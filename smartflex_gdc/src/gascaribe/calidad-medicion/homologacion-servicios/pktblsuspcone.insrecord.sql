declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'PKTBLSUSPCONE.INSRECORD';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'PKTBLSUSPCONE.INSRECORD',
       'Inserta registro en la entidad SUSPCONE',
       'ADM_PERSON',
       'PKG_SUSPCONE.PRCINSERTAREGISTRO',
       'Inserta registro en la entidad SUSPCONE',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO PKTBLSUSPCONE.INSRECORD REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO PKTBLSUSPCONE.INSRECORD YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
