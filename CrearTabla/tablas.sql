CREATE TABLE cliente (
    id_cliente          NUMBER NOT NULL,
    cedula              NUMBER,
    nombre              VARCHAR(20) NOT NULL,
    apellido            VARCHAR(20) NOT NULL,
    correo              VARCHAR(30) NOT NULL,
    telefono            NUMBER,
    edad                NUMBER,
    PRIMARY KEY (id_cliente)
);

CREATE TABLE sucursal(
 id_sucursal            NUMBER NOT NULL,
 nombre_sucursal        VARCHAR(20),
 ubicacion              VARCHAR(25),
 PRIMARY KEY(id_sucursal)
);

CREATE TABLE categoria_item(
 id_categoria            NUMBER NOT NULL,
 Categoria               VARCHAR(20),
 PRIMARY KEY(id_categoria)
);

CREATE TABLE inventario (
    id_item                 NUMBER NOT NULL,
    id_sucursal             NUMBER  NOT null,
    nombre_item             VARCHAR(20) NOT NULL,
    descripcion_item        VARCHAR(50),
    id_categoria            NUMBER NOT NULL,
    marca                   VARCHAR (10),
    cantidad                NUMBER,
    disponibilidad          VARCHAR(10) DEFAULT 'N',
    precio                  NUMBER DEFAULT 0,
    PRIMARY KEY (id_item),
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal),
    FOREIGN KEY (id_categoria) REFERENCES categoria_item(id_categoria)
);

CREATE TABLE articulos (
    id_articulo         NUMBER NOT NULL,
    id_pedido           NUMBER NOT NULL,
    id_item             NUMBER NOT NULL,
    nombre_item         VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_articulo),
     FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido),
    FOREIGN KEY (id_item) REFERENCES inventario (id_item)
);

CREATE TABLE pedidos (
    id_pedido           NUMBER NOT NULL,
    id_cliente          NUMBER NOT NULL,
    id_sucursal         NUMBER NOT NULL,
    fecha_creacion      TIMESTAMP,
    monto               NUMBER DEFAULT 0,
    itms                NUMBER DEFAULT 0,
    subtotal            NUMBER DEFAULT 0,
    PRIMARY KEY (id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
);