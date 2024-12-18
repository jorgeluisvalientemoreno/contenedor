declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'OR_BOLEGALIZEACTIVITIES.FNUGETCURRMOTIVE';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'OR_BOLEGALIZEACTIVITIES.FNUGETCURRMOTIVE',
       'Obtiene Motivo de la Orden A Legalizar',
       'ADM_PERSON',
       'PKG_BOGESTION_ORDENES.FNUOBTMOTIVOACTIVIDAD',
       'Obtiene Motivo de la Orden A Legalizar',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO OR_BOLEGALIZEACTIVITIES.FNUGETCURRMOTIVE REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO OR_BOLEGALIZEACTIVITIES.FNUGETCURRMOTIVE YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
