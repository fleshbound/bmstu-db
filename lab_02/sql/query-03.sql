-- Инструкция SELECT, использующая предикат LIKE.
-- Имена и почты всех клиентов старше 80 лет, подписанных на рассылку компаний
-- с LLC в названии (+ название компании, сервиса)
select c.name as client_name, c.email as client_email, cp.name as company_name, msvc.name as service_name
from clients c join mailingsubscriptions ms
    on c.id = ms.client_id
    join mailings ma
        on ma.mailing_service_id = ms.mailing_service_id
    join mailingservices msvc on
        ma.mailing_service_id = msvc.id
    join companies cp
        on ma.company_id = cp.id
where cp.name like '%LLC%' and c.age > 80;