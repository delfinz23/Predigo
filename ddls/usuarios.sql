CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre_usuario VARCHAR(12) UNIQUE NOT NULL,
    nombre_completo VARCHAR(255) NOT NULL,
    id_perfil INTEGER REFERENCES perfil(id) ON DELETE CASCADE,
    activo boolean not null,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_baja TIMESTAMP,
    email VARCHAR(255) UNIQUE NOT NULL,
    clave_acceso text not null    
);