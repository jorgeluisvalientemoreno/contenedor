DECLARE

  nuCantidad number := 0;

BEGIN

  select count(1)
    into nuCantidad
    from parametros p
   where p.codigo = 'MERE_ACTUALIZACION_DATOS_PREDIO';

  IF (nuCantidad = 0) THEN
    BEGIN
    
      INSERT INTO parametros
        (codigo,
         descripcion,
         valor_numerico,
         valor_cadena,
         valor_fecha,
         proceso,
         estado,
         obligatorio,
         fecha_creacion,
         fecha_actualizacion)
      VALUES
        ('MERE_ACTUALIZACION_DATOS_PREDIO',
         'MEDIO RECEPCION PARA EL TRAMITE ACTUALIZAR DATOS DEL PREDIO OSF-3541',
         10,
         NULL,
         NULL,
         23,
         'A',
         'S',
         sysdate,
         NULL);
    
      COMMIT;
      dbms_output.put_line('Se registro el Parametro MERE_ACTUALIZACION_DATOS_PREDIO');
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al registrar el Parametro MERE_ACTUALIZACION_DATOS_PREDIO - ' ||
                             SQLERRM);
    END;
  ELSE
    dbms_output.put_line('Ya existe el Parametro MERE_ACTUALIZACION_DATOS_PREDIO');
  END IF;

END;
/
