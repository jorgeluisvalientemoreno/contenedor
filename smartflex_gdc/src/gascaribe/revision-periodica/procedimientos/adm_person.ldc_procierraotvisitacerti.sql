CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PROCIERRAOTVISITACERTI (
    nuProductId        NUMBER,
    ID_ORGANISMO_OIA   NUMBER,                          --unidad operativa oia
    sbCERTIFICADO      VARCHAR2)
IS
    /*******************************************************************************
    Propiedad intelectual  de PROYECTO GASES DEL CARIBE

      Autor         :ESANTIAGO (horbath)
      Fecha         :19-05-2019
      DESCRIPCION   :PROCEDIMIENTO PERIMITE LA LEGAZLIZACION LAS ORDENES DEL TIPO DE TRABAJO(10500) 'VISITA DE ACEPTACION DE CERTIFICACION DE INSTALACIONES'
      CASO          : 200-2464

      Fecha                IDEntrega           Modificacion
      ============    ================    ============================================
      13/08/2019      ESANTIAGO (horbath) Caso: 200-2628 se modifica la forma en  que se obtiene el usuario,
                                          para legalización para obtener el valor del parámetro PERID_GEN_CIOR.
      27/07/2020      OLSOFTWARE         CA 272 se cambia condicional de causal para que valide por clase y no por tipo y se quita
                                         generacion de error, se cambio el manejo de excepciones por el adecuado
      04/02/2021      jBrito Caso: 446    1.  Se debe configurar el parÃ¡metro EST_OR_OIA para que tenga en cuenta el estado 11 â¿¿ Bloqueada
                                          2.  Se crearÃ¡ una variable â¿¿bloqueadoâ¿¿ que recibirÃ¡ el estado configurado en el parÃ¡metro COD_EST_BLO_OT ya existente.
                                          3.  Se crearÃ¡ una condiciÃ³n que validara si el estado de la orden es igual a la variable â¿¿bloqueadoâ¿¿,
                                              si cumple la condiciÃ³n se procederÃ¡ a desbloquear la orden con el api OS_UNLOCKORDER y una vez se
                                              genere el desbloqueo continuara con el proceso de asignaciÃ³n y legalizaciÃ³n.
                                          4.  Se agregar la condiciÃ³n para que genere el log en caso se presente error al desbloquear la orden
      28/07/2023       jpinedc              OSF-1379:
                                            * Se reemplaza os_legalizeorders por
                                            api_legalizeorders
                                            * Se reemplaza OS_ASSIGN_ORDER por API_ASSIGN_ORDER                             
                                            * ge_boerrors.seterrorcodeargument por
                                            pkg_error.setErrorMessage                                         
                                            * Se reemplaza Errors.setError; por
                                            pkg_error.setError;
                                            * Se reemplaza ERRORS.geterror por
                                            pkg_error.getError
                                            * Se cambia when ex.CONTROLLED_ERROR 
                                            por WHEN pkg_error.Controlled_Error
                                            * Se cambia raise ex.Controlled_Error
                                            por pkg_error.Controlled_Error                                        
                                            * Se quitan variables que no se usan
                                            * Se quita codigo que está en comentarios
                                            * Se agrega traza de inicio y fin con ut_trace
                                            * Se agrega pkg_utilidades.prAplicarPermisos
                                            * Se agrega pkg_utilidades.prCrearSinonimos
      09/08/2023       jpinedc              OSF-1379:
                                            * Se reemplaza os_unlockorder por api_unlockorder
      26/04/2024       PACOSTA              OSF-2598: Se crea el objeto en el esquema adm_person                                              
      *******************************************************************************/

    -- Constantes para el control de la traza
    csbSP_NAME                 CONSTANT VARCHAR2(100)         := 'LDC_PROCIERRAOTVISITACERTI.';
    cnuNVLTRC                  CONSTANT NUMBER                := 5;

    causalid          NUMBER;
    causaltype        NUMBER;
    tip_err           VARCHAR (200);
    sbComment         VARCHAR (200);
    lega              NUMBER := 0;
    asignada          NUMBER (1);
    registrada        NUMBER (1);
    bloqueado         NUMBER;                                            
    usuario           NUMBER;
    solicitud         MO_PACKAGES.PACKAGE_ID%TYPE := NULL;
    orden             OR_ORDER.ORDER_ID%TYPE := NULL;
    onuErrorCode      ge_error_log.error_log_id%TYPE;
    osbErrorMessage   ge_error_log.description%TYPE;

    CURSOR cusolord (PRODUC NUMBER)
    IS
        SELECT S.PACKAGE_ID, A.ORDER_ID
          FROM OR_ORDER_ACTIVITY A, MO_PACKAGES S, or_order o
         WHERE     A.TASK_TYPE_ID =
                   TO_NUMBER (
                       dald_parameter.fsbgetvalue_chain ('TIPO_TR_OIA', NULL))
               AND A.PACKAGE_ID = S.PACKAGE_ID
               AND A.ORDER_ID = O.ORDER_ID
               AND S.PACKAGE_TYPE_ID IN
                       (SELECT COLUMN_VALUE
                          FROM TABLE (
                                   ldc_boutilities.splitstrings (
                                       dald_parameter.fsbgetvalue_chain (
                                           'TIPO_SOL_OIA',
                                           NULL),
                                       ',')))
               AND O.ORDER_STATUS_ID IN
                       (SELECT COLUMN_VALUE
                          FROM TABLE (
                                   ldc_boutilities.splitstrings (
                                       dald_parameter.fsbgetvalue_chain (
                                           'EST_OR_OIA',
                                           NULL),
                                       ',')))
               AND a.PRODUCT_ID = PRODUC;
BEGIN

    ut_trace.trace('Inicia ' || csbSP_NAME , cnuNVLTRC); 

    SAVEPOINT cierrvis;

    --SE CARGA VARIABLES PARAMETRIZADAS
    causalid := dald_parameter.fnugetnumeric_value ('CAU_LEG_OIA');
    registrada := dald_parameter.fnugetnumeric_value ('ESTADO_REGISTRADO');
    asignada := dald_parameter.fnugetnumeric_value ('COD_ESTADO_ASIGNADA_OT');
    usuario := dald_parameter.fnuGetNumeric_Value ('PERID_GEN_CIOR'); --caso:200-2628
    bloqueado := dald_parameter.fnuGetNumeric_Value ('COD_EST_BLO_OT', NULL); --442

    -- SE VALIDA QUE EXISTA UNA ORDEN ASOCIADA LA PRODUCTO.
    OPEN cusolord (nuProductId);

    FETCH cusolord INTO solicitud, orden;

    IF cusolord%NOTFOUND
    THEN
        tip_err := '0';
        osbErrorMessage := 'no se encontro solicitud ni orden asociada';

        CLOSE cusolord;

        RETURN;

    END IF;

    CLOSE cusolord;

    -- 446, SE VALIDA SI LA ORDEN ESTA BLOQUEADA.
    IF daor_order.fnugetorder_status_id (orden) = bloqueado
    THEN
    
        api_unlockorder (orden,
                        1296,
                        'desbloqueo',
                        SYSDATE,
                        onuErrorCode,
                        osbErrorMessage);

        IF NVL (onuErrorCode, 0) != 0
        THEN
            tip_err := 'desbloqueo';
            osbErrorMessage :=
                   'Error al desbloquear orden ['
                || TO_CHAR (orden)
                || '] mensaje: ['
                || osbErrorMessage
                || ']';
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;
    END IF;

    -- SE VALIDA SI LA ORDEN ESTA ASIGANADA O REGISTRADA.
    IF daor_order.fnugetorder_status_id (orden) = asignada
    THEN
        lega := 1;
    ELSIF daor_order.fnugetorder_status_id (orden) = registrada
    THEN
        -- SI LA ORDEN ESTA REGISTRADA SE LE ASIGANA LA UNIDAD.
        API_ASSIGN_ORDER (orden,
                         ID_ORGANISMO_OIA,
                         onuErrorCode,
                         osbErrorMessage);

        IF NVL (onuErrorCode, 0) != 0
        THEN
            tip_err := 'asignacion';
            osbErrorMessage :=
                   'Error al asignar orden ['
                || TO_CHAR (orden)
                || '] mensaje: ['
                || osbErrorMessage
                || ']';
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;

        lega := 1;
    END IF;

    --SE OBTIENE EL TIPO DE CAUSAL
    causaltype := dage_causal.fnugeTclass_causal_id (causalid);

    --SE VALIDA clase DE CAUSAL
    IF causaltype != 1
    THEN
        causaltype := 0;
    END IF;

    --SE LEGALIZA LA ORDEN.
    IF lega = 1
    THEN
        sbComment := NULL;

        api_legalizeorders (
               orden
            || '|'
            || causalid
            || '|'
            || usuario                                       /*caso:200-2628*/
            || '|'
            || 'VAL_CERTIFICADO = '
            || sbCERTIFICADO
            || '|'
            || ldc_bcfinanceot.fnuGetActivityId (orden)
            || '>'
            || causaltype
            || ';;;;|||1277;'
            || sbComment,
            SYSDATE,
            SYSDATE,
            NULL,
            onuErrorCode,
            osbErrorMessage);

        IF NVL (onuErrorCode, 0) != 0
        THEN
            tip_err := 'legalizacion';
            RAISE pkg_error.CONTROLLED_ERROR;
        END IF;
    ELSE
        tip_err := 'legalizacion';
        osbErrorMessage :=
            'No se encuantra en una estado valido para legalizar';
        RAISE pkg_error.CONTROLLED_ERROR;
    END IF;

    ut_trace.trace('Termina ' || csbSP_NAME , cnuNVLTRC); 

EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR
    THEN
        ROLLBACK TO cierrvis;
        pkg_error.getError (onuErrorCode, osbErrorMessage);

        INSERT INTO LOG_LDC_PROCIERRAOTVISITACERTI (Num_order,
                                                    Num_producto,
                                                    Fecha_registro,
                                                    Tipo_error,
                                                    Err_mensaje)
             VALUES (orden,
                     solicitud,
                     SYSDATE,
                     tip_err,
                     SUBSTR (osbErrorMessage, 1, 200));
    WHEN OTHERS
    THEN
        ROLLBACK TO cierrvis;
        pkg_error.Seterror;
        pkg_error.geterror (onuErrorCode, osbErrorMessage);

        INSERT INTO LOG_LDC_PROCIERRAOTVISITACERTI (Num_order,
                                                    Num_producto,
                                                    Fecha_registro,
                                                    Tipo_error,
                                                    Err_mensaje)
             VALUES (orden,
                     solicitud,
                     SYSDATE,
                     tip_err,
                     osbErrorMessage);
END LDC_PROCIERRAOTVISITACERTI;
/

PROMPT Otorgando permisos de ejecucion a LDC_PROCIERRAOTVISITACERTI
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PROCIERRAOTVISITACERTI', 'ADM_PERSON');
END;
/
