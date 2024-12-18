CREATE OR REPLACE PACKAGE PKG_UIPBIFSE IS

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_UIPBIFSE
    Descripcion     : Paquete para imprimir factura no recurrente para el PB PBIFSE
  
    Autor           : Jorge Luis Valiente Moreno
    Fecha           : 28-12-2023
  
    Parametros de Entrada
  
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  PROCEDURE prcImprimirEstadoCuenta;

END PKG_UIPBIFSE;
/
CREATE OR REPLACE PACKAGE BODY PKG_UIPBIFSE IS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-3063';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : fsbVersion
      Descripcion     : Retona el identificador del ultimo caso que hizo cambios
      CASO            : OSF-1999
    
      Autor           : Jorge Luis Valiente Moreno
      Fecha           : 28-12-2023
    
      Modificaciones  :
      Autor       Fecha       Caso       Descripcion
    ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  PROCEDURE prcImprimirEstadoCuenta IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcImprimirEstadoCuenta
      Descripcion     : proceso para imprimir la facutra mediante PBIFSE
    
      Autor           : Jorge Luis Valiente Moreno
      Fecha           : 28-12-2023
    
      Parametros de Entrada
          isbFactura          Identificador de la orden.
          inuCurrent     Registro actual.
          inuTotal       Total de registros
      Parametros de Salida
          onuErrorCode   Codigo de error.
          osbErrorMess   Mensaje de error.
      Modificaciones  :
      =========================================================
      Autor           Fecha       Caso       Descripcion
    Jorge Valiente    05/08/2024  OSF-3063   Se realiza llamado del nuevo parametro FECHA_INICIO_FACT_ELECT 
                                             para validar la fecha de generacion de facturacion
    ***************************************************************************/
    -- Nombre de este metodo
    csbMT_NAME VARCHAR2(105) := csbSP_NAME || '.prcImprimirEstadoCuenta';
  
    nuFactura     NUMBER;
    sbFactura     ge_boinstancecontrol.stysbvalue;
    sbRutaSistema ge_boinstancecontrol.stysbvalue;
  
    OnuErrorCode    number;
    OsbErrorMessage varchar2(4000);
  
    nuCodProgFactura varchar2(4000) := pkg_parametros.fsbgetvalorcadena('CODIGO_PROGRAMA_GENERA_FACTURA_EXCLUIDO_GENERAR_PDF_PBIFSE');
  
    cursor cuValidaExistencia(inuValor number) is
      select count(1)
        from dual
       where inuValor in
             (SELECT to_number(regexp_substr(nuCodProgFactura,
                                             '[^,]+',
                                             1,
                                             LEVEL)) AS CodProgFactura
                FROM dual
              CONNECT BY regexp_substr(nuCodProgFactura, '[^,]+', 1, LEVEL) IS NOT NULL);
  
    cursor cuExisteFactura is
      select count(1), f.factprog, f.factfege
        from factura f
       where f.factcodi = nuFactura
       group by f.factprog, f.factfege;
  
    nuExisteFactura   number := 0;
    nuFacturaPrograma number := 0;
  
    --Inicio OSF-3063
    dtFechaInicioFactElect date := pkg_parametros.fdtGetValorFecha('FECHA_INICIO_FACT_ELECT');
    dtFechaGeneracionFact  date;
    --Fin OSF-3603
  
  BEGIN
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    sbFactura := ge_boinstancecontrol.fsbgetfieldvalue('FACTURA',
                                                       'FACTCODI');
  
    sbRutaSistema := ge_boinstancecontrol.fsbgetfieldvalue('GE_SUBSCRIBER',
                                                           'URL');
  
    pkg_traza.trace('Factura: ' || sbFactura, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Ruta: ' || sbRutaSistema, pkg_traza.cnuNivelTrzDef);
  
    nuFactura := TO_NUMBER(sbFactura);
  
    open cuExisteFactura;
    fetch cuExisteFactura
      into nuExisteFactura, nuFacturaPrograma, dtFechaGeneracionFact;
    close cuExisteFactura;
  
    pkg_traza.trace('Existe Factura: ' || nuExisteFactura,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Programa Genera Factura: ' || nuFacturaPrograma,
                    pkg_traza.cnuNivelTrzDef);
  
    if nuExisteFactura = 0 then
      pkg_error.seterrormessage(isbMsgErrr => 'No existe la factura ' ||
                                              nuFactura);
    else
      open cuValidaExistencia(nuFacturaPrograma);
      fetch cuValidaExistencia
        into nuExisteFactura;
      close cuValidaExistencia;
    
      if nuExisteFactura > 0 then
        pkg_error.seterrormessage(isbMsgErrr => 'La factura ' || nuFactura ||
                                                ' con el programa [' ||
                                                nuFacturaPrograma ||
                                                '] no esta autorizada para generar PDF.');
        --Inicio OSF-3063
        --Valida fecha de generacion de la factura contra la fecha del parametro FECHA_INICIO_FACT_ELECT
      else
        if trunc(dtFechaGeneracionFact) >= trunc(dtFechaInicioFactElect) then
          pkg_error.seterrormessage(isbMsgErrr => 'La factura ' ||
                                                  nuFactura ||
                                                  ' no podrá generar PDF debido a que su fecha de generación [' ||
                                                  trunc(dtFechaGeneracionFact) ||
                                                  '] es igual o superior la fecha [' ||
                                                  trunc(dtFechaInicioFactElect) ||
                                                  '] de inicio de facturacion eletronica.');
        end if;
        --Fin OSF-3063
      
      end if;
    
      PKG_BOIMPRE_FACT_SERVI.prcImprimirFacturaEnServidor(nuFactura,
                                                          sbRutaSistema);
    end if;
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
  END prcImprimirEstadoCuenta;

END PKG_UIPBIFSE;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_UIPBIFSE', 'OPEN');
END;
/