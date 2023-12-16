-- • Подставляемую табличную функцию
-- мессенджеры, которые используются компаниями, доход которых заключен между МИН и МАКС

create or replace function public.messenger_revenue_between(min_d double precision, max_d double precision)
    returns table(messenger_id integer,
                  messenger_name varchar,
                  company_revenue_dollars double precision)
as
$$
begin
    return query
    select ms.id, ms.name, c.revenue_dollars
    from mailingservices ms join public.mailings m on ms.id = m.mailing_service_id
                            join public.companies c on c.id = m.company_id
    where is_messenger = true and c.revenue_dollars between $1 and $2;
end;
$$ language plpgsql;

select * from messenger_revenue_between(10000, 90000) as t1;
