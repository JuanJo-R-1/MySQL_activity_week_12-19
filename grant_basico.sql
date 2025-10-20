CREATE DATABASE IF NOT EXISTS ecommerce_;
USE ecommerce_;

CREATE TABLE cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  correo VARCHAR(100)
);

CREATE TABLE producto (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  precio DECIMAL(10,2)
);

CREATE TABLE pedido (
  id_pedido INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT,
  fecha DATE,
  total DECIMAL(10,2),
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

INSERT INTO cliente (nombre, correo) VALUES ('María López','maria@email.com');
INSERT INTO producto (nombre, precio) VALUES ('Zapato Deportivo',150000),('Sandalia',80000);
INSERT INTO pedido (id_cliente, fecha, total) VALUES (1,'2025-10-19',230000);

CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'admin123';
CREATE USER IF NOT EXISTS 'vendedor'@'%' IDENTIFIED BY 'vendedor123';
CREATE USER IF NOT EXISTS 'analista'@'%' IDENTIFIED BY 'analista123';

GRANT ALL PRIVILEGES ON ecommerce_.* TO 'admin'@'%';
GRANT SELECT, INSERT, UPDATE ON pedido TO 'vendedor'@'%';
GRANT SELECT ON producto TO 'vendedor'@'%';
GRANT SELECT ON ecommerce_.* TO 'analista'@'%';

DELIMITER $$
CREATE FUNCTION total_pedidos_cliente(p_id INT) RETURNS DECIMAL(10,2)
BEGIN
  DECLARE t DECIMAL(10,2);
  SELECT IFNULL(SUM(total),0) INTO t FROM pedido WHERE id_cliente=p_id;
  RETURN t;
END$$
DELIMITER ;

GRANT EXECUTE ON FUNCTION ecommerce_.total_pedidos_cliente TO 'analista'@'%';
FLUSH PRIVILEGES;