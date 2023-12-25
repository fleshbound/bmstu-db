drop table if exists Employees cascade;
drop table if exists InOuts cascade;

create table Employees(
      id serial primary key,
      name varchar,
      birthday date,
      department varchar
);

create table InOuts(
    id serial primary key,
    emp_id int references Employees(id) on delete cascade,
    sysdate date,
    sysday varchar,
    systime time,
    type int
);

insert into Employees(name, birthday, department) values
('Пертров Петр Петрович', '12-11-1987', 'Бухгалтерия'),
('Пертров Иван Иванович', '05-11-1967', 'Бухгалтерия');

insert into InOuts(emp_id, sysdate, sysday, systime, type) values
(1, '19-12-2023', 'Вторник', '9:00', 1),
(1, '19-12-2023', 'Вторник', '9:20', 2),
(1, '19-12-2023', 'Вторник', '9:25', 1),
(2, '19-12-2023', 'Вторник', '9:05', 1);

-- Задание 1: скалярную функцию, возвращающую кол-во сотрудников,
-- которые выходили не более трех раз (значит, заходили не более 4-х)
create or replace function get_employees_three_exits()
returns bigint
as
$$
begin
    return query
    select count(*)
    from Employees em
    where em.id in (
            select IO.emp_id
            from employees e join InOuts IO on e.id = IO.emp_id
            where io.type = 1
            group by IO.emp_id
            having count(*) <= 4
    );
end;
$$ language plpgsql;
