
column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  sbCaso VARCHAR2(20) := 'OSF-2282';

begin

  UPDATE concbali cc SET cc.coblconc=991 WHERE cc.coblconc = 287 and cc.coblcoba = 291;

  COMMIT;

  dbms_output.put_line('Sobre el concepto base 291 se actualiza el concepto 287 por el concepto 991');

EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('Error al actualizar sobre el concepto base 291, el concepto 287 por el concepto 991: ' ||
                         SQLERRM || ']');
    ROLLBACK;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/