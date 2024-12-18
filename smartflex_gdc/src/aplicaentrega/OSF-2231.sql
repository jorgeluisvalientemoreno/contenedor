set serveroutput on size unlimited
set linesize 1000
set timing on
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25
DEFINE CASO=OSF-2231

SELECT SYS_CONTEXT('USERENV', 'DB_NAME') instancia,
   TO_CHAR(SYSDATE, 'yyyymmdd_hh24miss') fecha_ejec,
   SYS_CONTEXT('USERENV','CURRENT_SCHEMA') esquema,
   USER ejecutado_por,
   SYS_CONTEXT('USERENV', 'OS_USER') usuario_so
FROM DUAL;

PROMPT
PROMPT =========================================
PROMPT  ****   Información de Ejecución    ****
PROMPT =========================================
PROMPT Instancia        : &instancia
PROMPT Fecha ejecución  : &fecha_ejec
PROMPT Usuario DB       : &ejecutado_por
PROMPT Usuario O.S      : &usuario_so
PROMPT Esquema          : &esquema
PROMPT CASO             : &CASO
PROMPT =========================================
PROMPT

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "@src/gascaribe/general/sinonimos/personalizaciones.parametros.sql"
@src/gascaribe/general/sinonimos/personalizaciones.parametros.sql

prompt "@src/gascaribe/facturacion/reglas-critica/sql/tablas/personalizaciones.coslprom.sql"
@src/gascaribe/facturacion/reglas-critica/sql/tablas/personalizaciones.coslprom.sql

prompt "@src/gascaribe/facturacion/reglas-critica/paquetes/personalizaciones.pkg_coslprom.sql"
@src/gascaribe/facturacion/reglas-critica/paquetes/personalizaciones.pkg_coslprom.sql

prompt "@src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_coslprom.sql"
@src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_coslprom.sql

prompt "@src/gascaribe/facturacion/reglas-critica/paquetes/ldc_bssreglasproclecturas.sql"
@src/gascaribe/facturacion/reglas-critica/paquetes/ldc_bssreglasproclecturas.sql

prompt "src/gascaribe/facturacion/funciones/personalizaciones.fsbvaliususinlectpromediado.sql"
@src/gascaribe/facturacion/funciones/personalizaciones.fsbvaliususinlectpromediado.sql

prompt "@src/gascaribe/facturacion/sinonimos/personalizaciones.fsbvaliususinlectpromediado.sql"
@src/gascaribe/facturacion/sinonimos/personalizaciones.fsbvaliususinlectpromediado.sql

prompt "src/gascaribe/facturacion/funciones/fnuvaliususinlectpromediado.sql"
@src/gascaribe/facturacion/funciones/fnuvaliususinlectpromediado.sql

prompt "@src/gascaribe/facturacion/reglas-critica/fwcob/ge_object_121754.sql"
@src/gascaribe/facturacion/reglas-critica/fwcob/ge_object_121754.sql

prompt "@src/gascaribe/facturacion/notificaciones/sql/OSF-2231_Notificacion.sql"
@src/gascaribe/facturacion/notificaciones/sql/OSF-2231_Notificacion.sql

prompt "@src/gascaribe/datafix/OSF-2231_PoblacionCoslProm.sql"
@src/gascaribe/datafix/OSF-2231_PoblacionCoslProm.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;

PROMPT **** FIN EJECUCIÓN ****
PROMPT CASO             : &CASO
PROMPT Fecha fin        : &fecha_fin
PROMPT =========================================

set timing off
set serveroutput off
quit
/
