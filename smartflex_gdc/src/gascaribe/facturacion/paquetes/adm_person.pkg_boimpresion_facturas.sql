CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_BOIMPRESION_FACTURAS IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_BOIMPRESION_FACTURAS
    Descripcion     : Paquete para imprimir factura no recurrente para el PB PBIFSE
  
    Autor           : Jorge Luis Valiente Moreno
    Fecha           : 28-12-2023
  
    Parametros de Entrada
  
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  PROCEDURE prcImprimirFacturaEnServidor(inuConfexmeId  IN ed_confexme.coemcodi%type,
                                         inuFactura     IN NUMBER,
                                         isbRutaSistema IN VARCHAR2);

END PKG_BOIMPRESION_FACTURAS;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_BOIMPRESION_FACTURAS IS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-1999';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : fsbVersion
      Descripcion     : Retona DATA de usuarios
      Autor           : Jorge Luis Valiente Moreno
      Fecha           : 28-12-2023
    
      Modificaciones  :
      Autor       Fecha       Caso       Descripcion
    ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  PROCEDURE prcImprimirFacturaEnServidor(inuConfexmeId  IN ed_confexme.coemcodi%type,
                                         inuFactura     IN NUMBER,
                                         isbRutaSistema IN VARCHAR2) IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcImprimirFacturaEnServidor
      Descripcion     : proceso que genera PDF de la factura no recuirrente para PB
    
      Autor           : Jorge Luis Valiente Moreno
      Fecha           : 28-12-2023
    
      Parametros de Entrada
      inuConfexme      Codigo de CONFEXME para imprimir PDF
      isbRutaSistema   Ruta del sistema para imprimir el PDF
    
      Parametros de Salida
    
      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso       Descripcion
    ***************************************************************************/
    -- Nombre de este m?todo
    csbMT_NAME VARCHAR2(105) := csbSP_NAME ||
                                '.prcImprimirFacturaEnServidor';
  
    onuErrorCode    number;
    osbErrorMessage varchar2(4000);
  
    --Variables para el FCED
    clClobData       clob;
    rcTemplate       pktblED_ConfExme.cuEd_Confexme%rowtype; /* Plantilla */
    sbFormatIdent    ed_confexme.coempada%type; /* Identificador del formato */
    nuDigiFormatCode ed_formato.formcodi%type; /* Codigo del formato */
    sbTemplate       ed_confexme.coempadi%type; /* Template */
    --------------------------------
  
  BEGIN
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Factura: ' || inuFactura, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Ruta Sistema: ' || isbRutaSistema,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Confexme: ' || inuConfexmeId,
                    pkg_traza.cnuNivelTrzDef);
  
    --Inicio Instanciar DATA para el posterior uso de esta DATA en FCED
    --inicio datos para instanciar al paquete del formato de factura venta
    GE_BOINSTANCECONTROL.ADDGLOBALATTRIBUTE('FACTCODI', inuFactura);
    --Fin Instanciado de DATA
  
    --Inicio Logica del proceso de generacion de PDF
    pkBCED_Confexme.ObtieneRegistro(inuConfexmeId, rcTemplate);
  
    --Obtiene la configuracion de extraccion y mezcla
    sbFormatIdent := rcTemplate.coempada;
    pkg_traza.trace('Configuracion de extraccion y mezcla: ' ||
                    sbFormatIdent,
                    pkg_traza.cnuNivelTrzDef);
  
    --Obtiene el formato
    nuDigiFormatCode := pkBOInsertMgr.GetCodeFormato(sbFormatIdent);
    pkg_traza.trace('Formato: ' || nuDigiFormatCode,
                    pkg_traza.cnuNivelTrzDef);
  
    --  Ejecuta proceso de extraccion de datos, puede retornar datos en texto plano, xml o html
    pkBODataExtractor.ExecuteRules(nuDigiFormatCode, clClobData);
  
    --Obtiene el template
    sbTemplate := rcTemplate.coempadi;
    pkg_traza.trace('Template: ' || sbTemplate, pkg_traza.cnuNivelTrzDef);
  
    --Genera el PDF y los genera en al ruta definida
    id_bogeneralprinting.ExportToPDFFromMem(isbRutaSistema,
                                            'FACTURA_' || inuFactura,
                                            sbTemplate,
                                            clClobData);
    --Fin Loigca generacion PDF
  
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
  END prcImprimirFacturaEnServidor;

END PKG_BOIMPRESION_FACTURAS;
/
