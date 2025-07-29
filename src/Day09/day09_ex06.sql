CREATE FUNCTION fnc_person_visits_and_eats_on_date(pperson VARCHAR default 'Dmitriy', pprice numeric default 500, pdate date default '2022-01-08')
RETURNS TABLE (name varchar) AS $$
BEGIN
RETURN QUERY
	SELECT pz.name as pizzeria_name FROM pizzeria pz JOIN person_visits pv ON pz.id = pv.pizzeria_id
	JOIN person p ON pv.person_id = p.id
	JOIN menu m ON pz.id = m.pizzeria_id
	WHERE price < pprice AND p.name = pperson AND visit_date = pdate; 
END; 
$$ LANGUAGE PLPGSQL;