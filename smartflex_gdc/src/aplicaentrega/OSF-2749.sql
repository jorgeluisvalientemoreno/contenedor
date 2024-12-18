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

prompt "src/gascaribe/contratacion/funciones/adm_person.ldcfncretornamesliq.sql"
@src/gascaribe/contratacion/funciones/adm_person.ldcfncretornamesliq.sql

prompt "src/gascaribe/Cierre/paquetes/pkborradatoscierre.sql"
@src/gascaribe/Cierre/paquetes/pkborradatoscierre.sql

prompt "src/gascaribe/Cierre/paquetes/pkborradatoscierre_gdc.sql"
@src/gascaribe/Cierre/paquetes/pkborradatoscierre_gdc.sql

prompt "src/gascaribe/Cierre/procedimientos/ldc_progencierre_gdc.sql"
@src/gascaribe/Cierre/procedimientos/ldc_progencierre_gdc.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_cartcastigada_cierre_gdc.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_cartcastigada_cierre_gdc.sql

prompt "src/gascaribe/objetos-obsoletos/tablas/ldc_liqcontadm.sql"
@src/gascaribe/objetos-obsoletos/tablas/ldc_liqcontadm.sql

prompt "src/gascaribe/cartera/funciones/adm_person.ldc_retornaintmofi.sql"
@src/gascaribe/cartera/funciones/adm_person.ldc_retornaintmofi.sql

prompt "src/gascaribe/papelera-reciclaje/tablas/ldc_osf_castconc.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_osf_castconc.sql

prompt "src/gascaribe/papelera-reciclaje/tablas/ldc_osf_indica_carte.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_osf_indica_carte.sql

prompt "src/gascaribe/datafix/OSF-2749_borrar_sentencia.sql"
@src/gascaribe/datafix/OSF-2749_borrar_sentencia.sql

prompt "src/gascaribe/datafix/OSF-2749_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-2749_actualizar_obj_migrados.sql


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