select *
from open.cc_quoted_work qw
where qw.quotation_id=23374 ;
select *
from open.cc_quotation q
where q.quotation_id=23374 ;
select *
from open.cc_quotation_item qi
where qi.quotation_id=23374 ;
select *
from open.cc_quot_financ_cond cc
where cc.quotation_id=23374 ;
select *
from open.ldc_cotizacion_comercial  co
where id_cot_comercial=7456; 
select *
from OPEN.LDC_ITEMS_COTIZACION_COM  cm, open.ge_items i
where cm.id_cot_comercial=7456
and  cm.id_item=i.items_id order by fecha_registro desc ;
