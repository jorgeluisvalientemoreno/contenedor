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


prompt "Aplicando src/gascaribe/revision-periodica/certificados/parametros/causpadreotrevp.sql"
@src/gascaribe/revision-periodica/certificados/parametros/causpadreotrevp.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/parametros/titrpadreotrevp.sql"
@src/gascaribe/revision-periodica/certificados/parametros/titrpadreotrevp.sql


prompt "Aplicando src/gascaribe/revision-periodica/certificados/parametros/ldc_causpadreotrevp.sql"
@src/gascaribe/revision-periodica/certificados/parametros/ldc_causpadreotrevp.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/parametros/ldc_titrpadreotrevp.sql"
@src/gascaribe/revision-periodica/certificados/parametros/ldc_titrpadreotrevp.sql

prompt "Aplicando src/gascaribe/revision-periodica/asignacion/funciones/personalizaciones.fnuobtprimordensol.sql"
@src/gascaribe/revision-periodica/asignacion/funciones/personalizaciones.fnuobtprimordensol.sql

prompt "Aplicando src/gascaribe/revision-periodica/asignacion/sinonimos/personalizaciones.fnuobtprimordensol.sql"
@src/gascaribe/revision-periodica/asignacion/sinonimos/personalizaciones.fnuobtprimordensol.sql



prompt "Aplicando src/gascaribe/revision-periodica/asignacion/ldc_trg_marcaldcorder.sql"
@src/gascaribe/revision-periodica/asignacion/ldc_trg_marcaldcorder.sql

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