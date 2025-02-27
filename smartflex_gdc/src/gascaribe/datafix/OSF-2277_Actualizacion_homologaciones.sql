MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
 (SELECT
  'OPEN' as ESQUEMA_ORIGEN,
  'OS_LEGALIZEORDERALLACTIVITIES' as SERVICIO_ORIGEN,
  'Legalizar orden de trabajo con todas sus actividades' as DESCRIPCION_ORIGEN,
  'ADM_PERSON' as ESQUEMA_DESTINO,
  'API_LEGALIZEORDERS' as SERVICIO_DESTINO,
  NULL as DESCRIPCION_DESTINO,
  'Usar el tipo de comentario TIPO_COMENTARIO_GENERAL de la entidad PARAMETROS como tipo de comentario por defecto' as OBSERVACION
  FROM DUAL) B
ON (A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
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

COMMIT;
/