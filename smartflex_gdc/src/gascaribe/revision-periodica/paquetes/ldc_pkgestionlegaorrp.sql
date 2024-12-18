CREATE OR REPLACE PACKAGE LDC_PKGESTIONLEGAORRP IS
    FUNCTION  FNUGETSUSPCMOTPR(inuProducto IN NUMBER) RETURN NUMBER;
    /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : FNUGETSUSPCMOTPR
    Descripcion : funcion que valide si el producto no esta suspendido por otro proceso
                  diferente a RP

    Parametros Entrada
    inuProducto    codigo del producto

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR   DESCRIPCION
    ***************************************************************************/

    FUNCTION FBLGETPRODUCTOVENC(inuProducto IN NUMBER, idtFechaEje IN DATE) RETURN BOOLEAN;
    /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : FBLGETPRODUCTOVENC
    Descripcion : funcion que valide si el producto esta vencido por rp

    Parametros Entrada
    inuProducto    codigo del producto
    idtFechaEje    fecha de ejecucion de la orden

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR   DESCRIPCION
    ***************************************************************************/
    PROCEDURE PRVALISOLIRPPEND(inuProducto IN NUMBER);
    /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : PRVALISOLIRPPEND
    Descripcion : proceso que valida que u porducto no tenga solicitudes pendiente configuradas el parametro
                  COD_PKG_TYPE_ID_FILTRO

    Parametros Entrada
    inuProducto    codigo del producto

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR   DESCRIPCION
    ***************************************************************************/
    FUNCTION FNUGETESTAPROD(inuProducto IN NUMBER, osbIsSuspRP OUT VARCHAR2) RETURN NUMBER;
    /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : FNUGETESTAPROD
    Descripcion : funcion que retorna si producto esta suspendido por RP

    Parametros Entrada
    inuProducto    codigo del producto

    Valor de salida
    osbIsSuspRP    flag que indica si producto esta suspendido por RP

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR   DESCRIPCION
    ***************************************************************************/

    PROCEDURE PRCAMMARPROD( inuProducto IN NUMBER,
                            inuorden    IN NUMBER,
                            inumarca    IN NUMBER,
                            onuError    OUT NUMBER,
                            osbError    OUT VARCHAR2);
    /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : PRCAMMARPROD
    Descripcion : proceso que se encargue de cambiar la marca a un producto

    Parametros Entrada
    inuProducto    codigo del producto
    inuorden     orden de trabajo
    inumarca   marca del producto
    Valor de salida

    onuError  codigo de error
    osbError  mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR   DESCRIPCION
    ***************************************************************************/

    PROCEDURE PRMARCAPRODRP;
    /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : PRMARCAPRODRP
    Descripcion : plugin que se encargue de cambiar la marca a un producto

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR   DESCRIPCION
    ***************************************************************************/

    FUNCTION  FNUGETSOLIREPA( inuproducto    IN  NUMBER,
                            inuContrato    IN  NUMBER,
                            inuCliente     IN  NUMBER,
                            inuMedioRece   IN  NUMBER,
                            isbObservacion IN  VARCHAR2,
                            isbdireccionparseada IN VARCHAR2,
                            inudireccion IN NUMBER,
                            inulocalidad IN  NUMBER,
                            inucategoria IN NUMBER,
                            inusubcategoria IN  NUMBER,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2 ) RETURN NUMBER;
    /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : FNUGETSOLIREPA
    Descripcion : funcion que se encarga de crear solicitud de reparacion

    Parametros Entrada
    inuproducto    codigo del producto
    inuContrato    codigo del contrato
    inuCliente     codigo del cliente
    inuMedioRece   medio de recepcion
    isbObservacion observacion
    isbdireccionparseada direccion parseada
    inudireccion  codigo de la direccion
    inulocalidad  localidad
    inucategoria  categoria
    inusubcategoria sucategoria

    Valor de salida
    onuError  codigo de error
    osbError  mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR   DESCRIPCION
    ***************************************************************************/

    PROCEDURE  PRGENETRAMSUSPADMI( inuProducto  IN NUMBER,
                                 inuTipoSusp  IN NUMBER,
                                 inuorden  IN or_order.order_id%type,
                                 inuSolicitud IN mo_packages.package_id%type,
                                 onuError     OUT NUMBER,
                                 osbError     OUT VARCHAR2);
    /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : PRGENETRAMSUSPADMI
    Descripcion : proceso que genera tramite de suspension

    Parametros Entrada
    inuproducto    codigo del producto
    inuTipoSusp    tipo de suspension
    inuorden       codigo de la orden
    inuSolicitud   codigo de la solicitud

    Valor de salida    
    onuError  codigo de error
    osbError  mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR   DESCRIPCION
    ***************************************************************************/

    FUNCTION  	FNUGETSOLIRECO ( inuproducto IN NUMBER,
                                inutiposusp IN NUMBER,
                                inumediorece IN NUMBER,
                                isbobservacion IN VARCHAR2,
                                onuerror OUT NUMBER,
                                osberror OUT VARCHAR2) RETURN NUMBER;
    /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : FNUGETSOLIRECO
    Descripcion : funcion que genera orden de reconexion

    Parametros Entrada
    inuproducto     codigo del producto
    inuTipoSusp     tipo de suspension
    iinumediorece   medio de recepcion
    isbobservacion  observacion

    Valor de salida
    onuError  codigo de error
    osbError  mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR   DESCRIPCION
    ***************************************************************************/

    FUNCTION 	FNUGETSOLICERTRP ( inuproducto IN NUMBER,
                                inumediorece IN NUMBER,
                                isbobservacion IN VARCHAR2,
                                onuerror OUT NUMBER,
                                osberror OUT VARCHAR2) RETURN NUMBER;
    /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : FNUGETSOLICERTRP
    Descripcion : funcion que genera tramite de certificacion

    Parametros Entrada
    inuproducto     codigo del producto
    iinumediorece   medio de recepcion
    isbobservacion  observacion

    Valor de salida
    onuError  codigo de error
    osbError  mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR   DESCRIPCION
    ***************************************************************************/

    FUNCTION 	FNUGETSUSPDUMMY(inuproducto IN NUMBER) RETURN NUMBER;
    /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : FNUGETSUSPDUMMY
    Descripcion : funcion que  valida si un producto esta suspendido por dummy

    Parametros Entrada
    inuproducto    codigo del producto

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR   DESCRIPCION
    ***************************************************************************/
    PROCEDURE PRGENSUSPACOMRP;
    /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : PRGENSUSPACOMRP
    Descripcion : plugin genera suspension por acometida

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR   DESCRIPCION
    ***************************************************************************/
    FUNCTION FNUVALCAUSOLSUSPDUMMY ( nusolicitud NUMBER) RETURN NUMBER;
    /**********************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Nombre      : FNUVALCAUSOLSUSPDUMMY

    Descripción: SERIVICIO PARA VALIDAR SI EL CAUSAL DE LA SOLICITUD ESTA RELACIONADA
    AL PARAMETRO LDC_CAUSDUMMY

    Parametros Entrada
    nuSolicitud    codigo de solicitud

    Historia de Modificaciones
    Fecha             Autor             Modificación
    ***********************************************************************/

    FUNCTION FNUGETMARCAPROD( nusolicitud IN NUMBER, inuproducto IN NUMBER) 
    RETURN NUMBER;
    /**********************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Nombre      : FNUGETMARCAPROD

    Descripción: funcion que se encarga de retornar la marca del producto

    Parametros Entrada
    nuSolicitud    codigo de solicitud
    inuproducto    codigo del producto

    Historia de Modificaciones
    Fecha             Autor             Modificación
    ***********************************************************************/

END LDC_PKGESTIONLEGAORRP;

/


CREATE OR REPLACE PACKAGE BODY LDC_PKGESTIONLEGAORRP IS
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : LDC_PKGESTIONLEGAORRP
    Descripcion :       

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR      DESCRIPCION
    04/12/2023   Adrianavg  Modificación: OSF-1836: Se retira prInicializaerror y se reemplaza por pkg_error.prInicializaError( onuCodeError, osbMsgErrr)
                            Se retira esquema OPEN antepuesto a varios objetos. 
                            Se reemplaza ex.controlled_error por pkg_error.controlled_error
                            Se declaran variables para la gestión de traza y se hace uso del pkg_traza.trace.   
                            Los bloques de exception se ajustan a como se indica en las pautas técnicas. 
                            Se reemplaza errors.seterror por pkg_error.seterror;
                            Se añade pkg_error.seterror; antes de RAISE como se indica en las pautas técnicas(punto13).
                            Se reemplaza ld_boconstans.cnugeneric_error por pkg_error.CNUGENERIC_MESSAGE
                            Se reemplaza ge_boerrors.seterrorcodeargument por Pkg_Error.Seterrormessage()
                            Se reemplaza ERRORS.GETERROR(onuError, osbError) por Pkg_Error.geterror() 
  ***************************************************************************/     
    --Variables para gestión de traza
    csbNOMPKG           CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';
    csbNivelTraza       CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef; 

  FUNCTION FNUGETSUSPCMOTPR(inuProducto IN NUMBER) RETURN NUMBER IS
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : FNUGETSUSPCMOTPR
    Descripcion : funcion que valide si el producto no esta suspendido por otro proceso
                  diferente a RP

    Parametros Entrada
    inuProducto    codigo del producto

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR    DESCRIPCION
    25/05/2021  DSALTARIN 769: Se cambio parametro PE_ACTIVIDADES_SUSPENSION_CM por ACTIVIDADES_SUSPENSION_CM
    05/12/2023  Adrianavg OSF-1836: Se ajusta expresión '[^|]+' por '[^,]+' en cursor cuValidaacti, ya que en la tabla 
                          LD_parameter se encuentran separados por coma[,] y no por pipe[|]
                          Se declaran variables para el manejo de error onuerrorcode, osberrormessage
                          Se hace uso del pkg_error.prInicializaError
   ***************************************************************************/
   nuSusp NUMBER := 0;

   sbActSuspCmOtr VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('ACTIVIDADES_SUSPENSION_CM', NULL);
   sbActSuspCmRp  VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('ACTI_SUSP_CM_REVI_PER_NEW_FLUJ', NULL);

   nuactividadSusp NUMBER;

   CURSOR cugetActiSusp IS
   SELECT OA.ACTIVITY_ID
     FROM PR_PRODUCT P, OR_ORDER_ACTIVITY OA
    WHERE P.PRODUCT_ID = inuProducto
      AND P.PRODUCT_STATUS_ID = 2
      AND P.SUSPEN_ORD_ACT_ID = OA.ORDER_ACTIVITY_ID;

    CURSOR cuValidaacti IS
    SELECT COUNT(1)
      FROM( SELECT  *
              FROM (SELECT TO_NUMBER(REGEXP_SUBSTR(sbactsuspcmotr, '[^,]+', 1, LEVEL)) AS actividad
                    FROM dual
              CONNECT BY REGEXP_SUBSTR(sbactsuspcmotr, '[^,]+', 1, LEVEL) IS NOT NULL)
             WHERE actividad NOT IN (SELECT TO_NUMBER(REGEXP_SUBSTR(sbactsuspcmrp, '[^,]+', 1, LEVEL)) AS actividadrp
                                       FROM dual
                                 CONNECT BY REGEXP_SUBSTR(sbactsuspcmrp, '[^,]+', 1, LEVEL) IS NOT NULL))
    WHERE actividad = nuactividadsusp;

    --Variables para gestión de traza
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'FNUGETSUSPCMOTPR';
	  onuErrorCode        NUMBER;
    osbErrorMessage     VARCHAR2(4000);
 BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);

    OPEN cugetActiSusp;
    FETCH cugetActiSusp INTO nuactividadSusp;
    CLOSE cugetActiSusp;
    pkg_traza.trace(csbMetodo||' nuactividadSusp: '||nuactividadSusp, csbNivelTraza);

    IF nuactividadSusp IS NOT NULL THEN
       OPEN cuValidaacti;
      FETCH cuValidaacti INTO nuSusp;
      CLOSE cuValidaacti;

      IF nuSusp > 1 THEN
         nuSusp := 1;
      END IF;
    END IF;

    pkg_traza.trace(csbMetodo||' nuSusp: '||nuSusp, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    RETURN nuSusp;
 EXCEPTION
   WHEN pkg_error.controlled_error THEN
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace('sbError: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);  
        RETURN nuSusp;
   WHEN OTHERS THEN
        pkg_error.seterror;  
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace('osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);   
        RETURN nuSusp;
 END FNUGETSUSPCMOTPR;

 FUNCTION FBLGETPRODUCTOVENC(inuProducto IN NUMBER, idtFechaEje IN DATE) RETURN BOOLEAN IS
 /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : FBLGETPRODUCTOVENC
    Descripcion : funcion que valide si el producto esta vencido por rp

    Parametros Entrada
    inuProducto    codigo del producto
    idtFechaEje    fecha de ejecucion de la orden

    Valor de salida

   HISTORIA DE MODIFICACIONES
    FECHA      AUTOR      DESCRIPCION
   05/12/2023  Adrianavg  OSF-1836: Se declaran variables para el manejo de error onuerrorcode, osberrormessage
                          Se hace uso del pkg_error.prInicializaError
  ***************************************************************************/
    blvencido         BOOLEAN := FALSE;
    sbFlagTipFech     VARCHAR2(1) :=  DALDC_PARAREPE.FSBGETPARAVAST('LDC_FLAGVALTIPOFECHA', NULL);
    nuDias_Anti_Notf  NUMBER := nvl(Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0);
    sbexiste          VARCHAR2(1);

   CURSOR cuValiVencFecSist IS
   SELECT /*+ index (a IDX_LDC_PLAZOS_CERT01) */
        'X'
    FROM ldc_plazos_cert a
   WHERE plazo_min_suspension <= sysdate + nuDias_Anti_Notf --
     AND is_notif IN ('YV', 'YR')
     AND a.ID_PRODUCTO = inuProducto;

   CURSOR cuValiVencFecEjeOrd IS
   SELECT /*+ index (a IDX_LDC_PLAZOS_CERT01) */
        'X'
    FROM ldc_plazos_cert a
   WHERE plazo_min_suspension <= idtFechaEje + nuDias_Anti_Notf --
     AND is_notif IN ('YV', 'YR')
     AND a.ID_PRODUCTO = inuProducto;

    --Variables para gestión de traza
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'FBLGETPRODUCTOVENC';
	  onuErrorCode        NUMBER;
    osbErrorMessage     VARCHAR2(4000);
 BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);

    IF sbFlagTipFech = 'S' THEN
       OPEN cuValiVencFecSist;
      FETCH cuValiVencFecSist  INTO sbexiste;
      CLOSE cuValiVencFecSist;
    ELSE
      OPEN cuValiVencFecEjeOrd;
     FETCH cuValiVencFecEjeOrd  INTO sbexiste;
     CLOSE cuValiVencFecEjeOrd;
    END IF;
    pkg_traza.trace(csbMetodo||' sbFlagTipFech: '|| sbFlagTipFech, csbNivelTraza);

    blvencido := sbexiste IS NOT NULL;
    IF blvencido THEN
       pkg_traza.trace(csbMetodo||' blvencido: TRUE', csbNivelTraza);
    ELSIF NOT blvencido THEN
       pkg_traza.trace(csbMetodo||' blvencido: FALSE', csbNivelTraza); 
    ELSE 
       pkg_traza.trace(csbMetodo||' blvencido: NULL', csbNivelTraza);
    END IF;    

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

  RETURN blvencido;
 EXCEPTION
   WHEN pkg_error.controlled_error THEN
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace('osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC); 
        RETURN blvencido;
   WHEN OTHERS THEN
        pkg_error.seterror; 
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace('osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
        RETURN blvencido;
 END FBLGETPRODUCTOVENC;

 PROCEDURE  PRVALISOLIRPPEND(inuProducto IN NUMBER) IS
 /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : PRVALISOLIRPPEND
    Descripcion : proceso que valida que u porducto no tenga solicitudes pendiente configuradas el parametro
                  COD_PKG_TYPE_ID_FILTRO

    Parametros Entrada
    inuProducto    codigo del producto

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR       DESCRIPCION
    05/12/2023  Adrianavg   OSF-1836: se retiran las variables nuError y sbError declaradas sin uso.
                            Se retira IF FBLAPLICAENTREGAXCASO('0000472')
                            Se declaran variables para el manejo de error onuerrorcode, osberrormessage
                            Se hace uso del pkg_error.prInicializaError
    07/12/2023  Adrianavg   OSF-1836: Se reemplaza Pkg_Error.Seterrormessage(pkg_error.CNUGENERIC_MESSAGE, mensaje) 
                            por pkg_error.setErrorMessage( isbMsgErrr => 'mensaje de Error');
  ***************************************************************************/

    sbSolicitudes    VARCHAR2(4000) := Dald_parameter.fsbgetvalue_chain('COD_PKG_TYPE_ID_FILTRO',NULL);
    nuEstaRegi       NUMBER := DALDC_PARAREPE.FNUGETPAREVANU('LDC_ESTARESO', NULL);
    sbexiste         VARCHAR2(1);

    CURSOR cuValidaSoli IS
    SELECT 'X'
      FROM mo_packages s, mo_motive m
     WHERE s.package_id = m.package_id
       AND m.product_id = inuProducto
       AND s.package_type_id in (SELECT TO_NUMBER(REGEXP_SUBSTR(sbSolicitudes,'[^,]+', 1, LEVEL)) AS actividadrp
                                   FROM dual
                             CONNECT BY REGEXP_SUBSTR(sbSolicitudes, '[^,]+', 1, LEVEL) IS NOT NULL )
       AND s.MOTIVE_STAtUS_ID = nuEstaRegi;

    --Variables para gestión de traza
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'PRVALISOLIRPPEND';
	  onuErrorCode        NUMBER;
    osbErrorMessage     VARCHAR2(4000);
  BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);

       OPEN cuValidaSoli;
       FETCH cuValidaSoli INTO sbexiste; 
       pkg_traza.trace(csbMetodo||' sbexiste: '||sbexiste, csbNivelTraza);   

       IF cuValidaSoli%FOUND THEN
          CLOSE cuValidaSoli;
          Pkg_Error.Seterrormessage(isbMsgErrr =>'Producto ['||inuProducto||'] tiene solicitudes RP pendientes');
       END IF;
       CLOSE cuValidaSoli;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);    

  EXCEPTION
   WHEN pkg_error.controlled_error THEN
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace('osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);     
        RAISE;
   WHEN OTHERS THEN
        pkg_error.seterror; 
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace('osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.controlled_error;
 END PRVALISOLIRPPEND;

 FUNCTION FNUGETESTAPROD(inuProducto IN NUMBER, osbIsSuspRP OUT VARCHAR2) RETURN NUMBER IS
/**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : FNUGETESTAPROD
    Descripcion : funcion que retorna si producto esta suspendido por RP

    Parametros Entrada
    inuProducto    codigo del producto

    Valor de salida
    osbIsSuspRP    flag que indica si producto esta suspendido por RP

    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR      DESCRIPCION
    05/12/2023  Adrianavg  OSF-1836: Se declaran variables para el manejo de error onuerrorcode, osberrormessage
                           Se hace uso del pkg_error.prInicializaError    
  ***************************************************************************/
    nuestaprod NUMBER;
    nuOrdeactivity NUMBER;

   sbTiposuspRp VARCHAR2(400) :=  DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TIPO_SUSPENSION_RP',NULL);

    CURSOR cuGetEstaProdu IS
    SELECT product_status_id
     FROM pr_product
    WHERE product_id = inuProducto;

    CURSOR cugetTipoSusP IS
    SELECT 'S'
      FROM PR_PROD_SUSPENSION PS
     WHERE PS.PRODUCT_ID = inuProducto
       AND PS.ACTIVE = 'Y'
       AND PS.SUSPENSION_TYPE_ID IN ( SELECT TO_NUMBER(REGEXP_SUBSTR(sbTiposuspRp,'[^,]+', 1, LEVEL)) AS tiposusp
                                        FROM dual
                                  CONNECT BY REGEXP_SUBSTR(sbTiposuspRp, '[^,]+', 1, LEVEL) IS NOT NULL  );

    --Variables para gestión de traza
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'FNUGETESTAPROD';
	  onuErrorCode        NUMBER;
    osbErrorMessage     VARCHAR2(4000);
  BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_error.prInicializaError(onuerrorcode, osbErrorMessage);

    OPEN cuGetEstaProdu;
    FETCH cuGetEstaProdu INTO nuestaprod;
    CLOSE cuGetEstaProdu;
    pkg_traza.trace(csbMetodo||' nuestaprod: '||nuestaprod, csbNivelTraza);

    IF nuestaprod = 2 THEN
      OPEN cugetTipoSusP;
      FETCH cugetTipoSusP INTO OsbIsSuspRP;
      IF cugetTipoSusP%NOTFOUND THEN
         osbIsSuspRP := 'N';
      END IF;
      CLOSE cugetTipoSusP;
    ELSE
     osbIsSuspRP := 'N';
    END IF;
    pkg_traza.trace(csbMetodo||' OsbIsSuspRP: '||OsbIsSuspRP, csbNivelTraza);    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    RETURN nuestaprod;
  EXCEPTION
   WHEN pkg_error.controlled_error THEN 
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace('osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);    
       RETURN nuestaprod;
   WHEN OTHERS THEN
        pkg_error.seterror; 
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace('osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
      RETURN nuestaprod;
 END FNUGETESTAPROD;

 PROCEDURE PRCAMMARPROD( inuProducto IN NUMBER,
                            inuorden    IN NUMBER,
                            inumarca    IN NUMBER,
                            onuError    OUT NUMBER,
                            osbError    OUT VARCHAR2) IS
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : PRCAMMARPROD
    Descripcion : proceso que se encargue de cambiar la marca a un producto

    Parametros Entrada
    inuProducto codigo del producto
    inuorden    orden de trabajo
    inumarca    marca del producto

    Valor de salida
    onuError  codigo de error
    osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR      DESCRIPCION
    05/12/2023  Adrianavg  OSF-1836: Se declaran variables para el manejo de error onuerrorcode, osberrormessage
                           Se hace uso del pkg_error.prInicializaError    
  ***************************************************************************/
    numarcaantes NUMBER;

    --Variables para gestión de traza
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'PRCAMMARPROD';
	  onuErrorCode        NUMBER;
    osbErrorMessage     VARCHAR2(4000);
  BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_error.prInicializaError(onuerrorcode, osbErrorMessage);

    pkg_traza.trace(csbMetodo||' inuProducto: '||inuProducto, csbNivelTraza);
    pkg_traza.trace(csbMetodo||' inuorden: '||inuorden, csbNivelTraza);
    pkg_traza.trace(csbMetodo||' inumarca: '||inumarca, csbNivelTraza);

    numarcaantes := ldc_fncretornamarcaprod(inuProducto);
    pkg_traza.trace(csbMetodo||' numarcaantes: '||numarcaantes, csbNivelTraza);

    ldcprocinsactumarcaprodu(inuProducto,  inumarca, inuorden);
    ldc_prmarcaproductolog(inuProducto,numarcaantes, inumarca , 'Legalizacion OT :'||inuorden);

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_error.controlled_error THEN 
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace('sbError: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);   

    WHEN OTHERS THEN
         pkg_error.seterror;  
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace('osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);

 END PRCAMMARPROD;

 PROCEDURE PRMARCAPRODRP IS
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : PRMARCAPRODRP
    Descripcion : plugin que se encargue de cambiar la marca a un producto

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR      DESCRIPCION
    05/12/2023  Adrianavg  OSF-1836: Se retira IF FBLAPLICAENTREGAXCASO('0000472') 
                           Se hace uso del pkg_error.prInicializaError
                           Se reemplaza or_bolegalizeorder.fnuGetCurrentOrder por pkg_bcordenes.fnuobtenerotinstancialegal
    07/12/2023  Adrianavg  OSF-1836: Se reemplaza Pkg_Error.Seterrormessage(pkg_error.CNUGENERIC_MESSAGE, mensaje) 
                           por pkg_error.setErrorMessage( isbMsgErrr => 'mensaje de Error');                          
  ***************************************************************************/
    nuorden      NUMBER;
    nuMarca      NUMBER;
    nuProducto   NUMBER;
    nuerror      NUMBER;
    sberror      VARCHAR2(4000);

    CURSOR cuGetProducto IS
    SELECT product_id
      FROM or_order_activity at
     WHERE at.order_id = nuorden
       AND ROWNUM   = 1;

    --Variables para gestión de traza
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'PRMARCAPRODRP';

  BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_error.prInicializaError(nuerror, sberror);

       --Obtener el identificador de la orden  que se encuentra en la instancia
      nuorden := pkg_bcordenes.fnuobtenerotinstancialegal;
      pkg_traza.trace(csbMetodo||' nuorden: '||nuorden, csbNivelTraza);

      OPEN cuGetProducto;
      FETCH cuGetProducto INTO nuProducto;
      IF cuGetProducto%NOTFOUND THEN
          CLOSE cuGetProducto;
          Pkg_Error.Seterrormessage(isbMsgErrr => 'Orden ['||nuorden||'] no tiene producto asociado');
      END IF;
      CLOSE cuGetProducto;
      pkg_traza.trace(csbMetodo||' nuProducto: '||nuProducto, csbNivelTraza);

      nuMarca := LDC_FNUGETNUEVAMARCA(nuorden);
      pkg_traza.trace(csbMetodo||' nuMarca: '||nuMarca, csbNivelTraza);

      PRCAMMARPROD(nuProducto, nuorden,nuMarca, nuerror, sberror);

        IF nuerror <> 0 THEN
          Pkg_Error.Seterrormessage( isbMsgErrr => sberror);
        END IF;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);    

  EXCEPTION
    WHEN pkg_error.controlled_error THEN 
         pkg_Error.getError(nuerror, sberror);
         pkg_traza.trace('sbError: ' || sberror, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);   
         RAISE pkg_error.controlled_error;
    WHEN OTHERS THEN
         pkg_error.seterror; 
         pkg_Error.getError(nuerror, sberror);
         pkg_traza.trace('sberror: ' || sberror, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
         RAISE pkg_error.controlled_error;
 END PRMARCAPRODRP;

 FUNCTION FNUGETSOLIREPA( inuproducto    IN  NUMBER,
                          inuContrato    IN  NUMBER,
                          inuCliente     IN  NUMBER,
                          inuMedioRece   IN  NUMBER,
                          isbObservacion IN  VARCHAR2,
                          isbdireccionparseada IN VARCHAR2,
                          inudireccion IN NUMBER,
                          inulocalidad IN  NUMBER,
                          inucategoria IN NUMBER,
                          inusubcategoria IN  NUMBER,
                          onuError OUT NUMBER,
                          osbError OUT VARCHAR2 ) RETURN NUMBER IS
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : FNUGETSOLIREPA
    Descripcion : funcion que se encarga de crear solicitud de reparacion

    Parametros Entrada
    inuproducto          codigo del producto
    inuContrato          codigo del contrato
    inuCliente           codigo del cliente
    inuMedioRece         medio de recepcion
    isbObservacion       observacion
    isbdireccionparseada direccion parseada
    inudireccion         codigo de la direccion
    inulocalidad         localidad
    inucategoria         categoria
    inusubcategoria      sucategoria

    Valor de salida
    onuError  codigo de error
    osbError  mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR      DESCRIPCION
    04/12/2023  Adrianavg  OSF-1836: Se hace uso del pkg_error.prInicializaError
                           Se reemplaza el tipo de dato de la variable sbrequestxml1, de VARCHAR2 a constants_per.TIPO_XML_SOL
                           Se reemplaza armado del XML P_SOLICITUD_REPARACION_PRP_100294 por pkg_xml_soli_rev_periodica.getSolicitudReparacionRp
                           Se reemplaza os_registerrequestwithxml por API_REGISTERREQUESTBYXML
    07/12/2023  Adrianavg  OSF-1836: Se reemplaza Pkg_Error.Seterrormessage(pkg_error.CNUGENERIC_MESSAGE, mensaje) 
                           por pkg_error.setErrorMessage( isbMsgErrr => 'mensaje de Error');                             
  ***************************************************************************/
    nuSolicitud         NUMBER; 
    numotiveid          NUMBER;
    sbrequestxml1       constants_per.TIPO_XML_SOL%TYPE; 
    nucontacomponentes  NUMBER;
    nunumber            NUMBER(4) DEFAULT 0;
    nuprodmotive        mo_component.prod_motive_comp_id%TYPE;
    sbtagname           mo_component.tag_name%TYPE;
    nuclasserv          mo_component.class_service_id%TYPE;
    nucomppadre         mo_component.component_id%TYPE;
    rcComponent         damo_component.stymo_component;
    rcmo_comp_link      damo_comp_link.stymo_comp_link;

   CURSOR cuComponente(nucumotivos mo_motive.motive_id%TYPE) IS
   SELECT COUNT(1)
     FROM mo_component C
    WHERE c.motive_id = nucumotivos; 

    --Variables para gestión de traza
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'FNUGETSOLIREPA';

 BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_error.prInicializaError(onuError, osbError);
    pkg_traza.trace(csbMetodo||' inuproducto: '||inuproducto||', inuContrato: '||inuContrato, csbNivelTraza);
    pkg_traza.trace(csbMetodo||' inuCliente: '||inuCliente||', inuMedioRece: '||inuMedioRece, csbNivelTraza); 
    pkg_traza.trace(csbMetodo||' isbObservacion: '||isbObservacion||', isbdireccionparseada: '||isbdireccionparseada, csbNivelTraza); 
    pkg_traza.trace(csbMetodo||' inudireccion: '||inudireccion||', inulocalidad: '||inulocalidad, csbNivelTraza); 
    pkg_traza.trace(csbMetodo||' inucategoria: '||inucategoria||', inusubcategoria: '||inusubcategoria, csbNivelTraza);

    sbrequestxml1 := pkg_xml_soli_rev_periodica.getSolicitudReparacionRp(inuMedioRece,     --inuMedioRecepcionId
                                                                         isbObservacion,   --isbComentario 
                                                                         inuproducto,      --inuProductoId
                                                                         inuCliente       --inuClienteId
                                                                         );

    pkg_traza.trace(csbMetodo||' sbrequestxml1: '||sbrequestxml1, csbNivelTraza);

    -- Se crea la solicitud y la orden de trabajo
     API_REGISTERREQUESTBYXML( sbrequestxml1,
                               nuSolicitud,
                               numotiveid,
                               onuError,
                               osbError
                             );
     pkg_traza.trace(csbMetodo||'API_REGISTERREQUESTBYXML--> nuSolicitud: '||nuSolicitud||', numotiveid: '||numotiveid, csbNivelTraza);

     IF onuError <> 0 THEN
         Pkg_Error.Seterrormessage(isbMsgErrr => osbError);
     ELSE
       -- Consultamos si el motivo generado tiene asociado los componentes
        OPEN cuComponente(numotiveid);
       FETCH cuComponente INTO nucontacomponentes;
       CLOSE cuComponente;
       pkg_traza.trace(csbMetodo||' nucontacomponentes: '||nucontacomponentes, csbNivelTraza);

       -- Si el motivo no tine los componentes asociados, se procede a registrarlos
       IF (nucontacomponentes=0)THEN
        FOR i IN (
                  SELECT kl.*,mk.package_id solicitud,mk.subcategory_id subcategoria
                    FROM mo_motive mk,pr_component kl
                   WHERE mk.motive_id = numotiveid
                     AND kl.component_status_id <> 9
                     AND mk.product_id = kl.product_id
                   ORDER BY kl.component_type_id
                  ) LOOP

         IF i.component_type_id = 7038 THEN

            nunumber     := 1;
            nuprodmotive := 10346;
            sbtagname    := 'C_GAS_10346';
            nuclasserv   := NULL;

         ELSIF i.component_type_id = 7039 THEN
            nunumber     := 2;
            nuprodmotive := 10348;
            sbtagname    := 'C_MEDICION_10348';
            nuclasserv   := 3102;
         END IF;

         rcComponent.component_id         := mo_bosequences.fnugetcomponentid();
         rcComponent.component_number     := nunumber;
         rcComponent.obligatory_flag      := 'N';
         rcComponent.obligatory_change    := 'N';
         rcComponent.notify_assign_flag   := 'N';
         rcComponent.authoriz_letter_flag := 'N';
         rcComponent.status_change_date   := SYSDATE;
         rcComponent.recording_date       := SYSDATE;
         rcComponent.directionality_id    := 'BI';
         rcComponent.custom_decision_flag := 'N';
         rcComponent.keep_number_flag     := 'N';
         rcComponent.motive_id            := numotiveid;
         rcComponent.prod_motive_comp_id  := nuprodmotive;
         rcComponent.component_type_id    := i.component_type_id;
         rcComponent.motive_type_id       := 75;
         rcComponent.motive_status_id     := 15;
         rcComponent.product_motive_id    := 100304;
         rcComponent.class_service_id     := nuclasserv;
         rcComponent.package_id           := nuSolicitud;
         rcComponent.product_id           := i.product_id;
         rcComponent.service_number       := i.product_id;
         rcComponent.component_id_prod    := i.component_id;
         rcComponent.uncharged_time       := 0;
         rcComponent.product_origin_id    := i.product_id;
         rcComponent.quantity             := 1;
         rcComponent.tag_name             := sbtagname;
         rcComponent.is_included          := 'N';
         rcComponent.category_id          := i.category_id;
         rcComponent.subcategory_id       := i.subcategoria;

         damo_component.Insrecord(rcComponent);

         IF i.component_type_id = 7038 THEN
          nucomppadre :=  rcComponent.component_id;
         END IF;

         IF(nuMotiveId IS NOT NULL)THEN
           rcmo_comp_link.child_component_id  := rcComponent.component_id;
           IF i.component_type_id = 7039 THEN
              rcmo_comp_link.father_component_id := nucomppadre;
           ELSE
              rcmo_comp_link.father_component_id := NULL;
           END IF;
           rcmo_comp_link.motive_id           := nuMotiveId;
           damo_comp_link.insrecord(rcmo_comp_link);
         END IF;
        END LOOP;
       END IF;
     END IF;
    pkg_traza.trace(csbMetodo||' nuSolicitud: '||nuSolicitud, csbNivelTraza);

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    RETURN nuSolicitud;

  EXCEPTION
   WHEN pkg_error.controlled_error THEN        
        pkg_Error.getError(onuError, osbError); 
        pkg_traza.trace('osbError: ' || osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);           
        RETURN nuSolicitud;
   WHEN OTHERS THEN
        pkg_error.seterror; 
        pkg_Error.getError(onuError, osbError);
        pkg_traza.trace('osbError: ' || osbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);         
       RETURN nuSolicitud;
 END FNUGETSOLIREPA;

 PROCEDURE  PRGENETRAMSUSPADMI( inuProducto  IN NUMBER,
                                inuTipoSusp  IN NUMBER,
                                inuorden     IN or_order.order_id%TYPE,
                                inuSolicitud IN mo_packages.package_id%TYPE,
                                onuError     OUT NUMBER,
                                osbError     OUT VARCHAR2) IS
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : PRGENETRAMSUSPADMI
    Descripcion : proceso que genera tramite de suspension

    Parametros Entrada
    inuproducto    codigo del producto
    inuTipoSusp    tipo de suspension
    inuorden       codigo de la orden
    inuSolicitud   codigo de la solicitud

    Valor de salida
    onuError  codigo de error
    osbError  mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA      AUTOR      DESCRIPCION
    04/12/2023 Adrianavg  OSF-1836: Se hace uso del pkg_error.prInicializaError
                          Se reemplaza el tipo de dato de la variable sbrequestxml1, de VARCHAR2 a constants_per.TIPO_XML_SOL
                          Se añade pkg_error.seterror; antes de RAISE erPrograma como se indica en las pautas técnicas.
                          Se reemplaza ge_bopersonal.fnugetpersonid por pkg_bopersonal.fnugetpersonaid
                          Se reemplaza daor_order.fnugetcausal_id por pkg_bcordenes.fnuobtienecausal
                          Se ajusta cursor cusolicitudesabiertas, reemplazando ldc_boutilities.splitstrings por REGEXP_SUBSTR
                          Se retiran variables declaradas sin uso: nudireccion, dtfechasusp
  ***************************************************************************/
    numediorecepcion    mo_packages.reception_type_id%TYPE; 
    sbComment           VARCHAR2(2000);
    nuPackageId         mo_packages.package_id%TYPE;
    nuMotiveId          mo_motive.motive_id%TYPE;
    nutipoCausal        NUMBER;
    nuCausal            NUMBER;
    sbrequestxml1       constants_per.TIPO_XML_SOL%TYPE; 
    nuErrorCode         NUMBER;
    sbErrorMessage      VARCHAR2(4000);
    nucontratoid        or_order_activity.subscription_id%TYPE;
    nucliente           or_order_activity.subscriber_id%TYPE;
    nuEstadoSolitud     mo_packages.motive_status_id%TYPE;
    nuPackageidPadre    mo_packages.package_id%TYPE;
    nuCodigoAtrib       NUMBER := Dald_parameter.fnuGetNumeric_Value('LDC_CODIATRLECTSUSPAD',NULL);
    sbNombreoAtrib      VARCHAR2(100) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_NOMBATRLECTSUSPAD',NULL);
    sbsolicitudes       VARCHAR2(1000);
    nuPersonaLega       ge_person.person_id%TYPE := pkg_bopersonal.fnugetpersonaid;
    nucausalorder       ge_causal.causal_id%TYPE;
    nuLectura           NUMBER;
    erPrograma          EXCEPTION;

    --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
    CURSOR cuProducto IS
    SELECT at.subscription_id,
           at.subscriber_id,
           m.motive_status_id,
           at.package_id
     FROM or_order_activity at,mo_packages m
    WHERE at.product_id = inuProducto
      AND AT.package_id IS NOT NULL
      AND at.package_id = inuSolicitud
      AND m.package_id = at.package_id
      AND ROWNUM = 1;

    --se consulta solicitudes abiertas
    CURSOR cusolicitudesabiertas IS
    SELECT pv.package_id colsolicitud
      FROM mo_packages pv,mo_motive mv
     WHERE pv.package_type_id  IN ( SELECT TO_NUMBER(REGEXP_SUBSTR(dald_parameter.fsbgetvalue_chain('VAL_TRAMITES_NUEVOS_FLUJOS',NULL),'[^,]+', 1, LEVEL)) AS tiposusp
                                      FROM   dual
                                CONNECT BY REGEXP_SUBSTR(dald_parameter.fsbgetvalue_chain('VAL_TRAMITES_NUEVOS_FLUJOS',NULL), '[^,]+', 1, LEVEL) IS NOT NULL  )
      AND pv.package_type_id  <> Dald_parameter.fnuGetNumeric_Value('LDC_TRAM_RECO_SIN_CERT',NULL)
      AND pv.motive_status_id = dald_parameter.fnuGetNumeric_Value('ESTADO_SOL_REGISTRADA')
      AND mv.product_id       = inuProducto
      AND pv.package_id       = mv.package_id;

    CURSOR cuLecturaOrdePadre(nuParametro NUMBER) IS
    SELECT decode(s.capture_order,1, value_1,2,value_2,3, value_3, 4, value_4, 5,value_5, 6, value_6, 7,value_7, 8,value_8, 9,value_9,10,value_10,11,value_11,12,value_12,13, value_13, 14,value_14, 15, value_15, 16, value_16,17, value_17, 18, value_18, 19, value_19, 20,value_20, 'NA') lectura
      FROM or_tasktype_add_data d,
           ge_attrib_set_attrib s,
           ge_attributes A,
           or_requ_data_value r ,
           or_order o
    WHERE d.task_type_id = o.task_type_id
      AND d.attribute_set_id = s.attribute_set_id
      AND s.attribute_id = a.attribute_id
      AND r.attribute_set_id = d.attribute_set_id
      AND r.order_id = o.order_id
      AND o.order_id = inuorden
      AND d.active = 'Y'
      AND A.attribute_id = nuParametro ;

    CURSOR cuPersonaLega IS
    SELECT person_id
      FROM or_order_person
     WHERE order_id = inuorden;

    nuUnidadDummy     NUMBER := daldc_pararepe.fnugetparevanu('UNIT_DUMMY_RP', null);

    --Variables para gestión de traza
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'PRGENETRAMSUSPADMI';

 BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_error.prInicializaError(onuError, osbError); 

    pkg_traza.trace(csbMetodo||' inuProducto: '||inuProducto ||', inuTipoSusp: '||inuTipoSusp, csbNivelTraza);
    pkg_traza.trace(csbMetodo||' inuorden: '||inuorden ||', inuSolicitud: '||inuSolicitud, csbNivelTraza); 

	-- obtenemos el producto y el paquete
	 OPEN cuproducto;
	FETCH cuProducto INTO nucontratoid, nucliente, nuEstadoSolitud, nuPackageidPadre;
	IF cuProducto%NOTFOUND THEN
       osbError := 'Proceso termino con errores Producto['||inuProducto||']. ';
       pkg_Error.setError; 
       RAISE erPrograma;
	END IF;
	CLOSE cuproducto;
    pkg_traza.trace(csbMetodo||' nucontratoid: '||nucontratoid ||', nucliente: '||nucliente, csbNivelTraza); 
    pkg_traza.trace(csbMetodo||' nuPackageidPadre: '||nuPackageidPadre, csbNivelTraza); 

    IF nuEstadoSolitud = 13 THEN

     -- Actualizamos las solicitud que se esta legalizando para que no salga como pendiente
     UPDATE mo_packages m
        SET m.motive_status_id = 14
      WHERE m.package_id  = nuPackageidPadre;
     pkg_traza.trace(csbMetodo||' Actualizamos las solicitud que se esta legalizando para que no salga como pendiente '||SQL%ROWCOUNT, csbNivelTraza);
    END IF;

  -- Buscamos solicitudes de revisi?n periodica generadas
    sbsolicitudes := NULL;
    FOR i IN cusolicitudesabiertas LOOP
     IF sbsolicitudes IS NULL THEN
      sbsolicitudes := i.colsolicitud;
     ELSE
      sbsolicitudes := sbsolicitudes||','||to_char(i.colsolicitud);
     END IF;
    END LOOP;
    pkg_traza.trace(csbMetodo||' sbsolicitudes: '||sbsolicitudes, csbNivelTraza);

    IF sbsolicitudes IS NULL THEN

         -- Construimos XML para generar el tramite
         nupackageid      := NULL;
         numotiveid       := NULL;
         nuerrorcode      := NULL;
         sberrormessage   := NULL; 

          OPEN cuLecturaOrdePadre(nuCodigoAtrib);
         FETCH cuLecturaOrdePadre INTO nuLectura;
         IF cuLecturaOrdePadre%NOTFOUND THEN
            nuLectura := null;
         END IF;
         CLOSE cuLecturaOrdePadre;
         pkg_traza.trace(csbMetodo||' nuLectura: '||nuLectura, csbNivelTraza);

         if nuLectura  is null then
            osbError := 'Proceso termino con errores : '||'No se ha digitado Lectura';
            pkg_Error.setError;
            RAISE erPrograma;
         end if;
         nucausalorder := pkg_bcordenes.fnuobtienecausal(inuorden);
         pkg_traza.trace(csbMetodo||' nucausalorder: '||nucausalorder, csbNivelTraza);

         OPEN cupersonalega;        
         FETCH cupersonalega INTO nupersonalega;        
         CLOSE cupersonalega;

         sbcomment := '[GENERACION PLUGIN]| LEGALIZACION ORDEN['||inuorden||']|LECTURA['||nuLectura||']|PERSONA['||nuPersonaLega||']| '||dald_parameter.fsbGetValue_Chain('COMENTARIO_SUSP_ADM_PRP')||' CON CAUSAL : '||to_char(nucausalorder);

         numediorecepcion := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_SUSPADM_PRP');

         IF numediorecepcion IS NULL THEN
            osbError := 'No existe datos para el parametro MEDIO_RECEPCION_SUSPADM_PRP, definalos por el comando LDPAR';
            pkg_Error.setError;
            RAISE erPrograma;
         END IF;

         nutipoCausal := DALDC_PARAREPE.FNUGETPAREVANU('LDC_TIPOCAUSDUMMY', NULL);

         IF nutipoCausal IS NULL THEN
            osbError :=  'No existe datos para el parametro TIPO_DE_CAUSAL_SUSP_ADMI, definalos por el comando LDPAR';
            pkg_Error.setError; 
            RAISE erPrograma;
         END IF;

         nuCausal := DALDC_PARAREPE.FNUGETPAREVANU('LDC_CAUSDUMMY', NULL); 

         IF nuCausal IS NULL THEN
             osbError :=  'No existe datos para el parametro COD_CAUSA_SUSP_ADM_XML, definalos por el comando LDPAR';
             pkg_Error.setError;
             RAISE erPrograma;
         END IF;

         pkg_traza.trace(csbMetodo||' nupersonalega: '||nupersonalega, csbNivelTraza);         
         pkg_traza.trace(csbMetodo||' sbcomment: '||sbcomment, csbNivelTraza); 
         pkg_traza.trace(csbMetodo||' numediorecepcion: '||numediorecepcion, csbNivelTraza); 
         pkg_traza.trace(csbMetodo||' nutipoCausal: '||nutipoCausal, csbNivelTraza); 
         pkg_traza.trace(csbMetodo||' nuCausal: '||nuCausal, csbNivelTraza);

          nupackageid := LDC_PKGESTIONCASURP.fnuGeneTramSuspRP( inuProducto,
                                                                numediorecepcion,
                                                                nutipoCausal,
                                                                nuCausal,
                                                                inuTipoSusp,
                                                                sbcomment,
                                                                onuError,
                                                                osberror);
          pkg_traza.trace(csbMetodo||' nupackageid: '||nupackageid, csbNivelTraza);                                                                

          IF nupackageid IS NULL THEN
             osberror := 'Proceso termino con errores : '||'Error al generar la solicitud de suspension administrativa prp. Codigo error : '||to_char(onuError)||' Mensaje de error : '||osberror;
             pkg_Error.setError;
             RAISE erPrograma;
          ELSE
               ldcproccrearegistrotramtab(ldc_seq_tramites_revper.nextval,inuProducto,nupackageid,inuTipoSusp,inuTipoSusp,SYSDATE,'Se atiende la solicitud nro : '||to_char(nupackageid));
               osberror := 'Proceso termino Ok. Se genero la solicitud Nro : '||TO_CHAR(nupackageid);
               IF nuEstadoSolitud = 13 THEN
               -- Actualizamos las solicitud que se esta legalizando para que no salga como pendiente
                  UPDATE mo_packages m
                     SET m.motive_status_id = 13
                   WHERE m.package_id      = nuPackageidPadre;
                   pkg_traza.trace(csbMetodo||' Actualizamos las solicitud que se esta legalizando para que no salga como pendiente '||SQL%ROWCOUNT, csbNivelTraza);
               END IF;

                INSERT INTO ldc_bloq_lega_solicitud (package_id_orig, package_id_gene) 
                VALUES (inusolicitud, nupackageid);
                pkg_traza.trace(csbMetodo||' Insertar en ldc_bloq_lega_solicitud', csbNivelTraza); 

				INSERT INTO LDC_ORDEASIGPROC(ORAPORPA,ORAPSOGE, ORAOUNID, ORAOPROC) 
                VALUES (inuorden, nupackageid, nuUnidadDummy, 'SUSPDUMMYRP');
                pkg_traza.trace(csbMetodo||' Insertar en ldc_ordeasigproc', csbNivelTraza);

          END IF;
      ELSE
        osbError := 'Error al generar la solicitud para el producto : '||to_char(inuProducto)||' Tiene las siguientes solicitudes de revisi?n periodica en estado registradas : '||TRIM(sbsolicitudes);
        pkg_Error.setError;
        RAISE erPrograma;
      END IF;

   pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

  EXCEPTION
  WHEN erPrograma THEN
	     onuError := -1;
       pkg_traza.trace('erPrograma: ' || osbError, csbNivelTraza);
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
	WHEN pkg_error.controlled_error THEN 
       pkg_Error.getError(onuError, osbError); 
       pkg_traza.trace('osbError: ' || osbError, csbNivelTraza);
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);          

  WHEN OTHERS THEN 
       pkg_Error.setError;          
       pkg_Error.getError(onuError, osbError);
       pkg_traza.trace('osbError: ' || osbError, csbNivelTraza);
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          

 END PRGENETRAMSUSPADMI;


 FUNCTION FNUGETSOLIRECO ( inuproducto IN NUMBER,
                           inutiposusp IN NUMBER,
                           inumediorece IN NUMBER,
                           isbobservacion IN VARCHAR2,
                           onuerror OUT NUMBER,
                           osberror OUT VARCHAR2) RETURN NUMBER  IS
 /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : FNUGETSOLIRECO
    Descripcion : funcion que genera orden de reconexion

    Parametros Entrada
    inuproducto     codigo del producto
    inuTipoSusp     tipo de suspension
    iinumediorece   medio de recepcion
    isbobservacion  observacion

    Valor de salida
    onuError  codigo de error
    osbError  mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA      AUTOR      DESCRIPCION
    04/12/2023 Adrianavg  Se retira el cursor cugetDatosProd y se crea el cursor cuCliente
                          Se añade uso de pkg_error.prInicializaError
                          Se reemplaza el tipo de dato de la variable sbrequestxml1, de VARCHAR2 a constants_per.TIPO_XML_SOL
                          Se reemplaza os_registerrequestwithxml por API_REGISTERREQUESTBYXML
                          Se reemplaza armado del XML P_SOLICITUD_DE_RECONEXION_SIN_CERTIFICACION_100321 por pkg_xml_soli_rev_periodica.getXMSolicitudReconexionRp 
                          Se reemplaza dapr_product.fnugetcategory_id por pkg_bcproducto.fnucategoria
                          Se reemplaza dapr_product.fnugetsubcategory_id por pkg_bcproducto.fnusubcategoria
  ***************************************************************************/
    nuSolicitud             NUMBER;
    sbrequestxml1           constants_per.TIPO_XML_SOL%TYPE;
    numotiveid              mo_motive.motive_id%TYPE; 
    nucliente               NUMBER; 
    nucont                  NUMBER(4);
    rcComponent             damo_component.stymo_component;
    rcmo_comp_link          damo_comp_link.stymo_comp_link;
    nunumber                NUMBER(4) DEFAULT 0;
    nuprodmotive            mo_component.prod_motive_comp_id%TYPE;
    sbtagname               mo_component.tag_name%TYPE;
    nuclasserv              mo_component.class_service_id%TYPE;
    nucomppadre             mo_component.component_id%TYPE;

	-- Cursor para obtener los componentes asociados a un motivo
    CURSOR cuComponente(nucumotivos mo_motive.motive_id%TYPE) IS
    SELECT COUNT(1)
      FROM mo_component C
     WHERE c.package_id = nucumotivos;

	-- Cursor para obtener id del cliente
    CURSOR cuCliente
    IS
    SELECT c.suscclie
      FROM suscripc c, pr_product pr
     WHERE c.susccodi = pr.subscription_id
       AND pr.product_id = inuproducto;     

    --Variables para gestión de traza
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'FNUGETSOLIRECO';

  BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_error.prInicializaError(onuError, osbError);  
    pkg_traza.trace(csbMetodo||' inuproducto: '||inuproducto ||', inutiposusp: '||inutiposusp, csbNivelTraza);
    pkg_traza.trace(csbMetodo||' inumediorece: '||inumediorece ||', isbobservacion: '||isbobservacion, csbNivelTraza);

    OPEN cuCliente;
    FETCH cuCliente INTO nucliente;
    CLOSE cuCliente;

    sbrequestxml1 := pkg_xml_soli_rev_periodica.getXMSolicitudReconexionRp  (inumediorece,     --inuMedioRecepcionId
                                                                             isbobservacion,   -- isbComentario
                                                                             inuproducto,      -- inuProductoId
                                                                             nucliente,        -- inuClienteId
                                                                             inutiposusp       -- inuTipoSuspensionId
                                                                             );--P_SOLICITUD_DE_RECONEXION_SIN_CERTIFICACION_100321
    pkg_traza.trace(csbMetodo||' sbrequestxml1: '||sbrequestxml1, csbNivelTraza); 

    -- Procesamos el XML y generamos la solicitud
    API_REGISTERREQUESTBYXML( sbrequestxml1,
                              nuSolicitud,
                              numotiveid,
                              onuError,
                              osbError);
    pkg_traza.trace(csbMetodo||' nuSolicitud: '||nuSolicitud||', numotiveid: '||numotiveid, csbNivelTraza);    

   IF onuError = 0 THEN
        -- Consultamos si el motivo generado tiene asociado los componentes
        OPEN cuComponente(numotiveid);
        FETCH cuComponente INTO nucont;
        CLOSE cuComponente;
        pkg_traza.trace(csbMetodo||' nucont: '||nucont, csbNivelTraza);

        -- Si el motivo no tine los componentes asociados, se procede a registrarlos
        IF (nucont=0)THEN
            FOR i IN (
                    SELECT kl.*,mk.package_id solicitud,mk.subcategory_id subcategoria
                            FROM mo_motive mk,pr_component kl
                        WHERE mk.motive_id = numotiveid
                                AND kl.component_status_id <> 9
                                AND mk.product_id = kl.product_id
                        ORDER BY kl.component_type_id
                    ) LOOP
                IF i.component_type_id = 7038 THEN
                            nunumber     := 1;
                            nuprodmotive := 10346;
                            sbtagname    := 'C_GAS_10346';
                            nuclasserv   := NULL;
                ELSIF i.component_type_id = 7039 THEN
                            nunumber     := 2;
                            nuprodmotive := 10348;
                            sbtagname    := 'C_MEDICION_10348';
                            nuclasserv   := 3102;
                END IF;
                rcComponent.component_id         := mo_bosequences.fnugetcomponentid();
                rcComponent.component_number     := nunumber;
                rcComponent.obligatory_flag      := 'N';
                rcComponent.obligatory_change    := 'N';
                rcComponent.notify_assign_flag   := 'N';
                rcComponent.authoriz_letter_flag := 'N';
                rcComponent.status_change_date   := SYSDATE;
                rcComponent.recording_date       := SYSDATE;
                rcComponent.directionality_id    := 'BI';
                rcComponent.custom_decision_flag := 'N';
                rcComponent.keep_number_flag     := 'N';
                rcComponent.motive_id            := numotiveid;
                rcComponent.prod_motive_comp_id  := nuprodmotive;
                rcComponent.component_type_id    := i.component_type_id;
                rcComponent.motive_type_id       := 75;
                rcComponent.motive_status_id     := 15;
                rcComponent.product_motive_id    := 100304;
                rcComponent.class_service_id     := nuclasserv;
                rcComponent.package_id           := nuSolicitud;
                rcComponent.product_id           := i.product_id;
                rcComponent.service_number       := i.product_id;
                rcComponent.component_id_prod    := i.component_id;
                rcComponent.uncharged_time       := 0;
                rcComponent.product_origin_id    := i.product_id;
                rcComponent.quantity             := 1;
                rcComponent.tag_name             := sbtagname;
                rcComponent.is_included          := 'N';
                rcComponent.category_id          := pkg_bcproducto.fnucategoria(i.product_id); 
                rcComponent.subcategory_id       := pkg_bcproducto.fnusubcategoria(i.product_id);
                damo_component.Insrecord(rcComponent);
                IF i.component_type_id = 7038 THEN
                    nucomppadre :=  rcComponent.component_id;
                END IF;
                IF(nuMotiveId IS NOT NULL)THEN
                        rcmo_comp_link.child_component_id  := rcComponent.component_id;
                        IF i.component_type_id = 7039 THEN
                           rcmo_comp_link.father_component_id := nucomppadre;
                        ELSE
                           rcmo_comp_link.father_component_id := NULL;
                        END IF;
                        rcmo_comp_link.motive_id := nuMotiveId;
                        damo_comp_link.insrecord(rcmo_comp_link);
                END IF;
            END LOOP;
        END IF;
    END IF;
    pkg_traza.trace(csbMetodo||' nuSolicitud: '||nuSolicitud, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

 RETURN nuSolicitud;
 EXCEPTION
 WHEN pkg_error.controlled_error THEN 
      pkg_Error.getError(onuError, osbError); 
      pkg_traza.trace('osbError: ' || osbError, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);      
      RETURN nuSolicitud;
 WHEN OTHERS THEN
      pkg_error.seterror;  
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace('osbError: ' || osbError, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);       
      RETURN nuSolicitud;
 END FNUGETSOLIRECO;

 FUNCTION FNUGETSOLICERTRP ( inuproducto IN NUMBER,
                             inumediorece IN NUMBER,
                             isbobservacion IN VARCHAR2,
                             onuerror OUT NUMBER,
                             osberror OUT VARCHAR2) RETURN NUMBER IS
 /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : FNUGETSOLICERTRP
    Descripcion : funcion que genera tramite de certificacion

    Parametros Entrada
    inuproducto     codigo del producto
    iinumediorece   medio de recepcion
    isbobservacion  observacion

    Valor de salida
    onuError  codigo de error
    osbError  mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA      AUTOR      DESCRIPCION
    04/12/2023 Adrianavg  Se retira el cursor cugetDatosProd, ya no se necesitan esos datos para el XML y se crea el cursor cuCliente
                          Se reemplaza el tipo de dato de la variable sbrequestxml1, de VARCHAR2 a constants_per.TIPO_XML_SOL
                          Se reemplaza el armado del XML P_GENERACION_SOLICITUD_DE_CERTIFICACION_PRP_100295 por pkg_xml_soli_rev_periodica.getXMSolicitudCertificacionRp
                          Se reemplaza os_registerrequestwithxml por API_REGISTERREQUESTBYXML
                          Se añade uso de pkg_error.prInicializaError
  ***************************************************************************/
    nuSolicitud         NUMBER;
    sbrequestxml1       constants_per.TIPO_XML_SOL%TYPE;
    numotiveid          mo_motive.motive_id%TYPE;    
    sbdireccionparseada VARCHAR2(4000);
    nudireccion         NUMBER;
    nulocalidad         NUMBER;
    nucategoria         NUMBER;
    nusubcategori       NUMBER;
    nucontratoid        NUMBER;
    nucliente           NUMBER; 

	-- Cursor para obtener id del cliente
    CURSOR cuCliente
    IS
    SELECT c.suscclie
      FROM suscripc c, pr_product pr
     WHERE c.susccodi = pr.subscription_id
       AND pr.product_id = inuproducto; 

    --Variables para gestión de traza
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'FNUGETSOLICERTRP';

  BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_error.prInicializaError(onuError, osbError); 
    pkg_traza.trace(csbMetodo||' inuproducto: '||inuproducto ||', inumediorece: '||inumediorece, csbNivelTraza);
    pkg_traza.trace(csbMetodo||' isbobservacion: '||isbobservacion, csbNivelTraza);   

    OPEN cuCliente;
    FETCH cuCliente INTO nucliente;
    CLOSE cuCliente;
    pkg_traza.trace(csbMetodo||' nucliente: '||nucliente, csbNivelTraza);

    sbrequestxml1 := pkg_xml_soli_rev_periodica.getXMSolicitudCertificacionRp (inumediorece,    --inuMedioRecepcionId
                                                                               isbobservacion,  -- isbComentario
                                                                               inuproducto,     -- inuProductoId
                                                                               nucliente       -- inuClienteId
                                                                               );--P_GENERACION_SOLICITUD_DE_CERTIFICACION_PRP_100295
    pkg_traza.trace(csbMetodo||' sbrequestxml1: '||sbrequestxml1, csbNivelTraza);  

    -- Procesamos el XML y generamos la solicitud
    API_REGISTERREQUESTBYXML( sbrequestxml1,
                              nuSolicitud,
                              numotiveid,
                              onuError,
                              osbError);

    pkg_traza.trace(csbMetodo||'API_REGISTERREQUESTBYXML--> nuSolicitud: '||nuSolicitud||', numotiveid: '||numotiveid, csbNivelTraza);      
    pkg_traza.trace(csbMetodo||'API_REGISTERREQUESTBYXML--> onuError: '||onuError||', osbError: '||osbError, csbNivelTraza);     
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

  RETURN nuSolicitud;

 EXCEPTION
 WHEN pkg_error.controlled_error THEN 
      pkg_Error.getError(onuError, osbError); 
      pkg_traza.trace('osbError: ' || osbError, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);       
      RETURN nuSolicitud;
 WHEN OTHERS THEN 
      pkg_error.seterror;  
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace('osbError: ' || osbError, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
      RETURN nuSolicitud;
 END FNUGETSOLICERTRP;

 FUNCTION FNUGETSUSPDUMMY(inuproducto IN NUMBER) RETURN NUMBER IS
 /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : FNUGETSUSPDUMMY
    Descripcion : funcion que  valida si un producto esta suspendido por dummy

    Parametros Entrada
    inuproducto    codigo del producto

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA      AUTOR      DESCRIPCION
    04/12/2023 Adrianavg  Se retira FBLAPLICAENTREGAXCASO('0000472').
                          Se declaran variables para el manejo de error onuerrorcode, osberrormessage
                          Se añade uso de pkg_error.prInicializaError
  ***************************************************************************/
    nuSusp NUMBER := 0;

    sbactividades VARCHAR2(4000) := DALDC_PARAREPE.fsbGetPARAVAST('LDC_ACTIVISUSPDUMMY', NULL);

    CURSOR cuValidaactividad IS
    SELECT 1
      FROM pr_product p, or_order_activity oa
     WHERE p.product_id = inuproducto
       AND p.product_id =  oa.product_id
       AND p.SUSPEN_ORD_ACT_ID = oa.ORDER_ACTIVITY_ID
       AND oa.ACTIVITY_ID IN (SELECT TO_NUMBER(REGEXP_SUBSTR(sbactividades,'[^,]+', 1, LEVEL)) AS activi
                                FROM dual
                          CONNECT BY REGEXP_SUBSTR(sbactividades, '[^,]+', 1, LEVEL) IS NOT NULL  );

    --Variables para gestión de traza
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'FNUGETSUSPDUMMY';
	  onuErrorCode        NUMBER;
    osbErrorMessage     VARCHAR2(4000);
 BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_error.prInicializaError(onuerrorcode, osbErrorMessage);
    pkg_traza.trace(csbMetodo||' inuproducto: '||inuproducto, csbNivelTraza);

     OPEN cuValidaactividad;
    FETCH cuValidaactividad INTO nuSusp;
    IF cuValidaactividad%NOTFOUND THEN
       nuSusp := 0;
    END IF;
    CLOSE cuValidaactividad;      
    pkg_traza.trace(csbMetodo||' nuSusp: '||nuSusp, csbNivelTraza);   
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    RETURN nuSusp;
 EXCEPTION
 WHEN OTHERS THEN
      pkg_error.seterror;  
      pkg_Error.getError(onuerrorcode, osbErrorMessage);
      pkg_traza.trace('osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
      RETURN nuSusp;
 END FNUGETSUSPDUMMY;

 PROCEDURE PRGENSUSPACOMRP IS
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : PRGENSUSPACOMRP
    Descripcion : plugin genera suspension por acometida

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA      AUTOR      DESCRIPCION
    05/12/2023 Adrianavg  OSF-1836: Se reemplaza ge_bopersonal.fnugetpersonid por pkg_bopersonal.fnugetpersonaid
                          Se reemplaza el tipo de dato de la variable sbrequestxml1, de VARCHAR2 a constants_per.TIPO_XML_SOL
                          Se retira IF FBLAPLICAENTREGAXCASO('0000472')
                          Se añade uso de pkg_error.prInicializaError
                          Se retiran variables declaradas sin uso y otras que ya no aplican: ex_error, nuparano, nuparmes
                          nutsess, sbparuser, dtplazominrev, numarca, numarcaantes, nucontacomponentes, nunumber, nuprodmotive
                          sbtagname, nuclasserv, nucomppadre, rcComponent, rcmo_comp_link, sbsolicitudes
                          Se reemplaza or_bolegalizeorder.fnuGetCurrentOrder por pkg_bcordenes.fnuobtenerotinstancialegal
                          Se reemplaza daor_order.fnugetcausal_id por pkg_bcordenes.fnuobtienecausal
                          Se reemplaza SELECT-INTO por cursor cuDatosTramite, se añade IF-ENDIF para enviar a RAISE NO_DATA_FOUND en caso 
                          de no encontrar dato
                          Se reemplaza ldc_proactualizaestaprog por pkg_estaproc.practualizaestaproc
                          Se reemplaza os_assign_order por api_assign_order
                          Se reemplaza daor_order_person.fnugetperson_id por pkg_bcordenes.fnuobtenerpersona
                          Se reemplaza or_boorderactivities.createactivity por api_createorder
    07/12/2023 Adrianavg  OSF-1836: Se reemplaza Pkg_Error.Seterrormessage(pkg_error.CNUGENERIC_MESSAGE, mensaje) 
                          por pkg_error.setErrorMessage( isbMsgErrr => 'mensaje de Error'); 
                          Se retiran los RAISE de pkg_error.controlled_error que se encuentran posterior a un Pkg_Error.Seterrormessage(isbMsgErrr => sbmensa); 
  ***************************************************************************/
	  onuErrorCode        NUMBER;
    osbErrorMessage     VARCHAR2(4000);
    nuPackage_id        mo_packages.package_id%TYPE;
    nuMotiveId          mo_motive.motive_id%TYPE;
    sbrequestxml1       constants_per.TIPO_XML_SOL%TYPE;
    nuorden             or_order.order_id%TYPE;
    dtfechasuspension   DATE;
    sbComment           VARCHAR2(2000);
    nuProductId         NUMBER;
    nuContratoId        NUMBER;
    nuTaskTypeId        NUMBER;
    nuCausalOrder       NUMBER; 
    nupakageid          mo_packages.package_id%TYPE;
    nucliente           ge_subscriber.subscriber_id%TYPE;
    numediorecepcion    mo_packages.reception_type_id%TYPE;
    sbdireccionparseada ab_address.address_parsed%TYPE;
    nudireccion         ab_address.address_id%TYPE;
    nulocalidad         ab_address.geograp_location_id%TYPE;
    nucategoria         mo_motive.category_id%TYPE;
    nusubcategori       mo_motive.subcategory_id%TYPE;
    sw                  NUMBER(2) DEFAULT 0; 
    sbmensa             VARCHAR2(10000);

    sbflag              VARCHAR2(1);
    numeresuspadmin     mo_packages.reception_type_id%TYPE;
    nuunidadoperativa   or_order.operating_unit_id%TYPE;
    inuSUSPENSION_TYPE_ID ldc_marca_producto.SUSPENSION_TYPE_ID%TYPE;
    nutipoCausal        NUMBER;
    nuCausal            NUMBER;
    nuEstadoPro         NUMBER;
    dtFechaeje          DATE;

  --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
  CURSOR cuProducto(nuorden NUMBER) IS
   SELECT product_id, subscription_id, ot.task_type_id,package_id,at.subscriber_id,ot.operating_unit_id,
        (SELECT person_id
		   FROM or_order_person P
		  WHERE P.order_id = ot.order_id
		    AND ROWNUM < 2) persona,
						 OT.EXECUTION_FINAL_DATE
     FROM or_order_activity at, or_order ot
    WHERE at.order_id = nuorden
      AND package_id IS NOT NULL
      AND at.order_id = ot.order_id
      AND ROWNUM   = 1;

  -- Cursor para obtener los componentes asociados a un motivo
   CURSOR cuComponente(nucumotivos mo_motive.motive_id%TYPE) IS
   SELECT COUNT(1)
     FROM mo_component C
    WHERE c.package_id = nucumotivos;

    CURSOR cuDatosTramite(p_nuproductid pr_product.product_id%TYPE)
    IS
    SELECT di.address_parsed ,di.address_id, di.geograp_location_id, pr.category_id, pr.subcategory_id, pr.product_status_id
      FROM pr_product pr,ab_address di
     WHERE pr.product_id = p_nuproductid
       AND pr.address_id = di.address_id;   

	--INICIO CA 472
	  nuPersonaLega       ge_person.person_id%TYPE := pkg_bopersonal.fnugetpersonaid;
    nuLectura           NUMBER;
    nuCodigoAtrib       NUMBER := Dald_parameter.fnuGetNumeric_Value('LDC_CODIATRLECTSUSPAD',NULL);
    sbNombreoAtrib      VARCHAR2(100) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_NOMBATRLECTSUSPAD',NULL);
	  nuSuspOtPr          NUMBER := 0;
	  inuorder_id NUMBER;
	  inuorderact_id  NUMBER;
	  nuActividadGene NUMBER := DALDC_PARAREPE.fnuGetPAREVANU('ACTIVITY_USUA_YA_SUSP_ACO_RP', NULL);
	--FIN CA 472

    --Variables para gestión de traza
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'PRGENSUSPACOMRP';

 BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_error.prInicializaError(onuerrorcode, osbErrorMessage); 

    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuorden       := pkg_bcordenes.fnuobtenerotinstancialegal;
    nucausalorder := pkg_bcordenes.fnuobtienecausal(nuorden);
    pkg_traza.trace(csbMetodo||' nuorden: '||nuorden||', nucausalorder: '||nucausalorder, csbNivelTraza); 

    -- obtenemos el producto y el paquete
    OPEN cuproducto(nuorden);
    FETCH cuProducto INTO nuproductid, nucontratoid, nutasktypeid,nupakageid,nucliente,nuunidadoperativa, nuPersonaLega, dtFechaeje;
    IF cuProducto%NOTFOUND THEN
       sbmensa := 'Proceso termino con errores : '||'El cursor cuProducto no arrojo datos con el # de orden'||TO_CHAR(nuorden);
       Pkg_Error.Seterrormessage(isbMsgErrr => sbmensa);       
     END IF;
    CLOSE cuproducto;

    pkg_traza.trace(csbMetodo||' nuproductid: '   ||nuproductid||', nucontratoid: '   ||nucontratoid, csbNivelTraza);     
    pkg_traza.trace(csbMetodo||' nutasktypeid: '  ||nutasktypeid||', nupakageid: '    ||nupakageid, csbNivelTraza);  
    pkg_traza.trace(csbMetodo||' nucliente: '     ||nucliente||', nuunidadoperativa: '||nuunidadoperativa, csbNivelTraza);
    pkg_traza.trace(csbMetodo||' nuPersonaLega: ' ||nuPersonaLega||', dtFechaeje: '   ||dtFechaeje, csbNivelTraza);

    -- Obtenemos los datos de la solicitud de visita de verificacion para generar el tramite de defecto critico
    sbdireccionparseada := NULL;
    nudireccion         := NULL;
    nulocalidad         := NULL;
    nucategoria         := NULL;
    nusubcategori       := NULL;
    sw                  := 1;
		BEGIN
             OPEN cuDatosTramite(nuproductid);
            FETCH cuDatosTramite INTO sbdireccionparseada
									 ,nudireccion
									 ,nulocalidad
									 ,nucategoria
									 ,nusubcategori
									 ,nuEstadoPro;
            CLOSE cuDatosTramite; 
            IF nudireccion IS NULL THEN 
               Pkg_Error.Seterror;
               RAISE NO_DATA_FOUND; 
            END IF;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				 sw := -1;
		END;
        pkg_traza.trace(csbMetodo||' nuEstadoPro: '||nuEstadoPro , csbNivelTraza);

		IF nuEstadoPro = 2 THEN
		  nuSuspOtPr := FNUGETSUSPCMOTPR(nuproductid);
          pkg_traza.trace(csbMetodo||' nuSuspOtPr: '||nuSuspOtPr , csbNivelTraza);

			IF NOT FBLGETPRODUCTOVENC(nuproductid, dtFechaeje) AND nuSuspOtPr = 0 THEN
			 	IF INSTR(DALD_PARAMETER.FSBGETVALUE_CHAIN('TITRCAUSL_REPADEFCRIT_SUSPACOM'), nuTaskTypeId||'|'||nucausalorder) > 0 THEN
					sw := 0;
				END IF;
			END IF;
		END IF;
        pkg_traza.trace(csbMetodo||' sw: '||sw , csbNivelTraza);

		IF sw = 1 THEN
			IF nuSuspOtPr = 0 and nuEstadoPro = 1 THEN
					-- Construimos XML para generar el tramite
					numediorecepcion := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_REPARACION_PRP');
					nuPackage_id      := NULL;
					nuMotiveId        := NULL;
					onuErrorCode      := NULL;
					osbErrorMessage   := NULL;
					dtfechasuspension := SYSDATE + 1 / 24 / 60;
					numeresuspadmin := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_SUSPADM_PRP',NULL);
                    pkg_traza.trace(csbMetodo||' numeresuspadmin: '||numeresuspadmin, csbNivelTraza);

					inuSUSPENSION_TYPE_ID := LDCI_PKREVISIONPERIODICAWEB.fnuTipoSuspension(nuproductid);
                    pkg_traza.trace(csbMetodo||' inuSUSPENSION_TYPE_ID: '||inuSUSPENSION_TYPE_ID, csbNivelTraza);

					nutipoCausal := Dald_parameter.fnuGetNumeric_Value('TIPO_CAUSAL_100013_SUSP_ACOME',NULL);
					pkg_traza.trace(csbMetodo||' nutipoCausal: '||nutipoCausal , csbNivelTraza);

                    IF nutipoCausal IS NULL THEN
                       Pkg_Error.Seterrormessage(isbMsgErrr =>'No existe datos para el parametro TIPO_CAUSAL_100013_SUSP_ACOME, definalos por el comando LDPAR');
					END IF;

					nuCausal := Dald_parameter.fnuGetNumeric_Value('CAUSAL_SUSP_ACOM_100013',NULL);
                    pkg_traza.trace(csbMetodo||' nuCausal: '||nuCausal , csbNivelTraza);

					IF nuCausal IS NULL THEN
                       Pkg_Error.Seterrormessage( isbMsgErrr => 'No existe datos para el parametro COD_CAUSA_SUSP_ADM_XML, definalos por el comando LDPAR');
					END IF;

					IF nuPersonaLega IS NULL THEN
                       sbmensa := 'Proceso termino con errores : No se encontro persona que legaliza';
                       Pkg_Error.Seterrormessage( isbMsgErrr => sbmensa);
					END IF;

					nuLectura := ldc_boordenes.fsbDatoAdicTmpOrden(nuorden,nuCodigoAtrib,TRIM(sbNombreoAtrib));
					pkg_traza.trace(csbMetodo||' nuLectura: '||nuLectura , csbNivelTraza);

                    IF nulectura  IS NULL THEN
                       sbmensa := 'Proceso termino con errores : '||'No se ha digitado Lectura';
                       pkg_error.seterrormessage( isbMsgErrr => sbmensa);
					END IF;

					sbcomment := '[GENERACION PLUGIN]| LEGALIZACION ORDEN['||nuorden||']|LECTURA['||nuLectura||']|PERSONA['||nuPersonaLega||']|  CON CAUSAL : '||to_char(nucausalorder);
                    pkg_traza.trace(csbMetodo||' sbcomment: '||sbcomment , csbNivelTraza);

					nuPackage_id := LDC_PKGESTIONCASURP.fnuGeneTramSuspRP(  nuproductid,
                                                                            numeresuspadmin,
                                                                            nutipoCausal,
                                                                            nuCausal,
                                                                            inuSUSPENSION_TYPE_ID,
                                                                            sbcomment,
                                                                            onuErrorCode,
                                                                            osbErrorMessage);

					pkg_traza.trace(csbMetodo||' nuPackage_id: '||nuPackage_id , csbNivelTraza);

                    IF nuPackage_id IS NULL THEN
                       sbmensa := 'OT: '||nuorden||'.Proceso termino con errores : '||' Error al generar la solicitud de suspension administrativa x xml. Codigo error : '||to_char(onuErrorCode)||' Mensaje de error : '||osbErrorMessage;
					   pkg_estaproc.practualizaestaproc('LDC_CREATRAMITESUSPACOMET'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS'),'Ok',sbmensa); 
					   Pkg_Error.Seterrormessage(isbMsgErrr => sbmensa);
					ELSE
                        INSERT INTO LDC_BLOQ_LEGA_SOLICITUD(PACKAGE_ID_ORIG, PACKAGE_ID_GENE)
                        VALUES(nupakageid,  nuPackage_id);
                        pkg_traza.trace(csbMetodo||' Insert en LDC_BLOQ_LEGA_SOLICITUD ' , csbNivelTraza);

                        sbflag := ldc_fsbretornaaplicaasigauto(nutasktypeid,nucausalorder);
                        pkg_traza.trace(csbMetodo||' sbflag: '||sbflag, csbNivelTraza);                       

                        IF nvl(sbflag,'N') = 'S' THEN
                           ldc_procrearegasiunioprevper(nuunidadoperativa,nuproductid,nutasktypeid,nuorden,nuPackage_id);
                        END IF;

                        -- Dejamos la solicitud como estaba
                        UPDATE mo_packages m
                           SET m.motive_status_id = 13
                         WHERE m.package_id = nupakageid;
                         pkg_traza.trace(csbMetodo||' Actualizar la solicitud a como estaba '||SQL%ROWCOUNT , csbNivelTraza);
                         sbmensa := 'OT:'||nuorden||'.Proceso termino Ok. Se genero la solicitud Nro : '||TO_CHAR(nuPackage_id);
					END IF;

		     ELSE

               --genera actividad
                api_createorder(nuActividadGene,--inuItemsid
                                nupakageid,     --inuPackageid
                                NULL,           --inuMotiveid
                                NULL,           --inuComponentid
                                NULL,           --inuInstanceid
                                nudireccion,    --inuAddressid
                                NULL,           --inuElementid
                                nucliente,      --inuSubscriberid
                                nucontratoid,   --inuSubscriptionid
                                nuproductid,    --inuProductid
                                NULL,           --inuOperunitid
                                NULL,           --idtExecestimdate
                                NULL,           --inuProcessid
                                NULL,           --isbComment
                                FALSE,          --iblProcessorder
                                NULL,           --inuPriorityid
                                NULL,           --inuOrdertemplateid
                                NULL,           --isbCompensate
                                NULL,           --inuConsecutive
                                NULL,           --inuRouteid
                                NULL,           --inuRouteConsecutive
                                NULL,           --inuLegalizetrytimes
                                NULL,           --isbTagname
                                TRUE,           --iblIsacttoGroup
                                NULL,           --inuRefvalue
                                NULL,           --inuActionid
                                inuorder_id,    --ionuOrderid
                                inuorderact_id, --ionuOrderactivityid
                                onuErrorCode,   --onuErrorCode
                                osbErrorMessage --osbErrorMessage
                                ); 


                 pkg_traza.trace(csbMetodo||' inuorder_id: '||inuorder_id||', inuorderact_id: '||inuorderact_id, csbNivelTraza);

				 IF inuorder_id IS NOT NULL THEN
				    -- ASIGNAR LA ORDEN A LA UNIDAD OPERATIVA
				    API_ASSIGN_ORDER(inuorder_id,       -- inuOrder 
                                     nuunidadoperativa, --inuOperatingUnit 
                                     onuerrorcode,      --onuErrorCode,
                                     osberrormessage    --osbErrorMessage 
                                    );
					  IF onuErrorCode = 0 THEN
						--Relacionar OT Padre con OT Hija
						INSERT INTO or_related_order (ORDER_ID, RELATED_ORDER_ID, RELA_ORDER_TYPE_ID)
						VALUES   (nuorden, inuorder_id, 13);
                        pkg_traza.trace(csbMetodo||' Relacionar OT Padre con OT Hija nuorden: '||nuorden||', inuorder_id: '||inuorder_id, csbNivelTraza);
						-------------------------------
						INSERT INTO LDC_PRODUCTOPARASUSP (PRODUCT_ID,ORDER_ID,PROCESO,RESPONSABLE_ID) VALUES(nuProductId,inuorder_id,'USER_YA_SUSPE_ACO', pkg_bcordenes.fnuobtenerpersona(nuorden));
                        pkg_traza.trace(csbMetodo||' Insertar en LDC_PRODUCTOPARASUSP - Proceso: USER_YA_SUSPE_ACO', csbNivelTraza);
					  ELSE
						  sbmensa := 'Proceso termino con errores : '||osberrormessage||' ';
						  Pkg_Error.Seterrormessage(isbMsgErrr => sbmensa);
					  END IF;
				  END IF;

		  END IF;
	    ELSE
			IF sw <> 0 THEN
				sbmensa := 'OT:'||nuorden||'.Proceso termino con errores : '||'No se encontraron datos de la solicitud asociada a la orden # '||TO_CHAR(nuorden);
				Pkg_Error.Seterrormessage(isbMsgErrr => sbmensa);
			END IF;

		END IF;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

 EXCEPTION
	WHEN pkg_error.controlled_error THEN
       pkg_Error.getError(onuerrorcode, osbErrorMessage); 
       pkg_traza.trace('osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);       
       RAISE pkg_error.controlled_error;
  WHEN OTHERS THEN
       pkg_error.seterror;  
       pkg_Error.getError(onuerrorcode, osbErrorMessage);
       pkg_traza.trace('osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
	     RAISE pkg_error.controlled_error;
 END PRGENSUSPACOMRP;


 FUNCTION FNUVALCAUSOLSUSPDUMMY ( nusolicitud NUMBER) RETURN NUMBER IS
 /**********************************************************************
    Propiedad intelectual de Arquitecsoft
    Nombre   FNUVALCAUSOLSUSPDUMMY
    Autor    lUIS JAVIER LOPEZ BARRIOS
    Fecha    23/03/2021

    Descripción: SERIVICIO PARA VALIDAR SI EL CAUSAL DE LA SOLICITUD ESTA RELACIONADA
                 AL PARAMETRO LDC_CAUSDUMMY

    Historia de Modificaciones
    FECHA      AUTOR      DESCRIPCION
    05/12/2023 Adrianavg  OSF-1836: Se declaran variables para el manejo de error onuerrorcode, osberrormessage
                          Se hace uso del pkg_error.prInicializaError
  ***********************************************************************/
    nuCausalExsite NUMBER;

    CURSOR cucausalsolicitud 
    IS
    SELECT mm.causal_id,
           cc.causal_type_id
     FROM mo_motive mm, cc_causal cc
    WHERE mm.package_id = nusolicitud
      AND mm.causal_id = cc.causal_id;

    nuCausalSolicitud       NUMBER;
    nuTipocausal            NUMBER;
    nuCausalParametro       NUMBER;
    nuTipoCausalParametro   NUMBER;

    --Variables para gestión de traza
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'fnuvalcausolsuspdummy';
	  onuErrorCode        NUMBER;
    osbErrorMessage     VARCHAR2(4000);
  BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_error.prInicializaError(onuerrorcode, osbErrorMessage); 

     OPEN cucausalsolicitud;
    FETCH cucausalsolicitud INTO
          nucausalsolicitud,
          nutipocausal;
    CLOSE cucausalsolicitud;
    pkg_traza.trace(csbMetodo||' nucausalsolicitud: '||nucausalsolicitud||', nutipocausal: '||nutipocausal, csbNivelTraza);        

    nucausalparametro := daldc_pararepe.fnugetparevanu('LDC_CAUSDUMMY', 0);
    pkg_traza.trace(csbMetodo||' nucausalparametro: '||nucausalparametro, csbNivelTraza);

    nutipocausalparametro := daldc_pararepe.fnugetparevanu('LDC_TIPOCAUSDUMMY', 0);
    pkg_traza.trace(csbMetodo||' nutipocausalparametro: '||nutipocausalparametro, csbNivelTraza);

    nucausalexsite := 0;
    IF nucausalsolicitud = nucausalparametro AND nutipocausal = nutipocausalparametro THEN
        nucausalexsite := 1;
    END IF;
    pkg_traza.trace(csbMetodo||' nucausalexsite: '||nucausalexsite, csbNivelTraza);   

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

 RETURN nucausalexsite;
 EXCEPTION
 WHEN OTHERS THEN
      pkg_error.seterror;   
      pkg_Error.getError(onuerrorcode, osbErrorMessage);
      pkg_traza.trace('osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);  
      RETURN nucausalexsite;
 END fnuvalcausolsuspdummy;

 FUNCTION FNUGETMARCAPROD ( nusolicitud IN NUMBER, inuproducto IN NUMBER) RETURN NUMBER IS
 /**********************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Nombre      : FNUGETMARCAPROD

    Descripción: funcion que se encarga de retornar la marca del producto

    Parametros Entrada
    nuSolicitud    codigo de solicitud
    inuproducto    codigo del producto

    Historia de Modificaciones
    FECHA      AUTOR      DESCRIPCION
    05/12/2023 Adrianavg  OSF-1836: Se declaran variables para el manejo de error onuerrorcode, osberrormessage
                          Se hace uso del pkg_error.prInicializaError    
  ***********************************************************************/
   NUMarca NUMBER;

   CURSOR cugetMarcaProdSoli IS
   SELECT MARCA_ANTES
     FROM ldc_creatami_revper
    WHERE SOLICITUD = nuSolicitud 
      AND PRODUCTO = inuproducto;

    --Variables para gestión de traza
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'fnugetmarcaprod';
	  onuErrorCode        NUMBER;
    osbErrorMessage     VARCHAR2(4000);
 BEGIN 

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_error.prInicializaError(onuerrorcode, osbErrorMessage); 

    NUMarca := ldc_fncretornamarcaprod(inuproducto); 
    pkg_traza.trace(csbMetodo||' NUMarca: '||NUMarca, csbNivelTraza);

   RETURN  NUMarca;
 EXCEPTION
 WHEN OTHERS THEN
      pkg_error.seterror;  
      pkg_Error.getError(onuerrorcode, osbErrorMessage);
      pkg_traza.trace('osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);   
      RETURN -1;
 END FNUGETMARCAPROD;

END LDC_PKGESTIONLEGAORRP ;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKGESTIONLEGAORRP
BEGIN
  pkg_utilidades.prAplicarPermisos('LDC_PKGESTIONLEGAORRP','OPEN');
END;
/