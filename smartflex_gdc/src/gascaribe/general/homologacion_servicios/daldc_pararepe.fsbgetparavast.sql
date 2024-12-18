declare

  contador Number;

begin

  select count(1)
    into contador
    from ADM_PERSON.homologacion_servicios
   where servicio_origen = 'DALDC_PARAREPE.FSBGETPARAVAST';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'DALDC_PARAREPE.FSBGETPARAVAST',
       'Retorna cadena relacionado al proceso de Revision Periodica',
       'ADM_PERSON',
       'PKG_BCLDC_PARAREPE.FSBOBTIENEVALORCADENA',
       'Retorna cadena relacionado al proceso de Revision Periodica',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DALDC_PARAREPE.FSBGETPARAVAST REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DALDC_PARAREPE.FSBGETPARAVAST YA EXISTE.');
  end if;
exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
