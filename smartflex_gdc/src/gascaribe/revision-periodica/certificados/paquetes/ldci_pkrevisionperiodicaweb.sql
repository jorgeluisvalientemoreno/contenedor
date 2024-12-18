CREATE OR REPLACE PACKAGE ldci_pkrevisionperiodicaweb AS
  sbsqlcertificate           VARCHAR2(10000);
  sbsqlcertificatesf         VARCHAR2(10000);
  sbsqlcertificateoia        VARCHAR2(10000);
  sbcertificateattributes    VARCHAR2(4000);
  sbcertificatesfattributes  VARCHAR2(4000);
  sbcertificateoiaattributes VARCHAR2(4000);
  
  gnuErr                     NUMBER;
  gsbErr                     VARCHAR2(4000);
  
  /* -------------------------------------------------------------------------------------------------------------------
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKREVISIONPERIODICAWEB
     AUTOR      : Emiro Leyva Hernandez
     FECHA      : 08/04/2014
     DESCRIPCION: Paquete que permite la integracion de la pagina web y smarflex en el tema de revision periodica certificadas por OIA
     Historia de Modificaciones
     Autor     Fecha       Descripcion
     SLEMUS    30/05/2015  SAO 312076 - Parametrizar el mensaje del certificado OIA, se parametriza la informacion
                           del mensaje de aceptacion y del mensaje de rechazo.
     eaguera   17/04/2018  PROREGISTERNEWCERTIRP: Caso 200-1572 Reorganizacion de codigo para la asignacion de orden a unidad operativa.
                           Se coloca en comentarios valicion de que exista la unidad operativa. Ahora se manda codigo OIA.
                           Se asigna tipo de inspeccion voluntaria (2) si la funcion ldc_getEdadRP < 54
     eaguera   08/05/2018  fnuGetProdActiveByContract: Se cambia parametro VENTAS_COTIZADAS_OIA por COD_VENTAS_COTIZADAS_OIA.
     eaguera   08/05/2018  fnuGetProdRedContract: Se cambia parametro VENTAS_COTIZADAS_OIA por COD_VENTAS_COTIZADAS_OIA.
   jdonado   17/08/2018  proRegisterNewCertiRP: Se corrige inconveniente de aprobaci?n de certificado cuyo tipo de inspecci?n es 4
   hjmorales  26/09/2018  200-2146 JOB_SUSPENSION_XNO_CERT:Se modifica cursor cuNotifica y cuSuspender para agregar condici?n de categoria de producto
     fsierra 03/04/2020 1- GLPI 20 Se quita el comentario a la instruccion de codigo donde se habia dejado la seccion que valida la relacion de la unidad de trabajo con el orgenismo de inspeccion.
                        Esto habia sido colocado en comentario por el incidente 300-27257.
                        2- GLPI 20 Se modifica segmento de codigo del procedimiento proRegisterNewCertiRP que cambia estado de orden a ejecutada.
     josdon  15/05/2020  GLPI 102 Se modifica procedimiento proRegisterNewCertiRP para agregar la l?gica del resultado de inspecci?n 5-Con defectos no cr?ticos y sin artefactos a gas
     OL-Software     26/07/2020  Caso 404 - Se ajusta el proceso al momento de actualizar la marca del producto, a fin de que valide con el parametro TIPOINSACTMARCA
     OL-Software     17/01/2020  Caso 540 - Se agrega validacion que permite determinar si el contratista es externo y la orden viene con un valor definido.
	                                        Se corrige el procedimiento al momento en que se crea al técnico que está registrando el certificado en OSF. Al no existir el programa lo crea.
	Horbath       25/02/2021    CASO 409 - Adicionar la nueva variable sbOrder a la consulta dinamica   
										   Adicionar subconsulta de la vaeriable sbResultadoInspeccion para obtener 
										   la descripcion de la nueva forma LDCRESINSPEC
    Horbath      25-09-2021     CA667:  Se modifica FillCertificateAttributes
    jpinedc      25-08-2023     OSF-1393: Se borran JOB_SUSPENSION_XNO_CERT y PROLEGALIZO 
  *-----------------------------------------------------------------------------------------------0-----------------------*/

  PROCEDURE proregisternewcertirp(inucontratoid           IN ldc_certificados_oia.id_contrato%TYPE, -- codifo del contrato
                                  idtfechainspe           IN ldc_certificados_oia.fecha_inspeccion%TYPE, -- fecha de inspeccion
                                  inutipoinspec           IN ldc_certificados_oia.tipo_inspeccion%TYPE, -- tipo de inspeccion
                                  isbcertificado          IN ldc_certificados_oia.certificado%TYPE, -- numero del certificado
                                  inuorganismoid          IN ldc_certificados_oia.id_organismo_oia%TYPE, -- codigo del organismo certificador
                                  inuinspector            IN ge_person.number_id%TYPE, -- cedula del inspector
                                  isbnombre_inspector     IN ge_person.name_%TYPE, -- nombre del inspector
                                  isbcodigosic            IN VARCHAR2, -- codigo SIC
                                  idtfechavigencia        IN DATE, -- fecha de vigencia
                                  inuresultado_inspeccion IN ldc_certificados_oia.resultado_inspeccion%TYPE, -- resultado de la inspeccion
                                  isbred_individual       IN ldc_certificados_oia.red_individual%TYPE, -- flag que indica si la red es individual
                                  icuartefactos           IN CLOB, -- cursor de artefactos
                                  icudefnocritico         IN CLOB, -- defectos no criticos
                                  ISBAPROBADO             IN VARCHAR2 default null, -- se pasa parametro para logica de aprobacion
                                  iSBMatricula            IN mo_packages.document_key%TYPE, -- matricula
                                  isbUrl                  IN Varchar2 DEFAULT null, --Se agrega [CA 200-1572]
                                  inuOrderid              IN or_order.order_id%TYPE DEFAULT null, --Se agrega [CA 200-1572]
                                  inuCodigoOrganismo      IN ldc_organismos.organismo_id%TYPE DEFAULT null, --Se agrega [CA 200-1572]
								                  sbVacioInterno      	  IN ldc_certificados_oia.vaciointerno%TYPE DEFAULT null, --caso: 806
								                  dtFechaReg      		  IN ldc_certificados_oia.fecha_reg_osf%TYPE DEFAULT null, --caso: 806
                                  cumensaje               OUT SYS_REFCURSOR); -- CURSOR DE MENSAJES DE ERROR

  PROCEDURE proobtieneartefactos(inucodigo       IN NUMBER,
                                 cuappliance     OUT SYS_REFCURSOR,
                                 onuerrorcode    OUT NUMBER,
                                 osberrormessage OUT VARCHAR2);
  PROCEDURE proobtienedefectos(inucodigo       IN NUMBER,
                               cudefect        OUT SYS_REFCURSOR,
                               onuerrorcode    OUT NUMBER,
                               osberrormessage OUT VARCHAR2);

  PROCEDURE proenviastatuscerti(inuorganismoid  IN ldc_certificados_oia.id_organismo_oia%TYPE, -- codigo del organismo certificador
                                isbcertificado  IN ldc_certificados_oia.certificado%TYPE, -- numero del certificado
                                osbstatus       OUT VARCHAR2,
                                onuerrorcode    OUT NUMBER,
                                osberrormessage OUT VARCHAR2);
  FUNCTION fblexistcertificado(inuid_organismo_oia IN ldc_certificados_oia.id_organismo_oia%TYPE,
                               inucertificado      IN ldc_certificados_oia.certificado%TYPE)
  --caso 200-1189RETURN boolean;
   RETURN varchar2;

  FUNCTION fnuotaceptacioncertificado(inupackage_id IN mo_packages.package_id%TYPE,
                                      inuaddressid  IN or_order_activity.address_id%TYPE)
    RETURN NUMBER;

  /***************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Procedure   :   fnuGetProdRedMatriByContract
  Descripcion :   Permite obtener el numero del primer producto del tipo dado
                  en estado Activo dado el contrato PARA RED MATRIZ.
  Autor       :   Emiro leyva
  Fecha       :   30-04-2014
  Parametros  :
      inuSubscriptionId:    Identificador del Contrato.
      inuProductTypeId:     Identificador del Tipo de Producto.

  Retorno     : Identificador del primer producto encontrado dado el contrato
  Historia de Modificaciones
  Fecha      IDEntrega               Descripcion
  ==========  ======================= ========================================
  30-04-2014  Emirol.CASO3375        Creacion.
  ***************************************************************************/
  FUNCTION fnugetprodredmatribycontract(inusubscriptionid IN suscripc.susccodi%TYPE,
                                        inuproducttypeid  IN servicio.servcodi%TYPE DEFAULT NULL)
    RETURN pr_product.product_id%TYPE;

  /***************************************************************************
  Propiedad intelectual de Open International Systems (c).

  Procedure   :   fnuGetProdActiveByContract
  Descripcion :   Permite obtener el numero del primer producto del tipo dado
                  en estado Activo o suspendido dado el contrato. Si el tipo de producto es
                  nulo se buscan los tipos de producto 7014.

  Autor       :   Emiro leyva
  Fecha       :   30-04-2014
  Parametros  :
      inuSubscriptionId:    Identificador del Contrato.
      inuProductTypeId:     Identificador del Tipo de Producto.

  Retorno     : Identificador del primer producto encontrado dado el contrato

  Historia de Modificaciones
  Fecha      IDEntrega               Descripcion
  ==========  ======================= ========================================
  30-04-2014  Emirol.CASO3375        Creacion.
  ***************************************************************************/

  FUNCTION fnugetprodactivebycontract(inusubscriptionid IN suscripc.susccodi%TYPE,
                                      inuproducttypeid  IN servicio.servcodi%TYPE DEFAULT NULL)
    RETURN pr_product.product_id%TYPE;

  /*******************************************************************************
   Metodo: GetCertificateSFByCertificate
   Descripcion:   Obtiene todos los Certificados de SF que tiene un Certificado
                  Este es Hijo del Padre
   Autor: LLOZADA
   Fecha: 12/04/2014
   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/
  PROCEDURE getcertificatesfbycertificate(inucertificate IN ldc_plazos_cert.plazos_cert_id%TYPE,
                                          ocucursor      OUT constants.tyrefcursor);

  /*******************************************************************************
   Metodo: GetCertificateByCertificateSF
   Descripcion:   Obtiene el Certificado a partir del Certificado del hijo
                  Esto es Padre de Hijo Certificate SF
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/
  PROCEDURE getcertificatebycertificatesf(inucertificatesf_id IN NUMBER,
                                          onucertificate      OUT NUMBER);

  /*******************************************************************************
   Metodo: GetCertificateByCertificateOIA
   Descripcion:   Obtiene el Certificado a partir del Certificado del hijo
                  Esto es Padre de Hijo Certificate SF
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/
  PROCEDURE getcertificatebycertificateoia(inucertificateoia_id IN NUMBER,
                                           onucertificate       OUT NUMBER);

  /*******************************************************************************
   Metodo: GetCertificateOIAByCertificate
   Descripcion:   Obtiene todos los Certificados de SF que tiene un Certificado
                  Este es Hijo del Padre
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/
  PROCEDURE getcertificateoiabycertificate(inucertificate IN ldc_plazos_cert.plazos_cert_id%TYPE,
                                           ocucursor      OUT constants.tyrefcursor);

  /*******************************************************************************
   Metodo: GetCertificateSF
   Descripcion:   Obtiene todos los datos de un Certficado de SF a partir de un codigo
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/
  PROCEDURE getcertificatesf(inucertificatesf IN pr_certificate.certificate_id%TYPE,
                             ocucursor        OUT constants.tyrefcursor);

  /*******************************************************************************
   Metodo: FillCertificateSFAttributes
   Descripcion:   Obtiene todos los datos a mostrar para un Certificado
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/
  PROCEDURE fillcertifcatesfattributes;

  /***************************************************************************
   Metodo: getAssociates
   Descripcion:   Metodo de busqueda para los asociados
  ***************************************************************************/
  PROCEDURE getcertificates(isbidcontrato IN ldc_plazos_cert.id_contrato%TYPE,
                            isbidproducto IN ldc_plazos_cert.id_producto%TYPE,
                            ocucursor     OUT constants.tyrefcursor);

  /***************************************************************************
  Metodo: FillAssociateAttributes
  Descripcion:   Retorna los atributos de un Asociado
  ***************************************************************************/
  PROCEDURE fillcertificateattributes;

  /***************************************************************************
   Metodo: GetAssociate
   Descripcion:   Retorna los atributos de un Asociado
  ***************************************************************************/
  PROCEDURE getcertifcate(inucertificate IN ldc_plazos_cert.plazos_cert_id%TYPE,
                          ocucursor      OUT constants.tyrefcursor);

  /*******************************************************************************
   Metodo: GetCertificateOIA
   Descripcion:   Obtiene todos los datos de un Certficado OIA a partir de un codigo
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/
  PROCEDURE getcertificateoia(inucertificateoiaid IN ldc_certificados_oia.certificados_oia_id%TYPE,
                              ocucursor           OUT constants.tyrefcursor);

  /*******************************************************************************
   Metodo: FillCertOIAAttributes
   Descripcion:   Obtiene todos los datos a mostrar para un Certificado
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/
  PROCEDURE fillcertoiaattributes;

  /***************************************************************************
  PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

   PROCEDIMIENTO : PROUPDOBSTATUSCERTOIA
   AUTOR : EMIRO LEYVA HERNANDEZ
   FECHA : 08/04/2014
   DESCRIPCION : Procedimiento para actualizar el esta del certificado resultado de la validacion de autenticidad del
                 certificado, tambien envia correo el OIA si tiene e_mail configurado en la unidad operativa

     Parametros de Entrada

     Parametros de Salida

  Historia de Modificaciones

  Autor        Fecha       Descripcion.
  ***************************************************************************/

  PROCEDURE proupdobstatuscertoia;
  /*******************************************************************************
   Metodo: GetCertificatesOIA
   Descripcion:   Obtiene todos los CertificadosOIA que cumplan con los criterios de
                  seleccion indicados por el usuario
   Autor: LLOZADA
   Fecha: Junio 12/2008

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   14-04-2014     LLOZADA - Creaci?n

  *******************************************************************************/
  PROCEDURE getcertificatesoia(isbcertificado IN ldc_certificados_oia.certificado%TYPE,
                               isbestado      IN ldc_certificados_oia.status_certificado%TYPE,
                               isbunidad      IN ldc_certificados_oia.id_organismo_oia%TYPE,
                               ocucursor      OUT constants.tyrefcursor);

  PROCEDURE loadproductinformation(inuidcertificadosoia IN ldc_certificados_oia.certificados_oia_id%TYPE,
                                   iblincludedwarning   IN BOOLEAN DEFAULT TRUE);

  /*******************************************************************************
   Metodo: fnuValiVisualTramite
   Descripcion:   Valida la visualizacion del tramite 100235 si el producto esta suspendido
                  con tipo de suspension 104 vigente y no tiene un certificado de OIA
                  vigente.
   Autor: Emiro Leyva
   Fecha: Abril 23/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12-04-2014     EMIROL - Creaci?n

  *******************************************************************************/
  FUNCTION fnuvalivisualtramite(inuproduct_id IN pr_product.product_id%TYPE)
    RETURN NUMBER;

  FUNCTION fnugetsolisuspetypepriori(inuproductoid IN servsusc.sesunuse%TYPE)
    RETURN mo_motive.package_id%TYPE;
  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_REGISTRVISIIDENCERTIXOTREV
  Descripcion    : GENERA TRAMITE DE VISITA DE IDENTIFICACION DE CERTIFICADO POR XML DESDE EL OTROV
  Autor          : Emiro Leyva H.
  Fecha          : 08/06/2014

  Parametros              Descripcion
  ============         ===================
  nuExternalId:


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE ldc_registrvisiidencertixotrev(inuproduct_id pr_product.product_id%TYPE);

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : OBJ_LEG_VISIIDENCERTI
  Descripcion    : OBJETO PARA LEGALIZAR LA ACTIVIDAD DE VISITA DE IDENTIFICACION DE CERTIFICADO
  Autor          : Emiro Leyva H.
  Fecha          : 08/05/2014

  Parametros              Descripcion
  ============         ===================
  nuExternalId:
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
   08/05/2014       EMIROL              CREACION
  ******************************************************************/
  PROCEDURE obj_leg_visiidencerti;

  FUNCTION fnuprodaplicagenenotif(inuproduct_id pr_product.product_id%TYPE)
    RETURN NUMBER;
  FUNCTION fnugetlocalidadesase(inugeograp_location_id ldc_equiva_localidad.geograp_location_id%TYPE)
    RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : OBJ_LEG_NOTIF_SUSP
  Descripcion    : OBJETO PARA LEGALIZAR LA NOTIFICACION DE SUSPENSION POR AUSENCIA DE CERTIFICADO
  Autor          : Emiro Leyva H.
  Fecha          : 08/05/2014

  Parametros              Descripcion
  ============         ===================
  nuExternalId:


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
   08/05/2014       EMIROL              CREACION
  ******************************************************************/
  PROCEDURE prosuspcomponente(inuproduct_id IN pr_product.product_id%TYPE,
                              inususptypeid IN pr_comp_suspension.suspension_type_id%TYPE);
  PROCEDURE obj_leg_notif_susp;
  PROCEDURE obj_leg_genera_rp;
  PROCEDURE obj_leg_causal_3341_rp;
  PROCEDURE proatiendesusprp_plugi;
  PROCEDURE obj_leg_registercertificate;
  /*****************************************************************
    Propiedad intelectual de PETI (c).
    Unidad         : prFinanceOtCerti
    Descripcion    : Procedimiento donde se implementa la logica para financiar actividades
                     durante la legalizacion de la orden de certificacion (PLUGIN).
    Autor          : Emiro leyva
    Fecha          : 10/06/2014

    Metodos
    Nombre         :
    Parametros         Descripcion
    ============  ===================
    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

  PROCEDURE prfinanceotcerti;
  FUNCTION fnutiposuspension(inuproduct_id IN pr_product.product_id%TYPE)
    RETURN NUMBER;
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuTipoSuspension
    Descripcion    : funcion que busca el tipo de funcion de la tabla ldc_marca_producto
                     si no existe el registro devuelve 101, se usa en una lista de valor
                     para la legalizacion de la orden de suspension.acion (PLUGIN).
    Autor          : Emiro leyva
    Fecha          : 02/07/2014

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
  PROCEDURE prsuspprodwithoutcertificate(inuproductid IN pr_product.product_id%TYPE);

  PROCEDURE prgenmarcaprodbycerti;
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fblIsProductCertified
    Descripcion    : funcion que busca si el producto esta certificado
    Autor          : Emiro leyva
    Fecha          : 06/08/2014

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
  FUNCTION fsbisproductcertified(inuproduct_id IN pr_product.product_id%TYPE)
    RETURN VARCHAR2;
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : prValidate10500
    Descripcion    : Procedimiento para validar la ejecuci?n o legalizaci?n de instalaciones de
                     interna o cargos por conexi?n en tr?mite de ventas antes de legalizar
                     la visita de aceptaci?n de certificado 10500.
    Autor          : Sayra Ocor?
    Fecha          : 01/09/2014

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
  PROCEDURE prvalidate10500;

  FUNCTION fnugetotultimarp
  /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : fnuGetOtUltimaRP
    Descripcion    : Busca la ultima orden de revision periodica
    Autor          : Emiro Leyva H.
    Fecha          : 23/10/2014

    Parametros              Descripcion
    ============         ===================
    nuExternalId:


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================

    ******************************************************************/

  (inuproductid IN pr_product.product_id%TYPE) RETURN or_order.order_id%TYPE;
  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : prLevantaTipoSuspen
   Descripcion    : Procedimiento donde se implementa la logica para levantar en la reconexion las
                    suspensiones de revision periodica cuando la reconexion no se realiza x el mismo
                    tipo de suspension que se suspensio (DEFINIR EN FMIO).
   Autor          : Emiro leyva
   Fecha          : 20/10/2014

   Metodos

   Nombre         :
   Parametros         Descripcion
   ============  ===================


   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========         =========         ====================
  ******************************************************************/

  PROCEDURE prlevantatiposuspen;
  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fsbIsNotifPlazos
   Descripcion    : funcion para buscar en las reglas de orcor si el producto se
                    notifica por vencimiento o por reparacion enviendo el producto
   Autor          : Emiro leyva
   Fecha          : 20/10/2014

   Metodos

   Nombre         :
   Parametros         Descripcion
   ============  ===================


   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========         =========         ====================
  ******************************************************************/

  FUNCTION fsbisnotifplazos(inuproduct_id IN pr_product.product_id%TYPE)
    RETURN VARCHAR2;

  FUNCTION fsbAplicaEntrega(isbEntrega VARCHAR2) RETURN CHAR;

  FUNCTION fnususpendedproduct(inuproduct pr_product.product_id%TYPE,
                               isbtypett  VARCHAR2) RETURN NUMBER;

  FUNCTION fnuGetProdRedContract(inuSubscriptionId IN suscripc.susccodi%TYPE,
                                 inuProductTypeId  IN servicio.servcodi%type default null)
    RETURN pr_product.product_id%TYPE;

END ldci_pkrevisionperiodicaweb;
/

CREATE OR REPLACE PACKAGE BODY LDCI_PKREVISIONPERIODICAWEB AS

    -- Constantes para el control de la traza
    csbSP_NAME                 CONSTANT VARCHAR2(100)         := 'LDCI_PKREVISIONPERIODICAWEB.';
    cnuNVLTRC                  CONSTANT NUMBER                := 5;

  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKREVISIONPERIODICAWEB
     AUTOR      : Emiro Leyva Hernandez
     FECHA      : 08/04/2014
     DESCRIPCION: Paquete que permite la integracion de la pagina web y smarflex en el tema de revision periodica certificadas por OIA

    Historia de Modificaciones
    Autor        Fecha            Descripcion
    Sandra Muñoz 05-09-2015       Se modifica el procedimiento fnuOtAceptacionCertificado
    SLEMUS       30/05/2015       2. SAO 312076
                                  Parametrizar el mensaje del certificado OIA, se parametriza la informacion
                                  del mensaje de aceptacion y del mensaje de rechazo.
  hjmorales  26/09/2018  200-2146 JOB_SUSPENSION_XNO_CERT:Se modifica cursor cuNotifica y cuSuspender para agregar condición de categoria de producto
  OL-Software     26/07/2020  Caso 404 - Se ajusta el proceso al momento de actualizar la marca del producto, a fin de que valide con el parametro TIPOINSACTMARCA
  Horbath      25-09-2021     CA667:  Se modifica FillCertificateAttributes
  */
  FUNCTION fnuGetProdRedContract(inuSubscriptionId IN suscripc.susccodi%TYPE,
                                 inuProductTypeId  IN servicio.servcodi%type default null)
    RETURN pr_product.product_id%TYPE IS
    /*-------------------------------------------------------------------------------------------
      Historia de Modificaciones
      Autor           Fecha            Descripcion
      Eduardo Aguera  22-11-2017       Caso 200-1324 Se modifica cursor cuProdActiveByContract para colocar
                                       los estados por parametro.
      Eduardo Aguera  08/05/2018       Se cambia parametro VENTAS_COTIZADAS_OIA por COD_VENTAS_COTIZADAS_OIA.
    --------------------------------------------------------------------------------------------*/
    CURSOR cuProdActiveByContract(nuSubscriptionId suscripc.susccodi%type,
                                  nuProductTypeId  servicio.servcodi%type) IS
      SELECT /*+ index(se IX_SERVSUSC12) */
      DISTINCT p.*
        FROM pr_product p, servsusc se
       WHERE se.sesususc = p.subscription_id
         AND p.product_status_id IN (SELECT COLUMN_VALUE FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_VENTAS_COTIZADAS_OIA',NULL),',')))
         AND p.subscription_id = nuSubscriptionId
         AND p.product_type_id =
             NVL(nuProductTypeId, LD_BOConstans.cnuGasService)
         AND se.sesunuse = p.product_id
         AND se.sesuserv = p.product_type_id
         AND (se.sesufere is null OR se.sesufere > sysdate)
         AND rownum = 1;

    rcProduct cuProdActiveByContract%ROWTYPE;

    PROCEDURE CloseCursor IS
    BEGIN
      IF (cuProdActiveByContract%ISOPEN) THEN
        CLOSE cuProdActiveByContract;
      END IF;
    END CloseCursor;

  BEGIN
    UT_Trace.Trace('Inicia '|| csbSP_NAME || 'fnuGetProdRedMatriByContract', cnuNVLTRC );
    UT_Trace.Trace('[' || inuSubscriptionId || '][' || inuProductTypeId || ']', cnuNVLTRC);
    CloseCursor;

    /*Validacion de existencia del cliente*/
    IF (pktblsuscripc.fblexist(inuSubscriptionId)) THEN
      OPEN cuProdActiveByContract(inuSubscriptionId, inuProductTypeId);
      FETCH cuProdActiveByContract
        INTO rcProduct;
      CloseCursor;
    END IF;

    UT_Trace.Trace('Primer Producto Activo de red matriz del Contrato ' ||
                   rcProduct.product_id,
                   cnuNVLTRC);
    UT_Trace.Trace('Termina '|| csbSP_NAME || 'fnuGetProdRedMatriByContract', cnuNVLTRC);
    RETURN rcProduct.product_id;
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      CloseCursor;
      RAISE pkg_Error.Controlled_Error;
    WHEN others THEN
      CloseCursor;
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END fnuGetProdRedContract;

  FUNCTION fnuGetLocalidadesASE(inugeograp_location_id ldc_equiva_localidad.geograp_location_id%TYPE)
    RETURN NUMBER IS
    /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : fnuGetLocalidadesASE
    Descripcion    : busca si la localidad es de area exclusiva ASE
    Autor          : Emiro Leyva H.
    Fecha          : 14/05/2014

    Parametros              Descripcion
    ============         ===================
    nuExternalId:


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
     08/05/2014       EMIROL              CREACION
    ******************************************************************/

    CURSOR cuAreaExclusiva(nuLoca ldc_equiva_localidad.geograp_location_id%TYPE) IS
      SELECT 1
        FROM ldc_equiva_localidad
       WHERE geograp_location_id = nuLoca
         AND servicioexclu = 'S';

    nuASE   NUMBER;
    SBFECHA LD_PARAMETER.VALUE_CHAIN%TYPE;
    dffecha DATE;
  BEGIN
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'fnuGetLocalidadesASE', cnuNVLTRC);
    
    SBFECHA := Dald_parameter.fsbGetValue_Chain('FECHA_VIG_ASE', NULL);
    IF SBFECHA IS NULL THEN
      pkg_error.setErrorMessage( isbMsgErrr => 
                                       'No existe datos para el parametro FECHA_VIG_ASE, definalos por el comando LDPAR');
    END IF;
    dffecha := to_date(SBFECHA, 'DD/MM/YYYY');
    nuAse   := 0;
    IF trunc(SYSDATE) <= TRUNC(dffecha) THEN
      OPEN cuAreaExclusiva(inugeograp_location_id);
      FETCH cuAreaExclusiva
        INTO nuASE;
      IF cuAreaExclusiva%NOTFOUND THEN
        nuAse := 0;
      END IF;
      CLOSE cuAreaExclusiva;
    END IF;
    UT_Trace.Trace('Termina ' || csbSP_NAME || 'fnuGetLocalidadesASE', cnuNVLTRC);
    RETURN(nuAse);
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.SetError;
      RETURN(0);
    WHEN no_data_found THEN
      RETURN(0);
  END fnuGetLocalidadesASE;

  FUNCTION fnuGetProdRedMatriByContract(inuSubscriptionId IN suscripc.susccodi%TYPE,
                                        inuProductTypeId  IN servicio.servcodi%TYPE DEFAULT NULL)
    RETURN pr_product.product_id%TYPE IS
    CURSOR cuProdActiveByContract(nuSubscriptionId suscripc.susccodi%TYPE,
                                  nuProductTypeId  servicio.servcodi%TYPE) IS
      SELECT /*+ index(se IX_SERVSUSC12) */
      DISTINCT p.*
        FROM pr_product p, ps_product_status ps, servsusc se
       WHERE se.sesususc = p.subscription_id
         AND p.product_status_id = ps.product_status_id
         AND p.subscription_id = nuSubscriptionId
         AND p.product_type_id =
             NVL(nuProductTypeId, LD_BOConstans.cnuGasService)
         AND se.sesunuse = p.product_id
         AND se.sesuserv = p.product_type_id
         AND (se.sesufere IS NULL OR se.sesufere > SYSDATE)
         AND ps.is_active_product = ge_boconstants.csbYES
         AND ps.is_final_status = ge_boconstants.csbYES
         AND 0 =
             (SELECT COUNT(1) FROM elmesesu el WHERE EMSSSESU = p.product_id)
         AND rownum = 1;

    rcProduct cuProdActiveByContract%ROWTYPE;

    PROCEDURE CloseCursor IS
    BEGIN
      IF (cuProdActiveByContract%ISOPEN) THEN
        CLOSE cuProdActiveByContract;
      END IF;
    END CloseCursor;
  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'fnuGetProdRedMatriByContract', cnuNVLTRC);  
    UT_Trace.Trace('[' ||inuSubscriptionId || '][' || inuProductTypeId || ']', cnuNVLTRC);
    CloseCursor;

    /*Validacion de existencia del cliente*/
    IF (pktblsuscripc.fblexist(inuSubscriptionId)) THEN
      OPEN cuProdActiveByContract(inuSubscriptionId, inuProductTypeId);
      FETCH cuProdActiveByContract
        INTO rcProduct;
      CloseCursor;
    END IF;

    UT_Trace.Trace('Primer Producto Activo de red matriz del Contrato ' ||
                   rcProduct.product_id,
                   cnuNVLTRC);
                   
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'fnuGetProdRedMatriByContract', cnuNVLTRC);                    
    RETURN rcProduct.product_id;
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      CloseCursor;
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      CloseCursor;
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END fnuGetProdRedMatriByContract;
  /***************************************************************************************************************
  Propiedad intelectual de Open International Systems (c).

  Procedure   :   fnuGetProdActiveByContract
  Descripcion :   Permite obtener el numero del primer producto del tipo dado
                  en estado Activo o suspendido dado el contrato. Si el tipo de producto es
                  nulo se buscan los tipos de producto 7014.

  Autor       :   Emiro leyva
  Fecha       :   30-04-2014
  Parametros  :
      inuSubscriptionId:    Identificador del Contrato.
      inuProductTypeId:     Identificador del Tipo de Producto.

  Retorno     : Identificador del primer producto encontrado dado el contrato

  Historia de Modificaciones
  Fecha      IDEntrega               Descripcion
  ==========  ======================= ========================================
  30-04-2014  Emirol.CASO3375        Creacion.
  22-11-2017  Eduardo Aguera         Caso 200-1324 Se modifica cursor fnuGetProdActiveByContract para colocar
                                     los estados por parametro.
  08/05/2018  Eduardo Aguera         Se cambia parametro VENTAS_COTIZADAS_OIA por COD_VENTAS_COTIZADAS_OIA.
  **************************************************************************************************************/
  FUNCTION fnuGetProdActiveByContract(inuSubscriptionId IN suscripc.susccodi%TYPE,
                                      inuProductTypeId  IN servicio.servcodi%TYPE DEFAULT NULL)
    RETURN pr_product.product_id%TYPE IS
    CURSOR cuProdActiveByContract(nuSubscriptionId suscripc.susccodi%TYPE,
                                  nuProductTypeId  servicio.servcodi%TYPE) IS
      SELECT /*+ index(se IX_SERVSUSC12) */
      DISTINCT p.*
        FROM pr_product p, servsusc se
       WHERE se.sesususc = p.subscription_id
         AND p.subscription_id = nuSubscriptionId
         AND p.product_status_id IN (SELECT COLUMN_VALUE FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_VENTAS_COTIZADAS_OIA',NULL),',')))
         AND p.product_type_id = NVL(nuProductTypeId, LD_BOConstans.cnuGasService)
         AND se.sesunuse = p.product_id
         AND se.sesuserv = p.product_type_id
         AND (se.sesufere IS NULL OR se.sesufere > SYSDATE)
         AND rownum = 1;

    rcProduct cuProdActiveByContract%ROWTYPE;

    PROCEDURE CloseCursor IS
    BEGIN
      IF (cuProdActiveByContract%ISOPEN) THEN
        CLOSE cuProdActiveByContract;
      END IF;
    END CloseCursor;

  BEGIN
        
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'fnuGetProdActiveByContract', cnuNVLTRC);   
    UT_Trace.Trace('['||inuSubscriptionId||']['||inuProductTypeId||']', cnuNVLTRC);
    CloseCursor;

    /*Validacion de existencia del cliente*/
    IF (pktblsuscripc.fblexist(inuSubscriptionId)) THEN
      OPEN cuProdActiveByContract(inuSubscriptionId, inuProductTypeId);
      FETCH cuProdActiveByContract
        INTO rcProduct;
      CloseCursor;
    END IF;

    UT_Trace.Trace('Primer Producto Activo del Contrato '||rcProduct.product_id, cnuNVLTRC);
    UT_Trace.Trace('Termina ' || csbSP_NAME || 'fnuGetProdActiveByContract', cnuNVLTRC);     
    
    RETURN rcProduct.product_id;
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      CloseCursor;
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      CloseCursor;
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END fnuGetProdActiveByContract;

  FUNCTION fnuGetSoliSuspetypePriori(inuProductoId IN servsusc.sesunuse%TYPE)
    RETURN mo_motive.package_id%TYPE IS
    CURSOR cuSoliSuspe(nuProductoId servsusc.sesunuse%TYPE) IS
      SELECT MAX(m.package_id)
        FROM mo_motive m, mo_suspension s
       WHERE m.product_id = nuProductoId
         AND m.motive_id = s.motive_id
         AND s.suspension_type_id = 104
         AND m.motive_status_id IN (1, 11);

    nuPackageId mo_motive.package_id%TYPE;
    PROCEDURE CloseCursor IS
    BEGIN
      IF (cuSoliSuspe%ISOPEN) THEN
        CLOSE cuSoliSuspe;
      END IF;
    END CloseCursor;

  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'fnuGetSoliSuspetypePriori', cnuNVLTRC); 

    CloseCursor;

    /*Validacion de existencia del producto*/
    IF (DAPR_PRODUCT.FBLEXIST(inuProductoId)) THEN
      OPEN cuSoliSuspe(inuProductoId);
      FETCH cuSoliSuspe
        INTO nuPackageId;
      CloseCursor;
    END IF;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'fnuGetSoliSuspetypePriori', cnuNVLTRC); 
    
    RETURN nuPackageId;
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      CloseCursor;
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      CloseCursor;
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END fnuGetSoliSuspetypePriori;

  FUNCTION fblExistCertificado(inuID_ORGANISMO_OIA IN LDC_CERTIFICADOS_OIA.ID_ORGANISMO_OIA%TYPE,
                               inuCERTIFICADO      IN LDC_CERTIFICADOS_OIA.CERTIFICADO%TYPE)
    RETURN varchar2 IS

    CURSOR cuRecord(inuID_ORGANISMO IN LDC_CERTIFICADOS_OIA.ID_ORGANISMO_OIA%TYPE,
                    inuCERTIFI      IN LDC_CERTIFICADOS_OIA.CERTIFICADO%TYPE) IS
      SELECT LDC_CERTIFICADOS_OIA.*, LDC_CERTIFICADOS_OIA.rowid
        FROM LDC_CERTIFICADOS_OIA
       WHERE ID_ORGANISMO_OIA = inuID_ORGANISMO
         AND CERTIFICADO = inuCERTIFI
         AND STATUS_CERTIFICADO IN ('I', 'A');

    rcData       cuRecord%ROWTYPE;
    rcRecordNull cuRecord%ROWTYPE;

    sbDatoCert varchar2(3200) := null;

  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'fblExistCertificado', cnuNVLTRC); 
            
    sbDatoCert := null;

    IF cuRecord%ISOPEN THEN
      CLOSE cuRecord;
    END IF;
    OPEN cuRecord(inuID_ORGANISMO_OIA, inuCERTIFICADO);

    FETCH cuRecord
      INTO rcData;
    sbDatoCert := sbDatoCert || rcData.Certificado || ' Contrato: ' ||
                  rcData.Id_Contrato;
    IF cuRecord%NOTFOUND THEN
      CLOSE cuRecord;
      rcData := rcRecordNull;
      RAISE no_data_found;
    END IF;
    CLOSE cuRecord;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'fblExistCertificado', cnuNVLTRC); 
    
    return sbDatoCert;

  EXCEPTION
    WHEN no_data_found THEN
      sbDatoCert := null;
      return sbDatoCert;
  END fblExistCertificado;

  PROCEDURE PROOBTIENEARTEFACTOS(inuCodigo       IN NUMBER,
                                 CUAPPLIANCE     OUT SYS_REFCURSOR,
                                 onuErrorCode    OUT NUMBER,
                                 osbErrorMessage OUT VARCHAR2) AS

  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'PROOBTIENEARTEFACTOS', cnuNVLTRC); 
    
    --consultando los datos de la tabla de artefactos
    OPEN CUAPPLIANCE FOR
      SELECT APPLIANCE_ID CODIGO, DESCRIPTION DESCRIPCION
        FROM GE_APPLIANCE;
    onuErrorCode    := 0;
    osbErrorMessage := 'Consulta exitosa ';
    
    UT_Trace.Trace('Termina ' || csbSP_NAME || 'PROOBTIENEARTEFACTOS', cnuNVLTRC); 
    

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(onuErrorCode, osbErrorMessage);
    WHEN OTHERS THEN
      osbErrorMessage := 'Error consultando los artefactos: ' ||
                         DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      pkg_Error.SetError;
      pkg_Error.getError(onuErrorCode, osbErrorMessage);
  END PROOBTIENEARTEFACTOS;

  PROCEDURE PROOBTIENEDEFECTOS(inuCodigo       IN NUMBER,
                               CUDEFECT        OUT SYS_REFCURSOR,
                               onuErrorCode    OUT NUMBER,
                               osbErrorMessage OUT VARCHAR2) AS

  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'PROOBTIENEDEFECTOS', cnuNVLTRC); 
    
    --consultando los datos de la tabla de ge_defect
    OPEN CUDEFECT FOR
      SELECT DEFECT_ID CODIGO, DESCRIPTION DESCRIPCION
        FROM ge_defect
       WHERE is_critical = 'N'
         AND DEFECT_ID NOT IN
             (SELECT TO_NUMBER(COLUMN_VALUE)
                FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('COD_DEFECTOS_NO_OIA',
                                                                                         NULL),
                                                        ',')));
    onuErrorCode    := 0;
    osbErrorMessage := 'Consulta exitosa ';

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'PROOBTIENEDEFECTOS', cnuNVLTRC); 
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(onuErrorCode, osbErrorMessage);
    WHEN OTHERS THEN
      osbErrorMessage := 'Error consultando los defectos no criticos: ' ||
                         DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      pkg_Error.SetError;
      pkg_Error.getError(onuErrorCode, osbErrorMessage);

  END PROOBTIENEDEFECTOS;

  PROCEDURE PROENVIASTATUSCERTI(inuOrganismoId  IN LDC_CERTIFICADOS_OIA.ID_ORGANISMO_OIA%TYPE, -- codigo del organismo certificador
                                isbCertificado  IN LDC_CERTIFICADOS_OIA.CERTIFICADO%TYPE, -- numero del certificado
                                osbstatus       OUT VARCHAR2,
                                onuErrorCode    OUT NUMBER,
                                osbErrorMessage OUT VARCHAR2) AS
    /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

      PROCEDIMIENTO : PROENVIASTATUSCERTI
      AUTOR : EMIRO LEYVA HERNANDEZ
      FECHA : 14/05/2014

      DESCRIPCION : Procedimiento api que debe consumir el portal web
                    el cual devuelve el estado de la certificacion


        Parametros de Entrada

        Parametros de Salida

     Historia de Modificaciones

     Autor        Fecha       Descripcion.
    */

    CURSOR cuStatus(inuID_ORGANISMO IN LDC_CERTIFICADOS_OIA.ID_ORGANISMO_OIA%TYPE,
                    inuCERTIFI      IN LDC_CERTIFICADOS_OIA.CERTIFICADO%TYPE) IS
      SELECT LDC_CERTIFICADOS_OIA.*, LDC_CERTIFICADOS_OIA.rowid
        FROM LDC_CERTIFICADOS_OIA
       WHERE ID_ORGANISMO_OIA = inuID_ORGANISMO
         AND CERTIFICADO = inuCERTIFI;

    rcData cuStatus%ROWTYPE;
  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'PROENVIASTATUSCERTI', cnuNVLTRC);   
  
    IF cuStatus%ISOPEN THEN
      CLOSE cuStatus;
    END IF;
    OPEN cuStatus(inuOrganismoId, isbCertificado);

    FETCH cuStatus
      INTO rcData;
    IF cuStatus%NOTFOUND THEN
      CLOSE cuStatus;
      osbstatus := NULL;
      RAISE pkg_Error.Controlled_Error;
    END IF;
    CLOSE cuStatus;
    osbstatus       := rcData.STATUS_CERTIFICADO;
    onuErrorCode    := 0;
    osbErrorMessage := 'Consulta exitosa';

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'PROENVIASTATUSCERTI', cnuNVLTRC);   
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      osbstatus       := NULL;
      onuErrorCode    := -1;
      osbErrorMessage := 'Registro no existe';
    WHEN OTHERS THEN
      osbstatus       := NULL;
      osbErrorMessage := 'Error consultando: ' ||
                         DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      pkg_Error.SetError;
      pkg_Error.getError(onuErrorCode, osbErrorMessage);
  END PROENVIASTATUSCERTI;

  ------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE proAsignaOrdenOIA(inuOrder           in or_order.order_id%type,
                              inuContratistaOIA  in ge_contratista.id_contratista%type,
                              inuTask_type_id    in or_task_type.task_type_id%type,
                              onuCodigoError     in out number,
                              osbMensaje         in out varchar2)
   /*-------------------------------------------------------------------------------------------------------------------
    PROCEDIMIENTO : proRegisterNewCertiRP
    AUTOR : Eduardo Aguera
    FECHA : 17/04/2018
    DESCRIPCION : Asigna orden de trabajo a la unidad operativa de un organismo de inspeccion
    Historia de Modificaciones
    Autor        Fecha       Descripcion.

   -------------------------------------------------------------------------------------------------------------------*/
    AS

    nuUnidadContratistaOIA    or_operating_unit.operating_unit_id%type;
    nuCantUnidOia             NUMBER := 0;
    exValidacion              exception;

    -- Cursor para validar cuantas unidades tiene el contratista OIA
    CURSOR cuCantUnidOia(inuContratista  ldc_organismos.contratista_id%TYPE,
                         inuTask_type_id or_task_type.task_type_id%TYPE) IS
      SELECT COUNT(DISTINCT U.OPERATING_UNIT_ID) cantidad
        FROM OR_ACTIVIDADES_ROL  AR,
             SA_ROLE             R,
             OR_ROL_UNIDAD_TRAB  rolun,
             or_operating_unit   u,
             or_task_types_items ti,
             ge_contratista      co
       WHERE AR.ID_ROL = R.ROLE_ID
         and rolun.id_rol = r.role_id
         and u.operating_unit_id = rolun.id_unidad_operativa
         and ti.task_type_id = inuTask_type_id -- tipo de trabajo de la orden ingresada
         and co.id_contratista = u.contractor_id
         and u.contractor_id = inuContratista -- contratista OIA
         and ti.items_id = id_actividad;

  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'proAsignaOrdenOIA', cnuNVLTRC);   
      
    --Obtengo la cantidad de unidades que tiene el contratista OIA
    OPEN cuCantUnidOia(inuContratistaOIA, inuTask_type_id);
    FETCH cuCantUnidOia INTO nuCantUnidOia;
    IF cuCantUnidOia%NOTFOUND THEN
      nuCantUnidOia := NULL;
    END IF;
    CLOSE cuCantUnidOia;

    -- Si la cantidad es 0 (No tiene unidad) o si es mayor a 1 (tiene varias), mandamos error.
    IF nvl(nuCantUnidOia,0) = 0 OR nuCantUnidOia > 1 THEN
      osbMensaje := 'El contratista OIA [' || to_char(inuContratistaOIA) ||'] no tiene unidad operativa o tiene mas de una asignada. Por favor validar.';
      RAISE exValidacion;
    ELSIF nuCantUnidOia = 1 THEN
      -- Si solo tiene una unidad, la obtenemos.
      SELECT distinct U.OPERATING_UNIT_ID
        INTO nuUnidadContratistaOIA
        FROM OR_ACTIVIDADES_ROL  AR,
             SA_ROLE             R,
             OR_ROL_UNIDAD_TRAB  rolun,
             or_operating_unit   u,
             or_task_types_items ti,
             ge_contratista      co
       WHERE AR.ID_ROL = R.ROLE_ID
         and rolun.id_rol = r.role_id
         and u.operating_unit_id = rolun.id_unidad_operativa
         and ti.task_type_id = inuTask_type_id -- tipo de trabajo de la orden ingresada
         and co.id_contratista = u.contractor_id
         and u.contractor_id = inuContratistaOIA -- contratista OIA
         and ti.items_id = id_actividad;

      -- Asignamos la orden
      API_ASSIGN_ORDER(inuOrder,
                      nuUnidadContratistaOIA,
                      onuCodigoError,
                      osbMensaje);

      -- Si el codigo de error es diferente de 0, quiere decir que hubo error. Lo arrojamos.
      IF nvl(onuCodigoError,0) != 0 THEN
        osbMensaje := 'Error al asignar orden ['||to_char(inuOrder) ||'] mensaje: ['||osbMensaje||']';
        RAISE exValidacion;
      END IF;
    END IF;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'proAsignaOrdenOIA', cnuNVLTRC);   
    
  exception
    when exValidacion then
      onuCodigoError := -1;
    when others then
      onuCodigoError := -1;
      pkg_error.setError;
      pkg_error.getError(gnuErr,gsbErr);
      osbMensaje := 'Error asignando orden de trabajo a Organismo de inspeccion. '||gsbErr;
  END proAsignaOrdenOIA;
  ------------------------------------------------------------------------------------------------------------------------------------------------------------

  PROCEDURE proRegisterNewCertiRP(inuContratoId           IN LDC_CERTIFICADOS_OIA.id_contrato%TYPE, -- codifo del contrato
                                  idtfechaInspe           IN LDC_CERTIFICADOS_OIA.FECHA_INSPECCION%TYPE, -- fecha de inspeccion
                                  inuTipoInspec           IN LDC_CERTIFICADOS_OIA.TIPO_INSPECCION%TYPE, -- tipo de inspeccion
                                  isbCertificado          IN LDC_CERTIFICADOS_OIA.CERTIFICADO%TYPE, -- numero del certificado
                                  inuOrganismoId          IN LDC_CERTIFICADOS_OIA.ID_ORGANISMO_OIA%TYPE, -- codigo del organismo certificador
                                  inuInspector            IN GE_PERSON.NUMBER_ID%TYPE, -- cedula del inspector
                                  isbNombre_inspector     IN GE_PERSON.NAME_%TYPE, -- nombre del inspector
                                  isbCodigoSIC            IN VARCHAR2, -- codigo SIC
                                  idtfechaVigencia        IN DATE, -- fecha de vigencia
                                  inuRESULTADO_INSPECCION IN LDC_CERTIFICADOS_OIA.RESULTADO_INSPECCION%TYPE, -- resultado de la inspeccion
                                  isbRED_INDIVIDUAL       IN LDC_CERTIFICADOS_OIA.RED_INDIVIDUAL%TYPE, -- flag que indica si la red es individual
                                  icuArtefactos           IN CLOB, -- cursor de artefactos
                                  icuDefNoCritico         IN CLOB, -- defectos no criticos
                                  ISBAPROBADO             IN VARCHAR2 default NULL, -- se pasa parametro para logica de aprobacion
                                  iSBMatricula            IN mo_packages.document_key%TYPE, -- matricula
                                  isbUrl                  IN Varchar2 DEFAULT NULL, --Se agrega [CA 200-1572]
                                  inuOrderid              IN or_order.order_id%TYPE DEFAULT NULL, --Se agrega [CA 200-1572]
                                  inuCodigoOrganismo      IN ldc_organismos.organismo_id%TYPE DEFAULT NULL, --Se agrega [CA 200-1572]
								                  sbVacioInterno      	  IN ldc_certificados_oia.vaciointerno%TYPE DEFAULT NULL, --caso: 806
								                  dtFechaReg      		    IN ldc_certificados_oia.fecha_reg_osf%TYPE DEFAULT NULL, --caso: 806
                                  CUMENSAJE               OUT SYS_REFCURSOR) -- CURSOR DE MENSAJES DE ERROR
   AS
    /* -------------------------------------------------------------------------------------------------------------------
      PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P
      PROCEDIMIENTO : proRegisterNewCertiRP
      AUTOR : EMIRO LEYVA HERNANDEZ
      FECHA : 08/04/2014
      RICEF      : I003
      DESCRIPCION : Procedimiento para REGISTRAR EL CERTIFICADO EN SMARFLEX

        Parametros de Entrada
        Parametros de Salida

      Historia de Modificaciones
      Autor        Fecha       Descripcion.
      ------------------------------------------------------------------------------------------------------------------------
      AAcuna       22-03-2017  Caso 200-1189
      ljlb         06/10/2017  Caso 200-1324 Se quita logica de creacion de suspension y se
                               adiciona parametro de entrada ISBAPROBADO y iSBMatricula
                               se modifica cursor de salida para que envie contrato
      eaguera      21/11/2017  Caso 200-1324 Se realiza un mejor control de los errores.
      SEBTAP       19-12-2017  Caso 200-1572 Se agregan nuevas validaciones para la orden.
      Karbaq       27/02/2018  Caso 200-1798 se agrega la validacion de tipo de inspaccion voluntaria  u obligatoria.
      eaguera      02/04/2018  Se adicionan validaciones para el registro de inspecciones con orden de trabajo relacionada.
      SEBTAP       10-ABR-2018 Caso 200-1572 Se agregan nuevas validaciones.
      eaguera      17/04/2018  Caso 200-1572 Reorganizacion de codigo para la asignacion de orden a unidad operativa.
                               Se coloca en comentarios valicion de que exista la unidad operativa. Ahora se manda codigo OIA.
                               Se asigna tipo de inspeccion voluntaria (2) si la funcion ldc_getEdadRP < 54
    josdon    17/08/2018 Caso 300-27257 corregir inconveniente de aprobación de certificados si el tipo de inspección es 4
                 Se deja en comentario la sección de código que valida la relación de la unidad de trabajo con el orgenismo de inspección.
    fsierra 03/04/2020 1- GLPI 20 Se quita el comentario a la instruccion de codigo donde se habia dejado la seccion que valida la relacion de la unidad de trabajo con el orgenismo de inspeccion.
                        Esto habia sido colocado en comentario por el incidente 300-27257.
                        2- GLPI 20 Se modifica segmento de codigo del procedimiento proRegisterNewCertiRP que cambia estado de orden a ejecutada.
    josdon  15/05/2020  GLPI 102 Se modifica procedimiento proRegisterNewCertiRP para agregar la lógica del resultado de inspección 5-Con defectos no críticos y sin artefactos a gas
    fsierra 29/05/2020  GLPI 102 Se agrega validación a condicional para pasar una orden a estado ejecutada, primero validando que se encuentre asignada.
    OL-Software     26/07/2020  Caso 404 - Se ajusta el proceso al momento de actualizar la marca del producto, a fin de que valide con el parametro TIPOINSACTMARCA
    OL-Software     17/01/2020  Caso 540 - Se agrega validacion que permite determinar si el contratista es externo y la orden viene con un valor definido.
	                                       Se corrige el procedimiento al momento en que se crea al técnico que está registrando el certificado en OSF. Al no existir el programa lo crea. 
    dsaltarin       08/08/2022  OSF-477: Se agrega validación de la fecha de inspección, la fecha recibida no puede ser mayo que la fecha actual.
                                Se elimina código en comentario. Se elimina código no usado de acuerdo a los aplica entrega.
    dsaltarin       20/09/2022  OSF-576: Se corrige para devolver siemrpe 4 variables en el cursor de salida                                
    *-------------------------------------------------------------------------------------------------------------------------*/

    -- define las variables
    SW                    NUMBER := 0;
    nuPersonId            ge_person.person_id%TYPE;
    nuProductId           LDC_CERTIFICADOS_OIA.ID_PRODUCTO%TYPE;
    sbExistePerson        VARCHAR2(1);
    resulta               BOOLEAN;
    registro              daor_oper_unit_persons.styOr_oper_unit_persons;
    nuCERTIFICADOS_OIA_ID LDC_CERTIFICADOS_OIA.CERTIFICADOS_OIA_ID%TYPE;
    nuAPPLIANCE_ID        LDC_APPLIANCE_OIA.APPLIANCE_ID%TYPE;
    nuDefecto             ge_defect.defect_id%TYPE;
    nuEdad                NUMBER;
    nuAPPLIANCE_OIA_ID    LDC_APPLIANCE_OIA.APPLIANCE_OIA_ID%TYPE;
    sbmensaje             VARCHAR2(2000);
    nuPackage_id          mo_packages.package_id%TYPE;
    nuLocalidad           ldc_equiva_localidad.geograp_location_id%TYPE;
    nuASE                 NUMBER;

    onuErrorCode          ge_error_log.error_log_id%type;
    osbErrorMessage       ge_error_log.description%type;

    sbDatosCuMensaje      VARCHAR2(2000);
    SBValCert             LD_PARAMETER.VALUE_CHAIN%type;
    sbMenActu             VARCHAR2(3200);
    SBValActCert          VARCHAR2(3200);
    SBValSuspCert         VARCHAR2(3200);
    datosValCert          VARCHAR2(3200) := NULL;
    nuTipo_Inspeccion     LDC_CERTIFICADOS_OIA.TIPO_INSPECCION%TYPE;

    excActCert            EXCEPTION;

    nuComment_Type        ge_comment_type.comment_type_id%type:=3;
    sbOrder_Comment       or_order_comment.order_comment%type:='Orden ejecutada por registro de informe de inspeccion';

    cnu20                 CONSTANT NUMBER := 20;

    -- cursor para sacar los artefactos
    CURSOR cuArtefactos IS
      SELECT *
        FROM XMLTable('/Artefactos/idArtefacto' PASSING
                      XMLTYPE(icuArtefactos) Columns Row_Num FOR Ordinality,
                      idArtefacto NUMBER(10) Path '/');

    -- cursor para sacar los defectos no criticos
    CURSOR cuDefecto IS
      SELECT *
        FROM XMLTable('/Defectos/idDefecto' PASSING
                      XMLTYPE(icuDefNoCritico) Columns Row_Num FOR
                      Ordinality,
                      idDefecto NUMBER(10) Path '/');

    CURSOR cuIdentificationSus(inuContrato SUSCRIPC.SUSCCODI%type) IS
      SELECT g.subscriber_id
        FROM SUSCRIPC s, ge_subscriber g
       WHERE g.subscriber_id = s.suscclie
         AND s.susccodi = inuContrato;

    CURSOR cuMensajeTemporal IS
      Select CODIGO, MENSAJE From ldc_tempoMensajeWeb;

    CURSOR cuContratoMatricula IS
      SELECT m.subscription_id
        FROM mo_packages p, mo_motive m
       WHERE p.package_type_id IN
             (SELECT COLUMN_VALUE
                FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('LDC_LISTTRAOIA',
                                                                                         NULL),
                                                        ',')))
         AND p.document_key = iSBMatricula
         AND m.package_id = p.package_id
         AND NOT EXISTS
       (SELECT 1
                FROM mo_motive mi, mo_packages pI
               WHERE mI.package_id = PI.package_id
                 AND m.subscription_id <> mI.subscription_id
                 AND p.document_key = pI.document_key
                 AND p.package_id <> PI.package_id);

    --Cursor para validar los datos de la orden de trabajo relacionada con la inspeccion
    Cursor cuOrden(inuOrden or_order.order_id%type) IS
      SELECT o.operating_unit_id,
             o.order_status_id,
             o.task_type_id,
             a.subscription_id
        FROM or_order o, or_order_activity a
       WHERE o.order_id = inuOrden
         AND o.order_id = a.order_id;

    --Cursor para traer los datos del organismo de inspeccion
    Cursor cuOrganismo(inuOrganismo or_order.order_id%type) IS
      SELECT l.contratista_id, l.operating_unit_id
        FROM ldc_organismos l
       WHERE l.organismo_id = inuOrganismo;

    nuContratistaOrganismo NUMBER := NULL;
    nuUnidadOrganismo      NUMBER := NULL;
    nuIdOrganismoOia       NUMBER := NULL;

    -- Cursor para validar existencia de valores en parametros separados por coma
    CURSOR cu_Parameter(inuvalor    NUMBER,
                        sbParameter ld_parameter.parameter_id%TYPE) IS
      SELECT COUNT(1) CANTIDAD
        FROM DUAL
       WHERE inuvalor IN
             (SELECT to_number(column_value)
                FROM table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain(sbParameter,
                                                                                         NULL),
                                                        ',')));
    -- Variable para almacenar el resultado del cursor.
    nuExistParameter NUMBER := 0;

    Cursor cuUnidad(inuUnidadOrder or_operating_unit.operating_unit_id%type,
                    inuContratista or_operating_unit.contractor_id%type) IS
      SELECT COUNT(1) cantidad
        FROM DUAL
       WHERE inuUnidadOrder IN
             (SELECT O.OPERATING_UNIT_ID
                FROM OR_OPERATING_UNIT O
               WHERE O.CONTRACTOR_ID = inuContratista);
    nuExistUnit NUMBER := 0;

    Cursor cuValResultadoInspeccion(inuRESULTADO_INSPECCION LDC_CERTIFICADOS_OIA.RESULTADO_INSPECCION%TYPE) IS
      SELECT count(1) cantidad
        FROM DUAL
       WHERE inuRESULTADO_INSPECCION IN
             (SELECT to_number(column_value)
                FROM table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('RESULTADO_INSPECCION_OIA',
                                                                                         NULL),
                                                        ',')));

    rcResultadoInspeccion cuValResultadoInspeccion%ROWTYPE;


    --Variables de la orden de trabajo relacionada
    nuOperating_unit_id  or_order.operating_unit_id%type;
    nuOrder_status_id    or_order.order_status_id%type;
    nuTask_type_id       or_order.task_type_id%type;
    nuSubscription_id    or_order_activity.subscription_id%type;
    nuContrato           suscripc.susccodi%type;
    
    sbProcesoapro        VARCHAR2(1) := 'S';
    nuOrganismoOperUnit  or_order.operating_unit_id%type;
    dtFechReg            date;

    PROCEDURE CerrarCursor IS
    BEGIN
      IF (cuValResultadoInspeccion%ISOPEN) THEN
        CLOSE cuValResultadoInspeccion;
      END IF;
    END CerrarCursor;

  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'proRegisterNewCertiRP', cnuNVLTRC);   
        
    DELETE FROM ldc_tempoMensajeWeb;

    nuTipo_Inspeccion := inuTipoInspec;    
    
    IF inuContratoId IS NULL THEN
        OPEN cuContratoMatricula;
        FETCH cuContratoMatricula
          INTO nuContrato;
        CLOSE cuContratoMatricula;
      ELSE
        nuContrato := inuContratoId;
    END IF;
    

    -- valida que exista el contrato
    IF NOT pktblsuscripc.fblexist(nuContrato) THEN
      INSERT INTO ldc_tempoMensajeWeb VALUES (1, 'El Contrato '||nuContrato|| ' no existe');
      sw := sw + 1;
    END IF;

    -- valida que no se grabe mas de una vez el certificado para la mismo organismo certificador
    SBValCert     := Dald_parameter.fsbGetValue_Chain('LDCI_FLAG_VALCERT',
                                                      NULL);
    SBValActCert  := Dald_parameter.fsbGetValue_Chain('LDCI_FLAG_VALACTCERT',
                                                      NULL);
    SBValSuspCert := Dald_parameter.fsbGetValue_Chain('LDCI_FLAG_VALSUSPCERT',
                                                      NULL);

    IF SBValCert IS NULL THEN
      pkg_error.setErrorMessage( isbMsgErrr => 
                                       'No existe datos para el parametro LDCI_FLAG_VALCERT, definalos por el comando LDPAR');
    END IF;

    IF SBValActCert IS NULL THEN
      pkg_error.setErrorMessage( isbMsgErrr => 
                                       'No existe datos para el parametro LDCI_FLAG_VALACTCERT, definalos por el comando LDPAR');
    END IF;

    IF SBValSuspCert IS NULL THEN
      pkg_error.setErrorMessage( isbMsgErrr => 
                                       'No existe datos para el parametro LDCI_FLAG_VALSUSPCERT, definalos por el comando LDPAR');
    END IF;

    IF (SBValCert = 'S') then
      datosValCert := fblExistCertificado(inuOrganismoId, isbCertificado);
      IF datosValCert IS NOT NULL THEN
        INSERT INTO ldc_tempoMensajeWeb VALUES (3,'El Organismo certificador ya utilizo ese certificado' ||datosValCert);
        sw := sw + 1;
      END IF;
    END IF;

    --Valida que no se grabe mas de una vez el certificado para la mismo organismo certificador
    --Busca si existe el inspector
    resulta        := ge_bopersonal.valididentification(inuInspector,
                                                        1,
                                                        nuPersonId);
    sbExistePerson := 'N';
    IF nvl(nuPersonId, 0) > 0 THEN
      sbExistePerson := 'Y';
    END IF;

    IF isbRED_INDIVIDUAL = 'Y' THEN
      -- busco el producto activo de gas
      nuProductId := LDCI_PKREVISIONPERIODICAWEB.fnuGetProdActiveByContract(nuContrato);
      IF nvl(nuProductId, 0) <= 0 THEN
        INSERT INTO ldc_tempoMensajeWeb VALUES (4, 'Este contrato no tiene producto de gas activo');
        sw := sw + 1;
      END IF;
    END IF;

    --Si el contrato no es nulo realizamos la validacion
    IF nuContrato IS NOT NULL then
      nuProductId := LDCI_PKREVISIONPERIODICAWEB.fnuGetProdRedContract(nuContrato);
      nuLocalidad := PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTLOCALITY(nuProductId);
      nuAse       := fnuGetLocalidadesASE(nuLocalidad);

      IF nuASE = 1 THEN
        INSERT INTO ldc_tempoMensajeWeb
        VALUES (6,'Al Contrato registrado numero ' || nuContrato ||' no es posible registrar un certificado de inspeccion o certificacion dado que se localiza' ||
                ' en una localidad de servicio exclusivo');
        sw := sw + 1;
      END IF;
    END IF;

    IF (TRUNC(idtfechaInspe) > TRUNC(SYSDATE)) THEN
        INSERT INTO ldc_tempoMensajeWeb
        VALUES (7,'La fecha de inspección ' || idtfechaInspe ||' no puede ser mayor que la fecha actual ' || sysdate);
        sw := sw + 1;
    END IF;

    IF (idtfechaInspe is null) THEN
        INSERT INTO ldc_tempoMensajeWeb
        VALUES (7,'La fecha de inspección no puede ser nula ');
        sw := sw + 1;
    END IF;

    IF inuTipoInspec = 1 then
    -- busco la EDAD PARA VERIFICAR LA VIGENCIA
        nuEdad := ldc_getEdadRP(nuProductId);
        IF nuEdad < 54 then
            nuTipo_Inspeccion := 2;
        END IF;
    END IF;

    --Validamos si existe organismos y si la orden esta asignada a la unidad operativa correspondiente
    IF inuCodigoOrganismo IS NOT NULL then
      --Buscamos organismo de inspeccion
      OPEN cuOrganismo(inuCodigoOrganismo);
      FETCH cuOrganismo INTO nuContratistaOrganismo, nuUnidadOrganismo;
      IF cuOrganismo%notfound then
        INSERT INTO ldc_tempoMensajeWeb VALUES (8,'El organismo de inspeccion ['||to_char(inuCodigoOrganismo) ||'] no fue encontrado. Por favor revisar.');
        sw := sw + 1;
      END IF;
      CLOSE cuOrganismo;

      --Si orden es NULL y no tiene unidad de trabajo por defecto debe sacar error
      IF nuUnidadOrganismo IS NULL AND inuOrderid IS NULL THEN
        INSERT INTO ldc_tempoMensajeWeb VALUES (9,'El organismo [' ||to_char(inuCodigoOrganismo) ||'] no tiene configurado [UNIDAD_OPERATIVA] y el [ID_ORDEN] es nulo.');
        sw := sw + 1;
      END IF;

        IF(nuUnidadOrganismo IS NOT NULL AND nuContratistaOrganismo IS NULL AND inuOrderid IS NOT NULL) THEN
            INSERT INTO LDC_TEMPOMENSAJEWEB
            VALUES (cnu20,
                    'El organismo [' || to_char(inuCodigoOrganismo) ||'] no puede registrar una orden de trabajo durante el registro de certificado de inspeccion. Favor validar'
                    );
            sw := sw + 1;
        END IF;

      --Definimos la unidad operativa y codigo de organismo
      nuIdOrganismoOIA := inuCodigoOrganismo;
      IF inuOrderid IS NOT NULL THEN
        --Si existe orden colocamos la unidad operativa de la orden
        nuOrganismoOperUnit := nuOperating_unit_id;
      ELSE
        --Si no existe orden colocamos la unidad operativa por defecto en la tabla LDC_ORGANISMOS
        nuOrganismoOperUnit := nuUnidadOrganismo;
      END IF;
    ELSE
      --Si el codigo de organismo es NULL significa que es el portal anterior y la unidad operativa esta en la variable inuOrganismoId
      nuIdOrganismoOIA := NULL;
      nuOrganismoOperUnit := inuOrganismoId;
    END IF;

    --Si hay orden de trabajo se realizan validaciones
    IF inuOrderid IS NOT NULL THEN
      OPEN cuOrden(inuOrderid);
      FETCH cuOrden
        INTO nuOperating_unit_id,
             nuOrder_status_id,
             nuTask_type_id,
             nuSubscription_id;
      IF cuOrden%notfound then
        INSERT INTO ldc_tempoMensajeWeb VALUES (10,'La orden ['||to_char(inuOrderid) ||'] no fue encontrada. Por favor revisar.');
        sw := sw + 1;
      END IF;
      CLOSE cuOrden;

      --Verificamos si la orden esta asignada a una unidad operativa relacionada con el contratista del organismo
      --Colocado en comentario momentaneamente por incidente 300-27257
      --Se quita el comentario que habia sido colocado momentaneamente por el incidente 300-27257 (GLPI 20)
    IF nuContratistaOrganismo IS NOT NULL AND inuOrderid IS NOT NULL AND nuOperating_unit_id IS NOT NULL then
        SELECT COUNT(1) cantidad
          INTO nuExistUnit
          FROM DUAL
         WHERE nuOperating_unit_id IN
               (SELECT O.OPERATING_UNIT_ID
                  FROM OR_OPERATING_UNIT O
                 WHERE O.CONTRACTOR_ID = nuContratistaOrganismo);

        IF nuExistUnit = 0 THEN
        INSERT INTO ldc_tempoMensajeWeb VALUES (11,'La orden [' ||to_char(inuOrderid) ||'] no se encuentra asignada a una unidad operativa relacionada con el organismo de inspeccion. Por favor revisar.');
        sw := sw + 1;
        END IF;

      END IF;


      --Validamos si la orden se encuentra en un estado valido (asignada o ejecutada)
      OPEN cu_Parameter(nuOrder_status_id, 'ESTA_ORDEN_VALIDO_OIA');
      FETCH cu_Parameter INTO nuExistParameter;
      IF cu_Parameter%NOTFOUND THEN
        nuExistParameter := 0;
      END IF;
      CLOSE cu_Parameter;
      IF nuExistParameter = 0 then
        INSERT INTO ldc_tempoMensajeWeb VALUES (12,'La orden [' ||to_char(inuOrderid) ||'] no se encuentra en un estado valido para ser relacionada. Por favor revisar.');
        sw := sw + 1;
      END IF;

      --Validamos si el contrato de la inspeccion corresponde con el contrato de la orden
      IF nuSubscription_id != inuContratoId then
        INSERT INTO ldc_tempoMensajeWeb VALUES (13,'El contrato de la inspeccion [' ||to_char(inuContratoId) ||'] no corresponde con el contrato de la orden. Por favor revisar.');
        sw := sw + 1;
      END IF;

      --Procedemos a definir la unidad operativa y codigo de organismo
      If inuCodigoOrganismo IS NOT NULL then
        nuIdOrganismoOIA := inuCodigoOrganismo;
        IF inuOrderid IS NOT NULL THEN
          --Si existe orden colocamos la unidad operativa de la orden
          nuOrganismoOperUnit := nuOperating_unit_id;
        ELSE
          --Si no existe orden colocamos la unidad operativa por defecto en la tabla LDC_ORGANISMOS
          nuOrganismoOperUnit := nuUnidadOrganismo;
        END IF;
      ELSE
        --Si el codigo de organismo es NULL significa que es el portal anterior y la unidad operativa esta en la variable inuOrganismoId
        nuIdOrganismoOIA := NULL;
        nuOrganismoOperUnit := inuOrganismoId;
      END IF;

      --Validamos si la orden corresponde a los tipos de trabajo permitidos
      OPEN cu_Parameter(nuTask_type_id, 'TIPO_TRAB_ORDEN_VALIDO_OIA');
      FETCH cu_Parameter
        INTO nuExistParameter;
      IF cu_Parameter%NOTFOUND THEN
        nuExistParameter := 0;
      END IF;
      CLOSE cu_Parameter;
      IF nuExistParameter = 0 then
        INSERT INTO ldc_tempoMensajeWeb VALUES (14,'La orden [' ||to_char(inuOrderid) ||'] no tiene el tipo de trabajo permitido para asociar con el informe de inspeccion. Por favor revisar.');
        sw := sw + 1;
      END IF;
    END IF;
    
    IF dtFechaReg IS NULL then
        INSERT INTO ldc_tempoMensajeWeb VALUES (15,'La fecha de registro no puede ser nula');
        sw := sw + 1;
    END IF;

    IF trunc(dtFechaReg)>trunc(sysdate) then
        INSERT INTO ldc_tempoMensajeWeb VALUES (16,'La fecha de registro '||trunc(dtFechaReg) ||'no puede mayor que la fecha actual '||trunc(sysdate));
        sw := sw + 1;
    END IF;

    dtFechReg := dtFechaReg;
 
    --SI CUMPLE CON TODAS LAS VALIDACIONES DEL PROCESO PROCEDE A REGISTRAR EL CERTIFICADO LA SUSPENSION Y ACTUALIZAR EL CERTIFICADO
    IF sw = 0 then
      IF sbExistePerson = 'N' THEN
        -- creo el person
        nuPersonId := NULL;
        ge_bopersonal.register(isbNombre_inspector,
                               inuInspector,
                               1,
                               NULL,
                               NULL,
                               NULL,
                               NULL,
                               132,
                               NULL,
                               NULL,
                               NULL,
                               nuPersonId);

		registro.operating_unit_id := nuOrganismoOperUnit;
        registro.person_id         := nuPersonId;
        -- asocia el person a la unidad de trabajo
        daor_oper_unit_persons.insrecord(registro);
        dage_person.updcomment_(nuPersonId, 'SIC:' || isbCodigoSIC);
      END IF;

      SELECT seq_LDC_CERTIFICADOS_OIA.nextval
        INTO nuCERTIFICADOS_OIA_ID
        FROM dual;

      INSERT INTO LDC_CERTIFICADOS_OIA
          (CERTIFICADOS_OIA_ID,
          ID_CONTRATO,
          ID_PRODUCTO,
          FECHA_INSPECCION,
          TIPO_INSPECCION,
          CERTIFICADO,
          ID_ORGANISMO_OIA,
          ID_INSPECTOR,
          RESULTADO_INSPECCION,
          PACKAGE_ID,
          RED_INDIVIDUAL,
          STATUS_CERTIFICADO,
          FECHA_REGISTRO,
          URL,
          ORDER_ID,
          ORGANISMO_ID,
          VACIOINTERNO,
          FECHA_REG_OSF
      )
        VALUES
          (nuCERTIFICADOS_OIA_ID,
          nuContrato,
          nuProductId,
          idtfechaInspe,
          nuTipo_Inspeccion,
          isbCertificado,
          nuOrganismoOperUnit,
          nuPersonId,
          inuRESULTADO_INSPECCION,
          nuPackage_id,
          isbRED_INDIVIDUAL,
          'I',
          dtFechReg,
          isbUrl, 
          inuOrderid,
          nuIdOrganismoOia,
          sbVacioInterno,
          sysdate);

      IF icuArtefactos IS NOT NULL THEN
        FOR RG IN cuArtefactos LOOP
          nuAPPLIANCE_ID := RG.IDARTEFACTO;
          SELECT seq_LDC_APPLIANCE_OIA.nextval
            INTO nuAPPLIANCE_OIA_ID
            FROM dual;
          INSERT INTO LDC_APPLIANCE_OIA
          VALUES
            (nuAPPLIANCE_OIA_ID, nuCERTIFICADOS_OIA_ID, nuAPPLIANCE_ID);
        END LOOP;
      END IF;
      IF icuDefNoCritico IS NOT NULL THEN
        FOR RG IN cuDefecto LOOP
          nuDefecto := RG.IDDEFECTO;
          INSERT INTO LDC_DEFECTOS_OIA
          VALUES
            (nuCERTIFICADOS_OIA_ID, nuDefecto);
        END LOOP;
      END IF;

      OPEN cuValResultadoInspeccion(inuRESULTADO_INSPECCION);
      FETCH cuValResultadoInspeccion
        INTO rcResultadoInspeccion;
      CerrarCursor;

      IF rcResultadoInspeccion.Cantidad > 0 THEN
        
        IF NVL(ISBAPROBADO, 'S') = 'S' THEN
          sbProcesoapro := 'S';
        ELSE
          sbProcesoapro := 'N';
        END IF;
        
      END IF;

      --Si la orden es registrada, se la asignamos a la unidad operativa del contratista relacionado con la OIA.
      IF inuOrderid IS NOT NULL AND nuOrder_status_id = Dald_parameter.fnuGetNumeric_Value('ESTADO_ORDEN_REGISTRADA_OIA',NULL) THEN
        proAsignaOrdenOIA(inuOrderid, nuContratistaOrganismo, nuTask_type_id, onuErrorCode, osbErrorMessage);
        -- Si el codigo de error es diferente de 0, quiere decir que hubo error. Lo arrojamos.
        IF nvl(onuErrorCode,0) != 0 THEN
          pkg_error.setErrorMessage( isbMsgErrr => osbErrorMessage);
        END IF;
      END IF;

      --Si la orden no es NULL se pasa a estado ejecutada
      IF dald_parameter.fsbgetvalue_chain('ACTU_ESTA_ORDEN', NULL) = 'Y' AND daor_order.fnugetorder_status_id(inuOrderid, NULL) = Dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT',NULL) AND inuOrderid IS NOT NULL THEN
        BEGIN

           or_BOEjecutarorden.ejecutarorden( inuOrderid, nuComment_Type, sbOrder_Comment );

           daor_order.updexec_initial_date(inuOrderid,idtfechaInspe);

           daor_order.updexecution_final_date(inuOrderid,idtfechaInspe);

           EXCEPTION
           WHEN OTHERS THEN
                 pkg_Error.SetError;
                 RAISE pkg_Error.Controlled_Error;
           END;
      END IF;

      INSERT INTO ldc_tempoMensajeWeb
      VALUES (0,'El Registro  del Certificado # ' || nuCERTIFICADOS_OIA_ID ||' fue exitoso');
      
    END IF;

    OPEN CUMENSAJE FOR
        SELECT CODIGO,
               MENSAJE,
               nuCERTIFICADOS_OIA_ID CERTIFICADOS_OIA_ID,
               nuContrato            CONTRATO
          FROM ldc_tempoMensajeWeb;
    
    sbDatosCuMensaje := NULL;
    For reLdcTempoMensajeWeb In cuMensajeTemporal Loop
      sbDatosCuMensaje := sbDatosCuMensaje || '/' ||
                          reLdcTempoMensajeWeb.Codigo || ',' ||
                          reLdcTempoMensajeWeb.Mensaje;
    END loop;

    log_certificados_oia(nuContrato,
                         idtfechaInspe,
                         inuTipoInspec,
                         isbCertificado,
                         inuOrganismoId,
                         inuRESULTADO_INSPECCION,
                         isbRED_INDIVIDUAL,
                         sbDatosCuMensaje,
                         onuErrorCode,
                         osbErrorMessage);

    UT_Trace.Trace('Term ina ' || csbSP_NAME || 'proRegisterNewCertiRP', cnuNVLTRC);   
    
  EXCEPTION
    WHEN excActCert THEN
      ROLLBACK;
      pkg_Error.getError(onuErrorCode, sbmensaje);

      sbmensaje := 'Error:  ' || sbmensaje || sbMenActu || '-' ||
                   Dbms_Utility.Format_Error_Backtrace;

      INSERT INTO ldc_tempoMensajeWeb VALUES (99, sbmensaje);
      OPEN CUMENSAJE FOR
        Select CODIGO, 
                MENSAJE , 
                null  CERTIFICADOS_OIA_ID,
                nuContrato            CONTRATO
               From ldc_tempoMensajeWeb;
               
      COMMIT;
      --Se registra en la tabla log
      log_certificados_oia(nuContrato,
                           idtfechaInspe,
                           inuTipoInspec,
                           isbCertificado,
                           inuOrganismoId,
                           inuRESULTADO_INSPECCION,
                           isbRED_INDIVIDUAL,
                           sbmensaje,
                           onuErrorCode,
                           osbErrorMessage);

    WHEN pkg_Error.Controlled_Error THEN
      ROLLBACK;
      pkg_Error.getError(onuErrorCode, sbmensaje);
      sbmensaje := 'Error no Controlado ' || sbmensaje;

      INSERT INTO ldc_tempoMensajeWeb VALUES (99, sbmensaje);

      OPEN CUMENSAJE FOR

        Select CODIGO, 
                MENSAJE , 
                null  CERTIFICADOS_OIA_ID,
                nuContrato            CONTRATO 
        From ldc_tempoMensajeWeb;

      COMMIT;

      --Se registra en la tabla log
      log_certificados_oia(nuContrato,
                           idtfechaInspe,
                           inuTipoInspec,
                           isbCertificado,
                           inuOrganismoId,
                           inuRESULTADO_INSPECCION,
                           isbRED_INDIVIDUAL,
                           sbmensaje,
                           onuErrorCode,
                           osbErrorMessage);

    WHEN OTHERS THEN
      ROLLBACK;
      pkg_Error.setError;
      pkg_Error.getError(gnuErr,gsbErr);
      sbmensaje := 'Error no controlado:  ' || sbmensaje || gsbErr || '-' ||
                   Dbms_Utility.Format_Error_Backtrace;
      INSERT INTO ldc_tempoMensajeWeb VALUES (99, sbmensaje);
      COMMIT;
      OPEN CUMENSAJE FOR
        SELECT CODIGO, 
                MENSAJE , 
                null  CERTIFICADOS_OIA_ID,
                nuContrato            CONTRATO
         FROM ldc_tempoMensajeWeb;
      --Se registra el log de auditoria
      log_certificados_oia(nuContrato,
                           idtfechaInspe,
                           inuTipoInspec,
                           isbCertificado,
                           inuOrganismoId,
                           inuRESULTADO_INSPECCION,
                           isbRED_INDIVIDUAL,
                           sbmensaje,
                           onuErrorCode,
                           osbErrorMessage);
  END proRegisterNewCertiRP;

  /*LLOZADA*/
  /*******************************************************************************
   Metodo: FillCertificateAttributes
   Descripcion:   Obtiene todos los datos a mostrar para un Certificado
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   24-12-2021	  Horbath   CA806: Se adiciona el campo vacio interno
   25-09-2021     Horbath   CA667: Se adiciona el campo Marca Reparable
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/

  PROCEDURE FillCertificateAttributes IS

    sbPlazosCertId          VARCHAR2(500);
    sbIdContrato            VARCHAR2(500);
    sbIdProducto            VARCHAR2(500);
    sbPlazoMinimoRevision   VARCHAR2(500);
    sbPlazoMinimoSuspension VARCHAR2(500);
    sbPlazoMaximo           VARCHAR2(500);
    sbParent                VARCHAR2(500);
    sbFromCertificate       VARCHAR2(4000);
    sbMarcaReparable        VARCHAR2(500);
	sbVacioInterno        	VARCHAR2(500);
    sbIsNotif               VARCHAR2(500);

  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'FillCertificateAttributes', cnuNVLTRC);   
        
    -- Si ya existe una sentencia de atributos no se debe continuar
    IF sbSqlCertificate IS NOT NULL THEN
      RETURN;
    END IF;

    -- Definicion de cada uno de los atributos
    sbPlazosCertId          := 'LDC_PLAZOS_CERT.PLAZOS_CERT_ID';
    sbIdContrato            := 'LDC_PLAZOS_CERT.ID_CONTRATO';
    sbIdProducto            := 'LDC_PLAZOS_CERT.ID_PRODUCTO';
    sbPlazoMinimoRevision   := 'LDC_PLAZOS_CERT.PLAZO_MIN_REVISION';
    sbPlazoMinimoSuspension := 'LDC_PLAZOS_CERT.PLAZO_MIN_SUSPENSION';
    sbPlazoMaximo           := 'LDC_PLAZOS_CERT.PLAZO_MAXIMO';
    sbParent                := 'to_char(:parent_id) parent_id';
    sbMarcaReparable        := 'LDC_BODefectNoRepara.fsbGetMarkLock(LDC_PLAZOS_CERT.ID_PRODUCTO) "Defecto No Reparable"';
	sbVacioInterno			:= 'ldc_plazos_Cert.VacioInterno "Vacio Interno"';
    sbIsNotif               := 'ldc_plazos_cert.is_notif';

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
    sbCertificateAttributes := sbCertificateAttributes || sbMarcaReparable || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || sbVacioInterno || ', ' ||
                               chr(10);
    sbCertificateAttributes := sbCertificateAttributes || sbIsNotif || ', ' ||
                               chr(10);
	 sbCertificateAttributes := sbCertificateAttributes || sbParent ||
                               chr(10);

    -- Definicion del FROM con las dos tablas origen de datos
    sbFromCertificate := 'FROM LDC_PLAZOS_CERT' || chr(10);

    --  la sentencia con todos los componentes comunes
    sbSqlCertificate := 'SELECT ' || chr(10);
    sbSqlCertificate := sbSqlCertificate || sbCertificateAttributes;
    sbSqlCertificate := sbSqlCertificate || sbFromCertificate;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'FillCertificateAttributes', cnuNVLTRC);   
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END FillCertificateAttributes;

  /*******************************************************************************
   Metodo: GetCertifcate
   Descripcion:   Obtiene todos los datos del certificado a partir de un codigo
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/
  PROCEDURE GetCertifcate(inuCertificate IN LDC_PLAZOS_CERT.PLAZOS_CERT_ID%TYPE,
                          ocuCursor      OUT constants.tyRefCursor) IS
    sbSqlFinal VARCHAR2(10000);
  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'GetCertifcate', cnuNVLTRC);   
        
    -- Llamado al metodo que define los atributos
    FillCertificateAttributes;

    -- Condicion para traer un unico atributo recibiendo valor de ID
    sbSqlFinal := sbSqlCertificate ||
                  'WHERE LDC_PLAZOS_CERT.PLAZOS_CERT_ID = :Certificate' ||
                  chr(10);
     UT_Trace.Trace(sbSqlFinal, 10 );

    -- Abrir CURSOR con sentencia y parametros
    OPEN ocuCursor FOR sbSqlFinal
      USING cc_boBossUtil.cnuNULL, inuCertificate;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'GetCertifcate', cnuNVLTRC);   

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END GetCertifcate;

  /*******************************************************************************
   Metodo: GetCertificates
   Descripcion:   Obtiene todos los Certificados que cumplan con los criterios de
                  seleccion indicados por el usuario
   Autor: LLOZADA
   Fecha: Junio 12/2008

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   14-04-2014     LLOZADA - Creación

  *******************************************************************************/

  PROCEDURE GetCertificates(isbIdContrato IN LDC_PLAZOS_CERT.ID_CONTRATO%TYPE,
                            isbIdProducto IN LDC_PLAZOS_CERT.ID_PRODUCTO%TYPE,
                            ocuCursor     OUT constants.tyRefCursor) IS

    sbSqlFinal VARCHAR2(10000);
    sbFilters  VARCHAR2(4000);

  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'GetCertificates', cnuNVLTRC);   
    
    -- Las validaciones a continuacion funcionan de la siguiente manera:
    -- Si viene nulo genera instruccion igual en ambos lados del igual para que ignore la condicion
    -- Si no, concatena a la instruccion el parametro que recibe el valor digitado por el usuario

    -- Valida el tipo de documento
    IF isbIdContrato IS NOT NULL THEN
      sbFilters := sbFilters ||
                   ' WHERE LDC_PLAZOS_CERT.ID_CONTRATO = :IDCONTRATO' ||
                   chr(10);
    ELSE
      sbFilters := sbFilters ||
                   ' WHERE LDC_PLAZOS_CERT.ID_CONTRATO = nvl(:IDCONTRATO,LDC_PLAZOS_CERT.ID_CONTRATO )' ||
                   chr(10);
    END IF;

    -- En las siguientes validaciones se debe evaluar el nulo, para saber cuando concatenar los %
    -- de manera que funcione el like

    -- Valida la identificacion
    IF isbIdProducto IS NOT NULL THEN
      sbFilters := sbFilters ||
                   ' and LDC_PLAZOS_CERT.ID_PRODUCTO = :IDPRODUCTO' ||
                   chr(10);
    ELSE
      sbFilters := sbFilters ||
                   ' and LDC_PLAZOS_CERT.ID_PRODUCTO = nvl(:IDPRODUCTO , LDC_PLAZOS_CERT.ID_PRODUCTO )' ||
                   chr(10);
    END IF;

    -- Se arma la sentencia SQL
    FillCertificateAttributes;
    sbSqlFinal := sbSqlCertificate || sbFilters;
    ut_trace.trace(sbSqlFinal, 10);

    -- Llamada al cursor pasando siempre TODOS los parametros
    OPEN ocuCursor FOR sbSqlFinal
      USING cc_boBossUtil.cnuNULL, isbIdContrato, isbIdProducto;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'GetCertificates', cnuNVLTRC);   
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END GetCertificates;

  /*******************************************************************************
   Metodo: GetCertificatesOIA
   Descripcion:   Obtiene todos los CertificadosOIA que cumplan con los criterios de
                  seleccion indicados por el usuario
   Autor: LLOZADA
   Fecha: Junio 12/2008

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   14-04-2014     LLOZADA - Creación

  *******************************************************************************/

  PROCEDURE GetCertificatesOIA(isbCertificado IN ldc_certificados_oia.certificado%TYPE,
                               isbEstado      IN ldc_certificados_oia.status_certificado%TYPE,
                               isbUnidad      IN ldc_certificados_oia.id_organismo_oia%TYPE,
                               ocuCursor      OUT constants.tyRefCursor) IS

    sbSqlFinal VARCHAR2(10000);
    sbFilters  VARCHAR2(4000);

  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'GetCertificatesOIA', cnuNVLTRC);   
    
    -- Las validaciones a continuacion funcionan de la siguiente manera:
    -- Si viene nulo genera instruccion igual en ambos lados del igual para que ignore la condicion
    -- Si no, concatena a la instruccion el parametro que recibe el valor digitado por el usuario

    -- Valida el certificado
    IF isbCertificado IS NOT NULL THEN
      sbFilters := sbFilters ||
                   ' WHERE ldc_certificados_oia.certificado = :IDCERTIFICADO' ||
                   chr(10);
    ELSE
      sbFilters := sbFilters ||
                   ' WHERE ldc_certificados_oia.certificado = nvl(:IDCERTIFICADO,ldc_certificados_oia.certificado )' ||
                   chr(10);
    END IF;

    -- Valida el estado
    IF isbEstado IS NOT NULL THEN
      sbFilters := sbFilters ||
                   ' and ldc_certificados_oia.status_certificado = :IDESTADO' ||
                   chr(10);
    ELSE
      sbFilters := sbFilters ||
                   ' and ldc_certificados_oia.status_certificado = nvl(:IDESTADO , ldc_certificados_oia.status_certificado )' ||
                   chr(10);
    END IF;

    -- Valida la unidad operativa
    IF isbUnidad IS NOT NULL THEN
      sbFilters := sbFilters ||
                   ' and ldc_certificados_oia.id_organismo_oia = :IDORGANISMO' ||
                   chr(10);
    ELSE
      sbFilters := sbFilters ||
                   ' and ldc_certificados_oia.id_organismo_oia = nvl(:IDORGANISMO , ldc_certificados_oia.id_organismo_oia )' ||
                   chr(10);
    END IF;

    -- Se arma la sentencia SQL
    FillCertOIAAttributes;
    sbSqlFinal := sbSqlCertificateOIA || sbFilters;
    ut_trace.trace(sbSqlFinal,10);
    UT_Trace.Trace('--Paso 100. sbSqlFinal' || sbSqlFinal, 10);
    UT_Trace.Trace('--Paso 101. isbCertificado' || isbCertificado, 10);
    UT_Trace.Trace('--Paso 103. isbEstado' || isbEstado, 10);
    UT_Trace.Trace('--Paso 100. isbUnidad' || isbUnidad, 10);

    -- Llamada al cursor pasando siempre TODOS los parametros
    OPEN ocuCursor FOR sbSqlFinal
      USING cc_boBossUtil.cnuNULL, isbCertificado, isbEstado, isbUnidad;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'GetCertificatesOIA', cnuNVLTRC);   
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END GetCertificatesOIA;

  /*LLOZADA*/
  /*******************************************************************************
   Metodo: FillCertificateSFAttributes
   Descripcion:   Obtiene todos los datos a mostrar para un Certificado
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/
  PROCEDURE FillCertifcateSFAttributes IS

    sbCertificateId       VARCHAR2(500);
    sbProductId           VARCHAR2(500);
    sbPackageId           VARCHAR2(500);
    sbActividadCerttifica VARCHAR2(500);
    sbActividadCancela    VARCHAR2(500);
    sbFechaRegistro       VARCHAR2(500);
    sbFechaRevision       VARCHAR2(500);
    sbFechaEstimadaRev    VARCHAR2(500);
    sbFechaFinalRevision  VARCHAR2(500);
    sbActividadRevision   VARCHAR2(500);
    sbParent              VARCHAR2(500);
    sbFromAssociate       VARCHAR2(4000);

  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'FillCertifcateSFAttributes', cnuNVLTRC);   
        
    -- Si ya existe una sentencia de atributos no se debe continuar
    IF sbSqlCertificateSF IS NOT NULL THEN
      RETURN;
    END IF;

    -- Definicion de cada uno de los atributos
    sbCertificateId       := 'PR_CERTIFICATE.CERTIFICATE_ID';
    sbProductId           := 'PR_CERTIFICATE.PRODUCT_ID';
    sbPackageId           := 'PR_CERTIFICATE.PACKAGE_ID';
    sbActividadCerttifica := 'PR_CERTIFICATE.ORDER_ACT_CERTIF_ID';
    sbActividadCancela    := 'PR_CERTIFICATE.ORDER_ACT_CANCEL_ID';
    sbFechaRegistro       := 'PR_CERTIFICATE.REGISTER_DATE';
    sbFechaRevision       := 'PR_CERTIFICATE.REVIEW_DATE';
    sbFechaEstimadaRev    := 'PR_CERTIFICATE.ESTIMATED_END_DATE';
    sbFechaFinalRevision  := 'PR_CERTIFICATE.END_DATE';
    sbActividadRevision   := 'PR_CERTIFICATE.ORDER_ACT_REVIEW_ID';
    sbParent              := 'to_char(:parent_id) parent_id';

    -- Conformacion de la cadena con los atributos
    sbCertificateSFAttributes := sbCertificateSFAttributes ||
                                 sbCertificateId || ', ' || chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes || sbProductId || ', ' ||
                                 chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes || sbPackageId || ', ' ||
                                 chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes ||
                                 sbActividadCerttifica || ', ' || chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes ||
                                 sbActividadCancela || ', ' || chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes ||
                                 sbFechaRegistro || ', ' || chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes ||
                                 sbFechaRevision || ', ' || chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes ||
                                 sbFechaEstimadaRev || ', ' || chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes ||
                                 sbFechaFinalRevision || ', ' || chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes ||
                                 sbActividadRevision || ', ' || chr(10);
    sbCertificateSFAttributes := sbCertificateSFAttributes || sbParent ||
                                 chr(10);

    -- Definicion del FROM con las dos tablas origen de datos
    sbFromAssociate := 'FROM PR_CERTIFICATE' || chr(10);

    --  la sentencia con todos los componentes comunes
    sbSqlCertificateSF := 'SELECT ' || chr(10);
    sbSqlCertificateSF := sbSqlCertificateSF || sbCertificateSFAttributes;
    sbSqlCertificateSF := sbSqlCertificateSF || sbFromAssociate;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'FillCertifcateSFAttributes', cnuNVLTRC);   
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END FillCertifcateSFAttributes;

  /*******************************************************************************
   Metodo: GetCertificateSF
   Descripcion:   Obtiene todos los datos de un Certficado de SF a partir de un codigo
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/
  PROCEDURE GetCertificateSF(inuCertificateSF IN PR_CERTIFICATE.CERTIFICATE_ID%TYPE,
                             ocuCursor        OUT constants.tyRefCursor) IS
    sbSqlFinal VARCHAR2(10000);
  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'GetCertificateSF', cnuNVLTRC);   
    
    
    ut_trace.trace('-- Paso 1. GetCertificateSF, inuCertificateSF:[' ||
                   inuCertificateSF || ']',
                   cnuNVLTRC);
    -- Llamado al metodo que define los atributos
    FillCertifcateSFAttributes;

    -- Condicion para traer un unico atributo recibiendo valor de ID
    sbSqlFinal := sbSqlCertificateSF ||
                  'WHERE PR_CERTIFICATE.CERTIFICATE_ID = :CertificateSF' ||
                  chr(10);

    ut_trace.trace('-- Paso 2. GetCertificateSF, sbSqlFinal:[' ||
                   sbSqlFinal || ']',
                   cnuNVLTRC);

    -- Abrir CURSOR con sentencia y parametros
    OPEN ocuCursor FOR sbSqlFinal
      USING cc_boBossUtil.cnuNULL, inuCertificateSF;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'GetCertificateSF', cnuNVLTRC);   
         
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END GetCertificateSF;

  /*******************************************************************************
   Metodo: GetCertificateByCertificateSF
   Descripcion:   Obtiene el Certificado a partir del Certificado del hijo
                  Esto es Padre de Hijo Certificate SF
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/
  PROCEDURE GetCertificateByCertificateSF(inuCertificateSF_ID IN NUMBER,
                                          onuCertificate      OUT NUMBER) IS
  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'GetCertificateByCertificateSF', cnuNVLTRC);   
    
    SELECT PLAZOS_CERT_ID
      INTO onuCertificate
      FROM ldc_plazos_cert
     WHERE id_producto =
           (SELECT product_id
              FROM pr_certificate
             WHERE certificate_id = inuCertificateSF_ID);

    ut_trace.trace('-- Paso 3. GetCertificateByCertificateSF, onuCertificate:[' ||
                   onuCertificate || ']',
                   cnuNVLTRC);

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'GetCertificateByCertificateSF', cnuNVLTRC);   
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      -- Si falla retorna nulo
      onuCertificate := NULL;

    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END GetCertificateByCertificateSF;

  /*******************************************************************************
   Metodo: GetCertificateSFByCertificate
   Descripcion:   Obtiene todos los Certificados de SF que tiene un Certificado
                  Este es Hijo del Padre
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/
  PROCEDURE GetCertificateSFByCertificate(inuCertificate IN ldc_plazos_cert.plazos_cert_id%TYPE,
                                          ocuCursor      OUT constants.tyRefCursor) IS
    sbSqlFinal VARCHAR2(4000);
    nuProducto ldc_plazos_cert.id_producto%TYPE;
  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'GetCertificateSFByCertificate', cnuNVLTRC);   
    
    SELECT ID_PRODUCTO
      INTO nuProducto
      FROM ldc_plazos_cert
     WHERE plazos_cert_id = inuCertificate;

    FillCertifcateSFAttributes();

    sbSqlFinal := sbSqlCertificateSF ||
                  'WHERE PR_CERTIFICATE.PRODUCT_ID = :Product_id';
    ut_trace.trace(sbSqlFinal,cnuNVLTRC);

    ut_trace.trace('-- Paso 4. GetCertificateSFByCertificate, nuProducto:[' ||
                   nuProducto || ']',
                   cnuNVLTRC);
    ut_trace.trace('-- Paso 5. GetCertificateSFByCertificate, sbSqlFinal:[' ||
                   sbSqlFinal || ']',
                   cnuNVLTRC);

    OPEN ocuCursor FOR sbSqlFinal
      USING inuCertificate, nuProducto;
    ut_trace.trace('-- Paso 5.1 FINALIZA GetCertificateSFByCertificate', cnuNVLTRC);
    
    UT_Trace.Trace('Termina ' || csbSP_NAME || 'GetCertificateSFByCertificate', cnuNVLTRC);   
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END GetCertificateSFByCertificate;

  /*******************************************************************************
   Metodo: FillCertOIAAttributes
   Descripcion:   Obtiene todos los datos a mostrar para un Certificado
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
   21/12/2018     miguel ballesteros - modificacion de la variable sbTipoInspeccion CASO 200-2286
   25/02/2021     Horbath CASO 409 Adicionar la nueva variable sbOrder a la consulta dinamica   
                           Adicionar subconsulta de la vaeriable sbResultadoInspeccion para obtener 
                           la descripcion de la nueva forma LDCRESINSPEC
  *******************************************************************************/
  PROCEDURE FillCertOIAAttributes IS

    sbCertificateOiaId    VARCHAR2(500);
    sbIdContrato          VARCHAR2(500);
    sbIdProducto          VARCHAR2(500);
    sbFechaInspeccion     VARCHAR2(500);
    sbTipoInspeccion      VARCHAR2(500);
    sbCertificado         VARCHAR2(500);
    sbOrganismoOIA        VARCHAR2(500);
    sbInspector           VARCHAR2(500);
    sbResultadoInspeccion VARCHAR2(500);
    sbSolicitud           VARCHAR2(500);
    sbRed                 VARCHAR2(500);
    sbEstado              VARCHAR2(500);
    sbFechaRegistro       VARCHAR2(500);
    sbObservacion         VARCHAR2(500);
    sbFechaAprobacion VARCHAR2(500);
    sbFechaArchivo    VARCHAR2(500);
    sbArchivo         VARCHAR2(500);
    sbUrl             VARCHAR2(500);
    sbParent         VARCHAR2(500);
    sbFromAssociate  VARCHAR2(4000);

    sbOrder          VARCHAR2(4000);
	sbVacioInterno   VARCHAR2(4000);
	sbFechReg        VARCHAR2(4000);
	sbFechApro       VARCHAR2(4000);

  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'FillCertOIAAttributes', cnuNVLTRC);   
        
    -- Si ya existe una sentencia de atributos no se debe continuar
    IF sbSqlCertificateOIA IS NOT NULL THEN
      RETURN;
    END IF;

    -- Definicion de cada uno de los atributos
    sbCertificateOiaId    := 'ldc_certificados_oia.CERTIFICADOS_OIA_ID';
    sbIdContrato          := 'ldc_certificados_oia.ID_CONTRATO';
    sbIdProducto          := 'ldc_certificados_oia.ID_PRODUCTO';
    sbFechaInspeccion     := 'ldc_certificados_oia.FECHA_INSPECCION';
    sbTipoInspeccion      := '(select codigo||''-''||descripcion from ldc_resuinsp where codigo = ldc_certificados_oia.TIPO_INSPECCION) TIPO_INSPECCION';
    sbCertificado         := 'ldc_certificados_oia.CERTIFICADO';
    sbOrganismoOIA        := 'ldc_certificados_oia.ID_ORGANISMO_OIA||''-''||DAOR_OPERATING_UNIT.FSBGETNAME(ldc_certificados_oia.ID_ORGANISMO_OIA,NULL) ID_ORGANISMO_OIA';
    sbInspector           := 'ldc_certificados_oia.ID_INSPECTOR||''-''||DAGE_PERSON.FSBGETNAME_(ldc_certificados_oia.ID_INSPECTOR, NULL) ID_INSPECTOR';
    sbResultadoInspeccion := '(select codigo|| ''-''||descripcion from LDC_RESINSPEC where codigo =ldc_certificados_oia.RESULTADO_INSPECCION) RESULTADO_INSPECCION';
    sbSolicitud           := 'ldc_certificados_oia.PACKAGE_ID';
    sbRed                 := 'decode(ldc_certificados_oia.RED_INDIVIDUAL,''Y'',''INDIVIDUAL'',''MATRIZ'') RED_INDIVIDUAL';
    sbEstado              := 'decode(ldc_certificados_oia.STATUS_CERTIFICADO,''I'',''REGISTRADA'',''A'',''APROBADA'',''R'',''RECHAZADA'') STATUS_CERTIFICADO';
    sbFechaRegistro       := 'ldc_certificados_oia.FECHA_REGISTRO';
    sbObservacion         := 'ldc_certificados_oia.OBSER_RECHAZO';
    sbFechaAprobacion     := 'ldc_certificados_oia.FECHA_APROBACION';
    sbFechaArchivo        := 'ldc_certificados_oia.FECHA_ARCHIVO';
    sbArchivo             := 'ldc_certificados_oia.ARCHIVO';
    sbUrl                 := 'ldc_certificados_oia.URL';
    sbOrder               := 'ldc_certificados_oia.order_id';
	sbVacioInterno        := 'ldc_certificados_oia.vaciointerno';
	sbFechReg             := 'ldc_certificados_oia.fecha_reg_osf';
	sbFechApro            := 'ldc_certificados_oia.fecha_apro_osf';
    sbParent              := 'to_char(:parent_id) parent_id';

    -- Conformacion de la cadena con los atributos
    sbCertificateOIAAttributes := sbCertificateOIAAttributes ||
                                  sbCertificateOiaId || ', ' || chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes ||
                                  sbIdContrato || ', ' || chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes ||
                                  sbIdProducto || ', ' || chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes ||
                                  sbFechaInspeccion || ', ' || chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes ||
                                  sbTipoInspeccion || ', ' || chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes ||
                                  sbCertificado || ', ' || chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes ||
                                  sbOrganismoOIA || ', ' || chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes || sbInspector || ', ' ||
                                  chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes ||
                                  sbResultadoInspeccion || ', ' || chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes || sbSolicitud || ', ' ||
                                  chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes || sbRed || ', ' ||
                                  chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes || sbEstado || ', ' ||
                                  chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes ||
                                  sbFechaRegistro || ', ' || chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes ||
                                  sbObservacion || ', ' || chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes ||
                                  sbFechaAprobacion || ', ' || chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes ||
                                  sbFechaArchivo || ', ' || chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes || sbArchivo || ', ' ||
                                  chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes || sbUrl || ', ' ||
                                  chr(10);
    sbCertificateOIAAttributes := sbCertificateOIAAttributes || sbOrder || ', ' ||
                                    chr(10);

    sbCertificateOIAAttributes := sbCertificateOIAAttributes || sbVacioInterno || ', ' ||chr(10);
	sbCertificateOIAAttributes := sbCertificateOIAAttributes || sbFechReg || ', ' ||chr(10);
	sbCertificateOIAAttributes := sbCertificateOIAAttributes || sbFechApro || ', ' ||chr(10);
                                    
    sbCertificateOIAAttributes := sbCertificateOIAAttributes || sbParent ||
                                  chr(10);

    -- Definicion del FROM con las dos tablas origen de datos
    sbFromAssociate := 'FROM ldc_certificados_oia' || chr(10);

    --  la sentencia con todos los componentes comunes
    sbSqlCertificateOIA := 'SELECT ' || chr(10);
    sbSqlCertificateOIA := sbSqlCertificateOIA ||
                           sbCertificateOIAAttributes;
    sbSqlCertificateOIA := sbSqlCertificateOIA || sbFromAssociate;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'FillCertOIAAttributes', cnuNVLTRC);   

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END FillCertOIAAttributes;

  /*******************************************************************************
   Metodo: GetCertificateOIA
   Descripcion:   Obtiene todos los datos de un Certficado OIA a partir de un codigo
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/
  PROCEDURE GetCertificateOIA(inuCertificateOIAId IN ldc_certificados_oia.certificados_oia_id%TYPE,
                              ocuCursor           OUT constants.tyRefCursor) IS
    sbSqlFinal VARCHAR2(10000);
  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'GetCertificateOIA', cnuNVLTRC);   
      
    -- Llamado al metodo que define los atributos
    FillCertOIAAttributes;

    -- Condicion para traer un unico atributo recibiendo valor de ID
    sbSqlFinal := sbSqlCertificateOIA ||
                  'WHERE ldc_certificados_oia.certificados_oia_id = :CertificadoOIA' ||
                  chr(10);

    -- Abrir CURSOR con sentencia y parametros
    OPEN ocuCursor FOR sbSqlFinal
      USING cc_boBossUtil.cnuNULL, inuCertificateOIAId;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'GetCertificateOIA', cnuNVLTRC);   
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END GetCertificateOIA;

  /*******************************************************************************
   Metodo: GetCertificateByCertificateOIA
   Descripcion:   Obtiene el Certificado a partir del Certificado del hijo
                  Esto es Padre de Hijo Certificate SF
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/
  PROCEDURE GetCertificateByCertificateOIA(inuCertificateOIA_ID IN NUMBER,
                                           onuCertificate       OUT NUMBER) IS
  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'GetCertificateByCertificateOIA', cnuNVLTRC);  
    
    SELECT PLAZOS_CERT_ID
      INTO onuCertificate
      FROM ldc_plazos_cert
     WHERE id_producto =
           (SELECT ID_PRODUCTO
              FROM ldc_certificados_oia
             WHERE CERTIFICADOS_OIA_ID = inuCertificateOIA_ID);

    ut_trace.trace('-- Paso 20. GetCertificateByCertificateSF, onuCertificate:[' ||
                   onuCertificate || ']',
                   cnuNVLTRC);

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'GetCertificateByCertificateOIA', cnuNVLTRC);  
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      -- Si falla retorna nulo
      onuCertificate := NULL;

    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END GetCertificateByCertificateOIA;

  /*******************************************************************************
   Metodo: GetCertificateOIAByCertificate
   Descripcion:   Obtiene todos los Certificados de SF que tiene un Certificado
                  Este es Hijo del Padre
   Autor: LLOZADA
   Fecha: 12/04/2014

   Historia de Modificaciones
   Fecha          Autor - Modificacion
   ===========    ================================================================
   12/04/2014     LLOZADA - Creacion
  *******************************************************************************/
  PROCEDURE GetCertificateOIAByCertificate(inuCertificate IN ldc_plazos_cert.plazos_cert_id%TYPE,
                                           ocuCursor      OUT constants.tyRefCursor) IS
    sbSqlFinal VARCHAR2(4000);
    nuProducto ldc_plazos_cert.id_producto%TYPE;
  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'GetCertificateOIAByCertificate', cnuNVLTRC);  
    
    SELECT ID_PRODUCTO
      INTO nuProducto
      FROM ldc_plazos_cert
     WHERE plazos_cert_id = inuCertificate;

    FillCertOIAAttributes();

    sbSqlFinal := sbSqlCertificateOIA ||
                  'WHERE ldc_certificados_oia.ID_PRODUCTO = :Product_id';
    ut_trace.trace(sbSqlFinal, cnuNVLTRC);

    ut_trace.trace('-- Paso 21. GetCertificateSFByCertificate, nuProducto:[' ||
                   nuProducto || ']',
                   cnuNVLTRC);
    ut_trace.trace('-- Paso 22. GetCertificateSFByCertificate, sbSqlFinal:[' ||
                   sbSqlFinal || ']',
                   cnuNVLTRC);

    OPEN ocuCursor FOR sbSqlFinal
      USING inuCertificate, nuProducto;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'GetCertificateOIAByCertificate', cnuNVLTRC);  
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END GetCertificateOIAByCertificate;
  /***************************************************************************
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

    PROCEDIMIENTO : PROUPDOBSTATUSCERTOIA
    AUTOR : EMIRO LEYVA HERNANDEZ
    FECHA : 08/04/2014
    DESCRIPCION : Procedimiento para actualizar el esta del certificado resultado de la
                  validacion de autenticidad del certificado, tambien envia correo el OIA
                  si tiene e_mail configurado en la unidad operativa

      Parametros de Entrada

      Parametros de Salida

   Historia de Modificaciones

   Autor        Fecha       Descripcion.
   HORBATH   27/12/2021     CASO 806: Se modifico la logiuca para agregar la validacion del campo fecha de aprobacion y agregarlo al llamado del procedimiento LDCI_PROUPDOBSTATUSCERTOIAWS
  HORBATH   16/02/2021      CASO 409: Se modifico la logiuca del servicio para reemplazarlo por el llamado del 
                                      servicio LDCI_PROUPDOBSTATUSCERTOIAWS
  SLEMUS    30/05/2015      2. SAO 312076
                            Parametrizar el mensaje del certificado OIA, se parametriza la informacion
                            del mensaje de aceptacion y del mensaje de rechazo.
  oparra    30/04/2015      2. SAO 312076
                            Parametrizar el mensaje del certificado OIA, la información
                            de la linea de atención de la gasera (LDC_MENSAJE_CERT_OIA).
  emirol    08/04/2014      1. Creacion
   ***************************************************************************/
  PROCEDURE PROUPDOBSTATUSCERTOIA AS
    -- define las variables
    sbStatus_certi        LDC_CERTIFICADOS_OIA.STATUS_CERTIFICADO%TYPE;
	sbFechaAprob          LDC_CERTIFICADOS_OIA.FECHA_REG_OSF%TYPE;

    inuCERTIFICADOS_OIA_ID ge_boInstanceControl.stysbValue;
    idtID                  ge_boInstanceControl.stysbValue;
    sbFatherInstance       Ge_BOInstanceControl.stysbName;

    sbSTATUS_CERTIFICADO ge_boInstanceControl.stysbValue;
    sbOBSER_RECHAZO      ge_boInstanceControl.stysbValue;

    CURSOR cuCertificadosOIA(nuCertificado LDC_CERTIFICADOS_OIA.certificados_oia_id%TYPE) IS
      SELECT id_contrato, certificado, id_organismo_oia, fecha_registro
        FROM LDC_CERTIFICADOS_OIA
       WHERE certificados_oia_id = nuCertificado;

    nuOnuCodigo   number;
    sbOsbMensaje  varchar2(4000);    

  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'PROUPDOBSTATUSCERTOIA', cnuNVLTRC);  
    
    Ge_BOInstanceControl.GETFATHERCURRENTINSTANCE(sbFatherInstance);

    -- obtener el nuevo estado
    sbSTATUS_CERTIFICADO := ge_boInstanceControl.fsbGetFieldValue('LDC_CERTIFICADOS_OIA',
                                                                  'STATUS_CERTIFICADO');
    sbStatus_certi       := sbSTATUS_CERTIFICADO;
    UT_Trace.Trace('--Paso 200. sbStatus_certi: ' || sbStatus_certi, 10);

    -- obtener la observacion
    sbOBSER_RECHAZO := ge_boInstanceControl.fsbGetFieldValue('LDC_CERTIFICADOS_OIA',
                                                             'OBSER_RECHAZO');
    UT_Trace.Trace('--Paso 201. sbOBSER_RECHAZO: ' || sbOBSER_RECHAZO, 10);
	
	 -- obtener la fecha de aprobacion
    sbFechaAprob := ge_boInstanceControl.fsbGetFieldValue('LDC_CERTIFICADOS_OIA',
                                                             'FECHA_APROBACION');
    UT_Trace.Trace('--Paso 203. sbFechaAprob: ' || sbFechaAprob, 10);
	
	  if TO_DATE(sbFechaAprob, 'DD/MM/YYYY HH24:MI:SS') > sysdate  then              
              pkg_error.setErrorMessage( isbMsgErrr => 'La fecha de probación no puede ser mayor que la fecha actual.');
     end if;
	
    GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('WORK_INSTANCE',
                                              NULL,
                                              'LDC_CERTIFICADOS_OIA',
                                              'CERTIFICADOS_OIA_ID',
                                              inuCERTIFICADOS_OIA_ID);
    UT_Trace.Trace('--Paso 5000. idtID: ' || idtID, 10);
			
    
    LDCI_PROUPDOBSTATUSCERTOIAWS(inuCertiOia => inuCERTIFICADOS_OIA_ID,
                                 IsbStatus => sbStatus_certi,
                                 IsbObser => sbOBSER_RECHAZO,
								                 IdtFechapro => TO_DATE(sbFechaAprob, 'DD/MM/YYYY HH24:MI:SS'),
                                 OnuCodigo => nuOnuCodigo,
                                 OsbMensaje => sbOsbMensaje);    
                                 
    UT_Trace.Trace('--Paso 409-1. nuOnuCodigo: ' || nuOnuCodigo, 10);
    UT_Trace.Trace('--Paso 409-2. sbOsbMensaje: ' || sbOsbMensaje, 10);    
                                 
    if nuOnuCodigo <> 0 then      
       rollback;
       pkg_error.setErrorMessage( isbMsgErrr => sbOsbMensaje);      
    else
      commit;
    end if;
    
    UT_Trace.Trace('Termina' || csbSP_NAME || 'PROUPDOBSTATUSCERTOIA', cnuNVLTRC);  
                                                          
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      raise;
    WHEN OTHERS THEN
      RAISE pkg_Error.Controlled_Error;
  END PROUPDOBSTATUSCERTOIA;

  PROCEDURE LoadProductInformation(inuIdCertificadosOIA IN ldc_certificados_oia.certificados_oia_id%TYPE,
                                   iblIncludedWarning   IN BOOLEAN DEFAULT TRUE) IS
    -- Declaracion de variables
    sbInstance VARCHAR2(2000) := mo_boUncompositionConstants.csbWORK_INSTANCE;
    nuProducto ldc_certificados_oia.certificados_oia_id%TYPE;

    CURSOR cuProducto IS
      SELECT id_producto
        FROM ldc_certificados_oia
       WHERE certificados_oia_id = inuIdCertificadosOIA;

  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'LoadProductInformation', cnuNVLTRC);  
   
    OPEN cuProducto;
    FETCH cuProducto
      INTO nuProducto;
    CLOSE cuProducto;

    IF (nuProducto IS NULL) THEN
      RETURN;
    END IF;

    ge_boInstanceControl.AddAttribute(sbInstance,
                                      NULL,
                                      'PR_PRODUCT',
                                      'PRODUCT_ID',
                                      nuProducto,
                                      TRUE);

    ge_boInstanceControl.AddAttribute(sbInstance,
                                      NULL,
                                      'LDC_CERTIFICADOS_OIA',
                                      'CERTIFICADOS_OIA_ID',
                                      inuIdCertificadosOIA,
                                      TRUE);

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'LoadProductInformation', cnuNVLTRC);  
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END LoadProductInformation;

  FUNCTION fnuValiVisualTramite(inuProduct_id IN pr_product.product_id%TYPE)
    RETURN NUMBER IS
    /*******************************************************************************
     Metodo: fnuValiVisualTramite
     Descripcion:   Valida la visualizacion del tramite 100235 si el producto esta suspendido
                    con tipo de suspension 104 vigente y no tiene un certificado de OIA
                    vigente retorna 0 si se visualiza el tramite.
     Autor: Emiro Leyva
     Fecha: Abril 23/2014

     Historia de Modificaciones
     Fecha          Autor - Modificacion
     ===========    ================================================================
     12-04-2014     EMIROL - Creación

    *******************************************************************************/
    nuresulta       NUMBER := 0;

  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'fnuValiVisualTramite', cnuNVLTRC);  
  
    --  busca una suspension activa del tipo de suspension 104
    SELECT COUNT(*)
      INTO nuresulta
      FROM pr_prod_suspension
     WHERE product_id = inuProduct_id
       AND active = 'Y';

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'fnuValiVisualTramite', cnuNVLTRC);  

    RETURN(nuresulta);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN(0);
  END fnuValiVisualTramite;

  FUNCTION fnuGetOtUltimaRP
  /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : fnuGetOtUltimaRP
    Descripcion    : Busca la ultima orden de revision periodica
    Autor          : Emiro Leyva H.
    Fecha          : 23/10/2014

    Parametros              Descripcion
    ============         ===================
    nuExternalId:


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================

    ******************************************************************/

  (inuProductId IN pr_product.product_id%TYPE) RETURN or_order.order_id%TYPE IS
    CURSOR cuOtRP(nuProduct_Id pr_product.product_id%TYPE) IS
      SELECT MAX(a.order_id)
        FROM or_order_activity a, or_order b
       WHERE a.product_id = nuProduct_Id
         AND a.task_type_id = 12161
         AND a.order_id = b.order_id
         AND b.order_status_id = 8;

    nuOrder_id or_order.order_id%TYPE;

  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'fnuGetOtUltimaRP', cnuNVLTRC);  
      
    OPEN cuOtRP(inuProductId);
    FETCH cuOtRP
      INTO nuOrder_id;
    IF cuOtRP%NOTFOUND THEN
      nuOrder_id := NULL;
    END IF;
    CLOSE cuOtRP;
    
    UT_Trace.Trace('Termina ' || csbSP_NAME || 'fnuGetOtUltimaRP', cnuNVLTRC);  
    
    RETURN nuOrder_id;
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END fnuGetOtUltimaRP;

  PROCEDURE LDC_REGISTRVISIIDENCERTIXOTREV(inuProduct_id pr_product.product_id%TYPE) IS
    /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : LDC_REGISTRVISIIDENCERTIXOTREV
    Descripcion    : GENERA TRAMITE DE VISITA DE IDENTIFICACION DE CERTIFICADO POR XML DESDE EL OTROV
    Autor          : Emiro Leyva H.
    Fecha          : 08/06/2014

    Parametros              Descripcion
    ============         ===================
    nuExternalId:


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================

    ******************************************************************/
    onuerrorcode     NUMBER;
    osberrormessage  VARCHAR2(4000);
    sbComment        VARCHAR2(2000) := 'SE GENERAN DESDE OTREV';
    sbRequestXML1    VARCHAR2(32767);
    nuAddress_id     pr_product.address_id%TYPE;
    rcAb_address     daab_address.styAB_Address;
    nuPackage_id     MO_PACKAGES.PACKAGE_ID%TYPE;
    nuMotiveId       MO_MOTIVE.MOTIVE_ID%TYPE;
    nuSUBSCRIBERId   ge_subscriber.SUBSCRIBER_id%TYPE;
    nuSUBSCRIPTIONID pr_product.SUBSCRIPTION_ID%TYPE;
    nuCate           servsusc.sesucate%TYPE;
    nuSuca           servsusc.sesusuca%TYPE;
    sw1              NUMBER;
    nusaldodiferido  diferido.difesape%TYPE;
    sbaplicamarc     VARCHAR2(1);
    sbaplicaentr     VARCHAR2(2);
    dtplazominrev    DATE;
    CURSOR cuBuscaMarca(nuprodu ldc_marca_producto.id_producto%TYPE) IS
      SELECT COUNT(1) FROM ldc_marca_producto WHERE id_producto = nuprodu;

    CURSOR cuBuscaSoli(nuprodu ldc_marca_producto.id_producto%TYPE) IS
      SELECT COUNT(1)
        FROM mo_packages a, ps_motive_status c, mo_motive x
       WHERE a.PACKAGE_TYPE_ID IN (100246,
                                   100156,
                                   265,
                                   266,
                                   100248,
                                   100237,
                                   100293,
                                   100294,
                                   100295,
                                   100321,
                                   100013)
         AND c.MOTIVE_STATUS_ID = a.MOTIVE_STATUS_ID
         AND c.MOTI_STATUS_TYPE_ID = 2
         AND c.MOTIVE_STATUS_ID NOT IN (14, 32, 51)
         AND x.PACKAGE_ID = a.PACKAGE_ID
         AND x.PRODUCT_ID = nuprodu;

    CURSOR cuInge(nuprodu ldc_marca_producto.id_producto%TYPE) IS
      SELECT COUNT(1)
        FROM or_order, or_order_activity
       WHERE or_order_activity.order_id = or_order.order_id
         AND or_order.ORDER_STATUS_ID IN (0, 5)
         AND or_order.TASK_TYPE_ID IN
             (SELECT ID_TRABCERT FROM ldc_trab_cert)
         AND or_order_activity.product_id = nuprodu;
  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'LDC_REGISTRVISIIDENCERTIXOTREV', cnuNVLTRC);  
        
    OPEN cuBuscaMarca(inuProduct_id);
    FETCH cuBuscaMarca
      INTO sw1;
    IF cuBuscaMarca%NOTFOUND THEN
      sw1 := 0;
    END IF;
    CLOSE cuBuscaMarca;
    IF sw1 = 0 THEN
      OPEN cuBuscaSoli(inuProduct_id);
      FETCH cuBuscaSoli
        INTO sw1;
      IF cuBuscaSoli%NOTFOUND THEN
        sw1 := 0;
      END IF;
      CLOSE cuBuscaSoli;
    END IF;
    IF sw1 = 0 THEN
      OPEN cuInge(inuProduct_id);
      FETCH cuInge
        INTO sw1;
      IF cuInge%NOTFOUND THEN
        sw1 := 0;
      END IF;
      CLOSE cuInge;
    END IF;
    -- Busco si hay diferidos de revisión que se esten pagando
    nusaldodiferido := 0;
    sbaplicaentr    := LDCI_PKREVISIONPERIODICAWEB.fsbAplicaEntrega('OSS_CON_ELAL_200_1607_1');
    IF sbaplicaentr = 'S' THEN
      BEGIN
        SELECT nvl(SUM(difesape), 0)
          INTO nusaldodiferido
          FROM diferido
         WHERE difenuse = inuProduct_id
           AND difeconc IN (739, 755)
           AND difesape >= 1;
      EXCEPTION
        WHEN no_data_found THEN
          nusaldodiferido := 0;
      END;
    ELSE
      nusaldodiferido := 0;
    END IF;
    --  busco el address_id del producto
    IF sw1 = 0 AND nvl(nusaldodiferido, 0) = 0 THEN
      nuAddress_id := dapr_product.fnugetaddress_id(inuProduct_id);
      daab_address.getrecord(nuAddress_id, rcAb_address);
      nuSUBSCRIPTIONID := dapr_product.fnugetSUBSCRIPTION_ID(inuProduct_id);
      nuSUBSCRIBERId   := pktblsuscripc.fnugetsuscclie(nuSUBSCRIPTIONID);
      nuCate           := pktblservsusc.fnugetcategory(inuProduct_id);
      nuSuca           := pktblservsusc.fnugetsesusuca(inuProduct_id);
      -- SE INICIALIZA EL REGISTRO PARA CREAR EL MO_pACKAGES
      sbRequestXML1 := '<?xml version="1.0" encoding="ISO-8859-1"?>
           <P_LDC_SOLICITUD_VISITA_IDENTIFICACION_CERTIFICADO_100237 ID_TIPOPAQUETE="100237">
           <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID>
           <COMMENT_>' || sbComment ||
                       '</COMMENT_>
           <IDENTIFICADOR_DEL_CLIENTE>' ||
                       nuSUBSCRIBERId || '</IDENTIFICADOR_DEL_CLIENTE>
           <M_MOTIVO_VISITA_IDENTIFICACION_CERTIFICADO_100243>
           <PRODUCT_ID>' || inuProduct_id ||
                       '</PRODUCT_ID>
           <SUBSCRIPTION_ID>' || nuSUBSCRIPTIONID ||
                       '</SUBSCRIPTION_ID>
           <ADDRESS>' || rcAb_address.ADDRESS ||
                       '</ADDRESS>
           <PARSER_ADDRESS_ID>' ||
                       rcAb_address.ADDRESS_ID ||
                       '</PARSER_ADDRESS_ID>
           <GEOGRAP_LOCATION_ID>' ||
                       rcAb_address.GEOGRAP_LOCATION_ID ||
                       '</GEOGRAP_LOCATION_ID>
           <CATEGORY_ID>' || nuCate ||
                       '</CATEGORY_ID>
           <SUBCATEGORY_ID>' || nusuca ||
                       '</SUBCATEGORY_ID>
           </M_MOTIVO_VISITA_IDENTIFICACION_CERTIFICADO_100243>
           </P_LDC_SOLICITUD_VISITA_IDENTIFICACION_CERTIFICADO_100237>';
      API_REGISTERREQUESTBYXML(sbRequestXML1,
                                nuPackage_id,
                                nuMotiveId,
                                onuErrorCode,
                                osbErrorMessage);
      IF onuErrorCode = 0 THEN
        -- Verificamos la fecha minima del certificado del producto.
        IF sbaplicaentr = 'S' THEN
          BEGIN
            SELECT pc.plazo_min_revision
              INTO dtplazominrev
              FROM ldc_plazos_cert pc
             WHERE pc.id_producto = inuProduct_id
               AND rownum = 1;
          EXCEPTION
            WHEN no_data_found THEN
              dtplazominrev := to_date('01/01/1900', 'dd/mm/yyyy');
          END;
          IF trunc(SYSDATE) < trunc(dtplazominrev) THEN
            sbaplicamarc := 'N';
          ELSE
            sbaplicamarc := 'S';
          END IF;
        ELSE
          sbaplicamarc := 'S';
        END IF;
        -- Valida que la fecha minima de revisión, sea menor o igual al SYSDATE para que genere marca
        IF sbaplicamarc = 'S' THEN
          UPDATE LDC_MARCA_PRODUCTO
             SET INTENTOS = NVL(INTENTOS, 0) + 1
           WHERE ID_PRODUCTO = inuProduct_id;
          IF SQL%NOTFOUND THEN
            INSERT INTO LDC_MARCA_PRODUCTO
              (ID_PRODUCTO,
               ORDER_ID,
               CERTIFICADO,
               FECHA_ULTIMA_ACTU,
               INTENTOS,
               MEDIO_RECEPCION,
               REGISTER_POR_DEFECTO,
               SUSPENSION_TYPE_ID)
            VALUES
              (inuProduct_id,
               NULL,
               NULL,
               trunc(SYSDATE),
               1,
               'I',
               'N',
               NULL);
          END IF;
        END IF;
      END IF;
    ELSE
      DELETE FROM ldc_otrev WHERE product_id = inuProduct_id;
    END IF;

    ut_trace.trace('creo el tramite'||'-'||nuPackage_id, 10);

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'LDC_REGISTRVISIIDENCERTIXOTREV', cnuNVLTRC);  
       
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END LDC_REGISTRVISIIDENCERTIXOTREV;

  PROCEDURE OBJ_LEG_VISIIDENCERTI IS
    /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : OBJ_LEG_VISIIDENCERTI
    Descripcion    : OBJETO PARA LEGALIZAR LA ACTIVIDAD DE VISITA DE IDENTIFICACION DE CERTIFICADO
    Autor          : Emiro Leyva H.
    Fecha          : 08/05/2014

    Parametros              Descripcion
    ============         ===================
    nuExternalId:


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
     08/05/2014       EMIROL              CREACION
    ******************************************************************/

    nuorderid         or_order.order_id%TYPE;
    nucurractivityid  or_order_activity.order_activity_id%TYPE;
    nuProductId       or_order_activity.product_id%TYPE;
    nuCausa_si_quiere ge_causal.causal_id%TYPE;
    nuCausal          ge_causal.causal_id%TYPE;
    sw1               NUMBER;

    CURSOR cuInge(nuprodu ldc_marca_producto.id_producto%TYPE) IS
      SELECT 1
        FROM or_order, or_order_activity
       WHERE or_order_activity.order_id = or_order.order_id
         AND or_order.ORDER_STATUS_ID IN (0, 5)
         AND or_order.TASK_TYPE_ID IN
             (SELECT ID_TRABCERT FROM ldc_trab_cert)
         AND or_order_activity.product_id = nuprodu;
  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'OBJ_LEG_VISIIDENCERTI', cnuNVLTRC);
      
    ---  orden que se legaliza
    nuorderid := or_bolegalizeorder.fnugetcurrentorder;
    -- Actividad de Orden
    nucurractivityid := ldc_bcfinanceot.fnuGetActivityId(nuorderid);

    -- Obtiene la actividad asociada a la actividad de orden
    IF nuorderid IS NULL THEN
      nuorderid := daor_order_activity.fnugetorder_id(nucurractivityid);
    END IF;
    nuProductId       := daor_order_activity.Fnugetproduct_Id(nucurractivityid);
    nuCausal          := daor_order.fnugetcausal_id(nuorderid);
    nuCausa_si_quiere := Dald_parameter.fnuGetNumeric_Value('CAUSAL_ACEPTA_RP',
                                                            NULL);
    IF nuCausa_si_quiere IS NULL THEN
      pkg_error.setErrorMessage( isbMsgErrr => 
                                       'No existe datos para el parametro CAUSAL_ACEPTA_RP, definalos por el comando LDPAR');
    END IF;
    IF nuCausal = nuCausa_si_quiere THEN
      OPEN cuInge(nuProductId);
      FETCH cuInge
        INTO sw1;
      IF cuInge%NOTFOUND THEN
        sw1 := 0;
      END IF;
      CLOSE cuInge;
      IF sw1 = 1 THEN
        pkg_error.setErrorMessage( isbMsgErrr => 
                                         'Este Producto tiene tramite de Ingenieria certificables en proceso, debe legalizar con la causal "USUARIO ENVIA CERTIFICADO"');
      END IF;
      -- se crea el tramite de revision periodica
      LDC_BOREVIEW.PERIODICREVIEWREGISTER(nuProductId, NULL);
    END IF;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'OBJ_LEG_VISIIDENCERTI', cnuNVLTRC);
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END OBJ_LEG_VISIIDENCERTI;

  FUNCTION fnuProdAplicaGeneNotif(inuProduct_id pr_product.product_id%TYPE)
    RETURN NUMBER IS
    /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : fnuProdAplicaGeneNotif
    Descripcion    : busca si el producto aplica para generale notificacion de revision
                     en las regla de revision periodica
                     se verifica que sea de area exclusiva y la fecha de inicio de la res_creg_059
    Autor          : Emiro Leyva H.
    Fecha          : 14/05/2014

    Parametros              Descripcion
    ============         ===================
    nuExternalId:


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
     08/05/2014       EMIROL              CREACION
    ******************************************************************/

    nuLocalidad ldc_equiva_localidad.geograp_location_id%TYPE;
    nuASE       NUMBER;
  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'fnuProdAplicaGeneNotif', cnuNVLTRC);
   
    nuAse       := 0;
    nuLocalidad := PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTLOCALITY(inuProduct_id);
    nuAse       := fnuGetLocalidadesASE(nuLocalidad);

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'fnuProdAplicaGeneNotif', cnuNVLTRC);
    RETURN(nuAse);
  END fnuProdAplicaGeneNotif;

  PROCEDURE OBJ_LEG_NOTIF_SUSP IS
    /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : OBJ_LEG_NOTIF_SUSP
    Descripcion    : OBJETO PLUGIN PARA LEGALIZAR LA NOTIFICACION DE SUSPENSION POR AUSENCIA DE CERTIFICADO
                     Y GENERAR LA SUSPENSION ADMINISTRATIVA
    Autor          : Emiro Leyva H.
    Fecha          : 08/05/2014

    Parametros              Descripcion
    ============         ===================
    nuExternalId:


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
     26/03/2015       IVANDC              Se ajuste el cursor cuBuscaSoli. Aranda 6899
     08/05/2014       EMIROL              CREACION
    ******************************************************************/
    onuerrorcode     NUMBER;
    osberrormessage  VARCHAR2(4000);
    nuorderid        or_order.order_id%TYPE;
    nucurractivityid or_order_activity.order_activity_id%TYPE;
    nuProductId      or_order_activity.product_id%TYPE;
    nuPackage_id     MO_PACKAGES.PACKAGE_ID%TYPE;
    nuMotiveId       MO_MOTIVE.MOTIVE_ID%TYPE;
    nuSUBSCRIBERId   ge_subscriber.SUBSCRIBER_id%TYPE;
    nuSUBSCRIPTIONID pr_product.SUBSCRIPTION_ID%TYPE;
    nutipoCausal     NUMBER;
    nuCausal         NUMBER;
    fecha_inicio     DATE;
    sbComment        VARCHAR2(2000) := 'SE GENERAN DESDE OBJ_LEG_NOTIF_SUSP)';
    sbRequestXML1    VARCHAR2(32767);
    sw1              NUMBER := 0;
    SW3              NUMBER;
    nuDias           NUMBER;
    nuDias_dif_repa  NUMBER;
    -- Producto a procesar
    inuSUSPENSION_TYPE_ID ldc_marca_producto.SUSPENSION_TYPE_ID%TYPE;

    CURSOR cuMarca(nuProduct ldc_marca_producto.id_producto%TYPE) IS
      SELECT SUSPENSION_TYPE_ID
        FROM ldc_marca_producto
       WHERE ID_PRODUCTO = nuProduct
         AND REGISTER_POR_DEFECTO = 'Y'
         AND SUSPENSION_TYPE_ID IN (102, 103);

    CURSOR cuBuscaSoli(nuprodu ldc_marca_producto.id_producto%TYPE) IS
      SELECT 1
        FROM mo_packages a, ps_motive_status c, mo_motive x
       WHERE a.PACKAGE_TYPE_ID IN
             (SELECT TO_NUMBER(COLUMN_VALUE)
                FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('COD_TIPOS_SOLICITUD_NOTIF_SUSP',
                                                                                         NULL),
                                                        ',')))
         AND c.MOTIVE_STATUS_ID = a.MOTIVE_STATUS_ID
         AND c.MOTI_STATUS_TYPE_ID = 2
         AND c.MOTIVE_STATUS_ID NOT IN (14, 32, 51)
         AND x.PACKAGE_ID = a.PACKAGE_ID
         AND x.PRODUCT_ID = nuprodu
      UNION
      SELECT 1
        FROM or_order, or_order_activity
       WHERE or_order_activity.order_id = or_order.order_id
         AND or_order.ORDER_STATUS_ID IN (0, 5)
         AND or_order.TASK_TYPE_ID IN
             (SELECT ID_TRABCERT FROM ldc_trab_cert)
         AND or_order_activity.product_id = nuprodu;

    CURSOR cuFech(nuprodu ldc_marca_producto.id_producto%TYPE) IS
      SELECT COUNT(1)
        FROM ldc_plazos_cert
       WHERE id_producto = nuprodu
         AND plazo_maximo -
             Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_NOTIFICAR_RP',
                                                NULL) <= SYSDATE
      UNION
      SELECT COUNT(1)
        FROM ldc_marca_producto
       WHERE id_producto = nuprodu
         AND fecha_ultima_actu <= SYSDATE - (nuDias + nuDias_dif_repa)
         AND REGISTER_POR_DEFECTO = 'Y';

  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'OBJ_LEG_NOTIF_SUSP', cnuNVLTRC);
        
    ---  orden que se legaliza
    nuorderid := or_bolegalizeorder.fnugetcurrentorder;
    -- Actividad de Orden
    nucurractivityid := ldc_bcfinanceot.fnuGetActivityId(nuorderid);
    nuDias           := Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO',
                                                           NULL);
    nuDias_dif_repa  := Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_NOTIFICAR_RP_REPA',
                                                           NULL);
    nuProductId      := daor_order_activity.Fnugetproduct_Id(nucurractivityid);
    nuSUBSCRIPTIONID := dapr_product.fnugetSUBSCRIPTION_ID(nuProductId);
    nuSUBSCRIBERId   := pktblsuscripc.fnugetsuscclie(nuSUBSCRIPTIONID);
    nutipoCausal     := Dald_parameter.fnuGetNumeric_Value('TIPO_DE_CAUSAL_SUSP_ADMI',
                                                           NULL);
    OPEN cuBuscaSoli(nuProductId);
    FETCH cuBuscaSoli
      INTO sw1;
    IF cuBuscaSoli%NOTFOUND THEN
      sw1 := 0;
    END IF;
    CLOSE cuBuscaSoli;
    IF sw1 = 1 THEN
      pkg_error.setErrorMessage( isbMsgErrr => 
                                       'Este Producto tiene tramite de revision periodica y/o tramite de Ingenieria certificables en proceso, debe legalizar con la causal "USUARIO CONTACTO PARA ACTUALIZAR CERTIFICADO"');
    END IF;

    IF nutipoCausal IS NULL THEN
      pkg_error.setErrorMessage( isbMsgErrr => 
                                       'No existe datos para el parametro TIPO_DE_CAUSAL_SUSP_ADMI, definalos por el comando LDPAR');
    END IF;
    nuCausal := Dald_parameter.fnuGetNumeric_Value('COD_CAUSA_SUSP_ADM_XML',
                                                   NULL);

    IF nuCausal IS NULL THEN
      pkg_error.setErrorMessage( isbMsgErrr => 
                                       'No existe datos para el parametro COD_CAUSA_SUSP_ADM_XML, definalos por el comando LDPAR');
    END IF;
    inuSUSPENSION_TYPE_ID := 101;
    OPEN cuMarca(nuProductId);
    FETCH cuMarca
      INTO inuSUSPENSION_TYPE_ID;
    IF cuMarca%NOTFOUND THEN
      inuSUSPENSION_TYPE_ID := 101;
    END IF;
    CLOSE cuMarca;
    sw3 := 1;
    OPEN cuFech(nuProductId);
    FETCH cuFech
      INTO sw3;
    IF cuFech%NOTFOUND THEN
      sw3 := 0;
    END IF;
    CLOSE cuFech;
    IF SW3 > 0 THEN
      -- SE INICIALIZA EL REGISTRO PARA CREAR EL MO_pACKAGES de suspension
      fecha_inicio  := SYSDATE + 1 / 24 / 60;
      sbRequestXML1 := '<?xml version="1.0" encoding="ISO-8859-1"?>
                <P_LBC_SUSPENSION_ADMINISTRATIVA_POR_XML_100156 ID_TIPOPAQUETE="100156">
                <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID>
                <CONTACT_ID>' || nuSUBSCRIBERId ||
                       '</CONTACT_ID>
                <ADDRESS_ID></ADDRESS_ID>
                <COMMENT_>' || sbComment ||
                       '</COMMENT_>
                <PRODUCT>' || nuProductId ||
                       '</PRODUCT>
                <FECHA_DE_SUSPENSION>' ||
                       fecha_inicio || '</FECHA_DE_SUSPENSION>
                <TIPO_DE_SUSPENSION>' ||
                       inuSUSPENSION_TYPE_ID ||
                       '</TIPO_DE_SUSPENSION>
                <TIPO_DE_CAUSAL>' || nutipoCausal ||
                       '</TIPO_DE_CAUSAL>
                <CAUSAL_ID>' || nuCausal ||
                       '</CAUSAL_ID>
                </P_LBC_SUSPENSION_ADMINISTRATIVA_POR_XML_100156>';
      API_REGISTERREQUESTBYXML(sbRequestXML1,
                                nuPackage_id,
                                nuMotiveId,
                                onuErrorCode,
                                osbErrorMessage);
      IF onuErrorCode <> 0 THEN
        pkg_error.setErrorMessage( isbMsgErrr => osbErrorMessage );
      END IF;
    END IF;
    
    UT_Trace.Trace('Termina ' || csbSP_NAME || 'OBJ_LEG_NOTIF_SUSP', cnuNVLTRC);
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.SetError;
      RAISE;
    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END OBJ_LEG_NOTIF_SUSP;

  PROCEDURE OBJ_LEG_GENERA_RP IS
    /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : OBJ_LEG_GENERA_RP
    Descripcion    : OOBJETO PLUGIN PARA LEGALIZAR LA NOTIFICACION DE SUSPENSION POR AUSENCIA DE CERTIFICADO
                     Y GENERA LA REVISION PERIODICA.
    Autor          : Emiro Leyva H.
    Fecha          : 08/05/2014

    Parametros              Descripcion
    ============         ===================
    nuExternalId:


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
     08/05/2014       EMIROL              CREACION
    ******************************************************************/
    nuorderid         or_order.order_id%TYPE;
    nucurractivityid  or_order_activity.order_activity_id%TYPE;
    nuProductId       or_order_activity.product_id%TYPE;
    SW1               NUMBER := 0;
    CURSOR cuInge(nuprodu ldc_marca_producto.id_producto%TYPE) IS
      SELECT 1
        FROM or_order, or_order_activity
       WHERE or_order_activity.order_id = or_order.order_id
         AND or_order.ORDER_STATUS_ID IN (0, 5)
         AND or_order.TASK_TYPE_ID IN
             (SELECT ID_TRABCERT FROM ldc_trab_cert)
         AND or_order_activity.product_id = nuprodu
      UNION
      SELECT 1
        FROM mo_packages a, ps_motive_status c, mo_motive x
       WHERE a.PACKAGE_TYPE_ID IN (265, 266)
         AND c.MOTIVE_STATUS_ID = a.MOTIVE_STATUS_ID
         AND c.MOTI_STATUS_TYPE_ID = 2
         AND c.MOTIVE_STATUS_ID NOT IN (14, 32, 51)
         AND x.PACKAGE_ID = a.PACKAGE_ID
         AND x.PRODUCT_ID = nuprodu;
  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'OBJ_LEG_GENERA_RP', cnuNVLTRC);  
      
    ---  orden que se legaliza
    nuorderid := or_bolegalizeorder.fnugetcurrentorder;
    -- Actividad de Orden
    nucurractivityid := ldc_bcfinanceot.fnuGetActivityId(nuorderid);

    nuProductId := daor_order_activity.Fnugetproduct_Id(nucurractivityid);
    OPEN cuInge(nuProductId);
    FETCH cuInge
      INTO sw1;
    IF cuInge%NOTFOUND THEN
      sw1 := 0;
    END IF;
    CLOSE cuInge;
    IF sw1 = 1 THEN
      pkg_error.setErrorMessage( isbMsgErrr => 
                                       'Este Producto tiene tramite de Ingenieria certificables yo tramite de revision periodica en proceso, debe legalizar con la causal "USUARIO CONTACTO PARA ACTUALIZAR CERTIFICADO"');
    END IF;
    -- se crea el tramite de revision periodica
    LDC_BOREVIEW.PERIODICREVIEWREGISTER(nuProductId, NULL);

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'OBJ_LEG_GENERA_RP', cnuNVLTRC);  
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.SetError;
      RAISE;
    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END OBJ_LEG_GENERA_RP;

  PROCEDURE OBJ_LEG_CAUSAL_3341_RP IS
    /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : OBJ_LEG_CAUSAL_3341_RP
    Descripcion    : OOBJETO PLUGIN PARA LEGALIZAR LA NOTIFICACION DE SUSPENSION POR AUSENCIA DE CERTIFICADO
                     Y NO GENERA NINGUN TRAMITE SOLO VALIDA QUE SE USE CUANDO YA SE SOLICITO
                     TRAMITE DE REVISION PERIODICA O TRAMITE DE INGENIERIA.
    Autor          : Emiro Leyva H.
    Fecha          : 08/05/2014

    Parametros              Descripcion
    ============         ===================
    nuExternalId:


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
     26/03/2015       IVANDC              Se ajuste el cursor cuBuscaSoli. Aranda 6899
     08/05/2014       EMIROL              CREACION
    ******************************************************************/
    nuorderid         or_order.order_id%TYPE;
    nucurractivityid  or_order_activity.order_activity_id%TYPE;
    nuProductId       or_order_activity.product_id%TYPE;
    SW1               NUMBER := 0;
    CURSOR cuBuscaSoli(nuprodu ldc_marca_producto.id_producto%TYPE) IS
      SELECT 1
        FROM mo_packages a, ps_motive_status c, mo_motive x
       WHERE a.PACKAGE_TYPE_ID IN
             (SELECT TO_NUMBER(COLUMN_VALUE)
                FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('COD_TIPOS_SOLICITUD_NOTIF_SUSP',
                                                                                         NULL),
                                                        ',')))
         AND c.MOTIVE_STATUS_ID = a.MOTIVE_STATUS_ID
         AND c.MOTI_STATUS_TYPE_ID = 2
         AND c.MOTIVE_STATUS_ID NOT IN (14, 32, 51)
         AND x.PACKAGE_ID = a.PACKAGE_ID
         AND x.PRODUCT_ID = nuprodu
      UNION
      SELECT 1
        FROM or_order, or_order_activity
       WHERE or_order_activity.order_id = or_order.order_id
         AND or_order.ORDER_STATUS_ID IN (0, 5)
         AND or_order.TASK_TYPE_ID IN
             (SELECT ID_TRABCERT FROM ldc_trab_cert)
         AND or_order_activity.product_id = nuprodu;
  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'OBJ_LEG_CAUSAL_3341_RP', cnuNVLTRC);  
        
    ---  orden que se legaliza
    nuorderid := or_bolegalizeorder.fnugetcurrentorder;
    -- Actividad de Orden
    nucurractivityid := ldc_bcfinanceot.fnuGetActivityId(nuorderid);

    nuProductId := daor_order_activity.Fnugetproduct_Id(nucurractivityid);
    OPEN cuBuscaSoli(nuProductId);
    FETCH cuBuscaSoli
      INTO sw1;
    IF cuBuscaSoli%NOTFOUND THEN
      sw1 := 0;
    END IF;
    CLOSE cuBuscaSoli;
    IF sw1 <> 1 THEN
      pkg_error.setErrorMessage( isbMsgErrr => 
                                       'Para utilizar esta causal se requiere que el Producto tenga tramite de revision periodica y/o' ||
                                       ' Tramite de Ingenieria certificables en proceso, debe legalizar con la causal "USUARIO CONTACTO PARA ACTUALIZAR CERTIFICADO"');
    END IF;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'OBJ_LEG_CAUSAL_3341_RP', cnuNVLTRC);  

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.SetError;
      RAISE;
    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END OBJ_LEG_CAUSAL_3341_RP;
  PROCEDURE PROSUSPCOMPONENTE(inuProduct_id IN pr_product.product_id%TYPE,
                              inuSuspTypeId IN pr_comp_suspension.suspension_type_id%TYPE) IS
    /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : PROSUSPCOMPONENTE
    Descripcion    : METODO PARA SUSPENDER LOS COMPONENTES DE UN PRODUCTO
    Autor          : Emiro Leyva H.
    Fecha          : 26/06/2014

    Parametros              Descripcion
    ============         ===================
    nuExternalId:


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================

    ******************************************************************/
    CURSOR CuComponent(nuProducto IN pr_product.product_id%TYPE) IS

      SELECT a.*, a.ROWID
        FROM Pr_Component a
       WHERE a.Product_Id = nuProducto
         AND EXISTS
       (SELECT 'X'
                FROM Ps_Product_Status c
               WHERE c.Product_Status_Id = a.Component_Status_Id
                 AND c.Is_Active_Product = GE_BOConstants.csbYES);
  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'PROSUSPCOMPONENTE', cnuNVLTRC);  
        
    FOR rcComponent IN CuComponent(inuProduct_id) LOOP
      rcComponent.component_status_id := PR_BOPARAMETER.fnuGetCOMPSUSP;
      rcComponent.last_upd_date       := ut_date.fdtSysdate;
      dapr_component.updRecord(rcComponent);
      IF (dage_suspension_type.fsbGetDirectionality_id(inuSuspTypeId) <> 'IN') THEN
        DACompsesu.Updcmssescm(rcComponent.component_id,
                               PR_BOParameter.fnuGetCOMPSUSP);
      END IF;
    END LOOP;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'PROSUSPCOMPONENTE', cnuNVLTRC);  
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.SetError;
      RAISE;
    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;

  END PROSUSPCOMPONENTE;

  PROCEDURE PROATIENDESUSPRP_PLUGI IS
    /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : PROATIENDESUSPRP_PLUGI
    Descripcion    : Plugin de legalización para el tipo de trabajo de Aceptación de Certificación
                     que deja al producto suspendido por no dejar hacer la certificación por las LDC.
    Autor          : Emiro Leyva H.
    Fecha          : 29/05/2014

    Parametros              Descripcion
    ============         ===================
    nuExternalId:


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================

    ******************************************************************/
    -- Actividad de Orden
    nuOrderActivity  or_order_activity.order_activity_id%TYPE;
    nuProduct        or_order_activity.product_id%TYPE;
    nuSuspensionType ge_suspension_type.suspension_type_id%TYPE;
    nuorderid        or_order.order_id%TYPE;

  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'PROATIENDESUSPRP_PLUGI', cnuNVLTRC);  

    --Obtener la actividad que se esta legalizando
    ---  orden que se legaliza
    nuorderid       := or_bolegalizeorder.fnugetcurrentorder;
    nuOrderActivity := ldc_bcfinanceot.fnuGetActivityId(nuorderid);
    -- Obtiene el producto
    nuProduct := daor_order_activity.Fnugetproduct_Id(nuOrderActivity);

    -- Obtiene el tipo de suspension
    nuSuspensionType := Dald_parameter.fnuGetNumeric_Value('SUSPENSION_TYPE_CERTI',
                                                           NULL);

    IF nuSuspensionType IS NULL THEN
      pkg_error.setErrorMessage( isbMsgErrr => 
                                       'Typo de suspension no valido, esta nulo');
    END IF;
    -- se cambia el estado pendiente de instalacion a ACTIVO
    dapr_product.Updproduct_Status_Id(nuProduct,
                                      PR_BOParameter.fnuGetPRODACTI);
    mo_bosuspension.regadminsuspension(nuOrderActivity, nuSuspensionType);
    PROSUSPCOMPONENTE(nuProduct, nuSuspensionType);
    -- Actualiza la ultima actividad de orden legalizada por suspension de un producto
    dapr_product.updsuspen_ord_act_id(nuProduct, nuOrderActivity);
    INSERT INTO LDC_MARCA_PRODUCTO
      (ID_PRODUCTO,
       ORDER_ID,
       CERTIFICADO,
       FECHA_ULTIMA_ACTU,
       INTENTOS,
       MEDIO_RECEPCION,
       REGISTER_POR_DEFECTO,
       SUSPENSION_TYPE_ID)
    VALUES
      (nuProduct,
       nuorderid,
       NULL,
       trunc(SYSDATE),
       1,
       'I',
       'Y',
       nuSuspensionType);

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'PROATIENDESUSPRP_PLUGI', cnuNVLTRC);  
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.SetError;
      RAISE;
    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END PROATIENDESUSPRP_PLUGI;

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : prFinanceOtCerti
    Descripcion    : Procedimiento donde se implementa la logica para financiar actividades
                     durante la legalizacion de la orden de certificacion (PLUGIN).
    Autor          : Emiro leyva
    Fecha          : 10/06/2014

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    02-09-2014       Sayra Ocoró     Aranda 4723: Se modifica el procedimiento para que valide la existencia
                                                  de la orden 10500 dentro de la soliciud.
  ******************************************************************/

  PROCEDURE prFinanceOtCerti IS
    -- Actividad de Orden
    rcSalesFinanCond     DACC_Sales_Financ_Cond.styCC_Sales_Financ_Cond;
    nuInterestPerc       cc_Sales_Financ_Cond.interest_percent%TYPE;
    rcFinanPlan          plandife%ROWTYPE;
    onuFinanPlanId       plandife.pldicodi%TYPE;
    onuQuotasNumber      plandife.pldicuma%TYPE;
    nuAtrribute_id       ge_attributes.ATTRIBUTE_ID%TYPE;
    sbaditionalattribute or_temp_data_values.data_value%TYPE;
    nuOrderId            or_order.order_id%TYPE;
    nuPackageID          mo_packages.package_id%TYPE;
    nuOrderActivity      or_order_activity.order_activity_id%TYPE;
    nuItem_id            or_order_activity.activity_id%TYPE;
    nuCount              NUMBER := 0;
    nutask_type_id       or_order.task_type_id%TYPE;
    nuConcepto           or_task_type.concept%TYPE;
    nuPackageTypeId      ps_package_type.package_type_id%TYPE;
    nuPRODUCT_ID         or_order_activity.product_id%TYPE;
    onuerrorcode         NUMBER;
    osberrormessage      VARCHAR2(4000);
    dtfechAsigna         or_order.assigned_date%TYPE;
    nuCate               pr_product.category_id%TYPE;
    onuIdListaCosto      ge_unit_cost_ite_lis.list_unitary_cost_id%TYPE;
    onuCostoItem         ge_unit_cost_ite_lis.price%TYPE;
    onuPrecioVentaItem   ge_unit_cost_ite_lis.sales_value%TYPE;

    nuCausalId      ge_causal.causal_id%TYPE;
    nuCausalClassId ge_class_causal.class_causal_id%TYPE;
    nuAddressId     or_order_activity.address_id%TYPE;
    --Cursor para validar la existencia de orden de tipo de trabajo 10500
    ---en un trámite de ventas
    CURSOR cuOrder10500(inuPackageId mo_packages.package_id%TYPE,
                        inuAddressId or_order_activity.address_id%TYPE) IS
      SELECT COUNT(*)
        FROM or_order_activity
       WHERE package_id = inuPackageId
         AND task_type_id = 10500
         AND address_id = inuAddressId;

  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'prFinanceOtCerti', cnuNVLTRC);  

    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuOrderId       := or_bolegalizeorder.fnuGetCurrentOrder;
    nuOrderActivity := ldc_bcfinanceot.fnuGetActivityId(nuorderid);
    ut_trace.trace('Ejecucion LDCI_PKREVISIONPERIODICAWEB.prFinanceOtCerti => nuOrderId=>' ||
                   nuOrderId,
                   10);
    --Obtener causal de legalizacion
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
    ut_trace.trace('Ejecucion LDCI_PKREVISIONPERIODICAWEB.prFinanceOtCerti => nuCausalId=>' ||
                   nuCausalId,
                   10);
    --Obtener tipo de causal
    nuCausalClassId := dage_causal.fnugetclass_causal_id(nuCausalId);
    ut_trace.trace('Ejecucion LDCI_PKREVISIONPERIODICAWEB.prFinanceOtCerti => nuCausalClassId=>' ||
                   nuCausalClassId,
                   10);
    --Obtener identificador de la solicitud
    nuPackageID  := daor_order_activity.Fnugetpackage_Id(nuOrderActivity);
    nuPRODUCT_ID := daor_order_activity.Fnugetproduct_Id(nuOrderActivity);
    nuAddressId  := daor_order_activity.Fnugetaddress_Id(nuOrderActivity);
    ut_trace.trace('Ejecucion LDCI_PKREVISIONPERIODICAWEB.prFinanceOtCerti => inuPackageID=>' ||
                   nuPackageID,
                   10);
    OPEN cuOrder10500(nuPackageID, nuAddressId);
    FETCH cuOrder10500
      INTO nuCount;
    CLOSE cuOrder10500;
    nuPackageTypeId := damo_packages.fnugetpackage_type_id(nuPackageID);

    --VALIDAR SI LA CAUSAL DE LEGALIZACION ES EXITOSA
    IF nuPackageTypeId != 323 AND nuCausalClassId = 1 AND nuCount > 0 THEN
      
      IF nuPackageID IS NULL OR nuPackageID = -1 THEN
        pkg_error.setErrorMessage( isbMsgErrr => 
                                         'No existe una solicitud asociada a la orden ' ||
                                         nuOrderId);
      END IF;

      nutask_type_id := daor_order.fnugettask_type_id(nuOrderId);
      dtfechAsigna   := SYSDATE;
      nuConcepto     := daor_task_type.fnugetconcept(nutask_type_id);
      IF nuConcepto IS NULL OR nuConcepto = -1 THEN
        pkg_error.setErrorMessage( isbMsgErrr => 
                                         'El tipo de trabajo no tiene el concepto definido ' ||
                                         nutask_type_id);
      END IF;
      -- busco la categoria del producto para asignar el item
      -- con el que se debe cobrar la certificacion
      nuCate := dapr_product.Fnugetcategory_Id(nuPRODUCT_ID);
      IF nucate = 1 THEN
        nuItem_id := Dald_parameter.fnuGetNumeric_Value('COD_ITEM_CERTIF_RESID',
                                                        NULL);
        IF nuItem_id IS NULL THEN
          pkg_error.setErrorMessage( isbMsgErrr => 
                                           'El parametro del item para el cobro de la certificacion a categoria RESIDENCIAL ' ||
                                           'aun no esta definido. Revise por LDPAR el parametro "COD_ITEM_CERTIF_RESID"');
        END IF;
      ELSE
        nuItem_id := Dald_parameter.fnuGetNumeric_Value('COD_ITEM_CERTIF_COMERC',
                                                        NULL);
        IF nuItem_id IS NULL THEN
          pkg_error.setErrorMessage( isbMsgErrr => 
                                           'El parametro del item para el cobro de la certificacion a categoria COMERCIAL ' ||
                                           'aun no esta definido. Revise por LDPAR el parametro "COD_ITEM_CERTIF_COMERC"');
        END IF;
      END IF;
      -- busco el id del atributo del plan de financiacion
      SELECT ATTRIBUTE_ID
        INTO nuAtrribute_id
        FROM ge_attributes
       WHERE NAME_ATTRIBUTE = 'PLAN_ACUERDO_PAGO_CERTIF';
      sbaditionalattribute := LDC_BOORDENES.fsbDatoAdicTmpOrden(nuorderid,
                                                                nuAtrribute_id,
                                                                'PLAN_ACUERDO_PAGO_CERTIF');
      onuFinanPlanId       := TO_NUMBER(sbaditionalattribute);
      -- busco el id del atributi del numero de cuotas
      SELECT ATTRIBUTE_ID
        INTO nuAtrribute_id
        FROM ge_attributes
       WHERE NAME_ATTRIBUTE = 'NUM_CUOTAS_FINANC_CERTIF';
      -- busco el valor del dato adicional para la cuota
      sbaditionalattribute := LDC_BOORDENES.fsbDatoAdicTmpOrden(nuorderid,
                                                                nuAtrribute_id,
                                                                'NUM_CUOTAS_FINANC_CERTIF');
      onuQuotasNumber      := TO_NUMBER(sbaditionalattribute);
      --Validar si existe una configuracio aplicable
      IF onuFinanPlanId IS NULL OR onuQuotasNumber IS NULL THEN
        pkg_error.setErrorMessage( isbMsgErrr => 
                                         'No se ha digitado los datos adicionales para el Plan de financiacion o la cuota inicial');
      END IF;
      IF onuFinanPlanId <> -1 THEN
        IF onuQuotasNumber = 0 THEN
          pkg_error.setErrorMessage( isbMsgErrr => 
                                           'El numero de la cuota no puede ser cero ');
        END IF;
      END IF;
      GE_BCCertContratista.ObtenerCostoItemLista(nuItem_id,
                                                 dtfechAsigna,
                                                 NULL,
                                                 NULL,
                                                 NULL,
                                                 NULL,
                                                 onuIdListaCosto,
                                                 onuCostoItem,
                                                 onuPrecioVentaItem);
      IF onuPrecioVentaItem > 0 THEN
        -- genera el cargo
        API_CREACARGOS(nuPRODUCT_ID,
                        nuConcepto,
                        0,
                        53,
                        onuPrecioVentaItem,
                        'PP-' || nuPackageID,
                        NULL,
                        onuerrorcode,
                        osberrormessage);
        IF (onuErrorCode <> 0) THEN
          pkg_error.setErrorMessage( isbMsgErrr => osberrormessage );
        END IF;
        --Generar una factura con los cargos a la cuenta de cobro -1 generados por la legalizacion de la orden (estos se identifican
        --porque en la tabla CARGOS, en la tabla CARGDOSO tienen el prefijo "PP" mas el numero de la solicitud), usando el metodo:
        --Donde inuPackageID es un parametro de entrada que hace referencia al numero de la solicitud padre de la orden de trabajo
        CC_BOACCOUNTS.GENERATEACCOUNTBYPACK(nuPackageID);
        IF onuFinanPlanId <> -1 THEN
          --Obtiene la informacion del plan
          rcFinanPlan := pkTblPlandife.frcGetRecord(onuFinanPlanId);
          --Obtiene el porcentaje de interes
          nuInterestPerc := fnuGetInterestRate(rcFinanPlan.plditain,
                                               SYSDATE);
          ut_trace.trace('Ejecucion LDCI_PKREVISIONPERIODICAWEB.prFinanceOtCerti => nuInterestPerc =>' ||
                         nuInterestPerc,
                         10);
          --Actualiza los campos CC_SALES_FINANC_COND
          rcSalesFinanCond.package_id          := nuPackageID;
          rcSalesFinanCond.financing_plan_id   := onuFinanPlanId;
          rcSalesFinanCond.compute_method_id   := pktblplandife.fnugetpaymentmethod(onuFinanPlanId);
          rcSalesFinanCond.interest_rate_id    := pktblplandife.fnugetinterestratecod(onuFinanPlanId);
          rcSalesFinanCond.first_pay_date      := SYSDATE;
          rcSalesFinanCond.percent_to_finance  := 100;
          rcSalesFinanCond.interest_percent    := nuInterestPerc;
          rcSalesFinanCond.spread              := 0;
          rcSalesFinanCond.quotas_number       := onuQuotasNumber;
          rcSalesFinanCond.tax_financing_one   := 'N';
          rcSalesFinanCond.value_to_finance    := onuPrecioVentaItem;
          rcSalesFinanCond.document_support    := 'OR-' || nuOrderId;
          rcSalesFinanCond.initial_payment     := 0;
          rcSalesFinanCond.average_quote_value := 0;

          --Validar si para la solicitud ya se definieron conticiones de financiacion
          IF NOT dacc_sales_financ_cond.fblexist(nuPackageID) THEN
            --Inserta la informacion de las condiciones
            DACC_Sales_Financ_Cond.insrecord(rcSalesFinanCond);
          ELSE
            --Actualizar la informacion de las condiciones
            DACC_Sales_Financ_Cond.Updrecord(rcSalesFinanCond);
          END IF;

          --Realizar la financiacion de la factura mediante el metodo:
          --Donde inuPackageID es un parametro de entrada que hace referencia al numero de la solicitud padre de la orden de trabajo
          --y onuFinanId es el numero de la financiacion generada.
          cc_bofinancing.financingorder(nuPackageID);
        END IF;
      ELSE
        pkg_error.setErrorMessage( isbMsgErrr => 
                                         'El Precio de Venta del Item es CERO, Verifique el Valor y/o la Vigencia de la Lista de Precio para el Item ' ||
                                         nuItem_id);
      END IF;
    END IF;
    
    UT_Trace.Trace('Termina ' || csbSP_NAME || 'prFinanceOtCerti', cnuNVLTRC);      

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.SetError;
      RAISE;
    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END prFinanceOtCerti;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del Paquete: sbAplicaEntrega
  Descripcion:        Indica si la entrega aplica para la gasera

  Autor : Sandra Muñoz
  Fecha : 02-09-2015 Aranda 8495

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  02-09-2015    Sandra Muñoz          Creacion
  ******************************************************************/
  FUNCTION fsbAplicaEntrega(isbEntrega VARCHAR2) RETURN CHAR IS
    blGDO      BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaGDO(isbEntrega);
    blEFIGAS   BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaEfigas(isbEntrega);
    blSURTIGAS BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaSurtigas(isbEntrega);
    blGDC      BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaGDC(isbEntrega);
  BEGIN
    -- Valida si la entrega aplica para la gasera
    IF blGDO = TRUE OR blEFIGAS = TRUE OR blSURTIGAS = TRUE OR blGDC = TRUE THEN
      RETURN 'S';
    ELSE
      RETURN 'N';
    END IF;
  END fsbAplicaEntrega;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : fnuOtAceptacionCertificado
  Descripcion    : busca si el producto tiene orde de rechazo de aceptacion
                 : de certificado al momento de la venta
  Autor          : Emiro Leyva H.
  Fecha          : 20/06/2014

  Parametros              Descripcion
  ============         ===================
  nuExternalId:


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
   05-09-2015     Sandra Muñoz        ARA8657. Se aplica un ordenamiento descendente
                                      a las ordenes se la solicitud para
                                      obtener la causal mas reciente
   08/05/2014       EMIROL              CREACION
  ******************************************************************/

  FUNCTION fnuOtAceptacionCertificado(inuPackage_id IN mo_packages.package_Id%TYPE,
                                      inuAddressId  IN or_order_activity.address_id%TYPE)
    RETURN NUMBER IS

    nuCausalClassId ge_class_causal.class_causal_id%TYPE;
    nuCausal        ge_causal.causal_id%TYPE;
    dtFecha_vige    DATE;
    dtFecha_Package DATE;
    CURSOR cuOtAcepta(nupackageId IN mo_packages.package_id%TYPE,
                      nuAddressId IN or_order_activity.address_id%TYPE) IS
      SELECT nvl(b.causal_id, 0)
        FROM or_order_activity a, or_order b
       WHERE a.task_type_id = 10500
         AND b.order_id = a.order_id
         AND b.order_status_id = 8
         AND a.package_id = nupackageId
         AND a.address_id = nuAddressId;

    CURSOR cuOtInspe(nupackageId IN mo_packages.package_id%TYPE,
                     isbOrdena CHAR) IS
      SELECT nvl(b.causal_id, 0)
        FROM or_order_activity a, or_order b
       WHERE a.task_type_id IN
             (Dald_parameter.fnuGetNumeric_Value('COD_INSP_CERT_TASK_TYPE',
                                                 NULL),
              Dald_parameter.fnuGetNumeric_Value('COD_TASK_TYPE_INSP_CERT_TRAB_A',
                                                 NULL))
         AND b.order_id = a.order_id
         AND b.order_status_id = 8
         AND a.package_id = nupackageId
       ORDER BY CASE
                  WHEN isbOrdena = 'S' THEN
                   b.legalization_date
                END DESC,
                CASE
                  WHEN isbOrdena = 'N' THEN
                   nvl(b.causal_id, 0)
                END;

  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'fnuOtAceptacionCertificado', cnuNVLTRC);  
        
    dtFecha_vige := Dald_parameter.fsbGetValue_Chain('LIVE_DEPARTURE_DATE_PR',
                                                     NULL);
    BEGIN
      OPEN cuOtAcepta(inuPackage_id, inuAddressId);
      FETCH cuOtAcepta
        INTO nuCausal;
      IF cuOtAcepta%NOTFOUND THEN
        nuCausal := 0;
      END IF;
      CLOSE cuOtAcepta;
    EXCEPTION
      WHEN no_data_found THEN
        CLOSE cuOtAcepta;
        nuCausal := 0;
    END;
    IF nuCausal = 0 THEN
      BEGIN
        OPEN cuOtInspe(inuPackage_id, fsbAplicaEntrega('OSS_SMS_ARA_8657'));
        FETCH cuOtInspe
          INTO nuCausal;
        IF cuOtInspe%NOTFOUND THEN
          nuCausal := 0;
        END IF;
        CLOSE cuOtInspe;
      EXCEPTION
        WHEN no_data_found THEN
          CLOSE cuOtInspe;
          nuCausal := 0;
      END;
    END IF;
    dtFecha_Package := damo_packages.fdtgetrequest_date(inuPackage_id);
    IF nuCausal = 0 THEN
      IF trunc(dtFecha_Package) > dtFecha_vige THEN
        RETURN(0);
      ELSE
        RETURN(1);
      END IF;
    END IF;
    nuCausalClassId := dage_causal.fnugetclass_causal_id(nuCausal);

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'fnuOtAceptacionCertificado', cnuNVLTRC);  
       
    --VALIDAR SI LA CAUSAL DE LEGALIZACION ES EXITOSA
    IF nuCausalClassId = 1 THEN
      RETURN(1);
    END IF;
    RETURN(2);
  EXCEPTION
    WHEN no_data_found THEN
      RETURN(0);
  END fnuOtAceptacionCertificado;

  PROCEDURE OBJ_LEG_REGISTERCERTIFICATE IS
    /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : OBJ_LEG_REGISTERCERTIFICATE
    Descripcion    : OOBJETO PARA LEGALIZAR LAS ORDENES DE CARGO X CONEXION
                     Y GENERAR LA CERTIFICACION SI EL USUARIO ACEPTA.
    Autor          : Emiro Leyva H.
    Fecha          : 20/06/2014

    Parametros              Descripcion
    ============         ===================
    nuExternalId:


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
     08/05/2014       EMIROL              CREACION
     25/02/2015       KAREMB              Se modifica para agregarle el parametro <<COD_ACT_CXC>>
                                          con las actividades de cargo por conexion
     11/08/2015       ivandc              Se crea validacion para productos que fueron certificados
                                          por independientes. Aranda 8477
    ******************************************************************/
    nuorderid        or_order.order_id%TYPE;
    nucurractivityid or_order_activity.order_activity_id%TYPE;
    nupackageId      or_order_activity.package_id%TYPE;
    nuOk             NUMBER;
    nuActividad_id   ge_items.items_id%TYPE;
    nuCausalId       GE_CAUSAL.CAUSAL_ID%TYPE;
    nuAddressId      or_order_activity.address_id%TYPE;

    nuExisteSolictud NUMBER;
  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'OBJ_LEG_REGISTERCERTIFICATE', cnuNVLTRC);  

    ---  orden que se legaliza
    nuorderid  := or_bolegalizeorder.fnugetcurrentorder;
    nuCausalId := daor_order.fnugetcausal_id(nuorderid);
    -- Actividad de Orden
    nucurractivityid := ldc_bcfinanceot.fnuGetActivityId(nuorderid);
    nupackageId      := daor_order_activity.fnugetpackage_id(nucurractivityid);

    nuAddressId := daor_order_activity.fnugetaddress_id(nucurractivityid);


    BEGIN
      SELECT COUNT(*)
        INTO nuExisteSolictud
        FROM LDC_PROD_CERT_INDEP
       WHERE package_id = nupackageId;

    EXCEPTION
      WHEN OTHERS THEN
        nuExisteSolictud := 0;
    END;

    ut_trace.trace('LDCI_PKREVISIONPERIODICAWEB.OBJ_LEG_REGISTERCERTIFICATE => nuExisteSolictud => ' ||
                   nuExisteSolictud,
                   10);

    -- Se valida que la solicitud no exista en la tabla de control
    IF nuExisteSolictud = 0 THEN

      nuActividad_id := daor_order_activity.fnugetactivity_id(nucurractivityid);
      nuOk           := fnuOtAceptacionCertificado(nupackageId, nuAddressId);
      IF nuOk = 0 THEN
        pkg_error.setErrorMessage( isbMsgErrr => 
                                         'La orden de Aceptacion de Certificado debe ser legalizada primero');
      END IF;
      IF nuOk = 1
         AND instr(',' || dald_parameter.fsbGetValue_Chain('COD_ACT_CXC') || ',',
                   ',' || to_char(nuActividad_id) || ',') > 0 AND
         instr(',' || dald_parameter.fsbGetValue_Chain('CAUSAL_TO_CERTIFY') || ',',
               ',' || to_char(nuCausalId) || ',') > 0 THEN
        OR_BOOBJACTUTILITIES.REGISTERCERTIFICATE;
      END IF;

    END IF;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'OBJ_LEG_REGISTERCERTIFICATE', cnuNVLTRC);  
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.SetError;
      RAISE;
    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END OBJ_LEG_REGISTERCERTIFICATE;
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuTipoSuspension
    Descripcion    : funcion que busca el tipo de funcion de la tabla ldc_marca_producto
                     si no existe el registro devuelve 101, se usa en una lista de valor
                     para la legalizacion de la orden de suspension.acion (PLUGIN).
    Autor          : Emiro leyva
    Fecha          : 02/07/2014

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

  FUNCTION fnuTipoSuspension(inuProduct_id IN pr_product.product_Id%TYPE)
    RETURN NUMBER IS

    nutipoSuspe LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID%TYPE;

    CURSOR cuDatos(nuProduct_id IN pr_product.product_Id%TYPE) IS
      SELECT nvl(SUSPENSION_TYPE_ID, 101)
        FROM LDC_MARCA_PRODUCTO
       WHERE ID_PRODUCTO = nuProduct_id;

  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'fnuTipoSuspension', cnuNVLTRC);  
        
    OPEN cuDatos(inuProduct_id);
    FETCH cuDatos
      INTO nutipoSuspe;
    IF cuDatos%NOTFOUND THEN
      CLOSE cuDatos;
      RETURN(101);
    END IF;
    CLOSE cuDatos;
    
    UT_Trace.Trace('Termina ' || csbSP_NAME || 'fnuTipoSuspension', cnuNVLTRC);  
            
    RETURN(nutipoSuspe);
  EXCEPTION
    WHEN no_data_found THEN
      RETURN(101);
  END fnuTipoSuspension;

  PROCEDURE PrSuspProdWithOutCertificate(inuProductId IN pr_product.product_Id%TYPE) IS
    curfComponents   Constants.tyRefCursor;
    rcComponent      DAPR_Component.styPR_Component;
    CURSOR cuProdSuspension(inuProductId NUMBER) IS
      SELECT COUNT(*)
        FROM pr_prod_suspension
       WHERE pr_prod_suspension.product_id = inuProductId;
  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'PrSuspProdWithOutCertificate', cnuNVLTRC);  
    
    dapr_product.updproduct_status_id(inuProductId,
                                      PR_BOParameter.fnuGetPRODSUSP);

    curfComponents := PR_BCComponent.frfGetComponentsByProductId(inuProductId);
    LOOP
      FETCH curfComponents
        INTO rcComponent;
      EXIT WHEN curfComponents%NOTFOUND;

      dapr_Component.updcomponent_status_id(rcComponent.component_id,
                                            PR_BOParameter.fnugetCOMPSUSP);
    END LOOP;
    CLOSE curfComponents;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'PrSuspProdWithOutCertificate', cnuNVLTRC);  
   
  END PrSuspProdWithOutCertificate;
  PROCEDURE prGenMarcaProdByCerti IS
    nuOrderId         or_order.order_id%TYPE;
    nuOrderActivityId or_order_activity.order_activity_id%TYPE;
    nuProductId       pr_product.product_id%TYPE;
    dtLegalizeRP      DATE;
    nuIntentos        NUMBER := 0;
    nuCausalId        ge_causal.causal_id%TYPE;
    nuCausalClassId   ge_class_causal.class_causal_id%TYPE;
    nuPackage_id      mo_packages.package_id%TYPE;
    nuPackageTypeId   mo_packages.package_type_id%TYPE;
    nuOt              or_order.order_id%TYPE;
  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'prGenMarcaProdByCerti', cnuNVLTRC);  
   
    --Obtener orden de la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    --Obtener causal
    nuCausalId        := daor_order.fnugetcausal_id(nuOrderId);
    nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
    --Obtener identificador del producto
    nuProductId := daor_order_activity.fnugetproduct_id(nuOrderActivityId);
    --OBTENER LA SOLICITUD
    nuPackage_id := daor_order_activity.Fnugetpackage_Id(nuOrderActivityId);
    -- busco el tipo de paquete
    nuPackageTypeId := damo_packages.fnugetpackage_type_id(nuPackage_id);
    -- OBTENER LA CLASE DE CAUSAL
    nuCausalClassId := dage_causal.fnugetclass_causal_id(nuCausalId);
    --VALIDAR SI LA CAUSAL DE LEGALIZACION ES DE FALLO PARA MARCAR EL PRODUCTO
    IF nuCausalClassId = 2 THEN
      nuOt := LDCI_PKREVISIONPERIODICAWEB.fnuGetOtUltimaRP(nuProductId);
      IF nuOt IS NULL THEN
        dtLegalizeRP := trunc(SYSDATE);
      ELSE
        dtLegalizeRP := daor_order.fdtgetlegalization_date(nuOt);
      END IF;

      --Validar la existencia de la marcar del producto
      IF daldc_marca_producto.fblExist(nuProductId) THEN
        nuIntentos := daldc_marca_producto.fnuGetINTENTOS(nuProductId);
        nuIntentos := nuIntentos + 1;
        daldc_marca_producto.updFECHA_ULTIMA_ACTU(nuProductId,
                                                  dtLegalizeRP);
        daldc_marca_producto.updINTENTOS(nuProductId, nuIntentos);
        IF nuPackageTypeId NOT IN (100014, 100153) THEN
          daldc_marca_producto.updORDER_ID(nuProductId, nuOrderId);
        END IF;
        daldc_marca_producto.updREGISTER_POR_DEFECTO(nuProductId, 'Y');
        daldc_marca_producto.updMEDIO_RECEPCION(nuProductId, 'I');
        daldc_marca_producto.updSUSPENSION_TYPE_ID(nuProductId, 103);
      ELSE
        INSERT INTO ldc_marca_producto
          (id_producto,
           order_id,
           certificado,
           fecha_ultima_actu,
           intentos,
           medio_recepcion,
           register_por_defecto,
           suspension_type_id)
        VALUES
          (nuProductId, nuOrderId, NULL, dtLegalizeRP, 1, 'I', 'Y', 103);
      END IF;

    END IF;
    
    UT_Trace.Trace('Termina ' || csbSP_NAME || 'prGenMarcaProdByCerti', cnuNVLTRC);  
            
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END prGenMarcaProdByCerti;

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbIsProductCertified
    Descripcion    : funcion que busca si el producto esta certificado DEVUELVE 'Y'
    Autor          : Emiro leyva
    Fecha          : 06/08/2014

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

  FUNCTION fsbIsProductCertified(inuProduct_id IN pr_product.product_Id%TYPE)
    RETURN VARCHAR2 IS

    dtfechCerti LDC_PLAZOS_CERT.PLAZO_MIN_REVISION%TYPE;

    CURSOR cuDatos(nuProduct_id IN pr_product.product_Id%TYPE) IS
      SELECT trunc(PLAZO_MIN_REVISION) PLAZO_MIN_REVISION
        FROM ldc_plazos_cert
       WHERE id_producto = nuProduct_id;

  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'fsbIsProductCertified', cnuNVLTRC);  
        
    OPEN cuDatos(inuProduct_id);
    FETCH cuDatos
      INTO dtfechCerti;
    IF cuDatos%NOTFOUND THEN
      dtfechCerti := trunc(SYSDATE);
    END IF;
    CLOSE cuDatos;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'fsbIsProductCertified', cnuNVLTRC);  
        
    IF trunc(SYSDATE) < dtfechCerti AND
       NOT (daldc_marca_producto.fblExist(inuProduct_id)) THEN
      RETURN('Y');
    ELSE
      RETURN('N');
    END IF;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN('N');
  END fsbIsProductCertified;

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : prValidate10500
    Descripcion    : Procedimiento para validar la ejecución o legalización de instalaciones de
                     interna o cargos por conexión en trámite de ventas antes de legalizar
                     la visita de aceptación de certificado 10500.
    Autor          : Sayra Ocoró
    Fecha          : 01/09/2014

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
  PROCEDURE prValidate10500 IS

    nuOrderId       or_order.order_id%TYPE;
    nuCausalId      ge_causal.causal_id%TYPE;
    nuCausalClassId ge_causal.class_causal_id%TYPE;
    CURSOR cuOrder(inuPackageId  mo_packages.package_id%TYPE,
                   inuTaskTypeId or_task_type.task_type_id%TYPE) IS
      SELECT order_id
        FROM or_order_activity
       WHERE package_id = inuPackageId
         AND task_type_id = inuTaskTypeId;

    nuOrderActivityId or_order_activity.order_activity_id%TYPE;
    nuPackageId       mo_packages.package_id%TYPE;
    nuPackageTypeId   ps_package_type.package_type_id%TYPE;

  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'prValidate10500', cnuNVLTRC);  

    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('Ejecucion LDCI_PKREVISIONPERIODICAWEB.prValidate10500 => nuOrderId=>' ||
                   nuOrderId,
                   10);
    --Obtener causal de legalizacion
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
    ut_trace.trace('Ejecucion LDCI_PKREVISIONPERIODICAWEB.prValidate10500 => nuCausalId=>' ||
                   nuCausalId,
                   10);
    --Obtener tipo de causal
    nuCausalClassId := dage_causal.fnugetclass_causal_id(nuCausalId);
    ut_trace.trace('Ejecucion LDCI_PKREVISIONPERIODICAWEB.prValidate10500 => nuCausalClassId=>' ||
                   nuCausalClassId,
                   10);
    nuOrderActivityId := ldc_bcfinanceot.fnugetActivityId(nuOrderId);
    ut_trace.trace('Ejecucion LDCI_PKREVISIONPERIODICAWEB.prValidate10500 => nuOrderActivityId=>' ||
                   nuOrderActivityId,
                   10);
    nuPackageId := daor_order_activity.fnugetpackage_id(nuOrderActivityId);
    ut_trace.trace('Ejecucion LDCI_PKREVISIONPERIODICAWEB.prValidate10500 => nuPackageId=>' ||
                   nuPackageId,
                   10);
    --Validar el tipo de soliciud
    nuPackageTypeId := damo_packages.fnugetpackage_type_id(nuPackageId);
    IF nuPackageTypeId = 323 AND nuCausalClassId = 1 THEN
      pkg_error.setErrorMessage( isbMsgErrr => 
                                       'Las ordenes de Aceptacion de Certificacion para constructoras no puede legalizarce con causal de Exito' ||
                                       nuCausalId);
    END IF;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'prValidate10500', cnuNVLTRC); 
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      RAISE;

    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END prValidate10500;

  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : prLevantaTipoSuspen
   Descripcion    : Procedimiento donde se implementa la logica para levantar en la reconexion las
                    suspensiones de revision periodica cuando la reconexion no se realiza x el mismo
                    tipo de suspension que se suspensio (DEFINIR EN FMIO).
   Autor          : Emiro leyva
   Fecha          : 20/10/2014

   Metodos

   Nombre         :
   Parametros         Descripcion
   ============  ===================


   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========         =========         ====================
  ******************************************************************/

  PROCEDURE prLevantaTipoSuspen IS
    -- Actividad de Orden
    nuOrderId        or_order.order_id%TYPE;
    nuOrderActivity  or_order_activity.order_activity_id%TYPE;
    nuClassCausalRef ge_causal.class_causal_id%TYPE := 1;
    nuPRODUCT_ID     or_order_activity.product_id%TYPE;
    nuCausalId       ge_causal.causal_id%TYPE;
    nuCausalClassId  ge_class_causal.class_causal_id%TYPE;
    nuSuspensionType NUMBER;

    CURSOR cuTipoActual(inuProduct or_order_activity.product_id%TYPE) IS
      SELECT /*+ ordered index(MO_MOTIVE IX_MO_SUSPENSION01) index(MO_SUSPENSION PK_MO_SUSPENSION)*/
       mo_suspension.suspension_type_id
        FROM mo_motive, mo_suspension
       WHERE mo_suspension.motive_id = mo_motive.motive_id
         AND (mo_suspension.ending_date IS NULL OR
             mo_suspension.ending_date > SYSDATE)
         AND mo_motive.product_id = inuProduct
         AND mo_motive.motive_status_id = 11;

    CURSOR cuTypoSusp(inuproduct pr_product.product_id%TYPE) IS
      SELECT *
        FROM pr_prod_suspension
       WHERE product_id = inuproduct
         AND suspension_type_id IN (101, 102, 103, 104)
         AND suspension_type_id <> nuSuspensionType;

  BEGIN

    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'prLevantaTipoSuspen', cnuNVLTRC); 

    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuOrderId       := or_bolegalizeorder.fnuGetCurrentOrder;
    nuOrderActivity := ldc_bcfinanceot.fnuGetActivityId(nuorderid);
    --Obtener causal de legalizacion
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
    --Obtener tipo de causal
    nuCausalClassId := dage_causal.fnugetclass_causal_id(nuCausalId);
    nuPRODUCT_ID    := daor_order_activity.Fnugetproduct_Id(nuOrderActivity);
    OPEN cuTipoActual(nuPRODUCT_ID);
    FETCH cuTipoActual
      INTO nuSuspensionType;
    CLOSE cuTipoActual;
    --VALIDAR SI LA CAUSAL DE LEGALIZACION ES EXITOSA
    IF nuCausalClassId = nuClassCausalRef AND
       nuSuspensionType IN (101, 102, 103, 104) THEN
      FOR rg IN cuTypoSusp(nuPRODUCT_ID) LOOP
        dapr_prod_suspension.updinactive_date(rg.prod_suspension_id,
                                              SYSDATE);
        dapr_prod_suspension.updactive(rg.prod_suspension_id, 'N');
      END LOOP;
    END IF;
    
    UT_Trace.Trace('Termina ' || csbSP_NAME || 'prLevantaTipoSuspen', cnuNVLTRC);     

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.SetError;
      RAISE;
    WHEN OTHERS THEN
      pkg_Error.SetError;
      RAISE pkg_Error.Controlled_Error;
  END prLevantaTipoSuspen;
  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fsbIsNotifPlazos
   Descripcion    : funcion para buscar en las reglas de orcor si el producto se
                    notifica por vencimiento o por reparacion enviendo el producto
   Autor          : Emiro leyva
   Fecha          : 20/10/2014

   Metodos

   Nombre         :
   Parametros         Descripcion
   ============  ===================


   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========         =========         ====================
  ******************************************************************/

  FUNCTION fsbIsNotifPlazos(inuProduct_id IN pr_product.product_Id%TYPE)
    RETURN VARCHAR2 IS

    CURSOR cuDatos(nuProduct_id IN pr_product.product_Id%TYPE) IS
      SELECT is_notif
        FROM ldc_plazos_cert
       WHERE id_producto = nuProduct_id;
    sbIs_Notif ldc_plazos_cert.is_notif%TYPE;
  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'fsbIsNotifPlazos', cnuNVLTRC);   
   
    OPEN cuDatos(inuProduct_id);
    FETCH cuDatos
      INTO sbIs_Notif;
    CLOSE cuDatos;
    UT_Trace.Trace('Termina ' || csbSP_NAME || 'fsbIsNotifPlazos', cnuNVLTRC);    
    RETURN(sbIs_Notif);
  EXCEPTION
    WHEN no_data_found THEN
      RETURN NULL;
  END fsbIsNotifPlazos;

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuSuspendedProduct
    Descripcion    : funcion para determinar si el producto esta suspendido desde Acometida
    Autor          : Oscar PArra
    Fecha          : 23/11/2014

    Metodos

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    23/11/2014        oparra.2732        Creacion
  *******************************************************************/
  FUNCTION fnuSuspendedProduct(inuproduct pr_product.product_id%TYPE,
                               isbtypeTT  VARCHAR2) RETURN NUMBER IS

    nuflagR          NUMBER;
    nuFlagError      NUMBER;
    sbErrorsMessages VARCHAR2(2000);

    sbTTAcometida  VARCHAR2(2000) := dald_parameter.fsbGetValue_Chain('LDC_TT_SUSP_ACOMETIDA');
    sbActAcometida VARCHAR2(2000) := dald_parameter.fsbGetValue_Chain('LDC_ACT_SUSP_ACOMETIDA');    
    sbActCM VARCHAR2(2000) := dald_parameter.fsbGetValue_Chain('LDC_ACT_SUSP_CM');

    -- Cursor que valida que el producto haya sido suspendido desde acometida
    CURSOR cuSuspendAcometida IS
      SELECT 1
        FROM pr_product PR, or_order_activity o
       WHERE PR.product_id = inuProduct
         AND PR.suspen_ord_act_id = o.order_activity_id
         AND (o.task_type_id IN
             (SELECT column_value
                 FROM TABLE(ldc_boutilities.splitStrings(sbTTAcometida, ','))) OR
             o.activity_id IN
             (SELECT column_value
                 FROM TABLE(ldc_boutilities.splitStrings(sbActAcometida, ','))))
         AND rownum = 1;

    -- Cursor que valida que el producto haya sido suspendido desde CM
    CURSOR cuSuspendCM IS
      SELECT 1
        FROM pr_product PR, or_order_activity o
       WHERE PR.product_id = inuProduct
         AND PR.suspen_ord_act_id = o.order_activity_id
         AND o.activity_id IN
             (SELECT column_value
                FROM TABLE(ldc_boutilities.splitStrings(sbActCM, ',')))
         AND rownum = 1;
  BEGIN
  
    UT_Trace.Trace('Inicia ' || csbSP_NAME || 'fnuSuspendedProduct', cnuNVLTRC);  
      
    IF inuproduct IS NOT NULL THEN
      IF isbtypeTT = 'A' THEN
        OPEN cuSuspendAcometida;
        FETCH cuSuspendAcometida
          INTO nuflagR;
        CLOSE cuSuspendAcometida;
        IF nuflagR IS NOT NULL THEN
          IF nuflagR = 1 THEN
            RETURN 1; -- se suspendio desde acometida
          ELSE
            RETURN 0;
          END IF;
        END IF;

      ELSIF isbtypeTT = 'CM' THEN
        OPEN cuSuspendCM;
        FETCH cuSuspendCM
          INTO nuflagR;
        CLOSE cuSuspendCM;

        IF nuflagR IS NOT NULL THEN
          IF nuflagR = 1 THEN
            RETURN 1; -- se suspendio desde CM
          ELSE
            RETURN 0;
          END IF;
        END IF;
      END IF;
    ELSE
      nuFlagError      := 1;
      sbErrorsMessages := 'El producto es nulo.';
    END IF;

    UT_Trace.Trace('Termina ' || csbSP_NAME || 'fnuSuspendedProduct', cnuNVLTRC);  
        
    RETURN nuflagR;

  END fnuSuspendedProduct;

END LDCI_PKREVISIONPERIODICAWEB;
/
PROMPT Otorgando permisos de ejecucion sobre LDCI_PKREVISIONPERIODICAWEB
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_PKREVISIONPERIODICAWEB','OPEN');
END;
/

