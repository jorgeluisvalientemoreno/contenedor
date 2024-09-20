select  
    2014 ano, 1 Mes, 'Inicial' Des_Mes, 
    cargtipr, 
    cargfecr, 
    case 
      when cargtipr = 'A' then 
          (select factfege  
            from open.cuencobr, open.factura  
              where cargcuco = cucocodi  
              and cucofact = factcodi) 
      else  cargfecr end fechamovimiento,         
    cargconc, 
    OPEN.pktblconcepto.fsbgetconcdesc(cargconc) DESC_CONCEPTO, 
    cargsign, 
    cargcaca, 
    Decode(cargcaca,NULL,'''',OPEN.dacauscarg.fsbgetcacadesc(cargcaca)) CAUSA, 
    decode(cargsign,'DB',cargvalo,-cargvalo) valor, 
    cargcodo, cargdoso,cargcuco 
  from open.cargos c 
  where cargnuse = 50293403 
  and cargfecr < '09/02/2015 00:00:00' 
union 
select  
    cicoano ano, cicomes Mes, to_char(to_date(to_char(CICOMES),'mm'),'Month') Des_Mes, 
    cargtipr, 
    cargfecr, 
    case 
      when cargtipr = 'A' then 
          (select factfege  
            from open.cuencobr, open.factura  
              where cargcuco = cucocodi  
              and cucofact = factcodi) 
      else  cargfecr end fechamovimiento,         
    cargconc, 
    OPEN.pktblconcepto.fsbgetconcdesc(cargconc) DESC_CONCEPTO, 
    cargsign, 
    cargcaca, 
    Decode(cargcaca,NULL,'''',OPEN.dacauscarg.fsbgetcacadesc(cargcaca)) CAUSA, 
    decode(cargsign,'DB',cargvalo,-cargvalo) valor, 
    cargcodo, cargdoso,cargcuco 
  from open.cargos c, open.ldc_ciercome 
  where cargnuse = 50293403 
  and cargfecr >= '09/02/2015 00:00:00' 
    and cargfecr between cicofein and cicofech 
  order by cargfecr
