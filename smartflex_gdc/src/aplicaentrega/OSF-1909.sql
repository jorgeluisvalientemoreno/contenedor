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

prompt "Aplicando src/gascaribe/gestion-ordenes/tablas/personalizaciones.detalle_ot_agrupada.sql"
@src/gascaribe/gestion-ordenes/tablas/personalizaciones.detalle_ot_agrupada.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bcparametros_open.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bcparametros_open.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_bcparametros_open.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_bcparametros_open.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.detalle_ot_agrupada.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.detalle_ot_agrupada.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/seq_or_order_items.sql"
@src/gascaribe/objetos-producto/sinonimos/seq_or_order_items.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order_items.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order_items.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_or_order_items.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_or_order_items.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_detalle_ot_agrupada.sql"
@src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_detalle_ot_agrupada.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_detalle_ot_agrupada.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_detalle_ot_agrupada.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_bcordenes_industriales.sql"
@src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_bcordenes_industriales.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_bcordenes_industriales.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_bcordenes_industriales.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_boordenes_industriales.sql"
@src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_boordenes_industriales.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_boordenes_industriales.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_boordenes_industriales.sql

prompt "Aplicando src/gascaribe/facturacion/schedules/job_agrupaottitr.sql"
@src/gascaribe/facturacion/schedules/job_agrupaottitr.sql

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