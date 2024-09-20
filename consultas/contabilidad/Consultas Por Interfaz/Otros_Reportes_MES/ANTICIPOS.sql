select distinct h.hcecnuse from open.hicaesco h
 where h.hcecnuse in (select cargnuse from open.cargos c where cargconc =  301 and cargfecr >= '09-02-2015')
   and h.hcececac != 1;

select * 
  from open.cargos c--, (select distinct(h.hcecnuse) from open.hicaesco h where h.hcececac != 1) h
 where cargconc =  301 and cargfecr >= '09-02-2015' and cargfecr < '01-07-2015' and cargsign = 'SA'
   and open.dapr_product.fnugetproduct_status_id (cargnuse) != 15;
   
select * 
  from open.cargos c--, (select distinct(h.hcecnuse) from open.hicaesco h where h.hcececac = 1) h
 where cargconc =  301 and cargfecr >= '09-02-2015' and cargfecr < '01-07-2015' and cargsign = 'SA'
   and open.dapr_product.fnugetproduct_status_id (cargnuse) = 15;
 
select * from open.cargos c where cargconc = 301 and cargsign = 'SA' and cargfecr >= '09-02-2015' and cargfecr < '01-07-2015';
