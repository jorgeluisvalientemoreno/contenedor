CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcordenes_industriales IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bcordenes_industriales
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   09/01/2024
    Descripcion :   Paquete con consultas para manejo de ordenes de
                    industriales
    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    felipe.valencia     19/04/2024      OSF-2561    Se agrega la función ftbobtienecontratos
                                                    y se elimina la función fnu_obt_cantidad_registros
                                                    Se agregan hints al cursor cuOrdenesProceso.
                                                    Se agrega la tabla pl tytbCodigoContrato 
    felipe.valencia     09/01/2024      OSF-1909    Creacion
*******************************************************************************/
    csbTiposTrabajo		CONSTANT VARCHAR2(4000) := pkg_bcparametros_open.fsbGetValorCadena('AGRUPED_TASK_TYPE');

    TYPE tytbCodigoContrato IS TABLE OF ge_contrato.id_contrato%TYPE INDEX BY BINARY_INTEGER;
    CURSOR cuOrdenesProceso
    (
        inuContrato IN ge_contrato.id_contrato%TYPE
    )
    IS
    SELECT  /*+ use_nl(oo ot aa)
                index(oo IDX_OR_ORDER21)
                index(ot IDX_OR_ORDER_ACTIVITY_05)
                index(aa PK_AB_ADDRESS) 
            */
            oo.order_id,
            oo.operating_unit_id,
            oo.defined_contract_id,
            oo.legalization_date,
            oo.task_type_id,
            aa.geograp_location_id,
            ot.activity_id
    FROM    or_order oo,
            or_order_activity ot,
            ab_address aa
    WHERE   ot.order_id = oo.order_id
    AND     aa.address_id = oo.external_address_id
    AND     oo.task_type_id IN (SELECT TO_NUMBER(regexp_substr(csbTiposTrabajo,'[^,]+', 1, level)) as valores
                                     FROM dual
                                     connect by regexp_substr(csbTiposTrabajo, '[^,]+', 1, level) is not null)
    AND     oo.order_status_id 	= 8 
    AND     oo.is_pending_liq = 'Y'
    AND     oo.saved_data_values = 'ORDER_GROUPED'
    AND     oo.defined_contract_id = inuContrato
    AND NOT EXISTS (SELECT orden_agrupadora FROM detalle_ot_agrupada WHERE orden_agrupadora = oo.order_id);

    CURSOR cuValorItemsAgrupadora
    IS
    SELECT  dtotg.orden_agrupadora,
            oi.items_id,
            sum(oi.legal_item_amount) legal_item_amount,
            sum(oi.value) value,
            (
                SELECT  order_activity_id
                FROM    or_order_activity oot
                WHERE   oot.order_id  = dtotg.orden_agrupadora
            ) order_activity_id
    FROM    detalle_ot_agrupada dtotg,
            or_order_items oi,
            ge_items i
    WHERE   oi.order_id = dtotg.orden
    AND     i.items_id = oi.items_id
    AND     dtotg.estado IN ('R', 'E')
    AND     i.item_classif_id  not in (3,8,21,2)
    GROUP BY dtotg.orden_agrupadora, oi.items_id;


    CURSOR cuNoValorizada
    IS
    SELECT distinct dtotg.orden_agrupadora
    FROM    detalle_ot_agrupada dtotg
    WHERE   dtotg.estado = 'R'
    AND     NOT EXISTS  (    SELECT a.order_id
                        FROM or_order_items a, ge_items b
                        WHERE  a.items_id= b.items_id
                        AND     item_classif_id  not in (3,8,21, 2)
                        AND     a.order_id = dtotg.orden
                    );
    

    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion 
    RETURN VARCHAR2;

    FUNCTION ftbobtienecontratos
    RETURN tytbCodigoContrato;
END pkg_bcordenes_industriales;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcordenes_industriales IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion     VARCHAR2(15) := 'OSF-2561';
    -- Constantes para el control de la traza
    csbSP_NAME     CONSTANT VARCHAR2(35):= $$PLSQL_UNIT;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 09/02/2024
    Modificaciones  :
    Autor               Fecha       Caso     Descripcion
    felipe.valencia     09/02/2024  OSF-1909 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : ftbobtienecontratos
        Descripcion     : Consulta ccontratos abiertos
        Autor           : 
        Fecha           : 19/04/2024
        Parametros de Entrada
        
        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     19/04/2024          OSF-2561: Creación
    ***************************************************************************/
    FUNCTION ftbobtienecontratos
    RETURN tytbCodigoContrato
    IS
        nuContar NUMBER;
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'ftbobtienecontratos';

        tbContratos          tytbCodigoContrato;

        CURSOR cuObtieneContratos
        IS
        SELECT  distinct id_contrato 
        FROM    ge_contrato c, ct_tasktype_contype ctt
        WHERE   ctt.contract_type_id = c.id_tipo_contrato
        AND     ctt.flag_type = 'T'
        AND     c.status in ('AB', 'SU')
        AND     ctt.task_type_id IN (SELECT TO_NUMBER(regexp_substr(csbTiposTrabajo,'[^,]+', 1, level)) as valores
                                            FROM dual
                                            connect by regexp_substr(csbTiposTrabajo, '[^,]+', 1, level) is not null)
                                            
        AND not exists(select null from open.ct_tasktype_contype ct2 where ct2.contract_id =c.id_contrato and ct2.flag_type = 'C')               
        UNION ALL             
        SELECT  distinct id_contrato 
        FROM    ge_contrato c, ct_tasktype_contype ctt
        WHERE   ctt.contract_id = c.id_contrato
        AND     ctt.flag_type = 'C'
        AND     c.status in ('AB', 'SU')
        AND     ctt.task_type_id IN (SELECT TO_NUMBER(regexp_substr(csbTiposTrabajo,'[^,]+', 1, level)) as valores
                                            FROM dual
                                            connect by regexp_substr(csbTiposTrabajo, '[^,]+', 1, level) is not null);
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuObtieneContratos%ISOPEN) THEN
            CLOSE cuObtieneContratos;
        END IF;

        OPEN cuObtieneContratos;
        FETCH cuObtieneContratos BULK COLLECT INTO tbContratos;
        CLOSE cuObtieneContratos;
        
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN tbContratos;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;     
    END ftbobtienecontratos;

END pkg_bcordenes_industriales;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_bcordenes_industriales
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_bcordenes_industriales'), 'PERSONALIZACIONES');
END;
/