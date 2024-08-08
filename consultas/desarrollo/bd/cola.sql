ALTER SESSION SET CURRENT_SCHEMA= "OPEN";
SELECT b.NAME NOMBRE_COLA, b.queue_table, b.user_comment DESCRIPCION, a.waiting WAITING, a.ready READY, expired EXPIRED
FROM V$AQ a, dba_queues b
WHERE a.qid(+) = b.qid
AND owner = 'OPEN'
AND name like 'AQ/_%' escape '/'
ORDER BY 5 desc;


alter session set current_schema=OPEN;
  select * from AQ_TBL_FINISH_G4; 
 select * from AQ_TBL_FINISH_G4; 
 select * from AQ_TBL_INIT_G4; 
 select * from AQ_TBL_INIT_G4; 
 select * from AQ_TBL_DISPATCH_G4; 
 select * from AQ_TBL_DISPATCH_G4; 
 select * from AQ_TBL_FINISH_G3; 
 select * from AQ_TBL_FINISH_G3; 
 select * from AQ_TBL_INIT_G3; 
 select * from AQ_TBL_INIT_G3; 
 select * from AQ_TBL_DISPATCH_G3; 
 select * from AQ_TBL_DISPATCH_G3; 
 select * from AQ_TBL_FINISH_G2; 
 select * from AQ_TBL_FINISH_G2; 
 select * from AQ_TBL_INIT_G2; 
 select * from AQ_TBL_INIT_G2; 
 select * from AQ_TBL_DISPATCH_G2; 
 select * from AQ_TBL_DISPATCH_G2; 
 select * from AQ_TBL_RATING; 
 select * from AQ_TBL_RATING; 
 select * from AQ_TBL_MOT_FAC_01; 
 select * from AQ_TBL_MOT_FAC_01; 
 select * from AQ_TBL_FINISH; 
 select * from AQ_TBL_FINISH; 
 select * from AQ_TBL_INIT; 
 select * from AQ_TBL_INIT; 
 select * from AQ_TBL_LOCAL; 
 select * from AQ_TBL_LOCAL; 
 select * from AQ_TBL_DISPATCH; 
 select * from AQ_TBL_DISPATCH; 
 select * from AQ_TBL_MOT_MAN_03; 
 select * from AQ_TBL_MOT_MAN_03; 
 select * from AQ_TBL_ORDERS_01; 
 select * from AQ_TBL_ORDERS_01; 
 select * from AQ_TBL_WOR_FLO_02; 
 select * from AQ_TBL_WOR_FLO_02; 
 select * from AQ_TBL_WOR_FLO_01; 
 select * from AQ_TBL_WOR_FLO_01; 
 select * from AQ_TBL_MOT_MAN_02; 
 select * from AQ_TBL_MOT_MAN_02; 
 select * from AQ_TBL_CUS_CAR_01; 
 select * from AQ_TBL_CUS_CAR_01; 
 select * from AQ_TBL_MOT_MAN_01; 
 select * from AQ_TBL_MOT_MAN_01; 
