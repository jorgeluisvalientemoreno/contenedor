column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
Declare
  --
  /*
  Datafix para anular solicitudes 
  */
  cursor cuSolicitudes is
        SELECT p2.package_id,
               p2.request_Date,
               p2.motive_status_id,
               p2.user_id,
               p2.comment_,
               p2.cust_care_reques_num,
               p2.package_type_id
        FROM  OPEN.mo_packages p
        INNER JOIN OPEN.mo_packages p2 on p2.cust_care_reques_num = to_char(p.cust_care_reques_num)
        WHERE p.package_id IN (213641388)
        AND   p2.motive_status_id = 13
        ORDER BY  p2.package_id;
  
  -- Motivo de la solicitud      
  cursor cuMo_motive(nuSolicitud number) is
    select mo.motive_id
      from open.mo_motive mo
     where mo.package_id = nuSolicitud;
     
  -- Carga de Person ID para el comentario
  CURSOR cuGe_person IS
    select ge_person.person_id
      from open.ge_person
     where ge_person.person_id = 13552; -- ALBA PINEDA     

  sbComment       VARCHAR2(4000) := 'Se cambia estado a anulado por caso OSF-2805';
  sbMo_comment    mo_comment.comment_%type := 'Se cambia estado a anulado por caso OSF-2805';
  sbmensaje       VARCHAR2(4000);
  eerrorexception EXCEPTION;
  onuErrorCode    NUMBER(18);
  osbErrorMessage VARCHAR2(2000);
  cnuCommentType  CONSTANT NUMBER := 83;
  nuPlanId        wf_instance.instance_id%TYPE;
  nuError         NUMBER;
  nuCommentType   NUMBER := 1277;
  nuErrorCode     NUMBER;
  sbErrorMesse    VARCHAR2(4000);
  TYPE t_array_solicitudes IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

  v_array_solicitudes     t_array_solicitudes;

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

  cursor cuErrorFlujo(nuSol number) is
    SELECT 'MOPRP' FORMA,
           P.PACKAGE_ID,
           P.MOTIVE_STATUS_ID,
           P.PACKAGE_TYPE_ID,
           P.REQUEST_DATE,
           EL.MESSAGE,
           NULL,
           EL.date_,
           LM.EXECUTOR_LOG_ID CODIGO_CAMBIAR1,
           NULL CODIGO_CAMBIAR2
      FROM OPEN.MO_EXECUTOR_LOG_MOT LM,
           OPEN.GE_EXECUTOR_LOG     EL,
           OPEN.MO_PACKAGES         P
     WHERE LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
       AND P.PACKAGE_ID = LM.PACKAGE_ID
       AND LM.STATUS_EXEC_LOG_ID = 4
       AND P.PACKAGE_ID = nuSol
    UNION ALL
    SELECT 'MOPWP' FORMA,
           P.PACKAGE_ID,
           P.MOTIVE_STATUS_ID,
           P.PACKAGE_TYPE_ID,
           P.REQUEST_DATE,
           EL.MESSAGE,
           NULL,
           EL.date_,
           LM.WF_PACK_INTERFAC_ID CODIGO_CAMBIAR1,
           NULL CODIGO_CAMBIAR2
      FROM OPEN.MO_WF_PACK_INTERFAC LM,
           OPEN.GE_EXECUTOR_LOG     EL,
           OPEN.MO_PACKAGES         P
     WHERE LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
       AND P.PACKAGE_ID = LM.PACKAGE_ID
       AND LM.STATUS_ACTIVITY_ID = 4
       AND P.PACKAGE_ID = nuSol
    UNION ALL
    SELECT 'MOPWM' FORMA,
           P.PACKAGE_ID,
           P.MOTIVE_STATUS_ID,
           P.PACKAGE_TYPE_ID,
           P.REQUEST_DATE,
           EL.MESSAGE,
           NULL,
           EL.date_,
           WF_MOTIV_INTERFAC_ID CODIGO_CAMBIAR1,
           NULL CODIGO_CAMBIAR2
      FROM OPEN.MO_WF_MOTIV_INTERFAC LM,
           OPEN.GE_EXECUTOR_LOG      EL,
           OPEN.MO_PACKAGES          P,
           OPEN.MO_MOTIVE            M
     WHERE LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
       AND P.PACKAGE_ID = M.PACKAGE_ID
       AND M.MOTIVE_ID = LM.MOTIVE_ID
       AND LM.STATUS_ACTIVITY_ID = 4       
       AND P.PACKAGE_ID = nuSol
    UNION ALL
    SELECT 'MOPWC' FORMA,
           P.PACKAGE_ID,
           P.MOTIVE_STATUS_ID,
           P.PACKAGE_TYPE_ID,
           P.REQUEST_DATE,
           EL.MESSAGE,
           NULL,
           EL.date_,
           WF_COMP_INTERFAC_ID CODIGO_CAMBIAR1,
           NULL CODIGO_CAMBIAR2           
      FROM OPEN.MO_WF_COMP_INTERFAC LM,
           OPEN.GE_EXECUTOR_LOG     EL,
           OPEN.MO_PACKAGES         P,
           OPEN.MO_COMPONENT        C
     WHERE LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
       AND P.PACKAGE_ID = C.PACKAGE_ID
       AND C.COMPONENT_ID = LM.COMPONENT_ID
       AND LM.STATUS_ACTIVITY_ID = 4
       AND P.PACKAGE_ID = nuSol
    UNION ALL
    SELECT 'INRMO/WFEWF' FORMA,
           P.PACKAGE_ID,
           P.MOTIVE_STATUS_ID,
           P.PACKAGE_TYPE_ID,
           P.REQUEST_DATE,
           EL.MESSAGE_DESC,
           WF.INSTANCE_ID,
           EL.LOG_DATE,
           WF.INSTANCE_ID CODIGO_CAMBIAR1,
           EL.EXCEPTION_LOG_ID CODIGO_CAMBIAR2
      FROM OPEN.WF_INSTANCE      WF,
           OPEN.WF_EXCEPTION_LOG EL,
           OPEN.MO_PACKAGES      P,
           OPEN.WF_DATA_EXTERNAL DE
     WHERE WF.INSTANCE_ID = EL.INSTANCE_ID
       AND DE.PLAN_ID = WF.PLAN_ID
       AND DE.PACKAGE_ID = P.PACKAGE_ID
       AND WF.STATUS_ID = 9
       AND EL.STATUS = 1
       AND P.PACKAGE_ID = nuSol
    UNION ALL
    SELECT 'INRMO' FORMA,
           P.PACKAGE_ID,
           P.MOTIVE_STATUS_ID,
           P.PACKAGE_TYPE_ID,
           P.REQUEST_DATE,
           LAST_MESS_DESC_ERROR,
           W.INSTANCE_ID,
           I.INSERTING_DATE,
           I.INTERFACE_HISTORY_ID CODIGO_CAMBIAR1,
           NULL CODIGO_CAMBIAR2           
      FROM OPEN.IN_INTERFACE_HISTORY I,
           OPEN.WF_INSTANCE          W,
           OPEN.MO_PACKAGES          P,
           OPEN.WF_DATA_EXTERNAL     DE
     WHERE I.STATUS_ID = 9
       AND I.REQUEST_NUMBER_ORIGI = W.INSTANCE_ID
       AND DE.PLAN_ID = W.PLAN_ID
       AND DE.PACKAGE_ID = P.PACKAGE_ID
       AND P.PACKAGE_ID = nuSol;

  rgErrorFlujo cuErrorFlujo%rowtype;
  -- Secuencia MO_COMMENT
  nuseqcomment mo_comment.comment_id%type;
  numotive     mo_motive.motive_id%type;
  nuPersonID   open.ge_person.person_id%type;

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
      --
      FOR regOt IN cuOrdenes(reg.package_id) LOOP
        BEGIN
          ldc_cancel_order(regOt.order_id,
                           3446,
                           SBCOMMENT,
                           cnuCommentType,
                           onuErrorCode,
                           osbErrorMessage);
          if onuErrorCode <> 0 then
            nuError := 1;
            rollback;
          end if;
        
        EXCEPTION
          WHEN OTHERS THEN
            nuError := 1;
            rollback;
        END;
      END LOOP;
      --
      IF nuError = 0 THEN
        BEGIN
          --Cambio estado de la solicitud
          UPDATE OPEN.mo_packages
             SET motive_status_id = dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'), attention_date = sysdate
           WHERE package_id IN (reg.package_id);
          -- Registro cambio de estado de la solicitud
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
             ut_session.getProgram || ' - ' || SBCOMMENT,
             ut_session.getModule,
             ut_session.GetClientInfo,
             ut_session.GetAction,
             MO_BOSEQUENCES.fnuGetSeq_MO_PACKAGE_CHNG_LOG,
             PACKAGE_IDvar,
             CUST_CARE_REQUES_NUMvar,
             PACKAGE_TYPE_IDvar,
             O_MOTIVE_STATUS_IDVar,
             dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'));
             
          -- Adicionamos el registro de comentario del motivo
          nuseqcomment :=  SEQ_MO_COMMENT.NEXTVAL;
          --
          numotive   := NULL;
          nuPersonID := NULL;
          --
          -- Arma el registro del comment de la orden dejando evidencia de ANULACION de la orden
          open cuGe_person;
          fetch cuGe_person into nuPersonID;
          close cuGe_person;
          --
          open cumo_motive(reg.package_id);
          fetch cumo_motive into numotive;
          close cumo_motive;
          --
          INSERT INTO MO_COMMENT
            (comment_id,
             comment_,
             motive_id,
             comment_type_id,
             package_id,
             register_date,
             person_id,
             organizat_area_id,
             limit_response_date,
             histor_nav_id)
          VALUES
            (
             nuseqcomment,
             sbMo_comment,
             numotive,
             2,
             reg.package_id,
             sysdate,
             nuPersonID,
             NULL,
             NULL,
             NULL
            );
          --
          UPDATE OPEN.mo_motive
             SET annul_date         = SYSDATE,
                 status_change_date = SYSDATE,
                 annul_causal_id    = ge_boparameter.fnuget('ANNUL_CAUSAL'),
                 motive_status_id   = 5,
                 causal_id          = 287,
                 attention_date     = sysdate
           WHERE package_id IN (reg.package_id);
        EXCEPTION
          WHEN OTHERS THEN
            rollback;
            nuError := 1;
            dbms_output.put_line('Error anulando solicitud|' ||
                                 reg.package_id || '|' || sqlerrm);
        END;
        
        
        IF nuError = 0 THEN
          COMMIT;
          --
          nuPlanId := 0;
          nuPlanId := wf_boinstance.fnugetplanid(reg.package_id, 17);
          --
          -- Anula el plan de wf
          IF nuPlanId != 0 then
            --
            BEGIN
              mo_boannulment.annulwfplan(nuPlanId);
            EXCEPTION
              WHEN OTHERS THEN
                rollback;
                nuError := 1;
                dbms_output.put_line('Error anulando plan solicitud|' ||
                                     reg.package_id || '|' || sqlerrm);
            END;
            --
            IF nuError = 0 THEN
              IF cuErrorFlujo%isopen THEN
                CLOSE cuErrorFlujo;
              END IF;
              OPEN cuErrorFlujo(reg.package_id);
              FETCH cuErrorFlujo
                into rgErrorFlujo;
              IF cuErrorFlujo%notfound THEN
                COMMIT;
                dbms_output.put_line('SOLICITUD ANULADA SIN ERROR DE FLUJO|' ||
                                     reg.package_id || ' nuPersonID ' || nuPersonID);
              ELSE
                  CASE rgErrorFlujo.FORma 
                      WHEN 'MOPRP' THEN
                          UPDATE MO_EXECUTOR_LOG_MOT i
                             set i.status_exec_log_id = 3 -- Procesado
                           where i.EXECUTOR_LOG_MOT_ID = rgErrorFlujo.CODIGO_CAMBIAR1;
                      WHEN 'MOPWP' THEN
                          UPDATE MO_WF_PACK_INTERFAC i
                             set i.status_activity_id = 3 -- Atendida
                           where i.WF_PACK_INTERFAC_ID = rgErrorFlujo.CODIGO_CAMBIAR1;                    
                      WHEN 'MOPWM' THEN
                          UPDATE MO_WF_MOTIV_INTERFAC i
                             set i.status_activity_id = 3 -- Atendida
                           where i.WF_MOTIV_INTERFAC_ID = rgErrorFlujo.CODIGO_CAMBIAR1; 
                      WHEN 'MOPWC' THEN
                          UPDATE MO_WF_COMP_INTERFAC i
                             set i.status_activity_id = 3 -- Atendida
                           where i.WF_COMP_INTERFAC_ID = rgErrorFlujo.CODIGO_CAMBIAR1;                     
                      WHEN 'INRMO/WFEWF' THEN
                          UPDATE WF_INSTANCE i
                             set i.status_id = 8 -- Cancelada
                           where i.INSTANCE_ID = rgErrorFlujo.CODIGO_CAMBIAR1;                     
                          UPDATE WF_EXCEPTION_LOG i
                             set i.status = 2 -- Resuelta
                           where i.EXCEPTION_LOG_ID = rgErrorFlujo.CODIGO_CAMBIAR2; 
                      WHEN 'INRMO' THEN
                          UPDATE IN_INTERFACE_HISTORY i
                             set i.status_id = 6 -- Mensaje cancelado
                           where i.INTERFACE_HISTORY_ID = rgErrorFlujo.CODIGO_CAMBIAR1;
                  END CASE;
                COMMIT;
                dbms_output.put_line('SOLICITUD ANULADA CON ERROR DE FLUJO|' ||
                                     reg.package_id);
              END IF;
              CLOSE cuErrorFlujo;
            END IF;
            --
        END IF;
      END IF;
    END IF;
   END IF; --1 VALIDACION
  END LOOP;
END;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/