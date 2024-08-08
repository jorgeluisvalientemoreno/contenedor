select (800000 - 532387)  "Saldo a favor calculado",
       (select servsusc.sesusafa
       from open.servsusc
       where servsusc.sesunuse = 1183081)  "Saldo a favor"
from dual;