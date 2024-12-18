column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN

    DBMS_OUTPUT.PUT_LINE('Inicia Datafix OSF-3675' );

    UPDATE mo_packages 
    SET comment_ = 'SE CAMBIA ESTRATO DE 2 A 3 MEDIANTE RSL SP-RE-0090 DEL 19 DE NOV DEL 2024 RSL NOTI EL 19 DE NOV DEL 2024 VER RAD 24-023589'
    WHERE package_id in (221067951,221067940,221067943,221067941,221067949,221067945,221067931);
    DBMS_OUTPUT.PUT_LINE('Fin Datafix OSF-3675' );

    COMMIT;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/