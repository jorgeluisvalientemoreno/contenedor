SET DEFINE OFF;
MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
 (SELECT
  'OPEN' as ESQUEMA_ORIGEN,
  'OR_BOCONSTANTS.CNUORDER_STAT_CLOSED' as SERVICIO_ORIGEN,
  'Constante para estado de orden cerrada' as DESCRIPCION_ORIGEN,
  'PERSONALIZACIONES' as ESQUEMA_DESTINO,
  'PKG_GESTIONORDENES.CNUORDENCERRADA' as SERVICIO_DESTINO,
  'Constante para estado de orden cerrada' as DESCRIPCION_DESTINO,
  NULL as OBSERVACION
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
  A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN,
  A.DESCRIPCION_ORIGEN = B.DESCRIPCION_ORIGEN,
  A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO,
  A.SERVICIO_DESTINO = B.SERVICIO_DESTINO,
  A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
  A.OBSERVACION = B.OBSERVACION;

COMMIT;
