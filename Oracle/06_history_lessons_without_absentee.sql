--06 Найти все занятия истории, проведенные в классах с проекторами без прогульщиков
SELECT l.* FROM lessons l
    INNER JOIN classrooms cr ON l.classroom_id = cr.id
    INNER JOIN lesson_types lt ON l.lesson_type = lt.id
WHERE cr.has_projector = 1 AND lt.name = 'История' AND l.id IN
            (SELECT ld.lesson_id FROM lessons_diary ld
            GROUP BY ld.lesson_id
            HAVING SUM(ld.is_absent) = 0);