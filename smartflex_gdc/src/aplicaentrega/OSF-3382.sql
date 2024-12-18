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

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_organismos.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_organismos.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldcbi_ldc_marca_producto.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcbi_ldc_marca_producto.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_ldc_deprtatt.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcbi_ldc_deprtatt.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.ldc_ejecuta_conc_diaria.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.ldc_ejecuta_conc_diaria.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_insolvencia.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_insolvencia.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_log_insolvencia.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_log_insolvencia.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.seq_ldc_log_insolvencia.sql"
@src/gascaribe/cartera/sinonimo/adm_person.seq_ldc_log_insolvencia.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_audi_liqtitrloca.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_audi_liqtitrloca.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_audi_ord_ofer_redes.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_audi_ord_ofer_redes.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_audi_vehiculos.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_audi_vehiculos.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_contplau.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_contplau.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_conttsfa.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_conttsfa.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_conttsfahist.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_conttsfahist.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_coprauac.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_coprauac.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_coprdeco.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_coprdeco.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_cottclac.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_cottclac.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_ct_taribove.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_ct_taribove.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_ctrl_pers_ext.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_ctrl_pers_ext.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_datoval_titrcaus.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_datoval_titrcaus.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_liqtitrloca.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_liqtitrloca.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_liqvehiuno.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_liqvehiuno.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_loc_tipo_list_dep.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_loc_tipo_list_dep.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_logcontplau.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_logcontplau.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ldc_fnb_subs_block.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldcbi_ldc_fnb_subs_block.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.au_boadminauditorias.sql"
@src/gascaribe/general/sinonimos/adm_person.au_boadminauditorias.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.au_boauditpolicy.sql"
@src/gascaribe/general/sinonimos/adm_person.au_boauditpolicy.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.au_bosequence.sql"
@src/gascaribe/general/sinonimos/adm_person.au_bosequence.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_descripindi.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_descripindi.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_logcoprdeco.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_logcoprdeco.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_ldc_info_predio.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_ldc_info_predio.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ps_engineering_activ.sql"
@src/gascaribe/general/sinonimos/adm_person.ps_engineering_activ.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ut_clob.sql"
@src/gascaribe/general/sinonimos/adm_person.ut_clob.sql

prompt "Aplicando src/gascaribe/general/materiales/sinonimos/adm_person.ldc_descmateriales.sql"
@src/gascaribe/general/materiales/sinonimos/adm_person.ldc_descmateriales.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_info_oper_unit.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_info_oper_unit.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_ordtiptraadi.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_ordtiptraadi.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tt_proceso.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tt_proceso.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.ldc_aud_ejecuta_conc_diaria.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.ldc_aud_ejecuta_conc_diaria.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.ldc_entireca_contra.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.ldc_entireca_contra.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_itemadic_log.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_itemadic_log.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_itemadicinte_log.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_itemadicinte_log.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldcbi_ldc_cotizacion_comercial.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldcbi_ldc_cotizacion_comercial.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.seq_ldc_audit_cuot_proy.sql"
@src/gascaribe/ventas/sinonimos/adm_person.seq_ldc_audit_cuot_proy.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.seq_ldc_itemadic_ldcriaic_log.sql"
@src/gascaribe/ventas/sinonimos/adm_person.seq_ldc_itemadic_ldcriaic_log.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.seq_ldc_itemadicinte_log.sql"
@src/gascaribe/ventas/sinonimos/adm_person.seq_ldc_itemadicinte_log.sql

prompt "------------------------------------------------------"
prompt "Aplicando migracion de objetos"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcvalicontplau.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcvalicontplau.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcvalicontplau.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcvalicontplau.sql

prompt "Aplicando src/gascaribe/ventas/trigger/LDC_TRGHISTCONTTSALD.sql"
@src/gascaribe/ventas/trigger/LDC_TRGHISTCONTTSALD.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.ldc_trghistconttsald.sql"
@src/gascaribe/ventas/trigger/adm_person.ldc_trghistconttsald.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrgbi_coprauac01.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrgbi_coprauac01.sql

prompt "Aplicando src/gascaribe/contratacion/trigger/adm_person.ldctrgbi_coprauac01.sql"
@src/gascaribe/contratacion/trigger/adm_person.ldctrgbi_coprauac01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trglogcpdeco.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trglogcpdeco.sql

prompt "Aplicando src/gascaribe/contratacion/trigger/adm_person.ldc_trglogcpdeco.sql"
@src/gascaribe/contratacion/trigger/adm_person.ldc_trglogcpdeco.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_cotiz_comercial.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_cotiz_comercial.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.trg_bi_ldc_cotiz_comercial.sql"
@src/gascaribe/ventas/trigger/adm_person.trg_bi_ldc_cotiz_comercial.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgvaliactvsi.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgvaliactvsi.sql

prompt "Aplicando src/gascaribe/servicios-asociados/triggers/adm_person.ldc_trgvaliactvsi.sql"
@src/gascaribe/servicios-asociados/triggers/adm_person.ldc_trgvaliactvsi.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trginsldc_ct_taribove.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trginsldc_ct_taribove.sql

prompt "Aplicando src/gascaribe/contratacion/trigger/adm_person.ldc_trginsldc_ct_taribove.sql"
@src/gascaribe/contratacion/trigger/adm_person.ldc_trginsldc_ct_taribove.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ctrl_pers_ext.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ctrl_pers_ext.sql

prompt "Aplicando src/gascaribe/contratacion/trigger/adm_person.ldc_trg_ctrl_pers_ext.sql"
@src/gascaribe/contratacion/trigger/adm_person.ldc_trg_ctrl_pers_ext.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_cuotas_proyecto_trg_delete.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_cuotas_proyecto_trg_delete.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.ldc_cuotas_proyecto_trg_delete.sql"
@src/gascaribe/ventas/trigger/adm_person.ldc_cuotas_proyecto_trg_delete.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_cuotas_proyecto_trg_update.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_cuotas_proyecto_trg_update.sql

prompt "Aplicando src/gascaribe/ventas/trigger/adm_person.ldc_cuotas_proyecto_trg_update.sql"
@src/gascaribe/ventas/trigger/adm_person.ldc_cuotas_proyecto_trg_update.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldc_datoval_titrcaus.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldc_datoval_titrcaus.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.trg_ldc_datoval_titrcaus.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.trg_ldc_datoval_titrcaus.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_deprtatt.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_deprtatt.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/adm_person.trg_bi_ldc_deprtatt.sql"
@src/gascaribe/facturacion/triggers/adm_person.trg_bi_ldc_deprtatt.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_materiales.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_materiales.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/adm_person.ldc_trg_materiales.sql"
@src/gascaribe/general/materiales/triggers/adm_person.ldc_trg_materiales.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_descripindi.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_descripindi.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/triggers/adm_person.ldc_trg_descripindi.sql"
@src/gascaribe/servicios-nuevos/triggers/adm_person.ldc_trg_descripindi.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgdetalle2ttproceso.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgdetalle2ttproceso.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/triggers/adm_person.ldc_trgdetalle2ttproceso.sql"
@src/gascaribe/servicios-nuevos/triggers/adm_person.ldc_trgdetalle2ttproceso.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/crtrgbuldc_detarepoatecli.sql"
@src/gascaribe/papelera-reciclaje/triggers/crtrgbuldc_detarepoatecli.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/triggers/adm_person.crtrgbuldc_detarepoatecli.sql"
@src/gascaribe/atencion-usuarios/triggers/adm_person.crtrgbuldc_detarepoatecli.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrg_aud_ejeca_conc_diaria.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrg_aud_ejeca_conc_diaria.sql

prompt "Aplicando src/gascaribe/recaudos/triggers/adm_person.ldctrg_aud_ejeca_conc_diaria.sql"
@src/gascaribe/recaudos/triggers/adm_person.ldctrg_aud_ejeca_conc_diaria.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgbentirecacontra_valor.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgbentirecacontra_valor.sql

prompt "Aplicando src/gascaribe/facturacion/triggers/adm_person.ldc_trgbentirecacontra_valor.sql"
@src/gascaribe/facturacion/triggers/adm_person.ldc_trgbentirecacontra_valor.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/crtrgbiuldc_equivalencia_sspd.sql"
@src/gascaribe/papelera-reciclaje/triggers/crtrgbiuldc_equivalencia_sspd.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/triggers/adm_person.crtrgbiuldc_equivalencia_sspd.sql"
@src/gascaribe/atencion-usuarios/triggers/adm_person.crtrgbiuldc_equivalencia_sspd.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_fnb_subs_block.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_fnb_subs_block.sql

prompt "Aplicando src/gascaribe/fnb/triggers/adm_person.trg_bi_ldc_fnb_subs_block.sql"
@src/gascaribe/fnb/triggers/adm_person.trg_bi_ldc_fnb_subs_block.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldc_grupo_localidad.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldc_grupo_localidad.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.trg_ldc_grupo_localidad.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.trg_ldc_grupo_localidad.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trginsldc_info_oper_unit.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trginsldc_info_oper_unit.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trginsldc_info_oper_unit.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trginsldc_info_oper_unit.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldc_info_oper_unit_nel.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldc_info_oper_unit_nel.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_ldc_info_oper_unit_nel.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_ldc_info_oper_unit_nel.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_info_predio.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_info_predio.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ldc_info_predio.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ldc_info_predio.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/tgr_log_insolvencia.sql"
@src/gascaribe/papelera-reciclaje/triggers/tgr_log_insolvencia.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.tgr_log_insolvencia.sql"
@src/gascaribe/cartera/triggers/adm_person.tgr_log_insolvencia.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/interaccion/trigger/ldc_trg_fechaintersinflujo.sql"
@src/gascaribe/atencion-usuarios/interaccion/trigger/ldc_trg_fechaintersinflujo.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/interaccion/trigger/adm_person.ldc_trg_fechaintersinflujo.sql"
@src/gascaribe/atencion-usuarios/interaccion/trigger/adm_person.ldc_trg_fechaintersinflujo.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldc_item_uo_lr.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldc_item_uo_lr.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_ldc_item_uo_lr.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_ldc_item_uo_lr.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrg_ldc_item_uo_lr.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrg_ldc_item_uo_lr.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldctrg_ldc_item_uo_lr.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldctrg_ldc_item_uo_lr.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/tgr_iu_itemadic_ldcriaic.sql"
@src/gascaribe/papelera-reciclaje/triggers/tgr_iu_itemadic_ldcriaic.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.tgr_iu_itemadic_ldcriaic.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.tgr_iu_itemadic_ldcriaic.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_itemadic_ldcriaic.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_itemadic_ldcriaic.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.trg_itemadic_ldcriaic.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.trg_itemadic_ldcriaic.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/tgr_iu_itemadicinte_ldcriaic.sql"
@src/gascaribe/papelera-reciclaje/triggers/tgr_iu_itemadicinte_ldcriaic.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.tgr_iu_itemadicinte_ldcriaic.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.tgr_iu_itemadicinte_ldcriaic.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_itemadicinte_ldcriaic.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_itemadicinte_ldcriaic.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.trg_itemadicinte_ldcriaic.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.trg_itemadicinte_ldcriaic.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_itemcoti_ldcriaic.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_itemcoti_ldcriaic.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.trg_itemcoti_ldcriaic.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.trg_itemcoti_ldcriaic.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_itemcotiinte_ldcriaic.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_itemcotiinte_ldcriaic.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.trg_itemcotiinte_ldcriaic.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.trg_itemcotiinte_ldcriaic.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_intrts_ldc_itemcous.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_intrts_ldc_itemcous.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_intrts_ldc_itemcous.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_intrts_ldc_itemcous.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgldcitemexenaumaftinsupd.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgldcitemexenaumaftinsupd.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.trgldcitemexenaumaftinsupd.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.trgldcitemexenaumaftinsupd.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_aud_ldc_audi_liqtitrloca.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_aud_ldc_audi_liqtitrloca.sql

prompt "Aplicando src/gascaribe/contratacion/trigger/adm_person.trg_aud_ldc_audi_liqtitrloca.sql"
@src/gascaribe/contratacion/trigger/adm_person.trg_aud_ldc_audi_liqtitrloca.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_aud_ldc_audi_vehiculos.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_aud_ldc_audi_vehiculos.sql

prompt "Aplicando src/gascaribe/contratacion/trigger/adm_person.trg_aud_ldc_audi_vehiculos.sql"
@src/gascaribe/contratacion/trigger/adm_person.trg_aud_ldc_audi_vehiculos.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_upd_lotepagoproduct.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_upd_lotepagoproduct.sql

prompt "Aplicando src/gascaribe/recaudos/triggers/adm_person.ldc_trg_upd_lotepagoproduct.sql"
@src/gascaribe/recaudos/triggers/adm_person.ldc_trg_upd_lotepagoproduct.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_marca_producto.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_marca_producto.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.trg_bi_ldc_marca_producto.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.trg_bi_ldc_marca_producto.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgvaliformcalc.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgvaliformcalc.sql

prompt "Aplicando src/gascaribe/cartera/triggers/adm_person.ldc_trgvaliformcalc.sql"
@src/gascaribe/cartera/triggers/adm_person.ldc_trgvaliformcalc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ord_des_oder_redes.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ord_des_oder_redes.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_ord_des_oder_redes.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_ord_des_oder_redes.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_aud_ord_ofer_red.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_aud_ord_ofer_red.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.trg_aud_ord_ofer_red.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.trg_aud_ord_ofer_red.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_bi_ordtiptraadic.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_bi_ordtiptraadic.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_bi_ordtiptraadic.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.ldc_trg_bi_ordtiptraadic.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldc_ordtiptraadi.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldc_ordtiptraadi.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/triggers/adm_person.trg_ldc_ordtiptraadi.sql"
@src/gascaribe/gestion-ordenes/triggers/adm_person.trg_ldc_ordtiptraadi.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldc_organismos.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldc_organismos.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.trg_ldc_organismos.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.trg_ldc_organismos.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3382_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-3382_actualizar_obj_migrados.sql

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