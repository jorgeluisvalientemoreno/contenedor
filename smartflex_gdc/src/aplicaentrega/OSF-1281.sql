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

prompt "Aplicando src/gascaribe/cierre/paquetes/pkborradatoscierre_gdc.sql"
@src/gascaribe/Cierre/paquetes/pkborradatoscierre_gdc.sql

prompt "Aplicando src/gascaribe/cierre/paquetes/pkborradatoscierre.sql"
@src/gascaribe/Cierre/paquetes/pkborradatoscierre.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcm_lectesp4.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcm_lectesp4.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_prlecturavalida.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prlecturavalida.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_procgeneradatoscreg_b1_gc.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procgeneradatoscreg_b1_gc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_procgeneradatoscreg_b1_gc3.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procgeneradatoscreg_b1_gc3.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_procgeneradatoscreg_b1.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procgeneradatoscreg_b1.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_procgeneradatoscreg_b2.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procgeneradatoscreg_b2.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_procgeneradatoscreg_b2.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procgeneradatoscreg_b2.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_projecjprocmes_b.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_projecjprocmes_b.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldrrepb_gc.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldrrepb_gc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldrrepb.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldrrepb.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao547566_p01_e02.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao547566_p01_e02.sql


prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_procgeneradatoscreg_b1_gc2.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procgeneradatoscreg_b1_gc2.sql






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