-- Определяемую пользователем скалярную функцию CLR
create or replace function msgrs_cnt()
returns int
as
$$
    msgrs = plpy.execute("select * from mailingservices where is_messenger = true;")
    return len(msgrs)
$$ language plpython3u;

select *
from msgrs_cnt();