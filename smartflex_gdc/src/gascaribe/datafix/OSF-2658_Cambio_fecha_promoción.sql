column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN

    UPDATE PR_PROMOTION 
    SET    final_date =  TO_DATE('05/06/2024 11:59:59 pm', 'DD/MM/YYYY HH:MI:SS AM')
    WHERE product_id IN (SELECT sesunuse FROM servsusc WHERE sesususc IN (48191822)) 
    AND asso_promotion_id = 73 AND final_date >= SYSDATE ;

    UPDATE PR_PROMOTION 
    SET    final_date =  TO_DATE('06/06/2024 11:59:59 pm', 'DD/MM/YYYY HH:MI:SS AM')
    WHERE product_id IN (SELECT sesunuse FROM servsusc WHERE sesususc IN (1999599, 48195472,1138258)) 
    AND asso_promotion_id = 73 AND final_date >= SYSDATE ;


    UPDATE PR_PROMOTION 
    SET    final_date =  TO_DATE('15/06/2024 11:59:59 pm', 'DD/MM/YYYY HH:MI:SS AM')
    WHERE product_id IN (SELECT sesunuse FROM servsusc WHERE sesususc IN (48087314)) 
    AND asso_promotion_id = 73 AND final_date >= SYSDATE ;

    UPDATE PR_PROMOTION 
    SET    final_date =  TO_DATE('21/06/2024 11:59:59 pm', 'DD/MM/YYYY HH:MI:SS AM')
    WHERE product_id IN (SELECT sesunuse FROM servsusc WHERE sesususc IN (1999576)) 
    AND asso_promotion_id = 73 AND final_date >= SYSDATE ;

    UPDATE PR_PROMOTION 
    SET    final_date =  TO_DATE('26/06/2024 11:59:59 pm', 'DD/MM/YYYY HH:MI:SS AM')
    WHERE product_id IN (SELECT sesunuse FROM servsusc WHERE sesususc IN (48221648)) 
    AND asso_promotion_id = 73 AND final_date >= SYSDATE ;

    UPDATE PR_PROMOTION 
    SET    final_date =  TO_DATE('18/07/2024 11:59:59 pm', 'DD/MM/YYYY HH:MI:SS AM')
    WHERE product_id IN (SELECT sesunuse FROM servsusc WHERE sesususc IN (66844634)) 
    AND asso_promotion_id = 73 AND final_date >= SYSDATE ;

    UPDATE PR_PROMOTION 
    SET    final_date =  TO_DATE('23/08/2024 11:59:59 pm', 'DD/MM/YYYY HH:MI:SS AM')
    WHERE product_id IN (SELECT sesunuse FROM servsusc WHERE sesususc IN (1053002)) 
    AND asso_promotion_id = 73 AND final_date >= SYSDATE ;

    UPDATE PR_PROMOTION 
    SET    final_date =  TO_DATE('11/09/2024 11:59:59 pm', 'DD/MM/YYYY HH:MI:SS AM')
    WHERE product_id IN (SELECT sesunuse FROM servsusc WHERE sesususc IN (48206241)) 
    AND asso_promotion_id = 73 AND final_date >= SYSDATE ;

    UPDATE PR_PROMOTION 
    SET    final_date =  TO_DATE('12/09/2024 11:59:59 pm', 'DD/MM/YYYY HH:MI:SS AM')
    WHERE product_id IN (SELECT sesunuse FROM servsusc WHERE sesususc IN (67400541)) 
    AND asso_promotion_id = 73 AND final_date >= SYSDATE ;

    UPDATE PR_PROMOTION 
    SET    final_date =  TO_DATE('02/10/2024 11:59:59 pm', 'DD/MM/YYYY HH:MI:SS AM')
    WHERE product_id IN (SELECT sesunuse FROM servsusc WHERE sesususc IN (66789782)) 
    AND asso_promotion_id = 73 AND final_date >= SYSDATE ;

    COMMIT;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/