SELECT p.name 
FROM person p JOIN person_order po ON p.id = po.person_id
	JOIN menu m ON po.menu_id = m.id
WHERE address IN ('Moscow', 'Samara') AND gender = 'male' AND pizza_name IN ('pepperoni pizza','mushroom pizza')
ORDER BY 1 DESC;