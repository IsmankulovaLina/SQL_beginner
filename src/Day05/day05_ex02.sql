CREATE INDEX idx_person_name ON person(UPPER(name));

set enable_seqscan =off;
EXPLAIN ANALYSE 
SELECT *
FROM person 
WHERE UPPER(name) = 'Elvira';