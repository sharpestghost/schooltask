SELECT * FROM students; --completed
SELECT * FROM specialities;
SELECT * FROM lesson_types;
SELECT * FROM classrooms;
--depend from lesson_types
SELECT * FROM teachers;
--depend from lesson_types / specialities
SELECT * FROM speciality_lesson_types_map; --completed
--depend from students, classrooms and teachers
SELECT * from classes; --completed
--depend from list of above + lesson_types
SELECT * FROM lessons;
--depend from classes and students
SELECT * FROM class_students_map; -- add constraint to enddate field
--depend from lessons and students
SELECT * FROM lessons_diary;