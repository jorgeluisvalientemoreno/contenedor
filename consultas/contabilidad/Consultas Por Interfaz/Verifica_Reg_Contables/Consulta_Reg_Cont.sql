SELECT dcrccuco,
       clcrclco,
       clcodesc,
       substr(dcrcinad,instr(dcrcinad, '|&Factura||E||', 1, 1)+ length('|&Factura||E||'),length(dcrcinad))  item,
       sum(decode(dcrcsign,'C',dcrcvalo, -dcrcvalo)) valor
 FROM OPEN.ic_decoreco, OPEN.ic_clascore , OPEN.ic_clascont
WHERE dcrcecrc in (select IE.ECRCCONS from open.ic_encoreco IE where ie.ecrcfech = '26-05-2016' and ecrccoco = 4/* 4 = Actas */) 
  AND dcrcinad like '%|&Factura||E||%' --
  AND clcrcons = dcrcclcr
  AND clcrclco = clcocodi
GROUP BY dcrccuco, clcrclco, clcodesc,
         substr(dcrcinad,instr(dcrcinad, '|&Factura||E||', 1, 1)+ length('|&Factura||E||'),length(dcrcinad))
