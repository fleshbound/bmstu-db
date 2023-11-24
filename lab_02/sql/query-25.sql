-- Оконные функции для устранения дублей
-- удаление дублей с информацией о среднем, максимальном и суммарном периодах для каждой расслыки по компании
select c.name,
       avg(m.period_days) over(partition by c.name order by c.name) as avg_period,
       sum(m.period_days) over(partition by c.name order by c.name) as sum_period,
       max(m.period_days) over(partition by c.name order by c.name) as max_period,
       row_number() over (partition by c.name) as row_num
into temp table notdoubles
from companies c left outer join mailings m
     on c.id = m.company_id
where m.mailing_service_id is not null and m.is_periodic = true;

select * from notdoubles;

delete from notdoubles
where row_num > 1;

select * from notdoubles;