CREATE OR REPLACE PROCEDURE ldcreasco (
    inuProgramacion   IN ge_process_schedule.process_schedule_id%TYPE)
IS
    /*****************************************************************************************************************
        Autor       : John Jairo Jimenez Marimon
        Fecha       : 2018-09-03
        Descripcion : Registramos cantidad de ordenes asignadas por contratista ofertados de cartera.

        Parametros Entrada

        Valor de salida

       HISTORIA DE MODIFICACIONES
         FECHA        AUTOR   DESCRIPCION
         25/JUL/2020    JJJM 0000455  Se modifca el cursor cuofertadcart para que los tipos de ofertados los lea del parametro :
                                    TIPODEOFERTADORANGOXASIG.
                                    Se modifica los cursores cuordasignadassinzonas y cuordasignadas para que las causales las causales del
                                    parametro : CAUSNOVALIDAS_OFERTRANXASIG.
                    En esta entrega no se modifico la logica del procedimiento, solo se reemplazaron los valores quemados
                    por parametros configurables.
         15-02-2020   HB      Cambio 242 Se modifica para manejo de actividades padre y actividades hijas
         29-01-2020   HB      Cambio 90 Se modifica para que se puedan digitar y procesar varias unidades operativas
         20-07-2021   HB      Cambio 633 Se modifica para que cuando la unidad operativa este en el parametro UNI_OPE_LEC_ESP cuente las lecturas de cada orden
                              de la tabla de lecturas especiales (LDC_CM_LECTESP)
      20-07-2021   Horbath      Caso 626:Se modfica para enviar un correo un correo a la persona conectada al momento de ejecutarse  la forma ldcreasco.
      29-04-2024   jpinedc   OSF-2581: Se reemplaza LDC_SENDEMAIL por pkg_Correo.prcEnviaCorreo
    ********************************************************************************************************************/


    CURSOR cudatosfecha (nucucicoano NUMBER, nucucicomes NUMBER)
    IS
        SELECT *
          FROM (  SELECT c.cicoano,
                         c.cicomes,
                         c.cicofein,
                         c.cicofech
                    FROM ldc_ciercome c
                   WHERE     c.cicoano =
                             DECODE (nucucicoano, -1, c.cicoano, nucucicoano)
                         AND c.cicomes =
                             DECODE (nucucicomes, -1, c.cicomes, nucucicomes)
                         AND c.cicoesta = 'S'
                ORDER BY c.cicofech DESC)
         WHERE ROWNUM = 1;

    CURSOR cuofertadcart (sbUnidOpe VARCHAR2)
    IS
        SELECT xu.unidad_operativa
          FROM ldc_const_unoprl xu
         WHERE     xu.tipo_ofertado IN
                       (                                       -- Caso 0000455
                        SELECT TO_NUMBER (COLUMN_VALUE)
                          FROM TABLE (
                                   ldc_boutilities.splitstrings (
                                       pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                           'TIPODEOFERTADORANGOXASIG'),
                                       ',')))
               AND xu.unidad_operativa IN
                       (SELECT TO_NUMBER (COLUMN_VALUE)
                          FROM TABLE (
                                   LDC_BOUTILITIES.SPLITSTRINGS (sbUnidOpe,
                                                                 '|')));



    CURSOR cuordasignadassinzonas (nucuunidoper   NUMBER,
                                   dtcufeinasig   DATE,
                                   dtcufefiasig   DATE)
    IS
          -- se modifica cursor (Cambio 242)
          SELECT tipo_trabajo_cart,
                 act_padre                   actividad_cart,
                 SUM (cantidad_asignada)     cantidad_asignada
            FROM (  SELECT o.task_type_id
                               tipo_trabajo_cart,
                           a.activity_id
                               actividad_cart,
                           DECODE ((SELECT apah.actividad_padre
                                      FROM ldc_act_father_act_hija apah
                                     WHERE apah.actividad_hija = a.activity_id),
                                   NULL, a.activity_id,
                                   (SELECT apah.actividad_padre
                                      FROM ldc_act_father_act_hija apah
                                     WHERE apah.actividad_hija = a.activity_id))
                               act_padre,
                           SUM (
                               ldc_cantasignada (o.operating_unit_id,
                                                 o.order_id,
                                                 o.saved_data_values))
                               cantidad_asignada                      -- CA633
                      FROM or_order o, or_order_activity a
                     WHERE     o.operating_unit_id = nucuunidoper
                           AND NVL (o.causal_id, -1) NOT IN
                                   (                           -- Caso 0000455
                                    SELECT TO_NUMBER (COLUMN_VALUE)
                                      FROM TABLE (
                                               ldc_boutilities.splitstrings (
                                                   pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                                       'CAUSNOVALIDAS_OFERTRANXASIG'),
                                                   ',')))
                           AND o.order_status_id = o.order_status_id
                           AND a.activity_id NOT IN
                                   (SELECT cx.actividad_novedad_ofertados
                                      FROM ldc_tipo_trab_x_nov_ofertados cx)
                           AND o.assigned_date BETWEEN dtcufeinasig
                                                   AND dtcufefiasig
                           AND a.order_activity_id =
                               ldc_bcfinanceot.fnugetactivityid (o.order_id)
                           AND o.order_id = a.order_id
                  GROUP BY o.task_type_id, a.activity_id)
        GROUP BY tipo_trabajo_cart, act_padre;

    CURSOR cuordasignadas (nucuunidoper   NUMBER,
                           dtcufeinasig   DATE,
                           dtcufefiasig   DATE)
    IS
          -- se modifica cursor (Cambio 242)
          SELECT tipo_trabajo_cart,
                 act_padre                   actividad_cart,
                 zona_ofertado_cart,
                 SUM (cantidad_asignada)     cantidad_asignada
            FROM (  SELECT o.task_type_id
                               tipo_trabajo_cart,
                           a.activity_id,
                           DECODE ((SELECT apah.actividad_padre
                                      FROM ldc_act_father_act_hija apah
                                     WHERE apah.actividad_hija = a.activity_id),
                                   NULL, a.activity_id,
                                   (SELECT apah.actividad_padre
                                      FROM ldc_act_father_act_hija apah
                                     WHERE apah.actividad_hija = a.activity_id))
                               act_padre,
                           z.id_zona_oper
                               zona_ofertado_cart,
                           SUM (
                               ldc_cantasignada (o.operating_unit_id,
                                                 o.order_id,
                                                 o.saved_data_values))
                               cantidad_asignada                      -- CA633
                      --,COUNT(1) cantidad_asignada
                      FROM or_order       o,
                           ab_address     d,
                           ldc_zona_loc_ofer_cart z,
                           or_order_activity a
                     WHERE     o.operating_unit_id = nucuunidoper
                           AND NVL (o.causal_id, -1) NOT IN
                                   (                           -- Caso 0000455
                                    SELECT TO_NUMBER (COLUMN_VALUE)
                                      FROM TABLE (
                                               ldc_boutilities.splitstrings (
                                                   pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                                       'CAUSNOVALIDAS_OFERTRANXASIG'),
                                                   ',')))
                           AND o.order_status_id = o.order_status_id
                           AND a.activity_id NOT IN
                                   (SELECT cx.actividad_novedad_ofertados
                                      FROM ldc_tipo_trab_x_nov_ofertados cx)
                           AND o.assigned_date BETWEEN dtcufeinasig
                                                   AND dtcufefiasig
                           AND a.order_activity_id =
                               ldc_bcfinanceot.fnugetactivityid (o.order_id)
                           AND o.external_address_id = d.address_id
                           AND d.geograp_location_id = z.localidad
                           AND o.order_id = a.order_id
                  GROUP BY o.task_type_id, a.activity_id, z.id_zona_oper)
        GROUP BY tipo_trabajo_cart, act_padre, zona_ofertado_cart;

    nutsess        NUMBER;
    sbparuser      VARCHAR2 (30);
    sbmensa        VARCHAR2 (1000);
    nucontreg      NUMBER (8);
    sbParametros   ge_process_schedule.parameters_%TYPE;
    nuHilos        NUMBER := 1;
    nuLogProceso   ge_log_process.log_process_id%TYPE;
    nuvaunitoper   VARCHAR2 (2000);
    nuvacicoano    ldc_ciercome.cicoano%TYPE;
    nuvacicomes    ldc_ciercome.cicomes%TYPE;
    sbobserd       VARCHAR2 (1000);
    nucontazonas   NUMBER (10);
    nucuentaunid   NUMBER := 0;

    --Inicio Caso: 626
    PROCEDURE ldcreasco_enviacorreo (MESSAGE   VARCHAR2,
                                     nuAno     NUMBER,
                                     nuMes     NUMBER)
    IS
        nutsess     NUMBER;
        sbmensa     VARCHAR2 (1000);
        sbemail     VARCHAR2 (100);
        sbparuser   VARCHAR2 (30);

        CURSOR cuCorreoperson IS                                   -- caso:626
            SELECT E_MAIL
              FROM GE_PERSON
             WHERE PERSON_ID = ge_bopersonal.fnuGetPersonId;
             
        sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
           
    BEGIN

        nutsess     := USERENV ('SESSIONID'); 
        sbparuser   := USER;

        ldc_proinsertaestaprog (nuAno,
                                nuMes,
                                'LDCREASCO_ENVIACORREO',
                                'En ejecucion',
                                nutsess,
                                sbparuser);

        OPEN cuCorreoperson;

        FETCH cuCorreoperson INTO sbemail;

        CLOSE cuCorreoperson;

        IF sbemail IS NOT NULL
        THEN

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => sbemail,
                isbAsunto           => 'Notificacion de finalizacion del proceso LDCREASCO',
                isbMensaje          => MESSAGE
            );  
                
            ldc_proactualizaestaprog (nutsess,
                                      'Envia correo',
                                      'LDCREASCO_ENVIACORREO',
                                      'Termino Ok.');
        ELSE
            ldc_proactualizaestaprog (
                nutsess,
                'No se encontro correo configurado',
                'LDCREASCO_ENVIACORREO',
                'ERROR.');
        END IF;

    EXCEPTION
        WHEN OTHERS
        THEN
            sbmensa :=
                   'Error al enviar el correo del proceso LDCREASCO. '
                || SQLERRM;
            ldc_proactualizaestaprog (nutsess,
                                      sbmensa,
                                      'LDCREASCO_ENVIACORREO',
                                      'ERROR.');
    END;
-- Fin caso:626


BEGIN
    -- Obtenemos datos para realizar ejecucion
      
    nutsess     := USERENV ('SESSIONID');
    sbparuser   := USER;

    -- Se obtiene parametros
    ge_boschedule.AddLogToScheduleProcess (inuprogramacion,
                                           nuhilos,
                                           nulogproceso);
    sbParametros := dage_process_schedule.fsbGetParameters_ (inuProgramacion);
    nuvaunitoper :=
        ut_string.getparametervalue (sbParametros,
                                     'ADDRESS',
                                     '|',
                                     '=');
    nuvacicoano :=
        TO_NUMBER (ut_string.getparametervalue (sbParametros,
                                                'CICOANO',
                                                '|',
                                                '='));
    nuvacicomes :=
        TO_NUMBER (ut_string.getparametervalue (sbParametros,
                                                'CICOMES',
                                                '|',
                                                '='));



    -- Obtenemos las fechas del mes
    FOR i IN cudatosfecha (nuvacicoano, nuvacicomes)
    LOOP
        -- Se inicia log del programa
        -- Obtenemos las unidades operativas ofertadas
        /* nucontreg := 0;*/
        FOR j IN cuofertadcart (nuvaunitoper)
        LOOP
            ldc_proinsertaestaprog (i.cicoano,
                                    i.cicomes,
                                    'LDCREASCO',
                                    'En ejecucion',
                                    nutsess,
                                    sbparuser);
            nucontreg := 0;
            nucontazonas := 0;

            -- Consultamos si la unidad operativa tiene configuraci?n por zonas
            SELECT COUNT (1)
              INTO nucontazonas
              FROM ldc_const_liqtarran bv
             WHERE     bv.unidad_operativa = j.unidad_operativa
                   AND bv.zona_ofertados = -1
                   AND TRUNC (SYSDATE) BETWEEN TRUNC (bv.fecha_ini_vigen)
                                           AND TRUNC (bv.fecha_fin_vige);

            -- Se inactivan los registros en caso de que ya existan
            UPDATE ldc_cant_asig_ofer_cart x
               SET x.reg_activo = 'N'
             WHERE     x.nuano = nuvacicoano
                   AND x.numes = nuvacicomes
                   AND x.unidad_operatva_cart = j.unidad_operativa
                   AND x.reg_activo = 'Y';

            COMMIT;

            -- Obtenemos las asignaciones
            IF nucontazonas >= 1
            THEN
                FOR k
                    IN cuordasignadassinzonas (j.unidad_operativa,
                                               i.cicofein,
                                               i.cicofech)
                LOOP
                    sbobserd :=
                           i.cicoano
                        || ' - '
                        || i.cicomes
                        || ' - '
                        || j.unidad_operativa
                        || ' - '
                        || k.actividad_cart
                        || ' - '
                        || k.tipo_trabajo_cart
                        || ' - '
                        || -1
                        || ' - '
                        || 'Y';

                    INSERT INTO ldc_cant_asig_ofer_cart (
                                    nuano,
                                    numes,
                                    unidad_operatva_cart,
                                    actividad,
                                    tipo_trabajo,
                                    zona_ofertados,
                                    reg_activo,
                                    cantidad_asignada,
                                    fecha_creacion_reg,
                                    usuario,
                                    nro_acta)
                         VALUES (i.cicoano,
                                 i.cicomes,
                                 j.unidad_operativa,
                                 k.actividad_cart,
                                 k.tipo_trabajo_cart,
                                 -1,
                                 'Y',
                                 k.cantidad_asignada,
                                 SYSDATE,
                                 USER,
                                 -1);

                    nucontreg := nucontreg + 1;
                    COMMIT;
                END LOOP;
            ELSE
                FOR k
                    IN cuordasignadas (j.unidad_operativa,
                                       i.cicofein,
                                       i.cicofech)
                LOOP
                    sbobserd :=
                           i.cicoano
                        || ' - '
                        || i.cicomes
                        || ' - '
                        || j.unidad_operativa
                        || ' - '
                        || k.actividad_cart
                        || ' - '
                        || k.tipo_trabajo_cart
                        || ' - '
                        || k.zona_ofertado_cart
                        || ' - '
                        || 'Y';

                    INSERT INTO ldc_cant_asig_ofer_cart (
                                    nuano,
                                    numes,
                                    unidad_operatva_cart,
                                    actividad,
                                    tipo_trabajo,
                                    zona_ofertados,
                                    reg_activo,
                                    cantidad_asignada,
                                    fecha_creacion_reg,
                                    usuario,
                                    nro_acta)
                         VALUES (i.cicoano,
                                 i.cicomes,
                                 j.unidad_operativa,
                                 k.actividad_cart,
                                 k.tipo_trabajo_cart,
                                 k.zona_ofertado_cart,
                                 'Y',
                                 k.cantidad_asignada,
                                 SYSDATE,
                                 USER,
                                 -1);

                    nucontreg := nucontreg + 1;
                    COMMIT;
                END LOOP;
            END IF;

            sbmensa :=
                   'Unidad: '
                || j.unidad_operativa
                || ' - Proceso terminó Ok. Se crearon : '
                || TO_CHAR (nucontreg)
                || ' registros.';
            ldcreasco_enviacorreo ('El proceso LDCREASCO termino con exito',
                                   nuvacicoano,
                                   nuvacicomes);                   -- caso:626
            ldc_proactualizaestaprog (nutsess,
                                      sbmensa,
                                      'LDCREASCO',
                                      'Termino Ok.');
        END LOOP;
    END LOOP;

    ge_boschedule.changelogProcessStatus (nuLogProceso, 'F');
EXCEPTION
    WHEN OTHERS
    THEN
        sbmensa :=
               'Proceso terminó con errores LDCREASCO. '
            || SQLERRM
            || ' - '
            || sbobserd;
        ldc_proactualizaestaprog (nutsess,
                                  sbmensa,
                                  'LDCREASCO',
                                  'ERROR.');
        ldcreasco_enviacorreo (
               'El proceso LDCREASCO termino con errores: '
            || SQLERRM
            || ' - '
            || sbobserd,
            nuvacicoano,
            nuvacicomes);
        ge_boschedule.changelogProcessStatus (nuLogProceso, 'F');
END;
/