SELECT substr(B.FechaPago,LENGTH(B.FechaPago)-1,2)||'/'||
      substr(B.FechaPago,LENGTH(B.FechaPago)-3,2)||'/'||
      substr(B.FechaPago,1,4) FechaPago,
      B.dcrcfecr,
      B.porcent,
      B.dcrcecrc,
      B.dcrccorc,
      B.cuenta,
      B.dcrcinad,
      Clasi,
      B.dcrcusua,
      B.dcrcterm,
      B.dcrcprog,
      B.dcrcsist,
      B.clasificador,
      B.Comprobante,
      B.TipoComprobante,
      B.ecrcfech,
      SUM(B.valor) valor
    FROM
      (SELECT
        (SELECT DISTINCT a.rcccpopa
        FROM open.ic_recoclco a
        WHERE clcrcons=a.rcccclcr
        AND a.rccccuco=dcrccuco
        ) porcent,
        dcrcecrc,
        dcrccorc,
        dcrccuco cuenta,
        dcrcsign signo,
        SUM(DECODE(dcrcsign,'D',dcrcvalo,-dcrcvalo)) valor,
        dcrcinad,
        TRUNC(dcrcfecr) dcrcfecr,
        dcrcusua,
        dcrcterm,
        dcrcprog,
        dcrcsist,
        clcrclco Clasi,
        DECODE(open.ldci_pkinterfazsap.fnuValidaCtaBanco(clcrclco,dcrccuco),0,-1,clcrclco) clasificador,
        corccoco Comprobante ,
        corctido TipoComprobante,
        TRUNC(ecrcfech) ecrcfech,
        open.ldci_pkinterfazsap.fvaGetData(30,dcrcinad,'|') FechaPago

      FROM open.ic_encoreco
      JOIN open.ic_decoreco  ON (ecrccons = dcrcecrc)
      JOIN open.ic_confreco  ON (dcrccorc = corccons )
      JOIN open.ic_clascore  ON (clcrcons = dcrcclcr)
      JOIN open.ic_clascont  ON (clcrclco    =clcocodi)
     WHERE ecrccoco IN  (SELECT COD_COMPROBANTE FROM open.LDCI_TIPOINTERFAZ WHERE TIPOINTERFAZ = 'L2') --sbTipoInterfaz
       AND ecrcfech BETWEEN '12-10-2022' and '12-10-2022'
       AND clcrclco = 596
      GROUP BY dcrcecrc, dcrccorc, dcrccuco, dcrcsign, dcrcinad, TRUNC(dcrcfecr), dcrcusua, dcrcterm, dcrcprog, dcrcsist,
               clcrclco, corccoco, corctido, TRUNC(ecrcfech), clcrcons
      ) B
    GROUP BY B.porcent, B.dcrcecrc, B.dcrccorc, B.cuenta, B.dcrcinad, B.dcrcfecr, B.dcrcusua, B.dcrcterm, B.dcrcprog, B.dcrcsist,
             B.clasificador, B.Comprobante, B.TipoComprobante, B.ecrcfech, B.FechaPago, Clasi;
