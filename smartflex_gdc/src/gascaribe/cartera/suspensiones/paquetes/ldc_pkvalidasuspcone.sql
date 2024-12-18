CREATE OR REPLACE Package ldc_pkValidaSuspcone Is

 /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: ldc_pkValidaSuspcone
  Descripcion:        Analisis de errores en Suspcone

  Autor    : HB
  Fecha    : 29-04-2020  CA 361

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  28/10/2020    HB                    CA-493  Se ingresa analisis tipo 5 y Analisis para productos especificos
                                      cargados por la forma LDCAISPPRES
  11/11/2022    lvalencia             OSF-658: Se agrega el parametro LDC_SERVICE_ALLOW
                                      en el procedimiento LeeArchivo
  11-03-2024    ADRIANAVG             OSF-2388: aplican pautas técnicas y se reemplazan servicios homólogos
                                      Se añade como parametro de entrada el Nombre del proceso a la función fnuanalisissuspcone_1, fnuanalisissuspcone_2
                                      fnuanalisissuspcone_3, fnuanalisissuspcone_4, fnuanalisissuspcone_5 y fnuanalisissuspcone_pres
  ******************************************************************/

PROCEDURE pranalisis (
    nutipo NUMBER
);

PROCEDURE processldcaisp;

FUNCTION fnuanalisissuspcone_1 (
    sbnameproceso IN VARCHAR2,
    osbmsgerror OUT VARCHAR2
) RETURN NUMBER;

FUNCTION fnuanalisissuspcone_2 (
    sbnameproceso IN VARCHAR2,
    osbmsgerror   OUT VARCHAR2
) RETURN NUMBER;

FUNCTION fnuanalisissuspcone_3 (
    sbnameproceso IN VARCHAR2,
    osbmsgerror   OUT VARCHAR2
) RETURN NUMBER;

FUNCTION fnuanalisissuspcone_4 (
    sbnameproceso IN VARCHAR2,
    osbmsgerror   OUT VARCHAR2
) RETURN NUMBER;

FUNCTION fnuanalisissuspcone_5 (
    sbnameproceso IN VARCHAR2,
    osbmsgerror OUT VARCHAR2
) RETURN NUMBER;

FUNCTION fnuanalisissuspcone_pres (
    sbnameproceso IN VARCHAR2,
    osbmsgerror OUT VARCHAR2
) RETURN NUMBER;

FUNCTION armadatosorden (
    inuorden      IN or_order.order_id%TYPE,
    inuttorden    IN or_order.task_type_id%TYPE,
    inuestorden   IN or_order.order_status_id%TYPE,
    idtfecreorden IN DATE,
    idtfelegorden IN DATE
) RETURN VARCHAR2;

FUNCTION hallatipoultactsusp (
    sbultactsusp IN VARCHAR2
) RETURN VARCHAR2;

FUNCTION inconsis_rp RETURN VARCHAR2;

FUNCTION inconsis_ca RETURN VARCHAR2;

PROCEDURE insertareg;

FUNCTION fbogetisnumber (
    isbvalor VARCHAR2
) RETURN BOOLEAN; -- CASO 493

PROCEDURE ldcaisppres; -- CASO 493

PROCEDURE leearchivo; -- CASO 493

End ldc_pkValidaSuspcone;

/


CREATE OR REPLACE Package Body ldc_pkValidaSuspcone Is
  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: ldc_pkValidaSuspcone
  Descripcion:        Analisis de errores en Suspcone

  Autor    : HB
  Fecha    : 29-04-2020  CA 361

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  28/10/2020    HB                      CA-493  Se ingresa analisis tipo 5 y Analisis para productos especificos
                                        cargados por la forma LDCAISPPRES
                                        Se retiran variables declaradas sin uso sbsesion, nuparano, nuparmes, sbscript
  11-03-2024    ADRIANAVG               OSF-2388: Se declaran variables para la gestión de trazas
                                        En el llamado del pkg_Error.setErrorMessage se retira el parametro Onuerrorcode y Nuerror para que tome por defecto el valor CNUGENERIC_MESSAGE
  ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbNOMPKG               CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';
    csbNivelTraza           CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
	csbInicio   	        CONSTANT VARCHAR2(35) 	    := pkg_traza.csbINICIO;

    -- Datos de paquete

    dtfechaproceso  DATE;
    sbpath          VARCHAR2(500);
    sbfile          VARCHAR2(500);
    sbtipoarch      VARCHAR2(2000); 
    sbproducto      VARCHAR2(2000);

    nutipoanalisis  NUMBER;
    dtfecha         DATE := SYSDATE; 
    nutsess         NUMBER;
    sbparuser       VARCHAR2(4000);

    nuproducto      pr_product.product_id%TYPE;
    nuprodstat      pr_product.product_status_id%TYPE;
    nusesuesco      servsusc.sesuesco%TYPE;
    sbestprod       VARCHAR2(200);
    sbestcorte      VARCHAR2(200);
    ult_act_susp    VARCHAR2(200);
    est_componente_1 VARCHAR2(200);
    est_componente_2 VARCHAR2(200);
    orden_1         VARCHAR2(200);
    orden_2         VARCHAR2(200);
    orden_3         VARCHAR2(200);
    orden_4         VARCHAR2(200); 

    nucont          NUMBER := 0;
    nuerror         NUMBER := 0;
    nucantps        NUMBER;
    nucantcs        NUMBER;
    nucantec        NUMBER;
    nucantord       NUMBER;
    nucantsus       NUMBER;
    nucantsolrec    NUMBER;

    nupsid1         pr_prod_suspension.prod_suspension_id%TYPE;
    nupsst1         pr_prod_suspension.suspension_type_id%TYPE;
    dtpsad1         pr_prod_suspension.aplication_date%TYPE;
    dtpsid1         pr_prod_suspension.inactive_date%TYPE;

    nupsid2         pr_prod_suspension.prod_suspension_id%TYPE;
    nupsst2         pr_prod_suspension.suspension_type_id%TYPE;
    dtpsad2         pr_prod_suspension.aplication_date%TYPE;
    dtpsid2         pr_prod_suspension.inactive_date%TYPE;

    nucsid1         pr_comp_suspension.comp_suspension_id%TYPE;
    nucsco1         pr_comp_suspension.component_id%TYPE;
    nucsst1         pr_comp_suspension.suspension_type_id%TYPE;
    dtcsad1         pr_comp_suspension.aplication_date%TYPE;
    dtcsid1         pr_comp_suspension.inactive_date%TYPE;

    nucsid2         pr_comp_suspension.comp_suspension_id%TYPE;
    nucsco2         pr_comp_suspension.component_id%TYPE;
    nucsst2         pr_comp_suspension.suspension_type_id%TYPE;
    dtcsad2         pr_comp_suspension.aplication_date%TYPE;
    dtcsid2         pr_comp_suspension.inactive_date%TYPE;

    nucsid3         pr_comp_suspension.comp_suspension_id%TYPE;
    nucsco3         pr_comp_suspension.component_id%TYPE;
    nucsst3         pr_comp_suspension.suspension_type_id%TYPE;
    dtcsad3         pr_comp_suspension.aplication_date%TYPE;
    dtcsid3         pr_comp_suspension.inactive_date%TYPE;

    nucsid4         pr_comp_suspension.comp_suspension_id%TYPE;
    nucsco4         pr_comp_suspension.component_id%TYPE;
    nucsst4         pr_comp_suspension.suspension_type_id%TYPE;
    dtcsad4         pr_comp_suspension.aplication_date%TYPE;
    dtcsid4         pr_comp_suspension.inactive_date%TYPE;    

    nuecid1         pr_component.component_id%TYPE;
    nueces1         pr_component.component_status_id%TYPE;

    nuecid2         pr_component.component_id%TYPE;
    nueces2         pr_component.component_status_id%TYPE;    

    nuorultactsusp   or_order.order_id%TYPE;
    nuacultactsusp   or_order_activity.order_activity_id%TYPE;
    nuttultactsusp   or_order.task_type_id%TYPE;
    nuultactsusprp   or_order_activity.order_activity_id%TYPE;
    nuultactsuspca   or_order_activity.order_activity_id%TYPE;    

    nuororden1   or_order.order_id%TYPE;
    nuttorden1   or_order.task_type_id%TYPE;
    nuosorden1   or_order.order_status_id%TYPE;
    dtfcorden1   DATE;
    dtflorden1   DATE;

    nuororden2   or_order.order_id%TYPE;
    nuttorden2   or_order.task_type_id%TYPE;
    nuosorden2   or_order.order_status_id%TYPE;
    dtfcorden2   DATE;
    dtflorden2   DATE;

    nuororden3   or_order.order_id%TYPE;
    nuttorden3   or_order.task_type_id%TYPE;
    nuosorden3   or_order.order_status_id%TYPE;
    dtfcorden3   DATE;
    dtflorden3   DATE;

    nuororden4   or_order.order_id%TYPE;
    nuttorden4   or_order.task_type_id%TYPE;
    nuosorden4   or_order.order_status_id%TYPE;
    dtfcorden4   DATE;
    dtflorden4   DATE;

    nuorsusp1  suspcone.suconuor%TYPE;
    nutpsusp1  suspcone.sucotipo%TYPE;
    nufosusp1  suspcone.sucofeor%TYPE;
    nufasusp1  suspcone.sucofeat%TYPE;

    nuorsusp2  suspcone.suconuor%TYPE;
    nutpsusp2  suspcone.sucotipo%TYPE;
    nufosusp2  suspcone.sucofeor%TYPE;
    nufasusp2  suspcone.sucofeat%TYPE;

    nusorec mo_packages.package_id%TYPE;
    nuorrec or_order.order_id%TYPE;
    nuttrec or_order.task_type_id%TYPE;
    nueorec or_order.order_status_id%TYPE;

    sbsuspcone1 VARCHAR2(30);
    sbsuspcone2 VARCHAR2(30);

----------------------------------------------------------------------------------
procedure processldcaisp IS
  /******************************************************************
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas 
                                          Se declaran variables para la gestión de error 
                                          Se retira código comentariado
                                          Se reemplaza ERROR.seterror por pkg_Error.setErrorMessage()
                                          Se reemplaza ex.controlled_error por pkg_Error.controlled_error;
                                          Se ajusta bloque de exception según pautas técnicas
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'processldcaisp';
    Onuerrorcode        NUMBER                    := pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage     VARCHAR2(2000);

    cnunull_attribute CONSTANT NUMBER := 2126;

    sbobject_type_id    ge_boinstancecontrol.stysbvalue;
    sbtpanali           ge_boinstancecontrol.stysbvalue; 

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage); 

    sbtpanali := ge_boinstancecontrol.fsbgetfieldvalue('LDC_TP_ANALISIS_SUSPCONE', 'TPANSUSP_ID');
    pkg_traza.trace(csbMetodo ||' sbtpanali: ' || sbtpanali, csbNivelTraza);

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------ 

    IF (sbtpanali IS NULL) THEN
        pkg_Error.setErrorMessage(isbMsgErrr => 'Tipo Analisis');
        RAISE pkg_Error.controlled_error;
    END IF;

    ------------------------------------------------
    -- User code
    ------------------------------------------------
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

EXCEPTION
    WHEN pkg_Error.controlled_error THEN
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
         RAISE; 
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RAISE pkg_Error.controlled_error;
END processldcaisp;

-------------------------------------------------------------------------
PROCEDURE PRANALISIS (nutipo NUMBER) IS
  /******************************************************************
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas  
                                          Se declara variable para el nombre del proceso ESTAPROC
                                          Se reemplaza SELECT-INTO y ldc_proinsertaestaprog por BEGIN-END para pkg_estaproc.prinsertaestaproc 
                                          Se reemplaza ERROR.seterror por pkg_Error.setErrorMessage() y se retira el RAISE ya que el pkg_erorr.seterrormessage lo hace en su lógica interna
                                          Se ajusta bloque de exception según pautas técnicas
                                          Se reemplaza ldc_proactualizaestaprog por pkg_estaproc.practualizaestaproc
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'pranalisis';
    Onuerrorcode        NUMBER                    := pkg_error.CNUGENERIC_MESSAGE;
    sbproceso           VARCHAR2(100 BYTE)        := csbMetodo||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
    sbNameProceso       sbproceso%TYPE;

    sbinco              VARCHAR2(2);
    nureturn            NUMBER(1) := 0;
    osberror            VARCHAR2(4000); 

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberror);
    pkg_traza.trace(csbMetodo ||' nutipo: ' || nutipo, csbNivelTraza);

    -- se obtienen datos para registrar en ESTAPROC
    BEGIN
        sbNameProceso:= sbproceso; --invocarlo una sola vez
        pkg_traza.trace(csbMetodo||' sbNameProceso: '||sbNameProceso , csbNivelTraza);
        -- Ingresa en ESTAPROC
        PKG_ESTAPROC.PRINSERTAESTAPROC(sbNameProceso, NULL);	
        PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbNameProceso, 'Ok', osberror);
	END;

    -- evalua tipo de analisis
    IF nutipo = 1 THEN
        nureturn := fnuanalisissuspcone_1(sbNameProceso, osberror);
        IF nureturn = -1 THEN
            pkg_traza.trace(csbMetodo ||' osberror: ' || osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
            pkg_Error.setErrorMessage(isbMsgErrr => osberror); 
        END IF;

    ELSIF nutipo = 2 THEN
        nureturn := fnuanalisissuspcone_2(sbNameProceso, osberror);
        IF nureturn = -1 THEN
            pkg_traza.trace(csbMetodo ||' osberror: ' || osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
            pkg_Error.setErrorMessage(isbMsgErrr => osberror); 
        END IF;

    ELSIF nutipo = 3 THEN
        nureturn := fnuanalisissuspcone_3(sbNameProceso, osberror);
        IF nureturn = -1 THEN
            pkg_traza.trace(csbMetodo ||' osberror: ' || osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
            pkg_Error.setErrorMessage(isbMsgErrr => osberror);
        END IF;

    ELSIF nutipo = 4 THEN
        nureturn := fnuanalisissuspcone_4(sbNameProceso,osberror);
        IF nureturn = -1 THEN
            pkg_traza.trace(csbMetodo ||' osberror: ' || osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
            pkg_Error.setErrorMessage(isbMsgErrr => osberror);
        END IF;

    ELSIF nutipo = 5 THEN
        nureturn := fnuanalisissuspcone_5(sbNameProceso, osberror);
        IF nureturn = -1 THEN
            pkg_traza.trace(csbMetodo ||' osberror: ' || osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
            pkg_Error.setErrorMessage(isbMsgErrr => osberror);
        END IF;

    ELSIF nutipo = 99 THEN
        nureturn := fnuanalisissuspcone_pres(sbNameProceso, osberror);
        IF nureturn = -1 THEN
            pkg_traza.trace(csbMetodo ||' osberror: ' || osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
            pkg_Error.setErrorMessage(isbMsgErrr => osberror);
        END IF;

    ELSE
        osberror := 'Tipo de Analisis no contemplado en el Desarrollo';
        pkg_traza.trace(csbMetodo ||' osberror: ' || osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        pkg_Error.setErrorMessage(isbMsgErrr => osberror);
    END IF;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

EXCEPTION
    WHEN pkg_Error.controlled_error THEN
         pkg_Error.getError(onuerrorcode, osberror);
         pkg_traza.trace(csbMetodo ||' osberror: ' || osberror, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
         pkg_estaproc.practualizaestaproc(sbNameProceso, 'Error', osberror);   
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberror);
         pkg_traza.trace(csbMetodo ||' osberror: ' || osberror, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         pkg_estaproc.practualizaestaproc(sbNameProceso, 'Error', osberror);
END pranalisis;

------------------------------------------------------------------------------------------------------------------------
FUNCTION  FNUANALISISSUSPCONE_1 (sbNameProceso IN VARCHAR2, osbmsgerror OUT VARCHAR2) RETURN NUMBER IS

  /******************************************************************
    Busca los productos con est corte 1 y de producto 2 con
    ult act susp es nula o de cartera pero las susp activas son de rev periodica
    ult act susp es de cartera y las susp activas no son de cartera lo muestra
    ult asct de susp es nula

    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas
                                          Se reemplaza dald_parameter.fsbgetvalue_chain por pkg_bcld_parameter.fsbobtienevalorcadena
                                          Se retira código comentariado
                                          Se retira esquema OPEN antepuesto a pr_product, servsusc, pr_prod_suspension, pr_component, or_order_activity
                                          , or_order_status, or_order, or_task_type, ge_causal, ge_class_causal, mo_packages, suspcone, ps_package_type
                                          Se reemplaza ldc_boutilities.splitstrings por regexp_substr
                                          Se reemplaza SELECT-INTO por cursor cuEstProd, cuEstCorte, cuEstComponente, cuUltActSusp2
                                          Se reemplaza ldc_proactualizaestaprog por pkg_estaproc.practualizaestaproc
                                          Se añade como parametro de entrada el Nombre del proceso
                                          Se ajusta bloque de exception según pautas técnicas
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'pranalisis';
    csbNivelTrazaApi    CONSTANT NUMBER(2)        := pkg_traza.cnuNivelTrzApi;

    nuerror             NUMBER := 0;
    nutipo              NUMBER := 1;
    sbtipoulacsusp      VARCHAR2(200);
    sbttsuspca          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_CART_AJSUSPCONE');
    sbttsusprp          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_RP_AJSUSPCONE');
    sbttsuspad          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_ADM_AJSUSPCONE');
    sbttsuspvo          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_VOL_AJSUSPCONE');
    sbttreco            VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_RECO_AJSUSPCONE');
    sbttsusp            VARCHAR2(2000);
    sbttsuspreco        VARCHAR2(2000);

    CURSOR cuproductos IS
    SELECT sr.sesususc, sr.sesunuse, sr.sesuserv, sr.sesucicl, p.suspen_ord_act_id, sr.sesuesco, p.product_status_id
      FROM pr_product p, servsusc sr
     WHERE p.product_id= sr.sesunuse
       AND p.product_status_id = 2 
       AND sr.sesuesco = 1;

    CURSOR cususpactiprod (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.prod_suspension_id, P.product_id, P.suspension_type_id, P.register_date, P.aplication_date, P.inactive_date, P.active
      FROM pr_prod_suspension P
     WHERE P.product_id = nunuse
       AND P.active = 'Y'
  ORDER BY P.register_date;

    CURSOR cususpacticomp (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.*
      FROM pr_comp_suspension P
     WHERE P.component_id IN (SELECT cp.component_id
                                FROM pr_component cp
                               WHERE cp.product_id = nunuse)
       AND P.active = 'Y'
  ORDER BY P.register_date, P.component_id;

    CURSOR cuestcomp (nunuse servsusc.sesunuse%TYPE) IS
    SELECT cp.product_id, cp.component_id, cp.component_type_id, cp.component_status_id
      FROM pr_component cp
     WHERE cp.product_id = nunuse
       AND cp.component_status_id != 9
  ORDER BY cp.component_id;

    CURSOR cuultactsusp (nuordact or_order_activity.order_activity_id%TYPE) IS
    SELECT O.order_id, A.order_activity_id,  O.task_type_id, tt.DESCRIPTION desctt, O.created_date, O.legalization_date, O.order_status_id,
           (SELECT os.DESCRIPTION 
              FROM or_order_status os 
             WHERE os.order_status_id=O.order_status_id) descestaor,
           O.causal_id || ' - '  || gc.DESCRIPTION causal, CC.class_causal_id, CC.DESCRIPTION tipo_causal
      FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                      LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                      LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                      LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.order_activity_id = nuordact;

    CURSOR cuultactsusprp(nunuse servsusc.sesunuse%TYPE) IS
    SELECT A.order_activity_id
      FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                      LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                      LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                      LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.product_id = nunuse 
      AND O.order_status_id = 8
      AND CC.class_causal_id = 1
      AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsusprp, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsusprp, '[^|]+', 1, LEVEL) IS NOT NULL)
 ORDER BY O.legalization_date DESC;

    CURSOR cuultactsuspca(nunuse servsusc.sesunuse%TYPE) IS
    SELECT A.order_activity_id
      FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                      LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                      LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                      LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.product_id = nunuse 
      AND O.order_status_id = 8
      AND CC.class_causal_id = 1
      AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsuspca, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsuspca, '[^|]+', 1, LEVEL) IS NOT NULL)
 ORDER BY O.legalization_date DESC;

    CURSOR cuultordenes (nunuse servsusc.sesunuse%TYPE) IS
    SELECT O.order_id, A.package_id, P.motive_status_id, A.order_activity_id,  O.task_type_id, tt.DESCRIPTION desctt, O.created_date, O.legalization_date, O.order_status_id,
       (SELECT os.DESCRIPTION 
          FROM or_order_status os 
         WHERE os.order_status_id=O.order_status_id) descestaor,  
         O.causal_id || ' - '  || gc.DESCRIPTION causal, CC.class_causal_id, CC.DESCRIPTION tipo_causal            
      FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                      LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                      LEFT OUTER JOIN mo_packages P ON (A.package_id = P.package_id)
                      LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                      LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
     WHERE A.product_id = nunuse 
       AND O.order_status_id = 8
       AND CC.class_causal_id = 1
       AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsuspreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsuspreco, '[^|]+', 1, LEVEL) IS NOT NULL )
    ORDER BY created_date DESC;

    CURSOR cuultsuspcone (nunuse servsusc.sesunuse%TYPE) IS
    SELECT S.suconuor, S.sucotipo, S.sucofeor, S.sucofeat
      FROM suspcone S
     WHERE S.suconuse = nunuse
       AND S.sucotipo != 'A'
  ORDER BY S.sucofeor DESC;

    CURSOR cusolirecdet (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.package_id, O.order_id, O.task_type_id,O.order_status_id
      FROM mo_packages P LEFT OUTER JOIN ps_package_type pt ON (pt.package_type_id=P.package_type_id)
                         LEFT OUTER JOIN or_order_activity A ON (A.package_id=P.package_id)
                         LEFT OUTER JOIN or_order O ON (O.order_id = A.order_id)
                         LEFT OUTER JOIN mo_motive M ON (M.package_id=P.package_id)
    WHERE M.product_id=nunuse
      AND P.motive_status_id = 13
      AND O.order_status_id = 8 --  > 5
      AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttreco, '[^|]+', 1, LEVEL) IS NOT NULL)
    UNION
    SELECT P.package_id, O.order_id, O.task_type_id,  O.order_status_id
      FROM mo_packages P LEFT OUTER JOIN ps_package_type pt ON (pt.package_type_id=P.package_type_id)
                         LEFT OUTER JOIN or_order_activity A ON (A.package_id=P.package_id)
                         LEFT OUTER JOIN or_order O ON (O.order_id = A.order_id)
                         LEFT OUTER JOIN mo_motive M ON (M.package_id=P.package_id)
    WHERE M.product_id=nunuse
      AND P.motive_status_id = 13
      AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttreco, '[^|]+', 1, LEVEL) IS NOT NULL )
      AND O.order_id IS NULL;

    CURSOR cuEstProd(p_product_status_id pr_product.product_status_id%TYPE)
    IS 
    SELECT ps.product_status_id || ' - ' || ps.description
      FROM ps_product_status ps
     WHERE ps.product_status_id = p_product_status_id;

    CURSOR cuEstCorte(p_sesuesco servsusc.sesuesco%TYPE)
    IS 
    SELECT escocodi || ' - ' || escodesc 
      FROM estacort e 
     WHERE escocodi = p_sesuesco;      

    CURSOR cuEstComponente( p_product_status_id pr_product.product_status_id%TYPE )
    IS          
    SELECT ps.product_status_id || ' - ' || ps.DESCRIPTION  
      FROM ps_product_status ps 
     WHERE ps.product_status_id = p_product_status_id; 

    CURSOR cuUltActSusp2( p_task_type_id or_task_type.task_type_id%TYPE )
    IS
    SELECT  tt.task_type_id || ' - ' || tt.DESCRIPTION 
      FROM or_task_type tt 
     WHERE tt.task_type_id = p_task_type_id;    

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTrazaApi, csbInicio);
    pkg_error.prInicializaError(nuerror, osbmsgerror);
    pkg_traza.trace(csbMetodo ||' nutipo: ' || nutipo, csbNivelTrazaApi);

    nutipoanalisis := nutipo;
    pkg_traza.trace(csbMetodo ||' nutipoanalisis: ' || nutipoanalisis, csbNivelTrazaApi);

    sbttsusp     := sbttsuspca || '|' || sbttsusprp || '|' || sbttsuspad || '|' || sbttsuspvo;
    pkg_traza.trace(csbMetodo ||' sbttsusp: ' || sbttsusp, csbNivelTrazaApi);

    sbttsuspreco := sbttsusp || '|' || sbttreco;
    pkg_traza.trace(csbMetodo ||' sbttsuspreco: ' || sbttsuspreco, csbNivelTrazaApi);

    FOR rg IN cuproductos LOOP
        nucont := nucont + 1;
        -- limpia variables

        sbestprod      := NULL; sbestcorte      := NULL; ult_act_susp := NULL; est_componente_1 := NULL; est_componente_2 := NULL; orden_1        := NULL; orden_2        := NULL;
        orden_3        := NULL; orden_4         := NULL; nucantps     := 0;    nucantcs         := 0;    nucantec         := 0;    nucantord      :=0;     nucantsus      :=0;     nucantsolrec :=0;     nupsid1   := NULL; nupsst1 := NULL; dtpsad1 := NULL;
        dtpsid1        := NULL; nupsid2         := NULL; nupsst2      := NULL; dtpsad2          := NULL; dtpsid2          := NULL; nucsid1        := NULL; nucsco1        := NULL; nucsst1      := NULL; dtcsad1   := NULL;
        dtcsid1        := NULL; nucsid2         := NULL; nucsco2      := NULL; nucsst2          := NULL; dtcsad2          := NULL; dtcsid2        := NULL; nucsid3        := NULL; nucsco3      := NULL; nucsst3   := NULL;
        dtcsad3        := NULL; dtcsid3         := NULL; nucsid4      := NULL; nucsco4          := NULL; nucsst4          := NULL; dtcsad4        := NULL; dtcsid4        := NULL;
        nuecid1        := NULL; nueces1         := NULL; nuecid2      := NULL; nueces2          := NULL; nuorultactsusp   := NULL; nuttultactsusp := NULL; nuultactsusprp := NULL; nuororden1   := NULL;
        nuttorden1     := NULL; nuosorden1      := NULL; nuororden2   := NULL; nuttorden2       := NULL; nuosorden2       := NULL; nuororden3     := NULL; nuttorden3     := NULL; nuosorden3   := NULL;
        nuororden4     := NULL; nuttorden4      := NULL; nuosorden4   := NULL; nuorsusp1        := NULL; nutpsusp1        := NULL; nufosusp1      := NULL; nufasusp1      := NULL; nuorsusp2    := NULL;
        dtfcorden1     := NULL; dtflorden1      := NULL; dtfcorden2   := NULL; dtflorden2       := NULL; dtfcorden3       := NULL; dtflorden3     := NULL; dtfcorden4     := NULL; dtflorden4   := NULL;
        nutpsusp2      := NULL; nufosusp2       := NULL; nufasusp2    := NULL; nusorec          := NULL; nuorrec          := NULL; nuttrec        := NULL; nueorec        := NULL; sbsuspcone1  := NULL; sbsuspcone2  := NULL;
        nuacultactsusp := NULL; nuultactsuspca  := NULL;
        nuproducto     := rg.sesunuse;
        nuprodstat     := rg.product_status_id;
        nusesuesco     := rg.sesuesco;

        pkg_traza.trace(csbMetodo ||' nuproducto: ' || nuproducto, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' nuprodstat: ' || nuprodstat, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' nusesuesco: ' || nusesuesco, csbNivelTrazaApi);

        -- busca datos
        nucantps := 0;
        FOR rg2 IN cususpactiprod(rg.sesunuse) LOOP
            nucantps := nucantps + 1;
            IF nucantps = 1 THEN
                nupsid1 := rg2.prod_suspension_id;
                nupsst1 := rg2.suspension_type_id;
                dtpsad1 := rg2.aplication_date;
                dtpsid1 := rg2.inactive_date;
            ELSIF nucantps = 2 THEN
                nupsid2 := rg2.prod_suspension_id;
                nupsst2 := rg2.suspension_type_id;
                dtpsad2 := rg2.aplication_date;
                dtpsid2 := rg2.inactive_date;
            END IF;
        END LOOP;
        pkg_traza.trace(csbMetodo ||' cursor cususpactiprod INICIO', csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' prod_suspension_id_1: ' || nupsid1||', suspension_type_id_1: ' || nupsst1, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' aplication_date_1: ' || dtpsad1||', inactive_date_1: ' || dtpsid1, csbNivelTrazaApi);     
        pkg_traza.trace(csbMetodo ||' prod_suspension_id_2: ' || nupsid2||', suspension_type_id_2: ' || nupsst2, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' aplication_date_2: ' || dtpsad2||', inactive_date_2: ' || dtpsid2, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' cursor cususpactiprod FIN', csbNivelTrazaApi);   

        nucantcs := 0;
        FOR rg3 IN cususpacticomp(rg.sesunuse) LOOP
            nucantcs := nucantcs + 1;
            IF nucantcs = 1 THEN
              nucsid1 := rg3.comp_suspension_id;
              nucsco1 := rg3.component_id;
              nucsst1 := rg3.suspension_type_id;
              dtcsad1 := rg3.aplication_date;
              dtcsid1 := rg3.inactive_date;
            ELSIF nucantcs = 2 THEN
              nucsid2 := rg3.comp_suspension_id;
              nucsco2 := rg3.component_id;
              nucsst2 := rg3.suspension_type_id;
              dtcsad2 := rg3.aplication_date;
              dtcsid2 := rg3.inactive_date;
            ELSIF nucantcs = 3 THEN
              nucsid3 := rg3.comp_suspension_id;
              nucsco3 := rg3.component_id;
              nucsst3 := rg3.suspension_type_id;
              dtcsad3 := rg3.aplication_date;
              dtcsid3 := rg3.inactive_date;
            ELSIF nucantcs = 4 THEN
              nucsid4 := rg3.comp_suspension_id;
              nucsco4 := rg3.component_id;
              nucsst4 := rg3.suspension_type_id;
              dtcsad4 := rg3.aplication_date;
              dtcsid4 := rg3.inactive_date;
            END IF;
        END LOOP; 
        pkg_traza.trace(csbMetodo ||' cursor cususpacticomp INICIO', csbNivelTrazaApi);          
        pkg_traza.trace(csbMetodo ||' comp_suspension_id_1: ' || nucsid1||', component_id_1: ' || nucsco1, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' suspension_type_id_1: ' || nucsst1||', aplication_date_1: ' || dtcsad1, csbNivelTrazaApi);     
        pkg_traza.trace(csbMetodo ||' inactive_date_1: ' || dtcsid1, csbNivelTrazaApi); 

        pkg_traza.trace(csbMetodo ||' comp_suspension_id_2: ' || nucsid2||', component_id_2: ' || nucsco2, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' suspension_type_id_2: ' || nucsst2||', aplication_date_2: ' || dtcsad2, csbNivelTrazaApi);     
        pkg_traza.trace(csbMetodo ||' inactive_date_2: ' || dtcsid2, csbNivelTrazaApi);

        pkg_traza.trace(csbMetodo ||' comp_suspension_id_3: ' || nucsid3||', component_id_3: ' || nucsco3, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' suspension_type_id_3: ' || nucsst3||', aplication_date_3: ' || dtcsad3, csbNivelTrazaApi);     
        pkg_traza.trace(csbMetodo ||' inactive_date_3: ' || dtcsid3, csbNivelTrazaApi); 

        pkg_traza.trace(csbMetodo ||' comp_suspension_id_4: ' || nucsid4||', component_id_4: ' || nucsco4, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' suspension_type_id_4: ' || nucsst4||', aplication_date_4: ' || dtcsad4, csbNivelTrazaApi);     
        pkg_traza.trace(csbMetodo ||' inactive_date_4: ' || dtcsid4, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' cursor cususpacticomp FIN', csbNivelTrazaApi);         

        nucantec := 0;
        FOR rg4 IN cuestcomp(rg.sesunuse) LOOP
            nucantec := nucantec + 1;
            IF nucantec = 1 THEN
                nuecid1 := rg4.component_id;
                nueces1 := rg4.component_status_id;
            ELSIF nucantec = 2 THEN
                nuecid2 := rg4.component_id;
                nueces2 := rg4.component_status_id;
            END IF;
        END LOOP;
        pkg_traza.trace(csbMetodo ||' cursor cuestcomp INICIO', csbNivelTrazaApi);        
        pkg_traza.trace(csbMetodo ||' component_id_1: ' || nuecid1||', component_status_id: ' || nueces1, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' component_id_2: ' || nuecid2||', component_status_id: ' || nueces2, csbNivelTrazaApi);  
        pkg_traza.trace(csbMetodo ||' cursor cuestcomp FIN', csbNivelTrazaApi);        

        FOR rg5 IN cuultactsusp (rg.suspen_ord_act_id) LOOP
            nuorultactsusp := rg5.order_id;
            nuacultactsusp := rg5.order_activity_id;
            nuttultactsusp := rg5.task_type_id;
        END LOOP;
        pkg_traza.trace(csbMetodo ||' cursor cuultactsusp INICIO', csbNivelTrazaApi);        
        pkg_traza.trace(csbMetodo ||' order_id: ' || nuorultactsusp||', order_activity_id: ' || nuacultactsusp, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' task_type_id: ' || nuttultactsusp , csbNivelTrazaApi);  
        pkg_traza.trace(csbMetodo ||' cursor cuultactsusp FIN', csbNivelTrazaApi);     

        -- ult act de susp de RP
        OPEN cuultactsusprp(rg.sesunuse);
        FETCH cuultactsusprp INTO nuultactsusprp;
            IF cuultactsusprp%notfound THEN
            nuultactsusprp := NULL;
            END IF;
        CLOSE cuultactsusprp;
        pkg_traza.trace(csbMetodo ||' nuultactsusprp: ' || nuultactsusprp, csbNivelTrazaApi);

        -- ult act de susp de Cartera
        OPEN cuultactsuspca(rg.sesunuse);
        FETCH cuultactsuspca INTO nuultactsuspca;
            IF cuultactsuspca%notfound THEN
            nuultactsuspca := NULL;
            END IF;
        CLOSE cuultactsuspca;
        pkg_traza.trace(csbMetodo ||' nuultactsuspca: ' || nuultactsuspca, csbNivelTrazaApi);        

        nucantord := 0;
        FOR rg6 IN cuultordenes(rg.sesunuse) LOOP
            nucantord := nucantord + 1;
            IF nucantord = 1 THEN
              nuororden1 := rg6.order_id;
              nuttorden1 := rg6.task_type_id;
              nuosorden1 := rg6.order_status_id;
              dtfcorden1 := rg6.created_date;
              dtflorden1 := rg6.legalization_date;
            ELSIF nucantord = 2 THEN
              nuororden2 := rg6.order_id;
              nuttorden2 := rg6.task_type_id;
              nuosorden2 := rg6.order_status_id;
              dtfcorden2 := rg6.created_date;
              dtflorden2 := rg6.legalization_date;
            ELSIF nucantord = 3 THEN
              nuororden3 := rg6.order_id;
              nuttorden3 := rg6.task_type_id;
              nuosorden3 := rg6.order_status_id;
              dtfcorden3 := rg6.created_date;
              dtflorden3 := rg6.legalization_date;
            ELSIF nucantord = 4 THEN
              nuororden4 := rg6.order_id;
              nuttorden4 := rg6.task_type_id;
              nuosorden4 := rg6.order_status_id;
              dtfcorden4 := rg6.created_date;
              dtflorden4 := rg6.legalization_date;
            ELSE
              EXIT;
            END IF;
        END LOOP;
        pkg_traza.trace(csbMetodo || 'cursor cuultordenes INICIO', csbNivelTrazaApi);        
        pkg_traza.trace(csbMetodo ||' order_id_1: ' || nuororden1||', task_type_id_1: ' || nuttorden1, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' order_status_id_1: ' || nuosorden1||', created_date_1: ' || dtfcorden1, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' legalization_date_1: ' || dtflorden1 , csbNivelTrazaApi);
        --
        pkg_traza.trace(csbMetodo ||' order_id_2: ' || nuororden2||', task_type_id_2: ' || nuttorden2, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' order_status_id_2: ' || nuosorden2||', created_date_2: ' || dtfcorden2, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' legalization_date_2: ' || dtflorden2 , csbNivelTrazaApi);
        --
        pkg_traza.trace(csbMetodo ||' order_id_3: ' || nuororden3||', task_type_id_3: ' || nuttorden3, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' order_status_id_3: ' || nuosorden3||', created_date_3: ' || dtfcorden3, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' legalization_date_3: ' || dtflorden3 , csbNivelTrazaApi); 
        --
        pkg_traza.trace(csbMetodo ||' order_id_4: ' || nuororden4||', task_type_id_4: ' || nuttorden4, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' order_status_id_4: ' || nuosorden4||', created_date_4: ' || dtfcorden4, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' legalization_date_4: ' || dtflorden4 , csbNivelTrazaApi);         
        pkg_traza.trace(csbMetodo ||' cursor cuultordenes FIN', csbNivelTrazaApi);  

        nucantsus := 0;
        FOR rg7 IN cuultsuspcone(rg.sesunuse) LOOP
            nucantsus := nucantsus + 1;
            IF nucantsus = 1 THEN
                nuorsusp1 := rg7.suconuor;
                nutpsusp1 := rg7.sucotipo;
                nufosusp1 := rg7.sucofeor;
                nufasusp1 := rg7.sucofeat;
            ELSIF nucantsus = 2 THEN
                nuorsusp2 := rg7.suconuor;
                nutpsusp2 := rg7.sucotipo;
                nufosusp2 := rg7.sucofeor;
                nufasusp2 := rg7.sucofeat;
            ELSE
                EXIT;
            END IF;
        END LOOP;
        pkg_traza.trace(csbMetodo ||' cursor cuultsuspcone INICIO', csbNivelTrazaApi);        
        pkg_traza.trace(csbMetodo ||' suconuor_1: ' || nuorsusp1||', sucotipo_1: ' || nutpsusp1, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' sucofeor_1: ' || nufosusp1||', sucofeat_1: ' || nufasusp1, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' legalization_date_1: ' || dtflorden1 , csbNivelTrazaApi);
        --
        pkg_traza.trace(csbMetodo ||' suconuor_2: ' || nuorsusp2||', sucotipo_2: ' || nutpsusp2, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' sucofeor_2: ' || nufosusp2||', sucofeat_2: ' || nufasusp2, csbNivelTrazaApi); 
        pkg_traza.trace(csbMetodo ||' cursor cuultsuspcone FIN', csbNivelTrazaApi); 

        nucantsolrec := 0; 
        FOR rg8 IN cusolirecdet(rg.sesunuse) LOOP
            nucantsolrec := nucantsolrec + 1;
            IF nucantsolrec = 1 THEN
                nusorec := rg8.package_id;
                nuorrec := rg8.order_id;
                nuttrec := rg8.task_type_id;
                nueorec := rg8.order_status_id;
            ELSE
                EXIT;
            END IF;
        END LOOP;

        pkg_traza.trace(csbMetodo ||' cursor cusolirecdet INICIO', csbNivelTrazaApi);        
        pkg_traza.trace(csbMetodo ||' package_id: ' || nusorec||', order_id: ' || nuorrec, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' task_type_id: ' || nuttrec||', order_status_id: ' || nueorec, csbNivelTrazaApi); 
        pkg_traza.trace(csbMetodo ||' cursor cusolirecdet FIN', csbNivelTrazaApi);

        -- halla descripciones de estados de producto, componente y de corte
        OPEN cuEstProd(rg.product_status_id);
        FETCH cuEstProd INTO sbestprod;
        CLOSE cuEstProd;
        pkg_traza.trace(csbMetodo ||' sbestprod: ' || sbestprod , csbNivelTrazaApi);

        OPEN cuEstCorte(rg.sesuesco);
        FETCH cuEstCorte INTO sbestcorte;
        CLOSE cuEstCorte;
        pkg_traza.trace(csbMetodo ||' sbestcorte: ' || sbestcorte , csbNivelTrazaApi);

        IF nueces1 IS NOT NULL THEN
            OPEN cuEstComponente(nueces1);
            FETCH cuEstComponente INTO est_componente_1;
            CLOSE cuEstComponente;
            pkg_traza.trace(csbMetodo ||' est_componente_1: ' || est_componente_1 , csbNivelTrazaApi);
        END IF;

        IF nueces2 IS NOT NULL THEN
            OPEN cuEstComponente(nueces2);
            FETCH cuEstComponente INTO est_componente_2;
            CLOSE cuEstComponente;
            pkg_traza.trace(csbMetodo ||' est_componente_2: ' || est_componente_2 , csbNivelTrazaApi);
        END IF;

        -- halla tipo de trabajo de la ultima actividad de suspension
        IF nuttultactsusp IS NULL THEN
            ult_act_susp := NULL;
        ELSE
            OPEN cuUltActSusp2(nuttultactsusp);
            FETCH cuUltActSusp2 INTO ult_act_susp;
            CLOSE cuUltActSusp2;
        END IF;
        pkg_traza.trace(csbMetodo ||' ult_act_susp: ' || ult_act_susp , csbNivelTrazaApi);

        -- Arma datos de las ordenes
        orden_1 := armadatosorden(nuororden1, nuttorden1, nuosorden1, dtfcorden1, dtflorden1);
        pkg_traza.trace(csbMetodo ||' orden_1: ' || orden_1 , csbNivelTrazaApi);

        orden_2 := armadatosorden(nuororden2, nuttorden2, nuosorden2, dtfcorden2, dtflorden2);
        pkg_traza.trace(csbMetodo ||' orden_2: ' || orden_2 , csbNivelTrazaApi);

        orden_3 := armadatosorden(nuororden3, nuttorden3, nuosorden3, dtfcorden3, dtflorden3);
        pkg_traza.trace(csbMetodo ||' orden_3: ' || orden_3 , csbNivelTrazaApi);

        orden_4 := armadatosorden(nuororden4, nuttorden4, nuosorden4, dtfcorden4, dtflorden4);
        pkg_traza.trace(csbMetodo ||' orden_4: ' || orden_4 , csbNivelTrazaApi);

        -- Halla el tipo de suspensiion (RP o Cartera) y evalua si hay datos inconsistentes y si es asi los ingresa en la tabla
        sbtipoulacsusp := hallatipoultactsusp(ult_act_susp);
        pkg_traza.trace(csbMetodo ||' sbtipoulacsusp: ' || sbtipoulacsusp , csbNivelTrazaApi);

        IF sbtipoulacsusp = 'RP' THEN 
         IF inconsis_rp = 'SI' THEN
            insertareg;
            nuerror := nuerror + 1;
         pkg_traza.trace(csbMetodo ||' inconsis_rp SI' , csbNivelTrazaApi);
         END IF;
          pkg_traza.trace(csbMetodo ||' inconsis_rp NO' , csbNivelTrazaApi);
        ELSE
        IF sbtipoulacsusp = 'CA' THEN 
             insertareg;
             nuerror := nuerror + 1; 
        ELSE
          IF sbtipoulacsusp = 'NU' THEN-- no tiene ult act de susp
             insertareg;
             nuerror := nuerror + 1;
          END IF;
        END IF;
        END IF;

        IF MOD(nucont,50) = 0 THEN 
            pkg_estaproc.practualizaestaproc(sbNameProceso, 'Error', 'Analisis ' || nutipo || ' Van leidos ' || nucont || ' . Con datos inconsistentes: ' || nuerror);
        END IF;

        IF MOD(nuerror,500) = 0 THEN
          COMMIT;
        END IF;

    END LOOP;

    COMMIT;

    pkg_estaproc.practualizaestaproc(sbNameProceso, 'Ok', 'Analisis ' || nutipo || ' Leidos ' || nucont || ' . Con datos inconsistentes: ' || nuerror);
    osbmsgerror := NULL;
    pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN);
    RETURN (0 );

EXCEPTION
    WHEN pkg_Error.controlled_error THEN 
         pkg_Error.getError(nuerror, osbmsgerror);
         pkg_traza.trace(csbMetodo ||' osbmsgerror: ' || osbmsgerror, csbNivelTrazaApi);
         pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN_ERC);      
         pkg_estaproc.practualizaestaproc(sbNameProceso, 'error', osbmsgerror||' - '||dbms_utility.format_error_backtrace);
         RETURN -1;
    WHEN OTHERS THEN  
         pkg_Error.setError;
         pkg_Error.getError(nuerror, osbmsgerror);
         pkg_traza.trace(csbMetodo ||' osbmsgerror: ' || osbmsgerror, csbNivelTrazaApi);
         pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN_ERR);
         pkg_estaproc.practualizaestaproc(sbNameProceso, 'error', osbmsgerror||' - '||dbms_utility.format_error_backtrace);
         RETURN -1;
END fnuanalisissuspcone_1;

FUNCTION  FNUANALISISSUSPCONE_2 (sbNameProceso IN VARCHAR2, osbmsgerror OUT VARCHAR2) RETURN NUMBER IS
  /*******************************************************************
    Busca los productos con est corte 3 y de producto 2 con
    ult act susp es nula o de rev periodica
    ult act susp es de cartera y las susp activas no son de cartera

    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas
                                          Se reemplaza dald_parameter.fsbgetvalue_chain por pkg_bcld_parameter.fsbobtienevalorcadena
                                          Se retira código comentariado
                                          Se retira esquema OPEN antepuesto a pr_product, servsusc, pr_prod_suspension, pr_component, or_order_activity
                                          , or_order_status, or_order, or_task_type, ge_causal, ge_class_causal, mo_packages, suspcone, ps_package_type
                                          Se reemplaza ldc_boutilities.splitstrings por regexp_substr
                                          Se reemplaza SELECT-INTO por cursor cuEstProd, cuEstCorte, cuEstComponente, cuUltActSusp2
                                          Se reemplaza ldc_proactualizaestaprog por pkg_estaproc.practualizaestaproc
                                          Se añade como parametro de entrada el Nombre del proceso
                                          Se ajusta bloque de exception según pautas técnicas
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'fnuanalisissuspcone_2';
    csbNivelTrazaApi    CONSTANT NUMBER(2)        := pkg_traza.cnuNivelTrzApi;

    nuerror             NUMBER := 0;
    nutipo              NUMBER := 2;
    sbtipoulacsusp      VARCHAR2(200);
    sbttsuspca          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_CART_AJSUSPCONE');
    sbttsusprp          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_RP_AJSUSPCONE');
    sbttsuspad          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_ADM_AJSUSPCONE');
    sbttsuspvo          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_VOL_AJSUSPCONE');
    sbttreco            VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_RECO_AJSUSPCONE');
    sbttsusp            VARCHAR2(2000);
    sbttsuspreco        VARCHAR2(2000);

    CURSOR cuproductos IS
    SELECT sr.sesususc, sr.sesunuse, sr.sesuserv, sr.sesucicl, p.suspen_ord_act_id, sr.sesuesco, p.product_status_id
      FROM pr_product p, servsusc sr
     WHERE product_id= sr.sesunuse
       AND p.product_status_id = 2 
       AND sr.sesuesco = 3;

    CURSOR cususpactiprod (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.prod_suspension_id, P.product_id, P.suspension_type_id, P.register_date, P.aplication_date, P.inactive_date, P.active
      FROM pr_prod_suspension P
     WHERE P.product_id = nunuse
       AND P.active = 'Y'
  ORDER BY P.register_date;

    CURSOR cususpacticomp (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.*
      FROM pr_comp_suspension P
     WHERE P.component_id IN (SELECT cp.component_id
                                FROM pr_component cp
                               WHERE cp.product_id = nunuse)
      AND P.active = 'Y'
 ORDER BY P.register_date, P.component_id;

    CURSOR cuestcomp (nunuse servsusc.sesunuse%TYPE) IS
    SELECT cp.product_id, cp.component_id, cp.component_type_id, cp.component_status_id
      FROM pr_component cp
     WHERE cp.product_id = nunuse
       AND cp.component_status_id != 9
     ORDER BY cp.component_id;

    CURSOR cuultactsusp (nuordact or_order_activity.order_activity_id%TYPE) IS
    SELECT O.order_id, A.order_activity_id,  O.task_type_id, tt.DESCRIPTION desctt, O.created_date, O.legalization_date, O.order_status_id,
           (SELECT os.DESCRIPTION FROM or_order_status os WHERE os.order_status_id=O.order_status_id) descestaor,
            O.causal_id || ' - '  || gc.DESCRIPTION causal, CC.class_causal_id, CC.DESCRIPTION tipo_causal
      FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                      LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                      LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                      LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.order_activity_id = nuordact;

    CURSOR cuultactsusprp(nunuse servsusc.sesunuse%TYPE) IS
    SELECT A.order_activity_id
      FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                      LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                      LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                      LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.product_id = nunuse
      AND O.order_status_id = 8
      AND CC.class_causal_id = 1
      AND O.task_type_id IN  (SELECT (REGEXP_SUBSTR(sbttsusprp, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                                FROM dual
                          CONNECT BY regexp_substr(sbttsusprp, '[^|]+', 1, LEVEL) IS NOT NULL ) 
 ORDER BY O.legalization_date DESC;

    CURSOR cuultactsuspca(nunuse servsusc.sesunuse%TYPE) IS
     SELECT A.order_activity_id
       FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                       LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                       LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                       LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
     WHERE A.product_id = nunuse
       AND O.order_status_id = 8
       AND CC.class_causal_id = 1
       AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsuspca, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsuspca, '[^|]+', 1, LEVEL) IS NOT NULL )  
  ORDER BY O.legalization_date DESC;

    CURSOR cuultordenes (nunuse servsusc.sesunuse%TYPE) IS
    SELECT O.order_id, A.package_id, P.motive_status_id, A.order_activity_id,  O.task_type_id, tt.DESCRIPTION desctt, O.created_date, O.legalization_date, O.order_status_id,
           (SELECT os.DESCRIPTION FROM or_order_status os WHERE os.order_status_id=O.order_status_id) descestaor,
            O.causal_id || ' - '  || gc.DESCRIPTION causal, CC.class_causal_id,  CC.DESCRIPTION tipo_causal
      FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                      LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                      LEFT OUTER JOIN mo_packages P ON (A.package_id = P.package_id)
                      LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                      LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.product_id = nunuse
      AND O.order_status_id = 8
      AND CC.class_causal_id = 1
      AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsuspreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsuspreco, '[^|]+', 1, LEVEL) IS NOT NULL )     
    ORDER BY created_date DESC;

    CURSOR cuultsuspcone (nunuse servsusc.sesunuse%TYPE) IS
    SELECT S.suconuor, S.sucotipo, S.sucofeor, S.sucofeat
      FROM suspcone S
     WHERE S.suconuse = nunuse
       AND S.sucotipo != 'A'
     ORDER BY S.sucofeor DESC;

    CURSOR cusolirecdet (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.package_id, O.order_id, O.task_type_id, O.order_status_id
      FROM mo_packages P LEFT OUTER JOIN ps_package_type pt ON (pt.package_type_id=P.package_type_id)
                         LEFT OUTER JOIN or_order_activity A ON (A.package_id=P.package_id)
                         LEFT OUTER JOIN or_order O ON (O.order_id = A.order_id)
                         LEFT OUTER JOIN mo_motive M ON (M.package_id=P.package_id)
    WHERE M.product_id=nunuse
      AND P.motive_status_id = 13
      AND O.order_status_id = 8
      AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttreco, '[^|]+', 1, LEVEL) IS NOT NULL ) 
    UNION
    SELECT P.package_id, O.order_id, O.task_type_id,O.order_status_id
      FROM mo_packages P LEFT OUTER JOIN ps_package_type pt ON (pt.package_type_id=P.package_type_id)
                         LEFT OUTER JOIN or_order_activity A ON (A.package_id=P.package_id)
                         LEFT OUTER JOIN or_order O ON (O.order_id = A.order_id)
                         LEFT OUTER JOIN mo_motive M ON (M.package_id=P.package_id)
    WHERE M.product_id=nunuse
      AND P.motive_status_id = 13
      AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttreco, '[^|]+', 1, LEVEL) IS NOT NULL )  
      AND O.order_id IS NULL;

    CURSOR cuEstProd(p_product_status_id pr_product.product_status_id%TYPE)
    IS 
    SELECT ps.product_status_id || ' - ' || ps.description
      FROM ps_product_status ps
     WHERE ps.product_status_id = p_product_status_id;

    CURSOR cuEstCorte(p_sesuesco servsusc.sesuesco%TYPE)
    IS 
    SELECT escocodi || ' - ' || escodesc 
      FROM estacort e 
     WHERE escocodi = p_sesuesco;      

    CURSOR cuEstComponente( p_product_status_id pr_product.product_status_id%TYPE )
    IS          
    SELECT ps.product_status_id || ' - ' || ps.DESCRIPTION  
      FROM ps_product_status ps 
     WHERE ps.product_status_id = p_product_status_id; 

    CURSOR cuUltActSusp2( p_task_type_id or_task_type.task_type_id%TYPE )
    IS
    SELECT  tt.task_type_id || ' - ' || tt.DESCRIPTION 
      FROM or_task_type tt 
     WHERE tt.task_type_id = p_task_type_id;    

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTrazaApi, csbInicio);
    pkg_error.prInicializaError(nuerror, osbmsgerror);
    pkg_traza.trace(csbMetodo ||' nutipo: ' || nutipo, csbNivelTrazaApi);

    nutipoanalisis := nutipo;
    pkg_traza.trace(csbMetodo ||' nutipoanalisis: ' || nutipoanalisis, csbNivelTrazaApi);

    sbttsusp := sbttsuspca || '|' || sbttsusprp || '|' || sbttsuspad || '|' || sbttsuspvo;
    pkg_traza.trace(csbMetodo ||' sbttsusp: ' || sbttsusp, csbNivelTrazaApi);

    sbttsuspreco := sbttsusp || '|' || sbttreco;
    pkg_traza.trace(csbMetodo ||' sbttsuspreco: ' || sbttsuspreco, csbNivelTrazaApi);


    FOR rg IN cuproductos LOOP
    nucont := nucont + 1;
    -- limpia variables

    sbestprod      := NULL; sbestcorte := NULL; ult_act_susp := NULL; est_componente_1 := NULL;   est_componente_2 := NULL;      orden_1    := NULL; orden_2 := NULL;
    orden_3        := NULL; orden_4    := NULL; nucantps    := 0;    nucantcs   := 0;    nucantec   := 0;    nucantord  :=0;     nucantsus  :=0;     nucantsolrec :=0;  nupsid1 := NULL; nupsst1 := NULL; dtpsad1 := NULL;
    dtpsid1        := NULL; nupsid2    := NULL; nupsst2     := NULL; dtpsad2    := NULL; dtpsid2    := NULL; nucsid1    := NULL; nucsco1    := NULL; nucsst1  := NULL; dtcsad1 := NULL;
    dtcsid1        := NULL; nucsid2    := NULL; nucsco2     := NULL; nucsst2    := NULL; dtcsad2    := NULL; dtcsid2    := NULL; nucsid3    := NULL; nucsco3  := NULL; nucsst3 := NULL;
    dtcsad3        := NULL; dtcsid3    := NULL;  nucsid4    := NULL; nucsco4    := NULL; nucsst4    := NULL; dtcsad4    := NULL; dtcsid4    := NULL;
    nuecid1        := NULL; nueces1    := NULL; nuecid2     := NULL; nueces2    := NULL; nuorultactsusp := NULL; nuttultactsusp := NULL; nuultactsusprp := NULL; nuororden1   := NULL;
    nuttorden1     := NULL; nuosorden1 := NULL; nuororden2  := NULL; nuttorden2 := NULL; nuosorden2 := NULL; nuororden3 := NULL; nuttorden3 := NULL; nuosorden3  := NULL;
    nuororden4     := NULL; nuttorden4 := NULL; nuosorden4  := NULL; nuorsusp1  := NULL; nutpsusp1  := NULL; nufosusp1  := NULL; nufasusp1  := NULL; nuorsusp2   := NULL;
    dtfcorden1     := NULL; dtflorden1 := NULL; dtfcorden2  := NULL; dtflorden2 := NULL; dtfcorden3 := NULL; dtflorden3 := NULL; dtfcorden4 := NULL; dtflorden4  := NULL;
    nutpsusp2      := NULL; nufosusp2  := NULL; nufasusp2   := NULL; nusorec  := NULL;   nuorrec    := NULL; nuttrec    := NULL; nueorec    := NULL; sbsuspcone1 := NULL; sbsuspcone2  := NULL;
    nuacultactsusp := NULL;  nuultactsuspca:= NULL;
    nuproducto := rg.sesunuse;
    nuprodstat := rg.product_status_id;
    nusesuesco := rg.sesuesco;
    pkg_traza.trace(csbMetodo ||' nuproducto: ' || nuproducto, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' nuprodstat: ' || nuprodstat, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' nusesuesco: ' || nusesuesco, csbNivelTrazaApi);

    -- busca datos
    nucantps := 0;
    FOR rg2 IN cususpactiprod(rg.sesunuse) LOOP
     nucantps := nucantps + 1;
     IF nucantps = 1 THEN
       nupsid1 := rg2.prod_suspension_id;
       nupsst1 := rg2.suspension_type_id;
       dtpsad1 := rg2.aplication_date;
       dtpsid1 := rg2.inactive_date;
     ELSIF nucantps = 2 THEN
       nupsid2 := rg2.prod_suspension_id;
       nupsst2 := rg2.suspension_type_id;
       dtpsad2 := rg2.aplication_date;
       dtpsid2 := rg2.inactive_date;
     END IF;
    END LOOP;
    pkg_traza.trace(csbMetodo ||' cursor cususpactiprod INICIO', csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' prod_suspension_id_1: ' || nupsid1||', suspension_type_id_1: ' || nupsst1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' aplication_date_1: ' || dtpsad1||', inactive_date_1: ' || dtpsid1, csbNivelTrazaApi);     
    pkg_traza.trace(csbMetodo ||' prod_suspension_id_2: ' || nupsid2||', suspension_type_id_2: ' || nupsst2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' aplication_date_2: ' || dtpsad2||', inactive_date_2: ' || dtpsid2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' cursor cususpactiprod FIN', csbNivelTrazaApi);       

    nucantcs := 0;
    FOR rg3 IN cususpacticomp(rg.sesunuse) LOOP
    nucantcs := nucantcs + 1;
    IF nucantcs = 1 THEN
      nucsid1 := rg3.comp_suspension_id;
      nucsco1 := rg3.component_id;
      nucsst1 := rg3.suspension_type_id;
      dtcsad1 := rg3.aplication_date;
      dtcsid1 := rg3.inactive_date;
    ELSIF nucantcs = 2 THEN
      nucsid2 := rg3.comp_suspension_id;
      nucsco2 := rg3.component_id;
      nucsst2 := rg3.suspension_type_id;
      dtcsad2 := rg3.aplication_date;
      dtcsid2 := rg3.inactive_date;
    ELSIF nucantcs = 3 THEN
      nucsid3 := rg3.comp_suspension_id;
      nucsco3 := rg3.component_id;
      nucsst3 := rg3.suspension_type_id;
      dtcsad3 := rg3.aplication_date;
      dtcsid3 := rg3.inactive_date;
    ELSIF nucantcs = 4 THEN
      nucsid4 := rg3.comp_suspension_id;
      nucsco4 := rg3.component_id;
      nucsst4 := rg3.suspension_type_id;
      dtcsad4 := rg3.aplication_date;
      dtcsid4 := rg3.inactive_date;
    END IF;
    END LOOP;
    pkg_traza.trace(csbMetodo ||' cursor cususpacticomp INICIO', csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' comp_suspension_id_1: ' || nucsid1||', component_id_1: ' || nucsco1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' suspension_type_id_1: ' || nucsst1||', aplication_date_1: ' || dtcsad1, csbNivelTrazaApi);     
    pkg_traza.trace(csbMetodo ||' inactive_date_1: ' || dtcsid1, csbNivelTrazaApi);

    pkg_traza.trace(csbMetodo ||' comp_suspension_id_2: ' || nucsid2||', component_id_2: ' || nucsco2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' suspension_type_id_2: ' || nucsst2||', aplication_date_2: ' || dtcsad2, csbNivelTrazaApi);     
    pkg_traza.trace(csbMetodo ||' inactive_date_2: ' || dtcsid2, csbNivelTrazaApi);

    pkg_traza.trace(csbMetodo ||' comp_suspension_id_3: ' || nucsid3||', component_id_3: ' || nucsco3, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' suspension_type_id_3: ' || nucsst3||', aplication_date_3: ' || dtcsad3, csbNivelTrazaApi);     
    pkg_traza.trace(csbMetodo ||' inactive_date_3: ' || dtcsid3, csbNivelTrazaApi);

    pkg_traza.trace(csbMetodo ||' comp_suspension_id_4: ' || nucsid4||', component_id_4: ' || nucsco4, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' suspension_type_id_4: ' || nucsst4||', aplication_date_4: ' || dtcsad4, csbNivelTrazaApi);     
    pkg_traza.trace(csbMetodo ||' inactive_date_4: ' || dtcsid4, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' cursor cususpacticomp FIN', csbNivelTrazaApi);

    nucantec := 0;
    FOR rg4 IN cuestcomp(rg.sesunuse) LOOP
     nucantec := nucantec + 1;
     IF nucantec = 1 THEN
       nuecid1 := rg4.component_id;
       nueces1 := rg4.component_status_id;
     ELSIF nucantec = 2 THEN
       nuecid2 := rg4.component_id;
       nueces2 := rg4.component_status_id;
     END IF;
    END LOOP;
    pkg_traza.trace(csbMetodo ||' cursor cuestcomp INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' component_id_1: ' || nuecid1||', component_status_id: ' || nueces1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' component_id_2: ' || nuecid2||', component_status_id: ' || nueces2, csbNivelTrazaApi);  
    pkg_traza.trace(csbMetodo ||' cursor cuestcomp FIN', csbNivelTrazaApi);     

    FOR rg5 IN cuultactsusp (rg.suspen_ord_act_id) LOOP
     nuorultactsusp := rg5.order_id;
     nuacultactsusp := rg5.order_activity_id;
     nuttultactsusp := rg5.task_type_id;
    END LOOP;
    pkg_traza.trace(csbMetodo ||' cursor cuultactsusp INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' order_id: ' || nuorultactsusp||', order_activity_id: ' || nuacultactsusp, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' task_type_id: ' || nuttultactsusp , csbNivelTrazaApi);  
    pkg_traza.trace(csbMetodo ||' cursor cuultactsusp FIN', csbNivelTrazaApi);     

    -- ult act de susp de RP
    OPEN cuultactsusprp(rg.sesunuse);
    FETCH cuultactsusprp INTO nuultactsusprp;
    IF cuultactsusprp%notfound THEN
    nuultactsusprp := NULL;
    END IF;
    CLOSE cuultactsusprp;
    pkg_traza.trace(csbMetodo ||' nuultactsusprp: ' || nuultactsusprp, csbNivelTrazaApi);

    -- ult act de susp de Cartera
    OPEN cuultactsuspca(rg.sesunuse);
    FETCH cuultactsuspca INTO nuultactsuspca;
    IF cuultactsuspca%notfound THEN
    nuultactsuspca := NULL;
    END IF;
    CLOSE cuultactsuspca;
    pkg_traza.trace(csbMetodo ||' nuultactsuspca: ' || nuultactsuspca, csbNivelTrazaApi);

    nucantord := 0;
    FOR rg6 IN cuultordenes(rg.sesunuse) LOOP
    nucantord := nucantord + 1;
    IF nucantord = 1 THEN
      nuororden1 := rg6.order_id;
      nuttorden1 := rg6.task_type_id;
      nuosorden1 := rg6.order_status_id;
      dtfcorden1 := rg6.created_date;
      dtflorden1 := rg6.legalization_date;
    ELSIF nucantord = 2 THEN
      nuororden2 := rg6.order_id;
      nuttorden2 := rg6.task_type_id;
      nuosorden2 := rg6.order_status_id;
      dtfcorden2 := rg6.created_date;
      dtflorden2 := rg6.legalization_date;
    ELSIF nucantord = 3 THEN
      nuororden3 := rg6.order_id;
      nuttorden3 := rg6.task_type_id;
      nuosorden3 := rg6.order_status_id;
      dtfcorden3 := rg6.created_date;
      dtflorden3 := rg6.legalization_date;
    ELSIF nucantord = 4 THEN
      nuororden4 := rg6.order_id;
      nuttorden4 := rg6.task_type_id;
      nuosorden4 := rg6.order_status_id;
      dtfcorden4 := rg6.created_date;
      dtflorden4 := rg6.legalization_date;
    ELSE
      EXIT;
    END IF;
    END LOOP;

    pkg_traza.trace(csbMetodo ||' cursor cuultordenes INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' order_id_1: ' || nuororden1||', task_type_id_1: ' || nuttorden1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_status_id_1: ' || nuosorden1||', created_date_1: ' || dtfcorden1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_1: ' || dtflorden1 , csbNivelTrazaApi);
    --
    pkg_traza.trace(csbMetodo ||' order_id_2: ' || nuororden2||', task_type_id_2: ' || nuttorden2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_status_id_2: ' || nuosorden2||', created_date_2: ' || dtfcorden2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_2: ' || dtflorden2 , csbNivelTrazaApi);
    --
    pkg_traza.trace(csbMetodo ||' order_id_3: ' || nuororden3||', task_type_id_3: ' || nuttorden3, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_status_id_3: ' || nuosorden3||', created_date_3: ' || dtfcorden3, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_3: ' || dtflorden3 , csbNivelTrazaApi); 
    --
    pkg_traza.trace(csbMetodo ||' order_id_4: ' || nuororden4||', task_type_id_4: ' || nuttorden4, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_status_id_4: ' || nuosorden4||', created_date_4: ' || dtfcorden4, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_4: ' || dtflorden4 , csbNivelTrazaApi);         
    pkg_traza.trace(csbMetodo ||' cursor cuultordenes FIN', csbNivelTrazaApi);

    nucantsus := 0;
    FOR rg7 IN cuultsuspcone(rg.sesunuse) LOOP
     nucantsus := nucantsus + 1;
     IF nucantsus = 1 THEN
       nuorsusp1 := rg7.suconuor;
       nutpsusp1 := rg7.sucotipo;
       nufosusp1 := rg7.sucofeor;
       nufasusp1 := rg7.sucofeat;
     ELSIF nucantsus = 2 THEN
       nuorsusp2 := rg7.suconuor;
       nutpsusp2 := rg7.sucotipo;
       nufosusp2 := rg7.sucofeor;
       nufasusp2 := rg7.sucofeat;
    ELSE
      EXIT;
    END IF;
    END LOOP;
    pkg_traza.trace(csbMetodo ||' cursor cuultsuspcone INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' suconuor_1: ' || nuorsusp1||', sucotipo_1: ' || nutpsusp1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' sucofeor_1: ' || nufosusp1||', sucofeat_1: ' || nufasusp1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_1: ' || dtflorden1 , csbNivelTrazaApi);
    --
    pkg_traza.trace(csbMetodo ||' suconuor_2: ' || nuorsusp2||', sucotipo_2: ' || nutpsusp2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' sucofeor_2: ' || nufosusp2||', sucofeat_2: ' || nufasusp2, csbNivelTrazaApi); 
    pkg_traza.trace(csbMetodo ||' cursor cuultsuspcone FIN', csbNivelTrazaApi); 

    nucantsolrec := 0;
    FOR rg8 IN cusolirecdet(rg.sesunuse) LOOP
    nucantsolrec := nucantsolrec + 1;
    IF nucantsolrec = 1 THEN
      nusorec := rg8.package_id;
      nuorrec := rg8.order_id;
      nuttrec := rg8.task_type_id;
      nueorec := rg8.order_status_id;
    ELSE
      EXIT;
    END IF;
    END LOOP;
    pkg_traza.trace(csbMetodo ||' cursor cusolirecdet INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' package_id: ' || nusorec||', order_id: ' || nuorrec, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' task_type_id: ' || nuttrec||', order_status_id: ' || nueorec, csbNivelTrazaApi); 
    pkg_traza.trace(csbMetodo ||' cursor cusolirecdet FIN', csbNivelTrazaApi);

    -- halla descripciones de estados de producto, componente y de corte
    OPEN cuEstProd(rg.product_status_id);
    FETCH cuEstProd INTO sbestprod;
    CLOSE cuEstProd;
    pkg_traza.trace(csbMetodo ||' sbestprod: ' || sbestprod , csbNivelTrazaApi);

    OPEN cuEstCorte(rg.sesuesco);
    FETCH cuEstCorte INTO sbestcorte;
    CLOSE cuEstCorte;
    pkg_traza.trace(csbMetodo ||' sbestcorte: ' || sbestcorte , csbNivelTrazaApi);     

    IF nueces1 IS NOT NULL THEN
        OPEN cuEstComponente(nueces1);
        FETCH cuEstComponente INTO est_componente_1;
        CLOSE cuEstComponente;
        pkg_traza.trace(csbMetodo ||' est_componente_1: ' || est_componente_1 , csbNivelTrazaApi); 
    END IF;

    IF nueces2 IS NOT NULL THEN
        OPEN cuEstComponente(nueces2);
        FETCH cuEstComponente INTO est_componente_2;
        CLOSE cuEstComponente;
        pkg_traza.trace(csbMetodo ||' est_componente_2: ' || est_componente_2 , csbNivelTrazaApi); 
    END IF;

    -- halla tipo de trabajo de la ultima actividad de suspension
    IF nuttultactsusp IS NULL THEN
        ult_act_susp := NULL;
    ELSE
        OPEN cuUltActSusp2(nuttultactsusp);
        FETCH cuUltActSusp2 INTO ult_act_susp;
        CLOSE cuUltActSusp2;        
        SELECT  nuttultactsusp || ' - ' || tt.DESCRIPTION INTO ult_act_susp FROM or_task_type tt WHERE tt.task_type_id = nuttultactsusp;
    END IF;
    pkg_traza.trace(csbMetodo ||' ult_act_susp: ' || ult_act_susp , csbNivelTrazaApi);

    -- Arma datos de las ordenes
    orden_1 := armadatosorden(nuororden1, nuttorden1, nuosorden1, dtfcorden1, dtflorden1);
    pkg_traza.trace(csbMetodo ||' orden_1: ' || orden_1 , csbNivelTrazaApi);

    orden_2 := armadatosorden(nuororden2, nuttorden2, nuosorden2, dtfcorden2, dtflorden2);
    pkg_traza.trace(csbMetodo ||' orden_2: ' || orden_2 , csbNivelTrazaApi);

    orden_3 := armadatosorden(nuororden3, nuttorden3, nuosorden3, dtfcorden3, dtflorden3);
    pkg_traza.trace(csbMetodo ||' orden_3: ' || orden_3 , csbNivelTrazaApi);

    orden_4 := armadatosorden(nuororden4, nuttorden4, nuosorden4, dtfcorden4, dtflorden4);
    pkg_traza.trace(csbMetodo ||' orden_4: ' || orden_4 , csbNivelTrazaApi);

    -- Halla el tipo de suspensiion (RP o Cartera) y evalua si hay datos inconsistentes y si es asi los ingresa en la tabla
    sbtipoulacsusp := hallatipoultactsusp(ult_act_susp);
    pkg_traza.trace(csbMetodo ||' sbtipoulacsusp: ' || sbtipoulacsusp , csbNivelTrazaApi);

    IF sbtipoulacsusp = 'RP' THEN 
        insertareg;
        nuerror := nuerror + 1; 
    ELSE
    IF sbtipoulacsusp = 'CA' THEN      
      IF inconsis_ca = 'SI' THEN
         insertareg;
         nuerror := nuerror + 1;
      END IF;
    ELSE
      IF sbtipoulacsusp = 'NU' THEN-- no tiene ult act de susp
         insertareg;
         nuerror := nuerror + 1;
      END IF;
    END IF;
    END IF;

    IF MOD(nucont,50) = 0 THEN
        pkg_estaproc.practualizaestaproc(sbNameProceso, 'Error', 'Analisis ' || nutipo || ' Van leidos ' || nucont || ' . Con datos inconsistentes: ' || nuerror);
    END IF;

    IF MOD(nuerror,500) = 0 THEN
        COMMIT;
    END IF;

    END LOOP;

    COMMIT;

    pkg_estaproc.practualizaestaproc(sbNameProceso, 'Ok', 'Analisis ' || nutipo || ' Leidos ' || nucont || ' . Con datos inconsistentes: ' || nuerror);
    osbmsgerror := NULL;
    pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN);    
    RETURN (0 );

EXCEPTION
    WHEN pkg_Error.controlled_error THEN 
         pkg_Error.getError(nuerror, osbmsgerror);
         pkg_traza.trace(csbMetodo ||' osbmsgerror: ' || osbmsgerror, csbNivelTrazaApi);
         pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN_ERC);      
         pkg_estaproc.practualizaestaproc(sbNameProceso, 'error', osbmsgerror||' - '||dbms_utility.format_error_backtrace);
         RETURN -1;
    WHEN OTHERS THEN  
         pkg_Error.setError;
         pkg_Error.getError(nuerror, osbmsgerror);
         pkg_traza.trace(csbMetodo ||' osbmsgerror: ' || osbmsgerror, csbNivelTrazaApi);
         pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN_ERR);
         pkg_estaproc.practualizaestaproc(sbNameProceso, 'error', osbmsgerror||' - '||dbms_utility.format_error_backtrace);
         RETURN -1;
END fnuanalisissuspcone_2;

--
FUNCTION  FNUANALISISSUSPCONE_3 (sbNameProceso IN VARCHAR2, osbmsgerror OUT VARCHAR2) RETURN NUMBER IS
  /*******************************************************************
    Busca los productos con est producto susp con
    numero de suspensiones activas 0 o mas de 1

    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas
                                          Se reemplaza dald_parameter.fsbgetvalue_chain por pkg_bcld_parameter.fsbobtienevalorcadena
                                          Se retira código comentariado
                                          Se retira esquema OPEN antepuesto a pr_product, servsusc, pr_prod_suspension, pr_component, or_order_activity
                                          , or_order_status, or_order, or_task_type, ge_causal, ge_class_causal, mo_packages, suspcone, ps_package_type
                                          Se reemplaza ldc_boutilities.splitstrings por regexp_substr
                                          Se reemplaza SELECT-INTO por cursor cuEstProd, cuEstCorte, cuEstComponente, cuUltActSusp2
                                          Se reemplaza ldc_proactualizaestaprog por pkg_estaproc.practualizaestaproc
                                          Se añade como parametro de entrada el Nombre del proceso
                                          Se ajusta bloque de exception según pautas técnicas
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'fnuanalisissuspcone_3';
    csbNivelTrazaApi    CONSTANT NUMBER(2)        := pkg_traza.cnuNivelTrzApi;

    nuerror         NUMBER := 0;
    nutipo          NUMBER := 3;
    sbtipoulacsusp  VARCHAR2(200);
    sbttsuspca      VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_CART_AJSUSPCONE');
    sbttsusprp      VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_RP_AJSUSPCONE');
    sbttsuspad      VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_ADM_AJSUSPCONE');
    sbttsuspvo      VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_VOL_AJSUSPCONE');
    sbttreco        VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_RECO_AJSUSPCONE');
    sbttsusp        VARCHAR2(2000);
    sbttsuspreco    VARCHAR2(2000);

    CURSOR cuproductos IS
    SELECT sr.sesususc, sr.sesunuse, sr.sesuserv, sr.sesucicl, p.suspen_ord_act_id, sr.sesuesco, p.product_status_id
      FROM pr_product p, servsusc sr
     WHERE p.product_id= sr.sesunuse
       AND p.product_status_id = 2
       AND p.product_id IN (SELECT ps.product_id
                              FROM pr_prod_suspension ps
                             WHERE ps.active = 'Y'
                             GROUP BY ps.product_id
                             HAVING COUNT(1) != 1);


    CURSOR cususpactiprod (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.prod_suspension_id, P.product_id, P.suspension_type_id, P.register_date, P.aplication_date, P.inactive_date, P.active
      FROM pr_prod_suspension P
     WHERE P.product_id = nunuse
       AND P.active = 'Y'
    ORDER BY P.register_date;

    CURSOR cususpacticomp (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.*
      FROM pr_comp_suspension P
      WHERE P.component_id IN (SELECT cp.component_id
                                 FROM pr_component cp
                                WHERE cp.product_id = nunuse)
       AND P.active = 'Y'
     ORDER BY P.register_date, P.component_id;

    CURSOR cuestcomp (nunuse servsusc.sesunuse%TYPE) IS
    SELECT cp.product_id, cp.component_id, cp.component_type_id, cp.component_status_id
      FROM pr_component cp
     WHERE cp.product_id = nunuse
       AND cp.component_status_id != 9
     ORDER BY cp.component_id;

    CURSOR cuultactsusp (nuordact or_order_activity.order_activity_id%TYPE) IS
    SELECT O.order_id, A.order_activity_id,  O.task_type_id, tt.DESCRIPTION desctt, O.created_date, O.legalization_date, O.order_status_id,
           (SELECT os.DESCRIPTION FROM or_order_status os WHERE os.order_status_id=O.order_status_id) descestaor,
            O.causal_id || ' - '  || gc.DESCRIPTION causal, CC.class_causal_id, CC.DESCRIPTION tipo_causal
      FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                      LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                      LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                      LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.order_activity_id = nuordact;

    CURSOR cuultactsusprp(nunuse servsusc.sesunuse%TYPE) IS
    SELECT A.order_activity_id
    FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                  LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                  LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                  LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.product_id = nunuse 
    AND O.order_status_id = 8
    AND CC.class_causal_id = 1
    AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsusprp, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsusprp, '[^|]+', 1, LEVEL) IS NOT NULL)
    ORDER BY O.legalization_date DESC;

    CURSOR cuultactsuspca(nunuse servsusc.sesunuse%TYPE) IS
    SELECT A.order_activity_id
    FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                  LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                  LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                  LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.product_id = nunuse 
    AND O.order_status_id = 8
    AND CC.class_causal_id = 1
    AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsuspca, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsuspca, '[^|]+', 1, LEVEL) IS NOT NULL)
    ORDER BY O.legalization_date DESC;

    CURSOR cuultordenes (nunuse servsusc.sesunuse%TYPE) IS
    SELECT O.order_id, A.package_id, P.motive_status_id, A.order_activity_id,  O.task_type_id, tt.DESCRIPTION desctt,
           O.created_date, O.legalization_date, O.order_status_id,
          (SELECT os.DESCRIPTION FROM or_order_status os WHERE os.order_status_id=O.order_status_id) descestaor,
          O.causal_id || ' - '  || gc.DESCRIPTION causal, CC.class_causal_id, CC.DESCRIPTION tipo_causal
    FROM or_order O
    INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
    LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
    LEFT OUTER JOIN mo_packages P ON (A.package_id = P.package_id)
    LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
    LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.product_id = nunuse
    AND O.order_status_id = 8
    AND CC.class_causal_id = 1
    AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsuspreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsuspreco, '[^|]+', 1, LEVEL) IS NOT NULL )
    ORDER BY created_date DESC;

    CURSOR cuultsuspcone (nunuse servsusc.sesunuse%TYPE) IS
    SELECT S.suconuor, S.sucotipo, S.sucofeor, S.sucofeat
      FROM suspcone S
     WHERE S.suconuse = nunuse
       AND S.sucotipo != 'A'
     ORDER BY S.sucofeor DESC;

    CURSOR cusolirecdet (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.package_id, O.order_id, O.task_type_id, O.order_status_id
      FROM mo_packages P LEFT OUTER JOIN ps_package_type pt ON (pt.package_type_id=P.package_type_id)
                         LEFT OUTER JOIN or_order_activity A ON (A.package_id=P.package_id)
                         LEFT OUTER JOIN or_order O ON (O.order_id = A.order_id)
                         LEFT OUTER JOIN mo_motive M ON (M.package_id=P.package_id)
    WHERE M.product_id=nunuse
    AND P.motive_status_id = 13
    AND O.order_status_id = 8 --  > 5
    AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttreco, '[^|]+', 1, LEVEL) IS NOT NULL)
    UNION
    SELECT P.package_id, O.order_id, O.task_type_id, O.order_status_id
      FROM mo_packages P LEFT OUTER JOIN ps_package_type pt ON (pt.package_type_id=P.package_type_id)
                         LEFT OUTER JOIN or_order_activity A ON (A.package_id=P.package_id)
                         LEFT OUTER JOIN or_order O ON (O.order_id = A.order_id)
                         LEFT OUTER JOIN mo_motive M ON (M.package_id=P.package_id)
    WHERE M.product_id=nunuse
    AND P.motive_status_id = 13
    AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttreco, '[^|]+', 1, LEVEL) IS NOT NULL)
    AND O.order_id IS NULL;

    CURSOR cuEstProd(p_product_status_id pr_product.product_status_id%TYPE)
    IS 
    SELECT ps.product_status_id || ' - ' || ps.description
      FROM ps_product_status ps
     WHERE ps.product_status_id = p_product_status_id;

    CURSOR cuEstCorte(p_sesuesco servsusc.sesuesco%TYPE)
    IS 
    SELECT escocodi || ' - ' || escodesc 
      FROM estacort e 
     WHERE escocodi = p_sesuesco;      

    CURSOR cuEstComponente( p_product_status_id pr_product.product_status_id%TYPE )
    IS          
    SELECT ps.product_status_id || ' - ' || ps.DESCRIPTION  
      FROM ps_product_status ps 
     WHERE ps.product_status_id = p_product_status_id; 

    CURSOR cuUltActSusp2( p_task_type_id or_task_type.task_type_id%TYPE )
    IS
    SELECT  tt.task_type_id || ' - ' || tt.DESCRIPTION 
      FROM or_task_type tt 
     WHERE tt.task_type_id = p_task_type_id;  

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTrazaApi, csbInicio);
    pkg_error.prInicializaError(nuerror, osbmsgerror);
    pkg_traza.trace(csbMetodo ||' nutipo: ' || nutipo, csbNivelTrazaApi);

    nutipoanalisis := nutipo;
    pkg_traza.trace(csbMetodo ||' nutipoanalisis: ' || nutipoanalisis, csbNivelTrazaApi);

    sbttsusp := sbttsuspca || '|' || sbttsusprp || '|' || sbttsuspad || '|' || sbttsuspvo;
    pkg_traza.trace(csbMetodo ||' sbttsusp: ' || sbttsusp, csbNivelTrazaApi);

    sbttsuspreco := sbttsusp || '|' || sbttreco;
    pkg_traza.trace(csbMetodo ||' sbttsuspreco: ' || sbttsuspreco, csbNivelTrazaApi);

    FOR rg IN cuproductos LOOP
    nucont := nucont + 1;
    -- limpia variables

    sbestprod   := NULL; sbestcorte := NULL; ult_act_susp := NULL; est_componente_1 := NULL; est_componente_2 := NULL; orden_1          := NULL; orden_2        := NULL;
    orden_3     := NULL; orden_4    := NULL; nucantps     := 0;    nucantcs         := 0;    nucantec         := 0;    nucantord        :=0;     nucantsus      :=0;     nucantsolrec   :=0;     nupsid1 := NULL; nupsst1 := NULL; dtpsad1 := NULL;
    dtpsid1     := NULL; nupsid2    := NULL; nupsst2      := NULL; dtpsad2          := NULL; dtpsid2          := NULL; nucsid1          := NULL; nucsco1        := NULL; nucsst1        := NULL; dtcsad1 := NULL;
    dtcsid1     := NULL; nucsid2    := NULL; nucsco2      := NULL; nucsst2          := NULL; dtcsad2          := NULL; dtcsid2          := NULL; nucsid3        := NULL; nucsco3        := NULL; nucsst3 := NULL;
    dtcsad3     := NULL; dtcsid3    := NULL; nucsid4      := NULL; nucsco4          := NULL; nucsst4          := NULL; dtcsad4          := NULL; dtcsid4        := NULL;
    nuecid1     := NULL; nueces1    := NULL; nuecid2      := NULL; nueces2          := NULL; nuorultactsusp   := NULL; nuttultactsusp   := NULL; nuultactsusprp := NULL; nuororden1     := NULL;
    nuttorden1  := NULL; nuosorden1 := NULL; nuororden2   := NULL; nuttorden2       := NULL; nuosorden2       := NULL; nuororden3       := NULL; nuttorden3     := NULL; nuosorden3     := NULL;
    nuororden4  := NULL; nuttorden4 := NULL; nuosorden4   := NULL; nuorsusp1        := NULL; nutpsusp1        := NULL; nufosusp1        := NULL; nufasusp1      := NULL; nuorsusp2      := NULL;
    dtfcorden1  := NULL; dtflorden1 := NULL; dtfcorden2   := NULL; dtflorden2       := NULL; dtfcorden3       := NULL; dtflorden3       := NULL; dtfcorden4     := NULL; dtflorden4     := NULL;
    nutpsusp2   := NULL; nufosusp2  := NULL; nufasusp2    := NULL; nusorec          := NULL; nuorrec          := NULL; nuttrec          := NULL; nueorec        := NULL; sbsuspcone1    := NULL; sbsuspcone2 := NULL;
    nuacultactsusp := NULL;  nuultactsuspca:= NULL;
    nuproducto := rg.sesunuse;
    nuprodstat := rg.product_status_id;
    nusesuesco := rg.sesuesco;

    pkg_traza.trace(csbMetodo ||' nuproducto: ' || nuproducto, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' nuprodstat: ' || nuprodstat, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' nusesuesco: ' || nusesuesco, csbNivelTrazaApi);

    -- busca datos
    nucantps := 0;
    FOR rg2 IN cususpactiprod(rg.sesunuse) LOOP
        nucantps := nucantps + 1;
        IF nucantps = 1 THEN
            nupsid1 := rg2.prod_suspension_id;
            nupsst1 := rg2.suspension_type_id;
            dtpsad1 := rg2.aplication_date;
            dtpsid1 := rg2.inactive_date;
        ELSIF nucantps = 2 THEN
            nupsid2 := rg2.prod_suspension_id;
            nupsst2 := rg2.suspension_type_id;
            dtpsad2 := rg2.aplication_date;
            dtpsid2 := rg2.inactive_date;
        END IF;
    END LOOP;
        pkg_traza.trace(csbMetodo ||' cursor cususpactiprod INICIO', csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' prod_suspension_id_1: ' || nupsid1||', suspension_type_id_1: ' || nupsst1, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' aplication_date_1: ' || dtpsad1||', inactive_date_1: ' || dtpsid1, csbNivelTrazaApi);     
        pkg_traza.trace(csbMetodo ||' prod_suspension_id_2: ' || nupsid2||', suspension_type_id_2: ' || nupsst2, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' aplication_date_2: ' || dtpsad2||', inactive_date_2: ' || dtpsid2, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' cursor cususpactiprod FIN', csbNivelTrazaApi);     

    nucantcs := 0;
    FOR rg3 IN cususpacticomp(rg.sesunuse) LOOP
        nucantcs := nucantcs + 1;
        IF nucantcs = 1 THEN
            nucsid1 := rg3.comp_suspension_id;
            nucsco1 := rg3.component_id;
            nucsst1 := rg3.suspension_type_id;
            dtcsad1 := rg3.aplication_date;
            dtcsid1 := rg3.inactive_date;
        ELSIF nucantcs = 2 THEN
            nucsid2 := rg3.comp_suspension_id;
            nucsco2 := rg3.component_id;
            nucsst2 := rg3.suspension_type_id;
            dtcsad2 := rg3.aplication_date;
            dtcsid2 := rg3.inactive_date;
        ELSIF nucantcs = 3 THEN
            nucsid3 := rg3.comp_suspension_id;
            nucsco3 := rg3.component_id;
            nucsst3 := rg3.suspension_type_id;
            dtcsad3 := rg3.aplication_date;
            dtcsid3 := rg3.inactive_date;
        ELSIF nucantcs = 4 THEN
            nucsid4 := rg3.comp_suspension_id;
            nucsco4 := rg3.component_id;
            nucsst4 := rg3.suspension_type_id;
            dtcsad4 := rg3.aplication_date;
            dtcsid4 := rg3.inactive_date;
        END IF;
    END LOOP;
    pkg_traza.trace(csbMetodo ||' cursor cususpacticomp INICIO', csbNivelTrazaApi);          
    pkg_traza.trace(csbMetodo ||' comp_suspension_id_1: ' || nucsid1||', component_id_1: ' || nucsco1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' suspension_type_id_1: ' || nucsst1||', aplication_date_1: ' || dtcsad1, csbNivelTrazaApi);     
    pkg_traza.trace(csbMetodo ||' inactive_date_1: ' || dtcsid1, csbNivelTrazaApi); 

    pkg_traza.trace(csbMetodo ||' comp_suspension_id_2: ' || nucsid2||', component_id_2: ' || nucsco2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' suspension_type_id_2: ' || nucsst2||', aplication_date_2: ' || dtcsad2, csbNivelTrazaApi);     
    pkg_traza.trace(csbMetodo ||' inactive_date_2: ' || dtcsid2, csbNivelTrazaApi);

    pkg_traza.trace(csbMetodo ||' comp_suspension_id_3: ' || nucsid3||', component_id_3: ' || nucsco3, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' suspension_type_id_3: ' || nucsst3||', aplication_date_3: ' || dtcsad3, csbNivelTrazaApi);     
    pkg_traza.trace(csbMetodo ||' inactive_date_3: ' || dtcsid3, csbNivelTrazaApi); 

    pkg_traza.trace(csbMetodo ||' comp_suspension_id_4: ' || nucsid4||', component_id_4: ' || nucsco4, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' suspension_type_id_4: ' || nucsst4||', aplication_date_4: ' || dtcsad4, csbNivelTrazaApi);     
    pkg_traza.trace(csbMetodo ||' inactive_date_4: ' || dtcsid4, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' cursor cususpacticomp FIN', csbNivelTrazaApi);        

    nucantec := 0;
    FOR rg4 IN cuestcomp(rg.sesunuse) LOOP
        nucantec := nucantec + 1;
        IF nucantec = 1 THEN
            nuecid1 := rg4.component_id;
            nueces1 := rg4.component_status_id;
        ELSIF nucantec = 2 THEN
            nuecid2 := rg4.component_id;
            nueces2 := rg4.component_status_id;
        END IF;
    END LOOP;
    pkg_traza.trace(csbMetodo ||' cursor cuestcomp INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' component_id_1: ' || nuecid1||', component_status_id: ' || nueces1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' component_id_2: ' || nuecid2||', component_status_id: ' || nueces2, csbNivelTrazaApi);  
    pkg_traza.trace(csbMetodo ||' cursor cuestcomp FIN', csbNivelTrazaApi); 

    FOR rg5 IN cuultactsusp (rg.suspen_ord_act_id) LOOP
        nuorultactsusp := rg5.order_id;
        nuacultactsusp := rg5.order_activity_id;
        nuttultactsusp := rg5.task_type_id;
    END LOOP;
    pkg_traza.trace(csbMetodo ||' cursor cuultactsusp INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' order_id: ' || nuorultactsusp||', order_activity_id: ' || nuacultactsusp, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' task_type_id: ' || nuttultactsusp , csbNivelTrazaApi);  
    pkg_traza.trace(csbMetodo ||' cursor cuultactsusp FIN', csbNivelTrazaApi);

    -- ult act de susp de RP
    OPEN cuultactsusprp(rg.sesunuse);
    FETCH cuultactsusprp INTO nuultactsusprp;
    IF cuultactsusprp%notfound THEN
    nuultactsusprp := NULL;
    END IF;
    CLOSE cuultactsusprp;
    pkg_traza.trace(csbMetodo ||' nuultactsusprp: ' || nuultactsusprp, csbNivelTrazaApi);

    -- ult act de susp de Cartera
    OPEN cuultactsuspca(rg.sesunuse);
    FETCH cuultactsuspca INTO nuultactsuspca;
    IF cuultactsuspca%notfound THEN
    nuultactsuspca := NULL;
    END IF;
    CLOSE cuultactsuspca;
    pkg_traza.trace(csbMetodo ||' nuultactsuspca: ' || nuultactsuspca, csbNivelTrazaApi);    

    nucantord := 0;
    FOR rg6 IN cuultordenes(rg.sesunuse) LOOP
        nucantord := nucantord + 1;
        IF nucantord = 1 THEN
            nuororden1 := rg6.order_id;
            nuttorden1 := rg6.task_type_id;
            nuosorden1 := rg6.order_status_id;
            dtfcorden1 := rg6.created_date;
            dtflorden1 := rg6.legalization_date;
        ELSIF nucantord = 2 THEN
            nuororden2 := rg6.order_id;
            nuttorden2 := rg6.task_type_id;
            nuosorden2 := rg6.order_status_id;
            dtfcorden2 := rg6.created_date;
            dtflorden2 := rg6.legalization_date;
        ELSIF nucantord = 3 THEN
            nuororden3 := rg6.order_id;
            nuttorden3 := rg6.task_type_id;
            nuosorden3 := rg6.order_status_id;
            dtfcorden3 := rg6.created_date;
            dtflorden3 := rg6.legalization_date;
        ELSIF nucantord = 4 THEN
            nuororden4 := rg6.order_id;
            nuttorden4 := rg6.task_type_id;
            nuosorden4 := rg6.order_status_id;
            dtfcorden4 := rg6.created_date;
            dtflorden4 := rg6.legalization_date;
        ELSE
            EXIT;
        END IF;
    END LOOP;

    pkg_traza.trace(csbMetodo ||' cursor cuultordenes INICIO', csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_id_1: ' || nuororden1||', task_type_id_1: ' || nuttorden1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_status_id_1: ' || nuosorden1||', created_date_1: ' || dtfcorden1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_1: ' || dtflorden1 , csbNivelTrazaApi);
    --
    pkg_traza.trace(csbMetodo ||' order_id_2: ' || nuororden2||', task_type_id_2: ' || nuttorden2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_status_id_2: ' || nuosorden2||', created_date_2: ' || dtfcorden2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_2: ' || dtflorden2 , csbNivelTrazaApi);
    --
    pkg_traza.trace(csbMetodo ||' order_id_3: ' || nuororden3||', task_type_id_3: ' || nuttorden3, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_status_id_3: ' || nuosorden3||', created_date_3: ' || dtfcorden3, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_3: ' || dtflorden3 , csbNivelTrazaApi);
    --
    pkg_traza.trace(csbMetodo ||' order_id_4: ' || nuororden4||', task_type_id_4: ' || nuttorden4, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_status_id_4: ' || nuosorden4||', created_date_4: ' || dtfcorden4, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_4: ' || dtflorden4 , csbNivelTrazaApi);         
    pkg_traza.trace(csbMetodo ||' cursor cuultordenes FIN', csbNivelTrazaApi);

    nucantsus := 0;
    FOR rg7 IN cuultsuspcone(rg.sesunuse) LOOP
        nucantsus := nucantsus + 1;
        IF nucantsus = 1 THEN
            nuorsusp1 := rg7.suconuor;
            nutpsusp1 := rg7.sucotipo;
            nufosusp1 := rg7.sucofeor;
            nufasusp1 := rg7.sucofeat;
        ELSIF nucantsus = 2 THEN
            nuorsusp2 := rg7.suconuor;
            nutpsusp2 := rg7.sucotipo;
            nufosusp2 := rg7.sucofeor;
            nufasusp2 := rg7.sucofeat;
        ELSE
            EXIT;
        END IF;
    END LOOP;
    pkg_traza.trace(csbMetodo ||' cursor cuultsuspcone INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' suconuor_1: ' || nuorsusp1||', sucotipo_1: ' || nutpsusp1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' sucofeor_1: ' || nufosusp1||', sucofeat_1: ' || nufasusp1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_1: ' || dtflorden1 , csbNivelTrazaApi);
    --
    pkg_traza.trace(csbMetodo ||' suconuor_2: ' || nuorsusp2||', sucotipo_2: ' || nutpsusp2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' sucofeor_2: ' || nufosusp2||', sucofeat_2: ' || nufasusp2, csbNivelTrazaApi); 
    pkg_traza.trace(csbMetodo ||' cursor cuultsuspcone FIN', csbNivelTrazaApi); 

    nucantsolrec := 0;
    FOR rg8 IN cusolirecdet(rg.sesunuse) LOOP
        nucantsolrec := nucantsolrec + 1;
        IF nucantsolrec = 1 THEN
            nusorec := rg8.package_id;
            nuorrec := rg8.order_id;
            nuttrec := rg8.task_type_id;
            nueorec := rg8.order_status_id;
        ELSE
            EXIT;
        END IF;
    END LOOP;
    pkg_traza.trace(csbMetodo ||' cursor cusolirecdet INICIO', csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' package_id: ' || nusorec||', order_id: ' || nuorrec, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' task_type_id: ' || nuttrec||', order_status_id: ' || nueorec, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' cursor cusolirecdet FIN', csbNivelTrazaApi);

    -- halla descripciones de estados de producto, componente y de corte
    OPEN cuEstProd(rg.product_status_id);
    FETCH cuEstProd INTO sbestprod;
    CLOSE cuEstProd;
    pkg_traza.trace(csbMetodo ||' sbestprod: ' || sbestprod , csbNivelTrazaApi);

    OPEN cuEstCorte(rg.sesuesco);
    FETCH cuEstCorte INTO sbestcorte;
    CLOSE cuEstCorte;
    pkg_traza.trace(csbMetodo ||' sbestcorte: ' || sbestcorte , csbNivelTrazaApi);     

    IF nueces1 IS NOT NULL THEN
        OPEN cuEstComponente(nueces1);
        FETCH cuEstComponente INTO est_componente_1;
        CLOSE cuEstComponente;
        pkg_traza.trace(csbMetodo ||' est_componente_1: ' || est_componente_1 , csbNivelTrazaApi);         
    END IF;

    IF nueces2 IS NOT NULL THEN
        OPEN cuEstComponente(nueces2);
        FETCH cuEstComponente INTO est_componente_2;
        CLOSE cuEstComponente;
        pkg_traza.trace(csbMetodo ||' est_componente_2: ' || est_componente_2 , csbNivelTrazaApi);         
    END IF;

    -- halla tipo de trabajo de la ultima actividad de suspension
    IF nuttultactsusp IS NULL THEN
        ult_act_susp := NULL;
    ELSE
        OPEN cuUltActSusp2(nuttultactsusp);
        FETCH cuUltActSusp2 INTO ult_act_susp;
        CLOSE cuUltActSusp2; 
    END IF;
    pkg_traza.trace(csbMetodo ||' ult_act_susp: ' || ult_act_susp , csbNivelTrazaApi);

    -- Arma datos de las ordenes
    orden_1 := armadatosorden(nuororden1, nuttorden1, nuosorden1, dtfcorden1, dtflorden1);
    pkg_traza.trace(csbMetodo ||' orden_1: ' || orden_1 , csbNivelTrazaApi);

    orden_2 := armadatosorden(nuororden2, nuttorden2, nuosorden2, dtfcorden2, dtflorden2);
    pkg_traza.trace(csbMetodo ||' orden_2: ' || orden_2 , csbNivelTrazaApi);

    orden_3 := armadatosorden(nuororden3, nuttorden3, nuosorden3, dtfcorden3, dtflorden3);
    pkg_traza.trace(csbMetodo ||' orden_3: ' || orden_3 , csbNivelTrazaApi);

    orden_4 := armadatosorden(nuororden4, nuttorden4, nuosorden4, dtfcorden4, dtflorden4);
    pkg_traza.trace(csbMetodo ||' orden_4: ' || orden_4 , csbNivelTrazaApi);

    -- Halla el tipo de suspensiion (RP o Cartera) y evalua si hay datos inconsistentes y si es asi los ingresa en la tabla
    sbtipoulacsusp := hallatipoultactsusp(ult_act_susp);
    pkg_traza.trace(csbMetodo ||' sbtipoulacsusp: ' || sbtipoulacsusp , csbNivelTrazaApi);


    insertareg;
    nuerror := nuerror + 1;

    IF MOD(nucont,50) = 0 THEN
        pkg_estaproc.practualizaestaproc(sbNameProceso, 'Error', 'Analisis ' || nutipo || ' Van leidos ' || nucont || ' . Con datos inconsistentes: ' || nuerror);
    END IF;

    IF MOD(nuerror,500) = 0 THEN
        COMMIT;
    END IF;

    END LOOP;

    COMMIT;

    pkg_estaproc.practualizaestaproc(sbNameProceso, 'Ok', 'Analisis ' || nutipo || ' Leidos ' || nucont || ' . Con datos inconsistentes: ' || nuerror);
    osbmsgerror := NULL;
    pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN);
    RETURN (0 );

EXCEPTION
    WHEN pkg_Error.controlled_error THEN 
         pkg_Error.getError(nuerror, osbmsgerror);
         pkg_traza.trace(csbMetodo ||' osbmsgerror: ' || osbmsgerror, csbNivelTrazaApi);
         pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN_ERC);      
         pkg_estaproc.practualizaestaproc(sbNameProceso, 'error', osbmsgerror||' - '||dbms_utility.format_error_backtrace);
         RETURN -1;
    WHEN OTHERS THEN  
         pkg_Error.setError;
         pkg_Error.getError(nuerror, osbmsgerror);
         pkg_traza.trace(csbMetodo ||' osbmsgerror: ' || osbmsgerror, csbNivelTrazaApi);
         pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN_ERR);
         pkg_estaproc.practualizaestaproc(sbNameProceso, 'error', osbmsgerror||' - '||dbms_utility.format_error_backtrace);
         RETURN -1;
END fnuanalisissuspcone_3;


FUNCTION  FNUANALISISSUSPCONE_4 (sbnameproceso IN VARCHAR2, osbmsgerror OUT VARCHAR2) RETURN NUMBER IS
  /*******************************************************************
    Busca los productos con est producto susp con
    numero de suspensiones por componentes activas diferente a 2

    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas
                                          Se reemplaza dald_parameter.fsbgetvalue_chain por pkg_bcld_parameter.fsbobtienevalorcadena
                                          Se retira código comentariado
                                          Se retira esquema OPEN antepuesto a pr_comp_suspension, pr_prod_suspension, pr_component, or_order_activity, or_order_status,
                                          or_order, or_task_type, ge_causal, ge_class_causal, suspcone, ps_package_type, mo_motive
                                          Se reemplaza ldc_boutilities.splitstrings por regexp_substr
                                          Se reemplaza SELECT-INTO por cursor cuEstProd, cuEstCorte, cuEstComponente, cuUltActSusp2
                                          Se reemplaza ldc_proactualizaestaprog por pkg_estaproc.practualizaestaproc
                                          Se añade como parametro de entrada el Nombre del proceso
                                          Se ajusta bloque de exception según pautas técnicas
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'fnuanalisissuspcone_4';
    csbNivelTrazaApi    CONSTANT NUMBER(2)        := pkg_traza.cnuNivelTrzApi;

    nuerror             NUMBER := 0;
    nutipo              NUMBER := 4;
    sbtipoulacsusp      VARCHAR2(200);
    sbttsuspca          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_CART_AJSUSPCONE');
    sbttsusprp          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_RP_AJSUSPCONE');
    sbttsuspad          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_ADM_AJSUSPCONE');
    sbttsuspvo          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_VOL_AJSUSPCONE');
    sbttreco            VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_RECO_AJSUSPCONE');
    sbttsusp            VARCHAR2(2000);
    sbttsuspreco        VARCHAR2(2000);

    CURSOR cuproductos IS
    SELECT sr.sesususc, sr.sesunuse, sr.sesuserv, sr.sesucicl, p.suspen_ord_act_id, sr.sesuesco, p.product_status_id
      FROM pr_product p, servsusc sr
     WHERE product_id= sr.sesunuse
       AND p.product_status_id = 2
       AND p.product_id IN (SELECT co.product_id
                              FROM pr_comp_suspension ps, pr_component co
                             WHERE ps.active = 'Y'
                               AND ps.component_id = co.component_id
                               AND co.product_id = p.product_id
                             GROUP BY co.product_id
                             HAVING COUNT(1) != 2);


    CURSOR cususpactiprod (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.prod_suspension_id, P.product_id, P.suspension_type_id, P.register_date, P.aplication_date, P.inactive_date, P.active
      FROM pr_prod_suspension P
     WHERE P.product_id = nunuse
       AND P.active = 'Y'
    ORDER BY P.register_date;

    CURSOR cususpacticomp (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.*
      FROM pr_comp_suspension P
      WHERE P.component_id IN (SELECT cp.component_id
                                 FROM pr_component cp
                                WHERE cp.product_id = nunuse)
       AND P.active = 'Y'
     ORDER BY P.register_date, P.component_id;

    CURSOR cuestcomp (nunuse servsusc.sesunuse%TYPE) IS
    SELECT cp.product_id, cp.component_id, cp.component_type_id, cp.component_status_id
      FROM pr_component cp
     WHERE cp.product_id = nunuse
       AND cp.component_status_id != 9
     ORDER BY cp.component_id;

    CURSOR cuultactsusp (nuordact or_order_activity.order_activity_id%TYPE) IS
    SELECT O.order_id, A.order_activity_id,  O.task_type_id, tt.DESCRIPTION desctt, O.created_date, O.legalization_date, O.order_status_id,
           (SELECT os.DESCRIPTION FROM or_order_status os WHERE os.order_status_id=O.order_status_id) descestaor,
            O.causal_id || ' - '  || gc.DESCRIPTION causal, CC.class_causal_id, CC.DESCRIPTION tipo_causal
      FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                      LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                      LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                      LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.order_activity_id = nuordact;

    CURSOR cuultactsusprp(nunuse servsusc.sesunuse%TYPE) IS
     SELECT A.order_activity_id
      FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                      LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                      LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                      LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.product_id = nunuse
      AND O.order_status_id = 8
      AND CC.class_causal_id = 1
      AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsusprp, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsusprp, '[^|]+', 1, LEVEL) IS NOT NULL)
    ORDER BY O.legalization_date DESC;

    CURSOR cuultactsuspca(nunuse servsusc.sesunuse%TYPE) IS
     SELECT A.order_activity_id
      FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                      LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                      LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                      LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.product_id = nunuse 
      AND O.order_status_id = 8
      AND CC.class_causal_id = 1
      AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsuspca, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsuspca, '[^|]+', 1, LEVEL) IS NOT NULL) 
    ORDER BY O.legalization_date DESC;

    CURSOR cuultordenes (nunuse servsusc.sesunuse%TYPE) IS
    SELECT O.order_id, A.package_id, P.motive_status_id, A.order_activity_id,  O.task_type_id, tt.DESCRIPTION desctt,
           O.created_date, O.legalization_date, O.order_status_id,
           (SELECT os.DESCRIPTION FROM or_order_status os WHERE os.order_status_id=O.order_status_id) descestaor,
            O.causal_id || ' - '  || gc.DESCRIPTION causal, CC.class_causal_id, CC.DESCRIPTION tipo_causal
      FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                      LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                      LEFT OUTER JOIN mo_packages P ON (A.package_id = P.package_id)
                      LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                      LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.product_id = nunuse 
    AND O.order_status_id = 8
    AND CC.class_causal_id = 1
    AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsuspreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsuspreco, '[^|]+', 1, LEVEL) IS NOT NULL)
    ORDER BY created_date DESC;

    CURSOR cuultsuspcone (nunuse servsusc.sesunuse%TYPE) IS
    SELECT S.suconuor, S.sucotipo, S.sucofeor, S.sucofeat
      FROM suspcone S
     WHERE S.suconuse = nunuse
       AND S.sucotipo != 'A'
     ORDER BY S.sucofeor DESC;

    CURSOR cusolirecdet (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.package_id, O.order_id, O.task_type_id, O.order_status_id
      FROM mo_packages P LEFT OUTER JOIN ps_package_type pt ON (pt.package_type_id=P.package_type_id)
                         LEFT OUTER JOIN or_order_activity A ON (A.package_id=P.package_id)
                         LEFT OUTER JOIN or_order O ON (O.order_id = A.order_id)
                         LEFT OUTER JOIN mo_motive M ON (M.package_id=P.package_id)
     WHERE M.product_id=nunuse
       AND P.motive_status_id = 13
       AND O.order_status_id = 8 --  > 5
       AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttreco, '[^|]+', 1, LEVEL) IS NOT NULL) 
    UNION
    SELECT P.package_id,  O.order_id, O.task_type_id, O.order_status_id
      FROM mo_packages P LEFT OUTER JOIN ps_package_type pt ON (pt.package_type_id=P.package_type_id)
                         LEFT OUTER JOIN or_order_activity A ON (A.package_id=P.package_id)
                         LEFT OUTER JOIN or_order O ON (O.order_id = A.order_id)
                         LEFT OUTER JOIN mo_motive M ON (M.package_id=P.package_id)
    WHERE M.product_id=nunuse
    AND P.motive_status_id = 13
    AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttreco, '[^|]+', 1, LEVEL) IS NOT NULL) 
    AND O.order_id IS NULL;

    CURSOR cuEstProd(p_product_status_id pr_product.product_status_id%TYPE)
    IS 
    SELECT ps.product_status_id || ' - ' || ps.description
      FROM ps_product_status ps
     WHERE ps.product_status_id = p_product_status_id; 

    CURSOR cuEstCorte(p_sesuesco servsusc.sesuesco%TYPE)
    IS 
    SELECT escocodi || ' - ' || escodesc 
      FROM estacort e 
     WHERE escocodi = p_sesuesco;      

    CURSOR cuEstComponente( p_product_status_id pr_product.product_status_id%TYPE )
    IS          
    SELECT ps.product_status_id || ' - ' || ps.DESCRIPTION  
      FROM ps_product_status ps 
     WHERE ps.product_status_id = p_product_status_id; 

    CURSOR cuUltActSusp2( p_task_type_id or_task_type.task_type_id%TYPE )
    IS
    SELECT tt.task_type_id || ' - ' || tt.DESCRIPTION 
      FROM or_task_type tt 
     WHERE tt.task_type_id = p_task_type_id; 

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTrazaApi, csbInicio);
    pkg_error.prInicializaError(nuerror, osbmsgerror);
    pkg_traza.trace(csbMetodo ||' nutipo: ' || nutipo, csbNivelTrazaApi);

    nutipoanalisis := nutipo;
    pkg_traza.trace(csbMetodo ||' nutipoanalisis: ' || nutipoanalisis, csbNivelTrazaApi);

    sbttsusp := sbttsuspca || '|' || sbttsusprp || '|' || sbttsuspad || '|' || sbttsuspvo;
    pkg_traza.trace(csbMetodo ||' sbttsusp: ' || sbttsusp, csbNivelTrazaApi);

    sbttsuspreco := sbttsusp || '|' || sbttreco;
    pkg_traza.trace(csbMetodo ||' sbttsuspreco: ' || sbttsuspreco, csbNivelTrazaApi);

    FOR rg IN cuproductos LOOP
    nucont := nucont + 1;
    -- limpia variables

    sbestprod   := NULL; sbestcorte := NULL; ult_act_susp := NULL; est_componente_1 := NULL; est_componente_2 := NULL; orden_1        := NULL; orden_2 := NULL;
    orden_3     := NULL; orden_4    := NULL; nucantps     := 0;    nucantcs         := 0;    nucantec         := 0;    nucantord      :=0;     nucantsus      :=0;     nucantsolrec   :=0;     nupsid1  := NULL; nupsst1 := NULL; dtpsad1 := NULL;
    dtpsid1     := NULL; nupsid2    := NULL; nupsst2      := NULL; dtpsad2          := NULL; dtpsid2          := NULL; nucsid1        := NULL; nucsco1        := NULL; nucsst1        := NULL; dtcsad1  := NULL;
    dtcsid1     := NULL; nucsid2    := NULL; nucsco2      := NULL; nucsst2          := NULL; dtcsad2          := NULL; dtcsid2        := NULL; nucsid3        := NULL; nucsco3        := NULL; nucsst3  := NULL;
    dtcsad3     := NULL; dtcsid3    := NULL;  nucsid4     := NULL; nucsco4          := NULL; nucsst4          := NULL; dtcsad4        := NULL; dtcsid4        := NULL;
    nuecid1     := NULL; nueces1    := NULL; nuecid2      := NULL; nueces2          := NULL; nuorultactsusp   := NULL; nuttultactsusp := NULL; nuultactsusprp := NULL; nuororden1     := NULL;
    nuttorden1  := NULL; nuosorden1 := NULL; nuororden2   := NULL; nuttorden2       := NULL; nuosorden2       := NULL; nuororden3     := NULL; nuttorden3     := NULL; nuosorden3     := NULL;
    nuororden4  := NULL; nuttorden4 := NULL; nuosorden4   := NULL; nuorsusp1        := NULL; nutpsusp1        := NULL; nufosusp1      := NULL; nufasusp1      := NULL; nuorsusp2      := NULL;
    dtfcorden1  := NULL; dtflorden1 := NULL; dtfcorden2   := NULL; dtflorden2       := NULL; dtfcorden3       := NULL; dtflorden3     := NULL; dtfcorden4     := NULL; dtflorden4     := NULL;
    nutpsusp2   := NULL; nufosusp2  := NULL; nufasusp2    := NULL; nusorec          := NULL; nuorrec          := NULL; nuttrec        := NULL; nueorec        := NULL; sbsuspcone1    := NULL; sbsuspcone2  := NULL;
    nuacultactsusp := NULL;  nuultactsuspca:= NULL;
    nuproducto := rg.sesunuse;
    nuprodstat := rg.product_status_id;
    nusesuesco := rg.sesuesco;    

    pkg_traza.trace(csbMetodo ||' nuproducto: ' || nuproducto, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' nuprodstat: ' || nuprodstat, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' nusesuesco: ' || nusesuesco, csbNivelTrazaApi);

    -- busca datos
    nucantps := 0;
    FOR rg2 IN cususpactiprod(rg.sesunuse) LOOP
        nucantps := nucantps + 1;
        IF nucantps = 1 THEN
            nupsid1 := rg2.prod_suspension_id;
            nupsst1 := rg2.suspension_type_id;
            dtpsad1 := rg2.aplication_date;
            dtpsid1 := rg2.inactive_date;
        ELSIF nucantps = 2 THEN
            nupsid2 := rg2.prod_suspension_id;
            nupsst2 := rg2.suspension_type_id;
            dtpsad2 := rg2.aplication_date;
            dtpsid2 := rg2.inactive_date;
        END IF;
    END LOOP;

    pkg_traza.trace(csbMetodo ||' cursor cususpactiprod INICIO', csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' prod_suspension_id_1: ' || nupsid1||', suspension_type_id_1: ' || nupsst1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' aplication_date_1: ' || dtpsad1||', inactive_date_1: ' || dtpsid1, csbNivelTrazaApi);     
    pkg_traza.trace(csbMetodo ||' prod_suspension_id_2: ' || nupsid2||', suspension_type_id_2: ' || nupsst2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' aplication_date_2: ' || dtpsad2||', inactive_date_2: ' || dtpsid2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' cursor cususpactiprod FIN', csbNivelTrazaApi);    

    nucantcs := 0;
    FOR rg3 IN cususpacticomp(rg.sesunuse) LOOP
        nucantcs := nucantcs + 1;
        IF nucantcs = 1 THEN
          nucsid1 := rg3.comp_suspension_id;
          nucsco1 := rg3.component_id;
          nucsst1 := rg3.suspension_type_id;
          dtcsad1 := rg3.aplication_date;
          dtcsid1 := rg3.inactive_date;
        ELSIF nucantcs = 2 THEN
          nucsid2 := rg3.comp_suspension_id;
          nucsco2 := rg3.component_id;
          nucsst2 := rg3.suspension_type_id;
          dtcsad2 := rg3.aplication_date;
          dtcsid2 := rg3.inactive_date;
        ELSIF nucantcs = 3 THEN
          nucsid3 := rg3.comp_suspension_id;
          nucsco3 := rg3.component_id;
          nucsst3 := rg3.suspension_type_id;
          dtcsad3 := rg3.aplication_date;
          dtcsid3 := rg3.inactive_date;
        ELSIF nucantcs = 4 THEN
          nucsid4 := rg3.comp_suspension_id;
          nucsco4 := rg3.component_id;
          nucsst4 := rg3.suspension_type_id;
          dtcsad4 := rg3.aplication_date;
          dtcsid4 := rg3.inactive_date;
        END IF;
    END LOOP;
        pkg_traza.trace(csbMetodo ||' cursor cususpacticomp INICIO', csbNivelTrazaApi);          
        pkg_traza.trace(csbMetodo ||' comp_suspension_id_1: ' || nucsid1||', component_id_1: ' || nucsco1, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' suspension_type_id_1: ' || nucsst1||', aplication_date_1: ' || dtcsad1, csbNivelTrazaApi);     
        pkg_traza.trace(csbMetodo ||' inactive_date_1: ' || dtcsid1, csbNivelTrazaApi); 

        pkg_traza.trace(csbMetodo ||' comp_suspension_id_2: ' || nucsid2||', component_id_2: ' || nucsco2, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' suspension_type_id_2: ' || nucsst2||', aplication_date_2: ' || dtcsad2, csbNivelTrazaApi);     
        pkg_traza.trace(csbMetodo ||' inactive_date_2: ' || dtcsid2, csbNivelTrazaApi);

        pkg_traza.trace(csbMetodo ||' comp_suspension_id_3: ' || nucsid3||', component_id_3: ' || nucsco3, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' suspension_type_id_3: ' || nucsst3||', aplication_date_3: ' || dtcsad3, csbNivelTrazaApi);     
        pkg_traza.trace(csbMetodo ||' inactive_date_3: ' || dtcsid3, csbNivelTrazaApi); 

        pkg_traza.trace(csbMetodo ||' comp_suspension_id_4: ' || nucsid4||', component_id_4: ' || nucsco4, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' suspension_type_id_4: ' || nucsst4||', aplication_date_4: ' || dtcsad4, csbNivelTrazaApi);     
        pkg_traza.trace(csbMetodo ||' inactive_date_4: ' || dtcsid4, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' cursor cususpacticomp FIN', csbNivelTrazaApi);      

    nucantec := 0;
    FOR rg4 IN cuestcomp(rg.sesunuse) LOOP
     nucantec := nucantec + 1;
     IF nucantec = 1 THEN
       nuecid1 := rg4.component_id;
       nueces1 := rg4.component_status_id;
     ELSIF nucantec = 2 THEN
       nuecid2 := rg4.component_id;
       nueces2 := rg4.component_status_id;
     END IF;
    END LOOP;

    pkg_traza.trace(csbMetodo ||' cursor cuestcomp INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' component_id_1: ' || nuecid1||', component_status_id: ' || nueces1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' component_id_2: ' || nuecid2||', component_status_id: ' || nueces2, csbNivelTrazaApi);  
    pkg_traza.trace(csbMetodo ||' cursor cuestcomp FIN', csbNivelTrazaApi);

    FOR rg5 IN cuultactsusp (rg.suspen_ord_act_id) LOOP
     nuorultactsusp := rg5.order_id;
     nuacultactsusp := rg5.order_activity_id;
     nuttultactsusp := rg5.task_type_id;
    END LOOP;

    pkg_traza.trace(csbMetodo ||'cursor cuultactsusp INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' order_id: ' || nuorultactsusp||', order_activity_id: ' || nuacultactsusp, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' task_type_id: ' || nuttultactsusp , csbNivelTrazaApi);  
    pkg_traza.trace(csbMetodo ||'cursor cuultactsusp FIN', csbNivelTrazaApi);

    -- ult act de susp de RP
    OPEN cuultactsusprp(rg.sesunuse);
    FETCH cuultactsusprp INTO nuultactsusprp;
        IF cuultactsusprp%notfound THEN
            nuultactsusprp := NULL;
        END IF;
    CLOSE cuultactsusprp;
    pkg_traza.trace(csbMetodo ||' nuultactsusprp: ' || nuultactsusprp, csbNivelTrazaApi);

    -- ult act de susp de Cartera
    OPEN cuultactsuspca(rg.sesunuse);
    FETCH cuultactsuspca INTO nuultactsuspca;
        IF cuultactsuspca%notfound THEN
            nuultactsuspca := NULL;
        END IF;
    CLOSE cuultactsuspca;
    pkg_traza.trace(csbMetodo ||' nuultactsuspca: ' || nuultactsuspca, csbNivelTrazaApi); 

    nucantord := 0;
    FOR rg6 IN cuultordenes(rg.sesunuse) LOOP
        nucantord := nucantord + 1;
        IF nucantord = 1 THEN
          nuororden1 := rg6.order_id;
          nuttorden1 := rg6.task_type_id;
          nuosorden1 := rg6.order_status_id;
          dtfcorden1 := rg6.created_date;
          dtflorden1 := rg6.legalization_date;
        ELSIF nucantord = 2 THEN
          nuororden2 := rg6.order_id;
          nuttorden2 := rg6.task_type_id;
          nuosorden2 := rg6.order_status_id;
          dtfcorden2 := rg6.created_date;
          dtflorden2 := rg6.legalization_date;
        ELSIF nucantord = 3 THEN
          nuororden3 := rg6.order_id;
          nuttorden3 := rg6.task_type_id;
          nuosorden3 := rg6.order_status_id;
          dtfcorden3 := rg6.created_date;
          dtflorden3 := rg6.legalization_date;
        ELSIF nucantord = 4 THEN
          nuororden4 := rg6.order_id;
          nuttorden4 := rg6.task_type_id;
          nuosorden4 := rg6.order_status_id;
          dtfcorden4 := rg6.created_date;
          dtflorden4 := rg6.legalization_date;
        ELSE
          EXIT;
        END IF;
    END LOOP;

    pkg_traza.trace(csbMetodo ||' cursor cuultordenes INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' order_id_1: ' || nuororden1||', task_type_id_1: ' || nuttorden1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_status_id_1: ' || nuosorden1||', created_date_1: ' || dtfcorden1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_1: ' || dtflorden1 , csbNivelTrazaApi);
    --
    pkg_traza.trace(csbMetodo ||' order_id_2: ' || nuororden2||', task_type_id_2: ' || nuttorden2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_status_id_2: ' || nuosorden2||', created_date_2: ' || dtfcorden2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_2: ' || dtflorden2 , csbNivelTrazaApi);
    --
    pkg_traza.trace(csbMetodo ||' order_id_3: ' || nuororden3||', task_type_id_3: ' || nuttorden3, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_status_id_3: ' || nuosorden3||', created_date_3: ' || dtfcorden3, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_3: ' || dtflorden3 , csbNivelTrazaApi); 
    --
    pkg_traza.trace(csbMetodo ||' order_id_4: ' || nuororden4||', task_type_id_4: ' || nuttorden4, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_status_id_4: ' || nuosorden4||', created_date_4: ' || dtfcorden4, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_4: ' || dtflorden4 , csbNivelTrazaApi);         
    pkg_traza.trace(csbMetodo ||' cursor cuultordenes FIN', csbNivelTrazaApi);

    nucantsus := 0;
    FOR rg7 IN cuultsuspcone(rg.sesunuse) LOOP
        nucantsus := nucantsus + 1;
        IF nucantsus = 1 THEN
            nuorsusp1 := rg7.suconuor;
            nutpsusp1 := rg7.sucotipo;
            nufosusp1 := rg7.sucofeor;
            nufasusp1 := rg7.sucofeat;
        ELSIF nucantsus = 2 THEN
            nuorsusp2 := rg7.suconuor;
            nutpsusp2 := rg7.sucotipo;
            nufosusp2 := rg7.sucofeor;
            nufasusp2 := rg7.sucofeat;
        ELSE
            EXIT;
        END IF;
    END LOOP;
    pkg_traza.trace(csbMetodo ||'cursor cuultsuspcone INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' suconuor_1: ' || nuorsusp1||', sucotipo_1: ' || nutpsusp1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' sucofeor_1: ' || nufosusp1||', sucofeat_1: ' || nufasusp1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_1: ' || dtflorden1 , csbNivelTrazaApi);
    --
    pkg_traza.trace(csbMetodo ||' suconuor_2: ' || nuorsusp2||', sucotipo_2: ' || nutpsusp2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' sucofeor_2: ' || nufosusp2||', sucofeat_2: ' || nufasusp2, csbNivelTrazaApi); 
    pkg_traza.trace(csbMetodo ||'cursor cuultsuspcone FIN', csbNivelTrazaApi); 

    nucantsolrec := 0;
    FOR rg8 IN cusolirecdet(rg.sesunuse) LOOP
    nucantsolrec := nucantsolrec + 1;
    IF nucantsolrec = 1 THEN
      nusorec := rg8.package_id;
      nuorrec := rg8.order_id;
      nuttrec := rg8.task_type_id;
      nueorec := rg8.order_status_id;
    ELSE
      EXIT;
    END IF;
    END LOOP;
    pkg_traza.trace(csbMetodo ||' cursor cusolirecdet INICIO', csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' package_id: ' || nusorec||', order_id: ' || nuorrec, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' task_type_id: ' || nuttrec||', order_status_id: ' || nueorec, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' cursor cusolirecdet FIN', csbNivelTrazaApi);

    -- halla descripciones de estados de producto, componente y de corte
    OPEN cuEstProd(rg.product_status_id);
    FETCH cuEstProd INTO sbestprod;
    CLOSE cuEstProd;
    pkg_traza.trace(csbMetodo ||' sbestprod: ' || sbestprod , csbNivelTrazaApi);    

    OPEN cuEstCorte(rg.sesuesco);
    FETCH cuEstCorte INTO sbestcorte;
    CLOSE cuEstCorte;
    pkg_traza.trace(csbMetodo ||' sbestcorte: ' || sbestcorte , csbNivelTrazaApi);     

    IF nueces1 IS NOT NULL THEN
        OPEN cuEstComponente(nueces1);
        FETCH cuEstComponente INTO est_componente_1;
        CLOSE cuEstComponente;
        pkg_traza.trace(csbMetodo ||' est_componente_1: ' || est_componente_1 , csbNivelTrazaApi);  
    END IF;

    IF nueces2 IS NOT NULL THEN
        OPEN cuEstComponente(nueces2);
        FETCH cuEstComponente INTO est_componente_2;
        CLOSE cuEstComponente;
        pkg_traza.trace(csbMetodo ||' est_componente_2: ' || est_componente_2 , csbNivelTrazaApi); 
    END IF;

    -- halla tipo de trabajo de la ultima actividad de suspension
    IF nuttultactsusp IS NULL THEN
        ult_act_susp := NULL;
    ELSE    
        OPEN cuUltActSusp2(nuttultactsusp);
        FETCH cuUltActSusp2 INTO ult_act_susp;
        CLOSE cuUltActSusp2;        
    END IF;
    pkg_traza.trace(csbMetodo ||' ult_act_susp: ' || ult_act_susp , csbNivelTrazaApi);

    -- Arma datos de las ordenes
    orden_1 := armadatosorden(nuororden1, nuttorden1, nuosorden1, dtfcorden1, dtflorden1);
    pkg_traza.trace(csbMetodo ||' orden_1: ' || orden_1 , csbNivelTrazaApi);

    orden_2 := armadatosorden(nuororden2, nuttorden2, nuosorden2, dtfcorden2, dtflorden2);
    pkg_traza.trace(csbMetodo ||' orden_2: ' || orden_2 , csbNivelTrazaApi);

    orden_3 := armadatosorden(nuororden3, nuttorden3, nuosorden3, dtfcorden3, dtflorden3);
    pkg_traza.trace(csbMetodo ||' orden_3: ' || orden_3 , csbNivelTrazaApi);

    orden_4 := armadatosorden(nuororden4, nuttorden4, nuosorden4, dtfcorden4, dtflorden4);
    pkg_traza.trace(csbMetodo ||' orden_4: ' || orden_4 , csbNivelTrazaApi);

    -- Halla el tipo de suspensiion (RP o Cartera) y evalua si hay datos inconsistentes y si es asi los ingresa en la tabla
    sbtipoulacsusp := hallatipoultactsusp(ult_act_susp);
    pkg_traza.trace(csbMetodo ||' sbtipoulacsusp: ' || sbtipoulacsusp , csbNivelTrazaApi);

    insertareg;
    nuerror := nuerror + 1;

    IF MOD(nucont,50) = 0 THEN
        pkg_estaproc.practualizaestaproc(sbNameProceso, 'Error', 'Analisis ' || nutipo || ' Van leidos ' || nucont || ' . Con datos inconsistentes: ' || nuerror);
    END IF;

    IF MOD(nuerror,500) = 0 THEN
        COMMIT;
    END IF;

    END LOOP;

    COMMIT;

    pkg_estaproc.practualizaestaproc(sbNameProceso, 'Ok', 'Analisis ' || nutipo || ' Leidos ' || nucont || ' . Con datos inconsistentes: ' || nuerror);
    osbmsgerror := NULL;
    pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN);
    RETURN (0 );

EXCEPTION
    WHEN pkg_Error.controlled_error THEN 
         pkg_Error.getError(nuerror, osbmsgerror);
         pkg_traza.trace(csbMetodo ||' osbmsgerror: ' || osbmsgerror, csbNivelTrazaApi);
         pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN_ERC);      
         pkg_estaproc.practualizaestaproc(sbNameProceso, 'error', osbmsgerror||' - '||dbms_utility.format_error_backtrace);
         RETURN -1;
    WHEN OTHERS THEN  
         pkg_Error.setError;
         pkg_Error.getError(nuerror, osbmsgerror);
         pkg_traza.trace(csbMetodo ||' osbmsgerror: ' || osbmsgerror, csbNivelTrazaApi);
         pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN_ERR);
         pkg_estaproc.practualizaestaproc(sbNameProceso, 'error', osbmsgerror||' - '||dbms_utility.format_error_backtrace);
         RETURN -1;
END fnuanalisissuspcone_4;

FUNCTION  FNUANALISISSUSPCONE_5 (sbnameproceso IN VARCHAR2, osbmsgerror OUT VARCHAR2) RETURN NUMBER IS
  /*******************************************************************
    Busca los productos con est producto susp con
    numero de suspensiones por componentes activas diferente a 2

    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas
                                          Se reemplaza dald_parameter.fsbgetvalue_chain por pkg_bcld_parameter.fsbobtienevalorcadena
                                          Se retira código comentariado
                                          Se retira esquema OPEN antepuesto a pr_product, servsusc, pr_comp_suspension, pr_prod_suspension, pr_component, or_order_activity, or_order_status,
                                          or_order, or_task_type, ge_causal, ge_class_causal, suspcone, ps_package_type, mo_motive, mo_packages
                                          Se reemplaza ldc_boutilities.splitstrings por regexp_substr
                                          Se reemplaza SELECT-INTO por cursor cuEstProd, cuEstCorte, cuEstComponente, cuUltActSusp2
                                          Se reemplaza ldc_proactualizaestaprog por pkg_estaproc.practualizaestaproc
                                          Se añade como parametro de entrada el Nombre del proceso
                                          Se ajusta bloque de exception según pautas técnicas
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'fnuanalisissuspcone_5';
    csbNivelTrazaApi    CONSTANT NUMBER(2)        := pkg_traza.cnuNivelTrzApi;

    nuerror             NUMBER := 0;
    nutipo              NUMBER := 5;
    nuprod              servsusc.sesunuse%TYPE;
    sbtipoulacsusp      VARCHAR2(200);
    sbttsuspca          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_CART_AJSUSPCONE');
    sbttsusprp          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_RP_AJSUSPCONE');
    sbttsuspad          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_ADM_AJSUSPCONE');
    sbttsuspvo          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_VOL_AJSUSPCONE');
    sbttreco            VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_RECO_AJSUSPCONE');
    sbttsusp            VARCHAR2(2000);
    sbttsuspreco        VARCHAR2(2000);

    CURSOR cuproductos IS
    SELECT sr.sesususc, sr.sesunuse, sr.sesuserv, sr.sesucicl, p.suspen_ord_act_id, sr.sesuesco, p.product_status_id
      FROM pr_product p, servsusc sr
     WHERE p.product_id= sr.sesunuse
       AND p.product_status_id = 2
       AND sr.sesuesco IN (1,2,3,5,6)
       AND NOT EXISTS (SELECT 'x'
                         FROM pr_prod_suspension ps
                        WHERE ps.active = 'Y'
                          AND ps.product_id = p.product_id);


    CURSOR cususpactiprod (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.prod_suspension_id, P.product_id, P.suspension_type_id, P.register_date, P.aplication_date, P.inactive_date, P.active
      FROM pr_prod_suspension P
     WHERE P.product_id = nunuse
       AND P.active = 'Y'
     ORDER BY P.register_date;

    CURSOR cususpacticomp (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.*
      FROM pr_comp_suspension P
     WHERE P.component_id IN (SELECT cp.component_id
                                FROM pr_component cp
                               WHERE cp.product_id = nunuse)
       AND P.active = 'Y'
    ORDER BY P.register_date, P.component_id;

    CURSOR cuestcomp (nunuse servsusc.sesunuse%TYPE) IS
    SELECT cp.product_id, cp.component_id, cp.component_type_id, cp.component_status_id
      FROM pr_component cp
     WHERE cp.product_id = nunuse
       AND cp.component_status_id != 9
     ORDER BY cp.component_id;

    CURSOR cuultactsusp (nuordact or_order_activity.order_activity_id%TYPE) IS
    SELECT O.order_id, A.order_activity_id,  O.task_type_id, tt.DESCRIPTION desctt, O.created_date, O.legalization_date, O.order_status_id,
       (SELECT os.DESCRIPTION FROM or_order_status os WHERE os.order_status_id=O.order_status_id) descestaor,
        O.causal_id || ' - '  || gc.DESCRIPTION causal, CC.class_causal_id,  CC.DESCRIPTION tipo_causal
    FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                    LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                    LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                    LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.order_activity_id = nuordact;

    CURSOR cuultactsusprp(nunuse servsusc.sesunuse%TYPE) IS
    SELECT A.order_activity_id
      FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                      LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                      LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                      LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.product_id = nunuse 
      AND O.order_status_id = 8
      AND CC.class_causal_id = 1
      AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsusprp, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsusprp, '[^|]+', 1, LEVEL) IS NOT NULL) 
    ORDER BY O.legalization_date DESC;

    CURSOR cuultactsuspca(nunuse servsusc.sesunuse%TYPE) IS
    SELECT A.order_activity_id
    FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                    LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                    LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                    LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.product_id = nunuse 
    AND O.order_status_id = 8
    AND CC.class_causal_id = 1
    AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsuspca, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsuspca, '[^|]+', 1, LEVEL) IS NOT NULL) 
    ORDER BY O.legalization_date DESC;

    CURSOR cuultordenes (nunuse servsusc.sesunuse%TYPE) IS
    SELECT O.order_id, A.package_id, P.motive_status_id, A.order_activity_id,  O.task_type_id, tt.DESCRIPTION desctt,
       O.created_date, O.legalization_date, O.order_status_id,
       (SELECT os.DESCRIPTION FROM or_order_status os WHERE os.order_status_id=O.order_status_id) descestaor,
        O.causal_id || ' - '  || gc.DESCRIPTION causal, CC.class_causal_id, CC.DESCRIPTION tipo_causal
    FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                    LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                    LEFT OUTER JOIN mo_packages P ON (A.package_id = P.package_id)
                    LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                    LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.product_id = nunuse
      AND O.order_status_id = 8
      AND CC.class_causal_id = 1
      AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsuspreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsuspreco, '[^|]+', 1, LEVEL) IS NOT NULL ) 
    ORDER BY created_date DESC;

    CURSOR cuultsuspcone (nunuse servsusc.sesunuse%TYPE) IS
    SELECT S.suconuor, S.sucotipo, S.sucofeor, S.sucofeat
      FROM suspcone S
     WHERE S.suconuse = nunuse
       AND S.sucotipo != 'A'
    ORDER BY S.sucofeor DESC;

    CURSOR cusolirecdet (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.package_id,  O.order_id, O.task_type_id, O.order_status_id
    FROM mo_packages P LEFT OUTER JOIN ps_package_type pt ON (pt.package_type_id=P.package_type_id)
                       LEFT OUTER JOIN or_order_activity A ON (A.package_id=P.package_id)
                       LEFT OUTER JOIN or_order O ON (O.order_id = A.order_id)
                       LEFT OUTER JOIN mo_motive M ON (M.package_id=P.package_id)
    WHERE M.product_id=nunuse
    AND P.motive_status_id = 13
    AND O.order_status_id = 8
    AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttreco, '[^|]+', 1, LEVEL) IS NOT NULL)
    UNION
    SELECT P.package_id,  O.order_id, O.task_type_id,  O.order_status_id
    FROM mo_packages P LEFT OUTER JOIN ps_package_type pt ON (pt.package_type_id=P.package_type_id)
                       LEFT OUTER JOIN or_order_activity A ON (A.package_id=P.package_id)
                       LEFT OUTER JOIN or_order O ON (O.order_id = A.order_id)
                       LEFT OUTER JOIN mo_motive M ON (M.package_id=P.package_id)
    WHERE M.product_id=nunuse
    AND P.motive_status_id = 13
    AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttreco, '[^|]+', 1, LEVEL) IS NOT NULL)
    AND O.order_id IS NULL;

    CURSOR cuEstProd(p_product_status_id pr_product.product_status_id%TYPE)
    IS 
    SELECT ps.product_status_id || ' - ' || ps.description
      FROM ps_product_status ps
     WHERE ps.product_status_id = p_product_status_id;

    CURSOR cuEstCorte(p_sesuesco servsusc.sesuesco%TYPE)
    IS 
    SELECT escocodi || ' - ' || escodesc 
      FROM estacort e 
     WHERE escocodi = p_sesuesco;      

    CURSOR cuEstComponente( p_product_status_id pr_product.product_status_id%TYPE )
    IS          
    SELECT ps.product_status_id || ' - ' || ps.DESCRIPTION  
      FROM ps_product_status ps 
     WHERE ps.product_status_id = p_product_status_id; 

    CURSOR cuUltActSusp2( p_task_type_id or_task_type.task_type_id%TYPE )
    IS
    SELECT tt.task_type_id || ' - ' || tt.DESCRIPTION 
      FROM or_task_type tt 
     WHERE tt.task_type_id = p_task_type_id;  

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTrazaApi, csbInicio);
    pkg_error.prInicializaError(nuerror, osbmsgerror);
    pkg_traza.trace(csbMetodo ||' nutipo: ' || nutipo, csbNivelTrazaApi);

    nutipoanalisis := nutipo;
    pkg_traza.trace(csbMetodo ||' nutipoanalisis: ' || nutipoanalisis, csbNivelTrazaApi);

    sbttsusp := sbttsuspca || '|' || sbttsusprp || '|' || sbttsuspad || '|' || sbttsuspvo;
    pkg_traza.trace(csbMetodo ||' sbttsusp: ' || sbttsusp, csbNivelTrazaApi);

    sbttsuspreco := sbttsusp || '|' || sbttreco;
    pkg_traza.trace(csbMetodo ||' sbttsuspreco: ' || sbttsuspreco, csbNivelTrazaApi);

    FOR rg IN cuproductos LOOP
        nuprod := rg.sesunuse;
        nucont := nucont + 1;
    -- limpia variables

    sbestprod   := NULL; sbestcorte := NULL; ult_act_susp := NULL;   est_componente_1 := NULL; est_componente_2 := NULL;    orden_1 := NULL;    orden_2 := NULL;
    orden_3     := NULL; orden_4    := NULL; nucantps       := 0;    nucantcs   := 0;    nucantec   := 0;    nucantord  :=0; nucantsus :=0; nucantsolrec :=0;  nupsid1 := NULL; nupsst1 := NULL; dtpsad1 := NULL;
    dtpsid1     := NULL; nupsid2    := NULL; nupsst2        := NULL; dtpsad2    := NULL; dtpsid2    := NULL; nucsid1    := NULL; nucsco1    := NULL; nucsst1    := NULL; dtcsad1   := NULL;
    dtcsid1     := NULL; nucsid2    := NULL; nucsco2        := NULL; nucsst2    := NULL; dtcsad2    := NULL; dtcsid2    := NULL; nucsid3    := NULL; nucsco3    := NULL; nucsst3   := NULL;
    dtcsad3     := NULL; dtcsid3    := NULL;  nucsid4       := NULL; nucsco4    := NULL; nucsst4    := NULL; dtcsad4    := NULL; dtcsid4    := NULL;
    nuecid1     := NULL; nueces1    := NULL; nuecid2        := NULL; nueces2    := NULL; nuorultactsusp := NULL; nuttultactsusp := NULL; nuultactsusprp := NULL; nuororden1 := NULL;
    nuttorden1  := NULL; nuosorden1 := NULL; nuororden2     := NULL; nuttorden2 := NULL; nuosorden2 := NULL; nuororden3 := NULL; nuttorden3 := NULL; nuosorden3  := NULL;
    nuororden4  := NULL; nuttorden4 := NULL; nuosorden4     := NULL; nuorsusp1  := NULL; nutpsusp1  := NULL; nufosusp1  := NULL; nufasusp1  := NULL; nuorsusp2   := NULL;
    dtfcorden1  := NULL; dtflorden1 := NULL; dtfcorden2     := NULL; dtflorden2 := NULL; dtfcorden3 := NULL; dtflorden3 := NULL; dtfcorden4 := NULL; dtflorden4  := NULL;
    nutpsusp2   := NULL; nufosusp2  := NULL; nufasusp2      := NULL; nusorec    := NULL; nuorrec    := NULL; nuttrec    := NULL; nueorec    := NULL; sbsuspcone1 := NULL; sbsuspcone2  := NULL;
    nuacultactsusp := NULL;  nuultactsuspca:= NULL;
    nuproducto  := rg.sesunuse;
    nuprodstat  := rg.product_status_id;
    nusesuesco  := rg.sesuesco;

    pkg_traza.trace(csbMetodo ||' nuproducto: ' || nuproducto, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' nuprodstat: ' || nuprodstat, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' nusesuesco: ' || nusesuesco, csbNivelTrazaApi);

    -- busca datos
    nucantps := 0;
    FOR rg2 IN cususpactiprod(rg.sesunuse) LOOP
     nucantps := nucantps + 1;
     IF nucantps = 1 THEN
       nupsid1 := rg2.prod_suspension_id;
       nupsst1 := rg2.suspension_type_id;
       dtpsad1 := rg2.aplication_date;
       dtpsid1 := rg2.inactive_date;
     ELSIF nucantps = 2 THEN
       nupsid2 := rg2.prod_suspension_id;
       nupsst2 := rg2.suspension_type_id;
       dtpsad2 := rg2.aplication_date;
       dtpsid2 := rg2.inactive_date;
     END IF;
    END LOOP;
    pkg_traza.trace(csbMetodo ||' cursor cususpactiprod INICIO', csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' prod_suspension_id_1: ' || nupsid1||', suspension_type_id_1: ' || nupsst1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' aplication_date_1: ' || dtpsad1||', inactive_date_1: ' || dtpsid1, csbNivelTrazaApi);     
    pkg_traza.trace(csbMetodo ||' prod_suspension_id_2: ' || nupsid2||', suspension_type_id_2: ' || nupsst2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' aplication_date_2: ' || dtpsad2||', inactive_date_2: ' || dtpsid2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' cursor cususpactiprod FIN', csbNivelTrazaApi); 

    nucantcs := 0;
    FOR rg3 IN cususpacticomp(rg.sesunuse) LOOP
    nucantcs := nucantcs + 1;
    IF nucantcs = 1 THEN
      nucsid1 := rg3.comp_suspension_id;
      nucsco1 := rg3.component_id;
      nucsst1 := rg3.suspension_type_id;
      dtcsad1 := rg3.aplication_date;
      dtcsid1 := rg3.inactive_date;
    ELSIF nucantcs = 2 THEN
      nucsid2 := rg3.comp_suspension_id;
      nucsco2 := rg3.component_id;
      nucsst2 := rg3.suspension_type_id;
      dtcsad2 := rg3.aplication_date;
      dtcsid2 := rg3.inactive_date;
    ELSIF nucantcs = 3 THEN
      nucsid3 := rg3.comp_suspension_id;
      nucsco3 := rg3.component_id;
      nucsst3 := rg3.suspension_type_id;
      dtcsad3 := rg3.aplication_date;
      dtcsid3 := rg3.inactive_date;
    ELSIF nucantcs = 4 THEN
      nucsid4 := rg3.comp_suspension_id;
      nucsco4 := rg3.component_id;
      nucsst4 := rg3.suspension_type_id;
      dtcsad4 := rg3.aplication_date;
      dtcsid4 := rg3.inactive_date;
    END IF;
    END LOOP;

    pkg_traza.trace(csbMetodo ||' cursor cususpacticomp INICIO', csbNivelTrazaApi);          
    pkg_traza.trace(csbMetodo ||' comp_suspension_id_1: ' || nucsid1||', component_id_1: ' || nucsco1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' suspension_type_id_1: ' || nucsst1||', aplication_date_1: ' || dtcsad1, csbNivelTrazaApi);     
    pkg_traza.trace(csbMetodo ||' inactive_date_1: ' || dtcsid1, csbNivelTrazaApi); 

    pkg_traza.trace(csbMetodo ||' comp_suspension_id_2: ' || nucsid2||', component_id_2: ' || nucsco2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' suspension_type_id_2: ' || nucsst2||', aplication_date_2: ' || dtcsad2, csbNivelTrazaApi);     
    pkg_traza.trace(csbMetodo ||' inactive_date_2: ' || dtcsid2, csbNivelTrazaApi);

    pkg_traza.trace(csbMetodo ||' comp_suspension_id_3: ' || nucsid3||', component_id_3: ' || nucsco3, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' suspension_type_id_3: ' || nucsst3||', aplication_date_3: ' || dtcsad3, csbNivelTrazaApi);     
    pkg_traza.trace(csbMetodo ||' inactive_date_3: ' || dtcsid3, csbNivelTrazaApi); 

    pkg_traza.trace(csbMetodo ||' comp_suspension_id_4: ' || nucsid4||', component_id_4: ' || nucsco4, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' suspension_type_id_4: ' || nucsst4||', aplication_date_4: ' || dtcsad4, csbNivelTrazaApi);     
    pkg_traza.trace(csbMetodo ||' inactive_date_4: ' || dtcsid4, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' cursor cususpacticomp FIN', csbNivelTrazaApi);            

    nucantec := 0;
    FOR rg4 IN cuestcomp(rg.sesunuse) LOOP
     nucantec := nucantec + 1;
     IF nucantec = 1 THEN
       nuecid1 := rg4.component_id;
       nueces1 := rg4.component_status_id;
     ELSIF nucantec = 2 THEN
       nuecid2 := rg4.component_id;
       nueces2 := rg4.component_status_id;
     END IF;
    END LOOP;
    pkg_traza.trace(csbMetodo ||' cursor cuestcomp INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' component_id_1: ' || nuecid1||', component_status_id: ' || nueces1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' component_id_2: ' || nuecid2||', component_status_id: ' || nueces2, csbNivelTrazaApi);  
    pkg_traza.trace(csbMetodo ||' cursor cuestcomp FIN', csbNivelTrazaApi);     

    FOR rg5 IN cuultactsusp (rg.suspen_ord_act_id) LOOP
     nuorultactsusp := rg5.order_id;
     nuacultactsusp := rg5.order_activity_id;
     nuttultactsusp := rg5.task_type_id;
    END LOOP;
    pkg_traza.trace(csbMetodo ||'cursor cuultactsusp INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' order_id: ' || nuorultactsusp||', order_activity_id: ' || nuacultactsusp, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' task_type_id: ' || nuttultactsusp , csbNivelTrazaApi);  
    pkg_traza.trace(csbMetodo ||'cursor cuultactsusp FIN', csbNivelTrazaApi);

    -- ult act de susp de RP
    OPEN cuultactsusprp(rg.sesunuse);
    FETCH cuultactsusprp INTO nuultactsusprp;
    IF cuultactsusprp%notfound THEN
    nuultactsusprp := NULL;
    END IF;
    CLOSE cuultactsusprp;
    pkg_traza.trace(csbMetodo ||' nuultactsusprp: ' || nuultactsusprp, csbNivelTrazaApi);

    -- ult act de susp de Cartera
    OPEN cuultactsuspca(rg.sesunuse);
    FETCH cuultactsuspca INTO nuultactsuspca;
    IF cuultactsuspca%notfound THEN
    nuultactsuspca := NULL;
    END IF;
    CLOSE cuultactsuspca;
    pkg_traza.trace(csbMetodo ||' nuultactsuspca: ' || nuultactsuspca, csbNivelTrazaApi);

    nucantord := 0;
    FOR rg6 IN cuultordenes(rg.sesunuse) LOOP
    nucantord := nucantord + 1;
    IF nucantord = 1 THEN
      nuororden1 := rg6.order_id;
      nuttorden1 := rg6.task_type_id;
      nuosorden1 := rg6.order_status_id;
      dtfcorden1 := rg6.created_date;
      dtflorden1 := rg6.legalization_date;
    ELSIF nucantord = 2 THEN
      nuororden2 := rg6.order_id;
      nuttorden2 := rg6.task_type_id;
      nuosorden2 := rg6.order_status_id;
      dtfcorden2 := rg6.created_date;
      dtflorden2 := rg6.legalization_date;
    ELSIF nucantord = 3 THEN
      nuororden3 := rg6.order_id;
      nuttorden3 := rg6.task_type_id;
      nuosorden3 := rg6.order_status_id;
      dtfcorden3 := rg6.created_date;
      dtflorden3 := rg6.legalization_date;
    ELSIF nucantord = 4 THEN
      nuororden4 := rg6.order_id;
      nuttorden4 := rg6.task_type_id;
      nuosorden4 := rg6.order_status_id;
      dtfcorden4 := rg6.created_date;
      dtflorden4 := rg6.legalization_date;
    ELSE
      EXIT;
    END IF;
    END LOOP;

    pkg_traza.trace(csbMetodo ||' cursor cuultordenes INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' order_id_1: ' || nuororden1||', task_type_id_1: ' || nuttorden1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_status_id_1: ' || nuosorden1||', created_date_1: ' || dtfcorden1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_1: ' || dtflorden1 , csbNivelTrazaApi);
    --
    pkg_traza.trace(csbMetodo ||' order_id_2: ' || nuororden2||', task_type_id_2: ' || nuttorden2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_status_id_2: ' || nuosorden2||', created_date_2: ' || dtfcorden2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_2: ' || dtflorden2 , csbNivelTrazaApi);
    --
    pkg_traza.trace(csbMetodo ||' order_id_3: ' || nuororden3||', task_type_id_3: ' || nuttorden3, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_status_id_3: ' || nuosorden3||', created_date_3: ' || dtfcorden3, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_3: ' || dtflorden3 , csbNivelTrazaApi); 
    --
    pkg_traza.trace(csbMetodo ||' order_id_4: ' || nuororden4||', task_type_id_4: ' || nuttorden4, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' order_status_id_4: ' || nuosorden4||', created_date_4: ' || dtfcorden4, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_4: ' || dtflorden4 , csbNivelTrazaApi);         
    pkg_traza.trace(csbMetodo ||' cursor cuultordenes FIN', csbNivelTrazaApi);   

    nucantsus := 0;
    FOR rg7 IN cuultsuspcone(rg.sesunuse) LOOP
     nucantsus := nucantsus + 1;
     IF nucantsus = 1 THEN
       nuorsusp1 := rg7.suconuor;
       nutpsusp1 := rg7.sucotipo;
       nufosusp1 := rg7.sucofeor;
       nufasusp1 := rg7.sucofeat;
     ELSIF nucantsus = 2 THEN
       nuorsusp2 := rg7.suconuor;
       nutpsusp2 := rg7.sucotipo;
       nufosusp2 := rg7.sucofeor;
       nufasusp2 := rg7.sucofeat;
    ELSE
      EXIT;
    END IF;
    END LOOP;

    pkg_traza.trace(csbMetodo ||' cursor cuultsuspcone INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' suconuor_1: ' || nuorsusp1||', sucotipo_1: ' || nutpsusp1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' sucofeor_1: ' || nufosusp1||', sucofeat_1: ' || nufasusp1, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' legalization_date_1: ' || dtflorden1 , csbNivelTrazaApi);
    --
    pkg_traza.trace(csbMetodo ||' suconuor_2: ' || nuorsusp2||', sucotipo_2: ' || nutpsusp2, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' sucofeor_2: ' || nufosusp2||', sucofeat_2: ' || nufasusp2, csbNivelTrazaApi); 
    pkg_traza.trace(csbMetodo ||' cursor cuultsuspcone FIN', csbNivelTrazaApi);

    nucantsolrec := 0;
    FOR rg8 IN cusolirecdet(rg.sesunuse) LOOP
    nucantsolrec := nucantsolrec + 1;
    IF nucantsolrec = 1 THEN
      nusorec := rg8.package_id;
      nuorrec := rg8.order_id;
      nuttrec := rg8.task_type_id;
      nueorec := rg8.order_status_id;
    ELSE
      EXIT;
    END IF;
    END LOOP;
    pkg_traza.trace(csbMetodo ||' cursor cusolirecdet INICIO', csbNivelTrazaApi);        
    pkg_traza.trace(csbMetodo ||' package_id: ' || nusorec||', order_id: ' || nuorrec, csbNivelTrazaApi);
    pkg_traza.trace(csbMetodo ||' task_type_id: ' || nuttrec||', order_status_id: ' || nueorec, csbNivelTrazaApi); 
    pkg_traza.trace(csbMetodo ||' cursor cusolirecdet FIN', csbNivelTrazaApi);

    -- halla descripciones de estados de producto, componente y de corte

    OPEN cuEstProd(rg.product_status_id);
    FETCH cuEstProd INTO sbestprod;
    CLOSE cuEstProd;
    pkg_traza.trace(csbMetodo ||' sbestprod: ' || sbestprod , csbNivelTrazaApi);    


    OPEN cuEstCorte(rg.sesuesco);
    FETCH cuEstCorte INTO sbestcorte;
    CLOSE cuEstCorte;
    pkg_traza.trace(csbMetodo ||' sbestcorte: ' || sbestcorte , csbNivelTrazaApi);    


    IF nueces1 IS NOT NULL THEN
            OPEN cuEstComponente(nueces1);
            FETCH cuEstComponente INTO est_componente_1;
            CLOSE cuEstComponente;
            pkg_traza.trace(csbMetodo ||' est_componente_1: ' || est_componente_1 , csbNivelTrazaApi);        

    END IF;

    IF nueces2 IS NOT NULL THEN
            OPEN cuEstComponente(nueces2);
            FETCH cuEstComponente INTO est_componente_2;
            CLOSE cuEstComponente;
            pkg_traza.trace(csbMetodo ||' est_componente_2: ' || est_componente_2 , csbNivelTrazaApi);        
    END IF;

    -- halla tipo de trabajo de la ultima actividad de suspension
    IF nuttultactsusp IS NULL THEN
        ult_act_susp := NULL;
    ELSE
        OPEN cuUltActSusp2(nuttultactsusp);
        FETCH cuUltActSusp2 INTO ult_act_susp;
        CLOSE cuUltActSusp2;        
    END IF;
    pkg_traza.trace(csbMetodo ||' ult_act_susp: ' || ult_act_susp , csbNivelTrazaApi);

    -- Arma datos de las ordenes
    orden_1 := armadatosorden(nuororden1, nuttorden1, nuosorden1, dtfcorden1, dtflorden1);
    pkg_traza.trace(csbMetodo ||' orden_1: ' || orden_1 , csbNivelTrazaApi);

    orden_2 := armadatosorden(nuororden2, nuttorden2, nuosorden2, dtfcorden2, dtflorden2);
    pkg_traza.trace(csbMetodo ||' orden_2: ' || orden_2 , csbNivelTrazaApi);

    orden_3 := armadatosorden(nuororden3, nuttorden3, nuosorden3, dtfcorden3, dtflorden3);
    pkg_traza.trace(csbMetodo ||' orden_3: ' || orden_3 , csbNivelTrazaApi);

    orden_4 := armadatosorden(nuororden4, nuttorden4, nuosorden4, dtfcorden4, dtflorden4);
    pkg_traza.trace(csbMetodo ||' orden_4: ' || orden_4 , csbNivelTrazaApi);

    -- Halla el tipo de suspensiion (RP o Cartera) y evalua si hay datos inconsistentes y si es asi los ingresa en la tabla
    sbtipoulacsusp := hallatipoultactsusp(ult_act_susp);

    insertareg;
    nuerror := nuerror + 1;

    IF MOD(nucont,50) = 0 THEN
        pkg_estaproc.practualizaestaproc(sbNameProceso, 'Error', 'Analisis ' || nutipo || ' Van leidos ' || nucont || ' . Con datos inconsistentes: ' || nuerror);
    END IF;

    IF MOD(nuerror,500) = 0 THEN
     COMMIT;
    END IF;

    END LOOP;

    COMMIT;

    pkg_estaproc.practualizaestaproc(sbNameProceso, 'Ok', 'Analisis ' || nutipo || ' Leidos ' || nucont || ' . Con datos inconsistentes: ' || nuerror);
    osbmsgerror := NULL;
    pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN);
    RETURN (0 );

EXCEPTION
    WHEN pkg_Error.controlled_error THEN 
         pkg_Error.getError(nuerror, osbmsgerror);
         pkg_traza.trace(csbMetodo ||' osbmsgerror: ' || osbmsgerror, csbNivelTrazaApi);
         pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN_ERC);      
         pkg_estaproc.practualizaestaproc(sbNameProceso, 'error', osbmsgerror||' - '||dbms_utility.format_error_backtrace);
         RETURN -1;
    WHEN OTHERS THEN  
         pkg_Error.setError;
         pkg_Error.getError(nuerror, osbmsgerror);
         pkg_traza.trace(csbMetodo ||' osbmsgerror: ' || osbmsgerror, csbNivelTrazaApi);
         pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN_ERR);
         pkg_estaproc.practualizaestaproc(sbNameProceso, 'error', osbmsgerror||' - '||dbms_utility.format_error_backtrace);
         RETURN -1;
END fnuanalisissuspcone_5;

FUNCTION  FNUANALISISSUSPCONE_PRES (sbnameproceso IN VARCHAR2, osbmsgerror OUT VARCHAR2) RETURN NUMBER IS
  /******************************************************************
    Busca los productos con est producto susp con
    numero de suspensiones por componentes activas diferente a 2

    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    09/04/2021    Horbath                 ca 711 se cambia en cursor cuProductos la obervacion a Subido en vez de
                                          procesado Y cuando se procesen cambiar observacion a Procesado.
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas
                                          Se reemplaza dald_parameter.fsbgetvalue_chain por pkg_bcld_parameter.fsbobtienevalorcadena
                                          Se retira código comentariado
                                          Se retira esquema OPEN antepuesto a pr_product, servsusc, pr_prod_suspension, pr_component, or_order_activity
                                          , or_order_status, or_order, or_task_type, ge_causal, ge_class_causal, mo_packages, suspcone, ps_package_type
                                          Se reemplaza ldc_boutilities.splitstrings por regexp_substr
                                          Se reemplaza SELECT-INTO por cursor cuEstProd, cuEstCorte, cuEstComponente, cuUltActSusp2
                                          Se reemplaza ldc_proactualizaestaprog por pkg_estaproc.practualizaestaproc
                                          Se añade como parametro de entrada el Nombre del proceso
                                          Se retira IF-ENDIF que evalua el fblaplicaentregaxcaso('0000711') para asignar S a la variable sbaplica711. Se deja
                                          pór defecto la asignación a S ya que este aplicaentrega 0000711 se encuentra activo en produccion
                                          Se ajusta bloque de exception según pautas técnicas
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'fnuanalisissuspcone_pres';
    csbNivelTrazaApi    CONSTANT NUMBER(2)        := pkg_traza.cnuNivelTrzApi;

    nuerror             NUMBER := 0;
    nutipo              NUMBER := 99;
    nuprod              servsusc.sesunuse%TYPE;
    sbtipoulacsusp      VARCHAR2(200);
    sbttsuspca          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_CART_AJSUSPCONE');
    sbttsusprp          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_RP_AJSUSPCONE');
    sbttsuspad          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_ADM_AJSUSPCONE');
    sbttsuspvo          VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_SUSP_VOL_AJSUSPCONE');
    sbttreco            VARCHAR2(2000) := pkg_bcld_parameter.fsbobtienevalorcadena('TT_RECO_AJSUSPCONE');
    sbttsusp            VARCHAR2(2000);
    sbttsuspreco        VARCHAR2(2000);

    --INICIO CA 711
    sbaplica711 VARCHAR2(1);
    --FIN CA 711

    CURSOR cuproductos IS
    SELECT sr.sesususc, sr.sesunuse, sr.sesuserv, sr.sesucicl, p.suspen_ord_act_id, sr.sesuesco, p.product_status_id
      FROM pr_product p, servsusc sr, ldc_prod_analisis_suspcone X
     WHERE product_id  = sr.sesunuse 
       AND sr.sesunuse = X.producto
       AND X.observacion = decode(sbaplica711, 'N', 'Procesado', 'Subido');

    CURSOR cususpactiprod (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.prod_suspension_id, P.product_id, P.suspension_type_id, P.register_date, P.aplication_date, P.inactive_date, P.active
      FROM pr_prod_suspension P
     WHERE P.product_id = nunuse
       AND P.active = 'Y'
     ORDER BY P.register_date;

    CURSOR cususpacticomp (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.*
      FROM pr_comp_suspension P
      WHERE P.component_id IN (SELECT cp.component_id
                                 FROM pr_component cp
                                WHERE cp.product_id = nunuse)
       AND p.active = 'Y'
     ORDER BY P.register_date, P.component_id;

    CURSOR cuestcomp (nunuse servsusc.sesunuse%TYPE) IS
    SELECT cp.product_id, cp.component_id, cp.component_type_id, cp.component_status_id
      FROM pr_component cp
     WHERE cp.product_id = nunuse
       AND cp.component_status_id != 9
     ORDER BY cp.component_id;

    CURSOR cuultactsusp (nuordact or_order_activity.order_activity_id%TYPE) IS
    SELECT O.order_id, A.order_activity_id,  O.task_type_id, tt.DESCRIPTION desctt, O.created_date, O.legalization_date, O.order_status_id,
           (SELECT os.DESCRIPTION FROM or_order_status os WHERE os.order_status_id=O.order_status_id) descestaor,
            O.causal_id || ' - '  || gc.DESCRIPTION causal, CC.class_causal_id, CC.DESCRIPTION tipo_causal
      FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                      LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                      LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                      LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.order_activity_id = nuordact;

    CURSOR cuultactsusprp(nunuse servsusc.sesunuse%TYPE) IS
     SELECT A.order_activity_id
       FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                       LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                       LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                       LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.product_id = nunuse 
    AND O.order_status_id = 8
    AND CC.class_causal_id = 1
    AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsusprp, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsusprp, '[^|]+', 1, LEVEL) IS NOT NULL)
    ORDER BY O.legalization_date DESC;

    CURSOR cuultactsuspca(nunuse servsusc.sesunuse%TYPE) IS
     SELECT A.order_activity_id
      FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                      LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                      LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                      LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.product_id = nunuse 
    AND O.order_status_id = 8
    AND CC.class_causal_id = 1
    AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsuspca, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsuspca, '[^|]+', 1, LEVEL) IS NOT NULL)
    ORDER BY O.legalization_date DESC;

    CURSOR cuultordenes (nunuse servsusc.sesunuse%TYPE) IS
    SELECT O.order_id, A.package_id, P.motive_status_id, A.order_activity_id,  O.task_type_id, tt.DESCRIPTION desctt,
           O.created_date, O.legalization_date, O.order_status_id,
           (SELECT os.DESCRIPTION FROM or_order_status os WHERE os.order_status_id=O.order_status_id) descestaor,
            O.causal_id || ' - '  || gc.DESCRIPTION causal, CC.class_causal_id, CC.DESCRIPTION tipo_causal
      FROM or_order O INNER JOIN or_task_type tt ON (tt.task_type_id=O.task_type_id)
                      LEFT OUTER JOIN or_order_activity A ON (O.order_id = A.order_id)
                      LEFT OUTER JOIN mo_packages P ON (A.package_id = P.package_id)
                      LEFT OUTER JOIN ge_causal gc ON (gc.causal_id = O.causal_id)
                      LEFT OUTER JOIN ge_class_causal CC ON (gc.class_causal_id = CC.class_causal_id)
    WHERE A.product_id = nunuse 
    AND O.order_status_id = 8
    AND CC.class_causal_id = 1
    AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttsuspreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttsuspreco, '[^|]+', 1, LEVEL) IS NOT NULL )
    ORDER BY created_date DESC;

    CURSOR cuultsuspcone (nunuse servsusc.sesunuse%TYPE) IS
    SELECT S.suconuor, S.sucotipo, S.sucofeor, S.sucofeat
      FROM suspcone S
     WHERE S.suconuse = nunuse
       AND S.sucotipo != 'A'
     ORDER BY S.sucofeor DESC;

    CURSOR cusolirecdet (nunuse servsusc.sesunuse%TYPE) IS
    SELECT P.package_id,  O.order_id, O.task_type_id, O.order_status_id
      FROM mo_packages P LEFT OUTER JOIN ps_package_type pt ON (pt.package_type_id=P.package_type_id)
                         LEFT OUTER JOIN or_order_activity A ON (A.package_id=P.package_id)
                         LEFT OUTER JOIN or_order O ON (O.order_id = A.order_id)
                         LEFT OUTER JOIN mo_motive M ON (M.package_id=P.package_id)
    WHERE M.product_id=nunuse
    AND P.motive_status_id = 13
    AND O.order_status_id = 8
    AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttreco, '[^|]+', 1, LEVEL) IS NOT NULL)
    UNION
    SELECT P.package_id, O.order_id, O.task_type_id,O.order_status_id
      FROM mo_packages P LEFT OUTER JOIN ps_package_type pt ON (pt.package_type_id=P.package_type_id)
                         LEFT OUTER JOIN or_order_activity A ON (A.package_id=P.package_id)
                         LEFT OUTER JOIN or_order O ON (O.order_id = A.order_id)
                         LEFT OUTER JOIN mo_motive M ON (M.package_id=P.package_id)
    WHERE M.product_id=nunuse
    AND P.motive_status_id = 13
    AND O.task_type_id IN (SELECT (REGEXP_SUBSTR(sbttreco, '[^|]+', 1, LEVEL)) AS COLUMN_VALUE
                               FROM dual
                         CONNECT BY regexp_substr(sbttreco, '[^|]+', 1, LEVEL) IS NOT NULL)
    AND O.order_id IS NULL;

    CURSOR cuEstProd(p_product_status_id pr_product.product_status_id%TYPE)
    IS 
    SELECT ps.product_status_id || ' - ' || ps.description
      FROM ps_product_status ps
     WHERE ps.product_status_id = p_product_status_id;

    CURSOR cuEstCorte(p_sesuesco servsusc.sesuesco%TYPE)
    IS 
    SELECT escocodi || ' - ' || escodesc 
      FROM estacort e 
     WHERE escocodi = p_sesuesco;      

    CURSOR cuEstComponente( p_product_status_id pr_product.product_status_id%TYPE )
    IS
    SELECT ps.product_status_id || ' - ' || ps.description 
      FROM ps_product_status ps
     WHERE ps.product_status_id = p_product_status_id;

    CURSOR cuUltActSusp2( p_task_type_id or_task_type.task_type_id%TYPE )
    IS
    SELECT tt.task_type_id || ' - ' || tt.DESCRIPTION 
      FROM or_task_type tt 
     WHERE tt.task_type_id = p_task_type_id;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTrazaApi, csbInicio);
    pkg_error.prInicializaError(nuerror, osbmsgerror);
    pkg_traza.trace(csbMetodo ||' nutipo: ' || nutipo, csbNivelTrazaApi);    

    --INICIO CA 711
    sbaplica711 := 'S';
    pkg_traza.trace(csbMetodo||' sbaplica711: '||sbaplica711 , csbNivelTraza);
    --FIN CA 711

    nutipoanalisis := nutipo;
    pkg_traza.trace(csbMetodo ||' nutipoanalisis: ' || nutipoanalisis, csbNivelTrazaApi);

    sbttsusp := sbttsuspca || '|' || sbttsusprp || '|' || sbttsuspad || '|' || sbttsuspvo;
    pkg_traza.trace(csbMetodo ||' sbttsusp: ' || sbttsusp, csbNivelTrazaApi);

    sbttsuspreco := sbttsusp || '|' || sbttreco;
    pkg_traza.trace(csbMetodo ||' sbttsuspreco: ' || sbttsuspreco, csbNivelTrazaApi);

    FOR rg IN cuproductos LOOP
        nuprod := rg.sesunuse;
        nucont := nucont + 1;
    -- limpia variables

        sbestprod       := NULL; sbestcorte := NULL; ult_act_susp   := NULL; est_componente_1 := NULL; est_componente_2 := NULL;  orden_1   := NULL; orden_2        := NULL;
        orden_3         := NULL; orden_4    := NULL; nucantps       := 0;    nucantcs       := 0;    nucantec       := 0;    nucantord      :=0;     nucantsus      :=0;     nucantsolrec   :=0;     nupsid1    := NULL; nupsst1 := NULL; dtpsad1 := NULL;
        dtpsid1         := NULL; nupsid2    := NULL; nupsst2        := NULL; dtpsad2        := NULL; dtpsid2        := NULL; nucsid1        := NULL; nucsco1        := NULL; nucsst1        := NULL; dtcsad1    := NULL;
        dtcsid1         := NULL; nucsid2    := NULL; nucsco2        := NULL; nucsst2        := NULL; dtcsad2        := NULL; dtcsid2        := NULL; nucsid3        := NULL; nucsco3        := NULL; nucsst3    := NULL;
        dtcsad3         := NULL; dtcsid3    := NULL;  nucsid4       := NULL; nucsco4        := NULL; nucsst4        := NULL; dtcsad4        := NULL; dtcsid4        := NULL;
        nuecid1         := NULL; nueces1    := NULL; nuecid2        := NULL; nueces2        := NULL; nuorultactsusp := NULL; nuttultactsusp := NULL; nuultactsusprp := NULL; nuororden1     := NULL;
        nuttorden1      := NULL; nuosorden1 := NULL; nuororden2     := NULL; nuttorden2     := NULL; nuosorden2     := NULL; nuororden3     := NULL; nuttorden3     := NULL; nuosorden3     := NULL;
        nuororden4      := NULL; nuttorden4 := NULL; nuosorden4     := NULL; nuorsusp1      := NULL; nutpsusp1      := NULL; nufosusp1      := NULL; nufasusp1      := NULL; nuorsusp2      := NULL;
        dtfcorden1      := NULL; dtflorden1 := NULL; dtfcorden2     := NULL; dtflorden2     := NULL; dtfcorden3     := NULL; dtflorden3     := NULL; dtfcorden4     := NULL; dtflorden4     := NULL;
        nutpsusp2       := NULL; nufosusp2  := NULL; nufasusp2      := NULL; nusorec        := NULL; nuorrec        := NULL; nuttrec        := NULL; nueorec        := NULL; sbsuspcone1    := NULL; sbsuspcone2  := NULL;
        nuacultactsusp  := NULL;  nuultactsuspca:= NULL;
        nuproducto      := rg.sesunuse;
        nuprodstat      := rg.product_status_id;
        nusesuesco      := rg.sesuesco;

        pkg_traza.trace(csbMetodo ||' nuproducto: ' || nuproducto, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' nuprodstat: ' || nuprodstat, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' nusesuesco: ' || nusesuesco, csbNivelTrazaApi);

        -- busca datos
        nucantps := 0;
        FOR rg2 IN cususpactiprod(rg.sesunuse) LOOP
            nucantps := nucantps + 1;
            IF nucantps = 1 THEN
                nupsid1 := rg2.prod_suspension_id;
                nupsst1 := rg2.suspension_type_id;
                dtpsad1 := rg2.aplication_date;
                dtpsid1 := rg2.inactive_date;
            ELSIF nucantps = 2 THEN
                nupsid2 := rg2.prod_suspension_id;
                nupsst2 := rg2.suspension_type_id;
                dtpsad2 := rg2.aplication_date;
                dtpsid2 := rg2.inactive_date;
            END IF;
        END LOOP;
        pkg_traza.trace(csbMetodo ||' cursor cususpactiprod INICIO', csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' prod_suspension_id_1: ' || nupsid1||', suspension_type_id_1: ' || nupsst1, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' aplication_date_1: ' || dtpsad1||', inactive_date_1: ' || dtpsid1, csbNivelTrazaApi);     
        pkg_traza.trace(csbMetodo ||' prod_suspension_id_2: ' || nupsid2||', suspension_type_id_2: ' || nupsst2, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' aplication_date_2: ' || dtpsad2||', inactive_date_2: ' || dtpsid2, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' cursor cususpactiprod FIN', csbNivelTrazaApi);   

        nucantcs := 0;
        FOR rg3 IN cususpacticomp(rg.sesunuse) LOOP
            nucantcs := nucantcs + 1;
            IF nucantcs = 1 THEN
                nucsid1 := rg3.comp_suspension_id;
                nucsco1 := rg3.component_id;
                nucsst1 := rg3.suspension_type_id;
                dtcsad1 := rg3.aplication_date;
                dtcsid1 := rg3.inactive_date;
            ELSIF nucantcs = 2 THEN
                nucsid2 := rg3.comp_suspension_id;
                nucsco2 := rg3.component_id;
                nucsst2 := rg3.suspension_type_id;
                dtcsad2 := rg3.aplication_date;
                dtcsid2 := rg3.inactive_date;
            ELSIF nucantcs = 3 THEN
                nucsid3 := rg3.comp_suspension_id;
                nucsco3 := rg3.component_id;
                nucsst3 := rg3.suspension_type_id;
                dtcsad3 := rg3.aplication_date;
                dtcsid3 := rg3.inactive_date;
            ELSIF nucantcs = 4 THEN
                nucsid4 := rg3.comp_suspension_id;
                nucsco4 := rg3.component_id;
                nucsst4 := rg3.suspension_type_id;
                dtcsad4 := rg3.aplication_date;
                dtcsid4 := rg3.inactive_date;
            END IF;
        END LOOP;
        pkg_traza.trace(csbMetodo ||' cursor cususpacticomp INICIO', csbNivelTrazaApi);          
        pkg_traza.trace(csbMetodo ||' comp_suspension_id_1: ' || nucsid1||', component_id_1: ' || nucsco1, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' suspension_type_id_1: ' || nucsst1||', aplication_date_1: ' || dtcsad1, csbNivelTrazaApi);     
        pkg_traza.trace(csbMetodo ||' inactive_date_1: ' || dtcsid1, csbNivelTrazaApi); 

        pkg_traza.trace(csbMetodo ||' comp_suspension_id_2: ' || nucsid2||', component_id_2: ' || nucsco2, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' suspension_type_id_2: ' || nucsst2||', aplication_date_2: ' || dtcsad2, csbNivelTrazaApi);     
        pkg_traza.trace(csbMetodo ||' inactive_date_2: ' || dtcsid2, csbNivelTrazaApi);

        pkg_traza.trace(csbMetodo ||' comp_suspension_id_3: ' || nucsid3||', component_id_3: ' || nucsco3, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' suspension_type_id_3: ' || nucsst3||', aplication_date_3: ' || dtcsad3, csbNivelTrazaApi);     
        pkg_traza.trace(csbMetodo ||' inactive_date_3: ' || dtcsid3, csbNivelTrazaApi); 

        pkg_traza.trace(csbMetodo ||' comp_suspension_id_4: ' || nucsid4||', component_id_4: ' || nucsco4, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' suspension_type_id_4: ' || nucsst4||', aplication_date_4: ' || dtcsad4, csbNivelTrazaApi);     
        pkg_traza.trace(csbMetodo ||' inactive_date_4: ' || dtcsid4, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' cursor cususpacticomp FIN', csbNivelTrazaApi);

        nucantec := 0;
        FOR rg4 IN cuestcomp(rg.sesunuse) LOOP
            nucantec := nucantec + 1;
            IF nucantec = 1 THEN
                nuecid1 := rg4.component_id;
                nueces1 := rg4.component_status_id;
            ELSIF nucantec = 2 THEN
                nuecid2 := rg4.component_id;
                nueces2 := rg4.component_status_id;
            END IF;
        END LOOP;
        pkg_traza.trace(csbMetodo ||' cursor cuestcomp INICIO', csbNivelTrazaApi);        
        pkg_traza.trace(csbMetodo ||' component_id_1: ' || nuecid1||', component_status_id: ' || nueces1, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' component_id_2: ' || nuecid2||', component_status_id: ' || nueces2, csbNivelTrazaApi);  
        pkg_traza.trace(csbMetodo ||' cursor cuestcomp FIN', csbNivelTrazaApi);    

        FOR rg5 IN cuultactsusp (rg.suspen_ord_act_id) LOOP
        nuorultactsusp := rg5.order_id;
        nuacultactsusp := rg5.order_activity_id;
        nuttultactsusp := rg5.task_type_id;
        END LOOP;
        pkg_traza.trace(csbMetodo ||' cursor cuultactsusp INICIO', csbNivelTrazaApi);        
        pkg_traza.trace(csbMetodo ||' order_id: ' || nuorultactsusp||', order_activity_id: ' || nuacultactsusp, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' task_type_id: ' || nuttultactsusp , csbNivelTrazaApi);  
        pkg_traza.trace(csbMetodo ||' cursor cuultactsusp FIN', csbNivelTrazaApi);

        -- ult act de susp de RP
        OPEN cuultactsusprp(rg.sesunuse);
        FETCH cuultactsusprp INTO nuultactsusprp;
            IF cuultactsusprp%notfound THEN
                nuultactsusprp := NULL;
            END IF;
        CLOSE cuultactsusprp;
        pkg_traza.trace(csbMetodo ||' nuultactsusprp: ' || nuultactsusprp, csbNivelTrazaApi);

        -- ult act de susp de Cartera
        OPEN cuultactsuspca(rg.sesunuse);
        FETCH cuultactsuspca INTO nuultactsuspca;
            IF cuultactsuspca%notfound THEN
                nuultactsuspca := NULL;
            END IF;
        CLOSE cuultactsuspca;
        pkg_traza.trace(csbMetodo ||' nuultactsuspca: ' || nuultactsuspca, csbNivelTrazaApi);

        nucantord := 0;
        FOR rg6 IN cuultordenes(rg.sesunuse) LOOP
            nucantord := nucantord + 1;
            IF nucantord = 1 THEN
                nuororden1 := rg6.order_id;
                nuttorden1 := rg6.task_type_id;
                nuosorden1 := rg6.order_status_id;
                dtfcorden1 := rg6.created_date;
                dtflorden1 := rg6.legalization_date;
            ELSIF nucantord = 2 THEN
                nuororden2 := rg6.order_id;
                nuttorden2 := rg6.task_type_id;
                nuosorden2 := rg6.order_status_id;
                dtfcorden2 := rg6.created_date;
                dtflorden2 := rg6.legalization_date;
            ELSIF nucantord = 3 THEN
                nuororden3 := rg6.order_id;
                nuttorden3 := rg6.task_type_id;
                nuosorden3 := rg6.order_status_id;
                dtfcorden3 := rg6.created_date;
                dtflorden3 := rg6.legalization_date;
            ELSIF nucantord = 4 THEN
                nuororden4 := rg6.order_id;
                nuttorden4 := rg6.task_type_id;
                nuosorden4 := rg6.order_status_id;
                dtfcorden4 := rg6.created_date;
                dtflorden4 := rg6.legalization_date;
            ELSE
                EXIT;
            END IF;
        END LOOP;
        pkg_traza.trace(csbMetodo ||' cursor cuultordenes INICIO', csbNivelTrazaApi);        
        pkg_traza.trace(csbMetodo ||' order_id_1: ' || nuororden1||', task_type_id_1: ' || nuttorden1, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' order_status_id_1: ' || nuosorden1||', created_date_1: ' || dtfcorden1, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' legalization_date_1: ' || dtflorden1 , csbNivelTrazaApi);
        --
        pkg_traza.trace(csbMetodo ||' order_id_2: ' || nuororden2||', task_type_id_2: ' || nuttorden2, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' order_status_id_2: ' || nuosorden2||', created_date_2: ' || dtfcorden2, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' legalization_date_2: ' || dtflorden2 , csbNivelTrazaApi);
        --
        pkg_traza.trace(csbMetodo ||' order_id_3: ' || nuororden3||', task_type_id_3: ' || nuttorden3, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' order_status_id_3: ' || nuosorden3||', created_date_3: ' || dtfcorden3, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' legalization_date_3: ' || dtflorden3 , csbNivelTrazaApi); 
        --
        pkg_traza.trace(csbMetodo ||' order_id_4: ' || nuororden4||', task_type_id_4: ' || nuttorden4, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' order_status_id_4: ' || nuosorden4||', created_date_4: ' || dtfcorden4, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' legalization_date_4: ' || dtflorden4 , csbNivelTrazaApi);         
        pkg_traza.trace(csbMetodo ||' cursor cuultordenes FIN', csbNivelTrazaApi);  

        nucantsus := 0;
        FOR rg7 IN cuultsuspcone(rg.sesunuse) LOOP
            nucantsus := nucantsus + 1;
            IF nucantsus = 1 THEN
                nuorsusp1 := rg7.suconuor;
                nutpsusp1 := rg7.sucotipo;
                nufosusp1 := rg7.sucofeor;
                nufasusp1 := rg7.sucofeat;
            ELSIF nucantsus = 2 THEN
                nuorsusp2 := rg7.suconuor;
                nutpsusp2 := rg7.sucotipo;
                nufosusp2 := rg7.sucofeor;
                nufasusp2 := rg7.sucofeat;
            ELSE
                EXIT;
            END IF;
        END LOOP;
        pkg_traza.trace(csbMetodo ||' cursor cuultsuspcone INICIO', csbNivelTrazaApi);        
        pkg_traza.trace(csbMetodo ||' suconuor_1: ' || nuorsusp1||', sucotipo_1: ' || nutpsusp1, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' sucofeor_1: ' || nufosusp1||', sucofeat_1: ' || nufasusp1, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' legalization_date_1: ' || dtflorden1 , csbNivelTrazaApi);
        --
        pkg_traza.trace(csbMetodo ||' suconuor_2: ' || nuorsusp2||', sucotipo_2: ' || nutpsusp2, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' sucofeor_2: ' || nufosusp2||', sucofeat_2: ' || nufasusp2, csbNivelTrazaApi); 
        pkg_traza.trace(csbMetodo ||' cursor cuultsuspcone FIN', csbNivelTrazaApi); 

        nucantsolrec := 0;
        FOR rg8 IN cusolirecdet(rg.sesunuse) LOOP
            nucantsolrec := nucantsolrec + 1;
            IF nucantsolrec = 1 THEN
                nusorec := rg8.package_id;
                nuorrec := rg8.order_id;
                nuttrec := rg8.task_type_id;
                nueorec := rg8.order_status_id;
            ELSE
                EXIT;
            END IF;
        END LOOP;
        pkg_traza.trace(csbMetodo ||' cursor cusolirecdet INICIO', csbNivelTrazaApi);        
        pkg_traza.trace(csbMetodo ||' package_id: ' || nusorec||', order_id: ' || nuorrec, csbNivelTrazaApi);
        pkg_traza.trace(csbMetodo ||' task_type_id: ' || nuttrec||', order_status_id: ' || nueorec, csbNivelTrazaApi); 
        pkg_traza.trace(csbMetodo ||' cursor cusolirecdet FIN', csbNivelTrazaApi);

        -- halla descripciones de estados de producto, componente y de corte
        OPEN cuEstProd(rg.product_status_id);
        FETCH cuEstProd INTO sbestprod;
        CLOSE cuEstProd;
        pkg_traza.trace(csbMetodo ||' sbestprod: ' || sbestprod , csbNivelTrazaApi);        

        OPEN cuEstCorte(rg.sesuesco);
        FETCH cuEstCorte INTO sbestcorte;
        CLOSE cuEstCorte;
        pkg_traza.trace(csbMetodo ||' sbestcorte: ' || sbestcorte , csbNivelTrazaApi);        

        IF nueces1 IS NOT NULL THEN
            OPEN cuEstComponente(nueces1);
            FETCH cuEstComponente INTO est_componente_1;
            CLOSE cuEstComponente;
            pkg_traza.trace(csbMetodo ||' est_componente_1: ' || est_componente_1 , csbNivelTrazaApi);            

        END IF;

        IF nueces2 IS NOT NULL THEN
            OPEN cuEstComponente(nueces2);
            FETCH cuEstComponente INTO est_componente_2;
            CLOSE cuEstComponente;
            pkg_traza.trace(csbMetodo ||' est_componente_2: ' || est_componente_2 , csbNivelTrazaApi);            
        END IF;

        -- halla tipo de trabajo de la ultima actividad de suspension
        IF nuttultactsusp IS NULL THEN
            ult_act_susp := NULL;
        ELSE
            OPEN cuUltActSusp2(nuttultactsusp);
            FETCH cuUltActSusp2 INTO ult_act_susp;
            CLOSE cuUltActSusp2;  
        END IF;
        pkg_traza.trace(csbMetodo ||' ult_act_susp: ' || ult_act_susp , csbNivelTrazaApi);

        -- Arma datos de las ordenes
        orden_1 := armadatosorden(nuororden1, nuttorden1, nuosorden1, dtfcorden1, dtflorden1);
        pkg_traza.trace(csbMetodo ||' orden_1: ' || orden_1 , csbNivelTrazaApi);

        orden_2 := armadatosorden(nuororden2, nuttorden2, nuosorden2, dtfcorden2, dtflorden2);
        pkg_traza.trace(csbMetodo ||' orden_2: ' || orden_2 , csbNivelTrazaApi);

        orden_3 := armadatosorden(nuororden3, nuttorden3, nuosorden3, dtfcorden3, dtflorden3);
        pkg_traza.trace(csbMetodo ||' orden_3: ' || orden_3 , csbNivelTrazaApi);

        orden_4 := armadatosorden(nuororden4, nuttorden4, nuosorden4, dtfcorden4, dtflorden4);
        pkg_traza.trace(csbMetodo ||' orden_4: ' || orden_4 , csbNivelTrazaApi);

        -- Halla el tipo de suspensiion (RP o Cartera) y evalua si hay datos inconsistentes y si es asi los ingresa en la tabla
        sbtipoulacsusp := hallatipoultactsusp(ult_act_susp);
        pkg_traza.trace(csbMetodo ||' sbtipoulacsusp: ' || sbtipoulacsusp , csbNivelTrazaApi);

        insertareg;
        nuerror := nuerror + 1;

        IF sbaplica711 = 'S' THEN
            UPDATE ldc_prod_analisis_suspcone SET observacion = 'Procesado'
            WHERE producto = nuprod;
            pkg_traza.trace(csbMetodo ||' sbaplica711 - UPDATE ldc_prod_analisis_suspcone - producto: ' || nuprod , csbNivelTrazaApi);
        END IF;

        IF MOD(nucont,50) = 0 THEN
            pkg_estaproc.practualizaestaproc(sbNameProceso, 'Error', 'Analisis ' || nutipo || ' Van leidos ' || nucont || ' . Con datos inconsistentes: ' || nuerror);
        END IF;

        IF MOD(nuerror,500) = 0 THEN
            COMMIT;
        END IF;

    END LOOP;

    COMMIT;

    -- borra la tabla de productos especificos
    EXECUTE IMMEDIATE 'truncate table LDC_PROD_ANALISIS_SUSPCONE';
    IF SQL%FOUND THEN 
        pkg_traza.trace(csbMetodo ||' TRUNCATE TABLE LDC_PROD_ANALISIS_SUSPCONE, Registros afectados: '||SQL%ROWCOUNT, csbNivelTrazaApi);           
    END IF;

    pkg_estaproc.practualizaestaproc(sbNameProceso, 'Ok', 'Analisis ' || nutipo || ' Leidos ' || nucont || ' . Generados: ' || nuerror);
    osbmsgerror := NULL;
    pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN);
    RETURN (0 );

EXCEPTION
    WHEN pkg_Error.controlled_error THEN 
         pkg_Error.getError(nuerror, osbmsgerror);
         pkg_traza.trace(csbMetodo ||' osbmsgerror: ' || osbmsgerror, csbNivelTrazaApi);
         pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN_ERC);      
         pkg_estaproc.practualizaestaproc(sbNameProceso, 'error', osbmsgerror||' - '||dbms_utility.format_error_backtrace);
         RETURN -1;
    WHEN OTHERS THEN  
         pkg_Error.setError;
         pkg_Error.getError(nuerror, osbmsgerror);
         pkg_traza.trace(csbMetodo ||' osbmsgerror: ' || osbmsgerror, csbNivelTrazaApi);
         pkg_traza.trace(csbMetodo, csbNivelTrazaApi, pkg_traza.csbFIN_ERR);
         pkg_estaproc.practualizaestaproc(sbNameProceso, 'error', osbmsgerror||' - '||dbms_utility.format_error_backtrace);
         RETURN -1;
END fnuanalisissuspcone_pres;

FUNCTION FNUGETSUSPACTPROD (nusesu IN  servsusc.sesunuse%TYPE,
                            osberror OUT VARCHAR2) RETURN NUMBER IS
  /******************************************************************  
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas 
                                          Se retira esquema OPEN antepuesto a pr_prod_suspension 
                                          Se ajusta bloque de exception según pautas técnicas
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'fnugetsuspactprod'; 
    nuactualizados NUMBER := 0;
    nucoderror NUMBER := 0;

    CURSOR cususpactiprod IS
    SELECT p.prod_suspension_id, p.product_id, p.suspension_type_id, p.register_date, p.aplication_date, p.inactive_date, p.active
      FROM pr_prod_suspension P
     WHERE P.product_id = nusesu
       AND P.active = 'Y'
     ORDER BY P.register_date;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(nuerror, osberror);
    pkg_traza.trace(csbMetodo ||' nusesu: ' || nusesu, csbNivelTraza);    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
    RETURN nuactualizados;

EXCEPTION
    WHEN OTHERS THEN 
        pkg_Error.setError;
        pkg_Error.getError(nucoderror, osberror);
        pkg_traza.trace(csbMetodo ||' osberror: ' || osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
        RETURN -1;
END fnugetsuspactprod;


-------------------------------------------------------------------------
FUNCTION ARMADATOSORDEN (
    inuorden      IN or_order.order_id%TYPE,
    inuttorden    IN or_order.task_type_id%TYPE,
    inuestorden   IN or_order.order_status_id%TYPE,
    idtfecreorden IN DATE,
    idtfelegorden IN DATE
) RETURN VARCHAR2 IS
  /******************************************************************  
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas
                                          Se declaran variables para la gestión del error
                                          Se retira código comentariado
                                          Se reemplaza SELECT-INTO por cursor cuOrden
                                          Se ajusta bloque de exception según pautas técnicas
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'armadatosorden'; 
    nuerror             NUMBER                    := pkg_error.CNUGENERIC_MESSAGE;
    osberror            VARCHAR2(2000); 
    sborden             VARCHAR2(500) := NULL;

    CURSOR cuOrden
    IS
    SELECT tt.task_type_id || ' - ' || tt.DESCRIPTION
      FROM or_task_type tt 
     WHERE tt.task_type_id = inuttorden;    
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(nuerror, osberror);
    pkg_traza.trace(csbMetodo ||' inuorden: ' || inuorden||', inuttorden: ' || inuttorden, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' inuestorden: ' || inuestorden||', idtfecreorden: ' || idtfecreorden||', idtfelegorden: ' || idtfelegorden, csbNivelTraza);

    IF inuorden IS NULL THEN
        sborden := NULL;
    ELSE
        OPEN cuOrden;
        FETCH cuOrden INTO sborden;
        CLOSE cuOrden; 
        sborden := rpad(sborden,60,'_');
        sborden := sborden || '   ' || TO_CHAR(idtfecreorden,'dd/mm/yyyy') ||  '    ' || TO_CHAR(idtfelegorden,'dd/mm/yyyy');
    END IF;
    pkg_traza.trace(csbMetodo ||' sborden: ' || sborden , csbNivelTraza);

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    RETURN (sborden);

EXCEPTION WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuerror, osberror);
        pkg_traza.trace(csbMetodo ||' osberror: ' || osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
        RETURN ('Error Armando Cadena de la Orden');
END armadatosorden;

-------------------------------------------------------------------------
FUNCTION HALLATIPOULTACTSUSP (sbultactsusp IN VARCHAR2) RETURN VARCHAR2 IS
  /******************************************************************  
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas
                                          Se declaran variables para la gestión del error 
                                          Se ajusta bloque de exception según pautas técnicas
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'hallatipoultactsusp';
    csbNivelTrazaApi    CONSTANT NUMBER(2)        := pkg_traza.cnuNivelTrzApi;
    nuerror             NUMBER                    := pkg_error.CNUGENERIC_MESSAGE;
    osberror            VARCHAR2(2000); 
    sbtipo              VARCHAR2(100) := NULL;
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(nuerror, osberror);
    pkg_traza.trace(csbMetodo ||' sbultactsusp: ' || sbultactsusp, csbNivelTraza);

    IF sbultactsusp IS NULL THEN
     sbtipo := 'NU';
    ELSIF (ult_act_susp LIKE '%SUSP%')      AND
          ((ult_act_susp LIKE '%REVISION%'  OR
          ult_act_susp LIKE '%DEFECTO%'     OR
          ult_act_susp LIKE '%REPARACION%'  OR
          ult_act_susp LIKE '%CERTIFICADO%' OR
          ult_act_susp LIKE '%ASOCIADOS%'   OR
          ult_act_susp LIKE '%NUEVAS%'      OR
          ult_act_susp LIKE '%SEGURIDAD%'   OR
          ult_act_susp LIKE '%RP%'          OR
          ult_act_susp LIKE '%REPARACION%')) THEN
      sbtipo := 'RP';
    ELSE
      sbtipo := 'CA';
    END IF;

    pkg_traza.trace(csbMetodo ||' sbtipo: ' || sbtipo, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    RETURN (sbtipo);

EXCEPTION WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuerror, osberror);
        pkg_traza.trace(csbMetodo ||' osberror: ' || osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
        RETURN (NULL);
END hallatipoultactsusp;


FUNCTION INCONSIS_RP RETURN VARCHAR2 IS
  /******************************************************************  
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas
                                          Se declaran variables para la gestión del error
                                          Se añade TRIM a la variable nusorec, ya que al evaluarla ='D', genera el error: "El valor ingresado excede la longitud del campo o error en la conversión de datos o
                                          el valor del índice de la tabla temporal es nulo " debido a que su valor es espacio en blanco
                                          Se ajusta bloque de exception según pautas técnicas
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'inconsis_rp';
    csbNivelTrazaApi    CONSTANT NUMBER(2)        := pkg_traza.cnuNivelTrzApi;
    nuerror             NUMBER                    := pkg_error.CNUGENERIC_MESSAGE; 
    osberror            VARCHAR2(2000);     
    sbinco              VARCHAR2(2);
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(nuerror, osberror);
    pkg_traza.trace(csbMetodo ||' nucantps: ' || nucantps||', nucantcs: ' || nucantcs, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nupsst1: ' || nupsst1||', nucsst1: ' || nucsst1, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nucsst2: ' || nucsst2||', nueces1: ' || nueces1, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nueces2: ' || nueces2||', nuprodstat: ' || nuprodstat, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nusesuesco: ' || nusesuesco||', nusorec: ' || nusorec, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nutpsusp1: ' || nutpsusp1||', nufasusp1: ' || nufasusp1, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nutpsusp1: ' || nutpsusp1, csbNivelTraza); 

    IF nucantps != 1 
    OR nucantcs != 2 
    OR nupsst1 < 101 
    OR nucsst1 < 101 
    OR nucsst2 < 101 
    OR nueces1 != 8 
    OR nueces2 != 8 
    OR nuprodstat != 2 
    OR nusesuesco != 1 
    OR nusorec IS NOT NULL OR TRIM(nusorec)='D' 
    OR (nutpsusp1 IS NOT NULL AND nufasusp1 IS NULL) THEN
     sbinco := 'SI';
    ELSE
     sbinco := 'NO';
    END IF;

    pkg_traza.trace(csbMetodo ||' sbinco: ' || sbinco, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    RETURN (sbinco);

EXCEPTION WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuerror, osberror);
        pkg_traza.trace(csbMetodo ||' osberror: ' || osberror||' - '||dbms_utility.format_error_backtrace, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);         
        RETURN ('NO');
END inconsis_rp;

FUNCTION INCONSIS_CA RETURN VARCHAR2 IS
  /******************************************************************  
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas
                                          Se declaran variables para la gestión del error 
                                          Se ajusta bloque de exception según pautas técnicas
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'inconsis_ca';
    csbNivelTrazaApi    CONSTANT NUMBER(2)        := pkg_traza.cnuNivelTrzApi;
    nuerror             NUMBER                    := pkg_error.CNUGENERIC_MESSAGE; 
    osberror            VARCHAR2(2000);     
    sbinco VARCHAR2(2);

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(nuerror, osberror);
    pkg_traza.trace(csbMetodo ||' nucantps: ' || nucantps||', nucantcs: ' || nucantcs, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nupsst1: ' || nupsst1||', nucsst1: ' || nucsst1, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nucsst2: ' || nucsst2||', nueces1: ' || nueces1, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nueces2: ' || nueces2||', nuprodstat: ' || nuprodstat, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nusesuesco: ' || nusesuesco||', nusorec: ' || nusorec, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nutpsusp1: ' || nutpsusp1||', nufasusp1: ' || nufasusp1, csbNivelTraza);

    IF nucantps != 1    OR 
    nucantcs != 2       OR 
    nupsst1 >= 101      OR 
    nucsst1 >= 101      OR 
    nucsst2 >= 101      OR 
    nueces1 != 8        OR 
    nueces2 != 8        OR
    nuprodstat != 2     OR 
    nusesuesco != 3     OR 
    nusorec IS NOT NULL OR 
    nutpsusp1='C'       OR
    (nutpsusp1 IS NOT NULL AND nufasusp1 IS NULL) THEN
     sbinco := 'SI';
    ELSE
     sbinco := 'NO';
    END IF;

    pkg_traza.trace(csbMetodo ||' sbinco: ' || sbinco, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    RETURN (sbinco);

EXCEPTION WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuerror, osberror);
        pkg_traza.trace(csbMetodo ||' osberror: ' || osberror||' - '||dbms_utility.format_error_backtrace, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
        RETURN ('NO');
END inconsis_ca;

PROCEDURE INSERTAREG IS
  /******************************************************************  
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas
                                          Se declaran variables para la gestión del error
                                          Se asigna valor a las variables nutsess y sbparuser
                                          Se añade bloque de exception según pautas técnicas
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'insertareg'; 
    nuerror             NUMBER                    := pkg_error.CNUGENERIC_MESSAGE; 
    osberror            VARCHAR2(2000);

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(nuerror, osberror); 
    nutsess:= USERENV('SESSIONID');
    sbparuser:= PKG_SESSION.GETUSER;
    
    INSERT INTO ldc_analisis_suspcone ( sesion, usuario, tipo_analisis, fecha_analisis, producto,
                                        est_prod, est_corte, ult_act_susp, nro_activ_ult_act_susp, nro_susp_act_producto,id_susp_act_prod_1,
                                        tipo_susp_act_prod_1, fech_apli_susp_act_prod_1, fech_inac_susp_act_prod_1, id_susp_act_prod_2,tipo_susp_act_prod_2,
                                        fech_apli_susp_act_prod_2, fech_inac_susp_act_prod_2, nr_susp_act_componentes, id_susp_act_comp_1, cod_susp_act_comp_1,
                                        tipo_susp_act_comp_1, fech_apli_susp_act_comp_1, fech_inac_susp_act_comp_1, id_susp_act_comp_2, cod_susp_act_comp_2,
                                        tipo_susp_act_comp_2, fech_apli_susp_act_comp_2, fech_inac_susp_act_comp_2, id_susp_act_comp_3, 
                                        cod_susp_act_comp_3, tipo_susp_act_comp_3, fech_apli_susp_act_comp_3, fech_inac_susp_act_comp_3, id_susp_act_comp_4, 
                                        cod_susp_act_comp_4, tipo_susp_act_comp_4, fech_apli_susp_act_comp_4, fech_inac_susp_act_comp_4, nro_componentes, 
                                        id_componente_1, estado_comp_1, id_componente_2, estado_comp_2, orden_1, 
                                        nro_orden_1, tipo_trab_orden_1, estado_orden_1, fecha_crea_orden_1, fecha_lega_orden_1, 
                                        orden_2, nro_orden_2, tipo_trab_orden_2, estado_orden_2, fecha_crea_orden_2, 
                                        fecha_lega_orden_2, orden_3, nro_orden_3, tipo_trab_orden_3, estado_orden_3,
                                        fecha_crea_orden_3, fecha_lega_orden_3, orden_4, nro_orden_4, 
                                        tipo_trab_orden_4, estado_orden_4, fecha_crea_orden_4, fecha_lega_orden_4, nro_ord_suspcone_1,
                                        tipo_suspcone_1, fech_orde_suspcone_1, fech_aten_suspcone_1, nro_ord_suspcone_2, tipo_suspcone_2, 
                                        fech_orde_suspcone_2, fech_aten_suspcone_2, nro_soli_reconex_deteni, nro_orde_recone_deteni,tt_orde_reconex_deteni, 
                                        esta_orde_reconex_deteni ,ult_act_susp_de_rp, ult_act_susp_de_ca
                            ) VALUES (  nutsess, sbparuser, nutipoanalisis, dtfecha, nuproducto,
                                        sbestprod, sbestcorte, ult_act_susp, nuacultactsusp, nucantps,
                                        nupsid1, nupsst1, dtpsad1, dtpsid1, nupsid2,
                                        nupsst2, dtpsad2, dtpsid2, nucantcs, nucsid1,
                                        nucsco1, nucsst1, dtcsad1, dtcsid1, nucsid2,
                                        nucsco2, nucsst2, dtcsad2, dtcsid2, nucsid3,
                                        nucsco3, nucsst3, dtcsad3, dtcsid3, nucsid4,
                                        nucsco4, nucsst4, dtcsad4, dtcsid4, nucantec,
                                        nuecid1, est_componente_1, nuecid2, est_componente_2, orden_1,
                                        nuororden1, nuttorden1, nuosorden1, dtfcorden1, dtflorden1,
                                        orden_2, nuororden2, nuttorden2, nuosorden2, dtfcorden2,
                                        dtflorden2, orden_3, nuororden3, nuttorden3, nuosorden3,
                                        dtfcorden3, dtflorden3, orden_4, nuororden4, nuttorden4,
                                        nuosorden4, dtfcorden4, dtflorden4, nuorsusp1, nutpsusp1,
                                        nufosusp1, nufasusp1, nuorsusp2, nutpsusp2, nufosusp2,
                                        nufasusp2, nusorec, nuorrec, nuttrec, nueorec,
                                        nuultactsusprp, nuultactsuspca
                                    );
    pkg_traza.trace(csbMetodo||' INSERT INTO ldc_analisis_suspcone, producto= '||nuproducto, csbNivelTraza, pkg_traza.csbFIN);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

EXCEPTION WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuerror, osberror);
        pkg_traza.trace(csbMetodo ||' osberror: ' || osberror||' - '||dbms_utility.format_error_backtrace, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
END insertareg;

FUNCTION fbogetisnumber (
    isbvalor VARCHAR2
) RETURN BOOLEAN IS
  /******************************************************************  
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas
                                          Se declaran variables para la gestión del error 
                                          Se ajusta bloque de exception según pautas técnicas
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'fbogetisnumber'; 
    nuerror             NUMBER                    := pkg_error.CNUGENERIC_MESSAGE; 
    osberror            VARCHAR2(2000);

    blresult            BOOLEAN := TRUE;
    nures               NUMBER; 

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(nuerror, osberror);
    pkg_traza.trace(csbMetodo ||' isbvalor: ' || isbvalor, csbNivelTraza);

    BEGIN
        nures := TO_NUMBER(isbvalor);
    EXCEPTION WHEN OTHERS THEN
        blresult := FALSE;
    END;
    pkg_traza.trace(csbMetodo ||' nures: ' || nures, csbNivelTraza);

    IF blresult THEN pkg_traza.trace(csbMetodo ||' blresult IS TRUE ', csbNivelTraza);
    ELSE pkg_traza.trace(csbMetodo ||' blresult IS FALSE ', csbNivelTraza);
    END IF;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    RETURN (blresult);

EXCEPTION
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuerror, osberror);
        pkg_traza.trace(csbMetodo ||' osberror: ' || osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);    
        RETURN (FALSE);
END fbogetisnumber;

PROCEDURE LDCAISPPRES IS
  /******************************************************************  
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas
                                          Se declaran variables para la gestión del error
                                          Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo
                                          Se reemplaza ERRORS.seterror() por pkg_Error.setErrorMessage y se retira el raise por ya lo hace el seterror en su logica interna 
                                          Se reemplaza ld_boconstans.cnugeneric_error por pkg_error.cnugeneric_message
                                          Se reemplaza dald_parameter.fsbgetvalue_chain por pkg_bcld_parameter.fsbobtienevalorcadena
                                          Se reemplaza pkutlfilemgr.fopen por pkg_gestionarchivos.ftabrirarchivo_smf
                                          Se reemplaza pkutlfilemgr.fclose por pkg_gestionarchivos.prccerrararchivo_smf
                                          Se añade bloque de exception según pautas técnicas
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'ldcaisppres'; 
    nuerror             NUMBER                    := pkg_error.CNUGENERIC_MESSAGE; 
    osberror            VARCHAR2(2000);
    sbsistdire          ge_boinstancecontrol.stysbvalue;
    sbfilemanagementr   pkg_gestionarchivos.styarchivo;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(nuerror, osberror); 

    sbsistdire := ge_boinstancecontrol.fsbgetfieldvalue('SISTEMA', 'SISTDIRE'); 
    pkg_traza.trace(csbMetodo ||' sbsistdire: '||sbsistdire, csbNivelTraza);

    IF (sbsistdire IS NULL) THEN
        pkg_traza.trace(csbMetodo ||' El Nombre de Achivo no debe ser nulo ', csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        pkg_Error.setErrorMessage(isbMsgErrr =>  'El Nombre de Achivo no debe ser nulo'); 
    END IF;

    --Halla ruta del archivo plano
    sbpath := pkg_bcld_parameter.fsbobtienevalorcadena('RUTA_ARCH_VALI_SUSP'); -- '/smartfiles/cartera';
    pkg_traza.trace(csbMetodo ||' sbpath: '||sbpath, csbNivelTraza);
    sbfile :=  sbsistdire;

    -- valida que exista el archivo
    BEGIN
        sbfilemanagementr := pkg_gestionarchivos.ftabrirarchivo_smf(sbpath, sbfile, 'r');
    EXCEPTION
        WHEN OTHERS THEN
            pkg_gestionarchivos.prccerrararchivo_smf(sbfilemanagementr);
            pkg_traza.trace(csbMetodo ||' El Nombre de Achivo no debe ser nulo ', csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
            pkg_Error.setErrorMessage(isbMsgErrr => 'Error ... Archivo no Existe o no se pudo abrir ');
    END;

    leearchivo;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

EXCEPTION WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuerror, osberror);
        pkg_traza.trace(csbMetodo ||' osberror: ' || osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
END ldcaisppres;


  PROCEDURE LEEARCHIVO
  IS
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ReadTextFile
    Descripcion    : Procedimiento que carga archivo plano con productos especificos a procesar
    Autor          : HB
    Fecha          : 28/10/2020 CA-493

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    09/04/2021    horbath                 ca 711 se cambia valor del campo observacion
                                          por Subido en vez de procesado
    11/11/2022    lvalencia               OSF-658: Se agrega el parámetro
                                          LDC_SERVICE_ALLOW
    11-03-2024    ADRIANAVG               OSF-2388: Se declara variable para el nombre del método en la gestión de trazas 
                                          Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo
                                          Se reemplaza ge_boerrors.seterrorcodeargument por pkg_Error.setErrorMessage y se retira el raise por ya lo hace el seterror en su logica interna 
                                          Se reemplaza ld_boconstans.cnugeneric_error por pkg_error.cnugeneric_message
                                          se reemplaza dald_parameter.fsbgetvalue_chain por pkg_bcld_parameter.fsbobtienevalorcadena
                                          Se reemplaza SELECT-INTO y ldc_proinsertaestaprog por BEGIN-END para pkg_estaproc.prinsertaestaproc
                                          Se retira código comentariado
                                          Se reemplaza pkutlfilemgr.fopen por pkg_gestionarchivos.ftabrirarchivo_smf
                                          Se reemplaza pkutlfilemgr.get_line por pkg_gestionarchivos.fsbobtenerlinea_smf
                                          Se reemplaza asignación de pkg_gestionarchivos.fsbobtenerlinea_smf() de nuCodigo por sbonline
                                          Se añade BEGIN-END al llamado de pkg_gestionarchivos.fsbobtenerlinea_smf() para manejar
                                          la exception de fin de archivo y asignar valor a nuCodigo 
                                          Se reemplaza pkutlfilemgr.fclose por pkg_gestionarchivos.prccerrararchivo_smf
                                          Se reemplaza ldc_proactualizaestaprog por pkg_estaproc.practualizaestaproc
                                          Se ajusta bloque de exception según pautas técnicas
  ******************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			CONSTANT VARCHAR2(100)    := csbNOMPKG||'leearchivo'; 
    sbproceso           VARCHAR2(100 BYTE)        := csbMetodo||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
    sbNameProceso       sbproceso%TYPE;

    sblinelog           VARCHAR2(4000);
    nulinea             NUMBER;

    onuerror            NUMBER := 0;
    osbmsgerror         VARCHAR2(4000) := NULL;

    nuajuste            NUMBER;
    osberrajuste        VARCHAR2(4000);

    nusesion            NUMBER;
    nuproducto          servsusc.sesunuse%TYPE;

    sbfilegl            VARCHAR2(100);
    sbext               VARCHAR2(10);
    sbonline            VARCHAR2(5000);

    /* Variables para conexion*/
    nucodigo            NUMBER;
    sbfilemanagement    pkg_gestionarchivos.styarchivo;

    cnuend_of_file      CONSTANT NUMBER := 1;

    nuerror             NUMBER;
    sbmessage           VARCHAR2(2000);

    /*Variables de archivo de log*/ 
    sblog               VARCHAR2(500); -- Log de errores
    sbtimeproc          VARCHAR2(500);

    sbtiparch           VARCHAR2(50);
    nuerrorcode         NUMBER;
    sberrormessage      VARCHAR2(4000);

    numonth             NUMBER; 
    sblinefile          VARCHAR2(1000);
    vnuexito            NUMBER := 0;
    vnunoexito          NUMBER := 0;
    sbasunto            VARCHAR2(2000);
    vsbmessage          VARCHAR2(2000);
    vsbsendemail        ld_parameter.value_chain%TYPE; --Direccion de email quine firma el email
    vsbrecemail         ld_parameter.value_chain%TYPE; --Direccion de email que recibe

    nucontador          NUMBER:= 1;
    nuindex             NUMBER;

    nuserv              servsusc.sesuserv%TYPE;

    sbtypeservice       ld_parameter.value_chain%TYPE := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_SERVICE_ALLOW');

    CURSOR cuproducto (nusesu servsusc.sesunuse%TYPE) IS
    SELECT sesuserv
      FROM servsusc
     WHERE sesunuse=nusesu;

    --INICIO CA 711
    sbaplica711         VARCHAR2(1) := 'N';
    --FIN CA 711

   BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_error.prInicializaError(nuerror, sberrormessage); 
        pkg_traza.trace(csbMetodo||' sbtypeservice: '||sbtypeservice , csbNivelTraza);

        IF sbtypeservice IS NULL THEN
            sberrormessage:= ' No existen datos para el parámetro LDC_SERVICE_ALLOW, se debe definir el parámetro en LDPAR';
            pkg_traza.trace(csbMetodo ||' sberrormessage: '||sberrormessage, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
            pkg_Error.setErrorMessage( pkg_error.cnugeneric_message, sberrormessage);
        END IF;

        -- se obtienen datos para registrar en ESTAPROC
        BEGIN
            sbNameProceso:= sbproceso; --invocarlo una sola vez
            pkg_traza.trace(csbMetodo||' sbNameProceso: '||sbNameProceso , csbNivelTraza);
            -- Ingresa en ESTAPROC
            pkg_estaproc.prinsertaestaproc(sbNameProceso, NULL);	
            pkg_estaproc.practualizaestaproc(sbNameProceso, 'En ejecucion', sberrormessage);
        END;    

        dtfechaproceso := sysdate;
        pkg_traza.trace(csbMetodo ||' dtfechaproceso: '||dtfechaproceso, csbNivelTraza);

        --INICIO CA 711
        IF fblaplicaentregaxcaso('0000711') THEN
            sbaplica711 := 'S';
        END IF;
        --FIN CA 711
        pkg_traza.trace(csbMetodo||' sbaplica711: '||sbaplica711 , csbNivelTraza);

        BEGIN
            sbfilemanagement := pkg_gestionarchivos.ftabrirarchivo_smf(sbpath, sbfile, 'r');
        EXCEPTION
        WHEN OTHERS THEN
            osbmsgerror := 'No se pudo abrir archivo ' || sbpath || ' ' || sbfile || ' ' || CHR(13) || sqlerrm; 
            pkg_traza.trace(csbMetodo ||' osbmsgerror: '||osbmsgerror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
            pkg_Error.setErrorMessage( pkg_error.cnugeneric_message, osbmsgerror);            
        END;

        nulinea := 0;

        ----------- ciclo de lectura de lineas del archivo
        LOOP
            sblinelog   := NULL;
            nulinea     := nulinea + 1;

            BEGIN 
              sbonline := pkg_gestionarchivos.fsbobtenerlinea_smf(sbfilemanagement); 
              pkg_traza.trace(csbMetodo ||' sbonline: ' || sbonline, csbNivelTraza);
              nucodigo:=0; 
            EXCEPTION WHEN NO_DATA_FOUND THEN 
              nucodigo:=1;
            END;             
            pkg_traza.trace(csbMetodo ||' nucodigo: '||nucodigo, csbNivelTraza);

            EXIT WHEN(nucodigo = cnuend_of_file);
            -- Inicializa variables extraidas del archivo
            sbtipoarch        := NULL;
            sbproducto        := NULL;

            /* Obtiene Columnas del archivo*/
            sbtiparch := substr(sbonline, 1, instr(sbonline, '|', 1, 1) - 1);
            pkg_traza.trace(csbMetodo ||' sbtiparch: '||sbtiparch, csbNivelTraza);

            sbproducto := substr(sbonline,
                          instr(sbonline, '|', 1, 1) + 1,
                          (instr(sbonline, '|', 1, 2)) -
                          (instr(sbonline, '|', 1, 1) + 1)); 
            pkg_traza.trace(csbMetodo ||' sbproducto: '||sbproducto, csbNivelTraza);

            ----------------- validaciones  ----------------------

            IF sbproducto IS NULL OR NOT fbogetisnumber(sbproducto) THEN
                sblinelog := 'Producto Nulo o No Numerico ' || sbproducto ||  CHR(13);
                pkg_traza.trace(csbMetodo ||' sblinelog: '||sblinelog, csbNivelTraza);
                nuproducto := NULL; 
                GOTO nextline;
            ELSE
                nuproducto := to_number(sbproducto);
            END IF;

            IF sbtiparch IS NULL  OR sbtiparch != 'LDCAISP' THEN
                sblinelog :=  'Linea no es del tipo LDCAISP' || CHR(13);
                pkg_traza.trace(csbMetodo ||' sblinelog: '||sblinelog, csbNivelTraza);
                GOTO nextline;
            END IF;

            -- valida que producto exista y sea de gas
            OPEN cuproducto (nuproducto);
            FETCH cuproducto INTO nuserv;
            IF cuproducto%notfound THEN
                nuserv := -1;
            END IF;
            CLOSE cuproducto;
            pkg_traza.trace(csbMetodo ||' nuserv: '||nuserv, csbNivelTraza);

            IF instr(sbtypeservice, nuserv||',') = 0 THEN
                sblinelog :=  'Producto no existe o el tipo de servicio no se encuentra configurado en el parámetro LDC_SERVICE_ALLOW' || CHR(13); 
                pkg_traza.trace(csbMetodo ||' sblinelog: '||sblinelog, csbNivelTraza);
                GOTO nextline;
            END IF;

            --INICIO CA 711
            IF sbaplica711 = 'S' THEN
                 sblinelog := 'Subido';
            ELSE
                -- paso las validaciones
                sblinelog := 'Procesado';
            END IF;
            pkg_traza.trace(csbMetodo ||' sblinelog: '||sblinelog, csbNivelTraza);

            --FIN CA 711
            <<nextline>>

            INSERT INTO ldc_prod_analisis_suspcone (producto, nombre_archivo, sesion, observacion) VALUES (nuproducto, sbfile, nutsess, sblinelog);
            pkg_traza.trace(csbMetodo ||' INSERT INTO ldc_prod_analisis_suspcone, producto '||nuproducto, csbNivelTraza);
        END LOOP;

        COMMIT;

        <<finproceso>>
        pkg_gestionarchivos.prccerrararchivo_smf(sbfilemanagement);

        pkg_estaproc.practualizaestaproc(sbNameProceso, 'OK', osbmsgerror); 
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.controlled_error THEN
            ROLLBACK;
            pkg_Error.getError(nuerrorcode, osbmsgerror);
            pkg_traza.trace(csbMetodo ||' osbmsgerror: ' || osbmsgerror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_estaproc.practualizaestaproc(sbNameProceso, 'ERROR', osbmsgerror);
        WHEN OTHERS THEN
            ROLLBACK;
            pkg_Error.setError;
            pkg_Error.getError(nuerrorcode, osbmsgerror);
            pkg_traza.trace(csbMetodo ||' osbmsgerror: ' || osbmsgerror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_estaproc.practualizaestaproc(sbNameProceso, 'ERROR', osbmsgerror);
END leearchivo;


End ldc_pkValidaSuspcone;
/
Prompt Otorgando permisos sobre ldc_pkValidaSuspcone
BEGIN
    pkg_Utilidades.prAplicarPermisos('LDC_PKVALIDASUSPCONE', 'OPEN');
END;
/
