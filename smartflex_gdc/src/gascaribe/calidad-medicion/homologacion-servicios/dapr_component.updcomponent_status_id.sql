declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'DAPR_COMPONENT.UPDCOMPONENT_STATUS_ID'
     and servicio_destino =
         'PKG_COMPONENTE_PRODUCTO.PRACTUALIZAESTADOCOMPONENTE';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'DAPR_COMPONENT.UPDCOMPONENT_STATUS_ID',
       'Actualizar estado componente',
       'ADM_PERSON',
       'PKG_COMPONENTE_PRODUCTO.PRACTUALIZAESTADOCOMPONENTE',
       'Actualizar estado componente y Fecha Ultima Modificacion de Producto y Servicio',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DAPR_COMPONENT.UPDCOMPONENT_STATUS_ID REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DAPR_COMPONENT.UPDCOMPONENT_STATUS_ID YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
