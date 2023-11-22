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
-- categoria (tabla categoria_item)
BEGIN
    add_categoria('Monitores');
    add_categoria('Perofericos');
    add_categoria('CPU');
    add_categoria('Targetas graficas');
    add_categoria('laptop');
    add_categoria('Cable');
    add_categoria('Caja');
    add_categoria('Cable');
    add_categoria('s');
END;
/

BEGIN
--id_sucursal, nombre_item, descripcion, id_categoria, marca, cantidad, disponibilidad, precio
    add_inventario(1000, 'intel I7', 'CPU algo', 3, 'Intel', 99, 'S', 499);
    add_inventario(1000, 'intel I5', 'CPU algo', 3, 'Intel', 99, 'S', 499);
    add_inventario(1000, 'intel I9', 'CPU algo', 3, 'Intel', 99, 'S', 499);
    add_inventario(1001, 'hp omen', 'laptop gaming', 3, 'hp', 99, 'S', 499);
    add_inventario(1002, 'hp omen', 'laptop gaming', 3, 'hp', 99, 'S', 499);
    add_inventario(1002, 'hp omen', 'laptop gaming', 3, 'hp', 99, 'S', 499); -- prueba de error (duplicacion de item)
END;
/

-- id_pedido, id_item, nombre_item (tabla articulos)