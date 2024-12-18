CREATE OR REPLACE PACKAGE adm_person.ldc_pkLDCCO IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    23/07/2024              PAcosta         OSF-2952: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    
    
    -- Author  : LUDYCOM BD
    -- Created : 30/06/2016 12:00:42
    -- Purpose : Manejo del pb LDCCO

    FUNCTION fcrBusqueda RETURN pkConstante.tyRefCursor;

    PROCEDURE proProceso(inuOT           IN or_order.order_id%TYPE,
                         inuCurrent      IN NUMBER,
                         inuTotal        IN NUMBER,
                         onuErrorCode    OUT NUMBER,
                         osbErrorMessage OUT VARCHAR2);

END ldc_pkLDCCO;
/
CREATE OR REPLACE PACKAGE BODY adm_person.ldc_pkLDCCO IS

    csbPaquete CONSTANT VARCHAR2(100) DEFAULT 'ldc_pkLDCCO';
    cnuDescripcionError NUMBER := 2741;
    csbEntrega200209 CONSTANT VARCHAR2(100) := 'OSS_CON_SMS_200209_3';

    FUNCTION fcrBusqueda RETURN pkConstante.tyRefCursor IS
        /*******************************************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: fcrBusqueda
        Descripcion:        Devuelve los datos para mostrar en LDCCO

        Autor    : Sandra Mu?oz
        Fecha    : 01-07-2016 CA 200-209

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    --------------------------------------------------------
        01-07-2016    Sandra Mu?oz           Creacion
        27-07-2016    John Jairo Jimenez     1) Se agregan validaciones a los campos de entrada de la pantalla
                                             2) Se crea fucnion para obtener la orden padre, por tal razon se
                                                elimina el union all del cursor de busquedas y se optimiza
                                                la consulta
		 31/05/2018    ljlB                    Modificacion de  consulta para que se tenga en cuentas las ordenes
                                              en estado  LDC_ESTAORDACONS
         08/02/2024    Jorge Valiente         OSF-2321: Agregar el estado SU en al consulta asociacion contrato-actual                                   
        ********************************************************************************************/

        rfcursor pkConstante.tyRefCursor;

        -- Datos en la pantalla
        sbID_CONTRATISTA    ge_boInstanceControl.stysbValue;
        sbOPERATING_UNIT_ID ge_boInstanceControl.stysbValue;
        sbID_TIPO_CONTRATO  ge_boInstanceControl.stysbValue;
        sbID_CONTRATO       ge_boInstanceControl.stysbValue;
        sbASSIGNED_DATE     ge_boInstanceControl.stysbValue;
        sbIdContratodesc      ge_boInstanceControl.stysbValue; -- Campo
        cnuNULL_ATTRIBUTE CONSTANT NUMBER := 2126;

        -- Variables
        nuContratista      ge_contratista.id_contratista%TYPE; -- Contratista
        nuUnidadOperativa  or_operating_unit.operating_unit_id%TYPE; -- Unidad operativa
        nuTipoContrato     ge_tipo_contrato.id_tipo_contrato%TYPE; -- Tipo de contrato
        nuContratoActual   ge_contrato.id_contrato%TYPE; -- Contrato
        dtFechaAsignacion  or_order.assigned_date%TYPE; -- Fecha de asignacion
        nuEstadoCerradoOT  ld_parameter.numeric_value%TYPE; -- Estado 8
        sbError            ge_error_log.description%TYPE; -- Error
        nuExiste           NUMBER; -- Indica si un elemento existe
        nuClaseCausalExito ld_parameter.numeric_value%TYPE; -- Clase 1
        nuPaso             NUMBER; -- Paso donde se presenta un error
        nuconta            NUMBER(4);
        sbnombcontra       ge_contratista.nombre_contratista%TYPE;
        sbnombuniope       or_operating_unit.name%TYPE;
        sbdesctipocontrato ge_tipo_contrato.descripcion%TYPE;
        sbdesccontratoact  ge_contrato.descripcion%TYPE;
        nuContratodesc     ge_contrato.id_contrato%TYPE; -- Contrato
        sbdesccontratodes  ge_contrato.descripcion%TYPE;
        -- Constantes
        csbProceso CONSTANT VARCHAR2(4000) := 'fcrBusqueda';

		sbEstaConsu      VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ESTAORDACONS', NULL); --Ticket 200 1138 LJLB-- se almacena los estados  de la orden a consultar
        sbEstaNoCerra    VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ESTAORDNOCERR', NULL); --Ticket 200 1138 LJLB-- se almacena los estados de la orden diferente de cerrado a tener en cuenta



    BEGIN
        -- Obtiene contratista

        nuPaso := 10;
        IF NOT fblaplicaentrega(csbEntrega200209) THEN
            sbError := 'Debe estar aplicada la entrega '||csbEntrega200209||' para que esta opcion funcione.';
            RAISE ex.Controlled_Error;
        END IF;

        nuPaso           := 15;
        sbID_CONTRATISTA := ge_boInstanceControl.fsbGetFieldValue('GE_CONTRATISTA',
                                                                  'ID_CONTRATISTA');

        nuPaso := 20;
        IF (sbID_CONTRATISTA IS NULL) THEN
            Errors.SetError(cnuNULL_ATTRIBUTE, 'Contratista');
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        nuPaso        := 30;
        nuContratista := to_number(sbID_CONTRATISTA);

        sbnombcontra := NULL;
        BEGIN
         SELECT cn.nombre_contratista INTO sbnombcontra
           FROM ge_contratista cn
          WHERE cn.id_contratista = nuContratista;
        EXCEPTION
         WHEN no_data_found THEN
          sbnombcontra := '----------';
        END;

        -- Unidad operativa
        nuPaso              := 30;
        sbOPERATING_UNIT_ID := ge_boInstanceControl.fsbGetFieldValue('OR_OPERATING_UNIT',
                                                                     'OPERATING_UNIT_ID');
        IF (sbOPERATING_UNIT_ID IS NULL) THEN
            Errors.SetError(cnuNULL_ATTRIBUTE, 'Unidad operativa.');
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        nuPaso              := 40;
        nuUnidadOperativa   := to_number(sbOPERATING_UNIT_ID);

        sbnombuniope := NULL;
        BEGIN
         SELECT uo.name INTO sbnombuniope
           FROM or_operating_unit uo
          WHERE uo.operating_unit_id = nuunidadoperativa;
        EXCEPTION
         WHEN no_data_found THEN
          sbnombuniope := '----------';
        END;

        -- Consultamos asociacion contratista vs unidad operativa digitada
        SELECT COUNT(1) INTO nuconta
          FROM or_operating_unit uo
         WHERE uo.operating_unit_id = nuUnidadOperativa
           AND uo.contractor_id     = nuContratista;

        -- Validamos que la unidad operativa digitada, corresponda al contratista digitado
         IF nuunidadoperativa <> -1 AND nuconta = 0 THEN
           Errors.SetError(cnuNULL_ATTRIBUTE, 'La unidad operativa : '||to_char(nuUnidadOperativa)||' - '||sbnombuniope||', no corresponde al contratista : '||to_char(nuContratista)||' - '||sbnombcontra);
           RAISE ex.CONTROLLED_ERROR;
         END IF;

        -- Tipo de contrato
        nuPaso             := 50;
        sbID_TIPO_CONTRATO := ge_boInstanceControl.fsbGetFieldValue('GE_TIPO_CONTRATO',
                                                                    'ID_TIPO_CONTRATO');
        IF (sbID_TIPO_CONTRATO IS NULL) THEN
            Errors.SetError(cnuNULL_ATTRIBUTE, 'Tipo contrato.');
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        nuPaso             := 60;
        nuTipoContrato     := to_number(sbID_TIPO_CONTRATO);

        BEGIN
         SELECT tc.descripcion INTO sbdesctipocontrato
           FROM ge_tipo_contrato tc
          WHERE tc.id_tipo_contrato = nuTipoContrato;
        EXCEPTION
         WHEN no_data_found THEN
          sbdesctipocontrato := '----------';
        END;

        -- Id contrato
        nuPaso           := 70;
        sbID_CONTRATO    := ge_boInstanceControl.fsbGetFieldValue('GE_CONTRATO', 'ID_CONTRATO');

        IF (sbID_CONTRATO IS NULL) THEN
            Errors.SetError(cnuNULL_ATTRIBUTE, 'Contrato actual.');
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        nuPaso           := 80;
        nuContratoActual := to_number(sbID_CONTRATO);

        BEGIN
         SELECT ca.descripcion INTO sbdesccontratoact
           FROM ge_contrato ca
          WHERE ca.id_contrato = nucontratoactual;
        EXCEPTION
         WHEN no_data_found THEN
          sbdesccontratoact := '----------';
        END;

        -- Consultamos asociacion contrato-actual vs tipo contrato vs contratista
        --OSF-2321 Se adiciona el estado SU a la sentencia
        SELECT COUNT(1) INTO nuconta
          FROM ge_contrato co
         WHERE co.id_contrato      = nuContratoActual
           AND co.id_tipo_contrato = nuTipoContrato
           AND co.id_contratista   = nuContratista
           AND co.status           in ('AB','SU');

        -- Validamos que la asociacion exista
         IF nuconta = 0 THEN
           Errors.SetError(cnuNULL_ATTRIBUTE, 'El contrato actual : '||to_char(nucontratoactual)||' - '||sbdesccontratoact||', no pertenece al contratista : '||to_char(nuContratista)||' - '||sbnombcontra||', o no es del tipo de contrato : '||to_char(nuTipoContrato)||' - '||sbdesctipocontrato);
           RAISE ex.CONTROLLED_ERROR;
         END IF;

        -- Fecha de asignacion
        nuPaso            := 90;
        sbASSIGNED_DATE   := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER', 'ASSIGNED_DATE');

        IF sbASSIGNED_DATE IS NULL THEN
           Errors.SetError(cnuNULL_ATTRIBUTE, 'Fecha de asignacion');
           RAISE ex.CONTROLLED_ERROR;
         END IF;

        nuPaso            := 100;
        dtFechaAsignacion := to_date(sbASSIGNED_DATE, ut_date.fsbDATE_FORMAT);

        -- Contrato destino
        nuPaso       := 101;
        sbIdContratodesc := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER', 'DEFINED_CONTRACT_ID');

        nuPaso := 102;
        IF sbIdContratodesc IS NULL THEN
           Errors.SetError(cnuNULL_ATTRIBUTE, 'Contrato destino.');
           RAISE ex.CONTROLLED_ERROR;
        END IF;

        nuContratodesc := to_number(sbIdContratodesc);

        BEGIN
         SELECT cd.descripcion INTO sbdesccontratodes
           FROM ge_contrato cd
          WHERE cd.id_contrato = nuContratodesc;
        EXCEPTION
         WHEN no_data_found THEN
          sbdesccontratodes := '----------';
        END;

       -- Consultamos asociacion contrato destino vs contratista
         SELECT COUNT(1) INTO nuconta
           FROM ge_contrato cc
          WHERE cc.id_contrato    = nuContratodesc
            AND cc.id_contratista = nucontratista
            AND cc.status         = 'AB'
            AND cc.id_contrato    <> nuContratoactual;

        IF nuconta = 0 THEN
           Errors.SetError(cnuNULL_ATTRIBUTE, 'El contrato destino : '||to_char(nuContratodesc)||' - '||sbdesccontratodes||', no esta asociado al contratista : '||to_char(nuContratista)||' - '||sbnombcontra);
           RAISE ex.CONTROLLED_ERROR;
        END IF;

        -- Identificar el estado cerrado de una ot
        nuPaso := 110;
        BEGIN
            nuEstadoCerradoOT := dald_parameter.fnuGetNumeric_Value(inuparameter_id => 'ESTADO_CERRADO');
        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible obtener el valor del parametro ESTADO_CERRADO. ' ||
                           SQLERRM;
                RAISE ex.Controlled_Error;
        END;

        nuPaso := 120;
        IF nuEstadoCerradoOT IS NULL THEN
            sbError := 'El valor del parametro ESTADO_CERRADO es vacio';
            RAISE ex.Controlled_Error;
        END IF;

        nuPaso := 130;
        SELECT COUNT(1)
        INTO   nuExiste
        FROM   or_order_status oos
        WHERE  oos.order_status_id = nuEstadoCerradoOT;

        nuPaso := 140;
        IF nuExiste = 0 THEN
            sbError := 'No se encontro un estado de orden con codigo ' || nuEstadoCerradoOT;
            RAISE ex.Controlled_Error;
        END IF;

        -- Identificar la clase de causales que indican que son de exito
        nuPaso := 150;
        BEGIN
            nuClaseCausalExito := dald_parameter.fnuGetNumeric_Value(inuparameter_id => 'LDC_CAUSAL_EXITO');
        EXCEPTION
            WHEN OTHERS THEN
                sbError := 'No fue posible consultar el parametro LDC_CAUSAL_EXITO. ' || SQLERRM;
                RAISE ex.Controlled_Error;
        END;

        nuPaso := 160;
        IF nuClaseCausalExito IS NULL THEN
            sbError := 'El valor del parametro LDC_CAUSAL_EXITO se encuentra vacio';
            RAISE ex.Controlled_Error;
        END IF;

        nuPaso := 170;
        SELECT COUNT(1)
        INTO   nuExiste
        FROM   ge_class_causal gcc
        WHERE  gcc.class_causal_id = nuClaseCausalExito;

        nuPaso := 180;
        IF nuExiste = 0 THEN
            sbError := 'No se encontro una causal con codigo ' || nuClaseCausalExito;
            RAISE ex.Controlled_Error;
        END IF;

        -- Las ordenes a listar deben cumplir con los filtros de la forma y debe traer las ordenes
        -- que no se encuentren en acta. El estado de la orden debe ser 8. Ademas la clase de la
        -- causal de legalizacion debe ser 1-Exito o la orden debe ser de novedad.  Los datos a
        -- mostrar de la orden son numero de orden, unidad de trabajo con su descripcion, tipo de
        -- trabajo con su descripcion, actividad principal con su descripcion, fecha de creacion de la ot,
        -- fecha de asignacion, fecha de legalizacion, numero de solicitud. Si la orden tiene una
        -- orden padre debe mostrarse numero de ot padre, fecha de asignacion , fecha de legalizacion,
        -- tipo de trabajo padre con su descripcion y actividad con su descripcion
        nuPaso := 190;
        OPEN rfcursor FOR
            /* jjjm SELECT oo.order_id "Numero de orden",
                   oou.operating_unit_id || ' - ' || oou.name "Unidad de trabajo",
                   ott.task_type_id || ' - ' || ott.description "Tipo de trabajo",
                   (SELECT ooa.activity_id || ' - ' || gi1.description
                    FROM   or_order_activity ooa,
                           ge_items          gi1
                    WHERE  ooa.activity_id IN
                           (SELECT gi.items_id
                            FROM   OR_TASK_TYPES_ITEMS otti,
                                   ge_items            gi
                            WHERE  otti.task_type_id = oo.task_type_id
                            AND    otti.items_id = gi.items_id
                            AND    gi.item_classif_id =
                                   dald_parameter.fnuGetNumeric_Value('COD_CLA_ITEM_ACT', NULL))
                    AND    ooa.order_id = oo.order_id
                    AND    gi1.items_id = ooa.activity_id
                    AND    rownum <= 1) "Actividad principal",
                   oo.created_date "Fecha de creacion",
                   oo.assigned_date "Fecha de asignacion",
                   oo.legalization_date "Fecha de legalizacion",
                   (SELECT MAX(ooa.package_id)
                    FROM   or_order_activity ooa
                    WHERE  ooa.order_id = oo.order_id) "Solicitud",
                    NULL "Orden padre",
                    NULL "Fecha asignacion orden padre",
                    NULL "Fecha legalizacion orden padre",
                    NULL "Tipo de trabajo orden padre",
                    NULL "Act. principal orden padre",
                   (SELECT gc.id_contrato || ' - ' || gc.descripcion
                    FROM   ge_contrato gc
                    WHERE  gc.id_contrato = oo.defined_contract_id) "Contrato definido",
                   (SELECT gtc.id_tipo_contrato || ' - ' || gtc.descripcion
                    FROM   ge_tipo_contrato gtc,
                           ge_contrato      gc
                    WHERE  gtc.id_tipo_contrato = gc.id_tipo_contrato
                    AND    gc.id_contrato = oo.defined_contract_id) "Tipo de contrato"
            FROM   or_order          oo,
                   ge_causal         gc,
                   or_operating_unit oou,
                   or_task_type      ott,
                   ge_contratista    contratista
            WHERE  oo.order_status_id = nuEstadoCerradoOT
            AND    oo.causal_id = gc.causal_id
            AND    oo.is_pending_liq IN ('Y', 'E')
            AND    (gc.class_causal_id = 1 OR EXISTS
                   (SELECT 1
                     FROM   ct_item_novelty cin,
                            or_order_items  ooi
                     WHERE  cin.items_id = ooi.items_id
                     AND    ooi.order_id = oo.order_id))
            AND    oo.operating_unit_id = oou.operating_unit_id
            AND    oou.contractor_id = contratista.id_contratista
            AND    oo.task_type_id = ott.task_type_id
            AND    ((oo.defined_contract_id IS NULL AND nuContratoActual IS NULL AND
                  nuTipoContrato IS NULL) OR EXISTS
                   (SELECT 1
                     FROM   ge_contrato      contrato,
                            ge_tipo_contrato gtc
                     WHERE  contrato.id_contrato = oo.defined_contract_id
                     AND    contrato.id_tipo_contrato = gtc.id_tipo_contrato
                     AND    contratista.id_contratista = contrato.id_contratista
                     AND    contrato.id_contrato = oo.defined_contract_id
                     AND    contrato.id_contrato = nvl(nuContratoActual, contrato.id_contrato)
                     AND    contrato.id_tipo_contrato =
                            nvl(nuTipoContrato, contrato.id_tipo_contrato)
                     AND    contrato.id_contrato = NVL(oo.defined_contract_id, contrato.id_contrato)
                     AND    contrato.id_contrato = nvl(nuContratoActual, contrato.id_contrato)
                     AND    contrato.status = 'AB'
                     AND    contrato.id_tipo_contrato =
                            nvl(nuTipoContrato, contrato.id_tipo_contrato)))
            AND    contratista.id_contratista = nvl(nuContratista, contratista.id_contratista)
            AND    oou.operating_unit_id = nvl(nuUnidadOperativa, oou.operating_unit_id)
            AND    oo.assigned_date <= nvl(dtFechaAsignacion, oo.assigned_date)
            AND    NOT EXISTS
             (SELECT 1 FROM or_related_order oro WHERE oro.related_order_id = oo.order_id)
            UNION ALL
            SELECT oo.order_id "Numero de orden",
                   oou.operating_unit_id || ' - ' || oou.name "Unidad de trabajo",
                   ott.task_type_id || ' - ' || ott.description "Tipo de trabajo",
                   (SELECT ooa.activity_id || ' - ' || gi1.description
                    FROM   or_order_activity ooa,
                           ge_items          gi1
                    WHERE  ooa.activity_id IN
                           (SELECT gi.items_id
                            FROM   OR_TASK_TYPES_ITEMS otti,
                                   ge_items            gi
                            WHERE  otti.task_type_id = oo.task_type_id
                            AND    otti.items_id = gi.items_id
                            AND    gi.item_classif_id =
                                   dald_parameter.fnuGetNumeric_Value('COD_CLA_ITEM_ACT', NULL))
                    AND    ooa.order_id = oo.order_id
                    AND    gi1.items_id = ooa.activity_id
                    AND    rownum <= 1) "Actividad principal",
                   oo.created_date "Fecha de creacion",
                   oo.assigned_date "Fecha de asignacion",
                   oo.legalization_date "Fecha de legalizacion",
                   (SELECT MAX(ooa.package_id)
                    FROM   or_order_activity ooa
                    WHERE  ooa.order_id = oo.order_id) "Solicitud",
                    oo_padre.order_id "Orden padre",
                    oo_padre.assigned_date "Fecha asignacion orden padre",
                    oo_padre.legalization_date "Fecha legalizacion orden padre",
                    ott_padre.task_type_id ||' - '||ott_padre.description "Tipo de trabajo orden padre",
                    (SELECT ooa.activity_id || ' - ' || gi1.description
                    FROM   or_order_activity ooa,
                           ge_items          gi1
                    WHERE  ooa.activity_id IN
                           (SELECT gi.items_id
                            FROM   OR_TASK_TYPES_ITEMS otti,
                                   ge_items            gi
                            WHERE  otti.task_type_id = oo_padre.task_type_id
                            AND    otti.items_id = gi.items_id
                            AND    gi.item_classif_id =
                                   dald_parameter.fnuGetNumeric_Value('COD_CLA_ITEM_ACT', NULL))
                    AND    ooa.order_id = oo_padre.order_id
                    AND    gi1.items_id = ooa.activity_id
                    AND    rownum <= 1) "Act. principal orden padre",
                   (SELECT gc.id_contrato || ' - ' || gc.descripcion
                    FROM   ge_contrato gc
                    WHERE  gc.id_contrato = oo.defined_contract_id) "Contrato definido",
                   (SELECT gtc.id_tipo_contrato || ' - ' || gtc.descripcion
                    FROM   ge_tipo_contrato gtc,
                           ge_contrato      gc
                    WHERE  gtc.id_tipo_contrato = gc.id_tipo_contrato
                    AND    gc.id_contrato = oo.defined_contract_id) "Tipo de contrato"
            FROM   or_order          oo,
                   ge_causal         gc,
                   or_operating_unit oou,
                   or_task_type      ott,
                   ge_contratista    contratista,
                   or_related_order  oro,
                   or_order          oo_padre,
                   or_task_type      ott_padre
            WHERE  oo.order_status_id = nuEstadoCerradoOT
            AND    oo.causal_id = gc.causal_id
            AND    oo.is_pending_liq IN ('Y', 'E')
            AND    (gc.class_causal_id = 1 OR EXISTS
                   (SELECT 1
                     FROM   ct_item_novelty cin,
                            or_order_items  ooi
                     WHERE  cin.items_id = ooi.items_id
                     AND    ooi.order_id = oo.order_id))
            AND    oo.operating_unit_id = oou.operating_unit_id
            AND    oou.contractor_id = contratista.id_contratista
            AND    oo.task_type_id = ott.task_type_id
            AND    ((oo.defined_contract_id IS NULL AND nuContratoActual IS NULL AND
                  nuTipoContrato IS NULL) OR EXISTS
                   (SELECT 1
                     FROM   ge_contrato      contrato,
                            ge_tipo_contrato gtc
                     WHERE  contrato.id_contrato = oo.defined_contract_id
                     AND    contrato.id_tipo_contrato = gtc.id_tipo_contrato
                     AND    contratista.id_contratista = contrato.id_contratista
                     AND    contrato.id_contrato = oo.defined_contract_id
                     AND    contrato.id_contrato = nvl(nuContratoActual, contrato.id_contrato)
                     AND    contrato.id_tipo_contrato =
                            nvl(nuTipoContrato, contrato.id_tipo_contrato)
                     AND    contrato.id_contrato = NVL(oo.defined_contract_id, contrato.id_contrato)
                     AND    contrato.id_contrato = nvl(nuContratoActual, contrato.id_contrato)
                     AND    contrato.status = 'AB'
                     AND    contrato.id_tipo_contrato =
                            nvl(nuTipoContrato, contrato.id_tipo_contrato)))
            AND    contratista.id_contratista = nvl(nuContratista, contratista.id_contratista)
            AND    oou.operating_unit_id = nvl(nuUnidadOperativa, oou.operating_unit_id)
            AND    oo.assigned_date <= nvl(dtFechaAsignacion, oo.assigned_date)
            AND    oro.related_order_id = oo.order_id
            AND    oo_padre.order_id = oro.order_id
            AND    oo_padre.task_type_id = ott_padre.task_type_id*/
          SELECT "Numero de orden"
      ,"Unidad de trabajo"
      ,"Tipo de trabajo"
      ,"Actividad principal"
      ,"Fecha de creacion"
      ,"Fecha de asignacion"
      ,"Fecha de legalizacion"
      ,"Solicitud"
      ,(SELECT so.request_date   FROM open.mo_packages so WHERE so.package_id = "Solicitud") "Fecha creacion solicitud"
      ,(SELECT so.attention_date FROM open.mo_packages so WHERE so.package_id = "Solicitud") "Fecha atencion solicitud"
      ,"Orden padre"
      ,(SELECT op.assigned_date                         FROM open.or_order op WHERE op.order_id = "Orden padre") "Fecha asignacion orden padre"
      ,(SELECT op.legalization_date                     FROM open.or_order op WHERE op.order_id = "Orden padre") "Fecha legalizacion orden padre"
      ,(SELECT op.task_type_id||' - '||ttop.description FROM open.or_order op,open.or_task_type ttop WHERE op.order_id = "Orden padre" AND op.task_type_id = ttop.task_type_id) "Tipo de trabajo orden padre"
      ,(
        SELECT ooa.activity_id || ' - ' || gi1.description
          FROM or_order_activity ooa,ge_items  gi1
         WHERE ooa.activity_id IN
                                (
                                 SELECT gi.items_id
                                   FROM or_task_types_items otti
                                       ,ge_items            gi
                                  WHERE otti.task_type_id  = (SELECT op.task_type_id FROM open.or_order op WHERE op.order_id = "Orden padre")
                                    AND otti.items_id      = gi.items_id
                                    AND gi.item_classif_id = dald_parameter.fnuGetNumeric_Value('COD_CLA_ITEM_ACT', NULL)
                                   )
                    AND ooa.order_id = "Orden padre"
                    AND gi1.items_id = ooa.activity_id
                    AND ROWNUM <= 1) "Act. principal orden padre"
      ,"Contrato definido"
      ,"Tipo de contrato"
      ,(select tiu.id_tipo_unidad||'-'||tiu.descripcion from open.ge_tipo_unidad tiu where tiu.id_tipo_unidad="Tipo Un") "Tipo Uni"
      ,(select cl.description||'-'||cl.description from open.ge_task_class cl where cl.task_class_id="Clasificacion Ti") "Clasificacion Titr"
      ,"Existe"
  FROM
      (
        SELECT oo.order_id "Numero de orden"
              ,oou.operating_unit_id || ' - ' || oou.name "Unidad de trabajo"
              ,oou.unit_type_id "Tipo Un"
              ,oo.task_type_id || ' - ' || (SELECT ott.description FROM or_task_type ott WHERE ott.task_type_id = oo.task_type_id)  "Tipo de trabajo"
              ,daor_task_type.fnugettask_type_classif(oo.task_type_id, null) "Clasificacion Ti"
              ,NVL((SELECT 'Y'
                 FROM  CT_TASKTYPE_CONTYPE TTTCO, GE_CONTRATO CON
                WHERE CON.ID_CONTRATO=nuContratodesc
                  AND TTTCO.TASK_TYPE_ID=OO.TASK_TYPE_ID
                  AND ((TTTCO.FLAG_TYPE='C' AND TTTCO.CONTRACT_ID=nuContratodesc) OR
                      (TTTCO.FLAG_TYPE='T' AND TTTCO.CONTRACT_TYPE_ID=CON.ID_TIPO_CONTRATO))
                  AND ROWNUM=1),'N') "Existe"
              ,(
                SELECT ooa.activity_id || ' - ' || gi1.description
                  FROM  or_order_activity ooa,ge_items gi1
                 WHERE  ooa.activity_id IN
                                         (
                                          SELECT gi.items_id
                                            FROM or_task_types_items otti,ge_items gi
                                           WHERE otti.task_type_id = oo.task_type_id
                                             AND otti.items_id = gi.items_id
                                             AND gi.item_classif_id = dald_parameter.fnuGetNumeric_Value('COD_CLA_ITEM_ACT', NULL))
                                             AND ooa.order_id = oo.order_id
                                             AND gi1.items_id = ooa.activity_id
                                             AND ROWNUM <= 1) "Actividad principal"
              ,oo.created_date "Fecha de creacion"
              ,oo.assigned_date "Fecha de asignacion"
              ,oo.legalization_date "Fecha de legalizacion"
              ,(
                SELECT MAX(ooa.package_id)
                  FROM or_order_activity ooa
                 WHERE ooa.order_id = oo.order_id
                ) "Solicitud"
               ,open.ldc_fncretordenpadre(oo.order_id) "Orden padre"
               ,(
                SELECT gc.id_contrato || ' - ' || gc.descripcion
                  FROM   ge_contrato gc
                 WHERE  gc.id_contrato = oo.defined_contract_id
               ) "Contrato definido"
              ,(
                SELECT gtc.id_tipo_contrato || ' - ' || gtc.descripcion
                  FROM ge_tipo_contrato gtc,ge_contrato      gc
                 WHERE gtc.id_tipo_contrato = gc.id_tipo_contrato
                   AND gc.id_contrato       = oo.defined_contract_id
                ) "Tipo de contrato"
          FROM or_order oo
              ,ge_causal gc
              ,or_operating_unit oou
         WHERE oo.order_status_id     IN ( SELECT to_number(COLUMN_VALUE)
                                           FROM TABLE(ldc_boutilities.splitstrings(sbEstaConsu, ',') )
                                          ) --TICKET 2001138 LJLB -- Se consultan los estado a tener en cuenta

           AND oo.defined_contract_id = nucontratoactual
           AND oo.assigned_date      <= dtFechaAsignacion
           AND oo.operating_unit_id   = DECODE(nuunidadoperativa,-1,oo.operating_unit_id,nuunidadoperativa)
           AND oou.contractor_id      = nucontratista
        -- AND oo.is_pending_liq IN ('Y', 'E')
           AND gc.class_causal_id = 1
           AND (CASE WHEN oo.is_pending_liq IS NULL AND oo.order_status_id IN ( SELECT to_number(COLUMN_VALUE)
                                                                               FROM TABLE(ldc_boutilities.splitstrings(sbEstaNoCerra, ',') )
                                                                              ) THEN
                           'Y'
                     ELSE
                         oo.is_pending_liq
                END) IN ('Y', 'E')
           AND (CASE WHEN oo.causal_id IS NOT NULL THEN
                       oo.causal_id
                     ELSE
                       1
                 END )= gc.causal_id --TICKET 2001138 LJLB -- se modifica filtros para que se tenga en cuenta las ordenes no cerrada con contrato

           AND oo.operating_unit_id = oou.operating_unit_id
           --AND oo.causal_id         = gc.causal_id
     );

        nuPaso := 200;
        RETURN rfcursor;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || csbProceso || '(' ||
                           nuPaso || '):' || sbError,
                           1);
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || csbPaquete || '.' || csbProceso || '(' ||
                           nuPaso || '):' || SQLERRM,
                           1);
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE proProceso(inuOT           IN or_order.order_id%TYPE,
                         inuCurrent      IN NUMBER,
                         inuTotal        IN NUMBER,
                         onuErrorCode    OUT NUMBER,
                         osbErrorMessage OUT VARCHAR2) IS
        /*******************************************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proProceso
        Descripcion:        Ejecuta el proceso de LDCCO

        Autor    : Sandra Mu?oz
        Fecha    : 01-07-2016 CA 200-209

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        01-07-2016   Sandra Mu?oz           Creacion
        *******************************************************************************************/

        nuPaso     NUMBER; -- Paso ejeucutado
        nuExiste   NUMBER; -- Existe un valor en la base de datos
        csbProceso VARCHAR2(100) := 'proProceso';
        sbError    ge_error_log.description%TYPE; -- Descripcion del error
        nuError     number;
        cnuError   ge_message.message_id%TYPE; -- Codigo del mensaje de error

        nuContratoDestino ge_contrato.id_contrato%TYPE; -- Contrato destino
        sbComentario      ge_boInstanceControl.stysbValue; -- Campo
        sbIdContrato      ge_boInstanceControl.stysbValue; -- Campo
        dtFechaMaxAsign   date;
        dtFechaMaxLega    date;
        nuEstadoOt        or_order.order_Status_id%type;

    BEGIN
        ut_trace.Trace('INICIO ' || csbProceso, 10);

        nuPaso := 10;
        IF NOT fblaplicaentrega(csbEntrega200209) THEN
            sbError := 'Debe estar aplicada la entrega OSS_CON_SMS_200209 para que esta opcion funcione.';
            RAISE ex.Controlled_Error;
        END IF;

        -- Leer los datos de la pantalla
        nuPaso       := 13;
        sbIdContrato := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER', 'DEFINED_CONTRACT_ID');

        nuPaso := 15;
        IF sbIdContrato IS NULL THEN
            sbError := 'Falta indicar el numero del contrato al que se asignaran las ordenes';
            RAISE ex.Controlled_Error;
        END IF;

        nuPaso       := 20;
        sbComentario := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER_COMMENT', 'ORDER_COMMENT');

        nuPaso := 25;
        IF sbComentario IS NULL THEN
            sbError := 'Falta indicar la observacion del cambio de contrato';
            RAISE ex.Controlled_Error;
        END IF;

        nuPaso            := 30;
        nuContratoDestino := to_number(sbIdContrato);
        
        begin
          select order_status_id into nuEstadoOt
            from open.or_order
          where order_id=inuOT;
        exception
          when others then
            nuEstadoOt:=-1;
        end;
        if nuEstadoOt not in (8,12) then
          begin
              select f.fecha_maxasig into dtFechaMaxAsign
              from open.ldc_contfema f
              where f.id_contrato = nuContratoDestino;
          exception
              when others then 
                   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'El contrato destino '||nuContratoDestino||' no tiene fecha maxima de asignacion');
                   RAISE ex.CONTROLLED_ERROR;
                
          end;
          if dtFechaMaxAsign < sysdate then
                 ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'El contrato destino '||nuContratoDestino||' tiene la fecha maxima de asignacion vencida');
                 RAISE ex.CONTROLLED_ERROR;
          end if;
        else
           begin
              select f.fecha_final into dtFechaMaxLega
              from open.ge_contrato  f
              where f.id_contrato = nuContratoDestino;
          exception
              when others then 
                   
                   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'No se encontro información del contrato '||nuContratoDestino);
                   RAISE ex.CONTROLLED_ERROR;
                
          end;
          if dtFechaMaxLega < sysdate then
               ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'El contrato destino tiene la fecha maxima de legalización vencida');
               RAISE ex.CONTROLLED_ERROR;
          end if;
        end if;

        -- Realizar el cambio de contrato
        BEGIN
        nuPaso := 40;

            ldc_chang_contract_order(inuot                        => inuOT,
                                     inuContratoDestino           => nuContratoDestino,
                                     isbObservacionCambioContrato => sbComentario);
        EXCEPTION
          when ex.CONTROLLED_ERROR then
                errors.GetError(onuErrorCode, osbErrorMessage);
            when others then
                Errors.setError;
                errors.GetError(onuErrorCode, osbErrorMessage);
                raise;
            /*WHEN OTHERS THEN
                sbError := 'Se presento un error al realizar el cambio en la OT ' || inuOT||'. '||SQLERRM;
                ERRORS.Geterror(nuError,sbError);
                RAISE ex.Controlled_Error;*/
        END;
        ut_trace.Trace('FIN ' || csbProceso, 10);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || csbProceso || '(' ||
                           nuPaso || '):' || sbError,
                          1);
             /*osbErrorMessage := sbError;
            onuErrorCode    := nuPaso;
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;*/
            raise;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO' || csbPaquete || '.' || csbProceso || '(' ||
                           nuPaso || '):' || SQLERRM,
                           1);
/*            osbErrorMessage := sbError;
            onuErrorCode    := nuPaso;
            ERRORS.SETERROR(inuapperrorcode => cnuDescripcionError, isbargument => sbError);
            RAISE EX.CONTROLLED_ERROR;*/
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

END ldc_pkLDCCO;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKLDCCO
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKLDCCO', 'ADM_PERSON');
END;
/