select * from open.ge_acta a where a.id_acta = 136223;
select * from open.ldci_actacont a where a.idacta = 136223;
select * from open.ldci_detaintesap l where l.cod_interfazldc = 35506;
-- CONSULTA OPEN
select dcrccuco, dcrcsign, dcrcvalo, dcrcinad, 
       item, (select ge.description from open.ge_items ge where ge.items_id = item) desc_item,
       titr, (select tt.clctclco from open.ic_clascott tt where tt.clcttitr = titr) clasi, dcrcclcr,
       To_Number(open.ldci_pkinterfazsap.fvaGetData(33,dcrcinad,'|')) Base
  from (       
          SELECT dc.*, 
                 open.ldci_pkinterfazsap.fvaGetData(46, DCRCINAD, '|') item, 
                 open.ldci_pkinterfazsap.fvaGetData(39, DCRCINAD, '|') Titr,
                 open.ldci_pkinterfazsap.fvaGetData(46,dcrcinad, '|')
            FROM open.ic_decoreco dc
           WHERE dcrcecrc in (select ec.ecrccons from open.ic_encoreco ec 
                               where ec.ECRCCOGE in(select cogecons from open.ic_compgene c 
                                                     where c.cogecoco = 4 -- actas
                                                       and cogefein >= '23-11-2020') -- Fecha de factura
                             )
             AND dcrcinad like '%|0162||E||%'
          --   and dcrccuco like '2436950%00'
       )
