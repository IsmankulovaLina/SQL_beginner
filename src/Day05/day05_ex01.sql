set enable_seqscan =off;
EXPLAIN ANALYSE
SELECT m.pizza_name AS pizza_name, pz.name AS pizzeria_name
FROM menu m JOIN pizzeria pz ON m.pizzeria_id = pz.id;