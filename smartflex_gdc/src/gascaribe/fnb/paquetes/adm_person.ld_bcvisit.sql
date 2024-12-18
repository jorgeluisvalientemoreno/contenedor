CREATE OR REPLACE PACKAGE ADM_PERSON.LD_BCVISIT IS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Ld_BcVisit
  Descripcion    : Paquete BO con las funciones y/o procedimientos que contendrá el de solicitud de visita.
  Autor          : kbaquero
  Fecha          : 30/11/2012 SAO 159429

  Metodos

  Nombre         :
  Parametros         Descripción
  ============   ===================
  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  -- Declaracion de Tipos de datos publicos

  -- Declaracion de variables publicas
  -----------------------
  -- Constants
  -----------------------
  -- Constante con el SAO de la ultima version aplicada
  csbVERSION CONSTANT VARCHAR2(10) := 'SAO234804';
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

  Autor          :  aacuña SAO 159429
  Fecha          :  24/09/2012

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  *****************************************************************/

  FUNCTION fsbVersion return varchar2;
  sbconsultation varchar2(4000);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSoliAct
  Descripcion    : Valida que no exista solicitud activa del cualquier tipo de
  Autor          : kbaquero
  Fecha          : 30/11/2012 SAO 159429

  Parametros         Descripción
  ============   ===================
  inuSusc:       Numero del suscritoR
  inuMotype:     Código del tipo de paquete
  inuEstapack:   Estado de la solicitud
  onucant:       Cantidad de solicitudes en estado activo

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSoliAct(inuSusc     in servsusc.sesususc%type,
                        inuMotype   in pr_product.product_type_id%type,
                        inuEstapack in mo_packages.motive_status_id%type,
                        onucant     out number);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValCate
  Descripcion    : Verifica la categoria de un contrato y devuelve estos datos para que sean verificado.
  Autor          : Kbaquero
  Fecha          : 06/12/2012 SAO 159429

  Parametros          Descripción
  ============     ==================
  inuSusc:         Número de suscripción
  inuGas_Service:  Parametro del servicio de gas
  isbCate :        Parametro de las categorias permitidas
  onuCant:         Parametro de la categoria permitida


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValCate(inuSusc        in suscripc.susccodi%type,
                        isbCate        in ld_parameter.value_chain%type,
                        inuGas_Service in ld_parameter.numeric_value%type,
                        onuCant        out ld_parameter.numeric_value%type);


                         /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Procpackatype
  Descripcion    : Selecciona el tipo de paquete de una solicitud dependiendo del
                   suscriptor
  Autor          : kbaquero
  Fecha          : 21/06/2013 SAO 159429

  Parametros         Descripción
  ============   ===================
  inuChanelCrossSale:   Código de la venta que se ingresa
  onucant:             Cantidad de solicitudes en estado activo

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE Procpackatype(inuChanelCrossSale in ld_sales_visit.visit_sale_cru_id%type,
                          onucant            out number);

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   fnuGetQuantityVisitFNB
    Descripcion :   Obtiene la cantidad de solicitudes registradas de Visita
                    de Financiación No Bancaria dado el tipo de visita.

    Autor       :   Jorge Alejandro Carmona Duque
    Fecha       :   25-09-2013
    Parametros  :
        inuSusc         Contrato
        inuMotype       Tipo de Paquete de Visita FNB
        inuEstapack     Identificador de Estado Registrado
        inuVisitType    Tipo de Visita seleccionado en el trámite

    Retorno     :   cantidad de solicitudes registradas de Visita
                    de Financiación No Bancaria dado el tipo de visita.

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    25-09-2013  JCarmona.SAO217872      Creación.
    ***************************************************************************/
    FUNCTION fnuGetQuantityVisitFNB
    (
        inuSusc         in servsusc.sesususc%type,
        inuMotype       in pr_product.product_type_id%type,
        inuEstapack     in mo_packages.motive_status_id%type,
        inuVisitType    in ld_sales_visit.visit_type_id%type
    )
    RETURN number;

END LD_BCVISIT;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LD_BCVISIT IS
  -- Declaracion de variables y tipos globales privados del paquete

  -- Definicion de metodos publicos y privados del paquete

  /************* ****************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure      :  fsbVersion
  Descripcion    :  Obtiene la Version actual del Paquete

  Parametros     :  Descripción
  Retorno        :
  csbVersion        Version del Paquete

  Autor          :  aacuña SAO 159429
  Fecha          :  24/09/2012

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  *****************************************************************/

  FUNCTION fsbVersion RETURN varchar2 IS
  BEGIN
    pkErrors.Push('Ld_BcVisit.fsbVersion');
    pkErrors.Pop;
    -- Retorna el SAO con que se realizo la ultima entrega
    RETURN(csbVersion);
  END fsbVersion;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSoliAct
  Descripcion    : Valida que no exista solicitud activa del cualquier tipo de
  Autor          : kbaquero
  Fecha          : 26/09/2012 SAO 159429

  Parametros         Descripción
  ============   ===================
  inuSusc:       Numero del suscritoR
  inuMotype:     Código del tipo de paquete
  inuEstapack:   Estado de la solicitud
  onucant:       Cantidad de solicitudes en estado activo

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSoliAct(inuSusc     in servsusc.sesususc%type,
                        inuMotype   in pr_product.product_type_id%type,
                        inuEstapack in mo_packages.motive_status_id%type,
                        onucant     out number) is

  BEGIN
    ut_trace.Trace('INICIO Ld_BcVisit.ProcSoliAct', 10);
    SELECT /*+  INDEX (MO_PACKAGES IDX_MO_PACKAGES_024) */
     count(*)
      INTO onucant
      FROM mo_packages P, mo_motive M
     WHERE P.package_id = M.package_id
       AND m.subscription_id = inuSusc
       AND p.motive_status_id = inuEstapack
       AND p.package_type_id = inuMotype;

    ut_trace.Trace('FIN Ld_BcVisit.ProcSoliAct', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSoliAct;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcValCate
  Descripcion    : Verifica la categoria de un contrato y devuelve estos datos para que sean verificado.
  Autor          : Kbaquero
  Fecha          : 06/12/2012 SAO 159429

  Parametros          Descripción
  ============     ==================
  inuSusc:         Número de suscripción
  inuGas_Service:  Parametro del servicio de gas
  isbCate :        Parametro de las categorias permitidas
  onuCant:         Parametro de la categoria permitida


  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcValCate(inuSusc        in suscripc.susccodi%type,
                        isbCate        in ld_parameter.value_chain%type,
                        inuGas_Service in ld_parameter.numeric_value%type,
                        onuCant        out ld_parameter.numeric_value%type)

   IS

  BEGIN

    ut_trace.Trace('INICIO Ld_BcVisit.ProcValCate', 10);

    SELECT /*+ordered use_nl(a c) INDEX (b IX_SUSCRIPC017) index(c PK_PS_PRODUCT_STATUS)*/
        1
      INTO onuCant
      FROM suscripc          b,
           pr_product        a,
           ps_product_status c,
           servsusc          s,
           ge_subscriber     g
     WHERE a.subscription_id = b.susccodi
       AND b.susccodi = s.sesususc
       AND sesuserv = a.product_type_id
       AND a.product_status_id = c.product_status_id
       AND g.subscriber_id = b.suscclie
       AND s.sesususc = a.subscription_id
       AND a.product_id = s.sesunuse
       AND sesufein = (SELECT MAX(sesufein)
                         FROM servsusc sesu
                        WHERE sesu.sesususc = inuSusc
                          AND sesu.sesucate = s.sesucate
                          and sesu.sesuserv = inuGas_Service)
       AND a.product_type_id = inuGas_Service
       AND b.susccodi = inuSusc
       AND regexp_instr(s.sesucate, isbCate) > 0
       AND c.is_active_product = ld_boconstans.csbYesFlag
       AND rownum = 1;

    ut_trace.Trace('FIN Ld_BcVisit.ProcValCate', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onuCant := -1;
     when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcValCate;


   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Procpackatype
  Descripcion    : Selecciona el tipo de paquete de una solicitud dependiendo del
                   suscriptor
  Autor          : kbaquero
  Fecha          : 27/09/2012 SAO 159429

  Parametros         Descripción
  ============   ===================
  inupacktype:         Código Tipo de paquete
  inuChanelCrossSale:   Código de la venta que se ingresa
  onucant:             Cantidad de solicitudes en estado activo

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE Procpackatype(inuChanelCrossSale in ld_sales_visit.visit_sale_cru_id%type,
                          onucant            out number) is

  BEGIN

    ut_trace.Trace('FIN Ld_BcVisit.Procpackatype', 10);

    SELECT /*+  INDEX (MO_PACKAGES IDX_MO_PACKAGES_024) */
     count(package_type_id)
      INTO onucant
      FROM mo_packages M
     WHERE M.PACKAGE_ID = inuChanelCrossSale;

    ut_trace.Trace('FIN Ld_BcVisit.Procpackatype', 10);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      onucant := 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END Procpackatype;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   fnuGetQuantityVisitFNB
    Descripcion :   Obtiene la cantidad de solicitudes registradas de Visita
                    de Financiación No Bancaria dado el tipo de visita.

    Autor       :   Jorge Alejandro Carmona Duque
    Fecha       :   25-09-2013
    Parametros  :
        inuSusc         Contrato
        inuMotype       Tipo de Paquete de Visita FNB
        inuEstapack     Identificador de Estado Registrado
        inuVisitType    Tipo de Visita seleccionado en el trámite

    Retorno     :   cantidad de solicitudes registradas de Visita
                    de Financiación No Bancaria dado el tipo de visita.

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    25-09-2013  JCarmona.SAO217872      Creación.
    ***************************************************************************/
    FUNCTION fnuGetQuantityVisitFNB
    (
        inuSusc         in servsusc.sesususc%type,
        inuMotype       in pr_product.product_type_id%type,
        inuEstapack     in mo_packages.motive_status_id%type,
        inuVisitType    in ld_sales_visit.visit_type_id%type
    )
    RETURN number
    IS
        CURSOR cuQuantityVisitFNB
        (
            nuSuscId            servsusc.sesususc%type,
            nuMotypeId          pr_product.product_type_id%type,
            nuEstaPackId        mo_packages.motive_status_id%type,
            nuVisitTypeId       ld_sales_visit.visit_type_id%type
        )
        IS
            SELECT
            1
            FROM mo_packages P, mo_motive M, ld_sales_visit V
            WHERE P.package_id = M.package_id
            AND M.package_id = V.package_id
            AND m.subscription_id = nuSuscId
            AND p.motive_status_id = nuEstaPackId
            AND p.package_type_id = nuMotypeId
            AND V.visit_type_id = nuVisitTypeId
            AND rownum = 1;

        nuQuantityVisitFNB  number;

        PROCEDURE CloseCursor
        IS
        BEGIN
            IF(cuQuantityVisitFNB%ISOPEN)THEN
                CLOSE cuQuantityVisitFNB;
            END IF;
        END CloseCursor;
    BEGIN
        UT_Trace.Trace('BEGIN Ld_BcVisit.fnuGetQuantityVisitFNB',10);

        CloseCursor;

        /*Validacion de existencia del cliente*/

        OPEN cuQuantityVisitFNB(inuSusc, inuMotype, inuEstapack, inuVisitType);
        FETCH cuQuantityVisitFNB INTO nuQuantityVisitFNB;

        CloseCursor;

        UT_Trace.Trace('Cantidad '||nuQuantityVisitFNB,10);
        UT_Trace.Trace('END Ld_BcVisit.fnuGetQuantityVisitFNB',10);
        RETURN nvl(nuQuantityVisitFNB, 0);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            CloseCursor;
            RAISE ex.CONTROLLED_ERROR;
        WHEN others THEN
            CloseCursor;
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END fnuGetQuantityVisitFNB;

END LD_BCVISIT;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LD_BCVISIT', 'ADM_PERSON'); 
END;
/
