declare

  contador Number;

begin

  select count(1)
    into contador
    from ADM_PERSON.homologacion_servicios
   where servicio_origen = 'DALDC_PARAREPE.FNUGETPAREVANU';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'DALDC_PARAREPE.FNUGETPAREVANU',
       'Retorna valor numerico relacionado al proceso de Revision Periodica',
       'ADM_PERSON',
       'PKG_BCLDC_PARAREPE.FNUOBTIENEVALORNUMERICO',
       'Retorna valor numerico relacionado al proceso de Revision Periodica',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DALDC_PARAREPE.FNUGETPAREVANU REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DALDC_PARAREPE.FNUGETPAREVANU YA EXISTE.');
  end if;
exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
