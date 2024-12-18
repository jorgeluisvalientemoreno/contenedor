CREATE OR REPLACE PACKAGE "LDC_BOVENTASFNB" AS

  /**************************************************************************
   Propiedad intelectual de Gases de Occidente.

   Nombre del Paquete: LDC_BOVENTASFNB
   Descripcion : PACKAGE PARA CREACION DE NOTAS CREDITO O DEBITO
                 PARA LAS ORDENES DE ENTREGA LEGALIZADAS DESDE
                 FLOTE PARA LA GENERACION DE VENTAS DE INGENIERIA

   Autor       : Jorge Valiente.
   Fecha       : 21 Octubre de 2013

   Historia de Modificaciones
     Fecha             Autor                Modificacion
   =========         =========            ====================
   05-06-2015      ABaldovino ARA 6798    Se modifica el metodo <<prEntregaArticulos>>
   10-02-2015       Llozada               Se modifica el metodo <<prUpdateFNB_SVI>>
   10/Oct/2022     Edmundo Lara           OSF-557: Se quita la validacion de que un contrato no permita crear un nuevo producto
                                                   si ya tiene creado uno en los servicios;
                                                   7056 Brilla Promigas
                                                   7055 Brilla GDCA
                                                   7053 Brilla Seguros.
  **************************************************************************/

  -- Obtiene la Version actual del Paquete
  FUNCTION FSBVERSION RETURN VARCHAR2;

  --------------------------------------------------------------------------
  --Tabla PL para el manejo
  --------------------------------------------------------------------------

  -------------------------------------------------------------------------
  -- Metodos publicos del PACKAGE
  --------------------------------------------------------------------------

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FRFPACKAGESFNB
  Descripcion    : RETORNA LAS SOLICITUDES GENERADAS POR EL PROCESO
                   DE LEGALIZACION DE ORDENES DE LA FORMA FLOTE
                   GENERANDO SOLICITUDES DE VENTAS DE SERVICIO DE INGENIERIA..
  Autor          : Jorge Valiente
  Fecha          : 28/10/2013

  Parametros                 Descripcion
  ============            ===================
  Constants_per.tyRefCursor   Retorna los registros mediante un cursor

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  FUNCTION FRFPACKAGESFNB RETURN Constants_per.tyRefCursor;
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrNotaCreditoFNB
  Descripcion    : Porcedimiento que permitira Generar Nota Credito
                   para las promociones de FNB.

  Autor          : Jorge Valiente
  Fecha          : 29/10/2013

  Parametros              Descripcion
  ============         ===================
   isbId               Identificador de la orden a legalizar
   inuCurrent          Registro actual
   inuTotal            Total de registros a procesar
   onuErrorCode        Error en el proceso
   osbErrorMessage     Mensaje de error en el proceso

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  Procedure PrNotaCreditoFNB(isbId           IN VARCHAR2,
                             inuCurrent      IN NUMBER,
                             inuTotal        IN NUMBER,
                             onuErrorCode    OUT NUMBER,
                             osbErrorMessage OUT VARCHAR2);

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrGeneraCargoFNB
  Descripcion    : Porcedimiento que permitira Generar
                   cargo a la promocion de FNB de la
                   orden legalizada.

  Autor          : Jorge Valiente
  Fecha          : 06/11/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  Procedure PrGeneraCargoFNB;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_PrEntregaArtuculos
  Descripcion    : Genera solicitud de venta de servicios de ingenieria para
                   crear la orden de instalacion de gasodomestico.

  Autor          : Jorge Valiente
  Fecha          : 25 - Octubre - 2013

  Parametros              Descripcion
  ============         ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  21-01-2013      Sayra Ocoro      Se adiciona un parametro de entrada al procedimiento para solucionar la
                                   NC 1750

  ******************************************************************/

  procedure prEntregaArticulos (inuOrderId in or_order.order_id%type);


 /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : prCreateProductFNB
  Descripcion    : Crea un producto de tipo FNB (7053, 7055,7056) en un contrato para
                   realizar posteriormente el traslado de cartera.

  Autor          : Sayra Ocoro
  Fecha          : 08-01-2014

  Parametros              Descripcion
  ============         ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/

  procedure prCreateProductFNB;
   /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : fnuValidateSuscription
  Descripcion    : Valida si el numero de suscripcion ingresado existe,
                   si tiene producto de gas (7014) ACTIVO y si no tiene algun
                   tipo de servicio financiero {7053,7055,7056}

  Autor          : Sayra Ocoro
  Fecha          : 09-01-2014

  Parametros              Descripcion
  ============         ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  23-03-2015      Sandra Lemus        Aranda 6372 Se realiza modificacion del procedimeinto,
                                      ya que solo realizaba los traslados para los tipos de
                                      productos quemados en el codigo, se reemplaza el codigo
                                      para obtener los valores por parametros-
  ******************************************************************/
 function fnuValidateSuscription return number;
 /*****************************************
  Metodo: fsbApliMalaAsesoria
  Descripcion: Indica si a la orden que se encuentra en la instancia le aplica
               novedad por mala asesoria. Para lo cual debe cumplir:
               1. Orden de trabajo de tipo APLICA ANULACION VENTA
               2. Legalizada con causal de exito - 3069
               3. Tener el dato adicional CAUSA_REAL_ANULACION con valor 3. MALA ASESORIA
               4. No tener una multa por el mismo motivo asociado a la solicitud de venta

  Parametros:

  Autor: Sayra Ocoro
  Fecha: 17/01/2014

  Historial de Modificaciones
  =========================================================================
     Fecha                Autor              Descripcion
  17-01-2014           Sayra Ocoro         Se CREA la logica para un objeto de legalizacion
                                           que soluciona la NC 2459_2
   ****************************************************************/
  procedure prMultaMalaAsesoria;
     /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prRegisterSVI
  Descripcion    : Porcedimiento para registrar Solicitudes de Venta de Servicios de Ingenieria

  Autor          : Sayra Ocoro
  Fecha          : 21/01/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  Procedure prRegisterSVI;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prUpdateFNB_SVI
  Descripcion    : Porcedimiento para registrar Solicitudes de Venta de Servicios de Ingenieria

  Autor          : Sayra Ocoro
  Fecha          : 18/02/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  18/10/2023      JSOTO				  OSF-1730 Al suprimir aplicaentrega este procedimiento queda sin uso
                                      
  ******************************************************************/
  


END LDC_BOVENTASFNB;
/
CREATE OR REPLACE PACKAGE BODY "LDC_BOVENTASFNB" AS
  /**************************************************************************
   Propiedad intelectual de Gases de Occidente.

   Nombre del Paquete: LDC_BOVENTASFNB
   Descripcion : PACKAGE PARA CREACION DE NOTAS CREDITO O DEBITO
                 PARA LAS ORDENES DE ENTREGA LEGALIZADAS DESDE
                 FLOTE PARA LA GENERACION DE VENTAS DE INGENIERIA

   Autor       : Jorge Valiente.
   Fecha       : 21 Octubre de 2013

   Historia de Modificaciones
     Fecha             Autor                Modificacion
   =========         =========          ====================
	 05-06-2015      ABaldovino ARA 6798    Se modifica el metodo <<prRegisterSVI>>
	 05-06-2015      ABaldovino ARA 6798    Se modifica el metodo <<prEntregaArticulos>>
   10-02-2015      Llozada                Se modifica el metodo <<prUpdateFNB_SVI>>
   28-10-2014      KCienfuegos.RNP1808    Se modifica el metodo <<prRegisterSVI>>
   10-10-2014      KCienfuegos.RNP1179    Se modifica el metodo <<prRegisterSVI>>
   08-01-2014      Sayra Ocoro            Se adiciona el metodo prCreateProductFNB
   09-01-2014      Sayra Ocoro            Se adiciona el metodo fnuValidateSuscription
   06/03/2014       JSOTO                 Caso aranda 3056  cambio de API de generacion de novedades
                                          OS_REGISTERNEWCHARGE  por   LDC_OS_REGISTERNEWCHARGE

  **************************************************************************/

  --------------------------------------------
  -- Variables PRIVADAS DEL PAQUETE
  --------------------------------------------

  tbAttributes cc_tytbAttribute;

  ---------------------------------------------------------------------------
  -- Constantes VERSION DEL PAQUETE
  ---------------------------------------------------------------------------
  CSBVERSION       CONSTANT VARCHAR2(40) := 'LDC_BOVENTASFNB_03';
  csbWORK_INSTANCE CONSTANT VARCHAR2(20) := 'WORK_INSTANCE';
  sbNombreEntrega  CONSTANT   varchar2(100) := 'FNB_VNT_LUL_135727';

  nuOrderStatus       number;
  nuTTEntregaArt      number;
  sbLineaArticulo     ld_parameter.value_chain%type;
  sbClasOT            ld_parameter.value_chain%type;
  
  csbSP_NAME 	CONSTANT VARCHAR2(35):= 'ldc_boventasfnb.';
  cnuNVLTRC 	CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
  csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;


  /*
  Versionammiento del Pkg */
  FUNCTION FSBVERSION RETURN VARCHAR2 IS
  BEGIN
    return CSBVERSION;
  END FSBVERSION;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FRFPACKAGESFNB
  Descripcion    : RETORNA LAS SOLICITUDES GENERADAS POR EL PROCESO
                   DE LEGALIZACION DE ORDENES DE LA FORMA FLOTE
                   GENERANDO SOLICITUDES DE VENTAS DE SERVICIO DE INGENIERIA..
  Autor          : Jorge Valiente
  Fecha          : 28/10/2013

  Parametros                 Descripcion
  ============            ===================
  Constants_per.tyRefCursor   Retorna los registros mediante un cursor

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  FUNCTION FRFPACKAGESFNB RETURN Constants_per.tyRefCursor IS

    rfQuery        Constants_per.tyRefCursor;
    sbErrorMessage VARCHAR2(4000);
	nuErrorCode    NUMBER;

    sbNON_BA_FI_REQU_ID ge_boInstanceControl.stysbValue;
    sbSUPPLIER_ID       ge_boInstanceControl.stysbValue;
	
	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.frfpackagesfnb';

  BEGIN
  
    pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	
    sbNON_BA_FI_REQU_ID := ge_boInstanceControl.fsbGetFieldValue('LD_NON_BAN_FI_ITEM',
                                                                 'NON_BA_FI_REQU_ID');
    sbSUPPLIER_ID       := ge_boInstanceControl.fsbGetFieldValue('LD_NON_BAN_FI_ITEM',
                                                                 'SUPPLIER_ID');
    --cursor para obtener los registro de las solicitudes de
    --venta de servicio de ingenieria de la legalizacion
    --de la forma FLOTE
    OPEN rfQuery FOR
      select mp.package_id "SOLICITUD SERVICIO INGENIERIA",
             trim(substr(mp.comment_,
                         instr(mp.comment_, ' ', -1),
                         Length(mp.comment_))) "SOLICITUD BRILLA ORIGEN",
             trim(substr(mp.comment_,
                         instr(mp.comment_, 'ORDEN MADRE') + 11,
                         length(trim(substr(mp.comment_,
                                            instr(mp.comment_, 'ORDEN MADRE') + 11,
                                            length(mp.comment_)))) -
                         length(trim(substr(mp.comment_,
                                            instr(mp.comment_,
                                                  'SOLICITUD PADRE'),
                                            length(mp.comment_)))))) "ORDEN ENTREGA DE ARTICULO",
			 
             pkg_bcunidadoperativa.fnuGetContratista(pkg_bcordenes.fnuObtieneUnidadOperativa
																						(to_number(trim(substr(mp.comment_,
                                                                                                              instr(mp.comment_,
                                                                                                                    'ORDEN MADRE') + 11,
                                                                                                              length(trim(substr(mp.comment_,
                                                                                                                                 instr(mp.comment_,
                                                                                                                                       'ORDEN MADRE') + 11,
                                                                                                                                 length(mp.comment_)))) -
                                                                                                              length(trim(substr(mp.comment_,
                                                                                                                                 instr(mp.comment_,
                                                                                                                                       'SOLICITUD PADRE'),
                                                                                                                                 length(mp.comment_)))))))
                                                                                        )
                                                     ) || ' - ' ||
             DAGE_CONTRATISTA.FSBGETDESCRIPCION(pkg_bcunidadoperativa.fnuGetContratista(pkg_bcordenes.fnuObtieneUnidadOperativa
																															(to_number(trim(substr(mp.comment_,
                                                                                                                                                 instr(mp.comment_,
                                                                                                                                                       'ORDEN MADRE') + 11,
                                                                                                                                                 length(trim(substr(mp.comment_,
                                                                                                                                                                    instr(mp.comment_,
                                                                                                                                                                          'ORDEN MADRE') + 11,
                                                                                                                                                                    length(mp.comment_)))) -
                                                                                                                                                 length(trim(substr(mp.comment_,
                                                                                                                                                                    instr(mp.comment_,
                                                                                                                                                                          'SOLICITUD PADRE'),
                                                                                                                                                                    length(mp.comment_)))))))
                                                                                                                            )
                                                                                        ),
                                                NULL) "PROVEEDOR"
        from mo_packages mp, LD_NON_BAN_FI_ITEM LNBFI
       where mp.tag_name = 'P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101'
         and MP.PACKAGE_TYPE_ID = 100101
         and UPPER(mp.comment_) like
             UPPER('%INSTALACION GASODOMESTICO BRILLA [TIPO_PAQUETE 100101]%SOLICITUD PADRE%')
         and pkg_bcunidadoperativa.fnuGetClasificacion(pkg_bcsolicitudes.fnuGetUnidadOperativa
																									(to_number(trim(substr(mp.comment_,
                                                                                                                        instr(mp.comment_,
                                                                                                                              ' ',
                                                                                                                              -1),
                                                                                                                        Length(mp.comment_))))
																									)
                                                       ) = 70
         AND LNBFI.NON_BA_FI_REQU_ID =
             TO_NUMBER(trim(substr(mp.comment_,
                                   instr(mp.comment_, ' ', -1),
                                   Length(mp.comment_))))
         AND LNBFI.SUPPLIER_ID =
             pkg_bcunidadoperativa.fnuGetContratista(pkg_bcordenes.fnuObtieneUnidadOperativa
																							(to_number(trim(substr(mp.comment_,
                                                                                                              instr(mp.comment_,
                                                                                                                    'ORDEN MADRE') + 11,
                                                                                                              length(trim(substr(mp.comment_,
                                                                                                                                 instr(mp.comment_,
                                                                                                                                       'ORDEN MADRE') + 11,
                                                                                                                                 length(mp.comment_)))) -
                                                                                                              length(trim(substr(mp.comment_,
                                                                                                                                 instr(mp.comment_,
                                                                                                                                       'SOLICITUD PADRE'),
                                                                                                                                 length(mp.comment_)))))))
																							)
                                                     )
         AND DALD_SUBLINE.fnuGetLine_Id(DALD_ARTICLE.fnuGetSubline_Id(LNBFI.ARTICLE_ID,
                                                                      NULL),
                                        NULL) = 1
         AND LNBFI.NON_BA_FI_REQU_ID =
             DECODE(sbNON_BA_FI_REQU_ID,
                    NULL,
                    LNBFI.NON_BA_FI_REQU_ID,
                    sbNON_BA_FI_REQU_ID)
         AND LNBFI.SUPPLIER_ID =
             DECODE(sbSUPPLIER_ID, NULL, LNBFI.SUPPLIER_ID, sbSUPPLIER_ID);

    return rfQuery;
	
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
	
  EXCEPTION
    when pkg_error.CONTROLLED_ERROR then
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      pkErrors.pop;
      raise;
    when OTHERS then
	  pkg_error.setError;
	  pkg_error.getError(nuErrorCode,sbErrorMessage);
	  pkg_error.setErrorMessage(nuErrorCode,sbErrorMessage);
      pkErrors.pop;
	  pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

  END FRFPACKAGESFNB;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrNotaCreditoFNB
  Descripcion    : Porcedimiento que permitira Generar Nota Credito
                   para las promociones de FNB.

  Autor          : Jorge Valiente
  Fecha          : 29/10/2013

  Parametros              Descripcion
  ============         ===================
   isbId               Identificador de la orden a legalizar
   inuCurrent          Registro actual
   inuTotal            Total de registros a procesar
   onuErrorCode        Error en el proceso
   osbErrorMessage     Mensaje de error en el proceso

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  Procedure PrNotaCreditoFNB(isbId           IN VARCHAR2,
                             inuCurrent      IN NUMBER,
                             inuTotal        IN NUMBER,
                             onuErrorCode    OUT NUMBER,
                             osbErrorMessage OUT VARCHAR2) is
    inuSesunuse   servsusc.sesunuse%type;
    inuSusccodi   suscripc.susccodi%type;
    inuCucocodi   cuencobr.cucocodi%type;
    inuConccodi   concepto.conccodi%type;
    inuCargunid   cargos.cargunid%type;
    isbCargsign   cargos.cargsign%type;
    inuCargcaca   cargos.cargcaca%type;
    inuCargvalo   cargos.cargvalo%type;
    isbNotaObse   notas.notaobse%type;
    isbLastDetail varchar2(200);
    ionuNotaNume  notas.notanume%type;
    nuPackagesId  mo_packages.package_id%type;

    -- Cursor para Obtener ordenes con TT = {12147,12135}, legalizadas con causal de exito
    cursor cuOrders(inuPackagesId mo_packages.package_id%type) is
      select /*+ index(or_order IDX_OR_ORDER_012) */
       or_order.order_id
        from or_order,
             or_order_activity,
             ge_causal,
			(SELECT to_number(DatosParametro)TipoTrabIng
            FROM(
	             SELECT regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('ID_TASK_TYPE_SERV_ING',NULL), '[^,]+', 1, LEVEL)AS DatosParametro
		         FROM dual
			     CONNECT BY regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('ID_TASK_TYPE_SERV_ING',NULL), '[^,]+', 1, LEVEL) IS NOT NULL)) 
	   where or_order_activity.package_id = inuPackagesId
         and or_order_activity.order_id = or_order.order_id
         and ge_causal.causal_id = or_order.causal_id
         and or_order.order_status_id =
             dald_parameter.fnuGetNumeric_Value('ESTADO_CERRADO')
         and ge_causal.class_causal_id =
             dald_parameter.fnuGetNumeric_Value('TRASNFER_SUCC_CAUSAL')
         and or_order.task_type_id = TipoTrabIng
       group by or_order.order_id;

    --Cursor para obtener los items
    cursor cuitems(nuorder_id or_order_items.order_id%type) is
      select *
        from or_order_items ooi
       where ooi.items_id in
			(SELECT to_number(DatosParametro) 
            FROM(
	             SELECT regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('ID_ITEMS_SERV_ING',NULL), '[^,]+', 1, LEVEL)AS DatosParametro
		         FROM dual
			     CONNECT BY regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('ID_ITEMS_SERV_ING',NULL), '[^,]+', 1, LEVEL) IS NOT NULL))
         and ooi.order_id = nuorder_id;

    tempcuitems cuitems%rowtype;
	
	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.PrNotaCreditoFNB';

  BEGIN

    pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	
    nuPackagesId := to_number(isbId);
    --1. Obtener ordenes con TT = {12147,12135}, legalizadas con causal de exito
    for rgOrders in cuOrders(nuPackagesId) loop
      ---1.1 Obtener items con id = {1009902, 1009904}
      for tempcuitems in cuitems(rgOrders.Order_Id) loop
        null;
        ----1.1.2 Si item_id = 1009904 (instalacion de hidraulica) -> Validar si esta en promocion y generar nota credito
      end loop;
    end loop;
	
	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  Exception
    When pkg_error.controlled_error then
     -- Rollback;
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
      Raise;

    When others then
     -- Rollback;
      onuErrorCode    := ld_boconstans.cnuGeneric_Error;
      osbErrorMessage := 'Error al Generar Nota Credito Mediante la solicitud [' ||
                         isbId || '] ' ;
      pkg_traza.trace(csbMT_NAME||' -'||onuErrorCode||':'||osbErrorMessage, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
  END PrNotaCreditoFNB;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrGeneraCargoFNB
  Descripcion    : Porcedimiento que permitira Generar
                   cargo a la promocion de FNB de la
                   orden legalizada.

  Autor          : Jorge Valiente
  Fecha          : 06/11/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  17-02-2014    Sayra Ocoro        ARANDA 2819: Se modifica
  ******************************************************************/
  Procedure PrGeneraCargoFNB is

    --Cursor para obtener los items
    cursor cuitems(nuorder_id or_order_items.order_id%type) is
      select ooi.*, oo.task_type_id
        from or_order_items ooi, or_order oo
       where ooi.order_id = nuorder_id
         and ooi.order_id = oo.order_id
         and ooi.items_id in
		 		  	      (SELECT to_number(DatoItem) 
						   FROM(
								 SELECT regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('ID_ITEMS_SERV_ING',NULL), '[^,]+', 1, LEVEL)AS DatoItem
								 FROM dual
								 CONNECT BY regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('ID_ITEMS_SERV_ING',NULL), '[^,]+', 1, LEVEL) IS NOT NULL))
         and oo.task_type_id in
		 		  	      (SELECT to_number(DatoTipoTrab) 
						   FROM(
								 SELECT regexp_substr(DALD_PARAMETER.
								 fsbGetValue_Chain('ID_TASK_TYPE_SERV_ING',NULL), '[^,]+', 1, LEVEL)AS DatoTipoTrab
								 FROM dual
								 CONNECT BY regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('ID_TASK_TYPE_SERV_ING',NULL), '[^,]+', 1, LEVEL) IS NOT NULL));

    --cursor para obtener datos del suscriptor
    cursor cucontrato(nuorder_id or_order_items.order_id%type) is
      select ssc.sesunuse, ssc.sesususc, s.susccicl
        from suscripc s, servsusc ssc
       where s.susccodi = ssc.sesususc
         and s.suscclie = (select mp.subscriber_id
                             from mo_packages mp, or_order_activity ooa
                            where ooa.order_id = nuorder_id
                              and mp.package_id = ooa.package_id
                            group by mp.subscriber_id)
         and ssc.sesuserv =
             dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS', NULL);
    --cursor para obtener el periodo de facturacion actual
    cursor cuperifact(nupefacicl perifact.pefacicl%type) is
      select p.pefacodi
        from perifact p
       where p.pefacicl = nupefacicl
         and p.pefaactu = 'S';

    --cursor para obtener la informacion del cargo generado
    --por el solicutd de venta de ingeniera para BRILLA
    cursor cucargos(nucargnuse cargos.cargnuse%type,
                    nucargconc cargos.cargconc%type,
                    nucargpefa cargos.cargpefa%type,
                    sbcargdoso cargos.cargdoso%type,
                    nucargcodo cargos.cargcodo%type) is
      select *
        from cargos c
       where c.cargnuse = nucargnuse
         and c.cargconc = nucargconc
         and c.cargsign = 'DB'
         and c.cargpefa = nucargpefa
         and c.cargdoso = sbcargdoso
         and c.cargcodo = nucargcodo
         and c.cargprog = 241;

    --cursor para obtener la solicitud
    cursor cuor_order_activity(nuorder_id or_order_activity.order_id%type) is
      select ooa.package_id --, ooa.address_id
        from or_order_activity ooa
       where ooa.order_id = nuorder_id
         and rownum = 1
       group by ooa.package_id; --, ooa.address_id;
    --cursor para validar la linea del articulo asociado a la orden
    --cursor para validar la linea del articulo asociado a la orden
    cursor culd_non_ban_fi_item(inuOrderId or_order.order_id%type) is
      select lnbfi.article_id idArticle, lnbfi.amount nuCant
        from ld_item_work_order LNBFI
       where LNBFI.order_id = inuOrderId
         and DALD_SUBLINE.fnuGetLine_Id(DALD_ARTICLE.fnuGetSubline_Id(LNBFI.ARTICLE_ID,
                                                                      NULL),
                                        NULL) IN
											  (SELECT to_number(DatoItem) 
											   FROM(
													 SELECT regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('COD_LIN_ART',NULL), '[^,]+', 1, LEVEL)AS DatoItem
													 FROM dual
													 CONNECT BY regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('COD_LIN_ART',NULL), '[^,]+', 1, LEVEL) IS NOT NULL));
 
 --fin cursor para linea del articulo asociado a la orden
    --cursor para validar la linea del articulo asociado a la orden
    cursor cuclasificacion(sbClasificaciono varchar2,
                           sbClasificacionc varchar2) is
      select 'X'
        from dual
       where sbClasificaciono IN
							  (SELECT to_number(DatoItem) 
								   FROM(
										 SELECT regexp_substr(sbClasificacionc, '[^,]+', 1, LEVEL)AS DatoItem
										 FROM dual
										 CONNECT BY regexp_substr(sbClasificacionc, '[^,]+', 1, LEVEL) IS NOT NULL
										)
							   );

    --fin cursor para linea del articulo asociado a la orden

    tempcuclasificacion      cuclasificacion%rowtype;
    tempculd_non_ban_fi_item culd_non_ban_fi_item%rowtype;

    --cursor para obtener solicitud de orden de venta brilla
    cursor cuventabrilla (nupackage_id mo_packages.package_id%type) IS
            SELECT  fv.id_pkg_vsi SOLICITUD_SERVICIO_INGENIERIA,
                    pkg.package_id SOLICITUD_VENTA_FNB,
                    pkg.request_date FECHA_REGISTRO_VENTA_FNB,
                    fv.id_ot_ea ORDEN_ENTREGA_ARTICULO,
                    ar.article_id ARTICULO
            FROM    mo_packages pkg,
                    or_operating_unit uo,
                    LD_NON_BAN_FI_ITEM it,
                    LD_ARTICLE ar,
                    LD_SUBLINE sl,
                    ldc_FNB_VSI fv
            WHERE pkg.package_id = fv.id_pkg_fnb
            AND uo.operating_unit_id = pkg.operating_unit_id
            AND it.non_ba_fi_requ_id = pkg.package_id
            AND ar.article_id = it.article_id
            AND sl.subline_id = ar.subline_id
            AND fv.procesado = 'N'
            AND sl.line_id IN
								(SELECT to_number(DatoItem) 
								   FROM(
										 SELECT regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('COD_LIN_ART',NULL), '[^,]+', 1, LEVEL)AS DatoItem
										 FROM dual
										 CONNECT BY regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('COD_LIN_ART',NULL), '[^,]+', 1, LEVEL) IS NOT NULL
										)
								)
            AND uo.oper_unit_classif_id IN
								(SELECT to_number(DatoUni) 
								   FROM(
										 SELECT regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('COD_CLA_UNI_OPE',NULL), '[^,]+', 1, LEVEL)AS DatoUni
										 FROM dual
										 CONNECT BY regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('COD_CLA_UNI_OPE',NULL), '[^,]+', 1, LEVEL) IS NOT NULL
										)
								)
            AND fv.id_pkg_vsi =  nupackage_id;

    --fin cursor para obtener solicitud de orden de venta brilla

    --cursor valida promocion sublinea del articulo
    cursor culdc_promo_fnb(NUsubline_id   ldc_promo_fnb.subline_id%TYPE,
                           DTREQUEST_DATE LDC_PROMO_FNB.INITIAL_DATE%TYPE) IS
      SELECT PROMO_FNB_ID, SUBLINE_ID, INITIAL_DATE, FINAL_DATE
        FROM LDC_PROMO_FNB LPF
       WHERE LPF.SUBLINE_ID = NUsubline_id
         AND TRUNC(to_date( DTREQUEST_DATE, ldc_boConsGenerales.fsbGetFormatoFecha )) BETWEEN TRUNC(to_date( LPF.INITIAL_DATE, ldc_boConsGenerales.fsbGetFormatoFecha )) AND
             TRUNC(to_date( LPF.FINAL_DATE, ldc_boConsGenerales.fsbGetFormatoFecha ));
    --fin cursor valida promocion sublinea del articulo

    tempculdc_promo_fnb culdc_promo_fnb%ROWTYPE;

    --cursor para validar la linea del articulo asociado a la orden
    cursor CUGENERACARGO(NUITEMS_ID OR_ORDER_ITEMS.ITEMS_ID%TYPE) is
      select 'X'
        from dual
       where NUITEMS_ID IN
							(SELECT to_number(DatoItem) 
							   FROM(
									 SELECT regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('ITE_GEN_CAR',NULL), '[^,]+', 1, LEVEL)AS DatoItem
									 FROM dual
									 CONNECT BY regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('ITE_GEN_CAR',NULL), '[^,]+', 1, LEVEL) IS NOT NULL
									)
							);
 
     --fin cursor para linea del articulo asociado a la orden

    TEMPCUGENERACARGO CUGENERACARGO%ROWTYPE;
    /*tempcuventabrilla cuventabrilla%rowtype;*/

    tempcuitems             cuitems%rowtype;
    tempcucontrato          cucontrato%rowtype;
    nupefacodi              perifact.pefacodi%type;
    tempcucargos            cucargos%rowtype;
    tempcuor_order_activity cuor_order_activity%rowtype;
    nuconcepto              or_task_type.concept%type;

    nuorderid       or_order_items.order_id%type;
    onuErrorCode    NUMBER;
    osbErrorMessage VARCHAR2(4000);
    nuItemValue     number;

    NUSUBLINE NUMBER;
    NUGENRACARGO NUMBER;
    NUITEMGENRACARGO NUMBER;

    --Contadores de itemsBrilla e itemsSI
    nuCountGasBrilla            number := 0;
    nuCountHidraulicaBrilla     number := 0;
    nuCountGasInst              number := 0;
    nuCountHidraulicaInst       number := 0;
    nuCausalId                  ge_causal.causal_id%type;
	
	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.PrGeneraCargoFNB';

  BEGIN

    pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
    --Obtener orden de la instancia
    nuorderid := pkg_bcordenes.fnuObtenerOTInstanciaLegal;
    pkg_traza.trace(' Orden Instaciada --> : ' || nuorderid, cnuNVLTRC);
    --Obtener la Solicitud de Venta de Servicios de Ingenieria asociada a la orden
    open cuor_order_activity(nuorderid);
    fetch cuor_order_activity   into tempcuor_order_activity;
    if cuor_order_activity%notfound then
        close cuor_order_activity;
		pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                                 'Error al consulta la solicictud de la orden [' ||
                                  nuorderid || ']');
        raise pkg_error.controlled_error;

    ELSE
      --Validar si la linea y la clasificacin de la unidad operarativa
      --de la solicitu del servicio de venta FNB de donde nacio la
      --la solicitud de servicio de ingenieria
      pkg_traza.trace('Solicitud Orden --> : ' ||tempcuor_order_activity.package_id,cnuNVLTRC);
      for  tempcuventabrilla in cuventabrilla(tempcuor_order_activity.package_id) loop
              pkg_traza.trace('Validar promociones de Items', cnuNVLTRC);
              NUSUBLINE := DALD_ARTICLE.fnuGetSubline_Id(tempcuventabrilla.articulo, NULL);
              pkg_traza.trace('Articulo --> ' || tempcuventabrilla.articulo, cnuNVLTRC);
              pkg_traza.trace('Sublinea --> ' || NUSUBLINE, cnuNVLTRC);
              --Obtener la cantidad de articulos entregados
              --tempculd_non_ban_fi_item := null;
              open culd_non_ban_fi_item (tempcuventabrilla.ORDEN_ENTREGA_ARTICULO);
              fetch culd_non_ban_fi_item into  tempculd_non_ban_fi_item;

              --Validar si se encontraron registros
              if culd_non_ban_fi_item%found then
                   close culd_non_ban_fi_item;
                   nuCountGasBrilla := nuCountGasBrilla + tempculd_non_ban_fi_item.nuCant;
                   pkg_traza.trace(' nuCountGasBrilla => '||nuCountGasBrilla,cnuNVLTRC);
                   --Validar conexiones hidraulicas
                   if instr(dald_parameter.fsbGetValue_Chain('PARCIAL_QUOTA_SUBLINE'),to_char(NUSUBLINE)) > 0 then
                            pkg_traza.trace('Fecha Registro [' ||
                                   tempcuventabrilla.fecha_registro_venta_fnb ||
                                   '] de la solicitud  --> ' ||
                                   tempcuventabrilla.solicitud_venta_fnb,
                                   cnuNVLTRC);
                            open culdc_promo_fnb(NUSUBLINE,
                                                 tempcuventabrilla.fecha_registro_venta_fnb);
                            fetch culdc_promo_fnb
                              into tempculdc_promo_fnb;
                            pkg_traza.trace('Resultado cursor  --> ' ||
                                           tempculdc_promo_fnb.PROMO_FNB_ID,
                                           cnuNVLTRC);
                            if culdc_promo_fnb%NOTfound then
                                  -- NO genera cargos
                                  NUGENRACARGO := -1;
                            else
                                  -- Genera cargos
                                  NUGENRACARGO := 0;
                                  --Incrementar contador de hidraulicas
                                  nuCountHidraulicaBrilla := nuCountHidraulicaBrilla + tempculd_non_ban_fi_item.nuCant;
                                  pkg_traza.trace('nuCountHidraulicaBrilla => '||nuCountHidraulicaBrilla, cnuNVLTRC);
                            END IF;
                            CLOSE culdc_promo_fnb;

                       end if;
                       pkg_traza.trace('nuCountHidraulicaBrilla => '||nuCountHidraulicaBrilla, cnuNVLTRC);
              end if;
               -- Actualiza el flag en LDC_FNB_VSI
              DALDC_FNB_VSI.updPROCESADO(tempcuventabrilla.SOLICITUD_VENTA_FNB,
                                     tempcuventabrilla.ORDEN_ENTREGA_ARTICULO,
                                     tempcuventabrilla.SOLICITUD_SERVICIO_INGENIERIA,
                                     'S');
              pkg_traza.trace('Registro Actualizado',cnuNVLTRC);
      end loop;
      pkg_traza.trace('NUITEMGENRACARGO  --> ' || NUGENRACARGO,cnuNVLTRC);
      --ARANDA 2819: Obtener causal
      nuCausalId := pkg_bcordenes.fnuObtieneCausal(nuorderid);
      pkg_traza.trace(' nuCausalId  --> ' || nuCausalId,cnuNVLTRC);
      pkg_traza.trace(' nuClassCausalId  --> ' || pkg_bcordenes.fnuObtieneClaseCausal(nuCausalId),cnuNVLTRC);
      IF pkg_bcordenes.fnuObtieneClaseCausal(nuCausalId) = 1 and  (nuCountHidraulicaBrilla > 0 or nuCountGasBrilla > 0) then
            open cucontrato(nuorderid);
            fetch cucontrato
               into tempcucontrato;
            pkg_traza.trace(' CICLO SUSCRIPTOR -->' || tempcucontrato.susccicl,
                           10);
            if cucontrato%found then
                  for tempcuitems in cuitems(nuorderid) loop
                        pkg_traza.trace(' Item legalizado --> ' || tempcuitems.items_id,
                                       10);
                        NUITEMGENRACARGO := -1;
                        if (tempcuitems.items_id =  1009902 and nuCountGasBrilla > 0)
                            or (tempcuitems.items_id  = 1009904 and nuCountHidraulicaBrilla > 0 ) then
                                  -- Valida si el item genera cargos
                                  OPEN CUGENERACARGO(tempcuitems.items_id);
                                  FETCH CUGENERACARGO
                                    INTO TEMPCUGENERACARGO;
                                  IF CUGENERACARGO%FOUND THEN
                                      NUITEMGENRACARGO := 0;
                                  END IF;
                                  CLOSE CUGENERACARGO;
                                  pkg_traza.trace(' NUITEMGENRACARGO  --> ' || NUITEMGENRACARGO,cnuNVLTRC);
                                  -- Valida si el item genera cargos
                                  IF NUITEMGENRACARGO = 0 THEN
                                                  pkg_traza.trace('Inicio de insertar cargo',cnuNVLTRC);

                                                  nuconcepto := daor_task_type.fnugetconcept(tempcuitems.task_type_id,null);
												  
												  api_creacargos(
																tempcucontrato.sesunuse,
																nuconcepto,
																1,
																3,
																-1 * round(abs(tempcuitems.total_price)),
																'PP-' ||tempcuor_order_activity.package_id,
																NULL,
																onuErrorCode,
																osbErrorMessage
																);

                                                  pkg_traza.trace('CODIGO SERVICIO --> ' ||
                                                                 tempcucontrato.sesunuse);
                                                  pkg_traza.trace('CONCEPTO DEL TIPO DE TRABAJO --> ' ||
                                                                 daor_task_type.fnugetconcept(tempcuitems.task_type_id,
                                                                                              null));
                                                  pkg_traza.trace('UNIDADES --> ' || 1);
                                                  pkg_traza.trace('CODIGO CAUSAL DE CARGO --> ' || 3);
                                                  pkg_traza.trace('VALOR TOTAL --> ' ||  round(abs(tempcuitems.total_price)));
                                                  pkg_traza.trace('DOCUMENTO SOPORTE --> PP-' ||
                                                                 tempcuor_order_activity.package_id);
                                                  pkg_traza.trace('CICLO --> ' || tempcucontrato.susccicl);
                                                  pkg_traza.trace('CODIGO ERROR --> ' || onuErrorCode);
                                                  pkg_traza.trace('DESCRIPCION ERROR --> ' || osbErrorMessage);
                                                  --/*
                                                  pkg_traza.trace('Fin de insertar cargo',cnuNVLTRC);

                                                  if onuErrorCode <> 0 then
                                                        close cucargos;
                                                        pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                                                                                  osbErrorMessage);
                                                        raise pkg_error.controlled_error;
                                                  end if;
                                  END IF; --FIN VALIDA Item genera cargo (NUITEMGENRACARGO)
                         end if;
                    end loop; -- FIN loop items
               end if;
      end if;-- FIN valida contrato
     close cucontrato;
--------------------------------------------
    close cuor_order_activity;
    end if;
	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
  Exception

    When pkg_error.controlled_error then
         -- Rollback;
		 pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
         Raise;
    When others then
         -- Rollback;
          onuErrorCode    := ld_boconstans.cnuGeneric_Error;
          osbErrorMessage := 'Error al Generar cargo a la solicitud [' ||
                             tempcuor_order_activity.package_id || '] ' ;
		  pkg_traza.trace(csbMT_NAME||'-'||onuErrorCode||':'||osbErrorMessage,cnuNVLTRC);
		  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
  END PrGeneraCargoFNB;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_PrEntregaArtuculos
  Descripcion    : Genera solicitud de venta de servicios de ingenieria para
                   crear la orden de instalacion de gasodomestico.

  Autor          : Jorge Valiente
  Fecha          : 25 - Octubre - 2013

  Parametros              Descripcion
  ============         ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  05-06-2015      ABaldovino       ARA 6798 - Se adiciona comentario en OR_ORDER_COMMENT luego de generada la solicitud
	05-06-2015      ABaldovino       Se elimina codigo comentado
  21-01-2013      Sayra Ocoro      Se adiciona un parametro de entrada al procedimiento para solucionar la
                                   NC 1750
  22/08/2014      Jorge Valiente   NC 1562: Modificar el ususario fijo 800167643 por el den parametro
                                            COD_USER_SOLICITUDES_INTERNAS
  ******************************************************************/

  procedure prEntregaArticulos (inuOrderId in or_order.order_id%type)
   is
    nuErrorCode       NUMBER;
    sbErrorMessage    VARCHAR2(4000);
    nuPackageId       mo_packages.package_id%type;
    nuMotiveId        mo_motive.motive_id%type;
    sbRequestIdExtern varchar2(2000);
    sbRequestXML1     constants_per.tipo_xml_sol%TYPE;
    nuorden           number; -- := 3614891; --3148698;
    dtFecha           DATE := SYSDATE;
    nuPersonId        ge_person.person_id%type;--GE_BOPERSONAL.fnuGetPersonId;
    nuPtoAtncn        number;
    sbComment         VARCHAR2(2000) := 'INSTALACION GASODOMESTICO BRILLA [TIPO_PAQUETE 100101]';
    nuProductId       number;
    nuContratoId      number;
    nuTaskTypeId      number;
    nuAddressId       number;
    nuActividad       number;
    nuIdentification  number;
    nuContactId       number;
    sbOrdersId        varchar2(4000);
    nuCOD_SERV_GAS    number;
    sbClasificacion   varchar2(2000);

    --variables para datos de la entidad de instancia
    Ionuentity binary_integer;
    Osbexist   varchar2(4000);
    ---------------------------------------------------

    --cursor para validar la linea del articulo asociado a la orden
    cursor culd_non_ban_fi_item(inuOrderId or_order.order_id%type) is
      select ld_item_work_order.article_id article_id
        from ld_item_work_order 
       where ld_item_work_order.order_id = inuOrderId 
         and DALD_SUBLINE.fnuGetLine_Id(DALD_ARTICLE.fnuGetSubline_Id(ld_item_work_order.ARTICLE_ID,
                                                                      NULL),
                                        NULL) IN
												(SELECT to_number(DatoItem) 
												   FROM(
														 SELECT regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('COD_LIN_ART',NULL), '[^,]+', 1, LEVEL)AS DatoItem
														 FROM dual
														 CONNECT BY regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('COD_LIN_ART',NULL), '[^,]+', 1, LEVEL) IS NOT NULL
														)
												);

    --fin cursor para linea del articulo asociado a la orden

    --cursor para validar la linea del articulo asociado a la orden
    cursor cuclasificacion(sbClasificaciono varchar2,
                           sbClasificacionc varchar2) is
      select 'X'
        from dual
       where sbClasificaciono IN
								(SELECT to_number(DatoItem) 
									FROM(
										 SELECT regexp_substr(sbClasificacionc, '[^,]+', 1, LEVEL)AS DatoItem
										 FROM dual
										 CONNECT BY regexp_substr(sbClasificacionc, '[^,]+', 1, LEVEL) IS NOT NULL
										)
								);
    --fin cursor para linea del articulo asociado a la orden

		--Obtiene el codigo del funcionario que realiza la venta
		CURSOR cuPersonFNB(inuPkgFNB mo_packages.package_id%TYPE) IS
			SELECT person_id
			FROM mo_packages
			WHERE package_id = inuPkgFNB;

	  CURSOR cuGetOrderVSI(inuPkgVSI mo_packages.package_id%TYPE) IS
		  SELECT order_id
			FROM or_order_activity
			WHERE package_id = inuPkgVSI;

    tempcuclasificacion      cuclasificacion%rowtype;
    tempculd_non_ban_fi_item culd_non_ban_fi_item%rowtype;
    nuSublineid              ld_subline.subline_id%type;
    nuPackageIdFNB           mo_packages.package_id%type;
	nuPersonFNBId            mo_packages.person_id%TYPE;
	nuOrderVSI               or_order.order_id%TYPE;

    --NC 1562 cursor y variables
    sbnumber_id varchar2(20) := DALD_PARAMETER.fsbGetValue_Chain('COD_USER_SOLICITUDES_INTERNAS',NULL);
    -------------------------

    csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.LDC_PrEntregaArtuculos';

  BEGIN

    pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);

    nuCOD_SERV_GAS := dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS',
                                                         NULL);
    if nuCOD_SERV_GAS is null then
        pkg_traza.trace('El parametro COD_SERV_GAS no tiene codigo de servicio de GAS.',cnuNVLTRC);
                     pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                                               'El parametro COD_SERV_GAS no tiene codigo de servicio de GAS.');
                     raise pkg_error.controlled_error;
    end if;
    nuActividad := dald_parameter.fnuGetNumeric_Value('COD_ACT_COT_TRA_VAR_BRI', NULL);
    if nuActividad is null then
         pkg_traza.trace('El parametro COD_ACT_COT_TRA_VAR_BRI no tiene codigo de actividad configurado.',cnuNVLTRC);
         pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                                   'El parametro COD_ACT_COT_TRA_VAR_BRI no tiene codigo de actividad configurado.');
         raise pkg_error.controlled_error;
    end if;
    sbClasificacion := dald_parameter.fsbGetValue_Chain('COD_CLA_UNI_OPE', NULL);
    if nuActividad is null then
       pkg_traza.trace('El parametro COD_CLA_UNI_OPE no tiene codigo de clasificacion de unidad operativa.',cnuNVLTRC);
       pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                                 'El parametro COD_CLA_UNI_OPE no tiene codigo de clasificacion de unidad operativa.');
       raise pkg_error.controlled_error;
    end if;

    --obtener datos de la instancia
    nuorden := inuOrderId;
    SELECT  PERSON_ID
    into  nuPersonId
    FROM    GE_PERSON
    WHERE   IDENT_TYPE_ID = 110
    AND     NUMBER_ID     = sbnumber_id; 

    ---obtiene el area organizacional
    SELECT ORGANIZAT_AREA_ID
      INTO nuPtoAtncn
      FROM CC_ORGA_AREA_SELLER
     WHERE PERSON_ID = nuPersonId
       AND IS_CURRENT = 'Y';

    SELECT PACKAGE_ID, SUBSCRIPTION_ID, TASK_TYPE_ID
      INTO nuPackageIdFNB, nuContratoId, nuTaskTypeId
      FROM OR_ORDER_ACTIVITY
     WHERE ORDER_ID = nuorden
       AND ROWNUM = 1;

    pkg_traza.trace('nuPackageId --> ' || nuPackageIdFNB,cnuNVLTRC);

    --*****Inicio nueva seccion*****--
    --Validar si la linea del articulo asociada al paquete esta parametrizada
    open culd_non_ban_fi_item(nuorden);
    fetch culd_non_ban_fi_item    into tempculd_non_ban_fi_item;
    pkg_traza.trace('ARTICULO tempculd_non_ban_fi_item => ' || tempculd_non_ban_fi_item.article_id ,cnuNVLTRC);

    if culd_non_ban_fi_item%found then
      nuSublineid:= dald_article.fnuGetSubline_Id(tempculd_non_ban_fi_item.article_id);
      pkg_traza.trace('SUBLINEA nuSublineid => ' || nuSublineid ,cnuNVLTRC);
      --Validar si la unidad operativa asociada a la solicitud es de clasificacion 70 -- fa?ta linea 1
      open cuclasificacion(pkg_bcunidadoperativa.fnuGetClasificacion(pkg_bcsolicitudes.fnuGetPuntoVenta(nuPackageIdFNB)),
                           sbClasificacion);
      fetch cuclasificacion
        into tempcuclasificacion;
      if cuclasificacion%found then
        --*****Fin nueva seccion*****--
        --Comentario en el codigo de la solicitud padre prveiniente
        --de la orden de ENTREGA DE ARTICULOS - FNB
        sbComment := sbComment || ' ORIGINADO POR LA SOLICITUD FNB # ' || nuPackageIdFNB || ' SUBLINEA '||nuSublineid||' - '|| dald_subline.fsbGetDescription(nuSublineid)||'[OT # '||nuorden||' ]' ;

         --21-01-2014 NC 1750: Adicionar descripcion de la sublinea del articulo
        --------------------------------------------------

        SELECT LP.IDENTIFICATION
          INTO nuIdentification
          FROM LD_PROMISSORY LP
         WHERE LP.PACKAGE_ID = nuPackageIdFNB
           AND UPPER(LP.PROMISSORY_TYPE) = 'D'
           and rownum = 1;

         nuProductId := pr_boproduct.fnuGetProdBySuscAndType(nuCOD_SERV_GAS,nuContratoId);
         nuAddressId := pkg_bcproducto.fnuIdDireccInstalacion(nuProductId);

        select gs.subscriber_id
          into nuContactId
          from ge_subscriber gs
         where gs.identification = to_char(nuIdentification)
           and rownum = 1;

        pkg_traza.trace('******************************************************',
                       cnuNVLTRC);
        pkg_traza.trace('Datos obtenidos de las consultas de la orden ' ||
                       nuorden,
                       cnuNVLTRC);
        pkg_traza.trace('Area organizacionla --> ' || nuPtoAtncn,cnuNVLTRC);
        pkg_traza.trace('Paquete --> ' || nuPackageIdFNB,cnuNVLTRC);
        pkg_traza.trace('Contrato --> ' || nuContratoId,cnuNVLTRC);
        pkg_traza.trace('Tipo de trabajo --> ' || nuTaskTypeId,cnuNVLTRC);
        pkg_traza.trace('Identificacion --> ' || nuIdentification,cnuNVLTRC);
        pkg_traza.trace('Producto --> ' || nuProductId,cnuNVLTRC);
        pkg_traza.trace('Direccion --> ' || nuAddressId,cnuNVLTRC);
        pkg_traza.trace('Contacto --> ' || nuContactId,cnuNVLTRC);
        pkg_traza.trace('Actividad --> ' || nuActividad,cnuNVLTRC);
        pkg_traza.trace('******************************************************',
                       cnuNVLTRC);

				sbRequestXML1 := pkg_xml_soli_vsi.getSolicitudVSI(
																   nuContratoId,
																   10,
																   sbComment,
																   nuProductId,
																   nuContactId,
																   nuPersonId,
																   nuPtoAtncn,
																   dtFecha,
																   nuAddressId,
																   nuAddressId,
																   nuActividad
																  );
				pkg_traza.trace(sbRequestXML1,cnuNVLTRC);

				api_registerRequestByXml(sbRequestXML1,
										 nuPackageId,
										 nuMotiveId,
										 nuErrorCode,
										 sbErrorMessage);

				pkg_traza.trace('nuErrorCode --> ' || nuErrorCode,cnuNVLTRC);
				pkg_traza.trace('sbErrorMessage --> ' || sbErrorMessage,cnuNVLTRC);

				if nuErrorCode <> 0 then
					pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
  											  sbErrorMessage ||
											  ' Codigo Error --> ' ||
											  nuErrorCode);
					raise pkg_error.controlled_error;

				else
						--21-01-2014 NC 1750
						---Generar persistencia para procesos futuros
						--Relacionar ordene con solicitudes
						insert into ldc_fnb_vsi (id_pkg_fnb,id_ot_ea,id_pkg_vsi,procesado)
												values (nuPackageIdFNB,nuorden,nuPackageId,'N');

						--05-06-2015 ABaldovino ARA 6798
					  --Se adiciona comentario con informacion de la venta
						nuPersonFNBId := NULL;
						FOR rgcuPersonFNB IN cuPersonFNB(nuPackageId) LOOP
							nuPersonFNBId := rgcuPersonFNB.Person_Id;
						END LOOP;

						FOR rgcuGetOrderVSI IN cuGetOrderVSI(nuPackageId) LOOP
							nuOrderVSI := rgcuGetOrderVSI.Order_Id;
						END LOOP;

						INSERT INTO or_order_comment(order_comment_id,
													 order_comment,
													 order_id,
													 comment_type_id,
													 register_date,
													 legalize_comment,
													 person_id)
						VALUES(seq_or_order_comment.nextval,
									 fsbgetfnbinfo(nuPackageId),
									 nuOrderVSI,
									 3,--Tipo de comentario
									 to_char(SYSDATE, 'dd/mm/yyy hh:mm:ss'),
									 'Y',
									 nuPersonFNBId);

				     --- FIN ARA 6798------------

						commit;
				end if;

			end if; --fin de validacion de clasificacion de unidad operativa
			close cuclasificacion;
		end if; --fin validacion de linea de articulo
		close culd_non_ban_fi_item;
		--*/
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC, pkg_traza.csbFIN);

  EXCEPTION

    WHEN pkg_error.controlled_error THEN
     -- Rollback;
      pkg_error.setError;
      pkg_error.getError(nuErrorCode, sbErrorMessage);
	  pkg_traza.trace(csbMT_NAME||' -'||nuErrorCode||':'||sbErrorMessage||sqlerrm, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise;
    when OTHERS then
     -- Rollback;
      pkg_error.setError;
      pkg_error.getError(nuErrorCode, sbErrorMessage);
	  pkg_traza.trace(csbMT_NAME||' -'||nuErrorCode||':'||sbErrorMessage||sqlerrm, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise;

  END prEntregaArticulos;

   /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : prCreateProductFNB
  Descripcion    : Crea un producgto de tipo FNB (7053, 7055,7056) en un contrato para
                   realizar posteriormente el traslado de cartera.

  Autor          : Sayra Ocoro
  Fecha          : 08-01-2014

  Parametros              Descripcion
  ============         ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  23-03-2015      Sandra Lemus        Aranda 6372 Se realiza modificacion del procedimeinto,
                                      ya que solo realizaba los traslados para los tipos de
                                      productos quemados en el codigo, se reemplaza el codigo
                                      para obtener los valores por parametros-
  ******************************************************************/

  procedure prCreateProductFNB
  is
      nuErrorCode NUMBER;
      sbErrorMessage VARCHAR2(4000);
      nuSubscription      pr_product.subscription_id%type;
      nuProductId         pr_product.product_id%type;
      rcProduct           dapr_product.stypr_product;
      rcAb_address        daab_address.styAB_address;
      nuProductTypeId     pr_product.product_type_id%type;
      nuCommPlanId        pr_product.commercial_plan_id%type;
      nuCompanyId         pr_product.company_id%type;
      tbSaleComposition   daps_prod_motive_comp.tytbPS_prod_motive_comp;

      /* tipos */
              TYPE tytbNumber IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
              TYPE tyrcComponents IS RECORD
              (
                  PrComponent     tytbNumber,
                  prodMotComp     tytbNumber,
                  parentPrComp    tytbNumber,
                  MoComponent     tytbNumber,
                  parentIndex     tytbNumber
              );
      /* Record para almacenar la jerarquia de componentes */
      rcCompRelations     tyrcComponents;
      nuIndex             BINARY_INTEGER;
      nuComponent         pr_component.component_id%type;
      nuParentComp        ps_prod_motive_comp.parent_comp%type;
      nuProductMotive     ps_product_motive.product_motive_id%type;

      cnuNULL_ATTRIBUTE constant number := 2126;

      sbSUSCCODI        ge_boInstanceControl.stysbValue;
      sbPRODUCT_TYPE_ID ge_boInstanceControl.stysbValue;
      sbCommercialPlan  varchar2(200);
      sbTagName         varchar2(250);
      sbparTagName      ld_parameter.value_chain%type;
      sbmensa            VARCHAR2(100);
      sbAtributoNulo     varchar2(100);
	  
	  csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.prCreateProductFNB';
	  sbProceso VARCHAR2(70) := 'prCreateProductFNB'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
    
     CURSOR cuMensaje IS
     select description from ge_message where message_id = cnuNULL_ATTRIBUTE;

	  
    BEGIN

        pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
		
        IF cuMensaje%ISOPEN THEN
            CLOSE cuMensaje;
        END IF;

        OPEN cuMensaje;
        FETCH cumensaje INTO sbAtributoNulo;
        CLOSE cuMensaje;
        
		 -- Se inicia log del programa
		 pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);

			sbSUSCCODI := ge_boInstanceControl.fsbGetFieldValue ('SUSCRIPC', 'SUSCCODI');
			sbPRODUCT_TYPE_ID := ge_boInstanceControl.fsbGetFieldValue ('PR_PRODUCT', 'PRODUCT_TYPE_ID');    

			------------------------------------------------
			-- Required Attributes
			------------------------------------------------

		if (sbSUSCCODI is null) then
			pkg_error.setErrorMessage(NULL, sbAtributoNulo|| ' Contrato');
			raise pkg_error.controlled_error;
		end if;

		if (sbPRODUCT_TYPE_ID is null) then
			pkg_error.setErrorMessage(NULL, sbAtributoNulo ||' Tipo de Producto');
			raise pkg_error.controlled_error;
		end if;


		------------------------------------------------
		-- User code
		------------------------------------------------

		nuSubscription:=to_number(sbSUSCCODI);
		pkg_traza.trace('nuSubscription['||nuSubscription||']',cnuNVLTRC);
		-- obtiene el producto de gas
		nuProductId:= pr_boproduct.fnuGetProdBySuscAndType(dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS'),nuSubscription);
		pkg_traza.trace('Product de gas: '||nuProductId,cnuNVLTRC);
		-- obtiene el record del producto
		rcProduct:= dapr_product.frcgetrecord(nuProductId);

		/* Obtiene el record de la direccion */
		rcAb_address := daab_address.frcGetRecord(rcProduct.address_id);

		-- Define tipo de producto. Brilla promigas 
		nuProductTypeId := to_number(sbPRODUCT_TYPE_ID);

		pkg_traza.Trace('nuProductTypeId['||nuProductTypeId||']',cnuNVLTRC);

		sbCommercialPlan := 'COD_COMERCIAL_PLAN_'||nuProductTypeId;
		sbparTagName := 'M_TAG_INSTALACION_DE_'||nuProductTypeId;

		pkg_traza.Trace('sbCommercialPlan['||sbCommercialPlan||']',cnuNVLTRC);

		pkg_traza.Trace('sbparTagName['||sbparTagName||']',cnuNVLTRC);

		LD_boflowFNBPack.GetLdparamater(sbCommercialPlan, 'N', nuCommPlanId);
		sbTagName := dald_parameter.fsbGetValue_Chain(sbparTagName, null);

		pkg_traza.Trace('nuCommPlanId['||nuCommPlanId||']',cnuNVLTRC);

		/* Obtiene el id de la empresa del usuario conectado */
		nuCompanyId := SA_BOSystem.fnuGetUserCompanyId;
		pkg_traza.Trace('nuCompanyId['||nuCompanyId||']',cnuNVLTRC);
		/* Se crea el producto */
		PR_BOCreationProduct.Register
		(
			nuSubscription,
			nuProductTypeId,
			nuCommPlanId,
			ldc_boConsGenerales.fdtGetSysDate,
			rcProduct.address_id,
			rcProduct.category_id,
			rcProduct.subcategory_id,
			nuCompanyId,
			pkg_bopersonal.fnuGetPersonaId,
			pkg_bopersonal.fnuGetPuntoAtencionId(pkg_bopersonal.fnuGetPersonaId),
			nuProductId,
			pkg_gestion_producto.CNUESTADO_ACTIVO_PRODUCTO, -- estado de producto
			ldc_bcConsGenerales.fsbValorColumna('PARAMETR', 'PAMENUME', 'PAMECODI', 'EST_SERVICIO_SIN_CORTE'),-- estado de corte
			NULL,
			NULL,
			NULL,
			NULL
		);

		pkg_traza.Trace('ProductoCreado =>: '||nuProductId,cnuNVLTRC);


		-- Se obtiene el valor del producto-motivo de venta de servicios financieros   para promigas M_INSTALACION_DE_SERVICIOS_FINANCIEROS_PROMIGAS_100215


		nuProductMotive := ps_boproductmotive.fnuGetProdMotiveByTagName(sbTagName);

		pkg_traza.Trace('Producto-Motivo['||nuProductMotive||']',cnuNVLTRC);
		/* Se obtiene la composicion de los componentes de la venta */
		DAPS_prod_motive_comp.GetRecords('Product_Motive_Id = '||nuProductMotive||' ORDER BY ASSIGN_ORDER ASC', tbSaleComposition);

		/* Inicializa el componente padre en null */
		nuParentComp := NULL;

		pkg_traza.Trace('Composicion de nivel['||tbSaleComposition.COUNT||']',cnuNVLTRC);
		nuIndex := tbSaleComposition.FIRST;

		/* Recorre la composicion */
		WHILE (nuIndex IS NOT NULL) LOOP

			/* Calcula el componenete padre */
			IF (tbSaleComposition(nuIndex).parent_comp IS NOT NULL) THEN
				nuParentComp := rcCompRelations.PrComponent(tbSaleComposition(nuIndex).parent_comp);
			ELSE
				nuParentComp := NULL;
			END IF;

			pkg_traza.Trace('Calcula el parent_comp['||nuParentComp||']',cnuNVLTRC);

			/* Crea un componente por cada registro */

				PR_BOCreationComponent.Register
				(
					nuProductId,                                    /* inuProductId */
					tbSaleComposition(nuIndex).component_type_id,   /* inuComponentTypeId */
					null,    /* inuClassServiceId */
					NULL,               /* isbServiceNumber */
					NULL,               /* idtServiceDate */
					NULL,               /* idtMediationDate */
					NULL,               /* inuQuantity */
					NULL,               /* inuUnchargedTime */
					NULL,               /* isbDirectionality */
					rcProduct.category_id, /* inuCategoryId */
					rcProduct.subcategory_id, /* inuSubcategoryId */
					NULL,               /* inuDistributAdminId */
					NULL,               /* inuMeter */
					NULL,               /* inuBuildingId */
					NULL,               /* inuAssignRouteId */
					nuParentComp,       /* inuParentComp */
					NULL,               /* isbDistrictId */
					NULL,               /* isbincluded */
					rcAb_address.address_id,            /* inuaddressId */
					rcAb_address.geograp_location_id,   /* inugeograp_location_id */
					rcAb_address.neighborthood_id,      /* inuneighborthood_id */
					rcAb_address.address,               /* isbaddress */
					NULL,               /* inuProductOrigin */
					NULL,               /* inuIncluded_Features_Id */
					NULL,               /* isbIsMain */
					nuCommPlanId,      /* inuCommercial_Plan_Id */
					nuComponent,        /* onuComponentId */
					FALSE,              /* iblRegAddress */
					FALSE,              /* iblElemmedi */
					FALSE,              /* iblSpecialPhone */
					NULL,               /* inuCompProdProvisionId */
					pkg_gestion_producto.CNUESTADO_ACTIVO_COMPONENTE,   /* inuComponentStatusId */
					FALSE               /* iblValidate */
				);

			pkg_traza.Trace('Componente['||nuComponent||']',cnuNVLTRC);
			/* Guarda en la tabla temporal */
			rcCompRelations.prodMotComp(tbSaleComposition(nuIndex).prod_motive_comp_id) := tbSaleComposition(nuIndex).prod_motive_comp_id;
			rcCompRelations.PrComponent(tbSaleComposition(nuIndex).prod_motive_comp_id) := nuComponent;
			rcCompRelations.parentPrComp(tbSaleComposition(nuIndex).prod_motive_comp_id):= nuParentComp;
			rcCompRelations.MoComponent(tbSaleComposition(nuIndex).prod_motive_comp_id) := NULL;
			rcCompRelations.parentIndex(tbSaleComposition(nuIndex).prod_motive_comp_id) := tbSaleComposition(nuIndex).parent_comp;


			nuIndex := tbSaleComposition.next(nuIndex);

		END LOOP;
		commit;
		sbmensa := 'Se proceso el contrato : '||sbSUSCCODI;

		pkg_estaproc.prActualizaEstaproc(sbProceso,'Termino Ok.');
		
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC, pkg_traza.csbFIN);



EXCEPTION
    when pkg_error.controlled_error then
	  pkg_error.setError;
      pkg_error.getError(nuErrorCode, sbErrorMessage);
	  pkg_traza.trace(csbMT_NAME||' -'||nuErrorCode||':'||sbErrorMessage||sqlerrm, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise;

    when OTHERS then
      pkg_error.setError;
      pkg_error.getError(nuErrorCode, sbErrorMessage);
	  pkg_traza.trace(csbMT_NAME||' -'||nuErrorCode||':'||sbErrorMessage||sqlerrm, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;

  end prCreateProductFNB;

   /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : fnuValidateSuscription
  Descripcion    : Valida si el numero de suscripcion ingresado existe,
                   si tiene producto de gas (7014) ACTIVO y si no tiene algun
                   tipo de servicio financiero {7053,7055,7056}

  Autor          : Sayra Ocoro
  Fecha          : 09-01-2014

  Parametros              Descripcion
  ============         ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  21-Abril-2014   Jorge Valiente      Aranda 3348: Modificacion de validacion de estado de producto GAS.
                                                   En conversacion con la funcionario Leila Gonzalez se
                                                   determino que valide el estado del producto en estado 1 Activo o 2 Suspendido.
  10/Oct/2022     Edmundo Lara        OSF-557: Se quita la validacion de que un contrato no permita crear un nuevo producto
                                               si ya tiene creado uno en los servicios;
                                               7056 Brilla Promigas
                                               7055 Brilla GDCA
                                               7053 Brilla Seguros.
                                               Cuando cumple la anterior condicion, retorna 5, bloquea la creacion, se cambiara por el valor 
                                               que tiene el paramero 'COD_RETORNO_FORMA_CPTCB', que estare en 6, para que no bloquee 
                                               el proceso de la forma.

  ******************************************************************/
 function fnuValidateSuscription
 return number
 is
    sbSUSCCODI                  ge_boInstanceControl.stysbValue;
    nuSusccodi                  suscripc.susccodi%type;
    nuProductId                 pr_product.product_id%type;
	nuProdServFinan				pr_product.product_id%type;
	nuProdBrilla				pr_product.product_id%type;
	nuProdBrillaProm			pr_product.product_id%type;
		  
    csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuValidateSuscription';
	
	CURSOR cuProdxtipo(inuContrato suscripc.susccodi%TYPE,
					   inuTipoProd servsusc.sesuserv%TYPE) IS
		SELECT  PRODUCT_ID
		FROM    PR_PRODUCT A
		WHERE   A.SUBSCRIPTION_ID = inuContrato
		AND     A.PRODUCT_TYPE_ID = inuTipoProd
		AND EXISTS (SELECT 'x'
				FROM PS_PRODUCT_STATUS B
				WHERE B.PRODUCT_STATUS_ID = A.PRODUCT_STATUS_ID
				AND (B.IS_ACTIVE_PRODUCT = constants_per.CSBYES));


 BEGIN
    pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);

    --Obtener identificador de la suscripcion
    sbSUSCCODI := ge_boInstanceControl.fsbGetFieldValue ('SUSCRIPC', 'SUSCCODI');
	
	if sbSUSCCODI is not null then
        nuSusccodi := to_number(sbSUSCCODI);
        --Validar si en contrato existe
        if pktblsuscripc.fblexist(nuSusccodi) then
		   	IF cuProdxtipo%ISOPEN THEN
				CLOSE cuProdxtipo;
			END IF;
	
			OPEN cuProdxtipo(nuSusccodi,dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS'));
			FETCH cuProdxtipo INTO nuProductId;
			CLOSE cuProdxtipo;
				
            if nuProductId is not null then
                --Validar el estado del producto = ACTIVO o producto = SUSPENDIDO
                --Modiicacion de validacion por Aranda 3348 adicionando el estado de producto GAS en Suspendido
                --y colocando parametros para los estado del prodcuto
                if pkg_bcproducto.fnuEstadoProducto(nuProductId) = dald_parameter.fnuGetNumeric_Value('ID_PRODUCT_STATUS_ACTIVO',NULL) or
                   pkg_bcproducto.fnuEstadoProducto(nuProductId) = dald_parameter.fnuGetNumeric_Value('ID_PRODUCT_STATUS_SUSP',NULL) then
                   --Validar que el producto no tenga uno de los productos de servicios financieros

					IF cuProdxtipo%ISOPEN THEN
						CLOSE cuProdxtipo;
					END IF;
	
					OPEN cuProdxtipo(nuSusccodi,dald_parameter.fnuGetNumeric_Value('COD_PRODUCT_TYPE'));
					FETCH cuProdxtipo INTO nuProdServFinan;
					CLOSE cuProdxtipo;

					IF cuProdxtipo%ISOPEN THEN
						CLOSE cuProdxtipo;
					END IF;
	
					OPEN cuProdxtipo(nuSusccodi,dald_parameter.fnuGetNumeric_Value('COD_PRODUCT_TYPE_BRILLA'));
					FETCH cuProdxtipo INTO nuProdBrilla;
					CLOSE cuProdxtipo;

					IF cuProdxtipo%ISOPEN THEN
						CLOSE cuProdxtipo;
					END IF;
	
					OPEN cuProdxtipo(nuSusccodi,dald_parameter.fnuGetNumeric_Value('COD_PRODUCT_TYPE_BRILLA_PROM'));
					FETCH cuProdxtipo INTO nuProdBrillaProm;
					CLOSE cuProdxtipo;

				   
                   if nuProdServFinan is null  or nuProdBrilla is null or nuProdBrillaProm is null then
					    pkg_traza.trace(csbMT_NAME || 'Retorna 1',cnuNVLTRC);
                        return 1;
                   else
                        -- OSF-557
                        -- return 5; -- Valida y no permite crear productos nuevos al contrato
						pkg_traza.trace(csbMT_NAME ||' Retorna: ' ||dald_parameter.fnuGetNumeric_Value('COD_RETORNO_FORMA_CPTCB'),cnuNVLTRC);
                        return dald_parameter.fnuGetNumeric_Value('COD_RETORNO_FORMA_CPTCB'); -- No valida y permite crear productos nuevos al contrato
                   end if;
                else
				    pkg_traza.trace(csbMT_NAME || 'Retorna 4',cnuNVLTRC);
                    return 4;
                end if;
            else
			   pkg_traza.trace(csbMT_NAME || 'Retorna 3',cnuNVLTRC);
               return 3;
            end if;
        else
		   pkg_traza.trace(csbMT_NAME || 'Retorna 2',cnuNVLTRC);
           return 2;
        end if;
    end if;
	pkg_traza.trace(csbMT_NAME || 'Retorna 0',cnuNVLTRC);
    return 0;
	
 end fnuValidateSuscription;

 /*****************************************
  Metodo: fsbApliMalaAsesoria
  Descripcion: Indica si a la orden que se encuentra en la instancia le aplica
               novedad por mala asesoria. Para lo cual debe cumplir:
               1. Orden de trabajo de tipo APLICA ANULACION VENTA
               2. Legalizada con causal de exito - 3069
               3. Tener el dato adicional CAUSA_REAL_ANULACION con valor 3. MALA ASESORIA
               4. No tener una multa por el mismo motivo asociado a la solicitud de venta

  Parametros:

  Autor: Sayra Ocoro
  Fecha: 17/01/2014

  Historial de Modificaciones
  =========================================================================
     Fecha                Autor              Descripcion
  17-01-2014           Sayra Ocoro         Se CREA la logica para un objeto de legalizacion
                                           que soluciona la NC 2459_2
   ****************************************************************/
  procedure prMultaMalaAsesoria is

    --obtiene la solicitud de anulacion/devolucion de la orden de la instancia
    cursor cuSolicitudOrden(nuorder or_order.order_id%type) is
      select a.package_id, b.package_id_asso
      from or_order_activity a, mo_packages_asso b
      where order_id = nuOrder
      and a.PACKAGE_ID = b.PACKAGE_ID;

    cursor cuordennovedad(nusolicitud    or_order_activity.package_id%type,
                          numalaasesoria or_order_activity.activity_id%type) is
      select a.order_id
        from or_order_activity a, or_order b
       where a.order_id = b.order_id
         and a.package_id = nusolicitud
         and a.activity_id = numalaasesoria
         and b.order_status_id = 8;

    cursor cuParametros
    IS
        select parameter_id, numeric_value, value_chain
        from ld_parameter
        where parameter_id in ('COD_APLICA_ANULA_VTA_TIPO_TRAB',
                               'COD_CAUSAL_APRUEBA_ANULA',
                               'COD_ITEM_MALA_ASESORIA_FNB',
                               'VAL_SAL_MIN_DIA_LEG_VIG',
                               'ID_TIPO_OBS_COMISION_VENTA',
                               'COD_ENTREGA_ART_FNB_TIPO_TRAB',
                               'COD_ORDER_STATUS',
                               'COD_LIN_ART',
                               'COD_CLA_UNI_OPE');

    type tyParametros is record (parameter_id ld_parameter.parameter_id%type,
                                 numeric_value ld_parameter.numeric_value%type,
                                 value_chain   ld_parameter.value_chain%type);

    type tbtyParametros is table of tyParametros index by binary_integer;

    tbParametros tbtyParametros;

    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);

    nuaplicaanulavta    number;
    nucausalaplicaanula number;
    nuMalaAsesoria      number;

    -- Para validar existencia de causal "Mala Asesoria". 1 = SI, 2 = NO
    nuExisteCausalMalaAsesoria number := 2;

    nutipotrabajo       or_order.task_type_id%type;
    nusolicitud         or_order_activity.package_id%type;
    nusolicitudvta      or_order_activity.package_id%type;
    nucausal            ge_causal.causal_id%type;
    nuOrdenNovedad      or_order.order_id%type;
    sbvalorcausa        varchar2(400);
    sbAplica            varchar2(1) := 'N';
    nuorder_id          or_order.order_id%type;
    idtDate             date;
    nuOperatingUnitId   or_operating_unit.operating_unit_id%type;
    onuValue            number;
    onuErrorCode        number;
	osbErrorMessage     varchar2(2000);
    nuIdComisionVenta   number;

    csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.prMultaMalaAsesoria';


  begin
    pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);

    nuorder_id := pkg_bcordenes.fnuObtenerOTInstanciaLegal;

    open cuParametros;
    fetch cuParametros bulk collect into tbParametros;
    close cuParametros;

    if tbParametros.count > 0 then
        for i in tbParametros.first .. tbParametros.last loop
            if tbParametros(i).parameter_id = 'COD_APLICA_ANULA_VTA_TIPO_TRAB' then
                nuaplicaanulavta := tbParametros(i).numeric_value;
            elsif tbParametros(i).parameter_id = 'COD_CAUSAL_APRUEBA_ANULA' then
                nucausalaplicaanula := tbParametros(i).numeric_value;
            elsif tbParametros(i).parameter_id = 'COD_ITEM_MALA_ASESORIA_FNB' then
                nuMalaAsesoria := tbParametros(i).numeric_value;
            elsif tbParametros(i).parameter_id = 'VAL_SAL_MIN_DIA_LEG_VIG' then
                onuValue := tbParametros(i).numeric_value;
            elsif tbParametros(i).parameter_id = 'ID_TIPO_OBS_COMISION_VENTA' then
                nuIdComisionVenta := tbParametros(i).numeric_value;

            elsif tbParametros(i).parameter_id = 'COD_ENTREGA_ART_FNB_TIPO_TRAB' then
                nuTTEntregaArt := tbParametros(i).numeric_value;

            elsif tbParametros(i).parameter_id = 'COD_ORDER_STATUS' then
                nuOrderStatus := tbParametros(i).numeric_value;

            elsif tbParametros(i).parameter_id = 'COD_LIN_ART' then
                sbLineaArticulo := tbParametros(i).value_chain;

            elsif tbParametros(i).parameter_id = 'COD_CLA_UNI_OPE' then
                sbClasOT := tbParametros(i).value_chain;
            end if;
        end loop;
    end if;

    pkg_traza.trace('nuaplicaanulavta => '||nuaplicaanulavta, cnuNVLTRC);
    pkg_traza.trace('nucausalaplicaanula => '||nucausalaplicaanula, cnuNVLTRC);
    pkg_traza.trace('nuMalaAsesoria => '||nuMalaAsesoria, cnuNVLTRC);

    nuTipoTrabajo := pkg_bcordenes.fnuObtieneTipoTrabajo(nuorder_id);
    pkg_traza.trace('nuTipoTrabajo => '||nuTipoTrabajo, cnuNVLTRC);
    nucausal := pkg_bcordenes.fnuobtienecausal(nuorder_id);
    pkg_traza.trace('nucausal => '||nucausal, cnuNVLTRC);

    if (nutipotrabajo is not null or nutipotrabajo > 0) then
      --si trabajo es 10145 aplica anulacion de la venta y tiene la causal de exito 3069
      if ((nutipotrabajo = nuaplicaanulavta) and
                         (nucausal = nucausalaplicaanula)) then
        --Obtener la causal con la que se registro la solicitud de anulacion
        BEGIN
            SELECT 1
                INTO nuExisteCausalMalaAsesoria
                FROM mo_motive m, or_order_activity a
                WHERE a.ORDER_id = nuorder_id
                and a.PACKAGE_id = m.package_id
                AND m.causal_id = 211 --137
                AND rownum = 1;
        EXCEPTION
            when no_data_found then
                nuExisteCausalMalaAsesoria := 2;
        END;
        pkg_traza.trace('nuExisteCausalMalaAsesoria => '||nuExisteCausalMalaAsesoria, cnuNVLTRC);
        --valida la existencia de causal "Mala Asesoria". 1 = SI, 2 = NO
        if nuExisteCausalMalaAsesoria = 1 then

          --obtiene la solicitud asociada a la orden de la instancia
          open cuSolicitudOrden(nuorder_id);
          fetch cuSolicitudOrden
            into nuSolicitud, nusolicitudvta;
          close cuSolicitudOrden;

          pkg_traza.trace('nuSolicitud => '||nuSolicitud, cnuNVLTRC);
          if (nusolicitud is not null or nusolicitudvta > 0) then
            --obtiene la solicitud de venta asociada a la solicitud de la orden de la instancia

            pkg_traza.trace('nuSolicitudVta => '||nuSolicitudVta, cnuNVLTRC);
            if (nusolicitudvta is not null or nusolicitudvta > 0) then
              open cuordennovedad(nusolicitud, nuMalaAsesoria);
              fetch cuordennovedad
                into nuOrdenNovedad;
              close cuordennovedad;

              pkg_traza.trace('nuOrdenNovedad 1 => '||nuOrdenNovedad, cnuNVLTRC);
              if (nuordennovedad is null) then
                open cuordennovedad(nuSolicitudVta, nuMalaAsesoria);
                fetch cuordennovedad
                  into nuordennovedad;
                close cuordennovedad;
              end if;

              pkg_traza.trace('nuOrdenNovedad 2 => '||nuOrdenNovedad, cnuNVLTRC);
              if (nuordennovedad is null) then
                 pkg_traza.trace('APLICANDO MULTA => ', cnuNVLTRC);
                 sbAplica := 'S';
                 idtDate := SYSDATE;
                 nuOperatingUnitId := pkg_bcsolicitudes.fnuGetPuntoVenta(nusolicitudvta);
                 pkg_traza.trace('nuOperatingUnitId => '||nuOperatingUnitId, cnuNVLTRC);
				 api_registernovelty(nuOperatingUnitId,nuMalaAsesoria,NULL,NULL,onuValue,NULL,nuIdComisionVenta,'Multa por Mala Asesoria','N',onuErrorCode,osbErrorMessage);
				 if (onuErrorCode <> 0) then
                      rollback;
          			  pkg_error.setErrorMessage(onuErrorCode, osbErrorMessage);
                      raise pkg_error.controlled_error;
                 end if;
              end if;
            end if;
          end if;
        end if;
      end if;
    end if;
	
  EXCEPTION
   WHEN pkg_error.controlled_error THEN
	  pkg_error.setError;
      pkg_error.getError(nuErrorCode, sbErrorMessage);
	  pkg_traza.trace(csbMT_NAME||' -'||nuErrorCode||':'||sbErrorMessage||sqlerrm, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise;
    when others then
	  pkg_error.setError;
      pkg_error.getError(nuErrorCode, sbErrorMessage);
	  pkg_traza.trace(csbMT_NAME||' -'||nuErrorCode||':'||sbErrorMessage||sqlerrm, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise;

  end prMultaMalaAsesoria;

   /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prRegisterSVI
  Descripcion    : Porcedimiento para registrar Solicitudes de Venta de Servicios de Ingenieria

  Autor          : Sayra Ocoro
  Fecha          : 21/01/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
	 05-06-2015    ABaldovino ARA 6798  Se adiciona comentario con informacion de la venta en OR_ORDER_COMMENT
   28-10-2014    KCienfuegos.RNP1808  Se modifica para excluir las ventas empaquetadas, ya que estas generan sus propias
                                      ordenes de instalacion.
   14-10-2014    KCienfuegos.RNP1179  Se modifica para validar si la venta se marco con instalacion de gasodomestico
                                      por proveedor, en tal caso, no se debe crear el tramite de venta de servicios
                                      de ingenieria.
   17-02-2014    Sayra Ocoro        ARANDA 2819: Se modifica
  ******************************************************************/
  Procedure prRegisterSVI
  is
      --Cursor para obtener las ordenes de entrega de articulo FNB para las que no se a registado Solicitud
      ---de Venta de Servicios de Ingenieria para la instalacion
      cursor cuOrders is
     select distinct or_order.order_id idOt, or_order_activity.package_id idPkg, or_order_activity.subscription_id idC
        	from or_order, or_order_activity,mo_packages,ld_item_work_order
        		where or_order.task_type_id = dald_parameter.fnuGetNumeric_Value('COD_ENTREGA_ART_FNB_TIPO_TRAB')
        			and order_status_id = dald_parameter.fnuGetNumeric_Value('COD_ORDER_STATUS')
        			and or_order_activity.order_id = or_order.order_id
        			and not exists
        				  (select null
        				  from ldc_fnb_vsi
        					  where  ldc_fnb_vsi.id_ot_ea = or_order.order_id
        				  )
              --Se excluyen los de venta con instalacion de proveedor RNP1179
              and not exists (select package_id
                                from ldc_instal_gasodom_fnb ig
                               where ig.package_id = mo_packages.package_id)
              --Se excluyen los de venta empaquetada RNP1808
              and not exists (select package_fnb_id
                                 from ldc_venta_empaquetada ve
                                where ve.package_fnb_id = mo_packages.package_id
                                  and ve.gas_applianc_sale ='Y'
                                  and ve.flag_gas_fnb_sale ='Y')
              and mo_packages.package_id = or_order_activity.package_id
              and mo_packages.user_id <> 'MIGRA'
              and ld_item_work_order.order_id = or_order.order_id 
              and DALD_SUBLINE.fnuGetLine_Id(DALD_ARTICLE.fnuGetSubline_Id(ld_item_work_order.ARTICLE_ID,NULL),
                                              NULL) IN
													(SELECT to_number(DatosParametro) 
													 FROM(
														  SELECT regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('COD_LIN_ART',NULL), '[^,]+', 1, LEVEL)AS DatosParametro
														  FROM dual
														  CONNECT BY regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('COD_LIN_ART',NULL), '[^,]+', 1, LEVEL) IS NOT NULL
														  )
													)
              and pkg_bcunidadoperativa.fnuGetClasificacion(pkg_bcsolicitudes.fnuGetPuntoVenta(or_order_activity.package_id))
              IN
					(SELECT to_number(DatosParametro) 
					 FROM(
						  SELECT regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('COD_CLA_UNI_OPE',NULL), '[^,]+', 1, LEVEL)AS DatosParametro
						  FROM dual
						  CONNECT BY regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('COD_CLA_UNI_OPE',NULL), '[^,]+', 1, LEVEL) IS NOT NULL
						  )
					);

      nuIdVSI          mo_packages.package_id%type;
      nuArticleId      ld_article.article_id%type;
      nuSublineId      ld_subline.subline_id%type;
      nuConsecutive    ldc_instal_gasodom_fnb.consecutive%type;
      --Cursor para obtener los articulos vendidos en la ot
      cursor cuArticle(inuOrderId or_order.order_id%type) is
      select ld_item_work_order.article_id articleId
        from ld_item_work_order
       where ld_item_work_order.order_id = inuOrderId;

       --Cursor para obtener las la orden de tipo de trabajo 10360 en estado asignado de una solicitud dada
       cursor cuOrder10360 (inuPackageId mo_packages.package_id%type) is
         select count (*)
           from or_order, or_order_activity
             where or_order_activity.package_id = inuPackageId
               and or_order_activity.order_id = or_order.order_id
               and or_order.task_type_id = 10360
               and or_order.order_status_id in (7,8);

		--Obtiene el codigo del funcionario que realiza la venta
			CURSOR cuPersonFNB(inuPkgFNB mo_packages.package_id%TYPE) IS
				SELECT person_id
				FROM mo_packages
				WHERE package_id = inuPkgFNB;

			CURSOR cuGetOrderVSI(inuPkgVSI mo_packages.package_id%TYPE) IS
				SELECT order_id
				FROM or_order_activity
				WHERE package_id = inuPkgVSI;

       nuCount            number;
       sbComment          mo_packages.comment_%type;
       nuCOD_SERV_GAS     number := dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS');
       nuProductId        pr_product.product_id%type;
 	   nuPersonFNBId      mo_packages.person_id%TYPE;
	   nuOrderVSI         or_order.order_id%TYPE;

       csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.prRegisterSVI';
       nuErrorCode NUMBER;
       sbErrorMessage VARCHAR2(4000);


  BEGIN

      pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);

		  for  rgOrders in cuOrders loop
         --Validar susi en proceso
         nuProductId:= pr_boproduct.fnuGetProdBySuscAndType(nuCOD_SERV_GAS,rgOrders.IdC);
         nuIdVSI := null;
         nuIdVSI := mo_bopackages.fnugetidpackage(nuProductId,100101,13);
         if nuIdVSI is not null then

            --Si existe susi y tiene ot de cotizacion sin ejecutar ni legalizar
            ---Adicionar sublinea al comentario de la solicitud y relacionar en la tabla LDC_FNB_VSI
            nuCount := 0;
            open cuOrder10360 (nuIdVSI);
            fetch cuOrder10360 into nuCount;
            close cuOrder10360;

            if nuCount is not null and nuCount = 0 then
                  nuArticleId := null;
                  open cuArticle (rgOrders.Idot);
                  fetch cuArticle into nuArticleId;
                  close cuArticle;
                  if nuArticleId is not null then
                     nuSublineId := dald_article.fnuGetSubline_Id(nuArticleId);
                     sbComment := damo_packages.fsbgetcomment_(nuIdVSI);
                     sbComment := sbComment || ' '||nuSublineId || ' - '|| dald_subline.fsbGetDescription(nuSublineId);
                     --Actualizar comentario de la solicitud
                     damo_packages.updcomment_(nuIdVSI,sbComment);
                     --Relacionar ordene con solicitudes
                     insert into ldc_fnb_vsi (id_pkg_fnb,id_ot_ea,id_pkg_vsi,procesado)
                            values (rgOrders.Idpkg,rgOrders.Idot,nuIdVSI,'N');
										--05-06-2015 ABaldovino ARA 6798
										--Se adiciona comentario con informacion de la venta
										nuPersonFNBId := NULL;
										FOR rgcuPersonFNB IN cuPersonFNB(rgOrders.Idpkg) LOOP
											nuPersonFNBId := rgcuPersonFNB.Person_Id;
										END LOOP;

										FOR rgcuGetOrderVSI IN cuGetOrderVSI(nuIdVSI) LOOP
											nuOrderVSI := rgcuGetOrderVSI.Order_Id;
										END LOOP;

										INSERT INTO or_order_comment(order_comment_id,
																	 order_comment,
																	 order_id,
																	 comment_type_id,
																	 register_date,
																	 legalize_comment,
																	 person_id)
										VALUES(seq_or_order_comment.nextval,
													 fsbgetfnbinfo(nuIdVSI),
													 nuOrderVSI,
													 3,--Tipo de comentario
													 to_char(SYSDATE, 'dd/mm/yyy hh:mm:ss'),
													 'Y',
													 nuPersonFNBId);

				           --- FIN ARA 6798------------

                  end if;
            end if;

         else
             --Registrar Solicitud de Venta de Servicios de Ingenieria
              LDC_BOVENTASFNB.prEntregaArticulos(rgOrders.idOt);
         end if;
		  end loop;
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

      commit;
  exception
      when others then
	  pkg_error.setError;
      pkg_error.getError(nuErrorCode, sbErrorMessage);
	  pkg_traza.trace(csbMT_NAME||' -'||nuErrorCode||':'||sbErrorMessage||sqlerrm, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      rollback;
      raise;
  end prRegisterSVI;

END LDC_BOVENTASFNB;
/
