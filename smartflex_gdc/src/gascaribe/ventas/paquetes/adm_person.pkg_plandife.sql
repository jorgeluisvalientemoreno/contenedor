CREATE OR REPLACE PACKAGE adm_person.pkg_PLANDIFE AS
  TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
  TYPE tytbRegistros IS TABLE OF PLANDIFE%ROWTYPE INDEX BY BINARY_INTEGER;
  CURSOR cuPLANDIFE IS
    SELECT * FROM PLANDIFE;
  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe y Efigas
      Autor : jvaliente
      Descr : Paquete manejo datos con relacion a la entidad PLANDIFE
      Tabla : PLANDIFE
      Caso  : OSF-3838
      Fecha : 10/01/2025 10:06:13
  ***************************************************************************/
  CURSOR cuRegistroRId(inuPLDICODI NUMBER) IS
    SELECT tb.*, tb.Rowid FROM PLANDIFE tb WHERE PLDICODI = inuPLDICODI;

  CURSOR cuRegistroRIdLock(inuPLDICODI NUMBER) IS
    SELECT tb.*, tb.Rowid
      FROM PLANDIFE tb
     WHERE PLDICODI = inuPLDICODI
       FOR UPDATE NOWAIT;
	   
	-- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;

  -- Obtiene el registro y el rowid
  FUNCTION frcObtRegistroRId(inuPLDICODI NUMBER,
                             iblBloquea  BOOLEAN DEFAULT FALSE)
    RETURN cuRegistroRId%ROWTYPE;

  -- Retorna verdadero si existe el registro
  FUNCTION fblExiste(inuPLDICODI NUMBER) RETURN BOOLEAN;

  -- Levanta excepción si el registro NO existe
  PROCEDURE prValExiste(inuPLDICODI NUMBER);

  -- Inserta un registro
  PROCEDURE prinsRegistro(ircRegistro cuPLANDIFE%ROWTYPE);

  -- Borra un registro
  PROCEDURE prBorRegistro(inuPLDICODI NUMBER);

  -- Borra un registro por RowId
  PROCEDURE prBorRegistroxRowId(iRowId ROWID);

  -- Obtiene el valor de la columna PLDIDESC
  FUNCTION fsbObtPLDIDESC(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIDESC%TYPE;

  -- Obtiene el valor de la columna PLDIFECR
  FUNCTION fdtObtPLDIFECR(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIFECR%TYPE;

  -- Obtiene el valor de la columna PLDIFEIN
  FUNCTION fdtObtPLDIFEIN(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIFEIN%TYPE;

  -- Obtiene el valor de la columna PLDIFEFI
  FUNCTION fdtObtPLDIFEFI(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIFEFI%TYPE;

  -- Obtiene el valor de la columna PLDICUMI
  FUNCTION fnuObtPLDICUMI(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDICUMI%TYPE;

  -- Obtiene el valor de la columna PLDICUMA
  FUNCTION fnuObtPLDICUMA(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDICUMA%TYPE;

  -- Obtiene el valor de la columna PLDIPOIN
  FUNCTION fnuObtPLDIPOIN(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIPOIN%TYPE;

  -- Obtiene el valor de la columna PLDIMCCD
  FUNCTION fnuObtPLDIMCCD(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIMCCD%TYPE;

  -- Obtiene el valor de la columna PLDIGECO
  FUNCTION fsbObtPLDIGECO(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIGECO%TYPE;

  -- Obtiene el valor de la columna PLDICEMA
  FUNCTION fnuObtPLDICEMA(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDICEMA%TYPE;

  -- Obtiene el valor de la columna PLDIDOSO
  FUNCTION fsbObtPLDIDOSO(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIDOSO%TYPE;

  -- Obtiene el valor de la columna PLDISPMA
  FUNCTION fnuObtPLDISPMA(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDISPMA%TYPE;

  -- Obtiene el valor de la columna PLDISPMI
  FUNCTION fnuObtPLDISPMI(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDISPMI%TYPE;

  -- Obtiene el valor de la columna PLDITAIN
  FUNCTION fnuObtPLDITAIN(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDITAIN%TYPE;

  -- Obtiene el valor de la columna PLDIFAGR
  FUNCTION fnuObtPLDIFAGR(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIFAGR%TYPE;

  -- Obtiene el valor de la columna PLDICUVE
  FUNCTION fnuObtPLDICUVE(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDICUVE%TYPE;

  -- Obtiene el valor de la columna PLDINCVS
  FUNCTION fnuObtPLDINCVS(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDINCVS%TYPE;

  -- Obtiene el valor de la columna PLDINVRE
  FUNCTION fnuObtPLDINVRE(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDINVRE%TYPE;

  -- Obtiene el valor de la columna PLDIPMIF
  FUNCTION fnuObtPLDIPMIF(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIPMIF%TYPE;

  -- Obtiene el valor de la columna PLDIPMAF
  FUNCTION fnuObtPLDIPMAF(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIPMAF%TYPE;

  -- Obtiene el valor de la columna PLDIPRMO
  FUNCTION fnuObtPLDIPRMO(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIPRMO%TYPE;

  -- Obtiene el valor de la columna PLDIPEGR
  FUNCTION fnuObtPLDIPEGR(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIPEGR%TYPE;

  -- Actualiza el valor de la columna PLDIDESC
  PROCEDURE prAcPLDIDESC(inuPLDICODI NUMBER, isbPLDIDESC VARCHAR2);

  -- Actualiza el valor de la columna PLDIFECR
  PROCEDURE prAcPLDIFECR(inuPLDICODI NUMBER, idtPLDIFECR DATE);

  -- Actualiza el valor de la columna PLDIFEIN
  PROCEDURE prAcPLDIFEIN(inuPLDICODI NUMBER, idtPLDIFEIN DATE);

  -- Actualiza el valor de la columna PLDIFEFI
  PROCEDURE prAcPLDIFEFI(inuPLDICODI NUMBER, idtPLDIFEFI DATE);

  -- Actualiza el valor de la columna PLDICUMI
  PROCEDURE prAcPLDICUMI(inuPLDICODI NUMBER, inuPLDICUMI NUMBER);

  -- Actualiza el valor de la columna PLDICUMA
  PROCEDURE prAcPLDICUMA(inuPLDICODI NUMBER, inuPLDICUMA NUMBER);

  -- Actualiza el valor de la columna PLDIPOIN
  PROCEDURE prAcPLDIPOIN(inuPLDICODI NUMBER, inuPLDIPOIN NUMBER);

  -- Actualiza el valor de la columna PLDIMCCD
  PROCEDURE prAcPLDIMCCD(inuPLDICODI NUMBER, inuPLDIMCCD NUMBER);

  -- Actualiza el valor de la columna PLDIGECO
  PROCEDURE prAcPLDIGECO(inuPLDICODI NUMBER, isbPLDIGECO VARCHAR2);

  -- Actualiza el valor de la columna PLDICEMA
  PROCEDURE prAcPLDICEMA(inuPLDICODI NUMBER, inuPLDICEMA NUMBER);

  -- Actualiza el valor de la columna PLDIDOSO
  PROCEDURE prAcPLDIDOSO(inuPLDICODI NUMBER, isbPLDIDOSO VARCHAR2);

  -- Actualiza el valor de la columna PLDISPMA
  PROCEDURE prAcPLDISPMA(inuPLDICODI NUMBER, inuPLDISPMA NUMBER);

  -- Actualiza el valor de la columna PLDISPMI
  PROCEDURE prAcPLDISPMI(inuPLDICODI NUMBER, inuPLDISPMI NUMBER);

  -- Actualiza el valor de la columna PLDITAIN
  PROCEDURE prAcPLDITAIN(inuPLDICODI NUMBER, inuPLDITAIN NUMBER);

  -- Actualiza el valor de la columna PLDIFAGR
  PROCEDURE prAcPLDIFAGR(inuPLDICODI NUMBER, inuPLDIFAGR NUMBER);

  -- Actualiza el valor de la columna PLDICUVE
  PROCEDURE prAcPLDICUVE(inuPLDICODI NUMBER, inuPLDICUVE NUMBER);

  -- Actualiza el valor de la columna PLDINCVS
  PROCEDURE prAcPLDINCVS(inuPLDICODI NUMBER, inuPLDINCVS NUMBER);

  -- Actualiza el valor de la columna PLDINVRE
  PROCEDURE prAcPLDINVRE(inuPLDICODI NUMBER, inuPLDINVRE NUMBER);

  -- Actualiza el valor de la columna PLDIPMIF
  PROCEDURE prAcPLDIPMIF(inuPLDICODI NUMBER, inuPLDIPMIF NUMBER);

  -- Actualiza el valor de la columna PLDIPMAF
  PROCEDURE prAcPLDIPMAF(inuPLDICODI NUMBER, inuPLDIPMAF NUMBER);

  -- Actualiza el valor de la columna PLDIPRMO
  PROCEDURE prAcPLDIPRMO(inuPLDICODI NUMBER, inuPLDIPRMO NUMBER);

  -- Actualiza el valor de la columna PLDIPEGR
  PROCEDURE prAcPLDIPEGR(inuPLDICODI NUMBER, inuPLDIPEGR NUMBER);

  -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
  PROCEDURE prActRegistro(ircRegistro cuPLANDIFE%ROWTYPE);
  
	-- Obtiene la cantidad de diferidos repesca
    FUNCTION fnuObtCantidadPlandifeRepesca(isbValorParametro  parametros.valor_cadena%TYPE)
	RETURN NUMBER;

END pkg_PLANDIFE;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_PLANDIFE AS

	-- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-4535';
	
	csbSP_NAME    CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
	csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;
  
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete
    Autor           : Jhon Erazo - MVM
    Fecha           : 04/06/2025
    Modificaciones  :
    Autor       Fecha       Caso    	Descripcion
    jerazomvm     04/06/2025  OSF-4535	Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
	
  -- Obtiene registro y RowId
  FUNCTION frcObtRegistroRId(inuPLDICODI NUMBER,
                             iblBloquea  BOOLEAN DEFAULT FALSE)
    RETURN cuRegistroRId%ROWTYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'frcObtRegistroRId';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroRId cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF iblBloquea THEN
      OPEN cuRegistroRIdLock(inuPLDICODI);
      FETCH cuRegistroRIdLock
        INTO rcRegistroRId;
      CLOSE cuRegistroRIdLock;
    ELSE
      OPEN cuRegistroRId(inuPLDICODI);
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
  FUNCTION fblExiste(inuPLDICODI NUMBER) RETURN BOOLEAN IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblExiste';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroRId cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroRId := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroRId.PLDICODI IS NOT NULL;
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
  PROCEDURE prValExiste(inuPLDICODI NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prValExiste';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NOT fblExiste(inuPLDICODI) THEN
      pkg_error.setErrorMessage(isbMsgErrr => 'No existe el registro [' ||
                                              inuPLDICODI ||
                                              '] en la tabla[PLANDIFE]');
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
  PROCEDURE prInsRegistro(ircRegistro cuPLANDIFE%ROWTYPE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prInsRegistro';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    INSERT INTO PLANDIFE
      (PLDICODI,
       PLDIDESC,
       PLDIFECR,
       PLDIFEIN,
       PLDIFEFI,
       PLDICUMI,
       PLDICUMA,
       PLDIPOIN,
       PLDIMCCD,
       PLDIGECO,
       PLDICEMA,
       PLDIDOSO,
       PLDISPMA,
       PLDISPMI,
       PLDITAIN,
       PLDIFAGR,
       PLDICUVE,
       PLDINCVS,
       PLDINVRE,
       PLDIPMIF,
       PLDIPMAF,
       PLDIPRMO,
       PLDIPEGR)
    VALUES
      (ircRegistro.PLDICODI,
       ircRegistro.PLDIDESC,
       ircRegistro.PLDIFECR,
       ircRegistro.PLDIFEIN,
       ircRegistro.PLDIFEFI,
       ircRegistro.PLDICUMI,
       ircRegistro.PLDICUMA,
       ircRegistro.PLDIPOIN,
       ircRegistro.PLDIMCCD,
       ircRegistro.PLDIGECO,
       ircRegistro.PLDICEMA,
       ircRegistro.PLDIDOSO,
       ircRegistro.PLDISPMA,
       ircRegistro.PLDISPMI,
       ircRegistro.PLDITAIN,
       ircRegistro.PLDIFAGR,
       ircRegistro.PLDICUVE,
       ircRegistro.PLDINCVS,
       ircRegistro.PLDINVRE,
       ircRegistro.PLDIPMIF,
       ircRegistro.PLDIPMAF,
       ircRegistro.PLDIPRMO,
       ircRegistro.PLDIPEGR);
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
  PROCEDURE prBorRegistro(inuPLDICODI NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prBorRegistro';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF rcRegistroAct.RowId IS NOT NULL THEN
      DELETE PLANDIFE WHERE ROWID = rcRegistroAct.RowId;
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
      DELETE PLANDIFE WHERE RowId = iRowId;
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

  -- Obtiene el valor de la columna PLDIDESC
  FUNCTION fsbObtPLDIDESC(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIDESC%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtPLDIDESC';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDIDESC;
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
  END fsbObtPLDIDESC;

  -- Obtiene el valor de la columna PLDIFECR
  FUNCTION fdtObtPLDIFECR(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIFECR%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fdtObtPLDIFECR';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDIFECR;
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
  END fdtObtPLDIFECR;

  -- Obtiene el valor de la columna PLDIFEIN
  FUNCTION fdtObtPLDIFEIN(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIFEIN%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fdtObtPLDIFEIN';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDIFEIN;
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
  END fdtObtPLDIFEIN;

  -- Obtiene el valor de la columna PLDIFEFI
  FUNCTION fdtObtPLDIFEFI(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIFEFI%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fdtObtPLDIFEFI';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDIFEFI;
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
  END fdtObtPLDIFEFI;

  -- Obtiene el valor de la columna PLDICUMI
  FUNCTION fnuObtPLDICUMI(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDICUMI%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPLDICUMI';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDICUMI;
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
  END fnuObtPLDICUMI;

  -- Obtiene el valor de la columna PLDICUMA
  FUNCTION fnuObtPLDICUMA(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDICUMA%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPLDICUMA';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDICUMA;
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
  END fnuObtPLDICUMA;

  -- Obtiene el valor de la columna PLDIPOIN
  FUNCTION fnuObtPLDIPOIN(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIPOIN%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPLDIPOIN';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDIPOIN;
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
  END fnuObtPLDIPOIN;

  -- Obtiene el valor de la columna PLDIMCCD
  FUNCTION fnuObtPLDIMCCD(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIMCCD%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPLDIMCCD';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDIMCCD;
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
  END fnuObtPLDIMCCD;

  -- Obtiene el valor de la columna PLDIGECO
  FUNCTION fsbObtPLDIGECO(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIGECO%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtPLDIGECO';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDIGECO;
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
  END fsbObtPLDIGECO;

  -- Obtiene el valor de la columna PLDICEMA
  FUNCTION fnuObtPLDICEMA(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDICEMA%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPLDICEMA';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDICEMA;
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
  END fnuObtPLDICEMA;

  -- Obtiene el valor de la columna PLDIDOSO
  FUNCTION fsbObtPLDIDOSO(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIDOSO%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtPLDIDOSO';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDIDOSO;
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
  END fsbObtPLDIDOSO;

  -- Obtiene el valor de la columna PLDISPMA
  FUNCTION fnuObtPLDISPMA(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDISPMA%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPLDISPMA';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDISPMA;
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
  END fnuObtPLDISPMA;

  -- Obtiene el valor de la columna PLDISPMI
  FUNCTION fnuObtPLDISPMI(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDISPMI%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPLDISPMI';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDISPMI;
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
  END fnuObtPLDISPMI;

  -- Obtiene el valor de la columna PLDITAIN
  FUNCTION fnuObtPLDITAIN(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDITAIN%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPLDITAIN';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDITAIN;
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
  END fnuObtPLDITAIN;

  -- Obtiene el valor de la columna PLDIFAGR
  FUNCTION fnuObtPLDIFAGR(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIFAGR%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPLDIFAGR';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDIFAGR;
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
  END fnuObtPLDIFAGR;

  -- Obtiene el valor de la columna PLDICUVE
  FUNCTION fnuObtPLDICUVE(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDICUVE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPLDICUVE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDICUVE;
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
  END fnuObtPLDICUVE;

  -- Obtiene el valor de la columna PLDINCVS
  FUNCTION fnuObtPLDINCVS(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDINCVS%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPLDINCVS';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDINCVS;
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
  END fnuObtPLDINCVS;

  -- Obtiene el valor de la columna PLDINVRE
  FUNCTION fnuObtPLDINVRE(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDINVRE%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPLDINVRE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDINVRE;
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
  END fnuObtPLDINVRE;

  -- Obtiene el valor de la columna PLDIPMIF
  FUNCTION fnuObtPLDIPMIF(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIPMIF%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPLDIPMIF';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDIPMIF;
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
  END fnuObtPLDIPMIF;

  -- Obtiene el valor de la columna PLDIPMAF
  FUNCTION fnuObtPLDIPMAF(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIPMAF%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPLDIPMAF';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDIPMAF;
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
  END fnuObtPLDIPMAF;

  -- Obtiene el valor de la columna PLDIPRMO
  FUNCTION fnuObtPLDIPRMO(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIPRMO%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPLDIPRMO';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDIPRMO;
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
  END fnuObtPLDIPRMO;

  -- Obtiene el valor de la columna PLDIPEGR
  FUNCTION fnuObtPLDIPEGR(inuPLDICODI NUMBER) RETURN PLANDIFE.PLDIPEGR%TYPE IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtPLDIPEGR';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN rcRegistroAct.PLDIPEGR;
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
  END fnuObtPLDIPEGR;

  -- Actualiza el valor de la columna PLDIDESC
  PROCEDURE prAcPLDIDESC(inuPLDICODI NUMBER, isbPLDIDESC VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIDESC';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(isbPLDIDESC, '-') <> NVL(rcRegistroAct.PLDIDESC, '-') THEN
      UPDATE PLANDIFE
         SET PLDIDESC = isbPLDIDESC
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
  END prAcPLDIDESC;

  -- Actualiza el valor de la columna PLDIFECR
  PROCEDURE prAcPLDIFECR(inuPLDICODI NUMBER, idtPLDIFECR DATE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIFECR';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(idtPLDIFECR, TO_DATE('01/01/1900', 'dd/mm/yyyy')) <>
       NVL(rcRegistroAct.PLDIFECR, TO_DATE('01/01/1900', 'dd/mm/yyyy')) THEN
      UPDATE PLANDIFE
         SET PLDIFECR = idtPLDIFECR
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
  END prAcPLDIFECR;

  -- Actualiza el valor de la columna PLDIFEIN
  PROCEDURE prAcPLDIFEIN(inuPLDICODI NUMBER, idtPLDIFEIN DATE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIFEIN';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(idtPLDIFEIN, TO_DATE('01/01/1900', 'dd/mm/yyyy')) <>
       NVL(rcRegistroAct.PLDIFEIN, TO_DATE('01/01/1900', 'dd/mm/yyyy')) THEN
      UPDATE PLANDIFE
         SET PLDIFEIN = idtPLDIFEIN
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
  END prAcPLDIFEIN;

  -- Actualiza el valor de la columna PLDIFEFI
  PROCEDURE prAcPLDIFEFI(inuPLDICODI NUMBER, idtPLDIFEFI DATE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIFEFI';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(idtPLDIFEFI, TO_DATE('01/01/1900', 'dd/mm/yyyy')) <>
       NVL(rcRegistroAct.PLDIFEFI, TO_DATE('01/01/1900', 'dd/mm/yyyy')) THEN
      UPDATE PLANDIFE
         SET PLDIFEFI = idtPLDIFEFI
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
  END prAcPLDIFEFI;

  -- Actualiza el valor de la columna PLDICUMI
  PROCEDURE prAcPLDICUMI(inuPLDICODI NUMBER, inuPLDICUMI NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDICUMI';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(inuPLDICUMI, -1) <> NVL(rcRegistroAct.PLDICUMI, -1) THEN
      UPDATE PLANDIFE
         SET PLDICUMI = inuPLDICUMI
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
  END prAcPLDICUMI;

  -- Actualiza el valor de la columna PLDICUMA
  PROCEDURE prAcPLDICUMA(inuPLDICODI NUMBER, inuPLDICUMA NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDICUMA';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(inuPLDICUMA, -1) <> NVL(rcRegistroAct.PLDICUMA, -1) THEN
      UPDATE PLANDIFE
         SET PLDICUMA = inuPLDICUMA
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
  END prAcPLDICUMA;

  -- Actualiza el valor de la columna PLDIPOIN
  PROCEDURE prAcPLDIPOIN(inuPLDICODI NUMBER, inuPLDIPOIN NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIPOIN';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(inuPLDIPOIN, -1) <> NVL(rcRegistroAct.PLDIPOIN, -1) THEN
      UPDATE PLANDIFE
         SET PLDIPOIN = inuPLDIPOIN
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
  END prAcPLDIPOIN;

  -- Actualiza el valor de la columna PLDIMCCD
  PROCEDURE prAcPLDIMCCD(inuPLDICODI NUMBER, inuPLDIMCCD NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIMCCD';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(inuPLDIMCCD, -1) <> NVL(rcRegistroAct.PLDIMCCD, -1) THEN
      UPDATE PLANDIFE
         SET PLDIMCCD = inuPLDIMCCD
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
  END prAcPLDIMCCD;

  -- Actualiza el valor de la columna PLDIGECO
  PROCEDURE prAcPLDIGECO(inuPLDICODI NUMBER, isbPLDIGECO VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIGECO';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(isbPLDIGECO, '-') <> NVL(rcRegistroAct.PLDIGECO, '-') THEN
      UPDATE PLANDIFE
         SET PLDIGECO = isbPLDIGECO
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
  END prAcPLDIGECO;

  -- Actualiza el valor de la columna PLDICEMA
  PROCEDURE prAcPLDICEMA(inuPLDICODI NUMBER, inuPLDICEMA NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDICEMA';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(inuPLDICEMA, -1) <> NVL(rcRegistroAct.PLDICEMA, -1) THEN
      UPDATE PLANDIFE
         SET PLDICEMA = inuPLDICEMA
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
  END prAcPLDICEMA;

  -- Actualiza el valor de la columna PLDIDOSO
  PROCEDURE prAcPLDIDOSO(inuPLDICODI NUMBER, isbPLDIDOSO VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIDOSO';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(isbPLDIDOSO, '-') <> NVL(rcRegistroAct.PLDIDOSO, '-') THEN
      UPDATE PLANDIFE
         SET PLDIDOSO = isbPLDIDOSO
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
  END prAcPLDIDOSO;

  -- Actualiza el valor de la columna PLDISPMA
  PROCEDURE prAcPLDISPMA(inuPLDICODI NUMBER, inuPLDISPMA NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDISPMA';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(inuPLDISPMA, -1) <> NVL(rcRegistroAct.PLDISPMA, -1) THEN
      UPDATE PLANDIFE
         SET PLDISPMA = inuPLDISPMA
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
  END prAcPLDISPMA;

  -- Actualiza el valor de la columna PLDISPMI
  PROCEDURE prAcPLDISPMI(inuPLDICODI NUMBER, inuPLDISPMI NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDISPMI';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(inuPLDISPMI, -1) <> NVL(rcRegistroAct.PLDISPMI, -1) THEN
      UPDATE PLANDIFE
         SET PLDISPMI = inuPLDISPMI
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
  END prAcPLDISPMI;

  -- Actualiza el valor de la columna PLDITAIN
  PROCEDURE prAcPLDITAIN(inuPLDICODI NUMBER, inuPLDITAIN NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDITAIN';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(inuPLDITAIN, -1) <> NVL(rcRegistroAct.PLDITAIN, -1) THEN
      UPDATE PLANDIFE
         SET PLDITAIN = inuPLDITAIN
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
  END prAcPLDITAIN;

  -- Actualiza el valor de la columna PLDIFAGR
  PROCEDURE prAcPLDIFAGR(inuPLDICODI NUMBER, inuPLDIFAGR NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIFAGR';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(inuPLDIFAGR, -1) <> NVL(rcRegistroAct.PLDIFAGR, -1) THEN
      UPDATE PLANDIFE
         SET PLDIFAGR = inuPLDIFAGR
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
  END prAcPLDIFAGR;

  -- Actualiza el valor de la columna PLDICUVE
  PROCEDURE prAcPLDICUVE(inuPLDICODI NUMBER, inuPLDICUVE NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDICUVE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(inuPLDICUVE, -1) <> NVL(rcRegistroAct.PLDICUVE, -1) THEN
      UPDATE PLANDIFE
         SET PLDICUVE = inuPLDICUVE
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
  END prAcPLDICUVE;

  -- Actualiza el valor de la columna PLDINCVS
  PROCEDURE prAcPLDINCVS(inuPLDICODI NUMBER, inuPLDINCVS NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDINCVS';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(inuPLDINCVS, -1) <> NVL(rcRegistroAct.PLDINCVS, -1) THEN
      UPDATE PLANDIFE
         SET PLDINCVS = inuPLDINCVS
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
  END prAcPLDINCVS;

  -- Actualiza el valor de la columna PLDINVRE
  PROCEDURE prAcPLDINVRE(inuPLDICODI NUMBER, inuPLDINVRE NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDINVRE';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(inuPLDINVRE, -1) <> NVL(rcRegistroAct.PLDINVRE, -1) THEN
      UPDATE PLANDIFE
         SET PLDINVRE = inuPLDINVRE
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
  END prAcPLDINVRE;

  -- Actualiza el valor de la columna PLDIPMIF
  PROCEDURE prAcPLDIPMIF(inuPLDICODI NUMBER, inuPLDIPMIF NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIPMIF';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(inuPLDIPMIF, -1) <> NVL(rcRegistroAct.PLDIPMIF, -1) THEN
      UPDATE PLANDIFE
         SET PLDIPMIF = inuPLDIPMIF
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
  END prAcPLDIPMIF;

  -- Actualiza el valor de la columna PLDIPMAF
  PROCEDURE prAcPLDIPMAF(inuPLDICODI NUMBER, inuPLDIPMAF NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIPMAF';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(inuPLDIPMAF, -1) <> NVL(rcRegistroAct.PLDIPMAF, -1) THEN
      UPDATE PLANDIFE
         SET PLDIPMAF = inuPLDIPMAF
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
  END prAcPLDIPMAF;

  -- Actualiza el valor de la columna PLDIPRMO
  PROCEDURE prAcPLDIPRMO(inuPLDICODI NUMBER, inuPLDIPRMO NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIPRMO';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(inuPLDIPRMO, -1) <> NVL(rcRegistroAct.PLDIPRMO, -1) THEN
      UPDATE PLANDIFE
         SET PLDIPRMO = inuPLDIPRMO
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
  END prAcPLDIPRMO;

  -- Actualiza el valor de la columna PLDIPEGR
  PROCEDURE prAcPLDIPEGR(inuPLDICODI NUMBER, inuPLDIPEGR NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIPEGR';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(inuPLDICODI, TRUE);
    IF NVL(inuPLDIPEGR, -1) <> NVL(rcRegistroAct.PLDIPEGR, -1) THEN
      UPDATE PLANDIFE
         SET PLDIPEGR = inuPLDIPEGR
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
  END prAcPLDIPEGR;

  -- Actualiza por RowId el valor de la columna PLDIDESC
  PROCEDURE prAcPLDIDESC_RId(iRowId        ROWID,
                             isbPLDIDESC_O VARCHAR2,
                             isbPLDIDESC_N VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIDESC_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(isbPLDIDESC_O, '-') <> NVL(isbPLDIDESC_N, '-') THEN
      UPDATE PLANDIFE SET PLDIDESC = isbPLDIDESC_N WHERE Rowid = iRowId;
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
  END prAcPLDIDESC_RId;

  -- Actualiza por RowId el valor de la columna PLDIFECR
  PROCEDURE prAcPLDIFECR_RId(iRowId        ROWID,
                             idtPLDIFECR_O DATE,
                             idtPLDIFECR_N DATE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIFECR_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(idtPLDIFECR_O, TO_DATE('01/01/1900', 'dd/mm/yyyy')) <>
       NVL(idtPLDIFECR_N, TO_DATE('01/01/1900', 'dd/mm/yyyy')) THEN
      UPDATE PLANDIFE SET PLDIFECR = idtPLDIFECR_N WHERE Rowid = iRowId;
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
  END prAcPLDIFECR_RId;

  -- Actualiza por RowId el valor de la columna PLDIFEIN
  PROCEDURE prAcPLDIFEIN_RId(iRowId        ROWID,
                             idtPLDIFEIN_O DATE,
                             idtPLDIFEIN_N DATE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIFEIN_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(idtPLDIFEIN_O, TO_DATE('01/01/1900', 'dd/mm/yyyy')) <>
       NVL(idtPLDIFEIN_N, TO_DATE('01/01/1900', 'dd/mm/yyyy')) THEN
      UPDATE PLANDIFE SET PLDIFEIN = idtPLDIFEIN_N WHERE Rowid = iRowId;
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
  END prAcPLDIFEIN_RId;

  -- Actualiza por RowId el valor de la columna PLDIFEFI
  PROCEDURE prAcPLDIFEFI_RId(iRowId        ROWID,
                             idtPLDIFEFI_O DATE,
                             idtPLDIFEFI_N DATE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIFEFI_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(idtPLDIFEFI_O, TO_DATE('01/01/1900', 'dd/mm/yyyy')) <>
       NVL(idtPLDIFEFI_N, TO_DATE('01/01/1900', 'dd/mm/yyyy')) THEN
      UPDATE PLANDIFE SET PLDIFEFI = idtPLDIFEFI_N WHERE Rowid = iRowId;
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
  END prAcPLDIFEFI_RId;

  -- Actualiza por RowId el valor de la columna PLDICUMI
  PROCEDURE prAcPLDICUMI_RId(iRowId        ROWID,
                             inuPLDICUMI_O NUMBER,
                             inuPLDICUMI_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDICUMI_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPLDICUMI_O, -1) <> NVL(inuPLDICUMI_N, -1) THEN
      UPDATE PLANDIFE SET PLDICUMI = inuPLDICUMI_N WHERE Rowid = iRowId;
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
  END prAcPLDICUMI_RId;

  -- Actualiza por RowId el valor de la columna PLDICUMA
  PROCEDURE prAcPLDICUMA_RId(iRowId        ROWID,
                             inuPLDICUMA_O NUMBER,
                             inuPLDICUMA_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDICUMA_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPLDICUMA_O, -1) <> NVL(inuPLDICUMA_N, -1) THEN
      UPDATE PLANDIFE SET PLDICUMA = inuPLDICUMA_N WHERE Rowid = iRowId;
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
  END prAcPLDICUMA_RId;

  -- Actualiza por RowId el valor de la columna PLDIPOIN
  PROCEDURE prAcPLDIPOIN_RId(iRowId        ROWID,
                             inuPLDIPOIN_O NUMBER,
                             inuPLDIPOIN_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIPOIN_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPLDIPOIN_O, -1) <> NVL(inuPLDIPOIN_N, -1) THEN
      UPDATE PLANDIFE SET PLDIPOIN = inuPLDIPOIN_N WHERE Rowid = iRowId;
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
  END prAcPLDIPOIN_RId;

  -- Actualiza por RowId el valor de la columna PLDIMCCD
  PROCEDURE prAcPLDIMCCD_RId(iRowId        ROWID,
                             inuPLDIMCCD_O NUMBER,
                             inuPLDIMCCD_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIMCCD_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPLDIMCCD_O, -1) <> NVL(inuPLDIMCCD_N, -1) THEN
      UPDATE PLANDIFE SET PLDIMCCD = inuPLDIMCCD_N WHERE Rowid = iRowId;
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
  END prAcPLDIMCCD_RId;

  -- Actualiza por RowId el valor de la columna PLDIGECO
  PROCEDURE prAcPLDIGECO_RId(iRowId        ROWID,
                             isbPLDIGECO_O VARCHAR2,
                             isbPLDIGECO_N VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIGECO_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(isbPLDIGECO_O, '-') <> NVL(isbPLDIGECO_N, '-') THEN
      UPDATE PLANDIFE SET PLDIGECO = isbPLDIGECO_N WHERE Rowid = iRowId;
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
  END prAcPLDIGECO_RId;

  -- Actualiza por RowId el valor de la columna PLDICEMA
  PROCEDURE prAcPLDICEMA_RId(iRowId        ROWID,
                             inuPLDICEMA_O NUMBER,
                             inuPLDICEMA_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDICEMA_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPLDICEMA_O, -1) <> NVL(inuPLDICEMA_N, -1) THEN
      UPDATE PLANDIFE SET PLDICEMA = inuPLDICEMA_N WHERE Rowid = iRowId;
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
  END prAcPLDICEMA_RId;

  -- Actualiza por RowId el valor de la columna PLDIDOSO
  PROCEDURE prAcPLDIDOSO_RId(iRowId        ROWID,
                             isbPLDIDOSO_O VARCHAR2,
                             isbPLDIDOSO_N VARCHAR2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIDOSO_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(isbPLDIDOSO_O, '-') <> NVL(isbPLDIDOSO_N, '-') THEN
      UPDATE PLANDIFE SET PLDIDOSO = isbPLDIDOSO_N WHERE Rowid = iRowId;
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
  END prAcPLDIDOSO_RId;

  -- Actualiza por RowId el valor de la columna PLDISPMA
  PROCEDURE prAcPLDISPMA_RId(iRowId        ROWID,
                             inuPLDISPMA_O NUMBER,
                             inuPLDISPMA_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDISPMA_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPLDISPMA_O, -1) <> NVL(inuPLDISPMA_N, -1) THEN
      UPDATE PLANDIFE SET PLDISPMA = inuPLDISPMA_N WHERE Rowid = iRowId;
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
  END prAcPLDISPMA_RId;

  -- Actualiza por RowId el valor de la columna PLDISPMI
  PROCEDURE prAcPLDISPMI_RId(iRowId        ROWID,
                             inuPLDISPMI_O NUMBER,
                             inuPLDISPMI_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDISPMI_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPLDISPMI_O, -1) <> NVL(inuPLDISPMI_N, -1) THEN
      UPDATE PLANDIFE SET PLDISPMI = inuPLDISPMI_N WHERE Rowid = iRowId;
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
  END prAcPLDISPMI_RId;

  -- Actualiza por RowId el valor de la columna PLDITAIN
  PROCEDURE prAcPLDITAIN_RId(iRowId        ROWID,
                             inuPLDITAIN_O NUMBER,
                             inuPLDITAIN_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDITAIN_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPLDITAIN_O, -1) <> NVL(inuPLDITAIN_N, -1) THEN
      UPDATE PLANDIFE SET PLDITAIN = inuPLDITAIN_N WHERE Rowid = iRowId;
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
  END prAcPLDITAIN_RId;

  -- Actualiza por RowId el valor de la columna PLDIFAGR
  PROCEDURE prAcPLDIFAGR_RId(iRowId        ROWID,
                             inuPLDIFAGR_O NUMBER,
                             inuPLDIFAGR_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIFAGR_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPLDIFAGR_O, -1) <> NVL(inuPLDIFAGR_N, -1) THEN
      UPDATE PLANDIFE SET PLDIFAGR = inuPLDIFAGR_N WHERE Rowid = iRowId;
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
  END prAcPLDIFAGR_RId;

  -- Actualiza por RowId el valor de la columna PLDICUVE
  PROCEDURE prAcPLDICUVE_RId(iRowId        ROWID,
                             inuPLDICUVE_O NUMBER,
                             inuPLDICUVE_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDICUVE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPLDICUVE_O, -1) <> NVL(inuPLDICUVE_N, -1) THEN
      UPDATE PLANDIFE SET PLDICUVE = inuPLDICUVE_N WHERE Rowid = iRowId;
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
  END prAcPLDICUVE_RId;

  -- Actualiza por RowId el valor de la columna PLDINCVS
  PROCEDURE prAcPLDINCVS_RId(iRowId        ROWID,
                             inuPLDINCVS_O NUMBER,
                             inuPLDINCVS_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDINCVS_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPLDINCVS_O, -1) <> NVL(inuPLDINCVS_N, -1) THEN
      UPDATE PLANDIFE SET PLDINCVS = inuPLDINCVS_N WHERE Rowid = iRowId;
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
  END prAcPLDINCVS_RId;

  -- Actualiza por RowId el valor de la columna PLDINVRE
  PROCEDURE prAcPLDINVRE_RId(iRowId        ROWID,
                             inuPLDINVRE_O NUMBER,
                             inuPLDINVRE_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDINVRE_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPLDINVRE_O, -1) <> NVL(inuPLDINVRE_N, -1) THEN
      UPDATE PLANDIFE SET PLDINVRE = inuPLDINVRE_N WHERE Rowid = iRowId;
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
  END prAcPLDINVRE_RId;

  -- Actualiza por RowId el valor de la columna PLDIPMIF
  PROCEDURE prAcPLDIPMIF_RId(iRowId        ROWID,
                             inuPLDIPMIF_O NUMBER,
                             inuPLDIPMIF_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIPMIF_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPLDIPMIF_O, -1) <> NVL(inuPLDIPMIF_N, -1) THEN
      UPDATE PLANDIFE SET PLDIPMIF = inuPLDIPMIF_N WHERE Rowid = iRowId;
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
  END prAcPLDIPMIF_RId;

  -- Actualiza por RowId el valor de la columna PLDIPMAF
  PROCEDURE prAcPLDIPMAF_RId(iRowId        ROWID,
                             inuPLDIPMAF_O NUMBER,
                             inuPLDIPMAF_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIPMAF_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPLDIPMAF_O, -1) <> NVL(inuPLDIPMAF_N, -1) THEN
      UPDATE PLANDIFE SET PLDIPMAF = inuPLDIPMAF_N WHERE Rowid = iRowId;
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
  END prAcPLDIPMAF_RId;

  -- Actualiza por RowId el valor de la columna PLDIPRMO
  PROCEDURE prAcPLDIPRMO_RId(iRowId        ROWID,
                             inuPLDIPRMO_O NUMBER,
                             inuPLDIPRMO_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIPRMO_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPLDIPRMO_O, -1) <> NVL(inuPLDIPRMO_N, -1) THEN
      UPDATE PLANDIFE SET PLDIPRMO = inuPLDIPRMO_N WHERE Rowid = iRowId;
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
  END prAcPLDIPRMO_RId;

  -- Actualiza por RowId el valor de la columna PLDIPEGR
  PROCEDURE prAcPLDIPEGR_RId(iRowId        ROWID,
                             inuPLDIPEGR_O NUMBER,
                             inuPLDIPEGR_N NUMBER) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAcPLDIPEGR_RId';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    IF NVL(inuPLDIPEGR_O, -1) <> NVL(inuPLDIPEGR_N, -1) THEN
      UPDATE PLANDIFE SET PLDIPEGR = inuPLDIPEGR_N WHERE Rowid = iRowId;
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
  END prAcPLDIPEGR_RId;

  -- Actualiza las columnas con valor diferente al anterior
  PROCEDURE prActRegistro(ircRegistro cuPLANDIFE%ROWTYPE) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prActRegistro';
    nuError       NUMBER;
    sbError       VARCHAR2(4000);
    rcRegistroAct cuRegistroRId%ROWTYPE;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    rcRegistroAct := frcObtRegistroRId(ircRegistro.PLDICODI, TRUE);
    IF rcRegistroAct.RowId IS NOT NULL THEN
      prAcPLDIDESC_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDIDESC,
                       ircRegistro.PLDIDESC);
    
      prAcPLDIFECR_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDIFECR,
                       ircRegistro.PLDIFECR);
    
      prAcPLDIFEIN_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDIFEIN,
                       ircRegistro.PLDIFEIN);
    
      prAcPLDIFEFI_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDIFEFI,
                       ircRegistro.PLDIFEFI);
    
      prAcPLDICUMI_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDICUMI,
                       ircRegistro.PLDICUMI);
    
      prAcPLDICUMA_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDICUMA,
                       ircRegistro.PLDICUMA);
    
      prAcPLDIPOIN_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDIPOIN,
                       ircRegistro.PLDIPOIN);
    
      prAcPLDIMCCD_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDIMCCD,
                       ircRegistro.PLDIMCCD);
    
      prAcPLDIGECO_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDIGECO,
                       ircRegistro.PLDIGECO);
    
      prAcPLDICEMA_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDICEMA,
                       ircRegistro.PLDICEMA);
    
      prAcPLDIDOSO_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDIDOSO,
                       ircRegistro.PLDIDOSO);
    
      prAcPLDISPMA_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDISPMA,
                       ircRegistro.PLDISPMA);
    
      prAcPLDISPMI_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDISPMI,
                       ircRegistro.PLDISPMI);
    
      prAcPLDITAIN_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDITAIN,
                       ircRegistro.PLDITAIN);
    
      prAcPLDIFAGR_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDIFAGR,
                       ircRegistro.PLDIFAGR);
    
      prAcPLDICUVE_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDICUVE,
                       ircRegistro.PLDICUVE);
    
      prAcPLDINCVS_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDINCVS,
                       ircRegistro.PLDINCVS);
    
      prAcPLDINVRE_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDINVRE,
                       ircRegistro.PLDINVRE);
    
      prAcPLDIPMIF_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDIPMIF,
                       ircRegistro.PLDIPMIF);
    
      prAcPLDIPMAF_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDIPMAF,
                       ircRegistro.PLDIPMAF);
    
      prAcPLDIPRMO_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDIPRMO,
                       ircRegistro.PLDIPRMO);
    
      prAcPLDIPEGR_RId(rcRegistroAct.RowId,
                       rcRegistroAct.PLDIPEGR,
                       ircRegistro.PLDIPEGR);
    
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
  
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fnuObtCantidadPlandifeRepesca 
    Descripcion     : Obtiene la cantidad de diferidos repesca
					  
    Autor           : Jhon Erazo
    Fecha           : 01/04/2025 
	
    Modificaciones  :
    Autor       Fecha       	Caso        Descripcion
    jerazomvm	01/04/2025   	OSF-4155    Creacion
    ***************************************************************************/
    FUNCTION fnuObtCantidadPlandifeRepesca(isbValorParametro  parametros.valor_cadena%TYPE)
	RETURN NUMBER
    IS
        -- Nombre de este mtodo
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtCantidadPlandifeRepesca';
        
		nuError         NUMBER;
		nuCantidad		NUMBER;
        sbError         VARCHAR2(4000);    
    
        CURSOR cuCantidadDiferidos
		IS
			SELECT COUNT(1)
			FROM plandife
			WHERE NVL(pldifefi,SYSDATE) > TRUNC(SYSDATE)
			AND	pldicodi IN ((SELECT TO_NUMBER(regexp_substr(isbValorParametro,'[^|,]+', 1, LEVEL))
							  FROM DUAL A
							  CONNECT BY regexp_substr(isbValorParametro, '[^|,]+', 1, LEVEL) IS NOT NULL));
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
		
		pkg_traza.trace('isbValorParametro: ' 	|| isbValorParametro, csbNivelTraza);

        IF (cuCantidadDiferidos%ISOPEN) THEN
			CLOSE cuCantidadDiferidos;
		END IF;
		
		OPEN cuCantidadDiferidos;
		FETCH cuCantidadDiferidos INTO nuCantidad;			  
		CLOSE cuCantidadDiferidos;
		
		pkg_traza.trace('nuCantidad: ' || nuCantidad, csbNivelTraza);
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
		
		RETURN nuCantidad;
         
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
    END fnuObtCantidadPlandifeRepesca;

END pkg_PLANDIFE;
/
BEGIN
  pkg_Utilidades.prAplicarPermisos(UPPER('pkg_PLANDIFE'),
                                   UPPER('adm_person'));
END;
/
