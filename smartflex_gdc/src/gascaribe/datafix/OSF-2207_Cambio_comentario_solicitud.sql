column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    CURSOR cuSolicitudes
    IS
    SELECT package_id, package_type_id, comment_ 
    FROM mo_packages 
    WHERE package_id  IN (208556928,
    208556918,
    208556924,
    208556926,
    208556932,
    208556934,
    208558216,
    208558218,
    208558210,
    208558214,
    208558220,
    208558222,
    208558224,
    208558226,
    208558228,
    208558230,
    208558246,
    208558236,
    208558242,
    208558244,
    208558252,
    208558256,
    208558259,
    208558261,
    208558263,
    208558266,
    208558269,
    208559477,
    208558271,
    208558273,
    208559471,
    208559473,
    208559475,
    208559479,
    208559481
    );
BEGIN
    FOR rcSolicitudes IN cuSolicitudes LOOP
      DBMS_OUTPUT.PUT_LINE('Procesando Solicitud: [' ||  rcSolicitudes.package_id||']');

      UPDATE mo_packages 
      SET comment_ = 'SE CAMBIA ESTRATO DE 1 A 3  MEDIANTE RSL 0010 DEL 18 DE ENE DEL 2021/RSL NOTI EL 06 DE DIC DEL 2023 VER RAD 23-024957'
      WHERE package_id = rcSolicitudes.package_id;
      DBMS_OUTPUT.PUT_LINE('Se actualizo Solicitud: [' ||  rcSolicitudes.package_id||']');
    END LOOP;

    commit;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/