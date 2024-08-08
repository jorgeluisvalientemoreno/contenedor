select *
from cuencobr  c
where c.cucosacu <0
and rownum <= 50;

select br2.cuconuse, s.sesususc, s.sesuserv, (sum(br2.cucosacu) - sum(br2.cucovare) - sum(br2.cucovrap))
from  cuencobr br2
inner join servsusc  s  on s.sesunuse = br2.cuconuse
     where /*((*/br2.cucosacu/*) - (br2.cucovare) - (br2.cucovrap))*/<0
     and rownum<= 3
     group by br2.cuconuse, s.sesususc, s.sesuserv ;
     
