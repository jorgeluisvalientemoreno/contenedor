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

prompt "------------------------------------------------------"
prompt "Aplicando Sinonimos a tablas producto"
@src/gascaribe/objetos-producto/sinonimos/causcarg.sql
show errors;

prompt "------------------------------------------------------"
@src/gascaribe/objetos-producto/sinonimos/ge_identifica_type.sql
show errors;

prompt "------------------------------------------------------"
prompt "Aplicando Sinonimos a tablas customizadas"
@src/gascaribe/facturacion/tarifa_transitoria/sinonimos/ld_parameter.sql
show errors;

prompt "------------------------------------------------------"
@src/gascaribe/facturacion/tarifa_transitoria/sinonimos/ldc_deprtatt.sql
show errors;

prompt "------------------------------------------------------"
@src/gascaribe/facturacion/tarifa_transitoria/sinonimos/ldc_prodtatt.sql
show errors;
prompt "------------------------------------------------------"

prompt "Aplicando paquete nuevo personalizaciones.pkg_tarifatransitoria"
@src/gascaribe/facturacion/tarifa_transitoria/paquetes_per/personalizaciones.pkg_tarifatransitoria.sql
show errors;

prompt "------------------------------------------------------"
prompt "Aplicando Sinonimos a paquete nuevo pkg_tarifatransitoria"
@src/gascaribe/facturacion/tarifa_transitoria/sinonimos/personalizaciones.pkg_tarifatransitoria.sql
show errors;

prompt "------------------------------------------------------"
prompt "Aplicando paquete de ldc_pktarifatransitoria deOPEN"
@src/gascaribe/facturacion/tarifa_transitoria/paquete/ldc_pktarifatransitoria.sql
show errors;

prompt "------------------------------------------------------"
prompt "Drop paquete personalizaciones.ldc_pktarifatransitoria"
@src/gascaribe/facturacion/tarifa_transitoria/paquetes_per/personalizaciones.ldc_pktarifatransitoria.sql
show errors;

prompt "------------------------------------------------------"
prompt "Aplicando paquete personalizaciones.ldc_pluglegalizarreforma"
@src/gascaribe/servicios-asociados/plugin/personalizaciones.ldc_pluglegalizarreforma.sql
show errors; 

prompt "------------------------------------------------------"
prompt "Aplicando Sinonimo a ldc_pluglegalizarreforma"
@src/gascaribe/servicios-asociados/sinonimos/personalizaciones.ldc_pluglegalizarreforma.sql
show errors;

prompt "------------------------------------------------------"
prompt "Aplicando paquete personalizaciones.ldc_boconsgenerales.sql"
@src/gascaribe/facturacion/tarifa_transitoria/paquetes_per/personalizaciones.ldc_boconsgenerales.sql
show errors; 

prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega V1.0"
prompt "------------------------------------------------------"


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit