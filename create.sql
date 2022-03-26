create type sex as enum ('男', '女');
alter type sex owner to root;
create table if not exists customer
(
    cid            integer not null
        primary key,
    cname          varchar(20),
    rtype          varchar(30),
    rate           integer,
    contact_person varchar(10),
    phone          varchar(20)
);
alter table customer
    owner to root;
create table if not exists parts
(
    pid     integer not null
        primary key,
    pname   varchar(20),
    pprice  integer,
    pnumber integer
);
alter table parts
    owner to root;
create table if not exists repairman
(
    id              serial
        constraint repairman_pk
            primary key,
    man_name        varchar(20),
    profession      varchar(10),
    hour_cost       numeric(10, 2),
    hashed_password varchar(255) not null,
    sex             sex,
    phone           varchar(11),
    birthday        timestamp(0),
    address         varchar(255),
    email_address   varchar(255),
    account         varchar(255) not null,
    created_time    timestamp default timezone('PRC'::text, now())
);
alter table repairman
    owner to root;
create unique index if not exists repairman_id_uindex
    on repairman (id);
create unique index if not exists repairman_account_uindex
    on repairman (account collate cstore);
create table if not exists salesman
(
    id              serial
        constraint salesman_pk
            primary key,
    man_name        varchar(20),
    hashed_password varchar(255)                                   not null,
    sex             sex,
    phone           varchar(11),
    birthday        timestamp(0),
    address         varchar(255),
    email_address   varchar(255),
    account         varchar(255)                                   not null,
    created_time    timestamp default timezone('PRC'::text, now()) not null
);
alter table salesman
    owner to root;
create unique index if not exists salesman_id_uindex
    on salesman (id);
create unique index if not exists salesman_account_uindex
    on salesman (account collate cstore);
create table if not exists vehicle
(
    frame_number         varchar(17) not null
        primary key,
    license_plate_number varchar(7),
    cid                  integer
        references customer
            on update cascade on delete cascade,
    color                varchar(5),
    vtype                varchar(20),
    vehicle_type         varchar(20)
);
alter table vehicle
    owner to root;