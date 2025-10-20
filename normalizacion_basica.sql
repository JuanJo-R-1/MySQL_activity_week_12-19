CREATE DATABASE IF NOT EXISTS club_deportivo;
USE club_deportivo;

CREATE TABLE categoria (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100)
);

CREATE TABLE jugador (
  id_jugador INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  edad INT,
  id_categoria INT,
  FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE entrenador (
  id_entrenador INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  especialidad VARCHAR(100)
);

CREATE TABLE programa_entrenamiento (
  id_programa INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  objetivo VARCHAR(150),
  id_entrenador INT,
  FOREIGN KEY (id_entrenador) REFERENCES entrenador(id_entrenador)
);

CREATE TABLE programa_jugador (
  id_programa INT,
  id_jugador INT,
  PRIMARY KEY (id_programa, id_jugador),
  FOREIGN KEY (id_programa) REFERENCES programa_entrenamiento(id_programa),
  FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador)
);

CREATE TABLE evento (
  id_evento INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  tipo VARCHAR(100),
  fecha DATE
);

CREATE TABLE jugador_evento (
  id_evento INT,
  id_jugador INT,
  PRIMARY KEY (id_evento, id_jugador),
  FOREIGN KEY (id_evento) REFERENCES evento(id_evento),
  FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador)
);

INSERT INTO categoria (nombre) VALUES ('Sub-15'), ('Sub-20');
INSERT INTO entrenador (nombre, especialidad) VALUES ('Carlos Ruiz','Física'), ('Ana López','Técnica');
INSERT INTO jugador (nombre, edad, id_categoria) VALUES ('Juan Rivero',14,1),('Luis Díaz',19,2);
INSERT INTO programa_entrenamiento (nombre, objetivo, id_entrenador) VALUES ('Resistencia','Mejorar condición física',1);
INSERT INTO programa_jugador VALUES (1,1),(1,2);
INSERT INTO evento (nombre,tipo,fecha) VALUES ('Torneo Regional','Torneo','2025-11-10');
INSERT INTO jugador_evento VALUES (1,1),(1,2);

CREATE INDEX idx_jugador_nombre ON jugador(nombre);

SELECT j.nombre AS jugador, c.nombre AS categoria
FROM jugador j
JOIN categoria c ON j.id_categoria=c.id_categoria;

SELECT e.nombre, COUNT(je.id_jugador) AS total_participantes
FROM evento e
JOIN jugador_evento je ON e.id_evento=je.id_evento
GROUP BY e.nombre;