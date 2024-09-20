--SAFAVALO es el saldo a favor que queda luiego de la aplicacion de un pago
select * from open.saldfavo, open.servsusc
where safaorig = 'PA'
and   safafecr >= to_date('01/03/2015','dd/mm/yyyy')
and   safafecr <  to_date('01/04/2015','dd/mm/yyyy')
and   sesunuse = safasesu
and   sesuserv = 7014;

-- La suma de los MOSFVALO es el SA que está pendiente por aplicar.  LO que se va aplicando está con valor negativo.
select * from open.movisafa, open.saldfavo, open.servsusc
where safaorig = 'PA'
and   safafecr >= to_date('01/03/2015','dd/mm/yyyy')
and   safafecr <  to_date('01/04/2015','dd/mm/yyyy')
and   sesunuse = safasesu
and   sesuserv = 7056
and   mosfsafa = safacons;
