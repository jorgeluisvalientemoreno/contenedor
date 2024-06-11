select *
from open.ldc_asigna_unidad_rev_per p, open.mo_packages r
where package_id=solicitud_generada
  and request_Date>='09/01/2018';
  
  SELECT x.unidad_operativa --INTO nuunidadoperativa
   FROM ldc_asigna_unidad_rev_per x
  WHERE x.solicitud_generada = 59486404
    AND rownum = 1;
    

SELECT *
   FROM open.ldc_conftitra_caus_asig_aut x
  WHERE x.tipo_trabajo = 10450
    
    AND x.asig_auto IN('S','s')
  ;

    select *
    from open.ldc_order
    where order_id=68237264
  
  
select *
from open.LDC_ORDENTRAMITERP

select *
from open.or_order_activity a, open.mo_packages p, open.or_task_type t
where p.package_type_id=100321
 and p.package_id=a.package_id
 and t.task_type_id=a.task_type_id
 and status='R'
 and a.task_type_id=10832
 and product_id=150;
 
 
 select *
 from ldc_marca_producto
 where id_producto=1508440;
 
SELECT *
   FROM ldc_conftitra_caus_asig_aut x
  WHERE x.tipo_trabajo = 10832
  for update;
  
  
  
  
  select r.order_id,
             system,
             dataorder,
             initdate,
             finaldate,
             changedate,
             messagecode,
             messagetext,
             state,
             fecha_recepcion,
             fecha_procesado,
             fecha_notificado,
             veces_procesado,
             substr(DATAORDER,instr(DATAORDER,'|',1,4)+1,instr(DATAORDER,'>',1)-instr(DATAORDER,'|',1,4)-1) ,
             o.task_type_id
        from open.LDCI_ORDENESALEGALIZAR r,
             open.or_order o 
       where r.fecha_recepcion>='22/12/2021'
        and r.system in ('WS_LUDYREPXREV', 'WS_LUDYREPXREV')
        and r.order_id=o.order_id
        and messagecode=0
        and dataorder like '%COD_UNIDAD_APOYO%';
 
