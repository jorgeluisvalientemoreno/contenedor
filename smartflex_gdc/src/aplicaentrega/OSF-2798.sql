column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                  Aplicando Entrega OSF-2798                              "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "---------------- INICIA MIGRACION DE ESQUEMA -----------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------ 1.PAQUETE CC_BOCLAIMINSTANCEDATA_PNA ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  cc_boclaiminstancedata_pna.sql"
@src/gascaribe/papelera-reciclaje/paquetes/cc_boclaiminstancedata_pna.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.pagonoab.sql"
@src/gascaribe/general/sinonimos/adm_person.pagonoab.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.cc_boclaiminstancedata_pna.sql"
@src/gascaribe/general/paquetes/adm_person.cc_boclaiminstancedata_pna.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.cc_boclaiminstancedata_pna.sql"
@src/gascaribe/general/sinonimos/adm_person.cc_boclaiminstancedata_pna.sql
show errors;

prompt "                                                                          " 
prompt "------------ 2.PAQUETE GDC_BCSUSPENSION_XNO_CERT -------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  gdc_bcsuspension_xno_cert.sql"
@src/gascaribe/revision-periodica/suspension/paquetes/gdc_bcsuspension_xno_cert.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.plazos_cert_prev_covid19.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.plazos_cert_prev_covid19.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.gdc_bcsuspension_xno_cert.sql"
@src/gascaribe/revision-periodica/paquetes/adm_person.gdc_bcsuspension_xno_cert.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.gdc_bcsuspension_xno_cert.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.gdc_bcsuspension_xno_cert.sql
show errors;

prompt "                                                                          " 
prompt "------------ 3.PAQUETE IC_BOCOMPLETSERVICEINT_GDCA -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ic_bocompletserviceint_gdca.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ic_bocompletserviceint_gdca.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ge_geogra_loca_type.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ge_geogra_loca_type.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ic_tipodoco.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_tipodoco.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ic_docugene.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_docugene.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.openfltr.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.openfltr.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.servempr.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.servempr.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.terccobr.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.terccobr.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.tmp_cargproc.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.tmp_cargproc.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.ge_bcgeogra_location.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ge_bcgeogra_location.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.ge_boschedule.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ge_boschedule.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.ic_bccompletserviceint.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_bccompletserviceint.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.ldci_pkwebservutils.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_pkwebservutils.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.pkbcconcepto.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkbcconcepto.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.pkbcic_docugene.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkbcic_docugene.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.pkboaccountinginterface.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkboaccountinginterface.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.pkboprocessconcurrencectrl.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkboprocessconcurrencectrl.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.pktblciclo.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblciclo.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.pktblconcterc.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblconcterc.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.pktblic_movimien.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblic_movimien.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.pktblnotas.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblnotas.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.pktblservempr.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblservempr.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.pktblservicio.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblservicio.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.pktblsistema.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblsistema.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.pktblterccobr.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblterccobr.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.pktmpchargesmgr.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktmpchargesmgr.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.ic_bocompletserviceint_gdca.sql"
@src/gascaribe/general/interfaz-contable/paquetes/adm_person.ic_bocompletserviceint_gdca.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ic_bocompletserviceint_gdca.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_bocompletserviceint_gdca.sql
show errors;

prompt "                                                                          " 
prompt "------------ 4.PAQUETE LD_BOAVAILABLEUNIT --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ld_boavailableunit.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boavailableunit.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ld_available_unit.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ld_available_unit.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.ld_boavailableunit.sql"
@src/gascaribe/contratacion/paquetes/adm_person.ld_boavailableunit.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ld_boavailableunit.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ld_boavailableunit.sql
show errors;

prompt "                                                                          " 
prompt "------------ 5.PAQUETE LDC_BCGESTIONTARIFAS ------------------------------" 
prompt "                                                                          "

prompt --->Aplicando borrado al Paquete O P E N  ldc_bcgestiontarifas.sql
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcgestiontarifas.sql
show errors;

prompt --->Aplicando creación sinónimo a Tabla adm_person.ldc_conftari.sql
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_conftari.sql
show errors;

prompt --->Aplicando creación sinónimo a Tabla adm_person.ldc_temptari.sql
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_temptari.sql
show errors;

prompt --->Aplicando creación sinónimo a Tabla adm_person.ta_proytari.sql
@src/gascaribe/facturacion/sinonimos/adm_person.ta_proytari.sql
show errors;

prompt --->Aplicando creación sinónimo a Tabla adm_person.ta_rangvitc.sql
@src/gascaribe/facturacion/sinonimos/adm_person.ta_rangvitc.sql
show errors;

prompt --->Aplicando creación sinónimo a Tabla adm_person.ta_rangvitp.sql
@src/gascaribe/facturacion/sinonimos/adm_person.ta_rangvitp.sql
show errors;

prompt --->Aplicando creación sinónimo a Tabla adm_person.ta_taricopr.sql
@src/gascaribe/facturacion/sinonimos/adm_person.ta_taricopr.sql
show errors;

prompt --->Aplicando creación sinónimo a Tabla adm_person.ta_vigetacp.sql
@src/gascaribe/facturacion/sinonimos/adm_person.ta_vigetacp.sql
show errors;

prompt --->Aplicando creación sinónimo a Secuencia adm_person.sq_ta_proytari_prtacons.sql
@src/gascaribe/facturacion/sinonimos/adm_person.sq_ta_proytari_prtacons.sql
show errors;

prompt --->Aplicando creación sinónimo a Secuencia adm_person.sq_ta_rangvitc_ravtcons.sql
@src/gascaribe/facturacion/sinonimos/adm_person.sq_ta_rangvitc_ravtcons.sql
show errors;

prompt --->Aplicando creación sinónimo a Secuencia adm_person.sq_ta_rangvitp_ravpcons.sql
@src/gascaribe/facturacion/sinonimos/adm_person.sq_ta_rangvitp_ravpcons.sql
show errors;

prompt --->Aplicando creación sinónimo a Secuencia adm_person.sq_ta_tariconc_tacocons.sql
@src/gascaribe/facturacion/sinonimos/adm_person.sq_ta_tariconc_tacocons.sql
show errors;

prompt --->Aplicando creación sinónimo a Secuencia adm_person.sq_ta_taricopr_tacpcons.sql
@src/gascaribe/facturacion/sinonimos/adm_person.sq_ta_taricopr_tacpcons.sql
show errors;

prompt --->Aplicando creación sinónimo a Secuencia adm_person.sq_ta_vigetaco_vitccons.sql
@src/gascaribe/facturacion/sinonimos/adm_person.sq_ta_vigetaco_vitccons.sql
show errors;

prompt --->Aplicando creación sinónimo a Secuencia adm_person.sq_ta_vigetacp_vitpcons.sql
@src/gascaribe/facturacion/sinonimos/adm_person.sq_ta_vigetacp_vitpcons.sql
show errors;

prompt --->Aplicando creación sinónimo a Paquete adm_person.pktblta_rangvitc.sql
@src/gascaribe/facturacion/sinonimos/adm_person.pktblta_rangvitc.sql
show errors;

prompt --->Aplicando creación sinónimo a Paquete adm_person.pktblta_rangvitp.sql
@src/gascaribe/facturacion/sinonimos/adm_person.pktblta_rangvitp.sql
show errors;

prompt --->Aplicando creación sinónimo a Paquete adm_person.pktblta_taricopr.sql
@src/gascaribe/facturacion/sinonimos/adm_person.pktblta_taricopr.sql
show errors;

prompt --->Aplicando creación sinónimo a Paquete adm_person.pktblta_vigetaco.sql
@src/gascaribe/facturacion/sinonimos/adm_person.pktblta_vigetaco.sql
show errors;

prompt --->Aplicando creación sinónimo a Paquete adm_person.pktblta_vigetacp.sql
@src/gascaribe/facturacion/sinonimos/adm_person.pktblta_vigetacp.sql
show errors;

prompt --->Aplicando creación al nuevo Paquete adm_person.ldc_bcgestiontarifas.sql
@src/gascaribe/facturacion/paquetes/adm_person.ldc_bcgestiontarifas.sql
show errors;

prompt --->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_bcgestiontarifas.sql
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_bcgestiontarifas.sql
show errors;

prompt "                                                                          " 
prompt "------------ 6.PAQUETE LDC_BOREPORTES ------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_boreportes.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boreportes.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_boreportes.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_boreportes.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_boreportes.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_boreportes.sql
show errors;

prompt "                                                                          " 
prompt "------------ 7.PAQUETE LDC_PKACTCOPRSUCA2 --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkactcoprsuca2.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkactcoprsuca2.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.coprsuca.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.coprsuca.sql
show errors;

prompt "--->Aplicando creación sinónimo a Secuencia adm_person.ldc_seq_coprsuca.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_seq_coprsuca.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkactcoprsuca2.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_pkactcoprsuca2.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkactcoprsuca2.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_pkactcoprsuca2.sql
show errors;

prompt "                                                                          " 
prompt "------------ 8.PAQUETE LDC_PKANAREFINANOSF -------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkanarefinanosf.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkanarefinanosf.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.cartrefi.sql"
@src/gascaribe/cartera/sinonimo/adm_person.cartrefi.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_osf_proerror.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_osf_proerror.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.tmp_usuarefi.sql"
@src/gascaribe/cartera/sinonimo/adm_person.tmp_usuarefi.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkanarefinanosf.sql"
@src/gascaribe/cartera/paquete/adm_person.ldc_pkanarefinanosf.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkanarefinanosf.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_pkanarefinanosf.sql
show errors;

prompt "                                                                          " 
prompt "------------ 9.PAQUETE LDC_PKCOSTOINGRESO --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkcostoingreso.sql"
@src/gascaribe/general/interfaz-contable/paquetes/ldc_pkcostoingreso.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldci_cuingreclasi.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_cuingreclasi.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.dage_contratista.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.dage_contratista.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.ldci_pkinterfazactas.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_pkinterfazactas.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkcostoingreso.sql"
@src/gascaribe/general/interfaz-contable/paquetes/adm_person.ldc_pkcostoingreso.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkcostoingreso.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldc_pkcostoingreso.sql
show errors;

prompt "                                                                          " 
prompt "------------ 10.PAQUETE LDC_PKG_REPORTS_FACT -----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkg_reports_fact.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkg_reports_fact.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkg_reports_fact.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_pkg_reports_fact.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkg_reports_fact.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_pkg_reports_fact.sql
show errors;

prompt "                                                                          " 
prompt "------------ 11.PAQUETE LDC_PKGESTIOINTANCIA -----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkgestiointancia.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgestiointancia.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_traza_log.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_traza_log.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.wf_instance_attrib.sql"
@src/gascaribe/general/sinonimos/adm_person.wf_instance_attrib.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.wf_instance_data_map.sql"
@src/gascaribe/general/sinonimos/adm_person.wf_instance_data_map.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.wf_instance_equiv.sql"
@src/gascaribe/general/sinonimos/adm_person.wf_instance_equiv.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.wf_instance_status.sql"
@src/gascaribe/general/sinonimos/adm_person.wf_instance_status.sql
show errors;

prompt "--->Aplicando creación sinónimo a Secuencia adm_person.seq_wf_instance_trans.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_wf_instance_trans.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkgestiointancia.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_pkgestiointancia.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkgestiointancia.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_pkgestiointancia.sql
show errors;

prompt "                                                                          " 
prompt "------------ 12.PAQUETE LDC_PKGESTORDECARTA ------------------------------" 
prompt "----------------- RETIRADO DE LA ENTREGA ---------------------------------" 
prompt "                                                                          "

--prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkgestordecarta.sql"
--@src/gascaribe/revision-periodica/paquetes/ldc_pkgestordecarta.sql
--show errors;

--prompt "--->Aplicando creación sinónimo a Paquete adm_person.ut_mailpost.sql"
--@src/gascaribe/general/sinonimos/adm_person.ut_mailpost.sql
--show errors;

--prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkgestordecarta.sql"
--@src/gascaribe/general/paquetes/adm_person.ldc_pkgestordecarta.sql
--show errors;

--prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkgestordecarta.sql"
--@src/gascaribe/general/sinonimos/adm_person.ldc_pkgestordecarta.sql
--show errors;

prompt "                                                                          " 
prompt "------------ 13.PAQUETE LDC_PKGGECOPRFAMAS -------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkggecoprfamas.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkggecoprfamas.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_concdife.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_concdife.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_config_contingenc.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_config_contingenc.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_difeaproc_planaliv.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_difeaproc_planaliv.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_logprofact.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_logprofact.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_notas_masivas.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_notas_masivas.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_notas_masivas_log.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_notas_masivas_log.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_prcopppa.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_prcopppa.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_tiprodcondes.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_tiprodcondes.sql
show errors;

prompt "--->Aplicando creación sinónimo a Secuencia adm_person.seq_ld_quota_block.sql"
@src/gascaribe/fnb/sinonimos/adm_person.seq_ld_quota_block.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.ldc_pkgenotadife.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_pkgenotadife.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.ldc_pkggecoprfa.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_pkggecoprfa.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.pktblcargos.sql"
@src/gascaribe/fnb/sinonimos/adm_person.pktblcargos.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.cc_causal.sql"
@src/gascaribe/fnb/sinonimos/adm_person.cc_causal.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkggecoprfamas.sql"
@src/gascaribe/fnb/paquetes/adm_person.ldc_pkggecoprfamas.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkggecoprfamas.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_pkggecoprfamas.sql
show errors;

prompt "                                                                          " 
prompt "------------ 14.PAQUETE LDC_PKGLDCGESTERRRP ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkgldcgesterrrp.sql"
@src/gascaribe/revision-periodica/paquetes/ldc_pkgldcgesterrrp.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.ldc_pkgldcgesterrrp_per.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_pkgldcgesterrrp_per.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkgldcgesterrrp.sql"
@src/gascaribe/revision-periodica/paquetes/adm_person.ldc_pkgldcgesterrrp.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkgldcgesterrrp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_pkgldcgesterrrp.sql
show errors;


prompt "                                                                          " 
prompt "------------ 15.PAQUETE LDC_PKGPROCMUCTT ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkgprocmuctt.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgprocmuctt.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_clmucont.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_clmucont.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_ormugene.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_ormugene.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_tmlocalttra.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_tmlocalttra.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.ldc_bcsalescommission.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_bcsalescommission.sql
show errors;

prompt "--->Aplicando creación sinónimo a Procedimiento adm_person.ldc_prolenalogerror.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_prolenalogerror.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkgprocmuctt.sql"
@src/gascaribe/contratacion/paquetes/adm_person.ldc_pkgprocmuctt.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkgprocmuctt.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_pkgprocmuctt.sql
show errors;

prompt "                                                                          " 
prompt "------------ 16.PAQUETE LDC_PRAJUSORDESINACTA ----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_prajusordesinacta.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_prajusordesinacta.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_act_ouib.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_act_ouib.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_inv_ouib.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_inv_ouib.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_log_items_modif_sin_acta.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_log_items_modif_sin_acta.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_or_order_items_temp.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_or_order_items_temp.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.or_item_moveme_caus.sql"
@src/gascaribe/actas/sinonimos/adm_person.or_item_moveme_caus.sql
show errors;

prompt "--->Aplicando creación sinónimo a Secuencia adm_person.seq_ldc_log_items_modif_sin.sql"
@src/gascaribe/actas/sinonimos/adm_person.seq_ldc_log_items_modif_sin.sql
show errors;

prompt "--->Aplicando creación sinónimo a Secuencia adm_person.seq_ldc_or_order_items_temp.sql"
@src/gascaribe/actas/sinonimos/adm_person.seq_ldc_or_order_items_temp.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.cc_bcquotation.sql"
@src/gascaribe/actas/sinonimos/adm_person.cc_bcquotation.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.ct_bocontract.sql"
@src/gascaribe/actas/sinonimos/adm_person.ct_bocontract.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.dacc_quotation.sql"
@src/gascaribe/actas/sinonimos/adm_person.dacc_quotation.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.dage_item_classif.sql"
@src/gascaribe/actas/sinonimos/adm_person.dage_item_classif.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.daor_ope_uni_item_bala.sql"
@src/gascaribe/actas/sinonimos/adm_person.daor_ope_uni_item_bala.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.daor_uni_item_bala_mov.sql"
@src/gascaribe/actas/sinonimos/adm_person.daor_uni_item_bala_mov.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.ge_boitemsconstants.sql"
@src/gascaribe/actas/sinonimos/adm_person.ge_boitemsconstants.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.if_boprevmaintenance.sql"
@src/gascaribe/actas/sinonimos/adm_person.if_boprevmaintenance.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.ldc_pkgasignarcont.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_pkgasignarcont.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.or_bcadjustmentorder.sql"
@src/gascaribe/actas/sinonimos/adm_person.or_bcadjustmentorder.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.or_bcgenordinspecc.sql"
@src/gascaribe/actas/sinonimos/adm_person.or_bcgenordinspecc.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.or_bcorder.sql"
@src/gascaribe/actas/sinonimos/adm_person.or_bcorder.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.or_boconceptvalue.sql"
@src/gascaribe/actas/sinonimos/adm_person.or_boconceptvalue.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.or_boitems.sql"
@src/gascaribe/actas/sinonimos/adm_person.or_boitems.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.or_boitemvalue.sql"
@src/gascaribe/actas/sinonimos/adm_person.or_boitemvalue.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.or_boordercost.sql"
@src/gascaribe/actas/sinonimos/adm_person.or_boordercost.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.or_boorderitems.sql"
@src/gascaribe/actas/sinonimos/adm_person.or_boorderitems.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_prajusordesinacta.sql"
@src/gascaribe/actas/paquetes/adm_person.ldc_prajusordesinacta.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_prajusordesinacta.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_prajusordesinacta.sql
show errors;

prompt "                                                                          " 
prompt "------------ 17.PAQUETE LDCI_PKINTERFAZLISTPRECSAP -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldci_pkinterfazlistprecsap.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkinterfazlistprecsap.sql
show errors;

prompt "--->Aplicando creación sinónimo a Secuencia adm_person.seq_ge_list_unitary_cost.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.seq_ge_list_unitary_cost.sql
show errors;

prompt "--->Aplicando creación sinónimo a Secuencia adm_person.seq_ldci_intdetlistprec.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.seq_ldci_intdetlistprec.sql
show errors;

prompt "--->Aplicando creación sinónimo a Secuencia adm_person.seq_ldci_intelistpr.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.seq_ldci_intelistpr.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.dage_list_unitary_cost.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.dage_list_unitary_cost.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.dage_parameter.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.dage_parameter.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.dage_unit_cost_ite_lis.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.dage_unit_cost_ite_lis.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.ldci_intdetlistprec.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_intdetlistprec.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.ldci_intelistpr.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_intelistpr.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.ldci_pkinterfazlistprecsap.sql"
@src/gascaribe/general/interfaz-contable/paquetes/adm_person.ldci_pkinterfazlistprecsap.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldci_pkinterfazlistprecsap.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_pkinterfazlistprecsap.sql
show errors;

prompt "                                                                          " 
prompt "------------ 18.PAQUETE PKBORRADATOSCIERRE -------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  pkborradatoscierre.sql"
@src/gascaribe/Cierre/paquetes/pkborradatoscierre.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_osf_cier_part_conci.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_osf_cier_part_conci.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_osf_cier_reca.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_osf_cier_reca.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_osf_contrato.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_osf_contrato.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_osf_contribucion.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_osf_contribucion.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_osf_estad_ventas_brilla.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_osf_estad_ventas_brilla.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_osf_salbitemp.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_osf_salbitemp.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_osf_salcuini.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_osf_salcuini.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_osf_subsidio.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_osf_subsidio.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_osf_ventas_brilla.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_osf_ventas_brilla.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_snapshotcreg.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_snapshotcreg.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_usuexentos.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_usuexentos.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.pkborradatoscierre.sql"
@src/gascaribe/general/paquetes/adm_person.pkborradatoscierre.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.pkborradatoscierre.sql"
@src/gascaribe/general/sinonimos/adm_person.pkborradatoscierre.sql
show errors;

prompt "                                                                          " 
prompt "------------ 19.PAQUETE PKBORRADATOSCIERRE_GDC ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  pkborradatoscierre_gdc.sql"
@src/gascaribe/Cierre/paquetes/pkborradatoscierre_gdc.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.tmphilocargdif.sql"
@src/gascaribe/general/sinonimos/adm_person.tmphilocargdif.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_usuarios_loca_edad_mora.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_usuarios_loca_edad_mora.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_procesos_cierre.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_procesos_cierre.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_osf_sin_ctas_bril.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_osf_sin_ctas_bril.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_osf_ecuacart.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_osf_ecuacart.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_osf_cartconci.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_osf_cartconci.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_osf_cartticonc.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_osf_cartticonc.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.pkborradatoscierre_gdc.sql"
@src/gascaribe/general/paquetes/adm_person.pkborradatoscierre_gdc.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.pkborradatoscierre_gdc.sql"
@src/gascaribe/general/sinonimos/adm_person.pkborradatoscierre_gdc.sql
show errors;

prompt "                                                                          " 
prompt "------------ 20.PAQUETE PKORDENESSINACTA ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  pkordenessinacta.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkordenessinacta.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete adm_person.or_boadjustmentorder.sql"
@src/gascaribe/actas/sinonimos/adm_person.or_boadjustmentorder.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.pkordenessinacta.sql"
@src/gascaribe/actas/paquetes/adm_person.pkordenessinacta.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.pkordenessinacta.sql"
@src/gascaribe/actas/sinonimos/adm_person.pkordenessinacta.sql
show errors;


prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------------ TERMINA MIGRACION DE ESQUEMA --------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          " 
prompt "------------ ACTUALIZAR REGISTRO MASTER_PERSONALIZACIONES ----------------" 
prompt "                                                                          "

prompt "--->Aplicando ingreso de objetos en MASTER_PERSONALIZACIONES              "
@src/gascaribe/datafix/OSF-2798_Actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2798                           "
prompt "--------------------------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso Aplica Entrega!!
set timing off
set serveroutput off
set define on

prompt "                                                                          "
prompt "---------------------------RECOMPILAR OBJETOS-----------------------------"
prompt "                                                                          "

prompt "--->Aplicando recompilar objetos"
@src/test/recompilar-objetos.sql
show errors;
quit
/