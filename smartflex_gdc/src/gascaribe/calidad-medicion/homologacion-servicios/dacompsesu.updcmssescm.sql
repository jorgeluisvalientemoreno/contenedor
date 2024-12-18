declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'DACOMPSESU.UPDCMSSESCM';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'DACOMPSESU.UPDCMSSESCM',
       'Actualiza Estado componente del servicio',
       'ADM_PERSON',
       'PKG_COMPONENTE_PRODUCTO.PRACTUALIZAESTADOCOMPONENTE',
       'Actualizar estado componente y Fecha Ultima Modificacion de Producto y Servicio',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DACOMPSESU.UPDCMSSESCM REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DACOMPSESU.UPDCMSSESCM YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
