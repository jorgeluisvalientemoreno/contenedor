column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/fm_possible_ntl.sql"
@src/gascaribe/objetos-producto/sinonimos/fm_possible_ntl.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/parametros/tipo_trabajo_valida_creacion_pno.sql"
@src/gascaribe/perdidas-no-operacionales/parametros/tipo_trabajo_valida_creacion_pno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/parametros/estado_orden_valida_creacion_pno.sql"
@src/gascaribe/perdidas-no-operacionales/parametros/estado_orden_valida_creacion_pno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/paquetes/personalizaciones.pkg_bcordenespno.sql"
@src/gascaribe/perdidas-no-operacionales/paquetes/personalizaciones.pkg_bcordenespno.sql
show errors;

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/sinonimos/personalizaciones.pkg_bcordenespno.sql"
@src/gascaribe/perdidas-no-operacionales/sinonimos/personalizaciones.pkg_bcordenespno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/paquetes/personalizaciones.pkg_boregistropno.sql"
@src/gascaribe/perdidas-no-operacionales/paquetes/personalizaciones.pkg_boregistropno.sql
show errors;

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/sinonimos/personalizaciones.pkg_boregistropno.sql"
@src/gascaribe/perdidas-no-operacionales/sinonimos/personalizaciones.pkg_boregistropno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/paquetes/ldc_registerntl.sql"
@src/gascaribe/perdidas-no-operacionales/paquetes/ldc_registerntl.sql
show errors;

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/procedimientos/prcvalidascript.sql"
@src/gascaribe/perdidas-no-operacionales/procedimientos/prcvalidascript.sql
show errors;

prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/