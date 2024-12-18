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

prompt "Aplicando src/gascaribe/servicios-nuevos/parametros/dias_sin_leg_cxc.sql"
@src/gascaribe/servicios-nuevos/parametros/dias_sin_leg_cxc.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/parametros/not_cor_cxc_sin_leg.sql"
@src/gascaribe/servicios-nuevos/parametros/not_cor_cxc_sin_leg.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/parametros/tt_cxc_sin_leg.sql"
@src/gascaribe/servicios-nuevos/parametros/tt_cxc_sin_leg.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/tablas/ldc_log_cxc_sin_leg.sql"
@src/gascaribe/servicios-nuevos/tablas/ldc_log_cxc_sin_leg.sql

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/paquetes_per/ldc_boconsgenerales.sql"
@src/gascaribe/facturacion/tarifa_transitoria/paquetes_per/ldc_boconsgenerales.sql


prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/ldc_email.sql"
@src/gascaribe/servicios-nuevos/paquetes/personalizaciones.ldc_email.sql


prompt "Aplicando src/gascaribe/servicios-nuevos/procedimientos/ldc_prnot_cxc_sin_legalizar.sql"
@src/gascaribe/servicios-nuevos/procedimientos/ldc_prnot_cxc_sin_legalizar.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/permisos/permisos_OSF-927.sql"
@src/gascaribe/servicios-nuevos/permisos/permisos_OSF-927.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/job/ldc_jobnot_cxc_sin_legalizar.sql"
@src/gascaribe/servicios-nuevos/job/ldc_jobnot_cxc_sin_legalizar.sql

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