create table if not exists info(
    name    text,
    cnt     int
);

create or replace function public.table_cnt(schema_n text)
returns void
as
$$
    declare row_data record;
    declare sql_str text;
    declare table_cnt int;
    begin
        for row_data in select table_schema||'.'||table_name as name
            from information_schema.tables
            where table_schema = schema_n
        loop
            sql_str := 'select count(*) from '||row_data.name;
            execute sql_str
            into table_cnt;
            execute 'insert into public.info values ('''||row_data.name||''', '||CAST(table_cnt as text)||')';
        end loop;
    end;
$$ language plpgsql;

select public.table_cnt('bmstu');
