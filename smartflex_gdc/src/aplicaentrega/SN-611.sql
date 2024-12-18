column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SN-611');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"


prompt "Aplicando src/ejecutores/bajar-ejecutores.sql"
@src/ejecutores/bajar-ejecutores.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/piloto-cesar/parametro/cod_peri_gracia_piloto_sn_ces.sql"
@src/gascaribe/servicios-nuevos/piloto-cesar/parametro/cod_peri_gracia_piloto_sn_ces.sql



prompt "Aplicando src/gascaribe/servicios-nuevos/piloto-cesar/funcion/ldc_fsbsolmarkedpilotosn.sql"
@src/gascaribe/servicios-nuevos/piloto-cesar/funcion/ldc_fsbsolmarkedpilotosn.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/piloto-cesar/procedimientos/ldc_prgetpackageinst.sql"
@src/gascaribe/servicios-nuevos/piloto-cesar/procedimientos/ldc_prgetpackageinst.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/piloto-cesar/procedimientos/ldc_prasociaperiodogracia.sql"
@src/gascaribe/servicios-nuevos/piloto-cesar/procedimientos/ldc_prasociaperiodogracia.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/piloto-cesar/procedimientos/ldc_prdesasociaperiodogracia.sql"
@src/gascaribe/servicios-nuevos/piloto-cesar/procedimientos/ldc_prdesasociaperiodogracia.sql


prompt "Aplicando src/gascaribe/servicios-nuevos/piloto-cesar/procedimientos/ldc_prfinalizaperiodogracia.sql"
@src/gascaribe/servicios-nuevos/piloto-cesar/procedimientos/ldc_prfinalizaperiodogracia.sql



prompt "Aplicando src/gascaribe/fwcob/GE_OBJECT_121684.sql"
@src/gascaribe/fwcob/GE_OBJECT_121684.sql

prompt "Aplicando src/gascaribe/fwcob/GE_OBJECT_121686.sql"
@src/gascaribe/fwcob/GE_OBJECT_121686.sql


prompt "Aplicando src/gascaribe/fwcob/GE_OBJECT_121688.sql"
@src/gascaribe/fwcob/GE_OBJECT_121688.sql

prompt "Aplicando src/gascaribe/fwcob/GE_OBJECT_121694.sql"
@src/gascaribe/fwcob/GE_OBJECT_121694.sql



prompt "Aplicando src/gascaribe/flujos/WF_UNIT_TYPE_154.sql"
@src/gascaribe/flujos/WF_UNIT_TYPE_154.sql

prompt "Aplicando src/gascaribe/flujos/WF_UNIT_TYPE_100595.sql"
@src/gascaribe/flujos/WF_UNIT_TYPE_100595.sql

prompt "Aplicando src/gascaribe/datafix/SN-611_ConfiguraPlugin.sql"
@src/gascaribe/datafix/SN-611_ConfiguraPlugin.sql









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