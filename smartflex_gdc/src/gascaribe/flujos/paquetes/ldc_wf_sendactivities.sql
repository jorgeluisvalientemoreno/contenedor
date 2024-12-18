CREATE OR REPLACE PACKAGE ldc_wf_sendactivities
IS
    /*****************************************************************
      Propiedad intelectual de Gases del Caribe / Efigas S.A.

      Nombre del Proceso: LDC_WF_SENDACTIVITIES
      Descripcion: Paquete para el reenv?o automatico de todas las actividades detenidas que est?n marcadas
                   para env?o manual en los FlujosOSF
      Autor  : Ing. Oscar Ospino Pati?o, Ludycom S.A.
      Fecha  : 17-06-2016 (Fecha Creacion Paquete)  No Tiquete CA(200-460) Entrega: CRM_SAC_OOP_200460_2

      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.              Modificacion
      -----------  -------------------    -------------------------------------
      07-03-2024    jpinedc                OSF-2377: Se cambia el manejo de archivos
                                            a pkg_gestionArchivos
      20-03-2024    jpinedc                 OSF-2377: Se usa pkg_BCLD_Parameter.fsbObtieneValorCadena
      17-06-2024    jpinedc                 OSF-2605: Se usa pkg_Correo                                          
    ******************************************************************/
    PROCEDURE prosendactivities;

    PROCEDURE prosendactivitiesemergencia;

    PROCEDURE pronotifactiv (isbprocesopadre   IN     VARCHAR2,
                             osberrormessage      OUT VARCHAR2);

    PROCEDURE compressfile (p_in_file IN VARCHAR2, p_out_file IN VARCHAR2);

    FUNCTION fbocheckmailformat (isbdata VARCHAR2)
        RETURN BOOLEAN;

    FUNCTION fcrsplitdata (isbdata IN VARCHAR2, osberror OUT VARCHAR2)
        RETURN CONSTANTS_PER.TYREFCURSOR;
END ldc_wf_sendactivities;
/

CREATE OR REPLACE PACKAGE BODY ldc_wf_sendactivities
IS
    sbpaquete   CONSTANT VARCHAR2 (30) := 'LDC_WF_SENDACTIVITIES';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    PROCEDURE prosendactivities
    IS
        /*****************************************************************
          Propiedad intelectual de Gases del Caribe / Efigas S.A.

          Nombre del Proceso: LDC_WF_SENDACTIVITIES
          Descripcion: Paquete para el reenv?o automatico de todas las actividades detenidas que est?n marcadas
                       para env?o manual en los FlujosOSF
          Autor  : Ing. Oscar Ospino Patinho, Ludycom S.A.
          Fecha  : 17-06-2016 (Fecha Creacion Paquete)  No Tiquete CA(200-460) Entrega: CRM_SAC_OOP_200460_1

          Historia de Modificaciones

          DD-MM-YYYY    <Autor>.              Modificacion
          -----------  -------------------    -------------------------------------
          09/02/2021   OLSOFTWARE             CA 638 se adiciona nuevo cursor CUWFEWF
          05/09/2016   Oscar Ospino P.        En la tabla LDC_WF_SENDACTIVITIESLOG se agrega un campo para registrar el nombre del proceso que inserta los datos
                                              para que el proceso que envia el correo pueda recuperar la informacion sin trocarla.
                                              Nota: Al crear nuevos procesos copia de PROSENDACTIVITIES, asegurarse de cambiar la variable sbproceso.

        ******************************************************************/

        sbproceso         VARCHAR2 (100) := sbpaquete || '.PROSENDACTIVITIES';
        nupaso            VARCHAR2 (20);
        onuerror          VARCHAR2 (50);
        osberrormessage   VARCHAR2 (4000);
        exerror           EXCEPTION;

        --PB MOPWP
        --Query Funcion: MO_BOFWSENTACTIVITIES.FRCGETSEARCHWFACTSENTFORPACK:
        CURSOR cumopwp IS
            SELECT a.wf_pack_interfac_id           pk,
                   a.wf_pack_interfac_id           message_proc_id,
                      a.activity_id
                   || ' - '
                   || wf_bobasicdataservices.fsbgetdescactivity (
                          a.activity_id)           activity_id,
                      a.status_activity_id
                   || ' - '
                   || mo_bobasicdataservices.fsbgetdescactivitystat (
                          a.status_activity_id)    activity_status,
                   a.package_id                    Package,
                      a.causal_id_output
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdesccausal (
                          a.causal_id_output)      causal_id_output,
                      a.action_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescaction (
                          a.action_id)             action_id,
                      a.executor_log_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescerrorlog (
                          a.executor_log_id)       mensaje_error,
                   a.recording_date                act_recording_date,
                   a.attendance_date               attendance_date
              FROM mo_wf_pack_interfac a, wf_instance b
             WHERE a.activity_id = b.instance_id AND a.status_activity_id = 4;

        --PB MOPWM
        --Query Funcion: MO_BOFWSENTACTIVITIES.FRCGETSEARCHWFACTSENTFORMOT:
        CURSOR cumopwm IS
            SELECT a.wf_motiv_interfac_id          pk,
                   a.wf_motiv_interfac_id          message_proc_id,
                      a.activity_id
                   || ' - '
                   || wf_bobasicdataservices.fsbgetdescactivity (
                          a.activity_id)           activity_id,
                      a.status_activity_id
                   || ' - '
                   || mo_bobasicdataservices.fsbgetdescactivitystat (
                          a.status_activity_id)    activity_status,
                   a.motive_id                     motive_id,
                      a.causal_id_output
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdesccausal (
                          a.causal_id_output)      causal_id_output,
                      a.action_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescaction (
                          a.action_id)             action_id,
                      a.executor_log_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescerrorlog (
                          a.executor_log_id)       mensaje_error,
                   a.recording_date                act_recording_date,
                   a.attendance_date               attendance_date
              FROM mo_wf_motiv_interfac  a,
                   wf_instance           b,
                   mo_motive             c
             WHERE     a.activity_id = b.instance_id
                   AND a.motive_id = c.motive_id
                   AND a.status_activity_id = 4;

        -- And rownum <= 1;

        --PB MOPWC
        --Query Funcion: MO_BOFWSENTACTIVITIES.FRCGETSEARCHWFACTIVITIESSENT:
        CURSOR cumopwc IS
            SELECT a.wf_comp_interfac_id           pk,
                   a.wf_comp_interfac_id           message_proc_id,
                      a.activity_id
                   || ' - '
                   || wf_bobasicdataservices.fsbgetdescactivity (
                          a.activity_id)           activity_id,
                      a.status_activity_id
                   || ' - '
                   || mo_bobasicdataservices.fsbgetdescactivitystat (
                          a.status_activity_id)    activity_status,
                   c.motive_id                     motive_id,
                   a.component_id                  component_id,
                      a.causal_id_output
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdesccausal (
                          a.causal_id_output)      causal_id_output,
                      a.action_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescaction (
                          a.action_id)             action_id,
                   c.service_number                service_number,
                      a.executor_log_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescerrorlog (
                          a.executor_log_id)       mensaje_error,
                   a.recording_date                act_recording_date,
                   a.attendance_date               attendance_date
              FROM mo_wf_comp_interfac  a,
                   wf_instance          b,
                   mo_component         c
             WHERE     a.activity_id = b.instance_id
                   AND a.component_id = c.component_id
                   AND a.status_activity_id = 4;

        -- And rownum <= 1;

        --PB MOPRP
        --Query Funcion: MO_BOFWSENTACTIVITIES.FRCGETSEARCHWFPROCSENTWOPLAN:
        CURSOR cumoprp IS
            SELECT a.executor_log_mot_id           pk,
                   a.executor_log_mot_id           message_proc_id,
                   a.package_id                    Package,
                   a.motive_id                     motive_id,
                      a.action_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescaction (
                          a.action_id)             action_id,
                      a.status_exec_log_id
                   || ' - '
                   || mo_bobasicdataservices.fsbgetdescactivitystat (
                          a.status_exec_log_id)    activity_status,
                      a.executor_log_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescerrorlog (
                          a.executor_log_id)       mensaje_error,
                   a.log_date                      log_date
              FROM mo_executor_log_mot a
             WHERE a.package_id = a.package_id AND a.status_exec_log_id = 4;

        -- And rownum <= 1;

        --PB INRMO
        --Query Funcion: IN_BOFW_INRMO_PB.FRCGETINTHISTORYBYPACK
        CURSOR cuinrmo IS
              SELECT h.request_number_origi,
                     h.interface_history_id,
                     h.last_mess_code_error || ' - ' || h.last_mess_desc_error
                         ultimo_error,
                        h.status_id
                     || ' - '
                     || dain_status.fsbgetdescription (h.status_id)
                         estado,
                     inserting_date
                FROM in_interface_history h
               WHERE h.status_id = '9'
            -- And rownum <= 1
            ORDER BY h.inserting_date DESC;

        --INICIO CA 638
        CURSOR CUWFEWF IS
            SELECT 'INRMO/WFEWF'           FORMA,
                   EXCEPTION_LOG_ID        pk,
                   EXCEPTION_LOG_ID        message_proc_id,
                   WF.DESCRIPTION          activity_id,
                   '9-Excepci¿n'          activity_status,
                   P.PACKAGE_ID            Package,
                   P.PACKAGE_TYPE_ID       PACKAGE_TYPE,
                      WF.action_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescaction (
                          WF.action_id)    action_id,
                   EL.MESSAGE_DESC,
                   WF.INITIAL_DATE,
                   SYSDATE                 ATTENDANCE_DATE,
                   wf.instance_id
              FROM WF_INSTANCE       WF,
                   WF_EXCEPTION_LOG  EL,
                   MO_PACKAGES       P,
                   WF_DATA_EXTERNAL  DE
             WHERE     WF.INSTANCE_ID = EL.INSTANCE_ID
                   AND DE.PLAN_ID = WF.PLAN_ID
                   AND DE.PACKAGE_ID = P.PACKAGE_ID
                   AND WF.STATUS_ID = 9
                   AND EL.STATUS = 1;

        rwwfewf           CUWFEWF%ROWTYPE;
        rwwfewf2          CUWFEWF%ROWTYPE;
    --FIN CA 638
        csbMetodo        CONSTANT VARCHAR2(70) := sbpaquete || '.prosendactivities';
    
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
         
        onuerror := NULL;
        osberrormessage := NULL;

        pkg_traza.Trace ('INICIO ' || sbpaquete || '.' || sbproceso);

        nupaso := '2';
              
        pkg_estaproc.prBorraEstaProc(isbproceso => sbproceso );

        pkg_estaproc.prinsertaestaproc( sbproceso , 1);
         
        --Borro el LOG solo de las actividades detenidas
        DELETE ldc_wf_sendactivitieslog w
         WHERE w.proceso = sbproceso;

        --Confirmar los cambios sobre la tablas LOG
        COMMIT;

        --MOPWM
        nupaso := '3';

        FOR regwm IN cumopwm
        LOOP
            osberrormessage := NULL;

            BEGIN
                --Se reenvia la actividad al flujo
                mo_BSAttendActivities.ManualSendByComp (
                    regwm.pk,
                    onuerror,
                    osberrormessage);

                --valido si hay error y lo registro en el LOG correspondiente.
                IF osberrormessage IS NOT NULL
                THEN
                    --iNSERTO EL REGISTRO EN EL LOG
                    INSERT INTO ldc_wf_sendactivitieslog (pbref,
                                                          id,
                                                          message_proc_id,
                                                          activity_id,
                                                          activity_status,
                                                          motive_id,
                                                          causal_id_output,
                                                          action_id,
                                                          mensaje_error,
                                                          act_recording_date,
                                                          attendance_date,
                                                          fecontrol,
                                                          proceso)
                         VALUES ('MOPWM',
                                 regwm.pk,
                                 regwm.message_proc_id,
                                 regwm.activity_id,
                                 regwm.activity_status,
                                 regwm.motive_id,
                                 regwm.causal_id_output,
                                 regwm.action_id,
                                 regwm.mensaje_error,
                                 regwm.act_recording_date,
                                 regwm.attendance_date,
                                 SYSDATE,
                                 sbproceso);

                    COMMIT;
                END IF;
            EXCEPTION
                WHEN OTHERS
                THEN
                    osberrormessage :=
                           ' Motivo: '
                        || regwm.motive_id
                        || ' | Activity: '
                        || regwm.activity_id
                        || ' | Action: '
                        || regwm.action_id
                        || ' | Causal de Salida: '
                        || regwm.causal_id_output
                        || ' | PASO: ('
                        || nupaso
                        || ')'
                        || ' | Mensaje Error: '
                        || regwm.mensaje_error
                        || CHR (10);
                        
                    pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => osberrormessage || ' | PASO: (' || nupaso || ')' , isbEstado => 'ERROR' );                        
            END;
        END LOOP;

        pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => 'PASO: (' || nupaso || ')' ,  isbEstado => 'OK' );
                                  
        --MOPWC
        nupaso := '4';

        FOR regwc IN cumopwc
        LOOP
            osberrormessage := NULL;

            BEGIN
                --Se reenvia la actividad al flujo
                mo_BSAttendActivities.ManualSendByComp (
                    regwc.pk,
                    onuerror,
                    osberrormessage);

                --valido si hay error y lo registro en el LOG correspondiente.
                IF osberrormessage IS NOT NULL
                THEN
                    --iNSERTO EL REGISTRO EN EL LOG
                    INSERT INTO ldc_wf_sendactivitieslog (pbref,
                                                          id,
                                                          message_proc_id,
                                                          activity_id,
                                                          activity_status,
                                                          motive_id,
                                                          component_id,
                                                          causal_id_output,
                                                          action_id,
                                                          service_number,
                                                          mensaje_error,
                                                          act_recording_date,
                                                          attendance_date,
                                                          fecontrol,
                                                          proceso)
                         VALUES ('MOPWC',
                                 regwc.pk,
                                 regwc.message_proc_id,
                                 regwc.activity_id,
                                 regwc.activity_status,
                                 regwc.motive_id,
                                 regwc.component_id,
                                 regwc.causal_id_output,
                                 regwc.action_id,
                                 regwc.service_number,
                                 regwc.mensaje_error,
                                 regwc.act_recording_date,
                                 regwc.attendance_date,
                                 SYSDATE,
                                 sbproceso);

                    COMMIT;
                END IF;
            EXCEPTION
                WHEN OTHERS
                THEN
                    osberrormessage :=
                           ' Motivo: '
                        || regwc.motive_id
                        || ' | Activity: '
                        || regwc.activity_id
                        || ' | Action: '
                        || regwc.action_id
                        || ' | Causal de Salida: '
                        || regwc.causal_id_output
                        || ' | PASO: ('
                        || nupaso
                        || ')'
                        || ' | Mensaje Error: '
                        || regwc.mensaje_error
                        || CHR (10);

                    pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => osberrormessage || ' | PASO: (' || nupaso || ')' , isbEstado => 'ERROR' );
            END;
        END LOOP;

        --Actualizo el estado del proceso
        pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => 'PASO: (' || nupaso || ')' ,  isbEstado => 'OK' );

        --MOPRP
        nupaso := '5';

        FOR regprp IN cumoprp
        LOOP
            osberrormessage := NULL;

            BEGIN
                --Se reenvia la actividad al flujo
                MO_BSEXECUTOR_LOG_MOT.ManualSend (regprp.pk,
                                                         onuerror,
                                                         osberrormessage);

                --valido si hay error y lo registro en el LOG correspondiente.
                IF osberrormessage IS NOT NULL
                THEN
                    --Inserto el registro en el LOG
                    INSERT INTO ldc_wf_sendactivitieslog (pbref,
                                                          id,
                                                          message_proc_id,
                                                          package_id,
                                                          motive_id,
                                                          action_id,
                                                          activity_status,
                                                          mensaje_error,
                                                          logdate,
                                                          fecontrol,
                                                          proceso)
                         VALUES ('MOPRP',
                                 regprp.pk,
                                 regprp.message_proc_id,
                                 regprp.package,
                                 regprp.motive_id,
                                 regprp.action_id,
                                 regprp.activity_status,
                                 regprp.mensaje_error,
                                 regprp.log_date,
                                 SYSDATE,
                                 sbproceso);

                    COMMIT;
                END IF;
            EXCEPTION
                WHEN OTHERS
                THEN
                    osberrormessage :=
                           ' | Tramite/Solicitud: '
                        || regprp.package
                        || ' Motivo: '
                        || regprp.motive_id
                        || ' | Action: '
                        || regprp.action_id
                        || ' | PASO: ('
                        || nupaso
                        || ')'
                        || ' | Mensaje Error: '
                        || regprp.mensaje_error
                        || CHR (10);
                        
                    pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => osberrormessage || ' | PASO: (' || nupaso || ')' , isbEstado => 'ERROR' );
            END;
        END LOOP;

        --Actualizo el estado del proceso
        pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => 'PASO: (' || nupaso || ')' ,  isbEstado => 'OK' );

        --INRMO
        nupaso := '6';

        FOR reginrmo IN cuinrmo
        LOOP
            osberrormessage := NULL;

            BEGIN
                --Se reenvia la actividad al flujo
                IN_BOFW_INRMO_PB.PROCESSHISTORY (
                    reginrmo.interface_history_id,
                    0,
                    0,
                    onuerror,
                    osberrormessage);

                --valido si hay error y lo registro en el LOG correspondiente.
                IF osberrormessage IS NOT NULL
                THEN
                    --Inserto el registro en el LOG
                    INSERT INTO ldc_wf_sendactivitieslog (pbref,
                                                          id,
                                                          package_id,
                                                          mensaje_error,
                                                          activity_status,
                                                          logdate,
                                                          fecontrol,
                                                          proceso)
                         VALUES ('INRMO',
                                 reginrmo.interface_history_id,
                                 reginrmo.request_number_origi,
                                 reginrmo.ultimo_error,
                                 reginrmo.estado,
                                 reginrmo.inserting_date,
                                 SYSDATE,
                                 sbproceso);

                    COMMIT;
                END IF;
            EXCEPTION
                WHEN OTHERS
                THEN
                    osberrormessage :=
                           ' | Tramite/Solicitud: '
                        || reginrmo.request_number_origi
                        || ' | PASO: ('
                        || nupaso
                        || ')'
                        || ' | Mensaje Error: '
                        || reginrmo.ultimo_error
                        || CHR (10)
                        || SQLERRM;
                    --Actualizo el estado del proceso
                    pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => osberrormessage || ' | PASO: (' || nupaso || ')' , isbEstado => 'ERROR' );
            END;
        END LOOP;

        --Actualizo el estado del proceso
        pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => 'PASO: (' || nupaso || ')' ,  isbEstado => 'OK' );

        nupaso := '7';

        -- MOPWP
        FOR regwp IN cumopwp
        LOOP
            osberrormessage := NULL;

            BEGIN
                --Se reenvia la actividad al flujo
                MO_BSATTENDACTIVITIES.MANUALSENDBYPACK (
                    regwp.pk,
                    onuerror,
                    osberrormessage);

                --valido si hay error y lo registro en el LOG correspondiente.
                IF osberrormessage IS NOT NULL
                THEN
                    --iNSERTO EL REGISTRO EN EL LOG
                    INSERT INTO ldc_wf_sendactivitieslog (pbref,
                                                          id,
                                                          message_proc_id,
                                                          activity_id,
                                                          activity_status,
                                                          package_id,
                                                          causal_id_output,
                                                          action_id,
                                                          mensaje_error,
                                                          act_recording_date,
                                                          attendance_date,
                                                          fecontrol,
                                                          proceso)
                         VALUES ('MOPWP',
                                 regwp.pk,
                                 regwp.message_proc_id,
                                 regwp.activity_id,
                                 regwp.activity_status,
                                 regwp.package,
                                 regwp.causal_id_output,
                                 regwp.action_id,
                                 regwp.mensaje_error,
                                 regwp.act_recording_date,
                                 regwp.attendance_date,
                                 SYSDATE,
                                 sbproceso);

                    COMMIT;
                END IF;
            EXCEPTION
                WHEN OTHERS
                THEN
                    osberrormessage :=
                           ' Tramite/Solicitud: '
                        || regwp.package
                        || ' | Activity: '
                        || regwp.activity_id
                        || ' | Action: '
                        || regwp.action_id
                        || ' | Causal de Salida: '
                        || regwp.causal_id_output
                        || ' | PASO: ('
                        || nupaso
                        || ')'
                        || ' | Mensaje Error: '
                        || regwp.mensaje_error
                        || CHR (10);

                    pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => osberrormessage || ' | PASO: (' || nupaso || ')' , isbEstado => 'ERROR' );
            END;
        END LOOP;


        --Actualizo el estado del proceso
        pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => 'PASO: (' || nupaso || ')' ,  isbEstado => 'OK' );

        --Crear el archivo adjunto y enviarlo por correo.

        nupaso := '8';

        osberrormessage := '';

        FOR regwp IN CUWFEWF
        LOOP
            osberrormessage := NULL;

            BEGIN
                --Se reenvia la actividad al flujo
                WF_BOEIFINSTANCE.RECOVERINSTANCE (regwp.instance_id);
                COMMIT;

                BEGIN
                    SELECT 'INRMO/WFEWF'           FORMA,
                           EXCEPTION_LOG_ID        pk,
                           EXCEPTION_LOG_ID        message_proc_id,
                           WF.DESCRIPTION          activity_id,
                           '9-Excepci¿n'          activity_status,
                           P.PACKAGE_ID            Package,
                           P.PACKAGE_TYPE_ID       PACKAGE_TYPE,
                              WF.action_id
                           || ' - '
                           || ge_bobasicdataservices.fsbgetdescaction (
                                  WF.action_id)    action_id,
                           EL.MESSAGE_DESC,
                           WF.INITIAL_DATE,
                           SYSDATE                 ATTENDANCE_DATE,
                           wf.instance_id
                      INTO rwwfewf
                      FROM WF_INSTANCE       WF,
                           WF_EXCEPTION_LOG  EL,
                           MO_PACKAGES       P,
                           WF_DATA_EXTERNAL  DE
                     WHERE     WF.INSTANCE_ID = EL.INSTANCE_ID
                           AND DE.PLAN_ID = WF.PLAN_ID
                           AND DE.PACKAGE_ID = P.PACKAGE_ID
                           AND WF.STATUS_ID = 9
                           AND EL.STATUS = 1
                           AND p.package_id = regwp.package;
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        rwwfewf := rwwfewf2;
                END;

                IF rwwfewf.message_desc IS NOT NULL
                THEN
                    INSERT INTO ldc_wf_sendactivitieslog (PBREF,
                                                          ID,
                                                          MESSAGE_PROC_ID,
                                                          ACTIVITY_ID,
                                                          ACTIVITY_STATUS,
                                                          PACKAGE_ID,
                                                          PACKAGE_TYPE,
                                                          ACTION_ID,
                                                          MENSAJE_ERROR,
                                                          ACT_RECORDING_DATE,
                                                          ATTENDANCE_DATE,
                                                          PROCESO)
                         VALUES (rwwfewf.FORMA,
                                 rwwfewf.pk,
                                 rwwfewf.message_proc_id,
                                 rwwfewf.activity_id,
                                 rwwfewf.activity_status,
                                 rwwfewf.package,
                                 rwwfewf.PACKAGE_TYPE,
                                 rwwfewf.action_id,
                                 rwwfewf.MESSAGE_DESC,
                                 rwwfewf.INITIAL_DATE,
                                 rwwfewf.attendance_date,
                                 sbproceso);

                    COMMIT;
                END IF;
            EXCEPTION
                WHEN OTHERS
                THEN
                    ROLLBACK;

                    --valido si hay error y lo registro en el LOG correspondiente.
                    --iNSERTO EL REGISTRO EN EL LOG
                    INSERT INTO ldc_wf_sendactivitieslog (PBREF,
                                                          ID,
                                                          MESSAGE_PROC_ID,
                                                          ACTIVITY_ID,
                                                          ACTIVITY_STATUS,
                                                          PACKAGE_ID,
                                                          PACKAGE_TYPE,
                                                          ACTION_ID,
                                                          MENSAJE_ERROR,
                                                          ACT_RECORDING_DATE,
                                                          ATTENDANCE_DATE,
                                                          PROCESO)
                         VALUES (regwp.FORMA,
                                 regwp.pk,
                                 regwp.message_proc_id,
                                 regwp.activity_id,
                                 regwp.activity_status,
                                 regwp.package,
                                 regwp.PACKAGE_TYPE,
                                 regwp.action_id,
                                 regwp.MESSAGE_DESC,
                                 regwp.INITIAL_DATE,
                                 regwp.attendance_date,
                                 sbproceso);

                    COMMIT;

                    osberrormessage :=
                           ' Tramite/Solicitud: '
                        || regwp.package
                        || ' | Activity: '
                        || regwp.activity_id
                        || ' | Action: '
                        || regwp.action_id
                        || ' | PASO: ('
                        || nupaso
                        || ')'
                        || ' | Mensaje Error: '
                        || regwp.MESSAGE_DESC
                        || CHR (10);

                    pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => osberrormessage || ' | PASO: (' || nupaso || ')' , isbEstado => 'ERROR' );
            END;
        END LOOP;

        --Actualizo el estado del proceso
        pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => 'PASO: (' || nupaso || ')' ,  isbEstado => 'OK' );

        --Crear el archivo adjunto y enviarlo por correo.
        nupaso := '9';

        osberrormessage := '';

        --Se ejecuta el proceso que envia el correo
        pronotifactiv (sbproceso, osberrormessage);

        IF osberrormessage IS NOT NULL
        THEN
            RAISE exerror;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
        WHEN exerror
        THEN
            onuerror := nupaso;
            osberrormessage :=
                   'TERMINO CON ERROR CONTROLADO | PROCESO: '
                || sbproceso
                || ' | PASO: ('
                || nupaso
                || ')'
                || CHR (10)
                || osberrormessage;

            --Actualiza ESTAPROC
            pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => osberrormessage || ' | PASO: (' || nupaso || ')' , isbEstado => 'ERROR' );    

            pkg_traza.Trace (osberrormessage);
        WHEN OTHERS
        THEN
            onuerror := nupaso;
            osberrormessage := SQLERRM;
            osberrormessage :=
                   'TERMINO CON ERROR NO CONTROLADO | PROCESO: '
                || sbproceso
                || ' | PASO: ('
                || nupaso
                || ')'
                || CHR (10)
                || 'ERROR: '
                || osberrormessage;

            --Actualiza ESTAPROC
            pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => osberrormessage || ' | PASO: (' || nupaso || ')' , isbEstado => 'ERROR' );
            
            pkg_traza.Trace (osberrormessage);
    END prosendactivities;

    PROCEDURE prosendactivitiesemergencia
    IS
        /*****************************************************************
          Propiedad intelectual de Gases del Caribe / Efigas S.A.

          Nombre del Proceso: LDC_WF_SENDACTIVITIES
          Descripcion: Paquete para el reenv?o automatico de todas las actividades detenidas que est?n marcadas
                       para env?o manual en los FlujosOSF
          Autor  : Ing. Oscar Ospino Patinho, Ludycom S.A.
          Fecha  : 17-06-2016 (Fecha Creacion Paquete)  No Tiquete CA(200-460) Entrega: CRM_SAC_OOP_200460_1

          Historia de Modificaciones

          DD-MM-YYYY    <Autor>.              Modificacion
          -----------  -------------------    -------------------------------------
          05/09/2016   Oscar Ospino P.        En la tabla LDC_WF_SENDACTIVITIESLOG se agrega un campo para registrar el nombre del proceso que inserta los datos
                                              para que el proceso que envia el correo pueda recuperar la informacion sin trocarla.
                                              Nota: Al crear nuevos procesos copia de PROSENDACTIVITIES, asegurarse de cambiar la variable sbproceso.
        ******************************************************************/

        sbproceso         VARCHAR2 (100)
                              := sbpaquete || '.PROSENDACTIVITIESEMERGENCIA';
        nupaso            VARCHAR2 (20);
        onuerror          VARCHAR2 (50);
        osberrormessage   VARCHAR2 (4000);
        exerror           EXCEPTION;

        --PB MOPWP
        --Query Funcion: MO_BOFWSENTACTIVITIES.FRCGETSEARCHWFACTSENTFORPACK:
        CURSOR cumopwp IS
            SELECT a.wf_pack_interfac_id           pk,
                   a.wf_pack_interfac_id           message_proc_id,
                      a.activity_id
                   || ' - '
                   || wf_bobasicdataservices.fsbgetdescactivity (
                          a.activity_id)           activity_id,
                      a.status_activity_id
                   || ' - '
                   || mo_bobasicdataservices.fsbgetdescactivitystat (
                          a.status_activity_id)    activity_status,
                   a.package_id                    Package,
                      a.causal_id_output
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdesccausal (
                          a.causal_id_output)      causal_id_output,
                      a.action_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescaction (
                          a.action_id)             action_id,
                      a.executor_log_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescerrorlog (
                          a.executor_log_id)       mensaje_error,
                   a.recording_date                act_recording_date,
                   a.attendance_date               attendance_date
              FROM mo_wf_pack_interfac  a,
                   wf_instance          b,
                   mo_packages          p
             WHERE     a.activity_id = b.instance_id
                   AND a.status_activity_id = 4
                   AND a.package_id = p.package_id
                   AND p.package_type_id IN (59, 308);

        -- And rownum <= 1;

        --PB MOPWM
        --Query Funcion: MO_BOFWSENTACTIVITIES.FRCGETSEARCHWFACTSENTFORMOT:
        CURSOR cumopwm IS
            SELECT a.wf_motiv_interfac_id          pk,
                   a.wf_motiv_interfac_id          message_proc_id,
                      a.activity_id
                   || ' - '
                   || wf_bobasicdataservices.fsbgetdescactivity (
                          a.activity_id)           activity_id,
                      a.status_activity_id
                   || ' - '
                   || mo_bobasicdataservices.fsbgetdescactivitystat (
                          a.status_activity_id)    activity_status,
                   a.motive_id                     motive_id,
                      a.causal_id_output
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdesccausal (
                          a.causal_id_output)      causal_id_output,
                      a.action_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescaction (
                          a.action_id)             action_id,
                      a.executor_log_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescerrorlog (
                          a.executor_log_id)       mensaje_error,
                   a.recording_date                act_recording_date,
                   a.attendance_date               attendance_date
              FROM mo_wf_motiv_interfac  a,
                   wf_instance           b,
                   mo_motive             c,
                   mo_packages           p
             WHERE     a.activity_id = b.instance_id
                   AND a.motive_id = c.motive_id
                   AND a.status_activity_id = 4
                   AND p.package_id = c.package_id
                   AND p.package_type_id IN (59, 308);

        -- And rownum <= 1;

        --PB MOPWC
        --Query Funcion: MO_BOFWSENTACTIVITIES.FRCGETSEARCHWFACTIVITIESSENT:
        CURSOR cumopwc IS
            SELECT a.wf_comp_interfac_id           pk,
                   a.wf_comp_interfac_id           message_proc_id,
                      a.activity_id
                   || ' - '
                   || wf_bobasicdataservices.fsbgetdescactivity (
                          a.activity_id)           activity_id,
                      a.status_activity_id
                   || ' - '
                   || mo_bobasicdataservices.fsbgetdescactivitystat (
                          a.status_activity_id)    activity_status,
                   c.motive_id                     motive_id,
                   a.component_id                  component_id,
                      a.causal_id_output
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdesccausal (
                          a.causal_id_output)      causal_id_output,
                      a.action_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescaction (
                          a.action_id)             action_id,
                   c.service_number                service_number,
                      a.executor_log_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescerrorlog (
                          a.executor_log_id)       mensaje_error,
                   a.recording_date                act_recording_date,
                   a.attendance_date               attendance_date
              FROM mo_wf_comp_interfac  a,
                   wf_instance          b,
                   mo_component         c,
                   mo_packages          p
             WHERE     a.activity_id = b.instance_id
                   AND a.component_id = c.component_id
                   AND a.status_activity_id = 4
                   AND c.package_id = p.package_id
                   AND p.package_type_id IN (59, 308);

        -- And rownum <= 1;

        --PB MOPRP
        --Query Funcion: MO_BOFWSENTACTIVITIES.FRCGETSEARCHWFPROCSENTWOPLAN:
        CURSOR cumoprp IS
            SELECT a.executor_log_mot_id           pk,
                   a.executor_log_mot_id           message_proc_id,
                   a.package_id                    Package,
                   a.motive_id                     motive_id,
                      a.action_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescaction (
                          a.action_id)             action_id,
                      a.status_exec_log_id
                   || ' - '
                   || mo_bobasicdataservices.fsbgetdescactivitystat (
                          a.status_exec_log_id)    activity_status,
                      a.executor_log_id
                   || ' - '
                   || ge_bobasicdataservices.fsbgetdescerrorlog (
                          a.executor_log_id)       mensaje_error,
                   a.log_date                      log_date
              FROM mo_executor_log_mot a, mo_packages p
             WHERE     a.package_id = p.package_id
                   AND a.status_exec_log_id = 4
                   AND p.package_type_id IN (59, 308);

        --PB INRMO
        --Query Funcion: IN_BOFW_INRMO_PB.FRCGETINTHISTORYBYPACK
        CURSOR cuinrmo IS
              SELECT h.request_number_origi,
                     h.interface_history_id,
                     h.last_mess_code_error || ' - ' || h.last_mess_desc_error
                         ultimo_error,
                        h.status_id
                     || ' - '
                     || dain_status.fsbgetdescription (h.status_id)
                         estado,
                     inserting_date
                FROM in_interface_history h,
                     wf_instance         w,
                     mo_packages         p
               WHERE     h.status_id = '9'
                     AND h.request_number_origi = w.instance_id
                     AND w.parent_external_id = p.package_id
                     AND p.package_type_id IN (59, 308)
            ORDER BY h.inserting_date DESC;
            
    BEGIN
        onuerror := NULL;
        osberrormessage := NULL;

        pkg_traza.Trace ('INICIO ' || sbpaquete || '.' || sbproceso);

        nupaso := '2';

        --Borro el indicador de inicio y fin del proceso
        pkg_estaproc.prBorraEstaProc(isbproceso => sbproceso );
    
        --Estado del Proceso
        pkg_estaproc.prInsertaEstaproc( sbproceso, 1 );
        
        --Borro el LOG solo de las actividades detenidas
        DELETE ldc_wf_sendactivitieslog w
         WHERE w.proceso = sbproceso;

        --Confirmar los cambios sobre las tablas de LOG
        COMMIT;

        --MOPWM
        nupaso := '3';

        FOR regwm IN cumopwm
        LOOP
            osberrormessage := NULL;

            BEGIN
                --Se reenvia la actividad al flujo
                mo_BSAttendActivities.ManualSendByComp (
                    regwm.pk,
                    onuerror,
                    osberrormessage);

                --valido si hay error y lo registro en el LOG correspondiente.
                IF osberrormessage IS NOT NULL
                THEN
                    --iNSERTO EL REGISTRO EN EL LOG
                    INSERT INTO ldc_wf_sendactivitieslog (pbref,
                                                          id,
                                                          message_proc_id,
                                                          activity_id,
                                                          activity_status,
                                                          motive_id,
                                                          causal_id_output,
                                                          action_id,
                                                          mensaje_error,
                                                          act_recording_date,
                                                          attendance_date,
                                                          fecontrol,
                                                          proceso)
                         VALUES ('MOPWM',
                                 regwm.pk,
                                 regwm.message_proc_id,
                                 regwm.activity_id,
                                 regwm.activity_status,
                                 regwm.motive_id,
                                 regwm.causal_id_output,
                                 regwm.action_id,
                                 regwm.mensaje_error,
                                 regwm.act_recording_date,
                                 regwm.attendance_date,
                                 SYSDATE,
                                 sbproceso);

                    COMMIT;
                END IF;
            EXCEPTION
                WHEN OTHERS
                THEN
                    osberrormessage :=
                           ' Motivo: '
                        || regwm.motive_id
                        || ' | Activity: '
                        || regwm.activity_id
                        || ' | Action: '
                        || regwm.action_id
                        || ' | Causal de Salida: '
                        || regwm.causal_id_output
                        || ' | PASO: ('
                        || nupaso
                        || ')'
                        || ' | Mensaje Error: '
                        || regwm.mensaje_error
                        || CHR (10);
                        
                    --Actualiza ESTAPROC
                    pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => osberrormessage || ' | PASO: (' || nupaso || ')' , isbEstado => 'ERROR' );    

            END;
        END LOOP;

        --Actualiza ESTAPROC
        pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => 'PASO: (' || nupaso || ')' , isbEstado => 'OK' );    

        --MOPWC
        nupaso := '4';

        FOR regwc IN cumopwc
        LOOP
            osberrormessage := NULL;

            BEGIN
                --Se reenvia la actividad al flujo
                mo_BSAttendActivities.ManualSendByComp (
                    regwc.pk,
                    onuerror,
                    osberrormessage);

                --valido si hay error y lo registro en el LOG correspondiente.
                IF osberrormessage IS NOT NULL
                THEN
                    --iNSERTO EL REGISTRO EN EL LOG
                    INSERT INTO ldc_wf_sendactivitieslog (pbref,
                                                          id,
                                                          message_proc_id,
                                                          activity_id,
                                                          activity_status,
                                                          motive_id,
                                                          component_id,
                                                          causal_id_output,
                                                          action_id,
                                                          service_number,
                                                          mensaje_error,
                                                          act_recording_date,
                                                          attendance_date,
                                                          fecontrol,
                                                          proceso)
                         VALUES ('MOPWC',
                                 regwc.pk,
                                 regwc.message_proc_id,
                                 regwc.activity_id,
                                 regwc.activity_status,
                                 regwc.motive_id,
                                 regwc.component_id,
                                 regwc.causal_id_output,
                                 regwc.action_id,
                                 regwc.service_number,
                                 regwc.mensaje_error,
                                 regwc.act_recording_date,
                                 regwc.attendance_date,
                                 SYSDATE,
                                 sbproceso);

                    COMMIT;
                END IF;
            EXCEPTION
                WHEN OTHERS
                THEN
                    osberrormessage :=
                           ' Motivo: '
                        || regwc.motive_id
                        || ' | Activity: '
                        || regwc.activity_id
                        || ' | Action: '
                        || regwc.action_id
                        || ' | Causal de Salida: '
                        || regwc.causal_id_output
                        || ' | PASO: ('
                        || nupaso
                        || ')'
                        || ' | Mensaje Error: '
                        || regwc.mensaje_error
                        || CHR (10);
                        
                    --Actualiza ESTAPROC
                    pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => osberrormessage || ' | PASO: (' || nupaso || ')' , isbEstado => 'ERROR' );    

            END;
        END LOOP;

        --Actualiza ESTAPROC
        pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => 'PASO: (' || nupaso || ')' , isbEstado => 'OK' );    

        --MOPRP
        nupaso := '5';

        FOR regprp IN cumoprp
        LOOP
            osberrormessage := NULL;

            BEGIN
                --Se reenvia la actividad al flujo
                MO_BSEXECUTOR_LOG_MOT.ManualSend (regprp.pk,
                                                         onuerror,
                                                         osberrormessage);

                --valido si hay error y lo registro en el LOG correspondiente.
                IF osberrormessage IS NOT NULL
                THEN
                    --Inserto el registro en el LOG
                    INSERT INTO ldc_wf_sendactivitieslog (pbref,
                                                          id,
                                                          message_proc_id,
                                                          package_id,
                                                          motive_id,
                                                          action_id,
                                                          activity_status,
                                                          mensaje_error,
                                                          logdate,
                                                          fecontrol,
                                                          proceso)
                         VALUES ('MOPRP',
                                 regprp.pk,
                                 regprp.message_proc_id,
                                 regprp.package,
                                 regprp.motive_id,
                                 regprp.action_id,
                                 regprp.activity_status,
                                 regprp.mensaje_error,
                                 regprp.log_date,
                                 SYSDATE,
                                 sbproceso);

                    COMMIT;
                END IF;
            EXCEPTION
                WHEN OTHERS
                THEN
                    osberrormessage :=
                           ' | Tramite/Solicitud: '
                        || regprp.package
                        || ' Motivo: '
                        || regprp.motive_id
                        || ' | Action: '
                        || regprp.action_id
                        || ' | PASO: ('
                        || nupaso
                        || ')'
                        || ' | Mensaje Error: '
                        || regprp.mensaje_error
                        || CHR (10);
                        
                    --Actualiza ESTAPROC
                    pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => osberrormessage || ' | PASO: (' || nupaso || ')' , isbEstado => 'ERROR' );    

            END;
        END LOOP;

        --Actualiza ESTAPROC
        pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => 'PASO: (' || nupaso || ')' , isbEstado => 'OK' );    


        --INRMO
        nupaso := '6';

        FOR reginrmo IN cuinrmo
        LOOP
            osberrormessage := 761;                                    --Null;

            BEGIN
                --Se reenvia la actividad al flujo
                IN_BOFW_INRMO_PB.PROCESSHISTORY (
                    reginrmo.interface_history_id,
                    0,
                    0,
                    onuerror,
                    osberrormessage);

                --valido si hay error y lo registro en el LOG correspondiente.
                IF osberrormessage IS NOT NULL
                THEN
                    --Inserto el registro en el LOG
                    INSERT INTO ldc_wf_sendactivitieslog (pbref,
                                                          id,
                                                          package_id,
                                                          mensaje_error,
                                                          activity_status,
                                                          logdate,
                                                          fecontrol,
                                                          proceso)
                         VALUES ('INRMO',
                                 reginrmo.interface_history_id,
                                 reginrmo.request_number_origi,
                                 reginrmo.ultimo_error,
                                 reginrmo.estado,
                                 reginrmo.inserting_date,
                                 SYSDATE,
                                 sbproceso);

                    COMMIT;
                END IF;
            EXCEPTION
                WHEN OTHERS
                THEN
                    osberrormessage :=
                           ' | Tramite/Solicitud: '
                        || reginrmo.request_number_origi
                        || ' | PASO: ('
                        || nupaso
                        || ')'
                        || ' | Mensaje Error: '
                        || reginrmo.ultimo_error
                        || CHR (10)
                        || SQLERRM;
                        
                    --Actualiza ESTAPROC
                    pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => osberrormessage || ' | PASO: (' || nupaso || ')' , isbEstado => 'ERROR' );    

            END;
        END LOOP;

        --Actualiza ESTAPROC
        pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => 'PASO: (' || nupaso || ')' , isbEstado => 'OK' );    

        nupaso := '7';

        -- MOPWP
        FOR regwp IN cumopwp
        LOOP
            osberrormessage := 761;                                    --Null;

            BEGIN
                --Se reenvia la actividad al flujo
                MO_BSATTENDACTIVITIES.MANUALSENDBYPACK (
                    regwp.pk,
                    onuerror,
                    osberrormessage);

                --valido si hay error y lo registro en el LOG correspondiente.
                IF osberrormessage IS NOT NULL
                THEN
                    --iNSERTO EL REGISTRO EN EL LOG
                    INSERT INTO ldc_wf_sendactivitieslog (pbref,
                                                          id,
                                                          message_proc_id,
                                                          activity_id,
                                                          activity_status,
                                                          package_id,
                                                          causal_id_output,
                                                          action_id,
                                                          mensaje_error,
                                                          act_recording_date,
                                                          attendance_date,
                                                          fecontrol,
                                                          proceso)
                         VALUES ('MOPWP',
                                 regwp.pk,
                                 regwp.message_proc_id,
                                 regwp.activity_id,
                                 regwp.activity_status,
                                 regwp.package,
                                 regwp.causal_id_output,
                                 regwp.action_id,
                                 regwp.mensaje_error,
                                 regwp.act_recording_date,
                                 regwp.attendance_date,
                                 SYSDATE,
                                 sbproceso);

                    COMMIT;
                END IF;
            EXCEPTION
                WHEN OTHERS
                THEN
                    osberrormessage :=
                           ' Tramite/Solicitud: '
                        || regwp.package
                        || ' | Activity: '
                        || regwp.activity_id
                        || ' | Action: '
                        || regwp.action_id
                        || ' | Causal de Salida: '
                        || regwp.causal_id_output
                        || ' | PASO: ('
                        || nupaso
                        || ')'
                        || ' | Mensaje Error: '
                        || regwp.mensaje_error
                        || CHR (10);

                    --Actualiza ESTAPROC
                    pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => osberrormessage || ' | PASO: (' || nupaso || ')' , isbEstado => 'ERROR' );    

            END;
        END LOOP;

        --Actualiza ESTAPROC
        pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => 'PASO: (' || nupaso || ')' , isbEstado => 'OK' );    

        --Crear el archivo adjunto y enviarlo por correo.
        nupaso := '8';

        osberrormessage := '';
        --Se ejecuta el proceso que envia el correo
        pronotifactiv (sbproceso, osberrormessage);

        IF osberrormessage IS NOT NULL
        THEN
            RAISE exerror;
        END IF;

        pkg_traza.Trace ('FIN ' || sbpaquete || '.' || sbproceso);
    EXCEPTION
        WHEN exerror
        THEN
            onuerror := nupaso;
            osberrormessage :=
                   'TERMINO CON ERROR CONTROLADO | PROCESO: '
                || sbproceso
                || ' | PASO: ('
                || nupaso
                || ')'
                || CHR (10)
                || osberrormessage;

                --Actualiza ESTAPROC
                pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => osberrormessage || ' | PASO: (' || nupaso || ')' , isbEstado => 'ERROR' );    


            pkg_traza.Trace (osberrormessage);
        WHEN OTHERS
        THEN
            onuerror := SQLCODE;
            osberrormessage := SQLERRM;
            osberrormessage :=
                   'TERMINO CON ERROR NO CONTROLADO | PROCESO: '
                || sbproceso
                || ' | PASO: ('
                || nupaso
                || ')'
                || CHR (10)
                || 'ERROR: '
                || osberrormessage;

            --Actualiza ESTAPROC
            pkg_estaproc.practualizaestaproc(isbproceso => sbproceso, isbObservacion => osberrormessage || ' | PASO: (' || nupaso || ')' , isbEstado => 'ERROR' );    

            pkg_traza.Trace (osberrormessage);
    END prosendactivitiesemergencia;

    PROCEDURE pronotifactiv (isbprocesopadre   IN     VARCHAR2,
                             osberrormessage      OUT VARCHAR2)
    IS
        /*****************************************************************
          Propiedad intelectual de Gases del Caribe / Efigas S.A.

          Nombre del Proceso: PRONOTIFACTIV
          Descripcion: Proceso que notifica por correo todas las actividades detenidas en los Flujos de OSF, tras la ejecuci?n del proceso
                       PROSENDACTIVITIES
          Autor  : Ing. Oscar Ospino Patinho, Ludycom S.A.
          Fecha  : 17-06-2016 (Fecha Creacion Paquete)  No Tiquete CA(200-460) Entrega: CRM_SAC_OOP_200460_1

          Historia de Modificaciones

          DD-MM-YYYY    <Autor>.              Modificacion
          -----------  -------------------    -------------------------------------
          05/09/2016   Oscar Ospino P.        Se adiciona parametro isbprocesopadre para consultar y notificar por correo solo los registros
                                              que haya insertado el proceso padre. Se condiciona la entrega con la variable sbentrega_200761

        ******************************************************************/

        sbproceso        VARCHAR2 (100) := sbpaquete || '.PROSENDMAILCSV';

        --Datos archivo adjunto
        archivo          pkg_gestionArchivos.styArchivo;

        --nombre del Archivo EJ: REPORTE_ACTIVIDADES_DETENIDAS_20160613_0832.CSV
        sbnombrearch     VARCHAR2 (100)
            :=    'REPORTE_ACTIVIDADES_DETENIDAS_'
               || TO_CHAR (SYSDATE, 'YYYYMMDD_HH24MI');

        --Nombre del Directorio donde se almacenaran los archivos
        directorio       VARCHAR2 (255)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_WF_DIRECTORY_ACTIVDET');
        sbruta           VARCHAR2 (255);                 --Ruta del directorio
        sbpath           VARCHAR2 (255);           --Ruta completa del archivo
        blfile           BFILE;     --file type para crear el archivo en disco
        adjunto          BLOB;          --file type del archivo final a enviar
        nutam_archivo    NUMBER;                 --tamano del archivo a enviar
        nuarchexiste     NUMBER;    --valida si creo algun archivo en el disco

        --Fuente donde el proceso tomara los datos
        sbfilesource     VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena (
                   'LDC_WF_SENDACTIV_MAILSOURCE');
        sbfilesrcdesc    VARCHAR2 (100);
        --********** Parametros correo **********--
        sbfrom           VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_SMTP_SENDER');
        sbfromdisplay    VARCHAR2 (4000) := 'Open SmartFlex';
        --Destinatarios
        sbto             VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_WF_MAIL_REP_ACTIV_DET');
        sbtodisplay      VARCHAR2 (4000) := '';
        sbcc             ut_string.tytb_string;
        sbccdisplay      ut_string.tytb_string;
        sbbcc            ut_string.tytb_string;
        --asunto
        sbsubject        VARCHAR2 (255)
            := 'REPORTE DIARIO DE ACTIVIDADES DETENIDAS EN FLUJOS';

        --Cuerpo del correo electronico
        sbmsg            VARCHAR2 (32000)
            :=    '<div align="center"><b>REPORTE DIARIO DE ACTIVIDADES DETENIDAS EN FLUJOS</b><p>Fecha de Proceso: '
               || SYSDATE
               || '<br>Fuente de Datos: ##FUENTE##
																 <br></p><br><br><style type="text/css">
																					.tg  {border-collapse:collapse;border-spacing:0}
																					.tg td{font-family:Arial, sans-serif;font-size:14px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
																					.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
																					.tg .tg-1{text-align:left}
																					.tg .tg-2{text-align:center}
																					.tg .tg-3{text-align:right}
																					.tgh {background-color: #E5ECF9}
																				</style><table class="tg"><tr><th class="tgh tg-2">Tipo Solicitud</th><th class="tgh tg-2">Descripcion</th><th class="tgh tg-2">Cantidad</th></tr>
																				##TABLA##
																				<br><br><br><table width="100%" border="0">
                                        <tr bgcolor="#E5ECF9"><td><div align="center"><font face="Tahoma" size="1" color="#FFFFFF"><font color="#003333"><b> '
               || REPLACE (isbprocesopadre, sbpaquete || '.', '')
               || ' </b></font></font></div></td></tr>
                                        <tr bgcolor="#E5ECF9"><td><div align="center"><font face="Tahoma" size="1" color="#FFFFFF"><font color="#003333"><b> Open SmartFlex </b></font></font></div></td></tr></table></div>';

        sbmsgtbl         VARCHAR2 (32000);
        sbcontenttype    VARCHAR2 (100) := 'text/html';
        sbfilename       VARCHAR2 (255) := sbnombrearch;
        sbfileext        VARCHAR2 (10) := 'CSV'; --especifica el tipo de archivo que se enviar?. ZIP o CSV

        boexistendatos   BOOLEAN := FALSE; --Flag para enviar el correo solo si hay datos

        exnofile         EXCEPTION;
        exparam          EXCEPTION;
        exruta           EXCEPTION;

        --Cuerpo correo listado agrupado del REPORTE MOPWD
        CURSOR cubodyreport IS
              SELECT p.package_type_id             tipo_paquete,
                     pty.description               descripcion,
                     COUNT (p.package_type_id)     cantidad
                FROM mo_wf_pack_interfac wfpi,
                     wf_instance        wfins,
                     ge_action_module   gam,
                     ge_executor_log    gel,
                     mo_packages        p,
                     ps_package_type    pty
               WHERE     wfpi.activity_id = wfins.instance_id
                     AND wfpi.action_id = gam.action_id
                     AND wfpi.executor_log_id = gel.executor_log_id
                     AND wfpi.package_id = p.package_id
                     AND p.package_type_id = pty.package_type_id
            GROUP BY p.package_type_id, pty.description
            ORDER BY cantidad DESC, p.package_type_id;

        CURSOR culistareport IS
              --Consultar listado de actividades detenidas en los Flujos (REPORTE MOPWD)
              SELECT wfpi.wf_pack_interfac_id
                         identificador,
                     p.package_type_id
                         tipo_paquete,
                     p.package_type_id || ' - ' || pty.description
                         descripcion_typo_paquete,
                     wfpi.activity_id || ' - ' || wfins.description
                         actividad,
                        wfpi.status_activity_id
                     || ' - '
                     || damo_status_activity.fsbgetdescription (
                            wfpi.status_activity_id)
                         estado,
                     wfpi.package_id
                         no_solicitud,
                     wfpi.action_id || ' - ' || gam.description
                         accion,
                        wfpi.executor_log_id
                     || ' - '
                     || REPLACE (
                            REPLACE (gel.MESSAGE, CHR (10), ' '),
                            'COULD NOT FIND PROGRAM UNIT BEING CALLED',
                            'NO HAY EJECUTORES, VERIFIQUE CON EL ADMINISTRADOR DEL SISTEMA')
                         mensaje_de_error,
                     wfpi.recording_date
                         fecha_registro
                FROM mo_wf_pack_interfac wfpi,
                     wf_instance        wfins,
                     ge_action_module   gam,
                     ge_executor_log    gel,
                     mo_packages        p,
                     ps_package_type    pty
               WHERE     wfpi.activity_id = wfins.instance_id
                     AND wfpi.action_id = gam.action_id
                     AND wfpi.executor_log_id = gel.executor_log_id
                     AND wfpi.package_id = p.package_id
                     AND p.package_type_id = pty.package_type_id
            ORDER BY wfpi.status_activity_id, wfpi.recording_date DESC;

        --Cuerpo correo listado agrupado tramites del LOG (LDC_WF_SENDACTIVITIESLOG)
        --CA 200-761 Solo consulta los datos insertados por el proceso padre pasado por parametro
        CURSOR cubodylog IS
              SELECT PKG_BCSOLICITUDES.FNUGETTIPOSOLICITUD (l.package_id)
                         tipo_paquete,
                     daps_package_type.fsbgetdescription (
                         PKG_BCSOLICITUDES.FNUGETTIPOSOLICITUD (l.package_id))
                         descripcion,
                     COUNT (l.package_id)
                         cantidad
                FROM ldc_wf_sendactivitieslog l
               WHERE l.package_id IS NOT NULL AND l.proceso = isbprocesopadre --CA 200-761
            GROUP BY PKG_BCSOLICITUDES.FNUGETTIPOSOLICITUD (l.package_id)
            ORDER BY cantidad DESC;

        --Detalle archivo adjunto TABLELOG (LDC_WF_SENDACTIVITIESLOG)
        --CA 200-761 Solo consulta los datos insertados por el proceso padre pasado por parametro
        CURSOR culistalog IS
              SELECT l.pbref                                  fuente,
                     l.id                                     workflow_id,
                     NVL (l.activity_id, '-')                 actividad,
                     NVL (l.activity_status, '-')             estado_actividad,
                     CASE
                         WHEN l.package_id IS NOT NULL
                         THEN
                                l.package_id
                             || ' - '
                             || daps_package_type.fsbgetdescription (
                                    PKG_BCSOLICITUDES.FNUGETTIPOSOLICITUD (
                                        l.package_id))
                         ELSE
                             '-'
                     END                                      tramite,
                     CASE
                         WHEN l.motive_id IS NOT NULL
                         THEN
                                l.motive_id
                             || ' - '
                             || daps_motive_type.fsbgetdescription (
                                    damo_motive.fnugetmotive_type_id (
                                        l.motive_id))
                         ELSE
                             '-'
                     END                                      motivo,
                     CASE
                         WHEN l.component_id IS NOT NULL
                         THEN
                                l.component_id
                             || ' - '
                             || daps_component_type.fsbgetdescription (
                                    damo_component.fnugetcomponent_type_id (
                                        l.component_id))
                         ELSE
                             '-'
                     END                                      componente,
                     NVL (l.action_id, '-')                   accion,
                     NVL (l.causal_id_output, '-')            causal_salida,
                     NVL (l.service_number, '-')              numero_servicio,
                     NVL (
                         REPLACE (REPLACE (l.mensaje_error, '  ', ''),
                                  CHR (10),
                                  ''),
                         '-')                                 mensaje_error,
                     NVL (l.act_recording_date, l.logdate)    fecha_grabacion
                FROM ldc_wf_sendactivitieslog l
               WHERE l.proceso = isbprocesopadre                  --CA 200-761
            ORDER BY l.pbref, l.activity_id, l.fecontrol DESC;

        rccurpt          culistareport%ROWTYPE;
        rccurlog         culistalog%ROWTYPE;

        CURSOR cucorreos (isbdata VARCHAR2)
        IS
            SELECT regexp_substr(isbdata,'[^;]+', 1,LEVEL) column_value, ROWNUM id
            FROM dual
            CONNECT BY regexp_substr(isbdata, '[^;]+', 1, LEVEL) IS NOT NULL;

        sbInstanciaBD        VARCHAR2 (40);
        
        CURSOR cudba_directories( isbDirectorio VARCHAR2)
        IS
        SELECT directory_path, directory_name
        FROM dba_directories d
        WHERE d.directory_name = isbDirectorio;
        
        rcdba_directories cudba_directories%ROWTYPE;    
        
    BEGIN
        pkg_traza.Trace ('INICIO ' || sbpaquete || '.' || sbproceso);

        --Borro el LOG del proceso
        pkg_estaproc.prBorraEstaProc(isbproceso => sbproceso );
        
        sbInstanciaBD := ldc_boConsGenerales.fsbGetDatabaseDesc;

        IF (LENGTH(sbInstanciaBD)) > 0 THEN
            sbInstanciaBD := 'BD ' || sbInstanciaBD || ': ';
        END IF;

        sbsubject :=
               sbInstanciaBD || sbsubject;    

        --inicio el LOG                                
        pkg_estaproc.prInsertaEstaproc( sbproceso, 1 );                                

        pkg_traza.Trace ('sbto|' || sbto );
        pkg_traza.Trace ('sbfrom|' || sbfrom );
        pkg_traza.Trace ('directorio|' || directorio );
        
        --valido que la cadena del remitente y destinatarios este bien formada
        IF    fbocheckmailformat (sbto) = FALSE
           OR fbocheckmailformat (sbfrom) = FALSE
           OR directorio IS NULL
        THEN
            RAISE exparam;
        END IF;

        --se obtiene la ruta del directorio
        OPEN cudba_directories(directorio);
        FETCH cudba_directories INTO rcdba_directories;
        CLOSE cudba_directories;
        
        sbRuta := rcdba_directories.directory_path;
        
        IF rcdba_directories.directory_name IS NULL THEN
            RAISE exruta;
        END IF;

        pkg_traza.Trace ('sbruta|' || sbruta );

        pkg_traza.Trace ('sbfilesource|' || sbfilesource );
                
        --****** SE ARMA EL CUERPO DEL MENSAJE DE CORREO ******--
        IF sbfilesource = 'REPORTE'
        THEN
            sbfilesrcdesc := 'REPORTE MOPWD';

            --Se insertan los datos en la tabla HTML
            FOR cureg IN cubodyreport
            LOOP
                --CA 200-761
                boexistendatos := TRUE;

                sbmsgtbl :=
                       sbmsgtbl
                    || '<tr><td class="tg-3">'
                    || cureg.tipo_paquete
                    || '</td><td class="tg-1">'
                    || cureg.descripcion
                    || '</td><td class="tg-2">'
                    || cureg.cantidad
                    || '</td></tr>';
            END LOOP;
        ELSIF sbfilesource = 'PROCESO'
        THEN
            sbfilesrcdesc := 'LOG DEL PROCESO';

            --Se insertan los datos en la tabla HTML
            FOR cureg IN cubodylog
            LOOP
                --CA 200-761
                boexistendatos := TRUE;

                sbmsgtbl :=
                       sbmsgtbl
                    || '<tr><td class="tg-3">'
                    || cureg.tipo_paquete
                    || '</td><td class="tg-1">'
                    || cureg.descripcion
                    || '</td><td class="tg-2">'
                    || cureg.cantidad
                    || '</td></tr>';
            END LOOP;
        ELSE
            RAISE exparam;
        END IF;

        --Se Cierra la tabla html
        sbmsgtbl := sbmsgtbl || '</table>';

        --Coloco la fuente de datos que usa el proceso en el cuerpo del correo electronico.
        sbmsg := REPLACE (sbmsg, '##FUENTE##', sbfilesrcdesc);

        --INSERTO LA TABLA CON DATOS EN EL BODY DEL MENSAJE
        sbmsg := REPLACE (sbmsg, '##TABLA##', sbmsgtbl);

        --****** FIN CUERPO DEL MENSAJE DE CORREO ******--

        --****** SE CREA EL ARCHIVO DEL REPORTE EN LA RUTA ESPECIFICADA ******--
        BEGIN
            archivo :=
                pkg_gestionArchivos.ftAbrirArchivo_SMF (
                    sbruta,
                    sbnombrearch || '.' || sbfileext,
                    'w');
        EXCEPTION
            WHEN OTHERS
            THEN
                RAISE exruta;
        END;

        --Titulo
        pkg_gestionArchivos.prcEscribeTermLinea_SMF (archivo);
        pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (
            archivo,
            'REPORTE ACTIVIDADES DETENIDAS TRAS REENVIO AUTOMATICO');
        pkg_gestionArchivos.prcEscribeTermLinea_SMF (archivo);
        pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (
            archivo,
               'PROCESO FUENTE: '
            || REPLACE (isbprocesopadre, sbpaquete || '.', ''));
        pkg_gestionArchivos.prcEscribeTermLinea_SMF (archivo);
        pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (archivo,
                                                         'OPEN SMARTFLEX');
        pkg_gestionArchivos.prcEscribeTermLinea_SMF (archivo);
        pkg_gestionArchivos.prcEscribeTermLinea_SMF (archivo);
        pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (
            archivo,
            'Fecha de Proceso: ' || SYSDATE);
        pkg_gestionArchivos.prcEscribeTermLinea_SMF (archivo);
        pkg_gestionArchivos.prcEscribeTermLinea_SMF (archivo);

        IF sbfilesource = 'REPORTE'
        THEN
            --Encabezado archivo adjunto
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (archivo,
                                                             'IDENTIFICADOR');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (archivo,
                                                             ';TIPO_PAQUETE');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (
                archivo,
                ';DESCRIPCION_TYPO_PAQUETE');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (archivo,
                                                             ';ACTIVIDAD');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (
                archivo,
                ';ESTADO ACTIVIDAD/TRAMITE');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (archivo,
                                                             ';NO_SOLICITUD');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (archivo,
                                                             ';ACCION');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (
                archivo,
                ';MENSAJE_DE_ERROR');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (
                archivo,
                ';FECHA_REGISTRO');
            pkg_gestionArchivos.prcEscribeTermLinea_SMF (archivo);

            --Relleno el detalle del Archivo
            FOR rccurpt IN culistareport
            LOOP
                --CA 200-761
                boexistendatos := TRUE;

                pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (
                    archivo,
                       rccurpt.identificador
                    || ';'
                    || rccurpt.tipo_paquete
                    || ';'
                    || rccurpt.descripcion_typo_paquete
                    || ';'
                    || rccurpt.actividad
                    || ';'
                    || rccurpt.estado
                    || ';'
                    || rccurpt.no_solicitud
                    || ';'
                    || rccurpt.accion
                    || ';'
                    || REPLACE (rccurpt.mensaje_de_error, ',', '|')
                    || ';'
                    || rccurpt.fecha_registro);
                pkg_gestionArchivos.prcEscribeTermLinea_SMF (archivo);
            END LOOP;

            pkg_gestionArchivos.prcCerrarArchivo_SMF (archivo, NULL, NULL);
        ELSIF sbfilesource = 'PROCESO'
        THEN
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (archivo,
                                                             'FUENTE');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (archivo,
                                                             ';WORKFLOW_ID');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (archivo,
                                                             ';ACTIVIDAD');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (
                archivo,
                ';ESTADO ACTIVIDAD');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (
                archivo,
                ';TRAMITE/SOLICITUD');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (archivo,
                                                             ';MOTIVO');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (archivo,
                                                             ';COMPONENTE');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (archivo,
                                                             ';ACCION');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (
                archivo,
                ';CAUSAL_SALIDA');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (
                archivo,
                ';NUMERO_SERVICIO');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (
                archivo,
                ';MENSAJE_DE_ERROR');
            pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (
                archivo,
                ';FECHA_GRABACION');
            pkg_gestionArchivos.prcEscribeTermLinea_SMF (archivo);

            --Relleno el detalle del Archivo
            FOR rccurlog IN culistalog
            LOOP
                --CA 200-761
                boexistendatos := TRUE;

                pkg_gestionArchivos.prcEscribirLineaSinTerm_SMF (
                    archivo,
                       rccurlog.fuente
                    || ';'
                    || rccurlog.workflow_id
                    || ';'
                    || rccurlog.actividad
                    || ';'
                    || rccurlog.estado_actividad
                    || ';'
                    || rccurlog.tramite
                    || ';'
                    || rccurlog.motivo
                    || ';'
                    || rccurlog.componente
                    || ';'
                    || rccurlog.accion
                    || ';'
                    || rccurlog.causal_salida
                    || ';'
                    || rccurlog.numero_servicio
                    || ';'
                    || REPLACE (rccurlog.mensaje_error, ',', '|')
                    || ';'
                    || rccurlog.fecha_grabacion);
                pkg_gestionArchivos.prcEscribeTermLinea_SMF (archivo);
            END LOOP;

            pkg_gestionArchivos.prcCerrarArchivo_SMF (archivo, NULL, NULL);
        END IF;

        --Se establece la ruta completa del archivo en la variable PATH (Solo para la compresion)
        sbpath := sbruta || '/' || sbnombrearch;

        --Comprimir archivos
        compressfile (sbpath || '.' || sbfileext, sbpath || '.ZIP');

        --Se valida si el archivo ZIP fue creado correctamente se adjunta, si no se envia el CSV
        --y Se indica con la variable SBFILEEXT
        blfile := BFILENAME (directorio, sbnombrearch || '.ZIP');
        nuarchexiste := DBMS_LOB.fileexists (blfile);

        IF nuarchexiste = 1
        THEN
            sbfileext := 'ZIP';
        ELSE
            blfile := NULL;
            blfile :=
                BFILENAME (directorio, sbnombrearch || '.' || sbfileext);
            nuarchexiste := DBMS_LOB.fileexists (blfile);

            IF nuarchexiste = 1
            THEN
                sbfileext := 'CSV';
            END IF;
        END IF;

        --Se valida si hay archivo a enviar
        IF sbfileext = 'ZIP' OR sbfileext = 'CSV'
        THEN
            DBMS_LOB.open (blfile, DBMS_LOB.file_readonly);
            nutam_archivo := DBMS_LOB.getlength (blfile);
            DBMS_LOB.createtemporary (adjunto, TRUE);
            DBMS_LOB.loadfromfile (adjunto, blfile, nutam_archivo);
            DBMS_LOB.close (blfile);

            --Por requisito del proceso que envia el mensaje se hace envio por cada destinario
            FOR i IN cucorreos (sbto)
            LOOP
                --CA 200-761
                IF boexistendatos = TRUE
                THEN                                
                    --Enviar el correo electronico con el adjunto
                    pkg_Correo.prcEnviaCorreo
                    (
                        isbDestinatarios    => i.COLUMN_VALUE,
                        isbAsunto           => sbsubject,
                        isbMensaje          => sbmsg,
                        isbArchivos         => directorio || '/'|| sbnombrearch || '.' || sbfileext,
                        isbDescRemitente    => sbfromdisplay
                    );                                        
                END IF;
            END LOOP;

            --Libero el archivo BLOB de la memoria.
            DBMS_LOB.freetemporary (adjunto);

            --Se borran los archivos que se generaron en el servidor.
            BEGIN
                IF sbfileext = 'CSV'
                THEN
                    pkg_gestionArchivos.prcBorrarArchivo_SMF (
                        sbruta,
                        sbnombrearch || '.CSV');
                ELSIF sbfileext = 'ZIP'
                THEN
                    pkg_gestionArchivos.prcBorrarArchivo_SMF (
                        sbruta,
                        sbnombrearch || '.ZIP');
                    pkg_gestionArchivos.prcBorrarArchivo_SMF (
                        sbruta,
                        sbnombrearch || '.CSV');
                END IF;
            EXCEPTION
                WHEN OTHERS
                THEN
                    osberrormessage :=
                        'ERROR AL BORRAR LOS ARCHIVOS TEMPORALES DEL SERVIDOR';
            END;
        ELSE
            --Se genera el error
            RAISE exnofile;
        END IF;

        --CA 200-761 Si Existen datos se crea el adjunto y se envia por correo
        IF boexistendatos = TRUE
        THEN
            -- estado del Proceso Actual
            pkg_estaproc.prActualizaEstaproc ( 
                isbProceso => sbproceso, 
                isbObservacion => 'Termino OK  / correo enviado!.', 
                isbEstado => 'OK' 
            );

            --Se actualiza estado del Proceso **Padre** en ESTAPROC
            pkg_estaproc.prActualizaEstaproc ( 
                isbProceso => isbprocesopadre, 
                isbObservacion => 'Termino OK  / correo enviado!.', 
                isbEstado => 'OK' 
            );

        ELSE

            -- estado del Proceso Actual
            pkg_estaproc.prActualizaEstaproc ( 
                isbProceso => sbproceso, 
                isbObservacion => 'Termino OK  - No hay Actividades para notificar. / No se envio correo.', 
                isbEstado => 'OK' 
            );

            --Se actualiza estado del Proceso **Padre** en ESTAPROC
            pkg_estaproc.prActualizaEstaproc ( 
                isbProceso => isbprocesopadre, 
                isbObservacion => 'Termino OK  - No hay Actividades para notificar. / No se envio correo.', 
                isbEstado => 'OK' 
            );

        END IF;

        pkg_traza.Trace ('FIN ' || sbpaquete || '.' || sbproceso);
    EXCEPTION
        WHEN exparam
        THEN
            osberrormessage :=
                'PRONOTIFACTIV: NO SE ENVIO EL MENSAJE. VERIFICAR QUE LOS PARAMETROS (LDC_WF_DIRECTORY_ACTIVDET, LDC_WF_MAIL_REP_ACTIV_DET, LDC_WF_SENDACTIV_MAILSOURCE) TENGAN DATOS VALIDOS.';

            --Se actualiza estado del Proceso **Padre** en ESTAPROC
            pkg_estaproc.prActualizaEstaproc ( 
                isbProceso => isbprocesopadre, 
                isbObservacion => osberrormessage, 
                isbEstado => 'Error' 
            );
                                      
        WHEN exruta
        THEN
            osberrormessage :=
                'PRONOTIFACTIV: NO SE ENVIO EL MENSAJE. VERIFICAR QUE EL DIRECTORIO DEFINIDO EN EL PARAMETRO LDC_WF_DIRECTORY_ACTIVDET TENGA UNA RUTA VALIDA EN EL SERVIDOR PARA GENERAR EL ADJUNTO.';

            --Se actualiza estado del Proceso **Padre** en ESTAPROC
            pkg_estaproc.prActualizaEstaproc ( 
                isbProceso => isbprocesopadre, 
                isbObservacion => osberrormessage, 
                isbEstado => 'Error' 
            );
            
        WHEN exnofile
        THEN
            osberrormessage :=
                   'PRONOTIFACTIV: NO SE ENVIO EL MENSAJE. ERROR AL CARGAR EL ARCHIVO ADJUNTO; VALIDAR LOS PERMISOS EN EL DIRECTORIO PARAMETRIZADO.'
                || CHR (10)
                || SQLERRM
                || CHR (10);
                
            --Se actualiza estado del Proceso **Padre** en ESTAPROC
            pkg_estaproc.prActualizaEstaproc ( 
                isbProceso => isbprocesopadre, 
                isbObservacion => osberrormessage, 
                isbEstado => 'Error' 
            );
        WHEN OTHERS
        THEN
            pkg_Traza.Trace (sbmsgtbl);

            osberrormessage :=
                   'PRONOTIFACTIV: TERMINO CON ERROR NO CONTROLADO. '
                || CHR (10)
                || SQLERRM;

            --Se actualiza estado del Proceso **Padre** en ESTAPROC
            pkg_estaproc.prActualizaEstaproc ( 
                isbProceso => isbprocesopadre, 
                isbObservacion => osberrormessage, 
                isbEstado => 'Error' 
            );
            
    END pronotifactiv;

    PROCEDURE compressfile (p_in_file IN VARCHAR2, p_out_file IN VARCHAR2)
    AS
        /*****************************************************************
          Propiedad intelectual de Gases del Caribe / Efigas S.A.

          Nombre del Proceso: COMPRESSFILE
          Descripcion: Proceso que comprime el contenido de un archivo en las rutas especificadas en los parametros.
                       Nota: en los parametros debe colocarse la ruta completa hacia el archivo con su extension. ej:
                       COMPRESSFILE('/smartfiles/tmp/hola.xls','/smartfiles/tmp/hola.zip')y luego de la ejecucion verificar
                       si el archivo efectivamente fue creado.

          Autor  : Ing. Oscar Ospino Patino, Ludycom S.A.
          Fecha  : 20-06-2016 (Fecha Creacion Paquete)  No Tiquete CA(200-460) Entrega: CRM_SAC_OOP_200460_1

          Historia de Modificaciones

          DD-MM-YYYY    <Autor>.              Modificacion
          -----------  -------------------    -------------------------------------

        ******************************************************************/

        LANGUAGE JAVA
        NAME 'LDC_UTILZIP.compressFile(java.lang.String,
java.lang.String)' ;

    FUNCTION fbocheckmailformat (isbdata VARCHAR2)
        RETURN BOOLEAN
    IS
        /*****************************************************************
          Propiedad intelectual de Gases del Caribe / Efigas S.A.

          Nombre del Proceso: FBOCHECKMAILFORMAT
          Descripcion: Funcion que valida si la cadena pasada como parametro cumple con la estructura .

          Autor  : Ing. Oscar Ospino Patino, Ludycom S.A.
          Fecha  : 20-06-2016 (Fecha Creacion Paquete)  No Tiquete CA(200-460) Entrega: CRM_SAC_OOP_200460_1

          Historia de Modificaciones

          DD-MM-YYYY    <Autor>.              Modificacion
          -----------  -------------------    -------------------------------------

        ******************************************************************/

        boresult     BOOLEAN := FALSE;
        nucant       NUMBER;
        nucantmail   NUMBER;
    BEGIN
        --Contar la cantidad de datos
        BEGIN
            SELECT COUNT(regexp_substr(isbdata,'[^;]+', 1,LEVEL)) 
            INTO nucant
            FROM dual
            CONNECT BY regexp_substr(isbdata, '[^;]+', 1, LEVEL) IS NOT NULL;
        EXCEPTION
            WHEN OTHERS
            THEN
                boresult := FALSE;
        END;

        --Contar la cantidad de datos que cumplen la estructura de correo electronico
        BEGIN
            SELECT COUNT(regexp_substr(isbdata,'[^;]+', 1,LEVEL))
            INTO nucantmail
            FROM dual
            WHERE REGEXP_LIKE(
                    regexp_substr(isbdata,'[^;]+', 1,LEVEL),
                    '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$')                  
            CONNECT BY regexp_substr(isbdata, '[^;]+', 1, LEVEL) IS NOT NULL;

        EXCEPTION
            WHEN OTHERS
            THEN
                boresult := FALSE;
        END;

        --Comparo las cantidades. Si son iguales la cadena esta bien formada. (TRUE)
        IF nucantmail = nucant
        THEN
            boresult := TRUE;
        ELSE
            boresult := FALSE;
        END IF;

        RETURN boresult;
    EXCEPTION
        WHEN OTHERS
        THEN
            boresult := FALSE;
            RETURN boresult;
    END fbocheckmailformat;

    FUNCTION fcrsplitdata (isbdata IN VARCHAR2, osberror OUT VARCHAR2)
        RETURN CONSTANTS_PER.TYREFCURSOR
    IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: fcrsplitdata
        Descripcion:        Toma la cadena de entrada separada por '|' y la devuelve
                            en un cursor referenciado de una sola fila.

        Autor    : Oscar Ospino P.
        Fecha    : 26-05-2016  CA 200-210

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        26-05-2016   Oscar Ospino P.        Creacion
        ******************************************************************/

        cuparam   CONSTANTS_PER.TYREFCURSOR;
    BEGIN
        --Se abre el cursor con la consulta que separa la cadena y hace el pivot para que los datos queden en una fila.
        OPEN cuparam FOR
            SELECT regexp_substr(isbdata,'[^;]+', 1,LEVEL) COLUMN_VALUE
            FROM dual
            CONNECT BY regexp_substr(isbdata, '[^;]+', 1, LEVEL) IS NOT NULL;

        RETURN cuparam;
    EXCEPTION
        WHEN OTHERS
        THEN
            osberror :=
                   'TERMINO CON ERROR NO CONTROLADO  '
                || sbpaquete
                || '.'
                || '('
                || '): '
                || SQLERRM;
    END fcrsplitdata;
END ldc_wf_sendactivities;
/

