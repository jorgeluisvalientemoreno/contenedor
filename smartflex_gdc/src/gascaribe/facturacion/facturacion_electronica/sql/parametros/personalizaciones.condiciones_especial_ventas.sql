MERGE INTO PERSONALIZACIONES.PARAMETROS A USING
 (SELECT
  'CONDICIONES_ESPECIAL_VENTAS' as CODIGO,
  'Condiciones especial venta ( concepto;causal;programa) - facturacion electronica' as DESCRIPCION,
  null as VALOR_NUMERICO,
  '153;53;700|154;53;700|155;53;700|156;53;700|157;53;700|220;53;700|284;53;700|285;53;700|286;53;700|332;53;700|875;53;700|864;53;700|871;53;700|153;53;2016|154;53;2016|155;53;2016|156;53;2016|157;53;2016|220;53;2016|284;53;2016|285;53;2016|286;53;2016|332;53;2016|875;53;2016|864;53;2016|871;53;2016'  as VALOR_CADENA,
  NULL as VALOR_FECHA,
  18 as PROCESO,
  SYSDATE as FECHA_CREACION,
  NULL as FECHA_ACTUALIZACION,
  USER as USUARIO,
  USERENV('TERMINAL') as TERMINAL
  FROM DUAL) B
ON (A.CODIGO = B.CODIGO)
WHEN NOT MATCHED THEN 
INSERT (
  CODIGO, DESCRIPCION, VALOR_NUMERICO, VALOR_CADENA, VALOR_FECHA, 
  PROCESO, FECHA_CREACION, FECHA_ACTUALIZACION, USUARIO, TERMINAL)
VALUES (
  B.CODIGO, B.DESCRIPCION, B.VALOR_NUMERICO, B.VALOR_CADENA, B.VALOR_FECHA, 
  B.PROCESO, B.FECHA_CREACION, B.FECHA_ACTUALIZACION, B.USUARIO, B.TERMINAL)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCRIPCION = B.DESCRIPCION,
  A.VALOR_NUMERICO = B.VALOR_NUMERICO,
  A.VALOR_CADENA = B.VALOR_CADENA,
  A.VALOR_FECHA = B.VALOR_FECHA,
  A.PROCESO = B.PROCESO,
  A.FECHA_CREACION = B.FECHA_CREACION,
  A.FECHA_ACTUALIZACION = B.FECHA_ACTUALIZACION,
  A.USUARIO = B.USUARIO,
  A.TERMINAL = B.TERMINAL;
COMMIT
/