--10 Найти учеников, которые в 2021 году были переведены в другой класс и их средняя успеваемость (GPA) улучшилась
--query
INSERT INTO lessons_diary (lesson_id, student_id, is_absent, grade, grade_extra) VALUES (14,312,0,5,4);
WITH modified_ld AS
    (SELECT ld.student_id, l.class_id, ld.grade as grade
    FROM lessons_diary ld
        INNER JOIN lessons l on l.id = ld.lesson_id
    WHERE ld.grade IS NOT NULL
        AND extract(year FROM l.dt) = 2021
    UNION ALL
    SELECT ld.student_id, l.class_id, ld.grade_extra as grade
    FROM lessons_diary ld
        INNER JOIN lessons l on l.id = ld.lesson_id
    WHERE ld.grade_extra IS NOT NULL
        AND extract(year FROM l.dt) = 2021),
csm_grades AS
    (SELECT csm.*, mld_grouped.avg_grade
    FROM class_students_map csm
    INNER JOIN (
        SELECT mld.student_id, mld.class_id, AVG(mld.grade) avg_grade
        FROM modified_ld mld
        GROUP BY mld.student_id, mld.class_id) mld_grouped
    ON csm.class_id = mld_grouped.class_id AND csm.student_id = mld_grouped.student_id)
SELECT s.*
FROM students s
INNER JOIN (
    SELECT DISTINCT csmg1.student_id
    FROM csm_grades csmg1
    INNER JOIN csm_grades csmg2 ON csmg1.student_id = csmg2.student_id
    WHERE extract(year FROM csmg1.end_date) = 2021
        AND extract(year FROM csmg2.start_date) = 2021
        AND csmg2.avg_grade > csmg1.avg_grade) imp_students
ON imp_students.student_id = s.id;

--update query for test
UPDATE class_students_map SET end_date = TO_DATE('2021-04-20', 'YYYY-MM-DD') WHERE student_id = 312 ;
INSERT INTO class_students_map (class_id, student_id, start_date, end_date)
VALUES (12, 312, TO_DATE('2021-04-20', 'YYYY-MM-DD'), TO_DATE('2026-06-25', 'YYYY-MM-DD'));
