-- • Многооператорную табличную функцию
-- получить инфо о клиенте client_id
create or replace function get_client_info(client_id integer)
returns table(id integer, name varchar, email varchar, age integer, sum_purchase_dollars double precision)
as
$$
begin
    drop table if exists client_info;

    create table client_info(
        id integer,
        name varchar,
        email varchar,
        age integer,
        sum_purchase_dollars double precision
    );

    insert into client_info(id, name, email, age, sum_purchase_dollars)
    select c.id, c.name, c.email, c.age, c.sum_purchase_dollars
    from clients c
    where c.id = client_id;

    return query
    select *
    from client_info;
end;
$$ language plpgsql;

select *
from get_client_info(50);