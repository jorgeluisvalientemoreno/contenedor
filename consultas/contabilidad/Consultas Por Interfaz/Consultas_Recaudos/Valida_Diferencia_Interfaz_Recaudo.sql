      SELECT abs(SUM(nvl(VALOR,0))) FROM (
      SELECT to_number(Cod_Entidad) banco,
             Desc_Entidad,
             Sucursal,
             FechaCreacion,
             Cod_Clasificador,
             Des_Clasificador,
             SUM(VALOR) VALOR,
             'RC' Tipo
        FROM (SELECT c.ecrcfech FechaCreacion,
                     open.ldci_pkinterfazsap.fvaGetData(7, dcrcinad, '|') Cod_Entidad,
                     open.pktblbanco.fsbgetbancnomb(open.ldci_pkinterfazsap.fvaGetData(7, dcrcinad, '|')) Desc_Entidad,
                     open.ldci_pkinterfazsap.fvaGetData(29, dcrcinad, '|') Sucursal,
                     h.clcocodi Cod_Clasificador,
                     h.clcodesc Des_Clasificador,
                     DCRCCUCO Cuenta,
                     DECODE(dcrcsign, 'D', dcrcvalo, -dcrcvalo) VALOR
                FROM OPEN.IC_DECORECO,
                     (SELECT *
                        FROM OPEN.IC_ENCORECO
                       WHERE ECRCCOGE IN
                             (SELECT COGECONS
                                FROM OPEN.IC_COMPGENE
                               WHERE COGECOCO IN (SELECT COD_COMPROBANTE FROM open.LDCI_TIPOINTERFAZ WHERE TIPOINTERFAZ ='L2')
                                 AND COGEFEIN >= '28-06-2019'
                                 AND COGEFEFI <= '28-06-2019')) C,
                     open.ic_clascore p,
                     open.ic_clascont h
               WHERE DCRCECRC = C.ECRCCONS
                 AND DCRCCLCR = p.clcrcons
                 AND p.clcrclco = h.clcocodi
                 AND (dcrccuco LIKE '147065%' OR dcrccuco LIKE '11%%')
              )
       GROUP BY FechaCreacion,
                Cod_Entidad,
                Desc_Entidad,
                Sucursal,
                Cod_Clasificador,
                Des_Clasificador,
                Cuenta
      UNION
      SELECT movibanc banco, open.pktblbanco.fsbgetbancnomb(movibanc) Desc_Entidad,
             movisuba sucursal, movifeco fecha, clasificador,
             (SELECT clcodesc FROM open.ic_clascont WHERE clcocodi = clasificador) desc_clas,
             (sum(decode(movisign, 'C', movivalo*-1, movivalo))*-1) valor, 'HE' tipo
        FROM
      (
      SELECT movibanc, movisuba, movifeco, (SELECT concclco FROM open.concepto WHERE conccodi = moviconc) clasificador,
             movisign, movivalo
        FROM open.ic_movimien
       WHERE movitido = 72
         AND movifeco >= '28-06-2019'
         AND movifeco <= '28-06-2019'
         AND moviconc IS NOT NULL
      )
      GROUP BY movibanc, movisuba, movifeco, clasificador
      );
