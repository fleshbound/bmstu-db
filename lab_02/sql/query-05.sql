-- Инструкция SELECT, использующая предикат EXISTS с вложенным подзапросом.
-- Список мессенджеров, в которых есть хотя бы одна рассылка дороже 9.8 долларов
select id as service_id, name as messenger_name, version as messenger_version
from mailingservices ms
where exists(select msub.price_dollars
             from mailingsubscriptions msub
             where msub.mailing_service_id = ms.id and msub.price_dollars > 9.8 and ms.is_messenger = true);