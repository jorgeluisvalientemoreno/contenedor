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


prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/cc_bowaitforpayment.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/cc_bowaitforpayment.sql

prompt "Aplicando src/gascaribe/recaudos/paquetes/adm_person.pkg_bogestion_pagos.sql"
@src/gascaribe/recaudos/paquetes/adm_person.pkg_bogestion_pagos.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4574_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-4574_homologacion_servicios.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4574_ins_cod_ean_codigo_barras_gdca.sql"
@src/gascaribe/datafix/OSF-4574_ins_cod_ean_codigo_barras_gdca.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4574_ins_cod_ean_codigo_barras_gdgu.sql"
@src/gascaribe/datafix/OSF-4574_ins_cod_ean_codigo_barras_gdgu.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.pkg_bcimpresioncodigobarras.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_bcimpresioncodigobarras.sql

prompt "Aplicando src/gascaribe/general/sinonimos/personalizaciones.pkg_bcimpresioncodigobarras.sql"
@src/gascaribe/general/sinonimos/personalizaciones.pkg_bcimpresioncodigobarras.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.pkg_boimpresioncodigobarras.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_boimpresioncodigobarras.sql

prompt "Aplicando src/gascaribe/general/sinonimos/personalizaciones.pkg_boimpresioncodigobarras.sql"
@src/gascaribe/general/sinonimos/personalizaciones.pkg_boimpresioncodigobarras.sql

prompt "Aplicando src/gascaribe/general/paquetes/pkg_bsimpresioncodigobarras.sql"
@src/gascaribe/general/paquetes/pkg_bsimpresioncodigobarras.sql

prompt "Aplicando src/gascaribe/general/sinonimos/pkg_bsimpresioncodigobarras.sql"
@src/gascaribe/general/sinonimos/pkg_bsimpresioncodigobarras.sql


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

