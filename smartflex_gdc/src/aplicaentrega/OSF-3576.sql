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

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ldc_docuorder.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ldc_docuorder.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ldc_titrdocu.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ldc_titrdocu.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ld_quota_block.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ld_quota_block.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ldc_audocuorder.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ldc_audocuorder.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_session.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_session.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.pkg_ldc_audocuorder.sql"
@src/gascaribe/fnb/paquetes/adm_person.pkg_ldc_audocuorder.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.pkg_ldc_audocuorder.sql"
@src/gascaribe/fnb/sinonimos/adm_person.pkg_ldc_audocuorder.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/adm_person.pkg_ldc_docuorder.sql"
@src/gascaribe/fnb/paquetes/adm_person.pkg_ldc_docuorder.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.pkg_ldc_docuorder.sql"
@src/gascaribe/fnb/sinonimos/adm_person.pkg_ldc_docuorder.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/personalizaciones.pkg_bcacotesdo.sql"
@src/gascaribe/fnb/paquetes/personalizaciones.pkg_bcacotesdo.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/personalizaciones.pkg_bcacotesdo.sql"
@src/gascaribe/fnb/sinonimos/personalizaciones.pkg_bcacotesdo.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/personalizaciones.pkg_boacotesdo.sql"
@src/gascaribe/fnb/paquetes/personalizaciones.pkg_boacotesdo.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/personalizaciones.pkg_boacotesdo.sql"
@src/gascaribe/fnb/sinonimos/personalizaciones.pkg_boacotesdo.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/pkg_uiacotesdo.sql"
@src/gascaribe/fnb/paquetes/pkg_uiacotesdo.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/pkg_uiacotesdo.sql"
@src/gascaribe/fnb/sinonimos/pkg_uiacotesdo.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/fwcpb/acotesdo.sql"
@src/gascaribe/gestion-ordenes/fwcpb/acotesdo.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.ldc_fnconsultaotesdoc.sql"
@src/gascaribe/fnb/funciones/adm_person.ldc_fnconsultaotesdoc.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_practualizaotesdoc.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_practualizaotesdoc.sql


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

