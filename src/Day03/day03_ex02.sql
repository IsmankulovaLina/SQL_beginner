SELECT pizza_name, price, pz.name AS pizzeria_name
FROM menu m JOIN pizzeria pz ON m.pizzeria_id = pz.id
WHERE m.id = (SELECT m.id AS menu_id
FROM menu 
EXCEPT
SELECT menu_id 
FROM person_order)
ORDER BY 1,2;