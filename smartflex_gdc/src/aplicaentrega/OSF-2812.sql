column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2812"
prompt "-----------------"

prompt "-----paquete DALDC_ACTBLOQ-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_actbloq.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_actbloq.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_actbloq.sql"
@src/gascaribe/actas/paquetes/adm_person.daldc_actbloq.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_actbloq.sql"
@src/gascaribe/actas/sinonimos/adm_person.daldc_actbloq.sql


prompt "-----paquete DALDC_PLANTEMP-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_plantemp.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_plantemp.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_plantemp.sql"
@src/gascaribe/actas/paquetes/adm_person.daldc_plantemp.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_plantemp.sql"
@src/gascaribe/actas/sinonimos/adm_person.daldc_plantemp.sql


prompt "-----paquete DALDC_PROGRAMAS_VIVIENDA-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_programas_vivienda.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_programas_vivienda.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_programas_vivienda.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.daldc_programas_vivienda.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_programas_vivienda.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.daldc_programas_vivienda.sql


prompt "-----paquete DALDC_RECLAMOS-----" 

prompt "--->Aplicando creacion de paquete adm_person.daldc_reclamos.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.daldc_reclamos.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_reclamos.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.daldc_reclamos.sql


prompt "-----paquete DALDC_RESPUESTA_CAUSAL-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_respuesta_causal.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_respuesta_causal.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_respuesta_causal.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.daldc_respuesta_causal.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_respuesta_causal.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.daldc_respuesta_causal.sql


prompt "-----paquete DALDC_ANALISIS_DE_CONSUMO -----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_analisis_de_consumo.sql"
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.ldc_analisis_de_consumo.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_analisis_de_consumo.sql"
@src/gascaribe/facturacion/consumos/paquetes/adm_person.daldc_analisis_de_consumo.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_analisis_de_consumo.sql"
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.daldc_analisis_de_consumo.sql


prompt "-----paquete DALD_NOTIFICATION-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_notification.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_notification.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_notification.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_notification.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_notification.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_notification.sql


prompt "-----paquete DALD_PROD_LINE_GE_CONT-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_prod_line_ge_cont.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_prod_line_ge_cont.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_prod_line_ge_cont.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_prod_line_ge_cont.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_prod_line_ge_cont.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_prod_line_ge_cont.sql


prompt "-----paquete DALD_REL_MAR_GEO_LOC-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_rel_mar_geo_loc.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_rel_mar_geo_loc.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_rel_mar_geo_loc.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_rel_mar_geo_loc.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_rel_mar_geo_loc.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_rel_mar_geo_loc.sql


prompt "-----paquete DALD_REL_MARK_BUDGET-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_rel_mark_budget.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_rel_mark_budget.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_rel_mark_budget.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_rel_mark_budget.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_rel_mark_budget.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_rel_mark_budget.sql


prompt "-----paquete DALD_REL_MARKET_RATE-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_rel_market_rate.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_rel_market_rate.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_rel_market_rate.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_rel_market_rate.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_rel_market_rate.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_rel_market_rate.sql


prompt "-----paquete DALD_RESOL_CONS_UNIT-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_resol_cons_unit.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_resol_cons_unit.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_resol_cons_unit.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_resol_cons_unit.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_resol_cons_unit.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_resol_cons_unit.sql


prompt "-----paquete DALD_SEGMEN_SUPPLIER-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_segmen_supplier.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_segmen_supplier.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_segmen_supplier.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_segmen_supplier.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_segmen_supplier.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_segmen_supplier.sql


prompt "-----paquete DALD_SEGMENT_CATEG-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_segment_categ.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_segment_categ.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_segment_categ.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_segment_categ.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_segment_categ.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_segment_categ.sql


prompt "-----paquete DALD_SHOPKEEPER-----" 

prompt "--->Aplicando creacion de paquete adm_person.dald_shopkeeper.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_shopkeeper.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_shopkeeper.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_shopkeeper.sql


prompt "-----paquete DALD_SUPPLI_MODIFICA_DATE-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_suppli_modifica_date.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_suppli_modifica_date.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_suppli_modifica_date.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_suppli_modifica_date.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_suppli_modifica_date.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_suppli_modifica_date.sql


prompt "-----paquete DALD_ZON_ASSIG_VALID-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_zon_assig_valid.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_zon_assig_valid.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_zon_assig_valid.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_zon_assig_valid.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_zon_assig_valid.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_zon_assig_valid.sql


prompt "-----paquete DALDC_BUDGET-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_budget.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_budget.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_budget.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_budget.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_budget.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_budget.sql


prompt "-----paquete DALDC_BUDGETBYPROVIDER-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_budgetbyprovider.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_budgetbyprovider.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_budgetbyprovider.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_budgetbyprovider.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_budgetbyprovider.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_budgetbyprovider.sql


prompt "-----paquete DALDC_LDC_SCORHIST-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_scorhist.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_scorhist.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_ldc_scorhist.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_ldc_scorhist.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_ldc_scorhist.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_ldc_scorhist.sql


prompt "-----paquete DALDC_PROMO_FNB-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_promo_fnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_promo_fnb.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_promo_fnb.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_promo_fnb.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_promo_fnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_promo_fnb.sql


prompt "-----paquete DALDC_PROVEED_INSTAL_FNB-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_proveed_instal_fnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_proveed_instal_fnb.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_proveed_instal_fnb.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_proveed_instal_fnb.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_proveed_instal_fnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_proveed_instal_fnb.sql


prompt "-----paquete DALD_POLICY_STATE-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_policy_state.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_policy_state.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_policy_state.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_policy_state.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_policy_state.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_policy_state.sql


prompt "-----paquete DALD_RENEWALL_SECURP-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_renewall_securp.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_renewall_securp.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_renewall_securp.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_renewall_securp.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_renewall_securp.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_renewall_securp.sql


prompt "-----paquete DALD_REP_INCO_SUB-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_rep_inco_sub.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_rep_inco_sub.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_rep_inco_sub.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_rep_inco_sub.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_rep_inco_sub.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_rep_inco_sub.sql


prompt "-----paquete DALDC_IMCOSEEL-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_imcoseel.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_imcoseel.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_imcoseel.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_imcoseel.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_imcoseel.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_imcoseel.sql


prompt "-----paquete DALDC_IPLI_IO-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_ipli_io.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_ipli_io.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_ipli_io.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_ipli_io.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_ipli_io.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_ipli_io.sql


prompt "-----paquete DALDC_LV_LEY_1581-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_lv_ley_1581.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_lv_ley_1581.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_lv_ley_1581.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_lv_ley_1581.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_lv_ley_1581.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_lv_ley_1581.sql


prompt "-----paquete DALDC_PKGMANTGRUPLOCA-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_pkgmantgruploca.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_pkgmantgruploca.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_pkgmantgruploca.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_pkgmantgruploca.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_pkgmantgruploca.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_pkgmantgruploca.sql


prompt "-----paquete DALDC_PKGMANTGRUPO-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_pkgmantgrupo.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_pkgmantgrupo.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_pkgmantgrupo.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_pkgmantgrupo.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_pkgmantgrupo.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_pkgmantgrupo.sql


prompt "-----paquete DALDC_REGIASOBANC-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_regiasobanc.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_regiasobanc.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_regiasobanc.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_regiasobanc.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_regiasobanc.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_regiasobanc.sql


prompt "-----paquete DALDC_RESOGURE-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_resogure.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_resogure.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_grupo_localidad.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_grupo_localidad.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_grupo.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_grupo.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_resogure.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_resogure.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_resogure.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_resogure.sql


prompt "-----paquete DALDC_MACOMCTT-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_macomctt.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_macomctt.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_comctt.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_comctt.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_macomctt.sql"
@src/gascaribe/gestion-contratista/paquetes/adm_person.daldc_macomctt.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_macomctt.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.daldc_macomctt.sql


prompt "-----paquete DALDC_ITEM_OBJ-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_item_obj.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_item_obj.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_item_obj.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_item_obj.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_item_obj.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_item_obj.sql


prompt "-----paquete DALDC_ITEMS_CONEXIONES-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_items_conexiones.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_items_conexiones.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_items_conexiones.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_items_conexiones.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_items_conexiones.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_items_conexiones.sql


prompt "-----paquete DALDC_LDC_ACTI_UNID_BLOQ-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_acti_unid_bloq.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_acti_unid_bloq.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_ldc_acti_unid_bloq.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_ldc_acti_unid_bloq.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_ldc_acti_unid_bloq.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_ldc_acti_unid_bloq.sql


prompt "-----paquete DALDC_TASKACTCOSTPROM-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_taskactcostprom.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_taskactcostprom.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_taskactcostprom.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.daldc_taskactcostprom.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_taskactcostprom.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_taskactcostprom.sql


prompt "-----paquete DALDC_ARCHASOBANC-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_archasobanc.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.ldc_archasobanc.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_archasobanc.sql"
@src/gascaribe/recaudos/paquetes/adm_person.daldc_archasobanc.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_archasobanc.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.daldc_archasobanc.sql


prompt "-----paquete DALDC_ATRIASOBANC-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_atriasobanc.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.ldc_atriasobanc.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_atriasobanc.sql"
@src/gascaribe/recaudos/paquetes/adm_person.daldc_atriasobanc.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_atriasobanc.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.daldc_atriasobanc.sql


prompt "-----paquete DALDC_RETROACTIVE-----" 

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_retroactive.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.ldc_retroactive.sql

prompt "--->Aplicando creacion de paquete adm_person.daldc_retroactive.sql"
@src/gascaribe/recaudos/paquetes/adm_person.daldc_retroactive.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldc_retroactive.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.daldc_retroactive.sql


prompt "-----Script OSF-2812_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2812_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2812-----"
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
