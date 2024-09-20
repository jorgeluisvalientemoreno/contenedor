SELECT 'HE' Tipo, c.concclco Clasi, t.clcodesc Des_Clasi, '2905900000' Cuenta, sum(decode(movisign, 'D', movivalo, -movivalo)) Total
  FROM open.ic_movimien m, open.concepto c, open.ic_clascont t
 WHERE m.movitido = 72
   and m.movifeco >= '&FECHA_INICIAL' 
   and movifeco   <= '&FECHA_FINAL'
   and m.moviconc is not null
   and m.moviconc = c.conccodi
   and t.clcocodi = c.concclco
   and m.moviserv = 7056
Group by c.concclco, t.clcodesc 
---
union
--
select 'RC' Tipo, Cod_Clasificador Clasi, Des_Clasificador Des_Clasi, cuenta, valor
from (
SELECT h.clcocodi Cod_Clasificador,
       h.clcodesc Des_Clasificador,
       DCRCCUCO Cuenta,
       sum(DECODE(dcrcsign, 'D', dcrcvalo, -dcrcvalo)) VALOR
  FROM OPEN.IC_DECORECO,
       (SELECT *
          FROM OPEN.IC_ENCORECO
         WHERE ECRCCOGE IN
               (SELECT COGECONS
                  FROM OPEN.IC_COMPGENE
                 WHERE COGECOCO IN (SELECT COD_COMPROBANTE FROM open.LDCI_TIPOINTERFAZ WHERE TIPOINTERFAZ ='L2')
                   AND COGEFEIN >= '&FECHA_INICIAL'||' 00:00:00'
                   AND COGEFEFI <= '&FECHA_FINAL'||' 23:59:59')) C,
       open.ic_clascore p,
       open.ic_clascont h
 WHERE DCRCECRC = C.ECRCCONS
   AND DCRCCLCR = p.clcrcons
   AND p.clcrclco = h.clcocodi
   and h.clcocodi in (2,6,46,49,56,58,60,81,98,99,102,103,121)
   and DCRCCUCO like '29%'
group by h.clcocodi, h.clcodesc, DCRCCUCO
)
where valor < 0
