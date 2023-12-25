-- 1. Извлечь все данные в JSON
copy (select row_to_json(m) result from mailings as m)
to '/home/sheglar/bmstu/db/lab_05/sql/data_json/mailings.json';

copy (select row_to_json(ms) from mailingservices as ms)
to '/home/sheglar/bmstu/db/lab_05/sql/data_json/mailingservices.json';

copy (select row_to_json(co) from companies as co)
to '/home/sheglar/bmstu/db/lab_05/sql/data_json/companies.json';

copy (select row_to_json(cl) from clients as cl)
to '/home/sheglar/bmstu/db/lab_05/sql/data_json/clients.json';

copy (select row_to_json(msub) from mailingsubscriptions as msub)
to '/home/sheglar/bmstu/db/lab_05/sql/data_json/mailingsubscriptions.json';

-- 2. Выполнить загрузку и сохранение XML или JSON файла в таблицу.
drop table if exists clients_copy;
create table if not exists clients_copy (
    id int not null primary key,
    favourite_client_id int,
    email varchar(50),
    age int check(age >= 13 and age <= 100),
    sum_purchase_dollars double precision,
    foreign key (favourite_client_id) references clients(id) on delete cascade
);

drop table if exists clients_import;
create table if not exists clients_import(
    data_json json
);
copy clients_import from '/home/sheglar/bmstu/db/lab_05/sql/data_json/clients.json';
select * from clients_import;

select * from clients_import, json_populate_record(null::clients_copy, data_json);

select * from clients_import, json_populate_record(cast(null as clients_copy), data_json);

insert into clients_copy
select id, favourite_client_id, email, age, sum_purchase_dollars
from clients_import, json_populate_record(null::clients_copy, data_json);

select * from clients_copy;

-- 3. Создать таблицу, в которой будет атрибут(-ы) с типом XML или JSON, или
-- добавить атрибут с типом XML или JSON к уже существующей таблице
drop table if exists clientcompanylikes;
create temp table if not exists clientcompanylikes(
    data_json json
);
select * from clientcompanylikes;

insert into clientcompanylikes
select *
from json_object('{client_id, company_id, like_count}',
                 '{727, 272, 13}');
select * from clientcompanylikes;

-- 4. Выполнить...
-- 4.1. Извлечь json фрагмент из json документа
drop table if exists clientcompanylikes;
create table if not exists clientcompanylikes(
    data_json json
);
insert into clientcompanylikes(data_json) values
('{"client_id": 1, "company_id": 5, "like_count": 10, "last_action": {"type": "dislike", "time": "2022-10-31 09:00:00"}}'),
('{"client_id": 2, "company_id": 4, "like_count": 9, "last_action": {"type": "like", "time": "2022-10-31 19:00:00"}}'),
('{"client_id": 3, "company_id": 3, "like_count": 8, "last_action": {"type": "repost", "time": "2022-10-31 13:45:00"}}'),
('{"client_id": 4, "company_id": 2, "like_count": 7, "last_action": {"type": "like", "time": "2022-10-31 05:46:00"}}'),
('{"client_id": 5, "company_id": 1, "like_count": 6, "last_action": {"type": "dislike", "time": "2022-10-31 15:13:00"}}');
select * from clientcompanylikes;

select data_json->>'client_id' as client_id, data_json->>'last_action' as last_action
from clientcompanylikes;

-- 4.2. Извлечь значения конкретных узлов или атрибутов json документа
select data_json->>'client_id' as client_id,
       data_json->'last_action'->>'type' as last_action_type,
       (data_json->'last_action'->>'time')::time as last_action_time
from clientcompanylikes;

-- 4.3. Выполнить проверку существования узла или атрибута
create or replace function key_exists(info json, key varchar)
returns bool
as
$$
begin
    return (info->key) is not null;
end;
$$ language plpgsql;

select key_exists(clientcompanylikes.data_json, 'name')
from clientcompanylikes;

drop function if exists key_exists;

-- 4.4. Изменить json документ
update clientcompanylikes
set data_json = data_json || '{"dislikes": 1}'
where (data_json->>'client_id')::int = 5;

select * from clientcompanylikes;

-- 4.5. Разделить json документ на несколько строк по узлам
drop table if exists clientcompanylikes;
create table if not exists clientcompanylikes(
    data_json json
);
insert into clientcompanylikes(data_json) values
('[
    {"client_id": 1, "company_id": 5, "like_count": 10, "last_action": {"type": "dislike", "time": "2022-10-31 09:00:00"}},
    {"client_id": 2, "company_id": 4, "like_count": 9, "last_action": {"type": "like", "time": "2022-10-31 19:00:00"}},
    {"client_id": 3, "company_id": 3, "like_count": 8, "last_action": {"type": "repost", "time": "2022-10-31 13:45:00"}},
    {"client_id": 4, "company_id": 2, "like_count": 7, "last_action": {"type": "like", "time": "2022-10-31 05:46:00"}},
    {"client_id": 5, "company_id": 1, "like_count": 6, "last_action": {"type": "dislike", "time": "2022-10-31 15:13:00"}}
]');

select json_array_elements(data_json)
from clientcompanylikes;

-- защита
create or replace procedure get_client_json_data()
as
$$
begin
    copy (
        select row_to_json(clients.*)
        from clients
    ) to '/home/sheglar/bmstu/db/lab_05/sql/data/client_info.json';
end;
$$ language plpgsql;

drop procedure get_client_json_data(client_id int);

call get_client_json_data();