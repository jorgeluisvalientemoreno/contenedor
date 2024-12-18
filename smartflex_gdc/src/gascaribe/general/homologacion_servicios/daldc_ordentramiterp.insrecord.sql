declare

  contador Number;

begin

  select count(1)
    into contador
    from ADM_PERSON.homologacion_servicios
   where servicio_origen = 'DALDC_ORDENTRAMITERP.INSRECORD';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'DALDC_ORDENTRAMITERP.INSRECORD',
       'Inserta registro en al entidad ldc_ordentramiterp',
       'ADM_PERSON',
       'PKG_LDC_ORDENTRAMITERP.PRCINSERTAREGISTRO',
       'Inserta registro en al entidad ldc_ordentramiterp',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DALDC_ORDENTRAMITERP.INSRECORD REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DALDC_ORDENTRAMITERP.INSRECORD YA EXISTE.');
  end if;
exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/


