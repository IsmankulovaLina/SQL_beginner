SELECT name, SUM(count) AS total_count
FROM ((SELECT pz.name, COUNT(*), 'visit' AS action_type
FROM person_visits pv JOIN pizzeria pz ON pv.pizzeria_id = pz.id
GROUP BY pz.name)
UNION
(SELECT pz.name, COUNT(*), 'order' AS action_type
FROM person_order po JOIN menu m ON po.menu_id = m.id
JOIN pizzeria pz ON m.pizzeria_id = pz.id
GROUP BY pz.name))
GROUP BY name
ORDER BY total_count DESC, name ASC;