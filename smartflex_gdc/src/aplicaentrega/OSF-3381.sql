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


prompt "------------------------------------------------------"
prompt "Aplicando sinonimos"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ld_bcsubsidy.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ld_bcsubsidy.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ld_renumbering.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ld_renumbering.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_vali_poli_type_temp.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_vali_poli_type_temp.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_cofuoop.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_cofuoop.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_contanve.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_contanve.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_contanvehist.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_contanvehist.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_prquotafnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_prquotafnb.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_quota_fnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_quota_fnb.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_solianeco.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_solianeco.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_promissory.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_promissory.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_promissory_pu.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_promissory_pu.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_quota_block.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_quota_block.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_quota_by_subsc.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_quota_by_subsc.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_quota_historic.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_quota_historic.sql

prompt "------------------------------------------------------"
prompt "Migracion de objetos"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgiurpolicyexclusion.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgiurpolicyexclusion.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgiurpolicyexclusion.sql"
@src/gascaribe/fnb/triggers/adm_person.trgiurpolicyexclusion.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_policy_type.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_policy_type.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaiurld_policy_type.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaiurld_policy_type.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbirld_policy_type.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbirld_policy_type.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbirld_policy_type.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbirld_policy_type.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiu_ld_pricelist.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiu_ld_pricelist.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiu_ld_pricelist.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiu_ld_pricelist.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_price_list_deta.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_price_list_deta.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_price_list_deta.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_price_list_deta.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaurld_prod_line_ge_cont.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaurld_prod_line_ge_cont.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaurld_prod_line_ge_cont.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaurld_prod_line_ge_cont.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_promissory.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_promissory.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trg_bi_ld_promissory.sql"
@src/gascaribe/fnb/triggers/adm_person.trg_bi_ld_promissory.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_promissory_pu.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_promissory_pu.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trg_bi_ld_promissory_pu.sql"
@src/gascaribe/fnb/triggers/adm_person.trg_bi_ld_promissory_pu.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_quota_assign_policy.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_quota_assign_policy.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_quota_assign_policy.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_quota_assign_policy.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ifad_quote_block.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ifad_quote_block.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.ldc_trg_ifad_quote_block.sql"
@src/gascaribe/fnb/triggers/adm_person.ldc_trg_ifad_quote_block.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiallocatequoteblock.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiallocatequoteblock.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaiallocatequoteblock.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaiallocatequoteblock.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_quota_block.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_quota_block.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trg_bi_ld_quota_block.sql"
@src/gascaribe/fnb/triggers/adm_person.trg_bi_ld_quota_block.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_quota_by_subsc.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_quota_by_subsc.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trg_bi_ld_quota_by_subsc.sql"
@src/gascaribe/fnb/triggers/adm_person.trg_bi_ld_quota_by_subsc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_quota_historic.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_quota_historic.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trg_bi_ld_quota_historic.sql"
@src/gascaribe/fnb/triggers/adm_person.trg_bi_ld_quota_historic.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgauallocatequotetransfer.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgauallocatequotetransfer.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgauallocatequotetransfer.sql"
@src/gascaribe/fnb/triggers/adm_person.trgauallocatequotetransfer.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_rel_mar_geo_loc.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_rel_mar_geo_loc.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaiurld_rel_mar_geo_loc.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaiurld_rel_mar_geo_loc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_rel_mar_geo_loc.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_rel_mar_geo_loc.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_rel_mar_geo_loc.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_rel_mar_geo_loc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_rel_mark_budget.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_rel_mark_budget.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaiurld_rel_mark_budget.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaiurld_rel_mark_budget.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_rel_mark_budget.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_rel_mark_budget.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_rel_mark_budget.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_rel_mark_budget.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_rel_market_rate.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_rel_market_rate.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaiurld_rel_market_rate.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaiurld_rel_market_rate.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_rel_market_rate.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_rel_market_rate.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_rel_market_rate.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_rel_market_rate.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_afupdate_renumbering.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_afupdate_renumbering.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_afupdate_renumbering.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_afupdate_renumbering.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_afupdein_renumbering.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_afupdein_renumbering.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_afupdein_renumbering.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_afupdein_renumbering.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_resol_cons_unit.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_resol_cons_unit.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trgbiurld_resol_cons_unit.sql"
@src/gascaribe/ventas/trigger/adm_person.trgbiurld_resol_cons_unit.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_rollover_quota.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_rollover_quota.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_rollover_quota.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_rollover_quota.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ld_secure_sale.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ld_secure_sale.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.ldc_trg_ld_secure_sale.sql"
@src/gascaribe/fnb/triggers/adm_person.ldc_trg_ld_secure_sale.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_segmen_supplier.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_segmen_supplier.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_segmen_supplier.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_segmen_supplier.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bef_del_ld_send_authorize.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bef_del_ld_send_authorize.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trg_bef_del_ld_send_authorize.sql"
@src/gascaribe/fnb/triggers/adm_person.trg_bef_del_ld_send_authorize.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bef_ins_ld_send_authorize.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bef_ins_ld_send_authorize.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trg_bef_ins_ld_send_authorize.sql"
@src/gascaribe/fnb/triggers/adm_person.trg_bef_ins_ld_send_authorize.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bef_ins_ld_send_aut_prod.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bef_ins_ld_send_aut_prod.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trg_bef_ins_ld_send_aut_prod.sql"
@src/gascaribe/fnb/triggers/adm_person.trg_bef_ins_ld_send_aut_prod.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bef_upd_ld_send_authorize.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bef_upd_ld_send_authorize.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trg_bef_upd_ld_send_authorize.sql"
@src/gascaribe/fnb/triggers/adm_person.trg_bef_upd_ld_send_authorize.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_service_budget.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_service_budget.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaiurld_service_budget.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaiurld_service_budget.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_service_budget.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_service_budget.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_service_budget.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_service_budget.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ld_subs_como_dato.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ld_subs_como_dato.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.ldc_trg_ld_subs_como_dato.sql"
@src/gascaribe/fnb/triggers/adm_person.ldc_trg_ld_subs_como_dato.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiduld_subsidyvalidate.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiduld_subsidyvalidate.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trgaiduld_subsidyvalidate.sql"
@src/gascaribe/ventas/trigger/adm_person.trgaiduld_subsidyvalidate.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbidurld_subsidyvalidate.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbidurld_subsidyvalidate.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trgbidurld_subsidyvalidate.sql"
@src/gascaribe/ventas/trigger/adm_person.trgbidurld_subsidyvalidate.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiduld_subsidy_detailval.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiduld_subsidy_detailval.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trgaiduld_subsidy_detailval.sql"
@src/gascaribe/ventas/trigger/adm_person.trgaiduld_subsidy_detailval.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbidurld_subsidy_detailval.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbidurld_subsidy_detailval.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trgbidurld_subsidy_detailval.sql"
@src/gascaribe/ventas/trigger/adm_person.trgbidurld_subsidy_detailval.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_suppli_modifica_date.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_suppli_modifica_date.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_suppli_modifica_date.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_suppli_modifica_date.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiur_ld_suppli_settings.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiur_ld_suppli_settings.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiur_ld_suppli_settings.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiur_ld_suppli_settings.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiduld_ubicationvalidate.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiduld_ubicationvalidate.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trgaiduld_ubicationvalidate.sql"
@src/gascaribe/ventas/trigger/adm_person.trgaiduld_ubicationvalidate.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbidurld_ubicationvalidate.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbidurld_ubicationvalidate.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trgbidurld_ubicationvalidate.sql"
@src/gascaribe/ventas/trigger/adm_person.trgbidurld_ubicationvalidate.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaild_validity_policy_type.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaild_validity_policy_type.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaild_validity_policy_type.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaild_validity_policy_type.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_validity_policy_type.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_validity_policy_type.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaiurld_validity_policy_type.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaiurld_validity_policy_type.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgauld_validity_policy_type.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgauld_validity_policy_type.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgauld_validity_policy_type.sql"
@src/gascaribe/fnb/triggers/adm_person.trgauld_validity_policy_type.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaurld_validity_policy_type.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaurld_validity_policy_type.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaurld_validity_policy_type.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaurld_validity_policy_type.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_validity_policy_type.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_validity_policy_type.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_validity_policy_type.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_validity_policy_type.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ld_zon_assig_valid.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ld_zon_assig_valid.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.ldc_trg_ld_zon_assig_valid.sql"
@src/gascaribe/ventas/trigger/adm_person.ldc_trg_ld_zon_assig_valid.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurzon_assig_valid.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurzon_assig_valid.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trgbiurzon_assig_valid.sql"
@src/gascaribe/ventas/trigger/adm_person.trgbiurzon_assig_valid.sql

prompt "Aplicando src/gascaribe/ventas/trigger/LDC_TRGHISTCONTANULA.sql"
@src/gascaribe/ventas/trigger/LDC_TRGHISTCONTANULA.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.ldc_trghistcontanula.sql"
@src/gascaribe/ventas/trigger/adm_person.ldc_trghistcontanula.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3381_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-3381_actualizar_obj_migrados.sql

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