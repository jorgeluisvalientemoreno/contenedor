CREATE OR REPLACE PROCEDURE prcReglaIniPuntoAtencion
IS
    /**************************************************************************
        Propiedad Intelectual de Gases del caribe S.A E.S.P

        Unidad:       prcReglaIniPuntoAtencion
        Descripcion:  procedimiento que ejecuta el procedimiento la regla de
                      inicialización de punto de atención en la solicitud 
                      de actualización de datos 
                    predio.
        Autor:        Luis Felipe Valencia Hurtado
        
        Caso:         OSF-3198
        Fecha:        08/11/2024
        
        Modificaciones
        08/11/2024      felipe.valencia     Creción
    **************************************************************************/

    nuError                 NUMBER;     
    nuPersonaId             NUMBER; 
    nuPuntoAtencion         NUMBER; 
    nuAtributo              NUMBER; 

    sbPersonaId             VARCHAR2(4000); 
    sbError                 VARCHAR2(4000);
    csbMetodo               CONSTANT VARCHAR2(100) := 'prcReglaIniPuntoAtencion';

    cblVerdadero        BOOLEAN := CONSTANTS_PER.GETTRUE;
BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   

    IF (ge_boinstancecontrol.fblacckeyattributestack('WORK_INSTANCE', null, 'MO_PACKAGES', 'PERSON_ID', nuAtributo) = TRUE) THEN
        prc_obtienevalorinstancia('WORK_INSTANCE', NULL, 'MO_PACKAGES', 'PERSON_ID', sbPersonaId);
        nuPersonaId := TO_NUMBER(sbPersonaId);
        pkg_traza.trace('nuPersonaId :'||nuPersonaId, pkg_traza.cnuNivelTrzDef);

        nuPuntoAtencion := pkg_bopersonal.fnugetpuntoatencionid(nuPersonaId);

        ge_boinstancecontrol.setentityattribute(nuPuntoAtencion);
    ELSE
        nuPuntoAtencion := pkg_bopersonal.fnugetpuntoatencionid(NULL);
        ge_boinstancecontrol.setentityattribute(nuPuntoAtencion);
    END IF;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
EXCEPTION
    WHEN pkg_error.controlled_error THEN
        pkg_error.getError(nuError, sbError);    
        pkg_traza.trace('Error controlado en procedimiento prcReglaIniPuntoAtencion '||sbError, pkg_traza.cnuNivelTrzDef);
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(nuError, sbError);
        pkg_traza.trace('Error en procedimiento prcReglaIniPuntoAtencion '||sbError, pkg_traza.cnuNivelTrzDef);
        RAISE pkg_Error.Controlled_Error;
END prcReglaIniPuntoAtencion;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('prcReglaIniPuntoAtencion','OPEN');
END;
/