

create or replace trigger import_cd_detail_before_insert
before insert on import_cd_detail
for each ROW
DECLARE
    cd_exist_stock int;
    curr_stock_id int;
    curr_stock_available int;
    curr_stock_capacity int;
begin 
    select stock_id into curr_stock_id from import_cd where import_cd_id=:new.import_cd_id;
    select NVL(MIN(cd_id),-1)  into cd_exist_stock from stock_detail where cd_id=:new.cd_id and  stock_id=curr_stock_id;
    if(cd_exist_stock=-1) then
        insert into stock_detail values (:new.cd_id,curr_stock_id,0);
    else 
        select stock_available,stock_capacity into curr_stock_available,curr_stock_capacity
        from C##admin.stock@db_admin 
        where stock_id=curr_stock_id;
        if(curr_stock_capacity<curr_stock_available+:new.quatity) then
            --raise_application_error(-20000, 'Stock not enough capacity'); 
            dbms_output.put_line('Stock not enough capacity');

        end if;
    end if;
end;


--cập nhật số lượng cd có trong kho sau khi thêm chi tiết sản phẩm

create or replace trigger import_cd_detail_after_insert
after insert on import_cd_detail 
for each ROW
DECLARE
    cd_exist_stock int;
    curr_stock_id int;
    curr_stock_available int;
    curr_stock_capacity int;
begin 
   select stock_id into curr_stock_id from import_cd where import_cd_id=:new.import_cd_id;
   update stock_detail
   set stock_available=stock_available+:new.quatity
   where stock_id=curr_stock_id and cd_id=:new.cd_id;
   
   update C##admin.stock@db_admin 
   set stock_available=stock_available+:new.quatity
   where stock_id=curr_stock_id;
end;

--khởi tạo điểm mặc định cho user customer sau khi thêm khách hàng
CREATE OR replace  TRIGGER customer_after_insert
 AFTER INSERT ON customer
 FOR EACH ROW
 BEGIN
    insert into c##admin.customer@DB_admin values(:NEW.cust_id,0);    
END;




--cập nhật giá trước khi lưu thông tin sản phẩm vào đơn hàng 
CREATE
OR REPLACE TRIGGER orders_details_before_insert BEFORE
INSERT
    ON orders_details FOR EACH ROW 
    DECLARE
        o_price varchar2(10);
        stock_available_cd int;
        curr_stock_id int;

BEGIN 
        SELECT
            cd_price INTO o_price
        FROM cd
        where cd_id=:new.cd_id;
        :new.price := o_price;
end;


--cập nhật tổng đơn hàng sau khi thêm sản phẩm vào đơn hàng
CREATE
OR REPLACE TRIGGER orders_details_after_instert
AFTER
INSERT
    ON orders_details FOR EACH ROW
    DECLARE curr_stock_id number;

BEGIN

select stock_id into curr_stock_id 
   from orders 
   where order_id=:new.order_id;

-- cập nhật tổng tiền của đơn hàng
UPDATE
    orders
SET
    total = total + :NEW.quatity * :NEW.price
WHERE
    orders.order_id = :NEW.order_id;


--cập nhật số lượng cd có trong kho
UPDATE
    stock_detail
SET
    stock_detail.STOCK_AVAILABLE = stock_detail.STOCK_AVAILABLE - :NEW.quatity
WHERE
    stock_detail.cd_id = :new.cd_id and stock_detail.stock_id=curr_stock_id;

--cập nhật số lượng hàng có bên trong kho
UPDATE
    c##admin.stock@DB_admin
SET
    STOCK_AVAILABLE = STOCK_AVAILABLE - :NEW.quatity
    where stock_id=curr_stock_id;
END;


