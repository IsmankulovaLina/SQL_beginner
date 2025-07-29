SELECT m.pizza_name, pz.name AS pizzeria_name
FROM person_order po 
JOIN person p ON po.person_id = p.id
JOIN menu m ON m.id = po.menu_id
JOIN pizzeria pz ON m.pizzeria_id = pz.id
WHERE p.name IN ('Denis','Anna')
ORDER BY 1, 2;

