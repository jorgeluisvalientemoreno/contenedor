set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/
BEGIN
  UPDATE LDC_COPRSUCA SET CPSCPROD = 26 , CPSCCOTO = 393 WHERE CPSCCONS = 20467;
  UPDATE LDC_COPRSUCA SET CPSCPROD = 4326 , CPSCCOTO = 57368 WHERE CPSCCONS = 20477;
  UPDATE LDC_COPRSUCA SET CPSCPROD = 6173 , CPSCCOTO = 64395 WHERE CPSCCONS = 20480;
  UPDATE LDC_COPRSUCA SET CPSCPROD = 13 , CPSCCOTO = 254 WHERE CPSCCONS = 20653;
  UPDATE LDC_COPRSUCA SET CPSCPROD = 66 , CPSCCOTO = 20642 WHERE CPSCCONS = 20485;
  UPDATE COPRSUCA SET CPSCPROD = 26 , CPSCCOTO = 393 WHERE CPSCCONS = 77122;
  UPDATE COPRSUCA SET CPSCPROD = 4326 , CPSCCOTO = 57368 WHERE CPSCCONS = 77132;
  UPDATE COPRSUCA SET CPSCPROD = 6173 , CPSCCOTO = 64395 WHERE CPSCCONS = 77135;
  UPDATE COPRSUCA SET CPSCPROD = 13 , CPSCCOTO = 254 WHERE CPSCCONS = 77318;
  UPDATE COPRSUCA SET CPSCPROD = 66 , CPSCCOTO = 20642 WHERE CPSCCONS = 77140;
  commit;
  
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('error no controlado '||sqlerrm);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/