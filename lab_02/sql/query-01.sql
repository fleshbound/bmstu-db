-- Инструкция SELECT, использующая предикат сравнения.
-- Имена, возраст, название мессенджера, и размер подписки клиентов,
-- платящих за рассылку менее 1 доллара и которым менее 30 лет.

select distinct cl.name as client_name, cl.age as clinet_age, m.name as messenger_name, ms.price_dollars as sub_price_dollars
from clients cl join mailingsubscriptions ms
    on cl.id = ms.client_id
    join public.mailingservices m
        on ms.mailing_service_id = m.id
where ms.price_dollars < 1 and cl.age < 30;