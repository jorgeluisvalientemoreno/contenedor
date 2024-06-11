select count (pp.saresesu)
  from ldc_susp_autoreco_jc pp
  inner join servsusc ss on pp.SARESESU = ss.sesunuse
  left join pr_prod_suspension ps on pp.SARESESU = ps.product_id
  left join pericose  pc1 on pc1.pecscico = ss.sesucico --and ps.aplication_date between pc1.pecsfeci and pc1.pecsfecf
  left join cargos c2 on c2.cargnuse = ss.sesunuse and c2.cargpeco = pc1.pecscons
  left join confesco  ec on ec.coecserv = ss.sesuserv and ss.sesuesco = ec.coeccodi
 Where ss.sesuesco in (select ec.coeccodi from confesco  ec  where ec.coecserv = ss.sesuserv and ec.coeccodi =ss.sesuesco and ec.coecfact = 'S')
    and c2.cargconc = 31
   and   c2.cargcaca in (1,4,15,60)
   and   c2.cargcuco > 0
   and active = 'Y'
   and ec.coecfact = 'S'
