DECLARE

  nuCantidad number := 0;

BEGIN

  select count(1)
    into nuCantidad
    from parametros p
   where p.codigo = 'CORREO_VERIFICACION_ESTRATO';

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
        ('CORREO_VERIFICACION_ESTRATO',
         'CORREO DESTINO PARA NOTIFICAR VERIFICACION ESTRATO (Formato --> Depa1;correo1,correo2,correoN....|Depa2;correo1,correo2,correoN....|Depa3;correo1,correo2,correoN) OSF-3541',
         NULL,
         '2;auxadmvd2@gascaribe.com|3;cbrochero@gascaribe.com|4;bandrade@gascaribe.com',
         NULL,
         2,
         'A',
         'S',
         sysdate,
         NULL);
    
      COMMIT;
      dbms_output.put_line('Se registro el Parametro CORREO_VERIFICACION_ESTRATO');
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al registrar el Parametro CORREO_VERIFICACION_ESTRATO - ' ||
                             SQLERRM);
    END;
  ELSE
    dbms_output.put_line('Ya existe el Parametro CORREO_VERIFICACION_ESTRATO');
  END IF;

END;
/
