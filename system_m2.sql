connect system/123456;
drop  user  c##M2 CASCADE;
drop ROLE c##role_user_guest2;
drop user C##GUEST2 CASCADE;



create user  c##M2 identified by a123;
grant Connect, Resource, CREATE DATABASE LINK,CREATE ROLE, UNLIMITED  TABLESPACE to C##M2;


connect c##m2/a123;
--- enter script in file MX.sql

connect system/123456;


CREATE ROLE c##role_user_guest2 NOT IDENTIFIED;

GRANT select,insert,update,delete  on c##M2.stock to c##role_user_guest2;
GRANT select,insert,update,delete  on c##M2.cd to c##role_user_guest2;
GRANT select,insert,update,delete  on c##M2.stock_detail to c##role_user_guest2;
GRANT select,insert,update,delete  on c##M2.import_cd to c##role_user_guest2;
GRANT select,insert,update,delete  on c##M2.import_cd_detail to c##role_user_guest2;
GRANT select,insert,update,delete  on c##M2.customer to c##role_user_guest2;
GRANT select,insert,update,delete  on c##M2.orders to c##role_user_guest2;
GRANT select,insert,update,delete  on c##M2.orders_details to c##role_user_guest2;

CREATE USER C##GUEST2 IDENTIFIED BY GUEST;
GRANT CONNECT TO C##GUEST2;

GRANT c##role_user_guest2  to C##GUEST2;