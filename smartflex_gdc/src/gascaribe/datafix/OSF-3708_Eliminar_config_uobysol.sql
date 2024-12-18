column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    CURSOR cuDatos 
    IS
    SELECT  * 
    FROM    LDC_PACKAGE_TYPE_OPER_UNIT 
    WHERE   items_id IN (4000380,
      4000354,
      4000049,
      4000048,
      4000047,
      4000046,
      4000044,
      4000043,
      4000041,
      4000040,
      4000039,
      4000037,
      4000036,
      4000991,
      4294588,
      4000064,
      4000916,
      100010005
    ) and package_type_assign_id = 4;
BEGIN
  dbms_output.put_line('Inicia OSF-3708!');
  FOR reg IN cuDatos LOOP
      DELETE FROM LDC_PACKAGE_TYPE_OPER_UNIT WHERE package_type_oper_unit_id = reg.package_type_oper_unit_id;
      dbms_output.put_line('Se elimina configuración '||reg.package_type_oper_unit_id );
  END LOOP;
  commit;
  dbms_output.put_line('Fin OSF-3708!');
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/