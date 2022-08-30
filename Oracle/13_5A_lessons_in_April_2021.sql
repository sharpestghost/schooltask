--13 Вывести число, день недели, количество уроков для 5А класса за апрель 2021 года

SELECT extract(day FROM l.dt), TO_CHAR(l.dt, 'Day'), COUNT(*)
FROM lessons l
INNER JOIN classes c ON c.id = l.class_id
WHERE extract(month FROM l.dt) = 4 AND extract(year FROM l.dt) = 2021
  AND c.letter IN ('A', 'А') AND ROUND(months_between(l.dt, c.start_year) / 12) + 1 = 5 --0y diff = 1st class, 1y diff = 2nd, etc.

GROUP BY extract(day FROM l.dt), TO_CHAR(l.dt, 'Day');
