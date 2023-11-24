-- Инструкция SELECT, использующая рекурсивное обобщенное табличное выражение.
-- любимые клиенты 3 уровня начиная с клиента 727
with recursive client_like(id, name, favourite_client_id, level) as (
    -- корень
    select id, name, favourite_client_id, 0
    from clients
    where id = 100
    union all
    -- рекурсивный элемент
    select c.id, c.name, c.favourite_client_id, cl.level + 1
    from clients c join client_like cl
        on c.favourite_client_id = cl.id
)
select *
from client_like
where level = 3;