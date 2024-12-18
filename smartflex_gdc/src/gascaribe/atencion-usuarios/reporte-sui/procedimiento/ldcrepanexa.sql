CREATE OR REPLACE PROCEDURE ldcrepanexa (
    inuProgramacion   IN ge_process_schedule.process_schedule_id%TYPE)
IS
    /*********************************************************************************************
      Propiedad intelectual de JM GESTIONINFORMATICA S.A
      Funcion     : ldcrepanexa
      Descripcion : Nuevo reporte SUI ANEXO A

      Autor  : John Jairo Jimenez Marimon
      Fecha  : 16-06-2016

      Historia de Modificaciones

      DD-MM-YYYY    <Autor>.SAONNNNN            Modificacion
      -----------  -------------------          -------------------------------------
      16/11/2016   John Jairo Jimenez Marimon
      11/02/2019   John Jairo Jimenez Marimon  caso 200-2392 se agregan condiciones de sol no escritas
      24/02/2019   200-2392. HT. Se manejan errores, y se genera log de errores y se manejan funcionalidades solicitadas
                   en cambio de alcance de 200-2392
      27/05/2019   200-2392. CAMBIO DE ALCANCE. HT. Se cambia funcionalidad para determinar fecha de notificacion de las iteraciones por carta.
                   Manejando las fechas de ejecucion de las ot 10004 y 10005
      09/09/2019   75. HT. manejo de fechas de respuesta para iteraciones por carta
      29/09/2019   75. HT. cambio de alcance. mmanejo tipo de notificacion cuando por carta no se tenga respuesta aun (este en proceso)
      15/07/2020   467 ht. se adecua procedimiento para manejo de interacciones cuyo flujo termina con ordenes del tipo de trabajo 10343
      13/01/2022   943 ht. se modifica llamado a cursor cursor cuordenestrasspd que deben ser llamados con el numero de la solicitud y
                       no con el de la interacción en el recorrido de los cursores cusolicitudesconfirma y cusolnonotifi.
      18/07/2022   OSF-436: Actualizar la sentencias de los cursores cusolicitudes y cusolictasorecursos para agregar validacion del
                            tipo de solcitud con base a la respuesta y no permitir la duplicidad de DATA
      14/02/2023   Jorge Valiente OSF-900: Realizar cierre de cursores entre la linea de seguimiento de 46 y 47.
                                           Realizar cierre de cursores entre la linea de seguimiento de 50 y 51
      27/06/2024   jpinedc        OSF-2606: * Se usa pkg_Correo
                                  * Ajustes por estándares
    ************************************************************************************************/

    csbMetodo           CONSTANT VARCHAR2 (70) := 'ldcrepanexa';
    csbNivelTraza       CONSTANT NUMBER (2) := pkg_traza.fnuNivelTrzDef;

    sbcursor                     VARCHAR2 (50);

    CURSOR curldclogerrorrsui IS
          SELECT *
            FROM ldclogerrorrsui
        ORDER BY conse;

    -- variables para el manejo del envio de archivo de log de inconsistencia 200-2392 horbath
    flArchivo                    pkg_gestionArchivos.styArchivo;
    sbNombArchivo                VARCHAR2 (200) := 'logerroressui.txt';
    sbRuta                       ld_parameter.value_chain%TYPE;
    sbRecipients                 ld_parameter.value_chain%TYPE;
    sbSubject                    VARCHAR2 (200);
    sbMessage0                   VARCHAR2 (3000);
    sbMessage1                   VARCHAR2 (3000);
    fechnoti                     DATE;
    fechnoti1                    DATE;
    titr10004                    NUMBER
        := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('LDC_TITRESNIPERS'); --CAMBIO DE ALCANCE 200-2392 PARA MANEJAR FECHAS DE NOTIFICACION A ITERACIONES X CARTA
    titr10005                    NUMBER
        := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('LDC_TITRENNOXAV'); --CAMBIO DE ALCANCE 200-2392 PARA MANEJAR FECHAS DE NOTIFICACION A ITERACIONES X CARTA


    csbTASKTYPE_RESP_SSPD           ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena ('TASKTYPE_RESP_SSPD');
    csbTIP_TRABA_FECHA_RESP_SUI     ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena ('TIPOS_TRABAJO_FECHA_RESP_SUI');
    csbTIPOS_FECHA_ANEXO_A          ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena ('TIPOS_FECHA_ANEXO_A');
    csbTASKTYPE_TRALADA_SSPD        ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena ('TASKTYPE_TRALADA_SSPD');

    -- Solicitudes confirma
    CURSOR cusolicitudesconfirma (nucurano NUMBER, nucurmes NUMBER)
    IS
        SELECT d.package_id
                   solicitud_antes,
               codigo_dane,
               d.dane_dpto,
               d.dane_municipio,
               d.dane_poblacion,
               radicado_ing,
               fecha_registro,
               tipo_tramite,
               causal,
               detalle_causal,
               numero_identificacion,
               numero_factura,
               tipo_respuesta,
               fecha_respuesta,
               radicado_res,
               fecha_notificacion,
               tipo_notificacion,
               d.tipo_solicitud,
               d.estado_solicitud,
               d.medio_recepcion,
               d.tipo_respuesta_osf,
               d.fecha_fin_ot_soli,
               d.fecha_ejec_tt_re,
               d.causal_lega_ot,
               d.tipo_unidad_oper,
               d.medio_uso,
               d.codigo_homologacion,
               d.dias_registro,
               d.estado_iteraccion,
               d.atencion_inmediata,
               d.carta,
               (SELECT tsc.description
                  FROM ps_package_type tsc
                 WHERE tsc.package_type_id =
                       TO_NUMBER (TRIM (d.tipo_solicitud)))
                   desc_tipo_solicitud,
               (SELECT esc.description
                  FROM ps_motive_status esc
                 WHERE esc.motive_status_id = d.estado_solicitud)
                   desc_estado_solicitud,
               (SELECT trc.description
                  FROM ge_reception_type trc
                 WHERE trc.reception_type_id = d.medio_recepcion)
                   desc_med_rec,
               (SELECT cac.description
                  FROM ge_causal cac
                 WHERE cac.causal_id = d.causal_lega_ot)
                   desc_causal_legalizacion,
               (SELECT tuc.descripcion
                  FROM ge_tipo_unidad tuc
                 WHERE tuc.id_tipo_unidad = d.tipo_unidad_oper)
                   desc_tipo_unidad_oper,
               (SELECT eic.description
                  FROM ps_motive_status eic
                 WHERE eic.motive_status_id = d.estado_iteraccion)
                   desc_estado_iteraccion,
               (SELECT tire.descripcion
                  FROM ldc_sui_tipres tire
                 WHERE tire.codigo = d.tipo_respuesta)
                   desc_tipo_repuesta_osf,
               d.val_ferad_feresp,
               d.val_feresp_fenot,
               d.deleysiono,
               d.unida_oper,
               ldc_paqueteanexoa.ldc_fncretornanroctasolaso (d.package_id)
                   nro_cta_ps,
               (SELECT DISTINCT (cargnuse)
                  FROM cargos
                 WHERE cargdoso = 'PP-' || TO_CHAR (d.package_id))
                   producto_cargo,
               m.subscriber_id
                   cliente,
               x.subscription_id
                   contrato,
               x.product_id
                   producto,
               x.motive_status_id
          FROM ldc_ateclirepo      ac,
               ldc_detarepoatecli  d,
               mo_packages         m,
               mo_motive           x
         WHERE     ac.tipo_reporte = 'A'
               AND ac.ano_reporte = nucurano
               AND ac.mes_reporte = nucurmes
               AND d.estado_solicitud NOT IN (32,
                                              36,
                                              35,
                                              37,
                                              26,
                                              40,
                                              45,
                                              5)
               AND TRIM (d.tipo_respuesta) =
                   TO_CHAR (
                       pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                           'TIPO_RESPUESTA_VAL'))
               AND TRIM (d.tipo_solicitud) =
                   TO_CHAR (
                       pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                           'TIPO_SOLICITUD_52'))
               AND (    d.fecha_respuesta IS NOT NULL
                    AND d.fecha_respuesta <> 'N')
               AND (d.radicado_res IS NOT NULL AND d.radicado_res <> 'N')
               AND (    d.fecha_notificacion IS NOT NULL
                    AND d.fecha_notificacion <> 'N')
               AND (    d.tipo_notificacion IS NOT NULL
                    AND d.tipo_notificacion <> 'N')
               AND (d.fecha_traslado IS NULL OR d.fecha_traslado = 'N')
               AND d.package_id IS NOT NULL
               AND m.motive_status_id NOT IN (32,
                                              36,
                                              35,
                                              37,
                                              26,
                                              40,
                                              45,
                                              5)
               AND ac.ateclirepo_id = d.ateclirepo_id
               AND d.package_id = m.package_id
               AND m.package_id = x.package_id;

    -- Solicitudes que no han sido notificadas
    CURSOR cusolnonotifi (nucuraano NUMBER, nucurmes NUMBER)
    IS
        SELECT d.package_id
                   solicitud_antes,
               codigo_dane,
               d.dane_dpto,
               d.dane_municipio,
               d.dane_poblacion,
               radicado_ing,
               fecha_registro,
               tipo_tramite,
               causal,
               detalle_causal,
               numero_identificacion,
               numero_factura,
               tipo_respuesta,
               fecha_respuesta,
               radicado_res,
               DECODE (iteraccion,
                       NULL, (SELECT yh.cust_care_reques_num
                                FROM mo_packages yh
                               WHERE yh.package_id = d.package_id),
                       iteraccion)
                   iteraccion,
               d.tipo_solicitud,
               d.estado_solicitud,
               d.medio_recepcion,
               d.tipo_respuesta_osf,
               d.fecha_fin_ot_soli,
               d.fecha_ejec_tt_re,
               d.causal_lega_ot,
               d.tipo_unidad_oper,
               d.medio_uso,
               d.codigo_homologacion,
               d.dias_registro,
               d.estado_iteraccion,
               d.atencion_inmediata,
               d.carta,
               (SELECT tsc.description
                  FROM ps_package_type tsc
                 WHERE tsc.package_type_id =
                       TO_NUMBER (TRIM (d.tipo_solicitud)))
                   desc_tipo_solicitud,
               (SELECT esc.description
                  FROM ps_motive_status esc
                 WHERE esc.motive_status_id = d.estado_solicitud)
                   desc_estado_solicitud,
               (SELECT trc.description
                  FROM ge_reception_type trc
                 WHERE trc.reception_type_id = d.medio_recepcion)
                   desc_med_rec,
               (SELECT cac.description
                  FROM ge_causal cac
                 WHERE cac.causal_id = d.causal_lega_ot)
                   desc_causal_legalizacion,
               (SELECT tuc.descripcion
                  FROM ge_tipo_unidad tuc
                 WHERE tuc.id_tipo_unidad = d.tipo_unidad_oper)
                   desc_tipo_unidad_oper,
               (SELECT eic.description
                  FROM ps_motive_status eic
                 WHERE eic.motive_status_id = d.estado_iteraccion)
                   desc_estado_iteraccion,
               (SELECT tire.descripcion
                  FROM ldc_sui_tipres tire
                 WHERE tire.codigo = d.tipo_respuesta)
                   desc_tipo_repuesta_osf,
               d.val_ferad_feresp,
               d.val_feresp_fenot,
               d.deleysiono,
               d.unida_oper,
               ldc_paqueteanexoa.ldc_fncretornanroctasolaso (d.package_id)
                   nro_cta_ps,
               (SELECT DISTINCT (cargnuse)
                  FROM cargos
                 WHERE cargdoso = 'PP-' || TO_CHAR (d.package_id))
                   producto_cargo,
               m.subscriber_id
                   cliente,
               x.subscription_id
                   contrato,
               x.product_id
                   producto,
               x.motive_status_id
          FROM ldc_ateclirepo      ac,
               ldc_detarepoatecli  d,
               mo_packages         m,
               mo_motive           x
         WHERE     ac.tipo_reporte = 'A'
               AND ac.ano_reporte = nucuraano
               AND ac.mes_reporte = nucurmes
               AND d.estado_solicitud NOT IN (32,
                                              36,
                                              35,
                                              37,
                                              26,
                                              40,
                                              45,
                                              5)
               AND TRIM (d.tipo_respuesta) NOT IN
                       (TO_CHAR (
                            pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                'TIPO_RESPU_PEND_RESPUESTA')),
                        TO_CHAR (
                            pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                'TIPO_RESPU_SIN_RESPUESTA')),
                        TO_CHAR (
                            pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                'TIPO_RESPUESTA_ARCHIVA')))
               AND TRIM (d.tipo_solicitud) IN
                       (SELECT DISTINCT (TO_CHAR (csa.tipo_solicitud))
                          FROM ldc_sui_confirepsuia csa)
               AND (    d.fecha_respuesta IS NOT NULL
                    AND d.fecha_respuesta <> 'N')
               AND (d.radicado_res IS NOT NULL AND d.radicado_res <> 'N')
               AND (d.tipo_respuesta IS NOT NULL AND d.tipo_respuesta <> 'N')
               AND (   d.fecha_notificacion IS NULL
                    OR d.fecha_notificacion = 'N')
               AND (d.tipo_notificacion IS NULL OR d.tipo_notificacion = 'N')
               AND (d.fecha_traslado IS NULL OR d.fecha_traslado = 'N')
               AND d.package_id IS NOT NULL
               AND m.motive_status_id NOT IN (32,
                                              36,
                                              35,
                                              37,
                                              26,
                                              40,
                                              45,
                                              5)
               AND ac.ateclirepo_id = d.ateclirepo_id
               AND d.package_id = m.package_id
               AND m.package_id = x.package_id;

    -- Tipos de solicitudes
    CURSOR cutipossolicitudes IS
          SELECT DISTINCT (csa.tipo_solicitud)     tspadr
            FROM ldc_sui_confirepsuia csa
        ORDER BY tspadr DESC;

    -- Cursor de solicitudes a reportar al SUI
    CURSOR cusolicitudes (dtcurfein       DATE,
                          dtcurfefi       DATE,
                          dtcuranoantes   NUMBER,
                          dtcurmesantes   NUMBER,
                          nuvartspadr     NUMBER)
    IS
        SELECT tipo_solicitud,
               (SELECT tss.description
                  FROM ps_package_type tss
                 WHERE tss.package_type_id = tipo_solicitud)
                   desc_tipo_solicitud,
               estado_solicitud,
               (SELECT em.description
                  FROM ps_motive_status em
                 WHERE em.motive_status_id = estado_solicitud)
                   desc_estado_solicitud,
               atencion_inmediata,
               grupo_causal,
               causal_sspd,
               medio_recepcion,
               estado_iteracion,
               (SELECT emi.description
                  FROM ps_motive_status emi
                 WHERE emi.motive_status_id = estado_iteracion)
                   desc_estado_iteraccion,
               ot_document,
               fecha_recibido_solicitud,
               fecha_atencion_solicitud,
               medio_rece_cod,
               desc_med_rec,
               solicitud,
               loca_dane_ps,
               producto_cargo,
               cliente,
               contrato,
               producto,
               itera,
               fech_sol_itera,
               tipo_tramite,
               nro_cta_ps,
               registro
          FROM (SELECT tipo_sol         tipo_solicitud,
                       estado_sol       estado_solicitud,
                       atencion_inme    atencion_inmediata,
                       grup_cau         grupo_causal,
                       cau_sspd         causal_sspd,
                       medio_recep      medio_recepcion,
                       estado_itera     estado_iteracion,
                       ot_document,
                       fecha_recibido_solicitud,
                       fecha_atencion_solicitud,
                       medio_rece_cod,
                       desc_med_rec,
                       solicitud,
                       loca_dane_ps,
                       producto_cargo,
                       cliente,
                       contrato,
                       producto,
                       itera,
                       fech_sol_itera,
                       tipo_tramite,
                       nro_cta_ps,
                       NVL (
                           (SELECT re.codigo
                              FROM ldc_suia_resolucion   gh,
                                   ldc_sui_confirepsuia  re
                             WHERE     gh.activo = 'S'
                                   AND re.tipo_solicitud = tipo_sol
                                   AND re.estado_solicitud = estado_sol
                                   AND re.flag_ate_inme = atencion_inme
                                   AND re.causal_reg = cau_reg
                                   AND re.tipo_trabajo = tipo_trab
                                   AND re.causal_legalizacion = causal_leg
                                   AND re.grupo = grup_cau
                                   AND re.causal_sspd = cau_sspd
                                   AND re.medio_recepcion = medio_recep
                                   AND re.estado_iteraccion = estado_itera
                                   AND re.otdocume = ot_document
                                   AND gh.codigo = re.resolucion),
                           0)           registro
                  FROM (SELECT tipo_sol,
                               estado_sol,
                               atencion_inme,
                               causal_reg
                                   cau_reg,
                               tipo_trab,
                               causal_leg,
                               grup_cau,
                               cau_sspd,
                               medio_recep,
                               area_causante,
                               area_gestiona,
                               (SELECT it.motive_status_id
                                  FROM mo_packages it
                                 WHERE it.package_id = itera)
                                   estado_itera,
                               NVL (
                                   (SELECT DECODE (ots.order_status_id,
                                                   8, 3,
                                                   2)
                                      FROM or_order_activity  acs,
                                           or_order           ots
                                     WHERE     ots.task_type_id IN
                                                   (
                                                        SELECT to_number(regexp_substr(csbTASKTYPE_RESP_SSPD,'[^,]+', 1,LEVEL))
                                                        FROM dual
                                                        CONNECT BY regexp_substr(csbTASKTYPE_RESP_SSPD, '[^,]+', 1, LEVEL) IS NOT NULL
                                                    )
                                           AND ots.order_status_id != 12
                                           AND acs.package_id = itera
                                           AND acs.order_id = ots.order_id
                                           AND ROWNUM <= 1),
                                   1)
                                   ot_document,
                               fecha_recibido_solicitud,
                               fecha_atencion_solicitud,
                               fecha_anulacion,
                               medio_rece_cod,
                               desc_med_rec,
                               solicitud,
                               ldc_paqueteanexoa.ldc_fncretornalocadanesolaso (
                                   solicitud)
                                   loca_dane_ps,
                               (SELECT DISTINCT (cargnuse)
                                  FROM cargos
                                 WHERE cargdoso =
                                       'PP-' || TO_CHAR (solicitud))
                                   producto_cargo,
                               cliente,
                               contrato,
                               producto,
                               itera,
                               (SELECT it.request_date
                                  FROM mo_packages it
                                 WHERE it.package_id = itera)
                                   fech_sol_itera,
                               (SELECT tstr.tipo_tramite
                                  FROM ldc_sui_tipsol tstr
                                 WHERE tstr.tipo_solicitud = tipo_sol)
                                   tipo_tramite,
                               ldc_paqueteanexoa.ldc_fncretornanroctasolaso (
                                   solicitud)
                                   nro_cta_ps,
                               causal_motivo,
                               fecha_final_ejecucion
                          FROM (-- Solicitudes de atencion inmediata, atendidas en el mes actual y las recibidas en el mes actual atendidas en otro mes
                                SELECT so.package_type_id
                                           tipo_sol,
                                       so.motive_status_id
                                           estado_sol,
                                       'Y'
                                           atencion_inme,
                                       -1
                                           AS causal_reg,
                                       mo.causal_id
                                           causal_motivo,
                                       0
                                           AS tipo_trab,
                                       -1
                                           AS causal_leg,
                                       cs.grupo_causal
                                           grup_cau,
                                       cs.causal_sspd
                                           cau_sspd,
                                       mr.is_write
                                           medio_recep,
                                       so.request_date
                                           fecha_recibido_solicitud,
                                       so.attention_date
                                           fecha_atencion_solicitud,
                                       NULL
                                           AS fecha_anulacion,
                                       so.reception_type_id
                                           medio_rece_cod,
                                       mr.description
                                           desc_med_rec,
                                       so.organizat_area_id
                                           area_causante,
                                       so.management_area_id
                                           area_gestiona,
                                       so.package_id
                                           solicitud,
                                       so.subscriber_id
                                           cliente,
                                       mo.subscription_id
                                           contrato,
                                       mo.product_id
                                           producto,
                                       so.cust_care_reques_num
                                           itera,
                                       NULL
                                           AS fecha_final_ejecucion
                                  FROM mo_packages        so,
                                       mo_motive          mo,
                                       ge_reception_type  mr,
                                       ldc_sui_caus_equ   cs
                                 WHERE     so.motive_status_id NOT IN (32,
                                                                       36,
                                                                       35,
                                                                       37,
                                                                       26,
                                                                       40,
                                                                       45,
                                                                       5)
                                       AND 0 =
                                           (SELECT COUNT (1)
                                              FROM ldc_detarepoatecli  dl,
                                                   ldc_ateclirepo      aa
                                             WHERE     dl.package_id =
                                                       so.package_id
                                                   AND dl.estado_solicitud =
                                                       14
                                                   AND dl.flag_reporta = 'S'
                                                   AND aa.ano_reporte =
                                                       dtcuranoantes
                                                   AND aa.mes_reporte =
                                                       dtcurmesantes
                                                   AND aa.tipo_reporte = 'A'
                                                   AND dl.ateclirepo_id =
                                                       aa.ateclirepo_id)
                                       AND (   (so.attention_date BETWEEN dtcurfein
                                                                      AND dtcurfefi)
                                            OR (    so.motive_status_id = 14
                                                AND so.request_date BETWEEN dtcurfein
                                                                        AND dtcurfefi))
                                       AND 0 =
                                           (SELECT COUNT (1)
                                              FROM or_order_activity ac
                                             WHERE ac.package_id =
                                                   so.package_id)
                                       AND so.package_type_id = nuvartspadr
                                       AND so.package_id = mo.package_id
                                       AND so.reception_type_id =
                                           mr.reception_type_id
                                       AND mo.causal_id = cs.causal_registro
                                       AND so.PACKAGE_TYPE_ID =
                                           cs.TIPO_SOLICITUD
                                UNION ALL
                                -- Solicitudes atendidas de atencion no-inmediata en el mes actual y recibidas en el mes actual y atendidas en otro mes
                                SELECT so.package_type_id
                                           tipo_sol,
                                       so.motive_status_id
                                           estado_sol,
                                       'N'
                                           AS atencion_inme,
                                       -1
                                           AS causal_reg,
                                       -1
                                           AS causal_motivo,
                                       ot.task_type_id
                                           tipo_trab,
                                       ot.causal_id
                                           causal_leg,
                                       tc.grupo_causal
                                           grup_cau,
                                       tc.causal_sspd
                                           cau_sspd,
                                       mere.is_write
                                           medio_recep,
                                       so.request_date
                                           fecha_recibido_solicitud,
                                       so.attention_date
                                           fecha_atencion_solicitud,
                                       NULL
                                           AS fecha_anulacion,
                                       so.reception_type_id
                                           medio_rece_cod,
                                       mere.description
                                           desc_med_rec,
                                       so.organizat_area_id
                                           area_causante,
                                       so.management_area_id
                                           area_gestiona,
                                       so.package_id
                                           solicitud,
                                       so.subscriber_id
                                           cliente,
                                       oa.subscription_id
                                           contrato,
                                       oa.product_id
                                           producto,
                                       so.cust_care_reques_num
                                           itera,
                                       ot.execution_final_date
                                           fecha_final_ejecucion
                                  FROM mo_packages        so,
                                       ge_reception_type  mere,
                                       or_order_activity  oa,
                                       or_order           ot,
                                       ldc_sui_titrcale   tc,
                                       LDC_SUI_RESPUESTA  res       ---OSF-436
                                 WHERE     so.motive_status_id NOT IN (32,
                                                                       36,
                                                                       35,
                                                                       37,
                                                                       26,
                                                                       40,
                                                                       45,
                                                                       5)
                                       AND 0 =
                                           (SELECT COUNT (1)
                                              FROM ldc_detarepoatecli  dl,
                                                   ldc_ateclirepo      aa
                                             WHERE     dl.package_id =
                                                       so.package_id
                                                   AND dl.estado_solicitud =
                                                       14
                                                   AND dl.flag_reporta = 'S'
                                                   AND aa.ano_reporte =
                                                       dtcuranoantes
                                                   AND aa.mes_reporte =
                                                       dtcurmesantes
                                                   AND aa.tipo_reporte = 'A'
                                                   AND dl.ateclirepo_id =
                                                       aa.ateclirepo_id)
                                       AND (   (so.attention_date BETWEEN dtcurfein
                                                                      AND dtcurfefi)
                                            OR (    so.motive_status_id = 14
                                                AND so.request_date BETWEEN dtcurfein
                                                                        AND dtcurfefi))
                                       AND ot.order_status_id = 8
                                       AND so.reception_type_id =
                                           mere.reception_type_id
                                       AND so.package_type_id = nuvartspadr
                                       AND so.package_id = oa.package_id
                                       AND oa.order_id = ot.order_id
                                       AND ot.task_type_id = tc.tipo_trabajo
                                       AND ot.causal_id =
                                           tc.causal_legalizacion
                                       ----OSF-436
                                       AND tc.respuesta = res.idrespu
                                       AND res.tipo_solicitud =
                                           so.package_type_id
                                ----FIN OSF-436
                                UNION ALL
                                -- Solicitudes registradas hasta el mes actual no atendidas
                                SELECT so.package_type_id
                                           tipo_sol,
                                       so.motive_status_id
                                           estado_sol,
                                       'N'
                                           AS atencion_inme,
                                       mo.causal_id
                                           causal_reg,
                                       mo.causal_id
                                           AS causal_motivo,
                                       0
                                           AS tipo_trab,
                                       -1
                                           AS causal_leg,
                                       cs.grupo_causal
                                           grup_cau,
                                       cs.causal_sspd
                                           cau_sspd,
                                       mr.is_write
                                           medio_recep,
                                       so.request_date
                                           fecha_recibido_solicitud,
                                       so.attention_date
                                           fecha_atencion_solicitud,
                                       NULL
                                           AS fecha_anulacion,
                                       so.reception_type_id
                                           medio_rece_cod,
                                       mr.description
                                           desc_med_rec,
                                       so.organizat_area_id
                                           area_causante,
                                       so.management_area_id
                                           area_gestiona,
                                       so.package_id
                                           solicitud,
                                       so.subscriber_id
                                           cliente,
                                       mo.subscription_id
                                           contrato,
                                       mo.product_id
                                           producto,
                                       so.cust_care_reques_num
                                           itera,
                                       NULL
                                           AS fecha_final_ejecucion
                                  FROM mo_packages        so,
                                       ge_reception_type  mr,
                                       mo_motive          mo,
                                       ldc_sui_caus_equ   cs
                                 WHERE     so.motive_status_id NOT IN
                                               (32, 36)
                                       AND so.request_date <= dtcurfefi
                                       AND so.attention_date IS NULL
                                       AND so.package_type_id = nuvartspadr
                                       AND so.reception_type_id =
                                           mr.reception_type_id
                                       AND so.package_id = mo.package_id
                                       AND mo.causal_id = cs.causal_registro
                                       AND so.PACKAGE_TYPE_ID =
                                           cs.TIPO_SOLICITUD
                                UNION ALL
                                -- Solicitudes registradas en meses anteriores al actual y atendidas en meses despues del actual
                                SELECT so.package_type_id
                                           tipo_sol,
                                       so.motive_status_id
                                           estado_sol,
                                       'N'
                                           AS atencion_inme,
                                       mo.causal_id
                                           causal_reg,
                                       mo.causal_id
                                           AS causal_motivo,
                                       0
                                           AS tipo_trab,
                                       -1
                                           AS causal_leg,
                                       cs.grupo_causal
                                           grup_cau,
                                       cs.causal_sspd
                                           cau_sspd,
                                       mr.is_write
                                           medio_recep,
                                       so.request_date
                                           fecha_recibido_solicitud,
                                       so.attention_date
                                           fecha_atencion_solicitud,
                                       NULL
                                           AS fecha_anulacion,
                                       so.reception_type_id
                                           medio_rece_cod,
                                       mr.description
                                           desc_med_rec,
                                       so.organizat_area_id
                                           area_causante,
                                       so.management_area_id
                                           area_gestiona,
                                       so.package_id
                                           solicitud,
                                       so.subscriber_id
                                           cliente,
                                       mo.subscription_id
                                           contrato,
                                       mo.product_id
                                           producto,
                                       so.cust_care_reques_num
                                           itera,
                                       NULL
                                           AS fecha_final_ejecucion
                                  FROM mo_packages        so,
                                       ge_reception_type  mr,
                                       mo_motive          mo,
                                       ldc_sui_caus_equ   cs
                                 WHERE     so.motive_status_id NOT IN (32,
                                                                       36,
                                                                       35,
                                                                       37,
                                                                       26,
                                                                       40,
                                                                       45,
                                                                       5)
                                       AND so.request_date <=
                                           TO_DATE (
                                                  TO_CHAR (dtcurfein - 1,
                                                           'dd/mm/yyyy')
                                               || ' 23:59:59',
                                               'dd/mm/yyyy hh24:mi:ss')
                                       AND so.attention_date >=
                                           TO_DATE (
                                                  TO_CHAR (dtcurfefi + 1,
                                                           'dd/mm/yyyy')
                                               || ' 00:00:00',
                                               'dd/mm/yyyy hh24:mi:ss')
                                       AND so.package_type_id = nuvartspadr
                                       AND so.reception_type_id =
                                           mr.reception_type_id
                                       AND so.package_id = mo.package_id
                                       AND mo.causal_id = cs.causal_registro
                                       AND so.PACKAGE_TYPE_ID =
                                           cs.TIPO_SOLICITUD
                                UNION ALL
                                -- Solicitudes anuladas o en anulacion de meses anteriores al actual
                                SELECT so.package_type_id
                                           tipo_sol,
                                       so.motive_status_id
                                           estado_sol,
                                       'N'
                                           atencion_inme,
                                       mo.causal_id
                                           causal_reg,
                                       mo.causal_id
                                           AS causal_motivo,
                                       0
                                           AS tipo_trab,
                                       -1
                                           AS causal_leg,
                                       cs.grupo_causal
                                           grup_cau,
                                       cs.causal_sspd
                                           cau_sspd,
                                       mr.is_write
                                           medio_recep,
                                       so.request_date
                                           fecha_recibido_solicitud,
                                       so.attention_date
                                           fecha_atencion_solicitud,
                                       mo.annul_date
                                           fecha_anulacion,
                                       so.reception_type_id
                                           medio_rece_cod,
                                       mr.description
                                           desc_med_rec,
                                       so.organizat_area_id
                                           area_causante,
                                       so.management_area_id
                                           area_gestiona,
                                       so.package_id
                                           solicitud,
                                       so.subscriber_id
                                           cliente,
                                       mo.subscription_id
                                           contrato,
                                       mo.product_id
                                           producto,
                                       so.cust_care_reques_num
                                           itera,
                                       NULL
                                           AS fecha_final_ejecucion
                                  FROM mo_packages        so,
                                       ge_reception_type  mr,
                                       mo_motive          mo,
                                       ldc_sui_caus_equ   cs
                                 WHERE     so.motive_status_id IN (32,
                                                                   36,
                                                                   35,
                                                                   37,
                                                                   26,
                                                                   40,
                                                                   45,
                                                                   5)
                                       AND so.request_date <=
                                             TO_DATE (
                                                    TO_CHAR (dtcurfein,
                                                             'dd/mm/yyyy')
                                                 || ' 23:59:59',
                                                 'dd/mm/yyyy hh24:mi:ss')
                                           - 1
                                       AND mo.annul_date BETWEEN dtcurfein
                                                             AND dtcurfefi
                                       AND so.attention_date IS NULL
                                       AND so.package_type_id = nuvartspadr
                                       AND so.reception_type_id =
                                           mr.reception_type_id
                                       AND so.package_id = mo.package_id
                                       AND mo.causal_id = cs.causal_registro
                                       AND so.PACKAGE_TYPE_ID =
                                           cs.TIPO_SOLICITUD)))
         WHERE registro >= 1;

    -- Solicitudes asociadas a los recursos
    CURSOR cusolictasorecursos (nusolicitud    NUMBER,
                                nuvarqueja     NUMBER,
                                nucarreclamo   NUMBER)
    IS
        SELECT *
          FROM (SELECT tc.grupo_causal gcre, tc.causal_sspd csre
                  FROM mo_packages_asso   lk,
                       mo_packages        jk,
                       or_order_activity  oasr,
                       or_order           otrs,
                       ldc_sui_titrcale   tc,
                       LDC_SUI_RESPUESTA  res                        --OSF-436
                 WHERE     lk.package_id = nusolicitud
                       AND jk.package_type_id IN (nuvarqueja, nucarreclamo)
                       AND otrs.order_status_id = 8
                       AND lk.package_id_asso = jk.package_id
                       AND jk.package_id = oasr.package_id
                       AND oasr.order_id = otrs.order_id
                       AND otrs.task_type_id = tc.tipo_trabajo
                       AND otrs.causal_id = tc.causal_legalizacion
                       ----OSF-436
                       AND tc.respuesta = res.idrespu
                       AND res.tipo_solicitud = jk.package_type_id
                ----FIN OSF-436
                UNION ALL
                SELECT cr.grupo_causal gcre, cr.causal_sspd csre
                  FROM mo_packages_asso  lk,
                       mo_packages       jk,
                       mo_motive         mt,
                       ldc_sui_caus_equ  cr
                 WHERE     lk.package_id = nusolicitud
                       AND jk.package_type_id IN (nuvarqueja, nucarreclamo)
                       AND lk.package_id_asso = jk.package_id
                       AND 0 = (SELECT COUNT (1)
                                  FROM or_order_activity y
                                 WHERE y.package_id = jk.package_id)
                       AND jk.package_id = mt.package_id
                       AND mt.causal_id = cr.causal_registro
                       AND jk.PACKAGE_TYPE_ID = cr.TIPO_SOLICITUD)
         WHERE ROWNUM = 1;

    -- Fechas de respuestas solicitudes escritas
    CURSOR cuordenesresp (nupackage_id mo_packages.package_id%TYPE)
    IS
        SELECT *
          FROM (  SELECT a.execution_final_date
                             execution_final_date,
                         a.causal_id
                             causal_lega_resp,
                         (SELECT ut.unit_type_id
                            FROM or_operating_unit ut
                           WHERE ut.operating_unit_id = a.operating_unit_id)
                             tipo_unidad,
                         a.operating_unit_id
                             unidad_operativa
                    FROM or_order a, or_order_activity b
                   WHERE     a.order_id = b.order_id
                         AND a.ORDER_STATUS_ID <> 12
                         AND b.package_id = nupackage_id
                         AND b.task_type_id IN
                                 (
                                    SELECT to_number(regexp_substr(csbTASKTYPE_RESP_SSPD,'[^,]+', 1,LEVEL))
                                    FROM dual
                                    CONNECT BY regexp_substr(csbTASKTYPE_RESP_SSPD, '[^,]+', 1, LEVEL) IS NOT NULL
                                )
                ORDER BY execution_final_date DESC)
         WHERE ROWNUM = 1;

    CURSOR c_titr10005 (nupackage_id mo_packages.package_id%TYPE)
    IS
        SELECT *
          FROM (  SELECT a.execution_final_date     execution_final_date
                    FROM or_order a, or_order_activity b
                   WHERE     a.order_id = b.order_id
                         AND a.ORDER_STATUS_ID <> 12
                         AND b.package_id = nupackage_id
                         AND b.task_type_id = titr10005
                ORDER BY created_date DESC)
         WHERE ROWNUM = 1;


    CURSOR c_titr10004 (nupackage_id mo_packages.package_id%TYPE)
    IS
        SELECT *
          FROM (  SELECT a.execution_final_date     execution_final_date
                    FROM or_order a, or_order_activity b
                   WHERE     a.order_id = b.order_id
                         AND a.ORDER_STATUS_ID <> 12
                         AND b.package_id = nupackage_id
                         AND b.task_type_id = titr10004
                ORDER BY created_date DESC)
         WHERE ROWNUM = 1;


    CURSOR c_titr10343 (nupackage_id mo_packages.package_id%TYPE)
    IS
        SELECT *
          FROM (  SELECT a.execution_final_date     execution_final_date
                    FROM or_order a, or_order_activity b
                   WHERE     a.order_id = b.order_id
                         AND a.ORDER_STATUS_ID <> 12
                         AND b.package_id = nupackage_id
                         AND b.task_type_id = 10343
                ORDER BY created_date DESC)
         WHERE ROWNUM = 1;

    -- Solicitudes asociadas
    CURSOR cusoliasoci (nucusolicitud mo_packages.package_id%TYPE)
    IS
          SELECT pa.request_date     fecha_solicitud_anula
            FROM mo_packages_asso ap, mo_packages pa
           WHERE     ap.package_id = nucusolicitud
                 AND ap.package_id_asso = pa.package_id
                 AND ROWNUM = 1
        ORDER BY pa.request_date ASC;

    -- Fecha de respuestas solicitudes verbales
    CURSOR cuordenessol (nupackage_id mo_packages.package_id%TYPE)
    IS
        SELECT *
          FROM (  SELECT a.execution_final_date
                             execution_final_date,
                         a.causal_id
                             causal_lega_sol,
                         (SELECT ut.unit_type_id
                            FROM or_operating_unit ut
                           WHERE ut.operating_unit_id = a.operating_unit_id)
                             tipo_unidad,
                         a.operating_unit_id
                             unidad_operativa
                    FROM or_order a, or_order_activity b
                   WHERE     a.order_id = b.order_id
                         AND a.ORDER_STATUS_ID <> 12
                         AND b.package_id = nupackage_id
                         AND a.task_type_id IN
                                 (
                                    SELECT to_number(regexp_substr(csbTIP_TRABA_FECHA_RESP_SUI,'[^,]+', 1,LEVEL))
                                    FROM dual
                                    CONNECT BY regexp_substr(csbTIP_TRABA_FECHA_RESP_SUI, '[^,]+', 1, LEVEL) IS NOT NULL                                                 
                                  )
                         AND a.order_status_id = 8
                ORDER BY execution_final_date)
         WHERE ROWNUM = 1;

    -- Fechas adicionales
    CURSOR cuFechaAdicionales (nucusolicitud    NUMBER, /*dtfechafinrep DATE,*/
                               nucumediorecep   NUMBER,
                               nucutipres       NUMBER)
    IS
        SELECT new_date, tipo_notificacion
          FROM (  SELECT new_date, tipo_notificacion
                    FROM mo_addi_request_dates f,
                         ldc_sui_nttrtf       q,
                         ldc_sui_ordentipofech n
                   WHERE     request_id = nucusolicitud
                         AND request_date_typ_id IN
                                (
                                    SELECT to_number(regexp_substr(csbTIPOS_FECHA_ANEXO_A,'[^,]+', 1,LEVEL))
                                    FROM dual
                                    CONNECT BY regexp_substr(csbTIPOS_FECHA_ANEXO_A, '[^,]+', 1, LEVEL) IS NOT NULL
                                )
                         --   AND new_date             <= dtfechafinrep
                         AND f.request_date_typ_id = q.tipo_fecha_respuesta
                         AND q.medio_recepcion = nucumediorecep
                         AND q.tipo_respuesta = nucutipres
                         AND q.tipo_fecha_respuesta = n.tipo_fecha
                ORDER BY n.orden)
         WHERE ROWNUM = 1;

    -- Ordenes de traslado
    CURSOR cuordenestrasspd (nupackage_id mo_packages.package_id%TYPE)
    IS
          SELECT a.execution_final_date
            FROM or_order a, or_order_activity b
           WHERE     a.order_id = b.order_id
                 AND b.package_id = nupackage_id
                 AND a.order_status_id = 8
                 AND b.task_type_id IN
                        (
                            SELECT to_number(regexp_substr(csbTASKTYPE_TRALADA_SSPD,'[^,]+', 1,LEVEL))
                            FROM dual
                            CONNECT BY regexp_substr(csbTASKTYPE_TRALADA_SSPD, '[^,]+', 1, LEVEL) IS NOT NULL
                        )
                 AND ROWNUM = 1
        ORDER BY a.created_date;                       --mejora              ;

    sbParametros                 ge_process_schedule.parameters_%TYPE;
    nuHilos                      NUMBER := 1;
    nuLogProceso                 ge_log_process.log_process_id%TYPE;
    sbcoddane                    ldc_detarepoatecli.codigo_dane%TYPE;
    nulocaddan                   ge_geogra_location.geograp_location_id%TYPE;
    rcldc_equiva_localidad       daldc_equiva_localidad.styldc_equiva_localidad;
    blexiste                     BOOLEAN;
    nres                         NUMBER (5) DEFAULT 0;
    sbradicado                   mo_packages.cust_care_reques_num%TYPE;
    dtfechrad                    DATE;
    sbtitra                      ldc_detarepoatecli.tipo_tramite%TYPE;
    sbgrupcaus                   ldc_sui_grupcaus.codigo%TYPE;
    nucaussspd                   ldc_sui_confirepsuia.causal_sspd%TYPE;
    sbnrocuenta                  ldc_detarepoatecli.numero_identificacion%TYPE;
    sbnrofactura                 ldc_detarepoatecli.numero_factura%TYPE;
    sbtiporespu                  ldc_detarepoatecli.tipo_respuesta%TYPE;
    dtfecharespu                 VARCHAR2 (20);
    rccuordenessol               cuOrdenesSol%ROWTYPE;
    sbradrespuesta               ldc_detarepoatecli.radicado_res%TYPE;
    dtfechanotifica              DATE;
    sbtiponotifica               ldc_detarepoatecli.tipo_notificacion%TYPE;
    nupano                       NUMBER (4);
    nupmes                       NUMBER (2);
    sbdirectory                  ge_directory.PATH%TYPE;
    sbcorreo                     ge_subscriber.e_mail%TYPE;
    sbregenera                   ge_subscriber.active%TYPE;
    nutsess                      NUMBER;
    sbparuser                    VARCHAR2 (30);
    cnunull_attribute   CONSTANT NUMBER := 2126;
    nupakgsoliproc               mo_packages.package_id%TYPE;
    sberror                      VARCHAR2 (1000);
    nuerror                      NUMBER (10);
    nuidreporte                  ldc_ateclirepo.ateclirepo_id%TYPE;
    sbFile                       VARCHAR2 (250);
    sbaprobado                   ldc_ateclirepo.aprobado%TYPE;
    nunewid                      ldc_ateclirepo.ateclirepo_id%TYPE;
    vFile                        pkg_gestionArchivos.styArchivo;
    sbLineaDeta                  VARCHAR2 (2000);
    dtfechini                    DATE;
    dtfecfin                     DATE;
    nuestsolanulada              ps_motive_status.motive_status_id%TYPE;
    nuestsolenanula              ps_motive_status.motive_status_id%TYPE;
    rcldc_detarepoatecli         daldc_detarepoatecli.styldc_detarepoatecli;
    nutiponoti                   ldc_sui_nttrtf.tipo_notificacion%TYPE;
    dtfechtraslado               DATE;
    csbSeparador                 VARCHAR2 (2) := ',';
    sbAsunto                     VARCHAR2 (2000);
    sbMensaje                    VARCHAR2 (2000);
    nuerrorcode                  NUMBER;
    nuidreportedet               NUMBER;
    nucontareg                   NUMBER (15) DEFAULT 0;
    nucantiregcom                NUMBER (15) DEFAULT 0;
    nucantiregtot                NUMBER (15) DEFAULT 0;
    sbruradirectorio             ge_directory.PATH%TYPE;
    nocontaregenera              NUMBER (15);
    sbmenrege                    VARCHAR2 (1000);
    dtrespuanula                 DATE;
    sbdesccausal                 ge_causal.description%TYPE;
    sbdesctipounit               ge_tipo_unidad.descripcion%TYPE;
    nuvalidasoli                 NUMBER (15) DEFAULT 0;
    rgconfireporte               ldc_sui_confirepsuia%ROWTYPE;
    nucodresposf                 ldc_sui_tipres.codigo_resp_osf%TYPE;
    desc_tipo_repuesta_osf       ldc_sui_tipres.descripcion%TYPE;
    nulinea                      NUMBER (4);
    nupemesante                  NUMBER (2);
    nupeanoante                  NUMBER (4);
    sbtiporegreporte             ldc_detarepoatecli.tipo_reg_reporte%TYPE;
    nudiasregistro               ldc_detarepoatecli.dias_registro%TYPE;
    nudiasregistroval            ldc_detarepoatecli.dias_registro%TYPE;
    dtfechahoy                   DATE;
    sbflagotprocinterno          ld_parameter.value_chain%TYPE;
    numediorecepotinterna        ld_parameter.numeric_value%TYPE;
    nutiposolicrere              ld_parameter.numeric_value%TYPE;
    nutiposolicrers              ld_parameter.numeric_value%TYPE;
    nureporta                    VARCHAR2 (1);
    nutiposoliquej               ld_parameter.numeric_value%TYPE;
    nutipsolirecl                ld_parameter.numeric_value%TYPE;
    swcontr                      NUMBER (1);
    sbcaussspd                   ldc_detarepoatecli.detalle_causal%TYPE;
    nuiddirectorio               ge_directory.directory_id%TYPE;
    rccuordenesresp              cuordenesresp%ROWTYPE;
    sbtipnotconconlc             VARCHAR2 (10);
    nuanula                      NUMBER (1) DEFAULT 0;
    sberrfereferad               VARCHAR2 (100);
    sberrferefenot               VARCHAR2 (100);
    sbdeley                      VARCHAR2 (100);
    nuunidadoperativa            or_order.operating_unit_id%TYPE;
    sbnombreunidadoper           or_operating_unit.name%TYPE;
    numeroerrores                NUMBER DEFAULT 0;
    pckgid                       NUMBER;
BEGIN
    pkg_traza.trace (csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

    numeroerrores := 0;
    nulinea := -1;
    nucantiregcom := 0;
    nucantiregtot := 0;
    nucontareg :=
        pkg_BCLD_Parameter.fnuObtieneValorNumerico (
            'COD_CANTIDAD_REG_GUARDAR');
    sbtipnotconconlc :=
        TO_CHAR (
            pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                'TIPO_NOTIFI_CON_CONCLU'));
    dtfechahoy := TRUNC (SYSDATE);

    -- borra log de errores
    DELETE FROM ldclogerrorrsui;

    COMMIT;
    nulinea := -2;
    -- Se adiciona al log de procesos
    ge_boschedule.AddLogToScheduleProcess (inuProgramacion,
                                           nuHilos,
                                           nuLogProceso);
    nulinea := -3;
    -- se obtiene parametros
    sbParametros := dage_process_schedule.fsbGetParameters_ (inuProgramacion);
    nupano :=
        TO_NUMBER (ut_string.getparametervalue (sbParametros,
                                                'INSISTENTLY_COUNTER',
                                                '|',
                                                '='));
    nupmes :=
        TO_NUMBER (ut_string.getparametervalue (sbParametros,
                                                'NUMBER_OF_PROD',
                                                '|',
                                                '='));
    sbdirectory :=
        TRIM (ut_string.getparametervalue (sbParametros,
                                           'PATH',
                                           '|',
                                           '='));
    sbcorreo :=
        TRIM (ut_string.getparametervalue (sbParametros,
                                           'E_MAIL',
                                           '|',
                                           '='));
    sbregenera :=
        TRIM (ut_string.getparametervalue (sbParametros,
                                           'ACTIVE',
                                           '|',
                                           '='));
    nulinea := -4;

    -- Validamos los parámetros que no vengan vacios
    IF (nupano IS NULL)
    THEN
        pkg_error.setErrorMessage (
            inuCodeError   => cnunull_attribute,
            isbMsgErrr     => 'Año de generacion Vacio.');
    END IF;

    IF (nupmes IS NULL)
    THEN
        pkg_error.setErrorMessage (inuCodeError   => cnunull_attribute,
                                   isbMsgErrr     => 'Mes de generacion');
    END IF;

    IF (sbdirectory IS NULL)
    THEN
        pkg_error.setErrorMessage (inuCodeError   => cnunull_attribute,
                                   isbMsgErrr     => 'Ruta Del Directorio');
    ELSE
        nuiddirectorio := TO_NUMBER (sbdirectory);

        SELECT di.PATH
          INTO sbruradirectorio
          FROM ge_directory di
         WHERE di.directory_id = nuiddirectorio;
    END IF;

    IF (sbcorreo IS NULL)
    THEN
        pkg_error.setErrorMessage (inuCodeError   => cnunull_attribute,
                                   isbMsgErrr     => 'Correo de entrega');
    END IF;

    sbcorreo := LOWER (sbcorreo);

    IF (sbregenera IS NULL)
    THEN
        pkg_error.setErrorMessage (inuCodeError   => cnunull_attribute,
                                   isbMsgErrr     => 'Regenera');
    END IF;

    sbregenera := UPPER (sbregenera);
    nulinea := -5;
    -- Se inicia log del programa
    nutsess := USERENV ('SESSIONID');
    sbparuser := USER;

    ldc_proinsertaestaprog (nupano,
                            nupmes,
                            'LDCREPANEXA',
                            'En ejecución',
                            nutsess,
                            sbparuser);
    -- Validamos si existe generado reporte para el periodo a evaluar.
    nulinea := -6;
    nuidreporte := NULL;
    sbaprobado := NULL;

    BEGIN
        SELECT a.ateclirepo_id, a.aprobado
          INTO nuidreporte, sbaprobado
          FROM ldc_ateclirepo a
         WHERE     a.tipo_reporte = 'A'
               AND a.ano_reporte = nupano
               AND a.mes_reporte = nupmes;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            nuidreporte := NULL;
    END;

    nulinea := -7;

    -- Validamos si esta generado el reporte
    IF nuidreporte IS NOT NULL
    THEN
        rcldc_detarepoatecli.ateclirepo_id := nuidreporte;

        -- Si esta aprobado se envia archivo
        IF NVL (sbaprobado, 'N') = 'S'
        THEN
            -- Debe generar reporte del historico
            sbruradirectorio := TRIM (sbruradirectorio) || '/';
            ldc_paqueteanexoa.regenerareportea (nuidreporte,
                                                nupano,
                                                nupmes,
                                                sbcorreo,
                                                sbaprobado,
                                                sbruradirectorio,
                                                sbmenrege);

            SELECT COUNT (1)
              INTO nocontaregenera
              FROM ldc_detarepoatecli u
             WHERE u.ateclirepo_id = rcldc_detarepoatecli.ateclirepo_id;

            ldc_proactualizaestaprog (
                nutsess,
                   'Regenera desde BD con ID: '
                || TO_CHAR (nuidreporte)
                || sbmenrege,
                'LDCREPANEXA',
                'Termino ');
            RETURN;
        ELSIF NVL (sbaprobado, 'N') = 'N' AND sbregenera = 'N'
        THEN
            -- Sino esta aprobado y desea la ultima versión generada
            sbruradirectorio := TRIM (sbruradirectorio) || '/';
            ldc_paqueteanexoa.regenerareportea (nuidreporte,
                                                nupano,
                                                nupmes,
                                                sbcorreo,
                                                sbaprobado,
                                                sbruradirectorio,
                                                sbmenrege);

            IF SUBSTR (sbmenrege, 1, 2) = '-1'
            THEN
                ldc_proactualizaestaprog (
                    nutsess,
                    'Proceso terminó con errores : ' || sbmenrege,
                    'LDCREPANEXA',
                    'Termino ');
            ELSE
                ldc_proactualizaestaprog (
                    nutsess,
                       'Regenera ultima versión desde BD con ID: '
                    || TO_CHAR (nuidreporte)
                    || ' '
                    || sbmenrege,
                    'LDCREPANEXA',
                    'Termino ');
            END IF;

            RETURN;
        ELSE
            --Sino esta aprobado, se genera nuevamente el reporte
            DELETE ldc_detarepoatecli
             WHERE ateclirepo_id = nuidreporte;

            COMMIT;
        END IF;
    ELSE
        -- Si no esta generado, se crea encabezado y detalle del reporte
        nunewid := NULL;

        SELECT sqldc_ateclirepo.NEXTVAL INTO nunewid FROM DUAL;

        INSERT INTO ldc_ateclirepo (ateclirepo_id,
                                    tipo_reporte,
                                    ano_reporte,
                                    mes_reporte,
                                    fecha_aprobacion,
                                    aprobado)
             VALUES (nunewid,
                     'A',
                     nupano,
                     nupmes,
                     NULL,
                     'N');

        rcldc_detarepoatecli.ateclirepo_id := nunewid;
        COMMIT;
    END IF;

    nulinea := -8;
    -- Debe generar reporte
    sbFile :=
           'Formato_anexo_A_'
        || nupano
        || '_'
        || nupmes
        || '_'
        || TO_CHAR (SYSDATE, 'YYYY_MM_DD_HH_MI_SS')
        || '.csv';
    vFile :=
        pkg_gestionArchivos.ftAbrirArchivo_SMF (sbruradirectorio,
                                                sbFile,
                                                'W');
    sbLineaDeta :=
        'DANE DEPARTAMENTO,DANE MUNICIPIO,DANE POBLACION,RADICADO RECIBIDO,FECHA RADICACION,TIPO DE TRAMITE,CAUSAL,DETALLE DE LA CAUSAL,NUMERO DE CUENTA,NUMERO IDENTIFICADOR DE FACTURA,TIPO RESPUESTA,FECHA RESPUESTA,RADICADO RESPUESTA,FECHA DE NOTIFICACION,TIPO DE NOTIFICACION,FECHA TRASLADO A SSPD,TIPO_SOLICITUD,ESTADO_SOLICITUD,MEDIO_RECEPCION,TIPO_RESPUESTA_OSF,FECHA_NO_CARTAS,FECHA_CARTAS,CAUSAL LEGALIZACION OT,TIPO_UNIDAD_OPERATIVA,MEDIO_USO,ID_HOMOLOGACION,DIAS_REGISTRO,TIPO_REPORTE,ESTADO_ITERACCION,SOLICITUD,ATENCION_INMEDIATA,CARTA,VAL_FECH_RESP_RADI,VAL_FECH_NOTI_RESP,DIAS_HABIL_FECH_RESP_RAD,UNIDAD_TRABAJO_ORDEN';
    pkg_gestionArchivos.prcEscribirLinea_SMF (vFile, sbLineaDeta);
    -- Obtenemos las fechas del periodo contable
    nulinea := -9;
    dtfechini :=
        TO_DATE (
               '01/'
            || TO_CHAR (nupmes)
            || '/'
            || TO_CHAR (nupano)
            || ' 00:00:00',
            'dd/mm/yyyy hh24:mi:ss');
    dtfecfin :=
        TO_DATE (TO_CHAR (LAST_DAY (dtfechini), 'dd/mm/yyyy') || ' 23:59:59',
                 'dd/mm/yyyy hh24:mi:ss');

    IF nupmes = 1
    THEN
        nupemesante := 12;
        nupeanoante := nupano - 1;
    ELSE
        nupemesante := nupmes - 1;
        nupeanoante := nupano;
    END IF;

    nulinea := -10;
    -- Solicitudes confirma
    sbcursor := 'cusolicitudesconfirma';

    FOR i IN cusolicitudesconfirma (nupeanoante, nupemesante)
    LOOP
        BEGIN
            nulinea := -11;
            nupakgsoliproc := i.solicitud_antes;
            nuidreportedet := NULL;
            sbtiporegreporte := 'CONFIRMA';
            sbnrocuenta := NULL;

            IF i.nro_cta_ps IS NOT NULL
            THEN
                sbnrocuenta := TO_CHAR (i.nro_cta_ps);
            ELSIF i.producto_cargo IS NOT NULL
            THEN
                sbnrocuenta :=
                    TO_CHAR (
                        pktblservsusc.fnugetsuscription (i.producto_cargo));
            ELSIF i.producto IS NOT NULL
            THEN
                sbnrocuenta :=
                    TO_CHAR (pktblservsusc.fnugetsuscription (i.producto));
            ELSIF i.contrato IS NOT NULL
            THEN
                sbnrocuenta := TO_CHAR (i.contrato);
            ELSE
                sbnrocuenta := '000';
            END IF;

            SELECT sqldc_detarepoatecli.NEXTVAL INTO nuidreportedet FROM DUAL;

            rcldc_detarepoatecli.package_id := i.solicitud_antes;
            rcldc_detarepoatecli.detarepoatecli_id := nuidreportedet;
            rcldc_detarepoatecli.codigo_dane := i.codigo_dane;
            rcldc_detarepoatecli.dane_dpto := i.dane_dpto;
            rcldc_detarepoatecli.dane_municipio := i.dane_municipio;
            rcldc_detarepoatecli.dane_poblacion := i.dane_poblacion;
            rcldc_detarepoatecli.radicado_ing := i.radicado_ing;
            rcldc_detarepoatecli.fecha_registro := i.fecha_registro;
            rcldc_detarepoatecli.tipo_tramite := i.tipo_tramite;
            rcldc_detarepoatecli.causal := i.causal;
            rcldc_detarepoatecli.detalle_causal := i.detalle_causal;
            rcldc_detarepoatecli.numero_identificacion := sbnrocuenta;
            rcldc_detarepoatecli.numero_factura := i.numero_factura;
            rcldc_detarepoatecli.tipo_respuesta := i.tipo_respuesta;
            rcldc_detarepoatecli.fecha_respuesta := i.fecha_respuesta;
            rcldc_detarepoatecli.radicado_res := i.radicado_res;


            IF i.medio_recepcion NOT IN (1,
                                         7,
                                         23,
                                         24)
            THEN
                -- caso 467
                OPEN c_titr10343 (i.radicado_ing);

                FETCH c_titr10343 INTO fechnoti;

                IF c_titr10343%NOTFOUND
                THEN
                    rcldc_detarepoatecli.fecha_notificacion :=
                        i.fecha_notificacion;
                    rcldc_detarepoatecli.tipo_notificacion :=
                        i.tipo_notificacion;
                ELSE
                    IF fechnoti IS NOT NULL
                    THEN
                        nutiponoti := 1;
                    ELSE
                        nutiponoti := 5;
                    END IF;
                END IF;

                CLOSE c_titr10343;

                OPEN c_titr10005 (i.radicado_ing);

                FETCH c_titr10005 INTO fechnoti1;

                IF c_titr10005%FOUND
                THEN
                    IF fechnoti1 IS NOT NULL
                    THEN
                        nutiponoti := 2;
                    END IF;
                END IF;

                CLOSE c_titr10005;
            ELSE
                OPEN c_titr10343 (i.radicado_ing);

                FETCH c_titr10343 INTO fechnoti;

                IF c_titr10343%NOTFOUND
                THEN
                    OPEN c_titr10005 (i.radicado_ing);

                    FETCH c_titr10005 INTO fechnoti;

                    IF c_titr10005%NOTFOUND
                    THEN
                        OPEN c_titr10004 (i.radicado_ing);

                        FETCH c_titr10004 INTO fechnoti;

                        IF c_titr10004%NOTFOUND
                        THEN
                            fechnoti := NULL;
                        ELSE
                            IF fechnoti IS NOT NULL
                            THEN
                                nutiponoti := 1;
                            ELSE
                                nutiponoti := 5;
                            END IF;
                        END IF;

                        CLOSE c_titr10004;
                    ELSE
                        IF fechnoti IS NOT NULL
                        THEN
                            nutiponoti := 2;
                        ELSE
                            nutiponoti := 5;
                        END IF;
                    END IF;

                    CLOSE c_titr10005;
                ELSE
                    IF fechnoti IS NOT NULL
                    THEN
                        nutiponoti := 1;
                    ELSE
                        nutiponoti := 5;
                    END IF;

                    OPEN c_titr10005 (i.radicado_ing);

                    FETCH c_titr10005 INTO fechnoti1;

                    IF c_titr10005%FOUND
                    THEN
                        IF fechnoti1 IS NOT NULL
                        THEN
                            nutiponoti := 2;
                        END IF;
                    END IF;

                    CLOSE c_titr10005;
                END IF;

                CLOSE c_titr10343;

                IF fechnoti IS NULL
                THEN
                    nutiponoti := 5;
                END IF;

                dtfechanotifica := fechnoti;
                rcldc_detarepoatecli.tipo_notificacion := nutiponoti;

                IF dtfechanotifica IS NULL
                THEN
                    rcldc_detarepoatecli.fecha_notificacion :=
                        dtfechanotifica;
                ELSE
                    rcldc_detarepoatecli.fecha_notificacion :=
                        TO_CHAR (dtfechanotifica, 'DD/MM/YYYY');
                END IF;
            END IF;


            dtfechanotifica := fechnoti;

            IF dtfechanotifica IS NULL
            THEN
                rcldc_detarepoatecli.fecha_notificacion := dtfechanotifica;
            ELSE
                rcldc_detarepoatecli.fecha_notificacion :=
                    TO_CHAR (dtfechanotifica, 'DD/MM/YYYY');
            END IF;

            rcldc_detarepoatecli.tipo_solicitud := i.tipo_solicitud;
            rcldc_detarepoatecli.estado_solicitud := i.estado_solicitud;
            rcldc_detarepoatecli.medio_recepcion := i.medio_recepcion;
            rcldc_detarepoatecli.tipo_respuesta_osf := i.tipo_respuesta_osf;
            rcldc_detarepoatecli.fecha_fin_ot_soli := i.fecha_fin_ot_soli;
            rcldc_detarepoatecli.fecha_ejec_tt_re := i.fecha_ejec_tt_re;
            rcldc_detarepoatecli.causal_lega_ot := i.causal_lega_ot;
            rcldc_detarepoatecli.tipo_unidad_oper := i.tipo_unidad_oper;
            rcldc_detarepoatecli.medio_uso := i.medio_uso;
            rcldc_detarepoatecli.codigo_homologacion :=
                NVL (i.codigo_homologacion, 0);
            rcldc_detarepoatecli.dias_registro := i.dias_registro;
            rcldc_detarepoatecli.tipo_reg_reporte := sbtiporegreporte;
            rcldc_detarepoatecli.estado_iteraccion := i.estado_iteraccion;
            rcldc_detarepoatecli.atencion_inmediata := i.atencion_inmediata;
            rcldc_detarepoatecli.carta := i.carta;
            rcldc_detarepoatecli.val_ferad_feresp := i.val_ferad_feresp;
            rcldc_detarepoatecli.val_feresp_fenot := i.val_feresp_fenot;
            rcldc_detarepoatecli.deleysiono := i.deleysiono;
            rcldc_detarepoatecli.unida_oper := i.unida_oper;
            -- 14. Fecha traslado SSPD
            nulinea := -12;
            dtfechtraslado := NULL;
            rcldc_detarepoatecli.fecha_traslado := NULL;

            -- 943
            pckgid := NULL;

            BEGIN
                  SELECT package_id
                    INTO pckgid
                    FROM mo_packages
                   WHERE     cust_care_reques_num = i.solicitud_antes
                         AND package_id <> i.solicitud_antes
                         AND ROWNUM = 1
                ORDER BY package_id;
            EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                    pckgid := NULL;
            END;

            IF pckgid IS NOT NULL
            THEN
                OPEN cuordenestrasspd (pckgid);

                FETCH cuordenestrasspd INTO dtfechtraslado;

                CLOSE cuordenestrasspd;
            END IF;

            IF dtfechtraslado IS NULL
            THEN
                rcldc_detarepoatecli.fecha_traslado := dtfechtraslado;
            ELSE
                rcldc_detarepoatecli.fecha_traslado :=
                    TO_CHAR (dtfechtraslado, 'DD/MM/YYYY');
            END IF;

            -- Nombre unidad operativa
            sbnombreunidadoper := NULL;

            BEGIN
                SELECT uo.name
                  INTO sbnombreunidadoper
                  FROM or_operating_unit uo
                 WHERE uo.operating_unit_id = rcldc_detarepoatecli.unida_oper;
            EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                    sbnombreunidadoper := NULL;
            END;

            -- Linea del registro a colocar en archivo
            nulinea := -13;
            sbLineaDeta :=
                   rcldc_detarepoatecli.dane_dpto
                || csbseparador
                || rcldc_detarepoatecli.dane_municipio
                || csbseparador
                || rcldc_detarepoatecli.dane_poblacion
                || csbseparador
                || rcldc_detarepoatecli.radicado_ing
                || csbseparador
                || rcldc_detarepoatecli.fecha_registro
                || csbseparador
                || rcldc_detarepoatecli.tipo_tramite
                || csbseparador
                || rcldc_detarepoatecli.causal
                || csbseparador
                || rcldc_detarepoatecli.detalle_causal
                || csbseparador
                || rcldc_detarepoatecli.numero_identificacion
                || csbseparador
                || rcldc_detarepoatecli.numero_factura
                || csbseparador
                || rcldc_detarepoatecli.tipo_respuesta
                || csbseparador
                || rcldc_detarepoatecli.fecha_respuesta
                || csbseparador
                || rcldc_detarepoatecli.radicado_res
                || csbseparador
                || rcldc_detarepoatecli.fecha_notificacion
                || csbseparador
                || NVL (rcldc_detarepoatecli.tipo_notificacion,
                        sbtipnotconconlc)
                || csbseparador
                || rcldc_detarepoatecli.fecha_traslado
                || csbseparador
                || rcldc_detarepoatecli.tipo_solicitud
                || ' - '
                || REPLACE (i.desc_tipo_solicitud, ',', NULL)
                || csbseparador
                || rcldc_detarepoatecli.estado_solicitud
                || ' - '
                || REPLACE (i.desc_estado_solicitud, ',', NULL)
                || csbseparador
                || rcldc_detarepoatecli.medio_recepcion
                || ' - '
                || REPLACE (i.desc_med_rec, ',', NULL)
                || csbseparador
                || rcldc_detarepoatecli.tipo_respuesta_osf
                || ' - '
                || REPLACE (i.desc_tipo_repuesta_osf, ',', NULL)
                || csbseparador
                || rcldc_detarepoatecli.fecha_fin_ot_soli
                || csbseparador
                || rcldc_detarepoatecli.fecha_ejec_tt_re
                || csbseparador
                || rcldc_detarepoatecli.causal_lega_ot
                || ' - '
                || REPLACE (i.desc_causal_legalizacion, ',', NULL)
                || csbseparador
                || rcldc_detarepoatecli.tipo_unidad_oper
                || ' - '
                || REPLACE (i.desc_tipo_unidad_oper, ',', NULL)
                || csbseparador
                || rcldc_detarepoatecli.medio_uso
                || csbseparador
                || rcldc_detarepoatecli.codigo_homologacion
                || csbseparador
                || rcldc_detarepoatecli.dias_registro
                || csbseparador
                || rcldc_detarepoatecli.tipo_reg_reporte
                || csbSeparador
                || rcldc_detarepoatecli.estado_iteraccion
                || ' - '
                || REPLACE (i.desc_estado_iteraccion, ',', NULL)
                || csbSeparador
                || rcldc_detarepoatecli.package_id
                || csbSeparador
                || rcldc_detarepoatecli.atencion_inmediata
                || csbSeparador
                || rcldc_detarepoatecli.carta
                || csbSeparador
                || rcldc_detarepoatecli.val_ferad_feresp
                || csbSeparador
                || rcldc_detarepoatecli.val_feresp_fenot
                || csbSeparador
                || rcldc_detarepoatecli.deleysiono
                || csbSeparador
                || rcldc_detarepoatecli.unida_oper
                || ' - '
                || sbnombreunidadoper;

            nucantiregcom := nucantiregcom + 1;

            IF nucantiregcom >= nucontareg
            THEN
                COMMIT;
                nucantiregtot := nucantiregtot + nucantiregcom;
                nucantiregcom := 0;
            END IF;

            -- Se imprime la linea en el archivo
            nulinea := -14;
            ldc_paqueteanexoa.impresion (vfile, sblineadeta);
            -- Creamos registro en la tabla
            nulinea := -15;
            ldc_paqueteanexoa.creadetallereporte (rcldc_detarepoatecli);
        /* end if; */
        EXCEPTION
            -- manejo de errores
            WHEN OTHERS
            THEN
                numeroerrores := numeroerrores + 1;
                sberror := SQLERRM;
                sberror := SUBSTR (sberror, 1, 200);
                ldcinsldclogerrorrsui (
                       'Error. Cursor:'
                    || sbcursor
                    || ' Solicitud:'
                    || nupakgsoliproc
                    || ' Linea:'
                    || TO_CHAR (nulinea)
                    || ' Error: '
                    || sberror);
        END;
    END LOOP;

    IF nucantiregcom <= 99
    THEN
        COMMIT;
        nucantiregtot := nucantiregtot + nucantiregcom;
    END IF;

    nucantiregcom := 0;
    -- Solicitudes que no han sido notificadas
    nulinea := -16;
    sbcursor := 'cusolnonotifi';

    FOR i IN cusolnonotifi (nupeanoante, nupemesante)
    LOOP
        BEGIN
            nulinea := -17;
            nupakgsoliproc := i.solicitud_antes;
            nuidreportedet := NULL;
            sbtiporegreporte := 'NO-NOTIFICA';
            sbnrocuenta := NULL;

            IF i.nro_cta_ps IS NOT NULL
            THEN
                sbnrocuenta := TO_CHAR (i.nro_cta_ps);
            ELSIF i.producto_cargo IS NOT NULL
            THEN
                sbnrocuenta :=
                    TO_CHAR (
                        pktblservsusc.fnugetsuscription (i.producto_cargo));
            ELSIF i.producto IS NOT NULL
            THEN
                sbnrocuenta :=
                    TO_CHAR (pktblservsusc.fnugetsuscription (i.producto));
            ELSIF i.contrato IS NOT NULL
            THEN
                sbnrocuenta := TO_CHAR (i.contrato);
            ELSE
                sbnrocuenta := '000';
            END IF;

            SELECT sqldc_detarepoatecli.NEXTVAL INTO nuidreportedet FROM DUAL;

            rcldc_detarepoatecli.package_id := i.solicitud_antes;
            rcldc_detarepoatecli.detarepoatecli_id := nuidreportedet;
            rcldc_detarepoatecli.codigo_dane := i.codigo_dane;
            rcldc_detarepoatecli.dane_dpto := i.dane_dpto;
            rcldc_detarepoatecli.dane_municipio := i.dane_municipio;
            rcldc_detarepoatecli.dane_poblacion := i.dane_poblacion;
            rcldc_detarepoatecli.radicado_ing := i.radicado_ing;
            rcldc_detarepoatecli.fecha_registro := i.fecha_registro;
            rcldc_detarepoatecli.tipo_tramite := i.tipo_tramite;
            rcldc_detarepoatecli.causal := i.causal;
            rcldc_detarepoatecli.detalle_causal := i.detalle_causal;
            rcldc_detarepoatecli.numero_identificacion := sbnrocuenta;
            rcldc_detarepoatecli.numero_factura := i.numero_factura;
            rcldc_detarepoatecli.tipo_respuesta := i.tipo_respuesta;
            rcldc_detarepoatecli.fecha_respuesta := i.fecha_respuesta;
            rcldc_detarepoatecli.radicado_res := i.radicado_res;
            rcldc_detarepoatecli.tipo_solicitud := i.tipo_solicitud;
            rcldc_detarepoatecli.estado_solicitud := i.estado_solicitud;
            rcldc_detarepoatecli.medio_recepcion := i.medio_recepcion;
            rcldc_detarepoatecli.tipo_respuesta_osf := i.tipo_respuesta_osf;
            rcldc_detarepoatecli.fecha_fin_ot_soli := i.fecha_fin_ot_soli;
            rcldc_detarepoatecli.fecha_ejec_tt_re := i.fecha_ejec_tt_re;
            rcldc_detarepoatecli.causal_lega_ot := i.causal_lega_ot;
            rcldc_detarepoatecli.tipo_unidad_oper := i.tipo_unidad_oper;
            rcldc_detarepoatecli.medio_uso := i.medio_uso;
            rcldc_detarepoatecli.codigo_homologacion :=
                NVL (i.codigo_homologacion, 0);
            rcldc_detarepoatecli.dias_registro := i.dias_registro;
            rcldc_detarepoatecli.tipo_reg_reporte := sbtiporegreporte;
            rcldc_detarepoatecli.estado_iteraccion := i.estado_iteraccion;
            rcldc_detarepoatecli.atencion_inmediata := i.atencion_inmediata;
            rcldc_detarepoatecli.carta := i.carta;
            rcldc_detarepoatecli.val_ferad_feresp := i.val_ferad_feresp;
            rcldc_detarepoatecli.val_feresp_fenot := i.val_feresp_fenot;
            rcldc_detarepoatecli.deleysiono := i.deleysiono;
            rcldc_detarepoatecli.unida_oper := i.unida_oper;
            -- 12. Fecha de notificación
            nulinea := -18;
            dtfechanotifica := NULL;
            nutiponoti := NULL;
            rcldc_detarepoatecli.fecha_notificacion := NULL;

            -- cambio alcance 75

            OPEN c_titr10343 (i.iteraccion);

            FETCH c_titr10343 INTO fechnoti;

            IF c_titr10343%NOTFOUND
            THEN
                OPEN c_titr10005 (i.iteraccion);

                FETCH c_titr10005 INTO fechnoti;

                IF c_titr10005%NOTFOUND
                THEN
                    OPEN c_titr10004 (i.iteraccion);

                    FETCH c_titr10004 INTO fechnoti;

                    IF c_titr10004%NOTFOUND
                    THEN
                        fechnoti := NULL;
                    ELSE
                        IF fechnoti IS NULL
                        THEN
                            nutiponoti := 5;
                        ELSE
                            nutiponoti := 1;
                        END IF;
                    END IF;

                    CLOSE c_titr10004;
                ELSE
                    IF fechnoti IS NULL
                    THEN
                        nutiponoti := 5;
                    ELSE
                        nutiponoti := 2;
                    END IF;
                END IF;

                CLOSE c_titr10005;
            ELSE
                IF fechnoti IS NULL
                THEN
                    nutiponoti := 5;
                ELSE
                    nutiponoti := 1;
                END IF;

                OPEN c_titr10005 (i.iteraccion);

                FETCH c_titr10005 INTO fechnoti1;

                IF c_titr10005%FOUND
                THEN
                    IF fechnoti1 IS NOT NULL
                    THEN
                        nutiponoti := 2;
                    END IF;
                END IF;

                CLOSE c_titr10005;
            END IF;

            CLOSE c_titr10343;

            IF fechnoti IS NULL
            THEN
                nutiponoti := 5;
            END IF;

            dtfechanotifica := fechnoti;

            IF dtfechanotifica IS NULL
            THEN
                rcldc_detarepoatecli.fecha_notificacion := dtfechanotifica;
            ELSE
                rcldc_detarepoatecli.fecha_notificacion :=
                    TO_CHAR (dtfechanotifica, 'DD/MM/YYYY');
            END IF;

            -- 13. Tipo de notificación
            nulinea := -19;
            rcldc_detarepoatecli.tipo_notificacion := NULL;

            IF nutiponoti IS NULL
            THEN
                rcldc_detarepoatecli.tipo_notificacion := nutiponoti;
            ELSE
                rcldc_detarepoatecli.tipo_notificacion :=
                    NVL (TO_CHAR (nutiponoti), sbtipnotconconlc);
            END IF;

            -- 14. Fecha traslado SSPD
            nulinea := -20;
            rcldc_detarepoatecli.fecha_traslado := NULL;
            dtfechtraslado := NULL;

            IF TO_NUMBER (TRIM (i.tipo_solicitud)) <>
               pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                   'TIPO_SOLICITUD_52')
            THEN
                rcldc_detarepoatecli.fecha_traslado := NULL;
            ELSE
                IF TO_NUMBER (TRIM (i.tipo_respuesta)) =
                   pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                       'TIPO_RESPUESTA_VAL')
                THEN
                    -- 943
                    pckgid := NULL;

                    BEGIN
                          SELECT package_id
                            INTO pckgid
                            FROM mo_packages
                           WHERE     cust_care_reques_num = i.solicitud_antes
                                 AND package_id <> i.solicitud_antes
                                 AND ROWNUM = 1
                        ORDER BY package_id;
                    EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                            pckgid := NULL;
                    END;

                    IF pckgid IS NOT NULL
                    THEN
                        OPEN cuordenestrasspd (pckgid);

                        FETCH cuordenestrasspd INTO dtfechtraslado;

                        CLOSE cuordenestrasspd;
                    END IF;

                    IF dtfechtraslado IS NULL
                    THEN
                        rcldc_detarepoatecli.fecha_traslado := dtfechtraslado;
                    ELSE
                        rcldc_detarepoatecli.fecha_traslado :=
                            TO_CHAR (dtfechtraslado, 'DD/MM/YYYY');
                    END IF;
                ELSE
                    rcldc_detarepoatecli.fecha_traslado := NULL;
                END IF;
            END IF;

            nulinea := 21;
            -- Validaciones
            sberrferefenot := NULL;

            IF TRIM (TO_NUMBER (i.tipo_respuesta)) <>
               pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                   'TIPO_RESPU_PEND_RESPUESTA')
            THEN
                -- Fecha respuesta VS Fecha de notificación
                IF TO_DATE (TO_CHAR (dtfechanotifica, 'dd/mm/yyyy'),
                            'dd/mm/yyyy') <
                   TO_DATE (i.fecha_respuesta, 'dd/mm/yyyy')
                THEN
                    BEGIN
                        IF i.carta = 'Y'
                        THEN                                       -- es carta
                            OPEN c_titr10343 (i.iteraccion);

                            FETCH c_titr10343 INTO fechnoti;

                            IF c_titr10343%NOTFOUND
                            THEN
                                OPEN c_titr10005 (i.iteraccion);

                                FETCH c_titr10005 INTO fechnoti;

                                IF c_titr10005%NOTFOUND
                                THEN
                                    OPEN c_titr10004 (i.iteraccion);

                                    FETCH c_titr10004 INTO fechnoti;

                                    IF c_titr10004%NOTFOUND
                                    THEN
                                        fechnoti := dtfechanotifica;
                                    END IF;

                                    CLOSE c_titr10004;
                                ELSE
                                    IF fechnoti IS NOT NULL
                                    THEN
                                        nutiponoti := 2;
                                        rcldc_detarepoatecli.tipo_notificacion :=
                                            NVL (TO_CHAR (nutiponoti),
                                                 sbtipnotconconlc);
                                    END IF;
                                END IF;

                                CLOSE c_titr10005;
                            ELSE
                                OPEN c_titr10005 (i.iteraccion);

                                FETCH c_titr10005 INTO fechnoti1;

                                IF c_titr10005%FOUND
                                THEN
                                    IF fechnoti1 IS NOT NULL
                                    THEN
                                        nutiponoti := 2;
                                        fechnoti := fechnoti1;
                                        rcldc_detarepoatecli.tipo_notificacion :=
                                            NVL (TO_CHAR (nutiponoti),
                                                 sbtipnotconconlc);
                                    END IF;
                                END IF;

                                CLOSE c_titr10005;
                            END IF;

                            CLOSE c_titr10343;

                            IF fechnoti IS NOT NULL
                            THEN
                                IF fechnoti <
                                   TO_DATE (i.fecha_respuesta, 'dd/mm/yyyy')
                                THEN
                                    sberrferefenot := 'VALIDACION-ERROR';
                                    rcldc_detarepoatecli.val_feresp_fenot :=
                                        sberrferefenot;
                                ELSE
                                    rcldc_detarepoatecli.fecha_notificacion :=
                                        TO_CHAR (fechnoti, 'dd/mm/yyyy');
                                    sberrferefenot := 'VALIDACION-CORRECTA.';
                                    rcldc_detarepoatecli.val_feresp_fenot :=
                                        sberrferefenot;
                                END IF;
                            END IF;
                        ELSE
                            sberrferefenot := 'VALIDACION-ERROR';
                            rcldc_detarepoatecli.val_feresp_fenot :=
                                sberrferefenot;
                        END IF;
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            sberrferefenot := 'VALIDACION-ERROR';
                            rcldc_detarepoatecli.val_feresp_fenot :=
                                sberrferefenot;
                    END;
                ELSE
                    sberrferefenot := 'VALIDACION-CORRECTA.';
                    rcldc_detarepoatecli.val_feresp_fenot := sberrferefenot;
                END IF;
            END IF;

            -- Nombre unidad operativa
            sbnombreunidadoper := NULL;

            BEGIN
                SELECT uo.name
                  INTO sbnombreunidadoper
                  FROM or_operating_unit uo
                 WHERE uo.operating_unit_id = rcldc_detarepoatecli.unida_oper;
            EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                    sbnombreunidadoper := NULL;
            END;

            -- Linea del registro a colocar en archivo
            sbLineaDeta :=
                   rcldc_detarepoatecli.dane_dpto
                || csbseparador
                || rcldc_detarepoatecli.dane_municipio
                || csbseparador
                || rcldc_detarepoatecli.dane_poblacion
                || csbseparador
                || rcldc_detarepoatecli.radicado_ing
                || csbseparador
                || rcldc_detarepoatecli.fecha_registro
                || csbseparador
                || rcldc_detarepoatecli.tipo_tramite
                || csbseparador
                || rcldc_detarepoatecli.causal
                || csbseparador
                || rcldc_detarepoatecli.detalle_causal
                || csbseparador
                || rcldc_detarepoatecli.numero_identificacion
                || csbseparador
                || rcldc_detarepoatecli.numero_factura
                || csbseparador
                || rcldc_detarepoatecli.tipo_respuesta
                || csbseparador
                || rcldc_detarepoatecli.fecha_respuesta
                || csbseparador
                || rcldc_detarepoatecli.radicado_res
                || csbseparador
                || rcldc_detarepoatecli.fecha_notificacion
                || csbseparador
                || NVL (rcldc_detarepoatecli.tipo_notificacion,
                        sbtipnotconconlc)
                || csbseparador
                || rcldc_detarepoatecli.fecha_traslado
                || csbseparador
                || rcldc_detarepoatecli.tipo_solicitud
                || ' - '
                || REPLACE (i.desc_tipo_solicitud, ',', NULL)
                || csbseparador
                || rcldc_detarepoatecli.estado_solicitud
                || ' - '
                || REPLACE (i.desc_estado_solicitud, ',', NULL)
                || csbseparador
                || rcldc_detarepoatecli.medio_recepcion
                || ' - '
                || REPLACE (i.desc_med_rec, ',', NULL)
                || csbseparador
                || rcldc_detarepoatecli.tipo_respuesta_osf
                || ' - '
                || REPLACE (i.desc_tipo_repuesta_osf, ',', NULL)
                || csbseparador
                || rcldc_detarepoatecli.fecha_fin_ot_soli
                || csbseparador
                || rcldc_detarepoatecli.fecha_ejec_tt_re
                || csbseparador
                || rcldc_detarepoatecli.causal_lega_ot
                || ' - '
                || REPLACE (i.desc_causal_legalizacion, ',', NULL)
                || csbseparador
                || rcldc_detarepoatecli.tipo_unidad_oper
                || ' - '
                || REPLACE (i.desc_tipo_unidad_oper, ',', NULL)
                || csbseparador
                || rcldc_detarepoatecli.medio_uso
                || csbseparador
                || rcldc_detarepoatecli.codigo_homologacion
                || csbseparador
                || rcldc_detarepoatecli.dias_registro
                || csbseparador
                || rcldc_detarepoatecli.tipo_reg_reporte
                || csbSeparador
                || rcldc_detarepoatecli.estado_iteraccion
                || ' - '
                || REPLACE (i.desc_estado_iteraccion, ',', NULL)
                || csbSeparador
                || rcldc_detarepoatecli.package_id
                || csbSeparador
                || rcldc_detarepoatecli.atencion_inmediata
                || csbSeparador
                || rcldc_detarepoatecli.carta
                || csbSeparador
                || rcldc_detarepoatecli.val_ferad_feresp
                || csbSeparador
                || rcldc_detarepoatecli.val_feresp_fenot
                || csbSeparador
                || rcldc_detarepoatecli.deleysiono
                || csbSeparador
                || rcldc_detarepoatecli.unida_oper
                || ' - '
                || sbnombreunidadoper;

            nucantiregcom := nucantiregcom + 1;

            IF nucantiregcom >= nucontareg
            THEN
                COMMIT;
                nucantiregtot := nucantiregtot + nucantiregcom;
                nucantiregcom := 0;
            END IF;

            -- Se imprime la linea en el archivo
            nulinea := -22;
            ldc_paqueteanexoa.impresion (vfile, sblineadeta);
            -- Creamos registro en la tabla
            nulinea := -23;
            ldc_paqueteanexoa.creadetallereporte (rcldc_detarepoatecli);

            ldc_paqueteanexoa.creadetallereporte (rcldc_detarepoatecli);
        EXCEPTION
            -- manejo de errores
            WHEN OTHERS
            THEN
                numeroerrores := numeroerrores + 1;
                sberror := SQLERRM;
                sberror := SUBSTR (sberror, 1, 200);
                ldcinsldclogerrorrsui (
                       'Error. Cursor:'
                    || sbcursor
                    || ' Solicitud:'
                    || nupakgsoliproc
                    || ' Linea:'
                    || TO_CHAR (nulinea)
                    || ' Error: '
                    || sberror);
        END;
    END LOOP;

    IF nucantiregcom <= 99
    THEN
        COMMIT;
        nucantiregtot := nucantiregtot + nucantiregcom;
        nucantiregcom := 0;
    END IF;

    nulinea := 24;
    sberror :=
           'Fecha inicio : '
        || TO_CHAR (dtfechini)
        || ' Fecha fin : '
        || TO_CHAR (dtfecfin);
    nutiposolicrere :=
        pkg_BCLD_Parameter.fnuObtieneValorNumerico ('TIPO_SOLICITUD_50');
    nutiposolicrers :=
        pkg_BCLD_Parameter.fnuObtieneValorNumerico ('TIPO_SOLICITUD_52');
    nutiposoliquej :=
        pkg_BCLD_Parameter.fnuObtieneValorNumerico ('TIPO_SOLICITUD_100030');
    nutipsolirecl :=
        pkg_BCLD_Parameter.fnuObtieneValorNumerico ('TIPO_SOLICITUD_545');

    FOR ts IN cutipossolicitudes
    LOOP
        sbcursor :=
            'cusolicitudes con  tipo solicitud =' || TO_CHAR (ts.tspadr);

        FOR i IN cusolicitudes (dtfechini,
                                dtfecfin,
                                nupeanoante,
                                nupemesante,
                                ts.tspadr)
        LOOP
            -- control de errores
            BEGIN                                               -- 200-2392 HT
                swcontr := 0;
                sbgrupcaus := NULL;
                sbcaussspd := NULL;

                IF i.tipo_solicitud IN (nutiposolicrere, nutiposolicrers)
                THEN
                    swcontr := 0;

                    FOR l
                        IN cusolictasorecursos (i.solicitud,
                                                nutiposoliquej,
                                                nutipsolirecl)
                    LOOP
                        sbgrupcaus := TO_CHAR (l.gcre);
                        sbcaussspd := TO_CHAR (l.csre);
                        swcontr := 1;
                    END LOOP;

                    IF swcontr = 1
                    THEN
                        nureporta := 'Y';
                    ELSE
                        nureporta := 'N';
                    END IF;
                ELSE
                    nureporta := 'Y';
                END IF;

                IF nureporta = 'Y'
                THEN
                    nulinea := 25;
                    sbflagotprocinterno :=
                        pkg_BCLD_Parameter.fsbObtieneValorCadena (
                            'APLICA_PROC_INTERNO');
                    numediorecepotinterna :=
                        pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                            'COD_TIPO_MEDIO_RECEP');
                    nudiasregistro := 0;
                    -- Validamos si las solicitudes anuladas o en anulacion, tienen asociada un tipo de solicitud 9 para que no hagan parte del reporte*/
                    nulinea := 26;
                    nuvalidasoli := 0;
                    nulinea := 27;

                    BEGIN
                        SELECT cr.*
                          INTO rgconfireporte
                          FROM ldc_sui_confirepsuia cr
                         WHERE cr.codigo = i.registro;
                    EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                            nuvalidasoli := -1;
                    END;

                    nulinea := 28;
                    nuidreportedet := NULL;

                    SELECT sqldc_detarepoatecli.NEXTVAL
                      INTO nuidreportedet
                      FROM DUAL;

                    nucodresposf := NULL;
                    desc_tipo_repuesta_osf := NULL;

                    BEGIN
                        SELECT tr.codigo_resp_osf, tr.descripcion
                          INTO nucodresposf, desc_tipo_repuesta_osf
                          FROM ldc_sui_tipres tr
                         WHERE tr.codigo = rgconfireporte.codigo_rpta;
                    EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                            nucodresposf := -1;
                            desc_tipo_repuesta_osf := '---------';
                    END;

                    nulinea := 29;
                    sbtiporegreporte := 'MES-REPORTE';
                    rcldc_detarepoatecli.detarepoatecli_id := nuidreportedet;
                    rcldc_detarepoatecli.tipo_solicitud := i.tipo_solicitud;
                    rcldc_detarepoatecli.estado_solicitud :=
                        i.estado_solicitud;
                    rcldc_detarepoatecli.medio_recepcion := i.medio_rece_cod;
                    rcldc_detarepoatecli.tipo_respuesta_osf := nucodresposf;
                    rcldc_detarepoatecli.medio_uso := 'Externa';
                    rcldc_detarepoatecli.flag_reporta := 'S';
                    rcldc_detarepoatecli.package_id := i.solicitud;
                    rcldc_detarepoatecli.codigo_homologacion :=
                        rgconfireporte.codigo;
                    rcldc_detarepoatecli.tipo_reg_reporte := sbtiporegreporte;
                    rcldc_detarepoatecli.estado_iteraccion :=
                        i.estado_iteracion;
                    rcldc_detarepoatecli.iteraccion := i.itera;
                    rcldc_detarepoatecli.atencion_inmediata :=
                        i.atencion_inmediata;
                    rcldc_detarepoatecli.carta := i.medio_recepcion;

                    IF nuvalidasoli = -1
                    THEN
                        rcldc_detarepoatecli.flag_reporta := 'N';
                        rcldc_detarepoatecli.codigo_homologacion := 0;
                    END IF;

                    -- Solicitudes para el reporte
                    nulinea := 30;
                    nupakgsoliproc := i.solicitud;
                    nuestsolanulada :=
                        pkg_BCLD_Parameter.fsbObtieneValorCadena (
                            'ESTADO_SOLICITUD_ANULADA');
                    nuestsolenanula :=
                        pkg_BCLD_Parameter.fsbObtieneValorCadena (
                            'ESTADO_SOLICITUD_EN_ANULACION');
                    -- 1. Obtenemos la información del codigo dane
                    nulinea := 31;
                    nulocaddan := NULL;

                    IF i.loca_dane_ps IS NOT NULL
                    THEN
                        nulocaddan := i.loca_dane_ps;
                    ELSIF i.producto_cargo IS NOT NULL
                    THEN
                        nulocaddan :=
                            pr_bosuspendcriterions.fnugetproductlocality (
                                i.producto_cargo);
                    ELSIF i.producto IS NOT NULL
                    THEN
                        nulocaddan :=
                            pr_bosuspendcriterions.fnugetproductlocality (
                                i.producto);
                    ELSIF i.contrato IS NOT NULL
                    THEN
                        nulocaddan := ldc_fncretornalocacontrato (i.contrato);
                    ELSE
                        nulocaddan := ldc_fncretornalocacliente (i.cliente);
                    END IF;

                    IF daldc_equiva_localidad.fblexist (nulocaddan)
                    THEN
                        rcldc_equiva_localidad :=
                            daldc_equiva_localidad.frcgetrecord (nulocaddan);
                        blexiste := TRUE;
                    END IF;

                    --Si encontro el codigo dane en la instruccion anterior entonces se muestra sino ERROR
                    nulinea := 32;

                    IF blExiste
                    THEN
                        sbcoddane :=
                               rcldc_equiva_localidad.departamento
                            || rcldc_equiva_localidad.municipio
                            || rcldc_equiva_localidad.poblacion;
                    ELSE
                        sbcoddane := 'ERROR';
                    END IF;

                    rcldc_detarepoatecli.codigo_dane := NULL;
                    rcldc_detarepoatecli.dane_dpto := NULL;
                    rcldc_detarepoatecli.dane_municipio := NULL;
                    rcldc_detarepoatecli.dane_poblacion := NULL;
                    rcldc_detarepoatecli.codigo_dane := sbcoddane;
                    rcldc_detarepoatecli.dane_dpto :=
                        rcldc_equiva_localidad.departamento;
                    rcldc_detarepoatecli.dane_municipio :=
                        rcldc_equiva_localidad.municipio;
                    rcldc_detarepoatecli.dane_poblacion :=
                        rcldc_equiva_localidad.poblacion;
                    nres := 0;
                    -- 2.Radicado recibido
                    nulinea := 33;
                    rcldc_detarepoatecli.radicado_ing := NULL;
                    sbradicado := NULL;
                    dtfechrad := NULL;

                    IF pkg_BCLD_Parameter.fsbObtieneValorCadena (
                           'APLICA_ITEACCION') =
                       'N'
                    THEN
                        SELECT COUNT (p.package_id)
                          INTO nres
                          FROM mo_packages p
                         WHERE     p.cust_care_reques_num = i.itera
                               AND p.package_id <> i.itera
                               AND p.package_type_id IN
                                       (SELECT tnx.tipo_solicitud
                                          FROM ldc_sui_tipsol tnx);

                        IF nres > 1
                        THEN
                            sbradicado := i.itera;
                            dtfechrad :=
                                TO_DATE (
                                    TO_CHAR (i.fech_sol_itera, 'dd-mm-yyyy'),
                                    'dd-mm-yyyy');
                        ELSE
                            sbradicado := i.solicitud;
                            dtfechrad :=
                                TO_DATE (
                                    TO_CHAR (i.fecha_recibido_solicitud,
                                             'dd-mm-yyyy'),
                                    'dd-mm-yyyy');
                        END IF;
                    ELSE
                        sbradicado := i.itera;
                        dtfechrad :=
                            TO_DATE (
                                TO_CHAR (i.fech_sol_itera, 'dd-mm-yyyy'),
                                'dd-mm-yyyy');
                    END IF;

                    rcldc_detarepoatecli.radicado_ing := TO_CHAR (sbradicado);
                    -- 3. Fecha de radicación
                    nulinea := 34;
                    rcldc_detarepoatecli.fecha_registro := NULL;

                    IF dtfechrad IS NULL
                    THEN
                        rcldc_detarepoatecli.fecha_registro := dtfechrad;
                    ELSE
                        rcldc_detarepoatecli.fecha_registro :=
                            TO_CHAR (dtfechrad, 'dd-mm-yyyy');
                    END IF;

                    -- 4. Tipo de tramite
                    nulinea := 35;
                    sbtitra := NULL;
                    rcldc_detarepoatecli.tipo_tramite := sbtitra;
                    sbtitra := TO_CHAR (i.tipo_tramite);
                    rcldc_detarepoatecli.tipo_tramite := sbtitra;
                    -- 5. Causal que es el grupo de causal
                    nulinea := 36;
                    rcldc_detarepoatecli.causal := NULL;

                    IF swcontr = 0
                    THEN
                        sbgrupcaus := i.grupo_causal;
                    END IF;

                    rcldc_detarepoatecli.causal := sbgrupcaus;
                    -- 6. Detalle de causal SSPD
                    nulinea := 37;
                    rcldc_detarepoatecli.detalle_causal := NULL;

                    IF swcontr = 0
                    THEN
                        nucaussspd := i.causal_sspd;
                        sbcaussspd := TO_CHAR (nucaussspd);
                    END IF;

                    rcldc_detarepoatecli.detalle_causal :=
                        TO_CHAR (sbcaussspd);
                    -- 7. Nro de cuenta
                    nulinea := 38;
                    sbnrocuenta := NULL;
                    rcldc_detarepoatecli.numero_identificacion := NULL;

                    IF i.nro_cta_ps IS NOT NULL
                    THEN
                        sbnrocuenta := TO_CHAR (i.nro_cta_ps);
                    ELSIF i.producto_cargo IS NOT NULL
                    THEN
                        sbnrocuenta :=
                            TO_CHAR (
                                pktblservsusc.fnugetsuscription (
                                    i.producto_cargo));
                    ELSIF i.producto IS NOT NULL
                    THEN
                        sbnrocuenta :=
                            TO_CHAR (
                                pktblservsusc.fnugetsuscription (i.producto));
                    ELSIF i.contrato IS NOT NULL
                    THEN
                        sbnrocuenta := TO_CHAR (i.contrato);
                    ELSE
                        sbnrocuenta := '000';
                    END IF;

                    rcldc_detarepoatecli.numero_identificacion := sbnrocuenta;
                    -- 8. Numero de factura
                    nulinea := 39;
                    sbnrofactura := NULL;
                    rcldc_detarepoatecli.numero_factura := NULL;

                    IF i.contrato IS NULL
                    THEN
                        sbnrofactura := 'N';
                    ELSE
                        sbnrofactura :=
                            NVL (
                                cc_boclaiminstancedata.fnugetclaimedbill (
                                    i.solicitud),
                                cc_boclaiminstancedata_pna.fnugetclaimedbill (
                                    i.solicitud));

                        IF sbnrofactura IS NULL
                        THEN
                            sbnrofactura := 'N';
                        END IF;
                    END IF;

                    rcldc_detarepoatecli.numero_factura :=
                        NVL (sbnrofactura, 'N');
                    -- 9. Tipo de respuesta
                    nulinea := 40;
                    sbtiporespu := NULL;
                    rcldc_detarepoatecli.tipo_respuesta := sbtiporespu;
                    sbtiporespu := TO_CHAR (rgconfireporte.codigo_rpta);
                    rcldc_detarepoatecli.tipo_respuesta :=
                        TO_CHAR (NVL (sbtiporespu, 'N'));
                    -- 10.Fecha de respuesta al usuario
                    nulinea := 41;
                    dtfecharespu := NULL;
                    rcldc_detarepoatecli.fecha_respuesta := dtfecharespu;
                    dtrespuanula := NULL;
                    rcldc_detarepoatecli.fecha_fin_ot_soli := NULL;
                    rcldc_detarepoatecli.fecha_ejec_tt_re := NULL;
                    rcldc_detarepoatecli.causal_lega_ot := NULL;
                    rcldc_detarepoatecli.tipo_unidad_oper := NULL;
                    nudiasregistro := NULL;
                    dtfechanotifica := NULL;
                    rcldc_detarepoatecli.fecha_notificacion := NULL;
                    nutiponoti := NULL;
                    sbtiponotifica := NULL;
                    rcldc_detarepoatecli.tipo_notificacion := NULL;
                    nuanula := 0;
                    nulinea := 42;

                    -- 10.1 Si la solicitud esta anulada o en anuacion, la fecha de respuesta es la de la fecha de recibido de la solicitud asociada a la solicitud de anulacion
                    IF i.estado_solicitud IN
                           (pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                'ESTADO_SOLICITUD_ANULADA'),
                            pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                'ESTADO_SOLICITUD_EN_ANULACION'))
                    THEN
                        nuanula := 1;

                        OPEN cusoliasoci (i.solicitud);

                        FETCH cusoliasoci INTO dtrespuanula;

                        CLOSE cusoliasoci;

                        IF dtrespuanula IS NULL
                        THEN
                            dtfecharespu := dtrespuanula;
                            dtfechanotifica := dtrespuanula;
                            nutiponoti := NULL;
                            sbtiponotifica := NULL;
                        ELSE
                            dtfecharespu :=
                                TO_CHAR (dtrespuanula, 'DD/MM/YYYY');
                            dtfechanotifica := dtrespuanula;
                            nutiponoti :=
                                pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                    'TIPO_NOTI_PERSONAL');
                            sbtiponotifica := TO_CHAR (nutiponoti);
                        END IF;

                        rcldc_detarepoatecli.fecha_respuesta := dtfecharespu;
                        rcldc_detarepoatecli.fecha_notificacion :=
                            TO_CHAR (dtfechanotifica, 'DD/MM/YYYY');
                        rcldc_detarepoatecli.tipo_notificacion :=
                            NVL (sbtiponotifica, sbtipnotconconlc);

                        IF rgconfireporte.medio_recepcion = 'Y'
                        THEN
                            rcldc_detarepoatecli.fecha_ejec_tt_re :=
                                dtfecharespu;
                        ELSE
                            rcldc_detarepoatecli.fecha_fin_ot_soli :=
                                dtfecharespu;
                        END IF;
                    -- 10.2 Fecha respuesta a los pendiente de respuesta
                    ELSIF    rcldc_detarepoatecli.tipo_respuesta = 'N'
                          OR rcldc_detarepoatecli.tipo_respuesta =
                             TO_CHAR (
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                     'TIPO_RESPU_PEND_RESPUESTA'))
                    THEN
                        dtfecharespu := NULL;
                        rcldc_detarepoatecli.fecha_respuesta := dtfecharespu;
                    -- 10.3 Fecha respuesta a los NO-CARTAS de atencion NO-INMEDIATA
                    ELSIF     rgconfireporte.medio_recepcion = 'N'
                          AND rgconfireporte.flag_ate_inme = 'N'
                    THEN
                        nuunidadoperativa := NULL;

                        OPEN cuordenessol (i.solicitud);

                        FETCH cuordenessol INTO rccuordenessol;

                        CLOSE cuordenessol;

                        IF rccuordenessol.execution_final_date IS NULL
                        THEN
                            dtfecharespu :=
                                rccuordenessol.execution_final_date;
                            dtfechanotifica := dtfecharespu;
                            nutiponoti := NULL;
                            sbtiponotifica := NULL;
                        ELSE
                            dtfecharespu :=
                                TO_CHAR (rccuordenessol.execution_final_date,
                                         'DD/MM/YYYY');
                            dtfechanotifica :=
                                rccuordenessol.execution_final_date;
                            nutiponoti :=
                                pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                    'TIPO_NOTI_PERSONAL');
                            sbtiponotifica := TO_CHAR (nutiponoti);
                        END IF;

                        rcldc_detarepoatecli.fecha_notificacion :=
                            TO_CHAR (dtfechanotifica, 'DD/MM/YYYY');
                        rcldc_detarepoatecli.tipo_notificacion :=
                            NVL (sbtiponotifica, sbtipnotconconlc);
                        rcldc_detarepoatecli.fecha_respuesta := dtfecharespu;
                        rcldc_detarepoatecli.fecha_fin_ot_soli :=
                            rccuordenessol.execution_final_date;
                        rcldc_detarepoatecli.causal_lega_ot :=
                            rccuordenessol.causal_lega_sol;
                        rcldc_detarepoatecli.tipo_unidad_oper :=
                            rccuordenessol.tipo_unidad;
                        nuunidadoperativa := rccuordenessol.unidad_operativa;

                        SELECT COUNT (1)
                          INTO nudiasregistro
                          FROM ge_calendar ca
                         WHERE     ca.date_ BETWEEN rccuordenessol.execution_final_date
                                                AND dtfechahoy
                               AND ca.day_type_id = 1
                               AND ca.country_id =
                                   pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                       'CODIGO_PAIS');
                    -- 10.4 Fecha respuesta a las no-cartas de atencion-inmediata
                    ELSIF     rgconfireporte.medio_recepcion = 'N'
                          AND rgconfireporte.flag_ate_inme = 'Y'
                    THEN
                        IF i.fecha_atencion_solicitud IS NULL
                        THEN
                            dtfecharespu := i.fecha_atencion_solicitud;
                            dtfechanotifica := dtfecharespu;
                            nutiponoti := NULL;
                            sbtiponotifica := NULL;
                        ELSE
                            dtfecharespu :=
                                TO_CHAR (i.fecha_atencion_solicitud,
                                         'DD/MM/YYYY');
                            dtfechanotifica := i.fecha_atencion_solicitud;
                            nutiponoti :=
                                pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                    'TIPO_NOTI_PERSONAL');
                            sbtiponotifica := TO_CHAR (nutiponoti);
                        END IF;

                        rcldc_detarepoatecli.fecha_notificacion :=
                            TO_CHAR (dtfechanotifica, 'DD/MM/YYYY');
                        rcldc_detarepoatecli.tipo_notificacion :=
                            NVL (sbtiponotifica, sbtipnotconconlc);
                        rcldc_detarepoatecli.fecha_respuesta := dtfecharespu;
                        rcldc_detarepoatecli.fecha_fin_ot_soli :=
                            dtfecharespu;
                        rcldc_detarepoatecli.tipo_respuesta :=
                            pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                'TIPO_RESPU_NO_ACCEDE_ANEXOA');
                        nulinea := 43;
                    -- 10.5 Si la solicitud es escrita, no-inmediata,es atendida, iteraccion registrada y ot de documentacion abierta
                    ELSIF     rgconfireporte.medio_recepcion = 'Y'
                          AND rgconfireporte.flag_ate_inme IN ('Y', 'N')
                          AND rgconfireporte.estado_solicitud = 14
                          AND rgconfireporte.estado_iteraccion = 13
                          AND i.ot_document IN (1, 2)
                    THEN
                        dtfecharespu := NULL;
                        rcldc_detarepoatecli.tipo_respuesta :=
                            pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                'TIPO_RESPU_PEND_RESPUESTA');
                        rcldc_detarepoatecli.fecha_respuesta := dtfecharespu;
                        rcldc_detarepoatecli.fecha_ejec_tt_re := dtfecharespu;
                    -- 10.6 Si la solicitud es escrita, no-inmediata,es atendida, iteraccion registrada o atendida y ot de documentacion cerrada
                    ELSIF     rgconfireporte.medio_recepcion = 'Y'
                          AND rgconfireporte.flag_ate_inme IN ('Y', 'N')
                          AND rgconfireporte.estado_solicitud = 14
                          AND rgconfireporte.estado_iteraccion IN (13, 14)
                          AND i.ot_document = 3
                    THEN
                        nuunidadoperativa := NULL;

                        OPEN cuordenesresp (i.itera);

                        FETCH cuordenesresp INTO rccuordenesresp;

                        CLOSE cuordenesresp;

                        -- inicio caso 75
                        IF rccuordenesresp.execution_final_date IS NULL
                        THEN
                            dtfecharespu :=
                                rccuordenesresp.execution_final_date;
                        ELSE
                            dtfecharespu :=
                                TO_CHAR (
                                    rccuordenesresp.execution_final_date,
                                    'DD/MM/YYYY');
                        END IF;

                        rcldc_detarepoatecli.fecha_respuesta := dtfecharespu;
                        rcldc_detarepoatecli.fecha_ejec_tt_re :=
                            rccuordenesresp.execution_final_date;
                        rcldc_detarepoatecli.causal_lega_ot :=
                            rccuordenesresp.causal_lega_resp;
                        rcldc_detarepoatecli.tipo_unidad_oper :=
                            rccuordenesresp.tipo_unidad;
                        nuunidadoperativa := rccuordenesresp.unidad_operativa;

                        rcldc_detarepoatecli.fecha_respuesta := dtfecharespu;
                        rcldc_detarepoatecli.fecha_ejec_tt_re :=
                            rccuordenesresp.execution_final_date;
                        rcldc_detarepoatecli.causal_lega_ot :=
                            rccuordenesresp.causal_lega_resp;
                        rcldc_detarepoatecli.tipo_unidad_oper :=
                            rccuordenesresp.tipo_unidad;
                        nuunidadoperativa := rccuordenesresp.unidad_operativa;

                        SELECT COUNT (1)
                          INTO nudiasregistro
                          FROM ge_calendar ca
                         WHERE     ca.date_ BETWEEN rccuordenesresp.execution_final_date
                                                AND dtfechahoy
                               AND ca.day_type_id = 1
                               AND ca.country_id =
                                   pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                       'CODIGO_PAIS');
                    -- TICKET 200-2392 JJMM -- 10.7 Si la solicitud  no es escrita, no-inmediata,es atendida, iteraccion registrada y ot de documentacion abierta
                    ELSIF     rgconfireporte.medio_recepcion <> 'Y'
                          AND rgconfireporte.flag_ate_inme IN ('Y', 'N')
                          AND rgconfireporte.estado_solicitud = 14
                          AND rgconfireporte.estado_iteraccion = 13
                          AND i.ot_document IN (1, 2)
                    THEN
                        dtfecharespu := NULL;
                        rcldc_detarepoatecli.tipo_respuesta :=
                            pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                'TIPO_RESPU_PEND_RESPUESTA');
                        rcldc_detarepoatecli.fecha_respuesta := dtfecharespu;
                        rcldc_detarepoatecli.fecha_ejec_tt_re := dtfecharespu;
                    -- TICKET 200-2392 JJMM -- 10.8 Si la solicitud no es escrita, no-inmediata,es atendida, iteraccion registrada o atendida y ot de documentacion cerrada
                    ELSIF     rgconfireporte.medio_recepcion <> 'Y'
                          AND rgconfireporte.flag_ate_inme IN ('Y', 'N')
                          AND rgconfireporte.estado_solicitud = 14
                          AND rgconfireporte.estado_iteraccion IN (13, 14)
                          AND i.ot_document = 3
                    THEN
                        nuunidadoperativa := NULL;

                        OPEN cuordenesresp (i.itera);

                        FETCH cuordenesresp INTO rccuordenesresp;

                        CLOSE cuordenesresp;

                        IF rccuordenesresp.execution_final_date IS NULL
                        THEN
                            dtfecharespu :=
                                rccuordenesresp.execution_final_date;
                        ELSE
                            dtfecharespu :=
                                TO_CHAR (
                                    rccuordenesresp.execution_final_date,
                                    'DD/MM/YYYY');
                        END IF;

                        rcldc_detarepoatecli.fecha_respuesta := dtfecharespu;
                        rcldc_detarepoatecli.fecha_ejec_tt_re :=
                            rccuordenesresp.execution_final_date;
                        rcldc_detarepoatecli.causal_lega_ot :=
                            rccuordenesresp.causal_lega_resp;
                        rcldc_detarepoatecli.tipo_unidad_oper :=
                            rccuordenesresp.tipo_unidad;
                        nuunidadoperativa := rccuordenesresp.unidad_operativa;

                        SELECT COUNT (1)
                          INTO nudiasregistro
                          FROM ge_calendar ca
                         WHERE     ca.date_ BETWEEN rccuordenesresp.execution_final_date
                                                AND dtfechahoy
                               AND ca.day_type_id = 1
                               AND ca.country_id =
                                   pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                       'CODIGO_PAIS');
                    END IF;

                    nulinea := 44;
                    -- 11. Radicado de respuesta
                    nulinea := 45;
                    sbradrespuesta := NULL;
                    rcldc_detarepoatecli.radicado_res := NULL;

                    IF    rcldc_detarepoatecli.tipo_respuesta = 'N'
                       OR rcldc_detarepoatecli.tipo_respuesta =
                          pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                              'TIPO_RESPU_PEND_RESPUESTA')
                    THEN
                        sbradrespuesta := NULL;
                    ELSE
                        sbradrespuesta := i.itera;
                    END IF;

                    rcldc_detarepoatecli.radicado_res := sbradrespuesta;
                    -- 12. Fecha de notificación
                    nulinea := 46;

                    IF    rcldc_detarepoatecli.tipo_respuesta = 'N'
                       OR rcldc_detarepoatecli.tipo_respuesta IN
                              (pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                   'TIPO_RESPU_PEND_RESPUESTA'),
                               pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                   'TIPO_RESPU_SIN_RESPUESTA'),
                               pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                   'TIPO_RESPUESTA_ARCHIVA'))
                    THEN
                        rcldc_detarepoatecli.fecha_notificacion := NULL;
                    ELSIF     rgconfireporte.medio_recepcion = 'Y'
                          AND nuanula = 0
                    THEN
                        IF (c_titr10343%ISOPEN)
                        THEN
                            CLOSE c_titr10343;
                        END IF;

                        OPEN c_titr10343 (i.itera);

                        FETCH c_titr10343 INTO fechnoti;

                        IF c_titr10343%NOTFOUND
                        THEN
                            IF (c_titr10005%ISOPEN)
                            THEN
                                CLOSE c_titr10005;
                            END IF;

                            OPEN c_titr10005 (i.itera);

                            FETCH c_titr10005 INTO fechnoti;

                            IF c_titr10005%NOTFOUND
                            THEN
                                IF (c_titr10004%ISOPEN)
                                THEN
                                    CLOSE c_titr10004;
                                END IF;

                                OPEN c_titr10004 (i.itera);

                                FETCH c_titr10004 INTO fechnoti;

                                IF c_titr10004%NOTFOUND
                                THEN
                                    fechnoti := NULL;
                                    NUTIPONOTI := 5;
                                ELSE
                                    IF FECHNOTI IS NOT NULL
                                    THEN
                                        NUTIPONOTI := 1;
                                    ELSE
                                        NUTIPONOTI := 5;
                                    END IF;
                                END IF;

                                CLOSE c_titr10004;
                            ELSE
                                IF FECHNOTI IS NOT NULL
                                THEN
                                    NUTIPONOTI := 2;
                                ELSE
                                    NUTIPONOTI := 5;
                                END IF;
                            END IF;

                            CLOSE c_titr10005;
                        ELSE
                            IF fechnoti IS NULL
                            THEN
                                nutiponoti := 5;
                            ELSE
                                nutiponoti := 1;
                            END IF;

                            IF (c_titr10005%ISOPEN)
                            THEN
                                CLOSE c_titr10005;
                            END IF;

                            OPEN c_titr10005 (i.itera);

                            FETCH c_titr10005 INTO fechnoti1;

                            IF c_titr10005%FOUND
                            THEN
                                IF fechnoti1 IS NOT NULL
                                THEN
                                    nutiponoti := 2;
                                    fechnoti := fechnoti1;
                                END IF;
                            END IF;

                            CLOSE c_titr10005;
                        END IF;

                        CLOSE c_titr10343;

                        dtfechanotifica := fechnoti;

                        IF dtfechanotifica IS NULL
                        THEN
                            rcldc_detarepoatecli.fecha_notificacion :=
                                dtfechanotifica;
                        ELSE
                            rcldc_detarepoatecli.fecha_notificacion :=
                                TO_CHAR (dtfechanotifica, 'DD/MM/YYYY');
                        END IF;
                    END IF;

                    -- 13. Tipo de notificación
                    nulinea := 47;

                    IF    rcldc_detarepoatecli.tipo_respuesta = 'N'
                       OR rcldc_detarepoatecli.tipo_respuesta =
                          pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                              'TIPO_RESPU_PEND_RESPUESTA')
                    THEN
                        sbtiponotifica :=
                            TO_CHAR (
                                pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                    'TIPO_NOTIFI_CON_CONCLU'));
                        rcldc_detarepoatecli.tipo_notificacion :=
                            NVL (sbtiponotifica, sbtipnotconconlc);
                    ELSIF rcldc_detarepoatecli.tipo_respuesta IN
                              (pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                   'TIPO_RESPU_SIN_RESPUESTA'),
                               pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                   'TIPO_RESPUESTA_ARCHIVA'))
                    THEN
                        sbtiponotifica :=
                            TO_CHAR (
                                pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                    'TIPO_NOTIFICACION_NO_REQ_NOTI'));
                        rcldc_detarepoatecli.tipo_notificacion :=
                            NVL (sbtiponotifica, sbtipnotconconlc);
                    ELSIF     rgconfireporte.medio_recepcion = 'Y'
                          AND nuanula = 0
                    THEN
                        sbtiponotifica := TO_CHAR (nutiponoti);

                        IF sbtiponotifica IS NULL
                        THEN
                            rcldc_detarepoatecli.tipo_notificacion := NULL;
                        ELSE
                            rcldc_detarepoatecli.tipo_notificacion :=
                                NVL (sbtiponotifica, sbtipnotconconlc);
                        END IF;
                    END IF;

                    -- 14. Fecha traslado SSPD
                    nulinea := 48;
                    dtfechtraslado := NULL;
                    rcldc_detarepoatecli.fecha_traslado := NULL;

                    IF i.tipo_solicitud <>
                       pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                           'TIPO_SOLICITUD_52')
                    THEN
                        rcldc_detarepoatecli.fecha_traslado := NULL;
                    ELSE
                        IF rgconfireporte.codigo_rpta =
                           pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                               'TIPO_RESPUESTA_VAL')
                        THEN
                            OPEN cuordenestrasspd (i.solicitud);

                            FETCH cuordenestrasspd INTO dtfechtraslado;

                            CLOSE cuordenestrasspd;

                            IF dtfechtraslado IS NULL
                            THEN
                                rcldc_detarepoatecli.fecha_traslado :=
                                    dtfechtraslado;
                            ELSE
                                rcldc_detarepoatecli.fecha_traslado :=
                                    TO_CHAR (dtfechtraslado, 'DD/MM/YYYY');
                            END IF;
                        ELSE
                            rcldc_detarepoatecli.fecha_traslado := NULL;
                        END IF;
                    END IF;

                    -- Descripción causal de legalización
                    nulinea := 49;
                    sbdesccausal := NULL;

                    BEGIN
                        SELECT cll.description
                          INTO sbdesccausal
                          FROM ge_causal cll
                         WHERE cll.causal_id =
                               rcldc_detarepoatecli.causal_lega_ot;
                    EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                            sbdesccausal := NULL;
                    END;

                    -- Descripción tipo unidad operativa
                    nulinea := 50;
                    sbdesctipounit := NULL;

                    BEGIN
                        SELECT gt.descripcion
                          INTO sbdesctipounit
                          FROM ge_tipo_unidad gt
                         WHERE gt.id_tipo_unidad =
                               rcldc_detarepoatecli.tipo_unidad_oper;
                    EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                            sbdesctipounit := NULL;
                    END;

                    rcldc_detarepoatecli.dias_registro := NULL;
                    rcldc_detarepoatecli.dias_registro := nudiasregistro;
                    rcldc_detarepoatecli.unida_oper := nuunidadoperativa;

                    -- Nombre unidad operativa
                    BEGIN
                        SELECT uo.name
                          INTO sbnombreunidadoper
                          FROM or_operating_unit uo
                         WHERE uo.operating_unit_id = nuunidadoperativa;
                    EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                            sbnombreunidadoper := NULL;
                    END;

                    -- Validaciones
                    sberrfereferad := NULL;
                    sberrferefenot := NULL;
                    sbdeley := NULL;
                    rcldc_detarepoatecli.val_ferad_feresp := sberrfereferad;
                    rcldc_detarepoatecli.val_feresp_fenot := sberrferefenot;
                    rcldc_detarepoatecli.deleysiono := sbdeley;

                    IF TRIM (TO_NUMBER (sbtiporespu)) <>
                       pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                           'TIPO_RESPU_PEND_RESPUESTA')
                    THEN
                        -- Fecha de radicado VS Fecha respuesta
                        IF     TO_DATE (dtfecharespu, 'dd/mm/yyyy') <
                               TO_DATE (TO_CHAR (dtfechrad, 'dd/mm/yyyy'),
                                        'dd/mm/yyyy')
                           AND dtfecharespu IS NOT NULL
                           AND dtfechrad IS NOT NULL
                        THEN
                            sberrfereferad := 'VALIDACION-ERROR';
                            rcldc_detarepoatecli.val_ferad_feresp :=
                                sberrfereferad;
                        ELSE
                            sberrfereferad := 'VALIDACION-CORRECTA.';
                            rcldc_detarepoatecli.val_ferad_feresp :=
                                sberrfereferad;
                        END IF;

                        -- Fecha respuesta VS Fecha de notificación
                        IF     TO_DATE (
                                   TO_CHAR (dtfechanotifica, 'dd/mm/yyyy'),
                                   'dd/mm/yyyy') <
                               TO_DATE (dtfecharespu, 'dd/mm/yyyy')
                           AND dtfecharespu IS NOT NULL
                           AND dtfechanotifica IS NOT NULL
                        THEN
                            BEGIN
                                IF i.medio_recepcion = 'Y'
                                THEN                               -- es carta
                                    IF (c_titr10005%ISOPEN)
                                    THEN
                                        CLOSE c_titr10005;
                                    END IF;

                                    OPEN c_titr10005 (i.itera);

                                    FETCH c_titr10005 INTO fechnoti;

                                    IF c_titr10005%NOTFOUND
                                    THEN
                                        IF (c_titr10004%ISOPEN)
                                        THEN
                                            CLOSE c_titr10004;
                                        END IF;

                                        OPEN c_titr10004 (i.itera);

                                        FETCH c_titr10004 INTO fechnoti;

                                        IF c_titr10004%NOTFOUND
                                        THEN
                                            fechnoti :=
                                                TO_DATE (dtfechanotifica,
                                                         'yyyy/mm/dd');
                                        END IF;

                                        CLOSE c_titr10004;
                                    END IF;

                                    CLOSE c_titr10005;

                                    IF fechnoti IS NOT NULL
                                    THEN
                                        IF fechnoti <
                                           TO_DATE (dtfecharespu,
                                                    'dd/mm/yyyy')
                                        THEN
                                            sberrferefenot :=
                                                'VALIDACION-ERROR';
                                            rcldc_detarepoatecli.val_feresp_fenot :=
                                                sberrferefenot;
                                        ELSE
                                            rcldc_detarepoatecli.fecha_notificacion :=
                                                TO_CHAR (fechnoti,
                                                         'dd/mm/yyyy');
                                            sberrferefenot :=
                                                'VALIDACION-CORRECTA.';
                                            rcldc_detarepoatecli.val_feresp_fenot :=
                                                sberrferefenot;
                                        END IF;
                                    END IF;
                                ELSE
                                    sberrferefenot := 'VALIDACION-ERROR';
                                    rcldc_detarepoatecli.val_feresp_fenot :=
                                        sberrferefenot;
                                END IF;
                            EXCEPTION
                                WHEN OTHERS
                                THEN
                                    sberrferefenot := 'VALIDACION-ERROR';
                                    rcldc_detarepoatecli.val_feresp_fenot :=
                                        sberrferefenot;
                            END;
                        ELSE
                            sberrferefenot := 'VALIDACION-CORRECTA.';
                            rcldc_detarepoatecli.val_feresp_fenot :=
                                sberrferefenot;
                        END IF;

                        -- Dias hábiles entre fecha de respuesta y radicado recibido
                        IF dtfechrad IS NOT NULL AND dtfecharespu IS NOT NULL
                        THEN
                            SELECT COUNT (1)
                              INTO nudiasregistroval
                              FROM ge_calendar ca
                             WHERE     ca.date_ BETWEEN TO_DATE (
                                                            TO_CHAR (
                                                                dtfechrad,
                                                                'dd/mm/yyyy'),
                                                            'dd/mm/yyyy')
                                                    AND TO_DATE (
                                                            dtfecharespu,
                                                            'dd/mm/yyyy')
                                   AND ca.day_type_id = 1
                                   AND ca.country_id =
                                       pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                           'CODIGO_PAIS');

                            IF nudiasregistroval <=
                               pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                                   'NRO_DIAS_HABILES_ANEXO_A')
                            THEN
                                sbdeley := 'DENTRO DE LEY';
                                rcldc_detarepoatecli.deleysiono := sbdeley;
                            ELSE
                                sbdeley := 'FUERA DE LEY';
                                rcldc_detarepoatecli.deleysiono := sbdeley;
                            END IF;
                        END IF;
                    END IF;

                    -- Linea del registro a colocar en archivo
                    nulinea := 51;

                    IF (   (sbflagotprocinterno = 'S')
                        OR (    sbflagotprocinterno = 'N'
                            AND i.medio_rece_cod <> numediorecepotinterna))
                    THEN
                        rcldc_detarepoatecli.estado_iteraccion := NULL;
                        rcldc_detarepoatecli.estado_iteraccion :=
                            TO_CHAR (i.estado_iteracion);
                        sbLineaDeta :=
                               rcldc_detarepoatecli.dane_dpto
                            || csbseparador
                            || rcldc_detarepoatecli.dane_municipio
                            || csbseparador
                            || rcldc_detarepoatecli.dane_poblacion
                            || csbseparador
                            || rcldc_detarepoatecli.radicado_ing
                            || csbseparador
                            || rcldc_detarepoatecli.fecha_registro
                            || csbseparador
                            || rcldc_detarepoatecli.tipo_tramite
                            || csbseparador
                            || rcldc_detarepoatecli.causal
                            || csbseparador
                            || rcldc_detarepoatecli.detalle_causal
                            || csbseparador
                            || rcldc_detarepoatecli.numero_identificacion
                            || csbseparador
                            || rcldc_detarepoatecli.numero_factura
                            || csbseparador
                            || rcldc_detarepoatecli.tipo_respuesta
                            || csbseparador
                            || rcldc_detarepoatecli.fecha_respuesta
                            || csbseparador
                            || rcldc_detarepoatecli.radicado_res
                            || csbseparador
                            || rcldc_detarepoatecli.fecha_notificacion
                            || csbseparador
                            || NVL (rcldc_detarepoatecli.tipo_notificacion,
                                    sbtipnotconconlc)
                            || csbseparador
                            || rcldc_detarepoatecli.fecha_traslado
                            || csbseparador
                            || rcldc_detarepoatecli.tipo_solicitud
                            || ' - '
                            || REPLACE (i.desc_tipo_solicitud, ',', NULL)
                            || csbseparador
                            || rcldc_detarepoatecli.estado_solicitud
                            || ' - '
                            || REPLACE (i.desc_estado_solicitud, ',', NULL)
                            || csbseparador
                            || rcldc_detarepoatecli.medio_recepcion
                            || ' - '
                            || REPLACE (i.desc_med_rec, ',', NULL)
                            || csbseparador
                            || rcldc_detarepoatecli.tipo_respuesta_osf
                            || ' - '
                            || REPLACE (desc_tipo_repuesta_osf, ',', NULL)
                            || csbseparador
                            || rcldc_detarepoatecli.fecha_fin_ot_soli
                            || csbseparador
                            || rcldc_detarepoatecli.fecha_ejec_tt_re
                            || csbseparador
                            || rcldc_detarepoatecli.causal_lega_ot
                            || ' - '
                            || REPLACE (sbdesccausal, ',', NULL)
                            || csbseparador
                            || rcldc_detarepoatecli.tipo_unidad_oper
                            || ' - '
                            || REPLACE (sbdesctipounit, ',', NULL)
                            || csbseparador
                            || rcldc_detarepoatecli.medio_uso
                            || csbseparador
                            || rcldc_detarepoatecli.codigo_homologacion
                            || csbseparador
                            || rcldc_detarepoatecli.dias_registro
                            || csbseparador
                            || rcldc_detarepoatecli.tipo_reg_reporte
                            || csbSeparador
                            || rcldc_detarepoatecli.estado_iteraccion
                            || ' - '
                            || REPLACE (i.desc_estado_iteraccion, ',', NULL)
                            || csbSeparador
                            || rcldc_detarepoatecli.package_id
                            || csbSeparador
                            || rcldc_detarepoatecli.atencion_inmediata
                            || csbSeparador
                            || rcldc_detarepoatecli.carta
                            || csbSeparador
                            || rcldc_detarepoatecli.val_ferad_feresp
                            || csbSeparador
                            || rcldc_detarepoatecli.val_feresp_fenot
                            || csbSeparador
                            || rcldc_detarepoatecli.deleysiono
                            || csbSeparador
                            || nuunidadoperativa
                            || ' - '
                            || sbnombreunidadoper;
                        -- Se imprime la linea en el archivo
                        nulinea := 52;
                        ldc_paqueteanexoa.impresion (vfile, sblineadeta);
                        -- Creamos registro en la tabla
                        nulinea := 53;
                        ldc_paqueteanexoa.creadetallereporte (
                            rcldc_detarepoatecli);
                        nucantiregcom := nucantiregcom + 1;

                        IF nucantiregcom >= nucontareg
                        THEN
                            COMMIT;
                            nucantiregtot := nucantiregtot + nucantiregcom;
                            nucantiregcom := 0;
                        END IF;
                    END IF;
                END IF;
            EXCEPTION
                -- manejo de errores
                WHEN OTHERS
                THEN
                    numeroerrores := numeroerrores + 1;
                    sberror := SQLERRM;
                    sberror := SUBSTR (sberror, 1, 200);
                    ldcinsldclogerrorrsui (
                           'Error. Cursor:'
                        || sbcursor
                        || ' Solicitud:'
                        || nupakgsoliproc
                        || ' Linea:'
                        || TO_CHAR (nulinea)
                        || ' Error: '
                        || sberror);
            END;
        END LOOP;
    END LOOP;

    -- Verifica si existen datos correctos sin bajar a disco
    nulinea := 54;

    IF (ldc_paqueteanexoa.gsbAuxLine IS NOT NULL)
    THEN
        --{
        pkg_gestionArchivos.prcEscribirLinea_SMF (
            vFile,
            ldc_paqueteanexoa.gsbAuxLine);
        ldc_paqueteanexoa.gsbAuxLine := NULL;
    --}
    END IF;

    IF nucantiregcom <= 99
    THEN
        COMMIT;
        nucantiregtot := nucantiregtot + nucantiregcom;
    END IF;

    -- Cerramos el archivo
    nulinea := 55;
    pkg_gestionArchivos.prcCerrarArchivo_SMF (vFile);
    -- Envio del archivo
    sbAsunto := 'Formato_anexo_A_' || sbFile;
    sbMensaje := 'Reporte formato Anexo A ' || nupano || '  ' || nupmes;
    
    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbcorreo,
        isbAsunto           => sbAsunto,
        isbMensaje          => sbMensaje,
        isbArchivos         => sbruradirectorio || '/' || sbFile
    );
    
    nulinea := 56;
    ge_boschedule.changelogProcessStatus (nuLogProceso, 'F');
    sberror :=
           'Proceso terminó Ok. Se procesaron : '
        || TO_CHAR (nucantiregtot)
        || ' registros, con Id de reporte : '
        || TO_CHAR (rcldc_detarepoatecli.ateclirepo_id);
    ldc_proactualizaestaprog (nutsess,
                              NVL (sberror, 'Ok'),
                              'LDCREPANEXA',
                              'Termino ' || nuerror);
    nulinea := 57;

    IF numeroerrores = 0
    THEN
        sbMessage0 :=
               'No se genero log de errores porque no hubo error en la generacion del archivo del Reporte formato Anexo A '
            || nupano
            || '  '
            || nupmes;
    ELSE
        sbMessage0 :=
               'Anexo log de errores en generacion del archivo del Reporte formato Anexo A '
            || nupano
            || '  '
            || nupmes;
    END IF;

    sbRecipients := pkg_BCLD_Parameter.fsbObtieneValorCadena ('MAILRSUI');
    sbRuta :=
        pkg_BCLD_Parameter.fsbObtieneValorCadena (
            'RUTACONTROLCARTERAESPECIAL');
    flArchivo :=
        pkg_gestionArchivos.ftAbrirArchivo_SMF (sbRuta, sbNombArchivo, 'w');
    sbSubject :=
           'LOG ERRORES EN GENERACION ARCHIVO REPORTE FORMATO ANEXO A '
        || nupano
        || '  '
        || nupmes;

    FOR l IN curldclogerrorrsui
    LOOP
        sbmessage1 := L.msgerror;
        pkg_gestionArchivos.prcEscribirLinea_SMF (flArchivo, sbMessage1);
    END LOOP;

    pkg_gestionArchivos.prcCerrarArchivo_SMF (flArchivo);
    pkg_Traza.Trace ('cerre archivo de log de errores');

    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => sbRecipients,
        isbAsunto           => sbSubject,
        isbMensaje          => sbMessage0,
        isbArchivos         => sbRuta || '/' || sbNombArchivo
    );
        
    pkg_traza.trace (csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR
    THEN
        ldc_proactualizaestaprog (
            nutsess,
               SQLERRM
            || ' SOLICITUD : '
            || TO_CHAR (nupakgsoliproc)
            || ' LINEA '
            || TO_CHAR (nulinea)
            || ' sberror '
            || sberror,
            'LDCREPANEXA',
            'Termino ' || sbmenrege);
        RAISE pkg_Error.CONTROLLED_ERROR;
    WHEN OTHERS
    THEN
        ldc_proactualizaestaprog (
            nutsess,
               SQLERRM
            || ' SOLICITUD : '
            || TO_CHAR (nupakgsoliproc)
            || ' LINEA '
            || TO_CHAR (nulinea)
            || ' sberror '
            || sberror,
            'LDCREPANEXA',
            'Termino ' || sbmenrege);
        pkg_Error.setError;
        RAISE pkg_Error.CONTROLLED_ERROR;
END;
/