-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS afluencia_metro_cdmx;
USE afluencia_metro_cdmx;

-- Crear tablas
CREATE TABLE IF NOT EXISTS lineas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS estaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    linea_id INT,
    tipo_estacion VARCHAR(50) DEFAULT 'Intermedia',
    capacidad_maxima INT DEFAULT 10000,
    FOREIGN KEY (linea_id) REFERENCES lineas(id)
);

CREATE TABLE IF NOT EXISTS afluencia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    estacion_id INT,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    afluencia INT NOT NULL,
    FOREIGN KEY (estacion_id) REFERENCES estaciones(id)
);

CREATE TABLE IF NOT EXISTS porcentajes_afluencia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    linea_id INT,
    porcentaje_hombres DECIMAL(5,2) NOT NULL,
    porcentaje_mujeres DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (linea_id) REFERENCES lineas(id)
);

-- Crear índices
CREATE INDEX idx_estaciones_linea_id ON estaciones(linea_id);
CREATE INDEX idx_afluencia_estacion_id ON afluencia(estacion_id);
CREATE INDEX idx_afluencia_fecha ON afluencia(fecha);

-- Insertar datos en la tabla de líneas
INSERT INTO lineas (nombre) VALUES 
('Línea 1'), ('Línea 2'), ('Línea 3'), ('Línea 8'),
('Línea B'), ('Línea A'), ('Línea 7'), ('Línea 12');

-- Usar DELIMITER para manejar bloques de código con variables
DELIMITER $$

-- Obtener los IDs de las líneas insertadas
SET @linea1_id := (SELECT id FROM lineas WHERE nombre = 'Línea 1')$$
SET @linea2_id := (SELECT id FROM lineas WHERE nombre = 'Línea 2')$$
SET @linea3_id := (SELECT id FROM lineas WHERE nombre = 'Línea 3')$$
SET @linea8_id := (SELECT id FROM lineas WHERE nombre = 'Línea 8')$$
SET @linea12_id := (SELECT id FROM lineas WHERE nombre = 'Línea 12')$$
SET @lineaB_id := (SELECT id FROM lineas WHERE nombre = 'Línea B')$$
SET @linea7_id := (SELECT id FROM lineas WHERE nombre = 'Línea 7')$$
SET @lineaA_id := (SELECT id FROM lineas WHERE nombre = 'Línea A')$$

-- Insertar datos en la tabla de estaciones
INSERT INTO estaciones (nombre, linea_id, tipo_estacion, capacidad_maxima) VALUES 
('Pantitlán', @linea1_id, 'Terminal', 20000), ('Tacubaya', @linea2_id, 'Intermedia', 15000), 
('Universidad', @linea3_id, 'Terminal', 18000), ('Indios Verdes', @linea3_id, 'Terminal', 25000), 
('Cuatro Caminos', @linea2_id, 'Terminal', 20000), ('Constitución de 1917', @linea8_id, 'Terminal', 12000), 
('Tláhuac', @linea12_id, 'Terminal', 15000), ('Tasqueña', @linea12_id, 'Terminal', 18000), 
('Observatorio', @linea1_id, 'Terminal', 17000), ('Ciudad Azteca', @lineaB_id, 'Terminal', 22000), 
('Buenavista', @lineaB_id, 'Intermedia', 14000), ('Insurgentes', @linea1_id, 'Intermedia', 13000), 
('La Paz', @lineaA_id, 'Terminal', 16000), ('Zaragoza', @linea1_id, 'Intermedia', 15000), 
('Chapultepec', @linea1_id, 'Intermedia', 13000), ('Chilpancingo', @linea9_id, 'Intermedia', 12000), 
('Barranca del Muerto', @linea7_id, 'Terminal', 14000)$$

-- Obtener los IDs de las estaciones insertadas
SET @pantitlan_id := (SELECT id FROM estaciones WHERE nombre = 'Pantitlán')$$
SET @barranca_del_Muerto_id := (SELECT id FROM estaciones WHERE nombre = 'Barranca del Muerto')$$
SET @chilpancingo_id := (SELECT id FROM estaciones WHERE nombre = 'Chilpancingo')$$
SET @cuatro_Caminos_id := (SELECT id FROM estaciones WHERE nombre = 'Cuatro Caminos')$$
SET @universidad_id := (SELECT id FROM estaciones WHERE nombre = 'Universidad')$$
SET @indios_verdes_id := (SELECT id FROM estaciones WHERE nombre = 'Indios Verdes')$$
SET @chapultepec_id := (SELECT id FROM estaciones WHERE nombre = 'Chapultepec')$$
SET @zaragoza_id := (SELECT id FROM estaciones WHERE nombre = 'Zaragoza')$$
SET @tacubaya_id := (SELECT id FROM estaciones WHERE nombre = 'Tacubaya')$$
SET @la_paz_id := (SELECT id FROM estaciones WHERE nombre = 'La Paz')$$
SET @insurgentes_id := (SELECT id FROM estaciones WHERE nombre = 'Insurgentes')$$
SET @buenavista_id := (SELECT id FROM estaciones WHERE nombre = 'Buenavista')$$
SET @ciudad_azteca_id := (SELECT id FROM estaciones WHERE nombre = 'Ciudad Azteca')$$
SET @observatorio_id := (SELECT id FROM estaciones WHERE nombre = 'Observatorio')$$
SET @tasquena_id := (SELECT id FROM estaciones WHERE nombre = 'Tasqueña')$$
SET @tlahuac_id := (SELECT id FROM estaciones WHERE nombre = 'Tláhuac')$$
SET @constitucion_de_1917_id := (SELECT id FROM estaciones WHERE nombre = 'Constitución de 1917')$$

-- Insertar datos en la tabla de afluencia
INSERT INTO afluencia (estacion_id, fecha, hora, afluencia) VALUES 
(@pantitlan_id, '2023-01-01', '06:30:00', 1500), (@barranca_del_Muerto_id, '2023-06-13', '06:10:00', 1600), 
(@chilpancingo_id, '2023-06-13', '07:15:00', 1800), (@tacubaya_id, '2023-06-13', '05:30:00', 1400), 
(@cuatro_Caminos_id, '2023-06-13', '06:10:00', 1700), (@universidad_id, '2023-06-13', '06:00:00', 1300), 
(@indios_verdes_id, '2023-06-13', '05:00:00', 1900), (@chapultepec_id, '2023-06-14', '05:45:00', 1550), 
(@zaragoza_id, '2023-06-14', '06:45:00', 1650), (@la_paz_id, '2023-06-14', '06:30:00', 1850), 
(@insurgentes_id, '2023-06-14', '07:00:00', 1450), (@buenavista_id, '2023-06-14', '05:15:00', 1750), 
(@ciudad_azteca_id, '2023-06-14', '05:00:00', 1350), (@observatorio_id, '2023-06-14', '05:00:00', 1950), 
(@tasquena_id, '2023-06-14', '05:45:00', 1950), (@tlahuac_id, '2023-06-14', '06:00:00', 1950), 
(@constitucion_de_1917_id, '2023-06-14', '05:20:00', 1950)$$

-- Insertar datos en la tabla de porcentajes de afluencia
INSERT INTO porcentajes_afluencia (linea_id, porcentaje_hombres, porcentaje_mujeres) VALUES 
(@linea1_id, 52.00, 48.00), (@linea2_id, 50.00, 50.00), 
(@linea3_id, 49.00, 51.00), (@linea8_id, 53.00, 47.00), 
(@linea12_id, 51.00, 49.00), (@lineaB_id, 54.00, 46.00)$$

DELIMITER ;

-- Consultas para ver los datos insertados
SELECT * FROM porcentajes_afluencia;
SELECT * FROM afluencia;
SELECT e.nombre AS Estación, SUM(a.afluencia) AS Afluencia_Total
FROM afluencia a
JOIN estaciones e ON a.estacion_id = e.id
GROUP BY e.nombre;
SELECT e.nombre AS Estación, a.fecha AS Fecha, SUM(a.afluencia) AS Afluencia
FROM afluencia a
JOIN estaciones e ON a.estacion_id = e.id
GROUP BY e.nombre, a.fecha
ORDER BY a.fecha;
SELECT l.nombre AS Línea, p.porcentaje_hombres AS Porcentaje_Hombres, p.porcentaje_mujeres AS Porcentaje_Mujeres
FROM porcentajes_afluencia p
JOIN lineas l ON p.linea_id = l.id;

