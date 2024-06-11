with basic as ( select :producto contrato , :periodo periodo from dual)
,cargos1 as ( select sesususc , sum(sumatoria)*0.25 "Valor a trasladar" 
      from (select sesususc , sesunuse  , 
      decode(cargsign, 'DB', cargvalo, -cargvalo) sumatoria
      from cargos
      left join servsusc on cargnuse = sesunuse 
      where sesususc  = (select contrato from basic)
      and cargpefa= (select periodo from basic)
      and cargconc in (31, 130 , 196, 167 )
      and cargcaca in (15,59))
    group by sesususc)  ,
 diferidos as ( select sum(difesape) saldo_pend
               from open.diferido d
               left join open.cc_grace_peri_defe  gp on gp.deferred_id = d.difecodi
               left join open.cc_grace_period  pc on pc.grace_period_id = gp.grace_period_id
               where difesape > 0 
               and difesusc in (select contrato from basic)
               and gp.end_date > sysdate
               and gp.end_date  = ( select max (gp2.end_date ) from cc_grace_peri_defe gp2 where  gp2.deferred_id = d.difecodi))  ,
info_final as ( select sesususc "Contrato" , "Valor a trasladar" , (select saldo_pend from diferidos)  "Saldo pendiente"  from cargos1) 
select *
from info_final ;
 
