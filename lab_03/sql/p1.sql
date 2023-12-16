-- Четыре хранимых процедуры
-- • Хранимую процедуру без параметров или с параметрами
-- добавить значение к скорости отклика мессенджерей (или не мессенджерей)
create or replace procedure add_response_speed_ms(add_speed_ms double precision, messenger_flag bool)
as
$$
begin
    update mailingservices
    set response_speed_ms = response_speed_ms + $1
    where is_messenger = $2;
end;
$$ language plpgsql;

select response_speed_ms, is_messenger
from mailingservices
where is_messenger = true;

call add_response_speed_ms(0.05, true);

select response_speed_ms, is_messenger
from mailingservices
where is_messenger = true;