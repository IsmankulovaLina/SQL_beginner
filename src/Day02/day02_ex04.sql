SELECT m.pizza_name, pz.name AS pizzeria_name, m.price
FROM menu m INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
WHERE pizza_name IN ('mushroom pizza', 'pepperoni pizza')
ORDER BY 1,2