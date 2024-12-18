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

prompt  "src/gascaribe/papelera-reciclaje/procedimientos/temp.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/temp.sql

prompt  "src/gascaribe/papelera-reciclaje/schedules/temp_info.sql"
@src/gascaribe/papelera-reciclaje/schedules/temp_info.sql

prompt  "src/gascaribe/papelera-reciclaje/procedimientos/prvalidacausalcorrdefrp.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/prvalidacausalcorrdefrp.sql


prompt  "src/gascaribe/papelera-reciclaje/procedimientos/finanprioritygdc.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/finanprioritygdc.sql

prompt  "src/gascaribe/papelera-reciclaje/procedimientos/ldc_atentesolotfinrevper.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_atentesolotfinrevper.sql

prompt  "src/gascaribe/papelera-reciclaje/procedimientos/prusupromporperiodo.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/prusupromporperiodo.sql

prompt "src/gascaribe/predios/sinonimos/adm_person.ab_info_premise.sql"
@src/gascaribe/predios/sinonimos/adm_person.ab_info_premise.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.cc_bcsegmentconstants.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.cc_bcsegmentconstants.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.concplsu.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.concplsu.sql

prompt "src/gascaribe/general/sinonimos/adm_person.dage_items_seriado.sql"
@src/gascaribe/general/sinonimos/adm_person.dage_items_seriado.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.elemmedi.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.elemmedi.sql


prompt "src/gascaribe/cartera/sinonimo/adm_person.gc_coll_mgmt_pro_det.sql"
@src/gascaribe/cartera/sinonimo/adm_person.gc_coll_mgmt_pro_det.sql

prompt "src/gascaribe/general/sinonimos/adm_person.ge_bccalendar.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_bccalendar.sql

prompt "src/gascaribe/general/sinonimos/adm_person.ge_boconstants.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_boconstants.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_sectorope_zona.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_sectorope_zona.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.ldc_contrprome.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_contrprome.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_package_type_oper_unit.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_package_type_oper_unit.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prcreasigorden.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prcreasigorden.sql

prompt "src/gascaribe/cartera/liquidacion/sinonimos/adm_person.ldc_temp_gcoreca_hilos.sql"
@src/gascaribe/cartera/liquidacion/sinonimos/adm_person.ldc_temp_gcoreca_hilos.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tmp_fpordersdata.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tmp_fpordersdata.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tmp_or_order_gc.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tmp_or_order_gc.sql

prompt "src/gascaribe/general/sinonimos/adm_person.ldc_versionaplica.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_versionaplica.sql

prompt "src/gascaribe/general/sinonimos/adm_person.ldc_versionempresa.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_versionempresa.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.ld_tabconcpc.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ld_tabconcpc.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.ld_tabprodnotif.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ld_tabprodnotif.sql

prompt "src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.logpno_ehg.sql"
@src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.logpno_ehg.sql

prompt "src/gascaribe/cartera/Financiacion/sinonimos/adm_person.mecadife.sql"
@src/gascaribe/cartera/Financiacion/sinonimos/adm_person.mecadife.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_boconstants.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_boconstants.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_boordertransition.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_boordertransition.sql

prompt "src/gascaribe/cartera/sinonimo/adm_person.seq_gc_coll_mgmt_pr_275315.sql"
@src/gascaribe/cartera/sinonimo/adm_person.seq_gc_coll_mgmt_pr_275315.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.seqld_tabprodnotif.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.seqld_tabprodnotif.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.seqtracefgrcr.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.seqtracefgrcr.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.tasainte.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.tasainte.sql

prompt "src/gascaribe/general/sinonimos/adm_person.ut_date.sql"
@src/gascaribe/general/sinonimos/adm_person.ut_date.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.xtracefgrcr.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.xtracefgrcr.sql

prompt "src/gascaribe/cartera/liquidacion/procedimientos/xlogpno_ehg.sql"
@src/gascaribe/cartera/liquidacion/procedimientos/xlogpno_ehg.sql

prompt "src/gascaribe/cartera/liquidacion/procedimientos/adm_person.xlogpno_ehg.sql"
@src/gascaribe/cartera/liquidacion/procedimientos/adm_person.xlogpno_ehg.sql

prompt "src/gascaribe/cartera/liquidacion/sinonimos/adm_person.xlogpno_ehg.sql"
@src/gascaribe/cartera/liquidacion/sinonimos/adm_person.xlogpno_ehg.sql

prompt "src/gascaribe/cartera/liquidacion/procedimientos/procreasigoreca_hilos.sql"
@src/gascaribe/cartera/liquidacion/procedimientos/procreasigoreca_hilos.sql

prompt "src/gascaribe/cartera/liquidacion/procedimientos/adm_person.procreasigoreca_hilos.sql"
@src/gascaribe/cartera/liquidacion/procedimientos/adm_person.procreasigoreca_hilos.sql

prompt "src/gascaribe/cartera/liquidacion/sinonimos/adm_person.procreasigoreca_hilos.sql"
@src/gascaribe/cartera/liquidacion/sinonimos/adm_person.procreasigoreca_hilos.sql

prompt "src/gascaribe/cartera/liquidacion/procedimientos/procreasigoreca.sql"
@src/gascaribe/cartera/liquidacion/procedimientos/procreasigoreca.sql

prompt "src/gascaribe/cartera/liquidacion/procedimientos/adm_person.procreasigoreca.sql"
@src/gascaribe/cartera/liquidacion/procedimientos/adm_person.procreasigoreca.sql

prompt "src/gascaribe/cartera/liquidacion/sinonimos/adm_person.procreasigoreca.sql"
@src/gascaribe/cartera/liquidacion/sinonimos/adm_person.procreasigoreca.sql

prompt "src/gascaribe/servicios-asociados/plugin/cambiocategoriaprod.sql"
@src/gascaribe/servicios-asociados/plugin/cambiocategoriaprod.sql

prompt "src/gascaribe/servicios-asociados/plugin/adm_person.cambiocategoriaprod.sql"
@src/gascaribe/servicios-asociados/plugin/adm_person.cambiocategoriaprod.sql

prompt "src/gascaribe/servicios-asociados/sinonimos/adm_person.cambiocategoriaprod.sql"
@src/gascaribe/servicios-asociados/sinonimos/adm_person.cambiocategoriaprod.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/prvalldcreasco.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/prvalldcreasco.sql

prompt "src/gascaribe/cartera/procedimientos/adm_person.prvalldcreasco.sql"
@src/gascaribe/cartera/procedimientos/adm_person.prvalldcreasco.sql

prompt "src/gascaribe/cartera/sinonimo/adm_person.prvalldcreasco.sql"
@src/gascaribe/cartera/sinonimo/adm_person.prvalldcreasco.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/reprogramorderaction.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/reprogramorderaction.sql

prompt "src/gascaribe/gestion-ordenes/procedure/adm_person.reprogramorderaction.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.reprogramorderaction.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.reprogramorderaction.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.reprogramorderaction.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/updpropiedadseriado.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/updpropiedadseriado.sql

prompt "src/gascaribe/general/procedimientos/adm_person.updpropiedadseriado.sql"
@src/gascaribe/general/procedimientos/adm_person.updpropiedadseriado.sql

prompt "src/gascaribe/general/sinonimos/adm_person.updpropiedadseriado.sql"
@src/gascaribe/general/sinonimos/adm_person.updpropiedadseriado.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/sendmailconcept.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/sendmailconcept.sql

prompt "src/gascaribe/facturacion/procedimientos/adm_person.sendmailconcept.sql"
@src/gascaribe/facturacion/procedimientos/adm_person.sendmailconcept.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.sendmailconcept.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.sendmailconcept.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/xinsertfgrcr.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/xinsertfgrcr.sql

prompt "src/gascaribe/facturacion/procedimientos/adm_person.xinsertfgrcr.sql"
@src/gascaribe/facturacion/procedimientos/adm_person.xinsertfgrcr.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.xinsertfgrcr.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.xinsertfgrcr.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/lduspr.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/lduspr.sql

prompt "src/gascaribe/datafix/OSF-2535_updsa_executable_lduspr.sql"
@src/gascaribe/datafix/OSF-2535_updsa_executable_lduspr.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2535_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-2535_actualizar_obj_migrados.sql

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