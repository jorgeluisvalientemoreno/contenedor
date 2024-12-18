CREATE OR REPLACE PACKAGE adm_person.LDC_BOPRINTFOFACTCUSTMGR
IS
/**********************************************************************************
  Propiedad intelectual de CSC.

  Package	    : LDC_BOPRINTFOFACTCUSTMgr
  Descripci?n	: Paquete con la logica de generacino de un Formatoi FCED como spool

  Autor	    : Manuel Mejia
  Fecha	    : 08-11-2017

  Historia de Modificaciones
  DD-MM-YYYY    <Autor>               Modificaci?n
  -----------  -------------------    -------------------------------------
  08-11-2017    Mmejia               	Creaci?n.
  06/03/2024    jsoto				 	OSF-2381  Ajustes:
										Se reemplaza uso de  UTL_FILE.PUT por  pkg_gestionarchivos.prcescribirlineasinterm_smf
										Se reemplaza uso de  UT_TRACE.TRACE por  Pkg_traza.trace
										Se reemplaza uso de  GE_BOFILEMANAGER.CSBWRITE_OPEN_FILE por  pkg_gestionarchivos.csbmodo_escritura
										Se reemplaza uso de  GE_BOFILEMANAGER.FILECLOSE por  pkg_gestionarchivos.prccerrararchivo_smf
										Se reemplaza uso de  GE_BOFILEMANAGER.FILEOPEN por  pkg_gestionarchivos.ftabrirarchivo_smf
										Se reemplaza uso de  GE_BOFILEMANAGER.FILEWRITE por  pkg_gestionarchivos.prcescribirlinea_smf
										Se reemplaza uso de  ERRORS.SETERROR por  PKG_ERROR.SETERROR
										Se reemplaza uso de  EX.CONTROLLED_ERROR por  PKG_ERROR.CONTROLLED_ERROR
										Se reemplaza uso de  UTL_FILE.FILE_TYPE por  PKG_GESTIONARCHIVOS.STYARCHIVO
										Se ajusta el manejo de errores y trazas por los personalizados
  25/06/2024    PAcosta                 OSF-2878: Cambio de esquema ADM_PERSON                                        
**********************************************************************************/
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    /*Unidad : Retorna la version */
    FUNCTION fsbVersion
    RETURN VARCHAR2;

    /*Unidad : Setea el valor de la ruta */
    PROCEDURE SetSbPath(iSbPath IN VARCHAR2);

    /*Unidad : Setea el valor de nombre archivo */
    PROCEDURE SetSbFileName(iSbFileName IN VARCHAR2);

    /*Unidad : Setea el valor de Codigo formato Impresion*/
    PROCEDURE SetNuIdFormato(inuIdFormato IN ed_formato.formcodi%TYPE);

    /*Unidad : Inicializacion de variables por defecto*/
    PROCEDURE Initialize;

    /*Unidad : Apertura del archivo de proceso de spool*/
    PROCEDURE FileOpen;

    /*Unidad : Escritutra del Clob temporal en el archivo*/
    PROCEDURE FileWrite;

    /*Unidad : Limpiar Clob temporal*/
    PROCEDURE ClobClear;

    /*Unidad : Cierre del archivo de proceso de spool*/
    PROCEDURE FileClose;

    /*Unidad : Prcoceso que ejecuta la regla de exgtraccion del formato y
                guarda en el archivo spool de salida
    */
    PROCEDURE PrintFoByFact(inuFactcodi factura.factcodi%TYPE);
    
    /*****************************************************************
    SINCECOMP

    Unidad         : ClobWriteT
    Descripcion    : Permite agregar el encabezado al archivo - Caso 200-1685
    Fecha          : 16-08-2018
    Autor:         : Daniel Valiente

    Parametros              Descripcion
    ============         ===================
    clData               Texto con los Encabezados

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE ClobWriteT(clData CLOB);

END LDC_BOPRINTFOFACTCUSTMgr;
/
CREATE OR REPLACE PACKAGE BODY adm_person.ldc_boprintfofactcustmgr
IS
/**********************************************************************************
  Propiedad intelectual de CSC.

  Package	    : LDC_BOPRINTFOFACTCUSTMgr
  Descripci?n	: Paquete con la logica de generacino de un Formatoi FCED como spool

  Autor	    : Manuel Mejia
  Fecha	    : 08-11-2017

  Historia de Modificaciones
  DD-MM-YYYY    <Autor>               Modificaci?n
  -----------  -------------------    -------------------------------------
  08-11-2017    Mmejia               Creaci?n.
**********************************************************************************/
  -----------------------------------
  -- Variables privadas del package
  -----------------------------------
  CSBVERSION          CONSTANT VARCHAR2(10) := 'OSF-2381';
  cnuOrdEstaRegi      CONSTANT NUMBER := 0;
  cnuOrdEstaAsig      CONSTANT NUMBER := 5;
  cnuCommentTypeGen   CONSTANT NUMBER := 83;
  cnuMaxLength        CONSTANT NUMBER := 32000;

  /* Mensaje */
  gnuErrorCode    	GE_MESSAGE.message_id%TYPE;
  gsbMessage      	GE_ERROR_LOG.description%TYPE;
  sbPath          	VARCHAR2(900) ;--- := '/smartfiles/tmp';
  csbDEFAULT_PATH	CONSTANT VARCHAR2(4) := '/tmp';
  sbFileName      	VARCHAR2(500);
  gSbErrMsg       	GE_ERROR_LOG.DESCRIPTION%TYPE;
  vPrintFactFile  	PKG_GESTIONARCHIVOS.STYARCHIVO;
  sbLineFeed      	VARCHAR2(10) := Chr(10);
  iboFilOpen      	BOOLEAN;
  nuPefacodi      	perifact.pefacodi%TYPE;
  nuIdFormato     	ed_formato.formcodi%TYPE;
  clobDest        	CLOB;
  
  csbNOMPKG   CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.'; -- Constantes para el control de la traza

  /*****************************************************************
  Propiedad intelectual de CSC.

  Procedure	: fsbVersion
  Descripci?n	:

  Par?metros	:	Descripci?n

  Retorno     :

  Autor	: Manuel Mejia
  Fecha	: 08-11-2017

  Historia de Modificaciones
  Fecha       Autor
  ----------  --------------------
  08-11-2017  Mmejia  Creaci?n.
  *****************************************************************/

  FUNCTION fsbVersion
  /*****************************************************************
  Propiedad intelectual de CSC (c).

  Unidad         : fsbVersion
  Descripcion    : Retrona la version
  Autor          :
  Fecha          : 08-11-2017

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  RETURN VARCHAR2
  IS

  nuError NUMBER;
  sbError VARCHAR2(4000);
  csbMetodo VARCHAR2(100) := csbNOMPKG||'FSBVERSION';
  

  BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    RETURN (CSBVERSION);

  EXCEPTION
    WHEN pkg_error.controlled_error THEN
		pkg_error.getError(nuError, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		RAISE;
    WHEN OTHERS THEN
		pkg_error.setError;
		pkg_error.getError(nuError, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		RAISE pkg_error.controlled_error;
  END fsbVersion;

  PROCEDURE SetSbPath(iSbPath IN VARCHAR2)
  /*****************************************************************
  Propiedad intelectual de CSC (c).

  Unidad         : fnuSetSbPath
  Descripcion    : Setea el PAth del archivo
  Autor          :
  Fecha          : 08-11-2017

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  IS
  
  nuError NUMBER;
  sbError VARCHAR2(4000);
  csbMetodo VARCHAR2(100) := csbNOMPKG||'SETSBPATH';
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
    sbPath := iSbPath;--'/smartfiles/tmp';
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    
    EXCEPTION
	WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_error.getError(nuError, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		RAISE;
    WHEN OTHERS THEN
		pkg_error.setError;
		pkg_error.getError(nuError, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		RAISE pkg_error.controlled_error;
  END SetSbPath;

  PROCEDURE SetSbFileName(iSbFileName IN VARCHAR2)
  /*****************************************************************
  Propiedad intelectual de CSC (c).

  Unidad         : fnuSetSbFileName
  Descripcion    : Setea el nombre del archivo
  Autor          :
  Fecha          : 08-11-2017

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  IS
  
  csbMetodo VARCHAR2(100) := csbNOMPKG||'SETSBFILENAME';
  nuError NUMBER;
  sbError VARCHAR2(4000);
  
  BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
    sbFileName := iSbFileName;
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.controlled_error THEN
	pkg_error.getError(nuError, sbError);
	pkg_traza.trace(csbMetodo||' '||sbError);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    RAISE;
    WHEN OTHERS THEN
	pkg_error.setError;
	pkg_error.getError(nuError, sbError);
	pkg_traza.trace(csbMetodo||' '||sbError);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
	RAISE pkg_error.controlled_error;
  END SetSbFileName;

  PROCEDURE SetNuIdFormato(inuIdFormato IN ed_formato.formcodi%TYPE)
  /*****************************************************************
  Propiedad intelectual de CSC (c).

  Unidad         : fnuSetNuIdFormato
  Descripcion    : Setea el codigo del formato
  Autor          :
  Fecha          : 08-11-2017

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  IS

	csbMetodo VARCHAR2(100) := csbNOMPKG||'SETNUIDFORMATO';
    nuError NUMBER;
    sbError VARCHAR2(4000);

  BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);    
	
	nuIdFormato := inuIdFormato;

    pkg_traza.trace(csbMetodo||' nuIdFormato['||nuIdFormato||']');

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_error.controlled_error THEN
	pkg_error.getError(nuError, sbError);
	pkg_traza.trace(csbMetodo||' '||sbError);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
     RAISE;
    WHEN OTHERS THEN
	pkg_error.setError;
	pkg_error.getError(nuError, sbError);
	pkg_traza.trace(csbMetodo||' '||sbError);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
	RAISE pkg_error.controlled_error;
  END SetNuIdFormato;

  PROCEDURE Initialize
  /*****************************************************************
  Propiedad intelectual de CSC (c).

  Unidad         : Initialize
  Descripcion    : Inicializa las variobles del proceso
  Autor          :
  Fecha          : 08-11-2017

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  IS
  
  csbMetodo VARCHAR2(100) := csbNOMPKG||'INITIALIZE';
  nuError NUMBER;
  sbError VARCHAR2(4000);
  
  BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);    
    sbPath      := csbDEFAULT_PATH;
    pkg_traza.trace(csbMetodo||' sbPath['||sbPath||']');
    --Se seta el periodo por defecto -1
    nuPefacodi := -1;
    --Se seta por defecto el nombre del archivo de salida
    sbFileName  := 'FIPFCAST' || '_' || nuPefacodi  || '_' || To_Char( SYSDATE, 'DDMMYYYY_HH24MISS' );
    clobDest := EMPTY_CLOB();
    dbms_lob.createtemporary(clobDest, true);
    pkg_traza.trace(csbMetodo||' sbFileName['||sbFileName||']');
    iboFilOpen  := FALSE;
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  END Initialize;

  PROCEDURE FileOpen
  /*****************************************************************
  Propiedad intelectual de CSC (c).

  Unidad         : FileOpen
  Descripcion    : Proceso que Abre el archivo
  Autor          :
  Fecha          : 08-11-2017

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  IS

	csbMetodo VARCHAR2(100) := csbNOMPKG||'FILEOPEN';
	nuError NUMBER;
	sbError VARCHAR2(4000);

  BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
    pkg_traza.trace(csbMetodo||'  sbPath['||sbPath||']');
    pkg_traza.trace(csbMetodo||'  sbFileName['||sbFileName||']');
    --Generacion del archivo de salida
	vPrintFactFile := pkg_gestionarchivos.ftabrirarchivo_smf(sbPath,sbFileName,pkg_gestionarchivos.csbmodo_escritura);
    --Se modifica la varibal de identifica la apertura de archivo
    iboFilOpen := TRUE;
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
  END FileOpen;

  PROCEDURE ClobWrite(clData CLOB)
  /*****************************************************************
  Propiedad intelectual de CSC (c).

  Unidad         : FileWrite
  Descripcion    : Proceso que concatena en el CLOB principal los datos de la extraccion
  Autor          :
  Fecha          : 08-11-2017

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  IS

	csbMetodo VARCHAR2(100) := csbNOMPKG||'CLOBWRITE';
	nuError NUMBER;
	sbError VARCHAR2(4000);

  BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
    Dbms_Lob.append(clobDest,clData);
    
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
	
  EXCEPTION
    WHEN pkg_error.controlled_error THEN
		pkg_error.getError(nuError, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		RAISE pkg_error.controlled_error;
    WHEN OTHERS THEN
		pkg_error.setError;
		pkg_error.getError(nuError, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		RAISE pkg_error.controlled_error;
  END ClobWrite;

  PROCEDURE ClobClear
  /*****************************************************************
  Propiedad intelectual de CSC (c).

  Unidad         : Initialize
  Descripcion    : Inicializa las variobles del proceso
  Autor          :
  Fecha          : 08-11-2017

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  IS
  
  csbMetodo VARCHAR2(100) := csbNOMPKG||'CLOBCLEAR';
  nuError NUMBER;
  sbError VARCHAR2(4000);
  
  BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
    Dbms_Lob.createTemporary(clobDest,true);
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  END ClobClear;


  PROCEDURE FileWrite
  /*****************************************************************
  Propiedad intelectual de CSC (c).

  Unidad         : FileWrite
  Descripcion    : Proceso que escribe el CLOB en el archivo
  Autor          :
  Fecha          : 08-11-2017

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  IS
    -------------------------------------------
    --Types y Subtypes
    -------------------------------------------
    SUBTYPE     styMaxVarchar2 IS VARCHAR2(32000);
    sbData      styMaxVarchar2;
    nuPosicion  NUMBER := 1;
	csbMetodo VARCHAR2(100) := csbNOMPKG||'FILEWRITE';
	nuError NUMBER;
    sbError VARCHAR2(4000);
  BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    --Valida si el archivo esta abierto
    IF(NOT iboFilOpen)THEN
      pkg_traza.trace('LDC_BOPRINTFOFACTCUSTMgr.FileWrite Archivo spool cerrado');
      pkg_error.SetErrorMessage(16404,sbFileName);
      RAISE pkg_error.CONTROLLED_ERROR;
    END IF;

    --LLena el archivo con los datos de CLOB
    LOOP
      sbData := Dbms_Lob.SubStr(clobDest, cnuMaxLength, nuPosicion );
      EXIT WHEN sbData IS NULL;
      nuPosicion := nuPosicion + Length(sbData);
      --Escribe en disco
	  pkg_gestionarchivos.prcescribirlinea_smf(vPrintFactFile,sbData,constants_per.GetTrue);
      sbData := NULL;
    END LOOP;
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
  END FileWrite;

  PROCEDURE FileClose
  /*****************************************************************
  Propiedad intelectual de CSC (c).

  Unidad         : FileClose
  Descripcion    : Proceso que cierra el archivo
  Autor          :
  Fecha          : 08-11-2017

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  IS
  
  csbMetodo VARCHAR2(100) := csbNOMPKG||'FILECLOSE';
  nuError NUMBER;
  sbError VARCHAR2(4000);
  
  BEGIN
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    --Valida si el archivo esta abierto
    IF(NOT iboFilOpen)THEN
      RAISE pkg_error.CONTROLLED_ERROR;
    END IF;

    --Cierra el archivo
	PKG_GESTIONARCHIVOS.PRCCERRARARCHIVO_SMF(vPrintFactFile,sbPath,sbFileName);
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
  END FileClose;

  PROCEDURE PrintFoByFact(inuFactcodi factura.factcodi%TYPE)
  IS
  /*****************************************************************
  Propiedad intelectual de CSC.

  Unidad         : PrintFoByFact
  Descripcion    : Funcion que Valida si el tiempo maximo de revision validando si esta
                   dentro de los n dias validos segun el parametro. Funcion interna
  Autor          : Manuel Mejia
  Fecha          : 08-11-2017

  Parametros              Descripcion
  ============         ===================
  nuExternalId:

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
    -------------------------------------------
    --Types y Subtypes
    -------------------------------------------
    rcfactura FACTURA%ROWTYPE;
    -------------------------------------------
    --Variables
    -------------------------------------------
    clData          CLOB;
	csbMetodo VARCHAR2(100) := csbNOMPKG||'PRINTFOBYFACT';
	nuError NUMBER;
    sbError VARCHAR2(4000);
	
	
  BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);    
	pkg_traza.trace(csbMetodo||' inuFactcodi['||inuFactcodi||']');

    rcfactura  := PKTBLFACTURA.frcGetRecord(inuFactcodi,1);

    --Realiza al extraccion de los datos y retorna en CLOB
    PKBODATAEXTRACTOR.InstanceBaseEntity(rcfactura.factcodi, 'FACTURA', TRUE);  
    PKBODATAEXTRACTOR.InstanceBaseEntity(rcfactura.factsusc, 'SUSCRIPC', TRUE); 
    --Setea losv alores en la isntancia
    ge_boinstanceControl.AddAttribute('DATA_EXTRACTOR',NULL,'FACTURA','FACTCODI',rcfactura.factcodi,TRUE);
    ge_boinstanceControl.AddAttribute('DATA_EXTRACTOR',NULL,'FACTURA','FACTSUSC',rcfactura.factsusc,TRUE);

    pkg_traza.trace(csbMetodo||' Inica la extraccion de los datos');

    PKBODATAEXTRACTOR.ExecuteRules(LDC_BOPRINTFOFACTCUSTMgr.nuIdFormato, clData);  -- (C?DIGO DEL FORMATO) EXTRAE EL XML DEL FORMATO ed_formato     44 103

    pkg_traza.trace(csbMetodo||' Finaliza la extraccion de los datos');

    pkg_traza.trace('LDC_BOPRINTFOFACTCUSTMgr.PrintFoByFact Valida el tama?o del CLOB');
    --Valida si el CLOB tiene datos

    IF UT_LOB.BLLOBCLOB_ISNULL( clData ) THEN
       RAISE pkg_error.controlled_error;
    END IF;
    pkg_traza.trace(csbMetodo||' Generacion del archivo');
    --Se hace el llamado a al funcion que concatena los datos en el clob temporal
    LDC_BOPRINTFOFACTCUSTMgr.ClobWrite(clData);
    pkg_traza.trace('Fin LDC_BOPRINTFOFACTCUSTMgr.PrintFoByFact', 10);
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
  END PrintFoByFact;
  
  /*****************************************************************
  SINCECOMP

  Unidad         : ClobWriteT
  Descripcion    : Permite agregar el encabezado al archivo - Caso 200-1685
  Fecha          : 16-08-2018
  Autor:         : Daniel Valiente

  Parametros              Descripcion
  ============         ===================
  clData               Texto con los Encabezados

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  PROCEDURE ClobWriteT(clData CLOB)
  IS

	csbMetodo VARCHAR2(100) := csbNOMPKG||'CLOBWRITET';

	nuError NUMBER;
    sbError VARCHAR2(4000);

  BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
    Dbms_Lob.append(clobDest,clData);
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
  END ClobWriteT;

END LDC_BOPRINTFOFACTCUSTMGR;
/
PROMPT Otorgando permisos de ejecucion a LDC_BOPRINTFOFACTCUSTMGR
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BOPRINTFOFACTCUSTMGR', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_BOPRINTFOFACTCUSTMGR para reportes
GRANT EXECUTE ON adm_person.LDC_BOPRINTFOFACTCUSTMGR TO rexereportes;
/
