CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_ITEMS_METRAJE_COT
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    04/05/2024              PAcosta         OSF-2776: Cambio de esquema ADM_PERSON                              
    ****************************************************************/
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type
	)
	IS
		SELECT LDC_ITEMS_METRAJE_COT.*,LDC_ITEMS_METRAJE_COT.rowid
		FROM LDC_ITEMS_METRAJE_COT
		WHERE
		    ID_ITEM = inuID_ITEM
		    and ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA
		    and ID_PROYECTO = inuID_PROYECTO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ITEMS_METRAJE_COT.*,LDC_ITEMS_METRAJE_COT.rowid
		FROM LDC_ITEMS_METRAJE_COT
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ITEMS_METRAJE_COT  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ITEMS_METRAJE_COT is table of styLDC_ITEMS_METRAJE_COT index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ITEMS_METRAJE_COT;

	/* Tipos referenciando al registro */
	type tytbID_COTIZACION_DETALLADA is table of LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type index by binary_integer;
	type tytbID_ITEM is table of LDC_ITEMS_METRAJE_COT.ID_ITEM%type index by binary_integer;
	type tytbFLAUTA is table of LDC_ITEMS_METRAJE_COT.FLAUTA%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type index by binary_integer;
	type tytbBBQ is table of LDC_ITEMS_METRAJE_COT.BBQ%type index by binary_integer;
	type tytbHORNO is table of LDC_ITEMS_METRAJE_COT.HORNO%type index by binary_integer;
	type tytbESTUFA is table of LDC_ITEMS_METRAJE_COT.ESTUFA%type index by binary_integer;
	type tytbSECADORA is table of LDC_ITEMS_METRAJE_COT.SECADORA%type index by binary_integer;
	type tytbCALENTADOR is table of LDC_ITEMS_METRAJE_COT.CALENTADOR%type index by binary_integer;
	type tytbLOG_VAL_BAJANTE is table of LDC_ITEMS_METRAJE_COT.LOG_VAL_BAJANTE%type index by binary_integer;
	type tytbLONG_BAJANTE is table of LDC_ITEMS_METRAJE_COT.LONG_BAJANTE%type index by binary_integer;
	type tytbLONG_BAJ_TABLERO is table of LDC_ITEMS_METRAJE_COT.LONG_BAJ_TABLERO%type index by binary_integer;
	type tytbLONG_TABLERO is table of LDC_ITEMS_METRAJE_COT.LONG_TABLERO%type index by binary_integer;
	type tytbCOSTO is table of LDC_ITEMS_METRAJE_COT.COSTO%type index by binary_integer;
	type tytbPRECIO is table of LDC_ITEMS_METRAJE_COT.PRECIO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ITEMS_METRAJE_COT is record
	(
		ID_COTIZACION_DETALLADA   tytbID_COTIZACION_DETALLADA,
		ID_ITEM   tytbID_ITEM,
		FLAUTA   tytbFLAUTA,
		ID_PROYECTO   tytbID_PROYECTO,
		BBQ   tytbBBQ,
		HORNO   tytbHORNO,
		ESTUFA   tytbESTUFA,
		SECADORA   tytbSECADORA,
		CALENTADOR   tytbCALENTADOR,
		LOG_VAL_BAJANTE   tytbLOG_VAL_BAJANTE,
		LONG_BAJANTE   tytbLONG_BAJANTE,
		LONG_BAJ_TABLERO   tytbLONG_BAJ_TABLERO,
		LONG_TABLERO   tytbLONG_TABLERO,
		COSTO   tytbCOSTO,
		PRECIO   tytbPRECIO,
		row_id tytbrowid
	);


	/***** Metodos Publicos ****/

    FUNCTION fsbVersion
    RETURN varchar2;

	FUNCTION fsbGetMessageDescription
	return varchar2;

	PROCEDURE ClearMemory;

	FUNCTION fblExist
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type
	);

	PROCEDURE getRecord
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		orcRecord out nocopy styLDC_ITEMS_METRAJE_COT
	);

	FUNCTION frcGetRcData
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type
	)
	RETURN styLDC_ITEMS_METRAJE_COT;

	FUNCTION frcGetRcData
	RETURN styLDC_ITEMS_METRAJE_COT;

	FUNCTION frcGetRecord
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type
	)
	RETURN styLDC_ITEMS_METRAJE_COT;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ITEMS_METRAJE_COT
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ITEMS_METRAJE_COT in styLDC_ITEMS_METRAJE_COT
	);

	PROCEDURE insRecord
	(
		ircLDC_ITEMS_METRAJE_COT in styLDC_ITEMS_METRAJE_COT,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ITEMS_METRAJE_COT in out nocopy tytbLDC_ITEMS_METRAJE_COT
	);

	PROCEDURE delRecord
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ITEMS_METRAJE_COT in out nocopy tytbLDC_ITEMS_METRAJE_COT,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ITEMS_METRAJE_COT in styLDC_ITEMS_METRAJE_COT,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ITEMS_METRAJE_COT in out nocopy tytbLDC_ITEMS_METRAJE_COT,
		inuLock in number default 1
	);

	PROCEDURE updFLAUTA
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbFLAUTA$ in LDC_ITEMS_METRAJE_COT.FLAUTA%type,
		inuLock in number default 0
	);

	PROCEDURE updBBQ
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbBBQ$ in LDC_ITEMS_METRAJE_COT.BBQ%type,
		inuLock in number default 0
	);

	PROCEDURE updHORNO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbHORNO$ in LDC_ITEMS_METRAJE_COT.HORNO%type,
		inuLock in number default 0
	);

	PROCEDURE updESTUFA
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbESTUFA$ in LDC_ITEMS_METRAJE_COT.ESTUFA%type,
		inuLock in number default 0
	);

	PROCEDURE updSECADORA
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbSECADORA$ in LDC_ITEMS_METRAJE_COT.SECADORA%type,
		inuLock in number default 0
	);

	PROCEDURE updCALENTADOR
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbCALENTADOR$ in LDC_ITEMS_METRAJE_COT.CALENTADOR%type,
		inuLock in number default 0
	);

	PROCEDURE updLOG_VAL_BAJANTE
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbLOG_VAL_BAJANTE$ in LDC_ITEMS_METRAJE_COT.LOG_VAL_BAJANTE%type,
		inuLock in number default 0
	);

	PROCEDURE updLONG_BAJANTE
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbLONG_BAJANTE$ in LDC_ITEMS_METRAJE_COT.LONG_BAJANTE%type,
		inuLock in number default 0
	);

	PROCEDURE updLONG_BAJ_TABLERO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbLONG_BAJ_TABLERO$ in LDC_ITEMS_METRAJE_COT.LONG_BAJ_TABLERO%type,
		inuLock in number default 0
	);

	PROCEDURE updLONG_TABLERO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbLONG_TABLERO$ in LDC_ITEMS_METRAJE_COT.LONG_TABLERO%type,
		inuLock in number default 0
	);

	PROCEDURE updCOSTO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuCOSTO$ in LDC_ITEMS_METRAJE_COT.COSTO%type,
		inuLock in number default 0
	);

	PROCEDURE updPRECIO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuPRECIO$ in LDC_ITEMS_METRAJE_COT.PRECIO%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_COTIZACION_DETALLADA
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type;

	FUNCTION fnuGetID_ITEM
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.ID_ITEM%type;

	FUNCTION fsbGetFLAUTA
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.FLAUTA%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type;

	FUNCTION fsbGetBBQ
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.BBQ%type;

	FUNCTION fsbGetHORNO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.HORNO%type;

	FUNCTION fsbGetESTUFA
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.ESTUFA%type;

	FUNCTION fsbGetSECADORA
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.SECADORA%type;

	FUNCTION fsbGetCALENTADOR
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.CALENTADOR%type;

	FUNCTION fsbGetLOG_VAL_BAJANTE
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.LOG_VAL_BAJANTE%type;

	FUNCTION fsbGetLONG_BAJANTE
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.LONG_BAJANTE%type;

	FUNCTION fsbGetLONG_BAJ_TABLERO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.LONG_BAJ_TABLERO%type;

	FUNCTION fsbGetLONG_TABLERO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.LONG_TABLERO%type;

	FUNCTION fnuGetCOSTO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.COSTO%type;

	FUNCTION fnuGetPRECIO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.PRECIO%type;


	PROCEDURE LockByPk
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		orcLDC_ITEMS_METRAJE_COT  out styLDC_ITEMS_METRAJE_COT
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ITEMS_METRAJE_COT  out styLDC_ITEMS_METRAJE_COT
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ITEMS_METRAJE_COT;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_ITEMS_METRAJE_COT
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ITEMS_METRAJE_COT';
	 cnuGeEntityId constant varchar2(30) := 2869; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type
	)
	IS
		SELECT LDC_ITEMS_METRAJE_COT.*,LDC_ITEMS_METRAJE_COT.rowid
		FROM LDC_ITEMS_METRAJE_COT
		WHERE  ID_ITEM = inuID_ITEM
			and ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA
			and ID_PROYECTO = inuID_PROYECTO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ITEMS_METRAJE_COT.*,LDC_ITEMS_METRAJE_COT.rowid
		FROM LDC_ITEMS_METRAJE_COT
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ITEMS_METRAJE_COT is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ITEMS_METRAJE_COT;

	rcData cuRecord%rowtype;

    blDAO_USE_CACHE    boolean := null;


	/* Metodos privados */
	FUNCTION fsbGetMessageDescription
	return varchar2
	is
	      sbTableDescription varchar2(32000);
	BEGIN
	    if (cnuGeEntityId > 0 and dage_entity.fblExist (cnuGeEntityId))  then
	          sbTableDescription:= dage_entity.fsbGetDisplay_name(cnuGeEntityId);
	    else
	          sbTableDescription:= csbTABLEPARAMETER;
	    end if;

		return sbTableDescription ;
	END;

	PROCEDURE GetDAO_USE_CACHE
	IS
	BEGIN
	    if ( blDAO_USE_CACHE is null ) then
	        blDAO_USE_CACHE :=  ge_boparameter.fsbget('DAO_USE_CACHE') = 'Y';
	    end if;
	END;
	FUNCTION fsbPrimaryKey( rcI in styLDC_ITEMS_METRAJE_COT default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_ITEM);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_COTIZACION_DETALLADA);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_PROYECTO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		orcLDC_ITEMS_METRAJE_COT  out styLDC_ITEMS_METRAJE_COT
	)
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN
		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

		Open cuLockRcByPk
		(
			inuID_ITEM,
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
		);

		fetch cuLockRcByPk into orcLDC_ITEMS_METRAJE_COT;
		if cuLockRcByPk%notfound  then
			close cuLockRcByPk;
			raise no_data_found;
		end if;
		close cuLockRcByPk ;
	EXCEPTION
		when no_data_found then
			if cuLockRcByPk%isopen then
				close cuLockRcByPk;
			end if;
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
		when ex.RESOURCE_BUSY THEN
			if cuLockRcByPk%isopen then
				close cuLockRcByPk;
			end if;
			errors.setError(cnuAPPTABLEBUSSY,fsbPrimaryKey(rcError)||'|'|| fsbGetMessageDescription );
			raise ex.controlled_error;
		when others then
			if cuLockRcByPk%isopen then
				close cuLockRcByPk;
			end if;
			raise;
	END;
	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ITEMS_METRAJE_COT  out styLDC_ITEMS_METRAJE_COT
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ITEMS_METRAJE_COT;
		if cuLockRcbyRowId%notfound  then
			close cuLockRcbyRowId;
			raise no_data_found;
		end if;
		close cuLockRcbyRowId;
	EXCEPTION
		when no_data_found then
			if cuLockRcbyRowId%isopen then
				close cuLockRcbyRowId;
			end if;
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' rowid=['||iriRowID||']');
			raise ex.CONTROLLED_ERROR;
		when ex.RESOURCE_BUSY THEN
			if cuLockRcbyRowId%isopen then
				close cuLockRcbyRowId;
			end if;
			errors.setError(cnuAPPTABLEBUSSY,'rowid=['||irirowid||']|'||fsbGetMessageDescription );
			raise ex.controlled_error;
		when others then
			if cuLockRcbyRowId%isopen then
				close cuLockRcbyRowId;
			end if;
			raise;
	END;
	PROCEDURE DelRecordOfTables
	(
		itbLDC_ITEMS_METRAJE_COT  in out nocopy tytbLDC_ITEMS_METRAJE_COT
	)
	IS
	BEGIN
			rcRecOfTab.ID_COTIZACION_DETALLADA.delete;
			rcRecOfTab.ID_ITEM.delete;
			rcRecOfTab.FLAUTA.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.BBQ.delete;
			rcRecOfTab.HORNO.delete;
			rcRecOfTab.ESTUFA.delete;
			rcRecOfTab.SECADORA.delete;
			rcRecOfTab.CALENTADOR.delete;
			rcRecOfTab.LOG_VAL_BAJANTE.delete;
			rcRecOfTab.LONG_BAJANTE.delete;
			rcRecOfTab.LONG_BAJ_TABLERO.delete;
			rcRecOfTab.LONG_TABLERO.delete;
			rcRecOfTab.COSTO.delete;
			rcRecOfTab.PRECIO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ITEMS_METRAJE_COT  in out nocopy tytbLDC_ITEMS_METRAJE_COT,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ITEMS_METRAJE_COT);

		for n in itbLDC_ITEMS_METRAJE_COT.first .. itbLDC_ITEMS_METRAJE_COT.last loop
			rcRecOfTab.ID_COTIZACION_DETALLADA(n) := itbLDC_ITEMS_METRAJE_COT(n).ID_COTIZACION_DETALLADA;
			rcRecOfTab.ID_ITEM(n) := itbLDC_ITEMS_METRAJE_COT(n).ID_ITEM;
			rcRecOfTab.FLAUTA(n) := itbLDC_ITEMS_METRAJE_COT(n).FLAUTA;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_ITEMS_METRAJE_COT(n).ID_PROYECTO;
			rcRecOfTab.BBQ(n) := itbLDC_ITEMS_METRAJE_COT(n).BBQ;
			rcRecOfTab.HORNO(n) := itbLDC_ITEMS_METRAJE_COT(n).HORNO;
			rcRecOfTab.ESTUFA(n) := itbLDC_ITEMS_METRAJE_COT(n).ESTUFA;
			rcRecOfTab.SECADORA(n) := itbLDC_ITEMS_METRAJE_COT(n).SECADORA;
			rcRecOfTab.CALENTADOR(n) := itbLDC_ITEMS_METRAJE_COT(n).CALENTADOR;
			rcRecOfTab.LOG_VAL_BAJANTE(n) := itbLDC_ITEMS_METRAJE_COT(n).LOG_VAL_BAJANTE;
			rcRecOfTab.LONG_BAJANTE(n) := itbLDC_ITEMS_METRAJE_COT(n).LONG_BAJANTE;
			rcRecOfTab.LONG_BAJ_TABLERO(n) := itbLDC_ITEMS_METRAJE_COT(n).LONG_BAJ_TABLERO;
			rcRecOfTab.LONG_TABLERO(n) := itbLDC_ITEMS_METRAJE_COT(n).LONG_TABLERO;
			rcRecOfTab.COSTO(n) := itbLDC_ITEMS_METRAJE_COT(n).COSTO;
			rcRecOfTab.PRECIO(n) := itbLDC_ITEMS_METRAJE_COT(n).PRECIO;
			rcRecOfTab.row_id(n) := itbLDC_ITEMS_METRAJE_COT(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_ITEM,
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
		);

		fetch cuRecord into rcData;
		if cuRecord%notfound  then
			close cuRecord;
			rcData := rcRecordNull;
			raise no_data_found;
		end if;
		close cuRecord;
	END;
	PROCEDURE LoadByRowId
	(
		irirowid in varchar2
	)
	IS
		rcRecordNull cuRecordByRowId%rowtype;
	BEGIN
		if cuRecordByRowId%isopen then
			close cuRecordByRowId;
		end if;
		open cuRecordByRowId
		(
			irirowid
		);

		fetch cuRecordByRowId into rcData;
		if cuRecordByRowId%notfound  then
			close cuRecordByRowId;
			rcData := rcRecordNull;
			raise no_data_found;
		end if;
		close cuRecordByRowId;
	END;
	FUNCTION fblAlreadyLoaded
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_ITEM = rcData.ID_ITEM AND
			inuID_COTIZACION_DETALLADA = rcData.ID_COTIZACION_DETALLADA AND
			inuID_PROYECTO = rcData.ID_PROYECTO
		   ) then
			return ( true );
		end if;
		return (false);
	END;

	/***** Fin metodos privados *****/

	/***** Metodos publicos ******/
    FUNCTION fsbVersion
    RETURN varchar2
	IS
	BEGIN
		return csbVersion;
	END;
	PROCEDURE ClearMemory
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		rcData := rcRecordNull;
	END;
	FUNCTION fblExist
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_ITEM,
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type
	)
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN		rcError.ID_ITEM:=inuID_ITEM;		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_ITEM,
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
		);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	)
	IS
	BEGIN
		LoadByRowId
		(
			iriRowID
		);
	EXCEPTION
		when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' rowid=['||iriRowID||']');
            raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE ValDuplicate
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type
	)
	IS
	BEGIN
		Load
		(
			inuID_ITEM,
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		orcRecord out nocopy styLDC_ITEMS_METRAJE_COT
	)
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN		rcError.ID_ITEM:=inuID_ITEM;		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_ITEM,
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type
	)
	RETURN styLDC_ITEMS_METRAJE_COT
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN
		rcError.ID_ITEM:=inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_ITEM,
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type
	)
	RETURN styLDC_ITEMS_METRAJE_COT
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN
		rcError.ID_ITEM:=inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO:=inuID_PROYECTO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_ITEM,
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_ITEM,
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_ITEMS_METRAJE_COT
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ITEMS_METRAJE_COT
	)
	IS
		rfLDC_ITEMS_METRAJE_COT tyrfLDC_ITEMS_METRAJE_COT;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ITEMS_METRAJE_COT.*, LDC_ITEMS_METRAJE_COT.rowid FROM LDC_ITEMS_METRAJE_COT';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ITEMS_METRAJE_COT for sbFullQuery;

		fetch rfLDC_ITEMS_METRAJE_COT bulk collect INTO otbResult;

		close rfLDC_ITEMS_METRAJE_COT;
		if otbResult.count = 0  then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor
	IS
		rfQuery tyRefCursor;
		sbSQL VARCHAR2 (32000) := 'select LDC_ITEMS_METRAJE_COT.*, LDC_ITEMS_METRAJE_COT.rowid FROM LDC_ITEMS_METRAJE_COT';
	BEGIN
		if isbCriteria is not null then
			sbSQL := sbSQL||' where '||isbCriteria;
		end if;
		if iblLock then
			sbSQL := sbSQL||' for update nowait';
		end if;
		open rfQuery for sbSQL;
		return(rfQuery);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecord
	(
		ircLDC_ITEMS_METRAJE_COT in styLDC_ITEMS_METRAJE_COT
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ITEMS_METRAJE_COT,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ITEMS_METRAJE_COT in styLDC_ITEMS_METRAJE_COT,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ITEMS_METRAJE_COT.ID_ITEM is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_ITEM');
			raise ex.controlled_error;
		end if;
		if ircLDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_COTIZACION_DETALLADA');
			raise ex.controlled_error;
		end if;
		if ircLDC_ITEMS_METRAJE_COT.ID_PROYECTO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PROYECTO');
			raise ex.controlled_error;
		end if;

		insert into LDC_ITEMS_METRAJE_COT
		(
			ID_COTIZACION_DETALLADA,
			ID_ITEM,
			FLAUTA,
			ID_PROYECTO,
			BBQ,
			HORNO,
			ESTUFA,
			SECADORA,
			CALENTADOR,
			LOG_VAL_BAJANTE,
			LONG_BAJANTE,
			LONG_BAJ_TABLERO,
			LONG_TABLERO,
			COSTO,
			PRECIO
		)
		values
		(
			ircLDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA,
			ircLDC_ITEMS_METRAJE_COT.ID_ITEM,
			ircLDC_ITEMS_METRAJE_COT.FLAUTA,
			ircLDC_ITEMS_METRAJE_COT.ID_PROYECTO,
			ircLDC_ITEMS_METRAJE_COT.BBQ,
			ircLDC_ITEMS_METRAJE_COT.HORNO,
			ircLDC_ITEMS_METRAJE_COT.ESTUFA,
			ircLDC_ITEMS_METRAJE_COT.SECADORA,
			ircLDC_ITEMS_METRAJE_COT.CALENTADOR,
			ircLDC_ITEMS_METRAJE_COT.LOG_VAL_BAJANTE,
			ircLDC_ITEMS_METRAJE_COT.LONG_BAJANTE,
			ircLDC_ITEMS_METRAJE_COT.LONG_BAJ_TABLERO,
			ircLDC_ITEMS_METRAJE_COT.LONG_TABLERO,
			ircLDC_ITEMS_METRAJE_COT.COSTO,
			ircLDC_ITEMS_METRAJE_COT.PRECIO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ITEMS_METRAJE_COT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ITEMS_METRAJE_COT in out nocopy tytbLDC_ITEMS_METRAJE_COT
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEMS_METRAJE_COT,blUseRowID);
		forall n in iotbLDC_ITEMS_METRAJE_COT.first..iotbLDC_ITEMS_METRAJE_COT.last
			insert into LDC_ITEMS_METRAJE_COT
			(
				ID_COTIZACION_DETALLADA,
				ID_ITEM,
				FLAUTA,
				ID_PROYECTO,
				BBQ,
				HORNO,
				ESTUFA,
				SECADORA,
				CALENTADOR,
				LOG_VAL_BAJANTE,
				LONG_BAJANTE,
				LONG_BAJ_TABLERO,
				LONG_TABLERO,
				COSTO,
				PRECIO
			)
			values
			(
				rcRecOfTab.ID_COTIZACION_DETALLADA(n),
				rcRecOfTab.ID_ITEM(n),
				rcRecOfTab.FLAUTA(n),
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.BBQ(n),
				rcRecOfTab.HORNO(n),
				rcRecOfTab.ESTUFA(n),
				rcRecOfTab.SECADORA(n),
				rcRecOfTab.CALENTADOR(n),
				rcRecOfTab.LOG_VAL_BAJANTE(n),
				rcRecOfTab.LONG_BAJANTE(n),
				rcRecOfTab.LONG_BAJ_TABLERO(n),
				rcRecOfTab.LONG_TABLERO(n),
				rcRecOfTab.COSTO(n),
				rcRecOfTab.PRECIO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN
		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

		if inuLock=1 then
			LockByPk
			(
				inuID_ITEM,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;


		delete
		from LDC_ITEMS_METRAJE_COT
		where
       		ID_ITEM=inuID_ITEM and
       		ID_COTIZACION_DETALLADA=inuID_COTIZACION_DETALLADA and
       		ID_PROYECTO=inuID_PROYECTO;
            if sql%notfound then
                raise no_data_found;
            end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
         raise ex.CONTROLLED_ERROR;
		when ex.RECORD_HAVE_CHILDREN then
			Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	)
	IS
		rcRecordNull cuRecord%rowtype;
		rcError  styLDC_ITEMS_METRAJE_COT;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ITEMS_METRAJE_COT
		where
			rowid = iriRowID
		returning
			ID_COTIZACION_DETALLADA,
			ID_ITEM,
			FLAUTA
		into
			rcError.ID_COTIZACION_DETALLADA,
			rcError.ID_ITEM,
			rcError.FLAUTA;
            if sql%notfound then
			 raise no_data_found;
		    end if;
            if rcData.rowID=iriRowID then
			 rcData := rcRecordNull;
		    end if;
	EXCEPTION
		when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' rowid=['||iriRowID||']');
            raise ex.CONTROLLED_ERROR;
		when ex.RECORD_HAVE_CHILDREN then
            Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription||' '||' rowid=['||iriRowID||']');
            raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecords
	(
		iotbLDC_ITEMS_METRAJE_COT in out nocopy tytbLDC_ITEMS_METRAJE_COT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ITEMS_METRAJE_COT;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEMS_METRAJE_COT, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_METRAJE_COT.first .. iotbLDC_ITEMS_METRAJE_COT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_METRAJE_COT.first .. iotbLDC_ITEMS_METRAJE_COT.last
				delete
				from LDC_ITEMS_METRAJE_COT
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_METRAJE_COT.first .. iotbLDC_ITEMS_METRAJE_COT.last loop
					LockByPk
					(
						rcRecOfTab.ID_ITEM(n),
						rcRecOfTab.ID_COTIZACION_DETALLADA(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_METRAJE_COT.first .. iotbLDC_ITEMS_METRAJE_COT.last
				delete
				from LDC_ITEMS_METRAJE_COT
				where
		         	ID_ITEM = rcRecOfTab.ID_ITEM(n) and
		         	ID_COTIZACION_DETALLADA = rcRecOfTab.ID_COTIZACION_DETALLADA(n) and
		         	ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_ITEMS_METRAJE_COT in styLDC_ITEMS_METRAJE_COT,
		inuLock in number default 0
	)
	IS
		nuID_ITEM	LDC_ITEMS_METRAJE_COT.ID_ITEM%type;
		nuID_COTIZACION_DETALLADA	LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type;
		nuID_PROYECTO	LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type;
	BEGIN
		if ircLDC_ITEMS_METRAJE_COT.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ITEMS_METRAJE_COT.rowid,rcData);
			end if;
			update LDC_ITEMS_METRAJE_COT
			set
				FLAUTA = ircLDC_ITEMS_METRAJE_COT.FLAUTA,
				BBQ = ircLDC_ITEMS_METRAJE_COT.BBQ,
				HORNO = ircLDC_ITEMS_METRAJE_COT.HORNO,
				ESTUFA = ircLDC_ITEMS_METRAJE_COT.ESTUFA,
				SECADORA = ircLDC_ITEMS_METRAJE_COT.SECADORA,
				CALENTADOR = ircLDC_ITEMS_METRAJE_COT.CALENTADOR,
				LOG_VAL_BAJANTE = ircLDC_ITEMS_METRAJE_COT.LOG_VAL_BAJANTE,
				LONG_BAJANTE = ircLDC_ITEMS_METRAJE_COT.LONG_BAJANTE,
				LONG_BAJ_TABLERO = ircLDC_ITEMS_METRAJE_COT.LONG_BAJ_TABLERO,
				LONG_TABLERO = ircLDC_ITEMS_METRAJE_COT.LONG_TABLERO,
				COSTO = ircLDC_ITEMS_METRAJE_COT.COSTO,
				PRECIO = ircLDC_ITEMS_METRAJE_COT.PRECIO
			where
				rowid = ircLDC_ITEMS_METRAJE_COT.rowid
			returning
				ID_ITEM,
				ID_COTIZACION_DETALLADA,
				ID_PROYECTO
			into
				nuID_ITEM,
				nuID_COTIZACION_DETALLADA,
				nuID_PROYECTO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ITEMS_METRAJE_COT.ID_ITEM,
					ircLDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA,
					ircLDC_ITEMS_METRAJE_COT.ID_PROYECTO,
					rcData
				);
			end if;

			update LDC_ITEMS_METRAJE_COT
			set
				FLAUTA = ircLDC_ITEMS_METRAJE_COT.FLAUTA,
				BBQ = ircLDC_ITEMS_METRAJE_COT.BBQ,
				HORNO = ircLDC_ITEMS_METRAJE_COT.HORNO,
				ESTUFA = ircLDC_ITEMS_METRAJE_COT.ESTUFA,
				SECADORA = ircLDC_ITEMS_METRAJE_COT.SECADORA,
				CALENTADOR = ircLDC_ITEMS_METRAJE_COT.CALENTADOR,
				LOG_VAL_BAJANTE = ircLDC_ITEMS_METRAJE_COT.LOG_VAL_BAJANTE,
				LONG_BAJANTE = ircLDC_ITEMS_METRAJE_COT.LONG_BAJANTE,
				LONG_BAJ_TABLERO = ircLDC_ITEMS_METRAJE_COT.LONG_BAJ_TABLERO,
				LONG_TABLERO = ircLDC_ITEMS_METRAJE_COT.LONG_TABLERO,
				COSTO = ircLDC_ITEMS_METRAJE_COT.COSTO,
				PRECIO = ircLDC_ITEMS_METRAJE_COT.PRECIO
			where
				ID_ITEM = ircLDC_ITEMS_METRAJE_COT.ID_ITEM and
				ID_COTIZACION_DETALLADA = ircLDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA and
				ID_PROYECTO = ircLDC_ITEMS_METRAJE_COT.ID_PROYECTO
			returning
				ID_ITEM,
				ID_COTIZACION_DETALLADA,
				ID_PROYECTO
			into
				nuID_ITEM,
				nuID_COTIZACION_DETALLADA,
				nuID_PROYECTO;
		end if;
		if
			nuID_ITEM is NULL OR
			nuID_COTIZACION_DETALLADA is NULL OR
			nuID_PROYECTO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ITEMS_METRAJE_COT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ITEMS_METRAJE_COT in out nocopy tytbLDC_ITEMS_METRAJE_COT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ITEMS_METRAJE_COT;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEMS_METRAJE_COT,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_METRAJE_COT.first .. iotbLDC_ITEMS_METRAJE_COT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_METRAJE_COT.first .. iotbLDC_ITEMS_METRAJE_COT.last
				update LDC_ITEMS_METRAJE_COT
				set
					FLAUTA = rcRecOfTab.FLAUTA(n),
					BBQ = rcRecOfTab.BBQ(n),
					HORNO = rcRecOfTab.HORNO(n),
					ESTUFA = rcRecOfTab.ESTUFA(n),
					SECADORA = rcRecOfTab.SECADORA(n),
					CALENTADOR = rcRecOfTab.CALENTADOR(n),
					LOG_VAL_BAJANTE = rcRecOfTab.LOG_VAL_BAJANTE(n),
					LONG_BAJANTE = rcRecOfTab.LONG_BAJANTE(n),
					LONG_BAJ_TABLERO = rcRecOfTab.LONG_BAJ_TABLERO(n),
					LONG_TABLERO = rcRecOfTab.LONG_TABLERO(n),
					COSTO = rcRecOfTab.COSTO(n),
					PRECIO = rcRecOfTab.PRECIO(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_METRAJE_COT.first .. iotbLDC_ITEMS_METRAJE_COT.last loop
					LockByPk
					(
						rcRecOfTab.ID_ITEM(n),
						rcRecOfTab.ID_COTIZACION_DETALLADA(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_METRAJE_COT.first .. iotbLDC_ITEMS_METRAJE_COT.last
				update LDC_ITEMS_METRAJE_COT
				SET
					FLAUTA = rcRecOfTab.FLAUTA(n),
					BBQ = rcRecOfTab.BBQ(n),
					HORNO = rcRecOfTab.HORNO(n),
					ESTUFA = rcRecOfTab.ESTUFA(n),
					SECADORA = rcRecOfTab.SECADORA(n),
					CALENTADOR = rcRecOfTab.CALENTADOR(n),
					LOG_VAL_BAJANTE = rcRecOfTab.LOG_VAL_BAJANTE(n),
					LONG_BAJANTE = rcRecOfTab.LONG_BAJANTE(n),
					LONG_BAJ_TABLERO = rcRecOfTab.LONG_BAJ_TABLERO(n),
					LONG_TABLERO = rcRecOfTab.LONG_TABLERO(n),
					COSTO = rcRecOfTab.COSTO(n),
					PRECIO = rcRecOfTab.PRECIO(n)
				where
					ID_ITEM = rcRecOfTab.ID_ITEM(n) and
					ID_COTIZACION_DETALLADA = rcRecOfTab.ID_COTIZACION_DETALLADA(n) and
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n)
;
		end if;
	END;
	PROCEDURE updFLAUTA
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbFLAUTA$ in LDC_ITEMS_METRAJE_COT.FLAUTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN
		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_ITEM,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_ITEMS_METRAJE_COT
		set
			FLAUTA = isbFLAUTA$
		where
			ID_ITEM = inuID_ITEM and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FLAUTA:= isbFLAUTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBBQ
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbBBQ$ in LDC_ITEMS_METRAJE_COT.BBQ%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN
		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_ITEM,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_ITEMS_METRAJE_COT
		set
			BBQ = isbBBQ$
		where
			ID_ITEM = inuID_ITEM and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BBQ:= isbBBQ$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updHORNO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbHORNO$ in LDC_ITEMS_METRAJE_COT.HORNO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN
		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_ITEM,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_ITEMS_METRAJE_COT
		set
			HORNO = isbHORNO$
		where
			ID_ITEM = inuID_ITEM and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.HORNO:= isbHORNO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updESTUFA
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbESTUFA$ in LDC_ITEMS_METRAJE_COT.ESTUFA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN
		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_ITEM,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_ITEMS_METRAJE_COT
		set
			ESTUFA = isbESTUFA$
		where
			ID_ITEM = inuID_ITEM and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ESTUFA:= isbESTUFA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSECADORA
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbSECADORA$ in LDC_ITEMS_METRAJE_COT.SECADORA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN
		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_ITEM,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_ITEMS_METRAJE_COT
		set
			SECADORA = isbSECADORA$
		where
			ID_ITEM = inuID_ITEM and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SECADORA:= isbSECADORA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCALENTADOR
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbCALENTADOR$ in LDC_ITEMS_METRAJE_COT.CALENTADOR%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN
		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_ITEM,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_ITEMS_METRAJE_COT
		set
			CALENTADOR = isbCALENTADOR$
		where
			ID_ITEM = inuID_ITEM and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CALENTADOR:= isbCALENTADOR$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLOG_VAL_BAJANTE
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbLOG_VAL_BAJANTE$ in LDC_ITEMS_METRAJE_COT.LOG_VAL_BAJANTE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN
		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_ITEM,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_ITEMS_METRAJE_COT
		set
			LOG_VAL_BAJANTE = isbLOG_VAL_BAJANTE$
		where
			ID_ITEM = inuID_ITEM and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LOG_VAL_BAJANTE:= isbLOG_VAL_BAJANTE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLONG_BAJANTE
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbLONG_BAJANTE$ in LDC_ITEMS_METRAJE_COT.LONG_BAJANTE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN
		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_ITEM,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_ITEMS_METRAJE_COT
		set
			LONG_BAJANTE = isbLONG_BAJANTE$
		where
			ID_ITEM = inuID_ITEM and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LONG_BAJANTE:= isbLONG_BAJANTE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLONG_BAJ_TABLERO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbLONG_BAJ_TABLERO$ in LDC_ITEMS_METRAJE_COT.LONG_BAJ_TABLERO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN
		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_ITEM,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_ITEMS_METRAJE_COT
		set
			LONG_BAJ_TABLERO = isbLONG_BAJ_TABLERO$
		where
			ID_ITEM = inuID_ITEM and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LONG_BAJ_TABLERO:= isbLONG_BAJ_TABLERO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLONG_TABLERO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		isbLONG_TABLERO$ in LDC_ITEMS_METRAJE_COT.LONG_TABLERO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN
		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_ITEM,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_ITEMS_METRAJE_COT
		set
			LONG_TABLERO = isbLONG_TABLERO$
		where
			ID_ITEM = inuID_ITEM and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LONG_TABLERO:= isbLONG_TABLERO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOSTO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuCOSTO$ in LDC_ITEMS_METRAJE_COT.COSTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN
		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_ITEM,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_ITEMS_METRAJE_COT
		set
			COSTO = inuCOSTO$
		where
			ID_ITEM = inuID_ITEM and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COSTO:= inuCOSTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRECIO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuPRECIO$ in LDC_ITEMS_METRAJE_COT.PRECIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN
		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_ITEM,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_ITEMS_METRAJE_COT
		set
			PRECIO = inuPRECIO$
		where
			ID_ITEM = inuID_ITEM and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRECIO:= inuPRECIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_COTIZACION_DETALLADA
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN

		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_COTIZACION_DETALLADA);
		end if;
		Load
		(
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.ID_COTIZACION_DETALLADA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_ITEM
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.ID_ITEM%type
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN

		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_ITEM);
		end if;
		Load
		(
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.ID_ITEM);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetFLAUTA
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.FLAUTA%type
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN

		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.FLAUTA);
		end if;
		Load
		(
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.FLAUTA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_PROYECTO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN

		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_PROYECTO);
		end if;
		Load
		(
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.ID_PROYECTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetBBQ
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.BBQ%type
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN

		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.BBQ);
		end if;
		Load
		(
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.BBQ);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetHORNO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.HORNO%type
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN

		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.HORNO);
		end if;
		Load
		(
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.HORNO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetESTUFA
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.ESTUFA%type
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN

		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ESTUFA);
		end if;
		Load
		(
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.ESTUFA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSECADORA
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.SECADORA%type
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN

		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.SECADORA);
		end if;
		Load
		(
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.SECADORA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCALENTADOR
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.CALENTADOR%type
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN

		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.CALENTADOR);
		end if;
		Load
		(
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.CALENTADOR);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetLOG_VAL_BAJANTE
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.LOG_VAL_BAJANTE%type
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN

		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.LOG_VAL_BAJANTE);
		end if;
		Load
		(
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.LOG_VAL_BAJANTE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetLONG_BAJANTE
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.LONG_BAJANTE%type
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN

		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.LONG_BAJANTE);
		end if;
		Load
		(
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.LONG_BAJANTE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetLONG_BAJ_TABLERO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.LONG_BAJ_TABLERO%type
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN

		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.LONG_BAJ_TABLERO);
		end if;
		Load
		(
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.LONG_BAJ_TABLERO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetLONG_TABLERO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.LONG_TABLERO%type
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN

		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.LONG_TABLERO);
		end if;
		Load
		(
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.LONG_TABLERO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOSTO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.COSTO%type
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN

		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.COSTO);
		end if;
		Load
		(
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.COSTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPRECIO
	(
		inuID_ITEM in LDC_ITEMS_METRAJE_COT.ID_ITEM%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_METRAJE_COT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_METRAJE_COT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_METRAJE_COT.PRECIO%type
	IS
		rcError styLDC_ITEMS_METRAJE_COT;
	BEGIN

		rcError.ID_ITEM := inuID_ITEM;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.PRECIO);
		end if;
		Load
		(
		 		inuID_ITEM,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.PRECIO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALDC_ITEMS_METRAJE_COT;
/
PROMPT Otorgando permisos de ejecucion a DALDC_ITEMS_METRAJE_COT
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_ITEMS_METRAJE_COT', 'ADM_PERSON');
END;
/