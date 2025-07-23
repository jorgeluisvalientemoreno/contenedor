create or replace PACKAGE   personalizaciones.pkg_boldcgpad IS

  FUNCTION fsbVersion RETURN VARCHAR2;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 22-01-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      22-01-2025   OSF-3650    Creacion
  ***************************************************************************/
  PROCEDURE prcObjeto(inuCiclo  IN  NUMBER);
 /***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcObjeto
	Descripcion     : proceso de ejecucion de la forma LDCGPAD

	Autor           : Luis Javier Lopez Barrios
	Fecha           : 22-01-2025

	Parametros de Entrada
       inuCiclo   codigo del ciclo
	Parametros de Salida

	Modificaciones  :
	=========================================================
	Autor       Fecha       Caso       Descripcion
	LJLB      22-01-2025   OSF-3650    Creacion
 ***************************************************************************/
end pkg_boldcgpad;
/
create or replace PACKAGE body personalizaciones.pkg_boldcgpad IS
  csbSP_NAME        CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion          CONSTANT VARCHAR2(15) := 'OSF-3650';
  nuError             NUMBER;
  sbError             VARCHAR2(4000);

  TYPE tytbNumber  IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 22-01-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      22-01-2025   OSF-3650    Creacion
  ***************************************************************************/
   csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fsbVersion';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('csbVersion => ' || csbVersion, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    RETURN csbVersion;
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
  END fsbVersion;


  PROCEDURE prcValidaInfoAboDife ( inuContrato    IN  NUMBER,
                                   onuPerioActual OUT NUMBER,
                                   onuError       OUT NUMBER,
                                   osbError       OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcValidaInfoAboDife
    Descripcion     : valida informacion para abono a diferido del contrato
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 21-01-2025

    Parametros Entrada
     inuContrato    codigo del contrato
    Parametros de salida
     onuPerioActual  periodo de facturacion actual
     onuerror        codigo de error 0 - exito -1 error
     osbError        mensaje de error

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      21-01-2025   OSF-3650    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcValidaInfoAboDife';
    dtFechaFin      DATE;
    nuCiclo         NUMBER;
    nuCantDif       NUMBER;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuContrato => ' || inuContrato, pkg_traza.cnuNivelTrzDef);
    pkg_error.prInicializaError(onuError,osbError );

    pkg_bcldcgpad.prcObtInfoAboDifexVali ( inuContrato,
                                           onuPerioActual,
                                            dtFechaFin,
                                            nuCiclo ,
                                            nuCantDif,
                                            onuError ,
                                            osbError );

    IF onuError <> 0 THEN
       RETURN;
    END IF;

    IF nuCiclo IS NULL THEN
        onuError := -1;
        osberror := 'Contrato ['||inuContrato||'] no existe, por favor valide.';
    END IF;

    IF onuPerioActual IS NULL THEN
        onuError := -1;
        osberror := osberror||CHR(10)||'Contrato ['||inuContrato||'] no tiene periodo de facturacion actual';
    END IF;

    IF dtFechaFin < SYSDATE THEN
       onuError := -1;
       osberror := osberror||CHR(10)||'La fecha final de movimiento del periodo ['||onuPerioActual||'] no puede ser menor a la fecha del sistema';
    END IF;

    IF nuCantDif = 0 THEN
      onuError := -1;
      osberror := osberror||CHR(10)||'Contrato ['||inuContrato||'] no tiene diferidos pendientes';
    END IF;

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
 END prcValidaInfoAboDife;

  PROCEDURE prcGeneraAbonDiferido( inuContrato   IN   servsusc.sesususc%type,
                                   onuError      OUT  NUMBER,
                                   osbError      OUT  VARCHAR2) IS
 /***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcGeneraAbonDiferido
	Descripcion     : Generar abono a diferido

	Autor           : Luis Javier Lopez Barrios
	Fecha           : 2022-11-22

	Parametros de Entrada
	   inuContrato      codigo de contrato
	Parametros de Salida
	   onuError      codigo de error
	   osbError      mensaje de error
	Modificaciones  :
	=========================================================
	Autor         Fecha       Caso       Descripcion
	LJLB          2022-11-22   OSF-3650    Creacion
    diana.montes  13/07/2023   OSF-1246: se pasa la creacion de la nota al metodo
                                   prcTrasladoDifeCorriente.
    diana.montes  25/05/2023   OSF-1116: se realiza la creacion de la nota, tan
                                     pronto se realiza la creacion de la cuenta de cobro
                                     y se envia el numero de la nota en la creacion de
                                     cargos realizada en prcTrasladoDifeCorriente.
 ***************************************************************************/
   csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcGeneraAbonDiferido';

   nuFactura    factura.factcodi%type;
   nuValorAmort   NUMBER := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('LDC_VALOR_AMORTIZA');
   nPorcAmort     NUMBER := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('LDC_PORCENT_AMORTIZA_CONS');
   nuValorTran    NUMBER := 0;
   nuValorProc    NUMBER  := 0;
   nuProducto     NUMBER;
   nuprodAnte     NUMBER := -1;

   nucuentaCobro  NUMBER;
   nuProgFactura  NUMBER := 6;

   tblProduProc  tytbNumber;
   tblCuentaProd tytbNumber;
   nuPerioActual  NUMBER;
   v_tytblDiferidos pkg_bcldcgpad.tytblDiferidos;
   reg   VARCHAR2(20);
   nuDiferido  NUMBER;

   PROCEDURE prcValidaAbonoDife IS
      csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prcValidaAbonoDife';
   BEGIN
     pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

     IF nuValorAmort IS NULL THEN
        onuError := -1;
        osberror := 'Parametro LDC_VALOR_AMORTIZA no esta definido';
        Pkg_Error.SetErrorMessage(isbMsgErrr =>  osberror);
     END IF;

     IF nPorcAmort IS NULL THEN
        onuError := -1;
        osberror := 'Parametro LDC_PORCENT_AMORTIZA_CONS no esta definido';
        Pkg_Error.SetErrorMessage(isbMsgErrr =>  osberror);
     END IF;

     prcValidaInfoAboDife ( inuContrato,
                            nuPerioActual,
                            onuError,
                            osberror);
     IF onuError <> 0 THEN
        Pkg_Error.SetErrorMessage(isbMsgErrr =>  osberror);
     END IF;

     pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
   END prcValidaAbonoDife;

   PROCEDURE prcInicializaValores IS
      csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prcInicializaValores';
   BEGIN
     pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

     pkg_error.prInicializaError(onuError,osbError );
     tblProduProc.DELETE;
     tblCuentaProd.DELETE;
     v_tytblDiferidos.DELETE;
     nuValorTran := 0;

     pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
   END prcInicializaValores;

 BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuContrato => ' || inuContrato, pkg_traza.cnuNivelTrzDef);
    prcInicializaValores;

    prcValidaAbonoDife;

    nuFactura := pkg_bcldcgpad.fnuObtFacturaxPeriodo(inuContrato, nuPerioActual);

    IF nuFactura IS NULL THEN
       pkg_bogestion_facturacion.prcCreaFactura( inuContrato,
                                                 nuProgFactura,
                                                 TRUE,
                                                 nuFactura,
                                                 onuError,
                                                 osbError );
       IF onuError <> 0 THEN
          Pkg_Error.SetErrorMessage(isbMsgErrr =>  osberror);
       END IF;
       nuValorTran := nuValorAmort;
    ELSE
       nuValorTran := pkg_bcldcgpad.fnuObtValorConsumo ( nuFactura, nuPerioActual);

       IF nuValorTran = 0 then
          nuValorTran := nuValorAmort;
       ELSE
          nuValorTran := ROUND(nuValorTran * (nPorcAmort/100),0);
       END IF;
    END IF;
    v_tytblDiferidos :=   pkg_bcldcgpad.ftblObtDiferidosaProc(inuContrato);
    pkg_traza.trace(' nuValorTran '||nuValorTran, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' Total registros '||v_tytblDiferidos.COUNT, pkg_traza.cnuNivelTrzDef);
    IF v_tytblDiferidos.COUNT > 0 THEN
        reg := v_tytblDiferidos.FIRST;
        LOOP
            EXIT WHEN reg IS NULL;
            nucuentaCobro := NULL;
            onuError :=  0;
            nuDiferido := v_tytblDiferidos(reg).nuDiferido;
            IF NVL(nuValorTran, 0 ) > 0 THEN
                IF  NOT tblProduProc.exists(v_tytblDiferidos(reg).nuProducto) THEN
                    nucuentaCobro := pkg_bcldcgpad.fnuObtCuentaCobro(nuFactura, v_tytblDiferidos(reg).nuProducto);
                   IF nucuentaCobro IS NULL  THEN
                       pkg_bogestion_facturacion.prcCreaCuentaCobro( v_tytblDiferidos(reg).nuProducto,
                                                                     inuContrato,
                                                                     nuFactura,
                                                                     nucuentaCobro,
                                                                     onuError,
                                                                     osbError);


                      IF onuError <> 0 THEN
                         EXIT;
                      END IF;
                  END IF;
                  tblCuentaProd(v_tytblDiferidos(reg).nuProducto) := nucuentaCobro;
                  tblProduProc(v_tytblDiferidos(reg).nuProducto) := v_tytblDiferidos(reg).nuProducto;
                ELSE
                   nucuentaCobro := tblCuentaProd(v_tytblDiferidos(reg).nuProducto);
                END IF;

                IF nuValorTran > v_tytblDiferidos(reg).nuSaldoDife THEN
                    nuValorTran := nuValorTran - v_tytblDiferidos(reg).nuSaldoDife;
                    nuValorProc := v_tytblDiferidos(reg).nuSaldoDife;
                ELSE
                    nuValorProc :=nuValorTran;
                    nuValorTran := 0;
                END IF;
                --se realiza proceso de traslado dpmh crea cargo
                pkg_bofinanciacion.prcTrasladoDifeaCorriente ( v_tytblDiferidos(reg).nuDiferido,
                                                               nuValorProc,
                                                               nucuentaCobro,
                                                               nuPerioActual,
                                                               onuError,
                                                               osbError);

                IF onuError <> 0 THEN
                   pkg_traza.trace(' Diferido osbError => ' || v_tytblDiferidos(reg).nuDiferido||' '||osbError, pkg_traza.cnuNivelTrzDef);
                   EXIT;
                END IF;
             ELSE
               
               pkg_traza.trace(' salgo porque no hay valor '||nuValorTran, pkg_traza.cnuNivelTrzDef);
               EXIT;
             END IF;             
             reg := v_tytblDiferidos.NEXT(reg);
        END LOOP;
    END IF;

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
 END prcGeneraAbonDiferido;

 PROCEDURE prcObjeto(inuCiclo  IN  NUMBER) IS
 /***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcObjeto
	Descripcion     : proceso de ejecucion de la forma LDCGPAD

	Autor           : Luis Javier Lopez Barrios
	Fecha           : 22-01-2025

	Parametros de Entrada
      inuCiclo   codigo del ciclo
	Parametros de Salida

	Modificaciones  :
	=========================================================
	Autor       Fecha       Caso       Descripcion
	LJLB      22-01-2025   OSF-3650    Creacion
 ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcObjeto';
    nuerror  NUMBER;
    sbError  VARCHAR2(4000);
    nuRegProcesados NUMBER := 0;
    nuIdReporte   NUMBER;
    nuConsecutivo NUMBER := 0;
    nuContrato    NUMBER;
    sbProceso     VARCHAR2(100) :='LDCGPAD'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS') ;
    rcPeriodo     perifact%ROWTYPE;
    nuIdProceso   NUMBER;
    v_tytblContratos   pkg_bcldcgpad.tytblContratos;
    sbIndex  VARCHAR2(20);
 BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuCiclo => ' || inuCiclo, pkg_traza.cnuNivelTrzDef);
    pkg_estaproc.prinsertaestaproc( sbProceso , 0);
    nuIdReporte :=  pkg_reportes_inco.fnuCrearCabeReporte('LDCGPAD', 'INCONSISTENCIAS PROCESO DE PLAN PILOTO ABONO A DIFERIDO');
    v_tytblContratos := pkg_bcldcgpad.ftblObtContratosaProc(inuCiclo);
    
    IF v_tytblContratos.COUNT > 0 THEN
      sbIndex := v_tytblContratos.FIRST;
      LOOP
          EXIT WHEN sbIndex IS NULL;
          nuerror := 0;
          nuContrato := v_tytblContratos(sbIndex).nuContrato;
          nuRegProcesados := nuRegProcesados  + 1;
           pkg_traza.trace(' procesando contrato => ' || nuContrato, pkg_traza.cnuNivelTrzDef);
          BEGIN
              prcGeneraAbonDiferido(nuContrato, nuError, sbError);
              IF nuerror = 0 THEN
                 COMMIT;
              ELSE
                nuConsecutivo := nuConsecutivo  + 1;
                pkg_reportes_inco.prCrearDetalleRepo( nuIdReporte,
                                                      nuContrato,
                                                      sbError,
                                                      'Error en proceso contrato',
                                                      nuConsecutivo);
                ROLLBACK;
              END IF;
          EXCEPTION 
             WHEN OTHERS THEN
                pkg_error.geterror(nuerror,sbError);
                nuConsecutivo := nuConsecutivo  + 1;
                pkg_reportes_inco.prCrearDetalleRepo( nuIdReporte,
                                                      nuContrato,
                                                      sbError,
                                                      'Error en proceso contrato',
                                                      nuConsecutivo);
                ROLLBACK;
          END ;
          sbIndex := v_tytblContratos.NEXT(sbIndex);
       END LOOP;
    
    END IF;
    --se regiatra proceso en procejec
    rcPeriodo := pkg_bogestionperiodos.frcObtPeriodoFacturacionActual(inuCiclo);


    pkg_bogestionejecucionprocesos.prcInsertaRegistroEjec( 'LDCGPAD',
                                                            rcPeriodo.pefacodi,
                                                            -1,
                                                            nuIdProceso );

    pkg_bogestionejecucionprocesos.prcActualizaRegistroEjec(nuIdProceso);
    COMMIT;
    pkg_estaproc.prActualizaAvance ( sbProceso, 'Ok', nuRegProcesados, nuRegProcesados );
    pkg_estaproc.practualizaestaproc(isbproceso => sbProceso);

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' osbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        nuConsecutivo := nuConsecutivo  + 1;
        pkg_reportes_inco.prCrearDetalleRepo( nuIdReporte,
                                              nuContrato,
                                              sbError,
                                              'Error en proceso contrato',
                                              nuConsecutivo);
        pkg_estaproc.practualizaestaproc( sbProceso, 'Error ', sbError  );
        ROLLBACK;
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        nuConsecutivo := nuConsecutivo  + 1;
        pkg_reportes_inco.prCrearDetalleRepo( nuIdReporte,
                                              nuContrato,
                                              sbError,
                                              'Error en proceso contrato',
                                              nuConsecutivo);
        pkg_estaproc.practualizaestaproc( sbProceso, 'Error ', sbError  );
        ROLLBACK;
        RAISE pkg_error.CONTROLLED_ERROR;
 END prcObjeto;
end pkg_boldcgpad;  
/
Prompt Otorgando permisos sobre PERSONALIZACIONES.PKG_BOLDCGPAD
BEGIN
    pkg_Utilidades.prAplicarPermisos('PKG_BOLDCGPAD', 'PERSONALIZACIONES');
END;
/