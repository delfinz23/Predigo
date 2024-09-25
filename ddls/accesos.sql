CREATE TABLE accesos (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER REFERENCES usuarios(id) ON DELETE CASCADE,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    exitoso BOOLEAN NOT NULL,
    motivo_fallo VARCHAR(255)
);
