column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2780"
prompt "-----------------"

prompt "-----paquete DALD_CUPON_CAUSAL-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_cupon_causal.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_cupon_causal.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_cupon_causal.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ld_cupon_causal.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_cupon_causal.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.dald_cupon_causal.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_cupon_causal.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.dald_cupon_causal.sql


prompt "-----paquete DALDC_DETAREPOATECLI-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_detarepoatecli.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_detarepoatecli.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_detarepoatecli.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_detarepoatecli.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_detarepoatecli.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.daldc_detarepoatecli.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_detarepoatecli.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.daldc_detarepoatecli.sql


prompt "-----paquete DALDC_TIPOINC_BYCON-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_tipoinc_bycon.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_tipoinc_bycon.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_tipoinc_bycon.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_tipoinc_bycon.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_tipoinc_bycon.sql"
@src/gascaribe/contratacion/paquetes/adm_person.daldc_tipoinc_bycon.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_tipoinc_bycon.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.daldc_tipoinc_bycon.sql


prompt "-----paquete DALD_ITEM_WORK_ORDER-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_item_work_order.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_item_work_order.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_item_work_order.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_item_work_order.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_item_work_order.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_item_work_order.sql


prompt "-----paquete DALD_NON_BA_FI_REQU-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_non_ba_fi_requ.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_non_ba_fi_requ.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_non_ba_fi_requ.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_non_ba_fi_requ.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_non_ba_fi_requ.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_non_ba_fi_requ.sql


prompt "-----paquete DALD_PROMISSORY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_promissory.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_promissory.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_promissory.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_promissory.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_promissory.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_promissory.sql


prompt "-----paquete DALD_QUOTA_BLOCK-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_quota_block.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_quota_block.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_quota_block.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_quota_block.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_quota_block.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_quota_block.sql


prompt "-----paquete DALD_QUOTA_BY_SUBSC-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_quota_by_subsc.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_quota_by_subsc.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_quota_by_subsc.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_quota_by_subsc.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_quota_by_subsc.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_quota_by_subsc.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_quota_by_subsc.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_quota_by_subsc.sql


prompt "-----paquete DALD_QUOTA_HISTORIC-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_quota_historic.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_quota_historic.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_quota_historic.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_quota_historic.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_quota_historic.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_quota_historic.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_quota_historic.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_quota_historic.sql


prompt "-----paquete DALD_QUOTA_TRANSFER-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_quota_transfer.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_quota_transfer.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_quota_transfer.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_quota_transfer.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_quota_transfer.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_quota_transfer.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_quota_transfer.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_quota_transfer.sql


prompt "-----paquete DALD_SUBLINE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_subline.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_subline.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_subline.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_subline.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_subline.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_subline.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_subline.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_subline.sql


prompt "-----paquete DALD_SUPPLI_SETTINGS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_suppli_settings.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_suppli_settings.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_suppli_settings.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_suppli_settings.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_suppli_settings.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_suppli_settings.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_suppli_settings.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_suppli_settings.sql


prompt "-----paquete DALD_ASIG_SUBSIDY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_asig_subsidy.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_asig_subsidy.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_asig_subsidy.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_asig_subsidy.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_asig_subsidy.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_asig_subsidy.sql


prompt "-----paquete DALD_DEAL-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_deal.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_deal.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_deal.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_deal.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_deal.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_deal.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_deal.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_deal.sql


prompt "-----paquete DALD_POLICY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_policy.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_policy.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_policy.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_policy.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_policy.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_policy.sql


prompt "-----paquete DALD_SECURE_SALE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_secure_sale.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_secure_sale.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_secure_sale.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_secure_sale.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_secure_sale.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_secure_sale.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_secure_sale.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_secure_sale.sql


prompt "-----paquete DALD_SUBSIDY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_subsidy.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_subsidy.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_subsidy.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_subsidy.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_subsidy.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_subsidy.sql


prompt "-----paquete DALD_UBICATION-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_ubication.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_ubication.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_ubication.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_ubication.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_ubication.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_ubication.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_ubication.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_ubication.sql


prompt "-----paquete DALDC_PARAGEEX-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_parageex.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_parageex.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_parageex.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_parageex.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_parageex.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_parageex.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_parageex.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_parageex.sql


prompt "-----paquete PKTBLLDC_RESOGURE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pktblldc_resogure.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pktblldc_resogure.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.fa_resogure.sql"
@src/gascaribe/general/sinonimos/adm_person.fa_resogure.sql

prompt "--->Aplicando creacion de paquete adm_person.pktblldc_resogure.sql"
@src/gascaribe/general/paquetes/adm_person.pktblldc_resogure.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.pktblldc_resogure.sql"
@src/gascaribe/general/sinonimos/adm_person.pktblldc_resogure.sql


prompt "-----paquete DALDC_MARCA_PRODUCTO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_marca_producto.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_marca_producto.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_marca_producto.sql"
@src/gascaribe/revision-periodica/paquetes/adm_person.daldc_marca_producto.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_marca_producto.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.daldc_marca_producto.sql


prompt "-----paquete DALDC_PARAREPE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_pararepe.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_pararepe.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_pararepe.sql"
@src/gascaribe/revision-periodica/paquetes/adm_person.daldc_pararepe.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_pararepe.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.daldc_pararepe.sql


prompt "-----paquete DALD_TEMP_CLOB_FACT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_temp_clob_fact.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_temp_clob_fact.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_temp_clob_fact.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ld_temp_clob_fact.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_temp_clob_fact.sql"
@src/gascaribe/ventas/paquetes/adm_person.dald_temp_clob_fact.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_temp_clob_fact.sql"
@src/gascaribe/ventas/sinonimos/adm_person.dald_temp_clob_fact.sql


prompt "-----paquete DALDC_COTIZACION_COMERCIAL-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_cotizacion_comercial.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_cotizacion_comercial.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_cotizacion_comercial.sql"
@src/gascaribe/ventas/paquetes/adm_person.daldc_cotizacion_comercial.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_cotizacion_comercial.sql"
@src/gascaribe/ventas/sinonimos/adm_person.daldc_cotizacion_comercial.sql


prompt "-----paquete DALDC_PROYECTO_CONSTRUCTORA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_proyecto_constructora.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_proyecto_constructora.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_proyecto_constructora.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_proyecto_constructora.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_proyecto_constructora.sql"
@src/gascaribe/ventas/paquetes/adm_person.daldc_proyecto_constructora.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_proyecto_constructora.sql"
@src/gascaribe/ventas/sinonimos/adm_person.daldc_proyecto_constructora.sql


prompt "-----Script OSF-2780_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2780_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2780-----"
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
