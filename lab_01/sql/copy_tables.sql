copy clients(favourite_client_id, email, name, age, sum_purchase_dollars)
from '/var/lib/postgresql/bmstu/01/data/clients_info.csv'
delimiter ';'
header csv;

copy companies(name, country, revenue_dollars, email)
from '/var/lib/postgresql/bmstu/01/data/companies_info.csv'
delimiter ';'
header csv;

copy mailingservices(is_messenger, response_speed_ms, version, name)
from '/var/lib/postgresql/bmstu/01/data/mailingservices_info.csv'
delimiter ';'
header csv;

copy mailings(company_id, mailing_service_id, is_periodic, period_days)
from '/var/lib/postgresql/bmstu/01/data/mailings_info.csv'
delimiter ';'
header csv;

copy mailingsubscriptions(client_id, mailing_service_id, price_dollars, start_at)
from '/var/lib/postgresql/bmstu/01/data/mailingsubsriptions_info.csv'
delimiter ';'
header csv;