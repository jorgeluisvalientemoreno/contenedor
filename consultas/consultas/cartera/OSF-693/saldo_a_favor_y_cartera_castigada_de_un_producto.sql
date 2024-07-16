select sum(decode(cargos.cargsign,'CR',cargos.cargvalo,'DB',-cargos.cargvalo))  "Cartera castigada", 
       servsusc.sesusafa  "Saldo a favor", 
       fvalidasaldofavor(1183081)  "Saldo a favor mayor a Cartera"
from open.cargos     
inner join open.servsusc on servsusc.sesunuse = cargos.cargnuse
where cargos.cargnuse = 1183081
and cargos.cargcaca in (2,58)
group by servsusc.sesusafa;