select cucofact "Factura",
        cargpefa "Periodo fact",
        cucocodi "Cuenta de cobro",
        sesususc "Contrato",
        cuconuse "Producto",
        sesuserv "Tipo producto",
        cucovato "Valor total" , cucovare "Valor en reclamo"
 from open.cuencobr
 left join open.servsusc on cuconuse = sesunuse
 left join open.cargos on cucocodi = cargcuco
 where sesususc  = 67402861 and cucosacu>0
  group by   cucofact ,cargpefa ,cucocodi,sesususc, cuconuse,sesuserv  , cucovato,cucofeve,cucovare,cucosacu;
  
  