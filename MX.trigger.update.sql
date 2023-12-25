--cập nhật điểm tích lũy cho khách hàng 

create or replace TRIGGER orders_after_update
AFTER UPDATE of total ON orders FOR EACH ROW 
begin
    update c##admin.customer@DB_admin
    set cust_score= cust_score+ :new.total-:old.total
    where cust_id=:new.cust_id;
end;
    


--cập nhật số lượng cd sau khi cập nhật chi tiết nhập thêm hàng vào kho
create or replace TRIGGER import_detail_cd_after_update
AFTER update of  quatity ON import_cd_detail 
FOR EACH ROW
  DECLARE
    curr_stock_detail_available int;
    curr_stock_available int;
    curr_stock_id int;
BEGIN
-- select stock_id into curr_stock_id from import_detail_cd where import_cd_id=:old.import_cd_id;
-- select stock_available into curr_stock_detail_available from stock_detail where cd_id = :old.cd_id;
select stock_id into curr_stock_id from import_cd where import_cd_id=:old.import_cd_id;

update stock_detail
  set stock_available =stock_available+:new.quatity-:old.quatity 
  where cd_id=:old.cd_id and stock_id=curr_stock_id;


-- select stock_available into curr_stock_available from c##admin.stock@DB_admin where stock_id = curr_stock_id;
  update c##admin.stock@DB_admin
  set stock_available= stock_available+:new.quatity-:old.quatity
  where stock_id=curr_stock_id;
END;

--cập nhật số lượng cd sau khi cập nhật chi tiết đơn hàng xuất kho
create or replace TRIGGER orders_details_after_update
AFTER
UPDATE  of  quatity
    ON orders_details FOR EACH ROW DECLARE
    subtotal int;
    curr_stock_id int;

BEGIN
select stock_id into curr_stock_id from orders where order_id=:old.order_id;

-- cập nhật tổng tiền của đơn hàng
UPDATE
    orders
SET
    total = total+ :NEW.quatity * :old.price -:old.quatity * :old.price
WHERE
    order_id = :old.order_id;
--cập nhật số lượng cd có trong kho
UPDATE
    stock_detail
SET
    STOCK_AVAILABLE = STOCK_AVAILABLE + :old.quatity- :NEW.quatity
WHERE
    cd_id = :old.cd_id and stock_id=curr_stock_id;
--cập nhật số lượng hàng có bên trong kho
UPDATE
    c##admin.stock@DB_admin
SET
    STOCK_AVAILABLE = STOCK_AVAILABLE + :old.quatity- :NEW.quatity
    where stock_id=curr_stock_id;
END;
