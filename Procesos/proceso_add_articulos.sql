DROP SEQUENCE sq_articulos;
CREATE SEQUENCE sq_articulos
    START WITH 1
    INCREMENT by 1
    NOCACHE;

CREATE OR REPLACE PROCEDURE add_articulos (
    p_id_pedido         articulos.id_pedido%TYPE,
    p_id_item           articulos.id_item%TYPE,
    p_nombre_item       articulos.nombre_item%TYPE
)
IS
BEGIN
    INSERT INTO articulos VALUES (sq_articulos.nextval, p_id_pedido, p_id_item, p_nombre_item);
    DBMS_OUTPUT.PUT_LINE('se agrego el item');
EXCEPTION 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR ORACLE: '|| sqlerrm);
END add_articulos;
/