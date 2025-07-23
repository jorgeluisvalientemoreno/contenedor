CREATE OR REPLACE PROCEDURE personalizaciones.oal_actualizasubcategoria
IS
    /**************************************************************************
        Propiedad Intelectual de Gases del caribe S.A E.S.P

        Unidad:       oal_actualizasubcategoria
        Descripcion:  Pluigin para actualizar la categoría y la subcategoria

        Autor:        Luis Felipe Valencia Hurtado
        
        Caso:         OSF-3198
        Fecha:        08/11/2024
        
        Modificaciones
        08/11/2024      felipe.valencia     Creción
    **************************************************************************/

    nuError                 NUMBER;     
    nuCausal                NUMBER;  
    nuOrden                 NUMBER;
    nuTipoSolicitud         NUMBER;
    nuClaseCausal           NUMBER;
    nuSolicitud             NUMBER;
    nuCategoriaAnterior     NUMBER;
    nuCategriaNueva         NUMBER;
    nuSubcategoriaAnterior  NUMBER;
    nuSubcategoriaNueva     NUMBER;
    nuContrato              NUMBER;
    sbError                 VARCHAR2(4000);
    sbSolicitud             VARCHAR2(4000);
    csbMetodo               CONSTANT VARCHAR2(100) := 'oal_actualizasubcategoria';

BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   

    nuOrden:= pkg_bcordenes.fnuobtenerotinstancialegal;
    pkg_traza.trace(csbMetodo||' Numero de la Orden: ' || nuorden, pkg_traza.cnuNivelTrzDef);

    nuCausal := pkg_bcordenes.fnuobtienecausal(nuorden);

    pkg_traza.trace(csbMetodo||' Causal de la Orden: ' || nuCausal, pkg_traza.cnuNivelTrzDef);

    nuClaseCausal := pkg_bcordenes.fnuobtieneclasecausal(nuCausal);

    pkg_traza.trace(csbMetodo||' Clase Causal de la Orden: ' || nuClaseCausal, pkg_traza.cnuNivelTrzDef);

    IF ( nuClaseCausal = 1 ) THEN
        nuSolicitud := pkg_bcordenes.fnuObtieneSolicitud(nuOrden);

        pkg_traza.trace(csbMetodo||' Solicitud: ' || nuSolicitud, pkg_traza.cnuNivelTrzDef);

        nuTipoSolicitud := pkg_bcsolicitudes.fnugettiposolicitud(nuSolicitud);

        pkg_traza.trace(csbMetodo||' Tipo Solicitud: ' || nuTipoSolicitud, pkg_traza.cnuNivelTrzDef);

        pkg_traza.trace(csbMetodo||' Solicitud: ' || nuSolicitud, pkg_traza.cnuNivelTrzDef);

        pkg_boGestionSolicitudes.prcObtCategoriasPorSolicitud(nuSolicitud,nuCategoriaAnterior,nuCategriaNueva);

        pkg_traza.trace(csbMetodo||' Categoría Anterior: ' || nuCategoriaAnterior, pkg_traza.cnuNivelTrzDef);

        pkg_traza.trace(csbMetodo||' Categoría Nueva: ' || nuCategriaNueva, pkg_traza.cnuNivelTrzDef);

        pkg_boGestionSolicitudes.prcObtSubCategoriaPorSolicitud(nuSolicitud,nuSubcategoriaAnterior,nuSubcategoriaNueva);

        pkg_traza.trace(csbMetodo||' Subsategoría Anterior: ' || nuSubcategoriaAnterior, pkg_traza.cnuNivelTrzDef);

        pkg_traza.trace(csbMetodo||' Subcategoría Nueva: ' || nuSubcategoriaNueva, pkg_traza.cnuNivelTrzDef);

        nuContrato := pkg_bcsolicitudes.fnuGetContrato(nuSolicitud);

        pkg_traza.trace(csbMetodo||' Contrato: ' || nuContrato, pkg_traza.cnuNivelTrzDef);

        pkg_bogestion_instancias.prcCreaInstancia(pkg_bogestion_instancias.csbWorkInstance);

        pkg_bogestion_instancias.prcAdicionarAtributo
        (
            pkg_bogestion_instancias.csbWorkInstance,
            NULL,
            'PS_PACKAGE_TYPE',
            'PACKAGE_TYPE_ID',
            nuTipoSolicitud
        );

        pkg_gestion_producto.prcActuaCateySubcaPorContrato(nuContrato,nuCategriaNueva,nuSubcategoriaNueva);
    END IF;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
EXCEPTION
    WHEN pkg_error.controlled_error THEN
        pkg_error.getError(nuError, sbError);    
        pkg_traza.trace('Error controlado en procedimiento oal_actualizasubcategoria '||sbError, pkg_traza.cnuNivelTrzDef);
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError, sbError);
        pkg_traza.trace('Error en procedimiento oal_actualizasubcategoria '||sbError, pkg_traza.cnuNivelTrzDef);
        RAISE pkg_Error.Controlled_Error;
END oal_actualizasubcategoria;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('OAL_ACTUALIZASUBCATEGORIA','PERSONALIZACIONES');
END;
/