BEGIN
    MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
     (SELECT
      'OPEN' as ESQUEMA_ORIGEN,
      'OS_DELADDRESS' as SERVICIO_ORIGEN,
      'Borra el registro de una dirección' as DESCRIPCION_ORIGEN,
      'ADM_PERSON' as ESQUEMA_DESTINO,
      'API_DELADDRESS ' as SERVICIO_DESTINO,
      'Borra el registro de una dirección' as DESCRIPCION_DESTINO,
      NULL as OBSERVACION
      FROM DUAL) B
    ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN and A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN and A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO and A.SERVICIO_DESTINO = B.SERVICIO_DESTINO)
    WHEN NOT MATCHED THEN 
    INSERT (
      ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
      DESCRIPCION_DESTINO, OBSERVACION)
    VALUES (
      B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, 
      B.DESCRIPCION_DESTINO, B.OBSERVACION)
    WHEN MATCHED THEN
    UPDATE SET 
      A.DESCRIPCION_ORIGEN = B.DESCRIPCION_ORIGEN,
      A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
      A.OBSERVACION = B.OBSERVACION;

    COMMIT;
END;
/