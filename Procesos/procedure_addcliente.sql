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
        INSERT INTO cliente (
            id_cliente, cedula, nombre, apellido, correo, telefono, edad
        ) VALUES (
            sec_idcliente.nextval, p_cedula, p_nombre, p_apellido, p_correo, p_telefono, p_edad
        );
        COMMIT; 
        DBMS_OUTPUT.PUT_LINE('Record inserted successfully.');
    ELSIF v_count_cedula > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Cedula already exists in the cliente table. Record not inserted.');
    ELSIF v_count_telefono > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Telefono already exists in the cliente table. Record not inserted.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Correo already exists in the cliente table. Record not inserted.');
    END IF;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            ROLLBACK;
END add_cliente;
/