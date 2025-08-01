CREATE VIEW v_price_with_discount AS
SELECT p.name, m.pizza_name, m.price, ROUND(price-price*0.1) AS discount_price
FROM person p 
JOIN person_order po ON p.id = po.person_id
JOIN menu m ON po.menu_id = m.id
ORDER BY p.name, pizza_name;