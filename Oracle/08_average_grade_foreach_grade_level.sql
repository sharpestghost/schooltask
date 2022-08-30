--08 Вывести буквы классов и средний бал (GPA) по оценкам, полученным учениками находящимися в этих классах, за 2021 год
SELECT c.letter, ROUND(AVG(ld.grade),2) GPA FROM (
SELECT lesson_id, grade FROM lessons_diary WHERE grade IS NOT NULL
UNION ALL
SELECT lesson_id, grade_extra grade FROM lessons_diary WHERE grade_extra IS NOT NULL) ld
    INNER JOIN lessons l ON ld.lesson_id = l.id INNER JOIN classes c ON l.class_id = c.id
    WHERE extract(year FROM l.dt) = 2021
GROUP BY c.letter;