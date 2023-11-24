CREATE OR REPLACE TRIGGER tr_act_inventario
AFTER INSERT ON articulos
FOR EACH ROW
DECLARE
    v_cantidad_inv          inventario.cantidad%TYPE;
    v_disponibilidad        inventario.disponibilidad%type;
BEGIN
    SELECT cantidad INTO v_cantidad_inv FROM inventario
    WHERE id_item = :NEW.id_item;
    
    IF v_cantidad_inv < 0 THEN
        v_disponibilidad := 'N';
        DBMS_OUTPUT.PUT_LINE('sin disponibilidad de inventario');
    ELSE
        v_disponibilidad := 'S';
    END IF;

    UPDATE inventario
    SET 
    cantidad = v_cantidad_inv - :NEW.cantidad,
    disponibilidad = v_disponibilidad
    WHERE id_item = :NEW.id_item;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR ORACLE: '|| SQLERRM);
END;
/


CREATE OR REPLACE TRIGGER tr_total_pago
AFTER INSERT OR DELETE ON articulos
FOR EACH ROW
DECLARE 
    v_monto         pedidos.monto%TYPE;
    v_precio_item   inventario.precio%TYPE;
    v_impuesto      pedidos.itms%TYPE;
    v_subtotal      pedidos.subtotal%TYPE;
BEGIN
    IF INSERTING THEN
        SELECT monto INTO v_monto FROM pedidos
        WHERE id_pedido = :new.id_pedido;

        SELECT precio INTO v_precio_item FROM inventario
        WHERE id_item = :NEW.id_item;

        v_monto := v_monto + v_precio_item * :NEW.cantidad;
        v_impuesto := calcula_impuesto(v_monto);
        v_subtotal := v_monto + v_impuesto; 

        UPDATE pedidos 
        SET
        monto = v_monto,
        itms = v_impuesto,
        subtotal = v_subtotal
        WHERE id_pedido = :NEW.id_pedido;
        DBMS_OUTPUT.PUT_LINE('se calculo el total de pagar del pedido: ' ||:NEW.id_pedido);
    
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('eliminando articulo del pedido');
        SELECT monto INTO v_monto FROM pedidos
        WHERE id_pedido = :OLD.id_pedido;

        SELECT precio INTO v_precio_item FROM inventario
        WHERE id_item = :OLD.id_item;

        v_monto := v_monto - v_precio_item * :OLD.cantidad;
        v_impuesto := calcula_impuesto(v_monto);
        v_subtotal := v_monto + v_impuesto; 

        UPDATE pedidos 
        SET
        monto = v_monto,
        itms = v_impuesto,
        subtotal = v_subtotal
        WHERE id_pedido = :OLD.id_pedido;
        DBMS_OUTPUT.PUT_LINE('se calculo el total de pagar del pedido: ' ||:OLD.id_pedido);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR ORACLE: '|| sqlerrm);
END;
/
       