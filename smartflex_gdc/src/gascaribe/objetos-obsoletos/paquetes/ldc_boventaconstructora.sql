   create or replace PACKAGE ldc_boVentaConstructora IS

    -- Author  : LUDYCOM BD
    -- Created : 01/06/2016 8:45:42
    -- Purpose : Manejo del pago de proyectos de constructoras

    csbAreaCartera         CONSTANT VARCHAR2(20) := 'CARTERA';
    csbAreaTesoreria       CONSTANT VARCHAR2(20) := 'TESORERIA';
    csbAreaSAC             CONSTANT VARCHAR2(20) := 'ATEN_CLIENTE';
    csbChequeRegistrado    CONSTANT ldc_cheques_proyecto.estado%TYPE := 'R'; -- Registrado
    csbCuotaRegistrada     CONSTANT ldc_cuotas_proyecto.estado%TYPE := 'R';
    csbCuotaExtraordinaria CONSTANT ldc_cuotas_adicionales.tipo_cuota%TYPE := 'E';


	nuCreaPagoVenta       NUMBER;

   --inicio caso 200-2022
  sbdtfecsol           varchar2(100);
  nuId                 varchar2(100);
  nuOPERUNITID         varchar2(100);
  nuDOCUMENTTYPEID     varchar2(100);
  nuDOCUMENTKEY        varchar2(100);
  sbPROJECTID          varchar2(100);
  sbCOMMENT_           varchar2(2000); --Se cambia de 100 a 2000 || Ca 200-1283
  nuDIRECCION          varchar2(100);
  nuCategoria          varchar2(100);
  nuSubcategoria       varchar2(100);
  nuTIPOIDENTIFICACION varchar2(100);
  nuIDENTIFICATION     varchar2(100);
  sbSUBSCRIBER_NAME    varchar2(100);
  sbAPELLIDO           varchar2(100);
  nuCOMPANY            varchar2(100);
  sbTITLE              varchar2(100);
  sbmail               varchar2(100);
  nuPERSONQUANTITY     varchar2(100);
  nuOLDOPERATOR        varchar2(100);
  sbVENTAEMPAQUETADA   varchar2(100);
  sbTELEFONOSCONTACTO  varchar2(100);
  sbREFERENCIAS        varchar2(100);
  nuCOMMERCIALPLAN     varchar2(100);
  sbPROMOCIONES        varchar2(2000); --Se cambia de 1000 a 2000 || Ca 200-1283
  nuTOTALVALUE         varchar2(100);
  nuPLANFINANCIACION   varchar2(100);
  nuNUMEROCUOTAS       varchar2(100);
  nuCUOTAMENSUAL       varchar2(100);
  nuINITPAYMENT        varchar2(100);
  nuUSAGE              varchar2(100);
  sbINSTALLTYPE        varchar2(100);
  sbInit_Payment_Mode  varchar2(100);
  sbInit_Pay_Received  varchar2(100);
  ErrorXml             varchar2(12000); --Se agrega para registro de errores del xml || Ca 200-1283
  
  
  -----------------------200-2022
    ------------------------------------------------------------------------------------------------
    -- Cuotas mensuales
    ------------------------------------------------------------------------------------------------
    PROCEDURE proCreaCuotasMensuales(inuProyecto    ldc_cuotas_proyecto.id_proyecto%TYPE, -- Proyecto
                                     idtFechaCobro  ldc_cuotas_proyecto.fecha_cobro%TYPE, -- fecha pactada para cobro
                                     inuValor       ldc_cuotas_proyecto.valor%TYPE, --  valor de cuota
                                     idtFechaAlarma ldc_cuotas_proyecto.fecha_alarma%TYPE -- fecha de alarma
                                     );

    PROCEDURE proModificaCuotaMensual(inuProyecto             ldc_cuotas_proyecto.id_proyecto%TYPE, -- Proyecto
                                      inuCuota                ldc_cuotas_proyecto.consecutivo%TYPE, -- Cuota
                                      idtFechaCobroProgramada ldc_cuotas_proyecto.fecha_cobro%TYPE, -- Fecha programada
                                      inuValor                ldc_cuotas_proyecto.valor%TYPE, -- Valor
                                      idtFechaAlarma          ldc_cuotas_proyecto.fecha_alarma%TYPE, -- Fecha alarma
                                      isbOperacion            VARCHAR2 DEFAULT 'U' -- Indica si el registro se debe borrar
                                      );

    PROCEDURE proMarcaCuotaPagada(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE DEFAULT NULL -- Proyecto
                                  );

    PROCEDURE proGeneraCuponCuotaMensual(inuProyecto      ldc_cuotas_proyecto.id_proyecto%TYPE, -- Proyecto
                                         inuCuota         ldc_cuotas_proyecto.consecutivo%TYPE, -- Cuota
                                         isbPrograma      cupon.cupoprog%TYPE DEFAULT 'FAJU', -- Programa donde se genera el cupon
                                         onuCuponGenerado OUT ldc_cuotas_proyecto.cupon%TYPE);

    ------------------------------------------------------------------------------------------------
    -- Impresion de cupones
    ------------------------------------------------------------------------------------------------
    PROCEDURE proImprimeCupon(inuCupon IN cupon.cuponume%TYPE -- Cupon
                              );
    PROCEDURE proImprimeCupon;

    PROCEDURE proImprimeCuponM(inuCupon IN cupon.cuponume%TYPE, -- Cupon
	                           isbFecha  IN DATE,
                               inuProyecto IN NUMBER,
                                inuRuta     in varchar2);

    ------------------------------------------------------------------------------------------------
    -- Cheques
    ------------------------------------------------------------------------------------------------

    PROCEDURE proCreaCheques(inuProyecto        ldc_cheques_proyecto.id_proyecto%TYPE, -- Proyecto
                             isbNumeroCheque    ldc_cheques_proyecto.numero_cheque%TYPE, -- Cheque
                             inuEntidadBancaria ldc_cheques_proyecto.entidad%TYPE, -- Entidad bancaria
                             idtFecha           ldc_cheques_proyecto.fecha_cheque%TYPE, -- Fecha cheque
                             idtFechaAlarma     ldc_cheques_proyecto.fecha_cheque%TYPE DEFAULT trunc(SYSDATE), -- Fecha alarma
                             inuValor           ldc_cheques_proyecto.valor%TYPE, -- Valor
                             isbCuenta          ldc_cheques_proyecto.cuenta%TYPE);

    PROCEDURE proDevolverCheque(inuProyecto ldc_cheques_proyecto.id_proyecto%TYPE, -- Proyecto
                                inuCheque   ldc_cheques_proyecto.consecutivo%TYPE -- Cheque
                                );

    PROCEDURE proModificaCheque(inuCheque        ldc_cheques_proyecto.consecutivo%TYPE, -- Consecutivo del cheque
                                inuEntidad       ldc_cheques_proyecto.entidad%TYPE, -- Entidad
                                isbCuenta        ldc_cheques_proyecto.cuenta%TYPE, --Cuenta
                                isbNumero_Cheque ldc_cheques_proyecto.numero_cheque%TYPE, -- Numero de cheque
                                idtFecha         ldc_cheques_proyecto.fecha_cheque%TYPE, -- Fecha
                                idtFechaAlarma   ldc_cheques_proyecto.fecha_alarma%TYPE, -- Fecha alarma
                                inuValor         ldc_cheques_proyecto.valor%TYPE, -- Valor cheque
                                isbOperacion     VARCHAR2);

    PROCEDURE proCambiarCheque(inuProyecto        ldc_cheques_proyecto.id_proyecto%TYPE, -- Proyecto
                               isbNumeroCheque    ldc_cheques_proyecto.numero_cheque%TYPE, -- Cheque
                               inuEntidadBancaria ldc_cheques_proyecto.entidad%TYPE, -- Entidad bancaria
                               idtFecha           ldc_cheques_proyecto.fecha_cheque%TYPE, -- Fecha cheque
                               idtFechaAlarma     ldc_cheques_proyecto.fecha_cheque%TYPE DEFAULT trunc(SYSDATE), -- Fecha alarma
                               inuValor           ldc_cheques_proyecto.valor%TYPE, -- Valor
                               isbCuenta          ldc_cheques_proyecto.cuenta%TYPE,
                               inuChequeAnterior  ldc_cheques_proyecto.consecutivo%TYPE);

    PROCEDURE proGeneraCuponCuotaCheque(inuProyecto      ldc_cheques_proyecto.id_proyecto%TYPE, -- Proyecto
                                        inuCheque        ldc_cheques_proyecto.consecutivo%TYPE, -- Cuota
                                        isbPrograma      cupon.cupoprog%TYPE, -- Programa
                                        onuCuponGenerado OUT ldc_cheques_proyecto.cupon%TYPE -- Cupon
                                        );

    PROCEDURE proLiberarCheque(inuProyecto ldc_cheques_proyecto.id_proyecto%TYPE, -- Proyecto
                               inuCheque   ldc_cheques_proyecto.consecutivo%TYPE -- Cheque a liberar
                               );

    ------------------------------------------------------------------------------------------------
    -- Procesos transversales
    ------------------------------------------------------------------------------------------------
    PROCEDURE proRegistraNotaCredito(inuProducto          IN servsusc.sesunuse%type,
                                     inuContrato          IN servsusc.sesususc%type,
                                     inuCuencobr          IN cuencobr.cucocodi%type,
                                     inuConcepto          IN concepto.conccodi%type,
                                     inuCausa             IN causcarg.cacacodi%TYPE,
                                     isbDescripcion       IN VARCHAR2,
                                     inuValue             IN diferido.difesape%type);

    PROCEDURE proRegistraNotaDebito(inuProducto          IN servsusc.sesunuse%type,
                                    inuContrato          IN servsusc.sesususc%type,
                                    inuCuencobr          IN cuencobr.cucocodi%type,
                                    inuConcepto          IN concepto.conccodi%type,
                                    inuCausa             IN causcarg.cacacodi%TYPE,
                                    isbDescription       IN VARCHAR2,
                                    inuValue             IN diferido.difesape%type);

    PROCEDURE proCreaCuentaCobro(inuProducto          IN servsusc.sesunuse%type,
                                 inuContrato          IN servsusc.sesususc%type,
                                 onuCuenta            OUT cuencobr.cucocodi%type,
                                 onuFactura           OUT factura.factcodi%type);

    PROCEDURE proTrasladaDifACorriente(inuDifecodi  IN diferido.difecodi%TYPE);
    ------------------------------------------------------------------------------------------------
    -- Recordatorios
    ------------------------------------------------------------------------------------------------
    PROCEDURE proRecordatoriosCheques;

    PROCEDURE proRecordatoriosCuotas;

    PROCEDURE proRecordatoriosContPagare;

    PROCEDURE proRecordatorios;

    PROCEDURE proRecordatorioFPCubrSaldoProy;

    PROCEDURE proEnviaCorreo(isbPara    VARCHAR2, -- Para quien va dirigido el correo
                             isbCC      VARCHAR2 DEFAULT NULL, --Copia del correo
                             isbAsunto  VARCHAR2, -- Asunto del correo
                             iclMensaje CLOB -- Mensaje
                             );

    ------------------------------------------------------------------------------------------------
    -- Equivalencia
    ------------------------------------------------------------------------------------------------

    PROCEDURE proCreaEquivalencia(inuDireccion           ab_address.address_id%TYPE, -- Direccion en OSF
                                  inuUnidPredialCotizada ldc_unidad_predial.id_unidad_predial_unico%TYPE, -- Unidad predial cotizada
                                  inuSolicitudVenta      mo_packages.package_id%TYPE -- Solicitud de venta
                                  );

    ------------------------------------------------------------------------------------------------
    -- Cuotas adicionales
    ------------------------------------------------------------------------------------------------
    PROCEDURE proRegistraCuotaAdicional(inuProyecto   ldc_cuotas_adicionales.id_proyecto%TYPE, -- Proyecto
                                        inuValorCupon ldc_cuotas_adicionales.valor%TYPE, -- Valor cupon
                                        isbTipoCuota  ldc_cuotas_adicionales.tipo_cuota%TYPE, -- Tipo de cuota
                                        onuCuota      OUT ldc_cuotas_adicionales.consecutivo%TYPE, -- Cuota
                                        onuCupon      OUT ldc_cuotas_adicionales.cupon%TYPE -- Cupon
                                        );

    PROCEDURE procargadatosLDCAPS(inuproyecto ldc_proyecto_constructora.id_proyecto%TYPE);

    ------------------------------------------------------------------------------------------------
    -- Actas
    ------------------------------------------------------------------------------------------------

    PROCEDURE proCreaDetalleActa(inuProyecto   ldc_actas_proyecto.id_proyecto%TYPE, -- Proyecto
                                 inuCuota      ldc_actas_proyecto.id_cuota%TYPE, -- Cuota
                                 inuTipoTrab   ldc_actas_proyecto.tipo_trabajo%TYPE, -- Tipo de trabajo
                                 inuValorUnit  ldc_actas_proyecto.valor_unit%TYPE, -- Valor unitario
                                 inuCantidad   ldc_actas_proyecto.cant_trabajo%TYPE, -- Cantidad
                                 inuValorTotal ldc_actas_proyecto.valor_total%TYPE -- Valor total
                                 );

    PROCEDURE proImprimeActa(inuProyecto ldc_cuotas_adicionales.id_proyecto%TYPE, -- Proyecto
                             inuCuota    ldc_cuotas_adicionales.consecutivo%TYPE, -- Cuota
                             isbRuta     VARCHAR2 -- Ruta en la que se almacenara el archivo PDF
                             );

    PROCEDURE proReImprimeActa;

     ------------------------------------------------------------------------------------------------
    -- Valor adicional
    ------------------------------------------------------------------------------------------------

    PROCEDURE proRegistraValorAdicional(inuProyecto       ldc_cuotas_adicionales.id_proyecto%TYPE, -- Proyecto
                                        inuValor          ldc_valor_adicional_proy.valor%TYPE, -- Valor adicional
                                        inuCosto          ldc_valor_adicional_proy.valor_costo%TYPE, --Valor Costo
                                        isbObservacion    ldc_valor_adicional_proy.observacion%TYPE, --Observacion
                                        isbConcepto       concepto.conccodi%type, --Concepto
                                        onuCupon    OUT   ldc_cuotas_adicionales.cupon%TYPE -- Cupon
                                        );

    ------------------------------------------------------------------------------------------------
    -- Subrogaciones
    ------------------------------------------------------------------------------------------------

    FUNCTION frfObtSubrogacionesPorAprobar RETURN constants_per.tyrefcursor;

    PROCEDURE proAprobarSubrogaciones(isbPk        IN VARCHAR2,
                                      inuCurrent   IN NUMBER,
                                      inuTotal     IN NUMBER,
                                      onuErrorCode OUT ge_error_log.message_id%TYPE,
                                      osbErrorMess OUT ge_error_log.description%TYPE);

    PROCEDURE ProActualizarYPagareContrato;

    PROCEDURE ProActualizarAnticipo;

    FUNCTION frfObtUnidsPredialesXProyecto RETURN constants_per.tyrefcursor;

    PROCEDURE proAnularUnidadesPrediales(isbPk        IN VARCHAR2,
                                         inuCurrent   IN NUMBER,
                                         inuTotal     IN NUMBER,
                                         onuErrorCode OUT ge_error_log.message_id%TYPE,
                                         osbErrorMess OUT ge_error_log.description%TYPE);

    PROCEDURE proObtCorreoPrinYCopia(isbCadenaCorreos IN ld_parameter.value_chain%TYPE,
                                     osbCorreoPpal    OUT VARCHAR2,
                                     osbCorreosSec    OUT VARCHAR2);

    ------------------------------------------------------------------------------------------------
    -- Calcula Iva
    ------------------------------------------------------------------------------------------------
    FUNCTION funCalculaIva(isbConcepto       concepto.conccodi%type) RETURN number;

    PROCEDURE LDCRVEEM;

    PROCEDURE GenerateventforLDCRVEEM(onupack         out mo_packages.package_id%type,
                      onuErrorCode    out number,
                      osbErrorMessage out varchar2);


    PROCEDURE 	PRGENERAVENTPLES(inuSolicitud IN mo_packages.package_id%TYPE);
     /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: PRGENERAVENTPLES
        Descripcion:        genera ventas de gas por formulario

        Autor    : Josh Brito
        Fecha    : 26/04/2019

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        20/04/2019  Jbrito          Creacion
        ******************************************************************/

    PROCEDURE PRGENEPAGOVENTCONESP(inuSolicitud IN mo_packages.package_id%type);
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: PRGENEPAGOVENTCONESP
        Descripcion:        proceso que se encarga de registrar los pagos

        Autor    : Josh Brito
        Fecha    : 26/04/2019

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        20/04/2019  Jbrito          Creacion
        ******************************************************************/

      PROCEDURE PRANULAPAGOVENTCONESP(inuSolicitud IN mo_packages.package_id%type);
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: PRANULAPAGOVENTCONESP
        Descripcion:        proceso que se encarga de anular pago a constructora

        Autor    : Josh Brito
        Fecha    : 26/04/2019

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        20/04/2019  Jbrito          Creacion
        ******************************************************************/
	FUNCTION fnuGetUnidDisp (inuPerson IN NUMBER, inuProyecto IN NUMBER) RETURN NUMBER;
	/*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: fnuGetUnidDisp
        Descripcion:        Obtiene unidad disponible segun la direccion

        Autor    : Luis Javier Lopez
        Fecha    : 10/03/2020

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        ******************************************************************/

END ldc_boVentaConstructora;
/
create or replace PACKAGE BODY ldc_boVentaConstructora IS

        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: ldc_boVentaConstructora
        Descripcion:        Paquete usado desde la funcionalidades de ventas constructora

        Autor    : Sandra Mu?oz
        Fecha    : 02-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        02-06-2016   Sandra Mu?oz           Creacion
		09/11/2023	 Jsoto					OSF-1787 Se realizan ajustes de llamado a objetos de producto de Open
											por objetos personalizados, manejo de errores y trazas personalizadas
											se cambia select into por cursores entre otros mencionados en el caso.
        ******************************************************************/



    ------------------------------------------------------------------------------------------------
    -- Datos de paquete
    ------------------------------------------------------------------------------------------------
    csbPaquete             CONSTANT VARCHAR2(30) := 'ldc_boVentaConstructora.';
	cnuNVLTRC 			   CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
	csbInicio   		   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
    csbCuotaFacturada      CONSTANT ldc_cuotas_proyecto.estado%TYPE := 'F';
    csbCuotaPagada         CONSTANT ldc_cuotas_proyecto.estado%TYPE := 'P';
    csbOperacionUpdate     VARCHAR2(1) := 'U';
    CsbTipoCupon           CONSTANT cupon.cupotipo%TYPE := 'AF'; -- Tipo de cupon para cuotas
    CnuSesion              CONSTANT NUMBER := userenv('sessionid');
    csbChequeConsignado    CONSTANT ldc_cheques_proyecto.estado%TYPE := 'C'; -- Consignado
    csbChequeDEvuelto      CONSTANT ldc_cheques_proyecto.estado%TYPE := 'D'; -- Devuelto
    csbChequeAnulado       CONSTANT ldc_cheques_proyecto.estado%TYPE := 'A'; -- Anulado
    csbChequeEliminado     CONSTANT ldc_cheques_proyecto.estado%TYPE := 'E'; -- Eliminado
    csbChequeLiberado      CONSTANT ldc_cheques_proyecto.estado%TYPE := 'L'; -- Liberado
    csbCotizAprobada       CONSTANT VARCHAR2(1) := 'A';
    csbCotizPreaprobada    CONSTANT VARCHAR2(1) := 'P';
    csbCotizAnulada        CONSTANT VARCHAR2(1) := 'N';
    csbProgAnulaPagos      CONSTANT procesos.proccodi%TYPE := 'FGCHC'; --'FANP'; -- Programa que anula los pagos
    csbProgramaAplicaPagos CONSTANT VARCHAR2(10) := 'FGCHC';
    cnuProductoGas         CONSTANT NUMBER := dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS',0);
    cnuProductoGenerico    CONSTANT NUMBER := dald_parameter.fnuGetNumeric_Value('COD_PRO_GEN',0);
    cnuNULL_ATTRIBUTE      CONSTANT NUMBER := 2126;
    gnuProyecto            ldc_proyecto_constructora.id_proyecto%TYPE;
    gnuSuscripcion         ldc_proyecto_constructora.suscripcion%TYPE;
    gnuProducto            pr_product.product_id%TYPE;
    gnuSaldo               NUMBER := 0;
    gnuValorTotal          NUMBER := 0;
    gnuFinanciacion        diferido.difecofi%TYPE;
    gnuCausaNota           NUMBER:= DALD_PARAMETER.fnuGetNumeric_Value('CAUSAL_NOTA_ANUL_UNIDAD',0);
    gnuCausNotaDebito      NUMBER:= DALD_PARAMETER.fnuGetNumeric_Value('CAUS_NOTA_DEB_ADIC',0);
    gnuTipoTrabInterna     NUMBER:= DALD_PARAMETER.fnuGetNumeric_Value('TIPO_TRAB_RED_INTERNA',0);
    gnuMetodCalculo        NUMBER:= DALD_PARAMETER.fnuGetNumeric_Value('METCAL_VAL_ADIC_CONST',0);
    gnuPlanDife            NUMBER:= DALD_PARAMETER.fnuGetNumeric_Value('PLAN_FINAN_DIF_VALADIC',0);
    cnuIdEmpresa           CONSTANT NUMBER:=99;
	
	  

   sbPath varchar2(500);
   sbFile varchar2(500);
   sbPROYECTO        ge_boInstanceControl.stysbValue;
    sbErrMsg varchar2(2000); -- Mensajes de Error
    sbForma VARCHAR2(40);
    ------------------------------------------------------------------------------------------------
    -- Errores
    ------------------------------------------------------------------------------------------------
    cnuDescripcionError NUMBER := 2741; -- Descripcion del error

    CURSOR cuDepartamentos IS
     SELECT geograp_location_id
       FROM ge_geogra_location
      WHERE geog_loca_area_type =
            dald_parameter.fnuGetNumeric_Value('COD_TYPE_DEPARTMENT', 0);

    PROCEDURE proTrasladoDiferidoACorriente(inuFinanciacion diferido.difecofi%TYPE, -- Financiacion
                                            inuValor        NUMBER, -- Valor a trasladar a presente mes
                                            onuFactura      OUT factura.factcodi%TYPE, -- FActura generada
                                            onuCuenta       OUT cuencobr.cucocodi%TYPE --Cuenta
                                            ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proTrasladoDiferidoACorriente
        Descripcion:        Traslada al corriente parte de una financiacion

        Autor    : Sandra Mu?oz
        Fecha    : 02-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        02-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso       VARCHAR2(4000) := csbPaquete||'proTrasladoDiferidoACorriente';
        nuPaso          NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError         VARCHAR2(4000);
        nuProducto      diferido.difenuse%TYPE; --Producto
        sbDocumento     diferido.difenudo%TYPE; -- Documento
        dtFechaRegistro diferido.difefein%TYPE; -- Registro de la financiacion
        nuError         NUMBER; -- Variable de error
        TYPE TYTBCOUNTDEFS IS TABLE OF NUMBER INDEX BY VARCHAR2(20);
        TRCDIFERIDOS TYTBCOUNTDEFS;

        exError EXCEPTION; -- Error controlado

		CURSOR cuFinanciacion(nuFinanciacion diferido.difecofi%TYPE)IS
            SELECT d.difenuse,
                   d.difenudo,
                   MAX(trunc(d.difefein))
            FROM   diferido d
            WHERE  d.difecofi = nuFinanciacion
            GROUP  BY d.difenuse,
                      d.difenudo;

		
		CURSOR cuCuenta(nuFinanciacion diferido.difecofi%TYPE)IS
			SELECT MAX(cucocodi)
			  FROM cargos c, cuencobr cc, diferido d
			 WHERE c.cargcuco = cc.cucocodi
			   AND c.cargdoso = 'DF-' || d.difecodi
			   AND d.difecofi = nuFinanciacion
			   AND trunc(c.cargfecr) = trunc(sysdate);


    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        nuPaso := 10;
        TRCDIFERIDOS(inuFinanciacion) := 1;

        -- Obtener los datos de la financiacion
        nuPaso := 20;
        BEGIN

			IF cuFinanciacion%ISOPEN THEN
				CLOSE cuFinanciacion;
			END IF;
			
			OPEN cuFinanciacion(inuFinanciacion);
			FETCH cuFinanciacion INTO nuProducto,sbDocumento,dtFechaRegistro;
			IF cuFinanciacion%NOTFOUND THEN
				CLOSE cuFinanciacion;
				RAISE no_data_found;
			END IF;
			CLOSE cuFinanciacion;
			
        EXCEPTION
            WHEN no_data_found THEN
                sbError := 'No se encontraron diferidos para la financiacion ' || inuFinanciacion;
                RAISE pkg_error.controlled_error;
            WHEN too_many_rows THEN
                sbError := 'Se encontraron varios productos asociados a la finanaciacion ' ||
                           inuFinanciacion;
                RAISE pkg_error.controlled_error;
        END;

        nuPaso := 30;
        CC_BODEFTOCURTRANSFER.GLOBALINITIALIZE;

        nuPaso := 40;
        BEGIN
            CC_BODEFTOCURTRANSFER.ADDDEFERTOCOLLECTFIN(inuproductid    => nuProducto,
                                                       inufinancingid  => inuFinanciacion,
                                                       idtregisterdate => dtFechaRegistro,
                                                       isbdifenudo     => sbDocumento);
        EXCEPTION
            WHEN OTHERS THEN

                sbError := 'No fue posible identificar los diferidos de la financiacion ' ||
                           inuFinanciacion;

                pkg_traza.trace('Se presento un error al ejecutar el procedimiento
                CC_BODEFTOCURTRANSFER.ADDDEFERTOCOLLECTFIN (
                                                               inuproductid => ' ||
                               nuProducto || ',
                                                               inufinancingid => ' ||
                               inuFinanciacion || ',
                                                               idtregisterdate => ' ||
                               dtFechaRegistro || ',
                                                               isbdifenudo => ' ||
                               sbDocumento || '
                                                               );' ||
                               SQLERRM);
                RAISE pkg_error.controlled_error;
        END;

        nuPaso := 50;
        CC_BODEFTOCURTRANSFER.TRANSFERDEBT(
                                           inupayment      => inuValor,
                                           idtinsolv       => dtFechaRegistro,
                                           iblabono        => TRUE,
                                           isbprograma     => 'FTDU',
                                           onuerrorcode    => nuError,
                                           osberrormessage => sbError);

        IF (nuError != constants_per.OK) THEN

            RAISE pkg_error.controlled_error;

        END IF;

        nuPaso := 60;
        TRCDIFERIDOS.DELETE;

        -- Obtener el codigo de la factura generada

       nuPaso := 70;

			IF cuCuenta%ISOPEN THEN
				CLOSE cuCuenta;
			END IF;
			
			OPEN cuCuenta(inuFinanciacion);
			FETCH cuCuenta INTO onuCuenta;
			CLOSE cuCuenta;


        onuFactura := pktblcuencobr.fnugetcucofact(onuCuenta,0);

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			IF(sbError IS NOT NULL)THEN
             pkg_error.setErrorMessage(cnuDescripcionError,sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proRegistraPagoCheque(inuCuponGenerado IN ldc_cheques_proyecto.cupon%TYPE, -- Cupon a pagar
                                    orcCheque        OUT ldc_cheques_proyecto%ROWTYPE, -- Datos del cheque asociado
                                    onuCaja          OUT ca_cajero.cajecaac%TYPE -- Caja actual
                                    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proRegistraPagoCheque
        Descripcion:        Registro del pago asociado al cupon generado por la cuota de cheque

        Autor    : Sandra Mu?oz
        Fecha    : 31-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'proRegistraPagoCheque';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);

        nubanco       NUMBER(4);
        nusucursal    VARCHAR2(15);
        nuconcilia    NUMBER(6);
        nucuponpago   NUMBER(10);
        nuvlrpago     NUMBER;
        sbusuario     VARCHAR2(40);
        sbterminal    VARCHAR2(60);
        sbformpago    VARCHAR2(2);
        nususcrip     NUMBER(8);
        nucuponpagado NUMBER(10);
        nuerrorcode   NUMBER(18);
        dtpagofepa    DATE;
        rcCajero      ca_cajero%ROWTYPE;
        rcCaja        ca_caja%ROWTYPE;
        rcCupon       cupon%ROWTYPE;
        nuExiste      NUMBER; -- Indica que un elemento existe
		
		CURSOR cuCajero IS
          SELECT *
            INTO rcCajero
            FROM ca_cajero cc
           WHERE cc.cajeuser = pkg_bopersonal.fnuGetPersonaId;


		CURSOR cuCaja(nuCodCaja ca_caja.cajacodi%TYPE)IS
          SELECT *
            INTO rcCaja
            FROM ca_caja cc
           WHERE cc.cajacodi = nuCodCaja;
	

		CURSOR cuConciliacion(inuBanco 	concilia.concbanc%TYPE)IS
        SELECT MAX(c.conccons)
        FROM   concilia c
        WHERE  c.concbanc = inuBanco
        AND    c.concflpr = 'N';

		CURSOR cuCupon(inuCupon cupon.cuponume%TYPE)IS
        SELECT * 
		FROM cupon c 
		WHERE c.cuponume = inuCupon;


		CURSOR cuCheque(inuCupon cupon.cuponume%TYPE)IS
          SELECT *
            FROM ldc_cheques_proyecto lcp
           WHERE lcp.cupon = inuCupon;


		CURSOR cuFormaPago(isbformpago formpago.fopacodi%TYPE)IS
	        SELECT COUNT(1) 
			FROM formpago fp 
			WHERE fp.fopacodi = isbformpago;


    BEGIN
        BEGIN
			IF cuCajero%ISOPEN THEN
				CLOSE cuCajero;
			END IF;

			OPEN cuCajero;
			FETCH cuCajero INTO rcCajero;
			IF cuCajero%NOTFOUND THEN
				CLOSE cuCajero;
				RAISE no_data_found;
			END IF;
			CLOSE cuCajero;
			
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            sbError := 'El usuario conectado no esta configurado como cajero, por tanto no puede realizar la operacion';
            RAISE pkg_error.controlled_error;
          WHEN OTHERS THEN
            sbError := 'Se presento un error al intentar obtener el cajero del usuario conectado '||sqlerrm;
            RAISE pkg_error.controlled_error;
        END;

        BEGIN

			IF cuCaja%ISOPEN THEN
				CLOSE cuCaja;
			END IF;

			OPEN cuCaja(rcCajero.Cajecaac);
			FETCH cuCaja INTO rcCaja;
			IF cuCaja%NOTFOUND THEN
				CLOSE cuCaja;
				RAISE no_data_found;
			END IF;
			CLOSE cuCaja;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            sbError := 'El cajero '||rcCajero.Cajecaac||' no tiene caja asociada';
            RAISE pkg_error.controlled_error;
          WHEN OTHERS THEN
            sbError := 'Se presento un error al intentar obtener el cajero del usuario conectado '||sqlerrm;
            RAISE pkg_error.controlled_error;
        END;

        nubanco    := rcCaja.Cajabanc;
        nusucursal := rccaja.cajasuba;
        onuCaja    := rcCajero.Cajecaac;

 
			IF cuConciliacion%ISOPEN THEN
				CLOSE cuConciliacion;
			END IF;

			OPEN cuConciliacion(nubanco);
			FETCH cuConciliacion INTO nuconcilia;
			CLOSE cuConciliacion;


        IF(nuconcilia IS NULL)THEN
          sbError := 'No existe una conciliacion abierta para el banco '||nubanco||'-'||pktblbanco.fsbgetbancnomb(nubanco,0);
          RAISE pkg_error.controlled_error;
        END IF;

        nucuponpago := inuCuponGenerado;

			IF cuCupon%ISOPEN THEN
				CLOSE cuCupon;
			END IF;

			OPEN cuCupon(nucuponpago);
			FETCH cuCupon INTO rcCupon;
			CLOSE cuCupon;



        nuvlrpago  := rcCupon.Cupovalo;
        sbusuario  := USER;
        sbterminal := SYS_CONTEXT('USERENV', 'TERMINAL');

        dtpagofepa := SYSDATE;

        BEGIN
			IF cuCheque%ISOPEN THEN
				CLOSE cuCheque;
			END IF;

			OPEN cuCheque(nucuponpago);
			FETCH cuCheque INTO orcCheque;
			IF cuCheque%NOTFOUND THEN
				CLOSE cuCheque;
				RAISE no_data_found;
			END IF;
			CLOSE cuCheque;
		
		EXCEPTION
          WHEN NO_DATA_FOUND THEN
            sbError := 'No se encontro un cheque asociado al cupon '||nucuponpago;
            RAISE pkg_error.controlled_error;
          WHEN OTHERS THEN
            sbError := 'Se presento un error al intentar obtener el cajero del usuario conectado '||sqlerrm;
            RAISE pkg_error.controlled_error;
        END;

        -- Forma de pago
        nuPaso := 130;
        BEGIN
            sbformpago := dald_parameter.fsbGetValue_Chain(inuparameter_id => 'CHEQUE_CONSTRUCTORA');
        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible obtener el parametro CHEQUE_CONSTRUCTORA.' || SQLERRM;
                RAISE pkg_error.controlled_error;
        END;

        nuPaso := 140;
        IF sbformpago IS NULL THEN
            sbError := 'No se ha definido valor para el parametro CHEQUE_CONSTRUCTORA';
            RAISE pkg_error.controlled_error;
        END IF;

        nuPaso := 150;

			IF cuFormaPago%ISOPEN THEN
				CLOSE cuFormaPago;
			END IF;

			OPEN cuFormaPago(sbformpago);
			FETCH cuFormaPago INTO nuExiste;
			CLOSE cuFormaPago;

        nuPaso := 160;
        IF nuExiste = 0 THEN
            sbError := 'No se encontro una forma de pago con codigo ' || sbformpago;
            RAISE pkg_error.controlled_error;
        END IF;

        -- Aplica pagos
        pkcollecting.register(inubanco        => nubanco,
                              inusucursal     => nusucursal,
                              inuconcilia     => nuconcilia,
                              inucuponpago    => nucuponpago,
                              inuvlrpago      => nuvlrpago,
                              isbusuario      => sbusuario,
                              isbterminal     => sbterminal,
                              isbprograma     => csbProgramaAplicaPagos,
                              isbformpago     => sbformpago,
                              onususcrip      => nususcrip,
                              onucuponpagado  => nucuponpagado,
                              onuerrorcode    => nuerrorcode,
                              osberrormessage => sbError,
                              idtpagofepa     => dtpagofepa,
                              isbentidopa     => orcCheque.Entidad,
                              isbdepadocu     => orcCheque.Numero_Cheque,
                              isbdepanucu     => orcCheque.Cuenta);

        pkg_traza.trace('sbError ' || sbError,cnuNVLTRC);

        IF (nuErrorCode <> constants_per.OK) THEN
            sbError := 'Error al registrar el pago del cupon. ' || sbError;
            RAISE pkg_error.controlled_error;
        END IF;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
             pkg_error.setErrorMessage(cnuDescripcionError,sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proRegistraInfoCheque(ircCheque IN ldc_cheques_proyecto%ROWTYPE, -- Informacion cheque
                                    inuCaja   IN ca_cajero.cajecaac%TYPE -- Caja actual
                                    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proRegistraInfoCheque
        Descripcion:        Registro del pago asociado al cupon generado por la cuota de cheque

        Autor    : Sandra Mu?oz
        Fecha    : 31-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/
        nuMvtoCaja       ca_movimien.movicons%TYPE;
        nuClaseDocCheque ld_parameter.numeric_value%TYPE;
        nuTipoCheque     ld_parameter.numeric_value%TYPE;
        nuExiste         NUMBER;
        nuDocumentoCaja  ca_docucaje.docadocu%TYPE;

        sbProceso VARCHAR2(4000) := csbPaquete||'proRegistraInfoCheque';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);

		CURSOR cuDocuCaja(nuCaja ca_docucaje.docacaja%TYPE)IS
        SELECT MAX(ddc.docadocu)
          FROM ca_docucaje ddc
         WHERE ddc.docacaja = nuCaja;

		CURSOR cuMoviCaja(inuDocumentoCaja ca_movimien.movidocu%TYPE)IS
        SELECT MAX(cm.movicons)
        FROM   ca_movimien cm
        WHERE  cm.movidocu = inuDocumentoCaja;

		CURSOR cuClaseDocCheque(inuClaseDocCheque clasdopa.cldpcodi%TYPE)IS
		SELECT COUNT(1) 
		FROM CLASDOPA cd 
		WHERE cd.cldpcodi = inuClaseDocCheque;

		CURSOR cuFormaPago(inuClaseDocCheque CA_CLDPFOPA.cdfpcldp%TYPE)IS
        SELECT COUNT(1) 
		FROM CA_CLDPFOPA cc 
		WHERE cc.cdfpcldp = inuClaseDocCheque;

		CURSOR cuTipoCheque(inuTipoCheque tipocheq.tichcodi%TYPE)IS
		SELECT COUNT(1) 
		FROM tipocheq tc 
		WHERE tc.tichcodi = InuTipoCheque;

    BEGIN
        -- Obtener el movimiento de caja generado
        nuPaso := 60;

			IF cuDocuCaja%ISOPEN THEN
				CLOSE cuDocuCaja;
			END IF;

			OPEN cuDocuCaja(inuCaja);
			FETCH cuDocuCaja INTO nuDocumentoCaja;
			CLOSE cuDocuCaja;

        IF(nuDocumentoCaja IS NULL)THEN
          sbError := 'No se encontro documento de caja para la caja '||inuCaja;
          RAISE pkg_error.controlled_error;
        END IF;

        BEGIN

			IF cuMoviCaja%ISOPEN THEN
				CLOSE cuMoviCaja;
			END IF;

			OPEN cuMoviCaja(nuDocumentoCaja);
			FETCH cuMoviCaja INTO nuMvtoCaja;
			IF cuMoviCaja%NOTFOUND THEN
				CLOSE cuMoviCaja;
				RAISE no_data_found;
			END IF;
			CLOSE cuMoviCaja;

        EXCEPTION
            WHEN no_data_found THEN
                sbError := 'No se encontro movimiento de caja para el cupon ' || ircCheque.Cupon;
                RAISE pkg_error.controlled_error;
                NULL;
            WHEN too_many_rows THEN
                sbError := 'Se encontraron varios movimientos de caja para el cupon ' ||
                           ircCheque.Cupon;
                RAISE pkg_error.controlled_error;
        END;

        IF(nuMvtoCaja IS NULL)THEN
           sbError := 'No se encontro movimiento de caja para el documento de caja ' ||nuDocumentoCaja;
           RAISE pkg_error.controlled_error;
        END IF;

        -- Obtener la clase de documento cheque
        nuPaso := 70;
        BEGIN
            nuClaseDocCheque := dald_parameter.fnuGetNumeric_Value(inuparameter_id => 'CLASE_DOC_CHEQUE');
        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible obtener el parametro CLASE_DOC_CHEQUE. ' || SQLERRM;
                RAISE pkg_error.controlled_error;
        END;

        nuPaso := 80;
        IF nuClaseDocCheque IS NULL THEN
            sbError := 'No se encontro valor para el parametro CLASE_DOC_CHEQUE';
            RAISE pkg_error.controlled_error;
        END IF;

        nuPaso := 90;
		
			IF cuClaseDocCheque%ISOPEN THEN
				CLOSE cuClaseDocCheque;
			END IF;

			OPEN cuClaseDocCheque(nuClaseDocCheque);
			FETCH cuClaseDocCheque INTO nuExiste;
			CLOSE cuClaseDocCheque;
		
        nuPaso := 100;
        IF nuExiste = 0 THEN
            sbError := 'No se encontro clase de documento con cheque ' || nuClaseDocCheque;
            RAISE pkg_error.controlled_error;
        END IF;

        nuPaso := 110;
		
			IF cuFormaPago%ISOPEN THEN
				CLOSE cuFormaPago;
			END IF;

			OPEN cuFormaPago(nuClaseDocCheque);
			FETCH cuFormaPago INTO nuExiste;
			CLOSE cuFormaPago;

        nuPaso := 120;
        IF nuExiste = 0 THEN
            sbError := 'No se encontro una forma de pago para la clase de documento ' ||
                       nuClaseDocCheque;
            RAISE pkg_error.controlled_error;
        END IF;

        -- Tipo de cheque
        nuPaso := 130;
        BEGIN
            nuTipoCheque := dald_parameter.fnuGetNumeric_Value(inuparameter_id => 'CHEQUE_CONSTRUCTORA');
        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible obtener el parametro CHEQUE_CONSTRUCTORA.' || SQLERRM;
                RAISE pkg_error.controlled_error;
        END;

        nuPaso := 140;
        IF nuTipoCheque IS NULL THEN
            sbError := 'No se ha definido valor para el parametro CHEQUE_CONSTRUCTORA';
            RAISE pkg_error.controlled_error;
        END IF;

        nuPaso := 150;

			IF cuTipoCheque%ISOPEN THEN
				CLOSE cuTipoCheque;
			END IF;

			OPEN cuTipoCheque(nuTipoCheque);
			FETCH cuTipoCheque INTO nuExiste;
			CLOSE cuTipoCheque;
		
		
        nuPaso := 160;
        IF nuExiste = 0 THEN
            sbError := 'No se encontro un tipo de cheque con codigo ' || nuTipoCheque;

            RAISE pkg_error.controlled_error;
        END IF;

        -- Registrar el cheque postfechado en la tabla OSF
        nuPaso := 170;

        BEGIN
            INSERT INTO ca_infoadfp
                (inafcons,
                 inafmovi,
                 inafdocu,
                 inafbanc,
                 inafcldp,
                 inafnuch,
                 inafcuen,
                 inaftich,
                 inaffech)
            VALUES
                (sq_ca_infoadfp_inafcons.nextval, --inafcons,consecutivo de la informacion adicional
                 nuMvtoCaja, --inafmovi,codigo del movimiento del documento en cajas
                 nuDocumentoCaja, -- inafdocu, documento de pago
                 ircCheque.Entidad, --inafbanc,entidad que expide documento
                 nuClaseDocCheque, --inafcldp,clase de documento de pago
                 ircCheque.Numero_Cheque, --inafnuch,numero de cheque
                 ircCheque.Cuenta, --inafcuen,cuenta relacionada al documento soporte
                 nuTipoCheque, --inaftich,tipo de cheque
                 ircCheque.Fecha_Cheque --inaffech,fecha asociada al documento soporte
                 );

        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible registrar el cheque  ' || ircCheque.Numero_Cheque ||
                           'al aplicar el pago. ' || SQLERRM;
                RAISE pkg_error.controlled_error;
        END;

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
             pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;
    END;

    PROCEDURE proPagoCupon(inuCuponGenerado IN ldc_cheques_proyecto.cupon%TYPE -- Cupon a pagar
                           ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proPagoCupon
        Descripcion:        Aplica el pago del cupon.

        Autor    : Sandra Mu?oz
        Fecha    : 09-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        09-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'proPagoCupon';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        rcCheque  ldc_cheques_proyecto%ROWTYPE; -- Cheques
        nuCaja    ca_cajero.cajecaac%TYPE; -- Cajero

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        nuPaso := 10;

        -- Registra pago
        proRegistraPagoCheque(inuCuponGenerado => inuCuponGenerado,
                              orcCheque        => rcCheque,
                              onuCaja          => nuCaja);

        -- Registra la informacion del cheque, imitando lo que se realiza por la forma FIACH
        proRegistraInfoCheque(ircCheque => rcCheque, inuCaja => nuCaja);

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proGeneraCupon(inuProyecto        IN ldc_cuotas_proyecto.id_proyecto%TYPE, -- Proyecto
                             inuValor           IN ldc_cuotas_proyecto.valor%TYPE, -- Valor de la cuota o el cheque
                             onuCuponGenerado   OUT cupon.cuponume%TYPE, -- Cupon generado
                             onuFacturaGenerada OUT factura.factcodi%TYPE -- Factura generada
                             ) IS

        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proGeneraCupon
        Descripcion:        Descarga del diferido el valor de la cuota o el cheque y genera cupon

        Autor    : Sandra Mu?oz
        Fecha    : 07-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        07-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso           VARCHAR2(4000) := csbPaquete||'proGeneraCupon';
        nuPaso              NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError             VARCHAR2(4000);
        nuFinanciacion      diferido.difecofi%TYPE;
        nuSaldoFinanciacion NUMBER;
        nuCuenta            cuencobr.cucocodi%TYPE;

    BEGIN

        -- Obtener la financiacion de la venta a constructora
        nuPaso := 10;
        ldc_bcVentaConstructora.proDeudaProyecto(inuProyecto     => inuProyecto,
                                                 onuDeuda        => nuSaldoFinanciacion,
                                                 onuFinanciacion => nuFinanciacion);

        nuPaso := 20;
        IF nuSaldoFinanciacion = 0 THEN
            sbError := 'El proyecto no tiene deuda.';
            RAISE pkg_error.controlled_error;
        END IF;

        nuPaso := 30;
        IF nuSaldoFinanciacion < inuValor THEN
            sbError := 'No es posible generar el cupon por valor de ' || inuValor ||
                       ' ya que este valor es mayor al saldo de la financiacion ' || nuFinanciacion ||
                       ' que es de $' || nuSaldoFinanciacion;
            RAISE pkg_error.controlled_error;
        END IF;

        -- Descarga el valor de la cuota a presente mes
        nuPaso := 40;
        proTrasladoDiferidoACorriente(inufinanciacion => nuFinanciacion,
                                      inuvalor        => inuValor,
                                      onuFactura      => onuFacturaGenerada,
                                      onuCuenta       => nuCuenta);

        -- Generar cupon
        nuPaso := 50;
        BEGIN
            pkCouponMgr.GenerateCouponService(isbTipo       => csbTipoCupon,
                                              isbDocumento  => onuFacturaGenerada,
                                              inuValor      => inuValor,
                                              inuCuponPadre => NULL,
                                              idtCupoFech   => NULL,
                                              onuCuponCurr  => onuCuponGenerado);

        EXCEPTION
            WHEN pkg_error.controlled_error THEN
              IF(sbError IS NOT NULL) THEN
                 pkg_error.setErrorMessage(cnuDescripcionError, sbError);
              END IF;
              RAISE pkg_error.controlled_error;
            WHEN OTHERS THEN
                sbError := 'No fue posible generar el cupon. ' || SQLERRM;
                pkg_traza.trace('        pkCouponMgr.GenerateCouponService(isbTipo       => ' ||
                               csbTipoCupon || ',
                                          isbDocumento  => ' ||
                               onuFacturaGenerada || ',
                                          inuValor      => ' ||
                               inuValor || ',
                                          inuCuponPadre => NULL,
                                          idtCupoFech   => NULL,
                                          onuCuponCurr  => ' ||
                               onuCuponGenerado || ') - ' || SQLERRM,cnuNVLTRC);
                 RAISE pkg_error.controlled_error;
        END;

        pkg_traza.trace('cupon ' || onuCuponGenerado,cnuNVLTRC);

        nuPaso := 60;
        IF onuCuponGenerado IS NULL THEN
            sbError := 'No se genero cupon para descargar el valor ' || inuValor || '. ' || SQLERRM;
            RAISE pkg_error.controlled_error;
        END IF;

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL) THEN
               pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proGeneraCuponCuotaMensual(inuProyecto      ldc_cuotas_proyecto.id_proyecto%TYPE, -- Proyecto
                                         inuCuota         ldc_cuotas_proyecto.consecutivo%TYPE, -- Cuota
                                         isbPrograma      cupon.cupoprog%TYPE DEFAULT 'FAJU', -- Programa donde se genera el cupon
                                         onuCuponGenerado OUT ldc_cuotas_proyecto.cupon%TYPE) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proGeneraCuponCuotaMensual
        Descripcion:        Traslada el valor de una cuota al corriente

        Autor    : Sandra Mu?oz
        Fecha    : 01-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        01-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso         VARCHAR2(4000) := csbPaquete||'proGeneraCuponCuotaMensual';
        nuPaso            NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError           VARCHAR2(4000);
        rcCuota           ldc_cuotas_proyecto%ROWTYPE; -- Datos de la cuota
        nuFacturaGenerada factura.factcodi%TYPE; -- Factura generada
        nuFactorRedondeo  NUMBER;
        nuValor           NUMBER :=0;

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);


        -- Setear el programa
        nuPaso := 10;
        pkErrors.setapplication(isbaplicacion => isbPrograma);

        -- Traer los datos de la cuota
        nuPaso := 20;
        ldc_bcVentaConstructora.proDatosCuotaMensual(inuproyecto => inuProyecto,
                                                     inucuota    => inuCuota,
                                                     orccuota    => rcCuota);

        FA_BOPoliticaRedondeo.ObtFactorRedondeo( null, nuFactorRedondeo, cnuIdEmpresa);

        nuValor := rcCuota.Valor;
        nuValor := round( nuValor, nuFactorRedondeo );
        -- Genera cupon
        nuPaso := 30;
        proGeneraCupon(inuProyecto        => inuProyecto,
                       inuValor           => nuValor,
                       onuCuponGenerado   => onuCuponGenerado,
                       onuFacturaGenerada => nuFacturaGenerada);

        -- Asociar el cupon a la cuota y cambiar su estado
        BEGIN
            nuPaso := 40;
            UPDATE ldc_cuotas_proyecto lcp
            SET    lcp.estado = csbCuotaFacturada,
                   lcp.cupon  = onuCuponGenerado
            WHERE  lcp.id_proyecto = inuProyecto
            AND    lcp.consecutivo = inuCuota;

            IF SQL%NOTFOUND THEN
                sbError := 'No se actualizo el estado ni el cupon para la cuota ' || inuProyecto;
                RAISE pkg_error.controlled_error;
            END IF;

        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible asignar el cupon ' || onuCuponGenerado ||
                           ' ni el estado ' || csbCuotaFacturada || ' a la cuota ' || inuCuota || '. ' ||
                           SQLERRM;
                RAISE pkg_error.controlled_error;
        END;

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proGeneraCuponCuotaCheque(inuProyecto      ldc_cheques_proyecto.id_proyecto%TYPE, -- Proyecto
                                        inuCheque        ldc_cheques_proyecto.consecutivo%TYPE, -- Cuota
                                        isbPrograma      cupon.cupoprog%TYPE, -- Programa
                                        onuCuponGenerado OUT ldc_cheques_proyecto.cupon%TYPE -- Cupon
                                        ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proGeneraCuponCuotaCheque
        Descripcion:        Traslada el valor de una cuota al corriente

        Autor    : Sandra Mu?oz
        Fecha    : 01-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        01-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'proGeneraCuponCuotaCheque';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        rcCheque  ldc_cheques_proyecto%ROWTYPE; -- Cheque
        exError EXCEPTION; -- Error controlado
        nuFacturaGenerada factura.factcodi%TYPE; -- Factura generada
        rcProyecto        ldc_proyecto_constructora%ROWTYPE; -- Datos del proyecto
        nuFactorRedondeo  NUMBER;
        nuValor           NUMBER :=0;

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Setear el programa
        nuPaso := 10;
        pkErrors.setapplication(isbaplicacion => isbPrograma);

        -- Traer los datos del cheque
        nuPaso := 20;
        ldc_bcVentaConstructora.proDatosCheque(inuCheque => inuCheque, orcCheque => rcCheque);

        -- Traer los datos del proyecto
        nuPaso := 30;
        ldc_bcproyectoconstructora.proDatosProyecto(inuproyecto => inuProyecto,
                                                    orcProyecto => rcProyecto,
                                                    osbError    => sbError);
        IF sbError IS NOT NULL THEN
            RAISE pkg_error.controlled_error;
        END IF;

        FA_BOPoliticaRedondeo.ObtFactorRedondeo( null, nuFactorRedondeo, cnuIdEmpresa);

        nuValor := rcCheque.Valor;
        nuValor := round( nuValor, nuFactorRedondeo );
        -- Genera cupon
        nuPaso := 40;
        proGeneraCupon(inuProyecto        => inuProyecto,
                       inuValor           => nuValor,
                       onuCuponGenerado   => onuCuponGenerado,
                       onuFacturaGenerada => nuFacturaGenerada);

        -- Asigna el cupon
        daldc_cheques_proyecto.updCUPON(inuconsecutivo => inuCheque, inucupon$ => onuCuponGenerado);

        -- Paga el cupon
        nuPaso := 50;
        proPagoCupon(inuCuponGenerado => onuCuponGenerado);

        -- Asociar el cupon a la cuota y cambiar su estado
        nuPaso := 60;
        BEGIN
            UPDATE Ldc_Cheques_Proyecto lcp
            SET    lcp.estado = csbChequeConsignado
            WHERE  lcp.id_proyecto = inuProyecto
            AND    lcp.consecutivo = inuCheque;

            IF SQL%NOTFOUND THEN
                sbError := 'No se actualizo el estado ni el estado para la cuota ' || inuProyecto;
                RAISE pkg_error.controlled_error;
            END IF;

        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible asignar el cupon ' || onuCuponGenerado ||
                           ' ni el estado ' || csbChequeConsignado || ' al cheque ' || inuCheque || '. ' ||
                           SQLERRM;
                RAISE pkg_error.controlled_error;
        END;

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proGeneraDatosCupon(onuError OUT NUMBER,
                                  osbError OUT VARCHAR2) IS

        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proGeneraDatosCupon
        Descripcion:        Genera la informacion para el cupon. Se toma como muestra el codigo
                            del procedimiento LDC_BOIMPFACTURACONSTRUCTORA.Generatebilldata

        Autor    : Sandra Mu?oz
        Fecha    : 03-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        03-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        CURSOR cuTemp_Clob(inusession NUMBER) IS
            SELECT l.package_id,
                   l.temp_clob_fact_id,
                   l.template_id,
                   l.docudocu,
                   l.sesion
            FROM   ld_temp_clob_fact l
            WHERE  l.sesion = inusession
            AND    l.package_id IS NOT NULL;

        nuParamConfexme ld_parameter.numeric_value%TYPE; -- Configuracion extraccion y mezcla
        nuConfexme      ed_confexme.coemcodi%TYPE; -- Codigo de extraccion y mezcla
        rcExtMixConf    ed_confexme%ROWTYPE; -- Datos de extraccion y mezcla
        nuFormatCode    ed_formato.formcodi%TYPE; -- Formato
        nuFactura       cuencobr.cucofact%TYPE; -- Factura asociada al cupon
        nubilldocument  ld_parameter.parameter_id%TYPE; -- Tipo de documento de la factura
        clfactclob      CLOB; -- Texto a imprimir
        rctempclob      Dald_Temp_Clob_Fact.styLD_temp_clob_fact; -- Datos a almacenar en la tabla temporal
        nuindex         NUMBER;
        sbProceso       VARCHAR2(4000) := csbPaquete||'proGeneraDatosCupon';
        nuPaso          NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error

    BEGIN

        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Obtiene el valor del parametro CONFEXME_FACTURA_CONSTRUCTORA*/ -- ld_parameter
        nuPaso          := 10;
        nuParamConfexme := dald_parameter.fnuGetNumeric_Value('CONFEXME_FACTURA_CONSTRUCTORA');

        FOR rcTemp_Clob IN cuTemp_Clob(cnuSesion) LOOP

            -- Obtener template
            nuPaso := 20;
            IF (rcExtMixConf.coempadi IS NULL) THEN

                nuPaso := 30;
                IF (nuParamConfexme IS NOT NULL) THEN

                    -- Asocia el confexme obtenido del parametro */ -- ed_confexme
                    nuPaso     := 40;
                    nuConfexme := nuParamConfexme;

                    -- Obtiene nombre de plantilla
                    nuPaso       := 50;
                    rcExtMixConf := pktblED_ConfExme.frcGetRecord(nuConfexme);

                    nuPaso                        := 60;
                    ld_bosubsidy.globalsbTemplate := rcExtMixConf.coempadi;

                    IF (rcExtMixConf.coempadi IS NULL) THEN
                        nuPaso   := 70;
                        onuError := Ld_Boconstans.cnuGeneric_Error;
                        nuPaso   := 80;
                        osbError := 'Error al buscar el template para realizar la mezcla a partir del identificador: ' ||
                                    nuConfexme || ', de la tabla ED_ConfExme';
                        GOTO error;

                    END IF;

                    --  Obtiene el ID del formato a partir del identificador  ed_confexme  ed_document
                    nuPaso       := 90;
                    nuFormatCode := pkBOInsertMgr.GetCodeFormato(rcExtMixConf.coempada);
                ELSE
                    onuError := Ld_Boconstans.cnuGeneric_Error;
                    osbError := 'Error al buscar el template para realizar la mezcla';
                    GOTO error;

                END IF;

            END IF;

            -- Obtener la factura asociada a la solicitud
            nuPaso    := 100;
            nuFactura := to_number(rcTemp_Clob.template_id);

            IF nuFactura IS NOT NULL THEN

                -- Obtener el tipo de documento de la factura
                nuPaso         := 110;
                nubilldocument := pktblfactura.fnuGetFACTCONS(nuFactura, NULL); -- factura

                IF daed_document.fblexist(nuFactura, nubilldocument) THEN
                    nuPaso := 120;
                    daed_document.delrecord(nuFactura, nubilldocument);
                END IF;

                --  Genera los datos de la factura
                nuPaso := 130;
                pkBOPrintingProcess.ProcessSaleBill(nuFormatCode,
                                                    nuFactura,
                                                    constants_per.CSBSI,
                                                    clfactclob); --out

                nuPaso     := 140;
                rctempclob := NULL;

                nuPaso  := 150;
                nuindex := LD_BOSequence.Fnuseqld_temp_clob_fact;

                --Insertar el clob en la entidad ld_temp_clob_fact
                nuPaso                       := 160;
                rctempclob.temp_clob_fact_id := rcTemp_Clob.temp_clob_fact_id;
                nuPaso                       := 170;
                rctempclob.sesion            := cnuSesion;
                nuPaso                       := 180;
                rctempclob.docudocu          := clfactclob;
                nuPaso                       := 190;
                rctempclob.template_id       := rcTemp_Clob.template_id;
                nuPaso                       := 200;
                rctempclob.package_id        := rcTemp_Clob.package_id;

                -- Insertar registro en entidad ld_temp_clob_fact
                nuPaso := 200;
                Dald_Temp_Clob_Fact.updRecord(rctempclob);
            ELSE
                onuError := ld_boconstans.cnuGeneric_Error;
                osbError := '[Error] no se ha obtenido una factura desde el Proceso de Batch';
                GOTO error;
            END IF;

            -- Fin obtener CLOB de la solicitud procesada
            <<error>>
            NULL;
        END LOOP;

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||osbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(osbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError,osbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proImprimeCupon(inuCupon IN cupon.cuponume%TYPE -- Cupon
                              ) IS

        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:  proImprimeCupon
        Descripcion:         Imprime el cupon a un PDF. Se toma como muestra el codigo de
                             LDC_BOIMPFACTURACONSTRUCTORA.Insertbillclob

        Autor    : Sandra Mu?oz
        Fecha    : 03-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        03-06-2016   Sandra Mu?oz           Creacion
        05-07-2016   KCienfuegos            Se modifica proceso de impresion.
        ******************************************************************/

        nuError            NUMBER;
        sbError            VARCHAR2(4000);
        nuFactura          factura.factcodi%TYPE; -- Factura generada
        nuPaso             NUMBER; -- Ultimo paso ejecutado antes del error
        sbProceso          VARCHAR2(4000) := csbPaquete||'proImprimeCupon';
        rcFactura          FACTURA%ROWTYPE;
        rcContrato         SUSCRIPC%ROWTYPE;
        nuConfexme         ed_confexme.coemcodi%TYPE;
        nuCodigoFormato    ED_FORMATO.FORMCODI%TYPE;
        rcConfexme         pktbled_confexme.cuEd_Confexme%rowtype;
        CLCLOBDATA CLOB;

		CURSOR cuFactura(nuCupon cupon.cuponume%TYPE)IS
		   SELECT c.cupodocu
            FROM cupon c
           WHERE c.cuponume = nuCupon;

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        nuPaso := 10;

        -- Verifica que el cupon exista.
        pktblCupon.acckey(inuCupon);

        -- Obtener la factura asociada al cupon
        BEGIN

			IF cuFactura%ISOPEN THEN
				CLOSE cuFactura;
			END IF;

			OPEN cuFactura(inuCupon);
			FETCH cuFactura INTO nuFactura;
			IF cuFactura%NOTFOUND THEN
				CLOSE cuFactura;
				RAISE no_data_found;
			END IF;
			CLOSE cuFactura;
			
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            sbError :='No se encontro cupon con codigo '||inuCupon;
            RAISE pkg_error.controlled_error;
        END;

        -- Se obtiene registro de factura
        rcFactura := pktblfactura.frcgetrecord( nuFactura );

        -- Se obtiene registro de contrato
        rcContrato := pktblsuscripc.frcgetrecord( rcFactura.factsusc );

        nuPaso     := 20;

        nuConfexme := dald_parameter.fnuGetNumeric_Value('CONFEXME_FACTURA_CONSTRUCTORA', 0);

        -- Obtiene el registro del tipo de formato de extraccion y mezcla
        pkBCED_Confexme.ObtieneRegistro
        (
            nuConfexme,
            rcConfexme
        );

        nuCodigoFormato :=  pkbced_formato.fnugetformcodibyiden(rcConfexme.coempada);

        pkbodataextractor.instancebaseentity(rcFactura.factcodi,'FACTURA', constants_per.GetTrue);

        nuPaso := 30;
        -- Ejecuta proceso de extraccion de datos para formato digital
        pkBODataExtractor.ExecuteRules( nuCodigoFormato, CLCLOBDATA );

        nuPaso := 40;
        -- Se genera el archivo
        pkBOPrintingProcess.Generateclob(Inubillingperiod => rcFactura.FACTPEFA,
                                         Inudocumentnumber => rcFactura.FACTCODI,
                                         Inudocumenttype => ge_boconstants.fnugetdoctypecons,
                                         Iclclob => CLCLOBDATA);

        nuPaso := 50;
        -- Se setea el archivo a imprimir
        pkboed_documentmem.Set_PrintDoc( clClobData );

        nuPaso := 60;
        -- Almacena en memoria la plantilla para extraccion y mezcla
        pkboed_documentmem.SetTemplate( rcConfexme.coempadi );

        nuPaso := 70;
        -- Se envia a imprimir en pantalla
        ge_boiopenexecutable.printpreviewerrule();

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCreaCuotasMensuales(inuProyecto    ldc_cuotas_proyecto.id_proyecto%TYPE, -- Proyecto
                                     idtFechaCobro  ldc_cuotas_proyecto.fecha_cobro%TYPE, -- fecha pactada para cobro
                                     inuValor       ldc_cuotas_proyecto.valor%TYPE, --  valor de cuota
                                     idtFechaAlarma ldc_cuotas_proyecto.fecha_alarma%TYPE -- fecha de alarma
                                     ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaCuotasMensuales
        Descripcion:        Registra cuotas

        Autor    : Sandra Mu?oz
        Fecha    : 01-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        01-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'proCreaCuotasMensuales';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        rcCuota   daldc_cuotas_proyecto.styLDC_CUOTAS_PROYECTO;

        exError EXCEPTION; -- Error controlado

		CURSOR cuCuotasProyecto(nuProyecto ldc_cuotas_proyecto.id_proyecto%TYPE)IS
        SELECT nvl(MAX(lcp.consecutivo), 0) + 1
        FROM   ldc_cuotas_proyecto lcp
        WHERE  lcp.id_proyecto = nuProyecto;


    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Construir el registro
        nuPaso := 10;

		IF cuCuotasProyecto%ISOPEN THEN
			CLOSE cuCuotasProyecto;
		END IF;

		OPEN cuCuotasProyecto(inuProyecto);
		FETCH cuCuotasProyecto INTO rcCuota.consecutivo;
		CLOSE cuCuotasProyecto;


        nuPaso                 := 20;
        rcCuota.id_proyecto    := inuProyecto;
        nuPaso                 := 30;
        rcCuota.fecha_cobro    := idtFechaCobro;
        nuPaso                 := 40;
        rcCuota.valor          := inuValor;
        nuPaso                 := 50;
        rcCuota.fecha_alarma   := idtFechaAlarma;
        nuPaso                 := 60;
        rcCuota.estado         := csbCuotaRegistrada; -- Registrada
        nuPaso                 := 70;
        rcCuota.fecha_registro := SYSDATE;
        nuPaso                 := 80;
        rcCuota.usua_registra  := USER;

        -- Grabar el registro
        nuPaso := 90;
        daldc_cuotas_proyecto.insRecord(ircldc_cuotas_proyecto => rcCuota);

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proModificaCuotaMensual(inuProyecto             ldc_cuotas_proyecto.id_proyecto%TYPE, -- Proyecto
                                      inuCuota                ldc_cuotas_proyecto.consecutivo%TYPE, -- Cuota
                                      idtFechaCobroProgramada ldc_cuotas_proyecto.fecha_cobro%TYPE, -- Fecha programada
                                      inuValor                ldc_cuotas_proyecto.valor%TYPE, -- Valor
                                      idtFechaAlarma          ldc_cuotas_proyecto.fecha_alarma%TYPE, -- Fecha alarma
                                      isbOperacion            VARCHAR2 DEFAULT 'U' -- Indica si el registro se debe borrar
                                      ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proModificaCuotaMensual
        Descripcion:        Modifica una cuota mensual

        Autor    : Sandra Mu?oz
        Fecha    : 01-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        01-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'proModificaCuotaMensual';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        rcCuota   ldc_cuotas_proyecto%ROWTYPE; -- Datos cuota mensual

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Obtiene la informacion de la cuota
        nuPaso := 10;
        Ldc_BcventaConstructora.proDatosCuotaMensual(inuproyecto => inuProyecto,
                                                     inucuota    => inuCuota,
                                                     orccuota    => rcCuota);

        -- Valida que la cuota este registada
        nuPaso := 20;
        IF rcCuota.Estado <> csbCuotaRegistrada THEN
            sbError := 'Solo se pueden hacer cambios sobre cuotas registradas.';
            RAISE pkg_error.controlled_error;
        END IF;

        nuPaso := 30;
        IF isbOperacion = csbOperacionUpdate THEN
            -- Realizar el cambio  de datos en el registro
            nuPaso := 40;
            UPDATE ldc_cuotas_proyecto lcp
            SET    lcp.fecha_cobro  = idtFechaCobroProgramada,
                   lcp.valor        = inuValor,
                   lcp.fecha_alarma = idtFechaAlarma
            WHERE  lcp.consecutivo = inuCuota
            AND    lcp.id_proyecto = inuProyecto;
        ELSE
            -- Borrar registro
            nuPaso := 50;
            DELETE ldc_cuotas_proyecto lcp
            WHERE  lcp.consecutivo = inuCuota
            AND    lcp.id_proyecto = inuProyecto;
        END IF;

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proMarcaCuotaPagada(inuProyecto ldc_proyecto_constructora.id_proyecto%TYPE DEFAULT NULL -- Proyecto
                                  ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:  proMarcaCuotaPagada
        Descripcion:         Marca una cuota como pagada al momento de la ejecucion del job de
                             recordatorios o al ingreso del PI

        Autor    : Sandra Mu?oz
        Fecha    : 28-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        28-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso   VARCHAR2(4000) := csbPaquete||'proMarcaCuotaPagada';
        nuPaso      NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError     VARCHAR2(4000);
        sbCuponPago cupon.cupoflpa%TYPE; -- Cupon pago ??

        CURSOR cuCuotas IS
            SELECT *
            FROM   ldc_cuotas_proyecto lcp
            WHERE  lcp.id_proyecto = inuProyecto
            AND    lcp.estado = csbCuotaFacturada
            AND    lcp.cupon IS NOT NULL;
			
		CURSOR cuFormaPago(inuCupon cupon.cuponume%TYPE)IS
            SELECT c.cupoflpa 
			FROM cupon c 
			WHERE c.cuponume = inuCupon;


    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Recorre todas las cuotas mensuales facturadas
        nuPaso := 10;
        FOR rgCuotas IN cuCuotas LOOP

            nuPaso := 20;
			
			IF cuFormaPago%ISOPEN THEN
				CLOSE cuFormaPago;
			END IF;

			OPEN cuFormaPago(rgCuotas.Cupon);
			FETCH cuFormaPago INTO sbCuponPago;
			CLOSE cuFormaPago;
			
            -- Si el cupon esta pago se marca la cuota como pagada
            nuPaso := 30;
            IF sbCuponPago = 'S' THEN
                nuPaso := 40;
                BEGIN
                    daldc_cuotas_proyecto.updESTADO(inuConsecutivo => rgCuotas.Consecutivo,
                                                    inuID_PROYECTO => inuProyecto,
                                                    isbEstado$     => csbCuotaPagada);
                EXCEPTION
                    WHEN OTHERS THEN
                        NULL;
                END;
            END IF;

        END LOOP;

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proEnviaCorreo(isbPara    VARCHAR2, -- Para quien va dirigido el correo
                             isbCC      VARCHAR2 DEFAULT NULL, --Copia del correo
                             isbAsunto  VARCHAR2, -- Asunto del correo
                             iclMensaje CLOB -- Mensaje
                             ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proEnviaCorreo
        Descripcion:        En via

        Autor    : Sandra Mu?oz
        Fecha    : 31-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'proEnviaCorreo';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        sbhost    VARCHAR2(50); --Servidor de correo de la Gasera
        sbfrom    VARCHAR2(50); --Correo de salida de la Gasera
        nuError   NUMBER;
		sbInstanciaBD  VARCHAR2(20);
		sbAsunto  VARCHAR2(4000);
		conn       utl_smtp.connection;

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Obtengo el servidor de correo
        nuPaso := 10;
        BEGIN
            nuPaso := 20;
            sbhost := dald_parameter.fsbgetvalue_chain('LDC_SMTP_HOST');
			sbInstanciaBD := ldc_boconsgenerales.fsbgetdatabasedesc();

			if (length(sbInstanciaBD) > 0) then
			  sbInstanciaBD := 'BD '||sbInstanciaBD||': ';
			end if;
			sbAsunto := sbInstanciaBD ||isbasunto;

            nuPaso := 30;
            IF sbhost IS NOT NULL THEN

                -- Obtengo el correo desde donde se va a enviar el mensaje [ Equivale a sbhost   := ge_boparameter.fsbget('HOST_MAIL');]
                nuPaso := 40;
                sbfrom := dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER');

                IF sbFrom IS NOT NULL THEN

                    -- Se pasan los parametros del correo a la funcion ut_mail.
                    nuPaso := 50;

					conn := LDC_Email.begin_mail(sbfrom, isbPara,sbAsunto,LDC_Email.MULTIPART_MIME_TYPE);

					-- Mensaje
					LDC_Email.write_boundary(conn, false);
					LDC_Email.write_mime_header(conn,'Content-Type','text/html; charset="iso-8859-1"' ||utl_tcp.CRLF);
					LDC_Email.write_text(conn,iclMensaje||unistr('\000D\000A')) ;
					-- Cierre
					LDC_Email.end_mail(conn);
                END IF;

            ELSE
                pkg_traza.trace('No se encontro el valor para el parametro LDC_SMTP_SENDER');

            END IF;

        EXCEPTION
            WHEN OTHERS THEN
                pkg_traza.trace('No se encontro el parametro LDC_SMTP_HOST');
        END;

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proRecordatoriosCuotas IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proRecordatoriosCuotas
        Descripcion:        Busca que cheques o cuotas deben ser recordadas de cobrar al funcionario
                            correspondiente

        Autor    : Sandra Mu?oz
        Fecha    : 02-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        02-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso    VARCHAR2(4000) := csbPaquete||'proRecordatoriosCuotas';
        nuPaso       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError      VARCHAR2(4000);
        sbEncabezado VARCHAR2(4000); -- TExto de correo
        sbSaludo     VARCHAR2(4000);
        clCuotas     CLOB;
        rcProyecto   ldc_proyecto_constructora%ROWTYPE; -- Datos proyecto
        nuExiste     NUMBER; -- Indica si un elemento existe
        sbAsunto     VARCHAR2(4000);
        clMensaje    CLOB;
        sbPara       VARCHAR2(4000);
        sbCC         VARCHAR2(10000);
        sbTo         VARCHAR2(10000);

        CURSOR cuCuotasMensuales(inuDepartamento ge_geogra_location.geograp_location_id%TYPE)  IS
            SELECT consecutivo,
                   p.id_proyecto,
                   fecha_cobro,
                   valor,
                   fecha_alarma,
                   estado,
                   cupon,
                   fecha_registro,
                   usua_registra
            FROM   ldc_cuotas_proyecto lcp, ldc_proyecto_constructora p
            WHERE  lcp.estado = csbCuotaRegistrada
            AND    trunc(lcp.fecha_alarma) = trunc(SYSDATE)
            AND    p.id_proyecto = lcp.id_proyecto
            AND    p.id_solicitud IS NOT NULL
            AND    pkg_bcdirecciones.fnuGetUbicaGeoPadre(p.id_localidad) = inuDepartamento
            ORDER  BY id_proyecto;

		CURSOR cuCuotasProyecto(inuDepartamento ge_geogra_location.geograp_location_id%TYPE)IS
			SELECT COUNT(1)
			FROM   ldc_cuotas_proyecto lcp, ldc_proyecto_constructora p
			WHERE  lcp.estado = csbCuotaRegistrada
			AND    trunc(lcp.fecha_alarma) = trunc(SYSDATE)
			AND    p.id_proyecto = lcp.id_proyecto
			AND    p.id_solicitud IS NOT NULL
			AND    pkg_bcdirecciones.fnuGetUbicaGeoPadre(p.id_localidad)= inuDepartamento;

		

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

     FOR i in cuDepartamentos LOOP
        -- Existen cuotas para recordar
        nuPaso := 10;

		IF cuCuotasProyecto%ISOPEN THEN
			CLOSE cuCuotasProyecto;
		END IF;

		OPEN cuCuotasProyecto(i.geograp_location_id);
		FETCH cuCuotasProyecto INTO nuExiste;
		CLOSE cuCuotasProyecto;
		
		
        nuPaso := 20;
        IF nuExiste > 0 THEN
            nuPaso   := 30;
            sbAsunto := 'OSF - Proyectos de constructora - Recordatorios de cuotas a cobrar';

            -- Crear la linea encabezado del correo
            nuPaso       := 40;
            sbSaludo     := '
Reciba un cordial saludo.

A continuacion se listan las cuotas mensuales a las que se les debe generar cupon:


';
            nuPaso       := 50;
            sbEncabezado := '
' || rpad('-', 100, '-') || '
' || rpad('PROYECTO', 60, ' ') || rpad('CUOTA', 20, ' ') ||
                            lpad('VALOR', 20, ' ') || '
' || rpad('-', 100, '-') || '
';

            -- Recordatorio de cuotas mensuales
            nuPaso := 60;
            FOR rgCuota IN cuCuotasMensuales(i.geograp_location_id) LOOP

                -- Datos del proyecto
                nuPaso := 70;
                ldc_bcproyectoconstructora.proDatosProyecto(inuproyecto => rgCuota.id_proyecto,
                                                            orcproyecto => rcProyecto,
                                                            osberror    => sbError);

                IF sbError IS NOT NULL THEN
                    nuPaso   := 80;
                    clCuotas := clCuotas || NULL;
                ELSE
                    -- Datos del proyecto
                    nuPaso   := 90;
                    clCuotas := rPAD(rcProyecto.Id_Proyecto || ' - ' || rcProyecto.Nombre, 60, ' ') ||
                                rpad(rgCuota.consecutivo, 20, ' ') || lpad(rgCuota.valor, 20, ' ');
                END IF;

            END LOOP;

        pkg_traza.trace(sbAsunto,cnuNVLTRC);
        pkg_traza.trace(sbSaludo || sbEncabezado || clCuotas,cnuNVLTRC);

        -- Obtiene el destinatario
        nuPaso := 100;
        BEGIN
            nuPaso := 110;
            sbPara := NULL;
            IF i.geograp_location_id = dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_ATLANTICO',0) THEN
              sbPara := dald_parameter.fsbgetvalue_chain('EMAIL_COBRO_CUOTAS_CONST_ATL');
            ELSIF (i.geograp_location_id =  dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_CESAR',0))THEN
              sbPara := dald_parameter.fsbgetvalue_chain('EMAIL_COBRO_CUOTAS_CONST_CES');
            ELSIF (i.geograp_location_id =  dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_MAGDALENA',0))THEN
              sbPara := dald_parameter.fsbgetvalue_chain('EMAIL_COBRO_CUOTAS_CONST_MAG');
            END IF;

            IF sbPara IS NOT NULL THEN
                proObtCorreoPrinYCopia(sbPara, sbTo, sbCC);
                -- Construye el mensaje
                nuPaso    := 120;
                clMensaje := sbSaludo || sbEncabezado || clCuotas;

                -- Envia el correo al interesado
                nuPaso := 130;
                proEnviaCorreo(isbPara => sbTo, isbCC => sbCC, isbAsunto => sbAsunto, iclMensaje => clMensaje);
            ELSE
                pkg_traza.trace('No se encontro un correo definido');
            END IF;

        EXCEPTION
            WHEN OTHERS THEN
                pkg_traza.trace('No se encontro el parametro para el envio de correo');
        END;

        END IF;

        END LOOP;

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);

    END;

    PROCEDURE proRecordatoriosCheques IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proRecordatoriosCheques
        Descripcion:        Buscar que cheques tienen fecha de consignacion el dia actual

        Autor    : Sandra Mu?oz
        Fecha    : 08-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        08-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso    VARCHAR2(4000) := csbPaquete||'proRecordatoriosCheques';
        nuPaso       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError      VARCHAR2(4000);
        sbEncabezado VARCHAR2(4000); -- TExto de correo
        sbSaludo     VARCHAR2(4000);
        clCheques    CLOB;
        rcProyecto   ldc_proyecto_constructora%ROWTYPE; -- Datos proyecto
        nuExiste     NUMBER; -- Indica si un elemento existe
        sbAsunto     VARCHAR2(4000);
        clMensaje    CLOB;
        sbPara       VARCHAR2(4000);
        sbCC         VARCHAR2(10000);
        sbTo         VARCHAR2(10000);

        CURSOR cuCheques  (inuDepartamento ge_geogra_location.geograp_location_id%TYPE) IS
            SELECT consecutivo,
                   p.id_proyecto,
                   numero_cheque,
                   entidad,
                   estado,
                   fecha_cheque,
                   fecha_alarma,
                   valor,
                   nuevo_cheque,
                   cupon,
                   usua_registra,
                   fecha_registro,
                   cuenta
            FROM   ldc_cheques_proyecto lcp, ldc_proyecto_constructora p
           WHERE   lcp.estado = csbChequeRegistrado
             AND   trunc(lcp.fecha_alarma) = trunc(SYSDATE)
             AND    p.id_proyecto = lcp.id_proyecto
             AND    pkg_bcdirecciones.fnuGetUbicaGeoPadre(p.id_localidad)= inuDepartamento
             AND    p.id_solicitud IS NOT NULL;


		CURSOR cuChequesConsig(nuDepartamento ge_geogra_location.geograp_location_id%TYPE)IS
			SELECT COUNT(1)
			FROM   ldc_cheques_proyecto lcp, ldc_proyecto_constructora p
			WHERE  lcp.estado = csbChequeRegistrado
			AND    trunc(lcp.fecha_alarma) = trunc(SYSDATE)
			AND    p.id_proyecto = lcp.id_proyecto
			AND    p.id_solicitud IS NOT NULL
			AND    pkg_bcdirecciones.fnuGetUbicaGeoPadre(p.id_localidad)= nuDepartamento;


        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

		FOR i in cuDepartamentos LOOP
        -- Existen cuotas para recordar
        nuPaso := 10;
			IF cuChequesConsig%ISOPEN THEN
				CLOSE cuChequesConsig;
			END IF;
			
			OPEN cuChequesConsig(i.geograp_location_id);
			FETCH cuChequesConsig INTO nuExiste;
			CLOSE cuChequesConsig;

			nuPaso := 20;
			IF nuExiste > 0 THEN

				sbAsunto := 'OSF - Proyectos de constructora - Recordatorios de cheques a consignar';

				-- Crear la linea encabezado del correo
				sbSaludo := '
	Reciba un cordial saludo.

	A continuacion se listan los cheques que deben ser enviados a consignar


	';

				nuPaso       := 30;
				sbEncabezado := '
	' || rpad('-', 100, '-') || '
	' || rpad('PROYECTO', 70, ' ') || rpad('CHEQUE', 30, ' ') || '
	' || rpad('-', 100, '-') || '
	';

				-- Recordatorio de cuotas mensuales
				nuPaso := 40;
				FOR rgCheque IN cuCheques(i.geograp_location_id) LOOP

					-- Datos del proyecto
					nuPaso := 50;
					ldc_bcproyectoconstructora.proDatosProyecto(inuproyecto => rgCheque.id_proyecto,
																orcproyecto => rcProyecto,
																osberror    => sbError);

					nuPaso := 60;
					IF sbError IS NOT NULL THEN
						nuPaso    := 70;
						clCheques := clCheques || NULL;
					ELSE
						-- Datos del proyecto
						nuPaso    := 80;
						clCheques := rPAD(rcProyecto.Id_Proyecto || ' - ' || rcProyecto.Nombre, 75, ' ') ||
									 rpad(rgCheque.numero_cheque, 25, ' ');
					END IF;

				END LOOP;

			  pkg_traza.trace(sbAsunto,cnuNVLTRC);
			  pkg_traza.trace(sbSaludo || sbEncabezado || clCheques,cnuNVLTRC);

			  -- Obtiene el destinatario
			  nuPaso := 90;
			  BEGIN
				  nuPaso := 100;
				  sbPara := NULL;
				  IF i.geograp_location_id = dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_ATLANTICO',0) THEN
					sbPara := dald_parameter.fsbgetvalue_chain('EMAIL_INGRESA_CHEQUES_CONS_ATL');
				  ELSIF (i.geograp_location_id =  dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_CESAR',0))THEN
					sbPara := dald_parameter.fsbgetvalue_chain('EMAIL_INGRESA_CHEQUES_CONS_CES');
				  ELSIF (i.geograp_location_id =  dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_MAGDALENA',0))THEN
					sbPara := dald_parameter.fsbgetvalue_chain('EMAIL_INGRESA_CHEQUES_CONS_MAG');
				  END IF;

				  nuPaso := 110;
				  IF sbPara IS NOT NULL THEN
					  proObtCorreoPrinYCopia(sbPara, sbTo, sbCC);
					  -- Construye el mensaje
					  nuPaso    := 120;
					  clMensaje := sbSaludo || sbEncabezado || clCheques;

					  -- Envia el correo al interesado
					  nuPaso := 130;
					  proEnviaCorreo(isbPara => sbTo, isbCC => sbCC, isbAsunto => sbAsunto, iclMensaje => clMensaje);
				  ELSE
					  nuPaso := 140;
					  pkg_traza.trace('No se encontro un correo definido');
				  END IF;

			  EXCEPTION
				  WHEN OTHERS THEN
					  pkg_traza.trace('No se encontro el parametro para envio de correo');
			  END;

			END IF;

      END LOOP;
        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);

    END;

    PROCEDURE proRecordatoriosContPagare IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proRecordatoriosContPagare
        Descripcion:        Pasados N dias desde el registro de la venta, si esta informacion no ha
                            sido registrada en sistema, se emitira una notificacion a la persona
                            encargada para recordarle el registro de estos datos.

        Autor    : Sandra Mu?oz
        Fecha    : 04-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        04-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso          VARCHAR2(4000) := csbPaquete||'proRecordatoriosContPagare';
        nuPaso             NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError            VARCHAR2(4000);
        sbEncabezado       VARCHAR2(4000); -- TExto de correo
        sbSaludo           VARCHAR2(4000);
        clDato             CLOB;
        sbDatoAPedir       VARCHAR2(4000);
        nuExiste           NUMBER; -- Indica si un elemento existe
        sbAsunto           VARCHAR2(4000);
        clMensaje          CLOB;
        sbPara             VARCHAR2(4000);
        nuDiasRecordatorio ld_parameter.numeric_value%TYPE; -- Dias transcurridos desde la venta para el recordatorio
        nuSolicitudVenta   mo_packages.package_id%TYPE; -- Codigo de la solicitud de venta del proyecto
        dtFechaVenta       mo_packages.request_date%TYPE; -- Fecha de la venta
        sbCC         VARCHAR2(10000);
        sbTo         VARCHAR2(10000);

        CURSOR cuProyecto (inuDepartamento ge_geogra_location.geograp_location_id%TYPE) IS
            SELECT lpp.id_proyecto,
                   lpp.nombre,
                   lpp.pagare,
                   lpp.contrato
            FROM   ldc_proyecto_constructora lpp
            WHERE  (lpp.pagare IS NULL AND lpp.contrato IS NULL)
              AND  pkg_bcdirecciones.fnuGetUbicaGeoPadre(lpp.id_localidad)= inuDepartamento
            ORDER  BY id_proyecto;
		
		CURSOR cuDatosProyecto(inuGeograp_location ge_geogra_location.geograp_location_id%TYPE)IS
			SELECT COUNT(1)
			FROM   ldc_proyecto_constructora lpp
			WHERE  lpp.pagare IS NULL
			AND    lpp.contrato IS NULL
			AND    lpp.id_solicitud IS NOT NULL
			AND    pkg_bcdirecciones.fnuGetUbicaGeoPadre(lpp.id_localidad)= inuGeograp_location;


        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

       FOR i in cuDepartamentos LOOP
        -- Existen contratos sin dato
        nuPaso := 10;
		
		IF cuDatosProyecto%ISOPEN THEN
			CLOSE cuDatosProyecto;
		END IF;
		
		OPEN cuDatosProyecto(i.geograp_location_id);
		FETCH cuDatosProyecto INTO nuExiste;
		CLOSE cuDatosProyecto;
		
		
        nuPaso := 20;
        IF nuExiste > 0 THEN

            -- Obtiene el numero de dias configurados para evaluar el pagare y contrato del proyecto
            nuPaso := 30;
            BEGIN
                nuPaso             := 40;
                nuDiasRecordatorio := dald_parameter.fnuGetNumeric_Value('DIAS_RECOR_CONTR_PAG_CONSTRUCT');

                nuPaso := 50;
                IF nuDiasRecordatorio IS NULL THEN
                    sbError := 'No se encontro un correo definido el DIAS_RECOR_CONTR_PAG_CONSTRUCT';
                    RAISE pkg_error.controlled_error;
                END IF;

            EXCEPTION
                WHEN OTHERS THEN
                    sbError := 'No se encontro el parametro DIAS_RECOR_CONTR_PAG_CONSTRUCT';
                    RAISE pkg_error.controlled_error;
            END;

            -- Recorrer  los proyectos sin informacion
            nuPaso := 60;
            FOR rgProyecto IN cuProyecto(i.geograp_location_id) LOOP

                -- Obtener la fecha de la venta
                nuPaso := 70;

                nuSolicitudVenta:= daldc_proyecto_constructora.fnuGetID_SOLICITUD(rgProyecto.Id_Proyecto,0);

                nuPaso := 80;
                IF (nuSolicitudVenta IS NOT NULL) THEN
                    dtFechaVenta := pkg_bcsolicitudes.fdtGetFechaRegistro(nuSolicitudVenta);

                    IF trunc(dtFechaVenta) + nuDiasRecordatorio <= trunc(SYSDATE) THEN
                        nuPaso := 90;
                        clDato := clDato ||
                                  rpad(rgProyecto.Id_Proyecto || ' - ' || rgProyecto.Nombre, 60, ' ');

                        nuPaso := 100;
                        IF rgProyecto.contrato IS NULL AND rgProyecto.Pagare IS NULL THEN
                            nuPaso       := 110;
                            sbDatoAPedir := 'Contrato y/o pagare';
                        END IF;

                        nuPaso := 150;
                        clDato := clDato || rpad(sbDatoAPedir, 40, ' ') ||CHR(10);

                    END IF;

               ELSE
                 continue;
               END IF;
            END LOOP;

        END IF;

        -- Si hay proyectos con venta asociada y la fecha ya sobre pasa le definido, debe enviarse correo
        nuPaso := 160;
        IF clDAto IS NOT NULL THEN
            nuPaso   := 170;
            sbAsunto := 'OSF - Proyectos de constructora - Recordatorios de ingreso de contrato y pagare';

            -- Crear la linea encabezado del correo
            sbSaludo     := '
Reciba un cordial saludo.

A continuacion se listan los proyectos a los que les falta ingresar el contrato y/o el pagare:


';
            nuPaso       := 180;
            sbEncabezado := '
' || rpad('-', 100, '-') || '
' || rpad('PROYECTO', 60, ' ') || rpad('FALTA INGRESAR', 40, ' ') || '
' || rpad('-', 100, '-') || '
';
          -- Obtiene el destinatario
          nuPaso := 190;
          BEGIN
              nuPaso := 200;
              sbPara := NULL;
              IF i.geograp_location_id = dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_ATLANTICO',0) THEN
                sbPara := dald_parameter.fsbgetvalue_chain('EMAIL_INGRESA_CONTR_Y_PAG_ATL');
              ELSIF (i.geograp_location_id =  dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_CESAR',0))THEN
                sbPara := dald_parameter.fsbgetvalue_chain('EMAIL_INGRESA_CONTR_Y_PAG_CES');
              ELSIF (i.geograp_location_id =  dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_MAGDALENA',0))THEN
                sbPara := dald_parameter.fsbgetvalue_chain('EMAIL_INGRESA_CONTR_Y_PAG_MAG');
              END IF;

              nuPaso := 210;
              IF sbPara IS NOT NULL THEN
                  proObtCorreoPrinYCopia(sbPara, sbTo, sbCC);
                  -- Construye el mensaje
                  nuPaso    := 230;
                  clMensaje := sbSaludo || sbEncabezado || clDato;

                  -- Envia el correo al interesado
                  nuPaso := 240;
                  proEnviaCorreo(isbPara => sbTo, isbCC => sbCC,isbAsunto => sbAsunto, iclMensaje => clMensaje);
              END IF;

          EXCEPTION
              WHEN OTHERS THEN
                  NULL;
          END;
        END IF;
        clDAto :=null;
       END LOOP;
        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);

    END;

    PROCEDURE proRecordatorioFPCubrSaldoProy IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proRecordatorioFPCubrSaldoProy
        Descripcion:        Envia recordatorio a las personas que estan encargadas de ajustar las formas
                            de pago para los proyectos para que cubran la deuda del cheque

        Autor    : Sandra Mu?oz
        Fecha    : 17-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        17-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso             VARCHAR2(4000) := csbPaquete||'proRecordatorioFPCubrSaldoProy';
        nuPaso                NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError               VARCHAR2(4000);
        nuDeudaProyecto       NUMBER; -- Deuda proyecto
        nuValorChequesXCobrar NUMBER; -- Cheques por cobrar
        nuValorCuotasXCobrar  NUMBER; -- Cuotas por cobrar
        nuValorXCobrar        NUMBER; -- Valor que falta por cobrar segun las formas de pago
        nuFinanciacion        NUMBER; -- Financiacion de la venta
        sbEncabezado          VARCHAR2(4000);
        clDato                CLOB; -- Proyectos a los que se les debe ajustarel valor de las forma de pago
        sbAsunto              VARCHAR2(4000); -- Asunto del correo
        sbSaludo              VARCHAR2(4000); -- Saludo del correo
        sbPara                ld_parameter.value_chain%TYPE; -- Persona a la que va dirigida el correo
        sbObservacion         VARCHAR2(4000); -- Observacion al usuario sobre cada inconsistencia encontrada
        clMensaje             CLOB; -- Cuerpo del correo
        sbCC         VARCHAR2(10000);
        sbTo         VARCHAR2(10000);

        CURSOR cuProyectos(inuDepartamento ge_geogra_location.geograp_location_id%TYPE) IS
            SELECT lpc.id_proyecto,
                   lpc.nombre
            FROM   ldc_proyecto_constructora lpc
            WHERE  lpc.id_solicitud IS NOT NULL
            AND    pkg_bcdirecciones.fnuGetUbicaGeoPadre(lpc.id_localidad)= inuDepartamento
            ORDER  BY lpc.id_proyecto;
		
		CURSOR cuPorCobrar(inuProyecto ldc_cheques_proyecto.id_proyecto%TYPE)IS
			SELECT nvl(SUM(lcp.valor), 0)
			FROM   ldc_cheques_proyecto lcp
			WHERE  lcp.estado = ldc_boventaconstructora.csbChequeRegistrado
			AND    lcp.id_proyecto = inuProyecto;


		CURSOR cuCuotasXCobrar(inuProyecto ldc_cuotas_proyecto.id_proyecto%TYPE)IS
			SELECT nvl(SUM(lcp.valor), 0)
			FROM   ldc_cuotas_proyecto lcp
			WHERE  lcp.estado = ldc_boventaconstructora.csbCuotaRegistrada
			AND    lcp.id_proyecto = inuProyecto;

		

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);
       FOR i in cuDepartamentos LOOP
        -- Recorrer todos los proyectos
        nuPaso := 10;
        FOR rgProyecto IN cuProyectos(i.geograp_location_id) LOOP

            -- Obtener la deuda del proyecto
            BEGIN
                nuPaso := 20;
                ldc_bcventaconstructora.proDeudaProyecto(inuProyecto     => rgProyecto.id_proyecto,
                                                         onuDeuda        => nuDeudaProyecto,
                                                         onuFinanciacion => nuFinanciacion);
            EXCEPTION
                WHEN OTHERS THEN
                    NULL;
            END;

            -- Si el proyecto tiene deuda
            nuPaso := 30;
            IF nuDeudaProyecto > 0 THEN

                -- Determinar el valor de los que faltan por cobrar
                nuPaso := 30;

                BEGIN
				
				IF cuPorCobrar%ISOPEN THEN
					CLOSE cuPorCobrar;
				END IF;
				
				OPEN cuPorCobrar(rgProyecto.Id_Proyecto);
				FETCH cuPorCobrar INTO nuValorChequesXCobrar;
				IF cuPorCobrar%NOTFOUND THEN
					CLOSE cuPorCobrar;
					RAISE NO_DATA_FOUND;
				END IF;
				CLOSE cuPorCobrar;

                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        sbError := 'No fue posible obtener el valor de los cheques a cobrar para el proyecto ' ||
                                   rgProyecto.Id_Proyecto || '. ' || SQLERRM;
                        RAISE pkg_error.controlled_error;
                    WHEN OTHERS THEN
                        sbError := '(Otros)No fue posible obtener el valor de los cheques a cobrar para el proyecto ' ||
                                   rgProyecto.Id_Proyecto || '. ' || SQLERRM;
                        RAISE pkg_error.controlled_error;
                END;

                -- Determinar el valor las cuotas que faltan por cobrar
                nuPaso := 40;
                BEGIN

				IF cuCuotasXCobrar%ISOPEN THEN
					CLOSE cuCuotasXCobrar;
				END IF;
				
				OPEN cuCuotasXCobrar(rgProyecto.Id_Proyecto);
				FETCH cuCuotasXCobrar INTO nuValorCuotasXCobrar;
				IF cuCuotasXCobrar%NOTFOUND THEN
					CLOSE cuCuotasXCobrar;
					RAISE NO_DATA_FOUND;
				END IF;
				CLOSE cuCuotasXCobrar;


                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        sbError := 'No fue posible obtener el valor de las cuotas a cobrar para el proyecto ' ||
                                   rgProyecto.Id_Proyecto || '. ' || SQLERRM;
                        RAISE pkg_error.controlled_error;
                    WHEN OTHERS THEN
                        sbError := '(Otros) No fue posible obtener el valor de las cuotas a cobrar para el proyecto ' ||
                                   rgProyecto.Id_Proyecto || '. ' || SQLERRM;
                        RAISE pkg_error.controlled_error;
                END;

                nuPaso         := 50;
                nuValorXCobrar := nuValorChequesXCobrar + nuValorCuotasXCobrar;

                -- Si la deuda no es compensada por las cuotas o cheques por cobrar, se agrega al mensaje a enviar
                nuPaso := 60;
                IF nuDeudaProyecto <> nuValorXCobrar THEN

                    nuPaso := 70;
                    IF nuDeudaProyecto < nuValorXCobrar THEN
                        nuPaso        := 80;
                        sbObservacion := 'Las cuotas/cheques que faltan por cobrar sobrepasan la deuda del proyecto';
                    ELSE
                        nuPaso        := 90;
                        sbObservacion := 'La deuda del proyecto no alcanza a ser cubierta por las cuotas/cheques que faltan por cobrar';
                    END IF;

                    nuPaso := 100;
                    clDato := clDato || '
' ||
                              rpad(rgProyecto.Id_Proyecto || ' - ' || rgProyecto.Nombre, 60, ' ') ||
                              rpad(nuValorChequesXCobrar, 20, ' ') ||
                              rpad(nuValorCuotasXCobrar, 20, ' ') || rpad(nuDeudaProyecto, 20, ' ') ||
                              sbObservacion;

                END IF;

            END IF;

        END LOOP;

        -- Si hay proyectos con venta asociada y la fecha ya sobre pasa le definido, debe enviarse correo
        nuPaso := 110;
        IF clDAto IS NOT NULL THEN

            nuPaso   := 120;
            sbAsunto := 'OSF - Proyectos de constructora - Inconsistencias entre la deuda del proyecto y las cuotas/cheques registrados';

            -- Crear la linea encabezado del correo
            nuPaso   := 130;
            sbSaludo := '
Reciba un cordial saludo.

A continuacion se listan los proyectos que tienen inconsistencias entre su saldo y las cuotas o cheques que cubren la deuda


';

            sbEncabezado := '
' || rpad('-', 180, '-') || '
' || rpad('PROYECTO', 60, ' ') || rpad('VALOR CUOTAS', 20, ' ') ||
                            rpad('VALOR CHEQUES', 20, ' ') || rpad('DEUDA', 20, ' ') ||
                            RPAD('OBSERVACION', 60, ' ') || '
' || rpad('-', 180, '-') || '
';


          -- Obtiene el destinatario
          nuPaso := 140;
          BEGIN
              nuPaso := 150;
              sbPara := NULL;
              IF i.geograp_location_id = dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_ATLANTICO',0) THEN
                sbPara := dald_parameter.fsbgetvalue_chain('EMAIL_AJUSTE_FORMAS_PAGO_ATL');
              ELSIF (i.geograp_location_id =  dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_CESAR',0))THEN
                sbPara := dald_parameter.fsbgetvalue_chain('EMAIL_AJUSTE_FORMAS_PAGO_CES');
              ELSIF (i.geograp_location_id =  dald_parameter.fnuGetNumeric_Value('DEPARTAMENTO_MAGDALENA',0))THEN
                sbPara := dald_parameter.fsbgetvalue_chain('EMAIL_AJUSTE_FORMAS_PAGO_MAG');
              END IF;

              IF sbPara IS NOT NULL THEN
                  proObtCorreoPrinYCopia(sbPara, sbTo, sbCC);
                  -- Construye el mensaje
                  nuPaso    := 160;
                  clMensaje := sbSaludo || sbEncabezado || clDato;

                  -- Envia el correo al interesado
                  nuPaso := 170;
                  proEnviaCorreo(isbPara => sbTo, isbCC => sbCC,isbAsunto => sbAsunto, iclMensaje => clMensaje);
              END IF;

          EXCEPTION
              WHEN OTHERS THEN
                  NULL;
          END;
        END IF;

        clDAto:=NULL;
       END LOOP;
        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);

    END;

    PROCEDURE proRecordatorios IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:  proRecordatorios
        Descripcion:

        Autor    : Sandra Mu?oz
        Fecha    : 31-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'proRecordatorios';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Recordatorios de cuotas mensuales
        proRecordatoriosCuotas;

        -- Recordatorio de consignacion de cheques
        proRecordatoriosCheques;

        -- Recordatorios de contrato y pagare
        proRecordatoriosContPagare;

        -- Recordatorio de inconsistencias entre las cuotas/cheques por cobrar y el saldo del diferido
        proRecordatorioFPCubrSaldoProy;

        -- Marca las cuotas como pagadas cuando se identifica que el cupon ya fue pagado
        proMarcaCuotaPagada;

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCreaEquivalencia(inuDireccion           ab_address.address_id%TYPE, -- Direccion en OSF
                                  inuUnidPredialCotizada ldc_unidad_predial.id_unidad_predial_unico%TYPE, -- Unidad predial cotizada
                                  inuSolicitudVenta      mo_packages.package_id%TYPE -- Solicitud de venta
                                  ) IS

        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:
        Descripcion:

        Autor    : Sandra Mu?oz
        Fecha    : 06-03-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        06-03-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso       VARCHAR2(4000) := csbPaquete||'proCreaEquivalencia';
        nuPaso          NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError         VARCHAR2(4000);
        rcEquival       daldc_equival_unid_pred.styLDC_EQUIVAL_UNID_PRED; -- Registro a insertar
        rcUnidadPredial ldc_unidad_predial%ROWTYPE; -- Datos unidad predial
        nuExiste        NUMBER; -- Indica si existe un elemento

		CURSOR cuUnidadPredial IS
			SELECT *
            FROM   ldc_unidad_predial lup
            WHERE  lup.id_unidad_predial_unico = inuUnidPredialCotizada;


		CURSOR cuSolicitud(nuSolicitudVenta mo_packages.package_id%TYPE)IS
			SELECT COUNT(1) 
			FROM mo_packages mp 
			WHERE mp.package_id = nuSolicitudVenta;

		
        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Obtener la informacion de la unidad predial
        nuPaso := 10;
        BEGIN
		
		IF cuUnidadPredial%ISOPEN THEN
			CLOSE cuUnidadPredial;
		END IF;
		
		OPEN cuUnidadPredial;
		FETCH cuUnidadPredial INTO rcUnidadPredial;
		IF cuUnidadPredial%NOTFOUND THEN
			CLOSE cuUnidadPredial;
			RAISE NO_DATA_FOUND;
		END IF;
		CLOSE cuUnidadPredial;
		
        EXCEPTION
            WHEN no_data_found THEN
                sbError := 'No se encontro una unidad predial con el codigo ' ||
                           inuUnidPredialCotizada;
                RAISE pkg_error.controlled_error;

        END;

        -- Verificar que exista la solicitud
        nuPaso := 15;
		
		IF cuSolicitud%ISOPEN THEN
			CLOSE cuSolicitud;
		END IF;
		
		OPEN cuSolicitud(inuSolicitudVenta);
		FETCH cuSolicitud INTO nuExiste;
		CLOSE cuSolicitud;


        IF nuExiste = 0 THEN
            sbError := 'No existe la solicitud ' || inuSolicitudVenta;
            RAISE pkg_error.controlled_error;
        END IF;

        -- Construir el registro
        nuPaso                            := 20;
        rcEquival.consecutivo             := seq_ldc_equival_unid_pred.nextval;
        nuPaso                            := 30;
        rcEquival.id_direccion            := inuDireccion;
        nuPaso                            := 40;
        rcEquival.id_unidad_predial       := rcUnidadPredial.Id_Unidad_Predial;
        nuPaso                            := 50;
        rcEquival.fecha_equiv             := SYSDATE;
        nuPaso                            := 60;
        rcEquival.id_proyecto             := rcUnidadPredial.Id_Proyecto;
        nuPaso                            := 70;
        rcEquival.id_torre                := rcUnidadPredial.Id_Torre;
        nuPaso                            := 80;
        rcEquival.id_piso                 := rcUnidadPredial.Id_Piso;
        nuPaso                            := 90;
        rcEquival.id_unidad_predial_unico := inuUnidPredialCotizada;
        nuPaso                            := 90;
        rcEquival.id_solicitud            := inuSolicitudVenta;
        nuPaso                            := 100;
        rcEquival.subrog_aprob            := 'N';
        nuPaso                            := 110;
        rcEquival.activa                  := 'S';

        -- Insertar el registro
        nuPaso := 120;
        BEGIN
            daldc_equival_unid_pred.insRecord(ircldc_equival_unid_pred => rcEquival);
        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible insertar el registro
             rcEquival.consecutivo                    ' ||
                           rcEquival.consecutivo || '
             rcEquival.id_direccion                    ' ||
                           rcEquival.id_direccion || '
             rcEquival.id_unidad_predial                ' ||
                           rcEquival.id_unidad_predial || '
             rcEquival.fecha_equiv                      ' ||
                           rcEquival.fecha_equiv || '
             rcEquival.id_proyecto                      ' ||
                           rcEquival.id_proyecto || '
             rcEquival.id_torre                         ' ||
                           rcEquival.id_torre || '
             rcEquival.id_piso                          ' ||
                           rcEquival.id_piso || '
             rcEquival.id_solicitud ' || rcEquival.id_solicitud ||
                           '
                            rcEquival.subrog_aprob' ||
                           rcEquival.subrog_aprob ||
                           '
             rcEquival.id_unidad_predial_unico          ' ||
                           rcEquival.id_unidad_predial_unico || '. ' || SQLERRM;

                RAISE pkg_error.controlled_error;
        END;

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
             pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCreaCheques(inuProyecto        ldc_cheques_proyecto.id_proyecto%TYPE, -- Proyecto
                             isbNumeroCheque    ldc_cheques_proyecto.numero_cheque%TYPE, -- Cheque
                             inuEntidadBancaria ldc_cheques_proyecto.entidad%TYPE, -- Entidad bancaria
                             idtFecha           ldc_cheques_proyecto.fecha_cheque%TYPE, -- Fecha cheque
                             idtFechaAlarma     ldc_cheques_proyecto.fecha_cheque%TYPE DEFAULT trunc(SYSDATE), -- Fecha alarma
                             inuValor           ldc_cheques_proyecto.valor%TYPE, -- Valor
                             isbCuenta          ldc_cheques_proyecto.cuenta%TYPE) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaCheques
        Descripcion:        Almacena los cheques

        Autor    : Sandra Mu?oz
        Fecha    : 07-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        07-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'proCreaCheques';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        rcCheque  daldc_cheques_proyecto.styLDC_CHEQUES_PROYECTO;

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Construir el registro
        nuPaso := 10;
        

        rcCheque.consecutivo    := seq_ldc_cheques_proyecto.nextval;
        nuPaso                  := 20;
        rcCheque.id_proyecto    := inuProyecto;
        nuPaso                  := 30;
        rcCheque.numero_cheque  := isbNumeroCheque;
        nuPaso                  := 40;
        rcCheque.entidad        := inuEntidadBancaria;
        nuPaso                  := 50;
        rcCheque.estado         := csbChequeRegistrado;
        nuPaso                  := 60;
        rcCheque.fecha_cheque   := idtFecha;
        nuPaso                  := 70;
        rcCheque.fecha_alarma   := idtFechaAlarma;
        nuPaso                  := 80;
        rcCheque.valor          := inuValor;
        nuPaso                  := 90;
        rcCheque.usua_registra  := USER;
        nuPaso                  := 100;
        rcCheque.fecha_registro := SYSDATE;
        nuPaso                  := 110;
        rcCheque.cuenta         := isbCuenta;

        -- Almacena la informacion
        nuPaso := 120;
        daldc_cheques_proyecto.insRecord(ircldc_cheques_proyecto => rcCheque);

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
             pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proDevolverCheque(inuProyecto ldc_cheques_proyecto.id_proyecto%TYPE, -- Proyecto
                                inuCheque   ldc_cheques_proyecto.consecutivo%TYPE -- Cheque
                                ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proDevolverCheque
        Descripcion:        Solo aplicar para cheques en estado consignados, El cheque pasa a estado
                            devuelto, Reversar el pago

        Autor    : Sandra Mu?oz
        Fecha    : 08-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        08-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso                VARCHAR2(4000) := csbPaquete||'proDevolverCheque';
        nuPaso                   NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError                  VARCHAR2(4000);
        rcCheque                 ldc_cheques_proyecto%ROWTYPE; -- Informacion del cheque
        sbCausalAnulacionCheques ld_parameter.value_chain%TYPE; -- Causal de anulacion de cheques
        nuExiste                 NUMBER; -- Existe un elemento ??

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Validar que el usuario que este liberando la accion sea de cartera
        nuPaso := 10;
        IF NOT ldc_bcventaconstructora.fblUsuarioConectPerteneceAArea(csbAreaCartera) THEN
            sbError := 'Solo un usuario de cartera autorizado puede liberar cheques';
            RAISE pkg_error.controlled_error;
        END IF;

        -- Informacion del cheque
        nuPaso := 20;
        ldc_bcVentaConstructora.proDatosCheque(inucheque => inuCheque, orccheque => rcCheque);

        -- Solo se puede permitir devolver cheques en estado Consignados
        nuPaso := 30;
        IF rcCheque.Estado <> csbChequeConsignado THEN
            sbError := 'Solo se pueden devolver cheques en estado consignado';
            RAISE pkg_error.controlled_error;
        END IF;

        -- Setear la aplicacion de anulacion
        nuPaso := 40;
        PKERRORS.SETAPPLICATION(csbProgAnulaPagos);

        -- Obtener la causal de anulacion de pagos
        nuPaso := 50;
        BEGIN
            nuPaso                   := 60;
            sbCausalAnulacionCheques := dald_parameter.fsbGetValue_Chain(inuParameter_id => 'CAUSAL_ANUL_CHEQUES_VTA_CONST');
        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible obtener el valor del parametro CAUSAL_ANUL_CHEQUES_VTA_CONST. ' ||
                           SQLERRM;
                RAISE pkg_error.controlled_error;
        END;

        nuPaso := 70;
        IF sbCausalAnulacionCheques IS NULL THEN
            sbError := 'No se ha definido un valor para el parametro CAUSAL_ANUL_CHEQUES_VTA_CONST';
            RAISE pkg_error.controlled_error;
        END IF;

        nuPaso := 80;
        SELECT COUNT(1)
        INTO   nuExiste
        FROM   rc_causanpa rc
        WHERE  rc.caapcodi = sbCausalAnulacionCheques;

        nuPaso := 90;
        IF nuExiste = 0 THEN
            sbError := 'No se encontro una causal de anulacion de cheques con codigo ' ||
                       sbCausalAnulacionCheques;
            RAISE pkg_error.controlled_error;
        END IF;

        -- Anular el pago
        nuPaso := 100;
        BEGIN
            rc_boannulpayments.collectingannul(inupagocupo => rcCheque.Cupon,
                                               isbpaancaap => sbCausalAnulacionCheques,
                                               isbpaanobse => 'Devolucion del cheque ' ||
                                                              rcCheque.Numero_Cheque ||
                                                              ' asociado al proyecto de constructora' ||
                                                              inuProyecto);

        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible anular el pago asociado al cupon ' || rcCheque.Cupon;

                pkg_traza.trace('  rc_boannulpayments.collectingannul(inupagocupo => rcCheque.Cupon,
                                                                  isbpaancaap => sbCausalAnulacionCheques,
                                                                  isbpaanobse => Devolucion del cheque ' ||
                               rcCheque.Numero_Cheque || ' asociado al proyecto de constructora' ||
                               inuProyecto || ');');

                RAISE pkg_error.controlled_error;
        END;

        -- Cambiar de estado el cheque a DEVUELTO
        nuPaso := 110;
        BEGIN
            daldc_cheques_proyecto.updESTADO(inuCONSECUTIVO => inuCheque,
                                             isbESTADO$     => csbChequeDEvuelto);
        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible cambiar el estado del cheque ' || rcCheque.Consecutivo ||
                           ' a ' || csbChequeDEvuelto;
                RAISE pkg_error.controlled_error;
        END;

        nuPaso := 120;
        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
             pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proModificaCheque(inuCheque        ldc_cheques_proyecto.consecutivo%TYPE, -- Consecutivo del cheque
                                inuEntidad       ldc_cheques_proyecto.entidad%TYPE, -- Entidad
                                isbCuenta        ldc_cheques_proyecto.cuenta%TYPE, --Cuenta
                                isbNumero_Cheque ldc_cheques_proyecto.numero_cheque%TYPE, -- Numero de cheque
                                idtFecha         ldc_cheques_proyecto.fecha_cheque%TYPE, -- Fecha
                                idtFechaAlarma   ldc_cheques_proyecto.fecha_alarma%TYPE, -- Fecha alarma
                                inuValor         ldc_cheques_proyecto.valor%TYPE, -- Valor cheque
                                isbOperacion     VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proModificaCheque
        Descripcion:        Actualiza la informacion del cheque

        Autor    : Sandra Mu?oz
        Fecha    : 08-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        08-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'proModificaCheque';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        rcCheque  ldc_cheques_proyecto%ROWTYPE; -- cheque

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Datos del cheque
        nuPaso := 10;
        ldc_bcventaconstructora.proDatosCheque(inucheque => inuCheque, orccheque => rcCheque);

        nuPaso := 20;
        IF isbOperacion = csbOperacionUpdate THEN
            -- Solo permite modificar datos si el cheque esta registrado
            nuPaso := 30;
            IF rcCheque.Estado <> csbChequeRegistrado THEN
                sbError := 'Solo se pueden realizar modificaciones a cheques en estado registrado';
                RAISE pkg_error.controlled_error;
            END IF;

            nuPaso := 40;
            UPDATE ldc_cheques_proyecto lcp
            SET    lcp.numero_cheque = isbNumero_Cheque,
                   lcp.entidad       = inuEntidad,
                   lcp.cuenta        = isbCuenta,
                   lcp.fecha_cheque  = idtFecha,
                   lcp.fecha_alarma  = idtFechaAlarma,
                   lcp.valor         = inuValor
            WHERE  lcp.consecutivo = inuCheque;

            nuPaso := 50;
            IF SQL%ROWCOUNT = 0 THEN
                sbError := 'No se encontro el cheque ' || inuCheque ||
                           ' para realizar la modificacion';
                RAISE pkg_error.controlled_error;
            END IF;
        ELSE
            nuPaso := 60;
            UPDATE ldc_cheques_proyecto lcp
            SET    lcp.Estado = csbChequeEliminado
            WHERE  lcp.consecutivo = inuCheque;
        END IF;

        nuPaso := 70;
        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
             pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCambiarCheque(inuProyecto        ldc_cheques_proyecto.id_proyecto%TYPE, -- Proyecto
                               isbNumeroCheque    ldc_cheques_proyecto.numero_cheque%TYPE, -- Cheque
                               inuEntidadBancaria ldc_cheques_proyecto.entidad%TYPE, -- Entidad bancaria
                               idtFecha           ldc_cheques_proyecto.fecha_cheque%TYPE, -- Fecha cheque
                               idtFechaAlarma     ldc_cheques_proyecto.fecha_cheque%TYPE DEFAULT trunc(SYSDATE), -- Fecha alarma
                               inuValor           ldc_cheques_proyecto.valor%TYPE, -- Valor
                               isbCuenta          ldc_cheques_proyecto.cuenta%TYPE,
                               inuChequeAnterior  ldc_cheques_proyecto.consecutivo%TYPE) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCambiarCheque
        Descripcion:        Cambia un cheque por uno nuevo

        Autor    : KCienfuegos
        Fecha    : 08-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        08-06-2016   KCienfuegos           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'proCambiarCheque';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        rcCheque  LDC_CHEQUES_PROYECTO%ROWTYPE; -- Informacion del cheque

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        nuPaso := 10;

        -- Validar que el usuario sea de servicio al cliente
        nuPaso := 20;
        IF NOT ldc_bcventaconstructora.fblUsuarioConectPerteneceAArea(isbarea => csbAreaSAC) THEN
            sbError := 'Un cheque solo puede ser cambiado por un usuario de servicio al cliente autorizado';
            RAISE pkg_error.controlled_error;
        END IF;

        -- Validar que el cheque este registrado
        nuPaso := 30;
        ldc_bcventaconstructora.proDatosCheque(inucheque => inuChequeAnterior,
                                               orccheque => rcCheque);
        nuPaso := 40;
        IF rcCheque.Estado <> csbChequeRegistrado THEN
            sbError := 'Solo se pueden cambiar cheques en estado registrado';
            RAISE pkg_error.controlled_error;
        END IF;

        -- Construir el registro
        nuPaso := 50;

        proCreaCheques(isbNumeroCheque    => isbNumeroCheque,
                       isbCuenta          => isbCuenta,
                       inuValor           => inuValor,
                       inuProyecto        => inuProyecto,
                       inuEntidadBancaria => inuEntidadBancaria,
                       idtFechaAlarma     => idtFechaAlarma,
                       idtFecha           => idtFecha);

        -- Actualiza el cheque
        nuPaso := 60;

        UPDATE ldc_cheques_proyecto cp
        SET    cp.nuevo_cheque = isbNumeroCheque,
               cp.estado       = csbChequeAnulado
        WHERE  cp.consecutivo = inuChequeAnterior;

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
             pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proLiberarCheque(inuProyecto ldc_cheques_proyecto.id_proyecto%TYPE, -- Proyecto
                               inuCheque   ldc_cheques_proyecto.consecutivo%TYPE -- Cheque a liberar
                               ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proLiberarCheque
        Descripcion:        Creo el cheque, al viejo le pongo el nuevo cheque y cambio de estado.

        Autor    : Sandra Mu?oz
        Fecha    : 09-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        09-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'proLiberarCheque';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);
        rcCheque  ldc_cheques_proyecto%ROWTYPE; -- Cheque

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Validar que el usuario que este liberando la accion sea de tesoreria
        nuPaso := 10;
        IF NOT ldc_bcventaconstructora.fblUsuarioConectPerteneceAArea(csbAreaTesoreria) THEN
            sbError := 'Solo un usuario de tesoreria autorizado puede liberar cheques';
            RAISE pkg_error.controlled_error;
        END IF;

        -- Traer la informacion del cheque
        nuPaso := 20;
        ldc_bcventaconstructora.proDatosCheque(inuCheque => inuCheque, orcCheque => rcCheque);

        -- Validar que el cheque este en estado "Consignado"
        nuPaso := 30;
        IF rcCheque.Estado <> csbChequeConsignado THEN
            sbError := 'Solo se puede liberar el cheque si esta en estado consignado';
            RAISE pkg_error.controlled_error;
        END IF;

        -- Realizar el cambio de estado
        nuPaso := 40;
        daldc_cheques_proyecto.updESTADO(inuconsecutivo => inuCheque,
                                         isbESTADO$     => csbChequeLiberado);

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
             pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proRegistraNotaCredito(inuProducto          IN servsusc.sesunuse%type,
                                     inuContrato          IN servsusc.sesususc%type,
                                     inuCuencobr          IN cuencobr.cucocodi%type,
                                     inuConcepto          IN concepto.conccodi%type,
                                     inuCausa             IN causcarg.cacacodi%TYPE,
                                     isbDescripcion       IN VARCHAR2,
                                     inuValue             IN diferido.difesape%type)
    IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proRegistraNotaCredito
        Descripcion:        Metodo para registrar nota credito

        Autor    : KCienfuegos
        Fecha    : 05-07-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        05-07-2016   KCienfuegos           Creacion
        ******************************************************************/
        nuNote                                  notas.notanume%type;
        sbProceso                               VARCHAR2(4000) := csbPaquete||'proRegistraNotaCredito';
    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        --  Crea la nota credito
        pkBillingNoteMgr.CreateBillingNote
        (
            inuProducto,
            inuCuencobr,
            GE_BOConstants.fnuGetDocTypeCreNote,
            sysdate,
            isbDescripcion,
            pkBillConst.csbTOKEN_NOTA_CREDITO,
            nuNote
        );

        -- Crea detalle de la nota credito
        FA_BOBillingNotes.DetailRegister
        (
            nuNote,
            inuProducto,
            inuContrato,
            inuCuencobr,
            inuConcepto,
            inuCausa,
            inuValue,
            NULL,
            pkBillConst.csbTOKEN_NOTA_CREDITO || nuNote,
            pkBillConst.CREDITO,
            ld_boconstans.csbYesFlag,
            NULL,
            constants_per.CSBNO,
            FALSE
        );

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            RAISE pkg_error.controlled_error;
    END proRegistraNotaCredito;

    PROCEDURE proRegistraNotaDebito(inuProducto          IN servsusc.sesunuse%type,
                                    inuContrato          IN servsusc.sesususc%type,
                                    inuCuencobr          IN cuencobr.cucocodi%type,
                                    inuConcepto          IN concepto.conccodi%type,
                                    inuCausa             IN causcarg.cacacodi%TYPE,
                                    isbDescription       IN VARCHAR2,
                                    inuValue             IN diferido.difesape%type)
    IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proRegistraNotaDebito
        Descripcion:        Metodo para registrar nota debito

        Autor    : KCienfuegos
        Fecha    : 06-07-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        06-07-2016   KCienfuegos           Creacion
        ******************************************************************/
        nuNote                                  notas.notanume%type;
        sbProceso                               VARCHAR2(4000) := csbPaquete||'proRegistraNotaDebito';
    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        --  Crea la nota debito
        pkBillingNoteMgr.CreateBillingNote
        (
            inuProducto,
            inuCuencobr,
            GE_BOConstants.fnuGetDocTypeDebNote,
            sysdate,
            isbDescription,
            pkBillConst.csbTOKEN_NOTA_DEBITO,
            nuNote
        );

        -- Crea detalle de la nota debito
        FA_BOBillingNotes.DetailRegister
        (
            nuNote,
            inuProducto,
            inuContrato,
            inuCuencobr,
            inuConcepto,
            inuCausa,
            inuValue,
            NULL,
            pkBillConst.csbTOKEN_NOTA_DEBITO || nuNote,
            pkBillConst.DEBITO,
            constants_per.CSBSI,
            NULL,
            constants_per.CSBSI,
            FALSE
        );

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            RAISE pkg_error.controlled_error;
    END proRegistraNotaDebito;

    PROCEDURE proCreaCuentaCobro(inuProducto          IN servsusc.sesunuse%type,
                                 inuContrato          IN servsusc.sesususc%type,
                                 onuCuenta            OUT cuencobr.cucocodi%type,
                                 onuFactura           OUT factura.factcodi%type)
    IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaCuentaCobro
        Descripcion:        Metodo para crear una cuenta de cobro

        Autor    : KCienfuegos
        Fecha    : 06-07-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        06-07-2016   KCienfuegos            Creacion.
        ******************************************************************/
        nuNote                                  notas.notanume%type;
        sbProceso                               VARCHAR2(4000) := csbPaquete||'proCreaCuentaCobro';
        rcContrato                              suscripc%ROWTYPE;
        rcProducto                              servsusc%ROWTYPE;
        nuCliente      suscripc.suscclie%type; -- se almacena cliente
        nuSistema      NUMBER;
        nuTipoComp     factura.factcons%type;
        nufiscal       FACTURA.factnufi%TYPE;
        nuTipoComprobante NUMBER;

        sbPrefijo       FACTURA.factpref%TYPE;
        nuConsFisca     FACTURA.factconf%TYPE;

        --TICKET 200-2022 LJLB -- se obtiene cliente del constrato
        CURSOR cuGetCliente IS
        SELECT suscclie
        FROM suscripc
        WHERE susccodi = inuContrato;

        --TICKET 200-2022 LJLB -- se codigo del sistema
        CURSOR cuGetSistema IS
        SELECT SISTCODI
        FROM sistema;

        --se consulta tipo de comprobante de la factura
        CURSOR cuTipoComp IS
        SELECT factcons
        FROM factura
        WHERE factcodi = onuFactura;


    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        -- Se obtiene numero de factura
        pkAccountStatusMgr.GetNewAccoStatusNum(onuFactura);

        --Se obtiene el record del contrato
        rcContrato := pktblSuscripc.frcGetRecord(inuContrato);

        -- Se crea la nueva factura
        pkAccountStatusMgr.AddNewRecord(onuFactura,
                                        pkGeneralServices.fnuIDProceso,
                                        rcContrato,
                                        GE_BOconstants.fnuGetDocTypeCons);

        -- Se obtiene el consecutivo de la cuenta de cobro
        pkAccountMgr.GetNewAccountNum(onuCuenta);

        -- Se obtienen el record del producto
        rcProducto := pktblservsusc.frcgetrecord(inuProducto);

        -- Crea una nueva cuenta de cobro
        pkAccountMgr.AddNewRecord(onuFactura, onuCuenta, rcProducto);

        --se actualiza numero fiscal

        OPEN cuGetCliente;
        FETCH cuGetCliente INTO nuCliente;
        CLOSE cuGetCliente;

        OPEN cuGetSistema;
        FETCH cuGetSistema INTO nuSistema;
        CLOSE cuGetSistema;

        OPEN cuTipoComp;
        FETCH cuTipoComp INTO nuTipoComp;
        CLOSE cuTipoComp;

        pkConsecutiveMgr.GetFiscalNumber(pkConsecutiveMgr.gcsbTOKENFACTURA,
                                         onuFactura,
                                         null,
                                         nuTipoComp,
                                         nuCliente,
                                         nuSistema,
                                         nufiscal,
                                         sbPrefijo,
                                         nuConsFisca,
                                         nuTipoComprobante);
        -- Se actualiza la factura
        pktblFactura.UpFiscalNumber(onuFactura,
                                    nufiscal,
                                    nuTipoComp,
                                    nuConsFisca,
                                    sbPrefijo);


        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
		    pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
			pkg_traza.trace(sbProceso||'Error: '||SQLERRM, cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;
    END proCreaCuentaCobro;

    PROCEDURE proTrasladaDifACorriente(inuDifecodi  IN diferido.difecodi%TYPE)
    IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proTrasladaDifACorriente
        Descripcion:        Metodo para trasladar un diferido a corriente

        Autor    : KCienfuegos
        Fecha    : 07-07-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        07-07-2016   KCienfuegos            Creacion.
        ******************************************************************/
        nuNote                                  notas.notanume%type;
        sbProceso                               VARCHAR2(4000) := csbPaquete||'proTrasladaDifACorriente';
        nuErrorCode               NUMBER;
        sbErrorMessage            VARCHAR2(3000);

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

          CC_BODefToCurTransfer.GlobalInitialize;

          CC_BODefToCurTransfer.AddDeferToCollect(inuDifecodi);

          CC_BODefToCurTransfer.TransferDebt
          (
              'FINAN',
              nuErrorCode,
              sbErrorMessage,
              false,
              ld_boconstans.cnuCero_Value,
              sysdate
          );

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            IF (sbErrorMessage IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbErrorMessage);
            END IF;
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END proTrasladaDifACorriente;

    PROCEDURE procargadatosLDCAPS(inuproyecto ldc_proyecto_constructora.id_proyecto%TYPE) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: procargadatosLDCAPS
        Descripcion:        Carga los datos del proyecto y el cliente en el PB LDCAPS y LDCACP.

        Autor    : KCienfuegos
        Fecha    : 13-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        13-06-2016   KCienfuegos           Creacion
        ******************************************************************/

        sbInstance       ge_boinstancecontrol.stysbname := NULL;
        sbGroup          ge_boinstancecontrol.stysbname := NULL;
        sbnombreproyecto ldc_proyecto_constructora.nombre%TYPE;
        nucliente        ldc_proyecto_constructora.cliente%TYPE;
        nutipoid         ge_subscriber.ident_type_id%TYPE;
        sbidentificacion ge_subscriber.identification%TYPE;
        sbnombrecliente  ge_subscriber.url%TYPE;
        sbPagare         ldc_proyecto_constructora.pagare%TYPE;
        sbContrato       ldc_proyecto_constructora.contrato%TYPE;
        nuCotizacion     cc_quotation.quotation_id%TYPE;
        nuAtributo       NUMBER;
        sbProceso        VARCHAR2(100) := csbPaquete||'procargadatosLDCAPS';
        nuPaso           NUMBER;
        sbError          VARCHAR2(4000);

        CURSOR cuObtieneCotizacion IS
         SELECT lcc.id_cotizacion_osf
            FROM   ldc_cotizacion_construct lcc
            WHERE  lcc.id_proyecto = inuProyecto
            AND    lcc.estado IN(csbCotizPreaprobada);

    BEGIN

        IF (inuproyecto IS NULL) THEN
            pkg_error.setErrorMessage(cnuNULL_ATTRIBUTE, 'Id del proyecto');
            RAISE pkg_error.controlled_error;
        END IF;

        IF (sbInstance IS NULL) THEN
            sbInstance := ge_boinstancecontrol.fsbgetcurrentinstance;
        END IF;

        IF (sbGroup IS NULL) THEN
            sbGroup := ge_boinstancecontrol.fsbgetcurrentgroup;
        END IF;

        sbNombreproyecto := daldc_proyecto_constructora.fsbGetNOMBRE(inuID_PROYECTO => inuproyecto);
        nuCliente        := daldc_proyecto_constructora.fnuGetCLIENTE(inuID_PROYECTO => inuproyecto);
        nuTipoid         := pkg_bccliente.fnuTipoIdentificacion(nuCliente);
        sbIdentificacion := pkg_bccliente.fsbidentificacion (nuCliente);
        sbNombrecliente  := pkg_bccliente.fsbnombres(nuCliente);

        ge_boinstancecontrol.setattributenewvalue(sbinstance,
                                                  sbgroup,
                                                  'LDC_PROYECTO_CONSTRUCTORA',
                                                  'ID_PROYECTO',
                                                  inuproyecto);
        ge_boinstancecontrol.setattributenewvalue(sbinstance,
                                                  sbgroup,
                                                  'LDC_PROYECTO_CONSTRUCTORA',
                                                  'NOMBRE',
                                                  sbNombreproyecto);
        ge_boinstancecontrol.setattributenewvalue(sbinstance,
                                                  sbgroup,
                                                  'GE_SUBSCRIBER',
                                                  'IDENT_TYPE_ID',
                                                  nuTipoid);
        ge_boinstancecontrol.setattributenewvalue(sbinstance,
                                                  sbgroup,
                                                  'GE_SUBSCRIBER',
                                                  'IDENTIFICATION',
                                                  sbIdentificacion);
        ge_boinstancecontrol.setattributenewvalue(sbinstance,
                                                  sbgroup,
                                                  'GE_SUBSCRIBER',
                                                  'URL',
                                                  sbNombrecliente);

        IF (ge_boinstancecontrol.FBLACCKEYATTRIBUTESTACK(sbinstance,
                                                         sbgroup,
                                                         'LDC_PROYECTO_CONSTRUCTORA',
                                                         'PAGARE',
                                                         nuAtributo)) THEN
            sbPagare := daldc_proyecto_constructora.fsbGetPAGARE(inuID_PROYECTO => inuproyecto);
            ge_boinstancecontrol.setattributenewvalue(sbinstance,
                                                      sbgroup,
                                                      'LDC_PROYECTO_CONSTRUCTORA',
                                                      'PAGARE',
                                                      sbPagare);
        END IF;

        IF (ge_boinstancecontrol.FBLACCKEYATTRIBUTESTACK(sbinstance,
                                                         sbgroup,
                                                         'LDC_PROYECTO_CONSTRUCTORA',
                                                         'CONTRATO',
                                                         nuAtributo)) THEN
            sbContrato := daldc_proyecto_constructora.fsbGetCONTRATO(inuID_PROYECTO => inuproyecto);
            ge_boinstancecontrol.setattributenewvalue(sbinstance,
                                                      sbgroup,
                                                      'LDC_PROYECTO_CONSTRUCTORA',
                                                      'CONTRATO',
                                                      sbContrato);
        END IF;

        IF (ge_boinstancecontrol.FBLACCKEYATTRIBUTESTACK(sbinstance,
                                                         sbgroup,
                                                         'CC_QUOTATION',
                                                         'QUOTATION_ID',
                                                         nuAtributo)) THEN
            OPEN cuObtieneCotizacion;
            FETCH cuObtieneCotizacion INTO nuCotizacion;
            CLOSE cuObtieneCotizacion;

            IF(nuCotizacion IS NOT NULL)THEN
              ge_boinstancecontrol.setattributenewvalue(sbinstance,
                                                        sbgroup,
                                                        'CC_QUOTATION',
                                                        'QUOTATION_ID',
                                                        nuCotizacion);
            END IF;
        END IF;

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
             pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    FUNCTION frfObtSubrogacionesPorAprobar RETURN constants_per.tyrefcursor IS
        /*****************************************************************
         Propiedad intelectual de Gases del Caribe.

         Nombre del Paquete: frfObtSubrogacionesPorAprobar
         Descripcion:        Retorna los registros a procesar en la forma LDCAPS

         Autor    : KCienfuegos
         Fecha    : 13-06-2016

         Historia de Modificaciones

         DD-MM-YYYY    <Autor>.              Modificacion
         -----------  -------------------    -------------------------------------
         13-06-2016   KCienfuegos           Creacion
        ******************************************************************/
        sbProceso     VARCHAR2(4000) := csbPaquete||'frfObtSubrogacionesPorAprobar';
        ocuCursor     constants_per.tyrefcursor;
        nuProyecto    ldc_proyecto_constructora.id_proyecto%TYPE;
        sbConsulta    VARCHAR2(32000);
        nuProductoGas pr_product.product_type_id%TYPE := dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS',0);
        sbID_PROYECTO ge_boInstanceControl.stysbValue;
        sbFILTRO      ge_boInstanceControl.stysbValue;
        nuPaso        NUMBER;
        sbError       VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        sbID_PROYECTO := ge_boInstanceControl.fsbGetFieldValue('LDC_PROYECTO_CONSTRUCTORA',
                                                                      'ID_PROYECTO');
        IF (sbID_PROYECTO IS NOT NULL) THEN
           nuProyecto := to_number(sbID_PROYECTO);
        END IF;

        sbFiltro   := ge_boInstanceControl.fsbGetFieldValue('AB_ADDRESS', 'ADDRESS_PARSED');

        sbConsulta := 'SELECT e.consecutivo id, e.id_direccion Id_direccion, ab.address_parsed Direccion, p.product_id Producto, e.id_solicitud Solicitud, subrog_aprob Aprobado ' ||
                      chr(10) ||
                      'FROM pr_product p, suscripc s, ab_address ab, ldc_equival_unid_pred e, ldc_proyecto_constructora pc' ||
                      chr(10) || 'WHERE e.id_proyecto = :inuProyecto' || chr(10) ||
                      'AND e.id_direccion = p.address_id' || chr(10) ||
                      'AND p.address_id = ab.address_id' || chr(10) ||
                      'AND p.product_type_id = :nuProductoGas' || chr(10) ||
                      'AND p.subscription_id = s.susccodi' || chr(10) ||
                      'AND e.id_proyecto = pc.id_proyecto' || chr(10) ||
                      'AND s.suscclie = pc.cliente' || chr(10)||
                      'AND e.activa = ''S'''|| chr(10);

        IF (sbFiltro IS NOT NULL) THEN
            sbConsulta := sbConsulta || 'AND ab.address_parsed LIKE UPPER(''%' || sbFiltro ||'%'')';
        END IF;

        pkg_traza.trace(' Consulta ' || sbConsulta, cnuNVLTRC);

        OPEN ocuCursor FOR sbConsulta
            USING nuProyecto, nuProductoGas;

        pkg_traza.trace(' FIN ' || csbPaquete || '.' || sbProceso, cnuNVLTRC);

        RETURN ocuCursor;

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
             pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proAprobarSubrogaciones(isbPk        IN VARCHAR2,
                                      inuCurrent   IN NUMBER,
                                      inuTotal     IN NUMBER,
                                      onuErrorCode OUT ge_error_log.message_id%TYPE,
                                      osbErrorMess OUT ge_error_log.description%TYPE) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proAprobarSubrogaciones
        Descripcion:        Metodo que procesa los registros de la forma LDCAPS

        Autor    : KCienfuegos
        Fecha    : 13-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        13-06-2016   KCienfuegos           Creacion
        ******************************************************************/
        sbProceso VARCHAR2(4000) := csbPaquete||'proAprobarSubrogaciones';
        sbOpcion  VARCHAR2(20);
        nuPaso    NUMBER;

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        IF (inuCurrent = 1) THEN
            sbOpcion := ge_boInstanceControl.fsbGetFieldValue('GE_SUBSCRIBER', 'ACTIVE');

            IF (sbOpcion IS NULL) THEN
                pkg_error.setErrorMessage(cnuNULL_ATTRIBUTE, 'Aprobar');
                RAISE pkg_error.controlled_error;
            END IF;

        END IF;

        daldc_equival_unid_pred.updSUBROG_APROB(inuCONSECUTIVO   => to_number(isbPk),
                                                isbSUBROG_APROB$ => sbOpcion);

        IF(sbOpcion = 'S')THEN
           daldc_equival_unid_pred.updFECHA_APROB(inuCONSECUTIVO => to_number(isbPk),
                                                  idtFECHA_APROB$ => SYSDATE);
        ELSE
           daldc_equival_unid_pred.updFECHA_APROB(inuCONSECUTIVO => to_number(isbPk),
                                                  idtFECHA_APROB$ => NULL);
        END IF;

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||osbErrorMess,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            IF(osbErrorMess IS NOT NULL)THEN
             pkg_error.setErrorMessage(cnuDescripcionError, osbErrorMess);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE ProActualizarYPagareContrato IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: ProActualizarYPagareContrato
        Descripcion:        Metodo para actualizar pagare y contrado de acuerdo a lo ingresado
                            en laforma LDCACP.

        Autor    : KCienfuegos
        Fecha    : 13-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        13-06-2016   KCienfuegos           Creacion
        ******************************************************************/
        sbID_PROYECTO ge_boInstanceControl.stysbValue;
        sbPAGARE      ge_boInstanceControl.stysbValue;
        sbCONTRATO    ge_boInstanceControl.stysbValue;
        nuProyecto    ldc_proyecto_constructora.id_proyecto%TYPE;
        sbProceso     VARCHAR2(100) := csbPaquete||'ProActualizarYPagareContrato';
        nuPaso        NUMBER;
        sbError       VARCHAR2(4000);

    BEGIN

        sbID_PROYECTO := ge_boInstanceControl.fsbGetFieldValue('LDC_PROYECTO_CONSTRUCTORA',
                                                               'ID_PROYECTO');
        sbPAGARE      := ge_boInstanceControl.fsbGetFieldValue('LDC_PROYECTO_CONSTRUCTORA',
                                                               'PAGARE');
        sbCONTRATO    := ge_boInstanceControl.fsbGetFieldValue('LDC_PROYECTO_CONSTRUCTORA',
                                                               'CONTRATO');

        ------------------------------------------------
        -- User code
        ------------------------------------------------
        IF (sbID_PROYECTO IS NULL) THEN
            pkg_error.setErrorMessage(cnuNULL_ATTRIBUTE, 'Id del Proyecto');
            RAISE pkg_error.controlled_error;
        END IF;

        IF (sbPAGARE IS NULL AND sbCONTRATO IS NULL) THEN
            pkg_error.setErrorMessage(cnuDescripcionError, 'Debe digitar pagare o contrato');
            RAISE pkg_error.controlled_error;
        END IF;


        nuProyecto := TO_NUMBER(sbID_PROYECTO);

        IF (DALDC_PROYECTO_CONSTRUCTORA.fblExist(nuProyecto)) THEN

            daldc_proyecto_constructora.updPAGARE(inuID_PROYECTO => nuProyecto,
                                                  isbPAGARE$     => sbPAGARE);
            daldc_proyecto_constructora.updCONTRATO(inuID_PROYECTO => nuProyecto,
                                                    isbCONTRATO$   => sbCONTRATO);

            COMMIT;
        END IF;

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
             pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            ROLLBACK;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            ROLLBACK;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE ProActualizarAnticipo IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: ProActualizarAnticipo
        Descripcion:        Metodo para actualizar el anticipo de una cotizacion

        Autor    : KCienfuegos
        Fecha    : 13-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        13-06-2016   KCienfuegos           Creacion
        ******************************************************************/
        sbID_PROYECTO ge_boInstanceControl.stysbValue;
        sbQUOTATION_ID ge_boInstanceControl.stysbValue;
        sbINITIAL_PAYMENT ge_boInstanceControl.stysbValue;
        nuProyecto    ldc_proyecto_constructora.id_proyecto%TYPE;
        nuCotizacion  cc_quotation.quotation_id%TYPE;
        rcCotizacion  DACC_Quotation.styCC_quotation;
        nuAnticipo    cc_quotation.initial_payment%TYPE;
        sbProceso     VARCHAR2(100) := csbPaquete||'ProActualizarAnticipo';
        nuPaso        NUMBER;
        sbError       VARCHAR2(4000);

    BEGIN

        sbID_PROYECTO := ge_boInstanceControl.fsbGetFieldValue('LDC_PROYECTO_CONSTRUCTORA',
                                                               'ID_PROYECTO');
        sbQUOTATION_ID := ge_boInstanceControl.fsbGetFieldValue ('CC_QUOTATION', 'QUOTATION_ID');
        sbINITIAL_PAYMENT := ge_boInstanceControl.fsbGetFieldValue ('CC_QUOTATION', 'INITIAL_PAYMENT');

        ------------------------------------------------
        -- User code
        ------------------------------------------------
        IF (sbID_PROYECTO IS NULL) THEN
            pkg_error.setErrorMessage(cnuNULL_ATTRIBUTE, 'Id del Proyecto');
            RAISE pkg_error.controlled_error;
        END IF;

        IF (sbQUOTATION_ID IS NULL) THEN
            pkg_error.setErrorMessage(cnuDescripcionError, 'No se encontro cotizacion valida para el proceso');
            RAISE pkg_error.controlled_error;
        END IF;

        nuCotizacion :=TO_NUMBER(sbQUOTATION_ID);
        dacc_quotation.acckey(nuCotizacion);

        rcCotizacion := dacc_quotation.frcgetrecord(nuCotizacion);

        IF (rcCotizacion.status IN ('A','C'))THEN
          pkg_error.setErrorMessage(cnuDescripcionError, 'La cotizacion ya fue aprobada por tanto no es posible actualizar el anticipo');
          RAISE pkg_error.controlled_error;
        END IF;

        nuAnticipo := to_number(sbINITIAL_PAYMENT);

        dacc_quotation.updinitial_payment(inuquotation_id => nuCotizacion,
                                          inuinitial_payment$ => nuAnticipo);

        COMMIT;

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            ROLLBACK;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            ROLLBACK;
            RAISE pkg_error.controlled_error;
    END;

    FUNCTION frfObtUnidsPredialesXProyecto RETURN constants_per.tyrefcursor IS
        /*****************************************************************
         Propiedad intelectual de Gases del Caribe.

         Nombre del Paquete: frfObtUnidsPredialesXProyecto
         Descripcion:        Retorna los registros a procesar en la forma LDCAUP,
                             para anular las unidades prediales de un proyecto constructora.

         Autor    : KCienfuegos
         Fecha    : 05-07-2016

         Historia de Modificaciones

         DD-MM-YYYY    <Autor>.              Modificacion
         -----------  -------------------    -------------------------------------
         05-07-2016   KCienfuegos           Creacion.
        ******************************************************************/
        sbProceso     VARCHAR2(4000) := csbPaquete||'frfObtUnidsPredialesXProyecto';
        ocuCursor     constants_per.tyrefcursor;
        nuProyecto    ldc_proyecto_constructora.id_proyecto%TYPE;
        sbConsulta    VARCHAR2(32000);
        nuProductoGas pr_product.product_type_id%TYPE := dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS',0);
        sbID_PROYECTO ge_boInstanceControl.stysbValue;
        sbFILTRO      ge_boInstanceControl.stysbValue;
        nuPaso        NUMBER;
        sbError       VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);


        nuProyecto := ge_boInstanceControl.fsbGetFieldValue('LDC_PROYECTO_CONSTRUCTORA',
                                                                      'ID_PROYECTO');
        IF (sbID_PROYECTO IS NOT NULL) THEN
           nuProyecto := to_number(sbID_PROYECTO);
        END IF;

        IF(gnuCausaNota IS NULL)THEN
           sbError:='El parametro CAUSAL_NOTA_ANUL_UNIDAD no ha sido configurado correctamente';
           raise pkg_error.controlled_error;
        END IF;

        sbFiltro   := ge_boInstanceControl.fsbGetFieldValue('AB_ADDRESS', 'ADDRESS_PARSED');

        sbConsulta := 'SELECT e.consecutivo id, e.id_direccion Id_direccion, ab.address_parsed Direccion, p.product_id Producto, activa Activa ' ||
                      chr(10) ||
                      'FROM pr_product p, suscripc s, ab_address ab, ldc_equival_unid_pred e, ldc_proyecto_constructora pc' ||
                      chr(10) || 'WHERE e.id_proyecto = :inuProyecto' || chr(10) ||
                      'AND e.id_direccion = p.address_id' || chr(10) ||
                      'AND p.address_id = ab.address_id' || chr(10) ||
                      'AND p.product_type_id = :nuProductoGas' || chr(10) ||
                      'AND p.subscription_id = s.susccodi' || chr(10) ||
                      'AND e.id_proyecto = pc.id_proyecto' || chr(10) ||
                      'AND s.suscclie = pc.cliente' || chr(10)||
                      'AND e.activa = ''S'''|| chr(10);

        IF (sbFiltro IS NOT NULL) THEN
            sbConsulta := sbConsulta || 'AND ab.address_parsed LIKE UPPER(''%' || sbFiltro ||'%'')';
        END IF;

        pkg_traza.trace(' Consulta ' || sbConsulta, cnuNVLTRC);

        OPEN ocuCursor FOR sbConsulta
            USING nuProyecto, nuProductoGas;

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN ocuCursor;

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;
    END;

    PROCEDURE proAnularUnidadesPrediales(isbPk        IN VARCHAR2,
                                         inuCurrent   IN NUMBER,
                                         inuTotal     IN NUMBER,
                                         onuErrorCode OUT ge_error_log.message_id%TYPE,
                                         osbErrorMess OUT ge_error_log.description%TYPE) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proAnularUnidadesPrediales
        Descripcion:        Metodo que procesa los registros de la forma LDCAUP.
                            (Anulacion de Unidades Prediales)

        Autor    : KCienfuegos
        Fecha    : 05-07-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        05-07-2016   KCienfuegos           Creacion
        ******************************************************************/
        sbProceso                          VARCHAR2(4000) := csbPaquete||'proAnularUnidadesPrediales';
        sbOpcion                           VARCHAR2(20);
        nuPaso                             NUMBER;
        nuCount                            NUMBER:=0;
        nuValor                            NUMBER:=0;
        rcUnidad                           daldc_equival_unid_pred.styLDC_EQUIVAL_UNID_PRED;
        nuProducto                         pr_product.product_id%TYPE;
        nuProyecto                         ldc_proyecto_constructora.id_proyecto%TYPE;
        sbID_PROYECTO                      ge_boInstanceControl.stysbValue;
        nuConcepto                         concepto.conccodi%TYPE;
        nuSolicitud                        ldc_proyecto_constructora.id_solicitud%TYPE;
        nuDiferido                         diferido.difecodi%TYPE;
        nuCuenta                           cuencobr.cucocodi%TYPE;
        nuFactura                          cuencobr.cucofact%TYPE;
        nuValorTotal                       cuencobr.cucovato%TYPE;
        sbSignoAplicado                    cargos.cargsign%type;
        nuAjusteAplicado                   cargos.cargvalo%type;
        blVentaFinanciada                  BOOLEAN;
        nuEstadoRetiro                     estacort.escocodi%TYPE := 95;

        CURSOR cuObtieneOrdenesLeg(nuAddress ab_address.address_id%TYPE) IS
          SELECT COUNT(1)
            FROM or_order_activity oa, or_order o
           WHERE o.order_id = oa.order_id
             AND o.order_status_id IN (pkg_gestionordenes.CNUORDENCERRADA, pkg_gestionordenes.CNUORDENENEJECUCION)
             AND oa.address_id = nuAddress
             AND oa.product_id = nuProducto;

        CURSOR cuOrdenesAnular(nuAddress ab_address.address_id%TYPE) IS
          SELECT DISTINCT o.order_id
            FROM or_order_activity oa, or_order o
           WHERE o.order_id = oa.order_id
             AND oa.address_id = nuAddress
             AND oa.product_id = nuProducto;

        CURSOR cuObtieneProducto(nuAddress ab_address.address_id%TYPE) IS
          SELECT product_id
            FROM pr_product p
           WHERE p.address_id = nuAddress;

        CURSOR cuObtValorPorTipoTrabajo IS
          SELECT id_tipo_trabajo, precio_total
            FROM ldc_consolid_cotizacion b, ldc_cotizacion_construct c
           WHERE b.id_proyecto = gnuProyecto
             AND b.id_cotizacion_detallada = c.id_cotizacion_detallada
             AND b.id_proyecto = c.id_proyecto
             AND c.estado = csbCotizAprobada;

        CURSOR cuObtDiferidoPorConcept(nuConcepto concepto.conccodi%TYPE) IS
          SELECT difecodi
            FROM diferido d
           WHERE difeconc = nuConcepto
             AND difenuse = gnuProducto
             AND difesusc = gnuSuscripcion;

        CURSOR cuProducto (nuSolicitud ldc_proyecto_constructora.id_solicitud%type) is
          SELECT DISTINCT product_id
            FROM mo_motive m
           WHERE package_id = nuSolicitud
             AND m.product_type_id = cnuProductoGenerico;

        CURSOR cuValorTotal IS
          SELECT SUM(b.precio_total)
            FROM ldc_consolid_cotizacion b, ldc_cotizacion_construct c
           WHERE b.id_proyecto = gnuProyecto
             AND b.id_cotizacion_detallada = c.id_cotizacion_detallada
             AND b.id_proyecto = c.id_proyecto
             AND c.estado = csbCotizAprobada;

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        IF (inuCurrent = 1) THEN
            gnuProyecto := to_number(ge_boInstanceControl.fsbGetFieldValue ('LDC_PROYECTO_CONSTRUCTORA', 'ID_PROYECTO'));
            gnuSuscripcion := daldc_proyecto_constructora.fnuGetSUSCRIPCION(inuID_PROYECTO => gnuProyecto);
            nuSolicitud := daldc_proyecto_constructora.fnuGetID_SOLICITUD(inuID_PROYECTO => gnuProyecto);

            --Se valida si la venta fue financiada
            blVentaFinanciada := ldc_bcVentaConstructora.fblProyectoFinanciado(gnuProyecto);

            -- Si la venta fue financiada se obtiene el saldo de la deuda
            IF(blVentaFinanciada) THEN
            ldc_bcVentaConstructora.proDeudaProyecto(inuProyecto     => gnuProyecto,
                                                     onuDeuda        => gnuSaldo,
                                                     onuFinanciacion => gnuFinanciacion);
            END IF;

            -- Se obtiene el producto generico
            OPEN  cuProducto(nuSolicitud);
            FETCH cuProducto INTO gnuProducto;
            CLOSE cuProducto;

            -- Se obtiene el valor total por apartamento
            OPEN cuValorTotal;
            FETCH cuValorTotal INTO gnuValorTotal;
            CLOSE cuValorTotal;

        END IF;

        --Validar que no existan trabajos realizados
        rcUnidad := daldc_equival_unid_pred.frcGetRecord(to_number(isbPk));

        IF (rcUnidad.id_direccion IS NOT NULL) THEN

          OPEN cuObtieneProducto(rcUnidad.id_direccion);
          FETCH cuObtieneProducto INTO nuProducto;
          CLOSE cuObtieneProducto;

          --Valida ordenes ejecutadas/legalizadas
          OPEN cuObtieneOrdenesLeg(rcUnidad.id_direccion);
          FETCH cuObtieneOrdenesLeg INTO nuCount;
          CLOSE cuObtieneOrdenesLeg;

        END IF;

        IF(nuCount > 0)THEN
          onuErrorCode := ld_boconstans.cnuonenumber;
          osbErrorMess := 'Para la unidad predial con direccion '||rcUnidad.id_direccion||'-'||pkg_bcdirecciones.fsbGetDireccionParseada(rcUnidad.id_direccion) ||' ya existen trabajos realizados.';

        ELSE
          BEGIN
          -- Se anulan las ordenes
          FOR o IN cuOrdenesAnular(rcUnidad.id_direccion) LOOP
			api_anullorder(o.order_id,NULL,NULL,onuErrorCode,osbErrorMess);
          END LOOP;

          -- Se anula el producto
          pr_boretire.RetireProduct(nuProducto, 2, sysdate, sysdate, null, true);

          pktblservsusc.updsesuesco(inuSesunuse => nuProducto,
                                    inusesuesco$ => nuEstadoRetiro);

          dapr_product.updproduct_status_id(inuProduct_Id => nuProducto,
                                            inuproduct_status_id$ => pkg_gestion_producto.CNUESTADO_RETIRADO_PRODUCTO);

          IF (blVentaFinanciada AND nvl(gnuSaldo,0)>=gnuValorTotal) THEN
            -- Se trasdala el valor a presente mes
            proTrasladoDiferidoACorriente(inufinanciacion => gnuFinanciacion,
                                          inuvalor        => gnuValorTotal,
                                          onuFactura      => nuFactura,
                                          onuCuenta       => nuCuenta);
          ELSE
            -- Se crea la cuenta de cobro
            proCreaCuentaCobro(gnuProducto,
                               gnuSuscripcion,
                               nuCuenta,
                               nuFactura);
          END IF;

          IF (nuCuenta IS NOT NULL) THEN

            --Crear la nota credito por el valor del costo del apartamento
            FOR i IN cuObtValorPorTipoTrabajo LOOP
                nuConcepto := daor_task_type.fnugetconcept(i.id_tipo_trabajo);

                proRegistraNotaCredito(gnuProducto,
                                       gnuSuscripcion,
                                       nuCuenta,
                                       nuConcepto,
                                       gnuCausaNota,
                                       'Anulacion de unidad predial',
                                       i.precio_total);
            END LOOP;

             -- Ajusta la Cuenta
              pkAccountMgr.AdjustAccount
              (
                  nuCuenta,
                  gnuProducto,
                  gnuCausaNota,
                  pkGeneralServices.fnuIDProceso,
                  pkBillConst.cnuUPDATE_DB,
                  sbSignoAplicado,
                  nuAjusteAplicado,
                  pkbillconst.POST_FACTURACION
              );

              -- Genera saldo a favor
              pkAccountMgr.GenPositiveBal( nuCuenta, nuConcepto );

          END IF;

            daldc_equival_unid_pred.updACTIVA(inuCONSECUTIVO   => to_number(isbPk),
                                              isbACTIVA$ =>  'N');
          EXCEPTION
            WHEN pkg_error.controlled_error THEN
			  pkg_traza.trace(sbProceso || '(' || nuPaso || '):' || osbErrorMess, cnuNVLTRC);
               pkg_error.getError(onuErrorCode,osbErrorMess);
               onuErrorCode := ld_boconstans.cnuonenumber;
            WHEN OTHERS THEN
			  pkg_traza.trace(sbProceso || '(' || nuPaso || '):' || SQLERRM, cnuNVLTRC);
              onuErrorCode := ld_boconstans.cnuonenumber;
              osbErrorMess := SQLERRM;
          END;
        END IF;

        IF (inuCurrent = inuTotal) THEN
            gnuProyecto := NULL;
            gnuProducto := NULL;
            gnuSuscripcion := NULL;
            gnuFinanciacion := NULL;
            gnuValorTotal := 0;
            gnuSaldo := 0;
        END IF;

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
		     pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
             RAISE;
        WHEN OTHERS THEN
             pkg_error.setError;
			 pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
             RAISE pkg_error.controlled_error;
    END;

    PROCEDURE proCreaCuotaAdicional(inuProyecto   ldc_cuotas_adicionales.id_proyecto%TYPE, -- Proyecto
                                    inuValorCupon ldc_cuotas_adicionales.valor%TYPE, -- Valor cupon
                                    isbTipoCuota  ldc_cuotas_adicionales.tipo_cuota%TYPE, -- Tipo de cuota
                                    inuCupon      ldc_cuotas_adicionales.cupon%TYPE, -- Cupon
                                    onuCuota      OUT ldc_cuotas_adicionales.consecutivo%TYPE -- Cuota
                                    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaCuotaAdicional
        Descripcion:        Crea la cuota en LDC_CUOTAS_ADICIONALES

        Autor    : Sandra Mu?oz
        Fecha    : 16-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        16-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'proCreaCuotaAdicional';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000); -- Error
        rcCuota   daldc_cuotas_adicionales.styLDC_CUOTAS_ADICIONALES;

    BEGIN
        
		pkg_traza.trace(sbProceso, cnuNVLTRC, csbInicio);
		

        -- Construye el registro
        nuPaso                 := 10;
        rcCuota.consecutivo    := seq_ldc_cuotas_adicionales.nextval;
        nuPaso                 := 20;
        rcCuota.id_proyecto    := inuProyecto;
        nuPaso                 := 30;
        rcCuota.valor          := inuValorCupon;
        nuPaso                 := 40;
        rcCuota.cupon          := inuCupon;
        nuPaso                 := 50;
        rcCuota.tipo_cuota     := isbTipoCuota;
        nuPaso                 := 60;
        rcCuota.fecha_registro := SYSDATE;
        nuPaso                 := 70;
        rcCuota.usua_registra  := USER;

        -- Graba la informacion
        nuPaso := 80;
        BEGIN
            daldc_cuotas_adicionales.insRecord(ircldc_cuotas_adicionales => rcCuota);
        EXCEPTION
            WHEN OTHERS THEN
                sbError := SQLERRM;
                RAISE pkg_error.controlled_error;
        END;

        onuCuota := rcCuota.consecutivo;

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proRegistraCuotaAdicional(inuProyecto   ldc_cuotas_adicionales.id_proyecto%TYPE, -- Proyecto
                                        inuValorCupon ldc_cuotas_adicionales.valor%TYPE, -- Valor cupon
                                        isbTipoCuota  ldc_cuotas_adicionales.tipo_cuota%TYPE, -- Tipo de cuota
                                        onuCuota      OUT ldc_cuotas_adicionales.consecutivo%TYPE, -- Cuota
                                        onuCupon      OUT ldc_cuotas_adicionales.cupon%TYPE -- Cupon
                                        ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proRegistraCuotaAdicional
        Descripcion:        Genera el cupon y registra la cuota

        Autor    : Sandra Mu?oz
        Fecha    : 17-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        17-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'proRegistraCuotaAdicional';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000); -- Error
        sbPrograma                VARCHAR2(10) := 'FRVAD';
        nuFactura factura.factcodi%TYPE; -- Factura
        nuFactorRedondeo                 NUMBER;
        nuIdEmpresa                      NUMBER:=99;
        nuValorCupon                     NUMBER:=0;

    BEGIN
        pkg_traza.trace(sbProceso, cnuNVLTRC, csbInicio);


        pkErrors.SetApplication(sbPrograma);

        FA_BOPoliticaRedondeo.ObtFactorRedondeo( null, nuFactorRedondeo, nuIdEmpresa);

        nuValorCupon := inuValorCupon;
        nuValorCupon := round( nuValorCupon, nuFactorRedondeo );

        -- Genera cupon
        nuPaso := 10;
        proGeneraCupon(inuProyecto        => inuProyecto,
                       inuValor           => nuValorCupon,
                       onuCuponGenerado   => onuCupon,
                       onuFacturaGenerada => nuFactura);

        -- Registra cuota adicional
        nuPaso := 20;
        proCreaCuotaAdicional(inuProyecto   => inuProyecto,
                              inuValorCupon => nuValorCupon,
                              isbTipoCuota  => isbTipoCuota,
                              inuCupon      => onuCupon,
                              onuCuota      => onuCuota);

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proCreaValorAdicional(inuProyecto     ldc_valor_adicional_proy.id_proyecto%TYPE, -- Proyecto
                                    inuValor        ldc_valor_adicional_proy.valor%TYPE, -- Valor adicional
                                    inuCosto        ldc_valor_adicional_proy.valor_costo%TYPE, --Costo adicional
                                    isbObservacion  ldc_valor_adicional_proy.observacion%TYPE, --Observacion
                                    inuCupon        ldc_cuotas_adicionales.cupon%TYPE -- Cupon
                                    ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaValorAdicional
        Descripcion:        Crea el valor adicional en LDC_VALOR_ADICIONAL_PROY

        Autor    : KCienfuegos
        Fecha    : 07-07-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        07-07-2016   KCienfuegos           Creacion
        ******************************************************************/

        sbProceso                VARCHAR2(4000) := csbPaquete||'proCreaValorAdicional';
        nuPaso                   NUMBER;
        sbError                  VARCHAR2(4000);
        rcValorAdic              daldc_valor_adicional_proy.styLDC_VALOR_ADICIONAL_PROY;

    BEGIN
        pkg_traza.trace(sbProceso, cnuNVLTRC, csbInicio);

        -- Construye el registro
        nuPaso                 := 10;
        rcValorAdic.consecutivo    := seq_ldc_valor_adicional_proy.nextval;
        nuPaso                 := 20;
        rcValorAdic.id_proyecto    := inuProyecto;
        nuPaso                 := 30;
        rcValorAdic.valor          := inuValor;
        nuPaso                 := 40;
        rcValorAdic.cupon      := inuCupon;
        nuPaso                 := 50;
        rcValorAdic.valor_costo := inuCosto;
        nuPaso                 := 60;
        rcValorAdic.observacion := isbObservacion;
        nuPaso                 := 70;
        rcValorAdic.fecha_registro := SYSDATE;
        nuPaso                 := 80;
        rcValorAdic.usuario    := USER;

        daldc_valor_adicional_proy.insRecord(rcValorAdic);

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
               pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proRegistraValorAdicional(inuProyecto       ldc_cuotas_adicionales.id_proyecto%TYPE, -- Proyecto
                                        inuValor          ldc_valor_adicional_proy.valor%TYPE, -- Valor adicional
                                        inuCosto          ldc_valor_adicional_proy.valor_costo%TYPE, --Valor Costo
                                        isbObservacion    ldc_valor_adicional_proy.observacion%TYPE, --Observacion
                                        isbConcepto       concepto.conccodi%type, --Concepto
                                        onuCupon    OUT   ldc_cuotas_adicionales.cupon%TYPE -- Cupon
                                        ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proRegistraValorAdicional
        Descripcion:        Genera el valor adicional

        Autor    : KCienfuegos
        Fecha    : 06-07-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        06-07-2016   KCienfuegos           Creacion.
        22/10/2016    JOSH BRITO           CASO 200-2022 Si aplica para la gasera, se tomara el concepto de les parametro de entrada
        ******************************************************************/

        sbProceso                 VARCHAR2(4000) := csbPaquete||'proRegistraValorAdicional';
        nuPaso                    NUMBER;
        sbError                   VARCHAR2(4000); -- Error
        rcValorAdicional          daldc_valor_adicional_proy.styLDC_VALOR_ADICIONAL_PROY;
        nuValor                   ldc_valor_adicional_proy.valor%TYPE;
        nuProducto                pr_product.product_id%TYPE;
        nuContrato                suscripc.susccodi%TYPE;
        nuCuenta                  cuencobr.cucocodi%TYPE;
        nuFactura                 factura.factcodi%TYPE;
        nuConcepto                concepto.conccodi%TYPE;
        nuPlanId                  plandife.pldicodi%TYPE;
        nuMetCalculo              mecadife.mcdicodi%TYPE;
        nuDifeCofi                diferido.difecofi%TYPE;
        nuDifecodi                diferido.difecodi%TYPE;
        nuCuentaDifCorr           cuencobr.cucocodi%TYPE;
        nuFactDifCorr             factura.factcodi%TYPE;
        nuCucovato                cuencobr.cucovato%TYPE;
        nuCotizacionOsf           cc_quotation.quotation_id%TYPE;
        nuNroCuotas               NUMBER;
        nuSaldo                   NUMBER;
        nuTotalAcumCapital        NUMBER;
        nuTotalAcumCuotExtr       NUMBER;
        nuTotalAcumInteres        NUMBER;
        sbRequiereVisado          VARCHAR2(20);
        sbPrograma                VARCHAR2(10) := 'FRVAD';

        CURSOR cuObtDiferido IS
          SELECT difecodi
            FROM diferido
           WHERE difenuse = nuProducto
             AND difecofi = nuDifeCofi
           ORDER BY difecodi DESC;

         CURSOR cuObtCuentaDiferido IS
          SELECT DISTINCT cargcuco
            FROM cargos
           WHERE cargnuse =  nuProducto
             AND trunc(cargfecr) = trunc(SYSDATE)
             AND cargsign = 'DB'
             AND cargdoso = 'DF-'||nuDifecodi
             AND cargcaca = dald_parameter.fnuGetNumeric_Value('CAUSCAR_CANC_DIFERIDO', 0)
             AND cargcuco<>-1
             AND cargvalo>0;

             nuFinan number;

        CURSOR cuConcIva IS
         SELECT cb.COBLCONC
         FROM CONCBALI cb, concepto c
         where cb.COBLCOBA = isbConcepto
          and cb.COBLCONC = c.CONCCODI
          and CONCTICL = 4;

      CURSOR cuValorIva(nucuenta cuencobr.cucocodi%type, nuconcepto number) IS
      SELECT NVL(SUM(DECODE(cargsign, 'DB', CARGVALO, 'CR', -CARGVALO)),0)
      FROM cargos c
      WHERE c.cargcuco = nucuenta
       and cargconc = nuconcepto
       ;

        nuConcIvA number;
        nuValorIva number;
        nuvalornota number;
        nuValorIvaCU NUMBER;

		sbObserNota VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_OBSENODE', NULL);

    BEGIN
        pkg_traza.trace(sbProceso, cnuNVLTRC, csbInicio);

        pkErrors.SetApplication(sbPrograma);

        -- Se valida la correcta configuracion del parametro
        IF(gnuCausNotaDebito IS NULL)THEN
          pkg_error.setErrorMessage(cnuDescripcionError, 'El valor numerico del parametro CAUS_NOTA_DEB_ADIC no ha sido configurado correctamente');
          RAISE pkg_error.controlled_error;
        END IF;

        -- Se obtiene el contrato
        nuContrato := daldc_proyecto_constructora.fnuGetSUSCRIPCION(inuID_PROYECTO => inuProyecto);

        -- Se obtiene el producto
        nuProducto := ldc_bcventaconstructora.fnuProdGenericoProyecto(inuProyecto => inuProyecto);

        nuValor := inuValor;

        fa_bopoliticaredondeo.aplicapolitica(nuProducto,nuValor);

        -- Se obtiene el concepto
        IF FBLAPLICAENTREGAXCASO('200-2022') THEN
          nuConcepto := isbConcepto;
        ELSE
          nuConcepto := daor_task_type.fnugetconcept(gnuTipoTrabInterna,0);
        END IF;
        nuValorIvaCU :=0;
        -- Se obtiene la cotizacion de OSF
        nuCotizacionOsf := ldc_bcventaconstructora.fnuCotizOsfxProyecto(inuProyecto);

        SELECT COUNT(*) INTO nuFinan
        FROM cc_quot_financ_cond
        WHERE QUOTATION_ID = nuCotizacionOsf;

        IF nuFinan > 0 THEN
           nuPlanId := dacc_quot_financ_cond.fnugetfinancing_plan_id(inuQuotation_Id => nuCotizacionOsf);
           nuMetCalculo := dacc_quot_financ_cond.fnugetcompute_method_id(inuQuotation_Id => nuCotizacionOsf);
        ELSE
           IF(gnuPlanDife IS NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, 'El valor numerico del parametro PLAN_FINAN_DIF_VALADIC no ha sido configurado correctamente');
              RAISE pkg_error.controlled_error;
           END IF;

           nuPlanId := gnuPlanDife;

           IF(gnuMetodCalculo IS NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, 'El valor numerico del parametro METCAL_VAL_ADIC_CONST no ha sido configurado correctamente');
              RAISE pkg_error.controlled_error;
           END IF;

           nuMetCalculo := gnuMetodCalculo;
        END IF;

        -- Se crea la cuenta de cobro
        proCreaCuentaCobro(nuProducto,
                           nuContrato,
                           nuCuenta,
                           nuFactura);


        nuvalornota  := round(  nuValor / (1 + (funCalculaIva (nuConcepto) / 100 ) ),0);
        nuValorIva :=  nuValor - nuvalornota;

        IF nuValorIva > 0 THEN
           OPEN cuConcIva;
           FETCH  cuConcIva INTO nuConcIvA;
           CLOSE cuConcIva;
           --se registra nota de iva
           proRegistraNotaDebito(nuProducto,
                               nuContrato,
                               nuCuenta,
                               nuConcIvA,
                               gnuCausNotaDebito,
                               sbObserNota,--'Anulacion de unidad predial',
                               nuValorIva);

        END IF;

                -- Se registra la nota debito
        proRegistraNotaDebito(nuProducto,
                               nuContrato,
                               nuCuenta,
                               nuConcepto,
                               gnuCausNotaDebito,
                               sbObserNota,--'Anulacion de unidad predial',
                               nuvalornota);

         OPEN cuValorIva(nuCuenta, nuConcIvA);
         FETCH cuValorIva INTO nuValorIvaCU;
         CLOSE cuValorIva;

        UPDATE cuencobr SET  CUCOIMFA = nuValorIvaCU WHERE cucocodi = nuCuenta;

        nuFactDifCorr := pktblcuencobr.fnugetcucofact(nuCuenta,0);
        nuCucovato    := pktblcuencobr.fnugetcucovato(nuCuenta,0);



        IF (nuFactDifCorr IS NOT NULL)THEN

        -- Se genera el cupon
        pkCouponMgr.GenerateCouponService(isbTipo       => csbTipoCupon,
                                 isbDocumento  => nuFactDifCorr,
                                 inuValor      => nuCucovato,
                                 inuCuponPadre => NULL,
                                 idtCupoFech   => NULL,
                                 onuCuponCurr  => onuCupon);
        END IF;


        -- Se registra el valor adicional en la tabla correspondiente
        proCreaValorAdicional(inuProyecto,
                              nuValor,
                              inuCosto,
                              isbObservacion,
                              onuCupon);

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;
    END;

    PROCEDURE proCreaDetalleActa(inuProyecto   ldc_actas_proyecto.id_proyecto%TYPE, -- Proyecto
                                 inuCuota      ldc_actas_proyecto.id_cuota%TYPE, -- Cuota
                                 inuTipoTrab   ldc_actas_proyecto.tipo_trabajo%TYPE, -- Tipo de trabajo
                                 inuValorUnit  ldc_actas_proyecto.valor_unit%TYPE, -- Valor unitario
                                 inuCantidad   ldc_actas_proyecto.cant_trabajo%TYPE, -- Cantidad
                                 inuValorTotal ldc_actas_proyecto.valor_total%TYPE -- Valor total
                                 ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaDetalleActa
        Descripcion:        Genera el registro en el acta

        Autor    : Sandra Mu?oz
        Fecha    : 17-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        17-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso   VARCHAR2(4000) := csbPaquete||'proCreaDetalleActa';
        nuPaso      NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError     VARCHAR2(4000); -- Error
        nuExiste    NUMBER; -- Existe un registro
        sbTipoCuota ldc_cuotas_adicionales.tipo_cuota%TYPE; -- Cuota adicional

        rcDetalle daldc_actas_proyecto.styLDC_ACTAS_PROYECTO; -- REgistro a insertar
		
		CURSOR cuTipoCuota(	nuCuota ldc_cuotas_adicionales.consecutivo%TYPE,
							nuProyecto ldc_cuotas_adicionales.id_proyecto%TYPE)is
            SELECT lca.tipo_cuota
            FROM   ldc_cuotas_adicionales lca
            WHERE  lca.consecutivo = nuCuota
            AND    lca.id_proyecto = nuProyecto;
		
		CURSOR cuConsecActa(nuProyecto ldc_actas_proyecto.id_proyecto%TYPE)IS
			SELECT nvl(MAX(lap.Id_Acta), 0)
			FROM   ldc_actas_proyecto lap
			WHERE  lap.id_proyecto = nuProyecto;


		CURSOR cuExisteCuota(nuCuota ldc_actas_proyecto.id_cuota%TYPE,
							 nuProyecto ldc_actas_proyecto.id_proyecto%TYPE)IS
			SELECT COUNT(1)
			FROM   ldc_actas_proyecto lap
			WHERE  lap.id_proyecto = nuProyecto
			AND    lap.id_cuota = nuCuota;



    BEGIN
        pkg_traza.trace(sbProceso, cnuNVLTRC, csbInicio);

        nuPaso := 10;
        BEGIN
		
			IF cuTipoCuota%ISOPEN THEN
				CLOSE cuTipoCuota;
			END IF;
			
			OPEN cuTipoCuota(inuCuota,inuProyecto);
			FETCH cuTipoCuota INTO sbTipoCuota;
			IF cuTipoCuota%NOTFOUND then
				CLOSE cuTipoCuota;
				RAISE NO_DATA_FOUND;
			END IF;
			CLOSE cuTipoCuota;
		
        EXCEPTION
            WHEN no_data_found THEN
                sbError := 'No fue posible obtener la informacion de la cuota ' || inuCuota ||
                           ' para el proyecto ' || inuProyecto || '. ' || SQLERRM;
                RAISE pkg_error.controlled_error;
        END;

        IF sbTipoCuota = csbCuotaExtraordinaria THEN
            sbError := 'No se permite generar actas para cuotas extraordinarias';
            RAISE pkg_error.controlled_error;
        END IF;

        nuPaso                := 15;
        rcDetalle.consecutivo := seq_ldc_actas_proyecto.nextval;

        -- Calcular el consecutivo del acta
        nuPaso := 20;

		IF cuConsecActa%ISOPEN THEN
				CLOSE cuConsecActa;
		END IF;
			
		OPEN cuConsecActa(inuProyecto);
		FETCH cuConsecActa INTO rcDetalle.id_acta;
		CLOSE cuConsecActa;
		

        nuPaso := 30;

		IF cuExisteCuota%ISOPEN THEN
				CLOSE cuExisteCuota;
		END IF;
			
		OPEN cuExisteCuota(inuCuota,inuProyecto);
		FETCH cuExisteCuota INTO nuExiste;
		CLOSE cuExisteCuota;

        IF nuExiste = 0 THEN
            nuPaso            := 40;
            rcDetalle.id_acta := rcDetalle.id_acta + 1;
        END IF;

        nuPaso                   := 50;
        rcDetalle.id_proyecto    := inuProyecto;
        nuPaso                   := 60;
        rcDetalle.id_cuota       := inuCuota;
        nuPaso                   := 70;
        rcDetalle.fecha_registro := SYSDATE;
        nuPaso                   := 80;
        rcDetalle.tipo_trabajo   := inuTipoTrab;
        nuPaso                   := 90;
        rcDetalle.valor_unit     := inuValorUnit;
        nuPaso                   := 100;
        rcDetalle.cant_trabajo   := inuCantidad;
        nuPaso                   := 110;
        rcDetalle.valor_total    := inuValorTotal;

        -- Almacenar el registro
        nuPaso := 120;
        BEGIN
            daldc_actas_proyecto.insRecord(ircldc_actas_proyecto => rcDetalle);
        EXCEPTION
            WHEN OTHERS THEN
                sbError := SQLERRM;
                RAISE pkg_error.controlled_error;
        END;

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proImprimeActa(inuProyecto ldc_cuotas_adicionales.id_proyecto%TYPE, -- Proyecto
                             inuCuota    ldc_cuotas_adicionales.consecutivo%TYPE, -- Cuota
                             isbRuta     VARCHAR2 -- Ruta en la que se almacenara el archivo PDF
                             ) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proImprimeActa
        Descripcion:        Impresion del acta

        Autor    : Sandra Mu?oz
        Fecha    : 21-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        21-06-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso    VARCHAR2(4000) := csbPaquete||'proImprimeActa';
        nuPaso       NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError      VARCHAR2(4000);
        nuEjecutable sa_executable.executable_id%TYPE; -- Codigo del ejecutable
        -- Datos para la impresion
        nuPosInstance     NUMBER;
        sbEvent           VARCHAR2(100) := 'POST_REGISTER';
        rcDatos           Dald_Temp_Clob_Fact.styLD_temp_clob_fact;
        nuFormatoActa     ed_formato.formcodi%TYPE; -- Formato acta
        nuExiste          NUMBER; -- Indica si existe un elemento
        sbNombreArchivo   VARCHAR2(4000);
        nuActa            ldc_actas_proyecto.id_acta%TYPE; -- Acta
        nuConsecutivoActa ldc_actas_proyecto.consecutivo%TYPE; -- Consecutivo acta
        nuProyecto        ldc_proyecto_constructora.id_proyecto%TYPE;
        nuCuota           ldc_cuotas_adicionales.consecutivo%TYPE;
        sbID_CUOTA        ge_boInstanceControl.stysbValue;
        sbCurrentInstance ge_boInstanceControl.stysbValue;
        nuInteg           NUMBER;

		CURSOR cuExisFormato(inuFormatoActa ed_formato.formcodi%TYPE)IS
		    SELECT COUNT(1) 
			FROM ed_formato ef 
			WHERE ef.formcodi = inuFormatoActa;

		CURSOR cuConsecActa(inuCuota ldc_actas_proyecto.id_cuota%TYPE,
							inuProyecto ldc_actas_proyecto.id_proyecto%TYPE)IS
			SELECT MIN(lap.consecutivo),
				   MIN(lap.id_acta)
			FROM   ldc_actas_proyecto lap
			WHERE  lap.id_cuota = inuCuota
			AND    lap.id_proyecto = inuProyecto;

		CURSOR cuExisPlantilla(inuPlantilla ed_plantill.plannomb%TYPE)IS
			SELECT COUNT(1)
			FROM   ed_plantill ep
			WHERE  ep.plannomb = inuPlantilla;

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        nuProyecto := inuProyecto;
        nuCuota    := inuCuota;

        IF (nuProyecto IS NULL AND nuCuota IS NULL) THEN

            GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbCurrentInstance);

            IF GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbCurrentInstance,
                                                            NULL,
                                                            'LDC_ACTAS_PROYECTO',
                                                            'ID_CUOTA',
                                                            nuInteg) THEN
                sbID_CUOTA := ge_boInstanceControl.fsbGetFieldValue('LDC_ACTAS_PROYECTO',
                                                                    'ID_CUOTA');
                ------------------------------------------------
                -- Required Attributes
                ------------------------------------------------
                IF (sbID_CUOTA IS NULL) THEN
                    sbError := 'El id de la cuota es nulo';
                    RAISE pkg_error.controlled_error;
                END IF;

                nuCuota := to_number(sbID_CUOTA);

                nuProyecto := daldc_cuotas_adicionales.fnuGetID_PROYECTO(inuCONSECUTIVO => nuCuota);
            ELSE
                sbError := 'El id de la cuota no esta instanciado';
                RAISE pkg_error.controlled_error;
            END IF;

        END IF;

        pkg_traza.trace('nuProyecto ' || nuProyecto, cnuNVLTRC);
        pkg_traza.trace('nuCuota ' || nuCuota, cnuNVLTRC);
        pkg_traza.trace('isbRuta ' || isbRuta, cnuNVLTRC);

        -- Construir el registro para insertar en LDC_TEMP_CLOB_FACT que es donde se toma la informacion
        -- para luego imprimir
        nuPaso                    := 10;
        rcDatos.temp_clob_fact_id := LD_BOSequence.Fnuseqld_temp_clob_fact;
        nuPaso                    := 20;
        rcDatos.sesion            := userenv('SESSIONID');

        -- Obtener el codigo de extraccion y mezcla
        nuPaso := 30;
        BEGIN
            nuFormatoActa := Dald_Parameter.fnuGetNumeric_Value(inuparameter_id => 'FORMATO_ACTA_CONSTRUCTORA');
        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible obtener el valor del parametro FORMATO_ACTA_CONSTRUCTORA';
                RAISE pkg_error.controlled_error;
        END;

        nuPaso := 40;
        IF nuFormatoActa IS NULL THEN
            sbError := 'No se encontro valor numerico para el parametro FORMATO_ACTA_CONSTRUCTORA';
            RAISE pkg_error.controlled_error;
        END IF;

        nuPaso := 50;
 
		IF cuExisFormato%ISOPEN THEN
			CLOSE cuExisFormato;
		END IF;
		
		OPEN cuExisFormato(nuFormatoActa);
		FETCH cuExisFormato INTO nuExiste;
		CLOSE cuExisFormato;
		

        IF nuExiste = 0 THEN
            sbError := 'No se encontro el formato ' || nuFormatoActa;
            RAISE pkg_error.controlled_error;
        END IF;

        nuPaso := 60;
        pkg_traza.trace('inuCuota ' || nuCuota, cnuNVLTRC);
        pkg_traza.trace('PKBODATAEXTRACTOR.INSTANCEBASEENTITY(' || nuCuota ||
                       ', LDC_CUOTAS_ADICIONALES,  constants_per.GetTrue  );',
                       cnuNVLTRC);

		IF cuConsecActa%ISOPEN THEN
			CLOSE cuConsecActa;
		END IF;
		
		OPEN cuConsecActa(nuCuota,nuProyecto);
		FETCH cuConsecActa INTO nuConsecutivoActa,nuActa;
		CLOSE cuConsecActa;
		

        pkg_traza.trace('nuConsecutivoActa ' || nuConsecutivoActa, cnuNVLTRC);

        BEGIN
            nuPaso := 65;
            PKBODATAEXTRACTOR.INSTANCEBASEENTITY(nuConsecutivoActa,
                                                 'LDC_ACTAS_PROYECTO',
                                                 constants_per.GetTrue);
        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'Error al ejecutar PKBODATAEXTRACTOR.INSTANCEBASEENTITY ' || SQLERRM;
                RAISE pkg_error.controlled_error;
        END;

        nuPaso := 70;
        pkBODataExtractor.ExecuteRules(inuformatcode => nuFormatoActa,
                                       oclclobdata   => rcDatos.docudocu);

        -- Insertar en la tabla temporal
        nuPaso := 80;
        Dald_Temp_Clob_Fact.insRecord(ircld_temp_clob_fact => rcDatos);

        pkg_traza.trace('rcDatos.temp_clob_fact_id  ' || rcDatos.temp_clob_fact_id,cnuNVLTRC);
        pkg_traza.trace('rcDatos.temp_clob_fact_id  ' || rcDatos.temp_clob_fact_id,cnuNVLTRC);

        COMMIT;

        -- Obtener el nombre del formato de acta
        nuPaso := 90;
        BEGIN
            ld_bosubsidy.globalsbTemplate := Dald_Parameter.fsbGetValue_Chain(inuparameter_id => 'PLANTILLA_ACTA_CONSTRUCTORA');
        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible obtener el valor del parametro PLANTILLA_ACTA_CONSTRUCTORA';
                RAISE pkg_error.controlled_error;
        END;

        nuPaso := 100;
        IF ld_bosubsidy.globalsbTemplate IS NULL THEN
            sbError := 'No se encontro valor numerico para el parametro PLANTILLA_ACTA_CONSTRUCTORA';
            RAISE pkg_error.controlled_error;
        END IF;

        nuPaso := 110;

		IF cuExisPlantilla%ISOPEN THEN
			CLOSE cuExisPlantilla;
		END IF;
		
		OPEN cuExisPlantilla(ld_bosubsidy.globalsbTemplate);
		FETCH cuExisPlantilla INTO nuExiste;
		CLOSE cuExisPlantilla;

        IF nuExiste = 0 THEN
            sbError := 'No se encontro la plantilla  ' || ld_bosubsidy.globalsbTemplate;
            RAISE pkg_error.controlled_error;
        END IF;

        -- Construir el nombre del archivo

        sbNombreArchivo := 'ACTA_' || nuProyecto || '_' || nuActa;

        -- Imprimir acta
        nuPaso := 120;
        Ld_BoSubsidy.ProcExportBillDuplicateToPDF(isbsource   => isbRuta,
                                                  isbfilename => sbNombreArchivo,
                                                  iclclob     => rcDatos.docudocu);

        nuPaso       := 140;
        nuEjecutable := sa_boexecutable.fnuGetExecutableIdbyName('EXME', FALSE);

        nuPaso := 150;

        IF (NOT GE_BOInstanceControl.fblIsInitInstanceControl) THEN
            GE_BOInstanceControl.InitInstanceManager;
        END IF;

        nuPaso := 160;
        IF (NOT GE_BOInstanceControl.fblAcckeyInstanceStack('WORK_INSTANCE', nuPosInstance)) THEN
            GE_BOInstanceControl.CreateInstance('WORK_INSTANCE', NULL);
        END IF;

        nuPaso := 170;
        GE_BOInstanceControl.AddAttribute('WORK_INSTANCE',
                                          NULL,
                                          'IOPENEXECUTABLE',
                                          sbEvent,
                                          nuEjecutable);

        nuPaso := 180;
        Ld_Bosubsidy.Callapplication('EXME');

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proImprimeCupon IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proImprimeCupon
        Descripcion:        Imprime un cupon. Se utiliza desde la forma LDCIC

        Autor    : KCienfuegos
        Fecha    : 22-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        22-06-2016   KCienfuegos           Creacion
        ******************************************************************/
        sbProceso    VARCHAR2(4000) := csbPaquete||'proImprimeCupon';
        sbCUPONUME   ge_boInstanceControl.stysbValue;
        nuCupon      cupon.cuponume%TYPE;
        nuEjecutable sa_executable.executable_id%TYPE;
        -- Datos para la impresion
        nuPosInstance NUMBER;
        sbEvent       VARCHAR2(100) := 'POST_REGISTER';
        nuPaso        NUMBER;
        sbError       VARCHAR2(4000);

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        sbCUPONUME := ge_boInstanceControl.fsbGetFieldValue('CUPON', 'CUPONUME');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------
        IF (sbCUPONUME IS NULL) THEN
            pkg_error.setErrorMessage(cnuNULL_ATTRIBUTE, 'Numero de Cupon');
            RAISE pkg_error.controlled_error;
        END IF;

        nuCupon := to_number(sbCUPONUME);
        proImprimeCupon(inuCupon => nuCupon);

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proReImprimeActa IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proReImprimeActa
        Descripcion:        Imprime un cupon. Se utiliza desde la forma LDCRA

        Autor    : KCienfuegos
        Fecha    : 22-06-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        22-06-2016   KCienfuegos           Creacion
        ******************************************************************/
        sbProceso    VARCHAR2(4000) := csbPaquete||'proReImprimeActa';
        nuEjecutable sa_executable.executable_id%TYPE;
        -- Datos para la reimpresion
        nuPosInstance NUMBER;
        sbEvent       VARCHAR2(100) := 'POST_REGISTER';
        nuPaso        NUMBER;
        sbError       VARCHAR2(4000);

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------
        nuEjecutable := sa_boexecutable.fnuGetExecutableIdbyName('FIAC', FALSE);

        IF (NOT GE_BOInstanceControl.fblIsInitInstanceControl) THEN
            GE_BOInstanceControl.InitInstanceManager;
        END IF;

        IF (NOT GE_BOInstanceControl.fblAcckeyInstanceStack('WORK_INSTANCE', nuPosInstance)) THEN
            GE_BOInstanceControl.CreateInstance('WORK_INSTANCE', NULL);
        END IF;

        GE_BOInstanceControl.AddAttribute('WORK_INSTANCE',
                                          NULL,
                                          'IOPENEXECUTABLE',
                                          sbEvent,
                                          nuEjecutable);

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proObtCorreoPrinYCopia(isbCadenaCorreos IN ld_parameter.value_chain%TYPE,
                                     osbCorreoPpal    OUT VARCHAR2,
                                     osbCorreosSec    OUT VARCHAR2) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proObtCorreoPrinYCopia
        Descripcion:        Se obtiene correo principal y secundario

        Autor    : KCienfuegos
        Fecha    : 18-08-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        18-08-2016  KCienfuegos           Creacion
        ******************************************************************/
        sbProceso                         VARCHAR2(4000) := csbPaquete||'proObtCorreoPrinYCopia';
        nuPaso                            NUMBER;
        sbError                           VARCHAR2(4000);
        blPrincipalDest                   BOOLEAN := TRUE;

        CURSOR cuEmails IS
		    SELECT regexp_substr(isbCadenaCorreos, '[^;]+', 1, LEVEL)AS EMAIL
			FROM dual
			CONNECT BY regexp_substr(isbCadenaCorreos, '[^;]+', 1, LEVEL) IS NOT NULL;


    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        FOR I IN cuEmails LOOP
            IF blPrincipalDest THEN
              osbCorreoPpal := I.EMAIL;
              blPrincipalDest := FALSE;
            ELSE
              osbCorreosSec := I.EMAIL ||','||osbCorreosSec;
            END IF;
        END LOOP;

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

    PROCEDURE proPlantilla(nuDato NUMBER) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:
        Descripcion:

        Autor    : Sandra Mu?oz
        Fecha    : 31-05-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        31-05-2016   Sandra Mu?oz           Creacion
        ******************************************************************/

        sbProceso VARCHAR2(4000) := csbPaquete||'proPlantilla';
        nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        sbError   VARCHAR2(4000);

        exError EXCEPTION; -- Error controlado

    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            RAISE pkg_error.controlled_error;
    END;

    ------------------------------------------------------------------------------------------------
    -- Calcula Iva
    ------------------------------------------------------------------------------------------------
    FUNCTION funCalculaIva(isbConcepto       concepto.conccodi%type ) RETURN number is
     /*****************************************************************
         Propiedad intelectual de HORBATH.

         Nombre del Paquete: funCalculaIva
         Descripcion:        Retorna los registros a procesar en la forma LDCAPS

         Autor    : JBRITO
         Fecha    : 22/10/2018

         Historia de Modificaciones

         DD-MM-YYYY    <Autor>.              Modificacion
         -----------  -------------------    -------------------------------------
         22/10/2018    JBRITO                Creacion
        ******************************************************************/


        sbProceso     VARCHAR2(4000) := csbPaquete||'funCalculaIva';
        nuPaso        NUMBER;
        sbError       VARCHAR2(4000);
        countIva      number;

        nuConcepto    NUMBER;

        cursor cuValorIva IS
        SELECT RAVPPORC
        FROM Ta_Rangvitp
        WHERE RAVPVITP = ( SELECT MAX(VITPCONS)
                          FROM   Ta_Vigetacp D
                          WHERE  D.Vitptipo = 'B'
                            AND SYSDATE BETWEEN VITPFEIN AND  VITPFEFI
                            AND Vitptacp IN (  SELECT TACPCONS
                                              FROM  Ta_Taricopr A, TA_PROYTARI b
                                              WHERE  a.tacpprta = b.prtacons
											    and b.prtaesta in (2,3)
											    and a.Tacpcotc =  (select MAX(COTCCONS)
                                                                  from TA_CONFTACO
                                                                where COTCCONC = nuConcepto and COTCVIGE ='S' AND SYSDATE BETWEEN COTCFEIN AND COTCFEFI)));

	CURSOR cuConcepto(sbConcepto CONCBALI.COBLCOBA%TYPE)IS
        SELECT cb.COBLCONC 
         FROM CONCBALI cb, concepto c
         where cb.COBLCOBA = sbConcepto
          and cb.COBLCONC = c.CONCCODI
          and CONCTICL = 4;

    BEGIN
     BEGIN

		IF cuConcepto%ISOPEN THEN
			CLOSE cuConcepto;
		END IF;
		
		OPEN cuConcepto(isbConcepto);
		FETCH cuConcepto INTO nuConcepto;
		IF cuConcepto%NOTFOUND THEN
			CLOSE cuConcepto;
			RAISE NO_DATA_FOUND;
        END IF;
        CLOSE cuConcepto;
			
        EXCEPTION
         WHEN NO_DATA_FOUND THEN
             nuConcepto := 0;
      END;

      IF nuConcepto > 0 THEN
        open cuValorIva;
        fetch cuValorIva into countIva;
        if cuValorIva%NOTFOUND THEN
           countIva :=0;
        END IF;
        close cuValorIva;

      ELSE
        countIva := 0;
      END IF;

      RETURN countIva;

     EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
             pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;

     PROCEDURE proImprimeCuponM(inuCupon IN cupon.cuponume%TYPE, -- Cupon
                              isbFecha  IN DATE,
                                inuProyecto IN NUMBER,
                              inuRuta     in varchar2) IS

        /*****************************************************************
        Propiedad intelectual de Horbath.

        Nombre del Paquete:  proImprimeCupon
        Descripcion:         Imprime el cupon a un PDF. Se toma como muestra el codigo de
                             LDC_BOIMPFACTURACONSTRUCTORA.Insertbillclob

        Autor    : Sandra Mu?oz
        Fecha    : 19/0/2019

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        19/03/2019   josh brito           Creacion
        ******************************************************************/

        nuError            NUMBER;
        sbError            VARCHAR2(4000);
        nuFactura          factura.factcodi%TYPE; -- Factura generada
        nuPaso             NUMBER; -- Ultimo paso ejecutado antes del error
        sbProceso          VARCHAR2(4000) := csbPaquete||'proImprimeCupon';
        rcFactura          FACTURA%ROWTYPE;
        rcContrato         SUSCRIPC%ROWTYPE;
        nuConfexme         ed_confexme.coemcodi%TYPE;
        nuCodigoFormato    ED_FORMATO.FORMCODI%TYPE;
        rcConfexme         pktbled_confexme.cuEd_Confexme%rowtype;
        CLCLOBDATA CLOB;

		CURSOR cuFactura(nuCupon cupon.cuponume%TYPE)IS
          SELECT c.cupodocu
            FROM cupon c
           WHERE c.cuponume = nuCupon;


    BEGIN
        pkg_traza.trace(sbProceso,cnuNVLTRC,csbInicio);

        nuPaso := 10;

        -- Verifica que el cupon exista.
        pktblCupon.acckey(inuCupon);

        -- Obtener la factura asociada al cupon
        BEGIN
		
		IF cuFactura%ISOPEN THEN
			CLOSE cuFactura;
		END IF;
		
		OPEN cuFactura(inuCupon);
		FETCH cuFactura INTO nuFactura;
		IF cuFactura%NOTFOUND THEN
			CLOSE cuFactura;
			RAISE NO_DATA_FOUND;
		END IF;
		CLOSE cuFactura;	
		
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            sbError :='No se encontro cupon con codigo '||inuCupon;
            RAISE pkg_error.controlled_error;
        END;

        -- Se obtiene registro de factura
        rcFactura := pktblfactura.frcgetrecord( nuFactura );

        -- Se obtiene registro de contrato
        rcContrato := pktblsuscripc.frcgetrecord( rcFactura.factsusc );

        nuPaso     := 20;

        nuConfexme := dald_parameter.fnuGetNumeric_Value('CONFEXME_FACTURA_CONSTRUCTORA', 0);

        -- Obtiene el registro del tipo de formato de extraccion y mezcla
        pkBCED_Confexme.ObtieneRegistro
        (
            nuConfexme,
            rcConfexme
        );


        nuCodigoFormato :=  pkbced_formato.fnugetformcodibyiden(rcConfexme.coempada);

        pkbodataextractor.instancebaseentity(rcFactura.factcodi,'FACTURA', constants_per.GetTrue);

        nuPaso := 30;
        -- Ejecuta proceso de extraccion de datos para formato digital
        pkBODataExtractor.ExecuteRules( nuCodigoFormato, CLCLOBDATA );

        nuPaso := 40;
        -- Se genera el archivo
        pkBOPrintingProcess.Generateclob(Inubillingperiod => rcFactura.FACTPEFA,
                                         Inudocumentnumber => rcFactura.FACTCODI,
                                         Inudocumenttype => ge_boconstants.fnugetdoctypecons,
                                         Iclclob => CLCLOBDATA);


         -- Instancia el numero del cupon a imprimir
        pkBOED_DocumentMem.Set_PrintDocId(inuCupon);

        nuPaso := 50;
        -- Se setea el archivo a imprimir
        pkboed_documentmem.Set_PrintDoc( clClobData );

        nuPaso := 60;
        -- Almacena en memoria la plantilla para extraccion y mezcla
        pkboed_documentmem.SetTemplate( rcConfexme.coempadi );

        if clClobData IS NOT NULL THEN
          -- Instancia informacion basica para extraccion y mezcla a partir de un archivo XML
          pkBOED_DocumentMem.SetBasicDataExMe(inuruta, 'Cupon_'|| TO_CHAR(isbFecha,'ddmmyyyy')||'_'||inuProyecto);
        End if;

        nuPaso := 70;
        -- Se envia a imprimir en pantalla
        ge_boiopenexecutable.printpreviewerrule();

        pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||sbError,cnuNVLTRC); 
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            IF(sbError IS NOT NULL)THEN
              pkg_error.setErrorMessage(cnuDescripcionError, sbError);
            END IF;
            RAISE pkg_error.controlled_error;

        WHEN OTHERS THEN
            pkg_traza.trace(sbProceso||': '||'(' || nuPaso || '):' ||SQLERRM,cnuNVLTRC);
			pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            RAISE pkg_error.controlled_error;

    END;


  PROCEDURE procinserinfphon
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Generateventfor
    Descripcion    : Procedimiento que inserta los valores de telefonos en la tabla
    Autor          : Karem Baquero
    Fecha          : 27/08/2016 ERS 200-465

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================

    ******************************************************************/
  (sbcadena        in ld_parameter.value_chain%type,
   nuTelG          in number,
   onuErrorCode    out number,
   osbErrorMessage out varchar2) IS

    /*se inserta en la tabla los valores de */
  begin

    insert into LDC_VENFORMASITELE

      (SELECT nuTelG,
              substr(sbcadena, 1, instr(sbcadena, ',', 1, 1) - 1) phone_id,
              substr(sbcadena, instr(sbcadena, ',', 1, 1) + 1) phone
         from dual);
    /*commit;*/

  EXCEPTION
    when pkg_error.controlled_error then
      rollback;
      raise pkg_error.controlled_error;
    when others then
      rollback;
      pkg_error.setError;
      raise pkg_error.controlled_error;

  end procinserinfphon;

  --********************************************************************************************
  --------------------------------------------------------------

  PROCEDURE procinserinfref
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Generateventfor
    Descripcion    : Procedimiento que inserta los valores de referencia en la tabla
    Autor          : Karem Baquero
    Fecha          : 27/08/2016 ERS 200-465

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================

    ******************************************************************/
  (sbcadena        in ld_parameter.value_chain%type,
   nuRefGP         in number,
   onuErrorCode    out number,
   osbErrorMessage out varchar2) IS

    /*se inserta en la tabla los valores de */
  begin
    insert into LDC_VENFORMASIREF
      (SELECT nuRefGP,
              substr(sbcadena, 1, instr(sbcadena, ',', 1, 1) - 1) ref,
              substr(sbcadena,
                     instr(sbcadena, ',', 1, 1) + 1,
                     (instr(sbcadena, ',', 1, 2)) -
                     (instr(sbcadena, ',', 1, 1) + 1)) nombre,

              substr(sbcadena,
                     instr(sbcadena, ',', 1, 2) + 1,
                     (instr(sbcadena, ',', 1, 3)) -
                     (instr(sbcadena, ',', 1, 2) + 1)) apellido,
              substr(sbcadena,
                     instr(sbcadena, ',', 1, 3) + 1,
                     (instr(sbcadena, ',', 1, 4)) -
                     (instr(sbcadena, ',', 1, 3) + 1)) direccion,
              substr(sbcadena, instr(sbcadena, ',', 1, 4) + 1) telefono

         FROM dual);
    /*commit;*/

  EXCEPTION
    when pkg_error.controlled_error then
      rollback;
      raise pkg_error.controlled_error;
    when others then
      rollback;
      pkg_error.setError;
      raise pkg_error.controlled_error;

  end procinserinfref;

  PROCEDURE GenerateventforLDCRVEEM
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : GenerateventforLDCRVEEM
    Descripcion    : Procedimiento que genera todo el proceso para cada venta de formulario leido
                     en el archivo plano
    Autor          : JOsh Brito
    Fecha          : 17/10/2018

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    ******************************************************************/
  (onupack         out mo_packages.package_id%type,
   onuErrorCode    out number,
   osbErrorMessage out varchar2) IS

    isbXMLVenta Clob;
    sbXMlvent   varchar2(12000); -- Se cambia de 10000 a 12000 || ca 200-1283
    nuMotiveId  mo_motive.motive_id%type;
    sbDatosSolicitud     varchar2(2000) := '';
    sbDatosCliente       varchar2(2000) := '';
    sbTelefContacCliente varchar2(2000) := '';
    sbReferenciaCliente  varchar2(2000) := '';
    sbDatosPromocion     varchar2(2000) := '';
    sbDatosInstalacion   varchar2(2000) := '';

    nuPromGP number;
    nuRefGP  number;
    nuTelGP  number;
    nuTelGPc number;
    nuRefGPC number;

    /*Cursor para extraer la informaci?n de refencia de venta*/
    Cursor cuInforefVenta(sbREFERENCIA in ld_parameter.value_chain%type) Is
		SELECT regexp_substr(sbREFERENCIA, '[^-]+', 1, LEVEL)AS refencia
		FROM dual
		CONNECT BY regexp_substr(sbREFERENCIA, '[^-]+', 1, LEVEL) IS NOT NULL;
	  
    Cursor cuInforefeVentafi Is
      SELECT * FROM LDC_VENFORMASIREF;

    /*Cursor para extraer la informaci?n de contacto*/
    Cursor cuInfophoVenta(sbTELEFONOSCONTACT in ld_parameter.value_chain%type) Is
		SELECT regexp_substr(sbTELEFONOSCONTACT, '[^-]+', 1, LEVEL)AS telefono
		FROM dual
		CONNECT BY regexp_substr(sbTELEFONOSCONTACT, '[^-]+', 1, LEVEL) IS NOT NULL;

    Cursor cuInfophoVentafi Is
      SELECT * FROM ldc_venformasitele;

    -- Cursor para extraer informacion de la promcion de venta
    Cursor cuInfoPromVenta(sbpromocio in ld_parameter.value_chain%type) Is
		SELECT regexp_substr(sbpromocio, '[^-]+', 1, LEVEL)AS Promotion_Id
		FROM dual
		CONNECT BY regexp_substr(sbpromocio, '[^-]+', 1, LEVEL) IS NOT NULL;

 begin

    begin
      delete from LDC_VENFORMASIREF;
      delete from ldc_venformasitele;
      commit;

    EXCEPTION
      when pkg_error.controlled_error then
        rollback;
        raise pkg_error.controlled_error;
      when others then
        rollback;
        pkg_error.setError;
        raise pkg_error.controlled_error;
    end;

    sbDatosSolicitud := '<P_VENTA_DE_GAS_POR_FORMULARIO_XML_PLAN_COMERCIAL_ESPECIAL_100354 ID_TIPOPAQUETE="100354">' ||
                        chr(13) || ' <FECHA_DE_SOLICITUD>' ||
                        to_date(sbdtfecsol, 'DD/MM/YYYY') ||
                        '</FECHA_DE_SOLICITUD>' || chr(13) || ' <ID>' || nuId ||
                        '</ID>' || chr(13) || ' <POS_OPER_UNIT_ID>' ||
                        nuOPERUNITID || '</POS_OPER_UNIT_ID>' || chr(13) ||
                        ' <DOCUMENT_TYPE_ID>' || nuDOCUMENTTYPEID ||
                        '</DOCUMENT_TYPE_ID>' || chr(13) ||
                        ' <DOCUMENT_KEY>' || nuDOCUMENTKEY ||
                        '</DOCUMENT_KEY>' || chr(13) || ' <PROJECT_ID>' ||
                        sbPROJECTID || '</PROJECT_ID>' || chr(13) ||
                        ' <COMMENT_>' || sbCOMMENT_ || '</COMMENT_>';

    sbDatosCliente := ' <DIRECCION>' || nuDIRECCION || '</DIRECCION>' ||
                      chr(13) || ' <CATEGORIA>' || nuCategoria ||
                      '</CATEGORIA>' || chr(13) || ' <SUBCATEGORIA>' ||
                      nuSubcategoria || '</SUBCATEGORIA>' || chr(13) ||
                      ' <TIPO_DE_IDENTIFICACION>' || nuTIPOIDENTIFICACION ||
                      '</TIPO_DE_IDENTIFICACION>' || chr(13) ||
                      ' <IDENTIFICATION>' || nuIDENTIFICATION ||
                      '</IDENTIFICATION>' || chr(13) ||
                      ' <SUBSCRIBER_NAME>' || sbSUBSCRIBER_NAME ||
                      '</SUBSCRIBER_NAME>' || chr(13) || ' <APELLIDO>' ||
                      sbAPELLIDO || '</APELLIDO>' || chr(13) ||
                      ' <COMPANY>' || nuCOMPANY || '</COMPANY>' || chr(13) ||
                      ' <TITLE>' || sbTITLE || '</TITLE>' || chr(13) ||
                      ' <CORREO_ELECTRONICO>' || sbmail ||
                      '</CORREO_ELECTRONICO>' || chr(13) ||
                      ' <PERSON_QUANTITY>' || nuPERSONQUANTITY ||
                      '</PERSON_QUANTITY>' || chr(13) || ' <OLD_OPERATOR>' ||
                      nuOLDOPERATOR || '</OLD_OPERATOR>'||chr(13) ||
                      ' <UNIDAD_DE_TRABAJO_INSTALADORA/>'||chr(13) ||
                      ' <UNIDAD_DE_TRABAJO_CERTIFICADORA/>'||chr(13) ||
                      ' <PROYECTO_CONSTRUCTORA>' || sbPROYECTO ||
                      '</PROYECTO_CONSTRUCTORA>';

    nuTelGP  := 1;
    nuTelGPC := 1;
    FOR rgInfoVentapho IN cuInfophoVenta(sbTELEFONOSCONTACTO) LOOP

      procinserinfphon(rgInfoVentapho.Telefono,
                       nuTelGPC,
                       onuErrorCode,
                       osbErrorMessage);

      nuTelGPC := nuTelGPC + 1;
    END LOOP;

    FOR rgcoif IN cuInfophoVentafi LOOP

      IF (nuTelGP = 1) THEN
        sbTelefContacCliente := ' <TELEFONOS_DE_CONTACTO GROUP="TEL_' ||
                                nuTelGP || '">' || chr(13) || '   <PHONE>' ||
                                rgcoif.phone || '</PHONE>' || chr(13) ||
                                '   <PHONE_TYPE_ID>' || rgcoif.phone_id ||
                                '</PHONE_TYPE_ID>' || chr(13) ||
                                ' </TELEFONOS_DE_CONTACTO>';
      ELSE
        sbTelefContacCliente := sbTelefContacCliente || chr(13) ||
                                ' <TELEFONOS_DE_CONTACTO GROUP="TEL_' ||
                                nuTelGP || '">' || chr(13) || '   <PHONE>' ||
                                rgcoif.phone || '</PHONE>' || chr(13) ||
                                '   <PHONE_TYPE_ID>' || rgcoif.phone_id ||
                                '</PHONE_TYPE_ID>' || chr(13) ||
                                ' </TELEFONOS_DE_CONTACTO>';
      END IF;

      nuTelGP := nuTelGP + 1;
    END LOOP;

    nuRefGP  := 1;
    nuRefGPC := 1;

    if sbREFERENCIAS is not null then
    FOR rgInfoVentaref IN cuInforefVenta(sbREFERENCIAS) LOOP

      procinserinfref(rgInfoVentaref.Refencia,
                      nuRefGPC,
                      onuErrorCode            => onuErrorCode,
                      osbErrorMessage         => osbErrorMessage);

      nuRefGPC := nuRefGPC + 1;
    END LOOP;

    FOR rgreif IN cuInforefeVentafi LOOP

      IF (nuRefGP = 1) THEN
        sbReferenciaCliente := ' <REFERENCIAS GROUP="REF_' || nuRefGP || '">' ||
                               chr(13) || ' <REFERENCE_TYPE_ID>' ||
                               rgreif.reference_type_id ||
                               '</REFERENCE_TYPE_ID>' || chr(13) ||
                               ' <NAME_>' || rgreif.name_ || '</NAME_>' ||
                               chr(13) || ' <LAST_NAME>' ||
                               rgreif.last_name || '</LAST_NAME>' ||
                               chr(13) || ' <ADDRESS_ID>' ||
                               rgreif.address_id || '</ADDRESS_ID>' ||
                               chr(13) || ' <PHONE>' || rgreif.phone ||
                               '</PHONE>' || chr(13) || ' </REFERENCIAS>';
      ELSE
        sbReferenciaCliente := sbReferenciaCliente || chr(13) ||
                               ' <REFERENCIAS GROUP="REF_' || nuRefGP || '">' ||
                               chr(13) || ' <REFERENCE_TYPE_ID>' ||
                               rgreif.reference_type_id ||
                               '</REFERENCE_TYPE_ID>' || chr(13) ||
                               ' <NAME_>' || rgreif.name_ || '</NAME_>' ||
                               chr(13) || ' <LAST_NAME>' ||
                               rgreif.last_name || '</LAST_NAME>' ||
                               chr(13) || ' <ADDRESS_ID>' ||
                               rgreif.address_id || '</ADDRESS_ID>' ||
                               chr(13) || ' <PHONE>' || rgreif.phone ||
                               '</PHONE>' || chr(13) || ' </REFERENCIAS>';
      END IF;
      nuRefGP := nuRefGP + 1;
    END LOOP;

    else
        sbReferenciaCliente := '';

    end if;

    nuPromGP := 1;
    FOR rgInfoVentaprom IN cuInfoPromVenta(sbPROMOCIONES) LOOP
      IF (nuPromGP = 1) THEN
        sbDatosPromocion := '  <PROMOCIONES GROUP="PROM_' || nuPromGP || '">' ||
                            chr(13) || '    <PROMOTION_ID>' ||
                            rgInfoVentaprom.Promotion_Id ||
                            '</PROMOTION_ID>' || chr(13) ||
                            '  </PROMOCIONES>';
      ELSE
        sbDatosPromocion := TRIM(sbDatosPromocion) || chr(13) ||
                            '  <PROMOCIONES GROUP="PROM_' || nuPromGP || '">' ||
                            chr(13) || '    <PROMOTION_ID>' ||
                            rgInfoVentaprom.Promotion_Id ||
                            '</PROMOTION_ID>' || chr(13) ||
                            '  </PROMOCIONES>';
      END IF;
      nuPromGP := nuPromGP + 1;
    END LOOP;

    sbDatosInstalacion := ' <M_INSTALACION_DE_GAS_100340>' || chr(13) ||
                          '  <COMMERCIAL_PLAN_ID>' || nuCOMMERCIALPLAN ||
                          '</COMMERCIAL_PLAN_ID>' || chr(13) ||
                          sbDatosPromocion || chr(13) || '  <TOTAL_VALUE>' ||
                          to_char(ROUND(nuTOTALVALUE, 2))|| /*'8100' ||*/
                          '</TOTAL_VALUE>' || chr(13) ||
                          '  <PLAN_DE_FINANCIACION>' || nuPLANFINANCIACION ||
                          '</PLAN_DE_FINANCIACION>' || chr(13) ||
                          '  <INITIAL_PAYMENT>' || nuINITPAYMENT /*'0'*/||
                          '</INITIAL_PAYMENT>' || chr(13) ||
                          '  <NUMERO_DE_CUOTAS>' || to_char(nuNUMEROCUOTAS) ||
                          '</NUMERO_DE_CUOTAS>' || chr(13) ||
                          '  <CUOTA_MENSUAL>' ||
                          to_char(ROUND(nuCUOTAMENSUAL, 2)) ||
                          '</CUOTA_MENSUAL>' || chr(13) ||
                          '  <INIT_PAYMENT_MODE>' || sbInit_Payment_Mode ||
                          '</INIT_PAYMENT_MODE>' || chr(13) ||
                          '  <INIT_PAY_RECEIVED>' || sbInit_Pay_Received ||
                          '</INIT_PAY_RECEIVED>' || chr(13) || '  <USAGE>' ||
                          nuUSAGE/*'1'*/ || '</USAGE>' || chr(13) ||
                          '  <INSTALL_TYPE>' || to_char(sbINSTALLTYPE) ||
                          '</INSTALL_TYPE>' || chr(13) || '  <C_GAS_10361>' ||
                          chr(13) || '     <C_MEDICION_10362/>' || chr(13) ||
                          '  </C_GAS_10361>' || chr(13) ||
                          ' </M_INSTALACION_DE_GAS_100340>' || chr(13) ||
                          '</P_VENTA_DE_GAS_POR_FORMULARIO_XML_PLAN_COMERCIAL_ESPECIAL_100354>';

    sbXMlvent := sbDatosSolicitud || chr(13) || sbDatosCliente || chr(13) ||
                 sbTelefContacCliente || chr(13) || sbReferenciaCliente ||
                 chr(13) || sbDatosInstalacion;
    /*Cambio 200-1283*/
    ErrorXml := sbXMlvent;
    /*Fin Cambio 200-1283*/
    -- Llamado a API de OSF para generar la venta por formulario XML
    api_registerRequestByXml(isbRequestXML   => sbXMlvent,
                              onuPackageID    => onuPack,
                              onuMotiveID     => nuMotiveId,
                              onuErrorCode    => onuErrorCode,
                              osbErrorMessage => osbErrorMessage);

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      pkg_error.getError(onuErrorCode, osbErrorMessage);
    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      pkg_error.getError(onuErrorCode, osbErrorMessage);
  END GenerateventforLDCRVEEM;

  FUNCTION fboGetIsNumber(isbValor varchar2) return boolean is

    blResult boolean := TRUE;
    nuRes    number;

  BEGIN
    begin
      nuRes := to_number(isbValor);
    exception
      when others then
        blResult := FALSE;
    end;

    return(blResult);

  EXCEPTION
    when others then
      return(FALSE);
  END fboGetIsNumber;

  PROCEDURE ReadTextFile IS

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ReadTextFile
    Descripcion    : Procedimiento que recorre el archivo plano, valida los campos
                     y genera las ventas por formulario que se encuentran en este archivo
    Fecha          : 25/08/2016 ERS 200-465

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    13-07-2017    SEBTAP                  Se crean variables para manejo de error,
                                          Se agrengan lineas de error al LOG
                                          Se valida que las referencias y las promociones no sean nulas.
    ******************************************************************/

    cnuZERO constant number := pkBillConst.CERO;
    cnuONE  constant number := LD_BOConstans.cnuonenumber;

    sbFileGl varchar2(100);
    sbExt    varchar2(10);
    sbOnline varchar2(5000);

    /* Variables para conexion*/

    sbFileManagement  utl_file.file_type;
    sbFileManagementd utl_file.file_type;
    nuLinea           number;
    nuCodigo          number;

    cnuend_of_file constant number := 1;

    nuerror   number;
    sbmessage varchar2(2000);

    /*Variables de archivo de log*/

    sbLog          varchar2(500); -- Log de errores
    sbLineLog      varchar2(1000);
    /*Cambio 200-1283*/
    sbLineLog_2    varchar2(1000);
    sequence_id  number;
    /*Fin Cambio 200-1283*/
    sbTimeProc     varchar2(500);
    nuErrorCode    NUMBER;
    sbErrorMessage VARCHAR2(4000);
    nuMonth        number;

    ------------ Variables del archivo
    sbLineFile   varchar2(1000);
    vnuexito     number := 0;
    vnunoexito   number := 0;
    sbAsunto     varchar2(2000);
    vsbmessage   varchar2(2000);
    vsbSendEmail ld_parameter.value_chain%TYPE; --Direccion de email quine firma el email
    vsbrecEmail  ld_parameter.value_chain%TYPE; --Direccion de email que recibe

    nuContador number := 1;
    nuIndex    number;
    onupackg   number;

    ------------------------

  BEGIN

    sbTimeProc := TO_CHAR(SYSDATE, 'yyyymmdd_hh24miss');

    /* Arma nombre del archivo LOG */
    sbLog := sbFile || '_' || sbTimeProc || '.LOG';

    /* Crea archivo Log */
    sbFileManagementd := pkUtlFileMgr.Fopen(sbPath, sbLog, 'w');

    begin
      sbFileManagement := pkUtlFileMgr.fOpen(sbPath, sbFile, 'r');
    exception
      when others then
        sbLineLog := '     Error ... No se pudo abrir archivo ' || sbPath || ' ' ||
                     sbFile || ' ' || chr(13) || sqlerrm;
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO FinProceso;
    end;

    nuLinea := 0;

    -- ciclo de lectura de lineas del archivo
    loop
      sbLineLog := NULL;
      nuLinea   := nuLinea + 1;
      nuCodigo  := pkUtlFileMgr.get_line(sbFileManagement, sbOnline);
      exit when(nuCodigo = cnuend_of_file);

      /*Obtiene la frecha de la solicitud*/
      sbdtfecsol := substr(sbOnline, 1, instr(sbOnline, '|', 1, 1) - 1);

      /*Obtiene el person ID*/
      nuId := substr(sbOnline,
                     instr(sbOnline, '|', 1, 1) + 1,
                     (instr(sbOnline, '|', 1, 2)) -
                     (instr(sbOnline, '|', 1, 1) + 1));

      /*Obtiene la unidad operativa*/
      nuOPERUNITID := substr(sbOnline,
                             instr(sbOnline, '|', 1, 2) + 1,
                             (instr(sbOnline, '|', 1, 3)) -
                             (instr(sbOnline, '|', 1, 2) + 1));

      /*Obtien el tipo de documento*/
      nuDOCUMENTTYPEID := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 3) + 1,
                                 (instr(sbOnline, '|', 1, 4)) -
                                 (instr(sbOnline, '|', 1, 3) + 1));

      /*Obtiene el documento*/
      nuDOCUMENTKEY := substr(sbOnline,
                              instr(sbOnline, '|', 1, 4) + 1,
                              (instr(sbOnline, '|', 1, 5)) -
                              (instr(sbOnline, '|', 1, 4) + 1));

      /**/
      sbPROJECTID := substr(sbOnline,
                            instr(sbOnline, '|', 1, 5) + 1,
                            (instr(sbOnline, '|', 1, 6)) -
                            (instr(sbOnline, '|', 1, 5) + 1));

      /*Obtiene la observacion*/
      sbCOMMENT_ := substr(sbOnline,
                           instr(sbOnline, '|', 1, 6) + 1,
                           (instr(sbOnline, '|', 1, 7)) -
                           (instr(sbOnline, '|', 1, 6) + 1));

      /*Obtiene la direccion*/
      nuDIRECCION := substr(sbOnline,
                            instr(sbOnline, '|', 1, 7) + 1,
                            (instr(sbOnline, '|', 1, 8)) -
                            (instr(sbOnline, '|', 1, 7) + 1));

      nuCategoria := substr(sbOnline,
                            instr(sbOnline, '|', 1, 8) + 1,
                            (instr(sbOnline, '|', 1, 9)) -
                            (instr(sbOnline, '|', 1, 8) + 1));

      nuSubcategoria := substr(sbOnline,
                               instr(sbOnline, '|', 1, 9) + 1,
                               (instr(sbOnline, '|', 1, 10)) -
                               (instr(sbOnline, '|', 1, 9) + 1));

      /*Obtien el tipo de identificacion*/
      nuTIPOIDENTIFICACION := substr(sbOnline,
                                     instr(sbOnline, '|', 1, 10) + 1,
                                     (instr(sbOnline, '|', 1, 11)) -
                                     (instr(sbOnline, '|', 1, 10) + 1));

      nuIDENTIFICATION := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 11) + 1,
                                 (instr(sbOnline, '|', 1, 12)) -
                                 (instr(sbOnline, '|', 1, 11) + 1));

      sbSUBSCRIBER_NAME := substr(sbOnline,
                                  instr(sbOnline, '|', 1, 12) + 1,
                                  (instr(sbOnline, '|', 1, 13)) -
                                  (instr(sbOnline, '|', 1, 12) + 1));

      sbAPELLIDO := substr(sbOnline,
                           instr(sbOnline, '|', 1, 13) + 1,
                           (instr(sbOnline, '|', 1, 14)) -
                           (instr(sbOnline, '|', 1, 13) + 1));

      nuCOMPANY := substr(sbOnline,
                          instr(sbOnline, '|', 1, 14) + 1,
                          (instr(sbOnline, '|', 1, 15)) -
                          (instr(sbOnline, '|', 1, 14) + 1));

      sbTITLE := substr(sbOnline,
                        instr(sbOnline, '|', 1, 15) + 1,
                        (instr(sbOnline, '|', 1, 16)) -
                        (instr(sbOnline, '|', 1, 15) + 1));

      sbmail := substr(sbOnline,
                       instr(sbOnline, '|', 1, 16) + 1,
                       (instr(sbOnline, '|', 1, 17)) -
                       (instr(sbOnline, '|', 1, 16) + 1));

      nuPERSONQUANTITY := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 17) + 1,
                                 (instr(sbOnline, '|', 1, 18)) -
                                 (instr(sbOnline, '|', 1, 17) + 1));

      nuOLDOPERATOR := substr(sbOnline,
                              instr(sbOnline, '|', 1, 18) + 1,
                              (instr(sbOnline, '|', 1, 19)) -
                              (instr(sbOnline, '|', 1, 18) + 1));

      sbVENTAEMPAQUETADA := substr(sbOnline,
                                   instr(sbOnline, '|', 1, 19) + 1,
                                   (instr(sbOnline, '|', 1, 20)) -
                                   (instr(sbOnline, '|', 1, 19) + 1));

      sbTELEFONOSCONTACTO := substr(sbOnline,
                                    instr(sbOnline, '|', 1, 20) + 1,
                                    (instr(sbOnline, '|', 1, 21)) -
                                    (instr(sbOnline, '|', 1, 20) + 1));

      sbREFERENCIAS := substr(sbOnline,
                              instr(sbOnline, '|', 1, 21) + 1,
                              (instr(sbOnline, '|', 1, 22)) -
                              (instr(sbOnline, '|', 1, 21) + 1));

      nuCOMMERCIALPLAN := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 22) + 1,
                                 (instr(sbOnline, '|', 1, 23)) -
                                 (instr(sbOnline, '|', 1, 22) + 1));

      sbPROMOCIONES := substr(sbOnline,
                              instr(sbOnline, '|', 1, 23) + 1,
                              (instr(sbOnline, '|', 1, 24)) -
                              (instr(sbOnline, '|', 1, 23) + 1));

      nuTOTALVALUE := substr(sbOnline,
                             instr(sbOnline, '|', 1, 24) + 1,
                             (instr(sbOnline, '|', 1, 25)) -
                             (instr(sbOnline, '|', 1, 24) + 1));

      nuPLANFINANCIACION := substr(sbOnline,
                                   instr(sbOnline, '|', 1, 25) + 1,
                                   (instr(sbOnline, '|', 1, 26)) -
                                   (instr(sbOnline, '|', 1, 25) + 1));

      nuNUMEROCUOTAS := substr(sbOnline,
                               instr(sbOnline, '|', 1, 26) + 1,
                               (instr(sbOnline, '|', 1, 27)) -
                               (instr(sbOnline, '|', 1, 26) + 1));

      nuCUOTAMENSUAL := substr(sbOnline,
                               instr(sbOnline, '|', 1, 27) + 1,
                               (instr(sbOnline, '|', 1, 28)) -
                               (instr(sbOnline, '|', 1, 27) + 1));

      nuINITPAYMENT := substr(sbOnline,
                              instr(sbOnline, '|', 1, 28) + 1,
                              (instr(sbOnline, '|', 1, 29)) -
                              (instr(sbOnline, '|', 1, 28) + 1));

      sbInit_Payment_Mode := substr(sbOnline,
                                    instr(sbOnline, '|', 1, 29) + 1,
                                    (instr(sbOnline, '|', 1, 30)) -
                                    (instr(sbOnline, '|', 1, 29) + 1));

      sbInit_Pay_Received := substr(sbOnline,
                                    instr(sbOnline, '|', 1, 30) + 1,
                                    (instr(sbOnline, '|', 1, 31)) -
                                    (instr(sbOnline, '|', 1, 30) + 1));

      nuUSAGE := substr(sbOnline,
                        instr(sbOnline, '|', 1, 31) + 1,
                        (instr(sbOnline, '|', 1, 32)) -
                        (instr(sbOnline, '|', 1, 31) + 1));

      sbINSTALLTYPE := substr(sbOnline,
                              instr(sbOnline, '|', 1, 32) + 1,
                              (instr(sbOnline, '|', 1, 33)) -
                              (instr(sbOnline, '|', 1, 32) + 1));

      ----------------- validaciones  ----------------------

      if sbdtfecsol is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'Fecha de la solicitud Nula' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuId is null or not fboGetIsNumber(nuId) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'person id  Nula o no numerica' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuOPERUNITID is null or not fboGetIsNumber(nuOPERUNITID) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'person id  Nula o no numerica' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuDOCUMENTTYPEID is null or not fboGetIsNumber(nuDOCUMENTTYPEID) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'tipo de documento  Nulo o no numerico' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuDOCUMENTKEY is null or not fboGetIsNumber(nuDOCUMENTKEY) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'documento  Nulo o no numerico' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;


      if trim(sbCOMMENT_) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'Observacion Nula' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuDIRECCION is null or not fboGetIsNumber(nuDIRECCION) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'Direcci?n  Nula o no numerico' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuTIPOIDENTIFICACION is null or
         not fboGetIsNumber(nuTIPOIDENTIFICACION) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'Direcci?n  Nula o no numerico' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if trim(nuIDENTIFICATION) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'identificacion  Nula' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if trim(sbSUBSCRIBER_NAME) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'Nombre  Nulo' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if trim(sbAPELLIDO) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'Apellido  Nulo' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if trim(nuCOMPANY) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'empresa  Nulo' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if trim(sbTITLE) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'titulo  Nulo' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if trim(sbmail) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'correo electronico  Nulo' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuPERSONQUANTITY is null or not fboGetIsNumber(nuPERSONQUANTITY) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'Personas a cargo  Nula o no numerico' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuCOMMERCIALPLAN is null or not fboGetIsNumber(nuCOMMERCIALPLAN) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'plan comercial  Nula o no numerico' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuPLANFINANCIACION is null or
         not fboGetIsNumber(nuPLANFINANCIACION) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'plan de financiaci?n  Nula o no numerico' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuTOTALVALUE is null or not fboGetIsNumber(nuTOTALVALUE) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'valor total de la venta  Nula o no numerico' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuCUOTAMENSUAL is null or not fboGetIsNumber(nuCUOTAMENSUAL) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'valor de la cuota mensual Nula o no numerico' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuINITPAYMENT is null or not fboGetIsNumber(nuINITPAYMENT) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'cuota inicial Nula o no numerico' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if trim(sbTELEFONOSCONTACTO) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'Telefonos de contacto  Nulo' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;
      /*Cambio 200-1283*/
      if trim(sbREFERENCIAS) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'Informaci?n de referencia  Nulo' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

     if trim(sbPROMOCIONES) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'promociones  Nulo' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;


       GenerateventforLDCRVEEM(onupackg, nuErrorCode, sbErrorMessage);


      if nuErrorCode != 0 then
        rollback;
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'Error ' ||
                     nuErrorCode || ' ' || sbErrorMessage || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
         /*Cambio 200-1283*/
         --- Se obtiene la siguiente secuencia de la tabla Ge_Error_Log
        sequence_id := pkgeneralservices.fnugetnextsequenceval('SEQ_GE_ERROR_LOG');
        --- Se Construye la linea que agregaremos al Log.
        sbLineLog_2 := ' Linea ' || nuLinea || '. ' || 'Error ' ||
                     nuErrorCode || ' ' ||' Error con info Xml --> ' || sequence_id || chr(13);
        --- Se ejecuta procedimiento para insertar registro en la tabla Ge_Error_Log
       LDC_PKGENVENFORMASI.RegErrXml(sequence_id, sbLineLog); -- Se envia la secuencia y la linea de error proveniente del API
       --- Insertamos en el LOG la linea con la descripcion del error.
       pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog_2);
       /*Fin Cambio 200-1283*/
      else
        commit;
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'Solicitud creada N?:' ||
                     onupackg || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
      end if;

      <<nextLine>>
      null;
    end loop;
    <<FinProceso>>
    pkUtlFileMgr.fClose(sbFileManagement);
    pkUtlFileMgr.fClose(sbFileManagementd);



  EXCEPTION
    when pkg_error.controlled_error then
      rollback;
      raise pkg_error.controlled_error;
    when others then
      rollback;
      pkg_error.setError;
      raise pkg_error.controlled_error;
  END ReadTextFile;



   PROCEDURE LDCRVEEM IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : LDCRVEEM
    Descripcion    : Procedimiento llamado por el PB
    Autor          : JOSH BRITO
    Fecha          : 16/10/2018 ERS 200-2022

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================

    ******************************************************************/

    sbSISTDIRE        ge_boInstanceControl.stysbValue;

    sbFileManagementr utl_file.file_type;

  BEGIN

    pkg_traza.TRACE('**************** Inicio LDC_PKGENVENFORMASI.LDCRVEEM',
                   cnuNVLTRC);

    sbSISTDIRE := ge_boInstanceControl.fsbGetFieldValue('SISTEMA','SISTDIRE');
    sbPROYECTO := ge_boInstanceControl.fsbGetFieldValue('LDC_PROYSOLES','ID_PROYECTO');

    if (sbSISTDIRE is null) then
      pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                      'El Nombre de Achivo no debe ser nulo');
      raise pkg_error.controlled_error;
    end if;

    sbPath := dald_parameter.fsbGetValue_Chain('RUTA_ARCH_VENFORM_MASIVAS'); -- '/smartfiles/cartera';
    sbFile := sbSISTDIRE;

    -- valida que exista el archivo
    begin
      sbFileManagementr := pkUtlFileMgr.fOpen(sbPath, sbFile, 'r');
    exception
      when others then
        pkUtlFileMgr.fClose(sbFileManagementr);
        pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                        'Error ... Archivo no Existe o no se pudo abrir ');
        raise pkg_error.controlled_error;

    end;

    sbForma := 'LDCRVEEM';
    ReadTextFile;

    pkg_traza.TRACE('**************** Fin LDC_PKGENVENFORMASI.LDCRVEEM', cnuNVLTRC);

  END LDCRVEEM;

  FUNCTION fsbGetFormaPago (inuSolicitud IN mo_packages.package_id%type) RETURN VARCHAR2 IS
 /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fsbGetFormaPago
    Descripcion:        retornar forma de pago

    Autor    : Josh Brito
    Fecha    : 26/04/2019

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    20/04/2019  Jbrito          Creacion
    ******************************************************************/

    nuContrato NUMBER;
    sbFormapago VARCHAR2(15);

    --se consulta forma de pago
    CURSOR cuFormaPago IS
    select dt.DETBFOPA
    from RC_DETATRBA dt, trbadosr td, DOCUSORE ds, pagos p, cupon c
    WHERE dt.DETBTRBA = td.TBDSTRBA-- 44386
      AND td.TBDSDOSR = ds.DOSRCODI
      AND p.PAGOCONC = ds.DOSRCONC
      and p.PAGOCUPO = c.CUPONUME
      and c.CUPODOCU = to_char(inuSolicitud)
      and c.CUPOSUSC = nuConTrato
      and c.CUPOFLPA = 'S';

     --se consulta contrato
     CURSOR cuGetContrato IS
     SELECT SUBSCRIPTION_ID
     FROM mo_motive
     WHERE package_id = inuSolicitud
      AND PRODUCT_TYPE_ID = 6121;

  BEGIN
    OPEN cuGetContrato;
    FETCH cuGetContrato INTO nuConTrato;
    CLOSE cuGetContrato;

    OPEN cuFormaPago;
    FETCH cuFormaPago INTO sbFormapago;
    CLOSE cuFormaPago;

      RETURN sbFormapago;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbFormapago;
  END;

  PROCEDURE prregistraVenta(sbXML IN VARCHAR2,
                            onuPack OUT NUMBER,
                            OnuMotiveId OUT NUMBER,
                            onuErrorCode OUT NUMBER,
                            osbErrorMessage OUT varchar2)IS

  BEGIN

   --se registra solicitud de venta
   api_registerRequestByXml(isbRequestXML   => sbXML,
                              onuPackageID    => onuPack,
                              onuMotiveID     => OnuMotiveId,
                              onuErrorCode    => onuErrorCode,
                              osbErrorMessage => osbErrorMessage);

  END prregistraVenta;
  PROCEDURE   PRGENERAVENTPLES(inuSolicitud IN mo_packages.package_id%TYPE) IS
     /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: PRGENERAVENTPLES
        Descripcion:        genera ventas de gas por formulario

        Autor    : Josh Brito
        Fecha    : 26/04/2019

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        20/04/2019  Jbrito          Creacion
		   31/10/2019  LJLB            CA 227 se quita redondeo del calculo de tasi nominal
        29/01/2020    LJLB         CA 274 se coloca logica para formularios
     ******************************************************************/

    sbDatosEncXML        varchar2(2000) := '';
    sbDatosSolicitud     varchar2(2000) := '';
    sbDatosCliente       varchar2(2000) := '';
    sbTelefContacCliente varchar2(2000) := '';
    sbReferenciaCliente  varchar2(2000) := '';
    sbDatosPromocion     varchar2(2000) := '';
    sbDatosInstalacion   varchar2(2000) := '';
    sbXML     varchar2(30000) := '';

    nudireccion  AB_ADDRESS.ADDRESS_ID%TYPE;
    nuCategoria   CATEGORI.CATECODI%TYPE;
    nuSucategoria  SUBCATEG.SUCACODI%TYPE;
    ionuOrderId	NUMBER;
	ionuOrderactivityid NUMBER;

    onuPack    number;
    nuMotiveId number;
    onuErrorCode number;
    osbErrorMessage varchar2(4000);

    sbactividadcxc  varchar2(4000) := dald_parameter.fsbgetvalue_chain('LDC_ACTICXCRE', NULL);-- se almacena actividad de cxc
    sbactividadcert  varchar2(4000) := dald_parameter.fsbgetvalue_chain('LDC_ACTREVCER', NULL);-- se almacena actividad de insp y cert
    nuRespHijo    NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_PARPERSONAHIJO', NULL);--se almacena codigo de responsable hijo

    --se consulta datos basicos de la venta
    CURSOR cuDatosBasico IS
    SELECT SYSDATE fecha_de_solicitud ,
           s.person_id Person_Id,
           s.pos_oper_unit_id pos_oper_unit_id,
           s.comment_ comment_,
           c.ident_type_id tipo_de_identificacion,
           c.identification identification,
           c.subscriber_name subscriber_name,
           nvl(c.subs_last_name,'NA') apellido,
           c.phone,
           'NA' company,
           'NA' title,
           c.e_mail correo_electronico,
           0 person_quantity,
           0 old_operator,
           pc.id_proyecto PROYECTO_CONSTRUCTORA
    FROM mo_packages s, ge_subscriber c, ldc_proyecto_constructora pc
    WHERE s.package_id = inuSolicitud
     AND s.subscriber_id = c.subscriber_id
     AND pc.id_solicitud = s.package_id;

    regDatosVenta cuDatosBasico%rowtype; --se crea registro de datos basicos

    --se consulta direcciones
    CURSOR cuDirecciones IS
    SELECT ADDITIONAL_DATA
    FROM MO_CONSTR_COMPANY_DAT p
    WHERE p.PACKAGE_ID = inuSolicitud ;

    sbDirecciones clob;

   --se deserializan las direcciones
   CURSOR cuDeseDirecciones is
   SELECT *
   FROM XMLTable('/DocumentElement/RECORDS' Passing
                       XMLType(sbDirecciones)  Columns
                                Direccion NUMBER Path 'Address')
    where pR_BOProduct.fnugetprodbyaddrprodtype(direccion, ld_boconstans.cnuGasService) is null ;

    regDirecciones cuDeseDirecciones%ROWTYPE;


  --se consulta informacion del plan especial
    CURSOR cuDatosInstalAcion IS
    SELECT confplancome Commercial_Plan_Id,
       confcuotaini initial_payment,
       confnumcuota Numero_De_Cuotas,
       --round(confnumcuota,0)  Cuota_Mensual,
       confplanfina plan_de_financiacion,
       --confvaltot total_value,
       '' Init_Payment_Mode ,
       'N' Init_Pay_Received,
       1 Usage,
       1 INSTALL_TYPE,
       UND_INSTALADORA_ID Unidad_insta,
       UND_CERTIFICADORA_ID unidad_certi,
       decode(CONFRESPCXC, nuRespHijo, 0, 1) activcxc,
       decode(CONFRESPCERT, nuRespHijo, 0, 1) actirevcer,
	   pc.SUSCRIPCION,
      pc.CANT_UNID_PREDIAL
    FROM ldc_confplco, LDC_COTIZACION_CONSTRUCT co, LDC_PROYECTO_CONSTRUCTORA pc
    WHERE codconfplco = co.PLAN_COMERCIAL_ESPCL
     AND co.id_proyecto = pc.ID_PROYECTO
     AND pc.ID_SOLICITUD = inuSolicitud
     AND co.estado IN   ('A', 'P');

     rgInfoVenta  cuDatosInstalAcion%ROWTYPE;

     --se consultan los datos del motivo
     CURSOR cuDatosMotivo IS
     SELECT subscriber_id, product_id, SUBSCRIPTION_ID
     FROM mo_motive m, mo_packages p
     WHERE p.package_id = onuPack
     and p.package_id = m.package_id
     and m.motive_id = nuMotiveId;

     regMotivos cuDatosMotivo%rowtype;
     --se consulta la tarifa vigente del concepto de venta
     cursor cuValorConc(inuConcepto number, nuPlanCome NUMBER) IS
     SELECT VITPVALO
     FROM   ta_vigetacp d, ta_taricopr A, TA_PROYTARI b
    WHERE  d.vitptipo = 'B'
		AND a.tacpprta = b.prtacons
		and b.prtaesta in (2,3)
		AND SYSDATE BETWEEN vitpfein AND  vitpfefi
		AND vitptacp =  tacpcons
		AND A.tacpcr01 = nuPlanCome
		AND (A.tacpcr02 = nuSucategoria OR A.tacpcr02 = -1)
		AND (A.tacpcr03 = nuCategoria OR A.tacpcr03 = -1)
		AND tacpcotc =
					   (  SELECT MAX(cotccons)
							FROM ta_conftaco
							WHERE cotcconc = inuConcepto AND cotcvige ='S'
								AND SYSDATE BETWEEN cotcfein AND cotcfefi);



      nuValorConcCxc NUMBER;
      nuValorConcCert NUMBER;
      nuConceCxc   NUMBER := DALD_PARAMEtER.FNUGETNUMERIC_VALUE('PAR_CONCEPTCXC',NULL);
      nuConceCert   NUMBER := DALD_PARAMEtER.FNUGETNUMERIC_VALUE('PAR_CONCEPTCERT',NULL);
      nuValorVenta  number;
      nuCuotaMensual  number;

  CURSOR cuItems (sbActividad VARCHAR2) IS
  select i.ITEMS_ID
  from CC_QUOTATION c, CC_QUOTATION_ITEM i
  where c.quotation_id = i.quotation_id
  and c.package_id = inuSolicitud
  and i.items_id in
    		(SELECT regexp_substr(sbActividad, '[^,]+', 1, LEVEL)AS Activ
			FROM dual
			CONNECT BY regexp_substr(sbActividad, '[^,]+', 1, LEVEL) IS NOT NULL);

  nuactividadcxc NUMBER;
  NUactividadcert NUMBER;

  CURSOR cuPlanFina(nuFinan NUMBER) IS
  SELECT  plditain, pldimccd, pldifagr
  FROM plandife
  WHERE pldicodi = nuFinan;

    regPlanFina   cuPlanFina%rowtype;

  nuIva NUMBER := 0;
  nuValorIva NUMBER := 0;
  nuEmpresa NUMBER;
  nuFactorRedondeo   TIMOEMPR.TMEMFARE%TYPE;
  nuTasaEA  NUMBER;
  nuTasaPer NUMBER;
  nuTasaNom  NUMBER;
  nuRangoLiq number;
  sbDatos varchar2(4000);
  nuContrato  NUMBER;
  sbExisPag VARCHAR2(1);

  --se consulta cupon a pagar
    CURSOR cuCuponanular IS
    SELECT 'X'
    FROM CUPON
    WHERE CUPODOCU = TO_CHAR(inuSolicitud)
     AND cuposusc = nuContrato
     AND cupoflpa = 'S'
	 AND CUPOTIPO = 'DE';

  --INICIO ca 274
  nuNumeAuto NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CODCONSE',NULL); --se actualiza numeracion autorizada
  nuCantDisp NUMBER; --se almacena cantidad disponible de formularios
  nuFormulario NUMBER; --se almacena formulario
  nuUnidadOpe number;


   --se valida la cantidad disponible de formularios
   CURSOR cuValidaCantForDispo(inuUnidad IN NUMBER) IS
   SELECT sum((CODINUFI  - nvl(CODIULNU,CODINUIN))) dif
    FROM FA_CONSDIST
    WHERE CODIACTI = 'S'
       AND CODIUNOP = inuUnidad
       AND CODICONA = nuNumeAuto
       AND (CODINUFI  - nvl(CODIULNU,CODINUIN) ) > 0 ;

   CURSOR cuSigFormulario(inuUnidad IN NUMBER) IS
   SELECT CASE WHEN CODIULNU IS NULL THEN
                     CODINUIN
                  ELSE  CODIULNU + 1
            END conse
    FROM FA_CONSDIST
    WHERE CODIACTI = 'S'
       AND CODIUNOP = inuUnidad
       AND CODICONA = nuNumeAuto
       AND (CODINUFI  - nvl(CODIULNU,CODINUIN) ) > 0
       AND NOT EXISTS (
                       SELECT 'x'
                       FROM fa_histcodi
                       WHERE HICDCONA = CODICONA
                        AND HICDNUME = (CASE WHEN CODIULNU IS NULL THEN
                                                 CODINUIN
                                        ELSE  CODIULNU + 1
                                        END )
                         AND HICDESTA IN ('V', 'P'));

	CURSOR cuCategorias(nuDireccion ab_address.address_id%TYPE)IS
		SELECT b.category_, b.subcategory_
		FROM ab_address a, ab_premise b 
		WHERE a.estate_number = b.premise_id 
		AND premise_id = nuDireccion;
		
  --FIN CA 274

  BEGIN

    --se cargan datos basico de la solicitud
    OPEN cuDatosBasico;
    FETCH cuDatosBasico INTO regDatosVenta;
    IF cuDatosBasico%NOTFOUND THEN
      CLOSE cuDatosBasico;
    pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                        'Solicitud ['||inuSolicitud||'] no existe o no tiene proyecto asociado');

     raise pkg_error.controlled_error;
	END IF;
    CLOSE cuDatosBasico;


   --INICIO CA 274

    nuUnidadOpe := fnuGetUnidDisp(regDatosVenta.person_id, regDatosVenta.PROYECTO_CONSTRUCTORA);

    OPEN cuValidaCantForDispo (nuUnidadOpe);
    FETCH cuValidaCantForDispo INTO nuCantDisp;
    CLOSE cuValidaCantForDispo;

    IF rgInfoVenta.CANT_UNID_PREDIAL > NVL(nuCantDisp,0) THEN
       pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                'No se tiene la cantidad de formularios disponible para la unidad operativa  ['||regDatosVenta.Pos_Oper_Unit_Id||']');

        raise pkg_error.controlled_error;
	END IF;
   --FIN CA 274

    --se carga direcciones a procesar
    OPEN cuDirecciones;
    FETCH cuDirecciones INTO sbDirecciones;
    IF cuDirecciones%NOTFOUND THEN
     CLOSE cuDirecciones;
       pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                        'Solicitud ['||inuSolicitud||'] no tiene las direcciones cargadas en ASIMADI');

       raise pkg_error.controlled_error;
	END IF;
    CLOSE cuDirecciones;

		--se consulta una direccion
	  OPEN cuDeseDirecciones;
	  FETCH cuDeseDirecciones INTO regDirecciones;
	  IF cuDeseDirecciones%FOUND THEN

			IF cuCategorias%ISOPEN then
				CLOSE cuCategorias;
			END IF;
		  
			OPEN cuCategorias(regDirecciones.Direccion);
			FETCH cuCategorias INTO nuCategoria,nuSucategoria;
			CLOSE cuCategorias;

	  END IF;
	  CLOSE cuDeseDirecciones;

  --Se carga informacion de plan comercial
    OPEN cuDatosInstalAcion;
    FETCH cuDatosInstalAcion INTO rgInfoVenta;
    IF cuDatosInstalAcion%NOTFOUND THEN
       CLOSE cuDatosInstalAcion;
     pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                        'Solicitud ['||inuSolicitud||'] no tiene configuraciones de plan comercial');

      raise pkg_error.controlled_error;
	END IF;
    CLOSE cuDatosInstalAcion;


    IF rgInfoVenta.initial_payment > 0 THEN
      nuContrato := rgInfoVenta.SUSCRIPCION;
      --se consulta si existe pago de cuota inicial
      OPEN cuCuponanular;
      FETCH cuCuponanular INTO sbExisPag;
      IF cuCuponanular%NOTFOUND THEN
         CLOSE cuCuponanular;
       pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                'No se ha realizado pago de la cuota inicial configurada en el plan especial escogido en la solicitud  ['||inuSolicitud||']');
        raise pkg_error.controlled_error;
	  END IF;
      CLOSE cuCuponanular;
    END IF;



    IF rgInfoVenta.activcxc = 0 THEN
        open cuValorConc(nuConceCxc, rgInfoVenta.Commercial_Plan_Id);
        fetch cuValorConc into nuValorConcCxc;
        if cuValorConc%notfound then
            close cuValorConc;
            pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                            'Solicitud ['||inuSolicitud||'] no tiene tarifa vigente para el concepto '|| nuConceCxc);

          raise pkg_error.controlled_error;
		end if;
        close cuValorConc;

    --calculo de iva
    nuIva := funCalculaIva(nuConceCxc);
    nuValorIva := nuValorIva + (nuValorConcCxc * nuIva / 100);

    END IF;

     IF rgInfoVenta.actirevcer = 0 THEN
        open cuValorConc(nuConceCert,rgInfoVenta.Commercial_Plan_Id);
        fetch cuValorConc into nuValorConcCert;
        if cuValorConc%notfound then
            close cuValorConc;
            pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                            'Solicitud ['||inuSolicitud||'] no tiene tarifa vigente para el concepto '|| nuConceCert);

          raise pkg_error.controlled_error;
		end if;
        close cuValorConc;
    nuIva := 0;
    nuIva := funCalculaIva(nuConceCert);
    nuValorIva := nuValorIva + ( nuValorConcCert * nuIva / 100);


    END IF;



    sbDatosEncXML:= '<?xml version="1.0" encoding="ISO-8859-1"?>'; --se colcoa encabezado del xml

    --se cargan datos de las promociones
    sbDatosPromocion := '<PROMOCIONES GROUP="'||1||'">'||
                             '<PROMOTION_ID>248</PROMOTION_ID>'||
                         '</PROMOCIONES>';

    nuValorVenta :=  round((nvl(nuValorConcCxc, 0) +nvl(nuValorConcCert, 0) + NVL(nuValorIva,0) ),0); -- se calcula valor de la venta

  --se calcula cuota mensual
  OPEN cuPlanFina(rgInfoVenta.Plan_De_Financiacion);
  FETCH cuPlanFina INTO regPlanFina;
  CLOSE cuPlanFina;

  nuEmpresa := pkg_session.fnugetempresadeusuario;
  FA_BOPOLITICAREDONDEO.OBTFACTORREDONDEO( NULL, nuFactorRedondeo, nuEmpresa);
  nuTasaEA := FNUGETINTERESTRATE(regPlanFina.plditain, sysdate);
  nuTasaNom := PKEFFECTIVEINTERESTRATEMGR.TONOMINALRATE(nuTasaEA + 0) ;
  nuTasaPer := ((nuTasaNom / 12 ) / 100);

  nuCuotaMensual :=  ceil( ( (nuValorVenta - rgInfoVenta.Initial_Payment) * ( ( power(( 1 + nuTasaPer), rgInfoVenta.Numero_De_Cuotas) *(nuTasaPer - (regPlanFina.pldifagr/100))) / ( power((1 + nuTasaPer), rgInfoVenta.Numero_De_Cuotas)- power(( 1 + (regPlanFina.pldifagr/100)), rgInfoVenta.Numero_De_Cuotas)))));
    sbDatosInstalacion := '<M_INSTALACION_DE_GAS_100340>'||
                            '<COMMERCIAL_PLAN_ID>'||rgInfoVenta.Commercial_Plan_Id||'</COMMERCIAL_PLAN_ID>'||
                            '<TOTAL_VALUE>'||nuValorVenta||'</TOTAL_VALUE>'||
                            '<PLAN_DE_FINANCIACION>'||rgInfoVenta.Plan_De_Financiacion||'</PLAN_DE_FINANCIACION>'||
                            '<INITIAL_PAYMENT>'||rgInfoVenta.Initial_Payment||'</INITIAL_PAYMENT>'||
                            '<NUMERO_DE_CUOTAS>'||to_char(rgInfoVenta.Numero_De_Cuotas)||'</NUMERO_DE_CUOTAS>'||
                            '<CUOTA_MENSUAL>'||nuCuotaMensual||'</CUOTA_MENSUAL>'||
                            '<INIT_PAYMENT_MODE>'||rgInfoVenta.Init_Payment_Mode||'</INIT_PAYMENT_MODE>'||
                            '<INIT_PAY_RECEIVED>'||rgInfoVenta.Init_Pay_Received||'</INIT_PAY_RECEIVED>'||
                            '<USAGE>'||rgInfoVenta.Usage||'</USAGE>'||
                            '<INSTALL_TYPE>'||to_char(rgInfoVenta.Install_Type)||'</INSTALL_TYPE>'||
                             sbDatosPromocion||
                             '<C_GAS_10361>'||
                                           '<C_MEDICION_10362/>'||
                             '</C_GAS_10361>'||
                          '</M_INSTALACION_DE_GAS_100340>'||
                         '</P_VENTA_DE_GAS_POR_FORMULARIO_XML_PLAN_COMERCIAL_ESPECIAL_100354>';



        --se realiza creacion de actividades a constructora
    IF rgInfoVenta.activcxc = 1 THEN
    --se consulta item de cxc
    OPEN cuItems(sbactividadcxc);
    FETCH cuItems INTO nuactividadcxc;
    IF cuItems%NOTFOUND THEN
       CLOSE cuItems;
       pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
            'Solicitud ['||inuSolicitud||'] error actividad de cxc no existe, parametro  LDC_ACTICXCRE');
    END IF;
    CLOSE cuItems;
  END IF;

  IF rgInfoVenta.actirevcer = 1 THEN
    OPEN cuItems(sbactividadcert);
    FETCH cuItems INTO NUactividadcert;
    IF cuItems%NOTFOUND THEN
      CLOSE cuItems;
      pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
        'Solicitud ['||inuSolicitud||'] error actividad de certificacion no existe, parametro  LDC_ACTREVCER');
    END IF;
    CLOSE cuItems;
  END IF;

  --se recorren direeciones y se registran ventas
    FOR reg IN cuDeseDirecciones LOOP
       onuPack := null;
       nuMotiveId := null;
       onuErrorCode := null;
       osbErrorMessage := null;
       sbXML := null;
       ionuOrderId := NULL;
	   
       sbDatosSolicitud := null;
       nuformulario := null;
       sbDatosCliente := null;

        nudireccion := reg.Direccion;
		
		IF cuCategorias%ISOPEN then
			CLOSE cuCategorias;
		END IF;
	  
		OPEN cuCategorias(nudireccion);
		FETCH cuCategorias INTO nuCategoria,nuSucategoria;
		CLOSE cuCategorias;

        open cuSigFormulario(nuUnidadOpe);
        fetch cuSigFormulario into nuformulario;
        close cuSigFormulario;
         --se cargan datos de la solicitud
       sbDatosSolicitud := '<P_VENTA_DE_GAS_POR_FORMULARIO_XML_PLAN_COMERCIAL_ESPECIAL_100354 ID_TIPOPAQUETE="100354">'||
                          '<FECHA_DE_SOLICITUD>'||SYSDATE||'</FECHA_DE_SOLICITUD>'||
                          '<ID>'||regDatosVenta.Person_Id||'</ID>'||
                          '<POS_OPER_UNIT_ID>'||regDatosVenta.Pos_Oper_Unit_Id||'</POS_OPER_UNIT_ID>'||
                          '<PROYECTO_CONSTRUCTORA>'||regDatosVenta.PROYECTO_CONSTRUCTORA||'</PROYECTO_CONSTRUCTORA>'||
                          '<DOCUMENT_TYPE_ID>1</DOCUMENT_TYPE_ID>
                           <DOCUMENT_KEY>'||nuformulario||'</DOCUMENT_KEY><PROJECT_ID/>'||
                          '<COMMENT_>'||regDatosVenta.Comment_||'</COMMENT_>';


        sbDatosCliente := '<DIRECCION>'||nudireccion||'</DIRECCION>'||
                          '<CATEGORIA>'||nuCategoria||'</CATEGORIA>'||
                          '<SUBCATEGORIA>'||nuSucategoria||'</SUBCATEGORIA>'||
                          '<TIPO_DE_IDENTIFICACION>'||regDatosVenta.Tipo_De_Identificacion||'</TIPO_DE_IDENTIFICACION>'||
                          '<IDENTIFICATION>'||regDatosVenta.Identification||'</IDENTIFICATION>'||
                          '<SUBSCRIBER_NAME>'||regDatosVenta.Subscriber_Name||'</SUBSCRIBER_NAME>'||
                          '<APELLIDO>'||regDatosVenta.Apellido||'</APELLIDO>'||
                          '<COMPANY>'||regDatosVenta.Company||'</COMPANY>'||
                          '<TITLE>'||regDatosVenta.Title||'</TITLE>'||
                          '<CORREO_ELECTRONICO>'||regDatosVenta.Correo_Electronico||'</CORREO_ELECTRONICO>'||
                          '<PERSON_QUANTITY>'||regDatosVenta.Person_Quantity||'</PERSON_QUANTITY>'||
                          '<OLD_OPERATOR>'||regDatosVenta.Old_Operator||'</OLD_OPERATOR>'||
                          '<VENTA_EMPAQUETADA>N</VENTA_EMPAQUETADA>'||
                          '<UNIDAD_DE_TRABAJO_INSTALADORA>'||rgInfoVenta.Unidad_insta||'</UNIDAD_DE_TRABAJO_INSTALADORA>'||
                          '<UNIDAD_DE_TRABAJO_CERTIFICADORA>'||rgInfoVenta.unidad_certi||'</UNIDAD_DE_TRABAJO_CERTIFICADORA>'

                          ;

         sbXML :=  sbDatosEncXML|| chr(13) ||sbDatosSolicitud|| chr(13) ||sbDatosCliente|| chr(13) ||sbDatosInstalacion;
       
        savepoint ventas;
        prregistraVenta (sbXML,onuPack,  nuMotiveId, onuErrorCode, osbErrorMessage);

        IF onuErrorCode <> 0 THEN
           pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                          'Solicitud ['||inuSolicitud||'] error al generar venta '||sbDatos||' '||osbErrorMessage);

            raise pkg_error.controlled_error;
		else
          commit;
        END IF;


		IF  rgInfoVenta.activcxc = 1 OR  rgInfoVenta.actirevcer = 1 THEN

		  IF cuDatosMotivo%ISOPEN THEN
			 CLOSE cuDatosMotivo;
		  END IF;

		  OPEN cuDatosMotivo;
		  FETCH cuDatosMotivo INTO regMotivos;
		  CLOSE cuDatosMotivo;
		END IF;
		IF   rgInfoVenta.activcxc = 1 THEN

				  api_createorder(nuactividadcxc,
								  null,
								  null,
								  null,
								  null,
								  nudireccion,
								  null,
								  null,
								  null,
								  null,
								  null,
								  SYSDATE,
								  null,
								  'Orden de Cxc venta a constructora '|| onuPack,
								  null,
								  null,
								  null,
								  null,
								  null,
								  null,
								  null,
								  0,
								  null,
								  null,
								  null,
								  null,
								  ionuOrderId,
								  ionuOrderactivityid,
								  onuErrorCode,
								  osbErrorMessage
								 );
										 
				IF onuErrorCode <> 0 THEN
					pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
							  'Solicitud ['||inuSolicitud||'] error al generar orden de cxc '||osbErrorMessage);

				ELSE
					 update or_order_activity oa
						   set package_id =onuPack , motive_id =nuMotiveId ,
							 subscriber_id = regMotivos.subscriber_id , subscription_id =regMotivos.subscription_id ,product_id = regMotivos.product_id
					  where oa.order_id=ionuOrderId;
				END IF;
		END IF;



			--se realiza creacion de actividades a constructora
		  IF rgInfoVenta.actirevcer = 1 THEN

				  api_createorder(nuactividadcert,
								  null,
								  null,
								  null,
								  null,
								  nudireccion,
								  null,
								  null,
								  null,
								  null,
								  null,
								  SYSDATE,
								  null,
								  'Orden de Revision a venta a constructora '|| onuPack,
								  null,
								  null,
								  null,
								  null,
								  null,
								  null,
								  null,
								  0,
								  null,
								  null,
								  null,
								  null,
								  ionuOrderId,
								  ionuOrderactivityid,
								  onuErrorCode,
								  osbErrorMessage
								 );
			  IF onuErrorCode <> 0 THEN

					pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
							  'Solicitud ['||inuSolicitud||'] error al generar orden de insp /cert '||osbErrorMessage);

				ELSE
					 update or_order_activity oa
						   set package_id =onuPack , motive_id =nuMotiveId ,
							 subscriber_id = regMotivos.subscriber_id , subscription_id =regMotivos.subscription_id ,product_id = regMotivos.product_id
					  where oa.order_id=ionuOrderId;
				END IF;
      END IF;


    END LOOP;

  EXCEPTION
    when pkg_error.controlled_error then

		pkg_error.getError(onuErrorCode, osbErrorMessage);
         raise pkg_error.controlled_error;

  when OTHERS then

	   pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                        'Error no controlado en PRGENERAVENTPLES '||sqlerrm);

  END PRGENERAVENTPLES;

  PROCEDURE PRGENEPAGOVENTCONESP(inuSolicitud IN mo_packages.package_id%type) IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: PRGENEPAGOVENTCONESP
        Descripcion:        proceso que se encarga de registrar los pagos

        Autor    : Josh Brito
        Fecha    : 26/04/2019

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        20/04/2019  Jbrito          Creacion
        17/11/2020   olsoftware       CA 568 se cambia el sysdate por fecha de pago
        ******************************************************************/




        nuContrato NUMBER; --se almacena corato de la solicitud
        nuCupon  CUPON.cuponume%type;
        nuValor  CUPON.cupovalo%type;
        nuBanco pagos.pagobanc%type;
        nuSucursal  pagos.pagosuba%type;
        sbFormaPago RC_DETATRBA.DETBFOPA%TYPE;


        isbXmlPayment clob;

       isbXmlReference   clob ;
       osbxmlcoupons     clob;
       onuErrorCode  number;
       osbErrorMessage  varchar2(4000);
       inuRefType  NUMBER:=1;

        --se consulta cupon a pagar
        CURSOR cuCuponaPagar IS
        SELECT cuponume, cupovalo
        FROM CUPON
        WHERE CUPODOCU = TO_CHAR(inuSolicitud)
         AND cuposusc = nuContrato
         AND cupoflpa = 'N'
         AND cupovalo > 0;


    CURSOR cuGetContrato IS
    SELECT SUBSCRIPTION_ID
    FROM mo_motive
    WHERE package_id = inuSolicitud;


   --INICIA CA 568
   dtFechPago DATE;

   --FIN CA 568

   --se obtiene banco del pago de la constructora
  CURSOR cuGetbancoPagoCons IS
  SELECT p.pagotdco, PAGOSUBA, PAGOBANC, pagofepa
  FROM pagos p, cupon c, LDC_PROYSOLES SP, LDC_PROYECTO_CONSTRUCTORA py
  WHERE p.PAGOCUPO = c.CUPONUME
    and c.CUPODOCU = to_char(py.ID_SOLICITUD)
    and sp.package_id = inuSolicitud
    and sp.ID_PROYECTO = py.ID_PROYECTO
    and c.CUPOSUSC = py.SUSCRIPCION
    and c.CUPOFLPA = 'S';

    --se consulta informacion del plan especial
    CURSOR cuCuotaInicial IS
    SELECT   confcuotaini initial_payment
    FROM ldc_confplco, LDC_COTIZACION_CONSTRUCT co, LDC_PROYECTO_CONSTRUCTORA pc, LDC_PROYSOLES SP
    WHERE codconfplco = co.PLAN_COMERCIAL_ESPCL
     AND co.id_proyecto = pc.ID_PROYECTO
   and sp.package_id = inuSolicitud
   and sp.ID_PROYECTO = pc.ID_PROYECTO
     AND co.estado IN   ('A', 'P');

  CURSOR cugetConcilia IS
  SELECT CONCCONS
  FROM concilia
  WHERE CONCBANC = nuBanco
   AND TRUNC(CONCFEPA) >= TRUNC(dtFechPago)
    AND CONCCIAU = 'S'
    AND CONCFLPR = 'N'
   ;

   nuCuotaInicial NUMBER := 0;
   sbTerminal  VARCHAR2(100);
   nuConcilia number;
   
   sbProceso varchar2(400):= csbPaquete||'PRGENEPAGOVENTCONESP';

  BEGIN


	OPEN cuGetContrato;
	FETCH cuGetContrato INTO nuContrato;
	IF cuGetContrato%NOTFOUND THEN
		pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
					'Error no se pudo recuperar contrato de la solicitud');
	END IF;
	CLOSE cuGetContrato;


	--se carga cupon
	OPEN cuCuponaPagar;
	FETCH cuCuponaPagar INTO nuCupon, nuValor;
	CLOSE cuCuponaPagar;

	OPEN cuCuotaInicial;
	FETCH cuCuotaInicial INTO nuCuotaInicial;
	CLOSE cuCuotaInicial;

	--se carga banco del pago del constructor
	open cuGetbancoPagoCons;
	fetch cuGetbancoPagoCons into sbFormaPago, nuSucursal, nuBanco, dtFechPago;
	close cuGetbancoPagoCons;

  OPEN cugetConcilia;
  FETCH cugetConcilia INTO nuConcilia;
  CLOSE cugetConcilia;
	sbTerminal := pkg_session.fsbgetTerminal;

  IF nuConcilia IS NULL THEN
      isbXmlPayment := '<?xml version="1.0" encoding="utf-8" ?>
                                  <Informacion_Pago>
                                   <Conciliacion>
                                    <Cod_Conciliacion/>
                                    <Entidad_Conciliacion>'||nuBanco||'</Entidad_Conciliacion>
                                    <Fecha_Conciliacion>'||to_char(sysdate)||'</Fecha_Conciliacion>
                                   </Conciliacion>
                                   <Entidad_Recaudo>'||nuBanco||'</Entidad_Recaudo>
                                   <Punto_Pago>'||nuSucursal||'</Punto_Pago>
                                   <Valor_Pagado>'||nuValor||'</Valor_Pagado>
                                   <Fecha_Pago>'||to_char(dtFechPago)/*CA 568 to_char(sysdate)*/||'</Fecha_Pago>
                                   <No_Transaccion/>
                                   <Forma_Pago>'||sbFormaPago||'</Forma_Pago>
                                   <Clase_Documento/>
                                   <No_Documento/>
                                   <Ent_Exp_Documento/>
                                   <No_Autorizacion/>
                                   <No_Meses/>
                                   <No_Cuenta/>
                                   <Programa>OS_PAYMENT</Programa>
                                   <Terminal>'||sbTerminal||'</Terminal>
                                  </Informacion_Pago>';
  ELSE
          isbXmlPayment := '<?xml version="1.0" encoding="utf-8" ?>
                                  <Informacion_Pago>
                                   <Conciliacion>
                                    <Cod_Conciliacion>'||nuConcilia||'</Cod_Conciliacion>
                                    <Entidad_Conciliacion>'||nuBanco||'</Entidad_Conciliacion>
                                    <Fecha_Conciliacion>'||to_char(sysdate)||'</Fecha_Conciliacion>
                                   </Conciliacion>
                                   <Entidad_Recaudo>'||nuBanco||'</Entidad_Recaudo>
                                   <Punto_Pago>'||nuSucursal||'</Punto_Pago>
                                   <Valor_Pagado>'||nuValor||'</Valor_Pagado>
                                   <Fecha_Pago>'||to_char(dtFechPago)/*CA 568 to_char(sysdate)*/||'</Fecha_Pago>
                                   <No_Transaccion/>
                                   <Forma_Pago>'||sbFormaPago||'</Forma_Pago>
                                   <Clase_Documento/>
                                   <No_Documento/>
                                   <Ent_Exp_Documento/>
                                   <No_Autorizacion/>
                                   <No_Meses/>
                                   <No_Cuenta/>
                                   <Programa>OS_PAYMENT</Programa>
                                   <Terminal>'||sbTerminal||'</Terminal>
                                  </Informacion_Pago>';

  END IF;
	isbXmlReference    := '<?xml version="1.0" encoding="utf-8" ?>
                                <Pago_Cupon>
                                 <Cupon>'||nuCupon||'</Cupon></Pago_Cupon>';

    --se realiza pago
    IF nuCupon is not null THEN
      API_PAYMENTSREGISTER(inuRefType, isbXMLReference, isbXMLPayment, osbXMLCoupons, onuErrorCode, osbErrorMessagE);

      IF onuErrorCode <> 0 THEN
         pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                        osbErrorMessagE);

      END IF;
    ELSE
     IF nuCuotaInicial > 0 then
         pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                        'No se ha generado cupon de pago de cuota inicial a la solicitud.Por favor revisar');
     END IF;

  END IF;

  EXCEPTION
      when pkg_error.controlled_error then
        pkg_error.getError(onuErrorCode, osbErrorMessage);
        pkg_traza.trace(osbErrorMessage,cnuNVLTRC);
	    pkg_traza.trace(sbProceso, cnuNVLTRC,pkg_traza.fsbFIN_ERC); 
		 --rollback;
         raise;
   when others then
         pkg_error.setError;
	     pkg_traza.trace(sbProceso, cnuNVLTRC,pkg_traza.fsbFIN_ERR); 
         raise pkg_error.controlled_error;
 
  END PRGENEPAGOVENTCONESP;

  PROCEDURE PRANULAPAGOVENTCONESP(inuSolicitud IN mo_packages.package_id%type) is
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: PRANULAPAGOVENTCONESP
    Descripcion:        proceso que se encarga de anular pago a constructora

    Autor    : Josh Brito
    Fecha    : 26/04/2019

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    20/04/2019  Jbrito          Creacion
    ******************************************************************/
     nuContrato NUMBER; --se almacena corato de la solicitud


    nuCupon  CUPON.cuponume%type;
    nuCausalAnu NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CAUSANULPAGO',NULL);

    CURSOR cuGetContrato IS
    SELECT SUBSCRIPTION_ID
  FROM mo_motive
  WHERE package_id = inuSolicitud;

    --se consulta cupon a pagar
    CURSOR cuCuponanular IS
    SELECT cuponume
    FROM CUPON
    WHERE CUPODOCU = TO_CHAR(inuSolicitud)
     AND cuposusc = nuContrato
     AND cupoflpa = 'S'
	 AND CUPOTIPO = 'DE';

	  --se consulta informacion del plan especial
    CURSOR cuCuotaInicial IS
    SELECT   confcuotaini initial_payment
    FROM ldc_confplco, LDC_COTIZACION_CONSTRUCT co, LDC_PROYECTO_CONSTRUCTORA pc, LDC_PROYSOLES SP
    WHERE codconfplco = co.PLAN_COMERCIAL_ESPCL
     AND co.id_proyecto = pc.ID_PROYECTO
	 and sp.package_id = inuSolicitud
	 and sp.ID_PROYECTO = pc.ID_PROYECTO
     AND co.estado IN   ('A', 'P');

   nuCuotaInicial NUMBER := 0;

    onuErrorCode NUMBER;
   osbErrorMessage VARCHAR2(4000);

  BEGIN

	OPEN cuGetContrato;
	FETCH cuGetContrato INTO nuContrato;
	IF cuGetContrato%NOTFOUND THEN
	  pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
						'Error no se pudo recuperar contrato de la solicitud');
	END IF;
	CLOSE cuGetContrato;

	OPEN cuCuponanular;
	FETCH cuCuponanular INTO nuCupon;
	CLOSE cuCuponanular;

	PKERRORS.SETAPPLICATION(csbProgAnulaPagos);

	IF nuCupon IS NOT NULL THEN
		  rc_boannulpayments.collectingannul(inupagocupo => nuCupon,
											 isbpaancaap => nuCausalAnu,
											 isbpaanobse => 'ANULACION DE PAGO CONSTRUCTORA PLAN ESPECIAL: SOLICITUD ['||inuSolicitud||']');
	ELSE
	  OPEN cuCuotaInicial;
	  FETCH cuCuotaInicial INTO nuCuotaInicial;
	  CLOSE cuCuotaInicial;

	  IF nuCuotaInicial > 0 THEN
	     pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
						'Se debe realizar el pago de cuotas inicial configurado en el plan especial escogido.');
	  END IF;

	END IF;

	--se eliminan registrao de ordenes planeadas
	DELETE FROM OR_PLANNED_ITEMS  WHERE ORDER_ACTIVITY_ID IN (SELECT  OA.ORDER_ACTIVITY_ID FROM OR_ORDER_ACTIVITY OA WHERE OA.PACKAGE_ID = inuSolicitud AND OA.STATUS = 'P');
    DELETE FROM OR_ORDER_ACTIVITY OA WHERE OA.PACKAGE_ID = inuSolicitud AND OA.STATUS = 'P';


   EXCEPTION
      when pkg_error.controlled_error then
       -- rollback;
		pkg_error.getError(onuErrorCode, osbErrorMessage);
          pkg_traza.trace(osbErrorMessage,cnuNVLTRC);

         raise pkg_error.controlled_error;
   when others then
         pkg_error.setError;
        raise pkg_error.controlled_error;
  END PRANULAPAGOVENTCONESP;

  FUNCTION fnuGetUnidDisp (inuPerson IN NUMBER, inuProyecto IN NUMBER) RETURN NUMBER IS
	/*****************************************************************
		Propiedad intelectual de Gases del Caribe.

		Nombre del Paquete: fnuGetUnidDisp
		Descripcion:        Obtiene unidad disponible segun la direccion

		Autor    : Luis Javier Lopez
		Fecha    : 10/03/2020

		Historia de Modificaciones

		DD-MM-YYYY    <Autor>.              Modificacion
		-----------  -------------------    -------------------------------------
		******************************************************************/

    nuDepa NUMBER; --se almacena departamento
    nuUnidadAtla NUMBER  := dald_parameter.fnuGetNumeric_Value('LDC_UNIDTRABDISPA', null);--se almacena unidad del atlantico
    nuUnidadMagd NUMBER := dald_parameter.fnuGetNumeric_Value('LDC_UNIDTRABDISPM', null);--se almacena unidad del magdalena
    nuUnidadcesar NUMBER := dald_parameter.fnuGetNumeric_Value('LDC_UNIDTRABDISPC', null);--se almacena unidad del cesar
    nuUnidad NUMBER; --se almacena unidad a validar
    nuUnidadDisp NUMBER;
	sbProceso varchar2(40):= csbPaquete||'fnuGetUnidDisp';


   --se obtiene departamento
    CURSOR cuObtiDepProy IS
    SELECT pkg_bcdirecciones.fnuGetUbicaGeoPadre(pkg_bcdirecciones.fnuGetDepartamento(c.ADDRESS_ID)) depa
    FROM ldc_proyecto_constructora py, ge_subscriber c
    WHERE id_proyecto = inuProyecto
	  and py.CLIENTE = c.subscriber_id;


	--se obtiene unidad disponible segun la persona
   CURSOR cuGetUnidad (inuUnidad NUMBER) IS
   SELECT or_operating_unit.operating_unit_id
    FROM or_operating_unit,
       or_oper_unit_persons
    WHERE or_operating_unit.operating_unit_id = or_oper_unit_persons.operating_unit_id
    AND or_operating_unit.oper_unit_classif_id = 22
    AND or_oper_unit_persons.person_id = inuPerson
    AND or_operating_unit.operating_unit_id = DECODE(inuUnidad, -1,or_operating_unit.operating_unit_id, inuUnidad);


 BEGIN
   --se obtiene departamento
   OPEN cuObtiDepProy;
   FETCH cuObtiDepProy INTO nuDepa;
   CLOSE cuObtiDepProy;
   
   pkg_traza.trace(sbProceso, cnuNVLTRC, csbInicio);
   
   pkg_traza.trace(sbProceso || 'nuDepa' ||nuDepa,cnuNVLTRC);


   --se valida el departamento
   if nuDepa is not null THEN
      IF nuDepa = 2 THEN
	     nuUnidad := nuUnidadcesar;
	  ELSIF nuDepa = 4 THEN
	     nuUnidad := nuUnidadMagd;
	  ELSE
	     nuUnidad := nuUnidadAtla;
	  END IF;

	  OPEN cuGetUnidad(nuUnidad);
	  FETCH cuGetUnidad INTO nuUnidadDisp;
	  IF cuGetUnidad%NOTFOUND THEN
	     nuUnidadDisp :=  nuUnidadAtla;
	  END IF;
	  CLOSE cuGetUnidad;

   ELSE
    OPEN cuGetUnidad(-1);
	  FETCH cuGetUnidad INTO nuUnidadDisp;
	  IF cuGetUnidad%NOTFOUND THEN
	     nuUnidadDisp :=  nuUnidadAtla;
	  END IF;
	  CLOSE cuGetUnidad;
   END IF;

  pkg_traza.trace(' UNIDAD ['||nuUnidadDisp||']',cnuNVLTRC);
  
  pkg_traza.trace(sbProceso, cnuNVLTRC, pkg_traza.csbFIN);
  
   RETURN  nuUnidadDisp;

 EXCEPTION
  when pkg_error.controlled_error then
	 raise pkg_error.controlled_error;
  when others then
	 pkg_error.setError;

 END fnuGetUnidDisp;


END ldc_boVentaConstructora;
/