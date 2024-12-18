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

prompt "Aplicando src/gascaribe/recaudos/parametros/direc_arch_cupon_pend_pago_1.sql"
@src/gascaribe/recaudos/parametros/direc_arch_cupon_pend_pago_1.sql

prompt "Aplicando src/gascaribe/recaudos/parametros/direc_arch_cupon_pend_pago_2.sql"
@src/gascaribe/recaudos/parametros/direc_arch_cupon_pend_pago_2.sql

prompt "src/gascaribe/fnb/sinonimos/adm_person.ld_bopackagefnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bopackagefnb.sql

prompt "src/gascaribe/recaudos/sinonimos/adm_person.logcupon.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.logcupon.sql

prompt "Aplicando src/gascaribe/recaudos/procedimientos/adm_person.procgeneracupon_bcolombia.sql"
@src/gascaribe/recaudos/procedimientos/adm_person.procgeneracupon_bcolombia.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procgeneracupon_bcolombia.sql"
@src/gascaribe/papelera-reciclaje/procgeneracupon_bcolombia.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.procgeneracupon_bcolombia.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.procgeneracupon_bcolombia.sql

prompt "Aplicando src/gascaribe/recaudos/procedimientos/adm_person.procgeneracuponaso2001.sql"
@src/gascaribe/recaudos/procedimientos/adm_person.procgeneracuponaso2001.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procgeneracuponaso2001.sql"
@src/gascaribe/papelera-reciclaje/procgeneracuponaso2001.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.procgeneracuponaso2001.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.procgeneracuponaso2001.sql

prompt "Aplicando src/gascaribe/recaudos/procedimientos/adm_person.procgeneracuponaso2001du.sql"
@src/gascaribe/recaudos/procedimientos/adm_person.procgeneracuponaso2001du.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procgeneracuponaso2001du.sql"
@src/gascaribe/papelera-reciclaje/procgeneracuponaso2001du.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.procgeneracuponaso2001du.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.procgeneracuponaso2001du.sql

prompt "Aplicando src/gascaribe/recaudos/procedimientos/adm_person.procgeneracuponaso2001_2.sql"
@src/gascaribe/recaudos/procedimientos/adm_person.procgeneracuponaso2001_2.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procgeneracuponaso2001_2.sql"
@src/gascaribe/papelera-reciclaje/procgeneracuponaso2001_2.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.procgeneracuponaso2001_2.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.procgeneracuponaso2001_2.sql

prompt "Aplicando src/gascaribe/recaudos/procedimientos/adm_person.procgeneracuponaso2001du_2.sql"
@src/gascaribe/recaudos/procedimientos/adm_person.procgeneracuponaso2001du_2.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procgeneracuponaso2001du_2.sql"
@src/gascaribe/papelera-reciclaje/procgeneracuponaso2001du_2.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.procgeneracuponaso2001du_2.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.procgeneracuponaso2001du_2.sql

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