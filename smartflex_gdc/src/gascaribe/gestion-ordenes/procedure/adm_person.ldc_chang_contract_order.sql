CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_CHANG_CONTRACT_ORDER(inuOT                        or_order.order_id%TYPE DEFAULT NULL, -- Tipo de trabajo
                                                                 inuContratoDestino           ge_contrato.id_contrato%TYPE DEFAULT NULL, -- Contrato destino
                                                                 isbObservacionCambioContrato or_order_comment.order_comment%TYPE DEFAULT NULL -- Observación para el comentario
                                                                 ) IS
    /***********************************************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_chang_contract_order
    Descripcion    : Proceso para cambiar el contrato de una orden.
                     Utilizado en LDCMC.
    Fecha          : 25-11-2014

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor                  Modificacion
    =========       =========                ====================
    30-06-2016      Sandra Muñoz CA200-209   Se agregan parámetros de entrada al procedimiento para
                                             que se pueda usar actualmente en la forma LDCMC y Se
                                             pueda usar por la nueva forma LDCCO
    25-11-2014      KCienfuegos.NC3206       Creación.
    ***********************************************************************************************/

    /*Constants*/
    cnuNULL_ATTRIBUTE         CONSTANT NUMBER := 2126;
    cnu_TASKTYPE_UNDEFINED    CONSTANT ge_message.message_id%TYPE := 901066;
    cnu_CONTR_ALREADY_DEFINED CONSTANT ge_message.message_id%TYPE := 901476;
    cnu_ParametrosGenerales   CONSTANT ge_message.message_id%TYPE := 10602;
    csbEntrega200209          CONSTANT VARCHAR2(100) := 'OSS_CON_SMS_200209_3';
    csbProceso                CONSTANT VARCHAR2(100) := 'LDC_chang_contract_order';

    /*String variables*/
    sbORDER_ID    ge_boInstanceControl.stysbValue;
    sbID_CONTRATO ge_boInstanceControl.stysbValue;

    -- CA200-209
    sbGenerarComentarioOT CHAR(1) := 'N'; -- Indica si luego de la modificación del contrato se debe generar comentario a la OT
    sbError               ge_error_log.description%TYPE; -- Mensaje de error
    nuContratoActual      ge_contrato.id_contrato%TYPE; -- Contrato actual
    nuTipoComentario      ld_parameter.numeric_value%TYPE; -- Tipo de comentario de orden
    nuExiste              NUMBER; -- Indica si un elemento exite en la bd
    nuError               NUMBER; -- Código de mensaje de error retornado por la api
    nuPaso                NUMBER;

    /*Numeric variables*/
    nuOrder    or_order.order_id%TYPE;
    nuContract ge_contrato.id_contrato%TYPE;

    /*Records*/
    rcOrder    daor_order.styOR_order;
    rcContract dage_contrato.styGE_contrato;

BEGIN

    ut_trace.Trace('INICIO: LDC_chang_contract_order', 10);

    -- Inicio CA200-209.
    -- Se controla que si los parámetros no se encuentran en la pantalla, se lean
    -- desde los ingresados al procedimiento
    nuPaso := 10;
    BEGIN
        sbORDER_ID    := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER', 'ORDER_ID');
        sbID_CONTRATO := ge_boInstanceControl.fsbGetFieldValue('GE_CONTRATO', 'ID_CONTRATO');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------
        IF (sbID_CONTRATO IS NULL) THEN
            --Errors.SetError(cnuNULL_ATTRIBUTE, 'Código de Contrato');
            ge_boerrors.seterrorcodeargument(cnuNULL_ATTRIBUTE,'Código de Contrato');
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        ------------------------------------------------
        -- User code
        ------------------------------------------------
        nuOrder    := to_number(sbORDER_ID);
        nuContract := to_number(sbID_CONTRATO);

    EXCEPTION
        WHEN OTHERS THEN
            IF fblaplicaentrega(csbEntrega200209) THEN
                nuOrder    := NULL;
                nuContract := NULL;
            ELSE
                sbError := 'La encuentra ' || csbEntrega200209 || ' no se encuentra aplicada';
                RAISE ex.Controlled_Error;
            END IF;

    END;

    nuPaso := 20;
    IF fblaplicaentrega(csbEntrega200209) THEN
        nuPaso := 30;
        IF nuContract IS NULL THEN
            nuPaso := 40;
            IF inuOT IS NULL OR inuContratoDestino IS NULL THEN
                sbError := 'No se han indicado los datos para realizar la operación';
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbError);
                RAISE ex.CONTROLLED_ERROR;
            END IF;

            -- Determinar si se está generando la modificación masivamente
            nuPaso                := 50;
            sbGenerarComentarioOT := 'S';
            nuOrder               := inuOT;
            nuContract            := inuContratoDestino;
        END IF;
    END IF;
    -- Fin CA200-209.

    /*Obtiene los registros de los datos a procesar*/
    rcOrder    := daOr_order.frcGetRecord(nuOrder);
    rcContract := dage_contrato.frcGetRecord(nuContract);

    nuContratoActual := daor_order.fnuGetDefined_Contract_Id(nuOrder);

    /* Se valida que el contrato a actualizar sea diferente al actual*/
    IF (nuContract = nuContratoActual) THEN
        ge_boerrors.SetErrorCodeArgument(cnu_CONTR_ALREADY_DEFINED, nuOrder || '|' || nuContract);
        RAISE ex.CONTROLLED_ERROR;
    END IF;

    /*Verifica si hay tipos de trabajo definidos por contrato*/
    IF (CT_BCContractTaskType.fblHasTaskTypesDefined(nuContract, 'C')) THEN
        ut_trace.trace('si hay tipos de trabajo definidos por contrato', 15);

        /*Verificar que el contrato soporte el tipo de trabajo de la orden*/
        ut_trace.trace('CT_BCContractTaskType.fblHasTaskType(' || nuContract || ', ' ||
                       rcOrder.task_type_id || ', C)',
                       1);
        IF (NOT CT_BCContractTaskType.fblHasTaskType(nuContract, rcOrder.task_type_id, 'C')) THEN

            /* El contrato no soporta el tipo de trabajo de la orden*/
            GE_BOErrors.SetErrorCode(cnu_TASKTYPE_UNDEFINED);

        END IF;

        /*Verificar si hay tipos de trabajo definidos por tipo de contrato*/
    ELSIF (CT_BCContractTaskType.fblHasTaskTypesDefined(rcContract.id_tipo_contrato, 'T')) THEN

        /*Verificar si el tipo de trabajo está definido por tipo de contrato*/
        IF (NOT CT_BCContractTaskType.fblHasTaskType(nuContract, rcOrder.task_type_id, 'T')) THEN

            /* El contrato no soporta el tipo de trabajo de la orden*/
            GE_BOErrors.SetErrorCode(cnu_TASKTYPE_UNDEFINED);
        END IF;

        ut_trace.trace('el tipo de trabajo está definido por tipo de contrato', 15);
    END IF;

    daor_order.upddefined_contract_id(nuOrder, nuContract);

    -- Inicio CA 200-209
    nuPaso := 100;
    IF fblaplicaentrega(csbEntrega200209) THEN

        -- Obtener el tipo de comentario con el que se debe crear el comentario
        nuPaso := 110;
        BEGIN
            nuTipoComentario := dald_parameter.fnuGetNumeric_Value('TIPO_COMENTARIO_CAMBIO_CONTRAT');
        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'Se presentó un error al consultar el parámetro TIPO_COMENTARIO_CAMBIO_CONTRAT. ' ||
                           SQLERRM;
                ge_boerrors.SetErrorCodeArgument(cnu_ParametrosGenerales, sbError);
                RAISE ex.CONTROLLED_ERROR;

        END;

        nuPaso := 120;
        IF nuTipoComentario IS NULL THEN
            sbError := 'El parámetro TIPO_COMENTARIO_CAMBIO_CONTRAT no tiene valor';
            ge_boerrors.SetErrorCodeArgument(cnu_ParametrosGenerales, sbError);
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        nuPaso := 130;
        SELECT COUNT(1)
        INTO   nuExiste
        FROM   GE_COMMENT_TYPE gct
        WHERE  gct.comment_type_id = nutipoComentario;

        nuPaso := 140;
        IF nuExiste = 0 THEN
            sbError := 'No se encontró un tipo de comentario con código ' || nuTipoComentario;
            ge_boerrors.SetErrorCodeArgument(cnu_ParametrosGenerales, sbError);
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        -- Validar si se debe generar el comentario
        nuPaso := 150;
        IF sbGenerarComentarioOT = 'S' THEN
            OS_ADDORDERCOMMENT(inuorderid       => inuOT,
                               inucommenttypeid => nutipoComentario,
                               isbcomment       => substr(isbObservacionCambioContrato ||
                                                          '. Contrato anterior ' || nuContratoActual ||
                                                          '. Contrato nuevo ' || nuContract,
                                                          1,
                                                          2000),
                               onuerrorcode     => nuError,
                               osberrormessage  => sbError);

            IF sbError IS NOT NULL THEN
                ge_boerrors.SetErrorCodeArgument(cnu_ParametrosGenerales, sbError);
                RAISE ex.CONTROLLED_ERROR;
            END IF;

        END IF;
    END IF;
    -- Fin CA200-209

    COMMIT;

    ut_trace.Trace('FIN: LDC_chang_contract_order', 10);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        ut_trace.trace('TERMINÿ CON ERROR ' || csbProceso || '(' || nuPaso || '):' || sbError, 1);
        ERRORS.Geterror(nuError,sbError);
        dbms_output.put_line(sbError);
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ut_trace.trace('TERMINÿ CON ERROR NO CONTROLADO' || csbProceso || '(' ||
                       nuPaso || '):' || SQLERRM,
                       1);
        ERRORS.SETERROR(inuapperrorcode => 2741, isbargument => sbError);
        RAISE EX.CONTROLLED_ERROR;

END LDC_chang_contract_order;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CHANG_CONTRACT_ORDER', 'ADM_PERSON');
END;
/