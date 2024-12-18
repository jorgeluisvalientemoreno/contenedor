CREATE OR REPLACE PACKAGE personalizaciones.pkg_bccambio_direccion_ordenes IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bccambio_direccion_ordenes
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   12/03/2024
    Descripcion :   Paquete con consultas para manejo cambio de dirección de
                    Ordenes
    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    PAcosta             17/05/2024      OSF-2706    Implementar homologación de parámetros en PKG_BCCAMBIO_DIRECCION_ORDENES - GDC
                                                    Se actualizan los siguientes métodos:
                                                    fblEsPermitidoTipoTrabajo
                                                    fblEsPermitidoEstado
    felipe.valencia     12/03/2024      OSF-2416    Creacion
*******************************************************************************/

    TYPE  tyrcInfoOrden IS RECORD
    (
        nuEstadoOrden       or_order.order_status_id%TYPE,
        nuTipoTrabajo       or_order.task_type_id%TYPE,
        nuDireccion         or_order.external_address_id%TYPE
    );

    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion 
    RETURN VARCHAR2;

    FUNCTION fblExisteDireccion
    (
        inuDireccion    IN  ab_address.address_id%type
    )
    RETURN BOOLEAN;

    FUNCTION fblValidaFormatoOrden
    (
        isbCadena        IN   VARCHAR2
    )
    RETURN BOOLEAN;

    FUNCTION frcObtieneInfoOrden
    (
        inuIdOrden  IN	or_order.order_id%TYPE
    )
    RETURN tyrcInfoOrden;

    FUNCTION fblEsPermitidoTipoTrabajo
    (
        inuTipotrabajo    IN  or_order.task_type_id%TYPE
    )
    RETURN BOOLEAN;

    FUNCTION fblEsPermitidoEstado
    (
        inuEstado    IN  or_order.order_status_id%TYPE
    )
    RETURN BOOLEAN;
END pkg_bccambio_direccion_ordenes;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bccambio_direccion_ordenes IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion     VARCHAR2(15) := 'OSF-2416';
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
    felipe.valencia     09/02/2024  OSF-2416 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fblExisteDireccion
        Descripcion     : Valida si la dirección existe
        Autor           : 
        Fecha           : 05/03/2024
        Parametros de Entrada
        
        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     05/03/2024          OSF-2416: Creación
    ***************************************************************************/
    FUNCTION fblExisteDireccion
    (
        inuDireccion    IN  ab_address.address_id%TYPE
    )
    RETURN BOOLEAN
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'fblExisteDireccion';

        blExiste            BOOLEAN := FALSE;
        nuConteo            NUMBER;

        CURSOR cuValDireccion
        (
            inuIdDireccion IN 	ab_address.address_id%type
        ) 
        IS
        SELECT  COUNT('X')
        FROM    ab_address 
        WHERE   address_id = inuIdDireccion;
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuValDireccion%ISOPEN) THEN
            CLOSE cuValDireccion;
        END IF;

        OPEN cuValDireccion(inuDireccion);
        FETCH cuValDireccion INTO nuConteo;
        CLOSE cuValDireccion;

        IF (nuConteo > 0) THEN
            blExiste := TRUE;
        END IF;  

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN blExiste;

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
    END fblExisteDireccion;

  /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fblValidaFormatoOrden
        Descripcion     : Valida si el formato de la orden es correcto
        Autor           : 
        Fecha           : 05/03/2024
        Parametros de Entrada
        
        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     05/03/2024          OSF-2416: Creación
    ***************************************************************************/
    FUNCTION fblValidaFormatoOrden
    (
        isbCadena        IN   VARCHAR2
    )
    RETURN BOOLEAN
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'fblValidaFormatoOrden';

        blFormato           BOOLEAN := FALSE;
        isbvalidaTexto      VARCHAR2(500);

        CURSOR cuValidaCadena
        (
            isbCadenaValidar        IN   VARCHAR2
        ) 
        IS
        SELECT  CASE WHEN LENGTH(TRIM(TRANSLATE(isbCadenaValidar, '0123456789-', ' '))) IS NULL
                THEN 'NUMERO'
                ELSE 'TEXTO'
                END  
        FROM dual;
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuValidaCadena%ISOPEN) THEN
            CLOSE cuValidaCadena;
        END IF;

        OPEN cuValidaCadena(isbCadena);
        FETCH cuValidaCadena INTO isbvalidaTexto;
        CLOSE cuValidaCadena;

        IF (isbvalidaTexto = 'NUMERO') THEN
            blFormato := TRUE;
        END IF;

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN blFormato;

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
    END fblValidaFormatoOrden;

   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : frcObtieneInfoOrden
        Descripcion     : Obtiene información de la orden
        Autor           : 
        Fecha           : 05/03/2024
        Parametros de Entrada
        
        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     05/03/2024          OSF-2416: Creación
    ***************************************************************************/
    FUNCTION frcObtieneInfoOrden
    (
        inuIdOrden  IN	or_order.order_id%TYPE
    )
    RETURN tyrcInfoOrden
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'frcObtieneInfoOrden';

        rcInfoOrden         tyrcInfoOrden;


        CURSOR cuObtieneInfoOrden(inuOrden IN	or_order.order_id%TYPE)
        IS
        SELECT  oo.order_status_id, oo.task_type_id, oo.external_address_id
        FROM    or_order oo
        WHERE   oo.order_id = inuOrden;
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuObtieneInfoOrden%ISOPEN) THEN
            CLOSE cuObtieneInfoOrden;
        END IF;

        OPEN cuObtieneInfoOrden(inuIdOrden);
        FETCH cuObtieneInfoOrden INTO rcInfoOrden;
        CLOSE cuObtieneInfoOrden;

        
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN rcInfoOrden;

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
    END frcObtieneInfoOrden;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fblEsPermitidoTipoTrabajo
        Descripcion     : Valida si el tipo de trabajo es permitido para el
                            cambio de dirección de la orden
        Autor           : 
        Fecha           : 05/03/2024
        Parametros de Entrada
        
        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        PAcosta             17/05/2024          OSF-2706: cambio dald_parameter.fsbgetvalue_chain por pkg_bcld_parameter.fsbobtienevalorcadena
        felipe.valencia     05/03/2024          OSF-2416: Creación
    ***************************************************************************/
    FUNCTION fblEsPermitidoTipoTrabajo
    (
        inuTipotrabajo    IN  or_order.task_type_id%TYPE
    )
    RETURN BOOLEAN
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'fblEsPermitidoTipoTrabajo';

        blExiste            BOOLEAN := FALSE;
        nuConteo            NUMBER;


        Cursor cuValidaTipoTrabajo
        (
            inuTTrabajo    IN	or_order.task_type_id%type
        ) 
        IS
        SELECT  COUNT(tipotrabajo)
        FROM    (
                    SELECT TO_NUMBER(regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena('LDC_PARTTCAMBDIREC606'),'[^,]+', 1, level)) as tipotrabajo
                    FROM dual connect by regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena('LDC_PARTTCAMBDIREC606'), '[^,]+', 1, level) is not null
                )
        WHERE tipotrabajo = inuTTrabajo;

 
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuValidaTipoTrabajo%ISOPEN) THEN
            CLOSE cuValidaTipoTrabajo;
        END IF;

        OPEN cuValidaTipoTrabajo(inuTipotrabajo);
        FETCH cuValidaTipoTrabajo INTO nuConteo;
        CLOSE cuValidaTipoTrabajo;

        IF (nuConteo > 0) THEN
            blExiste := TRUE;
        END IF;  

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN blExiste;

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
    END fblEsPermitidoTipoTrabajo;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fblEsPermitidoEstado
        Descripcion     : Valida si el tipo de trabajo es permitido para el
                            cambio de dirección de la orden
        Autor           : 
        Fecha           : 05/03/2024
        Parametros de Entrada
        
        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        PAcosta             17/05/2024          OSF-2706: cambio dald_parameter.fsbgetvalue_chain por pkg_bcld_parameter.fsbobtienevalorcadena
        felipe.valencia     05/03/2024          OSF-2416: Creación
    ***************************************************************************/
    FUNCTION fblEsPermitidoEstado
    (
        inuEstado    IN  or_order.order_status_id%TYPE
    )
    RETURN BOOLEAN
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'fblEsPermitidoEstado';

        blExiste            BOOLEAN := FALSE;
        nuConteo            NUMBER;


        Cursor cuValidaEstado
        (
            inuEstadoOrden    IN	or_order.order_status_id%type
        ) 
        IS
        SELECT  COUNT(estado)
        FROM    (
                    SELECT TO_NUMBER(regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena('LDC_PARESTADOCAMBDIREC606'),'[^,]+', 1, level)) as estado
                    FROM dual connect by regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena('LDC_PARESTADOCAMBDIREC606'), '[^,]+', 1, level) is not null
                )
        WHERE estado = inuEstadoOrden;
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuValidaEstado%ISOPEN) THEN
            CLOSE cuValidaEstado;
        END IF;

        OPEN cuValidaEstado(inuEstado);
        FETCH cuValidaEstado INTO nuConteo;
        CLOSE cuValidaEstado;

        IF (nuConteo > 0) THEN
            blExiste := TRUE;
        END IF;  

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN blExiste;

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
    END fblEsPermitidoEstado;

END pkg_bccambio_direccion_ordenes;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_bccambio_direccion_ordenes
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_bccambio_direccion_ordenes'), 'PERSONALIZACIONES');
END;
/