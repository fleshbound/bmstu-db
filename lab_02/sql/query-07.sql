-- Инструкция SELECT, использующая агрегатные функции в выражениях столбцов.
-- Количество клиентов, подписавшихся на первую рассылку в июне 2023 года;
-- средняя стоимость их рассылок;
select count(client_id), avg(sum_mailing_price_dollars) as avg_mailing_price_dollars
from (
    select ms.client_id as client_id, sum(ms.price_dollars) as sum_mailing_price_dollars
    from clients c join mailingsubscriptions ms
       on c.id = ms.client_id
    group by ms.client_id
    having min(ms.start_at) between '2023-06-01 00:00:00' and '2023-06-30 23:59:59'
) as march2023_subs;
