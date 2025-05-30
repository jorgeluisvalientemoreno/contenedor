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

prompt "Aplicando src/gascaribe/fnb/seguros/cardif/parametros/par_tipocausal_cardif_def.sql"
@src/gascaribe/fnb/seguros/cardif/parametros/par_tipocausal_cardif_def.sql

prompt "Aplicando src/gascaribe/fnb/seguros/cardif/tablas/cr_ldc_tipocausalcardif.sql"
@src/gascaribe/fnb/seguros/cardif/tablas/cr_ldc_tipocausalcardif.sql

prompt "Aplicando src/gascaribe/fnb/seguros/cardif/fwcea/ldc_tipocausalcardif.sql"
@src/gascaribe/fnb/seguros/cardif/fwcea/ldc_tipocausalcardif.sql

prompt "Aplicando src/gascaribe/fnb/seguros/cardif/paquetes/daldc_tipocausalcardif.sql"
@src/gascaribe/fnb/seguros/cardif/paquetes/daldc_tipocausalcardif.sql

prompt "Aplicando src/gascaribe/fnb/seguros/cardif/paquetes/ut_ean_cardif.sql"
@src/gascaribe/fnb/seguros/cardif/paquetes/ut_ean_cardif.sql

prompt "Aplicando src/gascaribe/fnb/seguros/cardif/fwcmd/ldctipocardif.sql"
@src/gascaribe/fnb/seguros/cardif/fwcmd/ldctipocardif.sql

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