column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2672"
prompt "-----------------"

prompt "-----procedimiento LDC_PROCREPBR-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_procrepbr.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procrepbr.sql


prompt "-----procedimiento LDCPLUGINMARCREPAINTEGR-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldcpluginmarcrepaintegr.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcpluginmarcrepaintegr.sql


prompt "-----procedimiento LDCPLUGINMARCCERTINTEGR-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldcpluginmarccertintegr.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcpluginmarccertintegr.sql


prompt "-----procedimiento LDCVALIDANOLEGSOLSACSOREF-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldcvalidanolegsolsacsoref.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcvalidanolegsolsacsoref.sql


prompt "-----procedimiento LDC_PRREGISTRAOTCONTRATO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_prregistraotcontrato.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prregistraotcontrato.sql


prompt "-----procedimiento PR_CREAACTIBYTASKTYPE-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pr_creaactibytasktype.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/pr_creaactibytasktype.sql


prompt "-----procedimiento LDC_LEGALIZERECONEX-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_legalizereconex.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_legalizereconex.sql


prompt "-----procedimiento LDC_PRANULACONSECUTIVO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pranulaconsecutivo.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_pranulaconsecutivo.sql


prompt "-----procedimiento PROCOSTOORDEN_1-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN procostoorden_1.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/procostoorden_1.sql


prompt "-----procedimiento LDC_VALMEDI_ORDCARGOCONEC-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_valmedi_ordcargoconec.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_valmedi_ordcargoconec.sql


prompt "-----procedimiento LECTMOVIL-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN lectmovil.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/lectmovil.sql


prompt "-----procedimiento LDC_VALIDACANTCARACOBS-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_validacantcaracobs.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_validacantcaracobs.sql


prompt "-----procedimiento LDC_PRCAUSALMARCAPRODUCTO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_prcausalmarcaproducto.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prcausalmarcaproducto.sql


prompt "-----procedimiento PRC_UD_CLOB_ED_DOCUMENT-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN prc_ud_clob_ed_document.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/prc_ud_clob_ed_document.sql


prompt "-----procedimiento LDC_DETREPBR-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_detrepbr.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_detrepbr.sql


prompt "-----procedimiento LDC_DETREPMS-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_detrepms.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_detrepms.sql


prompt "-----procedimiento LDC_ENCREPBR-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_encrepbr.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_encrepbr.sql


prompt "-----procedimiento LDC_OTCONTRATOSGDC-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_otcontratosgdc.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_otcontratosgdc.sql


prompt "-----procedimiento LD_LECTMOVIL-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ld_lectmovil.sql"
@src/gascaribe/papelera-reciclaje/tablas/ld_lectmovil.sql


prompt "-----procedimiento LDC_PROCONTROL_DUPLICADO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_procontrol_duplicado.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procontrol_duplicado.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_control_duplicado.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_control_duplicado.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_procontrol_duplicado.sql"
@src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldc_procontrol_duplicado.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_procontrol_duplicado.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_procontrol_duplicado.sql


prompt "-----procedimiento LDC_PROCVALIDAFUNUNIDOPER-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_procvalidafununidoper.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procvalidafununidoper.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_procvalidafununidoper.sql"
@src/gascaribe/general/procedimientos/adm_person.ldc_procvalidafununidoper.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_procvalidafununidoper.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_procvalidafununidoper.sql


prompt "-----procedimiento LDCI_PROREPLICECOLOCA-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldci_proreplicecoloca.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldci_proreplicecoloca.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldci_cecoubigetra.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_cecoubigetra.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldci_centbeneloca.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_centbeneloca.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldci_centrocosto.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_centrocosto.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldci_proreplicecoloca.sql"
@src/gascaribe/general/interfaz-contable/procedimientos/adm_person.ldci_proreplicecoloca.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldci_proreplicecoloca.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_proreplicecoloca.sql


prompt "-----procedimiento LDC_OS_VALIDBILLPERIODBYPROD-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_os_validbillperiodbyprod.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_os_validbillperiodbyprod.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.pktblperifact.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pktblperifact.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_os_validbillperiodbyprod.sql"
@src/gascaribe/facturacion/procedimientos/adm_person.ldc_os_validbillperiodbyprod.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_os_validbillperiodbyprod.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_os_validbillperiodbyprod.sql


prompt "-----procedimiento LDCI_PROUPDOBSTATUSCERTOIAWS-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldci_proupdobstatuscertoiaws.sql"
@src/gascaribe/general/integraciones/procedimientos/ldci_proupdobstatuscertoiaws.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_unidad_certif.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldc_unidad_certif.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_marcaprodrepa.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldc_marcaprodrepa.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.seq_ldc_certificado_cambest.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.seq_ldc_certificado_cambest.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.daldc_marca_producto.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.daldc_marca_producto.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_pkgestnuesqservnue.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldc_pkgestnuesqservnue.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_bodefectnorepara.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldc_bodefectnorepara.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.seq_ldc_marcaprodrepa.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.seq_ldc_marcaprodrepa.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_certificado_cambest.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldc_certificado_cambest.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_plazos_cert.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldc_plazos_cert.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_seq_plazos_cert.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldc_seq_plazos_cert.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldci_proupdobstatuscertoiaws.sql"
@src/gascaribe/general/integraciones/procedimientos/adm_person.ldci_proupdobstatuscertoiaws.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldci_proupdobstatuscertoiaws.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_proupdobstatuscertoiaws.sql


prompt "-----procedimiento LDCPROCREATRAMRECSINCERTXML-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldcprocreatramrecsincertxml.sql"
@src/gascaribe/revision-periodica/procedimientos/ldcprocreatramrecsincertxml.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldcprocreatramrecsincertxml.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldcprocreatramrecsincertxml.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldcprocreatramrecsincertxml.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcprocreatramrecsincertxml.sql


prompt "-----procedimiento LDC_VISITAVENTAGASXML-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_visitaventagasxml.sql"
@src/gascaribe/ventas/procedimientos/ldc_visitaventagasxml.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.mo_subs_type_motiv.sql"
@src/gascaribe/ventas/sinonimos/adm_person.mo_subs_type_motiv.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ld_fa_infoadic_referido.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ld_fa_infoadic_referido.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.pkld_fa_generalrules.sql"
@src/gascaribe/ventas/sinonimos/adm_person.pkld_fa_generalrules.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ab_premise_type.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ab_premise_type.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_visitaventagasxml.sql"
@src/gascaribe/ventas/procedimientos/adm_person.ldc_visitaventagasxml.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_visitaventagasxml.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_visitaventagasxml.sql


prompt "-----procedimiento LDC_PRVPMDATA-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_prvpmdata.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prvpmdata.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_prvpmdata.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prvpmdata.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_prvpmdata.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prvpmdata.sql


prompt "-----procedimiento LDC_PRODEVUELVEVALORESCUOTAS-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_prodevuelvevalorescuotas.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prodevuelvevalorescuotas.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_osf_proyrecar_temp.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_osf_proyrecar_temp.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_prodevuelvevalorescuotas.sql"
@src/gascaribe/cartera/procedimientos/adm_person.ldc_prodevuelvevalorescuotas.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_prodevuelvevalorescuotas.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_prodevuelvevalorescuotas.sql


prompt "-----procedimiento LDC_PROREG_CT_PROCESS_LOG-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_proreg_ct_process_log.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proreg_ct_process_log.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_proreg_ct_process_log.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_proreg_ct_process_log.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_proreg_ct_process_log.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_proreg_ct_process_log.sql


prompt "-----Script OSF-2672_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2672_actualizar_obj_migrados.sql

prompt "-----Script OSF-2672_del_reg_ldc_procedimiento_obj-----"
@src/gascaribe/datafix/OSF-2672_del_reg_ldc_procedimiento_obj.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2672-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on

prompt "-----RECOMPILAR OBJETOS-----"
prompt "--->Aplicando recompilar objetos"
@src/test/recompilar-objetos.sql
show errors;
