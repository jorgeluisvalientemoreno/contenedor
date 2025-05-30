--Oracle: Sentencias para DBA

--PAR�METROS Y ESTADO DE LA BASE DE DATOS INFORMACI�N INSTANCIA Informaci�n del estado de una instancia de base de datos: estado, versi�n, nombre, cuando se levanto, el nombre de la m�quina, �
SELECT * FROM v$instance;

--NOMBRE DE LA BASE DE DATOS A veces no sabemos donde estamos conectados, una forma es localizar el nombre de la base de datos
SELECT value FROM v$system_parameter WHERE upper(name) = upper('db_name');

--PAR�METROS DE LA BASE DE DATOS Vista que muestra los par�metros generales de Oracle:
SELECT * FROM v$system_parameter;
--o tambi�n
SHOW PARAMETERS valor_a_buscar;

--PRODUCTOS ORACLE INSTALADOS Y LA VERSI�N
SELECT * FROM product_component_version;

--OBTENER LA IP DEL SERVIDOR DE LA BASE DE DATOS ORACLE DATABASE
SELECT utl_inaddr.get_host_address IP FROM DUAL;

--UBICACI�N DE FICHEROS LOCALIZAR UBICACI�N Y NOMBRE DEL FICHERO SPFILE
--Como el fichero de par�metros puede haberse cambiado de lugar, se puede localizar de la siguiente manera
SELECT value FROM v$system_parameter WHERE name = 'spfile';

--LOCALIZAR UBICACI�N Y NOMBRE DE LOS FICHEROS DE CONTROL 
--Como el fichero de par�metros puede haberse cambiado de lugar, se puede localizar de la siguiente manera
--Ubicaci�n y n�mero de ficheros de control:
SELECT value FROM v$system_parameter WHERE name = 'control_files';

--TODOS LOS FICHEROS DE DATOS Y SU UBICACI�N
SELECT * FROM V$DATAFILE;

--FICHEROS TEMPORALES
SELECT * FROM V$TEMPFILE;

--FICHEROS DE REDO LOG
SELECT member FROM v$logfile;

--FICHEROS DE ARCHIVE LOG
SHOW parameters archive_dest

--VOLUMETR�A
--ESPACIO UTILIZADO POR LOS TABLESPACES
--Consulta SQL para el DBA de Oracle que muestra los tablespaces, el espacio utilizado, el espacio libre y los ficheros de datos de los mismos
  SELECT t.tablespace_name "Tablespace",
         t.status "Estado",
         ROUND(MAX(d.bytes) / 1024 / 1024, 2) "MB Tama�o",
         ROUND((MAX(d.bytes) / 1024 / 1024) -
               (SUM(DECODE(f.bytes, NULL, 0, f.bytes)) / 1024 / 1024),
               2) "MB Usados",
         ROUND(SUM(DECODE(f.bytes, NULL, 0, f.bytes)) / 1024 / 1024, 2) "MB Libres",
         t.pct_increase "% incremento",
         SUBSTR(d.file_name, 1, 80) "Fichero de datos"
    FROM DBA_FREE_SPACE f, DBA_DATA_FILES d, DBA_TABLESPACES t
   WHERE t.tablespace_name = d.tablespace_name
     AND f.tablespace_name(+) = d.tablespace_name
     AND f.file_id(+) = d.file_id
   GROUP BY t.tablespace_name, d.file_name, t.pct_increase, t.status
   ORDER BY 1, 3 DESC;

--TAMA�O OCUPADO POR LA BASE DE DATOS
SELECT SUM(BYTES) / 1024 / 1024 MB FROM DBA_EXTENTS;

--TAMA�O DE LOS FICHEROS DE DATOS DE LA BASE DE DATOS
SELECT SUM(bytes) / 1024 / 1024 MB FROM dba_data_files;

--TAMA�O OCUPADO POR UNA TABLA CONCRETA SIN INCLUIR LOS �NDICES DE LA MISMA
SELECT SUM(bytes) / 1024 / 1024 MB
  FROM user_segments
 WHERE segment_type = 'TABLE'
   AND segment_name = 'NOMBRETABLA';

--TAMA�O OCUPADO POR UNA TABLA CONCRETA INCLUYENDO LOS �NDICES DE LA MISMA
SELECT SUM(bytes) / 1024 / 1024 Table_Allocation_MB
  FROM user_segments
 WHERE segment_type in ('TABLE', 'INDEX')
   AND (segment_name = 'NOMBRETABLA' OR
       segment_name IN
       (SELECT index_name
           FROM user_indexes
          WHERE table_name = 'NOMBRETABLA'));

--TAMA�O OCUPADO POR UNA COLUMNA DE UNA TABLA
SELECT SUM(vsize('Nombre_Columna')) / 1024 / 1024 MB FROM Nombre_Tabla;

--ESPACIO OCUPADO POR USUARIO
SELECT owner, SUM(BYTES) / 1024 / 1024 FROM DBA_EXTENTS MB GROUP BY owner;

--ESPACIO OCUPADO POR LOS DIFERENTES SEGMENTOS (TABLAS, �NDICES, UNDO, ROLLBACK, CLUSTER, �)
SELECT SEGMENT_TYPE, SUM(BYTES) / 1024 / 1024
  FROM DBA_EXTENTS MB
 GROUP BY SEGMENT_TYPE;

--OCUPACI�N DE TODOS LOS OBJETOS DE LA BASE DE DATOS
--Espacio ocupado por todos los objetos de la base de datos, muestra primero los objetos que m�s ocupan
SELECT SEGMENT_NAME, SUM(BYTES) / 1024 / 1024
  FROM DBA_EXTENTS MB
 GROUP BY SEGMENT_NAME
 ORDER BY 2 DESC;

--OBJETOS DE LA BASE DE DATOS PROPIETARIOS DE OBJETOS Y N�MERO DE OBJETOS POR PROPIETARIO
SELECT owner, COUNT(owner) Numero
  FROM dba_objects
 GROUP BY owner
 ORDER BY Numero DESC;

--MUESTRA LOS DISPARADORES (TRIGGERS) DE LA BASE DE DATOS ORACLE DATABASE
SELECT * FROM ALL_TRIGGERS;

--REGLAS DE INTEGRIDAD Y COLUMNA A LA QUE AFECTAN
SELECT constraint_name, column_name FROM sys.all_cons_columns;

--TABLAS DE LAS QUE ES PROPIETARIO UN USUARIO DETERMINADO
SELECT table_owner, table_name
  FROM sys.all_synonyms
 WHERE table_owner = 'SCOTT';

--INFORMACI�N TABLESPACES
SELECT * FROM V$TABLESPACE;

--BUSQUEDAS DE CONSTRAINTS DESHABILITADAS
SELECT TABLE_NAME, CONSTRAINT_NAME, STATUS
  FROM ALL_CONSTRAINTS
 WHERE OWNER <> 'SIEBEL'
   AND STATUS = 'DISABLED';

--TABLAS CON M�S DE UN N�MERO DETERMINADO DE �NDICES
SELECT TABLE_NAME, COUNT(*)
  FROM ALL_INDEXES
 WHERE OWNER = 'SIEBEL'
 GROUP BY TABLE_NAME
HAVING COUNT(*) > 5
 ORDER BY 2 DESC;

--TABLAS SIN PR�MARY KEY
SELECT TABLE_NAME
  FROM ALL_TABLES T
 WHERE OWNER = 'SIEBEL'
   AND NOT EXISTS (SELECT 1
          FROM ALL_CONSTRAINTS C
         WHERE T.OWNER = C.OWNER
           AND CONSTRAINT_TYPE = 'P');

--OBJETOS NO V�LIDOS (PAQUETES, PROCEDIMIENTOS, FUNCIONES, TRIGGERS, VISTAS,�)
SELECT OBJECT_NAME, OBJECT_TYPE
  FROM all_objects
 WHERE OWNER = 'SIEBEL'
   AND STATUS <> 'VALID';

--OBJETOS CREADOS EN LA �LTIMA HORA
SELECT OBJECT_NAME, OBJECT_TYPE, LAST_DDL_TIME, CREATED, TIMESTAMP, STATUS
  FROM all_objects
 WHERE OWNER = 'SIEBEL'
   AND CREATED > sysdate - 1 / 24;

--OBJETOS MODIFICADOS EN LA �LTIMA HORA
SELECT OBJECT_NAME, OBJECT_TYPE, LAST_DDL_TIME, CREATED, TIMESTAMP, STATUS
  FROM all_objects
 WHERE OWNER = 'SIEBEL'
   AND TIMESTAMP > sysdate - 1;

--INFORMACI�N DE COLUMNAS DE UNA TABLA
SELECT TABLE_NAME,
       COLUMN_NAME,
       DATA_TYPE,
       DATA_LENGTH,
       DATA_PRECISION,
       NULLABLE
  FROM ALL_TAB_COLUMNS
 WHERE OWNER = 'SIEBEL'
   AND TABLE_NAME = 'MI_TABLA'
 ORDER BY TABLE_NAME, COLUMN_ID;

--OPTIMIZACI�N
--IDENTIFICA TABLESPACES Y PROPIETARIOS DE LOS MISMOS. SI TIENE DEMASIADOS EXTENT, EL TAMA�O DE LOS EXTENT PUEDE NO SER OPTIMO
SELECT owner,
       DECODE(partition_name,
              NULL,
              segment_name,
              segment_name || ':' || partition_name) name,
       segment_type,
       tablespace_name,
       bytes,
       initial_extent,
       next_extent,
       PCT_INCREASE,
       extents,
       max_extents
  FROM dba_segments
 WHERE extents > 1
 ORDER BY 9 DESC, 3;

--MEMORIA SHARE_POOL LIBRE Y USADA
SELECT name, to_number(value) bytes
  FROM v$parameter
 WHERE name = 'shared_pool_size'
UNION ALL
SELECT name, bytes
  FROM v$sgastat
 WHERE pool = 'shared pool'
   AND name = 'free memory';

--AUDITOR�A
--MOSTRAR DATOS DE AUDITOR�A DE LA BASE DE DATOS ORACLE (INICIO Y DESCONEXI�N DE SESIONES)
SELECT username, action_name, priv_used, returncode FROM dba_audit_trail;

--SESIONES / USUARIOS
--OBTENER LOS USUARIOS DE UNA BASE DE DATOS
SELECT USERNAME FROM DBA_USERS;

/*
--CONTRASE�AS POR DEFECTO DE ORACLE
SYS: CHANGE_ON_INSTALL
SYSTEM: MANAGER
SCOTT: TIGER
ADAMS: WOOD
JONES: STEEL
BLAKE: PAPER
FORD: CAR
KING: GOLD
*/

--OBTENER LOS ROLES EXISTENTES EN ORACLE DATABASE
SELECT * FROM DBA_ROLES;
ROLES Y PRIVILEGIOS POR ROLES

  SELECT * FROM role_sys_privs;

--INFORMACI�N DE CONEXI�N A LA BASE DE DATOS
SELECT SID, -- Identificador de sesi�n
       osuser, -- Usuario de sistema operativo
       username, -- Usuario de base de datos
       machine, -- M�quina desde la que se realiza la conexi�n
       program, -- Programa, que realiza la conexi�n
       logon_time, -- Hora de conexi�n
       Lockwait -- Identifica si hay bloqueo
  FROM v$session
 ORDER BY osuser;

--VISTA QUE MUESTRA EL N�MERO DE CONEXIONES ACTUALES A ORACLE AGRUPADO POR APLICACI�N QUE REALIZA LA CONEXI�N
SELECT program Aplicacion, COUNT(program) Numero_Sesiones
  FROM v$session
 GROUP BY program
 ORDER BY Numero_Sesiones DESC;

--VISTA QUE MUESTRA LOS USUARIOS DE ORACLE CONECTADOS Y EL N�MERO DE SESIONES POR USUARIO
SELECT username Usuario_Oracle, COUNT(username) Numero_Sesiones
  FROM v$session
 GROUP BY username
 ORDER BY Numero_Sesiones DESC;

--CURSORES ABIERTOS POR USUARIO
SELECT b.sid, a.username, b.value Cursores_Abiertos
  FROM v$session a, v$sesstat b, v$statname c
 WHERE c.name IN ('opened cursors current')
   AND b.statistic# = c.statistic#
   AND a.sid = b.sid
   AND a.username IS NOT NULL
   AND b.value > 0
 ORDER BY 3;

--OBTENER LOS PRIVILEGIOS OTORGADOS A UN ROL DE ORACLE
SELECT privilege FROM dba_sys_privs WHERE grantee = 'NOMBRE_ROL';

--INFORMACI�N SENTENCIAS SQL
--ACIERTOS DE LA CACH� (NO DEBE SUPERAR EL 1 POR CIENTO)
SELECT SUM(pins) Ejecuciones,
       SUM(reloads) Fallos_cache,
       TRUNC(SUM(reloads) / SUM(pins) * 100, 2) Porcentaje_aciertos
  FROM v$librarycache
 WHERE namespace IN ('TABLE/PROCEDURE', 'SQL AREA', 'BODY', 'TRIGGER');

--SENTENCIAS SQL COMPLETAS EJECUTADAS CON UN TEXTO DETERMINADO EN EL SQL
SELECT c.sid, d.piece, c.serial#, c.username, d.sql_text
  FROM v$session c, v$sqltext d
 WHERE c.sql_hash_value = d.hash_value
   AND UPPER(d.sql_text) LIKE '%WHERE CAMPO LIKE%'
 ORDER BY c.sid, d.piece999;

--UNA SENTENCIA SQL CONCRETA (FILTRADO POR SID)
SELECT c.sid, d.piece, c.serial#, c.username, d.sql_text
  FROM v$session c, v$sqltext d
 WHERE c.sql_hash_value = d.hash_value
   AND sid = 105
 ORDER BY c.sid, d.piece;

--�LTIMAS CONSULTAS SQL EJECUTADAS EN ORACLE Y USUARIO QUE LAS EJECUT�
SELECT DISTINCT vs.sql_text,
                vs.sharable_mem,
                vs.persistent_mem,
                vs.runtime_mem,
                vs.sorts,
                vs.executions,
                vs.parse_calls,
                vs.module,
                vs.buffer_gets,
                vs.disk_reads,
                vs.version_count,
                vs.users_opening,
                vs.loads,
                to_char(to_date(vs.first_load_time, 'YYYY-MM-DD/HH24:MI:SS'),
                        'MM/DD  HH24:MI:SS') first_load_time,
                rawtohex(vs.address) address,
                vs.hash_value hash_value,
                rows_processed,
                vs.command_type,
                vs.parsing_user_id,
                OPTIMIZER_MODE,
                au.USERNAME parseuser
  FROM v$sqlarea vs, all_users au
 WHERE (parsing_user_id != 0)
   AND (au.user_id(+) = vs.parsing_user_id)
   AND (executions >= 1)
 ORDER BY buffer_gets / executions DESC;

--COMPROBAR SI LA AUDITOR�A DE LA BASE DE DATOS ORACLE EST� ACTIVADA
SELECT name, value FROM v$parameter WHERE name LIKE 'audit_trail';

--LENGUAJE
--UTILIZAR �,� PARA MILLARES Y �.� PARA DECIMALES PARA REPRESENTACI�N N�MERICA DENTRO DE UN BLOQUE PL/SQL
BEGIN
  Dbms_session.set_nls('NLS_NUMERIC_CHARACTERS', '",."');
END;

--buscar la consulta que consume la mayor parte del tiempo de ejecuci�n (latencia)
SELECT schema_name,
       format_pico_time(total_latency) tot_lat,
       exec_count,
       format_pico_time(total_latency / exec_count) latency_per_call,
       query_sample_text
  FROM sys.x$statements_with_runtimes_in_95th_percentile as t1
  JOIN performance_schema.events_statements_summary_by_digest as t2
    on t2.digest = t1.digest
 WHERE schema_name not in ('performance_schema', 'sys')
 ORDER BY (total_latency / exec_count) desc limit 1 G
