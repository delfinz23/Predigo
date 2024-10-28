
drop database if exists predigo ;

CREATE DATABASE predigo ;

drop table if exists proyectos_experimentos ;

drop table if exists proyectos_datasets ;

drop table if exists proyectos ;

drop table if exists experimentos ;

drop table if exists detalle_datasets ;  

drop table if exists datasets ;   

DROP TABLE if exists accesos ;

DROP table if exists usuarios ;   

DROP TABLE if exists perfil ;

create table perfil (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT null, -- Cliente, Administrador
    descripcion VARCHAR(255) NOT NULL
    );

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



CREATE TABLE accesos (
    id SERIAL PRIMARY KEY,
    id_usuario INTEGER REFERENCES usuarios(id) ON DELETE CASCADE,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    exitoso BOOLEAN NOT NULL,
    motivo_fallo VARCHAR(255)
);



drop table if exists ciudad;

drop table if exists departamento ;

   
create table departamento (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT null,
    descripcion VARCHAR(255) NOT NULL
    );

   
create table ciudad (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT null,
    descripcion VARCHAR(255) NOT null,
    id_departamento INTEGER REFERENCES departamento(id) ON DELETE CASCADE
    );  

   

  

   
drop table if exists nivel_academico ;

create table nivel_academico (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT null,
    descripcion VARCHAR(255) NOT NULL
    );

drop table if exists estado_civil ;  
   
create table estado_civil (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT null,
    descripcion VARCHAR(255) NOT NULL
    );    
   
drop table if exists actividad_economica ;
   
create table actividad_economica (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT null,
    descripcion VARCHAR(255) NOT NULL
    );   

   
drop table if exists calificacion_sistema_financiero ;
   
create table calificacion_sistema_financiero (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT null,
    descripcion VARCHAR(255) NOT NULL
    );       
    
   
create table datasets (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) UNIQUE NOT null,
	descripcion VARCHAR(255) NOT NULL,
	tipo varchar(50) not null, --training, test, validation (muestra interna)
	id_usuario INTEGER REFERENCES usuarios(id) ON DELETE cascade not NULL,
	activo boolean not null,
	informacion_eda boolean not null,
	ubicacion_informacion_eda varchar(1000) not null, --seria el anotador o pdf generado
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	fecha_baja TIMESTAMP
	);




   
create table detalle_datasets (
	id SERIAL PRIMARY KEY,
	id_dataset INTEGER REFERENCES datasets(id) ON DELETE CASCADE,
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
	);


create table experimentos (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) UNIQUE NOT null,
	descripcion VARCHAR(255) NOT NULL,
	id_usuario INTEGER REFERENCES usuarios(id) ON DELETE cascade not NULL,
	id_dataset_training INTEGER REFERENCES datasets(id) ON DELETE cascade not NULL,
	id_dataset_test INTEGER REFERENCES datasets(id) ON delete cascade,
	activo boolean not null,
	estado varchar(50) not null, --INICIADO, EN CURSO, FINALIZADO OK, FINALIZADO NO OK
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	fecha_baja TIMESTAMP,
	
	tamanho_datos INTEGER not null,
	tamanho_buenos INTEGER not null,
	tamanho_malos INTEGER not null,
	tamanho_training_datos INTEGER not null,
	tamanho_test_datos INTEGER not null,
	

	aplicar_automl boolean not null,
	aplicar_interpretabilidad boolean not null,
	tipo_computacion varchar(3) not null, --CPU, GPU, QPU
	maxima_cantidad_iteraciones INTEGER not null,
	cantidad_iteraciones INTEGER not null,
	maximo_tiempo_entrenamiento INTEGER not null,
	tiempo_entrenamiento INTEGER not null,
	calidad_modelo_esperado INTEGER not null,
	calidad_modelo INTEGER not null,

	modelo_seleccionado varchar(100),
	accuracy decimal(12,8) ,
	precision decimal(12,8),
	recall decimal(12,8) ,
	f1_score decimal(12,8) ,
	
	informacion_tecnica_modelo boolean ,--el modelo se contruyo exitosamente
	ubicacion_informacion_tecnica_modelo varchar(1000), --seria el anotador o pdf generado
	fecha_creacion_modelo TIMESTAMP,
	ubicacion_modelo varchar(1000),
	modelo_deployado boolean ,--si el modelo que se construyo exitosamente ya se encuentra disponible como servicio
	ubicacion_servicio varchar(1000),
	fecha_creacion_servicio TIMESTAMP
	);




create table proyectos (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) UNIQUE NOT null,
	descripcion VARCHAR(255) NOT NULL,
	id_usuario INTEGER REFERENCES usuarios(id) ON DELETE cascade not NULL,
	activo boolean not null,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	fecha_baja TIMESTAMP
	);


create table proyectos_datasets (
	id_proyecto INTEGER REFERENCES proyectos(id) ON DELETE cascade not NULL,
	id_dataset  INTEGER REFERENCES datasets(id) ON DELETE cascade not null,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	);


create table proyectos_experimentos (
	id_proyecto INTEGER REFERENCES proyectos(id) ON DELETE cascade not NULL,
	id_experimento  INTEGER REFERENCES experimentos(id) ON DELETE cascade not null,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	);
