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
