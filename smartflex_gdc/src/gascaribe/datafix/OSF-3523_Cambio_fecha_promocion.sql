column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN

    dbms_output.put_line('Incia cambio de promoción OSF-3523');
    UPDATE PR_PROMOTION 
    SET    register_date =  TO_DATE('21/10/2024 05:36:53 pm', 'DD/MM/YYYY HH:MI:SS AM'),
           initial_date =  TO_DATE('21/10/2024 05:36:53 pm', 'DD/MM/YYYY HH:MI:SS AM')
    WHERE product_id IN (SELECT sesunuse FROM servsusc WHERE sesususc IN (66656637)) 
    AND asso_promotion_id = 73 AND promotion_id = 467581;

    COMMIT;
    dbms_output.put_line('Fin cambio de promoción OSF-3523');
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/