CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNCRECUFACTCICLO" (
                                                 depa NUMBER
                                                ,loca NUMBER
                                                ,cate NUMBER
                                                ,suca NUMBER
                                                ,ciclo NUMBER
                                                ,ano NUMBER
                                                ,mes NUMBER
                                                ,tipoprod number) RETURN NUMBER IS
 nuconta NUMBER DEFAULT 0;
BEGIN
SELECT /*+rule*/
       count(factcodi) into nuconta
  FROM factura f
      ,cuencobr c
      ,perifact pf
      ,servsusc
      ,pr_product p
      ,ab_address d
      ,ge_geogra_location l
      ,ge_geogra_location h
 WHERE sesuserv = tipoprod
   AND pf.pefacicl = ciclo
   AND pf.pefaano = ano
   AND pf.pefames = mes
   AND h.geograp_location_id = depa
   AND l.geograp_location_id = loca
   AND c.cucocate = cate
   AND c.cucosuca = suca
   AND f.factcodi = c.cucofact
   AND f.factpefa = pf.pefacodi
   AND cuconuse = sesunuse
   AND sesunuse = p.product_id
   AND p.address_id = d.address_id
   AND d.geograp_location_id = l.geograp_location_id
   AND l.geo_loca_father_id = h.geograp_location_id;
   return nuconta;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNCRECUFACTCICLO', 'ADM_PERSON');
END;
/