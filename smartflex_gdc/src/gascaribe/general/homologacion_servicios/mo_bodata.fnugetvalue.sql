declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'MO_BODATA.FNUGETVALUE';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'MO_BODATA.FNUGETVALUE',
       'Obtiene el valor numerico instanciado del atributo y entidad relacionada a una solicitud',
       'ADM_PERSON',
       'PKG_BOGESTIONSOLICITUDES.FNUOBTVALORNUMERICO',
       'Obtiene el valor numerico instanciado del atributo y entidad relacionada a una solicitud',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO MO_BODATA.FNUGETVALUE REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO MO_BODATA.FNUGETVALUE YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
