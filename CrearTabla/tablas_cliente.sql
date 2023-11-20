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