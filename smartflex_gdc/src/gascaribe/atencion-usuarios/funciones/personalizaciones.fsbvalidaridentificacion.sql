CREATE OR REPLACE FUNCTION personalizaciones.FSBVALIDARIDENTIFICACION(isbIdentificacion IN ge_subscriber.identification%TYPE,
                                                                      inuIdent_type_id  IN ge_subscriber.ident_type_id%TYPE) 
RETURN VARCHAR2 IS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : FSBVALIDARIDENTIFICACION
    Descripcion    : Realiza las validaciones de la identificación de acuerdo con su tipo,
                     para el registro de nuevos clientes
    Autor          :
    Fecha          :

    Parámetros              Descripcion
    ============            ===================
    isbIdentificacion        Identificacion cliente
    inuIdent_type_id         Tipo identificacion cliente
        
    Fecha           Autor               Modificación
    =========       =========           ====================
	22-08-2024      pacosta             OSF-3105: Creación
******************************************************************/
    -- Constantes para el control de la traza
    csbMetodo           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;                -- Constante para nombre de función    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    
    --Constantes
    cnuTipoIdentAlfa    CONSTANT NUMBER := 2;
    cnuTipoIdentNR      CONSTANT NUMBER := 110;     
    csbTiposIdentNum    CONSTANT ld_parameter.value_chain%TYPE := pkg_bcld_parameter.fsbobtienevalorcadena('TIPOS_IDENT_NUMERICAS');
    
    --Variables generales
    osbmensaje          VARCHAR2(4000);
    nuTINumerica        NUMBER;  
    nuDigVerIngresado   NUMBER;
    nuDigVerCalculado   NUMBER;
    nuModDigitoVer      NUMBER;
    sberror             VARCHAR2(4000);
    nuerror             NUMBER;
    
    --Cursores
    CURSOR cuTipoIdentNum
    (
        inudato      IN NUMBER,
        isbparametro IN ld_parameter.value_chain%Type
    )
    IS
    SELECT COUNT(1) cantidad
    FROM dual
    WHERE inudato IN
    (
        SELECT to_number(regexp_substr(isbparametro,
                '[^,]+',
                1,
                LEVEL)) AS tipotrabajo
        FROM dual
        CONNECT BY regexp_substr(isbparametro, '[^,]+', 1, LEVEL) IS NOT NULL
    );
        
BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_traza.trace('Identificacion      <= '||isbIdentificacion, csbNivelTraza);
    pkg_traza.trace('Tipo_Identificacion <= '||inuIdent_type_id, csbNivelTraza);  
    
    --Inicialización variable
    osbmensaje := '';
    
    --Valida que la identificación no tenga ceros a la izquierda
    IF SUBSTR(isbIdentificacion,1,1) = 0 THEN
        pkg_traza.trace('Se ingreso una identificacion con ceros a la izquierda' , pkg_traza.cnuNivelTrzDef);
        osbmensaje := 'No se permiten identificaciones con ceros a la izquierda, por favor realizar su corrección'; 
        Pkg_Error.SetErrorMessage( isbMsgErrr => osbmensaje);
    END IF;
    
    --Si el tipo de ident corresponde con alguno de los parametrizados, la ident debe ser numerica 
    OPEN cuTipoIdentNum(inuIdent_type_id,csbTiposIdentNum);
    FETCH cuTipoIdentNum INTO nuTINumerica;
    CLOSE cuTipoIdentNum;
    
    IF nuTINumerica > 0 THEN
        
        --Valida que la identificación sea numerica
        IF REGEXP_COUNT(isbIdentificacion, '[^0-9]') > 0 THEN
            pkg_traza.trace('Se ingreso una identificacion con caracteres especiales y/o alfabeticos' , pkg_traza.cnuNivelTrzDef);
            osbmensaje := 'El tipo de identificación no permite caracteres especiales y/o alfabéticos para la identificación, por favor realizar su corrección'; 
            Pkg_Error.SetErrorMessage( isbMsgErrr => osbmensaje);
        END IF;
    END IF;
    
    --Valida si el tipo de indetificacion es 2
    IF inuIdent_type_id = cnuTipoIdentAlfa THEN
        
        --valida si la identificacion contiene caracteres especiales
        IF REGEXP_COUNT(isbIdentificacion, '[^a-zA-Z0-9]') > 0 THEN
            pkg_traza.trace('Se ingreso una identificacion de tipo 2 con caracteres especiales' , pkg_traza.cnuNivelTrzDef);
            osbmensaje := 'El tipo de identificación 2 - pasaporte, no permite caracteres especiales para la identificación, por favor realizar su corrección'; 
            Pkg_Error.SetErrorMessage( isbMsgErrr => osbmensaje);
        END IF;
    END IF;
    
    --Valida si el tipo de identificacion es 110
    IF inuIdent_type_id = cnuTipoIdentNR THEN
        
        --valida que la longitud de la cadena sea 10
        IF LENGTH(isbIdentificacion) <> 10 THEN
            pkg_traza.trace('Se ingreso una indetificacion de tipo 110 con una longitud diferente de 10' , pkg_traza.cnuNivelTrzDef);
            osbmensaje := 'Para el tipo de identificación 110 - Nit/Rut, la longitud de la identificación debe ser diez, por favor realizar su corrección';                
           
            Pkg_Error.SetErrorMessage( isbMsgErrr => osbmensaje);
        END IF;
    
        --Obtiene el digito de verificacion de la identificacion ingresada
        nuDigVerIngresado := SUBSTR(isbIdentificacion,-1);
        
        --calcula digito de verificación a la identificación ingresada
        nuModDigitoVer := MOD(CAST(SUBSTR(isbIdentificacion, 1, 1) AS NUMBER) * 41 +
                        CAST(SUBSTR(isbIdentificacion, 2, 1) AS NUMBER) * 37 +
                        CAST(SUBSTR(isbIdentificacion, 3, 1) AS NUMBER) * 29 +
                        CAST(SUBSTR(isbIdentificacion, 4, 1) AS NUMBER) * 23 +
                        CAST(SUBSTR(isbIdentificacion, 5, 1) AS NUMBER) * 19 +
                        CAST(SUBSTR(isbIdentificacion, 6, 1) AS NUMBER) * 17 +
                        CAST(SUBSTR(isbIdentificacion, 7, 1) AS NUMBER) * 13 +
                        CAST(SUBSTR(isbIdentificacion, 8, 1) AS NUMBER) * 7 +
                        CAST(SUBSTR(isbIdentificacion, 9, 1) AS NUMBER) * 3, 11);
        
        IF nuModDigitoVer IN (0, 1) THEN
            nuDigVerCalculado := nuModDigitoVer;
        ELSE   
            nuDigVerCalculado := 11 - nuModDigitoVer;
        END IF;   
        
        --Se valida el digito de verificación ingresado
        IF nuDigVerIngresado <> nuDigVerCalculado THEN
            pkg_traza.trace('Se ingreso un digito de verificacion para la indetificacion de tipo 110 incorrecto' , pkg_traza.cnuNivelTrzDef);
            osbmensaje := 'El digito de verificación ingresado para la indetificación de tipo 110 - Nit/Rut no es correcto, por favor realizar su corrección';            
            Pkg_Error.SetErrorMessage( isbMsgErrr => osbmensaje);
        END IF;  
    END IF; 
    
    return osbmensaje;
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    
EXCEPTION
    WHEN pkg_error.controlled_error  THEN
        pkg_error.geterror(nuerror, sberror);        
        pkg_traza.TRACE('sbError: ' || sberror, csbNivelTraza);
        pkg_traza.TRACE(csbMetodo, csbNivelTraza, csbFin_Erc);
        return sberror;
    WHEN OTHERS THEN
        pkg_error.seterror;
        pkg_error.geterror(nuerror, sberror);        
        pkg_traza.TRACE('sbError: ' || sberror, csbNivelTraza);
        pkg_traza.TRACE(csbMetodo, csbNivelTraza, csbFin_Erc);
        return sberror; 
END FSBVALIDARIDENTIFICACION;
/
begin
    pkg_utilidades.prAplicarPermisos('FSBVALIDARIDENTIFICACION','PERSONALIZACIONES');
end;
/