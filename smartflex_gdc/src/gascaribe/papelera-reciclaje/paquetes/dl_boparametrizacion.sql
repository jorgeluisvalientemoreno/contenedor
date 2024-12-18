CREATE OR REPLACE PACKAGE        "DL_BOPARAMETRIZACION"
AS
  /*************************************************
  Propiedad intelectual de Open Systems (c).
  Unidad  : DL_BOPARAMETRIZACION
  Descripcion : Busines Service para manjear utilidades de carga de datos
  Autor  : Leonardo Garcia Q.
  Fecha  : 06-11-2009
  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ===========     =================== ====================
  *************************************************/
  -- Constantes
  -- Tipos
TYPE tytbnombre
IS
  TABLE OF VARCHAR2 (30) INDEX BY BINARY_INTEGER;
TYPE tytbNumero
IS
  TABLE OF NUMBER INDEX BY BINARY_INTEGER;
TYPE tytbEntity_id
IS
  TABLE OF ge_entity.entity_id%TYPE INDEX BY BINARY_INTEGER;
TYPE tytbCondicion
IS
  TABLE OF VARCHAR2 (32700) INDEX BY BINARY_INTEGER;
TYPE tytbModo
IS
  TABLE OF VARCHAR2 (1) INDEX BY BINARY_INTEGER;
TYPE tytbFields
IS
  TABLE OF VARCHAR2 (50) INDEX BY BINARY_INTEGER;
TYPE tytbResSent
IS
  TABLE OF VARCHAR2 (32700) INDEX BY BINARY_INTEGER;
TYPE tytbVarFields
IS
  TABLE OF VARCHAR2 (50) INDEX BY VARCHAR2 (50);

sbSchemaCSE VARCHAR2(10):= 'CSE';

TYPE tyrcBloqueTablas
IS
  RECORD
  (
    sbNombre    VARCHAR2 (30),
    sbCondicion VARCHAR2 (200) );
TYPE tytbrcBloqueTablas
IS
  RECORD
  (
    tbNombre tytbNombre,
    tbCondicion tytbCondicion,
    tbModo tytbModo );
TYPE tyrcFields
IS
  RECORD
  (
    tbField_name tytbFields,
    tbdata_type tytbFields,
    Value_ tytbResSent );
TYPE tyrcResSent
IS
  RECORD
  (
    tbNombreTabla tytbNombre,
    tbSentenciasaEjec tytbResSent,
    tbCampos tytbResSent,
    tbDatos tytbResSent,
    tbModo tytbModo );
TYPE tyrcFiles
IS
  RECORD
  (
    tbNombarchiv tytbFields,
    tbNumLinea tytbNumero );
  -- Tipos
TYPE tytbcolumn_name
IS
  TABLE OF VARCHAR2 (30) INDEX BY BINARY_INTEGER;
TYPE tytbData_type
IS
  TABLE OF VARCHAR2 (106) INDEX BY BINARY_INTEGER;
TYPE tytbData_length
IS
  TABLE OF NUMBER INDEX BY BINARY_INTEGER;
TYPE tytbData_precision
IS
  TABLE OF NUMBER INDEX BY BINARY_INTEGER;
TYPE tytb_Data_scale
IS
  TABLE OF NUMBER INDEX BY BINARY_INTEGER;
TYPE tytb_Data_Asig
IS
  TABLE OF VARCHAR2 (4000) INDEX BY BINARY_INTEGER;
TYPE tyrctbTablas
IS
  RECORD
  (
    tbcolumn_name tytbcolumn_name,
    tbdata_type tytbData_type,
    tbdata_length tytbData_length,
    tbdata_precision tytbData_precision,
    tbdata_scale tytb_Data_scale,
    tbData_Asig tytb_Data_Asig );
TYPE tyrcTablas
IS
  RECORD
  (
    column_name    VARCHAR2 (30),
    data_type      VARCHAR2 (106),
    data_length    NUMBER,
    data_precision NUMBER,
    data_scale     NUMBER,
    data           VARCHAR2 (3000) );
  --------------------------------------------
  -- Funciones y Procedimientos
  --------------------------------------------
  -- Declaracion de metodos publicos
  FUNCTION fsbVersion
    RETURN VARCHAR2;
  FUNCTION fsbGetInsertMode
    RETURN VARCHAR2;
  FUNCTION fsbGetUpdateMode
    RETURN VARCHAR2;
  FUNCTION fsbGetBothMode
    RETURN VARCHAR2;
  /******************************************************************
  Propiedad intelectual de Open Systems (c).
  Unidad  : ExtraerTablas
  Descripcion : Extrae los datos de las tablas de la base de datos que se le
  especifiquen en un archivo o en una tabla en memoria
  Parámetros   Descripción
  ============    ===================
  isbPath         in  Directorio donde esta el archivo con la lista de tablas,
  isbNombArchivo  in  Nombre del archivo con la lista de tablas a extraer,
  irctbTablas     in  Tabla de memoria con los nombres de las tablas a extraer
  Autor  : Leonardo Garcia Q.
  Fecha  : 11/04/2009
  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ===========     =================== ====================
  *********************************************************************/
  PROCEDURE ExtraerTablas(
      isbPath               IN VARCHAR2,
      isbNombArchivo        IN VARCHAR2,
      isbDB_LINK            IN VARCHAR2,
      isbErrorSequence      IN VARCHAR2 DEFAULT NULL,
      iblGetDataFromOtherDB IN BOOLEAN DEFAULT FALSE);
  PROCEDURE Processfile(
      isbNombreTabla VARCHAR2,
      isbCondicion   VARCHAR2,
      isbPath        VARCHAR2,
      isbModo        VARCHAR2,
      orctbSentencias OUT tyrcResSent);
  /******************************************************************
  Propiedad intelectual de Open Systems (c).
  Unidad  : CopiarTablasdeOtraBD
  Descripcion : Copia los datos de tablas segun un archivo en otra base de
  datos.
  Parámetros   Descripción
  ============    ===================
  isbPath                 in  Directorio donde esta el archivo con la lista de
  tablas,
  isbNombArchivo          in  Nombre del archivo con la lista de tablas a
  extraer,
  isbUsuarioBDOrigen      in  Usuario de la base de datos de la cual se van a
  extraer los datos
  isbPwdBDOrigen          in  Pwd de la base de datos de la cual se van a
  extraer los datos
  isbInstanciaBDOrigen    in  Instancia de la base de datos de la cual se van a
  extraer los datos
  Autor  : Leonardo Garcia Q.
  Fecha  : 11/04/2009
  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ===========     =================== ====================
  *********************************************************************/
  PROCEDURE CopiarDatosTablas(
      isbPath              IN VARCHAR2,
      isbNombArchivo       IN VARCHAR2,
      isbDBLINK            IN VARCHAR2,
      isbInstanciaBDOrigen IN VARCHAR2 DEFAULT NULL,
      isbUsuarioBDOrigen   IN VARCHAR2 DEFAULT NULL,
      isbPwdBDOrigen       IN VARCHAR2 DEFAULT NULL,
      isbOnlyVal           IN BOOLEAN DEFAULT FALSE);
  PROCEDURE CargadorTablasPorArchivo(
      isbProcessTrack    IN VARCHAR2,
      isbFileName        IN VARCHAR2,
      isbFilePath        IN VARCHAR2,
      isbOnlyVal         IN VARCHAR2,
      isbAlteraSecuencia IN VARCHAR2,
      inuNumeroHilo      IN NUMBER,
      inuNumeroHilos     IN NUMBER,
      isbModo            IN VARCHAR2 DEFAULT fsbGetInsertMode);
  PROCEDURE setSentEjecDest(
      irctbSentaEjecDest DL_BOPARAMETRIZACION.tyrcResSent);
  PROCEDURE AddError(
      isbLine_Number IN VARCHAR2,                     -- Número de línea.
      isbResSentence IN VARCHAR2,                     -- Linea del archivo
      isbError       IN ge_error_log.description%TYPE -- Descripción del error.
    );
  PROCEDURE insertError(
      isbTableName     VARCHAR2,
      isbRowId         VARCHAR2,
      isbErrorSequence VARCHAR2);
  PROCEDURE CrearArchivoEje(
      isbPath        IN VARCHAR2,
      isbNombarchivo IN VARCHAR2);
  PROCEDURE setRowid(
      isbRowid ROWID);
  PROCEDURE setExecutionMode(
      isbModo VARCHAR2);
  FUNCTION fsbGetExecutionMode
    RETURN VARCHAR2;
  FUNCTION ftbGetTableData
    RETURN tytbCondicion;
  FUNCTION fsgbCREARCADENALINEASRECTAS(
      isbCoor VARCHAR2)
    RETURN MDSYS.SDO_GEOMETRY;
  PROCEDURE CreateDirectory(
      isbPath    IN VARCHAR2,
      isbDirName IN VARCHAR2);
  /****************************************************************************
  ***
  Propiedad intelectual de Open International Systems (c).
  Procedure   :   CreateDirectoryHSPPP
  Descripción :   Crea directorio para el log de errores
  Autor       :   Paula Garcia
  Fecha       :   11-07-2013 11:15:26
  Historia de Modificaciones
  Fecha       IDEntrega
  Creación.
  *****************************************************************************
  **/
  PROCEDURE CreateDirectoryHSPPP(
      isbPath    IN VARCHAR2,
      isbDirName IN VARCHAR2);
  /******************************************************************
  Propiedad intelectual de Open Systems (c).
  Unidad  : ProcessHSPTP
  Descripcion :
  Parámetros   Descripción
  ============    ===================
  Autor  : Karina J. Cerón V.
  Fecha  : 06/05/2013
  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ===========     =================== ====================
  *********************************************************************/
  PROCEDURE ProcessHSPTP;
  /******************************************************************
  Propiedad intelectual de Open Systems (c).
  Unidad  : frcGetAmbientes
  Descripcion : Obtiene los resultados de la grilla del ejecutable HSPPP
  donde se obtienen todos los ambientes donde se aplicará la transformación
  Parámetros   Descripción
  ============    ===================
  Autor  : Paula Garcia
  Fecha  : 09/07/2013
  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ===========     =================== ====================
  *********************************************************************/
  FUNCTION frcGetAmbientes
    RETURN constants.tyRefCursor;
  /******************************************************************
  Propiedad intelectual de Open Systems (c).
  Unidad  : ProcessHSTSS
  Descripcion : Obtiene los resultados de la grilla del ejecutable HSPPP
  donde se obtienen todos los ambientes donde se aplicará la transformación
  y aplica el proceso principal
  Parámetros   Descripción
  ============    ===================
  Autor  : Paula Garcia
  Fecha  : 09/07/2013
  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ===========     =================== ====================
  *********************************************************************/
  PROCEDURE ProcessHSPPP;
  /******************************************************************
  Propiedad intelectual de Open Systems (c).
  Unidad  : setDB_LINK
  Descripcion : Setea el nombre del DB_LINK en memoria
  Parámetros   Descripción
  ============    ===================
  Autor  : Paula Garcia
  Fecha  : 09/07/2013
  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ===========     =================== ====================
  *********************************************************************/
  PROCEDURE setDB_LINK(
      isbDB_LINK VARCHAR2);
  /******************************************************************
  Propiedad intelectual de Open Systems (c).
  Unidad  : setDB_LINK
  Descripcion : Setea el nombre del DB en memoria
  Parámetros   Descripción
  ============    ===================
  Autor  : Saúl Trujillo
  Fecha  : 31/08/2014
  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ===========     =================== ====================
  *********************************************************************/
  PROCEDURE setDB(
      isbDB VARCHAR2);
  /******************************************************************
  Propiedad intelectual de Open Systems (c).
  Unidad  : fsbgetDB_LINK
  Descripcion : O   btiene el nombre del DB_LINK que está en memoria
  Parámetros   Descripción
  ============    ===================
  Autor  : Paula Garcia
  Fecha  : 09/07/2013
  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ===========     =================== ====================
  *********************************************************************/
  FUNCTION fsbgetDB_LINK
    RETURN VARCHAR2;
  /******************************************************************
  Propiedad intelectual de Open Systems (c).
  Unidad  : fsbgetDB
  Descripcion : Obtiene el nombre de la DB que está en memoria
  Parámetros   Descripción
  ============    ===================
  Autor  : Paula Garcia
  Fecha  : 09/07/2013
  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ===========     =================== ====================
  *********************************************************************/
  FUNCTION fsbgetDB
    RETURN VARCHAR2;
  /***************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Procedure   :   GetPrimaryAndValues
  Descripción :   Con las llaves primarias y los VALUES arma una cadena de tipo
  llave=valor|llave2= valor2| para insertar en el campo
  record de dl_log_process
  Autor       :   Paula Garcia
  Fecha       :   12-07-2013
  Historia de Modificaciones
  Fecha       IDEntrega
  12-07-2013
  Creación.
  ***************************************************************************/
  PROCEDURE GetPrimaryAndValues;
  /******************************************************************
  Propiedad intelectual de Open Systems (c).
  Unidad  : fblExistsDL_LOG_PROCESS
  Descripcion : R   evisa si existe el registro en dl_log_process
  Parámetros   Descripción
  ============    ===================
  Autor  : Paula Garcia
  Fecha  : 09/07/2013
  Historia de Modificaciones
  Fecha           Autor               Modificacion
  ===========     =================== ====================
  *********************************************************************/
  FUNCTION fblExistsDL_LOG_PROCESS(
      isbRow_id   VARCHAR2,
      isbTablename VARCHAR2,
      isbDataBase VARCHAR2)
    RETURN BOOLEAN;
  /***************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Procedure   :  InsRegNoProcess
  Descripción :  Inserta el registro no procesado en dl_log_process
  Autor       :   Paula Garcia
  Fecha       :   12-07-2013
  Historia de Modificaciones
  Fecha       IDEntrega
  Creación.
  ***************************************************************************/
  PROCEDURE InsRegNoProcess;
  /***************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Procedure   :  InsRegOkProcess
  Descripción :  Inserta el registro procesado en dl_log_process
  Autor       :   Paula Garcia
  Fecha       :   12-07-2013
  Historia de Modificaciones
  Fecha       IDEntrega
  12-07-2013
  Creación.
  ***************************************************************************/
  PROCEDURE InsRegOkProcess;
  /****************************************************************************
  ***
  Propiedad intelectual de Open International Systems (c).
  Procedure   :   SetgsbNombreTabla
  Descripción :
  Autor       :   Paula Garcia
  Fecha       :   17-07-2013 11:15:26
  Historia de Modificaciones
  Fecha       IDEntrega
  Creación.
  *****************************************************************************
  **/
  PROCEDURE SetgsbNombreTabla(
      isbNombreTabla VARCHAR2);
  /***************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Procedure   :   fsbGetgsbNombreTabla
  Descripción :
  Autor       :   Paula Garcia
  Fecha       :
  Historia de Modificaciones
  Fecha       IDEntrega
  Creación.
  ***************************************************************************/
  FUNCTION fsbGetgsbNombreTabla
    RETURN VARCHAR2;
  /****************************************************************************
  ***
  Propiedad intelectual de Open International Systems (c).
  Procedure   :   SetgsbDataTable
  Descripción :   gsbDataTable            tyrctbTablas;
  Autor       :   Paula Garcia
  Fecha       :   17-07-2013 11:15:26
  Historia de Modificaciones
  Fecha       IDEntrega
  Creación.
  *****************************************************************************
  **/
  PROCEDURE SetgsbDataTable(
      isbDataTable tyrctbTablas);
  /***************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Procedure   :   fsbGetgsbDataTable
  Descripción :
  Autor       :   Paula Garcia
  Fecha       :
  Historia de Modificaciones
  Fecha       IDEntrega
  Creación.
  ***************************************************************************/
  FUNCTION fsbGetgsbDataTable
    RETURN tyrctbTablas;
  /****************************************************************************
  ***
  Propiedad intelectual de Open International Systems (c).
  Procedure   :   SetgtbData
  Descripción :   gtbData                 tytbCondicion;
  Autor       :   Paula Garcia
  Fecha       :   17-07-2013 11:15:26
  Historia de Modificaciones
  Fecha       IDEntrega
  Creación.
  *****************************************************************************
  **/
  PROCEDURE SetgtbData(
      itbData tytbCondicion);
  /***************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Procedure   :   fsbGetgtbData
  Descripción :
  Autor       :   Paula Garcia
  Fecha       :
  Historia de Modificaciones
  Fecha       IDEntrega
  Creación.
  ***************************************************************************/
  FUNCTION fsbGetgtbData
    RETURN tyrctbTablas;
  /****************************************************************************
  ***
  Propiedad intelectual de Open International Systems (c).
  Procedure   :   SetgsbCadenatoInsert
  Descripción :   gsbCadenatoInsert       varchar2(2000);
  Autor       :   Paula Garcia
  Fecha       :   17-07-2013 11:15:26
  Historia de Modificaciones
  Fecha       IDEntrega
  Creación.
  *****************************************************************************
  **/
  PROCEDURE SetgsbCadenatoInsert(
      isbCadenatoInsert VARCHAR2);
  /***************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Procedure   :   fsbGetgsbCadenatoInsert
  Descripción :
  Autor       :   Paula Garcia
  Fecha       :
  Historia de Modificaciones
  Fecha       IDEntrega
  Creación.
  ***************************************************************************/
  FUNCTION fsbGetgsbCadenatoInsert
    RETURN VARCHAR2;
  /***************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Procedure   :   InsertIntoValuesTemp
  Descripción :   Llena los campos SDO_GEOMETRY, BLOB y CLOB para ser
  procesados en el destino.
  Autor       :   Paula Garcia
  Fecha       :
  Historia de Modificaciones
  Fecha       IDEntrega
  Creación.
  ***************************************************************************/
END DL_BOPARAMETRIZACION;
/
CREATE OR REPLACE PACKAGE BODY        "DL_BOPARAMETRIZACION"
AS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : DL_BOPARAMETRIZACION
    Descripcion    :
    Autor          :
    Fecha          :


    Historia de Modificaciones
    Fecha          Autor                Modificacion
    =========      =========            ====================
    16-01-2014     Mmejia.ARA5954       Se modifica metodo <<ProcessFileFromOtherDB>>
    ******************************************************************/

  -- Tipo para el registro de errores.
TYPE tyrcError
IS
  RECORD
  (
    Line_Number VARCHAR2 (512),         -- Número de línea.
    Line        VARCHAR2 (1000),        -- Linea del archivo
    Error ge_error_log.description%TYPE -- Descripción del error.
  );
  -- Tipo para la colección de registros de los errores.
TYPE tytbrcError
IS
  TABLE OF tyrcError INDEX BY BINARY_INTEGER;
  --------------------------------------------
  -- Constantes
  --------------------------------------------
  -- Esta constante se debe modificar cada vez que se entregue el paquete con
  -- un SAO
  csbVersion  CONSTANT VARCHAR2 (250) := 'SAO215120';
  csbPROGRAM  CONSTANT VARCHAR2 (5)   := 'ODLTB';
  csbDUMMY_   CONSTANT VARCHAR2 (20)  := 'DUMMY_';
  csbGCTB     CONSTANT VARCHAR2 (4)   := 'GCTB';
  csbODLTEMP_ CONSTANT VARCHAR2 (10)  := 'ODLTMP_';
  cnuLINEA    CONSTANT NUMBER         := 1;
  cnuPUNTO    CONSTANT NUMBER         := 2;
  csbBSS      CONSTANT VARCHAR2 (1)   := 'B';
  csbOSS      CONSTANT VARCHAR2 (1)   := 'O';
  csbINSERT   CONSTANT VARCHAR2 (1)   := 'I';
  csbUPDATE   CONSTANT VARCHAR2 (1)   := 'U';
  csbBOTH     CONSTANT VARCHAR2 (1)   := 'B';
  sbErrMsg    VARCHAR2 (2000);
  grctbBloqueTablas DL_BOPARAMETRIZACION.tytbrcBloqueTablas;
  grctbSentaEjecDest DL_BOPARAMETRIZACION.tyrcResSent;
  gtbrcError tytbrcError; -- Tabla de registro para manejo de errores.
  gtbrcError_EMPTY tytbrcError;
  gsbErrorFileName VARCHAR2 (200); -- Nombre del archivo de errores.
  gtbErrorsFileName tytbVarFields;
  gsbReproFileName VARCHAR2 (200); -- Nombre del archivo para reprocesamiento
  gsbZipFileName   VARCHAR2 (200);
  gsbEstaprog      VARCHAR2 (100); --
  gsbPathFile      VARCHAR2 (200); -- Ruta del directorio.
  gsbProcessTrack estaprog.esprprog%TYPE;
  gnuRecordsNumber NUMBER;
  gnuCompleteLines NUMBER;
  gsbOnlyVal       VARCHAR2 (1);
  gsbNomDBLink     VARCHAR2 (100);
  gtbColumn_name tytbcolumn_name;
  gsbTableFields VARCHAR2 (4000);
  gsbRecordData  VARCHAR2 (4000);
  gsbRowid ROWID;
  gsbModo VARCHAR2 (1);
  gtbData tytbCondicion;
  gsbFirstRow VARCHAR2 (4000);
  gtbDatos tytbResSent;
  gsbProc          clob;
  gsbProc1         clob;
  gnuInsertados    NUMBER;
  gnuRechazados    NUMBER;
  gsbErrorSequence VARCHAR2 (50);
  gsbDB_LINK       VARCHAR2 (200);
  gsbDB       VARCHAR2 (200);
  gsbDataTable tyrctbTablas;
  gsbNombreTabla      VARCHAR2 (100);
  gsbCadenatoInsert   VARCHAR2 (2000);
  gsbRecordtoInsert   VARCHAR2 (2000);
  gblNoTieneLlavePrim BOOLEAN := FALSE;
  --------------------------------------------
  -- Funciones y Procedimientos
  --------------------------------------------
FUNCTION fsbVersion
  RETURN VARCHAR2
IS
BEGIN
  RETURN csbVersion;
END;
FUNCTION fsbGetInsertMode
  RETURN VARCHAR2
IS
BEGIN
  RETURN csbINSERT;
END;
FUNCTION fsbGetUpdateMode
  RETURN VARCHAR2
IS
BEGIN
  RETURN csbUPDATE;
END;
FUNCTION fsbGetBothMode
  RETURN VARCHAR2
IS
BEGIN
  RETURN csbBOTH;
END;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   CreateDirectoryHSPPP
Descripción :   Crea directorio para el log de errores
Autor       :   Paula Garcia
Fecha       :   11-07-2013 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE CreateDirectoryHSPPP(
    isbPath    IN VARCHAR2,
    isbDirName IN VARCHAR2)
IS
BEGIN
  pkErrors.Push ('DL_BOPARAMETRIZACION.CreateDirectoryHSPPP');
  pkgeneralservices.tracedata ( 'mkdir -m777 ' || isbPath || '/' || isbDirName);
  llamasist ('cd ' || isbPath || '; mkdir -m777 ' || isbPath || '/' ||isbDirName);
  DBMS_LOCK.sleep(6);
  pkErrors.Pop;
EXCEPTION
WHEN ex.CONTROLLED_ERROR THEN
  RAISE ex.CONTROLLED_ERROR;
WHEN OTHERS THEN
  Errors.setError;
  RAISE ex.CONTROLLED_ERROR;
END CreateDirectoryHSPPP;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   ftbGetTableData
Descripción :   Obtiene tabla de dato de memoria
Autor       :   Leonardo Garcia
Fecha       :   22-08-2009 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
FUNCTION ftbGetTableData
  RETURN tytbCondicion
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.ftbGetTableData');
  pkerrors.pop;
  RETURN gtbData;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END ftbGetTableData;
PROCEDURE AlterTriggers(
    isbNomTabla VARCHAR2,
    isbAction   VARCHAR2)
IS
BEGIN
  pkErrors.Push ('DL_BOPARAMETRIZACION.AlterTriggers');
  pkgeneralservices.tracedata ('Alter table ' || isbNomTabla || ' ' || isbAction || ' all triggers');
  EXECUTE IMMEDIATE 'Alter table ' || isbNomTabla || ' ' || isbAction || ' all triggers';
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END AlterTriggers;
PROCEDURE AlterTriggersDBLink(
    isbNomTabla VARCHAR2,
    isbAction   VARCHAR2)
IS
BEGIN
  pkErrors.Push ('DL_BOPARAMETRIZACION.AlterTriggersDBLink');
  EXECUTE immediate 'BEGIN dbms_utility.exec_ddl_statement@'|| DL_BOPARAMETRIZACION.fsbgetDB_LINK||'('||chr(39)||'ALTER TABLE '||isbNomTabla ||' '||isbAction||' ALL TRIGGERS'||chr(39)||'); END;';
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END AlterTriggersDBLink;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   : GetFieldsFromDB
Descripción :
Autor       :   Leonardo Garcia
Fecha       :   22-08-2009 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE GetFieldsFromDB(
    isbRcName VARCHAR2,
    osbTableFields OUT VARCHAR2,
    osbRecordData OUT VARCHAR2)
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.GetFieldsFromDB');
  IF (gtbColumn_name.FIRST IS NULL OR gsbTableFields IS NOT NULL) THEN
    osbTableFields         := gsbTableFields;
    osbRecordData          := gsbRecordData;
    pkErrors.pop;
    RETURN;
  END IF;
  FOR nuIdx IN gtbColumn_name.FIRST .. gtbColumn_name.LAST
  LOOP
    IF (osbTableFields IS NULL) THEN
      osbTableFields   := gtbColumn_name (nuIdx);
      osbRecordData    := isbRcName || '.' || osbTableFields;
    ELSE
      osbTableFields := osbTableFields || ',' || gtbColumn_name (nuIdx);
      osbRecordData  := osbRecordData || ',' || isbRcName || '.' ||
      gtbColumn_name (nuIdx);
    END IF;
  END LOOP;
  gsbTableFields := osbTableFields;
  gsbRecordData  := osbRecordData;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END GetFieldsFromDB;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :
Descripción :
Autor       :   Leonardo Garcia
Fecha       :   22-08-2009 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
FUNCTION fsbGetRowid
  RETURN ROWID
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.fsbGetRowid');
  pkerrors.pop;
  RETURN gsbRowid;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END fsbGetRowid;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   setTableField
Descripción :
Autor       :   Leonardo Garcia
Fecha       :   22-08-2009 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE setTableField(
    itbColumn_name tytbcolumn_name)
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.setTableField');
  gtbColumn_name := itbColumn_name;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END setTableField;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   setRowid
Descripción :
Autor       :   Leonardo Garcia
Fecha       :   22-08-2009 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE setRowid(isbRowid ROWID)
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.setRowid');
  gsbRowid := isbRowid;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror(pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error(pkconstante.nuerror_level2, sbErrMsg);
END setRowid;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   setExecutionMode
Descripción :
Autor       :   Leonardo Garcia
Fecha       :   22-08-2009 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE setExecutionMode(isbModo VARCHAR2)
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.setExecutionMode');
  gsbModo := isbModo;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END setExecutionMode;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   setSentEjecDest
Descripción :   Fija en memoria el bloque de tablas resultantes
Autor       :   Leonardo Garcia
Fecha       :   22-08-2009 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE setSentEjecDest(irctbSentaEjecDest DL_BOPARAMETRIZACION.tyrcResSent)
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.setSentEjecDest');
  grctbSentaEjecDest := NULL;
  grctbSentaEjecDest := irctbSentaEjecDest;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   ftbGetSentaEjecDest
Obtiene un bloque de tablas resultantes de memoria
Descripción :   Obtiene un bloque de tablas
Autor       :   Leonardo Garcia
Fecha       :   22-08-2009 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
FUNCTION ftbGetSentaEjecDest
  RETURN DL_BOPARAMETRIZACION.tyrcResSent
IS
  rctbSentaEjecDest DL_BOPARAMETRIZACION.tyrcResSent;
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.ftbGetSentaEjecDest');
  pkerrors.pop;
  rctbSentaEjecDest  := grctbSentaEjecDest;
  grctbSentaEjecDest := NULL;
  RETURN rctbSentaEjecDest;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END ftbGetSentaEjecDest;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   fsbGetExecutionMode
Descripción :   Obtiene el modo de ejecucion
Autor       :   Leonardo Garcia
Fecha       :   22-08-2009 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
FUNCTION fsbGetExecutionMode
  RETURN VARCHAR2
IS
  rctbSentaEjecDest DL_BOPARAMETRIZACION.tyrcResSent;
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.fsbGetExecutionMode');
  pkerrors.pop;
  RETURN gsbModo;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END fsbGetExecutionMode;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   : ftbGetPrimaryKeyField
Descripción :   Obtiene el campo llave primaria de una tabla Llave primaria
Autor       :   Leonardo Garcia
Fecha       :   22-08-2009 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
FUNCTION ftbGetPrimaryKeyField(isbTablename IN VARCHAR2)
  RETURN tytbFields
IS
  cuDataFile pkConstante.tyRefCursor;
  sbSentence VARCHAR2 (1000);
  tbColumnNames tytbFields;
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.ftbGetPrimaryKeyField');
  gblNoTieneLlavePrim := FALSE;
  -- Arma sentencia para obtener llave primaria
  sbSentence := 'select b.column_name from user_constraints a,user_cons_columns b where a.table_name = '''|| UPPER (isbTableName) ||''' and a.CONSTRAINT_TYPE = ''P'' AND a.constraint_name = b.constraint_name order by position';
  OPEN cuDataFile FOR sbSentence;
  FETCH
    cuDataFile BULK COLLECT
  INTO
    tbColumnNames;
  CLOSE cuDataFile;
  --Si la tabla no tiene llaves primarias, asigne todos los campos de la tabla.
  IF (tbColumnNames.FIRST) IS NULL THEN
    sbSentence := 'SELECT technical_name FROM ge_entity_attributes WHERE entity_id IN ( SELECT entity_id FROM ge_entity WHERE name_ = ''' || UPPER (isbTableName) || ''') order by SECUENCE_';
    --ut_trace.trace('ConError:'||sbSentence);
    OPEN cuDataFile FOR sbSentence;
    FETCH
      cuDataFile BULK COLLECT
    INTO
      tbColumnNames;
    CLOSE cuDataFile;
    gblNoTieneLlavePrim := TRUE;
  END IF;
  pkerrors.pop;
  RETURN tbColumnNames;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END ftbGetPrimaryKeyField;
/******************************************************************
Propiedad intelectual de Open Systems (c).
Unidad  : fsbGetFieldName
Descripcion : Obtiene los nombres de los campos
Parámetros   Descripción
============    ===================
isbFieldName           Nombres de los campos
Retorno
============
Autor  : Leonardo Garcia .
Fecha  : 11/04/2010
Historia de Modificaciones
Fecha           Autor               Modificacion
===========     =================== ====================
*********************************************************************/
FUNCTION fsbGetFieldName(
    isbTablename VARCHAR2,
    isbFieldName VARCHAR2)
  RETURN VARCHAR2
IS
  nuFields    NUMBER;
  sbFieldName VARCHAR2 (1000);
  tbString ut_string.TyTb_String;
BEGIN
  pkErrors.Push ('DL_BOPARAMETRIZACION.fsbGetFieldName');
  -- Pasa la cadena de resultado a una tabla
  ut_string.ExtString (isbFieldName, '|', tbString);
  IF (tbString.FIRST IS NULL) THEN
    pkErrors.pop;
    RETURN NULL;
  END IF;
  -- Recorre la tabla de resultado
  FOR nuIdx IN tbString.FIRST .. tbString.LAST
  LOOP
    IF tbString (nuIdx) IS NOT NULL THEN
      -- Busca si existe el campo en la B.D
      SELECT COUNT (1) INTO nuFields FROM user_tab_COLUMNS WHERE column_name = UPPER (tbString (nuIdx))
      AND DATA_TYPE NOT IN ('SDO_GEOMETRY', 'CLOB')
      --AND DATA_TYPE NOT IN ('BLOB')
      AND table_name = UPPER (isbTablename);
      -- Si no existe, llena el campo dummy
      IF (nuFields = 0) THEN
        tbString (nuIdx) := csbDUMMY_ || tbString (nuIdx);
      ELSE
        tbString (nuIdx) := tbString (nuIdx);
      END IF;
      IF sbFieldName IS NOT NULL THEN
        sbFieldName  := sbFieldName || '|' || tbString (nuIdx);
      ELSE
        sbFieldName := tbString (nuIdx);
      END IF;
    END IF;
  END LOOP;
  pkErrors.pop;
  RETURN '0|' || sbFieldName || '|';
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END fsbGetFieldName;
/******************************************************************
Propiedad intelectual de Open Systems (c).
Unidad  : Create_files
Descripcion : Extrae los datos de las tablas de la base de datos que se le
especifiquen en un archivo.
Parámetros   Descripción
============    ===================
isbPath           in  Directorio donde esta el archivo con la lista de tablas,
irctbDatosTablas  in  Datos de las tablas
Retorno
============
Autor  : Leonardo Garcia .
Fecha  : 11/04/2010
Historia de Modificaciones
Fecha           Autor               Modificacion
===========     =================== ====================
*********************************************************************/
PROCEDURE Create_files(
    isbPath          IN VARCHAR2,
    irctbDatosTablas IN tyrcResSent,
    orctbArchivos    IN OUT tyrcFiles)
IS
  sbNombArch VARCHAR2 (100);
  fdarchivo UTL_FILE.FILE_TYPE;
  nuNumLinea NUMBER;
  nuIndice   NUMBER;
  ----------------- Metodos Encapsulados -------------------------------------
  ---------------------------------------------------------------------------------
FUNCTION fblExistFileInMem(
    itbNombarchiv tytbFields,
    isbNombArch VARCHAR2,
    onuIndice OUT NUMBER)
  RETURN BOOLEAN
IS
  nuIdx NUMBER;
BEGIN
  pkErrors.Push ( 'DL_BOPARAMETRIZACION.Create_files.fblExistFileInMem');
  onuIndice := NVL (itbNombarchiv.LAST, 0) + 1;
  nuIdx     := itbNombarchiv.FIRST;
  LOOP
    EXIT
  WHEN nuIdx IS NULL;
    -- Si el archivo existe en memoria devuelve verdadero
    IF (itbNombarchiv (nuIdx) = isbNombArch) THEN
      onuIndice              := nuIdx;
      pkErrors.pop;
      RETURN TRUE;
    END IF;
    nuIdx := itbNombarchiv.NEXT (nuIdx);
  END LOOP;
  pkErrors.pop;
  RETURN FALSE;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END fblExistFileInMem;
---------------------------------------------------------------------------------
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.Create_files');
  IF irctbDatosTablas.tbNombreTabla.FIRST IS NULL THEN
    pkErrors.pop;
    RETURN;
  END IF;
  FOR nuIdx IN irctbDatosTablas.tbNombreTabla.FIRST ..
  irctbDatosTablas.tbNombreTabla.LAST
  LOOP
    -- Arma nombre de archivo
    sbNombArch := irctbDatosTablas.tbNombreTabla (nuIdx) || '-' || gsbEstaprog|| '.ctb';
    fdarchivo := pkUtlFilemgr.Fopen (isbPath, sbNombArch, 'a');
    -- Si no existe en la tabla es porque no se ha creado el archivo
    IF (NOT fblExistFileInMem (orctbArchivos.tbNombarchiv, sbNombArch, nuIndice)) THEN
      -- Adiciona en la primera linea del archivo los nombres de los campos
      pkUtlFilemgr.put_line ( fdarchivo, fsbGetFieldName (irctbDatosTablas.tbNombreTabla (nuIdx), irctbDatosTablas.tbCampos (nuIdx)));
      -- Asigna  numero de linea
      orctbArchivos.tbNumLinea (nuIndice) := 1;
    END IF;
    nuNumlinea := orctbArchivos.tbNumLinea (nuIndice);
    -- Adiciona linea de datos
    pkUtlFilemgr.put_line ( fdarchivo, nuNumlinea || '|' || irctbDatosTablas.tbDatos (nuIdx));
    nuNumLinea := nuNumlinea + 1;
    -- Adiciona en tabla de memoria el nombre del archivo generado
    orctbArchivos.tbNumLinea (nuIndice)   := nuNumLinea;
    orctbArchivos.tbNombarchiv (nuindice) := sbNombArch;
    pkUtlFilemgr.fclose (fdarchivo);
  END LOOP;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END Create_files;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   fsbGetTableName
Create Directory.
Descripción :   Obtiene el nombre de la tabla a partir del nombre del archivo
Autor       :   Leonardo Garcia Q
Fecha       :   20-11-2009 16:28:44
Historia de Modificaciones
Fecha       IDEntrega
20-11-2009  lgarciaSAOXXXX
Creación.
******************************************************************************
*/
FUNCTION fsbGetTableName(
    isbNomArch VARCHAR2)
  RETURN VARCHAR2
IS
  nuPosition  NUMBER;
  sbTableName VARCHAR2 (100);
  sbNomArch   VARCHAR2 (100);
BEGIN
  --{
  pkErrors.Push ('DL_BOPARAMETRIZACION.fsbGetTableName');
  -- Si viene un punto en la primera posicion lo elimina
  IF (INSTR (isbNomArch, '.') = 1) THEN
    sbNomArch                := SUBSTR (isbNomArch, 2);
  ELSE
    sbNomArch := isbNomArch;
  END IF;
  -- Obtiene la posicion del caracter '-'
  nuPosition := INSTR (sbNomArch, '-');
  -- Si encontro el caracter
  IF (nuPosition > 0) THEN
    -- Asigna al nombre de la tabla el nombre obtenido del archivo
    sbTableName := SUBSTR (sbNomArch, 1, nuPosition - 1);
  ELSE
    -- Si no encontro '-' busca '.'
    nuPosition := INSTR (sbNomArch, '.');
    -- Si encontro el caracter '.'
    IF (nuPosition > 0) THEN
      -- Asigna al nombre de la tabla el nombre obtenido del archivo
      sbTableName := SUBSTR (sbNomArch, 1, nuPosition - 1);
    ELSE
      -- Asigna al nombre de la tabla el nombre obtenido del archivo
      sbTableName := sbNomArch;
    END IF;
  END IF;
  pkErrors.Pop;
  RETURN sbTableName;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END fsbGetTableName;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   ProcessSentaEjecDest
Descripción :   Procesa sentencias resultado de la extracccion de tablas
Autor       :   Leonardo Garcia Q
Fecha       :   22-08-2009 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE ProcessSentaEjecDest(
    isbNomArchivo VARCHAR2,
    irctbSentenciasaEjec DL_BOPARAMETRIZACION.tyrcResSent,
    iblGetDataFromOtherDB BOOLEAN)
IS
  osbErrorMessage VARCHAR2 (2000);
  tbsbNombArch tytbVarFields;
  rctbArchivos tyrcFiles;
  ----------------- Metodos Encapsulados -------------------------------------
PROCEDURE ClearMemory
IS
BEGIN
  gnuRechazados := 0;
  gnuInsertados := 0;
  gsbFirstRow   := NULL;
  gtbDatos.delete;
END;
-------------------------------------------------------------------------
PROCEDURE CreateTotaFile(
    isbPathFile  VARCHAR2,
    isbTablename VARCHAR2)
IS
  fdFile UTL_FILE.file_type;
  nuPosition NUMBER;
  sbNombArch VARCHAR2 (100);
BEGIN
  -- Extrae el nombre del archivo.
  nuPosition    := INSTR (isbNomArchivo, '.');
  IF (nuPosition > 0) THEN
    sbNombArch  := SUBSTR (isbNomArchivo, 1, nuPosition - 1);
  ELSE
    sbNombArch := isbNomArchivo;
  END IF;
  sbNombArch := sbNombArch || '-' || gsbErrorSequence || '.tot';
  fdFile     := pkUtlFileMgr.Fopen (isbPathFile, sbNombArch, 'a');
  pkUtlFileMgr.Put_Line(fdFile, RPAD (isbTablename, 25, ' ') || '|' || LPAD (gnuInsertados, 27, ' ') || '|' || LPAD (gnuRechazados, 22, ' ') || '|');
  pkUtlFileMgr.fclose(fdFile);
END;
-------------------------------------------------------------------------
PROCEDURE InsertDataFiles(
    isbPathFile VARCHAR2,
    irctbDatosTablas tyrcResSent,
    irctbArchivos tyrcFiles)
IS
  nuIdx NUMBER;
BEGIN
  /* ut_trace.init;
  ut_trace.setlevel(99);
  ut_trace.setoutput(ut_trace.fntrace_output_db);*/
  ut_trace.trace ('INICIO PROCESO', 2);
  pkErrors.Push ( 'DL_BOPARAMETRIZACION.ProcSentaEjecDest.InsertDataFiles');
  -- Fija en memoria la primra linea con los campos de la tabla
  gsbFirstRow :=fsbGetFieldName(irctbDatosTablas.tbNombreTabla(irctbDatosTablas.tbNombreTabla.FIRST), irctbDatosTablas.tbCampos(irctbDatosTablas.tbCampos.FIRST));
  gtbDatos := irctbDatosTablas.tbDatos;
  DL_BOPARAMETRIZACION.CargadorTablasPorArchivo ( NULL, -- Id de seguimiento
  irctbDatosTablas.tbNombreTabla ( irctbDatosTablas.tbNombreTabla.FIRST),
  isbPathFile, gsbOnlyVal, pkConstante.SI, --Altera Secuencia,
  1,                                       -- Numero de Hilo
  1,                                       -- Nuero de Hilos
  irctbDatosTablas.tbModo (irctbDatosTablas.tbModo.FIRST));
  ut_trace.trace ('crea total file', 2);
  -- Crea archivo de totales
  CreateTotaFile ( isbPathFile, irctbDatosTablas.tbNombreTabla (
  irctbDatosTablas.tbNombreTabla.FIRST));
  pkErrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  -- Adiciona el error a la colección de errores.
  AddError ( NULL, fsbGetTableName (irctbArchivos.tbNombarchiv.NEXT (nuidx)),
  pkErrors.fsbGetErrorMessage--osbErrorMessage
  );
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, osbErrorMessage);
  -- Adiciona el error a la colección de errores.
  AddError ( NULL, fsbGetTableName (irctbArchivos.tbNombarchiv.NEXT (nuidx)),
  pkErrors.fsbGetErrorMessage--osbErrorMessage
  );
  pkerrors.pop;
END InsertDataFiles;
---------------------------------------------------------------------------------
BEGIN
  --{
  pkErrors.Push ('DL_BOPARAMETRIZACION.ProcessSentaEjecDest');
  IF irctbSentenciasaEjec.tbNombreTabla.FIRST IS NULL THEN
    pkErrors.pop;
    RETURN;
  END IF;
  -- Si se esta ejecutando para obtener los datos de otra B.D.
  IF (NVL (iblGetDataFromOtherDB, FALSE)) THEN
    pkgeneralservices.tracedata ('LLAMA A CARGAR DATOS POR ARCHIVO');
    -- Borra datos memoria
    ClearMemory;
    -- Recorre los archivos para cargarlos en la b.d
    InsertDataFiles (gsbPathFile, irctbSentenciasaEjec, rctbArchivos);
    ut_trace.trace ('InsertDataFiles', 2);
    -- Si no es llamado para obt datos de otra b.d sino para generar archivo
  ELSE
    pkgeneralservices.tracedata ('LLAMA A CARGAR KCERON');
    -- Crea Archivos
    Create_files (gsbPathFile, irctbSentenciasaEjec, rctbArchivos);
  END IF;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END ProcessSentaEjecDest;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   AddError
Add Error.
Descripción :   Adiciona el error a la colección de errores.
Autor       :   Leonardo Garcia Q
Fecha       :   22-08-2009 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE AddError(
    isbLine_Number IN VARCHAR2,                     -- Número de línea.
    isbResSentence IN VARCHAR2,                     -- Linea del archivo
    isbError       IN ge_error_log.description%TYPE -- Descripción del error.
  )
IS
  ------------------------------------------------------------------------
  -- Variables:
  nuIndex BINARY_INTEGER;
BEGIN
  pkErrors.Push ('DL_BOPARAMETRIZACION.AddError');
  nuIndex                          := NVL (gtbrcError.LAST, 0) + 1;
  gtbrcError (nuIndex).Line_Number := isbLine_Number;
  gtbrcError (nuIndex).Line        := isbResSentence;
  gtbrcError (nuIndex).Error       := isbError;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END AddError;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   fblExistsValProcedure
Descripción :   Valida si existe un procedimiento en la base de datos
Autor       :   Leonardo Garcia Q
Fecha       :   20-11-2009 16:28:44
Historia de Modificaciones
Fecha       IDEntrega
20-11-2009  lgarciaSAOXXXX
Creación.
******************************************************************************
*/
FUNCTION fblExistsValProcedure(
    isbNombProc VARCHAR2)
  RETURN BOOLEAN
IS
  CURSOR cuObjeto (isbNombProc VARCHAR2)
  IS
    SELECT
      COUNT (*)
    FROM
      user_objects
    WHERE
      UPPER (object_name) = UPPER (isbNombProc);
  nuCount NUMBER         := 0;
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.fblExistsValProcedure');
  IF (cuObjeto%ISOPEN) THEN
    CLOSE cuObjeto;
  END IF;
  OPEN cuObjeto (isbNombProc);
  FETCH
    cuObjeto
  INTO
    nuCount;
  CLOSE cuObjeto;
  IF (nuCount > 0) THEN
    pkErrors.pop;
    RETURN TRUE;
  END IF;
  pkerrors.pop;
  RETURN FALSE;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END fblExistsValProcedure;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   fsbGetFieldsFromfile
Descripción :   Obtiene los nombres de los campos del archivo si vienen en la
primera linea
________________________________________________________________________
Retorno     |   Descripción
____________|___________________________________________________________
osbColumns  |   Columnas del archivo.
osbFields   |   Campos de la tabla externa.
____________|___________________________________________________________
Autor       :   Leonardo Garcia Q.
Fecha       :   22-08-2008 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
FUNCTION fsbGetFieldsFromfile(
    isbProcessId IN VARCHAR2,
    isbPathFile  IN VARCHAR2,
    isbFileName  IN VARCHAR2)
  RETURN VARCHAR2
IS
  fdFile UTL_FILE.file_type;
  sblinea VARCHAR2 (3000);
  nux     NUMBER;
BEGIN
  --{
  pkErrors.Push ('DL_BOPARAMETRIZACION.fsbGetFieldsFromfile');
  -- Si es llamado desde el cargador de datos de otra
  IF isbProcessId IS NULL THEN
    sblinea       := gsbFirstRow;
  ELSE
    -- Abre el archivo
    fdFile := pkUtlFileMgr.Fopen (isbPathFile, isbFileName, 'r');
    -- Lee la primera linea
    nux := pkUtlFileMgr.Get_Line (fdFile, sblinea);
    -- Cierra el archivo
    pkUtlFileMgr.fclose (fdFile);
  END IF;
  --Evalua si en el primer registro viene el numero de linea 0 es porque vienen
  -- los campos en el archivo
  IF (SUBSTR (sbLinea, 1, INSTR (sbLinea, '|') - 1) = '0') THEN
    -- Borra el numero de linea 0
    sbLinea := SUBSTR (sbLinea, INSTR (sbLinea, '|') + 1);
    -- Si en la ultima posicion enviaron un | lo borra para poder ejecutar el
    -- query
    IF (INSTR (sblinea, '|', -1) = LENGTH (sbLinea)) THEN
      -- Lo borra el ultimo |
      sbLinea := SUBSTR (sblinea, 1, LENGTH (sblinea) - 1);
    END IF;
    -- reemplaza los | por , para ejecucion del query
    sbLinea := REPLACE (sbLinea, '|', ',');
    pkErrors.pop;
    RETURN sblinea;
  END IF;
  pkErrors.Pop;
  RETURN NULL;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END fsbGetFieldsFromfile;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   CreateDirectory
Create Directory.
Descripción :   Crea el directorio.
Autor       :   Leonardo Garcia Q
Fecha       :   20-11-2009 16:28:44
Historia de Modificaciones
Fecha       IDEntrega
20-11-2009  lgarciaSAOXXXX
Creación.
******************************************************************************
*/
PROCEDURE CreateDirectory(
    isbProcessId VARCHAR2,
    isbPath      VARCHAR2,
    isbDirectory VARCHAR2)
IS
  ----------------------------------------------------------------------------
  -- Variables:
  sbSentence VARCHAR2 (4000) := NULL; -- Sentencia creación del directorio.
BEGIN
  --{
  pkErrors.Push ('DL_BOPARAMETRIZACION.CreateDirectory');
  -- Si es llamado desde el cargador de datos desde otra base
  IF isbProcessId IS NULL THEN
    pkErrors.pop;
    RETURN;
  END IF;
  -- Construir sentencia de creación de directorio.
  sbSentence := 'CREATE OR REPLACE DIRECTORY ' || isbDirectory || ' AS ''' ||
  isbPath || '''';
  -- Crear directorio
  -- !doc Asignar permisos de creación de cualquier directorio (grant
  -- create any directory)
  EXECUTE IMMEDIATE sbSentence;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END CreateDirectory;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   CreateErrorsFile
Create Errors File
Descripción :   Crea el archivo de errores.
Autor       :   Leonardo Garcia Q.
Fecha       :   22-08-2008 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE CreateErrorsFile(
    isbFileName       VARCHAR2,
    isbErrorSequence  VARCHAR2,
    iblCreaArchReproc BOOLEAN)
IS
  ------------------------------------------------------------------------
  -- Variables:
  fdFile UTL_FILE.file_type;
  fdLineFile UTL_FILE.file_type;
  nuPosition NUMBER;
  sbFileName VARCHAR2 (200);
BEGIN
  pkErrors.Push ('CreateErrorsFile');
  ut_trace.trace ('entro CreateErrorsFile:' || gsbPathFile, 2);
  -- Extrae el nombre del archivo.
  nuPosition    := INSTR (isbFileName, '.');
  IF (nuPosition > 0) THEN
    sbFileName  := SUBSTR (isbFileName, 1, nuPosition - 1);
  ELSE
    sbFileName := isbFileName;
  END IF;
  IF (gsbProcessTrack IS NOT NULL) THEN
    -- Arma el nombre del archivo de errores.
    gsbErrorFileName := sbFileName || '-' || gsbProcessTrack || '.err';
  ELSE
    -- Arma el nombre del archivo de errores.
    gsbErrorFileName := sbFileName || '-' || isbErrorSequence || '.err';
  END IF;
  -- Si ya existe en la tabla en memoria de errores retorna
  IF (gtbErrorsFileName.EXISTS (gsbErrorFileName)) THEN
    pkErrors.pop;
    RETURN;
  END IF;
  gtbErrorsFileName (gsbErrorFileName) := gsbErrorFileName;
  fdFile                               := pkUtlFileMgr.Fopen (gsbPathFile,
  gsbErrorFileName, 'a');
  pkUtlFileMgr.Put_Line (fdFile, 'Open Data Loader - Errors ');
  pkUtlFileMgr.Put_Line (fdFile, ' ');
  pkUtlFileMgr.Put_Line (fdFile,'Errors file opened at ' || TO_CHAR (SYSDATE));
  pkUtlFileMgr.Put_Line (fdFile, ' ');
  pkUtlFileMgr.Put_Line (fdFile, 'Line |  Error');
  pkUtlFileMgr.fclose (fdFile);
  -- Si debe crear archivo de reproceso
  IF iblCreaArchReproc THEN
    IF (gsbProcessTrack IS NOT NULL) THEN
      -- Crear archivo de archivo de reprocesamiento
      gsbReproFileName := '.' || sbFileName || '-' || gsbProcessTrack || '.rep'
      ;
    ELSE
      -- Crear archivo de archivo de reprocesamiento
      gsbReproFileName := '.' || sbFileName || '-' || isbErrorSequence ||
      '.rep';
    END IF;
    fdLineFile := pkUtlFileMgr.Fopen (gsbPathFile, gsbReproFileName, 'a');
    pkUtlFileMgr.fclose (fdLineFile);
  END IF;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END CreateErrorsFile;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   FlushErrors
Flush Errors.
Descripción :   Descarga errores en archivo y se limpia colección de
errores.
Autor       :   Leonardo Garcia
Fecha       :   22-08-2008 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE FlushErrors(
    isbFileName       VARCHAR2,
    isbErrorSequence  VARCHAR2,
    iblCreaArchReproc BOOLEAN DEFAULT TRUE)
IS
  ------------------------------------------------------------------------
  -- Variables:
  fdFile UTL_FILE.file_type;
  fdLineFile UTL_FILE.file_type;
BEGIN
  ut_trace.trace ('INICIO PROCESO:[ProcessHSTSS]ccc', 2);
  pkErrors.Push ('DL_BOPARAMETRIZACION.FlushErrors');
  IF (gtbrcError.FIRST IS NULL) THEN
    pkgeneralservices.tracedata ('No Hubo Errores');
    pkErrors.Pop;
    RETURN;
  END IF;
  CreateErrorsFile (isbFileName, isbErrorSequence, iblCreaArchReproc);
  -- Si el nombre del archivo de error no es nulo
  IF (gsbErrorFileName IS NOT NULL) THEN
    fdFile             := pkUtlFileMgr.Fopen (gsbPathFile, gsbErrorFileName,
    'a');
  END IF;
  -- Si el nombre del archivo de reprocesamiento no es nulo
  IF (gsbReproFileName IS NOT NULL) THEN
    fdLineFile         := pkUtlFileMgr.Fopen (gsbPathFile, gsbReproFileName,
    'a');
  END IF;
  FOR indx IN gtbrcError.FIRST .. gtbrcError.LAST
  LOOP
    -- Si el nombre del archivo de error no es nulo
    IF (gsbErrorFileName IS NOT NULL) THEN
      --Adiciona al archivo de inconsistencias el error y la linea del error
      pkUtlFileMgr.Put_Line ( fdFile, gtbrcError (indx).Line_Number || ' | ' ||
      gtbrcError (indx).Error);
    END IF;
    -- Si el nombre del archivo de reprocesamiento no es nulo
    IF (gsbReproFileName IS NOT NULL) THEN
      -- Adiciona en el archivo de reproceso de error la linea
      pkUtlFileMgr.Put_Line (fdLineFile, gtbrcError (indx).Line);
    END IF;
  END LOOP;
  pkUtlFileMgr.fclose (fdFile);
  pkUtlFileMgr.fclose (fdLineFile);
  -- Borra la información de las colecciones.
  gtbrcError := gtbrcError_EMPTY;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END FlushErrors;
PROCEDURE insertError(
    isbTableName     VARCHAR2,
    isbRowId         VARCHAR2,
    isbErrorSequence VARCHAR2)
IS
  ------------------------------------------------------------------------
  -- Variables:
  sbExecute VARCHAR(8000);
BEGIN
  pkErrors.Push ('DL_BOPARAMETRIZACION.insertError');
  sbExecute            :='';
  IF (gtbrcError.FIRST IS NULL) THEN
    pkgeneralservices.tracedata ('No Hubo Errores');
    pkErrors.Pop;
    RETURN;
  END IF;
  FOR indx IN gtbrcError.FIRST .. gtbrcError.LAST
  LOOP
    -- Si el nombre del archivo de error no es nulo
    IF (gsbErrorFileName IS NOT NULL) THEN
      --Adiciona a la tabla CSE_ERROR_PROCESS de inconsistencias el error y la
      -- linea del error
      sbExecute:='INSERT INTO CSE_ERROR_PROCESS (ERROR_ID,PROCESS_NAME,LINE_NUMBER, TABLE_NAME,ROW_ID, MESSAGE_ERROR, DATE_ERROR) VALUES (PKGENERALSERVICES.fnugetnextsequenceval('||chr(39)||'SEQ_CSE_ERROR_PROCESS'||chr(39)||'),'||chr(39)||gsbProcessTrack||chr(39)||','||gtbrcError(indx).Line_Number||','||chr(39)||isbTableName||chr(39)||','||chr(39)||isbRowId||chr(39)||','||chr(39)||gtbrcError(indx).Error||chr(39)||', SYSDATE)';
      EXECUTE IMMEDIATE sbExecute;
      commit;
    END IF;
  END LOOP;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END insertError;
/******************************************************************
Propiedad intelectual de Open Systems (c).
Unidad  : Processfile
Descripcion : Procesa el archivo para extraer datos de una tabla basica
Parámetros   Descripción
============    ===================
irctbDatosTablas  in  Bloque de datos
isbPath           in  Directorio donde esta el archivo con la lista de tablas,
Retorno
============
Autor  : Leonardo Garcia .
Fecha  : 11/04/2010
Historia de Modificaciones
Fecha           Autor               Modificacion
===========     =================== ====================
*********************************************************************/
PROCEDURE Processfile(
    isbNombreTabla VARCHAR2,
    isbCondicion   VARCHAR2,
    isbPath        VARCHAR2,
    isbModo        VARCHAR2,
    orctbSentencias OUT tyrcResSent)
IS
  nuIdx NUMBER;
  -- Constantes
  cnuLimit CONSTANT NUMBER := 100;
  rctbDatosTablas tyrcResSent;
  ------------------------------------------------------------------------
  --          METODOS ENCAPSULADOS                                      --
  ------------------------------------------------------------------------
PROCEDURE Put_line(
    irctbFields tyrcFields,
    isbResSentence VARCHAR2,
    isbTabla       VARCHAR2,
    inumLinea      NUMBER,
    isbModo        VARCHAR2)
IS
  tbString ut_string.TyTb_String;
  sbCampos VARCHAR2 (3000)  := NULL;
  sbDatos  VARCHAR2 (32000) := NULL;
BEGIN
  pkerrors.push ('Processfile.Put_line');
  -- Pasa la cadena de resultado a una tabla
  ut_string.ExtString (isbResSentence, '|', tbString);
  IF (tbString.FIRST IS NULL) THEN
    pkgeneralservices.tracedata ('No obtuvo registros la consulta');
    pkErrors.pop;
    RETURN;
  END IF;
  -- Recorre la tabla de resultado
  FOR nuIdx IN irctbFields.tbField_name.FIRST .. irctbFields.tbField_name.LAST
  LOOP
    --{
    sbCampos := sbCampos || irctbFields.tbField_name (nuidx) || '|';
    --}
  END LOOP;
  FOR nuIdx IN tbString.FIRST .. tbString.LAST
  LOOP
    --{
    -- Si es a ultima posicion no le añade | al final
    IF nuIdx   = tbString.LAST THEN
      sbDatos := sbDatos || tbString (nuIdx);
    ELSE
      sbDatos := sbDatos || tbString (nuIdx) || '|';
    END IF;
    --ut_trace.trace('PPP sbDatos:'||sbDatos,2);
    --}
  END LOOP;
  rctbDatosTablas.tbNombreTabla ( NVL (rctbDatosTablas.tbNombreTabla.LAST, 0) +
  1)                                                                     := REPLACE (isbTabla, csbODLTEMP_, '');
  rctbDatosTablas.tbCampos ( NVL (rctbDatosTablas.tbCampos.LAST, 0) + 1) :=
  sbCampos;
  rctbDatosTablas.tbDatos (NVL (rctbDatosTablas.tbDatos.LAST, 0) + 1) :=
  inumLinea || '|' || sbDatos;
  rctbDatosTablas.tbModo (NVL (rctbDatosTablas.tbModo.LAST, 0) + 1) := isbModo;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END put_line;
--------------------------------------------------------------------------------
PROCEDURE ProcessTable(
    isbPath  VARCHAR2,
    isbSent  VARCHAR2,
    isbTable VARCHAR2,
    irctbFields IN tyrcFields,
    isbModo VARCHAR2)
IS
  tbResSent tytbResSent;
  sbProcess clob;
  nuIdxResSent BINARY_INTEGER;
  tbCampos ut_string.TyTb_String;
  nuConfigExprId NUMBER;
  sbExpression   clob;
  sbSent         clob;
BEGIN
  pkerrors.push ('Processfile.ProcessTable');
  --sbSent := replace(isbSent, isbTable, csbODLTEMP_||isbTable);
  sbSent := isbSent;
  --ut_trace.trace('PPP isbSent:'||isbSent,2);
  --ut_trace.trace('PPP isbSent:'||sbSent,2);
  EXECUTE IMMEDIATE sbSent BULK COLLECT INTO tbResSent;
  --ut_trace.trace('PPP isbSent:'||sbSent,2);
  IF tbResSent.FIRST IS NULL THEN
    --ut_trace.trace('PPP tbResSent NO tenia datos',2);
    pkErrors.pop;
    RETURN;
  END IF;
  --ut_trace.trace('PPP tbResSent tenia datos',2);
  FOR nuidx IN tbResSent.FIRST .. tbResSent.LAST
  LOOP
    Put_line (irctbFields, tbResSent (nuIdx), isbTable, nuidx, isbModo);
  END LOOP;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END ProcessTable;
------------------------------------------------------------------------------------------------
PROCEDURE GetTableFields(
    isbTableName VARCHAR2,
    orctbFields OUT NOCOPY tyrcFields)
IS
  CURSOR cuFields
  IS
    SELECT
      column_name,
      data_type
    FROM
      user_tab_COLUMNS
    WHERE
      table_name = UPPER (isbTableName)
    ORDER BY
      column_id;
  CURSOR cuFieldsStandard
  IS
    SELECT
      column_name,
      data_type
    FROM
      user_tab_COLUMNS
    WHERE
      table_name       = UPPER (isbTableName)
    AND DATA_TYPE NOT IN ('SDO_GEOMETRY','BLOB', 'CLOB')
    ORDER BY
      column_id;
  tbColumn_name tytbFields;
  tbData_type tytbFields;
BEGIN
  pkerrors.push ('Processfile.GetTableFields');
  IF (cuFields%ISOPEN) THEN
    pkErrors.pop;
    CLOSE cuFields;
  END IF;
  IF (cuFieldsStandard%ISOPEN) THEN
    pkErrors.pop;
    CLOSE cuFieldsStandard;
  END IF;
  IF fnuGetOracleEdition = 1 THEN
    OPEN cuFields;
    FETCH
      cuFields BULK COLLECT
    INTO
      tbColumn_name,
      tbData_type;
    CLOSE cuFields;
  ELSE
    OPEN cuFieldsStandard;
    FETCH
      cuFieldsStandard BULK COLLECT
    INTO
      tbColumn_name,
      tbData_type;
    CLOSE cuFieldsStandard;
  END IF;
  orctbFields.tbfield_name := tbColumn_name;
  orctbFields.tbdata_type  := tbData_type;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END GetTableFields;
------------------------------------------------------------------------------------------------
PROCEDURE GetSentence(
    isbTableName VARCHAR2,
    isbCondicion VARCHAR2,
    orctbFields OUT NOCOPY tyrcFields,
    osbSentence OUT VARCHAR2)
IS
  sbSelect         clob;
  sbFrom           clob;
  sbCampo          clob;
  sbCondicion      clob;
  sbtabletoprocess clob;
BEGIN
  pkerrors.push ('ProcessFile.GetSentence');
  pkgeneralservices.tracedata ('ProcessFile.GetSentence');
  -- Obtener campos de la tabla
  GetTableFields (isbTableName, orctbFields);
  IF (orctbFields.tbfield_name.FIRST IS NULL) THEN
    pkErrors.pop;
    osbSentence := NULL;
    RETURN;
  END IF;
  sbSelect := 'SELECT ';
  -- Arma sentencia select con los campos de la tabla
  FOR nuIdx IN orctbFields.tbfield_name.FIRST .. orctbFields.tbfield_name.LAST
  LOOP
    --{
    sbCampo        := orctbFields.tbfield_name (nuIdx);
    IF isbTableName = 'ODLTMP_GR_CONFIG_EXPRESSION' AND sbCampo IN ('CODE')
      THEN
      sbSelect        := sbSelect || 'NULL';
    ELSIF isbTableName = 'ODLTMP_GR_CONFIG_EXPRESSION' AND sbCampo IN (
      'EXPRESSION') THEN
      sbSelect                          := sbSelect || 'NULL ||' || '''|''' || '||';
    ELSIF (sbCampo                       = 'SHAPE' OR sbCampo = 'CURRENT_POSITION') AND
      orctbFields.tbfield_name.LAST      = nuidx THEN
      sbSelect                          := sbSelect || 'NULL';
    ELSIF (sbCampo                       = 'SHAPE' OR sbCampo = 'CURRENT_POSITION')
      AND orctbFields.tbfield_name.LAST != nuidx THEN
      sbSelect                          := sbSelect || 'NULL' || '||' ||
      '''|''' || '||';
    ELSIF (orctbFields.tbData_type (nuIdx) = 'BLOB') AND
      orctbFields.tbfield_name.LAST       != nuidx THEN
      sbSelect                            := sbSelect || '''1''' || '||' ||
      '''|''' || '||';
    ELSIF (orctbFields.tbData_type (nuIdx) = 'BLOB') AND
      orctbFields.tbfield_name.LAST        = nuidx THEN
      sbSelect                            := sbSelect || '''1''' || '||' ||
      '''|''';
    ELSE
      IF (orctbFields.tbData_type (nuIdx) = 'VARCHAR2') THEN
        sbCampo                          := 'replace(' || sbCampo || ',''|'',''&'')';
      END IF;
      IF (orctbFields.tbfield_name.LAST = nuidx) THEN
        sbSelect                       := sbSelect || sbCampo;
      ELSE
        sbSelect := sbSelect || sbCampo || '||' || '''|''' || '||';
      END IF;
    END IF;
    --}
  END LOOP;
  -- Arma el from de la sentencia
  sbFrom           := ' FROM ' || isbTableName;
  sbtabletoprocess := REPLACE (isbTableName, csbODLTEMP_, '');
  sbCondicion      := REPLACE (UPPER (isbCondicion), UPPER (sbtabletoprocess),
  UPPER (isbTableName));
  osbSentence := sbSelect || sbFrom || ' ' || sbCondicion;
  pkgeneralservices.tracedata ('Sentencia a ejecutar: ');
  pkgeneralservices.tracedata (osbSentence);
  pkgeneralservices.tracedata (osbSentence);
  ut_trace.trace ('Sentencia a Ejecutar: '||osbSentence,1);
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END GetSentence;
------------------------------------------------------------------------------------------------
PROCEDURE GetTableData(
    isbTableName VARCHAR2,
    isbCondicion VARCHAR2,
    isbModo      VARCHAR2)
IS
  sbSentencia VARCHAR2 (32000);
  rctbFields tyrcFields;
  sbCondicion      VARCHAR2 (32000);
  sbtabletoprocess VARCHAR2 (200);
BEGIN
  pkerrors.push ('ExtraerTablas.Processfile.GetTableData');
  sbtabletoprocess := REPLACE (isbTableName, csbODLTEMP_, '');
  sbCondicion      := REPLACE (UPPER (isbCondicion), UPPER (sbtabletoprocess),
  UPPER (isbTableName));
  -- Obtener Sentencia a ejecutar
  GetSentence (isbTableName, isbCondicion, rctbFields, sbSentencia);
  IF sbSentencia IS NULL THEN
    pkErrors.pop;
    pkErrors.setErrorCode (-1);
    pkErrors.setErrorMessage ('No encontro la tabla ' || isbTableName);
    RAISE LOGIN_DENIED;
  END IF;
  -- Ejecutar sentencia
  ProcessTable (isbPath, sbSentencia, isbTableName, rctbFields, isbModo);
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END GetTableData;
------------------------------------------------------------------------------------------------
PROCEDURE Process(
    isbnombtabla VARCHAR2,
    isbCondicion VARCHAR2,
    isbModo      VARCHAR2)
IS
BEGIN
  pkerrors.push ('ExtraerTablas.Processfile.process');
  -- Si no hay mas tablas se sale
  IF (isbnombtabla IS NULL) THEN
    pkErrors.pop;
    RETURN;
  ELSE
    pkgeneralservices.tracedata ('---------------------------');
    pkgeneralservices.tracedata ('Nomb tabla ' || isbnombtabla);
    GetTableData (isbnombtabla, isbCondicion, isbModo);
  END IF;
  pkErrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END process;
----------------------------------------------------------------------------
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.Processfile');
  IF (isbNombreTabla IS NULL) THEN
    pkErrors.pop;
    pkgeneralservices.tracedata ('no hay registros');
    RETURN;
  END IF;
  Process (isbNombreTabla, isbcondicion, isbModo);
  -- Asigna las tablas de memoria
  orctbSentencias := rctbDatosTablas;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END Processfile;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   GenZipFile
Descripción :   Genera zip
Autor       :   Leonardo Garcia Q.
Fecha       :   22-08-2008 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE GenZipFile(
    isbNombZip VARCHAR2,
    isbPath    VARCHAR2,
    itbsbNombArch tytbVarFields)
IS
  sbZipCommand   VARCHAR2 (200);
  sbZipListfiles VARCHAR2 (3000);
  sbIdx          VARCHAR2 (50);
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.GenZipFile');
  -- Si no existen registros se sale
  IF (itbsbNombArch.FIRST IS NULL) THEN
    pkErrors.pop;
    RETURN;
  END IF;
  -- Si existe un solo registro no es necesario generar un zip
  IF (itbsbNombArch.COUNT <= 1) THEN
    pkErrors.pop;
    RETURN;
  END IF;
  -- Asigna commandos a ejecutar
  sbZipCommand := 'zip -m -j ' || isbPath || '/' || isbNombZip || ' ';
  sbIdx        := itbsbNombArch.FIRST;
  LOOP
    EXIT
  WHEN sbIdx         IS NULL;
    IF (sbIdx         = itbsbNombArch.LAST) THEN
      sbZipListfiles := sbZipListfiles || isbPath || '/' || itbsbNombArch (
      sbIdx);
    ELSE
      sbZipListfiles := sbZipListfiles || isbPath || '/' || itbsbNombArch (
      sbIdx) || ' ';
    END IF;
    sbIdx := itbsbNombArch.NEXT (sbIdx);
  END LOOP;
  pkgeneralservices.tracedata ( 'Commando: ' || sbZipCommand || sbZipListfiles)
  ;
  llamasist (sbZipCommand || sbZipListfiles);
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END GenZipFile;
/******************************************************************
Propiedad intelectual de Open Systems (c).
Unidad  : ExtraerTablasPorArchivo
Descripcion : Extrae los datos de las tablas de la base de datos que se le
especifiquen en un archivo.
Parámetros   Descripción
============    ===================
isbPath         in  Directorio donde esta el archivo con la lista de tablas,
isbNombArchivo  in  Nombre del archivo con la lista de tablas a extraer,
onuErrorCode       Código de error
osbErrorText       Mensaje de error
Retorno
============
onuSubscriberId    Id del subscriptor
Autor  : Leonardo Garcia .
Fecha  : 11/04/2006
Historia de Modificaciones
Fecha           Autor               Modificacion
===========     =================== ====================
*********************************************************************/
PROCEDURE ExtraerTablas(
    isbPath               IN VARCHAR2,
    isbNombArchivo        IN VARCHAR2,
    isbDB_LINK            IN VARCHAR2,
    isbErrorSequence      IN VARCHAR2 DEFAULT NULL,
    iblGetDataFromOtherDB IN BOOLEAN DEFAULT FALSE)
IS
  -- Constantes
  CNUEOF CONSTANT NUMBER := 1;
  -- Variables
  rctbTablas tytbrcBloqueTablas;
  rctbSentaEjecDest DL_BOPARAMETRIZACION.tyrcResSent;
  gblCreaArchivo    BOOLEAN;
  gnuIdx            NUMBER;
  nuRegProcesados   NUMBER := 0;
  sbIdx             VARCHAR2 (50);
  sbCondicionMirror VARCHAR2 (200);
  --------------- METODOS ENCAPSULADOS --------------------------
PROCEDURE ClearMemory
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.ExtraerTablas.ClearMemory');
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END ClearMemory;
------------------------------------------------------------------------------------------------
PROCEDURE GetTables(
    isbPath        VARCHAR2,
    isbNombArchivo VARCHAR2,
    orctbTablas OUT NOCOPY tytbrcBloqueTablas)
IS
  fdarchivo UTL_FILE.FILE_TYPE;
  nuEof   NUMBER := 0;
  sblinea VARCHAR2 (500);
  tbString ut_string.TyTb_String;
  nuidx NUMBER;
  -----CONSULTA TABLAS DE PARAMETRIZACION
  CURSOR cuTables
  IS
    SELECT
      CTL.TABLEV_TABLENAME,
      CTL.TABLEV_CONDITION,
      CTL.TABLEV_ACTION
    FROM
      CSE_TABLE_LEVEL CTL
    WHERE
      CTL.TABLEV_PARAM = 'S'
    AND EXISTS
      (
        SELECT
          'x'
        FROM
          dba_tables DTB
        WHERE
          DTB.table_name = CTL.TABLEV_TABLENAME
      )
  ORDER BY
    CTL.TABLEV_LEVEL ASC;
  --------------- METODOS ENCAPSULADOS --------------------------
PROCEDURE GetFileFields(
    inuIdx   NUMBER,
    isbLinea VARCHAR2)
IS
BEGIN
  pkerrors.push ('ExtraerTablas.GetTables.GetFileFields');
  ut_string.ExtString (isbLinea, '|', tbString);
  orctbTablas.tbnombre (nuIdx)    := tbString (1);
  orctbTablas.tbcondicion (nuIdx) := tbString (2);
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END GetFileFields;
-------------------------------------------------------------------------------
BEGIN
  pkerrors.push ('ExtraerTablas.GetTables');
  IF cuTables%ISOPEN THEN
    CLOSE cuTables;
  END IF;
  nuIdx := 1;
  FOR rec IN cuTables
  LOOP
    orctbTablas.tbnombre (nuIdx)    := REC.TABLEV_TABLENAME;
    orctbTablas.tbcondicion (nuIdx) := REC.TABLEV_CONDITION;
    orctbTablas.tbModo (nuIdx)      := REC.TABLEV_ACTION;
    nuIdx                           := nuIdx + 1;
  END LOOP;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END GetTables;
------------------------------------------------------------------------------------------------
PROCEDURE ProcessFileFromOtherDB(
    isbNombre    VARCHAR2,
    isbCondicion VARCHAR2,
    isbPath      VARCHAR2,
    isbModo      VARCHAR2)
IS
  sbCadena VARCHAR2 (8000);
  rctbSentaEjecOri DL_BOPARAMETRIZACION.tyrcResSent;
  sbDataBase     VARCHAR2 (100);
  isbTableMirror VARCHAR2 (100);
  sbRecordMirror VARCHAR2 (2000);
  tbLlaves tytbFields;
  sbValoresLlaves VARCHAR2 (2000);
  sb_             VARCHAR2 (2000);
  sbValoresWhere  VARCHAR2 (2000);
  --------------------------------------------------------------------
BEGIN
  pkerrors.push ('ExtraerTablas.ProcessFileFromOtherDB');
  /*ut_trace.init;
  ut_trace.setlevel (99);
  ut_trace.setoutput (ut_trace.fntrace_output_db);
  ut_trace.trace ('INICIO PROCESO:[ProcessFileFromOtherDB]', 2);  */
  sbDataBase := fsbgetDB;
  tbLlaves   := ftbGetPrimaryKeyField (isbNombre);
  FOR nuIdx IN tbLlaves.FIRST .. tbLlaves.LAST
  LOOP
    sbValoresLlaves := sbValoresLlaves || '''''' || tbLlaves (nuIdx) || '='''''
    || '||' || tbLlaves (nuIdx) || '||' || '''''|''''' || '||';
    sbValoresWhere := sbValoresWhere || ' ' || tbLlaves (nuIdx) || ' = mirror.'
    || tbLlaves (nuIdx);
    IF nuIdx         != tbLlaves.LAST THEN
      sbValoresWhere := sbValoresWhere || ' AND ';
    END IF;
  END LOOP;
  sb_ := 'select ' || sbValoresLlaves || 'from ' || sbSchemaCSE||'.MIRR_' || isbNombre;
  sb_ := REPLACE (sb_, '||from ', ' FROM ');
  sb_ := sb_ || ' WHERE ' || sbValoresWhere;
  sbValoresLlaves := substr(sbValoresLlaves,1,length(sbValoresLlaves)-2);
  --crea temporales a partir de la mirror con registros no procesados.
  IF isbCondicion IS NULL THEN
    sbCadena      := ' declare ' || CHR (10) || '   sbSent  varchar2(10000);'
    || CHR (10) || '   sbSentAlter  varchar2(1000);' || CHR (10) || 'begin ' ||
    CHR (10) || '   sbSent := ''Create global temporary table ' || csbODLTEMP_
    || isbNombre || CHR (10) || ' on commit preserve rows AS ' || CHR (10) ||
    '                  SELECT * FROM ' || sbSchemaCSE||'.MIRR_' || isbNombre || ' mirror'
    || CHR (10) ||
    '                  WHERE not exists (select ''''x'''' FROM '||sbSchemaCSE||'.dl_log_process'
    || CHR (10) ||
    '                                      WHERE '||sbSchemaCSE||'.dl_log_process.row_id = '
    || sbValoresLlaves || ' ' ||
    '                                      AND '||sbSchemaCSE||'.dl_log_process.table_name ='
    || '''''' || isbNombre || '''''' || CHR (10) ||
    '                                      AND '||sbSchemaCSE||'.dl_log_process.database_name = '
    || '''''' || sbDataBase || '''''' || CHR (10) ||
    '                                      AND '||sbSchemaCSE||'.dl_log_process.is_process = ''''S'''')'
-- se debe borrar lo comentado por cambio por rendimiento
/*    || CHR (10) ||
    '                          OR exists (select ''''x'''' FROM '||sbSchemaCSE||'.dl_log_process'
    || CHR (10) ||
    '                                      WHERE '||sbSchemaCSE||'.dl_log_process.row_id in ( '
    || sb_ || ')' ||
    '                                      AND '||sbSchemaCSE||'.dl_log_process.table_name ='
    || '''''' || isbNombre || '''''' || CHR (10) ||
    '                                      AND '||sbSchemaCSE||'.dl_log_process.database_name = '
    || '''''' || sbDataBase || '''''' || CHR (10) ||
    '                                      AND '||sbSchemaCSE||'.dl_log_process.is_process = ''''N'''')'*/
    || ''';' || CHR (10) || '   execute immediate sbSent;' || CHR (10) ||
    'end;';
  ELSE
    sbCondicionMirror := REPLACE (isbCondicion, LOWER (isbNombre), 'mirror');
    sbCadena          := ' declare ' || CHR (10) ||
    '   sbSent  varchar2(10000);' || CHR (10) ||
    '   sbSentAlter  varchar2(1000);' || CHR (10) || 'begin ' || CHR (10) ||
    '   sbSent := ''Create global temporary table ' || csbODLTEMP_ || isbNombre
    || CHR (10) || ' on commit preserve rows AS ' || CHR (10) ||
    '                  SELECT * FROM ' || sbSchemaCSE||'.MIRR_' || isbNombre ||
    ' mirror ' || sbCondicionMirror || CHR (10) ||
    '                  AND not exists (select ''''x'''' FROM '||sbSchemaCSE||'.dl_log_process'
    || CHR (10) ||
    '                                      WHERE '||sbSchemaCSE||'.dl_log_process.row_id = '
    || sbValoresLlaves || ' ' ||
    '                                      AND  '||sbSchemaCSE||'.dl_log_process.table_name ='
    || '''''' || isbNombre || '''''' || CHR (10) ||
    '                                      AND  '||sbSchemaCSE||'.dl_log_process.database_name = '
    || '''''' || sbDataBase || '''''' || CHR (10) ||
    '                                      AND '||sbSchemaCSE||'.dl_log_process.is_process = ''''S'''')'
-- se debe borrar lo comentado por cambio por rendimiento
/*    || CHR (10) ||
    '                          OR exists (select ''''x'''' FROM '||sbSchemaCSE||'.dl_log_process'
    || CHR (10) ||
    '                                      WHERE '||sbSchemaCSE||'.dl_log_process.row_id in ( '
    || sb_ || ')' ||
    '                                      AND '||sbSchemaCSE||'.dl_log_process.table_name ='
    || '''''' || isbNombre || '''''' || CHR (10) ||
    '                                      AND '||sbSchemaCSE||'.dl_log_process.database_name = '
    || '''''' || sbDataBase || '''''' || CHR (10) ||
    '                                      AND '||sbSchemaCSE||'.dl_log_process.is_process = ''''N'''')'*/
    || ''';' || CHR (10) || '   execute immediate sbSent;' || CHR (10) ||
    'end;';
  END IF;
  ut_trace.trace ('PPP sbCadena:' || sbCadena, 2);

  --Mmejia
  --ARA5954
  --Se desactiva la traza
--pkgeneralservices.settracedataon('DB','PASO');
--pkgeneralservices.tracedata('cad: '||sbCadena);
--pkgeneralservices.settracedataoff;
  EXECUTE IMMEDIATE sbCadena;
  ut_trace.trace ('PPP sbCadena ejecutó bien', 2);
  --Inserta el registro antes de procesarlo en dl_process_log con flag en N.
  ut_trace.trace ('Tabla: '||isbNombre, 2);
  ut_trace.trace ('Tabla Temporal: '||csbODLTEMP_ ||isbNombre, 2);
  ProcessFile (csbODLTEMP_||isbNombre, isbCondicion, gsbPathFile, isbModo,
  rctbSentaEjecOri);
  DL_BOPARAMETRIZACION.setSentEjecDest (rctbSentaEjecOri);
  -- Llena archivo de errores, creando el archivo de errores
  insertError (isbNombre,sb_, isbErrorSequence);
  FlushErrors (isbNombArchivo, isbErrorSequence, FALSE);
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END ProcessFileFromOtherDB;
------------------------------------------------------------------------------------------------
PROCEDURE CreateStatusExeProgRecord(
    inuRecNumber NUMBER)
IS
  PRAGMA AUTONOMOUS_TRANSACTION;
  sbEstaprog estaprog.esprprog%TYPE;
BEGIN
  pkErrors.Push (
  'DL_BOPARAMETRIZACION.ExtraerTablas.CreateStatusExeProgRecord');
  -- Adiciona registro
  pkStatusExeProgramMgr.AddRecord (gsbEstaprog, inuRecNumber);
  -- Hace commit
  pkGeneralServices.CommitTransaction;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END CreateStatusExeProgRecord;
---------------------------------------------------------------------------------
PROCEDURE UpStatusProgram(
    inuRecordsNumber NUMBER)
IS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  pkErrors.Push ('DL_BOPARAMETRIZACION.ExtraerTablas.UpStatusProgram');
  -- Notificar avance de proceso.
  pkStatusExeProgramMgr.UpStatusExeProgram (gsbEstaprog, 'Procesando...', NULL,
  inuRecordsNumber);
  pkGeneralServices.CommitTransaction;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END UpStatusProgram;
------------------------------------------------------------------------------------------------
PROCEDURE SetProcessData
IS
  nuPosition NUMBER;
  sbDataBase VARCHAR2 (100);
BEGIN
  pkErrors.Push ('DL_BOPARAMETRIZACION.ExtraerTablas.SetProcessData');
  -- Obtiene id del proceso
  sbDataBase  := fsbgetDB;
  gsbEstaprog := pkStatusExeProgramMgr.fsbGetProgramID ('PPP-');
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END SetProcessData;
------------------------------------------------------------------------------------------------
PROCEDURE DropTempTable(
    isbTempTabla VARCHAR2)
IS
  sbDBLinkSentence VARCHAR2 (100);
BEGIN
  pkerrors.push ( 'DL_BOPARAMETRIZACION.CopiarDatosTablas.DropTempTable');
  BEGIN
    sbDBLinkSentence := 'TRUNCATE TABLE ' || isbTempTabla;
    EXECUTE IMMEDIATE sbDBLinkSentence;
    sbDBLinkSentence := 'DROP TABLE ' || isbTempTabla;
    EXECUTE IMMEDIATE sbDBLinkSentence;
  EXCEPTION
  WHEN OTHERS THEN
    pkgeneralservices.tracedata ( 'Error borrando tabla ' || isbTempTabla);
    NULL;
  END;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END DropTempTable;
------------------------------------------------------------------------------------------------
BEGIN
  pkErrors.push ('DL_BOPARAMETRIZACION.ExtraerTablas');
  ut_trace.trace ('PASO');
  ClearMemory;
  -- Fija en memoria datos del proceso
  SetProcessData;
  gsbPathFile := isbPath;
  -- Obtiene las tablas a extraer
  GetTables (isbPath, isbNombArchivo, rctbTablas);
  ut_trace.trace ('PASO1');
  -- Registra seguimiento del proceso
  CreateStatusExeProgRecord (rctbTablas.tbNombre.COUNT);
  ut_trace.trace ('PASO2');
  -- Si esta vacia la tabla entonces sale del programa
  IF (rctbTablas.tbnombre.FIRST IS NULL) THEN
    pkErrors.pop;
    RETURN;
  END IF;
  gnuidx := rctbTablas.tbNombre.FIRST;
  ut_trace.trace ('PASO3');
  LOOP
    --{
    EXIT
  WHEN gnuIdx IS NULL;
    ut_trace.trace ('PASO4');
    pkgeneralservices.tracedata ('Tabla ' || rctbTablas.tbNombre (gnuidx));
    -- Desabilita los triggers de la tabla
    AlterTriggers (rctbTablas.tbNombre (gnuidx), 'DISABLE');
    AlterTriggersDBLINK (rctbTablas.tbNombre (gnuidx), 'DISABLE');
    ut_trace.trace ('PASO5');
    -- Si se esta ejecutando para obtener los datos de otra B.D.
    IF (NVL (iblGetDataFromOtherDB, FALSE)) THEN
      ut_trace.trace ('PASO6');
      --Borra tabla temporal
      DropTempTable (csbODLTEMP_ || rctbTablas.tbNombre (gnuidx));
      ProcessFileFromOtherDB (rctbTablas.tbNombre (gnuidx),
      rctbTablas.tbCondicion (gnuidx), isbPath, rctbTablas.tbModo (gnuidx));
      ut_trace.trace ('PASO7');
    ELSE
      ut_trace.trace ('PASO8');
      -- Procesa el archivo en la misma B.D
      ProcessFile (rctbTablas.tbNombre (gnuidx), rctbTablas.tbCondicion (gnuidx
      ), rctbTablas.tbModo (gnuidx), isbPath, rctbSentaEjecDest);
      ut_trace.trace ('PASO9');
      -- fija en memoria el registro de tablas resultante
      setSentEjecDest (rctbSentaEjecDest);
      ut_trace.trace ('PASO10');
    END IF;
    pkgeneralservices.tracedata ('ProcessSentaEjecDest');
    --Procesa Resultado
    ProcessSentaEjecDest (isbNombArchivo, ftbGetSentaEjecDest,
    iblGetDataFromOtherDB);
    ut_trace.trace ('PASO11');
    pkgeneralservices.tracedata ('UpStatusProgram');
    nuRegProcesados := nuRegProcesados + 1;
    -- Actualiza el avance del proceso
    UpStatusProgram (nuRegProcesados);
    ut_trace.trace ('PASO12');
    pkgeneralservices.tracedata ('FIN Tabla ' || rctbTablas.tbNombre (gnuidx));
    AlterTriggersDBLINK (rctbTablas.tbNombre (gnuidx), 'ENABLE');
    AlterTriggers (rctbTablas.tbNombre (gnuidx), 'ENABLE');
    ut_trace.trace ('PASO13');
    DropTempTable (csbODLTEMP_ || rctbTablas.tbNombre (gnuidx));
    ut_trace.trace ('PASO14');
    gnuIdx := rctbTablas.tbNombre.NEXT (gnuidx);
  END LOOP;
  ut_trace.trace ('PASO15');
  -- Actualiza a proceso termino
  pkstatusexeprogrammgr.ProcessFinishOK (gsbEstaprog);
  ut_trace.trace ('PASO16');
  pkErrors.pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  AlterTriggersDBLINK (rctbTablas.tbNombre (gnuidx), 'ENABLE');
  AlterTriggers (rctbTablas.tbNombre (gnuidx), 'ENABLE');
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  AlterTriggersDBLINK (rctbTablas.tbNombre (gnuidx), 'ENABLE');
  AlterTriggers (rctbTablas.tbNombre (gnuidx), 'ENABLE');
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  AlterTriggersDBLINK (rctbTablas.tbNombre (gnuidx), 'ENABLE');
  AlterTriggers (rctbTablas.tbNombre (gnuidx), 'ENABLE');
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END ExtraerTablas;
/******************************************************************
Propiedad intelectual de Open Systems (c).
Unidad  : fblExistsDL_LOG_PROCESS
Descripcion : R   evisa si existe el registro en dl_log_process
Parámetros   Descripción
============    ===================
Autor  : Paula Garcia
Fecha  : 09/07/2013
Historia de Modificaciones
Fecha           Autor               Modificacion
===========     =================== ====================
*********************************************************************/
FUNCTION fblExistsDL_LOG_PROCESS(
    isbRow_id   VARCHAR2,
    isbTableName VARCHAR2,
    isbDataBase VARCHAR2)
  RETURN BOOLEAN
IS
  nurow_id  varchar2(4000);
  sbExecute varchar2(4000);
  cuLog_process SYS_REFCURSOR;
BEGIN
    if cuLog_process%isopen then
        close cuLog_process;
    END if;
    sbExecute:='SELECT row_id FROM '||sbSchemaCSE||'.DL_LOG_PROCESS WHERE ROW_ID ='||chr(39)||isbRow_id||chr(39)||' AND TABLE_NAME= '||chr(39)||isbTableName||chr(39)||' AND DATABASE_NAME = '||chr(39)||isbDataBase||chr(39)||' ';
    open cuLog_process for sbExecute;
    fetch cuLog_process INTO nurow_id;
    close cuLog_process;
  IF nurow_id IS null THEN
    RETURN FALSE;
  ELSE
    RETURN TRUE;
  END IF;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END fblExistsDL_LOG_PROCESS;
/******************************************************************
Propiedad intelectual de Open Systems (c).
Unidad  : CargadorTablasPorArchivo
Descripcion : Extrae los datos de las tablas de la base de datos que se le
especifiquen en un archivo.
Parámetros   Descripción
============    ===================
isbFileName         in  Nombre del archivo a cargar. Este nombre debe llevar el
nombre de la tabla destino (ej: cargos.lst)
isbOnlyVal          in  Bandera para saber si esta en modo solo validacion para
no hacer commit.
iblAlteraSecuencia  in  Bandera para saber si se actualiza la secuencia de la
tabla
Autor  : Leonardo Garcia Q.
Fecha  : 11/04/2009
Historia de Modificaciones
Fecha           Autor               Modificacion
===========     =================== ====================
*********************************************************************/
PROCEDURE CargadorTablasPorArchivo(
    isbProcessTrack    IN VARCHAR2,
    isbFileName        IN VARCHAR2,
    isbFilePath        IN VARCHAR2,
    isbOnlyVal         IN VARCHAR2,
    isbAlteraSecuencia IN VARCHAR2,
    inuNumeroHilo      IN NUMBER,
    inuNumeroHilos     IN NUMBER,
    isbModo            IN VARCHAR2 DEFAULT fsbGetInsertMode)
IS
  -- Constantes
  cnuLimit     CONSTANT NUMBER := 100;
  gsbDirectory VARCHAR2 (200)  := 'DI_ODL_'; -- Nombre del directorio.
  -- Variables
  grctbTablas tyrctbTablas;
  gsbFecha VARCHAR2 (20);
  -- Tabla externa:
  gsbFileName          VARCHAR2 (200); -- Nombre del archivo a cargar.
  gsbExternalTableName VARCHAR2 (200); -- Nombre de la tabla externa.
  gsbTableName         VARCHAR2 (200); -- Nombre de la tabla a insertar datos
  --    isbProcessId    varchar2(100);
  sbErrMsg        VARCHAR2 (2000);
  onuErrorCode    NUMBER;
  osbErrorMessage VARCHAR2 (2000);
  sbErrorSequence VARCHAR2 (50);
  /****************************************************************************
  ***
  Propiedad intelectual de Open International Systems (c).
  Procedure   :   DropDirectory
  Drop Directory.
  Descripción :   Borra el directorio.
  Autor       :   Leonardo Garcia
  Fecha       :   20-11-2008 16:28:44
  Historia de Modificaciones
  Fecha       IDEntrega
  20-11-2010  lgarciaSAOXXXX
  Creación.
  *****************************************************************************
  **/
PROCEDURE DropDirectory
IS
  ----------------------------------------------------------------------------
  -- Variables:
  sbSentence VARCHAR2 (4000) := NULL; -- Sentencia creación del directorio.
BEGIN
  --{
  pkErrors.Push ( 'DL_BOPARAMETRIZACION.CargTablasPorArch..DropDirectory');
  -- Construir sentencia de borrado de directorio.
  sbSentence := 'DROP DIRECTORY ' || gsbDirectory;
  BEGIN
    -- Ejecuta el borrado del directorio
    EXECUTE IMMEDIATE sbSentence;
  EXCEPTION
  WHEN OTHERS THEN
    NULL;
  END;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END DropDirectory;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   DropExtTable
Descripción :   Borrar tabla externa.
Autor       :   Leonardo Garcia Q
Fecha       :   22-08-2009 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE DropExtTable
IS
BEGIN
  --{
  pkErrors.Push ( 'DL_BOPARAMETRIZACION.CargTablasPorArch.DropExtTable');
  -- En caso que exista la tabla externa, se elimina.
  BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ' || gsbExternalTableName;
  EXCEPTION
  WHEN OTHERS THEN
    NULL;
  END;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END DropExtTable;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   fsbGetColumns
Descripción :   Adiciona las comillas al string para ejecutar el query
al catalogo de oracle
Autor       :   Leonardo Garcia Q
Fecha       :   22-08-2009 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
FUNCTION fsbGetColumns(
    isbString VARCHAR2)
  RETURN VARCHAR2
IS
  sbColumns VARCHAR2 (2000);
BEGIN
  --{
  pkErrors.Push ('DL_BOPARAMETRIZACION.CargTablasPorArch.fsbGetColumns');
  sbColumns := sbColumns || '''' || UPPER (isbString) || '''';
  pkErrors.Pop;
  RETURN sbColumns;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END fsbGetColumns;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   GetColumnsAndFields
Get Fields And Columns
Descripción :   Obtiene los campos de la tabla y las columnas del
archivo.
________________________________________________________________________
Retorno     |   Descripción
____________|___________________________________________________________
osbColumns  |   Columnas del archivo.
osbFields   |   Campos de la tabla externa.
____________|___________________________________________________________
Autor       :   Leonardo Garcia Q.
Fecha       :   22-08-2008 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE GetColumnsAndFields(
    isbTableName IN VARCHAR2,
    osbColumns OUT VARCHAR2,
    osbFields IN OUT VARCHAR2)
IS
  CURSOR cuFields
  IS
    SELECT
      column_name,
      data_type,
      data_length,
      data_precision,
      data_scale
    FROM
      user_tab_COLUMNS
    WHERE
      table_name = UPPER (isbTableName);
  CURSOR cuFieldsStandard
  IS
    SELECT
      column_name,
      data_type,
      data_length,
      data_precision,
      data_scale
    FROM
      user_tab_COLUMNS
    WHERE
      table_name       = UPPER (isbTableName)
    AND data_type NOT IN ('SDO_GEOMETRY','BLOB', 'CLOB');
  sbCursor VARCHAR2 (3000);
  tbString ut_string.TyTb_String;
  rcTablas tyrcTablas;
BEGIN
  --{
  pkErrors.Push ( 'DL_BOPARAMETRIZACION.CargTablasPorArch.GetColumnsAndFields')
  ;
  grctbTablas := NULL;
  -- Evalua si el cursor esta abierto
  IF (cuFields%ISOPEN) THEN
    pkErrors.pop;
    CLOSE cuFields;
  END IF;
  IF (cuFieldsStandard%ISOPEN) THEN
    pkErrors.pop;
    CLOSE cuFieldsStandard;
  END IF;
  -- Obtiene los campos del catalogo de oracle.
  IF fnuGetOracleEdition = 1 THEN
    OPEN cuFields;
    FETCH
      cuFields BULK COLLECT
    INTO
      grctbTablas.tbcolumn_name,
      grctbTablas.tbdata_type,
      grctbTablas.tbdata_length,
      grctbTablas.tbdata_precision,
      grctbTablas.tbdata_scale;
    CLOSE cuFields;
  ELSE
    OPEN cuFieldsStandard;
    FETCH
      cuFieldsStandard BULK COLLECT
    INTO
      grctbTablas.tbcolumn_name,
      grctbTablas.tbdata_type,
      grctbTablas.tbdata_length,
      grctbTablas.tbdata_precision,
      grctbTablas.tbdata_scale;
    CLOSE cuFieldsStandard;
  END IF;
  -- Fija en memoria las columnas originales de la tabla para utilizarla
  -- en la insercion
  setTableField (grctbTablas.tbcolumn_name);
  -- Evalua si ya vienen los campos predeterminados del archivo
  IF (osbFields IS NOT NULL) THEN
    -- Limpia tablas pues vienen desde el archivo
    grctbTablas := NULL;
    -- Pasa la cadena de resultado a una tabla
    ut_string.ExtString (osbFields, ',', tbString);
    FOR nuIdx IN tbString.FIRST .. tbString.LAST
    LOOP
      -- Si es un campo dummy
      IF (INSTR (UPPER (tbString (nuIdx)), csbDUMMY_) != 0) THEN
        grctbTablas.tbcolumn_name (NVL (grctbTablas.tbcolumn_name.LAST, 0) + 1)
                                                                             := tbString (nuIdx);
        grctbTablas.tbdata_type ( NVL (grctbTablas.tbdata_type.LAST, 0) + 1) :=
        'VARCHAR2';
        grctbTablas.tbdata_length ( NVL (grctbTablas.tbdata_length.LAST, 0) + 1
        ) := 2000;
        grctbTablas.tbdata_precision ( NVL (grctbTablas.tbdata_precision.LAST,
        0)                                                               + 1) := NULL;
        grctbTablas.tbdata_scale (NVL (grctbTablas.tbdata_scale.LAST, 0) + 1)
        := NULL;
      ELSE
        -- Es un campo de la base de datos
        rcTablas := NULL;
        -- Arma cursor con los campos especificos
        sbCursor :=
        'SELECT column_name,data_type,data_length,data_precision,data_scale '
        || 'from user_tab_COLUMNS ' || 'where table_name = upper(''' ||
        isbTableName || ''')' || 'and column_name in (' || fsbGetColumns (
        tbString (nuIdx)) || ')';
        BEGIN
          EXECUTE IMMEDIATE sbCursor INTO rcTablas.column_name,
          rcTablas.data_type,
          rcTablas.data_length,
          rcTablas.data_precision,
          rcTablas.data_scale;
        EXCEPTION
        WHEN OTHERS THEN
          IF (rcTablas.column_name IS NULL) THEN
            pkErrors.SetErrorMessage ( 'El campo: ' || tbString (nuIdx) ||
            ' o la tabla ' || isbTableName || ' no existe');
            RAISE LOGIN_DENIED;
          END IF;
        END;
        grctbTablas.tbcolumn_name (NVL(grctbTablas.tbcolumn_name.LAST, 0) + 1)
                                                                           := rcTablas.column_name;
        grctbTablas.tbdata_type (NVL(grctbTablas.tbdata_type.LAST, 0) + 1) :=
        rcTablas.data_type;
        grctbTablas.tbdata_length (NVL(grctbTablas.tbdata_length.LAST, 0) + 1)
        := rcTablas.data_length;
        grctbTablas.tbdata_precision (NVL(grctbTablas.tbdata_precision.LAST, 0)
                                                                        + 1) :=rcTablas.data_precision;
        grctbTablas.tbdata_scale (NVL(grctbTablas.tbdata_scale.LAST, 0) + 1) :=
        rcTablas.data_scale;
      END IF;
    END LOOP;
  END IF;
  IF (grctbTablas.tbcolumn_name.FIRST IS NULL) THEN
    pkErrors.pop;
    RETURN;
  END IF;
  -- Borra el campo de salida
  osbFields := NULL;
  --Asigna el primer campo de numero de linea para crear la tabla externa
  osbFields := 'NUM_LINEA varchar(2000)';
  FOR nuIdx IN grctbTablas.tbcolumn_name.FIRST ..
  grctbTablas.tbcolumn_name.LAST
  LOOP
    -- Si no es el primer campo adiciona coma
    IF (osbFields IS NOT NULL) THEN
      osbFields   := osbFields || ', ' || CHR (13);
    END IF;
    IF (grctbTablas.tbdata_type (nuIdx) = 'VARCHAR2') THEN
      osbFields                        := osbFields ||
      grctbTablas.tbcolumn_name (nuIdx) || ' ' || grctbTablas.tbdata_type (
      nuIdx) || '(' || --grctbTablas.tbdata_length(nuIdx)||')'; se deja fijo
      -- varchar2(1000) porque en el primer registro vienen
      -- los nombres de los campos
      '2000)';
    ELSIF (grctbTablas.tbdata_type (nuIdx) = 'CHAR') THEN
      osbFields                           := osbFields ||
      grctbTablas.tbcolumn_name (nuIdx) || ' ' || grctbTablas.tbdata_type (
      nuIdx) || '(' || grctbTablas.tbdata_length (nuIdx) || ')';
    ELSIF (grctbTablas.tbdata_type (nuIdx) = 'DATE') THEN
      osbFields                           := osbFields ||
      grctbTablas.tbcolumn_name (nuIdx) || ' ' || 'VARCHAR2(2000)';
    ELSIF (grctbTablas.tbdata_type (nuIdx) = 'NUMBER') THEN
      -- los numericos se crean como varchar2 de 2000
      osbFields := osbFields || grctbTablas.tbcolumn_name (nuIdx) || ' ' ||
      'VARCHAR2(2000)';
      grctbTablas.tbdata_type (nuIdx)     := 'VARCHAR2';
    ELSIF (grctbTablas.tbdata_type (nuIdx) = 'SDO_GEOMETRY') THEN
      osbFields                           := osbFields ||
      grctbTablas.tbcolumn_name (nuIdx) || ' ' || 'VARCHAR2(2000)';
    END IF;
  END LOOP;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END GetColumnsAndFields;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   CreateExternalTable
Create External Table
Descripción :   Crea la tabla externa.
Autor       :   Leonardo Garcia Q.
Fecha       :   22-08-2008 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE CreateExternalTable(
    isbProcessId VARCHAR2,
    inuNumHilo   NUMBER)
IS
  ------------------------------------------------------------------------
  -- Variables:
  sbColumns  VARCHAR2 (4000) := NULL; -- Columnas del archivo.
  sbFields   VARCHAR2 (4000) := NULL; -- Campos de la tabla externa.
  sbFileName VARCHAR2 (200);
  nuPosition NUMBER;
  -- Sentencia para la creación de la tabla externa.
  sbSentence VARCHAR2 (4000) := NULL;
BEGIN
  --{
  pkErrors.Push ( 'DL_BOPARAMETRIZACION.CargTablasPorArch.CreateExternalTable')
  ;
  -- Si en el archivo o en memoria viene en la primera linea los nombres de los
  -- campos.
  -- los obtiene
  sbFields := fsbGetFieldsFromfile (isbProcessId, gsbPathFile, gsbFileName);
  -- Obtiene los campos de la tabla y las columnas del archivo.
  GetColumnsAndFields (gsbTableName, sbColumns, sbFields);
  -- Si es llamado desde el cargador de datos desde otra base
  IF isbProcessId IS NULL THEN
    pkErrors.pop;
    RETURN;
  END IF;
  gsbExternalTableName := 'ext_' || gsbTableName || '_' || inuNumHilo;
  -- En caso que exista la tabla externa, se elimina.
  DropExtTable;
  sbFileName := sbFileName || gsbFecha;
  -- Se arma la sentencia de la creación de la tabla externa.
  sbSentence := 'CREATE TABLE ' || gsbExternalTableName || CHR (13) || '(' ||
  CHR (13) || sbFields || CHR (13) || ')' || CHR (13) ||
  'ORGANIZATION EXTERNAL' || CHR (13) || '(   TYPE ORACLE_LOADER' || CHR (13)
  || '    DEFAULT DIRECTORY ' || gsbDirectory || CHR (13) ||
  '    ACCESS PARAMETERS' || CHR (13) || '    (   RECORDS DELIMITED BY NEWLINE'
  || CHR (13) || '        BADFILE ''' || '.' || sbFileName || '.bad''' || CHR (
  13) || '        LOGFILE ''' || '.' || sbFileName || '.log''' || CHR (13) ||
  '        FIELDS TERMINATED BY ''|''' || CHR (13) ||
  '        MISSING FIELD VALUES ARE NULL' || CHR (13) || '    )' || CHR (13) ||
  '    LOCATION (''' || gsbFileName || ''')' || CHR (13) || ') ';
  pkgeneralservices.tracedata (sbSentence);
  -- Se crea la tabla externa.
  EXECUTE IMMEDIATE sbSentence;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END CreateExternalTable;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   SetEnvironmentData
Set Table Data.
Descripción :   Establece los datos para la creación de la tabla.
____________________________________________________________________________
Parámetros      |   Descripción
________________|___________________________________________________________
isbProcessId    |   Identificador del proceso.
isbFileName     |   Nombre del archivo.
________________|___________________________________________________________
Autor       :   Leonardo Garcia Q.
Fecha       :   22-08-2008 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE SetEnvironmentData(--        isbProcessId    in varchar2,
    isbFileName IN VARCHAR2,
    inuNumHilo  IN NUMBER,
    isbFilePath IN VARCHAR2)
IS
  ----------------------------------------------------------------------------
BEGIN
  --{
  pkErrors.Push ('DL_BOPARAMETRIZACION.CargTablasPorArch.SetEnvironmentData');
  -- Establece el nombre del archivo.
  gsbFileName  := isbFileName;
  gsbTableName := fsbGetTableName (gsbFileName);
  -- Arma el nombre del directorio
  gsbDirectory := SUBSTR (UPPER (gsbDirectory || gsbTableName), 1, 27);
  -- Le adiciona el hilo al nombre del directorio
  gsbDirectory         := UPPER (gsbDirectory || inuNumHilo);
  gsbPathFile          := isbFilePath;
  IF (gsbErrorSequence IS NOT NULL) THEN
    sbErrorSequence    := gsbErrorSequence;
  ELSE
    sbErrorSequence := TO_CHAR (SYSDATE, 'yyyymmddhh24miss');
  END IF;
  sbErrorSequence := sbErrorSequence || '-' || inuNumHilo;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END SetEnvironmentData;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   CreateStatusExeProgRecord
Create Status Execution Program Record.
Descripción :   Crea estado de ejecución del proceso.
Autor       :   Leonardo Garcia
Fecha       :   22-08-2008 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
22-08-2008  isinisteSAO86275
Creación.
******************************************************************************
*/
PROCEDURE CreateStatusExeProgRecord(
    isbProcessId VARCHAR2,
    inuNumHilo   NUMBER,
    inuNumHilos  NUMBER)
IS
  PRAGMA AUTONOMOUS_TRANSACTION;
  ----------------------------------------------------------------------------
  -- Cursores:
  cuDataFile pkConstante.tyRefCursor;
  ----------------------------------------------------------------------------
  -- Variables:
  sbSentence VARCHAR2 (4000);
BEGIN
  --{
  pkErrors.Push (
  'DL_BOPARAMETRIZACION.CargTablasPorArch.CreateStatusExeProgRecord');
  IF (isbProcessId  IS NULL) THEN
    gsbProcessTrack := NULL;
    pkErrors.pop;
    RETURN;
  END IF;
  gsbProcessTrack := isbProcessId || '-' || inuNumHilo;
  -- Cuenta el total de registros.
  sbSentence := 'SELECT count(1) FROM ' || gsbExternalTableName ||
  ' WHERE mod(NUM_LINEA,' || inuNumHilos || ')+1' || '=' || inuNumHilo ||
  ' and NUM_LINEA != 0';
  OPEN cuDataFile FOR sbSentence;
  FETCH
    cuDataFile
  INTO
    gnuRecordsNumber;
  CLOSE cuDataFile;
  pkgeneralservices.tracedata ('*ODL* gsbProcessTrack  = ' || gsbProcessTrack);
  pkgeneralservices.tracedata ('*ODL* gnuRecordsNumber = ' || gnuRecordsNumber)
  ;
  pkStatusExeProgramMgr.AddRecord (gsbProcessTrack, gnuRecordsNumber);
  pkGeneralServices.CommitTransaction;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END CreateStatusExeProgRecord;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   CreateEnvironment
Create Environment
Descripción :   Crea el ambiente para el manejo de tablas externas.
____________________________________________________________________________
Parámetros      |   Descripción
________________|___________________________________________________________
isbProcessId    |   Identificador del proceso.
isbFileName     |   Nombre del archivo.
________________|___________________________________________________________
Autor       :   Leonardo Garcia Q.
Fecha       :   22-08-2008 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE CreateEnvironment(
    isbProcessId IN VARCHAR2,
    isbFileName  IN VARCHAR2,
    isbFilePath  IN VARCHAR2,
    inuNumHilo   IN NUMBER,
    inuNumHilos  IN NUMBER,
    isbModo      IN VARCHAR2)
IS
BEGIN
  pkErrors.Push ('CreateEnvironment');
  -- Fija en memoria el programa
  pkErrors.setApplication (csbGCTB);
  -- Fija el modo de ejecucion
  setExecutionMode (isbModo);
  -- Establece los datos para la creación de la tabla.
  SetEnvironmentData (--            isbProcessId   ,
  isbFileName, inuNumHilo, isbFilePath);
  -- Crea Directorio
  CreateDirectory (isbProcessId, gsbPathFile, gsbDirectory);
  -- Crea la tabla externa.
  CreateExternalTable (isbProcessId, inuNumHilo);
  -- Inserta registro del proceso
  CreateStatusExeProgRecord (isbProcessId, inuNumHilo, inuNumHilos);
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END CreateEnvironment;
/******************************************************************************
***************/
PROCEDURE GetSentence(
    isbTableName VARCHAR2,
    inuNumHilo   NUMBER,
    inuNumHilos  NUMBER,
    osbSentence OUT VARCHAR2)
IS
  sbSelect VARCHAR2 (3000);
  sbFrom   VARCHAR2 (1000);
  sbCampo  VARCHAR2 (2000);
BEGIN
  pkerrors.push ('GetSentence');
  IF (grctbTablas.tbcolumn_name.FIRST IS NULL OR gsbProcessTrack IS NULL) THEN
    pkErrors.pop;
    RETURN;
  END IF;
  sbSelect := 'SELECT NUM_LINEA||' || '''|''' || '||';
  -- Arma sentencia select con los campos de la tabla
  FOR nuIdx IN grctbTablas.tbcolumn_name.FIRST ..
  grctbTablas.tbcolumn_name.LAST
  LOOP
    sbCampo := 'trim(' || grctbTablas.tbcolumn_name (nuIdx) || ')';
    -- Reemplaza las comillas simples por dobles comillas
    sbCampo                           := REPLACE (sbCampo, '''', '''''');
    IF (grctbTablas.tbcolumn_name.LAST = nuidx) THEN
      sbSelect                        := sbSelect || sbCampo;
    ELSE
      sbSelect := sbSelect || sbCampo || '||' || '''|''' || '||';
    END IF;
    --}
  END LOOP;
  -- Arma el from de la sentencia
  sbFrom := ' FROM ' || gsbExternalTableName || ' WHERE mod(NUM_LINEA,' ||
  inuNumHilos || ')+1' || '=' || inuNumHilo || ' and NUM_LINEA != 0';
  osbSentence := sbSelect || sbFrom;
  pkgeneralservices.tracedata ('Sentencia a ejecutar: ');
  pkgeneralservices.tracedata (osbSentence);
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, osbErrorMessage);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, osbErrorMessage);
END GetSentence;
/******************************************************************************
***************/
PROCEDURE InsertInRollbackFile(
    isbFileName IN VARCHAR2,
    isbCadena   IN VARCHAR2,
    isbModo     IN VARCHAR2)
IS
  fdFile UTL_FILE.file_type;
BEGIN
  pkErrors.Push ('InsertInRollbackFile');
  IF (isbModo = csbUPDATE) THEN
    pkErrors.pop;
    RETURN;
  END IF;
  fdFile := pkUtlFileMgr.Fopen (gsbPathFile, isbFileName, 'a');
  pkUtlFileMgr.Put_Line (fdFile, isbCadena);
  IF (MOD (NVL (gnuCompleteLines, 0) + 1, cnuLimit) = 0) THEN
    pkUtlFileMgr.Put_Line (fdFile, 'commit;');
  END IF;
  pkUtlFileMgr.fclose (fdFile);
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END InsertInRollbackFile;
-----------------------------------------------------------------------
/******************************************************************************
***************/
PROCEDURE ExecuteAddProcess(
    isbDeclaraReg  VARCHAR2,
    isbPrimerNivel VARCHAR2,
    iblExecValProc BOOLEAN,
    itbPrimKey tytbFields,
    ichPrimerNivel CHAR)
IS
  sbProcedure   clob;
  sbProcedure1  clob;
  tbDummy ut_string.TyTb_String;
  nuIndDummy NUMBER;
  sbRowid ROWID;
  sbTableFields   VARCHAR2 (4000);
  sbRecordData    VARCHAR2 (4000);
  nucursorhandler NUMBER;
  nudbmssqlerr    NUMBER;
  tbData DL_BOPARAMETRIZACION.tytbCondicion;
  -------------------------------------------------------------------------------
FUNCTION fsbGetPrimaryKeyParam
  RETURN VARCHAR2
IS
  sbResult VARCHAR2 (1000);
BEGIN
  pkErrors.Push ('DL_BOPARAMETRIZACION.CargTablasPorArch.fsbGetPrimaryKeyParam'
  );
  IF (itbPrimKey.FIRST IS NULL) THEN
    pkErrors.pop;
    RETURN NULL;
  END IF;
  -- Recorre la tabla de llaves primarias
  FOR nuIdx IN itbPrimKey.FIRST .. itbPrimKey.LAST
  LOOP
    sbResult := sbResult || 'rc_' || gsbTableName || '.' || itbPrimKey (nuIdx);
    -- Si no es el ultimo campo de la llave primaria
    IF nuIdx   != itbPrimKey.LAST THEN
      sbResult := sbResult || ',';
    END IF;
  END LOOP;
  pkErrors.Pop;
  RETURN sbResult;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END fsbGetPrimaryKeyParam;
-------------------------------------------------------------------------------
FUNCTION fsbGetProcessSentence
  RETURN VARCHAR2
IS
  sbUpdateRecord VARCHAR2 (20);
  sbProc1        clob;
  sbModo         VARCHAR2 (1);
  sbPrimKey      VARCHAR2 (10000);
  sbFirstPrmKey  VARCHAR2 (100);
  tbString ut_string.TyTb_String;
  sbSelectToRowid    VARCHAR2 (10000);
  sbFblExistsNoLlave VARCHAR2 (10000);
  sbSentenceUpd0     clob;
  sbSentenceUpd      clob;
  sbWhereUpd         clob;
  sbSentenceUpdCE    clob;
  sbWhereUpdCE       clob;
  ----------------------------------------------------------------
FUNCTION fsbCampoEspecial
  RETURN VARCHAR2
IS
  cuDataFile pkConstante.tyRefCursor;
  tbColumnNames tytbFields;
  tbTableNames tytbFields;
  tbDataType tytbFields;
  sbSentence   clob;
  sbSentenceCE clob;
  --tbPKVal        tytbFields;
  sbPk VARCHAR2 (1000);
BEGIN
  /* ut_trace.init;
  ut_trace.setlevel(99);
  ut_trace.setoutput(ut_trace.fntrace_output_db);*/
  sbSentence :=
  ' SELECT column_name, table_name, data_type
FROM user_tab_COLUMNS
WHERE
data_type in (''SDO_GEOMETRY'',''CLOB'', ''BLOB'')
AND table_name ='''
  || gsbTableName || '''';
  OPEN cuDataFile FOR sbSentence;
  FETCH
    cuDataFile BULK COLLECT
  INTO
    tbColumnNames,
    tbTableNames,
    tbDataType;
  CLOSE cuDataFile;
  IF tbColumnNames.FIRST IS NOT NULL THEN
    SELECT
      b.column_name
    INTO
      sbPk
    FROM
      user_constraints a,
      user_cons_columns b
    WHERE
      a.table_name        = gsbTableName
    AND a.CONSTRAINT_TYPE = 'P'
    AND a.constraint_name = b.constraint_name;
    sbSentenceCE         := 'BEGIN ';
    FOR nuIdx IN tbColumnNames.FIRST .. tbColumnNames.LAST
    LOOP
      IF tbColumnNames (nuIdx) IS NOT NULL THEN
        sbSentenceCE           := sbSentenceCE || ' UPDATE ' || tbTableNames (
        nuIdx) || '@' || fsbgetDB_LINK || ' SET ' || tbColumnNames (nuIdx) ||
        ' = ' || '(select ' || tbColumnNames (nuIdx) || ' FROM ODLTMP_' ||
        tbTableNames (nuIdx) || ' WHERE ' || sbPk || '= rc_' || tbTableNames (
        nuIdx) || '.' || sbPk || '); ' || CHR (10);
      END IF;
    END LOOP;
    sbSentenceCE := sbSentenceCE || 'END; ';
 --   ut_trace.trace ('sbSentenceCE:' || sbSentenceCE, 2);
  END IF;
  ut_trace.trace ('sbSentenceCE:no data', 2);
  RETURN sbSentenceCE;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END fsbCampoEspecial;
BEGIN
  /* ut_trace.init;
  ut_trace.setlevel(99);
  ut_trace.setoutput(ut_trace.fntrace_output_db);*/
  pkErrors.Push ('DL_BOPARAMETRIZACION.CargTablasPorArch.fsbGetProcessSentence'
  );
  IF gsbProc1 IS NOT NULL THEN
    pkErrors.pop;
    RETURN gsbProc1;
  END IF;
  -- Si la tabla es de BSS
  IF (ichPrimerNivel = csbBSS) THEN
    sbUpdateRecord  := 'UpRecord';
  ELSE
    sbUpdateRecord := 'UpdRecord';
  END IF;
  -- Obtiene el modo de ejecucion
  sbModo                := fsbGetExecutionMode;
  IF fnuGetOracleEdition = 1 THEN
    sbSentenceUpdCE     := fsbCampoEspecial;
  END IF;
  -- Obtiene llaves primarias
  sbPrimKey := fsbGetPrimaryKeyParam;
  -- Obtiene primer campo de llave primaria
  sbFirstPrmKey := NVL (SUBSTR (sbPrimKey, 1, INSTR (sbPrimKey, ',') - 1),
  sbPrimKey);
  ut_string.ExtString (sbPrimKey, ',', tbString);
  IF (tbString.FIRST IS NULL) THEN
    pkErrors.pop;
    RETURN NULL;
  END IF;
  sbFblExistsNoLlave := 'SELECT count(1) INTO nuExists FROM ' || gsbTableName
  || '@' || fsbgetDB_LINK || ' WHERE ';
  sbSentenceUpd0 := 'UPDATE ' || gsbTableName || '@' || fsbgetDB_LINK ||
  ' SET ';
  sbSelectToRowid:='';
  sbWhereUpd     :='';
  sbWhereUpdCE   :='';
  -- Recorre la tabla de resultado
  FOR nuIdx IN tbString.FIRST .. tbString.LAST
  LOOP
    --if tbString(nuIdx) is not null then
    -- Si es a ultima posicion no le añade AND al final
    --Recorre todas las llaves primarias que estaban separadas por ,
    IF nuIdx           = tbString.LAST THEN
      sbSelectToRowid := sbSelectToRowid || REPLACE (tbString (nuIdx), 'rc_',
      '') || '=' || tbString (nuIdx);
      sbWhereUpd := sbWhereUpd || REPLACE (tbString (nuIdx), 'rc_', '') || '='
      || tbString (nuIdx);
      sbWhereUpdCE := sbWhereUpdCE || REPLACE (tbString (nuIdx), 'rc_' ||
      gsbTableName || '.', '') || '=' || tbString (nuIdx);
    ELSE
      sbSelectToRowid := sbSelectToRowid || REPLACE (tbString (nuIdx), 'rc_',
      '') || '=' || tbString (nuIdx) || ' AND ';
      sbWhereUpd := sbWhereUpd || REPLACE (tbString (nuIdx), 'rc_', '') || '='
      || tbString (nuIdx) || ' AND ';
      sbWhereUpdCE := sbWhereUpdCE || REPLACE (tbString (nuIdx), 'rc_' ||
      gsbTableName || '.', '') || '=' || tbString (nuIdx) || ' AND ';
    END IF;
  END LOOP;
  --Si la tabla es una de las 11 que no tienen llave primaria, se arma el
  -- fblexists con todos los campos de la tabla
  IF gblNoTieneLlavePrim THEN
    sbFblExistsNoLlave := sbFblExistsNoLlave || sbSelectToRowid || ';';
  ELSE
    --Recorre todos los campos que se van a asignar en el SET del UPDATE
    -- dinámico
    ut_string.ExtString (sbRecordData, ',', tbString);
    IF (tbString.FIRST IS NULL) THEN
      pkErrors.pop;
      RETURN NULL;
    END IF;
    FOR nuIdx IN tbString.FIRST .. tbString.LAST
    LOOP
      -- Si es a ultima posicion no le añade AND al final
      --Recorre todas las llaves primarias que estaban separadas por ,
      IF nuIdx         = tbString.LAST THEN
        sbSentenceUpd := sbSentenceUpd || REPLACE (tbString (nuIdx), 'rc_', '')
        || '=' || tbString (nuIdx);
      ELSE
        sbSentenceUpd := sbSentenceUpd || REPLACE (tbString (nuIdx), 'rc_', '')
        || '=' || tbString (nuIdx) || ' , ';
      END IF;
    END LOOP;
    sbSentenceUpd := sbSentenceUpd0 || sbSentenceUpd || ' WHERE ' || sbWhereUpd
    || ';';
  END IF;
  --Si no tiene llave primaria, debe hacer el SELECT del rowid solo con los
  -- campos que tengan datos.
  sbSelectToRowid := 'select rowid INTO sbRowid FROM ' || gsbTableName || '@'
  || fsbgetDB_LINK || ' where ' || sbSelectToRowid || ';';
  -- Si el modo es insert
  IF (sbModo = csbINSERT) THEN
    -- Si existe primer nivel valida si ya existe con la llave primaria
    IF ( isbPrimerNivel IS NOT NULL AND sbPrimKey IS NOT NULL AND NOT
      (
        gblNoTieneLlavePrim
      )
      ) THEN
      sbProc1 := sbProc1 || 'if (nvl(' || sbFirstPrmKey ||
      ',null) is not null) then ' || 'if ' || isbPrimerNivel || '.fblExist' ||
      '@' || fsbgetDB_LINK || '(' || sbPrimKey || ') then' ||
      ' pkErrors.SetErrorMessage(''' || '<' || sbPrimKey ||
      ' >|REGISTRO YA EXISTE'');' || ' raise login_denied;' || 'end if;';
      sbProc1 := sbProc1 || 'insert into ' || gsbTableName || '@' ||
      fsbgetDB_LINK || ' (' || sbTableFields || ') values (' || sbRecordData ||
      ');' || CHR (10) || sbSelectToRowid || CHR (10) ||
      ' dl_boparametrizacion.setRowid(sbRowid);';
      IF (isbPrimerNivel IS NOT NULL AND sbPrimKey IS NOT NULL) THEN
        sbProc1          := sbProc1 || ' END IF;';
      END IF;
    END IF;
    IF gblNoTieneLlavePrim THEN
      sbProc1 := sbProc1 || 'if (nvl(' || sbFirstPrmKey ||
      ',null) is not null) then ' || CHR (10) || sbFblExistsNoLlave || CHR (10)
      || 'if nuExists > 0 then ' ||
      ' pkErrors.SetErrorMessage(''REGISTRO YA EXISTE'');' ||
      ' raise login_denied;' || 'end if;';
      sbProc1 := sbProc1 || 'insert into ' || gsbTableName || '@' ||
      fsbgetDB_LINK || ' (' || sbTableFields || ') values (' || sbRecordData ||
      ');';
    END IF;
    -- Si esta modo update
  ELSIF (sbModo = csbUPDATE) THEN
    -- Si no tiene llave primaria
    IF (sbPrimKey IS NULL) THEN
      pkErrors.SetErrorMessage (
      '<MODO UPDATE NO VALIDO>|NO EXISTE LLAVE PRIMARIA ');
      RAISE LOGIN_DENIED;
    END IF;
    -- Si existe primer nivel valida si no existe con la llave primaria
    IF (isbPrimerNivel IS NOT NULL AND NOT
      (
        gblNoTieneLlavePrim
      )
      ) THEN
      sbProc1 := sbProc1 || 'if (nvl(' || sbFirstPrmKey ||
      ',null) is not null) then ' || 'if not ' || isbPrimerNivel || '.fblExist'
      || '@' || fsbgetDB_LINK || '(' || sbPrimKey || ') then' ||
      ' pkErrors.SetErrorMessage(''' || '<' || sbPrimKey ||
      '>|REGISTRO NO EXISTE'');' || ' raise login_denied;' || 'end if;';
      sbProc1 := sbProc1 || 'if (nvl(' || sbFirstPrmKey ||
      ',null) is not null) then ' || sbSentenceUpd || 'end if; END if;';
    END IF;
    /*
    No debe hacer un UPDATE ya que no sabe qué campo actualizar, pues para
    identificar el UPDATE se usa llave primaria.
    al no tener llave primaria, no se sabe qué campo conservar.
    */
    -- Si esta en modo insert y update
  ELSIF (sbModo = csbBOTH) THEN
    -- Si no tiene llave primaria
    IF (sbPrimKey IS NULL) THEN
      pkErrors.SetErrorMessage (
      '<MODO AMBOS NO VALIDO>|NO EXISTE LLAVE PRIMARIA ');
      RAISE LOGIN_DENIED;
    END IF;
    -- Si existe primer nivel valida si no existe con la llave primaria
    IF ( isbPrimerNivel IS NOT NULL AND sbPrimKey IS NOT NULL AND NOT
      (
        gblNoTieneLlavePrim
      )
      ) THEN
      IF gsbTableName  = 'GE_XSL_TEMPLATE' THEN
        sbTableFields :=sbTableFields || ',' || 'TEMPLATE_SOURCE';
        sbRecordData  := sbRecordData || ', EMPTY_CLOB()';
      END IF;
      sbProc1 := sbProc1 || 'if (nvl(' || sbFirstPrmKey ||
      ',null) is not null) then ' || 'if ' || isbPrimerNivel || '.fblExist' ||
      '@' || fsbgetDB_LINK || '(' || sbPrimKey || ') then ' || sbSentenceUpd ||
      'else ' || 'insert into ' || gsbTableName || '@' || fsbgetDB_LINK || ' ('
      || sbTableFields || ') values (' || sbRecordData || ');' || CHR (10) ||
      sbSelectToRowid || CHR (10) || 'dl_boparametrizacion.setRowid(sbRowid);'
      || 'end if;' || 'end if;';
    END IF;
    IF gblNoTieneLlavePrim THEN
      sbProc1 := sbProc1 || 'if (nvl(' || sbFirstPrmKey ||
      ',null) is not null) then ' || sbFblExistsNoLlave || CHR (10) ||
      ' if nuExists = 0 then ' || 'insert into ' || gsbTableName || '@' ||
      fsbgetDB_LINK || ' (' || sbTableFields || ') values (' || sbRecordData ||
      ');' || CHR (10) || ' else ' || ' pkErrors.SetErrorMessage(''' ||
      'REGISTRO YA EXISTE'');' || ' raise login_denied;' || ' end if;' ||
      'end if;';
    END IF;
  END IF;
  --Asigna '1' para los campos BLOBs e inserta con ese valor. Luego se
  -- actualiza el '1' por el dato correspondiente.
  IF sbSentenceUpdCE IS NOT NULL THEN
    sbProc1          := REPLACE (sbProc1, 'rc_GE_ITEM_PHOTO.ITEM_PHOTO',
    'EMPTY_BLOB()') || sbSentenceUpdCE;
    sbProc1 := REPLACE (sbProc1, 'rc_ED_PLANTILL.PLANCONT', 'EMPTY_BLOB()') ||
    sbSentenceUpdCE;
  END IF;
  sbProc1  := sbProc1 || ' END;';
  gsbProc1 := sbProc1;
  pkErrors.Pop;
  RETURN sbProc1;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END fsbGetProcessSentence;
-------------------------------------------------------------------------------
FUNCTION fsbGetDeclareSentence
  RETURN VARCHAR2
IS
  sbProc VARCHAR2 (4000);
BEGIN
  --{
  pkErrors.Push ('DL_BOPARAMETRIZACION.CargTablasPorArch.ExecuteAddProcess');
  sbProc := 'declare ' || '  sbData         varchar2(1000);' ||
  '  sbRowid        rowid;' || '  nuValue        varchar2(100);' ||
  '  sbErrMsg       varchar2(2000);' || '  sbSentence     varchar2(2000);' ||
  '  nuExists       number;' ||
  '  tbData         DL_BOPARAMETRIZACION.tytbCondicion;' || isbDeclaraReg ||
  'begin ' || '   tbData := DL_BOPARAMETRIZACION.ftbGetTableData;';
  nuIndDummy     := 1;
  gsbDataTable   := grctbTablas;
  gsbNombreTabla := gsbTableName;
  -- Arma la asignacion de cada una de los datos
  FOR nuIdx IN grctbTablas.tbData_Asig.FIRST .. grctbTablas.tbData_Asig.LAST
  LOOP
    -- Si es un campo dummy
    IF (INSTR (UPPER (grctbTablas.tbcolumn_name (nuIdx)), csbDUMMY_) != 0) THEN
      -- llena tabla de dummys
      tbDummy (nuIndDummy) := grctbTablas.tbData_Asig (nuIdx);
      nuIndDummy           := nuIndDummy + 1;
    ELSE
      IF grctbTablas.tbdata_type (nuIdx) != 'BLOB' THEN
        sbProc                           := sbProc || 'rc_' || gsbTableName ||
        '.' || grctbTablas.tbcolumn_name (nuIdx) || ':=' ||
        grctbTablas.tbData_Asig (nuIdx) || '; ';
      END IF;
    END IF;
  END LOOP;
  -- Valida si existe procedimiento que realiza validaciones
  IF (iblExecValProc) THEN
    sbProc := sbProc || 'BEGIN ' || 'dl_exe_' || gsbTableName || '(rc_' ||
    gsbTableName;
    IF (tbDummy.FIRST IS NOT NULL) THEN
      -- Recorre los campos dummy
      FOR nuIdx IN tbDummy.FIRST .. tbDummy.LAST
      LOOP
        sbProc := sbProc || ',' || tbDummy (nuIdx);
      END LOOP;
    END IF;
    sbProc := sbProc || '); ' || 'exception ' || 'when login_denied then ' ||
    '   raise login_denied; ' || 'when pkConstante.exERROR_LEVEL2 then ' ||
    '   raise pkConstante.exERROR_LEVEL2; ' || 'when others then ' ||
    '   pkErrors.NotifyError(pkErrors.fsbLastObject,''ERROR EN REGLA dl_exe_'
    || gsbTableName || ':''|| SQLERRM,sbErrMsg); ' ||
    '   raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg); ' ||
    'end;';
  END IF;
  gsbProc := sbProc;
  pkErrors.Pop;
  RETURN sbProc;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END fsbGetDeclareSentence;
-----------------------------------------------------------------------------
BEGIN
  pkerrors.push ('ExecuteAddProcess');
  --ut_trace.trace('PPP INICIO ExecuteAddProcess',2);
  -- Limpia rowid de memoria
  --DL_BOPARAMETRIZACION.setRowid(sbRowid);
  DL_BOPARAMETRIZACION.GetFieldsFromDB ('rc_' || gsbTableName, sbTableFields,
  sbRecordData);
  --ut_trace.trace('PRU GetFieldsFromDB',2);
  sbProcedure  := fsbGetDeclareSentence;
  sbProcedure1 := fsbGetProcessSentence;
  -- Ejecuta metodo dinamico
--  ut_trace.trace ('PRU sbProcedure:' || sbProcedure, 2);
 -- ut_trace.trace ('PRU sbProcedure1:' || sbProcedure1, 2);
  tbData := DL_BOPARAMETRIZACION.ftbGetTableData;
  --Arma la cadena para la inserción en dl_log_process con la info de las
  -- llaves primarias.
  DL_BOPARAMETRIZACION.GetPrimaryAndValues;
  --ut_trace.trace('PRU GetPrimaryAndValues:'||gsbCadenatoInsert,2);
  --Inserta el registro no procesado en dl_log_process con flag en 'N'
  DL_BOPARAMETRIZACION.InsRegNoProcess;
  EXECUTE IMMEDIATE sbProcedure || sbProcedure1;
  sbRowid := fsbGetRowid;
  --nuValue := fnuGetnuValue;
  --ut_trace.trace('PPP sbRowid:'||sbRowid,2);
  DL_BOPARAMETRIZACION.InsRegOkProcess;
  -- Si existe rowid
  IF (sbRowid IS NOT NULL) THEN
    -- Inserta en archivo de reversa
    InsertInRollbackFile ( '.' || gsbTableName || '-' || NVL (gsbProcessTrack,
    sbErrorSequence) || '.rev', 'DELETE FROM ' || gsbTableName ||
    ' WHERE ROWID = ''' || sbRowid || ''';', isbModo);
    --ut_trace.trace('PRU ROWID NO ES NULO',2);
    --El registro se insertó correctamente, entonces se guarda como procesado
    -- en el archivo de log.
    --AdminDL_LOG_PROCESSOK(gsbTableName);
  END IF;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject,SQLERRM,osbErrorMessage);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2,osbErrorMessage);
END ExecuteAddProcess;
------------------------------------------------------------------------------------------------
FUNCTION fsbGetCoor(
    isbString VARCHAR2,
    ionuData IN OUT VARCHAR2,
    onuTipoCoor OUT NUMBER)
  RETURN VARCHAR2
IS
  tbString ut_string.TyTb_String;
  sbCoor VARCHAR2 (1000);
BEGIN
  -- Pasa la cadena de resultado a una tabla
  ut_string.ExtString (isbString, ',', tbString);
  IF tbString.FIRST IS NULL THEN
    pkErrors.setErrorMessage ('Valor de coordenadas no valido');
    RAISE LOGIN_DENIED;
  END IF;
  FOR nuidx IN tbString.FIRST .. tbString.LAST
  LOOP
    gtbData (ionuData) := tbString (nuidx);
    sbCoor             := sbCoor || 'tbData(' || ionuData || ')';
    IF nuIdx           != tbString.LAST THEN
      sbCoor           := sbCoor || '||'';''||';
    END IF;
    ionuData := ionuData + 1;
  END LOOP;
  IF ionuData    = 2 THEN
    onuTipoCoor := cnuPUNTO;
  ELSE
    onuTipoCoor := cnuLINEA;
  END IF;
  RETURN sbCoor;
END;
------------------------------------------------------------------------------------------------
PROCEDURE InsertRecord(
    inuLineNumber  NUMBER,
    isbResSentence VARCHAR2,
    ichPrimerNivel CHAR,
    isbDeclaraReg  VARCHAR2,
    isbPrimerNivel VARCHAR2,
    iblExecValProc BOOLEAN,
    inuNumHilo     NUMBER,
    inuNumHilos    NUMBER,
    itbPrimKey tytbFields)
IS
  cnuDIMPUNTO   CONSTANT NUMBER := 2001;
  cnuDIMLINEA   CONSTANT NUMBER := 2002;
  cnuCOORSYSTEM CONSTANT NUMBER := 8192;
  tbString ut_string.TyTb_String;
  sbDato     VARCHAR2 (4000);
  nuData     NUMBER := 1;
  sbCoor     VARCHAR2 (1000);
  nuTipoCoor NUMBER;
  nuVarKC    NUMBER;
BEGIN
  pkerrors.push ('InsertRecord');
  ut_trace.trace ('InsertRecord XXX', 2);
  --ut_trace.trace('InsertRecord', 2);
  -- Pasa la cadena de resultado a una tabla
  ut_string.ExtString (isbResSentence, '|', tbString);
  IF (tbString.FIRST IS NULL) THEN
    pkgeneralservices.tracedata ('No obtuvo registros la consulta');
    pkErrors.pop;
    RETURN;
  END IF;
  FOR nuIdx IN tbString.FIRST .. tbString.LAST
  LOOP
    sbDato := NULL;
    -- Si el tipo de dato es varchar2 o char2
    IF (grctbTablas.tbData_type (nuIdx) = 'VARCHAR2' OR grctbTablas.tbData_type
      (nuIdx)                           = 'CHAR') THEN
      gtbData (nuData)                 := tbString (nuIdx);
      sbDato                           := 'replace(tbData(' || nuData ||
      '),''&'',''|'')';
      nuData := nuData + 1;
      -- Si el tipo de dato es date
    ELSIF (grctbTablas.tbData_type (nuIdx) = 'DATE') THEN
      IF (tbString (nuIdx)                IS NULL) THEN
        gtbData (nuData)                  := NULL;
        sbDato                            := 'tbData(' || nuData || ')';
        nuData                            := nuData + 1;
      ELSE
        gtbData (nuData) := tbString (nuIdx);
        sbDato           := 'to_date(tbData(' || nuData || '))';
        nuData           := nuData + 1;
      END IF;
    ELSIF (grctbTablas.tbData_type (nuIdx) = 'SDO_GEOMETRY') THEN
      IF (tbString (nuIdx)                IS NULL) THEN
        gtbData (nuData)                  := NULL;
        sbDato                            := 'null';
        nuData                            := nuData + 1;
      ELSE
        sbCoor       := fsbGetCoor (tbString (nuIdx), nuData, nuTipoCoor);
        IF nuTipoCoor = cnuPUNTO THEN
          sbDato     := 'MDSYS.SDO_GEOMETRY(' || cnuDIMPUNTO || ',' ||
          cnuCOORSYSTEM || ',' || 'SDO_POINT_TYPE(' || sbCoor || ',NULL),' ||
          'NULL,' || 'NULL)';
        ELSIF nuTipoCoor = cnuLINEA THEN
          sbDato        := 'DL_BOPARAMETRIZACION.fsgbCREARCADENALINEASRECTAS('
          || sbCoor || ')';
        END IF;
      END IF;
    ELSE
      gtbData (nuData) := tbString (nuIdx);
      sbDato           := 'tbData(' || nuData || ')';
      nuData           := nuData + 1;
    END IF;
    grctbTablas.tbData_asig (nuIdx) := sbDato;
    --}
  END LOOP;
  ExecuteAddProcess (isbDeclaraReg, isbPrimerNivel, iblExecValProc, itbPrimKey,
  ichPrimerNivel);
  DL_BOPARAMETRIZACION.InsRegOkProcess;
  -- Modo validacion
  IF isbOnlyVal = pkConstante.SI THEN
    pkGeneralServices.rollbacktransaction;
  ELSE
    pkGeneralServices.commitTransaction;
    gnuInsertados := NVL (gnuInsertados, 0) + 1;
  END IF;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  gnuRechazados := NVL (gnuRechazados, 0) + 1;
  pkGeneralServices.rollbacktransaction;
  -- Adiciona el error a la colección de errores.
  AddError (inuLineNumber,inuLineNumber || '|' || isbResSentence,
  pkErrors.fsbGetErrorMessage);
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject,SQLERRM,osbErrorMessage);
  pkerrors.pop;
  gnuRechazados := NVL (gnuRechazados, 0) + 1;
  pkGeneralServices.rollbacktransaction;
  -- Adiciona el error a la colección de errores.
  AddError (inuLineNumber,isbResSentence,pkErrors.fsbGetErrorMessage);
END insertRecord;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   UpStatusExeProgram
Update Status Execution Program.
Descripción :   Actualiza estado de ejecución del proceso.
Autor       :   Leonardo Garcia
Fecha       :   22-08-2008 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
19-01-2009  sgomezSAO86275
Se modifica el mensaje de procesamiento.
22-08-2008  lgarciaSAOXXXX
Creación.
******************************************************************************
*/
PROCEDURE UpStatusExeProgram
IS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  pkErrors.Push ( 'DL_BOPARAMETRIZACION.CargTablasPorArch.UpStatusExeProgram');
  IF gsbProcessTrack IS NULL THEN
    pkErrors.pop;
    RETURN;
  END IF;
  -- Notificar avance de proceso.
  pkStatusExeProgramMgr.UpStatusExeProgram (gsbProcessTrack, 'Procesando...',
  gnuRecordsNumber, gnuCompleteLines);
  pkGeneralServices.CommitTransaction;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END UpStatusExeProgram;
---------------------------------------------------------------------
PROCEDURE ProcessFromMemory(
    isbSent        VARCHAR2,
    ichPrimerNivel CHAR,
    isbDeclaraReg  VARCHAR2,
    isbPrimerNivel VARCHAR2,
    iblExecValProc BOOLEAN,
    inuNumHilo     NUMBER,
    inuNumHilos    NUMBER,
    itbPrimKey tytbFields)
IS
  nuNumberReg    NUMBER;
  nuNumbeRegProc NUMBER;
  nuNumLinea     NUMBER;
BEGIN
  pkErrors.Push ( 'DL_BOPARAMETRIZACION.CargTablasPorArch.ProcessFromMemory');
  -- Llena el archivo
  IF (gtbDatos.FIRST IS NULL) THEN
    pkErrors.pop;
    RETURN;
  END IF;
  FOR nuIdx IN gtbDatos.FIRST .. gtbDatos.LAST
  LOOP
    nuNumLinea := SUBSTR (gtbDatos (nuIdx), 1, INSTR (gtbDatos (nuIdx), '|') -
    1);
    gtbDatos (nuIdx) := SUBSTR (gtbDatos (nuIdx), INSTR (gtbDatos (nuIdx), '|')
    + 1);
    InsertRecord (nuNumLinea, gtbDatos (nuIdx), ichPrimerNivel, isbDeclaraReg,
    isbPrimerNivel, iblExecValProc, inuNumHilo, inuNumHilos, itbPrimKey);
    -- Actualiza la variable global
    gnuCompleteLines := gnuCompleteLines + 1;
    --}
  END LOOP;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END;
---------------------------------------------------------------------
PROCEDURE ProcessFromFile(
    isbSent        VARCHAR2,
    ichPrimerNivel CHAR,
    isbDeclaraReg  VARCHAR2,
    isbPrimerNivel VARCHAR2,
    iblExecValProc BOOLEAN,
    inuNumHilo     NUMBER,
    inuNumHilos    NUMBER,
    itbPrimKey tytbFields)
IS
  nuCursor NUMBER;
  tbResSent DBMS_SQL.Varchar2_table;
  nuIdx          NUMBER := cnuLimit * -1;
  nuNumberReg    NUMBER;
  nuNumbeRegProc NUMBER;
  nuNumLinea     NUMBER;
BEGIN
  pkErrors.Push ('DL_BOPARAMETRIZACION.CargTablasPorArch.ProcessFromFile');
  nuCursor := DBMS_SQL.open_cursor;
  DBMS_SQL.parse (nuCursor, isbSent, DBMS_SQL.native);
  DBMS_SQL.define_array (nuCursor,1,tbResSent,cnuLimit,nuidx);
  nuNumberReg    := DBMS_SQL.execute (nuCursor);
  nuNumbeRegProc := 1;
  LOOP
    tbResSent.delete;
    nuNumberReg := DBMS_SQL.fetch_rows (nuCursor);
    DBMS_SQL.COLUMN_VALUE (nuCursor, 1, tbResSent);
    -- Llena el archivo
    IF (tbResSent.FIRST IS NULL) THEN
      pkErrors.pop;
      RETURN;
    END IF;
    FOR nuIdx IN tbResSent.FIRST .. tbResSent.LAST
    LOOP
      --{
      nuNumLinea :=SUBSTR (tbResSent (nuIdx),1,INSTR (tbResSent (nuIdx), '|') -
      1);
      tbResSent (nuIdx) :=SUBSTR (tbResSent (nuIdx),INSTR (tbResSent (nuIdx),
      '|') + 1);
      pkgeneralservices.tracedata ('Línea ' || nuNumLinea);
      --ut_trace.trace('tbResSent(nuIdx):'||tbResSent(nuIdx));
      InsertRecord (nuNumLinea, tbResSent (nuIdx), ichPrimerNivel,
      isbDeclaraReg, isbPrimerNivel, iblExecValProc, inuNumHilo, inuNumHilos,
      itbPrimKey);
      -- Actualiza la variable global
      gnuCompleteLines := nuNumbeRegProc;
      -- Actualiza registro de progreso
      UpStatusExeProgram;
      nuNumbeRegProc := nuNumbeRegProc + 1;
      --}
    END LOOP;
    EXIT
  WHEN nuNumberReg != cnuLimit;
    -- Descarga errores en archivo y se limpia colección de errores.
    insertError (gsbTableName,
    'DL_BOPARAMETRIZACION.CargTablasPorArch.ProcessFromFile', sbErrorSequence);
    FlushErrors (gsbTableName, sbErrorSequence);
  END LOOP;
  DBMS_SQL.close_cursor (nucursor);
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END;
--------------------------------------------------------------------------------
PROCEDURE ProcessTable(
    isbSent        VARCHAR2,
    ichPrimerNivel CHAR,
    isbDeclaraReg  VARCHAR2,
    isbPrimerNivel VARCHAR2,
    iblExecValProc BOOLEAN,
    inuNumHilo     NUMBER,
    inuNumHilos    NUMBER,
    itbPrimKey tytbFields)
IS
BEGIN
  pkerrors.push ( 'DL_BOPARAMETRIZACION.CargTablasPorArch.ProcessTable');
  --ut_trace.trace('DL_BOPARAMETRIZACION.CargTablasPorArch.ProcessTable',2);
  -- Si es llamado para cargar datos desde otra base de datos
  IF gsbProcessTrack IS NULL THEN
    ProcessFromMemory (isbSent, ichPrimerNivel, isbDeclaraReg, isbPrimerNivel,
    iblExecValProc, inuNumHilo, inuNumHilos, itbPrimKey);
  ELSE
    ProcessFromFile (isbSent, ichPrimerNivel, isbDeclaraReg, isbPrimerNivel,
    iblExecValProc, inuNumHilo, inuNumHilos, itbPrimKey);
  END IF;
  -- Inserta en archivo de reversa
  InsertInRollbackFile ( '.' || gsbTableName || '-' || NVL (gsbProcessTrack,
  sbErrorSequence) || '.rev', 'commit;', isbModo);
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, osbErrorMessage);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, osbErrorMessage);
END ProcessTable;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   ProcessFinishOK
Process Finish OK.
Descripción :   Actualiza estado de ejecución del proceso.
Autor       :   Leonardo Garcia
Fecha       :   22-08-2008 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
22-08-2008  lgarciaSAOXXXX
Creación.
******************************************************************************
*/
PROCEDURE ProcessFinishOK
IS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  --{
  pkErrors.Push ( 'DL_BOPARAMETRIZACION.CargTablasPorArch.ProcessFinishOK');
  IF gsbProcessTrack IS NULL THEN
    pkErrors.pop;
    RETURN;
  END IF;
  -- Indicar que el proceso terminó con éxito.
  pkStatusExeProgramMgr.ProcessFinishOK (gsbProcessTrack);
  --ut_trace.trace('PPP INICIO ProcessFinishOK:'||gsbProcessTrack,2);
  pkGeneralServices.CommitTransaction;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END ProcessFinishOK;
/******************************************************************************
***************/
PROCEDURE GetProcessData(
    ochPrimerNivel OUT CHAR,
    osbDeclaraReg OUT VARCHAR2,
    osbPrimerNivel OUT VARCHAR2,
    oblExecValProc OUT BOOLEAN,
    otbPrimKey OUT tytbFields)
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.CargTablasPorArch.GetProcessData');
  -- Valida si existe el primer nivel de tabla de BSS
  IF (fblExistsValProcedure ('pktbl' || gsbTableName)) THEN
    ochPrimerNivel := csbBSS;
    osbDeclaraReg  := 'rc_' || gsbTableName || ' ' || gsbTableName ||
    '%rowtype;';
    osbPrimerNivel := ' pktbl' || gsbTableName;
    -- Valida si existe el primer nivel de tabla de OSS
  ELSIF (fblExistsValProcedure ('DA' || gsbTableName)) THEN
    ochPrimerNivel := csbOSS;
    osbDeclaraReg  := 'rc_' || gsbTableName || ' DA' || gsbTableName || '.STY'
    || gsbTableName || ';';
    osbPrimerNivel := ' DA' || gsbTableName;
  ELSE
    ochPrimerNivel := 'N';
    osbDeclaraReg  := 'rc_' || gsbTableName || ' ' || gsbTableName ||
    '%rowtype;';
  END IF;
  -- Valida si existe procedimiento que realiza validaciones
  IF (fblExistsValProcedure ('DL_EXE_' || gsbTableName)) THEN
    oblExecValProc := TRUE;
  ELSE
    oblExecValProc := FALSE;
  END IF;
  -- Obtiene llave primaria
  otbPrimKey := ftbGetPrimaryKeyField (gsbTableName);
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, osbErrorMessage);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, osbErrorMessage);
END GetProcessData;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   ProcessExternalTable
Process External Table
Descripción :   Procesa la información de la tabla externa.
Autor       :   Leonardo Garcia
Fecha       :   22-08-2009 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE ProcessExternalTable(
    inuNumHilo  NUMBER,
    inuNumHilos NUMBER)
IS
  ------------------------------------------------------------------------
  -- Cursores:
  rcuFileData pkConstante.tyRefCursor;
  ------------------------------------------------------------------------
  -- Variables:
  sbSentence    VARCHAR2 (4000) := NULL; -- Consulta.
  sbSentencia   VARCHAR2 (3000);
  sbDeclaraReg  VARCHAR2 (200);
  sbPrimerNivel VARCHAR2 (200);
  chPrimerNivel CHAR := 'N';
  blExecValProc BOOLEAN;
  tbPrimKey tytbFields;
BEGIN
  pkErrors.Push ('DL_BOPARAMETRIZACION.CargTablasPorArch.ProcessExternalTable')
  ;
  -- Obtener Sentencia a ejecutar
  GetSentence (gsbExternalTableName, inuNumHilo, inuNumHilos, sbSentencia);
  -- Obtiene los datos necesarios para el proceso
  GetProcessData (chPrimerNivel, sbDeclaraReg, sbPrimerNivel, blExecValProc,
  tbPrimKey);
  -- Proesar sentencia para consultar tabla externa
  ProcessTable (sbSentencia, chPrimerNivel, sbDeclaraReg, sbPrimerNivel,
  blExecValProc, inuNumHilo, inuNumHilos, tbPrimKey);
  -- Reporta que Termina el proceso
  ProcessFinishOK;
  -- Descarga errores en archivo y se limpia colección de errores.
  insertError (gsbTableName,
  'DL_BOPARAMETRIZACION.CargTablasPorArch.ProcessExternalTable',
  sbErrorSequence);
  FlushErrors (gsbTableName, sbErrorSequence);
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END ProcessExternalTable;
--------------------------------------------------------------------------
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   AlterSequence
Descripción :   Altera secuencia al valor maximo de la tabla
Autor       :   Leonardo Garcia
Fecha       :   22-08-2009 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE AlterSequence
IS
  cuDataFile pkConstante.tyRefCursor;
  sbSentence     VARCHAR2 (1000);
  sbColumnName   VARCHAR2 (100);
  nuMaxNumber    NUMBER;
  sbSeqFormat    VARCHAR2 (10);
  blEncontro     BOOLEAN;
  nuCurrentValue NUMBER;
  sbSeqName      VARCHAR2 (100);
  tbKeys tytbFields;
  numin_value NUMBER;
  -------------------------------------------------------------------------------------
FUNCTION fnugetMaxNumber(
    isbColumnName VARCHAR2,
    isbTableName  VARCHAR2)
  RETURN NUMBER
IS
  nuMaxNumber NUMBER;
BEGIN
  OPEN cuDataFile FOR sbSentence;
  FETCH
    cuDataFile
  INTO
    nuMaxNumber;
  CLOSE cuDataFile;
  RETURN NVL (nuMaxNumber, 0);
END;
-------------------------------------------------------------------------------------
FUNCTION fsbGetSequenceName(
    isbTableName VARCHAR2,
    onumin_value OUT NUMBER)
  RETURN VARCHAR2
IS
  CURSOR cuSequence ( isbSeqName VARCHAR2, isbSeqName1 VARCHAR2 DEFAULT NULL,
    isbSeqName2                  VARCHAR2 DEFAULT NULL)
  IS
    SELECT
      sequence_name,
      min_value
    FROM
      user_sequences
    WHERE
      sequence_name  = isbSeqName
    OR sequence_name = isbSeqName1
    OR sequence_name = isbSeqName2;
  CURSOR cuGetSeqName (isbTableName IN VARCHAR2)
  IS
    SELECT
      TABLEV_SEQUENCENAME
    FROM
      CSE_TABLE_SEQUENCE
    WHERE
      TABLEV_TABLENAME = isbTableName;
  sbSequenceName VARCHAR2 (100);
BEGIN
  IF cuGetSeqName%ISOPEN THEN
    CLOSE cuGetSeqName;
  END IF;
  -- Busca la secuencia en la tabla de secuencia de CSE
  OPEN cuGetSeqName (isbTableName);
  FETCH
    cuGetSeqName
  INTO
    sbSequenceName;
  CLOSE cuGetSeqName;
  -- Si encuentra el nombre de la secuencia entonces lo devuelve
  IF sbSequenceName IS NOT NULL THEN
    OPEN cuSequence (sbSequenceName);
    FETCH
      cuSequence
    INTO
      sbSequenceName,
      onumin_value;
    RETURN sbSequenceName;
  END IF;
  IF cuSequence%ISOPEN THEN
    CLOSE cuSequence;
  END IF;
  -- Abre el cursor
  OPEN cuSequence ('SEQ_' || isbTableName, 'SQ_' || isbTableName, 'SQ' ||
  isbTableName);
  -- Obtiene el nombre de la secuencia
  FETCH
    cuSequence
  INTO
    sbSequenceName,
    onumin_value;
  CLOSE cuSequence;
  -- Si encuentra el nombre de la secuencia entonces lo devuelve
  IF sbSequenceName IS NOT NULL THEN
    RETURN sbSequenceName;
  END IF;
  RETURN NULL;
END;
-------------------------------------------------------------------------------------
BEGIN
  --{
  pkErrors.Push ('AlterSequence');
  pkgeneralservices.tracedata ('altersequence');
  tbKeys         := ftbGetPrimaryKeyField (gsbTableName);
  IF tbKeys.COUNT = 0 THEN
    pkgeneralservices.tracedata (
    'No se pudo alterar la secuencia debido a que la entidad no tiene PK');
    pkErrors.pop;
    RETURN;
  END IF;
  IF tbKeys.COUNT > 1 THEN
    pkgeneralservices.tracedata (
    'No se altera la secuencia debido a que la PK es compuesta');
    pkErrors.pop;
    RETURN;
  END IF;
  sbColumnName := tbKeys (tbKeys.FIRST);
  -- Cuenta el total de registros.
  sbSentence := 'SELECT max(' || sbColumnName || ') FROM ' || gsbTableName;
  -- Obtiene el maximo de la tabla
  nuMaxNumber := NVL (fnugetMaxNumber (sbColumnName, gsbTableName), 0);
  pkgeneralservices.tracedata ('nuMaxNumber : ' || nuMaxNumber);
  IF (nuMaxNumber = 0) THEN
    pkErrors.pop;
    RETURN;
  END IF;
  -- Obtiene el nombre de la secuencia
  sbSeqName    := fsbGetSequenceName (gsbTableName, numin_value);
  IF sbSeqName IS NULL THEN
    pkErrors.pop;
    RETURN;
  END IF;
  pkgeneralservices.tracedata ('sbSeqName : ' || sbSeqName);
  -- Obtiene el siguiente numero de la secuencia
  nuCurrentValue := pkGeneralServices.fnugetnextsequenceval (sbSeqName);
  pkgeneralservices.tracedata ('nuCurrentValue : ' || nuCurrentValue);
  EXECUTE IMMEDIATE 'alter sequence ' || sbSeqName || ' increment BY '|| ( (
  nuCurrentValue - NVL (numin_value, 0)) - 2) * -1;
  -- Obtiene el siguiente numero de la secuencia
  nuCurrentValue := pkGeneralServices.fnugetnextsequenceval (sbSeqName);
  pkgeneralservices.tracedata ('nuCurrentValue 2: ' || nuCurrentValue);
  -- Calcula el siguiente numero para incrementar la secuencia
  nuMaxNumber := nuMaxNumber - nuCurrentValue;
  pkgeneralservices.tracedata ('nuMaxNumber : ' || nuMaxNumber);
  -- Incrementa la secuencia con el max
  EXECUTE IMMEDIATE 'alter sequence ' || sbSeqName || ' increment BY ' ||
  nuMaxNumber;
  -- Obtiene el siguiente numero de la secuencia
  nuCurrentValue := pkGeneralServices.fnugetnextsequenceval (sbSeqName);
  pkgeneralservices.tracedata ('nuCurrentValue : ' || nuCurrentValue);
  -- Incrementa la secuencia con el max
  EXECUTE IMMEDIATE 'alter sequence ' || sbSeqName || ' increment BY 1';
  pkgeneralservices.tracedata ('termina secuencia');
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  -- Incrementa la secuencia con el max
  EXECUTE IMMEDIATE 'alter sequence ' || sbSeqName || ' increment BY 1';
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  -- Incrementa la secuencia con el max
  EXECUTE IMMEDIATE 'alter sequence ' || sbSeqName || ' increment BY 1';
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  -- Incrementa la secuencia con el max
  IF sbSeqName IS NOT NULL THEN
    EXECUTE IMMEDIATE 'alter sequence ' || sbSeqName || ' increment BY 1';
  END IF;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END AlterSequence;
--------------------------------------------------------------------------------------
BEGIN
  pkErrors.push ('CargadorTablasPorArchivo');
  pkgeneralservices.tracedata ('Inicio de insercion: ' || SYSDATE);
  grctbTablas      := NULL;
  gsbErrorFileName := NULL;
  gsbTableFields   := NULL;
  gtbData.delete;
  gsbProc          := NULL;
  gsbProc1         := NULL;
  gsbFecha         := TO_CHAR (SYSDATE, 'yyyymmddhh24miss');
  gnuCompleteLines := 0;
  -- Se crea el ambiente para el manejo de tablas externas.
  CreateEnvironment (isbProcessTrack, isbFileName, isbFilePath, inuNumeroHilo,
  inuNumeroHilos, isbModo);
  -- Procesa la información de la tabla externa.
  ProcessExternalTable (inuNumeroHilo, inuNumeroHilos);
  -- Borra tabla externa
  DropExtTable;
  -- Borra el directorio
  DropDirectory;
  pkgeneralservices.tracedata ('Fin de insercion: ' || SYSDATE);
  pkgeneralservices.tracedata ('Fin Actualizacion Sentencia');
  /* pendiente de definir esto para que se haga en el proc y no por cada hilo
  */
  pkErrors.pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  DropDirectory;
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  DropDirectory;
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  DropDirectory;
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END CargadorTablasPorArchivo;
/******************************************************************
Propiedad intelectual de Open Systems (c).
Unidad  : CopiarDatosTablas
Descripcion : Copia los datos de tablas segun un archivo en otra base de
datos.
Parámetros   Descripción
============    ===================
isbPath                 in  Directorio donde esta el archivo con la lista de
tablas,
isbNombArchivo          in  Nombre del archivo con la lista de tablas a extraer
,
isbUsuarioBDOrigen      in  Usuario de la base de datos de la cual se van a
extraer los datos
isbPwdBDOrigen          in  Pwd de la base de datos de la cual se van a extraer
los datos
isbInstanciaBDOrigen    in  Instancia de la base de datos de la cual se van a
extraer los datos
Autor  : Leonardo Garcia Q.
Fecha  : 11/04/2009
Historia de Modificaciones
Fecha           Autor               Modificacion
===========     =================== ====================
*********************************************************************/
PROCEDURE CopiarDatosTablas(
    isbPath              IN VARCHAR2,
    isbNombArchivo       IN VARCHAR2,
    isbDBLINK            IN VARCHAR2,
    isbInstanciaBDOrigen IN VARCHAR2 DEFAULT NULL,
    isbUsuarioBDOrigen   IN VARCHAR2 DEFAULT NULL,
    isbPwdBDOrigen       IN VARCHAR2 DEFAULT NULL,
    isbOnlyVal           IN BOOLEAN DEFAULT FALSE)
IS
  sbNombArchZip VARCHAR2 (100);
  nuPosition    NUMBER;
  --------------- METODOS ENCAPSULADOS --------------------------
PROCEDURE ClearMemory
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.CopiarDatosTablas.ClearMemory');
  gsbOnlyVal := NULL;
  gtbErrorsFileName.delete;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END ClearMemory;
------------------------------------------------------------------------------------------------
PROCEDURE DropDBLink(
    isbUsuarioBDOrigen IN VARCHAR2,
    isbNomDBLink       IN VARCHAR2)
IS
  sbDBLinkSentence VARCHAR2 (100);
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.CopiarDatosTablas.DropDBLink');
  IF isbUsuarioBDOrigen IS NULL THEN
    pkErrors.pop;
    RETURN;
  END IF;
  sbDBLinkSentence := 'DROP DATABASE LINK ' || isbNomDBLink;
  BEGIN
    EXECUTE IMMEDIATE sbDBLinkSentence;
  EXCEPTION
  WHEN OTHERS THEN
    NULL;
  END;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END DropDBLink;
------------------------------------------------------------------------------------------------
PROCEDURE CreateDBLink(
    isbUsuarioBDOrigen   IN VARCHAR2,
    isbPwdBDOrigen       IN VARCHAR2,
    isbInstanciaBDOrigen IN VARCHAR2,
    osbNomDBLink OUT VARCHAR2)
IS
  sbDBLinkSentence VARCHAR2 (200);
BEGIN
  pkerrors.push ( 'DL_BOPARAMETRIZACION.CopiarDatosTablas.CreateDBLink');
  osbNomDBLink           := 'DB_' || isbInstanciaBDOrigen;
  IF (isbUsuarioBDOrigen IS NULL) THEN
    pkErrors.pop;
    RETURN;
  END IF;
  DropDBLink (isbUsuarioBDOrigen, osbNomDBLink);
  sbDBLinkSentence := 'CREATE DATABASE LINK ' || osbNomDBLink || ' connect to '
  || isbUsuarioBDOrigen || ' identified by ' || isbPwdBDOrigen || ' using '''
  || isbInstanciaBDOrigen || '''';
  EXECUTE IMMEDIATE sbDBLinkSentence;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END CreateDBLink;
------------------------------------------------------------------------------------------------
PROCEDURE SetProcessData
IS
  nuPosition NUMBER;
BEGIN
  pkErrors.Push ( 'DL_BOPARAMETRIZACION.CopiarDatosTablas.SetProcessData');
  gsbPathFile := isbPath;
  IF isbOnlyVal THEN
    gsbOnlyVal := pkConstante.SI;
  ELSE
    gsbOnlyVal := pkConstante.NO;
  END IF;
  -- Arma el nombre del archivo de errores.
  gsbErrorSequence := TO_CHAR (SYSDATE, 'yyyymmddhh24miss');
  -- Extrae el nombre del archivo.
  nuPosition      := INSTR (isbNombArchivo, '.');
  IF (nuPosition   > 0) THEN
    sbNombArchZip := SUBSTR (isbNombArchivo, 1, nuPosition - 1);
  ELSE
    sbNombArchZip := isbNombArchivo;
  END IF;
  gsbZipFileName := sbNombArchZip || '-' || gsbErrorSequence || '.zip';
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END SetProcessData;
-------------------------------------------------------------------------
PROCEDURE CreateTotalFile(
    isbNombArchivo VARCHAR2,
    isbPathFile    VARCHAR2)
IS
  fdFile UTL_FILE.file_type;
  nuPosition NUMBER;
  sbNombArch VARCHAR2 (100);
BEGIN
  -- Extrae el nombre del archivo.
  sbNombArch := isbNombArchivo || '-' || gsbErrorSequence || '.tot';
  -- Crea Directorio
  CreateDirectoryHSPPP (isbPathFile || '/', isbNombArchivo);
  fdFile := pkUtlFileMgr.Fopen (isbPathFile, sbNombArch, 'a');
  pkUtlFileMgr.Put_Line (fdFile,
  '*****************************************************************************'
  );
  pkUtlFileMgr.Put_Line (fdFile,
  '********************     RESULTADO DE CARGA *********************************'
  );
  pkUtlFileMgr.Put_Line (fdFile,
  '*****************************************************************************'
  );
  pkUtlFileMgr.Put_Line (fdFile,
  '   TABLA                 |        INSERTADOS         |       RECHAZADOS     |'
  );
  pkUtlFileMgr.fclose (fdFile);
END;
-------------------------------------------------------------------------
BEGIN
  pkErrors.push ('DL_BOPARAMETRIZACION.CopiarDatosTablas');
  ut_trace.trace ('INICIO PROCESO', 2);
  --ut_trace.trace('HHH INICIO PROCESO:[CopiarDatosTablas]',2);
  --ut_trace.trace('HHH VARIABLES:[isbNombArchivo]:'||isbNombArchivo,2);
  --ut_trace.trace('HHH VARIABLES:[isbPath]:'||isbPath,2);
  --ut_trace.trace('HHH VARIABLES:[isbDBLINK]:'||isbDBLINK,2);
  ClearMemory;
  --ut_trace.trace('HHH TERMINO PROCESO:[ClearMemory]',2);
  --ut_trace.trace('HHH INICIO PROCESO:[SetProcessData]',2);
  -- Fija en memoria datos del proceso
  SetProcessData;
  --ut_trace.trace('HHH VARIABLES:[gsbErrorSequence]:'||gsbErrorSequence,2);
  --ut_trace.trace('HHH TERMINO PROCESO:[SetProcessData]',2);
  -- Crea archivo de  totales
  --ut_trace.trace('HHH INICIO PROCESO:[CreateTotalFile]',2);
  CreateTotalFile (isbNombArchivo, isbPath);
  ut_trace.trace ('HHH TERMINO PROCESO:[CreateTotalFile]', 2);
  gsbNomDBLink := isbDBLINK;
  ut_trace.trace ('gsbNomDBLink:' || isbDBLINK, 2);
  -- Crea el dblink para conectarse a la base de datos origen
  -- CreateDBLink(isbUsuarioBDOrigen,isbPwdBDOrigen,isbInstanciaBDOrigen,
  -- gsbNomDBLink);
  pkgeneralservices.tracedata ('Extraer tablas');
  -- Extraer Datos de la base de datos origen
  ut_trace.trace ('inicio de extraertablas', 2);
  ExtraerTablas (isbPath, isbNombArchivo, gsbNomDBLink, gsbErrorSequence, TRUE);
  ut_trace.trace ('termino de extraertablas', 2);
  -- Borra el dblink
  -- DropDBLink(isbUsuarioBDOrigen,gsbNomDBLink);
  -- Llena archivo de errores, creando el archivo de errores
  ut_trace.trace ('inicio de FlushErrors', 2);
  insertError (isbNombArchivo,'DL_BOPARAMETRIZACION.CopiarDatosTablas',
  gsbErrorSequence);
  FlushErrors (isbNombArchivo, gsbErrorSequence, FALSE);
  pkErrors.pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END CopiarDatosTablas;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   CrearArchivoEje
Descripción :   Crear Archivo de ejecucion del cargador de archivos de tablas
basicas
____________________________________________________________________________
Parámetros      |   Descripción
________________|___________________________________________________________
________________|___________________________________________________________
Autor       :   Leonardo Garcia
Fecha       :
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE CrearArchivoEje(
    isbPath        IN VARCHAR2,
    isbNombarchivo IN VARCHAR2)
IS
  sbNombTabla    VARCHAR2 (100);
  sbComments     VARCHAR2 (1000);
  sbSentence     VARCHAR2 (4000);
  sbCreate       VARCHAR2 (4000);
  sbProced       VARCHAR2 (4000);
  sbCamposDummy  VARCHAR2 (200);
  sbTipoRegistro VARCHAR2 (100);
  sbParameters   VARCHAR2 (200);
  fdArchivo UTL_FILE.file_type;
  ------------------------------------------------------------------------------------------------
FUNCTION fsbGetTipoRegistro(
    isbTableName VARCHAR2)
  RETURN VARCHAR2
IS
BEGIN
  --{
  pkErrors.Push ('DL_BOPARAMETRIZACION.CrearArchivoEje.fsbGetTipoRegistro');
  -- Valida si existe el primer nivel de tabla de OSS
  IF (fblExistsValProcedure ('DA' || isbTableName)) THEN
    pkErrors.pop;
    RETURN 'DA' || isbTableName || '.STY' || isbTableName || ';';
    -- Valida si existe el primer nivel de tabla de BSS
  ELSIF (fblExistsValProcedure ('pktbl' || isbTableName)) THEN
    pkErrors.pop;
    RETURN isbTableName || '%rowtype;';
  END IF;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END fsbGetTipoRegistro;
------------------------------------------------------------------------------------------------
FUNCTION fsbGetCamposDummy(
    isbPath        VARCHAR2,
    isbNombarchivo VARCHAR2)
  RETURN VARCHAR2
IS
  sbCampos      VARCHAR2 (1000);
  sbCamposDummy VARCHAR2 (1000);
  sbCadena      VARCHAR2 (1000);
BEGIN
  --{
  pkErrors.Push ( 'DL_BOPARAMETRIZACION.CrearArchivoEje.fsbGetCamposDummy');
  -- Obtiene los nombres de los campos del archivo
  sbCampos := UPPER ( fsbGetFieldsFromfile ('ESTAPROG', isbPath, isbNombarchivo
  ) || ',');
  LOOP
    sbCadena := SUBSTR (sbCampos, INSTR (sbCampos, csbDUMMY_));
    -- Si no encontro la cadena dummy_
    IF (NVL (sbCadena, 0) = NVL (sbCampos, 0)) THEN
      pkErrors.pop;
      -- Elimina la ultma coma
      sbCamposDummy := SUBSTR (sbCamposDummy, 1, INSTR (sbCamposDummy, ',', -1)
                                                                            - 1
      );
      RETURN sbCamposDummy;
    END IF;
    sbCamposDummy := sbCamposDummy || '    ' || SUBSTR (sbCadena, 1, INSTR (
    sbCadena, ',')                                      - 1) || ' varchar2,' || CHR (10);
    sbCampos := SUBSTR (sbCadena, INSTR (sbCadena, ',') + 1);
  END LOOP;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
  --}
END fsbGetCamposDummy;
------------------------------------------------------------------------------------------------
BEGIN
  --{
  pkErrors.Push ('DL_BOPARAMETRIZACION.CrearArchivoEje');
  sbNombTabla := fsbGetTableName (isbNombarchivo);
  -- Obtiene los campos dummys del archivo
  sbCamposDummy := fsbGetCamposDummy (isbPath, isbNombarchivo);
  -- Obtiene el tipo de registro segun tablas
  sbTipoRegistro := REPLACE (fsbGetTipoRegistro (sbNombTabla), ';', ' ');
  sbComments     :=
  '/*******************************************************************************'
  || CHR (10) ||
  '     Propiedad intelectual de Open International Systems (c).' || CHR (10)
  || '     Procedure   :   ' || 'DL_EXE_' || sbNombTabla || CHR (10) ||
  '     Descripción :   <DESCRIPCION_PROCEDIMIENTO>' || CHR (10) || CHR (10) ||
  '     Autor       :   <AUTOR>' || CHR (10) || '     Fecha       :   <FECHA>'
  || CHR (10) || CHR (10) || '     Historia de Modificaciones' || CHR (10) ||
  '     Fecha       IDEntrega' || CHR (10) || CHR (10) ||
  '     <FECHA>     <IDENTREGA>' || CHR (10) || '     Creación.' || CHR (10) ||
  '*******************************************************************************/'
  || CHR (10);
  sbCreate := 'CREATE OR  PROCEDURE ' || 'DL_EXE_' || INITCAP (sbNombTabla) ||
  CHR (10);
  sbParameters := '(' || CHR (10) || '    iorc' || sbNombTabla || ' in out ' ||
  sbTipoRegistro;
  -- Si tiene campos dummy los adiciona
  IF (sbCamposDummy IS NOT NULL) THEN
    sbParameters    := sbParameters || ',' || CHR (10) || sbCamposDummy || CHR
    (10);
  END IF;
  sbParameters := sbParameters || CHR (10) || ') IS' || CHR (10);
  sbProced     := 'BEGIN ' || CHR (10) || '    pkErrors.push(''DL_EXE_' ||
  INITCAP (sbNombTabla) || ''');' || CHR (10) || CHR (10) ||
  '    /* INSERTE OPERACIONES Y VALIDACIONES AQUI' || CHR (10) || CHR (10) ||
  '    /*--Ejemplo de las validaciones que se pueden hacer ' || CHR (10) ||
  '    if (campo1 = condicion) then' || CHR (10) ||
  '        pkErrors.SetErrorCode(numError);' || CHR (10) ||
  '        raise login_denied;' || CHR (10) || '    end if; */' || CHR (10) ||
  CHR (10) || '    pkErrors.pop;' || CHR (10) || 'END;' || CHR (10) || '/';
  -- Crea el archivo
  fdArchivo := pkUtlFileMgr.Fopen (isbPath, 'prDL_EXE_' || INITCAP (sbNombTabla
  ) || '.sql','w');
  -- Adiciona las lineas al archivo.
  pkUtlFileMgr.Put_Line ( fdArchivo, sbComments || sbCreate || sbParameters ||
  sbProced);
  -- Cierra Archivo
  pkUtlFileMgr.fclose (fdArchivo);
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END CrearArchivoEje;
-----------------------------------------------------------------------------------------------
FUNCTION fsgbCREARCADENALINEASRECTAS(
    isbCoor VARCHAR2)
  RETURN MDSYS.SDO_GEOMETRY
IS
  osgline MDSYS.SDO_GEOMETRY;
  sbCoor VARCHAR2 (1000);
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.fsgbCREARCADENALINEASRECTAS');
  -- Crea linea recta
  AB_BOGEOMETRIA.CREARCADENALINEASRECTAS (isbCoor, osgline);
  pkerrors.pop;
  RETURN osgline;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END;
PROCEDURE CreateDirectory(
    isbPath    IN VARCHAR2,
    isbDirName IN VARCHAR2)
IS
BEGIN
  pkErrors.Push ('DL_BOPARAMETRIZACION.ProcessHSPTP.CreateDirectory');
  pkgeneralservices.tracedata ('mkdir -m777 ' || isbPath || '/' || isbDirName);
  llamasist ('mkdir -m777 ' || isbPath || '/' || isbDirName);
  DBMS_LOCK.sleep (3);
  pkErrors.Pop;
EXCEPTION
WHEN ex.CONTROLLED_ERROR THEN
  RAISE ex.CONTROLLED_ERROR;
WHEN OTHERS THEN
  Errors.setError;
  RAISE ex.CONTROLLED_ERROR;
END CreateDirectory;
/******************************************************************
Propiedad intelectual de Open Systems (c).
Unidad  : ProcessHSPTP
Descripcion :
Parámetros   Descripción
============    ===================
Autor  : K        arina J. Cerón V.
Fecha  : 06/05/2013
Historia de Modificaciones
Fecha           Autor               Modificacion
===========     =================== ====================
*********************************************************************/
PROCEDURE ProcessHSPTP
IS
  nuDirectoryId ge_directory.directory_id%TYPE;
  sbPath ge_directory.PATH%TYPE;
  sbNombArchivo   VARCHAR2 (2000);
  onuErrorCode    NUMBER;
  osbErrorMessage VARCHAR2 (2000);
BEGIN
  NULL;
EXCEPTION
WHEN ex.CONTROLLED_ERROR THEN
  Errors.geterror (onuErrorCode, osbErrorMessage);
  pkgeneralservices.tracedata ('SALIDA onuErrorCode: ' || onuErrorCode);
  pkgeneralservices.tracedata ( 'SALIDA osbErrorMess: ' || osbErrorMessage);
WHEN OTHERS THEN
  Errors.seterror;
  Errors.geterror (onuErrorCode, osbErrorMessage);
  pkgeneralservices.tracedata ('SALIDA onuErrorCode: ' || onuErrorCode);
  pkgeneralservices.tracedata ('SALIDA osbErrorMess: ' || osbErrorMessage);
END ProcessHSPTP;
/******************************************************************
Propiedad intelectual de Open Systems (c).
Unidad  : frcGetAmbientes
Descripcion : Obtiene los resultados de la grilla del ejecutable HSPPP
donde se obtienen todos los ambientes donde se aplicará la transformación.
Proceso Paso de Parametrización
Parámetros   Descripción
============    ===================
Autor  : Paula Garcia
Fecha  : 09/07/2013
Historia de Modificaciones
Fecha           Autor               Modificacion
===========     =================== ====================
*********************************************************************/
FUNCTION frcGetAmbientes
  RETURN constants.tyRefCursor
IS
  sbProcessInstance GE_BOInstanceControl.stysbName;
  rcResult Constants.tyRefCursor;
BEGIN
  ge_boinstancecontrol.GetCurrentInstance (sbProcessInstance);
  OPEN rcResult FOR SELECT DATABASE_ID ID,
  DATABASE_NAME AMBIENTE,
  DATABASE_OWNER USUARIO,
  IS_PROCESS PROCESADA FROM CSE_DATABASE_PROCESS;
  RETURN rcResult;
EXCEPTION
WHEN ex.CONTROLLED_ERROR THEN
  RAISE ex.CONTROLLED_ERROR;
WHEN OTHERS THEN
  Errors.setError;
  RAISE ex.CONTROLLED_ERROR;
END frcGetAmbientes;
/******************************************************************
Propiedad intelectual de Open Systems (c).
Unidad  : ProcessHSPPP
Descripcion : Obtiene los resultados de la grilla del ejecutable HSPPP
donde se obtienen todos los ambientes donde se aplicará la transformación
Parámetros   Descripción
============    ===================
Autor  : Paula Garcia
Fecha  : 09/07/2013
Historia de Modificaciones
Fecha           Autor               Modificacion
===========     =================== ====================
*********************************************************************/
PROCEDURE ProcessHSPPP
IS
  nuDirectoryId ge_directory.directory_id%TYPE;
  sbPath ge_directory.PATH%TYPE;
  sbNombArchivo VARCHAR2 (2000);
  sbAmbienteId  NUMBER;
  ------------------------------------------------------------------------
BEGIN
  NULL;
EXCEPTION
WHEN ex.CONTROLLED_ERROR THEN
  RAISE;
WHEN OTHERS THEN
  RAISE;
END ProcessHSPPP;
/******************************************************************
Propiedad intelectual de Open Systems (c).
Unidad  : setDB_LINK
Descripcion : G   uarda en memoria el nombre del DB_LINK
Parámetros   Descripción
============    ===================
Autor  : Paula Garcia
Fecha  : 09/07/2013
Historia de Modificaciones
Fecha           Autor               Modificacion
===========     =================== ====================
*********************************************************************/
PROCEDURE setDB_LINK(
    isbDB_LINK VARCHAR2)
IS
BEGIN
  pkErrors.Push ('setDB_LINK');
  gsbDB_LINK := isbDB_LINK;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END setDB_LINK;
/******************************************************************
Propiedad intelectual de Open Systems (c).
Unidad  : setDB
Descripcion : Guarda en memoria el nombre de la DB
Parámetros   Descripción
============    ===================
Autor  : Saúl Trujillo
Fecha  : 31/03/2014
Historia de Modificaciones
Fecha           Autor               Modificacion
===========     =================== ====================
*********************************************************************/
PROCEDURE setDB(
    isbDB VARCHAR2)
IS
BEGIN
  pkErrors.Push ('setDB');
  gsbDB := isbDB;
  pkErrors.Pop;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END setDB;
/***************************************************************************
Propiedad intelectual de Open International Systems (c).
Procedure   :   fsbgetDB_LINK
Descripción :   Obtiene de memoria el nombre del db_link
Autor       :   Leonardo Garcia Q.
Fecha       :   14-01-2010 10:00:00
Historia de Modificaciones
Fecha       IDEntrega
14-01-2010
Creación.
***************************************************************************/
FUNCTION fsbgetDB_LINK
  RETURN VARCHAR2
IS
BEGIN
  pkErrors.Push ('fsbgetDB_LINK');
  pkErrors.Pop;
  RETURN gsbDB_LINK;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END fsbgetDB_LINK;
/***************************************************************************
Propiedad intelectual de Open International Systems (c).
Procedure   :   fsbgetDB
Descripción :   Obtiene de memoria el nombre de la DB
Autor       :   Saúl Trujillo
Fecha       :   31/03/2017
Historia de Modificaciones
Fecha       IDEntrega
***************************************************************************/
FUNCTION fsbgetDB
  RETURN VARCHAR2
IS
BEGIN
  pkErrors.Push ('fsbgetDB');
  pkErrors.Pop;
  RETURN gsbDB;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END fsbgetDB;
/***************************************************************************
Propiedad intelectual de Open International Systems (c).
Procedure   :   GetPrimaryAndValues
Descripción :   Con las llaves primarias y los VALUES arma una cadena de tipo
llave=valor|llave2= valor2| para insertar en el campo
record de dl_log_process
Autor       :   Paula Garcia
Fecha       :   12-07-2013
Historia de Modificaciones
Fecha       IDEntrega
12-07-2013
Creación.
***************************************************************************/
PROCEDURE GetPrimaryAndValues
IS
  tbPksNames tytbFields;
  blEsPk           BOOLEAN;
  sbCadenatoInsert VARCHAR (2000);
  sbRecordtoInsert VARCHAR (2000);
  orctbColumns tyrcFields;
  ------------------------------------------------------------------------
FUNCTION fblEsPk(
    isbColumnName VARCHAR2)
  RETURN BOOLEAN
IS
  CURSOR cuIsPrimary
  IS
    SELECT
      COUNT (1)
    FROM
      user_constraints a,
      user_cons_columns b
    WHERE
      a.table_name        = gsbNombreTabla
    AND a.CONSTRAINT_TYPE = 'P'
    AND B.COLUMN_NAME     = isbColumnName
    AND a.constraint_name = b.constraint_name;
  nuIsPk NUMBER;
BEGIN
  OPEN cuIsPrimary;
  FETCH
    cuIsPrimary
  INTO
    nuIsPk;
  CLOSE cuIsPrimary;
  IF nuIsPk < 1 THEN
    RETURN FALSE;
  ELSE
    RETURN TRUE;
  END IF;
END fblEsPk;
------------------------------------------------------------------------
PROCEDURE GetTableFields(
    isbTableName VARCHAR2,
    orctbFields OUT NOCOPY tyrcFields)
IS
  CURSOR cuFields
  IS
    SELECT
      column_name,
      data_type
    FROM
      user_tab_COLUMNS
    WHERE
      table_name = UPPER (isbTableName)
    ORDER BY
      column_id;
  CURSOR cuFieldsStandard
  IS
    SELECT
      column_name,
      data_type
    FROM
      user_tab_COLUMNS
    WHERE
      table_name       = UPPER (isbTableName)
    AND DATA_TYPE NOT IN ('SDO_GEOMETRY', 'CLOB','BLOB')
    ORDER BY
      column_id;
  tbColumn_name tytbFields;
  tbData_type tytbFields;
BEGIN
  pkerrors.push ('Processfile.GetTableFields');
  IF (cuFields%ISOPEN) THEN
    pkErrors.pop;
    CLOSE cuFields;
  END IF;
  IF (cuFieldsStandard%ISOPEN) THEN
    pkErrors.pop;
    CLOSE cuFieldsStandard;
  END IF;
  IF fnuGetOracleEdition = 1 THEN
    OPEN cuFields;
    FETCH
      cuFields BULK COLLECT
    INTO
      tbColumn_name,
      tbData_type;
    CLOSE cuFields;
  ELSE
    OPEN cuFieldsStandard;
    FETCH
      cuFieldsStandard BULK COLLECT
    INTO
      tbColumn_name,
      tbData_type;
    CLOSE cuFieldsStandard;
  END IF;
  orctbFields.tbfield_name := tbColumn_name;
  orctbFields.tbdata_type  := tbData_type;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END GetTableFields;
------------------------------------------------------------------------
BEGIN
  tbPksNames := ftbGetPrimaryKeyField (gsbNombreTabla);
  GetTableFields (gsbNombreTabla, orctbColumns);
  FOR nuIdx IN gsbDataTable.tbcolumn_name.FIRST ..
  gsbDataTable.tbcolumn_name.LAST
  LOOP
    blEsPk := fblEsPk (gsbDataTable.tbcolumn_name (nuIdx));
    IF blEsPk THEN
      sbCadenatoInsert := sbCadenatoInsert || gsbDataTable.tbcolumn_name (nuIdx
      ) || '=' || gtbData (nuIdx) || '|';
    END IF;
  END LOOP;
  IF (sbCadenatoInsert IS NULL) THEN
    FOR nuIdx IN gsbDataTable.tbcolumn_name.FIRST ..
    gsbDataTable.tbcolumn_name.LAST
    LOOP
      sbCadenatoInsert := sbCadenatoInsert || gsbDataTable.tbcolumn_name (nuIdx
      ) || '=' || gtbData (nuIdx) || '|';
    END LOOP;
  END IF;
  gsbCadenatoInsert := sbCadenatoInsert;
  gsbRecordtoInsert := sbRecordtoInsert;
  SetgsbCadenatoInsert (gsbCadenatoInsert);
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END GetPrimaryAndValues;
/***************************************************************************
Propiedad intelectual de Open International Systems (c).
Procedure   :  InsRegNoProcess
Descripción :  Inserta el registro no procesado en dl_log_process
Autor       :   Paula Garcia
Fecha       :   12-07-2013
Historia de Modificaciones
Fecha       IDEntrega
Creación.
***************************************************************************/
PROCEDURE InsRegNoProcess
IS
  sbDataBase VARCHAR2 (200);
  sbRecord   VARCHAR2 (4000);
  sbExecute VARCHAR2 (4000);
  --rcdl_log_process cse.dl_log_process%ROWTYPE;
BEGIN
  sbDataBase              := fsbgetDB;
  sbRecord                := gsbCadenatoInsert;
  /*rcdl_log_process.log_id := pkgeneralservices.fnuGetNextSequenceVal (sbSchemaCSE||'.SEQ_DL_LOG_PROCESS');
  rcdl_log_process.row_id        := gsbCadenatoInsert;
  rcdl_log_process.TABLE_NAME    := gsbNombreTabla;
  rcdl_log_process.DATABASE_NAME := sbDataBase;
  rcdl_log_process.IS_PROCESS    := 'N';
  rcdl_log_process.PROCESS_NAME  := gsbEstaprog;
  rcdl_log_process.RECORD        := gsbRecordtoInsert;*/
  IF fblExistsDL_LOG_PROCESS (gsbCadenatoInsert,gsbNombreTabla, sbDataBase) THEN
    sbExecute := 'UPDATE '||sbSchemaCSE||'.dl_log_process SET IS_PROCESS = '||chr(39)||'N'||chr(39)||', PROCESS_NAME = '||chr(39)||gsbEstaprog||chr(39)||', RECORD = '||chr(39)||gsbRecordtoInsert||chr(39)||' WHERE row_id = '||chr(39)||gsbCadenatoInsert||chr(39)||' AND TABLE_NAME = '||chr(39)||gsbNombreTabla||chr(39)||' AND database_name = '||chr(39)||sbDataBase||chr(39)||' ';
    execute immediate sbExecute;
  ELSE
    sbExecute := 'INSERT INTO '||sbSchemaCSE||'.dl_log_process (log_id,row_id,TABLE_NAME,DATABASE_NAME,IS_PROCESS,PROCESS_NAME,RECORD) VALUES ('||pkgeneralservices.fnuGetNextSequenceVal(sbSchemaCSE||'.SEQ_DL_LOG_PROCESS')||','||chr(39)||gsbCadenatoInsert||chr(39)||','||chr(39)||gsbNombreTabla||chr(39)||','||chr(39)||sbDataBase||chr(39)||','||chr(39)||'N'||chr(39)||','||chr(39)||gsbEstaprog||chr(39)||','||chr(39)||gsbRecordtoInsert||chr(39)||')';
    execute immediate sbExecute;
  END IF;
  --ut_trace.trace('JJJ inserto',2);
  COMMIT;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END InsRegNoProcess;
/***************************************************************************
Propiedad intelectual de Open International Systems (c).
Procedure   :  InsRegOkProcess
Descripción :  Inserta el registro procesado en dl_log_process
Autor       :   Paula Garcia
Fecha       :   12-07-2013
Historia de Modificaciones
Fecha       IDEntrega
12-07-2013
Creación.
***************************************************************************/
PROCEDURE InsRegOkProcess
IS
  sbDataBase VARCHAR2 (200);
  sbRecord   VARCHAR2 (10000);
  sbExecute VARCHAR2 (4000);
  --rcdl_log_process cse.dl_log_process%ROWTYPE;
BEGIN
  sbDataBase              := fsbgetDB;
  sbRecord                := gsbCadenatoInsert;
  /*rcdl_log_process.log_id := pkgeneralservices.fnuGetNextSequenceVal(sbSchemaCSE||'.SEQ_DL_LOG_PROCESS');
  rcdl_log_process.row_id        := gsbCadenatoInsert;
  rcdl_log_process.TABLE_NAME    := gsbNombreTabla;
  rcdl_log_process.DATABASE_NAME := sbDataBase;
  rcdl_log_process.IS_PROCESS    := 'S';
  rcdl_log_process.PROCESS_NAME  := gsbEstaprog;
  rcdl_log_process.RECORD        := gsbRecordtoInsert;*/
  IF fblExistsDL_LOG_PROCESS (sbRecord, gsbNombreTabla, sbDataBase) THEN
        sbExecute := 'UPDATE '||sbSchemaCSE||'.dl_log_process SET IS_PROCESS = '||chr(39)||'S'||chr(39)||', PROCESS_NAME = '||chr(39)||gsbEstaprog||chr(39)||', RECORD = '||chr(39)||gsbRecordtoInsert||chr(39)||' WHERE row_id = '||chr(39)||gsbCadenatoInsert||chr(39)||' AND TABLE_NAME = '||chr(39)||gsbNombreTabla||chr(39)||' AND database_name = '||chr(39)||sbDataBase||chr(39)||' ';
	 execute immediate sbExecute;
  ELSE
    sbExecute := 'INSERT INTO '||sbSchemaCSE||'.dl_log_process (log_id,row_id,TABLE_NAME,DATABASE_NAME,IS_PROCESS,PROCESS_NAME,RECORD) VALUES ('||pkgeneralservices.fnuGetNextSequenceVal(sbSchemaCSE||'.SEQ_DL_LOG_PROCESS')||','||chr(39)||gsbCadenatoInsert||chr(39)||','||chr(39)||gsbNombreTabla||chr(39)||','||chr(39)||sbDataBase||chr(39)||','||chr(39)||'S'||chr(39)||','||chr(39)||gsbEstaprog||chr(39)||','||chr(39)||gsbRecordtoInsert||chr(39)||')';
    execute immediate sbExecute;
  END IF;
EXCEPTION
WHEN LOGIN_DENIED THEN
  pkErrors.Pop;
  RAISE LOGIN_DENIED;
WHEN pkConstante.exERROR_LEVEL2 THEN
  pkErrors.Pop;
  RAISE pkConstante.exERROR_LEVEL2;
WHEN OTHERS THEN
  pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, sbErrMsg);
  pkErrors.Pop;
  raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END InsRegOkProcess;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   SetgsbNombreTabla
Descripción :
Autor       :   Paula Garcia
Fecha       :   17-07-2013 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE SetgsbNombreTabla
  (
    isbNombreTabla VARCHAR2
  )
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.SetgsbNombreTabla');
  gsbNombreTabla := isbNombreTabla;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END SetgsbNombreTabla;
/***************************************************************************
Propiedad intelectual de Open International Systems (c).
Procedure   :   fsbGetgsbNombreTabla
Descripción :
Autor       :   Paula Garcia
Fecha       :
Historia de Modificaciones
Fecha       IDEntrega
Creación.
***************************************************************************/
FUNCTION fsbGetgsbNombreTabla
  RETURN VARCHAR2
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.gsbNombreTabla');
  pkerrors.pop;
  RETURN gsbNombreTabla;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END fsbGetgsbNombreTabla;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   SetgsbDataTable
Descripción :   gsbDataTable            tyrctbTablas;
Autor       :   Paula Garcia
Fecha       :   17-07-2013 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE SetgsbDataTable
  (
    isbDataTable tyrctbTablas
  )
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.SetgsbDataTable');
  gsbDataTable := isbDataTable;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END SetgsbDataTable;
/***************************************************************************
Propiedad intelectual de Open International Systems (c).
Procedure   :   fsbGetgsbDataTable
Descripción :
Autor       :   Paula Garcia
Fecha       :
Historia de Modificaciones
Fecha       IDEntrega
Creación.
***************************************************************************/
FUNCTION fsbGetgsbDataTable
  RETURN tyrctbTablas
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.fsbGetgsbDataTable');
  pkerrors.pop;
  RETURN gsbDataTable;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END fsbGetgsbDataTable;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   SetgtbData
Descripción :   gtbData                 tytbCondicion;
Autor       :   Paula Garcia
Fecha       :   17-07-2013 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE SetgtbData
  (
    itbData tytbCondicion
  )
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.SetgtbData');
  gtbData := itbData;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END SetgtbData;
/***************************************************************************
Propiedad intelectual de Open International Systems (c).
Procedure   :   fsbGetgtbData
Descripción :
Autor       :   Paula Garcia
Fecha       :
Historia de Modificaciones
Fecha       IDEntrega
Creación.
***************************************************************************/
FUNCTION fsbGetgtbData
  RETURN tyrctbTablas
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.fsbGetgtbData');
  pkerrors.pop;
  RETURN gsbDataTable;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END fsbGetgtbData;
/******************************************************************************
*
Propiedad intelectual de Open International Systems (c).
Procedure   :   SetgsbCadenatoInsert
Descripción :   gsbCadenatoInsert       varchar2(2000);
Autor       :   Paula Garcia
Fecha       :   17-07-2013 11:15:26
Historia de Modificaciones
Fecha       IDEntrega
Creación.
******************************************************************************
*/
PROCEDURE SetgsbCadenatoInsert
  (
    isbCadenatoInsert VARCHAR2
  )
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.SetgsbCadenatoInsert');
  gsbCadenatoInsert := isbCadenatoInsert;
  pkerrors.pop;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END SetgsbCadenatoInsert;
/***************************************************************************
Propiedad intelectual de Open International Systems (c).
Procedure   :   fsbGetgsbCadenatoInsert
Descripción :
Autor       :   Paula Garcia
Fecha       :
Historia de Modificaciones
Fecha       IDEntrega
Creación.
***************************************************************************/
FUNCTION fsbGetgsbCadenatoInsert
  RETURN VARCHAR2
IS
BEGIN
  pkerrors.push ('DL_BOPARAMETRIZACION.fsbGetgsbCadenatoInsert');
  pkerrors.pop;
  RETURN gsbCadenatoInsert;
EXCEPTION
WHEN LOGIN_DENIED OR pkconstante.exerror_level2 THEN
  pkerrors.pop;
  RAISE;
WHEN OTHERS THEN
  pkerrors.notifyerror (pkerrors.fsblastobject, SQLERRM, sbErrMsg);
  pkerrors.pop;
  raise_application_error (pkconstante.nuerror_level2, sbErrMsg);
END fsbGetgsbCadenatoInsert;
END DL_BOPARAMETRIZACION;
/
