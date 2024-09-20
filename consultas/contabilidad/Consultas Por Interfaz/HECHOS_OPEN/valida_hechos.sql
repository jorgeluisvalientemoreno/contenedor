SELECT * FROM ic_movimien, ic_docugene
 WHERE movitido  = 71 AND movitimo=1 AND MOVITIDO=dogetido AND   MOVINUDO = dogenudo
AND dogefemo > '01-01-2016'
and MOVITIHE = 'CE' AND rownum = 1;
--
SELECT /*+ IX_IC_MOVIMIEN02 */ *
  FROM open.ic_movimien
 WHERE movifeco  > '01-04-2016'
   and movitido  = 71 
   AND movitimo  = 1 
   and MOVITIHE  = 'CE' AND rownum = 1
