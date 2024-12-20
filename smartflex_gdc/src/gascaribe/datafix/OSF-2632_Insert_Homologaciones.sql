BEGIN
  MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
 (SELECT
  'OPEN' as ESQUEMA_ORIGEN,
  'DAOR_ORDER.UPDRECORD' as SERVICIO_ORIGEN,
  'Actualiza la orden con un record' as DESCRIPCION_ORIGEN,
  'ADM_PERSON' as ESQUEMA_DESTINO,
  'PKG_OR_ORDER.PRCACTUALIZARECORD' as SERVICIO_DESTINO,
  'Actualiza la orden con un record' as DESCRIPCION_DESTINO,
  NULL as OBSERVACION
  FROM DUAL) B
ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN and A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN and A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO)
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
  A.SERVICIO_DESTINO = B.SERVICIO_DESTINO,
  A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
  A.OBSERVACION = B.OBSERVACION;

  MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
 (SELECT
  'OPEN' as ESQUEMA_ORIGEN,
  'DAOR_ORDER_STAT_CHANGE.INSRECORD' as SERVICIO_ORIGEN,
  'Inserta Registro de cambio de estado de la orden' as DESCRIPCION_ORIGEN,
  'ADM_PERSON' as ESQUEMA_DESTINO,
  'PKG_OR_ORDER_STAT_CHANGE.PRCINSOR_ORDER_STAT_CHANGE' as SERVICIO_DESTINO,
  'Inserta Registro de cambio de estado de la orden' as DESCRIPCION_DESTINO,
  NULL as OBSERVACION
  FROM DUAL) B
ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN and A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN and A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO)
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
  A.SERVICIO_DESTINO = B.SERVICIO_DESTINO,
  A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
  A.OBSERVACION = B.OBSERVACION;


  MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
 (SELECT
  'OPEN' as ESQUEMA_ORIGEN,
  'PKTBLSUSCRIPC.UPDSUSCEFCE' as SERVICIO_ORIGEN,
  'Actualiza envio de factura correo del contrato' as DESCRIPCION_ORIGEN,
  'ADM_PERSON' as ESQUEMA_DESTINO,
  'PKG_SUSCRIPC.PRC_UPDENVIOFACTURACORE' as SERVICIO_DESTINO,
  'Actualiza envio de factura correo del contrato' as DESCRIPCION_DESTINO,
  NULL as OBSERVACION
  FROM DUAL) B
ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN and A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN and A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO)
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
  A.SERVICIO_DESTINO = B.SERVICIO_DESTINO,
  A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
  A.OBSERVACION = B.OBSERVACION;

COMMIT;

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
END;
/