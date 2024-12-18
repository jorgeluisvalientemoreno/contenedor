CREATE OR REPLACE PACKAGE adm_person.pkg_cargos IS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : adm_person.pkg_cargos
    Descripción    : Paquete de primer nivel para gestión de cargos
    Autor          : jcatuche
    Fecha          : 15/05/2024

    Fecha           Autor               Modificación
    =========       =========           ====================
	15-05-2024      jcatuche            OSF-2467: Creación
******************************************************************/
    PROCEDURE prInsertaCargo
    (
        inucuco in  cargos.cargcuco%type,
        inunuse in  cargos.cargnuse%type,
        isbsign in  cargos.cargsign%type,
        inuconc in  cargos.cargconc%type,
        inuvalo in  cargos.cargvalo%type,
        inuvabl in  cargos.cargvabl%type,
        inupefa in  cargos.cargpefa%type,
        inufecr in  cargos.cargfecr%type,
        inuprog in  cargos.cargprog%type,
        inucaca in  cargos.cargcaca%type,
        isbdoso in  cargos.cargdoso%type,
        inucodo in  cargos.cargcodo%type,
        inuusua in  cargos.cargusua%type,
        isbtipr in  cargos.cargtipr%type
    );
    
END pkg_cargos;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_cargos IS
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
    Descripción     : Inserta registro en cuencobr

    Autor           : jcatuche
    Fecha           : 15-05-2024

    Parametros de Entrada
        inucuco     identificador de la cuenta
        inunuse     identificador del producto
        isbsign     signo del cargo
        inuconc     identificador del concepto
        inuvalo     valor del cargo
        inuvabl     valor base de liquidación
        inupefa     identificador del periodo de facturación
        inufecr     fecha de creación del cargo
        inuprog     identificador del programa
        inucaca     identificador de la causal
        isbdoso     documento de soporte
        inucodo     consecutivo del documento
        inuusua     identificador del usuario
        isbtipr     tipo de proceso
        
    Parametros de Salida
        NA
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripción
    jcatuche    15-05-2024  OSF-2467    Creación
  ***************************************************************************/
    PROCEDURE prInsertaCargo
    (
        inucuco in  cargos.cargcuco%type,
        inunuse in  cargos.cargnuse%type,
        isbsign in  cargos.cargsign%type,
        inuconc in  cargos.cargconc%type,
        inuvalo in  cargos.cargvalo%type,
        inuvabl in  cargos.cargvabl%type,
        inupefa in  cargos.cargpefa%type,
        inufecr in  cargos.cargfecr%type,
        inuprog in  cargos.cargprog%type,
        inucaca in  cargos.cargcaca%type,
        isbdoso in  cargos.cargdoso%type,
        inucodo in  cargos.cargcodo%type,
        inuusua in  cargos.cargusua%type,
        isbtipr in  cargos.cargtipr%type
    ) IS
        csbMT_NAME   CONSTANT VARCHAR2(100) := csbSP_NAME||'prInsertaCargo';
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        INSERT INTO cargos
        (
            cargcuco,
            cargnuse,            
            cargsign,
            cargconc,
            cargvalo,
            cargvabl,
            cargpefa,
            cargfecr,
            cargprog,
            cargcaca,
            cargdoso,
            cargcodo,
            cargusua,
            cargtipr
        )
        VALUES
        (
            inucuco,
            inunuse,
            isbsign,
            inuconc,
            inuvalo,
            inuvabl,            
            inupefa,
            inufecr,
            inuprog,
            inucaca,
            isbdoso,
            inucodo,
            inuusua,
            isbtipr
        );
        
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prInsertaCargo;
    
END pkg_cargos;
/
begin
    pkg_utilidades.prAplicarPermisos('PKG_CARGOS','ADM_PERSON');
end;
/