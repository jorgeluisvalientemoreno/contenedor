-- CARTERA CORRIENTE
/* Consulta Hechos */
SELECT CONCEPTO, CLASIFICADOR, SERVICIO, sum(VALOR), '2_HE' TIPO
FROM (
SELECT CONCEPTO, CONCCLCO CLASIFICADOR, PRODUCTO SERVICIO,
       SUM(DECODE(TIPOMOVI,1,VALOR,16,VALOR,25,VALOR,56,VALOR,-VALOR)) VALOR
  FROM ( /* Facturaci�n por Concepto */
        SELECT moviconc CONCEPTO, moviserv PRODUCTO, movitimo TIPOMOVI,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien
         WHERE movitido = 71
           AND movifeco >= '09/02/2015'
           AND movifeco <= '28/02/2015'
           AND movitihe = 'F'
           AND movitimo = 1
         GROUP BY movitimo,  moviserv,  moviconc
    UNION
        /* Aplicaci�n de Saldo a Favor en Facturaci�n */
        SELECT moviconc CONCEPTO, moviserv PRODUCTO, movitimo TIPOMOVI,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien
         WHERE movitido = 71
           AND movifeco >= '09/02/2015'
           AND movifeco <= '28/02/2015'
           AND movitihe is null
           AND movitimo = 11
         GROUP BY movitimo,  moviserv,  moviconc
    UNION
        /* Aplicaci�n saldo a Favor por Notas */
        SELECT moviconc CONCEPTO, moviserv PRODUCTO, movitimo TIPOMOVI,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien
         WHERE movitido = 73
           AND movifeco >= '09/02/2015'
           AND movifeco <= '28/02/2015'
           AND movitihe is null
           AND movitimo = 40
         GROUP BY movitimo,  moviserv,  moviconc
    UNION
        /* Saldo a favor por Facturaci�n */
        SELECT moviconc CONCEPTO, moviserv PRODUCTO, movitimo TIPOMOVI,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien
         WHERE movitido = 71
           AND movifeco >= '09/02/2015'
           AND movifeco <= '28/02/2015'
           AND movitihe is null  
           AND movitimo = 44  
         GROUP BY movitimo,  moviserv,  moviconc  
    UNION  
        /*Saldo a favor por Notas*/  
        SELECT moviconc CONCEPTO, moviserv PRODUCTO, movitimo TIPOMOVI,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor   
          FROM open.ic_movimien   
         WHERE movitido = 73  
           AND movifeco >= '09/02/2015'
           AND movifeco <= '28/02/2015'
           AND movitihe is null  
           AND movitimo = 46  
         GROUP BY movitimo,  moviserv,  moviconc  
    UNION   
        /*Notas por concepto*/  
        SELECT moviconc CONCEPTO, moviserv PRODUCTO, movitimo TIPOMOVI,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien   
         WHERE movitido = 73  
           AND movifeco >= '09/02/2015'
           AND movifeco <= '28/02/2015'
           AND movitihe is null  
           AND movitimo in (16,56)  
         GROUP BY movitimo,  moviserv,  moviconc  
    UNION  
        -- Devoluciones saldo a favor
        SELECT moviconc CONCEPTO, moviserv PRODUCTO, movitimo TIPOMOVI,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor   
          FROM open.ic_movimien   
         WHERE movitido = 73  
           AND movifeco >= '09/02/2015'
           AND movifeco <= '28/02/2015'
           AND movitihe is null  
           AND movitimo = 48  
         GROUP BY movitimo,  moviserv,  moviconc  
    UNION  
        -- Sancion por reactivacion de deuda
        SELECT moviconc CONCEPTO, moviserv PRODUCTO, movitimo TIPOMOVI,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor  
          FROM open.ic_movimien   
         WHERE movitido = 73  
           AND movifeco >= '09/02/2015'
           AND movifeco <= '28/02/2015'
           AND movitihe IS NULL  
           AND movitimo = 57  
         GROUP BY movitimo,  moviserv,  moviconc  
    UNION  
        /*Recaudo por concepto*/ 
        SELECT moviconc CONCEPTO, moviserv PRODUCTO, movitimo TIPOMOVI,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor  
          FROM open.ic_movimien  
         WHERE movitido = 72 
           AND movifeco >= '09/02/2015'
           AND movifeco <= '28/02/2015'
           AND movitimo = 23 
         GROUP BY movitimo,  moviserv,  moviconc 
   ), OPEN.CONCEPTO, OPEN.IC_CLASCONT 
  WHERE CONCEPTO =  conccodi 
    AND concclco = clcocodi (+) 
  GROUP BY CONCEPTO, producto,concclco
)
  WHERE VALOR <> 0
    /*AND CLASIFICADOR IS NULL*/
  GROUP BY CONCEPTO, CLASIFICADOR, SERVICIO, VALOR;