CREATE OR REPLACE PACKAGE adm_person.LDC_BONOTIFICACIONES is
 /**************************************************************************
    Propiedad intelectual de Gases de Occidente.
    Nombre del Paquete: LDC_BOmetrologia
    Descripcion : Paquete para las Notificaciones
    Autor       : llozada.
    Fecha       : 03 Diciembre de 2013
    Historia de Modificaciones
      Fecha             Autor                Modificaci?n
    =========         =========          ====================
    05-03-2015        Mmejia              Creacion ARA6335 <<fsbGetCommentRPAsociados>>
    03-12-2013         llozada            Creacion.
   **************************************************************************/
    type tyrcTemp    IS record (
      package_id        MO_PACKAGES.PACKAGE_ID%type,
      task_type_id      or_task_type.task_type_id%type,
      oder_id           OR_order.order_id%type
    );
    rcOrderTemp tyrcTemp;

    -- Obtiene la Version actual del Paquete
    FUNCTION FSBVERSION RETURN VARCHAR2;
 /*Funcion que devuelve el consumo promedio dada la orden*/
    FUNCTION getConsumoPromedio(inuOrder_id or_order.order_id%type)
    return number;
    /*Funcion que trae la ultima lectura del producto dada la orden*/
    FUNCTION getUltimaLectura(inuOrder_id or_order.order_id%type)
    return number;
    /*Funcion que devuelve el ultimo consumo facturado*/
    FUNCTION getUltimoConsumo(inuOrder_id or_order.order_id%type)
    return number;
    FUNCTION getMarca_medidor(inuSusccodi suscripc.susccodi%type)
    return varchar2;
    FUNCTION getModelo_medidor(inuSusccodi suscripc.susccodi%type)
    return varchar2;
    function fsbNumMedidor(nuContrato   suscripc.susccodi%type)
    return Varchar2;
    function fnuGetPresionMedicion(nuContrato   suscripc.susccodi%type)
    return number;
    function  fsbPromocionesVenta (inuOrderId or_order.order_id%type)
    return varchar2;
    function  fsbPuntosAdicionales (inuOrderId or_order.order_id%type)
    return varchar2;
    FUNCTION getAddressProduct(inupackageid or_order_activity.package_id%type)
    return number;
    function  fsbCorreccionDefectos (inuOrderId or_order.order_id%type)
    return varchar2;
    FUNCTION getAddressOrder(inuOrder_id or_order_activity.order_id%type)
    return number;

    /***********************************************************************************
    Propiedad intelectual de PETI.
    Unidad         : fsbGetCommentRPAsociados
    Descripcion    : Procedimiento que obtiene los comentarios de las ordenes de RP
                     Asociadas
    Autor          : Mmejia
    Fecha          : 05/03/2015

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========     ===================   ===============================================
    05-03-2015    Mmejia                Creación. ARA6335
    ***********************************************************************************/
    FUNCTION fsbGetCommentRPAsociados(inuOrderId or_order.order_id%TYPE) RETURN VARCHAR2;
END ldc_bonotificaciones;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BONOTIFICACIONES is
 /**************************************************************************
    Propiedad intelectual de Gases de Occidente.
    Nombre del Paquete: LDC_BOmetrologia
    Descripcion : Paquete para las Notificaciones
    Autor       : llozada.
    Fecha       : 03 Diciembre de 2013
    Historia de Modificaciones
      Fecha             Autor                Modificaci?n
    =========         =========          ====================
    05-03-2015        Mmejia              Creacion ARA6335 <<fsbGetCommentRPAsociados>>
    03-12-2013         llozada            Creacion.
   **************************************************************************/

    -- Declaracion de variables y tipos globales privados del paquete
    ---------------------------------------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    ---------------------------------------------------------------------------
    CSBVERSION                        CONSTANT   varchar2(40)  := 'OSF-2884';
        /*
      Funci?n que devuelve la versi?n del pkg*/
    FUNCTION FSBVERSION RETURN VARCHAR2 IS
    BEGIN
      return CSBVERSION;
    END FSBVERSION;
    /*Funcion que trae la ultima lectura del producto dada la orden*/
    FUNCTION getUltimaLectura(inuOrder_id or_order.order_id%type)
    return number
    IS
        CURSOR cuConsumo(inuProduct_id pr_product.product_id%type)
        IS
            SELECT max(cosspecs)
            FROM conssesu
            WHERE cosssesu = inuProduct_id
            AND cossmecc = 4
            AND cossflli = 'S';
        CURSOR cuLectura(inuPeriodo conssesu.cosspecs%type, inuProduct_id pr_product.product_id%type)
        IS
            SELECT LEEMLETO
            FROM lectelme
            WHERE leemsesu = inuProduct_id
            AND leempecs = inuPeriodo;
        nuProducto      pr_product.product_id%type;
        nuPeriodo       conssesu.cosspecs%type;
        nuLecturaAnt    lectelme.leemleto%type;
    BEGIN
        nuProducto := ldc_boutilities.fsbGetValorCampoTabla('OR_ORDER_ACTIVITY','ORDER_ID','PRODUCT_ID',inuOrder_id);
        open cuConsumo(nuProducto);
        fetch cuConsumo INTO nuPeriodo;
        close cuConsumo;
        if nuPeriodo IS null then
            --ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
            --                             'Error el producto ['||nuProducto||'] no tiene un periodo activo.');
            return 0;
        END if;
        open cuLectura(nuPeriodo,nuProducto);
        fetch cuLectura INTO nuLecturaAnt;
        close cuLectura;
        if nuLecturaAnt IS null then
            --ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
            --                             'Error el producto ['||nuProducto||'] no tiene Lecturas Anteriores.');
            return 0;
        END if;
        return nuLecturaAnt;
    END getUltimaLectura;
    /*Funcion que devuelve el consumo promedio dada la orden*/
    FUNCTION getConsumoPromedio(inuOrder_id or_order.order_id%type)
    return number
    IS
        CURSOR cuConsumo(inuProduct_id pr_product.product_id%type)
        IS
            SELECT max(cosspecs)
            FROM conssesu
            WHERE cosssesu = inuProduct_id
            AND cossmecc = 4
            AND cossflli = 'S';
        CURSOR cuPromedio(inuPeriodo conssesu.cosspecs%type, inuProduct_id pr_product.product_id%type)
        IS
            SELECT hcppcopr
            FROM hicoprpm
            WHERE hcppsesu = inuProduct_id
            AND hcpppeco = inuPeriodo;
        nuProducto      pr_product.product_id%type;
        nuPeriodo       conssesu.cosspecs%type;
        nuConsProme     hicoprpm.hcppcopr%type;
    BEGIN
        nuProducto := ldc_boutilities.fsbGetValorCampoTabla('OR_ORDER_ACTIVITY','ORDER_ID','PRODUCT_ID',inuOrder_id);
        open cuConsumo(nuProducto);
        fetch cuConsumo INTO nuPeriodo;
        close cuConsumo;
        if nuPeriodo IS null then
            --ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
            --                             'Error el producto ['||nuProducto||'] no tiene un periodo activo.');
            return 0;
        END if;
        open cuPromedio(nuPeriodo,nuProducto);
        fetch cuPromedio INTO nuConsProme;
        close cuPromedio;
        if nuConsProme IS null then
            --ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
            --                             'Error el producto ['||nuProducto||'] no tiene Lecturas Anteriores.');
            return 0;
        END if;
        return nuConsProme;
    END getConsumoPromedio;
    /*Funcion que devuelve el ultimo consumo facturado*/
    FUNCTION getUltimoConsumo(inuOrder_id or_order.order_id%type)
    return number
    IS
        CURSOR cuConsumo(inuProduct_id pr_product.product_id%type)
        IS
            SELECT max(cosspecs)
            FROM conssesu
            WHERE cosssesu = inuProduct_id
            AND cossmecc = 4
            AND cossflli = 'S';
        CURSOR cuUltimoConsumo(inuPeriodo conssesu.cosspecs%type, inuProduct_id pr_product.product_id%type)
        IS
            SELECT cosscoca
            FROM conssesu
            WHERE cosssesu = inuProduct_id
            AND cossmecc = 4
            AND cossflli = 'S'
            AND  cosspecs=inuPeriodo;
        nuProducto      pr_product.product_id%type;
        nuPeriodo       conssesu.cosspecs%type;
        nuConsProme     conssesu.cosscoca%type;
    BEGIN
        nuProducto := ldc_boutilities.fsbGetValorCampoTabla('OR_ORDER_ACTIVITY','ORDER_ID','PRODUCT_ID',inuOrder_id);
        open cuConsumo(nuProducto);
        fetch cuConsumo INTO nuPeriodo;
        close cuConsumo;
        if nuPeriodo IS null then
            --ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
            --                             'Error el producto ['||nuProducto||'] no tiene un periodo activo.');
            return 0;
        END if;
        open cuUltimoConsumo(nuPeriodo,nuProducto);
        fetch cuUltimoConsumo INTO nuConsProme;
        close cuUltimoConsumo;
        if nuConsProme IS null then
            --ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
            --                             'Error el producto ['||nuProducto||'] no tiene Lecturas Anteriores.');
            return 0;
        END if;
        return nuConsProme;
    END getUltimoConsumo;
    /*Funcion que devuelve la marca del medidor*/
    FUNCTION getMarca_medidor(inuSusccodi suscripc.susccodi%type)
    return varchar2
    IS
    cursor cuMarMedidor is
        select IT.ID_ITEMS_SERIADO  nuid_item
          from servsusc ss,elmesesu el, ge_items_seriado it
         where ss.sesunuse = el.emsssesu
           and ss.sesususc = inuSusccodi
           and ss.sesuserv = 7014
           and EL.EMSSCOEM = IT.SERIE
           and sysdate between EL.EMSSFEIN and EL.EMSSFERE
           and rownum < 2;
    nuIdItemSeriado GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%type;
    sbCadeana Varchar2(2000);
begin
    for rcMarMedidor in cuMarMedidor loop
         nuIdItemSeriado := rcMarMedidor.nuid_item;
    end loop;
    select LDC_BOUTILITIES.fsbgetvalorcampostabla('GE_ITEMS_TIPO_AT_VAL','ID_ITEMS_SERIADO','VALOR',nuIdItemSeriado,'ID_ITEMS_TIPO_ATR','1000028')
    into sbCadeana
    from dual;
    -- Retorna el valor obtenido
    return sbCadeana;
    END getMarca_medidor;
    /*Funcion que devuelve el modelo del medidor*/
    FUNCTION getModelo_medidor(inuSusccodi suscripc.susccodi%type)
    return varchar2
    IS
    cursor cuMarMedidor is
        select IT.ID_ITEMS_SERIADO  nuid_item
          from servsusc ss,elmesesu el, ge_items_seriado it
         where ss.sesunuse = el.emsssesu
           and ss.sesususc = inuSusccodi
           and ss.sesuserv = 7014
           and EL.EMSSCOEM = IT.SERIE
           and sysdate between EL.EMSSFEIN and EL.EMSSFERE
           and rownum < 2;
    nuIdItemSeriado GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%type;
    sbCadeana Varchar2(2000);
begin
    for rcMarMedidor in cuMarMedidor loop
         nuIdItemSeriado := rcMarMedidor.nuid_item;
    end loop;
    select LDC_BOUTILITIES.fsbgetvalorcampostabla('GE_ITEMS_TIPO_AT_VAL','ID_ITEMS_SERIADO','VALOR',nuIdItemSeriado,'ID_ITEMS_TIPO_ATR','1000029')
    into sbCadeana
    from dual;
    -- Retorna el valor obtenido
    return sbCadeana;
    END getModelo_medidor;
 /*Funcion que devuelve el serial del medidor*/
function fsbNumMedidor(nuContrato   suscripc.susccodi%type)
    return Varchar2
is
    cursor cuNumMedidor is
        select el.emsscoem  description
          from servsusc ss,elmesesu el
         where ss.sesunuse = el.emsssesu
           and ss.sesususc = nuContrato
           and ss.sesuserv = 7014
           and sysdate between EL.EMSSFEIN and EL.EMSSFERE
           and rownum < 2;
    sbCadeana Varchar2(2000);
begin
    for rcNumMedidor in cuNumMedidor loop
         sbCadeana := rcNumMedidor.description;
    end loop;
    -- Retorna el valor calculado
    return sbCadeana;
EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbNumMedidor;

 /*Funcion que devuelve el serial del medidor*/
function fnuGetPresionMedicion(nuContrato   suscripc.susccodi%type)
    return number
is
    cursor cuCM_VAVAFACO is
        select VVFCVALO  PRESION
          from servsusc ss,CM_VAVAFACO el
         where ss.sesunuse = el.VVFCSESU
           and ss.sesususc = nuContrato
           and ss.sesuserv = 7014
           and sysdate between EL.VVFCFEIV and EL.VVFCFEFV
           and EL.VVFCVAFC = 'PRESION_OPERACION'
           and rownum < 2;
    sbCadeana Varchar2(2000);
    --nuValor cm_bcvavafaco.tyrcVariableData;
    nuRetorno number;
    nuProducto servsusc.sesunuse%type;
    nuAddress_id pr_product.address_id%type;
    nuUbGeogra ab_address.geograp_location_id%type;
BEGIN
    for rcCM_VAVAFACO in cuCM_VAVAFACO loop
         nuRetorno := rcCM_VAVAFACO.PRESION;
    end loop;
    if nuRetorno is null then
        begin
          select sesunuse into nuProducto
            from servsusc
           where sesususc = nuContrato
             and sesuserv = 7014
             and rownum = 1;
          nuAddress_id := dapr_product.fnugetaddress_id(nuProducto);
          nuUbGeogra   := daab_address.fnugetgeograp_location_id(nuAddress_id);
          select VVFCVALO  INTO nuRetorno
            from CM_VAVAFACO el
           where sysdate between EL.VVFCFEIV and EL.VVFCFEFV
             and EL.VVFCVAFC = 'PRESION_OPERACION'
             and EL.VVFCUBGE = nuUbGeogra
             and rownum < 2;
        exception
        when others then
         nuRetorno := -1;
        end;
    end if;
    -- Retorna el valor calculado
    return nuRetorno;
EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fnuGetPresionMedicion;
 /*****************************************************************
  Propiedad intelectual de PETI (c).
  Unidad         : fsbPromocionesVenta
  Descripcion    : Función para obtener las promociones de la venta asociadas a la orden
  Autor          : Jhon Jairo Soto
  Fecha          : 12/02/2014
  Parametros              Descripcion
  ============         ===================
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  function  fsbPuntosAdicionales (inuOrderId or_order.order_id%type) return varchar2
  is
  --Cursor par obtener las promociones registradas durante a venta
    cursor cuPuntosAdicionales (inuPackage_id in OR_ORDER_ACTIVITY.PACKAGE_ID%type) is
           select DISTINCT A.ITEMS_ID||'-'||dage_items.fsbgetdescription(A.ITEMS_ID) ||' Cant: '|| A.ITEMS_QUANTITY items
             from OPEN.CC_QUOTATION_ITEM A, OPEN.CC_QUOTATION B, OPEN.OR_ORDER_ACTIVITY C
            where A.QUOTATION_ID = B.QUOTATION_ID
              AND B.PACKAGE_ID = C.PACKAGE_ID
              AND C.PACKAGE_ID = inuPackage_id;

      sbPuntosAdicionales               varchar2(30000);
      nuPackage_id                      OR_ORDER_ACTIVITY.PACKAGE_ID%type;

  begin
        nuPackage_id := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                                    'ORDER_ID',
                                                                    'PACKAGE_ID',
                                                                    inuOrderId);
        --Obtener las promociones asociadas a la orden y concatenarlas
         for rgPuntosAdic in cuPuntosAdicionales(nuPackage_id) loop
             sbPuntosAdicionales := sbPuntosAdicionales||rgPuntosAdic.items||' | ';
         end loop;

   return sbPuntosAdicionales;
   exception
    WHEN NO_DATA_FOUND THEN
      sbPuntosAdicionales := ' ';
      return sbPuntosAdicionales;
    when others then
      sbPuntosAdicionales := sqlcode||' - '||sqlerrm;
      return sbPuntosAdicionales;
  end fsbPuntosAdicionales;
  function  fsbPromocionesVenta (inuOrderId or_order.order_id%type) return varchar2
  is
  --Cursor par obtener las promociones registradas durante a venta
    cursor cuPromocionVenta is
           select A.PROMOTION_ID ||'-'||DACC_PROMOTION.FSBGETDESCRIPTION(A.PROMOTION_ID) DESCRIPTION
             from MO_MOT_PROMOTION A, MO_MOTIVE B, MO_PACKAGES C, OR_ORDER_ACTIVITY D
            WHERE A.MOTIVE_ID = B.MOTIVE_ID
              AND B.PACKAGE_ID = C.PACKAGE_ID
              AND D.PACKAGE_ID = C.PACKAGE_ID
              AND D.ORDER_ID = inuOrderId;

      sbPromociones               varchar2(30000);

  begin
        --Obtener las promociones asociadas a la orden y concatenarlas
         for rgPromociones in cuPromocionVenta loop
             sbPromociones := sbPromociones||rgPromociones.DESCRIPTION||' | ';
         end loop;

   return sbPromociones;
   exception
    WHEN NO_DATA_FOUND THEN
      sbPromociones := 'No registra';
      return sbPromociones;
    when others then
      sbPromociones := sqlcode||' - '||sqlerrm;
      return sbPromociones;
  end fsbPromocionesVenta;
    /*Funcion que trae la direccion del servicio al que se registra la solicitud*/
    FUNCTION getAddressProduct(inupackageid or_order_activity.package_id%type)
    return number
    IS
        CURSOR cuMo_motive is
            SELECT DISTINCT B.ADDRESS_ID
            FROM MO_MOTIVE A, PR_PRODUCT B
            WHERE A.PRODUCT_ID = B.PRODUCT_ID
            AND A.PACKAGE_ID = inupackageid;
            nuAddressId  OR_ORDER_ACTIVITY.ADDRESS_ID%type;
    BEGIN
        open cuMo_motive;
        fetch cuMo_motive INTO nuAddressId;
        close cuMo_motive;
        if nuAddressId IS null then
            nuAddressId := ldc_boutilities.fsbGetValorCampoTabla('MO_ADDRESS','PACKAGE_ID','ADDRESS_ID',inupackageid);
        END if;
        if nuAddressId = -1 then
            nuAddressId := ldc_boutilities.fsbGetValorCampoTabla('MO_PACKAGES','PACKAGE_ID','ADDRESS_ID',inupackageid);
        END if;
         return nuAddressId;
    END getAddressProduct;
  function  fsbCorreccionDefectos (inuOrderId or_order.order_id%type) return varchar2
  is
  --Cursor par obtener las promociones registradas durante a venta
    cursor cuDefectos is
        SELECT A.ITEMS_ID ||'-'|| B.DESCRIPTION  DESCRIPTION
        FROM OR_ORDER_ITEMS A,
             GE_ITEMS B,
             OR_TASK_TYPES_ITEMS C,
             OR_ORDER D
        WHERE A.ITEMS_ID = B.ITEMS_ID
          AND A.ORDER_ID = D.ORDER_ID
          AND D.TASK_TYPE_ID = C.TASK_TYPE_ID
          AND C.ITEM_AMOUNT = 0
          AND A.ITEMS_ID = C.ITEMS_ID
          AND A.ORDER_ID = inuOrderId;

      sbDefectos               varchar2(30000);

  begin
        --Obtener las promociones asociadas a la orden y concatenarlas
         for regDefectos in cuDefectos loop
             sbDefectos := sbDefectos||regDefectos.DESCRIPTION||' | ';
         end loop;

   return sbDefectos;
   exception
    WHEN NO_DATA_FOUND THEN
      sbDefectos := 'No registra';
      return sbDefectos;
    when others then
      sbDefectos := sqlcode||' - '||sqlerrm;
      return sbDefectos;
  end fsbCorreccionDefectos;

    FUNCTION getAddressOrder(inuOrder_id or_order_activity.order_id%type)
    return number
    IS
    -- Funcion usada desde la sentencia 120009035  para notificacion 100154  PQR
    cursor cuOrder_Activity is
    select  or_order_activity.subscriber_id cliente,
              or_order_activity.subscription_id contrato,
              or_order_activity.product_id producto,
              OR_ORDER_ACTIVITY.ADDRESS_ID address_id,
              OR_ORDER_ACTIVITY.PACKAGE_ID PACKAGE_ID
    from or_order_activity
    where or_order_activity.order_id = inuOrder_id;
            nuAddressId         OR_ORDER_ACTIVITY.ADDRESS_ID%type :=-1;
            regOrder_activity   cuOrder_Activity%rowtype;
            nutypePackage       MO_PACKAGES.PACKAGE_TYPE_ID%TYPE;
    BEGIN
        open cuOrder_Activity;
        fetch cuOrder_Activity INTO regOrder_activity;
        close cuOrder_Activity;
        nutypePackage := DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(regOrder_activity.PACKAGE_ID);
        if nutypePackage = 545  then
           nuAddressId := regOrder_activity.address_id;
        elsif regOrder_activity.producto is not null then
              nuAddressId := regOrder_activity.address_id;
        elsif regOrder_activity.contrato is not null then
              select address_id into nuAddressId
              from pr_product
              where subscription_id = regOrder_activity.contrato
              and rownum = 1
              order by product_type_id asc;
        elsif regOrder_activity.cliente is not null then
              nuAddressId := regOrder_activity.address_id;
        end if;
         return nuAddressId;
    END getAddressOrder;


    /***********************************************************************************
    Propiedad intelectual de PETI.
    Unidad         : fsbGetCommentRPAsociados
    Descripcion    : Procedimiento que obtiene los comentarios de las ordenes de RP
                     Asociadas
    Autor          : Mmejia
    Fecha          : 05/03/2015

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========     ===================   ===============================================
    05-03-2015    Mmejia                Creación. ARA6335
    ***********************************************************************************/
    FUNCTION fsbGetCommentRPAsociados(inuOrderId or_order.order_id%TYPE)
    RETURN VARCHAR2
    IS

      --Variables
      sbComment   VARCHAR2(30000);
      nuProductId pr_product.product_id%type;
      nuOrderRP   or_order.order_id%type;

      --Cursor para obtener el comentatio de la ot
      CURSOR cuComment(inuOrderId2 or_order.order_id%type)
      IS
      SELECT or_order_comment.order_comment COMENTARIO_ORDEN,or_order_comment.order_id ORDEN
      FROM OR_ORDER_ACTIVITY,OR_ORDER_COMMENT WHERE PACKAGE_ID IN ( SELECT PACKAGE_ID FROM OPEN.OR_ORDER_ACTIVITY
        WHERE ORDER_ID=inuOrderId2) AND TASK_TYPE_ID IN
      (SELECT To_Number(column_value)
          FROM TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('TIPO_TRABAJO_SERV_ING',NULL),',')))
        AND or_order_comment.order_id=OR_ORDER_ACTIVITY.order_id
        AND or_order_comment.legalize_comment = 'Y';

      --Cursor de ordenes PNO
      CURSOR cuCommentPNO(inuOrderId2 or_order.order_id%TYPE)
      IS
      SELECT or_order_comment.order_comment COMENTARIO_ORDEN,OR_ORDER.order_id ORDEN
      FROM OR_ORDER_COMMENT,OR_ORDER
      WHERE OR_ORDER_COMMENT.order_id=OR_ORDER.order_id
      AND or_order_comment.legalize_comment = 'Y'
      AND OR_ORDER.order_id IN (
      SELECT * FROM(
      SELECT OR_ORDER.order_id ORDEN
      FROM OPEN.OR_ORDER, OPEN.OR_ORDER_ACTIVITY
      WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM OPEN.OR_ORDER_ACTIVITY WHERE ORDER_ID=inuOrderId2)
      AND OR_ORDER.ORDER_ID=OR_ORDER_ACTIVITY.ORDER_ID
      AND LEGALIZATION_DATE IS NOT NULL
      AND OR_ORDER.TASK_TYPE_ID IN
      (SELECT To_Number(column_value)
          FROM TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('TIPO_TRABAJO_PNO_SERV_ING',NULL),',')))
      AND OR_ORDER.order_status_id=8
      ORDER BY LEGALIZATION_DATE DESC) WHERE ROWNUM=1);

      --Cursor ordenes  autonomas
      CURSOR cuCommentAutonomas(inuOrderId2 or_order.order_id%type)
      IS
      SELECT COMMENT_ COMENTARIO_ORDEN, order_id ORDEN
      FROM OPEN.OR_ORDER_ACTIVITY WHERE ORDER_ID=inuOrderId2 AND STATUS='R'
      AND TASK_TYPE_ID IN (SELECT To_Number(column_value)
                              FROM TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('TIPO_TRABAJO_AUTONOMAS',NULL),',')));

      --Cursor de ordenes autonomas legalizadas
      CURSOR cuCommentAutonomasLegalizadas(inuOrderId2 or_order.order_id%type) is
      SELECT COMMENT_ COMENTARIO_ORDEN, order_id ORDEN
      FROM OPEN.OR_ORDER_ACTIVITY
      wHERE ORDER_ID=inuOrderId2 AND STATUS='F'
      AND TASK_TYPE_ID IN (SELECT To_Number(column_value)
                               FROM TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('TIPO_TRABAJO_AUTONOMAS',NULL),',')))
      UNION
      (SELECT or_order_comment.order_comment COMENTARIO_ORDEN,OR_ORDER.order_id ORDEN
      FROM OPEN.OR_ORDER_COMMENT,OPEN.OR_ORDER
      WHERE OR_ORDER_COMMENT.order_id=OR_ORDER.order_id
      AND or_order_comment.legalize_comment = 'Y'
      AND OR_ORDER.ORDER_ID=inuOrderId2);

      nuOrderActivityId or_order_activity.order_activity_id%TYPE;
      nuPackagesId      mo_packages.package_id%TYPE;
    BEGIN

        --<<
        --Obtiene los comentarios de PNO
        -->>
        FOR rgComment IN cuCommentPNO(inuOrderId) LOOP
          sbComment := sbComment ||' Orden PNO: '||rgComment.ORDEN || ' Comentario PNO: '||rgComment.COMENTARIO_ORDEN || ' // ';
        END LOOP;

        --<<
        --Obtiene los comentarios de la orden
        -->>
        FOR rgComment IN cuComment(inuOrderId) LOOP
          sbComment := sbComment ||' Orden: '||rgComment.ORDEN || ' Comentario: '||rgComment.COMENTARIO_ORDEN || ' // ';
        END LOOP;

        --<<
        --Obtiene los comentarios de ordenes autonomas
        -->>
        FOR rgComment IN cuCommentAutonomas(inuOrderId) LOOP
          sbComment := sbComment ||' Orden Asignada: '||rgComment.ORDEN || ' Comentario ORCOM: '||rgComment.COMENTARIO_ORDEN || ' // ';
        END LOOP;

        --<<
        --Obtiene los comentarios de ordenes autonomas legalizadas
        -->>
        FOR rgComment IN cuCommentAutonomasLegalizadas(inuOrderId) LOOP
          sbComment := sbComment ||' Orden Legalizada: '||rgComment.ORDEN || ' Comentario: '||rgComment.COMENTARIO_ORDEN || ' // ';
        END LOOP;

        sbComment := SubStr(sbComment, 1, (Length(sbComment) - 2));
        sbComment := sbComment;

      RETURN sbComment;
    END fsbGetCommentRPAsociados;

END ldc_bonotificaciones;
/
Prompt Otorgando permisos sobre ADM_PERSON.ldc_bonotificaciones
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('ldc_bonotificaciones'), 'ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.LDC_BONOTIFICACIONES to REXEOPEN;
GRANT EXECUTE on ADM_PERSON.LDC_BONOTIFICACIONES to RSELSYS;
/
