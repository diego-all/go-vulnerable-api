CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(64),
    description VARCHAR(200),
    -- Usamos DECIMAL para precios, compatible con float64 en Go
    price DECIMAL(10, 2) NOT NULL, 
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL
);

INSERT INTO products (name, description, price, created_at, updated_at)
VALUES 
('Portátil Ultradelgado', 'Laptop de 14 pulgadas con procesador i7 y 16GB RAM', 1599.99, NOW(), NOW()),
('Smartphone Premium', 'Teléfono móvil de última generación con cámara de 108MP', 999.50, NOW(), NOW()),
('Monitor Curvo 4K', 'Pantalla de 32 pulgadas ideal para gaming y diseño', 450.75, NOW(), NOW()),
('Disco Duro SSD Externo', 'Almacenamiento portátil de 1TB con conexión USB-C', 85.00, NOW(), NOW()),
('Router WiFi 6', 'Dispositivo de red para alta velocidad y cobertura extendida', 120.25, NOW(), NOW()),
('Webcam HD', 'Cámara web con resolución 1080p y micrófono integrado', 49.99, NOW(), NOW()),
('Smartwatch Deportivo', 'Reloj inteligente con GPS y monitor de ritmo cardíaco', 189.90, NOW(), NOW()),
('Impresora Multifuncional', 'Impresora láser a color con escáner y conectividad WiFi', 275.40, NOW(), NOW()),
('Teclado Mecánico RGB', 'Teclado para PC con interruptores táctiles y retroiluminación', 110.00, NOW(), NOW()),
('Drone Plegable', 'Dron con cámara 4K y autonomía de vuelo de 30 minutos', 750.00, NOW(), NOW());
