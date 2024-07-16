select cc.cuconuse, sum(cc.cucosacu)
  from cuencobr cc
 having sum(cc.cucosacu) > 0
 group by cc.cuconuse;

select s.sesususc, cc.cuconuse, sum(cc.cucosacu)
  from cuencobr cc, servsusc s
 where cc.cuconuse = s.sesunuse and cc.cucofeve >sysdate -120 having sum(cc.cucosacu) > 0
 group by s.sesususc, cc.cuconuse
