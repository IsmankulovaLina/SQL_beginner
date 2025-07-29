WITH g AS 
	(SELECT g::date FROM generate_series ('2022-01-01', '2022-01-10', interval '1 day') AS g)

SELECT g::date as missing_date
FROM g 
	LEFT JOIN (SELECT * 
	FROM person_visits pv 
	WHERE person_id = 1 OR person_id = 2) AS pv 
	ON pv.visit_date = g
WHERE id IS NULL
ORDER BY 1;