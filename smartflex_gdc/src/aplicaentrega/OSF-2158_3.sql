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


prompt "Aplicando src/gascaribe/facturacion/spool/paquete/ldc_detallefact_gascaribe.pck"
@src/gascaribe/facturacion/spool/paquete/ldc_detallefact_gascaribe.pck

prompt "Aplicando src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolfac.pck"
@src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolfac.pck

prompt "Aplicando src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolconsu.pck"
@src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolconsu.pck

prompt "Aplicando src/gascaribe/facturacion/spool/framework/fwcob/ge_object_121713.sql"
@src/gascaribe/facturacion/spool/framework/fwcob/ge_object_121713.sql

prompt "Aplicando src/gascaribe/facturacion/spool/fced/confexme_72.sql"
@src/gascaribe/facturacion/spool/fced/confexme_72.sql

prompt "Aplicando src/gascaribe/facturacion/spool/fced/confexme_82.sql"
@src/gascaribe/facturacion/spool/fced/confexme_82.sql

prompt "Aplicando src/gascaribe/facturacion/spool/fced/CONFEXME_83.sql"
@src/gascaribe/facturacion/spool/fced/CONFEXME_83.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2158_3Actualizar_Tabla_Fidf.sql"
@src/gascaribe/datafix/OSF-2158_3Actualizar_Tabla_Fidf.sql

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