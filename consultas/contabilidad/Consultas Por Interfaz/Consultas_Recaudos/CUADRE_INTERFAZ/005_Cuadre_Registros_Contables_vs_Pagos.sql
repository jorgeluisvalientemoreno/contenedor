-- Total Pagos
SELECT FECHA, BANCO, BANCNOMB, VALOR, 'P' TIPO
 FROM (
        SELECT trunc(pagofegr) FECHA, pagobanc banco, b.bancnomb bancnomb,  SUM(pagovapa) valor--, 'P' tipo
          FROM open.pagos, open.banco b
         WHERE trunc(pagofegr) >= '&FECHA_INICIAL'||' 00:00:00' and trunc(pagofegr) < '&FECHA_FINAL'||' 23:59:59'
           and pagobanc = banccodi 
         GROUP BY pagobanc, trunc(pagofegr), b.bancnomb
        UNION
         SELECT paanfech fecha, pagobanc banco, b.bancnomb bancnomb, (SUM(pagovapa)*-1) valor--, 'PE' tipo
          FROM open.rc_pagoanul a, open.pagos p, open.banco b
         WHERE a.paancupo = p.pagocupo
           AND paanfech >= '&FECHA_INICIAL' and paanfech < '&FECHA_FINAL 23:59:59'
           and pagobanc = banccodi
         GROUP BY paanfech, pagobanc, b.bancnomb
    )
UNION
-- Total Contable por Entidad 
SELECT FechaCreacion, to_number(Cod_Entidad) banco, Desc_Entidad, SUM((VALOR)*-1) VALOR, 'C' Tipo
  FROM (SELECT c.ecrcfech FechaCreacion, open.ldci_pkinterfazsap.fvaGetData(7, dcrcinad, '|') Cod_Entidad,
               open.pktblbanco.fsbgetbancnomb(open.ldci_pkinterfazsap.fvaGetData(7, dcrcinad, '|')) Desc_Entidad,
               DECODE(dcrcsign, 'D', dcrcvalo, -dcrcvalo) VALOR
          FROM OPEN.IC_DECORECO,
               (SELECT * 
                  FROM OPEN.IC_ENCORECO
                 WHERE ECRCCOGE IN
                       (SELECT COGECONS
                          FROM OPEN.IC_COMPGENE
                         WHERE COGECOCO IN (SELECT COCOCODI
                                              FROM OPEN.IC_COMPCONT
                                             WHERE COCOTCCO = 2)
                           AND COGEFEIN >= '&FECHA_INICIAL'||' 00:00:00'
                           AND COGEFEFI <= '&FECHA_FINAL'||' 23:59:59')) C,
               open.ic_clascore p,
               open.ic_clascont h
         WHERE DCRCECRC = C.ECRCCONS
           AND DCRCCLCR = p.clcrcons
           AND p.clcrclco = h.clcocodi
           AND (dcrccuco LIKE '%147065%' OR dcrccuco LIKE '%1110%' OR dcrccuco LIKE '%110501%')
        )
 GROUP BY FechaCreacion, Cod_Entidad, Desc_Entidad
