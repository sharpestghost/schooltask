-- специализации учителей
create table specialities (
 id INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) primary key,
 name nvarchar2(50) not null
);

-- виды уроков (математика, литература, химия etc)
create table lesson_types (
 id INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) primary key,
--наименование урока
name nvarchar2(50) not null
);

-- связка специальностей учителей и видов уроков
create table speciality_lesson_types_map  (
speciality_id number not null,
lesson_type_id number not null,
FOREIGN KEY (speciality_id) REFERENCES specialities(id),
FOREIGN KEY (lesson_type_id) REFERENCES lesson_types(id)
);

-- учителя
create table teachers (
 id INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) primary key,
 --имя
 first_name   nvarchar2(25) not null,
--фамилия
 last_name    nvarchar2(50) not null,
--день рождения
 birthdate    date    not null,
--пол
 male         nvarchar2(1) not null check (male = 'M' or male = 'F'),
--дата, когда был нанят на работы
 start_date   date    not null,
--дата, когда был уволен с работы
 end_date     date,
--специализация
 speciality_id number  not null ,
FOREIGN KEY (speciality_id) REFERENCES lesson_types(id)
);

-- классные комнаты
create table classrooms (
 id INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) primary key,
--номер этажа
 floor                       number not null,
--номер класса
 num                         number not null,
--вместительность учеников
 capacity                    number,
--признак наличия в помещении проектора
 has_projector               number not null check(has_projector = 1 OR has_projector = 0),
--признак наличия в помещении интерактивной доски
 has_interactive_school_board number not null check(has_interactive_school_board = 1 OR  has_interactive_school_board = 0),
--признак недоступности помещения (ремонт, etc)
 is_temporary_closed         number not null check(is_temporary_closed = 1 OR is_temporary_closed = 0)

);
-- ученики

create table students (
    id  INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) primary key,
 --имя
 first_name   nvarchar2(25) not null,
 --фамилия
 last_name    nvarchar2(50) not null,
 --день рождения
 birthdate    date    not null,
 --пол
 male         nvarchar2(1) not null check(male = 'M' or male = 'F'),
 --дата, когда был зачислен в школу
 start_date   date    not null,
 --дата, когда был отчислен из школы (в т ч закончил школу)
 end_date     date
);

-- ученические классы
create table classes (
  id  INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) primary key,
 --буква класса: А/Б/В etc
 letter      nvarchar2(1) not null,
 --имя класса, выбранное по желанию учеников (напр, имена принято выбирать по названиям галактик: Андромеда, Млечный Путь, Скульптор etc)
 name        nvarchar2(50),
 --год, когда класс был сформирован из первоклашек
 start_year  date not null,
 --год окончания школы учениками класса
 end_year    date,
 --классный руководитель
 form_teacher number not null,
 --староста
 head_student number,
 --основная классная комната
 main_class  number,
 FOREIGN KEY (form_teacher) REFERENCES  teachers(id),
 FOREIGN KEY (head_student) REFERENCES students(id),
 FOREIGN KEY (main_class) REFERENCES classrooms(id)
);
-- связка классов и учеников
create table class_students_map (
 class_id INTEGER not null,
 student_id number not null,
 --дата зачисления в класс
 start_date date  not null,
 --дата отчисления из класса
 end_date  date,
 FOREIGN KEY (class_id) REFERENCES classes(id),
 FOREIGN KEY (student_id) REFERENCES students(id)
);

-- проведеные уроки
drop table lessons cascade constraints;
create table lessons (
 id INTEGER GENERATED ALWAYS AS IDENTITY (INCREMENT BY 1 START WITH 1 CACHE 10) primary key,
--дата проведения урока
 dt          date  not null,
--вид проводимого урока (математика, литература, химия etc)
 lesson_type number not null,
--учитель, проводивший урок
 teacher_id  number not null,
--класс, присутствующий на занятии
 class_id    number not null,
--классная комната, где проводился урок
 classroom_id number not null,
FOREIGN KEY (lesson_type) REFERENCES lesson_types(id),
FOREIGN KEY (teacher_id) REFERENCES teachers(id),
FOREIGN KEY (class_id) REFERENCES  classes(id),
FOREIGN KEY (classroom_id) REFERENCES classrooms(id)
);
drop table lessons_diary;
-- дневник успеваемости и посещения
create table lessons_diary (
 lesson_id  number not null,
 student_id number not null,
--признак отсутствия на уроке
 is_absent  number not null check(is_absent = 1 OR is_absent =  0),
--полученная на уроке оценка
 grade      number,
--полученная на уроке оценка (дополнительная)
 grade_extra number,
 FOREIGN KEY (lesson_id) REFERENCES lessons(id),
FOREIGN KEY (student_id) REFERENCES students(id)
);
