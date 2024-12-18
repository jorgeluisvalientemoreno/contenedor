declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'DAPR_PRODUCT.UPDPRODUCT_STATUS_ID'
     and servicio_destino =
         'PKG_PRODUCTO.PRACTUALIZAESTADOPRODUCTO';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'DAPR_PRODUCT.UPDPRODUCT_STATUS_ID',
       'Actualiza estado producto',
       'PERSONALIZACIONES',
       'PKG_PRODUCTO.PRACTUALIZAESTADOPRODUCTO',
       'Activa producto y servicio suspendido',
       'Utiliza varios servicios para activar producto y/o servicio suspendidos');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DAPR_PRODUCT.UPDPRODUCT_STATUS_ID REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DAPR_PRODUCT.UPDPRODUCT_STATUS_ID YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
