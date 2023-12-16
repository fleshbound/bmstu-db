-- • Рекурсивную хранимую процедуру или хранимую процедуру с рекурсивным ОТВ
drop table if exists LikeClientsResults;

create temp table LikeClientsResults (
     id integer,
     name varchar,
     favourite_client_id integer,
     level integer
);

create or replace procedure write_client_like_level(client_id integer, like_level integer)
as
$$
begin
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
    insert into LikeClientsResults(id, name, favourite_client_id, level)
    select id, name, favourite_client_id, level
    from client_like
    where client_like.level = $2;
end;
$$ language plpgsql;

call write_client_like_level(100, 5);

select *
from LikeClientsResults;