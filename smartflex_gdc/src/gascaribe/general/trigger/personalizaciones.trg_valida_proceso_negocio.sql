CREATE OR REPLACE TRIGGER PERSONALIZACIONES.TRG_VALIDA_PROCESO_NEGOCIO
BEFORE INSERT OR UPDATE ON  OBJETOS_ACCION
FOR EACH ROW
DECLARE
  /**************************************************************************************
  Propiedad Intelectual de Gases del Caribe

  Trigger     : TRG_VALIDA_PROCESO_NEGOCIO
  Descripcion : trigger para validar la existencia del ID del procesonegocio en la entidad OPEN.PROCESO_NEGOCIO
  Autor       : jsoto
  Fecha       : 11-10-2024

  Historia de Modificaciones

    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  /*Variable para almacenar valor del proceso*/
  nuExiste        NUMBER;
  nuError         NUMBER;
  sbError         VARCHAR2(4000);
  
  --cursor para validar si existe el id del procesonegocio
  cursor cuValidaProcesoNegocio(inuProceso number)is
  select count(1)  
   from proceso_negocio
	where codigo = inuProceso;
  
BEGIN
  /*Validamos si el tipo de trabajo del item es igual a tipo de trabajo que tiene registrado la actividad*/

    IF :new.procesonegocio IS NOT NULL THEN
    
			OPEN cuValidaProcesoNegocio(:new.procesonegocio);
			FETCH cuValidaProcesoNegocio INTO nuExiste;
			CLOSE cuValidaProcesoNegocio;
				

			/*En caso de no tener ningun registro mandaremos error*/
			IF nuExiste = 0 then
                pkg_error.setErrorMessage(
                                            isbMsgErrr => 'El ID del Proceso de Negocio '||:new.procesonegocio||' no se encuentra configurado en la entidad PROCESO_NEGOCIO'
                                         );
			END IF;
    END IF;
    
EXCEPTION
  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
  WHEN others THEN
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
END;
/
