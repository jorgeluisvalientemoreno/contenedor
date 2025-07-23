column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/cartera/sinonimo/seq_gc_prodprca_172041.sql"
@src/gascaribe/cartera/sinonimo/seq_gc_prodprca_172041.sql

prompt "Aplicando src/gascaribe/cartera/paquetes/adm_person.pkg_gc_prodprca.sql"
@src/gascaribe/cartera/paquetes/adm_person.pkg_gc_prodprca.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.pkg_gc_prodprca.sql"
@src/gascaribe/cartera/sinonimo/adm_person.pkg_gc_prodprca.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/gc_proycast.sql"
@src/gascaribe/cartera/sinonimo/gc_proycast.sql

prompt "Aplicando src/gascaribe/cartera/paquetes/adm_person.pkg_gc_proycast.sql"
@src/gascaribe/cartera/paquetes/adm_person.pkg_gc_proycast.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.pkg_gc_proycast.sql"
@src/gascaribe/cartera/sinonimo/adm_person.pkg_gc_proycast.sql

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