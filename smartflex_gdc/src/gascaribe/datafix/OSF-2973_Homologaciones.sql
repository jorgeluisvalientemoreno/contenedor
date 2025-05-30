BEGIN

    MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
     (SELECT
      'OPEN' as ESQUEMA_ORIGEN,
      'DAOR_EXTERN_SYSTEMS_ID.UPDADDRESS_ID' as SERVICIO_ORIGEN,
      'Actualiza el id de la dirección' as DESCRIPCION_ORIGEN,
      'ADM_PERSON' as ESQUEMA_DESTINO,
      'PKG_OR_EXTERN_SYSTEMS_ID.PRCACTUALIZADIRECCEXTERNA' as SERVICIO_DESTINO,
      'Actualiza el id de la dirección' as DESCRIPCION_DESTINO,
      NULL as OBSERVACION
      FROM DUAL) B
    ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN and A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
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
      A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO,
      A.SERVICIO_DESTINO = B.SERVICIO_DESTINO,
      A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
      A.OBSERVACION = B.OBSERVACION;

    MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
     (SELECT
      'OPEN' as ESQUEMA_ORIGEN,
      'DAOR_ORDER_ACTIVITY.UPDADDRESS_ID' as SERVICIO_ORIGEN,
      'Actualiza el id de la dirección en la actividad' as DESCRIPCION_ORIGEN,
      'ADM_PERSON' as ESQUEMA_DESTINO,
      'PKG_OR_ORDER_ACTIVITY.PRCACTUALIZADIRECCACTIVIDAD' as SERVICIO_DESTINO,
      'Actualiza el id de la dirección en la actividad' as DESCRIPCION_DESTINO,
      NULL as OBSERVACION
      FROM DUAL) B
    ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN and A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
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
      A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO,
      A.SERVICIO_DESTINO = B.SERVICIO_DESTINO,
      A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
      A.OBSERVACION = B.OBSERVACION;


    MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
     (SELECT
      'OPEN' as ESQUEMA_ORIGEN,
      'DAMO_PACKAGES.FDTGETATTENTION_DATE' as SERVICIO_ORIGEN,
      'Consultar fecha de atencion de una solicitud' as DESCRIPCION_ORIGEN,
      'ADM_PERSON' as ESQUEMA_DESTINO,
      'PKG_BCSOLICITUDES.FDTGETFECHAATENCION' as SERVICIO_DESTINO,
      NULL as DESCRIPCION_DESTINO,
      NULL as OBSERVACION
      FROM DUAL) B
    ON (A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO and A.SERVICIO_DESTINO = B.SERVICIO_DESTINO)
    WHEN NOT MATCHED THEN 
    INSERT (
      ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
      DESCRIPCION_DESTINO, OBSERVACION)
    VALUES (
      B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, 
      B.DESCRIPCION_DESTINO, B.OBSERVACION)
    WHEN MATCHED THEN
    UPDATE SET 
      A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN,
      A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN,
      A.DESCRIPCION_ORIGEN = B.DESCRIPCION_ORIGEN,
      A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
      A.OBSERVACION = B.OBSERVACION;

    MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
     (SELECT
      'OPEN' as ESQUEMA_ORIGEN,
      'DAMO_PACKAGES.FDTGETREQUEST_DATE' as SERVICIO_ORIGEN,
      'Consultar fecha de registro de una solicitud' as DESCRIPCION_ORIGEN,
      'ADM_PERSON' as ESQUEMA_DESTINO,
      'PKG_BCSOLICITUDES.FDTGETFECHAREGISTRO' as SERVICIO_DESTINO,
      NULL as DESCRIPCION_DESTINO,
      NULL as OBSERVACION
      FROM DUAL) B
    ON (A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO and A.SERVICIO_DESTINO = B.SERVICIO_DESTINO)
    WHEN NOT MATCHED THEN 
    INSERT (
      ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
      DESCRIPCION_DESTINO, OBSERVACION)
    VALUES (
      B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, 
      B.DESCRIPCION_DESTINO, B.OBSERVACION)
    WHEN MATCHED THEN
    UPDATE SET 
      A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN,
      A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN,
      A.DESCRIPCION_ORIGEN = B.DESCRIPCION_ORIGEN,
      A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
      A.OBSERVACION = B.OBSERVACION;


    DELETE PERSONALIZACIONES.HOMOLOGACION_SERVICIOS
    WHERE 
    ESQUEMA_ORIGEN = 'OPEN'
    AND SERVICIO_ORIGEN IN ( 'DAMO_PACKAGES.FNUPRODUCT_ID', 'DAMO_PACKAGES.FNUSUBSCRIPTION_ID' );
    
    COMMIT;

END;
/