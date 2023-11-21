CREATE TABLE articulos (
    id_articulo         NUMBER NOT NULL,
    id_pedido           NUMBER NOT NULL,
    id_item             NUMBER NOT NULL,
    nombre_item         VARCHAR(20) NOT NULL,

    PRIMARY KEY (id_cliente),
     FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido),
    FOREIGN KEY (id_item) REFERENCES invetario (id_item)
);