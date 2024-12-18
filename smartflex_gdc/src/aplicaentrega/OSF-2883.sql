column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                  Aplicando Entrega OSF-2883                              "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "---------------- INICIA MIGRACION DE ESQUEMA -----------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------ 1.PAQUETE LDC_DSPERIODO -------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_dsperiodo.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsperiodo.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_dsperiodo.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_dsperiodo.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_dsperiodo.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_dsperiodo.sql
show errors;

prompt "                                                                          " 
prompt "------------ 2.PAQUETE LDC_DSPS_MOTIVE_STATUS ----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_dsps_motive_status.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsps_motive_status.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_dsps_motive_status.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_dsps_motive_status.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_dsps_motive_status.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_dsps_motive_status.sql
show errors;

prompt "                                                                          " 
prompt "------------ 3.PAQUETE LDC_DSPS_PACKAGE_TYPE -----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_dsps_package_type.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsps_package_type.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_dsps_package_type.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_dsps_package_type.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_dsps_package_type.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_dsps_package_type.sql
show errors;


prompt "                                                                          " 
prompt "------------ 4.PAQUETE LDC_DSPS_PRODUCT_STATUS ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_dsps_product_status.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsps_product_status.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_dsps_product_status.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_dsps_product_status.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_dsps_product_status.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_dsps_product_status.sql
show errors;


prompt "                                                                          " 
prompt "------------ 5.PAQUETE LDC_DSSUBCATEG ------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_dssubcateg.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dssubcateg.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_dssubcateg.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_dssubcateg.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_dssubcateg.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_dssubcateg.sql
show errors;


prompt "                                                                          " 
prompt "------------ 6.PAQUETE LDC_PAQUETEANEXOA ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_paqueteanexoa.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_paqueteanexoa.sql
show errors;
prompt "--->Aplicando creación sinónimo a Paquete adm_person.daldc_detarepoatecli.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/sinonimo/adm_person.daldc_detarepoatecli.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ge_tipo_unidad.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/sinonimo/adm_person.ge_tipo_unidad.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_detarepoatecli.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/sinonimo/adm_person.ldc_detarepoatecli.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_sui_tipres.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/sinonimo/adm_person.ldc_sui_tipres.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_paqueteanexoa.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/paquete/adm_person.ldc_paqueteanexoa.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_paqueteanexoa.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/sinonimo/adm_person.ldc_paqueteanexoa.sql
show errors;


prompt "                                                                          " 
prompt "------------ 7.PAQUETE LDC_PE_BOGESTLIST ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pe_bogestlist.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pe_bogestlist.sql
show errors;
prompt "--->Aplicando creación sinónimo a Paquete adm_person.daldc_tipoinc_bycon.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.daldc_tipoinc_bycon.sql
show errors;
prompt "--->Aplicando creación sinónimo a Paquete adm_person.ldc_pe_bcgestlist.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_pe_bcgestlist.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pe_bogestlist.sql"
@src/gascaribe/contratacion/paquetes/adm_person.ldc_pe_bogestlist.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pe_bogestlist.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_pe_bogestlist.sql
show errors;


prompt "                                                                          " 
prompt "------------ 8.PAQUETE LDC_PKANULSOLICDUPLI ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkanulsolicdupli.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkanulsolicdupli.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkanulsolicdupli.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_pkanulsolicdupli.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkanulsolicdupli.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_pkanulsolicdupli.sql
show errors;


prompt "                                                                          " 
prompt "------------ 9.PROCEDIMIENTO LDC_PKCM_RESCALCVAR -------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkcm_rescalcvar.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcm_rescalcvar.sql
show errors;
prompt "--->Aplicando creación sinónimo a Paquete adm_person.cm_bccorrectfactorsvars.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cm_bccorrectfactorsvars.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.cm_vavafaco.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cm_vavafaco.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_altura_loc.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_altura_loc.sql
show errors;
prompt "--->Aplicando creación sinónimo a Paquete adm_person.pktblcm_vavafaco.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pktblcm_vavafaco.sql
show errors;
prompt "--->Aplicando creación sinónimo a Secuencia adm_person.sq_cm_vavafaco_198733.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.sq_cm_vavafaco_198733.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkcm_rescalcvar.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_pkcm_rescalcvar.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkcm_rescalcvar.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_pkcm_rescalcvar.sql
show errors;


prompt "                                                                          " 
prompt "------------ 10.PROCEDIMIENTO LDC_PKDLRCLPB ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkdlrclpb.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkdlrclpb.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ge_civil_state.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ge_civil_state.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ge_profession.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ge_profession.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_personge_school_degree.sql"
@src/gascaribe/fnb/sinonimos/adm_personge_school_degree.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ge_wage_scale.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ge_wage_scale.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ld_quota_by_subsc.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_quota_by_subsc.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_dlrclpb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_dlrclpb.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_log_dlrclpb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_log_dlrclpb.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_pagunidat.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_pagunidat.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkdlrclpb.sql"
@src/gascaribe/fnb/paquetes/adm_person.ldc_pkdlrclpb.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkdlrclpb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_pkdlrclpb.sql
show errors;


prompt "                                                                          " 
prompt "------------ 11.PROCEDIMIENTO LDC_PKFORMVENTAGASFORM ---------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkformventagasform.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkformventagasform.sql
show errors;
prompt "--->Aplicando creación sinónimo a Paquete adm_person.expresar_en_letras.sql"
@src/gascaribe/ventas/sinonimos/adm_person.expresar_en_letras.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ld_deal.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ld_deal.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ld_ubication.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ld_ubication.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ta_taricopr.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ta_taricopr.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ta_vigetacp.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ta_vigetacp.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkformventagasform.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_pkformventagasform.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkformventagasform.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_pkformventagasform.sql
show errors;


prompt "                                                                          " 
prompt "------------ 12.PROCEDIMIENTO LDC_PKGENGAVBR -----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkgengavbr.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgengavbr.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ld_quota_historic.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_quota_historic.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_gavbr.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_gavbr.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_log_ldrgavbr.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_log_ldrgavbr.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.movidife.sql"
@src/gascaribe/fnb/sinonimos/adm_person.movidife.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkgengavbr.sql"
@src/gascaribe/fnb/paquetes/adm_person.ldc_pkgengavbr.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkgengavbr.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_pkgengavbr.sql
show errors;


prompt "                                                                          " 
prompt "------------ 13.PROCEDIMIENTO LDC_PKGENNOTACOMENER -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkgennotacomener.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgennotacomener.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_cme_donaciones.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_cme_donaciones.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_cme_ordenamiento.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_cme_ordenamiento.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_contcoen.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_contcoen.sql
show errors;
prompt "--->Aplicando creación sinónimo a Paquete adm_person.ldc_pkgestiontaritran.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_pkgestiontaritran.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkgennotacomener.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_pkgennotacomener.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkgennotacomener.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_pkgennotacomener.sql
show errors;


prompt "                                                                          " 
prompt "------------ 14.PROCEDIMIENTO LDC_PKGENVENFORMASI ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkgenvenformasi.sql"
@src/gascaribe/objetos-obsoletos/ldc_pkgenvenformasi.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_venformasiref.sql"
@src/gascaribe/objetos-obsoletos/sinonimos/adm_person.ldc_venformasiref.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_venformasitele.sql"
@src/gascaribe/objetos-obsoletos/sinonimos/adm_person.ldc_venformasitele.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkgenvenformasi.sql"
@src/gascaribe/objetos-obsoletos/adm_person.ldc_pkgenvenformasi.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkgenvenformasi.sql"
@src/gascaribe/objetos-obsoletos/sinonimos/adm_person.ldc_pkgenvenformasi.sql
show errors;


prompt "                                                                          " 
prompt "------------ 15.PROCEDIMIENTO LDC_PKGESTIONABONDECONS --------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkgestionabondecons.sql"
@src/gascaribe/facturacion/plan_piloto/paquetes/ldc_pkgestionabondecons.sql
show errors;
prompt "--->Aplicando creación sinónimo a Paquete adm_person.pkaccountstatusmgr.sql"
@src/gascaribe/facturacion/plan_piloto/sinonimos/adm_person.pkaccountstatusmgr.sql
show errors;
prompt "--->Aplicando creación sinónimo a Paquete adm_person.pkconsecutivemgr.sql"
@src/gascaribe/facturacion/plan_piloto/sinonimos/adm_person.pkconsecutivemgr.sql
show errors;
prompt "--->Aplicando creación sinónimo a Paquete adm_person.pktblfactura.sql"
@src/gascaribe/facturacion/plan_piloto/sinonimos/adm_person.pktblfactura.sql
show errors;
prompt "--->Aplicando creación sinónimo a Paquete adm_person.pktblmovidife.sql"
@src/gascaribe/facturacion/plan_piloto/sinonimos/adm_person.pktblmovidife.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkgestionabondecons.sql"
@src/gascaribe/facturacion/plan_piloto/paquetes/adm_person.ldc_pkgestionabondecons.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkgestionabondecons.sql"
@src/gascaribe/facturacion/plan_piloto/sinonimos/adm_person.ldc_pkgestionabondecons.sql
show errors;


prompt "                                                                          " 
prompt "------------ 16.PROCEDIMIENTO LDC_PKGESTIONACARTASREDES ------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkgestionacartasredes.sql"
@src/gascaribe/ingenieria/paquetes/ldc_pkgestionacartasredes.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_mail_geo_location.sql"
@src/gascaribe/ingenieria/sinonimos/adm_person.ldc_mail_geo_location.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_usercartaspolit.sql"
@src/gascaribe/ingenieria/sinonimos/adm_person.ldc_usercartaspolit.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkgestionacartasredes.sql"
@src/gascaribe/ingenieria/paquetes/adm_person.ldc_pkgestionacartasredes.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkgestionacartasredes.sql"
@src/gascaribe/ingenieria/sinonimos/adm_person.ldc_pkgestionacartasredes.sql
show errors;


prompt "                                                                          " 
prompt "------------ 17.PROCEDIMIENTO LDC_PKGESTIONITEMS -------------------------" 
prompt "                                                                          "


prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkgestionitems.sql"
@src/gascaribe/general/paquetes/ldc_pkgestionitems.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ge_attr_allowed_values.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_attr_allowed_values.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ge_items_attributes.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_items_attributes.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ge_items_gama.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_items_gama.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ge_items_tipo.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_items_tipo.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ge_measure_unit.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_measure_unit.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.if_element_class.sql"
@src/gascaribe/general/sinonimos/adm_person.if_element_class.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.if_element_type.sql"
@src/gascaribe/general/sinonimos/adm_person.if_element_type.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.or_actividad.sql"
@src/gascaribe/general/sinonimos/adm_person.or_actividad.sql
show errors;
prompt "--->Aplicando creación sinónimo a Secuencia adm_person.seq_ge_items_50000344.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ge_items_50000344.sql
show errors;
prompt "--->Aplicando creación sinónimo a Secuencia adm_person.seq_ge_items_gama_item.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ge_items_gama_item.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkgestionitems.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_pkgestionitems.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkgestionitems.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_pkgestionitems.sql
show errors;

prompt "                                                                          " 
prompt "------------ 18.PROCEDIMIENTO LDC_PKGPROCEFACTSPOOLATENCLI ---------------"
prompt "--------------- ( NO SE MIGRA, SE DEJA EN OPEN ) -------------------------" 
prompt "                                                                          "

prompt "                                                                          " 
prompt "------------ 19.PROCEDIMIENTO LDC_PKGPROCEFACTSPOOLCART ------------------"
prompt "--------------- ( NO SE MIGRA, SE DEJA EN OPEN ) -------------------------" 
prompt "                                                                          "

prompt "                                                                          " 
prompt "------------ 20.PROCEDIMIENTO LDC_PKGPROCEFACTSPOOLCONSU -----------------"   
prompt "--------------- ( NO SE MIGRA, SE DEJA EN OPEN ) -------------------------" 
prompt "                                                                          "

prompt "                                                                          " 
prompt "------------ 21.PROCEDIMIENTO LDC_PKGPROCEFACTSPOOLFAC -------------------" 
prompt "--------------- ( NO SE MIGRA, SE DEJA EN OPEN ) -------------------------" 
prompt "                                                                          "

prompt "                                                                          " 
prompt "------------ 22.PAQUETE LDC_PKGPROCREVPERFACT ----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkgprocrevperfact.sql"
@src/gascaribe/facturacion/spool/paquete/ldc_pkgprocrevperfact.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_confimensrp.sql"
@src/gascaribe/facturacion/spool/sinonimos/adm_person.ldc_confimensrp.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_infoprnorp.sql"
@src/gascaribe/facturacion/spool/sinonimos/adm_person.ldc_infoprnorp.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla personalizaciones.ldc_pkgprocrevperfact.sql"
@src/gascaribe/facturacion/spool/sinonimos/personalizaciones.ldc_pkgprocrevperfact.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkgprocrevperfact.sql"
@src/gascaribe/facturacion/spool/paquete/adm_person.ldc_pkgprocrevperfact.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkgprocrevperfact.sql"
@src/gascaribe/facturacion/spool/sinonimos/adm_person.ldc_pkgprocrevperfact.sql
show errors;


prompt "                                                                          " 
prompt "------------ 23.PAQUETE LDC_PKGRUTCONTCAM --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkgrutcontcam.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgrutcontcam.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_ciclgrci.sql"
@src/gascaribe/facturacion/spool/sinonimos/adm_person.ldc_ciclgrci.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_histo_rutas_fact.sql"
@src/gascaribe/facturacion/spool/sinonimos/adm_person.ldc_histo_rutas_fact.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.or_route.sql"
@src/gascaribe/facturacion/spool/sinonimos/adm_person.or_route.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkgrutcontcam.sql"
@src/gascaribe/facturacion/spool/paquete/adm_person.ldc_pkgrutcontcam.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkgrutcontcam.sql"
@src/gascaribe/facturacion/spool/sinonimos/adm_person.ldc_pkgrutcontcam.sql
show errors;


prompt "                                                                          " 
prompt "------------ 24.PAQUETE LDC_PKLDCCFA -------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pkldccfa.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkldccfa.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.ldc_audit_cambio_fact_actas.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_audit_cambio_fact_actas.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pkldccfa.sql"
@src/gascaribe/actas/paquetes/adm_person.ldc_pkldccfa.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pkldccfa.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_pkldccfa.sql
show errors;


prompt "                                                                          " 
prompt "------------ 25.PAQUETE LDC_PKSATABMIRROR --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  ldc_pksatabmirror.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pksatabmirror.sql
show errors;
prompt "--->Aplicando creación sinónimo a Paquete adm_person.ge_bosequence.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_bosequence.sql
show errors;
prompt "--->Aplicando creación sinónimo a Tabla adm_person.sa_tab_mirror.sql"
@src/gascaribe/general/sinonimos/adm_person.sa_tab_mirror.sql
show errors;
prompt "--->Aplicando creación al nuevo Paquete adm_person.ldc_pksatabmirror.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_pksatabmirror.sql
show errors;
prompt "--->Aplicando creación sinónimo del nuevo Paquete adm_person.ldc_pksatabmirror.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_pksatabmirror.sql
show errors;

prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------------ TERMINA MIGRACION DE ESQUEMA --------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          " 
prompt "------------ ACTUALIZAR REGISTRO MASTER_PERSONALIZACIONES ----------------" 
prompt "                                                                          "

prompt "--->Aplicando actualizacion en MASTER_PERSONALIZACIONES OSF-2883_Actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-2883_Actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2883                           "
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