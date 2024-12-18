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

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkcrmfinbrillaportal.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkcrmfinbrillaportal.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkgestlegaorden.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkgestlegaorden.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkgestnotiorden.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkgestnotiorden.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkinterfazordlec.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkinterfazordlec.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkjobenviomensa.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkjobenviomensa.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkmoviventmate.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkmoviventmate.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkreservamaterial.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkreservamaterial.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_temppkgestlegaorden.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_temppkgestlegaorden.sql

prompt "Aplicando src/gascaribe/revision-periodica/suspension/paquetes/gdc_bosuspension_xno_cert.sql"
@src/gascaribe/revision-periodica/suspension/paquetes/gdc_bosuspension_xno_cert.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/paquetes/ldc_pkcostoingreso.sql"
@src/gascaribe/general/interfaz-contable/paquetes/ldc_pkcostoingreso.sql

prompt "Aplicando src/gascaribe/revision-periodica/suspension/paquetes/ldc_pkgestioncasurp.sql"
@src/gascaribe/revision-periodica/suspension/paquetes/ldc_pkgestioncasurp.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgvalga.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgvalga.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_actprodrp.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_actprodrp.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/ldc_asigdircontructoras.sql"
@src/gascaribe/ventas/paquetes/ldc_asigdircontructoras.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/package/ldc_bcrevokeots.sql"
@src/gascaribe/gestion-ordenes/package/ldc_bcrevokeots.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/ldc_boldsemail.sql"
@src/gascaribe/atencion-usuarios/paquetes/ldc_boldsemail.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_paqueteanexoa.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_paqueteanexoa.sql

prompt "Aplicando src/gascaribe/facturacion/notificaciones/paquetes/ldc_bonotyconsrec.sql"
@src/gascaribe/facturacion/notificaciones/paquetes/ldc_bonotyconsrec.sql

prompt "Recompilando objetos invalidos"
@src/test/recompilar-objetos.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on

prompt "                                                                          "
prompt "---------------------------RECOMPILAR OBJETOS-----------------------------"
prompt "                                                                          "

prompt "--->Aplicando recompilar objetos"
@src/test/recompilar-objetos.sql
show errors;
quit
/