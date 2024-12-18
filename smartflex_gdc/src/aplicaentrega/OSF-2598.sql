column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2598"
prompt "-----------------"

 
prompt "-----1.procedimiento LDCLEGGENNOT_TEMP-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldcleggennot_temp.sql" 
@src/gascaribe/atencion-usuarios/procedimientos/ldcleggennot_temp.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ge_calendar.sql" 
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ge_calendar.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldcleggennot_temp.sql" 
@src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldcleggennot_temp.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldcleggennot_temp.sql" 
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldcleggennot_temp.sql


prompt "-----2.procedimiento LDC_PROCIERRAOTVISITACERTI-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_procierraotvisitacerti.sql" 
@src/gascaribe/revision-periodica/procedimientos/ldc_procierraotvisitacerti.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.log_ldc_procierraotvisitacerti.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.log_ldc_procierraotvisitacerti.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_procierraotvisitacerti.sql" 
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_procierraotvisitacerti.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_procierraotvisitacerti.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_procierraotvisitacerti.sql


prompt "-----3.procedimiento LDC_PROCREATRAMITECERTI-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_procreatramitecerti.sql" 
@src/gascaribe/revision-periodica/plugin/ldc_procreatramitecerti.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_procreatramitecerti.sql" 
@src/gascaribe/revision-periodica/plugin/adm_person.ldc_procreatramitecerti.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_procreatramitecerti.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_procreatramitecerti.sql


prompt "-----4.procedimiento PROCESSVARACTANOVE-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N processvaractanove.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/processvaractanove.sql


prompt "-----5.procedimiento LDC_PROCNOUORT-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_procnouort.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procnouort.sql


prompt "-----6.procedimiento LDC_CLOSEORDER-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_closeorder.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_closeorder.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.or_bcregeneraactivid.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bcregeneraactivid.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.or_bobasicdataservices.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bobasicdataservices.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.or_borelatedorder.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_borelatedorder.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_execactionbytryleg.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_execactionbytryleg.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.changestatus.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.changestatus.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_closeorder.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_closeorder.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_closeorder.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_closeorder.sql


prompt "-----7.procedimiento LDC_NOTIFICA_CIERRE_OT-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N .sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_notifica_cierre_ot.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_confncor.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_confncor.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_notif_packtype.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_notif_packtype.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_notifica_cierre_ot.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_notifica_cierre_ot.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_notifica_cierre_ot.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_notifica_cierre_ot.sql


prompt "-----8.procedimiento LDC_PRFILLOTREVDET-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prfillotrevdet.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prfillotrevdet.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_otrev.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_otrev.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_prfillotrevdet.sql" 
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prfillotrevdet.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prfillotrevdet.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prfillotrevdet.sql


prompt "-----9.procedimiento LDC_PROVALIQNOLEGAXORCAO-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_provaliqnolegaxorcao.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_provaliqnolegaxorcao.sql


prompt "-----10.procedimiento LDC_PRREGISTRAORDEN-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prregistraorden.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prregistraorden.sql

prompt "--->Aplicando borrado de tabla ldc_dat_orden_trabajo.sql" 
@src/gascaribe/papelera-reciclaje/tablas/ldc_dat_orden_trabajo.sql

prompt "--->Aplicando borrado de tabla ldc_dat_orden_trabajo.sql" 
@src/gascaribe/papelera-reciclaje/dbms_jobs/425323.sql


prompt "-----11.procedimiento LDC_UPDATE_GRACE_PERIOD-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_update_grace_period.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_update_grace_period.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.dald_detail_liquidation.sql" 
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_detail_liquidation.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.dacc_grace_peri_defe.sql" 
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dacc_grace_peri_defe.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_pkcrmtramisegbri.sql" 
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ldc_pkcrmtramisegbri.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_update_grace_period.sql" 
@src/gascaribe/fnb/seguros/procedimientos/adm_person.ldc_update_grace_period.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_update_grace_period.sql" 
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ldc_update_grace_period.sql


prompt "-----12.procedimiento LDC_VAL_CAUS_PACK_TYPE-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_val_caus_pack_type.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_val_caus_pack_type.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_caus_pack_type.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_caus_pack_type.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_val_caus_pack_type.sql" 
@src/gascaribe/general/procedimientos/adm_person.ldc_val_caus_pack_type.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_val_caus_pack_type.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_val_caus_pack_type.sql


prompt "-----13.procedimiento ldc_val_susp_defect-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_val_susp_defect.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_val_susp_defect.sql


prompt "-----14.procedimiento LDCPROCESCAMBIOFELEOT-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldcprocescambiofeleot.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldcprocescambiofeleot.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_au_cflot.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_au_cflot.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_cott_cflo.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_cott_cflo.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldcprocescambiofeleot.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldcprocescambiofeleot.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldcprocescambiofeleot.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcprocescambiofeleot.sql


prompt "-----15.procedimiento PR_UPDATE_VALUE_COTI-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N pr_update_value_coti.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/pr_update_value_coti.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_itemadicinte_ldcriaic.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_itemadicinte_ldcriaic.sql

prompt "--->Aplicando creacion de procedimiento adm_person.pr_update_value_coti.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.pr_update_value_coti.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.pr_update_value_coti.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pr_update_value_coti.sql


prompt "-----16.procedimiento PROCESSESOLICITUD-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N processesolicitud.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/processesolicitud.sql


prompt "-----17.procedimiento PR_VALID_INCLUD_MAT-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N pr_valid_includ_mat.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/pr_valid_includ_mat.sql

prompt "--->Aplicando creacion de procedimiento adm_person.pr_valid_includ_mat.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.pr_valid_includ_mat.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.pr_valid_includ_mat.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pr_valid_includ_mat.sql



prompt "-----Script OSF-2598_actualizar_obj_migrados-----" 

@src/gascaribe/datafix/OSF-2598_actualizar_obj_migrados.sql


prompt "-----Script OSF-2598_del_reg_ldc_procedimiento_obj.sql-----" 

@src/gascaribe/datafix/OSF-2598_del_reg_ldc_procedimiento_obj.sql
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