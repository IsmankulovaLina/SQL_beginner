(SELECT pz.name AS pizzeria_name
FROM person_order po JOIN person p ON po.person_id = p.id AND gender = 'female'
JOIN menu m ON m.id = po.menu_id
JOIN pizzeria pz ON m.pizzeria_id = pz.id
EXCEPT
SELECT pz.name AS pizzeria_name
FROM person_order po JOIN person p ON po.person_id = p.id AND gender = 'male'
JOIN menu m ON m.id = po.menu_id
JOIN pizzeria pz ON m.pizzeria_id = pz.id)
UNION
(SELECT pz.name AS pizzeria_name
FROM person_order po JOIN person p ON po.person_id = p.id AND gender = 'male'
JOIN menu m ON m.id = po.menu_id
JOIN pizzeria pz ON m.pizzeria_id = pz.id
EXCEPT
SELECT pz.name AS pizzeria_name
FROM person_order po JOIN person p ON po.person_id = p.id AND gender = 'female'
JOIN menu m ON m.id = po.menu_id
JOIN pizzeria pz ON m.pizzeria_id = pz.id)
ORDER BY 1;