CREATE TABLE pedidos (
    id_pedido           NUMBER NOT NULL,
    id_cliente          NUMBER NOT NULL,
    id_sucursal         NUMBER NOT NULL,
    fecha_creacion      TIMESTAMP
    monto               NUMBER DEFAULT 0,
    itms                NUMBER DEFAULT 0,
    subtotal            NUMBER DEFAULT 0,

    PRIMARY KEY (id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
);