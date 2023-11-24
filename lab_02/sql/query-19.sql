-- Инструкция UPDATE со скалярным подзапросом в предложении SET.
-- добавить сумме трат клиентов среднее значение трат менее 5 долларов клиентам с id до 11
update clients
set sum_purchase_dollars = sum_purchase_dollars + (select avg(price_dollars)
                                                   from mailingsubscriptions
                                                   where price_dollars < 5)
where id < 11;
