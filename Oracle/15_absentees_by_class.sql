--15. Вывести классы (номер, буква) и количество отсутствовавших учеников 1 марта 2021 года и общее количество отсутствовавших в школе за этот день (класс и букву оставить пустыми)

WITH student_id_list AS
    (SELECT ld.student_id FROM lessons_diary ld
    INNER JOIN (SELECT id FROM lessons
                WHERE dt = TO_DATE('2021-03-01','YYYY-MM-DD')) l ON l.id = ld.lesson_id
    GROUP BY ld.student_id
    HAVING SUM(ld.is_absent) = COUNT(ld.is_absent))
SELECT TO_CHAR(ROUND(months_between(TO_DATE('2021-03-01','YYYY-MM-DD'), c.start_year) / 12) + 1) class_number,
                       c.letter, COUNT(*) FROM classes c
INNER JOIN class_students_map csm ON c.id = csm.class_id
INNER JOIN student_id_list ON student_id_list.student_id = csm.student_id
WHERE csm.start_date < TO_DATE('2021-03-01','YYYY-MM-DD')
    AND csm.end_date > TO_DATE('2021-03-01','YYYY-MM-DD')
   OR csm.end_date IS NULL
GROUP BY c.letter, c.start_year
UNION ALL
SELECT ' ', translate(' ' using nchar_cs), COUNT(*)
FROM student_id_list;
