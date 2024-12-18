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

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_actividadorden.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_actividadorden.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.progcart.sql"
@src/gascaribe/cartera/sinonimo/adm_person.progcart.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.conf_pericons.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.conf_pericons.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_pkcm_lectesp.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_pkcm_lectesp.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_inboxdet.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_inboxdet.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_defisewe.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_defisewe.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_estaproc.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_estaproc.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_inbox.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_inbox.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_logenviomsg.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_logenviomsg.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_logiint.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_logiint.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_logpaymentreg.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_logpaymentreg.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_logs_integraciones.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_logs_integraciones.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_logsproc.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_logsproc.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_mesainfgesnotmovil.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_mesainfgesnotmovil.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_mesaproc.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_mesaproc.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_orden.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_orden.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_ordenesalegalizar.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_ordenesalegalizar.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_outboxdet.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_outboxdet.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_outboxdetval.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_outboxdetval.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seq_outboxdet_process.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seq_outboxdet_process.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkgestnotiorden.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkgestnotiorden.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_procmoni.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_procmoni.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seq_logs_integraciones.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seq_logs_integraciones.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seqlogpaymentreg.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seqlogpaymentreg.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seqlogi.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seqlogi.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seqmesaws.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seqmesaws.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_utilws.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_utilws.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seqtrazaint.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seqtrazaint.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_sistmoviltipotrab.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_sistmoviltipotrab.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.s_ldci_outboxdet.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.s_ldci_outboxdet.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.clasdopa.sql"
@src/gascaribe/general/sinonimos/adm_person.clasdopa.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.seq_ldci_estaproc.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.seq_ldci_estaproc.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.seq_ldci_mesaproc.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.seq_ldci_mesaproc.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_distribut_admin.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_distribut_admin.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_temjoblega.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_temjoblega.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_personal_type.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_personal_type.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_subscription_type.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_subscription_type.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_activ_appliance.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_activ_appliance.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_activ_defect.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_activ_defect.sql



prompt "------------------------------------------------------"
prompt "Aplicando migracion de objetos"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pktrazainterfaces.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pktrazainterfaces.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pktrazainterfaces.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pktrazainterfaces.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pktrazainterfaces.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pktrazainterfaces.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pksoapapi.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pksoapapi.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pksoapapi.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pksoapapi.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pksoapapi.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pksoapapi.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkmesaws.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkmesaws.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkmesaws.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkmesaws.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkmesaws.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkmesaws.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkrepodatatype.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkrepodatatype.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkrepodatatype.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkrepodatatype.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkrepodatatype.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkrepodatatype.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkwebservutils.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkwebservutils.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkwebservutils.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkwebservutils.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkwebservutils.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkwebservutils.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkapiutil.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkapiutil.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkapiutil.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkapiutil.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkapiutil.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkapiutil.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkbssfacctto.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkbssfacctto.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkbssfacctto.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkbssfacctto.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkbssfacctto.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkbssfacctto.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkcrmportalweb.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkcrmportalweb.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkcrmportalweb.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkcrmportalweb.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkcrmportalweb.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkcrmportalweb.sql

prompt "Aplicando src/gascaribe/general/notification/paquetes/ldci_pkcrmsms.sql"
@src/gascaribe/general/notification/paquetes/ldci_pkcrmsms.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkcrmsms.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkcrmsms.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkcrmsms.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkcrmsms.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkdatacredito.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkdatacredito.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkdatacredito.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkdatacredito.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkdatacredito.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkdatacredito.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkgestnovorder.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkgestnovorder.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkgestnovorder.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkgestnovorder.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkgestnovorder.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkgestnovorder.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinfoadicionalect.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinfoadicionalect.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinfoadicionalect.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinfoadicionalect.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinfoadicionalect.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinfoadicionalect.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkoutbox.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkoutbox.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkoutbox.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkoutbox.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkoutbox.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkoutbox.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_temppkgestlegaorden.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_temppkgestlegaorden.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_temppkgestlegaorden.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_temppkgestlegaorden.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_temppkgestlegaorden.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_temppkgestlegaorden.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkbssreca.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkbssreca.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkbssreca.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkbssreca.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkbssreca.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkbssreca.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/package/ldci_pkosssolicitud.sql"
@src/gascaribe/gestion-ordenes/package/ldci_pkosssolicitud.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/package/adm_person.ldci_pkosssolicitud.sql"
@src/gascaribe/gestion-ordenes/package/adm_person.ldci_pkosssolicitud.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldci_pkosssolicitud.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldci_pkosssolicitud.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkvalidasigelec.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkvalidasigelec.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkvalidasigelec.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkvalidasigelec.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkvalidasigelec.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkvalidasigelec.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkfactelectronica_emi.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkfactelectronica_emi.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkfactelectronica_emi.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkfactelectronica_emi.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkfactelectronica_emi.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkfactelectronica_emi.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3180_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-3180_actualizar_obj_migrados.sql


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