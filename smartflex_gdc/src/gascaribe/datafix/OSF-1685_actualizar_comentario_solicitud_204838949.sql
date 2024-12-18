column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
BEGIN
  UPDATE open.mo_packages mp
     SET mp.comment_ = 'SEGUN CARTA RECIBIDA SRA ISABELLA JOSEFA VIDAL D ACUNTI CC 26688391 CEL 3045348173 PRESENTA CEDULA FISICA, SOLICITA QUE SE LE SEA CORREGIDO EL SEGUNDO APELLIDO EN SISTEMA APARECE COMO: ISABELLA JOSEFA VIDAL DACONTE Y VA A CORREGIR A: ISABELLA JOSEFA VIDAL D ACUNTI//'
   WHERE mp.package_id = 204838949;
  COMMIT;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

