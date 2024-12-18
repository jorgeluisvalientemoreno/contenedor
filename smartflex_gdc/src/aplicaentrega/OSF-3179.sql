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

prompt "------------------------------------------------------"
prompt "Aplicando sinonimos"
prompt "------------------------------------------------------"


PROMPT "Aplicando src/gascaribe/cartera/sinonimo/adm_person.cc_tmp_bal_by_conc.sql"
@src/gascaribe/cartera/sinonimo/adm_person.cc_tmp_bal_by_conc.sql

PROMPT "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_proinsertaerrpagauni.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_proinsertaerrpagauni.sql

PROMPT "Aplicando src/gascaribe/general/sinonimos/adm_person.codeplfi.sql"
@src/gascaribe/general/sinonimos/adm_person.codeplfi.sql

PROMPT "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_attributes_type.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_attributes_type.sql

PROMPT "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_items_tipo_atr.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_items_tipo_atr.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_contesse.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_contesse.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_cotivenmovpromo.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_cotivenmovpromo.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_cotivenmovrefe.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_cotivenmovrefe.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_cotivenmovteco.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_cotivenmovteco.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_cotiventasmovil.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_cotiventasmovil.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_dmitmmit.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_dmitmmit.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_docuvent.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_docuvent.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_infoadicionalot.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_infoadicionalot.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_intemmit.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_intemmit.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_itemdove.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_itemdove.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_mesainfgesnotmovil.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_mesainfgesnotmovil.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_ordeninterna.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_ordeninterna.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkcrmportalweb.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkcrmportalweb.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkmesaws.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkmesaws.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkmovimaterial.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkmovimaterial.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkossventmovilgesmanu.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkossventmovilgesmanu.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkrepodatatype.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkrepodatatype.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkreservamaterial.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkreservamaterial.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pksoapapi.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pksoapapi.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkventabrilla.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkventabrilla.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seqinfogesnoot.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seqinfogesnoot.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seridmit.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_seridmit.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_sq_gestventasmovil.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_sq_gestventasmovil.sql

PROMPT "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_anexolegaliza.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_anexolegaliza.sql

PROMPT "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_or_task_types_materiales.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_or_task_types_materiales.sql

PROMPT "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_otadicional.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_otadicional.sql

PROMPT "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_otadicionalda.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_otadicionalda.sql

PROMPT "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_otdalegalizar.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_otdalegalizar.sql

PROMPT "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tipotrabadiclego.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tipotrabadiclego.sql

PROMPT "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_usualego.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_usualego.sql

PROMPT "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.tt_damage_product.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.tt_damage_product.sql

PROMPT "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.tt_damage.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.tt_damage.sql

prompt "------------------------------------------------------"
prompt "Aplicando migracion de objetos"
prompt "------------------------------------------------------"

PROMPT "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinboxdetbrilla.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinboxdetbrilla.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinboxdetbrilla.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinboxdetbrilla.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinboxdetbrilla.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinboxdetbrilla.sql

PROMPT "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinboxdetonbase.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinboxdetonbase.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinboxdetonbase.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinboxdetonbase.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinboxdetonbase.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinboxdetonbase.sql

PROMPT "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinboxdetrevp.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinboxdetrevp.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinboxdetrevp.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinboxdetrevp.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinboxdetrevp.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinboxdetrevp.sql

PROMPT "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinfoadicionalcart.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinfoadicionalcart.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinfoadicionalcart.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinfoadicionalcart.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinfoadicionalcart.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinfoadicionalcart.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkinfoadicionallega.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkinfoadicionallega.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinfoadicionallega.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinfoadicionallega.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinfoadicionallega.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinfoadicionallega.sql

PROMPT "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinfoadicionalot.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinfoadicionalot.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinfoadicionalot.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinfoadicionalot.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinfoadicionalot.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinfoadicionalot.sql

PROMPT "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinfoadicionaloym.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinfoadicionaloym.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinfoadicionaloym.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinfoadicionaloym.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinfoadicionaloym.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinfoadicionaloym.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkinfoadicionalrevp.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkinfoadicionalrevp.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinfoadicionalrevp.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinfoadicionalrevp.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinfoadicionalrevp.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinfoadicionalrevp.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkinfoadicionalvent.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkinfoadicionalvent.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinfoadicionalvent.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkinfoadicionalvent.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinfoadicionalvent.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkinfoadicionalvent.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkivr.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkivr.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkivr.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkivr.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkivr.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkivr.sql

PROMPT "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pklemadopa.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pklemadopa.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pklemadopa.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pklemadopa.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pklemadopa.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pklemadopa.sql

PROMPT "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkmovimaterial_sp.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkmovimaterial_sp.sql

PROMPT "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkordeninterna.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkordeninterna.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkordeninterna.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkordeninterna.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkordeninterna.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkordeninterna.sql

PROMPT "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkreasignaorden.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkreasignaorden.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkreasignaorden.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkreasignaorden.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkreasignaorden.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkreasignaorden.sql

PROMPT "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkupdatecustomer.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkupdatecustomer.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkupdatecustomer.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkupdatecustomer.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkupdatecustomer.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkupdatecustomer.sql

PROMPT "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_resetintmenscajagris.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_resetintmenscajagris.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_resetintmenscajagris.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_resetintmenscajagris.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_resetintmenscajagris.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_resetintmenscajagris.sql

PROMPT "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_botrabajoadicional.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_botrabajoadicional.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_botrabajoadicional.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_botrabajoadicional.sql

PROMPT "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_botrabajoadicional.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_botrabajoadicional.sql

PROMPT "Aplicando src/gascaribe/datafix/OSF-3179_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-3179_actualizar_obj_migrados.sql

prompt "Aplicando src/test/recompilar-objetos.sql"
@src/test/recompilar-objetos.sql


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

