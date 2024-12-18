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


prompt "Aplicando src/gascaribe/gestion-ordenes/package/ldc_generavtingvis.sql"
@src/gascaribe/gestion-ordenes/package/ldc_generavtingvis.sql

prompt "Aplicando src/gascaribe/fnb/procedimientos/ldc_pasadifeapmplano.sql"
@src/gascaribe/fnb/procedimientos/ldc_pasadifeapmplano.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/paquetes/ldc_pkajustasuspcone.sql"
@src/gascaribe/cartera/suspensiones/paquetes/ldc_pkajustasuspcone.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/ldc_boprintfofactcustmgr.sql"
@src/gascaribe/facturacion/paquetes/ldc_boprintfofactcustmgr.sql

prompt "Aplicando src/gascaribe/general/procedimientos/ldc_insertitemsmasivo.sql"
@src/gascaribe/general/procedimientos/ldc_insertitemsmasivo.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2381_1_Homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-2381_1_Homologacion_servicios.sql

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
