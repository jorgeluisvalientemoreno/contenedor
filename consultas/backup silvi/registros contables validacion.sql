SELECT dc.*, open.ldci_pkinterfazsap.fvaGetData(46, DCRCINAD, '|') item
 FROM open.ic_decoreco dc
 WHERE dcrcecrc in (select ec.ecrccons from open.ic_encoreco ec
                     where ec.ECRCCOGE in (select cogecons from open.ic_compgene c
                                            where c.cogecoco = -- 4  -- Comprobante de GDCA.
                                                                72 -- Comprobante actas Guajira
                                              and cogefein >= '28/07/2025') -- Fecha de factura
                   )
   AND dcrcinad like '%|250592||%';
