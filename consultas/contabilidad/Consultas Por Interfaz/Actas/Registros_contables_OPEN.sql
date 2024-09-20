-- CONSULTA OPEN
SELECT * FROM open.ic_decoreco dc
 WHERE dcrcecrc in (select ec.ecrccons from open.ic_encoreco ec 
                     where ec.ECRCCOGE in(select cogecons from open.ic_compgene c 
                                           where c.cogecoco = 4 -- actas
                                             and cogefein = '06-04-2016') -- Fecha de factura
                   )
   AND dcrcinad like '%|2307||E||%';
------   
select ec.ecrccons from open.ic_encoreco ec 
 where ec.ECRCCOGE in(select cogecons from open.ic_compgene c where c.cogecoco = 4 and cogefein = '06-04-2016')
