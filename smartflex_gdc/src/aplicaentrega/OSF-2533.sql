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

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ge_bocertificate.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ge_bocertificate.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.os_legalizeorderallactivities.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.os_legalizeorderallactivities.sql

prompt "src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_validgenaudprevias.sql"
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_validgenaudprevias.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.ldc_cargaupo.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_cargaupo.sql

prompt "src/gascaribe/general/sinonimos/adm_person.ldc_rangogenint.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_rangogenint.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.cc_boaccounts.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.cc_boaccounts.sql

prompt "src/gascaribe/general/sinonimos/adm_person.mo_bocausal.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_bocausal.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.os_legalizeorderallactivities.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.os_legalizeorderallactivities.sql

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.ct_bccertificate.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ct_bccertificate.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.ldc_cicldepa.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_cicldepa.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldcprocinsactumarcaprodu.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcprocinsactumarcaprodu.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_uni_act_ot2.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_uni_act_ot2.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_act_father_act_hija.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_act_father_act_hija.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_unid_oper_hija_mod_tar.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_unid_oper_hija_mod_tar.sql

prompt "src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_proteccion_datos.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_proteccion_datos.sql

prompt "src/gascaribe/general/sinonimos/adm_person.wf_instance_trans.sql"
@src/gascaribe/general/sinonimos/adm_person.wf_instance_trans.sql

prompt "src/gascaribe/general/sinonimos/adm_person.seq_ldc_log_pb.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ldc_log_pb.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.seq_cargaupo.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.seq_cargaupo.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.ldc_codperfact.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_codperfact.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_otrev_certif.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_otrev_certif.sql

prompt "src/gascaribe/cartera/sinonimo/adm_person.cc_grace_period.sql"
@src/gascaribe/cartera/sinonimo/adm_person.cc_grace_period.sql

prompt "src/gascaribe/cartera/sinonimo/adm_person.pktblplandife.sql"
@src/gascaribe/cartera/sinonimo/adm_person.pktblplandife.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prmarcaproductolog.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prmarcaproductolog.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_item_uo_lr.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_item_uo_lr.sql

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_zona_ofer_cart.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_zona_ofer_cart.sql

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_resumen_ord_ofer_car.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_resumen_ord_ofer_car.sql

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_actas_aplica_proc_ofert.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_actas_aplica_proc_ofert.sql

prompt "src/gascaribe/general/sinonimos/adm_person.ge_boparameter.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_boparameter.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.ldc_pkfapc.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_pkfapc.sql

prompt "src/gascaribe/general/sinonimos/adm_person.ge_attributes.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_attributes.sql

prompt "src/gascaribe/general/sinonimos/adm_person.mo_bowf_pack_interfac.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_bowf_pack_interfac.sql

prompt "src/gascaribe/cartera/sinonimo/adm_person.ldc_validarfechacierremasivo.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_validarfechacierremasivo.sql

prompt "src/gascaribe/general/sinonimos/adm_person.gw_boconstants.sql"
@src/gascaribe/general/sinonimos/adm_person.gw_boconstants.sql

prompt "src/gascaribe/cartera/sinonimo/adm_person.ldc_prrecamora.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_prrecamora.sql

prompt "src/gascaribe/general/sinonimos/adm_person.cc_boosspackagedata.sql"
@src/gascaribe/general/sinonimos/adm_person.cc_boosspackagedata.sql

prompt "src/gascaribe/cartera/sinonimo/adm_person.ldc_finan_cond.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_finan_cond.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bcorderactivities.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bcorderactivities.sql

prompt "src/gascaribe/general/sinonimos/adm_person.ldc_fdtgetnoficationdate.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_fdtgetnoficationdate.sql

prompt "src/gascaribe/general/sinonimos/adm_person.ldc_log_pb.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_log_pb.sql

prompt "src/gascaribe/general/sinonimos/adm_person.ge_boiopenexecutable.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_boiopenexecutable.sql

prompt "src/gascaribe/general/sinonimos/adm_person.ldc_tempppaud.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_tempppaud.sql

prompt "src/gascaribe/cartera/sinonimo/adm_person.cc_sales_financ_cond.sql"
@src/gascaribe/cartera/sinonimo/adm_person.cc_sales_financ_cond.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldcctroiacctrl.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcctroiacctrl.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_const_unoprl.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_const_unoprl.sql

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_zona_loc_ofer_cart.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_zona_loc_ofer_cart.sql

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_tipo_trab_x_nov_ofertados.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_tipo_trab_x_nov_ofertados.sql

prompt "src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_interaccion_sin_flujo.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_interaccion_sin_flujo.sql

prompt "src/gascaribe/general/sinonimos/adm_person.mo_bopackages_asso.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_bopackages_asso.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_atentesolotfinrevper.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_atentesolotfinrevper.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_condefrp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_condefrp.sql

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.ge_bocertifcontratista.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ge_bocertifcontratista.sql

prompt "src/gascaribe/general/sinonimos/adm_person.ldc_saveconexion.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_saveconexion.sql

prompt "src/gascaribe/general/sinonimos/adm_person.ldc_export_report_excel.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_export_report_excel.sql

prompt "src/gascaribe/general/sinonimos/adm_person.cc_bobossutil.sql"
@src/gascaribe/general/sinonimos/adm_person.cc_bobossutil.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_certificados_oia.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_certificados_oia.sql

prompt "src/gascaribe/cartera/sinonimo/adm_person.fnugetinterestrate.sql"
@src/gascaribe/cartera/sinonimo/adm_person.fnugetinterestrate.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_uni_act_ot.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_uni_act_ot.sql

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_const_liqtarran.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_const_liqtarran.sql

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.procesopostcerraracta.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.procesopostcerraracta.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.ldc_consualto.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_consualto.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.bitainco.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.bitainco.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_plazos_certant.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_plazos_certant.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_fncretornamarcaprod.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_fncretornamarcaprod.sql

prompt "src/gascaribe/general/sinonimos/adm_person.cc_bopackaddidate.sql"
@src/gascaribe/general/sinonimos/adm_person.cc_bopackaddidate.sql

prompt "src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_cant_asig_ofer_cart.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_cant_asig_ofer_cart.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.ldc_valaltca.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_valaltca.sql

prompt "src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_items_documento.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_items_documento.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_prcondefrp.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prcondefrp.sql

prompt "src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prcondefrp.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prcondefrp.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prcondefrp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prcondefrp.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_prenviasms.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prenviasms.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_prfillotrevcertifiddet.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prfillotrevcertifiddet.sql

prompt "src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prfillotrevcertifiddet.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prfillotrevcertifiddet.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prfillotrevcertifiddet.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prfillotrevcertifiddet.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_prfinanordrp.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prfinanordrp.sql

prompt "src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prfinanordrp.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prfinanordrp.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prfinanordrp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prfinanordrp.sql

prompt "src/gascaribe/facturacion/reportes/procedimientos/ldc_prgapycar.sql"
@src/gascaribe/facturacion/reportes/procedimientos/ldc_prgapycar.sql

prompt "src/gascaribe/facturacion/reportes/procedimientos/adm_person.ldc_prgapycar.sql"
@src/gascaribe/facturacion/reportes/procedimientos/adm_person.ldc_prgapycar.sql

prompt "src/gascaribe/facturacion/reportes/sinonimos/adm_person.ldc_prgapycar.sql"
@src/gascaribe/facturacion/reportes/sinonimos/adm_person.ldc_prgapycar.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_prgetinfosubsidio.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prgetinfosubsidio.sql

prompt "src/gascaribe/ventas/procedimientos/adm_person.ldc_prgetinfosubsidio.sql"
@src/gascaribe/ventas/procedimientos/adm_person.ldc_prgetinfosubsidio.sql

prompt "src/gascaribe/ventas/sinonimos/adm_person.ldc_prgetinfosubsidio.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_prgetinfosubsidio.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_prgetpackagerp.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prgetpackagerp.sql

prompt "src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prgetpackagerp.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prgetpackagerp.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prgetpackagerp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prgetpackagerp.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_prinsertestadpdp.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prinsertestadpdp.sql

prompt "src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldc_prinsertestadpdp.sql"
@src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldc_prinsertestadpdp.sql

prompt "src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_prinsertestadpdp.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_prinsertestadpdp.sql

prompt "src/gascaribe/atencion-usuarios/interaccion/procedimiento/ldc_prJobinteraccionsinflujo.sql"
@src/gascaribe/atencion-usuarios/interaccion/procedimiento/ldc_prJobinteraccionsinflujo.sql

prompt "src/gascaribe/atencion-usuarios/interaccion/procedimiento/adm_person.ldc_prjobinteraccionsinflujo.sql"
@src/gascaribe/atencion-usuarios/interaccion/procedimiento/adm_person.ldc_prjobinteraccionsinflujo.sql

prompt "src/gascaribe/atencion-usuarios/interaccion/sinonimos/adm_person.ldc_prjobinteraccionsinflujo.sql"
@src/gascaribe/atencion-usuarios/interaccion/sinonimos/adm_person.ldc_prjobinteraccionsinflujo.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_prlegordensacrp.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prlegordensacrp.sql

prompt "src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prlegordensacrp.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prlegordensacrp.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prlegordensacrp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prlegordensacrp.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_prmarcaproducto.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prmarcaproducto.sql

prompt "src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prmarcaproducto.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prmarcaproducto.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prmarcaproducto.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prmarcaproducto.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_proactserialtermcont.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proactserialtermcont.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_proanularequisicion.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proanularequisicion.sql

prompt "src/gascaribe/general/procedimientos/adm_person.ldc_proanularequisicion.sql"
@src/gascaribe/general/procedimientos/adm_person.ldc_proanularequisicion.sql

prompt "src/gascaribe/general/sinonimos/adm_person.ldc_proanularequisicion.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_proanularequisicion.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_procerraractasabiertas.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procerraractasabiertas.sql

prompt "src/gascaribe/actas/procedimientos/adm_person.ldc_procerraractasabiertas.sql"
@src/gascaribe/actas/procedimientos/adm_person.ldc_procerraractasabiertas.sql

prompt "src/gascaribe/actas/sinonimos/adm_person.ldc_procerraractasabiertas.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_procerraractasabiertas.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_procesa_iteracion.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procesa_iteracion.sql

prompt "src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldc_procesa_iteracion.sql"
@src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldc_procesa_iteracion.sql

prompt "src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_procesa_iteracion.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_procesa_iteracion.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_progeneranoveltycartera.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_progeneranoveltycartera.sql

prompt "src/gascaribe/cartera/procedimientos/adm_person.ldc_progeneranoveltycartera.sql"
@src/gascaribe/cartera/procedimientos/adm_person.ldc_progeneranoveltycartera.sql

prompt "src/gascaribe/cartera/sinonimo/adm_person.ldc_progeneranoveltycartera.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_progeneranoveltycartera.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_llenacostoingresosocierre.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_llenacostoingresosocierre.sql

prompt "src/gascaribe/Cierre/procedimientos/adm_person.ldc_llenacostoingresosocierre.sql"
@src/gascaribe/Cierre/procedimientos/adm_person.ldc_llenacostoingresosocierre.sql

prompt "src/gascaribe/Cierre/sinonimos/adm_person.ldc_llenacostoingresosocierre.sql"
@src/gascaribe/Cierre/sinonimos/adm_person.ldc_llenacostoingresosocierre.sql

prompt "src/gascaribe/papelera-reciclaje/schedules/atencion_solic_rev_per_aut.sql"
@src/gascaribe/papelera-reciclaje/schedules/atencion_solic_rev_per_aut.sql

prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldc_proc_ejec_aten_rev_per_aut.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proc_ejec_aten_rev_per_aut.sql

prompt " Aplicando src/gascaribe/datafix/OSF-2533_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-2533_actualizar_obj_migrados.sql

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