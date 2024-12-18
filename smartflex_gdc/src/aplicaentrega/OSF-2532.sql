column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2532"
prompt "-----------------"


prompt "-----1.procedimiento LDC_PRABRIRACTACERRADA-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prabriractacerrada.sql" 
@src/gascaribe/actas/procedimientos/ldc_prabriractacerrada.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.seq_ct_process_log_109639.sql" 
@src/gascaribe/actas/sinonimos/adm_person.seq_ct_process_log_109639.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ct_process_log.sql" 
@src/gascaribe/actas/sinonimos/adm_person.ct_process_log.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldci_facteactasenv.sql" 
@src/gascaribe/actas/sinonimos/adm_person.ldci_facteactasenv.sql


prompt "--->Aplicando creacion de procedimiento adm_person.ldc_prabriractacerrada.sql" 
@src/gascaribe/actas/procedimientos/adm_person.ldc_prabriractacerrada.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prabriractacerrada.sql" 
@src/gascaribe/actas/sinonimos/adm_person.ldc_prabriractacerrada.sql


 
prompt "-----2.procedimiento LDC_PRCHANGEPLAN-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prchangeplan.sql" 
@src/gascaribe/facturacion/procedimientos/ldc_prchangeplan.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prchangeplan.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.cc_commercial_plan.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prchangeplan.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.cc_role.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prchangeplan.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.mo_bill_data_change.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prchangeplan.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_ccxcateg.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prchangeplan.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.cc_answer.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prchangeplan.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.mo_boattention.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prchangeplan.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ge_boparameter.sql


prompt "--->Aplicando creacion de procedimiento adm_person.ldc_prchangeplan.sql" 
@src/gascaribe/facturacion/procedimientos/adm_person.ldc_prchangeplan.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prchangeplan.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_prchangeplan.sql



prompt "-----3.procedimiento LDC_OS_INSERTFILEORDER-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_os_insertfileorder.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_os_insertfileorder.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.adm_person.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.cc_file.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.cc_bsattachfiles.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.cc_bsattachfiles.sql


prompt "--->Aplicando creacion de procedimiento adm_person.ldc_os_insertfileorder.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_os_insertfileorder.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_os_insertfileorder.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_os_insertfileorder.sql


 
prompt "-----4.procedimiento LDC_PLUVALCOOFER-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_pluvalcoofer.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_pluvalcoofer.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_const_unoprl.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_const_unoprl.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_const_unoprl.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_homoitmaitac.sql


prompt "--->Aplicando creacion de procedimiento adm_person.ldc_pluvalcoofer.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_pluvalcoofer.sql 


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_pluvalcoofer.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_pluvalcoofer.sql



prompt "-----5.procedimiento ldc_pluvalinstvsi-----" 
 
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_pluvalinstvsi.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_pluvalinstvsi.sql


prompt "--->Aplicando creacion de procedimiento adm_person.ldc_pluvalinstvsi.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_pluvalinstvsi.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_pluvalinstvsi.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_pluvalinstvsi.sql



prompt "-----6.procedimiento LDC_PPROCINFOESTABLEC-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_pprocinfoestablec.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_pprocinfoestablec.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prod_comerc_sector.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prod_comerc_sector.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ge_attributes_set.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_attributes_set.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ge_attributes.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_attributes.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.daldc_prod_comerc_sector.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_prod_comerc_sector.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.or_temp_data_values.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_temp_data_values.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.dage_attributes.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.dage_attributes.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_sector_comercial.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_sector_comercial.sql


prompt "--->Aplicando creacion de procedimiento adm_person.ldc_pprocinfoestablec.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_pprocinfoestablec.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_pprocinfoestablec.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_pprocinfoestablec.sql


 
prompt "-----7.procedimiento LDC_PR_VALIDA_ORDEN_30-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_pr_valida_orden_30.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_pr_valida_orden_30.sql


prompt "--->Aplicando creacion de procedimiento adm_person.ldc_pr_valida_orden_30.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_pr_valida_orden_30.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_pr_valida_orden_30.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_pr_valida_orden_30.sql



prompt "-----8.procedimiento LDC_PRACTUALIZACONDSATAB-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_practualizacondsatab.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_practualizacondsatab.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.sa_tab.sql" 
@src/gascaribe/general/sinonimos/adm_person.sa_tab.sql
 

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_actualiza_sa_tab.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_actualiza_sa_tab.sql
 

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.seterrordesc.sql" 
@src/gascaribe/general/sinonimos/adm_person.seterrordesc.sql
 

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_practualizacondsatab.sql" 
@src/gascaribe/general/procedimientos/adm_person.ldc_practualizacondsatab.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_practualizacondsatab.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_practualizacondsatab.sql
 


prompt "-----9.procedimiento LDC_PRACTUALIZAOTESDOC-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_practualizaotesdoc.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_practualizaotesdoc.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_docuorder.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_docuorder.sql
 

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ld_quota_block.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ld_quota_block.sql
 

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.au_bosystem.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.au_bosystem.sql
 

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_audocuorder.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_audocuorder.sql
 

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_practualizaotesdoc.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_practualizaotesdoc.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_practualizaotesdoc.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_practualizaotesdoc.sql
 


prompt "-----10.procedimiento LDC_PRBORRAMARCA-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prborramarca.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prborramarca.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_fncretornamarcaprod.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_fncretornamarcaprod.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prmarcaproductolog.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prmarcaproductolog.sql


prompt "--->Aplicando creacion de procedimiento adm_person.ldc_prborramarca.sql" 
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prborramarca.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prborramarca.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prborramarca.sql



prompt "-----11.procedimiento LDC_PRCAMBMEDIDORPREPAGO-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prcambmedidorprepago.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prcambmedidorprepago.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_pgeneratebillprep.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_pgeneratebillprep.sql


prompt "--->Aplicando creacion de procedimiento adm_person.ldc_prcambmedidorprepago.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_prcambmedidorprepago.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prcambmedidorprepago.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prcambmedidorprepago.sql



prompt "-----12.procedimiento LDC_PRCARGRECL-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prcargrecl.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prcargrecl.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_solprocjob.sql" 
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_solprocjob.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_reclamos.sql" 
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_reclamos.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.cargtram.sql" 
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cargtram.sql


prompt "--->Aplicando creacion de procedimiento adm_person.ldc_prcargrecl.sql" 
@src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldc_prcargrecl.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prcargrecl.sql" 
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_prcargrecl.sql



prompt "-----13.procedimiento LDC_PRCCOBUNIFITEM-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prccobunifitem.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prccobunifitem.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_aud_act_val_order.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_aud_act_val_order.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_itemcous.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_itemcous.sql


prompt "--->Aplicando creacion de procedimiento adm_person.ldc_prccobunifitem.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_prccobunifitem.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prccobunifitem.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prccobunifitem.sql



prompt "-----14.procedimiento LDC_PRCDEVCAUSOTSPAG-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prcdevcausotspag.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prcdevcausotspag.sql


prompt "--->Aplicando creacion de procedimiento adm_person.ldc_prcdevcausotspag.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_prcdevcausotspag.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prcdevcausotspag.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prcdevcausotspag.sql



prompt "-----15.procedimiento LDC_PRCLIENTERECLAMO-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N LDC_PRCLIENTERECLAMO.prc" 
@src/gascaribe/atencion-usuarios/valor-reclamo/procedimiento/LDC_PRCLIENTERECLAMO.prc


prompt "--->Aplicando creacion de procedimiento adm_person.ldc_prclientereclamo.sql" 
@src/gascaribe/atencion-usuarios/valor-reclamo/procedimiento/adm_person.ldc_prclientereclamo.sql


prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prclientereclamo.sql" 
@src/gascaribe/atencion-usuarios/valor-reclamo/sinonimos/adm_person.ldc_prclientereclamo.sql


prompt "-----OSF-2532_act_obj_mig-----" 
prompt "--->Aplicando script OSF-2532_act_obj_mig.sql" 
@src/gascaribe/datafix/OSF-2532_act_obj_mig.sql
show errors;


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-2180-----"
prompt "-----------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on


prompt "-----RECOMPILAR OBJETOS-----"
prompt "--->Aplicando recompilar objetos"
@src/test/recompilar-objetos.sql
show errors;