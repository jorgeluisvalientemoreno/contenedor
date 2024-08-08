select SESUNUSE "Producto" , CARGPEFA "periodo fact", ps.aplication_date "fecha susp",CARGPECO  "periodo cons", pecsfeci "fecha inicial consumo"  ,pecsfecf  "fecha final consumo" , c2.cargunid  "Consumo_suspension",
       (select sum(c3.cargunid) from cargos c3 
        where c3.cargnuse = ss.sesunuse and c3.cargpeco in (select pc4.pecscons from pericose pc4 where pc4.pecscico = ss.sesucico and pc4.pecsfecf > pc1.pecsfecf) and c3.cargconc = 31
         and   c3.cargcaca in (1,4,15,60)  and   c3.cargcuco > 0)  "Suma_consumo_posteriores",
    case when (select sum(c3.cargunid) from cargos c3 
        where c3.cargnuse = ss.sesunuse and c3.cargpeco in (select pc4.pecscons from pericose pc4 where pc4.pecscico = ss.sesucico and pc4.pecsfecf > pc1.pecsfecf) and c3.cargconc = 31
         and   c3.cargcaca in (1,4,15,60)  and   c3.cargcuco > 0) > 5 then 'SI' 
           when (select sum(c3.cargunid) from cargos c3 
        where c3.cargnuse = ss.sesunuse and c3.cargpeco in (select pc4.pecscons from pericose pc4 where pc4.pecscico = ss.sesucico and pc4.pecsfecf > pc1.pecsfecf) and c3.cargconc = 31
         and   c3.cargcaca in (1,4,15,60)  and   c3.cargcuco > 0) <= 5 then 'NO'  end as "Autoreconectado"
  from ldc_susp_autoreco_jc2 pp
  inner join servsusc ss on pp.saresesu = ss.sesunuse
  left join pr_prod_suspension ps on pp.saresesu = ps.product_id
  left join pericose  pc1 on pc1.pecscico = ss.sesucico and ps.aplication_date between pc1.pecsfeci and pc1.pecsfecf
  left join cargos c2 on c2.cargnuse = ss.sesunuse and c2.cargpeco = pc1.pecscons
  left join confesco  ec on ec.coecserv = ss.sesuserv and ss.sesuesco = ec.coeccodi
 Where /*ss.sesuesco in (select ec.coeccodi from confesco  ec  where ec.coecserv = ss.sesuserv and ec.coeccodi =ss.sesuesco and ec.coecfact = 'S')
    and */ c2.cargconc = 31
   and   c2.cargcaca in (1,4,15,60)
   and   c2.cargcuco > 0
   and active = 'Y'
   and ec.coecfact = 'S'
   --and c2.cargnuse
