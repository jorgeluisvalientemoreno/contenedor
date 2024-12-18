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

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_osf_marcacausal.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_osf_marcacausal.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ld_fa_paragene.sql"
@src/gascaribe/general/sinonimos/adm_person.ld_fa_paragene.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ld_fa_estadesc.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ld_fa_estadesc.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_conftitra_caus_asig_aut.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_conftitra_caus_asig_aut.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbretornaaplicaasigauto.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbretornaaplicaasigauto.sql

prompt "src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fsbretornaaplicaasigauto.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fsbretornaaplicaasigauto.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fsbretornaaplicaasigauto.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fsbretornaaplicaasigauto.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.isnumber.sql"
@src/gascaribe/general/funciones/adm_person.isnumber.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/isnumber.sql"
@src/gascaribe/papelera-reciclaje/funciones/isnumber.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.isnumber.sql"
@src/gascaribe/general/sinonimos/adm_person.isnumber.sql

prompt "Aplicando src/gascaribe/revision-periodica/funciones/adm_person.ldc_fnucuentassaldosproducto.sql"
@src/gascaribe/revision-periodica/funciones/adm_person.ldc_fnucuentassaldosproducto.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/LDC_FNUCUENTASSALDOSPRODUCTO.sql"
@src/gascaribe/papelera-reciclaje/funciones/LDC_FNUCUENTASSALDOSPRODUCTO.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_fnucuentassaldosproducto.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_fnucuentassaldosproducto.sql

prompt "Aplicando src/gascaribe/revision-periodica/funciones/adm_person.ldc_fnugetnuevamarca.sql"
@src/gascaribe/revision-periodica/funciones/adm_person.ldc_fnugetnuevamarca.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetnuevamarca.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetnuevamarca.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_fnugetnuevamarca.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_fnugetnuevamarca.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetzeroconsper_gdc.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetzeroconsper_gdc.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/funciones/adm_person.ldc_fnugetzeroconsper_gdc.sql"
@src/gascaribe/facturacion/consumos/funciones/adm_person.ldc_fnugetzeroconsper_gdc.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/sinonimos/adm_person.ldc_fnugetzeroconsper_gdc.sql"
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.ldc_fnugetzeroconsper_gdc.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.ld_fa_fsb_paragene.sql"
@src/gascaribe/general/funciones/adm_person.ld_fa_fsb_paragene.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ld_fa_fsb_paragene.sql"
@src/gascaribe/papelera-reciclaje/funciones/ld_fa_fsb_paragene.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ld_fa_fsb_paragene.sql"
@src/gascaribe/general/sinonimos/adm_person.ld_fa_fsb_paragene.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/funciones/adm_person.ldc_fnugetzeroconsper.sql"
@src/gascaribe/facturacion/consumos/funciones/adm_person.ldc_fnugetzeroconsper.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetzeroconsper.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetzeroconsper.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_fnugetzeroconsper.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_fnugetzeroconsper.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.ld_fa_fnu_estadesc.sql"
@src/gascaribe/cartera/funciones/adm_person.ld_fa_fnu_estadesc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ld_fa_fnu_estadesc.sql"
@src/gascaribe/papelera-reciclaje/funciones/ld_fa_fnu_estadesc.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ld_fa_fnu_estadesc.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ld_fa_fnu_estadesc.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_retornacomentotlega.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_retornacomentotlega.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_retornacomentotlega.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_retornacomentotlega.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_retornacomentotlega.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_retornacomentotlega.sql

prompt "Aplicando src/gascaribe/general/sql/OSF-2103_actualizar_obj_migrados.sql"
@src/gascaribe/general/sql/OSF-2185_actualizar_obj_migrados.sql

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
