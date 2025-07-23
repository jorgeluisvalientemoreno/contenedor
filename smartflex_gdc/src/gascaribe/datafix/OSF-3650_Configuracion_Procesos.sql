column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  INSERT INTO procesos (PROCCODI, PROCDESC, PROCPEDE, PROCCONS)
      VALUES('LDCGPAD', 'Genera Proceso de Abono a Diferido - Plan Piloto', 'N', 9908 );
  INSERT INTO COCOPRCI(CCPCCICL, CCPCVPER, CCPCINPR, CCPCPRRE)
    VALUES (1701, 'A', 26, 9908);
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
/