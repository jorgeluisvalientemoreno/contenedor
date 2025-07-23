DECLARE

  nuCantidad number := 0;

BEGIN

  select count(1)
    into nuCantidad
    from PROCESO_NEGOCIO pn
   where pn.descripcion = 'REFORMAS';

  IF (nuCantidad = 0) THEN
    BEGIN
      INSERT INTO PROCESO_NEGOCIO
        (codigo, descripcion)
      VALUES
        (23, 'REFORMAS');
    
      COMMIT;
      dbms_output.put_line('Se registro el proceso de negocio REFORMAS');
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al registrar el proceso de negocio REFORMAS - ' ||
                             SQLERRM);
    END;
  ELSE
    dbms_output.put_line('Ya existe el proceso de negocio REFORMAS');
  END IF;

END;
/
