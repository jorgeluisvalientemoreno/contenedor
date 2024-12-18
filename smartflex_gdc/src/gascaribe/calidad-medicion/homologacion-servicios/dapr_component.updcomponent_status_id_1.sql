declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'DAPR_COMPONENT.UPDCOMPONENT_STATUS_ID'
     and servicio_destino =
         'PKG_COMPONENTE_PRODUCTO.PRCACTESTADOPR_COMPONENT';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'DAPR_COMPONENT.UPDCOMPONENT_STATUS_ID',
       'Actualiza Estado componente del servicio',
       'ADM_PERSON',
       'PKG_COMPONENTE_PRODUCTO.PRCACTESTADOPR_COMPONENT',
       'Actualiza Estado componente del producto y la ultima fecha de actualizacion',
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
