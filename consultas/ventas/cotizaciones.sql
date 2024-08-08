select * from open.cc_quoted_work qw  ;
select * from open.cc_quotation ;
select * from open.cc_quotation_item qi ;
select * from open.cc_quot_financ_cond cc  ;
select * from open.ldc_cotizacion_comercial  co ; 
select * from open.ldc_items_cotizacion_com  cm, open.ge_items i 
where  cm.id_item=i.items_id order by fecha_registro desc ;
