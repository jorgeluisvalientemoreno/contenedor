select * from cc_commercial_segm ;

select * from  cc_com_seg_fea_val; 

select * from cc_com_seg_prom;

select * from cc_com_seg_finan;

select cc.commercial_segm_id,subs_type_id ,active , m.name, cc.geog_category_id, finan_finan_count   ,geog_subcategory_id,prod_cutting_state ,finan_finan_state,finan_acc_balance,prod_commercial_plan , f.priority, financing_plan_id
from  open.cc_com_seg_fea_val cc
left join open.cc_commercial_segm m on cc.commercial_segm_id = m.commercial_segm_id 
left join open.cc_com_seg_prom p on p.commercial_segm_id = cc.commercial_segm_id
left join open.cc_com_seg_finan f on f.commercial_segm_id = cc.commercial_segm_id
where    cc.commercial_segm_id = 2108

SELECT x.idplafise planfinan
          FROM ldc_plfiaplpro x
         WHERE x.producto = 50152180 --nupaproducto
         ORDER BY x.prioridad
