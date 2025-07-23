declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'CT_BOEXCLUSIONFUNCTIONS.EXCLUDEORDERFORDAYS';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'CT_BOEXCLUSIONFUNCTIONS.EXCLUDEORDERFORDAYS',
       'Excluye de acta la orden instanciada durante N dias',
       'ADM_PERSON',
       'PRCEXCLUIRORDENPORDIAS',
       'Excluye de acta la orden instanciada durante N dias',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO CT_BOEXCLUSIONFUNCTIONS.EXCLUDEORDERFORDAYS REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO CT_BOEXCLUSIONFUNCTIONS.EXCLUDEORDERFORDAYS YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
