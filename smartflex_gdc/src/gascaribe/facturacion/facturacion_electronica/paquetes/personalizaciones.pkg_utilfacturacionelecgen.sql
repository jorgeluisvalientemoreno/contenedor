create or replace PACKAGE  personalizaciones.pkg_UtilFacturacionElecGen IS
     -- Obtiene los argumentos de un método
    CURSOR cuArgumentos( isbPack VARCHAR2, isbApi VARCHAR2) IS
    SELECT ARGUMENT_NAME, DATA_TYPE, POSITION, rpad('','',100) VALUE
    FROM user_arguments
    WHERE NVL(PACKAGE_NAME,'-') = NVL(isbPack,'-')
    AND OBJECT_NAME = isbApi
    AND DATA_TYPE IS NOT NULL;
	 

    TYPE TYTRCPROGRAMA IS RECORD(
        PROGRAM_NAME VARCHAR2(100),
        PACKAGE VARCHAR2(100),
        API VARCHAR2(100),
        PROGRAM_TYPE VARCHAR2(50),
        BLOQUEPL VARCHAR2(4000),
        STEP VARCHAR2(50),
        PROGRAM_ACTION VARCHAR2(4000)
    );

    -- Tipo de dato para los argumentos de un método
    TYPE tbltytArgumentos      IS TABLE OF cuArgumentos%ROWTYPE INDEX BY VARCHAR2(100);

    TYPE tbltytSchedChainProg IS TABLE OF TYTRCPROGRAMA INDEX BY BINARY_INTEGER;
	
	tbDatosEmpresa pkg_empresa.tytbInfoEmpresas;
	

    FUNCTION ftbArgumentos( isbPack IN VARCHAR2,
                            isbApi  IN VARCHAR2)  RETURN tbltytArgumentos;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : ftbArgumentos
        Descripcion     : Retorna una tabla pl con la información de los argumentos de un metodo

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 26-01-2024

        Parametros de Entrada
          isbPack      nombre de paquete
          isbApi       nombre de paquete
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       26-01-2024   OSF-2158    Creacion
    ***************************************************************************/

    PROCEDURE prIniCadenaJobs;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prIniCadenaJobs
        Descripcion     : proceso que inicializa cadena de jobs

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 26-01-2024

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       26-01-2024   OSF-2158    Creacion
    ***************************************************************************/

    PROCEDURE prHiloCadenaJobs ( inuPeriodo    IN  NUMBER,
                                 inuCodigoLote IN  NUMBER,
                                 inuTipoDocu   IN  NUMBER,
                                 isbProceso    IN  VARCHAR2,
                                 isbOperacion  IN  VARCHAR2,
                                 inuTotalHilo  IN NUMBER,
                                 inuHilo       IN  NUMBER
                                 );
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prHiloCadenaJobs
        Descripcion     : proceso cada hilo de cadena de jobs

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 26-01-2024

        Parametros de Entrada
           inuPeriodo       periodo_facturacion
           inuCodigoLote    codigo del lote
           inuTipoDocu      tipo de documento
           isbProceso       nombre del proceso
           isbOperacion     operacion a realizar I - Insertar A - Actualizar
           inuTotalHilo     total hilo
           inuHilo          numero del hilo
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       26-01-2024   OSF-2158    Creacion
    ***************************************************************************/

    PROCEDURE prFinCadenaJobs( inuPeriodo    IN  NUMBER,
                               inuCodigoLote IN  NUMBER,
                               isbProceso    IN  VARCHAR2,
                               isbOperacion  IN  VARCHAR2,
                               inuTotalHilo  IN  NUMBER);
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prFinCadenaJobs
        Descripcion     : proceso para finalizar la cadena de jobs

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 26-01-2024

        Parametros de Entrada
           inuPeriodo     codigo del periodo de facturacion
          inuCodigoLote  codigo de lote
          isbProceso     nombre de proceso estaproc
          isbOperacion   operacion a realizar A - Actualizar, I - Insertar
          inuTotalHilo   cantidad de hilo
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       26-01-2024   OSF-2158    Creacion
    ***************************************************************************/
    PROCEDURE prCreaCadenaJobs( isbChainJobs IN  VARCHAR2,
                                inuPeriodo   IN  NUMBER,
                                inuTotalHilo  IN  NUMBER,
                                isbPrograma   IN VARCHAR2,
								inuConsecutivo in number);
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prCreaCadenaJobs
        Descripcion     : proceso que crea la cadena de Jobs del proceso masivo

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 26-01-2024

        Parametros de Entrada
          isbChainJobs  nombre de la cadena de jobs
          inuPeriodo    codigo del periodo de facturacion
          inuTotalHilo   total de hilo
          isbPrograma    programa en ejecucion
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       26-01-2024   OSF-2158    Creacion
    ***************************************************************************/
    --
    PROCEDURE prCrearProcMasivo;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prCreaCadenaJobs
        Descripcion     : Proceso masivo de facturacion electronica

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 26-01-2024

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       26-01-2024   OSF-2158    Creacion
    ***************************************************************************/

     PROCEDURE prCrearProcMasivoVenta;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prCrearProcMasivoVenta
        Descripcion     : procesa para la Creacion de cadena de Jobs del proceso masivo para ventas

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 15-05-2024

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       15-05-2024   OSF-2158    Creacion
    ***************************************************************************/
     PROCEDURE prActualizaEstrFactElec(  inuFactura   IN   NUMBER,
                                         inuCodigoLote IN  NUMBER,
                                         isbOperacion  IN  VARCHAR2,
                                         inuTipoDocu   IN  NUMBER,
                                         InuIdReporte   IN NUMBER,
                                         onuError     OUT  NUMBER,
                                         osbError     OUT  VARCHAR2);
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prActualizaEstrFactElec
        Descripcion     : proceso para generar estructura de facturacion electronica

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 17-01-2024

        Parametros de Entrada
          inuFactura       codigo de la factura
          inuCodigoLote    codigo de lote
          isbOperacion    Operacion a realizar I - Insertar A -Actualizar
          inuTipoDocu     tipo de documento a generar
          InuIdReporte    codigo de reporte
        Parametros de Salida
          onuError        codigo del error
          osbError        mensaje de error
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB        17-01-2024  OSF-2158    Creacion
      ***************************************************************************/
      PROCEDURE prCrearProcMasivoNotas;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prCrearProcMasivoNotas
        Descripcion     : procesa para la Creacion de cadena de Jobs del proceso masivo para notas

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 09-07-2024

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       09-07-2024   OSF-2158    Creacion
    ***************************************************************************/

     PROCEDURE prJobEliminarRegFactElect ;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prJobEliminarRegFactElect
        Descripcion     : job que se encarga de eliminar las facturas /notas enviadas a la Dian

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 13-09-2024

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       13-09-2024   OSF-3239    Creacion
    ***************************************************************************/
                          
								
	PROCEDURE prcCrearLoteMasivoVenta (isbCodEmpresa	IN VARCHAR2);

	    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcCrearLoteMasivoVenta
        Descripcion     : Crear lote masivo para facturas de venta

        Autor           : Jhon Soto
        Fecha           : 27-03-2025

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
    ***************************************************************************/
	
	PROCEDURE prcCrearLoteMasivoNotas (isbCodEmpresa IN VARCHAR2);
		    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcCrearLoteMasivoNotas
        Descripcion     : Crear lote masivo para notas

        Autor           : Jhon Soto
        Fecha           : 27-03-2025

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
    ***************************************************************************/
	
END pkg_UtilFacturacionElecGen;
/
create or replace PACKAGE BODY personalizaciones.pkg_UtilFacturacionElecGen IS
   csbProgram       VARCHAR2(2000) := 'JOBFAELGE';

	-- Declaracion de variables y tipos globales privados del paquete
   CsbChainJobs    VARCHAR2(30) := 'FACTELEC';
   --isbChainJobs    VARCHAR2(30) := 'CADENA_JOBFAEL';
   nuError         NUMBER;
   sbError         VARCHAR2(4000);

   v_tbSchedChainProg  tbltytSchedChainProg;
   V_TYTRCPROGRAMA TYTRCPROGRAMA;
   V_TYTRCPROGRAMAnull TYTRCPROGRAMA;
   -- Versión del paquete
   csbVersion              CONSTANT VARCHAR2(15) := 'OSF-4104';
   -- Para el control de traza:
   csbSP_NAME              CONSTANT VARCHAR2(32) := $$PLSQL_UNIT;
   csbNivelTraza           CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
   nuIntentoRep             NUMBER := pkg_parametros.fnuGetValorNumerico('NUMERO_INTENTOS_FAELGEN');
   sbProgramaExcluir    VARCHAR2(4000) := pkg_parametros.fsbgetvalorcadena('PROGRAMAS_EXCLUIR_NOTAS_FAEL');
   dtFechaInicial     DATE := TRUNC(SYSDATE);
   dtFechaFinal       DATE := SYSDATE;


   FUNCTION ftbArgumentos( isbPack IN VARCHAR2,
                           isbApi  IN VARCHAR2)  RETURN tbltytArgumentos IS
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : ftbArgumentos
        Descripcion     : Retorna una tabla pl con la información de los argumentos de un metodo

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 26-01-2024

        Parametros de Entrada
          isbPack      nombre de paquete
          isbApi       nombre de paquete
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       26-01-2024   OSF-2158    Creacion
   ***************************************************************************/
     csbMetodo        CONSTANT VARCHAR2(100) := csbSP_NAME ||  '.ftbArgumentos';

     tbArgumentos tbltytArgumentos;

     TYPE tytbArgumentosD IS TABLE OF cuArgumentos%ROWTYPE    INDEX BY BINARY_INTEGER;

     tbArgumentosD tytbArgumentosD;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pkg_Traza.trace('isbPack|' ||isbPack || '|isbApi|' || isbApi,csbNivelTraza);

        OPEN cuArgumentos( isbPack, isbApi );
        FETCH cuArgumentos BULK COLLECT INTO tbArgumentosD;
        CLOSE cuArgumentos;

        pkg_Traza.trace('tbArgumentosD.COUNT|' ||tbArgumentosD.COUNT,csbNivelTraza);

        IF tbArgumentosD.COUNT > 0 THEN
            FOR ind IN 1..tbArgumentosD.COUNT LOOP
                tbArgumentos( tbArgumentosD(ind).argument_name ) := tbArgumentosD(ind);
            END LOOP;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN tbArgumentos;
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END ftbArgumentos;

    PROCEDURE prIniCadenaJobs IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prIniCadenaJobs
        Descripcion     : proceso que inicializa cadena de jobs

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 26-01-2024

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       26-01-2024   OSF-2158    Creacion
    ***************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(100) := csbSP_NAME || '.prIniCadenaJobs';

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END prIniCadenaJobs;

    PROCEDURE prHiloCadenaJobs ( inuPeriodo    IN  NUMBER,
                                 inuCodigoLote IN  NUMBER,
                                 inuTipoDocu   IN  NUMBER,
                                 isbProceso    IN  VARCHAR2,
                                 isbOperacion  IN  VARCHAR2,
                                 inuTotalHilo  IN NUMBER,
                                 inuHilo       IN  NUMBER) IS
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prHiloCadenaJobs
        Descripcion     : proceso que realiza el hilado de las cadenas  de jobs

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 26-01-2024

        Parametros de Entrada
           inuPeriodo       periodo_facturacion
           inuCodigoLote    codigo del lote
           inuTipoDocu      tipo de documento
           isbProceso       nombre del proceso
           isbOperacion     operacion a realizar I - Insertar A - Actualizar
           inuTotalHilo     total hilo
           inuHilo          numero del hilo
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       26-01-2024   OSF-2158    Creacion
    ***************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(100) := csbSP_NAME ||  '.prHiloCadenaJobs';

        nuErrorCode         number;
        sbErrorMessage      VARCHAR2(4000);
        nuCount             NUMBER;
        nuRegist            NUMBER := 0;
        nuTotal             NUMBER;
        nuConsecutivo       NUMBER := 0;
        nuIdReporte         NUMBER;
        nuFactura            NUMBER;
        sbProcesoInt        VARCHAR2(100) :=(isbProceso)||'_'||to_char(inuHilo) ;
		sbEmpresa			VARCHAR2(10);

        CURSOR cuGetFactRecuProcesar IS
        SELECT *
		FROM ( SELECT factura.factcodi
				FROM factura
				WHERE factura.factpefa = inuPeriodo
				   AND factprog = 6
				   AND NOT EXISTS ( SELECT 1
									FROM factura_elect_general
									WHERE factura_elect_general.tipo_documento = inuTipoDocu
									 AND factura_elect_general.documento = to_char(factura.factcodi)
									 UNION ALL
									 SELECT 1
									 FROM facturas_emitidas
									 WHERE facturas_emitidas.tipo_documento = inuTipoDocu
									   AND facturas_emitidas.documento = to_char(factura.factcodi) )
			) factura
		WHERE mod(factura.factcodi, inuTotalHilo )+ 1 = inuHilo;

        TYPE tblFacturas  IS TABLE OF cuGetFactRecuProcesar%ROWTYPE;
        v_tblFacturas   tblFacturas;

        

        CURSOR cuGetDocuActualizar IS
        SELECT factura_elect_general.documento
        FROM factura_elect_general
        WHERE tipo_documento = inuTipoDocu
           AND factura_elect_general.codigo_lote = inuCodigoLote
           AND mod(factura_elect_general.documento, inuTotalHilo )+ 1 = inuHilo;


        PROCEDURE prCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(105) := csbMetodo || '.prCierraCursores';
        BEGIN
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);
            IF cuGetFactRecuProcesar%ISOPEN THEN
                CLOSE cuGetFactRecuProcesar;
            END IF;

            IF cuGetDocuActualizar%ISOPEN THEN
                CLOSE cuGetDocuActualizar;
            END IF;

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);
        END prCierraCursores;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        pkg_estaproc.prinsertaestaproc( sbProcesoInt , 0);
        nuIdReporte := null;

        nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( 'JOBFAELGE',
                                                            'Job de facturacion electronica recurrente');
        pkg_traza.trace(' nuIdReporte => ' || nuIdReporte, pkg_traza.cnuNivelTrzDef);

        prCierraCursores;

        -- Inicializa contador de productos procesados
        nuCount  := 0;
        nuRegist := 0;
        nuTotal  := 0;
             -- se valida si se va hacer el proceso para facturacion recurrente
        IF InuTipoDocu = PKG_BCFACTUELECTRONICAGEN.cnuTipoDocuFactRecu AND isbOperacion = 'I' THEN
            --se realiza proceso de facturacion electronica
            OPEN cuGetFactRecuProcesar;
            LOOP
            FETCH cuGetFactRecuProcesar BULK COLLECT INTO v_tblFacturas LIMIT 100;
             nuTotal := nuTotal  + v_tblFacturas.COUNT;
              nufactura:=  null;
              FOR idx IN 1..v_tblFacturas.COUNT LOOP

                  nuErrorCode := 0;
                  nuFactura :=  v_tblFacturas(idx).factcodi;
				  
				  sbEmpresa := pkg_lote_fact_electronica.fsbObtCodEmpresa(inuCodigoLote);
              
                  PKG_BOFACTUELECTRONICAGEN.prGenerarEstrFactElec( inuFactura => nuFactura,
                                                                   inuCodigoLote => inuCodigoLote,
                                                                   isbOperacion => isbOperacion,
                                                                   inuTipoDocu => InuTipoDocu,
                                                                   inuIdReporte => nuIdReporte,
																   isbCodEmpresa => sbEmpresa,
                                                                   onuError => nuErrorCode,
                                                                   osbError => sbErrorMessage);

                  IF nuErrorCode <> 0 THEN
                     ROLLBACK;
                  ELSE
                     nuRegist := nuRegist + 1;
                     COMMIT;
                  END IF;
                  pkg_estaproc.prActualizaAvance( sbProcesoInt,
                                                  'Procesando factura '||v_tblFacturas(idx).factcodi,
                                                   nuRegist,
                                                   nuTotal);
              END LOOP;
              EXIT   WHEN cuGetFactRecuProcesar%NOTFOUND;
            END LOOP;
            CLOSE cuGetFactRecuProcesar;

        END IF;

        IF isbOperacion = 'A' THEN
             --se realiza proceso de facturacion electronica
             OPEN cuGetDocuActualizar;
             LOOP
                FETCH cuGetDocuActualizar BULK COLLECT INTO v_tblFacturas LIMIT 100;
                 nuTotal := nuTotal  + v_tblFacturas.COUNT;
                  nufactura:=  null;
                  FOR idx IN 1..v_tblFacturas.COUNT LOOP

                      nuErrorCode := 0;
                      nuFactura :=  v_tblFacturas(idx).factcodi;
					  
			  
					  sbEmpresa := pkg_lote_fact_electronica.fsbObtCodEmpresa(inuCodigoLote);
                      
                      PKG_BOFACTUELECTRONICAGEN.prGenerarEstrFactElec( inuFactura => nuFactura,
                                                                       inuCodigoLote => inuCodigoLote,
                                                                       isbOperacion => isbOperacion,
                                                                       inuTipoDocu => InuTipoDocu,
                                                                       inuIdReporte => nuIdReporte,
																	   isbCodEmpresa => sbEmpresa,
                                                                       onuError => nuErrorCode,
                                                                       osbError => sbErrorMessage);
                                                                   
                      IF nuErrorCode <> 0 THEN
                         ROLLBACK;
                      ELSE
                         nuRegist := nuRegist + 1;
                         COMMIT;
                      END IF;
                      pkg_estaproc.prActualizaAvance( sbProcesoInt,
                                                      'Procesando factura '||v_tblFacturas(idx).factcodi,
                                                       nuRegist,
                                                       nuTotal);
                  END LOOP;
                  EXIT   WHEN cuGetDocuActualizar%NOTFOUND;
                END LOOP;
                CLOSE cuGetDocuActualizar;
        END IF;
        pkg_estaproc.practualizaestaproc(isbproceso => sbProcesoInt);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN
            pkg_error.getError(nuErrorCode,sbErrorMessage);
            pkg_traza.trace(' sbErrorMessage => ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
            prCierraCursores;
            pkg_estaproc.practualizaestaproc( sbProcesoInt, 'Error ', sbErrorMessage  );
            nuConsecutivo := nuConsecutivo + 1;
            pkg_reportes_inco.prCrearDetalleRepo( nuIdReporte,
                                                   nuFactura,
                                                   sbErrorMessage,
                                                   'S',
                                                   nuConsecutivo );
            rollback;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuErrorCode,sbErrorMessage);
            pkg_traza.trace(' sbErrorMessage => ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
            prCierraCursores;
            pkg_estaproc.practualizaestaproc( sbProcesoInt, 'Error ', sbErrorMessage  );
            nuConsecutivo := nuConsecutivo + 1;
            pkg_reportes_inco.prCrearDetalleRepo( nuIdReporte,
                                                   nuFactura,
                                                   sbErrorMessage,
                                                   'S',
                                                   nuConsecutivo );
            rollback;
    END prHiloCadenaJobs;

    PROCEDURE prFinCadenaJobs( inuPeriodo    IN  NUMBER,
                               inuCodigoLote IN  NUMBER,
                               isbProceso    IN  VARCHAR2,
                               isbOperacion  IN  VARCHAR2,
                               inuTotalHilo  IN  NUMBER) IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prFinCadenaJobs
        Descripcion     : Programa que se ejecuta en el último paso de la cadena de job

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 29-01-2024

        Parametros de Entrada
          inuPeriodo     codigo del periodo de facturacion
          inuCodigoLote  codigo de lote
          isbProceso     nombre de proceso estaproc
          isbOperacion   operacion a realizar A - Actualizar, I - Insertar
          inuTotalHilo   cantidad de hilo
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       29-01-2024   OSF-2158    Creacion
    ***************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  '.prFinCadenaJobs';

        CURSOR cuResumenProc IS
        WITH Procesos AS (
            SELECT substr(estado,instr(estado,' ') +1, length(estado)) estado,
                   total_registro,
                   (total_registro - regis_procesado) diferencia,
                   regis_procesado
            FROM estaproc
            WHERE proceso like isbProceso||'%'
             AND fecha_final_ejec IS NOT NULL
             AND estado like 'Termin%'
        )
        SELECT SUM(CASE WHEN estado = 'OK' AND diferencia = 0 THEN  1  ELSE 0 END) hilo_procesado,
               SUM(CASE WHEN estado = 'OK' AND diferencia = 0 THEN  0 ELSE 1 END) hilo_fallido,
               SUM(regis_procesado) total_registro
        FROM Procesos;

        nuTotal     NUMBER := 0;
        nuHiloProc  NUMBER := 0;
        nuHiloFall  NUMBER := 0;

        sbProceso   varchar2(100) := 'prFinCadenaJobs'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS')||'_'||inuPeriodo;

        PROCEDURE prCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(105) := csbMetodo ||  '.prCierraCursores';
        BEGIN
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);
            IF cuResumenProc%ISOPEN THEN
                CLOSE cuResumenProc;
            END IF;
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);
        END prCierraCursores;

        PROCEDURE prActualizaLote IS
          PRAGMA AUTONOMOUS_TRANSACTION;
          csbMetodo1        CONSTANT VARCHAR2(105) := csbMetodo ||  '.prActualizaLote';
          sbFlagProc    VARCHAR2(1) := 'N';
          nuIntento    NUMBER := 0;
        BEGIN
           pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);

           IF nuhiloproc = inuTotalHilo AND  nutotal > 0 THEN
             sbFlagProc := 'S';
             pkg_ldc_pecofact.prActualizaObse(inuPeriodo, sbFlagProc);
           ELSE
             nuIntento := nuIntento + 1;
			 pkg_ldc_pecofact.prActualizaObse(inuPeriodo, 'N');
           END IF;

           pkg_lote_fact_electronica.prActLoteFactElectronica( inucodigolote,
                                                               nutotal,
                                                               nuhiloproc,
                                                               nuhilofall,
                                                               nuIntento,
                                                               sbFlagProc,
                                                               isbOperacion);

           COMMIT;
           pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);
        END PRACTUALIZALOTE;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        pkg_EstaProc.prInsertaEstaproc ( sbProceso, 0 );
        prCierraCursores;

        OPEN cuResumenProc;
        FETCH cuResumenProc  INTO nuHiloProc, nuHiloFall, nuTotal;
        CLOSE cuResumenProc;

        prActualizaLote;
        pkg_EstaProc.prActualizaEstaproc ( isbProceso => sbProceso, isbObservacion => 'Se procesaron '||nuTotal||' Registros');
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN
            pkg_Error.getError( nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            prCierraCursores;
            pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error', sbError );
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError( nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            prCierraCursores;
            pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error', sbError );
    END prFinCadenaJobs;

   FUNCTION fsbAction ( isbPack     IN VARCHAR2,
                        isbApi      IN VARCHAR2 ,
                        isbProgType IN VARCHAR2,
                        isbBloquePl IN VARCHAR2 ) RETURN VARCHAR2
    IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbAction
        Descripcion     : funcion que retorna la accion para la cadena de jobs

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 29-01-2024

        Parametros de Entrada
          isbPack     nombre del paquete
          isbApi      nombre del api (proceso)
          isbProgType tipo de programa
          isbBloquePl  bloque pl
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       29-01-2024   OSF-2158    Creacion
    ***************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  '.fsbAction';

        sbAction    VARCHAR2(4000);

        nuError     NUMBER;
        sbError     VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        CASE isbProgType
            WHEN 'STORED_PROCEDURE' THEN
                sbAction := ISBPACK || '.' || ISBAPI;
            WHEN 'PLSQL_BLOCK' THEN
                sbAction := isbBloquePl;
        END CASE;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN sbAction;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END fsbAction;

    PROCEDURE prDefValArgsCadenaJobs( inuPeriodo    IN  NUMBER,
                                      inuCodigoLote IN  NUMBER,
                                      inuTipoDocu   IN  NUMBER,
                                      isbProceso    IN  VARCHAR2,
                                      isbOperacion  IN  VARCHAR2,
                                      inuTotalHilo  IN NUMBER,
                                      isbPrograma   IN VARCHAR2,
									  inuConsecutivo IN NUMBER) IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prDefValArgsCadenaJobs
        Descripcion     : proceso para definir parametros a funciones de la cadena de jobs

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 29-01-2024

        Parametros de Entrada
           inuPeriodo       periodo_facturacion
           inuCodigoLote    codigo del lote
           inuTipoDocu      tipo de documento
           isbProceso       nombre del proceso
           isbOperacion     operacion a realizar I - Insertar A - Actualizar
           inuTotalHilo     cantidad de hilo
           isbPrograma      programa en ejecucion
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       29-01-2024   OSF-2158    Creacion
    ***************************************************************************/
        csbMetodo           CONSTANT VARCHAR2(100) := csbSP_NAME || '.prDefValArgsCadenaJobs';
        tbArgumentos        tbltytArgumentos;
        tbArgumentosFin     tbltytArgumentos;
        sbIndArg            VARCHAR2(100);
        sbStep              VARCHAR2(100);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
       tbArgumentos.DELETE;

        tbArgumentos := ftbArgumentos( 'PKG_UTILFACTURACIONELECGEN', UPPER('prHiloCadenaJobs'));

        tbArgumentos('INUPERIODO').VALUE := inuPeriodo;
        tbArgumentos('INUCODIGOLOTE').VALUE := inuCodigoLote;
        tbArgumentos('INUTIPODOCU').VALUE := inuTipoDocu;
        tbArgumentos('ISBPROCESO').VALUE := isbProceso;
        tbArgumentos('ISBOPERACION').VALUE := isbOperacion;
        tbArgumentos('INUTOTALHILO').VALUE := inuTotalHilo;

        FOR nuHilo in 1..inuTotalHilo LOOP

            tbArgumentos('INUHILO').VALUE := nuHilo;

            sbStep := substr(isbPrograma||inuConsecutivo,1,19)||'_' || nuHilo;

            pkg_Traza.trace('sbStep|' ||sbStep,csbNivelTraza);

            sbIndArg := tbArgumentos.First;

            LOOP

                EXIT WHEN sbIndArg IS NULL;

                pkg_Traza.trace('sbIndArg|' ||sbIndArg,csbNivelTraza);
                pkg_Traza.trace('tbArgumentos(sbIndArg).position|' ||tbArgumentos(sbIndArg).position,csbNivelTraza);
                pkg_Traza.trace('tbArgumentos(sbIndArg).argument_name|' ||tbArgumentos(sbIndArg).argument_name,csbNivelTraza);
                pkg_Traza.trace('tbArgumentos(sbIndArg).data_type|' ||tbArgumentos(sbIndArg).data_type,csbNivelTraza);
                pkg_Traza.trace('tbArgumentos(sbIndArg).value|' ||tbArgumentos(sbIndArg).value,csbNivelTraza);

                pkg_scheduler.define_program_argument
                (
                    sbStep,
                    tbArgumentos(sbIndArg).position,
                    tbArgumentos(sbIndArg).argument_name,
                    tbArgumentos(sbIndArg).data_type,
                    tbArgumentos(sbIndArg).value,
                    nuError,
                    sbError
                );

                IF nuError <> 0 THEN
                    pkg_error.SetErrorMessage( isbMsgErrr => 'Error Creando el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name || '|' || sbError );
                ELSE
                    pkg_Traza.trace( 'OK Creacion el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name, csbNivelTraza );
                END IF;

                sbIndArg := tbArgumentos.Next(sbIndArg );

            END LOOP;

            pkg_scheduler.enable
            (
                sbStep,
                nuError,
                sbError
            );

            IF nuError <> 0 THEN
                pkg_error.SetErrorMessage( isbMsgErrr => 'Error habilitando el programa|' || sbStep || sbError );
            ELSE
                pkg_Traza.trace( 'OK habilitando el programa|' || sbStep, csbNivelTraza );
            END IF;

        END LOOP;

        tbArgumentosFin.delete;

        tbArgumentosFin := ftbArgumentos( 'PKG_UTILFACTURACIONELECGEN', UPPER('prFinCadenaJobs'));

        tbArgumentosFin('INUPERIODO').VALUE := inuPeriodo;
        tbArgumentosFin('INUCODIGOLOTE').VALUE := inuCodigoLote;
        tbArgumentosFin('ISBPROCESO').VALUE := isbProceso;
        tbArgumentosFin('ISBOPERACION').VALUE := isbOperacion;
        tbArgumentosFin('INUTOTALHILO').VALUE := inuTotalHilo;

        sbStep := 'FIN_'||substr(isbPrograma||inuConsecutivo,1,19);
        sbIndArg := null;
        pkg_Traza.trace('sbStep|' ||sbStep,csbNivelTraza);

        sbIndArg := tbArgumentosFin.First;

        LOOP

            EXIT WHEN sbIndArg IS NULL;

            pkg_Traza.trace('sbIndArg|' ||sbIndArg,csbNivelTraza);

            pkg_Traza.trace('tbArgumentos(sbIndArg).position|' ||tbArgumentosFin(sbIndArg).position,csbNivelTraza);
            pkg_Traza.trace('tbArgumentos(sbIndArg).argument_name|' ||tbArgumentosFin(sbIndArg).argument_name,csbNivelTraza);
            pkg_Traza.trace('tbArgumentos(sbIndArg).data_type|' ||tbArgumentosFin(sbIndArg).data_type,csbNivelTraza);
            pkg_Traza.trace('tbArgumentos(sbIndArg).value|' ||tbArgumentosFin(sbIndArg).value,csbNivelTraza);

            pkg_scheduler.define_program_argument
            (
                sbStep,
                tbArgumentosFin(sbIndArg).position,
                tbArgumentosFin(sbIndArg).argument_name,
                tbArgumentosFin(sbIndArg).data_type,
                tbArgumentosFin(sbIndArg).value,
                nuError,
                sbError
            );

            IF nuError <> 0 THEN
                pkg_error.SetErrorMessage(isbMsgErrr => 'Error Creando el argumento ' || sbStep || '.' || tbArgumentosFin(sbIndArg).argument_name || '|' || sbError );

            ELSE
                pkg_Traza.trace( 'OK Creando el argumento ' || sbStep || '.' || tbArgumentosFin(sbIndArg).argument_name , csbNivelTraza);
            END IF;

            sbIndArg := tbArgumentosFin.Next(sbIndArg );

        END LOOP;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END prDefValArgsCadenaJobs;

    PROCEDURE prActivaCadenaJobs(isbChainJobs IN VARCHAR2,
                                 inuPeriodo   IN NUMBER,
                                 isbPrograma   IN VARCHAR2,
								 inuConsecutivo IN NUMBER ) IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prActivaCadenaJobs
        Descripcion     : proceso para activar cadena de jobs

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 29-01-2024

        Parametros de Entrada
           isbChainJobs  nombre de la cadena de jobs
           inuPeriodo     periodo de facturacion
           isbPrograma    programa en ejecucion
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       29-01-2024   OSF-2158    Creacion
    ***************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || '.prActivaCadenaJobs';
        sbStep              VARCHAR2(100);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        sbStep := 'FIN_'||substr(isbPrograma||inuConsecutivo,1,19);

        pkg_scheduler.enable
        (
            sbStep,
            nuError,
            sbError
        );

        IF nuError <> 0 THEN
            pkg_error.SetErrorMessage(isbMsgErrr => 'Error Habilitando el paso ' || sbStep );
        ELSE
            pkg_Traza.trace( 'OK Habilitando el paso ' || sbStep, csbNivelTraza );
        END IF;

        sbStep := 'INI_'||substr(isbPrograma||inuConsecutivo,1,19);

        pkg_scheduler.enable
        (
            sbStep,
            nuError,
            sbError
        );

        IF nuError <> 0 THEN
            pkg_error.SetErrorMessage( isbMsgErrr => 'Error Habilitando el paso ' || sbStep );
        ELSE
            pkg_Traza.trace( 'OK Habilitando el paso ' || sbStep, csbNivelTraza );
        END IF;

        pkg_scheduler.enable
        (
            isbChainJobs,
            nuError,
            sbError
        );

        IF nuError <> 0 THEN
            pkg_error.SetErrorMessage( isbMsgErrr => 'Error Habilitando la cadena ' || isbChainJobs );
        ELSE
            pkg_Traza.trace( 'OK Habilitando la cadena ' || isbChainJobs, csbNivelTraza );
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END prActivaCadenaJobs;

   PROCEDURE prCreaReglasCadenaJobs(isbChainJobs IN VARCHAR2,
                                    inuPeriodo   IN NUMBER,
                                    inuTotalHilo  IN  NUMBER,
                                    isbPrograma   IN VARCHAR2,
									inuConsecutivo IN NUMBER
                                    ) IS
  /***************************************************************************
     Propiedad Intelectual de Gases del Caribe
     Programa        : prCreaReglasCadenaJobs
     Descripcion     : proceso para crear reglas de la cadena de jobs

     Autor           : Luis Javier Lopez Barrios
     Fecha           : 29-01-2024

     Parametros de Entrada
      isbChainJobs   nombre de la cadena de jobs
      inuPeriodo     periodo de facturacion
      inuTotalHilo   total de hilo
      isbPrograma    programa en ejecucion
     Parametros de Salida

     Modificaciones  :
     =========================================================
     Autor       Fecha       Caso       Descripcion
     LJLB       29-01-2024   OSF-2158    Creacion
    ***************************************************************************/

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  '.prCreaReglasCadenaJobs';

		sbCondicion     VARCHAR2(4000);
		sbAccion        VARCHAR2(4000);

	BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

		sbCondicion := 'FALSE';
		sbAccion   := 'start INI_' || substr(isbPrograma||inuConsecutivo,1,19);

		pkg_scheduler.define_chain_rule
		(
		   isbChainJobs,
		   sbCondicion,
		   sbAccion
		);

		sbCondicion := REPLACE(sbAccion,'start ','');
		sbCondicion := REPLACE(sbCondicion,',',' succeeded and ');
		sbCondicion := sbCondicion || ' succeeded';

		sbAccion    := 'start ';

		FOR IND0 IN 1..inuTotalHilo LOOP

			sbAccion   := sbAccion || substr(isbPrograma||inuConsecutivo,1,19) || '_' || IND0 ;

			IF IND0 < inuTotalHilo THEN
				sbAccion := sbAccion ||  ',';
			END IF;

		END LOOP;

		pkg_scheduler.define_chain_rule
		(
		   isbChainJobs,
		   sbCondicion,
		   sbAccion
		);

		sbCondicion := REPLACE(sbAccion,'start ','');
		sbCondicion := REPLACE(sbCondicion,',',' succeeded and ');
		sbCondicion := sbCondicion || ' succeeded';

		sbAccion := 'start FIN_' ||substr(isbPrograma||inuConsecutivo,1,19);

		pkg_scheduler.define_chain_rule
		(
		   isbChainJobs,
		   sbCondicion,
		   sbACCION
		);

		sbCondicion := REPLACE(sbAccion,'start ','');
		sbCondicion := REPLACE(sbCondicion,',',' succeeded and ');
		sbCondicion := sbCondicion || ' succeeded';

		sbAccion := 'END';

		-- termina la cadena
		pkg_scheduler.define_chain_rule
		(
		   isbChainJobs,
		   sbCondicion,
		   sbAccion
		);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
	END prCreaReglasCadenaJobs;

   PROCEDURE prCargTablaProgCadenaJobs( inuPeriodo    IN  NUMBER,
                                        inuTotalHilo  IN  NUMBER,
                                        otbSchedChainProg  out tbltytSchedChainProg,
                                        isbPrograma   IN VARCHAR2,
										inuConsecutivo IN NUMBER) IS
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prCargTablaProgCadenaJobs
        Descripcion     : Programa para cargar los programas de la cadena de jobs

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 29-01-2024

        Parametros de Entrada
          inuPeriodo     codigo del periodo de facturacion
          inuTotalHilo   total de hilo
        Parametros de Salida
          otbSchedChainProg   tabla con programacion de cadena de jobs
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       29-01-2024   OSF-2158    Creacion
    ***************************************************************************/

        csbMetodo       CONSTANT VARCHAR2(100) := csbSP_NAME ||  '.prCargTablaProgCadenaJobs';

        nuError         NUMBER;
        sbError         VARCHAR2(4000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        otbSchedChainProg.DELETE;
        V_TYTRCPROGRAMA := V_TYTRCPROGRAMAnull;

        V_TYTRCPROGRAMA.PROGRAM_NAME     := 'INI_' || substr(isbPrograma||inuConsecutivo,1,19);
        V_TYTRCPROGRAMA.PACKAGE          := 'PKG_UTILFACTURACIONELECGEN';
        V_TYTRCPROGRAMA.API              := UPPER('prIniCadenaJobs');
        V_TYTRCPROGRAMA.PROGRAM_TYPE     := 'STORED_PROCEDURE';
        V_TYTRCPROGRAMA.STEP             := 'INI_' || substr(isbPrograma||inuConsecutivo,1,19);
        V_TYTRCPROGRAMA.BLOQUEPL         := NULL;
        V_TYTRCPROGRAMA.PROGRAM_ACTION   := fsbAction ( V_TYTRCPROGRAMA.PACKAGE , V_TYTRCPROGRAMA.API  , V_TYTRCPROGRAMA.PROGRAM_TYPE, V_TYTRCPROGRAMA.BLOQUEPL );
        otbSchedChainProg(otbSchedChainProg.COUNT+1)  :=  V_TYTRCPROGRAMA;
        FOR IND IN 1..inuTotalHilo LOOP

            V_TYTRCPROGRAMA.PROGRAM_NAME := substr(isbPrograma||inuConsecutivo,1,19)||'_'|| IND;
            V_TYTRCPROGRAMA.PACKAGE      := 'PKG_UTILFACTURACIONELECGEN';
            V_TYTRCPROGRAMA.API          := UPPER('prHiloCadenaJobs');
            V_TYTRCPROGRAMA.PROGRAM_TYPE := 'STORED_PROCEDURE';
            V_TYTRCPROGRAMA.BLOQUEPL     := NULL;
            V_TYTRCPROGRAMA.STEP         := substr(isbPrograma||inuConsecutivo,1,19)||'_'|| IND;
            V_TYTRCPROGRAMA.PROGRAM_ACTION   := fsbAction ( V_TYTRCPROGRAMA.PACKAGE , V_TYTRCPROGRAMA.API  , V_TYTRCPROGRAMA.PROGRAM_TYPE, V_TYTRCPROGRAMA.BLOQUEPL );

            otbSchedChainProg(otbSchedChainProg.COUNT+1)  :=  V_TYTRCPROGRAMA;

        END LOOP;

        V_TYTRCPROGRAMA.PROGRAM_NAME     := 'FIN_' || substr(isbPrograma||inuConsecutivo,1,19);
        V_TYTRCPROGRAMA.PACKAGE          := 'PKG_UTILFACTURACIONELECGEN';
        V_TYTRCPROGRAMA.API              := UPPER('prFinCadenaJobs');
        V_TYTRCPROGRAMA.PROGRAM_TYPE     := 'STORED_PROCEDURE';
        V_TYTRCPROGRAMA.STEP             := 'FIN_' || substr(isbPrograma||inuConsecutivo,1,19);
        V_TYTRCPROGRAMA.BLOQUEPL         := NULL;
        V_TYTRCPROGRAMA.PROGRAM_ACTION   := fsbAction ( V_TYTRCPROGRAMA.PACKAGE , V_TYTRCPROGRAMA.API  , V_TYTRCPROGRAMA.PROGRAM_TYPE, V_TYTRCPROGRAMA.BLOQUEPL );

        otbSchedChainProg(otbSchedChainProg.COUNT+1)  :=  V_TYTRCPROGRAMA;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END prCargTablaProgCadenaJobs;

    PROCEDURE prCreaCadenaJobs( isbChainJobs IN VARCHAR2,
                                inuPeriodo   IN NUMBER,
                                inuTotalHilo  IN  NUMBER,
                                isbPrograma   IN VARCHAR2,
								inuConsecutivo IN NUMBER) IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prCreaCadenaJobs
        Descripcion     : Crea la cadena de Jobs del proceso masivo

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 29-01-2024

        Parametros de Entrada
          isbChainJobs   nombre de la cadena de jobs
          inuPeriodo    codigo del periodo de facturacion
          inuTotalHilo   total de hilo
          isbPrograma    programa en ejecucion
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       29-01-2024   OSF-2158    Creacion
    ***************************************************************************/
      csbMetodo        CONSTANT VARCHAR2(100) := csbSP_NAME ||  '.prCreaCadenaJobs';

      v_tbArgumentos  tbltytArgumentos;
      v_tbProgramas   pkg_scheduler.tytbProgramas;
      otbSchedChainProg  tbltytSchedChainProg;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        otbSchedChainProg.DELETE;
		v_tbProgramas.DELETE;
		v_tbArgumentos.DELETE;

        prCargTablaProgCadenaJobs(inuPeriodo, inuTotalHilo, otbSchedChainProg, isbPrograma, inuConsecutivo);

        IF pkg_scheduler.FBLSCHEDCHAINEXISTS( isbChainJobs ) THEN
            pkg_Traza.trace('Ya existe la cadena ' || isbChainJobs, csbNivelTraza );

            v_tbProgramas := pkg_scheduler.ftbProgramas( isbPrograma );

            IF
            (
                NVL(v_tbProgramas.Count,0) <> ( inuTotalHilo + 2)
                OR
                pkg_scheduler.fblUltEjecCadJobConError(  isbChainJobs )
            )
            THEN

                pkg_scheduler.pDropSchedChain( isbChainJobs );

                pkg_scheduler.create_chain( isbChainJobs );

            END IF;

        ELSE
            pkg_scheduler.create_chain( isbChainJobs );
        END IF;

        FOR indtbPr IN 1..otbSchedChainProg.COUNT LOOP

            pkg_Traza.trace('paso|'|| otbSchedChainProg(indtbPr).step, csbNivelTraza );
            pkg_Traza.trace('programa|' || otbSchedChainProg(indtbPr).package || '.' || otbSchedChainProg(indtbPr).api,csbNivelTraza);

            v_tbArgumentos := ftbArgumentos( otbSchedChainProg(indtbPr).package, otbSchedChainProg(indtbPr).api );

            pkg_Traza.trace('v_tbArgumentos.count|' || v_tbArgumentos.count,csbNivelTraza);

            pkg_scheduler.PCREASCHEDCHAINSTEP
            (
                isbChainJobs,
                otbSchedChainProg(indtbPr).step,
                otbSchedChainProg(indtbPr).program_name,
                otbSchedChainProg(indtbPr).program_type,
                otbSchedChainProg(indtbPr).program_action,
                v_tbArgumentos.count,
                TRUE,
                isbChainJobs,
                nuError,
                sbError
            );

            pkg_Traza.trace('Res pkg_scheduler.PCREASCHEDCHAINSTEP|' || sbError);

            IF nuError = 0 THEN
                NULL;
            ELSE
                Pkg_Error.SetErrorMessage(  isbMsgErrr => 'pCreaSchedChainStep|' || sbError );
            END IF;

        END LOOP;

        prCreaReglasCadenaJobs(isbChainJobs, inuPeriodo, inuTotalHilo, isbPrograma, inuConsecutivo);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
      WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END prCreaCadenaJobs;

    PROCEDURE prInsertaLoteaProce( inuTipoDocu IN NUMBER,
                                   inuPeriodo  IN  NUMBER,
                                   inuAno      IN  NUMBER,
                                   inuMes      IN  NUMBER,
                                   inuCiclo    IN  NUMBER,
                                   inuCantHilo IN NUMBER,
								   isbCodEmpresa IN VARCHAR2,
                                   onuLote     OUT NUMBER) IS
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prInsertaLoteaProce
        Descripcion     : procesa para inserta lote a procesar

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 14-05-2024

        Parametros de Entrada
           inuTipoDocu    tipo de documento
           inuPeriodo     codigo del periodo
           inuAno         año
           inuMes         mes
           inuCiclo       ciclo
           inuCantHilo    cantidad de hilo
		   isbCodEmpresa  Codigo de empresa

        Parametros de Salida
           onuLote       codigo del lote insertado
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       14-05-2024   OSF-2158    Creacion
		JSOTO	   27-03-2025	OSF-4104	Se agrega parametro de entrada isbCodEmpresa
    ***************************************************************************/
         PRAGMA AUTONOMOUS_TRANSACTION;
         csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME ||  '.prInsertaLoteaProce';

         v_styLoteFactElectronica  pkg_lote_fact_electronica.styLoteFactElectronica;
      BEGIN
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
         onuLote := SEQ_LOTE_FACT_ELECTRONICA.nextval;
         pkg_traza.trace(' onuLote => ' || onuLote, pkg_traza.cnuNivelTrzDef);

         v_styLoteFactElectronica.codigo_lote := onuLote;
         v_styLoteFactElectronica.periodo_facturacion := inuPeriodo;
         v_styLoteFactElectronica.anio := inuAno;
         v_styLoteFactElectronica.mes := inuMes;
         v_styLoteFactElectronica.ciclo := inuCiclo;
         v_styLoteFactElectronica.cantidad_hilos := inuCantHilo;
		 v_styLoteFactElectronica.empresa := isbCodEmpresa;
         v_styLoteFactElectronica.fecha_inicio := SYSDATE;
         v_styLoteFactElectronica.flag_terminado := 'N';
         v_styLoteFactElectronica.tipo_documento := inuTipoDocu;
		 

         pkg_lote_fact_electronica.prInsLoteFactElectronica(v_styLoteFactElectronica);
         commit;
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
   EXCEPTION
      WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            ROLLBACK;
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            ROLLBACK;
            RAISE pkg_Error.Controlled_Error;
    END prInsertaLoteaProce;

    PROCEDURE prInsertaLoteaProcesar( 	inuTipoDocu 	IN 	NUMBER,
										inuPeriodo  	IN  NUMBER,
										inuAno      	IN  NUMBER,
										inuMes      	IN  NUMBER,
										inuCiclo    	IN  NUMBER,
										inuCantHilo 	IN 	NUMBER,
										isbCodEmpresa  	IN 	VARCHAR2,
										onuLote     	OUT NUMBER) IS
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prInsertaLoteaProcesar
        Descripcion     : procesa para inserta lote a procesar

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 14-05-2024

        Parametros de Entrada
           inuTipoDocu    tipo de documento
           inuPeriodo     codigo del periodo
           inuAno         año
           inuMes         mes
           inuCiclo       ciclo
           inuCantHilo    cantidad de hilo
		   isbCodEmpresa	  Código de empresa
        Parametros de Salida
           onuLote       codigo del lote insertado
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       14-05-2024   OSF-2158    Creacion
		JSOTO	   14-03-2025   OSF-4104	Se agrega parametro isbCodEmpresa
    ***************************************************************************/
         csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME ||  '.prInsertaLoteaProcesar';
         v_styLoteFactElectronica  pkg_lote_fact_electronica.styLoteFactElectronica;
		 
      BEGIN
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
         onuLote := SEQ_LOTE_FACT_ELECTRONICA.nextval;
         pkg_traza.trace(' onuLote => ' || onuLote, pkg_traza.cnuNivelTrzDef);
		 
         v_styLoteFactElectronica.codigo_lote := onuLote;
         v_styLoteFactElectronica.periodo_facturacion := inuPeriodo;
         v_styLoteFactElectronica.anio := inuAno;
         v_styLoteFactElectronica.mes := inuMes;
         v_styLoteFactElectronica.ciclo := inuCiclo;
         v_styLoteFactElectronica.cantidad_hilos := inuCantHilo;
		 v_styLoteFactElectronica.empresa := isbCodEmpresa;
         v_styLoteFactElectronica.fecha_inicio := SYSDATE;
         v_styLoteFactElectronica.flag_terminado := 'N';
         v_styLoteFactElectronica.tipo_documento := inuTipoDocu;

         pkg_lote_fact_electronica.prInsLoteFactElectronica(v_styLoteFactElectronica);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
   EXCEPTION
      WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            ROLLBACK;
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            ROLLBACK;
            RAISE pkg_Error.Controlled_Error;
    END prInsertaLoteaProcesar;


    PROCEDURE prActualizaLoteProc( inuLote    IN  NUMBER,
                                   isbEstado  IN  VARCHAR2) IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prActualizaLoteProc
        Descripcion     : procesa para actualizar estado de lote de facturacion

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 14-05-2024

        Parametros de Entrada
           inuLote       codigo del lote
           isbEstado     estado del lote

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       14-05-2024   OSF-2158    Creacion
    ***************************************************************************/
         PRAGMA AUTONOMOUS_TRANSACTION;
         csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME ||  '.prActualizaLoteProc';
      BEGIN
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
         pkg_lote_fact_electronica.prActLoteFactElectronica(inuLote, isbEstado);

         commit;
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
       EXCEPTION
      WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            ROLLBACK;
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            ROLLBACK;
            RAISE pkg_Error.Controlled_Error;
    END prActualizaLoteProc;


    PROCEDURE prCrearProcMasivo IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prCrearProcMasivo
        Descripcion     : procesa para la Creacion de cadena de Jobs del proceso masivo

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 29-01-2024

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       29-01-2024   OSF-2158    Creacion
    ***************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(100) := csbSP_NAME ||  '.prCrearProcMasivo';
        csbProcEje       CONSTANT VARCHAR2(100) := 'RECU';
        nuTOTAL_HILOS    NUMBER := pkg_parametros.fnugetvalornumerico('CANT_HILO_FACTELE');
        sbProceso        VARCHAR2(4000) := 'PRCREARPROCMASIVO_'||TO_CHAR(SYSDATE, 'DDMMYYYYHH24MISS');
        sbProcesoCadena  VARCHAR2(4000);
        onuLoteProc      NUMBER;
        sbEstadoLote     VARCHAR2(1);
        sbChainJobs      VARCHAR2(30);
        sbOperacion      VARCHAR2(1) := 'I';

        CURSOR cuGetPeriodProc IS
        SELECT perifact.pefacodi,
               perifact.pefaano,
               perifact.pefames,
               perifact.pefacicl,
			   pkg_boconsultaempresa.fsbObtEmpresaCiclo(perifact.pefacicl) empresa
        FROM perifact, ldc_pecofact
        WHERE ldc_pecofact.pcfapefa = perifact.pefacodi
         AND NVL(ldc_pecofact.PCFAOBSE,'N') = 'N'
         AND NOT EXISTS ( SELECT 1
                          FROM lote_fact_electronica
                          WHERE lote_fact_electronica.periodo_facturacion = ldc_pecofact.pcfapefa
                                AND lote_fact_electronica.tipo_documento = pkg_bcfactuelectronicagen.cnuTipoDocuFactRecu
                                AND (lote_fact_electronica.flag_terminado = 'S'
                                OR lote_fact_electronica.intentos >= nuIntentoRep));

       CURSOR cuGetLotePrev(inuPeriodo IN NUMBER) IS
       SELECT lote_fact_electronica.codigo_lote,
              lote_fact_electronica.flag_terminado
       FROM lote_fact_electronica
       WHERE lote_fact_electronica.periodo_facturacion = inuPeriodo
        AND lote_fact_electronica.flag_terminado IN ('N','R')
        AND lote_fact_electronica.tipo_documento = pkg_bcfactuelectronicagen.cnuTipoDocuFactRecu
        AND lote_fact_electronica.intentos <= nuIntentoRep;


      nuConsecutivo NUMBER;
	  PROCEDURE prActualizaPeco( inuPeriodo IN NUMBER,
								 isbFlag 	IN VARCHAR2) IS
		  PRAGMA AUTONOMOUS_TRANSACTION;
          csbMetodo1        CONSTANT VARCHAR2(105) := csbMetodo ||  '.prActualizaLote';
	  BEGIN
		  pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);
		  pkg_ldc_pecofact.prActualizaObse(inuPeriodo, isbFlag);
		  commit;
		  pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);
	   END prActualizaPeco;

    BEGIN
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
       pkg_estaproc.prinsertaestaproc( sbProceso , 0);

       FOR reg IN cuGetPeriodProc LOOP
           IF cuGetLotePrev%ISOPEN THEN
              CLOSE cuGetLotePrev;
           END IF;
           sbChainJobs := null;
           sbProcesoCadena := null;
		   nuConsecutivo := SEQ_CONSECUTIVO_ESTAPROG.NEXTVAL;
           sbChainJobs :=  substr(CsbChainJobs||csbProcEje ||nuConsecutivo||'_'||reg.pefacodi,1,20);
           IF pkg_scheduler.fblSchedChainRunning( sbChainJobs ) THEN

              pkg_error.SetErrorMessage( isbMsgErrr => 'La cadena de Jobs ' || sbChainJobs || ' está corriendo' );
           ELSE
               onuLoteProc := null;
               OPEN cuGetLotePrev(reg.pefacodi);
               FETCH cuGetLotePrev INTO onuLoteProc, sbEstadoLote;
               CLOSE cuGetLotePrev;

               IF sbEstadoLote = 'R' THEN
                  sbOperacion := 'A';
                  prActualizaLoteProc(onuLoteProc, 'P');
               END IF;
               prCreaCadenaJobs(sbChainJobs, reg.pefacodi, nuTOTAL_HILOS, csbProgram, nuConsecutivo);
                -- Obtiene consecutivo de proceso para Estaprog
               sbProcesoCadena := substr(csbProgram||nuConsecutivo|| '_' ||reg.pefacodi,1,20);
               IF onuLoteProc IS NULL THEN
                   --se crea lote
                   prInsertaLoteaProce(pkg_bcfactuelectronicagen.cnuTipoDocuFactRecu,
                                       reg.pefacodi,
                                       reg.pefaano,
                                       reg.pefames,
                                       reg.pefacicl,
                                       nuTOTAL_HILOS,
									   reg.empresa,
                                       onuLoteProc);
               END IF;

			   --se actualiza tabla de FIDF
			   prActualizaPeco(reg.pefacodi, 'P');

               prDefValArgsCadenaJobs( reg.pefacodi,
                                       onuLoteProc,
                                       pkg_bcfactuelectronicagen.cnuTipoDocuFactRecu,
                                       sbProcesoCadena,
                                       sbOperacion,
                                       nuTOTAL_HILOS,
                                       csbProgram,
                                       nuConsecutivo);

               prActivaCadenaJobs(sbChainJobs, reg.pefacodi, csbProgram, nuConsecutivo);
               pkg_scheduler.run_chain(sbChainJobs , 'INI_'||substr(csbProgram||nuConsecutivo,1,19),  'JOB_' ||sbChainJobs );


           END IF;
       END LOOP;
       pkg_estaproc.practualizaestaproc(isbproceso => sbProceso);
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
   EXCEPTION
      WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error ', sbError );
            prActualizaLoteProc(onuLoteProc, sbEstadoLote);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error ', sbError );
            prActualizaLoteProc(onuLoteProc, sbEstadoLote);
            RAISE pkg_Error.Controlled_Error;
    END prCrearProcMasivo;

	PROCEDURE prCrearProcMasivoVenta IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prCrearProcMasivoVenta
        Descripcion     : procesa para la Creacion de cadena de Jobs del proceso masivo para ventas

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 15-05-2024

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
		JSOTO	   17-03-2025	OSF-4104	Se cambia lógica para hacer mediante un loop llamado a prcCrearLoteMasivoVenta
        LJLB       18-10-2024   OSF-3493    se cloca filtro de cargtipr = 'A' para cargos con condiciones especiales
		LJLB       15-05-2024   OSF-2158    Creacion
    ***************************************************************************/
	
        csbMetodo        CONSTANT VARCHAR2(100) := csbSP_NAME ||  '.prCrearProcMasivoVenta';
		nuIndice    	 empresa.codigo%TYPE;

    BEGIN
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
		
		tbDatosEmpresa.DELETE;
	 
		tbDatosEmpresa := pkg_empresa.frcObtieneInfoEmpresas;
	 
		nuIndice := tbDatosEmpresa.FIRST;
		
		LOOP
			EXIT WHEN nuIndice IS NULL;
			
			prcCrearLoteMasivoVenta(tbDatosEmpresa(nuIndice).codigo);
			
			nuIndice := tbDatosEmpresa.NEXT(nuIndice);
			
		END LOOP;

       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
   EXCEPTION
      WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
		    RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
		    RAISE pkg_Error.Controlled_Error;
    END prCrearProcMasivoVenta;

    PROCEDURE prCrearProcMasivoNotas IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prCrearProcMasivoNotas
        Descripcion     : procesa para la Creacion de cadena de Jobs del proceso masivo para notas

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 09-07-2024

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       09-07-2024   OSF-2158    Creacion
		JSOTO	   17-03-2025	OSF-4104	Se cambia la lógica por loop de empresas y llamado a PRCCREARLOTEMASIVONOTAS

    ***************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(100) := csbSP_NAME ||  '.prCrearProcMasivoNotas';
		nuIndice    	 empresa.codigo%TYPE;
		
    BEGIN
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
		
		tbDatosEmpresa.DELETE;
	 
		tbDatosEmpresa := pkg_empresa.frcObtieneInfoEmpresas;
	 
		nuIndice := tbDatosEmpresa.FIRST;
		
		LOOP
			EXIT WHEN nuIndice IS NULL;
			
			prccrearlotemasivonotas(tbDatosEmpresa(nuIndice).codigo);
			
			nuIndice := tbDatosEmpresa.NEXT(nuIndice);
		END LOOP;
	   		
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
   EXCEPTION
      WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END prCrearProcMasivoNotas;

	
    PROCEDURE prActualizaEstrFactElec(  inuFactura   IN   NUMBER,
                                         inuCodigoLote IN  NUMBER,
                                         isbOperacion  IN  VARCHAR2,
                                         inuTipoDocu   IN  NUMBER,
                                         InuIdReporte   IN NUMBER,
                                         onuError     OUT  NUMBER,
                                         osbError     OUT  VARCHAR2) IS
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prActualizaEstrFactElec
        Descripcion     : proceso para generar estructura de facturacion electronica

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 17-01-2024

        Parametros de Entrada
          inuFactura       codigo de la factura
          inuCodigoLote    codigo de lote
          isbOperacion    Operacion a realizar I - Insertar A -Actualizar
          inuTipoDocu     tipo de documento a generar
          InuIdReporte    codigo de reporte
        Parametros de Salida
          onuError        codigo del error
          osbError        mensaje de error
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB        17-01-2024  OSF-2158    Creacion
		JSOTO		21-03-2025	OSF-4104	Se obtiene el codigo de empresa para enviarlo a prGenerarEstrFactElec
      ***************************************************************************/
       csbMetodo        CONSTANT VARCHAR2(100) := csbSP_NAME ||  '.prActualizaEstrFactElec';
       nuIdReporte 		NUMBER;
	   sbCodEmpresa		VARCHAR2(10);
	   
    BEGIN
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
	   
	   sbCodEmpresa := pkg_lote_fact_electronica.fsbObtCodEmpresa(inuCodigoLote);
	   
       PKG_BOFACTUELECTRONICAGEN.prGenerarEstrFactElec( inuFactura => inuFactura,
                                                       inuCodigoLote => inuCodigoLote,
                                                       isbOperacion => isbOperacion,
                                                       inuTipoDocu => inuTipoDocu,
                                                       inuIdReporte => inuIdReporte,
													   isbCodEmpresa => sbCodEmpresa,
                                                       onuError => onuError,
                                                       osbError => osbError);
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
   EXCEPTION
      WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
    END prActualizaEstrFactElec;

    PROCEDURE prJobEliminarRegFactElect IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prJobEliminarRegFactElect
        Descripcion     : job que se encarga de eliminar las facturas /notas enviadas a la Dian

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 13-09-2024

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       13-09-2024   OSF-3239    Creacion
    ***************************************************************************/
      csbMetodo        CONSTANT VARCHAR2(150) := csbSP_NAME ||  '.prJobEliminarRegFactElect';
      sbProceso    VARCHAR2(4000) :=  'JOBELIREFE_'||TO_CHAR(SYSDATE, 'DDMMYYYYHH24MISS'); 
      sbFecha VARCHAR2(40) := TO_CHAR(SYSDATE, 'DDMMYYYY');
      sbNombreTabla  VARCHAR2(40) := 'tmp_fact_electronica'||sbFecha;
  BEGIN
	pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    pkg_estaproc.prinsertaestaproc( sbProceso , 0);
    pkg_traza.trace(' sbNombreTabla => ' || sbNombreTabla, pkg_traza.cnuNivelTrzDef);  
    --se crea tabla temporal
    EXECUTE IMMEDIATE 'CREATE TABLE '||sbNombreTabla||'  AS
                        SELECT *
                        FROM factura_elect_general
                        WHERE  NOT EXISTS ( SELECT 1 
                                              FROM facturas_emitidas
                                              WHERE factura_elect_general.codigo_lote = facturas_emitidas.codigo_lote 
                                                     AND factura_elect_general.tipo_documento =  facturas_emitidas.tipo_documento 
                                                     AND  factura_elect_general.documento = facturas_emitidas.documento )
                            AND factura_elect_general.emitir_factura = ''S''';

    --se elimina tabla 
    EXECUTE IMMEDIATE 'TRUNCATE TABLE factura_elect_general';


    EXECUTE IMMEDIATE 'INSERT INTO factura_elect_general
                        SELECT *
                        FROM '||sbNombreTabla;

    EXECUTE IMMEDIATE 'DROP TABLE '||sbNombreTabla;
    pkg_estaproc.practualizaestaproc(isbproceso => sbProceso);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
      WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error ', sbError );
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error ', sbError );
            RAISE pkg_Error.Controlled_Error;
  END prJobEliminarRegFactElect; 
  
  
  	PROCEDURE prcCrearLoteMasivoVenta (isbCodEmpresa	IN VARCHAR2) IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcCrearLoteMasivoVenta
        Descripcion     : procesa para la Creacion de cadena de Jobs del proceso masivo para ventas

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 15-05-2024

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       18-10-2024   OSF-3493    se cloca filtro de cargtipr = 'A' para cargos con condiciones especiales
		LJLB       15-05-2024   OSF-2158    Creacion
    ***************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(100) := csbSP_NAME ||  '.prcCrearLoteMasivoVenta';
        sbProceso        VARCHAR2(4000) := 'PRCREARPROCMASIVOVENTA_'||TO_CHAR(SYSDATE, 'DDMMYYYYHH24MISS');
        onuLoteProc      NUMBER;
        sbOperacion      VARCHAR2(1) := 'I';

		nuIdReporte        NUMBER;
		blConfirma         BOOLEAN := FALSE;


        CURSOR cuGetVentas IS
        WITH FacturaVentas AS (
                SELECT  factura.factcodi
                FROM factura, servsusc, cuencobr
                WHERE factura.factprog <> 6
				 AND cuencobr.cucofact = factura.factcodi
				 AND cuencobr.cuconuse = servsusc.sesunuse
                 AND servsusc.sesususc = factura.factsusc
				 AND servsusc.sesuserv NOT IN (  SELECT to_number(regexp_substr(PKG_BCFACTUELECTRONICAGEN.csbTipoProdExcluir,  '[^,]+',   1, LEVEL)) AS TIPOPROD
												  FROM dual
												  CONNECT BY regexp_substr(PKG_BCFACTUELECTRONICAGEN.csbTipoProdExcluir, '[^,]+', 1, LEVEL) IS NOT NULL )
                 AND (factura.factfege) between dtFechaInicial AND  dtFechaFinal
				 AND pkg_boconsultaempresa.fsbObtEmpresaFactura(factura.factcodi) = isbCodEmpresa),
         FacturaVentaIng AS
              (SELECT *
               FROM FacturaVentas
               WHERE EXISTS ( SELECT 1
                              FROM cargos, cuencobr
                              WHERE cuencobr.cucofact = FacturaVentas.factcodi
                                AND cargos.cargcuco = cuencobr.cucocodi
                                AND cargos.cargsign IN ('DB','CR')
								AND cargos.cargconc NOT IN (  SELECT to_number(regexp_substr(pkg_bcfactuelectronicagen.sbConcExcluir,  '[^,]+',   1, LEVEL)) AS concepto
															  FROM dual
															  CONNECT BY regexp_substr(pkg_bcfactuelectronicagen.sbConcExcluir, '[^,]+', 1, LEVEL) IS NOT NULL)
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

                               )),
		 FacturasFinales AS (
			 SELECT DISTINCT FacturaVentaIng.factcodi
			 FROM FacturaVentaIng
			 WHERE NOT EXISTS ( SELECT  1
								FROM factura_elect_general
								WHERE factura_elect_general.tipo_documento = pkg_bcfactuelectronicagen.cnuTipoDocuVentas
									AND factura_elect_general.documento = to_char(FacturaVentaIng.factcodi)
								UNION ALL
								SELECT 1
								FROM facturas_emitidas
								WHERE facturas_emitidas.tipo_documento = pkg_bcfactuelectronicagen.cnuTipoDocuVentas
								   AND facturas_emitidas.documento = to_char(FacturaVentaIng.factcodi) ))
		SELECT factcodi, TO_CHAR(SYSDATE, 'YYYY') pefaano, TO_CHAR(SYSDATE, 'MM') pefames,  -1 pefacodi
		FROM FacturasFinales;

        TYPE tblFactVentas  IS TABLE OF cuGetVentas%ROWTYPE;
        v_tblFactVentas   tblFactVentas;


        nuCount  NUMBER;
		nuRegist NUMBER;
		nuTotal  NUMBER;
        nufactura NUMBER;
        nuRegisInco NUMBER;

		PROCEDURE prInicializarVariable  IS
		  csbMetodo1        CONSTANT VARCHAR2(150) := csbMetodo ||  '.prInicializarVariable';

		BEGIN
		  pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);
		   nuCount  := 0;
		  nuRegist := 0;
		  nuTotal  := 0;
          nuRegisInco := 0;
		  nuIdReporte := null;
		  onuLoteProc := null;
		  pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);
		END prInicializarVariable;

		PROCEDURE prActualizaLote IS
          PRAGMA AUTONOMOUS_TRANSACTION;
          csbMetodo1        CONSTANT VARCHAR2(105) := csbMetodo ||  '.prActualizaLote';
          sbFlagProc    VARCHAR2(1) := 'S';
          nuIntento    NUMBER := 0;
		  nuhilofall NUMBER := 0;
		  nuTotalHilo  NUMBER := 1;

        BEGIN
           pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);

           IF nuTotal <> nuRegist THEN
		      nuTotal := nuRegist;
		   END IF;

           pkg_lote_fact_electronica.prActLoteFactElectronica( onuLoteProc,
                                                               nutotal,
                                                               1,
                                                               nuhilofall,
                                                               nuIntento,
                                                               sbFlagProc,
                                                               sbOperacion);

           COMMIT;
           pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);
        END PRACTUALIZALOTE;

    BEGIN
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
       pkg_estaproc.prinsertaestaproc( sbProceso , 0);

	  -- Inicializa contador de productos procesados
	  prInicializarVariable;

	  --se realiza proceso de facturacion electronica
	  OPEN cuGetVentas;
	  LOOP
		FETCH cuGetVentas BULK COLLECT INTO v_tblFactVentas LIMIT 100;
		  nuTotal := nuTotal  + v_tblFactVentas.COUNT;
		  nufactura:=  null;

		  FOR idx IN 1..v_tblFactVentas.COUNT LOOP
			  IF onuLoteProc IS NULL THEN

				IF nuRegist = 0 THEN
					nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( 'JOBFAELGE',
																		'Job de facturacion electronica de venta ');
					pkg_traza.trace(' nuIdReporte => ' || nuIdReporte, pkg_traza.cnuNivelTrzDef);
                END IF;
			   --se crea lote
			   prInsertaLoteaProcesar(pkg_bcfactuelectronicagen.cnuTipoDocuVentas,
                                       v_tblFactVentas(idx).pefacodi,
                                       v_tblFactVentas(idx).pefaano,
                                       v_tblFactVentas(idx).pefames,
                                       -1,
                                       1,
									   isbCodEmpresa,
                                       onuLoteProc);
			   END IF;

			   nuRegist := nuRegist + 1;
			  nuError := 0;
			  nuFactura :=  v_tblFactVentas(idx).factcodi;
              PKG_BOFACTUELECTRONICAGEN.prGenerarEstrFactElec( inuFactura => nuFactura,
                                                               inuCodigoLote => onuLoteProc,
                                                               isbOperacion => 'I',
                                                               inuTipoDocu => pkg_bcfactuelectronicagen.cnuTipoDocuVentas,
                                                               inuIdReporte => nuIdReporte,
															   isbCodEmpresa => isbCodEmpresa,
                                                               onuError => nuError,
                                                               osbError => sbError);
                                                               
 			  IF nuError <> 0 THEN
				 ROLLBACK;
                 nuRegisInco := nuRegisInco +1;
				 IF NOT blConfirma THEN
				    onuLoteProc := NULL;
				 END IF;

			  ELSE
				 COMMIT;
				 blConfirma := TRUE;

			  END IF;
			  pkg_estaproc.prActualizaAvance( sbProceso,
											  'Procesando venta '||v_tblFactVentas(idx).factcodi,
											   nuRegist,
											   nuTotal);
		  END LOOP;
		  EXIT   WHEN cuGetVentas%NOTFOUND;
		END LOOP;
		CLOSE cuGetVentas;
	   nuIdReporte := null;
	   pkg_estaproc.practualizaestaproc(isbproceso => sbProceso);
	   IF nuTotal - nuRegisInco <> 0 THEN
		   prActualizaLote;
	  END IF;

       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
   EXCEPTION
      WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error ', sbError );
		    RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error ', sbError );
		    RAISE pkg_Error.Controlled_Error;
    END prcCrearLoteMasivoVenta;

  
      PROCEDURE prcCrearLoteMasivoNotas (isbCodEmpresa IN VARCHAR2) IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcCrearLoteMasivoNotas
        Descripcion     : procesa para la Creacion de cadena de Jobs del proceso masivo para notas

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 09-07-2024

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       09-07-2024   OSF-2158    Creacion
    ***************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(100) := csbSP_NAME ||  '.prcCrearLoteMasivoNotas';

        sbProceso        VARCHAR2(4000) := 'PRCREARPROCMASIVONOTA_'||TO_CHAR(SYSDATE, 'DDMMYYYYHH24MISS');
        onuLoteProc      NUMBER;
        sbOperacion      VARCHAR2(1) := 'I';
	    blConfirma         BOOLEAN := FALSE;

		nuCount  NUMBER;
		nuRegist NUMBER;
		nuTotal  NUMBER;
        nufactura NUMBER;
		nuIdReporte NUMBER;

        CURSOR cuGetNotas IS
        WITH NotasFact AS (
            SELECT *
            FROM notas
            WHERE  notatino IN ('C', 'D')
               AND notaprog NOT IN  ( SELECT to_number(regexp_substr(sbProgramaExcluir,  '[^,]+',   1, LEVEL)) AS programas
                                      FROM dual
                                      CONNECT BY regexp_substr(sbProgramaExcluir, '[^,]+', 1, LEVEL) IS NOT NULL )
			  AND pkg_boconsultaempresa.fsbObtEmpresaFactura(notas.notafact) = isbCodEmpresa
              AND notas.notafecr BETWEEN dtFechaInicial AND  dtFechaFinal

           ), NotaIngreso AS
              (SELECT *
               FROM NotasFact
               WHERE EXISTS ( SELECT 1
                              FROM cargos
                              WHERE cargos.cargcodo = NotasFact.notanume
                                AND (cargos.cargprog = NotasFact.notaprog )
								AND cargos.cargconc NOT IN (  SELECT to_number(regexp_substr(pkg_bcfactuelectronicagen.sbConcExcluir,  '[^,]+',   1, LEVEL)) AS concepto
															  FROM dual
															  CONNECT BY regexp_substr(pkg_bcfactuelectronicagen.sbConcExcluir, '[^,]+', 1, LEVEL) IS NOT NULL)
                                AND cargos.cargcaca IN ( SELECT to_number(regexp_substr(pkg_bcfactuelectronicagen.csbCausalesIngr,  '[^,]+',   1, LEVEL)) AS programas
                                                          FROM dual
                                                          CONNECT BY regexp_substr(pkg_bcfactuelectronicagen.csbCausalesIngr, '[^,]+', 1, LEVEL) IS NOT NULL )) ),
		  NotasAReportar AS (
			  SELECT  NotaIngreso.notanume,  TO_CHAR(SYSDATE, 'YYYY') pefaano, TO_CHAR(SYSDATE, 'MM') pefames,  -1 pefacodi
			  FROM NotaIngreso, factura, servsusc, cuencobr
			  WHERE  factura.factcodi = NotaIngreso.notafact
				AND factura.factsusc = servsusc.sesususc
				AND cuencobr.cucofact = factura.factcodi
				AND cuencobr.cuconuse = servsusc.sesunuse
				AND servsusc.sesuserv NOT IN (  SELECT to_number(regexp_substr(PKG_BCFACTUELECTRONICAGEN.csbTipoProdExcluir,  '[^,]+',   1, LEVEL)) AS TIPOPROD
												  FROM dual
												  CONNECT BY regexp_substr(PKG_BCFACTUELECTRONICAGEN.csbTipoProdExcluir, '[^,]+', 1, LEVEL) IS NOT NULL )

				 AND EXISTS (  SELECT 1
							  FROM facturas_emitidas
							  WHERE facturas_emitidas.tipo_documento <> pkg_bcfactuelectronicagen.cnuTipoDocuNotas
								   AND facturas_emitidas.documento = to_char(factura.factcodi) )

                                   )
			SELECT unique NotasAReportar.notanume, NotasAReportar.pefaano, NotasAReportar.pefames, NotasAReportar.pefacodi
			FROM NotasAReportar
			WHERE NOT EXISTS (
                                SELECT  1
                                  FROM factura_elect_general
                                  WHERE factura_elect_general.tipo_documento = pkg_bcfactuelectronicagen.cnuTipoDocuNotas
                                    AND factura_elect_general.documento = to_char(NotasAReportar.notanume)
								 UNION ALL
								 SELECT 1
								 FROM facturas_emitidas
								 WHERE facturas_emitidas.tipo_documento = pkg_bcfactuelectronicagen.cnuTipoDocuNotas
								   AND facturas_emitidas.documento = to_char(NotasAReportar.notanume) );


		TYPE tblNotas  IS TABLE OF cuGetNotas%ROWTYPE;
        v_tblNotas   tblNotas;

		PROCEDURE prInicializarVariable  IS
		  csbMetodo1        CONSTANT VARCHAR2(150) := csbMetodo ||  '.prInicializarVariable';

		BEGIN
		  pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);
		   nuCount  := 0;
		  nuRegist := 0;
		  nuTotal  := 0;
		  nuIdReporte := null;
		  onuLoteProc := null;
		  pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);
		END prInicializarVariable;

		PROCEDURE prActualizaLote IS
          PRAGMA AUTONOMOUS_TRANSACTION;
          csbMetodo1        CONSTANT VARCHAR2(105) := csbMetodo ||  '.prActualizaLote';
          sbFlagProc    VARCHAR2(1) := 'S';
          nuIntento    NUMBER := 0;
		  nuhilofall NUMBER := 0;
		  nuTotalHilo  NUMBER := 1;

        BEGIN
           pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);

           IF nuTotal <> nuRegist THEN
		      nuTotal := nuRegist;
		   END IF;

           pkg_lote_fact_electronica.prActLoteFactElectronica( onuLoteProc,
                                                               nutotal,
                                                               1,
                                                               nuhilofall,
                                                               nuIntento,
                                                               sbFlagProc,
                                                               sbOperacion);

           COMMIT;
           pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);
        END PRACTUALIZALOTE;

    BEGIN
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
       pkg_estaproc.prinsertaestaproc( sbProceso , 0);

      -- Inicializa contador de productos procesados
	  prInicializarVariable;

	  --se realiza proceso de facturacion electronica
	  OPEN cuGetNotas;
	  LOOP
		FETCH cuGetNotas BULK COLLECT INTO v_tblNotas LIMIT 100;
		  nuTotal := nuTotal  + v_tblNotas.COUNT;
		  nufactura:=  null;

		  FOR idx IN 1..v_tblNotas.COUNT LOOP
			  IF onuLoteProc IS NULL THEN

				IF nuRegist = 0 THEN
					nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( 'JOBFAELGE',
																		'Job de facturacion electronica de notas ');
					pkg_traza.trace(' nuIdReporte => ' || nuIdReporte, pkg_traza.cnuNivelTrzDef);
				END IF;

			   --se crea lote
			   prInsertaLoteaProcesar(pkg_bcfactuelectronicagen.cnuTipoDocuNotas,
								   v_tblNotas(idx).pefacodi,
								   v_tblNotas(idx).pefaano,
								   v_tblNotas(idx).pefames,
								   -1,
								   1,
								   isbCodEmpresa,
								   onuLoteProc);
			   END IF;

			  nuRegist := nuRegist + 1;
			  nuError := 0;
			  nuFactura :=  v_tblNotas(idx).notanume;
              PKG_BOFACTUELECTRONICAGEN.prGenerarEstrFactElec( inuFactura => nuFactura,
                                                               inuCodigoLote => onuLoteProc,
                                                               isbOperacion => sbOperacion,
                                                               inuTipoDocu => pkg_bcfactuelectronicagen.cnuTipoDocuNotas,
                                                               inuIdReporte => nuIdReporte,
															   isbCodEmpresa => isbCodEmpresa,
                                                               onuError => nuError,
                                                               osbError => sbError);
     

			  IF nuError <> 0 THEN
				 ROLLBACK;
				 IF NOT blConfirma THEN
				    onuLoteProc := NULL;
				 END IF;
			  ELSE
				 COMMIT;
				 blConfirma := TRUE;
			  END IF;
			  pkg_estaproc.prActualizaAvance( sbProceso,
											  'Procesando nota '||nuFactura,
											   nuRegist,
											   nuTotal);
		  END LOOP;
		  EXIT   WHEN cuGetNotas%NOTFOUND;
		END LOOP;
		CLOSE cuGetNotas;

	   pkg_estaproc.practualizaestaproc(isbproceso => sbProceso);
	   IF nuTotal <> 0 THEN
		   prActualizaLote;
	  END IF;

       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
   EXCEPTION
      WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error ', sbError );
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error ', sbError );
            RAISE pkg_Error.Controlled_Error;
    END prcCrearLoteMasivoNotas;
  
END pkg_UtilFacturacionElecGen;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_UTILFACTURACIONELECGEN','PERSONALIZACIONES');
END;
/