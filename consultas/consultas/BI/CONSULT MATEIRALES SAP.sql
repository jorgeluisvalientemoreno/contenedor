select  FORMAT(  bldat, 'MM-yy') MES, SHKZG, sum(PSWBT), sum(DMBTR) --distinct KOART, SHKZG -
from sap.BSEG
where HKONT in ( '1518900200','1518900300')
 and bldat <=CONVERT(DATETIME, '2023-01-01', 102)
 and bldat>=CONVERT(DATETIME, '2022-01-01', 102)
 and BUKRS='GDCA'
 and blart='WA'
 GROUP BY FORMAT(  bldat, 'MM-yy') , SHKZG
 ;

 select top 10 *
 from Contabilidad.FactArrastreSaldos

 where cuenta in ( '1518900200','1518900300')
 and fecha>=CONVERT(DATETIME, '2022-12-01', 102);


 select top 10 *
 from contabilidad.FactBalanceContable
  where cuenta in ( '1518900200','1518900300')
  and fecha>=CONVERT(DATETIME, '2023-01-01', 102);

  select top 10 *
  from Redes.FactContabilidadSAP;


  select * --FORMAT(  FechaContabilizacion, 'yyyy') AÑO, SUM (VALOR) --TEXTO, SUM (VALOR) --FORMAT(  FechaContabilizacion, 'MM-yy') MES, SUM (VALOR)
  from SAP.FactMovimientoCuenta
  where CuentaContable in ( '1518900200','1518900300') 
  AND ClaseDocumento='WI'
 AND FechaContabilizacion>=CONVERT(DATETIME, '2018-01-01', 102)
  AND FechaContabilizacion<CONVERT(DATETIME, '2019-01-01', 102)
  --and texto=''
 -- GROUP BY FORMAT(  FechaContabilizacion, 'yyyy') 


   select FORMAT(  FechaContabilizacion, 'yyyy') AÑO, SUM (VALOR) --TEXTO, SUM (VALOR) --FORMAT(  FechaContabilizacion, 'MM-yy') MES, SUM (VALOR)
  from SAP.FactMovimientoCuenta
  where CuentaContable in ( '1518900200','1518900300') 
  AND ClaseDocumento='WI'
 AND FechaContabilizacion>=CONVERT(DATETIME, '2019-08-22', 102)
  AND FechaContabilizacion<CONVERT(DATETIME, '2023-01-01', 102)
  GROUP BY FORMAT(  FechaContabilizacion, 'yyyy') 
 