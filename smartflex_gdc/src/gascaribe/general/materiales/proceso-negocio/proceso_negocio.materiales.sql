DECLARE

  nuCantidad number := 0;

BEGIN

  select count(1)
    into nuCantidad
    from PROCESO_NEGOCIO pn
   where pn.descripcion = 'MATERIALES';

  IF (nuCantidad = 0) THEN
    BEGIN
      INSERT INTO PROCESO_NEGOCIO
        (codigo, descripcion)
      VALUES
        (22, 'MATERIALES');
    
      COMMIT;
      dbms_output.put_line('Se registro el proceso de negocio MATERIALES');
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al registrar el proceso de negocio MATERIALES - ' ||
                             SQLERRM);
    END;
  ELSE
    dbms_output.put_line('Ya existe el proceso de negocio MATERIALES');
  END IF;

END;
/
