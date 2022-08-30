--05 Вывести таблицу с полями teacher_name, grade_one_ratio, grade_two_ratio, grade_three_ratio, grade_four_ratio, grade_five_ratio

SELECT (t.first_name || ' ' || t.last_name) full_name, ld_ext.grade_one_count,
       ld_ext.grade_two_count, ld_ext.grade_three_count,
       ld_ext.grade_four_count, ld_ext.grade_five_count
       FROM teachers t INNER JOIN
           (SELECT l.teacher_id, ROUND(SUM(DECODE(ld.grade, 1, 1)) / COUNT(*) * 100, 2) grade_one_count,
        ROUND(SUM(DECODE(ld.grade, 2, 1)) / COUNT(*) * 100, 2) grade_two_count,
        ROUND(SUM(DECODE(ld.grade, 3, 1)) / COUNT(*) * 100, 2) grade_three_count,
        ROUND(SUM(DECODE(ld.grade, 4, 1)) / COUNT(*) * 100, 2) grade_four_count,
        ROUND(SUM(DECODE(ld.grade, 5, 1)) / COUNT(*) * 100, 2) grade_five_count
            FROM (SELECT lesson_id, grade
                  FROM lessons_diary WHERE grade IS NOT NULL
                UNION ALL
                SELECT lesson_id, grade_extra grade
                FROM lessons_diary WHERE grade_extra IS NOT NULL) ld
    INNER JOIN lessons l ON ld.lesson_id = l.id
    GROUP BY l.teacher_id) ld_ext ON ld_ext.teacher_id = t.id;

