CREATE OR REPLACE PACKAGE LDC_PKGESTIONCASURP IS

/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    LDC_PKGESTIONCASURP
    Autor       :   Horbath
    Fecha       :   01-26-2020
    Descripcion :   Paquete con los objetos para suspensión
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     27-07-2023  OSF-1356    * Se reemplaza os_legalizeorders por
                                        api_legalizeorders
                                        * ge_boerrors.seterrorcodeargument por
                                        pkg_error.setErrorMessage                                         
                                        * Se reemplaza Errors.setError por
                                        pkg_error.setError
                                        * Se reemplaza ERRORS.geterror por
                                        pkg_error.getError
                                        * Se cambia raise ex.Controlled_Error
                                        por pkg_error.Controlled_Error
                                        * Se cambia when ex.CONTROLLED_ERROR 
                                        por WHEN pkg_error.Controlled_Error
                                        * Se quita RAISE pkg_Error.controlled_error
                                        después de pkg_error.setErrorMessage
                                        * Se quitan variables que no se usan
                                        * Se quita codigo que está en comentarios
                                        * Se reemplaza signo de interrogación
                                        * Se quita flbAplicaEntregaXCaso
                                        * Se agrega pkg_utilidades.prAplicarPermisos
                                        * Se agrega pkg_utilidades.prCrearSinonimos
    jpinedc     02-08-2023  OSF-1356    * Se reemplaza OS_ASSIGN_ORDER por API_ASSIGN_ORDER
                                        * Se reemplaza OS_RegisterRequestWithXML por                                        
                                        API_REGISTERREQUESTBYXML
                                        * Se agrega traza de inicio y fin con ut_trace
                                        * Se quita open.
                                        * Se reemplaza ex.controlled_error por
                                        pkg_error.controlled_error                                         
    jpinedc     08-08-2023  OSF-1356    * Se quita "OPEN".
    jpinedc     27-05-2024  OSF-2603    * Se reemplaza ldc_enviamail por
                                        pkg_Correo.prcEnviaCorreo
*******************************************************************************/

  gbCiclo NUMBER := 0;

  PROCEDURE proRegistraLogLegOrdRecoSusp(sbProceso  IN LOG_ERRORES_CAMBIO_TISU.proceso%TYPE,
                                         dtFecha    IN LOG_ERRORES_CAMBIO_TISU.fechgene%TYPE,
                                         nuOrden    IN LOG_ERRORES_CAMBIO_TISU.order_id%TYPE,
                                         nuOrdenPad IN LOG_ERRORES_CAMBIO_TISU.ORDEPADRE%TYPE,
                                         sbError    IN LOG_ERRORES_CAMBIO_TISU.menserror%TYPE,
                                         sbUsuario  IN LOG_ERRORES_CAMBIO_TISU.usuario%TYPE);
  /**************************************************************************
     Autor       : Horbath
     Fecha       : 2020-26-01
     Ticket      : 176
     Descripcion : Proceso que genera log de errores

     Parametros Entrada
     sbProceso  nombre del proceso
     dtFecha    fecha de generacion
     nuProducto producto
     sbError    mensaje de error
     nuSesion   numero de sesion
     sbUsuario  usuario

     Valor de salida

     Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ***************************************************************************/

  PROCEDURE PRINDEPRODSUCA(inuProducto  IN NUMBER,
                           nuEstaCorRec OUT NUMBER,
                           nuJob        IN Number default 1,
                           nuOk         OUT NUMBER);
  /**************************************************************************
    Proceso     : PRINDEPRODSUCA
    Autor       : Horbath
    Fecha       : 2020-01-22
    Ticket      : 176
    Descripcion : identificacion de productos suspendido por cartera

    Parametros Entrada
    inuProducto    Codigo de producto


    Parametros de salida
     nuEstaCorRec   estado de corte orden de reconexion
     nuOk   0 producto cumple -1 no cumple

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE PRGENREGSUPCONE(inuSolicitud IN NUMBER);
  /**************************************************************************
    Proceso     : PRGENREGSUPCONE
    Autor       : Horbath
    Fecha       : 2020-01-22
    Ticket      : 176
    Descripcion : registra valor en suspcone

    Parametros Entrada
    inuSolicitud    Codigo de solicitud


    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE PRDELPRODMARE;
  /**************************************************************************
    Proceso     : PRDELPRODMARE
    Autor       : Horbath
    Fecha       : 2020-01-22
    Ticket      : 176
    Descripcion : elimina registro de la tabla LDC_PRODRERP

    Parametros Entrada

    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE PRGENRECORP(inuProducto  IN NUMBER,
                        nuEstaCorRec IN NUMBER,
                        onuError     OUT NUMBER,
                        osberror     OUT VARCHAR2,
                        onuSolicitud OUT MO_PACKAGES.PACKAGE_ID%TYPE);
  /**************************************************************************
    Proceso     : PRGENRECORP
    Autor       : Horbath
    Fecha       : 2020-01-22
    Ticket      : 176
    Descripcion : genera tramite de Cambio Tipo Suspension a RP

    Parametros Entrada
     inuProducto    Codigo de producto
     nuEstaCorRec    estado de orden de reconexion

    Parametros de salida
     onuError  codigo de error, 0 si no hay error
     osberror   mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  PROCEDURE EJECUTARHILO(inucantHil in number --
                         );
  PROCEDURE PRJOBRECOYSUSPRP(inuCantHilo NUMBER, inuHilo NUMBER,nupacodigo_producto NUMBER DEFAULT NULL);
  /**************************************************************************
    Proceso     : PRJOBRECOYSUSPRP
    Autor       : Horbath
    Fecha       : 2020-01-22
    Ticket      : 176
    Descripcion : job que asigna y legaliza ordenes de reconexion y suspension

    Parametros Entrada

    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  FUNCTION fnuGeneTramSuspRP(inuProducto   IN NUMBER,
                             inuMedioRecep IN NUMBER,
                             InutipoCausal IN NUMBER,
                             InuCausal     IN NUMBER,
                             inuTipoSusp   IN NUMBER,
                             IsbComment    IN VARCHAR2,
                             onuError      OUT NUMBER,
                             osberror      OUT VARCHAR2) RETURN NUMBER;
  /**************************************************************************
   Proceso     : fnuGeneTramSuspRP
   Autor       : Horbath
   Fecha       : 2020-01-22
   Ticket      : 176
   Descripcion : funcion que se encarga de crear tramite de suspension RP

   Parametros Entrada
     inuProducto    codigo del producto
     inuMedioRecep  medio de recepcion
     InutipoCausal  tipo de causal
     InuCausal      causal
     inuTipoSusp    tipo de suspension
     IsbComment     comentario de generacion

   Parametros de salida
    onuError codigo de error 0 si es correcto
     osberror mensaje de error
   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE prAsigLegOrdSusp(inuOrdenSusp     IN NUMBER,
                             InuOrderActivity IN NUMBER,
                             inuUnidOpeSus    IN NUMBER,
                             InuCausaLegSu    IN NUMBER,
                             InupersLegSus    IN NUMBER,
                             inuLectura       IN NUMBER,
                             IsbItem          IN VARCHAR2 DEFAULT NULL,
                             isbMedidor       IN VARCHAR2,
                             isbObservacion   IN VARCHAR2,
                             Onuerror         OUT NUMBER,
                             OSBERROR         OUT VARCHAR2);
  /**************************************************************************
     Proceso     : prAsigLegOrdSusp
     Autor       : Horbath
     Fecha       : 2020-01-22
     Ticket      : 176
     Descripcion : Asigna y legaliza orden de suspension

     Parametros Entrada
      inuOrdenSusp      orden de suspension
      InuOrderActivity  order activity
      inuUnidOpeSus     unidad operativa asignar
      InuCausaLegSu     causal de legalizacion
      InupersLegSus     persona que legaliza
      inuLectura        lectura
      IsbItem           item a legaliza
      isbMedidor        medidor
      isbObservacion    observacion

     Parametros de salida
      onuError  codigo de error, 0 si no hay error
      osberror   mensaje de error

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  PROCEDURE PRJOBRECOYSUSPRP2;
  /**************************************************************************
    Proceso     : PRJOBRECOYSUSPRP
    Autor       : Horbath
    Fecha       : 2020-01-22
    Ticket      : 176
    Descripcion : job que asigna y legaliza ordenes de reconexion y suspension

    Parametros Entrada

    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  procedure reconectaproduct;
  procedure RECONECTAPRODUCTCAST;
  procedure proEmpujaSolicitud(nuPackage       in mo_packages.package_id%type,
                               osberrormessage out varchar2);
  PROCEDURE PRINDEPRODSUADVO(inuProducto IN NUMBER,
                             onuerror    OUT NUMBER,
                             osbError    OUT VARCHAR2);
  /**************************************************************************
    Proceso     : PRJOBRECOYSUSPRP
    Autor       : olsoftware
    Fecha       : 2020-03-16
    Ticket      : 498
    Descripcion : proceso que se encarga de validar si un producto cumple para realizar cambio de suspension

    Parametros Entrada
       inuProducto  codigo del producto
    Parametros de salida
      onuerror codigo de error
      osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE PRGENETRAMRP(inuProducto    IN NUMBER,
                         inuMedioRece   IN NUMBER,
                         isbObservacion IN VARCHAR2,
                         onuError       OUT NUMBER,
                         osbError       OUT VARCHAR2);
  /**************************************************************************
    Proceso     : PRGENETRAMRP
    Autor       : olsoftware
    Fecha       : 2020-03-16
    Ticket      : 498
    Descripcion : proceso que se encarga de generar tramite de rp

    Parametros Entrada
       inuProducto  codigo del producto
       inuMedioRece  codigo de medio de recepcion
       isbObservacion  observacion
    Parametros de salida
      onuerror codigo de error
      osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE PRJOBRECOYSUSPXPROD(inuProducto NUMBER);

/**************************************************************************
  Proceso     : PRJOBRECOYSUSPXPROD
  Autor       : Olsoftware
  Fecha       : 2021-03-23
  Ticket      : 498
  Descripcion : job que asigna y legaliza ordenes de reconexion y suspension

  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
 ***************************************************************************/
end LDC_PKGESTIONCASURP;
/

CREATE OR REPLACE PACKAGE BODY LDC_PKGESTIONCASURP IS

    -- Constantes para el control de la traza
    csbSP_NAME                 CONSTANT VARCHAR2(100)         := 'LDC_PKGESTIONCASURP.';
    cnuNVLTRC                  CONSTANT NUMBER                := 5;
    
  --Se obtiene lectura de suspencion
  CURSOR cugetlecturaSusp(nuProd pr_product.product_id%type) IS
    SELECT LE.LEEMLETO
      FROM LECTELME le, ldc_PRODRERP p
     WHERE LE.LEEMSESU = P.PRREPROD
       AND le.LEEMDOCU = p.PRREACTI
       AND p.PRREPROD = nuProd
     order by le.leemfele desc;

  --Se obtiene lectura de suspencion
  CURSOR cugetlecturaFact(nuProd pr_product.product_id%type) IS
    SELECT LE.LEEMLETO
      FROM LECTELME le
     WHERE LE.LEEMSESU = nuProd
       AND LE.LEEMCLEC = 'F'
       AND (LE.LEEMOBLE = -1 OR LE.LEEMOBLE IS NULL)
       AND LE.LEEMLETO IS NOT NULL
     order by le.leemfele desc;

    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');

  PROCEDURE proRegistraLogLegOrdRecoSusp(sbProceso  IN LOG_ERRORES_CAMBIO_TISU.proceso%TYPE,
                                         dtFecha    IN LOG_ERRORES_CAMBIO_TISU.fechgene%TYPE,
                                         nuOrden    IN LOG_ERRORES_CAMBIO_TISU.order_id%TYPE,
                                         nuOrdenPad IN LOG_ERRORES_CAMBIO_TISU.ORDEPADRE%TYPE,
                                         sbError    IN LOG_ERRORES_CAMBIO_TISU.menserror%TYPE,
                                         sbUsuario  IN LOG_ERRORES_CAMBIO_TISU.usuario%TYPE) IS
    /**************************************************************************
       Autor       : Horbath
       Fecha       : 2020-26-01
       Ticket      : 176
       Descripcion : Proceso que genera log de errores

       Parametros Entrada
       sbProceso  nombre del proceso
       dtFecha    fecha de generacion
       nuProducto producto
       sbError    mensaje de error
       nuSesion   numero de sesion
       sbUsuario  usuario

       Valor de salida

       Historia de Modificaciones
       Fecha               Autor                Modificacion
     =========           =========          ====================
    ***************************************************************************/

    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN

    ut_trace.trace('Inicia ' || csbSP_NAME|| 'proRegistraLogLegOrdRecoSusp' , cnuNVLTRC); 
        
    INSERT INTO LOG_ERRORES_CAMBIO_TISU
      (proceso, fechgene, order_id, menserror, usuario)
    VALUES
      (sbProceso, dtFecha, nuOrden, sbError, sbUsuario);
    COMMIT;

    ut_trace.trace('Termina ' || csbSP_NAME|| 'proRegistraLogLegOrdRecoSusp' , cnuNVLTRC);
    
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END proRegistraLogLegOrdRecoSusp;

  PROCEDURE proRegistraLogValida(inuProducto  IN LDC_PRVACASU.PRCANUSE%TYPE,
                                 inuEstaCorte IN LDC_PRVACASU.PRCAESCO%TYPE,
                                 isbObserva   IN LDC_PRVACASU.PRCAOBSE%TYPE) IS
    /**************************************************************************
        Autor       : Horbath
        Fecha       : 2020-26-01
        Ticket      : 176
        Descripcion : Proceso que genera log de validacion de productos

        Parametros Entrada
        inuProducto    codigo del producto
    inuEstaCorte   estado de corte
        isbObserva     observacion

        Valor de salida

        Historia de Modificaciones
        Fecha               Autor                Modificacion
      =========           =========          ====================
     ***************************************************************************/

    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN

    ut_trace.trace('Inicia ' || csbSP_NAME|| 'proRegistraLogValida' , cnuNVLTRC); 
    
    INSERT INTO LDC_PRVACASU
      (PRCANUSE, PRCAFEVA, PRCAESCO, PRCAOBSE)
    VALUES
      (inuProducto, SYSDATE, inuEstaCorte, isbObserva);
    COMMIT;
    
    ut_trace.trace('Termina ' || csbSP_NAME|| 'proRegistraLogValida' , cnuNVLTRC);
        
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END proRegistraLogValida;

  PROCEDURE EJECUTARHILO(inucantHil in number) IS
    -- Variables
    sbWhat         GE_BOUTILITIES.STYSTATEMENT;
    nujob          number;
  BEGIN

    ut_trace.trace('Inicia ' || csbSP_NAME|| 'EJECUTARHILO' , cnuNVLTRC); 
    
    -- Loop to schedule threads
    FOR nuHilo IN 1 .. inucantHil LOOP

      sbWhat := 'BEGIN' || ' ' || 'LDC_PKGESTIONCASURP.PRJOBRECOYSUSPRP(' || ' ' ||
                to_char(inucantHil) || ', ' || to_char(nuHilo) || ' ' || ');' || ' ' ||
                'EXCEPTION' || ' ' ||
                'WHEN LOGIN_DENIED OR PKG_ERROR.CONTROLLED_ERROR THEN' || ' ' ||
                'RAISE;' || ' ' || 'WHEN OTHERS THEN' || ' ' ||
                'pkg_error.setError;' || ' ' || 'RAISE pkg_Error.controlled_error;' || ' ' ||
                'END;';

      dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
      commit;

    END LOOP;

    -- Sleep
    DBMS_LOCK.SLEEP(5);

    ut_trace.trace('Termina ' || csbSP_NAME|| 'EJECUTARHILO' , cnuNVLTRC);

  END EJECUTARHILO;

  PROCEDURE PRINDEPRODSUCA(inuProducto  IN NUMBER,
                           nuEstaCorRec OUT NUMBER,
                           nuJob        IN Number default 1,
                           nuOk         OUT NUMBER) IS
    /**************************************************************************
     Proceso     : PRINDEPRODSUCA
     Autor       : Horbath
     Fecha       : 2020-01-22
     Ticket      : 176
     Descripcion : identificacion de productos suspendido por cartera

     Parametros Entrada
      inuProducto    Codigo de producto


     Parametros de salida
       nuEstaCorRec   estado de corte en orden de reconexion
       nuOk   0 producto cumple -1 no cumple
     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    nuTipoSuspCart   ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_TIPOSUSCA'); --se almacena tipo de suspension de cartera
    sbEstaCort       ldc_pararepe.paravast%type := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_ESCOPRVA'); --se almacena estado de corte
    sbTitrPers       ldc_pararepe.paravast%type := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_TITRPERCAR'); --se almacena tipo d etrabajo de persecucion
    sbEstaOrpe       ldc_pararepe.paravast%type := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_ESORPER'); --se almacena estado de orden de persecucion
    sbEstaOrre       ldc_pararepe.paravast%type := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_ESORRECO'); --se almacena estado de orden de reconexion
    sbTramReco       ldc_pararepe.paravast%type := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_TRAMRECOCA'); --se almacena tramite de reconexion por pago
    nuEstaReso       ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_ESTARESO'); --se almacena estado abierto de las solicitudes
    sbEstaCore       ldc_pararepe.paravast%type := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_CODESOPRE'); --se almacena estado de corte de orden de reconexion
    nuTramiRec       ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CODTRAMRERP'); --se alamcena tipo de solicitud reconexion dummy
    nuEstadoRegTr    ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_ESTARESO'); --se almacena estado del tramite
    nuClasCausExi    ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CLCAEXIT'); --se almacena causal de clase exito
    nuEstaCerrOt     ld_parameter.numeric_value%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_ORDER_STATUS');
    nuEstaCortSuspTo ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('ESTADO_CORTE_SUSPENSION_TOTAL'); --Caso 442: estado de corte suspecion total

    sbdatos    varchar2(1); --se alamcena datos de valida de ot
    nuExiste   NUMBER := 0;
    nuEstacort NUMBER;

    TYPE typRefCursor IS REF CURSOR;
    vcursor typRefCursor;
    --sbsql   VARCHAR2(4000);

    --se valida si tiene tramite de reconexion pendiente
    CURSOR cuValidaTrmRec IS
      SELECT 'X'
        FROM mo_packages s, or_order_activity oa
       WHERE s.package_id = oa.package_id
         and oa.product_id = inuProducto
         and S.PACKAGE_TYPE_ID = nuTramiRec
         and S.MOTIVE_STATUS_ID = nuEstadoRegTr;

    --valida que producto no este pendiente de suspension rp
    cursor cuValidaOrdeSusp is
      select 'x'
        from ldc_prodreasu
       where ESTASUSP = 'N'
         and PRODUCT_ID = inuProducto;

    --Valida que el producto no se encuentre en proceso de cambio de suspension
    CURSOR cuValidaProdProc IS
      SELECT 'X'
        FROM LDC_PRODRERP
       WHERE PRREPROD = inuProducto
         and PRREPROC = 'N';

    --valida orden de persecucion
    CURSOR cuValiOrdePers IS
      SELECT /*+ index (o PK_OR_ORDER)
                     index (oa IDX_OR_ORDER_ACTIVITY_010)
                        */
       'X'
        FROM or_order o, or_order_activity oa
       WHERE o.ordeR_id = oa.order_id
         AND oa.product_id = inuProducto
         AND o.task_type_id IN (10169, 10884, 10918, 12521) --sbTitrPers
         AND o.order_status_id in (0, 5, 6, 7, 11); --sbEstaOrpe

    --SE VALDIA ORDEN DE RECONEXION
    CURSOR cuValidaOrReco IS
      SELECT /*+ index (o PK_OR_ORDER)
                        index (oa IDX_OR_ORDER_ACTIVITY_010)
                        index (s PK_MO_PACKAGES)
                        */
       'X'
        FROM or_order o, or_order_activity oa, mo_packages s
       WHERE o.ordeR_id = oa.order_id
         AND oa.package_id = s.package_id
         AND oa.product_id = inuProducto
         AND s.package_type_id IN (300) --sbTramReco
         AND (o.order_status_id in (5, 7) --sbEstaOrre
             or (o.order_status_id = nuEstaCerrOt and
             DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(o.causal_id, null) =
             nuClasCausExi)) --sbEstaOrre

         AND s.MOTIVE_STATUS_ID = nuEstaReso;

    sbObserva VARCHAR2(4000);

    --se obtiene estado de corte del producto
    CURSOR cuGetEstaCorte Is
      SELECT SESUESCO, sesuesfn, PRODUCT_STATUS_ID
        FROM servsusc, PR_PRODUCT
       WHERE sesunuse = inuProducto
         AND product_id = sesunuse;

    nuestacorte NUMBER;
    sbEstaFina  VARCHAR2(2);
    nuEstaProd  NUMBER;

    --se obtiene inclusion del producto
    CURSOR cugetInclusion IS
      SELECT INCCFERE
        FROM inclcoco
       WHERE inccsesu = inuProducto
         AND inccfeca IS NULL;

    dtFechaIncl DATE;

  BEGIN
  
    ut_trace.trace('Inicia ' || csbSP_NAME|| 'PRINDEPRODSUCA' , cnuNVLTRC);

    nuOk        := 0;
    sbObserva   := 'PRODUCTO CUMPLE CON LOS REQUISITOS';
    nuestacorte := NULL;
    sbdatos     := NULL;
    nuEstacort  := NULL;
    dtFechaIncl := NULL;
    sbEstaFina  := NULL;
    nuEstaProd  := NULL;

    IF nuJob = 1 THEN
      OPEN cuValidaProdProc;
      FETCH cuValidaProdProc
        INTO sbdatos;
      CLOSE cuValidaProdProc;
    END IF;

    IF sbdatos IS NOT NULL THEN
      nuOk      := 1;
      sbObserva := 'PRODUCTO YA FUE MARCADO Y SE ENCUENTRA EN PROCESO';
    ELSE
      --se valida tramite de reconexion
      IF nuJob in (1, 2) THEN
        OPEN cuValidaTrmRec;
        FETCH cuValidaTrmRec
          INTO sbdatos;
        CLOSE cuValidaTrmRec;
      END IF;

      IF sbdatos IS NOT NULL THEN
        nuOk      := 1;
        sbObserva := 'PRODUCTO TIENE ORDEN DE RECONEXION DUMMY EN PROCESO';
      ELSE
        --se valida si esta pendiente por generar suspensionde RP
        OPEN cuValidaOrdeSusp;
        FETCH cuValidaOrdeSusp
          INTO sbdatos;
        CLOSE cuValidaOrdeSusp;

        IF sbdatos IS NOT NULL THEN
          nuOk      := 1;
          sbObserva := 'PRODUCTO TIENE RECONEXION DUMMY ATENDIDA Y ESTA PENDIENTE POR GENERAR ORDEN DE SUSPENSION RP';
        ELSE
          --Se valida estado del producto
          OPEN cuGetEstaCorte;
          FETCH cuGetEstaCorte
            INTO nuestacorte, sbEstaFina, nuEstaProd;
          CLOSE cuGetEstaCorte;

          IF sbEstaFina = 'C' and nuestacorte <> nuEstaCortSuspTo THEN
            nuOk      := -1;
            sbObserva := 'PRODUCTO SE ENCUENTRA CASTIGADO CON ESTADO DE CORTE DIFERENTE DE [5 ?? SUSPENSION TOTAL]';
          ELSIF nuEstaProd <> 2 THEN
            nuOk      := -1;
            sbObserva := 'PRODUCTO NO SE ENCUENTRA SUSPENDIDO, ESTADO PRODUCTO ACTUAL [' ||
                         nuEstaProd || ']';
          ELSE
            --se valida estado de corte
            SELECT COUNT(1)
              INTO nuExiste
              FROM (SELECT to_number(regexp_substr(sbEstaCort,
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS estacort
                      FROM dual
                    CONNECT BY regexp_substr(sbEstaCort, '[^,]+', 1, LEVEL) IS NOT NULL)
             WHERE estacort = nuestacorte;

            IF nuExiste = 0 THEN
              nuOk      := -1;
              sbObserva := 'PRODUCTO NO TIENE UN ESTADO DE CORTE VALIDO PARA EL PROCESO, ESTADO DE CORTE ACTUAL [' ||
                           nuestacorte || ']';
            ELSE
              --se valida tipo de suspension de cartera
              SELECT COUNT(1)
                INTO nuExiste
                FROM pr_prod_suspension ps
               WHERE ps.product_id = inuProducto
                 AND ps.suspension_type_id = nuTipoSuspCart
                 AND ps.active = 'Y';

              IF nuExiste = 0 THEN
                nuOk      := -1;
                sbObserva := 'PRODUCTO NO SE ENCUENTRA SUSPENDIDO POR CARTERA';
              ELSE
                --se carga inclusion
                OPEN cugetInclusion;
                FETCH cugetInclusion
                  INTO dtFechaIncl;
                CLOSE cugetInclusion;

                IF dtFechaIncl IS NOT NULL THEN
                  nuOk      := -1;
                  sbObserva := 'PRODUCTO TIENE INCLUSION CON FECHA DE REGISTRO [' ||
                               dtFechaIncl || ']';
                ELSE
                  sbdatos := NULL;
                  --SE valdia orden de persecucion
                  open vcursor FOR 'SELECT  /*+ index (o PK_OR_ORDER)
                                          index (oa IDX_OR_ORDER_ACTIVITY_010)
                                    */''X''
                               FROM or_order o, or_order_activity oa
                               WHERE o.ordeR_id = oa.order_id
                                 AND oa.product_id = ' || inuProducto || '
                                 AND o.task_type_id IN (' || sbTitrPers || ')
                                 AND o.order_status_id in (' || sbEstaOrpe || ')';
                  fetch vcursor
                    into sbdatos;
                  close vcursor;
                  
                  IF sbdatos IS NOT NULL THEN
                    nuOk      := -1;
                    sbObserva := 'PRODUCTO TIENE ORDENES DE LOS TIPOS DE TRABAJOS DE PERSECUCION [' ||
                                 sbTitrPers || '],  EN LOS ESTADOS [' ||
                                 sbEstaOrpe || ']';
                  ELSE
                    --valida si estado de corte es 6 - orden de reconexion
                    SELECT COUNT(1)
                      INTO nuExiste
                      FROM (SELECT to_number(regexp_substr(sbEstaCore,
                                                           '[^,]+',
                                                           1,
                                                           LEVEL)) AS estacort
                              FROM dual
                            CONNECT BY regexp_substr(sbEstaCore,
                                                     '[^,]+',
                                                     1,
                                                     LEVEL) IS NOT NULL)
                     WHERE estacort = nuestacorte;

                    nuEstaCorRec := nuExiste;

                    IF nuExiste > 0 THEN
                      --SE valdia orden de reconexion
                      open vcursor FOR 'SELECT  /*+ index (o PK_OR_ORDER)
                                            index (oa IDX_OR_ORDER_ACTIVITY_010)
                                            index (s PK_MO_PACKAGES)
                                            */''X''
                                      FROM or_order o, or_order_activity oa, mo_packages s
                                      WHERE o.ordeR_id = oa.order_id
                                        AND oa.package_id = s.package_id
                                        AND oa.product_id = ' || inuProducto || '
                                        AND s.package_type_id IN (' || sbTramReco || ' )
                                        AND (o.order_status_id in (' || sbEstaOrre || ')
                                              or ( o.order_status_id = ' || nuEstaCerrOt || '
                                                 and DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(o.causal_id,null) = ' || nuClasCausExi || '
                                                 ) )
                                        AND s.MOTIVE_STATUS_ID = ' || nuEstaReso;
                      fetch vcursor
                        into sbdatos;
                      IF vcursor%FOUND THEN
                        nuOk      := -1;
                        sbObserva := 'PRODUCTO TIENE ORDENES DE RECONEXION DE CARTERA PENDIENTES O LEGALIZADAS CON EXITO Y SU SOLICITUD ABIERTA';
                      end if;
                      close vcursor;
                      /*OPEN cuValidaOrReco;
                      FETCH cuValidaOrReco INTO sbdatos;
                      IF cuValidaOrReco%FOUND THEN
                       nuOk := -1;
                       sbObserva := 'PRODUCTO TIENE ORDENES DE RECONEXION DE CARTERA PENDIENTES O LEGALIZADAS CON EXITO Y SU SOLICITUD ABIERTA';
                      END IF;
                      CLOSE cuValidaOrReco;*/

                    END IF;
                  END IF;
                END IF;
              END IF;
            END IF;
          END IF;
        END IF;
      END IF;
    END IF;

    --se genera log del proceso
    proRegistraLogValida(inuProducto, nuestacorte, sbObserva);
    
    ut_trace.trace('Termina ' || csbSP_NAME|| 'PRINDEPRODSUCA' , cnuNVLTRC);    

  EXCEPTION
    WHEN pkg_Error.controlled_error then
      nuOk := -1;
      RAISE pkg_Error.controlled_error;
    when others then
      nuOk := -1;
      pkg_error.setError;
      RAISE pkg_Error.controlled_error;
  END PRINDEPRODSUCA;

  PROCEDURE PRGENREGSUPCONE(inuSolicitud IN NUMBER) IS
    /**************************************************************************
      Proceso     : PRGENREGSUPCONE
      Autor       : Horbath
      Fecha       : 2020-01-22
      Ticket      : 176
      Descripcion : registra valor en suspcone

      Parametros Entrada
      inuSolicitud    Codigo de solicitud


      Parametros de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    nuProductID   mo_motive.product_id%type;
    rcServsusc    servsusc%rowtype;
    nuAddressId   pr_product.address_id%type;
    inuDepa       ge_geogra_location.geograp_location_id%type;
    inuLocaId     ge_geogra_location.geograp_location_id%type;
    nuOrder       or_order.order_id%type;
    nuBeforeState hicaesco.hcececan%type;

    ---Cursor para obtener el estado de corte anterior asociado al producto
    cursor cuBeforeStatus is
      select HCECECAN
        from hicaesco
       where hcecnuse = nuProductID
         and hcecfech = (select max(hcecfech)
                           from hicaesco
                          where hcecnuse = nuProductID);

    --se obtiene orden de reconexion
    cursor cugetOrden is
      select o.order_id,
             oa.product_id,
             oa.ORDER_ACTIVITY_ID,
             o.EXECUTION_FINAL_DATE
        from OR_ORDER_ACTIVITY oa, or_order o
       WHERE package_id = inuSolicitud
         and o.order_id = oa.order_id;

    --Se obtiene informacion del producto
    CURSOR cugetInfoProd IS
      select * from servsusc where servsusc.sesunuse = nuProductID;

    RCSUSPCONE   SUSPCONE%ROWTYPE;
    nuOrderActi  NUMBER;
    dtFechasOrde DATE;

  begin
  
    ut_trace.trace('Inicia ' || csbSP_NAME|| 'PRGENREGSUPCONE' , cnuNVLTRC);  

    --Obtener orden de reconexion
    open cugetOrden;
    fetch cugetOrden
      into nuOrder, nuProductID, nuOrderActi, dtFechasOrde;
    close cugetOrden;

    --Obtener direccion del producto
    nuAddressId := dapr_product.fnugetaddress_id(nuProductID, null);
    --Obtener localidad
    inuLocaId := daab_address.fnugetGEOGRAP_LOCATION_ID(nuAddressId, null);
    --Obtener Departamento
    inuDepa := dage_geogra_location.fnugetgeo_loca_father_id(inuLocaId,
                                                             null);

    --obtener registro del producto
    OPEN cugetInfoProd;
    FETCH cugetInfoProd
      INTO rcServsusc;
    CLOSE cugetInfoProd;
    --Obtener estado anterior
    nuBeforeState := NULL;

    OPEN cuBeforeStatus;
    FETCH cuBeforeStatus
      INTO nuBeforeState;
    CLOSE cuBeforeStatus;

    ut_trace.trace('Ejecucion proceso Insercuin nuBeforeState => ' ||
                   nuBeforeState,
                   10);

    RCSUSPCONE.SUCOIDSC     := SQIDSUSPCONE.NEXTVAL();
    RCSUSPCONE.SUCODEPA     := inuDepa;
    RCSUSPCONE.SUCOLOCA     := inuLocaId;
    RCSUSPCONE.SUCONUOR     := nuOrder;
    RCSUSPCONE.SUCOSUSC     := rcServsusc.SESUSUSC;
    RCSUSPCONE.SUCOSERV     := rcServsusc.SESUSERV;
    RCSUSPCONE.SUCONUSE     := rcServsusc.SESUNUSE;
    RCSUSPCONE.SUCOTIPO     := 'C';
    RCSUSPCONE.SUCOFEOR     := dtFechasOrde; --SYSDATE;
    RCSUSPCONE.SUCOCACD     := 2;
    RCSUSPCONE.SUCOOBSE     := 'Reconexion por Cambio de Tipo de Suspension a RP';
    RCSUSPCONE.SUCOCOEC     := nuBeforeState;
    RCSUSPCONE.SUCOCICL     := rcServsusc.sesucicl;
    RCSUSPCONE.SUCOORIM     := PKCONSTANTE.NO;
    RCSUSPCONE.SUCOPROG     := 'RECODUMMY';
    RCSUSPCONE.SUCOTERM     := PKGENERALSERVICES.FSBGETTERMINAL;
    RCSUSPCONE.SUCOUSUA     := PKGENERALSERVICES.FSBGETUSERNAME;
    RCSUSPCONE.SUCOFEAT     := null;
    RCSUSPCONE.SUCOCUPO     := null;
    RCSUSPCONE.SUCOACTIV_ID := nuOrderActi; --null;
    RCSUSPCONE.SUCOORDTYPE  := 3;

    IF (PKACCREIVADVANCEMGR.GNUACTIVITYCONS IS NOT NULL) THEN
      RCSUSPCONE.SUCOACGC := PKACCREIVADVANCEMGR.GNUACTIVITYCONS;
    END IF;

    PKTBLSUSPCONE.INSRECORD(RCSUSPCONE);
    
    ut_trace.trace('Termina ' || csbSP_NAME|| 'PRGENREGSUPCONE' , cnuNVLTRC);     

  EXCEPTION
    WHEN pkg_Error.controlled_error then
      RAISE pkg_Error.controlled_error;
    when others then
      pkg_error.setError;
      RAISE pkg_Error.controlled_error;
  END PRGENREGSUPCONE;

  PROCEDURE PRDELPRODMARE IS
    /**************************************************************************
     Proceso     : PRDELPRODMARE
     Autor       : Horbath
     Fecha       : 2020-01-22
     Ticket      : 176
     Descripcion : elimina resgitro de la tabla LDC_PRODRERP

     Parametros Entrada
     inuSolicitud    Codigo de solicitud


     Parametros de salida

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    nuorden      number; --se almacena codigo de la orden
    nuClasCausal NUMBER; --se almacena clase de causal
    nuProducto   NUMBER; --se almacena producto

    nuClasCausExi NUMBER := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CLCAEXIT'); --se almacena causal de clase exito

    --Se obtiene producto
    CURSOR cuProducto IS
      SELECT product_id
        FROM or_order_activity oa
       WHERE oa.order_id = nuorden;

  BEGIN
  
  
    ut_trace.trace('Inicia ' || csbSP_NAME|| 'PRDELPRODMARE' , cnuNVLTRC);   

    nuorden      := or_bolegalizeorder.fnuGetCurrentOrder;
    nuClasCausal := DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(DAOR_ORDER.FNUGETCAUSAL_ID(nuorden,
                                                                                 NULL));

    IF nuClasCausal = nuClasCausExi THEN
      OPEN cuProducto;
      FETCH cuProducto
        INTO nuProducto;
      CLOSE cuProducto;

      DELETE FROM LDC_PRODRERP WHERE PRREPROD = nuProducto;
    END IF;
    
    ut_trace.trace('Termina ' || csbSP_NAME|| 'PRDELPRODMARE' , cnuNVLTRC);
        
  EXCEPTION
    WHEN pkg_Error.controlled_error then
      RAISE pkg_Error.controlled_error;
    when others then
      pkg_error.setError;
      RAISE pkg_Error.controlled_error;
  END PRDELPRODMARE;
  PROCEDURE PRGENRECORP(inuProducto  IN NUMBER,
                        nuEstaCorRec IN NUMBER,
                        onuError     OUT NUMBER,
                        osberror     OUT VARCHAR2,
                        onuSolicitud OUT MO_PACKAGES.PACKAGE_ID%TYPE) IS
    /**************************************************************************
       Proceso     : PRGENRECORP
       Autor       : Horbath
       Fecha       : 2020-01-22
       Ticket      : 176
       Descripcion : genera tramite de Cambio Tipo Suspension a RP

       Parametros Entrada
        inuProducto    Codigo de producto
        inuestaCort    estado de corte del producto

       Parametros de salida
        onuError  codigo de error, 0 si no hay error
        osberror   mensaje de error

       HISTORIA DE MODIFICACIONES
       FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    nuCausaLeg  NUMBER := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CAUSLEFARE'); --se almacena causal de legalizacion
    nuUnidOper  NUMBER := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_UNOPRECA'); --se almacena unidad operativa
    sbComenLega VARCHAR2(4000) := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_COMLEORRE'); --se almacena comentario de legalIzacion
    sbTramiReco VARCHAR2(100) := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_TRAMRECOCA'); --se almacena tramite de reconexion
    sbEstaOrrec VARCHAR2(100) := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_ESTAORRECA'); --se almacena estado de ordenes de reconexion
    NuPersoLega NUMBER := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_PERSLERECA'); --se almacena persona que legaliza

    nuOrdenReco    NUMBER; --se almacena orden de reconexion
    RCORDER        DAOR_ORDER.STYOR_ORDER; -- se almacena registro de la orden de trabajo
    RCORDERNULL    DAOR_ORDER.STYOR_ORDER; -- se almacena registro de la orden de trabajo
    nuTipoCome     NUMBER := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_COTIPOCOD'); --Se almacena tipo de comentario
    nuTipoSuspCart NUMBER := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_TIPOSUSCA'); --se almacena tipo de suspension de cartera
    nuMediRece     NUMBER := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_COMEDRECE'); --se almacena medio de recepcion

    nuOrderactivity NUMBER;

    TYPE typRefCursor IS REF CURSOR;
    vcursor typRefCursor;

    --se obtiene unidad operativa
    CURSOR cugetUnidadOpera IS
      SELECT or_order_stat_change.final_oper_unit_id unidad_trabajo
        FROM or_order_stat_change
       WHERE or_order_stat_change.order_id = nuOrdenReco
         AND or_order_stat_change.final_status_id =
             OR_BOCONSTANTS.CNUORDER_STAT_ASSIGNED
         AND or_order_stat_change.final_oper_unit_id is not null;

    --se consulta orden de reconexion registrada o bloqueada
    CURSOR cugetOrdenReco IS
      SELECT O.order_id, oa.ORDER_ACTIVITY_ID
        FROM or_order o, or_order_activity oa, mo_packages p
       WHERE o.order_id = oa.order_id
         AND oa.package_id = p.package_id
         AND oa.product_id = inuProducto
         AND p.package_type_id in (300) --sbTramiReco
         AND o.order_status_id IN (0, 11) --sbEstaOrrec
      ;

    --se consulta estado de orden de reconexion
    CURSOR cugetestadoOrd IS
      SELECT order_status_id
        FROM or_order o
       WHERE o.order_id = nuOrdenReco;

    --se consulta informacion del producto
    CURSOR cuGetInfoProducto IS
      SELECT p.SUSPEN_ORD_ACT_ID, p.address_id, s.suscclie
        FROM pr_product p, suscripc s
       WHERE p.SUBSCRIPTION_ID = s.susccodi
         AND p.product_id = inuProducto;

    nuUltActividadSusp NUMBER;
    nuDireccion        NUMBER;
    nuCliente          NUMBER;

    nuEstaFinOrd NUMBER; --se almacena estado despues del desbloqueo
    nuunidadFin  NUMBER; --se alamacena ultima unidad operativa
    sbAsigfall   VARCHAR2(1) := 'N'; -- indica si se genero error al asignada
    sbFlagLeg    VARCHAR2(1) := 'N'; -- indica si se legaliza o no la orden
    sbCadenalega VARCHAR2(4000); --se almacena cadena de legalizacion

    sbrequestxml1 varchar2(4000); --se almacena xml para generar reconexion
    nupackageid   number; --se almacena solicitud generada
    numotiveid    number; --se almacena motivo

    --INICIO CA 498
    sbMotivoSuspVol VARCHAR2(400) := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_MOTISUSVOLU');
    sbMotivoSuspAdm VARCHAR2(400) := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_MOTISUSADMIN');
    nuTiposusp      NUMBER;

    CURSOR cuGetMarcaProducto IS
      SELECT decode(MOTIVO, sbMotivoSuspVol, 5, sbMotivoSuspAdm, 11) tiposusp
        FROM LDC_PRODEXCLRP P, pr_prod_suspension s
       WHERE P.PRODUCT_ID = inuProducto
         AND MOTIVO IN (sbMotivoSuspVol, sbMotivoSuspAdm)
         and p.product_id = s.product_id
         and s.active = 'Y'
         and s.suspension_type_id =
             decode(MOTIVO, sbMotivoSuspVol, 5, sbMotivoSuspAdm, 11);
    --FIN CA 498

  BEGIN
  
    ut_trace.trace('Inicia ' || csbSP_NAME|| 'PRGENRECORP' , cnuNVLTRC);  

    IF nuEstaCorRec > 0 THEN
      nuOrdenReco     := NULL;
      RCORDER         := RCORDERNULL;
      nuOrderactivity := NULL;
      --se consulta orden de reconexion
      open vcursor FOR 'SELECT O.order_id, oa.ORDER_ACTIVITY_ID
                            FROM or_order o, or_order_activity oa, mo_packages p
                            WHERE o.order_id = oa.order_id
                             AND oa.package_id = p.package_id
                             AND oa.product_id = ' || inuProducto || '
                             AND p.package_type_id in (' || sbTramiReco || ' )
                             AND o.order_status_id IN (' || sbEstaOrrec || ')';
      fetch vcursor
        into nuOrdenReco, nuOrderactivity;
      IF vcursor%FOUND THEN
        RCORDER := DAOR_ORDER.FRCGETRECORD(nuOrdenReco);
        --se valida si la orden esta bloqueada
        IF RCORDER.ORDER_STATUS_ID = Or_BOConstants.CNUORDER_STAT_LOCK THEN
          RCORDER.ARRANGED_HOUR := NULL;
          --se desasigna orden de trabajo
          IF RCORDER.OPERATING_UNIT_ID IS NOT NULL THEN
            OR_BOPROCESSORDER.UNASSIGNORDER(RCORDER,
                                            nuTipoCome,
                                            NULL,
                                            NULL,
                                            SYSDATE);
          ELSE
            --  se hace llamado al proceso que desbloquea la orden
            OR_BOFWLOCKORDER.UNLOCKORDER(nuOrdenReco,
                                         nuTipoCome,
                                         'Desbloqueo de orden por JOB de Suspension');
          END IF;
          nuunidadFin  := NULL;
          nuEstaFinOrd := NULL;

          --se consulta estado de l aorden despues de desbloquear
          OPEN cugetestadoOrd;
          FETCH cugetestadoOrd
            INTO nuEstaFinOrd;
          CLOSE cugetestadoOrd;

          IF nuEstaFinOrd = Or_BOConstants.CNUORDER_STAT_REGISTERED THEN
            OPEN cugetUnidadOpera;
            FETCH cugetUnidadOpera
              INTO nuunidadFin;
            CLOSE cugetUnidadOpera;
          END IF;
        END IF;
        --si la orden esta regsitrada se asigna
        IF nuEstaFinOrd = Or_BOConstants.CNUORDER_STAT_REGISTERED OR
           RCORDER.ORDER_STATUS_ID =
           Or_BOConstants.CNUORDER_STAT_REGISTERED THEN
          IF nuunidadFin IS NOT NULL THEN
            API_ASSIGN_ORDER(nuOrdenReco,
                            nuunidadFin,
                            onuError,
                            osberror);
            IF onuError <> 0 THEN
              sbAsigfall := 'S';
              onuError   := null;
              osberror   := null;
            ELSE
              onuError  := null;
              osberror  := null;
              sbFlagLeg := 'S';
            END IF;
          END IF;
          --si se genero error al asignar o la orden estaba regitrada
          IF nuunidadFin IS NULL OR sbAsigfall = 'S' THEN
            API_ASSIGN_ORDER(nuOrdenReco,
                            nuUnidOper,
                            onuError,
                            osberror);

            IF onuError = 0 THEN
              onuError  := null;
              osberror  := null;
              sbFlagLeg := 'S';
            ELSE
              proRegistraLogLegOrdRecoSusp('PRGENRECORP-ASIGNACION',
                                           SYSDATE,
                                           nuOrdenReco,
                                           null,
                                           osberror,
                                           USER);
            END IF;
          END IF;

          IF sbFlagLeg = 'S' THEN
            dbms_lock.sleep(1);
            sbCadenalega := nuOrdenReco || '|' || nuCausaLeg || '|' ||
                            NuPersoLega || '||' || nuOrderactivity || '>' || 0 ||
                            ';;;;|' ||
                            '||1277;Orden Legalizada por proceso de cambio de suspension a RP. ' ||
                            sbComenLega;
            -- se procede a legalizar la orden de trabajo
            api_legalizeorders(sbCadenalega,
                              SYSDATE,
                              SYSDATE,
                              null,
                              onuError,
                              osberror);

            IF onuError <> 0 THEN
              proRegistraLogLegOrdRecoSusp('PRGENRECORP-LEGALIZACION',
                                           SYSDATE,
                                           nuOrdenReco,
                                           null,
                                           osberror,
                                           USER);
            END IF;
          END IF;
        END IF;

      END IF;
      CLOSE vcursor;

    END IF;
    --se procede a registrar tramites por xml
    IF NVL(onuError, 0) = 0 THEN
      nuUltActividadSusp := null;
      nuDireccion        := null;
      nucliente          := null;
      --se consulta informacion del producto
      OPEN cuGetInfoProducto;
      FETCH cuGetInfoProducto
        INTO nuUltActividadSusp, nuDireccion, nucliente;
      CLOSE cuGetInfoProducto;

      OPEN cuGetMarcaProducto;
      FETCH cuGetMarcaProducto
          INTO nuTiposusp;
      CLOSE cuGetMarcaProducto;
      IF nuTiposusp IS NOT NULL THEN
          nuTipoSuspCart := nuTiposusp;
      END IF;

      sbrequestxml1 := '<?xml version="1.0" encoding="ISO-8859-1"?>
                           <P_CAMBIO_TIPO_SUSPENSION_A_RP_100312 ID_TIPOPAQUETE="100312">
                            <FECHA_DE_SOLICITUD>' ||
                       SYSDATE ||
                       '</FECHA_DE_SOLICITUD>
                            <RECEPTION_TYPE_ID>' ||
                       nuMediRece ||
                       '</RECEPTION_TYPE_ID>
                            <CONTACT_ID>' ||
                       nucliente ||
                       '</CONTACT_ID>
                            <ADDRESS_ID>' ||
                       nuDireccion || '</ADDRESS_ID>
                            <COMMENT_>RECONEXION POR CAMBIO DE SUSPENSION DE CARTERA A RP</COMMENT_>
                            <PRODUCT>' || inuProducto ||
                       '</PRODUCT>
                            <TIPO_DE_SUSPENSION>' ||
                       nuTipoSuspCart ||
                       '</TIPO_DE_SUSPENSION>
                           </P_CAMBIO_TIPO_SUSPENSION_A_RP_100312>';

      ut_trace.trace('Genera XML[' || sbrequestxml1 || ']', 10);
      -- Procesamos el XML y generamos la solicitud
      API_REGISTERREQUESTBYXML(sbrequestxml1,
                                nupackageid,
                                numotiveid,
                                onuError,
                                osberror);

      IF onuError = 0 THEN
        UPDATE LDC_PRODRERP
           SET PRREPROC = 'S',
               PRREFEPR = SYSDATE,
               PRREACTI = nuUltActividadSusp
         WHERE PRREPROD = inuProducto
           and PRREPROC = 'N';
        onuSolicitud := nupackageid;
        insert into ldc_ordeasigproc
          (orapsoge, oraoproc)
        values
          (nupackageid, 'CAMBTISU');

      ELSE
        proRegistraLogLegOrdRecoSusp('PRGENRECORP-TRAMITERECO',
                                     SYSDATE,
                                     NVL(nuOrdenReco, inuProducto),
                                     null,
                                     osberror,
                                     USER);

      END IF;
    END IF;

    ut_trace.trace('Termina ' || csbSP_NAME|| 'PRGENRECORP' , cnuNVLTRC);  
    
  EXCEPTION
    WHEN pkg_Error.controlled_error THEN
      pkg_error.getError(Onuerror, OSBERROR);
      proRegistraLogLegOrdRecoSusp('PRGENRECORP-TRAMITERECO',
                                   SYSDATE,
                                   NVL(nuOrdenReco, inuProducto),
                                   null,
                                   osberror,
                                   USER);
    WHEN OTHERS THEN
      pkg_error.setError;
      pkg_error.getError(Onuerror, OSBERROR);
      proRegistraLogLegOrdRecoSusp('PRGENRECORP-TRAMITERECO',
                                   SYSDATE,
                                   NVL(nuOrdenReco, inuProducto),
                                   null,
                                   osberror,
                                   USER);

  END PRGENRECORP;

  PROCEDURE PRLEGAORDRECVOL(inuProducto IN NUMBER,
                            onuError    OUT NUMBER,
                            osberror    OUT VARCHAR2) IS
    /**************************************************************************
       Proceso     : PRGENRECORP
       Autor       : Olsoftware
       Fecha       : 2021-03-24
       Ticket      : 498
       Descripcion : legaliza ordenes de reconexion voluntaria o administrativa

       Parametros Entrada
        inuProducto    Codigo de producto

       Parametros de salida
        onuError  codigo de error, 0 si no hay error
        osberror   mensaje de error

       HISTORIA DE MODIFICACIONES
       FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    nuUnidOper  ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_UNOPRECA'); --se almacena codigo de la unidad operativa
    nuCausaLeg  ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CAUSLEFARE'); --se almacena codigo de causal de legalizacion
    NuPersoLega ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_PERSLERECA'); --se almacena codigo de persona que legaliza

    sbComenLega VARCHAR2(4000) := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_COMLEORRE'); --se almacena comentario de legalIzacion
    sbEstaOrrec VARCHAR2(100) := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_ESTAORRECA'); --se almacena estado de ordenes de reconexion

    nuOrdenReco NUMBER; --se almacena orden de reconexion
    RCORDER     DAOR_ORDER.STYOR_ORDER; -- se almacena registro de la orden de trabajo
    RCORDERNULL DAOR_ORDER.STYOR_ORDER; -- se almacena registro de la orden de trabajo
    nuTipoCome  NUMBER := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_COTIPOCOD'); --Se almacena tipo de comentario
    nuOrderactivity NUMBER;

    TYPE typRefCursor IS REF CURSOR;
    vcursor typRefCursor;

    --se obtiene unidad operativa
    CURSOR cugetUnidadOpera IS
      SELECT or_order_stat_change.final_oper_unit_id unidad_trabajo
        FROM or_order_stat_change
       WHERE or_order_stat_change.order_id = nuOrdenReco
         AND or_order_stat_change.final_status_id =
             OR_BOCONSTANTS.CNUORDER_STAT_ASSIGNED
         AND or_order_stat_change.final_oper_unit_id is not null;

    --se consulta estado de orden de reconexion
    CURSOR cugetestadoOrd IS
      SELECT order_status_id
        FROM or_order o
       WHERE o.order_id = nuOrdenReco;

    --se consulta informacion del producto
    CURSOR cuGetInfoProducto IS
      SELECT p.SUSPEN_ORD_ACT_ID, p.address_id, s.suscclie
        FROM pr_product p, suscripc s
       WHERE p.SUBSCRIPTION_ID = s.susccodi
         AND p.product_id = inuProducto;

    nuEstaFinOrd NUMBER; --se almacena estado despues del desbloqueo
    nuunidadFin  NUMBER; --se alamacena ultima unidad operativa
    sbAsigfall   VARCHAR2(1) := 'N'; -- indica si se genero error al asignada
    sbFlagLeg    VARCHAR2(1) := 'N'; -- indica si se legaliza o no la orden
    sbCadenalega VARCHAR2(4000); --se almacena cadena de legalizacion

  BEGIN

    ut_trace.trace('Inicia ' || csbSP_NAME|| 'PRLEGAORDRECVOL' , cnuNVLTRC);  
    
    nuOrdenReco     := NULL;
    OnuError        := 0;
    RCORDER         := RCORDERNULL;
    nuOrderactivity := NULL;
    --se consulta orden de reconexion
    open vcursor FOR 'SELECT O.order_id, oa.ORDER_ACTIVITY_ID
                          FROM or_order o, or_order_activity oa, mo_packages p
                          WHERE o.order_id = oa.order_id
                           AND oa.package_id = p.package_id
                           AND oa.product_id = ' || inuProducto || '
                           AND p.package_type_id in (100210, 100346 )
                           AND o.order_status_id IN (' || sbEstaOrrec || ')';
    fetch vcursor
      into nuOrdenReco, nuOrderactivity;
    IF vcursor%FOUND THEN
      RCORDER := DAOR_ORDER.FRCGETRECORD(nuOrdenReco);
      --se valida si la orden esta bloqueada
      IF RCORDER.ORDER_STATUS_ID = Or_BOConstants.CNUORDER_STAT_LOCK THEN
        RCORDER.ARRANGED_HOUR := NULL;
        --se desasigna orden de trabajo
        IF RCORDER.OPERATING_UNIT_ID IS NOT NULL THEN
          OR_BOPROCESSORDER.UNASSIGNORDER(RCORDER,
                                          nuTipoCome,
                                          NULL,
                                          NULL,
                                          SYSDATE);
        ELSE
          --  se hace llamado al proceso que desbloquea la orden
          OR_BOFWLOCKORDER.UNLOCKORDER(nuOrdenReco,
                                       nuTipoCome,
                                       'Desbloqueo de orden por JOB de Suspension');
        END IF;
        nuunidadFin  := NULL;
        nuEstaFinOrd := NULL;

        --se consulta estado de l aorden despues de desbloquear
        OPEN cugetestadoOrd;
        FETCH cugetestadoOrd
          INTO nuEstaFinOrd;
        CLOSE cugetestadoOrd;

        IF nuEstaFinOrd = Or_BOConstants.CNUORDER_STAT_REGISTERED THEN
          OPEN cugetUnidadOpera;
          FETCH cugetUnidadOpera
            INTO nuunidadFin;
          CLOSE cugetUnidadOpera;
        END IF;
      END IF;
      --si la orden esta regsitrada se asigna
      IF nuEstaFinOrd = Or_BOConstants.CNUORDER_STAT_REGISTERED OR
         RCORDER.ORDER_STATUS_ID = Or_BOConstants.CNUORDER_STAT_REGISTERED THEN
        IF nuunidadFin IS NOT NULL THEN
          API_ASSIGN_ORDER(nuOrdenReco,
                          nuunidadFin,
                          onuError,
                          osberror);
          IF onuError <> 0 THEN
            sbAsigfall := 'S';
            onuError   := null;
            osberror   := null;
          ELSE
            onuError  := null;
            osberror  := null;
            sbFlagLeg := 'S';
          END IF;
        END IF;
        --si se genero error al asignar o la orden estaba regitrada
        IF nuunidadFin IS NULL OR sbAsigfall = 'S' THEN
          API_ASSIGN_ORDER(nuOrdenReco,
                          nuUnidOper,
                          onuError,
                          osberror);

          IF onuError = 0 THEN
            onuError  := null;
            osberror  := null;
            sbFlagLeg := 'S';
          ELSE
            proRegistraLogLegOrdRecoSusp('PRLEGAORDRECVOL-ASIGNACION',
                                         SYSDATE,
                                         nuOrdenReco,
                                         null,
                                         osberror,
                                         USER);
          END IF;
        END IF;

        IF sbFlagLeg = 'S' THEN
          dbms_lock.sleep(1);
          sbCadenalega := nuOrdenReco || '|' || nuCausaLeg || '|' ||
                          NuPersoLega || '||' || nuOrderactivity || '>' || 0 ||
                          ';;;;|' ||
                          '||1277;Orden Legalizada por proceso de cambio de suspension a RP. ' ||
                          sbComenLega;
          -- se procede a legalizar la orden de trabajo
          api_legalizeorders(sbCadenalega,
                            SYSDATE,
                            SYSDATE,
                            null,
                            onuError,
                            osberror);

          IF onuError <> 0 THEN
            proRegistraLogLegOrdRecoSusp('PRLEGAORDRECVOL-LEGALIZACION',
                                         SYSDATE,
                                         nuOrdenReco,
                                         null,
                                         osberror,
                                         USER);
          END IF;
        END IF;
      END IF;

    END IF;
    CLOSE vcursor;

    ut_trace.trace('Termina ' || csbSP_NAME|| 'PRLEGAORDRECVOL' , cnuNVLTRC);

  EXCEPTION
    WHEN pkg_Error.controlled_error THEN
      pkg_error.getError(Onuerror, OSBERROR);
      proRegistraLogLegOrdRecoSusp('PRLEGAORDRECVOL-TRAMITERECO',
                                   SYSDATE,
                                   NVL(nuOrdenReco, inuProducto),
                                   null,
                                   osberror,
                                   USER);
    WHEN OTHERS THEN
      pkg_error.setError;
      pkg_error.getError(Onuerror, OSBERROR);
      proRegistraLogLegOrdRecoSusp('PRLEGAORDRECVOL-TRAMITERECO',
                                   SYSDATE,
                                   NVL(nuOrdenReco, inuProducto),
                                   null,
                                   osberror,
                                   USER);

  END PRLEGAORDRECVOL;

  PROCEDURE prAsigLegOrdSusp(inuOrdenSusp     IN NUMBER,
                             InuOrderActivity IN NUMBER,
                             inuUnidOpeSus    IN NUMBER,
                             InuCausaLegSu    IN NUMBER,
                             InupersLegSus    IN NUMBER,
                             inuLectura       IN NUMBER,
                             IsbItem          IN VARCHAR2 DEFAULT NULL,
                             isbMedidor       IN VARCHAR2,
                             isbObservacion   IN VARCHAR2,
                             Onuerror         OUT NUMBER,
                             OSBERROR         OUT VARCHAR2) IS
    /**************************************************************************
       Proceso     : prAsigLegOrdSusp
       Autor       : Horbath
       Fecha       : 2020-01-22
       Ticket      : 176
       Descripcion : Asigna y legaliza orden de suspension

       Parametros Entrada
        inuOrdenSusp      orden de suspension
        InuOrderActivity  order activity
        inuUnidOpeSus     unidad operativa asignar
        InuCausaLegSu     causal de legalizacion
        InupersLegSus     persona que legaliza
        inuLectura        lectura
        IsbItem           item a legaliza
        isbMedidor        medidor
        isbObservacion    observacion

       Parametros de salida
        onuError  codigo de error, 0 si no hay error
        osberror   mensaje de error

       HISTORIA DE MODIFICACIONES
       FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    nuClasCausal NUMBER; --se almacena clase de causal
    sbCadenalega VARCHAR2(4000); --se almacena cadena de legalizacion
    -- se valida la clasificacion de la causal
    CURSOR cuTipoCausal IS
      SELECT DECODE(CLASS_CAUSAL_ID, 1, 1, 2, 0) tipo
        FROM ge_causal
       WHERE CAUSAL_ID = InuCausaLegSu;

  BEGIN
  
    ut_trace.trace('Inicia ' || csbSP_NAME|| 'prAsigLegOrdSusp' , cnuNVLTRC);
      
    --se asigan orden de suspension
    API_ASSIGN_ORDER(inuOrdenSusp,
                    inuUnidOpeSus,
                    onuerror,
                    oSBERROR);
    IF Onuerror = 0 THEN
      commit;
      nuClasCausal := NULL;
      sbCadenalega := NULL;
      onuerror     := NULL;
      oSBERROR     := NULL;
      --se valida clase de causal
      OPEN cuTipoCausal;
      FETCH cuTipoCausal
        INTO nuClasCausal;
      CLOSE cuTipoCausal;

      IF nuClasCausal > 0 THEN
        sbCadenalega := InuOrdenSusp || '|' || InuCausaLegSu || '|' ||
                        InupersLegSus || '||' || InuOrderActivity || '>' ||
                        nuClasCausal || ';READING>' || NVL(inuLectura, '') ||
                        '>9>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|' ||
                        NVL(IsbItem, '') || '|' || isbMedidor || ';1=' ||
                        NVL(inuLectura, '') || '=T===|' || '1277;' ||
                        isbObservacion;
      ELSE
        sbCadenalega := InuOrdenSusp || '|' || InuCausaLegSu || '|' ||
                        InupersLegSus || '||' || InuOrderActivity || '>' ||
                        nuClasCausal ||
                        ';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|' ||
                        NVL(isbItem, '') || '||1277;' || isbObservacion;
      END IF;
      --se legaliza orden de trabajo
      api_legalizeorders(sbCadenalega,
                        sysdate,
                        sysdate,
                        null,
                        Onuerror,
                        OSBERROR);
      dbms_lock.sleep(2);
    END IF;
    
    ut_trace.trace('Termina ' || csbSP_NAME|| 'prAsigLegOrdSusp' , cnuNVLTRC);    

  EXCEPTION
    WHEN pkg_Error.controlled_error THEN
      pkg_error.getError(Onuerror, OSBERROR);

    when others then
      pkg_error.setError;
      pkg_error.getError(Onuerror, OSBERROR);
  END prAsigLegOrdSusp;

  PROCEDURE PRJOBRECOYSUSPRP2 IS
    /**************************************************************************
     Proceso     : PRJOBRECOYSUSPRP
     Autor       : Horbath
     Fecha       : 2020-01-22
     Ticket      : 176
     Descripcion : job que asigna y legaliza ordenes de reconexion y suspension

     Parametros Entrada

     Parametros de salida

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    nuTramRerp    NUMBER := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CODTRAMRERP'); --se almacena codigo del tramite de reconexion Dummy
    nuUnidOper    NUMBER := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_UNIOPRECO'); --se almacena codigo de la unidad operativa
    nuCausalLega  NUMBER := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CAUSLERECO'); --se almacena codigo de causal de legalizacion
    nuPersonaLega NUMBER := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_PERSLERECO'); --se almacena codigo de persona que legaliza

    nuTramiSuspRp  NUMBER := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CODTRASUSRP'); --se almacena codigo de tramite de suspension Rp
    sbCadenalega   VARCHAR2(4000); --se almacena cadena de legalizacion

    nuerror        NUMBER; --se almacena codigo de error
    SBERROR        VARCHAR2(4000); --se almacena mensaje de error
    nuClasCausal   NUMBER; --se almacena clase de causal
    sbItemLegaReco VARCHAR2(4000); --se alamcena item de legalizacion
    Medidor        elmesesu.emsscoem%TYPE;

    nuOrdenReco NUMBER; --se almacena orde de reconexion
    NuProducto  NUMBER; --se almacena numero del producto

    nulectura      NUMBER; --se almacena lectura de suspension
    nuTipoSuspLega NUMBER; --se almacena tipo de suspension
    nuMediRece     NUMBER := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_COMEDRECE'); --se almacena medio de recepcion

    nuTipoSusp      NUMBER; --se almacena tipo de suspesion
    nuTipocausal    ldc_coactcasu.cacstica%type; --se almacena tipo de causal
    nuCausSusp      ldc_coactcasu.cacscasu%type; --se almacena causal de suspension
    nuUnidOpeSus    ldc_coactcasu.cacsunid%type; --se almacena unidad operativa
    nuCausaLegSu    ldc_coactcasu.cacscals%type; --se almacena causal de legalizacion
    nupersLegSus    ldc_coactcasu.cacspers%type; --se almacena persona que legaliza
    nuOrdenSusp     NUMBER; --se almacena orden de suspension
    nuOrderActivity NUMBER; --se almacena order activity de suspension
    nuSolicitud     NUMBER; --se almacena solicitud
    nuEstaCorRec    NUMBER; --se almacena si el producto ien estado de corte 6 -orden de suspension
    nuIsvalid       NUMBER; --se almacena si el producto esta suspendido por Cartera
    sbFlagElim      VARCHAR2(1) := 'N'; --flag para eliminar registro
    nuSolReco       mo_packages.package_id%type;

    --variabe para estaproc
    nuparano  NUMBER;
    nuparmes  NUMBER;
    nutsess   NUMBER;
    sbparuser VARCHAR2(400);
    --se consulta productos pendientes
    CURSOR cugetProdPendReco Is
      SELECT rowid idreg, PRREPROD FROM LDC_PRODRERP WHERE PRREPROC = 'N';

    --se obtiene orden de reconexion
    CURSOR cugetOrdeRecon IS
      SELECT o.order_id, OA.PRODUCT_ID, OA.ORDER_ACTIVITY_ID, OA.PACKAGE_ID
        FROM or_order_activity oa, or_order o, mo_packages s
       WHERE s.package_id = oa.package_id
         AND s.package_type_id = nuTramRerp
         AND oa.order_id = o.order_id
         AND o.order_status_id = Or_BOConstants.CNUORDER_STAT_REGISTERED
         and s.motive_Status_id = 13;

    --se obtiene orden de sspension con error
    CURSOR cugetOrdeSuspen IS
      SELECT o.order_id, OA.PRODUCT_ID, OA.ORDER_ACTIVITY_ID
        FROM or_order_activity oa, or_order o, mo_packages s
       WHERE s.package_id = oa.package_id
         AND s.package_type_id = nuTramiSuspRp
         AND oa.order_id = o.order_id
         AND o.order_status_id = Or_BOConstants.CNUORDER_STAT_REGISTERED
         AND s.COMMENT_ = 'CAMBIO DE SUSPENSION DE CARTERA A RP';

    --se obtienen productos con defectos
    CURSOR cuGetProducDefe IS
      SELECT DF.ID_PRODUCTO FROM LDC_DEFCRI_NOREPARABLE DF;

    --se obtiene productos reconectados a suspender
    CURSOR cuGenerarSuspen IS
      SELECT product_id FROM ldc_prodreasu WHERE estasusp = 'N';

    --Se obtiene lectura de suspencion
    CURSOR cugetlecturaSusp IS
      SELECT LE.LEEMLETO
        FROM LECTELME le, ldc_PRODRERP p
       WHERE LE.LEEMSESU = P.PRREPROD
         AND le.LEEMDOCU = p.PRREACTI
         AND p.PRREPROD = NuProducto
       order by le.leemfele desc;

    --se consulta medidor actual
    CURSOR cuMedidorAct IS
      SELECT emsscoem
        FROM elmesesu
       WHERE emsssesu = NuProducto
         AND sysdate between EMSSFEIN AND EMSSFERE;

    --se obtiene tipo de suspension
    CURSOR cugetTiposusp IS
      SELECT Suspension_Type_Id
        FROM Pr_Prod_Suspension PS
       WHERE PS.Product_Id = NuProducto
         AND Active = 'Y';

    -- se valida la clasificacion de la causal
    CURSOR cuTipoCausal(nuCausal ge_causal.CAUSAL_ID%TYPE) IS
      SELECT DECODE(CLASS_CAUSAL_ID, 1, 1, 2, 0) tipo
        FROM ge_causal
       WHERE CAUSAL_ID = nuCausal;

    --se obtiene configurcion de forma LDCCACASU
    CURSOR cugetConfiActSusp IS
      SELECT conf.cacstica,
             conf.cacscasu,
             conf.cacsunid,
             conf.cacscals,
             conf.cacspers
        FROM ldc_coactcasu conf, ldc_prodrerp p, or_order_activity oa
       WHERE oa.order_activity_id = p.prreacti
         AND conf.cacsacti = oa.activity_id
         AND p.prreprod = NuProducto;

    --se obtiene orden de suspension
    CURSOR cugetOrdeSusp IS
      SELECT oa.order_id, oa.order_activity_id
        FROM or_order_activity oa
       WHERE oa.package_id = nuSolicitud;

    PROCEDURE resetVariables IS

    BEGIN
      ut_trace.trace('Inicia ' || csbSP_NAME|| 'PRJOBRECOYSUSPRP2.resetVariables' , cnuNVLTRC);
        
      nuTipoSusp      := NULL;
      nuTipocausal    := NULL;
      nuCausSusp      := NULL;
      nuUnidOpeSus    := NULL;
      nuCausaLegSu    := NULL;
      nupersLegSus    := NULL;
      nulectura       := NULL;
      nuClasCausal    := NULL;
      Medidor         := NULL;
      nuSolicitud     := null;
      nuOrdenSusp     := null;
      nuOrderActivity := null;
      nuSolReco       := null;
      ut_trace.trace('Termina ' || csbSP_NAME|| 'PRJOBRECOYSUSPRP2.resetVariables' , cnuNVLTRC);
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END resetVariables;
  BEGIN

    ut_trace.trace('Inicia ' || csbSP_NAME|| 'PRJOBRECOYSUSPRP2' , cnuNVLTRC);
    
    -- Consultamos datos para inicializar el proceso
    SELECT to_number(to_char(SYSDATE, 'YYYY')),
           to_number(to_char(SYSDATE, 'MM')),
           userenv('SESSIONID'),
           USER
      INTO nuparano, nuparmes, nutsess, sbparuser
      FROM dual;
    -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,
                           nuparmes,
                           'PRJOBRECOYSUSPRP',
                           'En ejecucion',
                           nutsess,
                           sbparuser);
    -- se ejecuta proceso de generacion de reconexion
    FOR reg IN cugetProdPendReco LOOP
      nuError      := null;
      sberror      := null;
      nuEstaCorRec := null;
      nuIsvalid    := null;

      --se valida si el producto esta suspendido por cartera
      LDC_PKGESTIONCASURP.PRINDEPRODSUCA(reg.PRREPROD,
                                         nuEstaCorRec,
                                         2,
                                         nuIsvalid);

      IF nuIsvalid = 0 THEN
        --se genera orden de reconexion
        LDC_PKGESTIONCASURP.PRGENRECORP(reg.PRREPROD,
                                        nuEstaCorRec,
                                        nuError,
                                        sberror,
                                        nuSolReco);
        IF nuError = 0 THEN
          COMMIT;

        ELSE
          ROLLBACK;
        END IF;
      ELSE
        UPDATE LDC_PRODRERP
           SET PRREPROC = 'S',
               PRREOBSE = 'NO CUMPLE REQUISITO PARA GENERACION, VALIDAR LOG',
               PRREFEPR = SYSDATE
         WHERE rowid = reg.idreg;
        commit;

      END IF;
    END LOOP;

    FOR reg IN cuGetProducDefe LOOP
      nuEstaCorRec := NULL;
      nuIsvalid    := NULL;
      nuError      := null;
      sberror      := null;
      sbFlagElim   := 'N';
      --se valida si el producto esta suspendido por cartera
      LDC_PKGESTIONCASURP.PRINDEPRODSUCA(REG.ID_PRODUCTO,
                                         nuEstaCorRec,
                                         1,
                                         nuIsvalid);

      IF nuIsvalid = 0 THEN
        --se genera orden de reconexion
        PRGENRECORP(REG.ID_PRODUCTO,
                    nuEstaCorRec,
                    nuError,
                    sberror,
                    nuSolReco);
        IF nuError = 0 THEN
          sbFlagElim := 'S';
          COMMIT;
        ELSE
          ROLLBACK;
        END IF;
      END IF;

      IF sbFlagElim = 'S' THEN
        DELETE FROM LDC_DEFCRI_NOREPARABLE
         WHERE ID_PRODUCTO = REG.ID_PRODUCTO;
        COMMIT;
      END IF;

    END LOOP;

    --se obtienen ordenes de reconexion pendientes
    FOR reg IN cugetOrdeRecon LOOP
      resetVariables; --Se setean variables
      NuProducto  := reg.product_id;
      nuOrdenreco := reg.order_id;

      --se asigan orden de reconexion
      API_ASSIGN_ORDER(nuOrdenreco,
                      nuUnidOper,
                      nuerror,
                      SBERROR);

      IF nuerror <> 0 THEN
        proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPRP-ASIGRECO',
                                     SYSDATE,
                                     nuOrdenReco,
                                     null,
                                     sberror,
                                     USER);
        ROLLBACK;

      ELSE
        dbms_lock.sleep(1);
        nuerror := null;
        SBERROR := null;
        --se valida clase de causal
        OPEN cuTipoCausal(nuCausalLega);
        FETCH cuTipoCausal
          INTO nuClasCausal;
        CLOSE cuTipoCausal;

        --se obtiene lectura de suspension
        OPEN cugetlecturaSusp;
        FETCH cugetlecturaSusp
          INTO nulectura;
        CLOSE cugetlecturaSusp;

        --se obtiene medidor del producto
        OPEN cuMedidorAct;
        FETCH cuMedidorAct
          INTO medidor;
        CLOSE cuMedidorAct;

        IF nuClasCausal > 0 THEN
          --se obtiene el tipo de suspension
          OPEN cugetTiposusp;
          FETCH cugetTiposusp
            INTO nuTipoSuspLega;
          CLOSE cugetTiposusp;

          sbCadenalega := nuOrdenreco || '|' || nuCausalLega || '|' ||
                          nuPersonaLega || '||' || REG.ORDER_ACTIVITY_ID || '>' ||
                          nuClasCausal || ';READING>' || NVL(nuLectura, '') ||
                          '>9>;SUSPENSION_TYPE>' || NVL(nuTipoSuspLega, '') ||
                          '>>;;|' || NVL(sbItemLegaReco, '') || '|' ||
                          Medidor || ';1=' || NVL(nulectura, '') ||
                          '=T===|' ||
                          '1277;Orden Legalizada por proceso PRJOBRECOYSUSPRP';

        ELSE
          sbCadenalega := nuOrdenreco || '|' || nuCausalLega || '|' ||
                          nuPersonaLega || '||' || REG.ORDER_ACTIVITY_ID || '>' ||
                          nuClasCausal ||
                          ';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|' ||
                          NVL(sbItemLegaReco, '') ||
                          '||1277;Orden Legalizada por proceso PRJOBRECOYSUSPRP';
        END IF;
        --se legaliza orden de trabajo
        api_legalizeorders(sbCadenalega,
                          sysdate,
                          sysdate,
                          null,
                          nuerror,
                          SBERROR);

        IF nuerror <> 0 THEN
          proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPRP-LEGARECO',
                                       SYSDATE,
                                       nuOrdenReco,
                                       null,
                                       sberror,
                                       USER);
          ROLLBACK;
        ELSE
          dbms_lock.sleep(4);
          INSERT INTO LDC_PRODREASU
            (PRODUCT_ID, SOLIRECO, FECHRECO)
          VALUES
            (NuProducto, REG.PACKAGE_ID, SYSDATE);
          commit;

        END IF;
      END IF;

    END LOOP;

    --se realiza proceso de suspension
    FOR reg IN cuGenerarSuspen LOOP
      resetVariables; --Se setean variables
      NuProducto := reg.product_id;
      Ut_trace.trace('PRODUCTO A SUSPENDER '||NuProducto, cnuNVLTRC ) ;

      --se obtiene lectura de suspension
      OPEN cugetlecturaSusp;
      FETCH cugetlecturaSusp
        INTO nulectura;
      CLOSE cugetlecturaSusp;

      --se obtiene medidor del producto
      OPEN cuMedidorAct;
      FETCH cuMedidorAct
        INTO medidor;
      CLOSE cuMedidorAct;

      IF cugetConfiActSusp%ISOPEN THEN
        CLOSE cugetConfiActSusp;
      END IF;
      --se obtiene configuracion de actividad de suspension de cartera
      OPEN cugetConfiActSusp;
      FETCH cugetConfiActSusp
        INTO nuTipocausal,
             nuCausSusp,
             nuUnidOpeSus,
             nuCausaLegSu,
             nupersLegSus;
      IF cugetConfiActSusp%FOUND THEN
        nuTipoSusp := ldci_pkrevisionperiodicaweb.fnutiposuspension(NuProducto);
        --se crea orden de suspension
        nuSolicitud := fnuGeneTramSuspRP(NuProducto,
                                         nuMediRece,
                                         nuTipocausal,
                                         nuCausSusp,
                                         nuTipoSusp,
                                         'CAMBIO DE SUSPENSION DE CARTERA A RP',
                                         nuerror,
                                         SBERROR);
        IF nuerror <> 0 THEN
          proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPRP-TRAMSUSPRP',
                                       SYSDATE,
                                       nuOrdenReco,
                                       NULL,
                                       sberror,
                                       USER);
          ROLLBACK;
        ELSE
          UPDATE LDC_PRODREASU
             SET ESTASUSP = 'S'
           WHERE PRODUCT_ID = NuProducto;
          COMMIT;
          dbms_lock.sleep(4);
          --se obtiene orden de suspension
          OPEN cugetOrdeSusp;
          FETCH cugetOrdeSusp
            INTO nuOrdenSusp, nuOrderActivity;
          CLOSE cugetOrdeSusp;
          
        Ut_trace.trace('ORDEN DE SUSPENSION '||nuOrdenSusp, cnuNVLTRC ) ;          

          IF nuOrdenSusp IS NOT NULL THEN
            nuerror := null;
            SBERROR := null;
            --se asigna y legaliza orden de suspension
            prAsigLegOrdSusp(nuOrdenSusp,
                             nuOrderActivity,
                             nuUnidOpeSus,
                             nuCausaLegSu,
                             nupersLegSus,
                             nuLectura,
                             NULL,
                             Medidor,
                             'Orden Legalizada por proceso PRJOBRECOYSUSPRP',
                             nuerror,
                             SBERROR);

            IF nuerror <> 0 THEN
              proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPRP-ASIGLEGSUSP',
                                           SYSDATE,
                                           nuOrdenSusp,
                                           nuOrdenReco,
                                           sberror,
                                           USER);
              ROLLBACK;
            ELSE
              COMMIT;
            END IF;
          END IF;

        END IF;
      END IF;
      CLOSE cugetConfiActSusp;
    END LOOP;
    --se obtienen ordenes de suspension pendientes
    FOR reg IN cugetOrdeSuspen LOOP
      resetVariables; --Se setean variables
      NuProducto      := reg.product_id;
      nuOrdenSusp     := reg.order_id;
      nuOrderActivity := REG.ORDER_ACTIVITY_ID;

      --se obtiene lectura de suspension
      OPEN cugetlecturaSusp;
      FETCH cugetlecturaSusp
        INTO nulectura;
      CLOSE cugetlecturaSusp;

      --se obtiene medidor del producto
      OPEN cuMedidorAct;
      FETCH cuMedidorAct
        INTO medidor;
      CLOSE cuMedidorAct;

      IF cugetConfiActSusp%ISOPEN THEN
        CLOSE cugetConfiActSusp;
      END IF;

      --se obtiene configuracion de actividad de suspension de cartera
      OPEN cugetConfiActSusp;
      FETCH cugetConfiActSusp
        INTO nuTipocausal,
             nuCausSusp,
             nuUnidOpeSus,
             nuCausaLegSu,
             nupersLegSus;
      IF cugetConfiActSusp%FOUND THEN
        nuerror := null;
        SBERROR := null;
        --se asigna y legaliza orden de suspension
        prAsigLegOrdSusp(nuOrdenSusp,
                         nuOrderActivity,
                         nuUnidOpeSus,
                         nuCausaLegSu,
                         nupersLegSus,
                         nuLectura,
                         NULL,
                         Medidor,
                         'Orden Legalizada por proceso PRJOBRECOYSUSPRP',
                         nuerror,
                         SBERROR);

        IF nuerror <> 0 THEN
          proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPRP-ASIGLEGSUSP',
                                       SYSDATE,
                                       nuOrdenSusp,
                                       nuOrdenReco,
                                       sberror,
                                       USER);
          ROLLBACK;
        ELSE
          COMMIT;
        END IF;
      END IF;
      CLOSE cugetConfiActSusp;
    END LOOP;

    ldc_proactualizaestaprog(nutsess, SBERROR, 'PRJOBRECOYSUSPRP', 'Ok');

    ut_trace.trace('Termina ' || csbSP_NAME|| 'PRJOBRECOYSUSPRP2' , cnuNVLTRC);
    
  EXCEPTION
    WHEN pkg_Error.controlled_error THEN
      pkg_error.getError(nuerror, SBERROR);
      ldc_proactualizaestaprog(nutsess,
                               SBERROR,
                               'PRJOBRECOYSUSPRP',
                               'error');

    WHEN OTHERS THEN
      pkg_error.setError;
      pkg_error.getError(nuerror, SBERROR);
      ldc_proactualizaestaprog(nutsess,
                               SBERROR,
                               'PRJOBRECOYSUSPRP',
                               'error');
      rollback;
  END PRJOBRECOYSUSPRP2;

  FUNCTION fnuGeneTramSuspRP(inuProducto   IN NUMBER,
                             inuMedioRecep IN NUMBER,
                             InutipoCausal IN NUMBER,
                             InuCausal     IN NUMBER,
                             inuTipoSusp   IN NUMBER,
                             IsbComment    IN VARCHAR2,
                             onuError      OUT NUMBER,
                             osberror      OUT VARCHAR2) RETURN NUMBER IS
    /**************************************************************************
     Proceso     : fnuGeneTramSuspRP
     Autor       : Horbath
     Fecha       : 2020-01-22
     Ticket      : 176
     Descripcion : funcion que se encarga de crear tramite de suspension RP

     Parametros Entrada
       inuProducto    codigo del producto
       inuMedioRecep  medio de recepcion
       InutipoCausal  tipo de causal
       InuCausal      causal
       inuTipoSusp    tipo de suspension
       IsbComment     comentario de generacion

     Parametros de salida
      onuError codigo de error 0 si es correcto
       osberror mensaje de error
     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    dtfechasusp   DATE; --se almacena fecha de suspension
    sbrequestxml1 VARCHAR2(4000); --se almacena xml
    nucliente     NUMBER; --se almacena cliente
    nupackageid   NUMBER; --se almacena solicitud
    numotiveid    NUMBER; --se almacena motivo creado

    --se obtiene cliente del producto
    CURSOR cuGetCliente IS
      SELECT c.suscclie
        FROM pr_product p, suscripc c
       WHERE P.SUBSCRIPTION_ID = c.susccodi
         AND P.PRODUCT_ID = inuProducto;

  BEGIN
  
    ut_trace.trace('Inicia ' || csbSP_NAME|| 'fnuGeneTramSuspRP' , cnuNVLTRC);
      
    dtfechasusp := SYSDATE + 1 / 24 / 60;

    --se obtiene cliente
    OPEN cuGetCliente;
    FETCH cuGetCliente
      INTO nuCliente;
    CLOSE cuGetCliente;

    sbrequestxml1 := '<?xml version="1.0" encoding="ISO-8859-1"?>
                    <P_LBC_SUSPENSION_ADMINISTRATIVA_POR_XML_100156 ID_TIPOPAQUETE="100156">
                     <RECEPTION_TYPE_ID>' ||
                     inuMedioRecep || '</RECEPTION_TYPE_ID>
                     <CONTACT_ID>' || nucliente ||
                     '</CONTACT_ID>
                     <ADDRESS_ID></ADDRESS_ID>
                     <COMMENT_>' || IsbComment ||
                     '</COMMENT_>
                     <PRODUCT>' || inuProducto ||
                     '</PRODUCT>
                     <FECHA_DE_SUSPENSION>' ||
                     dtfechasusp ||
                     '</FECHA_DE_SUSPENSION>
                     <TIPO_DE_SUSPENSION>' ||
                     inuTipoSusp || '</TIPO_DE_SUSPENSION>
                     <TIPO_DE_CAUSAL>' || inuTipoCausal ||
                     '</TIPO_DE_CAUSAL>
                     <CAUSAL_ID>' || inuCausal ||
                     '</CAUSAL_ID>
                     </P_LBC_SUSPENSION_ADMINISTRATIVA_POR_XML_100156>';

    -- Se crea la solicitud y la orden de trabajo
    API_REGISTERREQUESTBYXML(sbrequestxml1,
                              nupackageid,
                              numotiveid,
                              onuError,
                              osberror);
                              
    ut_trace.trace('Termina ' || csbSP_NAME|| 'fnuGeneTramSuspRP' , cnuNVLTRC);
                                  
    RETURN nupackageid;
  EXCEPTION
    WHEN pkg_Error.controlled_error THEN
      pkg_error.getError(onuError, osberror);

    WHEN OTHERS THEN
      pkg_error.setError;
      pkg_error.getError(onuError, osberror);
      RETURN - 1;
  END fnuGeneTramSuspRP;

  PROCEDURE PRJOBRECOYSUSPRP(inuCantHilo NUMBER, inuHilo NUMBER,nupacodigo_producto NUMBER DEFAULT NULL) IS

    /**************************************************************************
     Proceso     : PRJOBRECOYSUSPRP
     Autor       : Horbath
     Fecha       : 2020-01-22
     Ticket      : 176
     Descripcion : job que asigna y legaliza ordenes de reconexion y suspension

     Parametros Entrada

     Parametros de salida

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
     16/03/2021   olsoftware    CA 498 se coloca filtro por el nuevo campo PRREFUEN este vacio
     04/10/2021   DANVAL        CA 717 Se inserta en la tabla LD_PRODAPPLYSUSPEND un registro posterior al proceso de asignación y legalización de la orden de suspensión
	   09/02/2022   JJJM          CA-923 Se agrega al procedimiento el parametro nmpacodigo_producto
                                       y se modifican los cursores, cugetProdPendReco,cuGetProducDefe y
                                       cugetOrdeRecon2 para agregandoles el parametro de entrada : nucu_nuse
                                       para que estos reciban el producto que viene del procedimiento,
                                       en caso de que este valor sea NULL, los cursores funcionarian como estaban,
                                       de lo contrario se filtra por el producto pasado por parametro.
                                       Tambien se valida que si el producto es diferente de NULL, este debe existir
                                       en la tabla pr_product de lo contrario no continua el proceso y se registra
                                       el error en la tabla ldc_osf_estaproc mediante el procedimiento : ldc_proactualizaestaprog.
                                                                               
    ***************************************************************************/
    --CA 717_1
    nuProductoValido number(5);
    --
    nuTramRerp      ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CODTRAMRERP'); --se almacena codigo del tramite de reconexion Dummy
    nuUnidOper      ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_UNIOPRECO'); --se almacena codigo de la unidad operativa
    nuCausalLega    ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CAUSLERECO'); --se almacena codigo de causal de legalizacion
    nuCausalLegFall ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CAUSDUMMYFALL'); --se almacena codigo de causal de legalizacion
    nuPersonaLega   ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_PERSLERECO'); --se almacena codigo de persona que legaliza

    nuTramiSuspRp  ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CODTRASUSRP'); --se almacena codigo de tramite de suspension Rp
    nuEstadoRegSol ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_ESTARESO'); --se almacena codigo regsitrado de la solicitud
    sbCadenalega   VARCHAR2(4000); --se almacena cadena de legalizacion
    sbCadenaFallo  VARCHAR2(4000); --se almacena cadena de legalizacion fallo

    nuerror        NUMBER; --se almacena codigo de error
    sbError        VARCHAR2(4000); --se almacena mensaje de error
    nuClasCausal   ge_causal.class_causal_id%type; --se almacena clase de causal
    sbItemLegaReco VARCHAR2(4000); --se alamcena item de legalizacion
    Medidor        elmesesu.emsscoem%TYPE;

    nuOrdenReco    NUMBER; --se almacena orde de reconexion
    NuProducto     pr_product.product_id%type; --se almacena numero del producto
    nuOrdenRecoDum or_order.order_id%type;

    nulectura      NUMBER; --se almacena lectura de suspension
    nuTipoSuspLega NUMBER; --se almacena tipo de suspension
    nuMediRece     ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_COMEDRECE'); --se almacena medio de recepcion

    nuTipoSusp      NUMBER; --se almacena tipo de suspesion
    nuTipocausal    ldc_coactcasu.cacstica%type; --se almacena tipo de causal
    nuCausSusp      ldc_coactcasu.cacscasu%type; --se almacena causal de suspension
    nuUnidOpeSus    ldc_coactcasu.cacsunid%type; --se almacena unidad operativa
    nuCausaLegSu    ldc_coactcasu.cacscals%type; --se almacena causal de legalizacion
    nupersLegSus    ldc_coactcasu.cacspers%type; --se almacena persona que legaliza
    nuOrdenSusp     or_order.order_id%type; --se almacena orden de suspension
    nuOrderActivity or_order_activity.order_activity_id%type; --se almacena order activity de suspension
    nuSolicitud     mo_packages.package_id%type; --se almacena solicitud
    nuEstaCorRec    estacort.escocodi%type; --se almacena si el producto ien estado de corte 6 -orden de suspension
    nuIsvalid       NUMBER; --se almacena si el producto esta suspendido por Cartera
    sbFlagElim      VARCHAR2(1) := 'N'; --flag para eliminar registro
    nuTiempoEspera  ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_ESPERA'); --tiempo a espaerar generacion de orden
    nuTiempoMaximo  ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_TIEMPO_MAX');
    nuTiempoTotal   number;
    nuUltActSusp    pr_product.suspen_ord_act_id%type;
    nuUltActSusMar  pr_product.suspen_ord_act_id%type;
    nuLectSuspAc    lectelme.leemleto%type;
    nuEstadoProd    pr_product.product_Status_id%type;
    sbErrorFlujo    varchar2(4000);
    nuEjecutores    number;
    nuMinEjecu      ld_parameter.numeric_value%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('NUM_EJECUTORES');
    nuTipoSuspCart  ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_TIPOSUSCA'); --se almacena tipo de suspension de cartera
    sbMail          ldc_pararepe.paravast%type := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_MAIL_CAMBIO_TIPOSUSP');
    nuMaxUsuario    ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_NUMERO_PROD_TIEMPO');
    sbCountUsuario  number;

    --variabe para estaproc
    nuparano  NUMBER;
    nuparmes  NUMBER;
    nutsess   NUMBER;
    sbparuser VARCHAR2(400);

    --variables para validar condiciones de facturacion y cartera
    sbPefaactu  varchar2(1);
    nuPerifact  perifact.pefacodi%type;
    nuPeriCons  pericose.pecscons%type;
    sbErrorFact varchar2(4000);
    sbErrorComp varchar2(4000);
    sbCompsus   varchar2(1);
    NOMBRE_BD   varchar2(100);
    nuSalir     number;
    nuSolReco   mo_packages.package_id%type;

  -- JJJM CA-923
  nmvaproduct_id pr_product.product_id%TYPE;
  nmconta        NUMBER(4);
    --se consulta productos pendientes
    CURSOR cugetProdPendReco(nucu_nuse NUMBER) Is
      select *
        from (SELECT LDC_PRODRERP.rowid idreg, PRREPROD, SESUCICL, SESUCICO
                FROM LDC_PRODRERP, SERVSUSC S
               WHERE PRREPROC = 'N'
                 AND SESUNUSE = PRREPROD
                 AND PRREFUEN IS NULL --CA 498 se coloca nuevo filtro
               order by sesucicl)
       where mod(PRREPROD, inuCantHilo) + 1 = inuHilo
         and PRREPROD = decode(nucu_nuse,-1,prreprod,nucu_nuse); -- JJJM CA-923  

    --se obtiene solicitud de reconexion del producto
    CURSOR cugetSoliRecon(nuProd     pr_product.product_id%type,
                          numSolReco mo_packages.package_id%type) IS
      SELECT s.PACKAGE_ID
        FROM mo_packages s, mo_motive m
       WHERE s.package_id = m.package_id
         AND s.package_type_id = nuTramRerp
         AND s.motive_Status_id = nuEstadoRegSol
         and m.product_id = nuProd
         and s.package_id = numSolReco;

    --se obtiene orden de reconexion del producto
    CURSOR cuOrdenRecoDummy(nuProd pr_product.product_id%type,
                            nuSol  mo_packages.package_id%type) IS
      SELECT OA.order_id
        FROM or_order_activity oa
       WHERE oa.package_id = nuSol
         AND oa.product_id = nuProd;

    --se obtiene orden de reconexion
    CURSOR cugetOrdeRecon(nuOt or_order.order_id%type) IS
      SELECT o.order_id, OA.PRODUCT_ID, OA.ORDER_ACTIVITY_ID, OA.PACKAGE_ID
        FROM or_order_activity oa, or_order o
       WHERE oa.order_id = o.order_id
         AND o.order_status_id = Or_BOConstants.CNUORDER_STAT_REGISTERED
         and o.order_id = nuOt;

    --se obtiene orden de sspension con error
    CURSOR cugetOrdeSuspen IS
      SELECT o.order_id, OA.PRODUCT_ID, OA.ORDER_ACTIVITY_ID
        FROM or_order_activity oa, or_order o, mo_packages s
       WHERE s.package_id = oa.package_id
         AND s.package_type_id = nuTramiSuspRp
         AND oa.order_id = o.order_id
         AND o.order_status_id = Or_BOConstants.CNUORDER_STAT_REGISTERED
         AND s.COMMENT_ = 'CAMBIO DE SUSPENSION DE CARTERA A RP';

    --se obtienen productos con defectos
    CURSOR cuGetProducDefe(nucu_nuse NUMBER) IS
      SELECT DF.ID_PRODUCTO
        FROM LDC_DEFCRI_NOREPARABLE DF
       WHERE df.id_producto = decode(nucu_nuse,-1,df.id_producto,nucu_nuse)
         AND mod(ID_PRODUCTO, inuCantHilo) + 1 = inuHilo;

    --se obtiene productos reconectados a suspender
    CURSOR cuGenerarSuspen IS
      SELECT product_id FROM ldc_prodreasu WHERE estasusp = 'N';

    --se consulta medidor actual
    CURSOR cuMedidorAct IS
      SELECT emsscoem
        FROM elmesesu
       WHERE emsssesu = NuProducto
         AND sysdate between EMSSFEIN AND EMSSFERE;

    --se obtiene tipo de suspension
    CURSOR cugetTiposusp IS
      SELECT Suspension_Type_Id
        FROM Pr_Prod_Suspension PS
       WHERE PS.Product_Id = NuProducto
         AND Active = 'Y';

    -- se valida la clasificacion de la causal
    CURSOR cuTipoCausal(nuCausal ge_causal.CAUSAL_ID%TYPE) IS
      SELECT DECODE(CLASS_CAUSAL_ID, 1, 1, 2, 0) tipo
        FROM ge_causal
       WHERE CAUSAL_ID = nuCausal;

    --se obtiene configurcion de forma LDCCACASU
    CURSOR cugetConfiActSusp(sbRowid varchar2) IS
      SELECT conf.cacstica,
             conf.cacscasu,
             conf.cacsunid,
             conf.cacscals,
             conf.cacspers
        FROM ldc_coactcasu     conf,
             ldc_prodrerp      p,
             or_order_activity oa
       WHERE oa.order_activity_id = p.prreacti
         AND conf.cacsacti = oa.activity_id
         AND p.prreprod = NuProducto
         and p.rowid = sbRowid;

    --se obtiene orden de suspension
    CURSOR cugetOrdeSusp IS
      SELECT oa.order_id, oa.order_activity_id
        FROM or_order_activity oa
       WHERE oa.package_id = nuSolicitud;

    --se valia el periodo de facturacion
    cursor cuPerifact(nuCiclo number) is
      select pefaactu
        from perifact
       where pefacicl = nuCiclo
         and sysdate between pefafimo and pefaffmo;

    CURSOR cuPeriodoCons(nuCiclo number) IS
      SELECT PECSCONS
        FROM PERICOSE
       WHERE PECSCICO = nuCiclo
         AND sysdate BETWEEN PECSFECI AND PECSFECF;

    --se obtiene orden de reconexion
    CURSOR cugetOrdeRecon2(nucu_nuse NUMBER) IS
      SELECT o.order_id,
             OA.PRODUCT_ID,
             OA.ORDER_ACTIVITY_ID,
             OA.PACKAGE_ID,
             o.order_status_id
        FROM or_order_activity oa, or_order o, mo_packages s
       WHERE oa.product_id = decode(nucu_nuse,-1,oa.product_id,nucu_nuse)
         AND s.package_id = oa.package_id
         AND s.package_type_id = nuTramRerp
         AND oa.order_id = o.order_id
         AND o.order_status_id in (0, 5)
         and s.motive_Status_id = nuEstadoRegSol
         and exists (select null
                from LDC_PRODRERP r
               where r.prreprod = oa.product_id
                 and r.prreproc = 'S'
                 and r.prreobse != 'X')
         and not exists
       (select null
                from LDC_PRODRERP r
               where r.prreprod = oa.product_id
                 and trunc(sysdate) = trunc(r.prrefege)
                 and r.prrefuen = 'SUSPADMIVOLU')
         AND mod(OA.PRODUCT_ID, inuCantHilo) + 1 = inuHilo;

    --se obtienen los componentes del producto
    CURSOR cuComProd(nuProd pr_product.product_id%type) is
      select p.product_id,
             p.component_id,
             p.component_status_id,
             c.cmssescm
        from pr_component p, compsesu c
       where p.product_id = c.cmsssesu
         and c.cmssidco = p.component_id
         and c.cmssfere > sysdate
         and p.product_id = nuProd;

    --se obtienen
    CURSOR cuSuspenCompo(nuComp pr_component.component_id%type) is
      select c.suspension_type_id
        from pr_comp_suspension c
       where component_id = nuComp
         and active = 'Y';

    PROCEDURE resetVariables IS

    BEGIN
      ut_trace.trace('Inicia ' || csbSP_NAME|| 'PRJOBRECOYSUSPRP.resetVariables' , cnuNVLTRC);
        
      nuTipoSusp      := NULL;
      nuTipocausal    := NULL;
      nuCausSusp      := NULL;
      nuUnidOpeSus    := NULL;
      nuCausaLegSu    := NULL;
      nupersLegSus    := NULL;
      nulectura       := NULL;
      nuClasCausal    := NULL;
      Medidor         := NULL;
      nuSolicitud     := null;
      nuOrdenSusp     := null;
      nuOrderActivity := null;
      nuSolReco       := null;
      ut_trace.trace('Termina ' || csbSP_NAME|| 'PRJOBRECOYSUSPRP.resetVariables' , cnuNVLTRC);      
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END resetVariables;
  BEGIN

    ut_trace.trace('Inicia ' || csbSP_NAME|| 'PRJOBRECOYSUSPRP' , cnuNVLTRC);
    
   dbms_output.disable();
   
   nmvaproduct_id := nvl(nupacodigo_producto,-1);
  
    -- Consultamos datos para inicializar el proceso
    SELECT to_number(to_char(SYSDATE, 'YYYY')),
           to_number(to_char(SYSDATE, 'MM')),
           userenv('SESSIONID'),
           USER
      INTO nuparano, nuparmes, nutsess, sbparuser
      FROM dual;

    NOMBRE_BD := UT_DBINSTANCE.FSBGETCURRENTINSTANCETYPE;
    if NOMBRE_BD != 'P' then
      NOMBRE_BD := 'PRUEBAS: ';
    ELSE
      NOMBRE_BD := NULL;
    end if;
    -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,
                           nuparmes,
                           'PRJOBRECOYSUSPRP',
                           'En ejecucion',
                           nutsess,
                           sbparuser);
    -- CA-923 JJJM Validamos si el producto enviado por parametro existe
    IF nmvaproduct_id <> -1 THEN
     SELECT COUNT(1) INTO nmconta
       FROM pr_product p
      WHERE p.product_id = nmvaproduct_id;
     IF nmconta = 0 THEN
      ldc_proactualizaestaprog(nutsess,
                               'No existe el producto con codigo : '||nmvaproduct_id,
                               'PRJOBRECOYSUSPRP',
                               'error'); 
      RETURN;                               
     END IF;
    END IF;                                                     

    begin
      select count(1) as CANTIDAD
        into nuEjecutores
        from gv$session s
       where s.module = 'EXECUTOR_PROCESS'
         and s.username = 'OPEN';
    exception
      when others then
        nuEjecutores := 0;
    end;

    if nuEjecutores >= nuMinEjecu then
      --se recorren y marcas los productos de defecto critico no reparable
      FOR reg IN cuGetProducDefe(nmvaproduct_id) LOOP
        nuEstaCorRec := NULL;
        nuIsvalid    := NULL;
        nuError      := null;
        sberror      := null;
        sbFlagElim   := 'N';
        --se valida si el producto esta suspendido por cartera
        LDC_PKGESTIONCASURP.PRINDEPRODSUCA(REG.ID_PRODUCTO,
                                           nuEstaCorRec,
                                           1,
                                           nuIsvalid);

        IF nuIsvalid = 0 THEN
          INSERT INTO LDC_PRODRERP
            (PRREPROD, PRREFEGE, PRREPROC)
          VALUES
            (reg.ID_PRODUCTO, SYSDATE, 'N');
          COMMIT;
        END IF;

      END LOOP;
      sbCountUsuario := 0;
      FOR reg IN cugetProdPendReco(nmvaproduct_id) LOOP
        nuSalir := 0;
        IF gbCiclo <> reg.sesucicl THEN
          gbCiclo     := reg.sesucicl;
          sbErrorFact := NULL;
          sbPefaactu  := NULL;
          nuPeriCons  := NULL;

          IF cuPeriodoCons%ISOPEN THEN
            CLOSE cuPeriodoCons;
          END IF;

          IF cuPerifact%ISOPEN THEN
            CLOSE cuPerifact;
          END IF;

          --valida si la fecha actual esta en periodo de facturacion actual
          open cuPerifact(reg.sesucicl);
          fetch cuPerifact
            into sbPefaactu;
          if cuPerifact%notfound then
            sbErrorFact := 'La fecha actual no se encuentra en los periodos de facturacion del ciclo ' ||
                           reg.sesucicl;
          else
            if sbPefaactu = 'N' then
              sbErrorFact := 'La fecha actual no se encuentra dentro del periodo de facturacion actual del ciclo ' ||
                             reg.sesucicl;
            else
              OPEN cuPeriodoCons(reg.sesucicl);
              FETCH cuPeriodoCons
                INTO nuPeriCons;
              IF cuPeriodoCons%NOTFOUND THEN
                sbErrorFact := 'El ciclo de consumo ' || reg.sesucico ||
                               ' no tiene un periodo de consumo vigente';
              END IF;
              CLOSE cuPeriodoCons;
              --nuPeriCons:= CM_BCREGLECT.FNUGETCURRCONSPERIODBYPROD(reg.prreprod,sysdate);

            END IF;
          END IF;
          CLOSE cuPerifact;
        end if;
        IF sbErrorFact IS NOT NULL THEN
          UPDATE LDC_PRODRERP
             SET PRREPROC = 'S', PRREOBSE = sbErrorFact, PRREFEPR = SYSDATE
           WHERE rowid = reg.idreg;
          commit;
        ELSE
          -- se ejecuta proceso de generacion de reconexion
          --   FOR reg IN cugetProdPendReco(regCi.SESUCICL) LOOP
          begin
            nuError      := null;
            sberror      := null;
            nuEstaCorRec := null;
            nuIsvalid    := null;
            sbErrorFact  := null;
            sbErrorComp  := null;
            sbPefaactu   := null;
            nuPerifact   := null;
            nuPeriCons   := null;
            resetVariables;
            UPDATE LDC_PRODRERP SET PRREOBSE = 'X' WHERE rowid = reg.idreg;
            commit;

            --se valida si el producto esta suspendido por cartera
            LDC_PKGESTIONCASURP.PRINDEPRODSUCA(reg.PRREPROD,
                                               nuEstaCorRec,
                                               2,
                                               nuIsvalid);

            IF nuIsvalid = 0 THEN
              for comp in cuComProd(reg.PRREPROD) loop
                if comp.component_status_id != 8 or comp.cmssescm != 8 then
                  sbErrorComp := 'Error con los componentes del producto validar';
                end if;
                sbCompsus := null;
                for compsus in cuSuspenCompo(comp.component_id) loop
                  sbCompsus := 'S';
                  if compsus.suspension_type_id != nuTipoSuspCart then
                    sbErrorComp := 'Error con los componentes del producto validar';
                    exit;
                  end if;
                end loop;

                if sbErrorComp is not null then
                  exit;
                end if;
              end loop;

              --se genera orden de reconexion
              if sbErrorComp is null then
                LDC_PKGESTIONCASURP.PRGENRECORP(reg.PRREPROD,
                                                nuEstaCorRec,
                                                nuError,
                                                sberror,
                                                nuSolReco);
                IF nuError = 0 THEN
                  open cugetlecturaSusp(reg.prreprod);
                  fetch cugetlecturaSusp
                    into nulectura;
                  if cugetlecturaSusp%notfound then
                    nulectura := null;
                  end if;
                  close cugetlecturaSusp;
                  if nuLectura is null then
                    OPEN cugetlecturaFact(reg.prreprod);
                    FETCH cugetlecturaFact
                      INTO nulectura;
                    CLOSE cugetlecturaFact;

                    IF nulectura IS NULL THEN
                      ROLLBACK;
                      sbErrorComp := 'No se encontro lectura asociada a la ultima actividad de suspension del producto';
                    END IF;
                  end if;
                  if sbErrorComp is null then
                    IF cugetConfiActSusp%ISOPEN THEN
                      CLOSE cugetConfiActSusp;
                    END IF;
                    --se obtiene configuracion de actividad de suspension de cartera
                    NuProducto := reg.prreprod;
                    OPEN cugetConfiActSusp(reg.idreg);
                    FETCH cugetConfiActSusp
                      INTO nuTipocausal,
                           nuCausSusp,
                           nuUnidOpeSus,
                           nuCausaLegSu,
                           nupersLegSus;
                    IF cugetConfiActSusp%FOUND THEN
                      COMMIT;
                    ELSE
                      ROLLBACK;
                      sbErrorComp := 'No se encontro configuracion de cambio de tipo de suspension, validar forma LDCCACASU';
                    END IF;
                  end if;

                ELSE
                  ROLLBACK;
                  sbErrorComp := sberror;
                END IF;
              end if;
              if sbErrorComp is not null then
                UPDATE LDC_PRODRERP
                   SET PRREPROC = 'S',
                       PRREOBSE = sbErrorComp,
                       PRREFEPR = SYSDATE
                 WHERE rowid = reg.idreg;
                commit;

              else
                ------empieza proceso de legalizacion de recoxion
                for reco in cugetSoliRecon(reg.prreprod, nuSolReco) loop
                  nuOrdenRecoDum := null;
                  nuTiempoTotal  := 0;
                  sbErrorFlujo   := null;
                  while nuOrdenRecoDum is null loop
                    open cuOrdenRecoDummy(reg.prreprod, reco.package_id);
                    fetch cuOrdenRecoDummy
                      into nuOrdenRecoDum;
                    close cuOrdenRecoDummy;
                    IF nuOrdenRecoDum is null then
                      DBMS_LOCK.SLEEP(nuTiempoEspera);
                      nuTiempoTotal := nuTiempoTotal + nuTiempoEspera;
                      LDC_PKGESTIONCASURP.proEmpujaSolicitud(reco.package_id,
                                                             sbErrorFlujo);
                      if sbErrorFlujo is not null then
                        UPDATE LDC_PRODRERP
                           SET PRREPROC = 'S',
                               PRREOBSE = 'ERROR FLUJOS ' || sbErrorFlujo,
                               PRREFEPR = SYSDATE
                         WHERE rowid = reg.idreg;
                        commit;
                        GOTO salir;
                      end if;
                      if nuTiempoTotal > nuTiempoMaximo then
                        UPDATE LDC_PRODRERP
                           SET PRREPROC = 'S',
                               PRREOBSE = 'SE PRESENTARON DEMORAS AL GENERAR OT RECON DUMMY, SE LEGALIZARA CON FALLO',
                               PRREFEPR = SYSDATE
                         WHERE rowid = reg.idreg;
                        commit;
                        GOTO salir;
                      end if;
                    end if;
                  end loop;

                  ---
                  FOR regOt IN cugetOrdeRecon(nuOrdenRecoDum) LOOP
                    resetVariables; --Se setean variables
                    NuProducto  := regOt.product_id;
                    nuOrdenreco := regOt.order_id;

                    --se asigan orden de reconexion
                    API_ASSIGN_ORDER(nuOrdenreco,
                                    nuUnidOper,
                                    nuerror,
                                    SBERROR);

                    IF nuerror <> 0 THEN
                      proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPRP-ASIGRECO',
                                                   SYSDATE,
                                                   nuOrdenReco,
                                                   NULL,
                                                   sberror,
                                                   USER);
                      ROLLBACK;
                      update ldc_PRODRERP
                         SET PRREPROC = 'S',
                             PRREOBSE = 'SE LEGALIZARA CON FALLO LA RECONEXION DUMMY POR ERROR, VALIDAR LOG',
                             PRREFEPR = SYSDATE
                       WHERE rowid = reg.idreg;
                      commit;
                    ELSE
                      commit;

                      dbms_lock.sleep(1);
                      nuerror := null;
                      SBERROR := null;

                      if nuTiempoTotal > nuTiempoMaximo then
                        LDC_PKGESTIONCASURP.PRINDEPRODSUCA(reg.PRREPROD,
                                                           nuEstaCorRec,
                                                           3,
                                                           nuIsvalid);
                        if nuIsvalid != 0 then
                          nuCausalLega := nuCausalLegFall;
                        end if;
                        begin
                          select p.suspen_ord_act_id
                            into nuUltActSusp
                            from pr_product p
                           where p.product_id = NuProducto;
                        exception
                          when others then
                            nuUltActSusp := null;
                        end;

                        begin
                          select PRREACTI
                            into nuUltActSusMar
                            from ldc_PRODRERP
                           where PRREPROD = NuProducto;
                        exception
                          when others then
                            nuUltActSusMar := null;
                        end;

                        if nvl(nuUltActSusp, 0) != nvl(nuUltActSusMar, 0) then
                          SELECT LEEMLETO
                            into nuLectSuspAc
                            FROM (SELECT LE.LEEMLETO
                                    FROM LECTELME le
                                   WHERE LE.LEEMSESU = NuProducto
                                     AND le.LEEMDOCU = nuUltActSusp
                                   ORDER BY LE.LEEMFELE DESC)
                           WHERE ROWNUM < 2;

                          if nuLectSuspAc is not null then
                            update ldc_PRODRERP
                               set PRREACTI = nuUltActSusp
                             where PRREPROD = NuProducto
                               AND PRREPROC = 'N';
                          else
                            OPEN cugetlecturaFact(NuProducto);
                            FETCH cugetlecturaFact
                              INTO nuLectSuspAc;
                            CLOSE cugetlecturaFact;
                            IF nuLectSuspAc IS NULL THEN
                              nuCausalLega := nuCausalLegFall;
                            ELSE
                              update ldc_PRODRERP
                                 set PRREACTI = nuUltActSusp
                               where PRREPROD = NuProducto
                                 AND PRREPROC = 'N';
                            END IF;
                          end if;

                        end if;

                      end if;
                      --se valida clase de causal
                      OPEN cuTipoCausal(nuCausalLega);
                      FETCH cuTipoCausal
                        INTO nuClasCausal;
                      CLOSE cuTipoCausal;

                      --se obtiene lectura de suspension
                      OPEN cugetlecturaSusp(NuProducto);
                      FETCH cugetlecturaSusp
                        INTO nulectura;
                      CLOSE cugetlecturaSusp;

                      IF nulectura IS NULL THEN
                        OPEN cugetlecturaFact(NuProducto);
                        FETCH cugetlecturaFact
                          INTO nulectura;
                        CLOSE cugetlecturaFact;
                      END IF;

                      --se obtiene medidor del producto
                      OPEN cuMedidorAct;
                      FETCH cuMedidorAct
                        INTO medidor;
                      CLOSE cuMedidorAct;

                      --se obtiene el tipo de suspension
                      OPEN cugetTiposusp;
                      FETCH cugetTiposusp
                        INTO nuTipoSuspLega;
                      CLOSE cugetTiposusp;
                      sbCadenaFallo := nuOrdenreco || '|' ||
                                       nuCausalLegFall || '|' ||
                                       nuPersonaLega || '||' ||
                                       regOt.ORDER_ACTIVITY_ID || '>' || 0 ||
                                       ';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|' ||
                                       NVL(sbItemLegaReco, '') ||
                                       '||1277;Orden Legalizada por proceso PRJOBRECOYSUSPRP';

                      IF nuClasCausal > 0 THEN
                        sbCadenalega := nuOrdenreco || '|' || nuCausalLega || '|' ||
                                        nuPersonaLega || '||' ||
                                        regOt.ORDER_ACTIVITY_ID || '>' ||
                                        nuClasCausal || ';READING>' ||
                                        NVL(nuLectura, '') ||
                                        '>9>;SUSPENSION_TYPE>' ||
                                        NVL(nuTipoSuspLega, '') || '>>;;|' ||
                                        NVL(sbItemLegaReco, '') || '|' ||
                                        Medidor || ';1=' ||
                                        NVL(nulectura, '') || '=T===|' ||
                                        '1277;Orden Legalizada por proceso PRJOBRECOYSUSPRP';
                      else
                        sbCadenalega := sbCadenaFallo;
                      END IF;
                      --se legaliza orden de trabajo
                      delete ldc_ordeasigproc
                       where orapsoge = reco.package_id
                         and oraoproc = 'CAMBTISU';

                      api_legalizeorders(sbCadenalega,
                                        sysdate,
                                        sysdate,
                                        null,
                                        nuerror,
                                        SBERROR);

                      IF nuerror <> 0 THEN
                        proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPRP-LEGARECO',
                                                     SYSDATE,
                                                     nuOrdenReco,
                                                     NULL,
                                                     sberror,
                                                     USER);
                        ROLLBACK;
                        nuerror := null;
                        SBERROR := null;
                        api_legalizeorders(sbCadenaFallo,
                                          sysdate,
                                          sysdate,
                                          null,
                                          nuerror,
                                          SBERROR);
                        if nuerror = 0 then
                          commit;
                          UPDATE LDC_PRODRERP
                             SET PRREPROC = 'S',
                                 PRREOBSE = 'SE LEGALIZA CON FALLO LA RECONEXION DUMMY POR ERROR, VALIDAR LOG',
                                 PRREFEPR = SYSDATE
                           WHERE rowid = reg.idreg;
                          commit;
                        else
                          rollback;
                          proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPRP-LEGARECO',
                                                       SYSDATE,
                                                       nuOrdenReco,
                                                       NULL,
                                                       SBERROR,
                                                       USER);
                          UPDATE LDC_PRODRERP
                             SET PRREPROC = 'S',
                                 PRREOBSE = 'SE LEGALIZARA CON FALLO LA RECONEXION DUMMY POR ERROR, VALIDAR LOG',
                                 PRREFEPR = SYSDATE
                           WHERE rowid = reg.idreg;
                          commit;
                        end if;
                      ELSE
                        nuEstadoProd := 2;
                        WHILE nuEstadoProd != 1 LOOP
                          BEGIN
                            SELECT PRODUCT_STATUS_ID
                              INTO nuEstadoProd
                              FROM PR_PRODUCT P
                             WHERE P.PRODUCT_ID = NuProducto;
                            if nuEstadoProd != 1 then
                              dbms_lock.sleep(nuTiempoEspera);
                              nuTiempoTotal := nuTiempoTotal +
                                               nuTiempoEspera;
                              if nuTiempoTotal > nuTiempoMaximo then
                                ROLLBACK;
                                UPDATE LDC_PRODRERP
                                   SET PRREPROC = 'S',
                                       PRREOBSE = 'SE PRESENTARON DEMORAS AL CAMBIAR ESTADO PRODUCTO, OT RECON DUMMY SE LEGALIZARA CON FALLO',
                                       PRREFEPR = SYSDATE
                                 WHERE rowid = reg.idreg;
                                commit;
                                GOTO salir;
                              end if;
                            end if;
                          EXCEPTION
                            WHEN OTHERS THEN
                              nuEstadoProd := 2;
                          END;

                        END LOOP;
                        ------EMPIEZA GENERACION SUSPENSION
                        IF cugetConfiActSusp%ISOPEN THEN
                          CLOSE cugetConfiActSusp;
                        END IF;
                        --se obtiene configuracion de actividad de suspension de cartera
                        OPEN cugetConfiActSusp(reg.idreg);
                        FETCH cugetConfiActSusp
                          INTO nuTipocausal,
                               nuCausSusp,
                               nuUnidOpeSus,
                               nuCausaLegSu,
                               nupersLegSus;
                        IF cugetConfiActSusp%FOUND THEN
                          nuTipoSusp := ldci_pkrevisionperiodicaweb.fnutiposuspension(NuProducto);
                          --se crea orden de suspension

                          nuSolicitud := fnuGeneTramSuspRP(NuProducto,
                                                           nuMediRece,
                                                           nuTipocausal,
                                                           nuCausSusp,
                                                           nuTipoSusp,
                                                           'CAMBIO DE SUSPENSION DE CARTERA A RP',
                                                           nuerror,
                                                           SBERROR);
                          IF nuerror <> 0 THEN
                            proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPRP-TRAMSUSPRP',
                                                         SYSDATE,
                                                         nuOrdenReco,
                                                         NULL,
                                                         sberror,
                                                         USER);
                            ROLLBACK;
                            UPDATE LDC_PRODRERP
                               SET PRREPROC = 'S',
                                   PRREOBSE = 'ERROR GENERANDO TRAMITE DE SUSPENSION:' ||
                                              SBERROR,
                                   PRREFEPR = SYSDATE
                             WHERE rowid = reg.idreg;
                            COMMIT;
                          ELSE
                            COMMIT;
                            dbms_lock.sleep(nuTiempoEspera);
                            nuTiempoTotal := nuTiempoTotal + nuTiempoEspera;
                            sbErrorFlujo  := NULL;
                            --se obtiene orden de suspension
                            WHILE nuOrdenSusp IS NULL LOOP
                              OPEN cugetOrdeSusp;
                              FETCH cugetOrdeSusp
                                INTO nuOrdenSusp, nuOrderActivity;
                              CLOSE cugetOrdeSusp;
                              IF nuOrdenSusp is null then
                                DBMS_LOCK.SLEEP(nuTiempoEspera);
                                nuTiempoTotal := nuTiempoTotal +
                                                 nuTiempoEspera;
                                LDC_PKGESTIONCASURP.proEmpujaSolicitud(nuSolicitud,
                                                                       sbErrorFlujo);
                              end if;
                              dbms_lock.sleep(nuTiempoEspera);
                              nuTiempoTotal := nuTiempoTotal +
                                               nuTiempoEspera;
                            END LOOP;

                            ut_trace.trace('ORDEN DE SUSPENSION '||nuOrdenSusp , cnuNVLTRC);                            
                            
                            IF nuOrdenSusp IS NOT NULL THEN
                              nuerror := null;
                              SBERROR := null;
                              delete ldc_bloq_lega_solicitud se
                               where se.package_id_gene = nuSolicitud;
                              --se asigna y legaliza orden de suspension
                              prAsigLegOrdSusp(nuOrdenSusp,
                                               nuOrderActivity,
                                               nuUnidOpeSus,
                                               nuCausaLegSu,
                                               nupersLegSus,
                                               nuLectura,
                                               NULL,
                                               Medidor,
                                               'Orden Legalizada por proceso PRJOBRECOYSUSPRP',
                                               nuerror,
                                               SBERROR);

                              IF nuerror <> 0 THEN
                                proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPRP-ASIGLEGSUSP',
                                                             SYSDATE,
                                                             nuOrdenSusp,
                                                             nuOrdenReco,
                                                             sberror,
                                                             USER);
                                ROLLBACK;
                                UPDATE LDC_PRODRERP
                                   SET PRREPROC = 'S',
                                       PRREOBSE = 'ERROR LEGALIZANDO OT SUSPENSION, VALIDAR LOG',
                                       PRREFEPR = SYSDATE
                                 WHERE rowid = reg.idreg;
                                COMMIT;
                                nuSalir := 1;
                                IF NOMBRE_BD IS NULL THEN
                                    pkg_Correo.prcEnviaCorreo
                                    (
                                        isbRemitente        => sbRemitente,
                                        isbDestinatarios    => sbMail,
                                        isbAsunto           => 'URGENTE!!! Error Job de Cambio de Suspension RP',
                                        isbMensaje          => NOMBRE_BD ||
                                                'Se tiene problemas legalizando la orden de suspension: ' ||
                                                nuOrdenSusp ||
                                                ' el programa terminara'
                                    );
                                ELSE
                                    pkg_Correo.prcEnviaCorreo
                                    (
                                        isbRemitente        => sbRemitente,
                                        isbDestinatarios    => sbMail,
                                        isbAsunto           => 'Error Job de Cambio de Suspension RP',
                                        isbMensaje          => NOMBRE_BD ||
                                                'Se tiene problemas legalizando la orden de suspension: ' ||
                                                nuOrdenSusp ||
                                                ' el programa terminara'
                                    );

                                END IF;
                              ELSE
                                DELETE FROM LDC_DEFCRI_NOREPARABLE
                                 WHERE ID_PRODUCTO = REG.PRREPROD;
                                UPDATE LDC_PRODRERP
                                   SET PRREPROC = 'S',
                                       PRREOBSE = 'PROCESADO CON EXITO',
                                       PRREFEPR = SYSDATE
                                 WHERE rowid = reg.idreg;

                                Select count(1)
                                  into nuProductoValido
                                  from servsusc s
                                 where s.sesunuse = NuProducto
                                   and s.sesuesco not in (5)
                                   and s.sesuesfn not in ('C');
                                if nuProductoValido = 1 then
                                  update LD_PRODAPPLYSUSPEND p
                                     set p.proc_reconex  = 'A',
                                         p.proc_date     = sysdate,
                                         p.proc_response = 'Se anula por nuevo cambio de tipo de suspensión'
                                   where p.proc_reconex = 'N'
                                     and p.product_id = NuProducto;
                                  insert into LD_PRODAPPLYSUSPEND
                                    (PRODUCT_ID,
                                     ORDER_ID,
                                     PROC_RECONEX,
                                     REG_DATE,
                                     PROC_DATE,
                                     PROC_RESPONSE)
                                  VALUES
                                    (NuProducto,
                                     nuOrdenSusp,
                                     'N',
                                     sysdate,
                                     null,
                                     null);
                                end if;
                                --
                                COMMIT;
                              END IF;
                            END IF;

                          END IF;
                        END IF;
                        CLOSE cugetConfiActSusp;
                        -----TERMINA GENERACION SUSPENSION

                      END IF;
                    END IF;

                  END LOOP;
                  ---

                end loop;

                ------termina proceso de legalizacioni de orden de reconexion
              end if;
            ELSE
              UPDATE LDC_PRODRERP
                 SET PRREPROC = 'S',
                     PRREOBSE = 'NO CUMPLE REQUISITO PARA GENERACION, VALIDAR LOG',
                     PRREFEPR = SYSDATE
               WHERE rowid = reg.idreg;
              commit;
            END IF;

            <<salir>>
            IF nuTiempoTotal > nuTiempoMaximo THEN
              sbCountUsuario := sbCountUsuario + 1;
              begin
                select count(1) as CANTIDAD
                  into nuEjecutores
                  from gv$session s
                 where s.module = 'EXECUTOR_PROCESS'
                   and s.username = 'OPEN';
              exception
                when others then
                  nuEjecutores := 0;
              end;
              if nuEjecutores < nuMinEjecu then
                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => sbRemitente,
                        isbDestinatarios    => sbMail,
                        isbAsunto           => 'Error Job de Cambio de Suspension RP',
                        isbMensaje          => NOMBRE_BD ||
                                'Se tiene problemas con los ejecutores favor validar'
                    );
                exit;
              end if;
            else
              sbCountUsuario := 0;
            END IF;
            if sbCountUsuario > nuMaxUsuario then
                pkg_Correo.prcEnviaCorreo
                (
                    isbRemitente        => sbRemitente,
                    isbDestinatarios    => sbMail,
                    isbAsunto           => 'Error Job de Cambio de Suspension RP',
                    isbMensaje          => NOMBRE_BD ||
                            'Se ha execedido el numero de usuarios con demoras en el cambio, favor validar'
                );
              exit;
            end if;
            if nuSalir = 1 then
              exit;
            end if;

          exception
            when others then
              rollback;
          end;
          --   END LOOP;

        END IF;
      END LOOP;

      FOR reg IN cugetOrdeRecon2(nmvaproduct_id) LOOP
        resetVariables; --Se setean variables
        NuProducto  := reg.product_id;
        nuOrdenreco := reg.order_id;
        nuerror     := 0;
        if reg.order_status_id = 0 then

          --se asigan orden de reconexion
          API_ASSIGN_ORDER(nuOrdenreco,
                          nuUnidOper,
                          nuerror,
                          SBERROR);

          IF nuerror <> 0 THEN
            proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPRP-ASIGRECO',
                                         SYSDATE,
                                         nuOrdenReco,
                                         NULL,
                                         sberror,
                                         USER);
            ROLLBACK;

          ELSE
            commit;
          end if;
        end if;

        if nuerror = 0 then
          --se valida clase de causal
          OPEN cuTipoCausal(nuCausalLegFall);
          FETCH cuTipoCausal
            INTO nuClasCausal;
          CLOSE cuTipoCausal;
          sbCadenalega := nuOrdenreco || '|' || nuCausalLegFall || '|' ||
                          nuPersonaLega || '||' || REG.ORDER_ACTIVITY_ID || '>' ||
                          nuClasCausal ||
                          ';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|' ||
                          NVL(sbItemLegaReco, '') ||
                          '||1277;Orden Legalizada por proceso PRJOBRECOYSUSPRP';
          --se legaliza orden de trabajo
          api_legalizeorders(sbCadenalega,
                            sysdate,
                            sysdate,
                            null,
                            nuerror,
                            SBERROR);
          IF nuerror <> 0 THEN
            proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPRP-LEGARECO',
                                         SYSDATE,
                                         nuOrdenReco,
                                         NULL,
                                         sberror,
                                         USER);
            ROLLBACK;
          ELSE
            commit;

          END IF;
        END IF;

      END LOOP;

      ldc_proactualizaestaprog(nutsess, SBERROR, 'PRJOBRECOYSUSPRP', 'Ok');
    else

        pkg_Correo.prcEnviaCorreo
        (
            isbRemitente        => sbRemitente,
            isbDestinatarios    => sbMail,
            isbAsunto           => 'Error Job de Cambio de Suspension RP',
            isbMensaje          => NOMBRE_BD ||
                    'Se tiene problemas con los ejecutores favor validar'
        );

        ldc_proactualizaestaprog(nutsess,
                               SBERROR,
                               'PRJOBRECOYSUSPRP',
                               'No estan el minimo de ejecutores arriba');
    end if;
    
    ut_trace.trace('Termina ' || csbSP_NAME|| 'PRJOBRECOYSUSPRP' , cnuNVLTRC);    

  EXCEPTION
    WHEN pkg_Error.controlled_error THEN
      pkg_error.getError(nuerror, SBERROR);
      ldc_proactualizaestaprog(nutsess,
                               SBERROR,
                               'PRJOBRECOYSUSPRP',
                               'error');

    WHEN OTHERS THEN
      pkg_error.setError;
      pkg_error.getError(nuerror, SBERROR);
      ldc_proactualizaestaprog(nutsess,
                               SBERROR,
                               'PRJOBRECOYSUSPRP',
                               'error');
      rollback;
  END PRJOBRECOYSUSPRP;

  procedure reconectaproduct is
    /**************************************************************************
     Proceso     : reconectaproduct
     Autor       : Horbath
     Fecha       : 2020-04-20
     Ticket      : 176
     Descripcion : plugin que realiza la reconexion dummy del producto

     Parametros Entrada

     Parametros de salida

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
       26/03/2021   olsoftware       CA 498 se coloca valdiacion para no crear suspcone y actualizar procudto activo
    ***************************************************************************/

    nuCausalId  or_order.causal_id%type;
    nuPackageId mo_packages.package_id%type;
    nuOrderId   or_order.order_id%type;
    nuMotiveId  mo_motive.motive_id%type;
    nuBloqueo   number;

    --INICIO CA 498
    sbMotivoSuspVol VARCHAR2(400) := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_MOTISUSVOLU');
    sbMotivoSuspAdm VARCHAR2(400) := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_MOTISUSADMIN');

    nuproducto number;
    sbMotivo   VARCHAR2(4000);

    CURSOR cuGetMarcaProducto IS
      SELECT OA.PRODUCT_ID, MOTIVO
        FROM LDC_PRODEXCLRP P, OR_ORDER_ACTIVITY OA
       WHERE P.PRODUCT_ID = OA.PRODUCT_ID
         AND MOTIVO IN (sbMotivoSuspVol, sbMotivoSuspAdm)
         AND OA.ORDER_ID = nuOrderId;
    --FIN CA 498

  begin
  
    ut_trace.trace('Inicia ' || csbSP_NAME|| 'reconectaproduct' , cnuNVLTRC);
      
    /*Obtiene el id de la orden en la instancia*/
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder();
    ut_trace.trace('reconectaproduct-nuOrderId -->' || nuOrderId, 10);
    /*Obtiene el id de la causal de legalizacion*/
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
    ut_trace.trace('LDC_VAL_CAUS_PACK_TYPE-nuCausalId -->' || nuCausalId,
                   10);
    /*Obtiene el id de la solicitud de la actividad*/
    nuPackageId := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                         'ORDER_ID',
                                                         'PACKAGE_ID',
                                                         nuOrderId);

    if nuPackageId is not null then
      begin
        select count(1)
          into nuBloqueo
          from ldc_ordeasigproc
         where orapsoge = nuPackageId
           and oraoproc = 'CAMBTISU';
      exception
        when others then
          nuBloqueo := 0;
      end;
    else
      pkg_error.setErrorMessage( isbMsgErrr =>
                                       'Error la orden ' || nuOrderId ||
                                       '. La orden no se encuentra asociada a solicitud');
    end if;
    if dage_causal.fnugetclass_causal_id(nuCausalId, null) = 1 then
      if nuBloqueo > 0 then
        pkg_error.setErrorMessage( isbMsgErrr =>
                                         'La orden solo se puede legalizar con causal de exito en el job de cambio de tipo de suspension');
      end if;

      OPEN cuGetMarcaProducto;
      FETCH cuGetMarcaProducto
        INTO nuproducto, sbMotivo;
      CLOSE cuGetMarcaProducto;

      nuMotiveId := ldc_boutilities.fsbgetvalorcampotabla('MO_MOTIVE',
                                                          'PACKAGE_ID',
                                                          'MOTIVE_ID',
                                                          nuPackageId);

      IF nuproducto IS NULL THEN

        LDC_PKGESTIONCASURP.PRGENREGSUPCONE(nuPackageId);

        MO_BOSUSPENSION.RECONBYPAYATTENTION(nuMotiveId);
      else
        IF sbMotivo = sbMotivoSuspVol THEN
          MO_BOSUSPENSION.RECONVOLPRATTENTION(nuMotiveId);
          dapr_product.updproduct_status_id(nuproducto, 1);
        ELSE
          LDC_PKOSSRECONEXADMIN.PROCRECONADMINCAMBEST(nuPackageId);
        END IF;
      END IF;

    end if;
    if nuBloqueo > 0 then
      delete ldc_bloq_lega_solicitud
       where package_id_gene = nuPackageId;
    end if;
    
    ut_trace.trace('Termina ' || csbSP_NAME|| 'reconectaproduct' , cnuNVLTRC);
        
  end reconectaproduct;

  procedure RECONECTAPRODUCTCAST is
    /**************************************************************************
     Proceso     : RECONECTAPRODUCTCAST
     Autor       : olsofware
     Fecha       : 27/09/2020
     Ticket      : CASO 442
     Descripcion : plugin que realiza la reconexion dummy del producto
                   y actualiza el producto a estado financiero CASTIGADO y estado de corte igual a 5

     Parametros Entrada

     Parametros de salida

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
     26/03/2021   olsoftware       CA 498 se coloca valdiacion para no crear suspcone y actualizar procudto activo
    ***************************************************************************/

    nuCausalId  or_order.causal_id%type;
    nuPackageId mo_packages.package_id%type;
    nuOrderId   or_order.order_id%type;
    nuMotiveId  mo_motive.motive_id%type;
    nuBloqueo   number;
    nuProducto  or_order_activity.product_id%type;

    --INICIO CA 498
    sbMotivoSuspVol VARCHAR2(400) := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_MOTISUSVOLU');
    sbMotivoSuspAdm VARCHAR2(400) := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_MOTISUSADMIN');

    nuproductoexc number;

    sbMotivo VARCHAR2(4000);

    CURSOR cuGetMarcaProducto IS
      SELECT OA.PRODUCT_ID, MOTIVO
        FROM LDC_PRODEXCLRP P, OR_ORDER_ACTIVITY OA
       WHERE P.PRODUCT_ID = OA.PRODUCT_ID
         AND MOTIVO IN (sbMotivoSuspVol, sbMotivoSuspAdm)
         AND OA.ORDER_ID = nuOrderId;
    --FIN CA 498

  begin
  
    ut_trace.trace('Inicia ' || csbSP_NAME|| 'RECONECTAPRODUCTCAST' , cnuNVLTRC);
      
    /*Obtiene el id de la orden en la instancia*/
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder();
    ut_trace.trace('RECONECTAPRODUCTCAST-nuOrderId -->' || nuOrderId, 10);
    /*Obtiene el id de la causal de legalizacion*/
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
    ut_trace.trace('LDC_VAL_CAUS_PACK_TYPE-nuCausalId -->' || nuCausalId,
                   10);
    /*Obtiene el id de la solicitud de la actividad*/
    nuPackageId := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                         'ORDER_ID',
                                                         'PACKAGE_ID',
                                                         nuOrderId);
    nuProducto  := null;
    begin
      select product_id
        into nuProducto
        from OR_ORDER_ACTIVITY
       where order_id = nuOrderId
         and rownum = 1;
    exception
      when others then
        nuProducto := null;
    end;

    if nuProducto is null then
      pkg_error.setErrorMessage( isbMsgErrr =>
                                       'Error la orden ' || nuOrderId ||
                                       '. La orden no tiene producto');
    end if;

    if nuPackageId is not null then
      begin
        select count(1)
          into nuBloqueo
          from ldc_ordeasigproc
         where orapsoge = nuPackageId
           and oraoproc = 'CAMBTISU';
      exception
        when others then
          nuBloqueo := 0;
      end;
    else
      pkg_error.setErrorMessage( isbMsgErrr =>
                                       'Error la orden ' || nuOrderId ||
                                       '. La orden no se encuentra asociada a solicitud');
    end if;
    if dage_causal.fnugetclass_causal_id(nuCausalId, null) = 1 then
      if nuBloqueo > 0 then
        pkg_error.setErrorMessage( isbMsgErrr =>
                                         'La orden solo se puede legalizar con causal de exito en el job de cambio de tipo de suspension');
      end if;
      
      OPEN cuGetMarcaProducto;
      FETCH cuGetMarcaProducto
        INTO nuproductoexc, sbMotivo;
      CLOSE cuGetMarcaProducto;

      if nuproductoexc is null then
        LDC_PKGESTIONCASURP.PRGENREGSUPCONE(nuPackageId);

        nuMotiveId := ldc_boutilities.fsbgetvalorcampotabla('MO_MOTIVE',
                                                            'PACKAGE_ID',
                                                            'MOTIVE_ID',
                                                            nuPackageId);
        MO_BOSUSPENSION.RECONBYPAYATTENTION(nuMotiveId);

      else
        IF sbMotivo = sbMotivoSuspVol THEN
          MO_BOSUSPENSION.RECONVOLPRATTENTION(nuMotiveId);
          dapr_product.updproduct_status_id(nuproductoexc, 1);
        ELSE
          LDC_PKOSSRECONEXADMIN.PROCRECONADMINCAMBEST(nuPackageId);
        END IF;
      end if;
      DBMS_LOCK.SLEEP(5);

      update servsusc set SESUESCO = 5 WHERE sesunuse = nuProducto;

      insert into PROD_NEGDEUDA_RP
        (PRODUCT_ID, FECHA_REGISTRO, PROCESADO)
      values
        (nuProducto, sysdate, 'N');

    end if;
    if nuBloqueo > 0 then
      delete ldc_bloq_lega_solicitud
       where package_id_gene = nuPackageId;
    end if;

    ut_trace.trace('Termina ' || csbSP_NAME|| 'RECONECTAPRODUCTCAST' , cnuNVLTRC);
    
  end RECONECTAPRODUCTCAST;

  procedure proEmpujaSolicitud(nuPackage       in mo_packages.package_id%type,
                               osberrormessage out varchar2) is
    /**************************************************************************
     Proceso     : proEmpujaSolicitud
     Autor       : Horbath
     Fecha       : 2020-04-20
     Ticket      : 176
     Descripcion : empuja una solicitud

     Parametros Entrada

     Parametros de salida

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    pragma autonomous_Transaction;
    onuerror    Varchar2(50);
    exerror     Exception;
    nuProcesado number := 0;

    --PB MOPWP
    --Query Funcion: MO_BOFWSENTACTIVITIES.FRCGETSEARCHWFACTSENTFORPACK:
    Cursor cumopwp Is
      Select a.wf_pack_interfac_id pk,
             a.wf_pack_interfac_id message_proc_id,
             a.activity_id || ' - ' ||
             wf_bobasicdataservices.fsbgetdescactivity(a.activity_id) activity_id,
             a.status_activity_id || ' - ' ||
             mo_bobasicdataservices.fsbgetdescactivitystat(a.status_activity_id) activity_status,
             a.package_id Package,
             a.causal_id_output || ' - ' ||
             ge_bobasicdataservices.fsbgetdesccausal(a.causal_id_output) causal_id_output,
             a.action_id || ' - ' ||
             ge_bobasicdataservices.fsbgetdescaction(a.action_id) action_id,
             a.executor_log_id || ' - ' ||
             ge_bobasicdataservices.fsbgetdescerrorlog(a.executor_log_id) mensaje_error,
             a.recording_date act_recording_date,
             a.attendance_date attendance_date
        From mo_wf_pack_interfac a, wf_instance b
       Where a.activity_id = b.instance_id
         And a.status_activity_id = 4
         and a.package_id = nuPackage;
    -- And rownum <= 1;

    --PB MOPWM
    --Query Funcion: MO_BOFWSENTACTIVITIES.FRCGETSEARCHWFACTSENTFORMOT:
    Cursor cumopwm Is
      Select a.wf_motiv_interfac_id pk,
             a.wf_motiv_interfac_id message_proc_id,
             a.activity_id || ' - ' ||
             wf_bobasicdataservices.fsbgetdescactivity(a.activity_id) activity_id,
             a.status_activity_id || ' - ' ||
             mo_bobasicdataservices.fsbgetdescactivitystat(a.status_activity_id) activity_status,
             a.motive_id motive_id,
             a.causal_id_output || ' - ' ||
             ge_bobasicdataservices.fsbgetdesccausal(a.causal_id_output) causal_id_output,
             a.action_id || ' - ' ||
             ge_bobasicdataservices.fsbgetdescaction(a.action_id) action_id,
             a.executor_log_id || ' - ' ||
             ge_bobasicdataservices.fsbgetdescerrorlog(a.executor_log_id) mensaje_error,
             a.recording_date act_recording_date,
             a.attendance_date attendance_date
        From mo_wf_motiv_interfac a,
             wf_instance          b,
             mo_motive            c
       Where a.activity_id = b.instance_id
         And a.motive_id = c.motive_id
         And a.status_activity_id = 4
         and c.package_id = nuPackage;
    -- And rownum <= 1;

    --PB MOPWC
    --Query Funcion: MO_BOFWSENTACTIVITIES.FRCGETSEARCHWFACTIVITIESSENT:
    Cursor cumopwc Is
      Select a.wf_comp_interfac_id pk,
             a.wf_comp_interfac_id message_proc_id,
             a.activity_id || ' - ' ||
             wf_bobasicdataservices.fsbgetdescactivity(a.activity_id) activity_id,
             a.status_activity_id || ' - ' ||
             mo_bobasicdataservices.fsbgetdescactivitystat(a.status_activity_id) activity_status,
             c.motive_id motive_id,
             a.component_id component_id,
             a.causal_id_output || ' - ' ||
             ge_bobasicdataservices.fsbgetdesccausal(a.causal_id_output) causal_id_output,
             a.action_id || ' - ' ||
             ge_bobasicdataservices.fsbgetdescaction(a.action_id) action_id,
             c.service_number service_number,
             a.executor_log_id || ' - ' ||
             ge_bobasicdataservices.fsbgetdescerrorlog(a.executor_log_id) mensaje_error,
             a.recording_date act_recording_date,
             a.attendance_date attendance_date
        From mo_wf_comp_interfac a,
             wf_instance         b,
             mo_component        c
       Where a.activity_id = b.instance_id
         And a.component_id = c.component_id
         And a.status_activity_id = 4
         and c.package_id = nuPackage;
    -- And rownum <= 1;

    --PB MOPRP
    --Query Funcion: MO_BOFWSENTACTIVITIES.FRCGETSEARCHWFPROCSENTWOPLAN:
    Cursor cumoprp Is
      Select a.executor_log_mot_id pk,
             a.executor_log_mot_id message_proc_id,
             a.package_id Package,
             a.motive_id motive_id,
             a.action_id || ' - ' ||
             ge_bobasicdataservices.fsbgetdescaction(a.action_id) action_id,
             a.status_exec_log_id || ' - ' ||
             mo_bobasicdataservices.fsbgetdescactivitystat(a.status_exec_log_id) activity_status,
             a.executor_log_id || ' - ' ||
             ge_bobasicdataservices.fsbgetdescerrorlog(a.executor_log_id) mensaje_error,
             a.log_date log_date
        From mo_executor_log_mot a
       Where a.package_id = a.package_id
         And a.status_exec_log_id = 4
         and a.package_id = nuPackage;
    -- And rownum <= 1;

  Begin
  
    ut_trace.trace('Inicia ' || csbSP_NAME|| 'proEmpujaSolicitud' , cnuNVLTRC);
      
    onuerror        := Null;
    osberrormessage := Null;
    nuProcesado     := 0;
    For regprp In cumoprp Loop
      osberrormessage := Null;
      Begin
        nuProcesado := 1;
        --Se reenvia la actividad al flujo
        MO_BSEXECUTOR_LOG_MOT.ManualSend(regprp.pk,
                                                onuerror,
                                                osberrormessage);
        --valido si hay error y lo registro en el LOG correspondiente.
        If osberrormessage Is Not Null Then
          null;
        End If;

      Exception
        When Others Then
          osberrormessage := ' | Tramite/Solicitud: ' || regprp.package ||
                             ' Motivo: ' || regprp.motive_id ||
                             ' | Action: ' || regprp.action_id ||
                             ' | Mensaje Error: ' || regprp.mensaje_error ||
                             chr(10);
      End;
    End Loop;
    if nuProcesado = 0 then
      -- MOPWP
      For regwp In cumopwp Loop
        osberrormessage := Null;
        Begin
          --Se reenvia la actividad al flujo
          MO_BSATTENDACTIVITIES.MANUALSENDBYPACK(regwp.pk,
                                                        onuerror,
                                                        osberrormessage);
          --valido si hay error y lo registro en el LOG correspondiente.
          If osberrormessage Is Not Null Then
            null;
          End If;

        Exception
          When Others Then
            osberrormessage := ' Tramite/Solicitud: ' || regwp.package ||
                               ' | Activity: ' || regwp.activity_id ||
                               ' | Action: ' || regwp.action_id ||
                               ' | Causal de Salida: ' ||
                               regwp.causal_id_output ||
                               ' | Mensaje Error: ' || regwp.mensaje_error ||
                               chr(10);
        End;
      End Loop;
    end if;
    if nuProcesado = 0 then
      For regwm In cumopwm Loop
        osberrormessage := Null;
        nuProcesado     := 1;
        Begin
          --Se reenvia la actividad al flujo
          mo_BSAttendActivities.ManualSendByComp(regwm.pk,
                                                        onuerror,
                                                        osberrormessage);

          --valido si hay error y lo registro en el LOG correspondiente.
          If osberrormessage Is Not Null Then
            null;
          End If;

        Exception
          When Others Then
            osberrormessage := ' Motivo: ' || regwm.motive_id ||
                               ' | Activity: ' || regwm.activity_id ||
                               ' | Action: ' || regwm.action_id ||
                               ' | Causal de Salida: ' ||
                               regwm.causal_id_output ||
                               ' | Mensaje Error: ' || regwm.mensaje_error ||
                               chr(10);
        End;
      End Loop;
    end if;
    if nuProcesado = 0 then
      For regwc In cumopwc Loop
        osberrormessage := Null;
        nuProcesado     := 1;
        Begin
          --Se reenvia la actividad al flujo
          mo_BSAttendActivities.ManualSendByComp(regwc.pk,
                                                        onuerror,
                                                        osberrormessage);

          --valido si hay error y lo registro en el LOG correspondiente.
          If osberrormessage Is Not Null Then
            null;
          End If;

        Exception
          When Others Then
            osberrormessage := ' Motivo: ' || regwc.motive_id ||
                               ' | Activity: ' || regwc.activity_id ||
                               ' | Action: ' || regwc.action_id ||
                               ' | Causal de Salida: ' ||
                               regwc.causal_id_output ||
                               ' | Mensaje Error: ' || regwc.mensaje_error ||
                               chr(10);
        End;
      End Loop;
    end if;

    ut_trace.trace('Termina ' || csbSP_NAME|| 'proEmpujaSolicitud' , cnuNVLTRC);
    
  end proEmpujaSolicitud;

  PROCEDURE PRINDEPRODSUADVO(inuProducto IN NUMBER,
                             onuerror    OUT NUMBER,
                             osbError    OUT VARCHAR2) IS
    /**************************************************************************
      Proceso     : PRINDEPRODSUADVO
      Autor       : olsoftware
      Fecha       : 2020-03-16
      Ticket      : 498
      Descripcion : proceso que se encarga de validar si un producto cumple para realizar cambio de suspension

      Parametros Entrada
         inuProducto  codigo del producto
      Parametros de salida
        onuerror codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    sbDatos     VARCHAR2(1);
    nuCategoria NUMBER;
    nuestaCort  NUMBER;
    sbTipoReco  VARCHAR2(4000);

    sbcateNovali VARCHAR2(400) := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_CATENOVARP');
    sbEstaCort   VARCHAR2(400) := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_ESTACORVALSUPRP');

    CURSOR cuValidaProdSusp IS
      SELECT p.CATEGORY_ID, sesuesco
        FROM pr_product p, servsusc
       WHERE p.product_id = inuProducto
         AND sesunuse = p.product_id
         AND product_status_id = 2;

    CURSOR cuValidaTipoSusp IS
      SELECT 'X'
        FROM pr_prod_suspension
       WHERE product_id = inuProducto
         AND SUSPENSION_TYPE_ID IN (5, 11)
         AND ACTIVE = 'Y';

    CURSOR cuValidareco IS
      SELECT DECODE(S.PACKAGE_TYPE_ID,
                    100210,
                    'Voluntaria',
                    'Administrativa') tiposoli
        FROM mo_packages s, or_order_activity oa, or_order o
       WHERE oa.product_id = inuProducto
         AND s.PACKAGE_TYPE_ID IN (100210, 100346)
         AND s.package_id = oa.package_id
         AND oa.order_id = o.order_id
         AND o.order_status_id in (5, 7);

  BEGIN

    ut_trace.trace('Inicia ' || csbSP_NAME|| 'PRINDEPRODSUADVO' , cnuNVLTRC);
    
      onuerror := 0;
      --se valida si el producto esta suspendido
      if cuValidaProdSusp%isopen then
        CLOSE cuValidaProdSusp;
      end if;
      OPEN cuValidaProdSusp;
      FETCH cuValidaProdSusp
        INTO nuCategoria, nuestaCort;
      IF cuValidaProdSusp%NOTFOUND THEN
        osbError := 'Producto [' || inuProducto || '] No esta suspendido.';
        GOTO LOG;
      END IF;
      CLOSE cuValidaProdSusp;

      --se valida categoria
      IF INSTR(',' || sbcateNovali || ',', ',' || nuCategoria || ',') > 0 THEN
        osbError := 'Categoria del producto [' || inuProducto ||
                    '] No esta permitida';
        GOTO LOG;
      END IF;

      --se valida estado de corte
      IF INSTR(',' || sbEstaCort || ',', ',' || nuestaCort || ',') = 0 THEN
        osbError := 'estado de corte del producto [' || inuProducto ||
                    '] No esta permitido';
        GOTO LOG;
      END IF;

      --se valida tipo de suspension
      if cuValidaTipoSusp%isopen then
        close cuValidaTipoSusp;
      end if;
      OPEN cuValidaTipoSusp;
      FETCH cuValidaTipoSusp
        INTO sbDatos;
      IF cuValidaTipoSusp%NOTFOUND THEN
        osbError := 'Producto [' || inuProducto ||
                    '] esta suspendido por un tipo de suspension diferente a voluntaria o administrativa';
        GOTO LOG;
      END IF;
      CLOSE cuValidaTipoSusp;

      --se valida ordenes de reconexion pendiente
      if cuValidareco%isopen then
        CLOSE cuValidareco;
      end if;
      OPEN cuValidareco;
      FETCH cuValidareco
        INTO sbTipoReco;
      IF cuValidareco%FOUND THEN
        osbError := 'Producto [' || inuProducto ||
                    '] tiene ordenes de reconexion ' || sbTipoReco ||
                    ' pendientes.';
        GOTO LOG;
      END IF;
      CLOSE cuValidareco;
      --se genera log del proceso
      <<LOG>>
      if osbError is null then
        osbError := 'PRODUCTO CUMPLE CON LOS REQUISITOS';
      else
        onuerror := -1;
      end if;

      proRegistraLogValida(inuProducto, nuestaCort, osbError);
      
    ut_trace.trace('Termina ' || csbSP_NAME|| 'PRINDEPRODSUADVO' , cnuNVLTRC);      

  EXCEPTION
    WHEN pkg_Error.controlled_error THEN
      pkg_error.getError(onuerror, osbError);
    WHEN OTHERS THEN
      pkg_error.setError;
      pkg_error.getError(onuerror, osbError);
  END PRINDEPRODSUADVO;

  PROCEDURE PRJOBRECOYSUSPXPROD(inuProducto NUMBER) IS

    /**************************************************************************
     Proceso     : PRJOBRECOYSUSPXPROD
     Autor       : Olsoftware
     Fecha       : 2021-03-23
     Ticket      : 498
     Descripcion : job que asigna y legaliza ordenes de reconexion y suspension

     Parametros Entrada

     Parametros de salida

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    nuTramRerp      ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CODTRAMRERP'); --se almacena codigo del tramite de reconexion Dummy
    nuUnidOper      ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_UNIOPRECO'); --se almacena codigo de la unidad operativa
    nuCausalLega    ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CAUSLERECO'); --se almacena codigo de causal de legalizacion
    nuCausalLegFall ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CAUSDUMMYFALL'); --se almacena codigo de causal de legalizacion
    nuPersonaLega   ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_PERSLERECO'); --se almacena codigo de persona que legaliza

    nuTramiSuspRp  ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_CODTRASUSRP'); --se almacena codigo de tramite de suspension Rp
    nuEstadoRegSol ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_ESTARESO'); --se almacena codigo regsitrado de la solicitud
    sbCadenalega   VARCHAR2(4000); --se almacena cadena de legalizacion
    sbCadenaFallo  VARCHAR2(4000); --se almacena cadena de legalizacion fallo

    nuerror        NUMBER; --se almacena codigo de error
    sbError        VARCHAR2(4000); --se almacena mensaje de error
    nuClasCausal   ge_causal.class_causal_id%type; --se almacena clase de causal
    sbItemLegaReco VARCHAR2(4000); --se alamcena item de legalizacion
    Medidor        elmesesu.emsscoem%TYPE;

    nuOrdenReco    NUMBER; --se almacena orde de reconexion
    NuProducto     pr_product.product_id%type; --se almacena numero del producto
    nuOrdenRecoDum or_order.order_id%type;

    nulectura      NUMBER; --se almacena lectura de suspension
    nuTipoSuspLega NUMBER; --se almacena tipo de suspension
    nuMediRece     ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_COMEDRECE'); --se almacena medio de recepcion

    nuTipoSusp      NUMBER; --se almacena tipo de suspesion
    nuTipocausal    ldc_coactcasu.cacstica%type; --se almacena tipo de causal
    nuCausSusp      ldc_coactcasu.cacscasu%type; --se almacena causal de suspension
    nuUnidOpeSus    ldc_coactcasu.cacsunid%type; --se almacena unidad operativa
    nuCausaLegSu    ldc_coactcasu.cacscals%type; --se almacena causal de legalizacion
    nupersLegSus    ldc_coactcasu.cacspers%type; --se almacena persona que legaliza
    nuOrdenSusp     or_order.order_id%type; --se almacena orden de suspension
    nuOrderActivity or_order_activity.order_activity_id%type; --se almacena order activity de suspension
    nuSolicitud     mo_packages.package_id%type; --se almacena solicitud
    nuEstaCorRec    estacort.escocodi%type; --se almacena si el producto ien estado de corte 6 -orden de suspension
    nuIsvalid       NUMBER; --se almacena si el producto esta suspendido por Cartera
    nuTiempoEspera  ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_ESPERA'); --tiempo a espaerar generacion de orden
    nuTiempoMaximo  ldc_pararepe.parevanu%type := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_TIEMPO_MAX');
    nuTiempoTotal   number;
    nuUltActSusp    pr_product.suspen_ord_act_id%type;
    nuUltActSusMar  pr_product.suspen_ord_act_id%type;
    nuLectSuspAc    lectelme.leemleto%type;
    nuEstadoProd    pr_product.product_Status_id%type;
    sbErrorFlujo    varchar2(4000);
    nuEjecutores    number;
    nuMinEjecu      ld_parameter.numeric_value%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('NUM_EJECUTORES');
    sbMail          ldc_pararepe.paravast%type := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_MAIL_CAMBIO_TIPOSUSP');
    sbCountUsuario  number;

    --variabe para estaproc
    nuparano  NUMBER;
    nuparmes  NUMBER;
    nutsess   NUMBER;
    sbparuser VARCHAR2(400);

    --variables para validar condiciones de facturacion y cartera
    sbPefaactu      varchar2(1);
    nuPerifact      perifact.pefacodi%type;
    nuPeriCons      pericose.pecscons%type;
    sbErrorFact     varchar2(4000);
    sbErrorComp     varchar2(4000);
    sbCompsus       varchar2(1);
    NOMBRE_BD       varchar2(100);
    nuSalir         number;
    nuMaxIntento    NUMBER := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_NUINPROCJOB');
    sbMotivoSuspVol VARCHAR2(400) := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_MOTISUSVOLU');
    sbMotivoSuspAdm VARCHAR2(400) := pkg_BCLDC_ParaRePe.fsbObtieneValorCadena('LDC_MOTISUSADMIN');
    nuSolReco       mo_packages.package_id%type;
    --se consulta productos pendientes
    CURSOR cugetProdPendReco Is
      select *
        from (SELECT LDC_PRODRERP.rowid idreg,
                     PRREPROD,
                     SESUCICL,
                     SESUCICO,
                     PRREACTI,
                     NVL(PRREINTE, 0) INTENTO
                FROM LDC_PRODRERP, SERVSUSC S
               WHERE PRREPROC = 'N'
                 AND SESUNUSE = PRREPROD
                 AND SESUNUSE = inuProducto
                 AND PRREFUEN = 'SUSPADMIVOLU' --CA 498 se coloca nuevo filtro
                 AND NVL(PRREINTE, 0) <= nuMaxIntento
               order by sesucicl);

    --se obtiene solicitud de reconexion del producto
    CURSOR cugetSoliRecon(nuProd pr_product.product_id%type,
                          numSol mo_packages.package_id%type) IS
      SELECT s.PACKAGE_ID
        FROM mo_packages s, mo_motive m
       WHERE s.package_id = m.package_id
         AND s.package_type_id = nuTramRerp
         AND s.motive_Status_id = nuEstadoRegSol
         and m.product_id = nuProd
         and s.package_id = numSol;

    --se obtiene orden de reconexion del producto
    CURSOR cuOrdenRecoDummy(nuProd pr_product.product_id%type,
                            nuSol  mo_packages.package_id%type) IS
      SELECT OA.order_id
        FROM or_order_activity oa
       WHERE oa.package_id = nuSol
         AND oa.product_id = nuProd;

    --se obtiene orden de reconexion
    CURSOR cugetOrdeRecon(nuOt or_order.order_id%type) IS
      SELECT o.order_id, OA.PRODUCT_ID, OA.ORDER_ACTIVITY_ID, OA.PACKAGE_ID
        FROM or_order_activity oa, or_order o
       WHERE oa.order_id = o.order_id
         AND o.order_status_id = Or_BOConstants.CNUORDER_STAT_REGISTERED
         and o.order_id = nuOt;

    --se obtiene orden de sspension con error
    CURSOR cugetOrdeSuspen IS
      SELECT o.order_id, OA.PRODUCT_ID, OA.ORDER_ACTIVITY_ID
        FROM or_order_activity oa, or_order o, mo_packages s
       WHERE s.package_id = oa.package_id
         AND s.package_type_id = nuTramiSuspRp
         AND oa.order_id = o.order_id
         AND o.order_status_id = Or_BOConstants.CNUORDER_STAT_REGISTERED
         AND s.COMMENT_ = 'CAMBIO DE SUSPENSION DE CARTERA A RP';

    --se obtiene productos reconectados a suspender
    CURSOR cuGenerarSuspen IS
      SELECT product_id FROM ldc_prodreasu WHERE estasusp = 'N';

    --se consulta medidor actual
    CURSOR cuMedidorAct IS
      SELECT emsscoem
        FROM elmesesu
       WHERE emsssesu = NuProducto
         AND sysdate between EMSSFEIN AND EMSSFERE;

    --se obtiene tipo de suspension
    CURSOR cugetTiposusp IS
      SELECT Suspension_Type_Id
        FROM Pr_Prod_Suspension PS
       WHERE PS.Product_Id = NuProducto
         AND Active = 'Y';

    -- se valida la clasificacion de la causal
    CURSOR cuTipoCausal(nuCausal ge_causal.CAUSAL_ID%TYPE) IS
      SELECT DECODE(CLASS_CAUSAL_ID, 1, 1, 2, 0) tipo
        FROM ge_causal
       WHERE CAUSAL_ID = nuCausal;

    --se obtiene configurcion de forma LDCCACASU
    CURSOR cugetConfiActSusp(sbRowid varchar2) IS
      SELECT conf.cacstica,
             conf.cacscasu,
             conf.cacsunid,
             conf.cacscals,
             conf.cacspers
        FROM ldc_coactcasu     conf,
             ldc_prodrerp      p,
             or_order_activity oa
       WHERE oa.order_activity_id = p.prreacti
         AND conf.cacsacti = oa.activity_id
         AND p.prreprod = NuProducto
         and p.rowid = sbRowid;

    --se obtiene orden de suspension
    CURSOR cugetOrdeSusp IS
      SELECT oa.order_id, oa.order_activity_id
        FROM or_order_activity oa
       WHERE oa.package_id = nuSolicitud;

    --se valia el periodo de facturacion
    cursor cuPerifact(nuCiclo number) is
      select pefaactu
        from perifact
       where pefacicl = nuCiclo
         and sysdate between pefafimo and pefaffmo;

    CURSOR cuPeriodoCons(nuCiclo number) IS
      SELECT PECSCONS
        FROM PERICOSE
       WHERE PECSCICO = nuCiclo
         AND sysdate BETWEEN PECSFECI AND PECSFECF;

    --se obtiene orden de reconexion
    CURSOR cugetOrdeRecon2 IS
      SELECT o.order_id,
             OA.PRODUCT_ID,
             OA.ORDER_ACTIVITY_ID,
             OA.PACKAGE_ID,
             o.order_status_id
        FROM or_order_activity oa, or_order o, mo_packages s
       WHERE s.package_id = oa.package_id
         AND s.package_type_id = nuTramRerp
         AND oa.order_id = o.order_id
         AND o.order_status_id in (0, 5)
         and s.motive_Status_id = nuEstadoRegSol
         AND OA.PRODUCT_ID = inuProducto
         and exists (select null
                from LDC_PRODRERP r
               where r.prreprod = oa.product_id
                 and r.prreproc = 'S'
                 and r.prreobse != 'X'
                 AND PRREFUEN = 'SUSPADMIVOLU');

    --se obtienen los componentes del producto
    CURSOR cuComProd(nuProd pr_product.product_id%type) is
      select p.product_id,
             p.component_id,
             p.component_status_id,
             c.cmssescm
        from pr_component p, compsesu c
       where p.product_id = c.cmsssesu
         and c.cmssidco = p.component_id
         and c.cmssfere > sysdate
         and p.product_id = nuProd;

    --se obtienen
    CURSOR cuSuspenCompo(nuComp pr_component.component_id%type) is
      select c.suspension_type_id
        from pr_comp_suspension c
       where component_id = nuComp
         and active = 'Y';

    PROCEDURE resetVariables IS

    BEGIN
      ut_trace.trace('Inicia ' || csbSP_NAME|| 'PRJOBRECOYSUSPXPROD.resetVariables' , cnuNVLTRC);    
      nuTipoSusp      := NULL;
      nuTipocausal    := NULL;
      nuCausSusp      := NULL;
      nuUnidOpeSus    := NULL;
      nuCausaLegSu    := NULL;
      nupersLegSus    := NULL;
      nulectura       := NULL;
      nuClasCausal    := NULL;
      Medidor         := NULL;
      nuSolicitud     := null;
      nuOrdenSusp     := null;
      nuOrderActivity := null;
      nuUltActSusp    := NULL;
      nuSolReco       := null;
      ut_trace.trace('Termina ' || csbSP_NAME|| 'PRJOBRECOYSUSPXPROD.resetVariables' , cnuNVLTRC);      
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END resetVariables;

    PROCEDURE prInsertProduProce(nuUltActiSusp IN NUMBER,
                                 nuIntento     IN NUMBER) IS
      PRAGMA AUTONOMOUS_TRANSACTION;
      sbWhat VARCHAR2(4000);
      nujob  NUMBER;
      nuHora NUMBER := pkg_BCLDC_ParaRePe.fnuObtieneValorNumerico('LDC_HORAPRJOB');
    BEGIN

      ut_trace.trace('Inicia ' || csbSP_NAME|| 'PRJOBRECOYSUSPXPROD.prInsertProduProce' , cnuNVLTRC);    
    
      INSERT INTO LDC_PRODRERP
        (PRREPROD,
         PRREACTI,
         PRREFEGE,
         PRREPROC,
         PRREOBSE,
         PRREFUEN,
         PRREINTE)
      VALUES
        (inuproducto,
         nuUltActiSusp,
         SYSDATE,
         'N',
         'MARCADO PARA REPROCESAR EN JOB PRJOBRECOYSUSPXPROD',
         'SUSPADMIVOLU',
         nuIntento);

      --se programa hilo
      sbWhat := 'BEGIN' || ' ' ||
                'LDC_PKGESTIONCASURP.PRJOBRECOYSUSPXPROD(' || ' ' ||
                inuproducto || ' ' || ');' || ' ' || 'EXCEPTION' || ' ' ||
                'WHEN LOGIN_DENIED OR PKG_ERROR.CONTROLLED_ERROR THEN' || ' ' ||
                'RAISE;' || ' ' || 'WHEN OTHERS THEN' || ' ' ||
                'pkg_error.setError;' || ' ' || 'RAISE pkg_Error.controlled_error;' || ' ' ||
                'END;';

      dbms_job.submit(nujob, sbWhat, sysdate + nuHora / 24); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)

      COMMIT;
      
      ut_trace.trace('Termina ' || csbSP_NAME|| 'PRJOBRECOYSUSPXPROD.prInsertProduProce' , cnuNVLTRC);    
      
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
    END prInsertProduProce;
  BEGIN
  
    ut_trace.trace('Inicia ' || csbSP_NAME|| 'PRJOBRECOYSUSPXPROD' , cnuNVLTRC);    
  
    dbms_output.disable();

    -- Consultamos datos para inicializar el proceso
    SELECT to_number(to_char(SYSDATE, 'YYYY')),
           to_number(to_char(SYSDATE, 'MM')),
           userenv('SESSIONID'),
           USER
      INTO nuparano, nuparmes, nutsess, sbparuser
      FROM dual;

    NOMBRE_BD := UT_DBINSTANCE.FSBGETCURRENTINSTANCETYPE;
    if NOMBRE_BD != 'P' then
      NOMBRE_BD := 'PRUEBAS: ';
    ELSE
      NOMBRE_BD := NULL;
    end if;
    -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,
                           nuparmes,
                           'PRJOBRECOYSUSPXPROD',
                           'En ejecucion',
                           nutsess,
                           sbparuser);

    sbCountUsuario := 0;
    FOR reg IN cugetProdPendReco LOOP
      begin
        select count(1) as CANTIDAD
          into nuEjecutores
          from gv$session s
         where s.module = 'EXECUTOR_PROCESS'
           and s.username = 'OPEN';
      exception
        when others then
          nuEjecutores := 0;
      end;
      if nuEjecutores < nuMinEjecu then
        UPDATE LDC_PRODRERP
           SET PRREPROC = 'S',
               PRREOBSE = 'NO ESTA LA CANTIDAD MINIMA DE EJECUTORES ARRIBA',
               PRREFEPR = SYSDATE
         WHERE rowid = reg.idreg;
        commit;
        prInsertProduProce(REG.PRREACTI, REG.INTENTO + 1);

        pkg_Correo.prcEnviaCorreo
        (
            isbRemitente        => sbRemitente,
            isbDestinatarios    => sbMail,
            isbAsunto           => 'Error Job de Cambio de Suspension RP',
            isbMensaje          => NOMBRE_BD ||
                    'Se tiene problemas con los ejecutores favor validar'
        );
        ldc_proactualizaestaprog(nutsess,
                                 SBERROR,
                                 'PRJOBRECOYSUSPXPROD',
                                 'No estan el minimo de ejecutores arriba');
        --end if;
      else
        nuSalir := 0;
        IF gbCiclo <> reg.sesucicl THEN
          gbCiclo     := reg.sesucicl;
          sbErrorFact := NULL;
          sbPefaactu  := NULL;
          nuPeriCons  := NULL;

          IF cuPeriodoCons%ISOPEN THEN
            CLOSE cuPeriodoCons;
          END IF;

          IF cuPerifact%ISOPEN THEN
            CLOSE cuPerifact;
          END IF;

          --valida si la fecha actual esta en periodo de facturacion actual
          open cuPerifact(reg.sesucicl);
          fetch cuPerifact
            into sbPefaactu;
          if cuPerifact%notfound then
            sbErrorFact := 'La fecha actual no se encuentra en los periodos de facturacion del ciclo ' ||
                           reg.sesucicl;
          else
            if sbPefaactu = 'N' then
              sbErrorFact := 'La fecha actual no se encuentra dentro del periodo de facturacion actual del ciclo ' ||
                             reg.sesucicl;
            else
              OPEN cuPeriodoCons(reg.sesucicl);
              FETCH cuPeriodoCons
                INTO nuPeriCons;
              IF cuPeriodoCons%NOTFOUND THEN
                sbErrorFact := 'El ciclo de consumo ' || reg.sesucico ||
                               ' no tiene un periodo de consumo vigente';
              END IF;
              CLOSE cuPeriodoCons;

            END IF;
          END IF;
          CLOSE cuPerifact;
        end if;

        IF sbErrorFact IS NOT NULL THEN
          UPDATE LDC_PRODRERP
             SET PRREPROC = 'S', PRREOBSE = sbErrorFact, PRREFEPR = SYSDATE
           WHERE rowid = reg.idreg;
          commit;
          prInsertProduProce(REG.PRREACTI, REG.INTENTO + 1);

        ELSE
          begin
            nuError      := null;
            sberror      := null;
            nuEstaCorRec := null;
            nuIsvalid    := null;
            sbErrorFact  := null;
            sbErrorComp  := null;
            sbPefaactu   := null;
            nuPerifact   := null;
            nuPeriCons   := null;
            resetVariables;
            UPDATE LDC_PRODRERP SET PRREOBSE = 'X' WHERE rowid = reg.idreg;
            commit;
            --se valida si el producto esta suspendido por cartera
            LDC_PKGESTIONCASURP.PRINDEPRODSUADVO(reg.PRREPROD,
                                                 nuError,
                                                 sberror);

            IF nuError = 0 THEN
              for comp in cuComProd(reg.PRREPROD) loop
                if comp.component_status_id != 8 or comp.cmssescm != 8 then
                  sbErrorComp := 'Error con los componentes del producto validar';
                end if;
                sbCompsus := null;
                for compsus in cuSuspenCompo(comp.component_id) loop
                  sbCompsus := 'S';
                  if compsus.suspension_type_id NOT IN (5, 11, 2) then
                    sbErrorComp := 'Error con los componentes del producto validar';
                    exit;
                  end if;
                end loop;

                if sbErrorComp is not null then
                  exit;
                end if;
              end loop;
              --se genera orden de reconexion
              if sbErrorComp is null then
                --se legaliza ordenes de reconexion
                PRLEGAORDRECVOL(reg.PRREPROD, nuError, sberror);
                IF nuError <> 0 THEN
                  ROLLBACK;
                  sbErrorComp := sberror;
                ELSE
                  LDC_PKGESTIONCASURP.PRGENRECORP(reg.PRREPROD,
                                                  0,
                                                  nuError,
                                                  sberror,
                                                  nuSolReco);
                END IF;
                IF nuError = 0 THEN
                  open cugetlecturaSusp(reg.prreprod);
                  fetch cugetlecturaSusp
                    into nulectura;
                  if cugetlecturaSusp%notfound then
                    nulectura := null;
                  end if;
                  close cugetlecturaSusp;
                  if nuLectura is null then
                    OPEN cugetlecturaFact(reg.prreprod);
                    FETCH cugetlecturaFact
                      INTO nulectura;
                    CLOSE cugetlecturaFact;

                    IF nulectura IS NULL THEN
                      ROLLBACK;
                      sbErrorComp := 'No se encontro lectura asociada a la ultima actividad de suspension del producto';
                    END IF;
                  end if;
                  if sbErrorComp is null then
                    IF cugetConfiActSusp%ISOPEN THEN
                      CLOSE cugetConfiActSusp;
                    END IF;
                    --se obtiene configuracion de actividad de suspension de cartera
                    NuProducto := reg.prreprod;
                    OPEN cugetConfiActSusp(reg.idreg);
                    FETCH cugetConfiActSusp
                      INTO nuTipocausal,
                           nuCausSusp,
                           nuUnidOpeSus,
                           nuCausaLegSu,
                           nupersLegSus;
                    IF cugetConfiActSusp%FOUND THEN
                      COMMIT;
                    ELSE
                      ROLLBACK;
                      sbErrorComp := 'No se encontro configuracion de cambio de tipo de suspension, validar forma LDCCACASU';
                    END IF;
                  end if;
                ELSE
                  ROLLBACK;
                  sbErrorComp := sberror;
                END IF;
              end if;
              if sbErrorComp is not null then
                UPDATE LDC_PRODRERP
                   SET PRREPROC = 'S',
                       PRREOBSE = sbErrorComp,
                       PRREFEPR = SYSDATE
                 WHERE rowid = reg.idreg;
                commit;

                prInsertProduProce(REG.PRREACTI, REG.INTENTO + 1);
              else
                ------empieza proceso de legalizacion de recoxion
                for reco in cugetSoliRecon(reg.prreprod, nuSolReco) loop
                  nuOrdenRecoDum := null;
                  nuTiempoTotal  := 0;
                  sbErrorFlujo   := null;
                  while nuOrdenRecoDum is null loop
                    open cuOrdenRecoDummy(reg.prreprod, reco.package_id);
                    fetch cuOrdenRecoDummy
                      into nuOrdenRecoDum;
                    close cuOrdenRecoDummy;
                    IF nuOrdenRecoDum is null then
                      DBMS_LOCK.SLEEP(nuTiempoEspera);
                      nuTiempoTotal := nuTiempoTotal + nuTiempoEspera;
                      LDC_PKGESTIONCASURP.proEmpujaSolicitud(reco.package_id,
                                                             sbErrorFlujo);
                      if sbErrorFlujo is not null then
                        UPDATE LDC_PRODRERP
                           SET PRREPROC = 'S',
                               PRREOBSE = 'ERROR FLUJOS ' || sbErrorFlujo,
                               PRREFEPR = SYSDATE
                         WHERE rowid = reg.idreg;
                        commit;
                        prInsertProduProce(REG.PRREACTI, REG.INTENTO + 1);
                        GOTO salir;
                      end if;
                      if nuTiempoTotal > nuTiempoMaximo then
                        UPDATE LDC_PRODRERP
                           SET PRREPROC = 'S',
                               PRREOBSE = 'SE PRESENTARON DEMORAS AL GENERAR OT RECON DUMMY, SE LEGALIZARA CON FALLO',
                               PRREFEPR = SYSDATE
                         WHERE rowid = reg.idreg;
                        commit;
                        prInsertProduProce(REG.PRREACTI, REG.INTENTO + 1);
                        GOTO salir;
                      end if;
                    end if;
                  end loop;

                  ---
                  FOR regOt IN cugetOrdeRecon(nuOrdenRecoDum) LOOP
                    resetVariables; --Se setean variables
                    NuProducto  := regOt.product_id;
                    nuOrdenreco := regOt.order_id;

                    --se asigan orden de reconexion
                    API_ASSIGN_ORDER(nuOrdenreco,
                                    nuUnidOper,
                                    nuerror,
                                    SBERROR);

                    IF nuerror <> 0 THEN
                      proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPXPROD-ASIGRECO',
                                                   SYSDATE,
                                                   nuOrdenReco,
                                                   NULL,
                                                   sberror,
                                                   USER);
                      ROLLBACK;
                      update ldc_PRODRERP
                         SET PRREPROC = 'S',
                             PRREOBSE = 'SE LEGALIZA CON FALLO LA RECONEXION DUMMY POR ERROR, VALIDAR LOG',
                             PRREFEPR = SYSDATE
                       WHERE rowid = reg.idreg;
                      commit;
                      prInsertProduProce(REG.PRREACTI, REG.INTENTO + 1);
                    ELSE
                      commit;

                      dbms_lock.sleep(1);
                      nuerror := null;
                      SBERROR := null;

                      if nuTiempoTotal > nuTiempoMaximo then
                        LDC_PKGESTIONCASURP.PRINDEPRODSUADVO(reg.PRREPROD,
                                                             nuerror,
                                                             SBERROR);
                        if nuerror != 0 then
                          nuCausalLega := nuCausalLegFall;
                        end if;
                        begin
                          select p.suspen_ord_act_id
                            into nuUltActSusp
                            from pr_product p
                           where p.product_id = NuProducto;
                        exception
                          when others then
                            nuUltActSusp := null;
                        end;

                        begin
                          select PRREACTI
                            into nuUltActSusMar
                            from ldc_PRODRERP
                           where PRREPROD = NuProducto;
                        exception
                          when others then
                            nuUltActSusMar := null;
                        end;

                        if nvl(nuUltActSusp, 0) != nvl(nuUltActSusMar, 0) then
                          SELECT LEEMLETO
                            into nuLectSuspAc
                            FROM (SELECT LE.LEEMLETO
                                    FROM LECTELME le
                                   WHERE LE.LEEMSESU = NuProducto
                                     AND le.LEEMDOCU = nuUltActSusp
                                   ORDER BY LE.LEEMFELE DESC)
                           WHERE ROWNUM < 2;

                          if nuLectSuspAc is not null then
                            update ldc_PRODRERP
                               set PRREACTI = nuUltActSusp
                             where PRREPROD = NuProducto
                               AND PRREPROC = 'N';
                          else
                            OPEN cugetlecturaFact(NuProducto);
                            FETCH cugetlecturaFact
                              INTO nuLectSuspAc;
                            CLOSE cugetlecturaFact;
                            IF nuLectSuspAc IS NULL THEN
                              nuCausalLega := nuCausalLegFall;
                            ELSE
                              update ldc_PRODRERP
                                 set PRREACTI = nuUltActSusp
                               where PRREPROD = NuProducto
                                 AND PRREPROC = 'N';
                            END IF;
                          end if;

                        end if;
                      end if;
                      --se valida clase de causal
                      OPEN cuTipoCausal(nuCausalLega);
                      FETCH cuTipoCausal
                        INTO nuClasCausal;
                      CLOSE cuTipoCausal;

                      --se obtiene lectura de suspension
                      OPEN cugetlecturaSusp(NuProducto);
                      FETCH cugetlecturaSusp
                        INTO nulectura;
                      CLOSE cugetlecturaSusp;

                      IF nulectura IS NULL THEN
                        OPEN cugetlecturaFact(NuProducto);
                        FETCH cugetlecturaFact
                          INTO nulectura;
                        CLOSE cugetlecturaFact;
                      END IF;

                      --se obtiene medidor del producto
                      OPEN cuMedidorAct;
                      FETCH cuMedidorAct
                        INTO medidor;
                      CLOSE cuMedidorAct;

                      --se obtiene el tipo de suspension
                      OPEN cugetTiposusp;
                      FETCH cugetTiposusp
                        INTO nuTipoSuspLega;
                      CLOSE cugetTiposusp;
                      sbCadenaFallo := nuOrdenreco || '|' ||
                                       nuCausalLegFall || '|' ||
                                       nuPersonaLega || '||' ||
                                       regOt.ORDER_ACTIVITY_ID || '>' || 0 ||
                                       ';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|' ||
                                       NVL(sbItemLegaReco, '') ||
                                       '||1277;Orden Legalizada por proceso PRJOBRECOYSUSPRP';

                      IF nuClasCausal > 0 THEN
                        sbCadenalega := nuOrdenreco || '|' || nuCausalLega || '|' ||
                                        nuPersonaLega || '||' ||
                                        regOt.ORDER_ACTIVITY_ID || '>' ||
                                        nuClasCausal || ';READING>' ||
                                        NVL(nuLectura, '') ||
                                        '>9>;SUSPENSION_TYPE>' ||
                                        NVL(nuTipoSuspLega, '') || '>>;;|' ||
                                        NVL(sbItemLegaReco, '') || '|' ||
                                        Medidor || ';1=' ||
                                        NVL(nulectura, '') || '=T===|' ||
                                        '1277;Orden Legalizada por proceso PRJOBRECOYSUSPRP';
                      else
                        sbCadenalega := sbCadenaFallo;
                      END IF;
                      --se legaliza orden de trabajo
                      delete ldc_ordeasigproc
                       where orapsoge = reco.package_id
                         and oraoproc = 'CAMBTISU';
                      api_legalizeorders(sbCadenalega,
                                        sysdate - 1 / 24 / 60,
                                        sysdate - 1 / 24 / 60,
                                        null,
                                        nuerror,
                                        SBERROR);

                      IF nuerror <> 0 THEN
                        proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPXPROD-LEGARECO',
                                                     SYSDATE,
                                                     nuOrdenReco,
                                                     NULL,
                                                     sberror,
                                                     USER);
                        ROLLBACK;
                        nuerror := null;
                        SBERROR := null;
                        api_legalizeorders(sbCadenaFallo,
                                          sysdate,
                                          sysdate,
                                          null,
                                          nuerror,
                                          SBERROR);
                        if nuerror = 0 then
                          commit;
                          UPDATE LDC_PRODRERP
                             SET PRREPROC = 'S',
                                 PRREOBSE = 'SE LEGALIZA CON FALLO LA RECONEXION DUMMY POR ERROR, VALIDAR LOG',
                                 PRREFEPR = SYSDATE
                           WHERE rowid = reg.idreg;
                          commit;
                          prInsertProduProce(NVL(nuUltActSusp,
                                                 REG.PRREACTI),
                                             REG.INTENTO + 1);
                        else
                          rollback;
                          proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPXPROD-LEGARECO',
                                                       SYSDATE,
                                                       nuOrdenReco,
                                                       NULL,
                                                       SBERROR,
                                                       USER);
                          UPDATE LDC_PRODRERP
                             SET PRREPROC = 'S',
                                 PRREOBSE = 'SE LEGALIZARA CON FALLO LA RECONEXION DUMMY POR ERROR, VALIDAR LOG',
                                 PRREFEPR = SYSDATE
                           WHERE rowid = reg.idreg;
                          commit;
                          prInsertProduProce(NVL(nuUltActSusp,
                                                 REG.PRREACTI),
                                             REG.INTENTO + 1);
                        end if;
                      ELSE
                        nuEstadoProd := 2;
                        WHILE nuEstadoProd != 1 LOOP
                          BEGIN
                            SELECT PRODUCT_STATUS_ID
                              INTO nuEstadoProd
                              FROM PR_PRODUCT P
                             WHERE P.PRODUCT_ID = NuProducto;
                            if nuEstadoProd != 1 then
                              dbms_lock.sleep(nuTiempoEspera);
                              nuTiempoTotal := nuTiempoTotal +
                                               nuTiempoEspera;
                              if nuTiempoTotal > nuTiempoMaximo then
                                ROLLBACK;
                                UPDATE LDC_PRODRERP
                                   SET PRREPROC = 'S',
                                       PRREOBSE = 'SE PRESENTARON DEMORAS AL CAMBIAR ESTADO PRODUCTO, OT RECON DUMMY SE LEGALIZARA CON FALLO',
                                       PRREFEPR = SYSDATE
                                 WHERE rowid = reg.idreg;
                                commit;
                                prInsertProduProce(NVL(nuUltActSusp,
                                                       REG.PRREACTI),
                                                   REG.INTENTO + 1);
                                GOTO salir;
                              end if;
                            end if;
                          EXCEPTION
                            WHEN OTHERS THEN
                              nuEstadoProd := 2;
                          END;

                        END LOOP;
                        ------EMPIEZA GENERACION SUSPENSION
                        IF cugetConfiActSusp%ISOPEN THEN
                          CLOSE cugetConfiActSusp;
                        END IF;
                        --se obtiene configuracion de actividad de suspension de cartera
                        OPEN cugetConfiActSusp(reg.idreg);
                        FETCH cugetConfiActSusp
                          INTO nuTipocausal,
                               nuCausSusp,
                               nuUnidOpeSus,
                               nuCausaLegSu,
                               nupersLegSus;
                        IF cugetConfiActSusp%FOUND THEN
                          nuTipoSusp := NVL(ldci_pkrevisionperiodicaweb.fnutiposuspension(NuProducto),
                                            101);
                          --se crea orden de suspension

                          nuSolicitud := fnuGeneTramSuspRP(NuProducto,
                                                           nuMediRece,
                                                           nuTipocausal,
                                                           nuCausSusp,
                                                           nuTipoSusp,
                                                           'CAMBIO DE SUSPENSION DE CARTERA A RP',
                                                           nuerror,
                                                           SBERROR);
                          IF nuerror <> 0 THEN
                            proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPXPROD-TRAMSUSPRP',
                                                         SYSDATE,
                                                         nuOrdenReco,
                                                         NULL,
                                                         sberror,
                                                         USER);
                            ROLLBACK;
                            UPDATE LDC_PRODRERP
                               SET PRREPROC = 'S',
                                   PRREOBSE = 'ERROR GENERANDO TRAMITE DE SUSPENSION:' ||
                                              SBERROR,
                                   PRREFEPR = SYSDATE
                             WHERE rowid = reg.idreg;
                            COMMIT;
                            prInsertProduProce(NVL(nuUltActSusp,
                                                   REG.PRREACTI),
                                               REG.INTENTO + 1);
                          ELSE
                            COMMIT;
                            dbms_lock.sleep(nuTiempoEspera);
                            nuTiempoTotal := nuTiempoTotal + nuTiempoEspera;
                            sbErrorFlujo  := NULL;
                            --se obtiene orden de suspension
                            WHILE nuOrdenSusp IS NULL LOOP
                              OPEN cugetOrdeSusp;
                              FETCH cugetOrdeSusp
                                INTO nuOrdenSusp, nuOrderActivity;
                              CLOSE cugetOrdeSusp;
                              IF nuOrdenSusp is null then
                                DBMS_LOCK.SLEEP(nuTiempoEspera);
                                nuTiempoTotal := nuTiempoTotal +
                                                 nuTiempoEspera;
                                LDC_PKGESTIONCASURP.proEmpujaSolicitud(nuSolicitud,
                                                                       sbErrorFlujo);
                              end if;
                              dbms_lock.sleep(nuTiempoEspera);
                              nuTiempoTotal := nuTiempoTotal +
                                               nuTiempoEspera;
                            END LOOP;

                            ut_trace.trace('ORDEN DE SUSPENSION '||nuOrdenSusp , cnuNVLTRC);  
                                
                            IF nuOrdenSusp IS NOT NULL THEN
                              nuerror := null;
                              SBERROR := null;
                              delete ldc_bloq_lega_solicitud se
                               where se.package_id_gene = nuSolicitud;

                               ut_trace.trace('nuUnidOpeSus '||nuUnidOpeSus||' nuCausaLegSu '||nuCausaLegSu||' nupersLegSus '||nupersLegSus||' nuLectura '||nuLectura , cnuNVLTRC);  
                            
                              --se asigna y legaliza orden de suspension
                              prAsigLegOrdSusp(nuOrdenSusp,
                                               nuOrderActivity,
                                               nuUnidOpeSus,
                                               nuCausaLegSu,
                                               nupersLegSus,
                                               nuLectura,
                                               NULL,
                                               Medidor,
                                               'Orden Legalizada por proceso PRJOBRECOYSUSPXPROD',
                                               nuerror,
                                               SBERROR);

                              IF nuerror <> 0 THEN
                                proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPXPROD-ASIGLEGSUSP',
                                                             SYSDATE,
                                                             nuOrdenSusp,
                                                             nuOrdenReco,
                                                             sberror,
                                                             USER);
                                ROLLBACK;
                                UPDATE LDC_PRODRERP
                                   SET PRREPROC = 'S',
                                       PRREOBSE = 'ERROR LEGALIZANDO OT SUSPENSION, VALIDAR LOG',
                                       PRREFEPR = SYSDATE
                                 WHERE rowid = reg.idreg;
                                COMMIT;
                                --se borra producto excluido
                                DELETE FROM LDC_PRODEXCLRP
                                 where PRODUCT_ID = REG.PRREPROD
                                   AND MOTIVO IN
                                       (sbMotivoSuspVol, sbMotivoSuspAdm);
                                commit;
                                --prInsertProduProce(NVL(nuUltActSusp,REG.PRREACTI), REG.INTENTO + 1);
                                nuSalir := 1;
                                IF NOMBRE_BD IS NULL THEN
                                    pkg_Correo.prcEnviaCorreo
                                    (
                                        isbRemitente        => sbRemitente,
                                        isbDestinatarios    => sbMail,
                                        isbAsunto           => 'URGENTE!!! Error Job de Cambio de Suspension RP',
                                        isbMensaje          => NOMBRE_BD ||
                                                'Se tiene problemas legalizando la orden de suspension: ' ||
                                                nuOrdenSusp ||
                                                ' el programa terminara'
                                    );
                                ELSE
                                    pkg_Correo.prcEnviaCorreo
                                    (
                                        isbRemitente        => sbRemitente,
                                        isbDestinatarios    => sbMail,
                                        isbAsunto           => 'Error Job de Cambio de Suspension RP',
                                        isbMensaje          => NOMBRE_BD ||
                                                'Se tiene problemas legalizando la orden de suspension: ' ||
                                                nuOrdenSusp ||
                                                ' el programa terminara'
                                    );
                                END IF;
                              ELSE
                                commit;
                                dbms_lock.sleep(2);
                                DELETE FROM LDC_DEFCRI_NOREPARABLE
                                 WHERE ID_PRODUCTO = REG.PRREPROD;
                                --se borra producto excluido
                                DELETE FROM LDC_PRODEXCLRP
                                 where PRODUCT_ID = REG.PRREPROD
                                   AND MOTIVO IN
                                       (sbMotivoSuspVol, sbMotivoSuspAdm);
                                commit;

                                --se realizaa tramite de rp
                                PRGENETRAMRP(REG.PRREPROD,
                                             nuMediRece,
                                             'Solicitud generada por proceso PRJOBRECOYSUSPXPROD',
                                             nuerror,
                                             SBERROR);
                                IF nuerror <> 0 THEN
                                  proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPXPROD-PRGENETRAMRP',
                                                               SYSDATE,
                                                               nuOrdenSusp,
                                                               nuOrdenReco,
                                                               sberror,
                                                               USER);
                                  ROLLBACK;
                                  UPDATE LDC_PRODRERP
                                     SET PRREPROC = 'S',
                                         PRREOBSE = 'ERROR GENERANDO TRAMITE DE RP, VALIDAR LOG',
                                         PRREFEPR = SYSDATE
                                   WHERE rowid = reg.idreg;
                                  COMMIT;
                                  --prInsertProduProce(NVL(nuUltActSusp,REG.PRREACTI), REG.INTENTO + 1);
                                  nuSalir := 1;
                                  IF NOMBRE_BD IS NULL THEN
                                    pkg_Correo.prcEnviaCorreo
                                    (
                                        isbRemitente        => sbRemitente,
                                        isbDestinatarios    => sbMail,
                                        isbAsunto           => 'URGENTE!!! Error Job de Cambio de Suspension RP',
                                        isbMensaje          => NOMBRE_BD ||
                                                  'Se tiene problemas generando tramite de Rp para producto [' ||
                                                  REG.PRREPROD ||
                                                  '] el programa terminara'
                                    );
                                  ELSE
                                    pkg_Correo.prcEnviaCorreo
                                    (
                                        isbRemitente        => sbRemitente,
                                        isbDestinatarios    => sbMail,
                                        isbAsunto           => 'Error Job de Cambio de Suspension RP',
                                        isbMensaje          => NOMBRE_BD ||
                                                  'Se tiene problemas generando tramite de Rp para producto [' ||
                                                  REG.PRREPROD ||
                                                  '] el programa terminara'
                                    );
                                  END IF;
                                ELSE
                                  DELETE FROM LDC_DEFCRI_NOREPARABLE
                                   WHERE ID_PRODUCTO = REG.PRREPROD;
                                  UPDATE LDC_PRODRERP
                                     SET PRREPROC = 'S',
                                         PRREOBSE = 'PROCESADO CON EXITO',
                                         PRREFEPR = SYSDATE
                                   WHERE rowid = reg.idreg;
                                  COMMIT;
                                END IF;
                                --
                              END IF;
                            END IF;

                          END IF;
                        END IF;
                        CLOSE cugetConfiActSusp;
                        -----TERMINA GENERACION SUSPENSION

                      END IF;
                    END IF;

                  END LOOP;
                  ---

                end loop;

                ------termina proceso de legalizacioni de orden de reconexion
              end if;
            ELSE
              UPDATE LDC_PRODRERP
                 SET PRREPROC = 'S',
                     PRREOBSE = 'NO CUMPLE REQUISITO PARA GENERACION, VALIDAR LOG',
                     PRREFEPR = SYSDATE
               WHERE rowid = reg.idreg;
              prInsertProduProce(NVL(nuUltActSusp, REG.PRREACTI),
                                 REG.INTENTO + 1);

              commit;
            END IF;
            <<salir>>
            if nuSalir = 1 then
              exit;
            end if;

          exception
            when others then
              rollback;
          end;
          --   END LOOP;

        END IF;
      END IF;
    END LOOP;
    dbms_lock.sleep(nuTiempoEspera);
    FOR reg IN cugetOrdeRecon2 LOOP
      resetVariables; --Se setean variables
      NuProducto  := reg.product_id;
      nuOrdenreco := reg.order_id;
      nuerror     := 0;
      if reg.order_status_id = 0 then
        --se asigan orden de reconexion
        API_ASSIGN_ORDER(nuOrdenreco,
                        nuUnidOper,
                        nuerror,
                        SBERROR);

        IF nuerror <> 0 THEN
          proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPXPROD-ASIGRECO',
                                       SYSDATE,
                                       nuOrdenReco,
                                       NULL,
                                       sberror,
                                       USER);
          ROLLBACK;

        ELSE
          commit;
        end if;
      end if;
      if nuerror = 0 then
        --se valida clase de causal
        OPEN cuTipoCausal(nuCausalLegFall);
        FETCH cuTipoCausal
          INTO nuClasCausal;
        CLOSE cuTipoCausal;
        sbCadenalega := nuOrdenreco || '|' || nuCausalLegFall || '|' ||
                        nuPersonaLega || '||' || REG.ORDER_ACTIVITY_ID || '>' ||
                        nuClasCausal ||
                        ';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|' ||
                        NVL(sbItemLegaReco, '') ||
                        '||1277;Orden Legalizada por proceso PRJOBRECOYSUSPRP';
        --se legaliza orden de trabajo
        api_legalizeorders(sbCadenalega,
                          sysdate,
                          sysdate,
                          null,
                          nuerror,
                          SBERROR);
        IF nuerror <> 0 THEN
          proRegistraLogLegOrdRecoSusp('PRJOBRECOYSUSPXPROD-LEGARECO',
                                       SYSDATE,
                                       nuOrdenReco,
                                       NULL,
                                       sberror,
                                       USER);
          ROLLBACK;
        ELSE
          commit;
        END IF;
      END IF;

    END LOOP;
    ldc_proactualizaestaprog(nutsess, SBERROR, 'PRJOBRECOYSUSPXPROD', 'Ok');
    
    ut_trace.trace('Termina ' || csbSP_NAME|| 'PRJOBRECOYSUSPXPROD' , cnuNVLTRC);    

  EXCEPTION
    WHEN pkg_Error.controlled_error THEN
      pkg_error.getError(nuerror, SBERROR);
      ldc_proactualizaestaprog(nutsess,
                               SBERROR,
                               'PRJOBRECOYSUSPXPROD',
                               'error');

    WHEN OTHERS THEN
      pkg_error.setError;
      pkg_error.getError(nuerror, SBERROR);
      ldc_proactualizaestaprog(nutsess,
                               SBERROR,
                               'PRJOBRECOYSUSPXPROD',
                               'error');
      rollback;
  END PRJOBRECOYSUSPXPROD;

  PROCEDURE PRGENETRAMRP(inuProducto    IN NUMBER,
                         inuMedioRece   IN NUMBER,
                         isbObservacion IN VARCHAR2,
                         onuError       OUT NUMBER,
                         osbError       OUT VARCHAR2) IS
    /**************************************************************************
        Proceso     : PRGENETRAMRP
        Autor       : olsoftware
        Fecha       : 2020-03-16
        Ticket      : 498
        Descripcion : proceso que se encarga de generar tramite de rp

        Parametros Entrada
           inuProducto  codigo del producto
           inuMedioRece  codigo de medio de recepcion
           isbObservacion  observacion
        Parametros de salida
          onuerror codigo de error
          osbError  mensaje de error
        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    numarca     NUMBER;
    sbTipoSusp  VARCHAR2(4);
    nuPackageId NUMBER;
    nuMotiveId  NUMBER;

    -- datos para generar xml
    CURSOR cudatosXml IS
      select di.ADDRESS_PARSED,
             di.ADDRESS_ID,
             di.GEOGRAP_LOCATION_ID,
             pr.CATEGORY_ID,
             pr.SUBCATEGORY_ID,
             pr.SUBSCRIPTION_ID,
             sc.SUSCCLIE SUBSCRIBER_ID,
             pr.product_id
        from pr_product pr, SUSCRIPC sc, ab_address di
       where pr.ADDRESS_ID = di.ADDRESS_ID
         and pr.SUBSCRIPTION_ID = sc.SUSCCODI
         and pr.product_id = inuProducto;

    regProducto cudatosXml%rowtype;

  BEGIN

    ut_trace.trace('Inicia ' || csbSP_NAME|| 'PRGENETRAMRP' , cnuNVLTRC);  
    
    Onuerror := 0;
    --Se consulta marca del producto
    numarca := ldc_fncretornamarcaprod(inuProducto);
    --se consulta tipo de suspension
    sbTipoSusp := ldc_fsbvalidasuspcemoacomprod(inuProducto);

    open cudatosXml;
    fetch cudatosXml
      into regProducto;
    close cudatosXml;

    IF numarca = ldcfncretornamarcarevprp and
       (sbTipoSusp is null or upper(sbTipoSusp) = 'CM') THEN
      ldc_pkgeneraTramiteRp.prGenera100237(inuMedioRece,
                                           isbObservacion,
                                           regProducto.SUBSCRIBER_ID,
                                           regProducto.PRODUCT_ID,
                                           regProducto.SUBSCRIPTION_ID,
                                           regProducto.ADDRESS_PARSED,
                                           regProducto.ADDRESS_ID,
                                           regProducto.GEOGRAP_LOCATION_ID,
                                           regProducto.CATEGORY_ID,
                                           regProducto.SUBCATEGORY_ID,
                                           nuPackageId,
                                           nuMotiveId,
                                           onuError,
                                           osbError);

    elsif (nuMarca in (ldcfncretornamarcarepprp, ldcfncretornamarcadefcri)) and
          (sbTipoSusp is null or upper(sbTipoSusp) = 'CM') then
      ldc_pkgeneraTramiteRp.prGenera100294(inuMedioRece,
                                           isbObservacion,
                                           regProducto.SUBSCRIBER_ID,
                                           regProducto.PRODUCT_ID,
                                           regProducto.SUBSCRIPTION_ID,
                                           regProducto.ADDRESS_PARSED,
                                           regProducto.ADDRESS_ID,
                                           regProducto.GEOGRAP_LOCATION_ID,
                                           regProducto.CATEGORY_ID,
                                           regProducto.SUBCATEGORY_ID,
                                           nuPackageId,
                                           nuMotiveId,
                                           onuError,
                                           osbError);
    elsif (nuMarca = ldcfncretornamarcacerprp) and
          (sbTipoSusp is null or upper(sbTipoSusp) = 'CM') then
      ldc_pkgeneraTramiteRp.prGenera100295(inuMedioRece,
                                           isbObservacion,
                                           regProducto.SUBSCRIBER_ID,
                                           regProducto.PRODUCT_ID,
                                           regProducto.SUBSCRIPTION_ID,
                                           regProducto.ADDRESS_PARSED,
                                           regProducto.ADDRESS_ID,
                                           regProducto.GEOGRAP_LOCATION_ID,
                                           regProducto.CATEGORY_ID,
                                           regProducto.SUBCATEGORY_ID,
                                           nuPackageId,
                                           nuMotiveId,
                                           onuError,
                                           OsbError);
    elsif (upper(sbTipoSusp) = 'AC') then
      --Se genera reconexion
      ldc_pkgeneraTramiteRp.prGenera100321(inuMedioRece,
                                           isbObservacion,
                                           regProducto.SUBSCRIBER_ID,
                                           regProducto.PRODUCT_ID,
                                           regProducto.SUBSCRIPTION_ID,
                                           regProducto.ADDRESS_PARSED,
                                           regProducto.ADDRESS_ID,
                                           regProducto.GEOGRAP_LOCATION_ID,
                                           regProducto.CATEGORY_ID,
                                           regProducto.SUBCATEGORY_ID,
                                           -1,
                                           nuPackageId,
                                           nuMotiveId,
                                           onuError,
                                           OsbError);

    end if;
    if onuError <> 0 then
      pkg_error.setErrorMessage( isbMsgErrr =>
                      'Error al generar proceso de Rp [' || OsbError || ']');
    end if;

    ut_trace.trace('Termina ' || csbSP_NAME|| 'PRGENETRAMRP' , cnuNVLTRC);

  EXCEPTION
    WHEN pkg_Error.controlled_error THEN
      pkg_error.getError(Onuerror, OSBERROR);
    WHEN OTHERS THEN
      pkg_error.setError;
      pkg_error.getError(Onuerror, OSBERROR);
  END PRGENETRAMRP;
end LDC_PKGESTIONCASURP;
/

PROMPT Otorgando permisos de ejecución sobre LDC_PKGESTIONCASURP
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKGESTIONCASURP','OPEN');
END;
/

