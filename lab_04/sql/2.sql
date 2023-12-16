-- Пользовательскую агрегатную функцию CLR
create or replace function avg_company_revenue(id_start integer, id_end integer)
returns double precision
as
$$
    comp = plpy.execute("select * from companies where id >=" + str(id_start) + " and id <= " + str(id_end) + ";")
    sum_ = 0
    for c in comp:
        sum_ += c["revenue_dollars"]
    return sum_ / len(c)
$$ language plpython3u;

select *
from avg_company_revenue(0, 1000);