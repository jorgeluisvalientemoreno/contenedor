declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'MO_BOBILLINGDATACHANGE.GETSUBCATEGORYSBYPACK';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'MO_BOBILLINGDATACHANGE.GETSUBCATEGORYSBYPACK',
       'Servicio para obtener Subcategoria actual y nueva Subcategoria de una solicitud',
       'ADM_PERSON',
       'PKG_BOGESTIONSOLICITUDES.PRCOBTSUBCATEGORIAPORSOLICITUD',
       'Servicio para reemplazar el llamado del metodo MO_BOBILLINGDATACHANGE.GETSUBCATEGORYSBYPACK',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO MO_BOBILLINGDATACHANGE.GETSUBCATEGORYSBYPACK REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO MO_BOBILLINGDATACHANGE.GETSUBCATEGORYSBYPACK YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
