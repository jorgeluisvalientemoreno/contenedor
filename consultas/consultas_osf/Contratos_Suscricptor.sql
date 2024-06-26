Select b1.sesunuse, sum(nvl(cucosacu, 0)) Total_Deuda
  from open.cuencobr a,
       (Select b.sesunuse
          from open.servsusc b
         where b.sesuserv = 7014
           and b.sesuesfn = 'M'
           and b.sesucate = 2) b1
 where a.cuconuse = b1.sesunuse
   and nvl(a.cucosacu, 0) > 0
 group by b1.sesunuse;
