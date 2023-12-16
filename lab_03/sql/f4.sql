-- • Рекурсивную функцию или функцию с рекурсивным ОТВ
-- любимые клиенты уровня like_level начиная с клиента client_id
create or replace function get_client_like_level(client_id integer, like_level integer)
returns table(id integer, name varchar, favourite_client_id integer, level integer)
as
$$
begin
    return query
    with recursive client_like(id, name, favourite_client_id, level) as (
        -- корень
        select clients.id, clients.name, clients.favourite_client_id, 0
        from clients
        where clients.id = $1
        union all
        -- рекурсивный элемент
        select c.id, c.name, c.favourite_client_id, cl.level + 1
        from clients c join client_like cl
            on c.favourite_client_id = cl.id
    )
    select *
    from client_like
    where client_like.level = $2;
end;
$$ language plpgsql;

select *
from get_client_like_level(100, 5);