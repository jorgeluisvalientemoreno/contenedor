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

prompt "Aplicando src/gascaribe/actas/sinonimos/ldc_act_father_act_hija.sql"
@src/gascaribe/actas/sinonimos/ldc_act_father_act_hija.sql

prompt "Aplicando src/gascaribe/actas/sinonimos/ldc_const_liqtarran.sql"
@src/gascaribe/actas/sinonimos/ldc_const_liqtarran.sql

prompt "Aplicando src/gascaribe/actas/sinonimos/ldc_const_unoprl.sql"
@src/gascaribe/actas/sinonimos/ldc_const_unoprl.sql

prompt "Aplicando src/gascaribe/actas/sinonimos/ldc_item_uo_lr.sql"
@src/gascaribe/actas/sinonimos/ldc_item_uo_lr.sql

prompt "Aplicando src/gascaribe/actas/sinonimos/ldc_tipo_trab_x_nov_ofertados.sql"
@src/gascaribe/actas/sinonimos/ldc_tipo_trab_x_nov_ofertados.sql

prompt "Aplicando src/gascaribe/actas/sinonimos/ldc_unid_oper_hija_mod_tar.sql"
@src/gascaribe/actas/sinonimos/ldc_unid_oper_hija_mod_tar.sql

prompt "Aplicando src/gascaribe/actas/sinonimos/ldc_zona_loc_ofer_cart.sql"
@src/gascaribe/actas/sinonimos/ldc_zona_loc_ofer_cart.sql

prompt "Aplicando src/gascaribe/actas/sinonimos/ldc_zona_ofer_cart.sql"
@src/gascaribe/actas/sinonimos/ldc_zona_ofer_cart.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ct_order_certifica.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ct_order_certifica.sql

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