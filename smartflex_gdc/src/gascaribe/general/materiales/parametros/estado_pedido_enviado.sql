DECLARE

  nuCantidad number := 0;

BEGIN

  select count(1)
    into nuCantidad
    from parametros p
   where p.codigo = 'ESTADO_PEDIDO_ENVIADO';

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
        ('ESTADO_PEDIDO_ENVIADO',
         'CODIGO ESTADO ENVIADO PARA SOLICITUD DE MATERIALES OSF-4057',
         2,
         NULL,
         NULL,
         22,
         'A',
         'S',
         sysdate,
         NULL);
    
      COMMIT;
      dbms_output.put_line('Se registro el Parametro ESTADO_PEDIDO_ENVIADO');
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error al registrar el Parametro ESTADO_PEDIDO_ENVIADO - ' ||
                             SQLERRM);
    END;
  ELSE
    dbms_output.put_line('Ya existe el Parametro ESTADO_PEDIDO_ENVIADO');
  END IF;

END;
/
