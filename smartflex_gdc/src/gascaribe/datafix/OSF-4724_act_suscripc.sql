SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-4724"
prompt "-----------------"
DECLARE
    nuAntSuscnupr NUMBER;
    nuNueSuscnupr NUMBER := 2;
    nuContrato NUMBER := 1113761;
BEGIN    
    select suscnupr
    into nuAntSuscnupr
    from suscripc
    where susccodi = nuContrato; 
        
    dbms_output.put_line('Actualizando campo SUSCNUPR '||nuAntSuscnupr||' de la entidad SUSCRIPC para el contrato '||nuContrato);
    
    UPDATE suscripc
    SET suscnupr = nuNueSuscnupr
    WHERE susccodi = nuContrato;
                    
    COMMIT;
    
    dbms_output.put_line('Actulizado campo SUSCNUPR de la entidad SUSCRIPC a '||nuNueSuscnupr||' para el contrato '||nuContrato);
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar SUSCRIPC, '||sqlerrm);
END;
/
prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-4724-----"
prompt "-----------------------"
SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;
prompt Fin Proceso!!
set serveroutput off
quit
/