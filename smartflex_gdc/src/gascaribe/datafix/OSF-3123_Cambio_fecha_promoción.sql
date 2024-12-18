column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN

    UPDATE PR_PROMOTION 
    SET    final_date =  TO_DATE('19/12/2024 11:59:59 pm', 'DD/MM/YYYY HH:MI:SS AM')
    WHERE product_id IN (SELECT sesunuse FROM servsusc WHERE sesususc IN (66279048)) 
    AND asso_promotion_id = 73 AND promotion_id = 440546;

    COMMIT;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/