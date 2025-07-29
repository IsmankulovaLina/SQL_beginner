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
ORDER BY total_cost, tour;