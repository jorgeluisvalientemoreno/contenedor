--validar_periodo_de_facturaci�n
select f.pefacodi,
       f.pefaano,
       f.pefames,
       f.pefafimo,
       f.pefaffmo,
       f.pefacicl,
       f.pefaactu
  from open.perifact f
 where  pefacicl in (1801)
 and pefaano >= 2024
 order by f.pefaffmo desc
