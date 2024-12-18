column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    NUCONTA NUMBER;
BEGIN
    SELECT COUNT(1) INTO NUCONTA
    FROM Ge_Suspension_Type
    WHERE SUSPENSION_TYPE_ID = 15;

  
    if NUCONTA = 0 then
      INSERT INTO Ge_Suspension_Type(SUSPENSION_TYPE_ID,
                      DIRECTIONALITY_ID,
                      DESCRIPTION,
                      PRIORITY,
                      ANALIZE,
                      CLASS_SUSPENSION,
                      COMPANY_KEY)

      VALUES (15, 'BI', 'SUSPENSIÓN CERTIFICACION PEDIENTE SN', 1, 'Y', 'A', 99 );

    end if;

    commit;
 END;
/
DECLARE

 NUCONTA NUMBER;
BEGIN
  SELECT COUNT(1) INTO NUCONTA
  FROM ps_sustyp_by_protyp

  WHERE suspension_type_id = 15;

  

  if NUCONTA = 0 then
    insert into ps_sustyp_by_protyp (
                                  PRODUCT_TYPE_ID,
                                  SUSPENSION_TYPE_ID
                                  )
                            values( 
                                    7014,
                                    15
                                  );
   end if;
   commit;
 END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/