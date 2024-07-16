select (48189 - 10000)  "Cartera calculada",
       (select sum(decode(cargos.cargsign,'CR',cargos.cargvalo,'DB',-cargos.cargvalo))
       from open.cargos
       where cargos.cargnuse = 1183081
       and cargos.cargcaca in (2,58))  "Cartera castigada"
from dual