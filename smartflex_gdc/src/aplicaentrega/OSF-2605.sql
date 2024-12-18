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

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/aopca.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/aopca.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_alertprodnolect.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_alertprodnolect.sql 

prompt "Aplicando src/gascaribe/servicios-nuevos/procedimientos/ldc_prnot_cxc_sin_legalizar.sql"
@src/gascaribe/servicios-nuevos/procedimientos/ldc_prnot_cxc_sin_legalizar.sql 

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_procrepavc_automatico.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procrepavc_automatico.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldcgencomase.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcgencomase.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_eve_comp_ct65e121302635.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_eve_comp_ct65e121302635.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldcprocenviamailpersondestino.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcprocenviamailpersondestino.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2605_ActSa_Executable_P_SOLICITUD_CARTAS_TIPO_100350.sql"
@src/gascaribe/datafix/OSF-2605_ActSa_Executable_P_SOLICITUD_CARTAS_TIPO_100350.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/procedure/pamot.sql"
@src/gascaribe/gestion-ordenes/procedure/pamot.sql 

prompt "Aplicando src/gascaribe/facturacion/diferidos/procedimientos/pbrcd.sql"
@src/gascaribe/facturacion/diferidos/procedimientos/pbrcd.sql 

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/pgppc.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/pgppc.sql 

prompt "Aplicando src/gascaribe/general/interfaz-contable/procedimientos/adm_person.ldc_llenacostoingresosocierre.sql"
@src/gascaribe/general/interfaz-contable/procedimientos/adm_person.ldc_llenacostoingresosocierre.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_notifica_cierre_ot.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_notifica_cierre_ot.sql

prompt "Aplicando src/gascaribe/fnb/procedimientos/adm_person.ldc_pasadifeapmplano.sql"
@src/gascaribe/fnb/procedimientos/adm_person.ldc_pasadifeapmplano.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2605_actualizar_obj_migrados.sql" 
@src/gascaribe/datafix/OSF-2605_actualizar_obj_migrados.sql

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