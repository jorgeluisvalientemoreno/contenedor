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

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.dald_policy_type.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_policy_type.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.dald_validity_policy_type.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_validity_policy_type.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ld_validity_policy_type.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_validity_policy_type.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ld_policy_type.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_policy_type.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ld_product_line.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_product_line.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_condesprenovseg.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ldc_condesprenovseg.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ld_prod_line_ge_cont.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_prod_line_ge_cont.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.sqesprprog.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.sqesprprog.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.pkstatusexeprogrammgr.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.pkstatusexeprogrammgr.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ld_bosecuremanagement.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_bosecuremanagement.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ld_boutilflow.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_boutilflow.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_managementemailfnb.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ldc_managementemailfnb.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ld_renewall_securp.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_renewall_securp.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_migrapoliza.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ldc_migrapoliza.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ld_prod_line_ge_cont.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_prod_line_ge_cont.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ld_renewall_securp.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_renewall_securp.sql

prompt "Aplicando creacion de procedimiento adm_person.ldc_renewpoliciesbycollective.sql" 
@src/gascaribe/fnb/seguros/procedimientos/adm_person.ldc_renewpoliciesbycollective.sql

prompt "Aplicando borrado de procedimiento en esquema anterior O P E N ldc_renewpoliciesbycollective.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_renewpoliciesbycollective.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_renewpoliciesbycollective.sql" 
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ldc_renewpoliciesbycollective.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.dasa_role_executables.sql"
@src/gascaribe/general/sinonimos/adm_person.dasa_role_executables.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.sa_role.sql"
@src/gascaribe/general/sinonimos/adm_person.sa_role.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.sa_borole.sql"
@src/gascaribe/general/sinonimos/adm_person.sa_borole.sql


prompt "-----paquete LDC_SEGURIDADES-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_seguridades.sql"
@src/gascaribe/general/paquetes/ldc_seguridades.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_seguridades.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_seguridades.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_seguridades.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_seguridades.sql


prompt "-----paquete LDC_UISOLXML-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_uisolxml.sql"
@src/gascaribe/general/paquetes/ldc_uisolxml.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_uisolxml.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_uisolxml.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_uisolxml.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_uisolxml.sql

prompt "Aplicando src/gascaribe/general/procedimientos/ldc_validcheckitems.sql"
@src/gascaribe/general/procedimientos/ldc_validcheckitems.sql

prompt "-----Script OSF-2878_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2379_actualizar_obj_migrados.sql

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