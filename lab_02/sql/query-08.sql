-- Инструкция SELECT, использующая скалярные подзапросы в выражениях столбцов.
-- клиент, имя его любимого клиента, среднее время отклика сервисов любимого клиента,
-- кол-во клиентов, считающих его сввоим любимым клиентом
select c.name as client_name,
       (select c1.name
        from clients c1
        where c1.id = c.favourite_client_id) as friend_name,
       (select avg(m.response_speed_ms)
        from mailingservices m join mailingsubscriptions ms
            on m.id = ms.mailing_service_id
        where ms.client_id = c.favourite_client_id) as friend_avg_service_responce_ms,
        (select count(*)
         from clients c1
         where c1.favourite_client_id = c.id
         group by c1.favourite_client_id) as being_friend_cnt
from clients c
order by being_friend_cnt desc;
