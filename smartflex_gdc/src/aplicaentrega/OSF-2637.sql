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

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_proreg_ct_process_log.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_proreg_ct_process_log.sql

prompt "src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_ordeeldorcd.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_ordeeldorcd.sql

prompt "src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_ordeeldorcd.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_ordeeldorcd.sql

prompt "src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_comeordorcd.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_comeordorcd.sql

prompt "src/gascaribe/atencion-usuarios/sinonimos/adm_person.seq_ldc_comeordorcd.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.seq_ldc_comeordorcd.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.cf_boactions.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.cf_boactions.sql

prompt "src/gascaribe/general/sinonimos/adm_person.daps_package_type.sql"
@src/gascaribe/general/sinonimos/adm_person.daps_package_type.sql

prompt "src/gascaribe/general/sinonimos/adm_person.dage_person.sql"
@src/gascaribe/general/sinonimos/adm_person.dage_person.sql

prompt "src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_inconsisflujo.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_inconsisflujo.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.dacc_causal.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.dacc_causal.sql

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.ct_boconstants.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ct_boconstants.sql

prompt "src/gascaribe/atencion-usuarios/sinonimos/adm_person.seq_ldc_ordeeldorcd.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.seq_ldc_ordeeldorcd.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_ordenes_ofertados_redes.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_ordenes_ofertados_redes.sql

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.seq_ct_process_log_109639.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.seq_ct_process_log_109639.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bofwlockorder.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bofwlockorder.sql

prompt "src/gascaribe/general/sinonimos/adm_person.dage_subscriber.sql"
@src/gascaribe/general/sinonimos/adm_person.dage_subscriber.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_homoitmaitac.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_homoitmaitac.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_osf_otnotificacion.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_osf_otnotificacion.sql

prompt "src/gascaribe/ventas/procedimientos/ldc_job_flujo_numeracion_venta.sql"
@src/gascaribe/ventas/procedimientos/ldc_job_flujo_numeracion_venta.sql

prompt "src/gascaribe/cartera/negociacion-deuda/procedimiento/ldc_anularerrorflujo.sql"
@src/gascaribe/cartera/negociacion-deuda/procedimiento/ldc_anularerrorflujo.sql

prompt "src/gascaribe/servicios-nuevos/piloto-cesar/procedimientos/ldc_prfinalizaperiodogracia.sql"
@src/gascaribe/servicios-nuevos/piloto-cesar/procedimientos/ldc_prfinalizaperiodogracia.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/genifrs_dummy.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/genifrs_dummy.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_prldc_ordeeldorcd_act.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prldc_ordeeldorcd_act.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/gdc_prreparacionrp.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prreparacionrp.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldcbi_desbloquear.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcbi_desbloquear.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldcbi_grantinnovacion.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcbi_grantinnovacion.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_recuperaatributoscopia2.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_recuperaatributoscopia2.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_recuperaatributoscopia.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_recuperaatributoscopia.sql


prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_prliquidacontra.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prliquidacontra.sql

prompt "src/gascaribe/gestion-contratista/procedimientos/adm_person.ldc_prliquidacontra.sql"
@src/gascaribe/gestion-contratista/procedimientos/adm_person.ldc_prliquidacontra.sql

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_prliquidacontra.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_prliquidacontra.sql

prompt "src/gascaribe/atencion-usuarios/onbase/ldc_prfilltablonbase.sql"
@src/gascaribe/atencion-usuarios/onbase/ldc_prfilltablonbase.sql

prompt "src/gascaribe/atencion-usuarios/onbase/procedimientos/adm_person.ldc_prfilltablonbase.sql"
@src/gascaribe/atencion-usuarios/onbase/procedimientos/adm_person.ldc_prfilltablonbase.sql

prompt "src/gascaribe/atencion-usuarios/onbase/job/sinonimos/adm_person.ldc_prfilltablonbase.sql"
@src/gascaribe/atencion-usuarios/onbase/job/sinonimos/adm_person.ldc_prfilltablonbase.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_atiendesolicitud.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_atiendesolicitud.sql

prompt "src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_atiendesolicitud.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_atiendesolicitud.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_atiendesolicitud.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_atiendesolicitud.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_progeneranoveltyrangoxasig.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_progeneranoveltyrangoxasig.sql

prompt "src/gascaribe/gestion-contratista/procedimientos/adm_person.ldc_progeneranoveltyrangoxasig.sql"
@src/gascaribe/gestion-contratista/procedimientos/adm_person.ldc_progeneranoveltyrangoxasig.sql

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_progeneranoveltyrangoxasig.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_progeneranoveltyrangoxasig.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_progeneranoveltyredespos.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_progeneranoveltyredespos.sql

prompt "src/gascaribe/gestion-contratista/procedimientos/adm_person.ldc_progeneranoveltyredespos.sql"
@src/gascaribe/gestion-contratista/procedimientos/adm_person.ldc_progeneranoveltyredespos.sql

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_progeneranoveltyredespos.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_progeneranoveltyredespos.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_progeneranoveltyredes.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_progeneranoveltyredes.sql

prompt "src/gascaribe/gestion-contratista/procedimientos/adm_person.ldc_progeneranoveltyredes.sql"
@src/gascaribe/gestion-contratista/procedimientos/adm_person.ldc_progeneranoveltyredes.sql

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_progeneranoveltyredes.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_progeneranoveltyredes.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_prdepuralistamateriales.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prdepuralistamateriales.sql

prompt "src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_prdepuralistamateriales.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_prdepuralistamateriales.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prdepuralistamateriales.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prdepuralistamateriales.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldci_valid_metraje.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldci_valid_metraje.sql

prompt "src/gascaribe/gestion-ordenes/procedure/adm_person.ldci_valid_metraje.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldci_valid_metraje.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldci_valid_metraje.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldci_valid_metraje.sql

prompt "src/gascaribe/gestion-ordenes/procedure/ldc_unlock_orders.sql"
@src/gascaribe/gestion-ordenes/procedure/ldc_unlock_orders.sql

prompt "src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_unlock_orders.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_unlock_orders.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_unlock_orders.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_unlock_orders.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_prgeneraotnoti.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prgeneraotnoti.sql

prompt "src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prgeneraotnoti.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prgeneraotnoti.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prgeneraotnoti.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prgeneraotnoti.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2637_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-2637_actualizar_obj_migrados.sql

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