-- Инструкция SELECT, консолидирующая данные с помощью предложения GROUP BY и предложения HAVING.
-- Сервисы, средний отклик которых в среднем по версиям меньше, чем среднее по всем версиям всех сервисов
select ms.name, avg(ms.response_speed_ms) as average_response_ms
from mailingservices ms
group by ms.name
having avg(ms.response_speed_ms) < (select avg(response_speed_ms)
                                    from mailingservices);