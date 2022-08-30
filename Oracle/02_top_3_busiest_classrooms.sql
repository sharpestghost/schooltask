--Вывести три наиболее загруженных уроками классных комнаты, кол-во занятий в каждой и % проведенных в них занятий из числа всех проведенных занятий
SELECT l.classroom_id AS room_number, COUNT(*) lessons_count,
       ROUND((COUNT(*) / (SELECT COUNT(*) FROM lessons) * 100), 2) lessons_percentage
FROM lessons l
GROUP BY l.classroom_id
ORDER BY COUNT(*) DESC
FETCH FIRST 3 ROWS ONLY;