
create or replace procedure Insert_stock (n_stock_id in number,n_stock_name in varchar2,
 n_stock_city_id in number,  n_stock_capacity in number)
as 
begin 
    if(n_stock_id>=0 and n_stock_id<=10 ) then
        insert into C##M1.stock@DB_M1 (stock_id,stock_name,stock_city_id) values  (n_stock_id ,n_stock_name , n_stock_city_id  );
        insert into C##admin.stock@DB_admin values (n_stock_id,0,n_stock_capacity);
    ELSIF(n_stock_id >10 and n_stock_id<=20 ) then
         insert into C##M2.stock@DB_M2(stock_id,stock_name,stock_city_id) values  (n_stock_id ,n_stock_name , n_stock_city_id  );
        insert into C##admin.stock@DB_admin values(n_stock_id,0,n_stock_capacity);
    else 
        dbms_output.put_line('insert failed');
        dbms_output.put_line('Id_stock out of range');
        dbms_output.put_line('Id_stock in [0..20]');
    end if;
    commit;
end;
-- start test procedure Insert_stock
begin 
    --Insert_stock (n_stock_id,n_stock_name, n_stock_city_id,n_stock_capacity)
    Insert_stock(3,'stock 3',1,100);
end;

select * from c##m1.stock@DB_M1;
select * from  C##admin.stock@DB_admin;



begin 
    --Insert_stock (n_stock_id,n_stock_name, n_stock_city_id,n_stock_capacity)
    Insert_stock(13,'stock 13',1,100);
end;

select * from c##m2.stock@DB_M2; 
select * from  C##admin.stock@DB_admin;

set SERVEROUTPUT  on;

begin 
    --Insert_stock (n_stock_id,n_stock_name, n_stock_city_id,n_stock_capacity)
    Insert_stock(30,'stock error ',1,100);
end;

select * from c##m1.stock@DB_M1;
select * from c##m2.stock@DB_M2; 
select * from  C##admin.stock@DB_admin;

--- end test procedure Insert_stock


create or replace procedure Insert_Cd (n_cd_id in number, n_cd_title in varchar2, n_cd_price in number, n_cd_description in varchar2)
as 
begin 
    if(n_cd_id>=0 and n_cd_id<=50) then
        insert into C##M1.cd@DB_M1(cd_id, cd_title,cd_price) values  (n_cd_id, n_cd_title,n_cd_price);
        insert into C##admin.cd@DB_admin values (n_cd_id,n_cd_description);
    ELSIF(n_cd_id >50 and n_cd_id<=100) then
         insert into C##M2.cd@DB_M2(cd_id, cd_title,cd_price) values (n_cd_id, n_cd_title,n_cd_price);
        insert into C##admin.cd@DB_admin values (n_cd_id,n_cd_description);
    else 
        dbms_output.put_line('insert failed');
        dbms_output.put_line('Id_Cd out of range');
        dbms_output.put_line('Id_cd in [0..100]');
    end if;
    commit;
end;

-- start test procedure Insert_Cd

begin 
    --Insert_Cd (n_cd_id, n_cd_title, n_cd_price, n_cd_description)
    Insert_Cd(3,'cd 3',10000,'this is the cd 3');
end;

select * from C##m1.cd@DB_M1;
select * from C##admin.cd@DB_admin;

begin 
    --Insert_Cd (n_cd_id, n_cd_title, n_cd_price, n_cd_description)
    Insert_Cd(53,'cd 53',10000,'this is the cd 53');
end;

select * from C##m2.cd@DB_M2;
select * from C##admin.cd@DB_admin;

begin 
    --Insert_Cd (n_cd_id, n_cd_title, n_cd_price, n_cd_description)
    Insert_Cd(200,'cd 200',1000,'this is the cd 200');
end;
select * from C##m1.cd@DB_M1;
select * from C##m2.cd@DB_M2;
select * from C##admin.cd@DB_admin;

-- end test procedure Insert_Cd


create or replace procedure Create_import_cd(n_import_cd_id in number,n_stock_id in number)
as 
    dem int;
begin 
    select count(stock_id) into dem from C##M1.stock@DB_M1 where stock_id=n_stock_id ;
    if(dem>0) then 
        if(n_import_cd_id >0 and n_import_cd_id<=100) then
            insert into C##M1.import_cd@DB_M1 (import_cd_id ,stock_id ,brand_store_id) values (n_import_cd_id,n_stock_id,3);
        else
            dbms_output.put_line('insert failed');
            dbms_output.put_line('Import id in range [1..100].');
        end if;
    else 
        select count(stock_id) into dem from C##M2.stock@DB_M2  where stock_id=n_stock_id;
        if(dem>0) then 
            if(n_import_cd_id >100 and n_import_cd_id<=200) then
                insert into C##M2.import_cd@DB_M2 (import_cd_id ,stock_id ,brand_store_id) values (n_import_cd_id,n_stock_id,3);
            else
                dbms_output.put_line('insert failed');
                dbms_output.put_line('Import id in range [100..200].');
            end if;
        else 
            dbms_output.put_line('insert failed');
            dbms_output.put_line('Id stock not exsit');
        end if;
    end if;
    commit;
end;

-- start test procedure import_cd

begin
    --Create_import_cd(n_import_cd_id,n_stock_id )
    Create_import_cd(3,3);
end;

select * from C##M1.import_cd@DB_M1;

begin
    --Create_import_cd(n_import_cd_id,n_stock_id )
    Create_import_cd(103,13);
end;
select * from C##M2.import_cd@DB_M2;


begin
    --Create_import_cd(n_import_cd_id,n_stock_id )
    Create_import_cd(203,13);
end;

select * from C##M1.import_cd@DB_M1;
select * from C##M2.import_cd@DB_M2;
-- end test procedure import_cd

create or replace procedure insert_import_cd_detail(n_import_cd_id in number,n_cd_id in number,n_quatity in number)
as 
    dem int;
    curr_stock_available int;
    curr_stock_capacity int;
    curr_stock_id int;
begin 
    SAVEPOINT save_insert_import_cd_detail;
    select count(import_cd_id) into dem from C##M1.import_cd@DB_M1 where import_cd_id=n_import_cd_id;
    if(dem>0) then
                select stock_id into curr_stock_id from C##M1.import_cd@DB_M1 where import_cd_id=n_import_cd_id;
        insert into C##M1.import_cd_detail@DB_M1 (import_cd_id,cd_id,quatity) values (n_import_cd_id,n_cd_id,n_quatity);
    else
        select count(import_cd_id) into dem from C##M2.import_cd@DB_M2 where import_cd_id=n_import_cd_id;
        if(dem>0) then
            select stock_id into curr_stock_id from  C##M2.import_cd@DB_M2 where import_cd_id=n_import_cd_id;
            insert into C##M2.import_cd_detail@DB_M2 (import_cd_id,cd_id,quatity)  values (n_import_cd_id,n_cd_id,n_quatity);
        else
            dbms_output.put_line('insert failed');
            dbms_output.put_line('Id import cd detail not exsit');
        end if;
    end if;

    select stock_available,stock_capacity into curr_stock_available,curr_stock_capacity
    from c##admin.stock@DB_admin
    where stock_id= curr_stock_id;
    if(curr_stock_available<=curr_stock_capacity) then
        commit;
    else
        ROLLBACK TO save_insert_import_cd_detail;
    end if;
end;

-- start test procedure insert_import_cd_detail

select * from cd;
begin
    --insert_import_cd_detail(n_import_cd_id ,n_cd_id ,n_quatity )
    insert_import_cd_detail(3,3,5);
end;

select * from c##m1.import_cd_detail@DB_M1;
select * from C##m1.stock_detail@DB_M1;
select * from C##admin.stock@db_admin;

select * from cd;
begin
    --insert_import_cd_detail(n_import_cd_id ,n_cd_id ,n_quatity )
    insert_import_cd_detail(103,53,5);
end;

select * from c##m2.import_cd_detail@DB_M2;
select * from C##m2.stock_detail@DB_M2;
select * from C##admin.stock@db_admin;
-- end test procedure insert_import_cd_detail
 
create or replace procedure insert_customer(n_cust_id in number ,n_cust_name in varchar2,n_cust_city_id number,n_cust_number_phone varchar2)
as
begin
    if(0<n_cust_id and n_cust_id<=100) then
        insert into C##M1.customer@DB_M1(cust_id,cust_name,cust_city_id,cust_number_phone) values(n_cust_id,n_cust_name,n_cust_city_id,n_cust_number_phone);
    ELSIF(100<n_cust_id and n_cust_id<=200) then
        insert into   C##M2.customer@DB_M2(cust_id,cust_name,cust_city_id,cust_number_phone)  values(n_cust_id,n_cust_name,n_cust_city_id,n_cust_number_phone);
    else
        dbms_output.put_line('insert failed');
        dbms_output.put_line('Id customer in range [1..200].');
    end if;
    commit;
end;


 -- start test procedure insert_customer
 
begin
    --insert_customer(n_cust_id  ,n_cust_name ,n_cust_city_id ,n_cust_number_phone )
    insert_customer(3 ,'cust 3',1,'096xxx');
end;
 
select * from c##m1.customer@DB_M1;
select * from c##admin.customer@db_admin;
 
 
begin
    --insert_customer(n_cust_id  ,n_cust_name ,n_cust_city_id ,n_cust_number_phone )
    insert_customer(103 ,'cust 103',1,'096xxx');
end;
 
select * from C##M2.customer@DB_M2;
select * from c##admin.customer@db_admin;
 
 
 
begin
    --insert_customer(n_cust_id  ,n_cust_name ,n_cust_city_id ,n_cust_number_phone )
    insert_customer(300 ,'cust 300',1,'096xxx');
end;
 
select * from customer;
select * from C##M2.customer@DB_M2;
select * from c##admin.customer@db_admin;
 
 
-- end test procedure insert_customer
 
 
 
 
 
create or replace procedure insert_order(n_order_id in number,n_stock_id in number, n_cust_id in number)
as
    dem int;
begin
    select count(cust_id) into dem from C##M1.customer@DB_M1 where cust_id=n_cust_id;
    if(dem=1) then
        select count(stock_id) into dem from C##M1.stock@DB_M1 where stock_id=n_stock_id;
        if(dem=1) then
            if(n_order_id>0 and n_order_id <=100) then
                insert into C##M1.orders@DB_M1  (order_id,brand_store_id,stock_id,cust_id,total)  values(n_order_id,3,n_stock_id,n_cust_id,0);
            else    
                dbms_output.put_line('insert failed');
                dbms_output.put_line('Id order in range [1..100]');
            end if;
        else
            dbms_output.put_line('insert failed');
            dbms_output.put_line('Id stock invalid');
        end if;
    else
        select count(cust_id) into dem from C##M2.customer@DB_M2 where cust_id=n_cust_id;
        if(dem=1) then
            select count(stock_id) into dem from C##M2.stock@DB_M2 where stock_id=n_stock_id;
            if(dem=1) then
                if(n_order_id>100 and n_order_id <=200) then
                    insert into C##M2.orders@DB_M2 (order_id,brand_store_id,stock_id,cust_id,total)  values(n_order_id,3,n_stock_id,n_cust_id,0);
                else   
                    dbms_output.put_line('insert failed'); 
                    dbms_output.put_line('Id order in range [100..200]');
                end if;
            else
                dbms_output.put_line('insert failed');
                dbms_output.put_line('Id stock invalid');
            end if;
        else
            dbms_output.put_line('insert failed');
            dbms_output.put_line('Id cust is not exist');
        end if;
    end if;

    commit;
end;
 
 

-- start test procedure insert_order
begin
    --insert_order(n_order_id,n_stock_id, n_cust_id );
    insert_order(3,1, 3);
end;
 
select * from c##m1.orders@DB_M1;
 
begin
    --insert_order(n_order_id,n_stock_id, n_cust_id );
    insert_order(103,11, 103 );
end;
 
select * from c##m2.orders@DB_M2;
 
begin
    --insert_order(n_order_id,n_stock_id, n_cust_id );
    insert_order(201,11, 101 );
end;
 
select * from c##m1.orders@DB_M1;
select * from c##m2.orders@DB_M2;
 
 
-- end test procedure insert_order

 
  
create or replace procedure insert_order_details (n_order_id in number, n_cd_id in number, n_quatity in number)
as
    dem int;
    n_price int;
    curr_stock_available int;
    curr_stock_capacity int;
    curr_stock_id int;
begin
    SAVEPOINT save_insert_order_details;
  select count(order_id) into dem from C##M1.orders@DB_M1 where order_id=n_order_id;
  if(dem=1) then
    select NVL(MIN(cd_price),-1)  into n_price from C##M1.cd@DB_M1 where cd_id=n_cd_id;
    if(n_price>0) then
        insert into C##M1.orders_details@DB_M1  (order_id,cd_id,quatity,price) values (n_order_id,n_cd_id,n_quatity,n_price);
        select stock_id into curr_stock_id from C##M1.orders@DB_M1 where  order_id=n_order_id;
        select  stock_available  into curr_stock_available from C##M1.stock_detail@DB_M1 where  cd_id=n_cd_id and stock_id=curr_stock_id;
        if(curr_stock_available >=0)then
            commit;
        else 
            dbms_output.put_line('insert failed');
            ROLLBACK to save_insert_order_details;
        end if;
    else    
        dbms_output.put_line('insert failed');
        dbms_output.put_line('Id cd not exist');
    end if;
  else
    select count(order_id) into dem from C##M2.orders@DB_M2 where order_id=n_order_id;
    if(dem=1) then
        select NVL(MIN(cd_price),-1)  into n_price from C##M2.cd@DB_M2 where cd_id=n_cd_id;
        if(n_price>0) then
            insert into C##M2.orders_details@DB_M2(order_id,cd_id,quatity,price)  values (n_order_id,n_cd_id,n_quatity,n_price);
            select stock_id into curr_stock_id from C##M2.orders@DB_M2 where  order_id=n_order_id;
            select  stock_available  into curr_stock_available from C##M2.stock_detail@DB_M2 where  cd_id=n_cd_id and stock_id=curr_stock_id;
            if(curr_stock_available >=0)then
                commit;
            else 
                dbms_output.put_line('insert failed');
                ROLLBACK to save_insert_order_details;
            end if;
        else 
            dbms_output.put_line('insert failed');   
            dbms_output.put_line('Id cd not exist');
        end if;
    else
        dbms_output.put_line('insert failed');
        dbms_output.put_line('Id order not exist');
    end if;
  end if;
end;    
 
-- start test procedure insert_order_details
begin
--insert_order_details (n_order_id, n_cd_id, n_quatity)
insert_order_details (1, 1, 2);
end;
 
select * from C##M1.orders@DB_M1;
select * from C##M1.orders_details@DB_M1;
select * from C##M1.stock_detail@DB_M1;
select * from c##admin.stock@DB_admin;
select * from c##admin.customer@DB_admin;
 
 
begin
--insert_order_details (n_order_id, n_cd_id, n_quatity)
insert_order_details (103, 53, 3);
end;
 
select * from C##M2.orders@DB_M2;
select * from C##M2.orders_details@DB_M2;
select * from C##M2.stock_detail@DB_M2;
select * from c##admin.stock@DB_admin;
select * from c##admin.customer@DB_admin;
 
-- end test procedure insert_order_details
 
 




create or replace procedure update_quatity_import_cd_detail (n_import_cd_id in number, n_cd_id in number, n_quatity in number)
as
    dem int;
    n_price int;
    curr_stock_available int;
    curr_stock_capacity int;
    curr_stock_id int;
begin
    SAVEPOINT save_update_quatity_import_cd_detail;
    select count(import_cd_id) into dem from C##M1.import_cd_detail@DB_M1 where import_cd_id=n_import_cd_id and cd_id=n_cd_id;
    if(dem=1) then
        select stock_id into curr_stock_id from C##M1.import_cd@DB_M1 where  import_cd_id=n_import_cd_id;

        update C##M1.import_cd_detail@DB_M1
        set quatity=n_quatity
        where import_cd_id=n_import_cd_id and cd_id=n_cd_id;

        select  stock_available,stock_capacity  into curr_stock_available,curr_stock_capacity from C##admin.stock@DB_admin 
        where stock_id=curr_stock_id;
        if(curr_stock_available >=0 and curr_stock_available<= curr_stock_capacity)then
            commit;
        else 
            dbms_output.put_line('insert failed');
            ROLLBACK to save_update_quatity_import_cd_detail;
        end if;
    else 
        select count(import_cd_id) into dem from C##M2.import_cd_detail@DB_M2 where import_cd_id=n_import_cd_id and cd_id=n_cd_id;
        if(dem=1) then
            select stock_id into curr_stock_id from C##M2.import_cd@DB_M2 where  import_cd_id=n_import_cd_id;
            
            update C##M2.import_cd_detail@DB_M2
            set quatity=n_quatity
            where import_cd_id=n_import_cd_id and cd_id=n_cd_id;
            
            select  stock_available,stock_capacity  into curr_stock_available,curr_stock_capacity from C##admin.stock@DB_admin
            where stock_id=curr_stock_id;
            if(curr_stock_available >=0 and curr_stock_available<= curr_stock_capacity)then
                commit;
            else 
                dbms_output.put_line('insert failed');
                ROLLBACK to save_update_quatity_import_cd_detail;
            end if;
        end if;
    end if;
end;

-- start test procedure update_quatity_import_cd_detail
begin
    --update_quatity_import_cd_detail (n_import_cd_id, n_cd_id, n_quatity) 
    update_quatity_import_cd_detail (3, 3,3 );
end;

 select * from C##M1.orders_details@DB_M1;

select * from c##m1.import_cd_detail@DB_M1;
select * from C##m1.stock_detail@DB_M1;
select * from C##admin.stock@db_admin;
 
begin
    --update_quatity_import_cd_detail (n_import_cd_id, n_cd_id, n_quatity)
    update_quatity_import_cd_detail (103, 53, 8);
end;
 
select * from C##M2.orders_details@DB_M2;

select * from c##m2.import_cd_detail@DB_M2;
select * from C##m2.stock_detail@DB_M2;
select * from C##admin.stock@db_admin;
 
 
-- end test procedure update_quatity_import_cd_detail




create or replace procedure update_quatity_order_details (n_order_id in number, n_cd_id in number, n_quatity in number)
as
    dem int;
    n_price int;
    curr_stock_available int;
    curr_stock_capacity int;
    curr_stock_id int;
begin
    SAVEPOINT save_update_quatity_order_details;
    select count(order_id) into dem from C##M1.orders_details@DB_M1 where order_id=n_order_id and cd_id=n_cd_id;
    if(dem=1) then
        select stock_id into curr_stock_id from C##M1.orders@DB_M1 where  order_id=n_order_id;
        update C##M1.orders_details@DB_M1
        set quatity=n_quatity
        where order_id=n_order_id and cd_id=n_cd_id;

        select  stock_available,stock_capacity  into curr_stock_available,curr_stock_capacity from C##admin.stock@DB_admin
            where stock_id=curr_stock_id;
            if(curr_stock_available >=0 and curr_stock_available<= curr_stock_capacity)then
                commit;
            else 
                dbms_output.put_line('insert failed');
                ROLLBACK to save_update_quatity_order_details;
            end if;
    else 

        select count(order_id) into dem from C##M2.orders_details@DB_M2 where order_id=n_order_id and cd_id=n_cd_id;
        if(dem=1) then
            select stock_id into curr_stock_id from C##M2.orders@DB_M2 where  order_id=n_order_id;
            update C##M2.orders_details@DB_M2
            set quatity=n_quatity
            where order_id=n_order_id and cd_id=n_cd_id;

             select  stock_available,stock_capacity  into curr_stock_available,curr_stock_capacity from C##admin.stock@DB_admin
            where stock_id=curr_stock_id;
            if(curr_stock_available >=0 and curr_stock_available<= curr_stock_capacity)then
                commit;
            else 
                dbms_output.put_line('insert failed');
                ROLLBACK to save_update_quatity_order_details;
            end if;
        end if;
    end if;
end;


-- start test procedure update_quatity_order_details

begin
--update_quatity_order_details (n_order_id, n_cd_id, n_quatity)
update_quatity_order_details (1, 1, 3);
end;
 
select * from C##M1.orders@DB_M1;
select * from C##M1.orders_details@DB_M1;
select * from C##M1.stock_detail@DB_M1;
select * from C##M1.cd@DB_M1;
select * from c##admin.stock@DB_admin;
select * from C##m1.import_cd_detail@db_m1;
select * from c##admin.customer@DB_admin;
 
begin
--update_quatity_order_details (n_order_id, n_cd_id, n_quatity)
update_quatity_order_details (103, 53, 8);
end;
 
select * from C##M2.orders@DB_M2;
select * from C##M2.orders_details@DB_M2;
select * from C##M2.stock_detail@DB_M2;
select * from C##M2.cd@DB_M2;
select * from c##admin.stock@DB_admin;
select * from C##m2.import_cd_detail@db_m2;
select * from c##admin.customer@DB_admin;
 
-- end test procedure update_quatity_order_details