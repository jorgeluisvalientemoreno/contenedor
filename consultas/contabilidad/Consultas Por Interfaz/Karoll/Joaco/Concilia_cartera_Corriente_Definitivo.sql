-- SALDO INICIAL
SELECT * FROM (
SELECT  SERVICIO, null movicaca, null desc_caca, null concepto, null DESC_CONC, sum(VALOR), '1_SALDO INICIAL' TIPO
FROM (
      SELECT caccserv SERVICIO, null, null,
            --cc.caccconc concepto, (select co.concdesc from open.concepto co where co.conccodi = cc.caccconc) DESC_CONC, 
            nvl(sum(decode(caccnaca,'N',caccsape)),0) VALOR
       FROM OPEN.ic_cartcoco cc
      WHERE caccfege = '31/07/2015'
        and caccserv = 7056
      GROUP BY caccserv--, cc.caccconc
     )
 WHERE valor <> 0
GROUP BY  SERVICIO, null, null
UNION ALL
-- SALDO FINAL
SELECT SERVICIO, null movicaca, null desc_caca,  null concepto, null DESC_CONC, sum(VALOR), '3_SALDO FINAL' TIPO
FROM (
      SELECT caccserv SERVICIO, null, null, 
             --cc.caccconc concepto, (select co.concdesc from open.concepto co where co.conccodi = cc.caccconc) DESC_CONC, 
             NVL((sum(decode(caccnaca,'N',caccsape))* -1),0) VALOR--, 'SF' TIPO
        FROM OPEN.ic_cartcoco cc
       WHERE caccfege = '31/08/2015'
       and caccserv = 7056
       GROUP BY caccserv--, cc.caccconc
     )
 WHERE valor <> 0
 GROUP BY SERVICIO, null, null
UNION ALL
/*Consulta Hechos*/
SELECT SERVICIO, movicaca, desc_caca, concepto, desc_conc, sum(VALOR), '2-'||movimiento TIPO
FROM (
SELECT PRODUCTO SERVICIO, movicaca, desc_caca, concepto, desc_conc, 
       SUM(DECODE(TIPOMOVI,1,VALOR,16,VALOR,25,VALOR,56,VALOR,-VALOR)) VALOR, movimiento
  FROM ( /*Facturaci¢n por Concepto*/
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, 
               movicaca, (select cg.cacadesc from open.causcarg cg where cacacodi = movicaca) desc_caca, 
               (SELECT m.timodesc from open.ic_tipomovi m where m.timocodi = movitimo) MOVIMIENTO,
               moviconc concepto, (select co.concdesc from open.concepto co where co.conccodi = moviconc) DESC_CONC, 
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien
         WHERE movitido = 71
           AND movifeco >= '01-08-2015'
           AND movifeco <= '31-08-2015'
           AND movitihe = 'F'
           AND movitimo = 1
           and moviserv = 7056
         GROUP BY moviserv, movitimo, moviconc, movicaca
    UNION
        /*Aplicaci¢n de Saldo a Favor en Facturaci¢n*/
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, 
               movicaca, (select cg.cacadesc from open.causcarg cg where cacacodi = movicaca) desc_caca,
               (SELECT m.timodesc from open.ic_tipomovi m where m.timocodi = movitimo) MOVIMIENTO,
               moviconc concepto, (select co.concdesc from open.concepto co where co.conccodi = moviconc) DESC_CONC,                
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien
         WHERE movitido = 71
           AND movifeco >= '01-08-2015'
           AND movifeco <= '31-08-2015'
           AND movitihe is null
           AND movitimo = 11
           and moviserv = 7056           
         GROUP BY moviserv, movitimo, moviconc, movicaca
    UNION
        /*Aplicaci¢n saldo a Favor por Notas*/
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, 
               movicaca, (select cg.cacadesc from open.causcarg cg where cacacodi = movicaca) desc_caca,
               (SELECT m.timodesc from open.ic_tipomovi m where m.timocodi = movitimo) MOVIMIENTO,
               moviconc concepto, (select co.concdesc from open.concepto co where co.conccodi = moviconc) DESC_CONC,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien
         WHERE movitido = 73
           AND movifeco >= '01-08-2015'
           AND movifeco <= '31-08-2015'
           AND movitihe is null
           AND movitimo = 40
           and moviserv = 7056           
         GROUP BY moviserv, movitimo, moviconc, movicaca
    UNION
        /*Saldo a favor por Facturaci¢n*/
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, 
               movicaca, (select cg.cacadesc from open.causcarg cg where cacacodi = movicaca) desc_caca, 
               (SELECT m.timodesc from open.ic_tipomovi m where m.timocodi = movitimo) MOVIMIENTO,
               moviconc concepto, (select co.concdesc from open.concepto co where co.conccodi = moviconc) DESC_CONC,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien
         WHERE movitido = 71
           AND movifeco >= '01-08-2015'
           AND movifeco <= '31-08-2015'
           AND movitihe is null  
           AND movitimo = 44  
           and moviserv = 7056           
         GROUP BY moviserv, movitimo, moviconc, movicaca
    UNION  
        /*Saldo a favor por Notas*/  
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, 
               movicaca, (select cg.cacadesc from open.causcarg cg where cacacodi = movicaca) desc_caca, 
               (SELECT m.timodesc from open.ic_tipomovi m where m.timocodi = movitimo) MOVIMIENTO,
               moviconc concepto, (select co.concdesc from open.concepto co where co.conccodi = moviconc) DESC_CONC,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor   
          FROM open.ic_movimien   
         WHERE movitido = 73  
           AND movifeco >= '01-08-2015'
           AND movifeco <= '31-08-2015'
           AND movitihe is null  
           AND movitimo = 46  
           and moviserv = 7056           
         GROUP BY moviserv, movitimo, moviconc, movicaca
    UNION   
        /*Notas por concepto*/  
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, 
               movicaca, (select cg.cacadesc from open.causcarg cg where cacacodi = movicaca) desc_caca, 
               (SELECT m.timodesc from open.ic_tipomovi m where m.timocodi = movitimo) MOVIMIENTO,
               moviconc concepto, (select co.concdesc from open.concepto co where co.conccodi = moviconc) DESC_CONC,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien   
         WHERE movitido = 73  
           AND movifeco >= '01-08-2015'
           AND movifeco <= '31-08-2015'
           AND movitihe is null  
           AND movitimo in (16,56)  
           and moviserv = 7056           
         GROUP BY moviserv, movitimo, moviconc, movicaca 
    UNION  
        -- Devoluciones saldo a favor
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, 
               movicaca, (select cg.cacadesc from open.causcarg cg where cacacodi = movicaca) desc_caca, 
               (SELECT m.timodesc from open.ic_tipomovi m where m.timocodi = movitimo) MOVIMIENTO,
               moviconc concepto, (select co.concdesc from open.concepto co where co.conccodi = moviconc) DESC_CONC,
               Sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor   
          FROM open.ic_movimien   
         WHERE movitido = 73  
           AND movifeco >= '01-08-2015'
           AND movifeco <= '31-08-2015'
           AND movitihe is null  
           AND movitimo = 48  
           and moviserv = 7056           
         GROUP BY moviserv, movitimo, moviconc, movicaca 
    UNION  
        -- Sancion por reactivacion de deuda
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, 
               movicaca, (select cg.cacadesc from open.causcarg cg where cacacodi = movicaca) desc_caca, 
               (SELECT m.timodesc from open.ic_tipomovi m where m.timocodi = movitimo) MOVIMIENTO,
               moviconc concepto, (select co.concdesc from open.concepto co where co.conccodi = moviconc) DESC_CONC,
               Sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor  
          FROM open.ic_movimien   
         WHERE movitido = 73  
           AND movifeco >= '01-08-2015'
           AND movifeco <= '31-08-2015'
           AND movitihe IS NULL  
           AND movitimo = 57  
           and moviserv = 7056           
         GROUP BY moviserv, movitimo, moviconc, movicaca
    UNION  
        /*Recaudo por concepto*/ 
        SELECT moviserv PRODUCTO, movitimo TIPOMOVI, 
               movicaca, (select cg.cacadesc from open.causcarg cg where cacacodi = movicaca) desc_caca, 
               (SELECT m.timodesc from open.ic_tipomovi m where m.timocodi = movitimo) MOVIMIENTO,
               moviconc concepto, (select co.concdesc from open.concepto co where co.conccodi = moviconc) DESC_CONC,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor  
          FROM open.ic_movimien  
         WHERE movitido = 72 
           AND movifeco >= '01-08-2015'
           AND movifeco <= '31-08-2015'
           AND movitimo IN (23 ,25)
           and moviserv = 7056           
         GROUP BY moviserv, movitimo, moviconc, movicaca
   )
GROUP BY producto, concepto, desc_conc, movimiento, movicaca, desc_caca
)
  WHERE VALOR <> 0
  GROUP BY SERVICIO, movimiento, concepto, desc_conc, movicaca, desc_caca);
