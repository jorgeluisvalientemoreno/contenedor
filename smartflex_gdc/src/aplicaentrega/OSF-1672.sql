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

prompt "Aplicando src/gascaribe/operacion-y-mantenimiento/paquetes/personalizaciones.pkg_xml_soli_emerg.sql"
@src/gascaribe/operacion-y-mantenimiento/paquetes/personalizaciones.pkg_xml_soli_emerg.sql

prompt "Aplicando src/gascaribe/operacion-y-mantenimiento/sinonimos/personalizaciones.pkg_xml_soli_emerg.sql"
@src/gascaribe/operacion-y-mantenimiento/sinonimos/personalizaciones.pkg_xml_soli_emerg.sql

prompt "@src/gascaribe/revision-periodica/certificados/procedimientos/personalizaciones.oal_certificado_dano_producto.sql"
@src/gascaribe/revision-periodica/certificados/procedimientos/personalizaciones.oal_certificado_dano_producto.sql

prompt "src/gascaribe/general/sinonimos/adm.api_registrodanoproductoxml.sql"
@src/gascaribe/general/sinonimos/adm.api_registrodanoproductoxml.sql

prompt "src/gascaribe/general/procedimientos/adm_person.api_registrodanoproductoxml.sql"
@src/gascaribe/general/procedimientos/adm_person.api_registrodanoproductoxml.sql


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