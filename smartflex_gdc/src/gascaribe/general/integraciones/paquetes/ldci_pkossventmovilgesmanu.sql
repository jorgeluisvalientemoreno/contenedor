create or replace PACKAGE LDCI_PKOSSVENTMOVILGESMANU AS
  /************************************************************************
   PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

           PAQUETE : LDCI_PKOSSVENTMOVILGESMANU
           AUTOR   : Karem Baquero
           FECHA   : 12/05/2015
           RICEF   :
   DESCRIPCION : Paquete de integración que contiene todas las funcionalidades referentes
                 a las ventas moviles para gestion Manual

   Historia de Modificaciones

   Autor            Fecha       Descripcion.
   KARBAQ           12/05/2015  Creación DEL PAQUETE
   Eduardo Cerón    23/04/2018  Caso 200-1559. Se modifica <Generateventfor>
   jpinedc          29/01/2024  OSF-2023: ProcSaleCotizaProcess - Se cambia
                                OS_REGISTERREQUESTWITHXML por API_REGISTERREQUESTBYXML
  ************************************************************************/
  -- Variables
    sbCouponAttribs      VARCHAR2(3000);

  /*Tipo Record para Lineas*/
  TYPE rectasint IS RECORD(
    LINE_ID           LD_FINAN_PLAN_FNB.LINE_ID%type,
    DESCRIPTION       LD_LINE.DESCRIPTION%type,
    FINAN_PLAN_FNB_ID LD_FINAN_PLAN_FNB.FINAN_PLAN_FNB_ID%type,
    FINANCING_PLAN_ID LD_FINAN_PLAN_FNB.FINANCING_PLAN_ID%type,
    PLDIDESC          PLANDIFE.PLDIDESC%type,
    CATEGORY_ID       LD_FINAN_PLAN_FNB.CATEGORY_ID%type,
    CATEDESC          CATEGORI.CATEDESC%type,
    PLDICUMI          PLANDIFE.PLDICUMI%type,
    PLDICUMA          PLANDIFE.PLDICUMA%type,
    PLDITAIN          PLANDIFE.PLDITAIN%type,
    COTIPORC          CONFTAIN.COTIPORC%type,
    TASA_NNAL_MENSUAL number);

  TYPE tbtsaint IS TABLE OF rectasint;
  rectasinte tbtsaint := tbtsaint();

  /*variables globales*/

  sbsqlcertificate           Varchar2(32767);
  sbsqlcertificatesf         Varchar2(20000);
  sbsqlcertificateoia        Varchar2(20000);
  sbcertificateattributes    Varchar2(10000);
  sbcertificatesfattributes  Varchar2(4000);
  sbcertificateoiaattributes Varchar2(4000);

  /**/
  Function FsbgetValidApli(inucuota      in servsusc.sesususc%type,
                           inuRaiseError in number default 1)
    return ld_parameter.value_chain%type;

  Function Fnugetsesunuse(inususcripc   in servsusc.sesususc%type,
                          inuRaiseError in number default 1)
    return servsusc.sesunuse%type;
  -----------------------------------------------------------
  PROCEDURE FillsalecotiAttributes;
  ----------------------------------------------------------------------
  PROCEDURE Getsalescoti(isbIdorden     in Ldci_CotiVentasMovil.order_id%type,
                         isbIdsolicitud in Ldci_CotiVentasMovil.solicitud_generada%type,
                         Isbestadi      in Ldci_CotiVentasMovil.Estado%type,
                         isbidentification in LDCI_COTIVENTASMOVIL.IDENTIFICATION%type,
                         ocuCursor      out constants.tyRefCursor);
  ----------------------------------------------------------------------

  PROCEDURE Getsalescotis(iscoti    in Ldci_CotiVentasMovil.cotizacion_venta_id %type,
                          ocuCursor out constants.tyRefCursor);
  ----------------------------------------------------------------------
  PROCEDURE FillSalePromSFAttributes;
  -----------------------------------------------------------------
  PROCEDURE GetPromocionSF(iscoti    in Ldci_CotiVentasMovil.cotizacion_venta_id %type,
                           ocuCursor out constants.tyRefCursor);
  -----------------------------------------------------------------------------
  PROCEDURE FillSalecontactoAttributes;
  ----------------------------------------------------------------------
  PROCEDURE GetSaleSFBycontacto(iscoti    in Ldci_CotiVentasMovil.cotizacion_venta_id %type,
                                ocuCursor out constants.tyRefCursor);

  ------------------------------------------------------------------------------
  PROCEDURE ProcSaleCotizaconsulta(isbsalecoti     IN VARCHAR2,
                                   onutypeID       OUT VARCHAR2,
                                   ONUIDENTI       OUT VARCHAR2,
                                   ONUNOMBRE       OUT VARCHAR2,
                                   OSBAPELLIDO     OUT VARCHAR2,
                                   ONUVALORTO      OUT VARCHAR2,
                                   onucuotini      OUT VARCHAR2,
                                   ONUVALORCUO     OUT VARCHAR2,
                                   onuErrorCode    OUT NUMBER,
                                   osbErrorMessage OUT VARCHAR2);
  ----------------------------------------------------------------------

  -----------------------------------------------------------------------

  PROCEDURE ProcSaleCotizaProcess;

  ---------------------------------------------------------------------------------

  PROCEDURE FillSaleReferencAttributes;
  --------------------------------------------------------------------------------
  PROCEDURE GetSaleReferenc(iscoti    in Ldci_CotiVentasMovil.cotizacion_venta_id %type,
                            ocuCursor out constants.tyRefCursor);

---------------------------------------------------------------------------------


  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del método: fblExisteVentaCotizada
  Descripción:        Devuelve valor booleano indicando si existe la venta móvil cotizada.

  Autor    : KCienfuegos
  Fecha    : 29-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
  29-08-2016   KCienfuegos           Creación
  ******************************************************************/
  FUNCTION fblExisteVentaCotizada(inuVentaCotizada ldci_cotiventasmovil.cotizacion_venta_id%TYPE)
    RETURN BOOLEAN;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del método: fcrVentaMovil
  Descripción:        Devuelve los datos de la venta movil cotizada.

  Autor    : KCienfuegos

  Fecha    : 29-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
  29-08-2016   KCienfuegos            Creación
  ******************************************************************/
  FUNCTION fcrVentaMovil(inuVenta    IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: fcrPromociones
  Descripción:        Obtiene las promociones de la venta

  Autor    : KCienfuegos

  Fecha    :  29-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
   29-08-2016  KCienfuegos                   Creación
  ******************************************************************/
  FUNCTION fcrPromociones(inuVenta    IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: fcrContactos
  Descripción:        Obtiene los contactos de la venta

  Autor    : KCienfuegos

  Fecha    :  29-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
   29-08-2016  KCienfuegos                   Creación
  ******************************************************************/
  FUNCTION fcrContactos(inuVenta    IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: fcrReferencias
  Descripción:        Obtiene las referencias de la venta

  Autor    : KCienfuegos

  Fecha    :  29-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
   29-08-2016  KCienfuegos                   Creación
  ******************************************************************/
  FUNCTION fcrReferencias(inuVenta    IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: fcrPlanesFinanciacion
  Descripción:        Obtiene los planes de financiación

  Autor    : KCienfuegos

  Fecha    :  29-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                      Modificación
  -----------  -------------------            -------------------------------------
   29-08-2016  KCienfuegos.CA200-37           Creación
  ******************************************************************/
  FUNCTION fcrPlanesFinanciacion(inuVenta    IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proCreaPromociones
  Descripción:        Registra las promociones para la venta móvil

  Autor    : KCienfuegos

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
   30-08-2016  KCienfuegos                   Creación
  ******************************************************************/
  PROCEDURE proCreaPromociones(inuVenta             IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE,
                               inuIdPromocion       IN ldci_cotivenmovpromo.promotion_id%TYPE);

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proCreaContactos
  Descripción:        Registra los contactos para la venta móvil

  Autor    : KCienfuegos

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
   30-08-2016  KCienfuegos                   Creación
  ******************************************************************/
  PROCEDURE proCreaContactos(inuVenta             IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE,
                             inuTipoTel           IN ldci_cotivenmovteco.phone_type_id%TYPE,
                             inuTelefono          IN ldci_cotivenmovteco.phone%TYPE);

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proCreaReferencias
  Descripción:        Registra las referencias para la venta móvil

  Autor    : KCienfuegos

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
   30-08-2016  KCienfuegos                   Creación
  ******************************************************************/
  PROCEDURE proCreaReferencias(inuVenta             IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE,
                               inuTipoRef           IN ldci_cotivenmovrefe.reference_type_id%TYPE,
                               isbNombre            IN ldci_cotivenmovrefe.name_%TYPE,
                               isbApellido          IN ldci_cotivenmovrefe.last_name%TYPE,
                               inuDireccion         IN ldci_cotivenmovrefe.address_id%TYPE,
                               isbTelefono          IN ldci_cotivenmovrefe.phone%TYPE);

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proModifDatosVenta
  Descripción:        Modifica los datos de la venta

  Autor    : KCienfuegos

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
   30-08-2016  KCienfuegos                   Creación
  ******************************************************************/
   PROCEDURE proModifDatosVenta(inuVenta                IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE,
                               inuDireccion            IN ldci_cotiventasmovil.direccion%TYPE,
                               inuFormulario           IN ldci_cotiventasmovil.document_key%TYPE,
                               isbTipoId               IN ldci_cotiventasmovil.tipo_de_identificacion%TYPE,
                               isbIdentificacion       IN ldci_cotiventasmovil.identification%TYPE,
                               isbNombre               IN ldci_cotiventasmovil.subscriber_name%TYPE,
                               isbApellido             IN ldci_cotiventasmovil.apellido%TYPE,
                               isbCorreo               IN ldci_cotiventasmovil.correo_electronico%TYPE,
                               inuEnergAnt             IN ldc_tipo_energetico.codigo%TYPE,
                               inuPlanComercial        IN ldci_cotiventasmovil.commercial_plan_id%TYPE,
                               inuPlanFinanciacion     IN ldci_cotiventasmovil.plan_de_financiacion%TYPE,
                               inuValorTotal           IN ldci_cotiventasmovil.total_value%TYPE,
                               inuCantCuotas           IN ldci_cotiventasmovil.numero_de_cuotas%TYPE,
                               inuCuotaInicial         IN ldci_cotiventasmovil.initial_payment%TYPE,
                               inuCuotaMensual         IN ldci_cotiventasmovil.cuota_mensual%TYPE,
                               inuTecnicoVentas        IN ldci_cotiventasmovil.tecnicos_ventas_id%TYPE,
                               inuUnidadInstaladora    IN ldci_cotiventasmovil.und_instaladora_id%TYPE,
                               inuUnidadCertificadora  IN ldci_cotiventasmovil.und_certificadora_id%TYPE,
                               inuTIPO_PREDIO          IN LDCI_COTIVENTASMOVIL.TIPO_PREDIO%type,
                               isbPREDIO_INDE          IN LDCI_COTIVENTASMOVIL.PREDIO_INDE%type,
                               inuCONTRATO             IN LDCI_COTIVENTASMOVIL.CONTRATO%type,
                               isbMEDIDOR              IN LDCI_COTIVENTASMOVIL.MEDIDOR%type,
                               inuESTALEY              IN LDCI_COTIVENTASMOVIL.ESTALEY%type,
                               isbCONSTRUCCION         IN LDCI_COTIVENTASMOVIL.CONSTRUCCION%type,
                               isbObservacion          IN ldci_cotiventasmovil.comment_%TYPE);
  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proModifPromociones
  Descripción:        Modifica las promociones para la venta móvil

  Autor    : KCienfuegos

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
   30-08-2016  KCienfuegos                   Creación
  ******************************************************************/
  PROCEDURE proModifPromociones(inuVenta             IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE,
                                inuIdPromocion       IN ldci_cotivenmovpromo.promotion_id%TYPE,
                                inuId                IN VARCHAR2,
                                isbOpcion            IN VARCHAR2);

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proModifContactos
  Descripción:        Modifica los contactos para la venta móvil

  Autor    : KCienfuegos

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
   30-08-2016  KCienfuegos                   Creación
  ******************************************************************/
  PROCEDURE proModifContactos(inuVenta             IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE,
                              inuId                IN VARCHAR2,
                              inuTipoTel           IN ldci_cotivenmovteco.phone_type_id%TYPE,
                              inuTelefono          IN ldci_cotivenmovteco.phone%TYPE,
                              isbOpcion            IN VARCHAR2);

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proModifReferencias
  Descripción:        Modifica las referencias para la venta móvil

  Autor    : KCienfuegos

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
   30-08-2016  KCienfuegos                   Creación
  *********************************************************
  ******************************************************************/
  PROCEDURE proModifReferencias(inuVenta             IN ldci_cotivenmovrefe.cotizacion_venta_id%TYPE,
                                inuTipoReferencia    IN ldci_cotivenmovrefe.reference_type_id%TYPE,
                                isbNombre            IN ldci_cotivenmovrefe.name_%TYPE,
                                isbApellido          IN ldci_cotivenmovrefe.last_name%TYPE,
                                inuDireccion         IN ldci_cotivenmovrefe.address_id%TYPE,
                                isbTelefono          IN ldci_cotivenmovrefe.phone%TYPE,
                                inuId                IN VARCHAR2,
                                isbOpcion            IN VARCHAR2);

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proRegistrarBackup
  Descripción:        Registra el backup de la información original de las ventas móviles
                      cotizadas.

  Autor    : KCienfuegos

  Fecha    :  01-09-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
   01-09-2016  KCienfuegos                   Creación
  *********************************************************
  ******************************************************************/
  PROCEDURE proRegistrarBackup(inuVenta  IN ldci_cotivenmovrefe.cotizacion_venta_id%TYPE);

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proValidaFormulario
  Descripción:        Método para validar el formulario

  Autor    : KCienfuegos

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
   30-08-2016  KCienfuegos            Creación
  ******************************************************************/
  PROCEDURE proValidaFormulario(inuVenta             IN ldci_cotivenmovrefe.cotizacion_venta_id%TYPE,
                                inuFormulario        IN fa_consdist.codinuin%TYPE,
                                inuTipoFormulario    IN fa_consdist.coditico%TYPE);

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: ProcArmaXMLVenta
  Descripción:        Método para validar el formulario

  Autor    : NCarrasquilla

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                      Modificación
  -----------  -------------------           	-------------------------------------
   30-08-2016   NCarrasquilla.CA200-37        Creación.
   02-09-2016   KCienfuegos.CA200-37          Modificación.
  ******************************************************************/
  PROCEDURE ProcArmaXMLVenta (nuVentaId  ldci_cotiventasmovil.cotizacion_venta_id%TYPE,
                              sbXML        OUT VARCHAR2);

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: fnuAplicaEntrega
  Descripción:        Función para validar si la entrega aplica para la gasera

  Autor    : KCienfuegos

  Fecha    :  01-09-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
   01-09-2016  KCienfuegos            Creación.
  ******************************************************************/
  FUNCTION fnuAplicaEntrega(isbNombreEntrega VARCHAR2)
    RETURN NUMBER;

  /**************************************************************************
    Propiedad intelectual de HORBATH.

    Unidad        : GetCoupon
    Descripcion   : Obtiene la informacion de los cupones para COVCM
    Autor         : Josh Brito - caso 200-2040
    ***************************************************************************/
    PROCEDURE GetCoupon
    (
        inuCoti     in   Ldci_CotiVentasMovil.cotizacion_venta_id%type, OCUCURSOR OUT CONSTANTS.TYREFCURSOR
    );


END LDCI_PKOSSVENTMOVILGESMANU;
/

create or replace PACKAGE BODY LDCI_PKOSSVENTMOVILGESMANU AS

  nuPorcentajeMax CONSTANT NUMBER:=100;
  nuTipoDocuForm  CONSTANT NUMBER:=135;
  cnuClasifVended CONSTANT NUMBER:= 22;

  Function Fnugetsesunuse(inususcripc   in servsusc.sesususc%type,
                          inuRaiseError in number default 1)
    return servsusc.sesunuse%type is

    /***************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

             PAQUETE : LDCI_PKCRMFINBRILLAPORTAL.Fnugetsesunuse
             AUTOR   : Sincecomp/Karem Baquero
             FECHA   : 30/07/2014
             RICEF   : l078
       DESCRIPCION   : Se realizala consulta del servicio suscrito
                       a traves del suscriptor para el registro de la venta brilla
                       con solicitud de venta FNB.
     Parametros de Salida

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
     KARBAQ       12/05/2015    Creaci?n DEL PAQUETE
    **************************************************************************/

    nusesunuse servsusc.sesunuse%type;
    cnuInactiveService constant servsusc.sesuesco%type := 96;

    CURSOR cuProduct IS
      SELECT /*+ leading( a )
                                              index( a IDX_PR_PRODUCT_010 )
                                              index( s PK_SERVSUSC )
                                              index( c PK_PS_PRODUCT_STATUS ) */
       s.sesunuse
        FROM pr_product a, servsusc s, ps_product_status c
       WHERE a.subscription_id = inususcripc
         AND a.product_type_id = ld_boconstans.cnuGasService
         AND s.sesunuse = a.product_id
         AND (s.sesufere is null OR s.sesufere > sysdate)
         AND a.product_status_id = c.product_status_id --
         AND c.is_active_product = 'Y'
         and c.is_final_status = 'Y'
         AND s.sesuesco <> cnuInactiveService
         And rownum = 1;

  Begin
    ut_trace.trace('Inicio LDCI_PKOSSVENTMOVILGESMANU.Fnugetsesunuse', 10);

    open cuProduct;
    fetch cuProduct
      INTO nusesunuse;
    close cuProduct;

    ut_trace.trace('Fin LDCI_PKOSSVENTMOVILGESMANU.Fnugetsesunuse ', 10);
    Return(nusesunuse);

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      if inuRaiseError = 1 then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  End Fnugetsesunuse;

  ---------------------------------------------------------------------------
  ---------------------------------------------------------------------------

  Function FsbgetValidApli(inucuota      in servsusc.sesususc%type,
                           inuRaiseError in number default 1)

   return ld_parameter.value_chain%type is

    sbvaliapli varchar2(1);
    sbparametr ld_parameter.value_chain%type;

  begin
    ut_trace.trace('Inicio LDCI_PKOSSVENTMOVILGESMANU.FsbgetValidApli', 10);

    if inucuota > 0 then

      sbparametr := dald_parameter.fsbGetValue_Chain('VALIDA_REGIS_COTI_VENTA_MOVIL');

      if sbparametr = ld_boconstans.csbokFlag then

        sbvaliapli := ld_boconstans.csbokFlag;
      else
        sbvaliapli := ld_boconstans.csbNOFlag;
      end if;

    else
      sbvaliapli := ld_boconstans.csbokFlag;
    end if;

    ut_trace.trace('Fin LDCI_PKOSSVENTMOVILGESMANU.FsbgetValidApli ', 10);

    Return(sbvaliapli);

  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      if inuRaiseError = 1 then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  End FsbgetValidApli;

  --------------------------------------------------------------------
  ---------------------------------------------------------------------
  ---------------------------------------------------------------------

  PROCEDURE ProcSaleCotizaconsulta(isbsalecoti     IN VARCHAR2,
                                   onutypeID       OUT VARCHAR2,
                                   ONUIDENTI       OUT VARCHAR2,
                                   ONUNOMBRE       OUT VARCHAR2,
                                   OSBAPELLIDO     OUT VARCHAR2,
                                   ONUVALORTO      OUT VARCHAR2,
                                   onucuotini      OUT VARCHAR2,
                                   ONUVALORCUO     OUT VARCHAR2,
                                   onuErrorCode    OUT NUMBER,
                                   osbErrorMessage OUT VARCHAR2) IS
    -- Declaracion de variables

    Cursor cucotivent is
      select l.tipo_de_identificacion,
             l.identification,
             l.subscriber_name,
             l.apellido,
             l.total_value,
             l.initial_payment,
             l.cuota_mensual
        from Ldci_CotiVentasMovil l
       where l.cotizacion_venta_id = isbsalecoti
      /*       and l.estado= any('P','E')*/
      ;

  BEGIN

    if isbsalecoti is not null then
      open cucotivent;
      fetch cucotivent
        into onutypeID,
             ONUIDENTI,
             ONUNOMBRE,
             OSBAPELLIDO,
             ONUVALORTO,
             onucuotini,
             ONUVALORCUO;
      close cucotivent;

    else

      osbErrorMessage := 'El Id. De la venta se encuentra en blanco';
      RAISE ex.CONTROLLED_ERROR;
    end if;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END;

    /************************************************************************
  
        PROGRAMA : ProcSaleCotizaProcess
        AUTOR   : Karem Baquero
        FECHA   : 12/05/2015
        RICEF   :
        DESCRIPCION : 

        Historia de Modificaciones

        Autor            Fecha          Descripcion.
        KARBAQ           12/05/2015     Creación
        jpinedc          26/01/2024     OSF-2023: Se cambia OS_REGISTERREQUESTWITHXML 
                                        por API_REGISTERREQUESTBYXML
    ************************************************************************/  

    PROCEDURE ProcSaleCotizaProcess  IS
    
        -- Declaracion de variables
        NUCOTI LDCI_COTIVENTASMOVIL.COTIZACION_VENTA_ID%type;
        onumensaje LDCI_COTIVENTASMOVIL.MENSAJE_ID%type;
        onuorder    LDCI_COTIVENTASMOVIL.Order_Id%type;
        isbXMLVenta     Clob;
        sbXMlvent       varchar2(10000);
        nuMotiveId     mo_motive.motive_id%type;
        onuPack     mo_packages.package_id%type;
        onuErrorCodi    NUMBER;
        osbErrorMsg  VARCHAR2(4000);
        nuVentaModi      NUMBER;
        sbXML            VARCHAR2(32767);

        cursor cuventa(inucotiv number) is
        SELECT l.mensaje_id,l.order_id
        FROM LDCI_COTIVENTASMOVIL l
        where l.cotizacion_venta_id = inucotiv
        and l.estado in ('R','E');-- JJJM

        cursor cuinforadi (inuorden number, inumens number )is
        select l.xml_solicitud from ldci_infgestotmov l
        where l.mensaje_id=inumens
        and l.order_id=inuorden;

        -- Cursor para extraer el segmento de XML en texto con la informacion de la venta
        Cursor cuXMLVenta(isbXMLDat In Clob) Is
        Select Replace(Replace(XMLElement("DAT", Datos.XML).getStringVal(),
                             '<DAT>'),
                     '</DAT>') XML
        From XMLTable('/' Passing XMLType(isbXMLDat) Columns XML XMLType Path
                      'P_VENTA_DE_GAS_POR_FORMULARIO_XML_100233') As Datos;

    BEGIN

        ut_trace.Trace('INICIO LDCI_PKOSSVENTMOVILGESMANU.ProcSaleCotizaProcess',
                       10);

        /*obtener los valores ingresados en la aplicacion PB LDCI_PVCM*/
        NUCOTI := ge_boInstanceControl.fsbGetFieldValue('LDCI_COTIVENTASMOVIL','COTIZACION_VENTA_ID');

        open cuventa(NUCOTI);
        fetch cuventa into onumensaje, onuorder;

        IF cuventa%FOUND THEN

            -- CA 200-37. se actualiza el XML si la venta, fue mmodificada
            SELECT count(1) into nuVentaModi
            FROM LDC_COTIVENTASMOVILBACKUP l
            WHERE l.cotizacion_venta_id = NUCOTI;

            IF ( nuVentaModi > 0 ) THEN

                -- Arma el XML con los datos modificados
                ProcArmaXMLVenta ( NUCOTI, sbXML );
                
                --Actualiza el campo con el nuevo XML
                UPDATE ldci_infgestotmov l
                SET l.xml_solicitud = sbXML
                WHERE l.mensaje_id = onumensaje
                AND l.order_id = onuorder;

                UT_TRACE.TRACE('Traza '||sbXML, 10);

            END IF;

            open cuinforadi(onuorder,onumensaje);
            fetch cuinforadi into isbXMLVenta;
            close cuinforadi;
            close cuventa;
            
        ELSE
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'Esta venta ya fue procesada, favor revisar: '|| NUCOTI);
        END IF;

        Open cuXMLVenta(isbXMLVenta);
        Fetch cuXMLVenta Into sbXMlvent;
        Close cuXMLVenta;

        -- Llamado a API de OSF para generar la venta por formulario XML
        API_REGISTERREQUESTBYXML(isbRequestXML   => sbXMlvent,
                                  onuPackageID    => onuPack,
                                  onuMotiveID     => nuMotiveId,
                                  onuErrorCode    => onuErrorCodi,
                                  osbErrorMessage => osbErrorMsg);

        -- Se valida la respuesta del API
        If onuErrorCodi = 0 Then

                     /*Inicio Karbaq 7132 Se actualiza los datos en la tabla de la informaci?n de ventas*/
            BEGIN
            
                UPDATE Ldci_CotiVentasMovil l
                   SET l.solicitud_generada = onuPack,
                       l.fecha_procesado    = sysdate,
                       l.estado             = 'A', -- JJJM
                       l.usuario= user
                 WHERE l.mensaje_id = onumensaje
                   AND l.order_id = onuorder;
            EXCEPTION
                When Others Then
                    onuErrorCodi := -1;
                    osbErrorMsg  := '[LDCI_PKGESTINFOADOT.proProcesaXMLVenta.Others]: ' ||
                                  SqlErrM;
                    UPDATE Ldci_CotiVentasMovil l
                     SET l.codigo_error  = onuErrorCodi,
                         l.mensaje_error = osbErrorMsg,
                          l.estado             = 'E',
                                             l.usuario= user
                    WHERE l.mensaje_id = onumensaje
                     AND l.order_id = onuorder;
            END;
          
        ELSE
        
            onuPack := Null;
            nuMotiveId  := Null;

            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       ' El proceso tiene el siguiente error: '|| ' - ' ||osbErrorMsg);

        END IF;

        COMMIT;

        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                           ' El proceso ha terminado satisfactoriamente, el numero de la solicutd registrado es: '|| onuPack);


        ut_trace.Trace('FIN LDCI_PKOSSVENTMOVILGESMANU.ProcSaleCotizaProcess',
                   10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            UPDATE Ldci_CotiVentasMovil l
            SET l.codigo_error  = onuErrorCodi,
            l.mensaje_error = osbErrorMsg,
            l.estado             = 'E',
            l.usuario= user
            WHERE l.mensaje_id = MENSAJE_ID
            AND l.order_id = onuorder;
            commit;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UPDATE Ldci_CotiVentasMovil l
            SET l.codigo_error  = onuErrorCodi,
            l.mensaje_error = osbErrorMsg,
            l.estado             = 'E',
            l.usuario= user
            WHERE l.mensaje_id = MENSAJE_ID
            AND l.order_id = onuorder;
            commit;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcSaleCotizaProcess;

  /*******************************************************************************
   Metodo: FillCertificateAttributes
   Descripcion:   Obtiene todos los datos a mostrar para un Certificado
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   05/04/2019     ELAL    se agregan nuevos campos numero de medidor, predio en construccion, predio de independizacion
                           contrato, estado de ley
   12/04/2014     LLOZADA - Creacion
   
  *******************************************************************************/

  PROCEDURE FillsalecotiAttributes IS

    sbPlazosCertId          varchar2(4000);
    sbIdContrato            varchar2(500);
    sbIdProducto            varchar2(500);
    sbPlazoMinimoRevision   varchar2(4000);
    sbPlazoMinimoSuspension varchar2(4000);
    sbPlazoMaximo           varchar2(4000);
    sbParent                varchar2(500);
    sbFromCertificate       varchar2(4000);
    sbJoinsCertificate      varchar2(4000);
    comment_                varchar2(4000);
    direccion               varchar2(4000);
    categoria               varchar2(4000);
    subcategoria            varchar2(4000);
    tipo_de_identificacion  varchar2(4000);
    identification          varchar2(4000);
    subscriber_name         varchar2(4000);
    apellido                varchar2(4000);
    company                 varchar2(4000);
    title                   varchar2(4000);
    correo_electronico      varchar2(4000);
    person_quantity         varchar2(4000);
    old_operator            varchar2(4000);
    venta_empaquetada       varchar2(4000);
    commercial_plan_id      varchar2(4000);
    total_value             varchar2(4000);
    plan_de_financiacion    varchar2(4000);
    initial_payment         varchar2(4000);
    numero_de_cuotas        varchar2(4000);
    cuota_mensual           varchar2(4000);
    init_payment_mode       varchar2(4000);
    init_pay_received       varchar2(4000);
    usage                   varchar2(4000);
    install_type            varchar2(4000);
    estado                  varchar2(4000);
    fecha_registro          varchar2(4000);
    fecha_procesado         varchar2(4000);
    codigo_error            varchar2(4000);
    mensaje_error           varchar2(4000);
    usuario                 varchar2(4000);
    solicitud_generada      varchar2(4000);
    modifixml               varchar2(4000);
    Fecha_modifixml         varchar2(4000);


  BEGIN
    -- Si ya existe una sentencia de atributos no se debe continuar
    if sbSqlCertificate IS not null then
      return;
    END if;

    -- Definicion de cada uno de los atributos
    sbPlazosCertId          := 'case'||chr(10)||
                               ' when Ldci_CotiVentasMovil.cotizacion_venta_id is not null then'||chr(10)||
                               ' Ldci_CotiVentasMovil.cotizacion_venta_id'||chr(10)||
                               ' else'||chr(10)||
                               ' (select cc_quotation.quotation_id from cc_quotation where package_id = or_order_activity.package_id and rownum = 1)'||chr(10)||
                               ' end cotizacion_venta_id';
    sbIdContrato            := 'Ldci_CotiVentasMovil.mensaje_id';
    sbIdProducto            := 'or_order_activity.order_id';
    sbPlazoMinimoRevision   := 'case'||chr(10)||
                               ' when Ldci_CotiVentasMovil.fecha_de_solicitud is not null then'||chr(10)||
                               ' Ldci_CotiVentasMovil.fecha_de_solicitud'||chr(10)||
                               ' else'||chr(10)||
                               ' damo_packages.fdtgetrequest_date(or_order_activity.package_id, 0)'||chr(10)||
                               ' end fecha_de_solicitud';
    sbPlazoMinimoSuspension := 'Ldci_CotiVentasMovil.person_id'||'||'||''''||' - '||''''||'||'||' (SELECT name_ FROM ge_person WHERE person_id = Ldci_CotiVentasMovil.person_id) as person_id ';--jjjm
    sbPlazoMaximo           := 'case'||chr(10)||
                               ' when Ldci_CotiVentasMovil.pos_oper_unit_id is not null then'||chr(10)||
                               ' Ldci_CotiVentasMovil.pos_oper_unit_id'||'||'||''''||' - '||''''||'||'||' (SELECT name FROM or_operating_unit WHERE operating_unit_id = Ldci_CotiVentasMovil.pos_oper_unit_id)'||chr(10)||
                               ' else'||chr(10)||
                               ' damo_packages.fnugetpos_oper_unit_id(or_order_activity.package_id, 0)'||'||'||''''||' - '||''''||'||'||' (SELECT name FROM or_operating_unit WHERE operating_unit_id = damo_packages.fnugetpos_oper_unit_id(or_order_activity.package_id, 0))'||chr(10)||
                               ' end pos_oper_unit_id';
    sbParent                := 'Ldci_CotiVentasMovil.document_type_id';
    comment_               := 'case'||chr(10)||
                              ' when Ldci_CotiVentasMovil.comment_ is not null then'||chr(10)||
                              ' Ldci_CotiVentasMovil.comment_'||chr(10)||
                              ' else'||chr(10)||
                              ' or_order_activity.comment_'||chr(10)||
                              ' end comment_';
    direccion              := 'case'||chr(10)||
                              ' when Ldci_CotiVentasMovil.direccion is not null then'||chr(10)||
                              ' Ldci_CotiVentasMovil.direccion'||'||'||''''||' - '||''''||'||'||' (SELECT d.address_parsed||'''||'  -  ''||l.description FROM ab_address d,ge_geogra_location l WHERE d.address_id = Ldci_CotiVentasMovil.direccion AND d.geograp_location_id = l.geograp_location_id)'||chr(10)||
                              ' else'||chr(10)||
                              ' or_order_activity.address_id'||'||'||''''||' - '||''''||'||'||' (SELECT d.address_parsed||'''||'  -  ''||l.description FROM ab_address d,ge_geogra_location l WHERE d.address_id = or_order_activity.address_id AND d.geograp_location_id = l.geograp_location_id)'||chr(10)||
                              ' end direccion';--jjjm
    categoria              := 'case'||chr(10)||
                              ' when Ldci_CotiVentasMovil.categoria is not null then'||chr(10)||
                              ' Ldci_CotiVentasMovil.categoria'||'||'||''''||' - '||''''||'||'||' (SELECT catedesc FROM categori WHERE catecodi = Ldci_CotiVentasMovil.categoria)'||chr(10)||
                              ' when or_order_activity.product_id is not null then'||chr(10)||
                              ' pktblservsusc.fnugetsesucate(or_order_activity.product_id)'||'||'||''''||' - '||''''||'||'||' (SELECT catedesc FROM categori WHERE catecodi = pktblservsusc.fnugetsesucate(or_order_activity.product_id))'||chr(10)||
                              ' else'||chr(10)||
                              ' null'||chr(10)||
                              ' end categoria';--jjjm
    subcategoria           := 'case'||chr(10)||
                              ' when Ldci_CotiVentasMovil.subcategoria is not null then'||chr(10)||
                              ' Ldci_CotiVentasMovil.subcategoria'||'||'||''''||' - '||''''||'||'||' (SELECT sucadesc FROM subcateg WHERE sucacate = Ldci_CotiVentasMovil.categoria AND sucacodi = Ldci_CotiVentasMovil.subcategoria)'||chr(10)||
                              ' when or_order_activity.product_id is not null then'||chr(10)||
                              ' pktblservsusc.fnugetsesusuca(or_order_activity.product_id)'||'||'||''''||' - '||''''||'||'||' (SELECT sucadesc FROM subcateg WHERE sucacate = pktblservsusc.fnugetsesucate(or_order_activity.product_id) AND sucacodi = pktblservsusc.fnugetsesusuca(or_order_activity.product_id))'||chr(10)||
                              ' else'||chr(10)||
                              ' null'||chr(10)||
                              ' end subcategoria';--jjjm
    tipo_de_identificacion := 'case'||chr(10)||
                              ' when Ldci_CotiVentasMovil.tipo_de_identificacion is not null then'||chr(10)||
                              ' Ldci_CotiVentasMovil.tipo_de_identificacion'||chr(10)||
                              ' else'||chr(10)||
                              ' dage_subscriber.fnugetident_type_id(or_order_activity.subscriber_id,0)'||chr(10)||
                              ' end tipo_de_identificacion';
    identification         := 'case'||chr(10)||
                              ' when Ldci_CotiVentasMovil.identification is not null then'||chr(10)||
                              ' Ldci_CotiVentasMovil.identification'||chr(10)||
                              ' else'||chr(10)||
                              ' dage_subscriber.fsbgetidentification(or_order_activity.subscriber_id,0)'||chr(10)||
                              ' end identification';
    subscriber_name        := 'case'||chr(10)||
                              ' when Ldci_CotiVentasMovil.subscriber_name is not null then'||chr(10)||
                              ' Ldci_CotiVentasMovil.subscriber_name'||chr(10)||
                              ' else'||chr(10)||
                              ' dage_subscriber.fsbgetsubscriber_name(or_order_activity.subscriber_id,0)'||chr(10)||
                              ' end subscriber_name';
    apellido               := 'case'||chr(10)||
                              ' when Ldci_CotiVentasMovil.apellido is not null then'||chr(10)||
                              ' Ldci_CotiVentasMovil.apellido'||chr(10)||
                              ' else'||chr(10)||
                              ' dage_subscriber.fsbgetsubs_last_name(or_order_activity.subscriber_id,0)'||chr(10)||
                              ' end apellido';
    company                := 'Ldci_CotiVentasMovil.company';
    title                  := 'Ldci_CotiVentasMovil.title';
    correo_electronico     := 'case'||chr(10)||
                              ' when Ldci_CotiVentasMovil.correo_electronico is not null then'||chr(10)||
                              ' Ldci_CotiVentasMovil.correo_electronico'||chr(10)||
                              ' else'||chr(10)||
                              ' dage_subscriber.fsbgete_mail(or_order_activity.subscriber_id,0)'||chr(10)||
                              ' end correo_electronico';
    person_quantity        := 'Ldci_CotiVentasMovil.person_quantity';
    old_operator           := 'Ldci_CotiVentasMovil.old_operator';
    venta_empaquetada      := 'Ldci_CotiVentasMovil.venta_empaquetada';
    commercial_plan_id     := 'Ldci_CotiVentasMovil.commercial_plan_id'||'||'||''''||' - '||''''||'||'||' (SELECT d.name FROM cc_commercial_plan d WHERE d.commercial_plan_id = Ldci_CotiVentasMovil.commercial_plan_id) as commercial_plan_id';--jjjm
    total_value            := 'Ldci_CotiVentasMovil.total_value';
    plan_de_financiacion   := 'Ldci_CotiVentasMovil.plan_de_financiacion'||'||'||''''||' - '||''''||'||'||' (SELECT pldidesc FROM plandife WHERE pldicodi = Ldci_CotiVentasMovil.plan_de_financiacion)as plan_de_financiacion';--jjjm
    initial_payment        := 'Ldci_CotiVentasMovil.initial_payment';
    numero_de_cuotas       := 'Ldci_CotiVentasMovil.numero_de_cuotas';
    cuota_mensual          := 'Ldci_CotiVentasMovil.cuota_mensual';
    init_payment_mode      := 'Ldci_CotiVentasMovil.init_payment_mode';
    init_pay_received      := 'Ldci_CotiVentasMovil.init_pay_received';
    usage                  := 'Ldci_CotiVentasMovil.usage';
    install_type           := 'Ldci_CotiVentasMovil.install_type';
    estado                 := 'Ldci_CotiVentasMovil.estado';
    fecha_registro         := 'case'||chr(10)||
                              ' when Ldci_CotiVentasMovil.fecha_registro is not null then'||chr(10)||
                              ' Ldci_CotiVentasMovil.fecha_registro'||chr(10)||
                              ' else'||chr(10)||
                              ' damo_packages.fdtgetrequest_date(or_order_activity.package_id,0)'||chr(10)||
                              ' end fecha_registro';
    fecha_procesado        := 'case'||chr(10)||
                              ' when Ldci_CotiVentasMovil.fecha_procesado is not null then'||chr(10)||
                              ' Ldci_CotiVentasMovil.fecha_procesado'||chr(10)||
                              ' else'||chr(10)||
                              ' damo_packages.fdtgetattention_date(or_order_activity.package_id,0)'||chr(10)||
                              ' end fecha_procesado';
    usuario                := 'case'||chr(10)||
                              ' when Ldci_CotiVentasMovil.usuario is not null then'||chr(10)||
                              ' Ldci_CotiVentasMovil.usuario'||chr(10)||
                              ' else'||chr(10)||
                              ' damo_packages.fsbgetuser_id(or_order_activity.package_id,0)'||chr(10)||
                              ' end usuario';
    solicitud_generada     := 'case'||chr(10)||
                              ' when Ldci_CotiVentasMovil.solicitud_generada is not null then'||chr(10)||
                              ' Ldci_CotiVentasMovil.solicitud_generada'||chr(10)||
                              ' else'||chr(10)||
                              ' or_order_activity.package_id'||chr(10)||
                              ' end solicitud_generada';
    codigo_error           := 'Ldci_CotiVentasMovil.codigo_error ';
    mensaje_error          := 'Ldci_CotiVentasMovil.mensaje_error ';
--    modifixml              := 'Ldci_CotiVentasMovil.codigo_error ';
  --  Fecha_modifixml        := 'Ldci_CotiVentasMovil.mensaje_error ';


    -- Conformacion de la cadena con los atributos
    sbCertificateAttributes := sbCertificateAttributes || sbPlazosCertId || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || sbIdContrato ||
                               ' , ' || chr(10);
    sbCertificateAttributes := sbCertificateAttributes || sbIdProducto || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes ||
                               sbPlazoMinimoRevision || ', ' || chr(10);
    sbCertificateAttributes := sbCertificateAttributes ||
                               sbPlazoMinimoSuspension || ', ' || chr(10);
    sbCertificateAttributes := sbCertificateAttributes || sbPlazoMaximo || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || sbParent || ', ' ||
                               chr(10);

    sbCertificateAttributes := sbCertificateAttributes || comment_ || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || direccion || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || categoria || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || subcategoria || ', ' ||
                               chr(10);

    sbCertificateAttributes := sbCertificateAttributes ||
                               tipo_de_identificacion || ', ' || chr(10);
    sbCertificateAttributes := sbCertificateAttributes || identification || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || subscriber_name || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || apellido || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || company || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || title || ', ' ||
                               chr(10);

    sbCertificateAttributes := sbCertificateAttributes ||
                               correo_electronico || ', ' || chr(10);
    sbCertificateAttributes := sbCertificateAttributes || person_quantity || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || old_operator || ', ' ||
                               chr(10);

    sbCertificateAttributes := sbCertificateAttributes || venta_empaquetada || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes ||
                               commercial_plan_id || ', ' || chr(10);
    sbCertificateAttributes := sbCertificateAttributes || total_value || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes ||
                               plan_de_financiacion || ', ' || chr(10);

    sbCertificateAttributes := sbCertificateAttributes || initial_payment || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || numero_de_cuotas || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || cuota_mensual || ', ' ||
                               chr(10);

    sbCertificateAttributes := sbCertificateAttributes || init_payment_mode || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || init_pay_received || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || usage || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || install_type || ', ' ||
                               chr(10);

    sbCertificateAttributes := sbCertificateAttributes || estado || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || fecha_registro || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || fecha_procesado || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || usuario || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes ||
                               solicitud_generada || ', ' || chr(10);

   
    sbCertificateAttributes := sbCertificateAttributes || '(select PERSON_OPER_UNIT_ID||'||''''||' - '||''''||'|| PERSON_NAME from LD_PERSON_OPER_UNIT where PERSON_OPER_UNIT_ID = Ldci_CotiVentasMovil.TECNICOS_VENTAS_ID) TECNICOS_VENTAS_ID' || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || '(select OPERATING_UNIT_ID ||'||''''||' - '||''''||'|| NAME FROM or_operating_unit where  OPERATING_UNIT_ID = Ldci_CotiVentasMovil.UND_INSTALADORA_ID) UND_INSTALADORA_ID ' || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || '(select OPERATING_UNIT_ID||'||''''||' - '||''''||'|| NAME FROM or_operating_unit where  OPERATING_UNIT_ID = Ldci_CotiVentasMovil.UND_CERTIFICADORA_ID) UND_CERTIFICADORA_ID ' || ', ' ||
                               chr(10);
                               
    --INICIO CA 200-2437 
    sbCertificateAttributes := sbCertificateAttributes ||'(SELECT PREMISE_TYPE_ID||'||''''||' - '||''''||'||DESCRIPTION FROM AB_PREMISE_TYPE WHERE PREMISE_TYPE_ID = LDCI_COTIVENTASMOVIL.TIPO_PREDIO) TIPO_PREDIO, ' ||chr(10);
    sbCertificateAttributes := sbCertificateAttributes ||'decode(LDCI_COTIVENTASMOVIL.PREDIO_INDE, ''Y'',''SI'',''NO'') PREDIO_INDE, '||chr(10); 
    sbCertificateAttributes := sbCertificateAttributes ||'LDCI_COTIVENTASMOVIL.CONTRATO, '	||chr(10);   
    sbCertificateAttributes := sbCertificateAttributes ||'LDCI_COTIVENTASMOVIL.MEDIDOR, '	||chr(10);   
    sbCertificateAttributes := sbCertificateAttributes ||'DECODE(LDCI_COTIVENTASMOVIL.ESTALEY, 1, ''1 - AUTORIZA'',''2 - NO AUTORIZA'') ESTALEY, '	||chr(10);   
    sbCertificateAttributes := sbCertificateAttributes ||'decode(LDCI_COTIVENTASMOVIL.CONSTRUCCION, ''Y'',''SI'',''NO'') CONSTRUCCION, '||chr(10);
       
    --FIN CA 200-2437
    
    sbCertificateAttributes := sbCertificateAttributes || codigo_error || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || mensaje_error ||
                               chr(10);
                          

    -- Definicion del FROM con las dos tablas origen de datos
    sbFromCertificate := 'FROM LDCI_COTIVENTASMOVIL, or_order_activity' || chr(10);
    sbJoinsCertificate := 'WHERE or_order_activity.order_id = LDCI_COTIVENTASMOVIL.order_id'|| chr(10);
    --[12042014]LLOZADA: NO SE USA PARA EL PI CERTRP
    -- Relacion entre las tablas origen de datos
    --sbJoinsCertificate     :=  'WHERE  LDC_PLAZOS_CERT.ID_CONTRATO = PAG_ID_PRODUCTO_type.ID_CONTRATO' ||chr(10);

    --  la sentencia con todos los componentes comunes
    sbSqlCertificate := 'SELECT ' || chr(10);
    sbSqlCertificate := sbSqlCertificate || sbCertificateAttributes;
    sbSqlCertificate := sbSqlCertificate || sbFromCertificate;
    sbSqlCertificate := sbSqlCertificate || sbJoinsCertificate;



  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END;

  /*******************************************************************************
   Metodo: Getsalescoti
   Descripcion:   Obtiene todos las ventas que cumplan con los criterios de
                  seleccion indicados por el usuario
   Autor: KBaquero
   Fecha: Agosto 13/2015

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   15/08/2015     KBaquero       - Creaci?n
   03/10/2018     JOSH BRITO     CASO 200-2040 si la entrega aplica, y los dias depues de la fecha de legalizacion
                                 superan la configuradad en el parametro PARDIASVERVISITADESPLEG se visualizaran las ordenes


  *******************************************************************************/

  PROCEDURE Getsalescoti(isbIdorden        in LDCI_COTIVENTASMOVIL.ORDER_ID%type,
                         isbIdsolicitud    in Ldci_CotiVentasMovil.solicitud_generada%type,
                         Isbestadi         in Ldci_CotiVentasMovil.Estado%type,
                         isbidentification in LDCI_COTIVENTASMOVIL.IDENTIFICATION%type,                       
                         ocuCursor         out constants.tyRefCursor) IS

    sbSqlFinal varchar2(15000);
    sbFilters  varchar2(4000);
    --nuParent varchar2(100);

  BEGIN

    -- Las validaciones a continuacion funcionan de la siguiente manera:
    -- Si viene nulo genera instruccion igual en ambos lados del igual para que ignore la condicion
    -- Si no, concatena a la instruccion el parametro que recibe el valor digitado por el usuario


    -- Valida el orden
    if isbIdorden is not null then
      sbFilters := sbFilters ||
                   ' AND or_order_activity.order_id = :IDORDER' ||
                   chr(10);
    else
      sbFilters := sbFilters ||
                   ' AND or_order_activity.order_id = nvl( :IDORDER,or_order_activity.order_id)' ||

                   chr(10);
    END if;

    -- En las siguientes validaciones se debe evaluar el nulo, para saber cuando concatenar los %
    -- de manera que funcione el like

    -- Valida la solicitud
    if isbIdsolicitud is not null then
      sbFilters := sbFilters ||
                   ' and or_order_activity.PACKAGE_ID = :IDPACK ' ||
                   chr(10);
    else
      sbFilters := sbFilters ||
                   ' and or_order_activity.PACKAGE_ID = nvl(:IDPACK , or_order_activity.PACKAGE_ID ) ' ||
                   chr(10);
    END if;

    ---
    -- Valida la identificacion
    if Isbestadi is not null then
      sbFilters := sbFilters ||
                   ' and Ldci_CotiVentasMovil.Estado = :IDest ' || chr(10);
    else
      sbFilters := sbFilters ||
                   ' and Ldci_CotiVentasMovil.Estado = nvl(:IDest , Ldci_CotiVentasMovil.Estado ) ' ||
                   chr(10);
    END if;


       -- Valida el orden
    if isbidentification is not null then
      sbFilters := sbFilters ||
                    ' and    Ldci_CotiVentasMovil.IDENTIFICATION = :isbidentification'||chr(10);

    else
      sbFilters := sbFilters ||
                    ' AND Ldci_CotiVentasMovil.IDENTIFICATION = nvl( :isbidentification,Ldci_CotiVentasMovil.IDENTIFICATION)' ||
                   chr(10);
    END if;

  /*  --CASO 200-2040
    -- Valida el TECNICO DE VENTA
    if isbTecnicoVenta is not null then
      sbFilters := sbFilters ||
                    ' and    Ldci_CotiVentasMovil.TECNICOS_VENTAS_ID = :isbTecnicoVenta'||chr(10);

    else
      sbFilters := sbFilters ||
                    ' AND Ldci_CotiVentasMovil.TECNICOS_VENTAS_ID = nvl( :isbTecnicoVenta,Ldci_CotiVentasMovil.TECNICOS_VENTAS_ID)' ||
                   chr(10);
    END if;

    -- Valida el unidad instaladora
    if isbUnidadInstala is not null then
      sbFilters := sbFilters ||
                    ' and    Ldci_CotiVentasMovil.UND_INSTALADORA_ID = :isbUnidadInstala'||chr(10);

    else
      sbFilters := sbFilters ||
                    ' AND Ldci_CotiVentasMovil.UND_INSTALADORA_ID = nvl( :isbUnidadInstala,Ldci_CotiVentasMovil.UND_INSTALADORA_ID)' ||
                   chr(10);
    END if;

    -- Valida el unidad certificadora
    if isbUnidadCertifi is not null then
      sbFilters := sbFilters ||
                    ' and    Ldci_CotiVentasMovil.UND_CERTIFICADORA_ID = :isbUnidadCertifi'||chr(10);

    else
      sbFilters := sbFilters ||
                    ' AND Ldci_CotiVentasMovil.UND_CERTIFICADORA_ID = nvl( :isbUnidadCertifi,Ldci_CotiVentasMovil.UND_CERTIFICADORA_ID)' ||
                   chr(10);
    END if;*/

    IF fblAplicaEntrega('CRM_VEN_JGBA_2002121_2') THEN
      sbFilters := sbFilters ||
                    ' AND or_order_activity.order_id in (SELECT OR_ORDER.ORDER_ID FROM OR_ORDER WHERE OR_ORDER.ORDER_ID = or_order_activity.order_id'
                    ||' AND (trunc(SYSDATE) - trunc(LEGALIZATION_DATE)) <= DALD_PARAMETER.FNUGETNUMERIC_VALUE(''PARDIASVERVISITADESPLEG'')  )' ||
                   chr(10);
    END IF;


    -- Se arma la sentencia SQL
    FillsalecotiAttributes;
    sbSqlFinal := sbSqlCertificate || sbFilters;


    -- Llamada al cursor pasando siempre TODOS los parametros
    open ocuCursor for sbSqlFinal
      using isbIdorden, isbIdsolicitud, Isbestadi,isbidentification; --, isbName, isbLastName;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END;

  /*******************************************************************************
   Metodo: Getsalescotis
   Descripcion:   Obtiene todos las ventas que cumplan con los criterios de
                  seleccion indicados por el usuario
   Autor: KBaquero
   Fecha: Agosto 13/2015

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   15/08/2015     KBaquero - Creaci?n

  *******************************************************************************/

  PROCEDURE Getsalescotis(iscoti    in Ldci_CotiVentasMovil.cotizacion_venta_id %type,
                          ocuCursor out constants.tyRefCursor) IS

    sbSqlFinal varchar2(15000);
    sbFilters  varchar2(4000);

  BEGIN

    -- Las validaciones a continuacion funcionan de la siguiente manera:
    -- Si viene nulo genera instruccion igual en ambos lados del igual para que ignore la condicion
    -- Si no, concatena a la instruccion el parametro que recibe el valor digitado por el usuario

    -- Valida el tipo de documento
    if iscoti is not null then
      sbFilters := sbFilters ||
                   ' and Ldci_CotiVentasMovil.cotizacion_venta_id = :IDCOTI' ||
                   chr(10);
    else
      sbFilters := sbFilters ||
                   ' and Ldci_CotiVentasMovil.cotizacion_venta_id = nvl( :IDCOTI,Ldci_CotiVentasMovil.cotizacion_venta_id )' ||
                   chr(10);
    END if;

    -- Se arma la sentencia SQL
    FillsalecotiAttributes;
    sbSqlFinal := sbSqlCertificate || sbFilters;
    dbms_output.put_Line(sbSqlFinal);

    -- Llamada al cursor pasando siempre TODOS los parametros
    open ocuCursor for sbSqlFinal
      using iscoti; --isbIdorden, isbIdsolicitud; --, isbName, isbLastName;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END;

  /**/
  --consulta dinamica de las promociones

  /*******************************************************************************
   Metodo: FillSalePromSFAttributes
   Descripcion:   Obtiene todos las promociones de la venta que cumplan con el criterios de
                  seleccion indicados por el usuario
   Autor: KBaquero
   Fecha: Agosto 13/2015

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   13/08/2015     KBaquero - Creaci?n

  *******************************************************************************/
  PROCEDURE FillSalePromSFAttributes /*(promotion_id IN LDCI_COTIVENMOVPROMO.PROMOTION_ID%TYPE)*/
   IS

    sbCertificateId       varchar2(500);
    sbProductId           varchar2(500);
    sbPackageId           varchar2(500);
    sbActividadCerttifica varchar2(500);
    sbActividadCancela    varchar2(500);
    sbFechaRegistro       varchar2(500);
    sbFechaRevision       varchar2(500);
    sbFechaEstimadaRev    varchar2(500);
    sbFechaFinalRevision  varchar2(500);
    sbActividadRevision   varchar2(500);
    sbParent              varchar2(500);
    sbFromAssociate       varchar2(4000);
    sbJoinsAssociate      varchar2(4000);

  BEGIN

    sbCertificateSFAttributes := null;

    -- Si ya existe una sentencia de atributos no se debe continuar
    if sbSqlCertificateSF IS not null then
      return;
    END if;

    -- Definicion de cada uno de los atributos
    sbCertificateId := 'LDCI_COTIVENMOVPROMO.cotizacion_venta_id';
    sbProductId     := 'LDCI_COTIVENMOVPROMO.PROMOTION_ID';
    sbPackageId     := 'DACC_PROMOTION.FSBGETDESCRIPTION(' || sbProductId ||
                       ',NULL) as Descripcion';

    -- Conformacion de la cadena con los atributos
    sbCertificateSFAttributes := sbCertificateSFAttributes ||
                                 sbCertificateId || ', ' || chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes || sbProductId || ', ' ||
                                 chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes || sbPackageId || /*', '||*/
                                 chr(10);

    -- Definicion del FROM con las dos tablas origen de datos
    sbFromAssociate := 'FROM LDCI_COTIVENMOVPROMO' || chr(10);

    --  la sentencia con todos los componentes comunes
    sbSqlCertificateSF := 'SELECT ' || chr(10);
    sbSqlCertificateSF := sbSqlCertificateSF || sbCertificateSFAttributes;
    sbSqlCertificateSF := sbSqlCertificateSF || sbFromAssociate;
    --sbSqlCertificateSF := sbSqlCertificateSF || sbJoinsAssociate;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END;

  --  consulta depromociones
  /*******************************************************************************
   Metodo: GetPromocionSF
   Descripcion:   Obtiene todos las promociones de la venta que cumplan con el criterios de
                  seleccion indicados por el usuario
   Autor: KBaquero
   Fecha: Agosto 13/2015

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   13/08/2015     KBaquero - Creaci?n

  *******************************************************************************/

  PROCEDURE GetPromocionSF(iscoti    in Ldci_CotiVentasMovil.cotizacion_venta_id %type,
                           ocuCursor out constants.tyRefCursor) IS
    sbSqlFinal varchar2(10000);
    nuProM     LDCI_COTIVENMOVPROMO.PROMOTION_ID%TYPE;

  BEGIN

    ut_trace.trace('-- Paso 1. GetPromocionSF, iscoti:[' || iscoti || ']',
                   2);
    sbSqlCertificateSF := null;
    -- Llamado al metodo que define los atributos
    FillSalePromSFAttributes;

    -- Condicion para traer un unico atributo recibiendo valor de ID
    sbSqlFinal := sbSqlCertificateSF ||
                  'WHERE LDCI_COTIVENMOVPROMO.cotizacion_venta_id  = :iscoti' ||
                  chr(10);

    ut_trace.trace('-- Paso 2. GetCertificateSF, sbSqlFinal:[' ||
                   sbSqlFinal || ']',
                   2);
    dbms_output.put_Line(sbSqlFinal);
    -- Abrir CURSOR con sentencia y parametros
    open ocuCursor for sbSqlFinal
      using iscoti;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END;

  /*******************************************************************************
    Metodo: FillSalecontactoAttributes
    Descripcion:   Obtiene todos los datos a mostrar para una informaci?n de telefono

   Autor: KBaquero
  Fecha: Agosto 14/2015

  Historia de Modificaciones
  Fecha          Autor - Modificacion
  ===========    ================================================================
  14/08/2015     KBaquero - Creaci?n

   *******************************************************************************/
  PROCEDURE FillSalecontactoAttributes IS

    sbRowId               varchar2(500);
    sbCertificateId       varchar2(500);
    sbProductId           varchar2(500);
    sbPackageId           varchar2(500);
    sbActividadCerttifica varchar2(500);
    sbActividadCancela    varchar2(500);
    sbFechaRegistro       varchar2(500);
    sbFechaRevision       varchar2(500);
    sbFechaEstimadaRev    varchar2(500);
    sbFechaFinalRevision  varchar2(500);
    sbActividadRevision   varchar2(500);
    sbParent              varchar2(500);
    sbFromAssociate       varchar2(4000);
    sbJoinsAssociate      varchar2(4000);

  BEGIN

    sbCertificateSFAttributes := null;
    -- Si ya existe una sentencia de atributos no se debe continuar
    if sbCertificateSFAttributes IS not null then
      return;
    END if;

    -- Definicion de cada uno de los atributos
    sbRowId         := 'LDCI_COTIVENMOVTECO.rowid  ';
    sbCertificateId := 'LDCI_COTIVENMOVTECO.cotizacion_venta_id  ';
    sbProductId     := 'LDCI_COTIVENMOVTECO.phone  ';
    sbPackageId     := 'LDCI_COTIVENMOVTECO.phone_type_id  ';

    -- Conformacion de la cadena con los atributos
    sbCertificateSFAttributes := sbCertificateSFAttributes ||
                                 sbRowId || ', ' || chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes ||
                                 sbCertificateId || ', ' || chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes || sbPackageId || ', ' ||
                                 chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes || sbProductId || /*', '||*/
                                 chr(10);

    -- Definicion del FROM con las dos tablas origen de datos
    sbFromAssociate := 'FROM LDCI_COTIVENMOVTECO' || chr(10);

    --  la sentencia con todos los componentes comunes
    sbSqlCertificateSF := 'SELECT ' || chr(10);
    sbSqlCertificateSF := sbSqlCertificateSF || sbCertificateSFAttributes;
    sbSqlCertificateSF := sbSqlCertificateSF || sbFromAssociate;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END;

  /*******************************************************************************
    Metodo: GetSaleSFBycontacto
  Descripcion:   Obtiene todos las promociones de las ventas
                  que cumplan con los criterios de  seleccion indicados por el usuario
  Autor: KBaquero
  Fecha: Agosto 14/2015

  Historia de Modificaciones
  Fecha          Autor - Modificacion
  ===========    ================================================================
  14/08/2015     KBaquero - Creaci?n
   *******************************************************************************/
  PROCEDURE GetSaleSFBycontacto(iscoti    in Ldci_CotiVentasMovil.cotizacion_venta_id %type,
                                ocuCursor out constants.tyRefCursor) IS
    sbSqlFinal varchar2(4000);
    nuProducto ldc_plazos_cert.id_producto%type;

  BEGIN

    sbSqlCertificateSF := null;
    FillSalecontactoAttributes;

    sbSqlFinal := sbSqlCertificateSF ||
                  'WHERE LDCI_COTIVENMOVTECO.cotizacion_venta_id  = :iscoti' ||
                  chr(10);
    dbms_output.put_Line(sbSqlFinal);

    ut_trace.trace('-- Paso 4. GetCertificateSFByCertificate, iscoti:[' ||
                   iscoti || ']',
                   2);
    ut_trace.trace('-- Paso 5. GetCertificateSFByCertificate, sbSqlFinal:[' ||
                   sbSqlFinal || ']',
                   2);

    open ocuCursor for sbSqlFinal
      using iscoti;
    ut_trace.trace('-- Paso 5.1 FINALIZA GetCertificateSFByCertificate', 2);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END;

  /*******************************************************************************
    Metodo: FillCertificateSFAttributes
    Descripcion:   Obtiene todos los datos a mostrar para una informaci?n de telefono

   Autor: KBaquero
  Fecha: Agosto 19/2015

  Historia de Modificaciones
  Fecha          Autor - Modificacion
  ===========    ================================================================
  19/08/2015     KBaquero - Creaci?n

   *******************************************************************************/
  PROCEDURE FillSaleReferencAttributes IS

    sbRowId               varchar2(500);
    sbcotizacion_venta_id varchar2(500);
    sbreference_type_id   varchar2(500);
    sbname_               varchar2(500);
    sblast_name           varchar2(500);
    sbaddress_id          varchar2(500);
    sbphone               varchar2(500);

    sbFromAssociate varchar2(4000);

  BEGIN

    sbCertificateSFAttributes := null;

    -- Si ya existe una sentencia de atributos no se debe continuar
    if sbSqlCertificateSF IS not null then
      return;
    END if;

    -- Definicion de cada uno de los atributos
    sbRowId               := 'LDCI_COTIVENMOVREFE.rowid ';
    sbcotizacion_venta_id := 'LDCI_COTIVENMOVREFE.cotizacion_venta_id  ';
    sbreference_type_id   := 'LDCI_COTIVENMOVREFE.reference_type_id  ';
    sbname_               := 'LDCI_COTIVENMOVREFE.name_  ';
    sblast_name           := 'LDCI_COTIVENMOVREFE.last_name';
    sbaddress_id          := 'LDCI_COTIVENMOVREFE.address_id';
    sbphone               := 'LDCI_COTIVENMOVREFE.phone';

    -- Conformacion de la cadena con los atributos
    sbCertificateSFAttributes := sbCertificateSFAttributes ||
                                 sbRowId || ', ' || chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes ||
                                 sbcotizacion_venta_id || ', ' || chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes ||
                                 sbreference_type_id || ', ' || chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes || sbname_ || ', ' ||
                                 chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes || sblast_name || ', ' ||
                                 chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes || sbaddress_id || ', ' ||
                                 chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes || sbphone ||
                                 chr(10);

    -- Definicion del FROM con las dos tablas origen de datos
    sbFromAssociate := 'FROM LDCI_COTIVENMOVREFE' || chr(10);

    --  la sentencia con todos los componentes comunes
    sbSqlCertificateSF := 'SELECT ' || chr(10);
    sbSqlCertificateSF := sbSqlCertificateSF || sbCertificateSFAttributes;
    sbSqlCertificateSF := sbSqlCertificateSF || sbFromAssociate;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END;

  /*******************************************************************************
    Metodo: GetSaleReferenc
  Descripcion:   Obtiene todos las promociones de las ventas
                  que cumplan con los criterios de  seleccion indicados por el usuario
  Autor: KBaquero
  Fecha: Agosto 19/2015

  Historia de Modificaciones
  Fecha          Autor - Modificacion
  ===========    ================================================================
  19/08/2015     KBaquero - Creaci?n
   *******************************************************************************/
  PROCEDURE GetSaleReferenc(iscoti    in Ldci_CotiVentasMovil.cotizacion_venta_id %type,
                            ocuCursor out constants.tyRefCursor) IS
    sbSqlFinal varchar2(4000);

  BEGIN

    sbSqlCertificateSF := null;
    FillSaleReferencAttributes;

    sbSqlFinal := sbSqlCertificateSF ||
                  'WHERE LDCI_COTIVENMOVREFE.cotizacion_venta_id  = :iscoti' ||
                  chr(10);
    dbms_output.put_Line(sbSqlFinal);

    ut_trace.trace('-- Paso 4. GetSaleReferenc, iscoti:[' || iscoti || ']',
                   2);
    ut_trace.trace('-- Paso 5. GetSaleReferenc, sbSqlFinal:[' ||
                   sbSqlFinal || ']',
                   2);

    open ocuCursor for sbSqlFinal
      using iscoti;
    ut_trace.trace('-- Paso 5.1 FINALIZA GetSaleReferenc', 2);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del método:  fblExisteVentaCotizada
  Descripción:        Devuelve valor booleano indicando si existe la venta móvil cotizada.

  Autor    : KCienfuegos
  Fecha    : 29-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
  29-08-2016   KCienfuegos           Creación
  ******************************************************************/
  FUNCTION fblExisteVentaCotizada(inuVentaCotizada ldci_cotiventasmovil.cotizacion_venta_id%TYPE -- Venta
                                 ) RETURN BOOLEAN IS
        sbError      VARCHAR2(4000);
        nuError      NUMBER;
        nuCant       NUMBER := 0;

        CURSOR cuObtVentasMov IS
          SELECT COUNT(1)
            FROM ldci_cotiventasmovil
           WHERE cotizacion_venta_id = inuVentaCotizada;

    BEGIN
        ut_trace.trace('INICIO ldci_pkossventmovilgesmanu.fblExisteVentaCotizada', 10);

        OPEN cuObtVentasMov;
        FETCH cuObtVentasMov INTO nuCant;
        CLOSE cuObtVentasMov;

        IF(nuCant>0)THEN
           RETURN TRUE;
        ELSE
           RETURN FALSE;
        END IF;

        ut_trace.trace('FIN ldci_pkossventmovilgesmanu.fblExisteVentaCotizada', 10);

        RETURN FALSE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.Geterror(nuError, sbError);
            ut_trace.trace('TERMINÓ CON ERROR ldci_pkossventmovilgesmanu.fblExisteVentaCotizada', sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINÓ CON ERROR NO CONTROLADO ldci_pkossventmovilgesmanu.fblExisteVentaCotizada: ' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del método:  fblExisteBackUpVenta
  Descripción:        Devuelve valor booleano indicando si existe el backup de la venta

  Autor    : KCienfuegos
  Fecha    : 01-09-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificación
  -----------  -------------------    -------------------------------------
  01-09-2016   KCienfuegos            Creación.
  ******************************************************************/
  FUNCTION fblExisteBackUpVenta(inuVenta ldci_cotiventasmovil.cotizacion_venta_id%TYPE -- Venta
                                 ) RETURN BOOLEAN IS

      nuExiste             NUMBER := 0;
      sbError              VARCHAR2(4000);
      nuError              NUMBER;

      CURSOR cuExisteBackup IS
        SELECT COUNT(1)
          FROM ldc_cotiventasmovilbackup
         WHERE cotizacion_venta_id = inuVenta;

    BEGIN
        ut_trace.trace('INICIO ldci_pkossventmovilgesmanu.fblExisteBackUpVenta', 10);

        OPEN cuExisteBackup;
        FETCH cuExisteBackup INTO nuExiste;
        CLOSE cuExisteBackup;

        IF(nuExiste>0)THEN
           RETURN TRUE;
        ELSE
           RETURN FALSE;
        END IF;

        ut_trace.trace('FIN ldci_pkossventmovilgesmanu.fblExisteBackUpVenta', 10);

        RETURN FALSE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.Geterror(nuError, sbError);
            ut_trace.trace('TERMINÓ CON ERROR ldci_pkossventmovilgesmanu.fblExisteVentaCotizada', sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINÓ CON ERROR NO CONTROLADO ldci_pkossventmovilgesmanu.fblExisteVentaCotizada: ' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del método: fcrVentaMovil
  Descripción:        Devuelve los datos de la venta movil cotizada.

  Autor    : KCienfuegos

  Fecha    : 29-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                       Modificación
  -----------  -------------------             -------------------------------------
  07-01-2021   HORBATH           			   CASO 542: Se modifica la consulta para obtener el codigo de tipo de energetico.
  05/04/2019    ELAL                          se agregan nuevos campos numero de medidor, predio en construccion, predio de independizacion
                                              contrato, estado de ley 
  29-08-2016    KCienfuegos.CA200-37           Creación
  
  ******************************************************************/
  FUNCTION fcrVentaMovil(inuVenta    IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR IS


    crVentaMovil                       PKCONSTANTE.TYREFCURSOR;

    BEGIN
        ut_trace.trace('INICIO ldci_pkossventmovilgesmanu.fcrVentaMovil');

        -- Consulta cursor referenciado
        OPEN crVentaMovil FOR
            SELECT cotizacion_venta_id,
                   mensaje_id,
                   order_id,
                   fecha_de_solicitud,
                   person_id,
                   pos_oper_unit_id,
                   document_type_id,
                   document_key,
                   project_id,
                   comment_,
                   direccion,
                   categoria,
                   subcategoria,
                   tipo_de_identificacion,
                   identification,
                   subscriber_name,
                   apellido,
                   company,
                   title,
                   correo_electronico,
                   person_quantity,
                   nvl((select ENERG_ANT
                        from LDC_ENERGETICO_ANT 
                        where COD_SALE= v.cotizacion_venta_id),DALD_PARAMETER.FNUGETNUMERIC_VALUE('COD_ENER_DEFECTO')) old_operator, --caso: 542
                   venta_empaquetada,
                   commercial_plan_id,
                   nvl(total_value,0) total_value,
                   plan_de_financiacion,
                   nvl(initial_payment,0) initial_payment,
                   nvl(numero_de_cuotas,0) numero_de_cuotas,
                   nvl(cuota_mensual,0) cuota_mensual,
                   init_payment_mode,
                   init_pay_received,
                   usage,
                   install_type,
                   estado,
                   fecha_registro,
                   fecha_procesado,
                   codigo_error,
                   mensaje_error,
                   usuario,
                   solicitud_generada,
                   tecnicos_ventas_id,
                   und_instaladora_id,
                   und_certificadora_id,
                   TIPO_PREDIO,
                   PREDIO_INDE,
                   CONTRATO,	
                   MEDIDOR,	
                   ESTALEY,
                   CONSTRUCCION
              FROM ldci_cotiventasmovil v
             WHERE v.cotizacion_venta_id = inuVenta;

        ut_trace.trace('FIN ldci_pkossventmovilgesmanu.fcrVentaMovil');

        RETURN crVentaMovil;

   EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;

      WHEN OTHERS THEN
          ut_trace.trace('TERMINÓ CON ERROR NO CONTROLADO ldci_pkossventmovilgesmanu.fcrVentaMovil:'|| SQLERRM);
          ERRORS.SETERROR;
          RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: fcrPromociones
  Descripción:        Obtiene las promociones de la venta

  Autor    : KCienfuegos

  Fecha    :  29-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                      Modificación
  -----------  -------------------            -------------------------------------
   29-08-2016  KCienfuegos.CA200-37           Creación
  ******************************************************************/
  FUNCTION fcrPromociones(inuVenta    IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR IS


      crPromociones                       PKCONSTANTE.TYREFCURSOR;

  BEGIN
      ut_trace.trace('INICIO ldci_pkossventmovilgesmanu.fcrPromociones');

      -- Consulta cursor referenciado
      OPEN crPromociones FOR
          SELECT cotizacion_venta_id,
                 p.promotion_id,
                 pp.description||' TIPO: '||dacc_prom_type.fsbgetdescription(pp.prom_type_id,0) description,
                 rowidtochar(p.rowid) id
          FROM   ldci_cotivenmovpromo   p, cc_promotion pp
          WHERE  p.cotizacion_venta_id = inuVenta
            AND  p.promotion_id = pp.promotion_id;

      ut_trace.trace('FIN ldci_pkossventmovilgesmanu.fcrPromociones');

      RETURN crPromociones;

   EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;

      WHEN OTHERS THEN
          ut_trace.trace('TERMINÓ CON ERROR NO CONTROLADO ldci_pkossventmovilgesmanu.fcrPromociones:'|| SQLERRM);
          ERRORS.SETERROR;
          RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: fcrContactos
  Descripción:        Obtiene los contactos de la venta

  Autor    : KCienfuegos

  Fecha    :  29-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                       Modificación
  -----------  -------------------             -------------------------------------
   29-08-2016   KCienfuegos.CA200-37           Creación
  ******************************************************************/
  FUNCTION fcrContactos(inuVenta    IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR IS

    crContactos                       PKCONSTANTE.TYREFCURSOR;

  BEGIN
      ut_trace.trace('INICIO ldci_pkossventmovilgesmanu.fcrContactos');

      -- Consulta cursor referenciado
      OPEN crContactos FOR
          SELECT cotizacion_venta_id, phone_type_id, phone, rowidtochar(rowid) id
          FROM   ldci_cotivenmovteco   c
          WHERE  c.cotizacion_venta_id = inuVenta;

      ut_trace.trace('FIN ldci_pkossventmovilgesmanu.fcrContactos');

      RETURN crContactos;

   EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;

      WHEN OTHERS THEN
          ut_trace.trace('TERMINÓ CON ERROR NO CONTROLADO ldci_pkossventmovilgesmanu.fcrContactos:'|| SQLERRM);
          ERRORS.SETERROR;
          RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: fcrReferencias
  Descripción:        Obtiene las referencias de la venta

  Autor    : KCienfuegos

  Fecha    :  29-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                      Modificación
  -----------  -------------------            -------------------------------------
   29-08-2016   KCienfuegos.CA200-37           Creación
  ******************************************************************/
  FUNCTION fcrReferencias(inuVenta    IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR IS

    crReferencias                       PKCONSTANTE.TYREFCURSOR;

  BEGIN
      ut_trace.trace('INICIO ldci_pkossventmovilgesmanu.fcrReferencias');

      -- Consulta cursor referenciado
      OPEN crReferencias FOR
          SELECT cotizacion_venta_id,
                 rowidtochar(rowid) id,
                 reference_type_id,
                 name_,
                 last_name,
                 address_id,
                 daab_address.fsbgetaddress_parsed(address_id,0) address_parsed,
                 phone
            FROM ldci_cotivenmovrefe r
           WHERE r.cotizacion_venta_id = inuVenta;

      ut_trace.trace('FIN ldci_pkossventmovilgesmanu.fcrReferencias');

      RETURN crReferencias;

   EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;

      WHEN OTHERS THEN
          ut_trace.trace('TERMINÓ CON ERROR NO CONTROLADO ldci_pkossventmovilgesmanu.fcrReferencias:'|| SQLERRM);
          ERRORS.SETERROR;
          RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: fcrPlanesFinanciacion
  Descripción:        Obtiene los planes de financiación

  Autor    : KCienfuegos

  Fecha    :  29-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                      Modificación
  -----------  -------------------            -------------------------------------
   29-08-2016  KCienfuegos.CA200-37           Creación
  ******************************************************************/
  FUNCTION fcrPlanesFinanciacion(inuVenta    IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE)
    RETURN PKCONSTANTE.TYREFCURSOR IS


      crPlanes                       PKCONSTANTE.TYREFCURSOR;
      dtFechaSolicitud               DATE;

      CURSOR cuObtieneFechaSol IS
        SELECT fecha_de_solicitud
          FROM ldci_cotiventasmovil
         WHERE cotizacion_venta_id = inuVenta;

  BEGIN
      ut_trace.trace('INICIO ldci_pkossventmovilgesmanu.fcrPlanesFinanciacion');

      OPEN cuObtieneFechaSol;
      FETCH cuObtieneFechaSol INTO dtFechaSolicitud;
      CLOSE cuObtieneFechaSol;

      dtFechaSolicitud := nvl(dtFechaSolicitud, sysdate);

      -- Consulta cursor referenciado
      OPEN crPlanes FOR
          SELECT pldicodi CODIGO, pldidesc DESCRIPCION, PLDICUMI CUOT_MIN, PLDICUMA CUOT_MAX
          FROM   plandife
          WHERE  pldipmaf = nuPorcentajeMax
            AND dtFechaSolicitud between PLDIFEIN AND PLDIFEFI
            ORDER BY pldicodi ASC;


      ut_trace.trace('FIN ldci_pkossventmovilgesmanu.fcrPlanesFinanciacion');

      RETURN crPlanes;

   EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;

      WHEN OTHERS THEN
          ut_trace.trace('TERMINÓ CON ERROR NO CONTROLADO ldci_pkossventmovilgesmanu.fcrPlanesFinanciacion:'|| SQLERRM);
          ERRORS.SETERROR;
          RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proCreaPromociones
  Descripción:        Registra las promociones para la venta móvil

  Autor    : KCienfuegos

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                       Modificación
  -----------  -------------------             -------------------------------------
   30-08-2016   KCienfuegos.CA200-37           Creación
  ******************************************************************/
  PROCEDURE proCreaPromociones(inuVenta             IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE,
                               inuIdPromocion       IN ldci_cotivenmovpromo.promotion_id%TYPE) IS


   BEGIN
          ut_trace.trace('INICIO ldci_pkossventmovilgesmanu.proCreaPromociones',10);

          proRegistrarBackup(inuVenta);

          INSERT INTO ldci_cotivenmovpromo
              (cotizacion_venta_id, promotion_id)
            VALUES
              (inuVenta, inuIdPromocion);

          ut_trace.trace('FIN ldci_pkossventmovilgesmanu.proCreaPromociones',10);

   EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;

          WHEN OTHERS THEN
              ut_trace.trace('TERMINÓ CON ERROR NO CONTROLADO ldci_pkossventmovilgesmanu.proCreaPromociones:' || SQLERRM);
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proCreaContactos
  Descripción:        Registra los contactos para la venta móvil

  Autor    : KCienfuegos

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                      Modificación
  -----------  -------------------           	-------------------------------------
   30-08-2016   KCienfuegos.CA200-37           Creación
  ******************************************************************/
  PROCEDURE proCreaContactos(inuVenta             IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE,
                             inuTipoTel           IN ldci_cotivenmovteco.phone_type_id%TYPE,
                             inuTelefono          IN ldci_cotivenmovteco.phone%TYPE) IS


   BEGIN
          ut_trace.trace('INICIO ldci_pkossventmovilgesmanu.proCreaContactos',10);

          proRegistrarBackup(inuVenta);

           INSERT INTO ldci_cotivenmovteco
              (cotizacion_venta_id, phone, phone_type_id)
            VALUES
              (inuVenta, inuTelefono, inuTipoTel);

          ut_trace.trace('FIN ldci_pkossventmovilgesmanu.proCreaContactos',10);

   EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;

          WHEN OTHERS THEN
              ut_trace.trace('TERMINÓ CON ERROR NO CONTROLADO ldci_pkossventmovilgesmanu.proCreaContactos:' || SQLERRM);
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proCreaReferencias
  Descripción:        Registra las referencias para la venta móvil

  Autor    : KCienfuegos

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                       Modificación
  -----------  -------------------             -------------------------------------
   30-08-2016   KCienfuegos.CA200-37           Creación
  ******************************************************************/
  PROCEDURE proCreaReferencias(inuVenta             IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE,
                               inuTipoRef           IN ldci_cotivenmovrefe.reference_type_id%TYPE,
                               isbNombre            IN ldci_cotivenmovrefe.name_%TYPE,
                               isbApellido          IN ldci_cotivenmovrefe.last_name%TYPE,
                               inuDireccion         IN ldci_cotivenmovrefe.address_id%TYPE,
                               isbTelefono          IN ldci_cotivenmovrefe.phone%TYPE) IS


   BEGIN
          ut_trace.trace('INICIO ldci_pkossventmovilgesmanu.proCreaReferencias',10);

          proRegistrarBackup(inuVenta);

           INSERT INTO LDCI_COTIVENMOVREFE
              (cotizacion_venta_id,
               reference_type_id,
               name_,
               last_name,
               address_id,
               phone)
            VALUES
              (inuVenta,
               inuTipoRef,
               isbNombre,
               isbApellido,
               inuDireccion,
               isbTelefono);

          ut_trace.trace('FIN ldci_pkossventmovilgesmanu.proCreaReferencias',10);

   EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;

          WHEN OTHERS THEN
              ut_trace.trace('TERMINÓ CON ERROR NO CONTROLADO ldci_pkossventmovilgesmanu.proCreaReferencias:' || SQLERRM);
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proModifDatosVenta
  Descripción:        Modifica los datos de la venta

  Autor    : KCienfuegos

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                       Modificación
  -----------  -------------------             -------------------------------------
   07-01-2021   HORBATH           			   CASO 542: Se modifica la logica para recibir un codigo de tipo de energetico.
   05/04/2019   ELAL                           se agregan nuevos campos numero de medidor, predio en construccion, predio de independizacion
                                               contrato, estado de ley
   30-08-2016   KCienfuegos.CA200-37           Creación
  ******************************************************************/
  PROCEDURE proModifDatosVenta(inuVenta                IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE,
                               inuDireccion            IN ldci_cotiventasmovil.direccion%TYPE,
                               inuFormulario           IN ldci_cotiventasmovil.document_key%TYPE,
                               isbTipoId               IN ldci_cotiventasmovil.tipo_de_identificacion%TYPE,
                               isbIdentificacion       IN ldci_cotiventasmovil.identification%TYPE,
                               isbNombre               IN ldci_cotiventasmovil.subscriber_name%TYPE,
                               isbApellido             IN ldci_cotiventasmovil.apellido%TYPE,
                               isbCorreo               IN ldci_cotiventasmovil.correo_electronico%TYPE,
                               inuEnergAnt             IN ldc_tipo_energetico.codigo%TYPE, --CASO: 542
                               inuPlanComercial        IN ldci_cotiventasmovil.commercial_plan_id%TYPE,
                               inuPlanFinanciacion     IN ldci_cotiventasmovil.plan_de_financiacion%TYPE,
                               inuValorTotal           IN ldci_cotiventasmovil.total_value%TYPE,
                               inuCantCuotas           IN ldci_cotiventasmovil.numero_de_cuotas%TYPE,
                               inuCuotaInicial         IN ldci_cotiventasmovil.initial_payment%TYPE,
                               inuCuotaMensual         IN ldci_cotiventasmovil.cuota_mensual%TYPE,
                               inuTecnicoVentas        IN ldci_cotiventasmovil.tecnicos_ventas_id%TYPE,
                               inuUnidadInstaladora    IN ldci_cotiventasmovil.und_instaladora_id%TYPE,
                               inuUnidadCertificadora  IN ldci_cotiventasmovil.und_certificadora_id%TYPE,
                               inuTIPO_PREDIO          IN LDCI_COTIVENTASMOVIL.TIPO_PREDIO%type,
                               isbPREDIO_INDE          IN LDCI_COTIVENTASMOVIL.PREDIO_INDE%type,
                               inuCONTRATO             IN LDCI_COTIVENTASMOVIL.CONTRATO%type,
                               isbMEDIDOR              IN LDCI_COTIVENTASMOVIL.MEDIDOR%type,
                               inuESTALEY              IN LDCI_COTIVENTASMOVIL.ESTALEY%type,
                               isbCONSTRUCCION         IN LDCI_COTIVENTASMOVIL.CONSTRUCCION%type,
                               isbObservacion          IN ldci_cotiventasmovil.comment_%TYPE) IS


       nuCategoria            ldci_cotiventasmovil.categoria%TYPE;
       nuSubcategoria         ldci_cotiventasmovil.subcategoria%TYPE;
	   nuValext               NUMBER;
	   
	   cursor cuExtener( cod number) is
		   select 1 
			from LDC_ENERGETICO_ANT 
			where COD_SALE= cod;			
		
	   
   BEGIN
          ut_trace.trace('INICIO ldci_pkossventmovilgesmanu.proModifDatosVenta',10);

          proRegistrarBackup(inuVenta);

          nuCategoria := ab_boaddress.fnugetcategory(inuaddressid => inuDireccion);
          nuSubcategoria := ab_boaddress.fnugetsubcategory(inuaddressid => inuDireccion);

          --Validar para que pase la información a las tablas de backup

          UPDATE ldci_cotiventasmovil v
             SET v.direccion = inuDireccion,
                 v.categoria = nvl(nuCategoria,v.categoria),
                 v.subcategoria = nvl(nuSubcategoria,v.subcategoria),
                 v.document_key = inuFormulario,
                 v.tipo_de_identificacion = isbTipoId,
                 v.identification = isbIdentificacion,
                 v.subscriber_name = isbNombre,
                 v.apellido = isbApellido,
                 v.correo_electronico = isbCorreo,
                 v.old_operator = LDC_FNCGETDESCENERGETICO(inuEnergAnt), --CASO: 542
                 v.commercial_plan_id = inuPlanComercial,
                 v.plan_de_financiacion = inuPlanFinanciacion,
                 v.total_value = inuValorTotal,
                 v.numero_de_cuotas = inuCantCuotas,
                 v.initial_payment = inuCuotaInicial,
                 v.cuota_mensual = inuCuotaMensual,
                 v.tecnicos_ventas_id = inuTecnicoVentas,
                 v.und_instaladora_id = inuUnidadInstaladora,
                 v.und_certificadora_id = inuUnidadCertificadora,
                 v.TIPO_PREDIO = inuTIPO_PREDIO,
                 v.PREDIO_INDE = isbPREDIO_INDE,
                 v.CONTRATO = inuCONTRATO,	
                 v.MEDIDOR = isbMEDIDOR,
                 v.ESTALEY = inuESTALEY,	
                 v.CONSTRUCCION = isbCONSTRUCCION,
                 v.comment_ = isbObservacion
           WHERE v.cotizacion_venta_id = inuVenta;
		   
		   -- INICIO CASO: 542
		   OPEN cuExtener(inuVenta);
		   FETCH cuExtener INTO nuValext;
		   CLOSE cuExtener;
		   
		   IF nuValext = 1 THEN
		   
			UPDATE LDC_ENERGETICO_ANT
			SET ENERG_ANT = inuEnergAnt
			where COD_SALE= inuVenta;
			
		   ELSE 
		   
			Insert into LDC_ENERGETICO_ANT (ENERG_ANT,COD_SALE) 
			values (inuEnergAnt,inuVenta);
			
		   END IF;
		   -- FIN CASO: 542

          ut_trace.trace('FIN ldci_pkossventmovilgesmanu.proModifDatosVenta',10);

   EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;

      WHEN OTHERS THEN
          ut_trace.trace('TERMINÓ CON ERROR NO CONTROLADO ldci_pkossventmovilgesmanu.proModifPromociones:' || SQLERRM);
          ERRORS.SETERROR;
          RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proModifPromociones
  Descripción:        Modifica las promociones para la venta móvil

  Autor    : KCienfuegos

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                       Modificación
  -----------  -------------------             -------------------------------------
   30-08-2016   KCienfuegos.CA200-37           Creación
  ******************************************************************/
  PROCEDURE proModifPromociones(inuVenta             IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE,
                                inuIdPromocion       IN ldci_cotivenmovpromo.promotion_id%TYPE,
                                inuId                IN VARCHAR2,
                                isbOpcion            IN VARCHAR2) IS

   BEGIN
          ut_trace.trace('INICIO ldci_pkossventmovilgesmanu.proModifPromociones',10);

          proRegistrarBackup(inuVenta);

          IF (isbOpcion = 'U') THEN

              UPDATE ldci_cotivenmovpromo p
                 SET p.promotion_id = inuIdPromocion
               WHERE p.cotizacion_venta_id = inuVenta
                 AND p.rowid = inuId;

          ELSIF (isbOpcion = 'D') THEN
              DELETE ldci_cotivenmovpromo p
               WHERE p.cotizacion_venta_id = inuVenta
                 AND p.rowid = inuId;

          END IF;

          ut_trace.trace('FIN ldci_pkossventmovilgesmanu.proModifPromociones',10);

   EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;

      WHEN OTHERS THEN
          ut_trace.trace('TERMINÓ CON ERROR NO CONTROLADO ldci_pkossventmovilgesmanu.proModifPromociones:' || SQLERRM);
          ERRORS.SETERROR;
          RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proModifContactos
  Descripción:        Modifica los contactos para la venta móvil

  Autor    : KCienfuegos

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                      Modificación
  -----------  -------------------            -------------------------------------
   30-08-2016   KCienfuegos.CA200-37           Creación
  ******************************************************************/
  PROCEDURE proModifContactos(inuVenta             IN ldci_cotiventasmovil.cotizacion_venta_id%TYPE,
                              inuId                IN VARCHAR2,
                              inuTipoTel           IN ldci_cotivenmovteco.phone_type_id%TYPE,
                              inuTelefono          IN ldci_cotivenmovteco.phone%TYPE,
                              isbOpcion            IN VARCHAR2) IS


  BEGIN
        ut_trace.trace('INICIO ldci_pkossventmovilgesmanu.proModifContactos',10);

        proRegistrarBackup(inuVenta);

        IF (isbOpcion = 'U') THEN
            UPDATE ldci_cotivenmovteco c
               SET c.phone_type_id = inuTipoTel,
                   c.phone         = inuTelefono
             WHERE c.cotizacion_venta_id = inuVenta
               AND c.rowid = inuId;

        ELSIF (isbOpcion = 'D') THEN
            DELETE ldci_cotivenmovteco c
             WHERE c.cotizacion_venta_id = inuVenta
               AND c.rowid = inuId;

        END IF;

        ut_trace.trace('FIN ldci_pkossventmovilgesmanu.proModifContactos',10);
  EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ut_trace.trace('TERMINÓ CON ERROR NO CONTROLADO ldci_pkossventmovilgesmanu.proModifContactos:' || SQLERRM);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proModifReferencias
  Descripción:        Modifica las referencias para la venta móvil

  Autor    : KCienfuegos

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                       Modificación
  -----------  -------------------             -------------------------------------
   30-08-2016   KCienfuegos.CA200-37           Creación
  ******************************************************************/
  PROCEDURE proModifReferencias(inuVenta             IN ldci_cotivenmovrefe.cotizacion_venta_id%TYPE,
                                inuTipoReferencia    IN ldci_cotivenmovrefe.reference_type_id%TYPE,
                                isbNombre            IN ldci_cotivenmovrefe.name_%TYPE,
                                isbApellido          IN ldci_cotivenmovrefe.last_name%TYPE,
                                inuDireccion         IN ldci_cotivenmovrefe.address_id%TYPE,
                                isbTelefono          IN ldci_cotivenmovrefe.phone%TYPE,
                                inuId                IN VARCHAR2,
                                isbOpcion            IN VARCHAR2) IS

   BEGIN
          ut_trace.trace('INICIO ldci_pkossventmovilgesmanu.proModifReferencias '||inuId,10);

          proRegistrarBackup(inuVenta);

          IF (isbOpcion = 'U') THEN
              UPDATE ldci_cotivenmovrefe r
                 SET r.reference_type_id = inuTipoReferencia,
                     r.name_             = isbNombre,
                     r.last_name         = isbApellido,
                     r.address_id        = inuDireccion,
                     r.phone             = isbTelefono
               WHERE r.cotizacion_venta_id = inuVenta
                 AND r.rowid = inuId;

          ELSIF (isbOpcion = 'D') THEN
              DELETE ldci_cotivenmovrefe r
               WHERE r.cotizacion_venta_id = inuVenta
                 AND r.rowid = inuId;

          END IF;

          ut_trace.trace('FIN ldci_pkossventmovilgesmanu.proModifReferencias',10);

   EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;

          WHEN OTHERS THEN
              ut_trace.trace('TERMINÓ CON ERROR NO CONTROLADO ldci_pkossventmovilgesmanu.proModifReferencias:' || SQLERRM);
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proRegistrarBackup
  Descripción:        Registra el backup de la información original de las ventas móviles
                      cotizadas.

  Autor    : KCienfuegos

  Fecha    :  01-09-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                       Modificación
  -----------  -------------------             -------------------------------------
   01-09-2016   KCienfuegos.CA200-37           Creación
  ******************************************************************/
  PROCEDURE proRegistrarBackup(inuVenta   IN ldci_cotivenmovrefe.cotizacion_venta_id%TYPE) IS

      CURSOR cuExisteBackup IS
        SELECT COUNT(1)
          FROM ldc_cotiventasmovilbackup
         WHERE cotizacion_venta_id = inuVenta;

   BEGIN
        ut_trace.trace('INICIO ldci_pkossventmovilgesmanu.proRegistrarBackup',10);

        IF(fblExisteBackUpVenta(inuVenta))THEN
           RETURN;
        END IF;

        BEGIN
          INSERT INTO LDC_COTIVENTASMOVILBACKUP
                      (cotizacion_venta_id,
                       mensaje_id,
                       order_id,
                       fecha_de_solicitud,
                       person_id,
                       pos_oper_unit_id,
                       document_type_id,
                       document_key,
                       project_id,
                       comment_,
                       direccion,
                       categoria,
                       subcategoria,
                       tipo_de_identificacion,
                       identification,
                       subscriber_name,
                       apellido,
                       company,
                       title,
                       correo_electronico,
                       person_quantity,
                       old_operator,
                       venta_empaquetada,
                       commercial_plan_id,
                       total_value,
                       plan_de_financiacion,
                       initial_payment,
                       numero_de_cuotas,
                       cuota_mensual,
                       init_payment_mode,
                       init_pay_received,
                       usage,
                       install_type,
                       estado,
                       fecha_registro,
                       fecha_procesado,
                       codigo_error,
                       mensaje_error,
                       usuario,
                       solicitud_generada,
                       modifxml,
                       fecha_modi_xml,
                       fecha_backup)
             SELECT  cotizacion_venta_id,
                     mensaje_id,
                     order_id,
                     fecha_de_solicitud,
                     person_id,
                     pos_oper_unit_id,
                     document_type_id,
                     document_key,
                     project_id,
                     comment_,
                     direccion,
                     categoria,
                     subcategoria,
                     tipo_de_identificacion,
                     identification,
                     subscriber_name,
                     apellido,
                     company,
                     title,
                     correo_electronico,
                     person_quantity,
                     old_operator,
                     venta_empaquetada,
                     commercial_plan_id,
                     total_value,
                     plan_de_financiacion,
                     initial_payment,
                     numero_de_cuotas,
                     cuota_mensual,
                     init_payment_mode,
                     init_pay_received,
                     usage,
                     install_type,
                     estado,
                     fecha_registro,
                     fecha_procesado,
                     codigo_error,
                     mensaje_error,
                     usuario,
                     solicitud_generada,
                     modifxml,
                     fecha_modi_xml,
                     sysdate
                FROM ldci_cotiventasmovil
               WHERE cotizacion_venta_id = inuVenta;
        EXCEPTION
           WHEN OTHERS THEN
             NULL;
        END;

       BEGIN
          INSERT INTO LDC_COTIVENMOVPROMOBACKUP
                      (cotizacion_venta_id,
                       promotion_id)
               SELECT  cotizacion_venta_id,
                       promotion_id
                 FROM  LDCI_COTIVENMOVPROMO
                WHERE  cotizacion_venta_id = inuVenta;
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;

        BEGIN
          INSERT INTO LDC_COTIVENMOVTECOBACKUP
                      (cotizacion_venta_id,
                       phone,
                       phone_type_id)
               SELECT  cotizacion_venta_id,
                       phone,
                       phone_type_id
                 FROM  LDCI_COTIVENMOVTECO
                WHERE  cotizacion_venta_id = inuVenta;
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;

        BEGIN
          INSERT INTO LDC_COTIVENMOVREFEBACKUP
                      (cotizacion_venta_id,
                       reference_type_id ,
                       name_,
                       last_name,
                       address_id,
                       phone)
               SELECT  cotizacion_venta_id,
                       reference_type_id ,
                       name_,
                       last_name,
                       address_id,
                       phone
                 FROM  LDCI_COTIVENMOVREFE
                WHERE  cotizacion_venta_id = inuVenta;
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;

        ut_trace.trace('FIN ldci_pkossventmovilgesmanu.proRegistrarBackup',10);

   EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;

          WHEN OTHERS THEN
              ut_trace.trace('TERMINÓ CON ERROR NO CONTROLADO ldci_pkossventmovilgesmanu.proRegistrarBackup:' || SQLERRM);
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: proValidaFormulario
  Descripción:        Método para validar el formulario

  Autor    : KCienfuegos

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                      Modificación
  -----------  -------------------           	-------------------------------------
   30-08-2016   KCienfuegos.CA200-37           Creación
  ******************************************************************/
  PROCEDURE proValidaFormulario(inuVenta             IN ldci_cotivenmovrefe.cotizacion_venta_id%TYPE,
                                inuFormulario        IN fa_consdist.codinuin%TYPE,
                                inuTipoFormulario    IN fa_consdist.coditico%TYPE) IS

      nuUtVendedor              or_operating_unit.operating_unit_id%TYPE;
      nuPerson                  ge_person.person_id%TYPE;

      CURSOR cuObtienePerson IS
         SELECT person_id
           FROM ldci_cotiventasmovil
          WHERE cotizacion_venta_id = inuVenta;
   BEGIN
          ut_trace.trace('INICIO ldci_pkossventmovilgesmanu.proValidaFormulario',10);

          OPEN cuObtienePerson;
          FETCH cuObtienePerson INTO nuPerson;
          CLOSE cuObtienePerson;

          nuUtVendedor := or_booperatingunit.fnugetfirstoperunit(nuPerson, cnuClasifVended);

          IF(DALD_PARAMETER.fsbGetValue_Chain('VAL_FORM_MOD_VENT_MOVIL',0)='S') THEN
            IF(nuUtVendedor IS NOT NULL)THEN
              pkconsecutivemgr.valauthnumber(inucliente => NULL,
                                             inuempresa => NULL,
                                             inunumero => inuFormulario,
                                             inuoperunit => nuUtVendedor,
                                             inutipocomp => inuTipoFormulario,
                                             inutipodocu => nuTipoDocuForm,
                                             inutipoprod => DALD_PARAMETER.fnuGetNumeric_Value('COD_SERV_GAS',0));
            END IF;
          END IF;

          ut_trace.trace('FIN ldci_pkossventmovilgesmanu.proValidaFormulario',10);

   EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;

          WHEN OTHERS THEN
              ut_trace.trace('TERMINÓ CON ERROR NO CONTROLADO ldci_pkossventmovilgesmanu.proValidaFormulario:' || SQLERRM);
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
  END;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: ProcArmaXMLVenta
  Descripción:        Método para validar el formulario

  Autor    : NCarrasquilla

  Fecha    :  30-08-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                      Modificación
  -----------  -------------------           	-------------------------------------
   30-08-2016   NCarrasquilla.CA200-37        Creación.
   02-09-2016   KCienfuegos.CA200-37          Modificación.
   23-11-2016   KCienfuegos.CA200-37          Se envía la fecha actual en la fecha de solicitud.
   23-04-2018   Eduardo Cerón.Caso 200-1559.  Se adicionan los campos UNIDAD_DE_TRABAJO_INSTALADORA y
                                              UNIDAD_DE_TRABAJO_CERTIFICADORA
  05/04/2019    ELAL                          se agregan nuevos campos numero de medidor, predio en construccion, predio de independizacion
                                              contrato, estado de ley 
  ******************************************************************/
  PROCEDURE ProcArmaXMLVenta (nuVentaId  ldci_cotiventasmovil.cotizacion_venta_id%TYPE,
                              sbXML        OUT VARCHAR2)
  IS
    sbDatosEncXML        varchar2(2000) := '';
    sbDatosSolicitud     varchar2(2000) := '';
    sbDatosCliente       varchar2(2000) := '';
    sbTelefContacCliente varchar2(2000) := '';
    sbReferenciaCliente  varchar2(2000) := '';
    sbDatosPromocion     varchar2(2000) := '';
    sbDatosInstalacion   varchar2(2000) := '';

    -- Cursor para extraer informacion de la venta
    CURSOR cuInfoVenta IS
      SELECT *
        FROM LDCI_COTIVENTASMOVIL
       WHERE COTIZACION_VENTA_ID = nuVentaId;
    rgInfoVenta cuInfoVenta%ROWTYPE;

    -- Cursor para extraer informacion de las promociones
    CURSOR cuInfoPromVenta IS
      SELECT *
        FROM LDCI_COTIVENMOVPROMO
       WHERE COTIZACION_VENTA_ID = nuVentaId;
    rgInfoVentaprom  cuInfoPromVenta%ROWTYPE;

    -- Cursor para extraer informacion de los telefonos
    CURSOR cuInfophoVenta IS
      SELECT *
        FROM LDCI_COTIVENMOVTECO
       WHERE COTIZACION_VENTA_ID = nuVentaId;
    rgInfoVentapho  cuInfophoVenta%ROWTYPE;

    -- Cursor para extraer informacion de las referencias
    CURSOR cuInforefVenta IS
      SELECT *
        FROM LDCI_COTIVENMOVREFE
       WHERE COTIZACION_VENTA_ID = nuVentaId;
    rgInfoVentaref  cuInforefVenta%ROWTYPE;

    nuGrupoTelefono       NUMBER;
    nuGrupoPromocion      NUMBER;
    nuGrupoReferencia     NUMBER;
  BEGIN
    ut_trace.trace('INICIA ldci_pkossventmovilgesmanu.ProcArmaXMLVenta',10);

    OPEN cuInfoVenta;
    FETCH cuInfoVenta into rgInfoVenta;
    CLOSE cuInfoVenta;

    sbDatosEncXML:= '<?xml version="1.0" encoding="UTF-8"?>';
    sbDatosSolicitud := '<P_VENTA_DE_GAS_POR_FORMULARIO_XML_100233 ID_TIPOPAQUETE="100233">'||
                          '<FECHA_DE_SOLICITUD>'||to_char(SYSDATE,'DD/MM/YYYY')||'</FECHA_DE_SOLICITUD>'||
                          '<ID>'||rgInfoVenta.Person_Id||'</ID>'||
                          '<POS_OPER_UNIT_ID>'||rgInfoVenta.Pos_Oper_Unit_Id||'</POS_OPER_UNIT_ID>'||
                          '<DOCUMENT_TYPE_ID>'||rgInfoVenta.Document_Type_Id||'</DOCUMENT_TYPE_ID>'||
                          '<DOCUMENT_KEY>'||rgInfoVenta.Document_Key||'</DOCUMENT_KEY>'||
                          '<PROJECT_ID/>'||
                          '<COMMENT_>'||rgInfoVenta.Comment_||'</COMMENT_>';

    sbDatosCliente := '<DIRECCION>'||rgInfoVenta.Direccion||'</DIRECCION>'||
                      '<CATEGORIA>'||rgInfoVenta.Categoria||'</CATEGORIA>'||
                      '<SUBCATEGORIA>'||rgInfoVenta.Subcategoria||'</SUBCATEGORIA>'||
                      '<TIPO_DE_IDENTIFICACION>'||rgInfoVenta.Tipo_De_Identificacion||'</TIPO_DE_IDENTIFICACION>'||
                      '<IDENTIFICATION>'||rgInfoVenta.Identification||'</IDENTIFICATION>'||
                      '<SUBSCRIBER_NAME>'||rgInfoVenta.Subscriber_Name||'</SUBSCRIBER_NAME>'||
                      '<APELLIDO>'||rgInfoVenta.Apellido||'</APELLIDO>'||
                      '<COMPANY>'||rgInfoVenta.Company||'</COMPANY>'||
                      '<TITLE>'||rgInfoVenta.Title||'</TITLE>'||
                      '<CORREO_ELECTRONICO>'||rgInfoVenta.Correo_Electronico||'</CORREO_ELECTRONICO>'||
                      '<PERSON_QUANTITY>'||rgInfoVenta.Person_Quantity||'</PERSON_QUANTITY>'||
                      '<OLD_OPERATOR>'||rgInfoVenta.Old_Operator||'</OLD_OPERATOR>'||                                        
					  '<TECNICO_DE_VENTAS>'||rgInfoVenta.TECNICOS_VENTAS_ID||'</TECNICO_DE_VENTAS>'||
                      '<UNIDAD_DE_TRABAJO_INSTALADORA>'||rgInfoVenta.UND_INSTALADORA_ID||'</UNIDAD_DE_TRABAJO_INSTALADORA>'||
                      '<UNIDAD_DE_TRABAJO_CERTIFICADORA>'||rgInfoVenta.UND_CERTIFICADORA_ID||'</UNIDAD_DE_TRABAJO_CERTIFICADORA>'||
                      '<TIPO_DE_PREDIO>'||rgInfoVenta.TIPO_PREDIO||'</TIPO_DE_PREDIO>'||
                      '<PREDIO_EN_CONSTRUCCION>'||rgInfoVenta.CONSTRUCCION||'</PREDIO_EN_CONSTRUCCION>'|| 
                      '<PREDIO_DE_INDEPENDIZACION>'||rgInfoVenta.PREDIO_INDE||'</PREDIO_DE_INDEPENDIZACION>'||
                      '<NUMERO_DE_CONTRATO>'||rgInfoVenta.CONTRATO||'</NUMERO_DE_CONTRATO>'||
                      '<NUMERO_DE_MEDIDOR>'||rgInfoVenta.MEDIDOR||'</NUMERO_DE_MEDIDOR>' ||
                      '<ESTADO_DE_LEY_1581>'||rgInfoVenta.ESTALEY||'</ESTADO_DE_LEY_1581>';
    nuGrupoTelefono := 1;
    FOR rgInfoVentapho IN cuInfophoVenta LOOP
      IF ( nuGrupoTelefono = 1 ) THEN
        sbTelefContacCliente := '<TELEFONOS_DE_CONTACTO GROUP="'||nuGrupoTelefono||'">'||
                                 '<PHONE>'||rgInfoVentapho.phone||'</PHONE>'||
                                 '<PHONE_TYPE_ID>'||rgInfoVentapho.phone_type_id||'</PHONE_TYPE_ID>'||
                                '</TELEFONOS_DE_CONTACTO>';
      ELSE
        sbTelefContacCliente := sbTelefContacCliente||
                      '<TELEFONOS_DE_CONTACTO GROUP="'||nuGrupoTelefono||'">'||
                       '<PHONE>'||rgInfoVentapho.phone||'</PHONE>'||
                       '<PHONE_TYPE_ID>'||rgInfoVentapho.phone_type_id||'</PHONE_TYPE_ID>'||
                      '</TELEFONOS_DE_CONTACTO>';
      END IF;
      nuGrupoTelefono := nuGrupoTelefono + 1;
    END LOOP;

    nuGrupoReferencia := 1;
    FOR rgInfoVentaref IN cuInforefVenta LOOP
      IF ( nuGrupoReferencia = 1 ) THEN
        sbReferenciaCliente :=  '<REFERENCIAS GROUP="'||nuGrupoReferencia||'">'||
                                  '<REFERENCE_TYPE_ID>'||rgInfoVentaref.reference_type_id||'</REFERENCE_TYPE_ID>'||
                                  '<NAME_>'||ltrim(rtrim(rgInfoVentaref.name_))||'</NAME_>'||
                                  '<LAST_NAME>'||ltrim(rtrim(rgInfoVentaref.last_name))||'</LAST_NAME>'||
                                  '<ADDRESS_ID>'||rgInfoVentaref.address_id||'</ADDRESS_ID>'||
                                  '<PHONE>'||rgInfoVentaref.phone||'</PHONE>'||
                                '</REFERENCIAS>';
      ELSE
        sbReferenciaCliente := sbReferenciaCliente||
                      '<REFERENCIAS GROUP="'||nuGrupoReferencia||'">'||
                        '<REFERENCE_TYPE_ID>'||rgInfoVentaref.reference_type_id||'</REFERENCE_TYPE_ID>'||
                        '<NAME_>'||ltrim(rtrim(rgInfoVentaref.name_))||'</NAME_>'||
                        '<LAST_NAME>'||ltrim(rtrim(rgInfoVentaref.last_name))||'</LAST_NAME>'||
                        '<ADDRESS_ID>'||rgInfoVentaref.address_id||'</ADDRESS_ID>'||
                        '<PHONE>'||rgInfoVentaref.phone||'</PHONE>'||
                      '</REFERENCIAS>';
      END IF;
      nuGrupoReferencia := nuGrupoReferencia + 1;
    END LOOP;

    nuGrupoPromocion := 1;
    FOR rgInfoVentaprom IN cuInfoPromVenta LOOP
      IF ( nuGrupoPromocion = 1 ) THEN
        sbDatosPromocion := '<PROMOCIONES GROUP="'||nuGrupoPromocion||'">'||
                             '<PROMOTION_ID>'||rgInfoVentaprom.Promotion_Id||'</PROMOTION_ID>'||
                            '</PROMOCIONES>';
      ELSE
        sbDatosPromocion := TRIM(sbDatosPromocion)||
                          '<PROMOCIONES GROUP="'||nuGrupoPromocion||'">'||
                           '<PROMOTION_ID>'||rgInfoVentaprom.Promotion_Id||'</PROMOTION_ID>'||
                          '</PROMOCIONES>';
      END IF;
      nuGrupoPromocion := nuGrupoPromocion + 1;
    END LOOP;

    sbDatosInstalacion := '<M_INSTALACION_DE_GAS_100219>'||
                            '<COMMERCIAL_PLAN_ID>'||rgInfoVenta.Commercial_Plan_Id||'</COMMERCIAL_PLAN_ID>'||
                               sbDatosPromocion||
                            '<TOTAL_VALUE>'||rgInfoVenta.Total_Value||'</TOTAL_VALUE>'||
                            '<PLAN_DE_FINANCIACION>'||rgInfoVenta.Plan_De_Financiacion||'</PLAN_DE_FINANCIACION>'||
                            '<INITIAL_PAYMENT>'||rgInfoVenta.Initial_Payment||'</INITIAL_PAYMENT>'||
                            '<NUMERO_DE_CUOTAS>'||to_char(rgInfoVenta.Numero_De_Cuotas)||'</NUMERO_DE_CUOTAS>'||
                            '<CUOTA_MENSUAL>'||rgInfoVenta.Cuota_Mensual||'</CUOTA_MENSUAL>'||
                            '<INIT_PAYMENT_MODE>'||rgInfoVenta.Init_Payment_Mode||'</INIT_PAYMENT_MODE>'||
                            '<INIT_PAY_RECEIVED>'||rgInfoVenta.Init_Pay_Received||'</INIT_PAY_RECEIVED>'||
                            '<USAGE>'||rgInfoVenta.Usage||'</USAGE>'||
                            '<INSTALL_TYPE>'||to_char(rgInfoVenta.Install_Type)||'</INSTALL_TYPE>'||
                             '<C_GAS_10311>'||
                                           '<C_MEDICION_10312/>'||
                             '</C_GAS_10311>'||
                          '</M_INSTALACION_DE_GAS_100219>'||
                         '</P_VENTA_DE_GAS_POR_FORMULARIO_XML_100233>';


    sbXML :=  sbDatosEncXML||sbDatosSolicitud||sbDatosCliente||sbTelefContacCliente||
              sbReferenciaCliente||sbDatosInstalacion;

    ut_trace.trace('FIN ldci_pkossventmovilgesmanu.ProcArmaXMLVenta',10);

  END ProcArmaXMLVenta;

  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: fnuAplicaEntrega
  Descripción:        Función para validar si la entrega aplica para la gasera

  Autor    : KCienfuegos

  Fecha    :  01-09-2016

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.                      Modificación
  -----------  -------------------            -------------------------------------
  01-09-2016   KCienfuegos.CA200-37           Creación
  ******************************************************************/
  FUNCTION fnuAplicaEntrega(isbNombreEntrega VARCHAR2)
    RETURN NUMBER IS

  BEGIN
       ut_trace.trace('INICIA ldci_pkossventmovilgesmanu.fnuAplicaEntrega',10);

       IF (fblaplicaentrega(isbNombreEntrega)) THEN
          RETURN 1;
       ELSE
          RETURN 0;
       END IF;

       RETURN 0;

       ut_trace.trace('FIN ldci_pkossventmovilgesmanu.fnuAplicaEntrega',10);

  EXCEPTION
    WHEN OTHERS THEN
       RETURN 0;
  END;


  /***************************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Unidad: FillCouponAtt

    Descripcion:   Arma el sql y llena la tabla de atributos para la seleccion
                    de registros de cupones


    Historia de Modificaciones
    Fecha       Autor               Modificacion
    =========   =========           ====================
    04-10-2018  Josh brito          Creacion caso 200-2040
    ****************************************************************************/
    PROCEDURE FillCouponAtt
    IS
      --SBVALOID     VARCHAR2( 500 );
    BEGIN

         if sbCouponAttribs IS not null then
            return;
        END if;

        --SBVALOID := 'c.CUPONUME||'';''||c.CUPOSUSC';
        cc_boBossUtil.AddAttribute ('c.CUPONUME', 'CUPONUME',  sbCouponAttribs);
        cc_boBossUtil.AddAttribute ('c.CUPOTIPO', 'CUPOTIPO',  sbCouponAttribs);
        cc_boBossUtil.AddAttribute ('c.CUPODOCU', 'CUPODOCU',  sbCouponAttribs);
        cc_boBossUtil.AddAttribute ('c.CUPOVALO', 'CUPOVALO',  sbCouponAttribs);
        cc_boBossUtil.AddAttribute ('c.CUPOFECH', 'CUPOFECH',  sbCouponAttribs);
        cc_boBossUtil.AddAttribute ('c.CUPOPROG', 'CUPOPROG',  sbCouponAttribs);
        cc_boBossUtil.AddAttribute ('c.CUPOCUPA', 'CUPOCUPA',  sbCouponAttribs);
        cc_boBossUtil.AddAttribute ('c.CUPOSUSC', 'CUPOSUSC',  sbCouponAttribs);
        cc_boBossUtil.AddAttribute ('decode(c.CUPOFLPA,'''||'S'||''','''||'SI'||''','''||'NO'||''')', 'CUPOFLPA',  sbCouponAttribs);

       -- cc_boBossUtil.AddAttribute( SBVALOID, 'Id', sbCouponAttribs );

        cc_boBossUtil.AddAttribute (':cotizacion_venta_id', 'cotizacion_venta_id', sbCouponAttribs);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            errors.seterror;
            raise ex.CONTROLLED_ERROR;
    END FillCouponAtt;

   /**************************************************************************
    Propiedad intelectual de HORBATH.

    Unidad        : GetCoupon
    Descripcion   : Obtiene la informacion de los cupones para COVCM
    Autor         : Josh Brito - caso 200-2040
    ***************************************************************************/
  PROCEDURE GetCoupon( inuCoti     in   Ldci_CotiVentasMovil.cotizacion_venta_id%type,
                         OCUCURSOR OUT CONSTANTS.TYREFCURSOR )
    IS
      SBSQL           VARCHAR2( 10000 );
      onuPackageId    MO_PACKAGES.PACKAGE_ID%type;
      inuCupon        CUPON.CUPONUME%type;

      CURSOR cuSolicitudCoti IS
      SELECT SOLICITUD_GENERADA --INTO onuPackageId
          FROM LDCI_COTIVENTASMOVIL
          WHERE COTIZACION_VENTA_ID = inuCoti;

      CURSOR cuCuponDocuDEPP (onuPackageId number) IS
      SELECT c.CUPONUME --into inuCupon
              FROM cupon c
              WHERE c.cupodocu = onuPackageId --isbCupodocu
              AND c.cupotipo in ( 'DE', 'PP' );

      CURSOR cuCupon (onuPackageId number) IS
      SELECT mp.coupon_id --into inuCupon
          FROM mo_motive_payment mp, mo_package_payment pp
          WHERE pp.PACKAGE_ID = onuPackageId --mp.coupon_id = inuCuponId
          AND mp.package_payment_id = pp.package_payment_id;

      CURSOR cuCuponDocuAFFA (onuPackageId number) IS
      SELECT c.CUPONUME --into inuCupon
              FROM cupon c, mo_motive_payment mp, mo_package_payment pp
              WHERE c.cupodocu = onuPackageId --isbCupodocu
              AND c.cupotipo in ( 'AF', 'FA' )
              AND c.cupodocu = mp.support_document
              AND mp.package_payment_id = pp.package_payment_id;
    BEGIN

    UT_TRACE.TRACE( 'Begin ldc_bocoupons.GetCoupons', 10 );

    OPEN cuSolicitudCoti;
      FETCH cuSolicitudCoti INTO onuPackageId;
        IF cuSolicitudCoti%NOTFOUND THEN
          onuPackageId := null;
        END IF;
    CLOSE cuSolicitudCoti;

    if onuPackageId is not null THEN

        OPEN cuCuponDocuDEPP(onuPackageId);
          FETCH cuCuponDocuDEPP INTO inuCupon;
            IF cuCuponDocuDEPP%NOTFOUND THEN
              inuCupon := null;
            END IF;
        CLOSE cuCuponDocuDEPP;

        IF inuCupon IS NULL THEN
            OPEN cuCupon(onuPackageId);
              FETCH cuCupon INTO inuCupon;
                IF cuCupon%NOTFOUND THEN
                  inuCupon := null;
                END IF;
            CLOSE cuCupon;
        END IF;

        IF inuCupon IS NULL THEN
            OPEN cuCuponDocuAFFA(onuPackageId);
              FETCH cuCuponDocuAFFA INTO inuCupon;
                IF cuCuponDocuAFFA%NOTFOUND THEN
                  inuCupon := null;
                END IF;
            CLOSE cuCuponDocuAFFA;
        END IF;

    END IF;

    FillCouponAtt;

    sbSql := ' SELECT '||sbCouponAttribs||' '                ||chr(10)||
          'FROM  /*+ LDCI_PKOSSVENTMOVILGESMANU.GetCoupon */ cupon c '  ||chr(10)||
          'WHERE  c.cuponume = :inuCupon';

     -- open ocuCursor for sbSql using cc_bobossutil.cnuNULL, INUSUBSCRIPTION;
    open ocuCursor for sbSql using inuCoti, inuCupon;

    UT_TRACE.TRACE( 'Sentencia: ' || SBSQL, 10 );
    UT_TRACE.TRACE( 'End LDCI_PKOSSVENTMOVILGESMANU.GetCoupons', 10 );

    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;


END LDCI_PKOSSVENTMOVILGESMANU;
/

