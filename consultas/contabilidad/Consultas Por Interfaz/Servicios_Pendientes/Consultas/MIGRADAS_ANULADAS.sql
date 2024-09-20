-- MIGRADAS ANULADAS
SELECT * from open.ldci_ingrevemi m 
 where m.invmsesu in (SELECT distinct hcecnuse FROM open.hicaesco h
                       WHERE hcececac in (/*5,95,*/110)
                         AND hcecserv = 7014
                         AND hcecfech >= '09-02-2015' and hcecfech < '01-06-2015');
                        
-- ANULADAS CONSTRUCTORAS
SELECT * FROM open.hicaesco h
 WHERE hcececac = 110
   AND hcecserv = 7014
   AND hcecfech >= '09-02-2015' and hcecfech < '01-06-2015'
   and h.hcecnuse in (select a.product_id from open.or_order_activity a, open.mo_packages p
                       where a.product_id = h.hcecnuse
                         and a.package_id = p.package_id
                         and p.package_type_id = 323);                        
