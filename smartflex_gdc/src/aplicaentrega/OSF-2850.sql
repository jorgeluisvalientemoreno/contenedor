column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2850"
prompt "-----------------"

prompt "-----paquete LDC_BSGESTIONREEXO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bsgestionreexo.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bsgestionreexo.sql


prompt "-----paquete LDC_CT_BOORDERREVOKE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_ct_boorderrevoke.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_ct_boorderrevoke.sql


prompt "-----paquete LDC_DETALLEFACT_GASCARIBEV2-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_detallefact_gascaribev2.sql"
@src/gascaribe/gestion-ordenes/paquetes/ldc_detallefact_gascaribev2.sql


prompt "-----paquete LDC_DSCATEGORI-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_dscategori.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dscategori.sql


prompt "-----paquete LDC_DSPLANDIFE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_dsplandife.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsplandife.sql


prompt "-----paquete LDC_DSSERVICIO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_dsservicio.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dsservicio.sql


prompt "-----paquete LDC_FINANRECO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_finanreco.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_finanreco.sql


prompt "-----paquete LDC_FORMPAGO_PARCIAL-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_formpago_parcial.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_formpago_parcial.sql


prompt "-----paquete LDC_FUNCIONES_PARA_ORMS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_funciones_para_orms.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_funciones_para_orms.sql


prompt "-----paquete LDC_GENERA_XML_SERASO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_genera_xml_seraso.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_genera_xml_seraso.sql


prompt "-----paquete LDC_IMPESTADOCUENTA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_impestadocuenta.sql"
@src/gascaribe/atencion-usuarios/paquetes/ldc_impestadocuenta.sql


prompt "-----paquete LDC_INFOREPCARFNB-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_inforepcarfnb.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_inforepcarfnb.sql


prompt "-----paquete LDC_ITEM_DESPLAZAMIENTO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_item_desplazamiento.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_item_desplazamiento.sql


prompt "-----paquete LDC_MASSIVEBRLEGALIZA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_massivebrlegaliza.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_massivebrlegaliza.sql


prompt "-----paquete LDC_MUES_ALEATORIA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_mues_aleatoria.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_mues_aleatoria.sql


prompt "-----paquete LDC_OOP_PRUEBAS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_oop_pruebas.sql"
@src/gascaribe/gestion-ordenes/paquetes/ldc_oop_pruebas.sql


prompt "-----paquete LDC_PAYMENTFORMAT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_paymentformat.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_paymentformat.sql


prompt "-----paquete LDC_BSGESTIONTARIFAS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bsgestiontarifas.sql"
@src/gascaribe/facturacion/paquetes/ldc_bsgestiontarifas.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.fa_mercrele.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.fa_mercrele.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.gst_tipomone.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.gst_tipomone.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_conftari.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_conftari.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_temptari.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_temptari.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ta_proytari.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ta_proytari.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bsgestiontarifas.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_bsgestiontarifas.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bsgestiontarifas.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_bsgestiontarifas.sql


prompt "-----paquete LDC_CARGUEINFOCONTRA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_cargueinfocontra.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_cargueinfocontra.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ldc_procesacontratos.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.seq_ldc_procesacontratos.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_tempocontratos.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_tempocontratos.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_procesacontratos.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_procesacontratos.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_logcargueinfo.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_logcargueinfo.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_logcargueinfo.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.seq_codcargue.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_cargueinfocontra.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_cargueinfocontra.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_cargueinfocontra.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_cargueinfocontra.sql


prompt "-----paquete LDC_ELIMINAREXCLUSION-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_eliminarexclusion.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_eliminarexclusion.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.dact_excluded_order.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.dact_excluded_order.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_eliminarexclusion.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.ldc_eliminarexclusion.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_eliminarexclusion.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_eliminarexclusion.sql


prompt "-----paquete LDC_MATBLOQANILLO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_matbloqanillo.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_matbloqanillo.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_matbloqanillo.sql"
@src/gascaribe/servicios-nuevos/paquetes/adm_person.ldc_matbloqanillo.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_matbloqanillo.sql"
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_matbloqanillo.sql


prompt "-----paquete LDC_PAKGENFORMCOTI-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pakgenformcoti.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pakgenformcoti.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_coticonstructora_adic.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_coticonstructora_adic.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pakgenformcoti.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_pakgenformcoti.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pakgenformcoti.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_pakgenformcoti.sql


prompt "-----Script OSF-2850_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2850_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2850-----"
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
