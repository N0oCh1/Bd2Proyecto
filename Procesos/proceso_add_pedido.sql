DROP SEQUENCE sq_pedido;
CREATE SEQUENCE sq_pedido
    START WITH 10000
    INCREMENT by 1
    NOCACHE;

CREATE OR REPLACE PROCEDURE add_pedido(
    p_id_cliente            pedidos.id_cliente%TYPE,
    p_id_sucursal           pedidos.id_sucursal%TYPE,
    p_fecha                 pedidos.fecha_creacion%TYPE,
    monto                   pedidos.monto%TYPE
)
IS
BEGIN
    INSERT INTO pedidos (id_pedido, id_cliente, id_sucursal, fecha_creacion, monto)