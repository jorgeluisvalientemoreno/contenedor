create or replace PACKAGE  personalizaciones.PKG_BOFACTUELECTRONICAGEN IS
  PROCEDURE prGenerarEstrFactElec( inuFactura   IN   NUMBER,
                                   inuCodigoLote IN  NUMBER,
                                   isbOperacion  IN  VARCHAR2,
                                   inuTipoDocu   IN  NUMBER,
                                   inuIdReporte  IN  NUMBER,
								   isbCodEmpresa	 IN  VARCHAR2,
                                   isbNotaNrefe  IN  VARCHAR2 DEFAULT 'N',
                                   onuError     OUT  NUMBER,
                                   osbError     OUT  VARCHAR2);
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGenerarEstrFactElec
    Descripcion     : proceso para generar estructura de facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-01-2024

    Parametros de Entrada
      inuFactura       codigo de la factura
      inuCodigoLote    codigo de lote
      isbOperacion    Operacion a realizar I - Insertar A -Actualizar
      inuTipoDocu     tipo de documento a generar
      inuIdReporte      id del reporte
	  isbCodEmpresa		Códig de empresa
      isbNotaNrefe      indica si la nota es referencia o no
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
	JSOTO		20-03-2025	OSF-4104	Se agrega parametro de entrada isbCodEmpresa
    LJLB        07-03-2025  OSF-4045    se agrega nuevo parametro isbNotaNrefe para validar si la nota es referenciada o no
    LJLB        17-01-2024  OSF-2158    Creacion
  ***************************************************************************/
END PKG_BOFACTUELECTRONICAGEN;
/
create or replace PACKAGE BODY  personalizaciones.PKG_BOFACTUELECTRONICAGEN IS
 -- Constantes para el control de la traza
  csbSP_NAME        CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion        CONSTANT VARCHAR2(15) := 'OSF-4104';
  nuError     NUMBER;
  sbError     VARCHAR(4000);
  nuConsecutivo      NUMBER := 0;

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 16-11-2023

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      15-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  PROCEDURE prGeneraEstrCanalUno(itytCanalUno  IN   pkg_bcfactuelectronicagen.tytCanalUno,
                                 oclDatos      OUT  CLOB ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraEstrCanalUno
    Descripcion     : proceso para generar estructura del canal uno

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-01-2024

    Parametros de Entrada
      itytCanalUno      registro con datos del canal uno
    Parametros de Salida
      oclDatos        clob con datos

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        02-12-2024  OSF-3666    se agrega campo orden de compra 
    LJLB        17-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalUno';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    oclDatos :=
    itytCanalUno.NroCanal						||'|'||
    itytCanalUno.NumeroCompleto                 ||'|'||
    itytCanalUno.TipoDocumento                  ||'|'||
    itytCanalUno.TipoOperacion                  ||'|'||
    itytCanalUno.Ambiente                       ||'|'||
    itytCanalUno.Prefijo                        ||'|'||
    itytCanalUno.NumeroDocumento                ||'|'||
    itytCanalUno.FechaDocumento                 ||'|'||
    itytCanalUno.HoraDocumento                  ||'|'||
    itytCanalUno.FacturaAsociada                ||'|'||
    itytCanalUno.FechaFacturaAsociada           ||'|'||
    itytCanalUno.CodigoConceptoNota             ||'|'||
    itytCanalUno.DescripcionConceptoNota        ||'|'||
    itytCanalUno.SeccionCorreccion              ||'|'||
    itytCanalUno.TipoMoneda                     ||'|'||
    itytCanalUno.NumeroLineas                   ||'|'||
    itytCanalUno.FormaPago                      ||'|'||
    itytCanalUno.CodigoMedioPago                ||'|'||
    itytCanalUno.DescripcionMedioPago           ||'|'||
    itytCanalUno.FechaVencimiento               ||'|'||
    itytCanalUno.FechaInicalPeriodoFacturacion  ||'|'||
    itytCanalUno.HoraInicalPeriodoFacturacion   ||'|'||
    itytCanalUno.FechaFinalPeriodoFacturacion   ||'|'||
    itytCanalUno.HoraFinalPeriodoFacturacion    ||'|'||
    itytCanalUno.TotalValorBruto                ||'|'||
    itytCanalUno.TotalValorBaseImponible        ||'|'||
    itytCanalUno.TotalValorBrutoMasTributos     ||'|'||
    itytCanalUno.TotalDescuentos                ||'|'||
    itytCanalUno.TotalCargos                    ||'|'||
    itytCanalUno.TotalAnticipos                 ||'|'||
    itytCanalUno.Redondeo                       ||'|'||
    itytCanalUno.TotalAPagar                    ||'|'||
    itytCanalUno.ValorLetras                    ||'|'||
    itytCanalUno.ReferenciaPago                 ||'|'||
    itytCanalUno.SaldoFavor                     ||'|'||
    itytCanalUno.CantidadFacturasVencidas       ||'|'||
    itytCanalUno.FacturasVencidas               ||'|'||
    itytCanalUno.NumeroContrato                 ||'|'||
    itytCanalUno.OrdenCompraFactura             ||'|'||
    itytCanalUno.FechaOrdenCompra               ||'|'||
    itytCanalUno.OrdenDespacho                  ||'|'||
    itytCanalUno.FechaOrdenDespacho             ||'|'||
    itytCanalUno.DocumentoRecepcion             ||'|'||
    itytCanalUno.FechaDocumentoRecepcion        ||'|'||
    itytCanalUno.Observaciones                  ||'|'||
    itytCanalUno.CodigoCentroCostos             ||'|'||
    itytCanalUno.NombreCentroCostos             ||'|'||
    itytCanalUno.MesFacturado                   ||'|'||
    itytCanalUno.PeriodoFacturado               ||'|'||
    itytCanalUno.DiasDeConsumo                  ||'|'||
    itytCanalUno.NumeroDeControl                ||'|'||
    itytCanalUno.PeriodoDeConsumo               ||'|'||
    itytCanalUno.ValorEnReclamo                 ||'|'||
    itytCanalUno.CupoBrilla                     ||'|'||
    itytCanalUno.LecturaAnterior                ||'|'||
    itytCanalUno.LecturaActual                  ||'|'||
    itytCanalUno.CausalNoLectura                ||'|'||
    itytCanalUno.ConsumoActual                  ||'|'||
    itytCanalUno.FactordeCorreccion             ||'|'||
    itytCanalUno.FechaSuspMora                  ||'|'||
    itytCanalUno.NumeroFacturaInter             ||'|'||
    itytCanalUno.ValorTotalXPagar               ||'|'||
    itytCanalUno.ValorTotalFacturaMes           ||'|'||
    itytCanalUno.ObservacionNotas               ||'|'||
    itytCanalUno.Calificacion                   ||'|'||
    itytCanalUno.ordenCompra                    ||'|'||
    itytCanalUno.NoUsar07                       ||'|'||
    itytCanalUno.NoUsar08                       ||'|'||
    itytCanalUno.NoUsar09                       ||'|'||
    itytCanalUno.NoUsar10                       ||'|'||
    itytCanalUno.NoUsar11                       ||'|'||
    itytCanalUno.PromedioDeConsumo              ||'|'||
    itytCanalUno.Temperatura                    ||'|'||
    itytCanalUno.Presion                        ||'|'||
    itytCanalUno.ConsumoEnKWh                   ||'|'||
    itytCanalUno.CalculoDeConsumo               ||'|'||
    itytCanalUno.TipoDeNotificacion             ||'|'||
    itytCanalUno.MensajeGeneral                 ||'|'||
    itytCanalUno.PlazoMaxRP                     ||'|'||
    itytCanalUno.SuspensionporRP                ||'|'||
    itytCanalUno.ComponentesdelCosto            ||'|'||
    itytCanalUno.ReferenciaKPIsCalidad          ||'|'||
    itytCanalUno.CalculoKPIsCalidad             ||'|'||
    itytCanalUno.CodigoBarrasId                 ||'|'||
    itytCanalUno.CodigoBarrasRef_Pago           ||'|'||
    itytCanalUno.CodigoBarrasValor              ||'|'||
    itytCanalUno.CodigoBarrasFechalimite        ||'|'||
    itytCanalUno.CodigoBarrasCompleto           ||'|'||
    itytCanalUno.TRMUltima                      ||'|'||
    itytCanalUno.TRMPromedio                    ||'|'||
    itytCanalUno.Visible                        ||'|'||
    itytCanalUno.Impreso                        ||'|'||
    itytCanalUno.ProteccionDeDatos              ||'|'||
    itytCanalUno.DireccionProducto              ||'|'||
    itytCanalUno.CausaPromedio                  ||'|'||
    itytCanalUno.PagareUnico                    ||'|'||
    itytCanalUno.CambioUso                      ||'|'||
    itytCanalUno.AcumuladoTarifaTransitoria     ||'|'||
    itytCanalUno.FinanciacionEspecial            ||'|'||
    itytCanalUno.MedidorMalUbicado               ||'|'||
    itytCanalUno.ImprimirFactura                 ||'|'||
    itytCanalUno.ValorUltimoPago                 ||'|'||
    itytCanalUno.FechaUltimoPago                 ||'|'||
    itytCanalUno.CantidadLineas                  ||'|'||
    itytCanalUno.CondicionPago                   ||'|'||
    itytCanalUno.NIU                             ||'|'||
    itytCanalUno.TipoProducto                    ||'|'||
    itytCanalUno.ObservacionNoLectura            ||'|'||
    itytCanalUno.ContratistaReparto              ||'|'||
    itytCanalUno.InteresMora                     ||'|'||
    itytCanalUno.PoderCalorifico                 ||'|'||
    itytCanalUno.ConsumoKWh                      ||'|'||
    itytCanalUno.ImprimirTijera                  ||'|'||
    itytCanalUno.BancoUltimoPago                 ||'|'||
    itytCanalUno.Tarifa_GM                       ||'|'||
    itytCanalUno.Tarifa_TM                       ||'|'||
    itytCanalUno.Tarifa_DM                       ||'|'||
    itytCanalUno.Tarifa_CV                       ||'|'||
    itytCanalUno.Tarifa_CC                       ||'|'||
    itytCanalUno.Tarifa_CVARIABLE                ||'|'||
    itytCanalUno.Tarifa_AS                       ||'|'||
    itytCanalUno.Tarifa_PORCSU                   ||'|'||
    itytCanalUno.Tarifa_SUBSIDIADA               ||'|'||
    itytCanalUno.Tarifa_DS                       ||'|'||
    itytCanalUno.Tarifa_CFIJO                    ||'|'||
    itytCanalUno.MesesRevisionTecReg             ||'|'||
    itytCanalUno.NumeroHojas                     ||'|'||
    itytCanalUno.FechaFinaExcencion              ||'|'||
    itytCanalUno.PresionAtmosferica              ||'|'||
    itytCanalUno.MensajePromocion                ||'|'||
    itytCanalUno.TipoNotificacion                ||'|'||
    itytCanalUno.MensajeRevisionSegura           ||'|'||
    itytCanalUno.CampanaID                       ||'|'||
    itytCanalUno.FactImagen                      ||'|'||
	 itytCanalUno.TotalGas                       ||'|'||       
    itytCanalUno.TotalBrilla                     ||'|'|| 
    itytCanalUno.TotalOtrosServicios             ||'|'||
    itytCanalUno.TotalCapital                    ||'|'||
    itytCanalUno.TotalIntereses                  ||'|'||
    itytCanalUno.TotalSaldoDiferidos             ||'|'||
    itytCanalUno.NombreArte                      ||'|'||
    itytCanalUno.TipoFacturaElectrónica          ||'|'||
    itytCanalUno.QRPago                          ;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
  END prGeneraEstrCanalUno;

   PROCEDURE prGeneraEstrCanalUnoA( itytCanalUnoA  IN   pkg_bcfactuelectronicagen.tytCanalUnoa,
                                     oclDatos      OUT  CLOB  ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraEstrCanalUnoa
    Descripcion     : proceso para generar estructura del canal uno a

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itytCanalUnoa      registro con datos del canal uno a
    Parametros de Salida
      oclDatos        clob con datos

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalUnoa';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    oclDatos := itytCanalUnoA.NroCanal||'|'||
    itytCanalUnoA.NumeroCompleto||'|'||
    itytCanalUnoA.IdentificacionAnticipo||'|'||
    itytCanalUnoA.ValorAnticipo||'|'||
    itytCanalUnoA.FechaReciboAnticipo||'|'||
    itytCanalUnoA.FechaPagoAnticipo||'|'||
    itytCanalUnoA.HoraPagoAnticipo||'|'||
    itytCanalUnoA.InstruccionesAnticipo;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
   EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
  END prGeneraEstrCanalUnoA;

  PROCEDURE prGeneraEstrCanalUnoB( itytCanalUnoB  IN   pkg_bcfactuelectronicagen.tytCanalUnob,
                                   oclDatos      OUT  CLOB  ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraEstrCanalUnoB
    Descripcion     : proceso para generar estructura del canal uno

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itytCanalUnoB      registro con datos del canal uno b
    Parametros de Salida
      oclDatos        clob con datos
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalUnoa';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    oclDatos := itytCanalUnoB.NroCanal||'|'||
                itytCanalUnoB.NumeroCompleto||'|'||
                itytCanalUnoB.TipoDescuentoCargo||'|'||
                itytCanalUnoB.IdentificacionDescuentoCargo||'|'||
                itytCanalUnoB.CodigoDescuento||'|'||
                itytCanalUnoB.ObservacionDescuentoCargo||'|'||
                itytCanalUnoB.PorcentajeDescuentoCargo||'|'||
                itytCanalUnoB.ValorTotalDescuentoCargo||'|'||
                itytCanalUnoB.BaseDescuentoCargo;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE pkg_error.CONTROLLED_ERROR;
  END prGeneraEstrCanalUnoB;

  PROCEDURE prGeneraEstrCanalOcho( itbltytCanalOcho  IN   pkg_bcfactuelectronicagen.tbltytCanalOcho,
                                   oclDatos      OUT  CLOB ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraEstrCanalOcho
    Descripcion     : proceso para generar estructura del canal uno G

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itbltytCanalOcho      tabla de registro con datos del canal uno G
    Parametros de Salida
      oclDatos        clob con datos

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalOcho';
    nuContador        NUMBER := 0;
    sbIndex           VARCHAR2(400);
    FUNCTION fclGetEstructura RETURN CLOB IS
        csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.fclGetEstructura';
        cblInfoEstr   CLOB;
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      cblInfoEstr := itbltytCanalOcho(sbIndex).NroCanal||'|'||
                        itbltytCanalOcho(sbIndex).NumeroCompleto||'|'||
                        itbltytCanalOcho(sbIndex).LimInferior||'|'||
                        itbltytCanalOcho(sbIndex).LimSuperior||'|'||
                        itbltytCanalOcho(sbIndex).ValorUnidad||'|'||
                        itbltytCanalOcho(sbIndex).ConsumoRango||'|'||
                        itbltytCanalOcho(sbIndex).ValorConsumoRango;
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
      RETURN cblInfoEstr;

    END fclGetEstructura;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    IF itbltytCanalOcho.COUNT > 0 THEN
        sbIndex := itbltytCanalOcho.FIRST;
        LOOP
          IF nuContador = 0 THEN
            oclDatos := fclGetEstructura;
          ELSE
                oclDatos := oclDatos||CHR(10)||fclGetEstructura;
           END IF;
            nuContador := nuContador + 1;
            sbIndex := itbltytCanalOcho.NEXT(sbIndex);
            EXIT WHEN sbIndex IS NULL;
        END LOOP;
    END IF;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
  END prGeneraEstrCanalOcho;

   PROCEDURE prGeneraEstrCanalNueve( itbltytCanalNueve  IN   pkg_bcfactuelectronicagen.tbltytCanalNueve,
                                   oclDatos      OUT  CLOB  ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraEstrCanalNueve
    Descripcion     : proceso para generar estructura del canal uno H

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itbltytCanalNueve      tabla de registro con datos del canal uno H
    Parametros de Salida
      oclDatos        clob con datos
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalNueve';
    nuContador        NUMBER := 0;
    sbIndex           VARCHAR2(100);
     FUNCTION fclGetEstructura RETURN CLOB IS
        csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.fclGetEstructura';
        cblInfoEstr   CLOB;
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      cblInfoEstr := itbltytCanalNueve(sbIndex).NroCanal||'|'||
                     itbltytCanalNueve(sbIndex).NumeroCompleto||'|'||
                     itbltytCanalNueve(sbIndex).IDOrdenamiento||'|'||
                     itbltytCanalNueve(sbIndex).FechaConsumo||'|'||
                     itbltytCanalNueve(sbIndex).Consumo||'|'||
                     itbltytCanalNueve(sbIndex).DiasConsumo ;

      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
      RETURN cblInfoEstr;
    END fclGetEstructura;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    IF itbltytCanalNueve.COUNT > 0 THEN
        sbIndex := itbltytCanalNueve.FIRST;
        LOOP
          IF nuContador = 0 THEN
             oclDatos := fclGetEstructura ;
          ELSE
            oclDatos := oclDatos||CHR(10)||fclGetEstructura  ;
         END IF;
         nuContador := nuContador  + 1;
         sbIndex := itbltytCanalNueve.NEXT(sbIndex);
         EXIT WHEN sbIndex IS NULL;
        END LOOP;
      END IF;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
   EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
  END prGeneraEstrCanalNueve;

  PROCEDURE prGeneraEstrCanalDos( itytCanalDos  IN   pkg_bcfactuelectronicagen.tytCanalDos,
                                   oclDatos      OUT  CLOB ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraEstrCanalDos
    Descripcion     : proceso para generar estructura del canal dos

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itytCanalDos      registro con datos del canal dos
    Parametros de Salida
      oclDatos        clob con datos
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalDos';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    oclDatos := itytCanalDos.NroCanal||'|'||
                itytCanalDos.NumeroCompleto||'|'||
                itytCanalDos.LlevaAnexos||'|'||
                itytCanalDos.CantidadAnexos||'|'||
                itytCanalDos.NombreAnexo||'|'||
                itytCanalDos.RazonSocial||'|'||
                itytCanalDos.NIT||'|'||
                itytCanalDos.FabricanteSW||'|'||
                itytCanalDos.NombreSW||'|'||
                itytCanalDos.Resolucion||'|'||
                itytCanalDos.ConsecutivoInicial||'|'||
                itytCanalDos.ConsecutivoFinal||'|'||
                itytCanalDos.Prefijo||'|'||
                itytCanalDos.FechaResolucion||'|'||
                itytCanalDos.FechaInicioVigencia||'|'||
                itytCanalDos.FechaFinalVigencia;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
  END prGeneraEstrCanalDos;

  PROCEDURE prGeneraEstrCanalTres( itytCanalTres  IN   pkg_bcfactuelectronicagen.tytCanalTres,
                                   oclDatos      OUT  CLOB  ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraEstrCanalTres
    Descripcion     : proceso para generar estructura del canal tres

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itytCanalTres      registro con datos del canal tres
    Parametros de Salida
      oclDatos        clob con datos

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalTres';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    oclDatos := itytCanalTres.NroCanal||'|'||
                itytCanalTres.NumeroCompleto||'|'||
                itytCanalTres.NaturalezaEmisor||'|'||
                itytCanalTres.CodigoIdentificacionEmisor||'|'||
                itytCanalTres.DescripcionIdentificacionEmi||'|'||
                itytCanalTres.NumeroIdentificacionEmisor||'|'||
                itytCanalTres.DigitoVerificacionEmisor||'|'||
                itytCanalTres.RazonSocialEmisor||'|'||
                itytCanalTres.NombreComercialEmisor||'|'||
                itytCanalTres.MatriculaMercantilEmisor||'|'||
                itytCanalTres.CodDepartamentoExpedicionEmi||'|'||
                itytCanalTres.NomDepartamentoExpedicionEmi||'|'||
                itytCanalTres.CodMunicipioExpedicionEmisor||'|'||
                itytCanalTres.NombreMunicipioExpedicionEmi||'|'||
                itytCanalTres.DireccionExpedicionEmisor||'|'||
                itytCanalTres.CodigoZonaPostalExpedicionEmi||'|'||
                itytCanalTres.CodigoPaisExpedicionEmisor||'|'||
                itytCanalTres.NombrePaisExpedicionEmisor||'|'||
                itytCanalTres.CodigoDepartamentoFiscalEmi||'|'||
                itytCanalTres.NombreDepartamentoFiscalEmi||'|'||
                itytCanalTres.CodigoMunicipioFiscalEmisor||'|'||
                itytCanalTres.NombreMunicipioFiscalEmisor||'|'||
                itytCanalTres.DireccionFiscalEmisor||'|'||
                itytCanalTres.CodigoZonaPostalFiscalEmisor||'|'||
                itytCanalTres.CodigoPaisFiscalEmisor||'|'||
                itytCanalTres.NombrePaisFiscalEmisor||'|'||
                itytCanalTres.TipoRegimenEmisor||'|'||
                itytCanalTres.ResponsabilidadesFiscalesEmi||'|'||
                itytCanalTres.CodigoTributoResponsableEmi||'|'||
                itytCanalTres.NombreTributoResponsableEmi||'|'||
                itytCanalTres.CorreoElectronicoEmisor||'|'||
                itytCanalTres.CorreoElectronicoControler||'|'||
                itytCanalTres.TelefonoEmisor||'|'||
                itytCanalTres.FaxEmisor||'|'||
                itytCanalTres.Opcional21||'|'||
                itytCanalTres.Opcional22||'|'||
                itytCanalTres.Opcional23||'|'||
                itytCanalTres.Opcional24||'|'||
                itytCanalTres.Opcional25||'|'||
                itytCanalTres.Opcional26||'|'||
                itytCanalTres.Opcional27||'|'||
                itytCanalTres.Opcional28||'|'||
                itytCanalTres.Opcional29||'|'||
                itytCanalTres.Opcional30;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
   EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE pkg_error.CONTROLLED_ERROR;
  END prGeneraEstrCanalTres;

  PROCEDURE prGeneraEstrCanalTresA( itytCanalTresA  IN   pkg_bcfactuelectronicagen.tytCanalTresA,
                                   oclDatos      OUT  CLOB ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraEstrCanalTresA
    Descripcion     : proceso para generar estructura del canal tres a

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itytCanalTresA      registro con datos del canal tres a
    Parametros de Salida
      oclDatos        clob con datos
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalTresA';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    oclDatos := itytCanalTresA.NroCanal||'|'||
                itytCanalTresA.NumeroCompleto||'|'||
                itytCanalTresA.CodIdentificacionParticipante||'|'||
                itytCanalTresA.DescIdentificacionParticipante||'|'||
                itytCanalTresA.NumIdentificacionParticipante||'|'||
                itytCanalTresA.DigitoVerificacionParticipante||'|'||
                itytCanalTresA.RazonSocialParticipante||'|'||
                itytCanalTresA.PorcentajeParticipacion||'|'||
                itytCanalTresA.TipoRegimenParticipante||'|'||
                itytCanalTresA.ResponFiscalesParticipante||'|'||
                itytCanalTresA.CodTributoResponParticipante||'|'||
                itytCanalTresA.NombTributoResponParticipante;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
 EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE pkg_error.CONTROLLED_ERROR;
  END prGeneraEstrCanalTresA;

  PROCEDURE prGeneraEstrCanalCuatro( itytCanalCuatro  IN   pkg_bcfactuelectronicagen.tytCanalCuatro,
                                   oclDatos      OUT  CLOB  ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraEstrCanalCuatro
    Descripcion     : proceso para generar estructura del canal cuatro

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itytCanalCuatro      registro con datos del canal cuatro
    Parametros de Salida
      oclDatos        clob con datos
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalCuatro';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    oclDatos := itytCanalCuatro.NroCanal||'|'||
            itytCanalCuatro.NumeroCompleto||'|'||
            itytCanalCuatro.NaturalezaReceptor||'|'||
            itytCanalCuatro.CodigoIdentificacionReceptor	||'|'||
            itytCanalCuatro.DescIdentificacionReceptor||'|'||
            itytCanalCuatro.NumeroIdentificacionReceptor||'|'||
            itytCanalCuatro.DigitoVerificacionReceptor||'|'||
            itytCanalCuatro.RazonSocialReceptor	||'|'||
            itytCanalCuatro.NombreComercialReceptor||'|'||
            itytCanalCuatro.MatriculaMercantilReceptor||'|'||
            itytCanalCuatro.CodigoDepartamentoReceptor||'|'||
            itytCanalCuatro.NombreDepartamentoReceptor||'|'||
            itytCanalCuatro.CodigoMunicipioReceptor||'|'||
            itytCanalCuatro.NombreMunicipioReceptor||'|'||
            itytCanalCuatro.DireccionReceptor||'|'||
            itytCanalCuatro.CodigoZonaPostalReceptor||'|'||
            itytCanalCuatro.CodigoPaisReceptor||'|'||
            itytCanalCuatro.NombrePaisReceptor||'|'||
            itytCanalCuatro.TipoRegimenReceptor||'|'||
            itytCanalCuatro.ResponFiscalesReceptor||'|'||
            itytCanalCuatro.CodTributoResponsableReceptor||'|'||
            itytCanalCuatro.NombTributoResponsableReceptor||'|'||
            itytCanalCuatro.CorreoElectronicoReceptor||'|'||
            itytCanalCuatro.TelefonoReceptor||'|'||
            itytCanalCuatro.FaxReceptor||'|'||
            itytCanalCuatro.NotaContacto||'|'||
            itytCanalCuatro.CodigoIdentificacionAutorizado||'|'||
            itytCanalCuatro.NumeroIdentificacionAutorizado||'|'||
            itytCanalCuatro.DigitoIdentificacionAutorizado||'|'||
            itytCanalCuatro.Uso||'|'||
            itytCanalCuatro.Estrato||'|'||
            itytCanalCuatro.Ciclo||'|'||
            itytCanalCuatro.RutaReparto||'|'||
            itytCanalCuatro.Medidor||'|'||
            itytCanalCuatro.DireccionCobro||'|'||
            itytCanalCuatro.DescripcionBarrio||'|'||
            itytCanalCuatro.CorreoElectronico2||'|'||
            itytCanalCuatro.EstadoTecnico;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
   EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE pkg_error.CONTROLLED_ERROR;
  END prGeneraEstrCanalCuatro;

  PROCEDURE prGeneraEstrCanalCinco( itytCanalCinco  IN   pkg_bcfactuelectronicagen.tytCanalCinco,
                                   oclDatos      OUT  CLOB) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraEstrCanalCinco
    Descripcion     : proceso para generar estructura del canal cinco

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itytCanalCuatro      registro con datos del canal cuatro
    Parametros de Salida
      oclDatos        clob con datos
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalCinco';
    sbIndex           VARCHAR2(50);
    nuContador       number := 0;
    FUNCTION fclGetEstructura RETURN CLOB IS
        csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.fclGetEstructura';
        cblInfoEstr   CLOB;
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      cblInfoEstr := itytCanalCinco.NroCanal||'|'||
      itytCanalCinco.NumeroCompleto||'|'||
      itytCanalCinco.CodigoImpuesto||'|'||
      itytCanalCinco.NombreImpuesto||'|'||
      itytCanalCinco.ValorTotalImpuesto||'|'||
      itytCanalCinco.TipoImpuesto||'|'||
      itytCanalCinco.Opcional41||'|'||
      itytCanalCinco.Opcional42||'|'||
      itytCanalCinco.Opcional43||'|'||
      itytCanalCinco.Opcional44||'|'||
      itytCanalCinco.Opcional45;
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
      RETURN cblInfoEstr;

    END fclGetEstructura;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    oclDatos := fclGetEstructura;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
   EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE pkg_error.CONTROLLED_ERROR;
  END prGeneraEstrCanalCinco;

  PROCEDURE prGeneraEstrCanalCincoA( itbltytCanalCincoA  IN   pkg_bcfactuelectronicagen.tbltytCanalCincoA,
                                     oclDatos      OUT  CLOB) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraEstrCanalCincoA
    Descripcion     : proceso para generar estructura del canal cinco a

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itbltytCanalCincoA     tabla con registro con datos del canal cinco a
    Parametros de Salida
      oclDatos        clob con datos

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalCincoA';
    sbIndex           VARCHAR2(50);
    nuContador       number := 0;
    FUNCTION fclGetEstructura RETURN CLOB IS
        csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.fclGetEstructura';
        cblInfoEstr   CLOB;
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      cblInfoEstr := itbltytCanalCincoA(sbIndex).NroCanal||'|'||
                    itbltytCanalCincoA(sbIndex).NumeroCompleto||'|'||
                    itbltytCanalCincoA(sbIndex).ValorBaseImponible||'|'||
                    itbltytCanalCincoA(sbIndex).ValorImpuesto||'|'||
                    itbltytCanalCincoA(sbIndex).Porcentaje||'|'||
                    itbltytCanalCincoA(sbIndex).UnidadMedidaBaseTributo||'|'||
                    itbltytCanalCincoA(sbIndex).IdentUnidadMedidaTributo||'|'||
                    itbltytCanalCincoA(sbIndex).ValorTributoUnidad||'|'||
                    itbltytCanalCincoA(sbIndex).Opcional46||'|'||
                    itbltytCanalCincoA(sbIndex).Opcional47||'|'||
                    itbltytCanalCincoA(sbIndex).Opcional48||'|'||
                    itbltytCanalCincoA(sbIndex).Opcional49||'|'||
                    itbltytCanalCincoA(sbIndex).Opcional50;

      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
      RETURN cblInfoEstr;

    END fclGetEstructura;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    IF itbltytCanalCincoA.COUNT > 0 THEN
        sbIndex := itbltytCanalCincoA.FIRST;
        LOOP
          IF nuContador = 0 THEN
             oclDatos := fclGetEstructura;
          ELSE
            oclDatos := oclDatos||CHR(10)||fclGetEstructura;
         END IF;
         nuContador := nuContador  + 1;
         sbIndex := itbltytCanalCincoA.NEXT(sbIndex);
         EXIT WHEN sbIndex IS NULL;
        END LOOP;
    END IF;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE pkg_error.CONTROLLED_ERROR;
  END prGeneraEstrCanalCincoA;

  FUNCTION fclGetEstrCanalSeisA( itytCanalSeisA  IN   pkg_bcfactuelectronicagen.tytCanalSeisA )  RETURN CLOB IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fclGetEstrCanalSeisA
    Descripcion     : proceso para generar estructura del canal seis a

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itytCanalSeisA    registro con datos del canal seis a
    Parametros de Salida

    Return
      clob con datos de estructura

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalSeisA';
    cblInfoEstr   CLOB;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    cblInfoEstr :=  itytCanalSeisA.NroCanal||'|'||
                    itytCanalSeisA.NumeroCompleto||'|'||
                    itytCanalSeisA.CodigoIdentificacionMandante||'|'||
                    itytCanalSeisA.NumeroIdentificacionMandante||'|'||
                    itytCanalSeisA.DigitoVerificacionMandante||'|'||
                    itytCanalSeisA.Opcional66||'|'||
                    itytCanalSeisA.Opcional67||'|'||
                    itytCanalSeisA.Opcional68||'|'||
                    itytCanalSeisA.Opcional69||'|'||
                    itytCanalSeisA.Opcional70;
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
     RETURN cblInfoEstr;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' osbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       raise pkg_error.CONTROLLED_ERROR;
  END fclGetEstrCanalSeisA;

  FUNCTION fclGetEstrCanalSeisb( itytCanalSeisB  IN   pkg_bcfactuelectronicagen.tytCanalSeisB )  RETURN CLOB IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fclGetEstrCanalSeisb
    Descripcion     : proceso para generar estructura del canal seis b

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itytCanalSeisB     registro con datos del canal seis b
    Parametros de Salida


    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME    VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalSeisB';
    cblInfoEstr   CLOB;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    cblInfoEstr := itytCanalSeisB.NroCanal||'|'||
                    itytCanalSeisB.NumeroCompleto||'|'||
                    itytCanalSeisB.TipoDescuentoCargoDetalle||'|'||
                    itytCanalSeisB.IdentDescuentoCargoDetalle||'|'||
                    itytCanalSeisB.CodigoDescuentoDetalle||'|'||
                    itytCanalSeisB.ObseDescuentoCargoDetalle||'|'||
                    itytCanalSeisB.PorcDescuentoCargoDetalle||'|'||
                    itytCanalSeisB.ValorTotalDescCargoDetalle||'|'||
                    itytCanalSeisB.BaseDescuentoCargoDetalle;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN cblInfoEstr;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE pkg_error.CONTROLLED_ERROR;
  END fclGetEstrCanalSeisb;

  FUNCTION fclGetEstrCanalSeisc( itytCanalSeisC  IN   pkg_bcfactuelectronicagen.tytCanalSeisC )  RETURN CLOB IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fclGetEstrCanalSeisc
    Descripcion     : proceso para generar estructura del canal seis c

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itytCanalSeisC     registro con datos del canal seis c
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalSeisC';
    cblInfoEstr   CLOB;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    cblInfoEstr := itytCanalSeisC.NroCanal||'|'||
                    itytCanalSeisC.NumeroCompleto||'|'||
                    itytCanalSeisC.CodigoImpuestoDetalle||'|'||
                    itytCanalSeisC.NombreImpuestoDetalle||'|'||
                    itytCanalSeisC.ValorTotalImpuestoDetalle||'|'||
                    itytCanalSeisC.TipoImpuestoDetalle||'|'||
                    itytCanalSeisC.Opcional71||'|'||
                    itytCanalSeisC.Opcional72||'|'||
                    itytCanalSeisC.Opcional73||'|'||
                    itytCanalSeisC.Opcional74||'|'||
                    itytCanalSeisC.Opcional75;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN cblInfoEstr;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       raise pkg_error.CONTROLLED_ERROR;
  END fclGetEstrCanalSeisc;

  FUNCTION fclGetEstrCanalSeisd( itytCanalSeisD  IN   pkg_bcfactuelectronicagen.tytCanalSeisD  ) RETURN CLOB IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fclGetEstrCanalSeisd
    Descripcion     : proceso para generar estructura del canal seis d

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itytCanalSeisD      registro con datos del canal seis d
    Parametros de Salida
      oclDatos        clob con datos

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalSeisD';
    cblInfoEstr   CLOB;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    cblInfoEstr := itytCanalSeisD.NroCanal||'|'||
                    itytCanalSeisD.NumeroCompleto||'|'||
                    itytCanalSeisD.ValorBaseImponibleDetalle||'|'||
                    itytCanalSeisD.ValorImpuestoDetalle||'|'||
                    itytCanalSeisD.PorcentajeDetalle||'|'||
                    itytCanalSeisD.UnidMedidaBaseTributoDetalle||'|'||
                    itytCanalSeisD.IdenUnidMedidaTributoDetalle||'|'||
                    itytCanalSeisD.ValorTributoUnidadDetalle||'|'||
                    itytCanalSeisD.Opcional76||'|'||
                    itytCanalSeisD.Opcional77||'|'||
                    itytCanalSeisD.Opcional78||'|'||
                    itytCanalSeisD.Opcional79||'|'||
                    itytCanalSeisD.Opcional80;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN cblInfoEstr;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE pkg_error.CONTROLLED_ERROR;
  END fclGetEstrCanalSeisd;

  PROCEDURE prGeneraEstrCanalSeis( itbltytCanalSeis  IN   pkg_bcfactuelectronicagen.tbltytCanalSeis,
                                   oclDatos      OUT  CLOB ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraEstrCanalSeis
    Descripcion     : proceso para generar estructura del canal seis

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itbltytCanalSeis     tabla con registro con datos del canal seis
    Parametros de Salida
      oclDatos        clob con datos
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalSeis';
    sbIndex           VARCHAR2(50);
    nuContador       number := 0;
    FUNCTION fclGetEstructura RETURN CLOB IS
        csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.fclGetEstructura';
        cblInfoEstr   CLOB;
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      cblInfoEstr := itbltytCanalSeis(sbIndex).NroCanal||'|'||
                    itbltytCanalSeis(sbIndex).NumeroCompleto||'|'||
                    itbltytCanalSeis(sbIndex).IDOrdenamiento||'|'||
                    itbltytCanalSeis(sbIndex).EstandarArticulo||'|'||
                    itbltytCanalSeis(sbIndex).CodigoArticulo||'|'||
                    itbltytCanalSeis(sbIndex).DescripcionArticulo||'|'||
                    itbltytCanalSeis(sbIndex).Observaciones||'|'||
                    itbltytCanalSeis(sbIndex).MarcaArticulo||'|'||
                    itbltytCanalSeis(sbIndex).ModeloArticulo||'|'||
                    itbltytCanalSeis(sbIndex).CantidadDetalle||'|'||
                    itbltytCanalSeis(sbIndex).CantidadBaseDetalle||'|'||
                    itbltytCanalSeis(sbIndex).PackDetalle||'|'||
                    itbltytCanalSeis(sbIndex).UnidadMedidadDetalle||'|'||
                    itbltytCanalSeis(sbIndex).ValorUnitarioDetalle||'|'||
                    itbltytCanalSeis(sbIndex).ValorTotalDetalle||'|'||
                    itbltytCanalSeis(sbIndex).DetalleRegalo||'|'||
                    itbltytCanalSeis(sbIndex).PrecioReferenciaDetalle||'|'||
                    itbltytCanalSeis(sbIndex).CodigoPrecioReferenciaDetalle||'|'||
                    itbltytCanalSeis(sbIndex).CodigoCentroCostosDetalle||'|'||
                    itbltytCanalSeis(sbIndex).NombreCentroCostosDetalle||'|'||
                    itbltytCanalSeis(sbIndex).Opcional51||'|'||
                    itbltytCanalSeis(sbIndex).Opcional52||'|'||
                    itbltytCanalSeis(sbIndex).Opcional53||'|'||
                    itbltytCanalSeis(sbIndex).Opcional54||'|'||
                    itbltytCanalSeis(sbIndex).Opcional55||'|'||
                    itbltytCanalSeis(sbIndex).Opcional56||'|'||
                    itbltytCanalSeis(sbIndex).Opcional57||'|'||
                    itbltytCanalSeis(sbIndex).Opcional58||'|'||
                    itbltytCanalSeis(sbIndex).Opcional59||'|'||
                    itbltytCanalSeis(sbIndex).Opcional60||'|'||
                    itbltytCanalSeis(sbIndex).Opcional61||'|'||
                    itbltytCanalSeis(sbIndex).Opcional62||'|'||
                    itbltytCanalSeis(sbIndex).Opcional63||'|'||
                    itbltytCanalSeis(sbIndex).Opcional64||'|'||
                    itbltytCanalSeis(sbIndex).Opcional65||CHR(10)||
                    fclGetEstrCanalSeisA(itbltytCanalSeis(sbIndex).infoCanal6a)||CHR(10)||
                    fclGetEstrCanalSeisB(itbltytCanalSeis(sbIndex).infoCanal6B)||CHR(10)||
                    fclGetEstrCanalSeisC(itbltytCanalSeis(sbIndex).infoCanal6C)||CHR(10)||
                    fclGetEstrCanalSeisD(itbltytCanalSeis(sbIndex).infoCanal6D);

      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
      RETURN cblInfoEstr;

    END fclGetEstructura;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    IF itbltytCanalSeis.COUNT > 0 THEN
        sbIndex := itbltytCanalSeis.FIRST;
        LOOP
          IF nuContador = 0 THEN
             oclDatos := fclGetEstructura;
          ELSE
            oclDatos := oclDatos||CHR(10)||fclGetEstructura;
         END IF;
         nuContador := nuContador  + 1;
         sbIndex := itbltytCanalSeis.NEXT(sbIndex);
         EXIT WHEN sbIndex IS NULL;
        END LOOP;
    END IF;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
 EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE pkg_error.CONTROLLED_ERROR;
  END prGeneraEstrCanalSeis;

  PROCEDURE prGeneraEstrCanalDiez( itbltytCanalDiez  IN   pkg_bcfactuelectronicagen.tbltytCanalDiez,
                                    oclDatos      OUT  CLOB ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraEstrCanalDiez
    Descripcion     : proceso para generar estructura del canal seis e

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itbltytCanalDiez     tabla con registro con datos del canal seis e
    Parametros de Salida
      oclDatos        clob con datos
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalDiez';
    sbIndex           VARCHAR2(50);
    nuContador       number := 0;
    FUNCTION fclGetEstructura RETURN CLOB IS
        csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.fclGetEstructura';
        cblInfoEstr   CLOB;
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      cblInfoEstr := itbltytCanalDiez(sbIndex).nroCanal||'|'||
                    itbltytCanalDiez(sbIndex).NumeroCompleto||'|'||
                    itbltytCanalDiez(sbIndex).IDOrdenamiento||'|'||
                    itbltytCanalDiez(sbIndex).Concepto||'|'||
                    itbltytCanalDiez(sbIndex).Descripcion||'|'||                    
                    nvl(itbltytCanalDiez(sbIndex).Capital, itbltytCanalDiez(sbIndex).SaldoAnterior)||'|'||
                    itbltytCanalDiez(sbIndex).Intereses||'|'||
                    itbltytCanalDiez(sbIndex).Total||'|'||
                    itbltytCanalDiez(sbIndex).SaldoDiferido||'|'||
                    itbltytCanalDiez(sbIndex).UnidadDelItem||'|'||
                    itbltytCanalDiez(sbIndex).CantidadDelItem||'|'||
                    itbltytCanalDiez(sbIndex).ValorUnitario||'|'||
                    itbltytCanalDiez(sbIndex).IVA||'|'||
                    itbltytCanalDiez(sbIndex).CuotasFaltantes;

      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
      RETURN cblInfoEstr;

    END fclGetEstructura;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    IF itbltytCanalDiez.COUNT > 0 THEN
        sbIndex := itbltytCanalDiez.FIRST;
        LOOP
          IF nuContador = 0 THEN
             oclDatos := fclGetEstructura;
          ELSE
            oclDatos := oclDatos||CHR(10)||fclGetEstructura;
         END IF;
         nuContador := nuContador  + 1;
         sbIndex := itbltytCanalDiez.NEXT(sbIndex);
         EXIT WHEN sbIndex IS NULL;
        END LOOP;
    END IF;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
  END prGeneraEstrCanalDiez;

  PROCEDURE prGeneraEstrCanalSiete( itytCanalSiete  IN   pkg_bcfactuelectronicagen.tytCanalSiete,
                                   oclDatos      OUT  CLOB  ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraEstrCanalSiete
    Descripcion     : proceso para generar estructura del canal siete

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      itytCanalSiete      registro con datos del canal siete
    Parametros de Salida
      oclDatos        clob con datos
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
	jerazomvm	01-07-2025	OSF-4604	Se renombra Opcional81 por InfoFormaPago
    LJLB        23-01-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraEstrCanalCuatro';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

     oclDatos := itytCanalSiete.NroCanal||'|'||
            itytCanalSiete.NumeroCompleto||'|'||
            itytCanalSiete.InfoFormaPago||'|'||
            itytCanalSiete.Opcional82||'|'||
            itytCanalSiete.Opcional83||'|'||
            itytCanalSiete.Opcional84||'|'||
            itytCanalSiete.Opcional85||'|'||
            itytCanalSiete.Opcional86||'|'||
            itytCanalSiete.Opcional87||'|'||
            itytCanalSiete.Opcional88||'|'||
            itytCanalSiete.Opcional89||'|'||
            itytCanalSiete.Opcional90||'|'||
            itytCanalSiete.Opcional91||'|'||
            itytCanalSiete.Opcional92||'|'||
            itytCanalSiete.Opcional93||'|'||
            itytCanalSiete.Opcional94||'|'||
            itytCanalSiete.Opcional95||'|'||
            itytCanalSiete.Opcional96||'|'||
            itytCanalSiete.Opcional97||'|'||
            itytCanalSiete.Opcional98||'|'||
            itytCanalSiete.Opcional99||'|'||
            itytCanalSiete.Opcional100;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
  END prGeneraEstrCanalSiete;

  PROCEDURE prGeneraPlanofactElect ( inuFactura       IN  NUMBER,
                                     inuTipoDocu      IN  NUMBER,
                                     isbOperacion     IN  VARCHAR2,
                                     onuContrato      OUT NUMBER,
                                     osbRutaReparto   OUT VARCHAR2,
                                     oclDatosRequest  OUT CLOB,
                                     oclDatosConti    OUT CLOB,
                                     osbEmitirFactura OUT VARCHAR2,
                                     ioCblSpool       IN OUT CLOB,
                                     onuError         OUT NUMBER,
                                     osbError         OUT VARCHAR2) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraPlanofactElect
    Descripcion     : proceso para generar plano de estructura de facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-01-2024

    Parametros de Entrada
      inuFactura       codigo de la factura
      inuTipoDocu      tipo de documento a generar
      isbOperacion    Operacion a realizar I - Insertar A -Actualizar
    Parametros de Salida
      onuContrato       nuemero de contrato
      osbRutaReparto    ruta de reparto
      oclDatosRequest   datos de archivo plano
      oclDatosConti     datos de archivo plano contigencia
      osbEmitirFactura  emitir factura a la Dian
      ioCblSpool         spool     
      onuError           codigo de error
      osbError           mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        17-01-2024  OSF-2158    Creacion
  ***************************************************************************/
     csbMT_NAME         VARCHAR2(100) := csbSP_NAME || '.prGenerarEstrFactElec';

     OtytCanalUno       pkg_bcfactuelectronicagen.tytCanalUno;
     OtytCanalUnoCont   pkg_bcfactuelectronicagen.tytCanalUno;
     OtytCanalUnoA      pkg_bcfactuelectronicagen.tytCanalUnoa;
     OtytCanalUnoB      pkg_bcfactuelectronicagen.tytCanalUnob;
     otbltytCanalOcho   pkg_bcfactuelectronicagen.tbltytCanalOcho;
     otbltytCanalNueve  pkg_bcfactuelectronicagen.tbltytCanalNueve;
     otytCanalDos       pkg_bcfactuelectronicagen.tytCanalDos;
     otytCanalDosCont   pkg_bcfactuelectronicagen.tytCanalDos;
     otytCanalTres      pkg_bcfactuelectronicagen.tytCanalTres;
     otytCanalTresA     pkg_bcfactuelectronicagen.tytCanalTresA;
     otytCanalCuatro    pkg_bcfactuelectronicagen.tytCanalCuatro;
     otytCanalCinco     pkg_bcfactuelectronicagen.tytCanalCinco;
     otbltytCanalCincoA pkg_bcfactuelectronicagen.tbltytCanalCincoA;
     otbltytCanalSeis   pkg_bcfactuelectronicagen.tbltytCanalSeis;
     otbltytCanalDiez   pkg_bcfactuelectronicagen.tbltytCanalDiez;
     otytCanalSiete     pkg_bcfactuelectronicagen.tytCanalSiete;

     oclDatosCanalUno   CLOB;
     oclDatosCanalUnoA  CLOB;
     oclDatosCanalUnoB  CLOB;
     oclDatosCanalOcho  CLOB;
     oclDatosCanalNueve  CLOB;
     oclDatosCanalDos   CLOB;
     oclDatosCanalDosCont   CLOB;
     oclDatosCanalTres  CLOB;
     oclDatosCanalTresa CLOB;
     oclDatosCanalCuatro CLOB;
     oclDatosCanalCinco  CLOB;
     oclDatosCanalCincoa CLOB;
     oclDatosCanalSeis  CLOB;
     oclDatosCanalDiez CLOB;
     oclDatosCanalSiete CLOB;
     oclDatosCanalUnocon CLOB;
     oclDatosCanalUnoAc  CLOB;
     oclDatosCanalUnoBc  CLOB;
     oclDatosCanalOchoc  CLOB;
     oclDatosCanalNuevec  CLOB;
     oclDatosCanalTresc  CLOB;
     oclDatosCanalTresac CLOB;
     oclDatosCanalCuatroc CLOB;
     oclDatosCanalCincoc  CLOB;
     oclDatosCanalCincoac CLOB;
     oclDatosCanalSeisc  CLOB;
     oclDatosCanalDiezc CLOB;
     oclDatosCanalSietec CLOB;
     sbFacturaElect VARCHAR2(4000);  
     nuFactura  NUMBER;

     CURSOR cugetFacturaNota IS
     SELECT notafact
     FROM notas
     WHERE notanume = inuFactura;

     PROCEDURE prInicializaDatos IS
       csbMT_NAME1        VARCHAR2(100) := csbMT_NAME || '.prReportarError';
     BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      pkg_error.prInicializaError(onuError, osbError);
      OtytCanalUno   := null;
      OtytCanalUnoA  := null;
      OtytCanalUnoB  := null;
      otytCanalDos   := null;
      otytCanalTresA := null;
      otytCanalCuatro := null;
      otytCanalSiete := null;
      nuFactura := NULL;
      otytCanalDosCont := null;

      oclDatosCanalUno := EMPTY_CLOB();
      oclDatosCanalUnoA := EMPTY_CLOB();
      oclDatosCanalUnoB := EMPTY_CLOB();
      oclDatosCanalOcho := EMPTY_CLOB();
      oclDatosCanalNueve := EMPTY_CLOB();
      oclDatosCanalDos  := EMPTY_CLOB();
      oclDatosCanalDosCont  := EMPTY_CLOB();
      oclDatosCanalTres := EMPTY_CLOB();
      oclDatosCanalTresa := EMPTY_CLOB();
      oclDatosCanalCuatro := EMPTY_CLOB();
      oclDatosCanalCinco := EMPTY_CLOB();
      oclDatosCanalCincoA := EMPTY_CLOB();
      oclDatosCanalSeis   := EMPTY_CLOB();
      oclDatosCanalDiez  := EMPTY_CLOB();
      oclDatosCanalSiete  := EMPTY_CLOB();

      oclDatosCanalUnoAc := EMPTY_CLOB();
      oclDatosCanalUnoBc := EMPTY_CLOB();
      oclDatosCanalOchoc := EMPTY_CLOB();
      oclDatosCanalNuevec := EMPTY_CLOB();
      oclDatosCanalTresc := EMPTY_CLOB();
      oclDatosCanalTresac := EMPTY_CLOB();
      oclDatosCanalCuatroc := EMPTY_CLOB();
      oclDatosCanalCincoc := EMPTY_CLOB();
      oclDatosCanalCincoAc := EMPTY_CLOB();
      oclDatosCanalSeisc   := EMPTY_CLOB();
      oclDatosCanalDiezc  := EMPTY_CLOB();
      oclDatosCanalSietec  := EMPTY_CLOB();
      oclDatosCanalUnocon := EMPTY_CLOB();
      oclDatosRequest     := EMPTY_CLOB();
      oclDatosConti        := EMPTY_CLOB();
      sbFacturaElect      := null;

      OtytCanalUnoCont   := null;
      otbltytCanalOcho.delete;
      otbltytCanalNueve.delete;
      otytCanalCinco := NULL;
      otbltytCanalCincoA.delete;
      otbltytCanalSeis.delete;
      otbltytCanalDiez.delete;
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
     END prInicializaDatos;
  BEGIN

    prInicializaDatos;
    nuFactura := inuFactura;

   pkg_bcfactuelectronicagen.prGetInfoCanalSeis( inuFactura,
                                                 inuTipoDocu,
                                                 isbOperacion,
                                                 otbltytCanalSeis,
                                                 osbEmitirFactura);

    IF inuTipoDocu = pkg_bcfactuelectronicagen.cnuTipoDocuNotas THEN
        IF cugetFacturaNota%ISOPEN THEN CLOSE cugetFacturaNota; END IF;
        OPEN cugetFacturaNota;
        FETCH cugetFacturaNota INTO nuFactura;
        CLOSE cugetFacturaNota;
    END IF;
    --se cargan informacion de los canales
    pkg_bcfactuelectronicagen.prGetInfoCanalUno( inuFactura,
                                                 inuTipoDocu,
                                                 ioCblSpool,
                                                 OtytCanalUno,
                                                 OtytCanalUnoCont,
                                                 onuContrato,
                                                 osbRutaReparto );


    pkg_bcfactuelectronicagen.prGetInfoCanalUnoA( nuFactura,
                                                 OtytCanalUnoA);


    pkg_bcfactuelectronicagen.prGetInfoCanalUnoB( nuFactura ,
                                                  OtytCanalUnoB);

    pkg_bcfactuelectronicagen.prGetInfoCanalOcho( otbltytCanalOcho );


    pkg_bcfactuelectronicagen.prGetInfoCanalNueve( otbltytCanalNueve );


    pkg_bcfactuelectronicagen.prGetInfoCanalDos( otytCanalDos, otytCanalDosCont);

    pkg_bcfactuelectronicagen.prGetInfoCanalTres( otytCanalTres);

    pkg_bcfactuelectronicagen.prGetInfoCanalTresA( otytCanalTresA);

    pkg_bcfactuelectronicagen.prGetInfoCanalCuatro( nuFactura,
                                                    otytCanalCuatro);


    pkg_bcfactuelectronicagen.prGetInfoCanalCinco( otytCanalCinco );


    pkg_bcfactuelectronicagen.prGetInfoCanalCincoA( otbltytCanalCincoA);


    pkg_bcfactuelectronicagen.prGetInfoCanalDiez( nuFactura,
                                                   otbltytCanalDiez);

    pkg_bcfactuelectronicagen.prGetInfoCanalSiete( otytCanalSiete );

    --se comienza a generar estructura de archivo
    prGeneraEstrCanalUno(OtytCanalUno,
                         oclDatosCanalUno);

      --se comienza a generar estructura de archivo
    prGeneraEstrCanalUno(OtytCanalUnoCont, oclDatosCanalUnocon);

    prGeneraEstrCanalUnoA(OtytCanalUnoa, oclDatosCanalUnoA    );

    prGeneraEstrCanalUnoB(OtytCanalUnoB, oclDatosCanalUnoB  );

    prGeneraEstrCanalOcho(otbltytCanalOcho,  oclDatosCanalOcho);

    prGeneraEstrCanalNueve(otbltytCanalNueve,   oclDatosCanalNueve );

    prGeneraEstrCanalDos(OtytCanalDos, oclDatosCanalDos);

    prGeneraEstrCanalDos(otytCanalDosCont, oclDatosCanalDosCont);                     

    prGeneraEstrCanalTres(OtytCanalTres,
                         oclDatosCanalTres );

    prGeneraEstrCanalTresa(OtytCanalTresa,
                         oclDatosCanalTresa);

    prGeneraEstrCanalCuatro(OtytCanalCuatro,
                            oclDatosCanalCuatro );

    prGeneraEstrCanalCinco( OtytCanalCinco,
                            oclDatosCanalCinco );

    prGeneraEstrCanalCincoA( OtbltytCanalCincoA,
                            oclDatosCanalCincoA);

    prGeneraEstrCanalSeis( OtbltytCanalSeis,
                            oclDatosCanalSeis  );

    prGeneraEstrCanalDiez( otbltytCanalDiez,
                           oclDatosCanalDiez  );

    prGeneraEstrCanalSiete( OtytCanalSiete,
                            oclDatosCanalSiete);

    oclDatosRequest := oclDatosCanalUno||chr(10)||oclDatosCanalUnoA||chr(10)||oclDatosCanalUnob||chr(10)||
                      oclDatosCanalDos||chr(10)||oclDatosCanalTres||chr(10)||oclDatosCanalTresa||chr(10)||
                      oclDatosCanalCuatro||chr(10)||oclDatosCanalCinco||chr(10)||oclDatosCanalCincoa||chr(10)||oclDatosCanalSeis||chr(10)||
                      oclDatosCanalSiete||chr(10)||oclDatosCanalOcho||chr(10)||oclDatosCanalNueve||chr(10)||oclDatosCanalDiez;

    sbFacturaElect :=   pkg_bcfactuelectronicagen.fsbgetfacturaelec;

    oclDatosCanalUnoAC :=  REPLACE(oclDatosCanalUnoA, sbFacturaElect, '<FACTURA_CONTINGENCIA>');
    oclDatosCanalUnobC :=  REPLACE(oclDatosCanalUnob, sbFacturaElect, '<FACTURA_CONTINGENCIA>');
    oclDatosCanalTresC  :=  REPLACE(oclDatosCanalTres,sbFacturaElect, '<FACTURA_CONTINGENCIA>');
    oclDatosCanalTresaC :=  REPLACE(oclDatosCanalTresa, sbFacturaElect, '<FACTURA_CONTINGENCIA>');
    oclDatosCanalCuatroC :=  REPLACE(oclDatosCanalCuatro, sbFacturaElect, '<FACTURA_CONTINGENCIA>');
    oclDatosCanalCincoC  :=  REPLACE(oclDatosCanalCinco,sbFacturaElect, '<FACTURA_CONTINGENCIA>');
    oclDatosCanalCincoaC  :=  REPLACE(oclDatosCanalCincoa,sbFacturaElect, '<FACTURA_CONTINGENCIA>');
    oclDatosCanalSeisC :=  REPLACE(oclDatosCanalSeis, sbFacturaElect, '<FACTURA_CONTINGENCIA>');
    oclDatosCanalSieteC :=  REPLACE(oclDatosCanalSiete, sbFacturaElect, '<FACTURA_CONTINGENCIA>');
    oclDatosCanalOchoC  :=  REPLACE(oclDatosCanalOcho,sbFacturaElect, '<FACTURA_CONTINGENCIA>');
    oclDatosCanalNueveC  :=  REPLACE(oclDatosCanalNueve,sbFacturaElect, '<FACTURA_CONTINGENCIA>'); 
    oclDatosCanalDiezC  :=  REPLACE(oclDatosCanalDiez,sbFacturaElect, '<FACTURA_CONTINGENCIA>');

    oclDatosConti  := oclDatosCanalUnocon||chr(10)||
                      oclDatosCanalUnoAC||chr(10)||oclDatosCanalUnobC||chr(10)||
                      oclDatosCanalDosCont||chr(10)||oclDatosCanalTresC||chr(10)||oclDatosCanalTresaC||chr(10)||
                      oclDatosCanalCuatroC||chr(10)||oclDatosCanalCincoC||chr(10)||oclDatosCanalCincoaC||chr(10)||oclDatosCanalSeisC||chr(10)||
                      oclDatosCanalSieteC||chr(10)||oclDatosCanalOchoC||chr(10)||oclDatosCanalNueveC||chr(10)||oclDatosCanalDiezC;
   EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(onuError,osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(onuError,osbError);
       pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prGeneraPlanofactElect;

  PROCEDURE prGenerarEstrFactElec( inuFactura    IN  NUMBER,
                                   inuCodigoLote IN  NUMBER,
                                   isbOperacion  IN  VARCHAR2,
                                   inuTipoDocu   IN  NUMBER,
                                   inuIdReporte  IN  NUMBER,
								   isbCodEmpresa IN  VARCHAR2,
                                   isbNotaNrefe  IN  VARCHAR2 DEFAULT 'N',
                                   onuError     OUT  NUMBER,
                                   osbError     OUT  VARCHAR2) IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGenerarEstrFactElec
    Descripcion     : proceso para generar estructura de facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-01-2024

    Parametros de Entrada
      inuFactura       codigo de la factura
      inuCodigoLote    codigo de lote
      isbOperacion    Operacion a realizar I - Insertar A -Actualizar
      inuIdReporte      id del reporte
	  isbCodEmpresa		Código de Empresa
      isbNotaNrefe      indica si la nota es referencia o no
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
	JSOTO		17-03-2025	OSF-4104    Se agrega parametro de entrada isbCodEmpresa
    LJLB        07-03-2025  OSF-4045    se agrega nuevo parametro isbNotaNrefe para validar si la nota es referenciada o no
    LJLB        17-01-2024  OSF-2158    Creacion
  ***************************************************************************/
     csbMT_NAME         VARCHAR2(100) := csbSP_NAME || '.prGenerarEstrFactElec';



     nuIdReporte        NUMBER;
     iregFacturaEle     pkg_factura_elect_general.styFacturaElectronicaGen;
     iregFacturaEleNull pkg_factura_elect_general.styFacturaElectronicaGen;
     nuContrato         NUMBER;
     sbRutaReparto      VARCHAR2(400);
     sbEmitirFactura    VARCHAR2(2);
     clDatosRequest     clob;
     cblSpool            clob; 
     oblFacturaVenta    BOOLEAN;
     clDatosConti     clob; 

     PROCEDURE prReportarError IS
       csbMT_NAME1        VARCHAR2(100) := csbMT_NAME || '.prReportarError';
     BEGIN
       pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
       IF onuError <> 0 THEN
          nuConsecutivo := nuConsecutivo + 1;
          pkg_traza.trace('inuIdReporte => ' || inuIdReporte, pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace('nuConsecutivo => ' || nuConsecutivo, pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace('inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace('osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
          pkg_reportes_inco.prCrearDetalleRepo( inuIdReporte,
                                                 inuFactura,
                                                 osbError,
                                                 'S',
                                                  nuConsecutivo );
        IF onuError <> -2 THEN
            pkg_error.seterrormessage(isbMsgErrr => osbError);
        END IF;
      END IF;
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
     END prReportarError;

     PROCEDURE prInicializaDatos IS
       csbMT_NAME1        VARCHAR2(100) := csbMT_NAME || '.prReportarError';
     BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      nuContrato := NULL;
      sbRutaReparto := NULL;
      iregFacturaEle := iregFacturaElenull;
      clDatosRequest     := EMPTY_CLOB();
      clDatosConti    := EMPTY_CLOB();
      cblSpool  := EMPTY_CLOB();
      oblFacturaVenta    :=  false;
      sbEmitirFactura    := NULL;
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
     END prInicializaDatos;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
    pkg_error.prinicializaerror(onuError, osbError);
    prInicializaDatos;
    pkg_traza.trace(' inuIdReporte => ' || inuIdReporte, pkg_traza.cnuNivelTrzDef);
    --si es factura recurrente
    IF inuTipoDocu = pkg_bcfactuelectronicagen.cnuTipoDocuFactRecu THEN
        --se carga informacion en memoria de la informacion de la factura
        pkg_bcfactuelectronicagen.prMapearDatosFactura( inuFactura,
														isbCodEmpresa,
                                                        cblSpool,
                                                        onuError,
                                                        osbError );
        --validar error
        prReportarError;

        pkg_bcfactuelectronicagen.prGetInfoValoraReportar ( inuFactura,
                                                             onuError,
                                                             osbError);
        --validar error
        prReportarError;
    ELSIF  inuTipoDocu = pkg_bcfactuelectronicagen.cnuTipoDocuVentas THEN
        pkg_bcfactuelectronicagen.prInicializarVariables(isbCodEmpresa);

        pkg_bcfactuelectronicagen.prGetInfoValoraReportarVentas ( inuFactura,
                                                                  oblFacturaVenta,
                                                                  onuError,
                                                                  osbError);
        --validar error
        prReportarError;

        IF NOT oblFacturaVenta THEN
           RETURN;
        END IF;
    ELSIF inuTipoDocu = pkg_bcfactuelectronicagen.cnuTipoDocuNotas THEN
          pkg_bcfactuelectronicagen.prInicializarVariables(isbCodEmpresa);
          pkg_bcfactuelectronicagen.prGetInfoValoraReportarNotas( inuFactura,
                                                                  isbNotaNrefe,
                                                                  onuError,
                                                                  osbError);
        --validar error;
         prReportarError;

    END IF; 

    prGeneraPlanofactElect ( inuFactura,
                             inuTipoDocu ,
                             isbOperacion ,
                             nuContrato ,
                             sbRutaReparto ,
                             clDatosRequest,
                             clDatosConti,
                             sbEmitirFactura,
                             cblSpool,
                             onuError,
                             osbError);

    --valida error
     prReportarError;

    iregFacturaEle.codigo_lote    := inuCodigoLote;
    iregFacturaEle.tipo_documento := inuTipoDocu;
    iregFacturaEle.consfael       := nvl(pkg_bcfactuelectronicagen.fnuGetConsecutivo, inuFactura);
    iregFacturaEle.factura_electronica  := pkg_bcfactuelectronicagen.fsbgetfacturaelec;
    iregFacturaEle.contrato       := nuContrato;
    iregFacturaEle.documento      := inuFactura;
    iregFacturaEle.estado         := 1;
    iregFacturaEle.fecha_registro := SYSDATE;
    iregFacturaEle.texto_enviado  := clDatosRequest;
    iregFacturaEle.texto_contigencia  := clDatosConti;
    iregFacturaEle.texto_spool  := cblSpool;
    iregFacturaEle.ruta_reparto   := sbRutaReparto;
    iregFacturaEle.emitir_factura := sbEmitirFactura;
    IF inuTipoDocu =  pkg_bcfactuelectronicagen.cnuTipoDocuFactRecu THEN
        iregFacturaEle.orden_funcion := fnuOrdenSuscImpresion(nuContrato);
    END IF;

     IF isbOperacion = 'I' THEN
        pkg_factura_elect_general.prinsertarfactelecgen(iregFacturaEle,
                                                        onuError,
                                                        osbError);
    ELSE
        pkg_factura_elect_general.prActualizarFactElecGen( iregFacturaEle.codigo_lote,
                                                           iregFacturaEle.tipo_documento,
                                                           iregFacturaEle.consfael,
                                                           iregFacturaEle.estado,
                                                           iregFacturaEle.ruta_reparto,
                                                           iregFacturaEle.texto_enviado,
                                                           iregFacturaEle.texto_contigencia,
                                                           iregFacturaEle.texto_spool,
                                                           iregFacturaEle.factura_electronica,
                                                           iregFacturaEle.emitir_factura,
                                                           iregFacturaEle.orden_funcion,
                                                           onuError,
                                                           osbError);

    END IF;
    --validar error
    prReportarError;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(onuError,osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(onuError,osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prGenerarEstrFactElec;
END PKG_BOFACTUELECTRONICAGEN; 
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BOFACTUELECTRONICAGEN','PERSONALIZACIONES');
END;
/