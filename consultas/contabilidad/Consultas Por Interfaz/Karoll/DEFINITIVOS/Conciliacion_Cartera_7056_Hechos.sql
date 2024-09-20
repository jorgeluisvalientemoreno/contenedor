-- SALDO INICIAL
SELECT * FROM (
SELECT  SERVICIO, sum(VALOR), 'SI' TIPO
FROM (
SELECT caccserv SERVICIO, nvl(sum(decode(caccnaca,'N',caccsape)),0) VALOR
  FROM OPEN.ic_cartcoco i
 WHERE caccfege = '30/06/2015'
   AND CACCSERV = 7056
 GROUP BY caccserv
 )
 WHERE valor <> 0
GROUP BY  SERVICIO
UNION ALL
-- SALDO FINAL
SELECT SERVICIO, sum(VALOR), 'SF' TIPO
FROM (
SELECT caccserv SERVICIO, NVL((sum(decode(caccnaca,'N',caccsape))* -1),0) VALOR, 'SF' TIPO
  FROM OPEN.ic_cartcoco
 WHERE caccfege = '31/07/2015'
    AND CACCSERV = 7056
 GROUP BY caccserv
 )
 WHERE valor <> 0
 GROUP BY SERVICIO
UNION ALL
/*Consulta Hechos*/
SELECT SERVICIO, sum(VALOR), 'HE' TIPO
FROM (
SELECT PRODUCTO SERVICIO, SUM(DECODE(TIPOMOVI,1,VALOR,16,VALOR,25,VALOR,56,VALOR,-VALOR)) VALOR
  FROM ( /*Facturaci¢n por Concepto*/
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien
         WHERE movitido = 71
           AND movifeco >= '01-07-2015'
           AND movifeco <= '31-07-2015'
           AND movitihe = 'F'
           AND movitimo = 1
           AND moviserv = 7056
         GROUP BY moviserv, movitimo 
    UNION
        /*Aplicaci¢n de Saldo a Favor en Facturaci¢n*/
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien
         WHERE movitido = 71
           AND movifeco >= '01-07-2015'
           AND movifeco <= '31-07-2015'
           AND movitihe is null
           AND movitimo = 11
           AND moviserv = 7056           
         GROUP BY moviserv, movitimo 
    UNION
        /*Aplicaci¢n saldo a Favor por Notas*/
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien
         WHERE movitido = 73
           AND movifeco >= '01-07-2015'
           AND movifeco <= '31-07-2015'
           AND movitihe is null
           AND movitimo = 40
           AND moviserv = 7056           
         GROUP BY moviserv, movitimo 
    UNION
        /*Saldo a favor por Facturaci¢n*/
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien
         WHERE movitido = 71
           AND movifeco >= '01-07-2015'
           AND movifeco <= '31-07-2015'
           AND movitihe is null  
           AND movitimo = 44
           AND moviserv = 7056           
         GROUP BY moviserv, movitimo 
    UNION  
        /*Saldo a favor por Notas*/  
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor   
          FROM open.ic_movimien   
         WHERE movitido = 73  
           AND movifeco >= '01-07-2015'
           AND movifeco <= '31-07-2015'
           AND movitihe is null  
           AND movitimo = 46
           AND moviserv = 7056
         GROUP BY moviserv, movitimo 
    UNION   
        /*Notas por concepto*/  
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien   
         WHERE movitido = 73  
           AND movifeco >= '01-07-2015'
           AND movifeco <= '31-07-2015'
           AND movitihe is null  
           AND movitimo in (16,56)
           AND moviserv = 7056
         GROUP BY moviserv, movitimo 
    UNION  
        -- Devoluciones saldo a favor
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor   
          FROM open.ic_movimien   
         WHERE movitido = 73  
           AND movifeco >= '01-07-2015'
           AND movifeco <= '31-07-2015'
           AND movitihe is null  
           AND movitimo = 48
           AND moviserv = 7056
         GROUP BY moviserv, movitimo 
    UNION  
        -- Sancion por reactivacion de deuda
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor  
          FROM open.ic_movimien   
         WHERE movitido = 73  
           AND movifeco >= '01-07-2015'
           AND movifeco <= '31-07-2015'
           AND movitihe IS NULL  
           AND movitimo = 57
           AND moviserv = 7056
         GROUP BY moviserv, movitimo 
    UNION  
        /*Recaudo por concepto*/ 
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor  
          FROM open.ic_movimien  
         WHERE movitido = 72 
           AND movifeco >= '01-07-2015'
           AND movifeco <= '31-07-2015'
           AND movitimo in (23,25) 
           AND moviserv = 7056           
         GROUP BY moviserv, movitimo 
   )
GROUP BY producto   
)
  WHERE VALOR <> 0
  GROUP BY SERVICIO, VALOR);
