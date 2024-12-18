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

-- Inicio Creación sinonimos privados objetos OPEN 1
prompt "Aplicando src/gascaribe/general/sinonimos/ldc_periprog.sql"
@src/gascaribe/general/sinonimos/ldc_periprog.sql

prompt "Aplicando src/gascaribe/general/sinonimos/gc_debt_negotiation.sql"
@src/gascaribe/general/sinonimos/gc_debt_negotiation.sql

prompt "Aplicando src/gascaribe/general/sinonimos/dabanco.sql"
@src/gascaribe/general/sinonimos/dabanco.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_items_documento.sql"
@src/gascaribe/general/sinonimos/ldc_items_documento.sql

prompt "Aplicando src/gascaribe/general/sinonimos/or_boinstanceactivities.sql"
@src/gascaribe/general/sinonimos/or_boinstanceactivities.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_cargtram.sql"
@src/gascaribe/general/sinonimos/ldcbi_cargtram.sql
-- Fin Creación sinonimos privados objetos OPEN 1

-- Inicio Creación sinonimos privados objetos OPEN 2
prompt "Aplicando src/gascaribe/general/sinonimos/ldc_cont_plan_cond.sql"
@src/gascaribe/general/sinonimos/ldc_cont_plan_cond.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_salitemsunidop.sql"
@src/gascaribe/general/sinonimos/ldc_salitemsunidop.sql

prompt "Aplicando src/gascaribe/general/sinonimos/seq_ge_items_documento.sql"
@src/gascaribe/general/sinonimos/seq_ge_items_documento.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_prodexclrp.sql"
@src/gascaribe/general/sinonimos/ldc_prodexclrp.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ab_segments.sql"
@src/gascaribe/general/sinonimos/ldcbi_ab_segments.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_pefageptt.sql"
@src/gascaribe/general/sinonimos/ldc_pefageptt.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_comosuspprodact.sql"
@src/gascaribe/general/sinonimos/ldc_comosuspprodact.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_deprsuad.sql"
@src/gascaribe/general/sinonimos/ldc_deprsuad.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_cargos.sql"
@src/gascaribe/general/sinonimos/ldcbi_cargos.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_conf_engi_acti.sql"
@src/gascaribe/general/sinonimos/ldc_conf_engi_acti.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_periprpl.sql"
@src/gascaribe/general/sinonimos/ldc_periprpl.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_inv_is.sql"
@src/gascaribe/general/sinonimos/ldc_inv_is.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_act_is.sql"
@src/gascaribe/general/sinonimos/ldc_act_is.sql

prompt "Aplicando src/gascaribe/general/sinonimos/dage_items_documento.sql"
@src/gascaribe/general/sinonimos/dage_items_documento.sql

prompt "Aplicando src/gascaribe/general/sinonimos/cc_deferred_movs_hist.sql"
@src/gascaribe/general/sinonimos/cc_deferred_movs_hist.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ge_boitemclassif.sql"
@src/gascaribe/general/sinonimos/ge_boitemclassif.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_cc_financing_request.sql"
@src/gascaribe/general/sinonimos/ldcbi_cc_financing_request.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_proajutt.sql"
@src/gascaribe/general/sinonimos/ldc_proajutt.sql

prompt "Aplicando src/gascaribe/general/sinonimos/trcasesu.sql"
@src/gascaribe/general/sinonimos/trcasesu.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_monto_acta.sql"
@src/gascaribe/general/sinonimos/ldc_monto_acta.sql
-- Fin Creación sinonimos privados objetos OPEN 2


-- Inicio Borrado de triggers en esquema OPEN 1
prompt "Aplicando src/gascaribe/facturacion/notificaciones/LDC_TRGNOTITERMPROC.trg"
@src/gascaribe/facturacion/notificaciones/LDC_TRGNOTITERMPROC.trg

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/trigger/ldc_trgvaliplespcart.sql"
@src/gascaribe/cartera/negociacion-deuda/trigger/ldc_trgvaliplespcart.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/ldc_trgvaliprocfact.sql"
@src/gascaribe/gestion-ordenes/triggers/ldc_trgvaliprocfact.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/ldc_trgvalterfidf.sql"
@src/gascaribe/facturacion/triggers/ldc_trgvalterfidf.sql

prompt "Aplicando src/gascaribe/recaudos/triggers/ldctrg_bss_sucubanc.sql"
@src/gascaribe/recaudos/triggers/ldctrg_bss_sucubanc.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/ldctrgbudi_or_ouib.sql"
@src/gascaribe/general/materiales/triggers/ldctrgbudi_or_ouib.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/ldctrgbudi_or_uibm.sql"
@src/gascaribe/general/materiales/triggers/ldctrgbudi_or_uibm.sql

prompt "Aplicando src/gascaribe/general/notification/triggers/trg_aiu_subscriber_sms.sql"
@src/gascaribe/general/notification/triggers/trg_aiu_subscriber_sms.sql

prompt "Aplicando src/gascaribe/cartera/Financiacion/triggers/trg_bi_cargtram.sql"
@src/gascaribe/cartera/Financiacion/triggers/trg_bi_cargtram.sql

prompt "Aplicando src/gascaribe/ventas/trigger/ldc_trgvaldir.sql"
@src/gascaribe/ventas/trigger/ldc_trgvaldir.sql
-- Fin Borrado de triggers en esquema OPEN 1

-- Inicio Borrado de triggers en esquema OPEN 2
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trglegcodavent.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trglegcodavent.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgmarcapeproc.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgmarcapeproc.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgmarcapergecu.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgmarcapergecu.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgmarusuretatt.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgmarusuretatt.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgmodfechhora.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgmodfechhora.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgmodobssoli.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgmodobssoli.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgprgeaupre.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgprgeaupre.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgrcaespclien.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgrcaespclien.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgsubsidios198.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgsubsidios198.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalacert.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalacert.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalcamclnofac.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalcamclnofac.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalcateg.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalcateg.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalcomlect.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalcomlect.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgvaliitemrecu.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgvaliitemrecu.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalitemcoti214.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalitemcoti214.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalpagcude.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalpagcude.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalususinmed.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalususinmed.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgvpmelmesesu.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgvpmelmesesu.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrg_ins_upd_pr_comp_suspens.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrg_ins_upd_pr_comp_suspens.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrg_mo_pack_revision.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrg_mo_pack_revision.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrg_mo_pack_sol_fnb.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrg_mo_pack_sol_fnb.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrgbudi_ge_is.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrgbudi_ge_is.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrgbudi_ge_itdo.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrgbudi_ge_itdo.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrginsertmatequi.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrginsertmatequi.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/tgr_bu_valida_monto_acta.sql"
@src/gascaribe/papelera-reciclaje/triggers/tgr_bu_valida_monto_acta.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/tgr_ia_operating_unit.sql"
@src/gascaribe/papelera-reciclaje/triggers/tgr_ia_operating_unit.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/tgr_ldc_conf_engi_acti.sql"
@src/gascaribe/papelera-reciclaje/triggers/tgr_ldc_conf_engi_acti.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/tgrau_ge_contrato.sql"
@src/gascaribe/papelera-reciclaje/triggers/tgrau_ge_contrato.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_act_order_value_estcobus.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_act_order_value_estcobus.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_aftins_cc_def_mov_hist.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_aftins_cc_def_mov_hist.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_aftins_trcasesu.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_aftins_trcasesu.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_aiuor_order_activity.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_aiuor_order_activity.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_aud_or_ope_uni_item_bala.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_aud_or_ope_uni_item_bala.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_auror_ope_uni_item_bala.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_auror_ope_uni_item_bala.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bala_mov_val_del_ser.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bala_mov_val_del_ser.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ab_segments.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ab_segments.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_bu_ge_contrato_vpvt.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_bu_ge_contrato_vpvt.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_cargos.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_cargos.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_cc_financing_request.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_cc_financing_request.sql
-- Fin Borrado de triggers en esquema OPEN 2

-- Inicio Creación de triggers en esquema ADM_PERSON 1
prompt "Aplicando src/gascaribe/facturacion/notificaciones/adm_person.ldc_trgnotitermproc.sql"
@src/gascaribe/facturacion/notificaciones/adm_person.ldc_trgnotitermproc.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/trigger/adm_person.ldc_trgvaliplespcart.sql"
@src/gascaribe/cartera/negociacion-deuda/trigger/adm_person.ldc_trgvaliplespcart.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trgvaliprocfact.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trgvaliprocfact.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/adm_person.ldc_trgvalterfidf.sql"
@src/gascaribe/facturacion/triggers/adm_person.ldc_trgvalterfidf.sql

prompt "Aplicando src/gascaribe/recaudos/triggers/adm_person.ldctrg_bss_sucubanc.sql"
@src/gascaribe/recaudos/triggers/adm_person.ldctrg_bss_sucubanc.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/adm_person.ldctrgbudi_or_ouib.sql"
@src/gascaribe/general/materiales/triggers/adm_person.ldctrgbudi_or_ouib.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/adm_person.ldctrgbudi_or_uibm.sql"
@src/gascaribe/general/materiales/triggers/adm_person.ldctrgbudi_or_uibm.sql

prompt "Aplicando src/gascaribe/general/notification/triggers/adm_person.trg_aiu_subscriber_sms.sql"
@src/gascaribe/general/notification/triggers/adm_person.trg_aiu_subscriber_sms.sql

prompt "Aplicando src/gascaribe/cartera/Financiacion/triggers/adm_person.trg_bi_cargtram.sql"
@src/gascaribe/cartera/Financiacion/triggers/adm_person.trg_bi_cargtram.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.ldc_trgvaldir.sql"
@src/gascaribe/ventas/trigger/adm_person.ldc_trgvaldir.sql
-- Fin Creación de triggers en esquema ADM_PERSON 1

-- Inicio Creación de triggers en esquema ADM_PERSON 2
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trglegcodavent.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trglegcodavent.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgmarcapeproc.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgmarcapeproc.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgmarcapergecu.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgmarcapergecu.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgmarusuretatt.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgmarusuretatt.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgmodfechhora.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgmodfechhora.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgmodobssoli.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgmodobssoli.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgprgeaupre.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgprgeaupre.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgrcaespclien.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgrcaespclien.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgsubsidios198.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgsubsidios198.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgvalacert.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgvalacert.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgvalcamclnofac.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgvalcamclnofac.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgvalcateg.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgvalcateg.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgvalcomlect.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgvalcomlect.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgvaliitemrecu.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgvaliitemrecu.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgvalitemcoti214.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgvalitemcoti214.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgvalpagcude.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgvalpagcude.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgvalususinmed.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgvalususinmed.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgvpmelmesesu.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgvpmelmesesu.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldctrg_ins_upd_pr_comp_suspens.sql"
@src/gascaribe/general/trigger/adm_person.ldctrg_ins_upd_pr_comp_suspens.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldctrg_mo_pack_revision.sql"
@src/gascaribe/general/trigger/adm_person.ldctrg_mo_pack_revision.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldctrg_mo_pack_sol_fnb.sql"
@src/gascaribe/general/trigger/adm_person.ldctrg_mo_pack_sol_fnb.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldctrgbudi_ge_is.sql"
@src/gascaribe/general/trigger/adm_person.ldctrgbudi_ge_is.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldctrgbudi_ge_itdo.sql"
@src/gascaribe/general/trigger/adm_person.ldctrgbudi_ge_itdo.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldctrginsertmatequi.sql"
@src/gascaribe/general/trigger/adm_person.ldctrginsertmatequi.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.tgr_bu_valida_monto_acta.sql"
@src/gascaribe/general/trigger/adm_person.tgr_bu_valida_monto_acta.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.tgr_ia_operating_unit.sql"
@src/gascaribe/general/trigger/adm_person.tgr_ia_operating_unit.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.tgr_ldc_conf_engi_acti.sql"
@src/gascaribe/general/trigger/adm_person.tgr_ldc_conf_engi_acti.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.tgrau_ge_contrato.sql"
@src/gascaribe/general/trigger/adm_person.tgrau_ge_contrato.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_act_order_value_estcobus.sql"
@src/gascaribe/general/trigger/adm_person.trg_act_order_value_estcobus.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_aftins_cc_def_mov_hist.sql"
@src/gascaribe/general/trigger/adm_person.trg_aftins_cc_def_mov_hist.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_aftins_trcasesu.sql"
@src/gascaribe/general/trigger/adm_person.trg_aftins_trcasesu.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_aiuor_order_activity.sql"
@src/gascaribe/general/trigger/adm_person.trg_aiuor_order_activity.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_aud_or_ope_uni_item_bala.sql"
@src/gascaribe/general/trigger/adm_person.trg_aud_or_ope_uni_item_bala.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_auror_ope_uni_item_bala.sql"
@src/gascaribe/general/trigger/adm_person.trg_auror_ope_uni_item_bala.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bala_mov_val_del_ser.sql"
@src/gascaribe/general/trigger/adm_person.trg_bala_mov_val_del_ser.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ab_segments.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ab_segments.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_bu_ge_contrato_vpvt.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_bu_ge_contrato_vpvt.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_cargos.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_cargos.sql
prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_cc_financing_request.sql" -- Aqui
@src/gascaribe/general/trigger/adm_person.trg_bi_cc_financing_request.sql
-- Fin Creación de triggers en esquema ADM_PERSON 2

-- Inicio Actualizacion registros MASTER_PERSONALIZACIONES 1
prompt "Aplicando src/gascaribe/datafix/OSF-3450_act_obj_mig.sql"
@src/gascaribe/datafix/OSF-3450_act_obj_mig.sql
-- Fin Actualizacion registros MASTER_PERSONALIZACIONES 1

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