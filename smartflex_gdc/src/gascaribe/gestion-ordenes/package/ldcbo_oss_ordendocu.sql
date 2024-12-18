CREATE OR REPLACE PACKAGE LDCBO_OSS_ORDENDOCU
AS
    /*******************************************************************************
    Propiedad intelectual de PROYECTO PETI

    Autor                :  Gabriel Gamarra
    Fecha                :  04-02-2015

    Fecha                IDEntrega           Modificacion
    ============    ================    ============================================
    04-Feb-2015     ggamarra            creacion del paquete
    06-Sep-2023     felipe.valencia     Se modifica para cambiar el api os_legalizeorders
                                        a api_legalizeorders
    *******************************************************************************/
        -- Constantes para el control de la traza
    csbSP_NAME 	    CONSTANT VARCHAR2(35)	:='LDCBO_OSS_ORDENDOCU.';
    cnuNVLTRC 	    CONSTANT NUMBER 		:= pkg_traza.cnuNivelTrzDef;
    csbInicio   	CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;
    
    FUNCTION fnuGetLote
        RETURN NUMBER;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : PROC_ASOCIA_LOTE_ORDEN
      Descripcion    : Asocia las ordenes del reporte al lote.

      Autor          : Gabriel Gamarra
      Fecha          : 04/02/2015

      Parametros                  Descripcion
      ============           ===================
      ORDEN_TRABAJO          Orden
      ID_LOTE                Lote

      Historia de Modificaciones
      Fecha            Autor                 Metodos
      =========        =========             ====================
    ******************************************************************/

    PROCEDURE PROC_ASOCIA_LOTE_ORDEN (
        ORDEN_TRABAJO   OR_ORDER.ORDER_ID%TYPE,
        ID_LOTE         ldc_ordenes_docu.id_proceso%TYPE);

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : PROC_LEGALIZA_LOTE_ORDEN
      Descripcion    : Asocia las ordenes del reporte al lote.

      Autor          : Gabriel Gamarra
      Fecha          : 04/02/2015

      Parametros                  Descripcion
      ============           ===================
      ORDEN_TRABAJO               Orden

      Historia de Modificaciones
      Fecha            Autor                 Metodos
      =========        =========             ====================
    ******************************************************************/

    PROCEDURE PROC_LEGALIZA_LOTE_ORDEN (ORDEN_TRABAJO OR_ORDER.ORDER_ID%TYPE);
END;
/

CREATE OR REPLACE PACKAGE BODY LDCBO_OSS_ORDENDOCU
AS
    /*******************************************************************************
     Propiedad intelectual de PROYECTO PETI

     Autor                :  Gabriel Gamarra
     Fecha                :  04-02-2015

     Fecha                IDEntrega           Modificacion
     ============    ================    ============================================
     04-Feb-2015     ggamarra            creacion del paquete
     06-Sep-2023     felipe.valencia     Se modifica para cambiar el api os_legalizeorders
                                        a api_legalizeorders
     *******************************************************************************/

    -- Esta constante se debe modificar cada vez que se entregue el paquete con un SAO
    csbVersion   CONSTANT VARCHAR2 (250) := 'OSF-1388';

    nuError               NUMBER;
    sbError               VARCHAR2 (2000);

    gnuLote               NUMBER;

    FUNCTION fsbVersion
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN csbVersion;
    END;

    /*****************************************************************
        Propiedad intelectual de Open International Systems (c).

        Unidad         : fnuGetLote
        Descripcion    : Obtiene el ID del lote a generar.

        Autor          : Gabriel Gamarra
        Fecha          : 04/02/2015

        Parametros                  Descripcion
        ============           ===================

        Historia de Modificaciones
        Fecha            Autor                 Metodos
        =========        =========             ====================
      ******************************************************************/
    FUNCTION fnuGetLote
        RETURN NUMBER
    IS
        idLote    NUMBER;
        id_user   sa_user.user_id%TYPE;
    BEGIN
        IF gnuLote IS NOT NULL
        THEN
            IF daldc_lotes_ordenes.fblExist (gnuLote)
            THEN
                idLote :=
                    pkgeneralservices.fnugetnextsequenceval (
                        'seqldc_lotes_ordenes');
                gnuLote := idLote;
            ELSE
                idLote := gnuLote;
            END IF;
        ELSE
            idLote :=
                pkgeneralservices.fnugetnextsequenceval (
                    'seqldc_lotes_ordenes');

            gnuLote := idLote;
        END IF;

        RETURN idLote;
    END fnuGetLote;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : PROC_ASOCIA_LOTE_ORDEN
      Descripcion    : Asocia las ordenes del reporte al lote.

      Autor          : Gabriel Gamarra
      Fecha          : 04/02/2015

      Parametros                  Descripcion
      ============           ===================
      ORDEN_TRABAJO          Orden
      ID_LOTE                Lote

      Historia de Modificaciones
      Fecha            Autor                 Metodos
      =========        =========             ====================
    ******************************************************************/

    PROCEDURE PROC_ASOCIA_LOTE_ORDEN (
        ORDEN_TRABAJO   OR_ORDER.ORDER_ID%TYPE,
        ID_LOTE         ldc_ordenes_docu.id_proceso%TYPE)
    IS
        onuErrorCode      NUMBER (18);
        osbErrorMessage   VARCHAR2 (2000);
        rcOrderDocu       daldc_ordenes_docu.styLDC_ORDENES_DOCU;
        rcOrderDocuNull   daldc_ordenes_docu.styLDC_ORDENES_DOCU;

        rcLote            daldc_lotes_ordenes.styLDC_LOTES_ORDENES;
        rcLoteNull        daldc_lotes_ordenes.styLDC_LOTES_ORDENES;
    BEGIN
        pkg_traza.trace(csbSP_NAME||'.PROC_ASOCIA_LOTE_ORDEN', cnuNVLTRC, csbInicio);
    
        rcOrderDocu := rcOrderDocuNull;
        rcLote := rcLoteNull;

        -- Si no existe el lote se inserta
        IF NOT daldc_lotes_ordenes.fblExist (ID_LOTE)
        THEN
            rcLote.id_lote := ID_LOTE;
            rcLote.create_date := TRUNC (SYSDATE);
            rcLote.user_id := PKG_SESSION.GETUSERID;

            -- daldc_lotes_ordenes.insRecord(rcLote);

            --Se coloca dentro de un bloque anonimo ya que el framework esta enviando al mismo tiempo
            --dos ordenes que crea el bloque y falla al hacer el insert por llave primaria ya que se intenta crear dos veces
            --el mismo bloque
            BEGIN
                INSERT INTO ldc_lotes_ordenes (id_lote, create_date, user_id)
                         VALUES (rcLote.id_lote,
                                 rcLote.create_date,
                                 rcLote.user_id);

                COMMIT;
            EXCEPTION
                WHEN OTHERS
                THEN
                    NULL;
            END;
        END IF;

        IF NOT daldc_ordenes_docu.fblExist (ORDEN_TRABAJO)
        THEN
            rcOrderDocu.id_orden := ORDEN_TRABAJO;
            rcOrderDocu.id_proceso := ID_LOTE;

            INSERT INTO ldc_ordenes_docu (ID_ORDEN, ID_PROCESO)
                 VALUES (ORDEN_TRABAJO, ID_LOTE);

            --     daldc_ordenes_docu.insRecord(rcOrderDocu);

            COMMIT;
        END IF;

        COMMIT;
        pkg_traza.trace(csbSP_NAME||'.PROC_ASOCIA_LOTE_ORDEN', cnuNVLTRC, pkg_traza.csbFIN);
    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_error.setError;
            pkg_error.getError(onuErrorCode, osbErrorMessage);
            pkg_traza.trace(csbSP_NAME||'.PROC_ASOCIA_LOTE_ORDEN'||' '||osbErrorMessage, cnuNVLTRC);
            pkg_traza.trace(csbSP_NAME||'.PROC_ASOCIA_LOTE_ORDEN', cnuNVLTRC, pkg_traza.csbFIN_ERC);
            ROLLBACK;
    END PROC_ASOCIA_LOTE_ORDEN;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : PROC_LEGALIZA_LOTE_ORDEN
    Descripcion    : Asocia las ordenes del reporte al lote.

    Autor          : Gabriel Gamarra
    Fecha          : 04/02/2015

    Parametros                  Descripcion
    ============           ===================
    ORDEN_TRABAJO               Orden

    Historia de Modificaciones
    Fecha            Autor                 Metodos
    =========        =========             ====================
  ******************************************************************/

    PROCEDURE PROC_LEGALIZA_LOTE_ORDEN (ORDEN_TRABAJO OR_ORDER.ORDER_ID%TYPE)
    IS
        nuCausal               NUMBER;

        --CURSOR PARA GENERAR CADENA QUE SERA TULIZADA PARA LEGALIZAR LA ORDEN
        CURSOR CUCADENALEGALIZACION (NUORDER_ID OR_ORDER.ORDER_ID%TYPE)
        IS
            SELECT    O.ORDER_ID
                   || '|3001|'
                   || pkg_bopersonal.fnugetPersonaId
                   || '||'
                   || A.ORDER_ACTIVITY_ID
                   || '>1;;;;|||1277;'
                   || 'ORDEN DE DOCUMENTACION LEGALIZADA POR LDCLOD'    CADENALEGALIZACION
              FROM OR_ORDER O, OR_ORDER_ACTIVITY A
             WHERE     O.ORDER_ID = A.ORDER_ID
                   AND O.ORDER_ID = TO_NUMBER (NUORDER_ID);

        CURSOR cuCausal (inuTask NUMBER)
        IS
            SELECT ge_causal.causal_id
              FROM or_task_type_causal, ge_causal
             WHERE     task_type_id = inuTask
                   AND or_task_type_causal.causal_id = ge_causal.causal_id
                   AND ge_causal.class_causal_id = 1
                   AND ROWNUM = 1;

        SBCADENALEGALIZACION   VARCHAR2 (4000);

        nuEstadoOT             or_order.order_status_id%type;

        onuErrorCode           NUMBER (18);
        osbErrorMessage        VARCHAR2 (2000);
    BEGIN
        pkg_traza.trace(csbSP_NAME||'.PROC_LEGALIZA_LOTE_ORDEN', cnuNVLTRC, csbInicio);
        nuEstadoOT := PKG_BCORDENES.FNUOBTIENEESTADO (ORDEN_TRABAJO);

        IF nuEstadoOT IN (5, 6, 7)
        THEN
            SBCADENALEGALIZACION := NULL;

            IF (CUCADENALEGALIZACION%ISOPEN) THEN
                CLOSE CUCADENALEGALIZACION;
            END IF;

            OPEN CUCADENALEGALIZACION (ORDEN_TRABAJO);
            FETCH CUCADENALEGALIZACION INTO SBCADENALEGALIZACION;
            CLOSE CUCADENALEGALIZACION;

            api_legalizeorders  (SBCADENALEGALIZACION,
                               SYSDATE,
                               SYSDATE,
                               SYSDATE,
                               onuErrorCode,
                               osbErrorMessage);

            

            IF (onuErrorCode <> 0)
            THEN
                ut_trace.trace (
                       'ERROR AL LEGALIZAR LA ORDEN ['
                    || ORDEN_TRABAJO
                    || '] '
                    || onuErrorCode
                    || ' - '
                    || osbErrorMessage,
                    10);
                ROLLBACK;
            ELSE
                COMMIT;
                ut_trace.trace ('OK', 10);
            END IF;
        ELSE
            ut_trace.trace (
                'ERROR AL LEGALIZAR LA ORDEN. NO SE ENCUENTRA EN ESTADO VALIDO PARA LEGALIZAR',
                10);
        END IF;
        pkg_traza.trace(csbSP_NAME||'.PROC_LEGALIZA_LOTE_ORDEN', cnuNVLTRC, pkg_traza.csbFIN);
    END PROC_LEGALIZA_LOTE_ORDEN;
END;
/
PROMPT Otorgando permisos de ejecución sobre LDCBO_OSS_ORDENDOCU
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCBO_OSS_ORDENDOCU','OPEN');
END;
/
