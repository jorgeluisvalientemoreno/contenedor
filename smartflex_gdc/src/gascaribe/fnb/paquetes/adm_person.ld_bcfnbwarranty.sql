CREATE OR REPLACE package adm_person.LD_BCFNBWARRANTY is
/*****************************************************************
Propiedad intelectual de Open International Systems (c).

Unidad         : LD_BCFNBWARRANTY
Descripcion    : Paquete BC con las funciones y/o procedimientos que contendrá la solicitud de garantía.
Autor          : Kbaquero
Fecha          : 08/10/2012 SAO 159480

Historia de Modificaciones
Fecha            Autor            Modificación
==========  ===================   ================================
19/06/2024  PAcosta               OSF-2845: Cambio de esquema ADM_PERSON
28-11-2013  hjgomez.SAO225271     Se crea <<fnuGetArticle>>
                                  Se modifica <<procmotiWarranty>>
27-09-2013  jcarrillo.SAO217956   1 - Se adiciona el método <GetDateDeliveryItem>
******************************************************************/

  -- Declaracion de Tipos de datos publicos

  -- Declaracion de variables publicas
  -----------------------
  -- Constants
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

  Autor          :  Kbaquero SAO 159480
  Fecha          :  08/10/2012

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  *****************************************************************/

  FUNCTION fsbVersion return varchar2;
  sbconsultation varchar2(4000);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : fboExistWarranty
   Descripcion    : Retorna `Y� si actualmente existe una solicitud de garantía asociada a la solicitud de venta,
                   de lo contrario retorna `N�
   Autor          : Kbaquero SAO 159480
   Fecha          : 08/10/2012

   Parametros             Descripción
   ============        ===================
  inuItem             :Identificación del ítem del cual se está realizando la solicitud de garantía.

   Historia de Modificaciones
   Fecha         Autor       Modificacion
   =========   ========= ====================

   ******************************************************************/

  FUNCTION fbcExistWarranty(inuItem     in ld_fnb_warranty.item_id%type,
                            inupacksale in ld_fnb_warranty.package_sale_id%type)
    RETURN varchar2;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : procmotiWarranty
  Descripcion    :
  Autor          : Kbaquero SAO 159480
  Fecha          : 08/10/2012

  Parametros             Descripción
  ============        ===================
  inupack             :Identificación del paquete
  Orfmotiwar           :Cursor de los item

  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================

  ******************************************************************/

  PROCEDURE procmotiWarranty(inupack    in ld_fnb_warranty.package_sale_id%type,
                             Orfmotiwar out pkConstante.tyRefCursor);

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad : frfGetOperating
    Descripcion : Retorna la unidad operativa que pertenece a un articulo

    Autor : AAcuna
    Fecha : 04/07/2013

    Parametros       Descripcion
    ============  ===================
    inuitem:  Tipo de poliza

    Historia de Modificaciones
    Fecha Autor Modificacion
    ========= ========= ====================

  ******************************************************************/
  FUNCTION frfGetOperating(inuitem in ld_article.article_id%type)

   RETURN constants.tyrefcursor;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad : GetDaywarranty
    Descripcion : Obtiene los días de Garantía que tiene un articulo

    Autor : AAcuna
    Fecha : 04/07/2013

    Parametros       Descripcion
    ============  ===================
    inuitem:       Id del item.

    Historia de Modificaciones
    Fecha Autor Modificacion
    ========= ========= ====================

  ******************************************************************/
  FUNCTION GetDaywarranty(inuitem in ld_fnb_warranty.item_id%type)

   RETURN number;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad : Getfechsale
    Descripcion : Obtiene la fecha de venta con la se realizó este articulo

    Autor : AAcuna
    Fecha : 04/07/2013

    Parametros       Descripcion
    ============  ===================
    inuitem:       Id del item.

    Historia de Modificaciones
    Fecha Autor Modificacion
    ========= ========= ====================

  ******************************************************************/
  PROCEDURE Getfechsale(inuitem    in ld_fnb_warranty.item_id%type,
                        inupack    in ld_fnb_warranty.package_id%type,
                        dtfechsale out mo_packages.request_date%type);

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad : GetDateDeliveryItem
    Descripcion : Obtiene la fecha de entrega del articulo en casos que
                    que se realiza la entrega en punto.
    ******************************************************************/
    PROCEDURE GetDateDeliveryItem
    (
        inuArticule     in  ld_item_work_order.article_id%type,
        inuPackage      in  or_order_activity.package_id%type,
        odtDateDelivery out date
    );

    /*****************************************************************
    Unidad : fnuGetArticle
    Descripcion : Obtiene el id del articulo del item de la orden
   ******************************************************************/
  FUNCTION fnuGetArticle(inuItem ld_fnb_warranty.item_id%type)
  return ld_article.article_id%type;

end LD_BCFNBWARRANTY;
/
CREATE OR REPLACE package body adm_person.LD_BCFNBWARRANTY is
/*****************************************************************
Propiedad intelectual de Open International Systems (c).

Unidad         : LD_BCFNBWARRANTY
Descripcion    : Paquete BC con las funciones y/o procedimientos que contendrá la solicitud de garantía.
Autor          : Kbaquero
Fecha          : 08/10/2012 SAO 159480

Historia de Modificaciones
Fecha            Autor            Modificación
==========  ===================   ================================
28-11-2013  hjgomez.SAO225271     Se crea <<fnuGetArticle>>
                                  Se modifica <<procmotiWarranty>>
27-09-2013  jcarrillo.SAO217956   1 - Se adiciona el método <GetDateDeliveryItem>
******************************************************************/

  -- Declaracion de variables y tipos globales privados del paquete

  -- Constante con el SAO de la ultima version aplicada
  csbVERSION CONSTANT VARCHAR2(10) := 'SAO225271';

  -- Definicion de metodos publicos y privados del paquete

  /*****************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure      :  fsbVersion
  Descripcion    :  Obtiene la Version actual del Paquete

  Parametros     :  Descripción
  Retorno        :
  csbVersion        Version del Paquete

  Autor          :  kbaquero SAO 159480
  Fecha          :  08/10/2012

  Historia de Modificaciones
  Fecha            Autor       Modificación
  =========      =========  ====================
  *****************************************************************/

  FUNCTION fsbVersion RETURN varchar2 IS
  BEGIN
    pkErrors.Push('LD_BCFNBWARRANTY.fsbVersion');
    pkErrors.Pop;
    -- Retorna el SAO con que se realizo la ultima entrega
    RETURN(csbVersion);
  END fsbVersion;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : fbcExistWarranty
   Descripcion    : Retorna `Y� si actualmente existe una solicitud de garantía asociada a la solicitud de venta,
                   de lo contrario retorna `N�
   Autor          : Kbaquero SAO 159480
   Fecha          : 08/10/2012

   Parametros             Descripción
   ============        ===================
  inuItem             :Identificación del ítem del cual se está realizando la solicitud de garantía.

   Historia de Modificaciones
   Fecha         Autor       Modificacion
   =========   ========= ====================

   ******************************************************************/

  FUNCTION fbcExistWarranty(inuItem     in ld_fnb_warranty.item_id%type,
                            inupacksale in ld_fnb_warranty.package_sale_id%type)
    RETURN varchar2 IS

    --Declaración de variables
    sbexist varchar2(1);
  BEGIN

    ut_trace.Trace('INICIO LD_BCFNBWARRANTY.fbcExistWarranty', 10);

    SELECT decode(count(*), 0, 'N', 'Y')
      INTO sbexist
      FROM mo_packages m, ld_fnb_warranty f
     WHERE f.package_id = m.package_id
       AND f.item_id = inuItem
       AND f.package_sale_id = inupacksale
       AND m.motive_status_id = 13;

    ut_trace.Trace('FIN LD_BCFNBWARRANTY.fbcExistWarranty', 10);

    RETURN(sbexist);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fbcExistWarranty;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : procmotiWarranty
   Descripcion    :
   Autor          : Kbaquero SAO 159480
   Fecha          : 08/10/2012

   Parametros             Descripción
   ============        ===================
  inuItem             :Identificación del ítem del cual se está realizando la solicitud de garantía.

   Historia de Modificaciones
   Fecha         Autor              Modificacion
   =========   =========            ====================
   28-11-2013   hjgomez.SAO225271   Se agrega ld_item_work_order
   ******************************************************************/

  PROCEDURE procmotiWarranty(inupack    in ld_fnb_warranty.package_sale_id%type,
                             Orfmotiwar out pkConstante.tyRefCursor) IS

  BEGIN

    ut_trace.Trace('INICIO LD_BCFNBWARRANTY.ProcSearchPolicyId', 10);

    OPEN Orfmotiwar FOR

      select /*+ (IDX_LD_FNB_WARRANTY_02) use_nls (f l)*/
       item_id, l.supplier_id
        from ld_fnb_warranty f, ld_article l, ld_item_work_order
       where package_id = inupack
         AND ld_item_work_order.item_work_order_id =  f.item_id
         AND ld_item_work_order.article_id = l.article_id
       order by l.supplier_id;

    ut_trace.Trace('FIN LD_BCFNBWARRANTY.procmotiWarranty', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END procmotiWarranty;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad : frfGetOperating
    Descripcion : Retorna la unidad operativa que pertenece a un articulo

    Autor : AAcuna
    Fecha : 04/07/2013

    Parametros       Descripcion
    ============  ===================
    inuitem:       Id del item.

    Historia de Modificaciones
    Fecha Autor Modificacion
    ========= ========= ====================

  ******************************************************************/
  FUNCTION frfGetOperating(inuitem in ld_article.article_id%type)

   RETURN constants.tyrefcursor IS

    rfOperating_Unit constants.tyrefcursor;

  BEGIN

    ut_trace.Trace('INICIO LD_BCFNBWARRANTY.frfGetOperating', 10);

    OPEN rfOperating_Unit FOR
      SELECT o.*
        FROM ld_article p, ge_contratista ge, or_operating_unit o
       WHERE p.supplier_id = ge.id_contratista
         AND ge.id_contratista = o.contractor_id
         AND p.article_id = inuitem
         and rownum = 1;

    RETURN rfOperating_Unit;

    ut_trace.Trace('FIN LD_BCFNBWARRANTY.frfGetOperating', 10);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END frfGetOperating;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad : GetDaywarranty
    Descripcion : Obtiene los días de Garantía que tiene un articulo

    Autor : AAcuna
    Fecha : 04/07/2013

    Parametros       Descripcion
    ============  ===================
    inuitem:       Id del item.

    Historia de Modificaciones
    Fecha Autor Modificacion
    ========= ========= ====================

  ******************************************************************/
  FUNCTION GetDaywarranty(inuitem in ld_fnb_warranty.item_id%type)

   return number IS

    nudias number;

  BEGIN

    ut_trace.Trace('INICIO LD_BCFNBWARRANTY.GetDaywarranty', 10);

    SELECT l.warranty
      INTO nudias
      FROM ld_article l
     WHERE l.article_id = inuitem --218
       AND rownum = 1;

    RETURN nudias;

    ut_trace.Trace('FIN LD_BCFNBWARRANTY.GetDaywarranty', 10);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END GetDaywarranty;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad : Getfechsale
    Descripcion : Obtiene la fecha de venta con la se realizó este articulo

    Autor : AAcuna
    Fecha : 04/07/2013

    Parametros       Descripcion
    ============  ===================
    inuitem:       Id del item.

    Historia de Modificaciones
    Fecha Autor Modificacion
    ========= ========= ====================

  ******************************************************************/
  PROCEDURE Getfechsale(inuitem    in ld_fnb_warranty.item_id%type,
                        inupack    in ld_fnb_warranty.package_id%type,
                        dtfechsale out mo_packages.request_date%type)

   IS

  BEGIN

    ut_trace.Trace('INICIO LD_BCFNBWARRANTY.Getfechsale', 10);

    SELECT l.sale_date
      INTO dtfechsale
      FROM ld_non_ba_fi_requ l, ld_non_ban_fi_item i
     WHERE l.non_ba_fi_requ_id = i.non_ba_fi_requ_id
       AND i.article_id = inuitem --218
       AND l.non_ba_fi_requ_id = inupack --459
       AND rownum = 1;

    ut_trace.Trace('FIN LD_BCFNBWARRANTY.Getfechsale', 10);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;

  END Getfechsale;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad : GetDateDeliveryItem
    Descripcion : Obtiene la fecha de entrega del articulo en casos que
                    que se realiza la entrega en punto.

    Autor : jcarrilo
    Fecha : 27/09/2013

    Historia de Modificaciones
    Fecha       Autor               Modificacion
    ==========  =================== =========================
    27-09-2013  jcarrillo.SAO217956 1 - Creación
    ******************************************************************/
    PROCEDURE GetDateDeliveryItem
    (
        inuArticule     in  ld_item_work_order.article_id%type,
        inuPackage      in  or_order_activity.package_id%type,
        odtDateDelivery out date
    )
    IS
        nuActivityDelivery  or_order_activity.activity_id%type;

        CURSOR cuGetDateDeliveryItem
        (
            inuArticuleId   in  ld_item_work_order.article_id%type,
            inuPackageId    in  or_order_activity.package_id%type,
            inuActivityId   in  or_order_activity.activity_id%type
        )
        IS
            SELECT  /*+
                        leading (or_order_activity)
                        index(or_order_activity IDX_OR_ORDER_ACTIVITY_06)
                        index(ld_item_work_order IX_LD_ITEM_WORK_ORDER01)
                        index(OR_order PK_OR_order)
                    */
                    nvl(OR_order.execution_final_date, OR_order.legalization_date)
            FROM    /*+ LD_BCFNBWARRANTY.GetDateDeliveryItem */
                    ld_item_work_order, or_order_activity, OR_order
            WHERE   or_order_activity.package_id = inuPackageId
            AND     or_order_activity.activity_id = inuActivityId
            AND     or_order_activity.order_activity_id = ld_item_work_order.order_activity_id
            AND     ld_item_work_order.article_id = inuArticuleId
            AND     ld_item_work_order.order_id = OR_order.order_id;

    BEGIN
        ut_trace.Trace('FIN LD_BCFNBWARRANTY.GetDateDeliveryItem', 10);

        nuActivityDelivery := dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB');

        open    cuGetDateDeliveryItem(inuArticule,inuPackage,nuActivityDelivery);
        fetch   cuGetDateDeliveryItem INTO odtDateDelivery;
        close   cuGetDateDeliveryItem;

        ut_trace.Trace('FIN LD_BCFNBWARRANTY.GetDateDeliveryItem', 10);

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            if(cuGetDateDeliveryItem%isopen)
            then
                close   cuGetDateDeliveryItem;
            end if;
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            if(cuGetDateDeliveryItem%isopen)
            then
                close   cuGetDateDeliveryItem;
            end if;
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END GetDateDeliveryItem;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad : fnuGetArticle
    Descripcion : Obtiene el id del articulo del item de la orden

    Autor : Joiman Gomez
    Fecha : 28-11-2013

    Parametros       Descripcion
    ============  ===================
    inuitem:       Id del item.

    Historia de Modificaciones
    Fecha       Autor               Modificacion
    =========   =========           ====================
    28-11-2013  hjgomez.SAO225271   Creación
   ******************************************************************/
  FUNCTION fnuGetArticle(inuItem ld_fnb_warranty.item_id%type)
  return ld_article.article_id%type
   IS
   nuArticle  ld_article.article_id%type;
  BEGIN

    ut_trace.Trace('INICIO LD_BCFNBWARRANTY.fnuGetArticle', 10);

    SELECT article_id
      INTO nuArticle
      FROM ld_item_work_order
     WHERE item_work_order_id=inuItem;
    return nuArticle;
    ut_trace.Trace('FIN LD_BCFNBWARRANTY.fnuGetArticle', 10);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;

  END fnuGetArticle;

end LD_BCFNBWARRANTY;
/
PROMPT Otorgando permisos de ejecucion a LD_BCFNBWARRANTY
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BCFNBWARRANTY', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LD_BCFNBWARRANTY para reportes
GRANT EXECUTE ON adm_person.LD_BCFNBWARRANTY TO rexereportes;
/
