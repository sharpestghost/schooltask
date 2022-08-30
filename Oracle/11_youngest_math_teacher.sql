--11. Найти самого молодого учителя преподававшего математику в школе, вывести фамилию, имя и количество лет на момент старта преподавания дисциплины
SELECT t2.last_name, t2.first_name, t2.age
FROM (SELECT t.last_name, t.first_name,
        floor(months_between(t.start_date, t.birthdate) / 12) age,
        to_date(t.start_date) - to_date(t.birthdate) AS daydiff
      FROM teachers t INNER JOIN lesson_types s ON t.speciality_id = s.id
      WHERE s.name = 'Математика'
      ORDER BY daydiff, birthdate) t2
FETCH FIRST 1 ROW ONLY;
