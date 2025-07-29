## Exercise 00 — Создадим индексы для каждого внешнего ключа
Пожалуйста, создайте простой индекс BTree для каждого внешнего ключа в нашей базе данных. Имя индекса должно соответствовать следующему правилу: `idx_{table_name}_{column_name}`. Например, имя индекса BTree для столбца `pizzeria_id` в таблице `menu` — это `idx_menu_pizzeria_id`.

## Exercise 01 — Как понять, что индекс работает?
Перед продолжением напишите SQL-запрос, который возвращает пиццы и соответствующие имена пиццерий. См. пример результата ниже (сортировка не требуется).

| pizza_name | pizzeria_name | 
| ------ | ------ |
| cheese pizza | Pizza Hut |
| ... | ... |

Давайте докажем, что ваши индексы работают для вашего SQL-запроса.
Пример доказательства — вывод команды `EXPLAIN ANALYZE`.  
Пожалуйста, ознакомьтесь с примером вывода команды.

    ...
    ->  Index Scan using idx_menu_pizzeria_id on menu m  (...)
    ...

**Подсказка**: Подумайте, почему ваши индексы не работают напрямую и что нужно сделать, чтобы активировать их?

## Exercise 02 — Формула находится в индексе. Всё в порядке?
Пожалуйста, создайте функциональный индекс B-Tree с именем `idx_person_name` по столбцу `name` таблицы `person`. Индекс должен содержать имена персон в верхнем регистре.  
Напишите любой SQL-запрос с доказательством (`EXPLAIN ANALYZE`), что индекс `idx_person_name` работает.

## Exercise 03 — Многоколонный индекс для наших целей
Пожалуйста, создайте более эффективный многоколонный индекс B-Tree с именем `idx_person_order_multi` для следующего SQL-запроса.

```sql
SELECT person_id, menu_id, order_date
FROM person_order
WHERE person_id = 8 AND menu_id = 19;
```

Команда `EXPLAIN ANALYZE` должна вернуть следующий шаблон. Обратите внимание на "Index Only Scan"!

    Index Only Scan using idx_person_order_multi on person_order ...

Предоставьте любой SQL-запрос с доказательством (`EXPLAIN ANALYZE`), что индекс `idx_person_order_multi` работает.

## Exercise 04 — Уникальность данных
Пожалуйста, создайте уникальный индекс B-Tree с именем `idx_menu_unique` по таблице `menu` для столбцов `pizzeria_id` и `pizza_name`.  
Напишите любой SQL-запрос с доказательством (`EXPLAIN ANALYZE`), что индекс `idx_menu_unique` работает.

## Exercise 05 — Частичная уникальность данных
Пожалуйста, создайте частично уникальный индекс B-Tree с именем `idx_person_order_order_date` по таблице `person_order`, включающий атрибуты `person_id` и `menu_id`, с частичной уникальностью по столбцу `order_date` для даты `'2022-01-01'`.

Команда `EXPLAIN ANALYZE` должна вернуть следующий шаблон:

    Index Only Scan using idx_person_order_order_date on person_order …

## Exercise 06 — Улучшаем производительность
Рассмотрите следующий SQL-запрос с технической точки зрения (игнорируйте логическую составляющую этого запроса):

```sql
SELECT
    m.pizza_name AS pizza_name,
    max(rating) OVER (PARTITION BY rating ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS k
FROM  menu m
INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
ORDER BY 1,2;
```

Создайте новый индекс B-Tree с именем `idx_1`, который должен улучшить метрику "Время выполнения" этого SQL-запроса.  
Предоставьте доказательства (`EXPLAIN ANALYZE`) того, что выполнение запроса было улучшено.

**Подсказка**: Это задание похоже на "грубую силу" поиска хорошего покрывающего индекса, поэтому перед новым тестом удалите индекс `idx_1`.

Образец моего улучшения:

**До**:

    Sort  (cost=26.08..26.13 rows=19 width=53) (actual time=0.247..0.254 rows=19 loops=1)
    "  Sort Key: m.pizza_name, (max(pz.rating) OVER (?))"
    Sort Method: quicksort  Memory: 26kB
    ->  WindowAgg  (cost=25.30..25.68 rows=19 width=53) (actual time=0.110..0.182 rows=19 loops=1)
            ->  Sort  (cost=25.30..25.35 rows=19 width=21) (actual time=0.088..0.096 rows=19 loops=1)
                Sort Key: pz.rating
                Sort Method: quicksort  Memory: 26kB
                ->  Merge Join  (cost=0.27..24.90 rows=19 width=21) (actual time=0.026..0.060 rows=19 loops=1)
                        Merge Cond: (m.pizzeria_id = pz.id)
                        ->  Index Only Scan using idx_menu_unique on menu m  (cost=0.14..12.42 rows=19 width=22) (actual time=0.013..0.029 rows=19 loops=1)
                            Heap Fetches: 19
                        ->  Index Scan using pizzeria_pkey on pizzeria pz  (cost=0.13..12.22 rows=6 width=15) (actual time=0.005..0.008 rows=6 loops=1)
    Planning Time: 0.711 ms
    Execution Time: 0.338 ms

**После**:

    Sort  (cost=26.28..26.33 rows=19 width=53) (actual time=0.144..0.148 rows=19 loops=1)
    "  Sort Key: m.pizza_name, (max(pz.rating) OVER (?))"
    Sort Method: quicksort  Memory: 26kB
    ->  WindowAgg  (cost=0.27..25.88 rows=19 width=53) (actual time=0.049..0.107 rows=19 loops=1)
            ->  Nested Loop  (cost=0.27..25.54 rows=19 width=21) (actual time=0.022..0.058 rows=19 loops=1)
                ->  Index Scan using idx_1 on …
                ->  Index Only Scan using idx_menu_unique on menu m  (cost=0.14..2.19 rows=3 width=22) (actual time=0.004..0.005 rows=3 loops=6)
    …
    Planning Time: 0.338 ms
    Execution Time: 0.203 ms

