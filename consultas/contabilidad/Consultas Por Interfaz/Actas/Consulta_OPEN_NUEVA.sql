-- CONSULTA OPEN
select dcrccuco, dcrcsign, dcrcvalo, dcrcinad, item,
       titr, (select tt.clctclco from open.ic_clascott tt where tt.clcttitr = titr) clasi, dcrcclcr
  from (       
          SELECT dc.*, 
                 open.ldci_pkinterfazsap.fvaGetData(46, DCRCINAD, '|') item, 
                 open.ldci_pkinterfazsap.fvaGetData(39, DCRCINAD, '|') Titr 
            FROM open.ic_decoreco dc
           WHERE dcrcecrc in (select ec.ecrccons from open.ic_encoreco ec 
                               where ec.ECRCCOGE in(select cogecons from open.ic_compgene c 
                                                     where c.cogecoco = 4 -- actas
                                                       and cogefein = '09-06-2016') -- Fecha de factura
                             )
             AND dcrcinad like '%|0686||E||%'
       )
