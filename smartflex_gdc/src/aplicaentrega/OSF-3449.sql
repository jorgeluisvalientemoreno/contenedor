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

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_gensac.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_gensac.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_paramtram.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_paramtram.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.mo_constr_company_dat.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_constr_company_dat.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ut_xmlutilities.sql"
@src/gascaribe/general/sinonimos/adm_person.ut_xmlutilities.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prodexclrp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prodexclrp.sql

prompt "Aplicando src/gascaribe/gestion-contratista/sinonimos/adm_person.ct_excl_item_cont_val.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ct_excl_item_cont_val.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_cocmcpcc.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_cocmcpcc.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_log_vavafaco.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_log_vavafaco.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_order_1.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_order_1.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.os_change_tasktype.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.os_change_tasktype.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.tipolocalidadunidad.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.tipolocalidadunidad.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_conftain.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_conftain.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_uosup.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_uosup.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.conf_metaasig.sql"
@src/gascaribe/ventas/sinonimos/adm_person.conf_metaasig.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_dampro_sin_tiemcom.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_dampro_sin_tiemcom.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.ldc_unpaid_task_types.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.ldc_unpaid_task_types.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.pktblbanco.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.pktblbanco.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.tranbanc.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.tranbanc.sql



prompt "------------------------------------------------------"
prompt "Aplicando migracion de objetos"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/operacion-y-mantenimiento/compensaciones/triggers/ldc_instt_damage_product.sql"
@src/gascaribe/operacion-y-mantenimiento/compensaciones/triggers/ldc_instt_damage_product.sql

prompt "Aplicando src/gascaribe/operacion-y-mantenimiento/compensaciones/triggers/adm_person.ldc_instt_damage_product.sql"
@src/gascaribe/operacion-y-mantenimiento/compensaciones/triggers/adm_person.ldc_instt_damage_product.sql

prompt "Aplicando src/gascaribe/emergencias/triggers/ldc_trg_bi_request_date.sql"
@src/gascaribe/emergencias/triggers/ldc_trg_bi_request_date.sql

prompt "Aplicando src/gascaribe/emergencias/triggers/adm_person.ldc_trg_bi_request_date.sql"
@src/gascaribe/emergencias/triggers/adm_person.ldc_trg_bi_request_date.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/trigger/LDC_TRG_BIU_VALIDFLAG.sql"
@src/gascaribe/cartera/negociacion-deuda/trigger/LDC_TRG_BIU_VALIDFLAG.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/trigger/adm_person.ldc_trg_biu_validflag.sql"
@src/gascaribe/cartera/negociacion-deuda/trigger/adm_person.ldc_trg_biu_validflag.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/ldc_trg_bloqasignacion.sql"
@src/gascaribe/gestion-ordenes/triggers/ldc_trg_bloqasignacion.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_bloqasignacion.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_bloqasignacion.sql

prompt "Aplicando src/gascaribe/facturacion/diferidos/triggers/ldc_trg_deleteconftain.sql"
@src/gascaribe/facturacion/diferidos/triggers/ldc_trg_deleteconftain.sql

prompt "Aplicando src/gascaribe/facturacion/diferidos/triggers/adm_person.ldc_trg_deleteconftain.sql"
@src/gascaribe/facturacion/diferidos/triggers/adm_person.ldc_trg_deleteconftain.sql

prompt "Aplicando src/gascaribe/revision-periodica/insolvencia/trigger/ldc_trg_esco_insolvencia.sql"
@src/gascaribe/revision-periodica/insolvencia/trigger/ldc_trg_esco_insolvencia.sql

prompt "Aplicando src/gascaribe/revision-periodica/insolvencia/trigger/adm_person.ldc_trg_esco_insolvencia.sql"
@src/gascaribe/revision-periodica/insolvencia/trigger/adm_person.ldc_trg_esco_insolvencia.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/interaccion/trigger/ldc_trg_interaccion.sql/"
@src/gascaribe/atencion-usuarios/interaccion/trigger/ldc_trg_interaccion.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/interaccion/trigger/adm_person.ldc_trg_interaccion.sql"
@src/gascaribe/atencion-usuarios/interaccion/trigger/adm_person.ldc_trg_interaccion.sql

prompt "Aplicando src/gascaribe/revision-periodica/asignacion/ldc_trg_oa_titrrev.sql"
@src/gascaribe/revision-periodica/asignacion/ldc_trg_oa_titrrev.sql

prompt "Aplicando src/gascaribe/revision-periodica/asignacion/triggers/adm_person.ldc_trg_oa_titrrev.sql"
@src/gascaribe/revision-periodica/asignacion/triggers/adm_person.ldc_trg_oa_titrrev.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/ldc_trg_status_order.sql"
@src/gascaribe/gestion-ordenes/triggers/ldc_trg_status_order.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_status_order.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_status_order.sql

prompt "Aplicando src/gascaribe/facturacion/diferidos/triggers/ldc_trgbitasadiferido.sql"
@src/gascaribe/facturacion/diferidos/triggers/ldc_trgbitasadiferido.sql

prompt "Aplicando src/gascaribe/facturacion/diferidos/triggers/adm_person.ldc_trgbitasadiferido.sql"
@src/gascaribe/facturacion/diferidos/triggers/adm_person.ldc_trgbitasadiferido.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_inser_tranbanc.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_inser_tranbanc.sql

prompt "Aplicando src/gascaribe/recaudos/triggers/adm_person.ldc_inser_tranbanc.sql"
@src/gascaribe/recaudos/triggers/adm_person.ldc_inser_tranbanc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_tgr_almacen.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_tgr_almacen.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_tgr_almacen.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_tgr_almacen.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trbincritica.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trbincritica.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/adm_person.ldc_trbincritica.sql"
@src/gascaribe/facturacion/triggers/adm_person.ldc_trbincritica.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trbisol_emer.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trbisol_emer.sql

prompt "Aplicando src/gascaribe/emergencias/triggers/adm_person.ldc_trbisol_emer.sql"
@src/gascaribe/emergencias/triggers/adm_person.ldc_trbisol_emer.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trbiugeneral.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trbiugeneral.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trbiugeneral.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trbiugeneral.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_au_mo_motive_prod.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_au_mo_motive_prod.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.ldc_trg_au_mo_motive_prod.sql"
@src/gascaribe/ventas/trigger/adm_person.ldc_trg_au_mo_motive_prod.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_biud_bodegaunidad.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_biud_bodegaunidad.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_biud_bodegaunidad.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_biud_bodegaunidad.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_biud_excepactividad.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_biud_excepactividad.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_biud_excepactividad.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_biud_excepactividad.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_biud_rolunidad.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_biud_rolunidad.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_biud_rolunidad.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_biud_rolunidad.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_bloqueoasignacion.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_bloqueoasignacion.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_bloqueoasignacion.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_bloqueoasignacion.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_cambio_tipo_trab_oa.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_cambio_tipo_trab_oa.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_cambio_tipo_trab_oa.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_cambio_tipo_trab_oa.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_cm_vavafaco.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_cm_vavafaco.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/adm_person.ldc_trg_cm_vavafaco.sql"
@src/gascaribe/facturacion/triggers/adm_person.ldc_trg_cm_vavafaco.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_comentario.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_comentario.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trg_comentario.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trg_comentario.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_defined_contrac.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_defined_contrac.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_defined_contrac.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_defined_contrac.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ge_contrato_bu01.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ge_contrato_bu01.sql

prompt "Aplicando src/gascaribe/contratacion/trigger/adm_person.ldc_trg_ge_contrato_bu01.sql"
@src/gascaribe/contratacion/trigger/adm_person.ldc_trg_ge_contrato_bu01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ge_contrato_bu02.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ge_contrato_bu02.sql

prompt "Aplicando src/gascaribe/contratacion/trigger/adm_person.ldc_trg_ge_contrato_bu02.sql"
@src/gascaribe/contratacion/trigger/adm_person.ldc_trg_ge_contrato_bu02.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ge_distribution_file.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ge_distribution_file.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trg_ge_distribution_file.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trg_ge_distribution_file.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_gen_ot_apoyo.sql/"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_gen_ot_apoyo.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_gen_ot_apoyo.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_gen_ot_apoyo.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_gen_ot_apoyo_rela.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_gen_ot_apoyo_rela.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_gen_ot_apoyo_rela.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_gen_ot_apoyo_rela.sql

prompt "Aplicando src/gascaribe/facturacion/diferidos/triggers/ldc_trg_insertconftain.sql"
@src/gascaribe/facturacion/diferidos/triggers/ldc_trg_insertconftain.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.ldc_trg_insertconftain.sql/"
@src/gascaribe/cartera/triggers/adm_person.ldc_trg_insertconftain.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_mo_motive_causal.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_mo_motive_causal.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trg_mo_motive_causal.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trg_mo_motive_causal.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_mo_motive_marca_prod.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_mo_motive_marca_prod.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.ldc_trg_mo_motive_marca_prod.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.ldc_trg_mo_motive_marca_prod.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_status_order_anblo.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_status_order_anblo.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_status_order_anblo.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_status_order_anblo.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_tipo_asignacion_uo.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_tipo_asignacion_uo.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_tipo_asignacion_uo.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_tipo_asignacion_uo.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_tipolocalidadunidad.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_tipolocalidadunidad.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_tipolocalidadunidad.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_tipolocalidadunidad.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgactmetcons.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgactmetcons.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/adm_person.ldc_trgactmetcons.sql"
@src/gascaribe/facturacion/triggers/adm_person.ldc_trgactmetcons.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgagrobsusp.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgagrobsusp.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.ldc_trgagrobsusp.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.ldc_trgagrobsusp.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgaimo_constr_comp_dat.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgaimo_constr_comp_dat.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.ldc_trgaimo_constr_comp_dat.sql"
@src/gascaribe/ventas/trigger/adm_person.ldc_trgaimo_constr_comp_dat.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgauasigauto.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgauasigauto.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trgauasigauto.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trgauasigauto.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgaucc_quotation.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgaucc_quotation.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.ldc_trgaucc_quotation.sql"
@src/gascaribe/ventas/trigger/adm_person.ldc_trgaucc_quotation.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgbefupestveriftransit.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgbefupestveriftransit.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/adm_person.ldc_trgbefupestveriftransit.sql"
@src/gascaribe/general/materiales/triggers/adm_person.ldc_trgbefupestveriftransit.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgbucc_quotation.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgbucc_quotation.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.ldc_trgbucc_quotation.sql"
@src/gascaribe/ventas/trigger/adm_person.ldc_trgbucc_quotation.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgbucc_quotation_item.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgbucc_quotation_item.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.ldc_trgbucc_quotation_item.sql"
@src/gascaribe/ventas/trigger/adm_person.ldc_trgbucc_quotation_item.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgcattotsup.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgcattotsup.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.ldc_trgcattotsup.sql"
@src/gascaribe/cartera/triggers/adm_person.ldc_trgcattotsup.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgchangeaddress.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgchangeaddress.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgchangeaddress.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgchangeaddress.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgcontfema.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgcontfema.sql

prompt "Aplicando src/gascaribe/gestion-contratista/triggers/adm_person.ldc_trgcontfema.sql"
@src/gascaribe/gestion-contratista/triggers/adm_person.ldc_trgcontfema.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trggetramsacrp.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trggetramsacrp.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.ldc_trggetramsacrp.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.ldc_trggetramsacrp.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgiudconfimaxmin.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgiudconfimaxmin.sql

prompt "Aplicando src/gascaribe/gestion-contratista/triggers/adm_person.ldc_trgiudconfimaxmin.sql"
@src/gascaribe/gestion-contratista/triggers/adm_person.ldc_trgiudconfimaxmin.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3449_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-3449_actualizar_obj_migrados.sql

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