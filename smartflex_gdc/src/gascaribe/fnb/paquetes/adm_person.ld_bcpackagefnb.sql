CREATE OR REPLACE PACKAGE ADM_PERSON.LD_BCPACKAGEFNB IS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_BcPackageFNB
  Descripcion    : Paquete Bc con las funciones y/o procedimientos que contendrá lo necesario
                  para las validaciones.
  Autor          : kbaquero
  Fecha          : 19/06/2013 SAO 138954

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
  csbVERSION CONSTANT VARCHAR2(10) := 'SAO138954';
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

  Autor          :  Kbaquero SAO 138954
  Fecha          :  19/06/2013

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  *****************************************************************/

  FUNCTION fsbVersion return varchar2;
  sbconsultation varchar2(4000);


  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad :         frfGetcontrat
  Descripcion    : Busca los contratos asociados al subscriber del paquete

  Autor          : KBaquero
  Fecha          : 19/06/2013

  Parametros         Descripción
  ============   ===================
  inusubs:       Id. Subscriber

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  19/06/2013     KBaquero     Creación
  ******************************************************************/

  FUNCTION frfGetcontrat(inusubs in ge_subscriber.subscriber_id%type)
    RETURN constants.tyrefcursor;

/*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSoliAct
  Descripcion    : Valida que no exista solicitud activa del cualquier cliente
  Autor          : kbaquero
  Fecha          : 19/06/2013 SAO 138954

  Parametros         Descripción
  ============   ===================
  inuSusc:       Id. Subscriber
  inuMotype:     Código del tipo de paquete
  inuEstapack:   Estado de la solicitud
  onucant:       Cantidad de solicitudes en estado activo

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  ******************************************************************/

  PROCEDURE ProcSoliAct(inuSusc     in  ge_subscriber.subscriber_id%type,
                        inuMotype   in pr_product.product_type_id%type,
                        inuEstapack in mo_packages.motive_status_id%type,
                        onucant     out number);

                          /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSoliActsusc
  Descripcion    : Valida que no exista solicitud activa del cualquier tipo de
  Autor          : kbaquero
  Fecha          : 19/06/2013 SAO 138954

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

  PROCEDURE ProcSoliActsusc(inuSusc     in  suscripc.susccodi%type,
                        inuMotype   in pr_product.product_type_id%type,
                        inuEstapack in mo_packages.motive_status_id%type,
                        onucant     out number);

  /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   fnuValPendDeliveryOrders
    Descripcion :   Valida si la solicitud de venta tiene órdenes de entrega
                    pendientes por legalizar.
                    Retorna 1 si hay ordenes por legalizar.
                    Retorna 0 de lo contrario.

    Autor       :   Jorge Alejandro Carmona Duque
    Fecha       :   13-09-2013
    Parametros  :
        nuPackOrActId:      Identificador de la Solicitud.
        nuActivityId:       Actividad de

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    13-09-2013  JCarmona.SAO213685      Creación.
    ***************************************************************************/
    FUNCTION fnuValPendDeliveryOrders
    (
        inuPackageId            mo_packages.package_id%type
    )
    return number;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   fnuValPendFlowLegalizeOrders
    Descripcion :   Valida si el flujo de venta se encuentra detenido en la
                    actividad "Espera por legalización Ot Entrega", es decir
                    que está esperando por la legalización de las órdenes de
                    entrega.
                    Retorna 1 si el flujo esta en espera por legalización.
                    Retorna 0 de lo contrario.

    Autor       :   Jorge Alejandro Carmona Duque
    Fecha       :   13-09-2013
    Parametros  :
        nuPackOrActId:      Identificador de la Solicitud.
        nuActivityId:       Actividad de

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    13-09-2013  JCarmona.SAO213685      Creación.
    ***************************************************************************/
    FUNCTION fnuValPendFlowLegalizeOrders
    (
        inuPackageId            mo_packages.package_id%type
    )
    return number;


    /**********************************************************************
        Propiedad intelectual de OPEN International Systems
        Nombre
        Autor
        Fecha

        Descripción  Actualiza las inconsistencias (ld_incons_fnb_exito)
                     cambiando su estado de Pendiente a Corregido

        Parametros
        Nombre            Descripción
        inuSaleId         Número de la solicitud que fue procesada (legalizadas
                          las órdenes) y se va a actualizar las inconsistencias
                          (si las tiene)
        Historia de Modificaciones
        Fecha             Autor           Modificación
        9/17/2013         vhurtado        Creación
    ***********************************************************************/
    PROCEDURE UpdInconsistency (inuSaleId IN ld_incons_fnb_exito.sale_id%type);



    /**********************************************************************
        Propiedad intelectual de OPEN International Systems
        Nombre
        Autor
        Fecha

        Descripción  Actualiza el articulo de las actividades asociadas a la orden
                        de entrega.

        Parametros
        Nombre                  Descripción
        inuArticleId            Identificador del articulo nuevo.
        inuOrderActivityId      Identificador de la actividad.


        Historia de Modificaciones
        Fecha             Autor           Modificación
        9/17/2013         LDiuza          Creación
    ***********************************************************************/
    PROCEDURE UpdArticleByOrder(
                                inuArticleId IN ld_article.article_id%type,
                                inuOrderActivityId  IN or_order_activity.order_activity_id%type,
                                inuValue            in ld_item_work_order.value%type,
                                inuCantidad         in ld_item_work_order.amount%type,
                                inuIva              in ld_item_work_order.iva%type
                                );

END LD_BCPACKAGEFNB;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LD_BCPACKAGEFNB IS
  -- Declaracion de variables y tipos globales privados del paquete

  -- Definicion de metodos publicos y privados del paquete

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure      :  fsbVersion
  Descripcion    :  Obtiene la Version actual del Paquete

  Parametros     :  Descripción
  Retorno        :
  csbVersion        Version del Paquete

  Autor          :  Kbaquero SAO 138954
  Fecha          :  19/06/2013

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

  Unidad :         frfGetcontrat
  Descripcion    : Busca los contratos asociados al subscriber del paquete

  Autor          : KBaquero
  Fecha          : 19/06/2013

  Parametros         Descripción
  ============   ===================
  inusubs:       Id. Subscriber

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  19/06/2013     KBaquero     Creación
  ******************************************************************/

  FUNCTION frfGetcontrat(inusubs in ge_subscriber.subscriber_id%type)

   RETURN constants.tyrefcursor

   IS

    rfGetCONTRAT constants.tyrefcursor;

  BEGIN

   ut_trace.Trace('INICIO LD_BcPackageFNB.frfGetcontrat', 10);


    OPEN rfGetCONTRAT FOR
      SELECT  susccodi
      FROM suscripc s
      WHERE s.suscclie = inusubs;


    RETURN rfGetCONTRAT;

  ut_trace.Trace('FIN LD_BcPackageFNB.frfGetcontrat', 10);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END frfGetcontrat;


   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSoliAct
  Descripcion    : Valida que no exista solicitud activa del cualquier tipo de
  Autor          : kbaquero
  Fecha          : 19/06/2013 SAO 138954

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

  PROCEDURE ProcSoliAct(inuSusc     in  ge_subscriber.subscriber_id%type,
                        inuMotype   in pr_product.product_type_id%type,
                        inuEstapack in mo_packages.motive_status_id%type,
                        onucant     out number) is

  BEGIN
 ut_trace.Trace('INICIO LD_BcPackageFNB.ProcSoliAct', 10);

    SELECT /*+  INDEX (MO_PACKAGES IDX_MO_PACKAGES_024) */
     count(*)
      INTO onucant
      FROM mo_packages P, mo_motive M
     WHERE P.package_id = M.package_id
       AND p.subscriber_id=inuSusc
        AND m.subscription_id is null
       AND p.motive_status_id = inuEstapack
       AND p.package_type_id = inuMotype;


   ut_trace.Trace('FIN LD_BcPackageFNB.ProcSoliAct', 10);


  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSoliAct;


   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcSoliActsusc
  Descripcion    : Valida que no exista solicitud activa del cualquier tipo de
  Autor          : kbaquero
  Fecha          : 19/06/2013 SAO 138954

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

  PROCEDURE ProcSoliActsusc(inuSusc     in suscripc.susccodi%type,
                        inuMotype   in pr_product.product_type_id%type,
                        inuEstapack in mo_packages.motive_status_id%type,
                        onucant     out number) is

  BEGIN
 ut_trace.Trace('INICIO LD_BcPackageFNB.ProcSoliActsusc', 10);

    SELECT /*+  INDEX (MO_PACKAGES IDX_MO_PACKAGES_024) */
     count(*)
      INTO onucant
      FROM mo_packages P, mo_motive M
     WHERE P.package_id = M.package_id
       AND m.subscription_id=inuSusc
       AND p.motive_status_id = inuEstapack
       AND p.package_type_id = inuMotype;


   ut_trace.Trace('FIN LD_BcPackageFNB.ProcSoliActsusc', 10);


  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcSoliActsusc;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   fnuValPendDeliveryOrders
    Descripcion :   Valida si la solicitud de venta tiene órdenes de entrega
                    pendientes por legalizar.
                    Retorna 1 si hay ordenes por legalizar.
                    Retorna 0 de lo contrario.

    Autor       :   Jorge Alejandro Carmona Duque
    Fecha       :   13-09-2013
    Parametros  :
        nuPackOrActId:      Identificador de la Solicitud.
        nuActivityId:       Actividad de

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    13-09-2013  JCarmona.SAO213685      Creación.
    ***************************************************************************/
    FUNCTION fnuValPendDeliveryOrders
    (
        inuPackageId            mo_packages.package_id%type
    )
    return number
    IS
        nuActivityDeliveryId        number;

        /* Retorna las órdenes de entrega en estado registradas */
        CURSOR cuValPendDeliveryOrders
        (
            nuPackOrActId OR_order_activity.package_id%type,
            nuActivityId OR_order_activity.activity_id%type
        )
        IS
            SELECT decode(count(o.order_id), 0, 0, 1)
            FROM OR_order_activity o
            WHERE o.package_id = nuPackOrActId
            AND o.activity_id = nuActivityId
            AND o.status = 'R';

        nuOrderAct number;

    BEGIN
        ut_trace.trace('Inicio ld_bcpackagefnb.fnuValPendDeliveryOrders['||inuPackageId||']', 1);

        nuActivityDeliveryId := Dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB'); -- Actividad de Entrega

        --Obtiene los datos a retornar.
        open cuValPendDeliveryOrders(inuPackageId,nuActivityDeliveryId);
            fetch cuValPendDeliveryOrders into nuOrderAct;
        close cuValPendDeliveryOrders;

        ut_trace.trace('Fin ld_bcpackagefnb.fnuValPendDeliveryOrders['||nuOrderAct||']', 1);
        return nuOrderAct;

    Exception
        When ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
        When others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
    End fnuValPendDeliveryOrders;

  /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   fnuValPendFlowLegalizeOrders
    Descripcion :   Valida si el flujo de venta se encuentra detenido en la
                    actividad "Espera por legalización Ot Entrega", es decir
                    que está esperando por la legalización de las órdenes de
                    entrega.
                    Retorna 1 si el flujo esta en espera por legalización.
                    Retorna 0 de lo contrario.

    Autor       :   Jorge Alejandro Carmona Duque
    Fecha       :   13-09-2013
    Parametros  :
        nuPackOrActId:      Identificador de la Solicitud.
        nuActivityId:       Actividad de

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    13-09-2013  JCarmona.SAO213685      Creación.
    ***************************************************************************/
    FUNCTION fnuValPendFlowLegalizeOrders
    (
        inuPackageId            mo_packages.package_id%type
    )
    return number
    IS
        nuUnitTypeLegId         wf_unit_type.unit_type_id%type;
        nuInstanceStatusId      number;
        /* Tipo de Unidad 100464 - Espera por legalización Ot Entrega */
        cnuUnitTypeId constant number := 100464;

        /* Valida si el flujo de venta se encuentra en la actividad de
           Espera por legalización Ot Entrega */
        CURSOR cuValPendFlowLegalizeOrders
        (
            nuPackOrActId OR_order_activity.package_id%type,
            nuUnitTypeId wf_unit_type.unit_type_id%type
        )
        IS
            SELECT      NVL((SELECT      DECODE(status_id, 4, 1, 0)
            FROM        wf_instance
            WHERE       external_id = to_char(nuPackOrActId)
            AND         unit_type_id =  nuUnitTypeId),0) status_id
            FROM        DUAL;

    BEGIN
        ut_trace.trace('Inicio ld_bcpackagefnb.fnuValPendFlowLegalizeOrders['||inuPackageId||']', 1);

        nuUnitTypeLegId := cnuUnitTypeId;

        --Obtiene los datos a retornar.
        open cuValPendFlowLegalizeOrders(inuPackageId,nuUnitTypeLegId);
            fetch cuValPendFlowLegalizeOrders into nuInstanceStatusId;
        close cuValPendFlowLegalizeOrders;

        ut_trace.trace('Fin ld_bcpackagefnb.fnuValPendFlowLegalizeOrders['||nuInstanceStatusId||']', 1);
        return nuInstanceStatusId;

    Exception
        When ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
        When others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
    End fnuValPendFlowLegalizeOrders;


    /**********************************************************************
        Propiedad intelectual de OPEN International Systems
        Nombre
        Autor
        Fecha

        Descripción  Actualiza las inconsistencias (ld_incons_fnb_exito)
                     cambiando su estado de Pendiente a Corregido

        Parametros
        Nombre            Descripción
        inuSaleId         Número de la solicitud que fue procesada (legalizadas
                          las órdenes) y se va a actualizar las inconsistencias
                          (si las tiene)
        Historia de Modificaciones
        Fecha             Autor           Modificación
        9/17/2013         vhurtado        Creación
    ***********************************************************************/
    PROCEDURE UpdInconsistency (inuSaleId IN ld_incons_fnb_exito.sale_id%type)
    IS
    BEGIN
           UPDATE ld_incons_fnb_exito SET state = 'C'
             WHERE state = 'P'
             AND sale_id = inuSaleId;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;


    /**********************************************************************
        Propiedad intelectual de OPEN International Systems
        Nombre
        Autor
        Fecha

        Descripción  Actualiza el articulo de las actividades asociadas a la orden
                        de entrega.

        Parametros
        Nombre                  Descripción
        inuArticleId            Identificador del articulo nuevo.
        inuOrderActivityId      Identificador de la actividad.


        Historia de Modificaciones
        Fecha             Autor           Modificación
        9/17/2013         LDiuza          Creación
    ***********************************************************************/
    PROCEDURE UpdArticleByOrder(
                                inuArticleId        IN ld_article.article_id%type,
                                inuOrderActivityId  IN or_order_activity.order_activity_id%type,
                                inuValue            in ld_item_work_order.value%type,
                                inuCantidad         in ld_item_work_order.amount%type,
                                inuIva              in ld_item_work_order.iva%type
                                )
    IS
    BEGIN
            UPDATE ld_item_work_order
            SET ld_item_work_order.article_id = inuArticleId,
                ld_item_work_order.value = inuValue,
                ld_item_work_order.amount = inuCantidad,
                ld_item_work_order.iva = inuIva
            WHERE ld_item_work_order.order_activity_id = inuOrderActivityId;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;



END LD_BCPACKAGEFNB;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LD_BCPACKAGEFNB', 'ADM_PERSON'); 
END;
/
