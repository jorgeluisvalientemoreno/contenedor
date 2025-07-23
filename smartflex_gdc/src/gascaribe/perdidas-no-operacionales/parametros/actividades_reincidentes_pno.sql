DECLARE

  nuCantidad number := 0;

BEGIN

  select count(1)
    into nuCantidad
    from parametros p
   where p.codigo = 'ACTIVIDADES_REINCIDENTES_PNO';

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
        ('ACTIVIDADES_REINCIDENTES_PNO',
         'ACTIVIADES REINCIDENTES EN EL PROCESO DE PNO OSF-4318',
         NULL,
         '4000957',
         NULL,
         10,
         'A',
         'S',
         sysdate,
         NULL);
    
      COMMIT;
      dbms_output.put_line('Se registro el Parametro ACTIVIDADES_REINCIDENTES_PNO');
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al registrar el Parametro ACTIVIDADES_REINCIDENTES_PNO - ' ||
                             SQLERRM);
    END;
  ELSE
    dbms_output.put_line('Ya existe el Parametro ACTIVIDADES_REINCIDENTES_PNO');
  END IF;

END;
/
