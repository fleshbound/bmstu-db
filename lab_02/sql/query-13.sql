-- Инструкция SELECT, использующая вложенные подзапросы с уровнем вложенности 3.
-- Имя клиента с макс. количеством ценящих его клиентов и это количество

select 'By likes' as criteria,
       c.name as client_name,
       (select max(cnt)
        from (select count(*) as cnt
        from clients
        group by favourite_client_id) as c_likes) as criteria_value
from clients c join (select favourite_client_id as id
                     from clients c
                     group by favourite_client_id
                     having count(*) = (select max(cnt)
                                        from (select count(*) as cnt
                                              from clients
                                              group by favourite_client_id) as c_likes)) as fav_likes
                    on c.id = fav_likes.id;
