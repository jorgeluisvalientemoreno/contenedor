select c.contrato, c.producto, deuda_no_corriente
  from open.ldc_osf_sesucier c
 where 1 = 1
   and c.nuano = 2025
      --and c.numes = 1
      --and c.producto = inunuse
   and deuda_no_corriente > 0;

select d.producto, (total_corriente + total_diferido) Deuda_Total
  from (Select b.sesunuse producto, sum(nvl(cucosacu, 0)) total_corriente
          from open.cuencobr a,
               (Select b.sesunuse
                  from open.servsusc b
                 where b.sesuserv = 7014
                   and b.sesuesfn = 'M') b
         where a.cuconuse = b.sesunuse
           and nvl(a.cucosacu, 0) > 0
         group by b.sesunuse) d,
       (select difenuse producto, sum(nvl(difesape, 0)) total_diferido
          from open.diferido
         group by difenuse) c
 where c.producto = d.producto
