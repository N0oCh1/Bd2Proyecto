CREATE OR REPLACE FUNCTION calcula_impuesto (
    p_monto             pedidos.monto%TYPE
) RETURN NUMBER IS
v_resultado             NUMBER;
BEGIN
    v_resultado := (p_monto * 7)/100;
RETURN v_resultado;
END calcula_impuesto;
/
