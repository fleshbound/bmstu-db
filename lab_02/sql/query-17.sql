-- Многострочная инструкция INSERT, выполняющая вставку в таблицу результирующего набора данных вложенного подзапроса.
insert into mailingservices (is_messenger, response_speed_ms, version, name)
select is_messenger,
       (select min(response_speed_ms) + 1.002
        from mailingservices),
       (select max(version)
        from mailingservices),
       'Test Carrot'
from mailingservices
where version = 100;