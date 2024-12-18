  DECLARE

  SBCOMMENT                VARCHAR2(4000) := 'SE ANULA POR SOLICITUD OSF-518';
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
   where m.package_id in (186860249,186927763,188649606,188675808,188425877,188418930,187391853,187427722,187904097,187904318,188419446,
                          186599570,187621765,187394217,187393777,188911814,188909923,184227826,181042016,188923476,189003806,188933731,
                          89193458,189175144,189178855,189171642,189509573,189449248,189494224,189438061,183683409);
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
          
          --Se realiza la transicion de estados de la solicitud y el producto
   --       BEGIN
   --        ldc_pkg_changstatesolici.packageinttransition(sol.package_id,ge_boparameter.fnuget('ANNUL_CAUSAL'));
   --       EXCEPTION
   --        WHEN OTHERS THEN
   --         sbmensaje := ' SOLICITUD : '||sol.package_id||'- ldc_pkg_changstatesolici.packageinttransition : '||SQLERRM;
   --         RAISE eerrorexception;
   --       END;

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

          -- Insertamos en el log de cambios de solicitud
          BEGIN
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
              
           EXCEPTION
             WHEN OTHERS THEN
              sbmensaje := 'error MO_PACKAGE_CHNG_LOG : '||to_char(PACKAGE_IDvar) ||' - '|| SQLERRM;
              RAISE eerrorexception;
           END;
                         
           -- Cambio estado del motivo
           BEGIN
              UPDATE open.mo_motive
                 SET annul_date         = SYSDATE,
                     status_change_date = SYSDATE,
                     annul_causal_id    = ge_boparameter.fnuget('ANNUL_CAUSAL'),
                     motive_status_id   = 5,
                     causal_id          = 287
               WHERE package_id IN (sol.package_id);
           EXCEPTION
              WHEN OTHERS THEN
               sbmensaje := 'error open.mo_motiv : '||to_char(sol.package_id)||' - '||SQLERRM;
               RAISE eerrorexception;
           END;
            
            -- Se obtiene el plan de wf
           BEGIN
               nuPlanId := wf_boinstance.fnugetplanid(sol.package_id, 17);
           EXCEPTION
              WHEN OTHERS THEN
               sbmensaje := 'error wf_boinstance.fnugetplanid : '||to_char(sol.package_id)||' - '||SQLERRM;
               RAISE eerrorexception;
           END;
           
            -- Anula el plan de wf
           BEGIN
              mo_boannulment.annulwfplan(nuPlanId);
           EXCEPTION
              WHEN OTHERS THEN
               sbmensaje := 'error mo_boannulment.annulwfplan : '||to_char(nuPlanId)||' - '||SQLERRM;
               RAISE eerrorexception;
           END;
           
           -- Valores en reclamo
           BEGIN
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
           EXCEPTION
              WHEN OTHERS THEN
               sbmensaje := 'error CuMomotive : '||to_char(nuPlanId)||' - '||SQLERRM;
               RAISE eerrorexception;
           END;             
           --
         COMMIT;
      
      END IF;
    
  END LOOP;
  
  
EXCEPTION
WHEN OTHERS THEN 
  ROLLBACK;
  DBMS_OUTPUT.PUT_LINE(SQLERRM||' '||sbmensaje);
END;
/
