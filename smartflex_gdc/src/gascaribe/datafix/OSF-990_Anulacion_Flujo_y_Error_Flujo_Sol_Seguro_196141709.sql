COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT TO_CHAR (SYSDATE, 'yyyymmdd_hh24miss')     dt,
       SYS_CONTEXT ('userenv', 'db_name')         db
  FROM DUAL;
SET SERVEROUTPUT ON SIZE UNLIMITED
EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX');
SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM DUAL;

DECLARE
    CURSOR cuSolicitudes IS
        SELECT p.package_id,
               p.request_Date,
               p.motive_status_id,
               p.user_id,
               p.comment_,
               p.cust_care_reques_num,
               p.package_type_id
          FROM OPEN.mo_packages p
         WHERE p.package_id IN (196141709) AND p.motive_status_id = 32;


    nuPlanId                  wf_instance.instance_id%TYPE;
    nuError                   NUMBER;

    CURSOR cuErrorFlujo (nuSol NUMBER)
    IS
        SELECT 'MOPRP'                FORMA,
               P.PACKAGE_ID,
               P.MOTIVE_STATUS_ID,
               P.PACKAGE_TYPE_ID,
               P.REQUEST_DATE,
               EL.MESSAGE,
               NULL,
               EL.date_,
               LM.EXECUTOR_LOG_ID     CODIGO_CAMBIAR1,
               NULL                   CODIGO_CAMBIAR2
          FROM OPEN.MO_EXECUTOR_LOG_MOT  LM,
               OPEN.GE_EXECUTOR_LOG      EL,
               OPEN.MO_PACKAGES          P
         WHERE     LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
               AND P.PACKAGE_ID = LM.PACKAGE_ID
               AND LM.STATUS_EXEC_LOG_ID = 4
               AND P.PACKAGE_ID = nuSol
        UNION ALL
        SELECT 'MOPWP'                    FORMA,
               P.PACKAGE_ID,
               P.MOTIVE_STATUS_ID,
               P.PACKAGE_TYPE_ID,
               P.REQUEST_DATE,
               EL.MESSAGE,
               NULL,
               EL.date_,
               LM.WF_PACK_INTERFAC_ID     CODIGO_CAMBIAR1,
               NULL                       CODIGO_CAMBIAR2
          FROM OPEN.MO_WF_PACK_INTERFAC  LM,
               OPEN.GE_EXECUTOR_LOG      EL,
               OPEN.MO_PACKAGES          P
         WHERE     LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
               AND P.PACKAGE_ID = LM.PACKAGE_ID
               AND LM.STATUS_ACTIVITY_ID = 4
               AND P.PACKAGE_ID = nuSol
        UNION ALL
        SELECT 'MOPWM'                  FORMA,
               P.PACKAGE_ID,
               P.MOTIVE_STATUS_ID,
               P.PACKAGE_TYPE_ID,
               P.REQUEST_DATE,
               EL.MESSAGE,
               NULL,
               EL.date_,
               WF_MOTIV_INTERFAC_ID     CODIGO_CAMBIAR1,
               NULL                     CODIGO_CAMBIAR2
          FROM OPEN.MO_WF_MOTIV_INTERFAC  LM,
               OPEN.GE_EXECUTOR_LOG       EL,
               OPEN.MO_PACKAGES           P,
               OPEN.MO_MOTIVE             M
         WHERE     LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
               AND P.PACKAGE_ID = M.PACKAGE_ID
               AND M.MOTIVE_ID = LM.MOTIVE_ID
               AND LM.STATUS_ACTIVITY_ID = 4
               AND P.PACKAGE_ID = nuSol
        UNION ALL
        SELECT 'MOPWC'                 FORMA,
               P.PACKAGE_ID,
               P.MOTIVE_STATUS_ID,
               P.PACKAGE_TYPE_ID,
               P.REQUEST_DATE,
               EL.MESSAGE,
               NULL,
               EL.date_,
               WF_COMP_INTERFAC_ID     CODIGO_CAMBIAR1,
               NULL                    CODIGO_CAMBIAR2
          FROM OPEN.MO_WF_COMP_INTERFAC  LM,
               OPEN.GE_EXECUTOR_LOG      EL,
               OPEN.MO_PACKAGES          P,
               OPEN.MO_COMPONENT         C
         WHERE     LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
               AND P.PACKAGE_ID = C.PACKAGE_ID
               AND C.COMPONENT_ID = LM.COMPONENT_ID
               AND LM.STATUS_ACTIVITY_ID = 4
               AND P.PACKAGE_ID = nuSol
        UNION ALL
        SELECT 'INRMO/WFEWF'           FORMA,
               P.PACKAGE_ID,
               P.MOTIVE_STATUS_ID,
               P.PACKAGE_TYPE_ID,
               P.REQUEST_DATE,
               EL.MESSAGE_DESC,
               WF.INSTANCE_ID,
               EL.LOG_DATE,
               WF.INSTANCE_ID          CODIGO_CAMBIAR1,
               EL.EXCEPTION_LOG_ID     CODIGO_CAMBIAR2
          FROM OPEN.WF_INSTANCE       WF,
               OPEN.WF_EXCEPTION_LOG  EL,
               OPEN.MO_PACKAGES       P,
               OPEN.WF_DATA_EXTERNAL  DE
         WHERE     WF.INSTANCE_ID = EL.INSTANCE_ID
               AND DE.PLAN_ID = WF.PLAN_ID
               AND DE.PACKAGE_ID = P.PACKAGE_ID
               AND WF.STATUS_ID = 9
               AND EL.STATUS = 1
               AND P.PACKAGE_ID = nuSol
        UNION ALL
        SELECT 'INRMO'                    FORMA,
               P.PACKAGE_ID,
               P.MOTIVE_STATUS_ID,
               P.PACKAGE_TYPE_ID,
               P.REQUEST_DATE,
               LAST_MESS_DESC_ERROR,
               W.INSTANCE_ID,
               I.INSERTING_DATE,
               I.INTERFACE_HISTORY_ID     CODIGO_CAMBIAR1,
               NULL                       CODIGO_CAMBIAR2
          FROM OPEN.IN_INTERFACE_HISTORY  I,
               OPEN.WF_INSTANCE           W,
               OPEN.MO_PACKAGES           P,
               OPEN.WF_DATA_EXTERNAL      DE
         WHERE     I.STATUS_ID = 9
               AND I.REQUEST_NUMBER_ORIGI = W.INSTANCE_ID
               AND DE.PLAN_ID = W.PLAN_ID
               AND DE.PACKAGE_ID = P.PACKAGE_ID
               AND P.PACKAGE_ID = nuSol;

    rgErrorFlujo              cuErrorFlujo%ROWTYPE;
BEGIN
    FOR reg IN cuSolicitudes
    LOOP
    
        DBMS_OUTPUT.put_line ( 'Solicitud|' ||reg.package_id );
        
        nuError := 0;
        
        UPDATE mo_packages_asso a
        SET annul_dependent = 'N'
        WHERE package_id = reg.package_id;
        
        DBMS_OUTPUT.put_line ( 'Se actualizó a N mo_packages_asso.annul_dependent' );

        IF nuError = 0
        THEN

            BEGIN
                nuPlanId := wf_boinstance.fnugetplanid (reg.package_id, 17);
            EXCEPTION
                WHEN OTHERS
                THEN
                    ROLLBACK;
                    nuError := 1;
                    DBMS_OUTPUT.put_line (
                           'Error anulando plan solicitud|'
                        || reg.package_id
                        || '|'
                        || SQLERRM);
            END;

            -- anula el plan de wf
            BEGIN
                mo_boannulment.annulwfplan (nuPlanId);
            EXCEPTION
                WHEN OTHERS
                THEN
                    ROLLBACK;
                    nuError := 1;
                    DBMS_OUTPUT.put_line (
                           'Error anulando plan solicitud|'
                        || reg.package_id
                        || '|'
                        || SQLERRM);
            END;

            IF nuError = 0
            THEN
                IF cuErrorFlujo%ISOPEN
                THEN
                    CLOSE cuErrorFlujo;
                END IF;

                OPEN cuErrorFlujo (reg.package_id);

                FETCH cuErrorFlujo INTO rgErrorFlujo;

                IF cuErrorFlujo%NOTFOUND
                THEN
                    DBMS_OUTPUT.put_line (
                           'FLUJO DE TRABAJO ANULADO SIN ERROR DE FLUJO|'
                        || reg.package_id);
                ELSE
                    CASE rgErrorFlujo.FORma
                        WHEN 'MOPRP'
                        THEN
                            UPDATE MO_EXECUTOR_LOG_MOT i
                               SET i.status_exec_log_id = 3       -- Procesado
                             WHERE i.EXECUTOR_LOG_MOT_ID =
                                   rgErrorFlujo.CODIGO_CAMBIAR1;
                        WHEN 'MOPWP'
                        THEN
                            UPDATE MO_WF_PACK_INTERFAC i
                               SET i.status_activity_id = 3        -- Atendida
                             WHERE i.WF_PACK_INTERFAC_ID =
                                   rgErrorFlujo.CODIGO_CAMBIAR1;
                        WHEN 'MOPWM'
                        THEN
                            UPDATE MO_WF_MOTIV_INTERFAC i
                               SET i.status_activity_id = 3        -- Atendida
                             WHERE i.WF_MOTIV_INTERFAC_ID =
                                   rgErrorFlujo.CODIGO_CAMBIAR1;
                        WHEN 'MOPWC'
                        THEN
                            UPDATE MO_WF_COMP_INTERFAC i
                               SET i.status_activity_id = 3        -- Atendida
                             WHERE i.WF_COMP_INTERFAC_ID =
                                   rgErrorFlujo.CODIGO_CAMBIAR1;
                        WHEN 'INRMO/WFEWF'
                        THEN
                            UPDATE WF_INSTANCE i
                               SET i.status_id = 8                -- Cancelada
                             WHERE i.INSTANCE_ID =
                                   rgErrorFlujo.CODIGO_CAMBIAR1;

                            UPDATE WF_EXCEPTION_LOG i
                               SET i.status = 2                    -- Resuelta
                             WHERE i.EXCEPTION_LOG_ID =
                                   rgErrorFlujo.CODIGO_CAMBIAR2;
                        WHEN 'INRMO'
                        THEN
                            UPDATE IN_INTERFACE_HISTORY i
                               SET i.status_id = 6        -- Mensaje cancelado
                             WHERE i.INTERFACE_HISTORY_ID =
                                   rgErrorFlujo.CODIGO_CAMBIAR1;
                    END CASE;

                    COMMIT;
                    DBMS_OUTPUT.put_line (
                           'FLUJO DE TRABAJO ANULADO CON ERROR DE FLUJO|'
                        || reg.package_id);
                END IF;

                CLOSE cuErrorFlujo;
            END IF;
        END IF;
    
    END LOOP;
    
END;
/

SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM DUAL;

SET SERVEROUTPUT OFF
QUIT
/