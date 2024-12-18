declare

  contador Number;

begin

  select count(1)
    into contador
    from personalizaciones.homologacion_servicios
   where servicio_origen = 'DAPR_PROD_SUSPENSION.UPDACTIVE';

  if contador = 0 then
    insert into homologacion_servicios
    values
      ('OPEN',
       'DAPR_PROD_SUSPENSION.UPDACTIVE',
       'Actualiza si la suspension esta o no activa YES[Y], NO[N]',
       'ADM_PERSON',
       'PKG_PR_PROD_SUSPENSION.PRCINACTIVASUSPENSION',
       'Inactiva la Suspension del producto en N con una fecha final de suspension',
       '');
    commit;
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DAPR_PROD_SUSPENSION.UPDACTIVE REGISTRADO OK.');
  else
    dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DAPR_PROD_SUSPENSION.UPDACTIVE YA EXISTE.');
  end if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
