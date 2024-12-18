CREATE OR REPLACE PACKAGE LDC_BOMETROLOGICAL is

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BOMETROLOGICAL
    Descripcion    : PAQUETE PARA VALIDAR LAS ORDENES DE PLAN DE MANTENIMIENTO
                     DE EQUIDOS O INSTRUMENTOS DE METROLOGIA.
    Autor          : JORGE VALIENTE
    Fecha          : 25/05/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    27-10-2014        Llozada [NC 2388]     Se modifica el metodo <<PrcVencFechCalibracion>>
    22-04-2024        jpinedc [OSF-2580]    * Se cambia ldc_sendemail por
                                            pkg_Correo
                                            * Se quita código en comentarios
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrcVencFechCalibracion
  Descripcion    : Valida con dias de anticipacion la fecha de
                   vencimiento de calibracion de los equipos o
                   instrumentos.
  Autor          :
  Fecha          : 25/05/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrcVencFechCalibracion;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrcVencFechMantemiento
  Descripcion    : Valida con dias de anticipacion la fecha de
                   vencimiento de mantenimiento de los equipos o
                   instrumentos.
  Autor          :
  Fecha          : 25/05/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrcVencFechMantemiento;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrcVencFechCaliPatron1
  Descripcion    : Valida con dias de anticipacion la fecha de
                   vencimiento de calibracion de los equipos patrones.
                   para esta calibracion de equipos patrones se utilizara
                   una cantidad de dias mayoor a validar la fecha de vencimiento
                   a la configurada del parametro para PrcVencFechCaliPatron2
  Autor          : Jorge Valiente
  Fecha          : 25/05/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrcVencFechCaliPatron1;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrcVencFechCaliPatron1
  Descripcion    : Valida con dias de anticipacion la fecha de
                   vencimiento de calibracion de los equipos patrones.
                   para esta calibracion de equipos patrones se utilizara
                   una cantidad de dias menor a validar la fecha de vencimiento
                   a la configurada del parametro para PrcVencFechCaliPatron1
  Autor          : Jorge Valiente
  Fecha          : 25/05/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrcVencFechCaliPatron2;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrcOrdenAseguMetroVenc
  Descripcion    : Valida ordenes de aseeguramiento metrologico ya vencidas.
  Autor          : Jorge Valiente
  Fecha          : 25/05/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrcOrdenAseguMetroVenc;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrcVencFechCaliPatron1
  Descripcion    : Valida con dias de anticipacion la fecha de
                   vencimiento de calibracion de los equipos patrones.
                   para esta calibracion de equipos patrones se utilizara
                   una cantidad de dias menor a validar la fecha de vencimiento
                   a la configurada del parametro para PrcVencFechCaliPatron1
  Autor          : Jorge Valiente
  Fecha          : 25/05/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrcVencFechConfMetrolo;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrcOrdenesMetrologicas
  Descripcion    : Ejecuta los procesos que permitiran identificar
                   cada una de las ordenes definidas en el plan de metrologia
  Autor          : Jorge Valiente
  Fecha          : 26/05/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrcOrdenesMetrologicas;

end LDC_BOMETROLOGICAL;
/

CREATE OR REPLACE PACKAGE BODY LDC_BOMETROLOGICAL
IS

    gsbRemitente     ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');

    csbCOD_ESTA_MANT ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena ('COD_ESTA_MANT');   

    csbEMAIL_ERROR_METR ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena ('EMAIL_ERROR_METR');

    csbCOD_TIPO_TRAB_MANT ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena ('COD_TIPO_TRAB_MANT');

    csbCOD_TIPO_CONF_METRO ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena ('COD_TIPO_CONF_METRO');

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : PrcVencFechCalibracion
    Descripcion    : Valida con dias de anticipacion la fecha de
                     vencimiento de calibracion de los equipos o
                     instrumentos.
    Autor          : Jorge Valiente
    Fecha          : 25/05/2013

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    22-11-2016       lfvalencia         Se modifica el cursor CUCONTRATISTAS para
                                        validar que el campo VALID_UNTIL sea mayor
                                        que la fecha actual del sistema.
    22-11-2014       paulaag [NC 3820]  Se modifica el cursor CUEXISTEORDEN para corregir el valor del
                                        RANGO.
    27-10-2014       llozada [NC 2388]  Se cambia la sentencia para que incluya los equipos de Terceros,
                                        ademas, se debe notificar N dias antes de la fecha de vencimiento.
    15-08-2013       Jsoto              Se cambia para que notifique a la persona
                                        encargada de la U.Trabajo al que esta asignado
                                        el item seriado
    ******************************************************************/
    PROCEDURE PrcVencFechCalibracion
    IS
        CURSOR CUCONTRATISTAS IS
            SELECT *
              FROM (  SELECT DISTINCT
                             (DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                  GE_ITEMS_SERIADO.ID_ITEMS_SERIADO))    "UNIDAD_TRABAJO"
                        FROM IF_MAINT_ITEMSER,
                             IF_MAINTENANCE,
                             GE_ITEMS_SERIADO,
                             GE_ITEMS_TIPO_AT_VAL,
                             GE_ITEMS_TIPO_ATR,
                             OR_ITEM_PATTERN
                       WHERE     IF_MAINTENANCE.MAINTENANCE_CONF_ID =
                                 IF_MAINT_ITEMSER.MAINT_ITEMSER_ID
                             AND IF_MAINTENANCE.ENTITY_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ENTI_ITEM_SERI')
                             AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
                                 IF_MAINTENANCE.EXTERNAL_ID
                             AND OR_ITEM_PATTERN.ID_ITEMS_SERIADO =
                                 GE_ITEMS_SERIADO.ID_ITEMS_SERIADO
                             AND OR_ITEM_PATTERN.VALID_UNTIL > SYSDATE
                             AND ABS (
                                       TRUNC (OR_ITEM_PATTERN.VALID_UNTIL)
                                     - TRUNC (SYSDATE)) =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_CALI')
                             AND IF_MAINTENANCE.MAINTENANCE_STATUS IN
                             (
                                SELECT to_number(regexp_substr(csbCOD_ESTA_MANT,'[^,]+', 1,LEVEL))
                                FROM dual
                                CONNECT BY regexp_substr(csbCOD_ESTA_MANT, '[^,]+', 1, LEVEL) IS NOT NULL
                             )
                             AND GE_ITEMS_SERIADO.ITEMS_ID =
                                 GE_ITEMS_TIPO_AT_VAL.ITEMS_ID
                             AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_TIPO_ATR =
                                 GE_ITEMS_TIPO_ATR.ID_ITEMS_TIPO_ATR
                             AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_SERIADO =
                                 GE_ITEMS_SERIADO.ID_ITEMS_SERIADO
                             AND GE_ITEMS_TIPO_ATR.ENTITY_ATTRIBUTE_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ATRI_RANGO')
                    ORDER BY 1 ASC)
            UNION
            SELECT DISTINCT a.operating_unit_id
              FROM GE_ITEMS_SERIADO a, OR_ITEM_PATTERN b
             WHERE     propiedad = 'T'
                   AND a.id_items_seriado = b.id_items_seriado
                   AND b.VALID_UNTIL > SYSDATE
                   AND ABS (TRUNC (b.VALID_UNTIL) - TRUNC (SYSDATE)) =
                       pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_CALI')
                   AND NOT EXISTS
                           (SELECT 'x'
                              FROM IF_MAINTENANCE c
                             WHERE c.external_id = a.id_items_seriado); /*Se adicionan los equipos de TERCEROS*/

        /*Trae la informacion del equipo*/
        CURSOR CUEXISTEORDEN (
            INUID_CONTRATISTA   GE_CONTRATISTA.ID_CONTRATISTA%TYPE)
        IS
            SELECT *
              FROM (  SELECT DISTINCT
                             GE_ITEMS_SERIADO.SERIE
                                 "CODIGO",
                             DAGE_ITEMS.FSBGETDESCRIPTION (
                                 GE_ITEMS_SERIADO.ITEMS_ID,
                                 NULL)
                                 "INSTRUMENTO",
                             GE_ITEMS_TIPO_AT_VAL.VALOR
                                 "RANGO",
                             DAOR_OPERATING_UNIT.FSBGETNAME (
                                 DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                     GE_ITEMS_SERIADO.ID_ITEMS_SERIADO))
                                 "NOM_U_OPERATIVA",
                             DAGE_PERSON.FSBGETE_MAIL (
                                 DAOR_OPERATING_UNIT.FNUGETPERSON_IN_CHARGE (
                                     DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                         GE_ITEMS_SERIADO.ID_ITEMS_SERIADO)),
                                 NULL)
                                 "CORREO",
                                (open.DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                     GE_ITEMS_SERIADO.ID_ITEMS_SERIADO,
                                     NULL))
                             || '-'
                             || (OPEN.DAOR_OPERATING_UNIT.FSBGETNAME (
                                     open.DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                         GE_ITEMS_SERIADO.ID_ITEMS_SERIADO,
                                         NULL),
                                     NULL))
                                 "UNIDAD_TRABAJO"
                        FROM IF_MAINT_ITEMSER,
                             IF_MAINTENANCE,
                             GE_ITEMS_SERIADO,
                             GE_ITEMS_TIPO_AT_VAL,
                             GE_ITEMS_TIPO_ATR,
                             OR_ITEM_PATTERN
                       WHERE     IF_MAINTENANCE.MAINTENANCE_CONF_ID =
                                 IF_MAINT_ITEMSER.MAINT_ITEMSER_ID
                             AND IF_MAINTENANCE.ENTITY_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ENTI_ITEM_SERI')
                             AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
                                 IF_MAINTENANCE.EXTERNAL_ID
                             AND OR_ITEM_PATTERN.ID_ITEMS_SERIADO =
                                 GE_ITEMS_SERIADO.ID_ITEMS_SERIADO
                             AND OR_ITEM_PATTERN.VALID_UNTIL > SYSDATE
                             AND ABS (
                                       TRUNC (OR_ITEM_PATTERN.VALID_UNTIL)
                                     - TRUNC (SYSDATE)) =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_CALI')
                             AND IF_MAINTENANCE.MAINTENANCE_STATUS IN
                             (
                                SELECT to_number(regexp_substr(csbCOD_ESTA_MANT,'[^,]+', 1,LEVEL))
                                FROM dual
                                CONNECT BY regexp_substr(csbCOD_ESTA_MANT, '[^,]+', 1, LEVEL) IS NOT NULL
                             )
                             AND GE_ITEMS_SERIADO.ITEMS_ID =
                                 GE_ITEMS_TIPO_AT_VAL.ITEMS_ID
                             AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_SERIADO =
                                 GE_ITEMS_SERIADO.ID_ITEMS_SERIADO
                             AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_TIPO_ATR =
                                 GE_ITEMS_TIPO_ATR.ID_ITEMS_TIPO_ATR
                             AND GE_ITEMS_TIPO_ATR.ENTITY_ATTRIBUTE_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ATRI_RANGO')
                             AND (DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                      GE_ITEMS_SERIADO.ID_ITEMS_SERIADO)) =
                                 INUID_CONTRATISTA
                             AND GE_ITEMS_SERIADO.OPERATING_UNIT_ID IS NOT NULL
                    ORDER BY 6 DESC)
            UNION
            (SELECT DISTINCT
                    a.SERIE
                        "CODIGO",
                    DAGE_ITEMS.FSBGETDESCRIPTION (a.ITEMS_ID, NULL)
                        "INSTRUMENTO",
                    c.VALOR
                        "RANGO",
                    DAOR_OPERATING_UNIT.FSBGETNAME (
                        DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                            a.ID_ITEMS_SERIADO))
                        "NOM_U_OPERATIVA",
                    DAGE_PERSON.FSBGETE_MAIL (
                        DAOR_OPERATING_UNIT.FNUGETPERSON_IN_CHARGE (
                            DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                a.ID_ITEMS_SERIADO)),
                        NULL)
                        "CORREO",
                       (open.DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                            a.ID_ITEMS_SERIADO,
                            NULL))
                    || '-'
                    || (OPEN.DAOR_OPERATING_UNIT.FSBGETNAME (
                            open.DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                a.ID_ITEMS_SERIADO,
                                NULL),
                            NULL))
                        "UNIDAD_TRABAJO"
               FROM GE_ITEMS_SERIADO      a,
                    OR_ITEM_PATTERN       b,
                    GE_ITEMS_TIPO_AT_VAL  c,
                    GE_ITEMS_TIPO_ATR     d
              WHERE     propiedad = 'T'
                    AND a.id_items_seriado = b.id_items_seriado
                    AND b.VALID_UNTIL > SYSDATE
                    AND ABS (TRUNC (b.VALID_UNTIL) - TRUNC (SYSDATE)) =
                        pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_CALI')
                    AND NOT EXISTS
                            (SELECT 'x'
                               FROM IF_MAINTENANCE c
                              WHERE c.external_id = a.id_items_seriado)
                    AND a.ITEMS_ID = c.ITEMS_ID
                    AND c.ID_ITEMS_SERIADO = a.ID_ITEMS_SERIADO
                    AND c.ID_ITEMS_TIPO_ATR = d.ID_ITEMS_TIPO_ATR
                    AND d.ENTITY_ATTRIBUTE_ID =
                        pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ATRI_RANGO')
                    AND (DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                             a.ID_ITEMS_SERIADO)) =
                        INUID_CONTRATISTA);

        sbMensaje1      VARCHAR2 (4000);
        sbMensaje2      VARCHAR2 (4000);

        sbEmail         GE_CONTRATISTA.CORREO_ELECTRONICO%TYPE;
        
        sbAsunto        VARCHAR2(1000);
        
    BEGIN
        pkg_Traza.Trace ('Inicio LDC_BOMETROLOGICAL.PrcVencFechCalibracion',
                         10);

        sbMensaje1 := NULL;
        sbMensaje2 := NULL;

        FOR TEMPCUCONTRATISTAS IN CUCONTRATISTAS
        LOOP
            sbMensaje1 :=
                   'El programa de aseguramiento metrologico indica que a la fecha '
                || TO_CHAR (SYSDATE, 'DD/MON/YYYY')
                || ' la unidad operativa ['
                || open.DAOR_OPERATING_UNIT.FSBGETNAME (
                       TEMPCUCONTRATISTAS.UNIDAD_TRABAJO,
                       NULL)
                || '] tiene equipo(s) o instrumento(s) (items seriados) que le faltan '
                || pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_CALI')
                || ' dias para vencer la fecha de calibracion: <P>'
                || '<table BORDER="1"> <tr BGCOLOR="gray"> <th>'
                || 'SERIE </th> <th>'
                || 'INSTRUMENTO </th> <th>'
                || 'RANGO </th> <th>'
                || 'UNIDAD OPERATIVA </th> </tr>';

            FOR TEMPCUEXISTEORDEN
                IN CUEXISTEORDEN (TEMPCUCONTRATISTAS.UNIDAD_TRABAJO)
            LOOP
                sbMensaje2 :=
                       sbMensaje2
                    || '<tr> <td>'
                    || TEMPCUEXISTEORDEN.CODIGO
                    || '</td> <td>'
                    || TEMPCUEXISTEORDEN.INSTRUMENTO
                    || '</td> <td>'
                    || TEMPCUEXISTEORDEN.RANGO
                    || '</td> <td>'
                    || TEMPCUEXISTEORDEN.UNIDAD_TRABAJO
                    || '</td> </tr>';

                sbEmail := TEMPCUEXISTEORDEN.CORREO;
            END LOOP;

            IF sbEmail IS NULL
            THEN
                sbEmail :=
                    csbEMAIL_ERROR_METR;
                sbMensaje1 :=
                       'Los siguientes datos no pudieron ser enviados: <P>'
                    || sbMensaje1
                    || sbMensaje2
                    || '  </table>';
                    
                    sbAsunto := 'CORREO INVALIDO UNIDAD OPERATIVA ['
                    || DAOR_OPERATING_UNIT.FSBGETNAME (
                           TEMPCUCONTRATISTAS.UNIDAD_TRABAJO)
                    || '] VENCIMIENTO FECHA LIMITE PARA CALIBRACION Y/O MANTENIMIENTO';
                    
                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => gsbRemitente,
                        isbDestinatarios    => sbEmail,
                        isbAsunto           => sbAsunto,
                        isbMensaje          => sbMensaje1
                    );
                    
            ELSE
                IF sbMensaje2 IS NOT NULL
                THEN
                    sbMensaje1 := sbMensaje1 || sbMensaje2 || '  </table>';

                    sbAsunto := 'VENCIMIENTO FECHA LIMITE PARA CALIBRACION Y/O MANTENIMIENTO';
                    
                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => gsbRemitente,
                        isbDestinatarios    => sbEmail,
                        isbAsunto           => sbAsunto,
                        isbMensaje          => sbMensaje1
                    );

                END IF;
            END IF;

            sbMensaje1 := NULL;
            sbMensaje2 := NULL;
        END LOOP;

        pkg_Traza.Trace ('Fin LDC_BOMETROLOGICAL.PrcVencFechCalibracion', 10);
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            gw_boerrors.checkerror (SQLCODE, SQLERRM);
    END PrcVencFechCalibracion;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : PrcVencFechMantemiento
    Descripcion    : Valida con dias de anticipacion la fecha de
                     vencimiento de mantenimiento de los equipos o
                     instrumentos.
    Autor          : Jorge Valiente
    Fecha          : 25/05/2013

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE PrcVencFechMantemiento
    IS
        CURSOR CUCONTRATISTAS IS
            SELECT *
              FROM (  SELECT DISTINCT
                             DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID (
                                 DAOR_ORDER.FNUGETOPERATING_UNIT_ID (
                                     IF_MAINTENANCE.ORDER_ID,
                                     NULL),
                                 NULL)    "CODIGO_CONTRATISTA"
                        FROM IF_MAINT_ITEMSER,
                             IF_MAINTENANCE,
                             GE_ITEMS_SERIADO,
                             GE_ITEMS_TIPO_AT_VAL,
                             GE_ITEMS_TIPO_ATR,
                             OR_ITEM_PATTERN
                       WHERE     IF_MAINTENANCE.MAINTENANCE_CONF_ID =
                                 IF_MAINT_ITEMSER.MAINT_ITEMSER_ID
                             AND IF_MAINTENANCE.ENTITY_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ENTI_ITEM_SERI')
                             AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
                                 IF_MAINTENANCE.EXTERNAL_ID
                             AND OR_ITEM_PATTERN.ID_ITEMS_SERIADO =
                                 GE_ITEMS_SERIADO.ID_ITEMS_SERIADO
                             AND ABS (
                                       TRUNC (OR_ITEM_PATTERN.VALID_UNTIL)
                                     - TRUNC (SYSDATE)) =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_MANT')
                             AND IF_MAINTENANCE.MAINTENANCE_STATUS IN
                             (
                                SELECT to_number(regexp_substr(csbCOD_ESTA_MANT,'[^,]+', 1,LEVEL))
                                FROM dual
                                CONNECT BY regexp_substr(csbCOD_ESTA_MANT, '[^,]+', 1, LEVEL) IS NOT NULL
                             )
                             AND GE_ITEMS_SERIADO.ITEMS_ID =
                                 GE_ITEMS_TIPO_AT_VAL.ITEMS_ID
                             AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_TIPO_ATR =
                                 GE_ITEMS_TIPO_ATR.ID_ITEMS_TIPO_ATR
                             AND GE_ITEMS_TIPO_ATR.ENTITY_ATTRIBUTE_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ATRI_RANGO')
                             AND DAOR_ORDER.FNUGETTASK_TYPE_ID (
                                     IF_MAINTENANCE.ORDER_ID) IN
                                        (
                                            SELECT to_number(regexp_substr(csbCOD_TIPO_TRAB_MANT,'[^,]+', 1,LEVEL))
                                            FROM dual
                                            CONNECT BY regexp_substr(csbCOD_TIPO_TRAB_MANT, '[^,]+', 1, LEVEL) IS NOT NULL
                                        )
                    GROUP BY IF_MAINTENANCE.ORDER_ID
                    ORDER BY 1 ASC);

        /*Trae la informacion del equipo*/
        CURSOR CUEXISTEORDEN (
            INUID_CONTRATISTA   GE_CONTRATISTA.ID_CONTRATISTA%TYPE)
        IS
            SELECT *
              FROM (  SELECT GE_ITEMS_SERIADO.SERIE        "CODIGO",
                             DAGE_ITEMS.FSBGETDESCRIPTION (
                                 GE_ITEMS_SERIADO.ITEMS_ID,
                                 NULL)                     "INSTRUMENTO",
                             GE_ITEMS_TIPO_AT_VAL.VALOR    "RANGO",
                             DAGE_CONTRATISTA.FSBGETDESCRIPCION (
                                 DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID (
                                     DAOR_ORDER.FNUGETOPERATING_UNIT_ID (
                                         IF_MAINTENANCE.ORDER_ID,
                                         NULL),
                                     NULL),
                                 NULL)                     "CONTRATISTA",
                             DAGE_CONTRATISTA.FSBGETCORREO_ELECTRONICO (
                                 DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID (
                                     DAOR_ORDER.FNUGETOPERATING_UNIT_ID (
                                         IF_MAINTENANCE.ORDER_ID,
                                         NULL),
                                     NULL),
                                 NULL)                     "CORREO",
                             DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID (
                                 DAOR_ORDER.FNUGETOPERATING_UNIT_ID (
                                     IF_MAINTENANCE.ORDER_ID,
                                     NULL),
                                 NULL)                     "CODIGO_CONTRATISTA"
                        FROM IF_MAINT_ITEMSER,
                             IF_MAINTENANCE,
                             GE_ITEMS_SERIADO,
                             GE_ITEMS_TIPO_AT_VAL,
                             GE_ITEMS_TIPO_ATR,
                             OR_ITEM_PATTERN
                       WHERE     IF_MAINTENANCE.MAINTENANCE_CONF_ID =
                                 IF_MAINT_ITEMSER.MAINT_ITEMSER_ID
                             AND IF_MAINTENANCE.ENTITY_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ENTI_ITEM_SERI')
                             AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
                                 IF_MAINTENANCE.EXTERNAL_ID
                             AND OR_ITEM_PATTERN.ID_ITEMS_SERIADO =
                                 GE_ITEMS_SERIADO.ID_ITEMS_SERIADO
                             AND ABS (
                                       TRUNC (SYSDATE)
                                     - TRUNC (OR_ITEM_PATTERN.VALID_UNTIL)) =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_MANT')
                             AND IF_MAINTENANCE.MAINTENANCE_STATUS IN
                             (
                                SELECT to_number(regexp_substr(csbCOD_ESTA_MANT,'[^,]+', 1,LEVEL))
                                FROM dual
                                CONNECT BY regexp_substr(csbCOD_ESTA_MANT, '[^,]+', 1, LEVEL) IS NOT NULL
                             )
                             AND GE_ITEMS_SERIADO.ITEMS_ID =
                                 GE_ITEMS_TIPO_AT_VAL.ITEMS_ID
                             AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_TIPO_ATR =
                                 GE_ITEMS_TIPO_ATR.ID_ITEMS_TIPO_ATR
                             AND GE_ITEMS_TIPO_ATR.ENTITY_ATTRIBUTE_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ATRI_RANGO')
                             AND DAOR_ORDER.FNUGETTASK_TYPE_ID (
                                     IF_MAINTENANCE.ORDER_ID) IN
                                     (                                        
                                        SELECT to_number(regexp_substr(csbCOD_TIPO_TRAB_MANT,'[^,]+', 1,LEVEL))
                                        FROM dual
                                        CONNECT BY regexp_substr(csbCOD_TIPO_TRAB_MANT, '[^,]+', 1, LEVEL) IS NOT NULL
                                     )
                             AND DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID (
                                     DAOR_ORDER.FNUGETOPERATING_UNIT_ID (
                                         IF_MAINTENANCE.ORDER_ID,
                                         NULL),
                                     NULL) =
                                 INUID_CONTRATISTA
                    GROUP BY GE_ITEMS_SERIADO.SERIE,
                             DAGE_ITEMS.FSBGETDESCRIPTION (
                                 GE_ITEMS_SERIADO.ITEMS_ID,
                                 NULL),
                             GE_ITEMS_TIPO_AT_VAL.VALOR,
                             DAGE_CONTRATISTA.FSBGETDESCRIPCION (
                                 DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID (
                                     DAOR_ORDER.FNUGETOPERATING_UNIT_ID (
                                         IF_MAINTENANCE.ORDER_ID,
                                         NULL),
                                     NULL),
                                 NULL),
                             DAGE_CONTRATISTA.FSBGETCORREO_ELECTRONICO (
                                 DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID (
                                     DAOR_ORDER.FNUGETOPERATING_UNIT_ID (
                                         IF_MAINTENANCE.ORDER_ID,
                                         NULL),
                                     NULL),
                                 NULL),
                             DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID (
                                 DAOR_ORDER.FNUGETOPERATING_UNIT_ID (
                                     IF_MAINTENANCE.ORDER_ID,
                                     NULL),
                                 NULL)
                    ORDER BY 6 DESC);

    BEGIN
        pkg_Traza.Trace ('Inicio LDC_BOMETROLOGICAL.PrcVencFechMantemiento',
                         10);

        NULL;

        pkg_Traza.Trace ('Fin LDC_BOMETROLOGICAL.PrcVencFechMantemiento', 10);
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            gw_boerrors.checkerror (SQLCODE, SQLERRM);
    END PrcVencFechMantemiento;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : PrcVencFechCaliPatron1
    Descripcion    : Valida con dias de anticipacion la fecha de
                     vencimiento de calibracion de los equipos patrones.
                     para esta calibracion de equipos patrones se utilizara
                     una cantidad de dias mayoor a validar la fecha de vencimiento
                     a la configurada del parametro para PrcVencFechCaliPatron2
    Autor          : Jorge Valiente
    Fecha          : 25/05/2013

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    22-11-2016       lfvalencia         Se modifica el cursor CUCONTRATISTAS para
                                        validar que el campo VALID_UNTIL sea mayor
                                        que la fecha actual del sistema.
    22-11-2014       paulaag [NC 3820]  Se modifica el cursor CUEXISTEORDEN para corregir el valor del
                                        RANGO y adicionar el nombre de UO.
    ******************************************************************/
    PROCEDURE PrcVencFechCaliPatron1
    IS
        CURSOR CUCONTRATISTAS IS
            SELECT *
              FROM (  SELECT DISTINCT
                             (DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                  GE_ITEMS_SERIADO.ID_ITEMS_SERIADO))    "UNIDAD_TRABAJO"
                        FROM IF_MAINT_ITEMSER,
                             IF_MAINTENANCE,
                             GE_ITEMS_SERIADO,
                             GE_ITEMS_TIPO_AT_VAL,
                             GE_ITEMS_TIPO_ATR,
                             OR_ITEM_PATTERN
                       WHERE     IF_MAINTENANCE.MAINTENANCE_CONF_ID =
                                 IF_MAINT_ITEMSER.MAINT_ITEMSER_ID
                             AND IF_MAINTENANCE.ENTITY_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ENTI_ITEM_SERI')
                             AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
                                 IF_MAINTENANCE.EXTERNAL_ID
                             AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
                                 OR_ITEM_PATTERN.ID_ITEMS_SERIADO
                             AND OR_ITEM_PATTERN.VALID_UNTIL > SYSDATE
                             AND ABS (
                                       TRUNC (OR_ITEM_PATTERN.VALID_UNTIL)
                                     - TRUNC (SYSDATE)) =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_MANT_P1')
                             AND IF_MAINTENANCE.MAINTENANCE_STATUS IN
                             (
                                SELECT to_number(regexp_substr(csbCOD_ESTA_MANT,'[^,]+', 1,LEVEL))
                                FROM dual
                                CONNECT BY regexp_substr(csbCOD_ESTA_MANT, '[^,]+', 1, LEVEL) IS NOT NULL
                             )
                             AND GE_ITEMS_SERIADO.ITEMS_ID =
                                 GE_ITEMS_TIPO_AT_VAL.ITEMS_ID
                             AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_SERIADO =
                                 GE_ITEMS_SERIADO.ID_ITEMS_SERIADO
                             AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_TIPO_ATR =
                                 GE_ITEMS_TIPO_ATR.ID_ITEMS_TIPO_ATR
                             AND GE_ITEMS_TIPO_ATR.ENTITY_ATTRIBUTE_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ATRI_RANGO')
                             AND GE_ITEMS_SERIADO.OPERATING_UNIT_ID IS NOT NULL
                             AND OR_ITEM_PATTERN.OPERATING_UNIT_ID IS NOT NULL
                    GROUP BY GE_ITEMS_SERIADO.ID_ITEMS_SERIADO
                    ORDER BY 1 ASC)
            UNION
            SELECT DISTINCT a.operating_unit_id     UNIDAD_TRABAJO
              FROM GE_ITEMS_SERIADO a, OR_ITEM_PATTERN b
             WHERE     propiedad = 'T'
                   AND a.id_items_seriado = b.id_items_seriado
                   AND b.VALID_UNTIL > SYSDATE
                   AND ABS (TRUNC (b.VALID_UNTIL) - TRUNC (SYSDATE)) =
                       pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_MANT_P1')
                   AND NOT EXISTS
                           (SELECT 'x'
                              FROM IF_MAINTENANCE c
                             WHERE c.external_id = a.id_items_seriado); /*Se adicionan los equipos de TERCEROS*/

        CURSOR CUEXISTEORDEN (
            INUID_CONTRATISTA   GE_CONTRATISTA.ID_CONTRATISTA%TYPE)
        IS
            SELECT *
              FROM (  SELECT DISTINCT
                             GE_ITEMS_SERIADO.SERIE
                                 "CODIGO",
                             DAGE_ITEMS.FSBGETDESCRIPTION (
                                 GE_ITEMS_SERIADO.ITEMS_ID,
                                 NULL)
                                 "INSTRUMENTO",
                             GE_ITEMS_TIPO_AT_VAL.VALOR
                                 "RANGO",
                             -- obtiene el Nombre UO
                             DAOR_OPERATING_UNIT.FSBGETNAME (
                                 DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                     GE_ITEMS_SERIADO.ID_ITEMS_SERIADO))
                                 "NOM_U_OPERATIVA",
                             DAGE_ORGANIZAT_AREA.FSBGETNAME_ (
                                 DAOR_OPERATING_UNIT.FNUGETORGA_AREA_ID (
                                     DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                         GE_ITEMS_SERIADO.ID_ITEMS_SERIADO,
                                         NULL),
                                     NULL))
                                 "AREA_ORGANIZACIONAL",
                             DAGE_PERSON.FSBGETE_MAIL (
                                 DAOR_OPERATING_UNIT.FNUGETPERSON_IN_CHARGE (
                                     DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                         GE_ITEMS_SERIADO.ID_ITEMS_SERIADO)),
                                 NULL)
                                 "CORREO",
                                -- obtiene la UO
                                (open.DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                     GE_ITEMS_SERIADO.ID_ITEMS_SERIADO,
                                     NULL))
                             || '-'
                             || (OPEN.DAOR_OPERATING_UNIT.FSBGETNAME (
                                     open.DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                         GE_ITEMS_SERIADO.ID_ITEMS_SERIADO,
                                         NULL),
                                     NULL))
                                 "UNIDAD_TRABAJO"
                        FROM IF_MAINT_ITEMSER,
                             IF_MAINTENANCE,
                             GE_ITEMS_SERIADO,
                             GE_ITEMS_TIPO_AT_VAL,
                             GE_ITEMS_TIPO_ATR,
                             OR_ITEM_PATTERN
                       WHERE     IF_MAINTENANCE.MAINTENANCE_CONF_ID =
                                 IF_MAINT_ITEMSER.MAINT_ITEMSER_ID
                             AND IF_MAINTENANCE.ENTITY_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ENTI_ITEM_SERI')
                             AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
                                 IF_MAINTENANCE.EXTERNAL_ID
                             AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
                                 OR_ITEM_PATTERN.ID_ITEMS_SERIADO
                             AND OR_ITEM_PATTERN.VALID_UNTIL > SYSDATE
                             AND ABS (
                                       TRUNC (OR_ITEM_PATTERN.VALID_UNTIL)
                                     - TRUNC (SYSDATE)) =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_MANT_P1')
                             AND IF_MAINTENANCE.MAINTENANCE_STATUS IN
                             (
                                SELECT to_number(regexp_substr(csbCOD_ESTA_MANT,'[^,]+', 1,LEVEL))
                                FROM dual
                                CONNECT BY regexp_substr(csbCOD_ESTA_MANT, '[^,]+', 1, LEVEL) IS NOT NULL
                             )
                             AND GE_ITEMS_SERIADO.ITEMS_ID =
                                 GE_ITEMS_TIPO_AT_VAL.ITEMS_ID
                             AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_TIPO_ATR =
                                 GE_ITEMS_TIPO_ATR.ID_ITEMS_TIPO_ATR
                             AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_SERIADO =
                                 GE_ITEMS_SERIADO.ID_ITEMS_SERIADO
                             AND GE_ITEMS_TIPO_ATR.ENTITY_ATTRIBUTE_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ATRI_RANGO')
                             AND (DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                      GE_ITEMS_SERIADO.ID_ITEMS_SERIADO)) =
                                 INUID_CONTRATISTA
                             AND OR_ITEM_PATTERN.OPERATING_UNIT_ID IS NOT NULL
                    ORDER BY 1 DESC)
            UNION
            (SELECT DISTINCT
                    a.SERIE
                        "CODIGO",
                    DAGE_ITEMS.FSBGETDESCRIPTION (a.ITEMS_ID, NULL)
                        "INSTRUMENTO",                                      --
                    c.VALOR
                        "RANGO",
                    DAOR_OPERATING_UNIT.FSBGETNAME (
                        DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                            a.ID_ITEMS_SERIADO))
                        "NOM_U_OPERATIVA",
                    DAGE_ORGANIZAT_AREA.FSBGETNAME_ (
                        DAOR_OPERATING_UNIT.FNUGETORGA_AREA_ID (
                            DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                a.ID_ITEMS_SERIADO,
                                NULL),
                            NULL))
                        "AREA_ORGANIZACIONAL",
                    DAGE_PERSON.FSBGETE_MAIL (
                        DAOR_OPERATING_UNIT.FNUGETPERSON_IN_CHARGE (
                            DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                a.ID_ITEMS_SERIADO)),
                        NULL)
                        "CORREO",
                       (open.DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                            a.ID_ITEMS_SERIADO,
                            NULL))
                    || '-'
                    || (OPEN.DAOR_OPERATING_UNIT.FSBGETNAME (
                            open.DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                a.ID_ITEMS_SERIADO,
                                NULL),
                            NULL))
                        "UNIDAD_TRABAJO"
               FROM GE_ITEMS_SERIADO      a,
                    OR_ITEM_PATTERN       b,
                    GE_ITEMS_TIPO_AT_VAL  c,
                    GE_ITEMS_TIPO_ATR     d
              WHERE     propiedad = 'T'
                    AND a.id_items_seriado = b.id_items_seriado
                    AND b.VALID_UNTIL > SYSDATE
                    AND ABS (TRUNC (b.VALID_UNTIL) - TRUNC (SYSDATE)) =
                        pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_MANT_P1')
                    AND NOT EXISTS
                            (SELECT 'x'
                               FROM IF_MAINTENANCE c
                              WHERE c.external_id = a.id_items_seriado)
                    AND a.ITEMS_ID = c.ITEMS_ID
                    AND c.ID_ITEMS_SERIADO = a.ID_ITEMS_SERIADO
                    AND c.ID_ITEMS_TIPO_ATR = d.ID_ITEMS_TIPO_ATR
                    AND d.ENTITY_ATTRIBUTE_ID =
                        pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ATRI_RANGO')
                    AND (DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                             a.ID_ITEMS_SERIADO)) =
                        INUID_CONTRATISTA);

        sbMensaje1               VARCHAR2 (4000);
        sbMensaje2               VARCHAR2 (4000);

        SBAREA_ORGANIZACIONNAL   GE_ORGANIZAT_AREA.NAME_%TYPE;
        NUCANTIDAD               NUMBER;

        sbEmail                  GE_CONTRATISTA.CORREO_ELECTRONICO%TYPE;
        
        sbAsunto                 VARCHAR2(2000);
        
    BEGIN
        pkg_Traza.Trace ('Inicio LDC_BOMETROLOGICAL.PrcVencFechCaliPatron1',
                         10);

        sbMensaje1 := NULL;
        sbMensaje2 := NULL;

        FOR TEMPCUCONTRATISTAS IN CUCONTRATISTAS
        LOOP
            NUCANTIDAD := 0;

            FOR TEMPCUEXISTEORDEN
                IN CUEXISTEORDEN (TEMPCUCONTRATISTAS.UNIDAD_TRABAJO)
            LOOP
                sbMensaje2 :=
                       sbMensaje2
                    || '<tr> <td>'
                    || TEMPCUEXISTEORDEN.CODIGO
                    || '</td> <td>'
                    || TEMPCUEXISTEORDEN.INSTRUMENTO
                    || '</td> <td>'
                    || TEMPCUEXISTEORDEN.RANGO
                    || '</td> <td>'
                    || TEMPCUEXISTEORDEN.UNIDAD_TRABAJO
                    || '</td> </tr>';

                sbEmail := TEMPCUEXISTEORDEN.CORREO;
                SBAREA_ORGANIZACIONNAL :=
                    TEMPCUEXISTEORDEN.AREA_ORGANIZACIONAL;
                NUCANTIDAD := NUCANTIDAD + 1;
            END LOOP;

            sbMensaje1 :=
                   'El programa de aseguramiento metrologico indica que a la fecha '
                || TO_CHAR (SYSDATE, 'DD/MON/YYYY')
                || ' la unidad operativa ['
                || DAOR_OPERATING_UNIT.FSBGETNAME (
                       TEMPCUCONTRATISTAS.UNIDAD_TRABAJO,
                       NULL)
                || '] tiene '
                || NUCANTIDAD
                || ' equipo(s) o instrumento(s) (items seriados) que les falta '
                || pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_MANT_P1')
                || ' dias por vencer la fecha de calibracion. <P>'
                || '<table BORDER="1"> <tr BGCOLOR="gray"> <th>'
                || 'SERIE </th> <th>'
                || 'INSTRUMENTO </th> <th>'
                || 'RANGO </th> <th>'
                || 'UNIDAD OPERATIVA </th> </tr>';

            IF sbEmail IS NULL
            THEN
                sbEmail :=
                    csbEMAIL_ERROR_METR;
                sbMensaje1 :=
                       'Los siguientes datos no pudieron ser enviados: <P>'
                    || sbMensaje1
                    || sbMensaje2
                    || '  </table>';
                    
                    sbAsunto := 'CORREO INVALIDO UNIDAD OPERATIVA ['
                    || DAOR_OPERATING_UNIT.FSBGETNAME (
                           TEMPCUCONTRATISTAS.UNIDAD_TRABAJO,
                           NULL)
                    || '] VENCIMIENTO DE FECHAS LIMITE PARA CALIBRACION DE PATRONES';

                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => gsbRemitente,
                        isbDestinatarios    => sbEmail,
                        isbAsunto           => sbAsunto,
                        isbMensaje          => sbMensaje1
                    );                    

            ELSE
                IF sbMensaje2 IS NOT NULL
                THEN
                    sbMensaje1 := sbMensaje1 || sbMensaje2 || '  </table>';
                                                               
                    sbAsunto := 'VENCIMIENTO DE FECHAS LIMITE PARA CALIBRACION DE PATRONES DEL LABORATORIO EN '
                        || pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_MANT_P1')
                        || ' DIAS';

                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => gsbRemitente,
                        isbDestinatarios    => sbEmail,
                        isbAsunto           => sbAsunto,
                        isbMensaje          => sbMensaje1
                    );    
                        
                END IF;
            END IF;

            sbMensaje1 := NULL;
            sbMensaje2 := NULL;
        END LOOP;

        pkg_Traza.Trace ('Fin LDC_BOMETROLOGICAL.PrcVencFechCaliPatron1', 10);
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            gw_boerrors.checkerror (SQLCODE, SQLERRM);
    END PrcVencFechCaliPatron1;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : PrcVencFechCaliPatron2
    Descripcion    : Valida con dias de anticipacion la fecha de
                     vencimiento de calibracion de los equipos patrones.
                     para esta calibracion de equipos patrones se utilizara
                     una cantidad de dias menor a validar la fecha de vencimiento
                     a la configurada del parametro para PrcVencFechCaliPatron1
    Autor          : Jorge Valiente
    Fecha          : 25/05/2013

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    22-11-2016       lfvalencia         Se modifica el cursor CUCONTRATISTAS para
                                        validar que el campo VALID_UNTIL sea mayor
                                        que la fecha actual del sistema.
    22-11-2014      paulaag NC [3820]   Se modifica el cursor CUEXISTEORDEN para:
                                          -Adicionar el campo UNIDAD_TRABAJO
                                          -Obtener correctamente el valor del RANGO
    ******************************************************************/
    PROCEDURE PrcVencFechCaliPatron2
    IS
        CURSOR CUCONTRATISTAS IS
            SELECT *
              FROM (  SELECT DISTINCT
                             (DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                  GE_ITEMS_SERIADO.ID_ITEMS_SERIADO))    "UNIDAD_TRABAJO"
                        FROM IF_MAINT_ITEMSER,
                             IF_MAINTENANCE,
                             GE_ITEMS_SERIADO,
                             GE_ITEMS_TIPO_AT_VAL,
                             GE_ITEMS_TIPO_ATR,
                             OR_ITEM_PATTERN
                       WHERE     IF_MAINTENANCE.MAINTENANCE_CONF_ID =
                                 IF_MAINT_ITEMSER.MAINT_ITEMSER_ID
                             AND IF_MAINTENANCE.ENTITY_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ENTI_ITEM_SERI')
                             AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
                                 IF_MAINTENANCE.EXTERNAL_ID
                             AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
                                 OR_ITEM_PATTERN.ID_ITEMS_SERIADO
                             AND OR_ITEM_PATTERN.VALID_UNTIL > SYSDATE
                             AND ABS (
                                       TRUNC (OR_ITEM_PATTERN.VALID_UNTIL)
                                     - TRUNC (SYSDATE)) =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_MANT_P2')
                             AND IF_MAINTENANCE.MAINTENANCE_STATUS IN
                             (
                                SELECT to_number(regexp_substr(csbCOD_ESTA_MANT,'[^,]+', 1,LEVEL))
                                FROM dual
                                CONNECT BY regexp_substr(csbCOD_ESTA_MANT, '[^,]+', 1, LEVEL) IS NOT NULL
                             )
                             AND GE_ITEMS_SERIADO.ITEMS_ID =
                                 GE_ITEMS_TIPO_AT_VAL.ITEMS_ID
                             AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_SERIADO =
                                 GE_ITEMS_SERIADO.ID_ITEMS_SERIADO
                             AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_TIPO_ATR =
                                 GE_ITEMS_TIPO_ATR.ID_ITEMS_TIPO_ATR
                             AND GE_ITEMS_TIPO_ATR.ENTITY_ATTRIBUTE_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ATRI_RANGO')
                             AND GE_ITEMS_SERIADO.OPERATING_UNIT_ID IS NOT NULL
                             AND OR_ITEM_PATTERN.OPERATING_UNIT_ID IS NOT NULL
                    GROUP BY GE_ITEMS_SERIADO.ID_ITEMS_SERIADO
                    ORDER BY 1 ASC)
            UNION
            SELECT DISTINCT a.operating_unit_id
              FROM GE_ITEMS_SERIADO a, OR_ITEM_PATTERN b
             WHERE     propiedad = 'T'
                   AND a.id_items_seriado = b.id_items_seriado
                   AND b.VALID_UNTIL > SYSDATE
                   AND ABS (TRUNC (b.VALID_UNTIL) - TRUNC (SYSDATE)) =
                       pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_MANT_P2')
                   AND NOT EXISTS
                           (SELECT 'x'
                              FROM IF_MAINTENANCE c
                             WHERE c.external_id = a.id_items_seriado);

        CURSOR CUEXISTEORDEN (
            INUID_CONTRATISTA   GE_CONTRATISTA.ID_CONTRATISTA%TYPE)
        IS
            SELECT *
              FROM (  SELECT GE_ITEMS_SERIADO.SERIE
                                 "CODIGO",
                             DAGE_ITEMS.FSBGETDESCRIPTION (
                                 GE_ITEMS_SERIADO.ITEMS_ID,
                                 NULL)
                                 "INSTRUMENTO",
                             GE_ITEMS_TIPO_AT_VAL.VALOR
                                 "RANGO",
                             DAGE_ORGANIZAT_AREA.FSBGETNAME_ (
                                 DAOR_OPERATING_UNIT.FNUGETORGA_AREA_ID (
                                     DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                         GE_ITEMS_SERIADO.ID_ITEMS_SERIADO,
                                         NULL),
                                     NULL))
                                 "AREA_ORGANIZACIONAL",
                             DAGE_PERSON.FSBGETE_MAIL (
                                 DAOR_OPERATING_UNIT.FNUGETPERSON_IN_CHARGE (
                                     DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                         GE_ITEMS_SERIADO.ID_ITEMS_SERIADO)),
                                 NULL)
                                 "CORREO",
                                -- obtiene la UO
                                (open.DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                     GE_ITEMS_SERIADO.ID_ITEMS_SERIADO,
                                     NULL))
                             || '-'
                             || (OPEN.DAOR_OPERATING_UNIT.FSBGETNAME (
                                     open.DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                         GE_ITEMS_SERIADO.ID_ITEMS_SERIADO,
                                         NULL),
                                     NULL))
                                 "UNIDAD_TRABAJO"
                        FROM IF_MAINT_ITEMSER,
                             IF_MAINTENANCE,
                             GE_ITEMS_SERIADO,
                             GE_ITEMS_TIPO_AT_VAL,
                             GE_ITEMS_TIPO_ATR,
                             OR_ITEM_PATTERN
                       WHERE     IF_MAINTENANCE.MAINTENANCE_CONF_ID =
                                 IF_MAINT_ITEMSER.MAINT_ITEMSER_ID
                             AND IF_MAINTENANCE.ENTITY_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ENTI_ITEM_SERI')
                             AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
                                 IF_MAINTENANCE.EXTERNAL_ID
                             AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
                                 OR_ITEM_PATTERN.ID_ITEMS_SERIADO
                             AND OR_ITEM_PATTERN.VALID_UNTIL > SYSDATE
                             AND ABS (
                                       TRUNC (OR_ITEM_PATTERN.VALID_UNTIL)
                                     - TRUNC (SYSDATE)) =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_MANT_P2')
                             AND IF_MAINTENANCE.MAINTENANCE_STATUS IN
                             (
                                SELECT to_number(regexp_substr(csbCOD_ESTA_MANT,'[^,]+', 1,LEVEL))
                                FROM dual
                                CONNECT BY regexp_substr(csbCOD_ESTA_MANT, '[^,]+', 1, LEVEL) IS NOT NULL
                             )
                             AND GE_ITEMS_SERIADO.ITEMS_ID =
                                 GE_ITEMS_TIPO_AT_VAL.ITEMS_ID
                             AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_TIPO_ATR =
                                 GE_ITEMS_TIPO_ATR.ID_ITEMS_TIPO_ATR
                             AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_SERIADO =
                                 GE_ITEMS_SERIADO.ID_ITEMS_SERIADO
                             AND GE_ITEMS_TIPO_ATR.ENTITY_ATTRIBUTE_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ATRI_RANGO')
                             AND (DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                      GE_ITEMS_SERIADO.ID_ITEMS_SERIADO)) =
                                 INUID_CONTRATISTA
                             AND OR_ITEM_PATTERN.OPERATING_UNIT_ID IS NOT NULL
                    GROUP BY GE_ITEMS_SERIADO.SERIE,
                             DAGE_ITEMS.FSBGETDESCRIPTION (
                                 GE_ITEMS_SERIADO.ITEMS_ID,
                                 NULL),
                             GE_ITEMS_TIPO_AT_VAL.VALOR,
                             DAGE_ORGANIZAT_AREA.FSBGETNAME_ (
                                 DAOR_OPERATING_UNIT.FNUGETORGA_AREA_ID (
                                     DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                         GE_ITEMS_SERIADO.ID_ITEMS_SERIADO,
                                         NULL),
                                     NULL)),
                             DAGE_PERSON.FSBGETE_MAIL (
                                 DAOR_OPERATING_UNIT.FNUGETPERSON_IN_CHARGE (
                                     DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                         GE_ITEMS_SERIADO.ID_ITEMS_SERIADO)),
                                 NULL),
                             open.DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                 GE_ITEMS_SERIADO.ID_ITEMS_SERIADO,
                                 NULL)
                    ORDER BY 1 DESC)
            UNION
            (SELECT DISTINCT
                    a.SERIE
                        "CODIGO",
                    DAGE_ITEMS.FSBGETDESCRIPTION (a.ITEMS_ID, NULL)
                        "INSTRUMENTO",
                    c.VALOR
                        "RANGO",
                    DAGE_ORGANIZAT_AREA.FSBGETNAME_ (
                        DAOR_OPERATING_UNIT.FNUGETORGA_AREA_ID (
                            DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                a.ID_ITEMS_SERIADO,
                                NULL),
                            NULL))
                        "AREA_ORGANIZACIONAL",
                    DAGE_PERSON.FSBGETE_MAIL (
                        DAOR_OPERATING_UNIT.FNUGETPERSON_IN_CHARGE (
                            DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                a.ID_ITEMS_SERIADO)),
                        NULL)
                        "CORREO",
                       (open.DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                            a.ID_ITEMS_SERIADO,
                            NULL))
                    || '-'
                    || (OPEN.DAOR_OPERATING_UNIT.FSBGETNAME (
                            open.DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                a.ID_ITEMS_SERIADO,
                                NULL),
                            NULL))
                        "UNIDAD_TRABAJO"
               FROM GE_ITEMS_SERIADO      a,
                    OR_ITEM_PATTERN       b,
                    GE_ITEMS_TIPO_AT_VAL  c,
                    GE_ITEMS_TIPO_ATR     d
              WHERE     propiedad = 'T'
                    AND a.id_items_seriado = b.id_items_seriado
                    AND b.VALID_UNTIL > SYSDATE
                    AND ABS (TRUNC (b.VALID_UNTIL) - TRUNC (SYSDATE)) =
                        pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_MANT_P2')
                    AND NOT EXISTS
                            (SELECT 'x'
                               FROM IF_MAINTENANCE c
                              WHERE c.external_id = a.id_items_seriado)
                    AND a.ITEMS_ID = c.ITEMS_ID
                    AND c.ID_ITEMS_SERIADO = a.ID_ITEMS_SERIADO
                    AND c.ID_ITEMS_TIPO_ATR = d.ID_ITEMS_TIPO_ATR
                    AND d.ENTITY_ATTRIBUTE_ID =
                        pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ATRI_RANGO')
                    AND (DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                             a.ID_ITEMS_SERIADO)) =
                        INUID_CONTRATISTA);


        sbMensaje1               VARCHAR2 (4000);
        sbMensaje2               VARCHAR2 (4000);

        SBAREA_ORGANIZACIONNAL   GE_ORGANIZAT_AREA.NAME_%TYPE;
        NUCANTIDAD               NUMBER;

        sbEmail                  GE_CONTRATISTA.CORREO_ELECTRONICO%TYPE;
        
        sbAsunto                 VARCHAR2(2000);
        
    BEGIN
        pkg_Traza.Trace ('Inicio LDC_BOMETROLOGICAL.PrcVencFechCaliPatron2',
                         10);

        sbMensaje1 := NULL;
        sbMensaje2 := NULL;

        FOR TEMPCUCONTRATISTAS IN CUCONTRATISTAS
        LOOP
            NUCANTIDAD := 0;

            FOR TEMPCUEXISTEORDEN
                IN CUEXISTEORDEN (TEMPCUCONTRATISTAS.UNIDAD_TRABAJO)
            LOOP
                sbMensaje2 :=
                       sbMensaje2
                    || '<tr> <td>'
                    || TEMPCUEXISTEORDEN.CODIGO
                    || '</td> <td>'
                    || TEMPCUEXISTEORDEN.INSTRUMENTO
                    || '</td> <td>'
                    || TEMPCUEXISTEORDEN.RANGO
                    || '</td> <td>'
                    || TEMPCUEXISTEORDEN.UNIDAD_TRABAJO
                    || '</td> </tr>';

                sbEmail := TEMPCUEXISTEORDEN.CORREO;
                SBAREA_ORGANIZACIONNAL :=
                    TEMPCUEXISTEORDEN.AREA_ORGANIZACIONAL;
                NUCANTIDAD := NUCANTIDAD + 1;
            END LOOP;

            sbMensaje1 :=
                   'El programa de aseguramiento metrologico indica que a la fecha '
                || TO_CHAR (SYSDATE, 'DD/MON/YYYY')
                || ' la unidad operativa ['
                || DAOR_OPERATING_UNIT.FSBGETNAME (
                       TEMPCUCONTRATISTAS.UNIDAD_TRABAJO,
                       NULL)
                || '] tiene '
                || NUCANTIDAD
                || ' equipo(s) o instrumento(s) (items seriados) que les falta '
                || pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_MANT_P2')
                || ' dias por vencer la fecha de calibracion. <P>'
                || '<table BORDER="1"> <tr BGCOLOR="gray"> <th>'
                || 'SERIE </th> <th>'
                || 'INSTRUMENTO </th> <th>'
                || 'RANGO </th> <th>'
                || 'UNIDAD OPERATIVA </th> </tr>';

            IF sbEmail IS NULL
            THEN
                sbEmail :=
                    csbEMAIL_ERROR_METR;
                sbMensaje1 :=
                       'Los siguientes datos no pudieron ser enviados: <P>'
                    || sbMensaje1
                    || sbMensaje2
                    || '  </table>';

                sbAsunto := 'CORREO INVALIDO UNIDAD OPERATIVA ['
                || DAOR_OPERATING_UNIT.FSBGETNAME (
                       TEMPCUCONTRATISTAS.UNIDAD_TRABAJO,
                       NULL)
                || '] VENCIMIENTO DE FECHAS LIMITE PARA CALIBRACION DE PATRONES';
                
                pkg_Correo.prcEnviaCorreo
                (
                    isbRemitente        => gsbRemitente,
                    isbDestinatarios    => sbEmail,
                    isbAsunto           => sbAsunto,
                    isbMensaje          => sbMensaje1
                );    

            ELSE
                IF sbMensaje2 IS NOT NULL
                THEN
                    sbMensaje1 := sbMensaje1 || sbMensaje2 || '  </table>';

                    sbAsunto := 'VENCIMIENTO DE FECHAS LIMITE PARA CALIBRACION DE PATRONES DEL LABORATORIO EN '
                            || pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_MANT_P2')
                            || ' DIAS';
                            
                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => gsbRemitente,
                        isbDestinatarios    => sbEmail,
                        isbAsunto           => sbAsunto,
                        isbMensaje          => sbMensaje1
                    );  
                    
                END IF;
            END IF;

            sbMensaje1 := NULL;
            sbMensaje2 := NULL;
        END LOOP;

        pkg_Traza.Trace ('Fin LDC_BOMETROLOGICAL.PrcVencFechCaliPatron2', 10);
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            gw_boerrors.checkerror (SQLCODE, SQLERRM);
    END PrcVencFechCaliPatron2;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : PrcOrdenAseguMetroVenc
    Descripcion    : Valida ordenes de aseeguramiento metrologico ya vencidas.
    Autor          : Jorge Valiente
    Fecha          : 25/05/2013

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE PrcOrdenAseguMetroVenc
    IS
        CURSOR CUCONTRATISTAS IS
            SELECT *
              FROM (  SELECT DISTINCT
                             (DAOR_ORDER.FNUGETOPERATING_UNIT_ID (
                                  OR_ORDER.ORDER_ID,
                                  NULL))    "UNIDAD_TRABAJO"
                        FROM IF_MAINTENANCE, OR_ORDER, OR_ITEM_PATTERN
                       WHERE     IF_MAINTENANCE.ENTITY_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ENTI_ITEM_SERI')
                             AND OR_ORDER.ORDER_ID = IF_MAINTENANCE.ORDER_ID
                             AND IF_MAINTENANCE.EXTERNAL_ID =
                                 OR_ITEM_PATTERN.ID_ITEMS_SERIADO
                             AND OR_ITEM_PATTERN.VALID_UNTIL IS NOT NULL
                             AND OR_ORDER.ORDER_STATUS_ID = 5
                             AND OR_ORDER.ASSIGNED_DATE <= SYSDATE
                             AND ABS (
                                       TRUNC (OR_ORDER.ASSIGNED_DATE)
                                     - TRUNC (SYSDATE)) >=
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_ORDE_ASEG_METR')
                             AND DAOR_ORDER_STATUS.FSBGETIS_FINAL_STATUS (
                                     OR_ORDER.ORDER_STATUS_ID) =
                                 'N'
                             AND DAOR_ORDER.FNUGETOPERATING_UNIT_ID (
                                     OR_ORDER.ORDER_ID,
                                     NULL)
                                     IS NOT NULL
                    GROUP BY OR_ORDER.ORDER_ID
                    ORDER BY 1 ASC)
            UNION
            SELECT DISTINCT a.operating_unit_id
              FROM or_order          d,
                   or_order_items    c,
                   GE_ITEMS_SERIADO  a,
                   OR_ITEM_PATTERN   b
             WHERE     propiedad = 'T'
                   AND d.ORDER_STATUS_ID = 5
                   AND d.ASSIGNED_DATE <= SYSDATE
                   AND d.order_id = c.order_id
                   AND c.items_id = a.items_id
                   AND a.id_items_seriado = b.id_items_seriado
                   AND ABS (TRUNC (d.ASSIGNED_DATE) - TRUNC (SYSDATE)) >=
                       pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_ORDE_ASEG_METR')
                   AND NOT EXISTS
                           (SELECT 'x'
                              FROM IF_MAINTENANCE c
                             WHERE c.external_id = a.id_items_seriado)
                   AND a.operating_unit_id IS NOT NULL
                   AND DAOR_ORDER_STATUS.FSBGETIS_FINAL_STATUS (
                           d.ORDER_STATUS_ID) =
                       'N';

        CURSOR CUEXISTEORDEN (
            INUID_CONTRATISTA   GE_CONTRATISTA.ID_CONTRATISTA%TYPE)
        IS
            SELECT *
              FROM (  SELECT DISTINCT
                             IF_MAINTENANCE.ORDER_ID,
                             OR_ORDER.TASK_TYPE_ID,
                             DAOR_OPERATING_UNIT.FSBGETNAME (
                                 OR_ORDER.OPERATING_UNIT_ID,
                                 NULL)                 "UNIDAD_OPERATIVA",
                             DAGE_CONTRATISTA.FSBGETDESCRIPCION (
                                 DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID (
                                     OR_ORDER.OPERATING_UNIT_ID),
                                 NULL)                 "CONTRATISTA",
                             DAGE_PERSON.FSBGETE_MAIL (
                                 DAOR_OPERATING_UNIT.FNUGETPERSON_IN_CHARGE (
                                     OR_ORDER.OPERATING_UNIT_ID),
                                 NULL)                 "CORREO",
                             OR_ORDER.ASSIGNED_DATE    "FECHA_ASIGNACION"
                        FROM IF_MAINTENANCE, OR_ORDER, OR_ITEM_PATTERN
                       WHERE     IF_MAINTENANCE.ENTITY_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ENTI_ITEM_SERI')
                             AND OR_ORDER.ORDER_ID = IF_MAINTENANCE.ORDER_ID
                             AND IF_MAINTENANCE.EXTERNAL_ID =
                                 OR_ITEM_PATTERN.ID_ITEMS_SERIADO
                             AND OR_ITEM_PATTERN.VALID_UNTIL IS NOT NULL
                             AND OR_ORDER.ORDER_STATUS_ID = 5
                             AND OR_ORDER.ASSIGNED_DATE <= SYSDATE
                             AND ABS (
                                       TRUNC (OR_ORDER.ASSIGNED_DATE)
                                     - TRUNC (SYSDATE)) >=
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_ORDE_ASEG_METR')
                             AND DAOR_ORDER_STATUS.FSBGETIS_FINAL_STATUS (
                                     OR_ORDER.ORDER_STATUS_ID) =
                                 'N'
                             AND OR_ORDER.OPERATING_UNIT_ID = INUID_CONTRATISTA
                    ORDER BY 1 DESC)
            UNION
            SELECT DISTINCT
                   d.ORDER_ID,
                   d.TASK_TYPE_ID,
                   DAOR_OPERATING_UNIT.FSBGETNAME (d.OPERATING_UNIT_ID, NULL)
                       "UNIDAD_OPERATIVA",
                   DAGE_CONTRATISTA.FSBGETDESCRIPCION (
                       DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID (
                           d.OPERATING_UNIT_ID),
                       NULL)
                       "CONTRATISTA",
                   DAGE_PERSON.FSBGETE_MAIL (
                       DAOR_OPERATING_UNIT.FNUGETPERSON_IN_CHARGE (
                           d.OPERATING_UNIT_ID),
                       NULL)
                       "CORREO",
                   d.ASSIGNED_DATE
                       "FECHA_ASIGNACION"
              FROM or_order          d,
                   or_order_items    c,
                   GE_ITEMS_SERIADO  a,
                   OR_ITEM_PATTERN   b
             WHERE     propiedad = 'T'
                   AND d.ORDER_STATUS_ID = 5
                   AND d.ASSIGNED_DATE <= SYSDATE
                   AND d.OPERATING_UNIT_ID = INUID_CONTRATISTA
                   AND d.order_id = c.order_id
                   AND c.items_id = a.items_id
                   AND a.id_items_seriado = b.id_items_seriado
                   AND ABS (TRUNC (d.ASSIGNED_DATE) - TRUNC (SYSDATE)) >=
                       pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_ORDE_ASEG_METR')
                   AND NOT EXISTS
                           (SELECT 'x'
                              FROM IF_MAINTENANCE c
                             WHERE c.external_id = a.id_items_seriado)
                   AND a.operating_unit_id IS NOT NULL
                   AND DAOR_ORDER_STATUS.FSBGETIS_FINAL_STATUS (
                           d.ORDER_STATUS_ID) =
                       'N';           /*Se adicionan los equipos de TERCEROS*/

        sbMensaje1   VARCHAR2 (32000);
        sbMensaje2   VARCHAR2 (32000);

        sbEmail      GE_CONTRATISTA.CORREO_ELECTRONICO%TYPE;
        
        sbAsunto     VARCHAR2(2000);
        
    BEGIN
        pkg_Traza.Trace ('Inicio LDC_BOMETROLOGICAL.PrcOrdenAseguMetroVenc',
                         10);

        sbMensaje1 := NULL;
        sbMensaje2 := NULL;

        FOR TEMPCUCONTRATISTAS IN CUCONTRATISTAS
        LOOP
            IF TEMPCUCONTRATISTAS.UNIDAD_TRABAJO IS NOT NULL
            THEN
                FOR TEMPCUEXISTEORDEN
                    IN CUEXISTEORDEN (TEMPCUCONTRATISTAS.UNIDAD_TRABAJO)
                LOOP
                    sbMensaje2 :=
                           sbMensaje2
                        || 'La Orden de trabajo No. '
                        || TEMPCUEXISTEORDEN.ORDER_ID
                        || ' - '
                        || DAOR_TASK_TYPE.fsbgetdescription (
                               TEMPCUEXISTEORDEN.TASK_TYPE_ID)
                        || ' asignada el dia '
                        || TO_CHAR (TEMPCUEXISTEORDEN.FECHA_ASIGNACION,
                                    'DD/MM/YYYY')
                        || ' a '
                        || TEMPCUEXISTEORDEN.UNIDAD_OPERATIVA
                        || ' se encuentra vencida. <P>';

                    sbEmail := TEMPCUEXISTEORDEN.CORREO;
                END LOOP;

                IF sbEmail IS NULL
                THEN
                    sbEmail :=
                        csbEMAIL_ERROR_METR;
                    sbMensaje1 :=
                           'Los siguientes datos no pudieron ser enviados: <P>'
                        || sbMensaje2
                        || '  </table>';

                    sbAsunto := 'CORREO INVALIDO UNIDAD OPERATIVA ['
                        || DAOR_OPERATING_UNIT.FSBGETNAME (
                               TEMPCUCONTRATISTAS.UNIDAD_TRABAJO,
                               NULL)
                        || '] ORDENES DE TRABAJO DE ASEGURAMIENTO METROLOGICO VENCIDAS';
                    
                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => gsbRemitente,
                        isbDestinatarios    => sbEmail,
                        isbAsunto           => sbAsunto,
                        isbMensaje          => sbMensaje1
                    );  

                ELSE
                    IF sbMensaje2 IS NOT NULL
                    THEN
                        sbMensaje1 := sbMensaje2 || '  </table>';
                            
                        sbAsunto := 'ORDENES DE TRABAJO DE ASEGURAMIENTO METROLOGICO ASIGNADAS';
                        
                        pkg_Correo.prcEnviaCorreo
                        (
                            isbRemitente        => gsbRemitente,
                            isbDestinatarios    => sbEmail,
                            isbAsunto           => sbAsunto,
                            isbMensaje          => sbMensaje1
                        );                              
                    END IF;
                END IF;

                sbMensaje1 := NULL;
                sbMensaje2 := NULL;
            END IF;
        END LOOP;

        pkg_Traza.Trace ('Fin LDC_BOMETROLOGICAL.PrcOrdenAseguMetroVenc', 10);
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            gw_boerrors.checkerror (SQLCODE, SQLERRM);
    END PrcOrdenAseguMetroVenc;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : PrcVencFechCaliPatron1
    Descripcion    : Valida con dias de anticipacion la fecha de
                     vencimiento de calibracion de los equipos patrones.
                     para esta calibracion de equipos patrones se utilizara
                     una cantidad de dias menor a validar la fecha de vencimiento
                     a la configurada del parametro para PrcVencFechCaliPatron1
    Autor          : Jorge Valiente
    Fecha          : 25/05/2013

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE PrcVencFechConfMetrolo
    IS
        CURSOR CUCONTRATISTAS IS
            SELECT *
              FROM (  SELECT DISTINCT
                             (DAGE_ITEMS_SERIADO.FNUGETOPERATING_UNIT_ID (
                                  GE_ITEMS_SERIADO.ID_ITEMS_SERIADO))    "UNIDAD_TRABAJO"
                        FROM IF_MAINT_ITEMSER,
                             IF_MAINTENANCE,
                             GE_ITEMS_SERIADO,
                             GE_ITEMS_TIPO_AT_VAL,
                             GE_ITEMS_TIPO_ATR,
                             OR_ITEM_PATTERN
                       WHERE     IF_MAINTENANCE.MAINTENANCE_CONF_ID =
                                 IF_MAINT_ITEMSER.MAINT_ITEMSER_ID
                             AND IF_MAINTENANCE.ENTITY_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ENTI_ITEM_SERI')
                             AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
                                 IF_MAINTENANCE.EXTERNAL_ID
                             AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
                                 OR_ITEM_PATTERN.ID_ITEMS_SERIADO
                             AND ABS (
                                       TRUNC (SYSDATE)
                                     - TRUNC (OR_ITEM_PATTERN.VALID_UNTIL)) =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_ORDE_CONF_METR')
                             AND IF_MAINTENANCE.MAINTENANCE_STATUS IN
                             (
                                SELECT to_number(regexp_substr(csbCOD_ESTA_MANT,'[^,]+', 1,LEVEL))
                                FROM dual
                                CONNECT BY regexp_substr(csbCOD_ESTA_MANT, '[^,]+', 1, LEVEL) IS NOT NULL
                             )
                             AND GE_ITEMS_SERIADO.ITEMS_ID =
                                 GE_ITEMS_TIPO_AT_VAL.ITEMS_ID
                             AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_TIPO_ATR =
                                 GE_ITEMS_TIPO_ATR.ID_ITEMS_TIPO_ATR
                             AND GE_ITEMS_TIPO_ATR.ENTITY_ATTRIBUTE_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ATRI_RANGO')
                             AND IF_MAINTENANCE.ORDER_ID IS NOT NULL
                             AND DAOR_ORDER.FNUGETTASK_TYPE_ID (
                                     IF_MAINTENANCE.ORDER_ID) IN
                                     (
                                        SELECT to_number(regexp_substr(csbCOD_TIPO_CONF_METRO,'[^,]+', 1,LEVEL))
                                        FROM dual
                                        CONNECT BY regexp_substr(csbCOD_TIPO_CONF_METRO, '[^,]+', 1, LEVEL) IS NOT NULL  
                                     )
                    ORDER BY 1 ASC)
            UNION
            --Equipos que no tiene plan de mantenimiento
            SELECT DISTINCT a.operating_unit_id
              FROM GE_ITEMS_SERIADO a, OR_ITEM_PATTERN b
             WHERE     propiedad = 'T'
                   AND a.id_items_seriado = b.id_items_seriado
                   AND ABS (TRUNC (SYSDATE) - TRUNC (b.VALID_UNTIL)) =
                       pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_ORDE_CONF_METR')
                   AND NOT EXISTS
                           (SELECT 'x'
                              FROM IF_MAINTENANCE c
                             WHERE c.external_id = a.id_items_seriado);

        /*Trae los datos del equipo*/
        CURSOR CUEXISTEORDEN (
            INUID_CONTRATISTA   GE_CONTRATISTA.ID_CONTRATISTA%TYPE)
        IS
            SELECT *
              FROM (  SELECT DISTINCT
                             GE_ITEMS_SERIADO.SERIE        "CODIGO",
                             DAGE_ITEMS.FSBGETDESCRIPTION (
                                 GE_ITEMS_SERIADO.ITEMS_ID,
                                 NULL)                     "INSTRUMENTO",
                             GE_ITEMS_TIPO_AT_VAL.VALOR    "RANGO",
                             DAGE_CONTRATISTA.FSBGETCORREO_ELECTRONICO (
                                 DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID (
                                     DAOR_ORDER.FNUGETOPERATING_UNIT_ID (
                                         IF_MAINTENANCE.ORDER_ID,
                                         NULL),
                                     NULL),
                                 NULL)                     "CORREO",
                             DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID (
                                 DAOR_ORDER.FNUGETOPERATING_UNIT_ID (
                                     IF_MAINTENANCE.ORDER_ID,
                                     NULL),
                                 NULL)                     "CODIGO_CONTRATISTA"
                        FROM IF_MAINT_ITEMSER,
                             IF_MAINTENANCE,
                             GE_ITEMS_SERIADO,
                             GE_ITEMS_TIPO_AT_VAL,
                             GE_ITEMS_TIPO_ATR,
                             OR_ITEM_PATTERN
                       WHERE     IF_MAINTENANCE.MAINTENANCE_CONF_ID =
                                 IF_MAINT_ITEMSER.MAINT_ITEMSER_ID
                             AND IF_MAINTENANCE.ENTITY_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ENTI_ITEM_SERI')
                             AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
                                 IF_MAINTENANCE.EXTERNAL_ID
                             AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
                                 OR_ITEM_PATTERN.ID_ITEMS_SERIADO
                             AND ABS (
                                       TRUNC (SYSDATE)
                                     - TRUNC (OR_ITEM_PATTERN.VALID_UNTIL)) =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_ORDE_CONF_METR')
                             AND IF_MAINTENANCE.MAINTENANCE_STATUS IN
                             (
                                SELECT to_number(regexp_substr(csbCOD_ESTA_MANT,'[^,]+', 1,LEVEL))
                                FROM dual
                                CONNECT BY regexp_substr(csbCOD_ESTA_MANT, '[^,]+', 1, LEVEL) IS NOT NULL
                             )
                             AND GE_ITEMS_SERIADO.ITEMS_ID =
                                 GE_ITEMS_TIPO_AT_VAL.ITEMS_ID
                             AND GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_TIPO_ATR =
                                 GE_ITEMS_TIPO_ATR.ID_ITEMS_TIPO_ATR
                             AND GE_ITEMS_TIPO_ATR.ENTITY_ATTRIBUTE_ID =
                                 pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_ATRI_RANGO')
                             AND IF_MAINTENANCE.ORDER_ID IS NOT NULL
                             AND DAOR_ORDER.FNUGETTASK_TYPE_ID (
                                     IF_MAINTENANCE.ORDER_ID) IN
                                     (
                                        SELECT to_number(regexp_substr(csbCOD_TIPO_CONF_METRO,'[^,]+', 1,LEVEL))
                                        FROM dual
                                        CONNECT BY regexp_substr(csbCOD_TIPO_CONF_METRO, '[^,]+', 1, LEVEL) IS NOT NULL
                                     )
                             AND DAOR_ORDER.FNUGETOPERATING_UNIT_ID (
                                     IF_MAINTENANCE.ORDER_ID,
                                     NULL) =
                                 INUID_CONTRATISTA
                    ORDER BY 1 DESC);

        sbMensaje1   VARCHAR2 (4000);
        sbMensaje2   VARCHAR2 (4000);

        NUCANTIDAD   NUMBER;

        sbEmail      GE_CONTRATISTA.CORREO_ELECTRONICO%TYPE;
        
        sbAsunto    VARCHAR2(2000);
        
    BEGIN
        pkg_Traza.Trace ('Inicio LDC_BOMETROLOGICAL.PrcVencFechConfMetrolo',
                         10);

        FOR TEMPCUCONTRATISTAS IN CUCONTRATISTAS
        LOOP
            NUCANTIDAD := 0;

            FOR TEMPCUEXISTEORDEN
                IN CUEXISTEORDEN (TEMPCUCONTRATISTAS.UNIDAD_TRABAJO)
            LOOP
                sbMensaje2 :=
                       sbMensaje2
                    || '<tr> <td>'
                    || TEMPCUEXISTEORDEN.CODIGO
                    || '</td> <td>'
                    || TEMPCUEXISTEORDEN.INSTRUMENTO
                    || '</td> <td>'
                    || TEMPCUEXISTEORDEN.RANGO
                    || '</td> </tr>';

                sbEmail := TEMPCUEXISTEORDEN.CORREO;
                NUCANTIDAD := NUCANTIDAD + 1;
            END LOOP;

            sbMensaje1 :=
                   'El programa de aseguramiento metrologico indica que a la fecha '
                || TO_CHAR (SYSDATE, 'DD/MON/YYYY')
                || ' tiene '
                || NUCANTIDAD
                || ' equipos o instrumentos que le faltan '
                || pkg_BCLD_Parameter.fnuObtieneValorNumerico ('DIAS_VENC_FECH_MANT_P1')
                || ' dia(s) por vencer la fecha de confirmacion programada. <P>'
                || '<table BORDER="1"> <tr BGCOLOR="gray"> <th>'
                || 'CODIGO </th> <th>'
                || 'INSTRUMENTO </th> <th>'
                || 'RANGO </th> </tr>';

            IF sbEmail IS NULL
            THEN
                sbEmail :=
                    csbEMAIL_ERROR_METR;
                sbMensaje1 :=
                       'Los siguientes datos no pudieron ser enviados: <P>'
                    || sbMensaje1
                    || sbMensaje2
                    || '  </table>';

                sbAsunto := 'CORREO INVALIDO UNIDAD OPERATIVA ['
                    || DAGE_CONTRATISTA.FSBGETNOMBRE_CONTRATISTA (
                           TEMPCUCONTRATISTAS.UNIDAD_TRABAJO,
                           NULL)
                    || '] CONFIRMACIONES METROLOGICAS';
                    
                pkg_Correo.prcEnviaCorreo
                (
                    isbRemitente        => gsbRemitente,
                    isbDestinatarios    => sbEmail,
                    isbAsunto           => sbAsunto,
                    isbMensaje          => sbMensaje1
                );   

            ELSE
                sbMensaje1 := sbMensaje1 || sbMensaje2 || '  </table>';

                sbAsunto := 'CONFIRMACIONES METROLOGICAS';
                
                pkg_Correo.prcEnviaCorreo
                (
                    isbRemitente        => gsbRemitente,
                    isbDestinatarios    => sbEmail,
                    isbAsunto           => sbAsunto,
                    isbMensaje          => sbMensaje1
                );   
                               
            END IF;

            sbMensaje1 := NULL;
            sbMensaje2 := NULL;
        END LOOP;

        pkg_Traza.Trace ('Fin LDC_BOMETROLOGICAL.PrcVencFechConfMetrolo', 10);
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            gw_boerrors.checkerror (SQLCODE, SQLERRM);
    END PrcVencFechConfMetrolo;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : PrcOrdenesMetrologicas
    Descripcion    : Ejecuta los procesos que permitiran identificar
                     cada una de las ordenes definidas en el plan de metrologia
    Autor          : Jorge Valiente
    Fecha          : 26/05/2013

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE PrcOrdenesMetrologicas
    IS
    BEGIN
        pkg_Traza.Trace ('Inicio LDC_BOMETROLOGICAL.PrcOrdenesMetrologicas',
                         10);

        LDC_BOMETROLOGICAL.PrcVencFechCalibracion;
        LDC_BOMETROLOGICAL.PrcVencFechCaliPatron1;
        LDC_BOMETROLOGICAL.PrcVencFechCaliPatron2;
        LDC_BOMETROLOGICAL.PrcOrdenAseguMetroVenc;

        pkg_Traza.Trace ('Fin LDC_BOMETROLOGICAL.PrcOrdenesMetrologicas', 10);
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            gw_boerrors.checkerror (SQLCODE, SQLERRM);
    END PrcOrdenesMetrologicas;
END LDC_BOMETROLOGICAL;
/

