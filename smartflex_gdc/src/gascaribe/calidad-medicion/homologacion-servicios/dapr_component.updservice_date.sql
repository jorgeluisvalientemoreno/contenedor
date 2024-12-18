declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'DAPR_COMPONENT.UPDSERVICE_DATE';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'DAPR_COMPONENT.UPDSERVICE_DATE',
       'Actualiza Fecha En La Cual Se Da Inicio Al Servicio',
       'ADM_PERSON',
       'PKG_COMPONENTE_PRODUCTO.PRACTUALIZAFECHAINSTALACION',
       'Actualiza Fecha De Inicio Al Servicio, Fecha Ultima Modificacion, Fecha Mediador De Servicio y Fecha de instalacion del servicio',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DAPR_COMPONENT.UPDSERVICE_DATE REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DAPR_COMPONENT.UPDSERVICE_DATE YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
