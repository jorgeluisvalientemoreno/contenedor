DECLARE

  nuCantidad number := 0;

BEGIN

  select count(1)
    into nuCantidad
    from parametros p
   where p.codigo = 'ESTADO_CORTE_NO_ACTU_EN_ACTIVA_PROD';

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
        ('ESTADO_CORTE_NO_ACTU_EN_ACTIVA_PROD',
         'ESTADOS DE CORTES QUE NO ACTUALIZAN EN LA ACTIVACION DEL PRODUCTO SEPARADOR (,) OSF-4489',
         NULL,
         '5',
         NULL,
         3,
         'A',
         'S',
         sysdate,
         NULL);
    
      COMMIT;
      dbms_output.put_line('Se registro el Parametro ESTADO_CORTE_NO_ACTU_EN_ACTIVA_PROD');
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al registrar el Parametro ESTADO_CORTE_NO_ACTU_EN_ACTIVA_PROD - ' ||
                             SQLERRM);
    END;
  ELSE
    dbms_output.put_line('Ya existe el Parametro ESTADO_CORTE_NO_ACTU_EN_ACTIVA_PROD');
  END IF;

END;
/
