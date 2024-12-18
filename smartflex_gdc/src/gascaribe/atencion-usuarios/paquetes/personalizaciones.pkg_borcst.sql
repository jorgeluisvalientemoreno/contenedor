create or replace PACKAGE PERSONALIZACIONES.PKG_BORCST AS

    /**************************************************************************
    Propiedad intelectual de Gases del Caribe

    Nombre del Paquete: PKG_BORCST
    Descripcion : PACKAGE para manejo ejecutable RCST.

    Autor       : Jhon Jairo Soto
    Fecha       : 18 Noviembre de 2024

    Historia de Modificaciones
      Fecha             Autor                Modificaci?n
    =========         =========          ====================

   **************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2;
    --------------------------------------------------------------------------
    --Tabla PL para el manejo de valores de Repetibilidad.
    --------------------------------------------------------------------------


    --------------------------------------------------------------------------
    -- Metodos publicos del PACKAGE
    --------------------------------------------------------------------------

    /*CREA Orden de Ajuste*/
   PROCEDURE prcProcesaRCST(
								 isbTipoInfo_Id  IN varchar2,
								 isbFechaReg 	 IN varchar2,
								 isbObservacion  IN varchar2
								);

END PKG_BORCST;
/

 CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BORCST AS
  /**************************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: PERSONALIZACIONES.PKG_BORCST
    Descripcion : PACKAGE para manejo de PB RCST.

    Autor       : Jhon Jairo Soto
    Fecha       : 18 noviembre de 2024

    Historia de Modificaciones
      Fecha             Autor                Modificaci?n
    =========         =========          ====================

   **************************************************************************/


    -- Declaracion de variables y tipos globales privados del paquete

    ---------------------------------------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    ---------------------------------------------------------------------------
    csbVersion          CONSTANT VARCHAR2(10) := 'OSF-3604';
    csbSP_NAME          CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';

    /*
      Funci?n que devuelve la versi?n del pkg*/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
      return csbVersion;
    END FSBVERSION;


   PROCEDURE prcProcesaRCST(
							 isbTipoInfo_Id  IN varchar2,
							 isbFechaReg 	 IN varchar2,
							 isbObservacion  IN varchar2
							)
   IS

     --  Variables para manejo de Errores
     sbErrorMessage              VARCHAR2(2000);
     nuErrorCode                 NUMBER;
     csbMT_NAME  				 VARCHAR2(200) := csbSP_NAME || 'prcProcesaRCST';
	 rcActCallCenter         	 daldc_actcallcenter.styldc_actcallcenter;
	 nuUserId                	 sa_user.user_id%type;
     nuPersonID                  NUMBER;


   BEGIN

	 pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

		 rcActCallCenter.actcc_id := pkg_gestionsecuencias.fnuseq_ldc_actcallcenter;
		 rcActCallCenter.tipoinfo_id := to_number(isbTipoInfo_Id);
		 rcActCallCenter.fechareg := to_date(isbFechaReg,ldc_boconsgenerales.fsbgetformatofecha);
		 rcActCallCenter.observacion := isbObservacion;

		 rcActCallCenter.terminal := pkg_session.fsbgetterminal;

		 nuUserId :=  pkg_session.getuserid;
		 nuPersonId := pkg_bopersonal.fnuobtpersonaporusuario(nuUserId);
		 rcActCallCenter.Person_Id :=  nuPersonId;

		 daldc_actcallcenter.insrecord(rcActCallCenter);

     pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


   EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuerrorcode, sbErrorMessage);
      pkg_traza.trace('sbErrorMessage: ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuerrorcode, sbErrorMessage);
      pkg_traza.trace('sbErrorMessage: ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;

   END prcProcesaRCST;

END  PKG_BORCST;
/

PROMPT Otorgando permisos de ejecución 
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BORCST', 'PERSONALIZACIONES');
END;
/