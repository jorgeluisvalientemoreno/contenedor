CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKFACTKIOSCO_GDC
AS
    /************************************************************************
    PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

           PAQUETE : LDCI_PKFACTKIOSCO
             AUTOR : Hector Fabio Dominguez
             FECHA : 29/01/2013
         RICEF : I045

    DESCRIPCION : Paquete de Impresion Duplciado para Kioscos,tiene como funcion principal la
                   consulta de informacion de los contratos y la consulta de datos para impresion


    Historia de Modificaciones

    Autor           Fecha       Descripcion.
    hectorfdv       05-03-2014  Ajuste en el calculo del saldo anteror TQ 3034
    hectorfdv       31-03-2014  Ajuste para cuando el retorno de la api de saldos sea nulo TQ 3034
    hectorfdv       29-04-2014  Ajuste de retorno en la funcion fnuConsultComponentCostoGen para evitar retorno nulo TQ 3292
    FCastro         03-05-2016  Se modifica PROGENERAFACT para cambiar el formato de conversion a caracter de la columna
                                InteresFinanciacion ya que esta colocando 3 espacios en blanco al inicio y genera error en el XML
    Esantiago       23-09-2020  ca234: Se modifica PROGENERAFACTGDC  y RfConcepParcial
    gonzalez        14-09-2023  OSF-1565: Se modifica el servicio FnuGetSaldoAnterior. Se realizan ajustes de estandar v8.
    dsaltarin       12/08/2024  SD-20871: De acuerdo con instrucciones de Luis Javier Lopez se cambia el llamado a esto LDC_DETALLEFACT_GASCARIBE.RFDATOSCONCEPTOS por 
                                ldc_detallefact_gascaribe.rfdatosconcestadocuenta debido a que por los cambios de facturación electrónica el cursor que se usaba devuelve mas datos.
    Jorge Valiente  06/02/2025  OSF-3938: Validar existencia del punto de atencion y medio de recepcion del funcional
                                            conectado para generar duplicado                              
    ************************************************************************/

    FUNCTION FNUCONSULTAVALORANTFACT (nuSusccodi IN suscripc.susccodi%TYPE)
        RETURN NUMBER;

    FUNCTION FNUCONSULTASADOACT (nuSusccodi IN suscripc.susccodi%TYPE)
        RETURN NUMBER;

    FUNCTION FNUCONSULTASADOANT (nuSusccodi IN suscripc.susccodi%TYPE)
        RETURN NUMBER;

    FUNCTION fsbOrdenSuspContrato (nuSusccodi IN suscripc.susccodi%TYPE)
        RETURN VARCHAR2;

    FUNCTION fsbProcFactura (nuSusccodi IN suscripc.susccodi%TYPE)
        RETURN VARCHAR2;

    FUNCTION FSBCONSULTAFECHREV (inuNuse IN NUMBER)
        RETURN VARCHAR2;

    PROCEDURE PROCONSULTASUSCRIPC ( inuSusccodi         IN  suscripc.susccodi%TYPE,
                                    isbIdentificacion   IN  VARCHAR2,
                                    isbTelefono         IN  VARCHAR2,
                                    nuServicio          IN  NUMBER,
                                    CUSUSCRIPCIONES     OUT SYS_REFCURSOR,
                                    ocuMensaje          OUT SYS_REFCURSOR,
                                    onuErrorCode        OUT NUMBER,
                                    osbErrorMessage     OUT VARCHAR2);

    FUNCTION fsbValidaContrato (nuSusccodi IN suscripc.susccodi%TYPE)
        RETURN VARCHAR2;

    FUNCTION fsbFormatoFactContrato (nuSusccodi IN suscripc.susccodi%TYPE)
        RETURN VARCHAR2;

    FUNCTION fsbValidaIdentificacion (
        nuIdentification   IN ge_subscriber.identification%TYPE)
        RETURN VARCHAR2;

    PROCEDURE OUT (sbMens IN VARCHAR2);

    FUNCTION fsbCaraCodiBarr128GRQ (isbCadeOrig IN VARCHAR2)
        RETURN VARCHAR2;

    PROCEDURE proCnltaDupliFact (inuSuscCodi       IN  SUSCRIPC.SUSCCODI%TYPE,
                                 orDocuments       OUT SYS_REFCURSOR,
                                 onuErrorCode      OUT NUMBER,
                                 osbErrorMessage   OUT VARCHAR2);

    PROCEDURE PROGENERAFACT (inuSusccodi        IN  suscripc.susccodi%TYPE,
                             inuSaldoGen        IN  NUMBER,
                             isbTipoSaldo       IN  VARCHAR2,
                             CUDATOSBASIC       OUT SYS_REFCURSOR,
                             CUFACTDETA         OUT SYS_REFCURSOR,
                             CURANGOS           OUT SYS_REFCURSOR,
                             CUHISTORICO        OUT SYS_REFCURSOR,
                             CULECTURAS         OUT SYS_REFCURSOR,
                             CUCONSUMOS         OUT SYS_REFCURSOR,
                             CUCOMPONENTES      OUT SYS_REFCURSOR,
                             osbSeguroLiberty   OUT VARCHAR2,
                             osbOrdenSusp       OUT VARCHAR2,
                             osbProcFact        OUT VARCHAR2,
                             onuErrorCode       OUT NUMBER,
                             osbErrorMessage    OUT VARCHAR2,
                             isbSistema         IN  VARCHAR2 DEFAULT 'N');

    FUNCTION fnuObtenerInteresMora (inuCupon       IN  CUPON.CUPONUME%TYPE,
                                    inuFactura     IN  NUMBER,
                                    onuErrorCode   OUT NUMBER,
                                    osbErrorMsg    OUT VARCHAR2)
        RETURN ta_vigetaco.vitcporc%TYPE;

    FUNCTION fnugetgeo_loca_father_id (iNuGeo IN NUMBER)
        RETURN NUMBER;

    FUNCTION fsbgetdescription (iNuGeo IN NUMBER)
        RETURN VARCHAR2;

    FUNCTION fnuConsultComponentCosto ( inuConcept    IN concepto.conccodi%TYPE,
                                        inuCompType   IN lectelme.leemtcon%TYPE,
                                        inuFOT        IN NUMBER,
                                        nufactura     IN factura.factcodi%TYPE, --factura
                                        nuSuscripc    IN servsusc.SESUSUSC%TYPE)
        RETURN ta_vigetaco.vitcvalo%TYPE;

    FUNCTION fnuConsultComponentCostoGen (  inuConcept    IN concepto.conccodi%TYPE,
                                            inuCompType   IN lectelme.leemtcon%TYPE,
                                            inuFOT        IN NUMBER,
                                            nufactura     IN factura.factcodi%TYPE,--factura
                                            nuSuscripc    IN servsusc.SESUSUSC%TYPE)
        RETURN ta_vigetaco.vitcvalo%TYPE;

    FUNCTION fsbGetDesviacion (inuFactura IN NUMBER)
        RETURN VARCHAR2;

    PROCEDURE prcConsultaDatosAdic (CUOTROS OUT SYS_REFCURSOR);

    PROCEDURE PROGENERAFACTGDC ( inuSusccodi       IN suscripc.susccodi%TYPE,
                                inuSaldoGen        IN NUMBER,
                                isbTipoSaldo       IN VARCHAR2,
                                CUDATOSBASIC       OUT SYS_REFCURSOR,
                                CUCONCEPT          OUT SYS_REFCURSOR,
                                CUREVISION         OUT SYS_REFCURSOR,
                                CUHISTORICO        OUT SYS_REFCURSOR,
                                CULECTURAS         OUT SYS_REFCURSOR,
                                CUTOTALES          OUT SYS_REFCURSOR,
                                CURANGOS           OUT SYS_REFCURSOR,
                                CUCOMPCOST         OUT SYS_REFCURSOR,
                                CUCODBAR           OUT SYS_REFCURSOR,
                                CUTASACAMB         OUT SYS_REFCURSOR,
                                CUOTROS            OUT SYS_REFCURSOR,
                                CUMARCAS           OUT SYS_REFCURSOR,               --CASO 200-1515
                                osbSeguroLiberty   OUT VARCHAR2,                     --Campo Nuevo,
                                osbOrdenSusp       OUT VARCHAR2,                     -- Campo Nuevo
                                osbProcFact        OUT VARCHAR2,                     -- Campo Nuevo
                                osbImprimir        OUT VARCHAR2,
                                onuErrorCode       OUT NUMBER,
                                osbErrorMessage    OUT VARCHAR2,
                                ISBSISTEMA         IN  VARCHAR2 DEFAULT 'N');

    ----CASO 200-1626
    /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     :   fnuGetProducto
    Descripcion :   Servicio que permitira obtener el saldo anterior de un suscriptor
    Autor       :   Jorge valiente

    Historia de Modificaciones
    Fecha               Autor              Modificacion
    =========           =========          ====================
    **************************************************************************/
    FUNCTION FnuGetSaldoAnterior (InuContrato NUMBER, InuFactura NUMBER)
        RETURN NUMBER;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RfConcepParcial
    Descripcion    : Procedimiento para mostrar el iva y el subtotal de los no regulados.
    Autor          : Gabriel Gamarra - Horbath Technologies.

    Parametros           Descripcion
    ============         ===================

    orfcursor            Retorna los datos

    Fecha           Autor               Modificacion
    =========       =========           ====================
    28/12/2023      adrianavg           OSF-1891: Se ajusta cuDatosDiferido el parametro p_difecodi de numérico a cargos.cargdoso%TYPE
    13/12/2023      adrianavg           OSF-1819: Se implementa pkg_error.prInicializaError.
                                        Se declaran variables para el manejo de traza y de error.
                                        Se reemplaza SELECT-INTO por cursor cuIdentificacion
                                        Se reemplaza SELECT-SUM-INTO por cuSumaValorSubsidio
                                        Se reemplaza SELECT-SUM-INTO por cuValorPorcentaje
                                        Se reemplaza SELECT-SUM-INTO por cuDatosDiferido
                                        Se reemplaza SELECT-SUM-INTO por cuCargo
                                        Se reemplaza SELECT-SUM-INTO por cuCargdoso
                                        Se reemplaza SELECT-SUM-INTO por cuDifesape
                                        Se retira nuAplicaEntrega200342. En el DECODE del INSERT INTO LDC_CONC_FACTURA_TEMP se asigna directo tbCargosOrdered (i).servicio),
                                        Se retira IF-ENDIF FBLAPLICAENTREGAXCASO ('0000501')
                                        Se retira IF-ENDIF sbAplicaso501 = 'N', Y la parte del ELSE, porque FBLAPLICAENTREGAXCASO ('0000501') arroja N, por lo tanto sbAplicaso501 es N
                                        Ajustar bloque de exceptions según las pautas técnicas
    22/02/2018      Jorge Valiente      CASO 200-1626: Se realizo el copiado de este servicio desde el fuente
                                                       orginal del paquete ldc_detallefact_gascaribe antes de este caso
                                                       y el CASO 200-1360
    18-10-2016      Sandra Mu?oz.       CA200-849: Se acumula en el total del diferido para que sume
                                        el valor de los diferidos que aun no se estan facturando
    12-09-2016      Sandra Mu?oz        CA200-342: Se llena el campo servicio para poder usarlo
                                        para agrupar los conceptos de brilla
    17/12/2015      Agordillo           Modificacion SAO.369165
                                        Se agrega un IF que permite validar si el servicio es 7053,
                                        se asigne null al saldo pendiente y numero de cuotas al diferido dado
                                        que esta informacion no se muestra en la factura
    05/08/2015      Mmejia              Modificacion Aranda.8199 Se traslada la logica que valida los diferidos
                                        que no estan asociados a una cuenta cobro para que se procese antes de
                                        calcular los campos del total mes esto ya que el total mes se
                                        estaba mostrando antes de estos registros en la impresion de la  factura.
    25/06/2015      Mmejia              Modificacion Aranda.6477 Se agrega  la logica para agregar
                                        a los detalles de factura los diferidos que no estan asociados
                                        a una cuenta de cobro.
    19/03/2015      Agordillo           Modificacion Incidente.140493
                                        * Se agrega una condicion cuando se esta agrupando los diferidos para que diferencie
                                        por causa de cargo, dado que a este concepto es al unico que se le muestra el saldo
                                        del diferido, intereses y cuotas pendiente.
                                        * Se agrega una condicion para que se inserte los cargos que son Diferidos pero no
                                        tienen causa de cargo 51-Cuota
                                        * Se agrega una condicion cuando el cargo es interes de un diferido para que solo se
                                        muestre en el cargo si es cuota.
    12/03/2015      Agordillo           Modificacion Incidente.143745
                                        * Se modifica el type tyrcCargosOrd para agrecar el campo signo
                                        * Se modifica para que en la tabla tbCargosOrdered que contiene los cargos
                                        ordenados se agrege el signo del cargo(DB,CR,SA,PA) etc.
                                        * Se cambia la insercion a la tabla LDC_CONC_FACTURA_TMP por LDC_CONC_FACTURA_TEMP
                                        dado que la primera tabla no tiene campo de signo
                                        * Se cambia la forma de insercion en la tabla LDC_CONC_FACTURA_TEMP definiendole
                                        los campos a insertar,para que en posteriores modificaciones de esta no exista
                                        problema para adicionar un nuevo campo y afecte los objetos que tambien la utilicen.
                                        * Se modifica el IF para acumular los totales (tbCargosOrdered(-1).TOTAL)
                                        en usuarios no regulados para que no tenga en cuenta los pagos signo (PA)
    11/11/2014      ggamarra           Creacion.
    ******************************************************************/

    PROCEDURE RfConcepParcial (InuContrato       NUMBER,
                               InuFactura        NUMBER,
                               orfcursor     OUT constants_per.tyRefCursor);

    ----CASO 200-1626

    --Caso 200-1427
    /************************************************************************
       PROCEDIMIENTO : LDCI_PKFACTKIOSCO_OSF_GDC.proSoliDuplicadoKiosco
       AUTOR         : Karem Baquero/Jm Gestion Informatica
       FECHA         : 30/10/2017
       CASO          : 1427
       DESCRIPCION   : Permite listar ordenes por solicitud

      Historia de Modificaciones
      Autor                 Fecha        Descripcion

    ************************************************************************/
    PROCEDURE proSoliDuplicadoKiosco (
        inuSuscCodi       IN     SUSCRIPC.SUSCCODI%TYPE,
        inuRecepTipo      IN     NUMBER,
        sbobservacion     IN     VARCHAR2,
        onuPackageId         OUT mo_packages.package_id%TYPE,
        onuMotiveId          OUT mo_motive.motive_id%TYPE,
        ONUERRORCODE      IN OUT NUMBER,
        OSBERRORMESSAGE   IN OUT VARCHAR2);

    /************************************************************************
    *PROPIEDAD INTELECTUAL
    *
    *    PROCEDURE : mensajesForma
    *    AUTOR     : Daniel Valiente
    *    FECHA     : 8-11-2017
    *    CASO      : 200-1427
    * DESCRIPCION  : Devuelve los mensajes que deberan aparecer en la forma LDFACTDUP
    *
    * Historia de Modificaciones
    ******************************************************************************************/
    PROCEDURE mensajesForma (osbtitulo OUT VARCHAR2, osbmensaje OUT VARCHAR2);

    /************************************************************************
    *PROPIEDAD INTELECTUAL
    *
    *    PROCEDURE : AplicaNETrangosConsumos
    *    AUTOR     : Daniel Valiente
    *    FECHA     : 5-03-2018
    *    CASO      : 200-1427
    * DESCRIPCION  : Instancia APLICA para generar tabla de Cargos en la Factura POR EL .net
    *
    * Historia de Modificaciones
    ******************************************************************************************/
    PROCEDURE AplicaNETrangosConsumos (vaplica IN VARCHAR2);
    /*****************************************************************
       Propiedad intelectual de GDC (c).

       Unidad         : fsbGetPeriodo
       Descripcion    : proceso que devuelve el perorio del diferido
       Autor          : OLSOFTWARE
    Ticket         : 590

       Parametros           Descripcion
       ============         ===================
         inunuse            producto
         inuDiferido        diferido
           Fecha           Autor               Modificacion
       =========       =========           ====================
    *****************************************************************/
    FUNCTION fsbGetPeriodo (inunuse IN NUMBER, inuDiferido IN NUMBER)
        RETURN VARCHAR2;
END LDCI_PKFACTKIOSCO_GDC;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKFACTKIOSCO_GDC
AS
    --CA. 200-904
    cnuCategoriaInd   CONSTANT servsusc.sesucate%TYPE := dald_parameter.fnuGetNumeric_Value ('CODIGO_CATE_INDUSTRIAL', 0) ;
    --variables para el manejo de trazas y error
    csbNOMPKG         CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';
    csbNivelTraza     CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     :   fnuGetProducto
    Descripcion :   Obtiene el producto asociado al contrato
    Autor       :   Gabriel Gamarra - Horbath Technologies

    Historia de Modificaciones
    Fecha               Autor              Modificacion
    =========           =========          ====================
    11-11-2014          ggamarra           Creacion
    25-09-2017          oparra             CA. 200-904 llamado
    12/12/2023          adrianavg          OSF-1819: Se declaran variables para el manejo de trazas y error
                                           Reemplazar SELECT-INTO por cursor cuSesunuse, se añade IF-ENDIF para manejo de notdatafound
                                           Reemplazar SELECT-INTO por cursor cuCuconuse, se añade IF-ENDIF para manejo de notdatafound
                                           Se implementa pkg_error.prInicializaError
                                           Ajustar bloque de exceptions según las pautas técnicas
    **************************************************************************/
    FUNCTION fnuGetProducto (inuFactura IN factura.factcodi%TYPE)
        RETURN NUMBER
    IS
        nuSesunuse   servsusc.sesunuse%TYPE;

        CURSOR cuSesunuse(p_nuFactura factura.factcodi%TYPE)
        IS
        SELECT sesunuse
          FROM servsusc, cuencobr
         WHERE sesunuse = cuconuse
           AND cucofact = p_nuFactura
           AND sesuserv = dald_parameter.fnuGetNumeric_Value ('COD_SERV_GAS')
           AND ROWNUM = 1;

        CURSOR cuCuconuse(p_nuFactura factura.factcodi%TYPE)
        IS
        SELECT cuconuse
          FROM cuencobr
         WHERE cucofact = p_nuFactura
           AND ROWNUM = 1;

        --variables para el manejo de trazas y error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'fnuGetProducto';
        nuError      NUMBER;
        sbError      VARCHAR2(2000);
    BEGIN
        -- Inicialmente se consulta si tiene producto de GAS
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);
        pkg_traza.trace(csbMetodo||' inuFactura: '||inuFactura, csbNivelTraza);

        BEGIN
            OPEN cuSesunuse(inuFactura);
            FETCH cuSesunuse INTO nuSesunuse;
            CLOSE cuSesunuse;
            IF nuSesunuse IS NULL THEN
               pkg_error.setError;
               RAISE NO_DATA_FOUND;
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 pkg_traza.trace(csbMetodo||' NO_DATA_FOUND ', csbNivelTraza);
                 nuSesunuse := -1;
        END;

        -- Si no tiene producto de GAS se selecciona cualquier producto del contrato
        IF (nuSesunuse = -1)
        THEN
        pkg_traza.trace(csbMetodo||' Si no tiene producto de GAS se selecciona cualquier producto del contrato', csbNivelTraza);

            BEGIN
                OPEN cuCuconuse(inuFactura);
                FETCH cuCuconuse INTO nusesunuse;
                CLOSE cuCuconuse;
                IF nuSesunuse IS NULL THEN
                   pkg_error.setError;
                   RAISE NO_DATA_FOUND;
                END IF;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                     pkg_traza.trace(csbMetodo||' NO_DATA_FOUND ', csbNivelTraza);
                     nuSesunuse := 0;
            END;
        END IF;

        pkg_traza.trace(csbMetodo||' nuSesunuse: '||nuSesunuse, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN nuSesunuse;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
             RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS
        THEN
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END fnuGetProducto;

    PROCEDURE prcConsultaDatosAdicGDC (CUOTROS OUT SYS_REFCURSOR)
    AS
        /**************************************************************************
        Propiedad Intelectual de PETI

        Funcion     :  prcConsultaDatosAdicGDC
        Descripcion :  Permite consultar los datos adicionales de la factura
                      es una extraccion de las reglas definidas en FCED FACTURA_MASIVA_EFIGAS

        Autor       : Hector Fabio Dominguez / Arquitecsoft
        Fecha       : 17-12-2014

        Historia de Modificaciones
          Fecha               Autor                Modificacion
        =========           =========          ====================
        12/12/2023          adrianavg          OSF-1819: Se ajusta al nombre correcto prcConsultaDatosAdicGDC en la descripción
                                               Se declaran variables para el manejo de trazas
                                               Se implementa pkg_error.prInicializaError
                                               Se reemplaza obtenervalorinstancia por api_obtenervalorinstancia
                                               Ajustar bloque de exceptions según las pautas técnicas
        23-04-2019          elal               se coloca formato al campo cupo de brilla
        17-12-2014          Hectord            Creacion.
        **************************************************************************/

        --Control de errores
        onuErrorCode       NUMBER;
        osbErrorMessage    VARCHAR2 (2000);
        nuContratoBrilla   NUMBER;
        nuCupoBrilla       NUMBER;

        --variables para el manejo de trazas
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'prcConsultaDatosAdicGDC';

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( onuErrorCode, osbErrorMessage);

        nuContratoBrilla := API_OBTENERVALORINSTANCIA ('FACTURA', 'FACTSUSC');
        pkg_traza.trace(csbMetodo||' nuContratoBrilla: '||nuContratoBrilla, csbNivelTraza);

        nuCupoBrilla :=  LD_BONONBANKFINANCING.FNUGETAVALIBLEQUOTE (nuContratoBrilla);
        pkg_traza.trace(csbMetodo||' nuCupoBrilla: '||nuCupoBrilla, csbNivelTraza);

        -- Se carga la informacion en un cursor referenciado
        OPEN CUOTROS FOR
            SELECT 'VALORESREF'                                    AS "DESCRIPCION",
                   'DES(h)=0 IPLI=100% IO=100% IRST=NO APLICA'     AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'VALCALC'                        AS "DESCRIPCION",
                   'DES(h)=0 COMPENSACION($)=0'     AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'CUPO_BRILLA'                                   AS "DESCRIPCION",
                   TO_CHAR (nuCupoBrilla, 'FM999,999,999,990')     AS "VALOR"
              FROM DUAL;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_error.seterror;
            pkg_error.geterror (onuErrorCode, osbErrorMessage);
            pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
    END prcConsultaDatosAdicGDC;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RfDatosConsumoHist
    Descripcion    : Procedimiento para extraer los datos relacionados
                     a los consumos historicos
    Autor          : Gabriel Gamarra - Horbath Technologies

    Parametros           Descripcion
    ============         ===================
    orfcursor            Retorna los datos consumos historicos.

    Fecha             Autor            Modificacion
    =========       =========          ====================
    29/12/2023                         OSF-1981: En el cursor cuCicloTelemedido se reemplaza pktblservsusc.fnugetsesucicl por pkg_bcproducto.fnuciclofacturacion
    12/12/2023      adrianavg          OSF-1819: Se declaran variables para el manejo de trazas y error
                                       Se implementa pkg_error.prInicializaError
                                       Se reemplaza obtenervalorinstancia por api_obtenervalorinstancia
                                       Se reemplaza pktblservsusc.fnugetcategory por pkg_bcproducto.fnuCategoria
                                       Se reemplaza pktblservsusc.fnugetbillingcycle por pkg_bcproducto.fnuCicloFacturacion
                                       Se reemplaza SELECT-INTO por cursor cuOrigConsumo, se añade IF-ENDIF para manejo de notdatafound
                                       Se reemplaza SELECT-INTO por cuCicloTelemedido con ajuste de ldc_boutilities.splitstrings por regexp_substr, se añade IF-ENDIF para manejo de notdatafound
                                       Se reemplaza SELECT-INTO por cursor cuDatosConsumo, se añade IF-ENDIF para manejo de notdatafound
                                       Se reemplaza SELECT-INTO por cursor cuCicloEspecial,
                                       Se reemplaza daab_address.fnugetgeograp_location_id por pkg_bcdirecciones.fnugetlocalidad
                                       Se reemplaza dapr_product.fnugetaddress_id por pkg_bcproducto.fnuiddireccinstalacion
                                       Ajustar bloque de exceptions según las pautas técnicas
                                       Del procedimiento gethistoricos se retiran variables declaradas sin uso:  contador , periodo, consumo, nupro y nucat. Se declaran variables para el manejo de trazas
    22/04/2019      elal               ca 200-2032 se cambia tipo de variable a presion y temperatura
    25/09/2017      oparra.CA200-904   Se modifica el orden de los meses
    13/03/2017      KCienfuegos.CA1081 Se modifican los cursores cucm_vavafacoP y cucm_vavafacoPL
                                       para obtener el valor de la columna vvfcvalo en lugar de la
                                       columna vvfcvapr, de acuerdo a lo cotizado por NLCZ.
    07/10/2015      Mmejia.ARA.8800    Se modifica la funcion modificar el calculo de la conversion
                                       de M3 a Kwh.
    07/09/2015      Spacheco ara8640   Se trabaja con open fetch para identificar la configuracion mas
                                       cercana al dia actual para la temperatura y la presion.
    05/08/2015      Mmejia.ARA.8199    Se modifica la funcion para que el variable sbFactor_correccion sea de tipo
                                       varchar2 no number la varible es sbFactor_correccion
    17/07/2015      Spacheco-ara8209   se modifica para que al identificar un ciclo telemedio el mensaje de calculo de
                                       consumo colocara rtu.
    13-05-2015      Slemus-ARA7263     Se modifica el origen de datos de temperatura y presión.
    01-03-2015      Llozada            Se envia el consumo sin multiplicarlo por el factor de corrección ya que en
                                       la tabla de consumos está fórmula ya está aplicada.
    11/11/2014      ggamarra           Creacion.
    ******************************************************************/
    PROCEDURE rfdatosconsumohist (orfcursor OUT constants_per.tyrefcursor)
    AS
        sbfactsusc            ge_boinstancecontrol.stysbvalue;
        sbfactpefa            ge_boinstancecontrol.stysbvalue;
        sbfactcodi            ge_boinstancecontrol.stysbvalue;
        nuperidocons          pericose.pecscons%TYPE;
        consumo_actual        NUMBER;
        cons_correg           NUMBER;
        sbFactor_correccion   VARCHAR2 (200);
        consumo_mes_1         NUMBER;
        fecha_cons_mes_1      VARCHAR2 (10);
        consumo_mes_2         NUMBER;
        fecha_cons_mes_2      VARCHAR2 (10);
        consumo_mes_3         NUMBER;
        fecha_cons_mes_3      VARCHAR2 (10);
        consumo_mes_4         NUMBER;
        fecha_cons_mes_4      VARCHAR2 (10);
        consumo_mes_5         NUMBER;
        fecha_cons_mes_5      VARCHAR2 (10);
        consumo_mes_6         NUMBER;
        fecha_cons_mes_6      VARCHAR2 (10);
        consumo_promedio      NUMBER;
        supercompres          NUMBER;
        temperatura           VARCHAR2 (100);
        presion               NUMBER;
        presionvar            VARCHAR2 (100);
        sbconsumo_promedio    VARCHAR2 (80);
        sbCicloespe           VARCHAR2 (100)  := DALD_PARAMETER.FSBGETVALUE_CHAIN ('LDC_CICLVALI', NULL); --TICKET 200-2032 ELAL -- Se almacena ciclos especiales
        vnuCicloEsp           NUMBER;
        calculo_cons          VARCHAR2 (50);
        equival_kwh           VARCHAR2 (50);
        nuCategoria           servsusc.sesucate%TYPE;
        par_pod_calor         NUMBER := dald_parameter.fnugetnumeric_value ('FIDF_POD_CALORIFICO');
        nucicloc              NUMBER;
        nuproduct             NUMBER;
        blnregulado           BOOLEAN;
        nugeoloc              ge_geogra_location.geograp_location_id%TYPE;
        vnucite               NUMBER;

        --variables para el manejo de trazas y error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'rfdatosconsumohist';
        nuError      NUMBER;
        sbError      VARCHAR2(2000);

        --declaracion de cursores
        CURSOR cucm_vavafacoP (nuproduct1 IN servsusc.sesunuse%TYPE)
        IS
              SELECT DECODE (nuCategoria, cnuCategoriaInd, vvfcvalo, vvfcvapr)    presion
                FROM cm_vavafaco
               WHERE vvfcsesu = nuproduct1
                     AND vvfcfefv >= TRUNC (SYSDATE)
                     AND vvfcvafc = 'PRESION_OPERACION'
            ORDER BY vvfcfefv ASC;

        CURSOR cucm_vavafacoPL (nugeoloc1 IN NUMBER)
        IS
              SELECT DECODE (nuCategoria, cnuCategoriaInd, vvfcvalo, vvfcvapr)    presion
                FROM cm_vavafaco
               WHERE vvfcfefv >= TRUNC (SYSDATE)
                     AND vvfcvafc = 'PRESION_OPERACION'
                     AND vvfcubge = nugeoloc1
            ORDER BY vvfcfefv ASC;

        CURSOR cucm_vavafacoPt (nuproduct1 IN servsusc.sesunuse%TYPE)
        IS
              SELECT TO_CHAR (vvfcvapr)
                FROM cm_vavafaco
               WHERE vvfcsesu = nuproduct1
                     AND vvfcfefv >= TRUNC (SYSDATE)
                     AND vvfcvafc = 'TEMPERATURA'
            ORDER BY vvfcfefv ASC;

        CURSOR cucm_vavafacotL (nugeoloc1 IN NUMBER)
        IS
              SELECT TO_CHAR (vvfcvapr)
                FROM cm_vavafaco
               WHERE vvfcfefv >= TRUNC (SYSDATE)
                     AND vvfcvafc = 'TEMPERATURA'
                     AND vvfcubge = nugeoloc1
            ORDER BY vvfcfefv ASC;

        CURSOR cuOrigConsumo( p_nuproduct    vw_cmprodconsumptions.cosssesu%TYPE,
                              p_sbfactpefa   vw_cmprodconsumptions.cosspefa%TYPE,
                              p_nuperidocons vw_cmprodconsumptions.cosspecs%TYPE)
        IS
        SELECT DECODE (cossmecc, 1, 'LEC.MEDIDOR', 'ESTIMADO')
          FROM vw_cmprodconsumptions
         WHERE cosssesu = p_nuproduct
           AND cosspefa = p_sbfactpefa
           AND cosspecs = p_nuperidocons;

        CURSOR cuCicloTelemedido(p_nuproduct vw_cmprodconsumptions.cosssesu%TYPE)
        IS
        SELECT COUNT (*)
          FROM (SELECT TO_NUMBER (regexp_substr(
                       dald_parameter.fsbGetValue_Chain (
                           'CICLO_TELEMEDIDOS_GDC'), '[^,]+', 1, LEVEL))AS COLUMN_VALUE
                 FROM dual
         CONNECT BY regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('CICLO_TELEMEDIDOS_GDC'), '[^,]+', 1, LEVEL) IS NOT NULL)
         WHERE COLUMN_VALUE = pkg_bcproducto.fnuciclofacturacion (p_nuproduct) ;

        CURSOR cuDatosConsumo(p_sbfactcodi   ge_boinstancecontrol.stysbvalue,
                              p_sbfactpefa   vw_cmprodconsumptions.cosspefa%TYPE)
        IS
        SELECT consumo_act,  TO_CHAR (fac_correccion, '0.9999'), ROUND (consumo_act),  supercompres,    ROUND (consumo_act)
           || ' M3 Equivalen a '
           || --ARA.8800
              --Mmejia
              --07-10-2015
              --Se modifica el calculo de la conversion de M3 a Kwh
              --segun se envio en el FANA debe ser diferencia de lecturas
              --por el facto en el parametro FIDF_POD_CALORIFICO
              --round(par_pod_calor * consumo_act / 3.6, 2) || 'kwh',
              ROUND (par_pod_calor * consumo_act, 2)
           || 'kwh',
           ROUND (
                 (  consumo_mes_1
                  + consumo_mes_2
                  + consumo_mes_3
                  + consumo_mes_4
                  + consumo_mes_5
                  + consumo_mes_6)
               / 6)
               cons_promedio
        FROM (SELECT ldc_detallefact_gascaribe.fnugetconsumoresidencial ( MAX (sesunuse),  MAX (cosspecs))   consumo_act,
                     MAX (fccofaco)                     fac_correccion,
                     MAX (fccofasc)                     supercompres,
                     MAX (fccofapc) * MAX (fccofaco)    poder_calor
              FROM factura  f
                   INNER JOIN servsusc s
                       ON ( sesususc = factsusc  AND sesuserv =   dald_parameter.fnugetnumeric_value ( 'COD_SERV_GAS'))
                   LEFT OUTER JOIN conssesu c
                       ON ( c.cosssesu = s.sesunuse AND c.cosspefa = f.factpefa AND cossmecc = 4)
                   LEFT OUTER JOIN cm_facocoss
                       ON (cossfcco = fccocons)
             WHERE factcodi = p_sbfactcodi
             ),  perifact
        WHERE pefacodi = p_sbfactpefa;

        CURSOR cuCicloEspecial(p_nucicloc NUMBER)
        IS
        SELECT COUNT (*)
          FROM ( SELECT TO_NUMBER (REGEXP_SUBSTR (sbCicloespe, '[^,]+', 1,  LEVEL)) ciclos
                   FROM DUAL
             CONNECT BY REGEXP_SUBSTR (sbCicloespe,  '[^,]+', 1,  LEVEL) IS NOT NULL)
         WHERE ciclos = p_nucicloc;

        -- Obtiene los historicos de consumo
        PROCEDURE gethistoricos (nucontrato   IN NUMBER,
                                 nuproducto   IN NUMBER,
                                 nuciclo      IN NUMBER,
                                 nuperiodo    IN NUMBER)
        AS
            TYPE tytbperiodos IS TABLE OF NUMBER
                INDEX BY BINARY_INTEGER;

            tbperconsumo      tytbperiodos;
            tbperfactura      tytbperiodos;

            tbperiodos        tytbperiodos;
            frperiodos        constants_per.tyrefcursor;

            nuperfactactual   perifact.pefacodi%TYPE;
            nuperfactprev     perifact.pefacodi%TYPE;
            nuperconsprev     pericose.pecscons%TYPE;
            sbperiodos        VARCHAR2 (100) := '';
            nuciclof          NUMBER;

            CURSOR cuconsumo (nuproducto NUMBER, tbperi tytbperiodos)
            IS
                SELECT SUM (c_1)     consumo_1,
                       SUM (c_2)     consumo_2,
                       SUM (c_3)     consumo_3,
                       SUM (c_4)     consumo_4,
                       SUM (c_5)     consumo_5,
                       SUM (c_6)     consumo_6
                  FROM (  SELECT CASE
                                     WHEN pecscons = tbperi (1) THEN SUM (cosssuma)
                                 END    c_1,
                                 CASE
                                     WHEN pecscons = tbperi (2) THEN SUM (cosssuma)
                                 END    c_2,
                                 CASE
                                     WHEN pecscons = tbperi (3) THEN SUM (cosssuma)
                                 END    c_3,
                                 CASE
                                     WHEN pecscons = tbperi (4) THEN SUM (cosssuma)
                                 END    c_4,
                                 CASE
                                     WHEN pecscons = tbperi (5) THEN SUM (cosssuma)
                                 END    c_5,
                                 CASE
                                     WHEN pecscons = tbperi (6) THEN SUM (cosssuma)
                                 END    c_6
                            FROM vw_cmprodconsumptions        -- pericose
                           WHERE cosssesu = nuproducto
                             AND pecscons IN (tbperi (1),
                                              tbperi (2),
                                              tbperi (3),
                                              tbperi (4),
                                              tbperi (5),
                                              tbperi (6))
                        GROUP BY pecscons);


            --variables para el manejo de trazas
            csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'rfdatosconsumohist.getHistoricos';

        BEGIN

            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
            pkg_traza.trace(csbMetodo||' nucontrato: ' ||nucontrato, csbNivelTraza);
            pkg_traza.trace(csbMetodo||' nuproducto: ' ||nuproducto, csbNivelTraza);
            pkg_traza.trace(csbMetodo||' nuciclo: ' ||nuciclo, csbNivelTraza);
            pkg_traza.trace(csbMetodo||' nuperiodo: ' ||nuperiodo, csbNivelTraza);

            nuciclof := nuciclo;
            pkg_traza.trace(csbMetodo||' nuciclof: '||nuciclof, csbNivelTraza);

            -- Periodo de facturacion Actual
            nuperfactactual := nuperiodo;
            pkg_traza.trace(csbMetodo||' nuperfactactual: '||nuperfactactual, csbNivelTraza);

            -- Obtiene los periodos facturados
            frperiodos := ldc_detallefact_gascaribe.frfcambiociclo (nucontrato);

            FETCH frperiodos BULK COLLECT INTO tbperiodos;
            pkg_traza.trace(csbMetodo||' Inicio Obtiene los ultimos 6 periodos facturados ', csbNivelTraza);

            -- Obtiene los ultimos 6 periodos facturados
            FOR i IN 1 .. 6
            LOOP
                -- Periodo de Facturacion Anterior
                BEGIN
                    nuperfactprev :=  pkbillingperiodmgr.fnugetperiodprevious ( nuperfactactual);
                EXCEPTION
                    WHEN pkg_error.controlled_error THEN
                         nuperfactprev := -1;
                    WHEN OTHERS THEN
                         nuperfactprev := -1;
                END;


                -- Se valida si el periodo obtenido es igual al facturado si no es igual, es por
                -- que el cliente cambio de ciclo
                IF (tbperiodos.EXISTS (i + 1)) AND (tbperiodos (i + 1) != nuperfactprev) THEN
                    nuperfactprev := tbperiodos (i + 1);
                    nuciclof := pktblperifact.fnugetcycle (nuperfactprev);
                END IF;

                -- Periodo de consumo Anterior
                BEGIN
                    nuperconsprev := ldc_boformatofactura.fnuobtperconsumo (nuciclof, nuperfactprev);
                EXCEPTION
                    WHEN pkg_error.CONTROLLED_ERROR THEN
                        nuperconsprev := -1;
                    WHEN OTHERS THEN
                        nuperconsprev := -1;
                END;

                tbperconsumo (i) := nuperconsprev;
                tbperfactura (i) := nuperfactprev;

                IF (sbperiodos IS NOT NULL)
                THEN
                    sbperiodos := nuperconsprev || ',' || sbperiodos;
                ELSE
                    sbperiodos := nuperconsprev;
                END IF;

                -- El Anterior queda actual para hallar los anteriores
                nuperfactactual := nuperfactprev;

                pkg_traza.trace(csbMetodo||' nuperfactprev: '||nuperfactprev||', nuperconsprev: '||nuperconsprev||chr(10)
                                         ||' sbperiodos: '||sbperiodos||', nuperfactactual: '||nuperfactactual, csbNivelTraza);
            END LOOP;

            pkg_traza.trace(csbMetodo||' nuperfactactual: '||nuperfactactual, csbNivelTraza);

            pkg_traza.trace(csbMetodo||' Fin Obtiene los ultimos 6 periodos facturados ', csbNivelTraza);

            pkg_traza.trace(csbMetodo||' Recorre el cursor cuconsumo ', csbNivelTraza);
            FOR i IN cuconsumo (nuproducto, tbperconsumo)
            LOOP
                pkg_traza.trace(csbMetodo||' --> consumo_mes_1'||i.consumo_1, csbNivelTraza);
                consumo_mes_1 := NVL (i.consumo_1, 0);
                pkg_traza.trace(csbMetodo||' --> consumo_mes_2'||i.consumo_2, csbNivelTraza);
                consumo_mes_2 := NVL (i.consumo_2, 0);
                pkg_traza.trace(csbMetodo||' --> consumo_mes_3'||i.consumo_3, csbNivelTraza);
                consumo_mes_3 := NVL (i.consumo_3, 0);
                pkg_traza.trace(csbMetodo||' --> consumo_mes_4'||i.consumo_4, csbNivelTraza);
                consumo_mes_4 := NVL (i.consumo_4, 0);
                pkg_traza.trace(csbMetodo||' --> consumo_mes_5'||i.consumo_5, csbNivelTraza);
                consumo_mes_5 := NVL (i.consumo_5, 0);
                pkg_traza.trace(csbMetodo||' --> consumo_mes_6'||i.consumo_6, csbNivelTraza);
                consumo_mes_6 := NVL (i.consumo_6, 0);
            END LOOP;
            pkg_traza.trace(csbMetodo||' Fin recorre el cursor cuconsumo' , csbNivelTraza);

            -- Hallando meses
            fecha_cons_mes_1 := ldc_detallefact_gascaribe.fsbgetfechapermmyyyy (tbperfactura (1));
            pkg_traza.trace(csbMetodo||' fecha_cons_mes_1: '||fecha_cons_mes_1 , csbNivelTraza);

            fecha_cons_mes_2 := ldc_detallefact_gascaribe.fsbgetfechapermmyyyy (tbperfactura (2));
            pkg_traza.trace(csbMetodo||' fecha_cons_mes_2: '||fecha_cons_mes_2 , csbNivelTraza);

            fecha_cons_mes_3 := ldc_detallefact_gascaribe.fsbgetfechapermmyyyy (tbperfactura (3));
            pkg_traza.trace(csbMetodo||' fecha_cons_mes_3: '||fecha_cons_mes_3 , csbNivelTraza);

            fecha_cons_mes_4 := ldc_detallefact_gascaribe.fsbgetfechapermmyyyy (tbperfactura (4));
            pkg_traza.trace(csbMetodo||' fecha_cons_mes_4: '||fecha_cons_mes_4 , csbNivelTraza);

            fecha_cons_mes_5 := ldc_detallefact_gascaribe.fsbgetfechapermmyyyy (tbperfactura (5));
            pkg_traza.trace(csbMetodo||' fecha_cons_mes_5: '||fecha_cons_mes_5 , csbNivelTraza);

            fecha_cons_mes_6 := ldc_detallefact_gascaribe.fsbgetfechapermmyyyy (tbperfactura (6));
            pkg_traza.trace(csbMetodo||' fecha_cons_mes_6: '||fecha_cons_mes_6 , csbNivelTraza);

            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        END gethistoricos;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);

        sbfactcodi := api_obtenervalorinstancia ('FACTURA', 'FACTCODI');
        pkg_traza.trace(csbMetodo||' sbfactcodi: '||sbfactcodi, csbNivelTraza);

        sbfactsusc := api_obtenervalorinstancia ('FACTURA', 'FACTSUSC');
        pkg_traza.trace(csbMetodo||' sbfactsusc: '||sbfactsusc, csbNivelTraza);

        sbfactpefa := api_obtenervalorinstancia ('FACTURA', 'FACTPEFA');
        pkg_traza.trace(csbMetodo||' sbfactpefa: '||sbfactpefa, csbNivelTraza);

        nuproduct := fnugetproducto (sbfactcodi);
        pkg_traza.trace(csbMetodo||' nuproduct: '||nuproduct, csbNivelTraza);

        blnregulado := ldc_detallefact_gascaribe.fblnoregulado (sbfactsusc);
        IF blnregulado THEN
            pkg_traza.trace(csbMetodo||' blnregulado: TRUE', csbNivelTraza);
        ELSE
            pkg_traza.trace(csbMetodo||' blnregulado: FALSE', csbNivelTraza);
        END IF;

        nuCategoria := pkg_bcproducto.fnuCategoria (nuproduct);
        pkg_traza.trace(csbMetodo||' nuCategoria: '||nuCategoria, csbNivelTraza);

        IF NOT blnregulado THEN
            pkg_traza.trace(csbMetodo||' NOT blnregulado ', csbNivelTraza);
            BEGIN
                nucicloc :=  NVL(pkg_bcproducto.fnuCicloFacturacion (nuproduct), -1);

                -- Se obtiene el periodo de consumo actual, dado el periodo de facturacion
                nuperidocons := ldc_boformatofactura.fnuobtperconsumo (nucicloc, sbfactpefa);

            EXCEPTION
                WHEN OTHERS
                THEN
                    nucicloc := -1;
                    nuperidocons := -1;
            END;
            pkg_traza.trace(csbMetodo||' nucicloc: '||nucicloc, csbNivelTraza);
            pkg_traza.trace(csbMetodo||' nuperidocons: '||nuperidocons, csbNivelTraza);

            gethistoricos (sbfactsusc,
                           nuproduct,
                           nucicloc,
                           sbfactpefa);


            -- Obtener el origen del consumo
            BEGIN
                 OPEN cuOrigConsumo(nuproduct, sbfactpefa, nuperidocons);
                FETCH cuOrigConsumo INTO calculo_cons;
                CLOSE cuOrigConsumo;
            EXCEPTION
                WHEN OTHERS THEN
                    calculo_cons := NULL;
            END;
            pkg_traza.trace(csbMetodo||' Obtener el origen del consumo: '||calculo_cons, csbNivelTraza);

            --Spacheco ara:8209 --se valida si el ciclo asociado al usuario esta configurado en el parametro
            --de ciclo de telemedido
            IF calculo_cons IS NOT NULL THEN
                pkg_traza.trace(csbMetodo||' Validacion ciclo asociado', csbNivelTraza);
                OPEN cuCicloTelemedido(nuproduct);
                FETCH cuCicloTelemedido INTO vnucite;
                CLOSE cuCicloTelemedido;

                IF vnucite = 1 THEN
                   calculo_cons := 'RTU';
                   pkg_traza.trace(csbMetodo||' Ciclo asociado al usuario esta configurado en el parametro de ciclo de telemedido: '||calculo_cons, csbNivelTraza);
                END IF;
            END IF;
                pkg_traza.trace(csbMetodo||' vnucite: '||vnucite, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' --> 1', csbNivelTraza);

            BEGIN
                --01-03-2015 Llozada: Se envia el consumo sin multiplicarlo por el factor de corrección ya que en la tabla de consumos esta fórmula ya está aplicada.
                 OPEN cuDatosConsumo(sbfactcodi, sbfactpefa);
                FETCH cuDatosConsumo INTO consumo_actual,
                                          sbFactor_correccion,
                                          cons_correg,
                                          supercompres,
                                          equival_kwh,
                                          consumo_promedio;

                pkg_traza.trace(csbMetodo||' Salida cursor cuDatosConsumo: consumo_actual: '||consumo_actual, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' Salida cursor cuDatosConsumo: sbFactor_correccion: '||sbFactor_correccion, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' Salida cursor cuDatosConsumo: cons_correg: '||cons_correg, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' Salida cursor cuDatosConsumo: supercompres: '||supercompres, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' Salida cursor cuDatosConsumo: equival_kwh: '||equival_kwh, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' Salida cursor cuDatosConsumo: consumo_promedio: '||consumo_promedio, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' --> 2', csbNivelTraza);

                IF cuDatosConsumo%NOTFOUND THEN
                   Pkg_Error.SetError;
                   pkg_traza.trace(csbMetodo||' NOTFOUND'||sqlerrm, csbNivelTraza);
                   RAISE NO_DATA_FOUND;
                END IF;
                CLOSE cuDatosConsumo;

                BEGIN
                    nugeoloc := pkg_bcdirecciones.fnugetlocalidad (pkg_bcproducto.fnuiddireccinstalacion (nuproduct));
                    pkg_traza.trace(csbMetodo||' nugeoloc : '||nugeoloc, csbNivelTraza);
                END;

                pkg_traza.trace(csbMetodo||' --> 3', csbNivelTraza);

                /*SPacheco Ara 8640 se trabaja con open fetch para identificar la configuracion mas
                cerca al dia del proceso*/

                --se consulta presion
                 OPEN cucm_vavafacoP (nuproduct);
                FETCH cucm_vavafacoP INTO presion;
                IF cucm_vavafacoP%NOTFOUND  THEN
                    --si no existe configuracion de presion para el producto se consulta por localidad
                    OPEN cucm_vavafacoPl (nugeoloc);
                    FETCH cucm_vavafacoPl INTO presion;
                    IF cucm_vavafacoPl%NOTFOUND THEN
                        presion := 0;
                    END IF;
                    CLOSE cucm_vavafacoPl;
                END IF;
                CLOSE cucm_vavafacoP;
                pkg_traza.trace(csbMetodo||' presion : '||presion, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' --> 4', csbNivelTraza);

                --SPacheco Ara 8640 se trabaja con open fetch para identificar la configuracion mas    cerca al dia del proceso

                --se consulta la temperatura configurada por el producto
                 OPEN cucm_vavafacoPt (nuproduct);
                FETCH cucm_vavafacoPt INTO temperatura;
                IF cucm_vavafacoPt%NOTFOUND THEN
                    --si no posee configuracion de temperatura por producto consulta por localidad
                    OPEN cucm_vavafacotl (nugeoloc);
                    FETCH cucm_vavafacotl INTO temperatura;
                    IF cucm_vavafacotl%NOTFOUND    THEN
                        temperatura := 0;
                    END IF;
                    CLOSE cucm_vavafacotl;
                END IF;
                CLOSE cucm_vavafacoPt;
                pkg_traza.trace(csbMetodo||' temperatura : '||temperatura, csbNivelTraza);

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    pkg_traza.trace(csbMetodo||' NO_DATA_FOUND ', csbNivelTraza);
                    consumo_actual := 0;
                    sbFactor_correccion := '0';
                    consumo_mes_1 := 0;
                    fecha_cons_mes_1 := ' ';
                    consumo_mes_2 := 0;
                    fecha_cons_mes_2 := ' ';
                    consumo_mes_3 := 0;
                    fecha_cons_mes_3 := ' ';
                    consumo_mes_4 := 0;
                    fecha_cons_mes_4 := ' ';
                    consumo_mes_5 := 0;
                    fecha_cons_mes_5 := ' ';
                    consumo_mes_6 := 0;
                    fecha_cons_mes_6 := ' ';
                    consumo_promedio := 0;
                    supercompres := 0;
                    temperatura := 0;
                    presionVAR := '0';
                    cons_correg := 0;
                    calculo_cons := ' ';
                    equival_kwh := ' ';
            END;

            -- Si es no regulado no muestra datos

            --INICIO CA 200-2032 ELAL -- se valida ciclos especiales

            sbconsumo_promedio :=  TO_CHAR (consumo_promedio, 'FM999,999,999.9990');
            pkg_traza.trace(csbMetodo||' sbconsumo_promedio : '||sbconsumo_promedio, csbNivelTraza);

             OPEN cuCicloEspecial(nucicloc);
            FETCH cuCicloEspecial INTO vnuCicloEsp;
            CLOSE cuCicloEspecial;
            pkg_traza.trace(csbMetodo||' vnuCicloEsp : '||vnuCicloEsp, csbNivelTraza);

            presionVAR := TO_CHAR (presion, 'FM999,990.90');
            pkg_traza.trace(csbMetodo||' presionVAR : '||presionVAR, csbNivelTraza);

            IF vnuCicloEsp >= 1 THEN
               sbFactor_correccion := 'VER ANEXO';
               temperatura := 'VER ANEXO';
               presionVAR := 'VER ANEXO';
            END IF;
        --FIN ca 200-2032

        ELSE
            pkg_traza.trace(csbMetodo||' ELSE ', csbNivelTraza);
            consumo_actual := NULL;
            sbFactor_correccion := NULL;
            consumo_mes_1 := NULL;
            fecha_cons_mes_1 := NULL;
            consumo_mes_2 := NULL;
            fecha_cons_mes_2 := NULL;
            consumo_mes_3 := NULL;
            fecha_cons_mes_3 := NULL;
            consumo_mes_4 := NULL;
            fecha_cons_mes_4 := NULL;
            consumo_mes_5 := NULL;
            fecha_cons_mes_5 := NULL;
            consumo_mes_6 := NULL;
            fecha_cons_mes_6 := NULL;
            consumo_promedio := NULL;
            supercompres := NULL;
            temperatura := NULL;
            presion := NULL;
            cons_correg := NULL;
            equival_kwh := NULL;
            calculo_cons := NULL;
        END IF;

        OPEN orfcursor FOR
            SELECT cons_correg             cons_correg,
                   sbFactor_correccion     factor_correccion,
                   consumo_mes_6           consumo_mes_1,
                   fecha_cons_mes_6        fecha_cons_mes_1,
                   consumo_mes_5           consumo_mes_2,
                   fecha_cons_mes_5        fecha_cons_mes_2,
                   consumo_mes_4           consumo_mes_3,
                   fecha_cons_mes_4        fecha_cons_mes_3,
                   consumo_mes_3           consumo_mes_4,
                   fecha_cons_mes_3        fecha_cons_mes_4,
                   consumo_mes_2           consumo_mes_5,
                   fecha_cons_mes_2        fecha_cons_mes_5,
                   consumo_mes_1           consumo_mes_6,
                   fecha_cons_mes_1        fecha_cons_mes_6,
                   sbconsumo_promedio      consumo_promedio,
                   temperatura             temperatura,
                   presionVAR              presion,
                   equival_kwh             equival_kwh,
                   calculo_cons            calculo_cons
              FROM DUAL;

       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
             RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
             pkg_error.seterror;
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
             RAISE pkg_error.controlled_error;
    END rfdatosconsumohist;

    PROCEDURE prcConsultaDatosAdic (CUOTROS OUT SYS_REFCURSOR)
    AS
        /**************************************************************************
        Propiedad Intelectual de PETI

        Funcion     :  prcConsultaDatosAdic
        Descripcion :  Permite consultar los datos adicionales de la factura
                       es una extraccion de las reglas definidas en FCED FACTURA_MASIVA_EFIGAS

        Autor       : Hector Fabio Dominguez / Arquitecsoft
        Fecha       : 17-12-2014

        Historia de Modificaciones
          Fecha               Autor                Modificacion
        =========           =========          ====================
        12/12/2023          adrianavg      OSF-1819: Se declaran variables para el manejo de trazas
                                           Se implementa pkg_error.prInicializaError
                                           Se reemplaza UT_STRING.FSBCONCAT por ldc_bcConsGenerales.fsbconcatenar
                                           Ajustar bloque de exceptions según las pautas técnicas
                                           Se retiran variables declaradas sin uso: NUVALTARIFA, NUPORCTARIFA, NURANTARIFA, SBTARIFACVA, NUVALTARIFAVA,
                                           SBTARIFASS, NUVALTARIFASS, NUCONSTARIFASS, NURANTARIFASS, SBTARIFACF
        28/12/2016          cramirez       CA 200-1012 Se deja parametrizado el IVA para que pueda ser cambiado cada que se necesite
        17-12-2014          Hectord        Creacion.
        **************************************************************************/
        nuIVA  ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetnumeric_value ('COD_VALOR_IVA');

        -- Control de errores
        onuErrorCode       NUMBER;
        osbErrorMessage    VARCHAR2 (2000);

        --Variables para contener los datos de la equivalencia de la regla  tarifa_gm
        NUVALTARIFAGM      VARCHAR2 (2000);
        SBTARIFAGM         VARCHAR2 (2000);

        --Variables para contener los datos de la equivalencia de la regla  tarifa_tm
        NUVALTARIFATM      VARCHAR2 (2000);
        SBTARIFATM         VARCHAR2 (2000);

        --Variables para contener los datos de la equivalencia de la regla  tarifa_dm
        NUVALTARIFADM      VARCHAR2 (2000);
        SBTARIFADM         VARCHAR2 (2000);

        --Variables para contener los datos de la equivalencia de la regla  tarifa_cv
        NUVALTARIFACV      VARCHAR2 (2000);
        SBTARIFACV         VARCHAR2 (2000);
        NUVALTARIFATCV     VARCHAR2 (2000);
        NUPORCTARIFATCV    VARCHAR2 (2000);
        NUCONSTARIFATCV    VARCHAR2 (2000);
        NURANTARIFATCV     VARCHAR2 (2000);
        NUTARIFATCV        VARCHAR2 (2000);

        --Variables para contener los datos de la equivalencia de la regla  tarifa_cc
        SBTARIFACC         VARCHAR2 (2000);
        NUCONSTARIFARECO   VARCHAR2 (2000);
        NUVALTARIFARECO    VARCHAR2 (2000);
        NUPORCTARIFARECO   VARCHAR2 (2000);

        --Variables para contener los datos de la equivalencia de la regla  tarifa_as
        NURANTARIFAAS      VARCHAR2 (2000);
        NUPORCTARIFAAS     VARCHAR2 (2000);
        NUVALTARIFAAS      VARCHAR2 (2000);
        NUCONSTARIFAAS     VARCHAR2 (2000);
        NUTARIFAAS         VARCHAR2 (2000);

        --Variables para contener los datos de la equivalencia de la regla  tarifa_porsu
        NUCONSTARIFAREIN   VARCHAR2 (2000);
        NUVALTARIFAREIN    VARCHAR2 (2000);
        NUPORCTARIFAREIN   VARCHAR2 (2000);
        NUIVAREVISION      NUMBER;
        NUVALORREVISION    NUMBER;
        SBVALORREVISION    VARCHAR2 (2000);
        SBMENJFACT         VARCHAR2 (4000);

        --Variables para contener los datos de la equivalencia de la regla  Cupo_Brilla
        NUCONTRATOBRILLA   VARCHAR2 (4000);
        NUCUPOBRILLA       VARCHAR2 (4000);

        --Variables para contener los datos de la equivalencia de la regla  tarifa_ds
        NUPORCENTAJEPC     VARCHAR2 (2000);
        NUTARIFAPC         VARCHAR2 (2000);
        SBTIPOPC           VARCHAR2 (2000);
        NUVALPORCPC        VARCHAR2 (2000);
        NUPORCPC           VARCHAR2 (2000);

        --Variables para contener los datos de la equivalencia de la regla  TARIFA_PORSU
        NUVALORPORCTS      VARCHAR2 (2000);
        SBTIPOTS           VARCHAR2 (2000);
        NUVALTARIFATS      VARCHAR2 (2000);
        NUVALORTS          VARCHAR2 (2000);

        --Variables para contener los datos de la equivalencia de la regla  TARIFA_CF
        NUTARIFACF         VARCHAR2 (2000);
        NUVALTARIFACF      VARCHAR2 (2000);
        NUPORCTARIFACF     VARCHAR2 (2000);
        NUCONSTARIFACF     VARCHAR2 (2000);

        --Variables para contener los datos de la equivalencia de la regla  TARIFA_DS
        NUCONSTARIFADS     VARCHAR2 (2000);
        NUVALTARIFADS      VARCHAR2 (2000);
        NUPORCTARIFADS     VARCHAR2 (2000);
        NURANTARIFADS      VARCHAR2 (2000);
        NUTARIFADS         VARCHAR2 (2000);

        --variables para el manejo de trazas y error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'prcConsultaDatosAdic';

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( onuErrorCode, osbErrorMessage);

        --Obtiene la tarifa de Suministro de Gas gm
        NUVALTARIFAGM := LDC_DETALLEFACT_EFIGAS.FNUGETVALCOSTCOMPVALID (200, 1, 6);
        pkg_traza.trace(csbMetodo||' Nuvaltarifagm: '||NUVALTARIFAGM, csbNivelTraza);

        SBTARIFAGM :=  ldc_bcConsGenerales.fsbconcatenar ('Gm,i,j/ 1-p: ', NUVALTARIFAGM, '   ');
        pkg_traza.trace(csbMetodo||' SBTARIFAGM: '||SBTARIFAGM, csbNivelTraza);

        --LDC - Obtiene la tarifa de Transporte de Gas
        NUVALTARIFATM :=  LDC_DETALLEFACT_EFIGAS.FNUGETVALCOSTCOMPVALID (204, 1, 6);
        pkg_traza.trace(csbMetodo||' NUVALTARIFATM: '||NUVALTARIFATM, csbNivelTraza);

        SBTARIFATM :=  ldc_bcConsGenerales.fsbconcatenar ('Tm,i,j/ 1-p:', NUVALTARIFATM, '   ');
        pkg_traza.trace(csbMetodo||' SBTARIFATM: '||SBTARIFATM, csbNivelTraza);

        --LDC - Obtiene la tarifa de distribucion de Gas
        NUVALTARIFADM := LDC_DETALLEFACT_EFIGAS.FNUGETVALCOSTCOMPVALID (20, 1, 6);
        pkg_traza.trace(csbMetodo||' NUVALTARIFADM: '||NUVALTARIFADM, csbNivelTraza);

        SBTARIFADM :=  ldc_bcConsGenerales.fsbconcatenar ('Dm,i,j x fpc m,i,j:', NUVALTARIFADM, '   ');
        pkg_traza.trace(csbMetodo||' SBTARIFADM: '||SBTARIFADM, csbNivelTraza);

        --LDC - Obtiene la tarifa de comercializacion de Gas
        NUVALTARIFACV :=  LDC_DETALLEFACT_EFIGAS.FNUGETVALCOSTCOMPVALID (18, 1, 6);
        pkg_traza.trace(csbMetodo||' NUVALTARIFACV: '||NUVALTARIFACV, csbNivelTraza);

        SBTARIFACV := ldc_bcConsGenerales.fsbconcatenar('Cv m,i,j:', NUVALTARIFACV, '   ');
        pkg_traza.trace(csbMetodo||' SBTARIFACV: '||SBTARIFACV, csbNivelTraza);

        --LDC - Obtiene la tarifa
        SBTARIFACC := ldc_bcConsGenerales.fsbconcatenar ('Cc m,i,j:', 0, '   ');
        pkg_traza.trace(csbMetodo||' SBTARIFACC: '||SBTARIFACC, csbNivelTraza);

        --LDC Obtiene el valor de reconexion
        LDC_DETALLEFACT_EFIGAS.GETCOSTCOMPVALID (159,
                                                 1,
                                                 6,
                                                 NUCONSTARIFARECO,
                                                 NUVALTARIFARECO,
                                                 NUPORCTARIFARECO);
        pkg_traza.trace(csbMetodo||' NUCONSTARIFARECO: '||NUCONSTARIFARECO, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' NUVALTARIFARECO: '||NUVALTARIFARECO, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' NUPORCTARIFARECO: '||NUPORCTARIFARECO, csbNivelTraza);

        --LDC Obtiene el valor de reinstalacion
        LDC_DETALLEFACT_EFIGAS.GETCOSTCOMPVALID (169,
                                                 1,
                                                 6,
                                                 NUCONSTARIFAREIN,
                                                 NUVALTARIFAREIN,
                                                 NUPORCTARIFAREIN);
        pkg_traza.trace(csbMetodo||' NUCONSTARIFAREIN: '||NUCONSTARIFAREIN, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' NUVALTARIFAREIN: '||NUVALTARIFAREIN, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' NUPORCTARIFAREIN: '||NUPORCTARIFAREIN, csbNivelTraza);

        -- Obtiene la tarifa de revision
        NUVALORREVISION := LDC_DETALLEFACT_EFIGAS.FNUGETVALREVISIONPERIODICA ();
        pkg_traza.trace(csbMetodo||' NUVALORREVISION: '||NUVALORREVISION, csbNivelTraza);

        IF NUVALORREVISION <> 0 THEN
            NUIVAREVISION := NUVALORREVISION * (nuIVA / 100);
            pkg_traza.trace(csbMetodo||' NUIVAREVISION: '||NUIVAREVISION, csbNivelTraza);

            SBVALORREVISION := ldc_bcConsGenerales.fsbconcatenar(NUVALORREVISION,  NUIVAREVISION, ' mas Iva ');
            pkg_traza.trace(csbMetodo||' SBVALORREVISION: '||SBVALORREVISION, csbNivelTraza);
        END IF;

        --Mensaje de la factura
        SBMENJFACT := LDC_DETALLEFACT_EFIGAS.fsbGetMensajeFacturacion ();
        pkg_traza.trace(csbMetodo||' SBMENJFACT: '||SBMENJFACT, csbNivelTraza);

        --Cupo Brilla
        NUCONTRATOBRILLA := OBTENERVALORINSTANCIA ('FACTURA', 'FACTSUSC');
        pkg_traza.trace(csbMetodo||' NUCONTRATOBRILLA: '||NUCONTRATOBRILLA, csbNivelTraza);

        NUCUPOBRILLA := LD_BONONBANKFINANCING.FNUGETAVALIBLEQUOTE (NUCONTRATOBRILLA);
        pkg_traza.trace(csbMetodo||' NUCUPOBRILLA: '||NUCUPOBRILLA, csbNivelTraza);

        --Tarifa de cargo variable
        LDC_DETALLEFACT_EFIGAS.GETCOSTCOMPVALID (31,
                                                 1,
                                                 6,
                                                 NUCONSTARIFATCV,
                                                 NUVALTARIFATCV,
                                                 NUPORCTARIFATCV);
        pkg_traza.trace(csbMetodo||' NUCONSTARIFATCV: '||NUCONSTARIFATCV, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' NUVALTARIFATCV: '||NUVALTARIFATCV, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' NUPORCTARIFATCV: '||NUPORCTARIFATCV, csbNivelTraza);

        NURANTARIFATCV :=  LDC_DETALLEFACT_EFIGAS.FNURANGOTARIFA (NUCONSTARIFATCV, 'CV');
        pkg_traza.trace(csbMetodo||' NURANTARIFATCV: '||NURANTARIFATCV, csbNivelTraza);

        IF NURANTARIFATCV <> 0 THEN
            NUTARIFATCV :=  ldc_bcConsGenerales.fsbconcatenar ('Cargo Variable:', NURANTARIFATCV, '   ');
            pkg_traza.trace(csbMetodo||' NUTARIFATCV: '||NUTARIFATCV, csbNivelTraza);
        END IF;

        -- Tarfia antes de Subsidio
        LDC_DETALLEFACT_EFIGAS.GETCOSTCOMPVALID (31,
                                                 1,
                                                 6,
                                                 NUCONSTARIFAAS,
                                                 NUVALTARIFAAS,
                                                 NUPORCTARIFAAS);
        pkg_traza.trace(csbMetodo||' NUCONSTARIFAAS: '||NUCONSTARIFAAS, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' NUVALTARIFAAS: '||NUVALTARIFAAS, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' NUPORCTARIFAAS: '||NUPORCTARIFAAS, csbNivelTraza);

        NURANTARIFAAS := LDC_DETALLEFACT_EFIGAS.FNURANGOTARIFA (NUCONSTARIFAAS, 'TAS');
        pkg_traza.trace(csbMetodo||' NURANTARIFAAS: '||NURANTARIFAAS, csbNivelTraza);

        IF NURANTARIFAAS <> 0 THEN
            NUTARIFAAS := ldc_bcConsGenerales.fsbconcatenar ('Tarifa antes de subsidio $m/3:',  NURANTARIFAAS, '   ');
        ELSE
            NUTARIFAAS := NULL;
        END IF;
        pkg_traza.trace(csbMetodo||' NUTARIFAAS: '||NUTARIFAAS, csbNivelTraza);

        -- calcula el porcentaje de contrubucion
        LDC_DETALLEFACT_EFIGAS.GETTAPORCSUBCONTRI (NUPORCENTAJEPC,
                                                   NUTARIFAPC,
                                                   SBTIPOPC);
        pkg_traza.trace(csbMetodo||' NUPORCENTAJEPC: '||NUPORCENTAJEPC, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' NUTARIFAPC: '||NUTARIFAPC, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' SBTIPOPC: '||SBTIPOPC, csbNivelTraza);

        IF SBTIPOPC = 'S' THEN
            NUVALPORCPC := ldc_bcConsGenerales.fsbconcatenar (NUPORCENTAJEPC, '%', '');
            NUPORCPC :=  ldc_bcConsGenerales.fsbconcatenar(' Subsidio:', NUVALPORCPC, '   ');
        ELSIF SBTIPOPC = 'C' THEN
            NUVALPORCPC := ldc_bcConsGenerales.fsbconcatenar (NUPORCENTAJEPC, '%', '');
            NUPORCPC :=  ldc_bcConsGenerales.fsbconcatenar ('% Contribuccion:', NUVALPORCPC, '   ');
        ELSE
            NUPORCPC := '';
        END IF;
        pkg_traza.trace(csbMetodo||' NUVALPORCPC: '||NUVALPORCPC, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' NUPORCPC: '||NUPORCPC, csbNivelTraza);

        -- Obtiene la informacion de la tarifa subsidiada
        LDC_DETALLEFACT_EFIGAS.GETTAPORCSUBCONTRI (NUVALORPORCTS,
                                                   NUVALTARIFATS,
                                                   SBTIPOTS);
        pkg_traza.trace(csbMetodo||' NUVALORPORCTS: '||NUVALORPORCTS, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' NUVALTARIFATS: '||NUVALTARIFATS, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' SBTIPOTS: '||SBTIPOTS, csbNivelTraza);

        IF SBTIPOTS = 'S' THEN
            NUVALORTS := ldc_bcConsGenerales.fsbconcatenar ('Tarifa Subsidiada %/m3 (< 20 m3):', NUVALTARIFATS, '   ');
            pkg_traza.trace(csbMetodo||' NUVALORTS: '||NUVALORTS, csbNivelTraza);
        END IF;

        --Obtiene la tarifa de cargo fijo
        LDC_DETALLEFACT_EFIGAS.GETCOSTCOMPVALID (17,
                                                 1,
                                                 6,
                                                 NUCONSTARIFACF,
                                                 NUVALTARIFACF,
                                                 NUPORCTARIFACF);
        pkg_traza.trace(csbMetodo||' NUCONSTARIFACF: '||NUCONSTARIFACF, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' NUVALTARIFACF: '||NUVALTARIFACF, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' NUPORCTARIFACF: '||NUPORCTARIFACF, csbNivelTraza);

        NUTARIFACF :=ldc_bcConsGenerales.fsbconcatenar ('Cargo Fijo Cf m,i,j', NUVALTARIFACF, '   ');
        pkg_traza.trace(csbMetodo||' NUTARIFACF: '||NUTARIFACF, csbNivelTraza);

        --Obtiene la tarifa despues del subsidio
        LDC_DETALLEFACT_EFIGAS.GETCOSTCOMPVALID (31,
                                                 1,
                                                 6,
                                                 NUCONSTARIFADS,
                                                 NUVALTARIFADS,
                                                 NUPORCTARIFADS);
        pkg_traza.trace(csbMetodo||' NUCONSTARIFADS: '||NUCONSTARIFADS, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' NUVALTARIFADS: '||NUVALTARIFADS, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' NUPORCTARIFADS: '||NUPORCTARIFADS, csbNivelTraza);

        NURANTARIFADS := LDC_DETALLEFACT_EFIGAS.FNURANGOTARIFA (NUCONSTARIFADS, 'TDS');
        pkg_traza.trace(csbMetodo||' NURANTARIFADS: '||NURANTARIFADS, csbNivelTraza);

        NUTARIFADS := ldc_bcConsGenerales.fsbconcatenar ('Tarifa $m/3 (mayor 20 m3):',  NURANTARIFADS,  '   ');
        pkg_traza.trace(csbMetodo||' NUTARIFADS: '||NUTARIFADS, csbNivelTraza);

        -- Se carga la informacion en un cursor referenciado
        OPEN CUOTROS FOR
            SELECT 'TARIFA_GM' AS "DESCRIPCION", SBTARIFAGM AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'TARIFA_TM' AS "DESCRIPCION", SBTARIFATM AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'TARIFA_DM' AS "DESCRIPCION", SBTARIFADM AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'TARIFA_CV' AS "DESCRIPCION", SBTARIFACV AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'TARIFA_CC' AS "DESCRIPCION", SBTARIFACC AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'TARIFA_RECONEXION'     AS "DESCRIPCION",
                   NUVALTARIFARECO         AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'TARIFA_REINSTALACION'     AS "DESCRIPCION",
                   NUVALTARIFAREIN            AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'TARIFA_REVISION'     AS "DESCRIPCION",
                   SBVALORREVISION       AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'MJS_FACTURA' AS "DESCRIPCION", SBMENJFACT AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'CUPO_BRILLA' AS "DESCRIPCION", NUCUPOBRILLA AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'TARIFA_CVARIABLE'     AS "DESCRIPCION",
                   NUTARIFATCV            AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'TARIFA_ASUBSIDIO' AS "DESCRIPCION", NUTARIFAAS AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'PORCENTAJE_CONTRIBUCION'     AS "DESCRIPCION",
                   NUPORCPC                      AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'TARIFA_SUBSIDIADA' AS "DESCRIPCION", NUVALORTS AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'TARIFA_CARGOFIJO' AS "DESCRIPCION", NUTARIFACF AS "VALOR"
              FROM DUAL
            UNION ALL
            SELECT 'TARIFA_DESPSUBSIDIO'     AS "DESCRIPCION",
                   NUTARIFADS                AS "VALOR"
              FROM DUAL;

     pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.seterror;
            pkg_error.geterror (onuErrorCode, osbErrorMessage);
            pkg_traza.trace('osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
    END prcConsultaDatosAdic;

    /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     :  fsbGetDesviacion
    Descripcion :  Obtiene la desviacion de consumos.

    Autor       : Sergio Mejia - Optima Consulting
    Fecha       : 05-03-2014

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    05-03-2014          smejia              Creacion.
    07-03-2014          smejia              Aranda 3065. Se redondea el campo consumo_promedio
                                            que se encuntra en el decode, validando si este campo
                                            es 0 o nulo.
    25-04-2014          hectorfdv           Se ajusta la funcion para calcular la desviacion
    12-12-2023          adrianavg           OSF-1819: Se ajusta al nombre correcto fsbGetDesviacion  en la descripción
                                            Se declaran variables para el manejo de trazas y error
                                            Se reemplaza SELECT-INTO por cursor cuDesviacion, se añade IF-ENDIF para manejo del NO_DATA_FOUND
                                            si el cursor no retorna datos
                                            Se implementa pkg_error.prInicializaError
                                            Ajustar bloque de exceptions según las pautas técnicas
    **************************************************************************/
    FUNCTION fsbGetDesviacion (inuFactura IN NUMBER)
        RETURN VARCHAR2
    IS
        sbDesviacion   VARCHAR2 (50);
        sbFactcodi     ge_boInstanceControl.stysbValue;

        --variables para el manejo de trazas y error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbGetDesviacion';
        nuError      NUMBER;
        sbError      VARCHAR2(2000);

        CURSOR cuDesviacion( p_sbFactcodi ge_boInstanceControl.stysbValue)
        IS
        SELECT TO_CHAR ( DECODE (ROUND (consumo_promedio),  0, 0, NULL, 0,
                    (  (  ROUND (consumo_actual)
                        - ROUND (consumo_promedio)) / ROUND (consumo_promedio))  * 100), 'FM999,999,990') || '%'    desviacion
        FROM (SELECT (  (  LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (
                         MAX (factpefa),
                         MAX (factcodi),
                         5)
                   + LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (
                         MAX (factpefa),
                         MAX (factcodi),
                         4)
                   + LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (
                         MAX (factpefa),
                         MAX (factcodi),
                         3)
                   + LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (
                         MAX (factpefa),
                         MAX (factcodi),
                         2)
                   + LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (
                         MAX (factpefa),
                         MAX (factcodi),
                         1)
                   + LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (
                         MAX (factpefa),
                         MAX (factcodi),
                         0))
                / 6)     consumo_promedio,
               NVL (
                   ROUND (
                       SUM (
                           DECODE (
                               sesucate,
                               1, cosscoca,
                               2, cosscoca,
                               3, DECODE (cossfcco,
                                          NULL, 0,
                                          cosscoca),
                               LDC_BOFORMATOFACTURA.fnuGetConsumoIndustriaNR ( factcodi))),  2), 0) consumo_actual
          FROM factura  f
               INNER JOIN servsusc s ON (sesususc = factsusc)
                LEFT OUTER JOIN conssesu c
                   ON (    c.cosssesu = s.sesunuse
                       AND c.cosspefa = f.factpefa
                       AND cossmecc = 4)
               LEFT OUTER JOIN cm_facocoss ON (cossfcco = fccocons)
         WHERE factcodi = p_sbFactcodi);

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);

        sbFactcodi := inuFactura;
        pkg_traza.trace(csbMetodo||' sbFactcodi: '||sbFactcodi, csbNivelTraza);

        OPEN cuDesviacion(sbFactcodi);
        FETCH cuDesviacion INTO sbDesviacion;
        CLOSE cuDesviacion;
        pkg_traza.trace(csbMetodo||' sbDesviacion: '||sbDesviacion, csbNivelTraza);

        IF sbDesviacion IS NULL THEN
           pkg_error.setError;
           RAISE NO_DATA_FOUND;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN sbDesviacion;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            pkg_traza.trace(csbMetodo||' NO_DATA_FOUND ', csbNivelTraza);
            RETURN TO_CHAR (0, 'FM999,999,990');
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
    END fsbGetDesviacion;

    /*****************************************************************
    Propiedad intelectual de Gases de occidente

    Function  :    FSBCONSULTAFECHREV
    Descripcion :  Calcula la fecha de la proxima
                   revision, si no es una fecha entonces
                   retorna el mensaje

    Parametros  :  Servicio
    Retorno     :onubReturn
    Autor    :  Hector Fabio Dominguez
    Fecha    :  08-01-2014

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    12-12-2023          adrianavg           OSF-1819: Se declaran variables para el manejo de trazas y error
                                            Se implementa pkg_error.prInicializaError
                                            Ajustar bloque de exceptions según las pautas técnicas
    *****************************************************************/

    FUNCTION FSBCONSULTAFECHREV (inuNuse IN NUMBER)
        RETURN VARCHAR2
    IS
        sbReturn   VARCHAR2 (1000);

        --variables para el manejo de trazas y error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'FSBCONSULTAFECHREV';
        nuError      NUMBER;
        sbError      VARCHAR2(2000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);
        pkg_traza.trace(csbMetodo||' inuNuse: '||inuNuse, csbNivelTraza);

        sbReturn :=
            TO_CHAR (
                TO_DATE (
                    LDC_BOFORMATOFACTURA.fnuGetFechaProxRevision (inuNuse),  'MON-yyyy'), 'MON-yyyy', 'NLS_DATE_LANGUAGE = SPANISH');

        pkg_traza.trace(csbMetodo||' sbReturn: '||sbReturn, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN sbReturn;
    EXCEPTION WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' sbReturn: '||LDC_BOFORMATOFACTURA.fnuGetFechaProxRevision ( inuNuse), csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
        RETURN LDC_BOFORMATOFACTURA.fnuGetFechaProxRevision ( inuNuse);
    END FSBCONSULTAFECHREV;

    /*****************************************************************
      Propiedad intelectual de Gases de occidente

      Function  :    FNUCONSULTAVALORANTFACT
      Descripcion :  Obtiene el valor facturado

      Parametros  :  Contrato
      Retorno     :onubReturn
      Autor    :  Hector Fabio Dominguez
      Fecha    :  08-01-2014

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
      29/12/2014        eaguera             Se coloca trunc(sysdate) en la comparacion de fecha de
                                            vencimiento del saldo anterior
      30/12/2014        Kbaquero            Se modifca el cursor  <<cuConsultaUltFact>> para que tenga
                                            en cuenta el ultimo perido de facturación generado y no la máxima
                                            cuenta de cobro.
      10/01/2018        Jorge Valiente      CASO 200-1626 Modificacion del proceso de obtener saldo anteior y colocar el nuevo servicio
      12-12-2023        adrianavg           OSF-1819: Se ajusta al nombre correcto FNUCONSULTAVALORANTFACT  en la descripción
                                            Se declaran variables para el manejo de trazas y error
                                            Se implementa pkg_error.prInicializaError
                                            Ajustar bloque de exceptions según las pautas técnicas
      *****************************************************************/

    FUNCTION FNUCONSULTAVALORANTFACT (nuSusccodi IN suscripc.susccodi%TYPE)
        RETURN NUMBER
    IS
        nuCodUltFact      NUMBER;
        nuSaldUltFact     NUMBER;
        onuReturnvalue    NUMBER := 0;
        nuSaldoAnterior   NUMBER;
        dtFechaVenc       DATE;

        /*
        * Descripcion: Se calcula cual es el ultimo periodo de las facturas con saldo
        *              Se obtiene las facturas de ese periodo y se suman los saldos pendientes
        * fecha: 03/03/2014
        *    TQ: 3034
        */
        CURSOR cuConsultaUltFact IS
              SELECT SUM (CUCOSACU) SALDO, cc.CUCOFACT
                FROM CUENCOBR cc
               WHERE cc.CUCOFACT IN (SELECT factu.factcodi
                                       FROM factura factu
                                      WHERE factu.factsusc = nuSusccodi
                                        AND (SELECT SUM (CUCOSACU)
                                               FROM CUENCOBR CCBR
                                              WHERE CCBR.CUCOFACT = factu.factcodi) > 0
                                         AND factu.FACTPEFA =
                                             (SELECT MAX (factusub.FACTPEFA)
                                                FROM FACTURA factusub
                                               WHERE factusub.factsusc = nuSusccodi
                                                 AND (SELECT SUM (CUCOSACU)
                                                        FROM CUENCOBR CCBR
                                                       WHERE CUCOFACT = factusub.factcodi) > 0))
            GROUP BY cc.CUCOFACT;

        --Consulta la fecha de vencimiento primera cuenta de cobro de la factura
        CURSOR cuConsultaFechVenc (iNuCodFact NUMBER)
        IS
            SELECT CUCOFEVE
              FROM CUENCOBR
             WHERE CUCOFACT = iNuCodFact AND ROWNUM <= 1;

        --variables para el manejo de trazas y error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'FNUCONSULTAVALORANTFACT';
        nuError      NUMBER;
        sbError      VARCHAR2(2000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);
        pkg_traza.trace(csbMetodo||' nuSusccodi: '||nuSusccodi, csbNivelTraza);

        --Se consulta la ultima factura generada
        OPEN cuConsultaUltFact;
        FETCH cuConsultaUltFact INTO nuSaldUltFact, nuCodUltFact;
        CLOSE cuConsultaUltFact;

        IF nuSaldUltFact IS NULL THEN
           nuSaldUltFact := 0;
        END IF;
        pkg_traza.trace(csbMetodo||' nuSaldUltFact: '||nuSaldUltFact, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' nuCodUltFact: '||nuCodUltFact, csbNivelTraza);

        --Se consulta a fecha de vencimiento de la primera cuenta de cobro
        OPEN cuConsultaFechVenc (nuCodUltFact);
        FETCH cuConsultaFechVenc INTO dtFechaVenc;
        CLOSE cuConsultaFechVenc;
        pkg_traza.trace(csbMetodo||' dtFechaVenc: '||dtFechaVenc, csbNivelTraza);

        --Se debe restar el saldo facturado al anterior siempre y cuando el saldo anterior sea superior o igual al facturado
        --en caso contrario quiere decir que el saldo anterior no esta incluido
        --CASO 200-1626
        --Se coloca en comentario para realizar el llamado del nuevo servicio
        nuSaldoAnterior := FnuGetSaldoAnterior (nuSusccodi, nuCodUltFact);
        pkg_traza.trace(csbMetodo||' nuSaldoAnterior: '||nuSaldoAnterior, csbNivelTraza);
        --CASO 200-1626

        /*
        * Si la fecha de vencimiento es menor a hoy, quiere decir que se debe realizar la resta
        * del valor facturado al saldo anterior, de lo contrario no, ya que el valor facturado
        * no se calculo dentro del saldo pendiente
        */

        --CASO 200-1626
        onuReturnvalue := NVL (nuSaldoAnterior, 0);
        pkg_traza.trace(csbMetodo||' onuReturnvalue: '||onuReturnvalue, csbNivelTraza);
        ---Fin CASO 200-1626

        --TQ 3278. FECHA: 31-03-2014 Ajuste para cuando el retorno de la api sea nulo
        IF onuReturnvalue IS NULL THEN
           onuReturnvalue := 0;
        END IF;

        pkg_traza.trace(csbMetodo||' onuReturnvalue: '||onuReturnvalue, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN onuReturnvalue;
    EXCEPTION
        WHEN OTHERS THEN
             pkg_Error.setError;
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
             RETURN 0;
    END FNUCONSULTAVALORANTFACT;

    /*****************************************************************
    Propiedad intelectual de Gases de occidente

    Function  :  fsbgetdescription
    Descripcion :  Obtiene descripcion del barrio

    Parametros  :  Descripcion
    Retorno     :osbReturn
    Autor    :  Hector Fabio Dominguez
    Fecha    :  10-11-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
     12-12-2023        adrianavg           OSF-1819: Se declaran variables para el manejo de trazas y error
                                           Se implementa pkg_error.prInicializaError
                                           Ajustar bloque de exceptions según las pautas técnicas
    *****************************************************************/

    FUNCTION fsbgetdescription (iNuGeo IN NUMBER)
        RETURN VARCHAR2
    IS
        osbReturn   VARCHAR2 (800);

        --variables para el manejo de trazas y error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbgetdescription';
        nuError      NUMBER;
        sbError      VARCHAR2(2000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);

        pkg_traza.trace(csbMetodo||' iNuGeo: '||iNuGeo, csbNivelTraza);

        osbReturn := dage_geogra_location.fsbgetdescription (iNuGeo);

        pkg_traza.trace(csbMetodo||' osbReturn: '||osbReturn, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN osbReturn;
    EXCEPTION
        WHEN OTHERS THEN
             pkg_Error.setError;
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
             RETURN ' ';
    END fsbgetdescription;

    /*****************************************************************
    Propiedad intelectual de Gases de occidente

    Function  :  fnugetgeo_loca_father_id
    Descripcion :  Obtiene el id del geograp padre

    Parametros  :  Descripcion
    inuConcept         Concepto
    inuCompType        Tipo de Consumo
    inuFOT             Forma de Obtener Tarifa

    Retorno     :
    nuTariffValid      Vigencia de Tarifa

    Autor    :  Hector Fabio Dominguez
    Fecha    :  10-11-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
     12-12-2023        adrianavg           OSF-1819: Se declaran variables para el manejo de trazas y error
                                           Se implementa pkg_error.prInicializaError
                                           Ajustar bloque de exceptions según las pautas técnicas
                                           Se añade RETURN oNuReturn;
    *****************************************************************/

    FUNCTION fnugetgeo_loca_father_id (iNuGeo IN NUMBER)
        RETURN NUMBER
    IS
        oNuReturn   NUMBER;

        --variables para el manejo de trazas y error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'fnugetgeo_loca_father_id';
        nuError      NUMBER;
        sbError      VARCHAR2(2000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);
        pkg_traza.trace(csbMetodo||' iNuGeo: '||iNuGeo, csbNivelTraza);

        oNuReturn :=  dage_geogra_location.fnugetgeo_loca_father_id (iNuGeo);

        pkg_traza.trace(csbMetodo||' oNuReturn: '||oNuReturn, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN oNuReturn;
    EXCEPTION
        WHEN OTHERS THEN
             pkg_Error.setError;
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
             RETURN -1;
    END fnugetgeo_loca_father_id;

    /*****************************************************************
      Propiedad intelectual de Gases de occidente

      Function    :  fnuConsultComponentCostoGen
      Descripcion :  Consulta componentes de costo

      Parametros  :  Descripcion
      inuConcept         Concepto
      inuCompType        Tipo de Consumo
      inuFOT             Forma de Obtener Tarifa
      nufactura          Numero de factura
      nuSuscripc         Contrato

     Retorno     :
     nuTariffValue      Valor

     Autor    :  Hector Fabio Dominguez
     Fecha    :  06-09-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
     29-04-2014         hectorfdv          Ajuste de retorno en la funcion fnuConsultComponentCostoGen para evitar retorno nulo TQ 3292
     12-12-2023         adrianavg          OSF-1819: Se ajusta al nombre correcto fnuConsultComponentCostoGen  en la descripción
                                           Se declaran variables para el manejo de trazas y error
                                           Se implementa pkg_error.prInicializaError
                                           Se reemplaza SELECT-INTO por cursor cuIndustriaNoRegulada, se añade IF-ENDIF para manejo de NO_DATA_FOUND
                                           Se reemplaza SELECT-INTO por cursor cuValorMonetario, se añade IF-ENDIF para manejo de NO_DATA_FOUND
                                           Se reemplaza SELECT-INTO por cursor vitcvalo, se añade IF-ENDIF para manejo de NO_DATA_FOUND
                                           Ajustar bloque de exceptions según las pautas técnicas
      *****************************************************************/

    FUNCTION fnuConsultComponentCostoGen (  inuConcept    IN concepto.conccodi%TYPE,
                                            inuCompType   IN lectelme.leemtcon%TYPE,
                                            inuFOT        IN NUMBER,
                                            nufactura     IN factura.factcodi%TYPE,
                                            nuSuscripc    IN servsusc.SESUSUSC%TYPE)
        RETURN ta_vigetaco.vitcvalo%TYPE
    IS
        nuVitcons                 ta_vigetaco.vitccons%TYPE;
        nuVitcvalo                ta_vigetaco.vitcvalo%TYPE;
        sbFactcodi                ge_boInstanceControl.stysbValue;

        nuEsIndustriaNoRegulada   NUMBER; -- 1 si es es una industria no regulada
        -- parametro de identificadores de categoria de industria no regulada
        sbParameter  ld_parameter.value_chain%TYPE  := dald_parameter.fsbGetValue_Chain ('CATEG_IDUSTRIA_NO_REG');

        --variables para el manejo de trazas y error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'fnuConsultComponentCostoGen';
        nuError      NUMBER;
        sbError      VARCHAR2(2000);

        CURSOR cuIndustriaNoRegulada(p_sbFactcodi ge_boInstanceControl.stysbValue)
        IS
        SELECT 1
          FROM factura,servsusc,
               (SELECT COLUMN_VALUE
                  FROM (SELECT regexp_substr(sbParameter, '[^|]+', 1, LEVEL) AS COLUMN_VALUE
                       FROM dual
                 CONNECT BY regexp_substr(sbParameter, '[^|]+', 1, LEVEL) IS NOT NULL) )
         WHERE factcodi = p_sbFactcodi
           AND sesususc = factsusc
           AND sesucate = COLUMN_VALUE
           AND ROWNUM = 1;

        CURSOR cuValorMonetario(p_inuConcept concepto.conccodi%TYPE,
                                p_sbFactcodi ge_boInstanceControl.stysbValue)
        IS
        SELECT ROUND (Total / cargunid, 2)
          FROM (SELECT DECODE (cargsign,
                               'CR', cargvalo * -1,
                               'PA', cargvalo * -1,
                               'AS', cargvalo * -1,
                               'DB', cargvalo,
                               cargvalo * -1)    Total,
                       cargunid
                  FROM factura   f,   cuencobr  cc,
                       cargos    cg,  concepto  c
                 WHERE cg.cargconc = c.conccodi
                   AND f.factcodi = cc.cucofact
                   AND cc.cucocodi = cg.cargcuco
                   AND (   SUBSTR (NVL (cargdoso, ' '), 1, 3) IN  ('CO-', 'CB-')
                        OR (    cargconc IN (137, 196, 37)
                        AND (SUBSTR (NVL (cargdoso, ' '),  1, 3) NOT IN  ('ID-', 'DF-'))))
                   AND c.concticl IN (1, 2)
                   AND cargconc = p_inuConcept
                   AND factcodi = p_sbFactcodi);

        CURSOR cuVitcvalo(p_nuVitcons ta_vigetaco.vitccons%TYPE)
        IS
        SELECT vitcvalo
          FROM ta_vigetaco
         WHERE vitccons = nuVitcons;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);
        pkg_traza.trace(csbMetodo||' inuConcept: '||inuConcept, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' inuCompType: '||inuCompType, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' inuFOT: '||inuFOT, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' nufactura: '||nufactura, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' nuSuscripc: '||nuSuscripc, csbNivelTraza);

        --Obtiene el identificador de la factura de la instancia
        sbFactcodi := nufactura;
        pkg_traza.trace(csbMetodo||' sbFactcodi: '||sbFactcodi, csbNivelTraza);

        -- Verifica si el cliente es industria no regulada
        BEGIN
            OPEN cuIndustriaNoRegulada(sbFactcodi);
            FETCH cuIndustriaNoRegulada INTO nuEsIndustriaNoRegulada;
            CLOSE cuIndustriaNoRegulada;

             IF nuEsIndustriaNoRegulada IS NULL THEN
                pkg_Error.setError;
                RAISE NO_DATA_FOUND;
             END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 nuEsIndustriaNoRegulada := 0;
        END;
        pkg_traza.trace(csbMetodo||' nuEsIndustriaNoRegulada: '||nuEsIndustriaNoRegulada, csbNivelTraza);

        IF nuEsIndustriaNoRegulada = 1 THEN
            -- Si es industria no regulada
            BEGIN
                 OPEN cuValorMonetario(inuConcept, sbFactcodi);
                FETCH cuValorMonetario INTO nuVitcvalo;
                CLOSE cuValorMonetario;
                IF nuVitcvalo IS NULL THEN
                   pkg_Error.setError;
                   RAISE NO_DATA_FOUND;
                END IF;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    nuVitcvalo := 0;
            END;
        ELSE
            -- Si la categoria es residencia, constructora, industria regulada
            BEGIN
                nuVitcons :=  LDCI_PKFACTKIOSCO_GDC.fnuConsultComponentCosto (  inuConcept,
                                                                                inuCompType,
                                                                                inuFOT,
                                                                                nufactura,
                                                                                nuSuscripc);
                pkg_traza.trace(csbMetodo||' nuVitcons: '||nuVitcons, csbNivelTraza);

            EXCEPTION
                WHEN pkg_error.CONTROLLED_ERROR THEN
                     pkg_Error.getError(nuError, sbError);
                     pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
                     pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                     RETURN 0;
                WHEN OTHERS THEN
                     pkg_Error.setError;
                     pkg_Error.getError(nuError, sbError);
                     pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
                     pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                     RETURN 0;
            END;

            IF nuVitcons IS NOT NULL THEN
                OPEN cuVitcvalo(nuVitcons);
               FETCH cuVitcvalo INTO nuVitcvalo;
               CLOSE cuVitcvalo;

                IF nuVitcvalo IS NULL THEN
                   pkg_Error.setError;
                   RAISE NO_DATA_FOUND;
                END IF;
            END IF;
        END IF;

        pkg_traza.trace(csbMetodo||' nuVitcvalo: '||nuVitcvalo, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        --tiquete 3292
        --fecha  29-04-2014
        --hectorfdv se realiza cambio en el retorno con nvl  para evitar retornar valores nulos
        RETURN NVL (nuVitcvalo, 0);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             nuVitcvalo := 0;
             pkg_traza.trace(csbMetodo||' NO_DATA_FOUND- nuVitcvalo '||nuVitcvalo, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
             RETURN nuVitcvalo;
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
             RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
             pkg_error.setError;
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
             RAISE pkg_error.CONTROLLED_ERROR;
    END fnuConsultComponentCostoGen;

    /*****************************************************************
    Propiedad intelectual de Gases de occidente

    Function    :  fnuConsultComponentCostoGeneric
    Descripcion :  Consulta componentes de costo

    Parametros  :  Descripcion
    inuConcept         Concepto
    inuCompType        Tipo de Consumo
    inuFOT             Forma de Obtener Tarifa
    nufactura          Numero de factura
    nuSuscripc         Contrato

    Retorno     :
    nuTariffValue      Valor

    Autor    :  Hector Fabio Dominguez
    Fecha    :  06-09-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
     12-12-2023         adrianavg          OSF-1819: Se declaran variables para el manejo de trazas
                                           Se implementa pkg_error.prInicializaError
                                           Ajustar bloque de exceptions según las pautas técnicas
    *****************************************************************/

    FUNCTION fnuConsultComponentCosto ( inuConcept    IN concepto.conccodi%TYPE,
                                        inuCompType   IN lectelme.leemtcon%TYPE,
                                        inuFOT        IN NUMBER,
                                        nufactura     IN factura.factcodi%TYPE,
                                        nuSuscripc    IN servsusc.SESUSUSC%TYPE)
        RETURN ta_vigetaco.vitcvalo%TYPE
    IS
        ------------------------------------------------------------------
        -- VARIABLES ENCAPSULADOS
        ------------------------------------------------------------------
        -- Periodo de Consumo Actual
        nuCompPeriodCurr    pericose.pecscons%TYPE;

        -- Periodo de Consumo Anterior
        nuCompPeriodPrev    pericose.pecscons%TYPE;

        -- Fecha de Lectura Inicial
        dtInitialReadDate   lectelme.leemfele%TYPE;

        -- Fecha de Lectura Final
        dtLastReadDate      lectelme.leemfele%TYPE;

        -- Registro del Producto
        rcProduct           servsusc%ROWTYPE;

        -- Registro de Factura
        rcBill              factura%ROWTYPE;

        -- Código de Tarifa
        nuTariffConc        ta_tariconc.tacocons%TYPE;

        -- Vigencia de Tarifa
        nuTariffValid       ta_vigetaco.vitccons%TYPE := NULL;

        -- Valor de la Tarifa
        nuTariffValue       ta_vigetaco.vitcvalo%TYPE;

        -- Porcentaje de la Tarifa
        nuTariffPerc        ta_vigetaco.vitcporc%TYPE;

        -- Identificador del producto
        nuproductid         servsusc.SESUNUSE%TYPE;

        onuErrorCode        NUMBER;
        osbErrorMessage     VARCHAR2 (2000);

        --variables para el manejo de trazas y error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'fnuConsultComponentCosto';

        --Cursor para consultar el producto
        CURSOR cuProducto IS
            SELECT *
              FROM servsusc
             WHERE SESUSUSC = nuSuscripc AND SESUSERV = 7014;

        --Cursor para consultar la factura
        CURSOR cuFactura IS
            SELECT *
              FROM FACTURA
             WHERE FACTCODI = nufactura;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( onuErrorCode, osbErrorMessage);
        pkg_traza.trace(csbMetodo||' inuConcept:  '||inuConcept, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' inuCompType: '||inuCompType, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' inuFOT:      '||inuFOT, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' nufactura:   '||nufactura, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' nuSuscripc:  '||nuSuscripc, csbNivelTraza);

        --Consultamos el producto
        OPEN cuProducto;
        FETCH cuProducto INTO rcProduct;
        CLOSE cuProducto;
        pkg_traza.trace(csbMetodo||' Ciclo De Consumo: '||rcProduct.sesucico, csbNivelTraza);

        --Consultamos la factura
        OPEN cuFactura;
        FETCH cuFactura INTO rcBill;
        CLOSE cuFactura;

        -- Obtener Informaciión desde la Instancia
        pkg_traza.trace(csbMetodo||' Periodo de Facturacion: '||rcBill.factpefa, csbNivelTraza);

        -- Obtener el periodo de consumo actual
        pkBCPericose.GetConsPerByBillPer (rcProduct.sesucico,
                                          rcBill.factpefa,
                                          nuCompPeriodCurr);
        pkg_traza.trace(csbMetodo||' nuCompPeriodCurr: '||nuCompPeriodCurr, csbNivelTraza);

        -- Obtener el periodo de consumo anterior
        pkBOPericose.GetPrevConsPeriod (nuCompPeriodCurr, nuCompPeriodPrev);
        pkg_traza.trace(csbMetodo||' nuCompPeriodPrev: '||nuCompPeriodPrev, csbNivelTraza);

        -- Obtener la fecha de lectura inicial
        CI_BCLectelme.GetLastReadingDate (nuCompPeriodPrev,
                                          rcProduct.sesunuse,
                                          inuCompType,
                                          dtInitialReadDate);
        pkg_traza.trace(csbMetodo||' dtInitialReadDate: '||dtInitialReadDate, csbNivelTraza);

        -- Obtener la fecha de lectura final
        CI_BCLectelme.GetLastReadingDate (nuCompPeriodCurr,
                                          rcProduct.sesunuse,
                                          inuCompType,
                                          dtLastReadDate);
        pkg_traza.trace(csbMetodo||' dtLastReadDate: '||dtLastReadDate, csbNivelTraza);

        -- Obtener la Tarifa para el Concepto
        TA_BOTarifas.LiqTarifa (rcProduct.sesuserv,
                                inuConcept,
                                rcProduct.sesunuse,
                                rcBill.factsusc,
                                dtInitialReadDate,
                                dtLastReadDate,
                                rcProduct.sesufevi,
                                NULL,
                                NULL,
                                inuFOT,
                                FALSE,
                                nuTariffConc,
                                nuTariffValid,
                                nuTariffValue,
                                nuTariffPerc);

        pkg_traza.trace(csbMetodo||' nuTariffValid: '||nuTariffValid, csbNivelTraza);

        pkg_traza.trace(csbMetodo||' nuTariffValue: '||nuTariffValue, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        -- Retorna el código de la vigencia de tarifa
        RETURN nuTariffValue;
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.seterror;
            pkg_error.geterror (onuErrorCode, osbErrorMessage);
            pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RETURN 0;
    END fnuConsultComponentCosto;

    /*****************************************************************
    Propiedad intelectual de Gases de occidente

    Function  :  fnuObtenerInteresMora
    Descripcion :  Obtiene la vigencia de tarifa para el componente
                   de costo.

    Parametros  :  Descripcion
    inuConcept         Concepto
    inuCompType        Tipo de Consumo
    inuFOT             Forma de Obtener Tarifa

    Retorno     :
    nuTariffValid      Vigencia de Tarifa

    Autor    :  Hector Fabio Dominguez
    Fecha    :  06-09-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
     12-12-2023         adrianavg          OSF-1819: Se declaran variables para el manejo de trazas
                                           Se implementa pkg_error.prInicializaError
                                           Ajustar bloque de exceptions según las pautas técnicas
    *****************************************************************/
    FUNCTION fnuObtenerInteresMora (inuCupon       IN CUPON.CUPONUME%TYPE,
                                    inuFactura     IN NUMBER,
                                    onuErrorCode   OUT NUMBER,
                                    osbErrorMsg    OUT VARCHAR2)
        RETURN ta_vigetaco.vitcporc%TYPE
    IS
        -- Porcentaje de la Tarifa
        nuTariffPerc   ta_vigetaco.vitcporc%TYPE;

        -- Parametro: identificador del concepto de interes de mora
        nuParConcInt   NUMBER;

        -- Identificador de la factura
        nuFactcodi     factura.factcodi%TYPE;

        --variables para el manejo de trazas
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'fnuObtenerInteresMora';

        CURSOR cuTarifa (inuConcepto   concepto.conccodi%TYPE,
                         inuFactura    factura.factcodi%TYPE)
        IS
            SELECT vitcporc
              FROM factura,
                   perifact,
                   ta_conftaco,
                   ta_tariconc,
                   ta_vigetaco
             WHERE factpefa = pefacodi
               AND tacocotc = cotccons
               AND vitctaco = tacocons
               AND pefaffmo BETWEEN cotcfein AND cotcfefi
               AND pefaffmo BETWEEN vitcfein AND vitcfefi
               AND cotcconc = inuConcepto
               AND factcodi = inuFactura
               AND ROWNUM = 1;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( onuErrorCode, osbErrorMsg);
        pkg_traza.trace(csbMetodo||' inuCupon: '||inuCupon, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' inuFactura: '||inuFactura, csbNivelTraza);

        -- Obtiene el identificador de la factura de la instancia
        nuFactcodi := inuFactura;
        pkg_traza.trace(csbMetodo||' nuFactcodi: '||nuFactcodi, csbNivelTraza);

        nuParConcInt := TO_NUMBER ( DALD_PARAMETER.fsbGetValue_Chain ('LDC_ID_CONCEPTOS_INTERES_MORA',  NULL));
        pkg_traza.trace(csbMetodo||' nuParConcInt: '||nuParConcInt, csbNivelTraza);

         OPEN cuTarifa (nuParConcInt, nuFactcodi);
        FETCH cuTarifa INTO nuTariffPerc;
        CLOSE cuTarifa;
        pkg_traza.trace(csbMetodo||' nuTariffPerc: '||nuTariffPerc, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        -- Retorna el código de la vigencia de tarifa
        RETURN ((NVL (nuTariffPerc, 0)));
    EXCEPTION
        WHEN OTHERS THEN
             pkg_error.seterror;
             pkg_error.geterror (onuErrorCode, osbErrorMsg);
             onuErrorCode := -666;
             osbErrorMsg := ' Error generando la informacion a imprimir en la factura: '
                            || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ' error ' || SQLERRM;
             pkg_traza.trace('osbErrorMsg: ' || osbErrorMsg, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
             RETURN NULL;
    END fnuObtenerInteresMora;

    /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

            FUNCTION : prcCierraCursores
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 10/09/2013
             RICEF   : I045
         DESCRIPCION : Esta funcion se encarga de cerrar los cursores

     Historia de Modificaciones

     Autor          Fecha             Descripcion.
     HECTORFDV      10/09/2013        Creacion del paquete
     adrianavg      12-12-2023        OSF-1819: Se declaran variables para el manejo de trazas
    ************************************************************************/

    PROCEDURE prcCierraCursor (CUCURSOR IN OUT SYS_REFCURSOR)
    AS
        --variables para el manejo de trazas
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'prcCierraCursor';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        IF NOT CUCURSOR%ISOPEN
        THEN
            OPEN CUCURSOR FOR SELECT *
                                FROM DUAL
                               WHERE 1 = 2;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    END;

    /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

            FUNCTION : prcCierraCursores
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 10/09/2013
             RICEF   : I045
         DESCRIPCION : Esta funcion se encarga de cerrar los cursores

     Historia de Modificaciones

     Autor          Fecha             Descripcion.
     HECTORFDV      10/09/2013        Creacion del paquete
     adrianavg      12-12-2023        OSF-1819: Se declaran variables para el manejo de trazas
    ************************************************************************/

    PROCEDURE prcCierraCursores (CUDATOSBASIC    IN OUT SYS_REFCURSOR,
                                 CUFACTDETA      IN OUT SYS_REFCURSOR,
                                 CURANGOS        IN OUT SYS_REFCURSOR,
                                 CUHISTORICO     IN OUT SYS_REFCURSOR,
                                 CULECTURAS      IN OUT SYS_REFCURSOR,
                                 CUCONSUMOS      IN OUT SYS_REFCURSOR,
                                 CUCOMPONENTES   IN OUT SYS_REFCURSOR)
    AS
        --variables para el manejo de trazas
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'prcCierraCursores';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        IF NOT CUDATOSBASIC%ISOPEN
        THEN
            OPEN CUDATOSBASIC FOR SELECT *
                                    FROM DUAL
                                   WHERE 1 = 2;
        END IF;

        IF NOT CUFACTDETA%ISOPEN
        THEN
            OPEN CUFACTDETA FOR SELECT *
                                  FROM DUAL
                                 WHERE 1 = 2;
        END IF;

        IF NOT CURANGOS%ISOPEN
        THEN
            OPEN CURANGOS FOR SELECT *
                                FROM DUAL
                               WHERE 1 = 2;
        END IF;

        IF NOT CUHISTORICO%ISOPEN
        THEN
            OPEN CUHISTORICO FOR SELECT *
                                   FROM DUAL
                                  WHERE 1 = 2;
        END IF;

        IF NOT CULECTURAS%ISOPEN
        THEN
            OPEN CULECTURAS FOR SELECT *
                                  FROM DUAL
                                 WHERE 1 = 2;
        END IF;

        IF NOT CUCONSUMOS%ISOPEN
        THEN
            OPEN CUCONSUMOS FOR SELECT *
                                  FROM DUAL
                                 WHERE 1 = 2;
        END IF;

        IF NOT CUCOMPONENTES%ISOPEN
        THEN
            OPEN CUCOMPONENTES FOR SELECT *
                                     FROM DUAL
                                    WHERE 1 = 2;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    END;

    /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

            FUNCTION : FSBORDENIMPRIME
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 17/12/2014
             RICEF   : I045
         DESCRIPCION : Funcion encargada de indicar si el usuario puede o no imprimir

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     HECTORFDV    17/12/2013  Creacion del paquete
     adrianavg    12-12-2023  OSF-1819: Se declaran variables para el manejo de traza
                              Se retiran variables declaradas sin uso: SBMENSAJEALERTA, NURESEXISTE
                              Se implementa pkg_error.prInicializaError
                              Ajustar bloque de exceptions según las pautas técnicas
    ************************************************************************/

    FUNCTION FSBORDENIMPRIME (nususccodi     IN SUSCRIPC.SUSCCODI%TYPE,
                              inuTipoSaldo   IN NUMBER)
        RETURN VARCHAR2
    IS
        -- Consultas las alertas del Kiosco. FECHA: 22-11-2014. TIQUETE: ROLLOUT
        CURSOR cuAlertas IS
            SELECT *
              FROM LDCI_KIOSCO_REGLAS
             WHERE TIPO = 'IMPRIME' AND ACTIVO = 'S';

        --Variable de control para las reglas
        rcData            LDCI_KIOSCO_REGLAS%ROWTYPE;
        sbRespuesta       VARCHAR2 (4000);
        onuErrorCode      NUMBER;
        osbErrormessage   VARCHAR2 (4000);
        osbrerno          VARCHAR2 (4000);

        --variables para el manejo de trazas
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'FSBORDENIMPRIME';

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( onuErrorCode, osbErrormessage);
        pkg_traza.trace(csbMetodo||' nususccodi: '||nususccodi, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' inuTipoSaldo: '||inuTipoSaldo, csbNivelTraza);

        FOR rcData IN cuAlertas
        LOOP
            EXECUTE IMMEDIATE RCDATA.FUENTE
                USING IN NUSUSCCODI, INUTIPOSALDO, OUT SBRESPUESTA;

            IF SBRESPUESTA = 'N'
            THEN
                OSBRERNO := RCDATA.COMENTARIO;
            ELSE
                OSBRERNO := SBRESPUESTA;
            END IF;

            EXIT WHEN UPPER (SBRESPUESTA) = 'N';
        END LOOP;

        pkg_traza.trace(csbMetodo||' SBRESPUESTA: '||SBRESPUESTA, csbNivelTraza);

        pkg_traza.trace(csbMetodo||' OSBRERNO: '||OSBRERNO, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN OSBRERNO;
    EXCEPTION
        WHEN OTHERS THEN
             osbErrorMessage := 'Error consultando saldo actual: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
             pkg_error.seterror;
             pkg_error.geterror (onuErrorCode, osbErrorMessage);
             pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, pkg_traza.cnuNivelTrzDef);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
             RETURN 'S';
    END FSBORDENIMPRIME;

    /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

            FUNCTION : fsbOrdenSuspContrato
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 16/05/2013
             RICEF   : I045
         DESCRIPCION : Funcion encargada de indicar si el usuario tiene una
                       orden de suspencion en proceso

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     HECTORFDV    16/05/2013  Creacion del paquete
     adrianavg    12-12-2023  OSF-1819: Se declaran variables para el manejo de traza
                              Se implementa pkg_error.prInicializaError
                              Ajustar bloque de exceptions según las pautas técnicas
    ************************************************************************/
    FUNCTION fsbOrdenSuspContrato (nuSusccodi IN suscripc.susccodi%TYPE)
        RETURN VARCHAR2
    IS
        --Consultas las alertas del Kiosco, FECHA: 22-11-2014, TIQUETE: ROLLOUT
        CURSOR cuAlertas IS
            SELECT *
              FROM LDCI_KIOSCO_REGLAS
             WHERE TIPO = 'ALERT' AND ACTIVO = 'S';

        -- Variable de control para las reglas

        rcData            LDCI_KIOSCO_REGLAS%ROWTYPE;
        sbRespuesta       VARCHAR2 (4000);
        sbMensajeAlerta   VARCHAR2 (4000) := '';
        nuResExiste       VARCHAR2 (4000);

        --variables para el manejo de trazas
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbOrdenSuspContrato';
        nuError      NUMBER;
        sbError      VARCHAR2(2000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);
        pkg_traza.trace(csbMetodo||' nususccodi: '||nususccodi, csbNivelTraza);

        FOR rcData IN cuAlertas
        LOOP
            EXECUTE IMMEDIATE rcData.FUENTE
                USING IN nuSusccodi, OUT sbRespuesta;

            IF UPPER (sbRespuesta) <> 'N'
            THEN
                sbMensajeAlerta :=  sbMensajeAlerta || REPLACE (rcData.COMENTARIO, '@1', sbRespuesta);
            END IF;
        END LOOP;

        IF sbMensajeAlerta = '' OR sbMensajeAlerta IS NULL
        THEN
            sbMensajeAlerta := 'N';
        END IF;
        pkg_traza.trace(csbMetodo||' sbMensajeAlerta: '||sbMensajeAlerta, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN sbMensajeAlerta;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo||' nuResExiste: ' || nuResExiste, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
             RETURN nuResExiste;
             RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo||' nuResExiste: ' || nuResExiste, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RETURN nuResExiste;
            RAISE pkg_error.Controlled_Error;
    END fsbOrdenSuspContrato;

    /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

            FUNCTION : fsbProcFactura
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 16/05/2013
             RICEF   :
         DESCRIPCION : Funcion encargada de validar si un contrato se encuentra en
                       proceso de facturacion

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     HECTORFDV    16/05/2013  Creacion del paquete
     adrianavg    12-12-2023  OSF-1819: Se declaran variables para el manejo de traza y error
                              Se implementa pkg_error.prInicializaError
                              Ajustar bloque de exceptions según las pautas técnicas
    ************************************************************************/
    FUNCTION fsbProcFactura (nuSusccodi IN suscripc.susccodi%TYPE)
        RETURN VARCHAR2
    IS
        nuExiste      NUMBER;
        nuResExiste   VARCHAR (2);

        CURSOR cuExiste
        IS
        SELECT COUNT (1)
          FROM Procejec
         WHERE Prejprog = 'FGCA'
           AND Prejespr <> 'E'
           AND PREJCOPE = (SELECT PEFACODI
                             FROM PERIFACT
                            WHERE pefaactu = 'S'
                              AND PEFACICL = (SELECT SUSCCICL
                                                FROM SUSCRIPC
                                               WHERE SUSCCODI = nuSusccodi)
                              AND ROWNUM = 1);

        --variables para el manejo de trazas y error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbProcFactura';
        nuError      NUMBER;
        sbError      VARCHAR2(2000);

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);
        pkg_traza.trace(csbMetodo||' nuSusccodi: '||nuSusccodi, csbNivelTraza);

        nuResExiste := '-1';

        BEGIN
            OPEN cuExiste;
            FETCH cuExiste INTO nuExiste;
            CLOSE cuExiste;

        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN
                 pkg_error.setError;--ADD OSF-1819
                 RAISE pkg_error.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                 pkg_error.setError;
                 RAISE pkg_error.CONTROLLED_ERROR;
        END;
        pkg_traza.trace(csbMetodo||' nuExiste: '||nuExiste, csbNivelTraza);

        IF (nuExiste = 1) THEN
            nuResExiste := 'S';
        ELSE
            nuResExiste := 'N';
        END IF;
        pkg_traza.trace(csbMetodo||' nuResExiste: '||nuResExiste, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN nuResExiste;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
             RETURN nuResExiste;
             RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
             pkg_error.setError;
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
             RETURN nuResExiste;
             RAISE pkg_error.CONTROLLED_ERROR;
    END fsbProcFactura;

    /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

            FUNCTION : countSyfRefCursor
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 16/05/2013
             RICEF   :
         DESCRIPCION : Funcion de utilidad para obtener el numero de filas
               que contiene un cursor

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     HECTORFDV    16/05/2013  Creacion del paquete
     adrianavg    12-12-2023  OSF-1819: Ajustar nombre por el correcto countSyfRefCursor
                              Se declaran variables para el manejo de traza
                              Ajustar bloque de exceptions según las pautas técnicas
    ************************************************************************/
    FUNCTION countSyfRefCursor (icRef IN SYS_REFCURSOR)
        RETURN NUMBER
    IS
        cSql   NUMBER;
        cnt    INTEGER;
        cRef   SYS_REFCURSOR;

        --variables para el manejo de trazas
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'countSyfRefCursor';

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);

        cRef := icRef;
        -- convert it to a DBMS_SQL cursor
        cSql := DBMS_SQL.to_cursor_number (cRef);

        -- now loop through it
        cnt := 0;

        LOOP
            EXIT WHEN DBMS_SQL.fetch_rows (cSql) = 0;
            cnt := cnt + 1;
        END LOOP;

        DBMS_SQL.close_cursor (cSql);

        pkg_traza.trace(csbMetodo||' cnt: '||cnt, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN cnt;
    END countSyfRefCursor;

    /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

            FUNCTION : FNUCONSULTASADOANT
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 16/05/2013
             RICEF   : I045
         DESCRIPCION : Proceso encargado de retornar la informacion del saldo anterior

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     HECTORFDV    16/05/2013  Creacion del paquete
     ADRIANAVG    12/12/2023  OSF-1819: Se retiran variables declaradas sin uso: nuIdentificacion, nuTelefono y sbMunicipio
                              Se implementa pkg_error.prInicializaError
                              Se declaran variables para el manejo de traza.
                              Ajustar bloque de exceptions según las pautas técnicas
    ************************************************************************/

    FUNCTION FNUCONSULTASADOANT (nuSusccodi IN suscripc.susccodi%TYPE)
        RETURN NUMBER
    IS
        onuSaldoPend         NUMBER;
        onuSaldoAnterior     NUMBER;
        onuPeriodoCant       NUMBER;
        sbDireccion          VARCHAR2 (500);
        sbCategoria          VARCHAR2 (500);
        onuErrorCode         NUMBER;
        osbErrorMessage      VARCHAR2 (1000);
        onudeferredbalance   NUMBER;

        --variables para el manejo de trazas
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'FNUCONSULTASADOANT';

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( onuErrorCode, osbErrorMessage);
        pkg_traza.trace(csbMetodo||' nuSusccodi: '||nuSusccodi, csbNivelTraza);

        /* Se llama al api que retorna el saldo anterior  */
        API_GETSUBSCRIPBALANCE (nuSusccodi,
                                NULL,
                                onuSaldoPend,
                                onudeferredbalance,
                                onuSaldoAnterior,
                                onuPeriodoCant,
                                onuErrorCode,
                                osbErrorMessage);

        pkg_traza.trace(csbMetodo||' onuSaldoPend: '||onuSaldoPend, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' onudeferredbalance: '||onudeferredbalance, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' onuPeriodoCant: '||onuPeriodoCant, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' onuErrorCode: '||onuErrorCode, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

        --TQ 3278, FECHA: 31-03-2014 Ajuste para cuando el retorno de la api sea nulo
        IF onuSaldoAnterior IS NULL
        THEN
            onuSaldoAnterior := 0;
        END IF;
        pkg_traza.trace(csbMetodo||' onuSaldoAnterior: '||onuSaldoAnterior, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN onuSaldoAnterior;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             ROLLBACK;
             pkg_error.geterror (onuErrorCode, osbErrorMessage);
             pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
             osbErrorMessage := 'Error consultando saldo anterior: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
             pkg_error.seterror;
             pkg_error.geterror (onuErrorCode, osbErrorMessage);
             pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
    END FNUCONSULTASADOANT;

    /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

            FUNCTION : FNUCONSULTASADOACT
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 16/05/2013
             RICEF   : I045
         DESCRIPCION : Proceso encargado de retornar la informacion del saldo actual

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     HECTORFDV    16/05/2013  Creacion del paquete
     ADRIANAVG    12/12/2023  OSF-1819: Se retiran variables declaradas sin uso: nuIdentificacion, nuTelefono y sbMunicipio
                              Se implementa pkg_error.prInicializaError
                              Se declaran variables para el manejo de traza.
                              Ajustar bloque de exceptions según las pautas técnicas
    ************************************************************************/
    FUNCTION FNUCONSULTASADOACT (nuSusccodi IN suscripc.susccodi%TYPE)
        RETURN NUMBER
    IS
        onuSaldoPend         NUMBER;
        onuSaldoAnterior     NUMBER;
        onuPeriodoCant       NUMBER;
        sbDireccion          VARCHAR2 (500);
        sbCategoria          VARCHAR2 (500);
        onuErrorCode         NUMBER;
        osbErrorMessage      VARCHAR2 (1000);
        onudeferredbalance   NUMBER;

        --variables para el manejo de trazas
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'FNUCONSULTASADOACT';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( onuErrorCode, osbErrorMessage);
        pkg_traza.trace(csbMetodo||' nuSusccodi: '||nuSusccodi, csbNivelTraza);

        /* Se consulta el api que retorna el saldo actual  */
        API_GETSUBSCRIPBALANCE (nuSusccodi,
                                NULL,
                                onuSaldoPend,
                                onudeferredbalance,
                                onuSaldoAnterior,
                                onuPeriodoCant,
                                onuErrorCode,
                                osbErrorMessage);


        pkg_traza.trace(csbMetodo||' onudeferredbalance: '||onudeferredbalance, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' onuSaldoAnterior: '||onuSaldoAnterior, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' onuPeriodoCant: '||onuPeriodoCant, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' onuErrorCode: '||onuErrorCode, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

        --TQ 3278 FECHA: 31-03-2014 Ajuste para cuando el retorno de la api sea nulo
        IF onuSaldoPend IS NULL
        THEN
            onuSaldoPend := 0;
        END IF;
        pkg_traza.trace(csbMetodo||' onuSaldoPend: '||onuSaldoPend, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN onuSaldoPend;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             ROLLBACK;
             pkg_error.geterror (onuErrorCode, osbErrorMessage);
             pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
             osbErrorMessage := 'Error consultando saldo actual: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
             pkg_error.seterror;
             pkg_error.geterror (onuErrorCode, osbErrorMessage);
             pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
    END FNUCONSULTASADOACT;

    /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

           PROCEDURE : PROCONSULTASUSCRIPC
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 16/05/2013
             RICEF   : I042
         DESCRIPCION : Proceso encargado de consultar la informacion que se
                       encuentran disponible para obtener duplicado

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     HECTORFDV    16/05/2013  Creacion del paquete
     Carlosr      24/04/2017  CA. 200-904. Mensajes kiosko
     ADRIANAVG    12/12/2023  OSF-1819: Se implementa pkg_error.prInicializaError
                              Se declaran variables para el manejo de traza y al interior del pr GetMensaje.
                              Se retiran variables declaradas ONUDEFERREDBALANCE, nuCantReg, CUSUSCRIPCIONESAUX
                              Se reemplaza Ldc_Boutilities.Splitstrings por regexp_substr en cursor ocuMensaje
                              Se reemplaza Ldc_Boutilities.Splitstrings por regexp_substr en el DELETE FROM ldci_kiosco_reglas_tmp
                              Ajustar bloque de exceptions según las pautas técnicas
    ************************************************************************/

    PROCEDURE PROCONSULTASUSCRIPC ( inuSusccodi         IN  suscripc.susccodi%TYPE,
                                    isbIdentificacion   IN  VARCHAR2,
                                    isbTelefono         IN  VARCHAR2,
                                    nuServicio          IN  NUMBER,
                                    CUSUSCRIPCIONES     OUT SYS_REFCURSOR,
                                    ocuMensaje          OUT SYS_REFCURSOR,
                                    onuErrorCode        OUT NUMBER,
                                    osbErrorMessage     OUT VARCHAR2)
    AS
        sbContrato           VARCHAR2 (2000);

        --variables para el manejo de trazas y error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'PROCONSULTASUSCRIPC';

        PROCEDURE GetMensaje (inuSusccodi         IN     suscripc.susccodi%TYPE,
                              isbIdentificacion   IN     VARCHAR2,
                              isbTelefono         IN     VARCHAR2,
                              osbContratos        OUT    VARCHAR2)
        IS

            CURSOR cuMensajes IS
                SELECT *
                  FROM LDCI_KIOSCO_REGLAS
                 WHERE ACTIVO = 'S' AND TRIM (FUENTE) IS NOT NULL;

            --Variable de control para las reglas
            rcData            LDCI_KIOSCO_REGLAS%ROWTYPE;
            sbRespuesta       VARCHAR2 (4000);
            sbMensajeAlerta   VARCHAR2 (4000) := '';
            nuResExiste       VARCHAR2 (4000);
            nuContrato        NUMBER;
            sbContratos       VARCHAR2 (2000);
            nuCont            NUMBER := 1;

            -- contrato por identificacion
            CURSOR cuContratoIdent IS
                SELECT susccodi     Contrato
                  FROM Suscripc Sus, Servsusc Serv, Ge_Subscriber Gesus
                 WHERE Serv.Sesususc = Sus.Susccodi
                   AND Gesus.Subscriber_Id = Sus.SUSCCLIE
                   AND Serv.Sesuserv = 7014
                   AND Gesus.identification = isbIdentificacion;

            -- contrato por telefono
            CURSOR cuContratoTel IS
                SELECT susccodi     Contrato
                  FROM Suscripc Sus, Servsusc Serv, Ge_Subscriber Gesus
                 WHERE Serv.Sesususc = Sus.Susccodi
                   AND Gesus.Subscriber_Id = Sus.SUSCCLIE
                   AND Serv.Sesuserv = 7014
                   AND Gesus.phone = isbTelefono;

        --variables para el manejo de trazas y error
        csbMetodo          CONSTANT VARCHAR2(100) := csbNOMPKG||'PROCONSULTASUSCRIPC.GetMensaje';
        csbNivelTraza2     CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzTrg;
        BEGIN

            pkg_traza.trace(csbMetodo, csbNivelTraza2, pkg_traza.csbInicio);
            pkg_traza.trace(csbMetodo||' inuSusccodi: '||inuSusccodi, csbNivelTraza2);
            pkg_traza.trace(csbMetodo||' isbIdentificacion: '||isbIdentificacion, csbNivelTraza2);
            pkg_traza.trace(csbMetodo||' isbTelefono: '||isbTelefono, csbNivelTraza2);

            -- validacion datos de entrada
            IF inuSusccodi <> -1
            THEN
                nuContrato := inuSusccodi;
                pkg_traza.trace(csbMetodo||' inuSusccodi <> -1 ', csbNivelTraza2);
                -- procesar los mensajes
                FOR rcData IN cuMensajes
                LOOP
                    EXECUTE IMMEDIATE rcData.FUENTE USING IN nuContrato, OUT sbRespuesta;

                    IF UPPER (sbRespuesta) <> 'N' THEN
                        sbMensajeAlerta := sbMensajeAlerta || REPLACE (rcData.COMENTARIO, '@1', sbRespuesta);

                        IF sbMensajeAlerta = '' OR sbMensajeAlerta IS NULL THEN
                            sbMensajeAlerta := 'N';
                        ELSE
                            -- se guardan mensajes correcto
                            INSERT INTO LDCI_KIOSCO_REGLAS_TMP
                                 VALUES (SEQ_KIOSCO_REGLAS_TMP.NEXTVAL,
                                         nuContrato,
                                         rcData.tipo,
                                         sbMensajeAlerta,
                                         rcData.orden,
                                         rcData.accion);
                            pkg_traza.trace(csbMetodo||' INSERT INTO LDCI_KIOSCO_REGLAS_TMP 1', csbNivelTraza2);
                            sbMensajeAlerta := '';
                        END IF;
                    END IF;

                    nuCont := nuCont + 1;
                END LOOP;

                sbContratos := nuContrato;
            ELSIF isbIdentificacion IS NOT NULL THEN
                pkg_traza.trace(csbMetodo||' evaluar los contratos de la identificacion ', csbNivelTraza2);
                -- evaluar los contratos de la identificacion
                FOR rc IN cuContratoIdent
                LOOP
                    -- procesar los mensajes
                    FOR rcData IN cuMensajes
                    LOOP
                        EXECUTE IMMEDIATE rcData.FUENTE  USING IN rc.Contrato, OUT sbRespuesta;

                        IF UPPER (sbRespuesta) <> 'N' THEN
                            sbMensajeAlerta :=  sbMensajeAlerta  || REPLACE (rcData.COMENTARIO, '@1', sbRespuesta);

                            IF sbMensajeAlerta = '' OR sbMensajeAlerta IS NULL
                            THEN
                                sbMensajeAlerta := 'N';
                            ELSE
                                -- se guardan mensajes correcto
                                INSERT INTO LDCI_KIOSCO_REGLAS_TMP
                                     VALUES (SEQ_KIOSCO_REGLAS_TMP.NEXTVAL,
                                             rc.Contrato,
                                             rcData.tipo,
                                             sbMensajeAlerta,
                                             rcData.orden,
                                             rcData.accion);
                                pkg_traza.trace(csbMetodo||' INSERT INTO LDCI_KIOSCO_REGLAS_TMP 2', csbNivelTraza2);
                                sbMensajeAlerta := '';
                            END IF;
                        END IF;
                        nuCont := nuCont + 1;
                    END LOOP;

                    IF (sbContratos IS NULL) THEN
                        sbContratos := rc.contrato;
                    ELSE
                        sbContratos := sbContratos || ',' || rc.contrato;
                    END IF;
                END LOOP;

            ELSIF isbTelefono IS NOT NULL THEN
                pkg_traza.trace(csbMetodo||' evaluar los contratos del telefono ', csbNivelTraza2);
                -- evaluar los contratos del telefono
                FOR rc IN cuContratoTel
                LOOP
                    -- procesar los mensajes
                    FOR rcData IN cuMensajes
                    LOOP
                        EXECUTE IMMEDIATE rcData.FUENTE USING IN rc.Contrato, OUT sbRespuesta;

                        IF UPPER (sbRespuesta) <> 'N' THEN
                            sbMensajeAlerta :=   sbMensajeAlerta || REPLACE (rcData.COMENTARIO, '@1', sbRespuesta);

                            IF sbMensajeAlerta = ''  OR sbMensajeAlerta IS NULL THEN
                                sbMensajeAlerta := 'N';
                            ELSE
                                -- se guardan mensajes correcto
                                INSERT INTO LDCI_KIOSCO_REGLAS_TMP
                                     VALUES (SEQ_KIOSCO_REGLAS_TMP.NEXTVAL,
                                             rc.Contrato,
                                             rcData.tipo,
                                             sbMensajeAlerta,
                                             rcData.orden,
                                             rcData.accion);
                                pkg_traza.trace(csbMetodo||' INSERT INTO LDCI_KIOSCO_REGLAS_TMP 3', csbNivelTraza2);
                                sbMensajeAlerta := '';
                            END IF;
                        END IF;

                        nuCont := nuCont + 1;
                    END LOOP;

                    IF (sbContratos IS NULL) THEN
                        sbContratos := rc.contrato;
                    ELSE
                        sbContratos := sbContratos || ',' || rc.contrato;
                    END IF;
                END LOOP;
            END IF;

            COMMIT;

            osbContratos := sbContratos;

            pkg_traza.trace(csbMetodo||' sbContratos: '||sbContratos, csbNivelTraza2);
            pkg_traza.trace(csbMetodo, csbNivelTraza2, pkg_traza.csbFIN);

        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN
                 RAISE pkg_error.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                 pkg_error.setError;
                 RAISE pkg_error.Controlled_Error;
        END GetMensaje;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( onuErrorCode, osbErrorMessage);
        pkg_traza.trace(csbMetodo||' inuSusccodi: '||inuSusccodi, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' isbIdentificacion: '||isbIdentificacion, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' isbTelefono: '||isbTelefono, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' nuServicio: '||nuServicio, csbNivelTraza);

        --consultando los datos basicos (headers) de la factura
        IF inuSusccodi <> -1
        THEN
            pkg_traza.trace(csbMetodo||' inuSusccodi <> -1 ', csbNivelTraza);
            OPEN CUSUSCRIPCIONES FOR
                SELECT Addr.Geograp_Location_Id AS nuLocalidad,
                       (SELECT Description
                          FROM Ge_Geogra_Location
                         WHERE Geograp_Location_Id = (SELECT Geo_Loca_Father_Id
                                                        FROM Ge_Geogra_Location
                                                       WHERE Geograp_Location_Id = Addr.Geograp_Location_Id)
                        ) AS sbDepartamento,
                       (SELECT Description
                          FROM Ge_Geogra_Location
                         WHERE Geograp_Location_Id = Addr.Geograp_Location_Id
                        ) AS sbNombreLocalidad,
                        (SELECT Description
                           FROM Ge_Geogra_Location
                          WHERE Geograp_Location_Id = Addr.NEIGHBORTHOOD_ID
                        ) AS SbBarrio,
                       Sus.Susccodi AS nuSuscripc,
                       LDCI_PKFACTKIOSCO_GDC.FNUCONSULTAVALORANTFACT (Sus.Susccodi) AS nuSaldAnterior,
                       LDCI_PKFACTKIOSCO_GDC.Fnuconsultasadoact ( Sus.Susccodi)     AS nuSaldActual,
                       Gesus.Subscriber_Name  AS sbNombreSuscripc,
                       Gesus.Subs_Last_Name   AS sbApellidoSuscripc,
                       Gesus.Identification   AS sbIdentificacion,
                       (SELECT address
                          FROM ab_address
                         WHERE address_id = Sus.Susciddi
                        ) AS sbDireccion,
                       'GAS ' || Cate.Catedesc AS sbCategoria,
                       Serv.Sesunuse AS nuServicio,
                       gesus.PHONE   AS sbTelefono
                  FROM Suscripc       Sus,
                       Ab_Address     Addr,
                       Categori       Cate,
                       Servsusc       Serv,
                       GE_SUBSCRIBER  gesus
                 WHERE Sus.Susccodi = inuSusccodi
                   AND Addr.Address_Id = Sus.Susciddi
                   AND Cate.Catecodi = Serv.Sesucate
                   AND Serv.Sesususc = Sus.Susccodi
                   AND Gesus.Subscriber_Id = Sus.SUSCCLIE
                   AND Serv.Sesuserv = nuServicio;

        ELSIF isbIdentificacion IS NOT NULL
        THEN
            pkg_traza.trace(csbMetodo||' isbIdentificacion IS NOT NULL ', csbNivelTraza);
            OPEN CUSUSCRIPCIONES FOR
                SELECT Addr.Geograp_Location_Id AS nuLocalidad,
                       (SELECT Description
                          FROM Ge_Geogra_Location
                         WHERE Geograp_Location_Id = (SELECT Geo_Loca_Father_Id
                                                        FROM Ge_Geogra_Location
                                                       WHERE Geograp_Location_Id =  Addr.Geograp_Location_Id)
                        ) AS sbDepartamento,
                       (SELECT Description
                          FROM Ge_Geogra_Location
                         WHERE Geograp_Location_Id = Addr.Geograp_Location_Id)  AS sbNombreLocalidad,
                        (SELECT Description
                           FROM Ge_Geogra_Location
                          WHERE Geograp_Location_Id = Addr.NEIGHBORTHOOD_ID) AS SbBarrio,
                       Sus.Susccodi AS nuSuscripc,
                       LDCI_PKFACTKIOSCO_GDC.FNUCONSULTAVALORANTFACT (Sus.Susccodi) AS nuSaldAnterior,
                       LDCI_PKFACTKIOSCO_GDC.Fnuconsultasadoact (Sus.Susccodi)      AS nuSaldActual,
                       Gesus.Subscriber_Name  AS sbNombreSuscripc,
                       Gesus.Subs_Last_Name   AS sbApellidoSuscripc,
                       Gesus.Identification   AS sbIdentificacion,
                       (SELECT address
                          FROM ab_address
                         WHERE address_id = Sus.Susciddi) AS sbDireccion,
                       'GAS ' || Cate.Catedesc AS sbCategoria,
                       Serv.Sesunuse AS nuServicio,
                       gesus.PHONE   AS sbTelefono
                  FROM Suscripc       Sus,
                       Ab_Address     Addr,
                       Categori       Cate,
                       Servsusc       Serv,
                       Ge_Subscriber  Gesus
                 WHERE Sus.SUSCCLIE IN (SELECT SUBSCRIBER_ID
                                          FROM GE_SUBSCRIBER
                                         WHERE IDENTIFICATION = isbIdentificacion)
                   AND Addr.Address_Id = Sus.Susciddi
                   AND Cate.Catecodi = Serv.Sesucate
                   AND Serv.Sesususc = Sus.Susccodi
                   AND Gesus.Subscriber_Id = Sus.SUSCCLIE
                   AND Serv.Sesuserv = nuServicio;

        ELSIF isbTelefono IS NOT NULL
        THEN
            pkg_traza.trace(csbMetodo||' isbTelefono IS NOT NULL ', csbNivelTraza);
            OPEN CUSUSCRIPCIONES FOR
                SELECT Addr.Geograp_Location_Id AS nuLocalidad,
                       (SELECT Description
                          FROM Ge_Geogra_Location
                         WHERE Geograp_Location_Id = (SELECT Geo_Loca_Father_Id
                                                        FROM Ge_Geogra_Location
                                                       WHERE Geograp_Location_Id =Addr.Geograp_Location_Id)
                        ) AS sbDepartamento,
                       (SELECT Description
                          FROM Ge_Geogra_Location
                         WHERE Geograp_Location_Id = Addr.Geograp_Location_Id) AS sbNombreLocalidad,
                        (SELECT Description
                           FROM Ge_Geogra_Location
                          WHERE Geograp_Location_Id = Addr.NEIGHBORTHOOD_ID) AS SbBarrio,
                       Sus.Susccodi   AS nuSuscripc,
                       LDCI_PKFACTKIOSCO_GDC.FNUCONSULTAVALORANTFACT (Sus.Susccodi) AS nuSaldAnterior,
                       LDCI_PKFACTKIOSCO_GDC.Fnuconsultasadoact (Sus.Susccodi) AS nuSaldActual,
                       Gesus.Subscriber_Name  AS sbNombreSuscripc,
                       Gesus.Subs_Last_Name   AS sbApellidoSuscripc,
                       Gesus.Identification   AS sbIdentificacion,
                       (SELECT address
                          FROM ab_address
                         WHERE address_id = Sus.Susciddi) AS sbDireccion,
                       'GAS ' || Cate.Catedesc AS sbCategoria,
                       Serv.Sesunuse  AS nuServicio,
                       gesus.PHONE    AS sbTelefono
                  FROM Suscripc       Sus,
                       Ab_Address     Addr,
                       Categori       Cate,
                       Servsusc       Serv,
                       Ge_Subscriber  Gesus
                 WHERE Sus.SUSCCLIE IN (SELECT SUBSCRIBER_ID
                                          FROM GE_SUBSCRIBER
                                         WHERE PHONE = isbTelefono)
                   AND Addr.Address_Id = Sus.Susciddi
                   AND Cate.Catecodi = Serv.Sesucate
                   AND Serv.Sesususc = Sus.Susccodi
                   AND Gesus.Subscriber_Id = Sus.SUSCCLIE
                   AND Serv.Sesuserv = nuServicio;
        END IF;

        IF NOT CUSUSCRIPCIONES%ISOPEN THEN
           OPEN CUSUSCRIPCIONES FOR SELECT *
                                      FROM DUAL
                                     WHERE 1 = 2;
        END IF;

        ---- cambio 200-904
        -- se procesan los mensajes
        GetMensaje (inuSusccodi,
                    isbIdentificacion,
                    isbTelefono,
                    sbContrato);
        pkg_traza.trace(csbMetodo||'GetMensaje--> sbContrato: '||sbContrato, csbNivelTraza);

        -- se abre el cursor para que cargue todos los mensajes
        OPEN ocuMensaje FOR
              SELECT t.comentario     AS sbmensaje,
                     t.tipo           AS sbtipo,
                     t.accion         AS sbaccion,
                     t.orden          AS sborden
                FROM ldci_kiosco_reglas_tmp t
               WHERE contrato IN (SELECT TO_NUMBER (COLUMN_VALUE)
                                    FROM (SELECT regexp_substr (sbContrato,  '[^,]+', 1,   LEVEL)AS COLUMN_VALUE
                                            FROM dual
                                      CONNECT BY regexp_substr(sbContrato, '[^,]+', 1, LEVEL) IS NOT NULL ))
            ORDER BY orden ASC;

        IF NOT ocuMensaje%ISOPEN THEN
           OPEN ocuMensaje FOR SELECT *
                                 FROM DUAL
                                WHERE 1 = 2;
        END IF;

        DELETE FROM ldci_kiosco_reglas_tmp t
         WHERE contrato IN (SELECT TO_NUMBER (COLUMN_VALUE)
                              FROM (SELECT regexp_substr (sbContrato,  '[^,]+', 1,   LEVEL)AS COLUMN_VALUE
                                      FROM dual
                                CONNECT BY regexp_substr(sbContrato, '[^,]+', 1, LEVEL) IS NOT NULL ));
        pkg_traza.trace(csbMetodo||' DELETE ldci_kiosco_reglas_tmp contrato in '||sbContrato, csbNivelTraza);
        COMMIT;

        onuErrorCode := 0;
        osbErrorMessage := 'Consulta exitosa ';

        COMMIT;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             ROLLBACK;
             pkg_error.geterror (onuErrorCode, osbErrorMessage);
             pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
             ROLLBACK;
             osbErrorMessage := 'Error consultando las facturas: '|| DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
             pkg_error.seterror;
             pkg_error.geterror (onuErrorCode, osbErrorMessage);
             pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
    END PROCONSULTASUSCRIPC;

    PROCEDURE OUT (sbMens IN VARCHAR2)
    IS
        --variables para el manejo de trazas y error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'OUT';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_traza.trace(csbMetodo|| ' sbMens: '||sbMens, csbNivelTraza, pkg_traza.csbInicio);
        DBMS_OUTPUT.put_line (sbMens);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    END;

    FUNCTION fsbCaraCodiBarr128GRQ (isbCadeOrig IN VARCHAR2)
        RETURN VARCHAR2
    IS
        /*******************************************************************************
         Nombre: fsbCaraCodiBarr128.fnc
         Autor: Augusto Cesar Donado Cepeda
         Fecha: 22/Dic/2005
         Descripcion: Convierte una cadena en un formato compatible con los codigos de
                      barra de Elfring Fonts Inc, la cual se usara para imprimir en las
                      facturas. Esta conversion es solo para el subconjunto C y tiene
                      las siguientes caracteristicas:
                      -Agrega el caracter inicial (se asume que se va a usar EAN).
                      -Elimina cualquier caracter no numerico.
                      -Agrega un cero al inicio si no hay un numero par de caracteres en
                       la cadena origen.
                      -Busca y convierte los datos en parejas de datos.
                      -Agrega caracteres de chequeo y parada.

         Parametros de Entrada:
           isbCadeOrig: Cadena original a ser transformada.

         Parametros de Salida:
           No tiene.

         Devuelve:
           Cadena de caracteres compatible con el codigo de barras de Elfring Fonts Inc.

         Historia de Modificaciones

         Autor        Fecha       Descripcion.
         ADRIANAVG    12/12/2023  OSF-1819: Se implementa pkg_error.prInicializaError
                                  Se declaran variables para el manejo de traza y al interior del pr GetMensaje.
                                  Ajustar bloque de exceptions según las pautas técnicas
        *******************************************************************************/

        /* DEFINICION DE CURSORES */

        /* DEFINICION DE VARIABLES */
        vsbCadOri      VARCHAR2 (500);
        vsbCadRes      VARCHAR2 (500);
        vsbCadResTem   VARCHAR2 (500);
        vsbCadTem      VARCHAR2 (500);
        vsbCadTem2     VARCHAR2 (500);
        vsbCadIni      VARCHAR2 (5);
        vsbCarChe      VARCHAR2 (5);
        vnuValPar      NUMBER;
        vnuValChe      NUMBER;
        vnuLong        NUMBER;
        i              NUMBER;
        vnuSuma        NUMBER;
        vnuPeso        NUMBER;
        vnuCtrlPar     NUMBER;

        --variables para el manejo de trazas y error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbCaraCodiBarr128GRQ';
        nuError      NUMBER;
        sbError      VARCHAR2(2000);

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);
        pkg_traza.trace(csbMetodo||' isbCadeOrig: '||isbCadeOrig, csbNivelTraza);

        FOR i IN 1 .. 254
        LOOP
            OUT (TO_CHAR (i) || '-' || CHR (i));
        END LOOP;

        --Inicializa las cadenas de entrada y salida
        vsbCadOri := LTRIM (RTRIM (REPLACE (isbCadeOrig, 's', CHR (178))));
        pkg_traza.trace(csbMetodo||' vsbCadOri: '||vsbCadOri, csbNivelTraza);

        vsbCadRes := NULL;
        pkg_traza.trace(csbMetodo||' vsbCadRes: '||vsbCadRes, csbNivelTraza);

        --Elimina los caracteres no numericos
        vnuLong := LENGTH (vsbCadOri);
        vsbCadTem := NULL;
        vsbCadTem2 := NULL;
        vnuCtrlPar := 0;

        FOR i IN 1 .. vnuLong
        LOOP
            IF INSTR ('1234567890' || CHR (178), SUBSTR (vsbCadOri, i, 1)) <> 0 THEN
                vsbCadTem2 := vsbCadTem2 || SUBSTR (vsbCadOri, i, 1);

                IF SUBSTR (vsbCadOri, i, 1) = CHR (178) THEN
                    IF MOD (vnuCtrlPar, 2) = 1  THEN
                        vsbCadTem2 := '0' || vsbCadTem2;
                    END IF;

                    vsbCadTem := vsbCadTem || vsbCadTem2;
                    vnuCtrlPar := 0;
                    vsbCadTem2 := NULL;
                ELSE
                    vnuCtrlPar := vnuCtrlPar + 1;
                END IF;
            END IF;
        END LOOP;


        IF vsbCadTem2 IS NOT NULL THEN
            IF MOD (vnuCtrlPar, 2) = 1 THEN
                vsbCadTem2 := '0' || vsbCadTem2;
            END IF;

            vsbCadTem := vsbCadTem || vsbCadTem2;
        END IF;

        pkg_traza.trace(csbMetodo||' vsbCadTem2: '||vsbCadTem2, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' vsbCadTem: '||vsbCadTem, csbNivelTraza);

        vnuLong := NVL (LENGTH (vsbCadTem), 0);

        IF vnuLong > 0 THEN
            --Se define el caracter de inicio para UCC/EAN
            vnuSuma := 207;
            vsbCadIni := CHR (125) || CHR (206);
            vnuPeso := 2;

            --Calcula el chequeo con modulo 103 y construye la cadena de salida
            i := 1;

            WHILE i <= vnuLong
            LOOP
                --Verifica el caracter especial
                IF SUBSTR (vsbCadTem, i, 1) = CHR (178) THEN
                    vsbCadRes := vsbCadRes || CHR (178);
                    i := i + 1;
                    vnuSuma := vnuSuma + (102 * vnuPeso);
                    vnuPeso := vnuPeso + 1;
                ELSE
                    --Toma el valor de la cadena de digitos por parejas
                    vnuValPar := TO_NUMBER (SUBSTR (vsbCadTem, i, 2));

                    --Multiplica el valor de la pareja por el peso y lo acumula
                    vnuSuma := vnuSuma + (vnuValPar * vnuPeso);
                    vnuPeso := vnuPeso + 1;

                    --Crea un caracter ASCII desde el valor de la pareja y lo almacena en la
                    --cadena de salida
                    IF vnuValPar < 90 THEN
                        vsbCadRes := vsbCadRes || CHR (vnuValPar + 33);
                    ELSE
                        vsbCadRes := vsbCadRes || CHR (vnuValPar + 104);
                    END IF;

                    i := i + 2;
                END IF;
            END LOOP;

            pkg_traza.trace(csbMetodo||' vnuSuma: '||vnuSuma, csbNivelTraza);

            --Busca el residuo de la suma dividida por 103
            vnuValChe := MOD (vnuSuma, 103);
            pkg_traza.trace(csbMetodo||' vnuValChe: '||vnuValChe, csbNivelTraza);

            --Crea un caracter ASCII desde el valor de chequeo
            IF vnuValChe < 90
            THEN
                vsbCarChe := CHR (vnuValChe + 33);
            ELSE
                vsbCarChe := CHR (vnuValChe + 104);
            END IF;
            pkg_traza.trace(csbMetodo||' vsbCarChe: '||vsbCarChe, csbNivelTraza);

            --Construye la cadena de salida con un espacio en blanco al final para el bug
            --Windows rasterization
            vsbCadResTem := vsbCadIni || vsbCadRes || vsbCarChe || CHR (126) || ' ';
            pkg_traza.trace(csbMetodo||' vsbCadResTem: '||vsbCadResTem, csbNivelTraza);

            --Reemplaza las comillas dobles por un caracter especial
            vsbCadRes := REPLACE (vsbCadResTem, CHR (34), CHR (226));
            pkg_traza.trace(csbMetodo||' vsbCadRes: '||vsbCadRes, csbNivelTraza);

        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        --Retorna el resultado
        RETURN (vsbCadRes);
    EXCEPTION
        WHEN OTHERS THEN
             pkg_Error.setError;
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
             RETURN NULL;
    END;

    /************************************************************************
      PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

            PROCEDURE : PROGENERAFACT
              AUTOR   : Hector Fabio Dominguez
              FECHA   : 16/05/2013
              RICEF   : I045
          DESCRIPCION : Proceso encargado de consultar la informacion que se
                        que se va a colocar en el pdf de la factura

      Historia de Modificaciones

      Autor        Fecha       Descripcion.
      HECTORFDV    16/05/2013  Creacion del paquete
      HECTORFDV   24/01/2013   Se modifica el proceso de obtenciión de cargos
                               para que incluya los intereses de financiación
                               cuando solo se liquiden solo intereses.
      HECTORFDV    10/02/2014  Ajuste en fechas limites de pago y calculo de saldo anterior
      HECTORFDV    14/02/2014  Ajuste consumos e historicos 2794
      HECTORFDV    30/02/2014  formateo del total a pagar, dias de consumo
      HECTORFDV    20/10/2014  Ajuste para el cobro de duplicado solo desde el Kiosco
      SOCORO       24/02/2016  CA 100-9811 Se debe validar el retorno null de la función
                               cc_boBssSubscriptionData.fnufavorbalance usada en el cursor CUDATOSBASIC para obtener el valor del reclamo
     ADRIANAVG     12/12/2023  OSF-1819: Se implementa pkg_error.prInicializaError y se retira la declaracion onuErrorCode := 0 y ONUDEFERREDBALANCE
                               Se declaran variables para el manejo de traza y de error.
                               Ajustar bloque de exceptions según las pautas técnicas
    Jorge Valiente 12/07/2024  OSF-2930:Nuevo servicio para registrar cupon duplicado.
    ************************************************************************/

    PROCEDURE PROGENERAFACT (inuSusccodi        IN  suscripc.susccodi%TYPE,
                             inuSaldoGen        IN  NUMBER,
                             isbTipoSaldo       IN  VARCHAR2,
                             CUDATOSBASIC       OUT SYS_REFCURSOR,
                             CUFACTDETA         OUT SYS_REFCURSOR,
                             CURANGOS           OUT SYS_REFCURSOR,
                             CUHISTORICO        OUT SYS_REFCURSOR,
                             CULECTURAS         OUT SYS_REFCURSOR,
                             CUCONSUMOS         OUT SYS_REFCURSOR,
                             CUCOMPONENTES      OUT SYS_REFCURSOR,
                             osbSeguroLiberty   OUT VARCHAR2,
                             osbOrdenSusp       OUT VARCHAR2,
                             osbProcFact        OUT VARCHAR2,
                             onuErrorCode       OUT NUMBER,
                             osbErrorMessage    OUT VARCHAR2,
                             isbSistema         IN  VARCHAR2 DEFAULT 'N')
    AS
        nuFactura            NUMBER;
        ISBXMLREFERENCE      CLOB; -- para envio de parametros en la generacion de cupon
        INUREFTYPE           NUMBER;
        ONUCUPONUME          NUMBER;
        ONUTOTALVALUE        NUMBER;
        nuInteresMora        ta_vigetaco.vitcporc%TYPE;

        --Variables de control para el cobro de duplicados
        nuCobroDupli         NUMBER;
        nuValorCobro         NUMBER;
        rcCobroDupli         DALD_CUPON_CAUSAL.styLD_CUPON_CAUSAL;
        sbCusaCargo          NUMBER;

        --Declaracion de variable de control para la fecha limite de pago. Tiquete:2733, Fecha:10-02-2014.  autor:    hectorfdv
        sbInmediata          VARCHAR2 (500);

        ERROR_GENERA         EXCEPTION;
        ERROR_MORA           EXCEPTION;

        --Consulta si se debe realizar o no el cobro. 21-11-2014, TIQUETE: ROLLOUT
         CURSOR cuConsultaCobro IS
            SELECT COUNT (*)
              FROM LDCI_CARASEWE
             WHERE CASEVALO = isbSistema AND CASEDESE = 'WS_KIOSCO_COBRO';

        --variables para el manejo de trazas y de error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'PROGENERAFACT';
        sbError      VARCHAR2(4000);
        nuError      NUMBER;

        CURSOR cuMaxFactCodi(p_inuSusccodi suscripc.susccodi%TYPE)
        IS
        SELECT MAX (factcodi)
          FROM factura
         WHERE factsusc = p_inuSusccodi
           AND FACTPROG = 6;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( onuErrorCode, osbErrorMessage);
        pkg_traza.trace(csbMetodo||' inuSusccodi: '||inuSusccodi, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' inuSaldoGen: '||inuSaldoGen, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' isbTipoSaldo: '||isbTipoSaldo, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' isbSistema: '||isbSistema, csbNivelTraza);

        osbSeguroLiberty := 'N';
        osbOrdenSusp := 'N';

        --Inicialziamos la variable de control para la fecha limite de pago. Tiquete: 2733. Fecha: 10-02-2014. Autor: hectorfdv
        sbInmediata := '';
        Inureftype := 2;

        --Se coloca el manejo de excepciones ya que el api no esta controlando en su interior las excepciones

        BEGIN
            ISBXMLREFERENCE :=
                   '<?xml version="1.0" encoding="utf-8" ?><Suscripcion><Id_Suscripcion>'
                || inuSusccodi
                || '</Id_Suscripcion><Valor_a_Pagar>'
                || inuSaldoGen
                || '</Valor_a_Pagar></Suscripcion >';
            pkg_traza.trace(csbMetodo||' ISBXMLREFERENCE: '||ISBXMLREFERENCE, csbNivelTraza);

            API_COUPONGENERATION (INUREFTYPE        => INUREFTYPE,
                                  ISBXMLREFERENCE   => ISBXMLREFERENCE,
                                  ONUCUPONUME       => ONUCUPONUME,
                                  ONUTOTALVALUE     => ONUTOTALVALUE,
                                  ONUERRORCODE      => ONUERRORCODE,
                                  OSBERRORMESSAGE   => OSBERRORMESSAGE);

            pkg_traza.trace(csbMetodo||' API_COUPONGENERATION--> ONUCUPONUME: '||ONUCUPONUME, csbNivelTraza);
            pkg_traza.trace(csbMetodo||' API_COUPONGENERATION--> ONUTOTALVALUE: '||ONUTOTALVALUE, csbNivelTraza);
            pkg_traza.trace(csbMetodo||' API_COUPONGENERATION--> ONUERRORCODE: '||ONUERRORCODE, csbNivelTraza);
            pkg_traza.trace(csbMetodo||' API_COUPONGENERATION--> OSBERRORMESSAGE: '||OSBERRORMESSAGE, csbNivelTraza);
        EXCEPTION
            WHEN OTHERS THEN
                 RAISE ERROR_GENERA;
        END;

        IF onuErrorCode <> 0 THEN
           RAISE ERROR_GENERA;
        END IF;

        BEGIN
            --Validamos si el parametro de cobro de duplicado se encuentra configurado
            nuValorCobro := DALD_PARAMETER.fnuGetNumeric_Value ('COBRO_POR_DUPLICADO');
        EXCEPTION
            WHEN OTHERS THEN
                 pkg_Error.getError(nuError, sbError);
                 pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
                 pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                 NULL;
        END;
        pkg_traza.trace(csbMetodo||' nuValorCobro: '||nuValorCobro, csbNivelTraza);

        IF nuValorCobro > 0 THEN
            --Evaluamos Si el sistema de negocio tiene asignado cobro
            OPEN cuConsultaCobro;
            FETCH cuConsultaCobro INTO nuCobroDupli;
            CLOSE cuConsultaCobro;
            pkg_traza.trace(csbMetodo||' nuCobroDupli: '||nuCobroDupli, csbNivelTraza);

            IF nuCobroDupli > 0 THEN
                LDCI_pkWebServUtils.proCaraServWeb ('WS_KIOSCO_CAUSA',
                                                    'CAUSALES_COBRO_DUPLICADO',
                                                     sbCusaCargo,
                                                     osbErrorMessage);
                pkg_traza.trace(csbMetodo||' LDCI_pkWebServUtils.proCaraServWeb--> sbCusaCargo: '||sbCusaCargo, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' LDCI_pkWebServUtils.proCaraServWeb--> osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

                rcCobroDupli.CUPONUME := onucuponume;
                rcCobroDupli.CAUSAL_ID := TO_NUMBER (NVL (sbCusaCargo, 0));
                rcCobroDupli.PACKAGE_ID := 0;
                DALD_CUPON_CAUSAL.insrecord (rcCobroDupli);
                --Inicio OSF-2930
                pkg_duplicado_factura.prcRegsitraDuplicado(onucuponume,
                                                           inuSusccodi,
                                                           0);
                --Fin OSF-2930                 
            END IF;
        END IF;

        --Select que se encarga de retornar la factura
        OPEN cuMaxFactCodi(inuSusccodi);
        FETCH cuMaxFactCodi INTO nuFactura;
        CLOSE cuMaxFactCodi;

        --Consulta la tasa de interes por mora
        nuInteresMora := fnuObtenerInteresMora (onucuponume,  nuFactura, onuErrorCode, osbErrorMessage);
        pkg_traza.trace(csbMetodo||' nuInteresMora: '||nuInteresMora, csbNivelTraza);

        IF onuErrorCode <> 0
        THEN
            osbErrorMessage :=' La tasa de interes de mora no se logro consultar';
            onuErrorCode := 0;
            pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);
        -- Se coloca en comentario por la misma razon de que es un campo informativo
        END IF;

        --valida si debemos colocar inmediato en la fecha limite de pago. Tiquete:  2733, 10-02-2014. Autor: hectorfdv
        --Se calcula la suma de las cuentas vencidas, si es superior a cero Entonces es pago inmediato-
        --Tiquete:  2756. 10-02-2014. Autor:    hectorfdv

        IF LDCI_PKFACTKIOSCO_GDC.FNUCONSULTASADOANT (inuSusccodi) > 0 THEN
            sbInmediata := 'INMEDIATO';
        ELSE
            sbInmediata := '-1';
        END IF;
        pkg_traza.trace(csbMetodo||' sbInmediata: '||sbInmediata, csbNivelTraza);

        --consultando los datos basicos (headers) de la factura
        OPEN CUDATOSBASIC FOR
            SELECT fc.factcodi  account_number,                                            --2
                   a.subscriber_name || ' ' || a.subs_last_name    client_name,            --3
                   ca.address_parsed                               client_address,         --4
                   s.sesusuca                                      subcategory,            --5
                   s.sesucate                                      codcategory,            --6
                   pktblcategori.fsbgetdescription (s.sesucate)    category,               --6
                   b.susccicl                                      billing_cycle,          --7
                   TO_CHAR (TO_DATE (pf.pefames, 'mm'), 'MONTH', 'NLS_DATE_LANGUAGE = SPANISH') billing_month,     --8
                   b.susccodi                                                                   suscripcion,       --9
                   'R: '|| ab.route_id|| '   C: ' || (SELECT consecutive
                                                       FROM ab_premise
                                                      WHERE ca.estate_number = premise_id)      route,             --10
                   TO_CHAR (pc.pecsfeci, 'dd mm yyyy')                                          date_initial_per,  --11
                   TO_CHAR (pc.pecsfecf, 'dd mm yyyy')                                          date_end_per,      --12
                   CASE
                       WHEN (LDC_BOFORMATOFACTURA.fsbPagoInmediato ( s.sesunuse) = 1) THEN  'INMEDIATO'
                       WHEN (sbInmediata = 'INMEDIATO') THEN 'INMEDIATO'
                       ELSE TO_CHAR (cc.cucofeve, 'dd/MON/yyyy', 'NLS_DATE_LANGUAGE = SPANISH')
                   END                                                                           date_limited_per, --13
                   TO_CHAR ( (SELECT ROUND (cupovalo)
                                FROM cupon
                               WHERE cuponume = ONUCUPONUME), 'FM999999999990')                    Total_pay,      --14
                   TO_CHAR (nuInteresMora  , 'FM999999990.0000')                                   interest_mora,  --15
                   REPLACE (LDC_BOFORMATOFACTURA.fsbPorcSuboContri (fc.factcodi), '%')             Percen_sc,      --16
                   LDC_BOFORMATOFACTURA.fnuGetIndiceCalidad (s.sesunuse, pf.pefafimo, pf.pefaffmo) time_desc,      --17
                   DECODE (ca.geograp_location_id, NULL, NULL,
                           dage_geogra_location.fnugetgeo_loca_father_id (ca.geograp_location_id))state,           --18
                   ca.geograp_location_id                                                         city,            --19
                   Dage_Geogra_Location.Fsbgetdisplay_Description (ca.geograp_location_id) cityDesc,
                   TO_CHAR ( (SELECT ROUND (SUM (CASE
                                           WHEN conctico = 1  THEN DECODE (CARGSIGN, 'CR', CARGVALO * -1,
                                                                                     'PA', CARGVALO * -1,
                                                                                     'AS', CARGVALO * -1,
                                                                                     'DB', CARGVALO,
                                                                                      CARGVALO * -1)
                                           ELSE  0
                                       END)
                                       )
                          FROM cuencobr, cargos, concepto
                         WHERE cargconc = conccodi
                           AND cargcuco = cucocodi
                           AND cucofact = fc.factcodi),    'FM999999990'
                           )                      t_servicios_publicos, --20
                   0                              t_bienes,             --21
                   TO_CHAR ( (SELECT ROUND (SUM (CASE
                                           WHEN conctico = 3 THEN DECODE (CARGSIGN, 'CR', CARGVALO * -1,
                                                                                    'PA', CARGVALO * -1,
                                                                                    'AS', CARGVALO * -1,
                                                                                    'DB', CARGVALO,
                                                                                     CARGVALO * -1)
                                           ELSE 0
                                       END)
                                       )
                          FROM cuencobr, cargos, concepto
                         WHERE cargconc = conccodi
                           AND cargcuco = cucocodi
                           AND cucofact = fc.factcodi),  'FM999999999990'
                           ) t_servicios,         --22
                   DECODE (ca.neighborthood_id, NULL, NULL, dage_geogra_location.fsbgetdescription (ca.neighborthood_id)) neighborthood,  --23
                   TO_CHAR (ROUND (LDCI_PKFACTKIOSCO_GDC.FNUCONSULTAVALORANTFACT ( fc.factsusc)),'FM999999999990') Saldo_Anterior, --24
                   (SELECT em.emsscoem
                      FROM elmesesu em, servsusc se
                     WHERE em.emsssesu = se.sesunuse
                       AND se.sesususc = b.susccodi
                       AND sesuserv = 7014
                       AND emssfein = (SELECT MAX (emssfein)
                                         FROM elmesesu em, servsusc se
                                        WHERE em.emsssesu = se.sesunuse
                                          AND se.sesususc = b.susccodi
                                          AND sesuserv = 7014)
                                          AND ROWNUM <= 1)  meter,    --25
                   (CASE
                        WHEN (a.ident_type_id = 110 OR a.ident_type_id = 1) THEN identification
                    END) Client_Nit,     --26
                   b.suscclie    suscriptor,
                   (ROUND (pc.pecsfecf) - TRUNC (pc.pecsfeci))   days_cons,
                   TO_CHAR (cc_boBssSubscriptionData.fnuClaimbalance (b.susccodi), 'FM999,999,990')   favor_balance,
                   TO_CHAR ( NVL ( cc_boBssSubscriptionData.fnufavorbalance ( b.susccodi),  0), 'FM999,999,990') claim_balance,
                   LDCI_PKFACTKIOSCO_GDC.fsbGetDesviacion (nuFactura)   desviacion
              FROM factura        fc,
                   cuencobr       cc,
                   suscripc       b,
                   servsusc       s,
                   ge_subscriber  a,
                   perifact       pf,
                   pericose       pc,
                   ab_address     ca,
                   ab_segments    ab
             WHERE fc.factcodi = nuFactura
               AND fc.factsusc = inuSusccodi
               AND s.sesuserv = 7014
               AND fc.factcodi = cc.cucofact
               AND fc.factsusc = b.susccodi
               AND b.susccodi = s.sesususc
               AND a.subscriber_id = b.suscclie
               AND pf.pefacodi = fc.factpefa
               AND pc.pecscons = LDC_BOFORMATOFACTURA.fnuObtPerConsumo ( pf.pefacicl,  pf.pefacodi)
               AND b.susciddi = ca.address_id
               AND pf.pefacodi = fc.factpefa
               AND ca.segment_id = ab.segments_id
               AND ROWNUM = 1;

        --Consultando cargos de la factura
        OPEN CUFACTDETA FOR
            SELECT concepto_desc,
                   TO_CHAR (Saldo_Anterior, 'FM999999990.00')  Saldo_Anterior,
                   TO_CHAR (Abono_Capital, 'FM999999990.00')   Abono_Capital,
                   TO_CHAR (Intereses, 'FM999999990.00')       Intereses,
                   NVL (TO_CHAR (Abono_Capital + Intereses + Total, 'FM999999999990.00'),0) Total,
                   TO_CHAR (Saldo_posterior_pago, 'FM999999990.00') Saldo_posterior_pago,
                   Cuotas_pendientes,
                   TO_CHAR (NVL (interes_financiacion, 0), 'FM999999990.0000') interes_financiacion,
                   tipo_concepto
              FROM (SELECT concepto_desc,
                           tipo_concepto,
                           cod_financia,
                           Saldo_Anterior,
                           Abono_Capital,
                           Intereses,
                           Iva,
                           Total,
                           Saldo_posterior_pago,
                           Cuotas_pendientes,
                           interes_financiacion
                      FROM (SELECT c.concorim orden,
                                   c.concdefa concepto_desc,
                                   c.conctico tipo_concepto,
                                   0 cod_financia,
                                   0 Saldo_Anterior,
                                   0 Abono_Capital,
                                   0 Intereses,
                                   (CASE
                                        WHEN cargconc = 137 THEN cargvalo ELSE 0
                                    END)  Iva,
                                   DECODE (cargsign, 'CR', cargvalo * -1,
                                                     'PA', cargvalo * -1,
                                                     'AS', cargvalo * -1,
                                                     'DB', cargvalo,
                                                      cargvalo * -1) Total,
                                   0 Saldo_posterior_pago,
                                   0 Cuotas_pendientes,
                                   0 interes_financiacion
                              FROM factura   f,
                                   cuencobr  cc,
                                   cargos    cg,
                                   concepto  c
                             WHERE cg.cargconc = c.conccodi
                                   AND f.factcodi = cc.cucofact
                                   AND cc.cucocodi = cg.cargcuco
                                   AND ( SUBSTR (NVL (cargdoso, ' '), 1, 3) IN ('CO-', 'CB-')
                                        OR ( cargconc IN (137, 196, 37)
                                            AND (SUBSTR (NVL (cargdoso, ' '), 1, 3) NOT IN  ('ID-', 'DF-'))
                                           )
                                        )
                                   AND c.concticl IN (1, 2)-- consumo
                                   AND factcodi = nuFactura)
                     WHERE Total <> 0
                    UNION ALL
                      SELECT concepto_desc,
                             tipo_concepto,
                             0 cod_financia,
                             SUM (Saldo_Anterior) Saldo_Anterior,
                             0 Abono_Capital,
                             SUM (Intereses) Intereses,
                             SUM (Iva) Iva,
                             SUM (Total),
                             SUM (Saldo_posterior_pago) Saldo_posterior_pago,
                             SUM (Cuotas_pendientes)    Cuotas_pendientes,
                             SUM (interes_financiacion) interes_financiacion
                        FROM (SELECT concorim orden,
                                     concdefa concepto_desc,
                                     conctico tipo_concepto,
                                     NVL((SELECT difesape
                                             FROM diferido
                                            WHERE difecodi = Nrodiferido) + cargvalo,  0)      Saldo_Anterior,
                                     cargvalo     Abono_Capital,
                                     Intereses    Intereses,
                                     (CASE
                                          WHEN cargconc = 137 THEN cargvalo
                                          ELSE 0
                                      END)        Iva,
                                     cargvalo     Total,
                                     NVL ((SELECT difesape
                                             FROM diferido
                                            WHERE difecodi = Nrodiferido), 0)      Saldo_posterior_pago,
                                     NVL ( (SELECT (difenucu - difecupa)
                                              FROM diferido
                                             WHERE difecodi = Nrodiferido), 0)      Cuotas_pendientes,
                                     NVL ( (SELECT difeinte
                                              FROM diferido
                                             WHERE difecodi = Nrodiferido), 0)      interes_financiacion
                                FROM (SELECT c.concorim,
                                             c.conccodi,
                                             c.concdefa,
                                             c.conctico,
                                             cg.cargsign,
                                             cg.cargdoso,
                                             cg.cargconc,
                                             DECODE (SUBSTR ( NVL (cg.cargdoso, ' '), 1, 3), 'DF-', SUBSTR( NVL (cg.cargdoso, ' '),  4))  Nrodiferido,
                                             DECODE (cargsign, 'CR', cargvalo * -1,
                                                               'PA', cargvalo * -1,
                                                               'AS', cargvalo * -1,
                                                               'DB', cargvalo,
                                                               cargvalo * -1)   cargvalo,
                                             (SELECT NVL (SUM (cargvalo), 0)
                                                FROM factura qf,
                                                     cuencobr qcc,
                                                     cargos  qcg,
                                                     concepto co
                                               WHERE qf.factcodi = qcc.cucofact
                                                 AND qcc.cucocodi = qcg.cargcuco
                                                 AND co.conccodi =  qcg.cargconc
                                                 AND qcg.cargdoso = 'ID-'|| DECODE (SUBSTR ( NVL (cg.cargdoso,' '),1,3), 'DF-', SUBSTR (NVL ( cg.cargdoso, ' '),4))
                                                 AND qf.factcodi = f.factcodi) Intereses,
                                             0 Por_IVA
                                        FROM factura f,
                                             cuencobr cc,
                                             cargos  cg,
                                             concepto c
                                       WHERE cg.cargconc = c.conccodi
                                         AND f.factcodi = cc.cucofact
                                         AND cc.cucocodi = cg.cargcuco
                                         AND ( c.concticl <> 4 OR cg.cargcaca NOT IN (15, 53))
                                         AND cargconc NOT IN (137, 196, 37)
                                         AND (SUBSTR (NVL (cargdoso, ' '), 1, 3) NOT IN ('CO-', 'DF-''ID-','CB-'))
                                         AND cargsign <> 'SA'
                                         AND f.factcodi = nuFactura))
                    GROUP BY concepto_desc, tipo_concepto
                      HAVING   SUM (Abono_Capital)
                             + SUM (Intereses)
                             + SUM (Total) <> 0
                    UNION ALL
                      SELECT concepto_desc,
                             tipo_concepto,
                             cod_financia,
                             SUM (Saldo_Anterior) Saldo_Anterior,
                             SUM (Abono_Capital) Abono_Capital,
                             SUM (Intereses)     Intereses,
                             SUM (Iva)           Iva,
                             SUM (Total)         Total,
                             SUM (Saldo_posterior_pago) Saldo_posterior_pago,
                             MAX (Cuotas_pendientes)    Cuotas_pendientes,
                             MAX (interes_financiacion) interes_financiacion
                        FROM (SELECT concorim   orden,
                                     concdefa   concepto_desc,
                                     conctico   tipo_concepto,
                                     (SELECT difecofi
                                        FROM diferido
                                       WHERE difecodi = Nrodiferido) cod_financia,
                                     DECODE (sesuserv, 7053, 0, NVL ((SELECT difesape
                                                                        FROM diferido
                                                                       WHERE difecodi = Nrodiferido) + cargvalo, 0)) Saldo_Anterior,
                                     DECODE (sesuserv, 7053, 0, cargvalo) Abono_Capital,
                                     DECODE (sesuserv, 7053, 0, NVL (Intereses, 0)) Intereses,
                                     (CASE
                                          WHEN cargconc = 173 THEN cargvalo
                                          ELSE 0
                                      END) Iva,
                                     DECODE (sesuserv, 7053, cargvalo, 0) Total,
                                     DECODE (sesuserv, 7053, 0, (NVL (
                                              (SELECT difesape
                                                 FROM diferido
                                                WHERE difecodi = Nrodiferido), 0))) Saldo_posterior_pago,
                                     DECODE ( sesuserv, 7053, 0, (NVL (
                                              (SELECT (difenucu - difecupa)
                                                 FROM diferido
                                                WHERE difecodi = Nrodiferido), 0))) Cuotas_pendientes,
                                     DECODE (sesuserv, 7053, 0, (
                                            (POWER ( 1  +   NVL ((SELECT difeinte
                                                                   FROM diferido
                                                                  WHERE difecodi = Nrodiferido), 0) / 100, (1 / 12))
                                             - 1) * 100)) interes_financiacion
                                FROM (SELECT cargcuco,
                                             c.concorim,
                                             c.conccodi,
                                             c.concdefa,
                                             c.conctico,
                                             cg.cargsign,
                                             cg.cargdoso,
                                             cg.cargconc,
                                             DECODE ( SUBSTR ( NVL (cg.cargdoso, ' '), 1, 3), 'DF-', SUBSTR ( NVL (cg.cargdoso, ' '), 4))  Nrodiferido,
                                             DECODE ( SUBSTR (NVL (cargdoso, ' '), 1, 3), 'DF-', cargvalo, 0) cargvalo,
                                              (SELECT cargvalo
                                                 FROM cargos abz
                                                WHERE cg.cargcuco = abz.cargcuco
                                                  AND SUBSTR (NVL (abz.cargdoso, ' '), 4,  LENGTH (abz.cargdoso)) =  SUBSTR (NVL (cg.cargdoso, ' '), 4, LENGTH (cg.cargdoso))
                                                  AND SUBSTR ( NVL (cargdoso,  ' '),1, 3) IN('ID-')) Intereses,
                                             0 Por_IVA,
                                             sesuserv
                                        FROM factura f,
                                             cuencobr cc,
                                             cargos  cg,
                                             concepto c,
                                             servsusc s
                                       WHERE cg.cargconc = c.conccodi
                                         AND f.factcodi = cc.cucofact
                                         AND cc.cucocodi = cg.cargcuco
                                         AND (SUBSTR (NVL (cargdoso, ' '), 1, 3) IN ('DF-'))
                                         AND cargsign <> 'SA'
                                         AND s.sesunuse = cargnuse
                                         AND f.factcodi = nuFactura))
                    GROUP BY concepto_desc, tipo_concepto, cod_financia
                      HAVING   SUM (Abono_Capital)
                             + SUM (Intereses)
                             + SUM (Total) <> 0
                    UNION ALL
                      SELECT concepto_desc,
                             tipo_concepto,
                             cod_financia,
                             SUM (Saldo_Anterior) Saldo_Anterior,
                             SUM (Abono_Capital) Abono_Capital,
                             SUM (Intereses) Intereses,
                             SUM (Iva) Iva,
                             SUM (Total) Total,
                             SUM (Saldo_posterior_pago) Saldo_posterior_pago,
                             MAX (Cuotas_pendientes) Cuotas_pendientes,
                             MAX (interes_financiacion) interes_financiacion
                        FROM (SELECT concorim orden,
                                     concdefa concepto_desc,
                                     conctico tipo_concepto,
                                     (SELECT difecofi
                                        FROM diferido
                                       WHERE difecodi = Nrodiferido) cod_financia,
                                         NVL ((SELECT difesape
                                               FROM diferido
                                              WHERE difecodi = Nrodiferido)
                                          + cargvalo,  0)   Saldo_Anterior,
                                     cargvalo  Abono_Capital,
                                     NVL (Intereses, 0) Intereses,
                                     (CASE
                                          WHEN cargconc = 173 THEN cargvalo
                                          ELSE 0
                                      END)
                                         Iva,
                                     0   Total,
                                     (NVL ( (SELECT difesape
                                               FROM diferido
                                              WHERE difecodi = Nrodiferido), 0)) Saldo_posterior_pago,
                                     (NVL ( (SELECT (difenucu - difecupa)
                                               FROM diferido
                                              WHERE difecodi = Nrodiferido), 0)) Cuotas_pendientes,
                                     (  (  POWER (1 +   NVL ((SELECT difeinte
                                                                FROM diferido
                                                               WHERE difecodi =  Nrodiferido), 0) / 100, (1 / 12))
                                         - 1)
                                      * 100) interes_financiacion,
                                       nrodiferido
                                FROM (SELECT cargcuco,
                                             c.concorim,
                                             c.conccodi,
                                             c.concdefa,
                                             c.conctico,
                                             cg.cargsign,
                                             cg.cargdoso,
                                             cg.cargconc,
                                             DECODE (SUBSTR (NVL (cg.cargdoso, ' '),1,3),'ID-', SUBSTR ( NVL (cg.cargdoso,' '), 4))    Nrodiferido,
                                             DECODE (SUBSTR (NVL (cargdoso, ' '), 1,3),'ID-', cargvalo, 0)  cargvalo,
                                             0 Intereses,
                                             0 Por_IVA
                                        FROM factura f,
                                             cuencobr cc,
                                             cargos  cg,
                                             concepto c
                                       WHERE cg.cargconc = c.conccodi
                                         AND f.factcodi = cc.cucofact
                                         AND cc.cucocodi = cg.cargcuco
                                         AND (SUBSTR (NVL (cargdoso, ' '), 1, 3) IN ('ID-'))
                                         AND cargsign <> 'SA'
                                         AND f.factcodi = nuFactura) a
                               WHERE NOT EXISTS
                                         (SELECT 1
                                            FROM (SELECT cargcuco,
                                                         cargconc,
                                                         DECODE ( SUBSTR (NVL ( cg.cargdoso, ' '), 1, 3), 'DF-', SUBSTR ( NVL ( cg.cargdoso, ' '), 4)) Nrodiferido
                                                    FROM factura f,
                                                         cuencobr cc,
                                                         cargos  cg,
                                                         concepto c
                                                   WHERE cg.cargconc = c.conccodi
                                                     AND f.factcodi = cc.cucofact
                                                     AND cc.cucocodi = cg.cargcuco
                                                         AND (SUBSTR (NVL (cargdoso,' '), 1,3) IN ('DF-'))
                                                         AND cargsign <> 'SA'
                                                         AND f.factcodi = nuFactura
                                                ) b
                                           WHERE a.cargcuco = b.cargcuco
                                             AND a.Nrodiferido = b.Nrodiferido)
                                        )
                    GROUP BY concepto_desc, tipo_concepto, cod_financia
                      HAVING   SUM (Abono_Capital)
                             + SUM (Intereses)
                             + SUM (Total) <> 0)
            UNION ALL
            SELECT 'SALDO ANTERIOR'                   concepto_desc,
                   '0.00'                             Saldo_Anterior,
                   '0.00'                             Abono_Capital,
                   '0.00'                             Intereses,
                   TO_CHAR ( LDCI_PKFACTKIOSCO_GDC.FNUCONSULTAVALORANTFACT ( inuSusccodi), 'FM999999990.00') Total,
                   '0.00'                             Saldo_posterior_pago,
                   0                                  Cuotas_pendientes,
                   TO_CHAR (0, 'FM999999990.0000')    interes_financiacion,
                   0                                  tipo_concepto
              FROM DUAL
             WHERE LDCI_PKFACTKIOSCO_GDC.FNUCONSULTAVALORANTFACT (inuSusccodi) <> 0
            UNION ALL
            SELECT 'IVA'  concepto_desc,
                   '0.00' Saldo_Anterior,
                   '0.00' Abono_Capital,
                   '0.00' Intereses,
                   TO_CHAR (SUM (Total), 'FM999999990.00') Total,
                   '0.00'  Saldo_posterior_pago,
                   0  Cuotas_pendientes,
                   TO_CHAR (0, 'FM999999990.0000') interes_financiacion,
                   0  tipo_concepto
              FROM (SELECT c.concorim orden,
                           c.concdefa concepto_desc,
                           c.conctico tipo_concepto,
                           0 cod_financia,
                           0 Saldo_Anterior,
                           0 Abono_Capital,
                           0 Intereses,
                           (CASE WHEN cargconc = 137 THEN cargvalo ELSE 0 END) Iva,
                           DECODE (cargsign,
                                   'CR', cargvalo * -1,
                                   'PA', cargvalo * -1,
                                   'AS', cargvalo * -1,
                                   'DB', cargvalo,
                                   cargvalo * -1) Total,
                           0 Saldo_posterior_pago,
                           0 Cuotas_pendientes,
                           0 interes_financiacion
                      FROM factura   f,
                           cuencobr  cc,
                           cargos    cg,
                           concepto  c
                     WHERE cg.cargconc = c.conccodi
                       AND f.factcodi = cc.cucofact
                       AND cc.cucocodi = cg.cargcuco
                       AND c.concticl = 4
                       AND cg.cargcaca IN (15, 53)
                       AND factcodi = nuFactura)
            HAVING SUM (Total) <> 0;

        --consulta de rangos de consumo
        OPEN CURANGOS FOR
            SELECT CASE
                       WHEN rang.ralilisr < 1000 THEN rang.raliliir || ' - ' || rang.ralilisr
                       ELSE rang.raliliir || ' - O MAS'
                   END              rango,
                   rang.ralivalo    valor
              FROM rangliqu  rang,
                   (SELECT cargconc,
                           factpefa,
                           factcodi,
                           cuconuse,
                           pefacicl,
                           pefacodi
                      FROM factura,
                           cuencobr,
                           cargos,
                           perifact
                     WHERE factcodi = nuFactura
                       AND factsusc = inuSusccodi
                       AND pefacodi = factpefa
                       AND factcodi = cucofact
                       AND cucocodi = cargcuco
                       AND cargconc = (SELECT pamenume
                                         FROM parametr
                                        WHERE pamecodi = 'CONSUMO')
                       AND ROWNUM = 1) cons
             WHERE cons.cargconc = rang.raliconc
                   AND cons.factpefa = rang.ralipefa
                   AND cons.cuconuse = rang.ralisesu
                   AND rang.ralipeco = LDC_BOFORMATOFACTURA.fnuObtPerConsumo (cons.pefacicl, cons.pefacodi)
                   AND ROWNUM < 3
            UNION ALL
            SELECT '0' rango, 0 valor FROM DUAL;

        --consulta historicos de consumo

        OPEN CUHISTORICO FOR
            SELECT LDC_BOFORMATOFACTURA.fnuObtNCuentaSaldo (sesunuse)                        n_cuentas_saldo,
                   TO_CHAR (ADD_MONTHS (SYSDATE, -5), 'MON', 'NLS_DATE_LANGUAGE = SPANISH')  mes_6,
                   LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (factpefa, factcodi, 5)           consumo_6,
                   TO_CHAR (ADD_MONTHS (SYSDATE, -4), 'MON', 'NLS_DATE_LANGUAGE = SPANISH')  mes_5,
                   LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (factpefa, factcodi, 4)           consumo_5,
                   TO_CHAR (ADD_MONTHS (SYSDATE, -3), 'MON','NLS_DATE_LANGUAGE = SPANISH')   mes_4,
                   LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (factpefa, factcodi, 3)           consumo_4,
                   TO_CHAR (ADD_MONTHS (SYSDATE, -2), 'MON', 'NLS_DATE_LANGUAGE = SPANISH')  mes_3,
                   LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (factpefa, factcodi, 2)           consumo_3,
                   TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'MON', 'NLS_DATE_LANGUAGE = SPANISH')  mes_2,
                   LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (factpefa, factcodi,  1)          consumo_2,
                   TO_CHAR (SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = SPANISH')                   mes_1,
                   LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (factpefa,  factcodi, 0)          consumo_1,
                   TO_CHAR (factfege, 'dd/MON/yyyy', 'NLS_DATE_LANGUAGE = SPANISH')          fecha_facturacion,
                   ONUCUPONUME cupon_referencia,
                   CASE
                       WHEN (LDC_BOFORMATOFACTURA.fsbPagoInmediato (sesunuse) = 1) THEN 'INMEDIATO'
                       WHEN (sbInmediata = 'INMEDIATO') THEN 'INMEDIATO'
                       ELSE TO_CHAR (pefaffpa,'dd/MON/yyyy', 'NLS_DATE_LANGUAGE = SPANISH')
                   END fecha_pag_recargo,
                      '(415)' || '7707232377896' || '(8020)'
                   || LPAD (ONUCUPONUME, 10, '0') || '(3900)'
                   || LPAD (inuSaldoGen, 10, '0') || '(96)'
                   || TO_CHAR (cucofeve, 'yyyymmdd') codigo_barras,
                   fsbCaraCodiBarr128GRQ
                    ('(415)'
                       || '7707232377896' || '(8020)'
                       || LPAD (ONUCUPONUME, 10, '0')|| '(3900)'
                       || LPAD (inuSaldoGen, 10, '0')|| '(96)'
                       || TO_CHAR (cucofeve, 'yyyymmdd')
                      )  ASCII_CODIGO_BARRAS,
                   TO_CHAR ( ROUND (
                           LDC_BOFORMATOFACTURA.fnuValorPosterior ( factcodi)), 'FM999999990')  Sal_Pos_Pago,
                   TO_CHAR ( ROUND (pktblsuscripc.fnugetsuscsafa (factsusc)), 'FM999999990')    Saldo_Favor,
                   DECODE (
                       LDC_BOFORMATOFACTURA.fnuMostrarFechaSuspension (sesususc),
                       1, TO_CHAR (pefaffpa,'dd/MON/yyyy', 'NLS_DATE_LANGUAGE = SPANISH'), NULL) fecha_susp_corte,
                   LDCI_PKFACTKIOSCO_GDC.FSBCONSULTAFECHREV (sesunuse)                           fecha_prox_revi
              FROM factura,
                   servsusc,
                   perifact,
                   cuencobr
             WHERE factsusc = inuSusccodi
               AND factcodi = nuFactura
               AND sesususc = factsusc
               AND cucofact = factcodi
               AND factpefa = pefacodi
               AND ROWNUM = 1;

        --consultas las lecturas
        OPEN CULECTURAS FOR
              SELECT ROUND (SUM (leac), 2)     lectura_actual,
                     ROUND (SUM (lean), 2)     lectura_anterior,
                     num_medidor,
                     causal_no_lec
                FROM (SELECT NVL (leemleto, 0) leac,
                             NVL (leemlean, 0) lean,
                             (SELECT emsscoem
                                FROM elmesesu
                               WHERE emsssesu = leemsesu
                                 AND ROWNUM = 1) num_medidor,
                             (SELECT obledesc
                                FROM obselect
                               WHERE oblecodi = leemobsc
                                 AND oblecanl = 'S'
                                 AND ROWNUM = 1) causal_no_lec
                        FROM factura, servsusc, lectelme
                       WHERE factcodi = nuFactura
                         AND factsusc = inuSusccodi
                         AND sesususc = factsusc
                         AND sesuserv = 7014  -- Servicio de GAS
                         AND leemsesu = sesunuse
                         AND leempefa = factpefa)
            GROUP BY num_medidor, causal_no_lec;

        --consulta los consumos
        OPEN CUCONSUMOS FOR
            --hectorfdv, TQ: 3071, 03-04-2014. Se actualiza el calculo del consumo promedio para evitar el envio de codigo de factura nula
            --cuando no se registra consumo
            SELECT ROUND (consumo_promedio, 0) consumo_promedio,
                   ROUND (consumo_actual, 0)   consumo_actual,
                   TO_CHAR (factor_correccion, 'FM999999990.0000')  factor_correccion,
                   poder_calorifico,
                   NVL ( ROUND (((consumo_actual * poder_calorifico) / 3.6), 2), 0) Equivalencia_Kwh,
                   NVL ( ROUND (((consumo_actual * consumo_promedio) / 3.6), 2), 0) Equi_Consumo_Pro
              FROM (SELECT (  (  LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (
                                     MAX (factpefa),
                                     MAX (factcodi),
                                     5)
                               + LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (
                                     MAX (factpefa),
                                     MAX (factcodi),
                                     4)
                               + LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (
                                     MAX (factpefa),
                                     MAX (factcodi),
                                     3)
                               + LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (
                                     MAX (factpefa),
                                     MAX (factcodi),
                                     2)
                               + LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (
                                     MAX (factpefa),
                                     MAX (factcodi),
                                     1)
                               + LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (
                                     MAX (factpefa),
                                     MAX (factcodi),
                                     0)) / 6
                        )  consumo_promedio,
                           NVL (ROUND (SUM (DECODE (
                                           sesucate,
                                           1, cosscoca,
                                           2, cosscoca,
                                           3, DECODE (cossfcco, NULL, 0, cosscoca),
                                           LDC_BOFORMATOFACTURA.fnuGetConsumoIndustriaNR (factcodi))), 2
                                    ), 0)  consumo_actual,
                           MAX (fccofaco)    factor_correccion,
                           MAX (fccofapc)    poder_calorifico,
                           NULL              Equivalencia_Kwh
                      FROM factura  f
                           INNER JOIN servsusc s ON (sesususc = factsusc)
                           LEFT OUTER JOIN conssesu c ON (c.cosssesu = s.sesunuse AND c.cosspefa = f.factpefa AND cossmecc = 4)
                           LEFT OUTER JOIN cm_facocoss ON (cossfcco = fccocons)
                     WHERE factcodi = nuFactura);

        --consulta los componentes de costo
        --hectorfdv, TQ: 3071, 03-04-2014. Se modifica el calculo de los componentes, para que permita la consulta de los conponentes
        -- cuando se trate de factura para industrias
        OPEN CUCOMPONENTES FOR
            SELECT LDCI_PKFACTKIOSCO_GDC.fnuConsultComponentCostoGen (TO_NUMBER (LDCI.CASEVALO), 1, 6, nuFactura, inuSusccodi) AS VALOR,
                   LDCI.CASEDESC                AS DESCRIPCION,
                   TO_NUMBER (LDCI.CASEVALO)    AS CONCEPTO,
                   C.CONCDESC                   AS CONCEPTODESC
              FROM LDCI_CARASEWE LDCI, CONCEPTO C
             WHERE LDCI.CASEDESE = 'WS_KIOSCO'
               AND TO_NUMBER (LDCI.CASEVALO) = C.CONCCODI;

        prcCierraCursores (CUDATOSBASIC,
                           CUFACTDETA,
                           CURANGOS,
                           CUHISTORICO,
                           CULECTURAS,
                           CUCONSUMOS,
                           CUCOMPONENTES);

        -- se consulta si tiene una orden de suspencion en proceso
        osbOrdenSusp := fsbOrdenSuspContrato (inuSusccodi);
        pkg_traza.trace(csbMetodo||' osbOrdenSusp: '||osbOrdenSusp, csbNivelTraza);

        --Se Consulta si el contrato se encuentra en proceso de facturacion
        osbProcFact := LDCI_PKFACTKIOSCO_GDC.fsbProcFactura (inuSusccodi);
        pkg_traza.trace(csbMetodo||' osbProcFact: '||osbProcFact, csbNivelTraza);

        --Se confirma la creacion del cupon, y demas transacciones de los apis
        COMMIT;
        onuErrorCode := 0;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN ERROR_GENERA THEN
            ROLLBACK;
            pkg_error.seterror;
            pkg_error.geterror (onuErrorCode, osbErrorMessage);
            prcCierraCursores (CUDATOSBASIC, CUFACTDETA, CURANGOS, CUHISTORICO, CULECTURAS, CUCONSUMOS,  CUCOMPONENTES);
            osbErrorMessage := 'Error Generando el cupon: ' || osbErrorMessage || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN ERROR_MORA THEN
            ROLLBACK;
            pkg_error.seterror;
            pkg_error.geterror (onuErrorCode, osbErrorMessage);
            prcCierraCursores (CUDATOSBASIC, CUFACTDETA, CURANGOS, CUHISTORICO, CULECTURAS, CUCONSUMOS,  CUCOMPONENTES);
            osbErrorMessage :=  'Error consultando el interes de mora: '  || osbErrorMessage || ' '  || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || osbErrorMessage;
            pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN pkg_error.CONTROLLED_ERROR THEN
            ROLLBACK;
            pkg_error.geterror (onuErrorCode, osbErrorMessage);
            osbErrorMessage := 'Error: ' || osbErrorMessage || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            ROLLBACK;
            pkg_error.seterror;
            pkg_error.geterror (onuErrorCode, osbErrorMessage);
            prcCierraCursores (CUDATOSBASIC, CUFACTDETA, CURANGOS, CUHISTORICO, CULECTURAS, CUCONSUMOS,  CUCOMPONENTES);
            osbErrorMessage :=  ' Error generando la informacion a imprimir en la factura: ' || osbErrorMessage || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);

    END PROGENERAFACT;

    /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

           PROCEDURE : fsbValidaContrato
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 16/05/2013
             RICEF   : I045
         DESCRIPCION : Proceso encargado de validar si un contrato
                       existe o no existe

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     HECTORFDV    16/05/2013  Creacion del paquete
     ADRIANAVG    12/12/2023  OSF-1819: Se implementa pkg_error.prInicializaError
                              Se declaran variables para el manejo de traza y de error.
                              Ajustar bloque de exceptions según las pautas técnicas
    ************************************************************************/

    FUNCTION fsbValidaContrato (nuSusccodi IN suscripc.susccodi%TYPE)
        RETURN VARCHAR2
    IS
        nuExiste      NUMBER;
        nuResExiste   VARCHAR (2);

        --variables para el manejo de trazas y de error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbValidaContrato';
        sbError      VARCHAR2(4000);
        nuError      NUMBER;

        CURSOR cuExisteSuscrip
        IS
        SELECT COUNT (1)
          FROM suscripc
         WHERE susccodi = nuSusccodi
           AND susccodi > 0; --Se excluye el  codigo -1  comodin

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);
        pkg_traza.trace(csbMetodo||' nuSusccodi: '||nuSusccodi, csbNivelTraza);

        nuResExiste := '-1';

        BEGIN
            OPEN cuExisteSuscrip;
            FETCH cuExisteSuscrip INTO nuExiste;
            CLOSE cuExisteSuscrip;
        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN
                 pkg_error.setError; --ADD OSF-1819
                 RAISE pkg_error.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                 pkg_error.setError;
                 RAISE pkg_error.CONTROLLED_ERROR;
        END;
        pkg_traza.trace(csbMetodo||' nuExiste: '||nuExiste, csbNivelTraza);

        IF (nuExiste = 1)
        THEN
            nuResExiste := '1';
        ELSE
            nuResExiste := '0';
        END IF;

        pkg_traza.trace(csbMetodo||' nuResExiste: '||nuResExiste, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN nuResExiste;

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
             RETURN nuResExiste;
             RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RETURN nuResExiste;
            RAISE pkg_error.CONTROLLED_ERROR;
    END fsbValidaContrato;

    /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

           PROCEDURE : fsbValidaIdentificacion
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 30/07/2012
             RICEF   : I045
         DESCRIPCION : Validar si la identificacion existe

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     HECTORFDV    16/05/2013  Creacion del paquete
     ADRIANAVG    12/12/2023  OSF-1819: Se implementa pkg_error.prInicializaError
                              Se declaran variables para el manejo de traza y de error.
                              Ajustar bloque de exceptions según las pautas técnicas
    ************************************************************************/

    FUNCTION fsbValidaIdentificacion ( nuIdentification   IN ge_subscriber.identification%TYPE)
        RETURN VARCHAR2
    IS
        nuExiste      NUMBER;
        nuResExiste   VARCHAR (2);

        --variables para el manejo de trazas y de error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbValidaIdentificacion';
        sbError      VARCHAR2(4000);
        nuError      NUMBER;

        CURSOR cuExisteGeSubscr
        IS
        SELECT COUNT (1)
          FROM ge_subscriber
         WHERE identification = nuIdentification;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);
        pkg_traza.trace(csbMetodo||' nuIdentification: '||nuIdentification, csbNivelTraza);

        nuResExiste := '-1';

        BEGIN
             OPEN cuExisteGeSubscr;
            FETCH cuExisteGeSubscr INTO nuExiste;
            CLOSE cuExisteGeSubscr;
        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN
                 pkg_error.setError; --ADD OSF-1819
                 RAISE pkg_error.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                 pkg_error.setError;
                 RAISE pkg_error.CONTROLLED_ERROR;
        END;
        pkg_traza.trace(csbMetodo||' nuExiste: '||nuExiste, csbNivelTraza);

        IF (nuExiste = 1)
        THEN
            nuResExiste := '1';
        ELSE
            nuResExiste := '0';
        END IF;
        pkg_traza.trace(csbMetodo||' nuResExiste: '||nuResExiste, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN nuResExiste;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
             RETURN nuResExiste;
             RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
             pkg_error.setError;
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
             RETURN nuResExiste;
             RAISE pkg_error.CONTROLLED_ERROR;
    END fsbValidaIdentificacion;

    /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

           PROCEDURE : fsbFormatoFactContrato
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 30/07/2012
             RICEF   : I045
         DESCRIPCION : Consulta el formato de una factura

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     HECTORFDV    16/05/2013  Creacion del paquete
     ADRIANAVG    12/12/2023  OSF-1819: Se implementa pkg_error.prInicializaError
                              Se declaran variables para el manejo de traza y de error.
                              Ajustar bloque de exceptions según las pautas técnicas
    ************************************************************************/
    FUNCTION fsbFormatoFactContrato (nuSusccodi IN suscripc.susccodi%TYPE)
        RETURN VARCHAR2
    IS
        nuExiste      NUMBER := 0;
        sbFormato     VARCHAR2 (100) := '';
        nuResExiste   NUMBER;

        --variables para el manejo de trazas y de error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbFormatoFactContrato';
        sbError      VARCHAR2(4000);
        nuError      NUMBER;

        CURSOR cuExisteFormato
        IS
        SELECT COUNT (1)
          FROM ed_formato edfo, ed_confexme edco, suscripc suscri
         WHERE suscri.susccodi = nuSusccodi
           AND edco.coemcodi = suscri.susccemf
           AND edfo.FORMIDEN = edco.COEMPADA;

        CURSOR cuNameFormato
        IS
        SELECT edfo.FORMDESC
          FROM ed_formato edfo, ed_confexme edco, suscripc suscri
         WHERE suscri.susccodi = nuSusccodi
           AND edco.coemcodi = suscri.susccemf
           AND edfo.FORMIDEN = edco.COEMPADA;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);
        pkg_traza.trace(csbMetodo||' nuSusccodi: '||nuSusccodi, csbNivelTraza);

        nuResExiste := -1;

        BEGIN
            OPEN cuExisteFormato;
            FETCH cuExisteFormato INTO nuExiste;
            CLOSE cuExisteFormato;
            pkg_traza.trace(csbMetodo||' nuExiste: '||nuExiste, csbNivelTraza);

            OPEN cuNameFormato;
            FETCH cuNameFormato INTO sbFormato;
            CLOSE cuNameFormato;

        EXCEPTION
            WHEN pkg_error.CONTROLLED_ERROR THEN
                 pkg_error.setError;  --ADD OSF-1819
                 RAISE pkg_error.CONTROLLED_ERROR;
            WHEN OTHERS  THEN
                 pkg_error.setError;
                 RAISE pkg_error.CONTROLLED_ERROR;
        END;

        IF (nuExiste = 1)
        THEN
            sbFormato := sbFormato;
        ELSE
            nuResExiste := '0';
        END IF;

        pkg_traza.trace(csbMetodo||' nuResExiste: '||nuResExiste, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' sbFormato: '||sbFormato, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN sbFormato;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
             RETURN nuResExiste;
             RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
             pkg_Error.setError;
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
             RETURN nuResExiste;
             RAISE pkg_error.CONTROLLED_ERROR;
    END fsbFormatoFactContrato;

    /*
    * Procedimiendo encargado de
    * retornar la informacion de la factura
    * de la tabla ed_document, este procedimiento
    * no será! utilizado para Kiosco
    */

    /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

           PROCEDURE : proCnltaDupliFact
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 30/07/2012
             RICEF   : I045
         DESCRIPCION : Consulta el duplicado de la factura

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     HECTORFDV    16/05/2013  Creacion del paquete
     ADRIANAVG    12/12/2023  OSF-1819: Se implementa pkg_error.prInicializaError y se retira la declaracion onuErrorCode := 0
                              Se declaran variables para el manejo de traza y de error.
                              Ajustar bloque de exceptions según las pautas técnicas
    ************************************************************************/
    PROCEDURE proCnltaDupliFact (inuSuscCodi       IN  SUSCRIPC.SUSCCODI%TYPE,
                                 orDocuments       OUT SYS_REFCURSOR,
                                 onuErrorCode      OUT NUMBER,
                                 osbErrorMessage   OUT VARCHAR2)
    IS

        --variables para el manejo de trazas y de error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'proCnltaDupliFact';

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( onuErrorCode, osbErrorMessage);
        pkg_traza.trace(csbMetodo||' inuSuscCodi: '||inuSuscCodi, csbNivelTraza);

        OPEN orDocuments FOR
            SELECT do.*
              FROM ed_document do, factura fa
             WHERE do.docupefa = fa.factpefa
               AND do.docucodi = fa.factcodi
               AND fa.factsusc = DECODE (inuSuscCodi, -1, fa.factsusc, inuSuscCodi)
               AND fa.factcodi = (SELECT MAX (factcodi)
                                    FROM factura fa1
                                   WHERE fa1.factsusc = DECODE (inuSuscCodi,  -1, fa.factsusc, inuSuscCodi))
               AND fa.factprog IN (6, 123);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             onuErrorCode := -1;
             pkg_Error.getError(onuErrorCode, osbErrorMessage);
             pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
             onuErrorCode := -1;
             pkg_Error.setError;
             pkg_Error.getError(onuErrorCode, osbErrorMessage);
             pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
             RAISE pkg_error.CONTROLLED_ERROR;
    END;--proCnltaDupliFact

    /************************************************************************
    *PROPIEDAD INTELECTUAL
    *
    *    PROCEDURE : PROGENERAFACTGDC
    *    AUTOR     : Hector Fabio Dominguez
    *    FECHA     : 13-01-2015
    *    RICEF     : I040
    * DESCRIPCION  :  Permite consultar la informacion de la factura
            *
    *
    * Historia de Modificaciones
    * Autor           Fecha      Descripcion.
    * HECTORFDV       26-10-2014  Creacion del procedimiento
    * HECTORFDV       14-01-2015  Ajustes con las ultimas actualizaciones de la factura
    * KAREMBM         21-04-2015  A-147645 Ajustes para que el envio de facturación electronica
                                  y duplicado web, no se genere un numero de cupon nuevo.
    * jjjm            04-09-2015 Se agrega condicion isbTipoSaldo para validar dupolicado factura mes anterior
    * oparra          25/04/2017 CA. 200-904 Ajuste Duplicado kiosko
    * DVALIENTE       26/02/2018 SE AGREGO PARA EL CASO 200-1515 EL CURSOR PARA LAS MARCAS DE AGUA E IMPRESO
    * Jorge Valiente  04/07/2018 CASO 200-1948: Actualizacion del proceso:
                                                Generacion del cargo a la -1
                                                Actualizacion de solicitud para financiar el cargo
    ELAL               22/04/2019   CA 200-2032 se adiciona logica para colocar reglas de negocio a la impresion de spooll
    Esantiago          23/09/2019   CA 234 se limita la logitud de la cadena de error.
     ADRIANAVG         13/12/2023   OSF-1819: Se implementa pkg_error.prInicializaError y se retira onuErrorCode := 0;
                                    Se declaran variables para el manejo de traza y de error.
                                    Se ajusta cursor cuSolicitud, reemplazando ldc_boutilities.splitstrings por regexp_substr
                                    En el cursor CUMARCAS, se reemplaza ge_bopersonal.fnugetpersonid por pkg_bopersonal.fnugetpersonaid
                                    Ajustar bloque de exceptions según las pautas técnicas
     Jorge Valiente    12/07/2024  OSF-2930:Nuevo servicio para registrar cupon duplicado.                                    
    ******************************************************************************************/

    PROCEDURE PROGENERAFACTGDC (inuSusccodi        IN  suscripc.susccodi%TYPE,
                                inuSaldoGen        IN  NUMBER,
                                isbTipoSaldo       IN  VARCHAR2,
                                CUDATOSBASIC       OUT SYS_REFCURSOR,
                                CUCONCEPT          OUT SYS_REFCURSOR,
                                CUREVISION         OUT SYS_REFCURSOR,
                                CUHISTORICO        OUT SYS_REFCURSOR,
                                CULECTURAS         OUT SYS_REFCURSOR,
                                CUTOTALES          OUT SYS_REFCURSOR,
                                CURANGOS           OUT SYS_REFCURSOR,
                                CUCOMPCOST         OUT SYS_REFCURSOR,
                                CUCODBAR           OUT SYS_REFCURSOR,
                                CUTASACAMB         OUT SYS_REFCURSOR,
                                CUOTROS            OUT SYS_REFCURSOR,
                                CUMARCAS           OUT SYS_REFCURSOR, --Caso 200-1515
                                osbSeguroLiberty   OUT VARCHAR2,
                                osbOrdenSusp       OUT VARCHAR2,
                                osbProcFact        OUT VARCHAR2,
                                osbImprimir        OUT VARCHAR2,
                                onuErrorCode       OUT NUMBER,
                                osbErrorMessage    OUT VARCHAR2,
                                ISBSISTEMA         IN  VARCHAR2 DEFAULT 'N')
    AS
        ONUDEFERREDBALANCE   NUMBER;
        nuFactura            NUMBER;
        ISBXMLREFERENCE      CLOB; -- para envio de parametros en la generacion de cupon
        INUREFTYPE           NUMBER;
        ONUCUPONUME          NUMBER;
        ONUTOTALVALUE        NUMBER;
        nuInteresMora        ta_vigetaco.vitcporc%TYPE;
        CUCONCEPTOS          SYS_REFCURSOR;

        NUPRODUCTO           NUMBER;
        blNRegulado          BOOLEAN;
        nuValorRECEPtype     NUMBER;                           --Caso 200-1427
        sbobs                VARCHAR2 (2000);                  --Caso 200-1427

        --Variables de control para el cobro de duplicados
        nuCobroDupli         NUMBER;
        nuValorCobro         NUMBER;
        rcCobroDupli         DALD_CUPON_CAUSAL.styLD_CUPON_CAUSAL;
        sbCusaCargo          NUMBER;
        nuPackageId          NUMBER;                           --Caso 200-1427
        nuMotiveId           NUMBER;                           --Caso 200-1427

        --Descripcion: Declaracion de variable de control para la fecha limite de pago. Tiquete:  2733, 10-02-2014. Autor: hectorfdv
        sbInmediata          VARCHAR2 (500);

        ERROR_GENERA         EXCEPTION;
        ERROR_MORA           EXCEPTION;

        --Consulta si se debe realizar o no el cobro. FECHA: 21-11-2014. TIQUETE: ROLLOUT
        CURSOR cuConsultaCobro IS
            SELECT COUNT (*)
              FROM LDCI_CARASEWE
             WHERE CASEVALO = isbSistema AND CASEDESE = 'WS_KIOSCO_COBRO';

        nufactelect          NUMBER;

        CURSOR cuConsultafactelect IS
            SELECT COUNT (*)
              FROM LDCI_CARASEWE
             WHERE CASEVALO = isbSistema AND CASEDESE = 'WS_NOTSUSCFELE';

        Total_servicio       VARCHAR2 (200);
        TOTAL_VALOR_MES      VARCHAR2 (200);
        TOTAL_AMORTIZACION   VARCHAR2 (200);
        TOTAL_DIFERIDO       VARCHAR2 (200);

        --Consulta el periodo de facturacion de una factura. 10-12-2014. TIQUETE: ROLLOUT
        CURSOR CUPEFAFACT (inuFactura NUMBER)
        IS
            SELECT FACTPEFA
              FROM FACTURA
             WHERE FACTCODI = inuFactura;

        --Se calcula cual es el ultimo periodo de las facturas con saldo. Se obtiene las facturas de ese periodo y se suman los saldos pendientes
        --03/03/2014  TQ: 3034
        CURSOR cuConsultaUltFact IS
              SELECT cc.CUCOFACT
                FROM CUENCOBR cc
               WHERE cc.CUCOFACT IN (SELECT factu.factcodi
                                     FROM factura factu
                                    WHERE factu.factsusc = inuSusccodi
                                      AND (SELECT SUM (CUCOSACU)
                                             FROM CUENCOBR CCBR
                                            WHERE CCBR.CUCOFACT = factu.factcodi) > 0
                                      AND factu.FACTPEFA =(SELECT MAX (factusub.FACTPEFA)
                                                             FROM FACTURA factusub
                                                            WHERE factusub.factsusc = inuSusccodi
                                                              AND (SELECT SUM (CUCOSACU)
                                                                     FROM CUENCOBR CCBR
                                                                    WHERE CUCOFACT = factusub.factcodi) >  0))
            GROUP BY cc.CUCOFACT;

        -- jjjm Cursor factura mas vieja con saldo
        CURSOR cufactante IS
            SELECT factura
              FROM (  SELECT factcodi     factura
                        FROM (  SELECT factcodi, pefaano, pefames
                                  FROM cuencobr, factura, perifact
                                 WHERE cucosacu > 0
                                   AND factsusc = inuSusccodi
                                   AND cucofact = factcodi
                                   AND factpefa = pefacodi
                              GROUP BY factcodi,
                                       pefaano,
                                       pefames,
                                       factprog
                              ORDER BY factcodi DESC)
                       WHERE ROWNUM <= 2
                    ORDER BY factcodi)
             WHERE ROWNUM <= 1;

        /*cursor para ultimo cupon de la factura*/
        CURSOR cuultcupfact IS
            SELECT cuponume, cupovalo
              FROM cupon
             WHERE cuponume =
                   (SELECT MAX (c.cuponume)
                      FROM cupon c
                     WHERE c.cupotipo = 'FA'
                       AND c.cupoprog = 'FIDF'
                       AND c.cuposusc = inuSusccodi
                       AND c.cupodocu =  (SELECT MAX (factu.factcodi)
                                            FROM factura factu
                                           WHERE factu.factsusc = inuSusccodi
                                             AND factu.factprog = 6
                                             AND factu.FACTPEFA = (SELECT MAX (factusub.FACTPEFA)
                                                                     FROM FACTURA factusub
                                                                    WHERE factusub.factsusc = inuSusccodi
                                                                      AND factusub.factprog = 6)));

        -- jjjm
        /*cursor para CUPON DE FACTURA MES ANTERIOR */
        CURSOR cucuponvalomesante IS
            SELECT cuponume, cupovalo
              FROM cupon
             WHERE cuponume =
                   (SELECT MAX (c.cuponume)
                      FROM cupon c
                     WHERE c.cupotipo = 'FA'
                       AND c.cupoprog = 'FIDF'
                       AND c.cuposusc = inuSusccodi
                       AND c.cupodocu = ( SELECT factura
                                            FROM (  SELECT factcodi  factura
                                                      FROM (  SELECT factcodi,
                                                                     pefaano,
                                                                     pefames
                                                                FROM cuencobr,
                                                                     factura,
                                                                     perifact
                                                               WHERE cucosacu > 0
                                                                 AND factsusc = inuSusccodi
                                                                 AND cucofact = factcodi
                                                                 AND factpefa = pefacodi
                                                            GROUP BY factcodi,
                                                                     pefaano,
                                                                     pefames,
                                                                     factprog
                                                            ORDER BY factcodi DESC)
                                                    WHERE ROWNUM <= 2
                                                 ORDER BY factcodi)
                                          WHERE ROWNUM <= 1));

        INUPERIODOFACT       NUMBER;
        SBCODIGOEAN          VARCHAR2 (3000);
        RCFACTURA            FACTURA%ROWTYPE;

        --Instancias de variables para la impresion de los conceptos de saldo anterior
        --Inicio CASO 200-459
        sbcadena             VARCHAR2 (4000);
        --Fin CASO 200-459

        -- CA- 200-904 Consulta solicitud
        CURSOR cuSolicitud (inuContrato NUMBER)
        IS
            SELECT MAX (mo_packages.package_id)
              FROM mo_packages, mo_motive
             WHERE mo_packages.package_id = mo_motive.package_id
               AND mo_packages.package_type_id IN (SELECT to_number(regexp_substr(dald_parameter.fsbGetValue_Chain ( 'COD_SOLIC_INFO_GRAL'),
                                                   '[^,]+', 1,   LEVEL)) AS COLUMN_VALUE
                                                    FROM dual
                                              CONNECT BY regexp_substr(dald_parameter.fsbGetValue_Chain ( 'COD_SOLIC_INFO_GRAL'), '[^,]+', 1, LEVEL) IS NOT NULL
                                              )
               AND mo_motive.subscription_id = inuContrato;

        nuPackage_id         NUMBER := 0;
        nuPosInstance        NUMBER;  -- CASO 200-1427

        ---Inicio CASO 200-1899
        sbPAGARE_UNICO       VARCHAR2 (4000) := ' ';

        CURSOR cupagareunico (IsbFactsusc VARCHAR2)
        IS
            SELECT lp.pagare_id     PAGARE_UNICO
              FROM LDC_PAGUNIDAT lp
             WHERE lp.suscription_id = IsbFactsusc AND lp.estado = 1;

        rfcupagareunico      cupagareunico%ROWTYPE;
        --Fin CASO 200-1899

        --INICIO CA 200-2032
        sbUsoNoresidencial   VARCHAR2 (50)  := DALD_PARAMETER.FSBGETVALUE_CHAIN ('LDC_USOSERV', NULL); -- se almacena valor no residencial
        --FIN CA 200-2032

        --variables para el manejo de trazas y de error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'PROGENERAFACTGDC';
        sbError      VARCHAR2(4000);
        nuError      NUMBER;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( onuErrorCode, osbErrorMessage);
        pkg_traza.trace(csbMetodo||' inuSusccodi: '||inuSusccodi, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' inuSaldoGen: '||inuSaldoGen, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' isbTipoSaldo: '||isbTipoSaldo, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' ISBSISTEMA: '||ISBSISTEMA, csbNivelTraza);

        --Inicio CASO 200-459
        sbcadena := '0. Parametros de entrada inuSusccodi['|| inuSusccodi || '] - inuSaldoGen[' || inuSaldoGen
                                                           || '] - isbTipoSaldo[' || isbTipoSaldo || '] - ISBSISTEMA[' || ISBSISTEMA  || ']';
        pkg_traza.trace(csbMetodo||' sbcadena: '||sbcadena, csbNivelTraza);

        LDC_PROCONTROL_DUPLICADO (inuSusccodi, sbcadena);
        --Fin CASO 200-459

        osbSeguroLiberty := 'N';
        OSBORDENSUSP := 'N';

        -- Inicialziamos la variable de control para la fecha limite de pago. Tiquete:  2733. 10-02-2014. Autor: hectorfdv
        sbInmediata := '';
        Inureftype := 2;

        --Se coloca el manejo de excepciones  ya que el api no esta controlando en su interior las excepciones
        BEGIN
            OPEN cuConsultafactelect;
            FETCH cuConsultafactelect INTO nufactelect;
            CLOSE cuConsultafactelect;
            pkg_traza.trace(csbMetodo||' nufactelect: '||nufactelect, csbNivelTraza);

            --Inicio CASO 200-459
            sbcadena := '1. Dato cursor cuConsultafactelect nufactelect['|| nufactelect || ']';
            pkg_traza.trace(csbMetodo||' sbcadena: '||sbcadena, csbNivelTraza);
            LDC_PROCONTROL_DUPLICADO (inuSusccodi, sbcadena);
            --Fin CASO 200-459

            -- JJJM
            IF nufactelect > 0  THEN
                IF isbTipoSaldo = 1   THEN
                    OPEN cuultcupfact;
                    FETCH cuultcupfact INTO ONUCUPONUME, ONUTOTALVALUE;
                    CLOSE cuultcupfact;
                ELSE
                    OPEN cucuponvalomesante;
                    FETCH cucuponvalomesante INTO ONUCUPONUME, ONUTOTALVALUE;
                    CLOSE cucuponvalomesante;
                END IF;
                pkg_traza.trace(csbMetodo||' ONUCUPONUME: '||ONUCUPONUME, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' ONUTOTALVALUE: '||ONUTOTALVALUE, csbNivelTraza);

                --Inicio CASO 200-459
                sbcadena := '2. isbTipoSaldo [' || isbTipoSaldo || '] Datos cursor cuultcupfact ONUCUPONUME[' || ONUCUPONUME  || '] - ONUTOTALVALUE[' || ONUTOTALVALUE|| ']';
                pkg_traza.trace(csbMetodo||' sbcadena: '||sbcadena, csbNivelTraza);
                LDC_PROCONTROL_DUPLICADO (inuSusccodi, sbcadena);
               --Fin CASO 200-459

            ELSE
                IF INUSALDOGEN > 0 THEN
                    ISBXMLREFERENCE := '<?xml version="1.0" encoding="utf-8" ?><Suscripcion><Id_Suscripcion>'
                        || inuSusccodi  || '</Id_Suscripcion><Valor_a_Pagar>'
                        || inuSaldoGen  || '</Valor_a_Pagar></Suscripcion >';
                    pkg_traza.trace(csbMetodo||' ISBXMLREFERENCE: '||ISBXMLREFERENCE, csbNivelTraza);

                    API_COUPONGENERATION (INUREFTYPE        => INUREFTYPE,
                                          ISBXMLREFERENCE   => ISBXMLREFERENCE,
                                          ONUCUPONUME       => ONUCUPONUME,
                                          ONUTOTALVALUE     => ONUTOTALVALUE,
                                          ONUERRORCODE      => ONUERRORCODE,
                                          OSBERRORMESSAGE   => OSBERRORMESSAGE);
                   pkg_traza.trace(csbMetodo||' API_COUPONGENERATION--> ONUCUPONUME: '||ONUCUPONUME, csbNivelTraza);
                   pkg_traza.trace(csbMetodo||' API_COUPONGENERATION--> ONUTOTALVALUE: '||ONUTOTALVALUE, csbNivelTraza);
                   pkg_traza.trace(csbMetodo||' API_COUPONGENERATION--> ONUERRORCODE: '||ONUERRORCODE, csbNivelTraza);
                   pkg_traza.trace(csbMetodo||' API_COUPONGENERATION--> OSBERRORMESSAGE: '||OSBERRORMESSAGE, csbNivelTraza);
                ELSE
                    ONUTOTALVALUE := 0;
                    ONUCUPONUME := 0;
                    pkg_traza.trace(csbMetodo||' ONUCUPONUME: '||ONUCUPONUME, csbNivelTraza);
                    pkg_traza.trace(csbMetodo||' ONUTOTALVALUE: '||ONUTOTALVALUE, csbNivelTraza);
                END IF;

                --Inicio CASO 200-459
                IF inuSaldoGen > 0
                THEN
                    sbcadena := '<?xml version="1.0" encoding="utf-8" ?><Suscripcion><Id_Suscripcion>'
                        || inuSusccodi || '</Id_Suscripcion><Valor_a_Pagar>'
                        || inuSaldoGen || '</Valor_a_Pagar></Suscripcion >';
                    pkg_traza.trace(csbMetodo||' sbcadena: '||sbcadena, csbNivelTraza);
                END IF;

                sbcadena := '3. '|| sbcadena || ' INUSALDOGEN ['|| INUSALDOGEN || '] Datos ONUCUPONUME['|| ONUCUPONUME  || '] - ONUTOTALVALUE['|| ONUTOTALVALUE|| ']';
                pkg_traza.trace(csbMetodo||' sbcadena: '||sbcadena, csbNivelTraza);
                LDC_PROCONTROL_DUPLICADO (inuSusccodi, sbcadena);

                --Fin CASO 200-459
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                 RAISE ERROR_GENERA;
        END;

        IF onuErrorCode <> 0 THEN
           RAISE ERROR_GENERA;
        END IF;

        BEGIN
            onuErrorCode := 0;

            --Validamos si el parámetro de cobro de duplicado se encuentra configurado
            nuValorCobro := DALD_PARAMETER.fnuGetNumeric_Value ( 'COBRO_POR_DUPLICADO');
            pkg_traza.trace(csbMetodo||' nuValorCobro: '||nuValorCobro, csbNivelTraza);
        EXCEPTION
            WHEN OTHERS THEN
                 pkg_Error.setError;
                 pkg_Error.getError(nuError, sbError);
                 pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
                 NULL;
        END;

        IF nuValorCobro > 0
        THEN
            --Evaluamos Si el sistema de negocio tiene asignado cobro
            OPEN cuConsultaCobro;
            FETCH cuConsultaCobro INTO nuCobroDupli;
            CLOSE cuConsultaCobro;

            --Inicio CASO 200-459
            sbcadena := '4. nuValorCobro ['|| nuValorCobro|| '] Datos cursor cuConsultaCobro nuCobroDupli['|| nuCobroDupli || ']';
            pkg_traza.trace(csbMetodo||' sbcadena: '||sbcadena, csbNivelTraza);

            LDC_PROCONTROL_DUPLICADO (inuSusccodi, sbcadena);
            --Fin CASO 200-459

            --inicio Caso 200-1427
            --se bloquea la sentencia

            nuValorRECEPtype := DALD_PARAMETER.fnuGetNumeric_Value ( 'COD_TIPO_MEDIO_RECEP_KIOSCO');
            pkg_traza.trace(csbMetodo||' nuValorRECEPtype: '||nuValorRECEPtype, csbNivelTraza);

            IF isbTipoSaldo = 0 THEN
                sbobs := ' IMPRESION DE FACTURA ANTERIOR';
            ELSIF isbTipoSaldo = 1
            THEN
                sbobs := ' IMPRESION DE FACTURA ACTUAL';
            END IF;
            pkg_traza.trace(csbMetodo||' sbobs: '||sbobs, csbNivelTraza);

            LDCI_PKFACTKIOSCO_GDC.proSoliDuplicadoKiosco (inuSusccodi,
                                                          nuValorRECEPtype,
                                                          sbobs,
                                                          nuPackageId,
                                                          nuMotiveId,
                                                          onuErrorCode,
                                                          osbErrorMessage);

            pkg_traza.trace(csbMetodo||' LDCI_PKFACTKIOSCO_GDC.proSoliDuplicadoKiosco--> nuPackageId: '||nuPackageId, csbNivelTraza);
            pkg_traza.trace(csbMetodo||' LDCI_PKFACTKIOSCO_GDC.proSoliDuplicadoKiosco--> nuMotiveId: '||nuMotiveId, csbNivelTraza);

            IF nuPackageId IS NULL THEN
                nuPackageId := 0;
                --pkg_error.SETERROR;
                pkg_error.GETERROR (osberrormessage, osberrormessage);
                pkg_traza.trace('osberrormessage: ' || osberrormessage, csbNivelTraza);
            END IF;
            
            --Inicio CASO 200-459
            sbcadena := '5. Datos para generar crago a la -1 ONUCUPONUME['|| ONUCUPONUME || '] - PACKAGE_ID [0]';
            pkg_traza.trace(csbMetodo||' sbcadena: '||sbcadena, csbNivelTraza);
            LDC_PROCONTROL_DUPLICADO (inuSusccodi, sbcadena);
            --Fin CASO 200-459

            rcCobroDupli.CUPONUME := ONUCUPONUME;
            pkg_traza.trace(csbMetodo||' rcCobroDupli.CUPONUME: '||rcCobroDupli.CUPONUME, csbNivelTraza);

            RCCOBRODUPLI.CAUSAL_ID := 280;
            pkg_traza.trace(csbMetodo||' rcCobroDupli.CAUSAL_ID: '||rcCobroDupli.CAUSAL_ID, csbNivelTraza);

            --CASO 200-1948
            --Cambiar el valor 0 por el codigo de la solicitud de generacion por parte de KISOKO .NET
            rcCobroDupli.PACKAGE_ID := NVL (nuPackageId, 0);
            pkg_traza.trace(csbMetodo||' rcCobroDupli.PACKAGE_ID: '||rcCobroDupli.PACKAGE_ID, csbNivelTraza);
            --Fin CASO 200-1948

            DALD_CUPON_CAUSAL.INSRECORD (RCCOBRODUPLI);
            --Inicio OSF-2930
            pkg_duplicado_factura.prcRegsitraDuplicado(ONUCUPONUME,
                                                       inuSusccodi,
                                                       NVL(nuPackageId, 0));
            --Fin OSF-2930

            --Inicio CASO 200-459
            sbcadena := '6. Exito en la generacion de cargo';
            pkg_traza.trace(csbMetodo||' sbcadena: '||sbcadena, csbNivelTraza);

            LDC_PROCONTROL_DUPLICADO (inuSusccodi, sbcadena);
        --Fin CASO 200-459

        --se bloquea el si caso 200-1427

        END IF;

        --Select que se encarga de retornar la factura
        IF isbTipoSaldo = 1 THEN
            pkg_traza.trace(csbMetodo||' consulta factura actual ', csbNivelTraza);
            OPEN CUCONSULTAULTFACT;
            FETCH CUCONSULTAULTFACT INTO NUFACTURA;
            CLOSE cuConsultaUltFact;
        ELSE
            pkg_traza.trace(csbMetodo||' consulta factura anterior ', csbNivelTraza);
            OPEN cufactante;
            FETCH cufactante INTO NUFACTURA;
            CLOSE cufactante;
        END IF;
        pkg_traza.trace(csbMetodo||' factura: '||NUFACTURA, csbNivelTraza);

        --Calcula el periodo de facturacion asociado a la factura
        OPEN CUPEFAFACT (NUFACTURA);
        FETCH CUPEFAFACT INTO INUPERIODOFACT;
        CLOSE CUPEFAFACT;
        pkg_traza.trace(csbMetodo||' Periodo de facturacion: '||INUPERIODOFACT, csbNivelTraza);

        --valida si debemos colocar inmediato en la fecha limite de pago. Tiquete:  2733. 10-02-2014. Autor:  hectorfdv

        --Se calcula la suma de las cuentas vencidas, si es superior a cero, Entonces es pago inmediato. Tiquete:  2756. 10-02-2014. Autor: hectorfdv

        --VALIDACION DE INSTANCIAS CASO 200-1427
        /*  Si no esta inicializada la instancia*/
        IF (NOT GE_BOInstanceControl.fblIsInitInstanceControl)  THEN
            pkg_traza.trace(csbMetodo||' inicializada la instancia ', csbNivelTraza);
            GE_BOInstanceControl.InitInstanceManager;
        END IF;

        /*  Si no existe la DATA_EXTRACTOR*/
        IF (NOT GE_BOInstanceControl.fblAcckeyInstanceStack ( 'DATA_EXTRACTOR', nuPosInstance))
        THEN
            pkg_traza.trace(csbMetodo||' existe la DATA_EXTRACTOR ', csbNivelTraza);
            /*variable global que determina si NO se genera la copia por KIOSCO .NET*/
            GE_BOInstanceControl.CreateInstance ('DATA_EXTRACTOR', NULL);
            GE_BOINSTANCECONTROL.ADDATTRIBUTE ('DATA_EXTRACTOR',   NULL, 'FACTURA', 'APLICA', '0', TRUE);
        END IF;

        --FIN DE VALIDACION

        GE_BOINSTANCECONTROL.ADDATTRIBUTE ('DATA_EXTRACTOR', NULL, 'FACTURA', 'FACTCODI', NUFACTURA,TRUE);
        GE_BOINSTANCECONTROL.ADDATTRIBUTE ('DATA_EXTRACTOR', NULL, 'FACTURA', 'FACTSUSC', INUSUSCCODI, TRUE);
        GE_BOINSTANCECONTROL.ADDATTRIBUTE ('DATA_EXTRACTOR', NULL, 'FACTURA', 'FACTPEFA', INUPERIODOFACT, TRUE);

        RCFACTURA := PKTBLFACTURA.FRCGETRECORD (NUFACTURA);
        pkg_traza.trace(csbMetodo||' Consecutivo del Estado de Cuenta: '||RCFACTURA.FACTCODI, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' Suscripcion: '||RCFACTURA.FACTSUSC, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' Periodo de Facturacion: '||RCFACTURA.FACTPEFA, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' nemonico DEL programa que genero el estado de cuenta: '||RCFACTURA.FACTPROG, csbNivelTraza);

        PKBOINSTANCEPRINTINGDATA.INSTANCEBILLDATA (INUSUSCCODI, RCFACTURA);

        --Bloque para la consulta de datos basicos de un suscriptor
        BEGIN
            --Inicio CASO 200-1899
             OPEN cupagareunico (inuSusccodi);
            FETCH cupagareunico INTO rfcupagareunico;
            IF cupagareunico%FOUND
            THEN
                IF rfcupagareunico.pagare_unico IS NOT NULL THEN
                    sbPAGARE_UNICO := 'con PU';
                END IF;
            END IF;
            CLOSE cupagareunico;
            pkg_traza.trace(csbMetodo||' sbPAGARE_UNICO: '||sbPAGARE_UNICO, csbNivelTraza);
            --Fin CASO 200-1899

            BLNREGULADO := LDC_DetalleFact_GasCaribe.FBLNOREGULADO (NUFACTURA);
            IF blNRegulado THEN
                pkg_traza.trace(csbMetodo||' blNRegulado IS TRUE', csbNivelTraza);
            ELSE
                pkg_traza.trace(csbMetodo||' blNRegulado IS FALSE', csbNivelTraza);
            END IF;

            IF NOT blNRegulado THEN
                ---- Se abre el CURSOR a retornar.
                pkg_traza.trace(csbMetodo||' Abre CUDATOSBASIC 1', csbNivelTraza);
                OPEN CUDATOSBASIC FOR
                     SELECT fc.factcodi  FACTURA,
                           TO_CHAR ( fc.factfege, 'DD/MON/YYYY','nls_date_language=spanish') FECH_FACT,
                           TO_CHAR ( TO_DATE (PF.PEFAMES || '-' || PF.PEFAANO, 'MM-YYYY'), 'MON-YYYY', 'nls_date_language=spanish') MES_FACT,
                           TO_CHAR ( TO_DATE (pktblperifact.fnugetmonth (fc.factpefa)
                                    || '-'|| pktblperifact.fnugetyear (fc.factpefa), 'MM-YYYY'), 'MONTH YYYY', 'nls_date_language=spanish') PERIODO_FACT,
                           CASE --TICKET 200-2032 ELAL --se cambia logica para obtencion de cuentas de cobro
                               WHEN LDC_DetalleFact_GasCaribe.fnuMesesDeuda ( fc.factsusc) >=  2 THEN  'INMEDIATO'
                               ELSE  TO_CHAR (cc.cucofeve, 'DD/MM/YYYY')
                           END  PAGO_HASTA,
                           TO_CHAR (ROUND (pc.pecsfecf - pc.pecsfeci))  DIAS_CONSUMO,
                           b.susccodi  CONTRATO,
                           ONUCUPONUME  CUPON,
                           a.subscriber_name || ' ' || a.subs_last_name   NOMBRE,
                           ca.address_parsed  DIRECCION_COBRO,
                           dage_geogra_location.fsbgetdescription ( ca.geograp_location_id) || ' - ' || SUBSTR ( dage_geogra_location.fsbgetdescription (
                                      dage_geogra_location.fnugetgeo_loca_father_id ( ca.geograp_location_id)),  0,  3
                                      ) LOCALIDAD,
                           REPLACE ( pktblcategori.fsbgetdescription ( s.sesucate),'COMERCIAL', sbUsoNoresidencial) CATEGORIA, --TICKET 200-2032 ELAL -- se cambia palabra comercial por el valor no residencial
                           TRIM (REPLACE (pktblsubcateg.fsbgetdescription (s.sesucate, s.sesusuca),'ESTRATO',''))  ESTRATO, --TICKET 200-2032 ELAL -- se quita palabra ESTRATO
                           b.susccicl  CICLO,
                           AB.ROUTE_ID || DAAB_PREMISE.FNUGETCONSECUTIVE (CA.ESTATE_NUMBER)  RUTA,
                           LDC_DetalleFact_GasCaribe.fnuMesesDeuda (fc.factsusc) MESES_DEUDA,
                           cc.cucocodi  NUM_CONTROL,
                            TO_CHAR (pc.pecsfeci, 'DD/MON') || ' - ' || TO_CHAR (pc.pecsfecf, 'DD/MON') PERIODO_CONSUMO,
                           b.suscsafa  SALDO_FAVOR,
                           NULL   SALDO_ANT,
                           CASE
                               WHEN LDC_DetalleFact_GasCaribe.fnuMesesDeuda ( fc.factsusc) >= 2
                               THEN 'INMEDIATO' --TICKET 200-2032 ELAL --  se adiciona validacion de meses de deuda
                               WHEN (LDC_DetalleFact_GasCaribe.fnuFechaSuspension (s.sesunuse,  s.sesucate) = 1)
                               THEN  TO_CHAR (pefaffpa, 'DD/MM/YYYY')
                               ELSE  ''
                           END FECHA_SUSPENSION,
                           (SELECT SUM (cucovare + cucovrap)
                              FROM cuencobr, servsusc
                             WHERE cuconuse = sesunuse
                               AND sesususc = fc.factsusc)  VALOR_RECL,
                           TO_CHAR (ONUTOTALVALUE, 'FM999,999,999,990') TOTAL_FACTURA,
                           CASE
                               WHEN LDC_DetalleFact_GasCaribe.fnuMesesDeuda (fc.factsusc) >= 2
                               THEN --TICKET 200-2032 ELAL --  se adiciona validacion de meses de deuda
                                   'INMEDIATO'
                               ELSE  TO_CHAR (cc.cucofeve, 'DD/MM/YYYY')
                           END PAGO_SIN_RECARGO,
                           NULL CONDICION_PAGO,
                           NULL IDENTIFICA,
                           NULL SERVICIO,
                           sbPAGARE_UNICO PAGARE_UNICO --CASO 200-1899
                      FROM factura        fc,
                           cuencobr       cc,
                           suscripc       b,
                           servsusc       s,
                           ge_subscriber  a,
                           perifact       pf,
                           pericose       pc,
                           ab_address     ca,
                           ab_segments    ab
                     WHERE fc.factcodi = NUFACTURA
                       AND fc.factcodi = cc.cucofact
                       AND fc.factsusc = b.susccodi
                       AND b.susccodi = s.sesususc
                       AND a.subscriber_id = b.suscclie
                       AND pf.pefacodi = fc.factpefa
                       AND pc.pecscons =  LDC_BOFORMATOFACTURA.fnuObtPerConsumo (pf.pefacicl, pf.pefacodi)
                       AND b.susciddi = ca.address_id
                       AND pf.pefacodi = fc.factpefa
                       AND ca.segment_id = ab.segments_id
                       AND cc.cuconuse = s.sesunuse
                       AND ROWNUM = 1;                
            ELSE
                pkg_traza.trace(csbMetodo||' Abre CUDATOSBASIC 2', csbNivelTraza);
                OPEN CUDATOSBASIC FOR
                    SELECT fc.factcodi FACTURA,
                           TO_CHAR (fc.factfege,'DD/MON/YYYY', 'nls_date_language=spanish') FECH_FACT,
                           TO_CHAR (TO_DATE (PF.PEFAMES || '-' || PF.PEFAANO, 'MM-YYYY'), 'MONTH YYYY', 'nls_date_language=spanish') MES_FACT,
                           TO_CHAR (pc.pecsfeci, 'DD')
                           || ' AL '
                           || TO_CHAR (pc.pecsfecf, 'DD MONTH', 'nls_date_language=spanish')
                           || ' DEL '
                           || PEFAANO PERIODO_FACT,
                           CASE
                               WHEN (LDC_BOFORMATOFACTURA.fnuObtNCuentaSaldo (s.sesunuse) > 2)  AND (s.sesucate = 1) THEN 'INMEDIATO'
                               WHEN (LDC_BOFORMATOFACTURA.fnuObtNCuentaSaldo (s.sesunuse) > 1)  AND (s.sesucate != 1) THEN 'INMEDIATO'
                               ELSE  TO_CHAR (cc.cucofeve, 'DD/MON/YYYY','nls_date_language=spanish')
                           END PAGO_HASTA,
                           NULL  DIAS_CONSUMO,
                           b.susccodi  CONTRATO,
                           PKBOBILLPRINTHEADERRULES.FSBGETCOUPON ()  CUPON,
                           a.subscriber_name || ' ' || a.subs_last_name  NOMBRE,
                           ca.address_parsed || ' ' || dage_geogra_location.fsbgetdescription ( ca.geograp_location_id)  DIRECCION_COBRO,
                           NULL LOCALIDAD, -- Revisar si va el departamento donde se va a guardar
                           NULL CATEGORIA,
                           NULL ESTRATO,
                           NULL CICLO,
                           NULL RUTA,
                           NULL MESES_DEUDA,
                           NULL NUM_CONTROL,
                           NULL PERIODO_CONSUMO,
                           TO_CHAR (b.suscsafa, 'FM999,999,999,990')SALDO_FAVOR,
                           TO_CHAR (PKBOBILLPRINTHEADERRULES.FNUGETTOTALPREVIOUSBALANCE, 'FM999,999,999,990') SALDO_ANT,
                           NULL FECHA_SUSPENSION,
                           NULL  VALOR_RECL,
                           TO_CHAR ( (SELECT ROUND (cupovalo)
                                        FROM cupon
                                       WHERE cuponume = ONUCUPONUME),
                                    'FM999,999,999,990') TOTAL_FACTURA,
                           TO_CHAR (cc.cucofeve, 'DD/MM/YYYY') PAGO_SIN_RECARGO,
                           'CONTADO' CONDICION_PAGO,
                           a.identification   IDENTIFICA,
                           'NO REGULADO'  SERVICIO,
                           sbPAGARE_UNICO  PAGARE_UNICO --CASO 200-1899
                      FROM factura        fc,
                           cuencobr       cc,
                           suscripc       b,
                           servsusc       s,
                           ge_subscriber  a,
                           perifact       pf,
                           pericose       pc,
                           ab_address     ca,
                           ab_segments    ab
                     WHERE fc.factcodi = NUFACTURA
                       AND fc.factcodi = cc.cucofact
                       AND fc.factsusc = b.susccodi
                       AND b.susccodi = s.sesususc
                       AND a.subscriber_id = b.suscclie
                       AND pf.pefacodi = fc.factpefa
                       AND pc.pecscons = LDC_BOFORMATOFACTURA.fnuObtPerConsumo (pf.pefacicl, pf.pefacodi)
                       AND b.susciddi = ca.address_id
                       AND pf.pefacodi = fc.factpefa
                       AND ca.segment_id = ab.segments_id
                       AND ROWNUM = 1;
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                pkg_error.SETERROR;
                pkg_error.GETERROR (ONUERRORCODE, OSBERRORMESSAGE);
                onuErrorCode := -1;
                OSBERRORMESSAGE := 'Error Consultando datos basicos: ' || OSBERRORMESSAGE|| ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
                pkg_traza.trace(csbMetodo||' OSBERRORMESSAGE: ' || OSBERRORMESSAGE, csbNivelTraza);
        END;

        --Bloque para la consulta de datos de los componentes de costo
        BEGIN
            LDC_DETALLEFACT_GASCARIBE.RFGETVALCOSTCOMPVALID (CUCOMPCOST);
            pkg_traza.trace(csbMetodo||' fin consulta de datos de los componentes de costo ', csbNivelTraza);
        EXCEPTION
            WHEN OTHERS THEN
                pkg_error.SETERROR;
                pkg_error.GETERROR (ONUERRORCODE, OSBERRORMESSAGE);
                ONUERRORCODE := -1;
                OSBERRORMESSAGE := 'Error Consultando datos historicos: ' || OSBERRORMESSAGE|| ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
                pkg_traza.trace(csbMetodo||' OSBERRORMESSAGE: ' || OSBERRORMESSAGE, csbNivelTraza);
        END;

        --Se llama al proceso que calcula la tabla de saldos anteriores. Se deje ejecutar posterior al RFGETVALCOSTCOMPVALID, ya que este internamente
        --instancia al producto que requiere INSTANCEADDITIONALDATA para realizar los calculos}
        pkg_traza.trace(csbMetodo||' llamado al proceso que calcula la tabla de saldos anteriores ', csbNivelTraza);
        PKBOINSTANCEPRINTINGDATA.INSTANCEADDITIONALDATA;

        --Bloque para la consulta de totales

        BEGIN
            --CASO 200-1626
            --Se coloco en comentario el llamado de generacion de conceptos para la factura de kiosko desde LDC_DETALLEFACT_GASCARIBE
            RfConcepParcial (inuSusccodi, NUFACTURA, CUTOTALES);
            pkg_traza.trace(csbMetodo||' fin iva y el subtotal de los no regulados ', csbNivelTraza);
           --Fin CASO 200-1626

        EXCEPTION
            WHEN OTHERS THEN
                pkg_error.SETERROR;
                pkg_error.GETERROR (ONUERRORCODE, OSBERRORMESSAGE);
                ONUERRORCODE := -1;
                OSBERRORMESSAGE := 'Error Consultando datos totales: ' || OSBERRORMESSAGE || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
                OSBERRORMESSAGE := SUBSTR (OSBERRORMESSAGE, 1, 254); -- caso 234
                pkg_traza.trace(csbMetodo||' OSBERRORMESSAGE: ' || OSBERRORMESSAGE, csbNivelTraza);
        END;

        --Bloque para la consulta de detalles de la factura
        BEGIN
            --LDC_DETALLEFACT_GASCARIBE.RFDATOSCONCEPTOS (CUCONCEPT);
            ldc_detallefact_gascaribe.rfdatosconcestadocuenta(CUCONCEPT);
            pkg_traza.trace(csbMetodo||' fin consulta de detalles de la factura ', csbNivelTraza);
        EXCEPTION
            WHEN OTHERS THEN
                pkg_error.SETERROR;
                pkg_error.GETERROR (ONUERRORCODE, OSBERRORMESSAGE);
                ONUERRORCODE := -1;
                OSBERRORMESSAGE := 'Error Consultando conceptos: ' || OSBERRORMESSAGE || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
                pkg_traza.trace(csbMetodo||' OSBERRORMESSAGE: ' || OSBERRORMESSAGE, csbNivelTraza);
        END;

        --Bloque para la consulta de datos basicos datos de lectura
        BEGIN
            ldc_detallefact_gascaribe.RfDatosLecturas (CULECTURAS);
            pkg_traza.trace(csbMetodo||' fin consulta de datos basicos datos de lectura ', csbNivelTraza);
        EXCEPTION
            WHEN OTHERS
            THEN
                pkg_error.SETERROR;
                pkg_error.GETERROR (ONUERRORCODE, OSBERRORMESSAGE);
                ONUERRORCODE := -1;
                OSBERRORMESSAGE := 'Error Consultando datos de la lectura: '|| OSBERRORMESSAGE || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
                pkg_traza.trace(csbMetodo||' OSBERRORMESSAGE: ' || OSBERRORMESSAGE, csbNivelTraza);
        END;

        --Bloque para la consulta de datos historicos
        BEGIN
            -- se cambia metodo Caso 200-904
            LDCI_PKFACTKIOSCO_GDC.RFDATOSCONSUMOHIST (CUHISTORICO);
            pkg_traza.trace(csbMetodo||' fin consulta de datos historicos ', csbNivelTraza);
        EXCEPTION
            WHEN OTHERS THEN
                pkg_error.SETERROR;
                pkg_error.GETERROR (ONUERRORCODE, OSBERRORMESSAGE);
                ONUERRORCODE := -1;
                OSBERRORMESSAGE := 'Error Consultando datos historicos: '|| OSBERRORMESSAGE|| ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
                pkg_traza.trace(csbMetodo||' OSBERRORMESSAGE: ' || OSBERRORMESSAGE, csbNivelTraza);
        END;

        --Bloque para la consulta de datos de la revision
        BEGIN
            ldc_detallefact_gascaribe.RfDatosRevision (CUREVISION);
            pkg_traza.trace(csbMetodo||' fin consulta de datos revision ', csbNivelTraza);
        EXCEPTION
            WHEN OTHERS
            THEN
                pkg_error.SETERROR;
                pkg_error.GETERROR (ONUERRORCODE, OSBERRORMESSAGE);
                ONUERRORCODE := -1;
                OSBERRORMESSAGE := 'Error Consultando datos de la revision: '|| OSBERRORMESSAGE || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
                pkg_traza.trace(csbMetodo||' OSBERRORMESSAGE: ' || OSBERRORMESSAGE, csbNivelTraza);
        END;

        --Bloque para la consulta de datos de los rangos de consumo, de acuerdo con la definicion de facturacion
        --no se realiza el calculo de la tabla de liquidacion de consumo.
        BEGIN
            NULL;
            ldc_detallefact_gascaribe.RfRangosConsumo (CURANGOS);
            pkg_traza.trace(csbMetodo||' fin consulta de datos rangos de consumo ', csbNivelTraza);
        EXCEPTION
            WHEN OTHERS
            THEN
                pkg_error.SETERROR;
                pkg_error.GETERROR (ONUERRORCODE, OSBERRORMESSAGE);
                ONUERRORCODE := -1;
                OSBERRORMESSAGE := 'Error Consultando datos rangos de consumo: ' || OSBERRORMESSAGE || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
                pkg_traza.trace(csbMetodo||' OSBERRORMESSAGE: ' || OSBERRORMESSAGE, csbNivelTraza);
        END;

        --Bloque para la consulta de codigo de barras
        BEGIN
            sbCodigoEAN :=  dald_parameter.fsbGetValue_Chain ('COD_EAN_CODIGO_BARRAS');
            pkg_traza.trace(csbMetodo||' sbCodigoEAN: '||sbCodigoEAN, csbNivelTraza);
            OPEN CUCODBAR FOR
                SELECT codigo_1,
                       codigo_2,
                       codigo_3,
                       codigo_4,
                       CASE
                           WHEN codigo_3 IS NOT NULL THEN
                               '(415)'
                               || CODIGO_1
                               || '(8020)'
                               || CODIGO_2
                               || '(3900)'
                               || CODIGO_3
                               || '(96)'
                               || CODIGO_4
                           ELSE  NULL
                       END  codigo_barras,
                       CASE
                           WHEN CODIGO_3 IS NOT NULL THEN
                               FSBCARACODIBARR128GRQ ('415'
                                                       || CODIGO_1
                                                       || '8020'
                                                       || CODIGO_2
                                                       || 's3900'
                                                       || CODIGO_3
                                                       || 's96'
                                                       || CODIGO_4)
                           ELSE  NULL
                       END codigo_barras_ascii
                  FROM (SELECT sbCodigoEAN                         codigo_1,
                               LPAD (CUPONUME, 10, '0')            Codigo_2,
                               LPAD (ROUND (cupovalo), 10, '0')    codigo_3,
                               TO_CHAR (ADD_MONTHS (cucofeve, 120),  'yyyymmdd')                codigo_4
                          FROM factura, cuencobr, cupon
                         WHERE cupodocu = factcodi
                           AND cuponume = ONUCUPONUME
                           AND factcodi = cucofact
                        UNION
                        SELECT NULL, ' ', NULL, ' ' FROM DUAL)
                 WHERE ROWNUM = 1;
        EXCEPTION
            WHEN OTHERS THEN
                pkg_error.SETERROR;
                pkg_error.GETERROR (ONUERRORCODE, OSBERRORMESSAGE);
                ONUERRORCODE := -1;
                OSBERRORMESSAGE := 'Error Consultando datos totales: ' || OSBERRORMESSAGE || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
                pkg_traza.trace(csbMetodo||' OSBERRORMESSAGE: ' || OSBERRORMESSAGE, csbNivelTraza);
        END;

        --Bloque para la consulta de tasas de cambio
        BEGIN
            LDC_DetalleFact_GasCaribe.rfGetValRates (CUTASACAMB);
            pkg_traza.trace(csbMetodo||' fin consulta de tasas de cambio ', csbNivelTraza);
        EXCEPTION
            WHEN OTHERS
            THEN
                pkg_error.SETERROR;
                pkg_error.GETERROR (ONUERRORCODE, OSBERRORMESSAGE);
                ONUERRORCODE := -1;
                OSBERRORMESSAGE := 'Error Consultando datos totales: ' || OSBERRORMESSAGE || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
                pkg_traza.trace(csbMetodo||' OSBERRORMESSAGE: ' || OSBERRORMESSAGE, csbNivelTraza);
        END;

        --Bloque para la consulta de tarifas
        BEGIN
            LDCI_PKFACTKIOSCO_GDC.prcConsultaDatosAdicgdc (CUOTROS);
            pkg_traza.trace(csbMetodo||' fin consulta de tarifas ', csbNivelTraza);
        EXCEPTION
            WHEN OTHERS THEN
                pkg_error.SETERROR;
                pkg_error.GETERROR (ONUERRORCODE, OSBERRORMESSAGE);
                ONUERRORCODE := -1;
                OSBERRORMESSAGE := 'Error Consultando datos totales: ' || OSBERRORMESSAGE || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
                pkg_traza.trace(csbMetodo||' OSBERRORMESSAGE: ' || OSBERRORMESSAGE, csbNivelTraza);
        END;

        --CASO 200-1515
        OPEN CUMARCAS FOR
            SELECT visible, impreso
              FROM (SELECT dald_parameter.fnuGetNumeric_Value (
                               'DUPLICADO_WATERMARK')    AS visible,
                           G.NAME_                       AS impreso
                      FROM GE_PERSON G
                     WHERE G.PERSON_ID = PKG_BOPERSONAL.FNUGETPERSONAID)
             WHERE ROWNUM = 1;

        --FIN CASO

        PRCCIERRACURSOR (CUDATOSBASIC);
        PRCCIERRACURSOR (CUREVISION);
        PRCCIERRACURSOR (CUCONCEPT);
        PRCCIERRACURSOR (CUHISTORICO);
        PRCCIERRACURSOR (CULECTURAS);
        PRCCIERRACURSOR (CUTOTALES);
        PRCCIERRACURSOR (CUCODBAR);
        PRCCIERRACURSOR (CUOTROS);
        PRCCIERRACURSOR (CURANGOS);
        PRCCIERRACURSOR (CUCOMPCOST);
        PRCCIERRACURSOR (CUTASACAMB);
        PRCCIERRACURSOR (CUMARCAS);                            --CASO 200-1515

        --Se Consulta si el contrato se encuentra en proceso de facturacion
        OSBPROCFACT := 'N';
        pkg_traza.trace(csbMetodo||' OSBPROCFACT: '||OSBPROCFACT, csbNivelTraza);

        osbImprimir := LDCI_PKFACTKIOSCO_GDC.FSBORDENIMPRIME (inuSusccodi, isbTipoSaldo);
        pkg_traza.trace(csbMetodo||' osbImprimir: '||osbImprimir, csbNivelTraza);

        --se consulta si tiene una orden de suspencion en proceso
        osbOrdenSusp := fsbOrdenSuspContrato (inuSusccodi);
        pkg_traza.trace(csbMetodo||' osbOrdenSusp: '||osbOrdenSusp, csbNivelTraza);
        --Se confirma la creacion del cupon, y demas transacciones de los apis

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN ERROR_GENERA THEN
            ROLLBACK;
            pkg_traza.trace(csbMetodo||' ERROR WHEN ERROR_GENERA ', csbNivelTraza);
            pkg_error.seterror;
            pkg_error.geterror (onuErrorCode, osbErrorMessage);
            PRCCIERRACURSOR (CUDATOSBASIC);
            PRCCIERRACURSOR (CUREVISION);
            PRCCIERRACURSOR (CUCONCEPT);
            PRCCIERRACURSOR (CUHISTORICO);
            PRCCIERRACURSOR (CULECTURAS);
            PRCCIERRACURSOR (CUTOTALES);
            PRCCIERRACURSOR (CUCODBAR);
            PRCCIERRACURSOR (CUOTROS);
            PRCCIERRACURSOR (CURANGOS);
            PRCCIERRACURSOR (CUCOMPCOST);
            PRCCIERRACURSOR (CUTASACAMB);
            PRCCIERRACURSOR (CUMARCAS);              --CASO 200-1515
            sbError := ' Error Generando el cupon: ' || osbErrorMessage || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN ERROR_MORA THEN
            ROLLBACK;
            pkg_traza.trace(csbMetodo||' ERROR WHEN ERROR_MORA ', csbNivelTraza);
            pkg_error.seterror;
            pkg_error.geterror (onuErrorCode, osbErrorMessage);
            PRCCIERRACURSOR (CUDATOSBASIC);
            PRCCIERRACURSOR (CUREVISION);
            PRCCIERRACURSOR (CUCONCEPT);
            PRCCIERRACURSOR (CUHISTORICO);
            PRCCIERRACURSOR (CULECTURAS);
            PRCCIERRACURSOR (CUTOTALES);
            PRCCIERRACURSOR (CUCODBAR);
            PRCCIERRACURSOR (CUOTROS);
            PRCCIERRACURSOR (CURANGOS);
            PRCCIERRACURSOR (CUCOMPCOST);
            PRCCIERRACURSOR (CUTASACAMB);
            PRCCIERRACURSOR (CUMARCAS);                        --CASO 200-1515
            sbError := ' Error consultando el interes de mora: ' || osbErrorMessage || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN pkg_error.CONTROLLED_ERROR THEN
            ROLLBACK;
            pkg_traza.trace(csbMetodo||' ERROR WHEN pkg_error.CONTROLLED_ERROR', csbNivelTraza);
            pkg_error.geterror (onuErrorCode, osbErrorMessage);
            sbError := ' Error: '|| sbError || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            pkg_traza.trace(csbMetodo||' sbError: ' || osbErrorMessage, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            ROLLBACK;
            pkg_traza.trace(csbMetodo||' ERROR WHEN OTHERS ', csbNivelTraza);
            pkg_error.seterror;
            pkg_error.geterror (onuErrorCode, osbErrorMessage);
            PRCCIERRACURSOR (CUDATOSBASIC);
            PRCCIERRACURSOR (CUREVISION);
            PRCCIERRACURSOR (CUCONCEPT);
            PRCCIERRACURSOR (CUHISTORICO);
            PRCCIERRACURSOR (CULECTURAS);
            PRCCIERRACURSOR (CUTOTALES);
            PRCCIERRACURSOR (CUCODBAR);
            PRCCIERRACURSOR (CUOTROS);
            PRCCIERRACURSOR (CURANGOS);
            PRCCIERRACURSOR (CUCOMPCOST);
            PRCCIERRACURSOR (CUTASACAMB);
            PRCCIERRACURSOR (CUMARCAS);                        --CASO 200-1515
            sbError := ' Error generando la informacion a imprimir en la factura: ' || osberrormessage || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
    END PROGENERAFACTGDC;

    ----CASO 200-1626
    /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     :   FnuGetSaldoAnterior
    Descripcion :   Servicio que permitira obtener el saldo anterior de un suscriptor
    Autor       :   Jorge valiente

    Historia de Modificaciones
    Fecha       Autor          Modificacion
    ==========  =========      ====================
  14-09-2023  cgonzalez    OSF-1565: Se cursor para consultar cuentas donde el saldo pendiente
                sea mayor al valor en reclamo y el valor en reclamo de pago no abonado
    13/12/2023  adrianavg      OSF-1819: Se ajusta el nombre de esta función por el correcto de fnuGetProducto por FnuGetSaldoAnterior
                               Se implementa pkg_error.prInicializaError.
                               Se declaran variables para el manejo de traza y de error.
                               Ajustar bloque de exceptions según las pautas técnicas
    **************************************************************************/
    FUNCTION FnuGetSaldoAnterior (InuContrato NUMBER, InuFactura NUMBER)
        RETURN NUMBER
    IS
        CURSOR cusaldoanterior IS
              SELECT (SUM (CUCOSACU) - SUM (CUCOVARE) - SUM (CUCOVRAP))    saldo_ant
                FROM servsusc, cuencobr
               WHERE sesususc = InuContrato
                 AND cuconuse = sesunuse
                 AND cucosacu > 0
                 AND cucofact != InuFactura
           AND (NVL(cucosacu,0) - NVL(cucovrap,0) - (CASE WHEN cucovare > 0 THEN cucovare ELSE 0 END) ) > 0
            GROUP BY sesunuse, sesuserv;

        rfcusaldoanterior   cusaldoanterior%ROWTYPE;

        NUsaldoanterior     NUMBER := 0;

        --variables para el manejo de trazas y de error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'FnuGetSaldoAnterior';
        sbError      VARCHAR2(4000);
        nuError      NUMBER;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);
        pkg_traza.trace(csbMetodo||' InuContrato: '||InuContrato, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' InuFactura: '||InuFactura, csbNivelTraza);

        FOR rfcusaldoanterior IN cusaldoanterior
        LOOP
            NUsaldoanterior := NUsaldoanterior + NVL (rfcusaldoanterior.saldo_ant, 0);
        END LOOP;

        pkg_traza.trace(csbMetodo||' NUsaldoanterior: '||NUsaldoanterior, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN NVL (NUsaldoanterior, 0);

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
             RETURN 0;
        WHEN OTHERS THEN
             pkg_Error.setError;
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
             RETURN 0;
    END FnuGetSaldoAnterior;

    /*****************************************************************
       Propiedad intelectual de GDC (c).

       Unidad         : fsbGetPeriodo
       Descripcion    : proceso que devuelve el perorio del diferido
       Autor          : OLSOFTWARE
       Ticket         : 590

       Parametros           Descripcion
       ============         ===================
         inunuse            producto
         inuDiferido        diferido

          Fecha           Autor               Modificacion
       =========       =========           ====================
        13/12/2023      adrianavg           OSF-1819: Se implementa pkg_error.prInicializaError.
                                            Se declaran variables para el manejo de traza y de error.
                                            Ajustar bloque de exceptions según las pautas técnicas
    *****************************************************************/
    FUNCTION fsbGetPeriodo (inunuse IN NUMBER, inuDiferido IN NUMBER)
        RETURN VARCHAR2
    IS

        sbPeriodo   VARCHAR2 (4000);

        CURSOR cuGetPeriodo IS
            SELECT ' ('
                   || TRIM (TO_CHAR (FECHA, 'Month'))
                   || '-'
                   || TO_CHAR (FECHA, 'YYYY')
                   || ')'    periodo
              FROM (SELECT ADD_MONTHS ( TO_DATE ('01/' || PEFAMES || '/' || PEFAANO),  -1) FECHA
                      FROM cargos c, perifact p
                     WHERE CARGNUSE = inunuse
                       AND CARGpefa = pefacodi
                       AND CARGDOSO = 'FD-' || TO_CHAR (inuDiferido));

        --variables para el manejo de trazas y de error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbGetPeriodo';
        sbError      VARCHAR2(4000);
        nuError      NUMBER;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);
        pkg_traza.trace(csbMetodo||' inunuse: '||inunuse, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' inuDiferido: '||inuDiferido, csbNivelTraza);

        OPEN cuGetPeriodo;
        FETCH cuGetPeriodo INTO sbPeriodo;
        CLOSE cuGetPeriodo;
        pkg_traza.trace(csbMetodo||' sbPeriodo: '||sbPeriodo, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN sbPeriodo;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
             RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
             pkg_error.setError;
             pkg_Error.getError(nuError, sbError);
             pkg_traza.trace(csbMetodo||' sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
             RAISE pkg_error.CONTROLLED_ERROR;
    END fsbGetPeriodo;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RfConcepParcial
    Descripcion    : Procedimiento para mostrar el iva y el subtotal de los no regulados.
    Autor          : Gabriel Gamarra - Horbath Technologies.

    Parametros           Descripcion
    ============         ===================

    orfcursor            Retorna los datos

    Fecha           Autor               Modificacion
    =========       =========           ====================
    28/12/2023      adrianavg           OSF-1981: Se ajusta cuDatosDiferido el parametro p_difecodi de numérico a cargos.cargdoso%TYPE
    13/12/2023      adrianavg           OSF-1819: Se implementa pkg_error.prInicializaError.
                                        Se declaran variables para el manejo de traza y de error.
                                        Se reemplaza SELECT-INTO por cursor cuIdentificacion
                                        Se reemplaza SELECT-SUM-INTO por cuSumaValorSubsidio
                                        Se reemplaza SELECT-SUM-INTO por cuValorPorcentaje
                                        Se reemplaza SELECT-SUM-INTO por cuDatosDiferido
                                        Se reemplaza SELECT-SUM-INTO por cuCargo
                                        Se reemplaza SELECT-SUM-INTO por cuCargdoso
                                        Se reemplaza SELECT-SUM-INTO por cuDifesape
                                        Se retira nuAplicaEntrega200342. En el DECODE del INSERT INTO LDC_CONC_FACTURA_TEMP se asigna directo tbCargosOrdered (i).servicio),
                                        Se retira IF-ENDIF FBLAPLICAENTREGAXCASO ('0000501')
                                        Se retira IF-ENDIF sbAplicaso501 = 'N', Y la parte del ELSE, porque FBLAPLICAENTREGAXCASO ('0000501') arroja N, por lo tanto sbAplicaso501 es N
                                        Ajustar bloque de exceptions según las pautas técnicas
    18/12/2020       olsoftware         CA 590 se agrupa conceptos de los alivios por res covid.
    18/04/2020       ESANTIAGO          CA 234 se cambia el borrado a la tabla temporal tblProdDife para limpiar los campos con null.

    18/04/2019       ELAL               CA 200-2032 se modifica para que se quite el saldo del concepto 832 y se coloque a los conceptos de brilla

    22/02/2018      Jorge Valiente      CASO 200-1626: Se realizo el copiado de este servicio desde el fuente
                                                       orginal del paquete ldc_detallefact_gascaribe antes de este caso
                                                       y el CASO 200-1360
    18-10-2016      Sandra Muñoz.       CA200-849: Se acumula en el total del diferido para que sume
                                        el valor de los diferidos que aun no se estan facturando
    12-09-2016      Sandra Muñoz        CA200-342: Se llena el campo servicio para poder usarlo
                                        para agrupar los conceptos de brilla
    17/12/2015      Agordillo           Modificacion SAO.369165
                                        Se agrega un IF que permite validar si el servicio es 7053,
                                        se asigne null al saldo pendiente y numero de cuotas al diferido dado
                                        que esta informacion no se muestra en la factura
    05/08/2015      Mmejia              Modificacion Aranda.8199 Se traslada la logica que valida los diferidos
                                        que no estan asociados a una cuenta cobro para que se procese antes de
                                        calcular los campos del total mes esto ya que el total mes se
                                        estaba mostrando antes de estos registros en la impresion de la  factura.
    25/06/2015      Mmejia              Modificacion Aranda.6477 Se agrega  la logica para agregar
                                        a los detalles de factura los diferidos que no estan asociados
                                        a una cuenta de cobro.
    19/03/2015      Agordillo           Modificacion Incidente.140493
                                        * Se agrega una condicion cuando se esta agrupando los diferidos para que diferencie
                                        por causa de cargo, dado que a este concepto es al unico que se le muestra el saldo
                                        del diferido, intereses y cuotas pendiente.
                                        * Se agrega una condicion para que se inserte los cargos que son Diferidos pero no
                                        tienen causa de cargo 51-Cuota
                                        * Se agrega una condicion cuando el cargo es interes de un diferido para que solo se
                                        muestre en el cargo si es cuota.
    12/03/2015      Agordillo           Modificacion Incidente.143745
                                        * Se modifica el type tyrcCargosOrd para agrecar el campo signo
                                        * Se modifica para que en la tabla tbCargosOrdered que contiene los cargos
                                        ordenados se agrege el signo del cargo(DB,CR,SA,PA) etc.
                                        * Se cambia la insercion a la tabla LDC_CONC_FACTURA_TMP por LDC_CONC_FACTURA_TEMP
                                        dado que la primera tabla no tiene campo de signo
                                        * Se cambia la forma de insercion en la tabla LDC_CONC_FACTURA_TEMP definiendole
                                        los campos a insertar,para que en posteriores modificaciones de esta no exista
                                        problema para adicionar un nuevo campo y afecte los objetos que tambien la utilicen.
                                        * Se modifica el IF para acumular los totales (tbCargosOrdered(-1).TOTAL)
                                        en usuarios no regulados para que no tenga en cuenta los pagos signo (PA)
    11/11/2014      ggamarra           Creacion.
    ******************************************************************/

    PROCEDURE RfConcepParcial (InuContrato   NUMBER,
                               InuFactura    NUMBER,
                               orfcursor     OUT constants_per.tyRefCursor)
    IS
        sbFactcodi                       ge_boInstanceControl.stysbValue;
        sbFactsusc                       ge_boInstanceControl.stysbValue;
        blNRegulado                      BOOLEAN;
        nuServicio                       servsusc.sesuserv%TYPE; -- Agordillo SAO.369165

        TYPE tyrcCargos IS RECORD
        (
            CARGCUCO    cargos.CARGCUCO%TYPE,
            CARGNUSE    cargos.CARGNUSE%TYPE,
            SERVCODI    servicio.SERVCODI%TYPE,
            SERVDESC    servicio.SERVDESC%TYPE,
            CARGCONC    cargos.CARGCONC%TYPE,
            CONCDEFA    concepto.CONCDEFA%TYPE,
            CARGCACA    cargos.CARGCACA%TYPE,
            CARGSIGN    cargos.CARGSIGN%TYPE,
            CARGPEFA    cargos.CARGPEFA%TYPE,
            CARGVALO    cargos.CARGVALO%TYPE,
            CARGDOSO    cargos.CARGDOSO%TYPE,
            CARGCODO    cargos.CARGCODO%TYPE,
            CARGUNID    cargos.CARGUNID%TYPE,
            CARGFECR    cargos.CARGFECR%TYPE,
            CARGPROG    cargos.CARGPROG%TYPE,
            CARGPECO    cargos.CARGPECO%TYPE,
            CARGTICO    cargos.CARGTICO%TYPE,
            CARGVABL    cargos.CARGVABL%TYPE,
            CARGTACO    cargos.CARGTACO%TYPE,
            ORDEN       NUMBER
        );

        TYPE tytbCargos IS TABLE OF tyrcCargos
            INDEX BY BINARY_INTEGER;

        tbCargos                         tytbCargos;
        tbCargosNull                     tytbCargos;

        TYPE tyrcCargosOrd IS RECORD
        (
            ETIQUETA       VARCHAR2 (3),
            CONCEPTO_ID    NUMBER,
            CONCEPTOS      VARCHAR2 (60),
            SIGNO          VARCHAR2 (10),       -- Agordilllo Incidente.143745
            ORDEN          NUMBER,
            SALDO_ANT      NUMBER,
            CAPITAL        NUMBER,
            INTERES        NUMBER,
            TOTAL          NUMBER,
            SALDO_DIF      NUMBER,
            CUOTAS         NUMBER,
            CAR_DOSO       VARCHAR2 (100),      -- Agordilllo Incidente.140493
            CAR_CACA       NUMBER,
            servicio       NUMBER                                -- CA 200-342
        );                                      -- Agordilllo Incidente.140493

        TYPE tytbFinal IS TABLE OF tyrcCargosOrd
            INDEX BY BINARY_INTEGER;

        tbCargosOrdered                  tytbFinal;
        tbFinalNull                      tytbFinal;

        sbConcIVA                        VARCHAR2 (2000) := '137|287|586|616';
        sbConcRecamora                   VARCHAR2 (2000) := '153|154|155|156|157|220|284|285|286';

        nuDifesape                       NUMBER;
        nuDifecuotas                     NUMBER;
        nuInteres                        NUMBER;
        nuLastSesu                       NUMBER;
        sbDescServ                       servicio.servdesc%TYPE;
        nuConcIVA                        NUMBER := 137;
        nuConcSuministro                 NUMBER := 200;
        nuConcComercial                  NUMBER := 716;
        inx                              NUMBER;
        inxConc                          VARCHAR2 (10);
        i                                NUMBER;
        j                                NUMBER;
        k                                NUMBER;
        nuSaldoAnterior                  NUMBER;
        nuSaldoProd                      NUMBER;
        rcProduct                        servsusc%ROWTYPE;
        rcProductNull                    servsusc%ROWTYPE;
        nuPorcSubs                       NUMBER;
        sbIdentifica                     ld_policy.identification_id%TYPE;
        nuDoso                           cargos.cargdoso%TYPE;
        nutem                            NUMBER;

        --INICIO CA 590
        nuConcSubAdi                     NUMBER   := DALD_PARAMETER.FNUGETNUMERIC_VALUE ('LDC_CONSUBADI', NULL);
        nuConcSubAdiTT                   NUMBER   := DALD_PARAMETER.FNUGETNUMERIC_VALUE ('LDC_CONSUBADITT', NULL);
        nuConcSubTT                      NUMBER   := DALD_PARAMETER.FNUGETNUMERIC_VALUE ('LDC_CONSUBTRAS', NULL);

        sbdoso196                        cargos.cargdoso%TYPE := NULL;
        nucodo196                        cargos.cargcodo%TYPE := NULL;

        CURSOR cuDosoSubsidio (nufactura     factura.factcodi%TYPE,
                               inupericose   NUMBER)
        IS
            SELECT CARGDOSO, CARGCODO
              FROM cargos, cuencobr, factura
             WHERE CUCOCODI = CARGCUCO
               AND CUCOFACT = FACTCODI
               AND FACTCODI = nufactura
               AND CARGCONC = 196
               AND cargpeco = inupericose
               AND ROWNUM = 1;

        --FIN CA 590

        CURSOR cuCargos IS
            SELECT CARGCUCO,
                   CARGNUSE,
                   SERVCODI,
                   SERVDESC,
                   DECODE (cargconc,
                           nuConcSubAdi, 196,
                           nuConcSubAdiTT, nuConcSubTT,
                           cargconc)    CARGCONC,
                   CONCDEFA,
                   CARGCACA,
                   CARGSIGN,
                   CARGPEFA,
                   CARGVALO,
                   DECODE (cargconc,
                           nuConcSubAdiTT, 'SUBTRAN' || CARGPECO,
                           nuConcSubTT, 'SUBTRAN' || CARGPECO,
                           CARGDOSO)    CARGDOSO,
                   DECODE (cargconc,
                           nuConcSubAdiTT, 0,
                           nuConcSubTT, 0,
                           CARGCODO)    CARGCODO,
                   CARGUNID,
                   CARGFECR,
                   CARGPROG,
                   CARGPECO,
                   CARGTICO,
                   CARGVABL,
                   CARGTACO,
                   ORDEN
              -- Se ordenan los productos según el orden que se requiere
              FROM cargos,
                   cuencobr,
                   servsusc,
                   concepto,
                   (SELECT DECODE (servcodi,
                                   7014, 1,
                                   6121, 2,
                                   7055, 3,
                                   7056, 4,
                                   7053, 5,
                                   7052, 6,
                                   7054, 7,
                                   99)    orden,
                           servcodi,
                           servdesc
                      FROM servicio) Serv_ord
             WHERE  cucofact = sbFactcodi
               AND cargcuco = cucocodi
               AND cargnuse = sesunuse
               AND sesuserv = servcodi
               AND DECODE (cargconc,
                           nuConcSubAdi, 196,
                            nuConcSubAdiTT, nuConcSubTT,
                            cargconc) =  conccodi
            UNION -- Se agregan los productos que no facturan en la cuenta Y tengan saldo pendiente
            SELECT -1           CARGCUCO,
                   sesunuse     CARGNUSE,
                   SERVCODI,
                   SERVDESC,
                   -1           CARGCONC,
                   NULL         CONCDEFA,
                   -1           CARGCACA,
                   'XX'         CARGSIGN,
                   -9999        CARGPEFA,
                   0            CARGVALO,
                   '-'          CARGDOSO,
                   0            CARGCODO,
                   0            CARGUNID,
                   SYSDATE      CARGFECR,
                   NULL         CARGPROG,
                   NULL         CARGPECO,
                   NULL         CARGTICO,
                   NULL         CARGVABL,
                   NULL         CARGTACO,
                   ORDEN
              -- Se ordenan los productos según el orden que se requiere
              FROM servsusc,
                   (SELECT DECODE (servcodi,
                                   7014, 1,
                                   6121, 2,
                                   7055, 3,
                                   7056, 4,
                                   7053, 5,
                                   7052, 6,
                                   7054, 7,
                                   99)    orden,
                           servcodi,
                           servdesc
                     FROM servicio) Serv_ord
             WHERE sesususc = sbFactsusc
               AND sesuserv = servcodi
               AND pkbccuencobr.fnugetoutstandbal (sesunuse) > 0
            ORDER BY
                orden,
                cargnuse,
                cargpefa DESC,
                cargdoso;

        --INICIO CA 379
        sbPlanCon                        VARCHAR2 (4000)  :=    ','  || DALD_PARAMETER.FSBGETVALUE_CHAIN ('LDC_PLANCOCF', NULL) || ',';
        sbPlanOtr                        VARCHAR2 (4000)  :=    ','  || DALD_PARAMETER.FSBGETVALUE_CHAIN ('LDC_PLANOTCO', NULL) || ',';
        sbDescCon                        VARCHAR2 (4000)  := DALD_PARAMETER.FSBGETVALUE_CHAIN ('LDC_DESCPLCO', NULL);
        sbDescOtrco                      VARCHAR2 (4000)  := DALD_PARAMETER.FSBGETVALUE_CHAIN ('LDC_DESCPLOC', NULL);
        sbconcdefa                       concepto.concdefa%TYPE;
        --FIN CA 379

        CURSOR cuDiferidos IS
            SELECT d.DIFECODI    DIFECODI,
                   d.DIFESUSC    DIFESUSC,
                   d.DIFECONC    DIFECONC,
                   d.DIFEVATD    DIFEVATD,
                   d.DIFEVACU    DIFEVACU,
                   d.DIFECUPA    DIFECUPA,
                   d.DIFENUCU    DIFENUCU,
                   d.DIFESAPE    DIFESAPE,
                   d.DIFENUDO    DIFENUDO,
                   d.DIFEINTE    DIFEINTE,
                   d.DIFEINAC    DIFEINAC,
                   d.DIFEUSUA    DIFEUSUA,
                   d.DIFETERM    DIFETERM,
                   d.DIFESIGN    DIFESIGN,
                   d.DIFENUSE    DIFENUSE,
                   d.DIFEMECA    DIFEMECA,
                   d.DIFECOIN    DIFECOIN,
                   d.DIFEPROG    DIFEPROG,
                   d.DIFEPLDI    DIFEPLDI,
                   d.DIFEFEIN    DIFEFEIN,
                   d.DIFEFUMO    DIFEFUMO,
                   d.DIFESPRE    DIFESPRE,
                   d.DIFETAIN    DIFETAIN,
                   d.DIFEFAGR    DIFEFAGR,
                   d.DIFECOFI    DIFECOFI,
                   d.DIFETIRE    DIFETIRE,
                   d.DIFEFUNC    DIFEFUNC,
                   d.DIFELURE    DIFELURE,
                   d.DIFEENRE    DIFEENRE,
                   c.CONCCODI    CONCCODI,
                   c.CONCDESC    CONCDESC,
                   c.CONCCOCO    CONCCOCO,
                   c.CONCORLI    CONCORLI,
                   c.CONCPOIV    CONCPOIV,
                   c.CONCORIM    CONCORIM,
                   c.CONCORGE    CONCORGE,
                   c.CONCDIFE    CONCDIFE,
                   c.CONCCORE    CONCCORE,
                   c.CONCCOIN    CONCCOIN,
                   c.CONCFLDE    CONCFLDE,
                   c.CONCUNME    CONCUNME,
                   (CASE
                        WHEN INSTR (sbPlanCon, ',' || d.DIFEPLDI || ',') > 0  THEN   sbDescCon || fsbGetPeriodo (d.difenuse, d.difecodi)
                        WHEN INSTR (sbPlanOtr, ',' || d.DIFEPLDI || ',') > 0  THEN   sbDescOtrco || fsbGetPeriodo (d.difenuse, d.difecodi)
                        ELSE  c.CONCDEFA
                    END)         CONCDEFA,
                   c.CONCFLIM    CONCFLIM,
                   c.CONCSIGL    CONCSIGL,
                   c.CONCTICO    CONCTICO,
                   c.CONCNIVE    CONCNIVE,
                   c.CONCCLCO    CONCCLCO,
                   c.CONCTICC    CONCTICC,
                   c.CONCTICL    CONCTICL,
                   c.CONCAPPR    CONCAPPR,
                   c.CONCCONE    CONCCONE,
                   c.CONCAPCP    CONCAPCP
              FROM diferido D, concepto C
             WHERE DIFESUSC = sbfactsusc
               AND DIFESAPE > 0
               AND difeconc = conccodi;

        SUBTYPE stytbcuDiferidos IS cuDiferidos%ROWTYPE;

        TYPE tytbcuDiferidos IS TABLE OF stytbcuDiferidos
            INDEX BY BINARY_INTEGER;

        tdiferidos                       tytbcuDiferidos;

        TYPE tytbNumber IS TABLE OF NUMBER
            INDEX BY BINARY_INTEGER;

        TYPE tytbVarchar IS TABLE OF NUMBER
            INDEX BY VARCHAR2 (10);

        gtbFinancion                     tytbNumber;
        gtbConceptos                     tytbVarchar;
        nuIndex                          NUMBER := 0;

        ----------------------------------------------------------------------
        -- Variables
        ----------------------------------------------------------------------
        gsbTotal                         VARCHAR2 (50);
        gsbIVANoRegulado                 VARCHAR2 (50);
        gsbSubtotalNoReg                 VARCHAR2 (50);
        gsbCargosMes                     VARCHAR2 (50);
        gnuConcNumber                    NUMBER;

        --INICIO CA 200-2032
        nuCodiFactProt                   NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE ('LDC_CODCONCSEGUPROT',  NULL); -- se lamacena codigo de factura protegida
        sbDescriConBri                   VARCHAR2 (150) := DALD_PARAMETER.FSBGETVALUE_CHAIN ('LDC_DESCCONCCREDBRIL',  NULL);
        nuSaldoDife                      NUMBER;
        nuContCon                        NUMBER := 0;
        nuIndeBri                        NUMBER := 1;

        TYPE tytProducDiferidos IS RECORD
        (
            nuProducto     NUMBER,
            nuSaldoDife    NUMBER,
            nuCuota        NUMBER
        );

        TYPE tytbProduDife IS TABLE OF tytProducDiferidos
            INDEX BY BINARY_INTEGER;

        tblProdDife                      tytbProduDife;
        --FIN CA 200-2032

        --variables para el manejo de trazas y de error
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'RfConcepParcial';
        sbError      VARCHAR2(4000);
        nuError      NUMBER;

        CURSOR cuIdentificacion( p_product_id ld_policy.product_id%TYPE)
        IS
        SELECT identification_id
          FROM ld_policy
         WHERE product_id = p_product_id;

        CURSOR cuSumaValorSubsidio(p_ralicodo rangliqu.ralicodo%TYPE )
        IS
        SELECT SUM (ralivasu) * 100 / SUM (ralivaul)
          FROM rangliqu
         WHERE ralicodo = p_ralicodo
           AND ralivasu > 0;

        CURSOR cuValorPorcentaje(p_vitctaco ta_vigetaco.vitctaco%TYPE,
                                 p_pecscons pericose.pecscons%TYPE)
        IS
        SELECT tav.vitcporc
         FROM ta_vigetaco tav, pericose pe
        WHERE tav.vitctaco = p_vitctaco
           AND pe.pecscons = p_pecscons
           AND pe.pecsfecf BETWEEN tav.vitcfein AND tav.vitcfefi
           AND tav.vitcvige = 'S'
           AND ROWNUM = 1;

        CURSOR cuDatosDiferido(p_difecodi cargos.cargdoso%TYPE,
                               p_sbconcdefa concepto.CONCDEFA%TYPE)
        IS
        SELECT DECODE (difesign, 'DB', difesape,  -1 * difesape), (difenucu - difecupa),
               (CASE
                    WHEN INSTR (sbPlanCon, ',' || DIFEPLDI || ',') > 0  THEN sbDescCon  || fsbGetPeriodo (difenuse, difecodi)
                    WHEN INSTR (sbPlanOtr, ',' || DIFEPLDI || ',') > 0  THEN sbDescOtrco|| fsbGetPeriodo (difenuse, difecodi)
                    ELSE p_sbconcdefa
                END) --379 Se agrupan conceptos por planes
          FROM diferido
         WHERE difecodi =  SUBSTR ( p_difecodi, 4, LENGTH (p_difecodi) - 3);

         CURSOR cuCargo(p_cargdoso cargos.cargdoso%TYPE,
                        p_cargcuco cargos.cargcuco%TYPE)
         IS
         SELECT DECODE (cargsign, 'DB', cargvalo,  -1 * cargvalo)
           FROM cargos
          WHERE cargdoso = 'ID-' || SUBSTR (p_cargdoso, 4, LENGTH ( p_cargdoso) - 3)
            AND cargcuco = p_cargcuco;

        CURSOR cuCargdoso(p_cargdoso cargos.cargdoso%TYPE,
                          p_cargcuco cargos.cargcuco%TYPE)
        IS
        SELECT cargdoso
          FROM cargos
         WHERE cargdoso = 'DF-' || SUBSTR (p_cargdoso, 4,  LENGTH (p_cargdoso) - 3)
           AND cargcuco = p_cargcuco
           AND cargcaca = 51; -- Agordillo Incidente 140493

       CURSOR cuDifesape(p_cargdoso cargos.cargdoso%TYPE)
       IS
        SELECT DECODE (difesign, 'DB', difesape, -1 * difesape)
          FROM diferido
         WHERE difecodi =  SUBSTR (p_cargdoso , 4,  LENGTH (p_cargdoso) - 3);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( nuError, sbError);
        pkg_traza.trace(csbMetodo||' InuContrato: '||InuContrato, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' InuFactura: '||InuFactura, csbNivelTraza);

        -- Obtiene el identificador de la factura instanciada
        sbFactcodi := InuFactura;
        sbFactsusc := InuContrato;
        blNRegulado := ldc_detallefact_gascaribe.fblNoRegulado (sbFactsusc);
        nuLastSesu := -1;
        inx := 1;

        gsbTotal := NULL;
        gsbIVANoRegulado := NULL;
        gsbSubtotalNoReg := NULL;
        gsbCargosMes := NULL;
        gnuConcNumber := 0;

        tbCargos := tbCargosNull;
        tbCargosOrdered := tbFinalNull;

        OPEN cuCargos;
        FETCH cuCargos BULK COLLECT INTO tbCargos;
        CLOSE cuCargos;

        IF NOT blNRegulado THEN
            pkg_traza.trace(csbMetodo||' Crear detalles para los regulados ', csbNivelTraza);

            i := tbCargos.FIRST;
            LOOP
                pkg_traza.trace(csbMetodo||' Va en i: '||i, csbNivelTraza);
                EXIT WHEN i IS NULL;

                -- Inicio CA 200-342
                pkg_traza.trace(csbMetodo||' -->***<--', csbNivelTraza);
        tbCargosOrdered (inx).servicio := tbCargos (i).servcodi;
                pkg_traza.trace(csbMetodo||' -->tbCargosOrdered(inx).servicio: '||tbCargosOrdered(inx).servicio, csbNivelTraza);

        tbCargosOrdered (-1).servicio := tbCargos (i).servcodi; -- Total servicio
                pkg_traza.trace(csbMetodo||' -->Total servicio: '||tbCargosOrdered(-1).servicio, csbNivelTraza);

        tbCargosOrdered (-2).servicio := tbCargos (i).servcodi; -- IVA
                pkg_traza.trace(csbMetodo||' -->IVA: '||tbCargosOrdered(-2).servicio, csbNivelTraza);

        tbCargosOrdered (-3).servicio := tbCargos (i).servcodi; -- Recargo por mora
                pkg_traza.trace(csbMetodo||' -->Recargo por mora: '||tbCargosOrdered(-3).servicio, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->***<--', csbNivelTraza);
                -- Fin CA 200-342
                pkg_traza.trace(csbMetodo||' -->***<--', csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Cuenta de cobro: '||tbCargos(i).Cargcuco, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Numero del servicio: '||tbCargos(i).cargnuse, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Codigo servicios comunicacion: '||tbCargos(i).servcodi, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Descripción servicio: '||tbCargos(i).servdesc, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Concepto: '||tbCargos (i).cargconc, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Concepto facturacion: '||tbCargos (i).concdefa, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Causa del cargo: '||tbCargos (i).cargcaca, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Signo: '||tbCargos (i).cargsign, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Periodo facturacion: '||tbCargos(i).cargpefa, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Valor del cargo: '||tbCargos(i).cargvalo, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Documento de soporte: '||tbCargos(i).cargdoso, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Consecutivo del documento: '||tbCargos (i).cargcodo, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Unidades: '||tbCargos (i).CARGUNID, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Fecha de creacion: '||tbCargos (i).CARGFECR, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Fecha de creacion: '||tbCargos (i).CARGFECR, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Programa: '||tbCargos(i).CARGPROG, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Periodo de consumo: '||tbCargos (i).cargpeco, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Tipo De Consumo: '||tbCargos (i).CARGTICO, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Valor Base de Liquidación: '||tbCargos (i).CARGVABL, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Id de la entidad tarifas por concepto: '||tbCargos (i).cargtaco, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->Orden: '||tbCargos (i).ORDEN, csbNivelTraza);
                pkg_traza.trace(csbMetodo||' -->***<--', csbNivelTraza);

                -- Imprime encabezado si cambia de servicio suscrito
                IF nuLastSesu <> tbCargos (i).cargnuse THEN
                   pkg_traza.trace(csbMetodo||' Imprime encabezado si cambia de servicio suscrito', csbNivelTraza);
                    rcProduct :=  pktblservsusc.frcgetrecord (tbCargos (i).cargnuse);
                    pkboinstanceprintingdata.instancecurrentproduct ( rcProduct);
                    nuSaldoAnterior :=  pkbobillprintprodrules.fsbgetpreviousbalance;
                    pkg_traza.trace(csbMetodo||' nuSaldoAnterior: '||nuSaldoAnterior, csbNivelTraza);

                    pkboinstanceprintingdata.instancecurrentproduct (rcProductNull);
                    nuSaldoProd := pkbccuencobr.fnugetoutstandbal ( tbCargos (i).cargnuse);
                    pkg_traza.trace(csbMetodo||' nuSaldoProd: '||nuSaldoProd, csbNivelTraza);

                    IF (tbCargos (i).cargpefa = -9999 AND nuSaldoProd > 0)
                       OR tbCargos (i).cargpefa <> -9999
                       THEN

                       tbCargosOrdered (inx).ETIQUETA := '31';

                        IF tbCargos (i).servcodi IN (7055, 7056)  THEN
                            tbCargosOrdered (inx).CONCEPTOS :=  UPPER (tbCargos (i).servdesc)
                                || ' (Serv.Susc.'
                                || tbCargos (i).cargnuse
                                || ')';
                        ELSE
                            tbCargosOrdered (inx).CONCEPTOS :=  'SERV.'
                                || UPPER (tbCargos (i).servdesc)
                                || ' (Serv.Susc.'
                                || tbCargos (i).cargnuse
                                || ')';
                        END IF;

                        inx := inx + 1;

                        -- Inicio CA 200-342
                        tbCargosOrdered (inx).servicio := tbCargos (i).servcodi;
                        -- Fin CA 200-342

                        -- Se crea la linea de saldo anterior si tiene
                        IF NVL (nuSaldoAnterior, 0) > 0 THEN
                            tbCargosOrdered (inx).ETIQUETA := '32';
                            tbCargosOrdered (inx).CONCEPTOS := 'Saldo Anterior';
                            tbCargosOrdered (inx).SALDO_ANT :=   nuSaldoAnterior;
                            inx := inx + 1;
                        ELSE
                            -- El producto no tiene cargos, muestra el saldo para que salga en el detalle
                            IF tbCargos (i).cargpefa = -9999   THEN
                                tbCargosOrdered (inx).ETIQUETA := '32';
                                tbCargosOrdered (inx).CONCEPTOS := 'Saldo Anterior';
                                tbCargosOrdered (inx).SALDO_ANT :=  nuSaldoProd;
                                inx := inx + 1;
                            END IF;
                        END IF;

                        -- Inicio CA 200-342
                        tbCargosOrdered (inx).servicio := tbCargos (i).servcodi;

                        -- Fin CA 200-342

                        -- Crea el detalle de totales
                        tbCargosOrdered (-1).ETIQUETA := '33';
                        tbCargosOrdered (-1).CAR_DOSO := tbCargos (i).SERVCODI; -- Agordillo Incidente 140493
                        tbCargosOrdered (-1).CONCEPTOS := 'Total Servicio:';
                        tbCargosOrdered (-1).CAPITAL := 0;
                        tbCargosOrdered (-1).INTERES := 0;
                        tbCargosOrdered (-1).TOTAL := 0;
                        tbCargosOrdered (-1).SALDO_DIF := 0;

                        -- Crea el acumulado de IVA
                        tbCargosOrdered (-2).ETIQUETA := '32';
                        tbCargosOrdered (-2).CONCEPTOS := 'IVA';
                        tbCargosOrdered (-2).CAPITAL := 0;

                        -- Crea el acumulado de Recargo por mora
                        tbCargosOrdered (-3).ETIQUETA := '32';
                        tbCargosOrdered (-3).CONCEPTOS := 'x';
                        tbCargosOrdered (-3).INTERES := 0;
                        tbCargosOrdered (-3).CAR_DOSO := tbCargos (i).SERVCODI; -- Agordillo Incidente 140493
                    END IF;
                END IF;

                -- Crea los detalles
                -- se cambian los valores según los signos, no se estan teniendo en cuenta SA
                IF tbCargos (i).cargsign IN ('CR', 'AS', 'PA') THEN
                   tbCargos (i).cargvalo := -1 * tbCargos (i).cargvalo;
                ELSIF tbCargos (i).cargsign IN ('DB')  THEN
                   tbCargos (i).cargvalo := tbCargos (i).cargvalo;
                ELSE
                   tbCargos (i).cargvalo := 0;
                END IF;
                pkg_traza.trace(csbMetodo||' Cambian los valores según los signos, Valor del cargo: '||tbCargos(i).cargvalo, csbNivelTraza);

                -- Modificación de las descripciones de los conceptos
                CASE
                    -- Si el concepto es prima seguros se agrega la cedula
                    WHEN tbCargos (i).SERVCODI IN (7053)
                         AND INSTR ('|' || sbConcIVA || '|',
                                    '|' || tbCargos (i).cargconc || '|') =  0
                         AND INSTR ('|' || sbConcRecamora || '|',
                                    '|' || tbCargos (i).cargconc || '|') =  0
                         AND SUBSTR (tbCargos (i).cargdoso, 0, 3) NOT IN ('ID-', 'DF-')
                    THEN
                        pkg_traza.trace(csbMetodo||' Si el concepto es prima seguros se agrega la cedula ', csbNivelTraza);
                        BEGIN
                             OPEN cuIdentificacion(tbCargos (i).cargnuse);
                            FETCH cuIdentificacion INTO sbIdentifica;
                            CLOSE cuIdentificacion;
                            pkg_traza.trace(csbMetodo||' sbIdentifica: '||sbIdentifica, csbNivelTraza);

                            tbCargos (i).CONCDEFA :=  tbCargos (i).CONCDEFA || ' CC: ' || sbIdentifica;
                            pkg_traza.trace(csbMetodo||' Concepto facturacion: '||tbCargos (i).CONCDEFA, csbNivelTraza);
                        EXCEPTION
                            WHEN OTHERS THEN
                                 NULL;
                        END;
                        pkg_traza.trace(csbMetodo||' Fin si el concepto es prima seguros se agrega la cedula ', csbNivelTraza);
                    -- Si el concepto es subsidio se agrega el %
                    WHEN tbCargos (i).SERVCODI IN (7014) AND tbCargos (i).cargconc = 196  THEN
                            pkg_traza.trace(csbMetodo||' Si el concepto es subsidio se agrega el % ', csbNivelTraza);
                            BEGIN-- el sbAplicaso501 RETORNA 'N' (VALIDADO PRODUCCION) OSF-1981

                            pkg_traza.trace(csbMetodo||' cargcodo: '||tbCargos(i).cargcodo, csbNivelTraza);

                                OPEN cuSumaValorSubsidio(tbCargos(i).cargcodo);
                                FETCH cuSumaValorSubsidio INTO nuPorcSubs;
                                CLOSE cuSumaValorSubsidio;

                                pkg_traza.trace(csbMetodo||' nuPorcSubs: '||nuPorcSubs, csbNivelTraza);

                                IF tbCargos (i).cargdoso LIKE 'SU-PR%' THEN
                                   tbCargos (i).CONCDEFA :=  tbCargos (i).CONCDEFA
                                        || ' LEY 142/94(Hasta 20M3 '
                                        || ROUND (nuPorcSubs, 2)
                                        || '% Cons.) SU-'
                                        || tbCargos (i).cargunid
                                        || 'AJ-'
                                        || SUBSTR (tbCargos (i).cargdoso, 7, 6);
                                ELSE
                                    tbCargos (i).CONCDEFA :=  tbCargos (i).CONCDEFA
                                        || ' LEY 142/94(Hasta 20M3 '
                                        || ROUND (nuPorcSubs, 2)
                                        || '% Cons.)';
                                END IF;
                            pkg_traza.trace(csbMetodo||' Concepto facturacion: '||tbCargos (i).CONCDEFA, csbNivelTraza);
                            EXCEPTION
                                WHEN OTHERS THEN
                                     NULL;
                            END;
                            pkg_traza.trace(csbMetodo||' Fin si el concepto es subsidio se agrega el % ', csbNivelTraza);

                    -- Si el concepto es contribución se agrega el %
                    WHEN tbCargos (i).SERVCODI IN (7014) AND tbCargos (i).cargconc = 37
                                                         AND SUBSTR (tbCargos (i).cargdoso, 0, 3) NOT IN ('ID-', 'DF-') THEN
                        pkg_traza.trace(csbMetodo||'  Si el concepto es contribución se agrega el % ', csbNivelTraza);
                        BEGIN
                            OPEN cuValorPorcentaje(tbCargos (i).CARGTACO, tbCargos (i).CARGPECO);
                            FETCH cuValorPorcentaje INTO nuPorcSubs;
                            CLOSE cuValorPorcentaje;
                            pkg_traza.trace(csbMetodo||' nuPorcSubs: '||nuPorcSubs, csbNivelTraza);

                            IF tbCargos (i).cargdoso LIKE 'CN-PR%' THEN
                                tbCargos (i).CONCDEFA := tbCargos (i).CONCDEFA
                                    || '('
                                    || ROUND (nuPorcSubs, 2)
                                    || '% Cons. + '
                                    || ROUND (nuPorcSubs, 2)
                                    || '% C. Fijo CN-AJ-'
                                    || SUBSTR (tbCargos (i).cargdoso, 7, 6);
                            ELSE
                                tbCargos (i).CONCDEFA :=  tbCargos (i).CONCDEFA
                                    || '('
                                    || ROUND (nuPorcSubs, 2)
                                    || '% Cons. + '
                                    || ROUND (nuPorcSubs, 2)
                                    || '% C. Fijo';
                            END IF;
                            pkg_traza.trace(csbMetodo||' Concepto facturacion: '||tbCargos (i).CONCDEFA, csbNivelTraza);
                        EXCEPTION
                            WHEN OTHERS THEN
                                 NULL;
                        END;
                        pkg_traza.trace(csbMetodo||' Fin Si el concepto es contribución se agrega el % ', csbNivelTraza);

                    WHEN tbCargos (i).SERVCODI IN (7014) AND tbCargos (i).cargdoso LIKE 'CO-PR%TC%'  THEN
                         pkg_traza.trace(csbMetodo||' SERVCODI 7014 y cargdoso CO-PR%TC  % ', csbNivelTraza);
                         tbCargos (i).CONCDEFA := tbCargos (i).CONCDEFA
                            || 'CO-'
                            || tbCargos (i).cargunid
                            || 'AJ-'
                            || SUBSTR (tbCargos (i).cargdoso, 7, 6);

                          pkg_traza.trace(csbMetodo||' Concepto facturacion: '||tbCargos (i).CONCDEFA, csbNivelTraza);
                          pkg_traza.trace(csbMetodo||' fin SERVCODI 7014 y cargdoso CO-PR%TC  % ', csbNivelTraza);
                    ELSE
                        NULL;
                END CASE;

                -- Evalua primero si es concepto de Iva o Recargo por mora para acumular

                CASE   -- Acumulado de IVA
                    WHEN INSTR ('|' || sbConcIVA || '|',
                                '|' || tbCargos (i).cargconc || '|') > 0
                         AND SUBSTR (tbCargos (i).cargdoso, 0, 3) NOT IN ('ID-', 'DF-') THEN

                         pkg_traza.trace(csbMetodo||'  Acumulado de IVA ', csbNivelTraza);

                         tbCargosOrdered (-2).CAPITAL :=  tbCargosOrdered (-2).CAPITAL  + tbCargos (i).cargvalo;
                         pkg_traza.trace(csbMetodo||'  CAPITAL: '||tbCargosOrdered (-2).CAPITAL, csbNivelTraza);

                         pkg_traza.trace(csbMetodo||' Fin acumulado de IVA ', csbNivelTraza);

                    -- Acumulado Recargo por mora
                    WHEN INSTR ('|' || sbConcRecamora || '|', '|' || tbCargos (i).cargconc || '|') >  0
                         AND SUBSTR (tbCargos (i).cargdoso, 0, 3) NOT IN ('ID-', 'DF-')  THEN

                        pkg_traza.trace(csbMetodo||' Acumulado Recargo por mora ', csbNivelTraza);

                        tbCargosOrdered (-3).INTERES :=  tbCargosOrdered (-3).INTERES  + tbCargos (i).cargvalo;
                        pkg_traza.trace(csbMetodo||' INTERES: '||tbCargosOrdered (-3).INTERES, csbNivelTraza);

                        IF tbCargosOrdered (-3).CONCEPTOS = 'x' THEN
                            tbCargosOrdered (-3).CONCEPTOS := 'INTERES DE MORA(Tasa '
                                || tbCargos (i).cargunid
                                || '%)';
                        END IF;
                        pkg_traza.trace(csbMetodo||' CONCEPTOS: '||tbCargosOrdered (-3).CONCEPTOS, csbNivelTraza);

                        pkg_traza.trace(csbMetodo||' Fin acumulado Recargo por mora ', csbNivelTraza);

                    -- Arma el detalle para los demás cargos diferentes de diferidos
                    WHEN SUBSTR (tbCargos (i).cargdoso, 0, 3) NOT IN ('ID-', 'DF-')
                         AND tbCargos (i).cargsign IN ('DB', 'CR', 'PA', 'AS') THEN

                        pkg_traza.trace(csbMetodo||'  Arma el detalle para los demás cargos diferentes de diferidos ', csbNivelTraza);

                        tbCargosOrdered (inx).ETIQUETA    := '32';
                        pkg_traza.trace(csbMetodo||' ETIQUETA: '||tbCargosOrdered (inx).ETIQUETA , csbNivelTraza);

                        tbCargosOrdered (inx).CONCEPTO_ID := tbCargos (i).cargconc; -- Agordilllo Incidente.140493
                        pkg_traza.trace(csbMetodo||' CONCEPTO_ID: '||tbCargosOrdered (inx).CONCEPTO_ID , csbNivelTraza);

                        tbCargosOrdered (inx).CONCEPTOS   := tbCargos (i).concdefa;
                        pkg_traza.trace(csbMetodo||' CONCEPTOS: '||tbCargosOrdered (inx).CONCEPTOS , csbNivelTraza);

                        tbCargosOrdered (inx).SIGNO       := tbCargos (i).cargsign; -- Agordilllo Incidente.143745
                        pkg_traza.trace(csbMetodo||' SIGNO: '||tbCargosOrdered (inx).SIGNO , csbNivelTraza);

                        tbCargosOrdered (inx).CAR_DOSO    := tbCargos (i).cargdoso; -- Agordilllo Incidente.140493
                        pkg_traza.trace(csbMetodo||' CAR_DOSO: '||tbCargosOrdered (inx).CAR_DOSO , csbNivelTraza);

                        tbCargosOrdered (inx).CAR_CACA    := tbCargos (i).cargcaca; -- Agordilllo Incidente.140493
                        pkg_traza.trace(csbMetodo||' CAR_CACA: '||tbCargosOrdered (inx).CAR_CACA , csbNivelTraza);

                        tbCargosOrdered (inx).SALDO_ANT   := NULL;
                        pkg_traza.trace(csbMetodo||' SALDO_ANT: '||tbCargosOrdered (inx).SALDO_ANT , csbNivelTraza);

                        tbCargosOrdered (inx).CAPITAL     := tbCargos (i).cargvalo;
                        pkg_traza.trace(csbMetodo||' CAPITAL: '||tbCargosOrdered (inx).CAPITAL , csbNivelTraza);

                        tbCargosOrdered (inx).INTERES     := NULL;
                        pkg_traza.trace(csbMetodo||' INTERES: '||tbCargosOrdered (inx).INTERES , csbNivelTraza);

                        tbCargosOrdered (inx).TOTAL       := NULL;
                        pkg_traza.trace(csbMetodo||' TOTAL: '||tbCargosOrdered (inx).TOTAL , csbNivelTraza);

                        tbCargosOrdered (inx).SALDO_DIF   := NULL;
                        pkg_traza.trace(csbMetodo||' SALDO_DIF: '||tbCargosOrdered (inx).SALDO_DIF , csbNivelTraza);

                        tbCargosOrdered (inx).CUOTAS      := NULL;
                        pkg_traza.trace(csbMetodo||' CUOTAS: '||tbCargosOrdered (inx).CUOTAS , csbNivelTraza);

                        inx := inx + 1;

                        -- Inicio CA 200-342
                        tbCargosOrdered (inx).servicio := tbCargos (i).servcodi;
                        pkg_traza.trace(csbMetodo||' servicio: '||tbCargosOrdered (inx).servicio , csbNivelTraza);

                        -- Fin CA 200-342
                        pkg_traza.trace(csbMetodo||' Fin arma el detalle para los demás cargos diferentes de diferidos ', csbNivelTraza);
                    -- Agrupa diferido con su respectivo interes de financiación
                    -- Agordillo Incidente.140493
                    -- Se agrega la condicion de causa de cargo 51 que corresponde la cuota del diferido
                    -- El cual si debe de mostrar el saldo del diferido y el interes
                    WHEN SUBSTR (tbCargos (i).cargdoso, 0, 3) = 'DF-' AND (tbCargos (i).cargcaca = 51) THEN

                         pkg_traza.trace(csbMetodo||'  Agrupa diferido con su respectivo interes de financiación ', csbNivelTraza);
                         nuIndex := SUBSTR (tbcargos (i).cargdoso, 4, LENGTH (tbcargos (i).cargdoso) - 3);

                         gtbFinancion (nuIndex) := SUBSTR (tbcargos (i).cargdoso, 4,  LENGTH (tbcargos (i).cargdoso) - 3);
                         pkg_traza.trace(csbMetodo||' gtbFinancion: '||gtbFinancion (nuIndex), csbNivelTraza);

                        BEGIN
                            --INICIO CA 379
                            sbconcdefa := tbCargos (i).concdefa;
                            pkg_traza.trace(csbMetodo||' sbconcdefa: '||sbconcdefa, csbNivelTraza);
                            --FIN
                            pkg_traza.trace(csbMetodo||' parametro cursor cuDatosDiferido, concdefa : '||tbCargos (i).concdefa, csbNivelTraza);
                            pkg_traza.trace(csbMetodo||' parametro cursor cuDatosDiferido, cargdoso : '||tbCargos (i).cargdoso, csbNivelTraza);

                             OPEN cuDatosDiferido(tbCargos (i).cargdoso, tbCargos (i).concdefa);
                            FETCH cuDatosDiferido INTO nuDifesape, nuDifecuotas, sbconcdefa;
                            CLOSE cuDatosDiferido;

                        EXCEPTION
                            WHEN OTHERS THEN
                                pkg_traza.trace(csbMetodo||' OTHERS, cuDatosDiferido '||sqlerrm, csbNivelTraza);
                                nuDifesape := 0;
                                nuDifecuotas := 0;
                        END;
                        pkg_traza.trace(csbMetodo||' cuDatosDiferido--> nuDifesape: '||nuDifesape, csbNivelTraza);
                        pkg_traza.trace(csbMetodo||' cuDatosDiferido--> nuDifecuotas: '||nuDifecuotas, csbNivelTraza);
                        pkg_traza.trace(csbMetodo||' cuDatosDiferido--> sbconcdefa: '||sbconcdefa, csbNivelTraza);

                        IF tbCargos (i).SERVCODI = 7053 AND INSTR (UPPER (sbconcdefa), 'RESCREG-059') = 0 THEN
                            nuDifesape := NULL;
                            nuDifecuotas := NULL;
                            nuInteres := NULL;

                            pkg_traza.trace(csbMetodo||' nuDifesape: '||nuDifesape, csbNivelTraza);
                            pkg_traza.trace(csbMetodo||' nuDifecuotas: '||nuDifecuotas, csbNivelTraza);
                            pkg_traza.trace(csbMetodo||' nuInteres: '||nuInteres, csbNivelTraza);

                        ELSE
                            pkg_traza.trace(csbMetodo||' parametro cursor cuCargo, cargcuco : '||tbCargos (i).cargcuco, csbNivelTraza);
                            pkg_traza.trace(csbMetodo||' parametro cursor cuCargo, cargdoso : '||tbCargos (i).cargdoso, csbNivelTraza);
                            BEGIN
                                 OPEN cuCargo(tbCargos (i).cargdoso,  tbCargos (i).cargcuco);
                                FETCH cuCargo INTO nuInteres;
                                CLOSE cuCargo;
                            EXCEPTION
                                WHEN OTHERS THEN
                                     pkg_traza.trace(csbMetodo||' OTHERS, cuCargo: '||sqlerrm, csbNivelTraza);
                                     nuInteres := 0;
                            END;
                            pkg_traza.trace(csbMetodo||' nuInteres: '||nuInteres, csbNivelTraza);
                        END IF;

                        tbCargosOrdered (inx).ETIQUETA := '32';
                        pkg_traza.trace(csbMetodo||' ETIQUETA: '||tbCargosOrdered (inx).ETIQUETA , csbNivelTraza);

                        tbCargosOrdered (inx).CONCEPTO_ID := tbCargos (i).cargconc; -- Agordilllo Incidente.140493
                        pkg_traza.trace(csbMetodo||' CONCEPTO_ID: '||tbCargosOrdered (inx).CONCEPTO_ID , csbNivelTraza);

                        tbCargosOrdered (inx).CONCEPTOS := sbconcdefa;
                        pkg_traza.trace(csbMetodo||' CONCEPTOS: '||tbCargosOrdered (inx).CONCEPTOS , csbNivelTraza);

                        tbCargosOrdered (inx).SIGNO := tbCargos (i).cargsign; -- Agordilllo Incidente.143745
                        pkg_traza.trace(csbMetodo||' SIGNO: '||tbCargosOrdered (inx).SIGNO , csbNivelTraza);

                        tbCargosOrdered (inx).CAR_DOSO :=
                            CASE
                                WHEN INSTR (UPPER (sbconcdefa), 'RESCREG-059') =  0 THEN tbCargos (i).cargdoso
                                ELSE 'RESCREG-059' || tbCargos (i).SERVCODI
                            END;
                        pkg_traza.trace(csbMetodo||' CAR_DOSO: '||tbCargosOrdered (inx).CAR_DOSO , csbNivelTraza);

                        tbCargosOrdered (inx).CAR_CACA :=  tbCargos (i).cargcaca; -- Agordilllo Incidente.140493
                        pkg_traza.trace(csbMetodo||' CAR_CACA: '||tbCargosOrdered (inx).CAR_CACA , csbNivelTraza);

                        tbCargosOrdered (inx).SALDO_ANT := NULL;
                        pkg_traza.trace(csbMetodo||' SALDO_ANT: '||tbCargosOrdered (inx).SALDO_ANT , csbNivelTraza);

                        tbCargosOrdered (inx).CAPITAL := tbCargos (i).cargvalo;
                        pkg_traza.trace(csbMetodo||' CAPITAL: '||tbCargosOrdered (inx).CAPITAL , csbNivelTraza);

                        tbCargosOrdered (inx).INTERES := nuInteres;
                        pkg_traza.trace(csbMetodo||' INTERES: '||tbCargosOrdered (inx).INTERES , csbNivelTraza);

                        tbCargosOrdered (inx).TOTAL := NULL;
                        pkg_traza.trace(csbMetodo||' TOTAL: '||tbCargosOrdered (inx).TOTAL , csbNivelTraza);

                        tbCargosOrdered (inx).SALDO_DIF := nuDifesape;
                        pkg_traza.trace(csbMetodo||' SALDO_DIF: '||tbCargosOrdered (inx).SALDO_DIF , csbNivelTraza);

                        tbCargosOrdered (inx).CUOTAS := nuDifecuotas;
                        pkg_traza.trace(csbMetodo||' CUOTAS: '||tbCargosOrdered (inx).CUOTAS , csbNivelTraza);


                        inx := inx + 1;

                        -- Inicio CA 200-342
                        tbCargosOrdered (inx).servicio := tbCargos (i).servcodi;
                        pkg_traza.trace(csbMetodo||' servicio: '||tbCargosOrdered (inx).servicio , csbNivelTraza);

                        -- Fin CA 200-342
                        pkg_traza.trace(csbMetodo||' Fin agrupa diferido con su respectivo interes de financiación ', csbNivelTraza);
                    --------------------------------------------------------------------------------------------------
                    -- Inicia Agordillo Incidente 140493
                    -- Se agrega la condicion and (tbCargos(i).cargcaca !=51)
                    -- para que se incluya los diferidos cuando no corresponden a cuota
                    WHEN SUBSTR (tbCargos (i).cargdoso, 0, 3) = 'DF-'  AND (tbCargos (i).cargcaca != 51) THEN

                        pkg_traza.trace(csbMetodo||' Almacenar los codigo de los diferidos en la tabla ', csbNivelTraza);
                        --Mmejia.Aranda 6477
                        --Se almacena los codigo de los diferidos en la tabla
                        nuIndex := SUBSTR (tbcargos (i).cargdoso, 4, LENGTH (tbcargos (i).cargdoso) - 3);
                        gtbFinancion (nuIndex) := SUBSTR (tbcargos (i).cargdoso, 4,  LENGTH (tbcargos (i).cargdoso) - 3);
                        pkg_traza.trace(csbMetodo||' gtbFinancion: '||gtbFinancion (nuIndex) , csbNivelTraza);

                        tbCargosOrdered (inx).ETIQUETA := '32';
                        pkg_traza.trace(csbMetodo||' ETIQUETA: '||tbCargosOrdered (inx).ETIQUETA , csbNivelTraza);

                        tbCargosOrdered (inx).CONCEPTO_ID := tbCargos (i).cargconc; -- Agordilllo Incidente.140493
                        pkg_traza.trace(csbMetodo||' CONCEPTO_ID: '||tbCargosOrdered (inx).CONCEPTO_ID , csbNivelTraza);

                        tbCargosOrdered (inx).CONCEPTOS := tbCargos (i).concdefa;
                        pkg_traza.trace(csbMetodo||' CONCEPTOS: '||tbCargosOrdered (inx).CONCEPTOS , csbNivelTraza);

                        tbCargosOrdered (inx).SIGNO := tbCargos (i).cargsign; -- Agordilllo Incidente.143745
                        pkg_traza.trace(csbMetodo||' SIGNO: '||tbCargosOrdered (inx).SIGNO , csbNivelTraza);

                        tbCargosOrdered (inx).CAR_DOSO := tbCargos (i).cargdoso; -- Agordilllo Incidente.140493
                        pkg_traza.trace(csbMetodo||' CAR_DOSO: '||tbCargosOrdered (inx).CAR_DOSO , csbNivelTraza);

                        tbCargosOrdered (inx).CAR_CACA := tbCargos (i).cargcaca; -- Agordilllo Incidente.140493
                        pkg_traza.trace(csbMetodo||' CAR_CACA: '||tbCargosOrdered (inx).CAR_CACA , csbNivelTraza);

                        tbCargosOrdered (inx).SALDO_ANT := NULL;
                        pkg_traza.trace(csbMetodo||' SALDO_ANT: '||tbCargosOrdered (inx).SALDO_ANT , csbNivelTraza);

                        tbCargosOrdered (inx).CAPITAL := tbCargos (i).cargvalo;
                        pkg_traza.trace(csbMetodo||' CAPITAL: '||tbCargosOrdered (inx).CAPITAL , csbNivelTraza);

                        tbCargosOrdered (inx).INTERES := NULL;
                        pkg_traza.trace(csbMetodo||' INTERES: '||tbCargosOrdered (inx).INTERES , csbNivelTraza);

                        tbCargosOrdered (inx).TOTAL := NULL;
                        pkg_traza.trace(csbMetodo||' TOTAL: '||tbCargosOrdered (inx).TOTAL , csbNivelTraza);

                        tbCargosOrdered (inx).SALDO_DIF := NULL;
                        pkg_traza.trace(csbMetodo||' SALDO_DIF: '||tbCargosOrdered (inx).SALDO_DIF , csbNivelTraza);

                        tbCargosOrdered (inx).CUOTAS := NULL;
                        pkg_traza.trace(csbMetodo||' CUOTAS: '||tbCargosOrdered (inx).CUOTAS , csbNivelTraza);

                        inx := inx + 1;

                        -- Inicio CA 200-342
                        tbCargosOrdered (inx).servicio := tbCargos (i).servcodi;
                        pkg_traza.trace(csbMetodo||' servicio: '||tbCargosOrdered (inx).servicio , csbNivelTraza);

                        -- Fin CA 200-342
                        pkg_traza.trace(csbMetodo||' Fin almacenar los codigo de los diferidos en la tabla ', csbNivelTraza);
                    -- Fin Agordillo Incidente 140493
                    ---------------------------------------------------------------------------------------------------

                    WHEN SUBSTR (tbCargos (i).cargdoso, 0, 3) = 'ID-' THEN
                        -- Busca si el Interes tiene diferido padre
                        pkg_traza.trace(csbMetodo||' Busca si el Interes tiene diferido padre ', csbNivelTraza);
                        BEGIN
                            -- Agordillo Incidente 140493 aca generaba error cuando existe el mismo diferido
                            -- liquidado para el mismo concepto en la misma cuenta de cobro mas de una vez Ej (cuota, abonos sin intereses)
                            -- Se agrega la condicion (and cargcaca =51) dado que en una cuenta de cobro, solo puede
                            -- Haber un cargo con causa de cargo 51 - Cuota de Diferido en FGCA
                            pkg_traza.trace(csbMetodo||' parametro cursor cuCargdoso, cargcuco : '||tbCargos (i).cargcuco, csbNivelTraza);
                            pkg_traza.trace(csbMetodo||' parametro cursor cuCargdoso, cargdoso : '||tbCargos (i).cargdoso, csbNivelTraza);

                            OPEN cuCargdoso(tbCargos (i).cargdoso, tbCargos (i).cargcuco);
                            FETCH cuCargdoso INTO nuDoso;
                            CLOSE cuCargdoso;

                        EXCEPTION
                            WHEN OTHERS THEN
                                 nuDoso := NULL;
                        END;
                        pkg_traza.trace(csbMetodo||' nuDoso: '||nuDoso, csbNivelTraza);

                        -- Si no existe el diferido padre muestra el concepto
                        IF nuDoso IS NULL THEN
                            --Se almacena los codigo de los diferidos en la tabla
                            nuIndex := SUBSTR (tbcargos (i).cargdoso, 4, LENGTH (tbcargos (i).cargdoso) - 3);
                            gtbFinancion (nuIndex) := SUBSTR (tbcargos (i).cargdoso,  4,  LENGTH (tbcargos (i).cargdoso) - 3);
                            pkg_traza.trace(csbMetodo||' gtbFinancion '||gtbFinancion(nuIndex), csbNivelTraza);
                            BEGIN
                                --INICIO CA 379
                                sbconcdefa := tbCargos (i).concdefa;
                                pkg_traza.trace(csbMetodo||' sbconcdefa: '||sbconcdefa, csbNivelTraza);
                                --FIN
                                pkg_traza.trace(csbMetodo||' parametro cursor cuDatosDiferido, concdefa : '||tbCargos (i).concdefa, csbNivelTraza);
                                pkg_traza.trace(csbMetodo||' parametro cursor cuDatosDiferido, cargdoso : '||tbCargos (i).cargdoso, csbNivelTraza);

                                 OPEN cuDatosDiferido(tbCargos (i).cargdoso, tbCargos (i).concdefa);
                                FETCH cuDatosDiferido INTO nuDifesape, nuDifecuotas, sbconcdefa;
                                CLOSE cuDatosDiferido;

                            EXCEPTION
                                WHEN OTHERS THEN
                                    pkg_traza.trace(csbMetodo||' OTHERS, cuDatosDiferido '||sqlerrm, csbNivelTraza);
                                    nuDifesape := 0;
                                    nuDifecuotas := 0;
                            END;
                            pkg_traza.trace(csbMetodo||' cuDatosDiferido--> nuDifesape: '||nuDifesape, csbNivelTraza);
                            pkg_traza.trace(csbMetodo||' cuDatosDiferido--> nuDifecuotas: '||nuDifecuotas, csbNivelTraza);
                            pkg_traza.trace(csbMetodo||' cuDatosDiferido--> sbconcdefa: '||sbconcdefa, csbNivelTraza);

                            IF tbCargos (i).SERVCODI = 7053 AND INSTR (UPPER (sbconcdefa), 'RESCREG-059') = 0 THEN
                                nuDifesape := NULL;
                                nuDifecuotas := NULL;

                                pkg_traza.trace(csbMetodo||' nuDifesape: '||nuDifesape, csbNivelTraza);
                                pkg_traza.trace(csbMetodo||' nuDifecuotas: '||nuDifecuotas, csbNivelTraza);
                            ELSE
                                NULL;
                            END IF;

                            tbCargosOrdered (inx).ETIQUETA := '32';
                            pkg_traza.trace(csbMetodo||' ETIQUETA: '||tbCargosOrdered (inx).ETIQUETA, csbNivelTraza);

                            tbCargosOrdered (inx).CONCEPTO_ID :=  tbCargos (i).cargconc; -- Agordilllo Incidente.140493
                            pkg_traza.trace(csbMetodo||' CONCEPTO_ID: '||tbCargosOrdered (inx).CONCEPTO_ID, csbNivelTraza);

                            tbCargosOrdered (inx).CONCEPTOS := sbconcdefa;
                            pkg_traza.trace(csbMetodo||' CONCEPTOS: '||tbCargosOrdered (inx).CONCEPTOS, csbNivelTraza);

                            tbCargosOrdered (inx).SIGNO :=  tbCargos (i).cargsign; -- Agordilllo Incidente.143745
                            pkg_traza.trace(csbMetodo||' SIGNO: '||tbCargosOrdered (inx).SIGNO, csbNivelTraza);

                            tbCargosOrdered (inx).CAR_DOSO :=
                                CASE
                                    WHEN INSTR (UPPER (sbconcdefa), 'RESCREG-059') = 0  THEN tbCargos (i).cargdoso
                                    ELSE 'RESCREG-059' || tbCargos (i).SERVCODI
                                END;
                            pkg_traza.trace(csbMetodo||' CAR_DOSO: '||tbCargosOrdered (inx).CAR_DOSO, csbNivelTraza);

                            tbCargosOrdered (inx).CAR_CACA :=  tbCargos (i).cargcaca; -- Agordilllo Incidente.140493
                            pkg_traza.trace(csbMetodo||' CAR_CACA: '||tbCargosOrdered (inx).CAR_CACA, csbNivelTraza);

                            tbCargosOrdered (inx).SALDO_ANT := NULL;
                            pkg_traza.trace(csbMetodo||' SALDO_ANT: '||tbCargosOrdered (inx).SALDO_ANT, csbNivelTraza);

                            tbCargosOrdered (inx).CAPITAL := 0;
                            pkg_traza.trace(csbMetodo||' CAPITAL: '||tbCargosOrdered (inx).CAPITAL, csbNivelTraza);

                            tbCargosOrdered (inx).INTERES := tbCargos (i).cargvalo;
                            pkg_traza.trace(csbMetodo||' INTERES: '||tbCargosOrdered (inx).INTERES, csbNivelTraza);

                            tbCargosOrdered (inx).TOTAL := NULL;
                            pkg_traza.trace(csbMetodo||' TOTAL: '||tbCargosOrdered (inx).TOTAL, csbNivelTraza);

                            tbCargosOrdered (inx).SALDO_DIF := nuDifesape;
                            pkg_traza.trace(csbMetodo||' SALDO_DIF: '||tbCargosOrdered (inx).SALDO_DIF, csbNivelTraza);

                            tbCargosOrdered (inx).CUOTAS := nuDifecuotas;
                            pkg_traza.trace(csbMetodo||' CUOTAS: '||tbCargosOrdered (inx).CUOTAS, csbNivelTraza);

                            inx := inx + 1;

                            -- Inicio CA 200-342
                            tbCargosOrdered (inx).servicio := tbCargos (i).servcodi;
                            pkg_traza.trace(csbMetodo||' servicio: '||tbCargosOrdered (inx).servicio, csbNivelTraza);
                        -- Fin CA 200-342

                        END IF;
                        pkg_traza.trace(csbMetodo||' Fin busca si el Interes tiene diferido padre ', csbNivelTraza);
                    ELSE
                        NULL;
                END CASE;

                -- Acumulación de totales

                IF tbCargos (i).cargsign IN ('CR', 'AS', 'PA', 'DB') THEN
                    -- Acumula intereres de financiación e IVA
                    pkg_traza.trace(csbMetodo||' Acumula intereres de financiación e IVA', csbNivelTraza);

                    IF (SUBSTR (tbCargos (i).cargdoso, 0, 3) = 'ID-')
                       OR INSTR ('|' || sbConcRecamora || '|', '|' || tbCargos (i).cargconc || '|') > 0
                       AND SUBSTR (tbCargos (i).cargdoso, 0, 3) NOT IN('DF-') THEN
                        tbCargosOrdered (-1).INTERES :=  tbCargosOrdered (-1).INTERES + tbCargos (i).cargvalo;
                    ELSE
                        tbCargosOrdered (-1).CAPITAL :=  tbCargosOrdered (-1).CAPITAL  + tbCargos (i).cargvalo;
                    END IF;

                    tbCargosOrdered (-1).TOTAL := tbCargosOrdered (-1).TOTAL + tbCargos (i).cargvalo;

                    pkg_traza.trace(csbMetodo||' INTERES: '||tbCargosOrdered (-1).INTERES, csbNivelTraza);
                    pkg_traza.trace(csbMetodo||' CAPITAL: '||tbCargosOrdered (-1).CAPITAL, csbNivelTraza);
                    pkg_traza.trace(csbMetodo||' TOTAL: '||tbCargosOrdered (-1).TOTAL, csbNivelTraza);

                    IF SUBSTR (tbCargos (i).cargdoso, 0, 3) = 'DF-' AND (   tbCargos (i).SERVCODI <> 7053
                       OR (    tbCargos (i).SERVCODI = 7053  AND INSTR (UPPER (sbconcdefa), 'RESCREG-059') <> 0))
                       AND tbCargos (i).cargcaca = 51 -- Incidente 140493, Agordillo acumula total cuando es cuota
                    THEN
                        --Mmejia.Aranda 6477
                        --Se almacena los codigo de los diferidos en la tabla
                        nuIndex := SUBSTR (tbcargos (i).cargdoso, 4, LENGTH (tbcargos (i).cargdoso) - 3);
                        gtbFinancion (nuIndex) := SUBSTR (tbcargos (i).cargdoso, 4, LENGTH (tbcargos (i).cargdoso) - 3);
                        pkg_traza.trace(csbMetodo||' gtbFinancion: '||gtbFinancion (nuIndex) , csbNivelTraza);

                        BEGIN
                            pkg_traza.trace(csbMetodo||' parametro cursor cuDifesape, cargdoso : '||tbCargos (i).cargdoso, csbNivelTraza);

                            OPEN cuDifesape(tbCargos (i).cargdoso);
                            FETCH cuDifesape INTO nuDifesape;
                            CLOSE cuDifesape;
                        EXCEPTION
                            WHEN OTHERS THEN
                                 nuDifesape := 0;
                        END;
                        pkg_traza.trace(csbMetodo||' nuDifesape: '|| nuDifesape, csbNivelTraza);

                        tbCargosOrdered (-1).SALDO_DIF :=  tbCargosOrdered (-1).SALDO_DIF + nuDifesape;
                        pkg_traza.trace(csbMetodo||' SALDO_DIF: '||tbCargosOrdered (inx).SALDO_DIF, csbNivelTraza);

                    END IF;
                    pkg_traza.trace(csbMetodo||' Fin acumula intereres de financiación e IVA', csbNivelTraza);

                END IF;

                -- Muestra el IVA, Recamora y Total si el servicio cambia
                pkg_traza.trace(csbMetodo||' Muestra el IVA, Recamora y Total si el servicio cambia', csbNivelTraza);
                IF tbCargos.NEXT (i) IS NULL THEN
                    --Aranada.8199,
                    --Mejia
                    --05-08-2015
                    --Se traslada la logica de diferidos no asociados a cuentas de cobro
                    --para que se procese antes de de calcular el total de la factura

                    --Aranda.6477
                    --Mmejia
                    --Se agrega  la logica para agregar a los detalles de factura
                    --los diferidos que no estan asociados a una cuenta de cobro.
                    pkg_traza.trace(csbMetodo||' Inicio Almacenar diferidos restantes', csbNivelTraza);

                    IF (tbCargosOrdered.COUNT () > 0) THEN
                        pkg_traza.trace(csbMetodo||' Inicio Almacenar diferidos restantes 1', csbNivelTraza);

                        k := tbCargosOrdered.FIRST;

                        LOOP
                            EXIT WHEN k IS NULL;

                            IF ( tbCargosOrdered (k).CONCEPTO_ID IS NOT NULL AND k NOT IN (-1, -2, -3)) THEN
                                inxConc :=  TO_CHAR (tbCargosOrdered (k).CONCEPTO_ID, '0000');
                                inxConc := RTRIM (LTRIM (inxConc));
                                pkg_traza.trace(csbMetodo||' Almacenar diferidos restantes inxConc[' || inxConc || ']idx[' || k || ']', csbNivelTraza);
                                gtbConceptos (inxConc) := k;
                                pkg_traza.trace(csbMetodo||' gtbConceptos: '||gtbConceptos (inxConc) , csbNivelTraza);
                            END IF;

                            k := tbCargosOrdered.NEXT (k);
                        END LOOP;
                    END IF;
                    pkg_traza.trace(csbMetodo||' Fin  Almacenar diferidos restantes gtbConceptos.COUNT[' || gtbConceptos.COUNT || ']', csbNivelTraza);

                    --Validacion diferidos con saldo no asociados a una cuenta de cobro
                    OPEN cuDiferidos;
                    FETCH cuDiferidos BULK COLLECT INTO tdiferidos;
                    CLOSE cuDiferidos;

                    k := tdiferidos.FIRST;

                    LOOP
                        EXIT WHEN k IS NULL;

                        IF (NOT gtbFinancion.EXISTS (tdiferidos (k).difecodi)) THEN
                            -- Creacion de detalles
                            inxConc := TO_CHAR (tdiferidos (k).difeconc, '0000');
                            inxConc := RTRIM (LTRIM (inx));
                            --inx := inx + 1;
                            pkg_traza.trace(csbMetodo||' tdiferidos (k).difecodi[' || tdiferidos (k).difecodi || '] inx ['|| inx || ']', csbNivelTraza);

                            -- Agordillo SAO.369165
                            -- 17/12/2015 Se agrega el IF para validar si el servicio es 7053, se asigne null al saldo pendiente y numero de cuotas
                            -- al diferido dado que esta informacion no se muestra en la factura.
                            nuServicio :=  pktblservsusc.fnugetsesuserv ( tdiferidos (k).difenuse);

                            IF nuServicio = 7053 AND INSTR (UPPER (tdiferidos (k).concdefa), 'RESCREG-059') =  0 THEN
                                nuDifesape := NULL;
                                tdiferidos (k).difesape := NULL;

                                nuDifecuotas := NULL;
                                tdiferidos (k).difenucu := NULL;
                            ELSE
                                nuDifesape :=  nuDifesape + tdiferidos (k).difesape;

                                -- Inicio CA 200-849.
                                -- Se acumula el saldo diferido para incluir el valor de los
                                -- diferidos que aun no se estan facturando
                                tbCargosOrdered (-1).saldo_dif := tbCargosOrdered (-1).saldo_dif + tDiferidos (k).difesape;
                            -- Fin CA 200-849.

                            END IF;
                            pkg_traza.trace(csbMetodo||' nuDifesape: '||nuDifesape, csbNivelTraza);
                            pkg_traza.trace(csbMetodo||' nuDifecuotas: '||nuDifecuotas, csbNivelTraza);
                            pkg_traza.trace(csbMetodo||' acumula el saldo diferido: '||tbCargosOrdered (-1).saldo_dif , csbNivelTraza);
                            -- Agordillo SAO.369165
                            -- 17/12/2015 Se agrega la condicion and nuServicio != 7053 para que solo se sume el saldo de diferido
                            -- Cuando el servicio es diferente 7053

                            --Valida si existe
                            IF ( gtbConceptos.EXISTS (inxConc)
                                AND ( nuServicio != 7053 OR ( nuServicio = 7053 AND INSTR ( UPPER ( tdiferidos (k).concdefa), 'RESCREG-059') <> 0 )
                                    )
                                )
                            THEN
                                pkg_traza.trace(csbMetodo|| ' tdiferidos (k).difecodi[' || tdiferidos (k).difecodi || '] EXISTE ', csbNivelTraza);
                                inx := gtbConceptos (inxConc);
                                tbcargosordered (inx).SALDO_DIF := tbcargosordered (inx).SALDO_DIF  + tdiferidos (k).difesape;
                                pkg_traza.trace(csbMetodo||' SALDO_DIF: '||tbcargosordered (inx).SALDO_DIF , csbNivelTraza);

                            ELSE
                                pkg_traza.trace(csbMetodo|| ' tdiferidos (k).difecodi[' || tdiferidos (k).difecodi || '] NO EXISTE ', csbNivelTraza);
                                tbCargosOrdered (inx).ETIQUETA := '32';
                                pkg_traza.trace(csbMetodo||' ETIQUETA: '||tbcargosordered (inx).ETIQUETA , csbNivelTraza);

                                pkg_traza.trace(csbMetodo|| ' tdiferidos (k).difecodi[' || tdiferidos (k).difecodi || '] NO EXISTE ', csbNivelTraza);
                                tbCargosOrdered (inx).CONCEPTO_ID := tdiferidos (k).difeconc;
                                pkg_traza.trace(csbMetodo||' CONCEPTO_ID: '||tbcargosordered (inx).CONCEPTO_ID , csbNivelTraza);

                                tbCargosOrdered (inx).CONCEPTOS := tdiferidos (k).concdefa;
                                pkg_traza.trace(csbMetodo||' CONCEPTOS: '||tbcargosordered (inx).CONCEPTOS , csbNivelTraza);

                                pkg_traza.trace(csbMetodo|| ' tdiferidos (k).difecodi[' || tdiferidos (k).difecodi || '] NO EXISTE ', csbNivelTraza);
                                tbCargosOrdered (inx).SIGNO := NULL;
                                tbCargosOrdered (inx).CAR_DOSO := NULL;
                                tbCargosOrdered (inx).CAR_CACA := NULL;
                                tbCargosOrdered (inx).SALDO_ANT := NULL;
                                tbCargosOrdered (inx).CAPITAL := 0;
                                tbCargosOrdered (inx).INTERES := NULL;
                                tbCargosOrdered (inx).TOTAL := NULL;
                                pkg_traza.trace(csbMetodo|| ' tdiferidos (k).difecodi[' || tdiferidos (k).difecodi || '] NO EXISTE ', csbNivelTraza);
                                tbCargosOrdered (inx).SALDO_DIF := tdiferidos (k).difesape;
                                pkg_traza.trace(csbMetodo||' SALDO_DIF: '||tbcargosordered (inx).SALDO_DIF , csbNivelTraza);

                                tbCargosOrdered (inx).CUOTAS := tdiferidos (k).difenucu;
                                pkg_traza.trace(csbMetodo||' CUOTAS: '||tbcargosordered (inx).CUOTAS , csbNivelTraza);

                                pkg_traza.trace(csbMetodo|| ' tdiferidos (k).difecodi[' || tdiferidos (k).difecodi || '] NO EXISTE ', csbNivelTraza);
                                inx := inx + 1;

                                -- Inicio CA 200-342
                                tbCargosOrdered (inx).servicio := tbCargos (i).servcodi;
                                pkg_traza.trace(csbMetodo||' servicio: '||tbcargosordered (inx).servicio , csbNivelTraza);
                                -- Fin CA 200-342

                            END IF;
                        END IF;

                        k := tdiferidos.NEXT (k);
                    END LOOP;

                    pkg_traza.trace(csbMetodo|| ' Termina  loop de diferidos ', csbNivelTraza);

                    IF tbCargosOrdered (-2).CAPITAL <> 0 THEN
                        tbCargosOrdered (inx) := tbCargosOrdered (-2);
                        inx := inx + 1;

                        -- Inicio CA 200-342
                        tbCargosOrdered (inx).servicio := tbCargos (i).servcodi;
                        -- Fin CA 200-342

                    END IF;

                    IF tbCargosOrdered (-3).INTERES <> 0 THEN
                        tbCargosOrdered (inx) := tbCargosOrdered (-3);
                        inx := inx + 1;

                        -- Inicio CA 200-342
                        tbCargosOrdered (inx).servicio := tbCargos (i).servcodi;
                        -- Fin CA 200-342

                    END IF;

                    tbCargosOrdered (inx) := tbCargosOrdered (-1);
                    inx := inx + 1;

                    -- Inicio CA 200-342
                    tbCargosOrdered (inx).servicio := tbCargos (i).servcodi;
                    -- Fin CA 200-342

                    gsbTotal := tbCargosOrdered (-1).TOTAL;
                    pkg_traza.trace(csbMetodo|| ' gsbTotal: ' || gsbTotal, csbNivelTraza);

                    gsbIVANoRegulado := tbCargosOrdered (-1).INTERES; --SE USA LA VARIBALE DE NOREGULADO
                    pkg_traza.trace(csbMetodo|| ' gsbIVARegulado: ' || gsbIVANoRegulado, csbNivelTraza);

                    gsbSubtotalNoReg := tbCargosOrdered (-1).SALDO_DIF;
                    pkg_traza.trace(csbMetodo|| ' gsbSubtotalReg: ' || gsbSubtotalNoReg, csbNivelTraza);

                    gsbCargosMes := tbCargosOrdered (-1).CAPITAL;
                    pkg_traza.trace(csbMetodo|| ' gsbCargosMes: ' || gsbCargosMes, csbNivelTraza);

                    tbCargosOrdered.delete (-2);
                    tbCargosOrdered.delete (-3);
                    tbCargosOrdered.delete (-1);
                ELSE --IF tbCargos.NEXT (i) IS NULL
                    j := tbCargos.NEXT (i);
                    pkg_traza.trace(csbMetodo|| ' tbCargos.NEXT (i) IS NULL  ', csbNivelTraza);
                    IF tbCargos (j).cargnuse <> tbCargos (i).cargnuse THEN
                        IF tbCargosOrdered (-2).CAPITAL <> 0 THEN
                            pkg_traza.trace(csbMetodo|| ' tbCargosOrdered (-2).CAPITAL <> 0 ', csbNivelTraza);
                            tbCargosOrdered (inx) := tbCargosOrdered (-2);
                            inx := inx + 1;
                            -- Inicio CA 200-342
                            tbCargosOrdered (inx).servicio := tbCargos (i).servcodi;
                            pkg_traza.trace(csbMetodo|| ' tbCargosOrdered (inx).servicio: '||tbCargosOrdered (inx).servicio, csbNivelTraza);
                            -- Fin CA 200-342

                        END IF;

                        IF tbCargosOrdered (-3).INTERES <> 0 THEN
                           pkg_traza.trace(csbMetodo|| ' tbCargosOrdered (-3).INTERES <> 0 ', csbNivelTraza);
                            tbCargosOrdered (inx) := tbCargosOrdered (-3);
                            inx := inx + 1;

                            -- Inicio CA 200-342
                            tbCargosOrdered (inx).servicio := tbCargos (i).servcodi;
                            pkg_traza.trace(csbMetodo|| ' tbCargosOrdered (inx).servicio: '||tbCargosOrdered (inx).servicio, csbNivelTraza);
                            -- Fin CA 200-342

                        END IF;

                        tbCargosOrdered (inx) := tbCargosOrdered (-1);
                        inx := inx + 1;

                        -- Inicio CA 200-342
                        tbCargosOrdered (inx).servicio := tbCargos (i).servcodi;
                        -- Fin CA 200-342

                        tbCargosOrdered.delete (-2);
                        tbCargosOrdered.delete (-3);
                        tbCargosOrdered.delete (-1);
                    END IF;
                END IF;
                pkg_traza.trace(csbMetodo||' Fin Muestra el IVA, Recamora y Total si el servicio cambia', csbNivelTraza);

                -- reasigna el servicio para los cambios
                nuLastSesu := tbCargos (i).cargnuse;
                pkg_traza.trace(csbMetodo|| ' reasigna el servicio para los cambios, nuLastSesu: '||nuLastSesu, csbNivelTraza);
                i := tbCargos.NEXT (i);


            END LOOP;
            pkg_traza.trace(csbMetodo||' Fin Crear detalles para los regulados ', csbNivelTraza);

            DELETE FROM LDC_CONC_FACTURA_TEMP;
            pkg_traza.trace(csbMetodo|| ' DELETE LDC_CONC_FACTURA_TEMP', csbNivelTraza);
            pkg_traza.trace(csbMetodo|| ' TBCARGOSORDERED.COUNT[' || tbCargosOrdered.COUNT || '] ', csbNivelTraza);

            nuSaldoDife := 0;
            tblProdDife.delete;
            nuIndeBri := 1;

            -- Agordilllo Incidente.140493
            -- Se agrega la columna orden a la tabla PL, para mantener el orden cuando se agrupen los datos.
            pkg_traza.trace(csbMetodo|| ' INICIA LOOP nuCodiFactProt ', csbNivelTraza);
            FOR i IN tbCargosOrdered.FIRST .. tbCargosOrdered.LAST
            LOOP
                tbCargosOrdered (i).ORDEN := i;
                nuSaldoDife := 0;

                --INICIO CA 200-2032
                --se valida si el concepto es el configurado en el parametro LDC_CODCONCSEGUPROT
                IF nuCodiFactProt = tbCargosOrdered (i).CONCEPTO_ID  AND INSTR (UPPER (tbCargosOrdered (i).CONCEPTOS), 'RESCREG-059') =  0
                THEN
                    nuSaldoDife := tbCargosOrdered (i).SALDO_DIF;
                    tbCargosOrdered (i).SALDO_DIF := NULL;

                    tblProdDife (nuIndeBri).nuProducto := tbCargosOrdered (i).servicio;
                    tblProdDife (nuIndeBri).nuSaldoDife := nuSaldoDife;
                    tblProdDife (nuIndeBri).nuCuota :=  tbCargosOrdered (i).CUOTAS;
                    tbCargosOrdered (i).CUOTAS := NULL;
                    nuIndeBri := nuIndeBri + 1;
                END IF;

                pkg_traza.trace(csbMetodo|| ' nuProducto: ' || tbCargosOrdered (i).servicio, csbNivelTraza);
                pkg_traza.trace(csbMetodo|| ' nuSaldoDife: ' || nuSaldoDife, csbNivelTraza);
                pkg_traza.trace(csbMetodo|| ' nuCuota: ' || tbCargosOrdered (i).CUOTAS, csbNivelTraza);

                --FIN CA 200-2032
            END LOOP;
            pkg_traza.trace(csbMetodo|| ' Finaliza LOOP nuCodiFactProt ', csbNivelTraza);

            nuSaldoDife := 0;
            pkg_traza.trace(csbMetodo|| ' sbDescriConBri: ' || sbDescriConBri, csbNivelTraza);

            --INICIO CA 200-2032
            pkg_traza.trace(csbMetodo|| ' INICIA LOOP Saldo diferido y servicio ', csbNivelTraza);
            FOR i IN tbCargosOrdered.FIRST .. tbCargosOrdered.LAST
            LOOP
                FOR j IN 1 .. tblProdDife.COUNT
                LOOP
                    IF tblProdDife (j).nuSaldoDife > 0  AND tblProdDife (j).nuCuota =  tbCargosOrdered (i).CUOTAS
                       AND tbCargosOrdered (i).servicio =  tblProdDife (j).nuProducto
                       AND UPPER (tbCargosOrdered (i).CONCEPTOS) LIKE '%' || sbDescriConBri || '%'
                    THEN
                        tbCargosOrdered (i).SALDO_DIF :=  tbCargosOrdered (i).SALDO_DIF + tblProdDife (j).nuSaldoDife;
                        -- INICIO caso: 234
                        --tblProdDife.delete(j);
                        tblProdDife (j).nuProducto := NULL;
                        tblProdDife (j).nuSaldoDife := NULL;
                        tblProdDife (j).nuCuota := NULL;
                    -- FIN caso: 234
                    END IF;
                pkg_traza.trace(csbMetodo|| ' SALDO_DIF: ' || tbCargosOrdered (i).SALDO_DIF, csbNivelTraza);
                pkg_traza.trace(csbMetodo|| ' nuProducto: ' || tblProdDife (j).nuProducto, csbNivelTraza);
                pkg_traza.trace(csbMetodo|| ' nuSaldoDife: ' || tblProdDife (j).nuSaldoDife, csbNivelTraza);
                pkg_traza.trace(csbMetodo|| ' nuCuota: ' || tblProdDife (j).nuCuota, csbNivelTraza);
                END LOOP;
            END LOOP;
            pkg_traza.trace(csbMetodo|| ' Finaliza LOOP Saldo diferido y servicio ', csbNivelTraza);
            --FIN CA 200-2032

            -- Agordilllo Incidente.143745
            FORALL i IN tbCargosOrdered.FIRST .. tbCargosOrdered.LAST
                INSERT INTO LDC_CONC_FACTURA_TEMP (ID,
                                                   CONCEPTO_ID,
                                                   CONCEPTO,
                                                   CONC_SIGNO,
                                                   TIPO_CONCEPTO,
                                                   ORDEN_CONCEPTO,
                                                   VALOR_MES,
                                                   PRESENTE_MES,
                                                   AMORTIZACION,
                                                   SALDO_DIFERIDO,
                                                   VENCIDO,
                                                   TASA_INTERES,
                                                   CUOTAS_PENDIENTES,
                                                   SERVICIO,
                                                   PRODUCTO,
                                                   DOC_SOPORTE,
                                                   CAU_CARGO)
                         VALUES (
                                    tbCargosOrdered (i).ETIQUETA,
                                    tbCargosOrdered (i).CONCEPTO_ID,
                                    tbCargosOrdered (i).CONCEPTOS,
                                    tbCargosOrdered (i).SIGNO,
                                    NULL,
                                    tbCargosOrdered (i).ORDEN, -- Agordilllo Incidente.140493
                                    tbCargosOrdered (i).CAPITAL,
                                    tbCargosOrdered (i).TOTAL,
                                    tbCargosOrdered (i).INTERES,
                                    tbCargosOrdered (i).SALDO_DIF,
                                    tbCargosOrdered (i).SALDO_ANT,
                                    NULL,
                                    tbCargosOrdered (i).CUOTAS,
                                    tbCargosOrdered (i).servicio, --OSF-1981
                                    NULL,
                                    tbCargosOrdered (i).CAR_DOSO,
                                    tbCargosOrdered (i).CAR_CACA);
            pkg_traza.trace(csbMetodo|| ' INSERT LDC_CONC_FACTURA_TEMP ', csbNivelTraza);
            -- Agordilllo Incidente.140493
            -- Se agrega el llamado  a la funcion fnuCanConceptos, dado que para mostrarse los datos se agrupan,
            -- y el numero de concepto no corresponden a los datos inciales sin agrupacion
            gnuConcNumber := LDC_DetalleFact_GasCaribe.fnuCanConceptos;
            pkg_traza.trace(csbMetodo|| ' gnuConcNumber: '||gnuConcNumber, csbNivelTraza);

        ELSE --IF NOT blNRegulado
            -- Crear detalles para los no regulados
            pkg_traza.trace(csbMetodo|| ' Crear detalles para los no regulados ', csbNivelTraza);
            i := tbCargos.FIRST;

            LOOP
                EXIT WHEN i IS NULL;

                -- Imprime encabezado si cambia de servicio suscrito
                pkg_traza.trace(csbMetodo|| ' nuLastSesu: '||nuLastSesu, csbNivelTraza);
                IF nuLastSesu = -1 THEN
                    -- Crea el detalle de total
                    tbCargosOrdered (-1).ETIQUETA := '36';
                    tbCargosOrdered (-1).CONCEPTOS := 'TOTALES';
                    tbCargosOrdered (-1).CAPITAL := 0;
                    tbCargosOrdered (-1).INTERES := 0;
                    tbCargosOrdered (-1).TOTAL := 0;
                    tbCargosOrdered (-1).SALDO_DIF :=
                          pkbobillprintheaderrules.fnugettotalpreviousbalance
                        - pkbobillprintheaderrules.fsbgetpositivebalance;
                    pkg_traza.trace(csbMetodo|| ' SALDO_DIF: '||tbCargosOrdered (-1).SALDO_DIF , csbNivelTraza);
                END IF;

                -- Crea los detalles
                pkg_traza.trace(csbMetodo|| ' Crea los detalles  ', csbNivelTraza);
                IF tbCargos (i).cargsign IN ('CR', 'AS', 'PA') THEN
                    tbCargos (i).cargvalo := -1 * tbCargos (i).cargvalo;
                ELSIF tbCargos (i).cargsign IN ('DB') THEN
                    tbCargos (i).cargvalo := tbCargos (i).cargvalo;
                ELSE
                    tbCargos (i).cargvalo := 0;
                END IF;
                pkg_traza.trace(csbMetodo|| ' Valor del cargo: '|| tbCargos (i).cargvalo, csbNivelTraza);

                pkg_traza.trace(csbMetodo|| ' sbConcIVA: '|| sbConcIVA, csbNivelTraza);
                IF INSTR ('|' || sbConcIVA || '|', '|' || tbCargos (i).cargconc || '|') = 0 THEN
                    tbCargosOrdered (inx).ETIQUETA := '35';
                    pkg_traza.trace(csbMetodo|| ' ETIQUETA: '|| tbCargosOrdered (inx).ETIQUETA, csbNivelTraza);

                    tbCargosOrdered (inx).CONCEPTO_ID := tbCargos (i).cargconc;  -- Agordilllo Incidente.140493
                    pkg_traza.trace(csbMetodo|| ' CONCEPTO_ID: '|| tbCargosOrdered (inx).CONCEPTO_ID, csbNivelTraza);

                    tbCargosOrdered (inx).CONCEPTOS := tbCargos (i).concdefa;
                    pkg_traza.trace(csbMetodo|| ' CONCEPTOS: '|| tbCargosOrdered (inx).CONCEPTOS, csbNivelTraza);

                    tbCargosOrdered (inx).SIGNO := tbCargos (i).cargsign; -- Agordilllo Incidente.143745
                    pkg_traza.trace(csbMetodo|| ' SIGNO: '|| tbCargosOrdered (inx).SIGNO, csbNivelTraza);

                    tbCargosOrdered (inx).CAR_DOSO := tbCargos (i).cargdoso; -- Agordilllo Incidente.140493
                    pkg_traza.trace(csbMetodo|| ' CAR_DOSO: '|| tbCargosOrdered (inx).CAR_DOSO, csbNivelTraza);

                    tbCargosOrdered (inx).CAR_CACA := tbCargos (i).cargcaca; -- Agordilllo Incidente.140493
                    pkg_traza.trace(csbMetodo|| ' CAR_CACA: '|| tbCargosOrdered (inx).CAR_CACA, csbNivelTraza);

                    tbCargosOrdered (inx).SALDO_ANT := NULL;
                    tbCargosOrdered (inx).CAPITAL := tbCargos (i).cargvalo;
                    pkg_traza.trace(csbMetodo|| ' CAPITAL: '|| tbCargosOrdered (inx).CAPITAL, csbNivelTraza);

                    tbCargosOrdered (inx).INTERES := NULL;
                    tbCargosOrdered (inx).TOTAL := NULL;
                    tbCargosOrdered (inx).SALDO_DIF := NULL;

                    pkg_traza.trace(csbMetodo|| ' nuConcSuministro: '|| nuConcSuministro, csbNivelTraza);
                    pkg_traza.trace(csbMetodo|| ' nuConcComercial: '|| nuConcComercial, csbNivelTraza);

                    IF tbCargos (i).cargconc IN (nuConcSuministro, nuConcComercial) THEN
                        tbCargosOrdered (inx).CUOTAS := tbCargos (i).cargunid;
                        pkg_traza.trace(csbMetodo|| ' CUOTAS: '|| tbCargosOrdered (inx).CUOTAS, csbNivelTraza);
                    END IF;

                    inx := inx + 1;
                END IF;

                -- Acumulación de totales
                pkg_traza.trace(csbMetodo|| ' Acumulación de totales, Signo :'||tbCargos (i).cargsign , csbNivelTraza);

                IF tbCargos (i).cargsign IN ('CR', 'AS', 'DB') THEN
                    -- Agordillo Incidente.143745 se excluyen los totales de PA

                    IF INSTR ('|' || sbConcIVA || '|', '|' || tbCargos (i).cargconc || '|') > 0 THEN
                        tbCargosOrdered (-1).INTERES :=  tbCargosOrdered (-1).INTERES + tbCargos (i).cargvalo;
                        pkg_traza.trace(csbMetodo|| ' INTERES: '||tbCargosOrdered (-1).INTERES , csbNivelTraza);
                    ELSE
                        tbCargosOrdered (-1).CAPITAL :=  tbCargosOrdered (-1).CAPITAL + tbCargos (i).cargvalo;
                        pkg_traza.trace(csbMetodo|| ' CAPITAL: '||tbCargosOrdered (-1).CAPITAL , csbNivelTraza);

                        tbCargosOrdered (-1).SALDO_DIF := tbCargosOrdered (-1).SALDO_DIF + tbCargos (i).cargvalo;
                        pkg_traza.trace(csbMetodo|| ' SALDO_DIF: '||tbCargosOrdered (-1).SALDO_DIF , csbNivelTraza);

                    END IF;

                    tbCargosOrdered (-1).TOTAL :=  tbCargosOrdered (-1).TOTAL + tbCargos (i).cargvalo;
                    pkg_traza.trace(csbMetodo|| ' TOTAL: '||tbCargosOrdered (-1).TOTAL , csbNivelTraza);

                END IF;

                -- Muestra los totales si el servicio cambia
                IF tbCargos.NEXT (i) IS NULL THEN
                    pkg_traza.trace(csbMetodo|| ' Muestra los totales si el servicio cambia ', csbNivelTraza);

                    gsbTotal := tbCargosOrdered (-1).TOTAL;
                    pkg_traza.trace(csbMetodo|| ' gsbTotal: ' || gsbTotal, csbNivelTraza);

                    gsbIVANoRegulado := tbCargosOrdered (-1).INTERES;
                    pkg_traza.trace(csbMetodo|| ' gsbIVANoRegulado: ' || gsbIVANoRegulado, csbNivelTraza);

                    gsbSubtotalNoReg := tbCargosOrdered (-1).SALDO_DIF;
                    pkg_traza.trace(csbMetodo|| ' gsbSubtotalNoReg: ' || gsbSubtotalNoReg, csbNivelTraza);

                    gsbCargosMes := tbCargosOrdered (-1).CAPITAL;
                    pkg_traza.trace(csbMetodo|| ' gsbCargosMes: ' || gsbCargosMes, csbNivelTraza);

                    tbCargosOrdered.delete (-1);
                END IF;

                -- reasigna el servicio para los cambios
                nuLastSesu := tbCargos (i).cargnuse;
                pkg_traza.trace(csbMetodo|| ' reasigna el servicio para los cambios, nuLastSesu: '||nuLastSesu, csbNivelTraza);
                i := tbCargos.NEXT (i);
            END LOOP;
            pkg_traza.trace(csbMetodo|| ' Finaliza LOOP Crear detalles para los no regulados ', csbNivelTraza);

            DELETE FROM LDC_CONC_FACTURA_TEMP;
            pkg_traza.trace(csbMetodo|| ' DELETE LDC_CONC_FACTURA_TEMP', csbNivelTraza);

            FOR i IN tbCargosOrdered.FIRST .. tbCargosOrdered.LAST
            LOOP
                tbCargosOrdered (i).ORDEN := i;
            END LOOP;

            -- Agordilllo Incidente.143745
            FORALL i IN tbCargosOrdered.FIRST .. tbCargosOrdered.LAST
                INSERT INTO LDC_CONC_FACTURA_TEMP (ID,
                                                   CONCEPTO_ID,
                                                   CONCEPTO,
                                                   CONC_SIGNO,
                                                   TIPO_CONCEPTO,
                                                   ORDEN_CONCEPTO,
                                                   VALOR_MES,
                                                   PRESENTE_MES,
                                                   AMORTIZACION,
                                                   SALDO_DIFERIDO,
                                                   VENCIDO,
                                                   TASA_INTERES,
                                                   CUOTAS_PENDIENTES,
                                                   SERVICIO,
                                                   PRODUCTO,
                                                   DOC_SOPORTE,
                                                   CAU_CARGO)
                     VALUES (tbCargosOrdered (i).ETIQUETA,
                             tbCargosOrdered (i).CONCEPTO_ID,
                             tbCargosOrdered (i).CONCEPTOS,
                             tbCargosOrdered (i).SIGNO,
                             NULL,
                             tbCargosOrdered (i).ORDEN, -- Agordilllo Incidente.140493
                             tbCargosOrdered (i).CAPITAL,
                             tbCargosOrdered (i).TOTAL,
                             tbCargosOrdered (i).INTERES,
                             tbCargosOrdered (i).SALDO_DIF,
                             NULL,
                             NULL,
                             NULL,
                             NULL,
                             tbCargosOrdered (i).CUOTAS,
                             tbCargosOrdered (i).CAR_DOSO,
                             tbCargosOrdered (i).CAR_CACA);
            pkg_traza.trace(csbMetodo|| ' INSERT LDC_CONC_FACTURA_TEMP 2', csbNivelTraza);
            -- Agordilllo Incidente.140493
            -- Se agrega el llamado  a la funcion fnuCanConceptos, dado que para mostrarse los datos se agrupan,
            -- y el numero de concepto no corresponden a los datos inciales sin agrupacion
            gnuConcNumber := LDC_DetalleFact_GasCaribe.fnuCanConceptos;
            pkg_traza.trace(csbMetodo|| ' gnuConcNumber 2: '||gnuConcNumber, csbNivelTraza);

        END IF;

        pkg_traza.trace(csbMetodo|| ' TOTAL:'|| gsbTotal
            || ' IVA:'
            || gsbIVANoRegulado
            || ' SUBTOTAL:'
            || gsbSubtotalNoReg
            || ' CARGOSMES:'
            || gsbCargosMes
            || ' CANTIDAD_CONC:'
            || gnuConcNumber, csbNivelTraza);

        OPEN orfcursor FOR
            SELECT TO_CHAR (gsbTotal, 'FM999,999,999,990')           TOTAL,
                   TO_CHAR (gsbIVANoRegulado, 'FM999,999,999,990')   IVA,
                   TO_CHAR (gsbSubtotalNoReg, 'FM999,999,999,990')   SUBTOTAL,
                   TO_CHAR (gsbCargosMes, 'FM999,999,999,990')       CARGOSMES,
                   gnuConcNumber                                     CANTIDAD_CONC
              FROM DUAL;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    END RfConcepParcial;

    /************************************************************************
    *PROPIEDAD INTELECTUAL
    *
    *    PROCEDURE : mensajesForma
    *    AUTOR     : Daniel Valiente
    *    FECHA     : 8-11-2017
    *    CASO      : 200-1427
    * DESCRIPCION  : Devuelve los mensajes que deberan aparecer en la forma LDFACTDUP
    *
    * Historia de Modificaciones
    14/12/2023      adrianavg     OSF-1819: Se declaran variables para el manejo de traza
    ******************************************************************************************/

    PROCEDURE mensajesForma (osbtitulo OUT VARCHAR2, osbmensaje OUT VARCHAR2)
    AS
        vtipo         VARCHAR2 (20);
        vcomentario   VARCHAR2 (255);

        CURSOR c_reglas IS
            SELECT DISTINCT (a.tipo), a.comentario
              FROM ldci_kiosco_reglas a
             WHERE a.activo = 'S' AND a.tipo IN ('MENSAJE1', 'MENSAJE2');

        --variables para el manejo de trazas
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'mensajesForma';

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);

        osbtitulo := '';
        osbmensaje := '';

        OPEN c_reglas;

        LOOP
            FETCH c_reglas INTO vtipo, vcomentario;
            EXIT WHEN c_reglas%NOTFOUND;

            IF vtipo = 'MENSAJE1' THEN
                osbtitulo := vcomentario;
            END IF;

            IF vtipo = 'MENSAJE2' THEN
                osbmensaje := vcomentario;
            END IF;
        END LOOP;

        CLOSE c_reglas;
        pkg_traza.trace(csbMetodo||' osbtitulo: '||osbtitulo, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' osbmensaje: '||osbmensaje, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    END mensajesForma;

    /************************************************************************
    *PROPIEDAD INTELECTUAL
    *
    *    PROCEDURE : AplicaNETrangosConsumos
    *    AUTOR     : Daniel Valiente
    *    FECHA     : 5-03-2018
    *    CASO      : 200-1427
    * DESCRIPCION  : Instancia APLICA para generar tabla de Cargos en la Factura POR EL .net
    *
    * Historia de Modificaciones
      14/12/2023      adrianavg     OSF-1819: Se declaran variables para el manejo de traza
    ******************************************************************************************/
    PROCEDURE AplicaNETrangosConsumos (vaplica IN VARCHAR2)
    AS
        nuPosInstance   NUMBER;

        --variables para el manejo de trazas
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'AplicaNETrangosConsumos';

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_traza.trace(csbMetodo|| ' vaplica: ' ||vaplica, csbNivelTraza, pkg_traza.csbInicio);

        GE_BOINSTANCECONTROL.INITINSTANCEMANAGER;
        GE_BOINSTANCECONTROL.CREATEINSTANCE ('DATA_EXTRACTOR', NULL);
        GE_BOINSTANCECONTROL.ADDATTRIBUTE ('DATA_EXTRACTOR',  NULL, 'FACTURA', 'APLICA',  vaplica, TRUE);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    END AplicaNETrangosConsumos;

    /************************************************************************
       PROCEDIMIENTO : LDCI_PKFACTKIOSCO_OSF_GDC.proSoliDuplicadoKiosco
       AUTOR         : Karem Baquero/Jm Gestion Informatica
       FECHA         : 30/10/2017
       CASO          : 1427
       DESCRIPCION   : Permite listar ordenes por solicitud

      Historia de Modificaciones
      Autor                 Fecha        Descripcion
      adrianavg             14/12/2023   OSF-1819: Se declaran variables para el manejo de traza
                                         Se implementa pkg_error.prInicializaError.
                                         Se reemplaza SELECT-INTO por cursor cuSuscripc, cuAbaddress cuNuCausal
                                         Declarar variable sbXML para recibir el armado del XML getSolicitudDuplicadoKiosco
                                         Ajustar bloque de exceptions según las pautas técnicas
      Jorge Valiente        06/02/2025   OSF-3938: Validar existencia del punto de atencion y medio de recepcion del funcional
                                                   conectado para generar duplicado
    ************************************************************************/

    PROCEDURE proSoliDuplicadoKiosco (  inuSuscCodi       IN  SUSCRIPC.SUSCCODI%TYPE,
                                        inuRecepTipo      IN  NUMBER,
                                        sbobservacion     IN  VARCHAR2,
                                        onuPackageId      OUT mo_packages.package_id%TYPE,
                                        onuMotiveId       OUT mo_motive.motive_id%TYPE,
                                        ONUERRORCODE      IN OUT NUMBER,
                                        OSBERRORMESSAGE   IN OUT VARCHAR2)
    AS
        nuIdAddress     suscripc.SUSCIDDI%TYPE;
        nususclient     suscripc.SUSCCLIE%TYPE;
        sbaddress       ab_address.address%TYPE;
        nugeoloca       ab_address.geograp_location_id%TYPE;
        sbDescripcion   CC_CAUSAL_TYPE.DESCRIPTION%TYPE;
        nucausal        CC_CAUSAL.CAUSAL_ID%TYPE := dald_parameter.fnuGetNumeric_Value ('COD_CAUSAL_SOLICITUD_KIOSCO');
        nutipocausal    CC_CAUSAL_TYPE.CAUSAL_TYPE_ID%TYPE := dald_parameter.fnuGetNumeric_Value ('COD_TIP_CAUSAL_SOLI_KIOSCO');

        --variables para el manejo de trazas
        csbMetodo    CONSTANT VARCHAR2(100) := csbNOMPKG||'proSoliDuplicadoKiosco';
        sbXML        constants_per.TIPO_XML_SOL%TYPE;

        CURSOR cuSuscripc
        IS
        SELECT SUSCCLIE, susciddi
          FROM Suscripc
         WHERE Susccodi = inuSuscCodi;

        CURSOR cuAbaddress(p_nuIdAddress ab_address.address_id%TYPE)
        IS
        SELECT NVL (a.geograp_location_id, 0), NVL (a.address_parsed, 0)
          FROM ab_address a
         WHERE a.address_id = p_nuIdAddress;

         CURSOR cuNuCausal( p_causal_type_id cc_causal_type.causal_type_id%TYPE)
         IS
        SELECT DESCRIPTION
          FROM cc_causal_type
         WHERE Causal_Type_Id = p_causal_type_id;

        --OSF-3938
        nuPersonId NUMBER;
        nuPuntoAtencion NUMBER;
        sbMedioRecepcion VARCHAR2(1);
        ------------------------
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);
        pkg_error.prInicializaError( ONUERRORCODE, OSBERRORMESSAGE);
        pkg_traza.trace(csbMetodo||' inuSuscCodi: '||inuSuscCodi, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' inuRecepTipo: '||inuRecepTipo, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' sbobservacion: '||sbobservacion, csbNivelTraza);

        ---OSF-3938
        BEGIN
          nuPersonId := pkg_bopersonal.fnugetpersonaid;
          pkg_traza.trace('Codigo Funcional: '||nuPersonId, csbNivelTraza);        
          nuPuntoAtencion := pkg_bopersonal.fnugetpuntoatencionid(nuPersonId);
          pkg_traza.trace('Punto de Atencion: '||nuPuntoAtencion, csbNivelTraza);        
          IF nvl(nuPuntoAtencion,0) = 0 or nuPuntoAtencion = -1 THEN
            Pkg_Error.SetErrorMessage( isbMsgErrr => 'El funcional no tiene Punto de Atencion Valido');
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            Pkg_Error.SetErrorMessage( isbMsgErrr => 'El funcional no tiene Punto de Atencion Valido');
        END;
        sbMedioRecepcion := pkg_BcPuntoAtencion.fsbValMedioRecepcion(nuPuntoAtencion,inuRecepTipo);
        pkg_traza.trace('Medio de Recepcion: '||inuRecepTipo, csbNivelTraza);        
        pkg_traza.trace('Existe Relacion: '||sbMedioRecepcion, csbNivelTraza);        
        IF sbMedioRecepcion = 'N' THEN
          Pkg_Error.SetErrorMessage( isbMsgErrr => 'El funcional no tiene configurado el Medio de recepcion '|| inuRecepTipo);
        END IF;
        ---------------------------
        
        --Se consulta el codigo de cliente que corresponde al contrato
        OPEN cuSuscripc;
        FETCH cuSuscripc INTO nususclient, nuIdAddress;
        CLOSE cuSuscripc;
        pkg_traza.trace(csbMetodo||' nususclient: '||nususclient, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' nuIdAddress: '||nuIdAddress, csbNivelTraza);

        --Se consulta la dirección parseada del que corresponde al contrato
        OPEN cuAbaddress(nuIdAddress);
        FETCH cuAbaddress INTO nugeoloca, sbaddress;
        CLOSE cuAbaddress;
        pkg_traza.trace(csbMetodo||' nugeoloca: '||nugeoloca, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' sbaddress: '||sbaddress, csbNivelTraza);

        --Se valida si el parámetro tipo de recepción es nulo
        pkg_traza.trace(csbMetodo||' nucausal: '||nucausal, csbNivelTraza);

        IF (inuRecepTipo IS NULL) THEN
            ONUERRORCODE := -1;
            OSBERRORMESSAGE := 'El parámetro tipo de recepción está nulo';
        ELSE
            OPEN cuNuCausal(nucausal);
            FETCH cuNuCausal INTO sbDescripcion;
            CLOSE cuNuCausal;

            sbDescripcion := sbobservacion;
            pkg_traza.trace(csbMetodo||' sbDescripcion: '||sbDescripcion, csbNivelTraza);

            pkg_traza.trace(csbMetodo||' nutipocausal: '||nutipocausal, csbNivelTraza);

            sbXML:= pkg_xml_soli_aten_cliente.getSolicitudDuplicadoKiosco(inuRecepTipo, --  inuMedioRecepcionId
                                                                          nususclient,  --   inuContactoId
                                                                          sbDescripcion,--   isbComentario
                                                                          3,            --   inuRelaSoliPredio
                                                                          nutipocausal, --   inuTipoCausal
                                                                          nucausal,     --   inuCausal
                                                                          inuSuscCodi,  --   inuContratoId
                                                                          sbaddress,    --   isbDireccion
                                                                          nuIdAddress,  --   inuDireccion
                                                                          nugeoloca     --   inuLocalidad
                                                                          );
            pkg_traza.trace(csbMetodo||' sbXML: '||sbXML, csbNivelTraza);

            api_RegisterRequestByXml (sbXML ,
                                      onuPackageId,
                                      onuMotiveId,
                                      ONUERRORCODE,
                                      OSBERRORMESSAGE);
            pkg_traza.trace(csbMetodo||' api_RegisterRequestByXml--> onuPackageId: '||onuPackageId, csbNivelTraza);
            pkg_traza.trace(csbMetodo||' api_RegisterRequestByXml--> onuMotiveId: '||onuMotiveId, csbNivelTraza);
            IF ONUERRORCODE = 0
            THEN
                --Por definicion del proceso actual para GDO se valida la cantidad de facturas adeudada
                COMMIT;
            END IF;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             ROLLBACK;
             pkg_error.geterror (onuErrorCode, osbErrorMessage);
             osbErrorMessage := osbErrorMessage || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
             pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
             ROLLBACK;
             osbErrorMessage := 'Error en proceso solicitud duplicado Kiosco: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
             pkg_error.seterror;
             pkg_error.geterror (onuErrorCode, osbErrorMessage);
             osbErrorMessage :=  osbErrorMessage || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
             pkg_traza.trace(csbMetodo||' osbErrorMessage: ' || osbErrorMessage, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
    END proSoliDuplicadoKiosco;
END LDCI_PKFACTKIOSCO_GDC;
/

PROMPT Otorgando permisos de ejecucion a LDCI_PKFACTKIOSCO_GDC
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKFACTKIOSCO_GDC','ADM_PERSON');
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKFACTKIOSCO_GDC to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKFACTKIOSCO_GDC to INTEGRADESA;
GRANT EXECUTE on ADM_PERSON.LDCI_PKFACTKIOSCO_GDC to REXEINNOVA;
/


