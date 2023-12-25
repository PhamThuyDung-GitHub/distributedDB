connect system/123456;
drop  user  c##admin CASCADE;
drop ROLE c##role_user_guest3;
drop user C##GUEST3 CASCADE;



create user  c##admin identified by a123;
grant Connect, Resource, CREATE DATABASE LINK,CREATE ROLE, UNLIMITED TABLESPACE to C##admin;

connect c##admin/a123;
--- enter script in file admin.sql

connect system/123456;

CREATE ROLE c##role_user_guest3 NOT IDENTIFIED;

GRANT Insert,select,update,delete ON c##admin.stock TO c##role_user_guest3;
GRANT Insert,select,update,delete on c##admin.cd to c##role_user_guest3;
GRANT Insert,select,update,delete on c##admin.customer to c##role_user_guest3;

CREATE USER C##GUEST3 IDENTIFIED BY GUEST;
GRANT CONNECT TO C##GUESt3;

GRANT c##role_user_guest3  to C##GUEST3;