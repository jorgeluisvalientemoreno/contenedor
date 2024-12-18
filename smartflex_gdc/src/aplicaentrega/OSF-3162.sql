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

prompt "Aplicando src/gascaribe/general/sinonimos/ic_clascott.sql"
@src/gascaribe/general/sinonimos/ic_clascott.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_ciercome.sql"
@src/gascaribe/general/sinonimos/ldc_ciercome.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ge_detalle_acta.sql"
@src/gascaribe/general/sinonimos/ge_detalle_acta.sql

-- Paquetes de Acceso A datos de tablas en el esquema Open
prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldc_tt_local.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_tt_local.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ldc_tt_local.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ldc_tt_local.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldci_carasewe.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldci_carasewe.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ldci_carasewe.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ldci_carasewe.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldc_tt_tb.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_tt_tb.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ldc_tt_tb.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ldc_tt_tb.sql

prompt "Aplicando src/gascaribe/general/procedimientos/adm_person.ldc_pcompressfile.sql"
@src/gascaribe/general/procedimientos/adm_person.ldc_pcompressfile.sql

-------------------------------------------------------------

prompt "Aplicando src/gascaribe/contabilidad/paquetes/adm_person.pkg_bcvalida_tt_local.sql"
@src/gascaribe/contabilidad/paquetes/adm_person.pkg_bcvalida_tt_local.sql

prompt "Aplicando src/gascaribe/contabilidad/sinonimos/adm_person.pkg_bcvalida_tt_local.sql"
@src/gascaribe/contabilidad/sinonimos/adm_person.pkg_bcvalida_tt_local.sql

-------------------------------------------------------------

prompt "Aplicando src/gascaribe/papelera-reciclaje/dbms_jobs/357626.sql"
@src/gascaribe/papelera-reciclaje/dbms_jobs/357626.sql

prompt "Aplicando src/gascaribe/contabilidad/paquetes/adm_person.ldc_pkvalida_tt_local.sql"
@src/gascaribe/contabilidad/paquetes/adm_person.ldc_pkvalida_tt_local.sql

prompt "Aplicando src/gascaribe/contabilidad/paquetes/personalizaciones.ldc_pkvalida_tt_local.sql"
@src/gascaribe/contabilidad/paquetes/personalizaciones.ldc_pkvalida_tt_local.sql

prompt "Aplicando src/gascaribe/contabilidad/sinonimos/personalizaciones.ldc_pkvalida_tt_local.sql"
@src/gascaribe/contabilidad/sinonimos/personalizaciones.ldc_pkvalida_tt_local.sql

prompt "Aplicando src/gascaribe/contabilidad/schedules/job_valida_conf_cont_tt_x_loca.sql"
@src/gascaribe/contabilidad/schedules/job_valida_conf_cont_tt_x_loca.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldc_val_confing_tt_local.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldc_val_confing_tt_local.sql

prompt "Aplicando src/gascaribe/general/trigger/personalizaciones.trg_ldc_val_confing_tt_local.sql"
@src/gascaribe/general/trigger/personalizaciones.trg_ldc_val_confing_tt_local.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3162_act_obj_mig.sql"
@src/gascaribe/datafix/OSF-3162_act_obj_mig.sql

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