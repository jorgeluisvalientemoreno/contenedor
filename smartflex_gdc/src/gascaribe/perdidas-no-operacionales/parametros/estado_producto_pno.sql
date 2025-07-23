DECLARE

  nuCantidad number := 0;

BEGIN

  select count(1)
    into nuCantidad
    from parametros p
   where p.codigo = 'ESTADO_PRODUCTO_PNO';

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
        ('ESTADO_PRODUCTO_PNO',
         'ESTADO DE PRODUCTO PARA INSTACIAR EN PNO OSF-4318',
         NULL,
         '1,2,15',
         NULL,
         10,
         'A',
         'S',
         sysdate,
         NULL);
    
      COMMIT;
      dbms_output.put_line('Se registro el Parametro ESTADO_PRODUCTO_PNO');
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al registrar el Parametro ESTADO_PRODUCTO_PNO - ' ||
                             SQLERRM);
    END;
  ELSE
    dbms_output.put_line('Ya existe el Parametro ESTADO_PRODUCTO_PNO');
  END IF;

END;
/
