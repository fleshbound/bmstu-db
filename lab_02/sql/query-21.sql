-- Инструкция DELETE с вложенным коррелированным подзапросом в предложении WHERE.
-- Удаление информации о подписках у тех клиентов, кого считает любимым наименьшее
-- кол-во человек
delete from clients
where id in (select favourite_client_id as id
                    from clients c
                    group by favourite_client_id
                    having count(*) = (select min(cnt)
                                       from (select count(*) as cnt
                                             from clients
                                             group by favourite_client_id) as c_likes));