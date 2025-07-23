CREATE OR REPLACE PROCEDURE prcreglaprecambiardatospredio
IS
    /**************************************************************************
        Propiedad Intelectual de Gases del caribe S.A E.S.P

        Unidad:       prcreglaprecambiardatospredio
        Descripcion:  procedimiento que ejecuta el procedimiento la regla pre 
                    en el motivo de la solicitud de actualización de datos 
                    predio.
        Autor:        Luis Felipe Valencia Hurtado
        
        Caso:         OSF-3198
        Fecha:        08/11/2024
        
        Modificaciones
        08/11/2024      felipe.valencia     Creción
    **************************************************************************/

    nuError                 NUMBER;     
    nuDireccionInstalVieja  NUMBER; 
    nuDireccionInstalNueva  NUMBER; 
    nuDireccionFactVieja    NUMBER;
    nuDireccionFactNueva    NUMBER;
    nuSubcategoriaVieja     NUMBER; 
    nuSubcategoriaNueva     NUMBER;
    nuCategoriaNueva        NUMBER;
    nuCategoriaVieja        NUMBER;


    sbDireccionInstalVieja  VARCHAR2(4000); 
    sbDireccionFactVieja    VARCHAR2(4000);
    sbDireccionInstalNueva  VARCHAR2(4000);
    sbDireccionFactNueva    VARCHAR2(4000);
    sbSubcategoriaNueva     VARCHAR2(4000);
    sbSubcategoriaVieja     VARCHAR2(4000);
    sbCategoriaNueva        VARCHAR2(4000);
    sbCategoriaVieja        VARCHAR2(4000);
    sbResolucion            VARCHAR2(4000);
    sbInstanciaActual       VARCHAR2(4000);   
    sbInstanciaPadre        VARCHAR2(4000);
    sbDirIntalacionReal     VARCHAR2(4000); 
    sbDirEntregaReal        VARCHAR2(4000); 
    sbComment               VARCHAR2(4000);
    sbError                 VARCHAR2(4000);
BEGIN
    -- Obtener instancia actual
    ge_boinstancecontrol.getcurrentinstance(sbInstanciaActual);

    ge_boinstancecontrol.getattributeoldvalue(sbInstanciaActual, NULL, 'MO_PROCESS', 'ADDRESS_MAIN_MOTIVE', sbDireccionInstalVieja);
    nuDireccionInstalVieja := TO_NUMBER(NVL(sbDireccionInstalVieja,-1));

    prc_obtienevalorinstancia(sbInstanciaActual, NULL, 'MO_PROCESS', 'ADDRESS_MAIN_MOTIVE', sbDireccionInstalNueva);
    nuDireccionInstalNueva := TO_NUMBER(sbDireccionInstalNueva);

    ge_boinstancecontrol.getattributeoldvalue(sbInstanciaActual, NULL, 'MO_PROCESS', 'VARCHAR_1', sbDireccionFactVieja);
    nuDireccionFactVieja := TO_NUMBER(NVL(sbDireccionFactVieja,-1));

    prc_obtienevalorinstancia(sbInstanciaActual, NULL, 'MO_PROCESS', 'VARCHAR_1', sbDireccionFactNueva);
    nuDireccionFactNueva := TO_NUMBER(sbDireccionFactNueva);

    ge_boinstancecontrol.getattributeoldvalue(sbInstanciaActual, NULL, 'MO_MOTIVE', 'SUBCATEGORY_ID', sbSubcategoriaVieja);
    nuSubcategoriaVieja := TO_NUMBER(NVL(sbSubcategoriaVieja,-1));

    prc_obtienevalorinstancia(sbInstanciaActual, NULL, 'MO_MOTIVE', 'SUBCATEGORY_ID', sbSubcategoriaNueva);
    nuSubcategoriaNueva := TO_NUMBER(sbSubcategoriaNueva);

    ge_boinstancecontrol.getattributeoldvalue(sbInstanciaActual, NULL, 'MO_MOTIVE', 'CATEGORY_ID', sbCategoriaVieja);
    nuCategoriaVieja := TO_NUMBER(NVL(sbCategoriaVieja,-1));

    prc_obtienevalorinstancia(sbInstanciaActual, NULL, 'MO_MOTIVE', 'CATEGORY_ID', sbCategoriaNueva);
    nuCategoriaNueva := TO_NUMBER(sbCategoriaNueva);

    prc_obtienevalorinstancia(sbInstanciaActual, NULL, 'MO_PROCESS', 'VARCHAR_2', sbResolucion);

    prc_obtienevalorinstancia(sbInstanciaActual, NULL, 'MO_PROCESS', 'COMMENTARY', sbDirIntalacionReal);

    prc_obtienevalorinstancia(sbInstanciaActual, NULL, 'MO_COMMENT', 'COMMENT_', sbDirEntregaReal);
    
    
    pkg_boactualizadatospredio.prcReglaPreCambiarDatosPredio
    (
        nuDireccionInstalNueva,
        nuDireccionFactVieja,   
        nuDireccionFactNueva,  
        nuDireccionFactVieja,
        nuSubcategoriaVieja,
        nuSubcategoriaNueva,
        nuCategoriaNueva,
        nuCategoriaVieja,
        sbResolucion,
        sbDirIntalacionReal,
        sbDirEntregaReal
    );

EXCEPTION
    WHEN pkg_error.controlled_error THEN
        pkg_error.getError(nuError, sbError);    
        pkg_traza.trace('Error controlado en procedimiento prcreglaprecambiardatospredio '||sbError, pkg_traza.cnuNivelTrzDef);
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError, sbError);
        pkg_traza.trace('Error en procedimiento prcreglaprecambiardatospredio '||sbError, pkg_traza.cnuNivelTrzDef);
        RAISE pkg_Error.Controlled_Error;
END prcreglaprecambiardatospredio;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('PRCREGLAPRECAMBIARDATOSPREDIO','OPEN');
END;
/