-- 1. Определяемую пользователем скалярную функцию CLR
create or replace function msgrs_cnt()
returns int
as
$$
    msgrs = plpy.execute("select * from mailingservices where is_messenger = true;")
    return len(msgrs)
$$ language plpython3u;

select *
from msgrs_cnt();
drop function if exists msgrs_cnt();

-- 2. Пользовательскую агрегатную функцию CLR
create or replace function avg_company_revenue(id_start integer, id_end integer)
    returns double precision
as
$$
    comp = plpy.execute("select * from companies where id >=" + str(id_start) + " and id <= " + str(id_end) + ";")
    sum_ = 0
    for c in comp:
        sum_ += c["revenue_dollars"]
    return sum_ / len(c)
$$ language plpython3u;

select *
from avg_company_revenue(0, 1000);
drop function if exists avg_company_revenue();

-- 3. Определяемую пользователем табличную функцию CLR
create or replace function get_last_versions()
    returns table(id integer, name varchar, last_version integer)
as
$$
    last_versions = plpy.execute("select name, max(version) as last \
                                  from mailingservices \
                                  group by name;")
    all_records = plpy.execute("select id, name, version as last_version \
                                  from mailingservices;")
    res = []
    for record in all_records:
        for last_v in last_versions:
            if last_v['name'] == record['name'] and last_v['last'] == record['last_version']:
                res.append(record)
    return res
$$ language plpython3u;

select *
from get_last_versions();
drop function if exists get_last_versions();

-- 4. Хранимую процедуру CLR
create or replace procedure print_company_clients_info(company_name varchar)
as
$$
    company_clients = plpy.execute(f" \
        select cl.id as client_id, cl.name as client_name \
        from clients cl join mailingsubscriptions msub on cl.id = msub.client_id \
                join public.mailingservices m on msub.mailing_service_id = m.id \
                join public.mailings m2 on m.id = m2.mailing_service_id \
                join public.companies c on c.id = m2.company_id \
        where c.name like '%{company_name}%' \
    ")
    for record in company_clients:
        plpy.notice(record)
$$ language plpython3u;

call print_company_clients_info('Thompson Inc');
drop procedure if exists print_company_clients_info(company_name varchar);

-- 5. Триггер CLR
create or replace function check_client_age()
returns trigger
as
$$
    plpy.notice(TD["new"])
    if TD["new"]["age"] > 100:
        plpy.notice("error update: age must be less than or equal to 100")
        return "SKIP"
    if TD["new"]["age"] < 13:
        plpy.notice("error update: age must be greater than or equal to 13")
        return "SKIP"
    return "OK"
$$ language plpython3u;

create trigger clients_update
    before update
    on clients
    for each row
    execute procedure check_client_age();

update clients
set age = 99
where id = 1;

drop trigger if exists clients_update on clients;
drop function if exists check_client_age();

-- 6. Определяемый пользователем тип данных CLR
create type old_client as (
    id int,
    name varchar,
    age int
);

create or replace function get_old_clients()
returns setof old_client
as
$$
    old_clients = plpy.execute(f" \
            select id, name, age \
            from clients \
            where age > 65 \
        ")
    return old_clients
$$ language plpython3u;

select id, name, age
from get_old_clients();

drop function if exists get_old_clients();
drop type if exists old_client;