--04 Для каждого месяца вывести учителей, которые провели от пяти до десяти уроков в ныне закрытой для использования классной комнате

SELECT td.month ||  '/' || td.year AS yearmonth, t.*
FROM (SELECT l.teacher_id, extract(month FROM l.dt) AS month,
             extract(year FROM l.dt) AS year, COUNT(*) AS lessons_count
      FROM lessons l INNER JOIN classrooms cr ON l.classroom_id = cr.id
      WHERE cr.is_temporary_closed = 1
      GROUP BY l.teacher_id, extract(month FROM l.dt), extract(year FROM l.dt)) td
INNER JOIN teachers t ON t.id = td.teacher_id
WHERE td.lessons_count BETWEEN 6 AND 10;