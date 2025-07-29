CREATE TABLE cities 
(point1 VARCHAR,
point2 VARCHAR,
cost NUMERIC);

INSERT INTO cities (point1, point2, cost) 
VALUES 
('a', 'b', 10), ('b', 'a', 10),
('a', 'c', 15), ('c', 'a', 15),
('a', 'd', 20), ('d', 'a', 20),
('b', 'c', 35), ('c', 'b', 35),
('b', 'd', 25), ('d', 'b', 25),
('c', 'd', 30), ('d', 'c', 30);

WITH RECURSIVE t (point1, depth, path, cycle) AS (
        SELECT point1, 1,
          ARRAY[c.point1],
          false
        FROM cities c
	  UNION
        SELECT c.point1,  depth + 1,
          path || c.point1,
          c.point1 = ANY(path)
        FROM cities c, t
        WHERE c.point1 != t.point1 AND NOT cycle AND depth < 5
),
t1 AS (SELECT 
	(SELECT cost FROM cities c WHERE c.point1 = path[1] AND c.point2 = path[2]) +
(SELECT cost FROM cities c WHERE c.point1 = path[2] AND c.point2 = path[3]) +
(SELECT cost FROM cities c WHERE c.point1 = path[3] AND c.point2 = path[4]) +
(SELECT cost FROM cities c WHERE c.point1 = path[4] AND c.point2 = 'a') AS total_cost,
	path || '{a}' as tour 
FROM t
WHERE NOT cycle AND depth = 4 LIMIT 6)

SELECT * 
FROM t1 
WHERE total_cost = (SELECT MIN(total_cost) from t1)
ORDER BY total_cost, tour;