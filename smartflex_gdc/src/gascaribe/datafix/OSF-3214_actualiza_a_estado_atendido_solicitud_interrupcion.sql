column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  cursor cuSolicitudes is
    SELECT p2.package_id,
           p2.request_Date,
           p2.motive_status_id,
           p2.user_id,
           p2.comment_,
           p2.cust_care_reques_num,
           p2.package_type_id
      FROM OPEN.mo_packages p
     INNER JOIN OPEN.mo_packages p2
        on p2.cust_care_reques_num = to_char(p.cust_care_reques_num)
     WHERE p.package_id IN (215958030, 216672852, 216760946)
       AND p2.motive_status_id = 46
     ORDER BY p2.package_id;

  sbComment       VARCHAR2(4000) := 'Se cambia estado de solicitud de regsitro de daño por OSF-3214';
  sbmensaje       VARCHAR2(4000);
  eerrorexception EXCEPTION;
  onuErrorCode    NUMBER(18);
  osbErrorMessage VARCHAR2(2000);
  cnuCommentType CONSTANT NUMBER := 83;
  nuPlanId      wf_instance.instance_id%TYPE;
  nuError       NUMBER;
  nuCommentType NUMBER := 1277;
  nuErrorCode   NUMBER;
  sbErrorMesse  VARCHAR2(4000);
  TYPE t_array_solicitudes IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

  v_array_solicitudes t_array_solicitudes;

  PACKAGE_IDvar           MO_PACKAGE_CHNG_LOG.PACKAGE_ID%type := null;
  CUST_CARE_REQUES_NUMvar MO_PACKAGE_CHNG_LOG.CUST_CARE_REQUES_NUM%type := null;
  PACKAGE_TYPE_IDvar      MO_PACKAGE_CHNG_LOG.PACKAGE_TYPE_ID%type := null;
  CURRENT_TABLE_NAMEvar   MO_PACKAGE_CHNG_LOG.CURRENT_TABLE_NAME%type := 'MO_PACKAGES';
  CURRENT_EVENT_IDvar     MO_PACKAGE_CHNG_LOG.CURRENT_EVENT_ID%type := ge_boconstants.UPDATE_;
  CURRENT_EVEN_DESCvar    MO_PACKAGE_CHNG_LOG.CURRENT_EVEN_DESC%type := 'UPDATE';
  O_MOTIVE_STATUS_IDVar   MO_PACKAGE_CHNG_LOG.o_motive_status_id%TYPE;

BEGIN

  FOR reg IN cuSolicitudes LOOP
    nuError := 0;
  
    BEGIN
      update open.tt_damage d
         set d.damage_causal_id = 3867, d.REG_DAMAGE_STATUS = 'A'
       where d.package_id = reg.package_id;
    EXCEPTION
      WHEN OTHERS THEN
        rollback;
        nuError := 1;
        dbms_output.put_line('Error actaulizando data del registro de daño de la solicitud|' ||
                             reg.package_id || '|' || sqlerrm);
    END;
  
    IF nuError = 0 THEN
      BEGIN
        --Cambio estado de la solicitud
        UPDATE OPEN.mo_packages
           SET motive_status_id = 14
         WHERE package_id = reg.package_id;
      EXCEPTION
        WHEN OTHERS THEN
          rollback;
          nuError := 1;
          dbms_output.put_line('Error actaulizando el estado de la solicitud|' ||
                               reg.package_id || '|' || sqlerrm);
      END;
    END IF;
  
    IF nuError = 0 THEN
      BEGIN
      
        PACKAGE_IDvar           := reg.package_id;
        CUST_CARE_REQUES_NUMvar := damo_packages.fsbgetcust_care_reques_num(reg.package_id,
                                                                            null);
        PACKAGE_TYPE_IDvar      := damo_packages.fnugetpackage_type_id(reg.package_id,
                                                                       null);
        O_MOTIVE_STATUS_IDVar   := reg.motive_status_id;
      
        INSERT INTO MO_PACKAGE_CHNG_LOG
          (CURRENT_USER_ID,
           CURRENT_USER_MASK,
           CURRENT_TERMINAL,
           CURRENT_TERM_IP_ADDR,
           CURRENT_DATE,
           CURRENT_TABLE_NAME,
           CURRENT_EXEC_NAME,
           CURRENT_SESSION_ID,
           CURRENT_EVENT_ID,
           CURRENT_EVEN_DESC,
           CURRENT_PROGRAM,
           CURRENT_MODULE,
           CURRENT_CLIENT_INFO,
           CURRENT_ACTION,
           PACKAGE_CHNG_LOG_ID,
           PACKAGE_ID,
           CUST_CARE_REQUES_NUM,
           PACKAGE_TYPE_ID,
           O_MOTIVE_STATUS_ID,
           N_MOTIVE_STATUS_ID)
        VALUES
          (AU_BOSystem.getSystemUserID,
           AU_BOSystem.getSystemUserMask,
           ut_session.getTERMINAL,
           ut_session.getIP,
           ut_date.fdtSysdate,
           CURRENT_TABLE_NAMEvar,
           AU_BOSystem.getSystemProcessName,
           ut_session.getSESSIONID,
           CURRENT_EVENT_IDvar,
           CURRENT_EVEN_DESCvar,
           ut_session.getProgram || '-' || SBCOMMENT,
           ut_session.getModule,
           ut_session.GetClientInfo,
           ut_session.GetAction,
           MO_BOSEQUENCES.fnuGetSeq_MO_PACKAGE_CHNG_LOG,
           PACKAGE_IDvar,
           CUST_CARE_REQUES_NUMvar,
           PACKAGE_TYPE_IDvar,
           O_MOTIVE_STATUS_IDVar,
           14);
      
      EXCEPTION
        WHEN OTHERS THEN
          rollback;
          dbms_output.put_line('Error registrado el cambio  de estado de la solicitud|' ||
                               reg.package_id || '|' || sqlerrm);
          nuError := 1;
      END;
    
    END IF;
  
    IF nuError = 0 THEN
      commit;
      dbms_output.put_line('Actualizacion de la solicitud de regsitro de daño ' ||
                           reg.package_id || ' Ok.');
    END IF;
  
  END LOOP;
END;
/


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/