declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'PKSERVSUSC.UPDSESUINCL';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'PKSERVSUSC.UPDSESUINCL',
       'Actualiza INCLUSIONES DE CONEXION-DESCONEXION-RETRO',
       'ADM_PERSON',
       'PKG_PRODUCTO.PRCACTUALIZAINCLUSION',
       'actualiza inclucion del servicio del producto',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO PKSERVSUSC.UPDSESUINCL REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO PKSERVSUSC.UPDSESUINCL YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
