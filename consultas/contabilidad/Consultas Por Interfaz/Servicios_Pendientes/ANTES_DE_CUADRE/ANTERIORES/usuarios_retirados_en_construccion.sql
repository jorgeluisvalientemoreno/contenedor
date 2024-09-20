-- USUARIOS RETIRADOS EN CONSTRUCCION
select h.hcecnuse from open.hicaesco h
 where h.hcececac = 96
   and h.hcececan = 1
   and h.hcecserv = 7014
   and h.hcecfech < '01-04-2015'
   and h.hcecnuse not in (select distinct hi.hcecnuse from open.hicaesco hi where hi.hcececac = 1
                             and hi.hcececan = 96 and hi.hcecserv = 7014
                             and hi.hcecfech < '01-04-2015' and hi.hcecnuse = h.hcecnuse)
   and open.dapr_product.fnugetproduct_status_id (hcecnuse) in (3, 9, 12);
-- Usuario castigado
select h.hcecnuse from open.hicaesco h
 where h.hcececac = 96
   and h.hcececan = 1
   and h.hcecserv = 7014
   and h.hcecfech < '01-04-2015'
   and h.hcecnuse not in (select distinct hi.hcecnuse from open.hicaesco hi where hi.hcececac = 1
                             and hi.hcececan = 96 and hi.hcecserv = 7014
                             and hi.hcecfech < '01-04-2015' and hi.hcecnuse = h.hcecnuse)
   and h.hcecnuse in (select cargnuse from open.cargos c 
                       where cargnuse = h.hcecnuse
                         and cargcaca = 2
                         and cargfecr > '09-02-2015')
 
