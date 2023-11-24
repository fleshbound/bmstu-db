-- Инструкция SELECT, использующая предикат IN с вложенным подзапросом.
-- Cписок мессенджеров, с которыми работают клиенты младше 20 лет
select name as service_name, response_speed_ms as service_response_speed_ms, version as service_version
from mailingservices
where id in (select ms.mailing_service_id
             from mailingsubscriptions ms join clients c
                on ms.client_id = c.id
             where age <= 20)
      and is_messenger = true;