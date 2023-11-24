-- Инструкция SELECT, использующая вложенные коррелированные подзапросы в качестве производных таблиц в предложении FROM
-- Клиенты с самой дорогой подпиской

select 'By subscription price' as criteria, c.name as client_name, mc.price_dollars as criteria_value
from clients c join (select * -- client_id as c_id, price_dollars as price
                     from mailingsubscriptions
                     where price_dollars = (select max(price_dollars)
                                            from mailingsubscriptions)) as mc
    on c.id = mc.client_id;