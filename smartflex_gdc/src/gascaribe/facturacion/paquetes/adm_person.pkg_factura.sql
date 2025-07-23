create or replace PACKAGE   adm_person.pkg_factura IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : pkg_factura
    Descripcion     : pkg para la gestion y consulta de datos de la tabla factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 29-11-2023

    Parametros de Entrada
        inuFactura     codigo de la factura
        inuNumeFisc    numero fiscal
        inuConsNuau    consecutivo
        isbActuSigCon  S - si actualiza tabla consecut N - no actualiza
    Parametros de Salida
        onuError       Codigo de error.
        osbError       Mensaje de error.
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    LJLB       29-11-2023   OSF-1916    Creacion
	JSOTO	   06-12-2024	OSF-3639	Agregan funcionalidades de primer nivel de la tabla factura
  ***************************************************************************/


  FUNCTION fsbVersion RETURN VARCHAR2;
  
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF FACTURA%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuFACTURA IS SELECT * FROM FACTURA;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : OPEN
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : FACTURA
        Caso  : OSF-XXXX
        Fecha : 05/12/2024 19:37:23
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuFACTCODI    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM FACTURA tb
        WHERE
        FACTCODI = inuFACTCODI;
     
    CURSOR cuRegistroRIdLock
    (
        inuFACTCODI    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM FACTURA tb
        WHERE
        FACTCODI = inuFACTCODI
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuFACTCODI    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuFACTCODI    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuFACTCODI    NUMBER
    );
 
     
  PROCEDURE prActuNumeFiscal ( inuFactura    IN  factura.factcodi%type,
                               inuNumeFisc   IN  factura.factnufi%type,
                               inuConsNuau   IN  factura.factconf%type,
                               isbActuSigCon IN  VARCHAR2,
                               onuError      OUT NUMBER,
                               osbError      OUT VARCHAR2);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActuNumeFiscal
    Descripcion     : proceso que actualiza numero fiscal de una factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 29-11-2023

    Parametros de Entrada
        inuFactura     codigo de la factura
        inuNumeFisc    numero fiscal
        inuConsNuau    consecutivo
        isbActuSigCon  S - si actualiza tabla consecut N - no actualiza
    Parametros de Salida
        onuError       Codigo de error.
        osbError       Mensaje de error.
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    LJLB       29-11-2023   OSF-1916    Creacion
  ***************************************************************************/
  PROCEDURE prInsertaFactura
    (
        inufact     in factura.factcodi%type,
        inususc     in factura.factsusc%type,
        inupefa     in factura.factpefa%type,
        inuvaap     in factura.factvaap%type,
        idtfege     in factura.factfege%type,
        isbterm     in factura.factterm%type,
        isbusua     in factura.factusua%type,
        inuprog     in factura.factprog%type
    );
    
  PROCEDURE prActualizaFechagen ( inuFactura    IN  factura.factcodi%type,
                                  idtFechagen   IN  factura.factfege%type);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaFechagen
    Descripcion     : proceso que fecha de generacion de una factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 27-06-2024

    Parametros de Entrada
        inuFactura     codigo de la factura
        idtFechagen    fecha de generacion
    Parametros de Salida       
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    LJLB       29-11-2023   OSF-1916    Creacion
  ***************************************************************************/
  
  
      -- Obtiene el valor de la columna FACTSUSC
    FUNCTION fnuObtFACTSUSC(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTSUSC%TYPE;
 
    -- Obtiene el valor de la columna FACTPEFA
    FUNCTION fnuObtFACTPEFA(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTPEFA%TYPE;
 
    -- Obtiene el valor de la columna FACTDEPA
    FUNCTION fnuObtFACTDEPA(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTDEPA%TYPE;
 
    -- Obtiene el valor de la columna FACTLOCA
    FUNCTION fnuObtFACTLOCA(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTLOCA%TYPE;
 
    -- Obtiene el valor de la columna FACTVAAP
    FUNCTION fnuObtFACTVAAP(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTVAAP%TYPE;
 
    -- Obtiene el valor de la columna FACTFEGE
    FUNCTION fdtObtFACTFEGE(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTFEGE%TYPE;
 
    -- Obtiene el valor de la columna FACTTERM
    FUNCTION fsbObtFACTTERM(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTTERM%TYPE;
 
    -- Obtiene el valor de la columna FACTUSUA
    FUNCTION fnuObtFACTUSUA(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTUSUA%TYPE;
 
    -- Obtiene el valor de la columna FACTPROG
    FUNCTION fnuObtFACTPROG(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTPROG%TYPE;
 
    -- Obtiene el valor de la columna FACTCONS
    FUNCTION fnuObtFACTCONS(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTCONS%TYPE;
 
    -- Obtiene el valor de la columna FACTNUFI
    FUNCTION fnuObtFACTNUFI(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTNUFI%TYPE;
 
    -- Obtiene el valor de la columna FACTCONF
    FUNCTION fnuObtFACTCONF(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTCONF%TYPE;
 
    -- Obtiene el valor de la columna FACTPREF
    FUNCTION fsbObtFACTPREF(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTPREF%TYPE;
 
    -- Obtiene el valor de la columna FACTCOAE
    FUNCTION fnuObtFACTCOAE(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTCOAE%TYPE;
 
    -- Obtiene el valor de la columna FACTVCAE
    FUNCTION fdtObtFACTVCAE(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTVCAE%TYPE;
 
    -- Obtiene el valor de la columna FACTDICO
    FUNCTION fnuObtFACTDICO(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTDICO%TYPE;
 

	--Obtener la ultima factura para el contrato
	    FUNCTION fnuObtUltFacturaContrato(
        inuFactSusc    NUMBER
        ) RETURN FACTURA.FACTCODI%TYPE;
  
END pkg_factura;
/
create or replace PACKAGE BODY  adm_person.pkg_factura  IS
 -- Constantes para el control de la traza
   csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
   csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
   -- Identificador del ultimo caso que hizo cambios
   csbVersion     CONSTANT VARCHAR2(15) := 'OSF-3740';
   nuError  NUMBER;
   sbError  VARCHAR2(4000);

   FUNCTION fsbVersion RETURN VARCHAR2 IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 16-11-2023

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       16-11-2023   OSF-1916    Creacion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;
   
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuFACTCODI    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuFACTCODI);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuFACTCODI);
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
        inuFACTCODI    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.FACTCODI IS NOT NULL;
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
        inuFACTCODI    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuFACTCODI) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuFACTCODI||'] en la tabla[FACTURA]');
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
 
 
    PROCEDURE prActuNumeFiscal ( inuFactura    IN  factura.factcodi%type,
                              inuNumeFisc   IN  factura.factnufi%type,
                              inuConsNuau   IN  factura.factconf%type,
                              isbActuSigCon IN  VARCHAR2,
                              onuError      OUT NUMBER,
                              osbError      OUT VARCHAR2) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActuNumeFiscal
    Descripcion     : proceso que actualiza numero fiscal de una factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 29-11-2023

    Parametros de Entrada
        inuFactura     codigo de la factura
        inuNumeFisc    numero fiscal
        inuConsNuau    consecutivo
        isbActuSigCon  S - si actualiza tabla consecut N - no actualiza
    Parametros de Salida
        onuError       Codigo de error.
        osbError       Mensaje de error.
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    LJLB       29-11-2023   OSF-1916    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prActuNumeFiscal';
  BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
	  pkg_traza.trace(' inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' inuNumeFisc => ' || inuNumeFisc, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' inuConsNuau => ' || inuConsNuau, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' isbActuSigCon => ' || isbActuSigCon, pkg_traza.cnuNivelTrzDef);
      pkg_error.prinicializaerror(onuError, osbError);

      UPDATE factura SET factnufi = inuNumeFisc,
                          factconf = inuConsNuau
      WHERE factcodi = inuFactura;

      IF isbActuSigCon = 'S' THEN
        UPDATE consecut SET consnume = inuNumeFisc + 1
        WHERE conscodi = inuConsNuau;
      END IF;

      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prActuNumeFiscal;
  
  PROCEDURE prInsertaFactura (  inufact     in factura.factcodi%type,
                                inususc     in factura.factsusc%type,
                                inupefa     in factura.factpefa%type,
                                inuvaap     in factura.factvaap%type,
                                idtfege     in factura.factfege%type,
                                isbterm     in factura.factterm%type,
                                isbusua     in factura.factusua%type,
                                inuprog     in factura.factprog%type ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertaFactura
    Descripción     : Inserta registro en factura

    Autor           : jcatuche
    Fecha           : 15-05-2024

    Parametros de Entrada
        inufact     identificador de la factura
        inususc     identificador del contrato
        inupefa     identificador del periodo
        inuvaap     valor aprobado
        idtfege     fecha de generación
        isbterm     terminal
        isbusua     usuario que inserta
        inuprog     programa que inserta
    Parametros de Salida
        NA
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripción
    jcatuche    15-05-2024  OSF-2467    Creación
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prInsertaFactura';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   
    pkg_traza.trace('inufact <= ' || inufact, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inususc <= ' || inususc, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inupefa <= ' || inupefa, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuvaap <= ' || inuvaap, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('idtfege <= ' || idtfege, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('isbterm <= ' || isbterm, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('isbusua <= ' || isbusua, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuprog <= ' || inuprog, pkg_traza.cnuNivelTrzDef);
    
    insert into factura
    ( 
        factcodi, 
        factsusc,
        factpefa,
        factvaap,
        factfege,
        factterm,
        factusua,
        factprog
    ) 
    values 
    (
        inufact,
        inususc,
        inupefa,
        inuvaap,
        idtfege,
        isbterm,
        isbusua,
        inuprog
    );
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   
    
  EXCEPTION    
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_error.CONTROLLED_ERROR; 
  END prInsertaFactura;

  PROCEDURE prActualizaFechagen ( inuFactura    IN  factura.factcodi%type,
                                  idtFechagen   IN  factura.factfege%type) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaFechagen
    Descripcion     : proceso que fecha de generacion de una factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 27-06-2024

    Parametros de Entrada
        inuFactura     codigo de la factura
        idtFechagen    fecha de generacion
    Parametros de Salida       
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    LJLB       27-06-2024   OSF-2913    Creacion
  ***************************************************************************/
   csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prActualizaFechagen';


  BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
	  pkg_traza.trace(' inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' idtFechagen => ' || idtFechagen, pkg_traza.cnuNivelTrzDef);
      UPDATE factura SET factfege = SYSDATE WHERE factcodi = inuFactura;
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_error.CONTROLLED_ERROR;
 END prActualizaFechagen;
 
 
     -- Obtiene el valor de la columna FACTSUSC
    FUNCTION fnuObtFACTSUSC(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTSUSC%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFACTSUSC';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTSUSC;
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
    END fnuObtFACTSUSC;
 
    -- Obtiene el valor de la columna FACTPEFA
    FUNCTION fnuObtFACTPEFA(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTPEFA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFACTPEFA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTPEFA;
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
    END fnuObtFACTPEFA;
 
    -- Obtiene el valor de la columna FACTDEPA
    FUNCTION fnuObtFACTDEPA(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTDEPA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFACTDEPA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTDEPA;
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
    END fnuObtFACTDEPA;
 
    -- Obtiene el valor de la columna FACTLOCA
    FUNCTION fnuObtFACTLOCA(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTLOCA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFACTLOCA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTLOCA;
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
    END fnuObtFACTLOCA;
 
    -- Obtiene el valor de la columna FACTVAAP
    FUNCTION fnuObtFACTVAAP(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTVAAP%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFACTVAAP';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTVAAP;
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
    END fnuObtFACTVAAP;
 
    -- Obtiene el valor de la columna FACTFEGE
    FUNCTION fdtObtFACTFEGE(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTFEGE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFACTFEGE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTFEGE;
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
    END fdtObtFACTFEGE;
 
    -- Obtiene el valor de la columna FACTTERM
    FUNCTION fsbObtFACTTERM(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTTERM%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtFACTTERM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTTERM;
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
    END fsbObtFACTTERM;
 
    -- Obtiene el valor de la columna FACTUSUA
    FUNCTION fnuObtFACTUSUA(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTUSUA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFACTUSUA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTUSUA;
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
    END fnuObtFACTUSUA;
 
    -- Obtiene el valor de la columna FACTPROG
    FUNCTION fnuObtFACTPROG(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTPROG%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFACTPROG';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTPROG;
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
    END fnuObtFACTPROG;
 
    -- Obtiene el valor de la columna FACTCONS
    FUNCTION fnuObtFACTCONS(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTCONS%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFACTCONS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTCONS;
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
    END fnuObtFACTCONS;
 
    -- Obtiene el valor de la columna FACTNUFI
    FUNCTION fnuObtFACTNUFI(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTNUFI%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFACTNUFI';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTNUFI;
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
    END fnuObtFACTNUFI;
 
    -- Obtiene el valor de la columna FACTCONF
    FUNCTION fnuObtFACTCONF(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTCONF%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFACTCONF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTCONF;
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
    END fnuObtFACTCONF;
 
    -- Obtiene el valor de la columna FACTPREF
    FUNCTION fsbObtFACTPREF(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTPREF%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtFACTPREF';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTPREF;
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
    END fsbObtFACTPREF;
 
    -- Obtiene el valor de la columna FACTCOAE
    FUNCTION fnuObtFACTCOAE(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTCOAE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFACTCOAE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTCOAE;
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
    END fnuObtFACTCOAE;
 
    -- Obtiene el valor de la columna FACTVCAE
    FUNCTION fdtObtFACTVCAE(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTVCAE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFACTVCAE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTVCAE;
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
    END fdtObtFACTVCAE;
 
    -- Obtiene el valor de la columna FACTDICO
    FUNCTION fnuObtFACTDICO(
        inuFACTCODI    NUMBER
        ) RETURN FACTURA.FACTDICO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFACTDICO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuFACTCODI);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FACTDICO;
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
    END fnuObtFACTDICO;
 
 	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtUltFacturaContrato 
    Descripcion     : Obtiene ultima factura para un contrato
    Autor           : jsoto
    Fecha           : 06/12/2024
	
	Parametros de entrada
		inuFactSusc   Id de contrato
	
	Parametros de salida
	
			
    Modificaciones  :
    Autor       Fecha       Caso        Descripción
    jsoto	    06-12-2024  OSF-3740    Creación
    ***************************************************************************/   

	-- Obtiene la ultima factura de acuerdo a la fecha de generación para el contrato 
	FUNCTION fnuObtUltFacturaContrato(
										inuFactSusc    NUMBER
									 ) RETURN FACTURA.FACTCODI%TYPE
	IS
	    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtUltFacturaContrato';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
		nuFactCodi		NUMBER :=NULL;
		
		CURSOR cuUltimaFactura IS
		SELECT  FACTCODI
            FROM    FACTURA
            WHERE   FACTSUSC = inuFactSusc
            ORDER BY FACTFEGE DESC;
			
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

		IF cuUltimaFactura%ISOPEN THEN  
			CLOSE cuUltimaFactura;
		END IF;        

		OPEN cuUltimaFactura;
		FETCH cuUltimaFactura INTO nuFactCodi;
		CLOSE cuUltimaFactura;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN nuFactCodi;
		
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RETURN nuFactCodi;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RETURN nuFactCodi;
    END fnuObtUltFacturaContrato;
	
 
END pkg_factura;
/
PROMPT Otorgando permisos de ejecucion a PKG_FACTURA
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_FACTURA','ADM_PERSON');
END;
/