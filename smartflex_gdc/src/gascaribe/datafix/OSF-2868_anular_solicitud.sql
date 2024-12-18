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
        INNER JOIN OPEN.mo_packages p2 on p2.cust_care_reques_num = to_char(p.cust_care_reques_num)
        WHERE p.package_id IN (158758150)
		AND p2.motive_status_id = 13
        ORDER BY  p2.package_id;

  sbComment VARCHAR2(4000) := 'Se cambia estado a anulado por OSF-2868';
  sbmensaje VARCHAR2(4000);
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

  cursor cuErrorFlujo(nuSol number) is
    SELECT 'MOPRP' FORMA,
           P.PACKAGE_ID,
           P.MOTIVE_STATUS_ID,
           P.PACKAGE_TYPE_ID,
           P.REQUEST_DATE,
           EL.MESSAGE,
           NULL,
           EL.date_,
           NULL CODIGO_CAMBIAR
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
           NULL CODIGO_CAMBIAR
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
           NULL CODIGO_CAMBIAR
      FROM OPEN.MO_WF_MOTIV_INTERFAC LM,
           OPEN.GE_EXECUTOR_LOG      EL,
           OPEN.MO_PACKAGES          P,
           OPEN.MO_MOTIVE            M
     WHERE LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
       AND P.PACKAGE_ID = M.PACKAGE_ID
       AND M.MOTIVE_ID = LM.MOTIVE_ID
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
           NULL CODIGO_CAMBIAR
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
           NULL CODIGO_CAMBIAR
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
           I.INTERFACE_HISTORY_ID CODIGO_CAMBIAR
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

  CURSOR cuOrderActiv is
    select nvl(product_id,52098239) PRODUCTO, oa.order_id ORDEN, oa.task_type_id, o.causal_id CAUSAL, gc.class_causal_id, o.order_status_id
    from open.or_order_activity oa 
    inner join open.or_order o ON  oa.order_id = o.order_id
    left join open.ge_causal gc ON o.causal_id = gc.causal_id
    where oa.package_id = 158758150--cnuPackage_id 
    and nvl(gc.class_causal_id,0) != 1 
    and o.order_status_id  in (12)
    and rownum= 1;

BEGIN
  dbms_output.put_line('Inicia datafix OSF-2868');
  FOR reg IN cuSolicitudes LOOP
    nuError := 0;
    IF nuError = 0 THEN
      --1 VALIDACION
      BEGIN
        dbms_output.put_line('Cambia Transición OSF-2868');
        ldc_pkg_changstatesolici.packageinttransition(reg.package_id,
                                                      ge_boparameter.fnuget('ANNUL_CAUSAL'));
        dbms_output.put_line('Termina Cambia Transición OSF-2868');
      EXCEPTION
        WHEN OTHERS THEN
          rollback;
          nuError := 0;
      END; 
      FOR regOt IN cuOrdenes(reg.package_id) LOOP
        BEGIN
          dbms_output.put_line('Anula ordenes OSF-2868');

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
          dbms_output.put_line('Termina ordenes OSF-2868');
        EXCEPTION
          WHEN OTHERS THEN
            nuError := 1;
            rollback;
        END;
      END LOOP;
      IF nuError = 0 THEN
        BEGIN
          dbms_output.put_line('Actualiza estados de la solicitud');
          --Cambio estado de la solicitud
          UPDATE OPEN.mo_packages
             SET motive_status_id = dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'), attention_date = sysdate
           WHERE package_id IN (reg.package_id);
        
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
        
          UPDATE OPEN.mo_motive
             SET annul_date         = SYSDATE,
                 status_change_date = SYSDATE,
                 annul_causal_id    = ge_boparameter.fnuget('ANNUL_CAUSAL'),
                 motive_status_id   = 5,
                 causal_id          = 287,
				 attention_date     = sysdate
           WHERE package_id IN (reg.package_id);

           dbms_output.put_line('Termina Actualiza estados de la solicitud');
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
            dbms_output.put_line('Obtiene el plan del flujo');
            nuPlanId := wf_boinstance.fnugetplanid(reg.package_id, 17);
          EXCEPTION
            WHEN OTHERS THEN
              rollback;
              nuError := 1;
              dbms_output.put_line('Error anulando plan solicitud|' ||
                                   reg.package_id || '|' || sqlerrm);
            
          END;
          -- anula el plan de wf

          IF (NVL(nuPlanId,0) <> 0) THEN
            BEGIN
              dbms_output.put_line('Anula el flujo');
              mo_boannulment.annulwfplan(nuPlanId);
              dbms_output.put_line('Termina anula el flujo');
            EXCEPTION
              WHEN OTHERS THEN
                rollback;
                nuError := 0;
              
            END;
          END IF;
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
                                   reg.package_id);
            ELSE
              IF rgErrorFlujo.FORma = 'INRMO' THEN
                UPDATE IN_INTERFACE_HISTORY i
                   set i.status_id = 6
                 where i.INTERFACE_HISTORY_ID = rgErrorFlujo.CODIGO_CAMBIAR;
              END IF;
              COMMIT;
              dbms_output.put_line('SOLICITUD ANULADA CON ERROR DE FLUJO|' ||
                                   reg.package_id);
            END IF;
            CLOSE cuErrorFlujo;
          END IF;
        END IF;
      END IF;
    END IF; ----1 VALIDACION
  END LOOP;

      --Recorrer ordenes del contrato de venta a constructora
    FOR rcOrderActiv in cuOrderActiv LOOP
        -- Se actualiza la fecha de retiro en el producto y componente - GDGA 15/02/2024
        update pr_product
        set product_status_id = 16,  -- Retirado sin instalacion
        suspen_ord_act_id = null,
        retire_date = sysdate
        where product_id = rcOrderActiv.PRODUCTO;

        -- Estado de corte
        pktblservsusc.updsesuesco(rcOrderActiv.PRODUCTO, 110    -- Retiro para el tipo de producto 6121
                                    -- 110 -- Retirado sin instalacion. para el tipo de producto 7014
            ); 

        UPDATE servsusc
        SET    sesufere = sysdate
        WHERE  sesunuse = rcOrderActiv.PRODUCTO;

        -- componente del producto
        update pr_component
        set component_status_id = 18  -- Retirado sin instalacion
        where product_id = rcOrderActiv.PRODUCTO;

        update compsesu
        set cmssescm = 18,  --
        cmssfere = sysdate
        where cmsssesu = rcOrderActiv.PRODUCTO;
    END LOOP;

    COMMIT;
  dbms_output.put_line('Fin datafix OSF-2868');
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/