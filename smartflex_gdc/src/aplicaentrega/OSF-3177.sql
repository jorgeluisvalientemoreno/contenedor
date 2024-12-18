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
prompt "Aplicando tipos"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/general/tipos/adm_person.mo_tytbcharges.sql"
@src/gascaribe/general/tipos/adm_person.mo_tytbcharges.sql

prompt "Aplicando src/gascaribe/general/tipos/adm_person.mo_tytbdeferred.sql"
@src/gascaribe/general/tipos/adm_person.mo_tytbdeferred.sql

prompt "Aplicando src/gascaribe/general/tipos/adm_person.mo_tytbquotasimulate.sql"
@src/gascaribe/general/tipos/adm_person.mo_tytbquotasimulate.sql

prompt "------------------------------------------------------"
prompt "Aplicando sinonimos"
prompt "------------------------------------------------------"


prompt "Aplicando src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.fm_discovery_type.sql"
@src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.fm_discovery_type.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.fm_involved_subsc.sql"
@src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.fm_involved_subsc.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.fa_consdist.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.fa_consdist.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.mo_tytbcharges.sql"
@src/gascaribe/fnb/sinonimos/adm_person.mo_tytbcharges.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.mo_tytbdeferred.sql"
@src/gascaribe/fnb/sinonimos/adm_person.mo_tytbdeferred.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.mo_tytbextrapayments.sql"
@src/gascaribe/fnb/sinonimos/adm_person.mo_tytbextrapayments.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.mo_tytbquotasimulate.sql"
@src/gascaribe/fnb/sinonimos/adm_person.mo_tytbquotasimulate.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.dald_article.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_article.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_boprocesruteros.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_boprocesruteros.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_clisincode.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_clisincode.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_codeudor.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_codeudor.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_eq_esta_civi_cardif.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_eq_esta_civi_cardif.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_eq_tipo_docu_cardif.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_eq_tipo_docu_cardif.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_pagunidet.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_pagunidet.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_pkventapagounico.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_pkventapagounico.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_policy_trasl.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_policy_trasl.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_provsincode.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_provsincode.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_segurovoluntario.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_segurovoluntario.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldci_outboxdet.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldci_outboxdet.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldci_outboxdetval.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldci_outboxdetval.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldci_pkcrmfinbrilla.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldci_pkcrmfinbrilla.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.seq_ldc_segurovoluntario.sql"
@src/gascaribe/fnb/sinonimos/adm_person.seq_ldc_segurovoluntario.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.seqldc_codeudor.sql"
@src/gascaribe/fnb/sinonimos/adm_person.seqldc_codeudor.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.cc_boossmotivecomponent.sql"
@src/gascaribe/general/sinonimos/adm_person.cc_boossmotivecomponent.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.dage_subs_general_data.sql"
@src/gascaribe/general/sinonimos/adm_person.dage_subs_general_data.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.dage_subs_phone.sql"
@src/gascaribe/general/sinonimos/adm_person.dage_subs_phone.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.damo_wf_pack_interfac.sql"
@src/gascaribe/general/sinonimos/adm_person.damo_wf_pack_interfac.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.daps_product_motive.sql"
@src/gascaribe/general/sinonimos/adm_person.daps_product_motive.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.fa_bchistcodi.sql"
@src/gascaribe/general/sinonimos/adm_person.fa_bchistcodi.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ld_boinstance.sql"
@src/gascaribe/general/sinonimos/adm_person.ld_boinstance.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkbcperifact.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkbcperifact.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkcontrolconexion.sql"
@src/gascaribe/general/sinonimos/adm_person.pkcontrolconexion.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkcouponmgr.sql"
@src/gascaribe/general/sinonimos/adm_person.pkcouponmgr.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pktblcategori.sql"
@src/gascaribe/general/sinonimos/adm_person.pktblcategori.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pktblsubcateg.sql"
@src/gascaribe/general/sinonimos/adm_person.pktblsubcateg.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ld_bcdatacred.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ld_bcdatacred.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_causalhomol.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_causalhomol.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldci_pkdatacredito.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldci_pkdatacredito.sql


prompt "------------------------------------------------------"
prompt "Aplicando migracion de objetos"
prompt "------------------------------------------------------"


prompt "Aplicando src/gascaribe/fnb/paquetes/ldci_pkconsultabrilla.sql"
@src/gascaribe/fnb/paquetes/ldci_pkconsultabrilla.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ldci_pkconsultabrilla.sql"
@src/gascaribe/fnb/paquetes/adm_person.ldci_pkconsultabrilla.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldci_pkconsultabrilla.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldci_pkconsultabrilla.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkcrmfinbrillaportal.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkcrmfinbrillaportal.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkcrmfinbrillaportal.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkcrmfinbrillaportal.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkcrmfinbrillaportal.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkcrmfinbrillaportal.sql

prompt "Aplicando src/gascaribe/fnb/seguros/cardif/paquetes/ut_ean_cardif.sql"
@src/gascaribe/fnb/seguros/cardif/paquetes/ut_ean_cardif.sql

prompt "Aplicando src/gascaribe/fnb/seguros/cardif/paquetes/adm_person.ut_ean_cardif.sql"
@src/gascaribe/fnb/seguros/cardif/paquetes/adm_person.ut_ean_cardif.sql

prompt "Aplicando src/gascaribe/fnb/seguros/sinonimos/adm_person.ut_ean_cardif.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ut_ean_cardif.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_bcnonbankfirules.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcnonbankfirules.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ld_bcnonbankfirules.sql"
@src/gascaribe/fnb/paquetes/adm_person.ld_bcnonbankfirules.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_bcnonbankfirules.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bcnonbankfirules.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_boliquidationminute.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boliquidationminute.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ld_boliquidationminute.sql"
@src/gascaribe/fnb/paquetes/adm_person.ld_boliquidationminute.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_boliquidationminute.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_boliquidationminute.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_boplugdatacred.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boplugdatacred.sql

prompt "Aplicando src/gascaribe/cartera/paquetes/adm_person.ld_boplugdatacred.sql"
@src/gascaribe/cartera/paquetes/adm_person.ld_boplugdatacred.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ld_boplugdatacred.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ld_boplugdatacred.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_boutilcancellations.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boutilcancellations.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ld_boutilcancellations.sql"
@src/gascaribe/fnb/paquetes/adm_person.ld_boutilcancellations.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_boutilcancellations.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_boutilcancellations.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_bcprecupon.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcprecupon.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ldc_bcprecupon.sql"
@src/gascaribe/fnb/paquetes/adm_person.ldc_bcprecupon.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_bcprecupon.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_bcprecupon.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_pkventafnb.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkventafnb.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ldc_pkventafnb.sql"
@src/gascaribe/fnb/paquetes/adm_person.ldc_pkventafnb.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_pkventafnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_pkventafnb.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ut_ean.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ut_ean.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ut_ean.sql"
@src/gascaribe/fnb/paquetes/adm_person.ut_ean.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ut_ean.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ut_ean.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/idautomation.sql"
@src/gascaribe/papelera-reciclaje/paquetes/idautomation.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.idautomation.sql"
@src/gascaribe/fnb/paquetes/adm_person.idautomation.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.idautomation.sql"
@src/gascaribe/fnb/sinonimos/adm_person.idautomation.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_bcflowfnbpack.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcflowfnbpack.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ld_bcflowfnbpack.sql"
@src/gascaribe/fnb/paquetes/adm_person.ld_bcflowfnbpack.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_bcflowfnbpack.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bcflowfnbpack.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_bcliquidationminute.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcliquidationminute.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ld_bcliquidationminute.sql"
@src/gascaribe/fnb/paquetes/adm_person.ld_bcliquidationminute.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_bcliquidationminute.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bcliquidationminute.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_bcpackagefnb.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcpackagefnb.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ld_bcpackagefnb.sql"
@src/gascaribe/fnb/paquetes/adm_person.ld_bcpackagefnb.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_bcpackagefnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bcpackagefnb.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_bcvisit.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcvisit.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ld_bcvisit.sql"
@src/gascaribe/fnb/paquetes/adm_person.ld_bcvisit.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_bcvisit.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bcvisit.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_bodatacred.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bodatacred.sql

prompt "Aplicando src/gascaribe/cartera/paquete/adm_person.ld_bodatacred.sql"
@src/gascaribe/cartera/paquete/adm_person.ld_bodatacred.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ld_bodatacred.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ld_bodatacred.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_bccotizacionconstructora.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bccotizacionconstructora.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/adm_person.ldc_bccotizacionconstructora.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_bccotizacionconstructora.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_bccotizacionconstructora.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_bccotizacionconstructora.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_bcdatacredito.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcdatacredito.sql

prompt "Aplicando src/gascaribe/cartera/paquetes/adm_person.ldc_bcdatacredito.sql"
@src/gascaribe/cartera/paquetes/adm_person.ldc_bcdatacredito.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_bcdatacredito.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_bcdatacredito.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_bcquotatransfer.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcquotatransfer.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ld_bcquotatransfer.sql"
@src/gascaribe/fnb/paquetes/adm_person.ld_bcquotatransfer.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_bcquotatransfer.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bcquotatransfer.sql

prompt "Aplicando src/gascaribe/objetos-obsoletos/ldc_calculacupobrilla.sql"
@src/gascaribe/objetos-obsoletos/ldc_calculacupobrilla.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ldc_calculacupobrilla.sql"
@src/gascaribe/fnb/paquetes/adm_person.ldc_calculacupobrilla.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_calculacupobrilla.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_calculacupobrilla.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_codeudores.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_codeudores.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ldc_codeudores.sql"
@src/gascaribe/fnb/paquetes/adm_person.ldc_codeudores.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_codeudores.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_codeudores.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_pktrasfnb.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pktrasfnb.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ldc_pktrasfnb.sql"
@src/gascaribe/fnb/paquetes/adm_person.ldc_pktrasfnb.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_pktrasfnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_pktrasfnb.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_pkventasegurovoluntario.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkventasegurovoluntario.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ldc_pkventasegurovoluntario.sql"
@src/gascaribe/fnb/paquetes/adm_person.ldc_pkventasegurovoluntario.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_pkventasegurovoluntario.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_pkventasegurovoluntario.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3177_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-3177_actualizar_obj_migrados.sql

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