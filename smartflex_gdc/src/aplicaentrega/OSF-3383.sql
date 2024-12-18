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

-- Inicio Sinonimos privados sobre objetos del esquema OPEN 1
prompt "Aplicando src/gascaribe/general/sinonimos/ldc_solcaufnb.sql"
@src/gascaribe/general/sinonimos/ldc_solcaufnb.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_sui_titrcale.sql"
@src/gascaribe/general/sinonimos/ldc_sui_titrcale.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_sui_inconhomo.sql"
@src/gascaribe/general/sinonimos/ldc_sui_inconhomo.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_sui_respuesta.sql"
@src/gascaribe/general/sinonimos/ldc_sui_respuesta.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_sui_tipsol.sql"
@src/gascaribe/general/sinonimos/ldc_sui_tipsol.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_sui_confirepsuia.sql"
@src/gascaribe/general/sinonimos/ldc_sui_confirepsuia.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_sui_esot_sspd.sql"
@src/gascaribe/general/sinonimos/ldc_sui_esot_sspd.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_tmp_tiposoli.sql"
@src/gascaribe/general/sinonimos/ldc_tmp_tiposoli.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_sui_estsol.sql"
@src/gascaribe/general/sinonimos/ldc_sui_estsol.sql

prompt "Aplicando src/gascaribe/general/sinonimos/seq_ldc_proteccion_datos.sql"
@src/gascaribe/general/sinonimos/seq_ldc_proteccion_datos.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_sui_caus_equ.sql"
@src/gascaribe/general/sinonimos/ldc_sui_caus_equ.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_sui_validaciones.sql"
@src/gascaribe/general/sinonimos/ldc_sui_validaciones.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_sui_medrec.sql"
@src/gascaribe/general/sinonimos/ldc_sui_medrec.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ldc_proteccion_datos.sql"
@src/gascaribe/general/sinonimos/ldcbi_ldc_proteccion_datos.sql
-- Fin Sinonimos privados sobre objetos del esquema OPEN 1

-- Inicio Sinonimos privados sobre objetos del esquema OPEN 2
prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ldc_osf_costingr.sql"
@src/gascaribe/general/sinonimos/ldcbi_ldc_osf_costingr.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ldc_segment_susc.sql"
@src/gascaribe/general/sinonimos/ldcbi_ldc_segment_susc.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_osf_ldcrbai.sql"
@src/gascaribe/general/sinonimos/ldc_osf_ldcrbai.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ct_simple_cond_items.sql"
@src/gascaribe/general/sinonimos/ct_simple_cond_items.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_prodexclrp.sql"
@src/gascaribe/general/sinonimos/ldc_prodexclrp.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ldc_otlegalizar.sql"
@src/gascaribe/general/sinonimos/ldcbi_ldc_otlegalizar.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ldc_prodtatt.sql"
@src/gascaribe/general/sinonimos/ldcbi_ldc_prodtatt.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_log_prodexclrp.sql"
@src/gascaribe/general/sinonimos/ldc_log_prodexclrp.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_audi_taskactcostprom.sql"
@src/gascaribe/general/sinonimos/ldc_audi_taskactcostprom.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_tipo_energetico.sql"
@src/gascaribe/general/sinonimos/ldc_tipo_energetico.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ldc_solcaufnb.sql"
@src/gascaribe/general/sinonimos/ldcbi_ldc_solcaufnb.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_pkinfoauditoria.sql"
@src/gascaribe/general/sinonimos/ldc_pkinfoauditoria.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ldc_pagunidat.sql"
@src/gascaribe/general/sinonimos/ldcbi_ldc_pagunidat.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ldc_pkg_or_item.sql"
@src/gascaribe/general/sinonimos/ldcbi_ldc_pkg_or_item.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_vista_uni_ope_tip_tra_vw.sql"
@src/gascaribe/general/sinonimos/ldc_vista_uni_ope_tip_tra_vw.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_tarifas_otgepacont_audi.sql"
@src/gascaribe/general/sinonimos/ldc_tarifas_otgepacont_audi.sql

prompt "Aplicando src/gascaribe/general/sinonimos/dapr_prod_suspension.sql"
@src/gascaribe/general/sinonimos/dapr_prod_suspension.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ldc_prod_comerc_sector.sql"
@src/gascaribe/general/sinonimos/ldcbi_ldc_prod_comerc_sector.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_tarifas_otgepacont.sql"
@src/gascaribe/general/sinonimos/ldc_tarifas_otgepacont.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_suia_resolucion.sql"
@src/gascaribe/general/sinonimos/ldc_suia_resolucion.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ldc_segurovoluntario.sql"
@src/gascaribe/general/sinonimos/ldcbi_ldc_segurovoluntario.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_simple_cond_items.sql"
@src/gascaribe/general/sinonimos/ldc_simple_cond_items.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_soluniopeaap.sql"
@src/gascaribe/general/sinonimos/ldc_soluniopeaap.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_tarifas_gestcart_audi.sql"
@src/gascaribe/general/sinonimos/ldc_tarifas_gestcart_audi.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_rgcoma.sql"
@src/gascaribe/general/sinonimos/ldc_rgcoma.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_reginfaud.sql"
@src/gascaribe/general/sinonimos/ldc_reginfaud.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_rgcoma_log.sql"
@src/gascaribe/general/sinonimos/ldc_rgcoma_log.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ldc_osf_ldcrbai.sql"
@src/gascaribe/general/sinonimos/ldcbi_ldc_osf_ldcrbai.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_ldc_plazos_cert.sql"
@src/gascaribe/general/sinonimos/ldcbi_ldc_plazos_cert.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_solasiautpor.sql"
@src/gascaribe/general/sinonimos/ldc_solasiautpor.sql
-- Fin Sinonimos privados sobre objetos del esquema OPEN 2

-- Inicio Borrado de triggers en el esquema OPEN 1
prompt "Aplicando src/gascaribe/revision-periodica/plazos/trigger/ldc_trg_marca_producto_gdc.sql"
@src/gascaribe/revision-periodica/plazos/trigger/ldc_trg_marca_producto_gdc.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/proteccion-datos/trigger/trg_bi_ldc_proteccion_datos.sql"
@src/gascaribe/atencion-usuarios/proteccion-datos/trigger/trg_bi_ldc_proteccion_datos.sql

prompt "Aplicando src/gascaribe/cartera/Financiacion/triggers/trg_de_ldc_proteccion_datos.sql"
@src/gascaribe/cartera/Financiacion/triggers/trg_de_ldc_proteccion_datos.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/Pagos-Parciales/trigger/ldc_traisolabofnb.sql"
@src/gascaribe/atencion-usuarios/Pagos-Parciales/trigger/ldc_traisolabofnb.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/reporte-sui/trigger/ldctrg_confirepsuia.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/trigger/ldctrg_confirepsuia.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/triggers/ldc_trgb_templocfaco.sql"
@src/gascaribe/facturacion/consumos/triggers/ldc_trgb_templocfaco.sql
-- Fin Borrado de triggers en el esquema OPEN 1

-- Inicio Borrado de triggers en el esquema OPEN 2
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldc_ormugene.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldc_ormugene.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_osf_costingr.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_osf_costingr.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_osf_ldcrbai.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_osf_ldcrbai.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_otlegalizar.sql" 
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_otlegalizar.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_pagunidat.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_pagunidat.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_pkg_or_item.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_pkg_or_item.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trginsldc_plandife.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trginsldc_plandife.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_biu_plazo_cert.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_biu_plazo_cert.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trggehistcert.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trggehistcert.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_marca_producto.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_marca_producto.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_plazos_cert.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_plazos_cert.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_tgactualizavigenciafin.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_tgactualizavigenciafin.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgbprocacti_actividad.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgbprocacti_actividad.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_prod_com_sector.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_prod_com_sector.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trghistprodex.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trghistprodex.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_prodtatt.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_prodtatt.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_upsert_ldc_promo_fnb.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_upsert_ldc_promo_fnb.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bf_provsincode.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bf_provsincode.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trggenarcinfaud.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trggenarcinfaud.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgldc_resogure.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgldc_resogure.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgrgcomaai.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgrgcomaai.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgrgcomabi.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgrgcomabi.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_segment_susc.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_segment_susc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_segurovoluntario.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_segurovoluntario.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldc_simple_cond_items.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldc_simple_cond_items.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgb_solasiautpor.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgb_solasiautpor.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_solcaufnb.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_solcaufnb.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trgaldc_soluniopeaap.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trgaldc_soluniopeaap.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_specials_plan.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_specials_plan.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrg_ldc_sui_estsol.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrg_ldc_sui_estsol.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrg_ldc_sui_tipsol.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrg_ldc_sui_tipsol.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldctrg_ldcresolsui.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldctrg_ldcresolsui.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldc_tarifas_gestcart.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldc_tarifas_gestcart.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_aud_ldc_tarifas_otgepacont.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_aud_ldc_tarifas_otgepacont.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldc_taskactcostprom.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ldc_taskactcostprom.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_aud_ldc_taskactcostprom.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_aud_ldc_taskactcostprom.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_detrgb_templocfaco.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_detrgb_templocfaco.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trga_templocfaco.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trga_templocfaco.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_uptrgb_templocfaco.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_uptrgb_templocfaco.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trguptipoener.sql"
@src/gascaribe/papelera-reciclaje/triggers/ldc_trguptipoener.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ttnovofertados.sql" -- Aqui
@src/gascaribe/papelera-reciclaje/triggers/ldc_trg_ttnovofertados.sql
-- Fin Borrado de triggers en el esquema OPEN 2

-- Inicio Creación de triggers en el esquema ADM_PERSON 1
prompt "Aplicando src/gascaribe/revision-periodica/plazos/trigger/adm_person.ldc_trg_marca_producto_gdc.sql"
@src/gascaribe/revision-periodica/plazos/trigger/adm_person.ldc_trg_marca_producto_gdc.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/proteccion-datos/trigger/adm_person.trg_bi_ldc_proteccion_datos.sql"
@src/gascaribe/atencion-usuarios/proteccion-datos/trigger/adm_person.trg_bi_ldc_proteccion_datos.sql

prompt "Aplicando src/gascaribe/cartera/Financiacion/triggers/adm_person.trg_de_ldc_proteccion_datos.sql"
@src/gascaribe/cartera/Financiacion/triggers/adm_person.trg_de_ldc_proteccion_datos.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/Pagos-Parciales/trigger/adm_person.ldc_traisolabofnb.sql"
@src/gascaribe/atencion-usuarios/Pagos-Parciales/trigger/adm_person.ldc_traisolabofnb.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/reporte-sui/trigger/adm_person.ldctrg_confirepsuia.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/trigger/adm_person.ldctrg_confirepsuia.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/triggers/adm_person.ldc_trgb_templocfaco.sql"
@src/gascaribe/facturacion/consumos/triggers/adm_person.ldc_trgb_templocfaco.sql
-- Fin Creación de triggers en el esquema ADM_PERSON 1

-- Inicio Creación de triggers en el esquema ADM_PERSON 2
prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldc_ormugene.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldc_ormugene.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ldc_osf_costingr.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ldc_osf_costingr.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ldc_osf_ldcrbai.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ldc_osf_ldcrbai.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ldc_otlegalizar.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ldc_otlegalizar.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ldc_pagunidat.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ldc_pagunidat.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ldc_pkg_or_item.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ldc_pkg_or_item.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trginsldc_plandife.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trginsldc_plandife.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trg_biu_plazo_cert.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trg_biu_plazo_cert.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trggehistcert.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trggehistcert.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trg_marca_producto.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trg_marca_producto.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ldc_plazos_cert.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ldc_plazos_cert.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_tgactualizavigenciafin.sql"
@src/gascaribe/general/trigger/adm_person.ldc_tgactualizavigenciafin.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgbprocacti_actividad.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgbprocacti_actividad.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ldc_prod_com_sector.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ldc_prod_com_sector.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trghistprodex.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trghistprodex.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ldc_prodtatt.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ldc_prodtatt.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trg_upsert_ldc_promo_fnb.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trg_upsert_ldc_promo_fnb.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bf_provsincode.sql"
@src/gascaribe/general/trigger/adm_person.trg_bf_provsincode.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trggenarcinfaud.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trggenarcinfaud.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgldc_resogure.sql"
@src/gascaribe/general/trigger/adm_person.trgldc_resogure.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgrgcomaai.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgrgcomaai.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgrgcomabi.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgrgcomabi.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ldc_segment_susc.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ldc_segment_susc.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ldc_segurovoluntario.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ldc_segurovoluntario.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldc_simple_cond_items.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldc_simple_cond_items.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgb_solasiautpor.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgb_solasiautpor.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_bi_ldc_solcaufnb.sql"
@src/gascaribe/general/trigger/adm_person.trg_bi_ldc_solcaufnb.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trgaldc_soluniopeaap.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trgaldc_soluniopeaap.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_specials_plan.sql"
@src/gascaribe/general/trigger/adm_person.trg_specials_plan.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldctrg_ldc_sui_estsol.sql"
@src/gascaribe/general/trigger/adm_person.ldctrg_ldc_sui_estsol.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldctrg_ldc_sui_tipsol.sql"
@src/gascaribe/general/trigger/adm_person.ldctrg_ldc_sui_tipsol.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldctrg_ldcresolsui.sql"
@src/gascaribe/general/trigger/adm_person.ldctrg_ldcresolsui.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldc_tarifas_gestcart.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldc_tarifas_gestcart.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_aud_ldc_tarifas_otgepacont.sql"
@src/gascaribe/general/trigger/adm_person.trg_aud_ldc_tarifas_otgepacont.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trg_ldc_taskactcostprom.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trg_ldc_taskactcostprom.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_aud_ldc_taskactcostprom.sql"
@src/gascaribe/general/trigger/adm_person.trg_aud_ldc_taskactcostprom.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_detrgb_templocfaco.sql"
@src/gascaribe/general/trigger/adm_person.ldc_detrgb_templocfaco.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trga_templocfaco.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trga_templocfaco.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_uptrgb_templocfaco.sql"
@src/gascaribe/general/trigger/adm_person.ldc_uptrgb_templocfaco.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trguptipoener.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trguptipoener.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trg_ttnovofertados.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trg_ttnovofertados.sql
-- Fin Creación de triggers en el esquema ADM_PERSON 2

-- Inicio Actualización de Objetos en master_personalizaciones
prompt "Aplicando src/gascaribe/datafix/OSF-3383_act_obj_mig.sql"
@src/gascaribe/datafix/OSF-3383_act_obj_mig.sql
-- Fin Actualización de Objetos en master_personalizaciones


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