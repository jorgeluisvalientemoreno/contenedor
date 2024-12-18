declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'PKTBLINCLCOCO.UPCANCELDATE';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'PKTBLINCLCOCO.UPCANCELDATE',
       'Actualiza Fecha de cancelacion de la inclusion para corte o conexion',
       'ADM_PERSON',
       'PKG_INCLUSION_CARTERA.PRCCANCELAINCLUCION',
       'Actualiza Fecha de cancelacion de la inclusion para corte o conexion',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO INCLCOCO.INCCFECA REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO INCLCOCO.INCCFECA YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
