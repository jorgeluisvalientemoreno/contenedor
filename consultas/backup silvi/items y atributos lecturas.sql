  select *
 from ge_items
 where items_id = 102008;
 
 
 select *
 from GE_ITEM_CLASSIF
 where USED_IN_LEGALIZE = 'Y' ; 
 
 select * 
 from ge_items_attributes
 where items_id = 102008 ;
 

 select *
 from ge_attributes 
 where attribute_id in ( 400001 ,400002 ,400007 , 400004)
