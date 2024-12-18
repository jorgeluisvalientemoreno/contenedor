column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                         Aplicando Entrega OSF-2569                       "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "--------------------------------INICIO------------------------------------"
prompt "                                                                          "
prompt "----------- 1.PROCEDIMIENTO LDC_PROGENERANOVELTYOFERTADOS ----------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_progeneranoveltyofertados.sql" 
@src/gascaribe/actas/ofertados/ldc_progeneranoveltyofertados.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_reporte_ofert_escalo.sql    " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_reporte_ofert_escalo.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_uni_act_ot.sql             " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_uni_act_ot.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_zona_ofer_cart.sql         " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_zona_ofer_cart.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_const_liqtarran.sql        " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_const_liqtarran.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_tipo_trab_x_nov_ofertados.sql " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_tipo_trab_x_nov_ofertados.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_zona_loc_ofer_cart.sql     " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_zona_loc_ofer_cart.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_actas_aplica_proc_ofert.sql " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_actas_aplica_proc_ofert.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_item_uo_lr.sql             " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_item_uo_lr.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_unid_oper_hija_mod_tar.sql  " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_unid_oper_hija_mod_tar.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_act_father_act_hija.sql    " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_act_father_act_hija.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_bcfinanceot.sql            " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_bcfinanceot.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_const_unoprl.sql           " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_const_unoprl.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_proactualizaestaprog.sql   " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_proactualizaestaprog.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ldc_proinsertaestaprog.sql     " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_proinsertaestaprog.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.or_boorder.sql                 " 
@src/gascaribe/actas/sinonimos/adm_person.or_boorder.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de tabla adm_person.ct_order_certifica.sql         " 
@src/gascaribe/actas/sinonimos/adm_person.ct_order_certifica.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldc_progeneranoveltyofertados.sql " 
@src/gascaribe/actas/ofertados/adm_person.ldc_progeneranoveltyofertados.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldc_progeneranoveltyofertados.sql " 
@src/gascaribe/actas/sinonimos/adm_person.ldc_progeneranoveltyofertados.sql
show errors;

prompt "                                                                          " 
prompt "----------- 2.PROCEDIMIENTO LDC_PRUSUARIOS_SUSP_CART ---------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prusuarios_susp_cart.sql" 
@src/gascaribe/cartera/suspensiones/procedimiento/ldc_prusuarios_susp_cart.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldc_prusuarios_susp_cart.sql" 
@src/gascaribe/cartera/suspensiones/procedimiento/adm_person.ldc_prusuarios_susp_cart.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldc_prusuarios_susp_cart.sql" 
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_prusuarios_susp_cart.sql
show errors;

prompt "                                                                          " 
prompt "----------- 3.PROCEDIMIENTO LDC_PRVALEGAORDENPERSEC-----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prvalegaordenpersec.sql" 
@src/gascaribe/cartera/suspensiones/ldc_prvalegaordenpersec.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.mo_suspension.sql               " 
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.mo_suspension.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.mo_suspension_comp.sql          " 
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.mo_suspension_comp.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a secuencia adm_person.seq_gc_proycast_172026.sql  " 
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.seq_gc_proycast_172026.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a secuencia adm_person.seq_pr_comp_suspension.sql  " 
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.seq_pr_comp_suspension.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.pkaccreivadvancemgr.sql       " 
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.pkaccreivadvancemgr.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.pktblsuspcone.sql             " 
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.pktblsuspcone.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_prodrerp.sql                " 
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_prodrerp.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a secuencia adm_person.seq_pr_prod_suspension.sql  " 
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.seq_pr_prod_suspension.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a secuencia adm_person.dbms_job.sql                " 
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.dbms_job.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a secuencia adm_person.ldc_boutilities.sql         " 
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_boutilities.sql
show errors;
prompt "                                                                          "
      
prompt "--->Aplicando creación de procedimiento adm_person.ldc_prvalegaordenpersec" 
@src/gascaribe/cartera/suspensiones/procedimiento/adm_person.ldc_prvalegaordenpersec.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldc_prvalegaordenpersec.sql" 
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_prvalegaordenpersec.sql
show errors;

prompt "                                                                          " 
prompt "----------- 4.PROCEDIMIENTO LDC_PRVALIDALECTURASUSP-----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prvalidalecturasusp.sql" 
@src/gascaribe/cartera/suspensiones/procedimiento/ldc_prvalidalecturasusp.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldc_prvalidalecturasusp.sql"
@src/gascaribe/cartera/suspensiones/procedimiento/adm_person.ldc_prvalidalecturasusp.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldc_prvalidalecturasusp.sql" 
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_prvalidalecturasusp.sql
show errors;

prompt "                                                                          " 
prompt "----------- 5.PROCEDIMIENTO LDC_UIATENDEVSALDOFAVOR_PROC------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_uiatendevsaldofavor_proc.sql" 
@src/gascaribe/cartera/devoluciones/procedimientos/ldc_uiatendevsaldofavor_proc.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.saldfavo.sql                    " 
@src/gascaribe/cartera/sinonimo/adm_person.saldfavo.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.movisafa.sql                    " 
@src/gascaribe/cartera/sinonimo/adm_person.movisafa.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.rc_devosafa.sql                 " 
@src/gascaribe/cartera/sinonimo/adm_person.rc_devosafa.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.ps_bopackagetype.sql          " 
@src/gascaribe/cartera/sinonimo/adm_person.ps_bopackagetype.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.rc_uiatendevsaldofavor.sql    " 
@src/gascaribe/cartera/sinonimo/adm_person.rc_uiatendevsaldofavor.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.fa_bochargecauses.sql         " 
@src/gascaribe/cartera/sinonimo/adm_person.fa_bochargecauses.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.pkbcmovisafa.sql              " 
@src/gascaribe/cartera/sinonimo/adm_person.pkbcmovisafa.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.dbms_standard.sql             " 
@src/gascaribe/cartera/sinonimo/adm_person.dbms_standard.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldc_uiatendevsaldofavor_proc.sql" 
@src/gascaribe/cartera/devoluciones/procedimientos/adm_person.ldc_uiatendevsaldofavor_proc.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldc_uiatendevsaldofavor_proc.sql" 
@src/gascaribe/cartera/sinonimo/adm_person.ldc_uiatendevsaldofavor_proc.sql
show errors;


prompt "                                                                          " 
prompt "----------- 6.PROCEDIMIENTO LDC_VALIDAIMPEDIMENTOS -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N adm_person.ldc_validaimpedimentos.sql" 
@src/gascaribe/cartera/impedimentos/procedimientos/ldc_validaimpedimentos.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.ge_boinstancecontrol.sql      " 
@src/gascaribe/cartera/sinonimo/adm_person.ge_boinstancecontrol.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.ge_boconstants.sql            " 
@src/gascaribe/cartera/sinonimo/adm_person.ge_boconstants.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.cc_borestriction.sql            " 
@src/gascaribe/cartera/sinonimo/adm_person.cc_borestriction.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldc_validaimpedimentos.sql " 
@src/gascaribe/cartera/impedimentos/procedimientos/adm_person.ldc_validaimpedimentos.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldc_validaimpedimentos.sql" 
@src/gascaribe/cartera/sinonimo/adm_person.ldc_validaimpedimentos.sql
show errors;

prompt "                                                                          " 
prompt "----------- 7.PROCEDIMIENTO LDCCREAFLUJOSRPSUSADMARSOLSAC ----------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldccreaflujosrpsusadmarsolsac.sql" 
@src/gascaribe/revision-periodica/plugin/ldccreaflujosrpsusadmarsolsac.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a función adm_person.ldc_fsbvalidasuspcemoacomprod.sql " 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_fsbvalidasuspcemoacomprod.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a procedimiento adm_person.ldcprocreatramrecsincertxml.sql " 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcprocreatramrecsincertxml.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a procedimiento adm_person.ldc_pararepe.sql        " 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_pararepe.sql
show errors;
prompt "                                                                          "
       
prompt "--->Aplicando creación de procedimiento adm_person.ldccreaflujosrpsusadmarsolsac.sql" 
@src/gascaribe/revision-periodica/plugin/adm_person.ldccreaflujosrpsusadmarsolsac.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldccreaflujosrpsusadmarsolsac.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldccreaflujosrpsusadmarsolsac.sql
show errors;

prompt "                                                                          "
prompt "----------- 8.PROCEDIMIENTO LDC_SUSPPORRPUSUVENC -------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_suspporrpusuvenc.sql" 
@src/gascaribe/revision-periodica/plugin/ldc_suspporrpusuvenc.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_cambio_estado_prod.sql      " 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_cambio_estado_prod.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_ordentramiterp.sql          " 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_ordentramiterp.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldc_suspporrpusuvenc.sql" 
@src/gascaribe/revision-periodica/plugin/adm_person.ldc_suspporrpusuvenc.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldc_suspporrpusuvenc.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_suspporrpusuvenc.sql
show errors;


prompt "                                                                          " 
prompt "------------ 9.PROCEDIMIENTO LDCPROCCREATRAMFLUJSACXML -------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldcproccreatramflujsacxml.sql" 
@src/gascaribe/revision-periodica/plugin/ldcproccreatramflujsacxml.sql
show errors;
prompt "                                                                          "
  
prompt "--->Aplicando sinonimo a tabla adm_person.ldc_conf_ttsusreco_tisolgene.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_conf_ttsusreco_tisolgene.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando sinonimo a funcion adm_person.ldcfncretornamarcarevprp.sql  " 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcfncretornamarcarevprp.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando sinonimo a funcion adm_person.ldcfncretornamarcadefcri.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcfncretornamarcadefcri.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando sinonimo a funcion adm_person.ldcfncretornamarcarepprp.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcfncretornamarcarepprp.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando sinonimo a funcion adm_person.ldcfncretornamarcacerprp.sql  " 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcfncretornamarcacerprp.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando sinonimo a funcion adm_person.ldc_fncretornasalddifvisita.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_fncretornasalddifvisita.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando sinonimo a secuencia adm_person.ldc_seq_tramites_revper.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_seq_tramites_revper.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando sinonimo a procedimiento adm_person.ldcproccrearegistrotramtab.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcproccrearegistrotramtab.sql
show errors;
prompt "                                                                          " 

prompt "--->Aplicando sinonimo a procedimiento adm_person.ldcprocinsactumarcaprodu.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcprocinsactumarcaprodu.sql
show errors;
prompt "                                                                          " 

prompt "--->Aplicando creación de procedimiento adm_person.ldcproccreatramflujsacxml.sql" 
@src/gascaribe/revision-periodica/plugin/adm_person.ldcproccreatramflujsacxml.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldcproccreatramflujsacxml.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcproccreatramflujsacxml.sql
show errors;


prompt "                                                                          " 
prompt "------------ 10.PROCEDIMIENTO LDCPROCCREATRAMIFLUJOSPRPXML ---------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldcproccreatramiflujosprpxml.sql" 
@src/gascaribe/revision-periodica/plugin/ldcproccreatramiflujosprpxml.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldcproccreatramiflujosprpxml" 
@src/gascaribe/revision-periodica/plugin/adm_person.ldcproccreatramiflujosprpxml.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldcproccreatramiflujosprpxml.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcproccreatramiflujosprpxml.sql
show errors;

prompt "                                                                          " 
prompt "----------- 11.PROCEDIMIENTO LDC_VALIDA_APTO_RP --------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_valida_apto_rp.sql" 
@src/gascaribe/revision-periodica/kiosko/procedimientos/ldc_valida_apto_rp.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla ldc_progen_sac_rp.sql                      " 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_progen_sac_rp.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldc_valida_apto_rp.sql " 
@src/gascaribe/revision-periodica/kiosko/procedimientos/adm_person.ldc_valida_apto_rp.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldc_valida_apto_rp.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_valida_apto_rp.sql
show errors;


prompt "                                                                          " 
prompt "----------- 12.PROCEDIMIENTO LDCCREATETRAMITERECONEXIONXML ---------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldccreatetramitereconexionxml.sql" 
@src/gascaribe/revision-periodica/certificados/procedimientos/ldccreatetramitereconexionxml.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a procedimiento adm_person.ldcvalproducttramitereco.sql" 
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldcvalproducttramitereco.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ld_prodapplysuspend.sql         " 
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ld_prodapplysuspend.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.prod_negdeuda_rp.sql            " 
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.prod_negdeuda_rp.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.mo_bosequences.sql            " 
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.mo_bosequences.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.ldc_certificados_oia.sql      " 
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_certificados_oia.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldccreatetramitereconexionxml.sql" 
@src/gascaribe/revision-periodica/certificados/procedimientos/adm_person.ldccreatetramitereconexionxml.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.ldccreatetramitereconexionxml.sql" 
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldccreatetramitereconexionxml.sql
show errors;

prompt "                                                                          " 
prompt "----------- 13.PROCEDIMIENTO LDCI_CRE_CAR_AVA_OBR_VEN_CON ----------------" 
prompt "                                                                          "
 
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldci_cre_car_ava_obr_ven_con.sql " 
@src/gascaribe/servicios-nuevos/plugins/ldci_cre_car_ava_obr_ven_con.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.mo_comment.sql                  " 
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.mo_comment.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.pkchargemgr.sql               " 
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.pkchargemgr.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.ldci_cre_car_ava_obr_ven_con.sql " 
@src/gascaribe/servicios-nuevos/plugins/adm_person.ldci_cre_car_ava_obr_ven_con.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldci_cre_car_ava_obr_ven_con.sql" 
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldci_cre_car_ava_obr_ven_con.sql
show errors;

prompt "                                                                          " 
prompt "------------ 14.PROCEDIMIENTO LDCI_REENVIO_MANUAL_FACTELECT --------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldci_reenvio_manual_factelect.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldci_reenvio_manual_factelect.sql
show errors;
prompt "                                                                          "

prompt "                                                                          " 
prompt "------------ 15.PROCEDIMIENTO PROGUARDAASIGOTTECRE -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N proguardaasigottecre.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/proguardaasigottecre.sql 
show errors;

prompt "                                                                          "
prompt "------------ 16.PROCEDIMIENTO PRCOMENTARIOOTREGENERACION -----------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N prcomentariootregeneracion.sql " 
@src/gascaribe/papelera-reciclaje/procedimientos/prcomentariootregeneracion.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.gw_boconstants.sql            " 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.gw_boconstants.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.prcomentariootregeneracion " 
@src/gascaribe/gestion-ordenes/procedure/adm_person.prcomentariootregeneracion.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.prcomentariootregeneracion.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.prcomentariootregeneracion.sql
show errors;

prompt "                                                                          " 
prompt "------------ 17.PROCEDIMIENTO PRSOLCUPPORWEB -----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N prsolcupporweb.sql " 
@src/gascaribe/atencion-usuarios/procedimientos/prsolcupporweb.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.prsolcupporweb         " 
@src/gascaribe/atencion-usuarios/procedimientos/adm_person.prsolcupporweb.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva procedimiento adm_person.prsolcupporweb.sql " 
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.prsolcupporweb.sql
show errors;

prompt "                                                                          " 
prompt "------------------- ACTUALIZAR REGISTRO ----------------------------------" 
prompt "                                                                          "
 
prompt "--->Aplicando actualización de objetos migrados                           "
@src/gascaribe/datafix/OSF-2569_actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2569                           "
prompt "--------------------------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
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