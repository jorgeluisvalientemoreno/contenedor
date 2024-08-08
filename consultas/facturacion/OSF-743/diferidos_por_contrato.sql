select difesusc,
      difenuse ,
      sesuserv || ' ' || servdesc tipo_producto ,
      difecodi ,
      difeconc,
      concdesc ,
      difesape ,
      difenucu - difecupa cuot_pendientes,
       difecupa , difefein ,  difepldi , difeprog
from diferido
left join  open.servsusc on difesusc = sesususc and difenuse= sesunuse
left join servicio on servcodi = sesuserv
left join LDC_CONCGRVF on cogrcodi = difeconc 
left join concepto on conccodi = difeconc 
where difesusc = 48057957
and  difesape > 0
and sesuserv = 7055
and sesucicl in (787)
and difeconc not in (832)