column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO INN SN - VEN-766');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/datafix/VEN-766_Borrar_cargos_de_mas_facturados.sql"
@src/gascaribe/datafix/VEN-766_Borrar_cargos_de_mas_facturados.sql
prompt "Aplicando src/gascaribe/datafix/VEN-766_Borrar_cargos_de_mas_menos_uno.sql"
@src/gascaribe/datafix/VEN-766_Borrar_cargos_de_mas_menos_uno.sql
prompt "Aplicando src/gascaribe/datafix/VEN-766_Cambiar_comentario_solicitudes.sql"
@src/gascaribe/datafix/VEN-766_Cambiar_comentario_solicitudes.sql
prompt "Aplicando src/gascaribe/datafix/VEN-766_Generar_cargos_marcados_error.sql"
@src/gascaribe/datafix/VEN-766_Generar_cargos_marcados_error.sql

prompt "Datafix terminado"

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/
