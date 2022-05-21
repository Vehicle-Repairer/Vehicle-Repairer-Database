create sequence parts_part_id_seq;
alter sequence parts_part_id_seq owner to root;
create sequence repairman_id_seq;
alter sequence repairman_id_seq owner to root;
create type sex as enum ('男', '女');
alter type sex owner to root;
create table customer
(
    customer_id    serial
        primary key,
    customer_name  varchar(20),
    customer_type  varchar(30),
    discount_rate  double precision,
    contact_person varchar(10),
    phone          varchar(20)
);
alter table customer
    owner to root;
create table parts
(
    part_id    integer default nextval('parts_part_id_seq'::regclass) not null
        primary key,
    part_name  varchar(30),
    part_price double precision
);

alter table parts
    owner to root;
create table repairman
(
    id              varchar(8)   not null
        constraint repairman_pk
            primary key,
    man_name        varchar(20),
    profession      varchar(10),
    hour_cost       numeric(10, 2),
    hashed_password varchar(255) not null,
    sex             sex,
    phone           varchar(11),
    birthday        varchar(10),
    address         varchar(255),
    email_address   varchar(255),
    created_time    timestamp default timezone('PRC'::text, now())
);
alter table repairman
    owner to root;
alter sequence repairman_id_seq owned by repairman.id;
create unique index repairman_id_uindex
    on repairman (id);
create table salesman
(
    id              varchar(8)                                     not null
        constraint salesman_pk
            primary key,
    man_name        varchar(20),
    hashed_password varchar(255)                                   not null,
    sex             sex,
    phone           varchar(11),
    birthday        varchar(10),
    address         varchar(255),
    email_address   varchar(255),
    created_time    timestamp default timezone('PRC'::text, now()) not null
);
alter table salesman
    owner to root;
create unique index salesman_id_uindex
    on salesman (id);
create table vehicle
(
    frame_number   varchar(17) not null
        primary key,
    license_number varchar(10) not null,
    customer_id    integer
        constraint vehicle_customer_customer_id_fk
            references customer,
    color          varchar(6),
    vehicle_model  varchar(20),
    vehicle_type   varchar(20)
);
alter table vehicle
    owner to root;
create unique index vehicle_license_number_uindex
    on vehicle (license_number);
create table attorney
(
    attorney_id     serial
        constraint attorney_pk
            primary key,
    customer_id     integer     not null
        references customer,
    frame_number    varchar(17) not null
        references vehicle,
    repair_type     varchar(10),
    repair_amount   varchar(10),
    range           integer,
    fuel_amount     varchar(10),
    salesman_id     varchar(8)
        references salesman,
    is_finished     boolean   default 0,
    detailed_fault  varchar(100),
    in_factory_time timestamp default timezone('PRC'::text, now()),
    final_price     numeric(10, 2),
    license_number  varchar(10),
    man_name        varchar(20)
);
alter table attorney
    owner to root;
create unique index attorney_attorney_id_uindex
    on attorney (attorney_id);
create table repair_item
(
    item_id    serial
        constraint repair_item_pk
            primary key,
    item_name  varchar(30) not null,
    need_time  integer,
    profession varchar(30)
);
alter table repair_item
    owner to root;
create unique index repair_item_item_id_uindex
    on repair_item (item_id);
create table assignment
(
    assignment_id serial
        constraint assignment_pk
            primary key,
    attorney_id   integer not null
        constraint assignment_attorney_attorney_id_fk
            references attorney,
    item_id       integer not null
        constraint assignment_repair_item_item_id_fk
            references repair_item,
    repair_man_id varchar(30)
        constraint assignment_repairman_id_fk
            references repairman,
    is_finished   boolean default 0
);
alter table assignment
    owner to root;
create unique index assignment_assignment_id_uindex
    on assignment (assignment_id);
create table part_consumption
(
    consumption_id serial
        constraint part_consumption_pk
            primary key,
    assignment_id  integer not null
        constraint part_consumption_assignment_assignment_id_fk
            references assignment,
    part_id        integer
        constraint part_consumption_parts_part_id_fk
            references parts,
    part_amount    integer
);
alter table part_consumption
    owner to root;
create unique index part_consumption_consumption_id_uindex
    on part_consumption (consumption_id);