declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU',
       'Servicio para atender solicitud',
       'ADM_PERSON',
       'PKG_BOGESTIONSOLICITUDES.PRCATENDERSOLICITUD',
       'Servicio para atender solicitud',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
