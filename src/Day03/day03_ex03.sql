(SELECT pz.name AS pizzeria_name
FROM person_visits pv JOIN person p ON pv.person_id = p.id AND gender = 'female'
JOIN pizzeria pz ON pv.pizzeria_id = pz.id
EXCEPT ALL
SELECT pz.name AS pizzeria_name
FROM person_visits pv JOIN person p ON pv.person_id = p.id AND gender = 'male'
JOIN pizzeria pz ON pv.pizzeria_id = pz.id)
UNION ALL
(SELECT pz.name AS pizzeria_name
FROM person_visits pv JOIN person p ON pv.person_id = p.id AND gender = 'male'
JOIN pizzeria pz ON pv.pizzeria_id = pz.id
EXCEPT ALL
SELECT pz.name AS pizzeria_name
FROM person_visits pv JOIN person p ON pv.person_id = p.id AND gender = 'female'
JOIN pizzeria pz ON pv.pizzeria_id = pz.id)
ORDER BY 1;