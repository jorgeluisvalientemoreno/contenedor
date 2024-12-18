column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2952"
prompt "-----------------"

prompt "-----paquete LDC_BO_SUBSCRIBERXID-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bo_subscriberxid.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bo_subscriberxid.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_item_warranty.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ge_item_warranty.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bo_subscriberxid.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_bo_subscriberxid.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bo_subscriberxid.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_bo_subscriberxid.sql


prompt "-----paquete LDC_BOPACKAGE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bopackage.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bopackage.sql

prompt "--->Aplicando creacion grants paquete adm_person.cc_tyobattribute.sql"
@src/gascaribe/general/tipos/adm_person.cc_tyobattribute.sql

prompt "--->Aplicando creacion grants paquete adm_person.cc_tytbattribute.sql"
@src/gascaribe/general/tipos/adm_person.cc_tytbattribute.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_tyobattribute.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_tyobattribute.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_tytbattribute.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_tytbattribute.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_bcosspackage.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_bcosspackage.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_bobossutil.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_bobossutil.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_bobssbillaccount.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_bobssbillaccount.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_boossadminactivity.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_boossadminactivity.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_boossattachfiles.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_boossattachfiles.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_boosscomment.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_boosscomment.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_boossmotive.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_boossmotive.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_boossmotivedata.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_boossmotivedata.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_boossnotification.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_boossnotification.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.damo_restriction.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.damo_restriction.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_boinstanceconstants.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ge_boinstanceconstants.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_bopayment.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_bopayment.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mo_boparameter.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.mo_boparameter.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mo_motive_payment.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.mo_motive_payment.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mo_restriction.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.mo_restriction.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.tt_boconstants.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.tt_boconstants.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mo_package_payment.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.mo_package_payment.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.vwrc_payments.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.vwrc_payments.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.rc_bcinformacionpagos.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.rc_bcinformacionpagos.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_bundled.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_bundled.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_boosssubscription.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_boosssubscription.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ps_class_service.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ps_class_service.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ps_component_type.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ps_component_type.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkboautomaticdebitnovelty.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkboautomaticdebitnovelty.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.rc_bcpositivebalance.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.rc_bcpositivebalance.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_bobsspayment.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_bobsspayment.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.curechde.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.curechde.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bopackage.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_bopackage.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bopackage.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_bopackage.sql


prompt "-----paquete LDC_BOSUBSCRIPTION-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bosubscription.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bosubscription.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.tt_bosearchdataservices.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.tt_bosearchdataservices.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_boossbundled.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_boossbundled.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.td.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.td.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_boosspromotion.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_boosspromotion.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_bobssbill.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_bobssbill.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_bobssclaim.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_bobssclaim.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkgeneralparametersmgr.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkgeneralparametersmgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_boosspackage.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_boosspackage.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_boosscomplaint.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_boosscomplaint.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.sucubanc.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.sucubanc.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bosubscription.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_bosubscription.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bosubscription.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_bosubscription.sql


prompt "-----paquete LDC_BOUBIGEOGRAFICA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_boubigeografica.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boubigeografica.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_boossdescription.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_boossdescription.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkbcsubscription.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkbcsubscription.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_boubigeografica.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_boubigeografica.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_boubigeografica.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_boubigeografica.sql


prompt "-----procedimiento LDC_PGENERATEBILLPREP-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pgeneratebillprep.sql"
@src/gascaribe/cartera/medidores-prepago/procedimientos/ldc_pgeneratebillprep.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.pkboratingmemorymgr.sql"
@src/gascaribe/cartera/medidores-prepago/sinonimos/adm_person.pkboratingmemorymgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.pktblelemmedi.sql"
@src/gascaribe/cartera/medidores-prepago/sinonimos/adm_person.pktblelemmedi.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ge_document_type.sql"
@src/gascaribe/cartera/medidores-prepago/sinonimos/adm_person.ge_document_type.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.pkinstancedatamgr.sql"
@src/gascaribe/cartera/medidores-prepago/sinonimos/adm_person.pkinstancedatamgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.cm_bcconstants.sql"
@src/gascaribe/cartera/medidores-prepago/sinonimos/adm_person.cm_bcconstants.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_pgeneratebillprep.sql"
@src/gascaribe/cartera/medidores-prepago/procedimientos/adm_person.ldc_pgeneratebillprep.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_pgeneratebillprep.sql"
@src/gascaribe/cartera/medidores-prepago/sinonimos/adm_person.ldc_pgeneratebillprep.sql


prompt "-----paquete LDC_PKDATAFIXUPDEDDOCU-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkdatafixupdeddocu.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkdatafixupdeddocu.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldcupdocfactlog.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcupdocfactlog.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_seq_updocfactlog.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_seq_updocfactlog.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkdatafixupdeddocu.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_pkdatafixupdeddocu.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkdatafixupdeddocu.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_pkdatafixupdeddocu.sql


prompt "-----paquete LDCCERTIFICATEACCOUNT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldccertificateaccount.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldccertificateaccount.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkbcbillingnotescrdb.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkbcbillingnotescrdb.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkconceptvaluesmgr.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkconceptvaluesmgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkbccargos.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkbccargos.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mo_boinstance_db.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.mo_boinstance_db.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.fa_bccertificates.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.fa_bccertificates.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_bccertificate.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.cc_bccertificate.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldcfa_tyobcertstatement.sql"
@src/gascaribe/general/tipos/adm_person.ldcfa_tyobcertstatement.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldcfa_tytbcertstatement.sql"
@src/gascaribe/general/tipos/adm_person.ldcfa_tytbcertstatement.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldcfa_tyobcertstatement.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcfa_tyobcertstatement.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldcfa_tytbcertstatement.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcfa_tytbcertstatement.sql

prompt "--->Aplicando creacion de paquete adm_person.ldccertificateaccount.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldccertificateaccount.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldccertificateaccount.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldccertificateaccount.sql


prompt "-----paquete LD_BOOSSPOLICY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_boosspolicy.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boosspolicy.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_boosspolicy.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.ld_boosspolicy.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_boosspolicy.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_boosspolicy.sql


prompt "-----paquete LDC_PKDATOSVISTAMATERIALIZADA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkdatosvistamaterializada.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkdatosvistamaterializada.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkdatosvistamaterializada.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_pkdatosvistamaterializada.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkdatosvistamaterializada.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_pkdatosvistamaterializada.sql


prompt "-----paquete GDO_REPORTECONSUMOS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN gdo_reporteconsumos.sql"
@src/gascaribe/papelera-reciclaje/paquetes/gdo_reporteconsumos.sql

prompt "--->Aplicando creacion de paquete adm_person.gdo_reporteconsumos.sql"
@src/gascaribe/general/paquetes/adm_person.gdo_reporteconsumos.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.gdo_reporteconsumos.sql"
@src/gascaribe/general/sinonimos/adm_person.gdo_reporteconsumos.sql


prompt "-----paquete LD_BOREADINGORDERDATA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_boreadingorderdata.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boreadingorderdata.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_boreadingorderdata.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.ld_boreadingorderdata.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_boreadingorderdata.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ld_boreadingorderdata.sql


prompt "-----paquete LDC_PKLDCCO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkldcco.sql"
@src/gascaribe/gestion-ordenes/package/ldc_pkldcco.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_tipo_unidad.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_tipo_unidad.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_contfema.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_contfema.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_task_class.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_task_class.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkldcco.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.ldc_pkldcco.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkldcco.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_pkldcco.sql


prompt "-----paquete LDC_PKMETROSCUBICOS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkmetroscubicos.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkmetroscubicos.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkfgca.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkfgca.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkmetroscubicos.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.ldc_pkmetroscubicos.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkmetroscubicos.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_pkmetroscubicos.sql


prompt "-----paquete LDC_BOFWCERTFREVPERIOD-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bofwcertfrevperiod.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bofwcertfrevperiod.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bofwcertfrevperiod.sql"
@src/gascaribe/revision-periodica/paquetes/adm_person.ldc_bofwcertfrevperiod.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bofwcertfrevperiod.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_bofwcertfrevperiod.sql


prompt "-----paquete PGK_LDCAUTO1-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pgk_ldcauto1.sql"
@src/gascaribe/servicios-asociados/areas-comunes/paquetes/pgk_ldcauto1.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_detamed.sql"
@src/gascaribe/servicios-asociados/areas-comunes/sinonimos/adm_person.ldc_detamed.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_oritem.sql"
@src/gascaribe/servicios-asociados/areas-comunes/sinonimos/adm_person.ldc_oritem.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_legaoraco.sql"
@src/gascaribe/servicios-asociados/areas-comunes/sinonimos/adm_person.ldc_legaoraco.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.or_tasktype_add_data.sql"
@src/gascaribe/servicios-asociados/areas-comunes/sinonimos/adm_person.or_tasktype_add_data.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_flag_garantia.sql"
@src/gascaribe/servicios-asociados/areas-comunes/sinonimos/adm_person.ldc_flag_garantia.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_attrib_set_attrib.sql"
@src/gascaribe/servicios-asociados/areas-comunes/sinonimos/adm_person.ge_attrib_set_attrib.sql

prompt "--->Aplicando creacion de paquete adm_person.pgk_ldcauto1.sql"
@src/gascaribe/servicios-asociados/areas-comunes/paquetes/adm_person.pgk_ldcauto1.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.pgk_ldcauto1.sql"
@src/gascaribe/servicios-asociados/areas-comunes/sinonimos/adm_person.pgk_ldcauto1.sql


prompt "-----paquete PKG_LDCGRIDLDCAPLAC-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pkg_ldcgridldcaplac.sql"
@src/gascaribe/servicios-asociados/areas-comunes/paquetes/pkg_ldcgridldcaplac.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_perfiles.sql"
@src/gascaribe/servicios-asociados/areas-comunes/sinonimos/adm_person.ldc_perfiles.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_typeperfiles.sql"
@src/gascaribe/servicios-asociados/areas-comunes/sinonimos/adm_person.ldc_typeperfiles.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.os_executiontoexecuted.sql"
@src/gascaribe/servicios-asociados/areas-comunes/sinonimos/adm_person.os_executiontoexecuted.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblestacort.sql"
@src/gascaribe/servicios-asociados/areas-comunes/sinonimos/adm_person.pktblestacort.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ldc_detamed.sql"
@src/gascaribe/servicios-asociados/areas-comunes/sinonimos/adm_person.seq_ldc_detamed.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ldc_legaoraco.sql"
@src/gascaribe/servicios-asociados/areas-comunes/sinonimos/adm_person.seq_ldc_legaoraco.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ldc_oritem.sql"
@src/gascaribe/servicios-asociados/areas-comunes/sinonimos/adm_person.seq_ldc_oritem.sql

prompt "--->Aplicando creacion de paquete adm_person.pkg_ldcgridldcaplac.sql"
@src/gascaribe/servicios-asociados/areas-comunes/paquetes/adm_person.pkg_ldcgridldcaplac.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.pkg_ldcgridldcaplac.sql"
@src/gascaribe/servicios-asociados/areas-comunes/sinonimos/adm_person.pkg_ldcgridldcaplac.sql


prompt "-----paquete LD_BOOSSCOMMENT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_boosscomment.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boosscomment.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_boosscomment.sql"
@src/gascaribe/ventas/paquetes/adm_person.ld_boosscomment.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_boosscomment.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ld_boosscomment.sql


prompt "-----paquete LDC_BCFORMATO_COTI_COM-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bcformato_coti_com.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcformato_coti_com.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_quot_financ_cond.sql"
@src/gascaribe/ventas/sinonimos/adm_person.cc_quot_financ_cond.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bcformato_coti_com.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_bcformato_coti_com.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bcformato_coti_com.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_bcformato_coti_com.sql


prompt "-----paquete LDC_BOPICONSTRUCTORA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bopiconstructora.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bopiconstructora.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.gi_boinstancedata.sql"
@src/gascaribe/ventas/sinonimos/adm_person.gi_boinstancedata.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_bccotizacionconstructora.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_bccotizacionconstructora.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_boventaconstructora.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_boventaconstructora.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_bocotizacionconstructora.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_bocotizacionconstructora.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.plansusc.sql"
@src/gascaribe/ventas/sinonimos/adm_person.plansusc.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_coticonstructora_adic.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_coticonstructora_adic.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.tipoconc.sql"
@src/gascaribe/ventas/sinonimos/adm_person.tipoconc.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.tasainte.sql"
@src/gascaribe/ventas/sinonimos/adm_person.tasainte.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_bobssdeferreddata.sql"
@src/gascaribe/ventas/sinonimos/adm_person.cc_bobssdeferreddata.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_proysoles.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_proysoles.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pm_project.sql"
@src/gascaribe/ventas/sinonimos/adm_person.pm_project.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_answer_mode.sql"
@src/gascaribe/ventas/sinonimos/adm_person.cc_answer_mode.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_refer_mode.sql"
@src/gascaribe/ventas/sinonimos/adm_person.cc_refer_mode.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_boquotationutil.sql"
@src/gascaribe/ventas/sinonimos/adm_person.cc_boquotationutil.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_bobssdescription.sql"
@src/gascaribe/ventas/sinonimos/adm_person.cc_bobssdescription.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bopiconstructora.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_bopiconstructora.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bopiconstructora.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_bopiconstructora.sql


prompt "-----paquete LDC_BOPICOTIZACOMERCIAL-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bopicotizacomercial.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bopicotizacomercial.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bopicotizacomercial.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_bopicotizacomercial.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bopicotizacomercial.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_bopicotizacomercial.sql


prompt "-----paquete LDC_PKTARIFATRANSITORIA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pktarifatransitoria.sql"
@src/gascaribe/facturacion/tarifa_transitoria/paquete/ldc_pktarifatransitoria.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pktarifatransitoria.sql"
@src/gascaribe/facturacion/tarifa_transitoria/paquete/adm_person.ldc_pktarifatransitoria.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pktarifatransitoria.sql"
@src/gascaribe/facturacion/tarifa_transitoria/sinonimos/adm_person.ldc_pktarifatransitoria.sql


prompt "-----Script OSF-2952_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2952_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2952-----"
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
