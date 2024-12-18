create or replace PACKAGE personalizaciones.PKG_BCFACTUELECTRONICAGEN IS
  csbTipoDocumento   CONSTANT VARCHAR2(2)  := '01';
  csbTipoDocumentoCont   CONSTANT VARCHAR2(2)  := '03';
  csbTipoDocuNotaCre   CONSTANT VARCHAR2(2)  := '91';
  csbTipoDocuNotaDeb   CONSTANT VARCHAR2(2)  := '92';
  csbTipoOperacion   CONSTANT VARCHAR2(2)  := '10';

  csbTipoOperNotaCreSf   CONSTANT VARCHAR2(2)  := '22';
  csbTipoOperNotaCreCf   CONSTANT VARCHAR2(2)  := '20';
  csbTipoOperNotaDebSf   CONSTANT VARCHAR2(2)  := '32';
  csbTipoOperNotaDebCf   CONSTANT VARCHAR2(2)  := '30';

  csbTipoOperacionAiu   CONSTANT VARCHAR2(2)  := '09';
  csbTipoMoneda      CONSTANT VARCHAR2(3)  := 'COP';
  csbFormaPago       CONSTANT VARCHAR2(2)  := '2';
  csbTotalAnticipo   CONSTANT VARCHAR2(2)  := '0';
  csbRedondeo        CONSTANT VARCHAR2(2)  := '0';

  csbRazonFabrSoft   CONSTANT VARCHAR2(50) := 'OPEN SYSTEMS COLOMBIA S.A.S';
  csbNitFabrSoft     CONSTANT VARCHAR2(40) := '9004017146';
  csbNombreFabrSoft  CONSTANT VARCHAR2(15) := 'OPEN';
  csbNombreSoft      CONSTANT VARCHAR2(30) := 'OPEN SMARTFLEX';
  csbNatuEmisor      CONSTANT VARCHAR2(4)  := '1';
  csbTipoIdeEmisor   CONSTANT VARCHAR2(8)  := '31';
  csbDescIdeEmisor   CONSTANT VARCHAR2(10) := 'NIT';

  csbTipoRegimenReceptor    CONSTANT VARCHAR2(30) := 'No Aplica';
  csbRespFiscalesReceptor   CONSTANT VARCHAR2(30) := 'R-99-PN';
  csbCodigoTribRespReceptor CONSTANT VARCHAR2(30) := 'ZZ';
  csbNombreTribRespReceptor CONSTANT VARCHAR2(100) := 'No aplica';
  csbNombreTribRespReceptorEmp CONSTANT VARCHAR2(100) := 'Otros tributos';



  csbPais              CONSTANT VARCHAR2(10) := 'CO';
  csbNombrePais        CONSTANT VARCHAR2(100) := 'COLOMBIA';
  csbNaturalezaEmisor  CONSTANT VARCHAR2(4)  := '1';
  csbTipoIdenEmisor    CONSTANT VARCHAR2(8)  := '31';
  csbDescTipoIdeEmisor CONSTANT VARCHAR2(8)  := 'NIT';

  csbCodigoImpuesto    CONSTANT VARCHAR2(8)  := '01';
  csbDescImpuesto      CONSTANT VARCHAR2(8)  := 'IVA';

  csbEstandarArt       CONSTANT VARCHAR2(8)  := '999';

  csbUnidadMedCons     CONSTANT VARCHAR2(8)  := 'MTQ';
  csbUnidadOtros       CONSTANT VARCHAR2(8)  := '94';


  cnuTipoDocuFactRecu CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('TIPO_DOCU_FACTURA');
  cnuTipoDocuVentas   CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('TIPO_DOCU_VENTAS');
  cnuTipoDocuNotas    CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('TIPO_DOCU_NOTAS');

  csbCausalesIngr     CONSTANT VARCHAR2(4000) := pkg_parametros.fsbgetvalorcadena('CAUSALES_INGRESO_NOTAS_FAEL');
  cnuProcesoFaju      CONSTANT NUMBER :=  pkg_parametros.fnugetvalornumerico('PROGRAMA_AJUSTE_CONSUMO_FAEL');
  sbCausalesIngVenta VARCHAR2(4000) := pkg_parametros.fsbgetvalorcadena('CAUSALES_INGRESO_VENTA_FAEL');
  sbDocumeSoporte    VARCHAR2(4000) := pkg_parametros.fsbgetvalorcadena('DOCUMENTO_SOPORTE_VENTA_FAEL');
  csbTipoProdExcluir   CONSTANT VARCHAR2(2000) := pkg_parametros.fsbgetvalorcadena('TIPO_PRODUCTO_EXCLUIR_FAEL');
  csbQrPago   CONSTANT VARCHAR2(2000) := pkg_parametros.fsbgetvalorcadena('CODIGO_QR_FAEL');
  sbConcExcluir        VARCHAR2(4000) := pkg_parametros.fsbgetvalorcadena('CONC_EXCLUIR_INGRESO_FAEL');

  sbCondicionesEspeVenta    VARCHAR2(4000) := pkg_parametros.fsbgetvalorcadena('CONDICIONES_ESPECIAL_VENTAS');
  gsbAmbiente         VARCHAR2(2);

  -- Tipo de dato de tabla PL donde el indice es el concepto y el valor es la unidad de medida
  TYPE tytRcUnidadMedConc IS RECORD ( nuConcepto        conc_unid_medida_dian.concepto_id%type,
									  sbUnidadMed       conc_unid_medida_dian.unidad_medida%type,
									  sbRequiereTarifa  conc_unid_medida_dian.requiere_tarifa%type);

  TYPE tytbUnidadMedConc IS TABLE OF tytRcUnidadMedConc INDEX BY BINARY_INTEGER;

  tbUnidadMedConc           tytbUnidadMedConc;

  --registro de canal uno
   TYPE tytCanalUno IS RECORD (	NroCanal						VARCHAR2(5),
								NumeroCompleto                  VARCHAR2(30),
								TipoDocumento                   VARCHAR2(5),
								TipoOperacion                   VARCHAR2(5),
								Ambiente                        VARCHAR2(2),
								Prefijo                         VARCHAR2(30),
								NumeroDocumento                 VARCHAR2(30),
								FechaDocumento                  VARCHAR2(30),
								HoraDocumento                   VARCHAR2(20),
								FacturaAsociada                 VARCHAR2(30),
								FechaFacturaAsociada            VARCHAR2(30),
								CodigoConceptoNota              VARCHAR2(15),
								DescripcionConceptoNota         VARCHAR2(200),
								SeccionCorreccion               VARCHAR2(15),
								TipoMoneda                      VARCHAR2(10),
								NumeroLineas                    VARCHAR2(15),
								FormaPago                       VARCHAR2(5),
								CodigoMedioPago                 VARCHAR2(5),
								DescripcionMedioPago            VARCHAR2(200),
								FechaVencimiento                VARCHAR2(30),
								FechaInicalPeriodoFacturacion   VARCHAR2(30),
								HoraInicalPeriodoFacturacion    VARCHAR2(30),
								FechaFinalPeriodoFacturacion    VARCHAR2(30),
								HoraFinalPeriodoFacturacion     VARCHAR2(30),
								TotalValorBruto                 VARCHAR2(30),
								TotalValorBaseImponible         VARCHAR2(30),
								TotalValorBrutoMasTributos      VARCHAR2(30) ,
								TotalDescuentos                 VARCHAR2(30),
								TotalCargos                     VARCHAR2(30),
								TotalAnticipos                  VARCHAR2(30) ,
								Redondeo                        VARCHAR2(4),
								TotalAPagar                     VARCHAR2(30),
								ValorLetras                     VARCHAR2(200),
								ReferenciaPago                  VARCHAR2(100),
								SaldoFavor                      VARCHAR2(30),
								CantidadFacturasVencidas        VARCHAR2(10),
								FacturasVencidas                VARCHAR2(30),
								NumeroContrato                  VARCHAR2(30),
								OrdenCompraFactura              VARCHAR2(30),
								FechaOrdenCompra                VARCHAR2(30) ,
								OrdenDespacho                   VARCHAR2(30) ,
								FechaOrdenDespacho              VARCHAR2(30) ,
								DocumentoRecepcion              VARCHAR2(30) ,
								FechaDocumentoRecepcion         VARCHAR2(30) ,
								Observaciones                   VARCHAR2(2000)  ,
								CodigoCentroCostos              VARCHAR2(50) ,
								NombreCentroCostos              VARCHAR2(200) ,
								MesFacturado                    VARCHAR2(30) ,
								PeriodoFacturado                VARCHAR2(50) ,
								DiasDeConsumo                   VARCHAR2(30) ,
								NumeroDeControl                 VARCHAR2(30),
								PeriodoDeConsumo                VARCHAR2(30),
								ValorEnReclamo                  VARCHAR2(30) ,
								CupoBrilla                      VARCHAR2(40),
								LecturaAnterior                 VARCHAR2(30),
								LecturaActual                   VARCHAR2(30),
								CausalNoLectura                 VARCHAR2(30),
								ConsumoActual                   VARCHAR2(30),
								FactordeCorreccion              VARCHAR2(30),
								FechaSuspMora                   VARCHAR2(30),
                                NumeroFacturaInter              VARCHAR2(30),
								ValorTotalXPagar                VARCHAR2(30),
								ValorTotalFacturaMes            VARCHAR2(30),
								ObservacionNotas                VARCHAR2(200),
								Calificacion                    VARCHAR2(30),
								NoUsar06                        VARCHAR2(10),
								NoUsar07                        VARCHAR2(10),
								NoUsar08                        VARCHAR2(10),
								NoUsar09                        VARCHAR2(10),
								NoUsar10                        VARCHAR2(10),
								NoUsar11                        VARCHAR2(10) ,
								PromedioDeConsumo               VARCHAR2(30),
								Temperatura                     VARCHAR2(30),
								Presion                         VARCHAR2(30) ,
								ConsumoEnKWh                    VARCHAR2(100),
								CalculoDeConsumo                VARCHAR2(30),
								TipoDeNotificacion              VARCHAR2(30),
								MensajeGeneral                  VARCHAR2(2000),
								PlazoMaxRP                      VARCHAR2(30),
								SuspensionporRP                 VARCHAR2(30) ,
								ComponentesdelCosto             VARCHAR2(100),
								ReferenciaKPIsCalidad           VARCHAR2(100),
								CalculoKPIsCalidad              VARCHAR2(100),
								CodigoBarrasId                  VARCHAR2(50),
								CodigoBarrasRef_Pago            VARCHAR2(30),
								CodigoBarrasValor               VARCHAR2(30),
								CodigoBarrasFechalimite         VARCHAR2(30),
								CodigoBarrasCompleto            VARCHAR2(100),
								TRMUltima                       VARCHAR2(30),
								TRMPromedio                     VARCHAR2(30),
								Visible                         VARCHAR2(10),
								Impreso                         VARCHAR2(10),
								ProteccionDeDatos               VARCHAR2(10),
								DireccionProducto               VARCHAR2(100),
								CausaPromedio                   VARCHAR2(30),
								PagareUnico                     VARCHAR2(50),
								CambioUso                       VARCHAR2(10),
								AcumuladoTarifaTransitoria      VARCHAR2(30),
								FinanciacionEspecial            VARCHAR2(10),
								MedidorMalUbicado               VARCHAR2(30),
								ImprimirFactura                 VARCHAR2(10) ,
								ValorUltimoPago                 VARCHAR2(30) ,
								FechaUltimoPago                 VARCHAR2(30) ,
								CantidadLineas                  VARCHAR2(30) ,
								CondicionPago                   VARCHAR2(30) ,
								NIU                             VARCHAR2(30) ,
								TipoProducto                    VARCHAR2(10) ,
								ObservacionNoLectura            VARCHAR2(30) ,
								ContratistaReparto              VARCHAR2(200) ,
								InteresMora                     VARCHAR2(30) ,
								PoderCalorifico                 VARCHAR2(30) ,
								ConsumoKWh                      VARCHAR2(30) ,
								ImprimirTijera                  VARCHAR2(30) ,
								BancoUltimoPago                 VARCHAR2(200) ,
								Tarifa_GM                       VARCHAR2(100) ,
								Tarifa_TM                       VARCHAR2(100) ,
								Tarifa_DM                       VARCHAR2(100) ,
								Tarifa_CV                       VARCHAR2(100) ,
								Tarifa_CC                       VARCHAR2(100) ,
								Tarifa_CVARIABLE                VARCHAR2(100) ,
								Tarifa_AS                       VARCHAR2(100) ,
								Tarifa_PORCSU                   VARCHAR2(100) ,
								Tarifa_SUBSIDIADA               VARCHAR2(100),
								Tarifa_DS                       VARCHAR2(100) ,
								Tarifa_CFIJO                    VARCHAR2(100) ,
								MesesRevisionTecReg             VARCHAR2(2000) ,
								NumeroHojas                     VARCHAR2(20) ,
								FechaFinaExcencion              VARCHAR2(30) ,
								PresionAtmosferica              VARCHAR2(20) ,
								MensajePromocion                VARCHAR2(100) ,
								TipoNotificacion                VARCHAR2(10) ,
								MensajeRevisionSegura           VARCHAR2(2000) ,
								CampanaID                       VARCHAR2(30) ,
								FactImagen                      CLOB,
                                TotalGas                        VARCHAR2(30),
                                TotalBrilla                     VARCHAR2(30),
                                TotalOtrosServicios             VARCHAR2(30),
                                TotalCapital                    VARCHAR2(30),
                                TotalIntereses                  VARCHAR2(30),
                                TotalSaldoDiferidos             VARCHAR2(30),
                                NombreArte                      VARCHAR2(100),
                                TipoFacturaElectrónica          VARCHAR2(20),
                                QRPago                          VARCHAR2(300)
                                );

  TYPE tytCanalUnoA IS RECORD (  NroCanal				 VARCHAR2(5),
                                 NumeroCompleto			 VARCHAR2(30),
                                 IdentificacionAnticipo  VARCHAR2(30),
                                 ValorAnticipo			 VARCHAR2(30),
                                 FechaReciboAnticipo     VARCHAR2(30),
                                 FechaPagoAnticipo       VARCHAR2(30),
                                 HoraPagoAnticipo        VARCHAR2(20),
                                 InstruccionesAnticipo   VARCHAR2(200));

   TYPE tytCanalUnoB IS RECORD (   NroCanal					  VARCHAR2(5),
								NumeroCompleto			      VARCHAR2(30),
								TipoDescuentoCargo            VARCHAR2(10),
								IdentificacionDescuentoCargo  VARCHAR2(20),
								CodigoDescuento               VARCHAR2(20),
								ObservacionDescuentoCargo     VARCHAR2(50),
								PorcentajeDescuentoCargo      VARCHAR2(10),
								ValorTotalDescuentoCargo      VARCHAR2(30),
								BaseDescuentoCargo            VARCHAR2(30));

    TYPE tytCanalOcho IS RECORD (   NroCanal					  VARCHAR2(5),
                                    NumeroCompleto			      VARCHAR2(30),
                                    LimInferior			          VARCHAR2(20),
                                    LimSuperior					  VARCHAR2(20),
                                    ValorUnidad		              VARCHAR2(30),
                                    ConsumoRango			      VARCHAR2(30),
                                    ValorConsumoRango			  VARCHAR2(30));

    TYPE tbltytCanalOcho IS TABLE OF tytCanalOcho INDEX BY VARCHAR2(40);

    TYPE tytCanalNueve IS RECORD (   NroCanal					  VARCHAR2(5),
                                    NumeroCompleto			      VARCHAR2(30),
                                    IDOrdenamiento		          VARCHAR2(20),
                                    FechaConsumo				  VARCHAR2(30),
                                    Consumo			              VARCHAR2(30),
                                    DiasConsumo			      	  VARCHAR2(20));

    TYPE tbltytCanalNueve IS TABLE OF tytCanalNueve   INDEX BY VARCHAR2(40);

    TYPE tytCanalDos IS RECORD (    NroCanal		    VARCHAR2(5),
                                    NumeroCompleto	    VARCHAR2(30),
                                    LlevaAnexos		    VARCHAR2(10),
                                    CantidadAnexos	    VARCHAR2(10),
                                    NombreAnexo		    VARCHAR2(200),
                                    RazonSocial		    VARCHAR2(200),
                                    NIT				    VARCHAR2(30),
                                    FabricanteSW        VARCHAR2(30),
                                    NombreSW		    VARCHAR2(100),
                                    Resolucion		    VARCHAR2(100),
                                    ConsecutivoInicial  VARCHAR2(100),
                                    ConsecutivoFinal	VARCHAR2(100),
                                    Prefijo             VARCHAR2(100),
                                    FechaResolucion     VARCHAR2(100),
                                    FechaInicioVigencia VARCHAR2(100),
                                    FechaFinalVigencia  VARCHAR2(100));

    TYPE tytCanalTres IS RECORD (    NroCanal		                  VARCHAR2(5),
                                    NumeroCompleto	                  VARCHAR2(30),
                                    NaturalezaEmisor                  VARCHAR2(10),
                                    CodigoIdentificacionEmisor	      VARCHAR2(10),
                                    DescripcionIdentificacionEmi	  VARCHAR2(50),
                                    NumeroIdentificacionEmisor		  VARCHAR2(30),
                                    DigitoVerificacionEmisor          VARCHAR2(5),
                                    RazonSocialEmisor                 VARCHAR2(200),
                                    NombreComercialEmisor		      VARCHAR2(200),
                                    MatriculaMercantilEmisor          VARCHAR2(50),
                                    CodDepartamentoExpedicionEmi      VARCHAR2(10),
                                    NomDepartamentoExpedicionEmi      VARCHAR2(50),
                                    CodMunicipioExpedicionEmisor      VARCHAR2(10),
                                    NombreMunicipioExpedicionEmi      VARCHAR2(50),
                                    DireccionExpedicionEmisor         VARCHAR2(100),
                                    CodigoZonaPostalExpedicionEmi     VARCHAR2(10),
                                    CodigoPaisExpedicionEmisor        VARCHAR2(10),
                                    NombrePaisExpedicionEmisor        VARCHAR2(30),
                                    CodigoDepartamentoFiscalEmi       VARCHAR2(10),
                                    NombreDepartamentoFiscalEmi       VARCHAR2(50),
                                    CodigoMunicipioFiscalEmisor       VARCHAR2(10),
                                    NombreMunicipioFiscalEmisor       VARCHAR2(50),
                                    DireccionFiscalEmisor             VARCHAR2(100),
                                    CodigoZonaPostalFiscalEmisor      VARCHAR2(50),
                                    CodigoPaisFiscalEmisor            VARCHAR2(50),
                                    NombrePaisFiscalEmisor            VARCHAR2(100),
                                    TipoRegimenEmisor                 VARCHAR2(100),
                                    ResponsabilidadesFiscalesEmi      VARCHAR2(100),
                                    CodigoTributoResponsableEmi       VARCHAR2(100),
                                    NombreTributoResponsableEmi       VARCHAR2(100),
                                    CorreoElectronicoEmisor           VARCHAR2(50),
                                    CorreoElectronicoControler        VARCHAR2(50),
                                    TelefonoEmisor                    VARCHAR2(30),
                                    FaxEmisor                         VARCHAR2(30),
                                    Opcional21                        VARCHAR2(10),
                                    Opcional22                        VARCHAR2(10),
                                    Opcional23                        VARCHAR2(10),
                                    Opcional24                        VARCHAR2(10),
                                    Opcional25                        VARCHAR2(10),
                                    Opcional26                        VARCHAR2(10),
                                    Opcional27                        VARCHAR2(10),
                                    Opcional28                        VARCHAR2(10),
                                    Opcional29                        VARCHAR2(10),
                                    Opcional30                        VARCHAR2(10));

   TYPE tytCanalTresA IS RECORD (  NroCanal		                   VARCHAR2(5),
                                    NumeroCompleto	                   VARCHAR2(30),
                                    CodIdentificacionParticipante      VARCHAR2(30),
                                    DescIdentificacionParticipante     VARCHAR2(50),
                                    NumIdentificacionParticipante      VARCHAR2(30),
                                    DigitoVerificacionParticipante     VARCHAR2(10),
                                    RazonSocialParticipante            VARCHAR2(200),
                                    PorcentajeParticipacion            VARCHAR2(10),
                                    TipoRegimenParticipante            VARCHAR2(10),
                                    ResponFiscalesParticipante         VARCHAR2(30),
                                    CodTributoResponParticipante       VARCHAR2(30),
                                    NombTributoResponParticipante      VARCHAR2(50));

  TYPE tytCanalCuatro IS RECORD (   NroCanal		                   VARCHAR2(5),
                                    NumeroCompleto	                   VARCHAR2(30),
                                    NaturalezaReceptor			       VARCHAR2(10),
                                    CodigoIdentificacionReceptor	   VARCHAR2(10),
                                    DescIdentificacionReceptor         VARCHAR2(100),
                                    NumeroIdentificacionReceptor       VARCHAR2(100),
                                    DigitoVerificacionReceptor         VARCHAR2(5),
                                    RazonSocialReceptor            	   VARCHAR2(500),
                                    NombreComercialReceptor            VARCHAR2(500),
                                    MatriculaMercantilReceptor         VARCHAR2(500),
                                    CodigoDepartamentoReceptor         VARCHAR2(20),
                                    NombreDepartamentoReceptor         VARCHAR2(50),
                                    CodigoMunicipioReceptor            VARCHAR2(20),
                                    NombreMunicipioReceptor            VARCHAR2(500),
                                    DireccionReceptor                  VARCHAR2(500),
                                    CodigoZonaPostalReceptor           VARCHAR2(500),
                                    CodigoPaisReceptor                 VARCHAR2(20),
                                    NombrePaisReceptor                 VARCHAR2(500),
                                    TipoRegimenReceptor                VARCHAR2(500),
                                    ResponFiscalesReceptor             VARCHAR2(500),
                                    CodTributoResponsableReceptor      VARCHAR2(500),
                                    NombTributoResponsableReceptor     VARCHAR2(500),
                                    CorreoElectronicoReceptor          VARCHAR2(100),
                                    TelefonoReceptor                   VARCHAR2(100),
                                    FaxReceptor                        VARCHAR2(30),
                                    NotaContacto                       VARCHAR2(100),
                                    CodigoIdentificacionAutorizado     VARCHAR2(100),
                                    NumeroIdentificacionAutorizado     VARCHAR2(30),
                                    DigitoIdentificacionAutorizado     VARCHAR2(10),
                                    Uso                                VARCHAR2(50),
                                    Estrato                            VARCHAR2(20),
                                    Ciclo                              VARCHAR2(20),
                                    RutaReparto                        VARCHAR2(500),
                                    Medidor                            VARCHAR2(200),
                                    DireccionCobro                     VARCHAR2(500),
                                    DescripcionBarrio                  VARCHAR2(500),
                                    CorreoElectronico2                 VARCHAR2(100),
                                    EstadoTecnico                      VARCHAR2(20));

  TYPE tytCanalCinco IS RECORD (  NroCanal		    VARCHAR2(5),
								NumeroCompleto	    VARCHAR2(30),
								CodigoImpuesto      VARCHAR2(30),
								NombreImpuesto      VARCHAR2(50),
								ValorTotalImpuesto  VARCHAR2(30),
								TipoImpuesto        VARCHAR2(30),
								Opcional41          VARCHAR2(30),
								Opcional42          VARCHAR2(30),
								Opcional43          VARCHAR2(30),
								Opcional44          VARCHAR2(30),
								Opcional45 			VARCHAR2(30) );


  TYPE tytCanalCincoA IS RECORD (  NroCanal		    				VARCHAR2(5),
                                    NumeroCompleto	    				VARCHAR2(30),
                                    ValorBaseImponible					VARCHAR2(30),
                                    ValorImpuesto                       VARCHAR2(30),
                                    Porcentaje                          VARCHAR2(10),
                                    UnidadMedidaBaseTributo             VARCHAR2(20),
                                    IdentUnidadMedidaTributo            VARCHAR2(30),
                                    ValorTributoUnidad                  VARCHAR2(30),
                                    Opcional46                          VARCHAR2(30),
                                    Opcional47                          VARCHAR2(30),
                                    Opcional48                          VARCHAR2(30),
                                    Opcional49                          VARCHAR2(30),
                                    Opcional50                          VARCHAR2(30) );

   TYPE tbltytCanalCincoA IS TABLE OF tytCanalCincoA INDEX BY VARCHAR2(40);

   TYPE tytCanalSeisA  IS RECORD (   NroCanal		    		 VARCHAR2(5),
                                    NumeroCompleto	    		 VARCHAR2(30),
                                    CodigoIdentificacionMandante VARCHAR2(30),
                                    NumeroIdentificacionMandante VARCHAR2(30),
                                    DigitoVerificacionMandante   VARCHAR2(10),
                                    Opcional66                   VARCHAR2(30),
                                    Opcional67                   VARCHAR2(30),
                                    Opcional68                   VARCHAR2(30),
                                    Opcional69                   VARCHAR2(30),
                                    Opcional70                   VARCHAR2(30));

  TYPE tytCanalSeisB  IS RECORD (   NroCanal		    		 VARCHAR2(5),
                                    NumeroCompleto	    		 VARCHAR2(30),
                                    TipoDescuentoCargoDetalle    VARCHAR2(30),
                                    IdentDescuentoCargoDetalle   VARCHAR2(30),
                                    CodigoDescuentoDetalle       VARCHAR2(20),
                                    ObseDescuentoCargoDetalle    VARCHAR2(100),
                                    PorcDescuentoCargoDetalle    VARCHAR2(10),
                                    ValorTotalDescCargoDetalle   VARCHAR2(30),
                                    BaseDescuentoCargoDetalle    VARCHAR2(30));

  TYPE tytCanalSeisC  IS RECORD (  NroCanal		    		 VARCHAR2(5),
                                   NumeroCompleto	    		 VARCHAR2(30),
                                   CodigoImpuestoDetalle       VARCHAR2(30),
                                   NombreImpuestoDetalle       VARCHAR2(50),
                                   ValorTotalImpuestoDetalle   VARCHAR2(30),
                                   TipoImpuestoDetalle         VARCHAR2(30),
                                   Opcional71                  VARCHAR2(30),
                                   Opcional72                  VARCHAR2(30),
                                   Opcional73                  VARCHAR2(30),
                                   Opcional74                  VARCHAR2(30),
                                   Opcional75                  VARCHAR2(30));


  TYPE tytCanalSeisD  IS RECORD (   NroCanal		    		    VARCHAR2(5),
                                    NumeroCompleto	    		    VARCHAR2(30),
                                    ValorBaseImponibleDetalle       VARCHAR2(30),
                                    ValorImpuestoDetalle            VARCHAR2(30),
                                    PorcentajeDetalle               VARCHAR2(10),
                                    UnidMedidaBaseTributoDetalle    VARCHAR2(10),
                                    IdenUnidMedidaTributoDetalle    VARCHAR2(20),
                                    ValorTributoUnidadDetalle       VARCHAR2(30),
                                    Opcional76                      VARCHAR2(30),
                                    Opcional77                      VARCHAR2(30),
                                    Opcional78                      VARCHAR2(30),
                                    Opcional79                      VARCHAR2(30),
                                    Opcional80                      VARCHAR2(30));

   TYPE tytCanalSeis  IS RECORD (   NroCanal		    			   VARCHAR2(5),
                                    NumeroCompleto	    			   VARCHAR2(30),
                                    IDOrdenamiento                     VARCHAR2(10),
                                    EstandarArticulo                   VARCHAR2(10),
                                    CodigoArticulo                     VARCHAR2(20),
                                    DescripcionArticulo                VARCHAR2(50),
                                    Observaciones                      VARCHAR2(100),
                                    MarcaArticulo                      VARCHAR2(20),
                                    ModeloArticulo                     VARCHAR2(20),
                                    CantidadDetalle                    VARCHAR2(20),
                                    CantidadBaseDetalle                VARCHAR2(20),
                                    PackDetalle                        VARCHAR2(30),
                                    UnidadMedidadDetalle               VARCHAR2(10),
                                    ValorUnitarioDetalle               VARCHAR2(20),
                                    ValorTotalDetalle                  VARCHAR2(20),
                                    DetalleRegalo                      VARCHAR2(20),
                                    PrecioReferenciaDetalle            VARCHAR2(30),
                                    CodigoPrecioReferenciaDetalle      VARCHAR2(20),
                                    CodigoCentroCostosDetalle          VARCHAR2(20),
                                    NombreCentroCostosDetalle          VARCHAR2(50),
                                    Opcional51                         VARCHAR2(30),
                                    Opcional52                         VARCHAR2(30),
                                    Opcional53                         VARCHAR2(30),
                                    Opcional54                         VARCHAR2(30),
                                    Opcional55                         VARCHAR2(30),
                                    Opcional56                         VARCHAR2(30),
                                    Opcional57                         VARCHAR2(30),
                                    Opcional58                         VARCHAR2(30),
                                    Opcional59                         VARCHAR2(30),
                                    Opcional60                         VARCHAR2(30),
                                    Opcional61                         VARCHAR2(30),
                                    Opcional62                         VARCHAR2(30),
                                    Opcional63                         VARCHAR2(30),
                                    Opcional64                         VARCHAR2(30),
                                    Opcional65                         VARCHAR2(30),
                                    infoCanal6a                        tytCanalSeisA,
                                    infoCanal6b                        tytCanalSeisB,
                                    infoCanal6c                        tytCanalSeisC,
                                    infoCanal6d                        tytCanalSeisD );

  TYPE tbltytCanalSeis IS TABLE OF tytCanalSeis INDEX BY VARCHAR2(40);

  TYPE tytCanalDiez  IS RECORD (   NroCanal		 VARCHAR2(5),
                                    NumeroCompleto	 VARCHAR2(30),
                                    IDOrdenamiento   VARCHAR2(20),
                                    Concepto         VARCHAR2(20),
                                    Descripcion      VARCHAR2(150),
                                    SaldoAnterior    VARCHAR2(100),
                                    Capital          VARCHAR2(100),
                                    Intereses        VARCHAR2(100),
                                    Total            VARCHAR2(100),
                                    SaldoDiferido    VARCHAR2(100),
                                    UnidadDelItem    VARCHAR2(10),
                                    CantidadDelItem  VARCHAR2(100),
                                    ValorUnitario    VARCHAR2(100),
                                    IVA              VARCHAR2(100),
                                    CuotasFaltantes  VARCHAR2(20));

    TYPE tbltytCanalDiez IS TABLE OF tytCanalDiez INDEX BY VARCHAR2(40);

    TYPE tytCanalSiete IS RECORD (  NroCanal		 VARCHAR2(5),
                                    NumeroCompleto	 VARCHAR2(30),
                                    Opcional81   	 VARCHAR2(30),
                                    Opcional82       VARCHAR2(30),
                                    Opcional83       VARCHAR2(30),
                                    Opcional84       VARCHAR2(30),
                                    Opcional85       VARCHAR2(30),
                                    Opcional86       VARCHAR2(30),
                                    Opcional87       VARCHAR2(30),
                                    Opcional88       VARCHAR2(30),
                                    Opcional89       VARCHAR2(30),
                                    Opcional90       VARCHAR2(30),
                                    Opcional91       VARCHAR2(30),
                                    Opcional92       VARCHAR2(30),
                                    Opcional93       VARCHAR2(30),
                                    Opcional94       VARCHAR2(30),
                                    Opcional95       VARCHAR2(30),
                                    Opcional96       VARCHAR2(30),
                                    Opcional97       VARCHAR2(30),
                                    Opcional98       VARCHAR2(30),
                                    Opcional99       VARCHAR2(30),
                                    Opcional100      VARCHAR2(30));

   --tipos para mapeo de xml de facturas
   TYPE tytInfoDatosCliente IS RECORD ( FACTURA				NUMBER(15),
                                        FECH_FACT			VARCHAR2(30),
                                        MES_FACT			VARCHAR2(30),
                                        PERIODO_FACT		VARCHAR2(40),
                                        PAGO_HASTA			VARCHAR2(30),
                                        DIAS_CONSUMO		VARCHAR2(10),
                                        CONTRATO			VARCHAR2(30),
                                        CUPON				VARCHAR2(30),
                                        NOMBRE				VARCHAR2(200),
                                        DIRECCION_COBRO		VARCHAR2(100),
                                        LOCALIDAD			VARCHAR2(60),
                                        CATEGORIA			VARCHAR2(30),
                                        ESTRATO				VARCHAR2(10),
                                        CICLO				VARCHAR2(15),
                                        RUTA				VARCHAR2(100),
                                        MESES_DEUDA			VARCHAR2(10),
                                        NUM_CONTROL			VARCHAR2(50),
                                        PERIODO_CONSUMO		VARCHAR2(40),
                                        SALDO_FAVOR			VARCHAR2(30),
                                        SALDO_ANT           VARCHAR2(30),
                                        FECHA_SUSPENSION	VARCHAR2(30),
                                        VALOR_RECL		 	VARCHAR2(30),
                                        TOTAL_FACTURA		VARCHAR2(30),
                                        PAGO_SIN_RECARGO	VARCHAR2(30),
                                        CONDICION_PAGO      VARCHAR2(30),
                                        IDENTIFICA          VARCHAR2(30),
                                        SERVICIO            VARCHAR2(30),
                                        CUPO_BRILLA			VARCHAR2(30));

   TYPE tytInfoDatosLectura IS RECORD ( NUM_MEDIDOR			VARCHAR2(30),
                                        LECTURA_ANTERIOR	VARCHAR2(30),
                                        LECTURA_ACTUAL		VARCHAR2(30),
                                        OBS_LECTURA 		VARCHAR2(20));

   TYPE tytInfoDatosConsumo IS RECORD ( CONS_CORREG			VARCHAR2(30),
                                        FACTOR_CORRECCION	VARCHAR2(10),
                                        CONSUMO_MES_1       VARCHAR2(10),
                                        FECHA_CONS_MES_1    VARCHAR2(10),
                                        CONSUMO_MES_2       VARCHAR2(10),
                                        FECHA_CONS_MES_2    VARCHAR2(10),
                                        CONSUMO_MES_3       VARCHAR2(10),
                                        FECHA_CONS_MES_3    VARCHAR2(10),
                                        CONSUMO_MES_4       VARCHAR2(10),
                                        FECHA_CONS_MES_4    VARCHAR2(10),
                                        CONSUMO_MES_5       VARCHAR2(10),
                                        FECHA_CONS_MES_5    VARCHAR2(10),
                                        CONSUMO_MES_6       VARCHAR2(10),
                                        FECHA_CONS_MES_6    VARCHAR2(10),
                                        CONSUMO_PROMEDIO    VARCHAR2(20),
                                        TEMPERATURA		    VARCHAR2(20),
                                        PRESION 		    VARCHAR2(10),
                                        EQUIVAL_KWH         VARCHAR2(150),
                                        CALCCONS            VARCHAR2(30));

   TYPE tytInfoDatosRevPer  IS RECORD ( TIPO_NOTI			VARCHAR2(30),
                                        MENS_NOTI	        VARCHAR2(100),
                                        FECH_MAXIMA		    VARCHAR2(50),
                                        FECH_SUSP 		    VARCHAR2(50));

   TYPE tytInfoRangos  IS RECORD (  LIM_INFERIOR    	VARCHAR2(10),
                                    LIM_SUPERIOR	    VARCHAR2(10),
                                    VALOR_UNIDAD		VARCHAR2(30),
                                    CONSUMO 		    VARCHAR2(20),
                                    VAL_CONSUMO         VARCHAR2(30) );

   TYPE tbltytInfoRangos IS TABLE OF tytInfoRangos INDEX BY VARCHAR2(40);
   TYPE tytInfoCompCost IS RECORD (  COMPCOST    	VARCHAR2(60),
                                     VALORESREF	    VARCHAR2(60),
                                     VALCALC   		VARCHAR2(60) );

   TYPE tytInfoCupon IS RECORD (  CODIGO_1    	VARCHAR2(30),
                                  CODIGO_2    	VARCHAR2(30),
                                  CODIGO_3    	VARCHAR2(30),
                                  CODIGO_4    	VARCHAR2(30),
                                  COD_BAR    	VARCHAR2(150));

   TYPE tytInfoDatosAdicional IS RECORD (  DIRECCION_PRODUCTO 	VARCHAR2(100),
                                           CAUSA_DESVIACION    	VARCHAR2(60),
                                           PAGARE_UNICO         VARCHAR2(40),
                                           CAMBIOUSO            VARCHAR2(5));

   TYPE tytInfoAdicional IS RECORD (  TASA_ULTIMA 	          VARCHAR2(30),
                                      TASA_PROMEDIO    	      VARCHAR2(30),
                                      CUADRILLA_REPARTO       VARCHAR2(60),
                                      OBSERV_NO_LECT_CONSEC   VARCHAR2(20),
                                      VISIBLE                 VARCHAR2(10),
                                      IMPRESO                 VARCHAR2(50),
                                      PROTECCION_ESTADO       VARCHAR2(5),
                                      ACUMU_TATT              VARCHAR2(30),
                                      FINAESPE                VARCHAR2(5),
                                      MED_MAL_UBICADO         VARCHAR2(5),
                                      IMPRIMEFACT             VARCHAR2(5),
                                      VALOR_ULT_PAGO          VARCHAR2(30),
                                      FECHA_ULT_PAGO          VARCHAR2(30),
                                      SALDO_ANTE              VARCHAR2(30),
                                      CALIFICACION            VARCHAR2(30));
   TYPE tytInfoTotales IS RECORD (  TOTAL 	                  VARCHAR2(50),
                                    IVA    	                  VARCHAR2(50),
                                    SUBTOTAL                  VARCHAR2(50),
                                    CARGOSMES                 VARCHAR2(50),
                                    CANTIDAD_CONC           VARCHAR2(10));

   TYPE tytInfoCargos  IS RECORD (  ETIQUETA  	     VARCHAR2(10),
                                    CONCEPTO_ID      NUMBER(10),
                                    DESC_CONCEP      VARCHAR2(100),
                                    SALDO_ANT        VARCHAR2(30),
                                    CAPITAL          VARCHAR2(30),
                                    INTERES          VARCHAR2(30),
                                    TOTAL            VARCHAR2(30),
                                    SALDO_DIF        VARCHAR2(50),
                                    UNIDAD_ITEMS     VARCHAR2(10),
                                    CANTIDAD         VARCHAR2(30),
                                    VALOR_UNITARIO   VARCHAR2(30),
                                    VALOR_IVA        VARCHAR2(30),
                                    CUOTAS           VARCHAR2(10),
                                    ORDENAMIENTO     VARCHAR2(10));

   TYPE tbltytInfoCargos IS TABLE OF tytInfoCargos INDEX BY VARCHAR2(40);
   TYPE tytInfoImpuesto IS RECORD ( nuValor        NUMBER(30,2),
                                    nuValorBase    NUMBER(20,2),
                                    nuImpuesto     NUMBER(20,2),
                                    nuTarifa       NUMBER(4,2));

   TYPE tbltytInfoImpuesto IS TABLE OF tytInfoImpuesto INDEX BY VARCHAR2(40);

   TYPE tytInfoAjustes IS RECORD ( nuValor         NUMBER(30,2),
                                   nuValorBase     NUMBER(30,2),
                                   nuConcepto      NUMBER(15),
                                   sbDescConce     VARCHAR2(50) );

   TYPE tytInfoIngresos IS RECORD ( nuIngreso       NUMBER(30,2),
                                    nuValorUnitario  NUMBER(30,2),
                                    nuConcepto      NUMBER(15),
                                    sbDescConce     VARCHAR2(50),
                                    isAjuste        VARCHAR2(2),
                                    nuValorIva       NUMBER(30,2),
									nuCantidad       NUMBER(15,2),
									sbUnidadMedida   VARCHAR2(10),
									InfoImpuesto    tytInfoImpuesto,
                                    infoDescuento   tytInfoAjustes  );

   TYPE tbltytInfoIngresos IS TABLE OF tytInfoIngresos INDEX BY VARCHAR2(40);



   TYPE tbltytInfoAjustes IS TABLE OF tytInfoAjustes INDEX BY VARCHAR2(40);

   PROCEDURE prGetInfoEquivaLoca( inuLocalidad     IN  NUMBER,
                                 osbCiudad        OUT VARCHAR2,
                                 osbDepartamento  OUT VARCHAR2,
                                 osbDescDepart    OUT VARCHAR2,
                                 osbDescLocalidad OUT VARCHAR2,
                                 onuError         OUT NUMBER,
                                 osbError         OUT VARCHAR2);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoEquivaLoca
    Descripcion     : Proceso que retorna informacion de equivalencia para facturacion
                      electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      inuLocalidad   codigo de la localidad
    Parametros de Salida
      osbCiudad          localidad
      onuDepartamento    departamento
      osbDescDepart      descripcion departamento
      osbDescLocalidad   descripcion de la ciudad
      onuError           codigo del error
      osbError           mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        09-01-2024   OSF-2158    Creacion
  ***************************************************************************/
 FUNCTION fnuGetEquivaleTipoIdent( inuTipoIden IN NUMBER,
                                    osbDescriTipoIden OUT VARCHAR2 ) RETURN equi_tipo_identfael.tipo_idendian%type;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetEquivaleTipoIdent
    Descripcion     : Proceso que retorna informacion de equivalencia de tipo de identificacion
                      facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      inuTipoIden   tipo de identificacion de osf
    Parametros de Salida
      osbDescriTipoIden   descripcion de tipo de identificacion
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        09-01-2024   OSF-2158    Creacion
  ***************************************************************************/
   FUNCTION fnuGetConsecutivo RETURN factura_elect_general.consfael%TYPE ;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetConsecutivo
    Descripcion     : funcion para obtener consecutivo
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 15-01-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  FUNCTION fsbGetFacturaElec RETURN factura_elect_general.consfael%TYPE ;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbGetFacturaElec
    Descripcion     : funcion para devolver factura electronica
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 07-06-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       07-06-2024   OSF-2158    Creacion
  ***************************************************************************/
 FUNCTION fsbGetDigitoVerifi(isbIdentificacion IN VARCHAR2,
                               osbIdenfiSinDigi OUT VARCHAR2) RETURN VARCHAR2;
  /**************************************************************************
   Propiedad Intelectual de GDC

    Funcion     :  fsbGetDigitoVerifi
    Descripcion :  devuelve digito de verificacion
    Autor       :  Luis Javier Lopez Barrios
    Fecha       :   23-01-2024

    Entrada
      isbIdentificacion identificacion
    Salida
     osbIdenfiSinDigi    identificacion sin digito de verificacion
    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    23-01-2024           LJLB               Creacion
  **************************************************************************/

   FUNCTION fsbGetAmbiente RETURN VARCHAR2 ;
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbGetAmbiente
    Descripcion     : retorna ambiente para canal uno facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 09-01-2024

    Parametros de Entrada
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        09-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  PROCEDURE prMapearDatosFactura ( inuFactura           IN NUMBER,
                                   oclSpool             OUT CLOB,
                                   onuError             OUT NUMBER,
                                   osbError             OUT VARCHAR2);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prMapearDatosFactura
    Descripcion     : Proceso que se encarga de mapear xml de la factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 09-01-2024

    Parametros de Entrada
      inuFactura   codigo de la factura
    Parametros de Salida
      oclSpool      salida del spool
      onuError     codigo del error
      osbError     mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        09-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  PROCEDURE prGetInfoValoraReportar ( inuFactura  IN NUMBER,
                                     onuError     OUT NUMBER,
                                     osbError     OUT VARCHAR2);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoValoraReportar
    Descripcion     : Proceso obtiene informacion de valores a reportar en la facturacion
                      electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 05-02-2024

    Parametros de Entrada
      inuFactura   codigo de la factura
    Parametros de Salida
      onuError             codigo del error
      osbError             mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        05-02-2024   OSF-2158    Creacion
  ***************************************************************************/

  PROCEDURE prGetInfoCanalUno( inuFactura       IN   NUMBER,
                               inuTipoDocu      IN  NUMBER,
                               ioCblSpool       IN OUT CLOB,
                               OtytCanalUno     OUT  tytCanalUno,
                               OtytCanalUnoCon  OUT  tytCanalUno,
                               OnuContrato      OUT  NUMBER,
                               osbRutaReparto   OUT  VARCHAR2);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalUno
    Descripcion     : retorna informacion para canal uno facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 09-01-2024

    Parametros de Entrada
      inuFactura       codigo de la factura
      inuTipoDocu      tipo de documento
    Parametros de Salida
      ioCblSpool       estructura spool
      OtytCanalUno     registro de canal uno
      OtytCanalUnoCon  registro de canal uno contigencia
      OnuContrato      numero de contrato
      osbRutaReparto   ruta de reparto
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        09-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  PROCEDURE prGetInfoCanalUnoA( inuFactura       IN   NUMBER,
                                  OtytCanalUnoA     OUT  tytCanalUnoA);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalUnoA
    Descripcion     : retorna informacion para canal uno a facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 09-01-2024

    Parametros de Entrada
      inuFactura       codigo de la factura
    Parametros de Salida
      OtytCanalUnoA    tabla con registro de canal uno a

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  PROCEDURE prGetInfoCanalUnoB( inuFactura       IN   NUMBER,
                                OtytCanalUnoB    OUT  tytCanalUnoB);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalUnoA
    Descripcion     : retorna informacion para canal uno a facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 09-01-2024

    Parametros de Entrada
      inuFactura       codigo de la factura
    Parametros de Salida
      OtytCanalUnoB    tabla con registro de canal uno b

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  PROCEDURE prGetInfoCanalOcho( otbltytCanalOcho   OUT  tbltytCanalOcho);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalOcho
    Descripcion     : retorna informacion para canal ocho facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otbltytCanalUnoG    tabla con registro de canal ocho

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
   PROCEDURE prGetInfoCanalNueve( otbltytCanalNueve OUT  tbltytCanalNueve);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalNueve
    Descripcion     : retorna informacion para canal nueve facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otbltytCanalNueve    tabla con registro de canal nueve

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/

   PROCEDURE prGetInfoCanalDos( otytCanalDos OUT  tytCanalDos,
                                otytCanalDosCont OUT  tytCanalDos);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalDos
    Descripcion     : retorna informacion para canal dos facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otytCanalDos        registro de canal dos
       otytCanalDosCont   registro de canal dos contigencia
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/

   PROCEDURE prGetInfoCanalTres( otytCanalTres OUT  tytCanalTres);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : otytCanalTres
    Descripcion     : retorna informacion para canal tres facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      prGetInfoCanalTres    tabla con registro de canal tres
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  PROCEDURE prGetInfoCanalTresA( otytCanalTresA OUT  tytCanalTresA);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalTresA
    Descripcion     : retorna informacion para canal tres a facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otytCanalTresA    tabla con registro de canal tres a
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  PROCEDURE prGetInfoCanalCuatro( inuFactura      IN   NUMBER,
                                  otytCanalCuatro OUT  tytCanalCuatro);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalCuatro
    Descripcion     : retorna informacion para canal cuatro facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otytCanalTresA    tabla con registro de canal cuatro
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  PROCEDURE prGetInfoCanalCinco( otytCanalCinco  OUT  tytCanalCinco);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalCinco
    Descripcion     : retorna informacion para canal cinco facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otytCanalCinco    registro de canal cinco
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  PROCEDURE prGetInfoCanalCincoA( otbltytCanalCincoA OUT  tbltytCanalCincoA);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalCinco
    Descripcion     : retorna informacion para canal cinco facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otytCanalCinco    tabla con registro de canal cinco
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  PROCEDURE prGetInfoCanalSeis( inuFactura        IN NUMBER,
                                inuTipoDocu       IN NUMBER,
                                isbOperacion      IN VARCHAR2,
                                otbltytCanalSeis  OUT  tbltytCanalSeis,
                                osbEmitirFactura  OUT VARCHAR);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalSeis
    Descripcion     : retorna informacion para canal seis facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada
      inuFactura  codigo de la factura
      inuTipoDocu tipo de documento
      isbOperacion   operacion I - INsertar A actualizar
    Parametros de Salida
      otbltytCanalSeis    tabla con registro de canal seis
      osbEmitirFactura    emitir factura
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
   PROCEDURE prGetInfoCanalSeisA( otytCanalSeisA     OUT  tytCanalSeisA);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalSeisA
    Descripcion     : retorna informacion para canal seis a facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otytCanalSeisA    Registro de canal seis a
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
   PROCEDURE prGetInfoCanalSeisB( inuConcepto     IN   NUMBER,
                                  onuDescuento    OUT  NUMBER,
                                  OtytCanalSeisB  OUT  tytCanalSeisb);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalSeisB
    Descripcion     : retorna informacion para canal seis b facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada
      inuConcepto  Codigo del concepto
    Parametros de Salida
      onuDescuento     descuento aplicado
      otytCanalSeisB    registro de canal seis b

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  PROCEDURE prGetInfoCanalSeisC( ItytInfoImpuesto  IN   tytInfoImpuesto,
                                 otytCanalSeisC    OUT  tytCanalSeisc);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalSeisC
    Descripcion     : retorna informacion para canal seis c facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada
      ItytInfoImpuesto   registro de impuesto
    Parametros de Salida
      otytCanalSeisc    registro de canal seis c

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
   PROCEDURE prGetInfoCanalSeisD( ItytInfoImpuesto  IN   tytInfoImpuesto,
                                  otytCanalSeisD    OUT  tytCanalSeisD);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalSeisC
    Descripcion     : retorna informacion para canal seis d facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada
      ItytInfoImpuesto   registro de impuesto
    Parametros de Salida
      otytCanalSeisD    registro de canal seis d

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  PROCEDURE prGetInfoCanalDiez( inuFactura        IN   NUMBER,
                                otbltytCanalDiez  OUT  tbltytCanalDiez);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalDiez
    Descripcion     : retorna informacion para canal diez facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada
      inuFactura     codigo de la factura
    Parametros de Salida
      otbltytCanalDiez    tabla con registro de canal diez
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  PROCEDURE prGetInfoCanalSiete( otytCanalSiete    OUT  tytCanalSiete);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalSiete
    Descripcion     : retorna informacion para canal siete facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      prGetInfoCanalSiete    tabla con registro de canal siete
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
   PROCEDURE prGetInfoValoraReportarVentas ( inuFactura      IN NUMBER,
                                            oblFacturaVenta OUT BOOLEAN,
                                            onuError        OUT NUMBER,
                                            osbError        OUT VARCHAR2);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoValoraReportarVentas
    Descripcion     : Proceso obtiene informacion de valores a reportar en la facturacion de ventas
                      electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 05-02-2024

    Parametros de Entrada
      inuFactura   codigo de la factura
    Parametros de Salida
      onuError             codigo del error
      osbError             mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        05-02-2024   OSF-2158    Creacion
  ***************************************************************************/

  PROCEDURE prGetInfoValoraReportarNotas ( inuNota    IN NUMBER,
                                           onuError   OUT NUMBER,
                                           osbError   OUT VARCHAR2);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoValoraReportarNotas
    Descripcion     : Proceso obtiene informacion de valores a reportar de las notas    electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 05-02-2024

    Parametros de Entrada
      inuNota   codigo de la nota
    Parametros de Salida
      onuError             codigo del error
      osbError             mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        05-02-2024   OSF-2158    Creacion
  ***************************************************************************/

   PROCEDURE prInicializarVariables ;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInicializarVariables
    Descripcion     : Inicializa variables globales
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 15-01-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2024   OSF-2158    Creacion
  ***************************************************************************/
   FUNCTION fsbGetPrefijo RETURN factura_elect_general.consfael%TYPE ;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbGetPrefijo
    Descripcion     : funcion para devolver prefijo factura electronica
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 07-06-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       07-06-2024   OSF-2158    Creacion
  ***************************************************************************/
END PKG_BCFACTUELECTRONICAGEN;
/
create or replace PACKAGE BODY  personalizaciones.PKG_BCFACTUELECTRONICAGEN IS
    -- Constantes para el control de la traza
  csbSP_NAME        CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion          CONSTANT VARCHAR2(15) := 'OSF-2158';
  nuError             NUMBER;
  sbError             VARCHAR2(4000);
  nuConsecutivo       NUMBER;
  sbPrefijo           VARCHAR2(30);
  sbNumeroCompleto    VARCHAR2(30);
  gnuCantConc         NUMBER;
  gsbResolucion       VARCHAR2(100);
  gnuConsInicial      NUMBER;
  gnuConsFinal        NUMBER;
  gdtFechaResol       DATE;
  gdtFechaIniVige     DATE;
  gdtFechaFinVige     DATE;
  nuConceptoCons      NUMBER := pkg_parametros.fnugetvalornumerico('CONCEPTO_CONSUMO_FAEL');
  nuConsTrans         NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_CONCTATT');
  gnuContadorLinea    NUMBER;
  gnuValorTotalIva    NUMBER;
  gnuValorTotal       NUMBER;
  gnuValorBaseTotal   NUMBER;
  gnuValorDescuento   NUMBER;

  gnuValorIngreso   NUMBER;
  gnuValorDescGen   NUMBER;
  gsbArteFactura    VARCHAR2(200);

  gsbTipoDocuAiu      VARCHAR2(4) := 'N';
  gsbConceptosAiu      VARCHAR2(4000) ;

  v_tytInfoDatosCliente   tytInfoDatosCliente;
  v_tytInfoDatosLectura   tytInfoDatosLectura;
  v_tytInfoDatosConsumo   tytInfoDatosConsumo;
  v_tytInfoDatosRevPer    tytInfoDatosRevPer;
  v_tytInfoRangos         tytInfoRangos;
  V_tbltytInfoRangos      tbltytInfoRangos;
  v_tytInfoCompCost       tytInfoCompCost;
  v_tytInfoCupon          tytInfoCupon;
  v_tytInfoDatosAdicional tytInfoDatosAdicional;
  v_tytInfoAdicional      tytInfoAdicional;
  v_tbltytInfoCargos      tbltytInfoCargos;
  v_tbltytInfoIngresos    tbltytInfoIngresos;
  v_tbltytInfoImpuesto    tbltytInfoImpuesto;
  v_tbltytInfoAjustes     tbltytInfoAjustes;

  v_tytInfoTotales  tytInfoTotales;


   csbMatriculaMerca    CONSTANT VARCHAR2(50) := pkg_parametros.fsbgetvalorcadena('MATRICULA_MERCANTIL');
  cnuLocalidadEmisor   CONSTANT NUMBER       := pkg_parametros.fnugetvalornumerico('LOCALIDAD_EMISOR');
  csbZonaPostalEmisor  CONSTANT VARCHAR2(100) := pkg_parametros.fsbgetvalorcadena('ZONA_POSTAL_EMISOR');
  csbRespFiscalEmisor  CONSTANT VARCHAR2(100) := pkg_parametros.fsbgetvalorcadena('RESP_FISCAL_EMISOR');
  csbCodTributoEmisor  CONSTANT VARCHAR2(100) := pkg_parametros.fsbgetvalorcadena('COD_TRIBUTO_EMISOR');
  csbNombTributoEmisor CONSTANT VARCHAR2(100) := pkg_parametros.fsbgetvalorcadena('NOMBRE_TRIBUTO_EMISOR');
  csbEmailEmisor       CONSTANT VARCHAR2(100) := pkg_parametros.fsbgetvalorcadena('EMAIL_EMISOR');
  csbEmailContEmisor   CONSTANT VARCHAR2(100) := pkg_parametros.fsbgetvalorcadena('EMAIL_CONTROLER_EMISOR');
  csbTelefonoEmisor    CONSTANT VARCHAR2(100) := pkg_parametros.fsbgetvalorcadena('TELEFONO_EMISOR');
  csbFaxEmisor         CONSTANT VARCHAR2(100) := pkg_parametros.fsbgetvalorcadena('FAX_EMISOR');
  csbRazonSocialEmisor CONSTANT VARCHAR2(200) := pkg_parametros.fsbgetvalorcadena('RAZON_SOCIAL_EMISOR');
  csbDireccionEmisor   CONSTANT VARCHAR2(200) := pkg_parametros.fsbgetvalorcadena('DIRECCION_EMISOR');
  csbTipoRegiEmisor    CONSTANT VARCHAR2(200) := pkg_parametros.fsbgetvalorcadena('TIPO_REGIMEN_EMISOR');

  csbArteFactRecurr    CONSTANT VARCHAR2(200) := pkg_parametros.fsbgetvalorcadena('ARTE_FACT_RECURRENTE');
  csbArteFactRecurrnR    CONSTANT VARCHAR2(200) := pkg_parametros.fsbgetvalorcadena('ARTE_FACT_RECURRENTE_NR');
  csbArteFactVenta     CONSTANT VARCHAR2(200) := pkg_parametros.fsbgetvalorcadena('ARTE_FACT_VENTA');
  csbArteNotas         CONSTANT VARCHAR2(200) := pkg_parametros.fsbgetvalorcadena('ARTE_NOTAS');

  cnuCodigoDescuento   CONSTANT NUMBER  := pkg_parametros.fnugetvalornumerico('CODIGO_DESCUENTO');
  nuPorcIva            CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('PORCENTAJE_IVA_ACTUAL');

  nuFacturaAso         VARCHAR2(4000);
  dtFechaAso           DATE;
  sbTipoNota           VARCHAR2(2);
  gsbObservacionNota   VARCHAR2(200);
  csbPrefijoNotaCre    CONSTANT VARCHAR2(200) := pkg_parametros.fsbgetvalorcadena('PREFIJO_NOTA_CREDITO');
  csbPrefijoNotaDeb    CONSTANT VARCHAR2(200) := pkg_parametros.fsbgetvalorcadena('PREFIJO_NOTA_DEBITO');

  csbDescNotaCre      CONSTANT VARCHAR2(200) := pkg_parametros.fsbgetvalorcadena('CODIGO_CONCEPTO_NOTACRE_FAEL');
  csbDescNotaDeb       CONSTANT VARCHAR2(200) := pkg_parametros.fsbgetvalorcadena('CODIGO_CONCEPTO_NOTADEB_FAEL');
  csbCodConcNotaCre    CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('CODIGO_CONCEPTO_NOTACRE_FAEL');
  csbCodConcNotaDeb    CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('CODIGO_CONCEPTO_NOTADEB_FAEL');
  sbcalificacion VARCHAR2(100);


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

  FUNCTION fsbGetDigitoVerifi(isbIdentificacion IN VARCHAR2,
                               osbIdenfiSinDigi OUT VARCHAR2) RETURN VARCHAR2 IS
  /**************************************************************************
   Propiedad Intelectual de GDC

    Funcion     :  fsbGetDigitoVerifi
    Descripcion :  devuelve digito de verificacion
    Autor       :  Luis Javier Lopez Barrios
    Fecha       :   23-01-2024

    Entrada
      isbIdentificacion identificacion
    Salida
     osbIdenfiSinDigi    identificacion sin digito de verificacion
    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    23-01-2024           LJLB               Creacion
  **************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fsbGetDigitoVerifi';
    sbDigitoVeri    VARCHAR2(2);

    nuError  NUMBER;
    sbError  VARCHAR2(4000);

    CURSOR cuGetDigitoVeri IS
     SELECT SUBSTR(REVERSE( isbIdentificacion), 1,  1) digito_verif,
           SUBSTR(isbIdentificacion, 1, LENGTH(isbIdentificacion) - 1) NitSinDigi
    FROM DUAL;

  BEGIN

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('isbIdentificacion => ' || isbIdentificacion, pkg_traza.cnuNivelTrzDef);
    IF cuGetDigitoVeri%ISOPEN THEN
       CLOSE cuGetDigitoVeri;
    END IF;

    OPEN cuGetDigitoVeri;
    FETCH cuGetDigitoVeri INTO sbDigitoVeri, osbIdenfiSinDigi;
    IF cuGetDigitoVeri%NOTFOUND THEN
       osbIdenfiSinDigi := isbIdentificacion;
    END IF;
    close cuGetDigitoVeri;
    pkg_traza.trace('sbDigitoVeri => ' || sbDigitoVeri, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    return nvl(sbDigitoVeri,'0');

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(nuError,sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RETURN '';
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RETURN '';
  END fsbGetDigitoVerifi;

  FUNCTION fnuGetConsecutivo RETURN factura_elect_general.consfael%TYPE IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetConsecutivo
    Descripcion     : funcion para obtener consecutivo
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 15-01-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  BEGIN
    RETURN nuConsecutivo;
  END fnuGetConsecutivo;

  PROCEDURE prSetConsecutivo( inuConsecutivo IN factura_elect_general.consfael%TYPE) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prSetConsecutivo
    Descripcion     : proceso para setear consecutivo
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 30-01-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  BEGIN
    nuConsecutivo := inuConsecutivo;
  END prSetConsecutivo;

  PROCEDURE prInicializarVariables IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInicializarVariables
    Descripcion     : Inicializa variables globales
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 15-01-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prInicializarVariables';
    v_tytInfoDatosClientenull 	tytInfoDatosCliente;
    v_tytInfoDatosLecturanull 	tytInfoDatosLectura;
    v_tytInfoDatosConsumonull 	tytInfoDatosConsumo;
    v_tytInfoDatosRevPernull  	tytInfoDatosRevPer;
    v_tytInfoRangosnull       	tytInfoRangos;
    v_tytInfoCompCostnull     	tytInfoCompCost;
    v_tytInfoCuponnull        	tytInfoCupon;
    v_tytInfoDatosAdicionalnull   tytInfoDatosAdicional;
    v_tytInfoAdicionalnull       tytInfoAdicional;
	v_tytInfoTotalesnull		 tytInfoTotales;

	    -- Cursor para leer la unidad de medida DIAN por concepto
    CURSOR cuUnidadMedida IS
    SELECT concepto_id,
           unidad_medida,
		   requiere_tarifa
    FROM conc_unid_medida_dian;



  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    v_tytInfoDatosCliente     := v_tytInfoDatosClientenull;
    v_tytInfoDatosLectura 	  := v_tytInfoDatosLecturanull;
    v_tytInfoDatosConsumo 	  := v_tytInfoDatosConsumonull;
    v_tytInfoDatosRevPer  	  := v_tytInfoDatosRevPernull;
    v_tytInfoRangos       	  := v_tytInfoRangosnull;
    v_tytInfoCompCost     	  := v_tytInfoCompCostnull;
    v_tytInfoCupon        	  := v_tytInfoCuponnull;
    v_tytInfoDatosAdicional   := v_tytInfoDatosAdicionalnull;
    v_tytInfoAdicional        := v_tytInfoAdicionalnull;
    gnuCantConc               := NULL;
    V_tbltytInfoRangos.delete;
	tbUnidadMedConc.delete;

	v_tytInfoTotales		  := v_tytInfoTotalesNULL;
    gsbResolucion             := null;
    gnuConsInicial            := null;
    gnuConsFinal              := null;
    gdtFechaResol             := null;
    gdtFechaIniVige           := null;
    gdtFechaFinVige           := null;
    v_tbltytInfoCargos.delete;
    gnuContadorLinea   := 0;
    gnuValorTotalIva := 0;
    gnuValorTotal := 0;
    gnuValorBaseTotal := 0;
    gnuValorDescuento := 0;
    gnuValorIngreso   := 0;
    gnuValorDescgen   := 0;
    gsbArteFactura    := NULL;
    v_tbltytInfoIngresos.delete;
    v_tbltytInfoImpuesto.delete;
    v_tbltytInfoAjustes.delete;
    gsbObservacionNota := NULL;

	IF cuUnidadMedida%ISOPEN THEN CLOSE cuUnidadMedida; END IF;
	--se carga tabla temporal de unidad de medida por concepto
	 FOR rc IN cuUnidadMedida LOOP
        tbUnidadMedConc(rc.concepto_id).sbUnidadMed := rc.unidad_medida;
        tbUnidadMedConc(rc.concepto_id).sbRequiereTarifa := rc.requiere_tarifa;
        tbUnidadMedConc(rc.concepto_id).nuConcepto := rc.concepto_id;
    END LOOP;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(nuError,sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prInicializarVariables;
  FUNCTION fsbGetFechaFormateada (isbFecha IN VARCHAR2) RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbGetFechaFormateada
    Descripcion     : Retona una fecha en formato YYYY-MM-DD
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 15-01-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       15-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fsbGetFechaFormateada';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('isbFecha => ' || isbFecha, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN TO_CHAR(TO_DATE(isbFecha, 'dd-mm-yyyy'),'yyyy-mm-dd');
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(nuError,sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RETURN '';
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RETURN '';
  END fsbGetFechaFormateada;

  PROCEDURE prGetInfoEquivaLoca( inuLocalidad     IN  NUMBER,
                                 osbCiudad        OUT VARCHAR2,
                                 osbDepartamento  OUT VARCHAR2,
                                 osbDescDepart    OUT VARCHAR2,
                                 osbDescLocalidad OUT VARCHAR2,
                                 onuError         OUT NUMBER,
                                 osbError         OUT VARCHAR2) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoEquivaLoca
    Descripcion     : Proceso que retorna informacion de equivalencia para facturacion
                      electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      inuLocalidad   codigo de la localidad
    Parametros de Salida
      osbCiudad          localidad
      osbDepartamento    departamento
      osbDescDepart      descripcion departamento
      osbDescLocalidad   descripcion de la ciudad
      onuError           codigo del error
      osbError           mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        09-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prGetInfoEquivaLoca';

    CURSOR cugetInfoCiudad IS
    SELECT ldc_equiva_localidad.departamento||ldc_equiva_localidad.municipio ciudad,
           ldc_equiva_localidad.departamento,
           l.description descciudad,
           d.description descdepartamento
    FROM ldc_equiva_localidad
      JOIN ge_geogra_location l ON l.geograp_location_id = ldc_equiva_localidad.geograp_location_id
      JOIN ge_geogra_location d ON d.geograp_location_id = l.geo_loca_father_id
    WHERE l.geograp_location_id = inuLocalidad;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuLocalidad => ' || inuLocalidad, pkg_traza.cnuNivelTrzDef);
    pkg_error.prinicializaerror(onuError, osbError);

    IF cugetInfoCiudad%ISOPEN THEN
       CLOSE cugetInfoCiudad;
    END IF;

    OPEN cugetInfoCiudad;
    FETCH cugetInfoCiudad INTO osbCiudad, osbDepartamento, osbDescLocalidad, osbDescDepart;
    CLOSE cugetInfoCiudad;

    pkg_traza.trace('osbCiudad => ' || osbCiudad, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('osbDepartamento => ' || osbDepartamento, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('osbDescLocalidad => ' || osbDescLocalidad, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('osbDescDepart => ' || osbDescDepart, pkg_traza.cnuNivelTrzDef);

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
  END prGetInfoEquivaLoca;

  FUNCTION fnuGetEquivaleTipoIdent( inuTipoIden IN NUMBER,
                                    osbDescriTipoIden OUT VARCHAR2 ) RETURN equi_tipo_identfael.tipo_idendian%type IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetEquivaleTipoIdent
    Descripcion     : Proceso que retorna informacion de equivalencia de tipo de identificacion
                      facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-01-2024

    Parametros de Entrada
      inuTipoIden   tipo de identificacion de osf
    Parametros de Salida
      osbDescriTipoIden   descripcion de tipo de identificacion
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        09-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fnuGetEquivaleTipoIdent';
    nuIdenDian equi_tipo_identfael.tipo_idendian%TYPE;

    CURSOR cugetEquiTipoIden IS
    SELECT equi_tipo_identfael.tipo_idendian,
           CASE WHEN TIPO_IDENDIAN =  13 THEN
                    'Cedula de ciudadania'
                WHEN TIPO_IDENDIAN =  41 THEN
                    'Pasaporte'
                WHEN TIPO_IDENDIAN =  22 THEN
                    'Cedula de extranjeria'
                WHEN TIPO_IDENDIAN =  12 THEN
                    'Tarjeta de identidad'
                WHEN TIPO_IDENDIAN =  31 THEN
                    'NIT'
         ELSE
              ''
         END descripcion
    FROM equi_tipo_identfael
    WHERE equi_tipo_identfael.tipo_idenosf = inuTipoIden;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuTipoIden => ' || inuTipoIden, pkg_traza.cnuNivelTrzDef);
    IF cugetEquiTipoIden%ISOPEN THEN
       CLOSE cugetEquiTipoIden;
    END IF;
    OPEN cugetEquiTipoIden;
    FETCH cugetEquiTipoIden INTO nuIdenDian, osbDescriTipoIden;
    CLOSE cugetEquiTipoIden;
    pkg_traza.trace('nuIdenDian => ' || nuIdenDian, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN nuIdenDian;

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(nuError,sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RETURN nuIdenDian;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' ||sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RETURN nuIdenDian;
  END fnuGetEquivaleTipoIdent;

  PROCEDURE prMapearDatosFactura ( inuFactura           IN NUMBER,
                                   oclSpool             OUT CLOB,
                                   onuError             OUT NUMBER,
                                   osbError             OUT VARCHAR2) IS
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prMapearDatosFactura
    Descripcion     : Proceso que se encarga de mapear xml de la factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 09-01-2024

    Parametros de Entrada
      inuFactura   codigo de la factura
    Parametros de Salida
      oclSpool      salida del spool
      onuError     codigo del error
      osbError     mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        09-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prMapearDatosFactura';

    clXmlFactura    ed_document.docudocu%type;


    cblRango  CLOB;
    cblCargos CLOB;


    nuContador      number := 0;
    CURSOR cuGetXmlFactura IS
    SELECT docudocu
    FROM ed_document
    WHERE docucodi =inuFactura;

    CURSOR cuInfoDatosGen(iclDatos CLOB) IS
    SELECT Datos.*
    FROM XMLTABLE ('/LDC_FACTURA/LDC_DATOS_CLIENTE'
                   PASSING XMLType (iclDatos)
                   COLUMNS  FACTURA			 NUMBER(15)  PATH 'FACTURA',
                            FECH_FACT		 VARCHAR2(30) PATH 'FECH_FACT',
                            MES_FACT		 VARCHAR2(30) PATH 'MES_FACT',
                            PERIODO_FACT	 VARCHAR2(40) PATH 'PERIODO_FACT',
                            PAGO_HASTA		 VARCHAR2(30) PATH 'PAGO_HASTA',
                            DIAS_CONSUMO	 VARCHAR2(10) PATH 'DIAS_CONSUMO',
                            CONTRATO		 VARCHAR2(30) PATH 'CONTRATO',
                            CUPON		     VARCHAR2(30) PATH 'CUPON',
                            NOMBRE		     VARCHAR2(200) PATH 'NOMBRE',
                            DIRECCION_COBRO	 VARCHAR2(100) PATH 'DIRECCION_COBRO',
                            LOCALIDAD		 VARCHAR2(60) PATH 'LOCALIDAD',
                            CATEGORIA		 VARCHAR2(30) PATH 'CATEGORIA',
                            ESTRATO		     VARCHAR2(10) PATH 'ESTRATO',
                            CICLO		     VARCHAR2(15) PATH 'CICLO',
                            RUTA		     VARCHAR2(100) PATH 'RUTA',
                            MESES_DEUDA		 VARCHAR2(10) PATH 'MESES_DEUDA',
                            NUM_CONTROL		 VARCHAR2(50) PATH 'NUM_CONTROL',
                            PERIODO_CONSUMO	 VARCHAR2(40) PATH 'PERIODO_CONSUMO',
                            SALDO_FAVOR		 VARCHAR2(30) PATH 'SALDO_FAVOR',
                            SALDO_ANT        VARCHAR2(30) PATH 'SALDO_ANT',
                            FECHA_SUSPENSION VARCHAR2(30) PATH 'FECHA_SUSPENSION',
                            VALOR_RECL		 VARCHAR2(30) PATH 'VALOR_RECL',
                            TOTAL_FACTURA	 VARCHAR2(30) PATH 'TOTAL_FACTURA',
                            PAGO_SIN_RECARGO VARCHAR2(30) PATH 'PAGO_SIN_RECARGO',
                            CONDICION_PAGO   VARCHAR2(30) PATH 'CONDICION_PAGO',
                            IDENTIFICA       VARCHAR2(30) PATH 'IDENTIFICA',
                            SERVICIO         VARCHAR2(30) PATH 'SERVICIO',
                            CUPO_BRILLA		 VARCHAR2(30) PATH 'CUPO_BRILLA') As Datos	;

    CURSOR cuInfoDatosLectura(iclDatos CLOB) IS
    SELECT Datos.*
    FROM XMLTABLE ('/LDC_FACTURA/LDC_DATOS_LECTURA'
			   PASSING XMLType (iclDatos)
			   COLUMNS  NUM_MEDIDOR			VARCHAR2(30) PATH 'NUM_MEDIDOR' ,
						LECTURA_ANTERIOR	VARCHAR2(30) PATH 'LECTURA_ANTERIOR',
						LECTURA_ACTUAL		VARCHAR2(30) PATH 'LECTURA_ACTUAL' ,
						OBS_LECTURA 		VARCHAR2(20) PATH 'OBS_LECTURA') As Datos;

    CURSOR cuInfoDatosConsumo(iclDatos CLOB) IS
    SELECT Datos.*
    FROM XMLTABLE ('/LDC_FACTURA/LDC_DATOS_CONSUMO'
                   PASSING XMLType (iclDatos)
                   COLUMNS  CONS_CORREG			VARCHAR2(30)  PATH 'CONS_CORREG',
                            FACTOR_CORRECCION	VARCHAR2(10)  PATH 'FACTOR_CORRECCION',
                            CONSUMO_MES_1       VARCHAR2(10)  PATH 'CONSUMO_MES_1',
                            FECHA_CONS_MES_1    VARCHAR2(10)  PATH 'FECHA_CONS_MES_1',
                            CONSUMO_MES_2       VARCHAR2(10)  PATH 'CONSUMO_MES_2',
                            FECHA_CONS_MES_2    VARCHAR2(10)  PATH 'FECHA_CONS_MES_2',
                            CONSUMO_MES_3       VARCHAR2(10)  PATH 'CONSUMO_MES_3',
                            FECHA_CONS_MES_3    VARCHAR2(10)  PATH 'FECHA_CONS_MES_3',
                            CONSUMO_MES_4       VARCHAR2(10)  PATH 'CONSUMO_MES_4',
                            FECHA_CONS_MES_4    VARCHAR2(10)  PATH 'FECHA_CONS_MES_4',
                            CONSUMO_MES_5       VARCHAR2(10)  PATH 'CONSUMO_MES_5',
                            FECHA_CONS_MES_5    VARCHAR2(10)  PATH 'FECHA_CONS_MES_5',
                            CONSUMO_MES_6       VARCHAR2(10)  PATH 'CONSUMO_MES_6',
                            FECHA_CONS_MES_6    VARCHAR2(10)  PATH 'FECHA_CONS_MES_6',
                            CONSUMO_PROMEDIO    VARCHAR2(20)  PATH 'CONSUMO_PROMEDIO',
                            TEMPERATURA		    VARCHAR2(20)  PATH 'TEMPERATURA',
                            PRESION 		    VARCHAR2(10)  PATH 'PRESION',
                            EQUIVAL_KWH         VARCHAR2(150) PATH 'EQUIVAL_KWH',
                            CALCCONS            VARCHAR2(30)  PATH 'CALCCONS' ) As Datos;

    CURSOR cuInfoDatosRevPer(iclDatos CLOB) IS
    SELECT Datos.*
    FROM XMLTABLE ('/LDC_FACTURA/LDC_DATOS_REVISION'
                   PASSING XMLType (iclDatos)
                   COLUMNS  TIPO_NOTI	VARCHAR2(30)  PATH 'TIPO_NOTI',
                            MENS_NOTI	VARCHAR2(100) PATH 'MENS_NOTI',
                            FECH_MAXIMA	VARCHAR2(50)  PATH 'FECH_MAXIMA',
                            FECH_SUSP 	VARCHAR2(50)  PATH 'FECH_SUSP'  ) As Datos;

    CURSOR cuInfoRangos(iclDatos CLOB) IS
    SELECT Datos.*, rownum cant_reg
    FROM XMLTABLE ('/LDC_FACTURA/LDC_RANGOS'
			   PASSING XMLType (iclDatos)
			   COLUMNS  LIM_INFERIOR    	VARCHAR2(10)  PATH 'LIM_INFERIOR',
						LIM_SUPERIOR	    VARCHAR2(10)  PATH 'LIM_SUPERIOR',
						VALOR_UNIDAD		VARCHAR2(30)  PATH 'VALOR_UNIDAD',
						CONSUMO 		    VARCHAR2(20)  PATH 'CONSUMO' 	,
						VAL_CONSUMO         VARCHAR2(30)  PATH 'VAL_CONSUMO'   ) As Datos
   ;

    sbIndex  varchar2(40);


    CURSOR cuInfoCompCost(iclDatos CLOB) IS
    SELECT Datos.*
    FROM XMLTABLE ('/LDC_FACTURA/LDC_COMPCOST'
			   PASSING XMLType (iclDatos)
			   COLUMNS  COMPCOST    	VARCHAR2(60)  PATH 'COMPCOST'  ,
						VALORESREF	    VARCHAR2(60)  PATH 'VALORESREF',
						VALCALC   		VARCHAR2(60)  PATH 'VALCALC'   ) As Datos;

    CURSOR cuInfoCupon(iclDatos CLOB) IS
    SELECT Datos.*
    FROM XMLTABLE ('/LDC_FACTURA/LDC_CUPON'
			   PASSING XMLType (iclDatos)
			   COLUMNS  CODIGO_1   VARCHAR2(30)  PATH 'CODIGO_1' ,
						CODIGO_2   VARCHAR2(30)  PATH 'CODIGO_2' ,
						CODIGO_3   VARCHAR2(30)  PATH 'CODIGO_3' ,
						CODIGO_4   VARCHAR2(30)  PATH 'CODIGO_4' ,
						COD_BAR    VARCHAR2(150) PATH 'COD_BAR'    ) As Datos;

    CURSOR cuInfoDatosAdicional(iclDatos CLOB) IS
    SELECT Datos.*
    FROM XMLTABLE ('/LDC_FACTURA/DATOS_ADICIONALES'
                   PASSING XMLType (iclDatos)
                   COLUMNS  DIRECCION_PRODUCTO 	VARCHAR2(100) PATH 'DIRECCION_PRODUCTO',
                            CAUSA_DESVIACION    VARCHAR2(60)  PATH 'CAUSA_DESVIACION',
                            PAGARE_UNICO        VARCHAR2(40)  PATH 'PAGARE_UNICO',
                            CAMBIOUSO           VARCHAR2(5)   PATH 'CAMBIOUSO'    ) As Datos;

    CURSOR cuInfoAdicional(iclDatos CLOB) IS
    SELECT Datos.*
    FROM XMLTABLE ('/LDC_FACTURA/INFO_ADICIONALES'
			   PASSING XMLType (iclDatos)
			   COLUMNS  TASA_ULTIMA 	        VARCHAR2(30) PATH 'TASA_ULTIMA',
						TASA_PROMEDIO    	    VARCHAR2(30) PATH 'TASA_PROMEDIO',
						CUADRILLA_REPARTO       VARCHAR2(60) PATH 'CUADRILLA_REPARTO',
						OBSERV_NO_LECT_CONSEC   VARCHAR2(20) PATH 'OBSERV_NO_LECT_CONSEC',
						VISIBLE                 VARCHAR2(10) PATH 'VISIBLE',
						IMPRESO                 VARCHAR2(50) PATH 'IMPRESO',
						PROTECCION_ESTADO       VARCHAR2(5)  PATH 'PROTECCION_ESTADO',
						ACUMU_TATT              VARCHAR2(30) PATH 'ACUMU_TATT',
						FINAESPE                VARCHAR2(5)  PATH 'FINAESPE',
						MED_MAL_UBICADO         VARCHAR2(5)  PATH 'MED_MAL_UBICADO',
						IMPRIMEFACT             VARCHAR2(5)  PATH 'IMPRIMEFACT',
						VALOR_ULT_PAGO          VARCHAR2(30) PATH 'VALOR_ULT_PAGO',
						FECHA_ULT_PAGO          VARCHAR2(30) PATH 'FECHA_ULT_PAGO',
						SALDO_ANTE              VARCHAR2(30) PATH 'SALDO_ANTE',
                        CALIFICACION            VARCHAR2(30) PATH 'CALIFICACION') As Datos;

    CURSOR cuInfoCargos(iclDatos CLOB) IS
    SELECT Datos.*, rownum cant_reg
    FROM XMLTABLE ('/LDC_FACTURA/CARGOS_SPOOL'
			   PASSING XMLType (iclDatos)
			   COLUMNS  ETIQUETA 	VARCHAR2(10)  PATH 'ETIQUETA',
						CONCEPTO_ID VARCHAR2(30)  PATH  'CONCEPTO_ID',
                        DESC_CONCEP VARCHAR2(100) PATH 'DESC_CONCEP',
						SALDO_ANT   VARCHAR2(30)  PATH 'SALDO_ANT',
						CAPITAL     VARCHAR2(30)  PATH 'CAPITAL',
						INTERES     VARCHAR2(30)  PATH 'INTERES',
						TOTAL       VARCHAR2(30)  PATH 'TOTAL',
						SALDO_DIF   VARCHAR2(50)  PATH 'SALDO_DIF',
                        UNIDAD_ITEMS    VARCHAR2(10)  PATH 'UNIDAD_ITEMS',
                        CANTIDAD        VARCHAR2(30)  PATH 'CANTIDAD',
                        VALOR_UNITARIO  VARCHAR2(30)  PATH 'VALOR_UNITARIO',
                        VALOR_IVA       VARCHAR2(30)  PATH 'VALOR_IVA',
						CUOTAS      VARCHAR2(10)  PATH 'CUOTAS' ) As Datos;

    CURSOR cuGetCantConcepto(iclDatos CLOB) IS
    SELECT Datos.*
    FROM XMLTABLE ('/LDC_FACTURA/LDC_TOTALES'
			   PASSING XMLType (iclDatos)
               COLUMNS  TOTAL 	 VARCHAR2(50)  PATH 'TOTAL',
                        IVA 	 VARCHAR2(50)  PATH 'IVA',
                        SUBTOTAL VARCHAR2(50)  PATH 'SUBTOTAL',
                        CARGOSMES VARCHAR2(50)  PATH 'CARGOSMES',
                        CANTIDAD_CONC 	VARCHAR2(10)  PATH 'CANTIDAD_CONC') Datos;

    PROCEDURE prCloseCursor IS
     csbMT_NAME1      VARCHAR2(150) := csbSP_NAME || '.prCloseCursor';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF cuGetXmlFactura%ISOPEN THEN
           CLOSE cuGetXmlFactura;
        END IF;

        IF cuInfoDatosGen%ISOPEN THEN
           CLOSE cuInfoDatosGen;
        END IF;

        IF cuInfoDatosLectura%ISOPEN THEN
           CLOSE cuInfoDatosLectura;
        END IF;

        IF cuInfoDatosConsumo%ISOPEN THEN
           CLOSE cuInfoDatosConsumo;
        END IF;

        IF cuInfoDatosRevPer%ISOPEN THEN
           CLOSE cuInfoDatosRevPer;
        END IF;

        IF cuInfoRangos%ISOPEN THEN
           CLOSE cuInfoRangos;
        END IF;

        IF cuInfoCompCost%ISOPEN THEN
           CLOSE cuInfoCompCost;
        END IF;

        IF cuInfoCupon%ISOPEN THEN
           CLOSE cuInfoCupon;
        END IF;

        IF cuInfoDatosAdicional%ISOPEN THEN
           CLOSE cuInfoDatosAdicional;
        END IF;

        IF cuInfoAdicional%ISOPEN THEN
           CLOSE cuInfoAdicional;
        END IF;

        IF cuInfoCargos%ISOPEN THEN
           CLOSE cuInfoCargos;
        END IF;

        IF cuGetCantConcepto%ISOPEN THEN
           CLOSE cuGetCantConcepto;
        END IF;

        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;
     PROCEDURE prIniciarDatos IS
     csbMT_NAME1      VARCHAR2(150) := csbSP_NAME || '.prIniciarDatos';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        cblRango :=  EMPTY_CLOB();
        cblCargos :=  EMPTY_CLOB();
        oclSpool :=  EMPTY_CLOB();
        sbcalificacion := NULL;
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prIniciarDatos;
  BEGIN
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     pkg_traza.trace('inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
     pkg_error.prinicializaerror(onuError, osbError);
     prCloseCursor;
     prInicializarVariables;
     prIniciarDatos;
	 pkg_traza.trace('Inicia Extraccion XML ',  pkg_traza.cnuNivelTrzDef);
     OPEN cuGetXmlFactura;
     FETCH cuGetXmlFactura INTO clXmlFactura;
     IF cuGetXmlFactura%NOTFOUND THEN
        onuError := -2;
        osbError := 'Factura ['||inuFactura||'] no tiene informacion de Xml ';

		FOR reg IN 1..7 LOOP
			cblRango := cblRango||'|||||';
		END LOOP;

		FOR reg IN 1..78 LOOP
		    cblCargos := cblCargos||'||||||||||||';
		END LOOP;

     END IF;
     CLOSE cuGetXmlFactura;
	 pkg_traza.trace('Fin  Extraccion XML  ' , pkg_traza.cnuNivelTrzDef);

	 IF onuError = 0 THEN
		 pkg_traza.trace('Inicia Informacion General ' , pkg_traza.cnuNivelTrzDef);
		 OPEN cuInfoDatosGen(clXmlFactura);
		 FETCH cuInfoDatosGen INTO v_tytInfoDatosCliente;
		 CLOSE cuInfoDatosGen;
		 pkg_traza.trace('Fin Informacion General ' , pkg_traza.cnuNivelTrzDef);
		 pkg_traza.trace('Inicia Informacion Lecturas ' , pkg_traza.cnuNivelTrzDef);
		 OPEN cuInfoDatosLectura(clXmlFactura);
		 FETCH cuInfoDatosLectura INTO v_tytInfoDatosLectura;
		 CLOSE cuInfoDatosLectura;
		 pkg_traza.trace('Fin Informacion Lecturas ' , pkg_traza.cnuNivelTrzDef);
		 pkg_traza.trace('Inicia Informacion Consumo ',  pkg_traza.cnuNivelTrzDef);
		 OPEN cuInfoDatosConsumo(clXmlFactura);
		 FETCH cuInfoDatosConsumo INTO v_tytInfoDatosConsumo;
		 CLOSE cuInfoDatosConsumo;
		 pkg_traza.trace('Fin Informacion Consumo ' , pkg_traza.cnuNivelTrzDef);
		 pkg_traza.trace('Inicia Informacion RevPer ' , pkg_traza.cnuNivelTrzDef);
		 OPEN cuInfoDatosRevPer(clXmlFactura);
		 FETCH cuInfoDatosRevPer INTO v_tytInfoDatosRevPer;
		 CLOSE cuInfoDatosRevPer;
		 pkg_traza.trace('Fin Informacion RevPer ' , pkg_traza.cnuNivelTrzDef);
		 pkg_traza.trace('Inicia Informacion Rango ' , pkg_traza.cnuNivelTrzDef);
		 FOR reg IN cuInfoRangos(clXmlFactura) LOOP
			sbIndex  := inuFactura||reg.cant_reg;
			V_tbltytInfoRangos(sbIndex).LIM_INFERIOR	:= reg.LIM_INFERIOR	;
			V_tbltytInfoRangos(sbIndex).LIM_SUPERIOR := reg.LIM_SUPERIOR;
			V_tbltytInfoRangos(sbIndex).VALOR_UNIDAD := reg.VALOR_UNIDAD;
			V_tbltytInfoRangos(sbIndex).CONSUMO 		:= reg.CONSUMO;
			V_tbltytInfoRangos(sbIndex).VAL_CONSUMO  := reg.VAL_CONSUMO;
			cblRango := cblRango||
						reg.LIM_INFERIOR    ||'|'||
						reg.LIM_SUPERIOR	 ||'|'||
						reg.VALOR_UNIDAD	 ||'|'||
						reg.CONSUMO 		 ||'|'||
						reg.VAL_CONSUMO      ||'|';
		 END LOOP;
		 pkg_traza.trace('Fin Informacion Rango ' , pkg_traza.cnuNivelTrzDef);
		 pkg_traza.trace('Inicia Informacion CompCost ',  pkg_traza.cnuNivelTrzDef);
		 OPEN cuInfoCompCost(clXmlFactura);
		 FETCH cuInfoCompCost INTO v_tytInfoCompCost;
		 CLOSE cuInfoCompCost;
		 pkg_traza.trace('Fin Informacion CompCost ' , pkg_traza.cnuNivelTrzDef);
		 pkg_traza.trace('Inicia Informacion Cupon ' , pkg_traza.cnuNivelTrzDef);
		 OPEN cuInfoCupon(clXmlFactura);
		 FETCH cuInfoCupon INTO v_tytInfoCupon;
		 CLOSE cuInfoCupon;
		 pkg_traza.trace('Fin Informacion Cupon ' , pkg_traza.cnuNivelTrzDef);
		 pkg_traza.trace('Inicia Informacion Adicional ',  pkg_traza.cnuNivelTrzDef);
		 OPEN cuInfoDatosAdicional(clXmlFactura);
		 FETCH cuInfoDatosAdicional INTO v_tytInfoDatosAdicional;
		 CLOSE cuInfoDatosAdicional;

		 OPEN cuInfoAdicional(clXmlFactura);
		 FETCH cuInfoAdicional INTO v_tytInfoAdicional;
		 CLOSE cuInfoAdicional;
		 pkg_traza.trace('Fin Informacion Adicional ',  pkg_traza.cnuNivelTrzDef);
		 pkg_traza.trace('Inicia Informacion Cargos ' , pkg_traza.cnuNivelTrzDef);
		 FOR reg IN cuInfoCargos(clXmlFactura) LOOP
			IF reg.ETIQUETA IS NOT NULL  THEN
				 nuContador := nuContador  + 1;
				sbIndex  := inuFactura||LPAD(nuContador,2, '00');
				v_tbltytInfoCargos(sbIndex).ETIQUETA	:= reg.ETIQUETA;
				v_tbltytInfoCargos(sbIndex).CONCEPTO_ID := reg.CONCEPTO_ID;
				v_tbltytInfoCargos(sbIndex).DESC_CONCEP := reg.DESC_CONCEP;
				v_tbltytInfoCargos(sbIndex).SALDO_ANT	:= reg.SALDO_ANT;
				v_tbltytInfoCargos(sbIndex).CAPITAL		:= reg.CAPITAL;
				v_tbltytInfoCargos(sbIndex).INTERES		:= reg.INTERES;
				v_tbltytInfoCargos(sbIndex).TOTAL		:= reg.TOTAL;
				v_tbltytInfoCargos(sbIndex).SALDO_DIF	:= reg.SALDO_DIF;
				v_tbltytInfoCargos(sbIndex).UNIDAD_ITEMS	:= reg.UNIDAD_ITEMS;
				v_tbltytInfoCargos(sbIndex).CANTIDAD	:= reg.CANTIDAD;
				v_tbltytInfoCargos(sbIndex).VALOR_UNITARIO	:= reg.VALOR_UNITARIO;
				v_tbltytInfoCargos(sbIndex).VALOR_IVA	:= reg.VALOR_IVA;
				v_tbltytInfoCargos(sbIndex).CUOTAS		:= reg.CUOTAS;
				v_tbltytInfoCargos(sbIndex).ORDENAMIENTO := reg.cant_reg;

			END IF;
			pkg_traza.trace('Fin Informacion Cargos ' , pkg_traza.cnuNivelTrzDef);

			cblCargos := cblCargos||reg.CONCEPTO_ID   ||'|'||
							reg.DESC_CONCEP   ||'|'||
							reg.SALDO_ANT     ||'|'||
							reg.CAPITAL       ||'|'||
							reg.INTERES       ||'|'||
							reg.TOTAL         ||'|'||
							reg.SALDO_DIF     ||'|'||
							reg.UNIDAD_ITEMS  ||'|'||
							reg.CANTIDAD      ||'|'||
							reg.VALOR_UNITARIO||'|'||
							reg.VALOR_IVA     ||'|'||
							reg.CUOTAS        ||'|';

		 END LOOP;

		 OPEN cuGetCantConcepto(clXmlFactura);
		 FETCH cuGetCantConcepto INTO v_tytInfoTotales;
		 CLOSE cuGetCantConcepto;
     END IF;
     gnuCantConc := v_tytInfoTotales.CANTIDAD_CONC;
     sbcalificacion := ldc_pkgprocefactspoolfac.fnuGetCaliConsumo(inuFactura);

    oclSpool := 1||'|'||
        v_tytInfoDatosCliente.FACTURA				||'|'||
        v_tytInfoDatosCliente.FECH_FACT			||'|'||
        v_tytInfoDatosCliente.MES_FACT			||'|'||
        v_tytInfoDatosCliente.PERIODO_FACT		||'|'||
        v_tytInfoDatosCliente.PAGO_HASTA			||'|'||
        v_tytInfoDatosCliente.DIAS_CONSUMO		||'|'||
        v_tytInfoDatosCliente.CONTRATO			||'|'||
        v_tytInfoDatosCliente.CUPON				||'|'||
        v_tytInfoDatosCliente.NOMBRE				||'|'||
        v_tytInfoDatosCliente.DIRECCION_COBRO		||'|'||
        v_tytInfoDatosCliente.LOCALIDAD			||'|'||
        v_tytInfoDatosCliente.CATEGORIA			||'|'||
        v_tytInfoDatosCliente.ESTRATO				||'|'||
        v_tytInfoDatosCliente.CICLO				||'|'||
        v_tytInfoDatosCliente.RUTA				||'|'||
        v_tytInfoDatosCliente.MESES_DEUDA			||'|'||
        v_tytInfoDatosCliente.NUM_CONTROL			||'|'||
        v_tytInfoDatosCliente.PERIODO_CONSUMO		||'|'||
        v_tytInfoDatosCliente.SALDO_FAVOR			||'|'||
        v_tytInfoDatosCliente.SALDO_ANT     ||'|'||
        v_tytInfoDatosCliente.FECHA_SUSPENSION	||'|'||
        v_tytInfoDatosCliente.VALOR_RECL		 	||'|'||
        v_tytInfoDatosCliente.TOTAL_FACTURA		||'|'||
        v_tytInfoDatosCliente.PAGO_SIN_RECARGO	||'|'||
        v_tytInfoDatosCliente.CONDICION_PAGO      ||'|'||
        v_tytInfoDatosCliente.IDENTIFICA          ||'|'||
        v_tytInfoDatosCliente.SERVICIO            ||'|'||
        v_tytInfoAdicional.OBSERV_NO_LECT_CONSEC ||'|'||
        v_tytInfoAdicional.CUADRILLA_REPARTO   ||'|'||
        v_tytInfoDatosCliente.CUPO_BRILLA	        ||'|'||
        v_tytInfoDatosLectura.NUM_MEDIDOR		||'|'||
        v_tytInfoDatosLectura.LECTURA_ANTERIOR||'|'||
        v_tytInfoDatosLectura.LECTURA_ACTUAL	||'|'||
        v_tytInfoDatosLectura.OBS_LECTURA     ||'|'||
        v_tytInfoDatosConsumo.CONS_CORREG			||'|'||
        v_tytInfoDatosConsumo.FACTOR_CORRECCION	||'|'||
        v_tytInfoDatosConsumo.CONSUMO_MES_1       ||'|'||
        v_tytInfoDatosConsumo.FECHA_CONS_MES_1    ||'|'||
        v_tytInfoDatosConsumo.CONSUMO_MES_2       ||'|'||
        v_tytInfoDatosConsumo.FECHA_CONS_MES_2    ||'|'||
        v_tytInfoDatosConsumo.CONSUMO_MES_3       ||'|'||
        v_tytInfoDatosConsumo.FECHA_CONS_MES_3    ||'|'||
        v_tytInfoDatosConsumo.CONSUMO_MES_4       ||'|'||
        v_tytInfoDatosConsumo.FECHA_CONS_MES_4    ||'|'||
        v_tytInfoDatosConsumo.CONSUMO_MES_5       ||'|'||
        v_tytInfoDatosConsumo.FECHA_CONS_MES_5    ||'|'||
        v_tytInfoDatosConsumo.CONSUMO_MES_6       ||'|'||
        v_tytInfoDatosConsumo.FECHA_CONS_MES_6    ||'|'||
        v_tytInfoDatosConsumo.CONSUMO_PROMEDIO    ||'|'||
        v_tytInfoDatosConsumo.TEMPERATURA		    ||'|'||
        v_tytInfoDatosConsumo.PRESION 		    ||'|'||
        v_tytInfoDatosConsumo.EQUIVAL_KWH         ||'|'||
        v_tytInfoDatosConsumo.CALCCONS            ||'|'||
        v_tytInfoDatosRevPer.TIPO_NOTI	||'|'||
        v_tytInfoDatosRevPer.MENS_NOTI	||'|'||
        v_tytInfoDatosRevPer.FECH_MAXIMA	||'|'||
        v_tytInfoDatosRevPer.FECH_SUSP   ||'|'||
        cblRango||
        v_tytInfoCompCost.COMPCOST  ||'|'||
        v_tytInfoCompCost.VALORESREF||'|'||
        v_tytInfoCompCost.VALCALC   ||'|'||
        v_tytInfoCupon.CODIGO_1 ||'|'||
        v_tytInfoCupon.CODIGO_2 ||'|'||
        v_tytInfoCupon.CODIGO_3 ||'|'||
        v_tytInfoCupon.CODIGO_4 ||'|'||
        v_tytInfoCupon.COD_BAR  ||'|'||
        v_tytInfoAdicional.TASA_ULTIMA 	      ||'|'||
        v_tytInfoAdicional.TASA_PROMEDIO    	  ||'|'||
        v_tytInfoAdicional.VISIBLE               ||'|'||
        v_tytInfoAdicional.IMPRESO               ||'|'||
        v_tytInfoAdicional.PROTECCION_ESTADO     ||'|'||
        v_tytInfoDatosAdicional.DIRECCION_PRODUCTO ||'|'||
        v_tytInfoDatosAdicional.CAUSA_DESVIACION   ||'|'||
        v_tytInfoDatosAdicional.PAGARE_UNICO       ||'|'||
        v_tytInfoDatosAdicional.CAMBIOUSO          ||'|'||
        v_tytInfoAdicional.ACUMU_TATT            ||'|'||
        v_tytInfoAdicional.FINAESPE              ||'|'||
        v_tytInfoAdicional.MED_MAL_UBICADO       ||'|'||
        v_tytInfoAdicional.IMPRIMEFACT           ||'|'||
        v_tytInfoAdicional.VALOR_ULT_PAGO        ||'|'||
        v_tytInfoAdicional.FECHA_ULT_PAGO        ||'|'||
        v_tytInfoTotales.TOTAL 	       ||'|'||
        v_tytInfoTotales.IVA    	       ||'|'||
        v_tytInfoTotales.SUBTOTAL       ||'|'||
        v_tytInfoTotales.CARGOSMES      ||'|'||
        v_tytInfoTotales.CANTIDAD_CONC  ||'|'||
        v_tytInfoAdicional.SALDO_ANTE   ||'|'||
        cblCargos||sbcalificacion;

     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(onuError,osbError);
      prCloseCursor;
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(onuError,osbError);
       prCloseCursor;
       pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);

  END prMapearDatosFactura;


  FUNCTION fsbGetAmbiente RETURN VARCHAR2 IS
     csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fsbGetAmbiente';
     sbAmbiente VARCHAR2(1);
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    sbAmbiente := CASE  WHEN ldc_boconsgenerales.fsbgetdatabasedesc() IS NULL THEN
                    '1'
                    ELSE
                         '2'
                    END;
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
     RETURN sbAmbiente;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(nuError,sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RETURN sbAmbiente;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RETURN sbAmbiente;
  END fsbGetAmbiente;

  PROCEDURE prGetInfoValoraReportarVentas ( inuFactura      IN NUMBER,
                                            oblFacturaVenta OUT BOOLEAN,
                                            onuError        OUT NUMBER,
                                            osbError        OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoValoraReportarVentas
    Descripcion     : Proceso obtiene informacion de valores a reportar en la facturacion de ventas
                      electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 05-02-2024

    Parametros de Entrada
      inuFactura   codigo de la factura
    Parametros de Salida
      onuError             codigo del error
      osbError             mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       18-10-2024   OSF-3493    se cloca filtro de cargtipr = 'A' para cargos con condiciones especiales
    LJLB        05-02-2024   OSF-2158    Creacion
  ***************************************************************************/
     csbMT_NAME      VARCHAR2(100)  := csbSP_NAME || '.prGetInfoValoraReportarVentas';


     nuContador      NUMBER         := 0;
     nuContadorAju   NUMBER         := 0;
     sbIndex         VARCHAR2(40);
     sbIndexImp      VARCHAR2(40);
     sbExiste        VARCHAR2(1);
     sbConcImpuesto  VARCHAR2(4000);
     nuIngrImpues    NUMBER;
     sbDescBasImp    VARCHAR2(400);
     nuConcBasImp    NUMBER;
     nuValorBase     NUMBER(25,2);
     nuPorcentaje    NUMBER;
     nuImpuesto      NUMBER(25,2);
     blIsConceptoAiu BOOLEAN :=  FALSE;
	 sbUnidMed       conc_unid_medida_dian.unidad_medida%TYPE;
	 nuCantidad      NUMBER;
	 nuValorUnitario  NUMBER(25,2);
	 nuCantBase     NUMBER;
	 nuValorUniBase NUMBER(25,2);

     --consulta valor de ingresos
     CURSOR cuGetIngresos IS
     SELECT  SUM(cargos.cargvalo * decode(cargos.cargsign,'CR', -1,1)) ingreso,
			cargos.cargconc,
			concepto.concdesc,
			sum(nvl(cargos.cargunid,1)) cantidad,
			sum(round(decode( nvl(cargos.cargunid,1),  0, 0, cargos.cargvalo / cargos.cargunid), 0)* decode(cargos.cargsign,'CR', -1,1) ) valorunitario
     FROM cargos, cuencobr, concepto, servsusc
     WHERE cargos.cargcuco = cucocodi
      AND cuencobr.cucofact = inuFactura
      AND cargos.cargsign IN ('DB','CR')
      AND servsusc.sesunuse = cuencobr.cuconuse
      AND servsusc.sesuserv NOT IN ( SELECT to_number(regexp_substr(csbTipoProdExcluir,  '[^,]+',   1, LEVEL)) AS TIPOPROD
                                      FROM dual
                                      CONNECT BY regexp_substr(csbTipoProdExcluir, '[^,]+', 1, LEVEL) IS NOT NULL )
	  AND ((cargos.cargcaca IN ( SELECT to_number(regexp_substr(pkg_bcfactuelectronicagen.sbCausalesIngVenta,  '[^,]+',   1, LEVEL)) AS causales
													  FROM dual
													  CONNECT BY regexp_substr(pkg_bcfactuelectronicagen.sbCausalesIngVenta, '[^,]+', 1, LEVEL) IS NOT NULL )
									AND SUBSTR(cargos.cargdoso,1,3) IN ( SELECT (regexp_substr(pkg_bcfactuelectronicagen.sbDocumeSoporte,  '[^,]+',   1, LEVEL)) AS DOCU
																		   FROM dual
																		   CONNECT BY regexp_substr(pkg_bcfactuelectronicagen.sbDocumeSoporte, '[^,]+', 1, LEVEL) IS NOT NULL  )
									)
									OR   (cargos.cargconc||';'||cargos.cargcaca||';'||cargos.cargprog IN (  SELECT (regexp_substr(pkg_bcfactuelectronicagen.sbCondicionesEspeVenta,  '[^|]+',   1, LEVEL)) AS datos
																											FROM dual
																											CONNECT BY regexp_substr(pkg_bcfactuelectronicagen.sbCondicionesEspeVenta, '[^|]+', 1, LEVEL) IS NOT NULL
																											)
										    AND cargos.cargtipr = 'A'))
	  AND cargos.cargconc NOT IN ( SELECT concbali.coblcoba
                                    FROM concbali
                                    WHERE concbali.coblconc in ( SELECT to_number(regexp_substr(sbConcImpuesto,  '[^,]+',   1, LEVEL)) AS concepto
                                                                 FROM dual
                                                                 CONNECT BY regexp_substr(sbConcImpuesto, '[^,]+', 1, LEVEL) IS NOT NULL) )
      AND cargos.cargconc NOT IN (  SELECT to_number(regexp_substr(sbConcExcluir,  '[^,]+',   1, LEVEL)) AS concepto
										FROM dual
									    CONNECT BY regexp_substr(sbConcExcluir, '[^,]+', 1, LEVEL) IS NOT NULL)
	  AND concepto.concticl <> 4
      AND cargos.cargconc = conccodi
      AND cargos.cargconc NOT IN ( SELECT cc_prom_detail.concept_id
									FROM cc_promotion, cc_prom_detail
									WHERE cc_promotion.promotion_id = cc_prom_detail.promotion_id
										AND cc_promotion.final_offer_date>sysdate)
     GROUP BY cargos.cargconc, concepto.concdesc
     ORDER BY cargos.cargconc;


    --se consultan ingresos base de los impuesto
    CURSOR cuGetIngrImpuesto(inuConcImp NUMBER) IS
    WITH IngreImp AS (
    SELECT cargos.cargvalo * decode(cargos.cargsign,'CR', -1,1) ingreso,
            cargos.cargconc,
            concepto.concdesc,
			nvl(cargos.cargunid,1) cantidad,
			round(decode( nvl(cargos.cargunid,1),  0, 0, cargos.cargvalo / cargos.cargunid), 0) * decode(cargos.cargsign,'CR', -1,1) valorunitario,
            rownum id_reg
    FROM cargos, cuencobr, concepto, servsusc
    WHERE cargos.cargcuco = cucocodi
     AND cuencobr.cucofact = inuFactura
     AND cargos.cargsign IN ('DB','CR')
     AND servsusc.sesunuse = cuencobr.cuconuse
	 AND cargos.cargconc NOT IN (  SELECT to_number(regexp_substr(sbConcExcluir,  '[^,]+',   1, LEVEL)) AS concepto
									FROM dual
									CONNECT BY regexp_substr(sbConcExcluir, '[^,]+', 1, LEVEL) IS NOT NULL)
     AND servsusc.sesuserv NOT IN ( SELECT to_number(regexp_substr(csbTipoProdExcluir,  '[^,]+',   1, LEVEL)) AS TIPOPROD
                                      FROM dual
                                      CONNECT BY regexp_substr(csbTipoProdExcluir, '[^,]+', 1, LEVEL) IS NOT NULL )

     AND ((cargos.cargcaca IN ( SELECT to_number(regexp_substr(pkg_bcfactuelectronicagen.sbCausalesIngVenta,  '[^,]+',   1, LEVEL)) AS causales
												  FROM dual
												  CONNECT BY regexp_substr(pkg_bcfactuelectronicagen.sbCausalesIngVenta, '[^,]+', 1, LEVEL) IS NOT NULL )
								AND SUBSTR(cargos.cargdoso,1,3) IN ( SELECT (regexp_substr(pkg_bcfactuelectronicagen.sbDocumeSoporte,  '[^,]+',   1, LEVEL)) AS DOCU
																	   FROM dual
																	   CONNECT BY regexp_substr(pkg_bcfactuelectronicagen.sbDocumeSoporte, '[^,]+', 1, LEVEL) IS NOT NULL  )
								)
								OR   (cargos.cargconc||';'||cargos.cargcaca||';'||cargos.cargprog IN (  SELECT (regexp_substr(pkg_bcfactuelectronicagen.sbCondicionesEspeVenta,  '[^|]+',   1, LEVEL)) AS datos
																										FROM dual
																										CONNECT BY regexp_substr(pkg_bcfactuelectronicagen.sbCondicionesEspeVenta, '[^|]+', 1, LEVEL) IS NOT NULL
																										)
									AND cargos.cargtipr = 'A'))
     AND cargos.cargconc = conccodi
     AND cargos.cargconc NOT IN ( SELECT cc_prom_detail.CONCEPT_ID
								  FROM cc_promotion, cc_prom_detail
								  WHERE cc_promotion.promotion_id = cc_prom_detail.promotion_id
									AND cc_promotion.final_offer_date > sysdate)
     AND cargos.cargconc in ( SELECT concbali.coblcoba
                              FROM concbali
                              WHERE concbali.coblconc = inuConcImp)
    ORDER BY cargos.cargconc),
    totalingimpuesto AS (
                SELECT ingreso ,
                       CASE WHEN id_reg = 1 THEN cargconc
                            ELSE (SELECT cargconc FROM ingreimp WHERE id_reg = 1)
                       END cargconc,
                       CASE WHEN id_reg = 1 THEN concdesc
                            ELSE (SELECT concdesc FROM ingreimp WHERE id_reg = 1)
                       END concdesc,
                       cantidad,
                       valorunitario
                FROM ingreimp)
    SELECT SUM(ingreso) ingreso,
           cargconc,
           concdesc,
		   SUM(cantidad) cantidad,
		   SUM(valorunitario) valorunitario
    FROM totalingimpuesto
    GROUP BY cargconc, concdesc;

   CURSOR cuGetValorDesc(inuConcepto NUMBER) IS
   WITH ConceDesc AS
      ( SELECT cl.coblconc concimpu, cl.coblcoba concbase
		FROM cc_promotion, cc_prom_detail,  concbali cl, concbali cl2
		WHERE cc_promotion.promotion_id = cc_prom_detail.promotion_id
			AND final_offer_date > sysdate
			AND cl.coblcoba = cc_prom_detail.concept_id
			AND cl2.coblconc = cc_prom_detail.concept_id
			AND cl2.coblcoba = inuConcepto ),
      ConcLiqui AS (
        SELECT CASE WHEN concepto.CONCTICL = 4 THEN
                        cargos.cargvalo * decode(cargos.cargsign,'CR', -1,1)
                     ELSE 0
                END conce_iva,
                 CASE WHEN concepto.CONCTICL = 4  THEN
                        cargos.cargvabl * decode(cargos.cargsign,'CR', -1,1)
                     ELSE 0
                END base_iva,
                CASE WHEN concepto.CONCTICL <> 4  THEN
                        cargos.cargvalo * decode(cargos.cargsign,'CR', -1,1)
                     ELSE 0
                END conce_base
        FROM cargos, cuencobr, servsusc, concepto
        WHERE cuencobr.cucofact = inuFactura
          AND servsusc.sesunuse = cuencobr.cuconuse
		  AND concepto.conccodi = cargos.cargconc
          AND cargos.cargsign IN ('DB','CR')
          AND (cargos.cargconc in (select concbase from ConceDesc)
             OR cargos.cargconc in (select concimpu from ConceDesc))
		  AND ((cargos.cargcaca IN ( SELECT to_number(regexp_substr(pkg_bcfactuelectronicagen.sbCausalesIngVenta,  '[^,]+',   1, LEVEL)) AS causales
													  FROM dual
													  CONNECT BY regexp_substr(pkg_bcfactuelectronicagen.sbCausalesIngVenta, '[^,]+', 1, LEVEL) IS NOT NULL )
									AND SUBSTR(cargos.cargdoso,1,3) IN ( SELECT (regexp_substr(pkg_bcfactuelectronicagen.sbDocumeSoporte,  '[^,]+',   1, LEVEL)) AS DOCU
																		   FROM dual
																		   CONNECT BY regexp_substr(pkg_bcfactuelectronicagen.sbDocumeSoporte, '[^,]+', 1, LEVEL) IS NOT NULL  )
									)
									OR   (cargos.cargconc||';'||cargos.cargcaca||';'||cargos.cargprog IN (  SELECT (regexp_substr(pkg_bcfactuelectronicagen.sbCondicionesEspeVenta,  '[^|]+',   1, LEVEL)) AS datos
																											FROM dual
																											CONNECT BY regexp_substr(pkg_bcfactuelectronicagen.sbCondicionesEspeVenta, '[^|]+', 1, LEVEL) IS NOT NULL
																											)
										AND cargos.cargtipr = 'A'))

		  AND servsusc.sesuserv NOT IN ( SELECT to_number(regexp_substr(csbTipoProdExcluir,  '[^,]+',   1, LEVEL)) AS TIPOPROD
                                          FROM dual
                                          CONNECT BY regexp_substr(csbTipoProdExcluir, '[^,]+', 1, LEVEL) IS NOT NULL )
          AND cuencobr.cucocodi = cargos.cargcuco  )
    SELECT nvl(sum(CONCE_IVA),0) conce_iva ,
           nvl(sum(base_iva),0) base_iva ,
           nvl(sum(CONCE_BASE),0) conce_base
    FROM ConcLiqui;

    nuValorIva NUMBER;
    nuValorBaseImp NUMBER;
    nuValorBasIva NUMBER;

    --se consulta impuestos
    CURSOR cuGetImpuesto IS
    WITH impuestos AS (
    SELECT  cargos.cargvalo * decode(cargos.cargsign,'CR', -1,1) valor,
            cargos.cargconc,
            concepto.concdesc,
            cargos.cargvabl * decode(cargos.cargsign,'CR', -1,1) cargvabl,
            cargos.cargtaco,
            cargos.cargfecr
    FROM cargos, cuencobr, concepto, servsusc
    WHERE cargos.cargcuco = cucocodi
      AND cuencobr.cucofact = inuFactura
      AND cargos.cargsign IN ('DB','CR')
      AND servsusc.sesunuse = cuencobr.cuconuse
	  AND cargos.cargconc NOT IN (  SELECT to_number(regexp_substr(sbConcExcluir,  '[^,]+',   1, LEVEL)) AS concepto
										FROM dual
									    CONNECT BY regexp_substr(sbConcExcluir, '[^,]+', 1, LEVEL) IS NOT NULL)
      AND servsusc.sesuserv NOT IN ( SELECT to_number(regexp_substr(csbTipoProdExcluir,  '[^,]+',   1, LEVEL)) AS TIPOPROD
                                     FROM dual
                                     CONNECT BY regexp_substr(csbTipoProdExcluir, '[^,]+', 1, LEVEL) IS NOT NULL )
      AND ((cargos.cargcaca IN ( SELECT to_number(regexp_substr(pkg_bcfactuelectronicagen.sbCausalesIngVenta,  '[^,]+',   1, LEVEL)) AS causales
													  FROM dual
													  CONNECT BY regexp_substr(pkg_bcfactuelectronicagen.sbCausalesIngVenta, '[^,]+', 1, LEVEL) IS NOT NULL )
									AND SUBSTR(cargos.cargdoso,1,3) IN ( SELECT (regexp_substr(pkg_bcfactuelectronicagen.sbDocumeSoporte,  '[^,]+',   1, LEVEL)) AS DOCU
																		   FROM dual
																		   CONNECT BY regexp_substr(pkg_bcfactuelectronicagen.sbDocumeSoporte, '[^,]+', 1, LEVEL) IS NOT NULL  )
									)
									OR   (cargos.cargconc||';'||cargos.cargcaca||';'||cargos.cargprog IN (  SELECT (regexp_substr(pkg_bcfactuelectronicagen.sbCondicionesEspeVenta,  '[^|]+',   1, LEVEL)) AS datos
																											FROM dual
																											CONNECT BY regexp_substr(pkg_bcfactuelectronicagen.sbCondicionesEspeVenta, '[^|]+', 1, LEVEL) IS NOT NULL
																											)
										AND cargos.cargtipr = 'A'))
     AND concepto.concticl = 4
     AND cargos.cargconc NOT IN (   SELECT concbali.coblconc
									FROM cc_promotion, cc_prom_detail, concbali
									WHERE cc_promotion.promotion_id = cc_prom_detail.promotion_id
									    AND concbali.coblcoba = cc_prom_detail.concept_id
										AND cc_promotion.final_offer_date > sysdate)

      AND cargos.cargconc = conccodi),
    tarifaimpuesto AS (
         SELECT impuestos.*,
                 ( SELECT ravtporc
                    FROM  ta_vigetaco,  ta_rangvitc
                  WHERE ta_vigetaco.vitctaco = cargtaco
                      AND ta_rangvitc.ravtvitc = ta_vigetaco.vitccons
                      AND cargfecr BETWEEN ta_vigetaco.vitcfein AND ta_vigetaco.vitcfefi) tarifa
          FROM impuestos
     ) , TotalImpuesto AS (
     SELECT SUM(valor) valor,
            SUM(cargvabl)  valor_base,
            cargconc,
            tarifa
     FROM tarifaimpuesto
     GROUP BY tarifa,cargconc)
   SELECT valor,
        valor_base,
        round(valor_base * ( tarifa /100),2) impuesto_calc,
        cargconc,
        tarifa
   FROM TotalImpuesto;

   PROCEDURE prCloseCursor IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prCloseCursor';
   BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF cuGetIngresos%ISOPEN THEN
           CLOSE cuGetIngresos;
        END IF;

        IF cuGetImpuesto%ISOPEN THEN
           CLOSE cuGetImpuesto;
        END IF;

        IF cuGetIngrImpuesto%ISOPEN THEN
           CLOSE cuGetIngrImpuesto;
        END IF;

        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;

    PROCEDURE prInicializaDatos IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prInicializaDatos';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        v_tbltytInfoIngresos.DELETE;
        v_tbltytInfoImpuesto.DELETE;
        v_tbltytInfoAjustes.DELETE;
        pkg_error.prinicializaerror(onuError, osbError);
        sbIndex := NULL;
        sbExiste := NULL;
        sbConcImpuesto  := null;
        nuIngrImpues := NULL;
        sbDescBasImp := NULL;
        nuConcBasImp := NULL;
        gnuValorTotalIva := 0;
        nuValorIva := 0;
        nuValorBaseImp := 0;
        gnuValorBaseTotal := 0;
        gsbTipoDocuAiu := 'N';
        gsbConceptosAiu := null;
        gnuValorIngreso := 0;
        gnuValorDescGen := 0;
        nuValorBasIva := 0;
		sbUnidMed := NULL;
		nuValorUnitario := 0;
		nuCantBase := 0;
		nuValorUniBase := 0;
		nuCantidad := 0;
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializaDatos;
  BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      pkg_traza.trace(' inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
      prCloseCursor;
      prInicializaDatos;
      pkg_error.prinicializaerror(onuError, osbError);
      oblFacturaVenta := false;
      pkg_traza.trace(' Inicia Impuestos ' , pkg_traza.cnuNivelTrzDef);
      FOR reg IN cuGetImpuesto LOOP
          nuIngrImpues := NULL;
          sbDescBasImp := NULL;
          nuConcBasImp := NULL;
          nuValorIva := 0;
          nuValorBaseImp := 0;
          nuValorBasIva := 0;
          nuValorBase  := reg.valor_base;
          nuPorcentaje := reg.tarifa;
          nuImpuesto   := reg.valor;
          blIsConceptoAiu :=  FALSE;
          nuContador := nuContador  + 1;
          sbIndexImp := inuFactura||nuContador;
          pkg_traza.trace(' sbIndexImp => ' ||sbIndexImp, pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace(' reg.cargconc => ' ||reg.cargconc, pkg_traza.cnuNivelTrzDef);

          IF nuContador = 1 THEN
             sbConcImpuesto := reg.cargconc;
          ELSE
            sbConcImpuesto := sbConcImpuesto||','||reg.cargconc;
          END IF;

          IF cuGetIngrImpuesto%ISOPEN THEN
             CLOSE cuGetIngrImpuesto;
          END IF;
           pkg_traza.trace(' nuValorBase Antes => ' ||nuValorBase, pkg_traza.cnuNivelTrzDef);
          --se consulta concepto base que liquido el impuesto
          OPEN cuGetIngrImpuesto(reg.cargconc);
          FETCH cuGetIngrImpuesto INTO nuIngrImpues, nuConcBasImp, sbDescBasImp, nuCantBase, nuValorUniBase ;
          IF cuGetIngrImpuesto%FOUND THEN

              IF cuGetValorDesc%ISOPEN THEN CLOSE cuGetValorDesc; END IF;

              OPEN cuGetValorDesc(nuConcBasImp);
              FETCH cuGetValorDesc INTO nuValorIva, nuValorBasIva, nuValorBaseImp;
              CLOSE cuGetValorDesc;
              pkg_traza.trace(' nuValorIva => ' ||nuValorIva, pkg_traza.cnuNivelTrzDef);
              pkg_traza.trace(' nuValorBaseImp => ' ||nuValorBaseImp, pkg_traza.cnuNivelTrzDef);
              pkg_traza.trace(' nuConcBasImp => ' ||nuConcBasImp, pkg_traza.cnuNivelTrzDef);
              pkg_traza.trace(' nuIngrImpues => ' ||nuIngrImpues, pkg_traza.cnuNivelTrzDef);
              pkg_traza.trace(' nuValorBasIva => ' ||nuValorBasIva, pkg_traza.cnuNivelTrzDef);

			  -- Inicia la unidad de medida por defecto en 94
			  sbUnidMed := csbUnidadOtros;
			  nuValorUnitario := nuIngrImpues + nuValorBaseImp;
			  nuCantidad  :=  1;

			 -- Valida si existe la unidad de medida del concepto en la tabla conc_unid_medida_dian
			  IF tbUnidadMedConc.EXISTS(nuConcBasImp) then
				  sbUnidMed := tbUnidadMedConc(nuConcBasImp).sbUnidadMed;
				  IF tbUnidadMedConc(nuConcBasImp).sbRequiereTarifa = 'S' THEN
					  nuValorUnitario := nuValorUniBase + nuValorBaseImp;
					  nuCantidad := nuCantBase;
				  END IF;
			  END IF;

              sbIndex := inuFactura||LPAD(nuContador, 2, '00');
              v_tbltytInfoIngresos(sbIndex).nuIngreso       := nuIngrImpues + nuValorBaseImp;
              v_tbltytInfoIngresos(sbIndex).nuValorUnitario := nuValorUnitario;
              v_tbltytInfoIngresos(sbIndex).nuConcepto      := nuConcBasImp;
              v_tbltytInfoIngresos(sbIndex).sbDescConce     := sbDescBasImp;
			  v_tbltytInfoIngresos(sbIndex).nuCantidad      := nuCantidad;
			  v_tbltytInfoIngresos(sbIndex).sbUnidadMedida  := sbUnidMed;

              nuValorBase := nuValorBase +  nuValorBaseImp;

          ELSE
		      pkg_error.setErrorMessage(isbMsgErrr => 'No existe concepto base del impuesto => '||reg.cargconc);
		  END IF;
          CLOSE cuGetIngrImpuesto;

           pkg_traza.trace(' nuValorBase Despues => ' ||nuValorBase, pkg_traza.cnuNivelTrzDef);
           pkg_traza.trace(' reg.tarifa => ' ||reg.tarifa, pkg_traza.cnuNivelTrzDef);
           IF reg.tarifa <> nuPorcIva THEN
             gsbTipoDocuAiu := 'S';
             nuValorBase  := ROUND((nuPorcentaje / nuPorcIva ) * nuValorBase, 0);
             nuPorcentaje := nuPorcIva;
             blIsConceptoAiu := TRUE;
          END IF;
		  pkg_traza.trace(' nuValorIva => ' ||nuValorIva, pkg_traza.cnuNivelTrzDef);
          v_tbltytInfoImpuesto(sbIndexImp).nuValor := reg.valor + nuValorIva;
          v_tbltytInfoImpuesto(sbIndexImp).nuValorBase  := abs(nuValorBase);
          v_tbltytInfoImpuesto(sbIndexImp).nuTarifa   := nuPorcentaje;
          v_tbltytInfoImpuesto(sbIndexImp).nuImpuesto := nuImpuesto + nuValorIva;

          v_tbltytInfoIngresos(sbIndex).InfoImpuesto    := v_tbltytInfoImpuesto(sbIndexImp);
		  v_tbltytInfoIngresos(sbIndex).nuValorIva := reg.valor + nuValorIva;
          gnuValorIngreso := gnuValorIngreso + nuIngrImpues + nuValorBaseImp;
          IF blIsConceptoAiu THEN
              IF gsbConceptosAiu IS NULL THEN
                 gsbConceptosAiu  := nuConcBasImp;
              ELSE
                gsbConceptosAiu  := gsbConceptosAiu||','||nuConcBasImp;
              END IF;
          END IF;

          gnuValorTotalIva := gnuValorTotalIva  + reg.valor + nuValorIva;
          gnuValorBaseTotal := gnuValorBaseTotal + nuValorBase;

          oblFacturaVenta := true;
      END LOOP;
      pkg_traza.trace(' Termina Impuestos sbConcImpuesto => '||sbConcImpuesto , pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' Inicia Ingresos ' , pkg_traza.cnuNivelTrzDef);
      FOR reg IN cuGetIngresos LOOP
          oblFacturaVenta := true;
          nuContador := nuContador  + 1;
          sbIndex := inuFactura||LPAD(nuContador, 2, '00');

        -- Inicia la unidad de medida por defecto en 94
          sbUnidMed := csbUnidadOtros;
          nuValorUnitario := reg.ingreso;
          nuCantidad  :=  1;

         -- Valida si existe la unidad de medida del concepto en la tabla conc_unid_medida_dian
          IF tbUnidadMedConc.EXISTS(reg.cargconc) then
              sbUnidMed := tbUnidadMedConc(reg.cargconc).sbUnidadMed;
              IF tbUnidadMedConc(reg.cargconc).sbRequiereTarifa = 'S' THEN
                  nuValorUnitario := reg.valorunitario;
                  nuCantidad := reg.cantidad;
              END IF;
          END IF;

          v_tbltytInfoIngresos(sbIndex).nuIngreso       := reg.ingreso;
          v_tbltytInfoIngresos(sbIndex).nuConcepto      := reg.cargconc;
          v_tbltytInfoIngresos(sbIndex).sbDescConce     := reg.concdesc;
          v_tbltytInfoIngresos(sbIndex).InfoImpuesto    := null;
          v_tbltytInfoIngresos(sbIndex).nuCantidad  := nuCantidad;
          v_tbltytInfoIngresos(sbIndex).nuValorUnitario  := nuValorUnitario;
          v_tbltytInfoIngresos(sbIndex).sbUnidadMedida  := sbUnidMed;

          gnuValorIngreso := gnuValorIngreso +  reg.ingreso;
      END LOOP;
      pkg_traza.trace(' Termina Ingresos ' , pkg_traza.cnuNivelTrzDef);
       --se realiza proceso de representacion grafica
      nuContador := 0;
      IF v_tbltytInfoIngresos.count > 0 THEN

           sbIndex :=  v_tbltytInfoIngresos.FIRST;
           LOOP

                nuContador := nuContador  + 1;
                pkg_traza.trace(' sbIndex ' ||sbIndex, pkg_traza.cnuNivelTrzDef);
                v_tbltytInfoCargos(sbIndex).DESC_CONCEP := v_tbltytInfoIngresos(sbIndex).sbDescConce;
                v_tbltytInfoCargos(sbIndex).CAPITAL		:= to_char(v_tbltytInfoIngresos(sbIndex).nuIngreso,'FM999,999,999,990');
                v_tbltytInfoCargos(sbIndex).CONCEPTO_ID := v_tbltytInfoIngresos(sbIndex).nuConcepto;
                v_tbltytInfoCargos(sbIndex).CANTIDAD  := v_tbltytInfoIngresos(sbIndex).nuCantidad;
                v_tbltytInfoCargos(sbIndex).VALOR_UNITARIO   := to_char(v_tbltytInfoIngresos(sbIndex).nuValorUnitario, 'FM999,999,999,990');
                v_tbltytInfoCargos(sbIndex).VALOR_IVA := to_char(v_tbltytInfoIngresos(sbIndex).nuValorIva, 'FM999,999,999,990');
                IF tbUnidadMedConc.EXISTS(v_tbltytInfoIngresos(sbIndex).nuConcepto) then
                    v_tbltytInfoCargos(sbIndex).UNIDAD_ITEMS := v_tbltytInfoIngresos(sbIndex).sbUnidadMedida;
                ELSE
                   v_tbltytInfoCargos(sbIndex).UNIDAD_ITEMS := 'UND';
                END IF;
                v_tbltytInfoCargos(sbIndex).ORDENAMIENTO := nuContador;
                sbIndex :=  v_tbltytInfoIngresos.NEXT(sbIndex);
               EXIT WHEN sbIndex IS NULL;
         END LOOP;
     END IF;

      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(onuError,osbError);
      prCloseCursor;
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(onuError,osbError);
       prCloseCursor;
       pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prGetInfoValoraReportarVentas;

  PROCEDURE prGetInfoValoraReportarNotas ( inuNota    IN NUMBER,
                                           onuError   OUT NUMBER,
                                           osbError   OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoValoraReportarNotas
    Descripcion     : Proceso obtiene informacion de valores a reportar de las notas    electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 05-02-2024

    Parametros de Entrada
      inuNota   codigo de la nota
    Parametros de Salida
      onuError             codigo del error
      osbError             mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        05-02-2024   OSF-2158    Creacion
  ***************************************************************************/
     csbMT_NAME      VARCHAR2(100)  := csbSP_NAME || '.prGetInfoValoraReportarNotas';

     nuContador      NUMBER         := 0;
     sbIndex         VARCHAR2(40);

     nuValorBase     NUMBER(25,2);
     nuPorcentaje    NUMBER;
     blIsConceptoAiu BOOLEAN :=  FALSE;
     nuImpuesto      NUMBER(25,2);
     nuFactura  NUMBER;
     nuPrograma  NUMBER;
     sbUnidMed       conc_unid_medida_dian.unidad_medida%TYPE;
	 nuCantidad      NUMBER;
	 nuValorUnitario  NUMBER(25,2);

     CURSOR cuGetInfoNotas IS
     SELECT notafact, notaprog, notatino, notaobse
     FROM notas
     WHERE notanume = inuNota;

     CURSOR cuGetFacturaAso(inuFactura NUMBER) IS
     SELECT facturas_emitidas.factura_electronica,
            facturas_emitidas.fecha_emision
     FROM facturas_emitidas
     WHERE documento = inuFactura;

     --consulta valor de ingresos
     CURSOR cuGetIngresos(inuFactura NUMBER, inuPrograma NUMBER) IS
     WITH notasfact AS (
        SELECT  SUM(cargos.cargvalo * decode(cargos.cargsign,'CR', -1,1)) ingreso,
                cargos.cargconc,
                concepto.concdesc,
                SUM(nvl(cargos.cargunid,1)) cantidad,
                SUM(round(decode( nvl(cargos.cargunid,1),  0, 0, cargos.cargvalo / cargos.cargunid), 0) * decode(cargos.cargsign,'CR', -1,1)  ) valorunitario
         FROM cargos, cuencobr, concepto, servsusc
         WHERE cargos.cargcuco = cucocodi
          AND cuencobr.cucofact = inuFactura
          AND cargos.cargcodo = inuNota
          AND cargos.cargprog = inuPrograma
          AND servsusc.sesunuse = cuencobr.cuconuse
          AND cargos.cargsign IN ('DB', 'CR')
          AND servsusc.sesuserv NOT IN ( SELECT to_number(regexp_substr(csbTipoProdExcluir,  '[^,]+',   1, LEVEL)) AS TIPOPROD
                                         FROM dual
                                         CONNECT BY regexp_substr(csbTipoProdExcluir, '[^,]+', 1, LEVEL) IS NOT NULL )

          AND cargos.cargcaca IN ( SELECT (regexp_substr(csbCausalesIngr,  '[^,]+',   1, LEVEL)) AS causales
                                    FROM dual
                                    CONNECT BY regexp_substr(csbCausalesIngr, '[^,]+', 1, LEVEL) IS NOT NULL  )
          AND concepto.concticl <> 4
          AND cargos.cargconc NOT IN (  SELECT to_number(regexp_substr(sbConcExcluir,  '[^,]+',   1, LEVEL)) AS concepto
										FROM dual
									    CONNECT BY regexp_substr(sbConcExcluir, '[^,]+', 1, LEVEL) IS NOT NULL)
          AND cargos.cargconc = conccodi
         GROUP BY cargos.cargconc, concepto.concdesc
         ORDER BY cargos.cargconc),
    notasimpuestos AS (
    SELECT  notasfact.cargconc conc_base,
            ci.cargconc conct1,
            (ci.cargvalo * decode(ci.cargsign,'CR', -1,1)) iva,
            ci.cargvabl valor_base,
            (SELECT  ravtporc
             FROM  ta_vigetaco,  ta_rangvitc, ta_tariconc, ta_conftaco
             WHERE ta_vigetaco.vitctaco = ta_tariconc.tacocons
                AND ta_conftaco.cotccons = ta_tariconc.tacocotc
                AND ta_conftaco.cotcconc = ci.cargconc
                AND ta_conftaco.cotcserv = 7014
                AND ta_rangvitc.ravtvitc = ta_vigetaco.vitccons
                AND ci.cargfecr BETWEEN ta_vigetaco.vitcfein AND ta_vigetaco.vitcfefi) tarifa
    FROM cargos ci, concepto ci, concbali, cuencobr, notasfact, servsusc
    WHERE  cuencobr.cucofact = inuFactura
       AND ci.cargcuco = cuencobr.cucocodi
        AND  ci.cargcodo = inuNota
        AND ci.cargprog = inuPrograma
        AND ci.concticl = 4
        AND ci.cargsign IN ('DB', 'CR')
        AND ci.cargconc = ci.conccodi
        AND concbali.coblcoba = notasfact.cargconc
        AND servsusc.sesunuse = cuencobr.cuconuse
        AND servsusc.sesuserv NOT IN ( SELECT to_number(regexp_substr(csbTipoProdExcluir,  '[^,]+',   1, LEVEL)) AS TIPOPROD
                                     FROM dual
                                     CONNECT BY regexp_substr(csbTipoProdExcluir, '[^,]+', 1, LEVEL) IS NOT NULL )
        AND ci.cargcaca IN ( SELECT (regexp_substr(csbCausalesIngr,  '[^,]+',   1, LEVEL)) AS causales
                             FROM dual
                             CONNECT BY regexp_substr(csbCausalesIngr, '[^,]+', 1, LEVEL) IS NOT NULL  )
        AND concbali.coblconc = ci.cargconc ),
    IngresosIva AS (
        SELECT ingreso,
               cargconc,
               concdesc,
               iva,
               valor_base,
               round(ingreso * tarifa /100,0) iva_calculado,
               tarifa,
               cantidad,
               valorunitario
        FROM notasfact
         LEFT JOIN notasimpuestos ON notasfact.cargconc =  notasimpuestos.conc_base)
    SELECT INGRESO,
          CARGCONC,
          CONCDESC,
          IVA ,
          TARIFA,
          cantidad,
          valor_base,
          valorunitario
    FROM IngresosIva;


   PROCEDURE prCloseCursor IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prCloseCursor';
   BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF cuGetIngresos%ISOPEN THEN
           CLOSE cuGetIngresos;
        END IF;

        IF cuGetInfoNotas%ISOPEN THEN
           CLOSE cuGetInfoNotas;
        END IF;

        IF cuGetFacturaAso%ISOPEN THEN
          CLOSE cuGetFacturaAso;
        END IF;

        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;

    PROCEDURE prInicializaDatos IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prInicializaDatos';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        v_tbltytInfoIngresos.DELETE;
        v_tbltytInfoImpuesto.DELETE;
        pkg_error.prinicializaerror(onuError, osbError);
        sbIndex := NULL;
         gnuValorTotalIva := 0;
        gnuValorBaseTotal := 0;
        gsbTipoDocuAiu := 'N';
        gsbConceptosAiu := null;
        gnuValorIngreso := 0;
        gnuValorDescGen := 0;
        sbUnidMed := NULL;
        nuImpuesto := 0;
        nuCantidad := 0;
        nuValorUnitario := 0;
        nuFacturaAso := NULL;
        dtFechaAso  := NULL;
        sbTipoNota  := NULL;
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializaDatos;
  BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      pkg_traza.trace(' inuNota => ' || inuNota, pkg_traza.cnuNivelTrzDef);
      prCloseCursor;
      prInicializaDatos;
      pkg_error.prinicializaerror(onuError, osbError);

      OPEN cuGetInfoNotas;
      FETCH cuGetInfoNotas INTO nuFactura,nuPrograma, sbTipoNota, gsbObservacionNota;
      CLOSE cuGetInfoNotas;

      pkg_traza.trace(' nuFactura => ' ||nuFactura, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' nuPrograma => '||nuPrograma, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' sbTipoNota => '||sbTipoNota, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' gsbObservacionNota => '||gsbObservacionNota, pkg_traza.cnuNivelTrzDef);

      OPEN cuGetFacturaAso(nuFactura);
      FETCH cuGetFacturaAso INTO nuFacturaAso, dtFechaAso;
      CLOSE cuGetFacturaAso;

      pkg_traza.trace(' nuFacturaAso => '||nuFacturaAso, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' dtFechaAso => '||dtFechaAso, pkg_traza.cnuNivelTrzDef);

      pkg_traza.trace(' Inicia Ingresos ' , pkg_traza.cnuNivelTrzDef);
      FOR reg IN cuGetIngresos(nuFactura, nuPrograma) LOOP
          nuContador := nuContador  + 1;
          sbIndex := inuNota||LPAD(nuContador, 2, '00');

          -- Inicia la unidad de medida por defecto en 94
          sbUnidMed := csbUnidadOtros;
          nuValorUnitario := abs(reg.ingreso);
          nuCantidad  :=  1;
         -- Valida si existe la unidad de medida del concepto en la tabla conc_unid_medida_dian
          IF tbUnidadMedConc.EXISTS(reg.cargconc) then
              sbUnidMed := tbUnidadMedConc(reg.cargconc).sbUnidadMed;
              IF tbUnidadMedConc(reg.cargconc).sbRequiereTarifa = 'S' THEN
                  nuValorUnitario := (reg.valorunitario);
                  nuCantidad := reg.cantidad;
              END IF;
          END IF;
          pkg_traza.trace(' sbUnidMed => ' ||sbUnidMed, pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace(' nuValorUnitario => ' ||nuValorUnitario, pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace(' nuCantidad => ' ||nuCantidad, pkg_traza.cnuNivelTrzDef);

          v_tbltytInfoIngresos(sbIndex).nuIngreso       := abs(reg.ingreso);
          v_tbltytInfoIngresos(sbIndex).nuConcepto      := reg.cargconc;
          v_tbltytInfoIngresos(sbIndex).sbDescConce     := reg.concdesc;
          v_tbltytInfoIngresos(sbIndex).nuCantidad      := nuCantidad ;
          v_tbltytInfoIngresos(sbIndex).nuValorUnitario := nuValorUnitario ;
          v_tbltytInfoIngresos(sbIndex).nuValorIva      := abs(reg.iva) ;
          v_tbltytInfoIngresos(sbIndex).InfoImpuesto    := null;
          v_tbltytInfoIngresos(sbIndex).sbUnidadMedida  := sbUnidMed;
          gnuValorIngreso := gnuValorIngreso +  reg.ingreso;
		  nuImpuesto := abs(reg.iva);
          IF abs(reg.iva) > 0 THEN
              nuValorBase  := abs(reg.valor_base);
              nuPorcentaje := reg.tarifa;

               IF reg.tarifa <> nuPorcIva THEN
                 gsbTipoDocuAiu := 'S';
                 nuValorBase  := ROUND((nuPorcentaje / nuPorcIva ) * nuValorBase, 0);
                 nuPorcentaje := nuPorcIva;
                 blIsConceptoAiu := TRUE;
              END IF;

              v_tbltytInfoImpuesto(sbIndex).nuValor := abs(reg.IVA);
              v_tbltytInfoImpuesto(sbIndex).nuValorBase  := nuValorBase;
              v_tbltytInfoImpuesto(sbIndex).nuTarifa   := nuPorcentaje;
              v_tbltytInfoImpuesto(sbIndex).nuImpuesto := nuImpuesto;

              v_tbltytInfoIngresos(sbIndex).InfoImpuesto    := v_tbltytInfoImpuesto(sbIndex);
              gnuValorTotalIva := gnuValorTotalIva  + abs(reg.IVA);
              gnuValorBaseTotal := gnuValorBaseTotal + abs(nuValorBase);
          END IF;
      END LOOP;
      pkg_traza.trace(' Termina Ingresos ' , pkg_traza.cnuNivelTrzDef);
      --se realiza proceso de representacion grafica
      nuContador := 0;
      IF v_tbltytInfoIngresos.count > 0 THEN

           sbIndex :=  v_tbltytInfoIngresos.FIRST;
           LOOP

                nuContador := nuContador  + 1;
                pkg_traza.trace(' sbIndex ' ||sbIndex, pkg_traza.cnuNivelTrzDef);
                v_tbltytInfoCargos(sbIndex).DESC_CONCEP := v_tbltytInfoIngresos(sbIndex).sbDescConce;
                v_tbltytInfoCargos(sbIndex).CAPITAL		:= to_char(v_tbltytInfoIngresos(sbIndex).nuIngreso, 'FM999,999,999,990');
                v_tbltytInfoCargos(sbIndex).CONCEPTO_ID := v_tbltytInfoIngresos(sbIndex).nuConcepto;
                v_tbltytInfoCargos(sbIndex).CANTIDAD  :=  v_tbltytInfoIngresos(sbIndex).nuCantidad;
                v_tbltytInfoCargos(sbIndex).VALOR_UNITARIO   := to_char(v_tbltytInfoIngresos(sbIndex).nuValorUnitario, 'FM999,999,999,990');
                v_tbltytInfoCargos(sbIndex).VALOR_IVA := to_char(v_tbltytInfoIngresos(sbIndex).nuValorIva, 'FM999,999,999,990');
                IF tbUnidadMedConc.EXISTS(v_tbltytInfoIngresos(sbIndex).nuConcepto) then
                    v_tbltytInfoCargos(sbIndex).UNIDAD_ITEMS := v_tbltytInfoIngresos(sbIndex).sbUnidadMedida;
                ELSE
                   v_tbltytInfoCargos(sbIndex).UNIDAD_ITEMS := 'UND';
                END IF;
                v_tbltytInfoCargos(sbIndex).ORDENAMIENTO := nuContador;
                sbIndex :=  v_tbltytInfoIngresos.NEXT(sbIndex);
               EXIT WHEN sbIndex IS NULL;
         END LOOP;
     END IF;

      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(onuError,osbError);
      prCloseCursor;
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(onuError,osbError);
       prCloseCursor;
       pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prGetInfoValoraReportarNotas;

 PROCEDURE prGetInfoValoraReportar ( inuFactura IN NUMBER,
                                     onuError   OUT NUMBER,
                                     osbError   OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoValoraReportar
    Descripcion     : Proceso obtiene informacion de valores a reportar en la facturacion
                      electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 05-02-2024

    Parametros de Entrada
      inuFactura   codigo de la factura
    Parametros de Salida
      onuError             codigo del error
      osbError             mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       23-10-2024   OSF-3511    se quita cargos AS del cursos de aplicacion de saldo a favor, ademas se arregla las condiciones 
                                        para reportar consumos recuperados positivos.
    LJLB       18-10-2024   OSF-3493    se coloca filtro de cargtipr = 'A' para cargos con condiciones especiales
    LJLB        05-02-2024   OSF-2158    Creacion
  ***************************************************************************/
     csbMT_NAME      VARCHAR2(100)  := csbSP_NAME || '.prGetInfoValoraReportar';


     sbCausalesIngre VARCHAR2(4000) := pkg_parametros.fsbgetvalorcadena('CAUSALES_INGRESO_FAEL');
     sbCondicionesEspe VARCHAR2(4000) := pkg_parametros.fsbgetvalorcadena('CONDICIONES_ESPECIALES_FACTELE');
	 nuConcComp     NUMBER := pkg_parametros.fnugetvalornumerico('CONCEPTO_COMPENSACION');
     nuCausal        NUMBER         := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_CAUSCARGTT');
     nuContador      NUMBER         := 0;
     nuContadorAju   NUMBER         := 0;
     sbIndex         VARCHAR2(40);
     sbIndexImp      VARCHAR2(40);
     sbIndexConsumo   VARCHAR2(40);
     nuPerioCons     NUMBER;
     sbExiste        VARCHAR2(1);
     nuCategoria     NUMBER;
     sbPeriodoCons   VARCHAR2(4000);
     sbConcImpuesto  VARCHAR2(4000);
     nuIngrImpues    NUMBER;
     sbDescBasImp    VARCHAR2(400);
     nuConcBasImp    NUMBER;
     nuValorBase     NUMBER(25,2);
     nuCantBasImp      NUMBER;
     nuValorUnitBasImp NUMBER(25,2);
     nuPorcentaje    NUMBER;
     nuImpuesto      NUMBER(25,2);
     nuValorAjuCons  NUMBER;
     nuValorAjuConsTra NUMBER;
     blValidaAjusCons  BOOLEAN;
     nuIngresoConsumo   NUMBER;
     sbUnidMed       conc_unid_medida_dian.unidad_medida%TYPE;
	 nuCantidad      NUMBER;
	 nuValorUnitario  NUMBER(25,2);

     --consulta valor de ingresos
     CURSOR cuGetIngresos IS
     SELECT *
	 FROM ( SELECT  SUM(cargos.cargvalo * decode(cargos.cargsign,'CR', -1,1)) ingreso,
				cargos.cargconc,
				concepto.concdesc,
				cuencobr.cucocate,
				cargos.cargpeco,
                sum(nvl(cargos.cargunid,1)) cantidad,
                sum(round(decode( nvl(cargos.cargunid,1),  0, 0, cargos.cargvalo / cargos.cargunid), 0)* decode(cargos.cargsign,'CR', -1,1) ) valorunitario
			 FROM cargos, cuencobr, concepto, servsusc
			 WHERE cargos.cargcuco = cucocodi
			  AND cuencobr.cucofact = inuFactura
			  AND (cargos.cargcaca IN ( SELECT to_number(regexp_substr(sbCausalesIngre,  '[^,]+',   1, LEVEL)) AS causales
									  FROM dual
									  CONNECT BY regexp_substr(sbCausalesIngre, '[^,]+', 1, LEVEL) IS NOT NULL )
				  OR (cargos.cargconc||';'||cargos.cargcaca IN (  SELECT (regexp_substr(sbCondicionesEspe,  '[^|]+',   1, LEVEL)) AS datos
																FROM dual
																CONNECT BY regexp_substr(sbCondicionesEspe, '[^|]+', 1, LEVEL) IS NOT NULL
																)
						AND cargos.cargtipr = 'A'))
			  AND cargos.cargdoso NOT LIKE 'DF-%'
			  AND cargos.cargsign IN ('DB','CR')
			  AND cargos.cargconc NOT IN (nuConsTrans, nuConceptoCons, nuConcComp)
			  AND servsusc.sesunuse = cuencobr.cuconuse
              AND servsusc.sesuserv NOT IN ( SELECT to_number(regexp_substr(csbTipoProdExcluir,  '[^,]+',   1, LEVEL)) AS TIPOPROD
                                             FROM dual
                                             CONNECT BY regexp_substr(csbTipoProdExcluir, '[^,]+', 1, LEVEL) IS NOT NULL )

              AND cargos.cargconc NOT IN ( SELECT concbali.coblcoba
											FROM concbali
											WHERE concbali.coblconc in ( SELECT to_number(regexp_substr(sbConcImpuesto,  '[^,]+',   1, LEVEL)) AS concepto
																		 FROM dual
																		 CONNECT BY regexp_substr(sbConcImpuesto, '[^,]+', 1, LEVEL) IS NOT NULL) )
			  AND cargos.cargconc NOT IN ( SELECT to_number(regexp_substr(sbConcExcluir,  '[^,]+',   1, LEVEL)) AS concepto
										  FROM dual
										  CONNECT BY regexp_substr(sbConcExcluir, '[^,]+', 1, LEVEL) IS NOT NULL)
			  AND concepto.concticl <> 4
			  AND cargos.cargconc = conccodi
			 GROUP BY cargos.cargconc, concepto.concdesc,cuencobr.cucocate, cargos.cargpeco
			 ORDER BY cargos.cargconc)
	  WHERE ingreso <> 0;

    --se consultas ajustes realizados en la facturacion  y consumo asociado
    CURSOR cuGetIngreConsumo IS
     WITH consumofacturado AS (
     SELECT CASE WHEN cargos.cargdoso LIKE 'CO-PR%' THEN
                    nvl(cargos.cargvalo,0) *  decode(cargos.cargsign,'CR', -1,1)
                 ELSE   0  END valor_descuento,
            CASE WHEN cargos.cargdoso NOT LIKE 'CO-PR%' THEN
                   nvl(cargos.cargvalo,0) *  decode(cargos.cargsign,'CR', -1,1)
                ELSE   0   END valor_ingreso,
            CASE  WHEN cargos.cargdoso NOT LIKE 'CO-PR%' THEN
                 cargos.cargpeco
            ELSE  0   END periodo,
            cargos.cargconc,
            concepto.concdesc,
            nvl(cargos.cargunid,1) cantidad,
			round(decode( nvl(cargos.cargunid,1),  0, 0, cargos.cargvalo / cargos.cargunid), 0)* decode(cargos.cargsign,'CR', -1,1)  valorunitario
    FROM cargos, cuencobr, concepto, servsusc
    WHERE cargos.cargcuco = cuencobr.cucocodi
     AND cuencobr.cucofact = inuFactura
     AND cargos.cargcaca IN ( SELECT to_number(regexp_substr(sbCausalesIngre,  '[^,]+',   1, LEVEL)) AS causales
                               FROM dual
                               CONNECT BY regexp_substr(sbCausalesIngre, '[^,]+', 1, LEVEL) IS NOT NULL )
     AND cargos.cargdoso NOT LIKE 'DF-%'
     AND cargos.cargconc = nuConceptoCons
     AND cargos.cargsign IN ('DB','CR')
      AND servsusc.sesunuse = cuencobr.cuconuse
      AND servsusc.sesuserv NOT IN ( SELECT to_number(regexp_substr(csbTipoProdExcluir,  '[^,]+',   1, LEVEL)) AS TIPOPROD
                                     FROM dual
                                     CONNECT BY regexp_substr(csbTipoProdExcluir, '[^,]+', 1, LEVEL) IS NOT NULL )
     AND cargos.cargconc = concepto.conccodi
    ), valorconsufacturado AS (
        SELECT SUM(valor_ingreso) valor_ingreso,
               SUM(valor_descuento) valor_descuento,
               MAX(periodo) periodo,
               cargconc,
               concdesc,
               sum(cantidad) cantidad,
               sum(valorunitario) valorunitario
        FROM consumofacturado
        GROUP BY consumofacturado.cargconc,
                 consumofacturado.concdesc )
    SELECT periodo, valor_ingreso, valor_descuento, cargconc, concdesc, cantidad, valorunitario
    FROM valorconsufacturado
    WHERE valor_ingreso <> 0 OR valor_descuento <> 0;

    regIngresConsumo      cuGetIngreConsumo%rowtype;
    regIngresConsumonull   cuGetIngreConsumo%rowtype;


    --consulta valor de ingresos de tarifa transitoria
    CURSOR cuGetIngresoTrans(inuPeriCons NUMBER) IS
     WITH ConsumoTranFacturado AS (
        SELECT  CASE WHEN cargos.cargpeco = inuPeriCons THEN
                    NVL(cargos.cargvalo,0) * decode(cargos.cargsign,'CR', -1,1)
                     ELSE 0  END ingreso,
                 CASE WHEN cargos.cargpeco <> inuPeriCons THEN
                    NVL(cargos.cargvalo,0) * decode(cargos.cargsign,'CR', -1,1)
                    ELSE 0  END ajuste,
                 cargos.cargconc,
                 concepto.concdesc,
                 nvl(cargos.cargunid,1) cantidad,
			    round(decode( nvl(cargos.cargunid,1),  0, 0, cargos.cargvalo / cargos.cargunid), 0)* decode(cargos.cargsign,'CR', -1,1)  valorunitario
        FROM cargos, cuencobr, concepto, servsusc
        WHERE cargos.cargcuco = cucocodi
         AND cuencobr.cucofact = inuFactura
         AND cargos.cargcaca  IN ( SELECT to_number(regexp_substr(sbCausalesIngre,  '[^,]+',   1, LEVEL)) AS causales
                                  FROM dual
                                  CONNECT BY regexp_substr(sbCausalesIngre, '[^,]+', 1, LEVEL) IS NOT NULL)
         AND cargos.cargconc = nuConsTrans
         AND cargos.cargdoso NOT LIKE 'DF-%'
         AND cargos.cargsign IN ('DB','CR')
         AND servsusc.sesunuse = cuencobr.cuconuse
         AND servsusc.sesuserv NOT IN ( SELECT to_number(regexp_substr(csbTipoProdExcluir,  '[^,]+',   1, LEVEL)) AS TIPOPROD
                                         FROM dual
                                         CONNECT BY regexp_substr(csbTipoProdExcluir, '[^,]+', 1, LEVEL) IS NOT NULL )
         AND cargos.cargconc = concepto.conccodi),
    TotalConsTran AS (
     SELECT SUM(ingreso) ingreso,
            SUM(ajuste) ajuste,
            cargconc ,
            concdesc,
            sum(cantidad) cantidad,
            sum(valorunitario) valorunitario
     FROM ConsumoTranFacturado
     GROUP BY cargconc, concdesc)
     SELECT *
     FROM TotalConsTran;

    regIngresTrans      cuGetIngresoTrans%rowtype;
    regIngresTransnull  cuGetIngresoTrans%rowtype;


    --se consultan ingresos base de los impuesto
    CURSOR cuGetIngrImpuesto(inuConcImp NUMBER) IS
    WITH IngreImp AS (
    SELECT cargos.cargvalo * decode(cargos.cargsign,'CR', -1,1) ingreso,
            cargos.cargconc,
            concepto.concdesc,
            nvl(cargos.cargunid,1) cantidad,
			round(decode( nvl(cargos.cargunid,1),  0, 0, cargos.cargvalo / cargos.cargunid), 0)* decode(cargos.cargsign,'CR', -1,1)  valorunitario,
            rownum id_reg
    FROM cargos, cuencobr, concepto, servsusc
    WHERE cargos.cargcuco = cucocodi
     AND cuencobr.cucofact = inuFactura
     AND (cargos.cargcaca IN ( SELECT to_number(regexp_substr(sbCausalesIngre,  '[^,]+',   1, LEVEL)) AS causales
                              FROM dual
                              CONNECT BY regexp_substr(sbCausalesIngre, '[^,]+', 1, LEVEL) IS NOT NULL)
         OR (cargos.cargconc||';'||cargos.cargcaca IN (  SELECT (regexp_substr(sbCondicionesEspe,  '[^|]+',   1, LEVEL)) AS datos
                                                        FROM dual
                                                        CONNECT BY regexp_substr(sbCondicionesEspe, '[^|]+', 1, LEVEL) IS NOT NULL
                                                        )
					AND cargos.cargtipr = 'A'))
     AND cargos.cargdoso NOT LIKE 'CO-PR%'
     AND cargos.cargdoso NOT LIKE 'DF-%'
     AND cargos.cargconc = conccodi
     AND cargos.cargsign IN ('DB','CR')
     AND servsusc.sesunuse = cuencobr.cuconuse
     AND servsusc.sesuserv NOT IN ( SELECT to_number(regexp_substr(csbTipoProdExcluir,  '[^,]+',   1, LEVEL)) AS TIPOPROD
                                     FROM dual
                                     CONNECT BY regexp_substr(csbTipoProdExcluir, '[^,]+', 1, LEVEL) IS NOT NULL )
     AND cargos.cargconc in ( SELECT concbali.coblcoba
                              FROM concbali
                              WHERE concbali.coblconc = inuConcImp)
    ORDER BY cargos.cargconc),
    totalingimpuesto AS (
                SELECT ingreso ,
                       CASE WHEN id_reg = 1 THEN cargconc
                            ELSE (SELECT cargconc FROM ingreimp WHERE id_reg = 1)
                       END cargconc,
                       CASE WHEN id_reg = 1 THEN concdesc
                            ELSE (SELECT concdesc FROM ingreimp WHERE id_reg = 1)
                       END concdesc,
                       cantidad,
                       valorunitario
                FROM ingreimp)
    SELECT *

	FROM ( SELECT SUM(ingreso) ingreso,
			   cargconc,
			   concdesc,
               SUM(cantidad)  cantidad,
               SUM(valorunitario) valorunitario
			FROM totalingimpuesto
			GROUP BY cargconc, concdesc)
	WHERE ingreso <> 0;

    --se consulta impuestos
    CURSOR cuGetImpuesto IS
    WITH impuestos AS (
    SELECT  cargos.cargvalo * decode(cargos.cargsign,'CR', -1,1) valor,
            cargos.cargconc,
            concepto.concdesc,
            cargos.cargvabl * decode(cargos.cargsign,'CR', -1,1) cargvabl,
            cargos.cargtaco,
            cargos.cargfecr
    FROM cargos, cuencobr, concepto, servsusc
    WHERE cargos.cargcuco = cucocodi
      AND cuencobr.cucofact = inuFactura
      AND cargos.cargdoso NOT LIKE 'DF-%'
      AND cargos.cargcaca IN ( SELECT to_number(regexp_substr(sbCausalesIngre,  '[^,]+',   1, LEVEL)) AS causales
                               FROM dual
                              CONNECT BY regexp_substr(sbCausalesIngre, '[^,]+', 1, LEVEL) IS NOT NULL )
      AND concepto.concticl = 4
      AND cargos.cargconc = conccodi
      AND servsusc.sesunuse = cuencobr.cuconuse
       AND servsusc.sesuserv NOT IN ( SELECT to_number(regexp_substr(csbTipoProdExcluir,  '[^,]+',   1, LEVEL)) AS TIPOPROD
                                         FROM dual
                                         CONNECT BY regexp_substr(csbTipoProdExcluir, '[^,]+', 1, LEVEL) IS NOT NULL )  ),
    tarifaimpuesto AS (
         SELECT impuestos.*,
                 ( SELECT ravtporc
                    FROM  ta_vigetaco,  ta_rangvitc
                  WHERE ta_vigetaco.vitctaco = cargtaco
                      AND ta_rangvitc.ravtvitc = ta_vigetaco.vitccons
                      AND cargfecr BETWEEN ta_vigetaco.vitcfein AND ta_vigetaco.vitcfefi) tarifa
          FROM impuestos
     ) , TotalImpuesto AS (
     SELECT SUM(valor) valor,
            SUM(cargvabl)  valor_base,
            cargconc,
            tarifa
     FROM tarifaimpuesto
     GROUP BY tarifa,cargconc)
   SELECT valor,
        valor_base,
        round(valor_base * ( tarifa /100),2) impuesto_calc,
        cargconc,
        tarifa
   FROM TotalImpuesto
   WHERE valor <> 0;

    blIsConceptoAiu BOOLEAN :=  FALSE;
    nuValorBaseCons NUMBER;
    sbIndexAjust         VARCHAR2(4000);
    nuValorAjuste   NUMBER;

    CURSOR cugetAplicacionSaldoFavor IS
    SELECT SUM(descuento) descuento
	FROM (
	SELECT NVL(SUM(cargos.cargvalo * decode(cargos.cargsign,'CR', -1,'AS', -1, 1) ),0) descuento
     FROM cargos, cuencobr, servsusc
     WHERE cargos.cargcuco = cucocodi
      AND cuencobr.cucofact = inuFactura
      AND cargos.cargdoso NOT LIKE 'CO-PR%'
      AND cargos.cargdoso NOT LIKE 'DF-%'
      AND servsusc.sesunuse = cuencobr.cuconuse
      AND servsusc.sesuserv NOT IN ( SELECT to_number(regexp_substr(csbTipoProdExcluir,  '[^,]+',   1, LEVEL)) AS TIPOPROD
                                     FROM dual
                                     CONNECT BY regexp_substr(csbTipoProdExcluir, '[^,]+', 1, LEVEL) IS NOT NULL )
      AND cargos.cargconc = nuConcComp );

    PROCEDURE prCloseCursor IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prCloseCursor';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF cuGetIngresos%ISOPEN THEN
           CLOSE cuGetIngresos;
        END IF;

        IF cuGetIngresoTrans%ISOPEN THEN
           CLOSE cuGetIngresoTrans;
        END IF;

        IF cuGetImpuesto%ISOPEN THEN
           CLOSE cuGetImpuesto;
        END IF;

        IF cuGetIngreConsumo%ISOPEN THEN
           CLOSE cuGetIngreConsumo;
        END IF;

        IF cuGetIngrImpuesto%ISOPEN THEN
           CLOSE cuGetIngrImpuesto;
        END IF;
        IF cugetAplicacionSaldoFavor%ISOPEN THEN
           CLOSE cugetAplicacionSaldoFavor;
        END IF;

        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;

    PROCEDURE prInicializaDatos IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prInicializaDatos';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        v_tbltytInfoIngresos.DELETE;
        v_tbltytInfoImpuesto.DELETE;
        v_tbltytInfoAjustes.DELETE;
        pkg_error.prinicializaerror(onuError, osbError);
        sbIndex := NULL;
        sbExiste := NULL;
        nuPerioCons := NULL;
        nuCategoria := NULL;
        sbPeriodoCons := NULL;
        regIngresTrans := regIngresTransnull;
        sbConcImpuesto  := null;
        nuIngrImpues := NULL;
        sbDescBasImp := NULL;
        nuConcBasImp := NULL;
        gnuValorTotalIva := 0;
        gnuValorBaseTotal := 0;
        gsbTipoDocuAiu := 'N';
        gsbConceptosAiu := null;
        nuValorBaseCons := 0;
        gnuValorIngreso := 0;
        gnuValorDescGen := 0;
        nuValorAjuCons := 0;
        nuValorAjuConsTra := 0;
        nuIngresoConsumo  := 0;
        blValidaAjusCons  := false;
        sbIndexConsumo    := null;
        nuCantBasImp  := null;
        nuValorUnitBasImp := null;
        sbUnidMed   := null;
        nuCantidad  := null;
	    nuValorUnitario := null;
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializaDatos;
  BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      pkg_traza.trace(' inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
      prCloseCursor;
      prInicializaDatos;
      pkg_traza.trace(' Inicia Impuestos ' , pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' sbCausalesIngre => ' ||sbCausalesIngre, pkg_traza.cnuNivelTrzDef);

      FOR reg IN cuGetImpuesto LOOP
          nuIngrImpues := NULL;
          sbDescBasImp := NULL;
          nuConcBasImp := NULL;
          nuCantBasImp  := null;
          nuValorUnitBasImp := null;
          sbUnidMed   := null;
          nuCantidad  := null;
	      nuValorUnitario := null;
          nuValorBase  := reg.valor_base;
          nuPorcentaje := reg.tarifa;
          nuImpuesto   := reg.valor;
          blIsConceptoAiu := FALSE;
          nuContador := nuContador  + 1;
          sbIndexImp := inuFactura||nuContador;
        pkg_traza.trace(' Concepto Impuesto '||reg.cargconc , pkg_traza.cnuNivelTrzDef);
          IF reg.tarifa <> nuPorcIva THEN
             gsbTipoDocuAiu := 'S';
             nuValorBase  := ROUND((nuPorcentaje / nuPorcIva ) * nuValorBase, 0);

             nuPorcentaje := nuPorcIva;
             pkg_traza.trace(' nuImpuesto '||nuImpuesto , pkg_traza.cnuNivelTrzDef);
             pkg_traza.trace(' nuValorBase '||nuValorBase , pkg_traza.cnuNivelTrzDef);
             pkg_traza.trace(' nuPorcentaje '||nuPorcentaje , pkg_traza.cnuNivelTrzDef);
             pkg_traza.trace(' gsbTipoDocuAiu '||gsbTipoDocuAiu , pkg_traza.cnuNivelTrzDef);
             blIsConceptoAiu := TRUE;
          END IF;
          pkg_traza.trace(' sbIndexImp '||sbIndexImp , pkg_traza.cnuNivelTrzDef);
          v_tbltytInfoImpuesto(sbIndexImp).nuValor := reg.valor;
          v_tbltytInfoImpuesto(sbIndexImp).nuValorBase  := abs(nuValorBase);
          v_tbltytInfoImpuesto(sbIndexImp).nuTarifa   := nuPorcentaje;
          v_tbltytInfoImpuesto(sbIndexImp).nuImpuesto := nuImpuesto;
          IF nuContador = 1 THEN
             sbConcImpuesto := reg.cargconc;
          ELSE
            sbConcImpuesto := sbConcImpuesto||','||reg.cargconc;
          END IF;


          IF cuGetIngrImpuesto%ISOPEN THEN
             CLOSE cuGetIngrImpuesto;
          END IF;
          --se consulta concepto base que liquido el impuesto
          OPEN cuGetIngrImpuesto(reg.cargconc);
          FETCH cuGetIngrImpuesto INTO nuIngrImpues, nuConcBasImp, sbDescBasImp, nuCantBasImp, nuValorUnitBasImp;
          IF cuGetIngrImpuesto%FOUND THEN
              sbIndex := inuFactura||LPAD(nuContador, 2, '00');
              -- Inicia la unidad de medida por defecto en 94
              sbUnidMed := csbUnidadOtros;
              nuValorUnitario := nuIngrImpues;
              nuCantidad  :=  1;
             -- Valida si existe la unidad de medida del concepto en la tabla conc_unid_medida_dian
              IF tbUnidadMedConc.EXISTS(nuConcBasImp) then
                  sbUnidMed := tbUnidadMedConc(nuConcBasImp).sbUnidadMed;
                  IF tbUnidadMedConc(nuConcBasImp).sbRequiereTarifa = 'S' THEN
                      nuValorUnitario := nuValorUnitBasImp;
                      nuCantidad := nuCantBasImp;
                  END IF;
              END IF;

              v_tbltytInfoIngresos(sbIndex).nuIngreso       := nuIngrImpues;
              v_tbltytInfoIngresos(sbIndex).nuValorUnitario := nuValorUnitario;
              v_tbltytInfoIngresos(sbIndex).nuCantidad      := nuCantidad;
              v_tbltytInfoIngresos(sbIndex).sbUnidadMedida  := sbUnidMed;
              v_tbltytInfoIngresos(sbIndex).nuConcepto      := nuConcBasImp;
              v_tbltytInfoIngresos(sbIndex).sbDescConce     := sbDescBasImp;
              v_tbltytInfoIngresos(sbIndex).InfoImpuesto    := v_tbltytInfoImpuesto(sbIndexImp);
              v_tbltytInfoIngresos(sbIndex).infoDescuento   := null;
              gnuValorIngreso := gnuValorIngreso + nuIngrImpues;
              pkg_traza.trace(' v_tbltytInfoImpuesto(sbIndexImp).nuValor '||v_tbltytInfoImpuesto(sbIndexImp).nuValor , pkg_traza.cnuNivelTrzDef);
              IF blIsConceptoAiu THEN
                  IF gsbConceptosAiu IS NULL THEN
                     gsbConceptosAiu  := nuConcBasImp;
                  ELSE
                    gsbConceptosAiu  := gsbConceptosAiu||','||nuConcBasImp;
                  END IF;
              END IF;
          END IF;
          CLOSE cuGetIngrImpuesto;

          gnuValorTotalIva := gnuValorTotalIva  + reg.valor;
          gnuValorBaseTotal := gnuValorBaseTotal + nuValorBase;

      END LOOP;
      pkg_traza.trace(' Termina Impuestos sbConcImpuesto => '||sbConcImpuesto , pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' Inicia Ingresos ' , pkg_traza.cnuNivelTrzDef);
      FOR reg IN cuGetIngresos LOOP
          nuContador := nuContador  + 1;
          sbIndex := inuFactura||LPAD(nuContador, 2, '00');
          pkg_traza.trace(' sbIndex ' ||sbIndex, pkg_traza.cnuNivelTrzDef);
          -- Inicia la unidad de medida por defecto en 94
          sbUnidMed := csbUnidadOtros;
          nuValorUnitario := reg.ingreso;
          nuCantidad  :=  1;
         -- Valida si existe la unidad de medida del concepto en la tabla conc_unid_medida_dian
          IF tbUnidadMedConc.EXISTS(reg.cargconc) then
              sbUnidMed := tbUnidadMedConc(reg.cargconc).sbUnidadMed;
              IF tbUnidadMedConc(reg.cargconc).sbRequiereTarifa = 'S' THEN
                  nuValorUnitario := reg.valorunitario;
                  nuCantidad :=  reg.cantidad;
              END IF;
          END IF;

          v_tbltytInfoIngresos(sbIndex).nuIngreso       := reg.ingreso;
          v_tbltytInfoIngresos(sbIndex).nuConcepto      := reg.cargconc;
          v_tbltytInfoIngresos(sbIndex).sbDescConce     := reg.concdesc;
          v_tbltytInfoIngresos(sbIndex).nuValorUnitario := nuValorUnitario;
          v_tbltytInfoIngresos(sbIndex).InfoImpuesto    := null;
          v_tbltytInfoIngresos(sbIndex).infoDescuento    := null;
          v_tbltytInfoIngresos(sbIndex).isAjuste        := 'N';
          v_tbltytInfoIngresos(sbIndex).nuCantidad      := nuCantidad;
          v_tbltytInfoIngresos(sbIndex).sbUnidadMedida  := sbUnidMed;

          gnuValorIngreso := gnuValorIngreso + reg.ingreso;
          IF reg.cargpeco IS NOT NULL AND nuPerioCons IS NULL THEN
             nuPerioCons := reg.cargpeco;
             nuCategoria := reg.cucocate;
          END IF;

      END LOOP;
      pkg_traza.trace(' Termina Ingresos nuContador => '||nuContador||' gnuValorIngreso => '||gnuValorIngreso , pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' nuCategoria => ' || nuCategoria, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' nuPerioCons => ' || nuPerioCons, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' Inicia Ajustes ' , pkg_traza.cnuNivelTrzDef);
      regIngresConsumo :=  regIngresConsumonull;
      OPEN cuGetIngreConsumo;
      FETCH cuGetIngreConsumo INTO regIngresConsumo;
      IF cuGetIngreConsumo%FOUND THEN

          IF nuPerioCons IS NULL THEN
             nuPerioCons := regIngresConsumo.periodo;
           END IF;
           pkg_traza.trace(' nuPerioCons ' ||nuPerioCons, pkg_traza.cnuNivelTrzDef);
          nuContador := nuContador  + 1;
          sbIndexConsumo := inuFactura||LPAD(nuContador, 2, '00');
          pkg_traza.trace(' sbIndexConsumo ' ||sbIndexConsumo, pkg_traza.cnuNivelTrzDef);
          gnuValorIngreso := gnuValorIngreso  + regIngresConsumo.valor_ingreso;

          IF gnuValorIngreso > 0 OR regIngresConsumo.valor_descuento > 0 THEN
              -- Inicia la unidad de medida por defecto en 94
              sbUnidMed := csbUnidadOtros;
              nuValorUnitario := regIngresConsumo.valor_ingreso;
              nuCantidad  :=  1;
             -- Valida si existe la unidad de medida del concepto en la tabla conc_unid_medida_dian
              IF tbUnidadMedConc.EXISTS(regIngresConsumo.cargconc) then
                  sbUnidMed := tbUnidadMedConc(regIngresConsumo.cargconc).sbUnidadMed;
                  IF tbUnidadMedConc(regIngresConsumo.cargconc).sbRequiereTarifa = 'S' THEN
                      nuValorUnitario := regIngresConsumo.valorunitario;
                      nuCantidad :=  regIngresConsumo.cantidad;
                  END IF;
              END IF;
              IF (regIngresConsumo.valor_descuento + regIngresConsumo.valor_ingreso) < 0 THEN
                 v_tbltytInfoIngresos(sbIndexConsumo).nuIngreso       := 0;
                 v_tbltytInfoIngresos(sbIndexConsumo).nuValorUnitario := nuValorUnitario;
                 nuIngresoConsumo :=  regIngresConsumo.valor_ingreso;
              ELSE
                 v_tbltytInfoIngresos(sbIndexConsumo).nuIngreso       := regIngresConsumo.valor_ingreso + regIngresConsumo.valor_descuento;
                 v_tbltytInfoIngresos(sbIndexConsumo).nuValorUnitario := nuValorUnitario;
                 IF regIngresConsumo.valor_descuento < 0 THEN
                    pkg_traza.trace(' Descuento menor al ingreso de consumo ' ||regIngresConsumo.valor_descuento, pkg_traza.cnuNivelTrzDef);
                    nuIngresoConsumo :=  ABS(regIngresConsumo.valor_descuento);
                 ELSIF gnuValorIngreso = 0 THEN
                     gnuValorIngreso := gnuValorIngreso + regIngresConsumo.valor_descuento;
                 END IF;
              END IF;
              v_tbltytInfoIngresos(sbIndexConsumo).nuCantidad      := nuCantidad;
              v_tbltytInfoIngresos(sbIndexConsumo).sbUnidadMedida  := sbUnidMed;
              v_tbltytInfoIngresos(sbIndexConsumo).nuConcepto      := regIngresConsumo.cargconc;
              v_tbltytInfoIngresos(sbIndexConsumo).sbDescConce     := regIngresConsumo.concdesc;
              v_tbltytInfoIngresos(sbIndexConsumo).InfoImpuesto    := null;

			  pkg_traza.trace(' nuIngresoConsumo ' ||nuIngresoConsumo, pkg_traza.cnuNivelTrzDef);
			 --se almacenan ajustes
			  nuValorAjuCons := regIngresConsumo.valor_descuento;

			  IF  (nuValorAjuCons  + gnuValorIngreso) >= 0 AND ABS(nuValorAjuCons) > 0 THEN
				  pkg_traza.trace(' Realizo ajuste Inicial ' , pkg_traza.cnuNivelTrzDef);
				  nuContadorAju := nuContadorAju  + 1;
				  sbIndexAjust := inuFactura||nuContadorAju;
				  v_tbltytInfoAjustes(sbIndexAjust).nuValor := (nuValorAjuCons);
				  v_tbltytInfoAjustes(sbIndexAjust).nuValorBase := (nuValorAjuCons);
				  v_tbltytInfoAjustes(sbIndexAjust).nuConcepto  := regIngresConsumo.cargconc;
				  v_tbltytInfoAjustes(sbIndexAjust).sbDescConce   := regIngresConsumo.concdesc;

				  v_tbltytInfoIngresos(sbIndexConsumo).infoDescuento    := v_tbltytInfoAjustes(sbIndexAjust);
				  blValidaAjusCons := true;
				  IF (nuValorAjuCons + regIngresConsumo.valor_ingreso) > 0 THEN
					 nuValorAjuCons := 0;
				  ELSE
					 IF nuValorAjuCons < 0 THEN
						nuValorAjuCons := nuValorAjuCons + regIngresConsumo.valor_ingreso;
					 END IF;
				  END IF;
			  END IF;
		END IF;

      END IF;
      CLOSE cuGetIngreConsumo;
      pkg_traza.trace(' Termina Ajustes nuValorAjuCons =>'||nuValorAjuCons||' gnuValorIngreso => '||gnuValorIngreso , pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' sbPeriodoCons => ' || sbPeriodoCons, pkg_traza.cnuNivelTrzDef);

     OPEN cuGetIngresoTrans(nuPerioCons);
     FETCH cuGetIngresoTrans INTO  regIngresTrans;
     IF cuGetIngresoTrans%FOUND THEN
          nuContador := nuContador  + 1;
          sbIndex := inuFactura||nuContador;
          IF ( (gnuValorIngreso - nuIngresoConsumo) + regIngresTrans.ingreso + nuValorAjuCons) > 0 THEN
              -- Inicia la unidad de medida por defecto en 94
              sbUnidMed := csbUnidadOtros;
              nuValorUnitario := regIngresTrans.ingreso;
              nuCantidad  :=  1;
             -- Valida si existe la unidad de medida del concepto en la tabla conc_unid_medida_dian
              IF tbUnidadMedConc.EXISTS(regIngresTrans.cargconc) then
                  sbUnidMed := tbUnidadMedConc(regIngresTrans.cargconc).sbUnidadMed;
                  IF tbUnidadMedConc(regIngresTrans.cargconc).sbRequiereTarifa = 'S' THEN
                      nuValorUnitario := regIngresTrans.valorunitario;
                      nuCantidad :=  regIngresTrans.cantidad;
                  END IF;
              END IF;

              IF (regIngresTrans.ajuste + regIngresTrans.ingreso) < 0 THEN
                 v_tbltytInfoIngresos(sbIndex).nuIngreso       := 0;
                 v_tbltytInfoIngresos(sbIndex).nuValorUnitario := nuValorUnitario;
              ELSE
                 v_tbltytInfoIngresos(sbIndex).nuIngreso       := regIngresTrans.ingreso + regIngresTrans.ajuste;
                 v_tbltytInfoIngresos(sbIndex).nuValorUnitario := nuValorUnitario;
              END IF;

              v_tbltytInfoIngresos(sbIndex).nuConcepto      := regIngresTrans.cargconc;
              v_tbltytInfoIngresos(sbIndex).sbDescConce     := regIngresTrans.concdesc;
              v_tbltytInfoIngresos(sbIndex).isAjuste        := 'N';
              v_tbltytInfoIngresos(sbIndex).nuCantidad      := nuCantidad;
              v_tbltytInfoIngresos(sbIndex).sbUnidadMedida  := sbUnidMed;
			  pkg_traza.trace(' regIngresTrans.ingreso => ' || regIngresTrans.ingreso, pkg_traza.cnuNivelTrzDef);
			  pkg_traza.trace(' regIngresTrans.ajuste => ' || regIngresTrans.ajuste, pkg_traza.cnuNivelTrzDef);

			  IF (nuValorAjuCons + (gnuValorIngreso - nuIngresoConsumo) ) <= 0  AND abs(regIngresTrans.ajuste) > 0 THEN
				  nuValorAjuConsTra := -regIngresTrans.ingreso;
				  nuContadorAju := nuContadorAju  + 1;
				  sbIndexAjust := inuFactura||nuContadorAju;
				  v_tbltytInfoAjustes(sbIndexAjust).nuValor := (nuValorAjuConsTra);
				  v_tbltytInfoAjustes(sbIndexAjust).nuValorBase := (nuValorAjuConsTra);
				  v_tbltytInfoAjustes(sbIndexAjust).nuConcepto  := regIngresTrans.cargconc;
				  v_tbltytInfoAjustes(sbIndexAjust).sbDescConce   := regIngresTrans.concdesc;
				  IF (gnuValorIngreso + regIngresTrans.ingreso) > 0 THEN
					 v_tbltytInfoIngresos(sbIndex).infoDescuento    := v_tbltytInfoAjustes(sbIndexAjust);
				  END IF;
			  ELSE
				 gnuValorIngreso := gnuValorIngreso  + regIngresTrans.ingreso;
				 IF abs(regIngresTrans.ajuste) > 0 THEN
					 IF  abs(nuValorAjuCons + (gnuValorIngreso - nuIngresoConsumo) ) <  abs(regIngresTrans.ajuste) THEN
						 nuValorAjuConsTra := -(nuValorAjuCons + (gnuValorIngreso - nuIngresoConsumo - regIngresTrans.ingreso));
					 ELSE
						 nuValorAjuConsTra := regIngresTrans.ajuste;
					 END IF;
					 pkg_traza.trace(' nuValorAjuConsTra antes => ' || nuValorAjuConsTra, pkg_traza.cnuNivelTrzDef);
					 nuContadorAju := nuContadorAju  + 1;
					 sbIndexAjust := inuFactura||nuContadorAju;
					 v_tbltytInfoAjustes(sbIndexAjust).nuValor := (nuValorAjuConsTra);
					 v_tbltytInfoAjustes(sbIndexAjust).nuValorBase := (nuValorAjuConsTra);
					 v_tbltytInfoAjustes(sbIndexAjust).nuConcepto  := regIngresTrans.cargconc;
					 v_tbltytInfoAjustes(sbIndexAjust).sbDescConce   := regIngresTrans.concdesc;

					 v_tbltytInfoIngresos(sbIndex).infoDescuento    := v_tbltytInfoAjustes(sbIndexAjust);
                     gnuValorIngreso := gnuValorIngreso + nuValorAjuConsTra;

				 END IF;
			  END IF;

			   IF regIngresTrans.ingreso = 0 AND gnuValorIngreso > 0 THEN
				   v_tbltytInfoIngresos(sbIndex).nuValorUnitario := abs(nuValorAjuConsTra);
                   v_tbltytInfoIngresos(sbIndex).nuCantidad := 1;
			   ELSE
				   IF (nuValorAjuConsTra + regIngresTrans.ingreso) > 0 THEN
					  nuValorAjuConsTra := 0;
				   END IF;
			   END IF;

		   END IF;

     END IF;
     CLOSE cuGetIngresoTrans;
	pkg_traza.trace(' gnuValorIngreso => ' || gnuValorIngreso, pkg_traza.cnuNivelTrzDef);																				   
     pkg_traza.trace(' nuValorAjuConsTra => ' || nuValorAjuConsTra, pkg_traza.cnuNivelTrzDef);
     IF NOT blValidaAjusCons AND  nuValorAjuCons <> 0 THEN
        pkg_traza.trace(' Realizo ajuste al Final gnuValorIngreso => '||gnuValorIngreso||' nuIngresoConsumo => '|| nuIngresoConsumo , pkg_traza.cnuNivelTrzDef);
        IF (nuValorAjuCons + (gnuValorIngreso - nuIngresoConsumo))  < 0 THEN
           IF gnuValorIngreso > 0 THEN
             nuValorAjuCons := -gnuValorIngreso;
             pkg_traza.trace(' Ingreso menor nuValorAjuCons => '|| nuValorAjuCons , pkg_traza.cnuNivelTrzDef);

           END IF;
        END IF;

        nuContadorAju := nuContadorAju  + 1;
        sbIndexAjust := inuFactura||nuContadorAju;
        v_tbltytInfoAjustes(sbIndexAjust).nuValor := (nuValorAjuCons);
        v_tbltytInfoAjustes(sbIndexAjust).nuValorBase := (nuValorAjuCons);
        v_tbltytInfoAjustes(sbIndexAjust).nuConcepto  := regIngresConsumo.cargconc;
        v_tbltytInfoAjustes(sbIndexAjust).sbDescConce   := regIngresConsumo.concdesc;
        IF  gnuValorIngreso > 0 THEN
            v_tbltytInfoIngresos(sbIndexConsumo).infoDescuento    := v_tbltytInfoAjustes(sbIndexAjust);

            IF nuIngresoConsumo = 0  THEN
               v_tbltytInfoIngresos(sbIndexConsumo).nuValorUnitario := abs(nuValorAjuCons);
               v_tbltytInfoIngresos(sbIndexConsumo).nuCantidad := 1;
            END IF;
        END IF;
     END IF;

     IF (nuValorAjuConsTra + nuValorAjuCons  + (gnuValorIngreso - nuIngresoConsumo)  ) > 0 THEN
         --se validan descuentos
         OPEN cugetAplicacionSaldoFavor;
         FETCH cugetAplicacionSaldoFavor INTO  gnuValorDescuento;
         CLOSE cugetAplicacionSaldoFavor;
          pkg_traza.trace(' Saldo a favor gnuValorDescuento =>'||gnuValorDescuento||' TotalFactura => '||(nuValorAjuConsTra + nuValorAjuCons  + (gnuValorIngreso - nuIngresoConsumo)) , pkg_traza.cnuNivelTrzDef);
         IF (nuValorAjuConsTra + nuValorAjuCons  + (gnuValorIngreso - nuIngresoConsumo) ) +  gnuValorDescuento < 0 THEN
            gnuValorDescuento :=  -(gnuValorIngreso - nuIngresoConsumo);
         ELSE
            IF nuValorAjuConsTra < 0  THEN
               gnuValorDescuento := gnuValorDescuento  + nuValorAjuConsTra;
            END IF;
            IF nuValorAjuCons < 0 THEN
               gnuValorDescuento := gnuValorDescuento  + nuValorAjuCons;
            END IF;

         END IF;
     ELSE
          gnuValorDescuento :=  - (gnuValorIngreso - nuIngresoConsumo);
     END IF;

      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(onuError,osbError);
      prCloseCursor;
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(onuError,osbError);
       prCloseCursor;
       pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prGetInfoValoraReportar;

  PROCEDURE prInicializarDatosCons (  inuFactura   IN NUMBER,
                                      inuTipoDocu  IN NUMBER,
                                      isbOperacion  IN VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInicializarDatosCons
    Descripcion     : proceso para inicializar consecutivos

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 09-01-2024

    Parametros de Entrada
      inuFactura       codigo de la factura
      inuTipoDocu      tipo de documento
      isbOperacion     Operacion a realizar I - Insertar A -Actualizar
    Parametros de Salida
      OtytCanalUno    tabla con registro de canal uno
      OnuContrato     numero de contrato
      osbRutaReparto   ruta de reparto
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        09-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prInicializarDatosCons';
    v_styConsecutivo  pkg_recofael.styConsecutivo;
    v_styConsecutivonull  pkg_recofael.styConsecutivo;
    CURSOR cuGetInfoFactura IS
     SELECT *
     FROM factura_elect_general
     WHERE factura_elect_general.TIPO_DOCUMENTO = inuTipoDocu
       AND factura_elect_general.DOCUMENTO = TO_CHAR(inuFactura);

    regFactura   cuGetInfoFactura%rowtype;
    regFacturanull   cuGetInfoFactura%rowtype;

    PROCEDURE prObtenerConsetivo IS
       PRAGMA AUTONOMOUS_TRANSACTION;
       csbMT_NAME1        CONSTANT VARCHAR2(105) := csbMT_NAME ||  '.prObtenerConsetivo';
       nuConseSig         NUMBER;
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF isbOperacion = 'I' THEN

            IF inuTipoDocu = cnuTipoDocuFactRecu THEN
                nuConseSig := SEQ_FACTURA_ELECT_GEN_CONSFAEL.NEXTVAL;
            ELSE
                nuConseSig := SEQ_FACTURA_ELECT_GEN_CONSVENT.NEXTVAL;
            END IF;
            v_styConsecutivo := pkg_recofael.frcgetRecord( inuTipoDocu,
                                                           nuConseSig,
                                                           'A',
                                                           nuError,
                                                           sbError );

            IF nuError <> 0 THEN
               pkg_error.setErrorMessage(isbMsgErrr => sbError);
            END IF;

            pkg_recofael.prActualizaCons( v_styConsecutivo.codigo,
                                         nuConseSig,
                                         nuError ,
                                         sbError );

           IF nuError <> 0 THEN
              ROLLBACK;
               pkg_error.setErrorMessage(isbMsgErrr => sbError);
           ELSE
               COMMIT;
               prSetConsecutivo( nuConseSig );
           END IF;
       ELSE
           IF cuGetInfoFactura%ISOPEN THEN CLOSE cuGetInfoFactura; END IF;
           regFactura := regFacturanull;
           OPEN cuGetInfoFactura;
           FETCH cuGetInfoFactura INTO regFactura;
           IF cuGetInfoFactura%NOTFOUND THEN
              CLOSE cuGetInfoFactura;
              pkg_error.setErrorMessage(isbMsgErrr => 'Factura ['||inuFactura||'] no existe en el proceso de facturacion electronica');
           END IF;
           CLOSE cuGetInfoFactura;

           nuConseSig := regFactura.CONSFAEL;
           v_styConsecutivo := pkg_recofael.frcgetRecord( inuTipoDocu,
                                                          nuConseSig,
                                                          'T',
                                                          nuError,
                                                          sbError );
           IF nuError <> 0 THEN
              pkg_error.setErrorMessage(isbMsgErrr => sbError);
           END IF;

           prSetConsecutivo( nuConseSig );
       END IF;

        gsbResolucion     := v_styConsecutivo.resolucion;
        gnuConsInicial    := v_styConsecutivo.cons_inicial;
        gnuConsFinal      := v_styConsecutivo.cons_final;
        gdtFechaResol     := v_styConsecutivo.fecha_resolucion;
        gdtFechaIniVige   := v_styConsecutivo.fecha_ini_vigencia;
        gdtFechaFinVige   := v_styConsecutivo.fecha_fin_vigencia;

       pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prObtenerConsetivo;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' inuTipoDocu => ' || inuTipoDocu, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' isbOperacion => ' || isbOperacion, pkg_traza.cnuNivelTrzDef);
    sbNumeroCompleto := null;
    v_styConsecutivo := v_styConsecutivonull;

    prObtenerConsetivo;
    sbPrefijo        := v_styConsecutivo.prefijo;
    sbNumeroCompleto := sbPrefijo||fnuGetConsecutivo;
    IF fnuGetConsecutivo IS NULL THEN
        pkg_error.setErrorMessage(isbMsgErrr => 'No existe consecutivo de facturacion electronica');
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
  END ;
  PROCEDURE prGetInfoCanalUno( inuFactura       IN   NUMBER,
                               inuTipoDocu      IN  NUMBER,
                               ioCblSpool       IN OUT CLOB,
                               OtytCanalUno     OUT  tytCanalUno,
                               OtytCanalUnoCon  OUT  tytCanalUno,
                               OnuContrato      OUT  NUMBER,
                               osbRutaReparto   OUT  VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalUno
    Descripcion     : retorna informacion para canal uno facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 09-01-2024

    Parametros de Entrada
      inuFactura       codigo de la factura
      inuTipoDocu      tipo de documento
      isbOperacion     Operacion a realizar I - Insertar A -Actualizar
    Parametros de Salida
      ioCblSpool       estructura spool
      OtytCanalUno     registro de canal uno
      OtytCanalUnoCon  registro de canal uno contigencia
      OnuContrato     numero de contrato
      osbRutaReparto   ruta de reparto
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        09-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalUno';

    v_tytCanalUnoNull tytCanalUno;

    sbFechaIniPeri   VARCHAR2(30);
    sbFechaFinPeri   VARCHAR2(30);
    sbHoraIniPeri    VARCHAR2(30);
    sbHoraFinPeri    VARCHAR2(30);
    sbFechaGenera    VARCHAR2(30);
    nuContrato       NUMBER;
    onuError         NUMBER;
    osbError         VARCHAR2(4000);
    nuTipoDocu      NUMBER;

    SBFechaVenc      varchar2(50);

    CURSOR cuGetFechaPeriodo IS
    SELECT to_char(factura.factfege,'yyyy-MM')||'-01' fecha_inicial,
           to_char(last_day(factura.factfege),'yyyy-MM-DD') fecha_final,
           to_char(factura.factfege,'HH:MM:SS')||'-05:00' hora_inicial,
           to_char(perifact.pefaffmo,'HH:MM:SS')||'-05:00' hora_final,
           factura.factsusc,
           to_char(factura.factfege,'yyyy-MM-DD') fecha_gene
    FROM perifact, factura
    WHERE perifact.pefacodi = factpefa
     AND factura.factcodi = inuFactura;

	CURSOR cuGetFechaPeriodoNota IS
    SELECT to_char(notas.notafecr, 'yyyy-MM')||'-01' fecha_inicial,
           to_char(last_day(notas.notafecr ),'yyyy-MM-DD') fecha_final,
           to_char(notas.notafecr,'HH:MM:SS')||'-05:00' hora_inicial,
           to_char(notas.notafecr ,'HH:MM:SS')||'-05:00' hora_final,
           factura.factsusc,
           to_char(notas.notafecr, 'yyyy-MM-DD') fecha_gene,
			factura.factcodi
    FROM notas, factura
    WHERE notas.notanume = inuFactura
     AND factura.factcodi = notas.notafact;


    CURSOR cuGetFechaVenci(inuFactu NUMBER) IS
    SELECT to_char(cucofeve, 'yyyy-MM-DD')
    FROM cuencobr
    WHERE cucofact = inuFactu;


    nuTotalPagar  NUMBER;
    nuFactura   NUMBER;

    PROCEDURE prCloseCursor IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prCloseCursor';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF cuGetFechaPeriodo%ISOPEN THEN
           CLOSE cuGetFechaPeriodo;
        END IF;

        IF cuGetFechaVenci%ISOPEN THEN
           CLOSE cuGetFechaVenci;
        END IF;
		IF cuGetFechaPeriodoNota%ISOPEN then
		  CLOSE cuGetFechaPeriodoNota;
		END IF;

        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;

    PROCEDURE prInicializaDatos IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prInicializaDatos';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        sbFechaIniPeri := '';
        sbFechaFinPeri := '';
        sbHoraIniPeri  := '';
        sbHoraFinPeri  := '';
        nuTotalPagar   := 0;
         nuFactura := null;
        OtytCanalUno := v_tytCanalUnoNull;
        nuContrato := NULL;
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializaDatos;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);

    prInicializaDatos;
    prCloseCursor;


    OtytCanalUno.NroCanal						 := 1;
    OtytCanalUno.NumeroCompleto                  := sbNumeroCompleto;
    nuTipoDocu := inuTipoDocu;

    IF inuTipoDocu = cnuTipoDocuNotas THEN

		OPEN cuGetFechaPeriodoNota;
		FETCH cuGetFechaPeriodoNota INTO sbFechaIniPeri, sbFechaFinPeri, sbHoraIniPeri, sbHoraFinPeri, nuContrato, sbFechaGenera, nuFactura;
		CLOSE cuGetFechaPeriodoNota;

	    IF sbTipoNota = 'C' THEN
            OtytCanalUno.TipoDocumento           := csbTipoDocuNotaCre;
            IF nuFacturaAso IS NULL THEN
               OtytCanalUno.TipoOperacion        := csbTipoOperNotaCreSf;
            ELSE
              OtytCanalUno.TipoOperacion         := csbTipoOperNotaCreCf;
            END IF;
             OtytCanalUno.CodigoConceptoNota     := csbCodConcNotaCre;
            OtytCanalUno.DescripcionConceptoNota := csbDescNotaCre;
        ELSE
           OtytCanalUno.TipoDocumento            := csbTipoDocuNotaDeb;

           IF nuFacturaAso IS NULL THEN
               OtytCanalUno.TipoOperacion        := csbTipoOperNotaDebSf;
           ELSE
              OtytCanalUno.TipoOperacion         := csbTipoOperNotaDebCf;
           END IF;
            OtytCanalUno.CodigoConceptoNota      := csbCodConcNotaDeb ;
            OtytCanalUno.DescripcionConceptoNota := csbDescNotaDeb;
        END IF;
        OtytCanalUno.FacturaAsociada             := nuFacturaAso;
        OtytCanalUno.FechaFacturaAsociada        := to_char(dtFechaAso,'yyyy-MM-DD');
        gsbArteFactura := csbArteNotas;
    ELSE

        OPEN cuGetFechaPeriodo;
        FETCH cuGetFechaPeriodo INTO sbFechaIniPeri, sbFechaFinPeri, sbHoraIniPeri, sbHoraFinPeri, nuContrato, sbFechaGenera;
        CLOSE cuGetFechaPeriodo;
	    nuFactura := inuFactura;

        IF cnuTipoDocuFactRecu = inuTipoDocu THEN
            IF NOT ldc_detallefact_gascaribe.fblNoRegulado(nuContrato) THEN
                gsbArteFactura := csbArteFactRecurr;
            ELSE
               gsbArteFactura := csbArteFactRecurrnR;
               nuTipoDocu  := 4;
            END IF;
        ELSE
           gsbArteFactura := csbArteFactVenta;
        END IF;

		OtytCanalUno.TipoDocumento               := csbTipoDocumento;

        IF gsbTipoDocuAiu = 'N' THEN
           OtytCanalUno.TipoOperacion            := csbTipoOperacion;
        ELSE
           OtytCanalUno.TipoOperacion            := csbTipoOperacionAiu;
        END IF;
        OtytCanalUno.FacturaAsociada             := '';
        OtytCanalUno.FechaFacturaAsociada        := '';
    END IF;

	OPEN cuGetFechaVenci(nuFactura);
  FETCH cuGetFechaVenci INTO SBFechaVenc;
  CLOSE cuGetFechaVenci;

  pkg_traza.trace('nuTipoDocu => ' || nuTipoDocu, pkg_traza.cnuNivelTrzDef);

	OnuContrato      := nuContrato;
    osbRutaReparto   := v_tytInfoDatosCliente.ruta;


    OtytCanalUno.Ambiente                        := fsbGetAmbiente;
    OtytCanalUno.Prefijo                         := sbPrefijo;
    OtytCanalUno.NumeroDocumento                 := nuConsecutivo;
    OtytCanalUno.FechaDocumento                  := sbFechaGenera;
    OtytCanalUno.HoraDocumento                   := '00:00:00-05:00';

    OtytCanalUno.SeccionCorreccion               := '';
    OtytCanalUno.TipoMoneda                      := csbTipoMoneda;
    OtytCanalUno.NumeroLineas                    := gnuContadorLinea;
    OtytCanalUno.FormaPago                       := csbFormaPago;
    OtytCanalUno.CodigoMedioPago                 := '';
    OtytCanalUno.DescripcionMedioPago            := '';
    OtytCanalUno.FechaVencimiento                := SBFechaVenc;
    OtytCanalUno.FechaInicalPeriodoFacturacion   := sbFechaIniPeri;
    OtytCanalUno.HoraInicalPeriodoFacturacion    := sbHoraIniPeri;
    OtytCanalUno.FechaFinalPeriodoFacturacion    := sbFechaFinPeri;
    OtytCanalUno.HoraFinalPeriodoFacturacion     := sbHoraFinPeri;
    OtytCanalUno.TotalValorBruto                 := TRIM(TO_CHAR(gnuValorTotal,'9999999999999999990.90')) ;
    OtytCanalUno.TotalValorBaseImponible         := TRIM(TO_CHAR(gnuValorBaseTotal,'9999999999999999990.90')) ;
    OtytCanalUno.TotalValorBrutoMasTributos      := TRIM(TO_CHAR(gnuValorTotal + nvl(gnuValorTotalIva,0),'9999999999999999990.90')) ;
    OtytCanalUno.TotalDescuentos                 := TRIM(TO_CHAR(abs(gnuValorDescuento),'9999999999999999990.90'))  ;
    OtytCanalUno.TotalCargos                     := '' ;
    OtytCanalUno.TotalAnticipos                  := csbTotalAnticipo;
    OtytCanalUno.Redondeo                        := csbRedondeo;
    nuTotalPagar                                 := (gnuValorTotal + nvl(gnuValorTotalIva,0) - nvl(abs(gnuValorDescuento),0));
    IF nuTotalPagar < 0 then
       nuTotalPagar := 0;
    END IF;
    OtytCanalUno.TotalAPagar                     := TRIM(TO_CHAR( nuTotalPagar,'9999999999999999990.90')) ;
    OtytCanalUno.ValorLetras                     := '';
    OtytCanalUno.ReferenciaPago                  := v_tytInfoDatosCliente.CUPON;
    OtytCanalUno.SaldoFavor                      := v_tytInfoDatosCliente.SALDO_FAVOR;
    OtytCanalUno.CantidadFacturasVencidas        := v_tytInfoDatosCliente.MESES_DEUDA;
    OtytCanalUno.FacturasVencidas                := v_tytInfoAdicional.SALDO_ANTE ;
    OtytCanalUno.NumeroContrato                  := nuContrato;
    OtytCanalUno.OrdenCompraFactura              := '';
    OtytCanalUno.FechaOrdenCompra                := '';
    OtytCanalUno.OrdenDespacho                   := '';
    OtytCanalUno.FechaOrdenDespacho              := '';
    OtytCanalUno.DocumentoRecepcion              := '';
    OtytCanalUno.FechaDocumentoRecepcion         := '';
    OtytCanalUno.Observaciones                   := '';
    OtytCanalUno.CodigoCentroCostos              := '';
    OtytCanalUno.NombreCentroCostos              := '';
    OtytCanalUno.MesFacturado                    := v_tytInfoDatosCliente.MES_FACT;
    OtytCanalUno.PeriodoFacturado                := v_tytInfoDatosCliente.PERIODO_FACT ;
    OtytCanalUno.DiasDeConsumo                   := v_tytInfoDatosCliente.DIAS_CONSUMO;
    OtytCanalUno.NumeroDeControl                 := v_tytInfoDatosCliente.NUM_CONTROL;
    OtytCanalUno.PeriodoDeConsumo                := v_tytInfoDatosCliente.PERIODO_CONSUMO;
    OtytCanalUno.ValorEnReclamo                  := v_tytInfoDatosCliente.VALOR_RECL;
    OtytCanalUno.CupoBrilla                      := v_tytInfoDatosCliente.CUPO_BRILLA;
    OtytCanalUno.LecturaAnterior                 := v_tytInfoDatosLectura.LECTURA_ANTERIOR;
    OtytCanalUno.LecturaActual                   := v_tytInfoDatosLectura.LECTURA_ACTUAL;
    OtytCanalUno.CausalNoLectura                 := v_tytInfoDatosLectura.OBS_LECTURA;
    OtytCanalUno.ConsumoActual                   := v_tytInfoDatosConsumo.CONS_CORREG;
    OtytCanalUno.FactordeCorreccion              := v_tytInfoDatosConsumo.FACTOR_CORRECCION;
    OtytCanalUno.FechaSuspMora                   := v_tytInfoDatosCliente.FECHA_SUSPENSION;
    OtytCanalUno.NumeroFacturaInter              := inuFactura;
    OtytCanalUno.ValorTotalXPagar                := v_tytInfoDatosCliente.TOTAL_FACTURA;
    OtytCanalUno.ValorTotalFacturaMes            := v_tytInfoTotales.CARGOSMES;
    OtytCanalUno.ObservacionNotas                := gsbObservacionNota;
    OtytCanalUno.Calificacion                    := sbcalificacion;
    OtytCanalUno.NoUsar06                        := '';
    OtytCanalUno.NoUsar07                        := '';
    OtytCanalUno.NoUsar08                        := '';
    OtytCanalUno.NoUsar09                        := '';
    OtytCanalUno.NoUsar10                        := '';
    OtytCanalUno.NoUsar11                        := '';
    OtytCanalUno.PromedioDeConsumo               := v_tytInfoDatosConsumo.CONSUMO_PROMEDIO;
    OtytCanalUno.Temperatura                     := v_tytInfoDatosConsumo.TEMPERATURA;
    OtytCanalUno.Presion                         := v_tytInfoDatosConsumo.PRESION;
    OtytCanalUno.ConsumoEnKWh                    := v_tytInfoDatosConsumo.EQUIVAL_KWH;
    OtytCanalUno.CalculoDeConsumo                := v_tytInfoDatosConsumo.CALCCONS;
    OtytCanalUno.TipoDeNotificacion              := v_tytInfoDatosRevPer.TIPO_NOTI;
    OtytCanalUno.MensajeGeneral                  := v_tytInfoDatosRevPer.MENS_NOTI;
    OtytCanalUno.PlazoMaxRP                      := v_tytInfoDatosRevPer.FECH_MAXIMA;
    OtytCanalUno.SuspensionporRP                 := v_tytInfoDatosRevPer.FECH_SUSP;
    OtytCanalUno.ComponentesdelCosto             := v_tytInfoCompCost.COMPCOST;
    OtytCanalUno.ReferenciaKPIsCalidad           := v_tytInfoCompCost.VALORESREF;
    OtytCanalUno.CalculoKPIsCalidad              := v_tytInfoCompCost.VALCALC;
    OtytCanalUno.CodigoBarrasId                  := v_tytInfoCupon.CODIGO_1;
    OtytCanalUno.CodigoBarrasRef_Pago            := v_tytInfoCupon.CODIGO_2;
    OtytCanalUno.CodigoBarrasValor               := v_tytInfoCupon.CODIGO_3;
    OtytCanalUno.CodigoBarrasFechalimite         := v_tytInfoCupon.CODIGO_4;
    OtytCanalUno.CodigoBarrasCompleto            := v_tytInfoCupon.COD_BAR;
    OtytCanalUno.TRMUltima                       := v_tytInfoAdicional.TASA_ULTIMA;
    OtytCanalUno.TRMPromedio                     := v_tytInfoAdicional.TASA_PROMEDIO;
    OtytCanalUno.Visible                         := v_tytInfoAdicional.VISIBLE;
    OtytCanalUno.Impreso                         := v_tytInfoAdicional.IMPRESO;
    OtytCanalUno.ProteccionDeDatos               := v_tytInfoAdicional.PROTECCION_ESTADO;
    OtytCanalUno.DireccionProducto               := v_tytInfoDatosAdicional.DIRECCION_PRODUCTO;
    OtytCanalUno.CausaPromedio                   := v_tytInfoDatosAdicional.CAUSA_DESVIACION;
    OtytCanalUno.PagareUnico                     := v_tytInfoDatosAdicional.PAGARE_UNICO;
    OtytCanalUno.CambioUso                       := v_tytInfoDatosAdicional.CAMBIOUSO;
    OtytCanalUno.AcumuladoTarifaTransitoria      := v_tytInfoAdicional.ACUMU_TATT;
    OtytCanalUno.FinanciacionEspecial            := v_tytInfoAdicional.FINAESPE;
    OtytCanalUno.MedidorMalUbicado               := v_tytInfoAdicional.MED_MAL_UBICADO;
    OtytCanalUno.ImprimirFactura                 := v_tytInfoAdicional.IMPRIMEFACT;
    OtytCanalUno.ValorUltimoPago                 := v_tytInfoAdicional.VALOR_ULT_PAGO;
    OtytCanalUno.FechaUltimoPago                 := v_tytInfoAdicional.FECHA_ULT_PAGO;
    OtytCanalUno.CantidadLineas                  := gnuCantConc;
    OtytCanalUno.CondicionPago                   := NULL;
    OtytCanalUno.NIU                             := NULL;
    OtytCanalUno.TipoProducto                    := NULL;
    OtytCanalUno.ObservacionNoLectura            := v_tytInfoAdicional.OBSERV_NO_LECT_CONSEC;
    OtytCanalUno.ContratistaReparto              := v_tytInfoAdicional.CUADRILLA_REPARTO;
    OtytCanalUno.InteresMora                     := '';
    OtytCanalUno.PoderCalorifico                 := '';
    OtytCanalUno.ConsumoKWh                      := '';
    OtytCanalUno.ImprimirTijera                  := '';
    OtytCanalUno.BancoUltimoPago                 := '';
    OtytCanalUno.Tarifa_GM                       := '';
    OtytCanalUno.Tarifa_TM                       := '';
    OtytCanalUno.Tarifa_DM                       := '';
    OtytCanalUno.Tarifa_CV                       := '';
    OtytCanalUno.Tarifa_CC                       := '';
    OtytCanalUno.Tarifa_CVARIABLE                := '';
    OtytCanalUno.Tarifa_AS                       := '';
    OtytCanalUno.Tarifa_PORCSU                   := '';
    OtytCanalUno.Tarifa_SUBSIDIADA               := '';
    OtytCanalUno.Tarifa_DS                       := '';
    OtytCanalUno.Tarifa_CFIJO                    := '';
    OtytCanalUno.MesesRevisionTecReg             := '';
    OtytCanalUno.NumeroHojas                     := '';
    OtytCanalUno.FechaFinaExcencion              := '';
    OtytCanalUno.PresionAtmosferica              := '';
    OtytCanalUno.MensajePromocion                := '';
    OtytCanalUno.TipoNotificacion                := '';
    OtytCanalUno.MensajeRevisionSegura           := '';
    OtytCanalUno.CampanaID                       := '';
    OtytCanalUno.FactImagen                      := '';
    OtytCanalUno.TotalGas                        := v_tytInfoTotales.SUBTOTAL;
    OtytCanalUno.TotalBrilla                     := '';
    OtytCanalUno.TotalOtrosServicios             := '';
    OtytCanalUno.TotalCapital                    := '';
    OtytCanalUno.TotalIntereses                  := '';
    OtytCanalUno.TotalSaldoDiferidos             := '';
    OtytCanalUno.NombreArte                      := gsbArteFactura;
    OtytCanalUno.TipoFacturaElectrónica          := nuTipoDocu;
    OtytCanalUno.QRPago                          := csbQrPago||v_tytInfoCupon.CODIGO_2;

	--se arma plano de contigencia
    OtytCanalUnoCon.NroCanal					    := 1;
    OtytCanalUnoCon.NumeroCompleto         	        := '<FACTURA_CONTINGENCIA>';
    OtytCanalUnoCon.TipoDocumento          	        := csbTipoDocumentoCont;
    OtytCanalUnoCon.FacturaAsociada                 := '<FACTURA_CONTINGENCIA>';
    OtytCanalUnoCon.FechaFacturaAsociada            := OtytCanalUno.FechaDocumento ;

    IF gsbTipoDocuAiu = 'N' THEN
       OtytCanalUnoCon.TipoOperacion                := csbTipoOperacion;
    ELSE
      OtytCanalUnoCon.TipoOperacion                 := csbTipoOperacionAiu;
    END IF;

    OtytCanalUnoCon.Ambiente                        := fsbGetAmbiente;
    OtytCanalUnoCon.Prefijo                         := '<PREFIJO_CONTIGENCIA>';
    OtytCanalUnoCon.NumeroDocumento                 := '<CONSECUTIVO_CONTINGENCIA>';
    OtytCanalUnoCon.FechaDocumento                  := sbFechaGenera;
    OtytCanalUnoCon.HoraDocumento                   := '00:00:00-05:00';
    OtytCanalUnoCon.CodigoConceptoNota              := '';
    OtytCanalUnoCon.DescripcionConceptoNota         := '';
    OtytCanalUnoCon.SeccionCorreccion               := '';
    OtytCanalUnoCon.TipoMoneda                      := csbTipoMoneda;
    OtytCanalUnoCon.NumeroLineas                    := gnuContadorLinea;
    OtytCanalUnoCon.FormaPago                       := csbFormaPago;
    OtytCanalUnoCon.CodigoMedioPago                 := '';
    OtytCanalUnoCon.DescripcionMedioPago            := '';
    OtytCanalUnoCon.FechaVencimiento                := SBFechaVenc;
    OtytCanalUnoCon.FechaInicalPeriodoFacturacion   := sbFechaIniPeri;
    OtytCanalUnoCon.HoraInicalPeriodoFacturacion    := sbHoraIniPeri;
    OtytCanalUnoCon.FechaFinalPeriodoFacturacion    := sbFechaFinPeri;
    OtytCanalUnoCon.HoraFinalPeriodoFacturacion     := sbHoraFinPeri;
    OtytCanalUnoCon.TotalValorBruto                 := TRIM(TO_CHAR(gnuValorTotal,'9999999999999999990.90')) ;
    OtytCanalUnoCon.TotalValorBaseImponible         := TRIM(TO_CHAR(gnuValorBaseTotal,'9999999999999999990.90')) ;
    OtytCanalUnoCon.TotalValorBrutoMasTributos      := TRIM(TO_CHAR(gnuValorTotal + nvl(gnuValorTotalIva,0),'9999999999999999990.90')) ;
    OtytCanalUnoCon.TotalDescuentos                 := TRIM(TO_CHAR(abs(gnuValorDescuento),'9999999999999999990.90'))  ;
    OtytCanalUnoCon.TotalCargos                     := '' ;
    OtytCanalUnoCon.TotalAnticipos                  := csbTotalAnticipo;
    OtytCanalUnoCon.Redondeo                        := csbRedondeo;
    nuTotalPagar                                 := (gnuValorTotal + nvl(gnuValorTotalIva,0) - nvl(abs(gnuValorDescuento),0));
    IF nuTotalPagar < 0 then
    nuTotalPagar := 0;
    END IF;
    OtytCanalUnoCon.TotalAPagar                     := TRIM(TO_CHAR( nuTotalPagar,'9999999999999999990.90')) ;
    OtytCanalUnoCon.ValorLetras                     := '';
    OtytCanalUnoCon.ReferenciaPago                  := v_tytInfoDatosCliente.CUPON;
    OtytCanalUnoCon.SaldoFavor                      := v_tytInfoDatosCliente.SALDO_FAVOR;
    OtytCanalUnoCon.CantidadFacturasVencidas        := v_tytInfoDatosCliente.MESES_DEUDA;
    OtytCanalUnoCon.FacturasVencidas                := v_tytInfoAdicional.SALDO_ANTE ;
    OtytCanalUnoCon.NumeroContrato                  := nuContrato;
    OtytCanalUnoCon.OrdenCompraFactura              := '';
    OtytCanalUnoCon.FechaOrdenCompra                := '';
    OtytCanalUnoCon.OrdenDespacho                   := '';
    OtytCanalUnoCon.FechaOrdenDespacho              := '';
    OtytCanalUnoCon.DocumentoRecepcion              := '';
    OtytCanalUnoCon.FechaDocumentoRecepcion         := '';
    OtytCanalUnoCon.Observaciones                   := '';
    OtytCanalUnoCon.CodigoCentroCostos              := '';
    OtytCanalUnoCon.NombreCentroCostos              := '';
    OtytCanalUnoCon.MesFacturado                    := v_tytInfoDatosCliente.MES_FACT;
    OtytCanalUnoCon.PeriodoFacturado                := v_tytInfoDatosCliente.PERIODO_FACT ;
    OtytCanalUnoCon.DiasDeConsumo                   := v_tytInfoDatosCliente.DIAS_CONSUMO;
    OtytCanalUnoCon.NumeroDeControl                 := v_tytInfoDatosCliente.NUM_CONTROL;
    OtytCanalUnoCon.PeriodoDeConsumo                := v_tytInfoDatosCliente.PERIODO_CONSUMO;
    OtytCanalUnoCon.ValorEnReclamo                  := v_tytInfoDatosCliente.VALOR_RECL;
    OtytCanalUnoCon.CupoBrilla                      := v_tytInfoDatosCliente.CUPO_BRILLA;
    OtytCanalUnoCon.LecturaAnterior                 := v_tytInfoDatosLectura.LECTURA_ANTERIOR;
    OtytCanalUnoCon.LecturaActual                   := v_tytInfoDatosLectura.LECTURA_ACTUAL;
    OtytCanalUnoCon.CausalNoLectura                 := v_tytInfoDatosLectura.OBS_LECTURA;
    OtytCanalUnoCon.ConsumoActual                   := v_tytInfoDatosConsumo.CONS_CORREG;
    OtytCanalUnoCon.FactordeCorreccion              := v_tytInfoDatosConsumo.FACTOR_CORRECCION;
    OtytCanalUnoCon.FechaSuspMora                   := v_tytInfoDatosCliente.FECHA_SUSPENSION;
    OtytCanalUnoCon.NumeroFacturaInter              := inuFactura;
    OtytCanalUnoCon.ValorTotalXPagar                := v_tytInfoDatosCliente.TOTAL_FACTURA;
    OtytCanalUnoCon.ValorTotalFacturaMes            := v_tytInfoTotales.CARGOSMES;
    OtytCanalUnoCon.ObservacionNotas                := gsbObservacionNota;
    OtytCanalUnoCon.Calificacion                    := sbcalificacion;
    OtytCanalUnoCon.NoUsar06                        := '';
    OtytCanalUnoCon.NoUsar07                        := '';
    OtytCanalUnoCon.NoUsar08                        := '';
    OtytCanalUnoCon.NoUsar09                        := '';
    OtytCanalUnoCon.NoUsar10                        := '';
    OtytCanalUnoCon.NoUsar11                        := '';
    OtytCanalUnoCon.PromedioDeConsumo               := v_tytInfoDatosConsumo.CONSUMO_PROMEDIO;
    OtytCanalUnoCon.Temperatura                     := v_tytInfoDatosConsumo.TEMPERATURA;
    OtytCanalUnoCon.Presion                         := v_tytInfoDatosConsumo.PRESION;
    OtytCanalUnoCon.ConsumoEnKWh                    := v_tytInfoDatosConsumo.EQUIVAL_KWH;
    OtytCanalUnoCon.CalculoDeConsumo                := v_tytInfoDatosConsumo.CALCCONS;
    OtytCanalUnoCon.TipoDeNotificacion              := v_tytInfoDatosRevPer.TIPO_NOTI;
    OtytCanalUnoCon.MensajeGeneral                  := v_tytInfoDatosRevPer.MENS_NOTI;
    OtytCanalUnoCon.PlazoMaxRP                      := v_tytInfoDatosRevPer.FECH_MAXIMA;
    OtytCanalUnoCon.SuspensionporRP                 := v_tytInfoDatosRevPer.FECH_SUSP;
    OtytCanalUnoCon.ComponentesdelCosto             := v_tytInfoCompCost.COMPCOST;
    OtytCanalUnoCon.ReferenciaKPIsCalidad           := v_tytInfoCompCost.VALORESREF;
    OtytCanalUnoCon.CalculoKPIsCalidad              := v_tytInfoCompCost.VALCALC;
    OtytCanalUnoCon.CodigoBarrasId                  := v_tytInfoCupon.CODIGO_1;
    OtytCanalUnoCon.CodigoBarrasRef_Pago            := v_tytInfoCupon.CODIGO_2;
    OtytCanalUnoCon.CodigoBarrasValor               := v_tytInfoCupon.CODIGO_3;
    OtytCanalUnoCon.CodigoBarrasFechalimite         := v_tytInfoCupon.CODIGO_4;
    OtytCanalUnoCon.CodigoBarrasCompleto            := v_tytInfoCupon.COD_BAR;
    OtytCanalUnoCon.TRMUltima                       := v_tytInfoAdicional.TASA_ULTIMA;
    OtytCanalUnoCon.TRMPromedio                     := v_tytInfoAdicional.TASA_PROMEDIO;
    OtytCanalUnoCon.Visible                         := v_tytInfoAdicional.VISIBLE;
    OtytCanalUnoCon.Impreso                         := v_tytInfoAdicional.IMPRESO;
    OtytCanalUnoCon.ProteccionDeDatos               := v_tytInfoAdicional.PROTECCION_ESTADO;
    OtytCanalUnoCon.DireccionProducto               := v_tytInfoDatosAdicional.DIRECCION_PRODUCTO;
    OtytCanalUnoCon.CausaPromedio                   := v_tytInfoDatosAdicional.CAUSA_DESVIACION;
    OtytCanalUnoCon.PagareUnico                     := v_tytInfoDatosAdicional.PAGARE_UNICO;
    OtytCanalUnoCon.CambioUso                       := v_tytInfoDatosAdicional.CAMBIOUSO;
    OtytCanalUnoCon.AcumuladoTarifaTransitoria      := v_tytInfoAdicional.ACUMU_TATT;
    OtytCanalUnoCon.FinanciacionEspecial            := v_tytInfoAdicional.FINAESPE;
    OtytCanalUnoCon.MedidorMalUbicado               := v_tytInfoAdicional.MED_MAL_UBICADO;
    OtytCanalUnoCon.ImprimirFactura                 := v_tytInfoAdicional.IMPRIMEFACT;
    OtytCanalUnoCon.ValorUltimoPago                 := v_tytInfoAdicional.VALOR_ULT_PAGO;
    OtytCanalUnoCon.FechaUltimoPago                 := v_tytInfoAdicional.FECHA_ULT_PAGO;
    OtytCanalUnoCon.CantidadLineas                  := gnuCantConc;
    OtytCanalUnoCon.CondicionPago                   := NULL;
    OtytCanalUnoCon.NIU                             := NULL;
    OtytCanalUnoCon.TipoProducto                    := NULL;
    OtytCanalUnoCon.ObservacionNoLectura            := v_tytInfoAdicional.OBSERV_NO_LECT_CONSEC;
    OtytCanalUnoCon.ContratistaReparto              := v_tytInfoAdicional.CUADRILLA_REPARTO;
    OtytCanalUnoCon.InteresMora                     := '';
    OtytCanalUnoCon.PoderCalorifico                 := '';
    OtytCanalUnoCon.ConsumoKWh                      := '';
    OtytCanalUnoCon.ImprimirTijera                  := '';
    OtytCanalUnoCon.BancoUltimoPago                 := '';
    OtytCanalUnoCon.Tarifa_GM                       := '';
    OtytCanalUnoCon.Tarifa_TM                       := '';
    OtytCanalUnoCon.Tarifa_DM                       := '';
    OtytCanalUnoCon.Tarifa_CV                       := '';
    OtytCanalUnoCon.Tarifa_CC                       := '';
    OtytCanalUnoCon.Tarifa_CVARIABLE                := '';
    OtytCanalUnoCon.Tarifa_AS                       := '';
    OtytCanalUnoCon.Tarifa_PORCSU                   := '';
    OtytCanalUnoCon.Tarifa_SUBSIDIADA               := '';
    OtytCanalUnoCon.Tarifa_DS                       := '';
    OtytCanalUnoCon.Tarifa_CFIJO                    := '';
    OtytCanalUnoCon.MesesRevisionTecReg             := '';
    OtytCanalUnoCon.NumeroHojas                     := '';
    OtytCanalUnoCon.FechaFinaExcencion              := '';
    OtytCanalUnoCon.PresionAtmosferica              := '';
    OtytCanalUnoCon.MensajePromocion                := '';
    OtytCanalUnoCon.TipoNotificacion                := '';
    OtytCanalUnoCon.MensajeRevisionSegura           := '';
    OtytCanalUnoCon.CampanaID                       := '';
    OtytCanalUnoCon.FactImagen                      := '';
    OtytCanalUnoCon.TotalGas                        := v_tytInfoTotales.SUBTOTAL;
    OtytCanalUnoCon.TotalBrilla                     := '';
    OtytCanalUnoCon.TotalOtrosServicios             := '';
    OtytCanalUnoCon.TotalCapital                    := '';
    OtytCanalUnoCon.TotalIntereses                  := '';
    OtytCanalUnoCon.TotalSaldoDiferidos             := '';
    OtytCanalUnoCon.NombreArte                      := gsbArteFactura;
    OtytCanalUnoCon.TipoFacturaElectrónica          := nuTipoDocu;
    OtytCanalUnoCon.QRPago                          := csbQrPago||v_tytInfoCupon.CODIGO_2;

    ioCblSpool := ioCblSpool||'|'||TRIM(TO_CHAR( nuTotalPagar,'FM999,999,999,990'))||'|'||TRIM(TO_CHAR(nvl(gnuValorTotalIva,0),'FM999,999,999,990'))||'|'||gnuContadorLinea||'|'||gsbResolucion||'|'|| to_char(gdtFechaResol,'YYYY-MM-DD')||'|'|| sbPrefijo||'|'||gnuConsInicial
                   ||'|'|| gnuConsFinal ||'|'|| to_char(gdtFechaIniVige,'YYYY-MM-DD')||'|'|| to_char(gdtFechaFinVige,'YYYY-MM-DD')||'|'|| sbNumeroCompleto||'|';
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(nuError,sbError);
      prCloseCursor;
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       prCloseCursor;
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE pkg_error.CONTROLLED_ERROR;
  END prGetInfoCanalUno;

  PROCEDURE prGetInfoCanalUnoA( inuFactura       IN   NUMBER,
                                OtytCanalUnoA    OUT  tytCanalUnoA) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalUnoA
    Descripcion     : retorna informacion para canal uno a facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 09-01-2024

    Parametros de Entrada
      inuFactura       codigo de la factura
    Parametros de Salida
      OtytCanalUnoA    tabla con registro de canal uno a

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalUnoA';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);

    OtytCanalUnoA.NroCanal				  := '1A';
    OtytCanalUnoA.NumeroCompleto		  := sbNumeroCompleto;
    OtytCanalUnoA.IdentificacionAnticipo  := '';
    OtytCanalUnoA.ValorAnticipo			  := '';
    OtytCanalUnoA.FechaReciboAnticipo     := '';
    OtytCanalUnoA.FechaPagoAnticipo       := '';
    OtytCanalUnoA.HoraPagoAnticipo        := '';
    OtytCanalUnoA.InstruccionesAnticipo   := '';

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
  END prGetInfoCanalUnoA;


  PROCEDURE prGetInfoCanalUnoB( inuFactura       IN   NUMBER,
                                OtytCanalUnoB    OUT  tytCanalUnoB) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalUnoA
    Descripcion     : retorna informacion para canal uno a facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 09-01-2024

    Parametros de Entrada
      inuFactura       codigo de la factura
    Parametros de Salida
      OtytCanalUnoB    tabla con registro de canal uno b

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalUnoB';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);

    OtytCanalUnoB.NroCanal						 := '1B';
    OtytCanalUnoB.NumeroCompleto                 := sbNumeroCompleto;
    IF gnuValorDescuento <> 0 THEN
        OtytCanalUnoB.TipoDescuentoCargo             := 'false';
        OtytCanalUnoB.IdentificacionDescuentoCargo   := 1;
        OtytCanalUnoB.CodigoDescuento                := cnuCodigoDescuento;
         OtytCanalUnoB.ObservacionDescuentoCargo      := '';
        OtytCanalUnoB.PorcentajeDescuentoCargo       := '100.00';
        OtytCanalUnoB.ValorTotalDescuentoCargo       := TRIM(TO_CHAR(ABS(gnuValorDescuento),'9999999999999999990.90'));
        OtytCanalUnoB.BaseDescuentoCargo             := TRIM(TO_CHAR(ABS(gnuValorDescuento),'9999999999999999990.90'));
    ELSE
        OtytCanalUnoB.TipoDescuentoCargo             := '';
        OtytCanalUnoB.IdentificacionDescuentoCargo   := '';
        OtytCanalUnoB.CodigoDescuento                := '';
        OtytCanalUnoB.ObservacionDescuentoCargo      := '';
        OtytCanalUnoB.PorcentajeDescuentoCargo       := '';
        OtytCanalUnoB.ValorTotalDescuentoCargo       := '';
        OtytCanalUnoB.BaseDescuentoCargo             := '';
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
  END prGetInfoCanalUnoB;

  PROCEDURE prGetInfoCanalOcho( otbltytCanalocho OUT  tbltytCanalocho) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalOcho
    Descripcion     : retorna informacion para canal ocho facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otbltytCanalocho    tabla con registro de canal ocho
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
   csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalOcho';
   sbIndex           VARCHAR2(40);
   sbIndexDato       VARCHAR2(40);
   nuContador        NUMBER := 0;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    otbltytCanalocho.delete;

    IF V_tbltytInfoRangos.COUNT > 0 THEN
        sbIndex := V_tbltytInfoRangos.FIRST;
        LOOP
            nuContador := nuContador + 1;
            sbIndexDato    := sbIndex||nuContador;
            otbltytCanalocho(sbIndexDato).NroCanal			:= '8';
            otbltytCanalocho(sbIndexDato).NumeroCompleto	:= sbNumeroCompleto;
            otbltytCanalocho(sbIndexDato).LimInferior		:= V_tbltytInfoRangos(sbIndex).LIM_INFERIOR;
            otbltytCanalocho(sbIndexDato).LimSuperior		:= V_tbltytInfoRangos(sbIndex).LIM_SUPERIOR;
            otbltytCanalocho(sbIndexDato).ValorUnidad		:= V_tbltytInfoRangos(sbIndex).VALOR_UNIDAD;
            otbltytCanalocho(sbIndexDato).ConsumoRango		:= V_tbltytInfoRangos(sbIndex).CONSUMO;
            otbltytCanalocho(sbIndexDato).ValorConsumoRango	:= V_tbltytInfoRangos(sbIndex).VAL_CONSUMO;

            sbIndex := V_tbltytInfoRangos.NEXT(sbIndex);
         EXIT WHEN sbIndex IS NULL;
        END LOOP;
    ELSE
        otbltytCanalocho(1).NroCanal			:= '8';
        otbltytCanalocho(1).NumeroCompleto	:= sbNumeroCompleto;
        otbltytCanalocho(1).LimInferior		:= '';
        otbltytCanalocho(1).LimSuperior		:= '';
        otbltytCanalocho(1).ValorUnidad		:= '';
        otbltytCanalocho(1).ConsumoRango	:= '';
        otbltytCanalocho(1).ValorConsumoRango := '';
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
  END prGetInfoCanalOcho;

   PROCEDURE prGetInfoCanalNueve( otbltytCanalNueve OUT  tbltytCanalNueve) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalNueve
    Descripcion     : retorna informacion para canal nueve facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otbltytCanalNueve    tabla con registro de canal nueve
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB	    29-08-2024   OSF-3202    Se coloca nuevo registro con el consumo actual
	LJLB        22-01-2024   OSF-2158    Creacion

  ***************************************************************************/
   csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalNueve';

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    otbltytCanalNueve.delete;
	otbltytCanalNueve(0).nroCanal		:= '9';
    otbltytCanalNueve(0).NumeroCompleto	:= sbNumeroCompleto;
    otbltytCanalNueve(0).IDOrdenamiento	:= 0;
    otbltytCanalNueve(0).FechaConsumo	:= CASE WHEN v_tytInfoDatosConsumo.FECHA_CONS_MES_1 IS NOT NULL THEN 'ACT' ELSE '' END;
    otbltytCanalNueve(0).Consumo		:= v_tytInfoDatosConsumo.CONS_CORREG;
    otbltytCanalNueve(0).DiasConsumo	:= NULL;


    otbltytCanalNueve(1).nroCanal		:= '9';
    otbltytCanalNueve(1).NumeroCompleto	:= sbNumeroCompleto;
    otbltytCanalNueve(1).IDOrdenamiento	:= 1;
    otbltytCanalNueve(1).FechaConsumo	:= v_tytInfoDatosConsumo.FECHA_CONS_MES_1;
    otbltytCanalNueve(1).Consumo			:= v_tytInfoDatosConsumo.CONSUMO_MES_1;
    otbltytCanalNueve(1).DiasConsumo		:= NULL;

    otbltytCanalNueve(2).nroCanal		:= '9';
    otbltytCanalNueve(2).NumeroCompleto	:= sbNumeroCompleto;
    otbltytCanalNueve(2).IDOrdenamiento	:= 2;
    otbltytCanalNueve(2).FechaConsumo	:= v_tytInfoDatosConsumo.FECHA_CONS_MES_2;
    otbltytCanalNueve(2).Consumo			:= v_tytInfoDatosConsumo.CONSUMO_MES_2;
    otbltytCanalNueve(2).DiasConsumo		:= NULL;

    otbltytCanalNueve(3).nroCanal		:= '9';
    otbltytCanalNueve(3).NumeroCompleto	:= sbNumeroCompleto;
    otbltytCanalNueve(3).IDOrdenamiento	:= 3;
    otbltytCanalNueve(3).FechaConsumo	:= v_tytInfoDatosConsumo.FECHA_CONS_MES_3;
    otbltytCanalNueve(3).Consumo			:= v_tytInfoDatosConsumo.CONSUMO_MES_3;
    otbltytCanalNueve(3).DiasConsumo		:= NULL;

    otbltytCanalNueve(4).nroCanal		:= '9';
    otbltytCanalNueve(4).NumeroCompleto	:= sbNumeroCompleto;
    otbltytCanalNueve(4).IDOrdenamiento	:= 4;
    otbltytCanalNueve(4).FechaConsumo	:= v_tytInfoDatosConsumo.FECHA_CONS_MES_4;
    otbltytCanalNueve(4).Consumo			:= v_tytInfoDatosConsumo.CONSUMO_MES_4;
    otbltytCanalNueve(4).DiasConsumo		:= NULL;

    otbltytCanalNueve(5).nroCanal		:= '9';
    otbltytCanalNueve(5).NumeroCompleto	:= sbNumeroCompleto;
    otbltytCanalNueve(5).IDOrdenamiento	:= 5;
    otbltytCanalNueve(5).FechaConsumo	:= v_tytInfoDatosConsumo.FECHA_CONS_MES_5;
    otbltytCanalNueve(5).Consumo			:= v_tytInfoDatosConsumo.CONSUMO_MES_5;
    otbltytCanalNueve(5).DiasConsumo		:= NULL;

    otbltytCanalNueve(6).nroCanal		:= '9';
    otbltytCanalNueve(6).NumeroCompleto	:= sbNumeroCompleto;
    otbltytCanalNueve(6).IDOrdenamiento	:= 6;
    otbltytCanalNueve(6).FechaConsumo	:= v_tytInfoDatosConsumo.FECHA_CONS_MES_6;
    otbltytCanalNueve(6).Consumo			:= v_tytInfoDatosConsumo.CONSUMO_MES_6;
    otbltytCanalNueve(6).DiasConsumo		:= NULL;

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
  END prGetInfoCanalNueve;

  PROCEDURE prGetInfoCanalDos( otytCanalDos     OUT  tytCanalDos,
                               otytCanalDosCont OUT  tytCanalDos ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalDos
    Descripcion     : retorna informacion para canal dos facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otytCanalDos     registro de canal dos
      otytCanalDosCont registro de canal dos contigencia
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
   csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalDos';

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    otytCanalDos.NroCanal		    := '2';
    otytCanalDos.NumeroCompleto	    := sbNumeroCompleto;
    otytCanalDos.LlevaAnexos		:= 'NO';
    otytCanalDos.CantidadAnexos	    := '';
    otytCanalDos.NombreAnexo		:= '';
    otytCanalDos.RazonSocial		:= csbRazonFabrSoft;
    otytCanalDos.NIT				:= csbNitFabrSoft;
    otytCanalDos.FabricanteSW       := csbNombreFabrSoft;
    otytCanalDos.NombreSW		    := csbNombreSoft;
    otytCanalDos.Resolucion		    := gsbResolucion;
    otytCanalDos.ConsecutivoInicial := gnuConsInicial;
    otytCanalDos.ConsecutivoFinal	:= gnuConsFinal;
    otytCanalDos.Prefijo            := sbPrefijo;
    otytCanalDos.FechaResolucion    := to_char(gdtFechaResol,'YYYY-MM-DD');
    otytCanalDos.FechaInicioVigencia := to_char(gdtFechaIniVige,'YYYY-MM-DD');
    otytCanalDos.FechaFinalVigencia  := to_char(gdtFechaFinVige,'YYYY-MM-DD');

    otytCanalDosCont.NroCanal		    := '2';
    otytCanalDosCont.NumeroCompleto	    := '<FACTURA_CONTINGENCIA>';
    otytCanalDosCont.LlevaAnexos		:= 'NO';
    otytCanalDosCont.CantidadAnexos	    := '';
    otytCanalDosCont.NombreAnexo		:= '';
    otytCanalDosCont.RazonSocial		:= csbRazonFabrSoft;
    otytCanalDosCont.NIT				:= csbNitFabrSoft;
    otytCanalDosCont.FabricanteSW       := csbNombreFabrSoft;
    otytCanalDosCont.NombreSW		    := csbNombreSoft;
    otytCanalDosCont.Resolucion		    := '<RESOLUCION_CONTIGENCIA>';
    otytCanalDosCont.ConsecutivoInicial := '<CONSECUTIVO_INICIAL_CONTIGENCIA>';
    otytCanalDosCont.ConsecutivoFinal	:= '<CONSECUTIVO_FINAL_CONTIGENCIA>';
    otytCanalDosCont.Prefijo            := '<PREFIJO_CONTIGENCIA>';
    otytCanalDosCont.FechaResolucion    := '<FECHA_RESOLUCION_CONTIGENCIA>';
    otytCanalDosCont.FechaInicioVigencia := '<FECHA_INICIO_VIGENCIA_CONTIGENCIA>';
    otytCanalDosCont.FechaFinalVigencia  := '<FECHA_FINAL_VIGENCIA_CONTIGENCIA>';

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
  END prGetInfoCanalDos;

  PROCEDURE prGetInfoCanalTres( otytCanalTres OUT  tytCanalTres) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : otytCanalTres
    Descripcion     : retorna informacion para canal tres facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otytCanalTres    tabla con registro de canal dos

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
   csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalDos';
   sbNitComple       VARCHAR2(80);
   sbNombreEmpre     VARCHAR2(80);
   sbDigitoVeri      VARCHAR2(4);
   sbNitSinDigito    VARCHAR2(80);
   sbDireccion       VARCHAR2(100);

   sbDepartamento    VARCHAR2(50);
   sbCiudad          VARCHAR2(50);
   sbDescDepart      VARCHAR2(500);
   sbDescLocalidad   VARCHAR2(500);
   onuError          NUMBER;
   osbError          VARCHAR2(4000);

   CURSOR cuGetInfoSistema IS
   SELECT SUBSTR(sistnitc, INSTR(sistnitc, '-') + 1, 1) digito,
            SUBSTR(sistnitc, 1, INSTR(sistnitc, '-') - 1) NitSinDigi,
         sistempr, sistdire
   FROM sistema;

   PROCEDURE prCloseCursor IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prCloseCursor';
   BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF cuGetInfoSistema%ISOPEN THEN
           CLOSE cuGetInfoSistema;
        END IF;
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;

    PROCEDURE prInicializaInfo IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prInicializaInfo';
   BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        sbNitComple    :='';
        sbNombreEmpre  :='';
        sbDigitoVeri   :='';
        sbNitSinDigito :='';
        sbDireccion    :='';
        sbDepartamento := null;
        sbCiudad       :='';
        sbDescDepart   :='';
        sbDescLocalidad :='';
        onuError        := 0;
       osbError         := NULL;
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializaInfo;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    prCloseCursor;
    prInicializaInfo;

    OPEN cuGetInfoSistema;
    FETCH cuGetInfoSistema INTO sbDigitoVeri, sbNitSinDigito, sbNombreEmpre, sbDireccion;
    CLOSE cuGetInfoSistema;

    prGetInfoEquivaLoca( cnuLocalidadEmisor,
                         sbCiudad,
                         sbDepartamento,
                         sbDescDepart,
                         sbDescLocalidad,
                         onuError,
                         osbError);


    otytCanalTres.NroCanal		                := '3';
    otytCanalTres.NumeroCompleto	            := sbNumeroCompleto;
    otytCanalTres.NaturalezaEmisor              := csbNaturalezaEmisor;
    otytCanalTres.CodigoIdentificacionEmisor	:= csbTipoIdenEmisor;
    otytCanalTres.DescripcionIdentificacionEmi	:= csbDescTipoIdeEmisor;
    otytCanalTres.NumeroIdentificacionEmisor	:= sbNitSinDigito;
    otytCanalTres.DigitoVerificacionEmisor      := sbDigitoVeri;
    otytCanalTres.RazonSocialEmisor             := csbRazonSocialEmisor;
    otytCanalTres.NombreComercialEmisor		    := sbNombreEmpre;
    otytCanalTres.MatriculaMercantilEmisor      := csbMatriculaMerca;
    otytCanalTres.CodDepartamentoExpedicionEmi  := sbDepartamento;
    otytCanalTres.NomDepartamentoExpedicionEmi  := sbDescDepart;
    otytCanalTres.CodMunicipioExpedicionEmisor  := sbCiudad;
    otytCanalTres.NombreMunicipioExpedicionEmi  := sbDescLocalidad;
    otytCanalTres.DireccionExpedicionEmisor     := csbDireccionEmisor;
    otytCanalTres.CodigoZonaPostalExpedicionEmi := csbZonaPostalEmisor;
    otytCanalTres.CodigoPaisExpedicionEmisor    := csbPais;
    otytCanalTres.NombrePaisExpedicionEmisor    := csbNombrePais;
    otytCanalTres.CodigoDepartamentoFiscalEmi   := sbDepartamento;
    otytCanalTres.NombreDepartamentoFiscalEmi   := sbDescDepart;
    otytCanalTres.CodigoMunicipioFiscalEmisor   := sbCiudad;
    otytCanalTres.NombreMunicipioFiscalEmisor   := sbDescLocalidad;
    otytCanalTres.DireccionFiscalEmisor         := csbDireccionEmisor;
    otytCanalTres.CodigoZonaPostalFiscalEmisor  := csbZonaPostalEmisor;
    otytCanalTres.CodigoPaisFiscalEmisor        := csbPais;
    otytCanalTres.NombrePaisFiscalEmisor        := csbNombrePais;
    otytCanalTres.TipoRegimenEmisor             := csbTipoRegiEmisor;
    otytCanalTres.ResponsabilidadesFiscalesEmi  := csbRespFiscalEmisor;
    otytCanalTres.CodigoTributoResponsableEmi   := csbCodTributoEmisor;
    otytCanalTres.NombreTributoResponsableEmi   := csbNombTributoEmisor;
    otytCanalTres.CorreoElectronicoEmisor       := csbEmailEmisor;
    otytCanalTres.CorreoElectronicoControler    := csbEmailContEmisor;
    otytCanalTres.TelefonoEmisor                := csbTelefonoEmisor;
    otytCanalTres.FaxEmisor                     := csbFaxEmisor;
    otytCanalTres.Opcional21                    := '';
    otytCanalTres.Opcional22                    := '';
    otytCanalTres.Opcional23                    := '';
    otytCanalTres.Opcional24                    := '';
    otytCanalTres.Opcional25                    := '';
    otytCanalTres.Opcional26                    := '';
    otytCanalTres.Opcional27                    := '';
    otytCanalTres.Opcional28                    := '';
    otytCanalTres.Opcional29                    := '';
    otytCanalTres.Opcional30                    := '';
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       prCloseCursor;
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       prCloseCursor;
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE pkg_error.CONTROLLED_ERROR;
  END prGetInfoCanalTres;

  PROCEDURE prGetInfoCanalTresA( otytCanalTresA OUT  tytCanalTresA) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalTresA
    Descripcion     : retorna informacion para canal tres a facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otytCanalTresA    tabla con registro de canal tres a
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
   csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalDos';

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    otytCanalTresA.NroCanal		                  := '3A';
    otytCanalTresA.NumeroCompleto	              := sbNumeroCompleto;
    otytCanalTresA.CodIdentificacionParticipante  := '';
    otytCanalTresA.DescIdentificacionParticipante := '';
    otytCanalTresA.NumIdentificacionParticipante  := '';
    otytCanalTresA.DigitoVerificacionParticipante := '';
    otytCanalTresA.RazonSocialParticipante        := '';
    otytCanalTresA.PorcentajeParticipacion        := '';
    otytCanalTresA.TipoRegimenParticipante        := '';
    otytCanalTresA.ResponFiscalesParticipante     := '';
    otytCanalTresA.CodTributoResponParticipante   := '';
    otytCanalTresA.NombTributoResponParticipante  := '';
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
  END prGetInfoCanalTresA;
  PROCEDURE prGetInfoCanalCuatro( inuFactura      IN   NUMBER,
                                  otytCanalCuatro OUT  tytCanalCuatro) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalCuatro
    Descripcion     : retorna informacion para canal cuatro facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otytCanalTresA    tabla con registro de canal tres a

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       26-11-2024   OSF-3649     se coloca restriccion para que contratos
                                        configurado en el MD mdceccg se le muestre el NIT correspondiente
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
   csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalCuatro';
   nuTipoPersona     NUMBER;
   nuTipoIdent       NUMBER;
   sbDigitoVeri      VARCHAR2(4);
   sbIdentSinDigito  VARCHAR2(30);
   sbDescripTipoIde  VARCHAR2(30);
   osbCiudad         VARCHAR2(50);
   osbDepartamento   VARCHAR2(50);
   osbDescDepart     VARCHAR2(50);
   osbDescLocalidad  VARCHAR2(50);
   onuError          NUMBER;
   osbError          VARCHAR2(4000);

   sbValidaNit       VARCHAR2(10) := pkg_parametros.fsbgetvalorcadena('VALIDA_NIT');
   sbCedulaGene      VARCHAR2(40) := pkg_parametros.fsbgetvalorcadena('CEDULA_GENERICA');
   sbEnvioEmail      VARCHAR2(1) := pkg_parametros.fsbgetvalorcadena('ACTIVAR_ENVIO_MAIL_FAEL');
   sbEmailDefecto      VARCHAR2(100) := pkg_parametros.fsbgetvalorcadena('CORREO_RECEPTOR_POR_DEFECTO');
   CURSOR cuGetInfoCliente IS
   SELECT factura.factfege,
          ab_address.address_parsed,
          ab_address.geograp_location_id,
          ge_subscriber.subscriber_id,
          ge_subscriber.ident_type_id,
          ge_subscriber.identification,
          REPLACE( REPLACE(ge_subscriber.subscriber_name||' '||ge_subscriber.subs_last_name, CHR(10), ''),CHR(13),'')  nombre,
          CASE WHEN sbEnvioEmail = 'S' THEN NVL(suscripc.suscmail,sbEmailDefecto) ELSE NULL END e_mail,
          cuencobr.cucocate SESUCATE,
          suscripc.susccodi
    FROM factura
     JOIN suscripc ON suscripc.susccodi = factura.factsusc
     JOIN cuencobr ON cuencobr.cucofact = factura.factcodi
     JOIN ge_subscriber ON ge_subscriber.subscriber_id = suscripc.suscclie
     JOIN ab_address ON ab_address.address_id = suscripc.susciddi
    WHERE factura.factcodi = inuFactura;

    regInfoCliente       cuGetInfoCliente%ROWTYPE;
    regInfoClienteNull   cuGetInfoCliente%ROWTYPE;
    sbDatos  VARCHAR2(1);

    CURSOR cuValidaIdentClie(inuCliente IN NUMBER) IS
    SELECT 'X'
    FROM fe_validacion_identificacion
    WHERE fe_validacion_identificacion.id_cliente = inuCliente
     AND fe_validacion_identificacion.valido = 'S';
     
    CURSOR cuValidaContExce(inuContrato IN NUMBER) IS
    SELECT 'X'
    FROM contratos_omitir_nit_generico
    WHERE contratos_omitir_nit_generico.contrato = inuContrato;


    PROCEDURE prCloseCursor IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prCloseCursor';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF cuGetInfoCliente%ISOPEN THEN
           CLOSE cuGetInfoCliente;
        END IF;

        IF cuValidaIdentClie%ISOPEN THEN
           CLOSE cuValidaIdentClie;
        END IF;
        
        IF cuValidaContExce%ISOPEN THEN
           CLOSE cuValidaContExce;
        END IF;
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;

    PROCEDURE prInicializarValores IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prInicializarValores';
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      regInfoCliente := regInfoClienteNull;
      nuTipoPersona  := 2;
      sbDigitoVeri   := NULL;
      nuTipoIdent    := NULL;
      sbIdentSinDigito := NULL;
      sbDescripTipoIde := NULL;
      osbCiudad        := NULL;
      osbDepartamento  := NULL;
      osbDescDepart    := NULL;
      osbDescLocalidad := NULL;
      onuError         := 0;
      osbError        := NULL;
      sbDatos         := null;
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializarValores;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    prCloseCursor;
    prInicializarValores;

    OPEN cuGetInfoCliente;
    FETCH cuGetInfoCliente INTO regInfoCliente;
    CLOSE cuGetInfoCliente;

    IF sbValidaNit = 'S' THEN
       OPEN cuValidaIdentClie(regInfoCliente.subscriber_id);
       FETCH cuValidaIdentClie INTO sbDatos;
       CLOSE cuValidaIdentClie;

       IF sbDatos IS NULL THEN
           nuTipoIdent := fnuGetEquivaleTipoIdent(1, sbDescripTipoIde );
           sbIdentSinDigito := sbCedulaGene;
       ELSIF regInfoCliente.ident_type_id = pkg_bcfactelectronica.cnuTipoIdNit AND regInfoCliente.sesucate = 1 THEN
          sbDatos := NULL;
          OPEN cuValidaContExce(regInfoCliente.susccodi);
          FETCH cuValidaContExce INTO sbDatos;
          CLOSE cuValidaContExce;
          
          IF sbDatos IS NULL THEN
              nuTipoIdent := fnuGetEquivaleTipoIdent(1, sbDescripTipoIde );
              sbIdentSinDigito := sbCedulaGene;
          END IF;
       END IF;
    END IF;
   --si el parametro esta apagado o el cliente fue validado busco su homologacion de tipo de identificacion
    IF nuTipoIdent IS NULL THEN
        nuTipoIdent := fnuGetEquivaleTipoIdent(regInfoCliente.ident_type_id, sbDescripTipoIde );
    END IF;

    IF nuTipoIdent IS NULL THEN
       onuError := 1;
       osbError := 'Tipo de identificacion ['||regInfoCliente.ident_type_id||'] no esta homologado.';
       pkg_error.setErrorMessage(isbMsgErrr =>osbError );
    END IF;

    IF sbIdentSinDigito IS NULL THEN
        sbIdentSinDigito := regInfoCliente.identification;

        IF regInfoCliente.ident_type_id = pkg_bcfactelectronica.cnuTipoIdNit THEN
           sbDigitoVeri  := fsbGetDigitoVerifi(regInfoCliente.identification, sbIdentSinDigito);
           nuTipoPersona := 1;
        END IF;
    END IF;

    prGetInfoEquivaLoca( regInfoCliente.geograp_location_id,
                         osbCiudad,
                         osbDepartamento,
                         osbDescDepart,
                         osbDescLocalidad,
                         onuError,
                         osbError);
    IF onuError <> 0 THEN
       pkg_error.setErrorMessage(isbMsgErrr =>osbError );
    END IF;
    otytCanalCuatro.NroCanal		    			:= '4';
    otytCanalCuatro.NumeroCompleto	    			:= sbNumeroCompleto;
    otytCanalCuatro.NaturalezaReceptor			    := nuTipoPersona;
    otytCanalCuatro.CodigoIdentificacionReceptor	:= nuTipoIdent;
    otytCanalCuatro.DescIdentificacionReceptor      := sbDescripTipoIde;
    otytCanalCuatro.NumeroIdentificacionReceptor    := sbIdentSinDigito;
    otytCanalCuatro.DigitoVerificacionReceptor      := sbDigitoVeri;
    otytCanalCuatro.RazonSocialReceptor            	:= regInfoCliente.nombre;
    otytCanalCuatro.NombreComercialReceptor         := '';
    otytCanalCuatro.MatriculaMercantilReceptor      := '';
    otytCanalCuatro.CodigoDepartamentoReceptor      := osbDepartamento;
    otytCanalCuatro.NombreDepartamentoReceptor      := osbDescDepart;
    otytCanalCuatro.CodigoMunicipioReceptor         := osbCiudad;
    otytCanalCuatro.NombreMunicipioReceptor         := osbDescLocalidad;
    otytCanalCuatro.DireccionReceptor               := NVL(v_tytInfoDatosCliente.DIRECCION_COBRO, regInfoCliente.address_parsed);
    otytCanalCuatro.CodigoZonaPostalReceptor        := '';
    otytCanalCuatro.CodigoPaisReceptor              := csbPais;
    otytCanalCuatro.NombrePaisReceptor              := csbNombrePais;
    otytCanalCuatro.TipoRegimenReceptor             := csbTipoRegimenReceptor;
    otytCanalCuatro.ResponFiscalesReceptor          := csbRespFiscalesReceptor;
    otytCanalCuatro.CodTributoResponsableReceptor   := csbCodigoTribRespReceptor;
    IF nuTipoPersona = 2 THEN
      otytCanalCuatro.NombTributoResponsableReceptor  := csbNombreTribRespReceptor;
    ELSE
      otytCanalCuatro.NombTributoResponsableReceptor  := csbNombreTribRespReceptorEmp;
    END IF;
    otytCanalCuatro.CorreoElectronicoReceptor       := regInfoCliente.e_mail;
    otytCanalCuatro.TelefonoReceptor                := '';
    otytCanalCuatro.FaxReceptor                     := '';
    otytCanalCuatro.NotaContacto                    := '';
    otytCanalCuatro.CodigoIdentificacionAutorizado  := '';
    otytCanalCuatro.NumeroIdentificacionAutorizado  := '';
    otytCanalCuatro.DigitoIdentificacionAutorizado  := '';
    otytCanalCuatro.Uso                             := v_tytInfoDatosCliente.CATEGORIA;
    otytCanalCuatro.Estrato                         := v_tytInfoDatosCliente.ESTRATO;
    otytCanalCuatro.Ciclo                           := v_tytInfoDatosCliente.CICLO;
    otytCanalCuatro.RutaReparto                     := v_tytInfoDatosCliente.RUTA;
    otytCanalCuatro.Medidor                         := v_tytInfoDatosLectura.NUM_MEDIDOR;
    otytCanalCuatro.DireccionCobro                  := v_tytInfoDatosCliente.DIRECCION_COBRO;
    otytCanalCuatro.DescripcionBarrio               := '';
    otytCanalCuatro.CorreoElectronico2              := '';
    otytCanalCuatro.EstadoTecnico                   := '';
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
   EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       prCloseCursor;
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       prCloseCursor;
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE pkg_error.CONTROLLED_ERROR;
   END prGetInfoCanalCuatro;

   PROCEDURE prGetInfoCanalCinco( otytCanalCinco  OUT  tytCanalCinco) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalCinco
    Descripcion     : retorna informacion para canal cinco facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otytCanalCinco    registro de canal cinco
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalCinco';
    PROCEDURE prInicializarValores IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prInicializarValores';
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializarValores;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    otytCanalCinco.NroCanal		       := '5';
    otytCanalCinco.NumeroCompleto	   := sbNumeroCompleto;
    IF gnuValorTotalIva > 0 THEN
        otytCanalCinco.CodigoImpuesto      := csbCodigoImpuesto;
        otytCanalCinco.NombreImpuesto      := csbDescImpuesto;
        otytCanalCinco.ValorTotalImpuesto  := TRIM(TO_CHAR(gnuValorTotalIva,'9999999999999999990.90')) ;
        otytCanalCinco.TipoImpuesto        := 'false';
    ELSE
        otytCanalCinco.CodigoImpuesto      := '';
        otytCanalCinco.NombreImpuesto      := '';
        otytCanalCinco.ValorTotalImpuesto  := '';
        otytCanalCinco.TipoImpuesto        := '';
    END IF;
    otytCanalCinco.Opcional41          := '';
    otytCanalCinco.Opcional42          := '';
    otytCanalCinco.Opcional43          := '';
    otytCanalCinco.Opcional44          := '';
    otytCanalCinco.Opcional45 		   := '';
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
  END prGetInfoCanalCinco;

  PROCEDURE prGetInfoCanalCincoA( otbltytCanalCincoA OUT  tbltytCanalCincoA) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalCinco
    Descripcion     : retorna informacion para canal cinco A facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otytCanalCincoA    tabla con registro de canal cinco A
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalCincoa';

    sbIndex  VARCHAR2(40);
    nuValorBase  NUMBER(20,2) := 0;
    nuImpuesto   NUMBER(20,2) := 0;
    nuTarifa     NUMBER(20,2);
    PROCEDURE prInicializarValores IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prInicializarValores';
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      sbIndex := NULL;
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializarValores;

    PROCEDURE prGeneraEstructura( nuValorBase IN NUMBER DEFAULT NULL,
                                  nuImpuesto  IN NUMBER DEFAULT NULL,
                                  nuPorce     IN NUMBER DEFAULT NULL,
                                  sbIndex     IN VARCHAR2) IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prGeneraEstructura';
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      pkg_traza.trace(' nuValorBase => ' || nuValorBase, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' nuImpuesto => ' || nuImpuesto, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' nuPorce => ' || nuPorce, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' sbIndex => ' || sbIndex, pkg_traza.cnuNivelTrzDef);
      otbltytCanalCincoA(sbIndex).NroCanal		    	     := '5A';
      otbltytCanalCincoA(sbIndex).NumeroCompleto	    	 := sbNumeroCompleto;
      otbltytCanalCincoA(sbIndex).ValorBaseImponible		 := TRIM(TO_CHAR(nuValorBase,'999999999999990.90'));
      otbltytCanalCincoA(sbIndex).ValorImpuesto             := TRIM(TO_CHAR(nuImpuesto,'999999999999990.90'));
      otbltytCanalCincoA(sbIndex).Porcentaje                := TRIM(TO_CHAR(nuPorce,'90.90'));
      otbltytCanalCincoA(sbIndex).UnidadMedidaBaseTributo   := '';
      otbltytCanalCincoA(sbIndex).IdentUnidadMedidaTributo  := '';
      otbltytCanalCincoA(sbIndex).ValorTributoUnidad        := '';
      otbltytCanalCincoA(sbIndex).Opcional46                := '';
      otbltytCanalCincoA(sbIndex).Opcional47                := '';
      otbltytCanalCincoA(sbIndex).Opcional48                := '';
      otbltytCanalCincoA(sbIndex).Opcional49                := '';
      otbltytCanalCincoA(sbIndex).Opcional50                := '';
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prGeneraEstructura;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    prInicializarValores;

    IF v_tbltytInfoImpuesto.COUNT > 0 THEN
        sbIndex := v_tbltytInfoImpuesto.FIRST;
        LOOP
           EXIT WHEN sbIndex IS NULL;
           nuValorBase := nuValorBase + nvl(v_tbltytInfoImpuesto(sbIndex).nuValorBase,0);
           nuImpuesto  := nuImpuesto + nvl(v_tbltytInfoImpuesto(sbIndex).nuValor,0);
           nuTarifa    := v_tbltytInfoImpuesto(sbIndex).nuTarifa;
          sbIndex := v_tbltytInfoImpuesto.NEXT(sbIndex);
        END LOOP;
        prGeneraEstructura( nuValorBase,
                             nuImpuesto,
                             nuTarifa,
                             '1');
    ELSE
        prGeneraEstructura( sbIndex => '1');
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
  END prGetInfoCanalCincoa;

  PROCEDURE prGetInfoCanalSeis( inuFactura        IN NUMBER,
                                inuTipoDocu       IN NUMBER,
                                isbOperacion      IN VARCHAR2,
                                otbltytCanalSeis  OUT  tbltytCanalSeis,
                                osbEmitirFactura  OUT VARCHAR) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalSeis
    Descripcion     : retorna informacion para canal seis facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada
        inuFactura  codigo de la factura
      inuTipoDocu tipo de documento
      isbOperacion   operacion I - INsertar A actualizar
    Parametros de Salida
      otbltytCanalSeis    tabla con registro de canal seis
      osbEmitirFactura    emitir factura
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalSeis';
    nuContador        NUMBER := 0;
    nuTotal           NUMBER;
    nuValorUni        NUMBER;
    sbIndex           VARCHAR2(40);
    sbUnidad          VARCHAR2(10);
    nuDescuento        NUMBER ;

    v_tytCanalSeisA    tytCanalSeisA;
    v_tytCanalSeisb    tytCanalSeisB;
    v_tytCanalSeisc    tytCanalSeisC;
    v_tytCanalSeisd    tytCanalSeisD;

    PROCEDURE prInicializarValores IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prInicializarValores';
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      sbUnidad := NULL;
      v_tytCanalSeisA := null;
      v_tytCanalSeisb := null;
      v_tytCanalSeisc := null;
      v_tytCanalSeisd := null;
      nuDescuento     := 0;
      nuTotal         := 0;
      nuValorUni      := 0;
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializarValores;

    PROCEDURE prGeneraEstructura( InuOrdenamiento   IN  NUMBER DEFAULT NULL,
                                  inuConcepto       IN  NUMBER DEFAULT NULL,
                                  isbDescConce      IN  VARCHAR2 DEFAULT NULL,
                                  inuCantidad       IN  NUMBER DEFAULT NULL,
                                  inuValor          IN  NUMBER DEFAULT NULL,
                                  inuValorUnitario  IN  NUMBER DEFAULT NULL,
                                  isbAjuste         IN VARCHAR2 DEFAULT NULL,
                                  isbUnidadMedida   IN  VARCHAR2 DEFAULT NULL,
                                  isbIndex           IN  VARCHAR2
                                  ) IS
       csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prGeneraEstructura';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        otbltytCanalSeis(isbIndex).NroCanal		    			 := '6';
        otbltytCanalSeis(isbIndex).NumeroCompleto	    		   := sbNumeroCompleto;
        otbltytCanalSeis(isbIndex).IDOrdenamiento                  := InuOrdenamiento;
        otbltytCanalSeis(isbIndex).EstandarArticulo                := (CASE WHEN inuConcepto IS NULL THEN '' ELSE csbEstandarArt END);
        otbltytCanalSeis(isbIndex).CodigoArticulo                  := inuConcepto;
        otbltytCanalSeis(isbIndex).DescripcionArticulo             := isbDescConce;
        pkg_traza.trace(' inuConcepto => ' || inuConcepto, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(' inuValor => ' || inuValor, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(' inuValorUnitario => ' || inuValorUnitario, pkg_traza.cnuNivelTrzDef);

        IF INSTR(','||NVL(inuConcepto,-1)||',', ','||gsbConceptosAiu||',') > 0 AND inuConcepto IS NOT NULL  THEN
           otbltytCanalSeis(isbIndex).Observaciones                   := 'Contrato de servicios AIU por concepto de: '||isbDescConce;
        ELSE
          otbltytCanalSeis(isbIndex).Observaciones                   := '';
        END IF;
        IF isbIndex <> '1' THEN
            gnuContadorLinea := gnuContadorLinea + 1;
            gnuValorTotal    := gnuValorTotal + inuValor;
        END IF;
        otbltytCanalSeis(isbIndex).MarcaArticulo                   := '';
        otbltytCanalSeis(isbIndex).ModeloArticulo                  := '';
        otbltytCanalSeis(isbIndex).CantidadDetalle                 := inuCantidad;
        otbltytCanalSeis(isbIndex).CantidadBaseDetalle             := inuCantidad;
        otbltytCanalSeis(isbIndex).PackDetalle                     := '';
        otbltytCanalSeis(isbIndex).UnidadMedidadDetalle            := isbUnidadMedida;
        otbltytCanalSeis(isbIndex).ValorUnitarioDetalle            := trim(to_char(inuValorUnitario,'999999999999990.90'));
        otbltytCanalSeis(isbIndex).ValorTotalDetalle               := trim(to_char( inuValor ,'999999999999990.90'));
        otbltytCanalSeis(isbIndex).DetalleRegalo                   := (CASE WHEN inuConcepto IS NULL OR sbTipoNota ='D' THEN '' ELSE 'false' END);
        otbltytCanalSeis(isbIndex).PrecioReferenciaDetalle         := '';
        otbltytCanalSeis(isbIndex).CodigoPrecioReferenciaDetalle   := '';
        otbltytCanalSeis(isbIndex).CodigoCentroCostosDetalle       := '';
        otbltytCanalSeis(isbIndex).NombreCentroCostosDetalle       := '';
        otbltytCanalSeis(isbIndex).Opcional51                      := '';
        otbltytCanalSeis(isbIndex).Opcional52                      := '';
        otbltytCanalSeis(isbIndex).Opcional53                      := '';
        otbltytCanalSeis(isbIndex).Opcional54                      := '';
        otbltytCanalSeis(isbIndex).Opcional55                      := '';
        otbltytCanalSeis(isbIndex).Opcional56                      := '';
        otbltytCanalSeis(isbIndex).Opcional57                      := '';
        otbltytCanalSeis(isbIndex).Opcional58                      := '';
        otbltytCanalSeis(isbIndex).Opcional59                      := '';
        otbltytCanalSeis(isbIndex).Opcional60                      := '';
        otbltytCanalSeis(isbIndex).Opcional61                      := '';
        otbltytCanalSeis(isbIndex).Opcional62                      := '';
        otbltytCanalSeis(isbIndex).Opcional63                      := '';
        otbltytCanalSeis(isbIndex).Opcional64                      := '';
        otbltytCanalSeis(isbIndex).Opcional65 					   := '';
        otbltytCanalSeis(isbIndex).infoCanal6a                     := v_tytCanalSeisA;
        otbltytCanalSeis(isbIndex).infoCanal6b                     := v_tytCanalSeisB;
        otbltytCanalSeis(isbIndex).infoCanal6c                     := v_tytCanalSeisC;
        otbltytCanalSeis(isbIndex).infoCanal6d                     := v_tytCanalSeisD;
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prGeneraEstructura;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    prInicializarValores;
    IF v_tbltytInfoIngresos.COUNT > 0  THEN
       IF inuTipoDocu <> cnuTipoDocuNotas THEN
           prInicializarDatosCons (  inuFactura ,
                                  inuTipoDocu,
                                  isbOperacion );
       ELSE
             prSetConsecutivo( inuFactura );
             IF sbTipoNota ='C' THEN
               sbPrefijo    := csbPrefijoNotaCre;
             ELSE
                sbPrefijo   := csbPrefijoNotaDeb;
             END IF;
             sbNumeroCompleto := sbPrefijo||fnuGetConsecutivo;
       END IF;


       sbIndex := v_tbltytInfoIngresos.FIRST;
       LOOP
         EXIT WHEN sbIndex IS NULL;
         prInicializarValores;
         nuContador := nuContador + 1;
               --canal seis a
         prGetInfoCanalSeisA(v_tytCanalSeisA);
         --canal seis b
         prGetInfoCanalSeisB( v_tbltytInfoIngresos(sbIndex).nuConcepto, nuDescuento, v_tytCanalSeisB);
          --canal seis c
         prGetInfoCanalSeisC(v_tbltytInfoIngresos(sbIndex).InfoImpuesto, v_tytCanalSeisC);
          --canal seis d
         prGetInfoCanalSeisD(v_tbltytInfoIngresos(sbIndex).InfoImpuesto, v_tytCanalSeisD);

         prGeneraEstructura(  nuContador,
                              v_tbltytInfoIngresos(sbIndex).nuConcepto,
                              v_tbltytInfoIngresos(sbIndex).sbDescConce,
                              v_tbltytInfoIngresos(sbIndex).nuCantidad,
                              v_tbltytInfoIngresos(sbIndex).nuIngreso,
                              v_tbltytInfoIngresos(sbIndex).nuValorUnitario,
                              v_tbltytInfoIngresos(sbIndex).isAjuste,
                              v_tbltytInfoIngresos(sbIndex).sbUnidadMedida,
                              sbIndex);
         osbEmitirFactura := 'S';
         sbIndex := v_tbltytInfoIngresos.NEXT(sbIndex);

       END LOOP;

    ELSE
       osbEmitirFactura := 'N';

      prSetConsecutivo( inuFactura );
	  sbNumeroCompleto := null;


       --canal seis a
       prGetInfoCanalSeisA(v_tytCanalSeisA);
      --canal seis b
       prGetInfoCanalSeisB( null, nuDescuento, v_tytCanalSeisB);
      --canal seis c
       prGetInfoCanalSeisC(null, v_tytCanalSeisC);
      --canal seis d
       prGetInfoCanalSeisD(null, v_tytCanalSeisD);

       prGeneraEstructura(isbIndex => '1');

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
  END prGetInfoCanalSeis;

  PROCEDURE prGetInfoCanalSeisA(  otytCanalSeisA    OUT  tytCanalSeisA) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalSeisA
    Descripcion     : retorna informacion para canal seis a facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      otytCanalSeisA    registro de canal seis a
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalSeisA';

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    otytCanalSeisA.NroCanal		    		    :='6A';
    otytCanalSeisA.NumeroCompleto	    	    :=sbNumeroCompleto;
    otytCanalSeisA.CodigoIdentificacionMandante :='';
    otytCanalSeisA.NumeroIdentificacionMandante :='';
    otytCanalSeisA.DigitoVerificacionMandante   :='';
    otytCanalSeisA.Opcional66                   :='';
    otytCanalSeisA.Opcional67                   :='';
    otytCanalSeisA.Opcional68                   :='';
    otytCanalSeisA.Opcional69                   :='';
    otytCanalSeisA.Opcional70                   :='';

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
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
  END prGetInfoCanalSeisA;

  PROCEDURE prGetInfoCanalSeisB(  inuConcepto     IN   NUMBER,
                                  onuDescuento    OUT  NUMBER,
                                  otytCanalSeisB  OUT  tytCanalSeisb) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalSeisB
    Descripcion     : retorna informacion para canal seis b facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada
       inuConcepto  Codigo del concepto
    Parametros de Salida
      otytCanalSeisB    registro de canal seis b
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalSeisB';
    sbIndex           VARCHAR2(40);
    sbTipoDescuento   VARCHAR2(40);
    nuCodiDescuento   NUMBER;
    nuConsecutivo     NUMBER;
    blExisAjuste      BOOLEAN;
    nuPorce           NUMBER;

    PROCEDURE prInicializarValores IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prInicializarValores';
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      sbIndex := null;
      nuCodiDescuento := null;
      sbTipoDescuento := null;
      nuConsecutivo := null;
      blExisAjuste := false;
      onuDescuento := 0;
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializarValores;

    PROCEDURE prGeneraEstructura( isbTipoDescuento IN  VARCHAR2 DEFAULT NULL,
                                  inuConsecutivo   IN  NUMBER DEFAULT NULL,
                                  inuCodDescuento  IN  NUMBER DEFAULT NULL,
                                  inuPorcentaje    IN  NUMBER DEFAULT NULL,
                                  inuValor         IN  NUMBER DEFAULT NULL,
                                  inuValorBase     IN  NUMBER DEFAULT NULL
                                  ) IS
       csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prGeneraEstructura';
    BEGIN
     pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     otytCanalSeisB.NroCanal		    		:= '6B';
     otytCanalSeisB.NumeroCompleto	    	    := sbNumeroCompleto;
     otytCanalSeisB.TipoDescuentoCargoDetalle   := isbTipoDescuento;
     otytCanalSeisB.IdentDescuentoCargoDetalle  := inuConsecutivo;
     otytCanalSeisB.CodigoDescuentoDetalle      := inuCodDescuento;
     otytCanalSeisB.ObseDescuentoCargoDetalle   := '';
     otytCanalSeisB.PorcDescuentoCargoDetalle   := TRIM(TO_CHAR(inuPorcentaje,'990.90'));
     otytCanalSeisB.ValorTotalDescCargoDetalle  := TRIM(TO_CHAR(inuValor,'999999999999990.90'));
     otytCanalSeisB.BaseDescuentoCargoDetalle   := TRIM(TO_CHAR(inuValorBase,'999999999999990.90'));
     pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prGeneraEstructura;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    prInicializarValores;

    IF inuConcepto IN ( nuConceptoCons, nuConsTrans)
        AND v_tbltytInfoAjustes.COUNT >  0 then
        sbIndex := v_tbltytInfoAjustes.FIRST;
        LOOP
          EXIT WHEN sbIndex IS NULL;
          IF v_tbltytInfoAjustes(sbIndex).nuConcepto = inuConcepto THEN
             blExisAjuste := true;
             sbTipoDescuento := 'true';
             nuConsecutivo := nuConsecutivo + 1;
             IF v_tbltytInfoAjustes(sbIndex).nuValor < 0 THEN
                sbTipoDescuento := 'false';
                nuCodiDescuento := cnuCodigoDescuento;
             END IF;

             onuDescuento := onuDescuento + v_tbltytInfoAjustes(sbIndex).nuValor;
             prGeneraEstructura( sbTipoDescuento,
                                 nuConsecutivo,
                                 nuCodiDescuento,
                                 100,
                                 abs(v_tbltytInfoAjustes(sbIndex).nuValor),
                                 abs(v_tbltytInfoAjustes(sbIndex).nuValor) );

          END IF;
          sbIndex := v_tbltytInfoAjustes.NEXT(sbIndex);
        END LOOP;
    END IF;

    IF NOT blExisAjuste THEN
         prGeneraEstructura;
    END IF;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
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
  END prGetInfoCanalSeisB;
  PROCEDURE prGetInfoCanalSeisC( ItytInfoImpuesto  IN   tytInfoImpuesto,
                                 otytCanalSeisC    OUT  tytCanalSeisc) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalSeisC
    Descripcion     : retorna informacion para canal seis c facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada
      ItytInfoImpuesto   registro de impuesto
    Parametros de Salida
      otytCanalSeisc    registro de canal seis c
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalSeisC';
    PROCEDURE prInicializarValores IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prInicializarValores';
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializarValores;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' ItytInfoImpuesto.nuImpuesto => ' || ItytInfoImpuesto.nuImpuesto, pkg_traza.cnuNivelTrzDef);
    IF ItytInfoImpuesto.nuImpuesto > 0 THEN
       otytCanalSeisC.CodigoImpuestoDetalle     := csbCodigoImpuesto;
       otytCanalSeisC.NombreImpuestoDetalle     := csbDescImpuesto;
       otytCanalSeisC.ValorTotalImpuestoDetalle := TRIM(TO_CHAR(ItytInfoImpuesto.nuImpuesto,'999999999999990.90'));
       otytCanalSeisC.TipoImpuestoDetalle       := 'false';
    ELSE
       otytCanalSeisC.CodigoImpuestoDetalle     := '';
       otytCanalSeisC.NombreImpuestoDetalle     := '';
       otytCanalSeisC.ValorTotalImpuestoDetalle := '';
       otytCanalSeisC.TipoImpuestoDetalle       := '';
    END IF;
    otytCanalSeisC.NroCanal		    		 :='6C';
    otytCanalSeisC.NumeroCompleto	    	 :=sbNumeroCompleto;
    otytCanalSeisC.Opcional71                :='';
    otytCanalSeisC.Opcional72                :='';
    otytCanalSeisC.Opcional73                :='';
    otytCanalSeisC.Opcional74                :='';
    otytCanalSeisC.Opcional75                :='';

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
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
  END prGetInfoCanalSeisC;

  PROCEDURE prGetInfoCanalSeisD( ItytInfoImpuesto  IN   tytInfoImpuesto,
                                 otytCanalSeisD    OUT  tytCanalSeisD) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalSeisC
    Descripcion     : retorna informacion para canal seis d facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada
      ItytInfoImpuesto   registro de impuesto
    Parametros de Salida
      otytCanalSeisD    registro de canal seis d
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalSeisD';
    PROCEDURE prInicializarValores IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prInicializarValores';
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializarValores;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    otytCanalSeisD.NroCanal		    		       := '6D';
    otytCanalSeisD.NumeroCompleto	    		   := sbNumeroCompleto;
    IF ItytInfoImpuesto.nuValorBase > 0 THEN
        otytCanalSeisD.ValorBaseImponibleDetalle       := TRIM(TO_CHAR(ItytInfoImpuesto.nuValorBase,'999999999999990.90'));
        otytCanalSeisD.ValorImpuestoDetalle            := TRIM(TO_CHAR(ItytInfoImpuesto.nuImpuesto,'999999999999990.90'));
        otytCanalSeisD.PorcentajeDetalle               := TRIM(TO_CHAR(ItytInfoImpuesto.nuTarifa,'90.90'));
    ELSE
       otytCanalSeisD.ValorBaseImponibleDetalle       := '';
        otytCanalSeisD.ValorImpuestoDetalle           := '';
        otytCanalSeisD.PorcentajeDetalle              := '';
    END IF;
    otytCanalSeisD.UnidMedidaBaseTributoDetalle    :='';
    otytCanalSeisD.IdenUnidMedidaTributoDetalle    :='';
    otytCanalSeisD.ValorTributoUnidadDetalle       :='';
    otytCanalSeisD.Opcional76                      :='';
    otytCanalSeisD.Opcional77                      :='';
    otytCanalSeisD.Opcional78                      :='';
    otytCanalSeisD.Opcional79                      :='';
    otytCanalSeisD.Opcional80                      :='';

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
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
  END prGetInfoCanalSeisd;

  PROCEDURE prGetInfoCanalDiez( inuFactura        IN   NUMBER,
                                otbltytCanalDiez  OUT  tbltytCanalDiez) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalDiez
    Descripcion     : retorna informacion para canal diez facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada
      inuFactura     codigo de la factura
    Parametros de Salida
      otytCanalSeisD    tabla con registro de canal seis d

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalDiez';
    sbIndex           VARCHAR2(50);
    sbIndexDato       VARCHAR2(50);
    nuContador        NUMBER := 0;

    PROCEDURE prInicializarValores IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prInicializarValores';
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializarValores;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    otbltytCanalDiez.delete;

    IF v_tbltytInfoCargos.COUNT > 0 THEN
        sbIndex := v_tbltytInfoCargos.FIRST;
        LOOP
            sbIndexDato    := sbIndex;
            otbltytCanalDiez(sbIndexDato).NroCanal		   :='10';
            otbltytCanalDiez(sbIndexDato).NumeroCompleto   := sbNumeroCompleto;
            otbltytCanalDiez(sbIndexDato).IDOrdenamiento   := v_tbltytInfoCargos(sbIndex).ORDENAMIENTO;
            otbltytCanalDiez(sbIndexDato).Concepto         := v_tbltytInfoCargos(sbIndex).CONCEPTO_ID;
            otbltytCanalDiez(sbIndexDato).Descripcion      := v_tbltytInfoCargos(sbIndex).DESC_CONCEP;
            otbltytCanalDiez(sbIndexDato).SaldoAnterior    := v_tbltytInfoCargos(sbIndex).SALDO_ANT;
            otbltytCanalDiez(sbIndexDato).Capital          := v_tbltytInfoCargos(sbIndex).CAPITAL;
            otbltytCanalDiez(sbIndexDato).Intereses        := v_tbltytInfoCargos(sbIndex).INTERES;
            otbltytCanalDiez(sbIndexDato).Total            := v_tbltytInfoCargos(sbIndex).TOTAL;
            otbltytCanalDiez(sbIndexDato).SaldoDiferido    := v_tbltytInfoCargos(sbIndex).SALDO_DIF;
            otbltytCanalDiez(sbIndexDato).UnidadDelItem    := v_tbltytInfoCargos(sbIndex).UNIDAD_ITEMS;
            otbltytCanalDiez(sbIndexDato).CantidadDelItem  := v_tbltytInfoCargos(sbIndex).CANTIDAD;
            otbltytCanalDiez(sbIndexDato).ValorUnitario    := v_tbltytInfoCargos(sbIndex).VALOR_UNITARIO;
            otbltytCanalDiez(sbIndexDato).IVA              := v_tbltytInfoCargos(sbIndex).VALOR_IVA;
            otbltytCanalDiez(sbIndexDato).CuotasFaltantes  :=v_tbltytInfoCargos(sbIndex).CUOTAS;

            sbIndex := v_tbltytInfoCargos.NEXT(sbIndex);
         EXIT WHEN sbIndex IS NULL;
        END LOOP;
    ELSE
        otbltytCanalDiez(1).NroCanal	     := '10';
        otbltytCanalDiez(1).NumeroCompleto	 := sbNumeroCompleto;
        otbltytCanalDiez(1).IDOrdenamiento	 := '';
        otbltytCanalDiez(1).Descripcion	     := '';
        otbltytCanalDiez(1).SaldoAnterior	 := '';
        otbltytCanalDiez(1).Capital	         := '';
        otbltytCanalDiez(1).Intereses        := '';
        otbltytCanalDiez(1).Total	         := '';
        otbltytCanalDiez(1).SaldoDiferido	 := '';
        otbltytCanalDiez(1).UnidadDelItem    := '';
        otbltytCanalDiez(1).CantidadDelItem  := '';
        otbltytCanalDiez(1).ValorUnitario    := '';
        otbltytCanalDiez(1).IVA              := '';
        otbltytCanalDiez(1).CuotasFaltantes  := '';
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
  END prGetInfoCanalDiez;

  PROCEDURE prGetInfoCanalSiete( otytCanalSiete    OUT  tytCanalSiete) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCanalSiete
    Descripcion     : retorna informacion para canal siete facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-01-2024

    Parametros de Entrada

    Parametros de Salida
      prGetInfoCanalSiete    tabla con registro de canal siete
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        22-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoCanalSiete';
    PROCEDURE prInicializarValores IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prInicializarValores';
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializarValores;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    otytCanalSiete.NroCanal		  := '7';
    otytCanalSiete.NumeroCompleto := sbNumeroCompleto;
    otytCanalSiete.Opcional81     := '';
    otytCanalSiete.Opcional82     := '';
    otytCanalSiete.Opcional83     := '';
    otytCanalSiete.Opcional84     := '';
    otytCanalSiete.Opcional85     := '';
    otytCanalSiete.Opcional86     := '';
    otytCanalSiete.Opcional87     := '';
    otytCanalSiete.Opcional88     := '';
    otytCanalSiete.Opcional89     := '';
    otytCanalSiete.Opcional90     := '';
    otytCanalSiete.Opcional91     := '';
    otytCanalSiete.Opcional92     := '';
    otytCanalSiete.Opcional93     := '';
    otytCanalSiete.Opcional94     := '';
    otytCanalSiete.Opcional95     := '';
    otytCanalSiete.Opcional96     := '';
    otytCanalSiete.Opcional97     := '';
    otytCanalSiete.Opcional98     := '';
    otytCanalSiete.Opcional99     := '';
    otytCanalSiete.Opcional100    := '';

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
  END prGetInfoCanalSiete;

  FUNCTION fsbGetFacturaElec RETURN factura_elect_general.consfael%TYPE  IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbGetFacturaElec
    Descripcion     : funcion para devolver factura electronica
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 07-06-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       07-06-2024   OSF-2158    Creacion
  ***************************************************************************/
   csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.fsbGetFacturaElec';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    RETURN sbNumeroCompleto;
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
  END fsbGetFacturaElec;

  FUNCTION fsbGetPrefijo RETURN factura_elect_general.consfael%TYPE  IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbGetPrefijo
    Descripcion     : funcion para devolver prefijo factura electronica
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 07-06-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       07-06-2024   OSF-2158    Creacion
  ***************************************************************************/
   csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.fsbGetPrefijo';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    RETURN sbPrefijo;
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
  END fsbGetPrefijo;
END PKG_BCFACTUELECTRONICAGEN;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BCFACTUELECTRONICAGEN','PERSONALIZACIONES');
END;
/