CREATE INDEX idx_person_order_multi ON person_order (person_id, menu_id, order_date);

set enable_seqscan =off;
EXPLAIN ANALYSE 
SELECT person_id, menu_id, order_date
FROM person_order
WHERE person_id = 1 AND menu_id = 2;