DECLARE

  nuCantidad number := 0;

BEGIN

  select count(1)
    into nuCantidad
    from parametros p
   where p.codigo = 'TIPO_TRABAJO_CAUSAL_REINCIDENTES_PNO';

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
        ('TIPO_TRABAJO_CAUSAL_REINCIDENTES_PNO',
         'TIPO DE TRABAJO Y CASULES CONFIGURADOS QUE NO PERMITEN REINCIDENCIA EN PNO PARA CATEGORIA RESIDENCIAL OSF-4318',
         NULL,
         '12669;3812,3813,3814,3800|12673;9037',
         NULL,
         10,
         'A',
         'S',
         sysdate,
         NULL);
    
      COMMIT;
      dbms_output.put_line('Se registro el Parametro TIPO_TRABAJO_CAUSAL_REINCIDENTES_PNO');
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al registrar el Parametro TIPO_TRABAJO_CAUSAL_REINCIDENTES_PNO - ' ||
                             SQLERRM);
    END;
  ELSE
    dbms_output.put_line('Ya existe el Parametro TIPO_TRABAJO_CAUSAL_REINCIDENTES_PNO');
  END IF;

END;
/
