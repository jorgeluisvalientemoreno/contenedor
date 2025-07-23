create or replace PACKAGE  adm_person.pkg_cuencobr IS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : adm_person.pkg_cuencobr
    Descripción    : Paquete de primer nivel para gestión de cuentas de cobro
    Autor          : jcatuche
    Fecha          : 15/05/2024

    Fecha           Autor               Modificación
    =========       =========           ====================
	15-05-2024      jcatuche            OSF-2467: Creación
	27/12/2024      jcatuche            OSF-3810: Se crean procedimientos de consulta y actualización para 
                                        los campos de la tala cuencobr.
    23/04/2025      felipe.valencia     OSF-4294: Se crea el tipo tytbcucofact
******************************************************************/
    subtype styRegistro   is  cuencobr%rowtype; 

    TYPE tytbcucofact IS TABLE OF cuencobr.cucofact%type INDEX BY binary_integer;
    
    CURSOR cuRegistroRId
    (
        inuCUCOCODI    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM cuencobr tb
        WHERE
        CUCOCODI = inuCUCOCODI;
     
    CURSOR cuRegistroRIdLock
    (
        inuCUCOCODI    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM cuencobr tb
        WHERE
        CUCOCODI = inuCUCOCODI
        FOR UPDATE NOWAIT;
    
    PROCEDURE prInsertaCuenta
    (
        inucuco in cuencobr.cucocodi%type,
        inuplsu in cuencobr.cucoplsu%type,
        inucate in cuencobr.cucocate%type,
        inusuca in cuencobr.cucosuca%type,
        inuvare in cuencobr.cucovare%type,
        inuvaab in cuencobr.cucovaab%type,
        inuvato in cuencobr.cucovato%type,
        inunuse in cuencobr.cuconuse%type,
        inufact in cuencobr.cucofact%type,
        inufeve in cuencobr.cucofeve%type,
        inuvafa in cuencobr.cucovafa%type,
        inuimfa in cuencobr.cucoimfa%type
    );
    
    PROCEDURE prActualizaFechaVenc( inuFactura   IN cuencobr.cucofact%type,
                                    idtFechaVenc IN cuencobr.cucofeve%type);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaFechaVenc
    Descripcion     : proceso que actualiza fecha de vencimiento de cuentas  de una factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 27-06-2024

    Parametros de Entrada
        inuFactura     codigo de la factura
        idtFechaVenc    fecha de vencimiento
    Parametros de Salida       
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    LJLB       29-11-2023   OSF-1916    Creacion
  ***************************************************************************/
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuCUCOCODI    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
    
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuCUCOCODI    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuCUCOCODI    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro IN styRegistro);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuCUCOCODI    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna CUCODEPA
    FUNCTION fnuObtCUCODEPA(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCODEPA%TYPE;
 
    -- Obtiene el valor de la columna CUCOLOCA
    FUNCTION fnuObtCUCOLOCA(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOLOCA%TYPE;
 
    -- Obtiene el valor de la columna CUCOPLSU
    FUNCTION fnuObtCUCOPLSU(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOPLSU%TYPE;
 
    -- Obtiene el valor de la columna CUCOCATE
    FUNCTION fnuObtCUCOCATE(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOCATE%TYPE;
 
    -- Obtiene el valor de la columna CUCOSUCA
    FUNCTION fnuObtCUCOSUCA(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOSUCA%TYPE;
 
    -- Obtiene el valor de la columna CUCOVAAP
    FUNCTION fnuObtCUCOVAAP(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOVAAP%TYPE;
 
    -- Obtiene el valor de la columna CUCOVARE
    FUNCTION fnuObtCUCOVARE(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOVARE%TYPE;
 
    -- Obtiene el valor de la columna CUCOVAAB
    FUNCTION fnuObtCUCOVAAB(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOVAAB%TYPE;
 
    -- Obtiene el valor de la columna CUCOVATO
    FUNCTION fnuObtCUCOVATO(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOVATO%TYPE;
 
    -- Obtiene el valor de la columna CUCOFEPA
    FUNCTION fdtObtCUCOFEPA(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOFEPA%TYPE;
 
    -- Obtiene el valor de la columna CUCONUSE
    FUNCTION fnuObtCUCONUSE(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCONUSE%TYPE;
 
    -- Obtiene el valor de la columna CUCOSACU
    FUNCTION fnuObtCUCOSACU(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOSACU%TYPE;
 
    -- Obtiene el valor de la columna CUCOVRAP
    FUNCTION fnuObtCUCOVRAP(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOVRAP%TYPE;
 
    -- Obtiene el valor de la columna CUCOFACT
    FUNCTION fnuObtCUCOFACT(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOFACT%TYPE;
 
    -- Obtiene el valor de la columna CUCOFAAG
    FUNCTION fnuObtCUCOFAAG(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOFAAG%TYPE;
 
    -- Obtiene el valor de la columna CUCOFEVE
    FUNCTION fdtObtCUCOFEVE(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOFEVE%TYPE;
 
    -- Obtiene el valor de la columna CUCOVAFA
    FUNCTION fnuObtCUCOVAFA(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOVAFA%TYPE;
 
    -- Obtiene el valor de la columna CUCOSIST
    FUNCTION fnuObtCUCOSIST(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOSIST%TYPE;
 
    -- Obtiene el valor de la columna CUCOGRIM
    FUNCTION fnuObtCUCOGRIM(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOGRIM%TYPE;
 
    -- Obtiene el valor de la columna CUCOIMFA
    FUNCTION fnuObtCUCOIMFA(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOIMFA%TYPE;
 
    -- Obtiene el valor de la columna CUCODIIN
    FUNCTION fnuObtCUCODIIN(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCODIIN%TYPE;
 
    -- Actualiza el valor de la columna CUCODEPA
    PROCEDURE prAcCUCODEPA(
        inuCUCOCODI    NUMBER,
        inuCUCODEPA    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOLOCA
    PROCEDURE prAcCUCOLOCA(
        inuCUCOCODI    NUMBER,
        inuCUCOLOCA    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOPLSU
    PROCEDURE prAcCUCOPLSU(
        inuCUCOCODI    NUMBER,
        inuCUCOPLSU    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOCATE
    PROCEDURE prAcCUCOCATE(
        inuCUCOCODI    NUMBER,
        inuCUCOCATE    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOSUCA
    PROCEDURE prAcCUCOSUCA(
        inuCUCOCODI    NUMBER,
        inuCUCOSUCA    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOVAAP
    PROCEDURE prAcCUCOVAAP(
        inuCUCOCODI    NUMBER,
        inuCUCOVAAP    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOVARE
    PROCEDURE prAcCUCOVARE(
        inuCUCOCODI    NUMBER,
        inuCUCOVARE    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOVAAB
    PROCEDURE prAcCUCOVAAB(
        inuCUCOCODI    NUMBER,
        inuCUCOVAAB    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOVATO
    PROCEDURE prAcCUCOVATO(
        inuCUCOCODI    NUMBER,
        inuCUCOVATO    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOFEPA
    PROCEDURE prAcCUCOFEPA(
        inuCUCOCODI    NUMBER,
        idtCUCOFEPA    DATE
    );
 
    -- Actualiza el valor de la columna CUCONUSE
    PROCEDURE prAcCUCONUSE(
        inuCUCOCODI    NUMBER,
        inuCUCONUSE    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOSACU
    PROCEDURE prAcCUCOSACU(
        inuCUCOCODI    NUMBER,
        inuCUCOSACU    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOVRAP
    PROCEDURE prAcCUCOVRAP(
        inuCUCOCODI    NUMBER,
        inuCUCOVRAP    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOFACT
    PROCEDURE prAcCUCOFACT(
        inuCUCOCODI    NUMBER,
        inuCUCOFACT    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOFAAG
    PROCEDURE prAcCUCOFAAG(
        inuCUCOCODI    NUMBER,
        inuCUCOFAAG    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOFEVE
    PROCEDURE prAcCUCOFEVE(
        inuCUCOCODI    NUMBER,
        idtCUCOFEVE    DATE
    );
 
    -- Actualiza el valor de la columna CUCOVAFA
    PROCEDURE prAcCUCOVAFA(
        inuCUCOCODI    NUMBER,
        inuCUCOVAFA    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOSIST
    PROCEDURE prAcCUCOSIST(
        inuCUCOCODI    NUMBER,
        inuCUCOSIST    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOGRIM
    PROCEDURE prAcCUCOGRIM(
        inuCUCOCODI    NUMBER,
        inuCUCOGRIM    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCOIMFA
    PROCEDURE prAcCUCOIMFA(
        inuCUCOCODI    NUMBER,
        inuCUCOIMFA    NUMBER
    );
 
    -- Actualiza el valor de la columna CUCODIIN
    PROCEDURE prAcCUCODIIN(
        inuCUCOCODI    NUMBER,
        inuCUCODIIN    NUMBER
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro IN styRegistro);

END pkg_cuencobr;
/
create or replace PACKAGE  BODY adm_person.pkg_cuencobr IS
    -- Constantes para el control de la traza
    csbSP_NAME          CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';           -- Constante para nombre de función
    cnuNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función.
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado

    --Variables generales
    sberror             VARCHAR2(4000);
    nuerror             NUMBER;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertaCuenta
    Descripcion     : Inserta registro en cuencobr

    Autor           : jcatuche
    Fecha           : 15-05-2024

    Parametros de Entrada
        inucuco     identificador de la cuenta
        inuplsu     identificador del plan
        inucate     identificador de la categoría
        inusuca     identificador de la subcategoría
        inuvare     valor en reclamo
        inuvaab     valor abonado
        inuvato     valor total
        inunuse     identificador del producto
        inufact     identificador de la factura
        inufeve     fecha de vencimiento
        inuvafa     valor facturado
        inuimfa     valor impuestos



    Parametros de Salida
        NA
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripción
    jcatuche    15-05-2024  OSF-2467    Creación
  ***************************************************************************/
    PROCEDURE prInsertaCuenta
    (
        inucuco in cuencobr.cucocodi%type,
        inuplsu in cuencobr.cucoplsu%type,
        inucate in cuencobr.cucocate%type,
        inusuca in cuencobr.cucosuca%type,
        inuvare in cuencobr.cucovare%type,
        inuvaab in cuencobr.cucovaab%type,
        inuvato in cuencobr.cucovato%type,
        inunuse in cuencobr.cuconuse%type,
        inufact in cuencobr.cucofact%type,
        inufeve in cuencobr.cucofeve%type,
        inuvafa in cuencobr.cucovafa%type,
        inuimfa in cuencobr.cucoimfa%type
    ) IS
        csbMT_NAME   CONSTANT VARCHAR2(100) := csbSP_NAME||'prInsertaCuenta';
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);

        insert into cuencobr
        (
            cucocodi,
            cucoplsu,
            cucocate,
            cucosuca,
            cucovare,
            cucovaab,
            cucovato,
            cuconuse,
            cucofact,
            cucofeve,
            cucovafa,
            cucoimfa
        )
        values
        (
            inucuco,
            inuplsu,
            inucate,
            inusuca,
            inuvare,
            inuvaab,
            inuvato,
            inunuse,
            inufact,
            inufeve,
            inuvafa,
            inuimfa
        );

        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError: ' || sbError, cnuNivelTraza);
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError: ' || sbError, cnuNivelTraza);
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prInsertaCuenta;
    
    PROCEDURE prActualizaFechaVenc( inuFactura   IN cuencobr.cucofact%type,
                                    idtFechaVenc IN cuencobr.cucofeve%type) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaFechaVenc
    Descripcion     : proceso que actualiza fecha de vencimiento de cuentas  de una factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 27-06-2024

    Parametros de Entrada
        inuFactura     codigo de la factura
        idtFechaVenc    fecha de vencimiento
    Parametros de Salida       
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    LJLB       27-06-2024   OSF-2913     Creacion
  ***************************************************************************/
    csbMT_NAME   CONSTANT VARCHAR2(100) := csbSP_NAME||'prActualizaFechaVenc';
  BEGIN
     pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
     pkg_traza.trace(' inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
     pkg_traza.trace(' idtFechaVenc => ' || idtFechaVenc, pkg_traza.cnuNivelTrzDef);
     UPDATE cuencobr SET cucofeve = idtFechaVenc WHERE cucofact = inuFactura;
     pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
  EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace(' sbError: ' || sbError,cnuNivelTraza);
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace(' sbError: ' || sbError, cnuNivelTraza);
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
        RAISE pkg_Error.Controlled_Error;
  END prActualizaFechaVenc;
  
  -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuCUCOCODI    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuCUCOCODI);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuCUCOCODI);
            FETCH cuRegistroRId INTO rcRegistroRId;
            CLOSE cuRegistroRId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroRId;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END frcObtRegistroRId;
 
    -- Retorna verdadero si el registro existe
    FUNCTION fblExiste(
        inuCUCOCODI    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroRId := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroRId.CUCOCODI IS NOT NULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fblExiste;
 
    -- Eleva error si el registro no existe
    PROCEDURE prValExiste(
        inuCUCOCODI    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NOT fblExiste(inuCUCOCODI) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuCUCOCODI||'] en la tabla[cuencobr]');
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prValExiste;
 
    -- Inserta un registro
    PROCEDURE prInsRegistro( ircRegistro IN styRegistro) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        INSERT INTO cuencobr(
            CUCOCODI,CUCODEPA,CUCOLOCA,CUCOPLSU,CUCOCATE,CUCOSUCA,CUCOVAAP,CUCOVARE,CUCOVAAB,CUCOVATO,CUCOFEPA,CUCONUSE,CUCOSACU,CUCOVRAP,CUCOFACT,CUCOFAAG,CUCOFEVE,CUCOVAFA,CUCOSIST,CUCOGRIM,CUCOIMFA,CUCODIIN
        )
        VALUES (
            ircRegistro.CUCOCODI,ircRegistro.CUCODEPA,ircRegistro.CUCOLOCA,ircRegistro.CUCOPLSU,ircRegistro.CUCOCATE,ircRegistro.CUCOSUCA,ircRegistro.CUCOVAAP,ircRegistro.CUCOVARE,ircRegistro.CUCOVAAB,ircRegistro.CUCOVATO,ircRegistro.CUCOFEPA,ircRegistro.CUCONUSE,ircRegistro.CUCOSACU,ircRegistro.CUCOVRAP,ircRegistro.CUCOFACT,ircRegistro.CUCOFAAG,ircRegistro.CUCOFEVE,ircRegistro.CUCOVAFA,ircRegistro.CUCOSIST,ircRegistro.CUCOGRIM,ircRegistro.CUCOIMFA,ircRegistro.CUCODIIN
        );
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prInsRegistro;
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuCUCOCODI    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE cuencobr
            WHERE 
            ROWID = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
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
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF iRowId IS NOT NULL THEN
            DELETE cuencobr
            WHERE RowId = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prBorRegistroxRowId;
 
    -- Obtiene el valor de la columna CUCODEPA
    FUNCTION fnuObtCUCODEPA(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCODEPA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCODEPA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCODEPA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCODEPA;
 
    -- Obtiene el valor de la columna CUCOLOCA
    FUNCTION fnuObtCUCOLOCA(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOLOCA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCOLOCA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOLOCA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCOLOCA;
 
    -- Obtiene el valor de la columna CUCOPLSU
    FUNCTION fnuObtCUCOPLSU(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOPLSU%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCOPLSU';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOPLSU;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCOPLSU;
 
    -- Obtiene el valor de la columna CUCOCATE
    FUNCTION fnuObtCUCOCATE(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOCATE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCOCATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOCATE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCOCATE;
 
    -- Obtiene el valor de la columna CUCOSUCA
    FUNCTION fnuObtCUCOSUCA(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOSUCA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCOSUCA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOSUCA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCOSUCA;
 
    -- Obtiene el valor de la columna CUCOVAAP
    FUNCTION fnuObtCUCOVAAP(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOVAAP%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCOVAAP';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOVAAP;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCOVAAP;
 
    -- Obtiene el valor de la columna CUCOVARE
    FUNCTION fnuObtCUCOVARE(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOVARE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCOVARE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOVARE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCOVARE;
 
    -- Obtiene el valor de la columna CUCOVAAB
    FUNCTION fnuObtCUCOVAAB(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOVAAB%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCOVAAB';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOVAAB;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCOVAAB;
 
    -- Obtiene el valor de la columna CUCOVATO
    FUNCTION fnuObtCUCOVATO(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOVATO%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCOVATO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOVATO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCOVATO;
 
    -- Obtiene el valor de la columna CUCOFEPA
    FUNCTION fdtObtCUCOFEPA(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOFEPA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtCUCOFEPA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOFEPA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtCUCOFEPA;
 
    -- Obtiene el valor de la columna CUCONUSE
    FUNCTION fnuObtCUCONUSE(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCONUSE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCONUSE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCONUSE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCONUSE;
 
    -- Obtiene el valor de la columna CUCOSACU
    FUNCTION fnuObtCUCOSACU(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOSACU%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCOSACU';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOSACU;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCOSACU;
 
    -- Obtiene el valor de la columna CUCOVRAP
    FUNCTION fnuObtCUCOVRAP(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOVRAP%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCOVRAP';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOVRAP;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCOVRAP;
 
    -- Obtiene el valor de la columna CUCOFACT
    FUNCTION fnuObtCUCOFACT(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOFACT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCOFACT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOFACT;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCOFACT;
 
    -- Obtiene el valor de la columna CUCOFAAG
    FUNCTION fnuObtCUCOFAAG(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOFAAG%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCOFAAG';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOFAAG;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCOFAAG;
 
    -- Obtiene el valor de la columna CUCOFEVE
    FUNCTION fdtObtCUCOFEVE(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOFEVE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtCUCOFEVE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOFEVE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtCUCOFEVE;
 
    -- Obtiene el valor de la columna CUCOVAFA
    FUNCTION fnuObtCUCOVAFA(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOVAFA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCOVAFA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOVAFA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCOVAFA;
 
    -- Obtiene el valor de la columna CUCOSIST
    FUNCTION fnuObtCUCOSIST(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOSIST%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCOSIST';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOSIST;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCOSIST;
 
    -- Obtiene el valor de la columna CUCOGRIM
    FUNCTION fnuObtCUCOGRIM(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOGRIM%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCOGRIM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOGRIM;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCOGRIM;
 
    -- Obtiene el valor de la columna CUCOIMFA
    FUNCTION fnuObtCUCOIMFA(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCOIMFA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCOIMFA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCOIMFA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCOIMFA;
 
    -- Obtiene el valor de la columna CUCODIIN
    FUNCTION fnuObtCUCODIIN(
        inuCUCOCODI    NUMBER
        ) RETURN cuencobr.CUCODIIN%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCUCODIIN';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI);
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        RETURN rcRegistroAct.CUCODIIN;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCUCODIIN;
 
    -- Actualiza el valor de la columna CUCODEPA
    PROCEDURE prAcCUCODEPA(
        inuCUCOCODI    NUMBER,
        inuCUCODEPA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCODEPA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCODEPA,-1) <> NVL(rcRegistroAct.CUCODEPA,-1) THEN
            UPDATE cuencobr
            SET CUCODEPA=inuCUCODEPA
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCODEPA;
 
    -- Actualiza el valor de la columna CUCOLOCA
    PROCEDURE prAcCUCOLOCA(
        inuCUCOCODI    NUMBER,
        inuCUCOLOCA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOLOCA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCOLOCA,-1) <> NVL(rcRegistroAct.CUCOLOCA,-1) THEN
            UPDATE cuencobr
            SET CUCOLOCA=inuCUCOLOCA
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOLOCA;
 
    -- Actualiza el valor de la columna CUCOPLSU
    PROCEDURE prAcCUCOPLSU(
        inuCUCOCODI    NUMBER,
        inuCUCOPLSU    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOPLSU';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCOPLSU,-1) <> NVL(rcRegistroAct.CUCOPLSU,-1) THEN
            UPDATE cuencobr
            SET CUCOPLSU=inuCUCOPLSU
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOPLSU;
 
    -- Actualiza el valor de la columna CUCOCATE
    PROCEDURE prAcCUCOCATE(
        inuCUCOCODI    NUMBER,
        inuCUCOCATE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOCATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCOCATE,-1) <> NVL(rcRegistroAct.CUCOCATE,-1) THEN
            UPDATE cuencobr
            SET CUCOCATE=inuCUCOCATE
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOCATE;
 
    -- Actualiza el valor de la columna CUCOSUCA
    PROCEDURE prAcCUCOSUCA(
        inuCUCOCODI    NUMBER,
        inuCUCOSUCA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOSUCA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCOSUCA,-1) <> NVL(rcRegistroAct.CUCOSUCA,-1) THEN
            UPDATE cuencobr
            SET CUCOSUCA=inuCUCOSUCA
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOSUCA;
 
    -- Actualiza el valor de la columna CUCOVAAP
    PROCEDURE prAcCUCOVAAP(
        inuCUCOCODI    NUMBER,
        inuCUCOVAAP    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOVAAP';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCOVAAP,-1) <> NVL(rcRegistroAct.CUCOVAAP,-1) THEN
            UPDATE cuencobr
            SET CUCOVAAP=inuCUCOVAAP
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOVAAP;
 
    -- Actualiza el valor de la columna CUCOVARE
    PROCEDURE prAcCUCOVARE(
        inuCUCOCODI    NUMBER,
        inuCUCOVARE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOVARE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCOVARE,-1) <> NVL(rcRegistroAct.CUCOVARE,-1) THEN
            UPDATE cuencobr
            SET CUCOVARE=inuCUCOVARE
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOVARE;
 
    -- Actualiza el valor de la columna CUCOVAAB
    PROCEDURE prAcCUCOVAAB(
        inuCUCOCODI    NUMBER,
        inuCUCOVAAB    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOVAAB';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCOVAAB,-1) <> NVL(rcRegistroAct.CUCOVAAB,-1) THEN
            UPDATE cuencobr
            SET CUCOVAAB=inuCUCOVAAB
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOVAAB;
 
    -- Actualiza el valor de la columna CUCOVATO
    PROCEDURE prAcCUCOVATO(
        inuCUCOCODI    NUMBER,
        inuCUCOVATO    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOVATO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCOVATO,-1) <> NVL(rcRegistroAct.CUCOVATO,-1) THEN
            UPDATE cuencobr
            SET CUCOVATO=inuCUCOVATO
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOVATO;
 
    -- Actualiza el valor de la columna CUCOFEPA
    PROCEDURE prAcCUCOFEPA(
        inuCUCOCODI    NUMBER,
        idtCUCOFEPA    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOFEPA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(idtCUCOFEPA,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.CUCOFEPA,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE cuencobr
            SET CUCOFEPA=idtCUCOFEPA
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOFEPA;
 
    -- Actualiza el valor de la columna CUCONUSE
    PROCEDURE prAcCUCONUSE(
        inuCUCOCODI    NUMBER,
        inuCUCONUSE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCONUSE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCONUSE,-1) <> NVL(rcRegistroAct.CUCONUSE,-1) THEN
            UPDATE cuencobr
            SET CUCONUSE=inuCUCONUSE
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCONUSE;
 
    -- Actualiza el valor de la columna CUCOSACU
    PROCEDURE prAcCUCOSACU(
        inuCUCOCODI    NUMBER,
        inuCUCOSACU    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOSACU';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCOSACU,-1) <> NVL(rcRegistroAct.CUCOSACU,-1) THEN
            UPDATE cuencobr
            SET CUCOSACU=inuCUCOSACU
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOSACU;
 
    -- Actualiza el valor de la columna CUCOVRAP
    PROCEDURE prAcCUCOVRAP(
        inuCUCOCODI    NUMBER,
        inuCUCOVRAP    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOVRAP';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCOVRAP,-1) <> NVL(rcRegistroAct.CUCOVRAP,-1) THEN
            UPDATE cuencobr
            SET CUCOVRAP=inuCUCOVRAP
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOVRAP;
 
    -- Actualiza el valor de la columna CUCOFACT
    PROCEDURE prAcCUCOFACT(
        inuCUCOCODI    NUMBER,
        inuCUCOFACT    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOFACT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCOFACT,-1) <> NVL(rcRegistroAct.CUCOFACT,-1) THEN
            UPDATE cuencobr
            SET CUCOFACT=inuCUCOFACT
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOFACT;
 
    -- Actualiza el valor de la columna CUCOFAAG
    PROCEDURE prAcCUCOFAAG(
        inuCUCOCODI    NUMBER,
        inuCUCOFAAG    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOFAAG';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCOFAAG,-1) <> NVL(rcRegistroAct.CUCOFAAG,-1) THEN
            UPDATE cuencobr
            SET CUCOFAAG=inuCUCOFAAG
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOFAAG;
 
    -- Actualiza el valor de la columna CUCOFEVE
    PROCEDURE prAcCUCOFEVE(
        inuCUCOCODI    NUMBER,
        idtCUCOFEVE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOFEVE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(idtCUCOFEVE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.CUCOFEVE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE cuencobr
            SET CUCOFEVE=idtCUCOFEVE
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOFEVE;
 
    -- Actualiza el valor de la columna CUCOVAFA
    PROCEDURE prAcCUCOVAFA(
        inuCUCOCODI    NUMBER,
        inuCUCOVAFA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOVAFA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCOVAFA,-1) <> NVL(rcRegistroAct.CUCOVAFA,-1) THEN
            UPDATE cuencobr
            SET CUCOVAFA=inuCUCOVAFA
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOVAFA;
 
    -- Actualiza el valor de la columna CUCOSIST
    PROCEDURE prAcCUCOSIST(
        inuCUCOCODI    NUMBER,
        inuCUCOSIST    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOSIST';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCOSIST,-1) <> NVL(rcRegistroAct.CUCOSIST,-1) THEN
            UPDATE cuencobr
            SET CUCOSIST=inuCUCOSIST
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOSIST;
 
    -- Actualiza el valor de la columna CUCOGRIM
    PROCEDURE prAcCUCOGRIM(
        inuCUCOCODI    NUMBER,
        inuCUCOGRIM    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOGRIM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCOGRIM,-1) <> NVL(rcRegistroAct.CUCOGRIM,-1) THEN
            UPDATE cuencobr
            SET CUCOGRIM=inuCUCOGRIM
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOGRIM;
 
    -- Actualiza el valor de la columna CUCOIMFA
    PROCEDURE prAcCUCOIMFA(
        inuCUCOCODI    NUMBER,
        inuCUCOIMFA    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOIMFA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCOIMFA,-1) <> NVL(rcRegistroAct.CUCOIMFA,-1) THEN
            UPDATE cuencobr
            SET CUCOIMFA=inuCUCOIMFA
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOIMFA;
 
    -- Actualiza el valor de la columna CUCODIIN
    PROCEDURE prAcCUCODIIN(
        inuCUCOCODI    NUMBER,
        inuCUCODIIN    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCODIIN';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(inuCUCOCODI,TRUE);
        IF NVL(inuCUCODIIN,-1) <> NVL(rcRegistroAct.CUCODIIN,-1) THEN
            UPDATE cuencobr
            SET CUCODIIN=inuCUCODIIN
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCODIIN;
 
    -- Actualiza por RowId el valor de la columna CUCODEPA
    PROCEDURE prAcCUCODEPA_RId(
        iRowId ROWID,
        inuCUCODEPA_O    NUMBER,
        inuCUCODEPA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCODEPA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCODEPA_O,-1) <> NVL(inuCUCODEPA_N,-1) THEN
            UPDATE cuencobr
            SET CUCODEPA=inuCUCODEPA_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCODEPA_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOLOCA
    PROCEDURE prAcCUCOLOCA_RId(
        iRowId ROWID,
        inuCUCOLOCA_O    NUMBER,
        inuCUCOLOCA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOLOCA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCOLOCA_O,-1) <> NVL(inuCUCOLOCA_N,-1) THEN
            UPDATE cuencobr
            SET CUCOLOCA=inuCUCOLOCA_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOLOCA_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOPLSU
    PROCEDURE prAcCUCOPLSU_RId(
        iRowId ROWID,
        inuCUCOPLSU_O    NUMBER,
        inuCUCOPLSU_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOPLSU_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCOPLSU_O,-1) <> NVL(inuCUCOPLSU_N,-1) THEN
            UPDATE cuencobr
            SET CUCOPLSU=inuCUCOPLSU_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOPLSU_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOCATE
    PROCEDURE prAcCUCOCATE_RId(
        iRowId ROWID,
        inuCUCOCATE_O    NUMBER,
        inuCUCOCATE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOCATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCOCATE_O,-1) <> NVL(inuCUCOCATE_N,-1) THEN
            UPDATE cuencobr
            SET CUCOCATE=inuCUCOCATE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOCATE_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOSUCA
    PROCEDURE prAcCUCOSUCA_RId(
        iRowId ROWID,
        inuCUCOSUCA_O    NUMBER,
        inuCUCOSUCA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOSUCA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCOSUCA_O,-1) <> NVL(inuCUCOSUCA_N,-1) THEN
            UPDATE cuencobr
            SET CUCOSUCA=inuCUCOSUCA_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOSUCA_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOVAAP
    PROCEDURE prAcCUCOVAAP_RId(
        iRowId ROWID,
        inuCUCOVAAP_O    NUMBER,
        inuCUCOVAAP_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOVAAP_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCOVAAP_O,-1) <> NVL(inuCUCOVAAP_N,-1) THEN
            UPDATE cuencobr
            SET CUCOVAAP=inuCUCOVAAP_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOVAAP_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOVARE
    PROCEDURE prAcCUCOVARE_RId(
        iRowId ROWID,
        inuCUCOVARE_O    NUMBER,
        inuCUCOVARE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOVARE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCOVARE_O,-1) <> NVL(inuCUCOVARE_N,-1) THEN
            UPDATE cuencobr
            SET CUCOVARE=inuCUCOVARE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOVARE_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOVAAB
    PROCEDURE prAcCUCOVAAB_RId(
        iRowId ROWID,
        inuCUCOVAAB_O    NUMBER,
        inuCUCOVAAB_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOVAAB_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCOVAAB_O,-1) <> NVL(inuCUCOVAAB_N,-1) THEN
            UPDATE cuencobr
            SET CUCOVAAB=inuCUCOVAAB_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOVAAB_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOVATO
    PROCEDURE prAcCUCOVATO_RId(
        iRowId ROWID,
        inuCUCOVATO_O    NUMBER,
        inuCUCOVATO_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOVATO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCOVATO_O,-1) <> NVL(inuCUCOVATO_N,-1) THEN
            UPDATE cuencobr
            SET CUCOVATO=inuCUCOVATO_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOVATO_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOFEPA
    PROCEDURE prAcCUCOFEPA_RId(
        iRowId ROWID,
        idtCUCOFEPA_O    DATE,
        idtCUCOFEPA_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOFEPA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(idtCUCOFEPA_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtCUCOFEPA_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE cuencobr
            SET CUCOFEPA=idtCUCOFEPA_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOFEPA_RId;
 
    -- Actualiza por RowId el valor de la columna CUCONUSE
    PROCEDURE prAcCUCONUSE_RId(
        iRowId ROWID,
        inuCUCONUSE_O    NUMBER,
        inuCUCONUSE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCONUSE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCONUSE_O,-1) <> NVL(inuCUCONUSE_N,-1) THEN
            UPDATE cuencobr
            SET CUCONUSE=inuCUCONUSE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCONUSE_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOSACU
    PROCEDURE prAcCUCOSACU_RId(
        iRowId ROWID,
        inuCUCOSACU_O    NUMBER,
        inuCUCOSACU_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOSACU_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCOSACU_O,-1) <> NVL(inuCUCOSACU_N,-1) THEN
            UPDATE cuencobr
            SET CUCOSACU=inuCUCOSACU_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOSACU_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOVRAP
    PROCEDURE prAcCUCOVRAP_RId(
        iRowId ROWID,
        inuCUCOVRAP_O    NUMBER,
        inuCUCOVRAP_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOVRAP_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCOVRAP_O,-1) <> NVL(inuCUCOVRAP_N,-1) THEN
            UPDATE cuencobr
            SET CUCOVRAP=inuCUCOVRAP_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOVRAP_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOFACT
    PROCEDURE prAcCUCOFACT_RId(
        iRowId ROWID,
        inuCUCOFACT_O    NUMBER,
        inuCUCOFACT_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOFACT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCOFACT_O,-1) <> NVL(inuCUCOFACT_N,-1) THEN
            UPDATE cuencobr
            SET CUCOFACT=inuCUCOFACT_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOFACT_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOFAAG
    PROCEDURE prAcCUCOFAAG_RId(
        iRowId ROWID,
        inuCUCOFAAG_O    NUMBER,
        inuCUCOFAAG_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOFAAG_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCOFAAG_O,-1) <> NVL(inuCUCOFAAG_N,-1) THEN
            UPDATE cuencobr
            SET CUCOFAAG=inuCUCOFAAG_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOFAAG_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOFEVE
    PROCEDURE prAcCUCOFEVE_RId(
        iRowId ROWID,
        idtCUCOFEVE_O    DATE,
        idtCUCOFEVE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOFEVE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(idtCUCOFEVE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtCUCOFEVE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE cuencobr
            SET CUCOFEVE=idtCUCOFEVE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOFEVE_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOVAFA
    PROCEDURE prAcCUCOVAFA_RId(
        iRowId ROWID,
        inuCUCOVAFA_O    NUMBER,
        inuCUCOVAFA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOVAFA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCOVAFA_O,-1) <> NVL(inuCUCOVAFA_N,-1) THEN
            UPDATE cuencobr
            SET CUCOVAFA=inuCUCOVAFA_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOVAFA_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOSIST
    PROCEDURE prAcCUCOSIST_RId(
        iRowId ROWID,
        inuCUCOSIST_O    NUMBER,
        inuCUCOSIST_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOSIST_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCOSIST_O,-1) <> NVL(inuCUCOSIST_N,-1) THEN
            UPDATE cuencobr
            SET CUCOSIST=inuCUCOSIST_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOSIST_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOGRIM
    PROCEDURE prAcCUCOGRIM_RId(
        iRowId ROWID,
        inuCUCOGRIM_O    NUMBER,
        inuCUCOGRIM_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOGRIM_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCOGRIM_O,-1) <> NVL(inuCUCOGRIM_N,-1) THEN
            UPDATE cuencobr
            SET CUCOGRIM=inuCUCOGRIM_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOGRIM_RId;
 
    -- Actualiza por RowId el valor de la columna CUCOIMFA
    PROCEDURE prAcCUCOIMFA_RId(
        iRowId ROWID,
        inuCUCOIMFA_O    NUMBER,
        inuCUCOIMFA_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCOIMFA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCOIMFA_O,-1) <> NVL(inuCUCOIMFA_N,-1) THEN
            UPDATE cuencobr
            SET CUCOIMFA=inuCUCOIMFA_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCOIMFA_RId;
 
    -- Actualiza por RowId el valor de la columna CUCODIIN
    PROCEDURE prAcCUCODIIN_RId(
        iRowId ROWID,
        inuCUCODIIN_O    NUMBER,
        inuCUCODIIN_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCUCODIIN_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        IF NVL(inuCUCODIIN_O,-1) <> NVL(inuCUCODIIN_N,-1) THEN
            UPDATE cuencobr
            SET CUCODIIN=inuCUCODIIN_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCUCODIIN_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro IN styRegistro) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbInicio);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.CUCOCODI,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcCUCODEPA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCODEPA,
                ircRegistro.CUCODEPA
            );
 
            prAcCUCOLOCA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOLOCA,
                ircRegistro.CUCOLOCA
            );
 
            prAcCUCOPLSU_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOPLSU,
                ircRegistro.CUCOPLSU
            );
 
            prAcCUCOCATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOCATE,
                ircRegistro.CUCOCATE
            );
 
            prAcCUCOSUCA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOSUCA,
                ircRegistro.CUCOSUCA
            );
 
            prAcCUCOVAAP_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOVAAP,
                ircRegistro.CUCOVAAP
            );
 
            prAcCUCOVARE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOVARE,
                ircRegistro.CUCOVARE
            );
 
            prAcCUCOVAAB_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOVAAB,
                ircRegistro.CUCOVAAB
            );
 
            prAcCUCOVATO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOVATO,
                ircRegistro.CUCOVATO
            );
 
            prAcCUCOFEPA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOFEPA,
                ircRegistro.CUCOFEPA
            );
 
            prAcCUCONUSE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCONUSE,
                ircRegistro.CUCONUSE
            );
 
            prAcCUCOSACU_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOSACU,
                ircRegistro.CUCOSACU
            );
 
            prAcCUCOVRAP_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOVRAP,
                ircRegistro.CUCOVRAP
            );
 
            prAcCUCOFACT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOFACT,
                ircRegistro.CUCOFACT
            );
 
            prAcCUCOFAAG_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOFAAG,
                ircRegistro.CUCOFAAG
            );
 
            prAcCUCOFEVE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOFEVE,
                ircRegistro.CUCOFEVE
            );
 
            prAcCUCOVAFA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOVAFA,
                ircRegistro.CUCOVAFA
            );
 
            prAcCUCOSIST_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOSIST,
                ircRegistro.CUCOSIST
            );
 
            prAcCUCOGRIM_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOGRIM,
                ircRegistro.CUCOGRIM
            );
 
            prAcCUCOIMFA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCOIMFA,
                ircRegistro.CUCOIMFA
            );
 
            prAcCUCODIIN_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CUCODIIN,
                ircRegistro.CUCODIIN
            );
 
        END IF;
        pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, cnuNivelTraza, csbFin_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError: '||sbError, cnuNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prActRegistro;
END pkg_cuencobr;
/  
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_CUENCOBR','ADM_PERSON');
END;
/