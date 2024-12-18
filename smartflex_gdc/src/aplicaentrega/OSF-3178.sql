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

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ci_bclectelme.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ci_bclectelme.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.cm_bohicoprpm.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.cm_bohicoprpm.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.cm_facocoss.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.cm_facocoss.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.getprevconsperiod.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.getprevconsperiod.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_conc_factura_temp.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_conc_factura_temp.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_detallefact_efigas.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_detallefact_efigas.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkbccuencobr.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkbccuencobr.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkbcelmesesu.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkbcelmesesu.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkbillingperiod.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkbillingperiod.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkbobillprintheaderrules.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkbobillprintheaderrules.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkbobillprintprodrules.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkbobillprintprodrules.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkboinstanceprintingdata.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkboinstanceprintingdata.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkbopericose.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkbopericose.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ta_botarifas.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ta_botarifas.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_err_pagauni.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_err_pagauni.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.log_error_err.sql"
@src/gascaribe/fnb/sinonimos/adm_person.log_error_err.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.s_ldc_err_pagauni.sql"
@src/gascaribe/fnb/sinonimos/adm_person.s_ldc_err_pagauni.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.cc_causal_type.sql"
@src/gascaribe/general/sinonimos/adm_person.cc_causal_type.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_economic_activity.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_economic_activity.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_subs_status.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_subs_status.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_activoencurso.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_activoencurso.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_contesse.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_contesse.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_defisewe.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_defisewe.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_estaproc.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_estaproc.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_inbox.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_inbox.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_inboxdet.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_inboxdet.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_itemacta.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_itemacta.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_itemtmp.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_itemtmp.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_kiosco_reglas.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_kiosco_reglas.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_kiosco_reglas_tmp.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_kiosco_reglas_tmp.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_loganulpago.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_loganulpago.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_logfael.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_logfael.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_materecu.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_materecu.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_mesaproc.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_mesaproc.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_operacion.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_operacion.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkbssfacctto.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkbssfacctto.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkbssreca.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkbssreca.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkgestnotiorden.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkgestnotiorden.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkgestnovorder.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkgestnovorder.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkmesaws.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkmesaws.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkoutbox.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkoutbox.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkrepodatatype.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkrepodatatype.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pksoapapi.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pksoapapi.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seqfacteactasenv.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seqfacteactasenv.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seqmesaws.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seqmesaws.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_sistmoviltipotrab.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_sistmoviltipotrab.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.s_ldci_inbox.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.s_ldci_inbox.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.s_ldci_inboxdet.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.s_ldci_inboxdet.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.seq_kiosco_reglas_tmp.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.seq_kiosco_reglas_tmp.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_auxicorc.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_auxicorc.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_clascore.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_clascore.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_compcont.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_compcont.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_confreco.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_confreco.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_crcoreco.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_crcoreco.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_recoclco.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_recoclco.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_ticocont.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_ticocont.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblic_clascore.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblic_clascore.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblic_compcont.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblic_compcont.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblic_confreco.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblic_confreco.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblic_recoclco.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblic_recoclco.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.sq_ic_auxicorc_187974.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.sq_ic_auxicorc_187974.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.sq_ic_clascore_clcrcons.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.sq_ic_clascore_clcrcons.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.sq_ic_confreco_corccons.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.sq_ic_confreco_corccons.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.sq_ic_crcoreco_ccrccons.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.sq_ic_crcoreco_ccrccons.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.sq_ic_movimien_175553.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.sq_ic_movimien_175553.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.sq_ic_recoclco_rccccons.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.sq_ic_recoclco_rccccons.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.tmpic_auxicorc.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.tmpic_auxicorc.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.tmpic_clascore.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.tmpic_clascore.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.tmpic_compcont.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.tmpic_compcont.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.tmpic_confreco.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.tmpic_confreco.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.tmpic_crcoreco.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.tmpic_crcoreco.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.tmpic_recoclco.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.tmpic_recoclco.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_boemergencyorders.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_boemergencyorders.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_boexternallegalizeactivity.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_boexternallegalizeactivity.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_boinstance.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_boinstance.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bolegalizeactivities.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bolegalizeactivities.sql


prompt "------------------------------------------------------"
prompt "Aplicando migracion de objetos"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_generareportebrilla.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_generareportebrilla.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ldci_generareportebrilla.sql"
@src/gascaribe/fnb/paquetes/adm_person.ldci_generareportebrilla.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldci_generareportebrilla.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldci_generareportebrilla.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_ifrs.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_ifrs.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/paquetes/adm_person.ldci_ifrs.sql"
@src/gascaribe/general/interfaz-contable/paquetes/adm_person.ldci_ifrs.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_ifrs.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_ifrs.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_maestromaterial.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_maestromaterial.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_maestromaterial.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_maestromaterial.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_maestromaterial.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_maestromaterial.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_oss_pkgeograplocat.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_oss_pkgeograplocat.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/package/adm_person.ldci_oss_pkgeograplocat.sql"
@src/gascaribe/gestion-ordenes/package/adm_person.ldci_oss_pkgeograplocat.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldci_oss_pkgeograplocat.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldci_oss_pkgeograplocat.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkanalisuspension.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkanalisuspension.sql

prompt "Aplicando src/gascaribe/cartera/paquetes/adm_person.ldci_pkanalisuspension.sql"
@src/gascaribe/cartera/paquetes/adm_person.ldci_pkanalisuspension.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldci_pkanalisuspension.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldci_pkanalisuspension.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkbsscarbrilla.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkbsscarbrilla.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkbsscarbrilla.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkbsscarbrilla.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkbsscarbrilla.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkbsscarbrilla.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkbsscobro.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkbsscobro.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkbsscobro.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkbsscobro.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkbsscobro.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkbsscobro.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkbssfactcons.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkbssfactcons.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkbssfactcons.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkbssfactcons.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkbssfactcons.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkbssfactcons.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkbssportalweb.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkbssportalweb.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkbssportalweb.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkbssportalweb.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkbssportalweb.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkbssportalweb.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkconexionu.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkconexionu.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkconexionu.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkconexionu.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkconexionu.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkconexionu.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkcrmconsulta.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkcrmconsulta.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkcrmconsulta.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkcrmconsulta.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkcrmconsulta.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkcrmconsulta.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkcrmcontratos.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkcrmcontratos.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkcrmcontratos.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkcrmcontratos.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkcrmcontratos.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkcrmcontratos.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkcrmsolicitud.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkcrmsolicitud.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkcrmsolicitud.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkcrmsolicitud.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkcrmsolicitud.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkcrmsolicitud.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkdatacreditoportal.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkdatacreditoportal.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkdatacreditoportal.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkdatacreditoportal.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkdatacreditoportal.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkdatacreditoportal.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkfactacta.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkfactacta.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkfactacta.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkfactacta.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkfactacta.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkfactacta.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkfactelectronica_emi.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkfactelectronica_emi.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkfactelectronica_emi.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkfactelectronica_emi.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkfactelectronica_emi.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkfactelectronica_emi.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkfactkiosco.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkfactkiosco.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkfactkiosco.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkfactkiosco.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkfactkiosco.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkfactkiosco.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/ldci_pkfactkiosco_gdc.sql"
@src/gascaribe/atencion-usuarios/paquetes/ldci_pkfactkiosco_gdc.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/adm_person.ldci_pkfactkiosco_gdc.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldci_pkfactkiosco_gdc.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldci_pkfactkiosco_gdc.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldci_pkfactkiosco_gdc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkfacturacion.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkfacturacion.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.ldci_pkfacturacion.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldci_pkfacturacion.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldci_pkfacturacion.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldci_pkfacturacion.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkgactivoencurso.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkgactivoencurso.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkgactivoencurso.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkgactivoencurso.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkgactivoencurso.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkgactivoencurso.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkgestenvorden.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkgestenvorden.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkgestenvorden.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkgestenvorden.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkgestenvorden.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkgestenvorden.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkgestnovorderxtt.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkgestnovorderxtt.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkgestnovorderxtt.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkgestnovorderxtt.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkgestnovorderxtt.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkgestnovorderxtt.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinbox.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinbox.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinbox.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinbox.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinbox.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinbox.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_practualizaoranpu.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_practualizaoranpu.sql

prompt "Aplicando src/gascaribe/fnb/procedimientos/adm_person.ldc_practualizaoranpu.sql"
@src/gascaribe/fnb/procedimientos/adm_person.ldc_practualizaoranpu.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_practualizaoranpu.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_practualizaoranpu.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_legalvisitasfnb.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_legalvisitasfnb.sql

prompt "Aplicando src/gascaribe/fnb/procedimientos/adm_person.ldc_legalvisitasfnb.sql"
@src/gascaribe/fnb/procedimientos/adm_person.ldc_legalvisitasfnb.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_legalvisitasfnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_legalvisitasfnb.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_anulasolicitud.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_anulasolicitud.sql

prompt "Aplicando src/gascaribe/fnb/procedimientos/adm_person.ldc_anulasolicitud.sql"
@src/gascaribe/fnb/procedimientos/adm_person.ldc_anulasolicitud.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_anulasolicitud.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_anulasolicitud.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ld_legalize.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ld_legalize.sql

prompt "Aplicando src/gascaribe/fnb/procedimientos/adm_person.ld_legalize.sql"
@src/gascaribe/fnb/procedimientos/adm_person.ld_legalize.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_legalize.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_legalize.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_proinsertaerrpagauni.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proinsertaerrpagauni.sql

prompt "Aplicando src/gascaribe/fnb/procedimientos/adm_person.ldc_proinsertaerrpagauni.sql"
@src/gascaribe/fnb/procedimientos/adm_person.ldc_proinsertaerrpagauni.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_proinsertaerrpagauni.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_proinsertaerrpagauni.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_prolenalogerror.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prolenalogerror.sql

prompt "Aplicando src/gascaribe/fnb/procedimientos/adm_person.ldc_prolenalogerror.sql"
@src/gascaribe/fnb/procedimientos/adm_person.ldc_prolenalogerror.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_prolenalogerror.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_prolenalogerror.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3178_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-3178_actualizar_obj_migrados.sql

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