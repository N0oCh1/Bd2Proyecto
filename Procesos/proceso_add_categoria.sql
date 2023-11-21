DROP SEQUENCE sq_categoria;
CREATE SEQUENCE sq_categoria
    START WITH 1
    INCREMENT by 1
    NOCACHE;

CREATE OR REPLACE PROCEDURE add_categoria (
    p_categoria         categoria_item.categoria%TYPE
)
IS
    v_categoria_count       NUMBER;
    v_id_sq                 NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_categoria_count
    FROM categoria_item
    WHERE categoria = p_categoria;

    IF v_categoria_count = 0 THEN
        SELECT sq_categoria.nextval INTO v_id_sq FROM DUAL;
        INSERT INTO categoria_item VALUES (v_id_sq, p_categoria);

        DBMS_OUTPUT.PUT_LINE('se inserto la categoria de manera correcta');
    ELSE
        DBMS_OUTPUT.PUT_LINE('ya existe esta categoria');
    END IF;

EXCEPTION  
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR ORACLE: ' || sqlerrm);
END add_categoria;
/