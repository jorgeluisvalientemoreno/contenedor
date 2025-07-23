CREATE OR REPLACE PACKAGE adm_person.pkg_LDC_ORDENES_RP AS
  TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
  TYPE tytbRegistros IS TABLE OF LDC_ORDENES_RP%ROWTYPE INDEX BY BINARY_INTEGER;
  CURSOR cuLDC_ORDENES_RP IS
    SELECT * FROM LDC_ORDENES_RP;
  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe y Efigas
      Autor : Jorge Valiente
      Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
      Tabla : LDC_ORDENES_RP
      Caso  : OSF-3821
      Fecha : 24/01/2025 16:20:13
  ***************************************************************************/
  CURSOR cuRegistroRId(inuPRODUCT_ID NUMBER,
                       inuORDER_ID   NUMBER,
                       inuPACKAGE_ID NUMBER) IS
    SELECT tb.*, tb.Rowid
      FROM LDC_ORDENES_RP tb
     WHERE PRODUCT_ID = inuPRODUCT_ID
       AND nvl(ORDER_ID, 0) = nvl(inuORDER_ID, 0)
       AND nvl(PACKAGE_ID, 0) = nvl(inuPACKAGE_ID, 0);

  CURSOR cuRegistroRIdLock(inuPRODUCT_ID NUMBER,
                           inuORDER_ID   NUMBER,
                           inuPACKAGE_ID NUMBER) IS
    SELECT tb.*, tb.Rowid
      FROM LDC_ORDENES_RP tb
     WHERE PRODUCT_ID = inuPRODUCT_ID
       AND nvl(ORDER_ID, 0) = nvl(inuORDER_ID, 0)
       AND nvl(PACKAGE_ID, 0) = nvl(inuPACKAGE_ID, 0)
       FOR UPDATE NOWAIT;

  -- Obtiene el registro y el rowid
  FUNCTION frcObtRegistroRId(inuPRODUCT_ID NUMBER,
                             inuORDER_ID   NUMBER,
                             inuPACKAGE_ID NUMBER,
                             iblBloquea    BOOLEAN DEFAULT FALSE)
    RETURN cuRegistroRId%ROWTYPE;

  -- Retorna verdadero si existe el registro
  FUNCTION fblExiste(inuPRODUCT_ID NUMBER,
                     inuORDER_ID   NUMBER,
                     inuPACKAGE_ID NUMBER) RETURN BOOLEAN;

  -- Levanta excepción si el registro NO existe
  PROCEDURE prValExiste(inuPRODUCT_ID NUMBER,
                        inuORDER_ID   NUMBER,
                        inuPACKAGE_ID NUMBER);

  -- Inserta un registro
  PROCEDURE prinsRegistro(ircRegistro cuLDC_ORDENES_RP%ROWTYPE);

  -- Inserta un registro
  PROCEDURE prcInstarRegistro(inuPRODUCT_ID LDC_ORDENES_RP.PRODUCT_ID%TYPE,
                              inuORDER_ID   LDC_ORDENES_RP.ORDER_ID%TYPE,
                              inuPACKAGE_ID LDC_ORDENES_RP.PACKAGE_ID%TYPE);

  -- Borra un registro
  PROCEDURE prBorRegistro(inuPRODUCT_ID NUMBER,
                          inuORDER_ID   NUMBER,
                          inuPACKAGE_ID NUMBER);

  -- Borra un registro por RowId
  PROCEDURE prBorRegistroxRowId(iRowId ROWID);

  -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
  PROCEDURE prActRegistro(ircRegistro cuLDC_ORDENES_RP%ROWTYPE);

END pkg_LDC_ORDENES_RP;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_LDC_ORDENES_RP AS
  csbSP_NAME    CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;
  -- Obtiene registro y RowId
  FUNCTION frcObtRegistroRId(inuPRODUCT_ID NUMBER,
                             inuORDER_ID   NUMBER,
                             inuPACKAGE_ID NUMBER,
                             iblBloquea    BOOLEAN DEFAULT FALSE)
    RETURN cuRegistroRId%ROWTYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'frcObtRegistroRId';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroRId cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF iblBloquea THEN
      OPEN cuRegistroRIdLock(inuPRODUCT_ID, inuORDER_ID, inuPACKAGE_ID);
      FETCH cuRegistroRIdLock
        INTO rcRegistroRId;
      CLOSE cuRegistroRIdLock;
    ELSE
      OPEN cuRegistroRId(inuPRODUCT_ID, inuORDER_ID, inuPACKAGE_ID);
      FETCH cuRegistroRId
        INTO rcRegistroRId;
      CLOSE cuRegistroRId;
    END IF;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroRId;
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
  END frcObtRegistroRId;

  -- Retorna verdadero si el registro existe
  FUNCTION fblExiste(inuPRODUCT_ID NUMBER,
                     inuORDER_ID   NUMBER,
                     inuPACKAGE_ID NUMBER) RETURN BOOLEAN IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblExiste';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroRId cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroRId := frcObtRegistroRId(inuPRODUCT_ID,
                                       inuORDER_ID,
                                       inuPACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroRId.PRODUCT_ID IS NOT NULL;
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
  END fblExiste;

  -- Eleva error si el registro no existe
  PROCEDURE prValExiste(inuPRODUCT_ID NUMBER,
                        inuORDER_ID   NUMBER,
                        inuPACKAGE_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prValExiste';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NOT fblExiste(inuPRODUCT_ID, inuORDER_ID, inuPACKAGE_ID) THEN
      pkg_error.setErrorMessage(isbMsgErrr => 'No existe el registro [' ||
                                              inuPRODUCT_ID || ',' ||
                                              inuORDER_ID || ',' ||
                                              inuPACKAGE_ID ||
                                              '] en la tabla[LDC_ORDENES_RP]');
    END IF;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
  END prValExiste;

  -- Inserta un registro
  PROCEDURE prInsRegistro(ircRegistro cuLDC_ORDENES_RP%ROWTYPE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsRegistro';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    INSERT INTO LDC_ORDENES_RP
      (PRODUCT_ID, ORDER_ID, PACKAGE_ID)
    VALUES
      (ircRegistro.PRODUCT_ID,
       ircRegistro.ORDER_ID,
       ircRegistro.PACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
  END prInsRegistro;

  -- Inserta un registro
  PROCEDURE prcInstarRegistro(inuPRODUCT_ID LDC_ORDENES_RP.PRODUCT_ID%TYPE,
                              inuORDER_ID   LDC_ORDENES_RP.ORDER_ID%TYPE,
                              inuPACKAGE_ID LDC_ORDENES_RP.PACKAGE_ID%TYPE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcInstarRegistro';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    INSERT INTO LDC_ORDENES_RP
      (PRODUCT_ID, ORDER_ID, PACKAGE_ID)
    VALUES
      (inuPRODUCT_ID, inuORDER_ID, inuPACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
  END prcInstarRegistro;

  -- Borra un registro
  PROCEDURE prBorRegistro(inuPRODUCT_ID NUMBER,
                          inuORDER_ID   NUMBER,
                          inuPACKAGE_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prBorRegistro';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPRODUCT_ID,
                                       inuORDER_ID,
                                       inuPACKAGE_ID,
                                       TRUE);
    IF rcRegistroAct.RowId IS NOT NULL THEN
      DELETE LDC_ORDENES_RP WHERE ROWID = rcRegistroAct.RowId;
    END IF;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
  END prBorRegistro;

  -- Borra un registro por RowId
  PROCEDURE prBorRegistroxRowId(iRowId ROWID) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prBorRegistroxRowId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF iRowId IS NOT NULL THEN
      DELETE LDC_ORDENES_RP WHERE RowId = iRowId;
    END IF;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
  END prBorRegistroxRowId;

  -- Actualiza las columnas con valor diferente al anterior
  PROCEDURE prActRegistro(ircRegistro cuLDC_ORDENES_RP%ROWTYPE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prActRegistro';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(ircRegistro.PRODUCT_ID,
                                       ircRegistro.ORDER_ID,
                                       ircRegistro.PACKAGE_ID,
                                       TRUE);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
  END prActRegistro;

END pkg_LDC_ORDENES_RP;
/
BEGIN
  pkg_Utilidades.prAplicarPermisos(UPPER('pkg_LDC_ORDENES_RP'),
                                   UPPER('adm_person'));
END;
/
