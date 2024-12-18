column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
    DECLARE
        nuError NUMBER;
        
        sbError VARCHAR2(4000);
        nuActa  NUMBER;
        sbComm  VARCHAR2(200) :='CASO OSF-682';

        CURSOR cuActas
        IS
        SELECT    *
        FROM      ge_acta
        WHERE     id_acta in (185643,185644);

    BEGIN
        DBMS_OUTPUT.PUT_LINE('Inicia proceso de abrir actas');
        FOR rcActa IN cuActas
        LOOP
            nuActa := rcActa.id_acta;
            DBMS_OUTPUT.PUT_LINE('Procesa Acta No.'||nuActa);

            ldc_prAbrirActaCerrada(nuActa, 
                                    sbComm, 
                                    nuError,
                                    sbError);

            IF nuError = 0 THEN
                COMMIT;
                DBMS_OUTPUT.PUT_LINE('Acta '||nuActa||' Reversada OK ');
            ELSE
                ROLLBACK;
                DBMS_OUTPUT.PUT_LINE('Error en Acta '||nuActa||' '||sbError);
            END IF;    
        END LOOP;
    END;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Finaliza proceso de abrir actas');
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/