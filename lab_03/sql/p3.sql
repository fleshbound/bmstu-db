-- • Хранимую процедуру с курсором
create or replace procedure get_client_emails_like_str(str varchar)
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
            raise notice 'email: %', like_email;
        end if;
    end loop;
    close email_cursor;
end;
$$ language plpgsql;

call get_client_emails_like_str('black')