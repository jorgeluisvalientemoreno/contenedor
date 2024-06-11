select v.vvfcvafc "Variable",v.vvfcubge "Capital",
(select  valor  from ldc_templocfaco e where e.capital=5 and e.temp_ano=2023 and   estado_apro = 'P') "Valor_ingresado",
 SUM( v.vvfcvalo ) "SumaValtemp",
 ((select  valor  from ldc_templocfaco e where e.capital= 5 and e.temp_ano=2023 and   estado_apro = 'P') + SUM( v.vvfcvalo ))/ (1+ COUNT(1) ) "Valor promedio" ,
  COUNT(1) "CantidadValtemp" 
    from cm_vavafaco v
    where v.vvfcvafc = 'TEMPERATURA'
    and v.vvfcubge in (5)
    and v.vvfcfefv >= sysdate - 60
    group by v.vvfcvafc,v.vvfcubge;