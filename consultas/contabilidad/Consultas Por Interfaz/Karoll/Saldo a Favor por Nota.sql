-- Saldo a Favor x Notas.
select substr(cargdoso, 1, 2) Tipo, cargcaca, cargsign, cargconc, o.concdesc, 
       sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)) valor
  from open.cargos c, open.servsusc s, open.concepto o
 where cargnuse = sesunuse
   and sesuserv = 7055
   and cargfecr >= '01-04-2015'
   and cargfecr <  '01-05-2015'
   and cargsign in ('SA')   
   and substr(cargdoso, 1, 2) not in ('PA')
   and cargconc = conccodi
   and cargtipr = 'P'
Group by substr(cargdoso, 1, 2), cargcaca, cargsign, cargconc, o.concdesc;
