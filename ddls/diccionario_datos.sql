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


select a.table_name tabla
, a.ordinal_position orden
, a.column_name columna
, a.data_type 
, case when a.numeric_scale > 0 then a.data_type ||'( '|| numeric_precision||', '||numeric_scale||')' 
	   when a.data_type = 'character varying' then 'varchar('||a.character_maximum_length||')'
	   when a.data_type = 'integer' then a.data_type 
	   when a.data_type = 'timestamp without time zone' then 'timestamp' 
	   else a.data_type end tipo_dato
, '' clave_principal
, a.is_nullable	nulo 
, a.c
FROM information_schema.columns a
where a.table_schema NOT IN ('pg_catalog', 'information_schema')
order by a.table_name
, a.ordinal_position


select *
from information_schema.table_constraints

SELECT c.column_name, c.data_type
FROM information_schema.table_constraints tc 
JOIN information_schema.constraint_column_usage AS ccu USING (constraint_schema, constraint_name) 
JOIN information_schema.columns AS c ON c.table_schema = tc.constraint_schema
  AND tc.table_name = c.table_name AND ccu.column_name = c.column_name
WHERE constraint_type = 'PRIMARY KEY' and tc.table_name = 'usuarios';