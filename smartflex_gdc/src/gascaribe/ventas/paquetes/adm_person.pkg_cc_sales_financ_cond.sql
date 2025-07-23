CREATE OR REPLACE PACKAGE adm_person.pkg_CC_SALES_FINANC_COND AS
  TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
  TYPE tytbRegistros IS TABLE OF CC_SALES_FINANC_COND%ROWTYPE INDEX BY BINARY_INTEGER;
  CURSOR cuCC_SALES_FINANC_COND IS
    SELECT * FROM CC_SALES_FINANC_COND;
  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe y Efigas
      Autor : jorge valiente
      Descr : Paquete manejo datos relacionados a la entidad CC_SALES_FINANC_COND
      Tabla : CC_SALES_FINANC_COND
      Caso  : OSF-3838
      Fecha : 10/01/2025 10:37:07
  ***************************************************************************/
  CURSOR cuRegistroRId(inuPACKAGE_ID NUMBER) IS
    SELECT tb.*, tb.Rowid
      FROM CC_SALES_FINANC_COND tb
     WHERE PACKAGE_ID = inuPACKAGE_ID;

  CURSOR cuRegistroRIdLock(inuPACKAGE_ID NUMBER) IS
    SELECT tb.*, tb.Rowid
      FROM CC_SALES_FINANC_COND tb
     WHERE PACKAGE_ID = inuPACKAGE_ID
       FOR UPDATE NOWAIT;

  -- Obtiene el registro y el rowid
  FUNCTION frcObtRegistroRId(inuPACKAGE_ID NUMBER,
                             iblBloquea    BOOLEAN DEFAULT FALSE)
    RETURN cuRegistroRId%ROWTYPE;

  -- Retorna verdadero si existe el registro
  FUNCTION fblExiste(inuPACKAGE_ID NUMBER) RETURN BOOLEAN;

  -- Levanta excepción si el registro NO existe
  PROCEDURE prValExiste(inuPACKAGE_ID NUMBER);

  -- Inserta un registro
  PROCEDURE prinsRegistro(ircRegistro cuCC_SALES_FINANC_COND%ROWTYPE);

  -- Borra un registro
  PROCEDURE prBorRegistro(inuPACKAGE_ID NUMBER);

  -- Borra un registro por RowId
  PROCEDURE prBorRegistroxRowId(iRowId ROWID);

  -- Obtiene el valor de la columna FINANCING_PLAN_ID
  FUNCTION fnuObtFINANCING_PLAN_ID(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.FINANCING_PLAN_ID%TYPE;

  -- Obtiene el valor de la columna COMPUTE_METHOD_ID
  FUNCTION fnuObtCOMPUTE_METHOD_ID(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.COMPUTE_METHOD_ID%TYPE;

  -- Obtiene el valor de la columna INTEREST_RATE_ID
  FUNCTION fnuObtINTEREST_RATE_ID(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.INTEREST_RATE_ID%TYPE;

  -- Obtiene el valor de la columna FIRST_PAY_DATE
  FUNCTION fdtObtFIRST_PAY_DATE(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.FIRST_PAY_DATE%TYPE;

  -- Obtiene el valor de la columna PERCENT_TO_FINANCE
  FUNCTION fnuObtPERCENT_TO_FINANCE(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.PERCENT_TO_FINANCE%TYPE;

  -- Obtiene el valor de la columna INTEREST_PERCENT
  FUNCTION fnuObtINTEREST_PERCENT(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.INTEREST_PERCENT%TYPE;

  -- Obtiene el valor de la columna SPREAD
  FUNCTION fnuObtSPREAD(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.SPREAD%TYPE;

  -- Obtiene el valor de la columna QUOTAS_NUMBER
  FUNCTION fnuObtQUOTAS_NUMBER(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.QUOTAS_NUMBER%TYPE;

  -- Obtiene el valor de la columna TAX_FINANCING_ONE
  FUNCTION fsbObtTAX_FINANCING_ONE(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.TAX_FINANCING_ONE%TYPE;

  -- Obtiene el valor de la columna VALUE_TO_FINANCE
  FUNCTION fnuObtVALUE_TO_FINANCE(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.VALUE_TO_FINANCE%TYPE;

  -- Obtiene el valor de la columna DOCUMENT_SUPPORT
  FUNCTION fsbObtDOCUMENT_SUPPORT(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.DOCUMENT_SUPPORT%TYPE;

  -- Obtiene el valor de la columna INITIAL_PAYMENT
  FUNCTION fnuObtINITIAL_PAYMENT(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.INITIAL_PAYMENT%TYPE;

  -- Obtiene el valor de la columna AVERAGE_QUOTE_VALUE
  FUNCTION fnuObtAVERAGE_QUOTE_VALUE(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.AVERAGE_QUOTE_VALUE%TYPE;

  -- Obtiene el valor de la columna FINAN_ID
  FUNCTION fnuObtFINAN_ID(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.FINAN_ID%TYPE;

  -- Actualiza el valor de la columna FINANCING_PLAN_ID
  PROCEDURE prAcFINANCING_PLAN_ID(inuPACKAGE_ID        NUMBER,
                                  inuFINANCING_PLAN_ID NUMBER);

  -- Actualiza el valor de la columna COMPUTE_METHOD_ID
  PROCEDURE prAcCOMPUTE_METHOD_ID(inuPACKAGE_ID        NUMBER,
                                  inuCOMPUTE_METHOD_ID NUMBER);

  -- Actualiza el valor de la columna INTEREST_RATE_ID
  PROCEDURE prAcINTEREST_RATE_ID(inuPACKAGE_ID       NUMBER,
                                 inuINTEREST_RATE_ID NUMBER);

  -- Actualiza el valor de la columna FIRST_PAY_DATE
  PROCEDURE prAcFIRST_PAY_DATE(inuPACKAGE_ID     NUMBER,
                               idtFIRST_PAY_DATE DATE);

  -- Actualiza el valor de la columna PERCENT_TO_FINANCE
  PROCEDURE prAcPERCENT_TO_FINANCE(inuPACKAGE_ID         NUMBER,
                                   inuPERCENT_TO_FINANCE NUMBER);

  -- Actualiza el valor de la columna INTEREST_PERCENT
  PROCEDURE prAcINTEREST_PERCENT(inuPACKAGE_ID       NUMBER,
                                 inuINTEREST_PERCENT NUMBER);

  -- Actualiza el valor de la columna SPREAD
  PROCEDURE prAcSPREAD(inuPACKAGE_ID NUMBER, inuSPREAD NUMBER);

  -- Actualiza el valor de la columna QUOTAS_NUMBER
  PROCEDURE prAcQUOTAS_NUMBER(inuPACKAGE_ID    NUMBER,
                              inuQUOTAS_NUMBER NUMBER);

  -- Actualiza el valor de la columna TAX_FINANCING_ONE
  PROCEDURE prAcTAX_FINANCING_ONE(inuPACKAGE_ID        NUMBER,
                                  isbTAX_FINANCING_ONE VARCHAR2);

  -- Actualiza el valor de la columna VALUE_TO_FINANCE
  PROCEDURE prAcVALUE_TO_FINANCE(inuPACKAGE_ID       NUMBER,
                                 inuVALUE_TO_FINANCE NUMBER);

  -- Actualiza el valor de la columna DOCUMENT_SUPPORT
  PROCEDURE prAcDOCUMENT_SUPPORT(inuPACKAGE_ID       NUMBER,
                                 isbDOCUMENT_SUPPORT VARCHAR2);

  -- Actualiza el valor de la columna INITIAL_PAYMENT
  PROCEDURE prAcINITIAL_PAYMENT(inuPACKAGE_ID      NUMBER,
                                inuINITIAL_PAYMENT NUMBER);

  -- Actualiza el valor de la columna AVERAGE_QUOTE_VALUE
  PROCEDURE prAcAVERAGE_QUOTE_VALUE(inuPACKAGE_ID          NUMBER,
                                    inuAVERAGE_QUOTE_VALUE NUMBER);

  -- Actualiza el valor de la columna FINAN_ID
  PROCEDURE prAcFINAN_ID(inuPACKAGE_ID NUMBER, inuFINAN_ID NUMBER);

  -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
  PROCEDURE prActRegistro(ircRegistro cuCC_SALES_FINANC_COND%ROWTYPE);

END pkg_CC_SALES_FINANC_COND;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_CC_SALES_FINANC_COND AS
  csbSP_NAME    CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;
  -- Obtiene registro y RowId
  FUNCTION frcObtRegistroRId(inuPACKAGE_ID NUMBER,
                             iblBloquea    BOOLEAN DEFAULT FALSE)
    RETURN cuRegistroRId%ROWTYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'frcObtRegistroRId';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroRId cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF iblBloquea THEN
      OPEN cuRegistroRIdLock(inuPACKAGE_ID);
      FETCH cuRegistroRIdLock
        INTO rcRegistroRId;
      CLOSE cuRegistroRIdLock;
    ELSE
      OPEN cuRegistroRId(inuPACKAGE_ID);
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
  FUNCTION fblExiste(inuPACKAGE_ID NUMBER) RETURN BOOLEAN IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblExiste';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroRId cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroRId := frcObtRegistroRId(inuPACKAGE_ID);
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
  PROCEDURE prValExiste(inuPACKAGE_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prValExiste';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NOT fblExiste(inuPACKAGE_ID) THEN
      pkg_error.setErrorMessage(isbMsgErrr => 'No existe el registro [' ||
                                              inuPACKAGE_ID ||
                                              '] en la tabla[CC_SALES_FINANC_COND]');
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
  PROCEDURE prInsRegistro(ircRegistro cuCC_SALES_FINANC_COND%ROWTYPE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsRegistro';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    INSERT INTO CC_SALES_FINANC_COND
      (PACKAGE_ID,
       FINANCING_PLAN_ID,
       COMPUTE_METHOD_ID,
       INTEREST_RATE_ID,
       FIRST_PAY_DATE,
       PERCENT_TO_FINANCE,
       INTEREST_PERCENT,
       SPREAD,
       QUOTAS_NUMBER,
       TAX_FINANCING_ONE,
       VALUE_TO_FINANCE,
       DOCUMENT_SUPPORT,
       INITIAL_PAYMENT,
       AVERAGE_QUOTE_VALUE,
       FINAN_ID)
    VALUES
      (ircRegistro.PACKAGE_ID,
       ircRegistro.FINANCING_PLAN_ID,
       ircRegistro.COMPUTE_METHOD_ID,
       ircRegistro.INTEREST_RATE_ID,
       ircRegistro.FIRST_PAY_DATE,
       ircRegistro.PERCENT_TO_FINANCE,
       ircRegistro.INTEREST_PERCENT,
       ircRegistro.SPREAD,
       ircRegistro.QUOTAS_NUMBER,
       ircRegistro.TAX_FINANCING_ONE,
       ircRegistro.VALUE_TO_FINANCE,
       ircRegistro.DOCUMENT_SUPPORT,
       ircRegistro.INITIAL_PAYMENT,
       ircRegistro.AVERAGE_QUOTE_VALUE,
       ircRegistro.FINAN_ID);
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
  PROCEDURE prBorRegistro(inuPACKAGE_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prBorRegistro';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID, TRUE);
    IF rcRegistroAct.RowId IS NOT NULL THEN
      DELETE CC_SALES_FINANC_COND WHERE ROWID = rcRegistroAct.RowId;
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
      DELETE CC_SALES_FINANC_COND WHERE RowId = iRowId;
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

  -- Obtiene el valor de la columna FINANCING_PLAN_ID
  FUNCTION fnuObtFINANCING_PLAN_ID(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.FINANCING_PLAN_ID%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtFINANCING_PLAN_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.FINANCING_PLAN_ID;
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
  END fnuObtFINANCING_PLAN_ID;

  -- Obtiene el valor de la columna COMPUTE_METHOD_ID
  FUNCTION fnuObtCOMPUTE_METHOD_ID(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.COMPUTE_METHOD_ID%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtCOMPUTE_METHOD_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.COMPUTE_METHOD_ID;
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
  END fnuObtCOMPUTE_METHOD_ID;

  -- Obtiene el valor de la columna INTEREST_RATE_ID
  FUNCTION fnuObtINTEREST_RATE_ID(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.INTEREST_RATE_ID%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtINTEREST_RATE_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.INTEREST_RATE_ID;
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
  END fnuObtINTEREST_RATE_ID;

  -- Obtiene el valor de la columna FIRST_PAY_DATE
  FUNCTION fdtObtFIRST_PAY_DATE(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.FIRST_PAY_DATE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fdtObtFIRST_PAY_DATE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.FIRST_PAY_DATE;
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
  END fdtObtFIRST_PAY_DATE;

  -- Obtiene el valor de la columna PERCENT_TO_FINANCE
  FUNCTION fnuObtPERCENT_TO_FINANCE(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.PERCENT_TO_FINANCE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtPERCENT_TO_FINANCE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PERCENT_TO_FINANCE;
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
  END fnuObtPERCENT_TO_FINANCE;

  -- Obtiene el valor de la columna INTEREST_PERCENT
  FUNCTION fnuObtINTEREST_PERCENT(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.INTEREST_PERCENT%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtINTEREST_PERCENT';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.INTEREST_PERCENT;
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
  END fnuObtINTEREST_PERCENT;

  -- Obtiene el valor de la columna SPREAD
  FUNCTION fnuObtSPREAD(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.SPREAD%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtSPREAD';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.SPREAD;
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
  END fnuObtSPREAD;

  -- Obtiene el valor de la columna QUOTAS_NUMBER
  FUNCTION fnuObtQUOTAS_NUMBER(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.QUOTAS_NUMBER%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtQUOTAS_NUMBER';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.QUOTAS_NUMBER;
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
  END fnuObtQUOTAS_NUMBER;

  -- Obtiene el valor de la columna TAX_FINANCING_ONE
  FUNCTION fsbObtTAX_FINANCING_ONE(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.TAX_FINANCING_ONE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fsbObtTAX_FINANCING_ONE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.TAX_FINANCING_ONE;
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
  END fsbObtTAX_FINANCING_ONE;

  -- Obtiene el valor de la columna VALUE_TO_FINANCE
  FUNCTION fnuObtVALUE_TO_FINANCE(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.VALUE_TO_FINANCE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtVALUE_TO_FINANCE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.VALUE_TO_FINANCE;
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
  END fnuObtVALUE_TO_FINANCE;

  -- Obtiene el valor de la columna DOCUMENT_SUPPORT
  FUNCTION fsbObtDOCUMENT_SUPPORT(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.DOCUMENT_SUPPORT%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fsbObtDOCUMENT_SUPPORT';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.DOCUMENT_SUPPORT;
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
  END fsbObtDOCUMENT_SUPPORT;

  -- Obtiene el valor de la columna INITIAL_PAYMENT
  FUNCTION fnuObtINITIAL_PAYMENT(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.INITIAL_PAYMENT%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtINITIAL_PAYMENT';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.INITIAL_PAYMENT;
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
  END fnuObtINITIAL_PAYMENT;

  -- Obtiene el valor de la columna AVERAGE_QUOTE_VALUE
  FUNCTION fnuObtAVERAGE_QUOTE_VALUE(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.AVERAGE_QUOTE_VALUE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtAVERAGE_QUOTE_VALUE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.AVERAGE_QUOTE_VALUE;
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
  END fnuObtAVERAGE_QUOTE_VALUE;

  -- Obtiene el valor de la columna FINAN_ID
  FUNCTION fnuObtFINAN_ID(inuPACKAGE_ID NUMBER)
    RETURN CC_SALES_FINANC_COND.FINAN_ID%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtFINAN_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.FINAN_ID;
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
  END fnuObtFINAN_ID;

  -- Actualiza el valor de la columna FINANCING_PLAN_ID
  PROCEDURE prAcFINANCING_PLAN_ID(inuPACKAGE_ID        NUMBER,
                                  inuFINANCING_PLAN_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcFINANCING_PLAN_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID, TRUE);
    IF NVL(inuFINANCING_PLAN_ID, -1) <>
       NVL(rcRegistroAct.FINANCING_PLAN_ID, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET FINANCING_PLAN_ID = inuFINANCING_PLAN_ID
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
  END prAcFINANCING_PLAN_ID;

  -- Actualiza el valor de la columna COMPUTE_METHOD_ID
  PROCEDURE prAcCOMPUTE_METHOD_ID(inuPACKAGE_ID        NUMBER,
                                  inuCOMPUTE_METHOD_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcCOMPUTE_METHOD_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID, TRUE);
    IF NVL(inuCOMPUTE_METHOD_ID, -1) <>
       NVL(rcRegistroAct.COMPUTE_METHOD_ID, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET COMPUTE_METHOD_ID = inuCOMPUTE_METHOD_ID
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
  END prAcCOMPUTE_METHOD_ID;

  -- Actualiza el valor de la columna INTEREST_RATE_ID
  PROCEDURE prAcINTEREST_RATE_ID(inuPACKAGE_ID       NUMBER,
                                 inuINTEREST_RATE_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcINTEREST_RATE_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID, TRUE);
    IF NVL(inuINTEREST_RATE_ID, -1) <>
       NVL(rcRegistroAct.INTEREST_RATE_ID, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET INTEREST_RATE_ID = inuINTEREST_RATE_ID
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
  END prAcINTEREST_RATE_ID;

  -- Actualiza el valor de la columna FIRST_PAY_DATE
  PROCEDURE prAcFIRST_PAY_DATE(inuPACKAGE_ID     NUMBER,
                               idtFIRST_PAY_DATE DATE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcFIRST_PAY_DATE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID, TRUE);
    IF NVL(idtFIRST_PAY_DATE, TO_DATE('01/01/1900', 'dd/mm/yyyy')) <>
       NVL(rcRegistroAct.FIRST_PAY_DATE,
           TO_DATE('01/01/1900', 'dd/mm/yyyy')) THEN
      UPDATE CC_SALES_FINANC_COND
         SET FIRST_PAY_DATE = idtFIRST_PAY_DATE
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
  END prAcFIRST_PAY_DATE;

  -- Actualiza el valor de la columna PERCENT_TO_FINANCE
  PROCEDURE prAcPERCENT_TO_FINANCE(inuPACKAGE_ID         NUMBER,
                                   inuPERCENT_TO_FINANCE NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcPERCENT_TO_FINANCE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID, TRUE);
    IF NVL(inuPERCENT_TO_FINANCE, -1) <>
       NVL(rcRegistroAct.PERCENT_TO_FINANCE, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET PERCENT_TO_FINANCE = inuPERCENT_TO_FINANCE
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
  END prAcPERCENT_TO_FINANCE;

  -- Actualiza el valor de la columna INTEREST_PERCENT
  PROCEDURE prAcINTEREST_PERCENT(inuPACKAGE_ID       NUMBER,
                                 inuINTEREST_PERCENT NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcINTEREST_PERCENT';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID, TRUE);
    IF NVL(inuINTEREST_PERCENT, -1) <>
       NVL(rcRegistroAct.INTEREST_PERCENT, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET INTEREST_PERCENT = inuINTEREST_PERCENT
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
  END prAcINTEREST_PERCENT;

  -- Actualiza el valor de la columna SPREAD
  PROCEDURE prAcSPREAD(inuPACKAGE_ID NUMBER, inuSPREAD NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcSPREAD';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID, TRUE);
    IF NVL(inuSPREAD, -1) <> NVL(rcRegistroAct.SPREAD, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET SPREAD = inuSPREAD
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
  END prAcSPREAD;

  -- Actualiza el valor de la columna QUOTAS_NUMBER
  PROCEDURE prAcQUOTAS_NUMBER(inuPACKAGE_ID    NUMBER,
                              inuQUOTAS_NUMBER NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcQUOTAS_NUMBER';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID, TRUE);
    IF NVL(inuQUOTAS_NUMBER, -1) <> NVL(rcRegistroAct.QUOTAS_NUMBER, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET QUOTAS_NUMBER = inuQUOTAS_NUMBER
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
  END prAcQUOTAS_NUMBER;

  -- Actualiza el valor de la columna TAX_FINANCING_ONE
  PROCEDURE prAcTAX_FINANCING_ONE(inuPACKAGE_ID        NUMBER,
                                  isbTAX_FINANCING_ONE VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcTAX_FINANCING_ONE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID, TRUE);
    IF NVL(isbTAX_FINANCING_ONE, '-') <>
       NVL(rcRegistroAct.TAX_FINANCING_ONE, '-') THEN
      UPDATE CC_SALES_FINANC_COND
         SET TAX_FINANCING_ONE = isbTAX_FINANCING_ONE
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
  END prAcTAX_FINANCING_ONE;

  -- Actualiza el valor de la columna VALUE_TO_FINANCE
  PROCEDURE prAcVALUE_TO_FINANCE(inuPACKAGE_ID       NUMBER,
                                 inuVALUE_TO_FINANCE NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcVALUE_TO_FINANCE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID, TRUE);
    IF NVL(inuVALUE_TO_FINANCE, -1) <>
       NVL(rcRegistroAct.VALUE_TO_FINANCE, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET VALUE_TO_FINANCE = inuVALUE_TO_FINANCE
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
  END prAcVALUE_TO_FINANCE;

  -- Actualiza el valor de la columna DOCUMENT_SUPPORT
  PROCEDURE prAcDOCUMENT_SUPPORT(inuPACKAGE_ID       NUMBER,
                                 isbDOCUMENT_SUPPORT VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcDOCUMENT_SUPPORT';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID, TRUE);
    IF NVL(isbDOCUMENT_SUPPORT, '-') <>
       NVL(rcRegistroAct.DOCUMENT_SUPPORT, '-') THEN
      UPDATE CC_SALES_FINANC_COND
         SET DOCUMENT_SUPPORT = isbDOCUMENT_SUPPORT
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
  END prAcDOCUMENT_SUPPORT;

  -- Actualiza el valor de la columna INITIAL_PAYMENT
  PROCEDURE prAcINITIAL_PAYMENT(inuPACKAGE_ID      NUMBER,
                                inuINITIAL_PAYMENT NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcINITIAL_PAYMENT';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID, TRUE);
    IF NVL(inuINITIAL_PAYMENT, -1) <>
       NVL(rcRegistroAct.INITIAL_PAYMENT, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET INITIAL_PAYMENT = inuINITIAL_PAYMENT
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
  END prAcINITIAL_PAYMENT;

  -- Actualiza el valor de la columna AVERAGE_QUOTE_VALUE
  PROCEDURE prAcAVERAGE_QUOTE_VALUE(inuPACKAGE_ID          NUMBER,
                                    inuAVERAGE_QUOTE_VALUE NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcAVERAGE_QUOTE_VALUE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID, TRUE);
    IF NVL(inuAVERAGE_QUOTE_VALUE, -1) <>
       NVL(rcRegistroAct.AVERAGE_QUOTE_VALUE, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET AVERAGE_QUOTE_VALUE = inuAVERAGE_QUOTE_VALUE
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
  END prAcAVERAGE_QUOTE_VALUE;

  -- Actualiza el valor de la columna FINAN_ID
  PROCEDURE prAcFINAN_ID(inuPACKAGE_ID NUMBER, inuFINAN_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcFINAN_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPACKAGE_ID, TRUE);
    IF NVL(inuFINAN_ID, -1) <> NVL(rcRegistroAct.FINAN_ID, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET FINAN_ID = inuFINAN_ID
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
  END prAcFINAN_ID;

  -- Actualiza por RowId el valor de la columna FINANCING_PLAN_ID
  PROCEDURE prAcFINANCING_PLAN_ID_RId(iRowId                 ROWID,
                                      inuFINANCING_PLAN_ID_O NUMBER,
                                      inuFINANCING_PLAN_ID_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcFINANCING_PLAN_ID_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuFINANCING_PLAN_ID_O, -1) <> NVL(inuFINANCING_PLAN_ID_N, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET FINANCING_PLAN_ID = inuFINANCING_PLAN_ID_N
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
  END prAcFINANCING_PLAN_ID_RId;

  -- Actualiza por RowId el valor de la columna COMPUTE_METHOD_ID
  PROCEDURE prAcCOMPUTE_METHOD_ID_RId(iRowId                 ROWID,
                                      inuCOMPUTE_METHOD_ID_O NUMBER,
                                      inuCOMPUTE_METHOD_ID_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcCOMPUTE_METHOD_ID_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuCOMPUTE_METHOD_ID_O, -1) <> NVL(inuCOMPUTE_METHOD_ID_N, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET COMPUTE_METHOD_ID = inuCOMPUTE_METHOD_ID_N
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
  END prAcCOMPUTE_METHOD_ID_RId;

  -- Actualiza por RowId el valor de la columna INTEREST_RATE_ID
  PROCEDURE prAcINTEREST_RATE_ID_RId(iRowId                ROWID,
                                     inuINTEREST_RATE_ID_O NUMBER,
                                     inuINTEREST_RATE_ID_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcINTEREST_RATE_ID_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuINTEREST_RATE_ID_O, -1) <> NVL(inuINTEREST_RATE_ID_N, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET INTEREST_RATE_ID = inuINTEREST_RATE_ID_N
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
  END prAcINTEREST_RATE_ID_RId;

  -- Actualiza por RowId el valor de la columna FIRST_PAY_DATE
  PROCEDURE prAcFIRST_PAY_DATE_RId(iRowId              ROWID,
                                   idtFIRST_PAY_DATE_O DATE,
                                   idtFIRST_PAY_DATE_N DATE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcFIRST_PAY_DATE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(idtFIRST_PAY_DATE_O, TO_DATE('01/01/1900', 'dd/mm/yyyy')) <>
       NVL(idtFIRST_PAY_DATE_N, TO_DATE('01/01/1900', 'dd/mm/yyyy')) THEN
      UPDATE CC_SALES_FINANC_COND
         SET FIRST_PAY_DATE = idtFIRST_PAY_DATE_N
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
  END prAcFIRST_PAY_DATE_RId;

  -- Actualiza por RowId el valor de la columna PERCENT_TO_FINANCE
  PROCEDURE prAcPERCENT_TO_FINANCE_RId(iRowId                  ROWID,
                                       inuPERCENT_TO_FINANCE_O NUMBER,
                                       inuPERCENT_TO_FINANCE_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcPERCENT_TO_FINANCE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPERCENT_TO_FINANCE_O, -1) <> NVL(inuPERCENT_TO_FINANCE_N, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET PERCENT_TO_FINANCE = inuPERCENT_TO_FINANCE_N
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
  END prAcPERCENT_TO_FINANCE_RId;

  -- Actualiza por RowId el valor de la columna INTEREST_PERCENT
  PROCEDURE prAcINTEREST_PERCENT_RId(iRowId                ROWID,
                                     inuINTEREST_PERCENT_O NUMBER,
                                     inuINTEREST_PERCENT_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcINTEREST_PERCENT_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuINTEREST_PERCENT_O, -1) <> NVL(inuINTEREST_PERCENT_N, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET INTEREST_PERCENT = inuINTEREST_PERCENT_N
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
  END prAcINTEREST_PERCENT_RId;

  -- Actualiza por RowId el valor de la columna SPREAD
  PROCEDURE prAcSPREAD_RId(iRowId      ROWID,
                           inuSPREAD_O NUMBER,
                           inuSPREAD_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcSPREAD_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuSPREAD_O, -1) <> NVL(inuSPREAD_N, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET SPREAD = inuSPREAD_N
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
  END prAcSPREAD_RId;

  -- Actualiza por RowId el valor de la columna QUOTAS_NUMBER
  PROCEDURE prAcQUOTAS_NUMBER_RId(iRowId             ROWID,
                                  inuQUOTAS_NUMBER_O NUMBER,
                                  inuQUOTAS_NUMBER_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcQUOTAS_NUMBER_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuQUOTAS_NUMBER_O, -1) <> NVL(inuQUOTAS_NUMBER_N, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET QUOTAS_NUMBER = inuQUOTAS_NUMBER_N
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
  END prAcQUOTAS_NUMBER_RId;

  -- Actualiza por RowId el valor de la columna TAX_FINANCING_ONE
  PROCEDURE prAcTAX_FINANCING_ONE_RId(iRowId                 ROWID,
                                      isbTAX_FINANCING_ONE_O VARCHAR2,
                                      isbTAX_FINANCING_ONE_N VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcTAX_FINANCING_ONE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(isbTAX_FINANCING_ONE_O, '-') <> NVL(isbTAX_FINANCING_ONE_N, '-') THEN
      UPDATE CC_SALES_FINANC_COND
         SET TAX_FINANCING_ONE = isbTAX_FINANCING_ONE_N
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
  END prAcTAX_FINANCING_ONE_RId;

  -- Actualiza por RowId el valor de la columna VALUE_TO_FINANCE
  PROCEDURE prAcVALUE_TO_FINANCE_RId(iRowId                ROWID,
                                     inuVALUE_TO_FINANCE_O NUMBER,
                                     inuVALUE_TO_FINANCE_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcVALUE_TO_FINANCE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuVALUE_TO_FINANCE_O, -1) <> NVL(inuVALUE_TO_FINANCE_N, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET VALUE_TO_FINANCE = inuVALUE_TO_FINANCE_N
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
  END prAcVALUE_TO_FINANCE_RId;

  -- Actualiza por RowId el valor de la columna DOCUMENT_SUPPORT
  PROCEDURE prAcDOCUMENT_SUPPORT_RId(iRowId                ROWID,
                                     isbDOCUMENT_SUPPORT_O VARCHAR2,
                                     isbDOCUMENT_SUPPORT_N VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcDOCUMENT_SUPPORT_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(isbDOCUMENT_SUPPORT_O, '-') <> NVL(isbDOCUMENT_SUPPORT_N, '-') THEN
      UPDATE CC_SALES_FINANC_COND
         SET DOCUMENT_SUPPORT = isbDOCUMENT_SUPPORT_N
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
  END prAcDOCUMENT_SUPPORT_RId;

  -- Actualiza por RowId el valor de la columna INITIAL_PAYMENT
  PROCEDURE prAcINITIAL_PAYMENT_RId(iRowId               ROWID,
                                    inuINITIAL_PAYMENT_O NUMBER,
                                    inuINITIAL_PAYMENT_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcINITIAL_PAYMENT_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuINITIAL_PAYMENT_O, -1) <> NVL(inuINITIAL_PAYMENT_N, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET INITIAL_PAYMENT = inuINITIAL_PAYMENT_N
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
  END prAcINITIAL_PAYMENT_RId;

  -- Actualiza por RowId el valor de la columna AVERAGE_QUOTE_VALUE
  PROCEDURE prAcAVERAGE_QUOTE_VALUE_RId(iRowId                   ROWID,
                                        inuAVERAGE_QUOTE_VALUE_O NUMBER,
                                        inuAVERAGE_QUOTE_VALUE_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcAVERAGE_QUOTE_VALUE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuAVERAGE_QUOTE_VALUE_O, -1) <>
       NVL(inuAVERAGE_QUOTE_VALUE_N, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET AVERAGE_QUOTE_VALUE = inuAVERAGE_QUOTE_VALUE_N
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
  END prAcAVERAGE_QUOTE_VALUE_RId;

  -- Actualiza por RowId el valor de la columna FINAN_ID
  PROCEDURE prAcFINAN_ID_RId(iRowId        ROWID,
                             inuFINAN_ID_O NUMBER,
                             inuFINAN_ID_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcFINAN_ID_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuFINAN_ID_O, -1) <> NVL(inuFINAN_ID_N, -1) THEN
      UPDATE CC_SALES_FINANC_COND
         SET FINAN_ID = inuFINAN_ID_N
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
  END prAcFINAN_ID_RId;

  -- Actualiza las columnas con valor diferente al anterior
  PROCEDURE prActRegistro(ircRegistro cuCC_SALES_FINANC_COND%ROWTYPE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prActRegistro';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(ircRegistro.PACKAGE_ID, TRUE);
    IF rcRegistroAct.RowId IS NOT NULL THEN
      prAcFINANCING_PLAN_ID_RId(rcRegistroAct.RowId,
                                rcRegistroAct.FINANCING_PLAN_ID,
                                ircRegistro.FINANCING_PLAN_ID);
    
      prAcCOMPUTE_METHOD_ID_RId(rcRegistroAct.RowId,
                                rcRegistroAct.COMPUTE_METHOD_ID,
                                ircRegistro.COMPUTE_METHOD_ID);
    
      prAcINTEREST_RATE_ID_RId(rcRegistroAct.RowId,
                               rcRegistroAct.INTEREST_RATE_ID,
                               ircRegistro.INTEREST_RATE_ID);
    
      prAcFIRST_PAY_DATE_RId(rcRegistroAct.RowId,
                             rcRegistroAct.FIRST_PAY_DATE,
                             ircRegistro.FIRST_PAY_DATE);
    
      prAcPERCENT_TO_FINANCE_RId(rcRegistroAct.RowId,
                                 rcRegistroAct.PERCENT_TO_FINANCE,
                                 ircRegistro.PERCENT_TO_FINANCE);
    
      prAcINTEREST_PERCENT_RId(rcRegistroAct.RowId,
                               rcRegistroAct.INTEREST_PERCENT,
                               ircRegistro.INTEREST_PERCENT);
    
      prAcSPREAD_RId(rcRegistroAct.RowId,
                     rcRegistroAct.SPREAD,
                     ircRegistro.SPREAD);
    
      prAcQUOTAS_NUMBER_RId(rcRegistroAct.RowId,
                            rcRegistroAct.QUOTAS_NUMBER,
                            ircRegistro.QUOTAS_NUMBER);
    
      prAcTAX_FINANCING_ONE_RId(rcRegistroAct.RowId,
                                rcRegistroAct.TAX_FINANCING_ONE,
                                ircRegistro.TAX_FINANCING_ONE);
    
      prAcVALUE_TO_FINANCE_RId(rcRegistroAct.RowId,
                               rcRegistroAct.VALUE_TO_FINANCE,
                               ircRegistro.VALUE_TO_FINANCE);
    
      prAcDOCUMENT_SUPPORT_RId(rcRegistroAct.RowId,
                               rcRegistroAct.DOCUMENT_SUPPORT,
                               ircRegistro.DOCUMENT_SUPPORT);
    
      prAcINITIAL_PAYMENT_RId(rcRegistroAct.RowId,
                              rcRegistroAct.INITIAL_PAYMENT,
                              ircRegistro.INITIAL_PAYMENT);
    
      prAcAVERAGE_QUOTE_VALUE_RId(rcRegistroAct.RowId,
                                  rcRegistroAct.AVERAGE_QUOTE_VALUE,
                                  ircRegistro.AVERAGE_QUOTE_VALUE);
    
      prAcFINAN_ID_RId(rcRegistroAct.RowId,
                       rcRegistroAct.FINAN_ID,
                       ircRegistro.FINAN_ID);
    
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

END pkg_CC_SALES_FINANC_COND;
/
BEGIN
  pkg_Utilidades.prAplicarPermisos(UPPER('pkg_CC_SALES_FINANC_COND'),
                                   UPPER('adm_person'));
END;
/
