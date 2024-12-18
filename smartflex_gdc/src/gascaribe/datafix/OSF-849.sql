
declare

  -- Poblacion a la que aplica el Datafix
  CURSOR cuPoblacion IS
  select  * 
  from    open.LDC_PROCEDIMIENTO_OBJ
  where   procedimiento = 'LDC_PRREVCONSCRIT';

begin
  dbms_output.put_line('---- Inicio OSF-849 ----');

  FOR reg in cuPoblacion
  LOOP
    UPDATE  OPEN.LDC_PROCEDIMIENTO_OBJ
    SET     ACTIVO = 'N'
    WHERE   TASK_TYPE_ID  = reg.TASK_TYPE_ID
    AND     CAUSAL_ID     = reg.CAUSAL_ID
    AND     PROCEDIMIENTO = reg.PROCEDIMIENTO;
    dbms_output.put_line('Se actualiza el estado del pluguin del tipo de trabajo ['
                          ||reg.TASK_TYPE_ID||'] asociado a la causal ['
                          ||reg.CAUSAL_ID||'] - procedimiento ['
                          ||reg.PROCEDIMIENTO||']');
  END LOOP;

  COMMIT;

  dbms_output.put_line('---- Fin OSF-849 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-849 ----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

