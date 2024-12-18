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
     WHERE p.package_id IN (216611380, 216611437)
       AND p2.motive_status_id = 49
     ORDER BY p2.package_id;

  sbComment       VARCHAR2(4000) := 'Se cambia estado a anulado por OSF-3050';
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
    IF nuError = 0 THEN
      --1 VALIDACION
      BEGIN
        ldc_pkg_changstatesolici.packageinttransition(reg.package_id,
                                                      ge_boparameter.fnuget('ANNUL_CAUSAL'));
      EXCEPTION
        WHEN OTHERS THEN
          rollback;
          nuError := 0;
      END;
    
      BEGIN
        update open.tt_damage d
           set d.reg_damage_status = 'I', d.approval = 'N'
         where d.package_id = reg.package_id;
      EXCEPTION
        WHEN OTHERS THEN
          rollback;
          nuError := 0;
      END;
    
      IF nuError = 0 THEN
        BEGIN
          --Cambio estado de la solicitud
          UPDATE OPEN.mo_packages
             SET motive_status_id = dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
           WHERE package_id IN (reg.package_id);
        
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
             dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'));
        
        EXCEPTION
          WHEN OTHERS THEN
            rollback;
            nuError := 1;
            dbms_output.put_line('Error anulando solicitud|' ||
                                 reg.package_id || '|' || sqlerrm);
        END;
        IF nuError = 0 THEN
          COMMIT;
          BEGIN
            nuPlanId := wf_boinstance.fnugetplanid(reg.package_id, 17);
          EXCEPTION
            WHEN OTHERS THEN
              rollback;
              nuError := 1;
              dbms_output.put_line('Error anulando plan solicitud|' ||
                                   reg.package_id || '|' || sqlerrm);
            
          END;
        
        END IF;
      END IF;
    END IF; ----1 VALIDACION
  END LOOP;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/