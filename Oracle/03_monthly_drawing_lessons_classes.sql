--03

SELECT cr.*
FROM classrooms cr INNER JOIN
    (SELECT l_grouped.classroom_id
    FROM (SELECT classroom_id
          FROM lessons l INNER JOIN lesson_types lt on l.lesson_type = lt.id
          WHERE lt.name = 'Рисование'
          GROUP BY (extract(month from l.dt) + extract(year from l.dt) * 12), classroom_id) l_grouped
    GROUP BY l_grouped.classroom_id
    HAVING (SELECT COUNT(DISTINCT (extract(month from dt) + extract(year from dt) * 12))
            FROM lessons) = COUNT(*)) l2
ON cr.id = l2.classroom_id;
SELECT COUNT(DISTINCT (extract(month from dt) + extract(year from dt) * 12)) FROM lessons;