declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'DAAB_SEGMENTS.FNUGETCATEGORY_';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'DAAB_SEGMENTS.FNUGETCATEGORY_',
       'Obtiene la categoria configurada en un segmento',
       'ADM_PERSON',
       'PKG_BCDIRECCIONES.FNUOBTCATEGORIASEGMENTO',
       'Obtiene la categoria configurada en un segmento',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DAAB_SEGMENTS.FNUGETCATEGORY_ REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DAAB_SEGMENTS.FNUGETCATEGORY_ YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
