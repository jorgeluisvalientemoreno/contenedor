CREATE OR REPLACE PACKAGE adm_person.ldc_uildc_fifcast
IS
    /*****************************************************************
    Propiedad intelectual de CSC.

    Unidad         : LDC_UILDC_FIFCAST
    Descripci?n    : Paquete para uso del pb LDC_FIFCAST.
    Autor          : Manuel Alejandro Mejia
    Fecha          : 01-12-2017

    Historia de Modificaciones
    Fecha       Autor                   Modificaci?n
    =========   =========               ====================
    01-12-2017  Mmejia                  Creaci?n.
    14-08-2024  jpinedc                 OSF-3126: Se modifica Process
	15/01/2025	jerazomvm				OSF-3843: Se modifica el procedimiento Process
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /*******************************************************************************
    Propiedad intelectual de CSC.

    Unidad     :   fsbVersion
    Descripcion:   Obtiene la version del paquete.
    *******************************************************************************/
    FUNCTION FSBVERSION
    RETURN VARCHAR2;

    /*******************************************************************************
    Propiedad intelectual de CSC.

    Unidad     :   Initialize
    Descripcion:   Servicio de inicializaci?n.
    *******************************************************************************/
    PROCEDURE Initialize;


    /*******************************************************************************
    Propiedad intelectual de CSC.

    Unidad     :   Process
    Descripcion:   Servicio de proceso
    *******************************************************************************/
    PROCEDURE Process(
                      inuPefaCicl IN  perifact.pefacicl%TYPE,
                      idaPefafimo IN  perifact.pefafimo%TYPE,
                      idaPefaffmo IN  perifact.pefaffmo%TYPE,
                      inuDepartam IN  ge_geogra_location.geograp_location_id%TYPE,
                      inuLocalida IN  ge_geogra_location.geograp_location_id%TYPE,
                      isbDepto    IN  varchar2,
                      isbLocalida IN  varchar2,
                      isbContrato IN  varchar2,
                      isbRuta     IN  varchar2,
                      isbCiclo IN varchar2
                      );

    PROCEDURE BeforeExe;

END LDC_UILDC_FIFCAST;
/

CREATE OR REPLACE PACKAGE BODY adm_person.ldc_uildc_fifcast
    IS
    /*****************************************************************
    Propiedad intelectual de CSC.

    Unidad         : LDC_UILDC_FIFCAST
    Descripci?n    : Paquete para uso del pb LDC_FIFCAST.
    Autor          : Manuel Alejandro Mejia
    Fecha          : 01-12-2017

    Historia de Modificaciones
    Fecha       Autor                       Modificaci?n
    =========   =========                   ====================
    01-12-2017  Mmejia                      Creaci?n.
    ******************************************************************/

    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-3843';
	
	csbNOMPKG  	 		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.'; -- Constantes para el control de la traza
	cnuNVLTRC 			CONSTANT NUMBER 		:= pkg_traza.cnuNivelTrzDef;
	csbInicio 			CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    GSBERRMSG           GE_ERROR_LOG.DESCRIPTION%TYPE;
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /**************************************************************
    Propiedad intelectual de CSC.
    Unidad      :  fsbVersion
    Descripcion :  Obtiene la version del paquete.

    Autor	       : Manuel Alejandro Mejia
    Fecha	       : 01-12-2017

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    01-12-2017   Mmejia                 Creaci?n.
    26-11-2018   F.Castro               Se modifica la ubicacion del EXIT WHEN en el loop del cursor rfc_processfact
                                        (Caso 200-2294). Ademas se agrega error y linea del error en la tabla
                                         estaprog

    ***************************************************************/
    FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END FSBVERSION;

    /**************************************************************
    Propiedad intelectual de CSC.
    Unidad      :  Initialize
    Descripcion :  Servicio de inicializaci?n.

    Autor	       : Manuel Alejandro Mejia
    Fecha	       : 01-12-2017

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    01-12-2017   Mmejia                 Creaci?n.
    ***************************************************************/
    PROCEDURE Initialize
    IS
    BEGIN
        NULL;
    END Initialize;


    /**************************************************************
    Propiedad intelectual de CSC.
    Unidad      :  Process
    Descripcion :  Servicio de proceso

    Autor	       : Manuel Alejandro Mejia
    Fecha	       : 01-12-2017

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    01-12-2017   Mmejia                 Creaci?n.
    06-12-2017   cgonzalez              Creacion de los sql dinamicos para la
                                        consulta y generacion de facturas para
                                        los contratos castigados
    16-08-2015   Daniel Valiente        Se agrega el ingreso del Encabezado al archivo
    14-08-2024   jpinedc                Se cambia truncate por
                                        pkg_truncate_tablas_open.prcldc_cargosfact_castigo_tmp
	15-01-2025	 jerazomvm				OSF-3843: 
										1. Se reemplaza el llenado del encabezado cldata por LDC_BOPRINTFOFACTCUSTMGR.sbDest y
											se elimina el llamado al proceso LDC_BOPRINTFOFACTCUSTMgr.ClobWriteT(ClData);
										2. Se reemplaza el llamado del procedimiento LDC_BOPRINTFOFACTCUSTMgr.PrintFoByFact por 
											LDC_BOPRINTFOFACTCUSTMgr.prcPrintFoByFactSinTermLinea
    ***************************************************************/
    PROCEDURE Process(
                      inuPefaCicl IN  perifact.pefacicl%TYPE,
                      idaPefafimo IN  perifact.pefafimo%TYPE,
                      idaPefaffmo IN  perifact.pefaffmo%TYPE,
                      inuDepartam IN  ge_geogra_location.geograp_location_id%TYPE,
                      inuLocalida IN  ge_geogra_location.geograp_location_id%TYPE,
                      isbDepto    IN  varchar2,
                      isbLocalida IN  varchar2,
                      isbContrato IN  varchar2,
                      isbRuta     IN  varchar2,
                      isbCiclo    IN  varchar2
                      )
    IS
	
		csbMetodo 		VARCHAR2(100) := csbNOMPKG||'Process';
		
      sbProgramName       estaprog.esprprog%TYPE;
      sbExecutableName    sa_executable.name%TYPE :='LDC_FIFCAST';
      nuTotalRecords      NUMBER;
      nuProcessedRecords  NUMBER;
      nuRegistros         NUMBER := 0; -- Cantidad de registros a procesar
      idx                 NUMBER := 1; -- Indice para el manejo de registros
      sbsql               VARCHAR2(3000); -- sql dinamico para obtener los contratos castigados
      sbfrom              VARCHAR2(3000); -- cuerpo de seleccion de datos segun su ordenamiento
      sbOrderData         VARCHAR2(3000); -- datos segun su ordenamiento

      nuPefacodi          NUMBER := 1;
      sbPath              VARCHAR2(200) := dald_parameter.fsbGetValue_Chain('RUTA_FACT_CASTIGADOS');--Ruta
      sbFileName          VARCHAR2(200) :='';
      nuIdFormato         ed_formato.formcodi%TYPE:=282;

      nuFacturaCast       NUMBER; -- id de la cuenta de cobro -> nueva secuencia

      nuError 				NUMBER;
	  sberror             	VARCHAR2(2000);

      nucontproce         number;
      sbFactError         VARCHAR2(1000) := null;
      sbMensFinProc       varchar2(1000) := null;

      ------------------------
      --Curor para crear el tipo de datos de los productos castigados
      ------------------------
     CURSOR cuClienCastmp
          IS
      SELECT 0 sesususc, 0 cargcaca, SYSDATE fecha_castigo, 0 id_factura
        FROM dual;


      -- Obtiene los conceptos castigados por contrato
      CURSOR cu_detallefact    (inuSesu IN servsusc.sesususc%TYPE,
                                inucaca IN causcarg.cacacodi%TYPE,
                                idfecha IN DATE)
          IS
      SELECT ss.sesususc,
             ca.cargconc    Concepto,
             Decode(ca.cargsign,'DB','CR','CR','DB') signo_fact,
             SUM(ca.cargvalo)VALOR_FACT
        FROM cargos ca,
             servsusc ss,
             concepto co
       WHERE ca.cargnuse = ss.sesunuse
         AND ca.cargconc = co.conccodi
         AND ca.cargtipr = 'P'
         AND ss.sesususc = inuSesu
         AND ca.cargcaca = inucaca
         AND trunc(ca.cargfecr) = idfecha
       GROUP BY ss.sesususc, ca.cargconc,ca.cargsign;


      -- obtiene la informacion de los castigados
      CURSOR cu_DataCobro
          IS
      SELECT 0 id_suscripc,
             0 id_factura,
             0 id_cons_fact,
             0 dpto,
             0 localida,
             0 Ciclo,
             0 route_id
        FROM dual;


      -- tabla tipo PL para obtener los clientes castigados
      TYPE tytbClienteCast IS TABLE OF cuClienCastmp%ROWTYPE INDEX BY BINARY_INTEGER;
      tbClienteCast tytbClienteCast;

      -- almacena los detalles de factura por catigo de cartera
      TYPE tytbdetafactCast IS TABLE OF ldc_cargosfact_castigo_tmp%ROWTYPE INDEX BY BINARY_INTEGER;
      tbdetafactCast tytbdetafactCast;


       -- usuarios a procesar que tienen valores en cargos castigado
      TYPE tytbcu_DataCobro IS TABLE OF cu_DataCobro%ROWTYPE INDEX BY BINARY_INTEGER;
      tbcu_DataCobro tytbcu_DataCobro;

       TYPE tyrcastig    IS REF CURSOR;
       cuClienCast        tyrcastig;
       rfc_processfact    tyrcastig;

       --Caso 200-1685
       ClData Clob;
       --
	BEGIN
	
		pkg_traza.trace(csbMetodo, cnuNVLTRC, csbInicio);  
		
		pkg_traza.trace('inuPefaCicl ' 	|| inuPefaCicl 	|| chr(10) || 
						'idaPefafimo ' 	|| idaPefafimo 	|| chr(10) || 
						'idaPefaffmo ' 	|| idaPefaffmo 	|| chr(10) || 
						'inuDepartam ' 	|| inuDepartam 	|| chr(10) || 
						'inuLocalida ' 	|| inuLocalida 	|| chr(10) || 
						'isbDepto ' 	|| isbDepto 	|| chr(10) || 
						'isbLocalida ' 	|| isbLocalida 	|| chr(10) || 
						'isbContrato ' 	|| isbContrato 	|| chr(10) || 
						'isbRuta ' 		|| isbRuta 		|| chr(10) || 
						'isbCiclo ' 	|| isbCiclo, cnuNVLTRC);

		PKERRORS.PUSH('LDC_UILDC_FIFCAST.BeforeExe');
		PKERRORS.POP;

		-- Crea el nombre del proceso
		sbProgramName := sbExecutableName||Sqesprprog.NEXTVAL;
		pkg_traza.trace('Nombre del proceso: '||sbProgramName, cnuNVLTRC);

		-- Registra Log en Estaprog
		Pkstatusexeprogrammgr.Addrecord(sbProgramName, 'Inicia busqueda de Castigados...', 0);
		Pkgeneralservices.Committransaction;

		tbdetafactCast.delete;
		tbcu_DataCobro.delete;

		pkg_traza.trace('Armado del SQL dinamico', cnuNVLTRC);


		-- Si el criterio es por fechas

      SELECT 'WITH clientes AS
      (
         SELECT  pr.prpcsusc,Trunc(Max(prpcfeca))fecha_castigo
          FROM GC_PRODPRCA pr
         WHERE prpcsaca > 0
           AND EXISTS (SELECT 1
                         FROM open.servsusc  ss, suscripc su, open.ab_address ca
                        WHERE ss.sesuesfn= ''C''
                          AND ss.sesususc   = su.susccodi
                          AND su.susciddi   = ca.address_id
                          AND ss.sesususc   = pr.prpcsusc' ||
                        ' AND dage_geogra_location.fnugetgeo_loca_father_id(ca.geograp_location_id) = '||DECODE(inuDepartam,-1,'dage_geogra_location.fnugetgeo_loca_father_id(ca.geograp_location_id)',inuDepartam)||
                        ' AND ss.sesucicl = '|| Decode(inuPefaCicl,-1,' ss.sesucicl ',inuPefaCicl)||
                        ' AND ss.sesucicl not in (SELECT TO_NUMBER(COLUMN_VALUE)
                               FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(dald_parameter.fsbGetValue_Chain(''LDC_CICLOS_FICTICIOS''),'','')))
                          AND ca.geograp_location_id = '|| Decode(inuLocalida,-1,' ca.geograp_location_id ', inuLocalida)||
        ') AND prpcfeca  '|| Decode(idaPefafimo,NULL,' = prpcfeca ',' BETWEEN '||Chr(39)||idaPefafimo||Chr(39)||' AND '||Chr(39)||idaPefaffmo||Chr(39))||
        '  AND prpcserv = 7014
        GROUP BY pr.prpcsusc
      )
       SELECT ss.sesususc,ca.cargcaca, cl.fecha_castigo,Max(co.cucofact) id_factura
         FROM cargos ca, servsusc ss, cuencobr co, clientes cl
        WHERE ca.cargcaca = 2
          AND ss.sesususc = cl.prpcsusc
          AND co.cucocodi = ca.cargcuco
          AND Trunc(ca.cargfecr) = cl.fecha_castigo
          AND ca.cargnuse = ss.sesunuse
        GROUP BY ss.sesususc,ca.cargcaca,cl.fecha_castigo' INTO sbsql FROM dual;

		pkg_traza.trace('sbsql: ' || sbsql, cnuNVLTRC);

		pkg_traza.trace('Obtiene los registros a procesar', cnuNVLTRC);

		-- Obtiene la cantidad de clientes castigados para la fecha pasada como parametro
		OPEN cuClienCast FOR sbsql;
		LOOP
		FETCH cuClienCast  INTO tbClienteCast(idx);
			idx := idx + 1;
            EXIT WHEN cuClienCast%NOTFOUND;
		END LOOP;
		CLOSE cuClienCast;

		-- Total de contratos a procesar
		nuTotalRecords := tbClienteCast.Count();

		pkg_traza.trace('Inicia el armado de cargos para cobro', cnuNVLTRC);
      
		-- Arma los cargos
		IF(nuTotalRecords > 0)THEN

			-- Actualiza registro de seguimiento en ESTAPROG
			Pkstatusexeprogrammgr.Upstatusexeprogramat(sbProgramName, 'Inicia busqueda de cargos ...',nuTotalRecords, 0);
			Pkgeneralservices.Committransaction;

			-- registros a procesar
			nuRegistros :=  0;

			BEGIN

				FOR nuIndex IN tbClienteCast.FIRST..tbClienteCast.LAST LOOP

					-- crea el consecutivo de la cuenta
					nuFacturaCast := ldc_seq_facturacastig.nextval;

					-- se Obtiene los cargos castigados objetos del castigo
					FOR rc_cu_detallefact IN cu_detallefact(tbClienteCast(nuIndex).sesususc,
															tbClienteCast(nuIndex).cargcaca,
															tbClienteCast(nuIndex).fecha_castigo) LOOP

						nucontproce := rc_cu_detallefact.sesususc;
						nuRegistros := nuRegistros + 1;

						tbdetafactCast(nuRegistros).id_cons_fact  := nuFacturaCast;
						tbdetafactCast(nuRegistros).id_factura    := tbClienteCast(nuIndex).id_factura;
						tbdetafactCast(nuRegistros).id_Suscripc   := rc_cu_detallefact.sesususc;
						tbdetafactCast(nuRegistros).id_concepto   := rc_cu_detallefact.concepto;
						tbdetafactCast(nuRegistros).id_signo      := rc_cu_detallefact.signo_fact;
						tbdetafactCast(nuRegistros).vlr_castfact  := rc_cu_detallefact.valor_fact;
						tbdetafactCast(nuRegistros).fecha_castigo := tbClienteCast(nuIndex).fecha_castigo;

					END LOOP;

				END LOOP;

				-- realiza el borrado de los registros anteriores
				pkg_truncate_tablas_open.prcldc_cargosfact_castigo_tmp;

				FORALL indx IN 1 .. tbdetafactCast.COUNT
				INSERT INTO ldc_cargosfact_castigo_tmp
                VALUES tbdetafactCast(indx);
				
				COMMIT;
				
				pkg_traza.trace('Fin armado de cargos para cobro', cnuNVLTRC);

			EXCEPTION
				WHEN OTHERS THEN
				sberror := SQLERRM;
				pkg_traza.trace('ERROR al obtener los cargos para el cobro-'||sberror, cnuNVLTRC);
			END;
		END IF;

		-- Inicia el proceso a partir de los cargos a cobrar que fueron objeto de castigo
		-- en la tabla ldc_cargosfact_castigo_tmp

		IF isbDepto = 'Y' THEN
			sbOrderData :=   'pkg_bcdirecciones.fnuGetUbicaGeoPadre(ads.geograp_location_id)';
		END IF;

		IF isbLocalida = 'Y' THEN
			sbOrderData := sbOrderData||',ads.geograp_location_id';
		END IF;

		IF  isbContrato = 'Y' THEN
			sbOrderData := sbOrderData||',vlc.id_suscripc';
		END IF;

		IF  isbCiclo = 'Y' THEN
			sbOrderData := sbOrderData||',suc.SUSCCICL';
		END IF;

		IF  isbRuta = 'Y' THEN
			sbOrderData := sbOrderData||',seg.route_id';
		END IF;

		sbOrderData := REPLACE(TRIM(REPLACE(sbOrderData,',', ' ')),' ',',') ;

		-- Armado del SQL
		-- Consulta para generar las facturas segun el ordenamiento indicado
		sbsql := 'Select vlc.id_suscripc,' ||chr(13)||
				  'vlc.id_factura,'  ||chr(13)||
				  'vlc.id_cons_fact,'||chr(13)||
				  'pkg_bcdirecciones.fnuGetUbicaGeoPadre(ads.geograp_location_id),'||chr(13)||
				  'ads.geograp_location_id,'||chr(13)||
				  'suc.SUSCCICL,'||chr(13)||
				  'seg.route_id'||chr(13);

		sbfrom := ' FROM ldc_cargosfact_castigo_tmp vlc,
					 concepto con,
					 suscripc suc,
					 ab_address ads,
					 ab_segments seg
			   WHERE vlc.id_concepto = con.conccodi
				 AND suc.susccodi    = vlc.id_suscripc
				 AND ads.address_id  = suc.susciddi
				 AND seg.segments_id = ads.segment_id'||chr(13)||
				 ' GROUP BY vlc.id_suscripc,
							vlc.id_factura,
							vlc.id_cons_fact,
							pkg_bcdirecciones.fnuGetUbicaGeoPadre(ads.geograp_location_id),
							ads.geograp_location_id, suc.SUSCCICL,
							seg.route_id '||chr(13)||' ORDER BY ';

		IF sbOrderData IS NULL THEN
			sbOrderData := '3';
		END IF;

		sbsql := sbsql ||sbfrom || sbOrderData;

		pkg_traza.trace('sbsql: ' || sbsql, cnuNVLTRC);

		-- Actualiza registro de seguimiento en ESTAPROG
		Pkstatusexeprogrammgr.Upstatusexeprogramat(sbProgramName, 'Inicia Generacion Facturas...',nuTotalRecords, 0);
		Pkgeneralservices.Committransaction;


		nuTotalRecords := 0;
		-- Recorre los contratos para la generacion de facturas
		OPEN rfc_processfact FOR sbsql;

		-- Total de contratos a procesar
		nuTotalRecords := tbClienteCast.Count();
		idx            := 0;
		LOOP
			FETCH rfc_processfact  INTO tbcu_DataCobro(idx);
			EXIT WHEN rfc_processfact%NOTFOUND;
            nucontproce := tbcu_DataCobro(idx).id_suscripc;
            idx := idx + 1;
		END LOOP;
		CLOSE rfc_processfact;

		tbClienteCast.delete;

		IF nuTotalRecords > 0 THEN

			pkg_traza.trace('Registros a procesar nuTotalRecords['||nuTotalRecords||']', cnuNVLTRC);

			-- Actualiza registro de seguimiento en ESTAPROG
			Pkstatusexeprogrammgr.Upstatusexeprogramat(sbProgramName, 'Proceso en ejecucion...',nuTotalRecords, 0);
			Pkgeneralservices.Committransaction;

			--Iniciliza la cantidad de registros
			nuProcessedRecords := 1;

			--Inicializa las varibles necesarias para Imprimir el spool
			LDC_BOPRINTFOFACTCUSTMgr.Initialize;--Metodo inicializador de variables por defecto
			LDC_BOPRINTFOFACTCUSTMgr.SetSbPath(sbPath);--Se no se desea la ruta por defecto se fija nuestra tura
        
			--Se seta el nombre custom del archivo
			sbFileName   := 'FIPFCAST' || '_' || nuPefacodi  || '_' || To_Char( SYSDATE, 'DDMMYYYY_HH24MISS' );
			LDC_BOPRINTFOFACTCUSTMgr.SetSbFileName(sbFileName);--Se no se desea la ruta por defecto se fija nuestra tura
        
			--Se abre el archivo del proceso
			LDC_BOPRINTFOFACTCUSTMgr.FileOpen();
        
			--Se setea el codigo de formato a generar
			LDC_BOPRINTFOFACTCUSTMgr.SetNuIdFormato(nuIdFormato);

			--Caso 200-1685
			LDC_BOPRINTFOFACTCUSTMGR.sbDest := ldc_detafact_cast_gascaribe.fsbgetencabezado || ldc_detafact_cast_gascaribe.fsbgetencabconc1 || ldc_detafact_cast_gascaribe.fsbgetencabconc2 || ldc_detafact_cast_gascaribe.fsbgetencabconc3 || ldc_detafact_cast_gascaribe.fsbgetencabconc4 || chr(13);

			--Recorre los productos para obtener el armado de la factura
			FOR nuIndex IN tbcu_DataCobro.FIRST..tbcu_DataCobro.LAST LOOP
			
				pkg_traza.trace('Registros procesados: '||nuProcessedRecords, cnuNVLTRC);
				--Execucion de reglas de extraccion y adicion en el archivo
				pkg_traza.SetLevel;
				-- se controla posible error en LDC_BOPRINTFOFACTCUSTMgr y se guarda la factura con el error
				-- para que el proceso continue y se procesen todas las facturas
				begin
					LDC_BOPRINTFOFACTCUSTMgr.prcPrintFoByFactSinTermLinea(tbcu_DataCobro(nuIndex).id_factura);
			
					Pkstatusexeprogrammgr.Upstatusexeprogramat(sbProgramName, 'Proceso en ejecucion...',nuTotalRecords, nuProcessedRecords);
					Pkgeneralservices.Committransaction;
			
				exception when others then
					if nvl(length(trim(sbFactError)),0) < 980 then -- se controla la longitud porque el campo de observacion de estaprog tiene 1000 caracteres
						sbFactError := sbFactError || tbcu_DataCobro(nuIndex).id_factura || ', ';
					end if;
					nuProcessedRecords := nuProcessedRecords -1;
				end;

				nuProcessedRecords := nuProcessedRecords +1;
			END LOOP;

			tbcu_DataCobro.delete;

			--Se cierra el archivo global
			LDC_BOPRINTFOFACTCUSTMgr.FileClose();
		END IF;

		pkg_traza.SetLevel(99);

		pkg_traza.trace('Registros procesados: '||nuProcessedRecords, cnuNVLTRC);
		pkg_traza.trace('Registros a procesar: '||nuTotalRecords, cnuNVLTRC);

		Pkstatusexeprogrammgr.Upstatusexeprogramat(sbProgramName, 'Proceso en ejecucion...', nuTotalRecords, nuProcessedRecords);
		Pkgeneralservices.Committransaction;

		-- Finaliza proceso en estaprog
		if trim(sbFactError) is null then
			sbMensFinProc := 'Proceso Finalizado Ok';
		else
			sbMensFinProc := 'Proceso Finalizado. Error en Facturas: ' || substr(sbFactError,950); -- se controla la longitud porque el campo de observacion de estaprog tiene 1000 caracteres
		end if;

		Pkstatusexeprogrammgr.Processfinishnok(sbProgramName, sbMensFinProc);

		pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);
		
	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR then
			Pkstatusexeprogrammgr.Upstatusexeprogramat(sbProgramName, 'Error (Contrato ' || nucontproce || '): ' ||
                 DBMS_UTILITY.FORMAT_ERROR_STACK ||
                                           ' - ' ||
                                           DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,nuTotalRecords, nuProcessedRecords);
			Pkgeneralservices.Committransaction;
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			Pkstatusexeprogrammgr.Upstatusexeprogramat(sbProgramName, 'Error (Contrato ' || nucontproce || '): ' ||
                 DBMS_UTILITY.FORMAT_ERROR_STACK ||
                                           ' - ' ||
                                           DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,nuTotalRecords, nuProcessedRecords);
			Pkgeneralservices.Committransaction;
			pkg_error.setError;
			pkg_error.getError(nuError, sberror);
			pkg_traza.trace(csbMetodo||' '||sbError);
			pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE pkg_error.CONTROLLED_ERROR;
		END Process;

    /*****************************************************************
    Propiedad intelectual de CSCo. (C).

    Procedure	: BeforeExe
    Descripci?n	:

    Par?metros	:	Descripci?n

    Retorno     :

    Autor	: Manuel Mejia
    Fecha	: 01-12-2017

    Historia de Modificaciones
    Fecha       Autor
    ----------  --------------------
    01-12-2017  Mmejia  Creaci?n.
    *****************************************************************/
    PROCEDURE BeforeExe
    IS
      cnuNULL_ATTRIBUTE constant number := 2126;

      sbPEFACICL ge_boInstanceControl.stysbValue;
      sbPEFAFIMO ge_boInstanceControl.stysbValue;
      sbPEFAFFMO ge_boInstanceControl.stysbValue;
    BEGIN
      PKERRORS.PUSH('LDC_UILDC_FIFCAST.BeforeExe');
      PKERRORS.POP;

/*      sbPEFACICL := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFACICL');
      sbPEFAFIMO := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAFIMO');
      sbPEFAFFMO := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAFFMO');

      ------------------------------------------------
      -- Required Attributes
      ------------------------------------------------

      if (sbPEFACICL is null) then
          Errors.SetError (cnuNULL_ATTRIBUTE, 'Ciclo de Facturaci?n');
          raise ex.CONTROLLED_ERROR;
      end if;

      if (sbPEFAFIMO is null) then
          Errors.SetError (cnuNULL_ATTRIBUTE, 'Fecha Inicial Movimientos');
          raise ex.CONTROLLED_ERROR;
      end if;

      if (sbPEFAFFMO is null) then
          Errors.SetError (cnuNULL_ATTRIBUTE, 'Fecha Final Movimientos');
          raise ex.CONTROLLED_ERROR;
      end if;

*/    NULL;
      EXCEPTION
      WHEN Login_Denied OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE;
      WHEN EX.CONTROLLED_ERROR THEN
        PKERRORS.POP;
        RAISE;
      WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, GSBERRMSG);
        PKERRORS.POP;
        Raise_Application_Error(PKCONSTANTE.NUERROR_LEVEL2, GSBERRMSG);
    END BeforeExe;

END LDC_UILDC_FIFCAST;
/

Prompt Otorgando permisos sobre ADM_PERSON.LDC_UILDC_FIFCAST
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('LDC_UILDC_FIFCAST'), 'ADM_PERSON');
END;
/

GRANT EXECUTE on ADM_PERSON.LDC_UILDC_FIFCAST to REPORTES;
/

