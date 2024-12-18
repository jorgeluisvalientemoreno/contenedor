column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/open.mo_package_chng_log.sql"
@src/gascaribe/objetos-producto/sinonimos/mo_package_chng_log.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/open.adm_person.ge_error_log.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_error_log.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/open.mo_boannulment.sql"
@src/gascaribe/objetos-producto/sinonimos/mo_boannulment.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/open.seq_mo_package_chng_log.sql"
@src/gascaribe/objetos-producto/sinonimos/seq_mo_package_chng_log.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/open.wf_instance.sql"
@src/gascaribe/objetos-producto/sinonimos/wf_instance.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/open.mo_executor_log_mot.sql"
@src/gascaribe/objetos-producto/sinonimos/mo_executor_log_mot.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/open.ge_executor_log.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_executor_log.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/open.mo_wf_comp_interfac.sql"
@src/gascaribe/objetos-producto/sinonimos/mo_wf_comp_interfac.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/open.mo_wf_motiv_interfac.sql"
@src/gascaribe/objetos-producto/sinonimos/mo_wf_motiv_interfac.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/open.mo_wf_pack_interfac.sql"
@src/gascaribe/objetos-producto/sinonimos/mo_wf_pack_interfac.sql

prompt "Aplicando src/gascaribe/general/sinonimos/open.wf_instance.sql"
@src/gascaribe/objetos-producto/sinonimos/wf_instance.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/open.in_interface_history.sql"
@src/gascaribe/objetos-producto/sinonimos/in_interface_history.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/open.wf_data_external.sql"
@src/gascaribe/objetos-producto/sinonimos/wf_data_external.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/open.wf_exception_log.sql"
@src/gascaribe/objetos-producto/sinonimos/wf_exception_log.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/open.sa_bouser.sql"
@src/gascaribe/objetos-producto/sinonimos/sa_bouser.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/open.ut_session.sql"
@src/gascaribe/objetos-producto/sinonimos/ut_session.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/open.pkg_session.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_session.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkgmanejosolicitudes.sql"
@src/gascaribe/general/paquetes/adm_person.pkgmanejosolicitudes.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkgmanejosolicitudes.sql"
@src/gascaribe/general/sinonimos/adm_person.pkgmanejosolicitudes.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/procedimiento/prjobanulasolinego.sql"
@src/gascaribe/cartera/negociacion-deuda/procedimiento/prjobanulasolinego.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/procedimiento/ldc_anularerrorflujo.sql"
@src/gascaribe/cartera/negociacion-deuda/procedimiento/ldc_anularerrorflujo.sql

prompt "Aplicando src/gascaribe/revision-periodica/plazos/trigger/ldc_trg_marca_producto_gdc.sql"
@src/gascaribe/revision-periodica/plazos/trigger/ldc_trg_marca_producto_gdc.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/