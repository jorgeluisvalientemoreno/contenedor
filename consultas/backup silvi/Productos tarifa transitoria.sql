select prttsesu "Producto",
       prttfein "Fecha Ingreso",
       prttacti "Flag",
       prttcicl "Ciclo",
       prttfefi "Fecha final",
       prttsoli "Solicitud_Retiro",
       prttusua "Usuario",
       prttterm "Terminal"
from open.ldc_prodtatt l
where prttsesu in (51988760,
6128938,
6138133,
50557358)
