SELECT pz.name AS pizzeria_name
FROM pizzeria pz JOIN menu m ON pz.id = m.pizzeria_id
JOIN person_visits pv ON pv.pizzeria_id = pz.id
JOIN person p ON p.id = pv.person_id
WHERE p.name = 'Dmitriy' AND visit_date = '2022-01-08' AND price < 800;