column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2892"
prompt "-----------------"

prompt "-----procedimiento DLRMTUS-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN dlrmtus.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/dlrmtus.sql


prompt "-----procedimiento GDO_MATRIZTRANSDETERIO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN gdo_matriztransdeterio.sql"
@src/gascaribe/papelera-reciclaje/paquetes/gdo_matriztransdeterio.sql


prompt "-----procedimiento IC_BOLISIMPROVREV-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ic_bolisimprovrev.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ic_bolisimprovrev.sql


prompt "-----procedimiento IC_BSLISIMPROVREV-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ic_bslisimprovrev.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ic_bslisimprovrev.sql


prompt "-----procedimiento PKLD_BLOCKED_QUERY-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkld_blocked_query.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_blocked_query.sql


prompt "-----procedimiento PKLD_CREDIT_BUREAU_QUERY-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkld_credit_bureau_query.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_credit_bureau_query.sql


prompt "-----procedimiento PKLD_FA_BCAPPLICAPARAM-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkld_fa_bcapplicaparam.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bcapplicaparam.sql


prompt "-----procedimiento PKLD_FA_BCGENERALPARAMETERS-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkld_fa_bcgeneralparameters.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bcgeneralparameters.sql


prompt "-----procedimiento PKLD_FA_BCMADESCPRPA-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkld_fa_bcmadescprpa.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bcmadescprpa.sql


prompt "-----procedimiento PKLD_FA_BCODETADEPP-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkld_fa_bcodetadepp.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bcodetadepp.sql


prompt "-----procedimiento PKLD_FA_BCQUERYPDD-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkld_fa_bcquerypdd.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bcquerypdd.sql


prompt "-----procedimiento PKLD_FA_BCQUERYREFERIDO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkld_fa_bcqueryreferido.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bcqueryreferido.sql


prompt "-----procedimiento PKLD_FA_BCREGISTERSUBSCRIBE-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkld_fa_bcregistersubscribe.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bcregistersubscribe.sql


prompt "-----procedimiento PKLD_FA_BOSUSCRIBEREFER-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkld_fa_bosuscriberefer.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bosuscriberefer.sql


prompt "-----procedimiento PKLD_FA_BSDISCOUNTAPPL2-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkld_fa_bsdiscountappl2.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bsdiscountappl2.sql


prompt "-----procedimiento PKLD_FA_BSDISCOUNTAPPLNO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkld_fa_bsdiscountapplno.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bsdiscountapplno.sql


prompt "-----procedimiento PKLICENSEINFO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pklicenseinfo.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pklicenseinfo.sql


prompt "-----procedimiento PKMO_PACKAGE-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkmo_package.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkmo_package.sql


prompt "-----procedimiento PKPARAGENERAL-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN pkparageneral.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkparageneral.sql


prompt "-----procedimiento RQCFG_100236_-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN rqcfg_100236_.sql"
@src/gascaribe/papelera-reciclaje/paquetes/rqcfg_100236_.sql


prompt "-----procedimiento RQTY_100238_-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN rqty_100238_.sql"
@src/gascaribe/papelera-reciclaje/paquetes/rqty_100238_.sql


prompt "-----procedimiento RQTY_100266_-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN rqty_100266_.sql"
@src/gascaribe/papelera-reciclaje/paquetes/rqty_100266_.sql


prompt "-----procedimiento UT_EAN_CARDIF3-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ut_ean_cardif3.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ut_ean_cardif3.sql


prompt "-----procedimiento UT_EAN_CARDIF4-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ut_ean_cardif4.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ut_ean_cardif4.sql


prompt "-----procedimiento UT_EAN_CARDIF5-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ut_ean_cardif5.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ut_ean_cardif5.sql


prompt "-----Script OSF-2892_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2892_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2892-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on

prompt "-----RECOMPILAR OBJETOS-----"
prompt "--->Aplicando recompilar objetos"
@src/test/recompilar-objetos.sql
show errors;
