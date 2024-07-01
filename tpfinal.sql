CREATE DATABASE IF NOT EXISTS parcialfinal;

USE parcialfinal;
 
-- Creación de la tabla Productos
CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    categoria VARCHAR(50),
    stock_disponible INT CHECK (stock_disponible >= 0)
);

-- Creación de la tabla Clientes
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion TEXT,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(15)
);

-- Creación de la tabla Pedidos
CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha_pedido DATE NOT NULL,
    estado_pedido ENUM('pendiente', 'enviado', 'entregado', 'cancelado') NOT NULL,
    metodo_pago VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Creación de la tabla Detalle_Pedidos
CREATE TABLE Detalle_Pedidos (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT CHECK (cantidad > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- Creación de la tabla Proveedores
CREATE TABLE Proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(100),
    direccion TEXT,
    telefono VARCHAR(15),
    email VARCHAR(100)
);

-- Creación de la tabla Compras_Proveedores
CREATE TABLE Compras_Proveedores (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT,
    id_producto INT,
    cantidad INT CHECK (cantidad > 0),
    fecha_compra DATE NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- Creación de la tabla Inventario
CREATE TABLE Inventario (
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    entradas INT CHECK (entradas >= 0),
    salidas INT CHECK (salidas >= 0),
    stock_actual INT CHECK (stock_actual >= 0),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);


-- Insercion de los datos
-- Productos



INSERT INTO Productos (nombre, descripcion, precio, categoria, stock_disponible)
VALUES ('iPhone 12', 'Teléfono móvil de alta gama', 1099.99, 'Electrónica', 50);

INSERT INTO Productos (nombre, descripcion, precio, categoria, stock_disponible)
VALUES ('MacBook Pro', 'Laptop para profesionales', 2399.99, 'Informática', 30);

INSERT INTO Productos (nombre, descripcion, precio, categoria, stock_disponible)
VALUES ('iPad Air', 'Tablet ligera y potente', 599.99, 'Electrónica', 20);

INSERT INTO Productos (nombre, descripcion, precio, categoria, stock_disponible)
VALUES ('AirPods Pro', 'Auriculares inalámbricos con cancelación de ruido', 249.99, 'Accesorios', 100);



-- Clientes

INSERT INTO Clientes (nombre, direccion, correo_electronico, telefono)
VALUES ('Nicolas Dangelo', 'Echeverria', 'nicodange04@gmail.com', '111-111-1111');

INSERT INTO Clientes (nombre, direccion, correo_electronico, telefono)
VALUES ('Nicolas Augusto Dangelo', '9 de Julio', 'nicodange2004@gmail.com', '111-111-1112');

INSERT INTO Clientes (nombre, direccion, correo_electronico, telefono)
VALUES ('Nico Dange', 'Plaza 789', 'nicolasdan04@gmail.com', '111-111-1113');



-- Los pedidos

INSERT INTO Pedidos (id_cliente, fecha_pedido, estado_pedido, metodo_pago)
VALUES (1, '2021-10-29', 'pendiente', 'Tarjeta de crédito');

INSERT INTO Pedidos (id_cliente, fecha_pedido, estado_pedido, metodo_pago)
VALUES (2, '2022-10-29', 'enviado', 'Transferencia bancaria');

INSERT INTO Pedidos (id_cliente, fecha_pedido, estado_pedido, metodo_pago)
VALUES (3, '2023-10-29', 'entregado', 'PayPal');



-- Detalle de los pedidos, id de los productos pedidos 

INSERT INTO Detalle_Pedidos (id_pedido, id_producto, cantidad, precio_unitario)
VALUES (1, 1, 2, 1099.99);

INSERT INTO Detalle_Pedidos (id_pedido, id_producto, cantidad, precio_unitario)
VALUES (1, 4, 1, 249.99);

INSERT INTO Detalle_Pedidos (id_pedido, id_producto, cantidad, precio_unitario)
VALUES (2, 2, 1, 2399.99);

INSERT INTO Detalle_Pedidos (id_pedido, id_producto, cantidad, precio_unitario)
VALUES (3, 3, 3, 599.99);

INSERT INTO Detalle_Pedidos (id_pedido, id_producto, cantidad, precio_unitario)
VALUES (3, 4, 2, 249.99);



-- Los proveedores

INSERT INTO Proveedores (nombre, contacto, direccion, telefono, email)
VALUES ('Apple Arg.', 'Martin', 'Palermo, Ba', '111-111-1114', 'martin@gmail.com');

INSERT INTO Proveedores (nombre, contacto, direccion, telefono, email)
VALUES ('Samsung Arg', 'Juan', 'Belgrano, BA', '111-111-1115', 'jaun@gmail.com');



-- Compras de los proveedores

INSERT INTO Compras_Proveedores (id_proveedor, id_producto, cantidad, fecha_compra)
VALUES (1, 1, 50, '2023-05-01');

INSERT INTO Compras_Proveedores (id_proveedor, id_producto, cantidad, fecha_compra)
VALUES (1, 3, 30, '2023-05-05');

INSERT INTO Compras_Proveedores (id_proveedor, id_producto, cantidad, fecha_compra)
VALUES (2, 2, 40, '2023-05-10');

INSERT INTO Compras_Proveedores (id_proveedor, id_producto, cantidad, fecha_compra)
VALUES (2, 4, 100, '2023-05-15');



-- Inventario de los productos

INSERT INTO Inventario (id_producto, entradas, salidas, stock_actual)
VALUES (1, 100, 50, 50);

INSERT INTO Inventario (id_producto, entradas, salidas, stock_actual)
VALUES (2, 40, 0, 40);

INSERT INTO Inventario (id_producto, entradas, salidas, stock_actual)
VALUES (3, 30, 0, 30);

INSERT INTO Inventario (id_producto, entradas, salidas, stock_actual)
VALUES (4, 100, 0, 100);




-- Consultas Sql 

-- Cantidad de pedidos mensuales
SELECT YEAR(fecha_pedido) AS Anio, MONTH(fecha_pedido) AS Mes, COUNT(*) AS Cantidad_pedidos
FROM Pedidos
GROUP BY YEAR(fecha_pedido), MONTH(fecha_pedido)
ORDER BY Anio, Mes;

-- Cantidad mensual pedida de cada artículo
SELECT YEAR(P.fecha_pedido) AS Anio, MONTH(P.fecha_pedido) AS Mes, PR.nombre AS Articulo, SUM(DP.cantidad) AS Cantidad_pedida
FROM Pedidos P
INNER JOIN Detalle_Pedidos DP ON P.id_pedido = DP.id_pedido
INNER JOIN Productos PR ON DP.id_producto = PR.id_producto
GROUP BY YEAR(P.fecha_pedido), MONTH(P.fecha_pedido), PR.nombre
ORDER BY Anio, Mes, PR.nombre;

-- Ranking de artículos
SELECT PR.nombre AS Articulo, YEAR(P.fecha_pedido) AS Anio, MONTH(P.fecha_pedido) AS Mes, SUM(DP.cantidad) AS Cantidad_pedida
FROM Pedidos P
INNER JOIN Detalle_Pedidos DP ON P.id_pedido = DP.id_pedido
INNER JOIN Productos PR ON DP.id_producto = PR.id_producto
GROUP BY PR.nombre, YEAR(P.fecha_pedido), MONTH(P.fecha_pedido)
ORDER BY Cantidad_pedida DESC;

-- Clientes con mas pedidos realizados
SELECT C.nombre AS Cliente, COUNT(*) AS Cantidad_pedidos
FROM Clientes C
LEFT JOIN Pedidos P ON C.id_cliente = P.id_cliente
GROUP BY C.nombre
ORDER BY Cantidad_pedidos DESC;

-- Ingresos mensualres
SELECT YEAR(fecha_pedido) AS Anio, MONTH(fecha_pedido) AS Mes, SUM(DP.cantidad * DP.precio_unitario) AS Ingreso_total
FROM Pedidos P
INNER JOIN Detalle_Pedidos DP ON P.id_pedido = DP.id_pedido
GROUP BY YEAR(fecha_pedido), MONTH(fecha_pedido)
ORDER BY Anio, Mes;

-- Productos con stock muy bajo
SELECT nombre AS Producto, stock_disponible AS Stock_disponible
FROM Productos
WHERE stock_disponible < 10;

-- Pedidos pendientes de entrega
SELECT P.id_pedido AS Pedido, C.nombre AS Cliente, P.fecha_pedido AS Fecha_del_pedido
FROM Pedidos P
INNER JOIN Clientes C ON P.id_cliente = C.id_cliente
WHERE P.estado_pedido = 'pendiente';

-- Productos top de cada categoria
SELECT PR.categoria AS Categoria, PR.nombre AS Producto, SUM(DP.cantidad) AS Cantidad_vendida
FROM Pedidos P
INNER JOIN Detalle_Pedidos DP ON P.id_pedido = DP.id_pedido
INNER JOIN Productos PR ON DP.id_producto = PR.id_producto
GROUP BY PR.categoria, PR.nombre
ORDER BY PR.categoria, Cantidad_vendida DESC;

-- Proveedores con ams productos dados
SELECT PV.nombre AS Proveedor, COUNT(*) AS Cantidad_productos_suministrados
FROM Proveedores PV
INNER JOIN Compras_Proveedores CP ON PV.id_proveedor = CP.id_proveedor
GROUP BY PV.nombre
ORDER BY Cantidad_productos_suministrados DESC;

-- Historial de compras del cliente id=2
SELECT P.id_pedido AS Pedido, P.fecha_pedido AS Fecha_del_pedido, P.estado_pedido AS Estado_del_pedido, SUM(DP.cantidad * DP.precio_unitario) AS Total_del_pedido
FROM Pedidos P
INNER JOIN Detalle_Pedidos DP ON P.id_pedido = DP.id_pedido
WHERE P.id_cliente = 2
GROUP BY P.id_pedido, P.fecha_pedido, P.estado_pedido
ORDER BY P.fecha_pedido DESC;







