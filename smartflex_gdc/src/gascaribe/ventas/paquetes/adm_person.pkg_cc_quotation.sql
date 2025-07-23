CREATE OR REPLACE PACKAGE adm_person.pkg_CC_QUOTATION AS
  TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
  TYPE tytbRegistros IS TABLE OF CC_QUOTATION%ROWTYPE INDEX BY BINARY_INTEGER;
  CURSOR cuCC_QUOTATION IS
    SELECT * FROM CC_QUOTATION;
  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe y Efigas
      Autor : jorge valiente
      Descr : Paquete manejo datos de la entidad CC_QUOTATION
      Tabla : CC_QUOTATION
      Caso  : OSF-3838
      Fecha : 10/01/2025 10:23:18
  ***************************************************************************/
  CURSOR cuRegistroRId(inuQUOTATION_ID NUMBER) IS
    SELECT tb.*, tb.Rowid
      FROM CC_QUOTATION tb
     WHERE QUOTATION_ID = inuQUOTATION_ID;

  CURSOR cuRegistroRIdLock(inuQUOTATION_ID NUMBER) IS
    SELECT tb.*, tb.Rowid
      FROM CC_QUOTATION tb
     WHERE QUOTATION_ID = inuQUOTATION_ID
       FOR UPDATE NOWAIT;

  -- Obtiene el registro y el rowid
  FUNCTION frcObtRegistroRId(inuQUOTATION_ID NUMBER,
                             iblBloquea      BOOLEAN DEFAULT FALSE)
    RETURN cuRegistroRId%ROWTYPE;

  -- Retorna verdadero si existe el registro
  FUNCTION fblExiste(inuQUOTATION_ID NUMBER) RETURN BOOLEAN;

  -- Levanta excepción si el registro NO existe
  PROCEDURE prValExiste(inuQUOTATION_ID NUMBER);

  -- Inserta un registro
  PROCEDURE prinsRegistro(ircRegistro cuCC_QUOTATION%ROWTYPE);

  -- Borra un registro
  PROCEDURE prBorRegistro(inuQUOTATION_ID NUMBER);

  -- Borra un registro por RowId
  PROCEDURE prBorRegistroxRowId(iRowId ROWID);

  -- Obtiene el valor de la columna DESCRIPTION
  FUNCTION fsbObtDESCRIPTION(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.DESCRIPTION%TYPE;

  -- Obtiene el valor de la columna REGISTER_DATE
  FUNCTION fdtObtREGISTER_DATE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.REGISTER_DATE%TYPE;

  -- Obtiene el valor de la columna STATUS
  FUNCTION fsbObtSTATUS(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.STATUS%TYPE;

  -- Obtiene el valor de la columna SUBSCRIBER_ID
  FUNCTION fnuObtSUBSCRIBER_ID(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.SUBSCRIBER_ID%TYPE;

  -- Obtiene el valor de la columna REGISTER_PERSON_ID
  FUNCTION fnuObtREGISTER_PERSON_ID(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.REGISTER_PERSON_ID%TYPE;

  -- Obtiene el valor de la columna PACKAGE_ID
  FUNCTION fnuObtPACKAGE_ID(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.PACKAGE_ID%TYPE;

  -- Obtiene el valor de la columna END_DATE
  FUNCTION fdtObtEND_DATE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.END_DATE%TYPE;

  -- Obtiene el valor de la columna UPDATE_PERSON_ID
  FUNCTION fnuObtUPDATE_PERSON_ID(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.UPDATE_PERSON_ID%TYPE;

  -- Obtiene el valor de la columna UPDATE_DATE
  FUNCTION fdtObtUPDATE_DATE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.UPDATE_DATE%TYPE;

  -- Obtiene el valor de la columna INITIAL_PAYMENT
  FUNCTION fnuObtINITIAL_PAYMENT(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.INITIAL_PAYMENT%TYPE;

  -- Obtiene el valor de la columna DISCOUNT_PERCENTAGE
  FUNCTION fnuObtDISCOUNT_PERCENTAGE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.DISCOUNT_PERCENTAGE%TYPE;

  -- Obtiene el valor de la columna GENERATED_CHARGES
  FUNCTION fsbObtGENERATED_CHARGES(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.GENERATED_CHARGES%TYPE;

  -- Obtiene el valor de la columna INIT_PAYMENT_MODE
  FUNCTION fsbObtINIT_PAYMENT_MODE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.INIT_PAYMENT_MODE%TYPE;

  -- Obtiene el valor de la columna TOTAL_ITEMS_VALUE
  FUNCTION fnuObtTOTAL_ITEMS_VALUE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.TOTAL_ITEMS_VALUE%TYPE;

  -- Obtiene el valor de la columna TOTAL_DISC_VALUE
  FUNCTION fnuObtTOTAL_DISC_VALUE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.TOTAL_DISC_VALUE%TYPE;

  -- Obtiene el valor de la columna TOTAL_TAX_VALUE
  FUNCTION fnuObtTOTAL_TAX_VALUE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.TOTAL_TAX_VALUE%TYPE;

  -- Obtiene el valor de la columna COMMENT_
  FUNCTION fsbObtCOMMENT_(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.COMMENT_%TYPE;

  -- Obtiene el valor de la columna PAY_MODALITY
  FUNCTION fnuObtPAY_MODALITY(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.PAY_MODALITY%TYPE;

  -- Obtiene el valor de la columna PRODUCT_TYPE_ID
  FUNCTION fnuObtPRODUCT_TYPE_ID(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.PRODUCT_TYPE_ID%TYPE;

  -- Obtiene el valor de la columna NO_QUOT_ITEM_CHARGE
  FUNCTION fsbObtNO_QUOT_ITEM_CHARGE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.NO_QUOT_ITEM_CHARGE%TYPE;

  -- Obtiene el valor de la columna AUI_PERCENTAGE
  FUNCTION fnuObtAUI_PERCENTAGE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.AUI_PERCENTAGE%TYPE;

  -- Obtiene el valor de la columna TOTAL_AIU_VALUE
  FUNCTION fnuObtTOTAL_AIU_VALUE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.TOTAL_AIU_VALUE%TYPE;

  -- Obtiene la cotizacion con la solicitud
  FUNCTION fnuObtCotizacionPorSolicitud(inuSolicitud NUMBER)
    RETURN CC_QUOTATION.QUOTATION_ID%TYPE;

  -- Actualiza el valor de la columna DESCRIPTION
  PROCEDURE prAcDESCRIPTION(inuQUOTATION_ID NUMBER,
                            isbDESCRIPTION  VARCHAR2);

  -- Actualiza el valor de la columna REGISTER_DATE
  PROCEDURE prAcREGISTER_DATE(inuQUOTATION_ID  NUMBER,
                              idtREGISTER_DATE DATE);

  -- Actualiza el valor de la columna STATUS
  PROCEDURE prAcSTATUS(inuQUOTATION_ID NUMBER, isbSTATUS VARCHAR2);

  -- Actualiza el valor de la columna SUBSCRIBER_ID
  PROCEDURE prAcSUBSCRIBER_ID(inuQUOTATION_ID  NUMBER,
                              inuSUBSCRIBER_ID NUMBER);

  -- Actualiza el valor de la columna REGISTER_PERSON_ID
  PROCEDURE prAcREGISTER_PERSON_ID(inuQUOTATION_ID       NUMBER,
                                   inuREGISTER_PERSON_ID NUMBER);

  -- Actualiza el valor de la columna PACKAGE_ID
  PROCEDURE prAcPACKAGE_ID(inuQUOTATION_ID NUMBER, inuPACKAGE_ID NUMBER);

  -- Actualiza el valor de la columna END_DATE
  PROCEDURE prAcEND_DATE(inuQUOTATION_ID NUMBER, idtEND_DATE DATE);

  -- Actualiza el valor de la columna UPDATE_PERSON_ID
  PROCEDURE prAcUPDATE_PERSON_ID(inuQUOTATION_ID     NUMBER,
                                 inuUPDATE_PERSON_ID NUMBER);

  -- Actualiza el valor de la columna UPDATE_DATE
  PROCEDURE prAcUPDATE_DATE(inuQUOTATION_ID NUMBER, idtUPDATE_DATE DATE);

  -- Actualiza el valor de la columna INITIAL_PAYMENT
  PROCEDURE prAcINITIAL_PAYMENT(inuQUOTATION_ID    NUMBER,
                                inuINITIAL_PAYMENT NUMBER);

  -- Actualiza el valor de la columna DISCOUNT_PERCENTAGE
  PROCEDURE prAcDISCOUNT_PERCENTAGE(inuQUOTATION_ID        NUMBER,
                                    inuDISCOUNT_PERCENTAGE NUMBER);

  -- Actualiza el valor de la columna GENERATED_CHARGES
  PROCEDURE prAcGENERATED_CHARGES(inuQUOTATION_ID      NUMBER,
                                  isbGENERATED_CHARGES VARCHAR2);

  -- Actualiza el valor de la columna INIT_PAYMENT_MODE
  PROCEDURE prAcINIT_PAYMENT_MODE(inuQUOTATION_ID      NUMBER,
                                  isbINIT_PAYMENT_MODE VARCHAR2);

  -- Actualiza el valor de la columna TOTAL_ITEMS_VALUE
  PROCEDURE prAcTOTAL_ITEMS_VALUE(inuQUOTATION_ID      NUMBER,
                                  inuTOTAL_ITEMS_VALUE NUMBER);

  -- Actualiza el valor de la columna TOTAL_DISC_VALUE
  PROCEDURE prAcTOTAL_DISC_VALUE(inuQUOTATION_ID     NUMBER,
                                 inuTOTAL_DISC_VALUE NUMBER);

  -- Actualiza el valor de la columna TOTAL_TAX_VALUE
  PROCEDURE prAcTOTAL_TAX_VALUE(inuQUOTATION_ID    NUMBER,
                                inuTOTAL_TAX_VALUE NUMBER);

  -- Actualiza el valor de la columna COMMENT_
  PROCEDURE prAcCOMMENT_(inuQUOTATION_ID NUMBER, isbCOMMENT_ VARCHAR2);

  -- Actualiza el valor de la columna PAY_MODALITY
  PROCEDURE prAcPAY_MODALITY(inuQUOTATION_ID NUMBER,
                             inuPAY_MODALITY NUMBER);

  -- Actualiza el valor de la columna PRODUCT_TYPE_ID
  PROCEDURE prAcPRODUCT_TYPE_ID(inuQUOTATION_ID    NUMBER,
                                inuPRODUCT_TYPE_ID NUMBER);

  -- Actualiza el valor de la columna NO_QUOT_ITEM_CHARGE
  PROCEDURE prAcNO_QUOT_ITEM_CHARGE(inuQUOTATION_ID        NUMBER,
                                    isbNO_QUOT_ITEM_CHARGE VARCHAR2);

  -- Actualiza el valor de la columna AUI_PERCENTAGE
  PROCEDURE prAcAUI_PERCENTAGE(inuQUOTATION_ID   NUMBER,
                               inuAUI_PERCENTAGE NUMBER);

  -- Actualiza el valor de la columna TOTAL_AIU_VALUE
  PROCEDURE prAcTOTAL_AIU_VALUE(inuQUOTATION_ID    NUMBER,
                                inuTOTAL_AIU_VALUE NUMBER);

  -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
  PROCEDURE prActRegistro(ircRegistro cuCC_QUOTATION%ROWTYPE);

END pkg_CC_QUOTATION;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_CC_QUOTATION AS
  csbSP_NAME    CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;
  -- Obtiene registro y RowId
  FUNCTION frcObtRegistroRId(inuQUOTATION_ID NUMBER,
                             iblBloquea      BOOLEAN DEFAULT FALSE)
    RETURN cuRegistroRId%ROWTYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'frcObtRegistroRId';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroRId cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF iblBloquea THEN
      OPEN cuRegistroRIdLock(inuQUOTATION_ID);
      FETCH cuRegistroRIdLock
        INTO rcRegistroRId;
      CLOSE cuRegistroRIdLock;
    ELSE
      OPEN cuRegistroRId(inuQUOTATION_ID);
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
  FUNCTION fblExiste(inuQUOTATION_ID NUMBER) RETURN BOOLEAN IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblExiste';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroRId cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroRId := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroRId.QUOTATION_ID IS NOT NULL;
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
  PROCEDURE prValExiste(inuQUOTATION_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prValExiste';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NOT fblExiste(inuQUOTATION_ID) THEN
      pkg_error.setErrorMessage(isbMsgErrr => 'No existe el registro [' ||
                                              inuQUOTATION_ID ||
                                              '] en la tabla[CC_QUOTATION]');
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
  PROCEDURE prInsRegistro(ircRegistro cuCC_QUOTATION%ROWTYPE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsRegistro';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    INSERT INTO CC_QUOTATION
      (QUOTATION_ID,
       DESCRIPTION,
       REGISTER_DATE,
       STATUS,
       SUBSCRIBER_ID,
       REGISTER_PERSON_ID,
       PACKAGE_ID,
       END_DATE,
       UPDATE_PERSON_ID,
       UPDATE_DATE,
       INITIAL_PAYMENT,
       DISCOUNT_PERCENTAGE,
       GENERATED_CHARGES,
       INIT_PAYMENT_MODE,
       TOTAL_ITEMS_VALUE,
       TOTAL_DISC_VALUE,
       TOTAL_TAX_VALUE,
       COMMENT_,
       PAY_MODALITY,
       PRODUCT_TYPE_ID,
       NO_QUOT_ITEM_CHARGE,
       AUI_PERCENTAGE,
       TOTAL_AIU_VALUE)
    VALUES
      (ircRegistro.QUOTATION_ID,
       ircRegistro.DESCRIPTION,
       ircRegistro.REGISTER_DATE,
       ircRegistro.STATUS,
       ircRegistro.SUBSCRIBER_ID,
       ircRegistro.REGISTER_PERSON_ID,
       ircRegistro.PACKAGE_ID,
       ircRegistro.END_DATE,
       ircRegistro.UPDATE_PERSON_ID,
       ircRegistro.UPDATE_DATE,
       ircRegistro.INITIAL_PAYMENT,
       ircRegistro.DISCOUNT_PERCENTAGE,
       ircRegistro.GENERATED_CHARGES,
       ircRegistro.INIT_PAYMENT_MODE,
       ircRegistro.TOTAL_ITEMS_VALUE,
       ircRegistro.TOTAL_DISC_VALUE,
       ircRegistro.TOTAL_TAX_VALUE,
       ircRegistro.COMMENT_,
       ircRegistro.PAY_MODALITY,
       ircRegistro.PRODUCT_TYPE_ID,
       ircRegistro.NO_QUOT_ITEM_CHARGE,
       ircRegistro.AUI_PERCENTAGE,
       ircRegistro.TOTAL_AIU_VALUE);
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
  PROCEDURE prBorRegistro(inuQUOTATION_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prBorRegistro';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF rcRegistroAct.RowId IS NOT NULL THEN
      DELETE CC_QUOTATION WHERE ROWID = rcRegistroAct.RowId;
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
      DELETE CC_QUOTATION WHERE RowId = iRowId;
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

  -- Obtiene el valor de la columna DESCRIPTION
  FUNCTION fsbObtDESCRIPTION(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.DESCRIPTION%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtDESCRIPTION';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.DESCRIPTION;
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
  END fsbObtDESCRIPTION;

  -- Obtiene el valor de la columna REGISTER_DATE
  FUNCTION fdtObtREGISTER_DATE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.REGISTER_DATE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fdtObtREGISTER_DATE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.REGISTER_DATE;
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
  END fdtObtREGISTER_DATE;

  -- Obtiene el valor de la columna STATUS
  FUNCTION fsbObtSTATUS(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.STATUS%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtSTATUS';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.STATUS;
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
  END fsbObtSTATUS;

  -- Obtiene el valor de la columna SUBSCRIBER_ID
  FUNCTION fnuObtSUBSCRIBER_ID(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.SUBSCRIBER_ID%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtSUBSCRIBER_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.SUBSCRIBER_ID;
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
  END fnuObtSUBSCRIBER_ID;

  -- Obtiene el valor de la columna REGISTER_PERSON_ID
  FUNCTION fnuObtREGISTER_PERSON_ID(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.REGISTER_PERSON_ID%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtREGISTER_PERSON_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.REGISTER_PERSON_ID;
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
  END fnuObtREGISTER_PERSON_ID;

  -- Obtiene el valor de la columna PACKAGE_ID
  FUNCTION fnuObtPACKAGE_ID(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.PACKAGE_ID%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPACKAGE_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PACKAGE_ID;
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
  END fnuObtPACKAGE_ID;

  -- Obtiene el valor de la columna END_DATE
  FUNCTION fdtObtEND_DATE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.END_DATE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fdtObtEND_DATE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.END_DATE;
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
  END fdtObtEND_DATE;

  -- Obtiene el valor de la columna UPDATE_PERSON_ID
  FUNCTION fnuObtUPDATE_PERSON_ID(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.UPDATE_PERSON_ID%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtUPDATE_PERSON_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.UPDATE_PERSON_ID;
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
  END fnuObtUPDATE_PERSON_ID;

  -- Obtiene el valor de la columna UPDATE_DATE
  FUNCTION fdtObtUPDATE_DATE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.UPDATE_DATE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fdtObtUPDATE_DATE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.UPDATE_DATE;
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
  END fdtObtUPDATE_DATE;

  -- Obtiene el valor de la columna INITIAL_PAYMENT
  FUNCTION fnuObtINITIAL_PAYMENT(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.INITIAL_PAYMENT%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtINITIAL_PAYMENT';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
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

  -- Obtiene el valor de la columna DISCOUNT_PERCENTAGE
  FUNCTION fnuObtDISCOUNT_PERCENTAGE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.DISCOUNT_PERCENTAGE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtDISCOUNT_PERCENTAGE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.DISCOUNT_PERCENTAGE;
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
  END fnuObtDISCOUNT_PERCENTAGE;

  -- Obtiene el valor de la columna GENERATED_CHARGES
  FUNCTION fsbObtGENERATED_CHARGES(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.GENERATED_CHARGES%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fsbObtGENERATED_CHARGES';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.GENERATED_CHARGES;
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
  END fsbObtGENERATED_CHARGES;

  -- Obtiene el valor de la columna INIT_PAYMENT_MODE
  FUNCTION fsbObtINIT_PAYMENT_MODE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.INIT_PAYMENT_MODE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fsbObtINIT_PAYMENT_MODE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.INIT_PAYMENT_MODE;
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
  END fsbObtINIT_PAYMENT_MODE;

  -- Obtiene el valor de la columna TOTAL_ITEMS_VALUE
  FUNCTION fnuObtTOTAL_ITEMS_VALUE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.TOTAL_ITEMS_VALUE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtTOTAL_ITEMS_VALUE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.TOTAL_ITEMS_VALUE;
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
  END fnuObtTOTAL_ITEMS_VALUE;

  -- Obtiene el valor de la columna TOTAL_DISC_VALUE
  FUNCTION fnuObtTOTAL_DISC_VALUE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.TOTAL_DISC_VALUE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtTOTAL_DISC_VALUE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.TOTAL_DISC_VALUE;
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
  END fnuObtTOTAL_DISC_VALUE;

  -- Obtiene el valor de la columna TOTAL_TAX_VALUE
  FUNCTION fnuObtTOTAL_TAX_VALUE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.TOTAL_TAX_VALUE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtTOTAL_TAX_VALUE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.TOTAL_TAX_VALUE;
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
  END fnuObtTOTAL_TAX_VALUE;

  -- Obtiene el valor de la columna COMMENT_
  FUNCTION fsbObtCOMMENT_(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.COMMENT_%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtCOMMENT_';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.COMMENT_;
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
  END fsbObtCOMMENT_;

  -- Obtiene el valor de la columna PAY_MODALITY
  FUNCTION fnuObtPAY_MODALITY(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.PAY_MODALITY%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPAY_MODALITY';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PAY_MODALITY;
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
  END fnuObtPAY_MODALITY;

  -- Obtiene el valor de la columna PRODUCT_TYPE_ID
  FUNCTION fnuObtPRODUCT_TYPE_ID(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.PRODUCT_TYPE_ID%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtPRODUCT_TYPE_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PRODUCT_TYPE_ID;
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
  END fnuObtPRODUCT_TYPE_ID;

  -- Obtiene el valor de la columna NO_QUOT_ITEM_CHARGE
  FUNCTION fsbObtNO_QUOT_ITEM_CHARGE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.NO_QUOT_ITEM_CHARGE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fsbObtNO_QUOT_ITEM_CHARGE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.NO_QUOT_ITEM_CHARGE;
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
  END fsbObtNO_QUOT_ITEM_CHARGE;

  -- Obtiene el valor de la columna AUI_PERCENTAGE
  FUNCTION fnuObtAUI_PERCENTAGE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.AUI_PERCENTAGE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtAUI_PERCENTAGE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.AUI_PERCENTAGE;
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
  END fnuObtAUI_PERCENTAGE;

  -- Obtiene el valor de la columna TOTAL_AIU_VALUE
  FUNCTION fnuObtTOTAL_AIU_VALUE(inuQUOTATION_ID NUMBER)
    RETURN CC_QUOTATION.TOTAL_AIU_VALUE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtTOTAL_AIU_VALUE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.TOTAL_AIU_VALUE;
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
  END fnuObtTOTAL_AIU_VALUE;

  -- Obtiene la cotizacion con la solicitud
  FUNCTION fnuObtCotizacionPorSolicitud(inuSolicitud NUMBER)
    RETURN CC_QUOTATION.QUOTATION_ID%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtCotizacionPorSolicitud';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
    CURSOR cuCotizacion IS
      SELECT tb.*, tb.Rowid
        FROM CC_QUOTATION tb
       WHERE tb.package_id = inuSolicitud;
  
    rcRegistroAct cuCotizacion%ROWTYPE;
  
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    OPEN cuCotizacion;
    FETCH cuCotizacion
      into rcRegistroAct;
    CLOSE cuCotizacion;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.Quotation_Id;
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
  END fnuObtCotizacionPorSolicitud;

  -- Actualiza el valor de la columna DESCRIPTION
  PROCEDURE prAcDESCRIPTION(inuQUOTATION_ID NUMBER,
                            isbDESCRIPTION  VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcDESCRIPTION';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(isbDESCRIPTION, '-') <> NVL(rcRegistroAct.DESCRIPTION, '-') THEN
      UPDATE CC_QUOTATION
         SET DESCRIPTION = isbDESCRIPTION
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
  END prAcDESCRIPTION;

  -- Actualiza el valor de la columna REGISTER_DATE
  PROCEDURE prAcREGISTER_DATE(inuQUOTATION_ID  NUMBER,
                              idtREGISTER_DATE DATE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcREGISTER_DATE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(idtREGISTER_DATE, TO_DATE('01/01/1900', 'dd/mm/yyyy')) <>
       NVL(rcRegistroAct.REGISTER_DATE, TO_DATE('01/01/1900', 'dd/mm/yyyy')) THEN
      UPDATE CC_QUOTATION
         SET REGISTER_DATE = idtREGISTER_DATE
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
  END prAcREGISTER_DATE;

  -- Actualiza el valor de la columna STATUS
  PROCEDURE prAcSTATUS(inuQUOTATION_ID NUMBER, isbSTATUS VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcSTATUS';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(isbSTATUS, '-') <> NVL(rcRegistroAct.STATUS, '-') THEN
      UPDATE CC_QUOTATION
         SET STATUS = isbSTATUS
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
  END prAcSTATUS;

  -- Actualiza el valor de la columna SUBSCRIBER_ID
  PROCEDURE prAcSUBSCRIBER_ID(inuQUOTATION_ID  NUMBER,
                              inuSUBSCRIBER_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcSUBSCRIBER_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(inuSUBSCRIBER_ID, -1) <> NVL(rcRegistroAct.SUBSCRIBER_ID, -1) THEN
      UPDATE CC_QUOTATION
         SET SUBSCRIBER_ID = inuSUBSCRIBER_ID
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
  END prAcSUBSCRIBER_ID;

  -- Actualiza el valor de la columna REGISTER_PERSON_ID
  PROCEDURE prAcREGISTER_PERSON_ID(inuQUOTATION_ID       NUMBER,
                                   inuREGISTER_PERSON_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcREGISTER_PERSON_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(inuREGISTER_PERSON_ID, -1) <>
       NVL(rcRegistroAct.REGISTER_PERSON_ID, -1) THEN
      UPDATE CC_QUOTATION
         SET REGISTER_PERSON_ID = inuREGISTER_PERSON_ID
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
  END prAcREGISTER_PERSON_ID;

  -- Actualiza el valor de la columna PACKAGE_ID
  PROCEDURE prAcPACKAGE_ID(inuQUOTATION_ID NUMBER, inuPACKAGE_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPACKAGE_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(inuPACKAGE_ID, -1) <> NVL(rcRegistroAct.PACKAGE_ID, -1) THEN
      UPDATE CC_QUOTATION
         SET PACKAGE_ID = inuPACKAGE_ID
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
  END prAcPACKAGE_ID;

  -- Actualiza el valor de la columna END_DATE
  PROCEDURE prAcEND_DATE(inuQUOTATION_ID NUMBER, idtEND_DATE DATE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcEND_DATE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(idtEND_DATE, TO_DATE('01/01/1900', 'dd/mm/yyyy')) <>
       NVL(rcRegistroAct.END_DATE, TO_DATE('01/01/1900', 'dd/mm/yyyy')) THEN
      UPDATE CC_QUOTATION
         SET END_DATE = idtEND_DATE
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
  END prAcEND_DATE;

  -- Actualiza el valor de la columna UPDATE_PERSON_ID
  PROCEDURE prAcUPDATE_PERSON_ID(inuQUOTATION_ID     NUMBER,
                                 inuUPDATE_PERSON_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcUPDATE_PERSON_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(inuUPDATE_PERSON_ID, -1) <>
       NVL(rcRegistroAct.UPDATE_PERSON_ID, -1) THEN
      UPDATE CC_QUOTATION
         SET UPDATE_PERSON_ID = inuUPDATE_PERSON_ID
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
  END prAcUPDATE_PERSON_ID;

  -- Actualiza el valor de la columna UPDATE_DATE
  PROCEDURE prAcUPDATE_DATE(inuQUOTATION_ID NUMBER, idtUPDATE_DATE DATE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcUPDATE_DATE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(idtUPDATE_DATE, TO_DATE('01/01/1900', 'dd/mm/yyyy')) <>
       NVL(rcRegistroAct.UPDATE_DATE, TO_DATE('01/01/1900', 'dd/mm/yyyy')) THEN
      UPDATE CC_QUOTATION
         SET UPDATE_DATE = idtUPDATE_DATE
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
  END prAcUPDATE_DATE;

  -- Actualiza el valor de la columna INITIAL_PAYMENT
  PROCEDURE prAcINITIAL_PAYMENT(inuQUOTATION_ID    NUMBER,
                                inuINITIAL_PAYMENT NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcINITIAL_PAYMENT';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(inuINITIAL_PAYMENT, -1) <>
       NVL(rcRegistroAct.INITIAL_PAYMENT, -1) THEN
      UPDATE CC_QUOTATION
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

  -- Actualiza el valor de la columna DISCOUNT_PERCENTAGE
  PROCEDURE prAcDISCOUNT_PERCENTAGE(inuQUOTATION_ID        NUMBER,
                                    inuDISCOUNT_PERCENTAGE NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcDISCOUNT_PERCENTAGE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(inuDISCOUNT_PERCENTAGE, -1) <>
       NVL(rcRegistroAct.DISCOUNT_PERCENTAGE, -1) THEN
      UPDATE CC_QUOTATION
         SET DISCOUNT_PERCENTAGE = inuDISCOUNT_PERCENTAGE
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
  END prAcDISCOUNT_PERCENTAGE;

  -- Actualiza el valor de la columna GENERATED_CHARGES
  PROCEDURE prAcGENERATED_CHARGES(inuQUOTATION_ID      NUMBER,
                                  isbGENERATED_CHARGES VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcGENERATED_CHARGES';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(isbGENERATED_CHARGES, '-') <>
       NVL(rcRegistroAct.GENERATED_CHARGES, '-') THEN
      UPDATE CC_QUOTATION
         SET GENERATED_CHARGES = isbGENERATED_CHARGES
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
  END prAcGENERATED_CHARGES;

  -- Actualiza el valor de la columna INIT_PAYMENT_MODE
  PROCEDURE prAcINIT_PAYMENT_MODE(inuQUOTATION_ID      NUMBER,
                                  isbINIT_PAYMENT_MODE VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcINIT_PAYMENT_MODE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(isbINIT_PAYMENT_MODE, '-') <>
       NVL(rcRegistroAct.INIT_PAYMENT_MODE, '-') THEN
      UPDATE CC_QUOTATION
         SET INIT_PAYMENT_MODE = isbINIT_PAYMENT_MODE
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
  END prAcINIT_PAYMENT_MODE;

  -- Actualiza el valor de la columna TOTAL_ITEMS_VALUE
  PROCEDURE prAcTOTAL_ITEMS_VALUE(inuQUOTATION_ID      NUMBER,
                                  inuTOTAL_ITEMS_VALUE NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcTOTAL_ITEMS_VALUE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(inuTOTAL_ITEMS_VALUE, -1) <>
       NVL(rcRegistroAct.TOTAL_ITEMS_VALUE, -1) THEN
      UPDATE CC_QUOTATION
         SET TOTAL_ITEMS_VALUE = inuTOTAL_ITEMS_VALUE
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
  END prAcTOTAL_ITEMS_VALUE;

  -- Actualiza el valor de la columna TOTAL_DISC_VALUE
  PROCEDURE prAcTOTAL_DISC_VALUE(inuQUOTATION_ID     NUMBER,
                                 inuTOTAL_DISC_VALUE NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcTOTAL_DISC_VALUE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(inuTOTAL_DISC_VALUE, -1) <>
       NVL(rcRegistroAct.TOTAL_DISC_VALUE, -1) THEN
      UPDATE CC_QUOTATION
         SET TOTAL_DISC_VALUE = inuTOTAL_DISC_VALUE
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
  END prAcTOTAL_DISC_VALUE;

  -- Actualiza el valor de la columna TOTAL_TAX_VALUE
  PROCEDURE prAcTOTAL_TAX_VALUE(inuQUOTATION_ID    NUMBER,
                                inuTOTAL_TAX_VALUE NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcTOTAL_TAX_VALUE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(inuTOTAL_TAX_VALUE, -1) <>
       NVL(rcRegistroAct.TOTAL_TAX_VALUE, -1) THEN
      UPDATE CC_QUOTATION
         SET TOTAL_TAX_VALUE = inuTOTAL_TAX_VALUE
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
  END prAcTOTAL_TAX_VALUE;

  -- Actualiza el valor de la columna COMMENT_
  PROCEDURE prAcCOMMENT_(inuQUOTATION_ID NUMBER, isbCOMMENT_ VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcCOMMENT_';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(isbCOMMENT_, '-') <> NVL(rcRegistroAct.COMMENT_, '-') THEN
      UPDATE CC_QUOTATION
         SET COMMENT_ = isbCOMMENT_
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
  END prAcCOMMENT_;

  -- Actualiza el valor de la columna PAY_MODALITY
  PROCEDURE prAcPAY_MODALITY(inuQUOTATION_ID NUMBER,
                             inuPAY_MODALITY NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPAY_MODALITY';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(inuPAY_MODALITY, -1) <> NVL(rcRegistroAct.PAY_MODALITY, -1) THEN
      UPDATE CC_QUOTATION
         SET PAY_MODALITY = inuPAY_MODALITY
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
  END prAcPAY_MODALITY;

  -- Actualiza el valor de la columna PRODUCT_TYPE_ID
  PROCEDURE prAcPRODUCT_TYPE_ID(inuQUOTATION_ID    NUMBER,
                                inuPRODUCT_TYPE_ID NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPRODUCT_TYPE_ID';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(inuPRODUCT_TYPE_ID, -1) <>
       NVL(rcRegistroAct.PRODUCT_TYPE_ID, -1) THEN
      UPDATE CC_QUOTATION
         SET PRODUCT_TYPE_ID = inuPRODUCT_TYPE_ID
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
  END prAcPRODUCT_TYPE_ID;

  -- Actualiza el valor de la columna NO_QUOT_ITEM_CHARGE
  PROCEDURE prAcNO_QUOT_ITEM_CHARGE(inuQUOTATION_ID        NUMBER,
                                    isbNO_QUOT_ITEM_CHARGE VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcNO_QUOT_ITEM_CHARGE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(isbNO_QUOT_ITEM_CHARGE, '-') <>
       NVL(rcRegistroAct.NO_QUOT_ITEM_CHARGE, '-') THEN
      UPDATE CC_QUOTATION
         SET NO_QUOT_ITEM_CHARGE = isbNO_QUOT_ITEM_CHARGE
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
  END prAcNO_QUOT_ITEM_CHARGE;

  -- Actualiza el valor de la columna AUI_PERCENTAGE
  PROCEDURE prAcAUI_PERCENTAGE(inuQUOTATION_ID   NUMBER,
                               inuAUI_PERCENTAGE NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcAUI_PERCENTAGE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(inuAUI_PERCENTAGE, -1) <> NVL(rcRegistroAct.AUI_PERCENTAGE, -1) THEN
      UPDATE CC_QUOTATION
         SET AUI_PERCENTAGE = inuAUI_PERCENTAGE
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
  END prAcAUI_PERCENTAGE;

  -- Actualiza el valor de la columna TOTAL_AIU_VALUE
  PROCEDURE prAcTOTAL_AIU_VALUE(inuQUOTATION_ID    NUMBER,
                                inuTOTAL_AIU_VALUE NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcTOTAL_AIU_VALUE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuQUOTATION_ID, TRUE);
    IF NVL(inuTOTAL_AIU_VALUE, -1) <>
       NVL(rcRegistroAct.TOTAL_AIU_VALUE, -1) THEN
      UPDATE CC_QUOTATION
         SET TOTAL_AIU_VALUE = inuTOTAL_AIU_VALUE
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
  END prAcTOTAL_AIU_VALUE;

  -- Actualiza por RowId el valor de la columna DESCRIPTION
  PROCEDURE prAcDESCRIPTION_RId(iRowId           ROWID,
                                isbDESCRIPTION_O VARCHAR2,
                                isbDESCRIPTION_N VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcDESCRIPTION_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(isbDESCRIPTION_O, '-') <> NVL(isbDESCRIPTION_N, '-') THEN
      UPDATE CC_QUOTATION
         SET DESCRIPTION = isbDESCRIPTION_N
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
  END prAcDESCRIPTION_RId;

  -- Actualiza por RowId el valor de la columna REGISTER_DATE
  PROCEDURE prAcREGISTER_DATE_RId(iRowId             ROWID,
                                  idtREGISTER_DATE_O DATE,
                                  idtREGISTER_DATE_N DATE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcREGISTER_DATE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(idtREGISTER_DATE_O, TO_DATE('01/01/1900', 'dd/mm/yyyy')) <>
       NVL(idtREGISTER_DATE_N, TO_DATE('01/01/1900', 'dd/mm/yyyy')) THEN
      UPDATE CC_QUOTATION
         SET REGISTER_DATE = idtREGISTER_DATE_N
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
  END prAcREGISTER_DATE_RId;

  -- Actualiza por RowId el valor de la columna STATUS
  PROCEDURE prAcSTATUS_RId(iRowId      ROWID,
                           isbSTATUS_O VARCHAR2,
                           isbSTATUS_N VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcSTATUS_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(isbSTATUS_O, '-') <> NVL(isbSTATUS_N, '-') THEN
      UPDATE CC_QUOTATION SET STATUS = isbSTATUS_N WHERE Rowid = iRowId;
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
  END prAcSTATUS_RId;

  -- Actualiza por RowId el valor de la columna SUBSCRIBER_ID
  PROCEDURE prAcSUBSCRIBER_ID_RId(iRowId             ROWID,
                                  inuSUBSCRIBER_ID_O NUMBER,
                                  inuSUBSCRIBER_ID_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcSUBSCRIBER_ID_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuSUBSCRIBER_ID_O, -1) <> NVL(inuSUBSCRIBER_ID_N, -1) THEN
      UPDATE CC_QUOTATION
         SET SUBSCRIBER_ID = inuSUBSCRIBER_ID_N
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
  END prAcSUBSCRIBER_ID_RId;

  -- Actualiza por RowId el valor de la columna REGISTER_PERSON_ID
  PROCEDURE prAcREGISTER_PERSON_ID_RId(iRowId                  ROWID,
                                       inuREGISTER_PERSON_ID_O NUMBER,
                                       inuREGISTER_PERSON_ID_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcREGISTER_PERSON_ID_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuREGISTER_PERSON_ID_O, -1) <> NVL(inuREGISTER_PERSON_ID_N, -1) THEN
      UPDATE CC_QUOTATION
         SET REGISTER_PERSON_ID = inuREGISTER_PERSON_ID_N
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
  END prAcREGISTER_PERSON_ID_RId;

  -- Actualiza por RowId el valor de la columna PACKAGE_ID
  PROCEDURE prAcPACKAGE_ID_RId(iRowId          ROWID,
                               inuPACKAGE_ID_O NUMBER,
                               inuPACKAGE_ID_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPACKAGE_ID_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPACKAGE_ID_O, -1) <> NVL(inuPACKAGE_ID_N, -1) THEN
      UPDATE CC_QUOTATION
         SET PACKAGE_ID = inuPACKAGE_ID_N
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
  END prAcPACKAGE_ID_RId;

  -- Actualiza por RowId el valor de la columna END_DATE
  PROCEDURE prAcEND_DATE_RId(iRowId        ROWID,
                             idtEND_DATE_O DATE,
                             idtEND_DATE_N DATE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcEND_DATE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(idtEND_DATE_O, TO_DATE('01/01/1900', 'dd/mm/yyyy')) <>
       NVL(idtEND_DATE_N, TO_DATE('01/01/1900', 'dd/mm/yyyy')) THEN
      UPDATE CC_QUOTATION
         SET END_DATE = idtEND_DATE_N
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
  END prAcEND_DATE_RId;

  -- Actualiza por RowId el valor de la columna UPDATE_PERSON_ID
  PROCEDURE prAcUPDATE_PERSON_ID_RId(iRowId                ROWID,
                                     inuUPDATE_PERSON_ID_O NUMBER,
                                     inuUPDATE_PERSON_ID_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcUPDATE_PERSON_ID_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuUPDATE_PERSON_ID_O, -1) <> NVL(inuUPDATE_PERSON_ID_N, -1) THEN
      UPDATE CC_QUOTATION
         SET UPDATE_PERSON_ID = inuUPDATE_PERSON_ID_N
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
  END prAcUPDATE_PERSON_ID_RId;

  -- Actualiza por RowId el valor de la columna UPDATE_DATE
  PROCEDURE prAcUPDATE_DATE_RId(iRowId           ROWID,
                                idtUPDATE_DATE_O DATE,
                                idtUPDATE_DATE_N DATE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcUPDATE_DATE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(idtUPDATE_DATE_O, TO_DATE('01/01/1900', 'dd/mm/yyyy')) <>
       NVL(idtUPDATE_DATE_N, TO_DATE('01/01/1900', 'dd/mm/yyyy')) THEN
      UPDATE CC_QUOTATION
         SET UPDATE_DATE = idtUPDATE_DATE_N
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
  END prAcUPDATE_DATE_RId;

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
      UPDATE CC_QUOTATION
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

  -- Actualiza por RowId el valor de la columna DISCOUNT_PERCENTAGE
  PROCEDURE prAcDISCOUNT_PERCENTAGE_RId(iRowId                   ROWID,
                                        inuDISCOUNT_PERCENTAGE_O NUMBER,
                                        inuDISCOUNT_PERCENTAGE_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcDISCOUNT_PERCENTAGE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuDISCOUNT_PERCENTAGE_O, -1) <>
       NVL(inuDISCOUNT_PERCENTAGE_N, -1) THEN
      UPDATE CC_QUOTATION
         SET DISCOUNT_PERCENTAGE = inuDISCOUNT_PERCENTAGE_N
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
  END prAcDISCOUNT_PERCENTAGE_RId;

  -- Actualiza por RowId el valor de la columna GENERATED_CHARGES
  PROCEDURE prAcGENERATED_CHARGES_RId(iRowId                 ROWID,
                                      isbGENERATED_CHARGES_O VARCHAR2,
                                      isbGENERATED_CHARGES_N VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcGENERATED_CHARGES_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(isbGENERATED_CHARGES_O, '-') <> NVL(isbGENERATED_CHARGES_N, '-') THEN
      UPDATE CC_QUOTATION
         SET GENERATED_CHARGES = isbGENERATED_CHARGES_N
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
  END prAcGENERATED_CHARGES_RId;

  -- Actualiza por RowId el valor de la columna INIT_PAYMENT_MODE
  PROCEDURE prAcINIT_PAYMENT_MODE_RId(iRowId                 ROWID,
                                      isbINIT_PAYMENT_MODE_O VARCHAR2,
                                      isbINIT_PAYMENT_MODE_N VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcINIT_PAYMENT_MODE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(isbINIT_PAYMENT_MODE_O, '-') <> NVL(isbINIT_PAYMENT_MODE_N, '-') THEN
      UPDATE CC_QUOTATION
         SET INIT_PAYMENT_MODE = isbINIT_PAYMENT_MODE_N
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
  END prAcINIT_PAYMENT_MODE_RId;

  -- Actualiza por RowId el valor de la columna TOTAL_ITEMS_VALUE
  PROCEDURE prAcTOTAL_ITEMS_VALUE_RId(iRowId                 ROWID,
                                      inuTOTAL_ITEMS_VALUE_O NUMBER,
                                      inuTOTAL_ITEMS_VALUE_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcTOTAL_ITEMS_VALUE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuTOTAL_ITEMS_VALUE_O, -1) <> NVL(inuTOTAL_ITEMS_VALUE_N, -1) THEN
      UPDATE CC_QUOTATION
         SET TOTAL_ITEMS_VALUE = inuTOTAL_ITEMS_VALUE_N
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
  END prAcTOTAL_ITEMS_VALUE_RId;

  -- Actualiza por RowId el valor de la columna TOTAL_DISC_VALUE
  PROCEDURE prAcTOTAL_DISC_VALUE_RId(iRowId                ROWID,
                                     inuTOTAL_DISC_VALUE_O NUMBER,
                                     inuTOTAL_DISC_VALUE_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcTOTAL_DISC_VALUE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuTOTAL_DISC_VALUE_O, -1) <> NVL(inuTOTAL_DISC_VALUE_N, -1) THEN
      UPDATE CC_QUOTATION
         SET TOTAL_DISC_VALUE = inuTOTAL_DISC_VALUE_N
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
  END prAcTOTAL_DISC_VALUE_RId;

  -- Actualiza por RowId el valor de la columna TOTAL_TAX_VALUE
  PROCEDURE prAcTOTAL_TAX_VALUE_RId(iRowId               ROWID,
                                    inuTOTAL_TAX_VALUE_O NUMBER,
                                    inuTOTAL_TAX_VALUE_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcTOTAL_TAX_VALUE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuTOTAL_TAX_VALUE_O, -1) <> NVL(inuTOTAL_TAX_VALUE_N, -1) THEN
      UPDATE CC_QUOTATION
         SET TOTAL_TAX_VALUE = inuTOTAL_TAX_VALUE_N
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
  END prAcTOTAL_TAX_VALUE_RId;

  -- Actualiza por RowId el valor de la columna COMMENT_
  PROCEDURE prAcCOMMENT__RId(iRowId        ROWID,
                             isbCOMMENT__O VARCHAR2,
                             isbCOMMENT__N VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcCOMMENT__RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(isbCOMMENT__O, '-') <> NVL(isbCOMMENT__N, '-') THEN
      UPDATE CC_QUOTATION
         SET COMMENT_ = isbCOMMENT__N
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
  END prAcCOMMENT__RId;

  -- Actualiza por RowId el valor de la columna PAY_MODALITY
  PROCEDURE prAcPAY_MODALITY_RId(iRowId            ROWID,
                                 inuPAY_MODALITY_O NUMBER,
                                 inuPAY_MODALITY_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPAY_MODALITY_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPAY_MODALITY_O, -1) <> NVL(inuPAY_MODALITY_N, -1) THEN
      UPDATE CC_QUOTATION
         SET PAY_MODALITY = inuPAY_MODALITY_N
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
  END prAcPAY_MODALITY_RId;

  -- Actualiza por RowId el valor de la columna PRODUCT_TYPE_ID
  PROCEDURE prAcPRODUCT_TYPE_ID_RId(iRowId               ROWID,
                                    inuPRODUCT_TYPE_ID_O NUMBER,
                                    inuPRODUCT_TYPE_ID_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcPRODUCT_TYPE_ID_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPRODUCT_TYPE_ID_O, -1) <> NVL(inuPRODUCT_TYPE_ID_N, -1) THEN
      UPDATE CC_QUOTATION
         SET PRODUCT_TYPE_ID = inuPRODUCT_TYPE_ID_N
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
  END prAcPRODUCT_TYPE_ID_RId;

  -- Actualiza por RowId el valor de la columna NO_QUOT_ITEM_CHARGE
  PROCEDURE prAcNO_QUOT_ITEM_CHARGE_RId(iRowId                   ROWID,
                                        isbNO_QUOT_ITEM_CHARGE_O VARCHAR2,
                                        isbNO_QUOT_ITEM_CHARGE_N VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcNO_QUOT_ITEM_CHARGE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(isbNO_QUOT_ITEM_CHARGE_O, '-') <>
       NVL(isbNO_QUOT_ITEM_CHARGE_N, '-') THEN
      UPDATE CC_QUOTATION
         SET NO_QUOT_ITEM_CHARGE = isbNO_QUOT_ITEM_CHARGE_N
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
  END prAcNO_QUOT_ITEM_CHARGE_RId;

  -- Actualiza por RowId el valor de la columna AUI_PERCENTAGE
  PROCEDURE prAcAUI_PERCENTAGE_RId(iRowId              ROWID,
                                   inuAUI_PERCENTAGE_O NUMBER,
                                   inuAUI_PERCENTAGE_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcAUI_PERCENTAGE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuAUI_PERCENTAGE_O, -1) <> NVL(inuAUI_PERCENTAGE_N, -1) THEN
      UPDATE CC_QUOTATION
         SET AUI_PERCENTAGE = inuAUI_PERCENTAGE_N
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
  END prAcAUI_PERCENTAGE_RId;

  -- Actualiza por RowId el valor de la columna TOTAL_AIU_VALUE
  PROCEDURE prAcTOTAL_AIU_VALUE_RId(iRowId               ROWID,
                                    inuTOTAL_AIU_VALUE_O NUMBER,
                                    inuTOTAL_AIU_VALUE_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'prAcTOTAL_AIU_VALUE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuTOTAL_AIU_VALUE_O, -1) <> NVL(inuTOTAL_AIU_VALUE_N, -1) THEN
      UPDATE CC_QUOTATION
         SET TOTAL_AIU_VALUE = inuTOTAL_AIU_VALUE_N
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
  END prAcTOTAL_AIU_VALUE_RId;

  -- Actualiza las columnas con valor diferente al anterior
  PROCEDURE prActRegistro(ircRegistro cuCC_QUOTATION%ROWTYPE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prActRegistro';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(ircRegistro.QUOTATION_ID, TRUE);
    IF rcRegistroAct.RowId IS NOT NULL THEN
      prAcDESCRIPTION_RId(rcRegistroAct.RowId,
                          rcRegistroAct.DESCRIPTION,
                          ircRegistro.DESCRIPTION);
    
      prAcREGISTER_DATE_RId(rcRegistroAct.RowId,
                            rcRegistroAct.REGISTER_DATE,
                            ircRegistro.REGISTER_DATE);
    
      prAcSTATUS_RId(rcRegistroAct.RowId,
                     rcRegistroAct.STATUS,
                     ircRegistro.STATUS);
    
      prAcSUBSCRIBER_ID_RId(rcRegistroAct.RowId,
                            rcRegistroAct.SUBSCRIBER_ID,
                            ircRegistro.SUBSCRIBER_ID);
    
      prAcREGISTER_PERSON_ID_RId(rcRegistroAct.RowId,
                                 rcRegistroAct.REGISTER_PERSON_ID,
                                 ircRegistro.REGISTER_PERSON_ID);
    
      prAcPACKAGE_ID_RId(rcRegistroAct.RowId,
                         rcRegistroAct.PACKAGE_ID,
                         ircRegistro.PACKAGE_ID);
    
      prAcEND_DATE_RId(rcRegistroAct.RowId,
                       rcRegistroAct.END_DATE,
                       ircRegistro.END_DATE);
    
      prAcUPDATE_PERSON_ID_RId(rcRegistroAct.RowId,
                               rcRegistroAct.UPDATE_PERSON_ID,
                               ircRegistro.UPDATE_PERSON_ID);
    
      prAcUPDATE_DATE_RId(rcRegistroAct.RowId,
                          rcRegistroAct.UPDATE_DATE,
                          ircRegistro.UPDATE_DATE);
    
      prAcINITIAL_PAYMENT_RId(rcRegistroAct.RowId,
                              rcRegistroAct.INITIAL_PAYMENT,
                              ircRegistro.INITIAL_PAYMENT);
    
      prAcDISCOUNT_PERCENTAGE_RId(rcRegistroAct.RowId,
                                  rcRegistroAct.DISCOUNT_PERCENTAGE,
                                  ircRegistro.DISCOUNT_PERCENTAGE);
    
      prAcGENERATED_CHARGES_RId(rcRegistroAct.RowId,
                                rcRegistroAct.GENERATED_CHARGES,
                                ircRegistro.GENERATED_CHARGES);
    
      prAcINIT_PAYMENT_MODE_RId(rcRegistroAct.RowId,
                                rcRegistroAct.INIT_PAYMENT_MODE,
                                ircRegistro.INIT_PAYMENT_MODE);
    
      prAcTOTAL_ITEMS_VALUE_RId(rcRegistroAct.RowId,
                                rcRegistroAct.TOTAL_ITEMS_VALUE,
                                ircRegistro.TOTAL_ITEMS_VALUE);
    
      prAcTOTAL_DISC_VALUE_RId(rcRegistroAct.RowId,
                               rcRegistroAct.TOTAL_DISC_VALUE,
                               ircRegistro.TOTAL_DISC_VALUE);
    
      prAcTOTAL_TAX_VALUE_RId(rcRegistroAct.RowId,
                              rcRegistroAct.TOTAL_TAX_VALUE,
                              ircRegistro.TOTAL_TAX_VALUE);
    
      prAcCOMMENT__RId(rcRegistroAct.RowId,
                       rcRegistroAct.COMMENT_,
                       ircRegistro.COMMENT_);
    
      prAcPAY_MODALITY_RId(rcRegistroAct.RowId,
                           rcRegistroAct.PAY_MODALITY,
                           ircRegistro.PAY_MODALITY);
    
      prAcPRODUCT_TYPE_ID_RId(rcRegistroAct.RowId,
                              rcRegistroAct.PRODUCT_TYPE_ID,
                              ircRegistro.PRODUCT_TYPE_ID);
    
      prAcNO_QUOT_ITEM_CHARGE_RId(rcRegistroAct.RowId,
                                  rcRegistroAct.NO_QUOT_ITEM_CHARGE,
                                  ircRegistro.NO_QUOT_ITEM_CHARGE);
    
      prAcAUI_PERCENTAGE_RId(rcRegistroAct.RowId,
                             rcRegistroAct.AUI_PERCENTAGE,
                             ircRegistro.AUI_PERCENTAGE);
    
      prAcTOTAL_AIU_VALUE_RId(rcRegistroAct.RowId,
                              rcRegistroAct.TOTAL_AIU_VALUE,
                              ircRegistro.TOTAL_AIU_VALUE);
    
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

END pkg_CC_QUOTATION;
/
BEGIN
  pkg_Utilidades.prAplicarPermisos(UPPER('pkg_CC_QUOTATION'),
                                   UPPER('adm_person'));
END;
/
