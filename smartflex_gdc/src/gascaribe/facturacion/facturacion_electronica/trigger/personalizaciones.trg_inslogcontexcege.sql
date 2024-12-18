CREATE OR REPLACE TRIGGER personalizaciones.TRG_INSLOGCONTEXCEGE 
BEFORE INSERT or UPDATE or DELETE ON contratos_omitir_nit_generico
 FOR EACH ROW
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : TRG_INSLOGCONTEXCEGE
    Descripcion     : trigger para insertar log  excepcion de contrato para cedula generica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 26-11-2024

    Parametros de Entrada
      
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       26-11-2024   OSF-3649    Creacion
  ***************************************************************************/
  DECLARE
     -- Constantes para el control de la traza
     csbMT_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
     -- Identificador del ultimo caso que hizo cambios
     csbVersion     CONSTANT VARCHAR2(15) := 'OSF-3649';
     sbExiste  VARCHAR2(1);
     sbAccion  VARCHAR2(1);
     nuError   NUMBER;
     sbError   VARCHAR2(4000);
     styContExcepcionLog  pkg_contrato_omitir_nitgene.styContOmitirCeduGeneLog;
     nuContrato  NUMBER;
     
     CURSOR cuExisteContrato IS
     SELECT 'X'
     FROM suscripc
     WHERE susccodi = nuContrato;
 BEGIN
   pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
   
   nuContrato := nvl(:new.contrato, :old.contrato);
   
   IF INSERTING OR UPDATING THEN
      IF cuExisteContrato%ISOPEN THEN   CLOSE cuExisteContrato;  END IF;
      
      OPEN cuExisteContrato;
      FETCH cuExisteContrato INTO sbExiste;
      CLOSE cuExisteContrato;
      
      IF sbExiste IS NULL THEN
         pkg_error.setErrorMessage(isbMsgErrr => ' Contrato ['||nuContrato||'] no existe');
      END IF;
      sbAccion := CASE WHEN INSERTING THEN 'I' ELSE 'U' END;
   ELSE
      sbAccion := 'D';
   END IF;
   --se llena registro de log
   styContExcepcionLog.contrato := nuContrato;
   styContExcepcionLog.accion := sbAccion;
   styContExcepcionLog.usuario := pkg_session.getUser;
   styContExcepcionLog.terminal := pkg_session.fsbgetTerminal;
   styContExcepcionLog.fecha_registro := sysdate;
   
   pkg_contrato_omitir_nitgene.prInsertarExceContLog( styContExcepcionLog,
                                                    nuError,
                                                    sbError);
   IF nuError <> 0 THEN
      RAISE pkg_error.CONTROLLED_ERROR;
   END IF;
   pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
 EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError, sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError, sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE pkg_error.CONTROLLED_ERROR;
END;
/