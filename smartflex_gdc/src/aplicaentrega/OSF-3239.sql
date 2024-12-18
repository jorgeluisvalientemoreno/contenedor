set serveroutput on size unlimited
set linesize 1000
set timing on
execute dbms_application_info.set_action('APLICANDO OSF-3239');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;


-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "@src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_utilfacturacionelecgen.sql"
@src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_utilfacturacionelecgen.sql

prompt "@src/gascaribe/facturacion/facturacion_electronica/sql/job/adm_person.job_elimfacturacion_elecgen.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/job/adm_person.job_elimfacturacion_elecgen.sql


prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;


set timing off
set serveroutput off
quit
/
