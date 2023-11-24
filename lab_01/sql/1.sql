select c.id as client_id,
       c.name as client_name,
       m.id as service_id,
       c2.id as company_id,
       c2.name as company_name
from clients c join mailingsubscriptions ms
    on c.id = ms.client_id
    join mailingservices m
        on ms.mailing_service_id = m.id
    join mailings m2
        on m.id = m2.mailing_service_id
    join companies c2
        on m2.company_id = c2.id
where c2.id = 13
order by c2.id;