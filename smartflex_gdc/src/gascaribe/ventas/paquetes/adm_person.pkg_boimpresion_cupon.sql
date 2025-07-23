CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_BOIMPRESION_CUPON IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_BOIMPRESION_CUPON
    Descripcion     : Paquete para imprimir cupon para el PB LDICU
  
    Autor           : Jhon Jairo Soto
    Fecha           : 27-11-2024
  
    Parametros de Entrada
  
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  PROCEDURE prcImprimirCupon(inuConfexme    IN ed_confexme.coemcodi%type,
							 inuCuponId     IN NUMBER
                             );


END PKG_BOIMPRESION_CUPON;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_BOIMPRESION_CUPON IS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-3636';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : fsbVersion
      Descripcion     : Retona ultimo caso
      Autor           : Jhon Jairo Soto
      Fecha           : 28-11-2024
    
      Modificaciones  :
      Autor       Fecha       Caso       Descripcion
    ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  PROCEDURE prcImprimirCupon(inuConfexme    IN ed_confexme.coemcodi%type,
							 inuCuponId     IN NUMBER
							 ) IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcImprimirCupon
      Descripcion     : proceso que genera cupon PB LDICU
    
      Autor           : Jhon Jairo Soto
      Fecha           : 27-11-2024
    
      Parametros de Entrada
      inuConfexme      Codigo de CONFEXME 
    
      Parametros de Salida
    
      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso       Descripcion
    ***************************************************************************/
    -- Nombre de este m?todo
    csbMT_NAME VARCHAR2(105) := csbSP_NAME ||
                                '.prcImprimirCupon';
  
    onuErrorCode    number;
    osbErrorMessage varchar2(4000);
  
    --Variables para el FCED
	rcConfexme      pktbled_confexme.cuEd_Confexme%rowtype; 
	clClobData      clob;   -- Data de la cotizacion
	nuFormatId      ed_formato.formcodi%type;

  
  BEGIN
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  

        -- Obtiene el registro del tipo de formato de extraccion y mezcla
        pkBCED_Confexme.ObtieneRegistro   --
        (
            inuConfexme,
            rcConfexme
        );

        -- Instancia la entidad base
        pkBODataExtractor.InstanceBaseEntity
        (
            inuCuponId,
            'CUPON',
            constants_per.GetTrue
        );

        --Obtiene el codigo del formato
        nuFormatId := pkbced_formato.fnugetformcodibyiden(rcConfexme.coempada);

        pkg_traza.Trace('Codigo del formato: '||nuFormatId);
        pkg_traza.Trace('Nombre de la plantilla: ' || rcConfexme.coempadi);

        --  Ejecuta proceso de extraccion de datos para formato digital
        pkBODataExtractor.ExecuteRules( nuFormatId, clClobData );

        -- Instancia el numero del cupon a imprimir
        pkBOED_DocumentMem.Set_PrintDocId(inuCuponId);

        -- Almancena en memoria el archivo para el proceso de extraccion y mezcla
        pkboed_documentmem.Set_PrintDoc( clClobData );

        -- Almancena en memoria la plantilla para extraccion y mezcla
        pkboed_documentmem.SetTemplate( rcConfexme.coempadi );

        pkg_traza.trace('Salida:'||to_char(clClobData));
		
        --  Proceso .NET de impresion de duplicado
        GE_BOIOpenExecutable.PrintPreviewerRule();

    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('Error: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('Error: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
  END prcImprimirCupon;


END PKG_BOIMPRESION_CUPON;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion PKG_BOIMPRESION_CUPON
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOIMPRESION_CUPON', 'ADM_PERSON'); 
END;
/