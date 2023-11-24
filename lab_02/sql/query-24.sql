-- Оконные функции. Использование конструкций MIN/MAX/AVG OVER()
-- среднее арифм., сумма и максимум периодов из рассылок для каждой компании
select c.id, c.name, c.revenue_dollars, m.mailing_service_id,
       m.period_days,
       avg(m.period_days) over(partition by c.name order by c.name) as avg_period,
       sum(m.period_days) over(partition by c.name order by c.name) as sum_period,
       max(m.period_days) over(partition by c.name order by c.name) as max_period
from companies c left outer join mailings m
    on c.id = m.company_id
where m.mailing_service_id is not null and m.is_periodic = true;
