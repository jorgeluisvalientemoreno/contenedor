CREATE OR REPLACE PACKAGE adm_person.pkg_ldc_inv_ouib AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF ldc_inv_ouib%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR culdc_inv_ouib IS SELECT * FROM ldc_inv_ouib;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : felipe.valencia
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : ldc_inv_ouib
        Caso  : OSF-3976
        Fecha : 05/02/2025 16:58:51
        Modificaciones
        fecha       Autor       Caso        Descripcion
        06/03/2025  jpinedc     OSF-4042    Se crean fnuObtCostoTotal y 
                                            fnuObtCantidadAsignada        
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuITEMS_ID    NUMBER,inuOPERATING_UNIT_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM ldc_inv_ouib tb
        WHERE
        ITEMS_ID = inuITEMS_ID AND
        OPERATING_UNIT_ID = inuOPERATING_UNIT_ID;
     
    CURSOR cuRegistroRIdLock
    (
        inuITEMS_ID    NUMBER,inuOPERATING_UNIT_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM ldc_inv_ouib tb
        WHERE
        ITEMS_ID = inuITEMS_ID AND
        OPERATING_UNIT_ID = inuOPERATING_UNIT_ID
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuITEMS_ID    NUMBER,inuOPERATING_UNIT_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuITEMS_ID    NUMBER,inuOPERATING_UNIT_ID    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuITEMS_ID    NUMBER,inuOPERATING_UNIT_ID    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro culdc_inv_ouib%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuITEMS_ID    NUMBER,inuOPERATING_UNIT_ID    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
    
    -- Obtiene el costo total del item de tipo inventario
    FUNCTION fnuObtCostoTotal(
        inuItem                 IN  ldc_inv_ouib.items_id%TYPE,
        inunuUnidadOperativa    IN  ldc_inv_ouib.operating_unit_id%TYPE
    )
    RETURN ldc_inv_ouib.total_costs%TYPE;
    
    -- Obtiene la cantidad asignada a la unidad del item de tipo inventario
    FUNCTION fnuObtCantidadAsignada(
        inuItem                 IN  ldc_inv_ouib.items_id%TYPE,
        inunuUnidadOperativa    IN  ldc_inv_ouib.operating_unit_id%TYPE
    )
    RETURN ldc_inv_ouib.quota%TYPE;      

    -- Obtiene la cantidad disponible la unidad del item de tipo inventario
    FUNCTION fnuObtCantidadDisponible(
        inuItem                 IN  ldc_inv_ouib.items_id%TYPE,
        inunuUnidadOperativa    IN  ldc_inv_ouib.operating_unit_id%TYPE
    )
    RETURN ldc_inv_ouib.balance%TYPE;    
 
END pkg_ldc_inv_ouib;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldc_inv_ouib AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuITEMS_ID    NUMBER,inuOPERATING_UNIT_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuITEMS_ID,inuOPERATING_UNIT_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuITEMS_ID,inuOPERATING_UNIT_ID);
            FETCH cuRegistroRId INTO rcRegistroRId;
            CLOSE cuRegistroRId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END frcObtRegistroRId;
 
    -- Retorna verdadero si el registro existe
    FUNCTION fblExiste(
        inuITEMS_ID    NUMBER,inuOPERATING_UNIT_ID    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuITEMS_ID,inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.ITEMS_ID IS NOT NULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fblExiste;
 
    -- Eleva error si el registro no existe
    PROCEDURE prValExiste(
        inuITEMS_ID    NUMBER,inuOPERATING_UNIT_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuITEMS_ID,inuOPERATING_UNIT_ID) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuITEMS_ID||','||inuOPERATING_UNIT_ID||'] en la tabla[ldc_inv_ouib]');
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prValExiste;
 
    -- Inserta un registro
    PROCEDURE prInsRegistro( ircRegistro culdc_inv_ouib%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO ldc_inv_ouib(
            ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT
        )
        VALUES (
            ircRegistro.ITEMS_ID,ircRegistro.OPERATING_UNIT_ID,ircRegistro.QUOTA,ircRegistro.BALANCE,ircRegistro.TOTAL_COSTS,ircRegistro.OCCACIONAL_QUOTA,ircRegistro.TRANSIT_IN,ircRegistro.TRANSIT_OUT
        );
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prInsRegistro;
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuITEMS_ID    NUMBER,inuOPERATING_UNIT_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuITEMS_ID,inuOPERATING_UNIT_ID, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE ldc_inv_ouib
            WHERE 
            ROWID = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prBorRegistro;
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistroxRowId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iRowId IS NOT NULL THEN
            DELETE ldc_inv_ouib
            WHERE RowId = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prBorRegistroxRowId;
    
    -- Obtiene el costo total del item de tipo activo
    FUNCTION fnuObtCostoTotal(
        inuItem                 IN  ldc_inv_ouib.items_id%TYPE,
        inunuUnidadOperativa    IN  ldc_inv_ouib.operating_unit_id%TYPE
    )
    RETURN ldc_inv_ouib.total_costs%TYPE
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCostoTotal';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        nuCostoTotal    ldc_inv_ouib.total_costs%TYPE;
        
        CURSOR cuObtCostoTotal
        IS
        SELECT total_costs
        FROM ldc_inv_ouib 
        WHERE items_id = inuItem
        AND operating_unit_id = inunuUnidadOperativa;
        
        PROCEDURE prcCierraCursor
        IS
            csbMetodo1        CONSTANT VARCHAR2(70) := csbMetodo||'.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);        
        BEGIN
        
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);
            
            IF cuObtCostoTotal%ISOPEN THEN
                CLOSE cuObtCostoTotal;
            END IF;

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError1,sbError1);
                pkg_traza.trace('sbError1 => '||sbError1, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError1,sbError1);
                pkg_traza.trace('sbError1 => '||sbError1, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;        
        END prcCierraCursor;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuObtCostoTotal;
        FETCH cuObtCostoTotal INTO nuCostoTotal;
        CLOSE cuObtCostoTotal;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN nuCostoTotal;
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN nuCostoTotal;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN nuCostoTotal;
    END fnuObtCostoTotal;    
                
    -- Obtiene la cantidad asignada a la unidad del item de tipo activo
    FUNCTION fnuObtCantidadAsignada(
        inuItem                 IN  ldc_inv_ouib.items_id%TYPE,
        inunuUnidadOperativa    IN  ldc_inv_ouib.operating_unit_id%TYPE
    )
    RETURN ldc_inv_ouib.quota%TYPE        
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCantidadAsignada';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        nuCantidadAsignada    ldc_inv_ouib.quota%TYPE;
        
        CURSOR cuObtCantidadAsignada
        IS
        SELECT quota
        FROM ldc_inv_ouib 
        WHERE items_id = inuItem
        AND operating_unit_id = inunuUnidadOperativa;
        
        PROCEDURE prcCierraCursor
        IS
            csbMetodo1        CONSTANT VARCHAR2(70) := csbMetodo||'.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);        
        BEGIN
        
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);
            
            IF cuObtCantidadAsignada%ISOPEN THEN
                CLOSE cuObtCantidadAsignada;
            END IF;

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError1,sbError1);
                pkg_traza.trace('sbError1 => '||sbError1, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError1,sbError1);
                pkg_traza.trace('sbError1 => '||sbError1, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;        
        END prcCierraCursor;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuObtCantidadAsignada;
        FETCH cuObtCantidadAsignada INTO nuCantidadAsignada;
        CLOSE cuObtCantidadAsignada;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN nuCantidadAsignada;
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN nuCantidadAsignada;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN nuCantidadAsignada;
    END fnuObtCantidadAsignada;      

    -- Obtiene la cantidad disponible la unidad del item de tipo inventario
    FUNCTION fnuObtCantidadDisponible(
        inuItem                 IN  ldc_inv_ouib.items_id%TYPE,
        inunuUnidadOperativa    IN  ldc_inv_ouib.operating_unit_id%TYPE
    )
    RETURN ldc_inv_ouib.balance%TYPE      
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCantidadDisponible';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        nuCantidadDisponible    ldc_inv_ouib.balance%TYPE;
        
        CURSOR cuObtCantidadDisponible
        IS
        SELECT balance
        FROM ldc_inv_ouib 
        WHERE items_id = inuItem
        AND operating_unit_id = inunuUnidadOperativa;
        
        PROCEDURE prcCierraCursor
        IS
            csbMetodo1        CONSTANT VARCHAR2(70) := csbMetodo||'.prcCierraCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);        
        BEGIN
        
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);
            
            IF cuObtCantidadDisponible%ISOPEN THEN
                CLOSE cuObtCantidadDisponible;
            END IF;

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError1,sbError1);
                pkg_traza.trace('sbError1 => '||sbError1, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError1,sbError1);
                pkg_traza.trace('sbError1 => '||sbError1, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;        
        END prcCierraCursor;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuObtCantidadDisponible;
        FETCH cuObtCantidadDisponible INTO nuCantidadDisponible;
        CLOSE cuObtCantidadDisponible;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN nuCantidadDisponible;
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN nuCantidadDisponible;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
            prcCierraCursor;
            RETURN nuCantidadDisponible;
    END fnuObtCantidadDisponible;  
 
END pkg_ldc_inv_ouib;
/

BEGIN
    -- OSF-3860
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_ldc_inv_ouib'), UPPER('adm_person'));
END;
/

