column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_prvalidauocert.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_prvalidauocert.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_prvalidauocert.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_prvalidauocert.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prvalidauocert.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prvalidauocert.sql

prompt "Aplicando src/gascaribe/general/sql/OSF-2103_actualizar_obj_migrados.sql"
@src/gascaribe/general/sql/OSF-2471_actualizar_obj_migrados.sql

prompt "Aplicando src/test/recompilar-objetos.sql"
@src/test/recompilar-objetos.sql

prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega V1.0"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/
