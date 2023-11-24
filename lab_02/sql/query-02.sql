-- Инструкция SELECT, использующая предикат BETWEEN
-- названия и доход компаний, создавших рассылку в сервисе, версия которого ранее 101, но позднее 49,
-- версия название сервиса

select c.name as company_name, c.revenue_dollars as company_revenue_dollars, ms.name as service_name, ms.version
from companies c join mailings m
    on c.id = m.company_id
    join mailingservices ms
        on m.mailing_service_id = ms.id
where ms.version between 50 and 100;