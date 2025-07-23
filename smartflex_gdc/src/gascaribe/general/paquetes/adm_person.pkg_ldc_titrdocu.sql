CREATE OR REPLACE PACKAGE adm_person.pkg_LDC_TITRDOCU AS
  TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
  TYPE tytbRegistros IS TABLE OF LDC_TITRDOCU%ROWTYPE INDEX BY BINARY_INTEGER;
  CURSOR cuLDC_TITRDOCU IS
    SELECT * FROM LDC_TITRDOCU;
  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe y Efigas
      Autor : jorge valiente
      Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
      Tabla : LDC_TITRDOCU
      Caso  : OSF-3957
      Fecha : 10/02/2025 14:31:27
  ***************************************************************************/
  CURSOR cuRegistroRId(inuTASK_TYPE_ID NUMBER) IS
    SELECT tb.*, tb.Rowid
      FROM LDC_TITRDOCU tb
     WHERE TASK_TYPE_ID = inuTASK_TYPE_ID;

  CURSOR cuRegistroRIdLock(inuTASK_TYPE_ID NUMBER) IS
    SELECT tb.*, tb.Rowid
      FROM LDC_TITRDOCU tb
     WHERE TASK_TYPE_ID = inuTASK_TYPE_ID
       FOR UPDATE NOWAIT;

  -- Obtiene el registro y el rowid
  FUNCTION frcObtRegistroRId(inuTASK_TYPE_ID NUMBER,
                             iblBloquea      BOOLEAN DEFAULT FALSE)
    RETURN cuRegistroRId%ROWTYPE;

  -- Retorna verdadero si existe el registro
  FUNCTION fblExiste(inuTASK_TYPE_ID NUMBER) RETURN BOOLEAN;

  -- Levanta excepción si el registro NO existe
  PROCEDURE prValExiste(inuTASK_TYPE_ID NUMBER);

  -- Inserta un registro
  PROCEDURE prinsRegistro(ircRegistro cuLDC_TITRDOCU%ROWTYPE);

  -- Borra un registro
  PROCEDURE prBorRegistro(inuTASK_TYPE_ID NUMBER);

  -- Borra un registro por RowId
  PROCEDURE prBorRegistroxRowId(iRowId ROWID);

  -- Obtiene el valor de la columna CANT_DOCU
  FUNCTION fnuObtCANT_DOCU(inuTASK_TYPE_ID NUMBER)
    RETURN LDC_TITRDOCU.CANT_DOCU%TYPE;

  -- Obtiene el valor de la columna BLOCK_PAGO
  FUNCTION fsbObtBLOCK_PAGO(inuTASK_TYPE_ID NUMBER)
    RETURN LDC_TITRDOCU.BLOCK_PAGO%TYPE;

  -- Actualiza el valor de la columna CANT_DOCU
  PROCEDURE prAcCANT_DOCU(inuTASK_TYPE_ID NUMBER, inuCANT_DOCU NUMBER);

  -- Actualiza el valor de la columna BLOCK_PAGO
  PROCEDURE prAcBLOCK_PAGO(inuTASK_TYPE_ID NUMBER, isbBLOCK_PAGO VARCHAR2);

  -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
  PROCEDURE prActRegistro(ircRegistro cuLDC_TITRDOCU%ROWTYPE);

END pkg_LDC_TITRDOCU;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_LDC_TITRDOCU AS
  csbSP_NAME    CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;
  -- Obtiene registro y RowId
  FUNCTION frcObtRegistroRId(inuTASK_TYPE_ID NUMBER,
                             iblBloquea      BOOLEAN DEFAULT FALSE)
    RETURN cuRegistroRId%ROWTYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'frcObtRegistroRId';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroRId cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF iblBloquea THEN
      OPEN cuRegistroRIdLock(inuTASK_TYPE_ID);
      FETCH cuRegistroRIdLock
        INTO rcRegistroRId;
      CLOSE cuRegistroRIdLock;
    ELSE
      OPEN cuRegistroRId(inuTASK_TYPE_ID);
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
  FUNCTION fblExiste(inuTASK_TYPE_ID NUMBER) RETURN BOOLEAN IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblExiste';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroRId cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroRId := frcObtRegistroRId(inuTASK_TYPE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroRId.TASK_TYPE_ID IS NOT NULL;
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
  PROCEDURE prValExiste(inuTASK_TYPE_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prValExiste';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NOT fblExiste(inuTASK_TYPE_ID) THEN
      pkg_error.setErrorMessage(isbMsgErrr => 'No existe el registro [' ||
                                              inuTASK_TYPE_ID ||
                                              '] en la tabla[LDC_TITRDOCU]');
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
  PROCEDURE prInsRegistro(ircRegistro cuLDC_TITRDOCU%ROWTYPE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsRegistro';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    INSERT INTO LDC_TITRDOCU
      (TASK_TYPE_ID, CANT_DOCU, BLOCK_PAGO)
    VALUES
      (ircRegistro.TASK_TYPE_ID,
       ircRegistro.CANT_DOCU,
       ircRegistro.BLOCK_PAGO);
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

  -- Borra un registro
  PROCEDURE prBorRegistro(inuTASK_TYPE_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prBorRegistro';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID, TRUE);
    IF rcRegistroAct.RowId IS NOT NULL THEN
      DELETE LDC_TITRDOCU WHERE ROWID = rcRegistroAct.RowId;
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
      DELETE LDC_TITRDOCU WHERE RowId = iRowId;
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

  -- Obtiene el valor de la columna CANT_DOCU
  FUNCTION fnuObtCANT_DOCU(inuTASK_TYPE_ID NUMBER)
    RETURN LDC_TITRDOCU.CANT_DOCU%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtCANT_DOCU';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.CANT_DOCU;
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
  END fnuObtCANT_DOCU;

  -- Obtiene el valor de la columna BLOCK_PAGO
  FUNCTION fsbObtBLOCK_PAGO(inuTASK_TYPE_ID NUMBER)
    RETURN LDC_TITRDOCU.BLOCK_PAGO%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtBLOCK_PAGO';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.BLOCK_PAGO;
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
  END fsbObtBLOCK_PAGO;

  -- Actualiza el valor de la columna CANT_DOCU
  PROCEDURE prAcCANT_DOCU(inuTASK_TYPE_ID NUMBER, inuCANT_DOCU NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcCANT_DOCU';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID, TRUE);
    IF NVL(inuCANT_DOCU, -1) <> NVL(rcRegistroAct.CANT_DOCU, -1) THEN
      UPDATE LDC_TITRDOCU
         SET CANT_DOCU = inuCANT_DOCU
       WHERE Rowid = rcRegistroAct.RowId;
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
  END prAcCANT_DOCU;

  -- Actualiza el valor de la columna BLOCK_PAGO
  PROCEDURE prAcBLOCK_PAGO(inuTASK_TYPE_ID NUMBER, isbBLOCK_PAGO VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcBLOCK_PAGO';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuTASK_TYPE_ID, TRUE);
    IF NVL(isbBLOCK_PAGO, '-') <> NVL(rcRegistroAct.BLOCK_PAGO, '-') THEN
      UPDATE LDC_TITRDOCU
         SET BLOCK_PAGO = isbBLOCK_PAGO
       WHERE Rowid = rcRegistroAct.RowId;
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
  END prAcBLOCK_PAGO;

  -- Actualiza por RowId el valor de la columna CANT_DOCU
  PROCEDURE prAcCANT_DOCU_RId(iRowId         ROWID,
                              inuCANT_DOCU_O NUMBER,
                              inuCANT_DOCU_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcCANT_DOCU_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuCANT_DOCU_O, -1) <> NVL(inuCANT_DOCU_N, -1) THEN
      UPDATE LDC_TITRDOCU
         SET CANT_DOCU = inuCANT_DOCU_N
       WHERE Rowid = iRowId;
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
  END prAcCANT_DOCU_RId;

  -- Actualiza por RowId el valor de la columna BLOCK_PAGO
  PROCEDURE prAcBLOCK_PAGO_RId(iRowId          ROWID,
                               isbBLOCK_PAGO_O VARCHAR2,
                               isbBLOCK_PAGO_N VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcBLOCK_PAGO_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(isbBLOCK_PAGO_O, '-') <> NVL(isbBLOCK_PAGO_N, '-') THEN
      UPDATE LDC_TITRDOCU
         SET BLOCK_PAGO = isbBLOCK_PAGO_N
       WHERE Rowid = iRowId;
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
  END prAcBLOCK_PAGO_RId;

  -- Actualiza las columnas con valor diferente al anterior
  PROCEDURE prActRegistro(ircRegistro cuLDC_TITRDOCU%ROWTYPE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prActRegistro';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(ircRegistro.TASK_TYPE_ID, TRUE);
    IF rcRegistroAct.RowId IS NOT NULL THEN
      prAcCANT_DOCU_RId(rcRegistroAct.RowId,
                        rcRegistroAct.CANT_DOCU,
                        ircRegistro.CANT_DOCU);
    
      prAcBLOCK_PAGO_RId(rcRegistroAct.RowId,
                         rcRegistroAct.BLOCK_PAGO,
                         ircRegistro.BLOCK_PAGO);
    
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
  END prActRegistro;

END pkg_LDC_TITRDOCU;
/
BEGIN
  -- OSF-3957
  pkg_Utilidades.prAplicarPermisos(UPPER('pkg_LDC_TITRDOCU'),
                                   UPPER('adm_person'));
END;
/
