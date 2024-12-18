CREATE OR REPLACE Package adm_person.LDC_PKAJUSTASUSPCONE Is
	/*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: ldc_pkAjustaSuspcone
  Descripcion:        Gestiona las suspensiones

  Autor    : Oscar Ospino P.
  Fecha    : 06-05-2016  CA 200-210

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  25/06/2024   PAcosta                OSF-2878: Cambio de esquema ADM_PERSON  
  06-03-2024   jsoto				  OSF-2381  Ajustes:
										Se reemplaza uso de  GE_BOERRORS.SETERRORCODEARGUMENT por  PKG_ERORR.SETERRORMESSAGE
										Se reemplaza uso de  UT_SESSION.GETTERMINAL por  pkg_session.fsbgetterminal
										Se reemplaza uso de  DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID por  pkg_bcsolicitudes.fnugettiposolicitud
										Se reemplaza uso de  PKUTLFILEMGR.FOPEN por  pkg_gestionarchivos.ftabrirarchivo_smf
										Se reemplaza uso de  DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID por  pkg_bcordenes.fnuobtieneclasecausal
										Se reemplaza uso de  EX.CONTROLLED_ERROR por  pkg_error.controlled_error
										Se reemplaza uso de  OR_BOCONSTANTS.CNUORDER_STAT_ASSIGNED por  pkg_gestionordenes.cnuordenasignada
										Se reemplaza uso de  UTL_FILE.FILE_TYPE por  PKG_GESTIONARCHIVOS.STYARCHIVO
										Se reemplaza uso de  UT_SESSION.GETPROGRAM por  pkg_session.getprogram
										Se reemplaza uso de  LDC_PROINSERTAESTAPROG por  pkg_estaproc.prinsertaestaproc
										Se reemplaza uso de  DAOR_ORDER.FNUGETORDER_STATUS_ID por  PKG_BCORDENES.FNUOBTIENEESTADO
										Se reemplaza uso de  UT_SESSION.GETIP por  pkg_session.getip
										Se reemplaza uso de  USERENV('SESSIONID') por  PKG_SESSION.FNUGETSESION
										Se reemplaza uso de  GE_BOERRORS.SETERRORCODE por  PKG_ERROR.SETERROR
										Se reemplaza uso de  UT_DATE.FDTSYSDATE por  ldc_boconsgenerales.fdtgetsysdate
										Se reemplaza uso de  UT_SESSION.GETMODULE por  pkg_session.fsbobtenermodulo
										Se reemplaza uso de  LDC_PROACTUALIZAESTAPROG por  pkg_estaproc.practualizaestaproc
										Se reemplaza uso de  PKUTLFILEMGR.FCLOSE por  pkg_gestionarchivos.prccerrararchivo_smf
										Se reemplaza uso de  OR_BOFWLOCKORDER.UNLOCKORDER por  api_unlockorder
										Se reemplaza uso de  UT_SESSION.GETSESSIONID por  pkg_session.fnugetsesion
										Se reemplaza uso de  PKUTLFILEMGR.GET_LINE por  pkg_gestionarchivos.fsbobtenerlinea_smf
										Se reemplaza uso de  ERRORS.SETERROR por  PKG_ERROR.SETERROR
										Se reemplaza uso de  ERRORS.GETERROR por  PKG_ERROR.GETERROR
										Se reemplaza uso de  OR_BOCONSTANTS.CNUORDER_STAT_REGISTERED por  pkg_gestionordenes.cnuordenregistrada
										Se reemplaza uso de  MO_BOANNULMENT.ANNULWFPLAN por  pkgmanejosolicitudes.pannulplanworkflow
										Se suprime uso de FBLAPLICAENTREGAXCASO y FBLAPLICAENTREGA y se deja la logica solamente los que esten activos.
										Se ajusta el manejo de errores y trazas por los personalizados
  23-09-2022   cgonzalez			  OSF-570: Se modifica el servicio <PRANULASOLITUDES>
  03-08-2022   cgonzalez			  OSF-448: Se modifican los servicios <LeeArchivo> <InsertaLog>
  16-05-2022   cgonzalez			  OSF-129: Se modifica el servicio PRANULASOLITUDES                                         
  ******************************************************************/

  procedure ldcnisp ;

   PROCEDURE LeeArchivo;

	function ActEstCorte (nusesu       in  servsusc.sesunuse%type,
                         nuesco_nuevo in  estacort.escocodi%type,
                         osberror     out varchar2) return number ;



function ActEstProd    (nusesu        in  servsusc.sesunuse%type,
                        nuespr_nuevo in  pr_product.product_status_id%type,
                        osberror     out varchar2) return number;

function ActEstComp    (nuCompId        in  pr_component.component_id%type,
                        nuescomp_nuevo in  pr_component.component_status_id%type,
                         osberror     out varchar2) return number ;

function ActUltActSusp  (nusesu        in  servsusc.sesunuse%type,
                         nuUltActSusp  in  pr_product.suspen_ord_act_id%type,
                         osberror      out varchar2) return number;

function Insert_Susp_Comp    (nusesu        in  servsusc.sesunuse%type,
                         nucompId      in  pr_comp_suspension.component_id%type,
                         osberror      out varchar2) return number;

function Insert_Susp_Prod    (nusesu        in  servsusc.sesunuse%type,
                              osberror      out varchar2) return number ;

function Inactiva_Susp_Prod  (nusesu        in  servsusc.sesunuse%type,
                              nuProdSuspId   in  pr_prod_suspension.prod_suspension_id%type,
                              dtInacDate     in  date,
                              osberror      out varchar2) return number ;

function Actualiza_TipoSusp_Prod  (nusesu        in  servsusc.sesunuse%type,
                                nuSuspTypeID   in  pr_prod_suspension.suspension_type_id%type,
                              osberror      out varchar2) return number;

function Inactiva_Susp_Comp  (nuCompSuspId   in  pr_comp_suspension.comp_suspension_id%type,
                              dtInacDate     in  date,
                              osberror      out varchar2) return number;


function Actualiza_TipoSusp_Comp  (nuCompSuspId   in  pr_comp_suspension.comp_suspension_id%type,
                              nuSuspTypeID   in  pr_comp_suspension.suspension_type_id%type,
                              osberror      out varchar2) return number;


function Atiende_Suspcone  (nusesu        in  servsusc.sesunuse%type,
                              nuOrden   in  suspcone.suconuor%type,
                              dtFecha   in date,
                              osberror      out varchar2) return number;

FUNCTION fboGetIsNumber (isbValor varchar2) return boolean;

function Anula_Suspcone  (nusesu        in  servsusc.sesunuse%type,
                              nuOrden   in  suspcone.suconuor%type,
                              dtFecha   in date,
                              osberror      out varchar2) return number ;

procedure InsertaLog (osbobservacion in varchar2) ;

PROCEDURE PRVALIINFOORDEN( inusoliReco IN NUMBER,
                           inuordensusp IN NUMBER,
                           inuOrdenSuspac IN NUMBER,
                           inuProducto IN NUMBER,
                           onuError OUT NUMBER,
                           osbError OUT VARCHAR2);
	/*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: PRVALIINFOORDEN
  Descripcion:        valida informacion de ordenes y reconexion

  Autor    : Horbath
  Fecha    : 09/04/2021  CA 711

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------

  ******************************************************************/

  PROCEDURE	PRGENERASUSP( inuOrden IN NUMBER,
                          inuproducto IN NUMBER,
                          onuerror OUT NUMBER,
                          osberror OUT VARCHAR2);
 /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: PRGENERASUSP
  Descripcion:        proceso que se encarga de actualizar o generar pr_prod_suspension

  Autor    : Horbath
  Fecha    : 09/04/2021  CA 711

  Parametro de Entrada:
    inuOrden    codigo de la orden
    inuproducto  codigo del producto
  Parametro de salida:
    onuerror    codigo de error
    osberror    mensaje de error

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  ******************************************************************/

  PROCEDURE  PRANULASOLITUDES( inuSoliReco IN NUMBER,
                               inuOrdenSusp IN NUMBER,
                               onuerror OUT NUMBER,
                               osberror OUT VARCHAR2);
  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: PRANULASOLITUDES
  Descripcion:        proceso que se encarga de anular solicitud y ordenes de suspension

  Autor    : Horbath
  Fecha    : 09/04/2021  CA 711

  Parametro de Entrada:
    inuSoliReco    codigo de la solicitud de reconexion
    inuOrdenSusp   codigo de la orden de suspension
  Parametro de salida:
    onuerror    codigo de error
    osberror    mensaje de error

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  23-09-2022   cgonzalez			  OSF-570: Se modifica para anular la orden de la variable inuOrdenSusp
  16-05-2022   cgonzalez			  OSF-129: Se modifica para no procesar 2 veces la solicitud
  ******************************************************************/
End ldc_pkAjustaSuspcone;
/
CREATE OR REPLACE Package Body adm_person.ldc_pkAjustaSuspcone Is

	------------------------------------------------------------------------------------------------
	-- Datos de paquete

sbPath            varchar2(500);
sbFile            varchar2(500);
dtfechaproceso    date;
nutsess           NUMBER := PKG_SESSION.FNUGETSESION;

 sbTipoArch        varchar2(2000);
 sbSesion          varchar2(2000);
 sbProducto        varchar2(2000);
 sbModEstProd      varchar2(4000);
 sbModEstCorte     varchar2(4000);
 sbCodiComp1       varchar2(4000);
 sbModEstComp1     varchar2(4000);
 sbCodiComp2       varchar2(4000);
 sbModEstComp2     varchar2(4000);
 sbCodiComp3       varchar2(4000);
 sbModEstComp3     varchar2(4000);
 sbModUltActSusp   varchar2(4000);

 sbAgrSusActiProd  varchar2(4000);
 sbAgrSusActiComp1 varchar2(4000);
 sbAgrSusActiComp2 varchar2(4000);
 sbAgrSusActiComp3 varchar2(4000);
 sbInaSusActiProd1 varchar2(4000);
 sbInaSusActiProd2 varchar2(4000);
 sbInaSusActiComp1 varchar2(4000);
 sbInaSusActiComp2 varchar2(4000);
 sbInaSusActiComp3 varchar2(4000);
 sbInaSusActiComp4 varchar2(4000);

 sbModTipoSusProd  varchar2(4000);
 sbModTipoSusComp1 varchar2(4000);
 sbModTipoSusComp2 varchar2(4000);
 sbModTipoSusComp3 varchar2(4000);
 sbOrdSuspConeAten varchar2(4000);
 sbOrdSuspConeAnul varchar2(4000);
 ---
 --INICIO CA 711
 sbSoliRecoAnul varchar2(4000);
 sbOrdeSuspAnul varchar2(4000);
 sbOrdeSuspacti varchar2(4000);
 sbMotivo 		varchar2(4000);
 --FIN CA 711
nutipoAnalisis number;
dtfecha  date := sysdate;
nuano    NUMBER(4);
numes    NUMBER(2);
nusesion NUMBER;
sbuser   VARCHAR2(30);

nuproducto pr_product.product_id%type;
nuprodstat  pr_product.product_status_id%type;
nusesuesco  servsusc.sesuesco%type;
sbestprod varchar2(200);
sbestcorte varchar2(200);
ULT_ACT_SUSP varchar2(200);
est_componente_1 varchar2(200);
est_componente_2 varchar2(200);
orden_1 varchar2(200);
orden_2 varchar2(200);
orden_3 varchar2(200);
orden_4 varchar2(200);
sbscript varchar2(4000) := null;

nucont   number := 0;
nuerror number := 0;
nucantps number;
nucantcs number;
nucantec number;
nucantord number;
nucantsus number;
nucantsolrec number;

nupsid1 pr_prod_suspension.prod_suspension_id%type;
nupsst1 pr_prod_suspension.suspension_type_id%type;
dtpsad1 pr_prod_suspension.aplication_date%type;
dtpsid1 pr_prod_suspension.inactive_date%type;

nupsid2 pr_prod_suspension.prod_suspension_id%type;
nupsst2 pr_prod_suspension.suspension_type_id%type;
dtpsad2 pr_prod_suspension.aplication_date%type;
dtpsid2 pr_prod_suspension.inactive_date%type;


nucsid1  pr_comp_suspension.comp_suspension_id%type;
nucsco1   pr_comp_suspension.component_id%type;
nucsst1   pr_comp_suspension.suspension_type_id%type;
dtcsad1   pr_comp_suspension.aplication_date%type;
dtcsid1   pr_comp_suspension.inactive_date%type;

nucsid2   pr_comp_suspension.comp_suspension_id%type;
nucsco2   pr_comp_suspension.component_id%type;
nucsst2   pr_comp_suspension.suspension_type_id%type;
dtcsad2   pr_comp_suspension.aplication_date%type;
dtcsid2   pr_comp_suspension.inactive_date%type;

nucsid3   pr_comp_suspension.comp_suspension_id%type;
nucsco3   pr_comp_suspension.component_id%type;
nucsst3   pr_comp_suspension.suspension_type_id%type;
dtcsad3   pr_comp_suspension.aplication_date%type;
dtcsid3   pr_comp_suspension.inactive_date%type;

nucsid4   pr_comp_suspension.comp_suspension_id%type;
nucsco4   pr_comp_suspension.component_id%type;
nucsst4   pr_comp_suspension.suspension_type_id%type;
dtcsad4   pr_comp_suspension.aplication_date%type;
dtcsid4   pr_comp_suspension.inactive_date%type;


nuecid1   pr_component.component_id%type;
nueces1   pr_component.component_status_id%type;

nuecid2   pr_component.component_id%type;
nueces2   pr_component.component_status_id%type;


nuorUltActSusp   or_order.order_id%type;
nuAcUltActSusp   or_order_Activity.Order_Activity_Id%type;
nuttUltActSusp   or_order.task_type_id%type;
nuUltActSuspRP    or_order_Activity.order_Activity_id%type;


nuorOrden1   or_order.order_id%type;
nuttOrden1   or_order.task_type_id%type;
nuosOrden1   or_order.order_status_id%type;
dtfcOrden1   date;
dtflOrden1   date;

nuorOrden2   or_order.order_id%type;
nuttOrden2   or_order.task_type_id%type;
nuosOrden2   or_order.order_status_id%type;
dtfcOrden2   date;
dtflOrden2   date;

nuorOrden3   or_order.order_id%type;
nuttOrden3   or_order.task_type_id%type;
nuosOrden3   or_order.order_status_id%type;
dtfcOrden3   date;
dtflOrden3   date;

nuorOrden4   or_order.order_id%type;
nuttOrden4   or_order.task_type_id%type;
nuosOrden4   or_order.order_status_id%type;
dtfcOrden4   date;
dtflOrden4   date;

nuorSusp1  suspcone.suconuor%type;
nutpSusp1  suspcone.sucotipo%type;
nufoSusp1  suspcone.sucofeor%type;
nufaSusp1  suspcone.sucofeat%type;

nuorSusp2  suspcone.suconuor%type;
nutpSusp2  suspcone.sucotipo%type;
nufoSusp2  suspcone.sucofeor%type;
nufaSusp2  suspcone.sucofeat%type;

nusorec mo_packages.package_id%type;
nuorrec or_order.order_id%type;
nuttrec or_order.task_type_id%type;
nueorec or_order.order_status_id%type;

sbSuspcone1 varchar2(30);
sbSuspcone2 varchar2(30);

csbNOMPKG   CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.'; -- Constantes para el control de la traza

-------------------------------------------------------------------------
procedure ldcnisp IS

  sbSISTDIRE 			ge_boInstanceControl.stysbValue;
  sbFileManagementr  	pkg_gestionarchivos.styarchivo;
  csbMetodo  			CONSTANT VARCHAR2(100) := csbNOMPKG||'ldcnisp'; --Nombre del método en la traza

BEGIN

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

  sbSISTDIRE := ge_boInstanceControl.fsbGetFieldValue('SISTEMA', 'SISTDIRE');



  if (sbSISTDIRE is null) then
    pkg_error.setErrorMessage(pkg_error.CNUGENERIC_MESSAGE,'El Nombre de Achivo no debe ser nulo');
  end if;

  --Halla ruta del archivo plano
  sbPath := dald_parameter.fsbGetValue_Chain('RUTA_ARCH_VALI_SUSP'); -- '/smartfiles/cartera';
  sbFile :=  sbSISTDIRE;

  -- valida que exista el archivo
  begin
    sbFileManagementr := pkg_gestionarchivos.ftabrirarchivo_smf(sbPath, sbFile, 'r');
  exception
    when others then
      pkg_gestionarchivos.prccerrararchivo_smf(sbFileManagementr,sbPath,sbFile);
      pkg_error.setErrorMessage(pkg_error.CNUGENERIC_MESSAGE,
                    'Error ... Archivo no Existe o no se pudo abrir ');
  end;

  LeeArchivo;

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

END ldcnisp;
----------------------------------------------------------------------------------
 PROCEDURE LeeArchivo
      IS

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ReadTextFile
  Descripcion    : Procedimiento que recorre el archivo plano y genera la nota y demas datos
  Autor          : HB
  Fecha          : 29/04/2016 ERS 200-206

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================
  03-08-2022    cgonzalez			    OSF-448: Se ajusta para tener en cuenta el campo MOTIVO de la entidad LDC_AJUSTA_SUSPCONE
  09/01/2021    HORBATH                 CA 711 ajustar proceso para leer los tres nuevos campos solicitud de reconexi??n,
                                        orden de suspensi??n anular y orden de suspensi??n activar
  ******************************************************************/
 sbLineLog varchar2(4000);
 nuLinea number;

 onuError number := 0;
 osbMsgError VARCHAR2(4000) := NULL;

 nuAjuste number;
 osbErrAjuste varchar2(4000);

 nuSesion          number;
 nuProducto        servsusc.sesunuse%type;
 nuModEstProd      pr_product.product_status_id%type;
 nuModEstCorte     servsusc.sesuesco%type;
 nuCodiComp1       pr_component.component_id%type;
 nuModEstComp1     pr_product.product_status_id%type;
 nuCodiComp2       pr_component.component_id%type;
 nuModEstComp2     pr_product.product_status_id%type;
 nuCodiComp3       pr_component.component_id%type;
 nuModEstComp3     pr_product.product_status_id%type;
 nuModUltActSusp   pr_product.suspen_ord_act_id%type;
 nuModTipoSusProd  pr_prod_suspension.suspension_type_id%type;
 nuModTipoSusComp1 pr_prod_suspension.suspension_type_id%type;
 nuModTipoSusComp2 pr_prod_suspension.suspension_type_id%type;
 nuModTipoSusComp3 pr_prod_suspension.suspension_type_id%type;
 nuOrdSuspConeAten or_order.order_id%type;
 nuOrdSuspConeAnul or_order.order_id%type;
 sbproceso  	   VARCHAR2(100)  := 'LDC_PKAJUSTASUSPCONE'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');


    sbFileGl varchar2(100);
    sbExt    varchar2(10);
    sbOnline varchar2(5000);

    /* Variables para conexion*/
    nuCodigo          number;
    sbFileManagement  pkg_gestionarchivos.styarchivo;


    cnuend_of_file constant number := 1;

    nuerror       number;
    sbmessage     varchar2(2000);

       /*Variables de archivo de log*/

    sbLog            varchar2(500); -- Log de errores
    sbTimeProc       varchar2(500);

    sbTipArch         varchar2(50);
    nuErrorCode      NUMBER;
    sbErrorMessage   VARCHAR2(4000);

    nuMonth          number;

     ------------

    sbLineFile        varchar2(1000);
    vnuexito        number := 0;
    vnunoexito      number := 0;
    sbAsunto        varchar2(2000);
    vsbmessage      varchar2(2000);
    vsbSendEmail    ld_parameter.value_chain%TYPE; --Direccion de email quine firma el email
    vsbrecEmail     ld_parameter.value_chain%TYPE; --Direccion de email que recibe

    nuContador  number:= 1;
    nuIndex     number;

    cursor cuAjustar (nusesi number) is
     select rowid fila, t.*
       from LDC_AJUSTA_SUSPCONE t
      where sesion = nusesi
        and observacion is null;

    cursor cuAnalisis (nusesi number, nuprod number) is
     select *
       from LDC_ANALISIS_SUSPCONE s
      where s.sesion = nusesi
        and s.producto = nuprod;
     rg2 cuAnalisis%rowtype;

 	 csbMetodo  			CONSTANT VARCHAR2(100) := csbNOMPKG||'LEEARCHIVO'; --Nombre del método en la traza


   BEGIN

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
    
      -- Start log program
	  pkg_estaproc.prinsertaestaproc( sbproceso , NULL);

     dtfechaproceso := sysdate;

       begin
         sbFileManagement := pkg_gestionarchivos.ftabrirarchivo_smf(sbPath, sbFile, 'r');
       exception
        when others then
         osbMsgError := 'No se pudo abrir archivo ' || sbPath || ' ' || sbFile || ' ' || chr(13) || sqlerrm;
         pkg_error.setErrorMessage(2741, osbMsgError);
        end;

        nuLinea := 0;

        ----------- ciclo de lectura de lineas del archivo
        loop
		
		  BEGIN
            sbOnline := pkg_gestionArchivos.fsbObtenerLinea_SMF (sbFileManagement);
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    EXIT;
                WHEN OTHERS THEN
                    RAISE;
          END;
		
          sbLineLog := NULL;
          nuLinea := nuLinea + 1;
          -- Inicializa variables extraidas del archivo
          sbTipoArch        := NULL;
          sbSesion          := NULL;
          sbProducto        := NULL;
          sbModEstProd      := NULL;
          sbModEstCorte     := NULL;
          sbCodiComp1       := NULL;
          sbModEstComp1     := NULL;
          sbCodiComp2       := NULL;
          sbModEstComp2     := NULL;
          sbCodiComp3       := NULL;
          sbModEstComp3     := NULL;
          sbModUltActSusp   := NULL;

          sbAgrSusActiProd  := NULL;
          sbAgrSusActiComp1 := NULL;
          sbAgrSusActiComp2 := NULL;
          sbAgrSusActiComp3 := NULL;
          sbInaSusActiProd1 := NULL;
          sbInaSusActiProd2 := NULL;
          sbInaSusActiComp1 := NULL;
          sbInaSusActiComp2 := NULL;
          sbInaSusActiComp3 := NULL;
          sbInaSusActiComp4 := NULL;

          sbModTipoSusProd  := NULL;
          sbModTipoSusComp1 := NULL;
          sbModTipoSusComp2 := NULL;
          sbModTipoSusComp3 := NULL;
          sbOrdSuspConeAten := NULL;
          sbOrdSuspConeAnul := NULL;

           sbSoliRecoAnul := NULL;
           sbOrdeSuspAnul := NULL;
           sbOrdeSuspacti := NULL;
		   sbMotivo 	  := NULL;
          /* Obtiene Columnas del archivo*/
          sbTipArch := substr(sbOnline,
                               1,
                              instr(sbOnline, '|', 1, 1) - 1);

          sbSesion := substr(sbOnline,
                          instr(sbOnline, '|', 1, 1) + 1,
                          (instr(sbOnline, '|', 1, 2)) -
                          (instr(sbOnline, '|', 1, 1) + 1));

          sbProducto := substr(sbOnline,
                          instr(sbOnline, '|', 1, 2) + 1,
                          (instr(sbOnline, '|', 1, 3)) -
                          (instr(sbOnline, '|', 1, 2) + 1));

          sbModEstProd := substr(sbOnline,
                                   instr(sbOnline, '|', 1, 3) + 1,
                                   (instr(sbOnline, '|', 1, 4)) -
                                   (instr(sbOnline, '|', 1, 3) + 1));

          sbModEstCorte := substr(sbOnline,
                                   instr(sbOnline, '|', 1, 4) + 1,
                                   (instr(sbOnline, '|', 1, 5)) -
                                   (instr(sbOnline, '|', 1, 4) + 1));

          sbCodiComp1 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 5) + 1,
                                 (instr(sbOnline, '|', 1, 6)) -
                                 (instr(sbOnline, '|', 1, 5) + 1));

          sbModEstComp1 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 6) + 1,
                                 (instr(sbOnline, '|', 1, 7)) -
                                 (instr(sbOnline, '|', 1, 6) + 1));


          sbCodiComp2 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 7) + 1,
                                 (instr(sbOnline, '|', 1, 8)) -
                                 (instr(sbOnline, '|', 1, 7) + 1));

          sbModEstComp2 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 8) + 1,
                                 (instr(sbOnline, '|', 1, 9)) -
                                 (instr(sbOnline, '|', 1, 8) + 1));

         sbCodiComp3 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 9) + 1,
                                 (instr(sbOnline, '|', 1, 10)) -
                                 (instr(sbOnline, '|', 1, 9) + 1));

         sbModEstComp3 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 10) + 1,
                                 (instr(sbOnline, '|', 1, 11)) -
                                 (instr(sbOnline, '|', 1, 10) + 1));

         sbModUltActSusp := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 11) + 1,
                                 (instr(sbOnline, '|', 1, 12)) -
                                 (instr(sbOnline, '|', 1, 11) + 1));

         sbAgrSusActiProd := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 12) + 1,
                                 (instr(sbOnline, '|', 1, 13)) -
                                 (instr(sbOnline, '|', 1, 12) + 1));

         sbAgrSusActiComp1 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 13) + 1,
                                 (instr(sbOnline, '|', 1, 14)) -
                                 (instr(sbOnline, '|', 1, 13) + 1));

         sbAgrSusActiComp2 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 14) + 1,
                                 (instr(sbOnline, '|', 1, 15)) -
                                 (instr(sbOnline, '|', 1, 14) + 1));

         sbAgrSusActiComp3 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 15) + 1,
                                 (instr(sbOnline, '|', 1, 16)) -
                                 (instr(sbOnline, '|', 1, 15) + 1));

         sbInaSusActiProd1 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 16) + 1,
                                 (instr(sbOnline, '|', 1, 17)) -
                                 (instr(sbOnline, '|', 1, 16) + 1));

         sbInaSusActiProd2 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 17) + 1,
                                 (instr(sbOnline, '|', 1, 18)) -
                                 (instr(sbOnline, '|', 1, 17) + 1));

         sbInaSusActiComp1 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 18) + 1,
                                 (instr(sbOnline, '|', 1, 19)) -
                                 (instr(sbOnline, '|', 1, 18) + 1));

        sbInaSusActiComp2 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 19) + 1,
                                 (instr(sbOnline, '|', 1, 20)) -
                                 (instr(sbOnline, '|', 1, 19) + 1));

       sbInaSusActiComp3 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 20) + 1,
                                 (instr(sbOnline, '|', 1, 21)) -
                                 (instr(sbOnline, '|', 1, 20) + 1));

        sbInaSusActiComp4 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 21) + 1,
                                 (instr(sbOnline, '|', 1, 22)) -
                                 (instr(sbOnline, '|', 1, 21) + 1));

       sbModTipoSusProd := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 22) + 1,
                                 (instr(sbOnline, '|', 1, 23)) -
                                 (instr(sbOnline, '|', 1, 22) + 1));

      sbModTipoSusComp1 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 23) + 1,
                                 (instr(sbOnline, '|', 1, 24)) -
                                 (instr(sbOnline, '|', 1, 23) + 1));

      sbModTipoSusComp2 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 24) + 1,
                                 (instr(sbOnline, '|', 1, 25)) -
                                 (instr(sbOnline, '|', 1, 24) + 1));

      sbModTipoSusComp3 := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 25) + 1,
                                 (instr(sbOnline, '|', 1, 26)) -
                                 (instr(sbOnline, '|', 1, 25) + 1));

      sbOrdSuspConeAten := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 26) + 1,
                                 (instr(sbOnline, '|', 1, 27)) -
                                 (instr(sbOnline, '|', 1, 26) + 1));

      sbOrdSuspConeAnul := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 27) + 1,
                                 (instr(sbOnline, '|', 1, 28)) -
                                 (instr(sbOnline, '|', 1, 27) + 1));

           sbSoliRecoAnul := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 28) + 1,
                                 (instr(sbOnline, '|', 1, 29)) -
                                 (instr(sbOnline, '|', 1, 28) + 1));
           sbOrdeSuspAnul := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 29) + 1,
                                 (instr(sbOnline, '|', 1, 30)) -
                                 (instr(sbOnline, '|', 1, 29) + 1));
           sbOrdeSuspacti := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 30) + 1,
                                 (instr(sbOnline, '|', 1, 31)) -
                                 (instr(sbOnline, '|', 1, 30) + 1));
			sbMotivo 	  := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 31) + 1,
                                 (instr(sbOnline, '|', 1, 32)) -
                                 (instr(sbOnline, '|', 1, 31) + 1));

      ----------------- validaciones  ----------------------

      if sbTipArch is null  or sbTipArch != 'AJSPC' then
             sbLineLog :=  'Linea no es del tipo AJSPC' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbSesion is null  or not fboGetIsNumber(sbSesion) then
             sbLineLog := 'Sesion Nula o No Numerico' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbProducto is null or not fboGetIsNumber(sbProducto) then
             sbLineLog := 'Producto Nulo o No Numerico' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbModEstProd is not null and not fboGetIsNumber(sbModEstProd) then
             sbLineLog := 'Est Producto a Modificar No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbModEstCorte is not null and not fboGetIsNumber(sbModEstCorte) then
             sbLineLog := 'Est Corte a Modificar No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbCodiComp1 is not null and not fboGetIsNumber(sbCodiComp1) then
             sbLineLog := 'Componente 1 No Numerico' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbModEstComp1 is not null and not fboGetIsNumber(sbModEstComp1) then
             sbLineLog := 'Est Componente 1 a Modificar No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbCodiComp2 is not null and not fboGetIsNumber(sbCodiComp2) then
             sbLineLog := 'Componente 2 No Numerico' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbModEstComp2 is not null and not fboGetIsNumber(sbModEstComp2) then
             sbLineLog := 'Est Componente 2 a Modificar No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbCodiComp3 is not null and not fboGetIsNumber(sbCodiComp3) then
             sbLineLog := 'Componente 3 No Numerico' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbModEstComp3 is not null and not fboGetIsNumber(sbModEstComp3) then
             sbLineLog := 'Est Componente 3 a Modificar No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbModUltActSusp is not null and not fboGetIsNumber(sbModUltActSusp) then
             sbLineLog := 'Ult Actividad de Suspension a Modificar No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbAgrSusActiProd is not null and sbAgrSusActiProd not in ('S','N') then
             sbLineLog := 'Agregar Susp Acti Prod con valor invalido' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbAgrSusActiComp1 is not null and sbAgrSusActiComp1 not in ('S','N') then
             sbLineLog := 'Agregar Susp Acti Comp 1 con valor invalido' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbAgrSusActiComp2 is not null and sbAgrSusActiComp2 not in ('S','N') then
             sbLineLog := 'Agregar Susp Acti Comp 2 con valor invalido' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbAgrSusActiComp3 is not null and sbAgrSusActiComp3 not in ('S','N') then
             sbLineLog := 'Agregar Susp Comp 3 con valor invalido' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbInaSusActiProd1 is not null and not fboGetIsNumber(sbInaSusActiProd1) then
             sbLineLog := 'Id SuspActiva Prod1 a Modificar No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbInaSusActiProd2 is not null and not fboGetIsNumber(sbInaSusActiProd2) then
             sbLineLog := 'Id SuspActiva Prod2 a Modificar No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbInaSusActiComp1 is not null and not fboGetIsNumber(sbInaSusActiComp1) then
             sbLineLog := 'Id SuspActiva Comp1 a Modificar No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbInaSusActiComp2 is not null and not fboGetIsNumber(sbInaSusActiComp2) then
             sbLineLog := 'Id SuspActiva Comp2 a Modificar No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbInaSusActiComp3 is not null and not fboGetIsNumber(sbInaSusActiComp3) then
             sbLineLog := 'Id SuspActiva Comp3 a Modificar No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbInaSusActiComp4 is not null and not fboGetIsNumber(sbInaSusActiComp4) then
             sbLineLog := 'Id SuspActiva Comp4 a Modificar No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbModTipoSusProd is not null and not fboGetIsNumber(sbModTipoSusProd) then
             sbLineLog := 'Tipo Suspension Prod a Modificar No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbModTipoSusComp1 is not null and not fboGetIsNumber(sbModTipoSusComp1) then
             sbLineLog := 'Tipo Suspension Comp 1 a Modificar No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbModTipoSusComp2 is not null and not fboGetIsNumber(sbModTipoSusComp2) then
             sbLineLog := 'Tipo Suspension Comp 2 a Modificar No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbModTipoSusComp3 is not null and not fboGetIsNumber(sbModTipoSusComp3) then
             sbLineLog := 'Tipo Suspension Comp 3 a Modificar No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbOrdSuspConeAten is not null and not fboGetIsNumber(sbOrdSuspConeAten) then
             sbLineLog := 'Orden Suspcone a Atender No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;

          if sbOrdSuspConeAnul is not null and not fboGetIsNumber(sbOrdSuspConeAnul) then
             sbLineLog := 'Orden Suspcone a Anular No Numerica' || chr(13);
             --insertalog;
             GOTO nextLine;
          end if;
              if sbSoliRecoAnul is not null and not fboGetIsNumber(sbSoliRecoAnul) then
                 sbLineLog := 'Solicitud de reconexion a Anular No Numerica' || chr(13);
                 --insertalog;
                 GOTO nextLine;
              end if;
              if sbOrdeSuspAnul is not null and not fboGetIsNumber(sbOrdeSuspAnul) then
                 sbLineLog := 'Orden de suspension a Anular No Numerica' || chr(13);
                 --insertalog;
                 GOTO nextLine;
              end if;
              if sbOrdeSuspacti is not null and not fboGetIsNumber(sbOrdeSuspacti) then
                 sbLineLog := 'Orden de suspension Activar No Numerica' || chr(13);
                 --insertalog;
                 GOTO nextLine;
              end if;

          <<nextLine>>
            insertalog (sbLineLog);
        end loop;

        <<FinProceso>>
         pkg_gestionarchivos.prccerrararchivo_smf(sbFileManagement,sbPath,sbFile);

       for rg in cuAJustar (nutsess) loop
        nuAjuste := 0;
        osberrajuste := null;
        nuErrorCode := 0;
         open cuAnalisis (rg.sesion_analisis, rg.producto);
         fetch cuAnalisis into rg2;
         if cuAnalisis%notfound then
          nuAjuste := -1;
          osberrajuste := 'No se encontro producto en LDC_ANALISIS_SUSPCONE para la sesion dada';
          goto fincuajustar;
         end if;
         close cuAnalisis;

         if rg.modestprod is not null then
           nuAjuste := ActEstProd(rg.producto, rg.modestprod, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.modestcorte is not null then
           nuAjuste := ActEstCorte(rg.producto, rg.modestcorte, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.codicomp1 is not null and rg.modestcomp1 is not null then
           nuAjuste := ActEstComp(rg.codicomp1, rg.modestcomp1, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.codicomp2 is not null and rg.modestcomp2 is not null then
           nuAjuste := ActEstComp(rg.codicomp2, rg.modestcomp2, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.codicomp3 is not null and rg.modestcomp3 is not null then
           nuAjuste := ActEstComp(rg.codicomp3, rg.modestcomp3, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.modultactsusp is not null  then
           nuAjuste := ActUltActSusp(rg.producto, rg.modultactsusp, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if nvl(rg.agrsusactiprod,'N') = 'S'  then
           nuAjuste := Insert_Susp_Prod(rg.producto, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if nvl(rg.agrsusacticomp1,'N') = 'S'  then
           nuAjuste := Insert_Susp_Comp(rg.producto, rg.codicomp1, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if nvl(rg.agrsusacticomp2,'N') = 'S'  then
           nuAjuste := Insert_Susp_Comp(rg.producto, rg.codicomp2, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if nvl(rg.agrsusacticomp3,'N') = 'S'  then
           nuAjuste := Insert_Susp_Comp(rg.producto, rg.codicomp3, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.inasusactiprod1 is not null then
           nuAjuste := Inactiva_Susp_Prod (rg.producto, rg.inasusactiprod1, sysdate, osberrajuste);
          if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.inasusactiprod2 is not null then
           nuAjuste := Inactiva_Susp_Prod (rg.producto, rg.inasusactiprod2, sysdate, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.inasusacticomp1 is not null then
           nuAjuste := Inactiva_Susp_Comp (rg.inasusacticomp1, sysdate, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.inasusacticomp2 is not null then
           nuAjuste := Inactiva_Susp_Comp (rg.inasusacticomp2, sysdate, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.inasusacticomp3 is not null then
           nuAjuste := Inactiva_Susp_Comp (rg.inasusacticomp3, sysdate, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.inasusacticomp4 is not null then
           nuAjuste := Inactiva_Susp_Comp (rg.inasusacticomp4, sysdate, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.modtiposusprod is not null then
           nuAjuste := Actualiza_TipoSusp_Prod (rg.producto, rg.modtiposusprod, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.modtiposuscomp1 is not null then
           nuAjuste := Actualiza_TipoSusp_Comp (rg.codicomp1, rg.modtiposuscomp1, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.modtiposuscomp2 is not null then
           nuAjuste := Actualiza_TipoSusp_Comp (rg.codicomp2, rg.modtiposuscomp2, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.modtiposuscomp3 is not null then
           nuAjuste := Actualiza_TipoSusp_Comp (rg.codicomp3, rg.modtiposuscomp3, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.ordsuspconeaten is not null then
           nuAjuste := Atiende_Suspcone (rg.producto, rg.ordsuspconeaten, sysdate, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

         if rg.ordsuspconeanul is not null then
           nuAjuste := Anula_Suspcone (rg.producto, rg.ordsuspconeanul, sysdate, osberrajuste);
           if nuAjuste <= 0 then
             goto fincuajustar;
           end if;
         end if;

			if rg.SOLI_RECONEXION is not null or  rg.ORDEN_SUSP_ANULAR is not null
					or  rg.ORDEN_SUSP_CREAR is not null then
			   nuAJuste := 1;
			end if;

			--se valdia informacion de los nuevos campos
            PRVALIINFOORDEN( rg.SOLI_RECONEXION,
                             rg.ORDEN_SUSP_ANULAR,
                             rg.ORDEN_SUSP_CREAR,
                             rg.producto,
                             nuErrorCode,
                             osberrajuste);
            IF nuErrorCode <> 0 THEN
                goto fincuajustar;
            END IF;

			if rg.ORDEN_SUSP_CREAR is not null then
				--se genera activacion de suspension
				PRGENERASUSP(  rg.ORDEN_SUSP_CREAR,
							  rg.producto,
							  nuErrorCode,
							  osberrajuste);
				IF nuErrorCode <> 0 THEN
					goto fincuajustar;
				END IF;
			end if;


            --se anulan solciitud y ordenes
            PRANULASOLITUDES(  rg.SOLI_RECONEXION,
                              rg.ORDEN_SUSP_ANULAR,
                              nuErrorCode,
                              osberrajuste);
            IF nuErrorCode <> 0 THEN
                goto fincuajustar;
            END IF;


         <<fincuajustar>>

         if nuAJuste <= 0 OR nuErrorCode <> 0 then
           rollback;
           if nuAjuste = 0 then
             osberrajuste := 'No se pudo ejecutar alguna de las acciones solicitadas';
           end if;

           update LDC_AJUSTA_SUSPCONE t
              set t.observacion = 'Error: ' || osberrajuste
            where rowid = rg.fila;
           commit;
         else
           commit;
           update LDC_AJUSTA_SUSPCONE t
              set t.observacion = 'Procesado'
            where rowid = rg.fila;
           commit;
         end if;
       end loop;

	 pkg_estaproc.practualizaestaproc(isbproceso => sbproceso,
									 isbEstado => 'OK',
									 isbObservacion => osbMsgError
									 );

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


    EXCEPTION
    when pkg_error.controlled_error then
      rollback;
	  pkg_error.getError(nuErrorCode, osberrajuste);
	  pkg_traza.trace(csbMetodo||' '||osberrajuste);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
	  pkg_estaproc.practualizaestaproc(isbproceso => sbproceso,
										isbEstado => 'ERROR',
										isbObservacion => osbMsgError
									   );
    when others then
      rollback;
   	  pkg_error.setError;
  	  pkg_error.getError(nuErrorCode, osberrajuste);
	  pkg_traza.trace(csbMetodo||' '||osberrajuste);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
	  pkg_estaproc.practualizaestaproc(isbproceso => sbproceso,
										isbEstado => 'ERROR',
										isbObservacion => osbMsgError
									   );END LeeArchivo;
----------------------------------------------------------------------------------
	function ActEstCorte (nusesu       in  servsusc.sesunuse%type,
                         nuesco_nuevo in  estacort.escocodi%type,
                         osberror     out varchar2) return number is

  nuactualizados 	number := 0;
  nuCodError  		number;
  csbMetodo  		CONSTANT VARCHAR2(100) := csbNOMPKG||'ActEstCorte'; --Nombre del método en la traza

	Begin
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
    update servsusc
       set sesuesco = nuesco_nuevo
     where sesunuse = nusesu;
     nuactualizados := sql%rowcount;

		Return nuactualizados;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
	
	Exception
   When Others Then
	pkg_error.setError;
	pkg_error.getError(nuCodError, osberror);
	pkg_traza.trace(csbMetodo||' '||osberror);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    return -1;
	End ActEstCorte;

----------------------------------------------------------------------

function ActEstProd    (nusesu        in  servsusc.sesunuse%type,
                        nuespr_nuevo in  pr_product.product_status_id%type,
                        osberror     out varchar2) return number is

  nuactualizados number := 0;
  nuCodError  number;
  csbMetodo  		CONSTANT VARCHAR2(100) := csbNOMPKG||'ActEstProd'; --Nombre del método en la traza

	Begin

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
    update pr_product p
       set p.product_status_id = nuespr_nuevo
     where p.product_id = nusesu;
     nuactualizados := sql%rowcount;

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

		Return nuactualizados;

	Exception
   When Others Then
	pkg_error.setError;
	pkg_error.getError(nuCodError, osberror);
	pkg_traza.trace(csbMetodo||' '||osberror);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    return -1;
	End ActEstProd;

----------------------------------------------------------------------

function ActEstComp    (nuCompId        in  pr_component.component_id%type,
                        nuescomp_nuevo in  pr_component.component_status_id%type,
                         osberror     out varchar2) return number is

  nuactualizados 	number := 0;
  nuCodError  		number;
  csbMetodo  		CONSTANT VARCHAR2(100) := csbNOMPKG||'ActEstComp'; --Nombre del método en la traza

	Begin
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
    update pr_component c
       set c.component_status_id = nuescomp_nuevo
     where c.component_id = nuCompId;
     nuactualizados := sql%rowcount;

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
	  
		Return nuactualizados;

	Exception
   When Others Then
	pkg_error.setError;
	pkg_error.getError(nuCodError, osberror);
	pkg_traza.trace(csbMetodo||' '||osberror);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    return -1;
	End ActEstComp;

----------------------------------------------------------------------

function ActUltActSusp  (nusesu        in  servsusc.sesunuse%type,
                         nuUltActSusp  in  pr_product.suspen_ord_act_id%type,
                         osberror      out varchar2) return number is

  nuactualizados number := 0;
  nuCodError     number := 0;
  nuUltActSusp2  pr_product.suspen_ord_act_id%type;
  csbMetodo  	 CONSTANT VARCHAR2(100) := csbNOMPKG||'ActUltActSusp'; --Nombre del método en la traza

	Begin

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
    if nuUltActSusp <= 0 then
      nuUltActSusp2 := null;
    else
      nuUltActSusp2 := nuUltActSusp;
    end if;

    update pr_product p
       set p.suspen_ord_act_id  = nuUltActSusp2
     where p.product_id = nusesu;
     nuactualizados := sql%rowcount;

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	Return nuactualizados;

	Exception
   When Others Then
	pkg_error.setError;
	pkg_error.getError(nuCodError, osberror);
	pkg_traza.trace(csbMetodo||' '||osberror);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    return -1;
	End ActUltActSusp;

----------------------------------------------------------------------

function Insert_Susp_Comp    (nusesu        in  servsusc.sesunuse%type,
                         nucompId      in  pr_comp_suspension.component_id%type,
                         osberror      out varchar2) return number is
 -- Inserta suspensiones de componentes con los datos de la susp activa del producto

  nuactualizados number := 0;
  nuCodError  number := 0;
  nuseq1 All_Sequences.LAST_NUMBER%type;

  cursor cuSuspProd is
   select p.prod_suspension_id, p.product_id, p.suspension_type_id, p.register_date, p.aplication_date, p.inactive_date, p.active
     from pr_prod_suspension p
    where p.product_id = nusesu
      and p.active = 'Y';

   rg cuSuspProd%rowtype;
   csbMetodo  	 CONSTANT VARCHAR2(100) := csbNOMPKG||'Insert_Susp_Comp'; --Nombre del método en la traza

	Begin
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    open cuSuspProd;
    fetch cuSuspProd into rg;
    if cuSuspProd%notfound then
      rg.prod_suspension_id := null;
    end if;
    close cuSuspProd;

    if rg.prod_suspension_id is not null then
      nuseq1 := SEQ_PR_COMP_SUSPENSION.NEXTVAL;
      insert into pr_comp_suspension(comp_suspension_id, component_id, suspension_type_id, register_date,
                               aplication_date,inactive_date, active)
                    values (nuseq1, nuCompId, rg.suspension_type_id, rg.register_date, rg.aplication_date, rg.inactive_date, rg.active);

     nuactualizados := sql%rowcount;
    end if;

     pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    Return nuactualizados;


	Exception
   When Others Then
	pkg_error.setError;
	pkg_error.getError(nuCodError, osberror);
	pkg_traza.trace(csbMetodo||' '||osberror);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    return -1;
	End Insert_Susp_Comp;

----------------------------------------------------------------------

function Insert_Susp_Prod    (nusesu        in  servsusc.sesunuse%type,
                              osberror      out varchar2) return number is
 -- Inserta suspension de producto con los datos de la susp activa de componente

  nuactualizados number := 0;
  nuCodError  number := 0;
  nuseq1 All_Sequences.LAST_NUMBER%type;

  cursor cuSuspComp is
   select p.*
  from pr_comp_suspension p
  where p.component_id in (SELECT cp.component_id
                             from pr_component cp
                            where cp.product_id = nusesu)
   and p.active = 'Y';

   rg cuSuspComp%rowtype;
   csbMetodo  	 CONSTANT VARCHAR2(100) := csbNOMPKG||'Insert_Susp_Prod'; --Nombre del método en la traza

	Begin
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    open cuSuspComp;
    fetch cuSuspComp into rg;
    if cuSuspComp%notfound then
      rg.comp_suspension_id := null;
    end if;
    close cuSuspComp;

    if rg.comp_suspension_id is not null then
      nuseq1 := SEQ_PR_PROD_SUSPENSION.NEXTVAL;
      insert into pr_prod_suspension(prod_suspension_id, product_id, suspension_type_id, register_date, aplication_date, inactive_date, active)
                    values (nuseq1, nusesu, rg.suspension_type_id, rg.register_date, rg.aplication_date, rg.inactive_date, rg.active);

      nuactualizados := sql%rowcount;
    end if;

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	Return nuactualizados;


	Exception
   When Others Then
	pkg_error.setError;
	pkg_error.getError(nuCodError, osberror);
	pkg_traza.trace(csbMetodo||' '||osberror);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    return -1;
	End Insert_Susp_Prod;

----------------------------------------------------------------------

function Inactiva_Susp_Prod  (nusesu        in  servsusc.sesunuse%type,
                              nuProdSuspId   in  pr_prod_suspension.prod_suspension_id%type,
                              dtInacDate     in  date,
                              osberror      out varchar2) return number is


  nuactualizados 	number := 0;
  nuCodError  		number := 0;
  csbMetodo  	 	CONSTANT VARCHAR2(100) := csbNOMPKG||'Inactiva_Susp_Prod'; --Nombre del método en la traza

	Begin
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    update pr_prod_suspension
       set inactive_Date      =  dtInacDate,
           active             =  'N'
     where prod_suspension_id =  nuProdSuspId
       and product_id         =  nusesu;

     nuactualizados := sql%rowcount;

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	Return nuactualizados;


	Exception
   When Others Then
	pkg_error.setError;
	pkg_error.getError(nuCodError, osberror);
	pkg_traza.trace(csbMetodo||' '||osberror);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    return -1;
	End Inactiva_Susp_Prod;

----------------------------------------------------------------------

function Actualiza_TipoSusp_Prod  (nusesu        in  servsusc.sesunuse%type,
                                nuSuspTypeID   in  pr_prod_suspension.suspension_type_id%type,
                              osberror      out varchar2) return number is


  nuactualizados 	number := 0;
  nuCodError  		number := 0;
  csbMetodo  	 	CONSTANT VARCHAR2(100) := csbNOMPKG||'Actualiza_TipoSusp_Prod'; --Nombre del método en la traza

	Begin
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    update pr_prod_suspension p
       set suspension_type_id =  nuSuspTypeID
     where product_id         =  nusesu
       and p.active = 'Y';

     nuactualizados := sql%rowcount;

		Return nuactualizados;

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	Exception
   When Others Then
	pkg_error.setError;
	pkg_error.getError(nuCodError, osberror);
	pkg_traza.trace(csbMetodo||' '||osberror);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    return -1;
	End Actualiza_TipoSusp_Prod;

----------------------------------------------------------------------

function Inactiva_Susp_Comp  (nuCompSuspId   in  pr_comp_suspension.comp_suspension_id%type,
                              dtInacDate     in  date,
                              osberror      out varchar2) return number is


  nuactualizados 	number := 0;
  nuCodError  		number := 0;
  csbMetodo  	 	CONSTANT VARCHAR2(100) := csbNOMPKG||'Inactiva_Susp_Comp'; --Nombre del método en la traza

	Begin

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    update pr_comp_suspension
       set inactive_Date      =  dtInacDate,
           active             =  'N'
     where comp_suspension_id =  nuCompSuspId;

     nuactualizados := sql%rowcount;
	 
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	Return nuactualizados;


	Exception
   When Others Then
	pkg_error.setError;
	pkg_error.getError(nuCodError, osberror);
	pkg_traza.trace(csbMetodo||' '||osberror);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    return -1;
	End Inactiva_Susp_Comp;

----------------------------------------------------------------------

function Actualiza_TipoSusp_Comp  (nuCompSuspId   in  pr_comp_suspension.comp_suspension_id%type,
                              nuSuspTypeID   in  pr_comp_suspension.suspension_type_id%type,
                              osberror      out varchar2) return number is


  nuactualizados 	number := 0;
  nuCodError  		number := 0;
  csbMetodo  	 	CONSTANT VARCHAR2(100) := csbNOMPKG||'Actualiza_TipoSusp_Comp'; --Nombre del método en la traza

	Begin
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    update pr_comp_suspension
       set suspension_type_id =  nuSuspTypeID
      where comp_suspension_id =  nuCompSuspId
        and active = 'Y';

     nuactualizados := sql%rowcount;

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
	
	Return nuactualizados;


	Exception
   When Others Then
	pkg_error.setError;
	pkg_error.getError(nuCodError, osberror);
	pkg_traza.trace(csbMetodo||' '||osberror);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    return -1;
	End Actualiza_TipoSusp_Comp;

----------------------------------------------------------------------

function Atiende_Suspcone  (nusesu        in  servsusc.sesunuse%type,
                              nuOrden   in  suspcone.suconuor%type,
                              dtFecha   in date,
                              osberror      out varchar2) return number is


  nuactualizados 	number := 0;
  nuCodError  		number := 0;
  csbMetodo  	 	CONSTANT VARCHAR2(100) := csbNOMPKG||'Atiende_Suspcone'; --Nombre del método en la traza

	Begin

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    update suspcone
       set sucofeat =  dtFecha
      where suconuse =  nusesu
        and suconuor = nuOrden;

     nuactualizados := sql%rowcount;

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
	
	Return nuactualizados;


	Exception
   When Others Then
	pkg_error.setError;
	pkg_error.getError(nuCodError, osberror);
	pkg_traza.trace(csbMetodo||' '||osberror);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    return -1;
	End Atiende_Suspcone;

----------------------------------------------------------------------
FUNCTION fboGetIsNumber
    (
	isbValor varchar2
    ) return boolean is

blResult 		boolean := TRUE;
nuRes    		number;
csbMetodo  	 	CONSTANT VARCHAR2(100) := csbNOMPKG||'fboGetIsNumber'; --Nombre del método en la traza
nuError         NUMBER;
sbError         VARCHAR2(4000);



BEGIN

 pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

 begin
   nuRes := to_number(isbValor);
 exception when others then
   blResult := FALSE;
 end;

 pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

 return (blResult);

EXCEPTION
    when others then
	pkg_error.setError;
	pkg_error.getError(nuError, sbError);
	pkg_traza.trace(csbMetodo||' '||sbError);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    return (FALSE);
END fboGetIsNumber;
----------------------------------------------------------------------
function Anula_Suspcone  (nusesu        in  servsusc.sesunuse%type,
                              nuOrden   in  suspcone.suconuor%type,
                              dtFecha   in date,
                              osberror      out varchar2) return number is


  nuactualizados 	number := 0;
  nuCodError  		number := 0;
  csbMetodo  	 	CONSTANT VARCHAR2(100) := csbNOMPKG||'Anula_Suspcone'; --Nombre del método en la traza

	Begin

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    update suspcone
       set sucotipo = 'A',
            sucofeat =  dtFecha
      where suconuse =  nusesu
        and suconuor = nuOrden;

     nuactualizados := sql%rowcount;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	Return nuactualizados;


	Exception
   When Others Then
	pkg_error.setError;
	pkg_error.getError(nuCodError, osberror);
	pkg_traza.trace(csbMetodo||' '||osberror);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    return -1;
	End Anula_Suspcone;

------------------------------------------------------------------------------------------------------------------------

procedure InsertaLog (osbobservacion in varchar2) is
/****************************
Historial de Modificaciones
 Fecha         Autor            Observacion
 03-08-2022    cgonzalez		OSF-448: Se ajusta para tener en cuenta el campo MOTIVO de la entidad LDC_AJUSTA_SUSPCONE
 09/01/2021    Horbath          ca 711 se agregan los campos SOLI_RECONEXION,ORDEN_SUSP_ANULAR,ORDEN_SUSP_CREAR
****************************/
  csbMetodo  	 	CONSTANT VARCHAR2(100) := csbNOMPKG||'InsertaLog'; --Nombre del método en la traza
  sbparuser     varchar(100) := PKG_SESSION.GETUSER;
begin
  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
  insert into  LDC_AJUSTA_SUSPCONE (usuario, fecha,  sesion, sesion_analisis,
                                    Producto,  ModEstProd,  ModEstCorte,
                                    CodiComp1,  ModEstComp1,  CodiComp2,  ModEstComp2,
                                    CodiComp3,  ModEstComp3,  ModUltActSusp,  AgrSusActiProd,
                                    AgrSusActiComp1,  AgrSusActiComp2,  AgrSusActiComp3,  InaSusActiProd1, InaSusActiProd2,
                                    InaSusActiComp1,  InaSusActiComp2,  InaSusActiComp3,  InaSusActiComp4, ModTipoSusProd,
                                    ModTipoSusComp1,  ModTipoSusComp2,  ModTipoSusComp3,  OrdSuspConeAten,
                                    OrdSuspConeAnul, observacion, SOLI_RECONEXION,ORDEN_SUSP_ANULAR,ORDEN_SUSP_CREAR, MOTIVO)
                 values (sbparuser, dtfechaproceso, nutsess, sbSesion,
                         sbProducto, sbModEstProd, sbModEstCorte,
                         sbCodiComp1, sbModEstComp1, sbCodiComp2, sbModEstComp2,
                         sbCodiComp3, sbModEstComp3, sbModUltActSusp, sbAgrSusActiProd,
                         sbAgrSusActiComp1, sbAgrSusActiComp2, sbAgrSusActiComp3, sbInaSusActiProd1, sbInaSusActiProd2,
                         sbInaSusActiComp1, sbInaSusActiComp2, sbInaSusActiComp3, sbInaSusActiComp4, sbModTipoSusProd,
                         sbModTipoSusComp1, sbModTipoSusComp2, sbModTipoSusComp3, sbOrdSuspConeAten,
                         sbOrdSuspConeAnul, osbobservacion,  sbSoliRecoAnul , sbOrdeSuspAnul , sbOrdeSuspacti, sbMotivo);

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    
	COMMIT;
	

end InsertaLog;

PROCEDURE PRVALIINFOORDEN( inusoliReco IN NUMBER,
                           inuordensusp IN NUMBER,
                           inuOrdenSuspac IN NUMBER,
                           inuProducto IN NUMBER,
                           onuError OUT NUMBER,
                           osbError OUT VARCHAR2) IS
	/*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: PRVALIINFOORDEN
  Descripcion:        valida informacion de ordenes y reconexion

  Autor    : Horbath
  Fecha    : 09/04/2021  CA 711

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  ******************************************************************/
   sbTipoSoliAnul VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TIPOSOLANUL', NULL);
   sbEstadoOrden VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ESTAORDANUL', NULL);
   sbTitrSuspAnul VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TITRSUSPANUL', NULL);

   nuproducto NUMBER;
   nuestado NUMBER;
   nuExiste NUMBER;
   nuclascausal NUMBER;

   CURSOR cuValidaSoliReco IS
   SELECT m.product_id, s.motive_status_id
   FROM mo_packages s, MO_MOTIVE m
   WHERE s.package_id = m.package_id
    AND s.package_id  = inusoliReco
    AND s.package_type_id in ( SELECT to_number(regexp_substr(sbTipoSoliAnul,'[^,]+', 1, LEVEL)) AS tiposoli
                               FROM dual
                               CONNECT BY regexp_substr(sbTipoSoliAnul, '[^,]+', 1, LEVEL) IS NOT NULL);

    CURSOR cuValidaOrdenSusp(inuorden NUMBER) IS
    SELECT oa.product_id, o.order_status_id, pkg_bcordenes.fnuobtieneclasecausal(o.causal_id) CLASECAUSAL
    FROM or_order o, or_order_activity oa
    WHERE o.order_id = oa.order_id
     AND o.order_id = inuorden
     AND o.TASK_TYPE_ID in ( SELECT to_number(regexp_substr(sbTitrSuspAnul,'[^,]+', 1, LEVEL)) AS tipotrab
                               FROM dual
                               CONNECT BY regexp_substr(sbTitrSuspAnul, '[^,]+', 1, LEVEL) IS NOT NULL);
							   
	csbMetodo  	 	CONSTANT VARCHAR2(100) := csbNOMPKG||'PRVALIINFOORDEN'; --Nombre del método en la traza
	
  BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

   onuError := 0;
   osberror := NULL;

    IF inusoliReco IS NOT NULL THEN
      OPEN cuValidaSoliReco;
      FETCH cuValidaSoliReco INTO nuproducto, nuestado;
      IF cuValidaSoliReco%NOTFOUND THEN
        onuError := -1;
        osbError := 'Solicitud ['||inusoliReco||'] no es de los tipos configurados en el parametro LDC_TIPOSOLANUL.';
        CLOSE cuValidaSoliReco;
        return;
      ELSE
        IF nuestado <> 13 THEN
            onuError := -1;
            osbError := 'Solicitud ['||inusoliReco||'] no se encuentra en un estado valido para el proceso.';
            CLOSE cuValidaSoliReco;
            return;
        END IF;

         IF nuproducto <> inuProducto THEN
            onuError := -1;
            osbError := 'Solicitud ['||inusoliReco||'] no esta asociada al producto ['||inuProducto||']';
            CLOSE cuValidaSoliReco;
            return;
        END IF;
      END IF;
      CLOSE cuValidaSoliReco;

    END IF;

    IF inuOrdenSuspac IS NOT NULL AND inuordensusp IS NOT NULL THEN
       IF inuOrdenSuspac = inuordensusp THEN
          onuError := -1;
          osbError := 'Orden de trabajo anular ['||inuordensusp||'] no puede ser igual a la orden de trabajo activar suspension ['||inuOrdenSuspac||']';
          return;
       END IF;
    END IF;

    IF inuordensusp IS NOT NULL THEN
      nuestado := null;
      nuproducto := null;
      nuclascausal := NULL;

      OPEN cuValidaOrdenSusp(inuordensusp);
      FETCH cuValidaOrdenSusp INTO nuproducto, nuestado, nuclascausal;
      IF cuValidaOrdenSusp%NOTFOUND THEN
        onuError := -1;
        osbError := 'Orden de trabajo de suspension  ['||inuordensusp||'] no es de los tipos de trabajos configurados en el parametro LDC_TITRSUSPANUL.';
        return;
        CLOSE cuValidaOrdenSusp;
      ELSE
         SELECT COUNT(1) INTO nuExiste
         FROM (
         ( SELECT to_number(regexp_substr(sbEstadoOrden,'[^,]+', 1, LEVEL)) AS estaorde
           FROM dual
           CONNECT BY regexp_substr(sbEstadoOrden, '[^,]+', 1, LEVEL) IS NOT NULL) ) t
         WHERE estaorde =  nuestado;

        IF nuExiste = 0 THEN
            onuError := -1;
            osbError := 'Orden de trabajo de suspension  ['||inuordensusp||'] no se encuentra en un estado valido para el proceso.';
            CLOSE cuValidaOrdenSusp;
            return;
        END IF;

         IF nuproducto <> inuProducto THEN
            onuError := -1;
            osbError := 'Orden de trabajo de suspension ['||inuordensusp||'] no esta asociada al producto ['||inuProducto||']';
            CLOSE cuValidaOrdenSusp;
            return;
        END IF;
      END IF;
      CLOSE cuValidaOrdenSusp;
    END IF;

    IF inuOrdenSuspac IS NOT NULL THEN
      nuestado := null;
      nuproducto := null;
      nuclascausal := NULL;

      OPEN cuValidaOrdenSusp(inuOrdenSuspac);
      FETCH cuValidaOrdenSusp INTO nuproducto, nuestado,nuclascausal;
      IF cuValidaOrdenSusp%NOTFOUND THEN
        onuError := -1;
        osbError := 'Orden de trabajo  para activar suspension ['||inuOrdenSuspac||'] no es de los tipos de trabajos configurados en el parametro LDC_TITRSUSPANUL.';
        return;
        CLOSE cuValidaOrdenSusp;
      ELSE

        IF nuestado <> 8 THEN
            onuError := -1;
            osbError := 'Orden de trabajo  para activar suspension ['||inuOrdenSuspac||'] no se encuentra en un estado valido para el proceso.';
            CLOSE cuValidaOrdenSusp;
            return;
        END IF;

        IF nuclascausal <> 1 THEN
            onuError := -1;
            osbError := 'Orden de trabajo  para activar suspension ['||inuOrdenSuspac||'] no esta legalizada con exito.';
            CLOSE cuValidaOrdenSusp;
            return;
        END IF;

         IF nuproducto <> inuProducto THEN
            onuError := -1;
            osbError := 'Orden de trabajo para activar suspension ['||inuOrdenSuspac||'] no esta asociada al producto ['||inuProducto||']';
            CLOSE cuValidaOrdenSusp;
            return;
        END IF;
      END IF;
      CLOSE cuValidaOrdenSusp;
    END IF;
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

 Exception
   When Others Then
	pkg_error.setError;
	pkg_error.getError(onuError, osberror);
	pkg_traza.trace(csbMetodo||' '||osberror);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END PRVALIINFOORDEN;

   PROCEDURE	PRGENERASUSP( inuOrden IN NUMBER,
                          inuproducto IN NUMBER,
                          onuerror OUT NUMBER,
                          osberror OUT VARCHAR2) IS
 /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: PRGENERASUSP
  Descripcion:        proceso que se encarga de actualizar o generar pr_prod_suspension

  Autor    : Horbath
  Fecha    : 09/04/2021  CA 711

  Parametro de Entrada:
    inuOrden    codigo de la orden
    inuproducto  codigo del producto
  Parametro de salida:
    onuerror    codigo de error
    osberror    mensaje de error

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  ******************************************************************/

    sbActivesusp VARCHAR2(1);
    nuProdSusp NUMBER;
    nuseq1 NUMBER;
    sbexiste VARCHAR2(1);
	nuTipoTrab NUMBER;
	dtFechaLega  DATE;
	nuTipoSusp NUMBER;

	CURSOR cugetInfoOrden Is
	SELECT O.LEGALIZATION_DATE, o.task_type_id
	FROM OR_ORDER O
	WHERE O.ORDER_ID = inuOrden
      ;

    CURSOR cugetSusp IS
    SELECT pr.*
    from pr_prod_suspension PR
    WHERE PR.aplication_date = dtFechaLega
     AND pr.product_id = inuproducto;

   regSusp   cugetSusp%rowtype;


    CURSOR cuGetInfoCompactiv IS
    SELECT *
    FROM pr_comp_suspension p
    WHERE p.component_id in (SELECT cp.component_id
                                 from pr_component cp
                                where cp.product_id = inuproducto)
      AND APLICATION_DATE = dtFechaLega;

    rg cuGetInfoCompactiv%rowtype;

   CURSOR cugetComponentes IS
   SELECT cp.component_id
   from pr_component cp
   where cp.product_id = inuproducto;

   CURSOR cuGetTipsusp Is
   SELECT tiposusp
   FROM LDC_TITRTISU
   WHERE tipotrab = nuTipoTrab;
   
   csbMetodo  	 	CONSTANT VARCHAR2(100) := csbNOMPKG||'PRGENERASUSP'; --Nombre del método en la traza

 BEGIN
 
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
   onuError := 0;
   osberror := NULL;

   OPEN cugetInfoOrden;
   FETCH cugetInfoOrden INTO dtFechaLega, nuTipoTrab;
   CLOSE cugetInfoOrden;

   OPEN cugetSusp;
   FETCH cugetSusp INTO regSusp;
   CLOSE cugetSusp;

   open cuGetInfoCompactiv;
   fetch cuGetInfoCompactiv into rg;
   if cuGetInfoCompactiv%notfound then
        rg.comp_suspension_id := null;
   end if;
   close cuGetInfoCompactiv;

   IF regSusp.active = 'N' THEN
      UPDATE pr_prod_suspension SET active = 'Y', INACTIVE_DATE = null
      WHERE PROD_SUSPENSION_ID = nuProdSusp;

      IF Rg.comp_suspension_id IS NULL THEN

		FOR regC IN cugetComponentes LOOP
		  nuseq1 := SEQ_PR_COMP_SUSPENSION.NEXTVAL;
		  insert into pr_comp_suspension(comp_suspension_id, component_id, suspension_type_id, register_date,
                                       aplication_date,inactive_date, active)
                            values (nuseq1, regC.component_id, regSusp.suspension_type_id, regSusp.register_date, regSusp.aplication_date, regSusp.inactive_date, regSusp.active);
        END LOOP;
      ELSE
		update pr_comp_suspension set active = 'Y', inactive_date = null
		WHERE component_id in (SELECT cp.component_id
								 from pr_component cp
								 where cp.product_id = inuproducto)
		  and aplication_date = regSusp.aplication_date;
      END IF;
   else
    IF regSusp.active IS NULL THEN
       nuseq1 := SEQ_PR_PROD_SUSPENSION.NEXTVAL;

       IF  rg.comp_suspension_id IS NOT NULL THEN
           insert into pr_prod_suspension(prod_suspension_id, product_id, suspension_type_id, register_date, aplication_date, inactive_date, active)
                      values (nuseq1, inuproducto, rg.suspension_type_id, rg.register_date, rg.aplication_date, rg.inactive_date, rg.active);
       ELSE
         OPEN cuGetTipsusp;
		 FETCH cuGetTipsusp INTO nuTipoSusp;
		 IF cuGetTipsusp%NOTFOUND THEN
		    onuError := -1;
           osbError := 'El tipo de trabajo ['||nuTipoTrab||'] no esta configurado en la forma LDCCTTTS';
		   close cuGetTipsusp;
		   return;
		 END IF;
		 CLOSE cuGetTipsusp;

		 insert into pr_prod_suspension(prod_suspension_id, product_id, suspension_type_id, register_date, aplication_date, inactive_date, active)
				  values (nuseq1, inuproducto, nuTipoSusp, dtFechaLega, dtFechaLega, null, 'Y');

		 nuseq1 := SEQ_PR_COMP_SUSPENSION.NEXTVAL;
		 FOR regC IN cugetComponentes LOOP
			  nuseq1 := SEQ_PR_COMP_SUSPENSION.NEXTVAL;
			  insert into pr_comp_suspension(comp_suspension_id, component_id, suspension_type_id, register_date,
										   aplication_date,inactive_date, active)
								values (nuseq1, regC.component_id, nuTipoSusp, dtFechaLega, dtFechaLega, NULL, 'Y');
        END LOOP;
       END IF;
    END IF;
   END IF;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

 Exception
   When Others Then
	pkg_error.setError;
	pkg_error.getError(onuError, osberror);
	pkg_traza.trace(csbMetodo||' '||osberror);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END PRGENERASUSP;

  PROCEDURE  PRANULASOLITUDES( inuSoliReco IN NUMBER,
                               inuOrdenSusp IN NUMBER,
                               onuerror OUT NUMBER,
                               osberror OUT VARCHAR2) is
  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: PRANULASOLITUDES
  Descripcion:        proceso que se encarga de anular solicitud y ordenes de suspension

  Autor    : Horbath
  Fecha    : 09/04/2021  CA 711

  Parametro de Entrada:
    inuSoliReco    codigo de la solicitud de reconexion
    inuOrdenSusp   codigo de la orden de suspension
  Parametro de salida:
    onuerror    codigo de error
    osberror    mensaje de error

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.             	 Modificacion
  -----------  -------------------   	 -------------------------------------
  23-09-2022   cgonzalez			  OSF-570: Se modifica para anular la orden de la variable inuOrdenSusp
  16-05-2022   cgonzalez			     OSF-129: Se modifica para no procesar 2 veces la solicitud
  26-01-2022   Danilo Barranco, Horbath  Se modififica cursor, para que muestre las solicitudes sin ordenes
  ******************************************************************/

  cnuCommentType     CONSTANT NUMBER := 83;
  nuNotas            number;
  TYPE tblsolicitudes IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
  nuPlanId           wf_instance.instance_id%type;
  vtbsolicitudes    tblsolicitudes;
  nuError NUMBER;
  sbError VARCHAR2(4000);
  nuInteraccion NUMBER;
  nuTipoSoli  NUMBER;
  nuMotivOEstado  NUMBER;
  nuEstadoOrden		NUMBER;

  nuCausalMoti NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CODCAUANUMOTI', NULL);
  nuCausalOrden  NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CODCAUSANULORD', NULL);
  nuCausalAnuSoli NUMBER := ge_boparameter.fnuget('ANNUL_CAUSAL');
  sbEstadoOrden VARCHAR2(400) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ESTAORDANUL', NULL);

CURSOR cugetOrdenesanular IS
SELECT a.order_id,p.package_id,o.order_status_id
  FROM mo_packages p
  left Join or_order_activity A on p.package_id = a.package_id
  left Join or_order o          on a.order_id = o.order_id
 where p.package_id = inuSoliReco
   AND o.order_status_id IN (SELECT to_number(regexp_substr(sbEstadoOrden,'[^,]+', 1, LEVEL)) AS ESOR
                              FROM   dual
                             CONNECT BY regexp_substr(sbEstadoOrden, '[^,]+', 1, LEVEL) IS NOT NULL )
union
 SELECT null,p.package_id, null
  FROM mo_packages p
  where p.package_id = inuSoliReco;

	--  Cursor de Suspensiones
	CURSOR cugetOrdenesSuspanul IS
		SELECT 	o.order_id, a.package_id, o.order_status_id
		FROM 	or_order o, or_order_activity a
		WHERE 	o.order_id = inuOrdenSusp
		AND 	a.order_id = o.order_id
		AND 	o.order_status_id IN (SELECT to_number(regexp_substr(sbEstadoOrden,'[^,]+', 1, LEVEL)) AS ESOR
									FROM dual
									CONNECT BY regexp_substr(sbEstadoOrden, '[^,]+', 1, LEVEL) IS NOT NULL);
									
	csbMetodo  	 	CONSTANT VARCHAR2(100) := csbNOMPKG||'cugetOrdenesanular'; --Nombre del método en la traza

  begin
  
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
  
    onuerror := 0;
    IF inuSoliReco IS NOT NULL THEN
       --ANULACION DE RECONEXION
       FOR reg IN cugetOrdenesanular LOOP
         nuError := 0;
         nuInteraccion := NULL;
         nuTipoSoli := NULL;
         nuMotivOEstado := NULL;
         nuPlanId := NULL;

         IF reg.package_id is not null THEN
            
            -- se reversan los cargos generados
            IF vtbsolicitudes.exists(reg.package_id) THEN
				NULL;
            ELSE
				ldc_pkg_changstatesolici.packageinttransition(reg.package_id,nuCausalAnuSoli);
				
				BEGIN
					nuNotas := fnureqchargescancell(reg.package_id);
				EXCEPTION
					WHEN OTHERS THEN
						pkg_error.seterror;
						pkg_error.geterror(nuError, sbError);
						pkg_error.seterrormessage(pkg_error.CNUGENERIC_MESSAGE,'Error en fnureqchargescancell, solicitud ['||reg.package_id||'] error '||sbError);
		        END;
				
				vtbsolicitudes(reg.package_id) := reg.package_id;
				
				--Cambio estado de la solicitud
				UPDATE mo_packages
                SET motive_status_id = dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
				WHERE package_id = reg.package_id;

				nuInteraccion := damo_packages.fsbgetcust_care_reques_num(reg.package_id,null);
				nuTipoSoli := pkg_bcsolicitudes.fnugettiposolicitud(reg.package_id);
				nuMotivOEstado :=  DAMO_MOTIVE.FNUGETMOTIVE_STATUS_ID(MO_BCPACKAGES.FNUGETMOTIVEID(reg.package_id));

				INSERT INTO MO_PACKAGE_CHNG_LOG  ( CURRENT_USER_ID,
                                                  CURRENT_USER_MASK,
                                                  CURRENT_TERMINAL,
                                                  CURRENT_TERM_IP_ADDR,
                                                  CURRENT_DATE,
                                                  CURRENT_TABLE_NAME,
                                                  CURRENT_EXEC_NAME,
                                                  CURRENT_SESSION_ID,
                                                  CURRENT_EVENT_ID,
                                                  CURRENT_EVEN_DESC,
                                                  CURRENT_PROGRAM,
                                                  CURRENT_MODULE,
                                                  CURRENT_CLIENT_INFO,
                                                  CURRENT_ACTION,
                                                  PACKAGE_CHNG_LOG_ID,
                                                  PACKAGE_ID,
                                                  CUST_CARE_REQUES_NUM,
                                                  PACKAGE_TYPE_ID,
                                                  O_MOTIVE_STATUS_ID,
                                                  N_MOTIVE_STATUS_ID
                                                  )
                                               VALUES
                                               (
                                                  AU_BOSystem.getSystemUserID,
                                                  AU_BOSystem.getSystemUserMask,
                                                  pkg_session.fsbgetterminal,
                                                  pkg_session.getip,
                                                  ldc_boconsgenerales.fdtgetsysdate,
                                                  'MO_PACKAGES',
                                                  AU_BOSystem.getSystemProcessName,
                                                  pkg_session.fnugetsesion,
                                                  ge_boconstants.UPDATE_,
                                                  'UPDATE',
                                                  pkg_session.getprogram||'-'|| 'ANULACION POR PROCESO DE TERMINACION DE CONTRATO',
                                                  pkg_session.fsbobtenermodulo,
                                                  ut_session.GetClientInfo,
                                                  ut_session.GetAction,
                                                  MO_BOSEQUENCES.fnuGetSeq_MO_PACKAGE_CHNG_LOG,
                                                  reg.package_id,
                                                  nuInteraccion,
                                                  nuTipoSoli,
                                                  nuMotivOEstado,
                                                  dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
                                              ) ;
				--Cambio estado del motivo
				UPDATE mo_motive
                SET annul_date         = SYSDATE,
                     status_change_date = SYSDATE,
                     annul_causal_id    = ge_boparameter.fnuget('ANNUL_CAUSAL'),
                     motive_status_id   = 5,
                     causal_id          = nuCausalMoti
				WHERE package_id = reg.package_id;
				-- Se obtiene el plan de wf
				BEGIN
					nuPlanId := wf_boinstance.fnugetplanid( reg.package_id, 17);
				EXCEPTION
					WHEN OTHERS THEN
						null;
				END;
				-- anula el plan de wf
				if nuPlanId is not null then
					BEGIN
						pkgmanejosolicitudes.pannulplanworkflow(reg.package_id);
					EXCEPTION
						WHEN OTHERS THEN
							BEGIN
								WF_BOINSTANCE.UPDANNULPLANSTATUS(nuPlanId);
							EXCEPTION
								WHEN OTHERS THEN
									pkg_error.seterror;
									pkg_error.geterror(nuError, sbError);
									pkg_error.seterrormessage(pkg_error.CNUGENERIC_MESSAGE,'Error en anulacion de plan de wf, solicitud ['||reg.package_id||'] error '||sbError);
							END;
					END;
				END IF;
            END IF;
        END IF;

        --se anula orden de trabajo
        -- si esta bloqueada se desbloquea primero
        if reg.order_status_id = 11 then
			api_unlockorder( reg.order_id,
							  1277,
							  'DESBLOQUEO DE ORDEN POR PROCESO DE TERMINACION DE CONTRATO',
							  sysdate,
							  nuError,
							  sbError
							);
							
			IF nuError <> 0 THEN
				PKG_ERROR.seterrormessage(pkg_error.CNUGENERIC_MESSAGE,'Error desbloqueando orden  ['||reg.order_id||'] error '||sbError);
			END IF;
			
        end if;
        
		if reg.order_id is not null then
			if (PKG_BCORDENES.FNUOBTIENEESTADO(reg.order_id) in (pkg_gestionordenes.cnuordenasignada, pkg_gestionordenes.cnuordenregistrada)) then
          
				ldc_cancel_order(
                           reg.order_id,
                           nuCausalOrden,
                           'ANULACION POR PROCESO DE LDCAISP',
                           cnuCommentType,
                           nuError,
                           sbError
                           );

				IF nuError <> 0 THEN
					PKG_ERROR.seterrormessage(pkg_error.CNUGENERIC_MESSAGE,'Error anulando orden  ['||reg.order_id||'] error '||sbError);
				END IF;
			End If;  --- fin estado
		  End If;  --- Fin orden null
      END LOOP;
    END IF;

    IF inuOrdenSusp IS  NOT NULL THEN
       FOR reg IN cugetOrdenesSuspanul LOOP
         nuError := 0;
         nuInteraccion := NULL;
         nuTipoSoli := NULL;
         nuMotivOEstado := NULL;
         nuPlanId := NULL;

		 IF reg.package_id is not null THEN

            -- se reversan los cargos generados
            IF vtbsolicitudes.exists(reg.package_id) THEN
				NULL;
            ELSE
				ldc_pkg_changstatesolici.packageinttransition(reg.package_id,nuCausalAnuSoli);
			
				BEGIN
					nuNotas := fnureqchargescancell(reg.package_id);
				EXCEPTION
					WHEN OTHERS THEN
						pkg_error.seterror;
						pkg_error.geterror(nuError, sbError);
						PKG_ERROR.seterrormessage(pkg_error.CNUGENERIC_MESSAGE,'Error en fnureqchargescancell, solicitud ['||reg.package_id||'] error '||sbError);
		        END;
				
				vtbsolicitudes(reg.package_id) := reg.package_id;
				
				--Cambio estado de la solicitud
				UPDATE mo_packages
                SET motive_status_id = dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
				WHERE package_id = reg.package_id;

				nuInteraccion := damo_packages.fsbgetcust_care_reques_num(reg.package_id,null);
				nuTipoSoli := pkg_bcsolicitudes.fnugettiposolicitud(reg.package_id);
				nuMotivOEstado :=  DAMO_MOTIVE.FNUGETMOTIVE_STATUS_ID(MO_BCPACKAGES.FNUGETMOTIVEID(reg.package_id));

				INSERT INTO MO_PACKAGE_CHNG_LOG  ( CURRENT_USER_ID,
                                                  CURRENT_USER_MASK,
                                                  CURRENT_TERMINAL,
                                                  CURRENT_TERM_IP_ADDR,
                                                  CURRENT_DATE,
                                                  CURRENT_TABLE_NAME,
                                                  CURRENT_EXEC_NAME,
                                                  CURRENT_SESSION_ID,
                                                  CURRENT_EVENT_ID,
                                                  CURRENT_EVEN_DESC,
                                                  CURRENT_PROGRAM,
                                                  CURRENT_MODULE,
                                                  CURRENT_CLIENT_INFO,
                                                  CURRENT_ACTION,
                                                  PACKAGE_CHNG_LOG_ID,
                                                  PACKAGE_ID,
                                                  CUST_CARE_REQUES_NUM,
                                                  PACKAGE_TYPE_ID,
                                                  O_MOTIVE_STATUS_ID,
                                                  N_MOTIVE_STATUS_ID
                                                  )
                                               VALUES
                                               (
                                                  AU_BOSystem.getSystemUserID,
                                                  AU_BOSystem.getSystemUserMask,
                                                  pkg_session.fsbgetterminal,
                                                  pkg_session.getip,
                                                  ldc_boconsgenerales.fdtgetsysdate,
                                                  'MO_PACKAGES',
                                                  AU_BOSystem.getSystemProcessName,
                                                  pkg_session.fnugetsesion,
                                                  ge_boconstants.UPDATE_,
                                                  'UPDATE',
                                                  pkg_session.getprogram||'-'|| 'ANULACION POR PROCESO DE TERMINACION DE CONTRATO',
                                                  pkg_session.fsbobtenermodulo,
                                                  ut_session.GetClientInfo,
                                                  ut_session.GetAction,
                                                  MO_BOSEQUENCES.fnuGetSeq_MO_PACKAGE_CHNG_LOG,
                                                  reg.package_id,
                                                  nuInteraccion,
                                                  nuTipoSoli,
                                                  nuMotivOEstado,
                                                  dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
                                              ) ;
				--Cambio estado del motivo
				UPDATE 	mo_motive
                SET 	annul_date         = SYSDATE,
						status_change_date = SYSDATE,
						annul_causal_id    = ge_boparameter.fnuget('ANNUL_CAUSAL'),
						motive_status_id   = 5,
						causal_id          = nuCausalMoti
				WHERE package_id = reg.package_id;
             
				-- Se obtiene el plan de wf
				BEGIN
					nuPlanId := wf_boinstance.fnugetplanid( reg.package_id, 17);
				EXCEPTION
					WHEN OTHERS THEN
						null;
				END;
				
				-- anula el plan de wf
				if nuPlanId is not null then
					BEGIN
						pkgmanejosolicitudes.pannulplanworkflow(reg.package_id);
					EXCEPTION
						WHEN OTHERS THEN
							BEGIN
								WF_BOINSTANCE.UPDANNULPLANSTATUS(nuPlanId);
							EXCEPTION
								WHEN OTHERS THEN
									pkg_error.seterror;
									pkg_error.geterror(nuError, sbError);
									PKG_ERROR.seterrormessage(pkg_error.CNUGENERIC_MESSAGE,'Error en anulacion de plan de wf, solicitud ['||reg.package_id||'] error '||sbError);
							END;
					END;
				END IF;
				
            END IF;

        END IF;

         --se anula orden de trabajo
         -- si esta blioqueada se desbloquea primero
        if reg.order_status_id = 11 then
										  
			api_unlockorder(reg.order_id,
							1277,
							'DESBLOQUEO DE ORDEN POR PROCESO DE TERMINACION DE CONTRATO',
							SYSDATE,
							nuError,
							sbError
							);
				IF nuError <> 0 THEN
					PKG_ERROR.seterrormessage(pkg_error.CNUGENERIC_MESSAGE,'Error desbloqueando orden  ['||reg.order_id||'] error '||sbError);
				END IF;

        end if;

        if reg.order_id is not null then
			if(PKG_BCORDENES.FNUOBTIENEESTADO(reg.order_id) in (pkg_gestionordenes.cnuordenasignada, pkg_gestionordenes.cnuordenregistrada)) then
          
				ldc_cancel_order(
                           reg.order_id,
                           nuCausalOrden,
                           'ANULACION POR PROCESO DE LDCAISP',
                           cnuCommentType,
                           nuError,
                           sbError
          );

				IF nuError <> 0 THEN
					PKG_ERROR.seterrormessage(pkg_error.CNUGENERIC_MESSAGE,'Error anulando orden  ['||reg.order_id||'] error '||sbError);
				END IF;
			End If;  --- fin estado
		End If; --- Fin orden null
       END LOOP;
    END IF;
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
	
  Exception
   when pkg_error.controlled_error then
	pkg_error.getError(nuError, osberror);
	pkg_traza.trace(csbMetodo||' '||osberror);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
   When Others Then
	pkg_error.setError;
	pkg_error.getError(onuError, osberror);
	pkg_traza.trace(csbMetodo||' '||osberror);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END PRANULASOLITUDES;
End ldc_pkAjustaSuspcone;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKAJUSTASUSPCONE
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKAJUSTASUSPCONE', 'ADM_PERSON');
END;
/