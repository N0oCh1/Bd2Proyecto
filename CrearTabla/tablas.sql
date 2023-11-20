CREATE TABLE CLIENTE (
    ID_CLIENTE NUMBER NOT NULL,
    CEDULA NUMBER,
    NOMBRE VARCHAR(20) NOT NULL,
    APELLIDO VARCHAR(20) NOT NULL,
    CORREO VARCHAR(30) NOT NULL,
    TELEFONO NUMBER,
    EDAD NUMBER,
    PRIMARY KEY (ID_CLIENTE)
);

CREATE TABLA SUCULAR(
    ID_SUCURSAL NUMBER NOT NULL,
    NOMBRE_SUCURSAL VARCHAR(20),
    UBICACION VARCHAR(25),
    PRIMARY KEY(ID_SUCURSAL)
);

CREATE TABLA CATEGORIA_ITEM(
    ID_CATEGORIA NUMBER NOT NULL,
    CATEGORIA VARCHAR(20),
    PRIMARY KEY(ID_CATEGORIA)
);

CREATE TABLE PEDIDOS (
    ID_PEDIDO NUMBER NOT NULL,
    ID_CLIENTE NUMBER NOT NULL,
    ID_SUCURSAL NUMBER NOT NULL,
    FECHA_CREACION TIMESTAMP MONTO NUMBER DEFAULT 0,
    ITMS NUMBER DEFAULT 0,
    SUBTOTAL NUMBER DEFAULT 0,
    PRIMARY KEY (ID_PEDIDO),
    FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE),
    FOREIGN KEY (ID_SUCURSAL) REFERENCES SUCURSAL(ID_SUCURSAL)
);

CREATE TABLE ARTICULOS (
    ID_ARTICULO NUMBER NOT NULL,
    ID_PEDIDO NUMBER NOT NULL,
    ID_ITEM NUMBER NOT NULL,
    NOMBRE_ITEM VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID_CLIENTE),
    FOREIGN KEY (ID_PEDIDO) REFERENCES PEDIDOS (ID_PEDIDO),
    FOREIGN KEY (ID_ITEM) REFERENCES INVETARIO (ID_ITEM)
);

CREATE TABLE INVENTARIO (
    ID_ITEM NUMBER NOT NULL,
    ID_SUCURSAL NUMBER NOT NULL,
    NOMBRE_ITEM VARCHAR(20) NOT NULL,
    DESCRIPCION_ITEM VARCHAR(50),
    ID_CATEGORIA NUMBER NOT NULL,
    MARCA VARCHAR (10),
    CANTIDAD NUMBER,
    DISPONIBILIDAD VARCHAR(10) DEFAULT 'no-disponible',
    PRECIO NUMBER DEFAULT 0,
    PRIMARY KEY (ID_ITEM),
    FOREIGN KEY (ID_SUCURSAL) REFERENCES SUCURSAL(ID_SUCURSAL),
    FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIA(ID_CATEGORIA)
);