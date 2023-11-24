-- Инструкция SELECT, использующая предикат сравнения с квантором.
-- Мессенджеры, цена рассылки в которых больше, чем средняя стоимость рассылки в каждом из сервисов с одинаковым
-- названием
select m.name as messenger_name, m.version as messenger_version, ms.price_dollars as mailing_price_dollars
from public.mailingsubscriptions ms join mailingservices as m
    on ms.mailing_service_id = m.id
where m.is_messenger = true and ms.price_dollars > all (select avg(ms1.price_dollars)
                                                        from mailingsubscriptions ms1 join mailingservices m1
                                                            on ms1.mailing_service_id = m1.id
                                                        group by m1.name)