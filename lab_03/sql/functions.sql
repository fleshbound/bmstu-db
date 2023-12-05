-- Четыре функции
-- • Скалярную функцию
create or replace function public.msgrs_cnt()
returns int
as
$$
    begin
        return (select count(*) from mailingservices where is_messenger is true);
    end;
$$ language plpgsql;

select public.msgrs_cnt();

-- • Подставляемую табличную функцию
create table messengers (messenger_id int,
                         messenger_name varchar(60),
                         company_revenue_dollars double precision);

create or replace function public.messenger_revenue_between(min_d double precision, max_d double precision)
    returns setof messengers
as
$$
begin
    select ms.id, ms.name, c.revenue_dollars
    from mailingservices ms join public.mailings m on ms.id = m.mailing_service_id
        join public.companies c on c.id = m.company_id
    where is_messenger = true and c.revenue_dollars between $1 and $2;
end;
$$ language plpgsql;

select * from messenger_revenue_between(10000, 90000) as t1;
-- • Многооператорную табличную функцию


-- • Рекурсивную функцию или функцию с рекурсивным ОТВ