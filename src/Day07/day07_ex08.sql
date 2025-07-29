SELECT address, pz.name, COUNT(*) AS count_of_orders
FROM person_order po JOIN menu m ON po.menu_id = m.id
JOIN pizzeria pz ON m.pizzeria_id = pz.id
JOIN person p ON po.person_id = p.id
GROUP BY address, pz.name
ORDER BY address, pz.name;