--cập nhật điểm tích lũy cho khách hàng

CREATE OR REPLACE TRIGGER ORDERS_AFTER_UPDATE AFTER
    UPDATE OF TOTAL ON ORDERS FOR EACH ROW
BEGIN
    UPDATE C##ADMIN.CUSTOMER@DB_ADMIN
    SET
        CUST_SCORE= CUST_SCORE+ :NEW.TOTAL-:OLD.TOTAL
    WHERE
        CUST_ID=:NEW.CUST_ID;
END;
 --cập nhật số lượng pen sau khi cập nhật chi tiết nhập thêm hàng vào kho
CREATE OR REPLACE TRIGGER IMPORT_DETAIL_PEN_AFTER_UPDATE AFTER
UPDATE OF QUATITY ON IMPORT_PEN_DETAIL FOR EACH ROW DECLARE CURR_STOCK_DETAIL_AVAILABLE INT;
CURR_STOCK_AVAILABLE INT;
CURR_STOCK_ID INT;
BEGIN
 -- select stock_id into curr_stock_id from import_detail_pen where import_pen_id=:old.import_pen_id;
 -- select stock_available into curr_stock_detail_available from stock_detail where pen_id = :old.pen_id;
    SELECT
        STOCK_ID INTO CURR_STOCK_ID
    FROM
        IMPORT_PEN
    WHERE
        IMPORT_PEN_ID=:OLD.IMPORT_PEN_ID;
    UPDATE STOCK_DETAIL
    SET
        STOCK_AVAILABLE =STOCK_AVAILABLE+:NEW.QUATITY-:OLD.QUATITY
    WHERE
        PEN_ID=:OLD.PEN_ID
        AND STOCK_ID=CURR_STOCK_ID;
 -- select stock_available into curr_stock_available from c##admin.stock@DB_admin where stock_id = curr_stock_id;
    UPDATE C##ADMIN.STOCK@DB_ADMIN
    SET
        STOCK_AVAILABLE= STOCK_AVAILABLE+:NEW.QUATITY-:OLD.QUATITY
    WHERE
        STOCK_ID=CURR_STOCK_ID;
END;
 --cập nhật số lượng pen sau khi cập nhật chi tiết đơn hàng xuất kho
CREATE OR REPLACE TRIGGER ORDERS_DETAILS_AFTER_UPDATE AFTER
UPDATE OF QUATITY ON ORDERS_DETAILS FOR EACH ROW DECLARE SUBTOTAL INT;
CURR_STOCK_ID INT;
BEGIN
    SELECT
        STOCK_ID INTO CURR_STOCK_ID
    FROM
        ORDERS
    WHERE
        ORDER_ID=:OLD.ORDER_ID;
 -- cập nhật tổng tiền của đơn hàng
    UPDATE ORDERS
    SET
        TOTAL = TOTAL+ :NEW.QUATITY * :OLD.PRICE -:OLD.QUATITY * :OLD.PRICE
    WHERE
        ORDER_ID = :OLD.ORDER_ID;
 --cập nhật số lượng pen có trong kho
    UPDATE STOCK_DETAIL
    SET
        STOCK_AVAILABLE = STOCK_AVAILABLE + :OLD.QUATITY- :NEW.QUATITY
    WHERE
        PEN_ID = :OLD.PEN_ID
        AND STOCK_ID=CURR_STOCK_ID;
 --cập nhật số lượng hàng có bên trong kho
    UPDATE C##ADMIN.STOCK@DB_ADMIN
    SET
        STOCK_AVAILABLE = STOCK_AVAILABLE + :OLD.QUATITY- :NEW.QUATITY
    WHERE
        STOCK_ID=CURR_STOCK_ID;
END;