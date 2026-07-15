Select PRODUCTO, 
       CONTRATO, 
      -- open.dage_geogra_location.fsbgetdescription(open.daab_address.fnugetgeograp_location_id(address_id)) Localidad,
       pefacicl Ciclo, 
       pefaano Ano, 
       pefames Mes, 
       PERIODO_FACTURACION,
       PERIODO_CONSUMO,
       CASE WHEN CONSUMO_PROMEDIO - (DESVIACION_POBLACIONAL *3)  < 0 THEN 0
         ELSE CONSUMO_PROMEDIO - (DESVIACION_POBLACIONAL *3) END Rango_Inferior,
       CONSUMO_PROMEDIO + (DESVIACION_POBLACIONAL *3)  Rango_Superior,
       CONSUMO_ACTUAL,
       CONSUMO_PROMEDIO,
       DESVIACION_POBLACIONAL,
       decode (TIPO_DESVIACION, 'N', 'N-NORMAL', 'A', 'A-AUMENTO', 'D-DISMINUCION') TIPO_DESVIACION,
       CALIFICACION REGLA,
       FECHA_REGISTRO,
       product_status_id,
       --open.daps_product_status.fsbgetdescription(product_status_id, null) desc_estado_prod,
       (select sum( case when (s.inactive_date > c.pecsfecf or (s.inactive_date is null and s.active='Y')) then c.pecsfecf else s.inactive_date end  -   case when s.aplication_date < c.pecsfeci then c.pecsfeci else s.aplication_date end )
          from open.pr_prod_suspension s 
         where  s.product_id  = dp.producto 
           and (((s.inactive_date <= c.pecsfecf and s.inactive_date>=c.pecsfeci) or (s.inactive_date is null and s.active='Y'))  
           and  (s.aplication_date >=c.pecsfeci and s.aplication_date<=c.pecsfecf))
       )
from open.info_producto_desvpobl dp
inner join open.perifact on pefacodi = Periodo_Facturacion --and pefacicl in (:ciclo) and pefaano=:a?o and pefames=:mes
inner join open.pr_product on dp.producto = product_id
inner join open.pericose c on c.pecscons=dp.periodo_consumo 
where Estado = 'A'
