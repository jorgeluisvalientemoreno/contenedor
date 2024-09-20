-- Ingreso Ventas Migradas
SELECT distinct invmsesu
from open.Ldci_Ingrevemi m
where m.invmsesu in (SELECT distinct hcecnuse
                       FROM open.hicaesco h
                      WHERE hcececan = 96
                        AND hcececac = 1
                        AND hcecserv = 7014
                        AND hcecfech >= '01-04-2015' and hcecfech < '01-05-2015'
                        /*AND open.dapr_product.fnugetproduct_status_id (h.hcecnuse) = 1*/)
