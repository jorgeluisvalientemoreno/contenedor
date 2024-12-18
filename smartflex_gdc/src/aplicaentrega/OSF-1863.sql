set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO SAO');

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25
DEFINE CASO=OSF-1863

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
PROMPT **** INICIO ****


prompt  Aplica procedimiento ldc_procreatramitecerti
@src/gascaribe/revision-periodica/plugin/ldc_procreatramitecerti.sql

prompt  Aplica sinónimo para open.ldc_procreatramitecerti
@src/gascaribe/revision-periodica/sinonimos/open.ldc_procreatramitecerti.sql

prompt aplica sinónimos y permisos para open.ge_distribution_file
@src/gascaribe/objetos-producto/sinonimos/ge_distribution_file.sql

prompt aplica sinónimos y permisos para open.ge_module
@src/gascaribe/objetos-producto/sinonimos/ge_module.sql

prompt aplica sinónimos y permisos para open.ge_statement
@src/gascaribe/objetos-producto/sinonimos/ge_statement.sql

prompt aplica sinónimos y permisos para open.gr_config_expression
@src/gascaribe/objetos-producto/sinonimos/gr_config_expression.sql

prompt aplica sinónimos y permisos para open.ldc_procedimiento_obj
@src/gascaribe/servicios-nuevos/sinonimos/open.ldc_procedimiento_obj.sql

prompt Aplica sinónimo para tabla ge_object
@src/gascaribe/objetos-producto/sinonimos/ge_object.sql

prompt aplica sinónimo para tabla ge_object_type
@src/gascaribe/objetos-producto/sinonimos/ge_object_type.sql

prompt aplica sinónimo para tabla gr_configura_type
@src/gascaribe/objetos-producto/sinonimos/gr_configura_type.sql

prompt Creación paquete pkg_homologaserv_util
@src/gascaribe/general/paquetes/personalizaciones.pkg_homologaserv_util.sql

prompt Creación sinónimos para personalizaciones.pkg_homologaserv_util
@src/gascaribe/general/sinonimos/personalizaciones.pkg_homologaserv_util.sql

prompt Creación nuevos servicio en la tabla homologacion_servicios
@src/gascaribe/datafix/OSF-1863_Ajuste_upd_homologacion_servicios.sql

show errors; 

SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin
  FROM DUAL;
PROMPT **** FIN EJECUCIÓN ****
PROMPT CASO             : &CASO
PROMPT Fecha fin        : &fecha_fin
PROMPT =========================================

set timing off
set serveroutput off
set define on
quit
/