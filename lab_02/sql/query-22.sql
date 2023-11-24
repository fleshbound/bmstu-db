-- Инструкция SELECT, использующая простое обобщенное табличное выражение
-- средняя сумма подписок на рассылку каждого пользователя
with client_sum(client_id, sum_dollars) as (
    select client_id, sum(price_dollars)
    from mailingsubscriptions
    group by client_id
)
select avg(sum_dollars) as avg_sub_sum_dollars
from client_sum;