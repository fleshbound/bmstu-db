-- Простая инструкция UPDATE.
update mailingservices
set response_speed_ms = response_speed_ms + 0.1
where name like '%Soap%';
