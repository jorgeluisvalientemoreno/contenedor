column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                         Aplicando Entrega OSF-2597                       "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "--------------------------------INICIO------------------------------------"
prompt "                                                                          "
prompt "----------- 1.PROCEDIMIENTO LDC_PROGENNOVOFERTSENSEVAESCA ----------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_progennovofertsensevaesca.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_progennovofertsensevaesca.sql
show errors;

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_actas_aplica_proc_ofert.sql " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_actas_aplica_proc_ofert.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_act_father_act_hija.sql    " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_act_father_act_hija.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_const_liqtarran.sql        " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_const_liqtarran.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_const_unoprl.sql           " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_const_unoprl.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_item_uo_lrl.sql            " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_item_uo_lrl.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_reporte_ofert_escalo.sql   " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_reporte_ofert_escalo.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando Sequence de secuencia adm_person.ldc_seqecalonado.sql       " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_seqecalonado.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_tipo_trab_x_nov_ofertados.sql  " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_tipo_trab_x_nov_ofertados.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_uni_act_ot.sql             " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_uni_act_ot.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_unid_oper_hija_mod_tar.sql " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_unid_oper_hija_mod_tar.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldc_progennovofertsensevaesca.sql " 
@src/gascaribe/actas/ofertados/adm_person.ldc_progennovofertsensevaesca.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldc_progennovofertsensevaesca.sql " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_progennovofertsensevaesca.sql
show errors;

prompt "                                                                          " 
prompt "----------- 2.PROCEDIMIENTO LDC_PROGOAVC ---------------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_progoavc.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_progoavc.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de paquete adm_person.ge_boconstants.sql           " 
@src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.ge_boconstants.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de paquete adm_person.or_boconstants.sql           " 
@src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.or_boconstants.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldc_progoavc.sql       " 
@src/gascaribe/perdidas-no-operacionales/procedimientos/adm_person.ldc_progoavc.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldc_progoavc.sql" 
@src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.ldc_progoavc.sql
show errors;

prompt "                                                                          "
prompt "----------- 3.PROCEDIMIENTO LDC_PROGRAMORDTOUNLOCK -----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_programordtounlock.sql " 
prompt " unicamente borrado "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_programordtounlock.sql
show errors;
prompt "                                                                          "

prompt "                                                                          " 
prompt "----------- 4.PROCEDIMIENTO LDC_PROGORDTOUNLOCKTRABVAR -------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_progordtounlocktrabvar.sql " 
prompt " unicamente borrado "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_progordtounlocktrabvar.sql
show errors;
prompt "                                                                          "

prompt "                                                                          " 
prompt "----------- 5.PROCEDIMIENTO LDC_UNLOCKORDERS -----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_unlockorders.sql " 
prompt " unicamente borrado "
@src/gascaribe/gestion-ordenes/procedure/ldc_unlockorders.sql
show errors;
prompt "                                                                          "

prompt "                                                                          " 
prompt "----------- 6.PROCEDIMIENTO LDC_PRVALMETROSHIJA --------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prvalmetroshija.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prvalmetroshija.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_ordenes_ofertados_redes.sql " 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_ordenes_ofertados_redes.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.adm_person.ldc_prvalmetroshija.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_prvalmetroshija.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.adm_person.ldc_prvalmetroshija.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prvalmetroshija.sql
show errors;


prompt "                                                                          " 
prompt "----------- 7.PROCEDIMIENTO LDC_PRVALPORDVENT ----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prvalpordvent.sql " 
prompt " unicamente borrado "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prvalpordvent.sql
show errors;
prompt "                                                                          "

prompt "                                                                          " 
prompt "----------- 8.PROCEDIMIENTO LDC_PBORDVENT --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_pbordvent.sql " 
prompt " unicamente borrado "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_pbordvent.sql
show errors;
prompt "                                                                          "

prompt "                                                                          "
prompt "----------- 9.PROCEDIMIENTO LDC_PRVISITAFALLLIDA -------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prvisitafalllida.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prvisitafalllida.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_cant_visita_fallida.sql     " 
@src/gascaribe/ventas/sinonimos/adm_person.ldc_cant_visita_fallida.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldc_prvisitafalllida.sql" 
@src/gascaribe/ventas/procedimientos/adm_person.ldc_prvisitafalllida.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nuevo procedimiento adm_person.ldc_prvisitafalllida.sql" 
@src/gascaribe/ventas/sinonimos/adm_person.ldc_prvisitafalllida.sql
show errors;

prompt "                                                                          " 
prompt "------------ 10.PROCEDIMIENTO LDC_VAINSLDSENDAUTHORI ---------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_vainsldsendauthori.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_vainsldsendauthori.sql
show errors;
prompt "                                                                          "
  
prompt "--->Aplicando sinonimo a tabla adm_person.ld_general_parameters.sql       " 
@src/gascaribe/general/sinonimos/adm_person.ld_general_parameters.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando sinonimo a tabla adm_person.ld_send_authorized.sql          " 
@src/gascaribe/general/sinonimos/adm_person.ld_send_authorized.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando creación de procedimiento adm_person.ldc_vainsldsendauthori.sql    " 
@src/gascaribe/general/procedimientos/adm_person.ldc_vainsldsendauthori.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando creación de sinonimo a nuevo procedimiento adm_person.ldc_vainsldsendauthori.sql    " 
@src/gascaribe/general/sinonimos/adm_person.ldc_vainsldsendauthori.sql
show errors;
prompt "                                                                          "  

prompt "                                                                          " 
prompt "------------ 11.PROCEDIMIENTO LDC_VALIDA_DATO_ADI_MED_ADIC ---------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_valida_dato_adi_med_adic.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_valida_dato_adi_med_adic.sql 
show errors;
prompt "                                                                          "
--

prompt "--->Aplicando sinonimo a paquete dage_items.sql                           " 
@src/gascaribe/actas/sinonimos/adm_person.dage_items.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.dage_items_seriado.sql        " 
@src/gascaribe/actas/sinonimos/adm_person.dage_items_seriado.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.daor_order_items.sql          " 
@src/gascaribe/actas/sinonimos/adm_person.daor_order_items.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_certificados_oia.sql        " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_certificados_oia.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.or_bcorderitems.sql           " 
@src/gascaribe/actas/sinonimos/adm_person.or_bcorderitems.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.or_boitemsmove.sql            " 
@src/gascaribe/actas/sinonimos/adm_person.or_boitemsmove.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.or_uni_item_bala_mov.sql        " 
@src/gascaribe/actas/sinonimos/adm_person.or_uni_item_bala_mov.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldc_valida_dato_adi_med_adic" 
@src/gascaribe/actas/procedimientos/adm_person.ldc_valida_dato_adi_med_adic.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldc_valida_dato_adi_med_adic.sql" 
@src/gascaribe/actas/sinonimos/adm_person.ldc_valida_dato_adi_med_adic.sql
show errors;

prompt "                                                                          " 
prompt "----------- 12.PROCEDIMIENTO LDC_VALIDA_FECHA_ASIGNACION -----------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_valida_fecha_asignacion.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_valida_fecha_asignacion.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldc_valida_fecha_asignacion.sql " 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_valida_fecha_asignacion.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldc_valida_fecha_asignacion.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_valida_fecha_asignacion.sql
show errors;


prompt "                                                                          " 
prompt "----------- 13.PROCEDIMIENTO LDC_VALIDA_ORASAR ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_valida_orasar.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_valida_orasar.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldc_valida_orasar.sql " 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_valida_orasar.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldc_valida_orasar.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_valida_orasar.sql
show errors;

prompt "                                                                          " 
prompt "----------- 14.PROCEDIMIENTO LDC_VALIDCHECKITEMS -------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_validcheckitems.sql" 
@src/gascaribe/general/procedimientos/ldc_validcheckitems.sql
show errors;
prompt "                                                                          "
  
prompt "--->Aplicando sinonimo a paquete adm_person.dage_directory.sql            " 
@src/gascaribe/general/sinonimos/adm_person.dage_directory.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando creación de procedimiento adm_person.ldc_validcheckitems.sql" 
@src/gascaribe/general/procedimientos/adm_person.ldc_validcheckitems.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando creación de sinonimo a nuevo procedimiento adm_person.ldc_validcheckitems.sql    " 
@src/gascaribe/general/sinonimos/adm_person.ldc_validcheckitems.sql
show errors;
prompt "                                                                          "  

prompt "                                                                          " 
prompt "------------ 15.PROCEDIMIENTO LDC_VALPERC_ORDCARGOCONEC ------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_valperc_ordcargoconec.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_valperc_ordcargoconec.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de procedimiento adm_person.ldc_valperc_ordcargoconec.sql" 
@src/gascaribe/facturacion/procedimientos/adm_person.ldc_valperc_ordcargoconec.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando creación de sinonimo a nuevo procedimiento adm_person.ldc_valperc_ordcargoconec.sql    " 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_valperc_ordcargoconec.sql
show errors;
prompt "                                                                          "  

prompt "                                                                          " 
prompt "------------ 16.PROCEDIMIENTO LDCDESENDNOTIFI ----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldcdesendnotifi.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldcdesendnotifi.sql
show errors;

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_user_noti.sql               " 
@src/gascaribe/general/sinonimos/adm_person.ldc_user_noti.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de procedimiento adm_person.ldcdesendnotifi.sql" 
@src/gascaribe/general/procedimientos/adm_person.ldcdesendnotifi.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando creación de sinonimo a nuevo procedimiento adm_person.ldcdesendnotifi.sql    " 
@src/gascaribe/general/sinonimos/adm_person.ldcdesendnotifi.sql
show errors;
prompt "                                                                          "  

prompt "                                                                          "
prompt "------------ 17.PROCEDIMIENTO LDCPLCONSREDEXTPOLSA -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldcplconsredextpolsa.sql " 
@src/gascaribe/papelera-reciclaje/procedimientos/ldcplconsredextpolsa.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.or_order_opeuni_chan.sql        " 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_order_opeuni_chan.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ge_comment_type.sql             " 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_comment_type.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.or_bofwlockorder.sql          " 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bofwlockorder.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.ut_date.sql                   " 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ut_date.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldcplconsredextpolsa   " 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldcplconsredextpolsa.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldcplconsredextpolsa.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcplconsredextpolsa.sql
show errors;

prompt "                                                                          " 
prompt "------------ 18.PROCEDIMIENTO LDCPROCDELETMARCAUSERCERTIFI ---------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldcprocdeletmarcausercertifi.sql " 
@src/gascaribe/papelera-reciclaje/procedimientos/ldcprocdeletmarcausercertifi.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a función adm_person.ldc_fncretornamarcaprod.sql     " 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_fncretornamarcaprod.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a procedimiento adm_person.ldc_prmarcaproductolog.sql    " 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prmarcaproductolog.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.pr_certificate.sql              " 
@src/gascaribe/revision-periodica/sinonimos/adm_person.pr_certificate.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldcprocdeletmarcausercertifi.sql" 
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldcprocdeletmarcausercertifi.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldcprocdeletmarcausercertifi.sql " 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcprocdeletmarcausercertifi.sql
show errors;

prompt "                                                                          " 
prompt "------------ 19.PROCEDIMIENTO PR_UPDATE_DATA_INSURED ---------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N pr_update_data_insured.sql " 
@src/gascaribe/papelera-reciclaje/procedimientos/pr_update_data_insured.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_log_update_insured.sql      " 
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ldc_log_update_insured.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a secuencia adm_person.seq_ldc_log_update_insured.sql    " 
@src/gascaribe/fnb/seguros/sinonimos/adm_person.seq_ldc_log_update_insured.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.pr_update_data_insured.sql" 
@src/gascaribe/fnb/seguros/procedimientos/adm_person.pr_update_data_insured.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.pr_update_data_insured.sql " 
@src/gascaribe/fnb/seguros/sinonimos/adm_person.pr_update_data_insured.sql
show errors;

prompt "                                                                          " 
prompt "------------ 20.PROCEDIMIENTO PROCESSLIQCONTRADMIN ----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N processliqcontradmin.sql " 
@src/gascaribe/papelera-reciclaje/procedimientos/processliqcontradmin.sql
show errors;
prompt "                                                                          "

prompt "                                                                          " 
prompt "------------ 21.PROCEDIMIENTO PROCGENERAASIGNACION1 ----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N procgeneraasignacion1.sql" 
prompt " unicamente borrado "
@src/gascaribe/papelera-reciclaje/procedimientos/procgeneraasignacion1.sql 
show errors;
prompt "                                                                          "

prompt "                                                                          " 
prompt "------------ APLICAR DATA FIX --------------------------------------------" 
prompt "                                                                          " 
prompt "-------------- BORRAR DATOS EN LDC_PROCEDIMIENTO_OBJ ---------------------"  
prompt "                                                                          "

prompt "--->Aplicando borrado de datos del LDC_PROGRAMORDTOUNLOCK OSF-2597_BorrarRegistrosProcEjec_ldc_programordtounlock.sql" 
@src/gascaribe/datafix/OSF-2597_BorrarRegistrosProcEjec_ldc_programordtounlock.sql
show errors;

prompt "                                                                          "
prompt "--->Aplicando borrado de datos del LDC_PROGORDTOUNLOCKTRABVAR OSF-2597_BorrarRegistrosProcEjec_ldc_progordtounlocktrabvar.sql" 
@src/gascaribe/datafix/OSF-2597_BorrarRegistrosProcEjec_ldc_progordtounlocktrabvar.sql
show errors;

prompt "                                                                          " 
prompt "-------------- BORRAR REGISTROS EN GE_OBJECT -----------------------------" 
prompt "                                                                          "
prompt "--->Aplicando borrado de datos del LDC_UNLOCKORDERS GE_OBJECT_121249.sql" 
@src/gascaribe/papelera-reciclaje/fwcob/GE_OBJECT_121249.sql
show errors;

prompt "                                                                          " 
prompt "------------  BORRAR JOB PROCGENERAASIGNACION1 ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de JOB OSF-2597_BorrarJOBProcGeneraasignacion1.sql" 
@src/gascaribe/datafix/OSF-2597_BorrarJOBProcGeneraasignacion1.sql
show errors;

prompt "                                                                          " 
prompt "------------- INGRESAR REGISTRO MASTER_PERSONALIZACIONES -----------------" 
prompt "                                                                          "
 
prompt "--->Aplicando inserción de objeto en MASTER_PERSONALIZACIONES             "
@src/gascaribe/datafix/OSF_2597_InsertMasterPersonalizaciones.sql
show errors;

prompt "                                                                          " 
prompt "------------- ACTUALIZAR REGISTRO MASTER_PERSONALIZACIONES ---------------" 
prompt "                                                                          "

prompt "--->Aplicando actualización de objetos migrados en MASTER_PERSONALIZACIONES"
@src/gascaribe/datafix/OSF-2597_actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2597                           "
prompt "--------------------------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso Aplica Entrega!!
set timing off
set serveroutput off
set define on

prompt "                                                                          "
prompt "---------------------------RECOMPILAR OBJETOS-----------------------------"
prompt "                                                                          "

prompt "--->Aplicando recompilar objetos"
@src/test/recompilar-objetos.sql
show errors;
quit
/