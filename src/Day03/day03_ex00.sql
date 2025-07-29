SELECT pizza_name, price, pz.name AS pizzeria_name, visit_date
FROM person_visits pv JOIN person p ON pv.person_id = p.id
JOIN pizzeria pz ON pv.pizzeria_id = pz.id
JOIN menu m ON m.pizzeria_id = pv.pizzeria_id
WHERE p.name = 'Kate' AND price BETWEEN 800 AND 1000
ORDER BY 1,2,3;