declare

  contador Number;

begin

  select count(1)
    into contador
    from ADM_PERSON.homologacion_servicios
   where servicio_origen = 'DAOR_OPE_UNI_ITEM_BALA.FNUGETTRANSIT_OUT_TOTAL';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'DAOR_OPE_UNI_ITEM_BALA.FNUGETTRANSIT_OUT_TOTAL',
       'Obtiene el total de items en transito saliente en la bodega de una unidad operativa',
       'ADM_PERSON',
       'PKG_BCOR_OPE_UNI_ITEM_BALA.FNUTOTALTRANSITOSALIDA',
       'Obtiene el total de items en transito saliente en la bodega de una unidad operativa',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DAOR_OPE_UNI_ITEM_BALA.FNUGETTRANSIT_OUT_TOTAL REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DAOR_OPE_UNI_ITEM_BALA.FNUGETTRANSIT_OUT_TOTAL YA EXISTE.');
  end if;
exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
