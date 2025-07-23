DECLARE

  nuCantidad number := 0;

BEGIN

  select count(1)
    into nuCantidad
    from LDC_PROCEDIMIENTO_OBJ p
   where p.task_type_id = 12622
     and p.procedimiento = 'LDC_PRCHANGEPLAN';

  IF (nuCantidad = 0) THEN
    BEGIN
    
      insert into ldc_procedimiento_obj
        (task_type_id,
         causal_id,
         procedimiento,
         descripcion,
         orden_ejec,
         activo)
      values
        (12622,
         NULL,
         'LDC_PRCHANGEPLAN',
         'VALIDA Y REALIZA EL CAMBIO DE PLAN COMERCIAL',
         2,
         'S');
    
      COMMIT;
      dbms_output.put_line('Se registro el PLUGIN LDC_PRCHANGEPLAN al tipo de trabajo 12622');
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al registrar el PLUGIN LDC_PRCHANGEPLAN al tipo de trabajo 12622 - ' ||
                             SQLERRM);
    END;
  ELSE
    dbms_output.put_line('Ya existe el registro del PLUGIN LDC_PRCHANGEPLAN al tipo de trabajo 12622');
  END IF;

END;
/
