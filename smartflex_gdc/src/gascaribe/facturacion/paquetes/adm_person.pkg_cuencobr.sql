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
******************************************************************/
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
            pkg_traza.trace(' sbError => ' || sbError, cnuNivelTraza);
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, cnuNivelTraza);
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
        pkg_traza.trace(' sbError => ' || sbError,cnuNivelTraza);
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace(' sbError => ' || sbError, cnuNivelTraza);
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
        RAISE pkg_Error.Controlled_Error;
  END prActualizaFechaVenc;
END pkg_cuencobr;
/  
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_CUENCOBR','ADM_PERSON');
END;
/