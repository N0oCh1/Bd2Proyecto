DROP SEQUENCE sq_sucursal;
CREATE SEQUENCE sq_sucursal 
    START WITH 1000
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;


CREATE OR REPLACE PROCEDURE add_sucursal (
    p_nombre_sucursal       sucursal.nombre_sucursal%TYPE,
    p_ubicacion             sucursal.ubicacion%TYPE
)  
IS
v_contador_nombre       NUMBER;
v_contador_ubicacion    NUMBER;
v_id_sq                 sucursal.id_sucursal%type;

BEGIN
    SELECT COUNT(*)
    INTO v_contador_nombre
    FROM sucursal
    WHERE nombre_sucursal = p_nombre_sucursal;

    SELECT COUNT(*)
    INTO v_contador_ubicacion
    FROM sucursal
    WHERE ubicacion = p_ubicacion;

    IF  v_contador_nombre = 0 AND v_contador_ubicacion = 0 THEN
        SELECT sq_sucursal.nextval INTO v_id_sq FROM DUAL;
        INSERT INTO sucursal VALUES (v_id_sq, p_nombre_sucursal, p_ubicacion);
        DBMS_OUTPUT.PUT_LINE ('se inserto el dato de manera correcta');
        COMMIT;

    ELSIF v_contador_nombre > 0 THEN
        DBMS_OUTPUT.PUT_LINE('el nombre de la sucursal ya existe');

    ELSIF v_contador_ubicacion > 0 then
        DBMS_OUTPUT.PUT_LINE('la ubicacion de la sucursal ya existe');
    
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR ORACLE : '|| sqlerrm);
        ROLLBACK;
END add_sucursal;
/