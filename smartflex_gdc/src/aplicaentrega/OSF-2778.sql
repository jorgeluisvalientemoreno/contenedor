column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2778"
prompt "-----------------"

prompt "-----paquete DALDC_ACTAS_PROYECTO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_actas_proyecto.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_actas_proyecto.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_actas_proyecto.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_actas_proyecto.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_actas_proyecto.sql"
@src/gascaribe/actas/paquetes/adm_person.daldc_actas_proyecto.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_actas_proyecto.sql"
@src/gascaribe/actas/sinonimos/adm_person.daldc_actas_proyecto.sql


prompt "-----paquete DALDC_ANTIC_CONTR-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_antic_contr.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_antic_contr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_antic_contr.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_antic_contr.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_antic_contr.sql"
@src/gascaribe/actas/paquetes/adm_person.daldc_antic_contr.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_antic_contr.sql"
@src/gascaribe/actas/sinonimos/adm_person.daldc_antic_contr.sql


prompt "-----paquete DALD_BILL_PENDING_PAYMENT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_bill_pending_payment.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_bill_pending_payment.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_bill_pending_payment.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ld_bill_pending_payment.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_bill_pending_payment.sql"
@src/gascaribe/facturacion/paquetes/adm_person.dald_bill_pending_payment.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_bill_pending_payment.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.dald_bill_pending_payment.sql


prompt "-----paquete DALD_DETAIL_LIQUIDATION-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_detail_liquidation.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_detail_liquidation.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_detail_liquidation.sql"
@src/gascaribe/facturacion/paquetes/adm_person.dald_detail_liquidation.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_detail_liquidation.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.dald_detail_liquidation.sql


prompt "-----paquete DALD_BINE_OLIMPICA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_bine_olimpica.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_bine_olimpica.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_bine_olimpica.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bine_olimpica.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_bine_olimpica.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_bine_olimpica.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_bine_olimpica.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_bine_olimpica.sql


prompt "-----paquete DALD_CONSTRUCT_UNIT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_construct_unit.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_construct_unit.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_construct_unit.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_construct_unit.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_construct_unit.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_construct_unit.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_construct_unit.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_construct_unit.sql


prompt "-----paquete DALD_CONVENT_EXITO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_convent_exito.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_convent_exito.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_convent_exito.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_convent_exito.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_convent_exito.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_convent_exito.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_convent_exito.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_convent_exito.sql


prompt "-----paquete DALD_FNB_SALE_FI_CON-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_fnb_sale_fi_con.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_fnb_sale_fi_con.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_fnb_sale_fi_con.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_fnb_sale_fi_con.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_fnb_sale_fi_con.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_fnb_sale_fi_con.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_fnb_sale_fi_con.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_fnb_sale_fi_con.sql


prompt "-----paquete DALD_LOG_FILE_FNB-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_log_file_fnb.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_log_file_fnb.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_log_file_fnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_log_file_fnb.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_log_file_fnb.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_log_file_fnb.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_log_file_fnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_log_file_fnb.sql


prompt "-----paquete DALD_PRICE_LIST-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_price_list.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_price_list.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_price_list.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_price_list.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_price_list.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_price_list.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_price_list.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_price_list.sql


prompt "-----paquete DALD_ROLLOVER_QUOTA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_rollover_quota.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_rollover_quota.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_rollover_quota.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_rollover_quota.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_rollover_quota.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_rollover_quota.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_rollover_quota.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_rollover_quota.sql


prompt "-----paquete DALD_SALES_WITHOUTSUBSIDY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_sales_withoutsubsidy.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_sales_withoutsubsidy.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_sales_withoutsubsidy.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_sales_withoutsubsidy.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_sales_withoutsubsidy.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_sales_withoutsubsidy.sql


prompt "-----paquete DALD_SAMPLE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_sample.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_sample.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_sample.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_sample.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_sample.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_sample.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_sample.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_sample.sql


prompt "-----paquete DALD_SIMULATED_QUOTA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_simulated_quota.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_simulated_quota.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_simulated_quota.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_simulated_quota.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_simulated_quota.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_simulated_quota.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_simulated_quota.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_simulated_quota.sql


prompt "-----paquete DALD_SPONSOR-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_sponsor.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_sponsor.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_sponsor.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_sponsor.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_sponsor.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_sponsor.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_sponsor.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_sponsor.sql


prompt "-----paquete DALDC_AUDIT_CUOT_PROY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_audit_cuot_proy.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_audit_cuot_proy.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_audit_cuot_proy.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_audit_cuot_proy.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_audit_cuot_proy.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_audit_cuot_proy.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_audit_cuot_proy.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_audit_cuot_proy.sql


prompt "-----paquete DALDC_TIPO_RESPUESTA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_tipo_respuesta.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_tipo_respuesta.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_tipo_respuesta.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_tipo_respuesta.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_tipo_respuesta.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_tipo_respuesta.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_tipo_respuesta.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_tipo_respuesta.sql


prompt "-----paquete DALD_BRAND-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_brand.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_brand.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_brand.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_brand.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_brand.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_brand.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_brand.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_brand.sql


prompt "-----paquete DALD_CONSULT_CODES-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_consult_codes.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_consult_codes.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_consult_codes.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_consult_codes.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_consult_codes.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_consult_codes.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_consult_codes.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_consult_codes.sql


prompt "-----paquete DALD_POLICY_EXCLUSION-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_policy_exclusion.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_policy_exclusion.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_policy_exclusion.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_policy_exclusion.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_policy_exclusion.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_policy_exclusion.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_policy_exclusion.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_policy_exclusion.sql


prompt "-----paquete DALDC_EQUI_PACKTYPE_SSPD-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_equi_packtype_sspd.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_equi_packtype_sspd.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_equi_packtype_sspd.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_equi_packtype_sspd.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_equi_packtype_sspd.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_equi_packtype_sspd.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_equi_packtype_sspd.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_equi_packtype_sspd.sql


prompt "-----paquete DALDC_EQUIVALENCIA_SSPD-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_equivalencia_sspd.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_equivalencia_sspd.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_equivalencia_sspd.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_equivalencia_sspd.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_equivalencia_sspd.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_equivalencia_sspd.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_equivalencia_sspd.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_equivalencia_sspd.sql


prompt "-----paquete DALDC_CAUSAL_SSPD-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_causal_sspd.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_causal_sspd.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_causal_sspd.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_causal_sspd.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_causal_sspd.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_causal_sspd.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_causal_sspd.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_causal_sspd.sql


prompt "-----paquete DALDC_CONFIG_EQUIVA_SSPD-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_config_equiva_sspd.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_config_equiva_sspd.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_config_equiva_sspd.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_config_equiva_sspd.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_config_equiva_sspd.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_config_equiva_sspd.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_config_equiva_sspd.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_config_equiva_sspd.sql


prompt "-----paquete DALDC_EQUI_CAUSAL_SSPD-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_equi_causal_sspd.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_equi_causal_sspd.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_equi_causal_sspd.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_equi_causal_sspd.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_equi_causal_sspd.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_equi_causal_sspd.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_equi_causal_sspd.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_equi_causal_sspd.sql


prompt "-----Script OSF-2778_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2778_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2778-----"
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
