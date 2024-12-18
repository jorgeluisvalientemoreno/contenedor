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

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tipodiametro.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tipodiametro.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tipotrablego.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tipotrablego.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tipozona.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tipozona.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_ttmatdiazona.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_ttmatdiazona.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.regmedivsi.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.regmedivsi.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_usucarteraesp.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_usucarteraesp.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_usucarteraesplog.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_usucarteraesplog.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldccag.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldccag.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldccamposvericart.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldccamposvericart.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_ab_address.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_ab_address.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_ab_premise.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_ab_premise.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_ldci_dmitmmit.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_ldci_dmitmmit.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_ldci_intemmit.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_ldci_intemmit.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_pr_product.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_pr_product.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_audi_unit_act_conadm.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_audi_unit_act_conadm.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_notificacartesp.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_notificacartesp.sql

prompt "Aplicando src/gascaribe/general/materiales/sinonimos/adm_person.ldc_result_process_pedidoventa.sql"
@src/gascaribe/general/materiales/sinonimos/adm_person.ldc_result_process_pedidoventa.sql

prompt "Aplicando src/gascaribe/general/materiales/sinonimos/adm_person.seq_ldc_result_process.sql"
@src/gascaribe/general/materiales/sinonimos/adm_person.seq_ldc_result_process.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_tipsolplancomercial.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_tipsolplancomercial.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_tipsolplanfinan.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_tipsolplanfinan.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_usucuoinindlog.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_usucuoinindlog.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldcrangocomision.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldcrangocomision.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldcrangocomisionlog.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldcrangocomisionlog.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_bocancellations.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bocancellations.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_unop_fnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_unop_fnb.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.audi_ldc_trab_cert.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.audi_ldc_trab_cert.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_unit_rp_plamin.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_unit_rp_plamin.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_tipocon_admin_audi.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_tipocon_admin_audi.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_tipocon_administrativo.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_tipocon_administrativo.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_unitoper_tipotra_conamd.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_unitoper_tipotra_conamd.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_cortinte.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_cortinte.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_registrainterfaz.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_registrainterfaz.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seriposi.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seriposi.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_tranesta.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_tranesta.sql


prompt "------------------------------------------------------"
prompt "Aplicando migracion de objetos"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/ventas/lista_valores_planes/trigger/TRG_INSUPD_TIPSOLPLANCOMERCIAL.sql"
@src/gascaribe/ventas/lista_valores_planes/trigger/TRG_INSUPD_TIPSOLPLANCOMERCIAL.sql

prompt "Aplicando src/gascaribe/ventas/lista_valores_planes/trigger/adm_person.trg_insupd_tipsolplancomercial.sql"
@src/gascaribe/ventas/lista_valores_planes/trigger/adm_person.trg_insupd_tipsolplancomercial.sql

prompt "Aplicando src/gascaribe/ventas/lista_valores_planes/trigger/TRG_INSUPD_TIPSOLPLANFINAN.sql"
@src/gascaribe/ventas/lista_valores_planes/trigger/TRG_INSUPD_TIPSOLPLANFINAN.sql

prompt "Aplicando src/gascaribe/ventas/lista_valores_planes/trigger/adm_person.trg_insupd_tipsolplanfinan.sql"
@src/gascaribe/ventas/lista_valores_planes/trigger/adm_person.trg_insupd_tipsolplanfinan.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/tgr_bu_ldci_transoma.sql"
@src/gascaribe/papelera-reciclaje/triggers/tgr_bu_ldci_transoma.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.tgr_bu_ldci_transoma.sql"
@src/gascaribe/general/trigger/adm_person.tgr_bu_ldci_transoma.sql


prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_aud_ldc_tipocon_admin.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_aud_ldc_tipocon_admin.sql

prompt "Aplicando src/gascaribe/contratacion/trigger/adm_person.trg_aud_ldc_tipocon_admin.sql"
@src/gascaribe/contratacion/trigger/adm_person.trg_aud_ldc_tipocon_admin.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_diametros.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_diametros.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_diametros.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_diametros.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgbtipotrabcertifica_item.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgbtipotrabcertifica_item.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.ldc_trgbtipotrabcertifica_item.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.ldc_trgbtipotrabcertifica_item.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_tipotrabadiclego_00.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_tipotrabadiclego_00.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_tipotrabadiclego_00.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_tipotrabadiclego_00.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_tipotrablego_00.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_tipotrablego_00.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_tipotrablego_00.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_tipotrablego_00.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_zonas.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_zonas.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_zonas.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_zonas.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrgaudi_ldc_trab_cert.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrgaudi_ldc_trab_cert.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.ldctrgaudi_ldc_trab_cert.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.ldctrgaudi_ldc_trab_cert.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_upsertldc_tt_act.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_upsertldc_tt_act.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_upsertldc_tt_act.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_upsertldc_tt_act.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgttproceso.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgttproceso.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trgttproceso.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trgttproceso.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrgbui_ldc_tt_tb.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrgbui_ldc_tt_tb.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldctrgbui_ldc_tt_tb.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldctrgbui_ldc_tt_tb.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ttmatdiazona.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ttmatdiazona.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_ttmatdiazona.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_ttmatdiazona.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgplazomin.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgplazomin.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trgplazomin.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trgplazomin.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_aud_ldc_unit_acconadm.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_aud_ldc_unit_acconadm.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.trg_aud_ldc_unit_acconadm.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.trg_aud_ldc_unit_acconadm.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrg_ldc_unop_fnb.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrg_ldc_unop_fnb.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.ldctrg_ldc_unop_fnb.sql"
@src/gascaribe/fnb/triggers/adm_person.ldctrg_ldc_unop_fnb.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_uo_bytipoinc_biu01.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_uo_bytipoinc_biu01.sql

prompt "Aplicando src/gascaribe/contratacion/trigger/adm_person.ldc_trg_uo_bytipoinc_biu01.sql"
@src/gascaribe/contratacion/trigger/adm_person.ldc_trg_uo_bytipoinc_biu01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_usclo_contract_biu01.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_usclo_contract_biu01.sql

prompt "Aplicando src/gascaribe/contratacion/trigger/adm_person.ldc_trg_usclo_contract_biu01.sql"
@src/gascaribe/contratacion/trigger/adm_person.ldc_trg_usclo_contract_biu01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_usualego_00.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_usualego_00.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_usualego_00.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_usualego_00.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrgsetfieldldcusucartesp.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrgsetfieldldcusucartesp.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.ldctrgsetfieldldcusucartesp.sql"
@src/gascaribe/cartera/triggers/adm_person.ldctrgsetfieldldcusucartesp.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrgupdtldcusucartesp.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrgupdtldcusucartesp.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.ldctrgupdtldcusucartesp.sql"
@src/gascaribe/cartera/triggers/adm_person.ldctrgupdtldcusucartesp.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiudldcusucuoinind.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiudldcusucuoinind.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trgaiudldcusucuoinind.sql"
@src/gascaribe/cartera/triggers/adm_person.trgaiudldcusucuoinind.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbildcusucuoinind.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbildcusucuoinind.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trgbildcusucuoinind.sql"
@src/gascaribe/cartera/triggers/adm_person.trgbildcusucuoinind.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_upsertldc_validate_rp.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_upsertldc_validate_rp.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.ldc_trg_upsertldc_validate_rp.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.ldc_trg_upsertldc_validate_rp.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgvpm.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgvpm.sql

prompt "Aplicando src/gascaribe/servicios-asociados/triggers/adm_person.ldc_trgvpm.sql"
@src/gascaribe/servicios-asociados/triggers/adm_person.ldc_trgvpm.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldccag.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldccag.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_ldccag.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_ldccag.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldci_trgbiu_ldci_cortinte.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldci_trgbiu_ldci_cortinte.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/trigger/adm_person.ldci_trgbiu_ldci_cortinte.sql"
@src/gascaribe/general/interfaz-contable/trigger/adm_person.ldci_trgbiu_ldci_cortinte.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldci_dmitmmit.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldci_dmitmmit.sql

prompt "Aplicando src/gascaribe/general/integraciones/triggers/adm_person.trg_bi_ldci_dmitmmit.sql"
@src/gascaribe/general/integraciones/triggers/adm_person.trg_bi_ldci_dmitmmit.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldci_intemmit.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldci_intemmit.sql

prompt "Aplicando src/gascaribe/general/integraciones/triggers/adm_person.trg_bi_ldci_intemmit.sql"
@src/gascaribe/general/integraciones/triggers/adm_person.trg_bi_ldci_intemmit.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trigger_flag.sql"
@src/gascaribe/papelera-reciclaje/triggers/trigger_flag.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/trigger/adm_person.trigger_flag.sql"
@src/gascaribe/general/interfaz-contable/trigger/adm_person.trigger_flag.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgbldci_seriposi.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgbldci_seriposi.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/adm_person.ldc_trgbldci_seriposi.sql"
@src/gascaribe/general/materiales/triggers/adm_person.ldc_trgbldci_seriposi.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldci_sistmoviltipotrab.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldci_sistmoviltipotrab.sql

prompt "Aplicando src/gascaribe/general/integraciones/triggers/adm_person.ldc_trg_ldci_sistmoviltipotrab.sql"
@src/gascaribe/general/integraciones/triggers/adm_person.ldc_trg_ldci_sistmoviltipotrab.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgbiuldci_transoma.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgbiuldci_transoma.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/adm_person.ldc_trgbiuldci_transoma.sql"
@src/gascaribe/general/materiales/triggers/adm_person.ldc_trgbiuldci_transoma.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/tgr_bi_ldci_transoma.sql"
@src/gascaribe/papelera-reciclaje/triggers/tgr_bi_ldci_transoma.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/adm_person.tgr_bi_ldci_transoma.sql"
@src/gascaribe/general/materiales/triggers/adm_person.tgr_bi_ldci_transoma.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_validabodegatrns.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_validabodegatrns.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/adm_person.trg_validabodegatrns.sql"
@src/gascaribe/general/materiales/triggers/adm_person.trg_validabodegatrns.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgbildci_trsoitem.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgbildci_trsoitem.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/adm_person.ldc_trgbildci_trsoitem.sql"
@src/gascaribe/general/materiales/triggers/adm_person.ldc_trgbildci_trsoitem.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiudldcrangocomision.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiudldcrangocomision.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trgaiudldcrangocomision.sql"
@src/gascaribe/ventas/trigger/adm_person.trgaiudldcrangocomision.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbiuldcrangocomision.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbiuldcrangocomision.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trgbiuldcrangocomision.sql"
@src/gascaribe/ventas/trigger/adm_person.trgbiuldcrangocomision.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgrcaespdire.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgrcaespdire.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgrcaespdire.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgrcaespdire.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_ab_address.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_ab_address.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_ab_address.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_ab_address.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgbu_ab_info_premise.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgbu_ab_info_premise.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgbu_ab_info_premise.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgbu_ab_info_premise.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_ab_premise.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_ab_premise.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_ab_premise.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_ab_premise.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_ab_segments.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_ab_segments.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_ab_segments.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_ab_segments.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgbiudldci_seriposi.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgbiudldci_seriposi.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/adm_person.ldc_trgbiudldci_seriposi.sql"
@src/gascaribe/general/materiales/triggers/adm_person.ldc_trgbiudldci_seriposi.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3384_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-3384_actualizar_obj_migrados.sql

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