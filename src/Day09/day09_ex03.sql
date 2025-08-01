CREATE OR REPLACE FUNCTION fnc_trg_person_audit()
RETURNS trigger AS 
$person_audit$
BEGIN
	IF (TG_OP = 'INSERT') THEN
		INSERT INTO person_audit (created, type_event, row_id, name, age, gender, address) 
		VALUES (current_timestamp, 'I', NEW.id, NEW.name, NEW.age, NEW.gender, NEW.address);
	ELSEIF (TG_OP = 'UPDATE') THEN
		INSERT INTO person_audit (created, type_event, row_id, name, age, gender, address) 
		VALUES (current_timestamp, 'U', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
	ELSEIF (TG_OP = 'DELETE') THEN
		INSERT INTO person_audit (created, type_event, row_id, name, age, gender, address) 
		VALUES (current_timestamp, 'D', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
	END IF;
	RETURN NULL;
END;
$person_audit$ 
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_person_audit
AFTER INSERT OR UPDATE OR DELETE ON person
   FOR EACH ROW EXECUTE FUNCTION fnc_trg_person_audit();

DROP TRIGGER trg_person_delete_audit ON person;
DROP FUNCTION fnc_trg_person_delete_audit();
DROP TRIGGER trg_person_insert_audit ON person;
DROP FUNCTION fnc_trg_person_insert_audit();
DROP TRIGGER trg_person_update_audit ON person;
DROP FUNCTION fnc_trg_person_update_audit();

TRUNCATE person_audit;