CREATE OR REPLACE PACKAGE adm_person.LD_BCGASSUBSCRIPTION is

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_BCGASSUBSCRIPTION
  Descripcion    : Paquete BC con las funciones y/o procedimientos que contendrá la solicitud de
                   terminación de contrato.
  Autor          : Kbaquero
  Fecha          : 16/11/2012 SAO 159730

  Metodos

  Nombre         :
  Parametros         Descripción
  ============   ===================
  Historia de Modificaciones
  Fecha            Autor                Modificación
  =========      =========              ====================
  19/06/2024     PAcosta                OSF-2845: Cambio de esquema ADM_PERSON  
  23/05/2014     acardenas.Cambio3647   Se adiciona servicio FnuGetMotiveByProd.
  ******************************************************************/

  -- Declaracion de Tipos de datos publicos

  -- Declaracion de variables publicas
  -----------------------
  -- Constants
  -----------------------
  -- Constante con el SAO de la ultima version aplicada
  csbVERSION CONSTANT VARCHAR2(10) := 'SAO159730';
  -----------------------
  --------------------------------------------------------------------
  -- Variables
  --------------------------------------------------------------------
  --------------------------------------------------------------------
  -- Cursores
  --------------------------------------------------------------------
  -----------------------------------
  -- Metodos publicos del package
  -----------------------------------

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure      :  fsbVersion
  Descripcion    :  Obtiene la Version actual del Paquete

  Parametros     :  Descripción
  Retorno        :
  csbVersion        Version del Paquete

  Autor          :  Kbaquero SAO 159730
  Fecha          :  16/11/2012

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  *****************************************************************/

  FUNCTION fsbVersion return varchar2;
  sbconsultation varchar2(4000);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fbodeferredHas
  Descripcion    : Retorna un numero con el
                   que se valida si alguno de los productos del contrato tiene diferidos activo y con saldo
                   pendiente.
   Autor          : Kbaquero SAO 159730
  Fecha          : 19/11/2012

  Parametros             Descripción
  ============        ===================
  inuSubscription:    Identificador del contrato
  inuProductTYpe :    Identificador del tipo de producto

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ******************************************************************/

  FUNCTION fbodeferredHas(inuSubscription suscripc.susccodi%type,
                          inuProductTYpe  ld_parameter.numeric_value%type,
                          inuProductTYpep ld_parameter.numeric_value%type)
    RETURN number;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fbodeferredHasd
    Descripcion    : Retorna un numero con el que se valida si alguno de los productos del contrato
                     tiene diferidos activo y con saldo pendiente.

    Autor          : Kbaquero SAO 159730
    Fecha          : 19/11/2012

    Parametros             Descripción
    ============        ===================
    inuSubscription:    Identificador del contrato

    Historia de Modificaciones
    Fecha         Autor       Modificacion
    =========   ========= ====================

  ******************************************************************/

  FUNCTION fbodeferredHasd(inuSubscription suscripc.susccodi%type,
                           inuProductTYpe  ld_parameter.numeric_value%type,
                           inuProductTYpep ld_parameter.numeric_value%type)
    RETURN number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchProd
  Descripcion    : Se genera un cursor referenciado con la información delos productos de ese contrato
  Autor          : Kbaquero
  Fecha          : 19/11/2012 SAO 159730

  Parametros         Descripción
  ============   ===================
   inuSuscripc       Número del contrato
  Orfsuscribyprod    Cursor referenciado con los datos del producto de un contrato

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchProd(inuSuscripc     in suscripc.susccodi%type,
                           inuprodtype     in pr_product.product_type_id%type,
                           Orfsuscribyprod out pkConstante.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchProdBrilla
  Descripcion    : Se genera un cursor referenciado con la información de los productos Brilla de ese contrato
  Autor          : Kbaquero
  Fecha          : 19/11/2012 SAO 159730

  Parametros         Descripción
  ============   ===================
   inuSuscripc       Número del contrato
  Orfsuscribyprod    Cursor referenciado con los datos del producto de un contrato

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchProdBrilla(inuSuscripc     in suscripc.susccodi%type,
                           inuprodtype     in pr_product.product_type_id%type,
                           inuProductTYpep in pr_product.product_type_id%type,
                           Orfsuscribyprod out pkConstante.tyRefCursor);

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FrfGetGASProduct
    Descripcion    : Retorna un numero del producto de gas de un contrato.

    Autor          : Kbaquero SAO 159730
    Fecha          : 26/11/2012

    Parametros             Descripción
    ============        ===================
    inuSubscription:    Identificador del contrato
    inuserv:            Identificador del tipo de producto

    Historia de Modificaciones
    Fecha         Autor       Modificacion
    =========   ========= ====================

  ******************************************************************/

  FUNCTION FrfGetGASProduct(inuSubscription suscripc.susccodi%type,
                            inuserv         servsusc.sesuserv%type)
    RETURN number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : ProcConvDate
   Descripcion    : Se genera un cursor referenciado con la información de los productos de ese contrato
   Autor          : Kbaquero
   Fecha          : 28/11/2012 SAO 159730

   Parametros          Descripción
   ============       ===================
  idtRegisterDate:     Identificador de fecha
  onuRegiDate:         Identificador de fecha

   Historia de Modificaciones
   Fecha            Autor       Modificación
   =========      =========  ====================
   ******************************************************************/

  PROCEDURE ProcConvDate(idtRegisterDate in varchar2,
                         onuRegiDate     out mo_packages.request_date%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchDataPack
  Descripcion    : Se genera un cursor referenciado con la información de los productos de ese contrato
  Autor          : Kbaquero
  Fecha          : 19/11/2012 SAO 159730

  Parametros         Descripción
  ============   ===================
   inuSuscripc       Número del contrato
  Orfsuscribyprod    Cursor referenciado con los datos del producto de un contrato

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchDataPack(inuSuscripc in suscripc.susccodi%type,
                               inupackage  in mo_packages.package_id %type,
                               onumotive   out mo_motive.motive_id%type);

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnuAddressPro
    Descripcion    : Retorna la dirección de instalación del tipo de producto gas.

    Autor          : Kbaquero SAO 159730
    Fecha          : 03/01/2013

    Parametros             Descripción
    ============        ===================
    inuSubscription:    Identificador del contrato
    inuProductTYpe:     Tipo de producto gas

    Historia de Modificaciones
    Fecha         Autor       Modificacion
    =========   ========= ====================

  ******************************************************************/

  FUNCTION fnuAddressPro(inuSubscription suscripc.susccodi%type,
                         inuProductTYpe  ld_parameter.numeric_value%type,
                         inuProductTYpep ld_parameter.numeric_value%type)
    RETURN ab_address.address_id%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchProductFnb
  Descripcion    : Busca los productos generados por contrato de tipo 7055.7056
  Autor          : AAcuña
  Fecha          : 02/01/20123 SAO 159764

  Parametros         Descripción
  ============   ===================
  inuGas_Service:   Parametro del número de servicio
  inuSubscription:  Parametro del contrato
  otbProduct:       Objeto tipo tabla con los productos

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchProductFnb(inuProductTYpe  ld_parameter.numeric_value%type,
                                 inuProductTYpep ld_parameter.numeric_value%type,
                                 inuSubscription suscripc.susccodi%type,
                                 otbProduct      out dapr_product.tytbproduct_id);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchMotiveFnb
  Descripcion    : Busca los motivos asociados a la solicitud y su tipo de producto sea 7055.7056
  Autor          : AAcuña
  Fecha          : 03/01/20123 SAO 159764

  Parametros         Descripción
  ============   ===================
  inuGas_Service:   Parametro del número de servicio
  inuSubscription:  Parametro del contrato
  otbProduct:       Objeto tipo tabla con los productos

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchMotiveFnb(inupackage in mo_packages.package_id%type,
                                otbMotive  out damo_motive.tytbMotive_Id);

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuGetMotive
    Descripcion    : Retorna el número de motivo creado para el tipo de producto gas

    Autor          : AAcuna SAO 159730
    Fecha          : 04/01/2013

    Parametros             Descripción
    ============        ===================
    inupackage:     Identificador de  la solicitud
    inuserv:        Identificador del tipo de producto

    Historia de Modificaciones
    Fecha         Autor       Modificacion
    =========   ========= ====================

  ******************************************************************/

  FUNCTION FnuGetMotive(inupackage in mo_packages.package_id%type,
                        inuserv    in servsusc.sesuserv%type)

   RETURN number;

     /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchMotiveProduct
  Descripcion    : Busca los productos asociados a la solicitud, para la
                   Actualización del estado
  Autor          : Kbaquero
  Fecha          : 25/06/2013 SAO 159730

  Parametros         Descripción
  ============   ===================
  inupackage:     Id. Del paquete
  otbProduct:       Objeto tipo tabla con los productos

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchMotiveProduct(inupackage in mo_packages.package_id%type,
                                   otbProduct  out dapr_product.tytbproduct_Id);


/*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchProductComp
  Descripcion    : Busca los compomentes asociados a un productos, para la
                   Actualización del estado del componente.
  Autor          : Kbaquero
  Fecha          : 25/06/2013 SAO 159730

  Parametros         Descripción
  ============   ===================
  inupackage:     Id. Del paquete
  otbcomponent:       Objeto tipo tabla con los componentes

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchProductComp(inuproduct in mo_motive.product_id%type,
                                  otbcomponent  out dapr_component.tytbcomponent_id);


  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetMotiveByProd
  Descripcion    : Obtiene el código del motivo dado el producto y la solicitud.
  Autor          : acardenas
  Fecha          : 23/05/2014   Cambio 3647

  Parametros         Descripción
  ============   ===================
  inupackage     Código del paquete
  inuProduct     Código del producto

  Historia de Modificaciones
  Fecha         Autor               Modificacion
  =========   =========             ====================
  23/05/2014  acardenas.Cambio3647  Creación
  ******************************************************************/

  FUNCTION FnuGetMotiveByProd(
                              inupackage    mo_packages.package_id%type,
                              inuProduct    pr_product.product_id%type
                              )
  RETURN    NUMBER;


  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetAttribOldVal
  Descripcion    : Obtiene el estado anterior del producto, dado el motivo y el
                   código del producto.
  Autor          : acardenas
  Fecha          : 23/05/2014   Cambio 3647

  Parametros         Descripción
  ============   ===================
  isbEntity      Nombre la entidad
  isbAttrib      Nombre del atributo
  inuMotive      Código del motivo
  isbPrimKey     Código de llave primaria de la entidad

  Historia de Modificaciones
  Fecha         Autor               Modificacion
  =========   =========             ====================
  23/05/2014  acardenas.Cambio3647  Creación
  ******************************************************************/

  FUNCTION FnuGetAttribOldVal(
                              isbEntity     mo_data_change.entity_name%type,
                              isbAttrib     mo_data_change.attribute_name%type,
                              inuMotive     mo_data_change.motive_id%type,
                              isbPrimKey    mo_data_change.entity_pk%type
                              )
  RETURN NUMBER;

end LD_BCGASSUBSCRIPTION;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LD_BCGASSUBSCRIPTION is

  -- Declaracion de variables y tipos globales privados del paquete

  -- Definicion de metodos publicos y privados del paquete

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure      :  fsbVersion
  Descripcion    :  Obtiene la Version actual del Paquete

  Parametros     :  Descripción
  Retorno        :
  csbVersion        Version del Paquete

  Autor          :  kbaquero SAO 159730
  Fecha          :  16/11/2012

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  *****************************************************************/

  FUNCTION fsbVersion RETURN varchar2 IS
  BEGIN
    pkErrors.Push('LD_BCGASSUBSCRIPTION.fsbVersion');
    pkErrors.Pop;
    -- Retorna el SAO con que se realizo la ultima entrega
    RETURN(csbVersion);
  END fsbVersion;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fbodeferredHas
    Descripcion    : Retorna un numero con el que se valida si alguno de los productos del contrato
                     tiene diferidos activo y con saldo pendiente.

    Autor          : Kbaquero SAO 159730
    Fecha          : 19/11/2012

    Parametros             Descripción
    ============        ===================
    inuSubscription:    Identificador del contrato

    Historia de Modificaciones
    Fecha         Autor       Modificacion
    =========   ========= ====================

  ******************************************************************/

  FUNCTION fbodeferredHas(inuSubscription suscripc.susccodi%type,
                          inuProductTYpe  ld_parameter.numeric_value%type,
                          inuProductTYpep ld_parameter.numeric_value%type)
    RETURN number IS

    nucant number;

  begin

    ut_trace.Trace('INICIO LD_BCGASSUBSCRIPTION.fbodeferredHas', 10);

    select /*+ INDEX (FK_DIFE_SUSC_CODI) USE_NL(diferido p)*/
     count(*)
      into nucant
      from diferido, pr_product p
     where difesape > 0
       and difesusc = inuSubscription
       and p.product_type_id in (inuProductTYpe, inuProductTYpep)
       and p.product_id = difenuse;

    return nucant;

    ut_trace.Trace('FIN LD_BCGASSUBSCRIPTION.fbodeferredHas', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return 0;
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      return 0;
      raise ex.CONTROLLED_ERROR;

  END fbodeferredHas;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fbodeferredHasd
    Descripcion    : Retorna un numero con el que se valida si alguno de los productos del contrato
                     tiene diferidos activo y con saldo pendiente.

    Autor          : Kbaquero SAO 159730
    Fecha          : 19/11/2012

    Parametros             Descripción
    ============        ===================
    inuSubscription:    Identificador del contrato

    Historia de Modificaciones
    Fecha         Autor       Modificacion
    =========   ========= ====================

  ******************************************************************/

  FUNCTION fbodeferredHasd(inuSubscription suscripc.susccodi%type,
                           inuProductTYpe  ld_parameter.numeric_value%type,
                           inuProductTYpep ld_parameter.numeric_value%type)
    RETURN number IS

    nucant number;

  begin

    ut_trace.Trace('INICIO LD_BCGASSUBSCRIPTION.fbodeferredHasd', 10);

    select /*+ INDEX (FK_DIFE_SUSC_CODI) USE_NL(diferido p)*/
     count(*)
      into nucant
      from diferido, pr_product p
     where difesusc = inuSubscription
       and p.product_type_id in (inuProductTYpe, inuProductTYpep)
       and p.product_id = difenuse;

    return nucant;

    ut_trace.Trace('FIN LD_BCGASSUBSCRIPTION.fbodeferredHasd', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return 0;
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      return 0;
      raise ex.CONTROLLED_ERROR;

  END fbodeferredHasd;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchProd
  Descripcion    : Se genera un cursor referenciado con la información de los productos de ese contrato
  Autor          : Kbaquero
  Fecha          : 19/11/2012 SAO 159730

  Parametros         Descripción
  ============   ===================
   inuSuscripc       Número del contrato
  Orfsuscribyprod    Cursor referenciado con los datos del producto de un contrato

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchProd(inuSuscripc     in suscripc.susccodi%type,
                           inuprodtype     in pr_product.product_type_id%type,
                           Orfsuscribyprod out pkConstante.tyRefCursor)

   IS

  BEGIN

    ut_trace.Trace('INICIO LD_BCGASSUBSCRIPTION.ProcSearchProd', 10);

    OPEN Orfsuscribyprod FOR

      SELECT /*+ FK_PR_PRODUCT_SUSCRIPC016 */
       product_id
        from pr_product
       where subscription_id = inuSuscripc
         and product_type_id = inuprodtype
         and product_status_id = 1;

    ut_trace.Trace('FIN LD_BCGASSUBSCRIPTION.ProcSearchProd', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSearchProd;

    /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchProdBrilla
  Descripcion    : Se genera un cursor referenciado con la información de los productos Brilla de ese contrato
  Autor          : Kbaquero
  Fecha          : 19/11/2012 SAO 159730

  Parametros         Descripción
  ============   ===================
   inuSuscripc       Número del contrato
  Orfsuscribyprod    Cursor referenciado con los datos del producto de un contrato

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchProdBrilla(inuSuscripc     in suscripc.susccodi%type,
                           inuprodtype     in pr_product.product_type_id%type,
                           inuProductTYpep in pr_product.product_type_id%type,
                           Orfsuscribyprod out pkConstante.tyRefCursor)

   IS

  BEGIN

    ut_trace.Trace('INICIO LD_BCGASSUBSCRIPTION.ProcSearchProdBrilla', 10);

    OPEN Orfsuscribyprod FOR

      SELECT /*+ FK_PR_PRODUCT_SUSCRIPC016 */
       product_id
        from pr_product
       where subscription_id = inuSuscripc
         and product_type_id in (inuprodtype,inuProductTYpep)
         and product_status_id = 1;

    ut_trace.Trace('FIN LD_BCGASSUBSCRIPTION.ProcSearchProdBrilla', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSearchProdBrilla;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FrfGetGASProduct
    Descripcion    : Retorna un numero del producto de gas de un contrato.

    Autor          : Kbaquero SAO 159730
    Fecha          : 26/11/2012

    Parametros             Descripción
    ============        ===================
    inuSubscription:    Identificador del contrato
    inuserv:            Identificador del tipo de producto

    Historia de Modificaciones
    Fecha         Autor       Modificacion
    =========   ========= ====================

  ******************************************************************/

  FUNCTION FrfGetGASProduct(inuSubscription suscripc.susccodi%type,
                            inuserv         servsusc.sesuserv%type)
    RETURN number IS

    nuprprod number;

  begin

    ut_trace.Trace('INICIO LD_BCGASSUBSCRIPTION.FrfGetGASProduct', 10);

    select /*+ IX_SERVSUSC12*/
     sesunuse
      into nuprprod
      from servsusc
     where sesuserv = inuserv
       and sesususc = inuSubscription;

    return nuprprod;

    ut_trace.Trace('FIN LD_BCGASSUBSCRIPTION.FrfGetGASProduct', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return 0;
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      return 0;
      raise ex.CONTROLLED_ERROR;

  END FrfGetGASProduct;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcConvDate
  Descripcion    : Se genera un cursor referenciado con la información de los productos de ese contrato
  Autor          : Kbaquero
  Fecha          : 27/11/2012 SAO 159730

  Parametros         Descripción
  ============   ===================


  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcConvDate(idtRegisterDate in varchar2,
                         onuRegiDate     out mo_packages.request_date%type) is

  BEGIN
    ut_trace.Trace('INICIO LD_BCGASSUBSCRIPTION.ProcConvDate', 10);

    select to_date(idtRegisterDate, 'dd/mm/yyyy')
      into onuRegiDate
      from dual;

    ut_trace.Trace('FIN LD_BCGASSUBSCRIPTION.ProcConvDate', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;

      raise ex.CONTROLLED_ERROR;
  end;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchDataPack
  Descripcion    : Busca la información del motivo, para crear uno adicional
  Autor          : Kbaquero
  Fecha          : 20/12/2012 SAO 159730

  Parametros         Descripción
  ============   ===================
   inuSuscripc       Número del contrato
   inupackage        identificador del paquete

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchDataPack(inuSuscripc in suscripc.susccodi%type,
                               inupackage  in mo_packages.package_id%type,
                               onumotive   out mo_motive.motive_id%type)

   IS

  BEGIN

    ut_trace.Trace('INICIO LD_BCGASSUBSCRIPTION.ProcSearchDataPack', 10);

    SELECT /*+ index(m idx_mo_packages_13)*/
     o.motive_id
      INTO onumotive
      FROM mo_motive o, mo_packages m
     WHERE m.package_id = inupackage
       AND m.tag_name = 'P_TRAMITE_DE_TERMINACION_DE_CONTRATO_100262'
       AND o.subscription_id = inuSuscripc
       AND m.package_id = o.package_id;

    ut_trace.Trace('FIN LD_BCGASSUBSCRIPTION.ProcSearchDataPack', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSearchDataPack;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnuAddressPro
    Descripcion    : Retorna la dirección de instalación del tipo de producto gas.

    Autor          : Kbaquero SAO 159730
    Fecha          : 03/01/2013

    Parametros             Descripción
    ============        ===================
    inuSubscription:    Identificador del contrato
    inuProductTYpe:     Tipo de producto gas

    Historia de Modificaciones
    Fecha         Autor       Modificacion
    =========   ========= ====================

  ******************************************************************/

  FUNCTION fnuAddressPro(inuSubscription suscripc.susccodi%type,
                         inuProductTYpe  ld_parameter.numeric_value%type,
                         inuProductTYpep ld_parameter.numeric_value%type)

    RETURN ab_address.address_id%type IS

    nuaddress ab_address.address_id%type;
  begin

    ut_trace.Trace('INICIO LD_BCGASSUBSCRIPTION.fnuAddressPro', 10);

    SELECT /*+ index(idx_pr_product_010)*/
    distinct address_id
      INTO nuaddress
      FROM pr_product
     where SUBSCRIPTION_ID = inuSubscription
       AND product_type_id in (inuProductTYpe, inuProductTYpep);

    return nuaddress;

    ut_trace.Trace('FIN LD_BCGASSUBSCRIPTION.fnuAddressPro', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return 0;
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      return 0;
      raise ex.CONTROLLED_ERROR;

  END fnuAddressPro;

  /****************************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchProductFnb
  Descripcion    : Busca los productos generados por contrato de tipo 7055.7056
  Autor          : AAcuña
  Fecha          : 02/01/2013 SAO 159764

  Parametros         Descripción
  ============   ===================
  inuGas_Service:   Parametro del número de servicio
  inuSubscription:  Parametro del contrato
  otbProduct:       Objeto tipo tabla con los productos

  Historia de Modificaciones
  Fecha        Autor                  Modificación
  =========    =========              ====================
  26/05/2014   acardenas.Cambio3647   Se modifica para excluir los productos de Servicios
                                      Financieros que se encuentren Retirados o Pendientes
                                      de Retiro. A estos productos NO se les debe generar
                                      motivo de terminación de contrato.
  ****************************************************************************/

  PROCEDURE ProcSearchProductFnb(inuProductTYpe  ld_parameter.numeric_value%type,
                                 inuProductTYpep ld_parameter.numeric_value%type,
                                 inuSubscription suscripc.susccodi%type,
                                 otbProduct      out dapr_product.tytbproduct_id)

   IS

    orfProduct pkConstante.tyRefCursor;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcSearchProductFnb', 10);

    OPEN orfProduct FOR
      SELECT /*+ INDEX (P idx_pr_product_010)*/
             product_id
        FROM pr_product
       WHERE subscription_id    = inuSubscription
         AND product_type_id    in (inuProductTYpe, inuProductTYpep)
         AND product_status_id  not in (3,20);
         -- Excluye productos retirados y pendientes de retiro

    FETCH   orfProduct BULK COLLECT
    INTO    otbProduct;
    CLOSE   orfProduct;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearchProductFnb', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSearchProductFnb;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchMotiveFnb
  Descripcion    : Busca los motivos asociados a la solicitud y su tipo de producto sea 7055.7056
  Autor          : AAcuña
  Fecha          : 03/01/20123 SAO 159764

  Parametros         Descripción
  ============   ===================
  inuGas_Service:   Parametro del número de servicio
  inuSubscription:  Parametro del contrato
  otbProduct:       Objeto tipo tabla con los productos

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchMotiveFnb(inupackage in mo_packages.package_id%type,
                                otbMotive  out damo_motive.tytbMotive_Id)

   IS

    orfMo_motive pkConstante.tyRefCursor;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcSearchProductFnb', 10);

    OPEN orfMo_motive FOR
      SELECT /*+ index (pk_mo_packages) */
       o.motive_id
        FROM mo_motive o, mo_packages m
       WHERE m.package_id = inupackage
         AND o.tag_name = 'M_INSTALACION_DE_GAS_100269'
         AND m.package_id = o.package_id;

    FETCH orfMo_motive BULK COLLECT
      INTO otbMotive;
    CLOSE orfMo_motive;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearchProductFnb', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSearchMotiveFnb;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuGetMotive
    Descripcion    : Retorna el número de motivo creado para el tipo de producto gas

    Autor          : AAcuna SAO 159730
    Fecha          : 04/01/2013

    Parametros             Descripción
    ============        ===================
    inupackage:     Identificador de  la solicitud
    inuserv:        Identificador del tipo de producto

    Historia de Modificaciones
    Fecha         Autor       Modificacion
    =========   ========= ====================

  ******************************************************************/

  FUNCTION FnuGetMotive(inupackage in mo_packages.package_id%type,
                        inuserv    in servsusc.sesuserv%type)

   RETURN number IS

    nuMotive mo_motive.motive_id%type;

  BEGIN

    ut_trace.Trace('INICIO LD_BCGASSUBSCRIPTION.FnuGetMotive', 10);

    SELECT /*+ index(idx_mo_motive_02)*/
     motive_id
      INTO nuMotive
      FROM mo_motive
     WHERE package_id = inupackage
       AND product_type_id = inuserv;

    return nuMotive;

    ut_trace.Trace('FIN LD_BCGASSUBSCRIPTION.FnuGetMotive', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return 0;
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      return 0;
      raise ex.CONTROLLED_ERROR;

  END FnuGetMotive;


   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchMotiveProduct
  Descripcion    : Busca los productos asociados a la solicitud, para la
                   Actualización del estado
  Autor          : Kbaquero
  Fecha          : 25/06/2013 SAO 159730

  Parametros         Descripción
  ============   ===================
  inupackage:     Id. Del paquete
  otbProduct:       Objeto tipo tabla con los productos

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchMotiveProduct(inupackage in mo_packages.package_id%type,
                                   otbProduct  out dapr_product.tytbproduct_Id)

   IS

    orfMo_motiveProd pkConstante.tyRefCursor;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcSearchMotiveProduct', 10);

    OPEN orfMo_motiveProd FOR
      SELECT /*+ index (pk_mo_packages) */
       o.product_id
        FROM mo_motive o, mo_packages m
       WHERE m.package_id = inupackage
         AND o.tag_name = 'M_INSTALACION_DE_GAS_100269'
         AND m.package_id = o.package_id;

    FETCH orfMo_motiveProd BULK COLLECT
      INTO otbProduct;
    CLOSE orfMo_motiveProd;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearchMotiveProduct', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END ProcSearchMotiveProduct;


  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSearchProductComp
  Descripcion    : Busca los compomentes asociados a un productos, para la
                   Actualización del estado del componente.
  Autor          : Kbaquero
  Fecha          : 25/06/2013 SAO 159730

  Parametros         Descripción
  ============   ===================
  inupackage:     Id. Del paquete
  otbcomponent:       Objeto tipo tabla con los componentes

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSearchProductComp(inuproduct in mo_motive.product_id%type,
                                  otbcomponent  out dapr_component.tytbcomponent_id)

   IS

    orfMo_Prodcomp pkConstante.tyRefCursor;

  BEGIN

    ut_trace.Trace('INICIO Ld_BcSecureManagement.ProcSearchProductComp', 10);

    OPEN orfMo_Prodcomp FOR
     select /*+ index (IDX_PR_COMPONENT_2)*/
        p.component_id
         from pr_component p
        where p.product_id = inuproduct;

    FETCH orfMo_Prodcomp BULK COLLECT
      INTO otbcomponent;
    CLOSE orfMo_Prodcomp;

    ut_trace.Trace('FIN Ld_BcSecureManagement.ProcSearchProductComp', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END ProcSearchProductComp;


  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetMotiveByProd
  Descripcion    : Obtiene el código del motivo dado el producto y la solicitud.
  Autor          : acardenas
  Fecha          : 23/05/2014   Cambio 3647

  Parametros         Descripción
  ============   ===================
  inupackage     Código del paquete
  inuProduct     Código del producto

  Historia de Modificaciones
  Fecha         Autor               Modificacion
  =========   =========             ====================
  23/05/2014  acardenas.Cambio3647  Creación
  ******************************************************************/

  FUNCTION FnuGetMotiveByProd(
                              inupackage    mo_packages.package_id%type,
                              inuProduct    pr_product.product_id%type
                              )
  RETURN NUMBER
  IS
    nuMotive mo_motive.motive_id%type;
  BEGIN

    ut_trace.Trace('INICIO LD_BCGASSUBSCRIPTION.FnuGetMotiveByProd', 10);

    SELECT  /*+ index(idx_mo_motive_02)*/
            motive_id
    INTO    nuMotive
    FROM    mo_motive
    WHERE   package_id = inupackage
            AND product_id = inuProduct;

    ut_trace.Trace('FIN LD_BCGASSUBSCRIPTION.FnuGetMotiveByProd', 10);

    return nuMotive;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END FnuGetMotiveByProd;


  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuGetAttribOldVal
  Descripcion    : Obtiene el valor anterior en la entidad MO_DATA_CHANGE, dado
                   la entidad, el atributo, el motivo y la llave primaria.
  Autor          : acardenas
  Fecha          : 23/05/2014   Cambio 3647

  Parametros         Descripción
  ============   ===================
  isbEntity      Nombre la entidad
  isbAttrib      Nombre del atributo
  inuMotive      Código del motivo
  isbPrimKey     Código de llave primaria de la entidad

  Historia de Modificaciones
  Fecha         Autor               Modificacion
  =========   =========             ====================
  23/05/2014  acardenas.Cambio3647  Creación
  ******************************************************************/

  FUNCTION FnuGetAttribOldVal(
                              isbEntity     mo_data_change.entity_name%type,
                              isbAttrib     mo_data_change.attribute_name%type,
                              inuMotive     mo_data_change.motive_id%type,
                              isbPrimKey    mo_data_change.entity_pk%type
                              )
  RETURN    NUMBER
  IS
    nuAttrOldVal     mo_data_change.entity_attr_old_val%type;
  BEGIN

    ut_trace.Trace('INICIO LD_BCGASSUBSCRIPTION.FnuGetAttribOldVal', 10);

    SELECT  /*+ index(IDX_MO_DATA_CHANGE01)*/
            entity_attr_old_val
    INTO    nuAttrOldVal
    FROM    mo_data_change
    WHERE   motive_id = inumotive
            AND entity_name = isbEntity
            AND attribute_name = isbAttrib
            AND entity_pk = isbPrimKey;

    ut_trace.Trace('FIN LD_BCGASSUBSCRIPTION.FnuGetAttribOldVal', 10);

    return nuAttrOldVal;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END FnuGetAttribOldVal;

end LD_BCGASSUBSCRIPTION;
/
PROMPT Otorgando permisos de ejecucion a LD_BCGASSUBSCRIPTION
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BCGASSUBSCRIPTION', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LD_BCGASSUBSCRIPTION para reportes
GRANT EXECUTE ON adm_person.LD_BCGASSUBSCRIPTION TO rexereportes;
/
