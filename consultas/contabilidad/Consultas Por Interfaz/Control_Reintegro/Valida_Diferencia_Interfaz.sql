      SELECT abs(SUM(nvl(VALOR,0)))
      FROM
      (
          SELECT ENTIDAD, SUM(VALOR) VALOR
          FROM
          (
          SELECT a.MOVIBACO, (select it.bancclco from open.banco it where it.banccodi = a.MOVIBACO) entidad,
          --       d.bancnomb Desc_Entidad,
                 SUM(DECODE(a.movisign, 'D', a.movivalo, -a.movivalo)) Valor
            FROM open.ic_movimien a, open.banco d, open.tipoenre f, open.cuenbanc e, open.ic_tipomovi g
           WHERE MOVITIDO = 74
             AND MOVITIMO IN (38, 65)
             AND a.MOVIFECO >= '26-11-2019'
             AND a.MOVIFECO <= '26-11-2019'
             AND a.MOVIBACO = d.banccodi
             AND d.banctier = 2
             AND a.movitibr = f.tiercodi
             AND a.movicuba = e.cubacodi
             AND g.timocodi = a.movitimo
          GROUP BY a.MOVIBACO
          ) GROUP BY ENTIDAD
          --
          MINUS
          --
          SELECT h.clcocodi ENTIDAD, dcrccuco,
          --       h.clcodesc Des_Clasificador,
                 SUM(DECODE(dcrcsign, 'D', dcrcvalo, -dcrcvalo)) VALOR
            FROM OPEN.IC_DECORECO,
                 (SELECT *
                    FROM OPEN.IC_ENCORECO
                   WHERE ECRCCOGE IN
                         (SELECT COGECONS
                            FROM OPEN.IC_COMPGENE
                           WHERE COGECOCO IN (SELECT COD_COMPROBANTE FROM open.LDCI_TIPOINTERFAZ WHERE TIPOINTERFAZ ='LA')
                             AND COGEFEIN >= '26-11-2019'
                             AND COGEFEFI <= '26-11-2019')) C,
                 open.ic_clascore p,
                 open.ic_clascont h
           WHERE DCRCECRC = C.ECRCCONS
             AND DCRCCLCR = p.clcrcons
             AND p.clcrclco = h.clcocodi
             AND (dcrccuco LIKE '1202%' OR dcrccuco LIKE '111%%')
--             AND h.clcocodi
          GROUP BY h.clcocodi, dcrccuco
      );
