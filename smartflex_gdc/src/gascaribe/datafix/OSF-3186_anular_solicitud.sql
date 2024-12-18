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
     WHERE p.package_id IN (216962579)
       AND p2.motive_status_id = 13
     ORDER BY p2.package_id;

  sbComment       VARCHAR2(4000) := 'Se cambia a estado anulado por OSF-3186';
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

  cursor cuOrdenes(nuSolicitud number) is
    select o.order_id, order_status_id, o.operating_unit_id
      from open.or_order o, open.or_order_activity A
     where a.order_id = o.order_id
       and a.package_id = nuSolicitud
       and a.status != 'F';

BEGIN

  FOR reg IN cuSolicitudes LOOP
    nuError := 0;
    IF nuError = 0 THEN
    
      IF nuError = 0 THEN
        PACKAGE_IDvar           := reg.package_id;
        CUST_CARE_REQUES_NUMvar := damo_packages.fsbgetcust_care_reques_num(reg.package_id,
                                                                            null);
        PACKAGE_TYPE_IDvar      := damo_packages.fnugetpackage_type_id(reg.package_id,
                                                                       null);
        O_MOTIVE_STATUS_IDVar   := DAMO_MOTIVE.FNUGETMOTIVE_STATUS_ID(MO_BCPACKAGES.FNUGETMOTIVEID(reg.package_id));
      
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
      
        IF nuError = 0 THEN
        
          --Cambio estado de la solicitud
          UPDATE OPEN.mo_packages
             SET motive_status_id = dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'),
                 attention_date   = sysdate
           WHERE package_id IN (reg.package_id);
        
          UPDATE OPEN.mo_motive
             SET annul_date         = SYSDATE,
                 status_change_date = SYSDATE,
                 annul_causal_id    = ge_boparameter.fnuget('ANNUL_CAUSAL'),
                 motive_status_id   = 5,
                 causal_id          = 287,
                 attention_date     = sysdate
           WHERE package_id IN (reg.package_id);
        
        END IF;
      END IF;
    END IF;
  END LOOP;
  
  begin

    commit;
    dbms_output.put_line('Se anulo la solicitud 216962579 - Ok.');

  exception
    when others then
      dbms_output.put_line('Error - No se anulo la solicitud 216962579 - ' || sqlerrm);
  end;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/