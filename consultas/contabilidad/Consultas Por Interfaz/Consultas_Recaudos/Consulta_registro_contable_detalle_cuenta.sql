-- Compara Registros contables vs Hechos
SELECT to_number(Cod_Entidad) banco,
       Desc_Entidad,
       FechaCreacion,
       Cod_Clasificador,
       Des_Clasificador,
       SUM(VALOR) VALOR,
       'RC' Tipo,
       cuenta
  FROM (SELECT c.ecrcfech FechaCreacion,
               open.ldci_pkinterfazsap.fvaGetData(7, dcrcinad, '|') Cod_Entidad,
               open.pktblbanco.fsbgetbancnomb(open.ldci_pkinterfazsap.fvaGetData(7, dcrcinad, '|')) Desc_Entidad,
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
                         WHERE COGECOCO IN (SELECT COCOCODI
                                              FROM OPEN.IC_COMPCONT t
                                             WHERE COCOTCCO = 2 and t.cococodi = 19)
                           AND COGEFEIN >= '&FECHA_INICIAL'||' 00:00:00'
                           AND COGEFEFI <= '&FECHA_FINAL'||' 23:59:59')) C,
               open.ic_clascore p,
               open.ic_clascont h
         WHERE DCRCECRC = C.ECRCCONS
           AND DCRCCLCR = p.clcrcons
           AND p.clcrclco = h.clcocodi
           and h.clcocodi = 52
          -- AND (dcrccuco LIKE '%147065%' OR dcrccuco LIKE '%1110%' OR dcrccuco LIKE '%110501%')
        )
 GROUP BY FechaCreacion,
          Cod_Entidad,
          Desc_Entidad,
          Cod_Clasificador,
          Des_Clasificador,
          Cuenta
