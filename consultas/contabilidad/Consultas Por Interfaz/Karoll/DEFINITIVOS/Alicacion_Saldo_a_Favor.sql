-- Aplicacion Saldo a Favor x Notas y Recaudo.
select substr(cargdoso, 1, 2) Tipo, cargcaca, cargsign, cargconc, o.concdesc, 
       sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)) valor
  from open.cargos c, open.servsusc s, open.concepto o
 where cargnuse = sesunuse
   and sesuserv = 7056
   and cargfecr >= '01-05-2015'
   and cargfecr <  '01-06-2015'
   and cargsign in ('AS')   
   and cargconc = conccodi
Group by substr(cargdoso, 1, 2), cargcaca, cargsign, cargconc, o.concdesc;
