-- функция, на вход название, страна компании
-- выход: количество клиентов
create or replace function get_clients_count(name varchar, country varchar)
returns table(client_count bigint, company_name varchar, company_country varchar)
as
$$
begin
    return query
    select count(c.id) as client_count, comp.name as company_name, comp.country as company_country
    from clients c join public.mailingsubscriptions ms on c.id = ms.client_id
                   join mailingservices mserv on ms.mailing_service_id = mserv.id
                   join mailings on mserv.id = mailings.mailing_service_id
                   join companies comp on mailings.company_id = comp.id
    where comp.id in (select id
                      from companies co
                      where co.country = $2 and co.name = $1)
    group by comp.name, comp.country;
end;
$$ language plpgsql;

select * from get_clients_count('Miller, Davis and Garcia', 'Russian Federation');