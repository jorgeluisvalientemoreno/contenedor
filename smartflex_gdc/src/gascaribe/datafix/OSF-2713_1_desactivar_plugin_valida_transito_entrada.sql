begin

  BEGIN

    update open.ldc_procedimiento_obj
       set activo = 'N'
     where procedimiento = 'PRCVALIDATRANSITOENTANTEBOD'
       and activo = 'S';
  END;

  COMMIT;
  dbms_output.put_line('Plugin desactivado');
exception
  when others then
    rollback;
    dbms_output.put_line(sqlerrm);
end;
/
