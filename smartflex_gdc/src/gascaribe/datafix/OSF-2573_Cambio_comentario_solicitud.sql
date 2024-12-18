column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN

    DBMS_OUTPUT.PUT_LINE('Procesando Solicitud: [' ||  212645814||']');

    UPDATE mo_packages 
    SET comment_ = 'CAMBIO DE SUBCATEGORIA SEGUN DECR. 095 DEL 10/11/2015 EL PREDIO UBICADO EN LA DIRECCION KR 20 CL 7B - 57 DEL MUNICIPIO DE EL COPEY CON COD. PREDIAL 20-238-01-01-0142-0003-000, SE ENCUENTRA CON ESTRATO 3// SE REALIZA CAMBIO DE ESTRATO 2 A 3'
    WHERE package_id = 212645814;
    DBMS_OUTPUT.PUT_LINE('Se actualizo Solicitud: [' ||  212645814||']');

    DBMS_OUTPUT.PUT_LINE('Procesando Solicitud: [' ||  212646051||']');

    UPDATE mo_packages 
    SET comment_ = 'CAMBIO DE SUBCATEGORIA SEGUN DECR. 095 DEL 10/11/2015 EL PREDIO UBICADO EN LA DIRECCION KR 20 CL 7B - 35 DEL MUNICIPIO DE EL COPEY CON COD. PREDIAL 20-238-01-01-0142-0003-000, SE ENCUENTRA CON ESTRATO 3// SE REALIZA CAMBIO DE ESTRATO 2 A 3'
    WHERE package_id = 212646051;
    DBMS_OUTPUT.PUT_LINE('Se actualizo Solicitud: [' ||  212646051||']');


    commit;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/