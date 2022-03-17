create type sex as enum ('男', '女');
alter type sex owner to root;
create table if not exists customer
(
    cid            integer not null,
    cname          varchar(20),
    rtype          varchar(30),
    rate           integer,
    contact_person varchar(10),
    phone          varchar(20),
    primary key (cid)
);
alter table customer
    owner to root;
create table if not exists parts
(
    pid     integer not null,
    pname   varchar(20),
    pprice  integer,
    pnumber integer,
    primary key (pid)
);
alter table parts
    owner to root;
create table repairman
(
    id              integer   default nextval('repairman_id_seq'::regclass) not null,
    man_name        varchar(20),
    profession      varchar(10),
    hour_cost       numeric(10, 2),
    hashed_password varchar(255)                                            not null,
    sex             varchar(1),
    phone           varchar(11),
    birthday        timestamp(0),
    address         varchar(255),
    email_address   varchar(255),
    account         varchar(255)                                            not null,
    created_time    timestamp default timezone('PRC'::text, now())
);
alter table repairman
    owner to root;
create unique index repairman_account_uindex
    on repairman (account collate cstore);
create table salesman
(
    id              serial,
    man_name        varchar(20),
    hashed_password varchar(255)                                   not null,
    sex             varchar(1),
    phone           varchar(11),
    birthday        timestamp(0),
    address         varchar(255),
    email_address   varchar(255),
    account         varchar(255)                                   not null,
    created_time    timestamp default timezone('PRC'::text, now()) not null
);
alter table salesman
    owner to root;
create unique index salesman_account_uindex
    on salesman (account collate cstore);
create table if not exists vehicle
(
    frame_number         varchar(17) not null,
    license_plate_number varchar(7),
    cid                  integer,
    color                varchar(5),
    vtype                varchar(20),
    vehicle_type         varchar(20),
    primary key (frame_number),
    foreign key (cid)
        references customer
        on update cascade on delete cascade
);
alter table vehicle
    owner to root;