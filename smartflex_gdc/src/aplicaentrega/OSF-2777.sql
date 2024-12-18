column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2777"
prompt "-----------------"

prompt "-----paquete DAPE_ECO_ACT_CONTRACT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dape_eco_act_contract.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dape_eco_act_contract.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pe_eco_act_contract.sql"
@src/gascaribe/actas/sinonimos/adm_person.pe_eco_act_contract.sql

prompt "--->Aplicando creacion de paquete adm_person.dape_eco_act_contract.sql"
@src/gascaribe/actas/paquetes/adm_person.dape_eco_act_contract.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dape_eco_act_contract.sql"
@src/gascaribe/actas/sinonimos/adm_person.dape_eco_act_contract.sql


prompt "-----paquete DALDC_VENTA_EMPAQUETADA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_venta_empaquetada.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_venta_empaquetada.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_venta_empaquetada.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_venta_empaquetada.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_venta_empaquetada.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.daldc_venta_empaquetada.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_venta_empaquetada.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.daldc_venta_empaquetada.sql


prompt "-----paquete DALDC_VENTA_ESTUFA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_venta_estufa.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_venta_estufa.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_venta_estufa.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_venta_estufa.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_venta_estufa.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.daldc_venta_estufa.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_venta_estufa.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.daldc_venta_estufa.sql


prompt "-----paquete DALD_APPROVE_SALES_ORDER-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_approve_sales_order.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_approve_sales_order.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_approve_sales_order.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ld_approve_sales_order.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_approve_sales_order.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.dald_approve_sales_order.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_approve_sales_order.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.dald_approve_sales_order.sql


prompt "-----paquete DALDC_SUSP_PERSECUCION-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_susp_persecucion.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_susp_persecucion.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_susp_persecucion.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_susp_persecucion.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_susp_persecucion.sql"
@src/gascaribe/cartera/paquetes/adm_person.daldc_susp_persecucion.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_susp_persecucion.sql"
@src/gascaribe/cartera/sinonimo/adm_person.daldc_susp_persecucion.sql


prompt "-----paquete DALDC_PERILOGC-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_perilogc.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_perilogc.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_perilogc.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_perilogc.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_perilogc.sql"
@src/gascaribe/facturacion/paquetes/adm_person.daldc_perilogc.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_perilogc.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.daldc_perilogc.sql


prompt "-----paquete DALDC_TEMP_BILL_ACUM-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_temp_bill_acum.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_temp_bill_acum.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_temp_bill_acum.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_temp_bill_acum.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_temp_bill_acum.sql"
@src/gascaribe/facturacion/paquetes/adm_person.daldc_temp_bill_acum.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_temp_bill_acum.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.daldc_temp_bill_acum.sql


prompt "-----paquete DALDC_METRAJE_PISO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_metraje_piso.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_metraje_piso.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_metraje_piso.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_metraje_piso.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_metraje_piso.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_metraje_piso.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_metraje_piso.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_metraje_piso.sql


prompt "-----paquete DALDC_METRAJE_TIPO_UNID_PRED-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_metraje_tipo_unid_pred.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_metraje_tipo_unid_pred.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_metraje_tipo_unid_pred.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_metraje_tipo_unid_pred.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_metraje_tipo_unid_pred.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_metraje_tipo_unid_pred.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_metraje_tipo_unid_pred.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_metraje_tipo_unid_pred.sql


prompt "-----paquete DALDC_PISO_PROYECTO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_piso_proyecto.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_piso_proyecto.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_piso_proyecto.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_piso_proyecto.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_piso_proyecto.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_piso_proyecto.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_piso_proyecto.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_piso_proyecto.sql


prompt "-----paquete DALDC_PKG_OR_ITEM-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_pkg_or_item.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_pkg_or_item.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_pkg_or_item.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_pkg_or_item.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_pkg_or_item.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_pkg_or_item.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_pkg_or_item.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_pkg_or_item.sql


prompt "-----paquete DALDC_TIPO_UNID_PRED_PROY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_tipo_unid_pred_proy.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_tipo_unid_pred_proy.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_tipo_unid_pred_proy.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_tipo_unid_pred_proy.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_tipo_unid_pred_proy.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_tipo_unid_pred_proy.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_tipo_unid_pred_proy.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_tipo_unid_pred_proy.sql


prompt "-----paquete DALDC_TIPO_VIVIENDA_CONT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_tipo_vivienda_cont.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_tipo_vivienda_cont.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_tipo_vivienda_cont.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_tipo_vivienda_cont.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_tipo_vivienda_cont.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_tipo_vivienda_cont.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_tipo_vivienda_cont.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_tipo_vivienda_cont.sql


prompt "-----paquete DALDC_TIPOCAUSALCARDIF-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_tipocausalcardif.sql"
@src/gascaribe/fnb/seguros/cardif/paquetes/daldc_tipocausalcardif.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_tipocausalcardif.sql"
@src/gascaribe/fnb/seguros/cardif/sinonimos/adm_person.ldc_tipocausalcardif.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_tipocausalcardif.sql"
@src/gascaribe/fnb/seguros/cardif/paquetes/adm_person.daldc_tipocausalcardif.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_tipocausalcardif.sql"
@src/gascaribe/fnb/seguros/cardif/sinonimos/adm_person.daldc_tipocausalcardif.sql


prompt "-----paquete DALDC_PREMISE_WARRANTY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_premise_warranty.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_premise_warranty.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_premise_warranty.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_premise_warranty.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_premise_warranty.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_premise_warranty.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_premise_warranty.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_premise_warranty.sql


prompt "-----paquete DALDC_LOTES_ORDENES-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_lotes_ordenes.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_lotes_ordenes.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_lotes_ordenes.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_lotes_ordenes.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_lotes_ordenes.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_lotes_ordenes.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_lotes_ordenes.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_lotes_ordenes.sql


prompt "-----paquete DALDC_ORDENES_DOCU-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_ordenes_docu.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_ordenes_docu.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_ordenes_docu.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_ordenes_docu.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_ordenes_docu.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_ordenes_docu.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_ordenes_docu.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_ordenes_docu.sql


prompt "-----paquete DALDC_TIPOS_TRABAJO_COT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_tipos_trabajo_cot.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_tipos_trabajo_cot.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_tipos_trabajo_cot.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tipos_trabajo_cot.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_tipos_trabajo_cot.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_tipos_trabajo_cot.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_tipos_trabajo_cot.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_tipos_trabajo_cot.sql


prompt "-----paquete DALDC_TIPOTRAB_COTI_COM-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_tipotrab_coti_com.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_tipotrab_coti_com.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_tipotrab_coti_com.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_tipotrab_coti_com.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_tipotrab_coti_com.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_tipotrab_coti_com.sql


prompt "-----paquete DALDC_TORRES_PROYECTO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_torres_proyecto.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_torres_proyecto.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_torres_proyecto.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_torres_proyecto.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_torres_proyecto.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_torres_proyecto.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_torres_proyecto.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_torres_proyecto.sql


prompt "-----paquete DALDC_UNIDAD_PREDIAL-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_unidad_predial.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_unidad_predial.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_unidad_predial.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_unidad_predial.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_unidad_predial.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_unidad_predial.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_unidad_predial.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_unidad_predial.sql


prompt "-----paquete DALDC_UO_BYTIPOINC-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_uo_bytipoinc.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_uo_bytipoinc.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_uo_bytipoinc.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_uo_bytipoinc.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_uo_bytipoinc.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_uo_bytipoinc.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_uo_bytipoinc.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_uo_bytipoinc.sql


prompt "-----paquete DALDC_UO_TRASLADO_PAGO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_uo_traslado_pago.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_uo_traslado_pago.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_uo_traslado_pago.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_uo_traslado_pago.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_uo_traslado_pago.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_uo_traslado_pago.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_uo_traslado_pago.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_uo_traslado_pago.sql


prompt "-----paquete DALDC_VAL_FIJOS_UNID_PRED-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_val_fijos_unid_pred.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_val_fijos_unid_pred.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_val_fijos_unid_pred.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_val_fijos_unid_pred.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_val_fijos_unid_pred.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_val_fijos_unid_pred.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_val_fijos_unid_pred.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_val_fijos_unid_pred.sql


prompt "-----paquete DALDC_VALOR_ADICIONAL_PROY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_valor_adicional_proy.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_valor_adicional_proy.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_valor_adicional_proy.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_valor_adicional_proy.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_valor_adicional_proy.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_valor_adicional_proy.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_valor_adicional_proy.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_valor_adicional_proy.sql


prompt "-----Script OSF-2777_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2777_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2777-----"
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
