-- Инструкция SELECT, консолидирующая данные с помощью предложения GROUP BY, но без предложения HAVING.
-- Для каждой компании, у которой есть рассылки: название, минимальный период рассылки, кол-во рассылок
select c.id, c.name,
       min(m.period_days) as min_meiling_period,
       count(m) as mailing_count
from companies c inner join mailings m
    on c.id = m.company_id
where m.is_periodic = true
group by c.name, c.id
order by c.name;