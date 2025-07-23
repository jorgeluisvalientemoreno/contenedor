DECLARE

  nuCantidad number := 0;

BEGIN

  select count(1)
    into nuCantidad
    from parametros p
   where p.codigo = 'CONCXTITR_AVANCE_OBRA_CONS';

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
        ('CONCXTITR_AVANCE_OBRA_CONS',
         'CONFIGURACION TIPO TRABAJO X CONCEPTO PARA AVANCE DE OBRAS OSF-4096',
         NULL,
         '12149|30;12162|674;12150|19;10268|30',
         NULL,
         9,
         'A',
         'S',
         sysdate,
         NULL);
    
      COMMIT;
      dbms_output.put_line('Se registro el Parametro CONCXTITR_AVANCE_OBRA_CONS');
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al registrar el Parametro CONCXTITR_AVANCE_OBRA_CONS - ' ||
                             SQLERRM);
    END;
  ELSE
    dbms_output.put_line('Ya existe el Parametro CONCXTITR_AVANCE_OBRA_CONS');
  END IF;

END;
/
