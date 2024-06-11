select (select nvl(c.cargvalo* (10 / 100),0)
        from open.cargos  c
        where c.cargcuco = 1098724926
        and c.cargconc in (30)
        and c.cargcaca = 50) as "10% DE LA INTERNA", 
       (select nvl(sum(d.difevatd),0)
        from open.diferido d
        left join open.plandife  pd on d.difepldi = pd.pldicodi
        left join open.cc_grace_period  pc on pc.grace_period_id = pd.pldipegr
        left join open.cc_grace_peri_defe  pg on pg.deferred_id = d.difecodi
        where d.difenuse = 1569214
        and d.difeconc = 781) as "VALOR DEL DIFERIDO" 
from dual;