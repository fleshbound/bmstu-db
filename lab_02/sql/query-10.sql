-- Инструкция SELECT, использующая поисковое выражение CASE.
-- Компании с определенным по прибыли размеру бизнеса
select c.name,
       case
           when c.revenue_dollars < 200000 then 'Small'
           when c.revenue_dollars < 500000 then 'Mid'
           when c.revenue_dollars < 700000 then 'Big'
           else 'Giant'
       end as business_size
from companies c;
