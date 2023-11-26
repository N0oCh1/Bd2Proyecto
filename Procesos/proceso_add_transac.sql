
DROP sq_transacc;
CREATE SEQUENCE sq_transacc 
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE OR REPLACE PROCEDURE add_transacc (
    p_id_pedido             transaccion.id_pedido%TYPE,
    p_id_cliente            transaccion.id_cliente%TYPE,
    p_monto                 transaccion.monto%TYPE
)
IS
v_subtotal          transaccion.subtotal%TYPE;
v_nombre            cliente.nombre%TYPE;
v_id_trans          number;
BEGIN

SELECT subtotal INTO v_subtotal FROM pedidos WHERE id_pedido = p_id_pedido;
SELECT nombre INTO v_nombre FROM cliente WHERE id_cliente = p_id_cliente;

IF p_monto = v_subtotal THEN
    SELECT sq_transacc.nextval INTO v_id_trans FROM DUAL;
    dbms_output.put_line('la transaccion a sido exitosa');
    INSERT INTO transaccion
    VALUES (v_id_trans, p_id_pedido, p_id_cliente, v_nombre, v_subtotal, p_monto, SYSTIMESTAMP);
    COMMIT;
ELSE
    dbms_output.put_line('el monto no cubre lo que tiene que pagar el cliente');
END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR ORACEL:  '||sqlerrm);
        ROLLBACK;
END add_transacc;
/