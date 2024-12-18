CREATE OR REPLACE PACKAGE personalizaciones.pkg_INFO_ADICIONAL_SOLICITUD AS
  TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
  TYPE tytbRegistros IS TABLE OF INFO_ADICIONAL_SOLICITUD%ROWTYPE INDEX BY BINARY_INTEGER;
  CURSOR cuINFO_ADICIONAL_SOLICITUD IS
    SELECT * FROM INFO_ADICIONAL_SOLICITUD;
  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe y Efigas
      Autor : jorge valiente
      Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
      Tabla : INFO_ADICIONAL_SOLICITUD
      Caso  : OSF-3742
      Fecha : 12/12/2024 14:57:33
  ***************************************************************************/
  CURSOR cuRegistroRId(inuPACKAGE_ID NUMBER, isbDATO_ADICIONAL VARCHAR2) IS
    SELECT tb.*, tb.Rowid
      FROM INFO_ADICIONAL_SOLICITUD tb
     WHERE PACKAGE_ID = inuPACKAGE_ID
       AND DATO_ADICIONAL = isbDATO_ADICIONAL;

  CURSOR cuRegistroRIdLock(inuPACKAGE_ID     NUMBER,
                           isbDATO_ADICIONAL VARCHAR2) IS
    SELECT tb.*, tb.Rowid
      FROM INFO_ADICIONAL_SOLICITUD tb
     WHERE PACKAGE_ID = inuPACKAGE_ID
       AND DATO_ADICIONAL = isbDATO_ADICIONAL
       FOR UPDATE NOWAIT;

  -- Obtiene el registro y el rowid
  FUNCTION frcObtRegistroRId(inuPACKAGE_ID     NUMBER,
                             isbDATO_ADICIONAL VARCHAR2,
                             iblBloquea        BOOLEAN DEFAULT FALSE)
    RETURN cuRegistroRId%ROWTYPE;

  -- Retorna verdadero si existe el registro
  FUNCTION fblExiste(inuPACKAGE_ID NUMBER, isbDATO_ADICIONAL VARCHAR2)
    RETURN BOOLEAN;

  -- Levanta excepción si el registro NO existe
  PROCEDURE prValExiste(inuPACKAGE_ID NUMBER, isbDATO_ADICIONAL VARCHAR2);

  -- Inserta un registro
  PROCEDURE prinsRegistro(ircRegistro cuINFO_ADICIONAL_SOLICITUD%ROWTYPE);

  -- Inserta un registro por atributos de entrada
  PROCEDURE prInsertaRegistro(inuPACKAGE_ID     NUMBER,
                              isbDATO_ADICIONAL VARCHAR2,
                              isbVALOR          VARCHAR2);

  -- Borra un registro
  PROCEDURE prBorRegistro(inuPACKAGE_ID NUMBER, isbDATO_ADICIONAL VARCHAR2);

  -- Borra un registro por RowId
  PROCEDURE prBorRegistroxRowId(iRowId ROWID);

  -- Obtiene el valor de la columna VALOR
  FUNCTION fsbObtVALOR(inuPACKAGE_ID NUMBER, isbDATO_ADICIONAL VARCHAR2)
    RETURN INFO_ADICIONAL_SOLICITUD.VALOR%TYPE;

  -- Actualiza el valor de la columna VALOR
  PROCEDURE prAcVALOR(inuPACKAGE_ID     NUMBER,
                      isbDATO_ADICIONAL VARCHAR2,
                      isbVALOR          VARCHAR2);

  -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
  PROCEDURE prActRegistro(ircRegistro cuINFO_ADICIONAL_SOLICITUD%ROWTYPE);

END pkg_INFO_ADICIONAL_SOLICITUD;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_INFO_ADICIONAL_SOLICITUD AS
  csbSP_NAME    CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;
  -- Obtiene registro y RowId
  FUNCTION frcObtRegistroRId(inuPACKAGE_ID     NUMBER,
                             isbDATO_ADICIONAL VARCHAR2,
                             iblBloquea        BOOLEAN DEFAULT FALSE)
    RETURN cuRegistroRId%ROWTYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'frcObtRegistroRId';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroRId cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF iblBloquea THEN
      OPEN cuRegistroRIdLock(inuPACKAGE_ID, isbDATO_ADICIONAL);
      FETCH cuRegistroRIdLock
        INTO rcRegistroRId;
      CLOSE cuRegistroRIdLock;
    ELSE
      OPEN cuRegistroRId(inuPACKAGE_ID, isbDATO_ADICIONAL);
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
  FUNCTION fblExiste(inuPACKAGE_ID NUMBER, isbDATO_ADICIONAL VARCHAR2)
    RETURN BOOLEAN IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblExiste';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroRId cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroRId := frcObtRegistroRId(inuPACKAGE_ID, isbDATO_ADICIONAL);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroRId.PACKAGE_ID IS NOT NULL;
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
  PROCEDURE prValExiste(inuPACKAGE_ID NUMBER, isbDATO_ADICIONAL VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prValExiste';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NOT fblExiste(inuPACKAGE_ID, isbDATO_ADICIONAL) THEN
      pkg_error.setErrorMessage(isbMsgErrr => 'No existe el registro [' ||
                                              inuPACKAGE_ID || ',' ||
                                              isbDATO_ADICIONAL ||
                                              '] en la tabla[INFO_ADICIONAL_SOLICITUD]');
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
  PROCEDURE prInsRegistro(ircRegistro cuINFO_ADICIONAL_SOLICITUD%ROWTYPE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsRegistro';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    INSERT INTO INFO_ADICIONAL_SOLICITUD
      (PACKAGE_ID, DATO_ADICIONAL, VALOR)
    VALUES
      (ircRegistro.PACKAGE_ID,
       ircRegistro.DATO_ADICIONAL,
       ircRegistro.VALOR);
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

  -- Inserta un registro por atributos de entrada
  PROCEDURE prInsertaRegistro(inuPACKAGE_ID     NUMBER,
                              isbDATO_ADICIONAL VARCHAR2,
                              isbVALOR          VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsRegistro';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    INSERT INTO INFO_ADICIONAL_SOLICITUD
      (PACKAGE_ID, DATO_ADICIONAL, VALOR)
    VALUES
      (inuPACKAGE_ID, isbDATO_ADICIONAL, isbVALOR);
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
  END prInsertaRegistro;

  -- Borra un registro
  PROCEDURE prBorRegistro(inuPACKAGE_ID NUMBER, isbDATO_ADICIONAL VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prBorRegistro';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID,
                                       isbDATO_ADICIONAL,
                                       TRUE);
    IF rcRegistroAct.RowId IS NOT NULL THEN
      DELETE INFO_ADICIONAL_SOLICITUD WHERE ROWID = rcRegistroAct.RowId;
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
      DELETE INFO_ADICIONAL_SOLICITUD WHERE RowId = iRowId;
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

  -- Obtiene el valor de la columna VALOR
  FUNCTION fsbObtVALOR(inuPACKAGE_ID NUMBER, isbDATO_ADICIONAL VARCHAR2)
    RETURN INFO_ADICIONAL_SOLICITUD.VALOR%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtVALOR';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID, isbDATO_ADICIONAL);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.VALOR;
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
  END fsbObtVALOR;

  -- Actualiza el valor de la columna VALOR
  PROCEDURE prAcVALOR(inuPACKAGE_ID     NUMBER,
                      isbDATO_ADICIONAL VARCHAR2,
                      isbVALOR          VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcVALOR';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID,
                                       isbDATO_ADICIONAL,
                                       TRUE);
    IF NVL(isbVALOR, '-') <> NVL(rcRegistroAct.VALOR, '-') THEN
      UPDATE INFO_ADICIONAL_SOLICITUD
         SET VALOR = isbVALOR
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
  END prAcVALOR;

  -- Actualiza por RowId el valor de la columna VALOR
  PROCEDURE prAcVALOR_RId(iRowId     ROWID,
                          isbVALOR_O VARCHAR2,
                          isbVALOR_N VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcVALOR_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(isbVALOR_O, '-') <> NVL(isbVALOR_N, '-') THEN
      UPDATE INFO_ADICIONAL_SOLICITUD
         SET VALOR = isbVALOR_N
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
  END prAcVALOR_RId;

  -- Actualiza las columnas con valor diferente al anterior
  PROCEDURE prActRegistro(ircRegistro cuINFO_ADICIONAL_SOLICITUD%ROWTYPE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prActRegistro';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(ircRegistro.PACKAGE_ID,
                                       ircRegistro.DATO_ADICIONAL,
                                       TRUE);
    IF rcRegistroAct.RowId IS NOT NULL THEN
      prAcVALOR_RId(rcRegistroAct.RowId,
                    rcRegistroAct.VALOR,
                    ircRegistro.VALOR);
    
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

END pkg_INFO_ADICIONAL_SOLICITUD;
/
BEGIN
  -- OSF-3742
  pkg_Utilidades.prAplicarPermisos(UPPER('pkg_INFO_ADICIONAL_SOLICITUD'),
                                   UPPER('personalizaciones'));
END;
/
