SELECT g::date as missing_date
FROM (SELECT * 
	FROM person_visits pv 
	WHERE person_id = 1 OR person_id = 2) as pv 
	RIGHT JOIN generate_series ('2022-01-01', '2022-01-10', interval '1 day') AS g 
	ON pv.visit_date = g
WHERE id IS NULL
ORDER BY 1;
