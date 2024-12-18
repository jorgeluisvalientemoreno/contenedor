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

prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.instances_to_delete_20221104.sql"
@src/gascaribe/general/sinonimos/adm_person.instances_to_delete_20221104.sql
prompt "Aplicando	rc/gascaribe/general/sinonimos/adm_person.ldc_delete_wf_instance.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_delete_wf_instance.sql
prompt "Aplicando	src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_pkflunotatecli.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_pkflunotatecli.sql
prompt "Aplicando	src/gascaribe/cartera/sinonimo/adm_person.ldc_createsuspcone.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_createsuspcone.sql
prompt "Aplicando	src/gascaribe/cartera/sinonimo/adm_person.sqidsuspcone.sql"
@src/gascaribe/cartera/sinonimo/adm_person.sqidsuspcone.sql
prompt "Aplicando	src/gascaribe/facturacion/sinonimos/adm_person.fa_boserviciosliqtarifarios.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.fa_boserviciosliqtarifarios.sql
prompt "Aplicando	src/gascaribe/facturacion/sinonimos/adm_person.fa_histcodi.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.fa_histcodi.sql
prompt "Aplicando	src/gascaribe/facturacion/sinonimos/adm_person.hileelme.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.hileelme.sql
prompt "Aplicando	src/gascaribe/facturacion/sinonimos/adm_person.ldc_log_actfor.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_log_actfor.sql
prompt "Aplicando	src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_reglas_definidas.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_reglas_definidas.sql
prompt "Aplicando	src/gascaribe/facturacion/sinonimos/adm_person.pktblhileelme.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pktblhileelme.sql
prompt "Aplicando	src/gascaribe/facturacion/sinonimos/adm_person.pktbllectelme.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pktbllectelme.sql
prompt "Aplicando	src/gascaribe/facturacion/sinonimos/adm_person.seq_fa_histcodi.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.seq_fa_histcodi.sql
prompt "Aplicando	src/gascaribe/facturacion/sinonimos/adm_person.seq_ldc_log_actfor.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.seq_ldc_log_actfor.sql
prompt "Aplicando	src/gascaribe/facturacion/sinonimos/adm_person.sq_hileelme_hlemcons.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.sq_hileelme_hlemcons.sql
prompt "Aplicando	src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_bcsecuremanagement.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_bcsecuremanagement.sql
prompt "Aplicando	src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_carasewe.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_carasewe.sql
prompt "Aplicando	src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_clascont.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_clascont.sql
prompt "Aplicando	src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_clascott.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_clascott.sql
prompt "Aplicando	src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldc_cier_prorecupaperiodocont.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldc_cier_prorecupaperiodocont.sql
prompt "Aplicando	src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldc_ordenes_costo_ingreso.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldc_ordenes_costo_ingreso.sql
prompt "Aplicando	src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldc_osf_costingr.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldc_osf_costingr.sql
prompt "Aplicando	src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_centbenelocal.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_centbenelocal.sql
prompt "Aplicando	src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_cuentacontable.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_cuentacontable.sql
prompt "Aplicando	src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_ingrevemi.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_ingrevemi.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.dage_geogra_location.sql"
@src/gascaribe/general/sinonimos/adm_person.dage_geogra_location.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.dage_process_schedule.sql"
@src/gascaribe/general/sinonimos/adm_person.dage_process_schedule.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.damo_comp_link.sql"
@src/gascaribe/general/sinonimos/adm_person.damo_comp_link.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.damo_component.sql"
@src/gascaribe/general/sinonimos/adm_person.damo_component.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.daor_order_activity.sql"
@src/gascaribe/general/sinonimos/adm_person.daor_order_activity.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.dasa_user.sql"
@src/gascaribe/general/sinonimos/adm_person.dasa_user.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.ge_bcperson.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_bcperson.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.ldc_conflunotateacl.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_conflunotateacl.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.ldc_enviamail.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_enviamail.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.ldc_proactualizaestaprog.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_proactualizaestaprog.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.ldc_proinsertaestaprog.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_proinsertaestaprog.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.ldci_cugacoclasi.sql"
@src/gascaribe/general/sinonimos/adm_person.ldci_cugacoclasi.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.mo_bomotive.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_bomotive.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.or_act_by_task_mod.sql"
@src/gascaribe/general/sinonimos/adm_person.or_act_by_task_mod.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.pkgeneralservices.sql"
@src/gascaribe/general/sinonimos/adm_person.pkgeneralservices.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.pktblconcepto.sql"
@src/gascaribe/general/sinonimos/adm_person.pktblconcepto.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.pktblge_bcperson.sql"
@src/gascaribe/general/sinonimos/adm_person.pktblge_bcperson.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.pktblservsusc.sql"
@src/gascaribe/general/sinonimos/adm_person.pktblservsusc.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.pktblsuscripc.sql"
@src/gascaribe/general/sinonimos/adm_person.pktblsuscripc.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.tipocons.sql"
@src/gascaribe/general/sinonimos/adm_person.tipocons.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.ut_dbinstance.sql"
@src/gascaribe/general/sinonimos/adm_person.ut_dbinstance.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.ut_string.sql"
@src/gascaribe/general/sinonimos/adm_person.ut_string.sql
prompt "Aplicando	src/gascaribe/gestion-contratista/sinonimos/adm_person.ct_order_certifica.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ct_order_certifica.sql
prompt "Aplicando	src/gascaribe/gestion-contratista/sinonimos/adm_person.ct_tasktype_contype.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ct_tasktype_contype.sql
prompt "Aplicando	src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_bcfinanceot.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_bcfinanceot.sql
prompt "Aplicando	src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_procrearegasiunioprevper.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_procrearegasiunioprevper.sql
prompt "Aplicando	src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldci_titrindiva.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldci_titrindiva.sql
prompt "Aplicando	src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_boorder.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_boorder.sql
prompt "Aplicando	src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_regenera_activida.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_regenera_activida.sql
prompt "Aplicando	src/gascaribe/gestion-ordenes/sinonimos/adm_person.os_createorderactivities.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.os_createorderactivities.sql
prompt "Aplicando	src/gascaribe/recaudos/sinonimos/adm_person.carearre.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.carearre.sql
prompt "Aplicando	src/gascaribe/recaudos/sinonimos/adm_person.forearre.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.forearre.sql
prompt "Aplicando	src/gascaribe/recaudos/sinonimos/adm_person.gst_hidasusc.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.gst_hidasusc.sql
prompt "Aplicando	src/gascaribe/recaudos/sinonimos/adm_person.gst_prevdeau.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.gst_prevdeau.sql
prompt "Aplicando	src/gascaribe/recaudos/sinonimos/adm_person.prdaenti.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.prdaenti.sql
prompt "Aplicando	src/gascaribe/recaudos/sinonimos/adm_person.sqgst_prdecodi.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.sqgst_prdecodi.sql
prompt "Aplicando	src/gascaribe/ventas/sinonimos/adm_person.ldc_osf_mvto_serv_pdte.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_osf_mvto_serv_pdte.sql
prompt "Aplicando	src/gascaribe/ventas/sinonimos/adm_person.ldc_osf_serv_pendiente.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_osf_serv_pendiente.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/generatefiledebitauto.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/generatefiledebitauto.sql
prompt "Aplicando	src/gascaribe/recaudos/procedimientos/adm_person.generatefiledebitauto.sql"
@src/gascaribe/recaudos/procedimientos/adm_person.generatefiledebitauto.sql
prompt "Aplicando	src/gascaribe/recaudos/sinonimos/adm_person.generatefiledebitauto.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.generatefiledebitauto.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_creatramitesuspacomet.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_creatramitesuspacomet.sql
prompt "Aplicando	src/gascaribe/revision-periodica/plugin/adm_person.ldc_creatramitesuspacomet.sql"
@src/gascaribe/revision-periodica/plugin/adm_person.ldc_creatramitesuspacomet.sql
prompt "Aplicando	src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_creatramitesuspacomet.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_creatramitesuspacomet.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_genera_serv_pendientes.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_genera_serv_pendientes.sql
prompt "Aplicando	src/gascaribe/ventas/procedimientos/adm_person.ldc_genera_serv_pendientes.sql"
@src/gascaribe/ventas/procedimientos/adm_person.ldc_genera_serv_pendientes.sql
prompt "Aplicando	src/gascaribe/ventas/sinonimos/adm_person.ldc_genera_serv_pendientes.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_genera_serv_pendientes.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_insertsuspcone.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_insertsuspcone.sql
prompt "Aplicando	src/gascaribe/cartera/reconexiones/procedimientos/adm_person.ldc_insertsuspcone.sql"
@src/gascaribe/cartera/reconexiones/procedimientos/adm_person.ldc_insertsuspcone.sql
prompt "Aplicando	src/gascaribe/cartera/sinonimo/adm_person.ldc_insertsuspcone.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_insertsuspcone.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/cancelpolicybyage.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/cancelpolicybyage.sql
prompt "Aplicando	src/gascaribe/fnb/seguros/procedimientos/adm_person.cancelpolicybyage.sql"
@src/gascaribe/fnb/seguros/procedimientos/adm_person.cancelpolicybyage.sql
prompt "Aplicando	src/gascaribe/fnb/seguros/sinonimos/adm_person.cancelpolicybyage.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.cancelpolicybyage.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_actformulario.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_actformulario.sql
prompt "Aplicando	src/gascaribe/facturacion/procedimientos/adm_person.ldc_actformulario.sql"
@src/gascaribe/facturacion/procedimientos/adm_person.ldc_actformulario.sql
prompt "Aplicando	src/gascaribe/facturacion/sinonimos/adm_person.ldc_actformulario.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_actformulario.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_activa_hilos_cartlinea.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_activa_hilos_cartlinea.sql
prompt "Aplicando	src/gascaribe/cartera/procedimientos/adm_person.ldc_activa_hilos_cartlinea.sql"
@src/gascaribe/cartera/procedimientos/adm_person.ldc_activa_hilos_cartlinea.sql
prompt "Aplicando	src/gascaribe/cartera/sinonimo/adm_person.ldc_activa_hilos_cartlinea.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_activa_hilos_cartlinea.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_bogeneratechargeorder.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_bogeneratechargeorder.sql
prompt "Aplicando	src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_bogeneratechargeorder.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_bogeneratechargeorder.sql
prompt "Aplicando	src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_bogeneratechargeorder.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_bogeneratechargeorder.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_boprocessldclt.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_boprocessldclt.sql
prompt "Aplicando	src/gascaribe/facturacion/procedimientos/adm_person.ldc_boprocessldclt.sql"
@src/gascaribe/facturacion/procedimientos/adm_person.ldc_boprocessldclt.sql
prompt "Aplicando	src/gascaribe/facturacion/sinonimos/adm_person.ldc_boprocessldclt.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_boprocessldclt.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_boupdatelastsuspen.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_boupdatelastsuspen.sql
prompt "Aplicando	src/gascaribe/cartera/procedimientos/adm_person.ldc_boupdatelastsuspen.sql"
@src/gascaribe/cartera/procedimientos/adm_person.ldc_boupdatelastsuspen.sql
prompt "Aplicando	src/gascaribe/cartera/sinonimo/adm_person.ldc_boupdatelastsuspen.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_boupdatelastsuspen.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_bovalexecutiondates.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_bovalexecutiondates.sql
prompt "Aplicando	src/gascaribe/cartera/procedimientos/adm_person.ldc_bovalexecutiondates.sql"
@src/gascaribe/cartera/procedimientos/adm_person.ldc_bovalexecutiondates.sql
prompt "Aplicando	src/gascaribe/cartera/sinonimo/adm_person.ldc_bovalexecutiondates.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_bovalexecutiondates.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_bovallastregen.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_bovallastregen.sql
prompt "Aplicando	src/gascaribe/cartera/procedimientos/adm_person.ldc_bovallastregen.sql"
@src/gascaribe/cartera/procedimientos/adm_person.ldc_bovallastregen.sql
prompt "Aplicando	src/gascaribe/cartera/sinonimo/adm_person.ldc_bovallastregen.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_bovallastregen.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_crea_orden_env_sspd.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_crea_orden_env_sspd.sql
prompt "Aplicando	src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldc_crea_orden_env_sspd.sql"
@src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldc_crea_orden_env_sspd.sql
prompt "Aplicando	src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_crea_orden_env_sspd.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_crea_orden_env_sspd.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_geneverprefin.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_geneverprefin.sql
prompt "Aplicando	src/gascaribe/facturacion/procedimientos/adm_person.ldc_geneverprefin.sql"
@src/gascaribe/facturacion/procedimientos/adm_person.ldc_geneverprefin.sql
prompt "Aplicando	src/gascaribe/facturacion/sinonimos/adm_person.ldc_geneverprefin.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_geneverprefin.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_genotinteraccionjob.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_genotinteraccionjob.sql
prompt "Aplicando	src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldc_genotinteraccionjob.sql"
@src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldc_genotinteraccionjob.sql
prompt "Aplicando	src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_genotinteraccionjob.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_genotinteraccionjob.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_getorders_supplier_info.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_getorders_supplier_info.sql
prompt "Aplicando	src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldc_getorders_supplier_info.sql"
@src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldc_getorders_supplier_info.sql
prompt "Aplicando	src/gascaribe/atencion-usuarios/sinonimos/Sadm_person.ldc_getorders_supplier_info.sql"
@src/gascaribe/atencion-usuarios/sinonimos/Sadm_person.ldc_getorders_supplier_info.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_llenacostoingresosocierre.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_llenacostoingresosocierre.sql
prompt "Aplicando	src/gascaribe/general/interfaz-contable/procedimientos/adm_person.ldc_llenacostoingresosocierre.sql"
@src/gascaribe/general/interfaz-contable/procedimientos/adm_person.ldc_llenacostoingresosocierre.sql
prompt "Aplicando	src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldc_llenacostoingresosocierre.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldc_llenacostoingresosocierre.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_job_delete_all_instances.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_job_delete_all_instances.sql
prompt "Aplicando	src/gascaribe/general/procedimientos/adm_person.ldc_job_delete_all_instances.sql"
@src/gascaribe/general/procedimientos/adm_person.ldc_job_delete_all_instances.sql
prompt "Aplicando	src/gascaribe/general/sinonimos/adm_person.ldc_job_delete_all_instances.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_job_delete_all_instances.sql
prompt "Aplicando	src/gascaribe/papelera-reciclaje/procedimientos/ldc_insert_serv_pendientes.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_insert_serv_pendientes.sql

prompt "Aplicando src/gascaribe/general/sql/OSF-2368_actualizar_obj_migrados.sql"
@src/gascaribe/general/sql/OSF-2368_actualizar_obj_migrados.sql

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