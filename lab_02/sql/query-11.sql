-- Создание новой временной локальной таблицы из результирующего набора данных инструкции SELECT.
-- информация о мессенджерах: название, последняя версия, средний отклик, минимальный отклик, версия с мин. откликом
drop table messengers;

select m.name as messenger_name,
       max(m.version) as latest_version,
       avg(m.response_speed_ms) as avg_version_speed_ms,
       min(m.response_speed_ms) as best_speed_ms,
       (select m1.version
        from mailingservices m1
        where m1.name = m.name and m1.version = (select min(m2.version)
                                                 from mailingservices m2
                                                 where m2.name = m.name
                                                 group by m2.name)
        ) as best_speed_version
into temp table messengers
from mailingservices m
where m.is_messenger = true
group by m.name;

select * from messengers;
