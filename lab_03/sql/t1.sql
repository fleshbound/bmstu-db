-- Два DML триггера
-- • Триггер AFTER
-- вывод информации о вставке в таблицу клиента
create or replace function on_client_insert()
returns trigger
as
$$
begin
    raise notice 'insert client: name=% like_client=% email=% age=% sum=%',
        new.name,
        new.favourite_client_id,
        new.email,
        new.age,
        new.sum_purchase_dollars;
    return new;
end;
$$ language plpgsql;

create trigger client_info_after_insert
    after insert
    on clients
    for each row
    execute procedure on_client_insert();

insert into clients(favourite_client_id, email, name, age, sum_purchase_dollars)
values (262, 'test@gmail.com', 'nAve Maria', 69, 727.5);
