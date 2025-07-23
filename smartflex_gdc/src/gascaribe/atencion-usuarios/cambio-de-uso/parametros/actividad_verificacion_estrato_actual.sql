DECLARE

  nuCantidad number := 0;

BEGIN

  select count(1)
    into nuCantidad
    from parametros p
   where p.codigo = 'ACTIVIDAD_VERIFICACION_ESTRATO_ACTUAL';

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
        ('ACTIVIDAD_VERIFICACION_ESTRATO_ACTUAL',
         'ACTIVIDAD PARA CREAR ORDEN DE VERIFICACION ESTRATO ACTUAL OSF-3541',
         100010646,
         NULL,
         NULL,
         2,
         'A',
         'S',
         sysdate,
         NULL);
    
      COMMIT;
      dbms_output.put_line('Se registro el Parametro ACTIVIDAD_VERIFICACION_ESTRATO_ACTUAL');
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al registrar el Parametro ACTIVIDAD_VERIFICACION_ESTRATO_ACTUAL - ' ||
                             SQLERRM);
    END;
  ELSE
    dbms_output.put_line('Ya existe el Parametro ACTIVIDAD_VERIFICACION_ESTRATO_ACTUAL');
  END IF;

END;
/
