DROP TABLE perfil ;

create table perfil (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT null,
    descripcion VARCHAR(255) NOT NULL
    );
   
DROP table usuarios ;   

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


DROP TABLE accesos ;


CREATE TABLE accesos (
    id SERIAL PRIMARY KEY,
    id_usuario INTEGER REFERENCES usuarios(id) ON DELETE CASCADE,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    exitoso BOOLEAN NOT NULL,
    motivo_fallo VARCHAR(255)
);

drop table datasets ;

create table datasets (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) UNIQUE NOT null,
	descripcion VARCHAR(255) NOT NULL,
	tipo varchar(50) not null,
	id_usuario INTEGER REFERENCES usuarios(id) ON DELETE CASCADE,
	activo boolean not null,
	informacion_eda boolean not null,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	fecha_baja TIMESTAMP
	);
	

drop table nivel_academico ;

create table nivel_academico (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT null,
    descripcion VARCHAR(255) NOT NULL
    );

drop table estado_civil ;  
   
create table estado_civil (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT null,
    descripcion VARCHAR(255) NOT NULL
    );    
   
drop table actividad_economica ;
   
create table actividad_economica (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT null,
    descripcion VARCHAR(255) NOT NULL
    );   

   
drop table calificacion_sistema_financiero ;
   
create table calificacion_sistema_financiero (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT null,
    descripcion VARCHAR(255) NOT NULL
    );     
   

drop table departamento ;
   
create table departamento (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT null,
    descripcion VARCHAR(255) NOT NULL
    );     
   

drop table ciudad;
   
create table ciudad (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT null,
    descripcion VARCHAR(255) NOT null,
    id_departamento INTEGER REFERENCES departamento(id) ON DELETE CASCADE
    );   
	
   
drop table detalle_datasets ;    
   
create table detalle_datasets (
	id SERIAL PRIMARY KEY,
	id_dataset INTEGER REFERENCES datasets(id) ON DELETE CASCADE,
	activo boolean not null,
	informacion_eda boolean not null,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	fecha_baja TIMESTAMP,
	identificador VARCHAR(50) UNIQUE NOT NULL,
	marca_objetivo boolean not null,	
	edad INTEGER NOT NULL,
	genero char(1) NOT NULL,
	id_nivel_academico INTEGER REFERENCES nivel_academico(id) ON DELETE CASCADE,
	id_estado_civil INTEGER REFERENCES estado_civil(id) ON DELETE CASCADE,
	cantidad_hijos INTEGER NOT NULL,
	id_ciudad INTEGER REFERENCES ciudad(id) ON DELETE CASCADE,
	posee_vehiculo_propio boolean not null,
	posee_vivienda_propia boolean not null,
	promedio_factura_servicios_basicos decimal(22,4) not null,
	deuda_pendiente_servicios_basicos decimal(22,4) not null,
	id_actividad_economica INTEGER REFERENCES actividad_economica(id) ON DELETE CASCADE,
	id_calificacion_sistema_financiero INTEGER REFERENCES calificacion_sistema_financiero(id) ON DELETE CASCADE,
	deuda_sistema_financiero decimal(22,4) not null,
	promedio_depositos_sistema_financiero decimal(22,4) not null,
	funcionario_publico boolean not null,
	asalariado boolean not null,
	antiguedad_laboral integer not null,
	anhos_aporte_jubilatorio integer not null,
	total_ingresos decimal(22,4) not null,
	plazo_solicitud integer not null,
	monto_solicitud decimal(22,4) not null	
	)
