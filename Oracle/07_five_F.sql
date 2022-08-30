--07 Найти учеников, сумевших получить оценку "2" на пяти подряд занятиях и для каждого вывести одним полем список учителей, поставивших эту оценку, в порядке убывания их возраста
WITH f_grades_list AS
(SELECT student_id, lesson_id, rownumb
FROM (SELECT CASE WHEN (grade = 2 OR grade_extra = 2) THEN 1 END  is_f_grade,
                ROW_NUMBER() over (PARTITION BY student_id ORDER BY lesson_id) rownumb,
                student_id, lesson_id
        FROM lessons_diary)
WHERE is_f_grade IS NOT NULL)
SELECT * FROM students s
INNER JOIN
    (SELECT listagg(full_name, ', ') WITHIN GROUP
    (ORDER BY birthdate desc) teachers_list, student_id
    FROM (
        SELECT fgl.student_id, fgl.rownumb, t.birthdate,
             (t.first_name || ' ' || t.last_name) full_name
        FROM (SELECT fgl.student_id, fgl.rownumb
              FROM f_grades_list fgl
              WHERE (
                    SELECT COUNT(*)
                    FROM f_grades_list fgl1
                    WHERE fgl1.rownumb BETWEEN fgl.rownumb + 1 AND fgl.rownumb + 4
                    AND fgl1.student_id = fgl.student_id) = 4) fgl
        INNER JOIN f_grades_list fgl2 ON fgl2.student_id = fgl.student_id
        INNER JOIN lessons l ON l.id = fgl2.lesson_id
        INNER JOIN teachers t ON l.teacher_id = t.id
        WHERE fgl2.rownumb BETWEEN fgl.rownumb AND fgl.rownumb + 4
        ORDER BY t.birthdate DESC)
    GROUP BY student_id, rownumb) s_final
ON s_final.student_id = s.id;
