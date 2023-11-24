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