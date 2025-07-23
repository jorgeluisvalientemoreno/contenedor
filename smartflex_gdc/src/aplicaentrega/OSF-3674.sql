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

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/medio_recepcion_valida_visita_campo.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/medio_recepcion_valida_visita_campo.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/paquetes/personalizaciones.pkg_bocambio_de_uso.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/paquetes/personalizaciones.pkg_bocambio_de_uso.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/paquetes/pkg_reglas_tramitecambiodeuso.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/paquetes/pkg_reglas_tramitecambiodeuso.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_xml_soli_facturacion.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_xml_soli_facturacion.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/fwcob/ge_object_121784.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/fwcob/ge_object_121784.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/fwcob/ge_object_121785.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/fwcob/ge_object_121785.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_100225.sql"
@src/gascaribe/tramites/ps_package_type_100225.sql

prompt "Aplicando src/gascaribe/flujos/WF_UNIT_TYPE_100390.sql"
@src/gascaribe/flujos/WF_UNIT_TYPE_100390.sql

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