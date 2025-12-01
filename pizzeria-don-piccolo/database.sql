DROP DATABASE IF EXISTS pizzeria_don_piccolo;

CREATE DATABASE pizzeria_don_piccolo;

USE pizzeria_don_piccolo;

CREATE TABLE persona (
    id INT PRIMARY KEY AUTO_INCREMENT not null,
    nombre VARCHAR(50) not null,
    apellido VARCHAR(50) not null,
    documento VARCHAR(20) not null,
    tipoDocumento ENUM('cc','ce') not null
);

CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT not null,
    tipoCliente VARCHAR(50) not null,
    FOREIGN KEY (id) REFERENCES persona(id)
);

CREATE TABLE zona (
    id INT PRIMARY KEY AUTO_INCREMENT not null,
    nombre VARCHAR(50) not null
);

CREATE TABLE repartidores (
    id INT PRIMARY KEY AUTO_INCREMENT not null,
    zona INT not null,
    estado ENUM('disponible','no_disponible') not null,
    FOREIGN KEY (id) REFERENCES persona(id),
    FOREIGN KEY (zona) REFERENCES zona(id)
);

CREATE TABLE trabajadores (
    id INT PRIMARY KEY AUTO_INCREMENT not null,
    tipo_trabajador VARCHAR(50) not null,
    fecha_ingreso DATETIME not NULL,
    FOREIGN KEY (id) REFERENCES persona(id)
);

CREATE TABLE pizza (
    id INT PRIMARY KEY AUTO_INCREMENT not null,
    nombre VARCHAR(80) not null,
    tamaño ENUM('pequeña','mediana','grande') not null,
    precio DOUBLE not null,
    tipo_pizza ENUM('vegetariana','especial','clasica') not null
);

CREATE TABLE ingredientes (
    id INT PRIMARY KEY AUTO_INCREMENT not null,
    nombre VARCHAR(50) not null,
    stock INT not null,
    precio INT not null
);

CREATE TABLE detalle_pizza (
    id INT PRIMARY KEY AUTO_INCREMENT not null,
    id_ingredientes INT not null,
    id_pizza INT not null,
    cantidad INT not null,
    subtotal DOUBLE not null,
    FOREIGN KEY (id_ingredientes) REFERENCES ingredientes(id),
    FOREIGN KEY (id_pizza) REFERENCES pizza(id)
);

CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT not null,
    id_cliente INT not null,
    fecha DATE not null,
    estado ENUM('pendiente', 'en preparación', 'entregado', 'cancelado') not null,
    total DOUBLE not null,
    descripcion VARCHAR(255) not null,
    tipo_pedido ENUM('local','domicilio') not null,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

CREATE TABLE detalle_pedido (
    id INT PRIMARY KEY AUTO_INCREMENT not null,
    id_pedido INT not null,
    id_pizza INT not null,
    cantidad INT not null,
    subtotal DOUBLE not null,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id),
    FOREIGN KEY (id_pizza) REFERENCES pizza(id)
);

CREATE TABLE domicilio (
    id INT PRIMARY KEY AUTO_INCREMENT not null,
    id_pedido INT not null,
    id_repartidor INT not null,
    dirrecion VARCHAR(255) not null,
    costo_domicilio DOUBLE not null,
    total_final DOUBLE not null,
    descripcion VARCHAR(255) not null,
    hora_salida DATETIME not null,
    hora_entrega DATETIME not null,
    distancia_aproximada DOUBLE not null,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id),
    FOREIGN KEY (id_repartidor) REFERENCES repartidores(id)
);

CREATE TABLE pago (
    id INT PRIMARY KEY AUTO_INCREMENT not null,
    metodo ENUM('efectivo','tarjeta','app') not null,
    id_pedido INT not null,
    descripcion VARCHAR(255) not null,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id)
);

-----------------------------------------------------------
                INSERSION DE DATOS                          
-----------------------------------------------------------

-- 1. Zonas
INSERT INTO zona (nombre) VALUES 
('florida'), 
('giron'), 
('bucaramanga');

-- 2. Personas (base para clientes, repartidores y trabajadores)
INSERT INTO persona (nombre, apellido, documento, tipoDocumento) VALUES
('Juan José', 'Pérez Gómez', '1037654321', 'cc'),
('María Camila', 'López Ruiz', '23456789', 'cc'),
('Carlos Andrés', 'Ramírez Soto', '987654321', 'cc'),
('Laura Valentina', 'García Mendoza', '1122334455', 'cc'),
('Pedro José', 'Morales Díaz', '5566778899', 'cc');

-- 3. Clientes
INSERT INTO clientes (id, tipoCliente) VALUES
(1, 'Frecuente'),
(2, 'Ocasional');

-- 4. Repartidores
INSERT INTO repartidores (id, zona, estado) VALUES
(3, 1, 'disponible'),
(4, 2, 'disponible');

-- 5. Trabajador (cajero o cocinero)
INSERT INTO trabajadores (id, tipo_trabajador, fecha_ingreso) VALUES
(5, 'Cocinero', '2024-03-15 08:00:00');

-- 6. Ingredientes
INSERT INTO ingredientes (nombre, stock, precio) VALUES
('Queso Mozzarella', 150, 8000),
('Pepperoni', 80, 12000),
('Champiñones', 100, 6000),
('Salsa de tomate', 200, 4000),
('Jamon', 90, 10000);

-- 7. Pizzas
INSERT INTO pizza (nombre, tamaño, precio, tipo_pizza) VALUES
('Margarita', 'mediana', 0, 'clasica'),
('Pepperoni Lovers', 'grande', 0, 'especial'),
('Vegetariana Deluxe', 'pequeña', 0, 'vegetariana');

-- 8. Detalle de ingredientes por pizza (detalle_pizza)
INSERT INTO detalle_pizza (id_ingredientes, id_pizza, cantidad, subtotal) VALUES
(1, 1, 2, 0),
(4, 1, 1, 0), 
(1, 2, 2, 0),
(2, 2, 1, 0),
(1, 3, 1, 0),
(3, 3, 1, 0),
(4, 3, 1, 0);

-- 9. Pedido de ejemplo (domicilio)
INSERT INTO pedidos (id_cliente, fecha, estado, total, descripcion, tipo_pedido) VALUES
(1, '2025-12-01', 'en preparación', 0, 'Bien caliente con bordes crujientes', 'domicilio');

-- 10. Detalle del pedido
INSERT INTO detalle_pedido (id_pedido, id_pizza, cantidad, subtotal) VALUES
(1, 2, 1, 0),
(1, 1, 1, 0),
(1, 1, 1, 0);

-- 11. Domicilio (entrega)
INSERT INTO domicilio (id_pedido, id_repartidor, dirrecion, costo_domicilio, total_final, descripcion, hora_salida, hora_entrega, distancia_aproximada) VALUES
(1, 3, 'Calle 45 # 23-15, Barrio Norte', 0, 0, 'Conjunto cerrado, portería avisa', '2025-12-01 19:30:00', '2025-12-01 19:50:00', 4.8);

-- 12. Pago
INSERT INTO pago (metodo, id_pedido, descripcion) VALUES
('efectivo', 1, 'Cliente paga con $80000, devuelve $3200');

