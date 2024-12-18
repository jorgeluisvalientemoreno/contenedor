column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2878"
prompt "-----------------"

prompt "-----paquete LDC_BOGESTIONTARIFAS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bogestiontarifas.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bogestiontarifas.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ta_proytari.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ta_proytari.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_bcgestiontarifas.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_bcgestiontarifas.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bogestiontarifas.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_bogestiontarifas.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bogestiontarifas.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_bogestiontarifas.sql


prompt "-----paquete LDC_BOPRINTFOFACTCUSTMGR-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_boprintfofactcustmgr.sql"
@src/gascaribe/facturacion/paquetes/ldc_boprintfofactcustmgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ut_lob.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ut_lob.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblfactura.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pktblfactura.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_boprintfofactcustmgr.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_boprintfofactcustmgr.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_boprintfofactcustmgr.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_boprintfofactcustmgr.sql


prompt "-----paquete LDC_DSCC_COMMERCIAL_PLAN-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_dscc_commercial_plan.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dscc_commercial_plan.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_dscc_commercial_plan.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_dscc_commercial_plan.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_dscc_commercial_plan.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_dscc_commercial_plan.sql


prompt "-----paquete LDC_DSEQUIVA_LOCALIDAD-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_dsequiva_localidad.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsequiva_localidad.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_dsequiva_localidad.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_dsequiva_localidad.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_dsequiva_localidad.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_dsequiva_localidad.sql


prompt "-----paquete LDC_DSESTACORT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_dsestacort.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsestacort.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_dsestacort.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_dsestacort.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_dsestacort.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_dsestacort.sql


prompt "-----paquete LDC_DSGE_RECEPTION_TYPE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_dsge_reception_type.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsge_reception_type.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_dsge_reception_type.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_dsge_reception_type.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_dsge_reception_type.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_dsge_reception_type.sql


prompt "-----paquete LDC_DSGE_TIPO_UNIDAD-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_dsge_tipo_unidad.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsge_tipo_unidad.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_tipo_unidad.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_tipo_unidad.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_dsge_tipo_unidad.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_dsge_tipo_unidad.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_dsge_tipo_unidad.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_dsge_tipo_unidad.sql


prompt "-----paquete LDC_PKAJUSTASUSPCONE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkajustasuspcone.sql"
@src/gascaribe/cartera/suspensiones/paquetes/ldc_pkajustasuspcone.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_titrtisu.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_titrtisu.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_pkg_changstatesolici.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_pkg_changstatesolici.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_analisis_suspcone.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_analisis_suspcone.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_ajusta_suspcone.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_ajusta_suspcone.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.fnureqchargescancell.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.fnureqchargescancell.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkajustasuspcone.sql"
@src/gascaribe/cartera/suspensiones/paquetes/adm_person.ldc_pkajustasuspcone.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkajustasuspcone.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_pkajustasuspcone.sql


prompt "-----paquete LDC_PKG_CAMFEC-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkg_camfec.sql"
@src/gascaribe/gestion-ordenes/package/ldc_pkg_camfec.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_imcorete.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_imcorete.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_camfec.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_camfec.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkg_camfec.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.ldc_pkg_camfec.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkg_camfec.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_pkg_camfec.sql


prompt "-----paquete LDC_PKGACTUALIZALISCOST-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkgactualizaliscost.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgactualizaliscost.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ge_list_unitary_cost.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.seq_ge_list_unitary_cost.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_seqlctaran.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_seqlctaran.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_logproacliscost.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_logproacliscost.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_itemexenaum.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_itemexenaum.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkgactualizaliscost.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.ldc_pkgactualizaliscost.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkgactualizaliscost.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_pkgactualizaliscost.sql


prompt "-----paquete LDC_PKGCAMVAC-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkgcamvac.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgcamvac.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_items_seriado_cost.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_items_seriado_cost.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mo_notify_log_pack.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_notify_log_pack.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkgcamvac.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_pkgcamvac.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkgcamvac.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_pkgcamvac.sql


prompt "-----paquete LDC_PKGENAJUSMASI-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkgenajusmasi.sql"
@src/gascaribe/atencion-usuarios/paquetes/ldc_pkgenajusmasi.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_bcfinancing.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_bcfinancing.sql

prompt "--->Aplicando creacion tipo a nuevo paquete adm_person.mo_tyobextrapayments.sql"
@src/gascaribe/general/tipos/adm_person.mo_tyobextrapayments.sql

prompt "--->Aplicando creacion tipo a nuevo paquete adm_person.mo_tytbextrapayments.sql"
@src/gascaribe/general/tipos/adm_person.mo_tytbextrapayments.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mensaje.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.mensaje.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cuotextr.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cuotextr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.fa_boivamodemgr.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.fa_boivamodemgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.feullico.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.feullico.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.funciona.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.funciona.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_bofinancialprofile.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ge_bofinancialprofile.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_document_type.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ge_document_type.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_log_err_ldcandm.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_log_err_ldcandm.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.movidife.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.movidife.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkaccountstatusmgr.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkaccountstatusmgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkaditionalpaymentmgr.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkaditionalpaymentmgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkbcaccountstatus.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkbcaccountstatus.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkbccargos.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkbccargos.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkbcfunciona.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkbcfunciona.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkbcsubscription.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkbcsubscription.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkbillfuncparameters.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkbillfuncparameters.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkboprocesssecurity.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkboprocesssecurity.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkconceptmgr.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkconceptmgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkconsecutivemgr.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkconsecutivemgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkdeferredmgr.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkdeferredmgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkdeferredplanmgr.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkdeferredplanmgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkextendedhash.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkextendedhash.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkgrlparamextendedmgr.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkgrlparamextendedmgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkservnumbermgr.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkservnumbermgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pksubscribermgr.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pksubscribermgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pksubsdatelinemgr.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pksubsdatelinemgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblcargos.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pktblcargos.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblconsecut.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pktblconsecut.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktbldiferido.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pktbldiferido.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblfeullico.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pktblfeullico.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblmensaje.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pktblmensaje.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblmovidife.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pktblmovidife.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblparafact.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pktblparafact.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblparametr.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pktblparametr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblservicio.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pktblservicio.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblsistema.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pktblsistema.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.procrest.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.procrest.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.timoempr.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.timoempr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.tipocomp.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.tipocomp.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkgenajusmasi.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_pkgenajusmasi.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkgenajusmasi.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_pkgenajusmasi.sql


prompt "-----paquete LDC_PKGENEORADI-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkgeneoradi.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgeneoradi.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_boinstanceconstants.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_boinstanceconstants.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.or_bcorderprocess.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bcorderprocess.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.or_boordernumerator.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_boordernumerator.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.or_bosupportorder.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bosupportorder.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkgeneoradi.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.ldc_pkgeneoradi.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkgeneoradi.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_pkgeneoradi.sql


prompt "-----paquete LDC_PKGENLECTESP-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkgenlectesp.sql"
@src/gascaribe/facturacion/lecturas_especiales/paquetes/ldc_pkgenlectesp.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_cm_lectesp_cicl.sql"
@src/gascaribe/facturacion/lecturas_especiales/sinonimos/adm_person.ldc_cm_lectesp_cicl.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_cm_lectesp_contnl.sql"
@src/gascaribe/facturacion/lecturas_especiales/sinonimos/adm_person.ldc_cm_lectesp_contnl.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_cm_lectesp_tpcl.sql"
@src/gascaribe/facturacion/lecturas_especiales/sinonimos/adm_person.ldc_cm_lectesp_tpcl.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_cm_log_geleesp.sql"
@src/gascaribe/facturacion/lecturas_especiales/sinonimos/adm_person.ldc_cm_log_geleesp.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkgenlectesp.sql"
@src/gascaribe/facturacion/lecturas_especiales/paquetes/adm_person.ldc_pkgenlectesp.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkgenlectesp.sql"
@src/gascaribe/facturacion/lecturas_especiales/sinonimos/adm_person.ldc_pkgenlectesp.sql


prompt "-----paquete LDC_PKGINFOGESMOV-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkginfogesmov.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkginfogesmov.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_infogesmov_log.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldc_infogesmov_log.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkginfogesmov.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldc_pkginfogesmov.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkginfogesmov.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldc_pkginfogesmov.sql


prompt "-----paquete LDC_PKPAGOSCONSIG-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkpagosconsig.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkpagosconsig.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_lotepagoproduct.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_lotepagoproduct.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkbopagoanticipado.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkbopagoanticipado.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.detapago.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.detapago.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkpagosconsig.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_pkpagosconsig.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkpagosconsig.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_pkpagosconsig.sql


prompt "-----paquete LDC_PKUICARGAPERIODOS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkuicargaperiodos.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkuicargaperiodos.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_pkbocargaperiodos.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_pkbocargaperiodos.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkuicargaperiodos.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_pkuicargaperiodos.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkuicargaperiodos.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_pkuicargaperiodos.sql


prompt "-----paquete LDC_PKVENTAGAS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkventagas.sql"
@src/gascaribe/ventas/ldc_pkventagas.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.formpago.sql"
@src/gascaribe/ventas/sinonimos/adm_person.formpago.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkventagas.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_pkventagas.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkventagas.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_pkventagas.sql


prompt "-----paquete LDC_UIAPPROVEDREQUESTS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_uiapprovedrequests.sql"
@src/gascaribe/ventas/paquetes/ldc_uiapprovedRequests.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_pkgapprovedrequests.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_pkgapprovedrequests.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_uiapprovedrequests.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_uiapprovedRequests.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_uiapprovedrequests.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_uiapprovedrequests.sql


prompt "-----paquete LDC_UILDCPBLEORD-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_uildcpbleord.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_uildcpbleord.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_uildcpbleord.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.ldc_uildcpbleord.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_uildcpbleord.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_uildcpbleord.sql


prompt "-----paquete LDC_UILDRPC-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_uildrpc.sql"
@src/gascaribe/fnb/seguros/paquetes/ldc_uildrpc.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_uildrpc.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.ldc_uildrpc.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_uildrpc.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ldc_uildrpc.sql


prompt "-----paquete PKACUCARTOT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pkacucartot.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkacucartot.sql

prompt "--->Aplicando creacion de paquete adm_person.pkacucartot.sql"
@src/gascaribe/ventas/paquetes/adm_person.pkacucartot.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.pkacucartot.sql"
@src/gascaribe/ventas/sinonimos/adm_person.pkacucartot.sql


prompt "-----paquete PKLDCPS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pkldcps.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkldcps.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_mo_comment.sql"
@src/gascaribe/ventas/sinonimos/adm_person.seq_mo_comment.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mo_admin_activity.sql"
@src/gascaribe/ventas/sinonimos/adm_person.mo_admin_activity.sql

prompt "--->Aplicando creacion de paquete adm_person.pkldcps.sql"
@src/gascaribe/ventas/paquetes/adm_person.pkldcps.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.pkldcps.sql"
@src/gascaribe/ventas/sinonimos/adm_person.pkldcps.sql


prompt "-----Script OSF-2878_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2878_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2878-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on

prompt "-----RECOMPILAR OBJETOS-----"
prompt "--->Aplicando recompilar objetos"
@src/test/recompilar-objetos.sql
show errors;
