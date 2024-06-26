select cc.cuconuse, sum(cc.cucosacu)
  from cuencobr cc
having sum(cc.cucosacu) > 0
 group by cc.cuconuse
