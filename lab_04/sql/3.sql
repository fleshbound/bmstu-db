-- Определяемую пользователем табличную функцию CLR
create or replace function get_last_versions()
returns table(id integer, name varchar, last_version integer)
as
$$
    last_versions = plpy.execute("select name, max(version) as last \
                                  from mailingservices \
                                  group by name;")
    all_records = plpy.execute("select id, name, version as last_version \
                                  from mailingservices;")
    res = []
    for record in all_records:
        for last_v in last_versions:
            if last_v['name'] == record['name'] and last_v['last'] == record['last_version']:
                res.append(record)
    return res
$$ language plpython3u;

select *
from get_last_versions();

select ms.id, ms.name, ms.version
from mailingservices ms
where ms.version = (select max(version)
                    from mailingservices m
                    where m.name = ms.name
                    group by ms.name);