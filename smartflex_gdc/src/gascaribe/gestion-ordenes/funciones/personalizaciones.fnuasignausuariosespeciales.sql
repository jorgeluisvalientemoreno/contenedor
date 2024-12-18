CREATE OR REPLACE FUNCTION personalizaciones.fnuasignausuariosespeciales
(
    isbIN IN VARCHAR2
)
RETURN VARCHAR2 
IS

    /*******************************************************************************
        Fuente=Propiedad Intelectual de Gases del Caribe
        fnuasignausuariosespeciales
        Autor       :   Luis Felipe Valencia Hurtado
        Fecha       :   16-09-2024
        Descripcion :   Función que se encarga de obtener la unidad operativa para
                        asignación automatica de ordenes para usuarios especiales
                        
        Parametros  :   isbIN - Información de la orden para asignar 

        Modificaciones  :
        Autor                   Fecha        Caso       Descripcion
        Felipe.valencia         16-09-2024   OSF-2758   Creación
    *******************************************************************************/

    csbMetodo               CONSTANT VARCHAR2(100) := $$PLSQL_UNIT;
    csbNivelTraza           CONSTANT NUMBER(2)     := pkg_traza.fnuNivelTrzDef;

    sbError             VARCHAR2(4000);
    nuError             NUMBER;   

    sbOrdenId           VARCHAR2(4000) := NULL;
    sbSolicitudId       VARCHAR2(4000) := NULL;
    sbActividadId       VARCHAR2(4000) := NULL;
    sbContratoId        VARCHAR2(4000) := NULL;
    nuUnidadOperativa   or_operating_unit.operating_unit_id%TYPE := -1;
    nuErrorId       	  NUMBER;
    sbMensajeError  	  VARCHAR2(4000);
    nuOrden             NUMBER;
    nuProducto          NUMBER;
    nuCiclo             NUMBER;
    nuSector            NUMBER;

    CURSOR CUDATA 
    IS
    SELECT regexp_substr(isbIN,'[^|]+', 1,LEVEL) COLUMN_VALUE
    FROM   dual
    CONNECT BY regexp_substr(isbIN, '[^|]+', 1, LEVEL) IS NOT NULL;
BEGIN
	  pkg_traza.trace(csbMetodo,  pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    pkg_Traza.Trace('isbIN: '||isbIN, pkg_traza.cnuNivelTrzDef);

    FOR rcDatos IN cuData LOOP
        pkg_Traza.Trace(rcDatos.COLUMN_VALUE, pkg_traza.cnuNivelTrzDef);

        IF (sbOrdenId IS NULL) THEN
            sbOrdenId     := rcDatos.COLUMN_VALUE;
            pkg_traza.trace('rcDatos.column_value sbOrdenId: ' || rcDatos.column_value, pkg_traza.cnuNivelTrzDef);
        ELSIF (sbSolicitudId IS NULL) THEN
            sbSolicitudId   := rcDatos.COLUMN_VALUE;
            pkg_traza.trace('rcDatos.column_value sbSolicitudId: ' || rcDatos.column_value, pkg_traza.cnuNivelTrzDef);
        ELSIF (sbActividadId IS NULL) THEN
            sbActividadId  := rcDatos.COLUMN_VALUE;
            pkg_traza.trace('rcDatos.column_value sbActividadId: ' || rcDatos.column_value, pkg_traza.cnuNivelTrzDef);
        ELSIF (sbContratoId IS NULL) THEN
            sbContratoId   := rcDatos.COLUMN_VALUE;
            pkg_traza.trace('rcDatos.column_value sbContratoId: ' || rcDatos.column_value, pkg_traza.cnuNivelTrzDef);
        END IF;
    END LOOP;

    nuOrden := TO_NUMBER(sbOrdenId);

    --Obtiene le produto de la orden
    nuProducto := pkg_bcordenes.fnuObtieneProducto(nuOrden);

    pkg_traza.trace('Producto Orden: ' || nuProducto, pkg_traza.cnuNivelTrzDef);

    nuCiclo := pkg_bcproducto.fnuciclofacturacion(nuProducto);

    pkg_traza.trace('Ciclo Orden: ' || nuCiclo, pkg_traza.cnuNivelTrzDef);

    nuSector := pkg_bcordenes.fnuobtienesectoroperativo(nuOrden);

    pkg_traza.trace('Sector orden: ' || nuSector, pkg_traza.cnuNivelTrzDef);

    --Obtener Unidad Operativa 
    nuUnidadOperativa := pkg_bcconfiguoespeciales.fnuObtineUnidadOperativa(nuCiclo, nuSector);

    pkg_traza.trace('Unidad Operativa a Asignar: ' || nuUnidadOperativa, pkg_traza.cnuNivelTrzDef);

    IF (nuUnidadOperativa IS NOT NULL) THEN
        BEGIN
            api_assign_order
            (
                nuOrden,
                nuUnidadOperativa,
                nuErrorId,
                sbMensajeError
            );

            IF NVL(nuErrorId, 0) = 0 THEN
                pkg_orden_uobysol.prcEliminarOrden(nuOrden);
            ELSE
                pkg_orden_uobysol.prcActualizaObservacion(nuOrden,sbMensajeError);
                Pkg_Error.SetErrorMessage(isbMsgErrr => 'Error al asignar la orden ' ||
                                                        nuOrden || ' Error: ' ||
                                                        sbMensajeError);
            END IF;
        EXCEPTION
          WHEN pkg_Error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError,  pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo,  pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
          WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError,  pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo,  pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        END;
    ELSE
        --Obtener Unidad Operativa del ciclo
        nuUnidadOperativa := pkg_bcconfiguoespeciales.fnuObtineUnidadOperativaCiclo(nuCiclo);
    END IF;

    pkg_traza.trace(csbMetodo,  pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    return nuUnidadOperativa;

EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        return nuUnidadOperativa;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        return nuUnidadOperativa;   
end fnuasignausuariosespeciales;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUASIGNAUSUARIOSESPECIALES', 'PERSONALIZACIONES');
END;
/
