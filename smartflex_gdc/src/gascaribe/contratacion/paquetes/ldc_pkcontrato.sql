CREATE OR REPLACE PACKAGE LDC_PKCONTRATO
AS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : LDC_PKVENTAPAGOUNICO
    Descripcion    : Paquete para el proceso de pagar? ?nico
    Autor          : Karem Baquero
    Fecha          : 09/11/2016 ERS 200-854


    Historia de Modificaciones

    Fecha         Autor          Modificacion
    =========     =========      ====================
    02/08/2021    jpinedc        OSF-1728: Se modifica PROACTUALIZACONTRATO

    14.03.2022    jgomez.OSF165  Se modifica <<PROACTUALIZACONTRATO>>

    02/08/2021    HORBATH        CA809 Se elimina la validación donde se verifica que el valor del anticipo sea igual a 0.

    ******************************************************************/
    ------------------
    -- Constantes
    ------------------
    csbYes   CONSTANT VARCHAR2 (1) := 'Y';
    csbNo    CONSTANT VARCHAR2 (1) := 'N';

    -----------------------
    -- Procesos de procedimientos y funciones
    -----------------------

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : PROACTUALIZACONTRATO
    Descripcion    : Servicio para la consultar lso datos del contrato desde CTCCO
    Autor          : Jorge Valiente
    Fecha          : 28/11/2016

    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    Fecha            Autor          Modificacion
    ==========  =================== =======================
    ******************************************************************/

    PROCEDURE PROCONSULTACONTRATO;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : PROACTUALIZACONTRATO
    Descripcion    : Servicio para la actualizar los datos del contrato desde CTCCO
    Autor          : Jorge Valiente
    Fecha          : 28/11/2016

    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    Fecha            Autor          Modificacion
    ==========  =================== =======================
    17/01/2021    OL-Software         CA418 Se adicionan los campos de area organizacional y aplica evaluación
    ******************************************************************/

    PROCEDURE PROACTUALIZACONTRATO;
END LDC_PKCONTRATO;
/

CREATE OR REPLACE PACKAGE BODY LDC_PKCONTRATO
AS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : LDC_PKCONTRATO
    Descripcion    : Paquete para el manejo de contratos
    Autor          : Jorge Valiente
    Fecha          : 09/11/2016 ERS 200-854

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor          Modificacion
    =========     =========      ====================
    14.03.2022    jgomez.OSF165  Se modifica <<PROACTUALIZACONTRATO>>
    07/02/2018    dsaltarin      ca 200 1724 se modifica el procedimiento PROACTUALIZACONTRATO

    ******************************************************************/

    ------------------
    -- Constantes
    ------------------
    -- Esta constante se debe modificar cada vez que se entregue el
    -- paquete con un SAO
    csbVersion                 CONSTANT VARCHAR2 (250) := 'CA80';

    -- Errores
    cnuErrorStatusContractor   CONSTANT NUMBER (18) := 900900;
    cnuErrorStatusContract     CONSTANT NUMBER (18) := 900899;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : PROCONSULTACONTRATO
    Descripcion    : Servicio para la consultar lso datos del contrato desde CTCCO
    Autor          : Jorge Valiente
    Fecha          : 28/11/2016

    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    Fecha            Autor          Modificacion
    ==========  =================== =======================
    ******************************************************************/

    PROCEDURE PROCONSULTACONTRATO
    IS
        CURSOR CUACTAASOCIADAS (INUCONTRATO NUMBER)
        IS
            SELECT GA.*
              FROM ge_acta ga
             WHERE     ga.Id_Contrato = INUCONTRATO
                   AND GA.ID_TIPO_ACTA IN (1, 2)
                   AND UPPER (GA.NOMBRE) LIKE '%ENTREGA DE ANTICIPO%';

        rfCUACTAASOCIADAS       CUACTAASOCIADAS%ROWTYPE;

        --Declaracion de variables.
        sbInstance              ge_boInstanceControl.stysbName;
        sbContractId            ge_boutilities.styStatement;
        nuIndex                 ge_boInstanceControl.stynuIndex;
        nuContractId            ge_contrato.id_contrato%TYPE;
        sbStatusOpen            ge_contrato.status%TYPE;
        sbStatusContract        ge_contrato.status%TYPE;

        -- Informacion del Contrato
        -- Valor Total
        nuValueTotal            ge_acta.valor_total%TYPE;
        -- Valor Anticipo
        nuValueAdvance          ge_acta.value_advance%TYPE;
        -- Fecha Inicial
        dtInitialDate           ge_acta.fecha_inicio%TYPE;
        -- Fecha Final
        dtFinalDate             ge_acta.fecha_fin%TYPE;
        -- Porcentaje de fondo de Garantia
        nuporcen_fondo_garant   ge_contrato.porcen_fondo_garant%TYPE;
        dtFechaMaximaAsig       LDC_CONTFEMA.FECHA_MAXASIG%TYPE; --Ticket 200-810 LJLB -- Se almacena fecha maxima de asigancion

        sbmensajeerror          VARCHAR2 (4000) := NULL;
        --709
        sbIncrementType         VARCHAR2 (1);
        nuOut                   NUMBER;
    BEGIN
        --Logica.
        ut_trace.trace ('INICIO LDC_PKCONTRATO.PROCONSULTACONTRATO', 10);

        --Obtiene el contrat de la instancia
        ge_boinstancecontrol.AcckeyAttributeStack ('WORK_INSTANCE',
                                                   NULL,
                                                   'GE_CONTRATO',
                                                   'ID_CONTRATO',
                                                   nuIndex);
        GE_BOInstanceControl.GetAttributeNewValue ('WORK_INSTANCE',
                                                   NULL,
                                                   'GE_CONTRATO',
                                                   'ID_CONTRATO',
                                                   sbContractId);

        nuContractId := ut_convert.fnuChartoNumber (sbContractId);

        ut_trace.trace ('Contrato[' || nuContractId || ']', 10);

        /*
        open CUACTAASOCIADAS(nuContractId);
        fetch CUACTAASOCIADAS
          into rfCUACTAASOCIADAS;
        if CUACTAASOCIADAS%found then
          ut_trace.trace('Existen Actas Invalidas Tipo Acta [1,2]', 10);
          Errors.setError(cnuErrorStatusContract,
                          'Existen Actas Invalidas Tipo Acta [1,2]');
          raise ex.CONTROLLED_ERROR;
        end if;
        close CUACTAASOCIADAS;
        --*/

        -- Obtiene identificador de Estado Abierto
        sbStatusOpen := ct_boconstants.fsbGetOpenStatus;
        ut_trace.trace ('Estado Contrato Parametro[' || sbStatusOpen || ']',
                        10);

        -- Obtiene estado actual del contrato.
        sbStatusContract := ct_bocontract.fsbGetStatusContract (nuContractId);
        ut_trace.trace ('Estado Contrato[' || sbStatusContract || ']', 10);

        -- Validar si el estado actual del contrato es Abierto
        IF sbStatusContract = sbStatusOpen
        THEN
            nuValueTotal :=
                dage_contrato.fnuGetValor_Total_Contrato (nuContractId, 0);
            nuValueAdvance :=
                dage_contrato.fnuGetValor_Anticipo (nuContractId, 0);
            dtInitialDate :=
                dage_contrato.fdtGetFecha_Inicial (nuContractId, 0);
            dtFinalDate := dage_contrato.fdtGetFecha_Final (nuContractId, 0);
            nuporcen_fondo_garant :=
                dage_contrato.fnugetporcen_fondo_garant (nuContractId, 0);
            dtFechaMaximaAsig := DALDC_CONTFEMA.fdtFechaMaxima (nuContractId); --Ticket 200-810  LJLB -- se consulta fecha maxima de asignacion

            GE_BOInstanceControl.GetCurrentInstance (sbInstance);

            ge_boInstanceControl.SetAttributeNewValue (sbInstance,
                                                       NULL,
                                                       'GE_ACTA',
                                                       'ID_CONTRATO',
                                                       nuContractId);
            ge_boInstanceControl.SetAttributeNewValue (sbInstance,
                                                       NULL,
                                                       'GE_ACTA',
                                                       'VALOR_TOTAL',
                                                       nuValueTotal);
            ge_boInstanceControl.SetAttributeNewValue (sbInstance,
                                                       NULL,
                                                       'GE_ACTA',
                                                       'VALUE_ADVANCE',
                                                       nuValueAdvance);
            ge_boInstanceControl.SetAttributeNewValue (
                sbInstance,
                NULL,
                'GE_ACTA',
                'FECHA_INICIO',
                TO_CHAR (dtInitialDate, ut_date.fsbDATE_FORMAT));
            ge_boInstanceControl.SetAttributeNewValue (
                sbInstance,
                NULL,
                'GE_ACTA',
                'FECHA_FIN',
                TO_CHAR (dtFinalDate, ut_date.fsbDATE_FORMAT));
            ge_boInstanceControl.SetAttributeNewValue (sbInstance,
                                                       NULL,
                                                       'GE_CONTRATO',
                                                       'PORCEN_FONDO_GARANT',
                                                       nuporcen_fondo_garant);

            --TICKET 810 LJLB -- se setea valor de fecha maxima de asigancion
            ge_boInstanceControl.SetAttributeNewValue (sbInstance,
                                                       NULL,
                                                       'LDC_CONTFEMA',
                                                       'FECHA_MAXASIG',
                                                       dtFechaMaximaAsig);

            IF fblaplicaentregaxcaso ('0000709')
            THEN
                sbIncrementType :=
                    daldc_tipoinc_bycon.fsbgetincrement_type (nuContractId,
                                                              NULL);

                IF sbIncrementType IS NOT NULL
                THEN
                    IF sbIncrementType = 'I'
                    THEN
                        sbIncrementType := 1;
                    ELSIF sbIncrementType = 'S'
                    THEN
                        sbIncrementType := 2;
                    ELSIF sbIncrementType = 'N'
                    THEN
                        sbIncrementType := 3;
                    ELSIF sbIncrementType = 'O'
                    THEN
                        sbIncrementType := 4;
                    END IF;

                    IF ge_boinstancecontrol.fblacckeyentitystack (
                           sbInstance,
                           NULL,
                           'LDC_TIPOINC_BYCON',
                           nuOut)
                    THEN
                        ge_boInstanceControl.SetAttributeNewValue (
                            sbInstance,
                            NULL,
                            'LDC_TIPOINC_BYCON',
                            'INCREMENT_TYPE',
                            sbIncrementType);
                    END IF;
                END IF;
            END IF;
        ELSE
            ut_trace.trace (
                'Error - El estado del contrato no es valido para la ejecucion del Acta de Modificacion',
                10);
            Errors.setError (
                cnuErrorStatusContract,
                   ct_boconstants.fsbGetDescStatus (sbStatusOpen)
                || '|'
                || ct_boconstants.fsbGetDescCertificateType (
                       ct_boconstants.fnugetChangeCertiType));
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        ut_trace.trace ('FIN CT_BoFWCertificate.ValidateChangeContract', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            ut_trace.trace (
                'ERROR - CONTROLLED_ERROR LDC_PKCONTRATO.PROCONSULTACONTRATO',
                10);
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            ut_trace.trace (
                'ERROR - OTHERS LDC_PKCONTRATO.PROCONSULTACONTRATO',
                10);
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END PROCONSULTACONTRATO;

    PROCEDURE CREAACTAMODIFICACION (
        INUCERTIFICATETYPE   IN GE_ACTA.ID_TIPO_ACTA%TYPE,
        INUCONTRACTID        IN GE_ACTA.CONTRACTOR_ID%TYPE,
        INUVALUETOTAL        IN GE_ACTA.VALOR_TOTAL%TYPE,
        INUVALUEADVANCE      IN GE_ACTA.VALUE_ADVANCE%TYPE,
        IDTINITIALDATE       IN GE_ACTA.FECHA_INICIO%TYPE,
        IDTFINALDATE         IN GE_ACTA.FECHA_FIN%TYPE,
        ISBCOMMENT           IN GE_ACTA.COMMENT_%TYPE,
        INUCOMMENTTYPE       IN GE_ACTA.COMMENT_TYPE_ID%TYPE)
    IS
        CNUREQUIRED_ATTRIBUTE   CONSTANT NUMBER := 116082;
        CNULESSORZER_VALERR     CONSTANT NUMBER := 4784;
        CNUADVANGREATERVALU     CONSTANT NUMBER := 110524;
        RCACTA                           DAGE_ACTA.STYGE_ACTA;
        CNUERRORDATES1          CONSTANT NUMBER (18) := 346;
        CNUERRORDATES2          CONSTANT NUMBER (18) := 12921;
        CNUERRORVALUES          CONSTANT NUMBER (18) := 900902;
    BEGIN
        UT_TRACE.TRACE ('INICIO CREAACTAMODIFICACION', 12);

        IF (INUCERTIFICATETYPE IS NULL)
        THEN
            ERRORS.SETERROR (CNUREQUIRED_ATTRIBUTE, 'Tipo de Acta');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF (INUCONTRACTID IS NULL)
        THEN
            ERRORS.SETERROR (CNUREQUIRED_ATTRIBUTE, 'Contrato');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF (INUCOMMENTTYPE IS NULL)
        THEN
            ERRORS.SETERROR (CNUREQUIRED_ATTRIBUTE, 'Tipo de Comentario');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF (INUCERTIFICATETYPE IS NULL)
        THEN
            ERRORS.SETERROR (CNUREQUIRED_ATTRIBUTE, 'Comentario');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF (INUVALUETOTAL <= 0)
        THEN
            ERRORS.SETERROR (CNULESSORZER_VALERR, 'Valor Total');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF (INUVALUEADVANCE < 0)
        THEN
            ERRORS.SETERROR (CNULESSORZER_VALERR, 'Valor Anticipo');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF     INUCERTIFICATETYPE <> CT_BOCONSTANTS.FNUGETOPENCERTITYPE
           AND INUCERTIFICATETYPE <> CT_BOCONSTANTS.FNUGETCHANGECERTITYPE
        THEN
            IF (IDTINITIALDATE IS NOT NULL)
            THEN
                IF (TRUNC (IDTINITIALDATE) < TRUNC (UT_DATE.FDTSYSDATE))
                THEN
                    ERRORS.SETERROR (CNUERRORDATES2);
                    RAISE EX.CONTROLLED_ERROR;
                END IF;
            END IF;
        END IF;

        IF (IDTINITIALDATE IS NOT NULL AND IDTFINALDATE IS NOT NULL)
        THEN
            IF (TRUNC (IDTINITIALDATE) > TRUNC (IDTFINALDATE))
            THEN
                ERRORS.SETERROR (CNUERRORDATES1);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
        END IF;

        IF (INUVALUEADVANCE IS NOT NULL AND INUVALUETOTAL IS NOT NULL)
        THEN
            IF (INUVALUEADVANCE >= INUVALUETOTAL)
            THEN
                ERRORS.SETERROR (CNUADVANGREATERVALU,
                                 'Valor Anticipo|Valor Total');
                RAISE EX.CONTROLLED_ERROR;
            END IF;
        END IF;

        RCACTA.NOMBRE :=
               CT_BOCONSTANTS.FSBGETDESCCERTIFICATETYPE (INUCERTIFICATETYPE)
            || ' '
            || DAGE_CONTRATO.FSBGETDESCRIPCION (INUCONTRACTID);
        RCACTA.ID_ACTA :=
            GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE ('GE_ACTA', 'SEQ_GE_ACTA');

        RCACTA.ID_TIPO_ACTA := INUCERTIFICATETYPE;
        RCACTA.FECHA_CREACION := UT_DATE.FDTSYSDATE;
        RCACTA.ESTADO := CT_BOCONSTANTS.FSBGETCLOSEDCERTIFSTATUS;
        RCACTA.ID_CONTRATO := INUCONTRACTID;
        RCACTA.VALOR_TOTAL := INUVALUETOTAL;
        RCACTA.VALUE_ADVANCE := INUVALUEADVANCE;
        RCACTA.FECHA_INICIO := IDTINITIALDATE;
        RCACTA.FECHA_FIN := IDTFINALDATE;
        RCACTA.COMMENT_TYPE_ID := INUCOMMENTTYPE;
        RCACTA.COMMENT_ := ISBCOMMENT;
        RCACTA.PERSON_ID := GE_BOPERSONAL.FNUGETPERSONID;
        RCACTA.TERMINAL := UT_SESSION.GETTERMINAL;
        RCACTA.CONTRACTOR_ID :=
            DAGE_CONTRATO.FNUGETID_CONTRATISTA (INUCONTRACTID);

        DAGE_ACTA.INSRECORD (RCACTA);

        UT_TRACE.TRACE ('FIN CREAACTAMODIFICACION', 12);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR
        THEN
            UT_TRACE.TRACE ('CONTROLLED_ERROR CREAACTAMODIFICACION', 12);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            UT_TRACE.TRACE ('others CREAACTAMODIFICACION', 12);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CREAACTAMODIFICACION;

    PROCEDURE CREAACTAANTICIPO (
        INUCONTRACTID     IN GE_CONTRATO.ID_CONTRATO%TYPE,
        INUVALUETOTAL     IN GE_ACTA.VALOR_TOTAL%TYPE,
        INUVALUEADVANCE   IN GE_ACTA.VALUE_ADVANCE%TYPE,
        ISBCOMMENT        IN GE_ACTA.COMMENT_%TYPE,
        INUCOMMENTTYPE    IN GE_ACTA.COMMENT_TYPE_ID%TYPE)
    IS
        CNUREQUIRED_ATTRIBUTE   CONSTANT NUMBER := 116082;
        CNULESSORZER_VALERR     CONSTANT NUMBER := 4784;
        CNUADVANGREATERVALU     CONSTANT NUMBER := 110524;
        CNUINVALIDPARAM         CONSTANT NUMBER := 119369;
        CNUERROITEM             CONSTANT NUMBER := 10750;
        NUCERTIFICATETYPE       CONSTANT NUMBER := 1;
        NUITEMSANTICIPO                  GE_ITEMS.ITEMS_ID%TYPE;
        RCACTA                           DAGE_ACTA.STYGE_ACTA;
        NUDETALLEACTA                    GE_DETALLE_ACTA.ID_DETALLE_ACTA%TYPE;
        SBDESCITEM                       GE_DETALLE_ACTA.DESCRIPCION_ITEMS%TYPE;
        RCDETALLEACTA                    DAGE_DETALLE_ACTA.STYGE_DETALLE_ACTA;
    BEGIN
        UT_TRACE.TRACE ('INICIO CREAACTAANTICIPO', 12);

        IF (INUCONTRACTID IS NULL)
        THEN
            ERRORS.SETERROR (CNUREQUIRED_ATTRIBUTE, 'Contrato');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF (INUCOMMENTTYPE IS NULL)
        THEN
            ERRORS.SETERROR (CNUREQUIRED_ATTRIBUTE, 'Tipo de Comentario');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF (INUVALUETOTAL <= 0)
        THEN
            ERRORS.SETERROR (CNULESSORZER_VALERR, 'Valor Total');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF (INUVALUEADVANCE < 0)
        THEN
            ERRORS.SETERROR (CNULESSORZER_VALERR, 'Valor Anticipo');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF (INUVALUEADVANCE IS NOT NULL AND INUVALUETOTAL IS NOT NULL)
        THEN
            IF (INUVALUEADVANCE >= INUVALUETOTAL)
            THEN
                ERRORS.SETERROR (CNUADVANGREATERVALU,
                                 'Valor Anticipo|Valor Total');
                RAISE EX.CONTROLLED_ERROR;
            END IF;
        END IF;

        NUITEMSANTICIPO := GE_BOPARAMETER.FNUVALORNUMERICO ('ITEM_ANTICIPO');

        IF NUITEMSANTICIPO IS NULL
        THEN
            ERRORS.SETERROR (CNUINVALIDPARAM, 'ITEM_ANTICIPO');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF NOT (DAGE_ITEMS.FBLEXIST (NUITEMSANTICIPO))
        THEN
            ERRORS.SETERROR (CNUERROITEM, NUITEMSANTICIPO);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        RCACTA.NOMBRE :=
               'ENTREGA DE ANTICIPO '
            || DAGE_CONTRATO.FSBGETDESCRIPCION (INUCONTRACTID);
        RCACTA.ID_ACTA :=
            GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE ('GE_ACTA', 'SEQ_GE_ACTA');

        RCACTA.ID_TIPO_ACTA := NUCERTIFICATETYPE;
        RCACTA.FECHA_CREACION := UT_DATE.FDTSYSDATE;
        RCACTA.ESTADO := CT_BOCONSTANTS.FSBGETCLOSEDCERTIFSTATUS;
        RCACTA.ID_CONTRATO := INUCONTRACTID;
        RCACTA.VALOR_TOTAL := INUVALUEADVANCE;
        RCACTA.VALUE_ADVANCE := INUVALUEADVANCE;
        RCACTA.FECHA_INICIO := UT_DATE.FDTSYSDATE;
        RCACTA.FECHA_FIN := UT_DATE.FDTSYSDATE;
        RCACTA.COMMENT_TYPE_ID := INUCOMMENTTYPE;
        RCACTA.COMMENT_ := ISBCOMMENT;
        RCACTA.PERSON_ID := GE_BOPERSONAL.FNUGETPERSONID;
        RCACTA.TERMINAL := UT_SESSION.GETTERMINAL;
        RCACTA.CONTRACTOR_ID :=
            DAGE_CONTRATO.FNUGETID_CONTRATISTA (INUCONTRACTID);
        RCACTA.IS_PENDING := 0;

        DAGE_ACTA.INSRECORD (RCACTA);

        UT_TRACE.TRACE ('Se inserta detalle de acta', 10);

        SBDESCITEM :=
               NUITEMSANTICIPO
            || ' - '
            || DAGE_ITEMS.FSBGETDESCRIPTION (NUITEMSANTICIPO);
        CT_BOCERTIFICATE.INSCERTIFICATEDETAIL (NUITEMSANTICIPO,
                                               SBDESCITEM,
                                               RCACTA.ID_ACTA,
                                               NUDETALLEACTA);

        RCDETALLEACTA := DAGE_DETALLE_ACTA.FRCGETRECORD (NUDETALLEACTA);

        RCDETALLEACTA.REFERENCE_ITEM_ID := NUITEMSANTICIPO;
        RCDETALLEACTA.CANTIDAD := 1;
        RCDETALLEACTA.VALOR_UNITARIO := INUVALUEADVANCE;
        RCDETALLEACTA.VALOR_TOTAL := INUVALUEADVANCE;
        RCDETALLEACTA.TIPO_GENERACION := 'A';
        RCDETALLEACTA.ID_UNIDAD_MEDIDA := 159;

        DAGE_DETALLE_ACTA.UPDRECORD (RCDETALLEACTA);

        UT_TRACE.TRACE ('FIN CREAACTAANTICIPO', 12);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR
        THEN
            UT_TRACE.TRACE ('CONTROLLED_ERROR CREAACTAANTICIPO', 12);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            UT_TRACE.TRACE ('others CREAACTAANTICIPO', 12);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CREAACTAANTICIPO;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : PROACTUALIZACONTRATO
    Descripcion    : Servicio para la actualizar los datos del contrato desde CTCCO
    Autor          : Jorge Valiente
    Fecha          : 28/11/2016

    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    Fecha       Autor          Modificacion
    ==========  ============== =======================
    14.03.2022  jgomez.OSF165  Se elimina la estricción que impide actualizar el contrato si dicho contrato
                               tiene actas de tipo [2 - Facturación]
    02/08/2021  HORBATH        CA809 Se elimina la validación donde se verifica que el valor del anticipo sea igual a 0.
    07/02/2018  DSALTARIN      CA2001724 Se modifica para que la validacion del valor del anticipo solo lance error si es menor que cero
    25/03/2020                   CA80 Se valida el valor anticipo con el asignado al contrato en la tabla GE_CONTRATO
    17/01/2021  OL-Software    CA418 Se adicionan los campos de area organizacional y aplica evaluación
    05/10/2023  jpinedc         OSF-1728: se cambia tipo de dato de nuContractId 
    ******************************************************************/

    PROCEDURE PROACTUALIZACONTRATO
    IS
        CURSOR CUACTAASOCIADASTIPO1 (INUCONTRATO NUMBER)
        IS
            SELECT GA.*
              FROM ge_acta ga
             WHERE     ga.Id_Contrato = INUCONTRATO
                   AND GA.ID_TIPO_ACTA IN (1)
                   AND UPPER (GA.NOMBRE) NOT LIKE '%ENTREGA DE ANTICIPO%';

        rfCUACTAASOCIADASTIPO1   CUACTAASOCIADASTIPO1%ROWTYPE;
        --Declaracion de variables.

        -- Instancia
        sbInstance               ge_boInstanceControl.stysbName;

        -- Id del Contrato
        sbContractId             ge_boutilities.styStatement;
        nuContractId             ge_acta.id_contrato%TYPE;

        -- Valor Total
        sbValueTotal             ge_boutilities.styStatement;
        nuValueTotal             ge_acta.valor_total%TYPE;

        -- Valor Anticipo
        sbValueAdvance           ge_boutilities.styStatement;
        nuValueAdvance           ge_acta.value_advance%TYPE;

        -- Fecha Inicial
        sbInitialDate            ge_boutilities.styStatement;
        dtInitialDate            ge_acta.fecha_inicio%TYPE;

        -- Fecha Final
        sbFinalDate              ge_boutilities.styStatement;
        dtFinalDate              ge_acta.fecha_fin%TYPE;

        --Id Tipo de Comentario
        sbCommentType            ge_boutilities.styStatement;
        nuCommentType            ge_comment_type.comment_type_id%TYPE;

        --Comentario
        sbComment                ge_acta.comment_%TYPE;

        --Porcentaje Fondo Garantia
        sbPORCEN_FONDO_GARANT    ge_boInstanceControl.stysbValue;
        nuPORCEN_FONDO_GARANT    ge_contrato.porcen_fondo_garant%TYPE;

        ---Inicio Variables actualizacion CONTRATO y ACTAS
        --Declaracion de variables.

        sbNewStatusContract      ge_contrato.status%TYPE;
        nuCertificateType        ge_acta.id_tipo_acta%TYPE;
        rcContract               daGe_contrato.styGe_contrato;
        blResult                 BOOLEAN := TRUE;

        -- Variables para datos actuales del contrato
        inuContractId            ge_acta.id_contrato%TYPE;
        inuNewValueTotal         ge_acta.valor_total%TYPE;
        inuNewValueAdvance       ge_acta.value_advance%TYPE;
        idtInitialDate           ge_acta.fecha_inicio%TYPE;
        idtNewFinalDate          ge_acta.fecha_fin%TYPE;
        inuCommentTypeId         ge_acta.comment_type_id%TYPE;
        isbComment               ge_acta.comment_%TYPE;
        sbpaverror               VARCHAR2 (1000);
        dtFechaMaximaAsig        LDC_CONTFEMA.FECHA_MAXASIG%TYPE; --Ticket 200-810 LJLB -- Se almacena fecha maxima de asigancion
        dtNewFeMaximaAsig        LDC_CONTFEMA.FECHA_MAXASIG%TYPE; --Ticket 200-810 LJLB -- Se almacena fecha maxima de asigancion nueva

        sbNewFeMaximaAsig        ge_boutilities.styStatement; --Ticket 200-810 LJLB -- Se almacena fecha maxima de asigancion nueva

        nuDifeAnticipo           ge_acta.value_advance%TYPE;
        liq_anticipo             VARCHAR2 (1);

        ---Fin Variables actualizacion CONTRATO y ACTAS

        nuItem                   GE_ITEMS.ITEMS_ID%TYPE
            := GE_BOPARAMETER.FNUVALORNUMERICO ('ITEM_ANTICIPO'); --TICKET 200-1473 LJLB-- se almacena item de entrega anticipo
        sbValiActaPaga           VARCHAR2 (1)
            := DALD_PARAMETER.FSBGETVALUE_CHAIN ('LDC_VALIDAACPAGA', NULL); --TICKET 200-1473 LJLB-- se almacena flag si se valida acta de entrega de anticipo paga
        sbDato                   VARCHAR2 (1); --TICKET 200-1473 LJLB-- se almacena si existe item excluido
        sbFlag                   VARCHAR2 (1) := 'N'; --TICKET 200-1473 LJLB-- se almacena si la entrega aplica en la gasera
        sbValidaValorPagado      VARCHAR2 (1)
            := DALD_PARAMETER.FSBGETVALUE_CHAIN ('LDC_VALIDAACPAGA', NULL); --TICKET 200-1473 LJLB-- se almacena flag si se quita validacion de actas de modificacion
        nuValorTotalLiquidado    NUMBER; --TICKET 200-1473 LJLB-- se almacena valor total liquidado
        sbflagvaltiac            VARCHAR2 (1);

        --Caso 418
        nuAreaOrganizacional     LDC_CONTRATO_AREA.area_id%TYPE;
        sbAplicaEvaluacion       LDC_CONTRATO_AREA.aplica_evaluacion%TYPE;
        csbCaso418      CONSTANT VARCHAR2 (30) := '0000418';
        nuAreaAnt                LDC_CONTRATO_AREA.area_id%TYPE;
        sbAplicaAnt              LDC_CONTRATO_AREA.aplica_evaluacion%TYPE;
        sbAplica418              VARCHAR2 (1);

        --Fin 418

        --TICKET 200-1473 LJLB-- consulta item excluido
        CURSOR cuItemExcluido IS
            SELECT 'X'
              FROM CT_EXCL_ITEM_CONT_VAL
             WHERE ITEMS_ID = nuItem;

        --TICKET 200-1473 LJLB-- valida si acta de entrega de anticipo estan pagadas
        CURSOR cuValidaActaEnAnt IS
            SELECT 'X'
              FROM GE_ACTA a, ge_detalle_acta d
             WHERE     ID_TIPO_ACTA = 1
                   AND a.id_Contrato = nuContractId
                   AND d.id_acta = a.id_acta
                   AND a.estado = 'C'
                   AND d.ID_ITEMS =
                       GE_BOPARAMETER.FNUVALORNUMERICO ('ITEM_ANTICIPO')
                   AND a.EXTERN_PAY_DATE IS NOT NULL
                   AND a.EXTERN_INVOICE_NUM IS NOT NULL;

        --TICKET 200-1473 LJLB-- validar que el nuevo valor de contrato no menor a la suma de valor pagado + pendiente de liquidacion + liquidado
        CURSOR cuValidaValorPagado IS
            SELECT (  (SELECT NVL (SUM (NVL (D.valor_total, 0)), 0)
                         FROM OPEN.ge_detalle_acta d, OPEN.ge_acta A
                        WHERE     D.id_acta = A.id_acta
                              AND A.id_contrato = C.id_contrato
                              AND A.estado = 'A'
                              AND NVL (affect_contract_val, 'Y') = 'Y')
                    + (SELECT ROUND (NVL (SUM (NVL (oi.VALUE, 0)), 0), 0)
                         FROM OPEN.or_order ot, OPEN.or_order_items oi
                        WHERE     ot.order_status_id =
                                  OPEN.dald_parameter.fnugetnumeric_value (
                                      'COD_ORDER_STATUS')
                              AND ot.defined_contract_id = C.id_contrato
                              AND ot.order_id = oi.order_id
                              AND 0 = (SELECT COUNT (*)
                                         FROM OPEN.ge_detalle_acta d
                                        WHERE d.id_orden = ot.order_id))
                    + valor_total_pagado)    valor_total
              FROM ge_contrato C
             WHERE C.id_contrato = nuContractId;

        --Caso 80: Se valida que el valor digitado en el campo valor anticipo sea menor al valor anticipo otorgado al contrato
        CURSOR cuGetValorAnticipoContrato (
            nuContratoId   IN GE_CONTRATO.valor_anticipo%TYPE)
        IS
            SELECT valor_anticipo
              FROM GE_CONTRATO
             WHERE ID_CONTRATO = nuContratoId;

        nuValorAnticipo          GE_CONTRATO.valor_anticipo%TYPE;
        sbEntrega                VARCHAR2 (100) := '0000080';
        --709
        sbIncrementType          VARCHAR2 (1);
        sbTipoIncrAnte           VARCHAR2 (1);
        sbTipoInc                VARCHAR2 (1);
        sbParam                  VARCHAR2 (2000)
            := dald_parameter.fsbGetValue_Chain ('LDC_VALTINC_BYTTCON', NULL);
        sbAplica709              VARCHAR2 (1);
        nuIdTipoContrato         open.ge_contrato.id_tipo_contrato%TYPE;
        rcldc_tipoinc_bycon      daldc_tipoinc_bycon.styldc_tipoinc_bycon;
        tbOperUnit               ldc_pe_bcgestlist.ttyrcOuByConTi;
        tbOperUnit_Empty         ldc_pe_bcgestlist.ttyrcOuByConTi;
        nuCountDif               NUMBER;
        nuCount                  NUMBER;
        rcldc_tipoinc_byconE     daldc_tipoinc_bycon.styldc_tipoinc_bycon;
    BEGIN
        ut_trace.trace ('INICIO LDC_PKCONTRATO.PROACTUALIZACONTRATO', 10);

        --TICKET 2001473 LJLB -- se valida si aplica la entrega
        IF fblaplicaentrega ('OSS_SETV_LJLB_2001473_1')
        THEN
            sbFlag := 'S';
        END IF;

        sbFlag := 'S';                                        --se debe borrar
        --Obtiene instancia actual
        GE_BOInstanceControl.GetCurrentInstance (sbInstance);

        --Obtiene el identificador del contratista
        ge_boInstanceControl.GetAttributeNewValue (sbInstance,
                                                   NULL,
                                                   'GE_ACTA',
                                                   'ID_CONTRATO',
                                                   sbContractId);
        nuContractId := TO_NUMBER (sbContractId);

        --Obtiene el valor total definido
        ge_boInstanceControl.GetAttributeNewValue (sbInstance,
                                                   NULL,
                                                   'GE_ACTA',
                                                   'VALOR_TOTAL',
                                                   sbValueTotal);
        nuValueTotal := TO_NUMBER (sbValueTotal);

        --Obtiene el valor del anticipo
        ge_boInstanceControl.GetAttributeNewValue (sbInstance,
                                                   NULL,
                                                   'GE_ACTA',
                                                   'VALUE_ADVANCE',
                                                   sbValueAdvance);
        nuValueAdvance := TO_NUMBER (sbValueAdvance);

        --Obtiene la fecha inicial
        ge_boInstanceControl.GetAttributeNewValue (sbInstance,
                                                   NULL,
                                                   'GE_ACTA',
                                                   'FECHA_INICIO',
                                                   sbInitialDate);
        dtInitialDate := ut_date.fdtdatewithformat (sbInitialDate);

        --Obtiene la fecha Final
        ge_boInstanceControl.GetAttributeNewValue (sbInstance,
                                                   NULL,
                                                   'GE_ACTA',
                                                   'FECHA_FIN',
                                                   sbFinalDate);
        dtFinalDate := ut_date.fdtdatewithformat (sbFinalDate);

        dtFechaMaximaAsig := DALDC_CONTFEMA.fdtFechaMaxima (nuContractId); --Ticket 200-810  LJLB -- se consulta fecha maxima de asignacion

        --Caso 80: Se valida que el valor digitado en el campo valor anticipo sea menor al valor anticipo otorgado al contrato
        IF fblaplicaentregaxcaso (sbEntrega)
        THEN
            OPEN cuGetValorAnticipoContrato (nuContractId);

            FETCH cuGetValorAnticipoContrato INTO nuValorAnticipo;

            CLOSE cuGetValorAnticipoContrato;

            IF nuValorAnticipo IS NULL
            THEN
                nuValorAnticipo := 0;
            END IF;

            IF nuValueAdvance < nuValorAnticipo
            THEN
                Errors.SetError (
                    2741,
                    'No se puede disminuir el valor de anticipo');
                RAISE ex.CONTROLLED_ERROR;
            END IF;
        END IF;

        --TICKET 200-810 LJLB -- Obtiene la fecha maxima de asigancion
        ge_boInstanceControl.GetAttributeNewValue (sbInstance,
                                                   NULL,
                                                   'LDC_CONTFEMA',
                                                   'FECHA_MAXASIG',
                                                   sbNewFeMaximaAsig);

        dtNewFeMaximaAsig := ut_date.fdtdatewithformat (sbNewFeMaximaAsig);
        --Obtiene el identificador del tipo de comentario
        ge_boInstanceControl.GetAttributeNewValue (sbInstance,
                                                   NULL,
                                                   'GE_ACTA',
                                                   'COMMENT_TYPE_ID',
                                                   sbCommentType);
        nuCommentType := TO_NUMBER (sbCommentType);

        --Obtiene el comentario
        ge_boInstanceControl.GetAttributeNewValue (sbInstance,
                                                   NULL,
                                                   'GE_ACTA',
                                                   'COMMENT_',
                                                   sbComment);

        --Obtiene el Porcentaje Fondo de Garantia
        ge_boInstanceControl.GetAttributeNewValue (sbInstance,
                                                   NULL,
                                                   'GE_CONTRATO',
                                                   'PORCEN_FONDO_GARANT',
                                                   sbPORCEN_FONDO_GARANT);
        nuPORCEN_FONDO_GARANT := TO_NUMBER (sbPORCEN_FONDO_GARANT);

        IF fblaplicaentregaxcaso (csbCaso418)
        THEN
            nuAreaAnt :=
                LDC_BOAREA_CONTRATO.FNU_OBTIENE_AREA_CONTRATO (nuContractId);
            sbAplicaAnt :=
                LDC_BOAREA_CONTRATO.FSB_OBTIENE_EVALUACION (nuContractId);

            sbAplica418 := 'S';
            nuAreaOrganizacional :=
                TO_NUMBER (
                    ge_boInstanceControl.fsbGetFieldValue (
                        'LDC_CONTRATO_AREA',
                        'AREA_ID'));
            sbAplicaEvaluacion :=
                TO_CHAR (
                    ge_boInstanceControl.fsbGetFieldValue (
                        'LDC_CONTRATO_AREA',
                        'APLICA_EVALUACION'));

            IF nuAreaOrganizacional IS NULL
            THEN
                Errors.seterror (
                    LD_BOCONSTANS.CNUGENERIC_ERROR,
                    'El campo Área Organizacional es obligatorio. Favor validar');
                RAISE ex.CONTROLLED_ERROR;
            END IF;

            IF sbAplicaEvaluacion IS NULL
            THEN
                Errors.seterror (
                    LD_BOCONSTANS.CNUGENERIC_ERROR,
                    'El campo Aplica Evaluación es obligatorio. Favor validar');
                RAISE ex.CONTROLLED_ERROR;
            END IF;

            IF sbAplicaEvaluacion = 'Y'
            THEN
                sbAplicaEvaluacion := 'S';
            END IF;
        ELSE
            sbAplica418 := 'N';
        END IF;

        IF fblaplicaentregaxcaso ('0000709')
        THEN
            sbAplica709 := 'S';
            ge_boInstanceControl.GetAttributeNewValue (sbInstance,
                                                       NULL,
                                                       'LDC_TIPOINC_BYCON',
                                                       'INCREMENT_TYPE',
                                                       sbIncrementType);

            BEGIN
                SELECT DECODE (sbIncrementType,
                               1, 'I',
                               2, 'S',
                               3, 'N',
                               'O')
                  INTO sbTipoInc
                  FROM DUAL;
            EXCEPTION
                WHEN OTHERS
                THEN
                    sbTipoInc := NULL;
            END;

            IF sbTipoInc IS NULL
            THEN
                Errors.SetError (
                    2741,
                    'El campo Tipo de incremento es obligatorio. Favor validar');
                RAISE ex.CONTROLLED_ERROR;
            END IF;

            BEGIN
                sbTipoIncrAnte :=
                    daldc_tipoinc_bycon.fsbGetINCREMENT_TYPE (sbContractId,
                                                              NULL);
            EXCEPTION
                WHEN OTHERS
                THEN
                    sbTipoIncrAnte := NULL;
            END;
        ELSE
            sbAplica709 := 'N';
            sbTipoIncrAnte := NULL;
            sbTipoInc := NULL;
        END IF;

        ut_trace.Trace (
               ' sbContractId: ['
            || sbContractId
            || ']
         sbValueTotal: ['
            || sbValueTotal
            || ']
         sbValueAdvance: ['
            || sbValueAdvance
            || ']
         sbInitialDate: ['
            || sbInitialDate
            || ']
         sbFinalDate: ['
            || sbFinalDate
            || ']
         sbCommentType: ['
            || sbCommentType
            || ']
         sbComment: ['
            || sbComment
            || ']
         sbPORCEN_FONDO_GARANT: ['
            || sbPORCEN_FONDO_GARANT
            || ']',
            11);

        ut_trace.trace ('INICIO Actualizacion DATOS CONTRATO', 10);

        inuContractId := sbContractId;
        inuNewValueTotal := sbValueTotal;
        inuNewValueAdvance := sbValueAdvance;
        idtInitialDate := sbInitialDate;
        idtNewFinalDate := dtFinalDate;
        inuCommentTypeId := sbCommentType;
        isbComment := sbComment;

        -- Tipo de acta a crear - Acta de Modificacion
        nuCertificateType := ct_boconstants.fnugetChangeCertiType;

        -- Se obtiene el registro del contrato
        dage_contrato.GetRecord (inuContractId, rcContract);

        -- Se alamance los valores actuales del contrato
        --dtFinalDate    := rcContract.fecha_final;
        nuValueAdvance := rcContract.valor_anticipo;
        nuValueTotal := rcContract.valor_total_contrato;

        IF     sbFlag = 'S'
           AND sbValidaValorPagado = 'N'
           AND nuValueTotal <> inuNewValueTotal
        THEN
            OPEN cuValidaValorPagado;

            FETCH cuValidaValorPagado INTO nuValorTotalLiquidado;

            IF nuValorTotalLiquidado > inuNewValueTotal
            THEN
                CLOSE cuValidaValorPagado;

                Errors.setError (
                    OPEN.LD_BOCONSTANS.CNUGENERIC_ERROR,
                       'No se puede disminuir valor total del contrato['
                    || nuContractId
                    || '], porque el valor total liquidado  ['
                    || nuValorTotalLiquidado
                    || '] es mayor al valor ingresado');
                RAISE ex.CONTROLLED_ERROR;
            END IF;

            CLOSE cuValidaValorPagado;
        ELSE
            sbflagvaltiac := NULL;
            sbflagvaltiac :=
                dald_parameter.fsbGetValue_Chain ('VALIDA_ACTA_TIPO_1', NULL);

            IF sbflagvaltiac = 'S'
            THEN
                OPEN CUACTAASOCIADASTIPO1 (nuContractId);

                FETCH CUACTAASOCIADASTIPO1 INTO rfCUACTAASOCIADASTIPO1;

                IF CUACTAASOCIADASTIPO1%FOUND
                THEN
                    ut_trace.trace (
                        'No es posible actualizar contrato si tiene Acta de Tipo [1] asociada',
                        10);
                    Errors.SetError (
                        OPEN.LD_BOCONSTANS.CNUGENERIC_ERROR,
                        'No es posible actualizar el contrato si tiene Acta de Tipo [1] asociada');
                    RAISE ex.CONTROLLED_ERROR;
                END IF;

                CLOSE CUACTAASOCIADASTIPO1;
            END IF;
        END IF;

        -- Se verifica que se haya realizado alguna modificacion
        IF     (    (TRUNC (idtNewFinalDate) = TRUNC (rcContract.fecha_final))
                AND                                  --trunc(dtFinalDate)) AND
                    (NVL (inuNewValueAdvance, 0) = NVL (nuValueAdvance, 0))
                AND (inuNewValueTotal = nuValueTotal)
                AND TRUNC (dtNewFeMaximaAsig) = TRUNC (dtFechaMaximaAsig))
           AND (   (    NVL (nuAreaAnt, -1) = NVL (nuAreaOrganizacional, -1)
                    AND NVL (sbAplicaAnt, '-1') =
                        NVL (sbAplicaEvaluacion, '-1')
                    AND sbAplica418 = 'S')
                OR (sbAplica418 = 'N'))
           AND (   (    NVL (sbTipoIncrAnte, '-') = NVL (sbTipoInc, '-')
                    AND sbAplica709 = 'S')
                OR (sbAplica709 = 'N'))
        THEN
            ROLLBACK;
            ut_trace.trace ('No se realizo ninguna modificacion', 11);
            Errors.setError (OPEN.LD_BOCONSTANS.CNUGENERIC_ERROR,
                             'No se realizo ninguna modificacion');
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        -- Se verifica que las modificaciones sean validas
        IF (TRUNC (idtNewFinalDate) <> TRUNC (rcContract.fecha_final))
        THEN
            -- Si la nueva fecha del contrato es menor a la fecha final actual del contrato, se levanta
            -- mensaje de error y no se registra acta.
            IF (TRUNC (idtNewFinalDate) < TRUNC (SYSDATE))
            THEN
                ut_trace.trace (
                    'La nueva fecha final del contrato es menor a la fecha actual del sistema',
                    11);
                Errors.setError (
                    OPEN.LD_BOCONSTANS.CNUGENERIC_ERROR,
                    'La nueva fecha final del contrato es menor a la fecha actual del sistema');
                RAISE ex.CONTROLLED_ERROR;
            END IF;

            -- actualizamos fechas de vigencias
            sbpaverror := NULL;
            ld_pk_actlistprecofer.ldc_procactfechasvigenciasofer (
                nuContractId,
                rcContract.fecha_final,
                idtNewFinalDate,
                sbpaverror);

            IF sbpaverror IS NOT NULL
            THEN
                Errors.setError (
                    OPEN.LD_BOCONSTANS.CNUGENERIC_ERROR,
                       'Error actualizando fechas contratos ofertados : '
                    || sbpaverror);
                RAISE ex.CONTROLLED_ERROR;
            END IF;

            rcContract.fecha_final := idtNewFinalDate;
            --Valida si los planes de condiciones asociados, aun son validos.
            ge_bocontrato.valPlanConditions (rcContract.id_contrato,
                                             rcContract.fecha_inicial,
                                             rcContract.fecha_final);
        END IF;

        IF inuNewValueTotal IS NOT NULL
        THEN
            -- Si el nuevo valor total del contrato es menor al valor actual del contrato, se levanta
            -- mensaje de error y no se registra acta.
            IF (inuNewValueTotal <= 0)
            THEN
                ut_trace.trace (
                    'El nuevo valor total del contrato es menor o igual a 0',
                    11);
                Errors.setError (
                    OPEN.LD_BOCONSTANS.CNUGENERIC_ERROR,
                    'El nuevo valor total del contrato es menor o igual a 0');
                RAISE ex.CONTROLLED_ERROR;
            END IF;

            rcContract.valor_total_contrato := inuNewValueTotal;
        ELSE
            ut_trace.trace ('El valor total del contrato no puede ser nulo',
                            11);
            Errors.setError (OPEN.LD_BOCONSTANS.CNUGENERIC_ERROR,
                             'El valor total del contrato no puede ser nulo');
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        IF inuNewValueAdvance IS NOT NULL
        THEN
            -- Si el nuevo valor del anticipo del contrato es menor al valor actual del anticipo del contrato o
            -- Es mayor que el nuevo valor del contrato. Se levanta mensaje de error y no se registra acta.
            --CA2001724
            --if (inuNewValueAdvance <= 0) then
            IF (inuNewValueAdvance < 0)
            THEN
                ut_trace.trace (
                    'El nuevo valor del anticipo del contrato es menor que 0',
                    11);
                /*Errors.setError(OPEN.LD_BOCONSTANS.CNUGENERIC_ERROR,
                'El nuevo valor del anticipo del contrato es menor o igual a 0');*/
                Errors.setError (
                    OPEN.LD_BOCONSTANS.CNUGENERIC_ERROR,
                    'El nuevo valor del anticipo del contrato es menor que 0');
                RAISE ex.CONTROLLED_ERROR;
            END IF;

            --TICKET 2001473 LJLB -- se valida si aplica la entrega
            IF sbFlag = 'S'
            THEN
                --TICKET 2001473 LJLB -- se consulta si el item esta excluido
                OPEN cuItemExcluido;

                FETCH cuItemExcluido INTO sbDato;

                CLOSE cuItemExcluido;
            END IF;

            --TICKET 2001473 LJLB -- si el item de anticipo no esta excluido se realiza el calculo
            IF sbDato IS NULL
            THEN
                --El valor total pagado del contrato es igual al valor del anticipo
                rcContract.valor_total_pagado :=
                      NVL (rcContract.valor_total_pagado, 0)
                    + NVL (inuNewValueAdvance, 0)
                    - NVL (rcContract.valor_anticipo, 0);
            END IF;

            -- Se actualiza el valor del anticipo
            rcContract.valor_anticipo := inuNewValueAdvance;
        END IF;

        IF sbPORCEN_FONDO_GARANT IS NOT NULL
        THEN
            -- Si el nuevo valor del anticipo del contrato es menor al valor actual del anticipo del contrato o
            -- Es mayor que el nuevo valor del contrato. Se levanta mensaje de error y no se registra acta.
            IF ((nuPORCEN_FONDO_GARANT < 0) AND (nuPORCEN_FONDO_GARANT > 100))
            THEN
                ut_trace.trace (
                    'El porcentaje del fondo de garantia es menor a 0 o mayo de 100',
                    11);
                Errors.setError (
                    OPEN.LD_BOCONSTANS.CNUGENERIC_ERROR,
                    'El porcentaje del fondo de garantia es menor a 0 o mayo de 100');
                RAISE ex.CONTROLLED_ERROR;
            END IF;

            -- Se actualiza el valor del porcentaje de fondo de garantia
            rcContract.porcen_fondo_garant := nuPORCEN_FONDO_GARANT;
        END IF;

        -- Actualizo el contrato
        dage_contrato.UpdRecord (rcContract);

        ---Caso 418 Area Organizacional
        IF fblaplicaentregaxcaso (csbCaso418)
        THEN
            LDC_BOAREA_CONTRATO.prGestionAreaContrato (inuContractId,
                                                       nuAreaOrganizacional,
                                                       sbAplicaEvaluacion);
        END IF;

        IF sbAplica709 = 'S'
        THEN
            nuIdTipoContrato := rcContract.id_tipo_contrato;
            tbOperUnit := tbOperUnit_Empty;
            nuCountDif := 0;
            nuCount := 0;

            ldc_pe_bcgestlist.pGetOuByConTi (inuContractId, tbOperUnit);

            IF (   (sbParam IS NULL)
                OR ',' || sbParam || ',' NOT LIKE
                       '%,' || nuIdTipoContrato || ',%')
            THEN
                IF (NVL (tbOperUnit.COUNT, 0) <= 0)
                THEN
                    ge_boerrors.seterrorcodeargument (
                        Ld_Boconstans.cnuGeneric_Error,
                        'Debe relacionar las unidades operativas.');
                    RAISE ex.CONTROLLED_ERROR;
                END IF;
            END IF;

            IF (tbOperUnit.COUNT > 0)
            THEN
                FOR idx IN tbOperUnit.FIRST .. tbOperUnit.LAST
                LOOP
                    --Se valida el tipo de incremento para las unidades compartidas
                    IF (ldc_pe_bcgestlist.cuCountDifTin%ISOPEN)
                    THEN
                        CLOSE ldc_pe_bcgestlist.cuCountDifTin;
                    END IF;

                    OPEN ldc_pe_bcgestlist.cuCountDifTin (
                        inuContractId,
                        tbOperUnit (idx).OPERATING_UNIT_ID,
                        sbTipoInc);

                    FETCH ldc_pe_bcgestlist.cuCountDifTin INTO nuCount;

                    CLOSE ldc_pe_bcgestlist.cuCountDifTin;

                    IF (nuCount > 0)
                    THEN
                        nuCountDif := nuCountDif + 1;
                    END IF;
                END LOOP;
            END IF;

            IF (nuCountDif = 0)
            THEN
                --Se inserta el tipo de incremento para el contrato
                rcldc_tipoinc_bycon := rcldc_tipoinc_byconE;
                rcldc_tipoinc_bycon.id_contrato := inuContractId;
                rcldc_tipoinc_bycon.increment_type := sbTipoInc;

                IF daldc_tipoinc_bycon.fblExist (inuContractId)
                THEN
                    daldc_tipoinc_bycon.updincrement_type (inuContractId,
                                                           sbTipoInc);
                ELSE
                    daldc_tipoinc_bycon.insrecord (rcldc_tipoinc_bycon);
                END IF;
            ELSE
                --Existen contratos de unidades compartidas con tipo de incremento diferente
                ge_boerrors.seterrorcodeargument (
                    Ld_Boconstans.cnuGeneric_Error,
                    'Existen contratos de unidades operativas compartidas con un tipo de incremento diferente al seleccionado.');
                RAISE ex.CONTROLLED_ERROR;
            END IF;
        END IF;

        ut_trace.trace ('FIN Actualizacion DATOS CONTRATO', 10);

        ut_trace.trace ('INICIO Generacion ACTA', 10);
        -- Se realiza registro del Acta
        --CT_BoCertificate.CreateStatusCertiContract
        CREAACTAMODIFICACION (nuCertificateType,
                              inuContractId,
                              inuNewValueTotal,
                              inuNewValueAdvance,
                              idtInitialDate,
                              rcContract.fecha_final,
                              isbComment,
                              inuCommentTypeId);

        ut_trace.trace ('Creacion de acta de liquidacion de anticipo', 6);
        --CA2001724
        nuDifeAnticipo :=
            NVL (inuNewValueAdvance, 0) - NVL (nuValueAdvance, 0);

        liq_anticipo :=
            ge_boparameter.fsbvaloralfanumerico ('LIQUIDA_ANTICIPO');

        --TICKET 2001473 LJLB -- se valida si aplica la entrega para la gasera
        IF sbFlag = 'S'
        THEN
            IF NVL (nuDifeAnticipo, 0) < 0 AND NVL (liq_anticipo, 'N') = 'Y'
            THEN
                --TICKET 2001473 LJLB -- se valida  actas de entrega de anticipo pagas
                IF sbValiActaPaga = 'S'
                THEN
                    OPEN cuValidaActaEnAnt;

                    FETCH cuValidaActaEnAnt INTO sbDato;

                    IF cuValidaActaEnAnt%FOUND
                    THEN
                        CLOSE cuValidaActaEnAnt;

                        Errors.setError (
                            OPEN.LD_BOCONSTANS.CNUGENERIC_ERROR,
                               'No se puede disminuir valor de anticipo del contrato['
                            || nuContractId
                            || '], porque existen ordenes de entrega de anticipo pagadas');
                        RAISE ex.CONTROLLED_ERROR;
                    END IF;

                    CLOSE cuValidaActaEnAnt;
                END IF;

                --ct_bocertificate.CreateLiqAdminCertificate
                CREAACTAANTICIPO (inuContractId,
                                  inuNewValueTotal,
                                  inuNewValueAdvance,
                                  isbcomment,
                                  inuCommentTypeId);
            END IF;
        END IF;

        IF NVL (nuDifeAnticipo, 0) > 0 AND NVL (liq_anticipo, 'N') = 'Y'
        THEN
            ct_bocertificate.CreateLiqAdminCertificate (inuContractId,
                                                        inuNewValueTotal,
                                                        nuDifeAnticipo,
                                                        isbcomment,
                                                        inuCommentTypeId);
        END IF;

        ut_trace.trace ('FIN Generacion ACTA', 10);
        ---------------------------------------------------------------------

        PKGENERALSERVICES.COMMITTRANSACTION;

        ut_trace.trace ('FIN LDC_PKCONTRATO.PROACTUALIZACONTRATO', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR
        THEN
            ut_trace.trace (
                'ERROR - CONTROLLED_ERROR LDC_PKCONTRATO.PROACTUALIZACONTRATO',
                10);
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            ut_trace.trace (
                'ERROR - OTHERS LDC_PKCONTRATO.PROACTUALIZACONTRATO',
                10);
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END PROACTUALIZACONTRATO;
END LDC_PKCONTRATO;
/

