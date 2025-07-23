CREATE OR REPLACE PACKAGE personalizaciones.pkg_boAsignacionUobysol is
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : pkg_boAsignacionUobysol
        Descripcion     : Paquete para la gestión relacionada con la asignación
                          basada en la configuración de asignación automatica 
                          de UOBYSOL

        Autor           : Diana Saltarin Soto
        Fecha           : 18-03-2025

        Parametros de Entrada
          isbDataIn      cadena con valores
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha        Caso       Descripcion
        dsaltarin   18-03-2025   OSF-4059    Creacion
    ***************************************************************************/
       TYPE TYTRCPARAMETROS IS RECORD(
                                      nuOrdenId             or_order.order_id%TYPE,
                                      nuSolicitudId         mo_packages.package_id%TYPE,
                                      nuActividadId         ge_items.items_id%TYPE,
                                      nuContratoId          suscripc.susccodi%TYPE,
                                      sbProceso             VARCHAR2(4000),
                                      nuCategoriaId         categori.catecodi%TYPE
                                );
    FUNCTION frcObtParametros( isbDataIn    IN  VARCHAR2)  RETURN TYTRCPARAMETROS;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : frcObtParametros
        Descripcion     : Retorna un record con los parametros de entrada

        Autor           : Diana Saltarin Soto
        Fecha           : 18-03-2025

        Parametros de Entrada
          isbDataIn      cadena con valores
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha        Caso       Descripcion
        dsaltarin   18-03-2025   OSF-4059    Creacion
    ***************************************************************************/
END pkg_boAsignacionUobysol;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boAsignacionUobysol is

    -- Version del paquete
    csbVersion              CONSTANT VARCHAR2(15) := 'OSF-4059';
    -- Para el control de traza:
    csbSP_NAME              CONSTANT VARCHAR2(32) := $$PLSQL_UNIT;
    csbNivelTraza           CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    csbSeparador            CONSTANT VARCHAR2(1)  := '|';

    FUNCTION frcObtParametros( isbDataIn IN      VARCHAR2)  RETURN TYTRCPARAMETROS is
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : frcObtParametros
        Descripcion     : Retorna un record con los parametros de entrada

        Autor           : Diana Saltarin Soto
        Fecha           : 18-03-2025

        Parametros de Entrada
          isbDataIn      cadena con valores
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha        Caso       Descripcion
        dsaltarin   18-03-2025   OSF-4059    Creacion
    ***************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(100) := csbSP_NAME ||  '.frcObtParametros';
        nuActivityIdrcParametros     TYTRCPARAMETROS;
        
        rcParametros        TYTRCPARAMETROS;
        tbCadenaSeparada    pkg_boutilidadescadenas.tytbCadenaSeparada;
        

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pkg_Traza.trace('isbDataIn: ' ||isbDataIn,csbNivelTraza);


        
        tbCadenaSeparada                    := pkg_boutilidadescadenas.ftbObtCadenaSeparada(isbDataIn, csbSeparador);

        rcParametros.nuOrdenId              := TO_NUMBER(tbCadenaSeparada(1));
        pkg_Traza.trace('isbDataIn: '       ||rcParametros.nuOrdenId,csbNivelTraza);

        rcParametros.nuSolicitudId          := TO_NUMBER(tbCadenaSeparada(2));
        pkg_Traza.trace('nuSolicitudId: '   ||rcParametros.nuSolicitudId,csbNivelTraza);

        rcParametros.nuActividadId          := TO_NUMBER(tbCadenaSeparada(3));
        pkg_Traza.trace('nuActividadId: '   ||rcParametros.nuActividadId,csbNivelTraza);

        rcParametros.nuContratoId           := TO_NUMBER(tbCadenaSeparada(4));
        pkg_Traza.trace('nuContratoId: '    ||rcParametros.nuContratoId,csbNivelTraza);

        rcParametros.sbProceso              := tbCadenaSeparada(5);
        pkg_Traza.trace('sbProceso: '       ||rcParametros.sbProceso,csbNivelTraza);

        rcParametros.nuCategoriaId          := TO_NUMBER(tbCadenaSeparada(6));
        pkg_Traza.trace('nuCategoriaId: '   ||rcParametros.nuCategoriaId,csbNivelTraza);
        

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN rcParametros;
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END;
END pkg_boAsignacionUobysol;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BOASIGNACIONUOBYSOL', 'PERSONALIZACIONES');
END;
/
