--cueunta de cobro
select c.*
  from open.cuencobr cc,
       open.servsusc ss,
       open.cargos   c,
       open.factura  f,
       open.perifact pf
 where ss.sesunuse = cc.cuconuse
   and c.cargcuco = cc.cucocodi
   and cc.cucofact = f.factcodi
   and f.factpefa = pf.pefacodi
   --and cc.cuconuse = 1647492
   and cc.cucocodi = 1128417898
   --and c.cargfecr >= '01/01/2022'
 order by 1 desc;
