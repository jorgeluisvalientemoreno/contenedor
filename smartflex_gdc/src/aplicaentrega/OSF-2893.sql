column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2893"
prompt "-----------------"

prompt "-----procedimiento LD_BOFILEBLOCKED-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ld_bofileblocked.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bofileblocked.sql


prompt "-----procedimiento LD_SERVICES_PERSON-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ld_services_person.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_services_person.sql


prompt "-----procedimiento LDC_BCGESTIONREEXO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_bcgestionreexo.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcgestionreexo.sql


prompt "-----procedimiento LDC_BCGESTIONREEXO2-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_bcgestionreexo2.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcgestionreexo2.sql


prompt "-----procedimiento LDC_BCORDENCONCILACION-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_bcordenconcilacion.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcordenconcilacion.sql


prompt "-----procedimiento LDC_BOGESTIONREEXO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_bogestionreexo.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bogestionreexo.sql


prompt "-----procedimiento LDC_BOGESTIONREEXO2-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_bogestionreexo2.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bogestionreexo2.sql


prompt "-----procedimiento LDC_BOLDCGCAUC-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN LDC_BOLDCGCAUC.pck"
@src/gascaribe/ventas/comisiones/paquetes/LDC_BOLDCGCAUC.pck


prompt "-----procedimiento LDC_BOORDENCONCILACION-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_boordenconcilacion.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boordenconcilacion.sql


prompt "-----procedimiento LDC_BOREVOKEORDER-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_borevokeorder.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_borevokeorder.sql


prompt "-----procedimiento LDC_BSGESTIONREEXO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_bsgestionreexo.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bsgestionreexo.sql


prompt "-----procedimiento LDC_DSCM_VAVAFACO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_dscm_vavafaco.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dscm_vavafaco.sql


prompt "-----procedimiento LDC_GENCOMIASESORVTA-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_gencomiasesorvta.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_gencomiasesorvta.sql


prompt "-----procedimiento LDC_OR_BOORDER-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_or_boorder.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_or_boorder.sql


prompt "-----procedimiento LDC_PKDIRECO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkdireco.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkdireco.sql


prompt "-----procedimiento LDC_PKGESTIONORDENES-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkgestionordenes.sql"
@src/gascaribe/gestion-ordenes/package/ldc_pkgestionordenes.sql


prompt "-----procedimiento LDC_PKINITLDRERLE-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkinitldrerle.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkinitldrerle.sql


prompt "-----procedimiento LDC_PKLDRERLE-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkldrerle.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkldrerle.sql


prompt "-----procedimiento LDC_PKRECNOSIN-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkrecnosin.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkrecnosin.sql


prompt "-----procedimiento LDC_PKREPORTEFIFAP-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkreportefifap.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkreportefifap.sql


prompt "-----procedimiento LDCPKFLCJ-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldcpkflcj.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldcpkflcj.sql


prompt "-----procedimiento PKG_MAIL_BASE-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkg_mail_base.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkg_mail_base.sql


prompt "-----procedimiento PKLD_FA_BSDISCOUNTAPPL-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkld_fa_bsdiscountappl.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bsdiscountappl.sql


prompt "-----procedimiento PKLD_FA_BSDISCOUNTAPPL2-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkld_fa_bsdiscountappl2.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bsdiscountappl2.sql


prompt "-----procedimiento PKLD_FA_BSDISCOUNTAPPLNO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkld_fa_bsdiscountapplno.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bsdiscountapplno.sql


prompt "-----procedimiento PKLD_FA_DETAREFE-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkld_fa_detarefe.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_detarefe.sql


prompt "-----procedimiento CEDR-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN cedr.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/cedr.sql


prompt "-----procedimiento FPMFE-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN fpmfe.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fpmfe.sql


prompt "-----procedimiento LDC_PBLDCRVPCON-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pbldcrvpcon.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_pbldcrvpcon.sql


prompt "-----procedimiento LDCFLCJ-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldcflcj.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcflcj.sql


prompt "-----procedimiento LDCGCAUC-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN LDCGCAUC.prc"
@src/gascaribe/ventas/comisiones/procedimientos/LDCGCAUC.prc


prompt "-----procedimiento LDCGREEX-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldcgreex.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcgreex.sql


prompt "-----procedimiento LDCRCB-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldcrcb.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcrcb.sql


prompt "-----procedimiento LDRDRC-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldrdrc.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldrdrc.sql


prompt "-----procedimiento LDURNS-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldurns.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldurns.sql


prompt "-----procedimiento LD_FA_DETAREFE-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ld_fa_detarefe.sql"
@src/gascaribe/papelera-reciclaje/tablas/ld_fa_detarefe.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.gispeti.ld_fa_detarefe.sql"
@src/gascaribe/papelera-reciclaje/sinonimos/gispeti.ld_fa_detarefe.sql


prompt "-----procedimiento LDC_REPEINGR-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_repeingr.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_repeingr.sql


prompt "-----procedimiento LDC_PKFLUNOTATECLI-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkflunotatecli.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkflunotatecli.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_pkflunotatecli.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_pkflunotatecli.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_pkflunotatecli.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_pkflunotatecli.sql


prompt "-----procedimiento LDC_PKGOTSSINCOBSINGAR-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkgotssincobsingar.sql"
@src/gascaribe/gestion-ordenes/package/ldc_pkgotssincobsingar.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.seq_ldc_otscobleg.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.seq_ldc_otscobleg.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_otscobleg.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_otscobleg.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_otlegalizar.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_otlegalizar.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_pkgotssincobsingar.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.ldc_pkgotssincobsingar.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_pkgotssincobsingar.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_pkgotssincobsingar.sql


prompt "-----procedimiento PE_BOGENCONTRACTOBLIG-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pe_bogencontractoblig.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pe_bogencontractoblig.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ge_bocertcontratista.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ge_bocertcontratista.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.dage_tipo_contrato.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.dage_tipo_contrato.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.dage_periodo_cert.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.dage_periodo_cert.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.dage_base_administra.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.dage_base_administra.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ct_boprocesslog.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ct_boprocesslog.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ct_boliquidationprocess.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ct_boliquidationprocess.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ct_bocertificate.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ct_bocertificate.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ct_bcliquidationsupport.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ct_bcliquidationsupport.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ct_bccontract.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ct_bccontract.sql

prompt "--->Aplicando creacion de procedimiento adm_person.pe_bogencontractoblig.sql"
@src/gascaribe/contratacion/paquetes/adm_person.pe_bogencontractoblig.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.pe_bogencontractoblig.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.pe_bogencontractoblig.sql


prompt "-----procedimiento PE_BOVALPRODSUITRCONNECTN-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pe_bovalprodsuitrconnectn.sql"
@src/gascaribe/cartera/reconexiones/paquetes/pe_bovalprodsuitrconnectn.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.pkgeneralparametersmgr.sql"
@src/gascaribe/cartera/reconexiones/sinonimos/adm_person.pkgeneralparametersmgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.pkgrlparamextendedmgr.sql"
@src/gascaribe/cartera/reconexiones/sinonimos/adm_person.pkgrlparamextendedmgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.pkboexpiredaccounts.sql"
@src/gascaribe/cartera/reconexiones/sinonimos/adm_person.pkboexpiredaccounts.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.mo_bogenericvalid.sql"
@src/gascaribe/cartera/reconexiones/sinonimos/adm_person.mo_bogenericvalid.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.pkincludesuspconnmgr.sql"
@src/gascaribe/cartera/reconexiones/sinonimos/adm_person.pkincludesuspconnmgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.gc_bccastigocartera.sql"
@src/gascaribe/cartera/reconexiones/sinonimos/adm_person.gc_bccastigocartera.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.pksuspconnservicemgr.sql"
@src/gascaribe/cartera/reconexiones/sinonimos/adm_person.pksuspconnservicemgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.confcose.sql"
@src/gascaribe/cartera/reconexiones/sinonimos/adm_person.confcose.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.parametr.sql"
@src/gascaribe/cartera/reconexiones/sinonimos/adm_person.parametr.sql

prompt "--->Aplicando creacion de procedimiento adm_person.pe_bovalprodsuitrconnectn.sql"
@src/gascaribe/cartera/reconexiones/paquetes/adm_person.pe_bovalprodsuitrconnectn.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.pe_bovalprodsuitrconnectn.sql"
@src/gascaribe/cartera/reconexiones/sinonimos/adm_person.pe_bovalprodsuitrconnectn.sql


prompt "-----procedimiento PE_BSGENCONTRACTOBLIG-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pe_bsgencontractoblig.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pe_bsgencontractoblig.sql

prompt "--->Aplicando creacion de procedimiento adm_person.pe_bsgencontractoblig.sql"
@src/gascaribe/contratacion/paquetes/adm_person.pe_bsgencontractoblig.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.pe_bsgencontractoblig.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.pe_bsgencontractoblig.sql


prompt "-----procedimiento PE_BSVALPRODSUITRCONNECTN-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pe_bsvalprodsuitrconnectn.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pe_bsvalprodsuitrconnectn.sql

prompt "--->Aplicando creacion de procedimiento adm_person.pe_bovalprodsuitrconnectn.sql"
@src/gascaribe/cartera/reconexiones/paquetes/adm_person.pe_bsvalprodsuitrconnectn.sql

prompt "--->Aplicando creacion sinonimo nuevo procedimiento adm_person.pe_bsvalprodsuitrconnectn.sql"
@src/gascaribe/cartera/reconexiones/sinonimos/adm_person.pe_bsvalprodsuitrconnectn.sql


prompt "-----procedimiento PKGRABALOGSEGPRO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkgrabalogsegpro.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkgrabalogsegpro.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_log_seg_proc.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_log_seg_proc.sql

prompt "--->Aplicando creacion de procedimiento adm_person.pe_bovalprodsuitrconnectn.sql"
@src/gascaribe/cartera/paquetes/adm_person.pkgrabalogsegpro.sql

prompt "--->Aplicando creacion sinonimo nuevo procedimiento adm_person.pkgrabalogsegpro.sql"
@src/gascaribe/cartera/sinonimo/adm_person.pkgrabalogsegpro.sql


prompt "-----Script OSF-2893_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2893_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2893-----"
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
