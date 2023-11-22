DROP SEQUENCE sq_inventario;
CREATE SEQUENCE sq_inventario
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE OR REPLACE PROCEDURE add_inventario(   
    p_idsucursal inventario.id_sucursal%TYPE,
    p_nombreitem inventario.nombre_item%TYPE,
    p_descripcon inventario.descripcion_item%TYPE,
    p_categoria inventario.id_categoria%TYPE,
    p_marca inventario.marca%TYPE,
    p_cantidad inventario.cantidad%TYPE,
    p_diponibilidad inventario.disponibilidad%TYPE,
    p_precio inventario.precio%TYPE
)
IS
    v_count_idsucursal NUMBER;
    v_count_nombreitem NUMBER;
    v_id_sq number; 
BEGIN
    SELECT COUNT(*)
    INTO v_count_idsucursal
    FROM inventario
    WHERE id_sucursal = p_idsucursal;

    SELECT COUNT(*)
    INTO v_count_nombreitem
    FROM inventario
    WHERE nombre_item = p_nombreitem;

    IF v_count_idsucursal = 0 OR v_count_nombreitem = 0 THEN

        SELECT sq_inventario.nextval INTO v_id_sq FROM DUAL;
        INSERT INTO inventario
        VALUES (v_id_sq, p_idsucursal, p_nombreitem, p_descripcon, p_categoria, p_marca, p_cantidad, p_diponibilidad, p_precio);
        DBMS_OUTPUT.PUT_LINE('se inserto el item dentro de la tabla');
        COMMIT; 
    ELSE
        DBMS_OUTPUT.PUT_LINE('no se puede repetir item dentro de las sucursales');
    END IF;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            ROLLBACK;
END add_inventario;
/