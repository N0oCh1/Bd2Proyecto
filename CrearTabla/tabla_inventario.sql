CREATE TABLE inventario (
    id_item                 NUMBER NOT NULL,
    id_sucursal             NUMBER  NOT null,
    nombre_item             VARCHAR(20) NOT NULL,
    descripcion_item        VARCHAR(50),
    id_categoria            NUMBER NOT NULL,
    marca                   VARCHAR (10),
    cantidad                NUMBER,
    disponibilidad          VARCHAR(10) DEFAULT 'no-disponible',
    precio                  NUMBER DEFAULT 0,

    PRIMARY KEY (id_item),
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal),
    FOREIGN KEY (id_categoria) REFERENCES categoria_item(id_categoria)
);