create sequence clients_id_seq owned by Clients.id;
alter table Clients
    add primary key (id),
    add foreign key (favourite_client_id) references clients(id) on delete cascade,
    alter column id set not null,
    alter column id set default nextval('clients_id_seq'),
    alter column email set not null,
    alter column email type varchar(50),
    alter column name set not null,
    alter column name type varchar(50),
    alter column age set not null,
    alter column sum_purchase_dollars set not null,
    add check (name != ''),
    add check (email != ''),
    add check (sum_purchase_dollars >= 0),
    add check (age >= 13 and age <= 100);

create sequence mailingservices_id_seq owned by MailingServices.id;
alter table MailingServices
    add primary key (id),
    alter column id set not null,
    alter column id set default nextval('mailingservices_id_seq'),
    alter column is_messenger set not null,
    alter column name set not null,
    alter column name type varchar(60),
    alter column version set not null,
    alter column response_speed_ms set not null,
    add check (response_speed_ms > 0),
    add check (name != ''),
    add check (version >= 0);

create sequence companies_id_seq owned by Companies.id;
alter table Companies
    add primary key (id),
    alter column id set not null,
    alter column id set default nextval('companies_id_seq'),
    alter column name set not null,
    alter column name type varchar(60),
    alter column country set not null,
    alter column country type varchar(60),
    alter column revenue_dollars set not null,
    alter column email set not null,
    alter column email type varchar(100),
    add check (name != ''),
    add check (email != ''),
    add check (revenue_dollars >= 0);

alter table MailingSubscriptions
    add foreign key (client_id) references clients(id) on delete cascade,
    add foreign key (mailing_service_id) references mailingservices(id) on delete cascade,
    alter column price_dollars set not null,
    alter column start_at set not null;

alter table Mailings
    add foreign key (company_id) references companies(id) on delete cascade,
    add foreign key (mailing_service_id) references mailingservices(id) on delete cascade,
    alter column is_periodic set not null,
    alter column period_days set not null,
    add check (period_days >= 0);
