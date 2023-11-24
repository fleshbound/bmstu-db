-- Инструкция SELECT, использующая простое выражение CASE.
--
select c.name as company_name,
       m.mailing_service_id as service_id,
       case m.period_days
           when 0 then 'no period'
           when 1 then 'every day'
           when 7 then 'every week'
           when 14 then 'every two weeks'
           when 30 then 'every month'
           when 31 then 'every month'
           else 'every ' || cast(m.period_days as varchar(3)) || ' days'
       end as period_str
from companies c join mailings m on c.id = m.company_id;
