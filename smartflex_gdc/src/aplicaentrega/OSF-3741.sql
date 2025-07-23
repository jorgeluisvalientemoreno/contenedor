column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/seq_ge_proc_sche_detail.sql"
@src/gascaribe/objetos-producto/sinonimos/seq_ge_proc_sche_detail.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/pkboprocctrlbyservicemgr.sql"
@src/gascaribe/objetos-producto/sinonimos/pkboprocctrlbyservicemgr.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_proc_sche_detail.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_proc_sche_detail.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/pkboprocctrlbybillperiod.sql"
@src/gascaribe/objetos-producto/sinonimos/pkboprocctrlbybillperiod.sql

prompt "Aplicando src/gascaribe/objetos-producto/permisos/pkboprocctrlbyservicemgr.sql"
@src/gascaribe/objetos-producto/permisos/pkboprocctrlbyservicemgr.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_gestionprocesosprogramados.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_gestionprocesosprogramados.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ge_proc_sche_detail.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ge_proc_sche_detail.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ge_proc_sche_detail.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ge_proc_sche_detail.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_servicio.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_servicio.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_servicio.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_servicio.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestionejecucionprocesos.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestionejecucionprocesos.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_bogestionejecucionprocesos.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_bogestionejecucionprocesos.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_ldc_periprog.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_ldc_periprog.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_ldc_periprog.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_ldc_periprog.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestionperiodos.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestionperiodos.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_bogestionperiodos.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_bogestionperiodos.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_reportes_inco.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_reportes_inco.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_boutilidades.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_boutilidades.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3741_InsertHomologacionServicios.sql"
@src/gascaribe/datafix/OSF-3741_InsertHomologacionServicios.sql

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