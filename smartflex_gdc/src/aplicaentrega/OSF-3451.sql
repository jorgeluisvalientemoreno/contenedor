column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2
prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

-- Inicio Creación sinonimos privados objetos OPEN
prompt "Aplicando src/gascaribe/general/sinonimos/cc_request_deferred.sql"
@src/gascaribe/general/sinonimos/cc_request_deferred.sql

prompt "Aplicando src/gascaribe/general/sinonimos/gc_debt_negotiation.sql"
@src/gascaribe/general/sinonimos/gc_debt_negotiation.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ge_items_doc_rel.sql"
@src/gascaribe/general/sinonimos/ge_items_doc_rel.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_cc_grace_peri_defe.sql"
@src/gascaribe/general/sinonimos/ldcbi_cc_grace_peri_defe.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_cc_request_deferred.sql"
@src/gascaribe/general/sinonimos/ldcbi_cc_request_deferred.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_cc_sales_financ_cond.sql"
@src/gascaribe/general/sinonimos/ldcbi_cc_sales_financ_cond.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ciclo.sql"
@src/gascaribe/general/sinonimos/ldcbi_ciclo.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_cm_facocoss.sql"
@src/gascaribe/general/sinonimos/ldcbi_cm_facocoss.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_cm_ordecrit.sql"
@src/gascaribe/general/sinonimos/ldcbi_cm_ordecrit.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_compsesu.sql"
@src/gascaribe/general/sinonimos/ldcbi_compsesu.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_concepto.sql"
@src/gascaribe/general/sinonimos/ldcbi_concepto.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_conssesu.sql"
@src/gascaribe/general/sinonimos/ldcbi_conssesu.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_coprsuca.sql"
@src/gascaribe/general/sinonimos/ldcbi_coprsuca.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ct_order_certifica.sql"
@src/gascaribe/general/sinonimos/ldcbi_ct_order_certifica.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_diferido.sql"
@src/gascaribe/general/sinonimos/ldcbi_diferido.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_elemmedi.sql"
@src/gascaribe/general/sinonimos/ldcbi_elemmedi.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_elmesesu.sql"
@src/gascaribe/general/sinonimos/ldcbi_elmesesu.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_fm_possible_ntl.sql"
@src/gascaribe/general/sinonimos/ldcbi_fm_possible_ntl.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_gc_coll_mgmt_pro_det.sql"
@src/gascaribe/general/sinonimos/ldcbi_gc_coll_mgmt_pro_det.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_gc_debt_negotiation.sql"
@src/gascaribe/general/sinonimos/ldcbi_gc_debt_negotiation.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_gc_debt_negot_charge.sql"
@src/gascaribe/general/sinonimos/ldcbi_gc_debt_negot_charge.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_gc_debt_negot_prod.sql"
@src/gascaribe/general/sinonimos/ldcbi_gc_debt_negot_prod.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_gc_prodprca.sql"
@src/gascaribe/general/sinonimos/ldcbi_gc_prodprca.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ge_causal.sql"
@src/gascaribe/general/sinonimos/ldcbi_ge_causal.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ge_contratista.sql"
@src/gascaribe/general/sinonimos/ldcbi_ge_contratista.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ge_contrato.sql"
@src/gascaribe/general/sinonimos/ldcbi_ge_contrato.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ge_geogra_location.sql"
@src/gascaribe/general/sinonimos/ldcbi_ge_geogra_location.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ge_items.sql"
@src/gascaribe/general/sinonimos/ldcbi_ge_items.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ge_items_documento.sql"
@src/gascaribe/general/sinonimos/ldcbi_ge_items_documento.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ge_items_doc_rel.sql"
@src/gascaribe/general/sinonimos/ldcbi_ge_items_doc_rel.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ge_items_seriado.sql"
@src/gascaribe/general/sinonimos/ldcbi_ge_items_seriado.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ge_item_warranty.sql"
@src/gascaribe/general/sinonimos/ldcbi_ge_item_warranty.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ge_list_unitary_cost.sql"
@src/gascaribe/general/sinonimos/ldcbi_ge_list_unitary_cost.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ge_subs_general_data.sql"
@src/gascaribe/general/sinonimos/ldcbi_ge_subs_general_data.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ge_unit_cost_ite_lis.sql"
@src/gascaribe/general/sinonimos/ldcbi_ge_unit_cost_ite_lis.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_hicoprpm.sql"
@src/gascaribe/general/sinonimos/ldcbi_hicoprpm.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_hileelme.sql"
@src/gascaribe/general/sinonimos/ldcbi_hileelme.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_lectelme.sql"
@src/gascaribe/general/sinonimos/ldcbi_lectelme.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_movidife.sql"
@src/gascaribe/general/sinonimos/ldcbi_movidife.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_movisafa.sql"
@src/gascaribe/general/sinonimos/ldcbi_movisafa.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_mo_addi_request_dates.sql"
@src/gascaribe/general/sinonimos/ldcbi_mo_addi_request_dates.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_mo_component.sql"
@src/gascaribe/general/sinonimos/ldcbi_mo_component.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_mo_gas_sale_data.sql"
@src/gascaribe/general/sinonimos/ldcbi_mo_gas_sale_data.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_mo_motive_payment.sql"
@src/gascaribe/general/sinonimos/ldcbi_mo_motive_payment.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_mo_packages.sql"
@src/gascaribe/general/sinonimos/ldcbi_mo_packages.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_mo_packages_asso.sql"
@src/gascaribe/general/sinonimos/ldcbi_mo_packages_asso.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_mo_package_payment.sql"
@src/gascaribe/general/sinonimos/ldcbi_mo_package_payment.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_mo_suspension.sql"
@src/gascaribe/general/sinonimos/ldcbi_mo_suspension.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_or_operating_unit.sql"
@src/gascaribe/general/sinonimos/ldcbi_or_operating_unit.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_or_order.sql"
@src/gascaribe/general/sinonimos/ldcbi_or_order.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_or_order_activity.sql"
@src/gascaribe/general/sinonimos/ldcbi_or_order_activity.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_or_order_act_var_det.sql"
@src/gascaribe/general/sinonimos/ldcbi_or_order_act_var_det.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_or_order_opeuni_chan.sql"
@src/gascaribe/general/sinonimos/ldcbi_or_order_opeuni_chan.sql

prompt "Aplicando src/gascaribe/general/sinonimos/mo_addi_request_dates.sql"
@src/gascaribe/general/sinonimos/mo_addi_request_dates.sql

prompt "Aplicando src/gascaribe/general/sinonimos/or_order_act_var_det.sql"
@src/gascaribe/general/sinonimos/or_order_act_var_det.sql
-- Fin Creación sinonimos privados objetos OPEN

-- Inicio Borrado de triggers en OPEN
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_cc_grace_peri_defe.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_cc_grace_peri_defe.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_cc_request_deferred.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_cc_request_deferred.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_cc_sales_financ_cond.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_cc_sales_financ_cond.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ciclo.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ciclo.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_cm_facocoss.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_cm_facocoss.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_cm_ordecrit.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_cm_ordecrit.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_compsesu.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_compsesu.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_concepto.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_concepto.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_conssesu.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_conssesu.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_coprsuca.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_coprsuca.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ct_order_certifica.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ct_order_certifica.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_diferido.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_diferido.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_elemmedi.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_elemmedi.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_elmesesu.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_elmesesu.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_fm_possible_ntl.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_fm_possible_ntl.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_gc_coll_mgmt_pro_det.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_gc_coll_mgmt_pro_det.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_gc_debt_negotiation.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_gc_debt_negotiation.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_gc_debt_negot_charge.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_gc_debt_negot_charge.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_gc_debt_negot_prod.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_gc_debt_negot_prod.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_gc_prodprca.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_gc_prodprca.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_gesubgendata.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_gesubgendata.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_causal.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_causal.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_contratista.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_contratista.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_contrato.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_contrato.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_geogra_location.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_geogra_location.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_items.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_items.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_items_documento.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_items_documento.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_items_doc_rel.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_items_doc_rel.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_items_seriado.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_items_seriado.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_item_warranty.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_item_warranty.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_list_unitary_cost.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_list_unitary_cost.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_unit_cost_ite_lis.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ge_unit_cost_ite_lis.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_hicoprpm.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_hicoprpm.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_hileelme.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_hileelme.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_lectelme.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_lectelme.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_movidife.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_movidife.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_movisafa.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_movisafa.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_mo_addi_request_dates.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_mo_addi_request_dates.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_mo_component.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_mo_component.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_mo_gas_sale_data.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_mo_gas_sale_data.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_mo_motive_payment.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_mo_motive_payment.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_mo_packages.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_mo_packages.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_mo_packages_asso.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_mo_packages_asso.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_mo_package_payment.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_mo_package_payment.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_mo_suspension.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_mo_suspension.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_operating_unit.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_operating_unit.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_order.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_order.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_order_activity.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_order_activity.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_order_act_var_det.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_order_act_var_det.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_order_opeuni_chan.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_or_order_opeuni_chan.sql
-- Fin Borrado de triggers en OPEN

-- Inicio Creacion de triggers en ADM_PERSON
prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_cc_grace_peri_defe.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_cc_grace_peri_defe.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_cc_request_deferred.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_cc_request_deferred.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_cc_sales_financ_cond.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_cc_sales_financ_cond.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ciclo.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ciclo.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_cm_facocoss.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_cm_facocoss.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_cm_ordecrit.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_cm_ordecrit.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_compsesu.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_compsesu.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_concepto.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_concepto.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_conssesu.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_conssesu.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_coprsuca.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_coprsuca.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ct_order_certifica.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ct_order_certifica.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_diferido.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_diferido.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_elemmedi.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_elemmedi.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_elmesesu.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_elmesesu.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_fm_possible_ntl.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_fm_possible_ntl.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_gc_coll_mgmt_pro_det.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_gc_coll_mgmt_pro_det.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_gc_debt_negotiation.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_gc_debt_negotiation.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_gc_debt_negot_charge.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_gc_debt_negot_charge.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_gc_debt_negot_prod.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_gc_debt_negot_prod.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_gc_prodprca.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_gc_prodprca.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_gesubgendata.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_gesubgendata.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ge_causal.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ge_causal.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ge_contratista.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ge_contratista.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ge_contrato.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ge_contrato.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ge_geogra_location.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ge_geogra_location.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ge_items.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ge_items.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ge_items_documento.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ge_items_documento.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ge_items_doc_rel.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ge_items_doc_rel.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ge_items_seriado.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ge_items_seriado.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ge_item_warranty.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ge_item_warranty.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ge_list_unitary_cost.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ge_list_unitary_cost.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ge_unit_cost_ite_lis.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ge_unit_cost_ite_lis.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_hicoprpm.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_hicoprpm.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_hileelme.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_hileelme.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_lectelme.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_lectelme.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_movidife.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_movidife.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_movisafa.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_movisafa.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_mo_addi_request_dates.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_mo_addi_request_dates.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_mo_component.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_mo_component.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_mo_gas_sale_data.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_mo_gas_sale_data.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_mo_motive_payment.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_mo_motive_payment.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_mo_packages.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_mo_packages.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_mo_packages_asso.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_mo_packages_asso.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_mo_package_payment.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_mo_package_payment.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_mo_suspension.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_mo_suspension.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_or_operating_unit.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_or_operating_unit.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_or_order.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_or_order.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_or_order_activity.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_or_order_activity.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_or_order_act_var_det.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_or_order_act_var_det.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_or_order_opeuni_chan.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_or_order_opeuni_chan.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_or_order_opeuni_chan.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_or_order_opeuni_chan.sql
-- Fin Creacion de triggers en ADM_PERSON

-- Inicio actualización en MASTER_PERSONALIZACIONES
prompt "Aplicando src/gascaribe/datafix/OSF-3451_act_obj_mig.sql"
@src/gascaribe/datafix/OSF-3451_act_obj_mig.sql
-- Fin actualización en MASTER_PERSONALIZACIONES

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"
commit;
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/
