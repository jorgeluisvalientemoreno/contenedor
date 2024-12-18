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


prompt "------------------------------------------------------"
prompt "Aplicando Sinonimos requeridos"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_consultapercier.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_consultapercier.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.seq_ldc_log_process_ldpor.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.seq_ldc_log_process_ldpor.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_mesaenvws.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_mesaenvws.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldc_log_process_ldpor.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldc_log_process_ldpor.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_ordenmoviles.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_ordenmoviles.sql


prompt "------------------------------------------------------"
prompt "Aplicando migracion de objetos"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_reporte_ley.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_reporte_ley.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.ldc_reporte_ley.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_reporte_ley.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_reporte_ley.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_reporte_ley.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_boreprocesaord.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boreprocesaord.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldc_boreprocesaord.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldc_boreprocesaord.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldc_boreprocesaord.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldc_boreprocesaord.sql


prompt "Aplicando src/gascaribe/datafix/OSF-3069_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-3069_actualizar_obj_migrados.sql

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