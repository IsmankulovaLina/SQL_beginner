## Exercise 00 — Простая транзакция
Пожалуйста, используйте командную строку для базы данных PostgreSQL (psql) для этого задания. Вам нужно проверить, как ваши изменения будут опубликованы в базе данных для других пользователей базы данных.  
На самом деле, нам нужны две активные сессии (т.е. 2 параллельные сессии в командной строке).  
Пожалуйста, предоставьте доказательство того, что ваша параллельная сессия не может увидеть ваши изменения до тех пор, пока вы не выполните `COMMIT`;

Смотрите шаги ниже.

**Session #1**  
- Обновление рейтинга для "Pizza Hut" до 5 баллов в режиме транзакции.  
- Проверьте, что вы можете видеть изменения в сессии #1.

**Session #2**  
- Проверьте, что вы не можете видеть изменения в сессии #2.

**Session #1**  
- Опубликуйте ваши изменения для всех параллельных сессий.

**Session #2**  
- Проверьте, что вы можете видеть изменения в сессии #2.


Итак, посмотрите пример нашего вывода для Session #2.

```sql
pizza_db=> select * from pizzeria where name  = 'Pizza Hut';
 id |   name    | rating
----+-----------+--------
 1 | Pizza Hut |    4.6
(1 row)

pizza_db=> select * from pizzeria where name  = 'Pizza Hut';
 id |   name    | rating
----+-----------+--------
 1 | Pizza Hut |      5
(1 row)
```

Вы можете видеть, что один и тот же запрос возвращает разные результаты, потому что первый запрос был выполнен до публикации в Session#1, а второй — после завершения Session#1.

## Exercise 01 — Аномалия потерянного обновления
Пожалуйста, используйте командную строку для базы данных PostgreSQL (psql) для этого задания. Вам нужно проверить, как ваши изменения будут опубликованы в базе данных для других пользователей базы данных.  
На самом деле, нам нужны две активные сессии (т.е. 2 параллельные сессии в командной строке).  
Перед запуском задания убедитесь, что у вас установлен стандартный уровень изоляции в базе данных. Просто выполните следующую команду: `SHOW TRANSACTION ISOLATION LEVEL;` и результат должен быть "read committed".  
Если нет — установите явно уровень изоляции read committed на уровне сессии.

Проверьте рейтинг для "Pizza Hut" в режиме транзакции для обеих сессий и затем выполните `UPDATE` рейтинга на значение 4 в Session #1 и `UPDATE` рейтинга на значение 3.6 в Session #2.

## Exercise 02 — Аномалия потерянного обновления при повторяемом чтении
Пожалуйста, используйте командную строку для базы данных PostgreSQL (psql) для этого задания. Вам нужно проверить, как ваши изменения будут опубликованы в базе данных для других пользователей базы данных.  
На самом деле, нам нужны две активные сессии (т.е. 2 параллельные сессии в командной строке).

Проверьте рейтинг для "Pizza Hut" в режиме транзакции для обеих сессий и затем выполните `UPDATE` рейтинга на значение 4 в Session #1 и `UPDATE` рейтинга на значение 3.6 в Session #2.

## Exercise 03 — Аномалия неповторяющихся чтений
Пожалуйста, используйте командную строку для базы данных PostgreSQL (psql) для этого задания. Вам нужно проверить, как ваши изменения будут опубликованы в базе данных для других пользователей базы данных.  
На самом деле, нам нужны две активные сессии (т.е. 2 параллельные сессии в командной строке).

Проверьте рейтинг для "Pizza Hut" в режиме транзакции для Session #1 и затем выполните `UPDATE` рейтинга на значение 3.6 в Session #2.

## Exercise 04 — Аномалия неповторяющихся чтений при сериализации
Пожалуйста, используйте командную строку для базы данных PostgreSQL (psql) для этого задания. Вам нужно проверить, как ваши изменения будут опубликованы в базе данных для других пользователей базы данных.  
На самом деле, нам нужны две активные сессии (т.е. 2 параллельные сессии в командной строке).

Проверьте рейтинг для "Pizza Hut" в режиме транзакции для Session #1 и затем выполните `UPDATE` рейтинга на значение 3.0 во второй сессии (#2).

## Exercise 05 — Аномалия фантомных чтений
Пожалуйста, используйте командную строку для базы данных PostgreSQL (psql) для этого задания. Вам нужно проверить, как ваши изменения будут опубликованы в базе данных для других пользователей базы данных.  
На самом деле, нам нужны две активные сессии (т.е. 2 параллельные сессии).

Объедините все рейтинги всех пиццерий одним режимом транзакции в Session #1 и затем выполните `INSERT` новой пиццерии 'Kazan Pizza' со рейтингом 5 и ID=10 во второй сессии (#2).

## Exercise 06 — Фантомные чтения при повторяемом чтении
Пожалуйста, используйте командную строку для базы данных PostgreSQL (psql) для этого задания. Вам нужно проверить, как ваши изменения будут опубликованы в базе данных для других пользователей базы данных.
На самом деле, нам нужны две активные сессии (т.е. 2 параллельные сессии).

Объедините все рейтинги всех пиццерий одним режимом транзакции в Session #1 и затем выполните `INSERT` новой пиццерии 'Kazan Pizza 2' со рейтингом 4 и ID=11 во второй сессии (#2).

## Exercise 07 — Взаимная блокировка
Пожалуйста, используйте командную строку для базы данных PostgreSQL (psql) для этого задания. Вам нужно проверить, как ваши изменения будут опубликованы в базе данных другим пользователям.
На самом деле, нам нужны две активные сессии (т.е. 2 параллельных сеанса).

Давайте воспроизведем ситуацию взаимной блокировки в нашей базе.
Напишите любой SQL-запрос с любым уровнем изоляции (можно использовать настройку по умолчанию) на таблице `pizzeria`, чтобы воспроизвести эту ситуацию взаимной блокировки.
