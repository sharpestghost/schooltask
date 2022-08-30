--14 Найти 3 самые легкие дисциплины (наивысшая средняя успеваемость учеников) за 2021 год, вывести в порядке убывания успеваемости

SELECT l.lesson_type, AVG(ld.grade)
FROM lessons l
INNER JOIN (
        SELECT lesson_id, grade
        FROM lessons_diary WHERE grade IS NOT NULL
        UNION ALL
        SELECT lesson_id, grade_extra grade
        FROM lessons_diary WHERE grade_extra IS NOT NULL) ld
ON ld.lesson_id = l.id
GROUP BY l.lesson_type
ORDER BY AVG(ld.grade) DESC FETCH FIRST 3 ROW ONLY;