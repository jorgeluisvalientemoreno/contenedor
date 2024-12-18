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

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.au_boadminauditorias.sql"
@src/gascaribe/general/sinonimos/adm_person.au_boadminauditorias.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.au_boauditpolicy.sql"
@src/gascaribe/general/sinonimos/adm_person.au_boauditpolicy.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.au_bosequence.sql"
@src/gascaribe/general/sinonimos/adm_person.au_bosequence.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_unit_dummy_oia.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_unit_dummy_oia.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ps_pack_type_param.sql"
@src/gascaribe/general/sinonimos/adm_person.ps_pack_type_param.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.seq_ldc_audit_cheq_proy.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ldc_audit_cheq_proy.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.seq_pr_certificate_156806.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_pr_certificate_156806.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ut_clob.sql"
@src/gascaribe/general/sinonimos/adm_person.ut_clob.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_bscindic.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_bscindic.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_conf_comm_aut_cont.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_conf_comm_aut_cont.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_confplcolog.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_confplcolog.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_confvpcdsi.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_confvpcdsi.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_contabdi.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_contabdi.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_contabdilog.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_contabdilog.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_afianzado.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_afianzado.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_bopersecucion.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_bopersecucion.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_coactcasu.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_coactcasu.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_logconcdife.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_logconcdife.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.ldc_conc_entireca.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.ldc_conc_entireca.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.ldc_entireca_contra.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.ldc_entireca_contra.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.audi_ldc_asig_ot_tecn.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.audi_ldc_asig_ot_tecn.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_conftitrlega.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_conftitrlega.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_conftitrregapo_log.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_conftitrregapo_log.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_genordvaldocu.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_genordvaldocu.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_proceso_actividad.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_proceso_actividad.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.dapr_certificate.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.dapr_certificate.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_resuinsp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_resuinsp.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldcbi_ldc_certificado.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcbi_ldc_certificado.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldcbi_ldc_certificados_oia.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcbi_ldc_certificados_oia.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.pr_bocertificate.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.pr_bocertificate.sql

prompt "------------------------------------------------------"
prompt "Aplicando migracion de objetos"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_actbloq.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_actbloq.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_actbloq.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_actbloq.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgbactigene_actividad.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgbactigene_actividad.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trgbactigene_actividad.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trgbactigene_actividad.sql

prompt "Aplicando src/gascaribe/cartera_fnb/trigger/trg_afianzado_historial_biu.sql"
@src/gascaribe/cartera_fnb/trigger/trg_afianzado_historial_biu.sql

prompt "Aplicando src/gascaribe/cartera_fnb/trigger/adm_person.trg_afianzado_historial_biu.sql"
@src/gascaribe/cartera_fnb/trigger/adm_person.trg_afianzado_historial_biu.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/tgr_ldc_antic_contr.sql"
@src/gascaribe/papelera-reciclaje/triggers/tgr_ldc_antic_contr.sql

prompt "Aplicando src/gascaribe/gestion-contratista/triggers/adm_person.tgr_ldc_antic_contr.sql"
@src/gascaribe/gestion-contratista/triggers/adm_person.tgr_ldc_antic_contr.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrg_audi_ldc_asig_ot_tecn.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrg_audi_ldc_asig_ot_tecn.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldctrg_audi_ldc_asig_ot_tecn.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldctrg_audi_ldc_asig_ot_tecn.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_bscindic.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_bscindic.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.ldc_trg_bscindic.sql"
@src/gascaribe/cartera/triggers/adm_person.ldc_trg_bscindic.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_delete_budget.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_delete_budget.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.ldc_trg_delete_budget.sql"
@src/gascaribe/fnb/triggers/adm_person.ldc_trg_delete_budget.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_update_budget.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_update_budget.sql

prompt "Aplicando src/gascaribe/gestion-contratista/triggers/adm_person.ldc_trg_update_budget.sql"
@src/gascaribe/gestion-contratista/triggers/adm_person.ldc_trg_update_budget.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_validate_budget.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_validate_budget.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.ldc_trg_validate_budget.sql"
@src/gascaribe/fnb/triggers/adm_person.ldc_trg_validate_budget.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ca_bono_liquidareca.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ca_bono_liquidareca.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.ldc_trg_ca_bono_liquidareca.sql"
@src/gascaribe/cartera/triggers/adm_person.ldc_trg_ca_bono_liquidareca.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldc_ca_liquidaedad.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldc_ca_liquidaedad.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.ldc_trg_ldc_ca_liquidaedad.sql"
@src/gascaribe/cartera/triggers/adm_person.ldc_trg_ldc_ca_liquidaedad.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldc_ca_liquidareca.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldc_ca_liquidareca.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.ldc_trg_ldc_ca_liquidareca.sql"
@src/gascaribe/cartera/triggers/adm_person.ldc_trg_ldc_ca_liquidareca.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ca_operunitxrangorec.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ca_operunitxrangorec.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.ldc_trg_ca_operunitxrangorec.sql"
@src/gascaribe/cartera/triggers/adm_person.ldc_trg_ca_operunitxrangorec.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldc_ca_rangperscast.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldc_ca_rangperscast.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.ldc_trg_ldc_ca_rangperscast.sql"
@src/gascaribe/cartera/triggers/adm_person.ldc_trg_ldc_ca_rangperscast.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgsessionmetcub_0.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgsessionmetcub_0.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.ldc_trgsessionmetcub_0.sql"
@src/gascaribe/cartera/triggers/adm_person.ldc_trgsessionmetcub_0.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_certificado.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_certificado.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.trg_bi_ldc_certificado.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.trg_bi_ldc_certificado.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_antes_upinscert.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_antes_upinscert.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.ldc_trg_antes_upinscert.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.ldc_trg_antes_upinscert.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/pagos-validacion/ldc_trggenordvaldoc.sql"
@src/gascaribe/revision-periodica/certificados/pagos-validacion/ldc_trggenordvaldoc.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/pagos-validacion/adm_person.ldc_trggenordvaldoc.sql"
@src/gascaribe/revision-periodica/certificados/pagos-validacion/adm_person.ldc_trggenordvaldoc.sql

prompt "Aplicando src/gascaribe/revision-periodica/plazos/trigger/ldc_trg_inscert.sql"
@src/gascaribe/revision-periodica/plazos/trigger/ldc_trg_inscert.sql

prompt "Aplicando src/gascaribe/revision-periodica/plazos/trigger/adm_person.ldc_trg_inscert.sql"
@src/gascaribe/revision-periodica/plazos/trigger/adm_person.ldc_trg_inscert.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trginscertificadosoia.sql"
@src/gascaribe/papelera-reciclaje/triggers/trginscertificadosoia.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.trginscertificadosoia.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.trginscertificadosoia.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_ldc_certificados_oia.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_ldc_certificados_oia.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.trg_ldcbi_ldc_certificados_oia.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.trg_ldcbi_ldc_certificados_oia.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_cheques_construc_trg_upd.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_cheques_construc_trg_upd.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.ldc_cheques_construc_trg_upd.sql"
@src/gascaribe/ventas/trigger/adm_person.ldc_cheques_construc_trg_upd.sql

prompt "Aplicando src/gascaribe/Cierre/Trigger/ldctrg_ldcciercome.trg"
@src/gascaribe/Cierre/Trigger/ldctrg_ldcciercome.trg

prompt "Aplicando src/gascaribe/Cierre/Trigger/adm_person.ldctrg_ldcciercome.sql"
@src/gascaribe/Cierre/Trigger/adm_person.ldctrg_ldcciercome.sql

prompt "Aplicando src/gascaribe/facturacion/lecturas_especiales/trigger/ldc_trgbilectespcontnl.sql"
@src/gascaribe/facturacion/lecturas_especiales/trigger/ldc_trgbilectespcontnl.sql

prompt "Aplicando src/gascaribe/facturacion/lecturas_especiales/trigger/adm_person.ldc_trgbilectespcontnl.sql"
@src/gascaribe/facturacion/lecturas_especiales/trigger/adm_person.ldc_trgbilectespcontnl.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgconfimaxminitems.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgconfimaxminitems.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgconfimaxminitems.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgconfimaxminitems.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgvaliconcasu.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgvaliconcasu.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.ldc_trgvaliconcasu.sql"
@src/gascaribe/cartera/triggers/adm_person.ldc_trgvaliconcasu.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldc_comctt.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldc_comctt.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldc_comctt.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldc_comctt.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_fechasolicitud.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_fechasolicitud.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trg_fechasolicitud.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trg_fechasolicitud.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trginsldc_comi_tarifa.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trginsldc_comi_tarifa.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.ldc_trginsldc_comi_tarifa.sql"
@src/gascaribe/ventas/trigger/adm_person.ldc_trginsldc_comi_tarifa.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldc_comi_tarifa_nel.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldc_comi_tarifa_nel.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.ldc_trg_ldc_comi_tarifa_nel.sql"
@src/gascaribe/ventas/trigger/adm_person.ldc_trg_ldc_comi_tarifa_nel.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgbconcentireca_valor.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgbconcentireca_valor.sql

prompt "Aplicando src/gascaribe/recaudos/triggers/adm_person.ldc_trgbconcentireca_valor.sql"
@src/gascaribe/recaudos/triggers/adm_person.ldc_trgbconcentireca_valor.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcconcdife.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcconcdife.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_ldcconcdife.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_ldcconcdife.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_condbloqasig.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_condbloqasig.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_condbloqasig.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_condbloqasig.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_condesprenovseg.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_condesprenovseg.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.ldc_trg_condesprenovseg.sql"
@src/gascaribe/fnb/triggers/adm_person.ldc_trg_condesprenovseg.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldc_condit_commerc.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldc_condit_commerc.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_ldc_condit_commerc.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_ldc_condit_commerc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldc_condit_commerc_sc.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldc_condit_commerc_sc.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.trg_ldc_condit_commerc_sc.sql"
@src/gascaribe/cartera/triggers/adm_person.trg_ldc_condit_commerc_sc.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/triggers/trgLDC_CONF_COMM_AUT_CONT01.trg"
@src/gascaribe/ventas/comisiones/triggers/trgLDC_CONF_COMM_AUT_CONT01.trg

prompt "Aplicando src/gascaribe/ventas/comisiones/triggers/adm_person.trgldc_conf_comm_aut_cont01.sql"
@src/gascaribe/ventas/comisiones/triggers/adm_person.trgldc_conf_comm_aut_cont01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalidacontcont.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalidacontcont.sql

prompt "Aplicando src/gascaribe/gestion-contratista/triggers/adm_person.ldc_trgvalidacontcont.sql"
@src/gascaribe/gestion-contratista/triggers/adm_person.ldc_trgvalidacontcont.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgldcconfplco.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgldcconfplco.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trgldcconfplco.sql"
@src/gascaribe/ventas/trigger/adm_person.trgldcconfplco.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalitemxtitr.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgvalitemxtitr.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trgvalitemxtitr.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trgvalitemxtitr.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcconftitrregapo.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcconftitrregapo.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.trg_ldcconftitrregapo.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.trg_ldcconftitrregapo.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcconfvpcdsi.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcconfvpcdsi.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trg_ldcconfvpcdsi.sql"
@src/gascaribe/ventas/trigger/adm_person.trg_ldcconfvpcdsi.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrg_ldc_const_liqtarran.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrg_ldc_const_liqtarran.sql

prompt "Aplicando src/gascaribe/contratacion/trigger/adm_person.ldctrg_ldc_const_liqtarran.sql"
@src/gascaribe/contratacion/trigger/adm_person.ldctrg_ldc_const_liqtarran.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrg_ldc_const_liqtarran2.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrg_ldc_const_liqtarran2.sql

prompt "Aplicando src/gascaribe/contratacion/trigger/adm_person.ldctrg_ldc_const_liqtarran2.sql"
@src/gascaribe/contratacion/trigger/adm_person.ldctrg_ldc_const_liqtarran2.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrg_ldc_const_unoprl.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrg_ldc_const_unoprl.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person..ldctrg_ldc_const_unoprl.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldctrg_ldc_const_unoprl.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/disparadores/LDC_TRGLOGCONTABDI.sql"
@src/gascaribe/facturacion/plan_piloto/disparadores/LDC_TRGLOGCONTABDI.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.ldc_trglogcontabdi.sql"
@src/gascaribe/cartera/triggers/adm_person.ldc_trglogcontabdi.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3314_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-3314_actualizar_obj_migrados.sql

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