SELECT attname, atttypid::regtype
FROM pg_attribute
LIMIT 50

SELECT * FROM pg_catalog.pg_tables WHERE schemaname='public';

SELECT * 
FROM pg_catalog.pg_attribute
WHERE schemaname='public'


SELECT table_schema || '.' || table_name
FROM information_schema.tables
WHERE table_type = 'BASE TABLE'
AND table_schema NOT IN ('pg_catalog', 'information_schema');


select c.table_name tabla
, c.ordinal_position orden
, c.column_name columna
, case when c.numeric_scale > 0 then c.data_type ||'( '|| c.numeric_precision||', '||c.numeric_scale||')' 
	   when c.data_type = 'character varying' then 'varchar('||c.character_maximum_length||')'
	   when c.data_type = 'integer' then c.data_type 
	   when c.data_type = 'timestamp without time zone' then 'timestamp' 
	   else c.data_type end tipo_dato
, case when c.ordinal_position = 1 then 'Si' end clave_principal
, c.is_nullable	nulo
, d.description descripcion
FROM information_schema.columns c
inner join pg_class c1 on c.table_name=c1.relname
inner join pg_catalog.pg_namespace n on c.table_schema=n.nspname and c1.relnamespace=n.oid 
left join pg_catalog.pg_description d on d.objsubid=c.ordinal_position and d.objoid=c1.oid

where c.table_schema NOT IN ('pg_catalog', 'information_schema')
order by c.table_name
, c.ordinal_position




select c.table_name tabla
, c.ordinal_position orden
, c.column_name columna
, case when c.numeric_scale > 0 then c.data_type ||'( '|| c.numeric_precision||', '||c.numeric_scale||')' 
	   when c.data_type = 'character varying' then 'varchar('||c.character_maximum_length||')'
	   when c.data_type = 'integer' then c.data_type 
	   when c.data_type = 'timestamp without time zone' then 'timestamp' 
	   else c.data_type end tipo_dato
, case when c.ordinal_position = 1 then 'Si' end clave_principal
, c.is_nullable	nulo
, d.description descripcion
FROM information_schema.columns c
inner join pg_class c1 on c.table_name=c1.relname
inner join pg_catalog.pg_namespace n on c.table_schema=n.nspname and c1.relnamespace=n.oid 
left join pg_catalog.pg_description d on d.objsubid=c.ordinal_position and d.objoid=c1.oid

where c.table_schema NOT IN ('pg_catalog', 'information_schema')
order by c.table_name
, c.ordinal_position
	




select c.table_schema,c.table_name,c.column_name,c.ordinal_position,c.column_default,c.data_type,d.description
from information_schema.columns c
inner join pg_class c1 on c.table_name=c1.relname
inner join pg_catalog.pg_namespace n on c.table_schema=n.nspname and c1.relnamespace=n.oid 
left join pg_catalog.pg_description d on d.objsubid=c.ordinal_position and d.objoid=c1.oid
where c.table_schema NOT IN ('pg_catalog', 'information_schema')
order by c.table_name 
, c.ordinal_position 
