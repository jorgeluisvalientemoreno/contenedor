DECLARE

  nuCantidad number := 0;

BEGIN

  select count(1)
    into nuCantidad
    from parametros p
   where p.codigo = 'TIPO_TRABAJO_PLIEGO_DE_CARGOS_PNO';

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
        ('TIPO_TRABAJO_PLIEGO_DE_CARGOS_PNO',
         'TIPO DE TRABAJO PLIEGO DE CARGOS OSF-4318',
         10128,
         NULL,
         NULL,
         10,
         'A',
         'S',
         sysdate,
         NULL);
    
      COMMIT;
      dbms_output.put_line('Se registro el Parametro TIPO_TRABAJO_PLIEGO_DE_CARGOS_PNO');
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al registrar el Parametro TIPO_TRABAJO_PLIEGO_DE_CARGOS_PNO - ' ||
                             SQLERRM);
    END;
  ELSE
    dbms_output.put_line('Ya existe el Parametro TIPO_TRABAJO_PLIEGO_DE_CARGOS_PNO');
  END IF;

END;
/
