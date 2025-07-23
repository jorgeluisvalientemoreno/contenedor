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

prompt "Aplicando src/migracion-guajira/tablas/homologacion.homocate.sql"
@src/migracion-guajira/tablas/homologacion.homocate.sql

prompt "Aplicando src/migracion-guajira/tablas/homologacion.homociclo.sql"
@src/migracion-guajira/tablas/homologacion.homociclo.sql

prompt "Aplicando src/migracion-guajira/tablas/homologacion.homoconcepto.sql"
@src/migracion-guajira/tablas/homologacion.homoconcepto.sql

prompt "Aplicando src/migracion-guajira/tablas/homologacion.homoestapr.sql"
@src/migracion-guajira/tablas/homologacion.homoestapr.sql

prompt "Aplicando src/migracion-guajira/tablas/homologacion.homomecadife.sql"
@src/migracion-guajira/tablas/homologacion.homomecadife.sql

prompt "Aplicando src/migracion-guajira/tablas/homologacion.homopefa.sql"
@src/migracion-guajira/tablas/homologacion.homopefa.sql

prompt "Aplicando src/migracion-guajira/tablas/homologacion.homoplfa.sql"
@src/migracion-guajira/tablas/homologacion.homoplfa.sql

prompt "Aplicando src/migracion-guajira/tablas/homologacion.homoserv.sql"
@src/migracion-guajira/tablas/homologacion.homoserv.sql

prompt "Aplicando src/migracion-guajira/tablas/homologacion.homosuca.sql"
@src/migracion-guajira/tablas/homologacion.homosuca.sql

prompt "Aplicando src/migracion-guajira/tablas/homologacion.homotais.sql"
@src/migracion-guajira/tablas/homologacion.homotais.sql

prompt "Aplicando src/migracion-guajira/tablas/migragg.conf_proc_migra.sql"
@src/migracion-guajira/tablas/migragg.conf_proc_migra.sql

prompt "Aplicando src/migracion-guajira/tablas/migragg.log_proc_migra.sql"
@src/migracion-guajira/tablas/migragg.log_proc_migra.sql

prompt "Aplicando src/migracion-guajira/tablas/migragg.log_proc_migra_det.sql"
@src/migracion-guajira/tablas/migragg.log_proc_migra_det.sql


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