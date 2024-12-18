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

prompt "Aplicando src/gascaribe/general/sinonimos/fblaplicaentregaxcaso.sql"
@src/gascaribe/general/sinonimos/fblaplicaentregaxcaso.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.dage_causal.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.dage_causal.sql

prompt "Aplicando src/gascaribe/Cierre/sinonimos/adm_person.ic_movimien.sql"
@src/gascaribe/Cierre/sinonimos/adm_person.ic_movimien.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_boordenes.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_boordenes.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.ldc_carteracorriente.sql"
@src/gascaribe/cartera/funciones/adm_person.ldc_carteracorriente.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_carteracorriente.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_carteracorriente.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_carteracorriente.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_carteracorriente.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.ldc_carteradiferida.sql"
@src/gascaribe/cartera/funciones/adm_person.ldc_carteradiferida.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_carteradiferida.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_carteradiferida.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_carteradiferida.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_carteradiferida.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_cauleg.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_cauleg.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_cauleg.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_cauleg.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimoS/adm_person.ldc_cauleg.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_cauleg.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/adm_person.ldc_consultavaldesmonte.sql"
@src/gascaribe/facturacion/funciones/adm_person.ldc_consultavaldesmonte.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_consultavaldesmonte.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_consultavaldesmonte.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_consultavaldesmonte.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_consultavaldesmonte.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_consultavaldesmonte.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_consultavaldesmonte.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.ldc_crm_fechaano.sql"
@src/gascaribe/general/funciones/adm_person.ldc_crm_fechaano.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_crm_fechaano.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_crm_fechaano.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_crm_fechaano.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_crm_fechaano.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.ldc_crm_fechadia"
@src/gascaribe/general/funciones/adm_person.ldc_crm_fechadia.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_crm_fechadia.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_crm_fechadia.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_crm_fechadia"
@src/gascaribe/general/sinonimos/adm_person.ldc_crm_fechadia.sql

prompt "Aplicando src/gascaribe/ventas/funciones/adm_person.ldc_dato_adic_noti_ventas.sql"
@src/gascaribe/ventas/funciones/adm_person.ldc_dato_adic_noti_ventas.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_dato_adic_noti_ventas.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_dato_adic_noti_ventas.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_dato_adic_noti_ventas.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_dato_adic_noti_ventas.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.ldc_fnaplicaentregaxcaso.sql"
@src/gascaribe/general/funciones/adm_person.ldc_fnaplicaentregaxcaso.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnaplicaentregaxcaso.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnaplicaentregaxcaso.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_fnaplicaentregaxcaso.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_fnaplicaentregaxcaso.sql

prompt "src/gascaribe/facturacion/funciones/adm_person.ldc_fnc_getcuadrepfac.sql"
@src/gascaribe/facturacion/funciones/adm_person.ldc_fnc_getcuadrepfac.sql

prompt "src/gascaribe/papelera-reciclaje/funciones/ldc_fnc_getcuadrepfac.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnc_getcuadrepfac.sql

prompt "src/gascaribe/facturacion/sinonimos/adm_person.ldc_fnc_getcuadrepfac.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_fnc_getcuadrepfac.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.ldc_fnc_getsegmentsusc.sql"
@src/gascaribe/fnb/funciones/adm_person.ldc_fnc_getsegmentsusc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnc_getsegmentsusc.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnc_getsegmentsusc.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_fnc_getsegmentsusc.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_fnc_getsegmentsusc.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.ldc_fnconsultaoranpu.sql"
@src/gascaribe/fnb/funciones/adm_person.ldc_fnconsultaoranpu.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnconsultaoranpu.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnconsultaoranpu.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.ldc_fnconsultaoranpu.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_fnconsultaoranpu.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.ldc_fnconsultaordenes.sql"
@src/gascaribe/fnb/funciones/adm_person.ldc_fnconsultaordenes.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnconsultaordenes.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnconsultaordenes.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_fnconsultaordenes.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_fnconsultaordenes.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.ldc_fnconsultaotesdoc.sql"
@src/gascaribe/fnb/funciones/adm_person.ldc_fnconsultaotesdoc.sql

prompt "src/gascaribe/papelera-reciclaje/funciones/ldc_fnconsultaotesdoc.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnconsultaotesdoc.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_fnconsultaotesdoc.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_fnconsultaotesdoc.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/adm_person.ldc_fncrecufactciclo.sql"
@src/gascaribe/facturacion/funciones/adm_person.ldc_fncrecufactciclo.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fncrecufactciclo.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fncrecufactciclo.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_fncrecufactciclo.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_fncrecufactciclo.sql

prompt "Aplicando src/gascaribe/recaudos/funciones/adm_person.ldc_fncrecupagociclo.sql"
@src/gascaribe/recaudos/funciones/adm_person.ldc_fncrecupagociclo.sql

prompt "src/gascaribe/papelera-reciclaje/funciones/ldc_fncrecupagociclo.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fncrecupagociclo.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.ldc_fncrecupagociclo.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.ldc_fncrecupagociclo.sql


prompt "Aplicando src/gascaribe/general/sql/OSF-2094_actualizar_obj_migrados.sql"
@src/gascaribe/general/sql/OSF-2098_actualizar_obj_migrados.sql

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
