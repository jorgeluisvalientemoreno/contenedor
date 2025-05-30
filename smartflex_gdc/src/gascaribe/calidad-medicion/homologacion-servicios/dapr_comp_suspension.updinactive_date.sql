declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'DAPR_COMP_SUSPENSION.UPDINACTIVE_DATE';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'DAPR_COMP_SUSPENSION.UPDINACTIVE_DATE',
       'Actualiza fecha final del componente de suspension',
       'ADM_PERSON',
       'PKG_PR_COMP_SUSPENSION.PRCINACTIVASUSPENSION',
       'Actualiza fecha final del componente de suspension',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DAPR_COMP_SUSPENSION.UPDINACTIVE_DATE REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DAPR_COMP_SUSPENSION.UPDINACTIVE_DATE YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
