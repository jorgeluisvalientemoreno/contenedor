column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN

    DBMS_OUTPUT.PUT_LINE('Inicia Datafix OSF-3648' );

    UPDATE mo_packages 
    SET comment_ = 'CAMBIO DE SUBCATEGORIA SEGUN 566 DEL 09 DE SEPTIEMBRE DE 2024 MODIFICA A ESTRATO 2 //SE REALIZA CAMBIO DE ESTRATO 1 A 2'
    WHERE package_id in (221027721, 221027719,221027717);
    DBMS_OUTPUT.PUT_LINE('Fin Datafix OSF-3648' );

    COMMIT;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/