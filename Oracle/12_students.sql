--12 Вывести учеников за первое полугодие 2021 года, у которых средний бал (GPA) по оценкам меньше среднего бала их класса, в формате фамилия, имя ученика, номер и буква класса

WITH modified_ld AS
    (SELECT ld.student_id, l.class_id, ld.grade as grade
     FROM lessons_diary ld INNER JOIN lessons l on l.id = ld.lesson_id
     WHERE ld.grade IS NOT NULL AND l.dt >= to_date('2021-01-01', 'YYYY-MM-DD')
        AND l.dt <= to_date('2021-06-30', 'YYYY-MM-DD')
    UNION ALL
    SELECT ld.student_id, l.class_id, ld.grade_extra as grade
    FROM lessons_diary ld INNER JOIN lessons l on l.id = ld.lesson_id
    WHERE ld.grade_extra IS NOT NULL AND l.dt >= to_date('2021-01-01', 'YYYY-MM-DD')
      AND l.dt <= to_date('2021-06-30', 'YYYY-MM-DD'))
SELECT s.first_name, s.last_name,
       ROUND(months_between(to_date('2021-01-01', 'YYYY-MM-DD'),
           c.start_year) / 12) class_number, c.letter
FROM students s
INNER JOIN
    (SELECT student_avg.student_id, student_avg.class_id
     FROM (SELECT student_id, class_id, AVG(grade) avg_grade
           FROM modified_ld
           GROUP BY student_id, class_id) student_avg
     INNER JOIN (SELECT class_id, AVG(grade) avg_grade
                 FROM modified_ld
                 GROUP BY class_id) class_avg
    ON class_avg.class_id = student_avg.class_id WHERE class_avg.avg_grade > student_avg.avg_grade) sl
ON sl.student_id = s.id INNER JOIN classes c ON sl.class_id = c.id;
