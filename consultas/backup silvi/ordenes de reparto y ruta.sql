select *
from open.or_order r 
inner join open.or_order_activity a  on r.order_id = a.order_id  
 where r.task_type_id = 12626 and created_date >='22/07/2024'
 and exists (select *
            from open.servsusc s
            where a.subscription_id = s.sesususc
            and s.sesucicl = 378)
 AND SUBSCRIPTION_ID IN (48045315,67536727);
 
 SELECT * FROM OPEN.PR_PRODUCT  WHERE SUBSCRIPTION_ID IN (48045315,67536727)
 
 SELECT * FROM OPEN.AB_ADDRESS A WHERE ADDRESS_ID IN (4958262,656019);
 
 SELECT * FROM OPEN.AB_SEGMENTS A WHERE  SEGMENTS_ID IN (599917,599638);
 
 SELECT * FROM OPEN.GE_GEOGRA_LOCATION  WHERE GEOGRAP_LOCATION_ID = 66 
 
