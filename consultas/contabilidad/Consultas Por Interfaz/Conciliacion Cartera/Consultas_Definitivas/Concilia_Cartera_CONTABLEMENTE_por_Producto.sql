-- CONCILIA CARTERA CONTABLE
SELECT *
  FROM
      (
-- SALDO INICIAL
        SELECT  SERVICIO, sum(VALOR) VALOR, '1_SI' TIPO
        FROM (
              SELECT caccserv SERVICIO, nvl(sum(decode(caccnaca,'N',caccsape)),0) VALOR
                FROM OPEN.ic_cartcoco
               WHERE caccfege = '30/11/2015'
               GROUP BY caccserv
             )
         WHERE valor <> 0
        GROUP BY  SERVICIO
        UNION ALL
        -- SALDO FINAL
        SELECT SERVICIO, sum(VALOR) VALOR, '3_SF' TIPO
        FROM (
              SELECT caccserv SERVICIO, NVL((sum(decode(caccnaca,'N',caccsape))* -1),0) VALOR, '3_SF' TIPO
                FROM OPEN.ic_cartcoco
               WHERE caccfege = '31/12/2015'
               GROUP BY caccserv
             )
         WHERE valor <> 0
         GROUP BY SERVICIO
        UNION ALL
        ----
        SELECT SERVICIO, SUM(VALOR) VALOR, '2_RC' TIPO
          FROM (
        select TO_NUMBER(Tipo_Producto) SERVICIO, /*cuenta, */sum(decode(signo, 'D', valor, -valor)) VALOR
          from (
        SELECT (SELECT  DISTINCT a.rcccpopa FROM OPEN.ic_recoclco a WHERE clcrcons=a.rcccclcr AND a.rccccuco=dcrccuco) porcent,
                Nvl(OPEN.ldci_pkinterfazsap.fvaGetData(5,dcrcinad,'|'),NULL)  categoria,
                Nvl(OPEN.ldci_pkinterfazsap.fvaGetData(6,dcrcinad,'|'),NULL)  sub_categoria,
                Nvl(OPEN.ldci_pkinterfazsap.fvaGetData(10,dcrcinad,'|'),NULL) Tipo_Producto,
                Nvl(OPEN.ldci_pkinterfazsap.fvaGetData(17,dcrcinad,'|'),NULL) Localidad,
                Nvl(OPEN.ldci_pkinterfazsap.fvaGetData(41,dcrcinad,'|'),NULL) causal,
                dcrcecrc,
                dcrccorc,
                dcrccuco cuenta,
                dcrcsign signo,
                SUM(dcrcvalo) valor,
                dcrcinad,
                dcrcusua,
                dcrcterm,
                dcrcprog,
                dcrcsist,
                clcrclco clas_orig,
                clcrclco clasificador,CLCODESC,
                corccoco Comprobante,
                corctido TipoDocumento,
                corctimo TipoMovimiento,
                OPEN.ldci_pkinterfazsap.fvaGetData(30,dcrcinad,'|') FechaPago,clcrcons
        FROM  OPEN.ic_encoreco
        JOIN  OPEN.ic_decoreco ON (ecrccons = dcrcecrc)
        JOIN  OPEN.ic_confreco ON (dcrccorc = corccons)
        JOIN  OPEN.ic_clascore ON (clcrcons = dcrcclcr)
        JOIN  OPEN.ic_clascont ON (clcrclco =clcocodi) 
        WHERE  ecrccoco IN (select cod_comprobante from OPEN.LDCI_TIPOINTERFAZ where tipointerfaz = 'L1')
        AND    ecrcfech  BETWEEN  '01/12/2015' and '31/12/2015'
        GROUP  BY dcrcecrc,clcrcons,CLCODESC,dcrccorc,dcrccuco,dcrcsign,dcrcinad,corctimo,
                 dcrcusua,dcrcterm,dcrcprog,dcrcsist,clcrclco,corccoco,corctido,clcrcons
        )
        where cuenta in (1406060101,1406060201,1407170101,1407170201,1407900101,1407900201,1407901101,1407901201,1407902101,
                         1407902201,1407904101,1407904201,1407906101,1407906201,1407907101,1407907201,1407909501,1407909502,
                         1407909601,1407909601,1408050101,1408050201,1408051101,1408051201,1470031101,1470031201,1470033101,
                         1470034101,1470034201,1470035101,1470035201,1470036101,1470037101,1470037201,1470038101,1470038201,
                         1470039101,1470039201)
        group by Tipo_Producto
        )
        GROUP BY SERVICIO
      --
      UNION ALL
      --
      /*Recaudo por concepto*/ 
      SELECT moviserv SERVICIO, sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))*-1) valor, '2_RE' TIPO
        FROM open.ic_movimien  
       WHERE movitido = 72 
         AND movifeco >= '01-12-2015'
         AND movifeco <= '31-12-2015'
         AND movitimo = 23 
       GROUP BY moviserv, movitimo 
      --
      UNION ALL
      --
      /*CARGDOSO CAUSAL 51*/        
       select SS.SESUSERV SERVICIOS, sum(cargvalo * -1) VALOR, '2_DF' TIPO
         from open.cargos c, OPEN.CUENCOBR, OPEN.FACTURA, open.CONCEPTO CO, OPEN.SERVSUSC SS 
        where c.CARGCONC  = CO.CONCCODI 
          AND C.CARGNUSE  = SS.SESUNUSE 
          AND factcodi    = CUCOfact 
          AND CARGCUCO    = CUCOCODI 
          AND FACTFEGE BETWEEN to_date('01/12/2015 00:00:00','dd/mm/yyyy hh24:mi:ss') 
                           and to_date('31/12/2015 23:59:59','dd/mm/yyyy hh24:mi:ss') 
          and cargtipr = 'A' 
          and cargsign NOT IN ('PA','AP')
          AND substr(cargdoso, 0, 2) = 'DF'
          AND cargcaca = 51
          AND concclco in (56,58,88,103)
        Group By SS.SESUSERV
       ---
       UNION ALL
       -- MOVIMIENTO DIFERIDOS
       SELECT SERVICIO, ((DB - CR)*-1) VALOR, '2_MD' TIPO
         FROM (
               SELECT   sesuserv SERVICIO, nvl(sum(decode(modisign,'DB',modivacu)),0) DB,
                       nvl(sum(decode(modisign,'CR',modivacu)),0) CR
                 FROM    open.movidife, open.servsusc
                WHERE   modifech >= to_date('01/12/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')
                  AND   modifech <= to_date('31/12/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
                  AND   modinuse = sesunuse
                  AND   modivacu > 0
               GROUP BY sesuserv
              )        
)
  WHERE VALOR <> 0
--  GROUP BY SERVICIO, VALOR;
