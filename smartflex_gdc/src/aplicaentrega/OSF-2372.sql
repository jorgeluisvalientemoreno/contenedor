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

prompt "Aplicando src/ejecutores/bajar-ejecutores.sql"
@src/ejecutores/bajar-ejecutores.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.ldc_fnc_getsegmentsusc.sql"
@src/gascaribe/fnb/funciones/adm_person.ldc_fnc_getsegmentsusc.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.ldc_fnconsultaotesdoc.sql"
@src/gascaribe/fnb/funciones/adm_person.ldc_fnconsultaotesdoc.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.ldc_carteracorriente.sql"
@src/gascaribe/cartera/funciones/adm_person.ldc_carteracorriente.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.ldc_carteradiferida.sql"
@src/gascaribe/cartera/funciones/adm_person.ldc_carteradiferida.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.ldc_fnuvalquoiniart.sql"
@src/gascaribe/fnb/funciones/adm_person.ldc_fnuvalquoiniart.sql

prompt "Aplicando src/gascaribe/Cierre/funciones/adm_person.ldcfnu_venanoactual.sql"
@src/gascaribe/Cierre/funciones/adm_person.ldcfnu_venanoactual.sql

prompt "Aplicando src/gascaribe/Cierre/funciones/adm_person.ldcfnu_venanodirec.sql"
@src/gascaribe/Cierre/funciones/adm_person.ldcfnu_venanodirec.sql

prompt "Aplicando src/gascaribe/fnb/seguros/funciones/adm_person.ldc_fnvnombrecontra.sql"
@src/gascaribe/fnb/seguros/funciones/adm_person.ldc_fnvnombrecontra.sql

prompt "Aplicando src/gascaribe/revision-periodica/funciones/adm_person.ldc_fsbasignautomaticarevper.sql"
@src/gascaribe/revision-periodica/funciones/adm_person.ldc_fsbasignautomaticarevper.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/funciones/adm_person.ldc_fvaretconsumos.sql"
@src/gascaribe/facturacion/consumos/funciones/adm_person.ldc_fvaretconsumos.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/funciones/adm_person.ldc_fsbvalidaexpresion_ic.sql"
@src/gascaribe/general/interfaz-contable/funciones/adm_person.ldc_fsbvalidaexpresion_ic.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/funciones/adm_person.ldc_frflistoperatingunity.sql"
@src/gascaribe/servicios-nuevos/funciones/adm_person.ldc_frflistoperatingunity.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/funciones/adm_person.ldc_frflistcontractor.sql"
@src/gascaribe/servicios-nuevos/funciones/adm_person.ldc_frflistcontractor.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/funciones/adm_person.ldc_procconsultaprodotspno.sql"
@src/gascaribe/perdidas-no-operacionales/funciones/adm_person.ldc_procconsultaprodotspno.sql

prompt "Aplicando src/gascaribe/actas/funciones/adm_person.ldc_procconsultaactasabiertas.sql"
@src/gascaribe/actas/funciones/adm_person.ldc_procconsultaactasabiertas.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.ldc_importeenletras.sql"
@src/gascaribe/general/funciones/adm_person.ldc_importeenletras.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/funciones/adm_person.ldc_pro_canti_refinanciado.sql"
@src/gascaribe/cartera/negociacion-deuda/funciones/adm_person.ldc_pro_canti_refinanciado.sql

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
