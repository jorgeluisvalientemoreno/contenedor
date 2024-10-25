--validar_ordenes_gcoreca 
 select product_id,
        ss.sesususc,
        ss.sesuesco,
        ss.sesuesfn,
        o.task_type_id,
        t.description,
        o.order_id,
        o.order_status_id status ,
        o.operating_unit_id,
        o.created_date, 
        o.legalization_date,
        o.causal_id,
        c.description,
        c.class_causal_id,
        oi.items_id,
        oi.legal_item_amount,
        oi.value,
        oi.total_price
  from or_order o
 inner join or_task_type t on o.task_type_id = t.task_type_id
 inner join or_order_items  oi on oi.order_id = o.order_id
 left join or_order_activity a on a.order_id = o.order_id
 left join servsusc  ss  on ss.sesunuse = product_id
 left join or_requ_Data_value da on da.order_id = o.order_id
 left join open.ge_causal c on c.causal_id = o.causal_id
 left join or_order_person p on p.order_id= o.order_id
 left join ge_person pe on pe.person_id = p.person_id
 Where o.created_date >= '01/08/2024'
 and o.task_type_id in (5005,11263)
 and o.operating_unit_id = 4296
 order by product_id  desc 
 
 
 --50112751,51647830,50107555,50664187,1023211,1000486,50117155,1999951,50665780,50682652,6102952
 --update or_order o  set o.created_date = '28/06/2024'  where o.created_date > '04/07/2024' and o.task_type_id in (5005,11263)  and o.order_status_id   in (0,5)

-- and  a.product_id in (1183221)
-- --and o.order_status_id   in (0,5)
--and  a.product_id in (1183221)

 --and o.causal_id = 9817

-- and  a.product_id in (17246623)
--and a.product_id in (50557303,50013948,52565629,50343029,50958050,8093482,50060700,50035747,50466703,50788051,17022907,5161439)
/*product_id in (50763632/*50763632,1192738,6042417,17245377,2035869,6139580,29000043,16004218,50716474,50054934,17031726,
 50242628,17218063,50545953,36000018,1177376,2083665,6517470,6634363,6525250,50658310,6115520,17031464,1147006,
 50193830,6099499,17192935,6639530,6605690,6606950,6587330,6512431,6631214,6115520,50658310,1147006,1177376,17031464,
 2083665,6517470,6525250,6634363)
 and */
