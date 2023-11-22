DROP SEQUENCE sq_pedido;
CREATE SEQUENCE sq_pedido
    START WITH 10000
    INCREMENT by 1
    NOCACHE;

CREATE OR REPLACE PROCEDURE add_pedido(
    p_id_cliente            pedidos.id_cliente%TYPE,
    p_id_sucursal           pedidos.id_sucursal%TYPE,
    p_estado_pedido         pedidos.estado%TYPE
)
IS
v_id_contador       NUMBER;
BEGIN
    SELECT sq_pedido.nextval INTO v_id_contador FROM DUAL;
    INSERT INTO pedidos (id_pedido, id_cliente, id_sucursal, estado, fecha_creacion)
    VALUES (v_id_contador, p_id_cliente, p_id_sucursal, p_estado_pedido, SYSTIMESTAMP);
    DBMS_OUTPUT.PUT_LINE('se creo el pedido numero:  '||v_id_contador);
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('ERROR ORACLE: '|| sqlerrm);
    IF sq_pedido.nextval > 1 THEN
        EXECUTE IMMEDIATE
        'ALTER SEQUENCE sq_pedido INCREMENT BY -1';
    END IF;
END add_pedido;
/