column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    nuError   number;
    sbError   varchar2(4000);
    cursor cuSolicitudes is
    SELECT  'MOPRP' FORMA, 
        P.PACKAGE_ID,
        P.MOTIVE_STATUS_ID,
        P.PACKAGE_TYPE_ID,
        (SELECT PS.DESCRIPTION FROM OPEN.PS_PACKAGE_TYPE PS WHERE PS.PACKAGE_TYPE_ID=P.PACKAGE_TYPE_ID) DESC_TISO,
        P.REQUEST_DATE, 
        EL.MESSAGE,
        NULL,
        EL.date_ 
    FROM    OPEN.MO_EXECUTOR_LOG_MOT LM,
        OPEN.GE_EXECUTOR_LOG EL,
        OPEN.MO_PACKAGES P
    WHERE   LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
      AND  P.PACKAGE_ID = LM.PACKAGE_ID
      AND  LM.STATUS_EXEC_LOG_ID = 4
      AND action_id=8250;
begin
      dbms_output.put_line('Solicitud|Error');
      for reg in cuSolicitudes loop
        begin
          nuError := null;
          sbError := null;
          adm_person.pkgmanejosolicitudes.pannulerrorflow(inupackages => reg.package_id);
          commit;
          dbms_output.put_line(reg.package_id||'|OK');
        exception
          when pkg_error.Controlled_Error then
            rollback;
            pkg_error.getError(nuError, sbError);
            dbms_output.put_line(reg.package_id||'|'||sbError);
          when others then
            rollback;
            pkg_error.getError(nuError, sbError);
            dbms_output.put_line(reg.package_id||'|'||sbError);
        end;
       
      end loop;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/