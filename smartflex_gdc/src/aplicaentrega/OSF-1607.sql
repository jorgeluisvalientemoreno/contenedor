column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0 OSF-1607" 
prompt "------------------------------------------------------"


prompt "Creando sinónimos pkaccountmgr.sql"
@src/gascaribe/objetos-producto/sinonimos/pkaccountmgr.sql
show errors; 

prompt "Creando sinónimos pkupdaccoreceiv.sql"
@src/gascaribe/objetos-producto/sinonimos/pkupdaccoreceiv.sql
show errors; 

prompt "Aplicando  procedimiento adm_person.api_ajustarcuenta.sql"
@src/gascaribe/cartera/api/adm_person.api_ajustarcuenta.sql
show errors; 

prompt "Creando sinónimo adm_person.api_ajustarcuenta.sql"
@src/gascaribe/cartera/sinonimo/adm_person.api_ajustarcuenta.sql

prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega V1.0 OSF-1607"
prompt "------------------------------------------------------"


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit