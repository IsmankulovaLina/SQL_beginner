SELECT order_date, CONCAT (name,' (age:', age,')') AS person_information
FROM person_order NATURAL JOIN (SELECT p.id as person_id, name, age from person p) AS p
ORDER BY 1, 2;