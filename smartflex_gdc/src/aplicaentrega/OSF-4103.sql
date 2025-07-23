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

prompt "Aplicando src/gascaribe/multiempresa/tablas/personalizaciones.secuencia_tipodocu_emfael.sql"
@src/gascaribe/multiempresa/tablas/personalizaciones.secuencia_tipodocu_emfael.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/personalizaciones.secuencia_tipodocu_emfael.sql"
@src/gascaribe/multiempresa/sinonimos/personalizaciones.secuencia_tipodocu_emfael.sql

prompt "Aplicando src/gascaribe/multiempresa/secuencias/personalizaciones.seq_fac_elec_gen_consvent_gdgu.sql"
@src/gascaribe/multiempresa/secuencias/personalizaciones.seq_fac_elec_gen_consvent_gdgu.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/personalizaciones.seq_fac_elec_gen_consvent_gdgu.sql"
@src/gascaribe/multiempresa/sinonimos/personalizaciones.seq_fac_elec_gen_consvent_gdgu.sql

prompt "Aplicando src/gascaribe/multiempresa/secuencias/personalizaciones.seq_fac_elec_gen_consfael_gdgu.sql"
@src/gascaribe/multiempresa/secuencias/personalizaciones.seq_fac_elec_gen_consfael_gdgu.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/personalizaciones.seq_fac_elec_gen_consfael_gdgu.sql"
@src/gascaribe/multiempresa/sinonimos/personalizaciones.seq_fac_elec_gen_consfael_gdgu.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4103_insertar_secuencia_tipodocu_emfael.sql"
@src/gascaribe/datafix/OSF-4103_insertar_secuencia_tipodocu_emfael.sql

prompt "Aplicando src/gascaribe/multiempresa/fwcea/vw_empresa.sql"
@src/gascaribe/multiempresa/fwcea/vw_empresa.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/tablas/recofael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/tablas/recofael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/indices/idx_recofael_01.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/indices/idx_recofael_01.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/fwcea/recofael.sql"
@src/gascaribe/facturacion/facturacion_electronica/fwcea/recofael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/fwcmd/mdccfe.sql"
@src/gascaribe/facturacion/facturacion_electronica/fwcmd/mdccfe.sql

prompt "Aplicando src /gascaribe/datafix/OSF-4103_borrar_sinonimos_pkg_recofael.sql"
@src/gascaribe/datafix/OSF-4103_borrar_sinonimos_pkg_recofael.sql


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

