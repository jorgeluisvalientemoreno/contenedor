CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_PKBOCARGAPERIODOS AS

  TYPE tyTabla IS TABLE OF VARCHAR2(2000) INDEX BY BINARY_INTEGER;

  PROCEDURE ProcessLDCCPC(isbName ldc_cargperi.capename%TYPE);

  PROCEDURE ProcessLDCCPF(isbName ldc_cargperi.capename%TYPE);

  --Lee un archivo y lo devuelve una colecci?n (TABLA PL)
  PROCEDURE pLeerArchivo(isbNombreArchivo in varchar2,
                         isbRuta          in varchar2,
                         otbDatosArchivo  out tytabla);

  PROCEDURE ParseString(ivaCadena IN VARCHAR2,
                        ivaToken  IN VARCHAR2,
                        otbSalida OUT tyTabla);

  PROCEDURE pInsDetaPeriodo(inuCodigo  ldc_cargperi.CAPECODI%TYPE,
                            isbLinea   ldc_perilogc.PERILINE%TYPE,
                            isbMensaje ldc_perilogc.PERIMENS%TYPE,
                            inuPeriodo ldc_perilogc.pericons%TYPE,
                            inuPefacod ldc_perilogc.peripefa%type);

  PROCEDURE pInsPeriodo(inuCodigo ldc_cargperi.CAPECODI%TYPE,
                        isbName   ldc_cargperi.capename%TYPE,
                        isbRuta   ld_parameter.value_chain%TYPE,
                        inuCant   ldc_cargperi.CAPECANT%TYPE,
                        isbEven   ldc_cargperi.CAPEEVEN%TYPE);

  PROCEDURE pobtSearhCargaMasiva(inuCodigo     IN ldc_cargperi.capecodi%TYPE,
                                 isbNombre     IN ldc_cargperi.capename%TYPE,
                                 isbEvento     IN ldc_cargperi.CAPEEVEN%TYPE,
                                 idtFechaIni   IN ldc_cargperi.CAPEDATE%TYPE,
                                 idtFechaFin   IN ldc_cargperi.CAPEDATE%TYPE,
                                 ocuDataCursor OUT constants_per.tyRefCursor);

  PROCEDURE pobtGetCargaMasiva(sbCodigo      IN VARCHAR2,
                               ocuDataCursor OUT constants_per.tyRefCursor);

END ldc_pkbocargaperiodos;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_PKBOCARGAPERIODOS AS

    /*******************************************************************************
     Propiedad intelectual GASES DEL CARIBE

     Autor         :
     Fecha         :
     DESCRIPCION   : Paquete utilizado crear periodos de consumo y facturacion de forma masiva
     CASO          : 

     FECHA        AUTOR       DESCRIPCION
	 20/03/2024	  JSOTO		  OSF-2387 Ajustes en todo el paquete para reemplazar algunos objetos de producto
							  por objetos personalizados para disminuir el impacto en la migracion a 8.0
								se reemplaza uso de	ex.controlled_error	por	pkg_error.controlled_error
								se reemplaza uso de	utl_file.get_line	por	pkg_gestionarchivos.fsbobtenerlinea_ut
								se reemplaza uso de	utl_file.fgetattr	por	pkg_gestionarchivos.prcatributosarchivo_ut
								se reemplaza uso de	constants.tyrefcursor	por	constants_per.tyrefcursor
								se reemplaza uso de	ge_boerrors.seterrorcode	por	pkg_error.seterror
								se reemplaza uso de	utl_file.fopen	por	pkg_gestionarchivos.ftabrirarchivo_ut
								se reemplaza uso de	ut_date.fsbdate_format	por	ldc_boconsgenerales.fsbgetformatofecha
								se reemplaza uso de	ge_boerrors.seterrorcodeargument	por	pkg_erorr.seterrormessage
								se reemplaza uso de	errors.seterror	por	pkg_error.seterror
								se reemplaza uso de	ut_trace.trace	por	pkg_traza.trace
								se reemplaza uso de	utl_file.fclose	por	pkg_gestionarchivos.prccerrararchivo_ut
								se reemplaza uso de	utl_file.file_type	por	pkg_gestionarchivos.styarchivo
								Se ajusta el manejo de errores y trazas de acuerdo a las pautas tecnicas de desarrollo
     *******************************************************************************/

  csbSP_NAME  CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';


  csbRuta     CONSTANT ld_parameter.value_chain%TYPE := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_RUTA_CARGAPERIODOS');
  csbPECSFLAG CONSTANT ld_parameter.value_chain%TYPE := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_PECSFLAG');
  csbPECSPROC CONSTANT ld_parameter.value_chain%TYPE := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_PECSPROC');
  csbPECSPROG CONSTANT ld_parameter.value_chain%TYPE := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_PECSPROG');

  sbProgramName      estaprog.esprprog%type;
  nuProcessedRecords estaprog.ESPRSUPR%type := 0;
  nuTotalRegistros   estaprog.ESPRTAPR%type := 0;

  --Obtiene el usuario de aplicaci?n
  sbUser PERICOSE.PECSUSER%TYPE := AU_BOSystem.getSystemUserMask;
  --Se obtiene la terminal desde donde se ejecuta el proceso
  sbTerminal pericose.PECSTERM%TYPE := AU_BOSystem.getSystemUserTerminal;

  PROCEDURE ProcessLDCCPC(isbName ldc_cargperi.capename%TYPE) IS
    tbArchivo    tytabla;
    tbRecord     tytabla;
    rcPericose   PERICOSE%ROWTYPE;
    nuCodPeriodo ldc_cargperi.CAPECODI%TYPE;
	
	nuError		NUMBER;
	sbError		VARCHAR2(4000);

    nuPericons pericose.PECSCONS%TYPE;

    --20.09.18 Variables y Cursor datos del periodo
    continuar number := 1; --Determinara si continua el proceso 1 (ok) 0 (no)
    nuExistPeriodo number;
    nuExistCiclo number;
    cico pericose.pecscico%TYPE;
    feci pericose.pecsfeci%TYPE;
    fecf pericose.pecsfecf%TYPE;
    feai pericose.pecsfeai%TYPE;
    feaf pericose.pecsfeaf%TYPE;
    CURSOR cuPeriodo(inuPeriodo in pericose.pecscons%TYPE) IS
      SELECT pe.pecscico, pe.pecsfeci, pe.pecsfecf, pe.pecsfeai, pe.pecsfeaf
        FROM pericose pe
       WHERE pe.pecscons = inuPeriodo;
    CURSOR cuExistPeriodo(inuPeriodo in pericose.pecscons%TYPE) IS
      SELECT count(pe.pecscons)
        FROM pericose pe
       WHERE pe.pecscons = inuPeriodo;
    difDias1 number;
    difDias2 number;
    --cursor para proceso de actualizacion
    fecodiP pericose.pecscons%TYPE;
    feciP pericose.pecsfeci%TYPE;
    fecfP pericose.pecsfecf%TYPE;
    feaiP pericose.pecsfeai%TYPE;
    feafP pericose.pecsfeaf%TYPE;
	csbMetodo VARCHAR2(100) := csbSP_NAME||'ProcessLDCCPC';
	
    CURSOR cuPeriodos(inuCiclo in pericose.pecscico%TYPE, idtFecha in pericose.pecsfeci%TYPE) IS
      SELECT pe.pecscons, pe.pecsfeci, pe.pecsfecf, pe.pecsfeai, pe.pecsfeaf
        FROM pericose pe
       WHERE pe.pecscico = inuCiclo
       AND pe.pecsfeci > idtFecha
       ORDER BY pe.pecsfeci; --TICKET 200-2331 LJLB -- se cambia orden de actualziacion

    CURSOR cuPeriodosDesc(inuCiclo in pericose.pecscico%TYPE, idtFecha in pericose.pecsfeci%TYPE) IS
    SELECT pe.pecscons, pe.pecsfeci, pe.pecsfecf, pe.pecsfeai, pe.pecsfeaf
      FROM pericose pe
     WHERE pe.pecscico = inuCiclo
     AND pe.pecsfeci > idtFecha
     ORDER BY pe.pecsfeci desc; --TICKET 200-2331 LJLB -- se cambia orden de actualziacion

  BEGIN
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    --Se obtienen las l?neas del archivo en una tabla PL
    pLeerArchivo(isbName, csbRuta, tbArchivo);

    -- Crea el nombre del proceso
    sbProgramName := 'LDCCPC' || Sqesprprog.Nextval;

    --Si el archivo tiene l?neas para procesar
    IF (tbArchivo.count > 0) THEN
      nuTotalRegistros := tbArchivo.count - 1;

      -- Inserta registo de seguimiento en ESTAPROG
      Pkstatusexeprogrammgr.Addrecord(sbProgramName,
                                      'Proceso en ejecucion ...',
                                      0);
      Pkgeneralservices.Committransaction;

      --Se actualiza el total de registros para procesar
      Pkstatusexeprogrammgr.Upstatusexeprogramat(sbProgramName,
                                                 'Proceso en ejecucion...',
                                                 nuTotalRegistros,
                                                 0);
      Pkgeneralservices.Committransaction;

      --Se obtiene el c?digo de la secuencia
      nuCodPeriodo := SEQ_LDC_CARGPERI.nextval;

      --Inserta en las tablas de LOG
      pInsPeriodo(nuCodPeriodo, isbName, csbRuta, tbArchivo.count, 'C');

      --Se procesan las l?neas del archivo
      FOR i IN tbArchivo.FIRST .. tbArchivo.LAST LOOP

        --Se descarta el encabezado
        IF (i = 1) THEN
          continue;
        END IF;

        --Devuelve los datos de la l?nea en una tabla
        ParseString(tbArchivo(i), ';', tbRecord);

        IF (tbRecord.count > 0) THEN
          BEGIN
            ----------------------------------------------------
            --REQ.200-1907
            /*Observacion: Se agrego una nueva columna, con el nuevo
            cambio aplicado la columna uno [tbRecord(1)] ya no es el ciclo
            si no que corresponde al periodo de consumo a actualizar
            por lo tanto las demas columnas aumentan en el valor de 1.*/
            ----------------------------------------------------
            --Si no se obtiene periodo de consumo, se obtiene de la secuencia y se crea
            --Como se hace actualmente.
            IF tbRecord(1) IS NULL THEN

              nuPericons := SQ_PERICOSE_PECSCONS.nextval;

              --Se arma el record de pericose
              --REQ.200-1907. Se corren en 1 las columnas
              rcPericose.PECSCONS := nuPericons;
              --rcPericose.PECSCICO := tbRecord(1);
              rcPericose.PECSCICO := tbRecord(2);
              --rcPericose.PECSFECI := tbRecord(2);
              rcPericose.PECSFECI := tbRecord(3);
              --rcPericose.PECSFECF := to_date(to_char(to_date(tbRecord(3)||' 11:59:59'),'dd/mm/yyyy HH:MI:SS'));
              rcPericose.PECSFECF := to_date(to_char(to_date(tbRecord(4) ||
                                                             ' 11:59:59'),
                                                     'dd/mm/yyyy HH:MI:SS'));
              --rcPericose.PECSFEAI := tbRecord(4);
              rcPericose.PECSFEAI := tbRecord(5);
              --rcPericose.PECSFEAF := to_date(to_char(to_date(tbRecord(5)||' 11:59:59'),'dd/mm/yyyy HH:MI:SS'));
              rcPericose.PECSFEAF := to_date(to_char(to_date(tbRecord(6) ||
                                                             ' 11:59:59'),
                                                     'dd/mm/yyyy HH:MI:SS'));
              rcPericose.PECSPROC := csbPECSPROC;
              rcPericose.PECSUSER := sbUser;
              rcPericose.PECSTERM := sbTerminal;
              rcPericose.PECSPROG := csbPECSPROG;
              rcPericose.PECSFLAV := csbPECSFLAG;

              --Se inserta el record
              pktblpericose.INSRECORD(rcPericose);
              pkGeneralServices.committransaction;

              nuProcessedRecords := i - 1;

              --Se actualiza progreso
              Pkstatusexeprogrammgr.Upstatusexeprogramat(sbProgramName,
                                                         'Proceso en ejecucion...',
                                                         nuTotalRegistros,
                                                         nuProcessedRecords);
              Pkgeneralservices.Committransaction;

              --Se inserta el detalle del proceso
              pInsDetaPeriodo(nuCodPeriodo,
                              tbArchivo(i),
                              'PROCESADO CON ?XITO',
                              nuPericons,
                              null);

            ELSE
              --REQ.200-1907 Nueva logica de actualizacion.

              --20.09.18 - validacion del periodo
              dbms_output.put_line('Validacion del Periodo ' || tbRecord(1));
              --TICKET 200-2231 LJLB -- se valida que el cursor no este abierto
              IF cuExistPeriodo%ISOPEN THEN
                 CLOSE cuExistPeriodo;
              END IF;

              open cuExistPeriodo(tbRecord(1));
              fetch cuExistPeriodo
                INTO nuExistPeriodo;
              close cuExistPeriodo;
              if nuExistPeriodo > 0 then
               --TICKET 200-2231 LJLB -- se valida que el cursor no este abierto
                IF cuPeriodo%ISOPEN THEN
                 CLOSE cuPeriodo;
                END IF;
                --Verifico los datos del periodo
                open cuPeriodo(tbRecord(1));
                fetch cuPeriodo
                  INTO cico, feci, fecf, feai, feaf;
                close cuPeriodo;
                if tbRecord(2) = cico then
                  dbms_output.put_line('Validacion del Ciclo ' || tbRecord(2));
                  if continuar = 1 then
                    --proceso de asignacion todo OK para modificar el periodo
                    --buscar la diferencia y asignarsela a los periodos posteriores del ciclo
                    dbms_output.put_line('Asigno las diferencias');
                    difDias1 := trunc(to_date(tbRecord(4)) - trunc(fecf));
                    difDias2 := trunc(to_date(tbRecord(6)) - trunc(feaf));
                    dbms_output.put_line('Diferencia 1 (' || tbRecord(4) || ' - ' || fecf || ') ' || difDias1);
                    dbms_output.put_line('Diferencia 2 (' || tbRecord(6) || ' - ' || feaf || ') ' || difDias2);
					--TICKET 200-2231 LJLB -- se cambia el orden de actualizacion de los periodos para evitar problema de solapamiento

					--Si se obtiene el periodo de consumo de la tabla se actualiza.
                    IF difDias1 <= 0 THEN

                        UPDATE pericose --TABLA DE ALMACENAMIENTO DE PERIODOS DE CONSUMO
                           SET pecscico = tbRecord(2), --ciclo de consumo
                               pecsfeci = tbRecord(3), --fecha de consumo inicial
                               pecsfecf = tbRecord(4), --fecha de consumo final
                               pecsfeai = tbRecord(5), --fecha de cargo basico inicial
                               pecsfeaf = tbRecord(6) --fecha de cargo basico final
                         WHERE pecscons = tbRecord(1); --consecutivo identificador del periodo

                        --REQ.200-1907 Se realiza la misma logica que hace el proceso actualmente.
                       --TICKET 200-2231 LJLB -- se valida que el cursor no este abierto
                        IF cuPeriodos%ISOPEN THEN
                         CLOSE cuPeriodos;
                        END IF;

                        OPEN cuPeriodos(tbRecord(2), to_Date(tbRecord(3)));
                        LOOP
                          FETCH cuPeriodos INTO fecodiP, feciP, fecfP, feaiP, feafP;
                          EXIT WHEN cuPeriodos%NOTFOUND;
                         UPDATE pericose --TABLA DE ALMACENAMIENTO DE PERIODOS DE CONSUMO
                           SET pecsfeci = feciP + difDias1, --fecha de consumo inicial
                               pecsfecf = fecfP + difDias1, --fecha de consumo final
                               pecsfeai = feaiP + difDias2, --fecha de cargo basico inicial
                               pecsfeaf = feafP + difDias2 --fecha de cargo basico final
                         WHERE pecscons = fecodiP; --consecutivo identificador del periodo
                         dbms_output.put_line('Modificado el Periodo ' || fecodiP);
                        END LOOP;
                        close cuPeriodos;

                      ELSE
                         --TICKET 200-2231 LJLB -- se valida que el cursor no este abierto
                        IF cuPeriodosDesc%ISOPEN THEN
                         CLOSE cuPeriodosDesc;
                        END IF;

                        OPEN cuPeriodosDesc(tbRecord(2), to_Date(tbRecord(3)));
                        LOOP
                          FETCH cuPeriodosDesc INTO fecodiP, feciP, fecfP, feaiP, feafP;
                          EXIT WHEN cuPeriodosDesc%NOTFOUND;
                         UPDATE pericose --TABLA DE ALMACENAMIENTO DE PERIODOS DE CONSUMO
                           SET pecsfeci = feciP + difDias1, --fecha de consumo inicial
                               pecsfecf = fecfP + difDias1, --fecha de consumo final
                               pecsfeai = feaiP + difDias2, --fecha de cargo basico inicial
                               pecsfeaf = feafP + difDias2 --fecha de cargo basico final
                         WHERE pecscons = fecodiP; --consecutivo identificador del periodo
                         dbms_output.put_line('Modificado el Periodo ' || fecodiP);
                        END LOOP;
                        close cuPeriodosDesc;

                        UPDATE pericose --TABLA DE ALMACENAMIENTO DE PERIODOS DE CONSUMO
                           SET pecscico = tbRecord(2), --ciclo de consumo
                               pecsfeci = tbRecord(3), --fecha de consumo inicial
                               pecsfecf = tbRecord(4), --fecha de consumo final
                               pecsfeai = tbRecord(5), --fecha de cargo basico inicial
                               pecsfeaf = tbRecord(6) --fecha de cargo basico final
                         WHERE pecscons = tbRecord(1); --consecutivo identificador del periodo

                      END IF;
                    --Asignacion de los nuevos datos para el ciclo
                    --codigo original
                    /**/

                    pkGeneralServices.committransaction;

                    nuProcessedRecords := i - 1;

                    --Se actualiza progreso
                    Pkstatusexeprogrammgr.Upstatusexeprogramat(sbProgramName,
                                                               'Proceso en ejecucion...',
                                                               nuTotalRegistros,
                                                               nuProcessedRecords);
                    Pkgeneralservices.Committransaction;

                    --Se inserta el detalle del proceso
                    pInsDetaPeriodo(nuCodPeriodo,
                                    tbArchivo(i),
                                    'PROCESADO CON ?XITO',
                                    tbRecord(1),
                                    null);
                    dbms_output.put_line('Modificacion Exitosa');
                    /**/
                  end if;
                else
                  --Se inserta el error por que no es el ciclo correspondiente
                  dbms_output.put_line('Error en el Ciclo del periodo de facturacion');
                  pInsDetaPeriodo(nuCodPeriodo,
                                tbArchivo(i),
                                'EL CICLO ' || tbRecord(2) || ' NO CORRESPONDE AL PERIODO DE CONSUMO ' || tbRecord(1),
                                null,
                                null);
                  Pkstatusexeprogrammgr.Processfinishnok(sbProgramName,
                                                       'PERIODO DE CONSUMO ' || tbRecord(1) || ' NO EXISTE');
                  Pkgeneralservices.Committransaction;
                end if;
              else
                --Se inserta el error por que no existe el periodo
                dbms_output.put_line('Error en el Periodo indicado no existe o no esta activo');
                pInsDetaPeriodo(nuCodPeriodo,
                              tbArchivo(i),
                              'PERIODO DE CONSUMO ' || tbRecord(1) || ' NO EXISTE',
                              null,
                              null);
                Pkstatusexeprogrammgr.Processfinishnok(sbProgramName,
                                                     'PERIODO DE CONSUMO ' || tbRecord(1) || ' NO EXISTE');
                Pkgeneralservices.Committransaction;
              end if;

            END IF;

          EXCEPTION
            WHEN OTHERS THEN
              --Se inserta el detalle del proceso
              pInsDetaPeriodo(nuCodPeriodo,
                              tbArchivo(i),
                              sqlerrm,
                              null,
                              null);

              Pkstatusexeprogrammgr.Processfinishnok(sbProgramName,
                                                     sqlerrm);
              Pkgeneralservices.Committransaction;
          END;
        END IF;
      END LOOP;

      --Finaliza proceso
      Pkstatusexeprogrammgr.Upstatusexeprogramat(sbProgramName,
                                                 'Proceso en ejecucion...',
                                                 nuTotalRegistros,
                                                 nuProcessedRecords);
      Pkstatusexeprogrammgr.Processfinishnok(sbProgramName,
                                             'Proceso Finalizado');
      Pkgeneralservices.Committransaction;
    END IF;
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    when pkg_error.controlled_error then
	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      raise;
    when OTHERS then
      pkg_error.setError;
	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  END ProcessLDCCPC;

  PROCEDURE ProcessLDCCPF(isbName ldc_cargperi.capename%TYPE) IS
    tbArchivo    tytabla;
    tbRecord     tytabla;
    rcPerifact   PERIFACT%ROWTYPE;
    nuCodPeriodo ldc_cargperi.CAPECODI%TYPE;
    nuPerifact   perifact.pefacodi%type;

	nuError		NUMBER;
	sbError		VARCHAR2(4000);

    --20.09.18 Variables y Cursor datos del periodo
    continuar number := 1; --Determinara si continua el proceso 1 (ok) 0 (no)
    nuExistPeriodo number;
    nuExistCiclo number;
    faano perifact.pefaano%TYPE;
    fames perifact.pefames%TYPE;
    facicl perifact.pefacicl%TYPE;
    fafimo perifact.pefafimo%TYPE;
    faffmo perifact.pefaffmo%TYPE;
    fafeco perifact.pefafeco%TYPE;
    fafepa perifact.pefafepa%TYPE;
    faffpa perifact.pefaffpa%TYPE;
    CURSOR cuPeriodo(inuPeriodo in perifact.pefacodi%TYPE) IS
      SELECT pe.pefaano, pe.pefames, pe.pefacicl, pe.pefafimo, pe.pefaffmo, pe.pefafeco, pe.pefafepa, pe.pefaffpa
        FROM perifact pe
       WHERE pe.pefacodi = inuPeriodo;

    CURSOR cuDatosCiclo(inuCiclo in perifact.pefacicl%TYPE, inuAno in perifact.pefaano%TYPE, inuMes in perifact.pefames%TYPE) IS
      SELECT count(*)
        FROM perifact pe
       WHERE pe.pefacicl = inuCiclo
       AND pe.pefaano = inuAno
       AND pe.pefames = inuMes;

    CURSOR cuExistPeriodo(inuPeriodo in perifact.pefacodi%TYPE) IS
      SELECT count(pe.pefacodi)
      FROM perifact pe
      WHERE pe.pefacodi = inuPeriodo
          AND pe.pefacodi >= ( SELECT pefacodi
                               FROM perifact p
                               WHERE p.pefacicl = pe.pefacicl
                                 AND p.pefaactu = 'S');
    difDias1 number;
    difDias2 number;
    difDias3 number;
    difDias4 number;
    faanoP perifact.pefaano%TYPE;
    famesP perifact.pefames%TYPE;
    --cursor para proceso de actualizacion
    facodiP perifact.pefacodi%TYPE;
    fafimoP perifact.pefafimo%TYPE;
    faffmoP perifact.pefaffmo%TYPE;
    fafecoP perifact.pefafeco%TYPE;
    fafepaP perifact.pefafepa%TYPE;
    faffpaP perifact.pefaffpa%TYPE;
	
	csbMetodo VARCHAR2(100) := csbSP_NAME||'ProcessLDCCPF';
	
    CURSOR cuPeriodos(inuCiclo in perifact.pefacicl%TYPE, inuAno in perifact.pefaano%TYPE, inuMes in perifact.pefames%TYPE) IS
      SELECT pe.pefacodi, pe.pefafimo, pe.pefaffmo, pe.pefafeco, pe.pefafepa, pe.pefaffpa
        FROM perifact pe
       WHERE pe.pefacicl = inuCiclo
       AND to_date('01/' || pe.pefames || '/' || pe.pefaano) > to_date('01/' || inuMes || '/' || inuAno)
       ORDER BY pefacodi ;

      CURSOR cuPeriodosDesc(inuCiclo in perifact.pefacicl%TYPE, inuAno in perifact.pefaano%TYPE, inuMes in perifact.pefames%TYPE) IS
      SELECT pe.pefacodi, pe.pefafimo, pe.pefaffmo, pe.pefafeco, pe.pefafepa, pe.pefaffpa
        FROM perifact pe
       WHERE pe.pefacicl = inuCiclo
       AND to_date('01/' || pe.pefames || '/' || pe.pefaano) > to_date('01/' || inuMes || '/' || inuAno)
       ORDER BY pefacodi desc;

  BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    --Se obtienen las l?neas del archivo en una tabla PL
    pLeerArchivo(isbName, csbRuta, tbArchivo);

    -- Crea el nombre del proceso
    sbProgramName := 'LDCCPF' || Sqesprprog.Nextval;

    --Si el archivo tiene l?neas para procesar
    IF (tbArchivo.count > 0) THEN
      nuTotalRegistros := tbArchivo.count - 1;

      -- Inserta registo de seguimiento en ESTAPROG
      Pkstatusexeprogrammgr.Addrecord(sbProgramName,
                                      'Proceso en ejecucion ...',
                                      0);
      Pkgeneralservices.Committransaction;

      --Se actualiza el total de registros para procesar
      Pkstatusexeprogrammgr.Upstatusexeprogramat(sbProgramName,
                                                 'Proceso en ejecucion...',
                                                 nuTotalRegistros,
                                                 0);
      Pkgeneralservices.Committransaction;

      --Se obtiene el c?digo de la secuencia
      nuCodPeriodo := SEQ_LDC_CARGPERI.nextval;

      --Inserta en las tablas de LOG
      pInsPeriodo(nuCodPeriodo, isbName, csbRuta, tbArchivo.count, 'F');

      --Se procesan las l?neas del archivo
      FOR i IN tbArchivo.FIRST .. tbArchivo.LAST LOOP

        --Se descarta el encabezado
        IF (i = 1) THEN
          continue;
        END IF;

        --Devuelve los datos de la l?nea en una tabla
        ParseString(tbArchivo(i), ';', tbRecord);

        IF (tbRecord.count > 0) THEN
          BEGIN
            ----------------------------------------------------
            --REQ.200-1907
            /*Observacion: Se agrego una nueva columna, con el nuevo
            cambio aplicado la columna uno [tbRecord(1)] ya no es el ciclo
            si no que corresponde al periodo de facturacion a actualizar
            por lo tanto las demas columnas aumentan en el valor de 1.*/
            ----------------------------------------------------
            --Si no se obtiene periodo de facturacion, se obtiene de la secuencia y se crea
            --Como se hace actualmente.
            IF tbRecord(1) IS NULL THEN

              nuPerifact := SQ_PERIFACT_PEFACODI.nextval;

              --Se arma el record de pericose
              --REQ.200-1907. Se corren en 1 las columnas
              rcPerifact.PEFACODI := nuPerifact;
              --rcPerifact.PEFACICL := tbRecord(1);
              rcPerifact.PEFACICL := tbRecord(2);
              --rcPerifact.PEFADESC := tbRecord(2);
              rcPerifact.PEFADESC := tbRecord(3);
              --rcPerifact.PEFAANO  := tbRecord(3);
              rcPerifact.PEFAANO := tbRecord(4);
              --rcPerifact.PEFAMES  := tbRecord(4);
              rcPerifact.PEFAMES  := tbRecord(5);
              rcPerifact.PEFASACA := 0; --Por defecto es cero desde la consola de facturaci?n
              --rcPerifact.PEFAFIMO := tbRecord(5);
              rcPerifact.PEFAFIMO := tbRecord(6);
              /*rcPerifact.PEFAFFMO := to_date(to_char(to_date(tbRecord(6) ||
                      ' 11:59:59'),
              'dd/mm/yyyy HH:MI:SS'));*/
              rcPerifact.PEFAFFMO := to_date(to_char(to_date(tbRecord(7) ||
                                                             ' 11:59:59'),
                                                     'dd/mm/yyyy HH:MI:SS'));
              rcPerifact.PEFAFECO := sysdate;
              /*rcPerifact.PEFAFEPA := to_date(to_char(to_date(tbRecord(7) ||
                      ' 11:59:59'),
              'dd/mm/yyyy HH:MI:SS'));*/
              rcPerifact.PEFAFEPA := to_date(to_char(to_date(tbRecord(8) ||
                                                             ' 11:59:59'),
                                                     'dd/mm/yyyy HH:MI:SS'));
              /*rcPerifact.PEFAFFPA := to_date(to_char(to_date(tbRecord(8) ||
                      ' 11:59:59'),
              'dd/mm/yyyy HH:MI:SS'));*/
              rcPerifact.PEFAFFPA := to_date(to_char(to_date(tbRecord(9) ||
                                                             ' 11:59:59'),
                                                     'dd/mm/yyyy HH:MI:SS'));
              --rcPerifact.PEFAOBSE := tbRecord(9);
              rcPerifact.PEFAOBSE := tbRecord(10);
              rcPerifact.PEFAFEGE := sysdate;
              rcPerifact.PEFAACTU := 'N';

              --Se inserta el record
              pktblperifact.INSRECORD(rcPerifact);
              pkGeneralServices.committransaction;

              nuProcessedRecords := i - 1;

              --Se actualiza progreso
              Pkstatusexeprogrammgr.Upstatusexeprogramat(sbProgramName,
                                                         'Proceso en ejecucion...',
                                                         nuTotalRegistros,
                                                         nuProcessedRecords);
              Pkgeneralservices.Committransaction;

              --Se inserta el detalle del proceso
              pInsDetaPeriodo(nuCodPeriodo,
                              tbArchivo(i),
                              'PROCESADO CON ?XITO',
                              null,
                              nuPerifact);
            ELSE
              --REQ.200-1907 Nueva logica de actualizacion.

              --20.09.18 - validacion del periodo
              dbms_output.put_line('Validacion del Periodo ' || tbRecord(1));
               --TICKET 200-2231 LJLB -- se valida que el cursor no este abierto
              IF cuExistPeriodo%ISOPEN THEN
               CLOSE cuExistPeriodo;
              END IF;

              open cuExistPeriodo(tbRecord(1));
              fetch cuExistPeriodo
                INTO nuExistPeriodo;
              close cuExistPeriodo;
              if nuExistPeriodo > 0 then

                --TICKET 200-2231 LJLB -- se valida que el cursor no este abierto
                IF cuPeriodo%ISOPEN THEN
                 CLOSE cuPeriodo;
                END IF;
                --Verifico los datos del periodo
                open cuPeriodo(tbRecord(1));
                fetch cuPeriodo
                  INTO faano, fames, facicl, fafimo, faffmo, fafeco, fafepa, faffpa;
                close cuPeriodo;

                if tbRecord(2) = facicl then
                  dbms_output.put_line('Validacion del Ciclo ' || tbRecord(2));
                  --Verifico el A?o y el Mes
                  dbms_output.put_line('Validacion del A?o y del Mes ' || tbRecord(4) || ' - ' || tbRecord(5));
                  if faano <> tbRecord(4) or fames <> tbRecord(5) then
                     --TICKET 200-2231 LJLB -- se valida que el cursor no este abierto
                    IF cuDatosCiclo%ISOPEN THEN
                     CLOSE cuDatosCiclo;
                    END IF;
                    open cuDatosCiclo(tbRecord(2),tbRecord(4),tbRecord(5));
                    fetch cuDatosCiclo
                      INTO nuExistCiclo;
                    close cuDatosCiclo;
                    if nuExistCiclo > 0 then
                      dbms_output.put_line('El Ciclo ya tiene asignado ese Mes y A?o en otro Periodo');
                      pInsDetaPeriodo(nuCodPeriodo,
                                    tbArchivo(i),
                                    'EL CICLO ' || tbRecord(2) || ' YA TIENE ASIGNADO UN PERIDODO AL A?O ' || tbRecord(4) || ' Y EL MES ' || tbRecord(5) || ' INDICADO',
                                    null,
                                    null);
                      Pkstatusexeprogrammgr.Processfinishnok(sbProgramName,
                                                           'PERIODO DE FACTURACION ' || tbRecord(1) || ' NO EXISTE O NO ESTA ACTIVO');
                      Pkgeneralservices.Committransaction;
                      continuar := 0;
                    end if;
                  end if;
                  if continuar = 1 then
                    --proceso de asignacion todo OK para modificar el periodo
                    --buscar la diferencia y asignarsela a los periodos posteriores del ciclo
                    dbms_output.put_line('Asigno las diferencias');
                    difDias1 := trunc(to_date(tbRecord(7)) - trunc(faffmo));
                    difDias2 := trunc(to_date(tbRecord(8)) - trunc(fafepa));
                    difDias3 := trunc(to_date(tbRecord(9)) - trunc(faffpa));
                    difDias4 := trunc(to_date(tbRecord(11)) - trunc(fafeco));
                    dbms_output.put_line('Diferencia 1 (' || tbRecord(7) || ' - ' || fafimo || ') ' || difDias1);
                    dbms_output.put_line('Diferencia 2 (' || tbRecord(8) || ' - ' || fafepa || ') ' || difDias2);
                    dbms_output.put_line('Diferencia 3 (' || tbRecord(9) || ' - ' || faffpa || ') ' || difDias3);
                    dbms_output.put_line('Diferencia 4 (' || tbRecord(11) || ' - ' || fafeco || ') ' || difDias4);

                    IF difDias1 <= 0 THEN

                       UPDATE perifact --TABLA PERIODO DE FACTURACION
                       SET pefacicl = tbRecord(2), --ciclo de facturacion
                           pefadesc = tbRecord(3), --descripcion del periodo de facturacion
                           pefaano  = tbRecord(4), --ano periodo facturacion.
                           pefames  = tbRecord(5), --mes periodo.
                           pefafimo = tbRecord(6), --fecha inicial movimientos facturar.
                           pefaffmo = tbRecord(7), --fecha final movimientos facturar/facturado.
                           pefafepa = tbRecord(8), --fecha limite pago facturacion periodo.
                           pefaffpa = tbRecord(9), --fecha final control registro pagos.
                           pefaobse = tbRecord(10), --observaciones periodo
                           pefafeco = tbRecord(11) -- fecha de corte
                     WHERE pefacodi = tbRecord(1); --codigo periodo facturacion.
                     dbms_output.put_line('Modificado el Periodo ' || tbRecord(1));

                    --TICKET 200-2231 LJLB -- se valida que el cursor no este abierto
                    IF cuPeriodos%ISOPEN THEN
                      CLOSE cuPeriodos;
                     END IF;


                    OPEN cuPeriodos(tbRecord(2), tbRecord(4), tbRecord(5));
                    LOOP
                      FETCH cuPeriodos INTO facodiP, fafimoP, faffmoP, fafecoP, fafepaP, faffpaP;
                      EXIT WHEN cuPeriodos%NOTFOUND;
                      UPDATE perifact
                       SET pefafimo = pefafimo + difDias1, --fecha inicial movimientos facturar.
                           pefaffmo = pefaffmo + difDias1, --fecha final movimientos facturar/facturado.
                           pefafepa = pefafepa + difDias2, --fecha limite pago facturacion periodo.
                           pefaffpa = pefaffpa + difDias3, --fecha final control registro pagos.
                           pefafeco = pefafeco + difDias4 -- fecha de corte
                     WHERE pefacodi = facodiP; --codigo periodo facturacion.
                     dbms_output.put_line('Modificado el Periodo ' || facodiP);
                    END LOOP;
                    close cuPeriodos;
                ELSE
                  --TICKET 200-2231 LJLB -- se valida que el cursor no este abierto
                    IF cuPeriodosDesc%ISOPEN THEN
                      CLOSE cuPeriodosDesc;
                     END IF;

                    OPEN cuPeriodosDesc(tbRecord(2), tbRecord(4), tbRecord(5));
                    LOOP
                      FETCH cuPeriodosDesc INTO facodiP, fafimoP, faffmoP, fafecoP, fafepaP, faffpaP;
                      EXIT WHEN cuPeriodosDesc%NOTFOUND;
                      UPDATE perifact
                       SET pefafimo = pefafimo + difDias1, --fecha inicial movimientos facturar.
                           pefaffmo = pefaffmo + difDias1, --fecha final movimientos facturar/facturado.
                           pefafepa = pefafepa + difDias2, --fecha limite pago facturacion periodo.
                           pefaffpa = pefaffpa + difDias3, --fecha final control registro pagos.
                           pefafeco = pefafeco + difDias4 -- fecha de corte
                     WHERE pefacodi = facodiP; --codigo periodo facturacion.
                     dbms_output.put_line('Modificado el Periodo ' || facodiP);
                    END LOOP;
                    close cuPeriodosDesc;

                     UPDATE perifact --TABLA PERIODO DE FACTURACION
                     SET pefacicl = tbRecord(2), --ciclo de facturacion
                         pefadesc = tbRecord(3), --descripcion del periodo de facturacion
                         pefaano  = tbRecord(4), --ano periodo facturacion.
                         pefames  = tbRecord(5), --mes periodo.
                         pefafimo = tbRecord(6), --fecha inicial movimientos facturar.
                         pefaffmo = tbRecord(7), --fecha final movimientos facturar/facturado.
                         pefafepa = tbRecord(8), --fecha limite pago facturacion periodo.
                         pefaffpa = tbRecord(9), --fecha final control registro pagos.
                         pefaobse = tbRecord(10), --observaciones periodo
                         pefafeco = tbRecord(11) -- fecha de corte
                   WHERE pefacodi = tbRecord(1); --codigo periodo facturacion.
                   dbms_output.put_line('Modificado el Periodo ' || tbRecord(1));

                END IF;
                    --Asignacion de los nuevos datos para el ciclo
                    --codigo original
                    /**/
                    --Si se obtiene el periodo de facturacion de la tabla se actualiza.



                    --REQ.200-1907 Se realiza la misma logica que hace el proceso actualmente.

                    pkGeneralServices.committransaction;

                    nuProcessedRecords := i - 1;

                    --Se actualiza progreso
                    Pkstatusexeprogrammgr.Upstatusexeprogramat(sbProgramName,
                                                               'Proceso en ejecucion...',
                                                               nuTotalRegistros,
                                                               nuProcessedRecords);
                    Pkgeneralservices.Committransaction;

                    --Se inserta el detalle del proceso
                    pInsDetaPeriodo(nuCodPeriodo,
                                    tbArchivo(i),
                                    'PROCESADO CON ?XITO',
                                    null,
                                    tbRecord(1));
                    dbms_output.put_line('Modificacion Exitosa');
                    /**/
                  end if;
                else
                  --Se inserta el error por que no es el ciclo correspondiente
                  dbms_output.put_line('Error en el Ciclo del periodo de facturacion');
                  pInsDetaPeriodo(nuCodPeriodo,
                                tbArchivo(i),
                                'EL CICLO ' || tbRecord(2) || ' NO CORRESPONDE AL PERIODO DE FACTURACION ' || tbRecord(1),
                                null,
                                null);
                  Pkstatusexeprogrammgr.Processfinishnok(sbProgramName,
                                                       'EL CICLO ' || tbRecord(2) || ' NO CORRESPONDE AL PERIODO DE FACTURACION ' || tbRecord(1));
                  Pkgeneralservices.Committransaction;
                end if;
              else
                --Se inserta el error por que no existe el periodo
                dbms_output.put_line('Error en el Periodo indicado no existe o es inferior al activo');
                pInsDetaPeriodo(nuCodPeriodo,
                              tbArchivo(i),
                              'PERIODO DE FACTURACION ' || tbRecord(1) || ' NO EXISTE O ES INFERIOR AL ACTIVO',
                              null,
                              null);
                Pkstatusexeprogrammgr.Processfinishnok(sbProgramName,
                                                     'PERIODO DE FACTURACION ' || tbRecord(1) || ' NO EXISTE O ES INFERIOR AL ACTIVO');
                Pkgeneralservices.Committransaction;
              end if;

            END IF;

          EXCEPTION
            WHEN OTHERS THEN
              --Se inserta el detalle del proceso
              pInsDetaPeriodo(nuCodPeriodo,
                              tbArchivo(i),
                              sqlerrm,
                              null,
                              null);
              Pkstatusexeprogrammgr.Processfinishnok(sbProgramName,
                                                     sqlerrm);
              Pkgeneralservices.Committransaction;
          END;
        END IF;
      END LOOP;

      --Finaliza proceso
      Pkstatusexeprogrammgr.Upstatusexeprogramat(sbProgramName,
                                                 'Proceso en ejecucion...',
                                                 nuTotalRegistros,
                                                 nuProcessedRecords);
      Pkstatusexeprogrammgr.Processfinishnok(sbProgramName,
                                             'Proceso Finalizado');
      Pkgeneralservices.Committransaction;
    END IF;

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    when pkg_error.controlled_error then
	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      raise;
    when OTHERS then
      pkg_error.setError;
	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;

  END ProcessLDCCPF;

  /*******************************************************************************
  <Procedure Fuente="Propiedad Intelectual de Empresas P?blicas de Medell?n">
  <Unidad> pLeerArchivo </Unidad>
  <Descripcion>
      Lee un archivo y lo devuelve una colecci?n (TABLA PL).
  </Descripcion>
  <Autor> Johanna Noguera Le?n - Axede S.A </Autor>
  <Fecha> 31/10/2016 </Fecha>
  <Parametros>
      <param nombre="isbNombreArchivo" tipo="varchar2" Direccion="IN">
          Nombre del Archivo
      </param>
      <param nombre="itbDatosTraza" tipo="pkg_epm_utilidades.tytabla" Direccion="IN">
          Tabla PL con los datos del archivo
      </param>
      <param nombre="oflArchivo" tipo="utl_file.file_TYPE" Direccion="OUT">
          Archivo
      </param>
  </Parametros>
  <Historial>
      <Modificacion Autor="jnoguera" Fecha="31/10/2016" Inc="OC[XXXXXX]">
      Creaci?n del m?todo
      </Modificacion>
  </Historial>
  </Procedure>
  *******************************************************************************/
  PROCEDURE pLeerArchivo(isbNombreArchivo in varchar2,
                         isbRuta          in varchar2,
                         otbDatosArchivo  out tytabla) IS
    oflArchivo  PKG_GESTIONARCHIVOS.STYARCHIVO;
    v_exists    BOOLEAN;
    v_length    NUMBER;
    v_blocksize NUMBER;
	
	csbMetodo VARCHAR2(100) := csbSP_NAME||'pLeerArchivo';
	nuError		NUMBER;
	sbError		VARCHAR2(4000);


    PROCEDURE ProFileToTable(iflArchivo IN PKG_GESTIONARCHIVOS.STYARCHIVO,
                             otbTabla   OUT tyTabla) IS
      nuIndice  NUMBER;
      sbLinea   varchar2(2000);
      EndOfFile BOOLEAN := false;
	  csbMetodo1 VARCHAR2(200) := csbMetodo||'.ProFileToTable';
      iflArchivo1   PKG_GESTIONARCHIVOS.STYARCHIVO;
	  
    BEGIN
	  pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
      nuIndice := 1;
      iflArchivo1 := iflArchivo;
      
      WHILE (EndOfFile = false) lOOP
        BEGIN
          sbLinea:= PKG_GESTIONARCHIVOS.FSBOBTENERLINEA_UT(iflArchivo1);
          sbLinea := REPLACE(sbLinea, CHR(13), '');
          sbLinea := REPLACE(sbLinea, CHR(10), '');
          otbTabla(nuIndice) := sbLinea;
          nuIndice := nuIndice + 1;
        EXCEPTION
          WHEN no_data_found THEN
            EndOfFile := TRUE;
        END;
      END LOOP;
	  pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
      WHEN OTHERS THEN
        raise;
    END ProFileToTable;
  BEGIN
  
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    --Se valida que exista el archivo en la ruta.
	PKG_GESTIONARCHIVOS.PRCATRIBUTOSARCHIVO_UT(isbRuta,
											  isbNombreArchivo,
											  v_exists,
											  v_length,
											  v_blocksize);

    --Si existe
    IF (v_exists) THEN
      -- Abre el archivo a procesar
      oflArchivo := PKG_GESTIONARCHIVOS.FTABRIRARCHIVO_UT(isbRuta, isbNombreArchivo, 'R');
      -- Carga el archivo a una tabla PL
      ProFileToTable(oflArchivo, otbDatosArchivo);
      PKG_GESTIONARCHIVOS.prcCerrarArchivo_Ut(oflArchivo);
    ELSE
      --Se levanta mensaje de error
      pkg_error.setErrorMessage(2741,
							   'No existe el archivo [' ||
							   isbNombreArchivo || '] en la ruta [' ||
							   isbRuta || ']');
    END IF;
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_error.controlled_error  THEN
      PKG_GESTIONARCHIVOS.prcCerrarArchivo_Ut(oflArchivo);
	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE;
    WHEN OTHERS THEN
      pkg_error.setError;
      PKG_GESTIONARCHIVOS.prcCerrarArchivo_Ut(oflArchivo);
	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE;
  END pLeerArchivo;
  

  PROCEDURE ParseString(ivaCadena IN VARCHAR2,
                        ivaToken  IN VARCHAR2,
                        otbSalida OUT tyTabla) IS
    nuIniBusqueda   NUMBER := 1;
    nuFinBusqueda   NUMBER := 1;
    sbArgumento     VARCHAR2(2000);
    nuIndArgumentos NUMBER := 1;
    nuLongitudArg   NUMBER;
	
	csbMetodo VARCHAR2(100) := csbSP_NAME||'ParseString';

    sbErrMsg VARCHAR2(4000);
	
	nuError		NUMBER;
	sbError		VARCHAR2(4000);

  BEGIN
  
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
  
    -- Recorre la lista de argumentos y los guarda en un tabla pl-sql
    WHILE (ivaCadena IS NOT NULL) LOOP
      -- Busca el separador en la cadena y almacena su posicion
      nuFinBusqueda := INSTR(ivaCadena, ivaToken, nuIniBusqueda);

      -- Si no exite el pipe, debe haber un argumento
      IF (nuFinBusqueda = 0) THEN
        -- Obtiene el argumento
        sbArgumento := SUBSTR(ivaCadena, nuIniBusqueda);
        otbSalida(nuIndArgumentos) := sbArgumento;

        -- Termina el ciclo
        EXIT;
      END IF;

      -- Obtiene el argumento hasta el separador
      nuLongitudArg := nuFinBusqueda - nuIniBusqueda;
      sbArgumento   := SUBSTR(ivaCadena, nuIniBusqueda, nuLongitudArg);
      -- Lo adiciona a la tabla de argumentos, quitando espacios y ENTER a los lados
      otbSalida(nuIndArgumentos) := TRIM(REPLACE(sbArgumento, CHR(13), ''));
      -- Inicializa la posicion inicial con la posicion del caracterer
      -- despues del pipe
      nuIniBusqueda := nuFinBusqueda + 1;
      -- Incrementa el indice de la tabla de argumentos
      nuIndArgumentos := nuIndArgumentos + 1;
    END LOOP;
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
	
  EXCEPTION
    WHEN OTHERS THEN
      pkg_error.setError;
	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  END ParseString;



  PROCEDURE pInsPeriodo(inuCodigo ldc_cargperi.CAPECODI%TYPE,
                        isbName   ldc_cargperi.capename%TYPE,
                        isbRuta   ld_parameter.value_chain%TYPE,
                        inuCant   ldc_cargperi.CAPECANT%TYPE,
                        isbEven   ldc_cargperi.CAPEEVEN%TYPE) IS
    rcRecord DALDC_CARGPERI.styLDC_CARGPERI;
	
	csbMetodo VARCHAR2(100) := csbSP_NAME||'pInsPeriodo';
	
	nuError		NUMBER;
	sbError		VARCHAR2(4000);

	
  BEGIN
  
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
  
    rcRecord.CAPECODI := inuCodigo;
    rcRecord.CAPENAME := isbName;
    rcRecord.CAPERUTA := isbRuta;
    rcRecord.CAPECANT := inuCant;
    rcRecord.CAPEEVEN := isbEven;
    rcRecord.CAPEDATE := sysdate;
    rcRecord.CAPEUSER := sbUser;
    rcRecord.CAPETERM := sbTerminal;

    DALDC_CARGPERI.INSRECORD(rcRecord);
    pkGeneralServices.committransaction;
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    when pkg_error.controlled_error then
	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      raise;

    when OTHERS then
      pkg_error.setError;
	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  END pInsPeriodo;
  
  
  PROCEDURE pInsDetaPeriodo(inuCodigo  ldc_cargperi.CAPECODI%TYPE,
                            isbLinea   ldc_perilogc.PERILINE%TYPE,
                            isbMensaje ldc_perilogc.PERIMENS%TYPE,
                            inuPeriodo ldc_perilogc.pericons%TYPE,
                            inuPefacod ldc_perilogc.peripefa%type) IS
    rcRecord DALDC_PERILOGC.styLDC_PERILOGC;
	
	csbMetodo VARCHAR2(100) := csbSP_NAME||'pInsDetaPeriodo';
	nuError		NUMBER;
	sbError		VARCHAR2(4000);

	
  BEGIN
  
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
  
    rcRecord.PERICODI := SEQ_LDC_PERILOGC.nextval;
    rcRecord.PERILINE := isbLinea;
    rcRecord.PERIMENS := isbMensaje;
    rcRecord.PERICARG := inuCodigo;
    rcRecord.PERIDATE := sysdate;
    rcRecord.PERICONS := inuPeriodo;
    rcRecord.PERIPEFA := inuPefacod;

    DALDC_PERILOGC.INSRECORD(rcRecord);
    pkGeneralServices.committransaction;
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    when pkg_error.controlled_error then
	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      raise;

    when OTHERS then
      pkg_error.setError;
	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      raise pkg_error.controlled_error;
  END pInsDetaPeriodo;
  


  /**************************************************************************
    Propiedad Intelectual de EFIGAS
    Procedimiento     :  pLlenarAtributos
    Descripcion :
    Autor       : Luis Lozada
    Fecha       : 10-09-2017

    Par?metros: iosbAtributos: variable con los datos de la consulta del PI

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    10-09-2017         llozada               Creaci?n.
  **************************************************************************/
  PROCEDURE pLlenarAtributos(iosbAtributos IN OUT Ge_BoUtilities.styStatement) IS
    sbEvento ge_boutilities.styStatementAttribute;
	csbMetodo VARCHAR2(100) := csbSP_NAME||'pLlenarAtributos';
	nuError		NUMBER;
	sbError		VARCHAR2(4000);

  BEGIN
  
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    IF iosbAtributos IS NOT NULL THEN
      RETURN;
    END IF;

    -- Se obtiene codigo-descripcion de los atributos a desplegar
    sbEvento := 'decode(CAPEEVEN, ''C'', ''C - Periodos de consumo'',
                                      ''F - Periodos de facturaci?n'')';

    -- Se Adicional los atributos a desplegar
    GE_BOUtilities.AddAttribute('CAPECODI', 'CODIGO', iosbAtributos);
    GE_BOUtilities.AddAttribute('CAPENAME', 'ARCHIVO', iosbAtributos);
    GE_BOUtilities.AddAttribute(sbEvento, 'Evento', iosbAtributos);
    GE_BOUtilities.AddAttribute('CAPECANT', 'Cant_reg', iosbAtributos);
    GE_BOUtilities.AddAttribute('CAPERUTA', 'Ruta', iosbAtributos);
    GE_BOUtilities.AddAttribute('CAPEDATE', 'Fecha_reg', iosbAtributos);
    GE_BOUtilities.AddAttribute('CAPEUSER', 'Usuario', iosbAtributos);
    GE_BOUtilities.AddAttribute('CAPETERM', 'Terminal', iosbAtributos);
    GE_BOUtilities.AddAttribute(':parent_id', 'parent_id', iosbAtributos);

    pkg_traza.trace(iosbAtributos);
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_error.controlled_error THEN
	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.controlled_error;
    WHEN OTHERS THEN
      pkg_error.setError;
  	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_error.controlled_error;
  END pLlenarAtributos;
  

  /**************************************************************************
    Propiedad Intelectual de EFIGAS
    Procedimiento     :  pobtGetCargaMasiva
    Descripcion : Servicio de consulta PI LDCPCF
    Autor       : Luis Lozada
    Fecha       : 10-09-2017

    Par?metros: sbCodigo: variable con los datos de la consulta del PI

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    10-09-2017         llozada               Creaci?n.
  **************************************************************************/
  PROCEDURE pobtGetCargaMasiva(sbCodigo      IN VARCHAR2,
                               ocuDataCursor OUT constants_per.tyRefCursor) IS
    sbSql       VARCHAR2(32767);
    nuCodigo    ldc_cargperi.capecodi%type;
    sbAtributos Ge_BoUtilities.styStatement;
	
	csbMetodo VARCHAR2(100) := csbSP_NAME||'pobtGetCargaMasiva';
	nuError		NUMBER;
	sbError		VARCHAR2(4000);

	
  BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    pLlenarAtributos(sbAtributos);

    nuCodigo := to_number(sbCodigo);

    sbSql := ' SELECT ' || sbAtributos || chr(10) ||
             ' FROM    LDC_CARGPERI ' || chr(10) ||
             ' WHERE   capecodi = :nuCodigo';

    pkg_traza.trace(sbSql);

    OPEN ocuDataCursor FOR sbSql
      USING cc_boBossUtil.cnuNULL, nuCodigo;
	  
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_error.controlled_error THEN
	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.controlled_error;
    WHEN OTHERS THEN
      pkg_error.setError;
	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_error.controlled_error;
  END pobtGetCargaMasiva;
  


  /**************************************************************************
    Propiedad Intelectual de EFIGAS
    Procedimiento     :  pobtGetCargaMasiva
    Descripcion : Servicio de b?squeda PI LDCPCF
    Autor       : Luis Lozada
    Fecha       : 10-09-2017

    Par?metros: sbCodigo: variable con los datos de la consulta del PI

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    10-09-2017         llozada               Creaci?n.
  **************************************************************************/
  PROCEDURE pobtSearhCargaMasiva(inuCodigo     IN ldc_cargperi.capecodi%TYPE,
                                 isbNombre     IN ldc_cargperi.capename%TYPE,
                                 isbEvento     IN ldc_cargperi.CAPEEVEN%TYPE,
                                 idtFechaIni   IN ldc_cargperi.CAPEDATE%TYPE,
                                 idtFechaFin   IN ldc_cargperi.CAPEDATE%TYPE,
                                 ocuDataCursor OUT constants_per.tyRefCursor) IS
    sbSql       VARCHAR2(32767);
    sbAtributos Ge_BoUtilities.styStatement;

    nuCodigo   ldc_cargperi.capecodi%TYPE;
    sbNombre   ldc_cargperi.capename%TYPE;
    sbEvento   ldc_cargperi.CAPEEVEN%TYPE;
    dtFechaFin ldc_cargperi.CAPEDATE%TYPE;
    dtFechaIni ldc_cargperi.CAPEDATE%TYPE;
	
	csbMetodo VARCHAR2(100) := csbSP_NAME||'pobtSearhCargaMasiva';
	nuError		NUMBER;
	sbError		VARCHAR2(4000);


  BEGIN
  
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
  
    pkg_traza.trace('inuCodigo: ' || inuCodigo);
    pkg_traza.trace('isbNombre: ' || isbNombre);
    pkg_traza.trace('isbEvento: ' || isbEvento);
    pkg_traza.trace('idtFechaIni: ' || idtFechaIni);
    pkg_traza.trace('idtFechaFin: ' || idtFechaFin);

    nuCodigo := nvl(inuCodigo, CC_BOConstants.cnuAPPLICATIONNULL);
    sbNombre := TRIM(upper(nvl(isbNombre, CC_BOConstants.csbNULLSTRING)));
    sbEvento := TRIM(upper(nvl(isbEvento, null)));

    pkg_traza.trace('nuCodigo: ' || nuCodigo);
    pkg_traza.trace('sbNombre: ' || sbNombre);
    pkg_traza.trace('sbEvento: ' || sbEvento);

    pLlenarAtributos(sbAtributos);

    --CRITERIOS PARA LA FECHA
    IF idtFechaIni is not null AND idtFechaFin is not null THEN

      dtFechaIni := trunc(to_date(idtFechaIni, LDC_BOCONSGENERALES.FSBGETFORMATOFECHA));
      dtFechaFin := trunc(to_date(idtFechaFin, LDC_BOCONSGENERALES.FSBGETFORMATOFECHA));
      pkg_traza.trace('dtFechaIni: ' || dtFechaIni);
      pkg_traza.trace('dtFechaFin: ' || dtFechaFin);

      sbSql := ' SELECT ' || sbAtributos || chr(10) ||
               ' FROM LDC_CARGPERI ' || chr(10) ||
               ' WHERE capecodi = decode(:nuCodigo,-1,capecodi,:nuCodigo)' ||
               chr(10) ||
               ' AND upper(capename) LIKE upper(decode(:sbNombre,''-1'',capename,:sbNombre))' ||
               chr(10) ||
               ' AND capeeven = decode(:sbEvento,null,capeeven,:sbEvento)' ||
               chr(10) || ' AND CAPEDATE >= :FechaInicial' || chr(10) ||
               ' AND CAPEDATE <= :FechaFinal' || chr(10);

      pkg_traza.trace(sbSql);

      OPEN ocuDataCursor FOR sbSql
        USING cc_boBossUtil.cnuNULL, nuCodigo, nuCodigo, sbNombre, sbNombre, sbEvento, sbEvento, dtFechaIni, dtFechaFin;

    ELSE
      sbSql := ' SELECT ' || sbAtributos || chr(10) ||
               ' FROM LDC_CARGPERI ' || chr(10) ||
               ' WHERE capecodi = decode(:nuCodigo,-1,capecodi,:nuCodigo)' ||
               chr(10) ||
               ' AND upper(capename) LIKE upper(decode(:sbNombre,''-1'',capename,:sbNombre))' ||
               chr(10) ||
               ' AND capeeven = decode(:sbEvento,null,capeeven,:sbEvento)' ||
               chr(10);

      pkg_traza.trace(sbSql);

      OPEN ocuDataCursor FOR sbSql
        USING cc_boBossUtil.cnuNULL, nuCodigo, nuCodigo, sbNombre, sbNombre, sbEvento, sbEvento;
    END IF;
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_error.controlled_error THEN
	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.controlled_error;
    WHEN OTHERS THEN
      pkg_error.setError;
	  pkg_error.getError(nuError, sbError);
	  pkg_traza.trace(csbMetodo||' '||sbError);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_error.controlled_error;
  END pobtSearhCargaMasiva;
END LDC_PKBOCARGAPERIODOS;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKBOCARGAPERIODOS', 'ADM_PERSON');
END;
/

