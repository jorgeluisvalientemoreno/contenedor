CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_ITEMS_COTIZ_PROY
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
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type
	)
	IS
		SELECT LDC_ITEMS_COTIZ_PROY.*,LDC_ITEMS_COTIZ_PROY.rowid
		FROM LDC_ITEMS_COTIZ_PROY
		WHERE
		    ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA
		    and ID_PROYECTO = inuID_PROYECTO
		    and ID_ITEM = inuID_ITEM
		    and TIPO_ITEM = isbTIPO_ITEM
		    and TIPO_TRAB = inuTIPO_TRAB;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ITEMS_COTIZ_PROY.*,LDC_ITEMS_COTIZ_PROY.rowid
		FROM LDC_ITEMS_COTIZ_PROY
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ITEMS_COTIZ_PROY  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ITEMS_COTIZ_PROY is table of styLDC_ITEMS_COTIZ_PROY index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ITEMS_COTIZ_PROY;

	/* Tipos referenciando al registro */
	type tytbID_COTIZACION_DETALLADA is table of LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type index by binary_integer;
	type tytbID_ITEM is table of LDC_ITEMS_COTIZ_PROY.ID_ITEM%type index by binary_integer;
	type tytbCANTIDAD is table of LDC_ITEMS_COTIZ_PROY.CANTIDAD%type index by binary_integer;
	type tytbCOSTO is table of LDC_ITEMS_COTIZ_PROY.COSTO%type index by binary_integer;
	type tytbPRECIO is table of LDC_ITEMS_COTIZ_PROY.PRECIO%type index by binary_integer;
	type tytbTOTAL_COSTO is table of LDC_ITEMS_COTIZ_PROY.TOTAL_COSTO%type index by binary_integer;
	type tytbTOTAL_PRECIO is table of LDC_ITEMS_COTIZ_PROY.TOTAL_PRECIO%type index by binary_integer;
	type tytbTIPO_ITEM is table of LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type index by binary_integer;
	type tytbTIPO_TRAB is table of LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ITEMS_COTIZ_PROY is record
	(
		ID_COTIZACION_DETALLADA   tytbID_COTIZACION_DETALLADA,
		ID_PROYECTO   tytbID_PROYECTO,
		ID_ITEM   tytbID_ITEM,
		CANTIDAD   tytbCANTIDAD,
		COSTO   tytbCOSTO,
		PRECIO   tytbPRECIO,
		TOTAL_COSTO   tytbTOTAL_COSTO,
		TOTAL_PRECIO   tytbTOTAL_PRECIO,
		TIPO_ITEM   tytbTIPO_ITEM,
		TIPO_TRAB   tytbTIPO_TRAB,
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
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type
	);

	PROCEDURE getRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		orcRecord out nocopy styLDC_ITEMS_COTIZ_PROY
	);

	FUNCTION frcGetRcData
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type
	)
	RETURN styLDC_ITEMS_COTIZ_PROY;

	FUNCTION frcGetRcData
	RETURN styLDC_ITEMS_COTIZ_PROY;

	FUNCTION frcGetRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type
	)
	RETURN styLDC_ITEMS_COTIZ_PROY;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ITEMS_COTIZ_PROY
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ITEMS_COTIZ_PROY in styLDC_ITEMS_COTIZ_PROY
	);

	PROCEDURE insRecord
	(
		ircLDC_ITEMS_COTIZ_PROY in styLDC_ITEMS_COTIZ_PROY,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ITEMS_COTIZ_PROY in out nocopy tytbLDC_ITEMS_COTIZ_PROY
	);

	PROCEDURE delRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ITEMS_COTIZ_PROY in out nocopy tytbLDC_ITEMS_COTIZ_PROY,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ITEMS_COTIZ_PROY in styLDC_ITEMS_COTIZ_PROY,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ITEMS_COTIZ_PROY in out nocopy tytbLDC_ITEMS_COTIZ_PROY,
		inuLock in number default 1
	);

	PROCEDURE updCANTIDAD
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuCANTIDAD$ in LDC_ITEMS_COTIZ_PROY.CANTIDAD%type,
		inuLock in number default 0
	);

	PROCEDURE updCOSTO
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuCOSTO$ in LDC_ITEMS_COTIZ_PROY.COSTO%type,
		inuLock in number default 0
	);

	PROCEDURE updPRECIO
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuPRECIO$ in LDC_ITEMS_COTIZ_PROY.PRECIO%type,
		inuLock in number default 0
	);

	PROCEDURE updTOTAL_COSTO
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuTOTAL_COSTO$ in LDC_ITEMS_COTIZ_PROY.TOTAL_COSTO%type,
		inuLock in number default 0
	);

	PROCEDURE updTOTAL_PRECIO
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuTOTAL_PRECIO$ in LDC_ITEMS_COTIZ_PROY.TOTAL_PRECIO%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_COTIZACION_DETALLADA
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type;

	FUNCTION fnuGetID_ITEM
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.ID_ITEM%type;

	FUNCTION fnuGetCANTIDAD
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.CANTIDAD%type;

	FUNCTION fnuGetCOSTO
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.COSTO%type;

	FUNCTION fnuGetPRECIO
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.PRECIO%type;

	FUNCTION fnuGetTOTAL_COSTO
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.TOTAL_COSTO%type;

	FUNCTION fnuGetTOTAL_PRECIO
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.TOTAL_PRECIO%type;

	FUNCTION fsbGetTIPO_ITEM
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type;

	FUNCTION fnuGetTIPO_TRAB
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type;


	PROCEDURE LockByPk
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		orcLDC_ITEMS_COTIZ_PROY  out styLDC_ITEMS_COTIZ_PROY
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ITEMS_COTIZ_PROY  out styLDC_ITEMS_COTIZ_PROY
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ITEMS_COTIZ_PROY;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_ITEMS_COTIZ_PROY
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ITEMS_COTIZ_PROY';
	 cnuGeEntityId constant varchar2(30) := 2866; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type
	)
	IS
		SELECT LDC_ITEMS_COTIZ_PROY.*,LDC_ITEMS_COTIZ_PROY.rowid
		FROM LDC_ITEMS_COTIZ_PROY
		WHERE  ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA
			and ID_PROYECTO = inuID_PROYECTO
			and ID_ITEM = inuID_ITEM
			and TIPO_ITEM = isbTIPO_ITEM
			and TIPO_TRAB = inuTIPO_TRAB
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ITEMS_COTIZ_PROY.*,LDC_ITEMS_COTIZ_PROY.rowid
		FROM LDC_ITEMS_COTIZ_PROY
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ITEMS_COTIZ_PROY is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ITEMS_COTIZ_PROY;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ITEMS_COTIZ_PROY default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_COTIZACION_DETALLADA);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_PROYECTO);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_ITEM);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.TIPO_ITEM);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.TIPO_TRAB);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		orcLDC_ITEMS_COTIZ_PROY  out styLDC_ITEMS_COTIZ_PROY
	)
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

		Open cuLockRcByPk
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_ITEM,
			isbTIPO_ITEM,
			inuTIPO_TRAB
		);

		fetch cuLockRcByPk into orcLDC_ITEMS_COTIZ_PROY;
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
		orcLDC_ITEMS_COTIZ_PROY  out styLDC_ITEMS_COTIZ_PROY
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ITEMS_COTIZ_PROY;
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
		itbLDC_ITEMS_COTIZ_PROY  in out nocopy tytbLDC_ITEMS_COTIZ_PROY
	)
	IS
	BEGIN
			rcRecOfTab.ID_COTIZACION_DETALLADA.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.ID_ITEM.delete;
			rcRecOfTab.CANTIDAD.delete;
			rcRecOfTab.COSTO.delete;
			rcRecOfTab.PRECIO.delete;
			rcRecOfTab.TOTAL_COSTO.delete;
			rcRecOfTab.TOTAL_PRECIO.delete;
			rcRecOfTab.TIPO_ITEM.delete;
			rcRecOfTab.TIPO_TRAB.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ITEMS_COTIZ_PROY  in out nocopy tytbLDC_ITEMS_COTIZ_PROY,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ITEMS_COTIZ_PROY);

		for n in itbLDC_ITEMS_COTIZ_PROY.first .. itbLDC_ITEMS_COTIZ_PROY.last loop
			rcRecOfTab.ID_COTIZACION_DETALLADA(n) := itbLDC_ITEMS_COTIZ_PROY(n).ID_COTIZACION_DETALLADA;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_ITEMS_COTIZ_PROY(n).ID_PROYECTO;
			rcRecOfTab.ID_ITEM(n) := itbLDC_ITEMS_COTIZ_PROY(n).ID_ITEM;
			rcRecOfTab.CANTIDAD(n) := itbLDC_ITEMS_COTIZ_PROY(n).CANTIDAD;
			rcRecOfTab.COSTO(n) := itbLDC_ITEMS_COTIZ_PROY(n).COSTO;
			rcRecOfTab.PRECIO(n) := itbLDC_ITEMS_COTIZ_PROY(n).PRECIO;
			rcRecOfTab.TOTAL_COSTO(n) := itbLDC_ITEMS_COTIZ_PROY(n).TOTAL_COSTO;
			rcRecOfTab.TOTAL_PRECIO(n) := itbLDC_ITEMS_COTIZ_PROY(n).TOTAL_PRECIO;
			rcRecOfTab.TIPO_ITEM(n) := itbLDC_ITEMS_COTIZ_PROY(n).TIPO_ITEM;
			rcRecOfTab.TIPO_TRAB(n) := itbLDC_ITEMS_COTIZ_PROY(n).TIPO_TRAB;
			rcRecOfTab.row_id(n) := itbLDC_ITEMS_COTIZ_PROY(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_ITEM,
			isbTIPO_ITEM,
			inuTIPO_TRAB
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
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_COTIZACION_DETALLADA = rcData.ID_COTIZACION_DETALLADA AND
			inuID_PROYECTO = rcData.ID_PROYECTO AND
			inuID_ITEM = rcData.ID_ITEM AND
			isbTIPO_ITEM = rcData.TIPO_ITEM AND
			inuTIPO_TRAB = rcData.TIPO_TRAB
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
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_ITEM,
			isbTIPO_ITEM,
			inuTIPO_TRAB
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type
	)
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;		rcError.ID_PROYECTO:=inuID_PROYECTO;		rcError.ID_ITEM:=inuID_ITEM;		rcError.TIPO_ITEM:=isbTIPO_ITEM;		rcError.TIPO_TRAB:=inuTIPO_TRAB;

		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_ITEM,
			isbTIPO_ITEM,
			inuTIPO_TRAB
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
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type
	)
	IS
	BEGIN
		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_ITEM,
			isbTIPO_ITEM,
			inuTIPO_TRAB
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		orcRecord out nocopy styLDC_ITEMS_COTIZ_PROY
	)
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;		rcError.ID_PROYECTO:=inuID_PROYECTO;		rcError.ID_ITEM:=inuID_ITEM;		rcError.TIPO_ITEM:=isbTIPO_ITEM;		rcError.TIPO_TRAB:=inuTIPO_TRAB;

		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_ITEM,
			isbTIPO_ITEM,
			inuTIPO_TRAB
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type
	)
	RETURN styLDC_ITEMS_COTIZ_PROY
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO:=inuID_PROYECTO;
		rcError.ID_ITEM:=inuID_ITEM;
		rcError.TIPO_ITEM:=isbTIPO_ITEM;
		rcError.TIPO_TRAB:=inuTIPO_TRAB;

		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_ITEM,
			isbTIPO_ITEM,
			inuTIPO_TRAB
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type
	)
	RETURN styLDC_ITEMS_COTIZ_PROY
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO:=inuID_PROYECTO;
		rcError.ID_ITEM:=inuID_ITEM;
		rcError.TIPO_ITEM:=isbTIPO_ITEM;
		rcError.TIPO_TRAB:=inuTIPO_TRAB;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_ITEM,
			isbTIPO_ITEM,
			inuTIPO_TRAB
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_ITEM,
			isbTIPO_ITEM,
			inuTIPO_TRAB
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_ITEMS_COTIZ_PROY
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ITEMS_COTIZ_PROY
	)
	IS
		rfLDC_ITEMS_COTIZ_PROY tyrfLDC_ITEMS_COTIZ_PROY;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ITEMS_COTIZ_PROY.*, LDC_ITEMS_COTIZ_PROY.rowid FROM LDC_ITEMS_COTIZ_PROY';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ITEMS_COTIZ_PROY for sbFullQuery;

		fetch rfLDC_ITEMS_COTIZ_PROY bulk collect INTO otbResult;

		close rfLDC_ITEMS_COTIZ_PROY;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ITEMS_COTIZ_PROY.*, LDC_ITEMS_COTIZ_PROY.rowid FROM LDC_ITEMS_COTIZ_PROY';
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
		ircLDC_ITEMS_COTIZ_PROY in styLDC_ITEMS_COTIZ_PROY
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ITEMS_COTIZ_PROY,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ITEMS_COTIZ_PROY in styLDC_ITEMS_COTIZ_PROY,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_COTIZACION_DETALLADA');
			raise ex.controlled_error;
		end if;
		if ircLDC_ITEMS_COTIZ_PROY.ID_PROYECTO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PROYECTO');
			raise ex.controlled_error;
		end if;
		if ircLDC_ITEMS_COTIZ_PROY.ID_ITEM is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_ITEM');
			raise ex.controlled_error;
		end if;
		if ircLDC_ITEMS_COTIZ_PROY.TIPO_ITEM is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|TIPO_ITEM');
			raise ex.controlled_error;
		end if;
		if ircLDC_ITEMS_COTIZ_PROY.TIPO_TRAB is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|TIPO_TRAB');
			raise ex.controlled_error;
		end if;

		insert into LDC_ITEMS_COTIZ_PROY
		(
			ID_COTIZACION_DETALLADA,
			ID_PROYECTO,
			ID_ITEM,
			CANTIDAD,
			COSTO,
			PRECIO,
			TOTAL_COSTO,
			TOTAL_PRECIO,
			TIPO_ITEM,
			TIPO_TRAB
		)
		values
		(
			ircLDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA,
			ircLDC_ITEMS_COTIZ_PROY.ID_PROYECTO,
			ircLDC_ITEMS_COTIZ_PROY.ID_ITEM,
			ircLDC_ITEMS_COTIZ_PROY.CANTIDAD,
			ircLDC_ITEMS_COTIZ_PROY.COSTO,
			ircLDC_ITEMS_COTIZ_PROY.PRECIO,
			ircLDC_ITEMS_COTIZ_PROY.TOTAL_COSTO,
			ircLDC_ITEMS_COTIZ_PROY.TOTAL_PRECIO,
			ircLDC_ITEMS_COTIZ_PROY.TIPO_ITEM,
			ircLDC_ITEMS_COTIZ_PROY.TIPO_TRAB
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ITEMS_COTIZ_PROY));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ITEMS_COTIZ_PROY in out nocopy tytbLDC_ITEMS_COTIZ_PROY
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEMS_COTIZ_PROY,blUseRowID);
		forall n in iotbLDC_ITEMS_COTIZ_PROY.first..iotbLDC_ITEMS_COTIZ_PROY.last
			insert into LDC_ITEMS_COTIZ_PROY
			(
				ID_COTIZACION_DETALLADA,
				ID_PROYECTO,
				ID_ITEM,
				CANTIDAD,
				COSTO,
				PRECIO,
				TOTAL_COSTO,
				TOTAL_PRECIO,
				TIPO_ITEM,
				TIPO_TRAB
			)
			values
			(
				rcRecOfTab.ID_COTIZACION_DETALLADA(n),
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.ID_ITEM(n),
				rcRecOfTab.CANTIDAD(n),
				rcRecOfTab.COSTO(n),
				rcRecOfTab.PRECIO(n),
				rcRecOfTab.TOTAL_COSTO(n),
				rcRecOfTab.TOTAL_PRECIO(n),
				rcRecOfTab.TIPO_ITEM(n),
				rcRecOfTab.TIPO_TRAB(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_ITEM,
				isbTIPO_ITEM,
				inuTIPO_TRAB,
				rcData
			);
		end if;


		delete
		from LDC_ITEMS_COTIZ_PROY
		where
       		ID_COTIZACION_DETALLADA=inuID_COTIZACION_DETALLADA and
       		ID_PROYECTO=inuID_PROYECTO and
       		ID_ITEM=inuID_ITEM and
       		TIPO_ITEM=isbTIPO_ITEM and
       		TIPO_TRAB=inuTIPO_TRAB;
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
		rcError  styLDC_ITEMS_COTIZ_PROY;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ITEMS_COTIZ_PROY
		where
			rowid = iriRowID
		returning
			ID_COTIZACION_DETALLADA,
			ID_PROYECTO,
			ID_ITEM,
			CANTIDAD,
			COSTO
		into
			rcError.ID_COTIZACION_DETALLADA,
			rcError.ID_PROYECTO,
			rcError.ID_ITEM,
			rcError.CANTIDAD,
			rcError.COSTO;
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
		iotbLDC_ITEMS_COTIZ_PROY in out nocopy tytbLDC_ITEMS_COTIZ_PROY,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ITEMS_COTIZ_PROY;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEMS_COTIZ_PROY, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_COTIZ_PROY.first .. iotbLDC_ITEMS_COTIZ_PROY.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_COTIZ_PROY.first .. iotbLDC_ITEMS_COTIZ_PROY.last
				delete
				from LDC_ITEMS_COTIZ_PROY
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_COTIZ_PROY.first .. iotbLDC_ITEMS_COTIZ_PROY.last loop
					LockByPk
					(
						rcRecOfTab.ID_COTIZACION_DETALLADA(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcRecOfTab.ID_ITEM(n),
						rcRecOfTab.TIPO_ITEM(n),
						rcRecOfTab.TIPO_TRAB(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_COTIZ_PROY.first .. iotbLDC_ITEMS_COTIZ_PROY.last
				delete
				from LDC_ITEMS_COTIZ_PROY
				where
		         	ID_COTIZACION_DETALLADA = rcRecOfTab.ID_COTIZACION_DETALLADA(n) and
		         	ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n) and
		         	ID_ITEM = rcRecOfTab.ID_ITEM(n) and
		         	TIPO_ITEM = rcRecOfTab.TIPO_ITEM(n) and
		         	TIPO_TRAB = rcRecOfTab.TIPO_TRAB(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_ITEMS_COTIZ_PROY in styLDC_ITEMS_COTIZ_PROY,
		inuLock in number default 0
	)
	IS
		nuID_COTIZACION_DETALLADA	LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type;
		nuID_PROYECTO	LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type;
		nuID_ITEM	LDC_ITEMS_COTIZ_PROY.ID_ITEM%type;
		sbTIPO_ITEM	LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type;
		nuTIPO_TRAB	LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type;
	BEGIN
		if ircLDC_ITEMS_COTIZ_PROY.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ITEMS_COTIZ_PROY.rowid,rcData);
			end if;
			update LDC_ITEMS_COTIZ_PROY
			set
				CANTIDAD = ircLDC_ITEMS_COTIZ_PROY.CANTIDAD,
				COSTO = ircLDC_ITEMS_COTIZ_PROY.COSTO,
				PRECIO = ircLDC_ITEMS_COTIZ_PROY.PRECIO,
				TOTAL_COSTO = ircLDC_ITEMS_COTIZ_PROY.TOTAL_COSTO,
				TOTAL_PRECIO = ircLDC_ITEMS_COTIZ_PROY.TOTAL_PRECIO
			where
				rowid = ircLDC_ITEMS_COTIZ_PROY.rowid
			returning
				ID_COTIZACION_DETALLADA,
				ID_PROYECTO,
				ID_ITEM,
				TIPO_ITEM,
				TIPO_TRAB
			into
				nuID_COTIZACION_DETALLADA,
				nuID_PROYECTO,
				nuID_ITEM,
				sbTIPO_ITEM,
				nuTIPO_TRAB;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA,
					ircLDC_ITEMS_COTIZ_PROY.ID_PROYECTO,
					ircLDC_ITEMS_COTIZ_PROY.ID_ITEM,
					ircLDC_ITEMS_COTIZ_PROY.TIPO_ITEM,
					ircLDC_ITEMS_COTIZ_PROY.TIPO_TRAB,
					rcData
				);
			end if;

			update LDC_ITEMS_COTIZ_PROY
			set
				CANTIDAD = ircLDC_ITEMS_COTIZ_PROY.CANTIDAD,
				COSTO = ircLDC_ITEMS_COTIZ_PROY.COSTO,
				PRECIO = ircLDC_ITEMS_COTIZ_PROY.PRECIO,
				TOTAL_COSTO = ircLDC_ITEMS_COTIZ_PROY.TOTAL_COSTO,
				TOTAL_PRECIO = ircLDC_ITEMS_COTIZ_PROY.TOTAL_PRECIO
			where
				ID_COTIZACION_DETALLADA = ircLDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA and
				ID_PROYECTO = ircLDC_ITEMS_COTIZ_PROY.ID_PROYECTO and
				ID_ITEM = ircLDC_ITEMS_COTIZ_PROY.ID_ITEM and
				TIPO_ITEM = ircLDC_ITEMS_COTIZ_PROY.TIPO_ITEM and
				TIPO_TRAB = ircLDC_ITEMS_COTIZ_PROY.TIPO_TRAB
			returning
				ID_COTIZACION_DETALLADA,
				ID_PROYECTO,
				ID_ITEM,
				TIPO_ITEM,
				TIPO_TRAB
			into
				nuID_COTIZACION_DETALLADA,
				nuID_PROYECTO,
				nuID_ITEM,
				sbTIPO_ITEM,
				nuTIPO_TRAB;
		end if;
		if
			nuID_COTIZACION_DETALLADA is NULL OR
			nuID_PROYECTO is NULL OR
			nuID_ITEM is NULL OR
			sbTIPO_ITEM is NULL OR
			nuTIPO_TRAB is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ITEMS_COTIZ_PROY));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ITEMS_COTIZ_PROY in out nocopy tytbLDC_ITEMS_COTIZ_PROY,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ITEMS_COTIZ_PROY;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEMS_COTIZ_PROY,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_COTIZ_PROY.first .. iotbLDC_ITEMS_COTIZ_PROY.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_COTIZ_PROY.first .. iotbLDC_ITEMS_COTIZ_PROY.last
				update LDC_ITEMS_COTIZ_PROY
				set
					CANTIDAD = rcRecOfTab.CANTIDAD(n),
					COSTO = rcRecOfTab.COSTO(n),
					PRECIO = rcRecOfTab.PRECIO(n),
					TOTAL_COSTO = rcRecOfTab.TOTAL_COSTO(n),
					TOTAL_PRECIO = rcRecOfTab.TOTAL_PRECIO(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_COTIZ_PROY.first .. iotbLDC_ITEMS_COTIZ_PROY.last loop
					LockByPk
					(
						rcRecOfTab.ID_COTIZACION_DETALLADA(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcRecOfTab.ID_ITEM(n),
						rcRecOfTab.TIPO_ITEM(n),
						rcRecOfTab.TIPO_TRAB(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_COTIZ_PROY.first .. iotbLDC_ITEMS_COTIZ_PROY.last
				update LDC_ITEMS_COTIZ_PROY
				SET
					CANTIDAD = rcRecOfTab.CANTIDAD(n),
					COSTO = rcRecOfTab.COSTO(n),
					PRECIO = rcRecOfTab.PRECIO(n),
					TOTAL_COSTO = rcRecOfTab.TOTAL_COSTO(n),
					TOTAL_PRECIO = rcRecOfTab.TOTAL_PRECIO(n)
				where
					ID_COTIZACION_DETALLADA = rcRecOfTab.ID_COTIZACION_DETALLADA(n) and
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n) and
					ID_ITEM = rcRecOfTab.ID_ITEM(n) and
					TIPO_ITEM = rcRecOfTab.TIPO_ITEM(n) and
					TIPO_TRAB = rcRecOfTab.TIPO_TRAB(n)
;
		end if;
	END;
	PROCEDURE updCANTIDAD
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuCANTIDAD$ in LDC_ITEMS_COTIZ_PROY.CANTIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_ITEM,
				isbTIPO_ITEM,
				inuTIPO_TRAB,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZ_PROY
		set
			CANTIDAD = inuCANTIDAD$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM = inuID_ITEM and
			TIPO_ITEM = isbTIPO_ITEM and
			TIPO_TRAB = inuTIPO_TRAB;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CANTIDAD:= inuCANTIDAD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOSTO
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuCOSTO$ in LDC_ITEMS_COTIZ_PROY.COSTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_ITEM,
				isbTIPO_ITEM,
				inuTIPO_TRAB,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZ_PROY
		set
			COSTO = inuCOSTO$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM = inuID_ITEM and
			TIPO_ITEM = isbTIPO_ITEM and
			TIPO_TRAB = inuTIPO_TRAB;

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
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuPRECIO$ in LDC_ITEMS_COTIZ_PROY.PRECIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_ITEM,
				isbTIPO_ITEM,
				inuTIPO_TRAB,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZ_PROY
		set
			PRECIO = inuPRECIO$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM = inuID_ITEM and
			TIPO_ITEM = isbTIPO_ITEM and
			TIPO_TRAB = inuTIPO_TRAB;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRECIO:= inuPRECIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTOTAL_COSTO
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuTOTAL_COSTO$ in LDC_ITEMS_COTIZ_PROY.TOTAL_COSTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_ITEM,
				isbTIPO_ITEM,
				inuTIPO_TRAB,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZ_PROY
		set
			TOTAL_COSTO = inuTOTAL_COSTO$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM = inuID_ITEM and
			TIPO_ITEM = isbTIPO_ITEM and
			TIPO_TRAB = inuTIPO_TRAB;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TOTAL_COSTO:= inuTOTAL_COSTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTOTAL_PRECIO
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuTOTAL_PRECIO$ in LDC_ITEMS_COTIZ_PROY.TOTAL_PRECIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_ITEM,
				isbTIPO_ITEM,
				inuTIPO_TRAB,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZ_PROY
		set
			TOTAL_PRECIO = inuTOTAL_PRECIO$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM = inuID_ITEM and
			TIPO_ITEM = isbTIPO_ITEM and
			TIPO_TRAB = inuTIPO_TRAB;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TOTAL_PRECIO:= inuTOTAL_PRECIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_COTIZACION_DETALLADA
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
			 )
		then
			 return(rcData.ID_COTIZACION_DETALLADA);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
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
	FUNCTION fnuGetID_PROYECTO
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
			 )
		then
			 return(rcData.ID_PROYECTO);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
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
	FUNCTION fnuGetID_ITEM
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.ID_ITEM%type
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
			 )
		then
			 return(rcData.ID_ITEM);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
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
	FUNCTION fnuGetCANTIDAD
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.CANTIDAD%type
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
			 )
		then
			 return(rcData.CANTIDAD);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
		);
		return(rcData.CANTIDAD);
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
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.COSTO%type
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
			 )
		then
			 return(rcData.COSTO);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
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
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.PRECIO%type
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
			 )
		then
			 return(rcData.PRECIO);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
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
	FUNCTION fnuGetTOTAL_COSTO
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.TOTAL_COSTO%type
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
			 )
		then
			 return(rcData.TOTAL_COSTO);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
		);
		return(rcData.TOTAL_COSTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTOTAL_PRECIO
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.TOTAL_PRECIO%type
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
			 )
		then
			 return(rcData.TOTAL_PRECIO);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
		);
		return(rcData.TOTAL_PRECIO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTIPO_ITEM
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
			 )
		then
			 return(rcData.TIPO_ITEM);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
		);
		return(rcData.TIPO_ITEM);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTIPO_TRAB
	(
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_COTIZ_PROY.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_ITEMS_COTIZ_PROY.ID_PROYECTO%type,
		inuID_ITEM in LDC_ITEMS_COTIZ_PROY.ID_ITEM%type,
		isbTIPO_ITEM in LDC_ITEMS_COTIZ_PROY.TIPO_ITEM%type,
		inuTIPO_TRAB in LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZ_PROY.TIPO_TRAB%type
	IS
		rcError styLDC_ITEMS_COTIZ_PROY;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_ITEM := isbTIPO_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
			 )
		then
			 return(rcData.TIPO_TRAB);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		isbTIPO_ITEM,
		 		inuTIPO_TRAB
		);
		return(rcData.TIPO_TRAB);
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
end DALDC_ITEMS_COTIZ_PROY;
/
PROMPT Otorgando permisos de ejecucion a DALDC_ITEMS_COTIZ_PROY
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_ITEMS_COTIZ_PROY', 'ADM_PERSON');
END;
/