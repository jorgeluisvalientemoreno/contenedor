CREATE OR REPLACE PACKAGE adm_person.pkg_LDC_HOMOITMAITAC AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF LDC_HOMOITMAITAC%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuLDC_HOMOITMAITAC IS SELECT * FROM LDC_HOMOITMAITAC;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : OPEN
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : LDC_HOMOITMAITAC
        Caso  : OSF-XXXX
        Fecha : 11/06/2025 17:09:48
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuITEM_MATERIAL    NUMBER,inuITEM_ACTIVIDAD    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_HOMOITMAITAC tb
        WHERE
        ITEM_MATERIAL = inuITEM_MATERIAL AND
        ITEM_ACTIVIDAD = inuITEM_ACTIVIDAD;
     
    CURSOR cuRegistroRIdLock
    (
        inuITEM_MATERIAL    NUMBER,inuITEM_ACTIVIDAD    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM LDC_HOMOITMAITAC tb
        WHERE
        ITEM_MATERIAL = inuITEM_MATERIAL AND
        ITEM_ACTIVIDAD = inuITEM_ACTIVIDAD
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuITEM_MATERIAL    NUMBER,inuITEM_ACTIVIDAD    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuITEM_MATERIAL    NUMBER,inuITEM_ACTIVIDAD    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuITEM_MATERIAL    NUMBER,inuITEM_ACTIVIDAD    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuLDC_HOMOITMAITAC%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuITEM_MATERIAL    NUMBER,inuITEM_ACTIVIDAD    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna EMPRESA
    FUNCTION fsbObtEMPRESA(
        inuITEM_MATERIAL    NUMBER,inuITEM_ACTIVIDAD    NUMBER
        ) RETURN LDC_HOMOITMAITAC.EMPRESA%TYPE;
 
    -- Actualiza el valor de la columna EMPRESA
    PROCEDURE prAcEMPRESA(
        inuITEM_MATERIAL    NUMBER,inuITEM_ACTIVIDAD    NUMBER,
        isbEMPRESA    VARCHAR2
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLDC_HOMOITMAITAC%ROWTYPE);

    FUNCTION fsbObtEMPRESA_ACTIVIDAD(
        inuITEM_ACTIVIDAD    NUMBER
        ) RETURN LDC_HOMOITMAITAC.EMPRESA%TYPE;
 
END pkg_LDC_HOMOITMAITAC;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_LDC_HOMOITMAITAC AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuITEM_MATERIAL    NUMBER,inuITEM_ACTIVIDAD    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuITEM_MATERIAL,inuITEM_ACTIVIDAD);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuITEM_MATERIAL,inuITEM_ACTIVIDAD);
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
        inuITEM_MATERIAL    NUMBER,inuITEM_ACTIVIDAD    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuITEM_MATERIAL,inuITEM_ACTIVIDAD);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.ITEM_MATERIAL IS NOT NULL;
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
        inuITEM_MATERIAL    NUMBER,inuITEM_ACTIVIDAD    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuITEM_MATERIAL,inuITEM_ACTIVIDAD) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuITEM_MATERIAL||','||inuITEM_ACTIVIDAD||'] en la tabla[LDC_HOMOITMAITAC]');
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
    PROCEDURE prInsRegistro( ircRegistro cuLDC_HOMOITMAITAC%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO LDC_HOMOITMAITAC(
            ITEM_MATERIAL,ITEM_ACTIVIDAD,EMPRESA
        )
        VALUES (
            ircRegistro.ITEM_MATERIAL,ircRegistro.ITEM_ACTIVIDAD,ircRegistro.EMPRESA
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
        inuITEM_MATERIAL    NUMBER,inuITEM_ACTIVIDAD    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuITEM_MATERIAL,inuITEM_ACTIVIDAD, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE LDC_HOMOITMAITAC
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
            DELETE LDC_HOMOITMAITAC
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
 
    -- Obtiene el valor de la columna EMPRESA
    FUNCTION fsbObtEMPRESA(
        inuITEM_MATERIAL    NUMBER,inuITEM_ACTIVIDAD    NUMBER
        ) RETURN LDC_HOMOITMAITAC.EMPRESA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtEMPRESA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuITEM_MATERIAL,inuITEM_ACTIVIDAD);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.EMPRESA;
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
    END fsbObtEMPRESA;
 
    -- Actualiza el valor de la columna EMPRESA
    PROCEDURE prAcEMPRESA(
        inuITEM_MATERIAL    NUMBER,inuITEM_ACTIVIDAD    NUMBER,
        isbEMPRESA    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEMPRESA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuITEM_MATERIAL,inuITEM_ACTIVIDAD,TRUE);
        IF NVL(isbEMPRESA,'-') <> NVL(rcRegistroAct.EMPRESA,'-') THEN
            UPDATE LDC_HOMOITMAITAC
            SET EMPRESA=isbEMPRESA
            WHERE Rowid = rcRegistroAct.RowId;
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
    END prAcEMPRESA;
 
    -- Actualiza por RowId el valor de la columna EMPRESA
    PROCEDURE prAcEMPRESA_RId(
        iRowId ROWID,
        isbEMPRESA_O    VARCHAR2,
        isbEMPRESA_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEMPRESA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbEMPRESA_O,'-') <> NVL(isbEMPRESA_N,'-') THEN
            UPDATE LDC_HOMOITMAITAC
            SET EMPRESA=isbEMPRESA_N
            WHERE Rowid = iRowId;
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
    END prAcEMPRESA_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuLDC_HOMOITMAITAC%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.ITEM_MATERIAL,ircRegistro.ITEM_ACTIVIDAD,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcEMPRESA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.EMPRESA,
                ircRegistro.EMPRESA
            );
 
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
    END prActRegistro;
    -- Obtiene el valor de la columna EMPRESA DEL ITEM ACTIVIDAD
    FUNCTION fsbObtEMPRESA_ACTIVIDAD(
        inuITEM_ACTIVIDAD    NUMBER
        ) RETURN LDC_HOMOITMAITAC.EMPRESA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtEMPRESA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        sbCodEmpresa 	ldc_homoitmaitac.empresa%TYPE;
		
		CURSOR cuEmpresaDeActividad
		IS
		SELECT EMPRESA
		FROM LDC_HOMOITMAITAC
		WHERE ITEM_ACTIVIDAD = inuITEM_ACTIVIDAD;
		
		
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
		pkg_traza.trace('inuITEM_ACTIVIDAD: '||inuITEM_ACTIVIDAD);

		
		IF cuEmpresaDeActividad%ISOPEN THEN
			CLOSE cuEmpresaDeActividad;
		END IF;
		
		
        OPEN cuEmpresaDeActividad;
		FETCH cuEmpresaDeActividad INTO sbCodEmpresa;
		CLOSE cuEmpresaDeActividad;
		
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
		
        RETURN sbCodEmpresa;
        
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
    END fsbObtEMPRESA_ACTIVIDAD;

 
END pkg_LDC_HOMOITMAITAC;
/
BEGIN
    -- OSF-XXXX
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_LDC_HOMOITMAITAC'), UPPER('adm_person'));
END;
/
