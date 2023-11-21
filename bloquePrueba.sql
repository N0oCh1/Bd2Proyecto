-- prueba

BEGIN
-- cedula, nombre, apellido, correo, telefono, edad (tabla cliente)
    add_cliente(4324543, 'nombre1', 'apellido1', 'ejemplo1@ejemplo.com',65474353 ,12);
    add_cliente(4524543, 'nombre2', 'apellido2', 'ejemplo2@ejemplo.com',65454324 ,22);
    add_cliente(4624543, 'nombre3', 'apellido3', 'ejemplo3@ejemplo.com',67874332 ,34);
    add_cliente(4824543, 'nombre4', 'apellido4', 'ejemplo4@ejemplo.com',69876743 ,22);
    add_cliente(2324543, 'nombre5', 'apellido5', 'ejemplo5@ejemplo.com',61231475 ,23);
    add_cliente(4524543, 'nombre2', 'apellido2', 'ejemplo2@ejemplo.com',65454324 ,22); -- prueba de error (repetir una insercion)
    add_cliente(2324541, 'nombre6', 'apellido6', 'ejemplo6@ejemplo.com',23231475 ,23);
END;
/

BEGIN
-- nombre_sucursal, ubicacion (tabla sucursal)
    add_sucursal('PtyComponents San Francisco', 'COsta del este');
    add_sucursal('PtyComponents Albrook', 'zona gorrila');

    add_sucursal('PtyComponents San Francisco', 'COsta del este'); -- prueba de error (repetir una insercion)
    add_sucursal('PtyComponents Albrook', 'zona gorrila'); -- prueba de error (repetir una insercion)

    add_sucursal('PtyComponents Tumba Muerto', 'los libertadores');

END;
/