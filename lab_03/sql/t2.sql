-- • Триггер INSTEAD OF
--     add check (age >= 13 and age <= 100);
create or replace function clients_age_safe_update()
returns trigger
as
$$
begin
    if new.age > 100 or new.age < 13 then
        raise notice 'update client: expected age from 13 to 100, got %', new.age;
    else
        raise notice 'update client: success';

        update clients
        set age = new.age
        where id = new.id;

        return new;
    end if;

    return old;
end;
$$ language plpgsql;

drop view clients_view;

create or replace view clients_view as
select *
from clients
where age < 20
order by id;

create trigger clients_age_update
    instead of update
    on clients_view
    for each row
    execute procedure clients_age_safe_update();

select *
from clients_view
where age = 13;

update clients_view
set age = 12
where age = 13;


