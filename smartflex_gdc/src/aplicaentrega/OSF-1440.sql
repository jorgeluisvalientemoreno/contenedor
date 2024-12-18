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
DEFINE CASO=OSF-1440

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
prompt "Aplicando Entrega Unificada OSF-1086 - OSF-1440"
prompt "------------------------------------------------------"

prompt "Aplicando OSF-1086"

prompt "@src/gascaribe/facturacion/reglas-critica/parametros/cod_atrb_cambio_medidor.sql"
@src/gascaribe/facturacion/reglas-critica/parametros/cod_atrb_cambio_medidor.sql

prompt "@src/gascaribe/facturacion/reglas-critica/tablas/ldc_obleacti.sql"
@src/gascaribe/facturacion/reglas-critica/tablas/ldc_obleacti.sql

prompt "@src/gascaribe/facturacion/reglas-critica/fwcea/LDC_OBLEACTI.sql"
@src/gascaribe/facturacion/reglas-critica/fwcea/LDC_OBLEACTI.sql

prompt "@src/gascaribe/facturacion/reglas-critica/md/ldcacgeol.sql"
@src/gascaribe/facturacion/reglas-critica/md/ldcacgeol.sql

prompt "@src/gascaribe/facturacion/reglas-critica/sql/OSF-1086Configuracion.sql"
@src/gascaribe/facturacion/reglas-critica/sql/OSF-1086Configuracion.sql

prompt "Aplicando OSF-1440"

prompt "src/gascaribe/datafix/OSF-1440_Ajuste_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-1440_Ajuste_homologacion_servicios.sql

prompt "@src/gascaribe/facturacion/sinonimos/obselect.sql"
@src/gascaribe/facturacion/sinonimos/obselect.sql

prompt "@src/gascaribe/facturacion/lecturas_especiales/parametros/observaciones_nlectura_lectesp.sql"
@src/gascaribe/facturacion/lecturas_especiales/parametros/observaciones_nlectura_lectesp.sql

prompt "@src/gascaribe/facturacion/lecturas_especiales/tablas/ldc_cm_lectesp.sql"
@src/gascaribe/facturacion/lecturas_especiales/tablas/ldc_cm_lectesp.sql

prompt "@src/gascaribe/facturacion/lecturas_especiales/paquetes/ldc_pkcm_lectesp.sql"
@src/gascaribe/facturacion/lecturas_especiales/paquetes/ldc_pkcm_lectesp.sql

prompt "@src/gascaribe/facturacion/reglas-critica/paquetes/ldc_bssreglasproclecturas.sql"
@src/gascaribe/facturacion/reglas-critica/paquetes/ldc_bssreglasproclecturas.sql

prompt "@src/gascaribe/facturacion/lecturas_especiales/fwcea/ldc_cm_lectesp.sql"
@src/gascaribe/facturacion/lecturas_especiales/fwcea/ldc_cm_lectesp.sql

prompt "@src/gascaribe/facturacion/giras/lectesp.sql"
@src/gascaribe/facturacion/giras/lectesp.sql

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
