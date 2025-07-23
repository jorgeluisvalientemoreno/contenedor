CREATE OR REPLACE PACKAGE adm_person.pkg_pagos IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_pagos
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   10/02/2025
    Descripcion :   Paquete
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     10/02/2025  OSF-3893 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Obtiene la forma de pago, la sucursal, el banco y la fecha del pago del cupon
    PROCEDURE prcObtFormaSucuBancFech
    (
        inuCupon            IN  pagos.pagocupo%TYPE,
        osbFormaPago        OUT pagos.pagotdco%TYPE,
        onuSucursal         OUT pagos.pagosuba%TYPE,
        onuBanco            OUT pagos.pagobanc%TYPE,
        odtFechaPago        OUT pagos.pagofepa%TYPE
    );


END pkg_pagos;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_pagos IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3893';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    cnuTIPO_REF_CUPON   CONSTANT NUMBER(1) := 1;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 10/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     10/02/2025  OSF-3893 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcObtFormaSucuBancFech 
    Descripcion     : Obtiene la forma de pago, la sucursal, el banco y la fecha
                      del pago del cupo
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 10/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     10/02/2025  OSF-3893 Creacion
    ***************************************************************************/
    PROCEDURE prcObtFormaSucuBancFech
    (
        inuCupon            IN  pagos.pagocupo%TYPE,
        osbFormaPago        OUT pagos.pagotdco%TYPE,
        onuSucursal         OUT pagos.pagosuba%TYPE,
        onuBanco            OUT pagos.pagobanc%TYPE,
        odtFechaPago        OUT pagos.pagofepa%TYPE
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcObtFormaSucuBancFech';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        CURSOR cuObtFormaSucuBancFech
        IS
        SELECT pagotdco, pagosuba, pagobanc, pagofepa
        FROM pagos 
        WHERE pagocupo = inuCupon; 
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuObtFormaSucuBancFech;
        FETCH cuObtFormaSucuBancFech 
        INTO osbFormaPago, onuSucursal, onuBanco, odtFechaPago;
        CLOSE cuObtFormaSucuBancFech;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
                       
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
    END prcObtFormaSucuBancFech;
      
END pkg_pagos;
/
Prompt Otorgando permisos sobre adm_person.pkg_pagos
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_pagos'), UPPER('adm_person'));
END;
/