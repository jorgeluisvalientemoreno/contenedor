column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2891"
prompt "-----------------"

prompt "-----paquete LDC_REPORTESPROCESO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_reportesproceso.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_reportesproceso.sql


prompt "-----paquete LDC_REPPLANOATECLIE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_repplanoateclie.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_repplanoateclie.sql


prompt "-----paquete LDC_RPT_LDRVACN-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_rpt_ldrvacn.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_rpt_ldrvacn.sql


prompt "-----paquete LDC_UIFCDCRG-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_uifcdcrg.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_uifcdcrg.sql


prompt "-----paquete LDC_UIFGRCG-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_uifgrcg.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_uifgrcg.sql


prompt "-----paquete LDC_UIFMAREG-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_uifmareg.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_uifmareg.sql


prompt "-----paquete LDC_UILDCIDO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_uildcido.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_uildcido.sql


prompt "-----paquete LDC_VAL_NOTAS_CICLO_5402-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_val_notas_ciclo_5402.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_val_notas_ciclo_5402.sql


prompt "-----paquete LDC_VAL_NOTAS_CICLO_5402V2-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_val_notas_ciclo_5402v2.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_val_notas_ciclo_5402v2.sql


prompt "-----paquete LDCCERTIFICATEACCOUNT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldccertificateaccount.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldccertificateaccount.sql


prompt "-----paquete LDCPKGGENPRECUPONCOTIZA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldcpkggenprecuponcotiza.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldcpkggenprecuponcotiza.sql


prompt "-----paquete LDCX_PKBINCAJASBRILLA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldcx_pkbincajasbrilla.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldcx_pkbincajasbrilla.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete sistemabrilla.ldcx_pkbincajasbrilla.sql"
@src/gascaribe/papelera-reciclaje/sinonimos/sistemabrilla.ldcx_pkbincajasbrilla.sql


prompt "-----paquete LDCX_PKCLIENTESBRILLA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldcx_pkclientesbrilla.sql"
@src/gascaribe/objetos-obsoletos/ldcx_pkclientesbrilla.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete sistemabrilla.ldcx_pkclientesbrilla.sql"
@src/gascaribe/objetos-obsoletos/sinonimos/sistemabrilla.ldcx_pkclientesbrilla.sql


prompt "-----paquete LDCX_PKORDENESBRILLA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldcx_pkordenesbrilla.sql"
@src/gascaribe/objetos-obsoletos/ldcx_pkordenesbrilla.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete sistemabrilla.ldcx_pkordenesbrilla.sql"
@src/gascaribe/objetos-obsoletos/sinonimos/sistemabrilla.ldcx_pkordenesbrilla.sql


prompt "-----paquete OPENSYSTEMS_ORDERS_-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN opensystems_orders_.sql"
@src/gascaribe/papelera-reciclaje/paquetes/opensystems_orders_.sql


prompt "-----paquete ORDSO_-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ordso_.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ordso_.sql


prompt "-----paquete PACKTEST-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN packtest.sql"
@src/gascaribe/papelera-reciclaje/paquetes/packtest.sql


prompt "-----paquete PGK_LDCAUTO1-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pgk_ldcauto1.sql"
@src/gascaribe/servicios-asociados/areas-comunes/paquetes/pgk_ldcauto1.sql


prompt "-----paquete PK_CARGAPLANTILLAS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pk_cargaplantillas.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pk_cargaplantillas.sql


prompt "-----paquete PK_LDCLODPD-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pk_ldclodpd.sql"
@src/gascaribe/general/paquetes/pk_ldclodpd.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pk_ldclodpd.sql"
@src/gascaribe/general/sinonimos/adm_person.pk_ldclodpd.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete innovacion.pk_ldclodpd.sql"
@src/gascaribe/general/sinonimos/innovacion.pk_ldclodpd.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete personalizaciones.pk_ldclodpd.sql"
@src/gascaribe/general/sinonimos/personalizaciones.pk_ldclodpd.sql


prompt "-----paquete PKCARGUE_DEU_POLIANU-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pkcargue_deu_polianu.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkcargue_deu_polianu.sql


prompt "-----paquete PKG_EMAILS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pkg_emails.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkg_emails.sql


prompt "-----paquete PKG_LDCCREASOLIVIORDP-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pkg_ldccreasoliviordp.sql"
@src/gascaribe/cartera/reconexiones/paquetes/pkg_ldccreasoliviordp.sql


prompt "-----paquete PKG_LDCGRIDLDCAPLAC-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pkg_ldcgridldcaplac.sql"
@src/gascaribe/servicios-asociados/areas-comunes/paquetes/pkg_ldcgridldcaplac.sql


prompt "-----paquete PKGSERVICIOCLIENTE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pkgserviciocliente.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkgserviciocliente.sql


prompt "-----Script OSF-2891_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2891_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2891-----"
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
