DROP SEQUENCE sec_idcliente;

CREATE SEQUENCE sec_idcliente
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE OR REPLACE PROCEDURE add_cliente(
    p_cedula cliente.cedula%TYPE,
    p_nombre cliente.nombre%TYPE,
    p_apellido cliente.apellido%TYPE,
    p_correo cliente.correo%TYPE,
    p_telefono cliente.telefono%TYPE,
    p_edad cliente.edad%TYPE
)
IS
    v_count_cedula NUMBER;
    v_count_telefono NUMBER;
    v_count_correo NUMBER;
    v_id_sq         cliente.id_cliente%type;
BEGIN
    SELECT COUNT(*)
    INTO v_count_cedula
    FROM cliente
    WHERE cedula = p_cedula;

    SELECT COUNT(*)
    INTO v_count_telefono
    FROM cliente
    WHERE telefono = p_telefono;

    SELECT COUNT(*)
    INTO v_count_correo
    FROM cliente
    WHERE correo = p_correo;

    -- If cedula, telefono, and correo do not exist, insert the new record
    IF v_count_cedula = 0 AND v_count_telefono = 0 AND v_count_correo = 0 THEN
        SELECT sec_idcliente.nextval INTO v_id_sq FROM DUAL;
        INSERT INTO cliente (
            id_cliente, cedula, nombre, apellido, correo, telefono, edad
        ) VALUES (
            v_id_sq, p_cedula, p_nombre, p_apellido, p_correo, p_telefono, p_edad
        );
        COMMIT; 
        DBMS_OUTPUT.PUT_LINE('el cliente se inserto correctamente');
    ELSIF v_count_cedula > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Cedula ya existe en los registro');
    ELSIF v_count_telefono > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Telefono ya existe en los registro');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Correo ya existe en los registro');
    END IF;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            ROLLBACK;
END add_cliente;
/