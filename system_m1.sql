
connect system/123456;
drop  user  c##M1 CASCADE;
drop ROLE c##role_user_guest1;
drop user C##GUEST1 CASCADE;

create user  c##M1 identified by a123;
grant Connect, Resource, CREATE DATABASE LINK,CREATE ROLE, UNLIMITED  TABLESPACE to C##M1;

connect c##m1/a123;
--- enter script in file MX.sql

connect system/123456;

CREATE ROLE c##role_user_guest1 NOT IDENTIFIED;

GRANT select,insert,update,delete  on c##M1.stock to c##role_user_guest1;
GRANT select,insert,update,delete  on c##M1.cd to c##role_user_guest1;
GRANT select,insert,update,delete  on c##M1.stock_detail to c##role_user_guest1;
GRANT select,insert,update,delete  on c##M1.import_cd to c##role_user_guest1;
GRANT select,insert,update,delete  on c##M1.import_cd_detail to c##role_user_guest1;
GRANT select,insert,update,delete  on c##M1.customer to c##role_user_guest1;
GRANT select,insert,update,delete  on c##M1.orders to c##role_user_guest1;
GRANT select,insert,update,delete  on c##M1.orders_details to c##role_user_guest1;

CREATE USER C##GUEST1 IDENTIFIED BY GUEST;
GRANT CONNECT TO C##GUEST1;

GRANT c##role_user_guest1  to C##GUEST1;