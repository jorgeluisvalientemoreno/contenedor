update or_order
   set causal_id=null,
       legalization_date=null,
       order_status_id=5,
       saved_data_values=null,
       exec_initial_date=null,
       execution_final_date=null
where order_id=323578034;


update or_order_activity
   set status='R',
       value1=null,
       value2=null
where order_id=323578034;

update or_order_items
   set legal_item_amount=0
 where order_id=323578034;
 

delete  or_order_stat_change
   where order_id=323578034
     and initial_status_id=5
     and final_status_id=8;


delete or_order_person
where order_id=323578034;


update lectelme
set leemdocu = 316462800, --ORDER_ACTIVITY_ID
leemleto = null, 
leemoble = null,
 leemfele = null
where leemcons = 143133153;

select * from hileelme
where hlemelme    = 143133153 --[lectelme.leemcons]

delete from hileelme
where hlemelme = 143133153;

select *  from open.conssesu 
where conssesu.cosssesu = 1159701
order by cossfere desc ;

delete from open.conssesu 
where conssesu.cosssesu = 1159701
and cossfcco =2651629
