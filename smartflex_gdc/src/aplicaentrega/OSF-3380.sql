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

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.seq_histcade.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.seq_histcade.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.seq_ld_fa_audidesc.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.seq_ld_fa_audidesc.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.seq_ld_general_audiace.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.seq_ld_general_audiace.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_bcsubsidy.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bcsubsidy.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_blocked_detail.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_blocked_detail.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_blocked.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_blocked.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_inconsistency_detai_cf.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_inconsistency_detai_cf.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_inconsistency_detai_dc.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_inconsistency_detai_dc.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_novelty.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_novelty.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_ascupoad.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_ascupoad.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_extra_quota_adic.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_extra_quota_adic.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_prquotafnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_prquotafnb.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_quota_fnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_quota_fnb.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_asig_subsidy.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_asig_subsidy.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_cupon_causal.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_cupon_causal.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_detail_liqui_seller.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_detail_liqui_seller.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_item_work_order.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_item_work_order.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_policy.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ld_policy.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.au_boadminauditorias.sql"
@src/gascaribe/general/sinonimos/adm_person.au_boadminauditorias.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.au_boauditpolicy.sql"
@src/gascaribe/general/sinonimos/adm_person.au_boauditpolicy.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.au_bosequence.sql"
@src/gascaribe/general/sinonimos/adm_person.au_bosequence.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.le_boliqpropiasval.sql"
@src/gascaribe/general/sinonimos/adm_person.le_boliqpropiasval.sql


prompt "------------------------------------------------------"
prompt "Aplicando migracion de objetos"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_upd_venta_fnb.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_upd_venta_fnb.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.ldc_trg_upd_venta_fnb.sql"
@src/gascaribe/fnb/triggers/adm_person.ldc_trg_upd_venta_fnb.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgdeleteldarticle.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgdeleteldarticle.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.ldc_trgdeleteldarticle.sql"
@src/gascaribe/fnb/triggers/adm_person.ldc_trgdeleteldarticle.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_article.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_article.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaiurld_article.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaiurld_article.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgauld_asig_subsidyorder.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgauld_asig_subsidyorder.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trgauld_asig_subsidyorder.sql"
@src/gascaribe/ventas/trigger/adm_person.trgauld_asig_subsidyorder.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_asig_subsidy.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_asig_subsidy.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trg_bi_ld_asig_subsidy.sql"
@src/gascaribe/ventas/trigger/adm_person.trg_bi_ld_asig_subsidy.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgburld_asig_subsidyorder.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgburld_asig_subsidyorder.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trgburld_asig_subsidyorder.sql"
@src/gascaribe/ventas/trigger/adm_person.trgburld_asig_subsidyorder.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_available_unit.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_available_unit.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaiurld_available_unit.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaiurld_available_unit.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_available_unit.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_available_unit.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_available_unit.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_available_unit.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_afupdate_blocked.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_afupdate_blocked.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trg_afupdate_blocked.sql"
@src/gascaribe/fnb/triggers/adm_person.trg_afupdate_blocked.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_befupdate_blocked.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_befupdate_blocked.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trg_befupdate_blocked.sql"
@src/gascaribe/fnb/triggers/adm_person.trg_befupdate_blocked.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiuld_ld_cancel_causal.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiuld_ld_cancel_causal.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiuld_ld_cancel_causal.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiuld_ld_cancel_causal.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_co_un_task_type.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_co_un_task_type.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaiurld_co_un_task_type.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaiurld_co_un_task_type.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_co_un_task_type.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_co_un_task_type.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_co_un_task_type.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_co_un_task_type.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_con_uni_budget.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_con_uni_budget.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaiurld_con_uni_budget.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaiurld_con_uni_budget.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_con_uni_budget.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_con_uni_budget.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_con_uni_budget.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_con_uni_budget.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_credit_quota.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_credit_quota.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_credit_quota.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_credit_quota.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_creg_resolution.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_creg_resolution.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/adm_person.trgbiurld_creg_resolution.sql"
@src/gascaribe/facturacion/triggers/adm_person.trgbiurld_creg_resolution.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_cupon_causal.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_cupon_causal.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/triggers/adm_person.trg_bi_ld_cupon_causal.sql"
@src/gascaribe/atencion-usuarios/triggers/adm_person.trg_bi_ld_cupon_causal.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgiurld_deal.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgiurld_deal.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trgiurld_deal.sql"
@src/gascaribe/ventas/trigger/adm_person.trgiurld_deal.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_demand_budget.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_demand_budget.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaiurld_demand_budget.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaiurld_demand_budget.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_demand_budget.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_demand_budget.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_demand_budget.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_demand_budget.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_detail_liqui_seller.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_detail_liqui_seller.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trg_bi_ld_detail_liqui_seller.sql"
@src/gascaribe/fnb/triggers/adm_person.trg_bi_ld_detail_liqui_seller.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_dis_exp_budget.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_dis_exp_budget.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaiurld_dis_exp_budget.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaiurld_dis_exp_budget.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_dis_exp_budget.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_dis_exp_budget.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_dis_exp_budget.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_dis_exp_budget.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ld_extra_quota.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ld_extra_quota.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.ldc_trg_ld_extra_quota.sql"
@src/gascaribe/fnb/triggers/adm_person.ldc_trg_ld_extra_quota.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgld_fa_critdesc.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgld_fa_critdesc.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/adm_person.trgld_fa_critdesc.sql"
@src/gascaribe/facturacion/triggers/adm_person.trgld_fa_critdesc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgidu_detadepp.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgidu_detadepp.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trgidu_detadepp.sql"
@src/gascaribe/cartera/triggers/adm_person.trgidu_detadepp.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbur_ld_fa_paragene.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbur_ld_fa_paragene.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/adm_person.trgbur_ld_fa_paragene.sql"
@src/gascaribe/facturacion/triggers/adm_person.trgbur_ld_fa_paragene.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgupdateparageneaudiace.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgupdateparageneaudiace.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/adm_person.trgupdateparageneaudiace.sql"
@src/gascaribe/facturacion/triggers/adm_person.trgupdateparageneaudiace.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ld_finan_plan_fnb.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ld_finan_plan_fnb.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trg_ld_finan_plan_fnb.sql"
@src/gascaribe/fnb/triggers/adm_person.trg_ld_finan_plan_fnb.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgld_general_param.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgld_general_param.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgld_general_param.sql"
@src/gascaribe/general/trigger/adm_person.trgld_general_param.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgupdgeneralparaaudi.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgupdgeneralparaaudi.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgupdgeneralparaaudi.sql"
@src/gascaribe/general/trigger/adm_person.trgupdgeneralparaaudi.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_afupdate_inconsistencycf.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_afupdate_inconsistencycf.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_afupdate_inconsistencycf.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_afupdate_inconsistencycf.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_afupdate_inconsistencydc.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_afupdate_inconsistencydc.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_afupdate_inconsistencydc.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_afupdate_inconsistencydc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_index_ipp_ipc.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_index_ipp_ipc.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgbiurld_index_ipp_ipc.sql"
@src/gascaribe/general/trigger/adm_person.trgbiurld_index_ipp_ipc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ld_item_work_order.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ld_item_work_order.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.ldc_trg_ld_item_work_order.sql"
@src/gascaribe/fnb/triggers/adm_person.ldc_trg_ld_item_work_order.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_item_work_order.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_item_work_order.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trg_bi_ld_item_work_order.sql"
@src/gascaribe/fnb/triggers/adm_person.trg_bi_ld_item_work_order.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_line.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_line.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaiurld_line.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaiurld_line.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_as_man_quota.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_as_man_quota.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.ldc_trg_as_man_quota.sql"
@src/gascaribe/fnb/triggers/adm_person.ldc_trg_as_man_quota.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgauallocatequotemanual.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgauallocatequotemanual.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgauallocatequotemanual.sql"
@src/gascaribe/fnb/triggers/adm_person.trgauallocatequotemanual.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_mar_exp_budget.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_mar_exp_budget.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgaiurld_mar_exp_budget.sql"
@src/gascaribe/fnb/triggers/adm_person.trgaiurld_mar_exp_budget.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_mar_exp_budget.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_mar_exp_budget.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_mar_exp_budget.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_mar_exp_budget.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiduld_max_recoveryval.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiduld_max_recoveryval.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trgbiduld_max_recoveryval.sql"
@src/gascaribe/ventas/trigger/adm_person.trgbiduld_max_recoveryval.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbidurld_max_recoveryval.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbidurld_max_recoveryval.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trgbidurld_max_recoveryval.sql"
@src/gascaribe/ventas/trigger/adm_person.trgbidurld_max_recoveryval.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_afupdate_novelty.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_afupdate_novelty.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_afupdate_novelty.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_afupdate_novelty.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_afupdein_novelty.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_afupdein_novelty.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_afupdein_novelty.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_afupdein_novelty.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_policy.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ld_policy.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trg_bi_ld_policy.sql"
@src/gascaribe/fnb/triggers/adm_person.trg_bi_ld_policy.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiurld_policy_by_cred_quot.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiurld_policy_by_cred_quot.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trgbiurld_policy_by_cred_quot.sql"
@src/gascaribe/fnb/triggers/adm_person.trgbiurld_policy_by_cred_quot.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3380_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-3380_actualizar_obj_migrados.sql

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