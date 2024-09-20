-- Conexiones mes
SELECT distinct hcecnuse, 
       decode((select distinct 1 from open.Ldci_Ingrevemi where invmsesu = hcecnuse), 1, 'MIGRADO', null) ESTADO
 FROM open.hicaesco h
WHERE hcececan = 96
  AND hcececac = 1
  AND hcecserv = 7014
  AND hcecfech >= '01-04-2015' and hcecfech < '01-05-2015'
  AND open.dapr_product.fnugetproduct_status_id (h.hcecnuse) = 1
