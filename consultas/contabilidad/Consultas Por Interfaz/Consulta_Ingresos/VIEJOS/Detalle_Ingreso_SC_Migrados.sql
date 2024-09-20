-- INgreso Servicios Cumplidos
select m.invmsesu, m.invmconc, c.concdesc, m.invmvain
  from open.Ldci_Ingrevemi m, open.concepto c
 where m.invmsesu in (SELECT hcecnuse
                        FROM open.hicaesco h
                       WHERE hcececan = 96
                         AND hcececac = 1
                         AND hcecserv = 7014
                         AND hcecfech >= '09-02-2015' and hcecfech < '01-03-2015'
                         AND open.dapr_product.fnugetproduct_status_id (h.hcecnuse) = 1)
--   and m.invmsesu = p.product_id
   and m.invmconc = c.conccodi
