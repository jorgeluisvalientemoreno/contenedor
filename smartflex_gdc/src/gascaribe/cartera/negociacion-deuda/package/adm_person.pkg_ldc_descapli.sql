CREATE OR REPLACE PACKAGE adm_person.PKG_LDC_DESCAPLI IS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : adm_person.PKG_LDC_DESCAPLI
    Descripción    : Paquete de primer nivel para gestión de la tabla ldc_descapli
    Autor          : jcatuche
    Fecha          : 23/08/2024

    Fecha           Autor               Modificación
    =========       =========           ====================
	23/08/2024      jcatuche            OSF-2974: Creación
******************************************************************/
    PROCEDURE prInsertaRegistro
    (
        inucuenta           in ldc_descapli.cuenta%type,
        inufactura          in ldc_descapli.factura%type,
        inudiferido         in ldc_descapli.diferido%type,
        inusolicitud        in ldc_descapli.solicitud%type,
        inuvalor_descuento  in ldc_descapli.valor_descuento%type,
        inuvalor_pago       in ldc_descapli.valor_pago%type,
        inucupon            in ldc_descapli.cupon%type
    ); 
    
    PROCEDURE prBorraRegistro
    (
        inusolicitud        in ldc_descapli.solicitud%type,
        inucupon            in ldc_descapli.cupon%type
    ); 
    
    
    
    
END PKG_LDC_DESCAPLI;
/
CREATE OR REPLACE PACKAGE BODY adm_person.PKG_LDC_DESCAPLI IS
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
    Programa        : prInsertaRegistro
    Descripcion     : Inserta registro en ldc_descapli

    Autor           : jcatuche
    Fecha           : 23/08/2024

    Parametros de Entrada
        inucuenta           Cuenta
        inufactura          Factura
        inudiferido         Diferido    
        inusolicitud        Solicitud   
        inuvalor_descuento  Valor descuento
        inuvalor_pago       Valor pago
        inucupon            Cupon
        
        
    Parametros de Salida
        NA
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripción
    jcatuche    23/08/2024  OSF-2974    Creación
    ***************************************************************************/
    PROCEDURE prInsertaRegistro
    (
        inucuenta           in ldc_descapli.cuenta%type,
        inufactura          in ldc_descapli.factura%type,
        inudiferido         in ldc_descapli.diferido%type,
        inusolicitud        in ldc_descapli.solicitud%type,
        inuvalor_descuento  in ldc_descapli.valor_descuento%type,
        inuvalor_pago       in ldc_descapli.valor_pago%type,
        inucupon            in ldc_descapli.cupon%type
    ) IS
        csbMT_NAME   CONSTANT VARCHAR2(100) := csbSP_NAME||'prInsertaRegistro';
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        insert into ldc_descapli (cuenta,factura,diferido,solicitud,valor_descuento,valor_pago,cupon,fecha)
        values (inucuenta, inufactura, inudiferido, inusolicitud,inuvalor_descuento,inuvalor_pago,inucupon,sysdate);
        
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prInsertaRegistro;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prBorraRegistro
    Descripcion     : Borra registro en ldc_descapli

    Autor           : jcatuche
    Fecha           : 23/08/2024

    Parametros de Entrada
        inusolicitud        Solicitud   
        inucupon            Cupon
        
        
    Parametros de Salida
        NA
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripción
    jcatuche    23/08/2024  OSF-2974    Creación
    ***************************************************************************/
    PROCEDURE prBorraRegistro
    (
        inusolicitud        in ldc_descapli.solicitud%type,
        inucupon            in ldc_descapli.cupon%type
    ) IS
        csbMT_NAME   CONSTANT VARCHAR2(100) := csbSP_NAME||'prBorraRegistro';
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        delete ldc_descapli d
        where d.solicitud = inusolicitud and d.cupon = inucupon;
        
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prBorraRegistro;
        
END PKG_LDC_DESCAPLI;
/
begin
    pkg_utilidades.prAplicarPermisos('PKG_LDC_DESCAPLI','ADM_PERSON');
end;
/