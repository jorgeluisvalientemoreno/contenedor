-- SALDO INICIAL
SELECT * FROM (
SELECT  SERVICIO, sum(VALOR), '1_SI' TIPO
FROM (
SELECT caccserv SERVICIO, nvl(sum(decode(caccnaca,'N',caccsape)),0) VALOR
  FROM OPEN.ic_cartcoco
 WHERE caccfege = '31/10/2016'
 GROUP BY caccserv
 )
 WHERE valor <> 0
GROUP BY  SERVICIO
UNION ALL
-- SALDO FINAL
SELECT SERVICIO, sum(VALOR), '3_SF' TIPO
FROM (
SELECT caccserv SERVICIO, NVL((sum(decode(caccnaca,'N',caccsape))* -1),0) VALOR, 'SF' TIPO
  FROM OPEN.ic_cartcoco
 WHERE caccfege = '30/11/2016'
 GROUP BY caccserv
 )
 WHERE valor <> 0
 GROUP BY SERVICIO
UNION ALL
/*Consulta Hechos*/
SELECT SERVICIO, sum(VALOR), '2_HE' TIPO
FROM (
SELECT PRODUCTO SERVICIO, SUM(DECODE(TIPOMOVI,1,VALOR,16,VALOR,25,VALOR,56,VALOR,-VALOR)) VALOR
  FROM ( /*Facturaci¢n por Concepto*/
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien
         WHERE movitido = 71
           and movifeco >= '01-11-2016'
           and movifeco <= '30-11-2016'  
           AND movitihe = 'F'
           AND movitimo = 1
         GROUP BY moviserv, movitimo 
    UNION
        /*Aplicaci¢n de Saldo a Favor en Facturaci¢n*/
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien
         WHERE movitido = 71
           and movifeco >= '01-11-2016'
           and movifeco <= '30-11-2016'
           AND movitihe is null
           AND movitimo = 11
         GROUP BY moviserv, movitimo 
    UNION
        /*Aplicaci¢n saldo a Favor por Notas*/
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien
         WHERE movitido = 73
           and movifeco >= '01-11-2016'
           and movifeco <= '30-11-2016'
           AND movitihe is null
           AND movitimo = 40
         GROUP BY moviserv, movitimo 
    UNION
        /*Saldo a favor por Facturaci¢n*/
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien
         WHERE movitido = 71
           and movifeco >= '01-11-2016'
           and movifeco <= '30-11-2016'
           AND movitihe is null  
           AND movitimo = 44  
         GROUP BY moviserv, movitimo 
    UNION  
        /*Saldo a favor por Notas*/  
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor   
          FROM open.ic_movimien   
         WHERE movitido = 73  
           and movifeco >= '01-11-2016'
           and movifeco <= '30-11-2016' 
           AND movitihe is null  
           AND movitimo = 46  
         GROUP BY moviserv, movitimo 
    UNION   
        /*Notas por concepto*/  
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien   
         WHERE movitido = 73  
           and movifeco >= '01-11-2016'
           and movifeco <= '30-11-2016'
           AND movitihe is null  
           AND movitimo in (16,56)  
         GROUP BY moviserv, movitimo 
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
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor  
          FROM open.ic_movimien   
         WHERE movitido = 73  
           and movifeco >= '01-11-2016'
           and movifeco <= '30-11-2016'
           AND movitihe IS NULL  
           AND movitimo = 57  
         GROUP BY moviserv, movitimo 
    UNION  
        /*Recaudo por concepto*/ 
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor  
          FROM open.ic_movimien  
         WHERE movitido = 72 
           and movifeco >= '01-11-2016'
           and movifeco <= '30-11-2016'
           AND movitimo = 23 
         GROUP BY moviserv, movitimo 
   )
GROUP BY producto   
)
  WHERE VALOR <> 0
  GROUP BY SERVICIO, VALOR);
