select *
 from ta_proytari
 left join ta_estaproy on esprcons = prtaesta 
 where prtacons in (8711, 8733 , 8734) ;

   
 select *
 from TA_PROYTARI
  where prtacons in (8711, 8733 , 8734)
 for update ; -- 3 actualizado 
