CREATE OR REPLACE TRIGGER PERSONALIZACIONES.TRG_VALIDA_IDENT_CLIENTE
BEFORE INSERT OR UPDATE OF IDENTIFICATION, IDENT_TYPE_ID ON GE_SUBSCRIBER
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
WHEN (NEW.SUBS_STATUS_ID != 3)

DECLARE
/************************************************************************************************************
  Autor       : PAOLA ACOSTA
  Fecha       : 17-09-2024
  Proceso     : PERSONALIZACIONES.TRG_VALIDA_IDENT_CLIENTE
  Ticket      : OSF-3174
  Descripcion : Trigger validar que la identificación de un cliente cumpla con la politica.

  Historia de Modificaciones
  Fecha               Autor                             Modificacion
  =========           =========                      ====================
  17-09-2024          pacosta                        OSF-3174: CREACION 
  13-09-2024          dsaltarin                      OSF-3293: Se modifica para que solo se ejecute al insetar 
                                                     un nuevo cliente o cuando actualicen el numero o tipo de 
                                                     identificación.
  16-09-2024          lvalencia                      OSF-3304: se agrega condicion WHEN (NEW.SUBS_STATUS_ID != 3)                                
  18-09-2024          pacosta                        OSF-3293: Se inserta condición para solo insertar en la tabla fe_validacion_identificacion
                                                     cuando el tipo de identificación es 110.
                                                     Se inserta condición para solo mantener un registro en la tabla fe_validacion_identificacion
                                                     cuando el tipo de identificación es 110, si el cliente existe y la nueva identificación es diferente de la
                                                     IDENT_NUEVA en fe_validacion_identificacion, se actualiza el registro para los campos IDENT_ANTERIOR y 
                                                     IDENT_NUEVA, si el cliente no existe se registra.
  09-10-2024          felipe.valencia                OSF-3436: Se modifica para validar que se ejecute la logica
                                                     en la actualización solo cuando los datos tipo y número de 
                                                     identificación varien                                                        
 *************************************************************************************************************/
    --Constantes
	csbMT_NAME          VARCHAR2(100) := $$PLSQL_UNIT;
    csbValido           CONSTANT fe_validacion_identificacion.valido%TYPE := 'S';
    csbObservacion      CONSTANT fe_validacion_identificacion.observacion%TYPE := 'Id Validado';   
    cnuTipoIdentNR      CONSTANT parametros.valor_cadena%TYPE := pkg_parametros.fsbgetvalorcadena('TIPO_IDENT_INSERT_TBL_FVI'); --110
    
    --Variables
	sbError             VARCHAR(4000);
	nuError             NUMBER;
    
    --Variables
    sbIdentificacion    ge_subscriber.identification%TYPE;
    nuident_type_id     ge_subscriber.ident_type_id%TYPE;    
    rcregistro          fe_validacion_identificacion%ROWTYPE;
    rcRegistroVal       pkg_fe_validacion_identifica.cuRegistroRId%ROWTYPE;
    nurowid             ROWID;
    nuSubscriber_id     ge_subscriber.subscriber_id%TYPE;
    sbIdent_anterior    fe_validacion_identificacion.ident_anterior%TYPE;
    sbValidar           VARCHAR2(4000);
    nuTIRegTFVI         NUMBER;
    
    --Cursores
    CURSOR cuTipoIdentRegTblFVI
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
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    
    IF ( (UPDATING AND :OLD.identification != :NEW.identification) OR (UPDATING AND :OLD.ident_type_id != :NEW.ident_type_id) OR INSERTING ) THEN
    
        IF UPDATING AND :OLD.identification != :NEW.identification THEN
            sbIdentificacion := :NEW.identification;  
            nuSubscriber_id := :OLD.subscriber_id;
            sbIdent_anterior := :OLD.identification;
            
            IF :OLD.ident_type_id != :NEW.ident_type_id THEN
                nuident_type_id := :NEW.ident_type_id;
            ELSE 
                nuident_type_id := :OLD.ident_type_id;
            END IF;                     
            
            pkg_traza.trace('REGISTRO UPDATE| sbIdentificacion: ' || sbIdentificacion || ' nuident_type_id: ' || nuident_type_id, pkg_traza.cnuNivelTrzDef);
            
        ELSIF UPDATING AND :OLD.ident_type_id != :NEW.ident_type_id THEN
        
            nuident_type_id := :NEW.ident_type_id;
            sbIdentificacion := :OLD.identification;
            nuSubscriber_id := :OLD.subscriber_id;
            sbIdent_anterior := :OLD.identification;
            
             pkg_traza.trace('REGISTRO UPDATE| sbIdentificacion: ' || sbIdentificacion || ' nuident_type_id: ' || nuident_type_id, pkg_traza.cnuNivelTrzDef);
        ELSE
            sbIdentificacion := :NEW.identification;  
            sbIdent_anterior := '-';
            nuident_type_id := :NEW.ident_type_id;
            nuSubscriber_id := :NEW.subscriber_id;
            
            pkg_traza.trace('REGISTRO INSERT| sbIdentificacion: ' || sbIdentificacion || ' nuident_type_id: ' || nuident_type_id, pkg_traza.cnuNivelTrzDef);
            
        END IF;  
        
        sbValidar := fsbvalidaridentificacion(sbIdentificacion, nuident_type_id);   
            
        IF sbValidar IS NULL THEN
            
            --valida si el tipo de identificacion debe registrar en FE_VALIDACION_IDENTIFICACION
            OPEN cuTipoIdentRegTblFVI(nuident_type_id,cnuTipoIdentNR);
            FETCH cuTipoIdentRegTblFVI INTO nuTIRegTFVI;
            CLOSE cuTipoIdentRegTblFVI;
            
            IF nuTIRegTFVI > 0 THEN
            
                --Obtiene datos para registrar en la tabla FE_VALIDACION_IDENTIFICACION             
                rcregistro.ID_CLIENTE := nuSubscriber_id; 
                rcregistro.IDENT_ANTERIOR := sbIdent_anterior; 
                rcregistro.IDENT_NUEVA := sbIdentificacion; 
                rcregistro.VALIDO := csbValido;
                rcregistro.OBSERVACION := csbObservacion;
                
                
                IF pkg_fe_validacion_identifica.fblexiste(rcregistro.ID_CLIENTE) THEN
                    
                     --obtiene registro de la tabla fe_validacion_identifica 
                     rcRegistroVal := pkg_fe_validacion_identifica.frcObtRegistroRId(rcregistro.ID_CLIENTE);
                     
                     --valida si la nueva dentificacion ingresada es diferente de la  registrada en la tabla fe_validacion_identifica
                     IF rcRegistroVal.IDENT_NUEVA <> rcregistro.IDENT_NUEVA THEN
                        
                        --actualiza registro en la tabla FE_VALIDACION_IDENTIFICACION
                        pkg_fe_validacion_identifica.prUpdRegistro(rcregistro);
                     END IF;
                ELSE
                
                    --inserta registro en la tabla FE_VALIDACION_IDENTIFICACION
                    pkg_fe_validacion_identifica.prinsregistro(rcregistro, nurowid);   
                END IF;
                
            END IF;
        
        ELSE
            Pkg_Error.SetErrorMessage( isbMsgErrr => sbValidar);
        END IF;
    
    END IF;
    
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    
EXCEPTION
    WHEN pkg_error.controlled_error  THEN
          pkg_error.geterror(nuerror, sberror);
          pkg_traza.TRACE('sbError: ' || sberror, pkg_traza.cnuniveltrzdef);
          pkg_traza.TRACE(csbmt_name, pkg_traza.cnuniveltrzdef, pkg_traza.csbfin_erc);
          RAISE pkg_error.controlled_error;
    WHEN OTHERS THEN

          pkg_error.seterror;
          pkg_error.geterror(nuerror, sberror);
          pkg_traza.TRACE('sbError: ' || sberror, pkg_traza.cnuniveltrzdef);
          pkg_traza.TRACE(csbmt_name, pkg_traza.cnuniveltrzdef, pkg_traza.csbfin_err);
          RAISE pkg_error.controlled_error;   
END TRG_VALIDA_IDENT_CLIENTE;
/