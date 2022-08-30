-- 1.    Выбрать всех прогулявших занятия в июле 2022 года учеников
SELECT s.* FROM students s
INNER JOIN (SELECT DISTINCT ld.student_id
            FROM lessons l INNER JOIN lessons_diary ld on l.id = ld.lesson_id
            WHERE extract(month from l.dt) <= 7 AND extract(year from l.dt) <= 2022
            AND ld.is_absent = 1) ld ON ld.student_id = s.id;
