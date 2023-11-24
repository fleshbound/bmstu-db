-- Простая инструкция DELETE.
-- удалить рассылки с периодом, равным 365
delete from mailings
where period_days = 365;
