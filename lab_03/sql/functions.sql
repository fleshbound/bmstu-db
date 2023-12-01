-- Четыре функции
-- • Скалярную функцию
create or replace function public.msgrs_cnt()
returns int
as
$$
    begin
        return (select count(*) from mailingservices where is_messenger is true);
    end;
$$ language plpgsql;

select public.msgrs_cnt();

-- • Подставляемую табличную функцию


-- • Многооператорную табличную функцию
-- • Рекурсивную функцию или функцию с рекурсивным ОТВ