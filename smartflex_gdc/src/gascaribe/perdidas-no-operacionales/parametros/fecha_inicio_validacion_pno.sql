DECLARE

  nuCantidad number := 0;

BEGIN

  select count(1)
    into nuCantidad
    from parametros p
   where p.codigo = 'FECHA_INICIO_VALIDACION_PNO';

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
        ('FECHA_INICIO_VALIDACION_PNO',
         'FECHA INICIO VALIDACION DE ORDENES CREADAS POR PNO PARA CATEGORIA RESIDENCIAL OSF-4318',
         NULL,
         NULL,
         TO_DATE('01/01/2023'),
         10,
         'A',
         'S',
         sysdate,
         NULL);
    
      COMMIT;
      dbms_output.put_line('Se registro el Parametro FECHA_INICIO_VALIDACION_PNO');
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al registrar el Parametro FECHA_INICIO_VALIDACION_PNO - ' ||
                             SQLERRM);
    END;
  ELSE
    dbms_output.put_line('Ya existe el Parametro FECHA_INICIO_VALIDACION_PNO');
  END IF;

END;
/
