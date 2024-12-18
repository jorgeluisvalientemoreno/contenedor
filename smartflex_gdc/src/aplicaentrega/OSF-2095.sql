column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega OSF-2095"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/cc_grace_peri_defe.sql"
@src/gascaribe/objetos-producto/sinonimos/cc_grace_peri_defe.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/constants.sql"
@src/gascaribe/objetos-producto/sinonimos/constants.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/daor_task_type.sql"
@src/gascaribe/objetos-producto/sinonimos/daor_task_type.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_boinstancecontrol.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_boinstancecontrol.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_operating_sector.sql"
@src/gascaribe/objetos-producto/sinonimos/or_operating_sector.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/resureca.sql"
@src/gascaribe/objetos-producto/sinonimos/resureca.sql

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/sinonimos/dald_parameter.sql"
@src/gascaribe/facturacion/tarifa_transitoria/sinonimos/dald_parameter.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ldc_asig_ot_tecn.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ldc_asig_ot_tecn.sql

prompt "Aplicando src/gascaribe/Cierre/sinonimos/ldc_osf_sesucier.sql"
@src/gascaribe/Cierre/sinonimos/ldc_osf_sesucier.sql

prompt "Aplicando src/gascaribe/cartera/funciones/fnugetpergracdife.sql"
@src/gascaribe/cartera/funciones/fnugetpergracdife.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.fnugetpergracdife.sql"
@src/gascaribe/cartera/funciones/adm_person.fnugetpergracdife.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.fnugetpergracdife.sql"
@src/gascaribe/cartera/sinonimo/adm_person.fnugetpergracdife.sql

prompt "Aplicando src/gascaribe/cartera/funciones/fnugetsaldoactcucocierre.sql"
@src/gascaribe/cartera/funciones/fnugetsaldoactcucocierre.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.fnugetsaldoactcucocierre.sql"
@src/gascaribe/cartera/funciones/adm_person.fnugetsaldoactcucocierre.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.fnugetsaldoactcucocierre.sql"
@src/gascaribe/cartera/sinonimo/adm_person.fnugetsaldoactcucocierre.sql

prompt "Aplicando src/gascaribe/general/funciones/fnugettiempofueramedi.sql"
@src/gascaribe/general/funciones/fnugettiempofueramedi.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.fnugettiempofueramedi.sql"
@src/gascaribe/general/funciones/adm_person.fnugettiempofueramedi.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.fnugettiempofueramedi.sql"
@src/gascaribe/general/sinonimos/adm_person.fnugettiempofueramedi.sql

prompt "Aplicando src/gascaribe/recaudos/funciones/fnugettoltalpagos.sql"
@src/gascaribe/recaudos/funciones/fnugettoltalpagos.sql

prompt "Aplicando src/gascaribe/recaudos/funciones/adm_person.fnugettoltalpagos.sql"
@src/gascaribe/recaudos/funciones/adm_person.fnugettoltalpagos.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.fnugettoltalpagos.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.fnugettoltalpagos.sql

prompt "Aplicando src/gascaribe/metrologia/funciones/fnugetvalidaesperalega.sql"
@src/gascaribe/metrologia/funciones/fnugetvalidaesperalega.sql

prompt "Aplicando src/gascaribe/metrologia/funciones/adm_person.fnugetvalidaesperalega.sql"
@src/gascaribe/metrologia/funciones/adm_person.fnugetvalidaesperalega.sql

prompt "Aplicando src/gascaribe/metrologia/sinonimos/adm_person.fnugetvalidaesperalega.sql"
@src/gascaribe/metrologia/sinonimos/adm_person.fnugetvalidaesperalega.sql

prompt "Aplicando src/gascaribe/cartera/funciones/fnu_ldc_getsaldconc_orm.sql"
@src/gascaribe/cartera/funciones/fnu_ldc_getsaldconc_orm.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.fnu_ldc_getsaldconc_orm.sql"
@src/gascaribe/cartera/funciones/adm_person.fnu_ldc_getsaldconc_orm.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.fnu_ldc_getsaldconc_orm.sql"
@src/gascaribe/cartera/sinonimo/adm_person.fnu_ldc_getsaldconc_orm.sql

prompt "Aplicando src/gascaribe/cartera/funciones/fnu_ldc_gettipoconc.sql"
@src/gascaribe/cartera/funciones/fnu_ldc_gettipoconc.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.fnu_ldc_gettipoconc.sql"
@src/gascaribe/cartera/funciones/adm_person.fnu_ldc_gettipoconc.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.fnu_ldc_gettipoconc.sql"
@src/gascaribe/cartera/sinonimo/adm_person.fnu_ldc_gettipoconc.sql

prompt "Aplicando src/gascaribe/cartera/funciones/fnusaldodiferido.sql"
@src/gascaribe/cartera/funciones/fnusaldodiferido.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.fnusaldodiferido.sql"
@src/gascaribe/cartera/funciones/adm_person.fnusaldodiferido.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.fnusaldodiferido.sql"
@src/gascaribe/cartera/sinonimo/adm_person.fnusaldodiferido.sql

prompt "Aplicando src/gascaribe/cartera/funciones/fnusaldopendiente.sql"
@src/gascaribe/cartera/funciones/fnusaldopendiente.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.fnusaldopendiente.sql"
@src/gascaribe/cartera/funciones/adm_person.fnusaldopendiente.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.fnusaldopendiente.sql"
@src/gascaribe/cartera/sinonimo/adm_person.fnusaldopendiente.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/frcgettecunidoperteccert.sql"
@src/gascaribe/gestion-ordenes/funciones/frcgettecunidoperteccert.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/adm_person.frcgettecunidoperteccert.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.frcgettecunidoperteccert.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.frcgettecunidoperteccert.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.frcgettecunidoperteccert.sql

prompt "Aplicando src/gascaribe/general/sql/OSF-2095_marcar_funciones.sql"
@src/gascaribe/general/sql/OSF-2095_marcar_funciones.sql

prompt "Recompilar objetos BD"
@src/test/recompilar-objetos.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/