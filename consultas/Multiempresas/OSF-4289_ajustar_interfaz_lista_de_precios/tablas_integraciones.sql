--tablas_integraciones

SELECT *
FROM   OPEN.LDCI_OPERACION; --Aqui se consulta la operación almacenada y que se ejecuta con el job
 
SELECT * 
FROM   OPEN.LDCI_INBOX 
WHERE  FECHA_REGISTRO >= TO_DATE('25/07/2025','DD/MM/YYYY'); --(CODIGO 13813199,13813198,13813197) (PROCESO_EXTERNO 69,68,67) --esta es la primera tabla a la cual llega la transacción desde sap pi

 
SELECT * 
FROM   OPEN.LDCI_INBOXDET 
WHERE  INBOX_ID IN (13813198, 13813199); --(CODIGO 9226326,9226327,9226325) --segunda tabla
 
SELECT *
FROM   OPEN.LDCI_OUTBOXDET
WHERE  INBOXDET_ID IN (9226326, 9226327); --(CODIGO 9226327,9226328) --tercera tabla 
 
SELECT *
FROM   OPEN.LDCI_OUTBOXDETVAL
WHERE  OUTBOXDET_ID IN (9226326, 9226327); --log de tercera tabla 
 
SELECT *
FROM   OPEN.LDCI_OUTBOXDET
WHERE  FECHA_REGISTRO >= TO_DATE('21/07/2025','DD/MM/YYYY'); --validando todos los registros de la tercera tabla 
