select * from open.cuencobr c where c.cucocodi = 3034262032;
select * from open.cargos where cargcuco = 3034262032;
select * from open.saldfavo s where s.safasesu = 51195617;
select * from open.movisafa m where m.mosfsesu = 51195617;
select * from open.ldc_prodtatt l where prttsesu = 51195617;
select * from open.ldc_deprtatt d where dpttsesu = 51195617;


select prttsesu "Producto",
       prttfein "Fecha Ingreso",
       prttacti "Flag",
       prttcicl "Ciclo",
       prttfefi "Fecha final",
       prttsoli "Solicitud_Retiro",
       prttusua "Usuario",
       prttterm "Terminal"
from open.ldc_prodtatt l 
where prttsesu = 6563999;

select s.safasesu "Producto" , s.safadocu "Documento_origen" , s.safafech "Fecha saldo", s.safafecr "Fecha creacion", s.safavalo "Valor"
from open.saldfavo s 
where s.safasesu = 1162796 
and safafecr >= '09/05/2023' ;

select * from open.movisafa m where m.mosfsesu = 1162796 and mosffecr >='09/05/2023' ;
