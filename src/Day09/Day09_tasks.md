Для задания этого дня используются синтаксисы SQL, DDL, DML

## Упражнение 00 — Аудит входящих вставок  
Мы хотим стать более сильными в работе с данными, и не хотим терять ни одного события изменения. Давайте реализуем функцию аудита для входящих изменений типа `INSERT`.  
Пожалуйста, создайте таблицу `person_audit` с той же структурой, что и таблица `person`, но с некоторыми дополнительными изменениями. Посмотрите на таблицу ниже с описаниями для каждого столбца.

| Column | Type | Description |
| ------ | ------ | ------ |
| created | timestamp with time zone | Время создания события. Значение по умолчанию — текущий таймстамп, NOT NULL |
| type_event | char(1) | Возможные значения: I (вставка), D (удаление), U (обновление). Значение по умолчанию — ‘I’. NOT NULL. Добавьте ограничение проверки `ch_type_event` с возможными значениями ‘I’, ‘U’ и ‘D’ |
| row_id | bigint | Копия `person.id`. NOT NULL |
| name | varchar | Копия `person.name` (без ограничений) |
| age | integer | Копия `person.age` (без ограничений) |
| gender | varchar | Копия `person.gender` (без ограничений) |
| address | varchar | Копия `person.address` (без ограничений) |

На самом деле, давайте создадим триггер-функцию базы данных с именем `fnc_trg_person_insert_audit`, которая должна обрабатывать DML-операцию `INSERT` и копировать новую строку в таблицу `person_audit`.

Подсказка: чтобы реализовать триггер PostgreSQL (подробности в документации PostgreSQL), нужно создать два объекта: функцию триггера и сам триггер.

Пожалуйста, определите триггер с именем `trg_person_insert_audit` со следующими опциями:
- триггер с опцией "FOR EACH ROW"  
- триггер "AFTER INSERT"  
- вызов функции `fnc_trg_person_insert_audit`

Когда вы завершите создание объектов триггера, выполните команду вставки в таблицу `person`:  
```sql
INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk');
```

---

## Упражнение 01 — Аудит входящих обновлений  
Давайте продолжим реализовывать наш паттерн аудита для таблицы `person`. Просто определите триггер `trg_person_update_audit` и соответствующую функцию-триггер `fnc_trg_person_update_audit`, чтобы обрабатывать все операции обновления (`UPDATE`) на таблице `person`. Мы должны сохранять старое состояние (`OLD`) всех атрибутов.

Когда будете готовы, выполните нижеуказанные команды обновления:

```sql
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
```

---

## Упражнение 02 — Аудит входящих удалений  
Наконец, нам нужно обработать команды удаления (`DELETE`) и сохранить старое состояние (`OLD`) всех атрибутов. Пожалуйста, создайте триггер `trg_person_delete_audit` и соответствующую функцию-триггер `fnc_trg_person_delete_audit`.  
Когда будете готовы, выполните следующую команду:

```sql
DELETE FROM person WHERE id = 10;
```

---

## Упражнение 03 — Общий аудит  
На самом деле, для таблицы `person` уже есть 3 триггера. Объединим всю нашу логику в один основной триггер под названием `trg_person_audit` и новую соответствующую функцию-триггер `fnc_trg_person_audit`.  
Иными словами, весь DML-трафик (`INSERT`, `UPDATE`, `DELETE`) должен обрабатываться одним блоком функции. Пожалуйста, явно определите отдельные блоки IF-ELSE для каждого события (`I`, `U`, `D`)!

Дополнительно выполните следующие шаги:
- удалите 3 старых триггера из таблицы `person`;
- удалите 3 старых функции-триггеры;
- выполните команду TRUNCATE (или DELETE) всех строк из таблицы `person_audit`.

Когда будете готовы, повторно выполните набор команд DML:

```sql
INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk');
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
DELETE FROM person WHERE id = 10;
```

---

## Упражнение 04 — Представление VS Функция базы данных  
Как вы помните, мы создали два представления базы данных для разделения данных таблицы `person` по признаку пола.  
Пожалуйста, определите два SQL-функции (обратите внимание — не pl/pgsql), с именами:
- `fnc_persons_female` (должна возвращать женщин),
- `fnc_persons_male` (должна возвращать мужчин).

Чтобы проверить себя и вызвать функцию, можно выполнить такие запросы (Удивительно! Вы можете работать с функцией как с виртуальной таблицей!):

```sql
SELECT *
FROM fnc_persons_male();

SELECT *
FROM fnc_persons_female();
```

---

## Упражнение 05 — Параметризованная функция базы данных  
Похоже, что две функции из упражнения 04 требуют более универсального подхода. Пожалуйста, удалите эти функции из базы данных перед продолжением.  
Напишите универсальную SQL-функцию (обратите внимание — не pl/pgsql), с именем `fnc_persons`. Эта функция должна иметь входной параметр pgender со значением по умолчанию `'female'`.

Чтобы проверить себя и вызвать функцию:

```sql
select *
from fnc_persons(pgender := 'male');

select *
from fnc_persons();
```

---

## Упражнение 06 — Функция как обертка-функция  
Теперь посмотрим на функции pl/pgsql.

Пожалуйста, создайте функцию pl/pgsql под названием `fnc_person_visits_and_eats_on_date`, основанную на SQL-запросе для поиска названий пиццерий, которые посетил человек (`IN` параметр pperson со значением по умолчанию `'Dmitriy'`) и где он мог купить пиццу дешевле указанной суммы в рублях (`IN` параметр pprice со значением по умолчанию 500) на указанную дату (`IN` параметр pdate со значением по умолчанию `'2022-01-08'`).

Для проверки вызова функции используйте такие примеры:

```sql
select *
from fnc_person_visits_and_eats_on_date(pprice := 800);

select *
from fnc_person_visits_and_eats_on_date(pperson := 'Anna', pprice := 1300,pdate := '2022-01-01');
```

---

## Упражнение 07 — Различное представление для поиска минимума  
Пожалуйста, напишите SQL или pl/pgsql функцию под названием `func_minimum`, которая имеет входной параметр — массив чисел и возвращает минимальное значение.

Для проверки вызова функции используйте:

```sql
SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);
```

---

## Упражнение 08 — Алгоритм Фибоначчи в функции  
Напишите SQL или pl/pgsql функцию под названием `fnc_fibonacci`, которая имеет входной параметр pstop типа integer (по умолчанию равен 10), а возвращаемое значение — таблица всех чисел Фибоначчи меньше чем pstop.

Для проверки вызова функции используйте:

```sql
select * from fnc_fibonacci(100);
select * from fnc_fibonacci();
```
