CREATE OR REPLACE PACKAGE ldc_pkgestprexclurp
IS

/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    LDC_PKGESTPREXCLURP
    Autor       :   Horbath
    Fecha       :   12/11/2020
    Descripcion :   Paquete con los objetos para suspensión
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     28-07-2023  OSF-1357    * Se reemplaza os_legalizeorders por
                                        api_legalizeorders
                                        * Se reemplaza OS_ASSIGN_ORDER por API_ASSIGN_ORDER
                                        * Se reemplaza OS_RegisterRequestWithXML por
                                        API_REGISTERREQUESTBYXML
                                        * Se reemplaza os_related_order
                                        por API_RELATED_ORDER
                                        * ge_boerrors.seterrorcodeargument por
                                        pkg_error.setErrorMessage
                                        * Se reemplaza Errors.setError; por
                                        pkg_error.setError;
                                        * Se reemplaza Errors.setError(2741,'..') por
                                        pkg_error.setErrorMessage
                                        * Se reemplaza ERRORS.geterror por
                                        pkg_error.getError
                                        * Se cambia when ex.CONTROLLED_ERROR
                                        por WHEN pkg_error.Controlled_Error
                                        * Se cambia raise ex.Controlled_Error
                                        por pkg_error.Controlled_Error
                                        * Se quita RAISE pkg_Error.controlled_error
                                        después de pkg_error.setErrorMessage
                                        * Se quitan variables que no se usan
                                        * Se quita codigo que está en comentarios
                                        * Se reemplaza signo de interrogación
                                        * Se quita flbAplicaEntregaXCaso
                                        * Se agrega traza de inicio y fin con ut_trace
                                        * Se agrega pkg_utilidades.prAplicarPermisos
                                        * Se agrega pkg_utilidades.prCrearSinonimos
    adrianavg     05-03-2024  OSF-2388  * Se aplican pautas técnicas y se reemplazan servicios homólogos                                       
*******************************************************************************/

    sbMotivo       ge_boInstanceControl.stysbValue;
    sbFechaIni     ge_boInstanceControl.stysbValue;
    sbFechaFin     ge_boInstanceControl.stysbValue;
    sbdateformat   VARCHAR2 (100);              --se almacena formato de fecha
    dtFechaIni     DATE;
    dtFechaFin     DATE;

    PROCEDURE insprodexclrp (
        nuProducto   IN     LDC_PRODEXCLRP.PRODUCT_ID%TYPE,
        sbMotivo     IN     LDC_PRODEXCLRP.MOTIVO%TYPE,
        nuOrden      IN     LDC_PRODEXCLRP.ORDER_ID%TYPE,
        onuError        OUT NUMBER,
        osbError        OUT VARCHAR2);

    /*****************************************************************
     Propiedad intelectual de GDC (c).

     Unidad         : insprodexclrp
     Descripcion    : proceso que inserta en la tabla LDC_PRODEXCLRP
     Autor          : Luis Javier Lopez / Horbath
     Ticket         : 337
     Fecha          : 12/11/2020


     datos Entrada
        nuProducto    codigo de producto
        sbMotivo      motivo
        nuOrden       codigo de orden

     Datos salida
        onuError     codigo de error
        osbError     mensaje de error

     Nombre         :
     Parametros         Descripcion
     ============  ===================
       Historia de Modificaciones
     Fecha             Autor             Modificacion
     =========         =========         ====================
     ******************************************************************/

    PROCEDURE delprodexclrp (
        nuProducto   IN     LDC_PRODEXCLRP.PRODUCT_ID%TYPE,
        sbMotivo     IN     LDC_PRODEXCLRP.MOTIVO%TYPE,
        onuError        OUT NUMBER,
        osbError        OUT VARCHAR2);

    /*****************************************************************
     Propiedad intelectual de GDC (c).

     Unidad         : delprodexclrp
     Descripcion    : proceso que elimina en la tabla LDC_PRODEXCLRP
     Autor          : Luis Javier Lopez / Horbath
     Ticket         : 337
     Fecha          : 12/11/2020


     datos Entrada
        nuProducto    codigo de producto
        sbMotivo      motivo

     Datos salida
        onuError     codigo de error
        osbError     mensaje de error

     Nombre         :
     Parametros         Descripcion
     ============  ===================
       Historia de Modificaciones
     Fecha             Autor             Modificacion
     =========         =========         ====================
     ******************************************************************/

    PROCEDURE PLUPREDIDEMO;

    /*****************************************************************
    Propiedad intelectual de GDC (c).

    Unidad         : PLUPREDIDEMO
    Descripcion    : plugin que se encarga de insertar en la tabla LDC_PRODEXCLRP con motivo predio demolido
    Autor          : Luis Javier Lopez / Horbath
    Ticket         : 337
    Fecha          : 12/11/2020


    datos Entrada

    Datos salida

    Nombre         :
    Parametros         Descripcion
    ============  ===================
      Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
     17/05/2021        HORBATH           CA 693 validar que no exista una orden en proceso
    ******************************************************************/

    PROCEDURE LEGALIZAORDSUSPEN;

    /*****************************************************************
    Propiedad intelectual de GDC (c).

    Unidad         : LEGALIZAORDSUSPEN
    Descripcion    : proceso que legaliza ordenes de suspension
    Autor          : Luis Javier Lopez / Horbath
    Ticket         : 337
    Fecha          : 12/11/2020


    datos Entrada

    Datos salida

    Nombre         :
    Parametros         Descripcion
    ============  ===================
      Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    ******************************************************************/

    PROCEDURE GENSUSPXIMPTEC;

    /*****************************************************************
    Propiedad intelectual de GDC (c).

    Unidad         : GENSUSPXIMPTEC
    Descripcion    : plugin que se encarga de generar tramite de suspensione insertar en la tabla
                      LDC_ASIGNA_SUSPENSION
    Autor          : Luis Javier Lopez / Horbath
    Ticket         : 337
    Fecha          : 12/11/2020


    datos Entrada

    Datos salida

    Nombre         :
    Parametros         Descripcion
    ============  ===================
      Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    ******************************************************************/

    PROCEDURE JOBPREDDEMO;

    /*****************************************************************
    Propiedad intelectual de GDC (c).

    Unidad         : JOBPREDDEMO
    Descripcion    : Job que se necarga de marcar los predios sin medidor
    Autor          : Luis Javier Lopez / Horbath
    Ticket         : 337
    Fecha          : 12/11/2020


    datos Entrada

    Datos salida

    Nombre         :
    Parametros         Descripcion
    ============  ===================
      Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    19/05/2021        horbath           ca 693 agregar  la validación de estado del producto activo y que el producto se encuentre vencido
                                        legalizar ordenes no ejecutadas
    ******************************************************************/

    FUNCTION FUNVALEXCLURP (inuProducto IN NUMBER)
        RETURN NUMBER;

    /*****************************************************************
      Propiedad intelectual de GDC (c).

      Unidad         : FUNVALEXCLURP
      Descripcion    : funcion que retorna si el producto esta excluido
      Autor          : Luis Javier Lopez / Horbath
      Ticket         : 337
      Fecha          : 12/11/2020


      datos Entrada
          inuProducto codigo del producto
      Datos salida

      Nombre         :
      Parametros         Descripcion
      ============  ===================
        Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
    ******************************************************************/

    FUNCTION FRCGETDELEXCLPR
        RETURN constants_per.tyrefcursor;

    /*****************************************************************
     Propiedad intelectual de GDC (c).

     Unidad         : FRCGETDELEXCLPR
     Descripcion    : funcion que retorna informacion para el PB LDCDELEXCLPR
     Autor          : Luis Javier Lopez / Horbath
     Ticket         : 337
     Fecha          : 12/11/2020


     datos Entrada
         inuProducto codigo del producto
     Datos salida

     Nombre         :
     Parametros         Descripcion
     ============  ===================
       Historia de Modificaciones
     Fecha             Autor             Modificacion
     =========         =========         ====================
    05-03-2024        adrianavg         OSF-2388: Se reemplaza constants.tyrefcursor por constants_per.tyrefcurso     
   ******************************************************************/
    PROCEDURE PRDELEXCLPR (
        isbcodigo      IN     VARCHAR2,
        inucurrent     IN     NUMBER,
        inutotal       IN     NUMBER,
        onuerrorcode      OUT ge_error_log.message_id%TYPE,
        osberrormess      OUT ge_error_log.description%TYPE);

    /**************************************************************************
        Autor       : Luis Javier Lopez Barrios / Horbath
        Proceso     : PRDELEXCLPR
        Fecha       : 2020-13-03
        Ticket      : 337
        Descripcion : Proceso que elimina producto excluido del  PB [LDCDELEXCLPR]

        Parametros Entrada
          isbcodigo  codigo
          inucurrent  valor actual
          inutotal    total
        Valor de salida
          onuerrorcode  codigo de error
          osberrormess  mensaje de error
        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION

      ***************************************************************************/

    PROCEDURE PROINSEXCLPR;

    /**************************************************************************
     Autor       : Luis Javier Lopez Barrios / Horbath
     Proceso     : PROINSEXCLPR
     Fecha       : 2020-13-03
     Ticket      : 337
     Descripcion : Proceso que lee archivo plano del  PB [LDCCAREXCLPR]

     Parametros Entrada

     Valor de salida

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION

   ***************************************************************************/

    PROCEDURE PRELIPROEXSMPDRP;

    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Proceso     : PRELIPROEXSMPDRP
      Fecha       : 2021-01-08
      Ticket      : 337
      Descripcion : Plugin que elimina productos excluidos sin medidor y predio demolido

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/

    PROCEDURE PRPROCGENVSI;

    /**************************************************************************
       Autor       : Horbath
       Fecha       : 2019-08-01
       Ticket      : 200-2630
       Descripcion : plugin para generar VSI.

       Parametros Entrada

       Valor de salida

       HISTORIA DE MODIFICACIONES
       FECHA        AUTOR       DESCRIPCION
       09/12/2020   dvaliente   Se obtiene el comentario de legalizacion y se anexo al comentario de la nueva solicitud VSI. (Caso 132)*/

    PROCEDURE PRGEMARANILLDENTRO;
/**************************************************************************
  Autor       :  Horbath
  Proceso     : PRGEMARANILLDENTRO
  Fecha       : 2021-05-17
  Ticket      : 693
  Descripcion : Plugin que genera marcacion en la tabla LDC_PRODEXCLRP con el motivo
                Anillo pasa por dentro

  Parametros Entrada

  Valor de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION

***************************************************************************/
END LDC_PKGESTPREXCLURP;


/


CREATE OR REPLACE PACKAGE BODY LDC_PKGESTPREXCLURP
IS
    /******************************************************************
    Fecha       Autor            Modificación
    =========   =========        ====================
    05-03-2024  adrianavg        OSF-2388: 
                                 Se reemplaza 'LDC_PKGESTPREXCLURP.' por $$PLSQL_UNIT||'.' 
                                 Se reemplaza valor de nivel de traza 5 por pkg_traza.cnuNivelTrzDef
                                 Se adiciona declaración variables de traza csbInicio y csbFin
                                 Se reemplaza ut_trace por pkg_traza
                                 Se cambian parametros del pkg_traza.trace
    ******************************************************************/
    -- Constantes para el control de la traza
    csbSP_NAME                 CONSTANT VARCHAR2(100)         := $$PLSQL_UNIT||'.';
    cnuNVLTRC                  CONSTANT NUMBER                := pkg_traza.cnuNivelTrzDef;
	csbInicio   	           CONSTANT VARCHAR2(35) 	      := pkg_traza.csbINICIO; 
    csbFin         	           CONSTANT VARCHAR2(35) 	      := pkg_traza.csbFIN;

    PROCEDURE PRINICIALIZAERROR (onuError OUT NUMBER, osbError OUT VARCHAR2)
    IS
        /******************************************************************
        Fecha       Autor            Modificación
        =========   =========        ====================
        05-03-2024  adrianavg        OSF-2388: se reemplaza 'prinicializaError' por csbSP_NAME||'prinicializaError'
                                     Se aumenta tamaño a la variable csbMT_NAME VARCHAR2(30) por VARCHAR2(40) 
        ******************************************************************/    
        -- Nombre de éste método
        csbMT_NAME  VARCHAR2(40) := csbSP_NAME||'prinicializaError';
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        onuError := 0;
        osbError := NULL;
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    END PRINICIALIZAERROR;

    PROCEDURE INSPRODEXCLRP (
        nuproducto IN ldc_prodexclrp.product_id%TYPE,
        sbmotivo   IN ldc_prodexclrp.motivo%TYPE,
        nuorden    IN ldc_prodexclrp.order_id%TYPE,
        onuerror   OUT NUMBER,
        osberror   OUT VARCHAR2
    )
    IS
        /*****************************************************************
        Propiedad intelectual de GDC (c).

        Unidad         : insprodexclrp
        Descripcion    : proceso que inserta en la tabla LDC_PRODEXCLRP
        Autor          : Luis Javier Lopez / Horbath
        Ticket         : 337
        Fecha          : 12/11/2020

        Datos Entrada
        nuProducto    codigo de producto
        sbMotivo      motivo
        nuOrden       codigo de orden

        Datos salida
        onuError     codigo de error
        osbError     mensaje de error

        Nombre         :
        Parametros         Descripcion
        ============  ===================
        Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========         =========         ====================
        05-03-2024          adrianavg       OSF-2388: se reemplaza 'insprodexclrp' por csbSP_NAME||'insprodexclrp'
                                            Se aumenta tamaño a la variable csbMT_NAME VARCHAR2(30) por VARCHAR2(35) 
                                            Se ajusta bloque de excepciones según pautas técnicas
         ******************************************************************/

        CURSOR cuValGas IS
            SELECT 1
              FROM pr_product
             WHERE product_id = nuProducto AND product_type_id = 7014;

        nuExiste   NUMBER;

        -- Nombre de éste método
        csbMT_NAME  VARCHAR2(35) := csbSP_NAME||'insprodexclrp';

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        --se inicializa variables de error
        prinicializaError (onuError, osbError);

        pkg_traza.trace(csbMT_NAME||' nuproducto: '||nuproducto, cnuNVLTRC );
        pkg_traza.trace(csbMT_NAME||' sbmotivo: '||sbmotivo, cnuNVLTRC );
        pkg_traza.trace(csbMT_NAME||' nuorden: '||nuorden, cnuNVLTRC ); 

        OPEN cuValGas;
        FETCH cuValGas INTO nuExiste;
        IF cuValGas%NOTFOUND THEN
            CLOSE cuValGas;
            pkg_traza.trace(csbMT_NAME||' El producto  [' || nuProducto  || '] no existe o no es de tipo gas', cnuNVLTRC); 
            pkg_error.setErrorMessage ( isbMsgErrr =>  'El producto  [' || nuProducto  || '] no existe o no es de tipo gas');
        END IF;
        CLOSE cuValGas;

        INSERT INTO ldc_prodexclrp (
            codigo,
            product_id,
            motivo,
            order_id,
            fech_exclu
        ) VALUES (
            seq_prodexclrp.NEXTVAL,
            nuproducto,
            sbmotivo,
            nuorden,
            sysdate
        );
        pkg_traza.trace(csbMT_NAME||' INSERT INTO ldc_prodexclrp, product_id= '||nuproducto, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_error.getError (onuerror, osberror); 
             pkg_traza.trace(csbMT_NAME ||' osberror: ' || osberror, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);           

        WHEN OTHERS THEN
             pkg_error.setError;
             pkg_error.getError (onuerror, osberror);
             pkg_traza.trace(csbMT_NAME ||' osberror: ' || osberror, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
    END INSPRODEXCLRP;

    PROCEDURE DELPRODEXCLRP (
        nuproducto IN ldc_prodexclrp.product_id%TYPE,
        sbmotivo   IN ldc_prodexclrp.motivo%TYPE,
        onuerror   OUT NUMBER,
        osberror   OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de GDC (c).
        
        Unidad         : delprodexclrp
        Descripcion    : proceso que elimina en la tabla LDC_PRODEXCLRP
        Autor          : Luis Javier Lopez / Horbath
        Ticket         : 337
        Fecha          : 12/11/2020
        
        Datos Entrada
        nuProducto    codigo de producto
        sbMotivo      motivo
        
        Datos salida
        onuError     codigo de error
        osbError     mensaje de error
        
        Nombre         :
        Parametros         Descripcion
        ============  ===================
        Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========         =========         ====================
        05-03-2024          adrianavg       OSF-2388: se reemplaza 'delprodexclrp' por csbSP_NAME||'delprodexclrp'
                                            Se aumenta tamaño a la variable csbMT_NAME VARCHAR2(30) por VARCHAR2(35)         
                                            Se ajusta bloque de excepciones según pautas técnicas
         ******************************************************************/
        -- Nombre de éste método
        csbMT_NAME  VARCHAR2(35) := csbSP_NAME||'delprodexclrp';

        sbdatos   VARCHAR2 (1);

        CURSOR cuExisteProdu IS
            SELECT 'X'
              FROM LDC_PRODEXCLRP
             WHERE PRODUCT_ID = nuProducto AND MOTIVO = sbMotivo;

    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        --se inicializa variables de error
        prinicializaError (onuError, osbError);

        pkg_traza.trace(csbMT_NAME||' nuproducto: '||nuproducto, cnuNVLTRC );
        pkg_traza.trace(csbMT_NAME||' sbmotivo: '||sbmotivo, cnuNVLTRC );

        OPEN cuExisteProdu;
        FETCH cuExisteProdu INTO sbdatos;
        pkg_traza.trace(csbMT_NAME||' ExisteProdu: '||NVL(sbdatos, 'NO EXISTE'), cnuNVLTRC );
        IF cuExisteProdu%FOUND THEN
            DELETE FROM LDC_PRODEXCLRP WHERE PRODUCT_ID = nuProducto AND MOTIVO = sbMotivo;
            pkg_traza.trace(csbMT_NAME||' DELETE FROM LDC_PRODEXCLRP ', cnuNVLTRC );
        END IF;
        CLOSE cuExisteProdu;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_error.getError (onuerror, osberror);
             pkg_traza.trace(csbMT_NAME ||' osberror: ' || osberror, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
             pkg_error.setError;
             pkg_error.getError (onuerror, osberror);
             pkg_traza.trace(csbMT_NAME ||' osberror: ' || osberror, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
    END DELPRODEXCLRP;

    PROCEDURE PLUPREDIDEMO
    IS
        /*****************************************************************
       Propiedad intelectual de GDC (c).

       Unidad         : PLUPREDIDEMO
       Descripcion    : plugin que se encarga de insertar en la tabla LDC_PRODEXCLRP con motivo predio demolido
       Autor          : Luis Javier Lopez / Horbath
       Ticket         : 337
       Fecha          : 12/11/2020

       Datos Entrada

       Datos salida

       Nombre         :
       Parametros         Descripcion
       ============  ===================
       
       Historia de Modificaciones
       Fecha             Autor             Modificacion
       =========         =========         ====================
       17/05/2021        HORBATH           CA 693 validar que no exista una orden en proceso
       05-03-2024        Adrianavg         OSF-2388: se reemplaza 'plupredidemo' por csbSP_NAME||'plupredidemo'
                                           Se aumenta tamaño a la variable csbMT_NAME VARCHAR2(30) por VARCHAR2(32)
                                           Se reemplaza or_boorderactivities.CreateActivity por api_createorder
                                           Se reemplaza or_bolegalizeorder.fnuGetCurrentOrder por pkg_bcordenes.fnuobtenerotinstancialegal
       ******************************************************************/
        -- Nombre de éste método
        csbMT_NAME  VARCHAR2(32) := csbSP_NAME||'plupredidemo';

        nuorden              NUMBER;            --Se almacena orden de trabajo
        nuactividagen        NUMBER            := daldc_pararepe.fnugetparevanu ('ACT_VISITA_TECNICAXSUSP',   NULL);
        sbMotivoPred         VARCHAR2 (2000)   := Daldc_pararepe.fsbGetPARAVAST ('MOTIEXCLU_PREDEMORP', NULL);

        OnuOrderId           NUMBER;
        OnuOrderActivityId   NUMBER;
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);

        --se obtiene  actvidad de la orden
        CURSOR cuValdemo IS
        SELECT oa.product_id, oa.address_id, oa.subscriber_id, oa.subscription_id, c.order_comment
          FROM or_order_activity oa, or_order_comment C
         WHERE oa.order_id = nuorden
           AND oa.order_id = c.order_id
           AND c.legalize_comment = 'Y';

        regOrden             cuValdemo%ROWTYPE;

        --INICIO CA 693
        CURSOR cuValidaOrden (inuproducto IN NUMBER) IS
        SELECT 'X'
          FROM or_order o, or_order_activity oa
         WHERE o.order_id = oa.order_id
           AND OA.activity_id = nuactividagen
           AND oa.product_id = inuproducto
           AND o.order_status_id NOT IN (SELECT e.order_status_id
                                           FROM or_order_status e
                                          WHERE E.IS_FINAL_STATUS = 'Y');

        sbExisteOrd          VARCHAR2 (1);
    --FIN CA 693
    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        --Obtener el identificador de la orden  que se encuentra en la instancia
        nuorden := pkg_bcordenes.fnuobtenerotinstancialegal;
        pkg_traza.trace(csbMT_NAME||' Numero de la Orden:' || nuorden, cnuNVLTRC);

        OPEN cuValdemo;
        FETCH cuValdemo INTO regOrden;
        IF cuValdemo%NOTFOUND THEN
            CLOSE cuValdemo;
            pkg_traza.trace(csbMT_NAME||' No se encontro informacion para la orden  [' || nuorden || '].', cnuNVLTRC); 
            pkg_error.setErrorMessage ( isbMsgErrr => 'No se encontro informacion para la orden  [' || nuorden || '].');
        END IF;
        CLOSE cuValdemo;

        pkg_traza.trace(csbMT_NAME||' nuactividagen: '||nuactividagen, cnuNVLTRC );
        pkg_traza.trace(csbMT_NAME||' sbMotivoPred: '||sbMotivoPred, cnuNVLTRC );

        IF nuactividagen IS NULL  THEN
            pkg_traza.trace(csbMT_NAME||' El parametro ACT_VISITA_TECNICAXSUSP no esta configurado', cnuNVLTRC); 
            pkg_error.setErrorMessage ( isbMsgErrr => 'El parametro ACT_VISITA_TECNICAXSUSP no esta configurado');
        END IF;

        pkg_traza.trace(csbMT_NAME||' product_id: '||regOrden.product_id, cnuNVLTRC ); 

        OPEN cuValidaOrden (regOrden.product_id);
        FETCH cuValidaOrden INTO sbExisteOrd;
        CLOSE cuValidaOrden;
        pkg_traza.trace(csbMT_NAME||' sbExisteOrd: '||sbExisteOrd, cnuNVLTRC );

        IF sbExisteOrd IS NULL THEN
                pkg_traza.trace(csbMT_NAME||' address_id: '||regOrden.address_id, cnuNVLTRC ); 
                pkg_traza.trace(csbMT_NAME||' subscriber_id: '||regOrden.subscriber_id, cnuNVLTRC ); 
                pkg_traza.trace(csbMT_NAME||' subscription_id: '||regOrden.subscription_id, cnuNVLTRC ); 
                pkg_traza.trace(csbMT_NAME||' order_comment: '||regOrden.order_comment, cnuNVLTRC ); 
            BEGIN
                api_createorder (
                    nuactividagen,              --inuItemsid
                    NULL,                       --inuPackage,
                    NULL,                       --nuMotive,
                    NULL,                       --inuComponentid
                    NULL,                       --inuInstanceid
                    regOrden.address_id,        --inuAddressid
                    NULL,                       --inuElementid
                    regOrden.subscriber_id,     --inuSubscriberid
                    regOrden.subscription_id,   --inuSubscriptionid
                    regOrden.product_id,        --inuProductid
                    NULL,                       --inuOperunitid
                    NULL,                       --idtExecestimdate
                    NULL,                       --inuProcessid
                    regOrden.order_comment,     --isbComment
                    NULL,                       --iblProcessorder
                    NULL,                       --inuPriorityid
                    NULL,                       --inuOrdertemplateid
                    NULL,                       --isbCompensate
                    NULL,                       --inuConsecutive
                    NULL,                       --inuRouteid
                    NULL,                       --inuRouteConsecutive
                    NULL,                       --inuLegalizetrytimes
                    NULL,                       --isbTagname
                    NULL,                       --iblIsacttoGroup
                    NULL,                       --inuRefvalue
                    NULL,                       --inuActionid
                    OnuOrderId,                 --ionuOrderid
                    OnuOrderActivityId,         --ionuOrderactivityid
                    nuerror,                    --onuErrorCode
                    sbError                     --osbErrorMessage
                                                );
            EXCEPTION
                WHEN pkg_error.CONTROLLED_ERROR THEN
                     pkg_error.getError (nuerror, sbError);
                     pkg_traza.trace(csbMT_NAME ||' ERROR EN api_createorder--> sbError: ' || sbError, cnuNVLTRC);
                WHEN OTHERS  THEN
                     pkg_error.setError;
                     pkg_error.getError (nuerror, sbError);
                     pkg_traza.trace(csbMT_NAME ||' ERROR EN api_createorder--> sbError: ' || sbError, cnuNVLTRC);
            END;       

            IF nuerror <> 0 THEN
                pkg_traza.trace(csbMT_NAME||' Error al generar la orden con la actividad [' || DAGE_ITEMS.FSBGETDESCRIPTION  (  'ACT_VISITA_TECNICAXSUSP',  NULL)  || ']: ', cnuNVLTRC);
                pkg_error.setErrorMessage ( isbMsgErrr => 'Error al generar la orden con la actividad [' || DAGE_ITEMS.FSBGETDESCRIPTION (  'ACT_VISITA_TECNICAXSUSP',  NULL)  || ']: '  || sbError);
            ELSE

                pkg_traza.trace(csbMT_NAME||' OnuOrderId: '||OnuOrderId, cnuNVLTRC );
                pkg_traza.trace(csbMT_NAME||' OnuOrderActivityId: '||OnuOrderActivityId, cnuNVLTRC );

                --se relaciona orden
                API_RELATED_ORDER (nuorden,
                                   OnuOrderId,
                                   nuerror,
                                   sbError);

                IF nuerror <> 0  THEN
                    pkg_traza.trace(csbMT_NAME||' Error al relacionar orden de trabajo: '|| sbError, cnuNVLTRC); 
                    pkg_error.setErrorMessage ( isbMsgErrr => 'Error al relacionar orden de trabajo: '|| sbError);
                END IF;

                --se inserta en la tabla de productos excluidos
                insprodexclrp (regOrden.product_id,
                               sbMotivoPred,
                               nuOrden,
                               nuerror,
                               sbError);

                IF nuerror <> 0 THEN
                    pkg_traza.trace(csbMT_NAME||' Error al crear registro de producto excluido: ' || sbError, cnuNVLTRC);
                    pkg_error.setErrorMessage ( isbMsgErrr => 'Error al crear registro de producto excluido: ' || sbError);
                END IF;
            END IF;
        END IF;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_Error.getError(nuerror, sbError);
             pkg_traza.trace(csbMT_NAME ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError||', Backtrace '||DBMS_UTILITY.format_error_backtrace, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
             RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
             pkg_error.setError;
             pkg_Error.getError(nuerror, sbError);
             pkg_traza.trace(csbMT_NAME ||' Error WHEN OTHERS, sbError: ' || sbError||', Backtrace '||DBMS_UTILITY.format_error_backtrace, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
             RAISE pkg_error.CONTROLLED_ERROR;
    END PLUPREDIDEMO;

    PROCEDURE GESTIONAORDEXCLURP (
        inusolicitud   IN NUMBER,
        inuorden       IN NUMBER,
        inuproducto    IN NUMBER,
        inuorderactivi IN NUMBER,
        onuerror       OUT NUMBER,
        osberror       OUT VARCHAR2
    ) IS
        /*****************************************************************
        Propiedad intelectual de GDC (c).

        Unidad         : GESTIONAORDEXCLURP
        Descripcion    : proceso que se encargar de asignar y legalizar las ordenes generas por el proceso de exclusión de RP
        Autor          : Luis Javier Lopez / Horbath
        Ticket         : 337
        Fecha          : 12/11/2020

        datos Entrada
        inuSolicitud    codigo de la solicitud
        inuOrden        codigo de la orden
        inuProducto     codigo del producto
        inuOrderactivi  codigo de la actividad

        Datos salida
        onuError        codigo de error
        osbError        mensaje de error

        Nombre         :
        Parametros         Descripcion
        ============  ===================
        Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========         =========         ====================
        05-03-2024          adrianavg        OSF-2388: se reemplaza 'gestionaordexclurp' por csbSP_NAME||'gestionaordexclurp'
                                             Se aumenta tamaño a la variable csbMT_NAME VARCHAR2(30) por VARCHAR2(40)
                                             Se retira esquema OPEN antepuesto a lectelme
                                             Se retira código comentariado
                                             Adicionar Pkg_Error.SetError; antes del RAISE en el IF-endif onuError <> 0
                                             Se reemplaza daor_order.fnugettask_type_id por pkg_bcordenes.fnuobtienetipotrabajo
                                             Se reemplaza dald_parameter.fnugetnumeric_value por pkg_bcld_parameter.fnuobtienevalornumerico
                                             Se ajusta bloque de excepciones según pautas técnicas
        ******************************************************************/
        -- Nombre de éste método
        csbMT_NAME           VARCHAR2(40) := csbSP_NAME||'gestionaordexclurp';

        nuunidadoperativa    NUMBER            := daldc_pararepe.fnugetparevanu ('UNIT_DUMMY_RP', NULL);
        nuCausal             NUMBER            := daldc_pararepe.fnugetparevanu ('CAUSAL_SUSPEN_IMPOTEC', NULL);
        nuPersona            NUMBER            := pkg_bcld_parameter.fnuobtienevalornumerico ('PERID_GEN_CIOR');
        nuClaseCausal        NUMBER;
        sbCadenalega         VARCHAR2 (4000);
        nuLectura            NUMBER;
        sbmedidor            elmesesu.emsscoem%TYPE; 

        CURSOR cugetmedidor IS
        SELECT emsscoem
          FROM elmesesu
         WHERE emsssesu = inuProducto
           AND SYSDATE BETWEEN EMSSFEIN AND EMSSFERE; 

        --se obtiene medidor y lectura
        CURSOR cuultlect IS
        SELECT leemleto
          FROM ( SELECT leemfele, NVL (leemleto, leemlean) leemleto
                   FROM lectelme l
                  WHERE l.leemsesu = inuProducto 
                    AND l.leemclec = 'F'
               ORDER BY leemfele DESC)
         WHERE ROWNUM = 1; 

        CURSOR culect IS
            SELECT leemleto
              FROM (  SELECT leemfele, leemleto
                        FROM lectelme l
                       WHERE l.leemsesu = inuProducto
                         AND l.leemleto IS NOT NULL
                         AND l.LEEMCLEC = 'F'
                    ORDER BY leemfele DESC)
             WHERE ROWNUM = 1;

        CURSOR cuTipoCausal IS
        SELECT DECODE (class_causal_id,  1, 1,  2, 0)  tipo
          FROM ge_causal
         WHERE CAUSAL_ID = nuCausal;

        SBDATOSADICIONALES   VARCHAR2 (4000);

        --CURSOR PARA OBTENER NOMRES DE DATOS ADICIONALES DE UN GRUPO DEL TIPO DE TRABAJO
        CURSOR cugrupo (nutask_type_id   or_task_type.task_type_id%TYPE,
                        NUClasecausal    ge_causal.class_causal_id%TYPE)
        IS
        SELECT *
          FROM or_tasktype_add_data ottd
         WHERE ottd.task_type_id = nutask_type_id
           AND ottd.active = 'Y'
           AND (ottd.use_ = DECODE (NUClasecausal,  1, 'C',  0, 'I')
            OR ottd.use_ = 'B');

        CURSOR cudatoadicional (nuattribute_set_id   ge_attributes_set.attribute_set_id%TYPE)
        IS
        SELECT *
          FROM ge_attributes b
         WHERE b.attribute_id IN  (SELECT a.attribute_id
                                     FROM ge_attrib_set_attrib a
                                    WHERE a.attribute_set_id = nuattribute_set_id);

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        --se inicializa variables de error
        prinicializaError (onuError, osbError);

        pkg_traza.trace(csbMT_NAME||' inusolicitud: '||inusolicitud, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME||' inuorden: '||inuorden, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME||' inuproducto: '||inuproducto, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME||' inuorderactivi: '||inuorderactivi, cnuNVLTRC);
        
        pkg_traza.trace(csbMT_NAME||' nuunidadoperativa: '||nuunidadoperativa, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME||' nuCausal: '||nuCausal, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME||' nuPersona: '||nuPersona, cnuNVLTRC);
        
        IF nuunidadoperativa IS NULL THEN
            pkg_traza.trace(csbMT_NAME||' El parametro UNIT_DUMMY_RP no esta configurado', cnuNVLTRC);
            pkg_error.setErrorMessage ( isbMsgErrr =>  'El parametro UNIT_DUMMY_RP no esta configurado');
        END IF;

        DELETE LDC_BLOQ_LEGA_SOLICITUD  WHERE Package_Id_Gene = inuSolicitud;
        pkg_traza.trace(csbMT_NAME||' DELETE LDC_BLOQ_LEGA_SOLICITUD  WHERE Package_Id_Gene= '||inuSolicitud, cnuNVLTRC);

        -- se procede asignar la orden generada
        API_ASSIGN_ORDER (inuOrden,
                          nuunidadoperativa,
                          onuError,
                          osbError);

        IF onuError <> 0 THEN
            Pkg_Error.SetError; 
            pkg_traza.trace(csbMT_NAME||' Error al asignar la orden generada: ' || osbError, cnuNVLTRC);
            RAISE pkg_error.CONTROLLED_ERROR;
        ELSE
            DBMS_LOCK.sleep (1);
            onuError := 0;
            osbError := NULL;

            OPEN cuTipoCausal;
            FETCH cuTipoCausal INTO nuClaseCausal;
            CLOSE cuTipoCausal;
            pkg_traza.trace(csbMT_NAME||' nuClaseCausal: ' || nuClaseCausal, cnuNVLTRC);

            --cadena datos adicionales
            SBDATOSADICIONALES := NULL;

            FOR rc IN cugrupo (pkg_bcordenes.fnuobtienetipotrabajo (inuOrden),  nuClaseCausal)
            LOOP
                pkg_traza.trace(csbMT_NAME||' Grupo de dato adicional ['|| rc.attribute_set_id
                                                                        || '] asociado al tipo de trabajo ['
                                                                        || rc.task_type_id
                                                                        || ']', cnuNVLTRC); 

                FOR rcdato IN cudatoadicional (rc.attribute_set_id)
                LOOP
                    IF SBDATOSADICIONALES IS NULL THEN
                        SBDATOSADICIONALES := RCDATO.NAME_ATTRIBUTE || '=';
                    ELSE
                        SBDATOSADICIONALES :=  SBDATOSADICIONALES || ';'
                                                                  || RCDATO.NAME_ATTRIBUTE
                                                                  || '=';
                    END IF;

                    pkg_traza.trace(csbMT_NAME||' Dato adicional[' || rcdato.name_attribute || ']', cnuNVLTRC); 
                END LOOP;
            END LOOP;

            --fin cadena datos adicionales

            IF nuClaseCausal = 1 THEN
                --se obtiene medidor
                OPEN cugetmedidor;
                FETCH cugetmedidor INTO sbmedidor;
                CLOSE cugetmedidor;
                pkg_traza.trace(csbMT_NAME||' sbmedidor: '||sbmedidor, cnuNVLTRC); 

                OPEN cuultlect;                
                FETCH cuultlect INTO nulectura;                
                CLOSE cuultlect;

                IF nulectura IS NULL THEN
                    OPEN culect;
                    FETCH culect INTO nulectura;
                    CLOSE culect;
                END IF;
                pkg_traza.trace(csbMT_NAME||' nulectura: '||nulectura, cnuNVLTRC);

                sbCadenalega :=  inuOrden
                                || '|'
                                || nuCausal
                                || '|'
                                || nuPersona
                                || '|'
                                || SBDATOSADICIONALES
                                || '|'
                                || inuOrderactivi
                                || '>'
                                || nuClaseCausal
                                || ';READING>'
                                || NVL (nuLectura, '')
                                || '>9>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|'
                                || '|'
                                || sbmedidor
                                || ';1='
                                || NVL (nuLectura, '')
                                || '=T===|'
                                || '1277;Servicio suspendido por imposibilidad tecnica.  No es posible certificar la instalacion';
            ELSE
                sbCadenalega :=  inuOrden
                                || '|'
                                || nuCausal
                                || '|'
                                || nuPersona
                                || '|'
                                || SBDATOSADICIONALES
                                || '|'
                                || inuOrderactivi
                                || '>'
                                || nuClaseCausal
                                || ';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|'
                                || '||1277;Servicio suspendido por imposibilidad tecnica.  No es posible certificar la instalacion';
            END IF;
            pkg_traza.trace(csbMT_NAME||' sbCadenalega: '||sbCadenalega, cnuNVLTRC);

            api_legalizeorders (sbCadenalega,
                               SYSDATE,
                               SYSDATE,
                               NULL,
                               onuError,
                               osbError);

            DBMS_LOCK.sleep (2);

            IF onuError <> 0 THEN
                pkg_traza.trace(csbMT_NAME||' Error al legalizar orden: '||osbError, cnuNVLTRC);
                pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;
        END IF;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_error.getError (onuError, osbError);  
             pkg_traza.trace(csbMT_NAME ||' osbError: ' || osbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
             pkg_error.setError;
             pkg_error.getError (onuError, osbError); 
             pkg_traza.trace(csbMT_NAME ||' osbError: ' || osbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);            
    END GESTIONAORDEXCLURP;

    PROCEDURE LEGALIZAORDSUSPEN
    IS
        /*****************************************************************
        Propiedad intelectual de GDC (c).

        Unidad         : LEGALIZAORDSUSPEN
        Descripcion    : proceso que legaliza ordenes de suspension
        Autor          : Luis Javier Lopez / Horbath
        Ticket         : 337
        Fecha          : 12/11/2020

        Datos Entrada

        Datos salida

        Nombre         :
        Parametros         Descripcion
        ============  ===================
        Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========         =========         ====================
        05-03-2024          adrianavg        OSF-2388: se reemplaza 'legalizaordsuspen' por csbSP_NAME||'legalizaordsuspen'
                                             Se aumenta tamaño a la variable csbMT_NAME VARCHAR2(30) por VARCHAR2(40)
                                             Se declaran variables para inicializar el proceso
                                             Se añade uso del pkg_error.prInicializaError(onuerrorcode, osberrormessage);
                                             Se reemplaza consulta de datos para inicializar el proceso según pautas técnicas
                                             Se reemplaza ldc_proinsertaestaprog por pkg_estaproc.prinsertaestaproc
                                             Se reemplaza ldc_proactualizaestaprog por pkg_estaproc.practualizaestaproc
                                             Se ajusta bloque de excepciones según pautas técnicas
        ******************************************************************/
        -- Nombre de éste método
        csbMT_NAME      VARCHAR2(40) := csbSP_NAME||'legalizaordsuspen';

        onuError        NUMBER;
        osbError        VARCHAR2 (4000);

        nuparano        NUMBER;
        nuparmes        NUMBER;
        nutsess         NUMBER;
        sbparuser       VARCHAR2 (400);

        CURSOR cugetOrdenesSusp IS
        SELECT o.order_id, oa.product_id, OA.order_activity_id, oa.package_id
          FROM ldc_asigna_suspension s, or_order_activity oa, or_order O
         WHERE s.package_id = oa.package_id
           AND S.procesado = 'N'
           AND oa.order_id = o.order_id
           AND o.order_status_id = 0;

        TYPE tblOrdenSusp IS TABLE OF cugetOrdenesSusp%ROWTYPE;

        vtblOrdenSusp   tblOrdenSusp;

        --variables para inicializar el proceso 
        sbproceso       VARCHAR2(100 BYTE) :=  csbMT_NAME||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
        sbNameProceso   sbproceso%TYPE;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        pkg_error.prInicializaError(onuError, osbError);
        
        -- inicializar el proceso
        BEGIN
            sbNameProceso:= sbproceso; --invocarlo una sola vez
            pkg_traza.trace(csbMT_NAME||' sbNameProceso: '||sbNameProceso , cnuNVLTRC);
            -- Inicializamos el proceso
            pkg_estaproc.prinsertaestaproc(sbNameProceso, NULL); 
        EXCEPTION
            WHEN OTHERS THEN
                 pkg_error.seterror;
                 pkg_error.geterror(onuError, osbError );
                 pkg_traza.trace(csbMT_NAME||' Error: '||osbError , cnuNVLTRC);
                 pkg_estaproc.practualizaestaproc( sbNameProceso, 'Error ', osbError  );
        END;                                


        OPEN cugetOrdenesSusp;

        LOOP
            FETCH cugetOrdenesSusp
            BULK COLLECT INTO vtblOrdenSusp
            LIMIT 100;

            FOR idx IN 1 .. vtblOrdenSusp.COUNT
            LOOP
                --se inicializa variables de error
                prinicializaError (onuError, osbError);

                --se legaliza orden
                GESTIONAORDEXCLURP (
                    vtblOrdenSusp (idx).package_id,
                    vtblOrdenSusp (idx).order_id,
                    vtblOrdenSusp (idx).product_id,
                    vtblOrdenSusp (idx).ORDER_ACTIVITY_ID,
                    onuError,
                    osbError);

                IF onuerror = 0 THEN

                    UPDATE ldc_asigna_suspension
                       SET fecha_proce = sysdate,  procesado = 'Y'
                     WHERE package_id = vtblordensusp(idx).package_id;                
                    COMMIT;
                    pkg_traza.trace(csbMT_NAME||' UPDATE LDC_ASIGNA_SUSPENSION PROCESADO=Y where PACKAGE_ID: '||vtblordensusp(idx).package_id, cnuNVLTRC);

                ELSE
                    pkg_traza.trace(csbMT_NAME||' ERROR en GESTIONAORDEXCLURP-->osbError: '||osbError , cnuNVLTRC);
                    ROLLBACK;
                    UPDATE ldc_asigna_suspension
                       SET fecha_proce = sysdate, observacion = osberror
                     WHERE package_id = vtblordensusp(idx).package_id;                
                    COMMIT;
                    pkg_traza.trace(csbMT_NAME||' UPDATE LDC_ASIGNA_SUSPENSION OBSERVACION=OSBERROR WHERE PACKAGE_ID:'||vtblordensusp(idx).package_id||', observacion:'||osberror, cnuNVLTRC);

                END IF;
            END LOOP;

            EXIT WHEN cugetOrdenesSusp%NOTFOUND;
        END LOOP;

        CLOSE cugetOrdenesSusp;

        BEGIN
            -- actualizar el proceso
            pkg_estaproc.practualizaestaproc(sbNameProceso, 'Ok', csbMT_NAME); 

        EXCEPTION
            WHEN pkg_Error.CONTROLLED_ERROR THEN
                 pkg_Error.getError( onuError, osbError);
                 pkg_traza.trace(csbMT_NAME||' Error: '||osbError , cnuNVLTRC);
                 pkg_estaproc.practualizaestaproc( sbNameProceso, 'Error ', osbError  );
            WHEN OTHERS THEN
                 pkg_error.seterror;
                 pkg_error.geterror(onuError, osbError );
                 pkg_traza.trace(csbMT_NAME||' Error: '||osbError , cnuNVLTRC);
                 pkg_estaproc.practualizaestaproc( sbNameProceso, 'Error ', osbError  );
        END;                                  

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             ROLLBACK;
             pkg_error.getError (onuError, osbError);
             -- actualizar el proceso
             pkg_estaproc.practualizaestaproc(sbNameProceso, 'error when controlled_error: '||osbError, csbMT_NAME);
             pkg_traza.trace(csbMT_NAME ||' osbError: ' || osbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
             ROLLBACK;
             pkg_error.setError;
             pkg_error.getError (onuError, osbError);
             -- actualizar el proceso
             pkg_estaproc.practualizaestaproc(sbNameProceso, 'error when others: '||osbError, csbMT_NAME); 
             pkg_traza.trace(csbMT_NAME ||' osbError: ' || osbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);             
    END LEGALIZAORDSUSPEN;

    PROCEDURE GENSUSPXIMPTEC
    IS
        /*****************************************************************
        Propiedad intelectual de GDC (c).

        Unidad         : GENSUSPXIMPTEC
        Descripcion    : plugin que se encarga de generar tramite de suspensione insertar en la tabla
                         LDC_ASIGNA_SUSPENSION
        Autor          : Luis Javier Lopez / Horbath
        Ticket         : 337
        Fecha          : 12/11/2020 

        Datos Entrada

        Datos salida

        Nombre         :
        Parametros         Descripcion
        ============  ===================
        Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========         =========         ====================
        05-03-2024          adrianavg        OSF-2388: se reemplaza 'gensuspximptec' por csbSP_NAME||'gensuspximptec'
                                             Se aumenta tamaño a la variable csbMT_NAME VARCHAR2(30) por VARCHAR2(35)
                                             Se ajusta bloque de excepciones según pautas técnicas
                                             Se reemplaza or_bolegalizeorder.fnuGetCurrentOrder por pkg_bcordenes.fnuobtenerotinstancialegal
                                             Se reemplaza dald_parameter.fnugetnumeric_value por pkg_bcld_parameter.fnuobtienevalornumerico
        ******************************************************************/
        -- Nombre de éste método
        csbMT_NAME          VARCHAR2(35) := csbSP_NAME||'gensuspximptec';

        nuorden              NUMBER;            --Se almacena orden de trabajo
        nuMedioRece          NUMBER            := daldc_pararepe.fnugetparevanu ('LDC_COMEDRECE', NULL);
        nuTipocausal         NUMBER            := pkg_bcld_parameter.fnuobtienevalornumerico ('TIPO_DE_CAUSAL_SUSP_ADMI');
        nuCausal             NUMBER            := pkg_bcld_parameter.fnuobtienevalornumerico ('COD_CAUSA_SUSP_ADM_XML');

        nuError              NUMBER;
        sbError              VARCHAR2 (4000);

        nuTipoSusp           NUMBER;
        nuSolicitud          NUMBER;

        --se obtiene  actvidad de la orden
        CURSOR cudatossusp IS
        SELECT oa.product_id, oa.address_id, oa.subscriber_id, oa.subscription_id, c.order_comment
          FROM or_order_activity oa, or_order_comment C
         WHERE oa.order_id = nuorden
           AND oa.order_id = c.order_id
           AND c.legalize_comment = 'Y';

        regOrden             cudatossusp%ROWTYPE;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        --Obtener el identificador de la orden  que se encuentra en la instancia
        nuorden := pkg_bcordenes.fnuobtenerotinstancialegal;
        pkg_traza.trace(csbMT_NAME||' Numero de la Orden:' || nuorden, cnuNVLTRC);

        OPEN cudatossusp;
        FETCH cudatossusp INTO regOrden;
        IF cudatossusp%NOTFOUND THEN
            CLOSE cudatossusp;
            pkg_traza.trace(csbMT_NAME||' No se encontro informacion para la orden  [' || nuorden || '].', cnuNVLTRC);
            pkg_error.setErrorMessage (isbMsgErrr => 'No se encontro informacion para la orden  [' || nuorden || '].');
        END IF;

        CLOSE cudatossusp;

        nuTipoSusp := ldci_pkrevisionperiodicaweb.fnutiposuspension (regOrden.product_id);
        pkg_traza.trace(csbMT_NAME||' nuTipoSusp: '||nuTipoSusp, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME||' product_id: '||regOrden.product_id, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME||' nuMedioRece: '||nuMedioRece, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME||' nuTipocausal: '||nuTipocausal, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME||' nuCausal: '||nuCausal, cnuNVLTRC);

        --se crea orden de suspension
        nuSolicitud :=
            LDC_PKGESTIONCASURP.fnuGeneTramSuspRP (
                regOrden.product_id,
                nuMedioRece,
                nuTipocausal,
                nuCausal,
                nuTipoSusp,
                'SUSPENSION GENERADA POR PROCESO GENSUSPXIMPTEC',
                nuerror,
                sberror);

        IF nuerror <> 0 THEN
            pkg_traza.trace(csbMT_NAME||' Error al generar el trámite de suspensión:  ['|| SBERROR|| '].', cnuNVLTRC);
            pkg_error.setErrorMessage (isbMsgErrr => 'Error al generar el trámite de suspensión:  ['|| SBERROR|| '].');
        END IF;

        INSERT INTO LDC_BLOQ_LEGA_SOLICITUD (PACKAGE_ID_GENE) VALUES (nuSolicitud);
        pkg_traza.trace(csbMT_NAME||' INSERT INTO LDC_BLOQ_LEGA_SOLICITUD, PACKAGE_ID_GENE: '||nuSolicitud, cnuNVLTRC);

        INSERT INTO LDC_ASIGNA_SUSPENSION (PACKAGE_ID, PROCESADO)  VALUES (nuSolicitud, 'N');
        pkg_traza.trace(csbMT_NAME||' INSERT INTO LDC_ASIGNA_SUSPENSION, PACKAGE_ID: '||nuSolicitud, cnuNVLTRC);

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_error.getError (nuerror, sberror);        
             pkg_traza.trace(csbMT_NAME ||' WHEN pkg_error.CONTROLLED_ERROR sberror: ' || sberror||', Backtrace '||DBMS_UTILITY.format_error_backtrace, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);        
             RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
             pkg_error.setError; 
             pkg_error.getError (nuerror, sberror);  
             pkg_traza.trace(csbMT_NAME ||'WHEN OTHERS  sberror: ' || sberror||', Backtrace '||DBMS_UTILITY.format_error_backtrace, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);             
             RAISE pkg_error.CONTROLLED_ERROR;
    END GENSUSPXIMPTEC;

    PROCEDURE JOBPREDDEMO
    IS
        /*****************************************************************
        Propiedad intelectual de GDC (c).

        Unidad         : JOBPREDDEMO
        Descripcion    : Job que se encarga de marcar los predios sin medidor
        Autor          : Luis Javier Lopez / Horbath
        Ticket         : 337
        Fecha          : 12/11/2020 

        datos Entrada

        Datos salida

        Nombre         :
        Parametros         Descripcion
        ============  ===================
          Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========         =========         ====================
        19/05/2021        horbath           ca 693 agregar  la validación de estado del producto activo y que el producto se encuentre vencido
                                            legalizar ordenes no ejecutadas
        05-03-2024        adrianavg         OSF-2388: se reemplaza 'jobpreddemo' por csbSP_NAME||'jobpreddemo'
                                            Se aumenta tamaño a la variable csbMT_NAME VARCHAR2(30) por VARCHAR2(32)
                                            Se retira esquema OPEN antepuesto a Dald_parameter.fnuGetNumeric_Value, ge_causal
                                            Se retira código comentariado
                                            Se declaran variables para inicializar el proceso
                                            Se reemplaza consulta de datos para inicializar el proceso según pautas técnicas
                                            Se reemplaza ldc_proinsertaestaprog por pkg_estaproc.prinsertaestaproc
                                            Se reemplaza SELECT-INTO por cursor cuAnnoMes
                                            Se reemplaza ldc_proactualizaestaprog por pkg_estaproc.practualizaestaproc
                                            Se reemplaza armado del XML P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101 por pkg_xml_soli_vsi.getSolicitudVSI
                                            Se reemplaza or_bofwlockorder.unlockorder por api_lockorder
                                            Se reemplaza dald_parameter.fnugetnumeric_value por pkg_bcld_parameter.fnuobtienevalornumerico
                                            Se ajusta bloque de excepciones según pautas técnicas
        ******************************************************************/
        -- Nombre de éste método
        csbMT_NAME          VARCHAR2(32) := csbSP_NAME||'jobpreddemo';

        nuError              NUMBER;
        sbError              VARCHAR2 (4000);

        nuparano             NUMBER;
        nuparmes             NUMBER;
        nutsess              NUMBER;
        sbparuser            VARCHAR2 (400);

        nuAnoAnt             NUMBER;
        numesant             NUMBER;

        nuActividadserv      NUMBER            := daldc_pararepe.fnugetparevanu ('LDC_ACTVSIGESINMED', NULL);
        nuMedioRece          NUMBER            := daldc_pararepe.fnugetparevanu ('LDC_COMEDRECE', NULL);
        nuTipocausal         NUMBER            := pkg_bcld_parameter.fnuobtienevalornumerico ('TIPO_DE_CAUSAL_SUSP_ADMI');
        nuCausal             NUMBER            := pkg_bcld_parameter.fnuobtienevalornumerico ('COD_CAUSA_SUSP_ADM_XML');
        nuTipoSusp           NUMBER;

        sbObserlect          VARCHAR2 (2000)   := daldc_pararepe.fsbGetPARAVAST ('OBSLEC_EXC_RP', NULL);
        sbMotivoMedi         VARCHAR2 (2000)   := daldc_pararepe.fsbGetPARAVAST ('MOTIEXCLU_SINMEDIRP', NULL);
        sbTipoSolRp          VARCHAR2 (2000)   := daldc_pararepe.fsbGetPARAVAST ('LDC_TRAMRPVALI', NULL);
        nuSolicitud          NUMBER;
        nuOrden              NUMBER;
        norderactid          NUMBER;

        nuDias_Anti_Notf     NUMBER            := pkg_bcld_parameter.fnuobtienevalornumerico ('NUM_DIAS_ANTICIPAR_NOTIFI_RP');

        nuPersonIdsol        NUMBER            := pkg_bcld_parameter.fnuobtienevalornumerico ('PERID_GEN_CIOR');
        ONUCHANNEL           CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE;

        --INICIO CA 693
        sbTipoSolValEje      VARCHAR2 (2000)    := daldc_pararepe.fsbGetPARAVAST ('LDC_TRAMRPVALEJE', NULL);

        sbConfTitrcausal     VARCHAR2 (4000)    := daldc_pararepe.fsbGetPARAVAST ('LDC_CONTITRCAUL', NULL);
        nuUnidadDummy        NUMBER             := daldc_pararepe.fnugetparevanu ('UNIT_DUMMY_RP', NULL);
        sbCadenalega         VARCHAR2 (4000);

        CURSOR cuGetOrdenesPend (nuproducto IN NUMBER)
        IS
        SELECT o.order_id, o.order_status_id, oa.ORDER_ACTIVITY_ID, o.task_type_id
          FROM or_order o, or_order_activity oa, mo_packages p
         WHERE o.order_id = oa.order_id
           AND oa.package_id = p.package_id
           AND oa.product_id = nuproducto
           AND p.package_type_id IN (SELECT TO_NUMBER ( REGEXP_SUBSTR ( sbtiposolvaleje, '[^,]+', 1, LEVEL)) AS tiso
                                       FROM DUAL
                                 CONNECT BY REGEXP_SUBSTR (sbtiposolvaleje, '[^,]+', 1, LEVEL) IS NOT NULL)
        AND o.ORDER_STATUS_ID NOT IN (SELECT s.ORDER_STATUS_ID
                                        FROM or_order_status s
                                       WHERE s.IS_FINAL_STATUS = 'Y')
        AND ((INSTR ( p.COMMENT_, 'SE GENERAN DESDE JOB (JOB_SUSPENSION_XNO_CERT)') >  0 AND package_type_id = 100156)
         OR package_type_id <> 100156);

        CURSOR cuGetEstadoNueOrde (nuorden IN NUMBER)
        IS
        SELECT o.order_status_id
          FROM or_order o
         WHERE o.order_id = nuorden;

        nuEstadoOrden        NUMBER;

        -- se valida la clasificacion de la causal
        CURSOR cuTipoCausal (nuCausal ge_causal.CAUSAL_ID%TYPE)
        IS
        SELECT DECODE (CLASS_CAUSAL_ID,  1, 1,  2, 0)     tipo
          FROM ge_causal
         WHERE CAUSAL_ID = nuCausal;

        nuClasCausal         NUMBER;
        nuCausalLega         NUMBER;


        CURSOR cuGetCausalLeg (nuTitr NUMBER)
        IS
        SELECT TO_NUMBER ( SUBSTR (confi, INSTR (confi, ',') + 1, LENGTH (confi))) causal
          FROM ( SELECT (REGEXP_SUBSTR (sbConfTitrcausal, '[^|]+', 1, LEVEL)) AS confi
                  FROM DUAL
            CONNECT BY REGEXP_SUBSTR (sbConfTitrcausal, '[^|]+', 1, LEVEL) IS NOT NULL)
         WHERE ',' || confi || ',' LIKE '%,' || nuTitr || ',%';

        nuMarco              NUMBER;
        sbExistesups         VARCHAR2 (1);

        CURSOR cuExisteSolisusp (inuproducto NUMBER)
        IS
        SELECT 'X'
          FROM mo_packages s, mo_motive m
         WHERE m.package_id = s.package_id
           AND s.package_type_id = 100156
           AND s.motive_status_id = 13
           AND M.PRODUCT_ID = inuproducto;

        SBDATOSADICIONALES   VARCHAR2 (4000);

        --CURSOR PARA OBTENER NOMRES DE DATOS ADICIONALES DE UN GRUPO DEL TIPO DE TRABAJO
        CURSOR cugrupo (nutask_type_id   or_task_type.task_type_id%TYPE,
                        NUClasecausal    Ge_Causal.class_causal_id%TYPE)
        IS
        SELECT *
          FROM or_tasktype_add_data ottd
         WHERE ottd.task_type_id = nutask_type_id
           AND ottd.active = 'Y'
           AND ( ottd.use_ = DECODE (NUClasecausal,  1, 'C',  0, 'I') OR ottd.use_ = 'B');

        CURSOR cudatoadicional (
            nuattribute_set_id   ge_attributes_set.attribute_set_id%TYPE)
        IS
        SELECT *
          FROM ge_attributes b
         WHERE b.attribute_id IN (SELECT a.attribute_id
                                    FROM ge_attrib_set_attrib a
                                   WHERE a.attribute_set_id = nuattribute_set_id);

        --se  consultan los productos sin medidor
        CURSOR cuReg IS
        WITH productos  AS
        (SELECT /*+ index (a IDX_LDC_PLAZOS_CERT01) */
                c.producto
           FROM ldc_contrprome c, pr_product p
          WHERE c.ano = nuanoant
            AND c.mes = numesant
            AND c.nroveces >= 3
            AND c.producto = p.product_id
            AND p.product_status_id = 1
            AND EXISTS (SELECT 1
                          FROM ldc_plazos_cert A
                         WHERE is_notif IN ('YV', 'YR')
                           AND A.id_producto = p.product_id
                           AND plazo_min_suspension <=  SYSDATE + NVL (nudias_anti_notf, 0))
                           AND c.obs_no_lect IN ( SELECT TO_NUMBER ( REGEXP_SUBSTR (sbobserlect, '[^,]+', 1, LEVEL))AS obslect
                                                   FROM DUAL
                                                CONNECT BY REGEXP_SUBSTR (sbobserlect, '[^,]+', 1, LEVEL) IS NOT NULL))
        SELECT *
         FROM productos p
        MINUS
        (SELECT oa.product_id
           FROM mo_motive oa, mo_packages p
          WHERE p.package_id = oa.package_id
            AND p.package_type_id IN ( SELECT TO_NUMBER (REGEXP_SUBSTR (sbtiposolrp, '[^,]+', 1, LEVEL)) AS tiso
                                         FROM DUAL
                                    CONNECT BY REGEXP_SUBSTR (sbtiposolrp,  '[^,]+', 1, LEVEL) IS NOT NULL)
            AND p.motive_status_id = 13
        UNION ALL
        SELECT oa.product_id
         FROM or_order_activity oa, mo_packages p, or_order o
        WHERE p.package_id = oa.package_id
          AND o.order_id = oa.order_id
          AND o.order_status_id = 7
          AND p.package_type_id IN (SELECT TO_NUMBER (REGEXP_SUBSTR (sbtiposolvaleje, '[^,]+', 1, LEVEL)) AS tiso
                                     FROM DUAL
                               CONNECT BY REGEXP_SUBSTR (sbtiposolvaleje, '[^,]+', 1,  LEVEL) IS NOT NULL));

        TYPE tblProduSinmed IS TABLE OF cuReg%ROWTYPE;

        vtblProduSinmed      tblProduSinmed;

        --Se valida si el producto ya existe en la tabla de exclusion con el motivo sin medidor
        CURSOR cuvalexcrp (inuproducto NUMBER)
        IS
        SELECT 1
          FROM ldc_prodexclrp
         WHERE product_id = inuproducto 
           AND motivo = sbMotivoMedi;

        CURSOR cuValplazomin (inuproducto NUMBER)
        IS
        SELECT /*+ index (a IDX_LDC_PLAZOS_CERT01) */
                1
          FROM ldc_plazos_cert a
         WHERE plazo_min_suspension <= SYSDATE + NVL (nuDias_Anti_Notf, 0)
           AND is_notif IN ('YV', 'YR')
           AND A.id_producto = inuproducto;

        nuExiste             NUMBER;

        CURSOR cuValest (inuproducto NUMBER)
        IS
        SELECT 1
          FROM pr_product
         WHERE product_id = inuproducto 
           AND product_status_id = 1;

        CURSOR cuGetOrden IS
        SELECT order_id, order_activity_id
          FROM or_order_activity
         WHERE package_id = nuSolicitud;

        CURSOR cugetInfoSoli (nuproducto NUMBER)
        IS
        SELECT product_id, suscclie, address_id
          FROM pr_product, suscripc
         WHERE susccodi = SUBSCRIPTION_ID 
           AND product_id = nuproducto;

        nuProductId          NUMBER;
        inuContactIdsol      NUMBER;
        inuIdAddress         NUMBER;
        sbRequestXML         VARCHAR2 (4000);
        nuPackageId          NUMBER;
        nuMotiveId           NUMBER;

        CURSOR cugetPuntoatencion IS
        SELECT organizat_area_id
          FROM cc_orga_area_seller
         WHERE person_id = nuPersonIdsol 
           AND is_current = 'Y';

        --variables para inicializar el proceso 
        sbproceso       VARCHAR2(100 BYTE) :=  csbMT_NAME||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
        sbNameProceso   sbproceso%TYPE;
        
        CURSOR cuAnnoMes
        IS
        SELECT 2021, 11--TO_NUMBER (TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'YYYY')),
               --TO_NUMBER (TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'MM')) 
          FROM DUAL;        

    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        -- inicializar el proceso
        BEGIN
            sbNameProceso:= sbproceso; --invocarlo una sola vez
            pkg_traza.trace(csbMT_NAME||' sbNameProceso: '||sbNameProceso , cnuNVLTRC); 
            pkg_estaproc.prinsertaestaproc(sbNameProceso, NULL);
        EXCEPTION
            WHEN OTHERS THEN
                 pkg_error.seterror;
                 pkg_error.geterror(nuError, sbError );
                 pkg_traza.trace(csbMT_NAME||' Error: '||sbError , cnuNVLTRC);
                 pkg_estaproc.practualizaestaproc( sbNameProceso, 'Error ', sbError  );
        END;         

        --se obtiene punto de atencion
        pkg_traza.trace(csbMT_NAME||' nuPersonIdsol: '||nuPersonIdsol , cnuNVLTRC);
        OPEN cugetPuntoatencion;
        FETCH cugetPuntoatencion INTO onuchannel;
        CLOSE cugetPuntoatencion;
        pkg_traza.trace(csbMT_NAME||' onuchannel: '||onuchannel , cnuNVLTRC);

        OPEN cuAnnoMes;
        FETCH cuAnnoMes INTO nuAnoAnt, numesant;
        CLOSE cuAnnoMes;
        BEGIN
            OPEN cuReg;
            LOOP
                FETCH cuReg BULK COLLECT INTO vtblProduSinmed LIMIT 100;

                FOR idx IN 1 .. vtblProduSinmed.COUNT
                LOOP
                    nuExiste := NULL;
                    nuTipoSusp := NULL;
                    nuerror := 0;
                    sbError := NULL;
                    nuSolicitud := NULL;
                    nuorden := NULL;
                    nuProductId := NULL;
                    inuContactIdsol := NULL;
                    inuIdAddress := NULL;
                    sbRequestXML := NULL;
                    nuPackageId := NULL;
                    nuMotiveId := NULL;
                    nuMarco := 0;

                    OPEN cuvalexcrp (vtblProduSinmed (idx).PRODUCTO);
                    FETCH cuvalexcrp INTO nuExiste;
                    CLOSE cuvalexcrp;
                    pkg_traza.trace(csbMT_NAME||' nuExiste: '||nuExiste , cnuNVLTRC);

                    OPEN cugetInfoSoli (vtblProduSinmed (idx).PRODUCTO);
                    FETCH cugetInfoSoli INTO nuProductId, inuContactIdsol, inuIdAddress;
                    CLOSE cugetInfoSoli;
                    pkg_traza.trace(csbMT_NAME||' nuProductId: '||nuProductId , cnuNVLTRC);
                    pkg_traza.trace(csbMT_NAME||' inuContactIdsol: '||inuContactIdsol , cnuNVLTRC);
                    pkg_traza.trace(csbMT_NAME||' inuIdAddress: '||inuIdAddress , cnuNVLTRC);
                    pkg_traza.trace(csbMT_NAME||' nuMedioRece: '||nuMedioRece , cnuNVLTRC);
                    pkg_traza.trace(csbMT_NAME||' nuActividadserv: '||nuActividadserv , cnuNVLTRC);

                    sbRequestXML := pkg_xml_soli_vsi.getSolicitudVSI( inuContratoID       => NULL,
                                                                      inuMedioRecepcionId => nuMedioRece,
                                                                      isbComentario       => NULL,
                                                                      inuProductoId       => nuProductId,
                                                                      inuClienteId        => inuContactIdsol,
                                                                      inuPersonaID        => nuPersonIdsol,
                                                                      inuPuntoAtencionId  => onuchannel,
                                                                      idtFechaSolicitud   => SYSDATE,
                                                                      inuAddressId        => inuIdAddress,
                                                                      inuTrabajosAddressId=> inuIdAddress,
                                                                      inuActividadId      => nuActividadserv
                                                                    );--P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101                                        

                    --genero suspension
                    nuTipoSusp :=  ldci_pkrevisionperiodicaweb.fnutiposuspension ( vtblProduSinmed (idx).PRODUCTO);
                    pkg_traza.trace(csbMT_NAME||' nuTipoSusp: '||nuTipoSusp , cnuNVLTRC);
                    
                    FOR regOrdp IN cuGetOrdenesPend ( vtblProduSinmed (idx).PRODUCTO)
                    LOOP
                        nuEstadoOrden := NULL;

                        IF regOrdp.ORDER_STATUS_ID = 11 THEN
                            BEGIN
                                api_lockorder( regOrdp.order_id,                                --inuOrderId
                                                1277,                                           --inuTipoComentario
                                                'DESBLOQUEO DE ORDEN POR PROCESO JOBPREDDEMO',  --isbComentario
                                                SYSDATE,                                        --idtFechaCambio
                                                nuError,                                        --onuErrorCode
                                                sbError);                                       --osbErrorMessage

                                IF cuGetEstadoNueOrde%ISOPEN THEN
                                    CLOSE cuGetEstadoNueOrde;
                                END IF;

                                OPEN cuGetEstadoNueOrde (regOrdp.order_id);
                                FETCH cuGetEstadoNueOrde INTO nuEstadoOrden;
                                CLOSE cuGetEstadoNueOrde;
                                pkg_traza.trace(csbMT_NAME||' nuEstadoOrden: '||nuEstadoOrden , cnuNVLTRC);

                            EXCEPTION
                                WHEN OTHERS THEN
                                    pkg_error.setError;
                                    pkg_error.getError (nuerror,  sberror);
                                    pkg_traza.trace(csbMT_NAME||' api_lockorder -->sberror: '||sberror , cnuNVLTRC);
                                    ldc_pkgrepegelerecoysusp.proRegistraLogLegOrdRecoSusp ( 'JOBPREDDEMO',
                                                                                            SYSDATE,
                                                                                            nuorden,
                                                                                            NULL,
                                                                                            sberror, USER);
                                    ROLLBACK;
                                    EXIT;
                            END;
                        ELSE
                            nuEstadoOrden := regOrdp.ORDER_STATUS_ID;
                        END IF;

                        pkg_traza.trace(csbMT_NAME||' nuEstadoOrden: '||nuEstadoOrden , cnuNVLTRC);

                        IF nuEstadoOrden = 0 THEN
                            --se asigan orden de reconexion
                            API_ASSIGN_ORDER (regOrdp.order_id,
                                              nuUnidadDummy,
                                              nuerror,
                                              sberror);

                            IF nuerror <> 0 THEN
                                pkg_traza.trace(csbMT_NAME||' API_ASSIGN_ORDER --> sberror: '||sberror , cnuNVLTRC);
                                ldc_pkgrepegelerecoysusp.proRegistraLogLegOrdRecoSusp ('JOBPREDDEMO', SYSDATE, regOrdp.order_id,
                                    NULL, 'Error al asignar orden['|| regOrdp.order_id
                                                                   || '] error ['
                                                                   || sberror
                                                                   || ']', USER);
                                ROLLBACK;
                                EXIT;
                            END IF;
                        END IF;

                        IF cuGetCausalLeg%ISOPEN THEN
                            CLOSE cuGetCausalLeg;
                        END IF;

                        OPEN cuGetCausalLeg (regOrdp.task_type_id);
                        FETCH cuGetCausalLeg INTO nuCausalLega;
                        pkg_traza.trace(csbMT_NAME||' nuCausalLega: '||nuCausalLega , cnuNVLTRC);

                        IF cuGetCausalLeg%NOTFOUND THEN
                            nuerror := -1;
                            sberror :=  'No existe configuracion del tipo de trabajo [' || regOrdp.task_type_id
                                                                                        || '] en el parametro LDC_CONTITRCAUL';
                            ldc_pkgrepegelerecoysusp.proRegistraLogLegOrdRecoSusp ('JOBPREDDEMO',
                                                                                    SYSDATE,
                                                                                    regOrdp.order_id,
                                                                                    NULL,
                                                                                       'No existe configuracion del tipo de trabajo ['
                                                                                    || regOrdp.task_type_id
                                                                                    || '] en el parametro LDC_CONTITRCAUL',
                                                                                    USER);
                            pkg_traza.trace(csbMT_NAME||' No existe configuracion del tipo de trabajo [' || regOrdp.task_type_id
                                                                                        || '] en el parametro LDC_CONTITRCAUL, '||sberror , cnuNVLTRC);
                            ROLLBACK;
                            CLOSE cuGetCausalLeg;

                            EXIT;
                        END IF;
                        CLOSE cuGetCausalLeg;

                        IF cuTipoCausal%ISOPEN THEN
                            CLOSE cuTipoCausal;
                        END IF;

                        --se valida clase de causal
                        OPEN cuTipoCausal (nuCausalLega);
                        FETCH cuTipoCausal INTO nuClasCausal;
                        CLOSE cuTipoCausal;
                        pkg_traza.trace(csbMT_NAME||' nuClasCausal: '||nuClasCausal , cnuNVLTRC);

                        --cadena datos adicionales
                        SBDATOSADICIONALES := NULL;

                        FOR rc IN cugrupo (regOrdp.task_type_id,  nuClasCausal)
                        LOOP
                            pkg_traza.trace(csbMT_NAME||'Grupo de dato adicional [' || rc.attribute_set_id
                                                                                    || '] asociado al tipo de trabajo ['
                                                                                    || rc.task_type_id
                                                                                    || ']' , cnuNVLTRC);

                            FOR rcdato IN cudatoadicional ( rc.attribute_set_id)
                            LOOP
                                IF SBDATOSADICIONALES IS NULL  THEN
                                    SBDATOSADICIONALES :=  RCDATO.NAME_ATTRIBUTE || '=';
                                ELSE
                                    SBDATOSADICIONALES := SBDATOSADICIONALES || ';' || RCDATO.NAME_ATTRIBUTE || '=';
                                END IF;

                                pkg_traza.trace(csbMT_NAME||' Dato adicional['|| rcdato.name_attribute || ']' , cnuNVLTRC);

                            END LOOP;
                        END LOOP;

                        sbCadenalega :=
                               regOrdp.order_id
                            || '|'
                            || nuCausalLega
                            || '|'
                            || nuPersonIdsol
                            || '|'
                            || SBDATOSADICIONALES
                            || '|'
                            || regOrdp.ORDER_ACTIVITY_ID
                            || '>'
                            || nuClasCausal
                            || ';;;;|||1277;Se cierra orden desde el job LDC_PKGESTPREXCLURP.JOBPREDDEMO predio se encuentra sin medidor o demolido';

                        pkg_traza.trace(csbMT_NAME||' sbCadenalega: '||sbCadenalega , cnuNVLTRC);

                        api_legalizeorders (sbCadenalega,
                                            SYSDATE - 1 / 24 / 60,
                                            SYSDATE - 1 / 24 / 60,
                                            NULL,
                                            nuerror,
                                            sberror);

                        IF nuerror <> 0 THEN
                            pkg_traza.trace(csbMT_NAME||' API_LEGALIZEORDERS --> sberror: '||sberror , cnuNVLTRC);
                            LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp ( 'JOBPREDDEMO',
                                                                                    SYSDATE,
                                                                                    regOrdp.order_id,
                                                                                    NULL,
                                                                                       'Error al legalizar orden['
                                                                                    || regOrdp.order_id
                                                                                    || '] error ['
                                                                                    || sberror
                                                                                    || ']',  USER);
                            ROLLBACK;

                            EXIT;
                        ELSE
                            --se notifica legalizacion
                            pkg_traza.trace(csbMT_NAME||' se notifica legalizacion ' , cnuNVLTRC);
                            LDC_NOTIFICA_CIERRE_OT (regOrdp.order_id,'SP');
                            COMMIT;
                            DBMS_LOCK.sleep (4);
                        END IF;
                    END LOOP;

                    IF NVL (nuerror, 0) = 0 THEN
                        sbExistesups := NULL;

                        --se valida si existe solicitud 100156
                        OPEN cuExisteSolisusp ( vtblProduSinmed (idx).PRODUCTO); 
                        FETCH cuExisteSolisusp INTO sbExistesups; 
                        CLOSE cuExisteSolisusp;
                        pkg_traza.trace(csbMT_NAME||' sbExistesups: '||sbExistesups , cnuNVLTRC);

                        IF sbExistesups IS NULL THEN
                            pkg_traza.trace(csbMT_NAME||' nuTipocausal: '||nuTipocausal , cnuNVLTRC);
                            pkg_traza.trace(csbMT_NAME||' nuCausal: '||nuCausal , cnuNVLTRC);
                            --se crea orden de suspension
                            nuSolicitud :=  LDC_PKGESTIONCASURP.fnuGeneTramSuspRP ( vtblProduSinmed (idx).PRODUCTO,
                                                                                    nuMedioRece,
                                                                                    nuTipocausal,
                                                                                    nuCausal,
                                                                                    nuTipoSusp,
                                                                                    'SUSPENSION GENERADA POR PROCESO JOBPREDDEMO',
                                                                                    nuerror,
                                                                                    sberror);

                            pkg_traza.trace(csbMT_NAME||' nuSolicitud: '||nuSolicitud , cnuNVLTRC);

                            IF nuerror <> 0 THEN
                                pkg_traza.trace(csbMT_NAME||' Ingreso a error tramite de suspension producto '||vtblProduSinmed(idx).PRODUCTO||', '||sberror , cnuNVLTRC);
                                LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp ('JOBPREDDEMO-SUSPENSION',
                                                                                        SYSDATE,
                                                                                        vtblProduSinmed (idx).PRODUCTO,
                                                                                        NULL,
                                                                                        SBERROR,
                                                                                        USER);
                                ROLLBACK;
                            ELSE
                                INSERT INTO LDC_BLOQ_LEGA_SOLICITUD ( PACKAGE_ID_GENE) VALUES (nuSolicitud);
                                pkg_traza.trace(csbMT_NAME||' INSERT INTO LDC_BLOQ_LEGA_SOLICITUD: '||nuSolicitud , cnuNVLTRC);

                                --si no existe producto marcado lo marco
                                IF nuExiste IS NULL THEN

                                    --se inserta en la tabla de productos excluidos
                                    insprodexclrp ( vtblProduSinmed (idx).PRODUCTO,
                                                    sbMotivoMedi,
                                                    NULL,
                                                    Nuerror,
                                                    sbError);

                                    IF nuerror <> 0 THEN
                                        pkg_traza.trace(csbMT_NAME||' Error en insprodexclrp: '||sbError , cnuNVLTRC);
                                        ROLLBACK;
                                        CONTINUE;
                                    ELSE
                                        nuMarco := 1;
                                    END IF;
                                END IF;

                                COMMIT;
                                DBMS_LOCK.sleep (5);

                                IF cuGetOrden%ISOPEN THEN
                                    CLOSE cuGetOrden;
                                END IF;

                                --se consulta orden a legalziar
                                OPEN cuGetOrden; 
                                FETCH cuGetOrden INTO nuorden, norderactid;
                                CLOSE cuGetOrden;
                                pkg_traza.trace(csbMT_NAME||' nuorden: '||nuorden , cnuNVLTRC);
                                pkg_traza.trace(csbMT_NAME||' norderactid: '||norderactid , cnuNVLTRC);

                                IF nuorden IS NOT NULL THEN
                                    --se legalzia orden
                                    GESTIONAORDEXCLURP (
                                        nuSolicitud,
                                        nuorden,
                                        vtblProduSinmed (idx).PRODUCTO,
                                        norderactid,
                                        nuError,
                                        sbError);

                                    IF nuError <> 0 THEN
                                        pkg_traza.trace(csbMT_NAME||' Error en gestionaordexclurp: '||sbError , cnuNVLTRC);
                                        LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp (
                                            'JOBPREDDEMO',
                                            SYSDATE,
                                            nuorden,
                                            NULL,
                                            SBERROR,
                                            USER);
                                        ROLLBACK;

                                        INSERT INTO LDC_ASIGNA_SUSPENSION (
                                                        PACKAGE_ID,
                                                        PROCESADO)
                                                 VALUES (nuSolicitud,
                                                         'N');

                                        COMMIT;
                                        pkg_traza.trace(csbMT_NAME||' INSERT INTO LDC_ASIGNA_SUSPENSION, PACKAGE_ID=: '||nuSolicitud , cnuNVLTRC);
                                    ELSE
                                        COMMIT;
                                    END IF;
                                ELSE
                                    pkg_traza.trace(csbMT_NAME||' ELSE, LA ORDEN IS NULL' , cnuNVLTRC);
                                    INSERT INTO LDC_ASIGNA_SUSPENSION (
                                                    PACKAGE_ID,
                                                    PROCESADO)
                                         VALUES (nuSolicitud, 'N');
                                    pkg_traza.trace(csbMT_NAME||' INSERT INTO LDC_ASIGNA_SUSPENSION, PACKAGE_ID=: '||nuSolicitud , cnuNVLTRC);
                                    COMMIT;
                                    LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp (
                                        'JOBPREDDEMO-EJEC',
                                        SYSDATE,
                                        nuSolicitud,
                                        NULL,
                                        'ORDEN NO GENERADA POR DEMORA EN LOS EJECUTORES',
                                        USER);
                                    pkg_traza.trace(csbMT_NAME||' ORDEN NO GENERADA POR DEMORA EN LOS EJECUTORES' , cnuNVLTRC);
                                END IF;

                                --se genera vsi si el producto se marco
                                IF nuMarco = 1 THEN

                                    /*Ejecuta el XML creado*/
                                    API_REGISTERREQUESTBYXML (
                                        sbRequestXML,
                                        nuPackageId,
                                        nuMotiveId,
                                        nuerror,
                                        sberror);

                                    IF nuerror <> 0 THEN
                                        pkg_traza.trace(csbMT_NAME||' API_REGISTERREQUESTBYXML -->sberror: '||sberror , cnuNVLTRC);
                                        LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp (
                                            'JOBPREDDEMO-VSI',
                                            SYSDATE,
                                            vtblProduSinmed (idx).PRODUCTO,
                                            NULL,
                                            sberror,
                                            USER);
                                        ROLLBACK;
                                    ELSE
                                        COMMIT;
                                    END IF;
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                END LOOP;

                EXIT WHEN cuReg%NOTFOUND;
            END LOOP;

            CLOSE cuReg; 

        EXCEPTION
            WHEN OTHERS THEN
                pkg_error.setError;
                pkg_error.getError (nuError, sbError);
                pkg_estaproc.practualizaestaproc( sbNameProceso, 'Error ', sbError  );
                pkg_traza.trace(csbMT_NAME ||' sbError: ' || sbError, cnuNVLTRC);
                ROLLBACK;
        END;

        pkg_estaproc.practualizaestaproc( sbNameProceso, 'Ok ', csbMT_NAME  ); 
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_error.getError (nuError, sbError);
             pkg_estaproc.practualizaestaproc( sbNameProceso, 'Error ', sbError  );
             pkg_traza.trace(csbMT_NAME ||' sbError: ' || sbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
             ROLLBACK;
        WHEN OTHERS THEN
             pkg_error.setError;
             pkg_error.getError (nuError, sbError);
             pkg_estaproc.practualizaestaproc( sbNameProceso, 'Error ', sbError  );
             pkg_traza.trace(csbMT_NAME ||' sbError: ' || sbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);            
             ROLLBACK;
    END JOBPREDDEMO;

    FUNCTION FUNVALEXCLURP ( inuproducto IN NUMBER) RETURN NUMBER IS
        /*****************************************************************
          Propiedad intelectual de GDC (c).

          Unidad         : FUNVALEXCLURP
          Descripcion    : funcion que retorna si el producto esta excluido
          Autor          : Luis Javier Lopez / Horbath
          Ticket         : 337
          Fecha          : 12/11/2020

          Datos Entrada
          inuProducto codigo del producto
          Datos salida

          Nombre         :
          Parametros         Descripcion
          ============  ===================
          Historia de Modificaciones
          Fecha             Autor             Modificacion
          =========         =========         ====================
          05-03-2024        adrianavg         OSF-2388: se reemplaza 'funvalexclurp' por csbSP_NAME||'funvalexclurp'
                                              Se aumenta tamaño a la variable csbMT_NAME VARCHAR2(30) por VARCHAR2(35)           
                                              Se ajusta bloque de excepciones según pautas técnicas
        ******************************************************************/
        -- Nombre de éste método
        csbMT_NAME  VARCHAR2(35) := 'funvalexclurp';

        nuExiste   NUMBER := 0;
        nuError    NUMBER;
        sbError    VARCHAR2 (4000);

        CURSOR cuGetExiste IS
        SELECT COUNT (1)
          FROM LDC_PRODEXCLRP
         WHERE PRODUCT_ID = inuProducto;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        pkg_error.prInicializaError(nuError, sbError);
        OPEN cuGetExiste;
        FETCH cuGetExiste INTO nuExiste;
        CLOSE cuGetExiste;
        pkg_traza.trace(csbMT_NAME ||' nuExiste: ' || nuExiste, cnuNVLTRC);

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN nuExiste;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_error.getError (nuError, sbError);
             pkg_traza.trace(csbMT_NAME ||' sbError: ' || sbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
             RETURN nuExiste;
        WHEN OTHERS THEN
             pkg_error.setError;
             pkg_error.getError (nuError, sbError);
             pkg_traza.trace(csbMT_NAME ||' sbError: ' || sbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
             RETURN nuExiste;
    END FUNVALEXCLURP;

    PROCEDURE PROBTIENEDATOS (
        osbFechaIni   OUT ge_boInstanceControl.stysbValue,
        osbFechaFin   OUT ge_boInstanceControl.stysbValue,
        osbMotivo     OUT ge_boInstanceControl.stysbValue)
    IS
    /*****************************************************************
     Propiedad intelectual de GDC (c).

     Unidad         : prObtieneDatos
     Descripcion    : proceso que obtiene los datos del PB LDCDELEXCLPR
     Autor          : Luis Javier Lopez / Horbath
     Ticket         : 337
     Fecha          : 12/11/2020


     datos Entrada

     Datos salida
        isbFechaIni fecha inicial
        isbFechaFin  fecha final
        IsbMotivo    motivo
     Nombre         :
     Parametros         Descripcion
     ============  ===================
       Historia de Modificaciones
     Fecha             Autor             Modificacion
     =========         =========         ====================
      05-03-2024        adrianavg         OSF-2388: se reemplaza 'probtienedatos' por csbSP_NAME||'probtienedatos'
                                          Se aumenta tamaño a la variable csbMT_NAME VARCHAR2(35) por VARCHAR2(35) 
                                          Se declaran variables para manejo del error nuError y sbError
                                          Se ajusta bloque de excepciones según pautas técnicas
   ******************************************************************/
        -- Nombre de éste método
        csbMT_NAME  VARCHAR2(35) := 'probtienedatos';
        nuError    NUMBER;
        sbError    VARCHAR2 (4000);        
    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        pkg_error.prInicializaError(nuError, sbError);
        
        osbFechaIni :=  ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAFECO');
        osbFechaFin :=  ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAFEEM');
        osbMotivo   :=  ge_boInstanceControl.fsbGetFieldValue ('LDC_PRODEXCLRP', 'MOTIVO');

        pkg_traza.trace(csbMT_NAME ||' osbFechaIni: ' || osbFechaIni, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME ||' osbFechaFin: ' || osbFechaFin, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME ||' osbMotivo: ' || osbMotivo, cnuNVLTRC);

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_error.getError(nuError, sbError);
             pkg_traza.trace(csbMT_NAME ||' sbError: ' || sbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
             RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
             pkg_error.setError; 
             pkg_error.getError (nuError, sbError);
             pkg_traza.trace(csbMT_NAME ||' sbError: ' || sbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
    END prObtieneDatos;

    PROCEDURE PRVALIDAINFORMACION
    IS
    /*****************************************************************
      Propiedad intelectual de GDC (c).

      Unidad         : prValidaInformacion
      Descripcion    : valida infromacion del PB LDCDELEXCLPR
      Autor          : Luis Javier Lopez / Horbath
      Ticket         : 337
      Fecha          : 12/11/2020


      datos Entrada

      Datos salida

      Nombre         :
      Parametros         Descripcion
      ============  ===================
        Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
      05-03-2024        adrianavg         OSF-2388: se reemplaza 'prValidaInformacion' por csbSP_NAME||'prValidaInformacion'
                                          Se aumenta tamaño a la variable csbMT_NAME VARCHAR2(35) por VARCHAR2(40)       
                                          Se declaran variables para manejo del error nuError y sbError
                                          Se reemplaza ut_date.fsbdate_format por ldc_boconsgenerales.fsbgetformatofecha
                                          Se ajusta bloque de excepciones según pautas técnicas
    ******************************************************************/
        -- Nombre de éste método
        csbMT_NAME  VARCHAR2(40) := csbSP_NAME||'prValidaInformacion';
        nuError    NUMBER;
        sbError    VARCHAR2 (4000);
    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        pkg_error.prInicializaError(nuError, sbError);
        
        prObtieneDatos (sbFechaIni, sbFechaFin, sbMotivo);
        sbdateformat := ldc_boconsgenerales.fsbgetformatofecha;
        pkg_traza.trace(csbMT_NAME ||' sbdateformat: ' || sbdateformat, cnuNVLTRC);

        pkg_traza.trace(csbMT_NAME ||' sbFechaIni: ' || sbFechaIni, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME ||' sbFechaFin: ' || sbFechaFin, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME ||' sbMotivo: ' || sbMotivo, cnuNVLTRC);

        IF sbFechaIni IS NOT NULL AND sbFechaFin IS NULL THEN
            pkg_traza.trace(csbMT_NAME ||' Fecha de final no puede estar vacia', cnuNVLTRC); 
            pkg_error.setErrorMessage (isbMsgErrr => 'Fecha de final no puede estar vacia');
        END IF;

        IF sbFechaIni IS NULL AND sbFechaFin IS NOT NULL THEN
            pkg_traza.trace(csbMT_NAME ||' Fecha de inicial no puede estar vacia', cnuNVLTRC); 
            pkg_error.setErrorMessage (isbMsgErrr => 'Fecha de inicial no puede estar vacia');
        END IF;

        IF sbFechaIni IS NOT NULL THEN
            dtFechaIni := TO_DATE (sbFechaIni, '' || sbdateformat || '');
            dtFechaFin := TO_DATE (sbFechaFin, '' || sbdateformat || '');

            IF dtFechaIni > dtFechaFin THEN
                pkg_traza.trace(csbMT_NAME ||' Fecha de inicial no puede ser mayor a la fecha final', cnuNVLTRC); 
                pkg_error.setErrorMessage (isbMsgErrr => 'Fecha de inicial no puede ser mayor a la fecha final');
            END IF;
        END IF;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_error.getError(nuError, sbError); 
             pkg_traza.trace(csbMT_NAME ||' sbError: ' || sbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
             RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
             pkg_error.setError; 
             pkg_error.getError (nuError, sbError);
             pkg_traza.trace(csbMT_NAME ||' sbError: ' || sbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
    END prValidaInformacion;


    FUNCTION FRCGETDELEXCLPR
    RETURN constants_per.tyrefcursor IS
        /*****************************************************************
         Propiedad intelectual de GDC (c).

         Unidad         : FRCGETDELEXCLPR
         Descripcion    : funcion que retorna informacion para el PB LDCDELEXCLPR
         Autor          : Luis Javier Lopez / Horbath
         Ticket         : 337
         Fecha          : 12/11/2020

         Datos Entrada
         inuProducto codigo del producto
         Datos salida

         Nombre         :
         Parametros         Descripcion
         ============  ===================
         Historia de Modificaciones
         Fecha             Autor             Modificacion
         =========         =========         ====================
         05-03-2024        adrianavg         OSF-2388: se reemplaza 'frcgetdelexclpr' por csbSP_NAME||'frcgetdelexclpr'
                                             Se aumenta tamaño a la variable csbMT_NAME VARCHAR2(30) por VARCHAR2(35)
                                             Se reemplaza constants.tyrefcursor por constants_per.tyrefcursor
                                             Se declaran variables para manejo del error nuError y sbError
                                             Se ajusta bloque de excepciones según pautas técnicas
       ******************************************************************/
        -- Nombre de éste método
        csbMT_NAME  VARCHAR2(35) := csbSP_NAME||'frcgetdelexclpr';
        nuError    NUMBER;
        sbError    VARCHAR2 (4000);
        rfresult   constants_per.tyrefcursor;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        pkg_error.prInicializaError(nuError, sbError);
        
        prValidaInformacion;
        pkg_traza.trace(csbMT_NAME ||' sbFechaIni: ' || sbFechaIni, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME ||' sbFechaFin: ' || sbFechaFin, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME ||' sbMotivo: ' || sbMotivo, cnuNVLTRC);
        
        IF sbFechaIni IS NULL THEN
            OPEN rfresult FOR
                SELECT codigo,
                       product_id    producto,
                       order_id      orden,
                       motivo,
                      fech_exclu     fecha_exclusion
                  FROM ldc_prodexclrp
                 WHERE motivo = decode (sbmotivo, 'TODOS', motivo, sbmotivo);
        ELSE
            OPEN rfresult FOR
                SELECT codigo,
                       product_id producto,
                       order_id   orden,
                       motivo,
                       fech_exclu fecha_exclusion
                  FROM ldc_prodexclrp
                 WHERE motivo = decode(sbmotivo, 'TODOS', motivo, sbmotivo)
                   AND fech_exclu BETWEEN sbfechaini AND sbfechafin;
        END IF;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN rfresult;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_error.getError(nuError, sbError); 
             pkg_traza.trace(csbMT_NAME ||' sbError: ' || sbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
             pkg_error.setError;
             pkg_error.setError; 
             pkg_error.getError (nuError, sbError);
             pkg_traza.trace(csbMT_NAME ||' sbError: ' || sbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
    END FRCGETDELEXCLPR;

    PROCEDURE prdelexclpr (
        isbcodigo    IN VARCHAR2,
        inucurrent   IN NUMBER,
        inutotal     IN NUMBER,
        onuerrorcode OUT ge_error_log.message_id%TYPE,
        osberrormess OUT ge_error_log.description%TYPE
    ) IS
         /**************************************************************************
         Autor       : Luis Javier Lopez Barrios / Horbath
         Proceso     : PRDELEXCLPR
         Fecha       : 2020-13-03
         Ticket      : 337
         Descripcion : Proceso que elimina producto excluido del  PB [LDCDELEXCLPR]
         
         Parametros Entrada
         isbcodigo  codigo
         inucurrent  valor actual
         inutotal    total
         Valor de salida
         onuerrorcode  codigo de error
         osberrormess  mensaje de error
         HISTORIA DE MODIFICACIONES
         FECHA        AUTOR        DESCRIPCION
         05-03-2024   adrianavg    OSF-2388: se reemplaza 'prdelexclpr' por csbSP_NAME||'prdelexclpr'
                                   Se aumenta tamaño a la variable csbMT_NAME VARCHAR2(35) por VARCHAR2(32)
                                   Se declaran variables para manejo del error nuError y sbError
                                   Se ajusta bloque de excepciones según pautas técnicas
        ***************************************************************************/
        -- Nombre de éste método
        csbMT_NAME  VARCHAR2(32) := csbSP_NAME||'prdelexclpr';

        sbMotivop   ge_boInstanceControl.stysbValue;
        sbFechaInip ge_boInstanceControl.stysbValue;
        sbFechaFinp ge_boInstanceControl.stysbValue;
        nuError     NUMBER;
        sbError     VARCHAR2 (4000);        

    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        pkg_error.prInicializaError(nuError, sbError);
        
        pkg_traza.trace(csbMT_NAME ||' isbcodigo: ' || isbcodigo, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME ||' inucurrent: ' || inucurrent, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME ||' inutotal: ' || inutotal, cnuNVLTRC);

        prObtieneDatos (sbFechaInip, sbFechaFinp, sbMotivop);

        IF sbMotivop <> sbMotivo  OR sbFechaInip <> sbFechaIni    OR sbFechaFinp <> sbFechaFin THEN
            pkg_traza.trace(csbMT_NAME ||' Se cambiaron los datos de la consulta, por favor volver a generar la busqueda ', cnuNVLTRC); 
            pkg_error.setErrorMessage (isbMsgErrr => 'Se cambiaron los datos de la consulta, por favor volver a generar la busqueda');
        END IF;

        DELETE FROM LDC_PRODEXCLRP WHERE CODIGO = isbcodigo;
        pkg_traza.trace(csbMT_NAME ||' DELETE FROM LDC_PRODEXCLRP WHERE CODIGO= '||isbcodigo, cnuNVLTRC);

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN            
             pkg_error.getError(nuError, sbError); 
             pkg_traza.trace(csbMT_NAME ||' sbError: ' || sbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
             RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
             pkg_error.setError;
             pkg_error.getError (nuError, sbError);
             pkg_traza.trace(csbMT_NAME ||' sbError: ' || sbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
             RAISE pkg_error.CONTROLLED_ERROR;
    END PRDELEXCLPR;

    PROCEDURE PROINSEXCLPR
    IS
        /**************************************************************************
         Autor       : Luis Javier Lopez Barrios / Horbath
         Proceso     : PROINSEXCLPR
         Fecha       : 2020-13-03
         Ticket      : 337
         Descripcion : Proceso que lee archivo plano del  PB [LDCCAREXCLPR]

         Parametros Entrada

         Valor de salida

         HISTORIA DE MODIFICACIONES
         FECHA        AUTOR       DESCRIPCION
         05-03-2024  OSF-2388     Se reemplaza utl_file.fopen por pkg_gestionarchivos.ftabrirarchivo_smf
                                  Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo
                                  Se reemplaza utl_file.get_line por pkg_gestionarchivos.fsbobtenerlinea_smf
                                  Se reemplaza utl_file.fclose por pkg_gestionarchivos.prccerrararchivo_smf
                                  Se reemplaza 'proinsexclpr' por csbSP_NAME||'proinsexclpr'
                                  Se aumenta tamaño a la variable csbMT_NAME VARCHAR2(35) por VARCHAR2(32)
                                  Se reemplaza utl_file.new_line por pkg_gestionarchivos.prcescribetermlinea_smf
                                  Se reemplaza utl_file.put por pkg_gestionarchivos.prcescribirlineasinterm_smf
                                  Se reemplaza Dage_Directory.Fsbgetpath por pkg_bcdirectorios.fsbGetRuta
                                  Se ajusta bloque de excepciones según pautas técnicas
       ***************************************************************************/
        -- Nombre de éste método
        csbMT_NAME  VARCHAR2(32) := csbSP_NAME||'proinsexclpr';

        sbdirectory_id    ge_boinstancecontrol.stysbvalue;
        sbfilename        ge_boinstancecontrol.stysbvalue;
        sbpathfile        ge_directory.PATH%TYPE;
        nuvalextarc       NUMBER;
        nucodigoerror     NUMBER;
        sbmensajeerror    VARCHAR2 (4000);
        sbarchivoorigen   pkg_gestionarchivos.styarchivo;
        archivoerror      pkg_gestionarchivos.styarchivo;
        sblinearorigen    VARCHAR2 (4000) := NULL;
        sbnombrearchivo   VARCHAR2 (255)  := 'error_prodexcl_' || TO_CHAR (sysdate, 'YYYYMMDD_HH24MISS');
        sbfileext         VARCHAR2 (10)   := 'txt';

        sbMotiexclu       VARCHAR2 (2000) := Daldc_pararepe.fsbGetPARAVAST ('MOTIVOS_EXCLU_RP', NULL);
        tbstring          ut_string.tytb_string;
        sbSeparador       VARCHAR2 (1) := '|';
        nuProducto        NUMBER;
        sbMotivo          VARCHAR2 (400);
        sbExiste          VARCHAR2 (1);
        nuerror           NUMBER := 0;
        NULINEA           NUMBER := 1;

        CURSOR cuvaliProd IS
        SELECT 'X'
          FROM SERVSUSC
         WHERE SESUNUSE = nuProducto 
           AND SESUSERV = 7014;

        CURSOR cuExisteMotivo IS
        SELECT 'X'
          FROM ( SELECT REGEXP_SUBSTR (sbMotiexclu, '[^,]+', 1, LEVEL) AS MOTIVO
                   FROM DUAL
                CONNECT BY REGEXP_SUBSTR (sbMotiexclu, '[^,]+', 1, LEVEL) IS NOT NULL)
         WHERE MOTIVO = sbMotivo;

        CURSOR cuValidaExcl IS
        SELECT 'X'
          FROM ldc_prodexclrp
         WHERE product_id = nuProducto 
           AND motivo = sbMotivo;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        pkg_error.prInicializaError(nucodigoerror, sbmensajeerror); 

        sbdirectory_id  := ge_boinstancecontrol.fsbgetfieldvalue ('GE_DIRECTORY', 'DIRECTORY_ID'); --15 es '/smartfiles/tmp';
        pkg_traza.trace(csbMT_NAME ||' sbdirectory_id: ' || sbdirectory_id, cnuNVLTRC);
        
        sbfilename      :=  ge_boinstancecontrol.fsbgetfieldvalue ('OR_ORDER_COMMENT', 'ORDER_COMMENT'); --'prueba_1_OSF2388.txt'
        pkg_traza.trace(csbMT_NAME ||' sbfilename: ' || sbfilename, cnuNVLTRC);
        
        sbpathfile      :=  pkg_bcdirectorios.fsbGetRuta (sbdirectory_id);
        pkg_traza.trace(csbMT_NAME ||' sbpathfile: ' || sbpathfile, cnuNVLTRC);
        
        nuvalextarc     :=  REGEXP_COUNT (UPPER (SBFILENAME), '\.TXT$');
        pkg_traza.trace(csbMT_NAME ||' nuvalextarc: ' || nuvalextarc, cnuNVLTRC);

        IF nuvalextarc = 0 THEN
            pkg_traza.trace(csbMT_NAME ||' Error en el la extencion de archivo ', cnuNVLTRC); 
            pkg_error.setErrorMessage ( isbMsgErrr => 'La extension del archivo debe ser .txt');
        END IF;

        LDC_BOARCHIVO.PRVALIDAEXISTENCIAABRIR (sbpathfile,
                                               Sbfilename,
                                               nucodigoerror,
                                               sbmensajeerror);

        IF nucodigoerror <> 0 THEN
            pkg_traza.trace(csbMT_NAME ||' Error en LDC_BOARCHIVO.PRVALIDAEXISTENCIAABRIR --> '||sbmensajeerror, cnuNVLTRC);
            pkg_error.setErrorMessage ( isbMsgErrr => 'archivo [' || sbfilename || '] no existe');
        END IF;

        BEGIN
            archivoerror := pkg_gestionarchivos.ftabrirarchivo_smf (sbpathfile, sbNombreArchivo || '.' || sbfileext, 'w');
            pkg_traza.trace(csbMT_NAME ||' --> abre archivo de error '||sbNombreArchivo, cnuNVLTRC);
        EXCEPTION
            WHEN OTHERS THEN
                pkg_traza.trace(csbMT_NAME ||' when others '||sqlerrm, cnuNVLTRC);
                NULL;
        END; 

        sbarchivoorigen := pkg_gestionarchivos.ftabrirarchivo_smf (sbpathfile, sbfilename, 'R');
        pkg_traza.trace(csbMT_NAME ||' --> abre archivo origen '||sbfilename, cnuNVLTRC);

        LOOP
            BEGIN
                sblinearorigen:= pkg_gestionarchivos.fsbobtenerlinea_smf (sbarchivoorigen);
                pkg_traza.trace(csbMT_NAME ||' --> obtiene linea del archivo origen '||sblinearorigen, cnuNVLTRC);
                sblinearorigen := REPLACE (REPLACE (sblinearorigen, CHR (10), ''), CHR (13), '');
                pkg_traza.trace(csbMT_NAME ||' --> reemplaza salto de linea y retorno '||sblinearorigen, cnuNVLTRC);
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    pkg_traza.trace(csbMT_NAME ||' when no_data_found '||sqlerrm, cnuNVLTRC);
                    EXIT;
            END;

            ut_string.extstring (sblinearorigen, sbSeparador, tbstring);
            
            nuProducto := tbstring (1); 
            sbMotivo := tbstring (2);  
            nuerror := 0;

            IF cuvaliProd%ISOPEN THEN
                CLOSE cuvaliProd;
            END IF; 
            OPEN cuvaliProd; 
            FETCH cuvaliProd INTO sbExiste; 
            pkg_traza.trace(csbMT_NAME ||' El producto es de gas: '||NVL(sbExiste, 'NO'), cnuNVLTRC);
            IF cuvaliProd%NOTFOUND THEN
                pkg_traza.trace(csbMT_NAME ||' El producto (' || nuProducto  || ') no es un producto de gas o no existe', cnuNVLTRC);
                pkg_gestionarchivos.prcescribetermlinea_smf(archivoerror);
                pkg_gestionarchivos.prcescribirlineasinterm_smf( archivoerror,  'Linea: ' || NULINEA
                                                                                          || ' El producto ('
                                                                                          || nuProducto
                                                                                          || ') no es un producto de gas o no existe');
                nuerror := -1;
            END IF; 
            CLOSE cuvaliProd;

            IF cuExisteMotivo%ISOPEN THEN
                CLOSE cuExisteMotivo;
            END IF;

            OPEN cuExisteMotivo; 
            FETCH cuExisteMotivo INTO sbExiste;
            pkg_traza.trace(csbMT_NAME ||' Existe el motivo entre los configurados: '||NVL(sbExiste, 'NO'), cnuNVLTRC);

            IF cuExisteMotivo%NOTFOUND  THEN
                pkg_traza.trace(csbMT_NAME ||' El motivo ('|| sbMotivo|| ') no esta configurado en el parametro MOTIVOS_EXCLU_RP', cnuNVLTRC);
                pkg_gestionarchivos.prcescribetermlinea_smf(archivoerror);
                pkg_gestionarchivos.prcescribirlineasinterm_smf ( archivoerror, 'Linea: ' || NULINEA
                                                                                          || ' El motivo ('
                                                                                          || sbMotivo
                                                                                          || ') no esta configurado en el parametro MOTIVOS_EXCLU_RP');
                nuerror := -1;
            END IF;
            CLOSE cuExisteMotivo;

            IF cuValidaExcl%ISOPEN THEN
                CLOSE cuValidaExcl;
            END IF;

            OPEN cuValidaExcl; 
            FETCH cuValidaExcl INTO sbExiste; 
            pkg_traza.trace(csbMT_NAME ||' El producto ya está excluido: '||NVL(sbExiste, 'NO'), cnuNVLTRC);
            IF cuValidaExcl%FOUND THEN
                pkg_gestionarchivos.prcescribetermlinea_smf (archivoerror);
                pkg_gestionarchivos.prcescribirlineasinterm_smf (archivoerror, 'Linea: '|| NULINEA
                                                                                        || ' El producto ('
                                                                                        || nuProducto
                                                                                        || ') ya esta excluido con el motivo ('
                                                                                        || sbMotivo
                                                                                        || ')');
                nuerror := -1;
            END IF; 
            CLOSE cuValidaExcl;

            IF nuerror = 0 THEN
                --Se inserta excluye
                insprodexclrp (nuProducto,
                               sbMotivo,
                               NULL,
                               nucodigoerror,
                               sbmensajeerror);

                IF Nucodigoerror <> 0 THEN
                    pkg_traza.trace(csbMT_NAME ||' Error en insprodexclrp '||sbmensajeerror, cnuNVLTRC);
                    pkg_gestionarchivos.prcescribetermlinea_smf (archivoerror);
                    pkg_gestionarchivos.prcescribirlineasinterm_smf  ( archivoerror, 'Linea: ' || NULINEA
                                                                                               || ' El producto ('
                                                                                               || nuProducto
                                                                                               || ') no se pudo excluir ('
                                                                                               || SBMENSAJEERROR
                                                                                               || ')');
                    ROLLBACK;
                ELSE
                    pkg_gestionarchivos.prcescribetermlinea_smf (archivoerror);
                    pkg_gestionarchivos.prcescribirlineasinterm_smf ( archivoerror,  'Linea: ' || NULINEA
                                                                                               || ' La exclusion del producto ('
                                                                                               || nuProducto
                                                                                               || ') con el motivo ('
                                                                                               || sbMotivo
                                                                                               || ') exito');

                    COMMIT;
                END IF;
            END IF;

            NULINEA := NULINEA + 1;
        END LOOP;

        pkg_gestionarchivos.prccerrararchivo_smf (archivoerror, sbpathfile, sbNombreArchivo, FALSE);    -- se cierra archivo
        pkg_gestionarchivos.prccerrararchivo_smf (sbarchivoorigen, sbpathfile, sbNombreArchivo, FALSE); -- se cierra archivo

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_error.getError (nuerror, sbmensajeerror);
             pkg_traza.trace(csbMT_NAME ||' sbmensajeerror: ' || sbmensajeerror, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
             RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN 
             pkg_error.setError;
             pkg_error.getError (nuerror, sbmensajeerror);
             pkg_traza.trace(csbMT_NAME ||' sbmensajeerror: ' || sbmensajeerror||', Backtrace '||DBMS_UTILITY.format_error_backtrace, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);            
             RAISE pkg_error.CONTROLLED_ERROR;
    END PROINSEXCLPR;

    PROCEDURE PRELIPROEXSMPDRP
    IS
        /**************************************************************************
          Autor       : Luis Javier Lopez Barrios / Horbath
          Proceso     : PRELIPROEXSMPDRP
          Fecha       : 2021-01-08
          Ticket      : 337
          Descripcion : Plugin que elimina productos excluidos sin medidor y predio demolido

          Parametros Entrada

          Valor de salida

         HISTORIA DE MODIFICACIONES
         FECHA        AUTOR       DESCRIPCION
         05-03-2024   adrianavg   OSF-2388: se reemplaza 'preliproexsmpdrp' por csbSP_NAME||'preliproexsmpdrp'
                                  Se aumenta tamaño a la variable csbMT_NAME VARCHAR2(35) por VARCHAR2(40)
                                  Se reemplaza or_bolegalizeorder.fnuGetCurrentOrder por pkg_bcordenes.fnuobtenerotinstancialegal                                  
                                  Se ajusta bloque de excepciones según pautas técnicas
        ***************************************************************************/
        -- Nombre de éste método
        csbMT_NAME           VARCHAR2(40)     := csbSP_NAME||'preliproexsmpdrp';
        nuorden              NUMBER;            --Se almacena orden de trabajo
        sbMotivoPred         VARCHAR2 (2000)  := Daldc_pararepe.fsbGetPARAVAST ('MOTIEXCLU_PREDEMORP', NULL);
        sbMotivoSinMedidor   VARCHAR2 (2000)  := Daldc_pararepe.fsbGetPARAVAST ('MOTIEXCLU_SINMEDIRP', NULL);

        nuError              NUMBER;
        sbError              VARCHAR2 (4000);

        --se obtiene  actvidad de la orden
        CURSOR cuValdemo IS
        SELECT oa.product_id
          FROM or_order_activity oa
         WHERE oa.order_id = nuorden;

        regOrden             cuValdemo%ROWTYPE;

    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        pkg_error.prInicializaError(nuerror, sbError);
        
        pkg_traza.trace(csbMT_NAME ||' sbMotivoPred: ' || sbMotivoPred, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME ||' sbMotivoSinMedidor: ' || sbMotivoSinMedidor, cnuNVLTRC);

        --Obtener el identificador de la orden  que se encuentra en la instancia
        nuorden := pkg_bcordenes.fnuobtenerotinstancialegal;
        pkg_traza.trace(csbMT_NAME ||' nuorden: ' || nuorden, cnuNVLTRC); 

        OPEN cuValdemo; 
        FETCH cuValdemo INTO regOrden; 
        IF cuValdemo%NOTFOUND THEN
            CLOSE cuValdemo;
            pkg_traza.trace(csbMT_NAME ||' No se encontro informacion para la orden  [' || nuorden || '].', cnuNVLTRC); 
            pkg_error.setErrorMessage (  isbMsgErrr => 'No se encontro informacion para la orden  [' || nuorden  || '].');
        END IF; 
        CLOSE cuValdemo;
        pkg_traza.trace(csbMT_NAME ||' Invoca DELPRODEXCLRP con Motivo: '||sbMotivoPred, cnuNVLTRC);
        delprodexclrp (regOrden.product_id,
                       sbMotivoPred,
                       nuError,
                       sbError);
        pkg_traza.trace(csbMT_NAME ||' nuError: ' || nuError||', sbError ' ||sbError, cnuNVLTRC);
        
        IF nuError = 0 THEN
            pkg_traza.trace(csbMT_NAME ||' Invoca DELPRODEXCLRP con Motivo: '||sbMotivoSinMedidor, cnuNVLTRC);
            delprodexclrp (regOrden.product_id,
                           sbMotivoSinMedidor,
                           nuError,
                           sbError);
            pkg_traza.trace(csbMT_NAME ||' nuError: ' || nuError||', sbError ' ||sbError, cnuNVLTRC);
            
            IF nuError <> 0 THEN
                pkg_traza.trace(csbMT_NAME ||' No se pudo eliminar exclusion del producto  [' || regOrden.product_id
                                                                                              || '] motivo ['
                                                                                              || sbMotivoSinMedidor
                                                                                              || '] error: '
                                                                                              || sbError, cnuNVLTRC); 
                pkg_error.setErrorMessage ( isbMsgErrr => 'No se pudo eliminar exclusion del producto  [' || regOrden.product_id
                                                                                                          || '] motivo ['
                                                                                                          || sbMotivoSinMedidor
                                                                                                          || '] error: '
                                                                                                          || sbError);
            END IF;
        ELSE
            pkg_traza.trace(csbMT_NAME ||' No se pudo eliminar exclusion del producto  [' || regOrden.product_id
                                                                                                        || '] motivo ['
                                                                                                        || sbMotivoPred
                                                                                                        || '] error: '
                                                                                                        || sbError, cnuNVLTRC); 
            pkg_error.setErrorMessage ( isbMsgErrr =>  'No se pudo eliminar exclusion del producto  [' || regOrden.product_id
                                                                                                        || '] motivo ['
                                                                                                        || sbMotivoPred
                                                                                                        || '] error: '
                                                                                                        || sbError);
        END IF;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_error.getError (nuError, sbError);
             pkg_traza.trace(csbMT_NAME ||' sbError: ' || sbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
             RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
             pkg_error.setError;
             pkg_error.getError (nuError, sbError);
             pkg_traza.trace(csbMT_NAME ||' sbError: ' || sbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
             RAISE pkg_error.CONTROLLED_ERROR;
    END PRELIPROEXSMPDRP;

    PROCEDURE PRPROCGENVSI
    IS
        /**************************************************************************
           Autor       : Horbath
           Fecha       : 2019-08-01
           Ticket      : 200-2630
           Descripcion : plugin para generar VSI.

           Parametros Entrada

           Valor de salida

           HISTORIA DE MODIFICACIONES
           FECHA        AUTOR       DESCRIPCION
           09/12/2020   dvaliente   Se obtiene el comentario de legalizacion y se anexo al comentario de la nueva solicitud VSI. (Caso 132)
           05-03-2024   adrianavg   OSF-2388: Se declara variable csbMT_NAME
                                    Se reemplaza ge_bopersonal.fnugetpersonid por pkg_bopersonal.fnugetpersonaid
                                    Se reemplaza or_bolegalizeorder.fnuGetCurrentOrder por pkg_bcordenes.fnuobtenerotinstancialegal
                                    Se reemplaza P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101 por pkg_xml_soli_vsi.getSolicitudVSI
                                    Se reemplaza ge_bopersonal.getcurrentchannel por pkg_bopersonal.fnugetpuntoatencionid
                                    Se reemplaza daor_order_person.fnugetperson_id por pkg_bcordenes.fnuobtenerpersona
                                    Se ajusta bloque de excepciones según pautas técnicas
        ***************************************************************************/
        -- Nombre de éste método
        csbMT_NAME      VARCHAR2(32) := csbSP_NAME||'prprocgenvsi';

        nuorden         NUMBER;                  --se almacena numero de orden
        sbmensa         VARCHAR2 (4000);
        nuPersonIdsol   NUMBER := pkg_bopersonal.fnugetpersonaid;
        onuchannel      cc_orga_area_seller.organizat_area_id%TYPE;
        sbObserva       VARCHAR2 (4000);
        sbRequestXML    VARCHAR2 (4000);
        nuPackageId     NUMBER;
        nuMotiveId      NUMBER;
        onuErrorCode    NUMBER;

        --se consultan datos de la orden
        CURSOR cuGetdatOrden IS
        SELECT O.TASK_TYPE_ID, O.OPERATING_UNIT_ID, O.CAUSAL_ID, OA.ACTIVITY_ID, s.package_id, P.CATEGORY_ID, P.SUBCATEGORY_ID,
               NVL (S.PACKAGE_TYPE_ID, -1)     PACKAGE_TYPE_ID, OA.PRODUCT_ID, OA.SUBSCRIBER_ID, P.ADDRESS_ID
          FROM or_order o, or_order_activity oa
          LEFT JOIN mo_packages s ON s.package_id = oa.package_id, pr_product p
         WHERE o.order_id = oa.order_id
           AND o.order_id = nuorden
           AND p.product_id = oa.product_id;

        regDatOrden     cuGetdatOrden%ROWTYPE;

        CURSOR cuConfVSI IS
        SELECT C.COCLACTI, C.COCLMERE, c.COCLASAU
          FROM LDC_COTTCLAC c
         WHERE ( c.COCLTISO = regDatOrden.PACKAGE_TYPE_ID OR c.COCLTISO = -1)
           AND c.COCLTITR   = regDatOrden.TASK_TYPE_ID
           AND ( c.COCLACPA = regDatOrden.ACTIVITY_ID OR c.COCLACPA IS NULL)
           AND ( c.COCLCAUS = regDatOrden.CAUSAL_ID OR c.COCLCAUS = -1)
           AND ( c.COCLCATE = regDatOrden.CATEGORY_ID OR c.COCLCATE = -1)
           AND ( c.COCLSUCA = regDatOrden.SUBCATEGORY_ID OR c.COCLSUCA IS NULL);
    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        pkg_traza.trace(csbMT_NAME ||' nuPersonIdsol: ' || nuPersonIdsol, cnuNVLTRC);

        nuorden := pkg_bcordenes.fnuobtenerotinstancialegal; --se obtiene orden que se esta legalizando
        pkg_traza.trace(csbMT_NAME ||' nuorden: ' || nuorden, cnuNVLTRC); 

        --se carga informacion de la orden
        OPEN cuGetdatOrden; 
        FETCH cuGetdatOrden INTO regDatOrden; 
        IF cuGetdatOrden%NOTFOUND THEN
            sbmensa := 'No existe informacion de la orden ' || TO_CHAR (nuorden);
            pkg_traza.trace(csbMT_NAME ||' sbmensa: ' || sbmensa, cnuNVLTRC); 
            pkg_error.setErrorMessage (isbMsgErrr => sbmensa);
        END IF; 
        CLOSE cuGetdatOrden;

        --se obtiene punto de atencion
        onuchannel := pkg_bopersonal.fnugetpuntoatencionid (nuPersonIdsol);
        pkg_traza.trace(csbMT_NAME ||' Punto de atención: ' || onuchannel, cnuNVLTRC);
        
        sbObserva := 'Solicitud Generada por legalizacion de la orden #' || nuorden;
        pkg_traza.trace(csbMT_NAME ||' sbObserva: ' || sbObserva, cnuNVLTRC);

        FOR reg IN cuConfVSI
        LOOP
            nuPackageId := NULL;
            nuMotiveId := NULL;
            onuErrorCode := NULL;
            sbmensa := NULL;

            pkg_traza.trace(csbMT_NAME ||' inuMedioRecepcionId: ' || reg.coclmere, cnuNVLTRC);
            pkg_traza.trace(csbMT_NAME ||' inuProductoId: ' || regDatOrden.product_id, cnuNVLTRC);
            pkg_traza.trace(csbMT_NAME ||' inuClienteId: ' || regDatOrden.Subscriber_Id, cnuNVLTRC);
            pkg_traza.trace(csbMT_NAME ||' inuPersonaID: ' || nuPersonIdsol, cnuNVLTRC);
            pkg_traza.trace(csbMT_NAME ||' inuAddressId: ' || regDatOrden.address_id, cnuNVLTRC);
            pkg_traza.trace(csbMT_NAME ||' inuActividadId: ' || reg.coclacti, cnuNVLTRC);

            sbRequestXML := pkg_xml_soli_vsi.getSolicitudVSI(NULL,                      --inuContratoID
                                                             reg.coclmere,              --inuMedioRecepcionId
                                                             sbObserva,                 --isbComentario
                                                             regDatOrden.product_id,    --inuProductoId
                                                             regDatOrden.Subscriber_Id, --inuClienteId
                                                             nuPersonIdsol,             --inuPersonaID
                                                             onuchannel,                --inuPuntoAtencionId
                                                             SYSDATE,                   --idtFechaSolicitud
                                                             regDatOrden.address_id,    --inuAddressId
                                                             regDatOrden.address_id,    --inuTrabajosAddressId
                                                             reg.coclacti               --inuActividadId
                                                             ); --P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101


            /*Ejecuta el XML creado*/
            API_REGISTERREQUESTBYXML (sbRequestXML,
                                       nuPackageId,
                                       nuMotiveId,
                                       onuErrorCode,
                                       sbmensa);

            IF nupackageid IS NULL THEN
                pkg_traza.trace(csbMT_NAME ||' API_REGISTERREQUESTBYXML -->nupackageid IS NULL '||sbmensa, cnuNVLTRC);  
                RAISE pkg_error.CONTROLLED_ERROR;
            ELSE

                pkg_traza.trace(csbMT_NAME ||' operating_unit_id: '||regdatorden.operating_unit_id, cnuNVLTRC);
                pkg_traza.trace(csbMT_NAME ||' causal_id: '||regdatorden.causal_id, cnuNVLTRC);                
                pkg_traza.trace(csbMT_NAME ||' Asignación automática: '||reg.COCLASAU, cnuNVLTRC);
                
                IF reg.COCLASAU = 'S' THEN

                    INSERT INTO ldc_bloq_lega_solicitud (
                        package_id_orig,
                        package_id_gene
                    ) VALUES (
                        regdatorden.package_id,
                        nupackageid
                    );

                    pkg_traza.trace(csbMT_NAME ||' INSERT INTO LDC_BLOQ_LEGA_SOLICITUD PACKAGE_ID_ORIG= '||regDatOrden.package_id, cnuNVLTRC); 

                    INSERT INTO ldc_ordeasigproc (
                        oraporpa,
                        orapsoge,
                        oraopele,
                        oraounid,
                        oraocale,
                        oraoitem,
                        oraoproc
                    ) VALUES (
                        nuorden,
                        nupackageid,
                        pkg_bcordenes.fnuobtenerpersona(nuorden),
                        regdatorden.operating_unit_id,
                        regdatorden.causal_id,
                        NULL,
                        'SEVAASAU'
                    );

                    pkg_traza.trace(csbMT_NAME ||' INSERT INTO LDC_ORDEASIGPROC nuorden= '||nuorden, cnuNVLTRC); 

                ELSE
                    INSERT INTO LDC_ORDEASIGPROC (ORAPORPA,
                                                  ORAPSOGE,
                                                  ORAOPELE,
                                                  ORAOUNID,
                                                  ORAOCALE,
                                                  ORAOITEM,
                                                  ORAOPROC)
                             VALUES (
                                        nuorden,
                                        nuPackageId,
                                        pkg_bcordenes.fnuobtenerpersona(nuorden),
                                        NULL,
                                        regDatOrden.causal_id,
                                        NULL,
                                        'SEVAASAU');
                    pkg_traza.trace(csbMT_NAME ||' INSERT INTO LDC_ORDEASIGPROC nuorden= '||nuorden, cnuNVLTRC);
                END IF;
            END IF;
        END LOOP;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFin);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_error.getError (onuErrorCode, sbmensa);
             pkg_traza.trace(csbMT_NAME ||' sbmensa: ' || sbmensa, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
             pkg_error.setError;
             pkg_error.getError (onuErrorCode, sbmensa);
             pkg_traza.trace(csbMT_NAME ||' sbmensa: ' || sbmensa, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
             RAISE pkg_error.CONTROLLED_ERROR;
    END PRPROCGENVSI;

    PROCEDURE PRGEMARANILLDENTRO
    IS
        /**************************************************************************
          Autor       :  Horbath
          Proceso     : PRGEMARANILLDENTRO
          Fecha       : 2021-05-17
          Ticket      : 693
          Descripcion : Plugin que genera marcacion en la tabla LDC_PRODEXCLRP con el motivo
                        Anillo pasa por dentro

          Parametros Entrada

          Valor de salida

          HISTORIA DE MODIFICACIONES
          FECHA        AUTOR       DESCRIPCION
         05-03-2024   adrianavg    OSF-2388: se reemplaza 'prgemaranilldentro' por csbSP_NAME||'prgemaranilldentro'
                                   Se aumenta tamaño a la variable csbMT_NAME VARCHAR2(35) por VARCHAR2(38)
                                   Se reemplaza or_bolegalizeorder.fnugetcurrentorder por pkg_bcordenes.fnuobtenerotinstancialegal
                                   Se ajusta bloque de excepciones según pautas técnicas
        ***************************************************************************/
        -- Nombre de éste método
        csbMT_NAME      VARCHAR2(38) := csbSP_NAME||'prgemaranilldentro';

        nuorden          NUMBER;

        CURSOR cuValidaEstaProd IS
        SELECT OA.product_id
          FROM or_order_activity oa, pr_product s
         WHERE OA.order_id = nuorden
           AND s.Product_Id = OA.product_id
           AND product_status_id = 1;

        nuProducto       NUMBER; 
        onuError         NUMBER;
        osbError         VARCHAR2 (4000);

        SBmOTIVOANILLO   VARCHAR2 (400) := DALDC_PARAREPE.FSBGETPARAVAST ('LDC_MOTIANILLDENT', NULL);
    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        nuorden := pkg_bcordenes.fnuobtenerotinstancialegal; --se obtiene orden que se esta legalizando
        pkg_traza.trace(csbMT_NAME ||' nuorden: '||nuorden, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME ||' sbmotivoanillo: '||sbmotivoanillo, cnuNVLTRC);

        OPEN cuValidaEstaProd; 
        FETCH cuValidaEstaProd INTO nuProducto; 
        CLOSE cuValidaEstaProd;
        pkg_traza.trace(csbMT_NAME ||' nuProducto: '||nuProducto, cnuNVLTRC);

        IF nuProducto IS NOT NULL THEN
            insprodexclrp (nuProducto,
                           sbmotivoanillo,
                           nuOrden,
                           onuError,
                           osbError);

            IF onuError <> 0 THEN
                pkg_traza.trace(csbMT_NAME ||' insprodexclrp --> osbError: '||osbError, cnuNVLTRC);
                RAISE pkg_error.CONTROLLED_ERROR;
            END IF;
        END IF;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_error.getError (onuError, osbError);
             pkg_traza.trace(csbMT_NAME ||' osbError: ' || osbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
             RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
             pkg_error.setError;
             pkg_error.getError (onuError, osbError);
             pkg_traza.trace(csbMT_NAME ||' osbError: ' || osbError, cnuNVLTRC);
             pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
             RAISE pkg_error.CONTROLLED_ERROR;
    END PRGEMARANILLDENTRO;
END LDC_PKGESTPREXCLURP;
/

PROMPT Otorgando permisos de ejecución sobre LDC_PKGESTIONCASURP
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKGESTPREXCLURP','OPEN');
END;
/