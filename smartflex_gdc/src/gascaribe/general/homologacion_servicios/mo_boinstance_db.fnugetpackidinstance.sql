BEGIN
    MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS a
    USING (SELECT 'OPEN'                                                       ESQUEMA_ORIGEN,
                  UPPER('mo_boinstance_db.fnuGetPackIDInstance')               SERVICIO_ORIGEN,
                  'Función para obtener el id de la instancia de la solicitud' DESCRIPCION_ORIGEN,
                  'ADM_PERSON'                                          ESQUEMA_DESTINO,
                  UPPER('pkg_boinstancia.fnuObtenerIdSolInstancia')            SERVICIO_DESTINO,
                  'Función para obtener el id de la instancia de la solicitud' DESCRIPCION_DESTINO,
                  NULL                                                         OBSERVACION
           FROM DUAL) b
    ON (a.ESQUEMA_ORIGEN = b.ESQUEMA_ORIGEN
        AND a.SERVICIO_ORIGEN = b.SERVICIO_ORIGEN
        AND a.ESQUEMA_DESTINO = b.ESQUEMA_DESTINO)
    WHEN NOT MATCHED THEN
        INSERT (ESQUEMA_ORIGEN,
                SERVICIO_ORIGEN,
                DESCRIPCION_ORIGEN,
                ESQUEMA_DESTINO,
                SERVICIO_DESTINO,
                DESCRIPCION_DESTINO,
                OBSERVACION)
        VALUES (b.ESQUEMA_ORIGEN,
                b.SERVICIO_ORIGEN,
                b.DESCRIPCION_ORIGEN,
                b.ESQUEMA_DESTINO,
                b.SERVICIO_DESTINO,
                b.DESCRIPCION_DESTINO,
                b.OBSERVACION)
    WHEN MATCHED THEN
        UPDATE
        SET a.DESCRIPCION_ORIGEN  = b.DESCRIPCION_ORIGEN,
            a.SERVICIO_DESTINO    = b.SERVICIO_DESTINO,
            a.DESCRIPCION_DESTINO = b.DESCRIPCION_DESTINO,
            a.OBSERVACION         = b.OBSERVACION;
END;
/
PROMPT "Homologación de fnuGetPackIDInstance registrada"
