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

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldcusuadifcartlicuencob.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldcusuadifcartlicuencob.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_usuarios_actualiza_cl.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_usuarios_actualiza_cl.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_esprocardiaria.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_esprocardiaria.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_concepto_diaria.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_concepto_diaria.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp12.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp12.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp11.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp11.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp10.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp10.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp9.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp9.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp8.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp8.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp7.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp7.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp6.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp6.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp5.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp5.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp4.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp4.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp3.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp3.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp2.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp2.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria_tmp.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.cc_bobssproductdata.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.cc_bobssproductdata.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.cc_bobsssubscriptiondata.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.cc_bobsssubscriptiondata.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.cc_bocertificate.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.cc_bocertificate.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.cc_bosubscription.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.cc_bosubscription.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.cm_noticrit.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.cm_noticrit.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.daestacort.sql"
@src/gascaribe/cartera/sinonimo/adm_person.daestacort.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.dald_quota_historic.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_quota_historic.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.dald_quota_transfer.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_quota_transfer.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.fa_boserviciosliqporproducto.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.fa_boserviciosliqporproducto.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.fsbaplicaentrega.sql"
@src/gascaribe/general/sinonimos/adm_person.fsbaplicaentrega.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.gdc_dsldc_plazos_cert.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.gdc_dsldc_plazos_cert.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.gdc_dsldc_usuarios_susp_y_noti.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.gdc_dsldc_usuarios_susp_y_noti.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.gdc_dsusuarios_no_aplica_su_no.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.gdc_dsusuarios_no_aplica_su_no.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_bogeogra_location.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_bogeogra_location.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_bosequence.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_bosequence.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_subscriber_type.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_subscriber_type.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_bcnonbankfinancing.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bcnonbankfinancing.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_bcquotatransfer.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bcquotatransfer.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_boflowfnbpack.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_boflowfnbpack.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_bopackagefnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bopackagefnb.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_edocta.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_edocta.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_email.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_email.sql

prompt "Aplicando src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_novelty_conditions.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_novelty_conditions.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_tipotrab_certifica.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_tipotrab_certifica.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_usuarios_susp_y_noti.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_usuarios_susp_y_noti.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_quota_by_subsc.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_quota_by_subsc.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_quota_transfer.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_quota_transfer.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_route.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_route.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_route_premise.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_route_premise.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_route_premise.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_route_premise.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkbiut_jobmgr.sql"
@src/gascaribe/general/sinonimos/adm_person.pkbiut_jobmgr.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkstatusexeprogrammgr.sql"
@src/gascaribe/general/sinonimos/adm_person.pkstatusexeprogrammgr.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.pksuspconnservicemgr.sql"
@src/gascaribe/cartera/sinonimo/adm_person.pksuspconnservicemgr.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pktblciclcons.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pktblciclcons.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pktblsistema.sql"
@src/gascaribe/general/sinonimos/adm_person.pktblsistema.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.procesos.sql"
@src/gascaribe/general/sinonimos/adm_person.procesos.sql

prompt "Aplicando src/gascaribe/predios/sinonimos/adm_person.seq_ldc_info_predio.sql"
@src/gascaribe/predios/sinonimos/adm_person.seq_ldc_info_predio.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.usuarios_no_aplica_suspe_notif.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.usuarios_no_aplica_suspe_notif.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ut_mail.sql"
@src/gascaribe/general/sinonimos/adm_person.ut_mail.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_activity.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_activity.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.gdc_bcsuspension_xno_cert.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.gdc_bcsuspension_xno_cert.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkbcprocejec.sql"
@src/gascaribe/general/sinonimos/adm_person.pkbcprocejec.sql

prompt "Aplicando src/gascaribe/revision-periodica/suspension/paquetes/gdc_bosuspension_xno_cert.sql"
@src/gascaribe/revision-periodica/suspension/paquetes/gdc_bosuspension_xno_cert.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/adm_person.gdc_bosuspension_xno_cert.sql"
@src/gascaribe/revision-periodica/paquetes/adm_person.gdc_bosuspension_xno_cert.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.gdc_bosuspension_xno_cert.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.gdc_bosuspension_xno_cert.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_bolastsuspensiondata.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bolastsuspensiondata.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/adm_person.ld_bolastsuspensiondata.sql"
@src/gascaribe/revision-periodica/paquetes/adm_person.ld_bolastsuspensiondata.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ld_bolastsuspensiondata.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ld_bolastsuspensiondata.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_boquerypolicy.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boquerypolicy.sql

prompt "Aplicando src/gascaribe/fnb/seguros/paquetes/adm_person.ld_boquerypolicy.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.ld_boquerypolicy.sql

prompt "Aplicando src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_boquerypolicy.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_boquerypolicy.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_boquotatransfer.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boquotatransfer.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.ld_boquotatransfer.sql"
@src/gascaribe/fnb/paquetes/adm_person.ld_boquotatransfer.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_boquotatransfer.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_boquotatransfer.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_api_predio.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_api_predio.sql

prompt "Aplicando src/gascaribe/predios/paquetes/adm_person.ldc_api_predio.sql"
@src/gascaribe/predios/paquetes/adm_person.ldc_api_predio.sql

prompt "Aplicando src/gascaribe/predios/sinonimos/adm_person.ldc_api_predio.sql"
@src/gascaribe/predios/sinonimos/adm_person.ldc_api_predio.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/ldc_asigdircontructoras.sql"
@src/gascaribe/ventas/paquetes/ldc_asigdircontructoras.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/adm_person.ldc_asigdircontructoras.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_asigdircontructoras.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_asigdircontructoras.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_asigdircontructoras.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_bclegalordenventas.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bclegalordenventas.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/adm_person.ldc_bclegalordenventas.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_bclegalordenventas.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_bclegalordenventas.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_bclegalordenventas.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_bcnotificacionescritica.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcnotificacionescritica.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.ldc_bcnotificacionescritica.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_bcnotificacionescritica.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_bcnotificacionescritica.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_bcnotificacionescritica.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_boasociados.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boasociados.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.ldc_boasociados.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.ldc_boasociados.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_boasociados.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_boasociados.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_boassingorder.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boassingorder.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.ldc_boassingorder.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.ldc_boassingorder.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_boassingorder.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_boassingorder.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_boconsparam.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boconsparam.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.ldc_boconsparam.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_boconsparam.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_boconsparam.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_boconsparam.sql

prompt "Aplicando src/gascaribe/facturacion/notificaciones/paquetes/LDC_BONOTYCONSREC.sql"
@src/gascaribe/facturacion/notificaciones/paquetes/LDC_BONOTYCONSREC.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.ldc_bonotyconsrec.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_bonotyconsrec.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_bonotyconsrec.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_bonotyconsrec.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_boregisternovelty.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boregisternovelty.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.ldc_boregisternovelty.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.ldc_boregisternovelty.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_boregisternovelty.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_boregisternovelty.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_ca_noti.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_ca_noti.sql

prompt "Aplicando src/gascaribe/cartera/paquete/adm_person.ldc_ca_noti.sql"
@src/gascaribe/cartera/paquete/adm_person.ldc_ca_noti.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_ca_noti.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_ca_noti.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_crmpazysalvo.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_crmpazysalvo.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_crmpazysalvo.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_crmpazysalvo.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_crmpazysalvo.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_crmpazysalvo.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_estadocuenta.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_estadocuenta.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.ldc_estadocuenta.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_estadocuenta.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_estadocuenta.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_estadocuenta.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_estadocuentacastigada.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_estadocuentacastigada.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.ldc_estadocuentacastigada.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_estadocuentacastigada.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_estadocuentacastigada.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_estadocuentacastigada.sql

prompt "Aplicando src/gascaribe/cartera/reportes/paquetes/ldc_pk_cartera_diaria.sql"
@src/gascaribe/cartera/reportes/paquetes/ldc_pk_cartera_diaria.sql

prompt "Aplicando src/gascaribe/cartera/reportes/paquetes/adm_person.ldc_pk_cartera_diaria.sql"
@src/gascaribe/cartera/reportes/paquetes/adm_person.ldc_pk_cartera_diaria.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_pk_cartera_diaria.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_pk_cartera_diaria.sql

@src/gascaribe/papelera-reciclaje/paquetes/ld_fa_reportgraficcr.sql
@src/gascaribe/papelera-reciclaje/paquetes/ld_fa_reportgraficcr.sql

prompt "Aplicando src/gascaribe/cartera/paquetes/adm_person.ld_fa_reportgraficcr.sql"
@src/gascaribe/cartera/paquetes/adm_person.ld_fa_reportgraficcr.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ld_fa_reportgraficcr.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ld_fa_reportgraficcr.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2781_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-2781_actualizar_obj_migrados.sql

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