DECLARE

  nuTab1 number := 0;

BEGIN
  select count(1)
    into nuTab1
    from ldc_procedimiento_obj a
   where a.procedimiento = 'PRCVALIDATRANSITOENTANTEBOD';

  IF (nuTab1 = 0) THEN
  
    dbms_output.put_line('Insertar el PLUGIN PRCVALIDATRANSITOENTANTEBOD');
    INSERT INTO ldc_procedimiento_obj
      (task_type_id,
       causal_id,
       procedimiento,
       descripcion,
       orden_ejec,
       activo)
    VALUES
      (-1,
       null,
       'PRCVALIDATRANSITOENTANTEBOD',
       'VALIDA TRANSITO ENTRANTE DE ITEMS EN BODEGAS',
       1,
       'S');
    commit;
  
  ELSE
  
    dbms_output.put_line('Ya existe el PLUGIN PRCVALIDATRANSITOENTANTEBOD');
  
  END IF;
  -----------------------------------------------------------------------------------------------------

END;
/
