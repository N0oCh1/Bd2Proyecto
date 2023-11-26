DROP SEQUENCE sq_inventario;
CREATE SEQUENCE sq_inventario
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
-- proceso añadir inventario
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

-- proceso registrar nuevos clientes
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

-- registrar articulos cuando se halla creado el pedido
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

-- anadir categoria para el inventario
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

-- registrar el pedido del cliente 
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

-- registrar las sucursales de la empresa
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