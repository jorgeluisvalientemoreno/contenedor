-- 011 Hechos Economicos sin Configuracion
SELECT movifeco, to_char(a.movibanc) Cod_Entidad, d.bancnomb Desc_Entidad,
       c.clcocodi Cod_Clasificador,  c.clcodesc Desc_Clasificador,
       SUM(DECODE(a.movisign, 'D', a.movivalo, -a.movivalo)) Total
  FROM open.ic_movimien a, open.ic_clascont c, open.banco d, open.concepto b
 WHERE a.moviconc = b.conccodi(+)
   AND a.movibanc = d.banccodi
   --and d.banccodi in (506)
   AND b.concclco = c.clcocodi
   AND a.movifeco BETWEEN '&FECHA_INICIAL'||' 00:00:00' AND '&FECHA_FINAL'||' 23:59:59'
   --and b.concclco = 118
GROUP BY movifeco, a.movibanc, d.bancnomb, c.clcocodi, c.clcodesc--;
MINUS
SELECT Fecha_Contable, Cod_Entidad, Desc_Entidad, Cod_Clasificador, Desc_Clasificador, SUM(valor) Total
  FROM (SELECT c.ecrcfech Fecha_Contable, open.ldci_pkinterfazsap.fvagetdata(7, dcrcinad, '|') Cod_Entidad,
               open.pktblbanco.fsbgetbancnomb(open.ldci_pkinterfazsap.fvagetdata(7, dcrcinad, '|')) Desc_Entidad,
               open.ldci_pkinterfazsap.fvagetdata(29, dcrcinad, '|') Cod_Punto_Pago,  h.clcocodi Cod_Clasificador,
               h.clcodesc Desc_Clasificador, DECODE(dcrcsign, 'D', dcrcvalo, -dcrcvalo) valor
          FROM open.ic_decoreco, (SELECT * FROM open.ic_encoreco
                                   WHERE ecrccoge IN (SELECT cogecons FROM open.ic_compgene
                                                       WHERE cogecoco IN (SELECT cococodi FROM open.ic_compcont
                                                                      WHERE cocotcco = 2)
                                                         AND cogefein >= ('&FECHA_INICIAL')
                                                         AND cogefefi <= ('&FECHA_FINAL'))) c,
               open.ic_clascore p, open.ic_clascont h
         WHERE dcrcecrc = c.ecrccons
           AND dcrcclcr = p.clcrcons
           AND p.clcrclco = h.clcocodi
           AND (dcrccuco LIKE '1110%' OR dcrccuco like '147065%' OR dcrccuco LIKE '%110501%'))
-- where Cod_Entidad in (19) --
--         Cod_Clasificador = 50 --
GROUP BY Fecha_Contable, Cod_Entidad, Desc_Entidad, Cod_Clasificador, Desc_Clasificador
