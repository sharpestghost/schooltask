--09  Найти учителей, которые проводили 4 и более различных дисциплин за 1 день в прошлом месяце
SELECT t.* FROM teachers t
INNER JOIN
    (SELECT DISTINCT teacher_id
     FROM
         (SELECT l.teacher_id, COUNT(*), extract(day FROM l.dt) lesson_day,
                 l.lesson_type FROM lessons l
        WHERE extract(month FROM l.dt) + 1 + extract(year FROM l.dt) * 12 =
            extract(month FROM sysdate)  + extract(year FROM sysdate) * 12
        GROUP BY to_char(l.dt, 'yyyy-mm-dd'), l.teacher_id, l.lesson_type)
    GROUP BY teacher_id, lesson_day
    HAVING COUNT(*) >= 2) l2
ON l2.teacher_id = t.id;


