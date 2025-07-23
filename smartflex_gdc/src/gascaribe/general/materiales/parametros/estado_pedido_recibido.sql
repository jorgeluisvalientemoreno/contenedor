DECLARE

  nuCantidad number := 0;

BEGIN

  select count(1)
    into nuCantidad
    from parametros p
   where p.codigo = 'ESTADO_PEDIDO_RECIBIDO';

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
        ('ESTADO_PEDIDO_RECIBIDO',
         'CODIGO ESTADO RECIBIDO PARA SOLICITUD DE MATERIALES OSF-4057',
         3,
         NULL,
         NULL,
         22,
         'A',
         'S',
         sysdate,
         NULL);
    
      COMMIT;
      dbms_output.put_line('Se registro el Parametro ESTADO_PEDIDO_RECIBIDO');
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al registrar el Parametro ESTADO_PEDIDO_RECIBIDO - ' ||
                             SQLERRM);
    END;
  ELSE
    dbms_output.put_line('Ya existe el Parametro ESTADO_PEDIDO_RECIBIDO');
  END IF;

END;
/
