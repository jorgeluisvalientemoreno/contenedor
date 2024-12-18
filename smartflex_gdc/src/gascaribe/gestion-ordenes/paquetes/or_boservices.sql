create or replace PACKAGE "OR_BOSERVICES" IS

  csbVersion CONSTANT VARCHAR2(20) := 'OSF-2678';

  --- Variables globales para los procedimientos Josecf 09-05-2013
  NOrder_id     or_order.ORDER_ID%TYPE;
  NTASK_TYPE_ID or_order.TASK_TYPE_ID%TYPE;
  NCAUSAL_ID    ldc_procedimiento_obj.CAUSAL_ID%TYPE;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : OR_BOServices
  Descripcion    : Paquete para el manejo de servicios en el modulo
                   de ordenes.
  Autor          : DaviNOrder_idd Arias Villalobos
  Fecha          : 30-Nov-2005

  Nombre         :
  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha       Autor         Modificacion
  =========   =========     ====================
  15-05-2024  PAcosta       OSF-2678: Modificación procedimientos: CLIENTPROCESSPOSTLEGALIZE
                                                                   LDC_VALIDATECICOLEGCERT
                                                                   PROCCESSLEGORPLO
                                                                   FRCGETUNIDOPERTECCERTRE
                                                                   PROCVALIDCAUSALNOLEGAL
                                                                   BLOQUEOLEGALIZACIONRP
  21-02-2108  KBaquero      CA 200-1458  se modifica el servicio <<ClientProcessPostLegalize>>
  26-Dic-2017 Stapias       Ca200-1261 se modifica el servicio <<ClientProcessPostLegalize>>
  10-Ago-2017 STapias       CA2001299 Se modidica el servicio <<ProccessLegORPLO>>
  17-04-2017  KCienfuegos   CA200533: Se modifica el metodo <<ProccessLegORPLO>>
  30-Nov-2005 Darias        SAO42621. Creacion
  02-Dic-2005 Darias        SAO42993. Eliminar implementacion de codigo
                            en el metodo ClientProcessPostLegalize
  30-Mar-2015 Agordillo     REQ.239 Modificacion
                            Se modifica el Procedimiento ClientProcessPostLegalize
                            Se crea la funcion ProccessLegORPLO
  13-Nov-2015 Mmejia        ARA.8602 , SAO.358079 Modificacion <<ldc_validatecicolegcert>> para
                            que valide la vigencia del tecnico con la fecha fin de
                            ejecucion de la orden.
  14-Nov-2015 Mmejia        SAO.358079 <<FRCGETUNIDOPERTECCERTRE>> creacion
  ******************************************************************/

  -- Declaracion de Tipos de datos publicos

  -- Declaracion de variables publicas

  -- Obtiene la version del paquete.
  FUNCTION fsbVersion RETURN VARCHAR2;

  -- Declaracion de metodos publicos

  /*****************************************************************
  Unidad      : ClientProcessPostLegalize
  Descripcion  : Proceso que realiza acciones cuando se legaliza una
                orden. Este procedimiento se entrega sin implementacion
                y queda en manos del cliente respetar la arquitectura
                y comunicacion con sistemas externos a OpenSmartFlex.
  Autor       : David Arias Villalobos
  Fecha       : 30-Nov-2005

  Parametros          Descripcion
  ============        ===================
  Entrada:
      inuOrder_id     id de la orden
      inuAction_id    id de la accion que se realiza

  Salida:

  Historia de Modificaciones
  Fecha       Autor             Modificacion
  =========   ========= ====================
  30-Nov-2005 Darias    SAO42621. Creacion
  02-Dic-2005 Darias    SAO42993. Eliminar implementacion de codigo
                        en el metodo ClientProcessPostLegalize
  30-03-2015 Agordillo  REQ.239 Modificacion
                        * Se realiza el llamado a procedimiento Or_Boservices.ProccessLegORPLO
                        para que se ejecute antes de la validacion los demas procedimientos en el
                        momento de la legalizacion
  05-Dic-2016 RGamboa   SAO396720. Se invoca el proceso "PE_BOTaskTypeTax.UpdatePrice"
   10/07/2018  LJLB      CA 2001325 se agrega validacion de items a retirar
  ******************************************************************/
  PROCEDURE ClientProcessPostLegalize(inuOrder_id  IN OR_ORDER.ORDER_ID%TYPE,
                                      inuAction_id IN OR_TRANSITION.ACTION_ID%TYPE);

  --PROCEDURE ValidaItemCertVSDefectos (inuOrder_id     IN  OR_ORDER.ORDER_ID%type);

  PROCEDURE ValidaItemCertVSDefectos;

  --PROCEDURE GenNovRespOportPQR(inuOrder_id     IN  OR_ORDER.ORDER_ID%type);

  PROCEDURE GenNovRespOportPQR;

  PROCEDURE ldc_validatecicolegcert(inuOrder_id IN OR_ORDER.ORDER_ID%TYPE);

  --PROCEDURE REVISION_DESVIACION_CONSUMO(NuOrder_id IN  OR_ORDER.ORDER_ID%type);
  PROCEDURE REVISION_DESVIACION_CONSUMO;

  PROCEDURE REVISION_CONSUMO;

  FUNCTION fsbExecProc(sbProc IN VARCHAR2, sbPara IN VARCHAR2)
    RETURN VARCHAR2;

  FUNCTION fnuLimpCarEsp(sbCadena VARCHAR2) RETURN VARCHAR;

  /*****************************************************************
  Procedimiento   :   ProccessLegORPLO
  Descripcion     :   Permite validar si el usuario concectado al sistema puede legalizar la orden
                      de no permitir se genera un mensaje de error en la forma ORPLO
  Autor       : Alexandra Gordillo
  Fecha       : 30-03-2015

  Historia de Modificaciones
  Fecha       Autor             Modificacion
  =========   ========= ====================
  21-08-2018  Daniel Valiente   CA2001370 Se valida que las cantidades puedan llevar Decimales
  10-08-2017  STapias           CA2001299 Se agrega logica para control de documentos solo aplica GDC
  17-04-2017  KCienfuegos       CA200533 Se agrega el llamado al metodo ldc_val_tiemp_fin_eje_ord
  28-04-2016  KCienfuegos       CA200151 Se modifica para validar las fechas inicial y final
                                de ejecucion para las ordenes procesadas por LDCTA y LDCGTA.
  30-03-2015  Agordillo         REQ.239 Creacion
  ******************************************************************/
  PROCEDURE ProccessLegORPLO(inuOrden in or_order.order_id%type);

  /*****************************************************************
  Procedimiento   :   FRCGETUNIDOPERTECCERTRE
  Descripcion     :   Funcion para obtener el conjunto de registros para la forma ORTCI

  Autor       : Manuel Mejia
  Fecha       : 17-11-2015

  Historia de Modificaciones
  Fecha       Autor             Modificacion
  =========   ========= ====================
  17-11-2015  Mmejia    ARA.8602 Creacion
  ******************************************************************/
  FUNCTION FRCGETUNIDOPERTECCERTRE RETURN constants_per.tyrefcursor;

  /*****************************************************************
  Procedimiento   :   procValidMaterial
  Descripcion     :   Permite validar si el parametro esta activo
                      para el Material y verifique las cantidades
                      ingresadas
  Autor       : Daniel Valiente
  Fecha       : 21-08-2018

  Historia de Modificaciones
  Fecha       Autor             Modificacion
  =========   ========= ====================
  ******************************************************************/
  PROCEDURE procValidMaterial(inuOrden        in or_order.order_id%type,
                              onuError        out ge_message.message_id%type,
                              osbErrorMessage out VARCHAR2);

  /*****************************************************************
  Procedimiento   :   procValidCausalNoLegal
  Descripcion     :   Permite validar si el parametro esta activo
                      para el Material y verifique las cantidades
                      ingresadas
  Autor       : Daniel Valiente
  Fecha       : 21-08-2018

  Historia de Modificaciones
  Fecha       Autor             Modificacion
  =========   ========= ====================
  ******************************************************************/
  PROCEDURE procValidCausalNoLegal(inuOrden        in or_order.order_id%type,
                                   onuError        out ge_message.message_id%type,
                                   osbErrorMessage out VARCHAR2);

  PROCEDURE BLOQUEOLEGALIZACIONRP;

END Or_Boservices;
/
create or replace PACKAGE BODY Or_Boservices IS
    -- Declaracion de variables y tipos globales privados del paquete
    csbSP_NAME CONSTANT VARCHAR2(100) := $$PLSQL_UNIT || '.';
    
    -- Definicion de metodos publicos y privados del paquete

    /******************************************************************
    Funcion         :   fsbVersion
    Descripcion     :   Funcion que retorna la ultima version del SAO
    
    Autor       : David Arias Villalobos
    Fecha       : 30-Nov-2005
    
    Parametros         Descripcion
    ============  ===================
    Entrada:
    
    ============
    Retorno:
      Cadena con el ultimo sao que modifico el paquete.
    
    Historia de Modificaciones
    Fecha       Autor             Modificacion
    =========   ========= ====================
    17-04-2017  KCienfuegos CA200533: Se modifica el metodo <<ProccessLegORPLO>>
    30-Nov-2005 Darias    SAO42621. Creacion
    02-Dic-2005 Darias    SAO42993. Eliminar implementacion de codigo
                        en el metodo ClientProcessPostLegalize    
    ******************************************************************/
    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
        csbMetodo   VARCHAR2(70) := csbSP_NAME || 'fsbVersion';
        nuErrorCode NUMBER; -- se almacena codigo de error
        sbMensError VARCHAR2(2000); -- se almacena descripcion del error 
    BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
        RETURN csbVersion;
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);    
    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN
            pkg_Error.getError(nuErrorCode, sbMensError);
            pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo,
                            pkg_traza.cnuNivelTrzDef,
                            pkg_traza.csbFIN_ERC);                        
            RAISE pkg_Error.Controlled_Error;    
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuErrorCode, sbMensError);
            pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo,
                          pkg_traza.cnuNivelTrzDef,
                          pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error; 
    END;

  /*****************************************************************
  Procedimiento   :   ClientProcessPostLegalize
  Descripcion     :   Procedimiento que se encarga de realizar procesos
                      despues que se legaliza una orden.
                      Por ejemplo: Comunicacion con un sistema externo
                      que maneje inventario.

  Autor       : David Arias Villalobos
  Fecha       : 30-Nov-2005

  Parametros         Descripcion
  ============  ===================
  Entrada:
          inuOrder_id     id de la orden
          inuAction_id    id de la accion que se realiza

  ============
  Retorno:

  Historia de Modificaciones
  Fecha       Autor             Modificacion
  =========   ========= ====================
  30-Nov-2005 Darias    SAO42621. Creacion
  02-Dic-2005 Darias    SAO42993. Eliminar implementacion de codigo
                        en el metodo ClientProcessPostLegalize
  30-03-2015  Agordillo REQ.239 Modificacion
                        * Se realiza el llamado a procedimiento Or_Boservices.ProccessLegORPLO
                        para que se ejecute antes de la validacion los demas procedimientos en el
                        momento de la legalizacion
  05-Dic-2016 RGamboa   SAO396720. Se invoca el proceso "PE_BOTaskTypeTax.UpdatePrice"
  05-Dic-2016 RGamboa   SAO409090. Se elimina llamado a "PE_BOTaskTypeTax.UpdatePrice"
  26-Dic-2017 Stapias   Ca 200-1261 Se agreagan validaciones para precio de item, localidad, unidad.
  21-Feb-2018 KBaquero  Ca 200-1458 Se agreagan validaciones para maximos y mminos por item.
  10/07/2018  LJLB      CA 2001325 se agrega validacion de items a retirar
  09/05/20119 ELAL      CA 200-2471 se coloca llamado al plugin LDC_CONSTRUCCION_INSTALACIONES.PROVALITEMSCONT si aplica la
                        entrega 200-2441
  08/04/2024  JorVal    OSF-2552: * Modificacion del cursor Culdc_procedimiento_obj_2 para todos los tipos de trabajo (-1)
                                  * Se retira validacion fblaplicaentregaxcaso(csbEntrega2002471) es TRUE en PL
                                  * Se retira validacion fblAplicaEntrega(csbEntrega2001325) con tota la logica es FALSE en PL
                                  * Se retira validacion fblAplicaEntrega(csbEntrega2001458) es TRUE en PL
                                  * Se retira validacion fblAplicaEntrega(csbEntrega2001261) es TRUE en PL
                                  * Se retira validacion fblaplicaentregaxcaso('0000858') es TRUE en PL
  15/05/2024  PAcosta   OSF-2678: Borrado objeto LDC_PROVALIDAITEMLOCTIPLIS de la lógica del proceso                     
  22/07/2024  JorVal    OSF-2880: * Realizar el llamado del nuevo servicio PRCVALIDAFINANCIACIONCARGOS del
                                    esquema personalizaciones para validar que no exista cargo a la -1 
                                    de la solicitud de orden legalizada
  ******************************************************************/
  PROCEDURE ClientProcessPostLegalize(inuOrder_id  IN OR_ORDER.ORDER_ID%TYPE,
                                      inuAction_id IN OR_TRANSITION.ACTION_ID%TYPE) IS
  
    CURSOR CurTrabOT(NumOrd Or_order.ORDER_ID%TYPE) IS
      SELECT TASK_TYPE_ID, CAUSAL_ID FROM or_order WHERE ORDER_ID = NumOrd;
  
    NumCodtrab   Or_order.TASK_TYPE_ID%TYPE;
    NuMCAUSAL_ID Or_order.CAUSAL_ID%TYPE;
  
    nuErrorCode    NUMBER;
    sbErrorMessage VARCHAR2(4000);
  
    ---ejecutar procedimiento en donde se tiene en cuenta las cuasales
    CURSOR Culdc_procedimiento_obj_1(NuTASK_TYPE_ID IN ldc_procedimiento_obj.TASK_TYPE_ID%TYPE,
                                     NuCAUSAL_ID    IN ldc_procedimiento_obj.CAUSAL_ID%TYPE) IS
      SELECT TASK_TYPE_ID, CAUSAL_ID, PROCEDIMIENTO, ORDEN_EJEC
        FROM ldc_procedimiento_obj
       WHERE ACTIVO = 'S'
         AND TASK_TYPE_ID = NuTASK_TYPE_ID
         AND CAUSAL_ID = NuCAUSAL_ID
       ORDER BY ORDEN_EJEC;
  
    ---ejecutar procedimiento en donde NO se tiene en cuenta las cuasales
    CURSOR Culdc_procedimiento_obj_2(NuTASK_TYPE_ID IN ldc_procedimiento_obj.TASK_TYPE_ID%TYPE) IS
      SELECT TASK_TYPE_ID, CAUSAL_ID, PROCEDIMIENTO, ORDEN_EJEC
        FROM ldc_procedimiento_obj
       WHERE ACTIVO = 'S'
         AND (TASK_TYPE_ID = NuTASK_TYPE_ID OR TASK_TYPE_ID = -1)
         AND CAUSAL_ID IS NULL
       ORDER BY ORDEN_EJEC;
  
    --TICKET 2001325 LJLB-- se valida retiro de items
    CURSOR cuValidarItemReti IS
      SELECT 'Esta legalizando el Retiro del Item [' || oi.items_id || '-' ||
             dage_items.fsbgetDescription(oi.items_id, null) ||
             '] el cual no esta habilitado para este proceso. Por favor Validar Parametros LDC_TIPOMEDIVAL y LDC_ITEM_PERMRETI.'
        FROM or_order_items oi
       WHERE NOT EXISTS (SELECT 'X'
                FROM ge_items i
               WHERE (i.id_items_tipo IN
                     (SELECT to_number(regexp_substr(pkg_bcld_parameter.fsbObtieneValorCadena('LDC_TIPOMEDIVAL'),
                                                      '[^,]+',
                                                      1,
                                                      LEVEL)) AS column_value
                         FROM dual
                       CONNECT BY regexp_substr(pkg_bcld_parameter.fsbObtieneValorCadena('LDC_TIPOMEDIVAL'),
                                                '[^,]+',
                                                1,
                                                LEVEL) IS NOT NULL) OR
                     i.items_id IN
                     (SELECT to_number(regexp_substr(pkg_bcld_parameter.fsbObtieneValorCadena('LDC_ITEM_PERMRETI'),
                                                      '[^,]+',
                                                      1,
                                                      LEVEL)) AS column_value
                         FROM dual
                       CONNECT BY regexp_substr(pkg_bcld_parameter.fsbObtieneValorCadena('LDC_ITEM_PERMRETI'),
                                                '[^,]+',
                                                1,
                                                LEVEL) IS NOT NULL))
                 AND i.ITEMS_ID = oi.items_id)
         AND oi.OUT_ = 'N'
         AND OI.ORDER_ID = inuOrder_id
         AND oi.LEGAL_ITEM_AMOUNT > 0;
  
    Sbproced VARCHAR2(1000);
  
    SbResp VARCHAR2(1000);
    --Variables agregadas caso 200-1261
    nuresp       NUMBER;
    Onuerrorcode NUMBER;
    Osberrormsg  VARCHAR2(3000);
  
    csbMetodo VARCHAR2(70) := csbSP_NAME || 'ClientProcessPostLegalize';
  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
    NOrder_id := inuOrder_id;
  
    -- Inicio Agordillo REQ.239
    Or_Boservices.ProccessLegORPLO(NOrder_id);
    -- Fin Agordillo REQ.239
  
    LDC_CONSTRUCCION_INSTALACIONES.PROVALITEMSCONT;
  
    pkg_traza.trace('Entro cursor CurTrabOT', pkg_traza.cnuNivelTrzDef);
  
    OPEN CurTrabOT(inuOrder_id);
    FETCH CurTrabOT
      INTO NumCodtrab, NuMCAUSAL_ID;
    CLOSE CurTrabOT;
  
    pkg_traza.trace('Salio cursor CurTrabOT', pkg_traza.cnuNivelTrzDef);
  
    -- Cambios caso 200-1261
    IF inuOrder_id IS NOT NULL THEN
      pkg_traza.trace('Inicia ldc_provalidaitemsleguonl',
                      pkg_traza.cnuNivelTrzDef);
      ldc_provalidaitemsleguonl(inuOrder_id,
                                nuresp,
                                Onuerrorcode,
                                Osberrormsg);
      pkg_traza.trace('Ejecuto ldc_provalidaitemsleguonl: inuOrder_id[' ||
                      inuOrder_id || '] nuresp[' || nuresp ||
                      '] Onuerrorcode[' || Onuerrorcode ||
                      '] Osberrormsg[' || Osberrormsg || ']',
                      pkg_traza.cnuNivelTrzDef);
    
      IF nuresp = 0 and Onuerrorcode <> 0 THEN
        pkg_error.SetErrorMessage(isbMsgErrr => Osberrormsg);
        RAISE pkg_Error.Controlled_Error;
      END IF;      
    
      IF nuresp = 0 and Onuerrorcode <> 0 THEN
        pkg_error.SetErrorMessage(isbMsgErrr => Osberrormsg);
        RAISE pkg_Error.Controlled_Error;
      END IF;
    END IF;
    -- Fin 200-1261
  
    /*Caso 200-1458*/
    pkg_traza.trace('Orden[' || inuOrder_id || ']',
                    pkg_traza.cnuNivelTrzDef);
  
    IF inuOrder_id IS NOT NULL THEN
      LDC_PROCONFMAXMINITEMS(inuOrder_id);
      pkg_traza.trace('Ejecuto LDC_PROCONFMAXMINITEMS orden[' ||
                      inuOrder_id || ']',
                      pkg_traza.cnuNivelTrzDef);
    end if;
  
    IF NumCodtrab IS NOT NULL THEN
    
      pkg_traza.trace('Entro al if NumCodTrab', pkg_traza.cnuNivelTrzDef);
    
      --- cuando se ejecutan procedimiento al trabajo y la causal
      FOR CAUSAL IN Culdc_procedimiento_obj_1(NumCodtrab, NuMCAUSAL_ID) LOOP
      
        Sbproced := REPLACE(CAUSAL.PROCEDIMIENTO, ' ', ''); 
      
        Sbproced := 'BEGIN ' || Sbproced || '; END;';
      
        pkg_traza.trace('Proceso CAUSAL Sbproced ' || Sbproced,
                        pkg_traza.cnuNivelTrzDef);
      
        EXECUTE IMMEDIATE (Sbproced);
      
      END LOOP;
    
      ---Ciclo para ejecutar procedimientos de acuerdo al trabajo
      FOR SINCAUSAL IN Culdc_procedimiento_obj_2(NumCodtrab) LOOP
      
        Sbproced := REPLACE(SINCAUSAL.PROCEDIMIENTO, ' ', '');
      
        Sbproced := 'BEGIN ' || Sbproced || '; END;';
        pkg_traza.trace('Proceso SINCAUSAL Sbproced ' || Sbproced,
                        pkg_traza.cnuNivelTrzDef);
        EXECUTE IMMEDIATE Sbproced;
      END LOOP;
    
    END IF;
  
    BLOQUEOLEGALIZACIONRP;
    
    --Inicio 2880
    PRCVALIDAFINANCIACIONCARGOS;
    --Fin 2880
  
    pkg_traza.trace('Salio if NumCodTrab', pkg_traza.cnuNivelTrzDef);
  
    -- Verifica certificacion tecnico para realizar trabajos
  
    pkg_traza.trace('Ejecuta Inicio LDC_VALIDATECICOLEGCERT',
                    pkg_traza.cnuNivelTrzDef);
  
    ldc_validatecicolegcert(inuOrder_id);
  
    pkg_traza.trace('Ejecuta Fin LDC_VALIDATECICOLEGCERT',
                    pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    --se coloca comentario mientras se habla con John Jimenez    06052013
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(Onuerrorcode, Osberrormsg);
      pkg_traza.trace('Error: ' || Osberrormsg, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(Onuerrorcode, Osberrormsg);
      pkg_traza.trace('Error: ' || Osberrormsg, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
    
  END ClientProcessPostLegalize;

  /*****************************************************************
  Procedimiento   :   ValidaItemCertVSDefectos
  Descripcion     :   Realiza la validacion que si una OT de certificacion tiene defectos no permita registrar un items de CERTIFICACION
                    y si la OT de certificacion no tiene defectos obliga a digitar el item de certificacion.
          Si hay alguno de estos dos eventos se lanza un error.
  Autor       : Jose Filigrana
  Fecha       : 07-02-2013

  Parametros         Descripcion
  ============  ===================
  Entrada:
          inuOrder_id     id de la orden
          inuAction_id    id de la accion que se realiza

  ============
  Retorno:

  Historia de Modificaciones
  Fecha       Autor             Modificacion
  =========   ========= ====================

  ******************************************************************/

  --  PROCEDURE ValidaItemCertVSDefectos (inuOrder_id     IN  OR_ORDER.ORDER_ID%type ) IS
  PROCEDURE ValidaItemCertVSDefectos IS
    --- RNP 603
    ---Cursor que permita saber si una orden de trabajo tiene defectologia
    CURSOR CurDefect(NumOrden or_order.ORDER_ID%TYPE) IS
      SELECT COUNT(1)
        FROM or_order          a,
             or_order_activity b,
             or_activ_defect   c,
             ge_defect         d
       WHERE a.order_id = NumOrden
         AND b.order_id = a.order_id
         AND b.order_activity_id = c.order_activity_id
         AND c.defect_id = d.defect_id;

    ---Cursor para saber la cantidad legalizada del item de certificacion de PRP en una orden de trabajo
    CURSOR CurCantItemCert(NumOrden or_order.ORDER_ID%TYPE) IS
      SELECT LEGAL_ITEM_AMOUNT
        FROM or_order_items
       WHERE ORDER_ID = NumOrden
         AND ITEMS_ID = 4000065; ---CERTIFICACION TRABAJOS PRP

    ----Nueva modificacion solicitada por Adolfo
    CURSOR CurItemCert(NumOrden or_order.ORDER_ID%TYPE,
                       Nuitems  or_order_items.ITEMS_ID%TYPE) IS
      SELECT LEGAL_ITEM_AMOUNT
        FROM or_order_items
       WHERE ORDER_ID = NumOrden
         AND ITEMS_ID = Nuitems;

    CURSOR CurCuasalLeg(NumOrd Or_order.ORDER_ID%TYPE) IS
      SELECT a.CAUSAL_ID, b.CLASS_CAUSAL_ID
        FROM or_order a, ge_causal b
       WHERE a.CAUSAL_ID = b.CAUSAL_ID
         AND ORDER_ID = NumOrd;

    NumCantDef  NUMBER;
    NumCantItem NUMBER;

    NoDato   EXCEPTION;
    SbMensaj VARCHAR(1000);

    inuOrder_id OR_ORDER.ORDER_ID%TYPE;

    NuCausal     ge_causal.CAUSAL_ID%TYPE;
    NuClassCau   ge_causal.CLASS_CAUSAL_ID%TYPE;
    SbValDatoADD VARCHAR2(30);

    csbMetodo VARCHAR2(70) := csbSP_NAME || 'ValidaItemCertVSDefectos';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error     

  BEGIN

    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);

    inuOrder_id  := NOrder_id;
    SbValDatoADD := Ldc_Boordenes.FnugetValorOTbyDatAdd(12161,
                                                        11721,
                                                        'RESULTADO_RP',
                                                        inuOrder_id);

    OPEN CurDefect(inuOrder_id);
    FETCH CurDefect
      INTO NumCantDef;
    IF CurDefect%NOTFOUND THEN
      NumCantDef := 0;
    END IF;
    CLOSE CurDefect;

    OPEN CurCantItemCert(inuOrder_id);
    FETCH CurCantItemCert
      INTO NumCantItem;
    IF CurCantItemCert%NOTFOUND THEN
      NumCantItem := 0;
    END IF;
    CLOSE CurCantItemCert;

    OPEN CurCuasalLeg(inuOrder_id);
    FETCH CurCuasalLeg
      INTO NuCausal, NuClassCau;
    IF CurCuasalLeg%NOTFOUND THEN
      NuClassCau := 0;
    END IF;
    CLOSE CurCuasalLeg;

    IF NuClassCau = 1 AND NumCantItem > 0 THEN

      IF NumCantDef > 0 AND NumCantItem > 0 THEN
        ---Lanzar mensage
        pkg_error.SetErrorMessage(isbMsgErrr => 'La orden legalizada no debe de tener un item de CERTIFICACION porque tiene defectos #' ||
                                  NumCantDef);

        SbMensaj := 'La orden legalizada no debe de tener un item de CERTIFICACION porque tiene defectos #' ||
                    NumCantDef;

        RAISE pkg_Error.Controlled_Error;
      END IF;

    END IF;

    IF NuClassCau = 1 AND NumCantDef > 0 AND NuCausal <> 8967THEN

     SbMensaj :=
     'No se puede legalizar la OT, con una causal de exito teniendo defectos' ;
     RAISE pkg_Error.Controlled_Error ; END IF ;

     IF NuClassCau <> 1 AND NumCantItem > 0 THEN
      SbMensaj := 'No se puede legalizar la OT, con una causal de fallo teniendo sin defectos';
      RAISE pkg_Error.Controlled_Error;
    END IF;

    IF NuCausal = 8967 AND NumCantItem > 0 THEN
      SbMensaj := 'No se puede legalizar la OT, con el items de INSPECCION Y/O CERTIFICACION TRABAJOS REVISION PERIODICA';
      RAISE pkg_Error.Controlled_Error;
    END IF;

    ---Nuevas validaciones solicitadas por Adolfo

    IF SbValDatoADD = '1 INSTALACION CERTIFICADA' THEN

      ---Certiricada por primera vez
      IF NuClassCau IN (9515, 3098, 3099, 3100, 3101, 3102) THEN
        OPEN CurItemCert(inuOrder_id, 4294613);
        FETCH CurItemCert
          INTO NumCantItem;
        IF CurItemCert%NOTFOUND THEN
          NumCantItem := 0;
          SbMensaj    := 'No se puede legalizar la OT, Debe de tener un item 2494613 CERTIFICACION EN PRIMERA VISITA';
          RAISE pkg_Error.Controlled_Error;
        END IF;
        CLOSE CurItemCert;
      END IF;

      --- Certificada despues de reparaciones
      IF NuClassCau = 9515 THEN
        OPEN CurItemCert(inuOrder_id, 4295299);
        FETCH CurItemCert
          INTO NumCantItem;
        IF CurItemCert%NOTFOUND THEN
          NumCantItem := 0;
          SbMensaj    := 'No se puede legalizar la OT, Debe de tener un item 4295299 CERTIFICACION POR REPARACION DE PRP';
          RAISE pkg_Error.Controlled_Error;
        END IF;
        CLOSE CurItemCert;
      END IF;

      IF NuClassCau IN (8967, 9094) THEN
        SbMensaj := 'No se puede legalizar la OT, Error en la causal de legalizacion';
        RAISE pkg_Error.Controlled_Error;

      END IF;
    END IF;

    IF SbValDatoADD = '2 INSTALACION PENDIENTE POR CERTIFICAR' THEN
      IF NuClassCau IN (8967, 3098, 3099, 3100, 3101, 3102) THEN
        OPEN CurItemCert(inuOrder_id, 4000067);
        FETCH CurItemCert
          INTO NumCantItem;
        IF CurItemCert%NOTFOUND THEN
          NumCantItem := 0;
          SbMensaj    := 'No se puede legalizar la OT, Debe de tener un item 4000067  SUSPENSION POR DEFECTO CRITICO';
          RAISE pkg_Error.Controlled_Error;
        END IF;
        CLOSE CurItemCert;
      END IF;

      IF NuClassCau IN (9094, 9515) THEN
        SbMensaj := 'No se puede legalizar la OT, Error en la causal de legalizacion';
        RAISE pkg_Error.Controlled_Error;

      END IF;

    END IF;

    IF SbValDatoADD = '3 INSTALACION APTA PARA SERVICIO' THEN
      IF NuClassCau IN (9094, 3098, 3099, 3100, 3101, 3102) THEN
        OPEN CurItemCert(inuOrder_id, 4295021);
        FETCH CurItemCert
          INTO NumCantItem;
        IF CurItemCert%NOTFOUND THEN
          NumCantItem := 0;
          SbMensaj    := 'No se puede legalizar la OT, Debe de tener un item 4295021  APTA PARA SERVICIO';
          RAISE pkg_Error.Controlled_Error;
        END IF;
        CLOSE CurItemCert;
      END IF;

      IF NuClassCau IN (8967, 9515) THEN
        SbMensaj := 'No se puede legalizar la OT, Error en la causal de legalizacion';
        RAISE pkg_Error.Controlled_Error;

      END IF;
    END IF;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN PROGRAM_ERROR THEN
      pkg_error.SetErrorMessage(isbMsgErrr => 'Sea a producido un error realizando la validacion de los defectos error ' ||
                                              TO_CHAR(SQLCODE) || 
                                              ' Mensaje ' || SQLERRM);
    WHEN pkg_Error.Controlled_Error THEN
      pkg_error.SetErrorMessage(isbMsgErrr => SbMensaj);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);                        
      RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, SbMensaj);
      pkg_traza.trace('Error: ' || SbMensaj, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error; 

  END ValidaItemCertVSDefectos;

  PROCEDURE GenNovRespOportPQR IS

    CURSOR CurOT(nuOrder_id IN OR_ORDER.ORDER_ID%TYPE) IS
      SELECT ASSIGNED_DATE,
             LEGALIZATION_DATE,
             OPERATING_UNIT_ID,
             ASSO_UNIT_ID,
             CAUSAL_ID
        FROM OR_ORDER
       WHERE order_id = nuOrder_id
         AND TASK_TYPE_ID = 12612;

    DTASSIGNED_DATE     OR_ORDER.ASSIGNED_DATE%TYPE;
    DTLEGALIZATION_DATE OR_ORDER.LEGALIZATION_DATE%TYPE;
    NuOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE;
    NuASSO_UNIT_ID      OR_ORDER.ASSO_UNIT_ID%TYPE;
    NuCAUSAL_ID         OR_ORDER.CAUSAL_ID%TYPE;

    NuOport NUMBER;

    inuOrder_id OR_ORDER.ORDER_ID%TYPE;

    csbMetodo VARCHAR2(70) := csbSP_NAME || 'GenNovRespOportPQR';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error  

  BEGIN

    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);

    inuOrder_id := NOrder_id;

    OPEN CurOT(inuOrder_id);
    FETCH CurOT
      INTO DTASSIGNED_DATE,
           DTLEGALIZATION_DATE,
           NuOPERATING_UNIT_ID,
           NuASSO_UNIT_ID,
           NuCAUSAL_ID;
    CLOSE CurOT;

    NuOport := 0;

    ---Causal de legalizacion procedente
    IF NuCAUSAL_ID IS NOT NULL AND NuCAUSAL_ID = 3002 THEN

      --- crea la OT de novedad para Respuesta oportuna a PQR
      Ct_Bonovelty.createnoveltyrule(NuOPERATING_UNIT_ID,
                                     4000591,
                                     NuASSO_UNIT_ID,
                                     inuOrder_id,
                                     1,
                                     1,
                                     NULL,
                                     105,
                                     'Novedad Respuesta oportuna a PQR ');

    END IF;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN OTHERS THEN
      pkg_error.SetErrorMessage(isbMsgErrr => 'Sea a producido un error realizando la validacion de los defectos error ' ||
                                TO_CHAR(SQLCODE) || ' Mensaje ' || SQLERRM);

  END GenNovRespOportPQR;

  PROCEDURE ldc_validatecicolegcert( inuOrder_id IN OR_ORDER.ORDER_ID%TYPE) IS

    /**************************************************************
    Propiedad intelectual PETI.

    procedimiento  :  ldc_validatecicolegcert

    Descripcion  : Verifica si el tecnico tiene certificacion vigente para que se le asigne o legaize trabajos

    Autor  : John Jairo Jimenez Marimon
    Fecha  : 07-03-2013

    Historia de Modificaciones
    Fecha       Autor             Modificacion
    =========   ========= ====================
    13-11-2015  Mmejia    ARA.8602 Modificacion  para que valide la  vigencia del tecnico
                          con la fecha fin de ejecucion de la orden.
    25-10-2016  BICM      CA 200-526 Se modifica para obtener correctamente la clase de causal en lugar del tipo de causal
    15-05-2024  PAcosta   OSF-2678: Borrado objetos LDC_CONSULTACERTVIGTECFE y LDC_CONSULTACERTVIGTEC de la lógica del proceso  
                                    Cambio DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID por PKG_BCORDENES.FNUOBTIENECLASECAUSAL
                                    Cambio DAOR_ORDER.FDTGETEXECUTION_FINAL_DATE por PKG_BCORDENES.FDTOBTIENEFECHAEJECUFIN
                                    Cambio DAOR_ORDER.FNUGETCAUSAL_ID por PKG_BCORDENES.FNUOBTIENECAUSAL
    **************************************************************/
        
    -- nuconta          NUMBER DEFAULT 0;
    nuregla          NUMBER DEFAULT 0;
    nuconta2         NUMBER DEFAULT 0;
    sbdescription    or_task_type.description%TYPE;
    eerror_no_existe EXCEPTION;
    eerror3          EXCEPTION;
    eerror           EXCEPTION;
    nuunidad         or_order_person.operating_unit_id%TYPE;
    nutecnico        or_order_person.person_id%TYPE;
    nuorden          or_order_person.order_id%TYPE;
    nuCausaLeg       or_order.causal_id%TYPE;
    nuClaseCauLeg    GE_CAUSAL_TYPE.causal_type_id%TYPE;
    daFeFinEjeOrd    or_order.execution_final_date%TYPE;

    CURSOR cu_or_order_person(nuorden NUMBER) IS
      SELECT * FROM or_order_person o WHERE o.order_id = nuorden;

    csbMetodo VARCHAR2(70) := csbSP_NAME || 'ldc_validatecicolegcert';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error  
      
  BEGIN
    
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
    
    nuCausaLeg := pkg_bcordenes.fnuobtienecausal(inuOrder_id);
    --CA 200-526
    nuClaseCauLeg := pkg_bcordenes.fnuobtieneclasecausal(nuCausaLeg);
    daFeFinEjeOrd := pkg_bcordenes.fdtobtienefechaejecufin(inuOrder_id);

    IF nuClaseCauLeg <> 2 THEN
      IF NVL(Ldc_Validatitrsecert(inuOrder_id), 0) > 0 THEN
        nuunidad  := NULL;
        nutecnico := NULL;
        nuorden   := NULL;
        FOR i IN cu_or_order_person(inuOrder_id) LOOP
          nuunidad  := i.operating_unit_id;
          nutecnico := i.person_id;
          nuorden   := i.order_id;
          SELECT COUNT(1)
            INTO nuregla
            FROM ldc_asig_ot_tecn
           WHERE unidad_operativa = nuunidad
             AND tecnico_unidad = nutecnico
             AND orden = nuorden;
          IF nuregla = 0 THEN
            RAISE eerror3;          
          END IF;
        END LOOP;
        IF nuorden IS NULL THEN
          RAISE eerror_no_existe;
        END IF;
      END IF;
    END IF;
    NULL;
    
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    
  EXCEPTION
    WHEN eerror_no_existe THEN
      pkg_error.SetErrorMessage(isbMsgErrr => 'La orden : ' || inuOrder_id || ' no tiene tecnicos asociados.');
    WHEN eerror3 THEN
      pkg_error.SetErrorMessage(isbMsgErrr => 'La unidad operativa : ' || nuunidad ||
                                ' y el tecnico : ' || nutecnico ||
                                ' no tienen asociada la orden : ' || nuorden ||
                                ' en la entidad asociasion orden a tecnico.');
    WHEN eerror THEN
      pkg_error.SetErrorMessage(isbMsgErrr => 'El tecnico : ' || nutecnico ||
                                ' asociado a la unidad operativa : ' || nuunidad ||
                                ' no puede legalizar la orden :' || nuorden ||
                                ' debido a que no tiene certificacion vigente para realizar el trabajo :' ||
                                sbdescription);
  END;

  PROCEDURE REVISION_DESVIACION_CONSUMO IS

    --- para saber la cantidad de item SIN REVISION INTERNA han sido legalizados en una OT
    CURSOR CurSinReviInt(NOrder_id IN OR_ORDER.ORDER_ID%TYPE) IS
      SELECT SUM(LEGAL_ITEM_AMOUNT)
        FROM or_order_items
       WHERE ORDER_ID = NOrder_id
         AND ITEMS_ID = 1001914;

    --- para saber la cantidad de item DESV CONSUMO (REVI INTERNA) han sido legalizados en una OT
    CURSOR CurReviInt(NOrder_id IN OR_ORDER.ORDER_ID%TYPE) IS
      SELECT SUM(LEGAL_ITEM_AMOUNT)
        FROM or_order_items
       WHERE ORDER_ID = NOrder_id
         AND ITEMS_ID = 1001913;

    CntSinRevi NUMBER;
    CntRevi    NUMBER;

    NoDato EXCEPTION;

    nuErrorCode    NUMBER;
    sbErrorMessage VARCHAR2(4000);

    error NUMBER;

    NuOrder_id OR_ORDER.ORDER_ID%TYPE;

    csbMetodo VARCHAR2(70) := csbSP_NAME || 'REVISION_DESVIACION_CONSUMO';
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error  

  BEGIN
    
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

    NuOrder_id := NOrder_id;

    pkg_traza.trace('REVISION_DESVIACION_CONSUMO' || NuOrder_id, pkg_traza.cnuNivelTrzDef); 

    OPEN CurSinReviInt(NuOrder_id);
    FETCH CurSinReviInt
      INTO CntSinRevi;
    IF CurSinReviInt%NOTFOUND THEN
      CntSinRevi := 0;
    END IF;

    OPEN CurReviInt(NuOrder_id);
    FETCH CurReviInt
      INTO CntRevi;
    IF CurReviInt%NOTFOUND THEN
      CntRevi := 0;
    END IF;

    pkg_traza.trace('CntSinRevi: ' || CntSinRevi, pkg_traza.cnuNivelTrzDef); 
    pkg_traza.trace('CntRevi: ' || CntRevi, pkg_traza.cnuNivelTrzDef); 

    --- Valida que no se haya resgistrado cantidades en los dos items
    IF CntSinRevi > 0 AND CntRevi > 0 THEN      
      sbErrorMessage := 'Solo puede legalizar un ITEM con cantidad mayor a cero (0), ya sea el ITEM 1001914 o el ITEM 1001913 ';
      pkg_traza.trace(sbErrorMessage, pkg_traza.cnuNivelTrzDef); 
      RAISE pkg_Error.Controlled_Error;
    END IF;

    IF CntSinRevi > 1 THEN
      sbErrorMessage := 'La cantidad del ITEM 1001914 no puede ser mayor a uno (1)';
      pkg_traza.trace(sbErrorMessage, pkg_traza.cnuNivelTrzDef); 
      RAISE pkg_Error.Controlled_Error;
    END IF;

    IF CntRevi > 1 THEN
      sbErrorMessage := 'La cantidad del ITEM 1001913 no puede ser mayor a uno (1)';
      pkg_traza.trace(sbErrorMessage, pkg_traza.cnuNivelTrzDef); 
      pkg_error.SetErrorMessage(isbMsgErrr => 'La cantidad del ITEM 1001913 no puede ser mayor a uno (1)');
      RAISE pkg_Error.Controlled_Error;
    END IF;
    
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_error.SetErrorMessage(isbMsgErrr => sbErrorMessage);
      pkg_error.SetErrorMessage(isbMsgErrr => 'VALIDANDO Solo puede legalizar un ITEM con cantidad mayor a cero (0), ya sea el ITEM 1001914 o el ITEM 1001913 ');
    RAISE pkg_Error.Controlled_Error;    

    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
    RAISE pkg_Error.Controlled_Error;  

  END;

  PROCEDURE REVISION_CONSUMO IS

    --- para saber la cantidad de item SIN REVISION INTERNA han sido legalizados en una OT
    CURSOR CurSinReviInt(NOrder_id IN OR_ORDER.ORDER_ID%TYPE) IS
      SELECT SUM(LEGAL_ITEM_AMOUNT)
        FROM or_order_items
       WHERE ORDER_ID = NOrder_id
         AND ITEMS_ID = 4295060;

    --- para saber la cantidad de item DESV CONSUMO (REVI INTERNA) han sido legalizados en una OT
    CURSOR CurReviInt(NOrder_id IN OR_ORDER.ORDER_ID%TYPE) IS
      SELECT SUM(LEGAL_ITEM_AMOUNT)
        FROM or_order_items
       WHERE ORDER_ID = NOrder_id
         AND ITEMS_ID = 4295153;

    CntSinRevi NUMBER;
    CntRevi    NUMBER;

    NoDato EXCEPTION;

    nuErrorCode    NUMBER;
    sbErrorMessage VARCHAR2(4000);

    error NUMBER;

    NuOrder_id OR_ORDER.ORDER_ID%TYPE;

    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'REVISION_CONSUMO';
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 

  BEGIN
    
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

    NuOrder_id := NOrder_id;

    pkg_traza.trace('REVISION_CONSUMO - Orden: ' || NuOrder_id, pkg_traza.cnuNivelTrzDef); 

    OPEN CurSinReviInt(NuOrder_id);
    FETCH CurSinReviInt
      INTO CntSinRevi;
    IF CurSinReviInt%NOTFOUND THEN
      CntSinRevi := 0;
    END IF;

    OPEN CurReviInt(NuOrder_id);
    FETCH CurReviInt
      INTO CntRevi;
    IF CurReviInt%NOTFOUND THEN
      CntRevi := 0;
    END IF;

    pkg_traza.trace('CntSinRevi: ' || CntSinRevi, pkg_traza.cnuNivelTrzDef); 
    pkg_traza.trace('CntRevi: ' || CntRevi, pkg_traza.cnuNivelTrzDef); 

    --- Valida que no se haya resgistrado cantidades en los dos items
    IF CntSinRevi > 0 AND CntRevi > 0 THEN
      sbErrorMessage := 'Solo puede legalizar un ITEM con cantidad mayor a cero (0), ya sea el ITEM 1001914 o el ITEM 1001913 ';
      pkg_traza.trace(sbErrorMessage, pkg_traza.cnuNivelTrzDef); 
      RAISE pkg_Error.Controlled_Error;
    END IF;

    IF CntSinRevi > 1 THEN
      sbErrorMessage := 'La cantidad del ITEM 1001914 no puede ser mayor a uno (1)';
      pkg_traza.trace(sbErrorMessage, pkg_traza.cnuNivelTrzDef); 
      RAISE pkg_Error.Controlled_Error;
    END IF;

    IF CntRevi > 1 THEN      
      sbErrorMessage := 'La cantidad del ITEM 1001913 no puede ser mayor a uno (1)';
      pkg_traza.trace(sbErrorMessage, pkg_traza.cnuNivelTrzDef); 
      pkg_error.SetErrorMessage(isbMsgErrr => 'La cantidad del ITEM 1001913 no puede ser mayor a uno (1)');
      RAISE pkg_Error.Controlled_Error;

    END IF;
    
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_error.SetErrorMessage(isbMsgErrr => sbErrorMessage);
      pkg_error.SetErrorMessage(isbMsgErrr => 'VALIDANDO Solo puede legalizar un ITEM con cantidad mayor a cero (0), ya sea el ITEM 1001914 o el ITEM 1001913 ');
    RAISE pkg_Error.Controlled_Error;    

    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
    RAISE pkg_Error.Controlled_Error; 


  END REVISION_CONSUMO;

  ---

  FUNCTION fsbExecProc(sbProc IN VARCHAR2, sbPara IN VARCHAR2)
    RETURN VARCHAR2 IS
    /***************************************************************************
      HISTORIA DE MODIFICACIONES
      AUTOR: Jose Filigrana
    Fecha: 15/05/2013
    DESCRIPCION: Se adiciono la comparacion de si sbProc es NULL
            ya que cuando este parametro entraba en null
            generaba un error.
      ***************************************************************************/
    sql_cursor INTEGER; -- Cursor del SQL
    ROWS       NUMBER; -- Ignorar
    sbScript   VARCHAR2(200); -- Texto del SQL dinamico
    sbError    VARCHAR2(2000) := '0|'; -- Error que retornan los procedimientos

    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'fsbExecProc';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 
        
  BEGIN

    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

    IF sbProc IS NULL THEN
      RETURN('0|');
    END IF;
    sql_cursor := DBMS_SQL.OPEN_CURSOR;

    sbScript := 'BEGIN ' || sbProc || '; END;';

    sbScript := Or_Boservices.fnuLimpCarEsp(sbScript);

    DBMS_SQL.PARSE(sql_cursor, sbScript, dbms_sql.v7);
    pkg_traza.trace(sbScript, pkg_traza.cnuNivelTrzDef);     
    DBMS_SQL.BIND_VARIABLE(sql_cursor, ':sbPara', sbPara);
    DBMS_SQL.BIND_VARIABLE(sql_cursor, ':sbError', sbError, 2000);
    ROWS := DBMS_SQL.EXECUTE(sql_cursor);
    DBMS_SQL.VARIABLE_VALUE(sql_cursor, ':sbError', sbError);
    DBMS_SQL.CLOSE_CURSOR(sql_cursor);

    pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);     
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    RETURN(sbError);
  EXCEPTION
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      DBMS_SQL.CLOSE_CURSOR(sql_cursor);
      RETURN('1|' || SQLERRM);
      
  END fsbExecProc;

  FUNCTION fnuLimpCarEsp(sbCadena VARCHAR2) RETURN VARCHAR IS
    /************************************************************************

    FUNCTION         : fnuLimpCarEsp
    AUTOR            : Jose Filigrana
    FECHA            : 15-05-2013
    DESCRIPCION      : Se encarga de limpiar la cadena entrada
                       de caracteres especiales no visibles
    RETORNA          : sbCadRet sin caracteres especiales

    PARAMETROS DE ENTRADA
    sbCadena     cadena

    PARAMETROS DE SALIDA

    HISTORIA DE MODIFICACIONES
    Fecha    Autor  Modificacion
    ************************************************************************/
    sbCadRet VARCHAR2(2000) := NULL;
    nuLonReq NUMBER;

    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'fnuLimpCarEsp';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 

  BEGIN

    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

    sbCadRet := sbCadena;
    sbCadRet := REPLACE(sbCadRet, CHR(08)); -- Backspace .
    sbCadRet := REPLACE(sbCadRet, CHR(09)); -- Tab .
    sbCadRet := REPLACE(sbCadRet, CHR(10)); -- fin de Linea .
    sbCadRet := REPLACE(sbCadRet, CHR(11)); -- Especial .
    sbCadRet := REPLACE(sbCadRet, CHR(12)); -- Saldo Pagina .
    sbCadRet := REPLACE(sbCadRet, CHR(13)); -- Enter .

    sbCadRet := LTRIM(RTRIM(sbCadRet));
    nuLonReq := LENGTH(sbCadRet);
    sbCadRet := SUBSTR(sbCadRet, 1, nuLonReq);

    pkg_traza.trace('sbCadRet: '||sbCadRet, pkg_traza.cnuNivelTrzDef); 
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    RETURN(sbCadRet);

  EXCEPTION

    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RETURN(sbCadRet);

    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
     RETURN(sbCadRet);
    
  END fnuLimpCarEsp;

  /*****************************************************************
  Procedimiento   :   ProccessLegORPLO
  Descripcion     :   Permite validar si el usuario concectado al sistema puede legalizar la orden
                      de no permitir se genera un mensaje de error en la forma ORPLO
  Autor       : Alexandra Gordillo
  Fecha       : 30-03-2015

  Historia de Modificaciones
  Fecha       Autor             Modificacion
  =========   =========         ====================
  15-05-2024  PAcosta           OSF-2678: Borrado objeto LDC_VAL_EXEC_DATE_ORDERS de la lógica del proceso
                                          Cambio DALD_PARAMETER.FSBGETVALUE_CHAIN por PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA
                                          Cambio ERRORS.SETERROR por PKG_ERROR.SETERROR
                                          Se retira validacion FBLAPLICAENTREGA(csbEntrega2001370) con la logica, resultado FALSE 
                                          Se retira validacion FBLAPLICAENTREGA(csbEntrega2001299) dejando la logica, resultado TRUE
                                          Cambio GE_BOPERSONAL.FNUGETPERSONID por PKG_BOPERSONAL.FNUGETPERSONAID
  21-08-2018  Daniel Valiente   CA2001370 Se valida que las cantidades puedan llevar Decimales
  10-08-2017  STapias           CA2001299 Se agrega logica para control de documentos solo aplica GDC
  17-04-2017  KCienfuegos       CA200533 Se agrega el llamado al metodo ldc_val_tiemp_fin_eje_ord
  28-04-2016  KCienfuegos       CA200151 Se modifica para validar las fechas inicial y final
                                de ejecucion para las ordenes procesadas por LDCTA y LDCGTA.
  30-03-2015  Agordillo         REQ.239 Creacion  
  ******************************************************************/
  PROCEDURE ProccessLegORPLO(inuOrden in or_order.order_id%type) AS
    nuLegaliza     NUMBER;
    nuperson       ge_person.person_id%type;
    nuNamePerson   ge_person.name_%type;
    sbErrorMessage varchar2(2000);
    /*Jm SEBTAP || Ca 200-1299 || Solo aplica para GDC*/
    csbEntrega2001299 CONSTANT VARCHAR2(100) := 'OSS_SER_STN_2001299_2';
    sbTask  NUMBER(20) := null;
    sbExist NUMBER(1) := 0;
    sbParam VARCHAR2(1) := 'N';
    /*Fin 200-1299*/
    --Caso 200-1370
    
    nError    ge_message.message_id%type;
    sErrorMes VARCHAR2(4000);

    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'ProccessLegORPLO';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 

  BEGIN

    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

    nuLegaliza   := LDC_fnuVisualizaORPLO(inuOrden);
    nuperson     := pkg_bopersonal.fnugetpersonaid;
    nuNamePerson := ge_bopersonal.fsbgetpersonname(nuperson);

    IF (nuLegaliza = 0) THEN
      pkg_traza.trace('Error validando si permite legalizacion', pkg_traza.cnuNivelTrzDef); 
      sbErrorMessage := 'El usuario ' || nuNamePerson || ' No puede legalizar la Orden';
      pkg_error.SetErrorMessage(isbMsgErrr => sbErrorMessage);
      RAISE pkg_Error.Controlled_Error;
    END IF;  
      
    pkg_traza.trace('Inicia control de documentos', pkg_traza.cnuNivelTrzDef); 
    sbParam := pkg_bcld_parameter.fsbobtienevalorcadena('SOLI_DOCU_X_TIPO_TRABAJO');
    IF (sbParam = 'Y') THEN
    pkg_traza.trace('Parametro configurado en [' ||
                   sbParam || '] se ejecutara el proceso', pkg_traza.cnuNivelTrzDef); 
    BEGIN
      select oo.task_type_id
        into sbTask
        from or_order oo
       where oo.order_id = inuOrden;
       pkg_traza.trace('Se consulta el tipo de trabajo [' ||
                     sbTask || '] en la tabla LDC_TITRDOCU', pkg_traza.cnuNivelTrzDef); 
      select count(1)
        into sbExist
        from ldc_titrdocu lt
       where lt.task_type_id = sbTask;
      if (sbExist = 1) then
        pkg_traza.trace('El tipo de trabajo existe y se insertara en la tabla LDC_DOCUORDER', pkg_traza.cnuNivelTrzDef); 
        insert into LDC_DOCUORDER
          (order_id,
           status_docu,
           LEGALIZATION_DATE,
           RECEPTION_DATE,
           FILE_DATE)
        values
          (inuOrden, 'CO', sysdate, null, null);
          pkg_traza.trace('insertando orden [' || inuOrden || '] y estado CO', pkg_traza.cnuNivelTrzDef);
      else
        pkg_traza.trace('El tipo de trabajo [' || sbTask ||
                       '] no existe en la tabla LDC_TITRDOCU', pkg_traza.cnuNivelTrzDef);
      end if;
    EXCEPTION
      WHEN OTHERS THEN
        pkg_traza.trace('Error durante el proceso.', pkg_traza.cnuNivelTrzDef);
        pkg_error.seterror;
        RAISE pkg_Error.Controlled_Error;
    END;
    ELSE
    pkg_traza.trace('Parametro configurado en [' || sbParam || 
                    '] no se ejecutara el proceso', pkg_traza.cnuNivelTrzDef);
    END IF;
    pkg_traza.trace('Fin control de documentos', pkg_traza.cnuNivelTrzDef);
         
    ldc_val_tiemp_fin_eje_ord(inuOrden);

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION 
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);                        
    RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error; 
          
  END ProccessLegORPLO;

  /*****************************************************************
  Procedimiento   :   FRCGETUNIDOPERTECCERTRE
  Descripcion     :   Funcion para obtener el conjunto de registros para la forma ORTCI

  Autor       : Manuel Mejia
  Fecha       : 17-11-2015

  Historia de Modificaciones
  Fecha       Autor             Modificacion
  =========   ========= ====================
  20-05-2024  PAcosta   OSF-2678: Cambio CONSTANTS.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
                                  Cambio DALD_PARAMETER.FNUGETNUMERIC_VALUE  por  PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO 
                                  Cambio DAOR_OPERATING_UNIT.FSBGETNAME  por  PKG_BCUNIDADOPERATIVA.FSBGETNOMBRE
                                  Cambio GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE por PRC_OBTIENEVALORINSTANCIA
  17-11-2015  Mmejia    ARA.8602 Creacion
  ******************************************************************/
  FUNCTION FRCGETUNIDOPERTECCERTRE RETURN constants_per.tyrefcursor IS
    sbProcessInstance        ge_boinstancecontrol.stysbname;
    nuIndex                  ge_boInstanceControl.stynuIndex;
    rcResult                 constants_per.tyrefcursor;
    sbunidadoper             VARCHAR2(1000);
    nuunidadoper             or_operating_unit.operating_unit_id%TYPE;
    sbunidadoperDes          VARCHAR2(1000);
    nuunidadoperDes          or_operating_unit.operating_unit_id%TYPE;
    nuTecnicoOrigen          ldc_asig_ot_tecn.tecnico_unidad%TYPE;
    nuTecnicoDestino         ldc_asig_ot_tecn.tecnico_unidad%TYPE;
    nuEJEC_ORDER_PARAM_VALUE number;

    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'FRCGETUNIDOPERTECCERTRE';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
    
  BEGIN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

    ge_boinstancecontrol.GetCurrentInstance(sbProcessInstance);
    -- se obtiene el valor de la unidad operativa origen de la instancia si existe
    IF ge_boinstancecontrol.fblAcckeyAttributeStack(sbProcessInstance,
                                                    Null,
                                                    'LDC_ASIG_OT_TECN',
                                                    'UNIDAD_OPERATIVA',
                                                    nuIndex) THEN
      prc_obtienevalorinstancia(sbProcessInstance,
                                null,
                                'LDC_ASIG_OT_TECN',
                                'UNIDAD_OPERATIVA',
                                sbunidadoper);

      -- Se obtiene el valor numerico del id de la orden
      nuunidadoper := to_number(trim(sbunidadoper));

    END IF;

    -- se obtiene el valor del tecnico origen de la instancia si existe
    IF ge_boinstancecontrol.fblAcckeyAttributeStack(sbProcessInstance,
                                                    Null,
                                                    'LDC_ASIG_OT_TECN',
                                                    'TECNICO_UNIDAD',
                                                    nuIndex) THEN
      prc_obtienevalorinstancia(sbProcessInstance,
                                null,
                                'LDC_ASIG_OT_TECN',
                                'TECNICO_UNIDAD',
                                sbunidadoper);

      -- Se obtiene el valor numerico del id de la orden
      nuTecnicoOrigen := to_number(trim(sbunidadoper));

    END IF;

    -- se obtiene el valor de la unidad destino origen de la instancia si existe
    IF ge_boinstancecontrol.fblAcckeyAttributeStack(sbProcessInstance,
                                                    Null,
                                                    'OR_OPERATING_UNIT',
                                                    'FATHER_OPER_UNIT_ID',
                                                    nuIndex) THEN
      prc_obtienevalorinstancia(sbProcessInstance,
                                null,
                                'OR_OPERATING_UNIT',
                                'PERSON_IN_CHARGE',
                                sbunidadoperDes);

      -- Se obtiene el valor numerico del id de la orden
      nuunidadoperDes := to_number(trim(sbunidadoperDes));

    END IF;

    -- se obtiene el valor del tecnico destino origen de la instancia si existe
    IF ge_boinstancecontrol.fblAcckeyAttributeStack(sbProcessInstance,
                                                    Null,
                                                    'OR_OPERATING_UNIT',
                                                    'PERSON_IN_CHARGE',
                                                    nuIndex) THEN
      prc_obtienevalorinstancia(sbProcessInstance,
                                null,
                                'OR_OPERATING_UNIT',
                                'PERSON_IN_CHARGE',
                                sbunidadoperDes);

      -- Se obtiene el valor numerico del id de la orden
      nuTecnicoDestino := to_number(trim(sbunidadoperDes));

    END IF;

    pkg_traza.trace('nuunidadoper ' || nuunidadoper, pkg_traza.cnuNivelTrzDef);

    --se identifica codigo de estado ot ejecutada
    nuEJEC_ORDER_PARAM_VALUE := pkg_bcld_parameter.fnuobtienevalornumerico('COD_ESTADO_OT_EJE');

    OPEN rcResult FOR
      SELECT /*+ CHOOSE */
      distinct o.order_id orden,
               o.task_type_id || ' - ' ||
               daor_task_type.fsbgetdescription(o.task_type_id) tipo_trabajo,
               o.assigned_date fecha_asignacion,
               a.package_id solicitud,
               p.SUBSCRIPTION_ID contrato,
               p.product_id producto,
               se.operating_sector_id || ' - ' || so.description sector_operativo,
               d.address_parsed direccion,
               o.operating_unit_id || ' - ' ||
               pkg_bcunidadoperativa.fsbgetnombre(o.operating_unit_id) unidad_operativa
        FROM or_order            o,
             or_order_activity   a,
             pr_product          p,
             ab_address          d,
             ab_segments         se,
             or_task_type        t,
             or_operating_sector so,
             ldc_asig_ot_tecn    la
       WHERE o.operating_unit_id = nuunidadoper
         AND o.order_status_id = nuEJEC_ORDER_PARAM_VALUE
         AND o.order_id = a.order_id
         AND a.product_id = p.product_id
         AND p.address_id = d.address_id
         AND d.segment_id = se.segments_id
         AND se.operating_sector_id = so.operating_sector_id
         AND o.task_type_id = t.task_type_id
         AND ldc_fnuvisualizaorplo(o.order_id) = 1
         AND o.order_id = la.orden
         AND la.tecnico_unidad = nuTecnicoOrigen
       ORDER BY o.order_id;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    
    RETURN rcResult;

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);                        
    RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error; 
      
  END FRCGETUNIDOPERTECCERTRE;

  /*****************************************************************
  Procedimiento   :   procValidMaterial
  Descripcion     :   Permite validar si el o activo
                      para el Material y verifique las cantidades
                      ingresadas
  Autor       : Daniel Valiente
  Fecha       : 21-08-2018

  Historia de Modificaciones
  Fecha       Autor             Modificacion
  =========   ========= ====================
  ******************************************************************/
  PROCEDURE procValidMaterial(inuOrden        in or_order.order_id%type,
                              onuError        out ge_message.message_id%type,
                              osbErrorMessage out VARCHAR2) AS

    --Cursor de Items de la Orden con las cantidades a validar
    CURSOR cuItems IS
      select o.items_id, o.legal_item_amount
        from OR_ORDER_ITEMS o
       where o.order_id = inuOrden;

    --determina si el item debe ser evaluado
    v_result number(10);

    --cantidad de items a validar
    v_cantR number(10, 5);
    v_cantT number(10, 5);

    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'procValidMaterial';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
    
  BEGIN

    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

    --Error
    onuError        := 0;
    osbErrorMessage := '';

    --Recorrido del cursor de Items de la Orden a Legalizar
    FOR itemsId in cuItems LOOP

      --Verifico que el item no permita decimales
      SELECT count(*)
        INTO v_result
        FROM LDC_UNIDADDEC m, ge_items i
       WHERE i.items_id = itemsId.Items_Id
         and i.measure_unit_id = m.measure_unit_id
         and m.flag_dec = 'N';

      if (v_result > 0) then
        v_cantR := itemsId.legal_item_amount;
        v_cantT := trunc(itemsId.legal_item_amount);
        --valido que no tenga decimales, si la resta de las dos cifras me devuelve un valor mayor que 0
        --es por que la cantidad de Items posee decimales
        if (v_cantR - v_cantT > 0) then
          onuError        := -1;
          osbErrorMessage := osbErrorMessage || 'El item [' ||
                             itemsId.Items_Id || ' - ' ||
                             DAGE_ITEMS.FSBGETDESCRIPTION(itemsId.Items_Id,
                                                          null) ||
                             '] de tipo de Unidad [' ||
                             DAGE_ITEMS.FNUGETMEASURE_UNIT_ID(itemsId.Items_Id,
                                                              null) ||
                             ' - ' ||
                             DAGE_MEASURE_UNIT.FSBGETDESCRIPTION(DAGE_ITEMS.FNUGETMEASURE_UNIT_ID(itemsId.Items_Id,
                                                                                                  null),
                                                                 null) ||
                             '] no permite cantidades decimales, por favor valide en LDCUNIDDEC. ';
        end if;
      end if;

    END LOOP;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(onuError, osbErrorMessage);
      pkg_traza.trace('Error: ' || osbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);                        
    RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuError, osbErrorMessage);
      pkg_traza.trace('Error: ' || osbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error; 
      
  END procValidMaterial;

  /*****************************************************************
  Procedimiento   :   procValidCausalNoLegal
  Descripcion     :   Permite validar si el parametro
                      VALID_CAUSAL_NO_LEGAL esta activo para la Causal
                      segun el Tipo de Trabajo y Actividad y de estar
                      registrado impida el proceso de legalizacion
                      por parte del Contratista
  Autor       : Daniel Valiente
  Fecha       : 21-08-2018

  Historia de Modificaciones
  Fecha       Autor             Modificacion
  =========   ========= ====================
  20-05-2024  PAcosta   OSF-2678: Cambio DALD_PARAMETER.FSBGETVALUE_CHAIN por PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA
                                  Cambio GE_BOPERSONAL.FNUGETPERSONID por PKG_BOPERSONAL.FNUGETPERSONAID  
                                  Cambio LDC_BOUTILITIES.SPLITSTRINGS por REGEXP_SUBSTR
 *****************************************************************/
  
  PROCEDURE procValidCausalNoLegal(inuOrden        in or_order.order_id%type,
                                   onuError        out ge_message.message_id%type,
                                   osbErrorMessage out VARCHAR2) AS

    --Cursor de Datos a validar para la legalizacion
    --mod 27/08/18
    CURSOR cuDatos IS
      SELECT o.order_id,
             o.task_type_id,
             i.items_id,
             o.causal_id,
             o.operating_unit_id
        FROM or_order o, or_order_items i, GE_ITEMS G
       WHERE o.order_id = inuOrden
         and o.order_id = i.order_id
         AND G.ITEMS_ID = I.ITEMS_ID
         AND G.ITEM_CLASSIF_ID IN
             (
                SELECT nvl(to_number(regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena('DEFINICION_ACTIVIDADES'),
                                                    '[^,]+', 
                                                    1, 
                                                    LEVEL)
                                                    )
                                     , 0) AS vlrColumna
                FROM dual
                CONNECT BY regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena('DEFINICION_ACTIVIDADES'), 
                                          '[^,]+', 
                                          1,
                                          LEVEL
                                          ) IS NOT NULL  
             );

    --determina si la orden se halla en Causales No Legalizables
    v_result  number(10);
    v_result1 number(10);
    --Identificacion
    v_identificacion number(10);
    --Area Organizacional
    v_areaorg number(10);

    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'procValidCausalNoLegal';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error

  BEGIN

    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

    onuError        := 0;
    osbErrorMessage := '';

    --Se obtiene el id de la persona conectada
    select pkg_bopersonal.fnugetpersonaid into v_identificacion from dual;
    pkg_traza.trace('Identificacion: ' || v_identificacion, pkg_traza.cnuNivelTrzDef); 

    --Se obtiene AREA ORGANIZACIONAL DE UNA PERSONA
    --Se modifica para que se consulte area organizacion configurada en ge_person
    v_areaorg := DAGE_PERSON.FNUGETORGANIZAT_AREA_ID(v_identificacion, NULL);

    pkg_traza.trace('v_areaorg: '|| v_areaorg, pkg_traza.cnuNivelTrzDef); 

    --
    SELECT count(*)
      INTO v_result1
      FROM dual
     where v_areaorg in (
        SELECT nvl(to_number(regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena('COD_AREA_ORGANIZACIONAL_EX'),
                        '[^,]+', 
                        1, 
                        LEVEL)
                        )
            ,0) AS vlrColumna
        FROM dual
        CONNECT BY regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena('COD_AREA_ORGANIZACIONAL_EX'), 
                                  '[^,]+', 
                                  1,
                                  LEVEL
                                  ) IS NOT NULL  );
    --valido que el area organizacional obtenida sea igual
    --con el parametro COD_AREA_ORGANIZACIONAL_EX para verificar que es contratista
    pkg_traza.trace('v_result1: ' || v_result1, pkg_traza.cnuNivelTrzDef); 

    if (v_result1 > 0) then
      --Recorrido del cursor de Datos de la Orden a Legalizar
      FOR datosOL in cuDatos LOOP

        --Verifico si la actividad no puede ser legalizada por el contratista
        SELECT count(*)
          INTO v_result
          FROM ldc_causalesnolegal m
         WHERE m.task_type_id = datosOL.Task_Type_Id
           and m.items_id = datosol.items_id
           and m.causal_id = datosol.causal_id;

        if (v_result > 0) then
          onuError        := -1;
          osbErrorMessage := 'El Contratista no puede Legalizar la Actividad[' ||
                             datosol.items_id || ' - ' ||
                             DAGE_ITEMS.FSBGETDESCRIPTION(datosol.items_id,
                                                          NULL) ||
                             ']  con el Tipo de Trabajo[' ||
                             datosOL.Task_Type_Id || ' - ' ||
                             DAOR_TASK_TYPE.FSBGETDESCRIPTION(datosOL.Task_Type_Id,
                                                              NULL) ||
                             '] y  Causal[' || datosol.causal_id || ' - ' ||
                             DAGE_CAUSAL.FSBGETDESCRIPTION(datosol.causal_id,
                                                           NULL) ||
                             ']. Por favor validar forma LDCCAUNOLEG.';
        end if;

      END LOOP;
    end if;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(onuError, osbErrorMessage);
      pkg_traza.trace('Error: ' || osbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);                        
    RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuError, osbErrorMessage);
      pkg_traza.trace('Error: ' || osbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error; 
      
  END procValidCausalNoLegal;

  /*****************************************************************
  Procedimiento   :   BLOQUEOLEGALIZACIONRP
  Descripcion     :   CA 858 PLUGIN para  verificar que si la orden esta registrada en LDC_ORDEASIGPROC y fue registrada desde ENCOCARTRP se verificara si el Comentario de Legalizacion de la Orden tiene en el texto de comentario la palabra ENCOCARTRP y el Tipo de Comentario es "1277 - INFORMACION GENERAL"

  Autor       : Daniel Valiente
  Fecha       : 21-08-2018

  Historia de Modificaciones
  Fecha       Autor             Modificacion
  =========   ========= ====================
  20/05/2024  PAcosta   OSF-2678: Cambio OR_BOLEGALIZEORDER.FNUGETCURRENTORDER por PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL
  ******************************************************************/
  
  PROCEDURE BLOQUEOLEGALIZACIONRP IS
    nuOrder_id     OR_ORDER.ORDER_ID%TYPE;
    nuTotalOrdenes number;
    nuOrderFind    number;

    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'BLOQUEOLEGALIZACIONRP';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
    
  BEGIN

    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);    
        
    nuOrder_id := pkg_bcordenes.fnuobtenerotinstancialegal;
    SELECT COUNT(1)
      INTO nuTotalOrdenes
      FROM LDC_ORDEASIGPROC
     WHERE LDC_ORDEASIGPROC.ORAPSOGE = nuOrder_id
       AND LDC_ORDEASIGPROC.ORAOPROC = 'ENCOCARTRP';
    if nuTotalOrdenes > 0 then
      select count(1)
        into nuOrderFind
        from or_order_comment o
       where upper(o.order_comment) like '%ENCOCARTRP%'
         and o.comment_type_id = 1277
         and o.order_id = nuOrder_id;
      if nuOrderFind = 0 then
        pkg_error.SetErrorMessage(isbMsgErrr => 'La Orden solo se puede legalizar por LDC_PKORDENES.JOBLEGORDECARTRP');
      end if;
    end if;
    
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);                        
    RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error; 
    
  END BLOQUEOLEGALIZACIONRP;

END Or_Boservices;
/
