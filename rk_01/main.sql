create database RK2;

drop table "Флорист","Букет","Покупатель","ФП";

create table if not exists "Флорист" (
    id serial primary key,
    "ФИО" varchar(100),
    "Номер паспорта" varchar(10),
    "Телефон" varchar(15)
);

create table if not exists "Букет" (
   id serial primary key,
   "Автор" int references "Флорист",
   "Название" varchar(50)
);

create table if not exists "Покупатель" (
    id serial primary key,
    "ФИО" varchar(100),
    "Дата рождения" date,
    "Город" varchar(30),
    "Телефон" varchar(15)
);

create table if not exists "ФП" (
    f_id int references "Флорист",
    p_id int references "Покупатель"
);

insert into "Флорист" ("ФИО", "Номер паспорта", "Телефон") values ('Klemens Behrendsen', '6925843654', '2-095-565-27-09');
insert into "Флорист" ("ФИО", "Номер паспорта", "Телефон") values ('Ruthie Buckerfield', '6823795913', '7-598-832-47-85');
insert into "Флорист" ("ФИО", "Номер паспорта", "Телефон") values ('Martin Van den Broek', '9360947042', '1-600-646-24-41');
insert into "Флорист" ("ФИО", "Номер паспорта", "Телефон") values ('Ludwig Burry', '0446751928', '0-407-277-78-79');
insert into "Флорист" ("ФИО", "Номер паспорта", "Телефон") values ('Oby Heading', '0422395000', '7-287-169-04-69');
insert into "Флорист" ("ФИО", "Номер паспорта", "Телефон") values ('Kissiah Fitch', '9943472469', '9-751-786-47-72');
insert into "Флорист" ("ФИО", "Номер паспорта", "Телефон") values ('Moss Niles', '3261720793', '0-440-989-08-66');
insert into "Флорист" ("ФИО", "Номер паспорта", "Телефон") values ('Becky Masdon', '4723993490', '4-504-874-36-49');
insert into "Флорист" ("ФИО", "Номер паспорта", "Телефон") values ('Toddy Murphey', '0505925545', '7-380-818-86-00');
insert into "Флорист" ("ФИО", "Номер паспорта", "Телефон") values ('Deeann Allender', '8885424280', '6-471-993-82-28');

insert into "Букет" ("Автор", "Название") values (3, 'Pamella');
insert into "Букет" ("Автор", "Название") values (3, 'Freddi');
insert into "Букет" ("Автор", "Название") values (6, 'Elisa');
insert into "Букет" ("Автор", "Название") values (2, 'Jackelyn');
insert into "Букет" ("Автор", "Название") values (10, 'Moyna');
insert into "Букет" ("Автор", "Название") values (2, 'Julianna');
insert into "Букет" ("Автор", "Название") values (10, 'Valli');
insert into "Букет" ("Автор", "Название") values (7, 'Lyndell');
insert into "Букет" ("Автор", "Название") values (9, 'Issy');
insert into "Букет" ("Автор", "Название") values (7, 'Jandy');

insert into "Покупатель" ("ФИО", "Дата рождения", "Город", "Телефон") values ('Marcelia Amaya', '2003-07-03', 'Velké Bílovice', '8-261-324-97-64');
insert into "Покупатель" ("ФИО", "Дата рождения", "Город", "Телефон") values ('Sofie Pottell', '2003-08-12', 'Jiangcun', '4-024-296-59-73');
insert into "Покупатель" ("ФИО", "Дата рождения", "Город", "Телефон") values ('Susan Yole', '2003-09-22', 'Chaguaní', '7-417-367-94-86');
insert into "Покупатель" ("ФИО", "Дата рождения", "Город", "Телефон") values ('Alexia Vidgeon', '2003-07-30', 'Ciechanowiec', '2-651-413-72-57');
insert into "Покупатель" ("ФИО", "Дата рождения", "Город", "Телефон") values ('Seth Riveles', '2003-06-21', 'Xingquan', '5-118-137-47-62');
insert into "Покупатель" ("ФИО", "Дата рождения", "Город", "Телефон") values ('Weber Dullard', '2003-04-21', 'Krynki', '4-520-109-46-92');
insert into "Покупатель" ("ФИО", "Дата рождения", "Город", "Телефон") values ('Blanche Gladbach', '2003-03-24', 'Fuquan', '0-849-718-64-90');
insert into "Покупатель" ("ФИО", "Дата рождения", "Город", "Телефон") values ('Ailbert Reburn', '2003-03-28', 'Uren’', '9-401-842-49-90');
insert into "Покупатель" ("ФИО", "Дата рождения", "Город", "Телефон") values ('Susann Nano', '2003-06-03', 'Pigeiros', '9-165-762-96-81');
insert into "Покупатель" ("ФИО", "Дата рождения", "Город", "Телефон") values ('Marla Antham', '2002-12-24', 'Ust’-Ilimsk', '8-514-357-92-82');

insert into "ФП" (f_id, p_id) values (7, 5);
insert into "ФП" (f_id, p_id) values (2, 4);
insert into "ФП" (f_id, p_id) values (8, 4);
insert into "ФП" (f_id, p_id) values (4, 4);
insert into "ФП" (f_id, p_id) values (5, 3);
insert into "ФП" (f_id, p_id) values (2, 6);
insert into "ФП" (f_id, p_id) values (10, 9);
insert into "ФП" (f_id, p_id) values (2, 9);
insert into "ФП" (f_id, p_id) values (6, 7);
insert into "ФП" (f_id, p_id) values (10, 5);

-- Задание №2
-- select с like.
-- Нахождение информации о букетах, название которых
-- начинается на букву J или заканчивается на букву a:
select *
from "Букет"
where "Название" like 'J%' or "Название" like '%a';

-- select с уровнем вложенности 3
-- Нахождение ID автора, имеющего больше всего покупателей
select 'По количеству покупателей' as "Критерий",
       id as "ID Флориста",
       (select max(cnt)
        from (select count(*) as cnt
              from "ФП"
              group by f_id) as f_cnt) as "Значение"
from "Флорист"
where id = (select f_id
            from "ФП"
            group by f_id
            having count(*) = (select max(cnt)
                               from (select count(*) as cnt
                                     from "ФП"
                                     group by f_id) as f_cnt));



-- многострочная insert
-- Вставка нового флориста с таким же именем, как у того, кто имеет больше всего покупателей,
-- но с другими номерами телефона и паспорта
insert into "Флорист" ("ФИО", "Номер паспорта", "Телефон")
select f."ФИО",
       '4518160570',
       '8-925-870-40-75'
from "Флорист" f join (select f_id
                        from "ФП"
                        group by f_id
                        having count(*) = (select max(cnt)
                        from (select count(*) as cnt
                        from "ФП"
                        group by f_id) as f_cnt)) as f_max_p
    on f.id = f_max_p.f_id;

-- Задание №3
create or replace function two_max_view()
returns text
as
$$
    declare table_data record;
    declare res_str text;
    begin
        -- селект названия по представлениям из всех представлений нашей базы
        -- группировка по таблицам
        -- расчет каунт(*)
        -- выбор верхних двух представлений
        -- Т_Т
        select viewname
        from information_schema.views
        group by table_name
        having count(*) = (select max(cnt)
                           from (select count(*) as cnt
                                 from -- текущий вид таблицы
                                 group by -- имя таблицы))
        order by count(*) desc
        limit 2;
    end;
$$ language plpgsql;