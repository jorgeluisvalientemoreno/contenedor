CREATE OR REPLACE PACKAGE adm_person.pkg_BCValida_tt_local IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    adm_person.pkg_BCValida_tt_local
    Autor       :   Lubin Pineda - MVM
    Fecha       :   07/10/2024
    Descripcion :   Paquete con los objetos de consultas para el paquete
                    PERSONALIZACIONES.ldc_pkvalida_tt_local
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/10/2024  OSF-3162 Creacion
*******************************************************************************/

    -- Retona Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Retorna un cursor referenciado con las ordenes legalizadas del contratista
    FUNCTION fcrOrdContratistaActa
    (
        inuContratista NUMBER,
        inuActa        NUMBER
    )
    RETURN constants_per.tyRefCursor;

    -- Ordenes legalizadas en rango de fechas por clasificadores contables
    FUNCTION fcrOrdRangoFechXClasifContable
    (
        idtfechainial       DATE,
        idtfechaFinal       DATE,
        isbClasificadores   VARCHAR2
    )
    RETURN constants_per.tyRefCursor;
    
    -- Retorna las fechas del cierre comercial actual
    PROCEDURE prcFechasCierreCom( odtFechIni OUT DATE, odtFechFin OUT DATE);
    
    -- Obtiene la cuenta del costo asociada al clasificador
    FUNCTION fsbObtienCuentaCosto 
    ( 
        inuClasificador     NUMBER
    )
    RETURN ldci_cugacoclasi.cuencosto%TYPE;
    
    -- Retorna 1 si existe el dato adicional. Nulo en caso contrario
    FUNCTION fnuObtieneDatoAdicional
    ( 
        inuOrden            NUMBER,
        isbDatoAdicional     VARCHAR2
    )
    RETURN NUMBER;

    -- Cantidad de actividades por tipo de trabajo y localidad
    FUNCTION fnuObtieneCantActTiTrLoc
    ( 
        inuLocalidad    NUMBER,
        inuTipoTrabajo  NUMBER
    )
    RETURN NUMBER;
    
    -- Centro de Costos por tipo de trabajo y localidad
    FUNCTION fnuObtieneCentCostTiTrLoc
    ( 
        inuLocalidad    NUMBER,
        inuTipoTrabajo  NUMBER
    )
    RETURN NUMBER;
    
    -- Cantidad de Ordenes del contratista y acta sin dirección
    FUNCTION fnuCantOrdContActSinDir
    (
        inuContratista  NUMBER,
        inuActa         NUMBER
    )
    RETURN NUMBER;
    
    -- Obtiene el clasificador contable para el tipo de trabajo
    FUNCTION fnuObtieneClasifContabTiTr( inuTipoTrabajo NUMBER)
    RETURN ic_clascott.clctclco%TYPE;
    
    -- Obtiene la cantidad de ordenes en la tabla ge_detalle_acta
    FUNCTION fnuCantOrdDetalleActa( inuActa NUMBER)
    RETURN NUMBER;                
    
END pkg_BCValida_tt_local;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_BCValida_tt_local IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3162';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 07/10/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/10/2024  OSF-3162 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fcrOrdContLegalExitoSinActa 
    Descripcion     : Retorna un cursor referenciado con las ordenes legalizadas del contratista
    Autor           : Lubin Pineda - MVM 
    Fecha           : 07/10/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/10/2024  OSF-3162 Creacion
    ***************************************************************************/                     
    FUNCTION fcrOrdContratistaActa
    (
        inuContratista NUMBER,
        inuActa        NUMBER
    )
    RETURN constants_per.tyRefCursor
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fcrOrdContratistaActa';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        crOrdContratistaActa    constants_per.tyRefCursor;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
   
        IF crOrdContratistaActa%IsOpen THEN
            CLOSE crOrdContratistaActa;
        END IF;
        
        OPEN crOrdContratistaActa FOR
        SELECT o.order_id,
        DECODE (o.task_type_id,
        10336, o.real_task_type_id,
        task_type_id)    task_type_id,
        o.task_type_id           titr_validar,
        ab.geograp_location_id,
        o.defined_contract_id
        FROM or_order            o,
        or_operating_unit   ou,
        ab_address          ab,
        ct_order_certifica  da
        WHERE     o.order_status_id = 8
        AND o.operating_unit_id = ou.operating_unit_id
        AND ab.address_id = o.external_address_id
        AND UPPER (ou.es_externa) = 'Y'
        AND ou.contractor_id =
        DECODE (NVL (inuContratista, -1),
        -1, ou.contractor_id,
        NVL (inuContratista, -1))
        AND da.order_id = o.order_id
        AND da.certificate_id = inuActa;
 
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        RETURN crOrdContratistaActa;   

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;               
    END fcrOrdContratistaActa;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fcrOrdRangoFechXClasifContable 
    Descripcion     : Ordenes legalizadas en rango de fechas por clasificadores 
                        contables
    Autor           : Lubin Pineda - MVM 
    Fecha           : 07/10/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/10/2024  OSF-3162 Creacion
    ***************************************************************************/                     
    FUNCTION fcrOrdRangoFechXClasifContable
    (
        idtfechainial       DATE,
        idtfechaFinal       DATE,
        isbClasificadores   VARCHAR2
    )
    RETURN constants_per.tyRefCursor
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fcrOrdRangoFechXClasifContable';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
            
        crOrdRangoFechXClasifContable    constants_per.tyRefCursor;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);   
    
        IF crOrdRangoFechXClasifContable%IsOpen THEN
            CLOSE crOrdRangoFechXClasifContable;
        END IF;


        OPEN crOrdRangoFechXClasifContable FOR
              SELECT /*+ index(o IDX_OR_ORDER16) */
                     /*+use_hash (o ab)*/
                     NULL                     order_id,
                     DECODE (o.task_type_id,
                             10336, real_task_type_id,
                             task_type_id)    task_type_id,
                     task_type_id             tipo_trabajo_validar,
                     ab.geograp_location_id,
                     co.clctclco,
                     COUNT (1)                cantidad
                FROM or_order o
                     LEFT JOIN ic_clascott co
                         ON co.clcttitr =
                            DECODE (o.task_type_id,
                                    10336, real_task_type_id,
                                    task_type_id),
                     ge_causal c,
                     ab_address    ab
               WHERE     TRUNC (legalization_Date) >= idtfechainial
                     AND TRUNC (legalization_Date) <= idtfechafinal
                     AND o.order_status_id = 8
                     AND o.causal_id = c.causal_id
                     AND c.class_causal_id = 1
                     AND EXISTS
                             (SELECT NULL
                                FROM ldc_tt_tb ttb
                               WHERE     ttb.task_type_id = o.task_type_id
                                     AND ttb.active_flag = 'Y')
                     AND ab.address_id = o.external_address_id
                     AND (   clctclco IS NULL
                          OR INSTR (isbClasificadores, ',' || clctclco || ',') =
                             0)
                     AND NOT EXISTS
                             (SELECT 'x'
                                FROM ct_order_certifica da
                               WHERE da.order_id = o.order_id)
            GROUP BY DECODE (o.task_type_id,
                             10336, real_task_type_id,
                             task_type_id),
                     task_type_id,
                     ab.geograp_location_id,
                     co.clctclco
            UNION
            SELECT /*+ index(o IDX_OR_ORDER16) */
                   /*+use_hash (o ab)*/
                   o.order_id               order_id,
                   DECODE (o.task_type_id,
                           10336, real_task_type_id,
                           task_type_id)    task_type_id,
                   task_type_id             tipo_trabajo_validar,
                   ab.geograp_location_id,
                   co.clctclco,
                   1                        cantidad
              FROM or_order   o
                   LEFT JOIN ic_clascott co
                       ON co.clcttitr =
                          DECODE (o.task_type_id,
                                  10336, real_task_type_id,
                                  task_type_id),
                   ge_causal  c,
                   ab_address      ab
             WHERE     TRUNC (legalization_Date) >= idtfechainial
                   AND TRUNC (legalization_Date) <= idtfechafinal
                   AND o.order_status_id = 8
                   AND o.causal_id = c.causal_id
                   AND c.class_causal_id = 1
                   AND EXISTS
                           (SELECT NULL
                              FROM ldc_tt_tb ttb
                             WHERE     ttb.task_type_id = o.task_type_id
                                   AND ttb.active_flag = 'Y')
                   AND ab.address_id = o.external_address_id
                   AND INSTR (isbClasificadores, ',' || clctclco || ',') > 0
                   AND NOT EXISTS
                           (SELECT 'x'
                              FROM ct_order_certifica da
                             WHERE da.order_id = o.order_id);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
                                     
        RETURN crOrdRangoFechXClasifContable;
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END fcrOrdRangoFechXClasifContable;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcFechasCierreCom 
    Descripcion     : Retorna las fechas del cierre comercial actual
    Autor           : Lubin Pineda - MVM 
    Fecha           : 07/10/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/10/2024  OSF-3162 Creacion
    ***************************************************************************/       
    PROCEDURE prcFechasCierreCom( odtFechIni OUT DATE, odtFechFin OUT DATE)
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcFechasCierreCom';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
        CURSOR cuFechasCierre IS
        SELECT cicofein, cicofech
        FROM ldc_ciercome
        WHERE SYSDATE BETWEEN cicofein AND cicofech;            
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        OPEN cuFechasCierre;
        FETCH cuFechasCierre INTO odtFechIni, odtFechFin;
        CLOSE cuFechasCierre;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;                   
    END prcFechasCierreCom;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbObtienCuentaCosto 
    Descripcion     : Retorna la cuenta del costo
    Autor           : Lubin Pineda - MVM 
    Fecha           : 07/10/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/10/2024  OSF-3162 Creacion
    ***************************************************************************/     
    FUNCTION fsbObtienCuentaCosto 
    ( 
        inuClasificador     NUMBER
    )
    RETURN ldci_cugacoclasi.cuencosto%TYPE
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtienCuentaCosto';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
            
        CURSOR culdci_cugacoclasi
        IS
        SELECT cg.cuencosto
        FROM ldci_cugacoclasi cg
        WHERE     cg.cuenclasifi = inuClasificador
        AND cg.cuencosto IS NOT NULL; 
        
        sbCuentaCosto   ldci_cugacoclasi.cuencosto%TYPE;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
                     
        OPEN    culdci_cugacoclasi;
        FETCH   culdci_cugacoclasi INTO sbCuentaCosto;
        CLOSE   culdci_cugacoclasi;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         

        RETURN sbCuentaCosto;
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbCuentaCosto;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbCuentaCosto;                
    END fsbObtienCuentaCosto; 


    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneDatoAdicional 
    Descripcion     : Retorna 1 si existe el dato adicional. Nulo en caso contrario
    Autor           : Lubin Pineda - MVM 
    Fecha           : 07/10/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/10/2024  OSF-3162 Creacion
    ***************************************************************************/    
    FUNCTION fnuObtieneDatoAdicional
    ( 
        inuOrden            NUMBER,
        isbDatoAdicional     VARCHAR2
    )
    RETURN NUMBER
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtieneDatoAdicional';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);     
    
        CURSOR cuDatoAdicional
        IS
        SELECT 1
        FROM OR_TASKTYPE_ADD_DATA  D,
        ge_attrib_set_attrib  s,
        ge_attributes         a,
        or_requ_data_value    r,
        or_order              o
        WHERE     d.task_type_id =
           O.TASK_TYPE_ID
        AND D.ATTRIBUTE_SET_ID =
           s.ATTRIBUTE_SET_ID
        AND s.attribute_id =
           a.attribute_id
        AND r.attribute_set_id =
           d.attribute_set_id
        AND r.order_id = o.order_id
        AND O.order_id = inuOrden
        AND DECODE (S.CAPTURE_ORDER,
                   1, NAME_1,
                   2, NAME_2,
                   3, NAME_3,
                   4, NAME_4,
                   5, NAME_5,
                   6, NAME_6,
                   7, NAME_7,
                   8, NAME_8,
                   9, NAME_9,
                   10, NAME_10,
                   11, NAME_11,
                   12, NAME_12,
                   13, NAME_13,
                   14, NAME_14,
                   15, NAME_15,
                   16, NAME_16,
                   17, NAME_17,
                   18, NAME_18,
                   19, NAME_19,
                   20, NAME_20,
                   'NA') = isbDatoAdicional;
                   
        nuDatoAdicional NUMBER;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);    
            
        OPEN cuDatoAdicional;
        FETCH cuDatoAdicional INTO nuDatoAdicional;
        CLOSE cuDatoAdicional;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);    
                
        RETURN nuDatoAdicional;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuDatoAdicional;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuDatoAdicional;     
    END fnuObtieneDatoAdicional; 
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneCantActTiTrLoc 
    Descripcion     : Cantidad de actividades por tipo de trabajo y localidad
    Autor           : Lubin Pineda - MVM 
    Fecha           : 07/10/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/10/2024  OSF-3162 Creacion
    ***************************************************************************/     
    FUNCTION fnuObtieneCantActTiTrLoc
    ( 
        inuLocalidad    NUMBER,
        inuTipoTrabajo  NUMBER
    )
    RETURN NUMBER
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtieneCantActTiTrLoc';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);     
        
        CURSOR cuCantActTiTrLoc
        IS
        SELECT COUNT (1)
        FROM ldci_actiubgttra
        WHERE   ACBGLOCA = inuLocalidad
        AND ACBGTITR = inuTipoTrabajo; 
        
        nuCantActTiTrLoc    NUMBER;
        
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);   
            
        OPEN cuCantActTiTrLoc;
        FETCH cuCantActTiTrLoc INTO nuCantActTiTrLoc;
        CLOSE cuCantActTiTrLoc;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);   
                
        RETURN nuCantActTiTrLoc;
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuCantActTiTrLoc;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuCantActTiTrLoc;          
    END fnuObtieneCantActTiTrLoc;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneCentCostTiTrLoc 
    Descripcion     : Centro de Costos por tipo de trabajo y localidad
    Autor           : Lubin Pineda - MVM 
    Fecha           : 07/10/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/10/2024  OSF-3162 Creacion
    ***************************************************************************/     
    FUNCTION fnuObtieneCentCostTiTrLoc
    ( 
        inuLocalidad    NUMBER,
        inuTipoTrabajo  NUMBER
    )
    RETURN NUMBER
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtieneCentCostTiTrLoc';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
               
        CURSOR cuCentCostTiTrLoc
        IS
        SELECT ccbgceco
        FROM ldci_cecoubigetra
        WHERE ccbgloca = inuLocalidad
        AND ccbgtitr = inuTipoTrabajo;
        
        nuCentCostTiTrLoc    ldci_cecoubigetra.ccbgceco%TYPE;
       
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuCentCostTiTrLoc;
        FETCH cuCentCostTiTrLoc INTO nuCentCostTiTrLoc;
        CLOSE cuCentCostTiTrLoc;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                        
        RETURN nuCentCostTiTrLoc;
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuCentCostTiTrLoc;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuCentCostTiTrLoc;        
    END fnuObtieneCentCostTiTrLoc;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fcrOrdenesContratistaActa 
    Descripcion     : Ordenes legalizadas en rango de fechas por clasificadores 
                        contables
    Autor           : Lubin Pineda - MVM 
    Fecha           : 07/10/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/10/2024  OSF-3162 Creacion
    ***************************************************************************/                     
    FUNCTION fnuCantOrdContActSinDir
    (
        inuContratista  NUMBER,
        inuActa         NUMBER
    )
    RETURN NUMBER
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuCantOrdContActSinDir';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
            
        CURSOR cuCantOrdContActSinDir
        IS
        SELECT COUNT (1)
        FROM or_order            o,
            or_operating_unit   ou,
            ct_order_certifica  da
        WHERE     o.order_status_id = 8
        AND o.operating_unit_id = ou.operating_unit_id
        AND o.EXTERNAL_ADDRESS_ID IS NULL
        AND UPPER (ou.es_externa) = 'Y'
        AND ou.contractor_id =
        DECODE (NVL (inuContratista, -1),
        -1, ou.contractor_id,
        NVL (inuContratista, -1))
        AND o.task_type_id IN (SELECT task_type_id
        FROM ldc_tt_tb
        WHERE active_flag = 'Y')
        AND da.order_id = o.order_id
        AND da.certificate_id = inuActa;
        
        nuCantOrdContActSinDir    NUMBER;    

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);   
    
        OPEN cuCantOrdContActSinDir;
        FETCH cuCantOrdContActSinDir INTO nuCantOrdContActSinDir;
        CLOSE cuCantOrdContActSinDir;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);   
                
        RETURN nuCantOrdContActSinDir;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuCantOrdContActSinDir;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuCantOrdContActSinDir;
    END fnuCantOrdContActSinDir;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneClasifContabTiTr 
    Descripcion     : Obtiene el clasificador contable para el tipo de trabajo
    Autor           : Lubin Pineda - MVM 
    Fecha           : 07/10/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/10/2024  OSF-3162 Creacion
    ***************************************************************************/     
    FUNCTION fnuObtieneClasifContabTiTr( inuTipoTrabajo NUMBER)
    RETURN ic_clascott.clctclco%TYPE
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtieneClasifContabTiTr';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        CURSOR cuClasifContabTiTr
        IS
        SELECT ct.clctclco
        FROM ic_clascott ct
        WHERE ct.clcttitr = inuTipoTrabajo;
                                 
        nuClasifContabTiTr  ic_clascott.clctclco%TYPE;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuClasifContabTiTr;
        FETCH cuClasifContabTiTr INTO nuClasifContabTiTr;
        CLOSE cuClasifContabTiTr;
      
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);   
                
        RETURN nuClasifContabTiTr;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuClasifContabTiTr;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuClasifContabTiTr;
    END fnuObtieneClasifContabTiTr;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuCantOrdDetalleActa 
    Descripcion     : Obtiene la cantidad de ordenes en ge_detalle_acta
    Autor           : Lubin Pineda - MVM 
    Fecha           : 07/10/2024 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/10/2024  OSF-3162 Creacion
    ***************************************************************************/     
    FUNCTION fnuCantOrdDetalleActa( inuActa NUMBER)
    RETURN NUMBER
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtieneClasifContabTiTr';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        CURSOR cuCantOrdDetalleActa
        IS
        SELECT COUNT(1)
        FROM ge_detalle_acta
        WHERE id_acta  = inuActa;
        
        nuCantOrdDetalleActa    NUMBER := 0;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        OPEN cuCantOrdDetalleActa;
        FETCH cuCantOrdDetalleActa INTO nuCantOrdDetalleActa;
        CLOSE cuCantOrdDetalleActa;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
            
        RETURN nuCantOrdDetalleActa;
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuCantOrdDetalleActa;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN nuCantOrdDetalleActa;    
    END fnuCantOrdDetalleActa;           
         
END pkg_BCValida_tt_local;
/

Prompt Otorgando permisos sobre ADM_PERSON.pkg_BCValida_tt_local
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_BCValida_tt_local'), 'ADM_PERSON');
END;
/

