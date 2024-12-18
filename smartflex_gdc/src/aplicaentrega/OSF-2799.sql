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


prompt "aplicando src/gascaribe/general/sinonimos/adm_person.pktblparametr.sql"
@src/gascaribe/general/sinonimos/adm_person.pktblparametr.sql

prompt "aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_return_item.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_return_item.sql

prompt "aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_return_item_detail.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_return_item_detail.sql

prompt "aplicando src/gascaribe/general/sinonimos/adm_person.wf_unit_type.sql"
@src/gascaribe/general/sinonimos/adm_person.wf_unit_type.sql

prompt "aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_suppli_settings.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_suppli_settings.sql

prompt "aplicando src/gascaribe/fnb/sinonimos/adm_person.seq_ld_price_list_deta.sql"
@src/gascaribe/fnb/sinonimos/adm_person.seq_ld_price_list_deta.sql

prompt "aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_price_list_deta.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_price_list_deta.sql

prompt "aplicando src/gascaribe/general/sinonimos/adm_person.dage_school_degree.sql"
@src/gascaribe/general/sinonimos/adm_person.dage_school_degree.sql

prompt "aplicando src/gascaribe/fnb/sinonimos/adm_person.seq_ld_price_list.sql"
@src/gascaribe/fnb/sinonimos/adm_person.seq_ld_price_list.sql

prompt "aplicando src/gascaribe/general/sinonimos/adm_person.dage_house_type.sql"
@src/gascaribe/general/sinonimos/adm_person.dage_house_type.sql

prompt "aplicando src/gascaribe/general/sinonimos/adm_person.ge_profession.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_profession.sql

prompt "aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_subline.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_subline.sql

prompt "aplicando src/gascaribe/general/sinonimos/adm_person.dage_civil_state.sql"
@src/gascaribe/general/sinonimos/adm_person.dage_civil_state.sql

prompt "aplicando src/gascaribe/gestion-contratista/sinonimos/adm_person.dage_contratista.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.dage_contratista.sql

prompt "aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_non_ban_fi_item.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_non_ban_fi_item.sql

prompt "aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_article.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_article.sql

prompt "aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_bccommercialsegmentfnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_bccommercialsegmentfnb.sql

prompt "aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsps_motive_status.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsps_motive_status.sql

prompt "aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsge_reception_type.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsge_reception_type.sql

prompt "aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsps_package_type.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsps_package_type.sql

prompt "aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsge_tipo_unidad.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsge_tipo_unidad.sql

prompt "aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsps_product_status.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsps_product_status.sql

prompt "aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dscc_commercial_plan.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dscc_commercial_plan.sql

prompt "aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dssubcateg.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dssubcateg.sql

prompt "aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsestacort.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsestacort.sql

prompt "aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_rememarc.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_rememarc.sql

prompt "aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_marca.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_marca.sql

prompt "aplicando src/gascaribe/facturacion/sinonimos/adm_person.coprsuca.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.coprsuca.sql

prompt "aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkbchicoprpm.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkbchicoprpm.sql

prompt "aplicando src/gascaribe/facturacion/sinonimos/adm_person.sq_perifact_pefacodi.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.sq_perifact_pefacodi.sql

prompt "aplicando src/gascaribe/facturacion/sinonimos/adm_person.seq_ldc_cargperi.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.seq_ldc_cargperi.sql

prompt "aplicando src/gascaribe/general/sinonimos/adm_person.sqesprprog.sql"
@src/gascaribe/general/sinonimos/adm_person.sqesprprog.sql

prompt "aplicando src/gascaribe/facturacion/sinonimos/adm_person.sq_pericose_pecscons.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.sq_pericose_pecscons.sql

prompt "aplicando src/gascaribe/facturacion/sinonimos/adm_person.seq_ldc_perilogc.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.seq_ldc_perilogc.sql

prompt "aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_concepto_diaria.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_concepto_diaria.sql

prompt "aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_tempnego.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_tempnego.sql

prompt "aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_tempnego.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_tempnego.sql

prompt "aplicando src/gascaribe/general/sinonimos/adm_person.ldc_logproc.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_logproc.sql

prompt "aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_metamensual.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_metamensual.sql

prompt "aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_grucat.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_grucat.sql

prompt "aplicando src/gascaribe/recaudos/sinonimos/adm_person.ldc_grupgeca.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.ldc_grupgeca.sql

prompt "aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_temp_cierrecartera_hilos.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_temp_cierrecartera_hilos.sql

prompt "aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_grupos.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_grupos.sql

prompt "aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_gruptipr.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_gruptipr.sql

prompt "aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_deta_prodrecu.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_deta_prodrecu.sql

prompt "aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_tarifas_gestcart.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_tarifas_gestcart.sql

prompt "aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_metas_cont_gestcobr.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_metas_cont_gestcobr.sql

prompt "aplicando src/gascaribe/general/sinonimos/adm_person.ldci_pkwebservutils.sql"
@src/gascaribe/general/sinonimos/adm_person.ldci_pkwebservutils.sql

prompt "aplicando src/gascaribe/cartera/sinonimo/adm_person.pkdeferredmgr.sql"
@src/gascaribe/cartera/sinonimo/adm_person.pkdeferredmgr.sql

prompt "aplicando src/gascaribe/cartera/sinonimo/adm_person.pkbcaccountstatus.sql"
@src/gascaribe/cartera/sinonimo/adm_person.pkbcaccountstatus.sql

prompt "aplicando src/gascaribe/cartera/sinonimo/adm_person.pkdeferredplanmgr.sql"
@src/gascaribe/cartera/sinonimo/adm_person.pkdeferredplanmgr.sql

prompt "aplicando src/gascaribe/facturacion/sinonimos/adm_person.concsopl.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.concsopl.sql

prompt "aplicando src/gascaribe/cartera/sinonimo/adm_person.cc_bcfinancing.sql"
@src/gascaribe/cartera/sinonimo/adm_person.cc_bcfinancing.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_dsge_geogra_location.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsge_geogra_location.sql

prompt "aplicando src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_dsge_geogra_location.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_dsge_geogra_location.sql

prompt "aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsge_geogra_location.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsge_geogra_location.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_dsge_items.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsge_items.sql

prompt "aplicando src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_dsge_items.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_dsge_items.sql

prompt "aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsge_items.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsge_items.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_dsmo_packages.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsmo_packages.sql

prompt "aplicando src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_dsmo_packages.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_dsmo_packages.sql

prompt "aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsmo_packages.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsmo_packages.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_dsor_operating_unit.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsor_operating_unit.sql

prompt "aplicando src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_dsor_operating_unit.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_dsor_operating_unit.sql

prompt "aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsor_operating_unit.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsor_operating_unit.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_dsor_order_status.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsor_order_status.sql

prompt "aplicando src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_dsor_order_status.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_dsor_order_status.sql

prompt "aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsor_order_status.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsor_order_status.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_dsor_task_type.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsor_task_type.sql

prompt "aplicando src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_dsor_task_type.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_dsor_task_type.sql

prompt "aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsor_task_type.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsor_task_type.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_dspr_product.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dspr_product.sql

prompt "aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dspr_product.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dspr_product.sql

prompt "aplicando src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_dspr_product.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_dspr_product.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_dsservsusc.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsservsusc.sql

prompt "aplicando src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_dsservsusc.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_dsservsusc.sql

prompt "aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsservsusc.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_dsservsusc.sql

prompt "aplicando src/gascaribe/facturacion/paquetes/ldc_pkbocargaperiodos.sql"
@src/gascaribe/facturacion/paquetes/ldc_pkbocargaperiodos.sql

prompt "aplicando src/gascaribe/facturacion/paquetes/adm_person.ldc_pkbocargaperiodos.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_pkbocargaperiodos.sql

prompt "aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_pkbocargaperiodos.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_pkbocargaperiodos.sql

prompt "aplicando src/gascaribe/cartera/liquidacion/paquetes/ldc_pkg_calc_gest_cartera.sql"
@src/gascaribe/cartera/liquidacion/paquetes/ldc_pkg_calc_gest_cartera.sql

prompt "aplicando src/gascaribe/cartera/paquete/adm_person.ldc_pkg_calc_gest_cartera.sql"
@src/gascaribe/cartera/paquete/adm_person.ldc_pkg_calc_gest_cartera.sql

prompt "aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_pkg_calc_gest_cartera.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_pkg_calc_gest_cartera.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_bccancellations.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bccancellations.sql

prompt "aplicando src/gascaribe/fnb/paquetes/adm_person.ld_bccancellations.sql"
@src/gascaribe/fnb/paquetes/adm_person.ld_bccancellations.sql

prompt "aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_bccancellations.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bccancellations.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_bcportafolio.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcportafolio.sql

prompt "aplicando src/gascaribe/fnb/paquetes/adm_person.ld_bcportafolio.sql"
@src/gascaribe/fnb/paquetes/adm_person.ld_bcportafolio.sql

prompt "aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_bcportafolio.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bcportafolio.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_bocommercialsegmentfnb.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bocommercialsegmentfnb.sql

prompt "aplicando src/gascaribe/fnb/paquetes/adm_person.ldc_bocommercialsegmentfnb.sql"
@src/gascaribe/fnb/paquetes/adm_person.ldc_bocommercialsegmentfnb.sql

prompt "aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_bocommercialsegmentfnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_bocommercialsegmentfnb.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_osspkevaluametodosavc.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_osspkevaluametodosavc.sql

prompt "aplicando src/gascaribe/perdidas-no-operacionales/paquetes/adm_person.ldc_osspkevaluametodosavc.sql"
@src/gascaribe/perdidas-no-operacionales/paquetes/adm_person.ldc_osspkevaluametodosavc.sql

prompt "aplicando src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.ldc_osspkevaluametodosavc.sql"
@src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.ldc_osspkevaluametodosavc.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcalcdatcartesp.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcalcdatcartesp.sql

prompt "aplicando src/gascaribe/cartera/paquetes/adm_person.ldc_pkcalcdatcartesp.sql"
@src/gascaribe/cartera/paquetes/adm_person.ldc_pkcalcdatcartesp.sql

prompt "aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_pkcalcdatcartesp.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_pkcalcdatcartesp.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_pkexcdifefina.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkexcdifefina.sql

prompt "aplicando src/gascaribe/cartera/paquetes/adm_person.ldc_pkexcdifefina.sql"
@src/gascaribe/cartera/paquetes/adm_person.ldc_pkexcdifefina.sql

prompt "aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_pkexcdifefina.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_pkexcdifefina.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_valfinplarefi.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_valfinplarefi.sql

prompt "aplicando src/gascaribe/cartera/paquetes/adm_person.ldc_valfinplarefi.sql"
@src/gascaribe/cartera/paquetes/adm_person.ldc_valfinplarefi.sql

prompt "aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_valfinplarefi.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_valfinplarefi.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_validalegcertnuevas.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_validalegcertnuevas.sql

prompt "aplicando src/gascaribe/revision-periodica/paquetes/adm_person.ldc_validalegcertnuevas.sql"
@src/gascaribe/revision-periodica/paquetes/adm_person.ldc_validalegcertnuevas.sql

prompt "aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_validalegcertnuevas.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_validalegcertnuevas.sql

prompt "aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkmatserializado.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkmatserializado.sql

prompt "aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkmatserializado.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkmatserializado.sql

prompt "aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkmatserializado.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkmatserializado.sql

prompt "aplicando src/gascaribe/datafix/OSF-2799_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-2799_actualizar_obj_migrados.sql

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