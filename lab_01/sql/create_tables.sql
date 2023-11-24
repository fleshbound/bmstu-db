create table if not exists Clients (
    id                      int,
    favourite_client_id     int,
    email                   text,
    name                    text,
    age                     int,
    sum_purchase_dollars    float
);

create table if not exists MailingServices (
    id                  int,
    is_messenger        bool,
    response_speed_ms   float,
    version             int,
    name                text
);

create table if not exists Companies (
    id              int,
    name            text,
    country         text,
    revenue_dollars  float,
    email           text
);

create table if not exists MailingSubscriptions (
    client_id           int,
    mailing_service_id  int,
    price_dollars       float,
    start_at            timestamp
);

create table if not exists Mailings (
    company_id          int,
    mailing_service_id  int,
    is_periodic         bool,
    period_days         float
);