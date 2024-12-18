declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'MO_BOBILLINGDATACHANGE.GETCATEGORYSBYPACK';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'MO_BOBILLINGDATACHANGE.GETCATEGORYSBYPACK',
       'Servicio para obtener categoria actual y nueva categoria de una solicitud',
       'ADM_PERSON',
       'PKG_BOGESTIONSOLICITUDES.PRCOBTCATEGORIASPORSOLICITUD',
       'Servicio para reemplazar el llamado del metodo MO_BOBILLINGDATACHANGE.GETCATEGORYSBYPACK',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO MO_BOBILLINGDATACHANGE.GETCATEGORYSBYPACK REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO MO_BOBILLINGDATACHANGE.GETCATEGORYSBYPACK YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
