-- Consulta causal 23 KAROL Q.
select ca.cargcuco, ca.cargnuse, ca.cargconc, ca.cargcaca, ca.cargsign, ca.cargvalo, ca.cargdoso,
       (select distinct(cg.cargcuco) from open.cargos cg
         where cg.cargcuco = substr(ca.cargdoso, 6, 10) and substr(cg.cargdoso, 6, 10) = ca.cargcuco) cuco_tras,
       (select distinct(cg.cargnuse) from open.cargos cg where cg.cargcuco = substr(ca.cargdoso, 6, 10)) nuse_tras,
       (select distinct(cg.cargconc) from open.cargos cg 
         where cg.cargcuco = substr(ca.cargdoso, 6, 10) and cg.cargconc = ca.cargconc and cg.cargcaca = 23) conc_tras,
       (select sum(cg.cargvalo) from open.cargos cg 
         where cg.cargcuco = substr(ca.cargdoso, 6, 10) and substr(cg.cargdoso, 6, 10) = ca.cargcuco and cg.cargconc = ca.cargconc
           and cg.cargcaca = 23 and cargsign = 'DB') valo_tras
  from open.cargos ca, open.servsusc s, open.concepto o--, open.causcarg g
 where ca.cargnuse = sesunuse
   and sesuserv = 7056
   and ca.cargfecr >= '01-08-2015'  and ca.cargfecr < '01-09-2015'
   and ca.cargtipr = 'P'    
   and ca.cargconc = conccodi and ca.cargcaca = 23
   and ca.cargdoso like 'TC%' and ca.cargsign = 'CR';
