drop table if exists tmp;
create temp table if not exists tmp(email varchar);

create or replace function get_client_emails_like_str(str varchar)
returns setof varchar
as
$$
declare
    like_email varchar(50);
    email_cursor cursor for
        select email
        from Clients;
begin
    open email_cursor;
    loop
        fetch email_cursor into like_email;
        exit when not found;
        if like_email like '%' || $1 || '%'
        then
            insert into tmp(email) values (like_email);
            raise notice 'email: %', like_email;
        end if;
    end loop;
    close email_cursor;
    return query
    select *
    from tmp;
end;
$$ language plpgsql;

create or replace function get_client_emails_like_str_py(str varchar)
returns setof varchar
as
$$
    all_clients = plpy.execute(f" \
        select * \
        from clients \
    ")
    res = []
    for client in all_clients:
        if client['email'].find(f"{str}") > -1:
            res.append(client['email'])
    return res
$$ language plpython3u;

drop procedure get_client_emails_like_str(str varchar)

explain analyse
select * from get_client_emails_like_str('red');

explain analyse
select * from get_client_emails_like_str_py('red');