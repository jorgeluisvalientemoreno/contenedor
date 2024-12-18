set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/
BEGIN
 update WF_INSTANCE set STATUS_ID = 6 where instance_id = 1241644097;
 update WF_INSTANCE set STATUS_ID = 6 where instance_id = 1282847819;
 update WF_INSTANCE set STATUS_ID = 6 where instance_id = 1373330250;
 update WF_INSTANCE set STATUS_ID = 6 where instance_id = 1453236857;
 update WF_INSTANCE set STATUS_ID = 6 where instance_id = 1456163057;
 update WF_INSTANCE set STATUS_ID = 6 where instance_id = 100913157;
 update WF_INSTANCE set STATUS_ID = 6 where instance_id = 103160867;
 update WF_INSTANCE set STATUS_ID = 6 where instance_id = 276183452;
 
 update MO_WF_PACK_INTERFAC set STATUS_ACTIVITY_ID = 3
  where package_id in (179207379,179243749,
  179248127,179254259,
  179373737,179724744,
  180005898,180006100,
  180059499,180073528,
  180270997,180328920,
  181213501,181354324,
  181590880,181631490,  181843749,181844598,  182120905,182125008,  182282779,182282988,  186673826)
   and STATUS_ACTIVITY_ID = 4;
  
  update WF_INSTANCE set STATUS_ID = 6 where instance_id = 276183452;
  
  COMMIT;   
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('error no controlado '||sqlerrm);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/