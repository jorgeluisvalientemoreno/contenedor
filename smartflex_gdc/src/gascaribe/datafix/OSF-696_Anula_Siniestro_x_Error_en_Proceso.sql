column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  DECLARE

  SBCOMMENT                VARCHAR2(4000) := 'SE ANULA POR CASO OSF-696';
  sbmensaje                VARCHAR2(4000);
  eerrorexception          EXCEPTION;
  onuErrorCode             NUMBER(18);
  osbErrorMessage          VARCHAR2(2000);
  cnuCommentType           CONSTANT NUMBER := 83;
  nuNotas                  NUMBER;
  TYPE t_array_solicitudes IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
  nuPlanId                 wf_instance.instance_id%type;
  v_array_solicitudes      t_array_solicitudes;
  numotiv                  NUMBER;
  nuprodu                  NUMBER;
  numoti2                  NUMBER;

  -- Solicitudes
  cursor cuSolicitudes is
  select m.package_id
    from open.mo_packages m
   where m.package_id in (177311017,191997056);
  -- Mo_Motive
  Cursor CuMomotive(nusol number) is
  select m.motive_id, m.product_id
    from open.mo_motive m
   where m.package_id = nusol;  
  -- Ordenes
  cursor cuOrdenes(nusol number) is
  select o.order_id, order_status_id, o.operating_unit_id
    from open.or_order o, open.or_order_activity A
   where a.order_id = o.order_id  
     and a.package_id = nusol
     and a.status! = 'F';
  -- CARGTRAM
  Cursor CuCargtram(numov number)  is
  select catrmoti
    from open.cargtram c
   where c.catrmoti = numov;      
     
  PACKAGE_IDvar           MO_PACKAGE_CHNG_LOG.PACKAGE_ID%type := null;
  CUST_CARE_REQUES_NUMvar MO_PACKAGE_CHNG_LOG.CUST_CARE_REQUES_NUM%type := null;
  PACKAGE_TYPE_IDvar      MO_PACKAGE_CHNG_LOG.PACKAGE_TYPE_ID%type := null;
  CURRENT_TABLE_NAMEvar   MO_PACKAGE_CHNG_LOG.CURRENT_TABLE_NAME%type := 'MO_PACKAGES';
  CURRENT_EVENT_IDvar     MO_PACKAGE_CHNG_LOG.CURRENT_EVENT_ID%type := ge_boconstants.UPDATE_;
  CURRENT_EVEN_DESCvar    MO_PACKAGE_CHNG_LOG.CURRENT_EVEN_DESC%type := 'UPDATE';
  O_MOTIVE_STATUS_IDVar   MO_PACKAGE_CHNG_LOG.o_motive_status_id%TYPE;

BEGIN
  
  FOR sol in cuSolicitudes LOOP

    IF sol.package_id IS NOT NULL  AND DAMO_PACKAGES.FNUGETPACKAGE_ID(sol.package_id,NULL) = sol.package_id THEN
          
          -- Se anulan las ordenes
          FOR reg in cuOrdenes(sol.package_id) LOOP

            BEGIN
              ldc_cancel_order(
                               reg.order_id,
                               3446,
                               SBCOMMENT,
                               cnuCommentType,
                               onuErrorCode,
                               osbErrorMessage
                               );

            EXCEPTION
             WHEN OTHERS THEN
              sbmensaje := 'Error ldc_cancel_order : '||to_char(onuErrorCode)||' - '||osbErrorMessage||' - '||sbmensaje;
              RAISE eerrorexception;
            END;
          END LOOP;
       
           --Cambio estado de la solicitud
           UPDATE open.mo_packages
              SET motive_status_id = dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
            WHERE package_id IN (sol.package_id);
        
          PACKAGE_IDvar            :=  sol.package_id;
          CUST_CARE_REQUES_NUMvar  :=  damo_packages.fsbgetcust_care_reques_num(sol.package_id,null);
          PACKAGE_TYPE_IDvar       :=  damo_packages.fnugetpackage_type_id(sol.package_id,null);
          O_MOTIVE_STATUS_IDVar    :=  DAMO_MOTIVE.FNUGETMOTIVE_STATUS_ID(MO_BCPACKAGES.FNUGETMOTIVEID(sol.package_id));

        INSERT INTO MO_PACKAGE_CHNG_LOG  (
            CURRENT_USER_ID,
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
            N_MOTIVE_STATUS_ID
            )
         VALUES
         (
            AU_BOSystem.getSystemUserID,
            AU_BOSystem.getSystemUserMask,
            ut_session.getTERMINAL,
            ut_session.getIP,
            ut_date.fdtSysdate,
            CURRENT_TABLE_NAMEvar,
            AU_BOSystem.getSystemProcessName,
            ut_session.getSESSIONID,
            CURRENT_EVENT_IDvar,
            CURRENT_EVEN_DESCvar,
            ut_session.getProgram||'-'||SBCOMMENT,
            ut_session.getModule,
            ut_session.GetClientInfo,
            ut_session.GetAction,
            MO_BOSEQUENCES.fnuGetSeq_MO_PACKAGE_CHNG_LOG,
            PACKAGE_IDvar,
            CUST_CARE_REQUES_NUMvar,
            PACKAGE_TYPE_IDvar,
            O_MOTIVE_STATUS_IDVar,
            dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
        ) ;
            --Cambio estado del motivo
            UPDATE open.mo_motive
               SET annul_date         = SYSDATE,
                   status_change_date = SYSDATE,
                   annul_causal_id    = ge_boparameter.fnuget('ANNUL_CAUSAL'),
                   motive_status_id   = 5,
                   causal_id          = 274 -- Error en digitacion, la que mas se ajusta, es por error en el proceso.
             WHERE package_id IN (sol.package_id);
             -- Se obtiene el plan de wf
             BEGIN
               nuPlanId := wf_boinstance.fnugetplanid(sol.package_id, 17);
             EXCEPTION
              WHEN OTHERS THEN
               sbmensaje := 'error wf_boinstance.fnugetplanid : '||to_char(sol.package_id)||' - '||SQLERRM;
               RAISE eerrorexception;
             END;
              -- anula el plan de wf
             BEGIN
              mo_boannulment.annulwfplan(nuPlanId);
             EXCEPTION
              WHEN OTHERS THEN
               sbmensaje := 'error mo_boannulment.annulwfplan : '||to_char(nuPlanId)||' - '||SQLERRM;
               RAISE eerrorexception;
             END;
             -- Valores en reclamo
             OPEN CuMomotive(sol.package_id);
             FETCH CuMomotive INTO numotiv, nuprodu;
             IF CuMomotive%FOUND THEN
               OPEN CuCargtram(numotiv);
               FETCH CuCargtram INTO numoti2;
               IF CuCargtram%NOTFOUND THEN
                 UPDATE CUENCOBR CO
                    SET CO.CUCOVARE = 0
                  WHERE CO.CUCONUSE = nuprodu
                    AND CO.CUCOVARE != 0;
               END IF;
             END IF;  
             CLOSE CuMomotive;
             CLOSE CuCargtram;
             --
         COMMIT;
      
      END IF;
    
  END LOOP;
  
  
EXCEPTION
WHEN OTHERS THEN 
  ROLLBACK;
  DBMS_OUTPUT.PUT_LINE(SQLERRM||' '||sbmensaje);
END;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/