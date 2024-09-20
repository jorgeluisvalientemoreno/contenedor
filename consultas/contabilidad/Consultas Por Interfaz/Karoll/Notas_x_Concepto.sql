-- Notas x Concepto
select substr(cargdoso, 1, 2) Tipo, cargcaca, cargsign, cargconc, o.concdesc, cargcaca, 
       sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)) valor
  from open.cargos c, open.servsusc s, open.concepto o
where cargnuse = sesunuse
  and sesuserv = 7056
  and cargfecr >= '01-05-2015'
  and cargfecr <  '01-06-2015'
  and cargsign not in ('PA','SA','AP','AS','NS','DV','TS','ST')   
  and cargconc = conccodi
  and cargcaca not in (20,23,46,50,51,56,58,73,19, 2)   
  and cargtipr = 'P'
Group by substr(cargdoso, 1, 2), cargcaca, cargsign, cargconc, o.concdesc, cargcaca;
