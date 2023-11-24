DROP SEQUENCE sq_articulos;
CREATE SEQUENCE sq_articulos
    START WITH 1
    INCREMENT by 1
    MINVALUE 1
    NOCACHE;

CREATE OR REPLACE PROCEDURE add_articulo (
    p_id_pedido         articulos.id_pedido%TYPE,
    p_id_item           articulos.id_item%TYPE,
    p_cantidad          articulos.cantidad%TYPE
)
IS
v_id_articulo         NUMBER;
v_nombre_item         articulos.nombre_item%TYPE;
v_id_cliente          pedidos.id_cliente%TYPE;
v_nombre_cliente      cliente.nombre%TYPE;
v_precio_item         articulos.precio%TYPE;
BEGIN
    SELECT sq_articulos.nextval INTO v_id_articulo FROM DUAL;
    SELECT nombre_item INTO v_nombre_item FROM inventario WHERE id_item = p_id_item;

    SELECT id_cliente INTO v_id_cliente from pedidos WHERE id_pedido = p_id_pedido;
    SELECT nombre INTO v_nombre_cliente FROM cliente WHERE id_cliente = v_id_cliente;

    SELECT precio INTO v_precio_item FROM inventario WHERE id_item = p_id_item;

    INSERT INTO articulos 
    VALUES (v_id_articulo, p_id_pedido, p_id_item, v_nombre_item, p_cantidad, v_precio_item);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('se agrego el item al pedido: '|| p_id_pedido ||' cliente: '||v_nombre_cliente);
EXCEPTION 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR ORACLE: '|| sqlerrm);
        IF sq_articulos.nextval > 1 THEN
            EXECUTE IMMEDIATE
        'ALTER SEQUENCE sq_articulos INCREMENT BY -1';
        END IF;
    ROLLBACK;
END add_articulo;
/