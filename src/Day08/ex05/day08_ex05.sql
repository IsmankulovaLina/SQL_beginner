-- Session #1
BEGIN ISOLATION LEVEL READ COMMITTED;
SELECT SUM(rating) FROM pizzeria;
SELECT SUM(rating) FROM pizzeria;
COMMIT;
SELECT SUM(rating) FROM pizzeria;

-- Session #2
BEGIN ISOLATION LEVEL READ COMMITTED;
INSERT INTO pizzeria (id, name, rating) VALUES (10, 'Kazan Pizza', 5);
COMMIT;
SELECT SUM(rating) FROM pizzeria;