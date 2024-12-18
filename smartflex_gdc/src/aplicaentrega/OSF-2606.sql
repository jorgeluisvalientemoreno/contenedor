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

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_prfillotrev.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prfillotrev.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_prfillotrevcertifi.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prfillotrevcertifi.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_prfillotrevrepa.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prfillotrevrepa.sql

prompt "Aplicando src/gascaribe/cartera/procedimientos/adm_person.ldc_procgenproyemadcareta.sql"
@src/gascaribe/cartera/procedimientos/adm_person.ldc_procgenproyemadcareta.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_unlock_orders.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_unlock_orders.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldcmosaca.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcmosaca.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2606_ActSa_Executable_LDCMOSACA.sql"
@src/gascaribe/datafix/OSF-2606_ActSa_Executable_LDCMOSACA.sql

prompt "Aplicando src/gascaribe/facturacion/procedimientos/adm_person.sendmailconcept.sql"
@src/gascaribe/facturacion/procedimientos/adm_person.sendmailconcept.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/dlrapir.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/dlrapir.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/dlrhcci.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/dlrhcci.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2606_ActSa_Executable_DLRHCCI.sql"
@src/gascaribe/datafix/OSF-2606_ActSa_Executable_DLRHCCI.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_anuordenesruterocrm.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_anuordenesruterocrm.sql

prompt "Aplicando src/gascaribe/objetos-obsoletos/ldccamaso.sql"
@src/gascaribe/objetos-obsoletos/ldccamaso.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2606_ActSa_Executable_LDCCAMASO.sql"
@src/gascaribe/datafix/OSF-2606_ActSa_Executable_LDCCAMASO.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/reporte-sui/procedimiento/ldcrepanexa.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/procedimiento/ldcrepanexa.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldrplam.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldrplam.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_validation_coupons.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_validation_coupons.sql

prompt "Aplicando src/gascaribe/operacion-y-mantenimiento/procedimientos/adm_person.ldc_envianotifsolemergencia.sql"
@src/gascaribe/operacion-y-mantenimiento/procedimientos/adm_person.ldc_envianotifsolemergencia.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2606_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-2606_actualizar_obj_migrados.sql

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