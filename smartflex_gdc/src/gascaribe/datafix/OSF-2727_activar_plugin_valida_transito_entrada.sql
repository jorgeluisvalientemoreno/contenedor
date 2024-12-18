begin

  BEGIN

    update open.ldc_procedimiento_obj
       set activo = 'S'
     where procedimiento = 'PRCVALIDATRANSITOENTANTEBOD'
       and activo = 'N';
  END;

  COMMIT;
  dbms_output.put_line('Plugin Activado');
exception
  when others then
    rollback;
    dbms_output.put_line(sqlerrm);
end;
/
