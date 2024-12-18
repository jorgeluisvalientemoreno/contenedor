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

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_gestionsecuencias.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_gestionsecuencias.sql

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/sinonimos/personalizaciones.ldc_boconsgenerales.sql"
@src/gascaribe/facturacion/tarifa_transitoria/sinonimos/personalizaciones.ldc_boconsgenerales.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/ldc_actcallcenter.sql"
@src/gascaribe/atencion-usuarios/sinonimos/ldc_actcallcenter.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.daldc_actcallcenter.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_actcallcenter.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_borcst.sql"
@src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_borcst.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_borcst.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_borcst.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/pkg_uircst.sql"
@src/gascaribe/atencion-usuarios/paquetes/pkg_uircst.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/pkg_uircst.sql"
@src/gascaribe/atencion-usuarios/sinonimos/pkg_uircst.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/fwcpb/rcst.sql"
@src/gascaribe/atencion-usuarios/fwcpb/rcst.sql



prompt "src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldc_insactcallcenter.sql"
@src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldc_insactcallcenter.sql


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

