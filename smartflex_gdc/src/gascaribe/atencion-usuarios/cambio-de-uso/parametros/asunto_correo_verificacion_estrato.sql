DECLARE

  nuCantidad number := 0;

BEGIN

  select count(1)
    into nuCantidad
    from parametros p
   where p.codigo = 'ASUNTO_CORREO_VERIFICACION_ESTRATO';

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
        ('ASUNTO_CORREO_VERIFICACION_ESTRATO',
         'TITULO PARA CORREO DE VERIFICACION ESTRATO OSF-3541',
         NULL,
         'Verificación estrato residencial, cambio de categoría, contrato CONTRATOCU',
         NULL,
         2,
         'A',
         'S',
         sysdate,
         NULL);
    
      COMMIT;
      dbms_output.put_line('Se registro el Parametro ASUNTO_CORREO_VERIFICACION_ESTRATO');
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al registrar el Parametro ASUNTO_CORREO_VERIFICACION_ESTRATO - ' ||
                             SQLERRM);
    END;
  ELSE
    dbms_output.put_line('Ya existe el Parametro ASUNTO_CORREO_VERIFICACION_ESTRATO');
  END IF;

END;
/
