  CREATE OR REPLACE PACKAGE LDC_PKPROCSERVVARIOS IS
/*******************************************************************************************************
    Propiedad intelectual de Gases del Caribe S.A (c).

    Unidad         : ldc_pkprocservvarios
    Descripcion    : Paquete con logica para procesos PRE en UOBYSOL
    Autor          : Horbath
    Fecha          : 2019-08-01
  
    Historia de Modificaciones
        DD-MM-YYYY      <Autor>.                Modificacion
        -----------     -------------------     ------------------------------------
        16-05-2024      felipe.valencia         OSF-2562: Se realiza modificación 
                                                al procedimiento PRPROCGENVSI para 
                                                agregar la orden a la tabla temporal
                                                tmp_generica y se realizan modificaciones
                                                técnicas.
        24-05-2023      jcatuchemvm             OSF-1340: Se ajusta procedimiento
                                                    [PRPROCGENVSI]
                                                    [PRASIGORDENSERNUE]
                                                    [PRASIGORDENVSISERNUE]
                                                    [PRJOB_GENEVSIDIASDESPUES]      
                                                    [PRPROCGENOT_AUTONOMA]                                              
                                                Se ajustan llamados a pkerror por los correspondientes en pkg_error.
                                                Se eliminan los esquemas en llamados a métodos o tablas de open.
        29-11-2022      jcatuchemvm             OSF-705: Se ajusta procedimiento
                                                    [PRASIGORDENVSISERNUE]
                                                    [PRASIGORDENSERNUE]
        01-08-2019      Horbath                 Creacion
*******************************************************************************************************/
  FUNCTION PRASIGORDENSERNUE(sbin IN VARCHAR2) RETURN VARCHAR2;
  /**************************************************************************
   Autor       : Horbath
   Fecha       : 2019-08-01
   Ticket      : 200-2630
   Descripcion : proceso PRE para asigancion en UOBYSOL

   Parametros Entrada
   sbin   cadena con orden de trabajo

   Valor de salida

   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  FUNCTION PRASIGORDENVSISERNUE(sbin IN VARCHAR2) RETURN VARCHAR2;
  /**************************************************************************
   Autor       : Horbath
   Fecha       : 2019-08-01
   Ticket      : 200-2630
   Descripcion : proceso PRE para asignacion en UOBYSOL

   Parametros Entrada
   sbin   cadena con orden de trabajo

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
     09/12/2020   dvaliente   Se obtiene el comentario de legalizacion y se anexo al comentario de la nueva solicitud VSI. (Caso 132)
  ***************************************************************************/

  PROCEDURE PRPROCVALIDAITEM;
  /**************************************************************************
     Autor       : Horbath
     Fecha       : 2019-08-01
     Ticket      : 200-2630
     Descripcion : plugin para validar que items del parametro LDC_CODITEMVA se legalicen

     Parametros Entrada

     Valor de salida

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE PRVALMARPRODXCAU;
  /**************************************************************************
     Autor       : Horbath
     Fecha       : 2019-11-27
     Ticket      : 200-2630
     Descripcion : plugin para validar la marca

     Parametros Entrada

     Valor de salida

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  
  PROCEDURE PRPROCGENOT_AUTONOMA;
    /**************************************************************************
       Autor       : DSALTARIN
       Fecha       : 2019-08-01
       Ticket      : 263
       Descripcion : plugin para generar OT AUTONOMA.

       Parametros Entrada

       Valor de salida

       HISTORIA DE MODIFICACIONES
       FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/  
    
  PROCEDURE PRJOB_GENEVSIDIASDESPUES;
    /**************************************************************************
       Autor       : DSALTARIN
       Fecha       : 2019-08-01
       Ticket      : 263
       Descripcion : JOB PARA GENERAR VSI DE ACUERDO A DIAS CONFIGURADOS EN
                     LDC_COTTCLAC

       Parametros Entrada

       Valor de salida

       HISTORIA DE MODIFICACIONES
       FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/      

    FUNCTION fsbVersion 
    RETURN VARCHAR2;

END LDC_PKPROCSERVVARIOS;
/
CREATE OR REPLACE PACKAGE BODY LDC_PKPROCSERVVARIOS IS
	-- Identificador del ultimo caso que hizo cambios
	csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2562';
	-- Constantes para el control de la traza
  csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  csbNivelTraza           CONSTANT NUMBER(2)     := pkg_traza.fnuNivelTrzDef;

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : fsbVersion
	Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor       	: Luis Felipe Valencia Hurtado
    Fecha       	: 29-01-2024

    Modificaciones  :
    Autor                   Fecha        Caso       Descripcion
    Felipe.valencia         29-01-2024   OSF-2562   Creación
	***************************************************************************/
	FUNCTION fsbVersion 
	RETURN VARCHAR2 
	IS
	BEGIN
		RETURN csbVersion;
	END fsbVersion;

  FUNCTION PRASIGORDENSERNUE(sbin IN VARCHAR2) RETURN VARCHAR2 IS
    /**************************************************************************
     Autor       : Horbath
     Fecha       : 2019-08-01
     Ticket      : 200-2630
     Descripcion : proceso PRE para asigancion en UOBYSOL

     Parametros Entrada
     sbin   cadena con orden de trabajo

     Valor de salida

     HISTORIA DE MODIFICACIONES
    FECHA           AUTOR                               DESCRIPCION
    14/07/2023      jcatuchemvm                         OSF-1340: Se actualizan los llamados OS_ASSIGN_ORDER por API_ASSIGN_ORDER
                                                        y os_addordercomment por API_ADDORDERCOMMENT
    29/NOV/2022     jcatuchemvm                         OSF-705: Se elimina asignacion de unidad operativa -1 si no se encuentra unidad 
                                                        en orden de revision. Llamado desde LDC_BOASIGAUTO no evalua correctamente la unidad -1 
                                                        para la asignacion.
    24/OCT/2020     John Jairo Jimenez Marim?n(JJJM)    CA516 Se modifica para cuando haya error
                                                            en la signaci?n, se guarde log invocando
                                                            el procedimiento LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp;
    ***************************************************************************/

    nuoperating_unit_id or_order.operating_unit_id%TYPE;
    sbdatain            VARCHAR2(4000);
    sbtrigger           VARCHAR2(4000);
    sbcategoria         VARCHAR2(4000);
    sborder_id          VARCHAR2(4000) := NULL;
    sbpackage_id        VARCHAR2(4000) := NULL;
    sbactivity_id       VARCHAR2(4000) := NULL;
    subscription_id     VARCHAR2(4000) := NULL;
    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || '.PRASIGORDENSERNUE';   
    
    nuTipoTrab NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_TITRVPSV'); --se almacena titr de visita
    sbcausales VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_CAUSASAU'); -- se almacena causales de legalizacion
    nuMeses    NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_NUMESES'); --se almacena numero de meses a validar
    nuContrato NUMBER; --se almacena contrato de la orden
    nuProducto NUMBER; --se almacena producto de la orden
    nuOrden    NUMBER; --se almacena orden de referencia

    onuerrorcode    NUMBER;
    osberrormessage VARCHAR2(4000);

    --Se consulta datos de la cadena
    CURSOR cudata IS
      SELECT column_value
        FROM TABLE(ldc_boutilities.splitstrings(sbin, '|'));

    --se consulta contrato y producto de la orden
    CURSOR cuGetContrato IS
      SELECT SUBSCRIPTION_ID, PRODUCT_ID
        FROM or_order_activity
       WHERE order_id = to_number(sborder_id);

    --se consulta orden de revision
    CURSOR cuOrdenRev IS
      SELECT O.order_id, O.OPERATING_UNIT_ID
        FROM or_order o, OR_ORDER_ACTIVITY oa
       WHERE o.order_id = oa.order_id
         AND oa.SUBSCRIPTION_ID = nuContrato
         AND oa.PRODUCT_ID = nuProducto
         AND o.task_type_id = nuTipoTrab
         AND o.order_status_id = 8
         AND o.causal_id in
             (select distinct REGEXP_SUBSTR(sbcausales, '[^,]+', 1, level)
                from dual
              connect by regexp_substr(sbcausales, '[^,]+', 1, level) is not null)
         AND O.LEGALIZATION_DATE >= ADD_MONTHS(sysdate, -nuMeses)
       ORDER BY LEGALIZATION_DATE DESC;

  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_traza.trace('INICIO PRASIGORDENSERNUE', pkg_traza.cnuNivelTrzDef);
    --OBTENER DATOS DE LA CADENA OBTENIDA DEL SERVICIO DE ASIGNACION
    FOR tempcudata IN cudata LOOP
      pkg_traza.trace(tempcudata.column_value, pkg_traza.cnuNivelTrzDef);
      IF sborder_id IS NULL THEN
        sborder_id      := tempcudata.column_value;
        osberrormessage := osberrormessage || ' - ' || sborder_id;
      ELSIF sbpackage_id IS NULL THEN
        sbpackage_id    := tempcudata.column_value;
        osberrormessage := osberrormessage || ' - ' || sbpackage_id;
      ELSIF sbactivity_id IS NULL THEN
        sbactivity_id   := tempcudata.column_value;
        osberrormessage := osberrormessage || ' - ' || sbactivity_id;
      ELSIF subscription_id IS NULL THEN
        subscription_id := tempcudata.column_value;
        osberrormessage := osberrormessage || ' - ' || subscription_id;
      ELSIF sbtrigger IS NULL THEN
        sbtrigger       := tempcudata.column_value;
        osberrormessage := osberrormessage || ' - ' || sbtrigger;
      ELSIF sbcategoria IS NULL THEN
        sbcategoria     := tempcudata.column_value;
        osberrormessage := osberrormessage || ' - ' || sbcategoria;
      END IF;
    END LOOP;

      IF cuGetContrato%isopen THEN
        CLOSE cuGetContrato;
      END IF;
    --se consulta el contrato y producto de la orden
    OPEN cuGetContrato;
    FETCH cuGetContrato
      INTO nuContrato, nuProducto;
    CLOSE cuGetContrato;

      IF cuOrdenRev%isopen THEN
        CLOSE cuOrdenRev;
      END IF;
    --se consulta orden de revision de menos de 3 meses
    OPEN cuOrdenRev;
    FETCH cuOrdenRev
      INTO nuOrden, nuoperating_unit_id;
    CLOSE cuOrdenRev;

    IF nuoperating_unit_id IS NOT NULL THEN
      -- inicio Asignar orden
      BEGIN
        
        API_ASSIGN_ORDER(to_number(sborder_id),
                        nuoperating_unit_id,
                        onuerrorcode,
                        osberrormessage);

        IF onuerrorcode = 0 THEN

          onuerrorcode    := null;
          osbErrorMessage := null;

          --se adiciona comentario
          API_ADDORDERCOMMENT(to_number(sborder_id),
                             1277,
                             'SERVICIO COTIZADO PREVIAMENTE EN SERVICIOS VARIOS LEGALIZADO (OT ' ||
                             nuOrden || ')',
                             onuErrorCode,
                             osbErrorMessage);

          IF onuerrorcode = 0 THEN
            ldc_boasigauto.prregsitroasigautolog(to_number(sbpackage_id),
                                                 to_number(sborder_id),
                                                 'LA ORDEN FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                                 nuoperating_unit_id || ']');


            UPDATE ldc_order
               SET asignado = 'S'
             WHERE nvl(package_id, 0) = nvl(to_number(sbpackage_id), 0)
               AND order_id = to_number(sborder_id);
          ELSE
            osberrormessage := 'NO SE PUDO REGISTRAR COMENTARIO A LA ORDEN [' ||
                               sborder_id || '] - MENSAJE DE ERROR  --> ' ||
                               osberrormessage;
            ldc_boasigauto.prregsitroasigautolog(to_number(sbpackage_id),
                                                 to_number(sborder_id),
                                                 osberrormessage);

          END IF;
        ELSE
          osberrormessage := 'LA ORDEN DE TRABAJO NO FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                             nuoperating_unit_id ||
                             '] - MENSAJE DE ERROR PROVENIENTE DE API_ASSIGN_ORDER --> ' ||
                             osberrormessage;
          ldc_boasigauto.prregsitroasigautolog(to_number(sbpackage_id),
                                               to_number(sborder_id),
                                               osberrormessage);

          /*CA516 JJJM*/
          LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp('PRASIGORDENSERNUE',
                                                                SYSDATE,
                                                                sborder_id,
                                                                NULL,
                                                                osberrormessage,
                                                                USER);

        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          sbdatain := 'INCONSISTENCIA EN SERVICIO PRASIGORDENSERNUE [' ||
                      dbms_utility.format_error_stack || '] - [' ||
                      dbms_utility.format_error_backtrace || ']';
          ldc_boasigauto.prregsitroasigautolog(null,
                                               to_number(sborder_id),
                                               'EL SERVICIO API_ASSIGN_ORDER NO PUDO ASIGNAR LA UNIDAD OPERATIVA A LA ORDEN [' ||
                                               sbdatain || ']');
      END;
      -- Fin Asignar orden
    ELSE
      -- sino obtuvo la UT
      nuoperating_unit_id := null;
    END IF;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN(to_char(nuoperating_unit_id));

  END PRASIGORDENSERNUE;

  FUNCTION PRASIGORDENVSISERNUE(sbin IN VARCHAR2) RETURN VARCHAR2 IS
    /**************************************************************************
     Autor       : Horbath
     Fecha       : 2019-08-01
     Ticket      : 200-2630
     Descripcion : proceso PRE para asignacion en UOBYSOL

     Parametros Entrada
     sbin   cadena con orden de trabajo

     Valor de salida

     HISTORIA DE MODIFICACIONES
    FECHA           AUTOR                               DESCRIPCION
    14/07/2023      jcatuchemvm                         OSF-1340: Se actualiza el llamado OS_ASSIGN_ORDER por API_ASSIGN_ORDER
    29/11/2022      jcatuchemvm                         OSF-705: Se elimina asignacion de unidad operativa -1 si no se encuentra unidad 
                                                        en LDC_ORDEASIGPROC. Llamado desde LDC_BOASIGAUTO no evalua correctamente la unidad -1 
                                                        para la asignacion.
    24/10/2020     John Jairo Jimenez Marim?n(JJJM)    CA516 Se modifica para cuando haya error
                                                            en la signaci?n, se guarde log invocando
                                                            el procedimiento LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp;
    ***************************************************************************/
    --Se consulta datos de la cadena
    CURSOR cudata IS
      SELECT column_value
        FROM TABLE(ldc_boutilities.splitstrings(sbin, '|'));

    nuoperating_unit_id or_order.operating_unit_id%TYPE;
    sbdatain            VARCHAR2(4000);
    sbtrigger           VARCHAR2(4000);
    sbcategoria         VARCHAR2(4000);
    sborder_id          VARCHAR2(4000) := NULL;
    sbpackage_id        VARCHAR2(4000) := NULL;
    sbactivity_id       VARCHAR2(4000) := NULL;
    subscription_id     VARCHAR2(4000) := NULL;
    onuerrorcode        NUMBER;
    osberrormessage     VARCHAR2(4000);

    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || '.PRASIGORDENVSISERNUE';

    --se consulta unidad operativa
    CURSOR cugetUnidad IS
      SELECT P.ORAOUNID
        FROM LDC_ORDEASIGPROC p
       WHERE P.ORAPSOGE = to_number(sbpackage_id)
         AND P.ORAOPROC = 'SEVAASAU';

  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    --OBTENER DATOS DE LA CADENA OBTENIDA DEL SERVICIO DE ASIGNACION
    FOR tempcudata IN cudata LOOP
      pkg_traza.trace(tempcudata.column_value, pkg_traza.cnuNivelTrzDef);
      IF sborder_id IS NULL THEN
        sborder_id      := tempcudata.column_value;
        osberrormessage := osberrormessage || ' - ' || sborder_id;
      ELSIF sbpackage_id IS NULL THEN
        sbpackage_id    := tempcudata.column_value;
        osberrormessage := osberrormessage || ' - ' || sbpackage_id;
      ELSIF sbactivity_id IS NULL THEN
        sbactivity_id   := tempcudata.column_value;
        osberrormessage := osberrormessage || ' - ' || sbactivity_id;
      ELSIF subscription_id IS NULL THEN
        subscription_id := tempcudata.column_value;
        osberrormessage := osberrormessage || ' - ' || subscription_id;
      ELSIF sbtrigger IS NULL THEN
        sbtrigger       := tempcudata.column_value;
        osberrormessage := osberrormessage || ' - ' || sbtrigger;
      ELSIF sbcategoria IS NULL THEN
        sbcategoria     := tempcudata.column_value;
        osberrormessage := osberrormessage || ' - ' || sbcategoria;
      END IF;
    END LOOP;

      IF cugetUnidad%isopen THEN
        CLOSE cugetUnidad;
      END IF;

    --se obtiene unidad operativa
    OPEN cugetUnidad;
    FETCH cugetUnidad
      into nuoperating_unit_id;
    CLOSE cugetUnidad;

    IF nuoperating_unit_id IS NOT NULL THEN
      -- inicio Asignar orden
      BEGIN
        --se quita bloqueo
        DELETE FROM LDC_BLOQ_LEGA_SOLICITUD
         WHERE PACKAGE_ID_GENE = to_number(sbpackage_id);

        API_ASSIGN_ORDER(to_number(sborder_id),
                        nuoperating_unit_id,
                        onuerrorcode,
                        osberrormessage);
        IF onuerrorcode = 0 THEN

          ldc_boasigauto.prregsitroasigautolog(to_number(sbpackage_id),
                                               to_number(sborder_id),
                                               'LA ORDEN FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                               nuoperating_unit_id || ']');


          UPDATE ldc_order
             SET asignado = 'S'
           WHERE nvl(package_id, 0) = nvl(to_number(sbpackage_id), 0)
             AND order_id = to_number(sborder_id);
        ELSE
          osberrormessage := 'LA ORDEN DE TRABAJO NO FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                             nuoperating_unit_id ||
                             '] - MENSAJE DE ERROR PROVENIENTE DE API_ASSIGN_ORDER --> ' ||
                             osberrormessage;
          ldc_boasigauto.prregsitroasigautolog(to_number(sbpackage_id),
                                               to_number(sborder_id),
                                               osberrormessage);

          /*CA516 JJJM*/
          LDC_PKGREPEGELERECOYSUSP.proRegistraLogLegOrdRecoSusp('PROASIORDENVSISERNUE',
                                                                SYSDATE,
                                                                sborder_id,
                                                                NULL,
                                                                osberrormessage,
                                                                USER);

        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          sbdatain := 'INCONSISTENCIA EN SERVICIO PRASIGORDENSERNUE [' ||
                      dbms_utility.format_error_stack || '] - [' ||
                      dbms_utility.format_error_backtrace || ']';
          ldc_boasigauto.prregsitroasigautolog(null,
                                               to_number(sborder_id),
                                               'EL SERVICIO API_ASSIGN_ORDER NO PUDO ASIGNAR LA UNIDAD OPERATIVA A LA ORDEN [' ||
                                               sbdatain || ']');
      END;
      -- Fin Asignar orden
    ELSE
      -- sino obtuvo la UT
      nuoperating_unit_id := null;
    END IF;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN(to_char(nuoperating_unit_id));
  END PRASIGORDENVSISERNUE;

  PROCEDURE PRPROCGENVSI IS
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
       17/10/2021   dsaltarin   Se modifica para que contemple generarse x dias despues
       07/03/2022   JorVal      CAMBIO 944: Se agrega llamado del nuevo parametro PARAM_TITRACT_ERROR para realizar llamado del 
                                API GE_BOERRORS.SETERRORCODEARGUMENT
       24/05/2023   jcatuchemvm OSF-1340: Se cambia el llamado a OS_RegisterRequestWithXML por api_registerRequestByXml, el cual encapsula el
                                procedimiento de open y añade logia para restablecer nivel y salida de traza despues del llamado, se detectó
                                que después del llamado, el nivel se asigna a cero impidiendo que se registre la traza correctamente.
       10/05/2024   fvalencia   Se modifca para agregar la orden en la tabla
                                temporal tmp_generica
    ***************************************************************************/
    nuorden       NUMBER; --se almacena numero de orden
    sbmensa       VARCHAR2(4000);
    nuPersonIdsol NUMBER := ge_bopersonal.fnugetpersonid;
    ONUCHANNEL    CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE;
    sbObserva     VARCHAR2(4000);
    sbRequestXML  VARCHAR2(4000);
    nuPackageId   NUMBER;
    nuMotiveId    NUMBER;
    onuErrorCode  NUMBER;
    
    dtFechaPro    DATE;
    sbGenera      VARCHAR2(1);
    dtFechaCrea   DATE;
    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || '.PRPROCGENVSI';

    --se consultan datos de la orden
    CURSOR cuGetdatOrden IS
      SELECT O.TASK_TYPE_ID,
             O.OPERATING_UNIT_ID,
             O.CAUSAL_ID,
             OA.ACTIVITY_ID,
             s.package_id,
             P.CATEGORY_ID,
             P.SUBCATEGORY_ID,
             nvl(S.PACKAGE_TYPE_ID,-1) PACKAGE_TYPE_ID,
             OA.PRODUCT_ID,
			 oa.SUBSCRIPTION_ID,
             OA.SUBSCRIBER_ID,
             NVL(OA.ADDRESS_ID,O.EXTERNAL_ADDRESS_ID) ADDRESS_ID,
             (select c.order_comment from or_ordeR_comment c where c.order_id= o.order_id and c.legalize_comment='Y' and rownum=1) comentario
        From or_order o, 
             or_order_activity oa 
             left join mo_packages s on s.package_id=oa.package_id
             left join pr_product p on p.product_id=oa.product_id
       WHERE o.order_id = oa.order_id
         AND o.order_id = nuorden;



    regDatOrden cuGetdatOrden%ROWTYPE;

    CURSOR cuConfVSI IS
      SELECT C.COCLACTI, C.COCLMERE, c.COCLASAU, c.COCLDIAS, c.COCLCAME
        FROM LDC_COTTCLAC c
       WHERE (c.COCLTISO = regDatOrden.PACKAGE_TYPE_ID or c.COCLTISO = -1)
         AND c.COCLTITR = regDatOrden.TASK_TYPE_ID
         AND (c.COCLACPA = regDatOrden.ACTIVITY_ID or c.COCLACPA is null)
         AND (c.COCLCAUS = regDatOrden.CAUSAL_ID or c.COCLCAUS = -1)
         AND (c.COCLCATE = regDatOrden.CATEGORY_ID or c.COCLCATE = -1)
         AND (c.COCLSUCA = regDatOrden.SUBCATEGORY_ID or c.COCLSUCA is null);


    --CAMBIO 944
    CURSOR CUEXISTE(NUVALOR NUMBER, IsbPARAM_TITRACT_ERROR VARCHAR2) IS 
      SELECT count(1) cantidad 
        FROM DUAL 
       WHERE NUVALOR IN 
             (select to_number(column_value) 
                from table(ldc_boutilities.splitstrings(pkg_bcld_parameter.fsbobtienevalorcadena(IsbPARAM_TITRACT_ERROR), 
                                                        ',')));     
    nuExiste number := 0;
	
	CURSOR cuGetCliente(inucontrato NUMBER) IS
	SELECT suscclie
	FROM suscripc
	WHERE susccodi = inucontrato;
	
	nucliente NUMBER;
    --------------------- 
  nuLevel     NUMBER(2);
  nuTraceOut  NUMBER(1);    

    rcTmpGenerica       pkg_tmp_generica.rcTmpGenerica%TYPE;

  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    nuorden := pkg_bcordenes.fnuobtenerotinstancialegal; --se obtiene orden que se esta legalizando

    pkg_traza.trace('INICIO PRPROCGENVSI ORDEN ' || nuorden, pkg_traza.cnuNivelTrzDef);

    rcTmpGenerica := null;
    rcTmpGenerica.nuDato_01 := nuorden; -- Orden legalizada
    rcTmpGenerica.FechaSys  := sysdate;
    -- Inserta en la tabla tmp_generica
    pkg_Tmp_Generica.prInsertar
    (
        rcTmpGenerica
    );
    
    dtFechaCrea := pkg_bcordenes.fdtobtienefechacreacion(nuorden);

      IF cuGetdatOrden%isopen THEN
        CLOSE cuGetdatOrden;
      END IF;
    --se carga informacion de la orden
    OPEN cuGetdatOrden;
    FETCH cuGetdatOrden
      INTO regDatOrden;
    IF cuGetdatOrden%NOTFOUND THEN
      sbmensa := 'No existe informacion de la orden ' || to_char(nuorden);
      pkg_Error.setErrorMessage(isbMsgErrr => sbmensa);
    END IF;
    CLOSE cuGetdatOrden;
    --se obtiene punto de atencion
    gE_BOPERSONAL.GETCURRENTCHANNEL(nuPersonIdsol, ONUCHANNEL);
    sbObserva := substr('Solicitud Generada por legalizacion de la orden #' || nuorden ||': '||regDatOrden.comentario,1,2000);

    FOR reg IN cuConfVSI LOOP
      if regDatOrden.PRODUCT_ID is not null and reg.COCLCAME='S' then
         if LDC_BoProcesaOrdVMP.fsbValidaCambMed(regDatOrden.PRODUCT_ID, dtFechaCrea)='S' then
           sbGenera :='N';
         else
           sbGenera :='S';
         end if;
      else
         sbGenera :='S';
      end if;
      --cambio 263
      if ((reg.cocldias=0) and sbGenera='S')then
          
          IF CUEXISTE%isopen THEN
            CLOSE CUEXISTE;
          END IF;
        --CAMBIO 944
          open CUEXISTE(pkg_bcordenes.fnuobtienetipotrabajo(nuorden),'PARAM_TITRACT_ERROR');
          fetch CUEXISTE into nuExiste;
          close CUEXISTE;
          
		    -----------------------------
          
        IF regDatOrden.SUBSCRIBER_ID IS NULL THEN
          IF regDatOrden.SUBSCRIPTION_ID IS NOT NULL THEN

            IF cuGetCliente%isopen THEN
              CLOSE cuGetCliente;
            END IF;
            OPEN cuGetCliente(regDatOrden.SUBSCRIPTION_ID );
            FETCH cuGetCliente INTO nuCliente;
            CLOSE cuGetCliente;
          ELSE

            IF cuGetCliente%isopen THEN
              CLOSE cuGetCliente;
            END IF;
            OPEN cuGetCliente(pkg_bcproducto.fnucontrato(regDatOrden.PRODUCT_ID ));
            FETCH cuGetCliente INTO nuCliente;
            CLOSE cuGetCliente;
          END IF;
        ELSE 
          nuCliente := regDatOrden.SUBSCRIBER_ID;
        END IF;
		  
		  
		  
        nuPackageId  := null;
        nuMotiveId   := null;
        onuErrorCode := null;
        sbmensa      := null;

        sbRequestXML :=  pkg_xml_soli_vsi.getSolicitudVSI
                        (
                            regDatOrden.SUBSCRIPTION_ID,
                            reg.COCLMERE,
                            sbObserva,
                            regDatOrden.PRODUCT_ID,
                            nuCliente,	
                            nuPersonIdsol,
                            ONUCHANNEL,
                            SYSDATE,
                            regDatOrden.ADDRESS_ID,
                            regDatOrden.ADDRESS_ID,
                            reg.COCLACTI
												);

        /*Ejecuta el XML creado*/
        api_registerRequestByXml(sbRequestXML,
                                  nuPackageId,
                                  nuMotiveId,
                                  onuErrorCode,
                                  sbmensa);

        
        pkg_traza.trace('onuErrorCode['|| onuErrorCode ||']', pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('onuErrorCode['|| sbmensa ||']', pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('nuPackageId['|| nuPackageId ||']', pkg_traza.cnuNivelTrzDef);
                  
        IF nupackageid IS NULL THEN
           RAISE pkg_Error.controlled_error;
        ELSE

          IF reg.COCLASAU = 'S' THEN
            insert into LDC_BLOQ_LEGA_SOLICITUD
              (PACKAGE_ID_ORIG, PACKAGE_ID_GENE)
            values
              (regDatOrden.package_id, nuPackageId);

            INSERT INTO LDC_ORDEASIGPROC
              (ORAPORPA,
               ORAPSOGE,
               ORAOPELE,
               ORAOUNID,
               ORAOCALE,
               ORAOITEM,
               ORAOPROC)
            VALUES
              (nuorden,
               nuPackageId,
               pkg_bcordenes.fnuobtenerpersona(nuorden),
               regDatOrden.OPERATING_UNIT_ID,
               regDatOrden.causal_id,
               null,
               'SEVAASAU');
          ELSE
            INSERT INTO LDC_ORDEASIGPROC
              (ORAPORPA,
               ORAPSOGE,
               ORAOPELE,
               ORAOUNID,
               ORAOCALE,
               ORAOITEM,
               ORAOPROC)
            VALUES
              (nuorden,
               nuPackageId,
               pkg_bcordenes.fnuobtenerpersona(nuorden),
               NULL,
               regDatOrden.causal_id,
               null,
               'SEVAASAU');

          END IF;
        END IF;
      Else
        if sbGenera='S' then
          dtFechaPro := trunc(sysdate) + reg.cocldias;
          IF reg.COCLASAU = 'S' THEN
            INSERT INTO LDC_GEN_VSIXJOB(COCLORDE, COCLACTI, COCLUNID, COCLMERE, COCLPROD,	COCLCOME, COCLDIRE, COCLFEPR, COCLPERS, COCLCAME)
            VALUES(nuorden, reg.COCLACTI, regDatOrden.OPERATING_UNIT_ID, reg.COCLMERE, regDatOrden.PRODUCT_ID, sbObserva,regDatOrden.ADDRESS_ID, dtFechaPro , nuPersonIdsol, reg.COCLCAME);
          ELSE
            INSERT INTO LDC_GEN_VSIXJOB(COCLORDE, COCLACTI, COCLUNID, COCLMERE, COCLPROD,	COCLCOME, COCLDIRE, COCLFEPR, COCLPERS, COCLCAME)
            VALUES(nuorden, reg.COCLACTI, null, reg.COCLMERE, regDatOrden.PRODUCT_ID, sbObserva,regDatOrden.ADDRESS_ID, dtFechaPro, nuPersonIdsol, reg.COCLCAME );
        End if;
        end if;
      End if;
    END LOOP;

    pkg_traza.trace('FIN PRPROCGENVSI ' || sbmensa, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_Error.controlled_error THEN
      --CAMBIO 944
      IF nuExiste = 1 THEN
        raise;
      ELSE              
        pkg_Error.getError(onuErrorCode, sbmensa);
      END IF;
      ----------------------------------      
    WHEN OTHERS THEN
      pkg_Error.setError;
      RAISE pkg_Error.controlled_error;

  END PRPROCGENVSI;

  PROCEDURE PRPROCVALIDAITEM IS
    /**************************************************************************
       Autor       : Horbath
       Fecha       : 2019-08-01
       Ticket      : 200-2630
       Descripcion : plugin para validar que items del parametro LDC_CODITEMVA se legalicen

       Parametros Entrada

       Valor de salida

       HISTORIA DE MODIFICACIONES
       FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    nuorden NUMBER; --se almacena numero de orden
    nuItems NUMBER; --se almacena codigo de items
    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || '.PRPROCVALIDAITEM';

    sbitems    VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_CODITEMVA'); -- se almacenan items a validar
    nuCantLega NUMBER;
    sbmensaje  VARCHAR2(4000); -- se almacena mensaje de error

    sbMensItem VARCHAR2(4000);

    --Se valida items legalizado
    CURSOR cuValiItem(nuItems NUMBER) IS
      SELECT count(1)
        FROM or_order_items
       WHERE ORDER_ID = nuorden
         AND LEGAL_ITEM_AMOUNT > 0
         AND ITEMS_ID = nuItems;

    --se consultan items a validar
    CURSOR cuItemaValidar IS
      SELECT I.ITEMS_ID, I.DESCRIPTION
        FROM ge_items i
       WHERE I.ITEMS_ID in
             (select distinct REGEXP_SUBSTR(sbitems, '[^,]+', 1, level) items
                from dual
              connect by regexp_substr(sbitems, '[^,]+', 1, level) is not null);

  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    nuorden := pkg_bcordenes.fnuobtenerotinstancialegal; --se obtiene orden que se esta legalizando
    pkg_traza.trace('INICIO PRPROCVALIDAITEM ORDEN ' || nuorden, pkg_traza.cnuNivelTrzDef);

    FOR reg IN cuItemaValidar LOOP

      IF cuValiItem%ISOPEN THEN
        CLOSE cuValiItem;
      END IF;

      --se valida items
      OPEN cuValiItem(reg.ITEMS_ID);
      FETCH cuValiItem
        INTO nuCantLega;
      CLOSE cuValiItem;

      IF nuCantLega = 0 THEN
        IF sbmensaje IS NULL THEN
          sbmensaje := reg.ITEMS_ID || '-' || reg.DESCRIPTION;
        ELSE
          sbmensaje := nvl(sbmensaje, ' ') || ', ' || reg.ITEMS_ID || '-' ||
                       reg.DESCRIPTION;
        END IF;

      END IF;

    END LOOP;

    --Se valdia si hubo error
    IF sbmensaje IS NOT NULL THEN
      sbmensaje := Initcap('Los Items ' || sbmensaje ||
                           ', son obligatorio legalizar para este tipo de trabajo.');
      pkg_Error.setErrorMessage(isbMsgErrr => sbmensaje);
    END IF;

    pkg_traza.trace('FIN PRPROCVALIDAITEM ' || sbmensaje, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_Error.controlled_error THEN
      RAISE pkg_Error.controlled_error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      RAISE pkg_Error.controlled_error;

  END PRPROCVALIDAITEM;

  PROCEDURE PRVALMARPRODXCAU IS
    /**************************************************************************
       Autor       : Horbath
       Fecha       : 2019-11-27
       Ticket      : 200-2630
       Descripcion : plugin para validar la marca

       Parametros Entrada

       Valor de salida

       HISTORIA DE MODIFICACIONES
       FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    error          NUMBER; --codigo de error
    sbmensa        VARCHAR2(4000); --mensaje de error
    nuOrden        NUMBER; --codigo de orden
    sbmarcas       VARCHAR2(4000); --se alamcena marcan a validar
    sbcausales     VARCHAR2(4000); --se almacena causales
    nuIndex        NUMBER;
    nucausal       NUMBER; --se almacena causal de legalizacion
    sBdatosPara    VARCHAR2(4000) := pkg_bcld_parameter.fsbobtienevalorcadena('CAUSAL_VALIDA_X_MARCA'); --se obtiene parametros
    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || '.PRVALMARPRODXCAU';                                                                    
    nuExistemarca  NUMBER := 0;
    nuExisteCausal NUMBER := 0;
    blValido       BOOLEAN := TRUE;

    --se crea tipo
    TYPE tptMarcaCausal IS RECORD(
      sbmarcas   VARCHAR2(4000),
      sbCausales VARCHAR2(4000));

    TYPE tblMarcaCausal IS TABLE OF tptMarcaCausal INDEX BY BINARY_INTEGER; --Se crea tabla de marca y causal

    vTblMarcaCausal tblMarcaCausal; --se crea variable de tabla

    --se obtiene datos configurados
    CURSOR cuGetParametros IS
      select distinct REGEXP_SUBSTR(sBdatosPara, '[^|]+', 1, level) DATOS
        from dual
      connect by regexp_substr(sBdatosPara, '[^|]+', 1, level) is not null;

    --se obtiene datos configurados
    CURSOR cuGetMarcaCausal(sbMarcaCausal VARCHAR2) IS
      select ROWNUM nume,
             REGEXP_SUBSTR(sbMarcaCausal, '[^;]+', 1, level) marcas
        from dual
      connect by regexp_substr(sbMarcaCausal, '[^;]+', 1, level) is not null;

    --se obtiene datos configurados
    CURSOR cuGetValidarMarcaCausal(sbValor VARCHAR2, nudato NUMBER) IS
      SELECT COUNT(1)
        FROM (select TO_NUMBER(REGEXP_SUBSTR(sbValor, '[^,]+', 1, level)) valor
                from dual
              connect by regexp_substr(sbValor, '[^,]+', 1, level) is not null)
       WHERE nudato = valor;

    numarca NUMBER; --se almacena marca del producto
    --se obtiene marca del producto
    CURSOR cugetMarcaprod IS
      SELECT NVL(SUSPENSION_TYPE_ID, 101)
        FROM or_order_activity oa, LDC_MARCA_PRODUCTO
       WHERE oa.order_id = nuOrden
         and ID_PRODUCTO = oa.product_id;

  bEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    --se valida si aplica la entrega 200-2630
    
    nuOrden  := pkg_bcordenes.fnuobtenerotinstancialegal; -- Obtenemos la orden que se esta legalizando
    nucausal := pkg_bcordenes.fnuobtienecausal(nuOrden); --se obtiene causal de la orden
    nuIndex  := 1;

    IF cugetMarcaprod%isopen THEN
      CLOSE cugetMarcaprod;
    END IF;
    --se obtiene marca del producto
    OPEN cugetMarcaprod;
    FETCH cugetMarcaprod
      INTO numarca;
    CLOSE cugetMarcaprod;

    pkg_traza.trace('marca del producto [' || numarca || ']', pkg_traza.cnuNivelTrzDef);
    --se valida que la marca no este vacia y el parametro tenga valor
    IF numarca IS NOT NULL AND sBdatosPara IS NOT NULL THEN
      pkg_traza.trace('parametro [' || sBdatosPara || ']', pkg_traza.cnuNivelTrzDef);
      --se obtiene parametros
      FOR reg IN cuGetParametros LOOP
        pkg_traza.trace('separar marcas [' || REG.DATOS || ']', pkg_traza.cnuNivelTrzDef);
        --se obtiene marca y causal
        FOR regca IN cuGetMarcaCausal(REG.DATOS) LOOP
          pkg_traza.trace('separar causales y marcas [' || regca.marcas || ']', pkg_traza.cnuNivelTrzDef);
          IF regca.nume = 1 THEN
            vTblMarcaCausal(nuIndex).sbmarcas := regca.marcas;
          ELSE
            vTblMarcaCausal(nuIndex).sbCausales := regca.marcas;
            nuIndex := nuIndex + 1;
          END IF;
        END LOOP;
      END LOOP;
      --se recorre tabla de marcas y causal
      FOR regp IN 1 .. vTblMarcaCausal.COUNT LOOP
        nuExistemarca  := 0;
        nuExisteCausal := 0;
        pkg_traza.trace('validar configuracion marca [' || vTblMarcaCausal(regp).sbmarcas || ']', pkg_traza.cnuNivelTrzDef);

        IF cuGetValidarMarcaCausal%isopen THEN
          CLOSE cuGetValidarMarcaCausal;
        END IF;

        OPEN cuGetValidarMarcaCausal(vTblMarcaCausal(regp).sbmarcas,
                                     numarca);
        FETCH cuGetValidarMarcaCausal
          INTO nuExistemarca;
        CLOSE cuGetValidarMarcaCausal;
        pkg_traza.trace('validar configuracion causal [' || vTblMarcaCausal(regp).sbCausales || ']', pkg_traza.cnuNivelTrzDef);
        OPEN cuGetValidarMarcaCausal(vTblMarcaCausal(regp).sbCausales,
                                     nucausal);
        FETCH cuGetValidarMarcaCausal
          INTO nuExisteCausal;
        CLOSE cuGetValidarMarcaCausal;
        pkg_traza.trace('resultado marca [' || nuExistemarca ||
                       '], resultado causal [' || nuExisteCausal || ']', pkg_traza.cnuNivelTrzDef);
        --se valida la configuracion
        IF nuExistemarca > 0 AND nuExisteCausal > 0 THEN
          blValido := TRUE;
          EXIT;
        ELSE
          IF nuExistemarca > 0 OR nuExisteCausal > 0 THEN
            blValido := FALSE;
          END IF;

        END IF;

      END LOOP;

      IF NOT blValido THEN
        sbmensa := 'La marca del producto [' || numarca ||
                   '] no esta permitido legalizar con la causal [' ||
                   nucausal || '-' ||
                   dage_causal.fsbgetdescription(nucausal, null) || ']';
        pkg_Error.setErrorMessage( isbMsgErrr => sbmensa);
        raise pkg_Error.controlled_error;
      END IF;

    END IF;
    

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
    when pkg_Error.controlled_error then
      pkg_Error.getError(error, sbmensa);
      raise pkg_Error.controlled_error;
    when OTHERS then
      pkg_Error.getError(error, sbmensa);
      raise pkg_Error.controlled_error;
  END PRVALMARPRODXCAU;


  PROCEDURE PRPROCGENOT_AUTONOMA IS
    /**************************************************************************
       Autor       : DSALTARIN
       Fecha       : 2019-08-01
       Ticket      : 263
       Descripcion : plugin para generar OT AUTONOMA.

       Parametros Entrada

       Valor de salida

       HISTORIA DE MODIFICACIONES
       FECHA        AUTOR         DESCRIPCION
      14/07/2023    jcatuchemvm   OSF-1340: Se actualiza el llamado a or_boorderactivities.createactivity
                                  por api_createorder y os_related_order por api_related_order
    ***************************************************************************/
    nuorden       NUMBER; --se almacena numero de orden
    sbmensa       VARCHAR2(4000);
    sbObserva     VARCHAR2(4000);
    onuErrorCode  NUMBER;
    osbError      VARCHAR2(4000);
    nuOtGenerar   OR_ORDER.ORDER_ID%TYPE;
    nuProducto    pr_product.product_id%type;
    nuContrato    suscripc.susccodi%type;
    nuCliente     ge_subscriber.subscriber_id%type;
    nuOrdenAct    ge_items.items_id%type;

    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || '.PRPROCGENOT_AUTONOMA';

    --se consultan datos de la orden
    CURSOR cuGetdatOrden IS
      SELECT O.TASK_TYPE_ID,
             O.OPERATING_UNIT_ID,
             O.CAUSAL_ID,
             OA.ACTIVITY_ID,
             s.package_id,
             P.CATEGORY_ID,
             P.SUBCATEGORY_ID,
             nvl(S.PACKAGE_TYPE_ID,-1) PACKAGE_TYPE_ID,
             OA.PRODUCT_ID,
             OA.SUBSCRIBER_ID,
             OA.SUBSCRIPTION_ID,
             P.ADDRESS_ID,
             nvl(oa.operating_sector_id,o.operating_sector_id) sector_oper,
             (select c.order_comment from or_ordeR_comment c where c.order_id= o.order_id and c.legalize_comment='Y' and rownum=1) comentario
        From or_order o, 
             or_order_activity oa 
             left join mo_packages s on s.package_id = oa.package_id
             Left join pr_product p on p.product_id = oa.product_id
       WHERE o.order_id = oa.order_id
         AND o.order_id = nuorden;



    regDatOrden cuGetdatOrden%ROWTYPE;

    CURSOR cuConfVSI IS
      SELECT c.actividad_generar, c.hereda_producto, c.hereda_observacion
        FROM OR_GENERA_OT_AUTON c
       WHERE c.task_type_id = regDatOrden.TASK_TYPE_ID
         AND (c.activity_id = regDatOrden.ACTIVITY_ID or c.activity_id is null)
         AND (c.causal_id = regDatOrden.CAUSAL_ID or c.causal_id = -1);



  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    nuorden := pkg_bcordenes.fnuobtenerotinstancialegal; --se obtiene orden que se esta legalizando

    pkg_traza.trace('INICIO PRPROCGENOT_AUTONOMA ORDEN ' || nuorden, pkg_traza.cnuNivelTrzDef);

      IF cuGetdatOrden%isopen THEN
        CLOSE cuGetdatOrden;
      END IF;
    --se carga informacion de la orden
    OPEN cuGetdatOrden;
    FETCH cuGetdatOrden
      INTO regDatOrden;
    IF cuGetdatOrden%NOTFOUND THEN
      sbmensa := 'No existe informacion de la orden ' || to_char(nuorden);
      pkg_Error.setErrorMessage(isbMsgErrr => sbmensa);
    END IF;
    CLOSE cuGetdatOrden;
    --se obtiene punto de atencion
    

    FOR reg IN cuConfVSI LOOP
      nuOtGenerar  := null;
      nuOrdenAct   := null;
      onuErrorCode := null;
      sbmensa      := null;
      nuProducto   := null;
      nuContrato   := null;
      nuCliente    := null;
      sbObserva    := null;
      osbError     := null;
      
      if reg.hereda_producto = 'S' then
        nuProducto    := regDatOrden.product_id;
        nuContrato    := regDatOrden.subscription_id;
        nuCliente     := regDatOrden.subscriber_id;
      end if;
      if reg.hereda_observacion = 'S' then
        sbObserva := regDatOrden.comentario;
      end if;
      
      Begin
       api_createorder
       (
        inuitemsid         => reg.actividad_generar,
        inupackageid        => null,
        inumotiveid         => null,
        inucomponentid      => NULL,
        inuinstanceid       => NULL,
        inuaddressid        => regDatOrden.address_id,
        inuelementid        => NULL,
        inusubscriberid     => nuCliente,
        inusubscriptionid   => nuContrato,
        inuproductid        => nuProducto,
        inuoperunitid       => NULL,
        idtexecestimdate    => NULL,
        inuprocessid        => NULL,
        isbcomment          => sbObserva,
        iblprocessorder     => FALSE,
        inupriorityid       => NULL,
        inuordertemplateid  => NULL,
        isbcompensate       => NULL,
        inuconsecutive      => NULL,
        inurouteid          => NULL,
        inurouteconsecutive => NULL,
        inulegalizetrytimes => 0,
        isbtagname          => NULL,
        iblisacttogroup     => FALSE,
        inurefvalue         => NULL,
        ionuorderid         => nuOtGenerar,
        ionuorderactivityid => nuOrdenAct,
        onuErrorCode        => onuErrorCode,
        osbErrorMessage     => osbError
      );
      if nuOtGenerar is not null then
        api_related_order(nuorden, nuOtGenerar, onuErrorCode, osbError);
      end if;
    Exception
      when pkg_Error.controlled_error then
           pkg_Error.getError(onuErrorCode, osbError);     
      when others then
          pkg_Error.setError;
          pkg_Error.getError(onuErrorCode, osbError);
    End;
    if onuErrorCode != 0 then 
      pkg_Error.setErrorMessage(isbMsgErrr => osbError);
      RAISE pkg_Error.controlled_error;                                                 
    end if;
    END LOOP;

    pkg_traza.trace('FIN PRPROCGENOT_AUTONOMA ' || sbmensa, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_Error.controlled_error THEN
      pkg_Error.getError(onuErrorCode, sbmensa);
    WHEN OTHERS THEN
      pkg_Error.setError;
      RAISE pkg_Error.controlled_error;

  END PRPROCGENOT_AUTONOMA;
  
  PROCEDURE PRJOB_GENEVSIDIASDESPUES IS
    /**************************************************************************
       Autor       : DSALTARIN
       Fecha       : 2019-08-01
       Ticket      : 263
       Descripcion : JOB PARA GENERAR VSI DE ACUERDO A DIAS CONFIGURADOS EN
                     LDC_COTTCLAC

       Parametros Entrada

       Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA         AUTOR         DESCRIPCION
      24/05/2023    jcatuchemvm   OSF-1340: Se cambia el llamado a OS_RegisterRequestWithXML por api_registerRequestByXml, el cual encapsula el
                                  procedimiento de open y añade logia para restablecer nivel y salida de traza despues del llamado, se detectó
                                  que después del llamado, el nivel se asigna a cero impidiendo que se registre la traza correctamente.
                                  Se actualiza el llamado OS_ASSIGN_ORDER por API_ASSIGN_ORDER
      01/08/2019    DSALTARIN     OSF-263: Creación
    ***************************************************************************/      
    ONUCHANNEL    CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE; 
    sbRequestXML  VARCHAR2(4000);
    nuPackageId   NUMBER;
    nuMotiveId    NUMBER;
    onuErrorCode  NUMBER; 
    sbmensa       VARCHAR2(4000);
    nuOtGen       or_order.order_id%type;
    sbGenera      VARCHAR2(1);
    dtFechaCrea   DATE;

    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || '.PRJOB_GENEVSIDIASDESPUES';
    
    --variabe para estaproc
    nuparano  NUMBER;
    nuparmes  NUMBER;
    nutsess   NUMBER;
    sbparuser VARCHAR2(400);
 
 cursor cuDatos IS
    SELECT J.*,
           S.SUSCCLIE,
           (select package_id from or_order_activity a where a.order_id=j.COCLORDE and rownum=1) package_id,
           J.ROWID
    FROM LDC_GEN_VSIXJOB J
    LEFT JOIN PR_PRODUCT P ON P.PRODUCT_ID=J.COCLPROD
    LEFT JOIN SUSCRIPC S ON S.SUSCCODI=P.SUBSCRIPTION_ID
    WHERE J.COCLFEPR<=TRUNC(SYSDATE);
    
  cursor cuOrden(nuSoli mo_packages.package_id%type) is
  select a.order_id
  from or_order_activity a
  where a.package_id = nuSoli
  and   status='R';
  
      CURSOR cuDatosGenerales
      IS
      SELECT to_number(to_char(SYSDATE, 'YYYY')),
           to_number(to_char(SYSDATE, 'MM')),
           userenv('SESSIONID'),
           USER
      INTO nuparano, nuparmes, nutsess, sbparuser
      FROM dual;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

    IF cuDatosGenerales%isopen THEN
      CLOSE cuDatosGenerales;
    END IF;

    OPEN cuDatosGenerales;
    FETCH cuDatosGenerales INTO nuparano, nuparmes, nutsess, sbparuser;
    CLOSE cuDatosGenerales;

    -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,
                           nuparmes,
                           'PRJOB_GENEVSIDIASDESPUES',
                           'En ejecucion',
                           nutsess,
                           sbparuser);  
    ---aplica entrega 263
    FOR REG IN CUDATOS LOOP
      BEGIN    
        nuPackageId  := null;
        nuMotiveId   := null;
        onuErrorCode := null;
        sbmensa      := null;
        ONUCHANNEL   := null;
        dtFechaCrea  := pkg_bcordenes.fdtobtienefechacreacion(reg.COCLORDE);
        if REG.COCLCAME ='S' AND reg.COCLPROD is not null then
          if LDC_BoProcesaOrdVMP.fsbValidaCambMed(reg.COCLPROD, dtFechaCrea)='S' then
             sbGenera :='N';
          else
             sbGenera :='S';
          end if;
        else
          sbGenera:='S';
        end if;
        if sbGenera='S' then
                
          gE_BOPERSONAL.GETCURRENTCHANNEL(reg.COCLPERS, ONUCHANNEL);

          sbRequestXML :=  pkg_xml_soli_vsi.getSolicitudVSI
                        (
                          pkg_bcproducto.fnucontrato(reg.COCLPROD),
                          reg.COCLMERE,
                          reg.COCLCOME,
                          reg.COCLPROD,
                          reg.SUSCCLIE,	
                          reg.COCLPERS,
                          ONUCHANNEL,
                          SYSDATE,
                          reg.COCLDIRE,
                          reg.COCLDIRE,
                          reg.COCLACTI
                      );

          /*Ejecuta el XML creado*/
          api_registerRequestByXml(sbRequestXML,
                                    nuPackageId,
                                    nuMotiveId,
                                    onuErrorCode,
                                    sbmensa);
          
          IF nupackageid IS NULL THEN
            ROLLBACK;
            UPDATE LDC_GEN_VSIXJOB 
               SET COCLERRO=sbmensa,
                   COCLFECH=SYSDATE
             WHERE ROWID=REG.ROWID;
             COMMIT;
          ELSE
            COMMIT;
            
            IF reg.COCLUNID is not null THEN
              dbms_lock.sleep(5);
              if cuOrden%isopen then
                close cuOrden;
              end if;
              open cuOrden(nuPackageId);
              fetch cuOrden into nuOtGen;
              close cuOrden;
              onuErrorCode := 0;
              if nuOtGen is not null then
                API_ASSIGN_ORDER(nuOtGen,
                                reg.COCLUNID,
                                onuErrorCode,
                                sbmensa);
               if onuErrorCode = 0 then
                  commit;
               else 
                 rollback;
              end if;
              if nuOtGen is null or onuErrorCode!=0 then
                insert into LDC_BLOQ_LEGA_SOLICITUD
                    (PACKAGE_ID_ORIG, PACKAGE_ID_GENE)
                    values
                      (reg.package_id, nuPackageId);
                     end if;
              End if;

              INSERT INTO LDC_ORDEASIGPROC
                (ORAPORPA,
                 ORAPSOGE,
                 ORAOPELE,
                 ORAOUNID,
                 ORAOCALE,
                 ORAOITEM,
                 ORAOPROC)
              VALUES
                (reg.COCLORDE,
                 nuPackageId,
                 NULL,
                 reg.COCLUNID,
                 null,
                 null,
                 'SEVAASAU');
            ELSE
              INSERT INTO LDC_ORDEASIGPROC
                (ORAPORPA,
                 ORAPSOGE,
                 ORAOPELE,
                 ORAOUNID,
                 ORAOCALE,
                 ORAOITEM,
                 ORAOPROC)
              VALUES
                (reg.COCLORDE,
                 nuPackageId,
                 null,
                 NULL,
                 null,
                 null,
                 'SEVAASAU');

            END IF;
                      
            DELETE LDC_GEN_VSIXJOB 
             WHERE ROWID=REG.ROWID;
             COMMIT;
          END IF;
        Else
          DELETE LDC_GEN_VSIXJOB 
          WHERE ROWID=REG.ROWID;
          COMMIT;
        End if;
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          pkg_Error.setError;
          pkg_Error.getError(onuErrorCode, sbmensa);
           
          UPDATE LDC_GEN_VSIXJOB 
             SET COCLERRO=sbmensa,
                 COCLFECH=SYSDATE
          WHERE ROWID=REG.ROWID;
          COMMIT;
            
      END;
    END LOOP;
 
    ldc_proactualizaestaprog(nutsess, 'Termino Ok', 'PRJOB_GENEVSIDIASDESPUES', 'Ok');
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  Exception
    when others then
      pkg_Error.setError;
      pkg_Error.getError(onuErrorCode, sbmensa);
      ldc_proactualizaestaprog(nutsess, sbmensa, 'PRJOB_GENEVSIDIASDESPUES', 'Error');
  END PRJOB_GENEVSIDIASDESPUES;
  
END LDC_PKPROCSERVVARIOS;
/
