-- SALDO INICIAL
SELECT CARTERA, SERVICIO, (SELECT SERVDESC FROM OPEN.SERVICIO S WHERE S.SERVCODI = SERVICIO) DESC_SERVICO,
       conccodi concepto, concdesc desc_concepto,
       concclco clasificador, (select t.clcodesc concdesc from open.ic_clascont t where t.clcocodi = concclco) desc_clasificador,
       movimiento, VALOR, TIPO
  FROM 
(
--
SELECT 'CORRIENTE' CARTERA, SERVICIO, movimiento, conccodi, concdesc, concclco, VALOR, TIPO 
FROM (
SELECT  SERVICIO, '01_Saldo Inicial' Movimiento, conccodi, concdesc, concclco, sum(VALOR) VALOR, '1_Sdo_Inicial' TIPO
FROM (
      SELECT caccserv SERVICIO, o.conccodi, concdesc, o.concclco, nvl(sum(decode(caccnaca,'N',caccsape)),0) VALOR
        FROM OPEN.ic_cartcoco c, open.concepto o
       WHERE caccfege = '31/12/2016'
         and c.caccconc = o.conccodi
       GROUP BY caccserv, o.conccodi, o.concclco, concdesc
     )
 WHERE valor <> 0
GROUP BY  SERVICIO, conccodi, concclco, concdesc
--
UNION ALL
-- SALDO FINAL
SELECT SERVICIO, '10_Saldo Final' Movimiento, conccodi, concdesc, concclco, sum(VALOR) VALOR, '3_Sdo_Final' TIPO
FROM (
      SELECT caccserv SERVICIO, o.conccodi, concdesc, o.concclco, NVL((sum(decode(caccnaca,'N',caccsape))* -1),0) VALOR, 'SF' TIPO
        FROM OPEN.ic_cartcoco, open.concepto o
       WHERE caccfege = '31/01/2017'
         and caccconc = conccodi
       GROUP BY caccserv, o.conccodi, o.concclco, concdesc
       )
 WHERE valor <> 0
 GROUP BY SERVICIO, conccodi, concclco, concdesc
 --
UNION ALL
/*Consulta Hechos*/
SELECT SERVICIO, movimiento, conccodi, concdesc, concclco, sum(VALOR) VALOR, '2_Mvto_Mes' TIPO
FROM (
      SELECT PRODUCTO SERVICIO, conccodi, concdesc, concclco, movimiento, 
             SUM(DECODE(TIPOMOVI,1,VALOR,16,VALOR,25,VALOR,56,VALOR,-VALOR)) VALOR
        FROM ( /*Facturaci¢n por Concepto*/
              SELECT moviserv PRODUCTO, o.conccodi, concdesc, o.concclco, movitimo TIPOMOVI, '02_Fracion x Concepto' Movimiento, 
                     sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
                FROM open.ic_movimien, open.concepto o
               WHERE movitido = 71
                 and movifeco >= '01-01-2017'
                 and movifeco <= '31-01-2017'  
                 AND movitihe = 'F'
                 AND movitimo = 1
                 AND moviconc = conccodi
               GROUP BY moviserv, movitimo, o.conccodi, o.concclco, concdesc 
          UNION
              /*Aplicaci¢n de Saldo a Favor en Facturaci¢n*/
              SELECT moviserv PRODUCTO, o.conccodi, concdesc, o.concclco, movitimo TIPOMOVI, '03_Aplica_SA_Fracion' Movimiento, 
                     sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
                FROM open.ic_movimien, open.concepto o
               WHERE movitido = 71
                 and movifeco >= '01-01-2017'
                 and movifeco <= '31-01-2017' 
                 AND movitihe is null
                 AND movitimo = 11
                 AND moviconc = conccodi
               GROUP BY moviserv, movitimo, o.conccodi, o.concclco, concdesc
          UNION
              /*Aplicaci¢n saldo a Favor por Notas*/
              SELECT moviserv PRODUCTO, o.conccodi, concdesc, o.concclco, movitimo TIPOMOVI, '06_Aplica_SA_Notas' Movimiento, 
                     sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
                FROM open.ic_movimien, open.concepto o
               WHERE movitido = 73
                 and movifeco >= '01-01-2017'
                 and movifeco <= '31-01-2017' 
                 AND movitihe is null
                 AND movitimo = 40
                 AND moviconc = conccodi
               GROUP BY moviserv, movitimo, o.conccodi, o.concclco , concdesc
          UNION
              /*Saldo a favor por Facturaci¢n*/
              SELECT moviserv PRODUCTO, o.conccodi, concdesc, o.concclco, movitimo TIPOMOVI, '04_SA_Fracion' Movimiento,  
                     sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
                FROM open.ic_movimien, open.concepto o
               WHERE movitido = 71
                 and movifeco >= '01-01-2017'
                 and movifeco <= '31-01-2017' 
                 AND movitihe is null  
                 AND movitimo = 44
                 AND moviconc = conccodi
               GROUP BY moviserv, movitimo, o.conccodi, o.concclco, concdesc 
          UNION  
              /*Saldo a favor por Notas*/  
              SELECT moviserv PRODUCTO, o.conccodi, concdesc, o.concclco, movitimo TIPOMOVI, '07_SA_Notas' Movimiento, 
                     sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor   
                FROM open.ic_movimien, open.concepto o   
               WHERE movitido = 73  
                 and movifeco >= '01-01-2017'
                 and movifeco <= '31-01-2017' 
                 AND movitihe is null  
                 AND movitimo = 46
                 AND moviconc = conccodi
               GROUP BY moviserv, movitimo, o.conccodi, o.concclco, concdesc 
          UNION   
              /*Notas por concepto*/  
              SELECT moviserv PRODUCTO, o.conccodi, concdesc, o.concclco, movitimo TIPOMOVI, '05_Notas_Concepto' Movimiento, 
                     sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
                FROM open.ic_movimien, open.concepto o   
               WHERE movitido = 73  
                 and movifeco >= '01-01-2017'
                 and movifeco <= '31-01-2017' 
                 AND movitihe is null  
                 AND movitimo in (16,56)
                 AND moviconc = conccodi
               GROUP BY moviserv, movitimo, o.conccodi, o.concclco, concdesc 
      /*    UNION  
              -- Devoluciones saldo a favor
              SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor   
                FROM open.ic_movimien   
               WHERE movitido = 73  
                 and movifeco >= '01-03-2016'
                 and movifeco <= '31-03-2016' 
                 AND movitihe is null  
                 AND movitimo = 48  
               GROUP BY moviserv, movitimo */
          UNION  
              -- Sancion por reactivacion de deuda
              SELECT moviserv PRODUCTO, o.conccodi, concdesc, o.concclco, movitimo TIPOMOVI, '08_Sancion_X_Reactivacion_Deuda' Movimiento, 
                     sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor  
                FROM open.ic_movimien, open.concepto o
               WHERE movitido = 73  
                 and movifeco >= '01-01-2017'
                 and movifeco <= '31-01-2017' 
                 AND movitihe IS NULL  
                 AND movitimo = 57
                 AND moviconc = conccodi
               GROUP BY moviserv, movitimo, o.conccodi, o.concclco, concdesc
          UNION  
              /*Recaudo por concepto*/ 
              SELECT moviserv PRODUCTO, o.conccodi, concdesc, o.concclco, movitimo TIPOMOVI, '09_Rdo_x_Concepto' Movimiento, 
                     sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor  
                FROM open.ic_movimien, open.concepto o
               WHERE movitido = 72 
                 and movifeco >= '01-01-2017'
                 and movifeco <= '31-01-2017' 
                 AND movitimo = 23 
                 AND moviconc = conccodi
               GROUP BY moviserv, movitimo, o.conccodi, o.concclco, concdesc
         )
      GROUP BY producto, movimiento, conccodi, concclco, concdesc   
      )
        WHERE VALOR <> 0
        GROUP BY SERVICIO, movimiento, VALOR, conccodi, concclco, concdesc
)
--
UNION ALL
-- CARTERA DIFERIDA
-- SALDO INICIAL
SELECT 'DIFERIDA' CARTERA, /*caccnuse PRODUCTO,*/ caccserv SERVICIO, '01_Saldo Inicial' Movimiento, o.conccodi, concdesc, o.concclco, 
       nvl(sum(decode(caccnaca,'F',caccsape)),0) VALOR, '1_Sdo_Inicial' TIPO
  FROM open.ic_cartcoco, open.concepto o
 WHERE caccfege = '31/12/2016'
   AND caccconc = conccodi
 GROUP BY /*caccnuse,*/ caccserv, o.conccodi, o.concclco, concdesc
UNION
-- SALDO FINAL
SELECT 'DIFERIDA' CARTERA,/*caccnuse PRODUCTO,*/ caccserv SERVICIO, '10_Saldo Final' Movimiento, conccodi, concdesc, concclco,  
       NVL((sum(decode(caccnaca,'F',caccsape))* -1),0) VALOR, '3_Sdo_Final' TIPO
  FROM open.ic_cartcoco, open.concepto o
 WHERE caccfege = '31/01/2017'
   and caccconc = o.conccodi
 GROUP BY /*caccnuse,*/ caccserv, o.conccodi, o.concclco, concdesc
UNION
-- MOVIMIENTO DIFERIDOS
SELECT 'DIFERIDA' CARTERA, /*PRODUCTO,*/ SERVICIO, '02_Mvto Diferido' Movimiento, conccodi, concdesc, concclco,
       (DB - CR) VALOR, '2_Mvto_Mes' TIPO
  FROM (
        SELECT  /*sesunuse PRODUCTO,*/ sesuserv SERVICIO, o.conccodi, concdesc, o.concclco, nvl(sum(decode(modisign,'DB',modivacu)),0) DB,
                nvl(sum(decode(modisign,'CR',modivacu)),0) CR
        FROM    open.movidife, open.servsusc, open.diferido d, open.concepto o
        WHERE   modifech >= to_date('01/01/2017 00:00:00','dd/mm/yyyy hh24:mi:ss')
          AND   modifech <= to_date('31/01/2017 23:59:59','dd/mm/yyyy hh24:mi:ss')
          AND   modinuse = sesunuse
          AND   modivacu > 0
          AND   modidife = d.difecodi
          AND   d.difeconc = o.conccodi
        GROUP BY /*sesunuse,*/ sesuserv, o.conccodi, o.concclco, concdesc
       )
--
)
ORDER BY CARTERA, SERVICIO, MOVIMIENTO, conccodi, concclco
;
