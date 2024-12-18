column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2776"
prompt "-----------------"

prompt "-----paquete DALDC_CLIENTE_ESPECIAL-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_cliente_especial.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_cliente_especial.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_cliente_especial.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_cliente_especial.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_cliente_especial.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.daldc_cliente_especial.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_cliente_especial.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.daldc_cliente_especial.sql


prompt "-----paquete DALDC_AUDIT_CHEQ_PROY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_audit_cheq_proy.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_audit_cheq_proy.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_audit_cheq_proy.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_audit_cheq_proy.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_audit_cheq_proy.sql"
@src/gascaribe/facturacion/paquetes/adm_person.daldc_audit_cheq_proy.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_audit_cheq_proy.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.daldc_audit_cheq_proy.sql


prompt "-----paquete DALDC_CARGPERI-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_cargperi.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_cargperi.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_cargperi.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_cargperi.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_cargperi.sql"
@src/gascaribe/facturacion/paquetes/adm_person.daldc_cargperi.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_cargperi.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.daldc_cargperi.sql


prompt "-----paquete DALDC_CHEQUES_PROYECTO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_cheques_proyecto.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_cheques_proyecto.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_cheques_proyecto.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_cheques_proyecto.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_cheques_proyecto.sql"
@src/gascaribe/facturacion/paquetes/adm_person.daldc_cheques_proyecto.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_cheques_proyecto.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.daldc_cheques_proyecto.sql


prompt "-----paquete DALDC_CUOTAS_ADICIONALES-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_cuotas_adicionales.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_cuotas_adicionales.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_cuotas_adicionales.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_cuotas_adicionales.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_cuotas_adicionales.sql"
@src/gascaribe/facturacion/paquetes/adm_person.daldc_cuotas_adicionales.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_cuotas_adicionales.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.daldc_cuotas_adicionales.sql


prompt "-----paquete DALDC_CUOTAS_PROYECTO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_cuotas_proyecto.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_cuotas_proyecto.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_cuotas_proyecto.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_cuotas_proyecto.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_cuotas_proyecto.sql"
@src/gascaribe/facturacion/paquetes/adm_person.daldc_cuotas_proyecto.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_cuotas_proyecto.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.daldc_cuotas_proyecto.sql


prompt "-----paquete DALDC_BINE_HOMECENTER-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_bine_homecenter.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_bine_homecenter.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_bine_homecenter.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_bine_homecenter.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_bine_homecenter.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_bine_homecenter.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_bine_homecenter.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_bine_homecenter.sql


prompt "-----paquete DALDC_CONSOLID_COTIZACION-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_consolid_cotizacion.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_consolid_cotizacion.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_consolid_cotizacion.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_consolid_cotizacion.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_consolid_cotizacion.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_consolid_cotizacion.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_consolid_cotizacion.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_consolid_cotizacion.sql


prompt "-----paquete DALDC_DETALLE_MET_COTIZ-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_detalle_met_cotiz.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_detalle_met_cotiz.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_detalle_met_cotiz.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_detalle_met_cotiz.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_detalle_met_cotiz.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_detalle_met_cotiz.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_detalle_met_cotiz.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_detalle_met_cotiz.sql


prompt "-----paquete DALDC_FNB_COMMENT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_fnb_comment.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_fnb_comment.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_fnb_comment.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_fnb_comment.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_fnb_comment.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_fnb_comment.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_fnb_comment.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_fnb_comment.sql


prompt "-----paquete DALDC_FNB_DELIVER_DATE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_fnb_deliver_date.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_fnb_deliver_date.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_fnb_deliver_date.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_fnb_deliver_date.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_fnb_deliver_date.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_fnb_deliver_date.sql


prompt "-----paquete DALDC_FNB_SUBS_BLOCK-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_fnb_subs_block.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_fnb_subs_block.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_fnb_subs_block.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_fnb_subs_block.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_fnb_subs_block.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_fnb_subs_block.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_fnb_subs_block.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_fnb_subs_block.sql


prompt "-----paquete DALDC_FNB_VSI-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_fnb_vsi.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_fnb_vsi.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_fnb_vsi.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_fnb_vsi.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_fnb_vsi.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_fnb_vsi.sql


prompt "-----paquete DALDC_IMPRDOCU-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_imprdocu.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_imprdocu.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_imprdocu.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_imprdocu.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_imprdocu.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_imprdocu.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_imprdocu.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_imprdocu.sql


prompt "-----paquete DALDC_INSTAL_GASODOM_FNB-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_instal_gasodom_fnb.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_instal_gasodom_fnb.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_instal_gasodom_fnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_instal_gasodom_fnb.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_instal_gasodom_fnb.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_instal_gasodom_fnb.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_instal_gasodom_fnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_instal_gasodom_fnb.sql


prompt "-----paquete DALDC_INVOICE_FNB_SALES-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_invoice_fnb_sales.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_invoice_fnb_sales.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_invoice_fnb_sales.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_invoice_fnb_sales.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_invoice_fnb_sales.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_invoice_fnb_sales.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_invoice_fnb_sales.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_invoice_fnb_sales.sql


prompt "-----paquete DALDC_ITEMS_COTIZ_PROY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_items_cotiz_proy.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_items_cotiz_proy.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_items_cotiz_proy.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_items_cotiz_proy.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_items_cotiz_proy.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_items_cotiz_proy.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_items_cotiz_proy.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_items_cotiz_proy.sql


prompt "-----paquete DALDC_ITEMS_COTIZACION_COM-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_items_cotizacion_com.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_items_cotizacion_com.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_items_cotizacion_com.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_items_cotizacion_com.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_items_cotizacion_com.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_items_cotizacion_com.sql


prompt "-----paquete DALDC_ITEMS_METRAJE_COT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_items_metraje_cot.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_items_metraje_cot.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_items_metraje_cot.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_items_metraje_cot.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_items_metraje_cot.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_items_metraje_cot.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_items_metraje_cot.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_items_metraje_cot.sql


prompt "-----paquete DALDC_ITEMS_POR_UNID_PRED-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_items_por_unid_pred.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_items_por_unid_pred.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_items_por_unid_pred.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_items_por_unid_pred.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_items_por_unid_pred.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_items_por_unid_pred.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_items_por_unid_pred.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_items_por_unid_pred.sql


prompt "-----paquete DALDC_ACTCALLCENTER-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_actcallcenter.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_actcallcenter.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_actcallcenter.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_actcallcenter.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_actcallcenter.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_actcallcenter.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_actcallcenter.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_actcallcenter.sql


prompt "-----paquete DALDC_ATTRADDACCOUNTSENTITY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_attraddaccountsentity.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_attraddaccountsentity.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_attraddaccountsentity.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_attraddaccountsentity.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_attraddaccountsentity.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_attraddaccountsentity.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_attraddaccountsentity.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_attraddaccountsentity.sql


prompt "-----paquete DALDC_CONDBLOQASIG-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_condbloqasig.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_condbloqasig.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_condbloqasig.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_condbloqasig.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_condbloqasig.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_condbloqasig.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_condbloqasig.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_condbloqasig.sql


prompt "-----paquete DALDC_EQUIVAL_UNID_PRED-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_equival_unid_pred.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_equival_unid_pred.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_equival_unid_pred.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_equival_unid_pred.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_equival_unid_pred.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_equival_unid_pred.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_equival_unid_pred.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_equival_unid_pred.sql


prompt "-----paquete DALDC_INFO_PREDIO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_info_predio.sql"
@src/gascaribe/predios/paquetes/daldc_info_predio.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_info_predio.sql"
@src/gascaribe/predios/sinonimos/adm_person.ldc_info_predio.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_info_predio.sql"
@src/gascaribe/predios/paquetes/adm_person.daldc_info_predio.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_info_predio.sql"
@src/gascaribe/predios/sinonimos/adm_person.daldc_info_predio.sql


prompt "-----Script OSF-2776_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2776_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2776-----"
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
