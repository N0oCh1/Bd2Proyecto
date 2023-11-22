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

       
