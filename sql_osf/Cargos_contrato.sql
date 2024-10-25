select a.cargcuco,
       a.cargconc,
       c.concdesc,
       a.cargnuse,
       a.cargcaca,
       a.cargsign,
       s.signdesc,
       a.cargpefa,
       a.cargvalo,
       a.cargvabl,
       a.cargdoso,
       a.cargcodo,
       a.cargusua,
       a.cargtipr,
       a.cargunid,
       a.cargfecr,
       a.cargprog,
       a.cargcoll,
       a.cargpeco,
       a.cargtico,
       a.cargtaco
  from open.cargos a
  left join open.concepto c
    on c.conccodi = a.cargconc
  left join open.SIGNO s
    on s.signcodi = a.cargsign
  left join open.cuencobr cc
    on cc.cucocodi = cc.cucocodi
   and cc.cucosacu > 0
 where a.cargnuse in
       (select s.sesunuse from open.servsusc s where s.sesususc in (39813))
--and a.cargfecr > '14/08/2024'
 order by a.cargfecr desc;
