select difesusc,
      difenuse ,
      sesuserv || ' ' || servdesc tipo_producto ,
      difecodi ,
      difeconc,
      concdesc ,
      difesape ,
      difenucu - difecupa cuot_pendientes,
       difecupa , difefein ,  difepldi , difeprog, grupcodi
from open.diferido
left join  open.servsusc on difesusc = sesususc and difenuse= sesunuse
left join open.servicio on servcodi = sesuserv
left join open.LDC_CONCGRVF on cogrcodi = difeconc 
left join open.concepto on conccodi = difeconc 
where difesape > 0
and difesusc = 1503707
--and difeconc in (895)
and sesucicl in (101)
--and sesuserv = 7055 
--and sesuserv = 7055
--and difecupa = 0
--and grupcodi = 16
--and difeconc  in (832,895,936) 
--and difepldi  in (111,110,113)
/*and sesuserv  = 7055
and sesucicl in (787)
and difeconc = 895
and sesuesfn <> 'C'*/
--and difenuse = 50516730
--and difecupa = 0 
--and trunc(difefein) >= '25/08/2022'
--and difenuse = 50962001
--and difepldi not in (111,110,113)
--and difeprog not like '%GCNED%'
