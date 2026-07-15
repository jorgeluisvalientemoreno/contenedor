with costo_mat_caribe as(
              select 'material' as tipo,
                     dlp.codigo_interfaz,
                     codigo_item, 
                     m.empresa, 
                     dlp.costo_items costo_interfaz, 
                     ROUND(dlp.costo_items * 1.19, 2) costo_interfaz_total,  
                     round(ROUND(dlp.costo_items * 1.19, 2) *1.25,2) precio_interfaz
              from ldci_intdetlistprec dlp
              join ldci_intelistpr m on m.codigo = dlp.codigo_interfaz and m.empresa='GDCA'
              where dlp.codigo_interfaz in (&interfaz_caribe)
 )
,costo_act_caribe as (
            select 'actividad' as tipo,
                   c.codigo_interfaz,
                   h.item_actividad codigo_item,
                   c.empresa,
                   c.costo_interfaz costo_interfaz,
                   round(costo_interfaz_total*1.06,2) costo_interfaz_Adm,
                   round(round(costo_interfaz_total*1.06,2)*1.25,2) precio_interfaz
            from costo_mat_caribe c
            join ldc_homoitmaitac h on h.empresa=c.empresa and h.item_material = c.codigo_item
)

, costo_mat_guajira as(
          select 'material' as tipo,
                 dlp.codigo_interfaz,
                 codigo_item,
                 m.empresa, 
                 dlp.costo_items costo_interfaz, 
                 ROUND(dlp.costo_items * 1.19, 2) costo,  
                 round(ROUND(dlp.costo_items * 1.19, 2) *1.25,2) precio
          from ldci_intdetlistprec dlp
          join ldci_intelistpr m on m.codigo = dlp.codigo_interfaz and m.empresa='GDGU'
          where dlp.codigo_interfaz in (&interfaz_guajira)
)
,costo_act_guajira as(
        select 'actividad' as tipo,
               c.codigo_interfaz,
               h.item_actividad codigo_item,
               c.costo_interfaz costo_interfaz,
               c.empresa,
               round(c.costo*1.06,2) costo,
               round(round(c.costo*1.06,2)*1.25,2) precio
        from costo_mat_guajira c
        join ldc_homoitmaitac h on h.empresa=c.empresa and h.item_material = c.codigo_item
)
, total_interfaz as(
                select *
                from costo_mat_caribe
                union all
                select *
                from costo_act_caribe
                union all
                select *
                from costo_act_guajira
)
select la.list_unitary_cost_id lista_actual,
       la.items_id,
       la.price costo_actual,
       la.sales_value precio_actual,
       tipo,
       codigo_interfaz,
       codigo_item,
       costo_interfaz,
       empresa,
       costo_interfaz_total,
       precio_interfaz,
       lan.list_unitary_cost_id lista_anterior,
       lan.price costo_anterior,
       lan.sales_value precio_anterior,
       case
         when tipo is not null and costo_interfaz_total = la.price then 'COSTO CORRECTO'
         when tipo is not null and costo_interfaz_total != la.price then 'COSTO ERRADO' 
         when la.price =lan.price then 'COSTO CORRECTO'
         else 'COSTO ERRADO' 
       end validar_costo,
       case
         when tipo is not null and precio_interfaz = la.sales_value then 'PRECIO CORRECTO'
         when tipo is not null and precio_interfaz != la.sales_value then 'PRECIO ERRADO' 
         when la.sales_value = lan.sales_value then 'PRECIO CORRECTO'
         else 'PRECIO ERRADO'
       end validar_precio
 from ge_unit_cost_ite_lis la
full outer join total_interfaz on items_id = codigo_item
left join ge_unit_cost_ite_lis lan on lan.items_id = la.items_id and lan.list_unitary_cost_id = &listaanterior
where la.list_unitary_cost_id = &lista_actual


--and empresa = 'GDGU'
--and empresa = 'GDCA'

--and tipo = 'material'
--and tipo = 'actividad'

--and codigo_interfaz is null
--and codigo_interfaz is not null
