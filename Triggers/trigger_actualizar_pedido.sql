CREATE OR REPLACE TRIGGER tr_estado 
AFTER INSERT ON transaccion 
FOR EACH ROW
DECLARE
BEGIN
    UPDATE pedidos
    SET estado = 'CANCELADO'
    WHERE id_pedido = :NEW.id_pedido;
    dbms_output.put_line('se actualizo el estado del pedido '||:NEW.id_pedido);
END;
/