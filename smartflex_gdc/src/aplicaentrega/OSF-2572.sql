set serveroutput on size unlimited
set linesize 1000
set timing on
execute dbms_application_info.set_action('APLICANDO OSF-2572');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25

DEFINE CASO=OSF-2572

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

prompt "src/gascaribe/fnb/seguros/proceso-negocio/proceso_negocio.seguros.sql"
@src/gascaribe/fnb/seguros/proceso-negocio/proceso_negocio.seguros.sql

prompt "src/gascaribe/fnb/seguros/parametros/seguro_funerario.sql"
@src/gascaribe/fnb/seguros/parametros/seguro_funerario.sql

prompt "src/gascaribe/fnb/seguros/parametros/estafina_noperm_venta_seguro.sql"
@src/gascaribe/fnb/seguros/parametros/estafina_noperm_venta_seguro.sql

prompt "src/gascaribe/fnb/seguros/paquetes/ld_bosecuremanagement.sql"
@src/gascaribe/fnb/seguros/paquetes/ld_bosecuremanagement.sql

prompt "src/gascaribe/fwcob/GE_OBJECT_120774.sql"
@src/gascaribe/fwcob/GE_OBJECT_120774.sql

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