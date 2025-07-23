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

prompt "Aplicando src/gascaribe/recaudos/sinonimos/sucubanc.sql"
@src/gascaribe/recaudos/sinonimos/sucubanc.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_fsbnumformulario.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_fsbnumformulario.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_bcimpresioncertificcliente.sql"
@src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_bcimpresioncertificcliente.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_bcimpresioncertificcliente.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_bcimpresioncertificcliente.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_boimpresioncertificcliente.sql"
@src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_boimpresioncertificcliente.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_boimpresioncertificcliente.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_boimpresioncertificcliente.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/pkg_bsimpresioncertificcliente.sql"
@src/gascaribe/atencion-usuarios/paquetes/pkg_bsimpresioncertificcliente.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/pkg_bsimpresioncertificcliente.sql"
@src/gascaribe/atencion-usuarios/sinonimos/pkg_bsimpresioncertificcliente.sql

prompt "Aplicando src/gascaribe/general/paquetes/pkg_bsimpresionempresa.sql"
@src/gascaribe/general/paquetes/pkg_bsimpresionempresa.sql




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

