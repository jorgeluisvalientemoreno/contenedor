declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'DAMO_MOTIVE.FNUGETMOTIVE_ID'; 

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'DAMO_MOTIVE.FNUGETMOTIVE_ID',
       'Obtiene el motivo',
       'ADM_PERSON',
       'PKG_BCSOLICITUDES.FNUOBTENERMOTIVODESOLICITUD',
       'Obtiene el motivo asociado a la solicitud',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DAMO_MOTIVE.FNUGETMOTIVE_ID REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DAMO_MOTIVE.FNUGETMOTIVE_ID YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
