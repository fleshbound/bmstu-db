-- Европейская компания, у которой больше всего клиентов с конкретной версией приложения
-- select max(cnt)
--         from (select count(*) as cnt
--         from clients
--         group by favourite_client_id) as c_likes
select c.name as company_name, (select max(cnt)
                from (select count(*) as cnt
                      from companies c join mailings m
                                            on c.id = m.company_id
                                       join mailingservices ms
                                            on m.mailing_service_id = ms.id
                                       join mailingsubscriptions msub
                                            on ms.id = msub.mailing_service_id
                                       join clients cl
                                            on cl.id = msub.client_id
                      where ms.version = 12
                      group by c.name) as cnt_clients) as max_clients_count
from companies c join mailings m
        on c.id = m.company_id
    join mailingservices ms
        on m.mailing_service_id = ms.id
    join mailingsubscriptions msub
        on ms.id = msub.mailing_service_id
    join clients cl
        on cl.id = msub.client_id
where ms.version = 12
group by c.name
having count(*) = (select max(cnt)
                   from (select count(*) as cnt
                         from companies c join mailings m
                                         on c.id = m.company_id
                                    join mailingservices ms
                                         on m.mailing_service_id = ms.id
                                    join mailingsubscriptions msub
                                         on ms.id = msub.mailing_service_id
                                    join clients cl
                                         on cl.id = msub.client_id
                         where ms.version = 12
                         group by c.name) as cnt_clients);
