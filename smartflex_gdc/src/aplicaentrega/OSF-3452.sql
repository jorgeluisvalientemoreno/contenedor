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

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.gc_debt_negotiation.sql"
@src/gascaribe/cartera/sinonimo/adm_person.gc_debt_negotiation.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldcbi_cc_fin_req_concept.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldcbi_cc_fin_req_concept.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldcbi_pr_prod_suspension.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldcbi_pr_prod_suspension.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldcbi_suspcone.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldcbi_suspcone.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.mo_tyobdeferred.sql"
@src/gascaribe/cartera/sinonimo/adm_person.mo_tyobdeferred.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.fa_apromofa.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.fa_apromofa.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_cuencobr.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_cuencobr.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_cupon.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_cupon.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_fa_apromofa.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_fa_apromofa.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_factura.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_factura.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_pericose.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_pericose.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_perifact.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_perifact.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_pr_comp_suspension.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_pr_comp_suspension.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_pr_component.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_pr_component.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_pr_product_request.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_pr_product_request.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_pr_subs_type_prod.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_pr_subs_type_prod.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_producto_trg.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_producto_trg.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_rangliqu.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_rangliqu.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_ta_vigeliqu.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_ta_vigeliqu.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ta_vigeliqu.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ta_vigeliqu.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_database_version.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_database_version.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ld_parameter_innova.sql"
@src/gascaribe/general/sinonimos/adm_person.ld_parameter_innova.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_audi_actas.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_audi_actas.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_ab_info_premise.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_ab_info_premise.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_ge_acta.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_ge_acta.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_ge_detalle_acta.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_ge_detalle_acta.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_ge_subs_housing_data.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_ge_subs_housing_data.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_ge_subs_work_relat.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_ge_subs_work_relat.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_ge_subscriber.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_ge_subscriber.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_mo_address.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_mo_address.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_mo_comment.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_mo_comment.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_mo_mot_promotion.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_mo_mot_promotion.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_wf_instance.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_wf_instance.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldci_package_camunda_log.sql"
@src/gascaribe/general/sinonimos/adm_person.ldci_package_camunda_log.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pr_product_request.sql"
@src/gascaribe/general/sinonimos/adm_person.pr_product_request.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.seq_ldc_usuarios_actualiza_cl.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ldc_usuarios_actualiza_cl.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcbi_or_requ_data_value.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcbi_or_requ_data_value.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcbi_or_task_type_causal.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcbi_or_task_type_causal.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcbi_or_task_type.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcbi_or_task_type.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcbi_or_task_types_items.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcbi_or_task_types_items.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcbi_or_uni_item_bala_mov.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcbi_or_uni_item_bala_mov.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.fm_preinvoice_pno.sql"
@src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.fm_preinvoice_pno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.ldcbi_fm_preinvoice_pno.sql"
@src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.ldcbi_fm_preinvoice_pno.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.ldci_innovacion_log_cupon.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.ldci_innovacion_log_cupon.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.seq_ldci_innovacion_log_cupon.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.seq_ldci_innovacion_log_cupon.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldcbi_pr_certificate.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcbi_pr_certificate.sql

prompt "------------------------------------------------------"
prompt "Aplicando migracion de objetos"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/cartera/suspensiones/triggers/trg_bitrabajopersecucion.sql"
@src/gascaribe/cartera/suspensiones/triggers/trg_bitrabajopersecucion.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/triggers/adm_person.trg_bitrabajopersecucion.sql"
@src/gascaribe/cartera/suspensiones/triggers/adm_person.trg_bitrabajopersecucion.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/triggers/TRG_CAMUNDA_PACKAGE.sql"
@src/gascaribe/servicios-nuevos/triggers/TRG_CAMUNDA_PACKAGE.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/triggers/adm_person.trg_camunda_package.sql"
@src/gascaribe/servicios-nuevos/triggers/adm_person.trg_camunda_package.sql

prompt "Aplicando src/gascaribe/de/trigger/trg_de_ab_info_premise.sql"
@src/gascaribe/de/trigger/trg_de_ab_info_premise.sql

prompt "Aplicando src/gascaribe/de/trigger/adm_person.trg_de_ab_info_premise.sql"
@src/gascaribe/de/trigger/adm_person.trg_de_ab_info_premise.sql

prompt "Aplicando src/gascaribe/de/trigger/trg_de_cc_fin_req_concept.sql"
@src/gascaribe/de/trigger/trg_de_cc_fin_req_concept.sql

prompt "Aplicando src/gascaribe/de/trigger/adm_person.trg_de_cc_fin_req_concept.sql"
@src/gascaribe/de/trigger/adm_person.trg_de_cc_fin_req_concept.sql

prompt "Aplicando src/gascaribe/de/trigger/trg_de_fa_apromofa.sql"
@src/gascaribe/de/trigger/trg_de_fa_apromofa.sql

prompt "Aplicando src/gascaribe/de/trigger/adm_person.trg_de_fa_apromofa.sql"
@src/gascaribe/de/trigger/adm_person.trg_de_fa_apromofa.sql

prompt "Aplicando src/gascaribe/de/trigger/trg_de_fm_preinvoice_pno.sql"
@src/gascaribe/de/trigger/trg_de_fm_preinvoice_pno.sql

prompt "Aplicando src/gascaribe/de/trigger/adm_person.trg_de_fm_preinvoice_pno.sql"
@src/gascaribe/de/trigger/adm_person.trg_de_fm_preinvoice_pno.sql

prompt "Aplicando src/gascaribe/de/trigger/trg_de_ge_subs_housing_data.sql"
@src/gascaribe/de/trigger/trg_de_ge_subs_housing_data.sql

prompt "Aplicando src/gascaribe/de/trigger/adm_person.trg_de_ge_subs_housing_data.sql"
@src/gascaribe/de/trigger/adm_person.trg_de_ge_subs_housing_data.sql

prompt "Aplicando src/gascaribe/de/trigger/trg_de_ge_subs_work_relat.sql"
@src/gascaribe/de/trigger/trg_de_ge_subs_work_relat.sql

prompt "Aplicando src/gascaribe/de/trigger/adm_person.trg_de_ge_subs_work_relat.sql"
@src/gascaribe/de/trigger/adm_person.trg_de_ge_subs_work_relat.sql

prompt "Aplicando src/gascaribe/de/trigger/trg_de_mo_mot_promotion.sql"
@src/gascaribe/de/trigger/trg_de_mo_mot_promotion.sql

prompt "Aplicando src/gascaribe/de/trigger/adm_person.trg_de_mo_mot_promotion.sql"
@src/gascaribe/de/trigger/adm_person.trg_de_mo_mot_promotion.sql

prompt "Aplicando src/gascaribe/cartera_fnb/trigger/trg_financiar_afianzado_biu.sql"
@src/gascaribe/cartera_fnb/trigger/trg_financiar_afianzado_biu.sql

prompt "Aplicando src/gascaribe/cartera_fnb/trigger/adm_person.trg_financiar_afianzado_biu.sql"
@src/gascaribe/cartera_fnb/trigger/adm_person.trg_financiar_afianzado_biu.sql

prompt "Aplicando src/gascaribe/actas/trigger/TRG_LDC_OT_DOBLES.sql"
@src/gascaribe/actas/trigger/TRG_LDC_OT_DOBLES.sql

prompt "Aplicando src/gascaribe/actas/trigger/adm_person.trg_ldc_ot_dobles.sql"
@src/gascaribe/actas/trigger/adm_person.trg_ldc_ot_dobles.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_requ_data_value.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_requ_data_value.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_or_requ_data_value.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_or_requ_data_value.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_task_type.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_task_type.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.trg_bi_or_task_type.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.trg_bi_or_task_type.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_task_type_causal.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_task_type_causal.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.trg_bi_or_task_type_causal.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.trg_bi_or_task_type_causal.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_task_types_items.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_task_types_items.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.trg_bi_or_task_types_items.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.trg_bi_or_task_types_items.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_uni_item_bala_mov.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_uni_item_bala_mov.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/adm_person.trg_bi_or_uni_item_bala_mov.sql"
@src/gascaribe/general/materiales/triggers/adm_person.trg_bi_or_uni_item_bala_mov.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_pericose.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_pericose.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/adm_person.trg_bi_pericose.sql"
@src/gascaribe/facturacion/triggers/adm_person.trg_bi_pericose.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_perifact.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_perifact.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/adm_person.trg_bi_perifact.sql"
@src/gascaribe/facturacion/triggers/adm_person.trg_bi_perifact.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_pr_certificate.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_pr_certificate.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.trg_bi_pr_certificate.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.trg_bi_pr_certificate.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_pr_comp_suspension.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_pr_comp_suspension.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/triggers/adm_person.trg_bi_pr_comp_suspension.sql"
@src/gascaribe/cartera/suspensiones/triggers/adm_person.trg_bi_pr_comp_suspension.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_pr_component.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_pr_component.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_pr_component.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_pr_component.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_pr_prod_suspension.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_pr_prod_suspension.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/triggers/adm_person.trg_bi_pr_prod_suspension.sql"
@src/gascaribe/cartera/suspensiones/triggers/adm_person.trg_bi_pr_prod_suspension.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_pr_product_request.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_pr_product_request.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_pr_product_request.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_pr_product_request.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_pr_subs_type_prod.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_pr_subs_type_prod.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_pr_subs_type_prod.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_pr_subs_type_prod.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_rangliqu.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_rangliqu.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/adm_person.trg_bi_rangliqu.sql"
@src/gascaribe/facturacion/triggers/adm_person.trg_bi_rangliqu.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_suspcone.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_suspcone.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/triggers/adm_person.trg_bi_suspcone.sql"
@src/gascaribe/cartera/suspensiones/triggers/adm_person.trg_bi_suspcone.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ta_vigeliqu.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ta_vigeliqu.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/adm_person.trg_bi_ta_vigeliqu.sql"
@src/gascaribe/facturacion/triggers/adm_person.trg_bi_ta_vigeliqu.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_wf_instance.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_wf_instance.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_wf_instance.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_wf_instance.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_cc_tmp_bal_by_conc_ai.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_cc_tmp_bal_by_conc_ai.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_cc_tmp_bal_by_conc_ai.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_cc_tmp_bal_by_conc_ai.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_cc_tmp_bal_by_conc_au.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_cc_tmp_bal_by_conc_au.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_cc_tmp_bal_by_conc_au.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_cc_tmp_bal_by_conc_au.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_cc_tmp_bal_by_conc_bi.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_cc_tmp_bal_by_conc_bi.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_cc_tmp_bal_by_conc_bi.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_cc_tmp_bal_by_conc_bi.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ddl_log_object.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ddl_log_object.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ddl_log_object.sql"
@src/gascaribe/general/trigger/adm_person.trg_ddl_log_object.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_del_ge_acta_nov_ofer.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_del_ge_acta_nov_ofer.sql

prompt "Aplicando src/gascaribe/gestion-contratista/triggers/adm_person.trg_del_ge_acta_nov_ofer.sql"
@src/gascaribe/gestion-contratista/triggers/adm_person.trg_del_ge_acta_nov_ofer.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_gc_debt_negot_charge_ai.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_gc_debt_negot_charge_ai.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_gc_debt_negot_charge_ai.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_gc_debt_negot_charge_ai.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_gc_debt_negot_prod_bu.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_gc_debt_negot_prod_bu.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_gc_debt_negot_prod_bu.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_gc_debt_negot_prod_bu.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ins_after_diferido.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ins_after_diferido.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_ins_after_diferido.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_ins_after_diferido.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ins_diferido.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ins_diferido.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_ins_diferido.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_ins_diferido.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_inv_cupon.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_inv_cupon.sql

prompt "Aplicando src/gascaribe/recaudos/triggers/adm_person.trg_inv_cupon.sql"
@src/gascaribe/recaudos/triggers/adm_person.trg_inv_cupon.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldc_aud_acta.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldc_aud_acta.sql

prompt "Aplicando src/gascaribe/gestion-contratista/triggers/adm_person.trg_ldc_aud_acta.sql"
@src/gascaribe/gestion-contratista/triggers/adm_person.trg_ldc_aud_acta.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_cartera_cargos.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_cartera_cargos.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_ldcbi_cartera_cargos.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_ldcbi_cartera_cargos.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_cartera_diferido.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_cartera_diferido.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_ldcbi_cartera_diferido.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_ldcbi_cartera_diferido.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_cuencobr.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_cuencobr.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/adm_person.trg_ldcbi_cuencobr.sql"
@src/gascaribe/facturacion/triggers/adm_person.trg_ldcbi_cuencobr.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_cupon.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_cupon.sql

prompt "Aplicando src/gascaribe/recaudos/triggers/adm_person.trg_ldcbi_cupon.sql"
@src/gascaribe/recaudos/triggers/adm_person.trg_ldcbi_cupon.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_factura.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_factura.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/adm_person.trg_ldcbi_factura.sql"
@src/gascaribe/facturacion/triggers/adm_person.trg_ldcbi_factura.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_ge_acta.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_ge_acta.sql

prompt "Aplicando src/gascaribe/gestion-contratista/triggers/adm_person.trg_ldcbi_ge_acta.sql"
@src/gascaribe/gestion-contratista/triggers/adm_person.trg_ldcbi_ge_acta.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_ge_detalle_acta.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_ge_detalle_acta.sql

prompt "Aplicando src/gascaribe/gestion-contratista/triggers/adm_person.trg_ldcbi_ge_detalle_acta.sql"
@src/gascaribe/gestion-contratista/triggers/adm_person.trg_ldcbi_ge_detalle_acta.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_ge_subscriber.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_ge_subscriber.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_ge_subscriber.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_ge_subscriber.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_mo_address.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_mo_address.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_mo_address.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_mo_address.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_mo_comment.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_mo_comment.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_mo_comment.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_mo_comment.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3452_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-3452_actualizar_obj_migrados.sql

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