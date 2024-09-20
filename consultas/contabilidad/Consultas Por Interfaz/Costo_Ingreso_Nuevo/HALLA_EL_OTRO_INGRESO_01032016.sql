select * --sum(cargvalo)
 from open.cargos, open.cuencobr co, open.factura fa
where cargnuse = 4064316 and cargconc = 739 and cargcaca in (41,53) and cargsign = 'DB' -- OTROS_ING_OSF
  and cargcuco = cucocodi  and cucofact = fa.factcodi
  and fa.factfege >= '&FECHA_INICIAL' and fa.factfege  <= '&FECHA_FINAL 23:59:59'
  and substr(cargdoso,4,10) in (select a.package_id from open.or_order_activity a, open.or_task_type tp
                                 where a.product_id = 4064316
                                   and a.task_type_id = tp.task_type_id
                                   and tp.concept = 739)
=========================================================
(case when concept is not null and
          (concept not in (19,30,291,674) or titr not in (10495,12149,12151,10622,10624,12150,12152,12153)) then
     (select sum(cargvalo) from open.cargos, open.cuencobr co, open.factura fa
      where cargnuse = product_id 
        and cargconc = concept 
        and cargcaca in (41,53) 
        and cargsign = 'DB'
        and cargcuco = cucocodi  
        and cucofact = fa.factcodi
        and fa.factfege >= '&FECHA_INICIAL' and fa.factfege <= '&FECHA_FINAL 23:59:59'
        and substr(cargdoso,4,10) in (select a.package_id from open.or_order_activity a, open.or_task_type tp
                                       where a.product_id = product_id
                                         and a.task_type_id = tp.task_type_id
                                         and tp.concept = concept)) end) Ing_Otro,
