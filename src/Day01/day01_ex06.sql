SELECT action_date, p.name AS person_name 
FROM (SELECT order_date AS action_date, person_id
FROM person_order
INTERSECT ALL
SELECT visit_date, person_id
FROM person_visits) AS t JOIN person p ON t.person_id = p.id
ORDER BY action_date, person_name DESC;