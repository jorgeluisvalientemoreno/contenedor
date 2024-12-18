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

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.cc_quotation_item.sql"
@src/gascaribe/ventas/sinonimos/adm_person.cc_quotation_item.sql

prompt "Aplicando src/gascaribe/actas/sinonimos/adm_person.ge_detalle_acta.sql"
@src/gascaribe/actas/sinonimos/adm_person.ge_detalle_acta.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/sinonimos/adm_person.dage_suspension_type.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.dage_suspension_type.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.damo_packages.sql"
@src/gascaribe/general/sinonimos/adm_person.damo_packages.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.fa_locamere.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.fa_locamere.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_datos_actualizar.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_datos_actualizar.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_manual_quota.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_manual_quota.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_subs_como_dato.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_subs_como_dato.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldc_liqcontadm.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_liqcontadm.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_plazos_cert.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_plazos_cert.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkconstante.sql"
@src/gascaribe/general/sinonimos/adm_person.pkconstante.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkservnumber.sql"
@src/gascaribe/general/sinonimos/adm_person.pkservnumber.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_marca_producto.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_marca_producto.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.ldcfncretornaflagdoccompl.sql"
@src/gascaribe/fnb/funciones/adm_person.ldcfncretornaflagdoccompl.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldcfncretornaflagdoccompl.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldcfncretornaflagdoccompl.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldcfncretornaflagdoccompl.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldcfncretornaflagdoccompl.sql

prompt "Aplicando src/gascaribe/contratacion/funciones/adm_person.ldcfncretornamesliq.sql"
@src/gascaribe/contratacion/funciones/adm_person.ldcfncretornamesliq.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldcfncretornamesliq.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldcfncretornamesliq.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldcfncretornamesliq.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldcfncretornamesliq.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.ldc_fncretornaprodmotive.sql"
@src/gascaribe/general/funciones/adm_person.ldc_fncretornaprodmotive.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fncretornaprodmotive.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fncretornaprodmotive.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_fncretornaprodmotive.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_fncretornaprodmotive.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.ldc_fncvalcumpldifsegmcom.sql"
@src/gascaribe/cartera/funciones/adm_person.ldc_fncvalcumpldifsegmcom.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fncvalcumpldifsegmcom.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fncvalcumpldifsegmcom.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_fncvalcumpldifsegmcom.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_fncvalcumpldifsegmcom.sql

prompt "Aplicando src/gascaribe/revision-periodica/suspension/funciones/adm_person.ldc_fnproddisposuspedfnc.sql"
@src/gascaribe/revision-periodica/suspension/funciones/adm_person.ldc_fnproddisposuspedfnc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnproddisposuspedfnc.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnproddisposuspedfnc.sql

prompt "Aplicando src/gascaribe/revision-periodica/suspension/funciones/adm_person.ldc_fnproddisposuspedfnc.sql"
@src/gascaribe/revision-periodica/suspension/sinonimos/adm_person.ldc_fnproddisposuspedfnc.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.ldc_fnu_aplicaentrega.sql"
@src/gascaribe/general/funciones/adm_person.ldc_fnu_aplicaentrega.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnu_aplicaentrega.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnu_aplicaentrega.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_fnu_aplicaentrega.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_fnu_aplicaentrega.sql

prompt "Aplicando src/gascaribe/ventas/funciones/adm_person.ldc_fnucentrmedcoti.sql"
@src/gascaribe/ventas/funciones/adm_person.ldc_fnucentrmedcoti.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnucentrmedcoti.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnucentrmedcoti.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_fnucentrmedcoti.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_fnucentrmedcoti.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.ldc_fnucomodato.sql"
@src/gascaribe/fnb/funciones/adm_person.ldc_fnucomodato.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnucomodato.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnucomodato.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_fnucomodato.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_fnucomodato.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.ldc_fnucontrolvisualanulsoli.sql"
@src/gascaribe/general/funciones/adm_person.ldc_fnucontrolvisualanulsoli.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnucontrolvisualanulsoli.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnucontrolvisualanulsoli.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_fnucontrolvisualanulsoli.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_fnucontrolvisualanulsoli.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.ldc_fnugetedadcc.sql"
@src/gascaribe/cartera/funciones/adm_person.ldc_fnugetedadcc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetedadcc.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetedadcc.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_fnugetedadcc.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_fnugetedadcc.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/funciones/adm_person.ldc_fnugetlastsusptypebyprod.sql"
@src/gascaribe/cartera/suspensiones/funciones/adm_person.ldc_fnugetlastsusptypebyprod.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetlastsusptypebyprod.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetlastsusptypebyprod.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_fnugetlastsusptypebyprod.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_fnugetlastsusptypebyprod.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/adm_person.ldcfnu_getmerebyloca.sql"
@src/gascaribe/facturacion/funciones/adm_person.ldcfnu_getmerebyloca.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldcfnu_getmerebyloca.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldcfnu_getmerebyloca.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldcfnu_getmerebyloca.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldcfnu_getmerebyloca.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/funciones/adm_person.ldc_fnugetnewidentlodpd.sql"
@src/gascaribe/atencion-usuarios/funciones/adm_person.ldc_fnugetnewidentlodpd.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetnewidentlodpd.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetnewidentlodpd.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_fnugetnewidentlodpd.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_fnugetnewidentlodpd.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.ldc_fnugetnumberexpaccounts.sql"
@src/gascaribe/cartera/funciones/adm_person.ldc_fnugetnumberexpaccounts.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetnumberexpaccounts.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetnumberexpaccounts.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_fnugetnumberexpaccounts.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_fnugetnumberexpaccounts.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/adm_person.ldc_fnugetpefabypeco.sql"
@src/gascaribe/facturacion/funciones/adm_person.ldc_fnugetpefabypeco.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetpefabypeco.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetpefabypeco.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_fnugetpefabypeco.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_fnugetpefabypeco.sql

prompt "Aplicando src/gascaribe/general/sql/OSF-2094_actualizar_obj_migrados.sql"
@src/gascaribe/general/sql/OSF-2100_actualizar_obj_migrados.sql

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
