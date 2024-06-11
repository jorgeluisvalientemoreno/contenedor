 select cucofact "Factura",
        cargpefa "Periodo fact",
        cucocodi "Cuenta de cobro",
        sesususc "Contrato",
        cuconuse "Producto",
        sesuserv "Tipo producto",
        cucovato "Valor total"
 from cuencobr 
 left join servsusc on cuconuse = sesunuse
 left join cargos on cucocodi = cargcuco
 where cuconuse= 52577259
 and cargpefa= 103794
 and cargcuco= 3033799911
 group by   cucofact ,cargpefa ,cucocodi,sesususc, cuconuse,sesuserv  , cucovato 