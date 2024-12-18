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

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.finanprioritygdc.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.finanprioritygdc.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.frcgetunidoperteccert.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.frcgetunidoperteccert.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_atentesolotfinrevper.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_atentesolotfinrevper.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_consultacertvigtec.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_consultacertvigtec.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_consultacertvigtecfe.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_consultacertvigtecfe.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ldcfncretornamesliq.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ldcfncretornamesliq.sql

prompt "Aplicando src/gascaribe/Cierre/sinonimos/adm_person.ldcfnu_venanoactual.sql"
@src/gascaribe/Cierre/sinonimos/adm_person.ldcfnu_venanoactual.sql

prompt "Aplicando src/gascaribe/Cierre/sinonimos/adm_person.ldcfnu_venanodirec.sql"
@src/gascaribe/Cierre/sinonimos/adm_person.ldcfnu_venanodirec.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_per_comercial.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_per_comercial.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_retornaintmofi.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_retornaintmofi.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3254_actualizar_master_person.sql"
@src/gascaribe/datafix/OSF-3254_actualizar_master_person.sql

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