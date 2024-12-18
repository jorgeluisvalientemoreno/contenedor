column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                         Aplicando Entrega OSF-2388                       "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "

prompt "--------------------------------INICIO------------------------------------"
prompt "                                                                          "

prompt "                                                                          " 
prompt "--------------------1.PAQUETE LDC_PKVALIDASUSPCONE------------------------" 
prompt "                                                                          " 

prompt "                                                                          "
prompt "Aplicando ejecución del paquete ldc_pkvalidasuspcone                      " 
prompt "en directorio src/gascaribe/cartera/suspensiones/paquetes                 "
@src/gascaribe/cartera/suspensiones/paquetes/ldc_pkvalidasuspcone.sql 
show errors;
prompt "                                                                          "

prompt "                                                                          " 
prompt "--------------------2.PAQUETE LDC_PKGESTPREXCLURP-------------------------" 
prompt "                                                                          " 

prompt "                                                                          "
prompt "Aplicando ejecución del paquete ldc_pkgestprexclurp                       " 
prompt "en directorio src/gascaribe/revision-periodica/paquetes                   "
@src/gascaribe/revision-periodica/paquetes/ldc_pkgestprexclurp.sql 
show errors;
prompt "                                                                          "

prompt "                                                                          " 
prompt "--------------------3.PAQUETE LDC_PKGESTIONITEMS -------------------------" 
prompt "                                                                          " 

prompt "                                                                          "
prompt "Aplicando ejecución del paquete ldc_pkgestionitems                        " 
prompt "en directorio src/gascaribe/general/paquetes                              "
@src/gascaribe/general/paquetes/ldc_pkgestionitems.sql 
show errors;
prompt "                                                                          "

prompt "                                                                          " 
prompt "--------------------4.PAQUETE LDC_PKTRDIFSUBACTE -------------------------" 
prompt "                                                                          " 

prompt "                                                                          "
prompt "Aplicando ejecución del paquete ldc_pktrdifsubacte                        " 
prompt "en directorio src/gascaribe/facturacion/paquetes                          "
@src/gascaribe/facturacion/paquetes/ldc_pktrdifsubacte.sql 
show errors;
prompt "                                                                          "


prompt "                                                                          " 
prompt "----------------------- 5.PAQUETE PKG_ESTAPROC ---------------------------" 
prompt "                                                                          " 

prompt "                                                                          "
prompt "Aplicando ejecución del paquete pkg_estaproc                              "
prompt "en directorio src/gascaribe/general/paquetes                              "
@src/gascaribe/general/paquetes/personalizaciones.pkg_estaproc.sql
show errors;
prompt "                                                                          "

prompt "                                                                          " 
prompt "---------------6.AJUSTE OBSERVACION HOMOLOGACIONSERVICIOS ----------------" 
prompt "                                                                          " 

prompt "Aplicando update en HomologacionServicios                                 "
prompt "en directorio src/gascaribe/datafix                                       "
@src/gascaribe/datafix/OSF_2388_UpdtHomologacionServicios.sql
show errors;

prompt "                                                                          "
prompt "                                                                          " 
prompt "---------------7.INSERTAR REGISTRO HOMOLOGACIONSERVICIOS  ----------------" 
prompt "                                                                          " 

prompt "Aplicando insert en HomologacionServicios                                 "
prompt "en directorio src/gascaribe/datafix                                       "
@src/gascaribe/datafix/OSF_2388_InsertHomologacionServicios.sql
show errors;
prompt "                                                                          "

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------------FINALIZA-----------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                        Fin Aplica Entrega OSF-2388                       "
prompt "--------------------------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit 