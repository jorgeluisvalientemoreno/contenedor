SELECT dc.*
  FROM open.ic_decoreco dc
 WHERE dcrcecrc in (select ec.ecrccons from open.ic_encoreco ec 
                     where ec.ECRCCOGE in(select cogecons from open.ic_compgene c 
                                           where c.cogecoco = 3 -- Control Reintegro
                                             and cogefein >= '30-06-2023') -- Fecha de factura
                   )


