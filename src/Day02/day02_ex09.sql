SELECT name
FROM person p JOIN person_order po ON p.id = po.person_id
JOIN menu m ON po.menu_id = m.id 
WHERE pizza_name = 'pepperoni pizza' AND gender = 'female'
INTERSECT
SELECT name
FROM person p JOIN person_order po ON p.id = po.person_id
JOIN menu m ON po.menu_id = m.id 
WHERE pizza_name = 'cheese pizza' AND gender = 'female'
ORDER BY 1;