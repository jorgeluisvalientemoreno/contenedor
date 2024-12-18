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

prompt "Aplicando src/general/sinonimos/dacc_promotion.sql"
@src/gascaribe/general/sinonimos/dacc_promotion.sql

prompt "Aplicando src/general/sinonimos/fa_mercrele.sql"
@src/gascaribe/general/sinonimos/fa_mercrele.sql

prompt "Aplicando src/general/sinonimos/formpago.sql"
@src/gascaribe/general/sinonimos/formpago.sql

prompt "Aplicando src/general/sinonimos/ge_attrib_set_attrib.sql"
@src/gascaribe/general/sinonimos/ge_attrib_set_attrib.sql

prompt "Aplicando src/general/sinonimos/ge_house_type.sql"
@src/gascaribe/general/sinonimos/ge_house_type.sql

prompt "Aplicando src/general/sinonimos/ge_subs_family_data.sql"
@src/gascaribe/general/sinonimos/ge_subs_family_data.sql

prompt "Aplicando src/general/sinonimos/ge_subs_referen_data.sql"
@src/gascaribe/general/sinonimos/ge_subs_referen_data.sql

prompt "Aplicando src/general/sinonimos/ge_third_part_serv.sql"
@src/gascaribe/general/sinonimos/ge_third_part_serv.sql

prompt "Aplicando src/general/sinonimos/ge_tytbstring.sql"
@src/gascaribe/general/sinonimos/ge_tytbstring.sql

prompt "Aplicando src/general/sinonimos/ld_fa_concrefe.sql"
@src/gascaribe/general/sinonimos/ld_fa_concrefe.sql

prompt "Aplicando src/general/sinonimos/ld_fa_critdesc.sql"
@src/gascaribe/general/sinonimos/ld_fa_critdesc.sql

prompt "Aplicando src/general/sinonimos/ld_fa_critrefe.sql"
@src/gascaribe/general/sinonimos/ld_fa_critrefe.sql

prompt "Aplicando src/general/sinonimos/ld_fa_descprpa.sql"
@src/gascaribe/general/sinonimos/ld_fa_descprpa.sql

prompt "Aplicando src/general/sinonimos/ld_fa_detadepp.sql"
@src/gascaribe/general/sinonimos/ld_fa_detadepp.sql

prompt "Aplicando src/general/sinonimos/ld_fa_fnu_paragene.sql"
@src/gascaribe/general/sinonimos/ld_fa_fnu_paragene.sql

prompt "Aplicando src/general/sinonimos/ld_fa_loprdred.sql"
@src/gascaribe/general/sinonimos/ld_fa_loprdred.sql

prompt "Aplicando src/general/sinonimos/ld_fa_loprdree.sql"
@src/gascaribe/general/sinonimos/ld_fa_loprdree.sql

prompt "Aplicando src/general/sinonimos/ld_fa_referido.sql"
@src/gascaribe/general/sinonimos/ld_fa_referido.sql

prompt "Aplicando src/general/sinonimos/ld_fa_ubgerefe.sql"
@src/gascaribe/general/sinonimos/ld_fa_ubgerefe.sql

prompt "Aplicando src/general/sinonimos/ldc_acta.sql"
@src/gascaribe/general/sinonimos/ldc_acta.sql

prompt "Aplicando src/general/sinonimos/ldc_analisis_suspcone.sql"
@src/gascaribe/general/sinonimos/ldc_analisis_suspcone.sql

prompt "Aplicando src/general/sinonimos/ldc_cargosfact_castigo_tmp.sql"
@src/gascaribe/general/sinonimos/ldc_cargosfact_castigo_tmp.sql

prompt "Aplicando src/general/sinonimos/ldc_configuracionaiu.sql"
@src/gascaribe/general/sinonimos/ldc_configuracionaiu.sql

prompt "Aplicando src/general/sinonimos/ldc_detafact_cast_gascaribe.sql"
@src/gascaribe/general/sinonimos/ldc_detafact_cast_gascaribe.sql

prompt "Aplicando src/general/sinonimos/ldc_items_audit.sql"
@src/gascaribe/general/sinonimos/ldc_items_audit.sql

prompt "Aplicando src/general/sinonimos/ldc_log_ldtcfa.sql"
@src/gascaribe/general/sinonimos/ldc_log_ldtcfa.sql

prompt "Aplicando src/general/sinonimos/ldc_prod_analisis_suspcone.sql"
@src/gascaribe/general/sinonimos/ldc_prod_analisis_suspcone.sql

prompt "Aplicando src/general/sinonimos/ldc_seq_facturacastig.sql"
@src/gascaribe/general/sinonimos/ldc_seq_facturacastig.sql

prompt "Aplicando src/general/sinonimos/ldc_tariconsfact.sql"
@src/gascaribe/general/sinonimos/ldc_tariconsfact.sql

prompt "Aplicando src/general/sinonimos/ldc_tt_local.sql"
@src/gascaribe/general/sinonimos/ldc_tt_local.sql

prompt "Aplicando src/general/sinonimos/ldci_actiubgttra.sql"
@src/gascaribe/general/sinonimos/ldci_actiubgttra.sql

prompt "Aplicando src/general/sinonimos/mo_motivo_promocion.sql"
@src/gascaribe/general/sinonimos/mo_motivo_promocion.sql

prompt "Aplicando src/general/sinonimos/or_tasktype_add_data.sql"
@src/gascaribe/general/sinonimos/or_tasktype_add_data.sql

prompt "Aplicando src/general/sinonimos/parafact.sql"
@src/gascaribe/general/sinonimos/parafact.sql

prompt "Aplicando src/general/sinonimos/pktblformpago.sql"
@src/gascaribe/general/sinonimos/pktblformpago.sql

prompt "Aplicando src/general/sinonimos/seq_detadepp.sql"
@src/gascaribe/general/sinonimos/seq_detadepp.sql

prompt "Aplicando src/general/sinonimos/seq_ld_fa_concrefe.sql"
@src/gascaribe/general/sinonimos/seq_ld_fa_concrefe.sql

prompt "Aplicando src/general/sinonimos/seq_ld_fa_critrefe.sql"
@src/gascaribe/general/sinonimos/seq_ld_fa_critrefe.sql

prompt "Aplicando src/general/sinonimos/seq_ld_fa_ubgrefe.sql"
@src/gascaribe/general/sinonimos/seq_ld_fa_ubgrefe.sql

prompt "Aplicando src/general/sinonimos/seq_ldc_items_audit.sql"
@src/gascaribe/general/sinonimos/seq_ldc_items_audit.sql

prompt "Aplicando src/general/sinonimos/cc_prom_detail.sql"
@src/gascaribe/general/sinonimos/cc_prom_detail.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ge_subs_work_relat.sql"
@src/gascaribe/general/sinonimos/ge_subs_work_relat.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ge_subs_housing_data.sql"
@src/gascaribe/general/sinonimos/ge_subs_housing_data.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ge_house_type.sql"
@src/gascaribe/general/sinonimos/ge_house_type.sql

prompt "Aplicando src/gascaribe/objetos-producto/tipos/permisos_OSF-2884.sql"
@src/gascaribe/objetos-producto/tipos/permisos_OSF-2884.sql

----------------------------------------------------------------
prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_ab_boaddressparser.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_ab_boaddressparser.sql

prompt "Aplicando src/general/paquetes/adm_person.ldc_ab_boaddressparser.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_ab_boaddressparser.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_bomaterialrequest.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bomaterialrequest.sql

prompt "Aplicando src/general/materiales/paquetes/adm_person.ldc_bomaterialrequest.sql"
@src/gascaribe/general/materiales/paquetes/adm_person.ldc_bomaterialrequest.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_bonotificaciones.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bonotificaciones.sql

prompt "Aplicando src/gascaribe/general/notification/paquetes/adm_person.ldc_bonotificaciones.sql"
@src/gascaribe/general/notification/paquetes/adm_person.ldc_bonotificaciones.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_pe_bcgestlist.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pe_bcgestlist.sql

prompt "Aplicando src/general/materiales/paquetes/adm_person.ldc_pe_bcgestlist.sql"
@src/gascaribe/general/materiales/paquetes/adm_person.ldc_pe_bcgestlist.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_pk_rep_ven.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pk_rep_ven.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/adm_person.ldc_pk_rep_ven.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_pk_rep_ven.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_pktariconsfact.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pktariconsfact.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/paquetes/adm_person.ldc_pktariconsfact.sql"
@src/gascaribe/facturacion/consumos/paquetes/adm_person.ldc_pktariconsfact.sql -- OK

prompt "Aplicando src/gascaribe/cartera/suspensiones/paquetes/ldc_pkvalidasuspcone.sql"
@src/gascaribe/cartera/suspensiones/paquetes/ldc_pkvalidasuspcone.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/paquetes/adm_person.ldc_pkvalidasuspcone.sql"
@src/gascaribe/cartera/suspensiones/paquetes/adm_person.ldc_pkvalidasuspcone.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_uildc_fifcast.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_uildc_fifcast.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.ldc_uildc_fifcast.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_uildc_fifcast.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_valida_order_redes.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_valida_order_redes.sql

prompt "Aplicando src/gascaribe/actas/ofertados/adm_person.ldc_valida_order_redes.sql"
@src/gascaribe/actas/ofertados/adm_person.ldc_valida_order_redes.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/pe_bceconomicactivity.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pe_bceconomicactivity.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pe_bceconomicactivity.sql"
@src/gascaribe/general/paquetes/adm_person.pe_bceconomicactivity.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/pe_bctasktypetax.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pe_bctasktypetax.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pe_bctasktypetax.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pe_bctasktypetax.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/pe_botasktypetax.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pe_botasktypetax.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pe_botasktypetax.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pe_botasktypetax.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/pkg_ldc_items_audit.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkg_ldc_items_audit.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldc_items_audit.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_items_audit.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/pkg_ldc_ordenes_ofert_red.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkg_ldc_ordenes_ofert_red.sql

prompt "Aplicando src/gascaribe/actas/ofertados/adm_person.pkg_ldc_ordenes_ofert_red.sql"
@src/gascaribe/actas/ofertados/adm_person.pkg_ldc_ordenes_ofert_red.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bcdescprpago.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bcdescprpago.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_bcdescprpago.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_bcdescprpago.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bcdiscountapplication.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bcdiscountapplication.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_bcdiscountapplication.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_bcdiscountapplication.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bclogprocdescref.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bclogprocdescref.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_bclogprocdescref.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_bclogprocdescref.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bcodedetadesc.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bcodedetadesc.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_bcodedetadesc.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_bcodedetadesc.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_boregistrardescuento.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_boregistrardescuento.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_boregistrardescuento.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_boregistrardescuento.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bsapplicationpddn.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bsapplicationpddn.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_bsapplicationpddn.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_bsapplicationpddn.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_concrefe.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_concrefe.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_concrefe.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_concrefe.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_critrefe.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_critrefe.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_critrefe.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_critrefe.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_ubgerefe.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_ubgerefe.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_ubgerefe.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_ubgerefe.sql -- OK

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_validarcontrato.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_validarcontrato.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_validarcontrato.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_validarcontrato.sql

---------------------------------------------------------------
prompt "Aplicando src/general/sinonimos/adm_person.ldc_ab_boaddressparser.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_ab_boaddressparser.sql

prompt "Aplicando src/general/materiales/sinonimos/adm_person.ldc_bomaterialrequest.sql"
@src/gascaribe/general/materiales/sinonimos/adm_person.ldc_bomaterialrequest.sql

prompt "Aplicando src/gascaribe/general/notification/sinonimos/adm_person.ldc_bonotificaciones.sql"
@src/gascaribe/general/notification/sinonimos/adm_person.ldc_bonotificaciones.sql

prompt "Aplicando src/general/materiales/sinonimos/adm_person.ldc_pe_bcgestlist.sql"
@src/gascaribe/general/materiales/sinonimos/adm_person.ldc_pe_bcgestlist.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_pk_rep_ven.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_pk_rep_ven.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/sinonimos/adm_person.ldc_pktariconsfact.sql"
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.ldc_pktariconsfact.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_pkvalidasuspcone.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_pkvalidasuspcone.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_uildc_fifcast.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_uildc_fifcast.sql

prompt "Aplicando src/gascaribe/actas/sinonimos/adm_person.ldc_valida_order_redes.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_valida_order_redes.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pe_bceconomicactivity.sql"
@src/gascaribe/general/sinonimos/adm_person.pe_bceconomicactivity.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pe_bctasktypetax.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pe_bctasktypetax.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pe_botasktypetax.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pe_botasktypetax.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ldc_items_audit.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ldc_items_audit.sql

prompt "Aplicando src/gascaribe/actas/sinonimos/adm_person.pkg_ldc_ordenes_ofert_red.sql"
@src/gascaribe/actas/sinonimos/adm_person.pkg_ldc_ordenes_ofert_red.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_bcdescprpago.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_bcdescprpago.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_bcdiscountapplication.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_bcdiscountapplication.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_bclogprocdescref.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_bclogprocdescref.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_bcodedetadesc.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_bcodedetadesc.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_boregistrardescuento.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_boregistrardescuento.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_bsapplicationpddn.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_bsapplicationpddn.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_concrefe.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_concrefe.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_critrefe.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_critrefe.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_ubgerefe.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_ubgerefe.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_validarcontrato.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_validarcontrato.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2884_act_obj_mig.sql"
@src/gascaribe/datafix/OSF-2884_act_obj_mig.sql

prompt "Recompilando objetos invalidos"
@src/test/recompilar-objetos.sql

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