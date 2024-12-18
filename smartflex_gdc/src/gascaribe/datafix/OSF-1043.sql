column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  blInsertOK    boolean := false;

begin
  dbms_output.put_line('---- Inicio OSF-1043 ----');

  BEGIN

    MERGE INTO OPEN.GE_SUSPENSION_TYPE A USING
    (SELECT
      107 as SUSPENSION_TYPE_ID,
      'BI' as DIRECTIONALITY_ID,
      'SUSPENSION POR PNO' as DESCRIPTION,
      1 as PRIORITY,
      'Y' as ANALIZE,
      'A' as CLASS_SUSPENSION,
      99 as COMPANY_KEY
      FROM DUAL) B
    ON (A.SUSPENSION_TYPE_ID = B.SUSPENSION_TYPE_ID)
    WHEN NOT MATCHED THEN 
    INSERT (
      SUSPENSION_TYPE_ID, DIRECTIONALITY_ID, DESCRIPTION, PRIORITY, ANALIZE, 
      CLASS_SUSPENSION, COMPANY_KEY)
    VALUES (
      B.SUSPENSION_TYPE_ID, B.DIRECTIONALITY_ID, B.DESCRIPTION, B.PRIORITY, B.ANALIZE, 
      B.CLASS_SUSPENSION, B.COMPANY_KEY)
    WHEN MATCHED THEN
    UPDATE SET 
      A.DIRECTIONALITY_ID = B.DIRECTIONALITY_ID,
      A.DESCRIPTION = B.DESCRIPTION,
      A.PRIORITY = B.PRIORITY,
      A.ANALIZE = B.ANALIZE,
      A.CLASS_SUSPENSION = B.CLASS_SUSPENSION,
      A.COMPANY_KEY = B.COMPANY_KEY;
    COMMIT;
    blInsertOK := true;
    dbms_output.put_line('OK - GE_SUSPENSION_TYPE');
  EXCEPTION
    WHEN OTHERS THEN
      rollback;
      DBMS_OUTPUT.PUT_LINE('Error GE_SUSPENSION_TYPE --> '||sqlerrm);
  END;

  IF (blInsertOK) THEN
    BEGIN
        MERGE INTO OPEN.PS_SUSTYP_BY_PROTYP A USING
        (SELECT
          7014 as PRODUCT_TYPE_ID,
          107 as SUSPENSION_TYPE_ID
          FROM DUAL) B
        ON (A.PRODUCT_TYPE_ID = B.PRODUCT_TYPE_ID and A.SUSPENSION_TYPE_ID = B.SUSPENSION_TYPE_ID)
        WHEN NOT MATCHED THEN 
        INSERT (
          PRODUCT_TYPE_ID, SUSPENSION_TYPE_ID)
        VALUES (
          B.PRODUCT_TYPE_ID, B.SUSPENSION_TYPE_ID);
        COMMIT;
        dbms_output.put_line('OK - PS_SUSTYP_BY_PROTYP');
    EXCEPTION
      WHEN OTHERS THEN
        rollback;
        DBMS_OUTPUT.PUT_LINE('Error PS_SUSTYP_BY_PROTYP --> '||sqlerrm);
    END;
  END IF;

  COMMIT;

  dbms_output.put_line('---- Fin OSF-1043 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-1043 ----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/