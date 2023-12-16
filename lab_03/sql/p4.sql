-- • Хранимую процедуру доступа к метаданным
create or replace procedure get_db_info(name_db varchar) as
$$
declare
    database_id integer;
    data_collade varchar;
begin
    select pg.oid, pg.datcollate
    from pg_database as pg
    where pg.datname like name_db
    into database_id, data_collade;

    raise notice 'db: name %, id %, collade %', name_db, database_id, data_collade;
end;
$$ language plpgsql;


call get_db_info('bmstu');