
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
	ubicacion_informacion_tecnica_modelo text, --seria el anotador o pdf generado
	fecha_creacion_modelo TIMESTAMP,
	ubicacion_modelo text,
	modelo_deployado boolean ,--si el modelo que se construyo exitosamente ya se encuentra disponible como servicio
	ubicacion_servicio text,
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
	
	

COMMENT ON COLUMN public.usuarios.id IS 'Codigo Unico del Usuario Generada de Forma Automatica';
COMMENT ON COLUMN public.usuarios.nombre_usuario IS 'Nombre del Usuario cuyo valor no se repite en la tabla';
COMMENT ON COLUMN public.usuarios.nombre_completo IS 'Nombre Completo del Usuario';
COMMENT ON COLUMN public.usuarios.id_perfil IS 'Codigo del Perfil del Usuario';
COMMENT ON COLUMN public.usuarios.activo IS 'Si el usuario se encuentra activo o no';
COMMENT ON COLUMN public.usuarios.fecha_creacion IS 'Fecha de Alta del Usuario';
COMMENT ON COLUMN public.usuarios.fecha_baja IS 'Fecha de Baja del Usuario';
COMMENT ON COLUMN public.usuarios.email IS 'Correo Electronico del Usuario';
COMMENT ON COLUMN public.usuarios.clave_acceso IS 'Clave de Acceso del Usuario';


COMMENT ON COLUMN public.accesos.id IS 'Codigo Unico del Acceso del Usuario al Sistema Generada de Forma Automatica';
COMMENT ON COLUMN public.accesos.id_usuario IS 'Codigo del Usuario';
COMMENT ON COLUMN public.accesos.fecha_hora IS 'Fecha y Hora del Acceso al Sistema';
COMMENT ON COLUMN public.accesos.exitoso IS 'Si el Acceso del Usuario fue exitoso o no';
COMMENT ON COLUMN public.accesos.motivo_fallo IS 'Si el Acceso del Usuario no fue exitoso, registrar el error detectado';


COMMENT ON COLUMN public.actividad_economica.id IS 'Codigo Unico de la Actividad Economica de una Persona';
COMMENT ON COLUMN public.actividad_economica.nombre IS 'Nombre de la Actividad Economica de una Persona, que no se repite en la tabla';
COMMENT ON COLUMN public.actividad_economica.descripcion IS 'Descripcion sobre de la Actividad Economica de una Persona';

COMMENT ON COLUMN public.calificacion_sistema_financiero.id IS 'Codigo Unico de la Calificacion del Sistema Financiero de una Persona';
COMMENT ON COLUMN public.calificacion_sistema_financiero.nombre IS 'Nombre de la Calificacion del Sistema Financiero, que no se repite en la tabla';
COMMENT ON COLUMN public.calificacion_sistema_financiero.descripcion IS 'Descripcion sobre de la Calificacion del Sistema Financiero de una Persona';


COMMENT ON COLUMN public.departamento.id IS 'Codigo Unico del Departamento geografico donde vive la Persona';
COMMENT ON COLUMN public.departamento.nombre IS 'Nombre del Departamento geografico, que no se repite en la tabla';
COMMENT ON COLUMN public.departamento.descripcion IS 'Descripcion sobre del Departamento geografico donde vive la Persona';

COMMENT ON COLUMN public.ciudad.id IS 'Codigo Unico de la Ciudad geografica donde vive la Persona';
COMMENT ON COLUMN public.ciudad.nombre IS 'Nombre de la Ciudad geografica, que no se repite en la tabla';
COMMENT ON COLUMN public.ciudad.descripcion IS 'Descripcion sobre la Ciudad geografica donde vive la Persona';

COMMENT ON COLUMN public.estado_civil.id IS 'Codigo Unico del Estado Civil de la Persona';
COMMENT ON COLUMN public.estado_civil.nombre IS 'Nombre del Estado Civil, que no se repite en la tabla';
COMMENT ON COLUMN public.estado_civil.descripcion IS 'Descripcion sobre el Estado Civil de la Persona';

COMMENT ON COLUMN public.nivel_academico.id IS 'Codigo Unico del Nivel Academico de la Persona';
COMMENT ON COLUMN public.nivel_academico.nombre IS 'Nombre del Nivel Academico, que no se repite en la tabla';
COMMENT ON COLUMN public.nivel_academico.descripcion IS 'Descripcion sobre el Nivel Academico de la Persona';

COMMENT ON COLUMN public.perfil.id IS 'Codigo Unico del Perfil de la Persona en el Sistema';
COMMENT ON COLUMN public.perfil.nombre IS 'Nombre del Perfil, que no se repite en la tabla';
COMMENT ON COLUMN public.perfil.descripcion IS 'Descripcion sobre el Perfil de la Persona en el Sistema';


COMMENT ON COLUMN public.proyectos.id IS 'Codigo Unico del Proyecto de un Usuario(Cliente)';
COMMENT ON COLUMN public.proyectos.nombre IS 'Nombre del Proyecto, que no se repite en la tabla';
COMMENT ON COLUMN public.proyectos.descripcion IS 'Descripcion sobre el Proyecto';
COMMENT ON COLUMN public.proyectos.id_usuario IS 'Codigo del Usuario(Cliente) del Proyecto';
COMMENT ON COLUMN public.proyectos.activo IS 'Si el proyecto se encuenta activo';
COMMENT ON COLUMN public.proyectos.fecha_creacion IS 'Fecha de Creacion del Proyecto';
COMMENT ON COLUMN public.proyectos.fecha_baja IS 'Fecha de Baja del Proyecto';


