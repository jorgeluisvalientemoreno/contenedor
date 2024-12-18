CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_METRAJE_TIPO_UNID_PRED
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
    05/06/2024              PAcosta         OSF-2777: Cambio de esquema ADM_PERSON                              
    ****************************************************************/  
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type
	)
	IS
		SELECT LDC_METRAJE_TIPO_UNID_PRED.*,LDC_METRAJE_TIPO_UNID_PRED.rowid
		FROM LDC_METRAJE_TIPO_UNID_PRED
		WHERE
		    ID_PROYECTO = inuID_PROYECTO
		    and TIPO_UNID_PREDIAL = inuTIPO_UNID_PREDIAL;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_METRAJE_TIPO_UNID_PRED.*,LDC_METRAJE_TIPO_UNID_PRED.rowid
		FROM LDC_METRAJE_TIPO_UNID_PRED
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_METRAJE_TIPO_UNID_PRED  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_METRAJE_TIPO_UNID_PRED is table of styLDC_METRAJE_TIPO_UNID_PRED index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_METRAJE_TIPO_UNID_PRED;

	/* Tipos referenciando al registro */
	type tytbTIPO_UNID_PREDIAL is table of LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type index by binary_integer;
	type tytbFLAUTA is table of LDC_METRAJE_TIPO_UNID_PRED.FLAUTA%type index by binary_integer;
	type tytbHORNO is table of LDC_METRAJE_TIPO_UNID_PRED.HORNO%type index by binary_integer;
	type tytbBBQ is table of LDC_METRAJE_TIPO_UNID_PRED.BBQ%type index by binary_integer;
	type tytbESTUFA is table of LDC_METRAJE_TIPO_UNID_PRED.ESTUFA%type index by binary_integer;
	type tytbSECADORA is table of LDC_METRAJE_TIPO_UNID_PRED.SECADORA%type index by binary_integer;
	type tytbCALENTADOR is table of LDC_METRAJE_TIPO_UNID_PRED.CALENTADOR%type index by binary_integer;
	type tytbLONG_VAL_BAJANTE is table of LDC_METRAJE_TIPO_UNID_PRED.LONG_VAL_BAJANTE%type index by binary_integer;
	type tytbLONG_BAJANTE_TABL is table of LDC_METRAJE_TIPO_UNID_PRED.LONG_BAJANTE_TABL%type index by binary_integer;
	type tytbLONG_TABLERO is table of LDC_METRAJE_TIPO_UNID_PRED.LONG_TABLERO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_METRAJE_TIPO_UNID_PRED is record
	(
		TIPO_UNID_PREDIAL   tytbTIPO_UNID_PREDIAL,
		ID_PROYECTO   tytbID_PROYECTO,
		FLAUTA   tytbFLAUTA,
		HORNO   tytbHORNO,
		BBQ   tytbBBQ,
		ESTUFA   tytbESTUFA,
		SECADORA   tytbSECADORA,
		CALENTADOR   tytbCALENTADOR,
		LONG_VAL_BAJANTE   tytbLONG_VAL_BAJANTE,
		LONG_BAJANTE_TABL   tytbLONG_BAJANTE_TABL,
		LONG_TABLERO   tytbLONG_TABLERO,
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
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type
	);

	PROCEDURE getRecord
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		orcRecord out nocopy styLDC_METRAJE_TIPO_UNID_PRED
	);

	FUNCTION frcGetRcData
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type
	)
	RETURN styLDC_METRAJE_TIPO_UNID_PRED;

	FUNCTION frcGetRcData
	RETURN styLDC_METRAJE_TIPO_UNID_PRED;

	FUNCTION frcGetRecord
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type
	)
	RETURN styLDC_METRAJE_TIPO_UNID_PRED;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_METRAJE_TIPO_UNID_PRED
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_METRAJE_TIPO_UNID_PRED in styLDC_METRAJE_TIPO_UNID_PRED
	);

	PROCEDURE insRecord
	(
		ircLDC_METRAJE_TIPO_UNID_PRED in styLDC_METRAJE_TIPO_UNID_PRED,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_METRAJE_TIPO_UNID_PRED in out nocopy tytbLDC_METRAJE_TIPO_UNID_PRED
	);

	PROCEDURE delRecord
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_METRAJE_TIPO_UNID_PRED in out nocopy tytbLDC_METRAJE_TIPO_UNID_PRED,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_METRAJE_TIPO_UNID_PRED in styLDC_METRAJE_TIPO_UNID_PRED,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_METRAJE_TIPO_UNID_PRED in out nocopy tytbLDC_METRAJE_TIPO_UNID_PRED,
		inuLock in number default 1
	);

	PROCEDURE updFLAUTA
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuFLAUTA$ in LDC_METRAJE_TIPO_UNID_PRED.FLAUTA%type,
		inuLock in number default 0
	);

	PROCEDURE updHORNO
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuHORNO$ in LDC_METRAJE_TIPO_UNID_PRED.HORNO%type,
		inuLock in number default 0
	);

	PROCEDURE updBBQ
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuBBQ$ in LDC_METRAJE_TIPO_UNID_PRED.BBQ%type,
		inuLock in number default 0
	);

	PROCEDURE updESTUFA
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuESTUFA$ in LDC_METRAJE_TIPO_UNID_PRED.ESTUFA%type,
		inuLock in number default 0
	);

	PROCEDURE updSECADORA
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuSECADORA$ in LDC_METRAJE_TIPO_UNID_PRED.SECADORA%type,
		inuLock in number default 0
	);

	PROCEDURE updCALENTADOR
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuCALENTADOR$ in LDC_METRAJE_TIPO_UNID_PRED.CALENTADOR%type,
		inuLock in number default 0
	);

	PROCEDURE updLONG_VAL_BAJANTE
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuLONG_VAL_BAJANTE$ in LDC_METRAJE_TIPO_UNID_PRED.LONG_VAL_BAJANTE%type,
		inuLock in number default 0
	);

	PROCEDURE updLONG_BAJANTE_TABL
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuLONG_BAJANTE_TABL$ in LDC_METRAJE_TIPO_UNID_PRED.LONG_BAJANTE_TABL%type,
		inuLock in number default 0
	);

	PROCEDURE updLONG_TABLERO
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuLONG_TABLERO$ in LDC_METRAJE_TIPO_UNID_PRED.LONG_TABLERO%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetTIPO_UNID_PREDIAL
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type;

	FUNCTION fnuGetFLAUTA
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.FLAUTA%type;

	FUNCTION fnuGetHORNO
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.HORNO%type;

	FUNCTION fnuGetBBQ
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.BBQ%type;

	FUNCTION fnuGetESTUFA
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.ESTUFA%type;

	FUNCTION fnuGetSECADORA
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.SECADORA%type;

	FUNCTION fnuGetCALENTADOR
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.CALENTADOR%type;

	FUNCTION fnuGetLONG_VAL_BAJANTE
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.LONG_VAL_BAJANTE%type;

	FUNCTION fnuGetLONG_BAJANTE_TABL
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.LONG_BAJANTE_TABL%type;

	FUNCTION fnuGetLONG_TABLERO
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.LONG_TABLERO%type;


	PROCEDURE LockByPk
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		orcLDC_METRAJE_TIPO_UNID_PRED  out styLDC_METRAJE_TIPO_UNID_PRED
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_METRAJE_TIPO_UNID_PRED  out styLDC_METRAJE_TIPO_UNID_PRED
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_METRAJE_TIPO_UNID_PRED;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_METRAJE_TIPO_UNID_PRED
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_METRAJE_TIPO_UNID_PRED';
	 cnuGeEntityId constant varchar2(30) := 2860; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type
	)
	IS
		SELECT LDC_METRAJE_TIPO_UNID_PRED.*,LDC_METRAJE_TIPO_UNID_PRED.rowid
		FROM LDC_METRAJE_TIPO_UNID_PRED
		WHERE  ID_PROYECTO = inuID_PROYECTO
			and TIPO_UNID_PREDIAL = inuTIPO_UNID_PREDIAL
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_METRAJE_TIPO_UNID_PRED.*,LDC_METRAJE_TIPO_UNID_PRED.rowid
		FROM LDC_METRAJE_TIPO_UNID_PRED
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_METRAJE_TIPO_UNID_PRED is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_METRAJE_TIPO_UNID_PRED;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_METRAJE_TIPO_UNID_PRED default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_PROYECTO);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.TIPO_UNID_PREDIAL);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		orcLDC_METRAJE_TIPO_UNID_PRED  out styLDC_METRAJE_TIPO_UNID_PRED
	)
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;

		Open cuLockRcByPk
		(
			inuID_PROYECTO,
			inuTIPO_UNID_PREDIAL
		);

		fetch cuLockRcByPk into orcLDC_METRAJE_TIPO_UNID_PRED;
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
		orcLDC_METRAJE_TIPO_UNID_PRED  out styLDC_METRAJE_TIPO_UNID_PRED
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_METRAJE_TIPO_UNID_PRED;
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
		itbLDC_METRAJE_TIPO_UNID_PRED  in out nocopy tytbLDC_METRAJE_TIPO_UNID_PRED
	)
	IS
	BEGIN
			rcRecOfTab.TIPO_UNID_PREDIAL.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.FLAUTA.delete;
			rcRecOfTab.HORNO.delete;
			rcRecOfTab.BBQ.delete;
			rcRecOfTab.ESTUFA.delete;
			rcRecOfTab.SECADORA.delete;
			rcRecOfTab.CALENTADOR.delete;
			rcRecOfTab.LONG_VAL_BAJANTE.delete;
			rcRecOfTab.LONG_BAJANTE_TABL.delete;
			rcRecOfTab.LONG_TABLERO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_METRAJE_TIPO_UNID_PRED  in out nocopy tytbLDC_METRAJE_TIPO_UNID_PRED,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_METRAJE_TIPO_UNID_PRED);

		for n in itbLDC_METRAJE_TIPO_UNID_PRED.first .. itbLDC_METRAJE_TIPO_UNID_PRED.last loop
			rcRecOfTab.TIPO_UNID_PREDIAL(n) := itbLDC_METRAJE_TIPO_UNID_PRED(n).TIPO_UNID_PREDIAL;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_METRAJE_TIPO_UNID_PRED(n).ID_PROYECTO;
			rcRecOfTab.FLAUTA(n) := itbLDC_METRAJE_TIPO_UNID_PRED(n).FLAUTA;
			rcRecOfTab.HORNO(n) := itbLDC_METRAJE_TIPO_UNID_PRED(n).HORNO;
			rcRecOfTab.BBQ(n) := itbLDC_METRAJE_TIPO_UNID_PRED(n).BBQ;
			rcRecOfTab.ESTUFA(n) := itbLDC_METRAJE_TIPO_UNID_PRED(n).ESTUFA;
			rcRecOfTab.SECADORA(n) := itbLDC_METRAJE_TIPO_UNID_PRED(n).SECADORA;
			rcRecOfTab.CALENTADOR(n) := itbLDC_METRAJE_TIPO_UNID_PRED(n).CALENTADOR;
			rcRecOfTab.LONG_VAL_BAJANTE(n) := itbLDC_METRAJE_TIPO_UNID_PRED(n).LONG_VAL_BAJANTE;
			rcRecOfTab.LONG_BAJANTE_TABL(n) := itbLDC_METRAJE_TIPO_UNID_PRED(n).LONG_BAJANTE_TABL;
			rcRecOfTab.LONG_TABLERO(n) := itbLDC_METRAJE_TIPO_UNID_PRED(n).LONG_TABLERO;
			rcRecOfTab.row_id(n) := itbLDC_METRAJE_TIPO_UNID_PRED(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_PROYECTO,
			inuTIPO_UNID_PREDIAL
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
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_PROYECTO = rcData.ID_PROYECTO AND
			inuTIPO_UNID_PREDIAL = rcData.TIPO_UNID_PREDIAL
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
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_PROYECTO,
			inuTIPO_UNID_PREDIAL
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type
	)
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN		rcError.ID_PROYECTO:=inuID_PROYECTO;		rcError.TIPO_UNID_PREDIAL:=inuTIPO_UNID_PREDIAL;

		Load
		(
			inuID_PROYECTO,
			inuTIPO_UNID_PREDIAL
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
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type
	)
	IS
	BEGIN
		Load
		(
			inuID_PROYECTO,
			inuTIPO_UNID_PREDIAL
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		orcRecord out nocopy styLDC_METRAJE_TIPO_UNID_PRED
	)
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN		rcError.ID_PROYECTO:=inuID_PROYECTO;		rcError.TIPO_UNID_PREDIAL:=inuTIPO_UNID_PREDIAL;

		Load
		(
			inuID_PROYECTO,
			inuTIPO_UNID_PREDIAL
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type
	)
	RETURN styLDC_METRAJE_TIPO_UNID_PRED
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN
		rcError.ID_PROYECTO:=inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL:=inuTIPO_UNID_PREDIAL;

		Load
		(
			inuID_PROYECTO,
			inuTIPO_UNID_PREDIAL
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type
	)
	RETURN styLDC_METRAJE_TIPO_UNID_PRED
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN
		rcError.ID_PROYECTO:=inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL:=inuTIPO_UNID_PREDIAL;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_PROYECTO,
			inuTIPO_UNID_PREDIAL
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_PROYECTO,
			inuTIPO_UNID_PREDIAL
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_METRAJE_TIPO_UNID_PRED
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_METRAJE_TIPO_UNID_PRED
	)
	IS
		rfLDC_METRAJE_TIPO_UNID_PRED tyrfLDC_METRAJE_TIPO_UNID_PRED;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_METRAJE_TIPO_UNID_PRED.*, LDC_METRAJE_TIPO_UNID_PRED.rowid FROM LDC_METRAJE_TIPO_UNID_PRED';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_METRAJE_TIPO_UNID_PRED for sbFullQuery;

		fetch rfLDC_METRAJE_TIPO_UNID_PRED bulk collect INTO otbResult;

		close rfLDC_METRAJE_TIPO_UNID_PRED;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_METRAJE_TIPO_UNID_PRED.*, LDC_METRAJE_TIPO_UNID_PRED.rowid FROM LDC_METRAJE_TIPO_UNID_PRED';
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
		ircLDC_METRAJE_TIPO_UNID_PRED in styLDC_METRAJE_TIPO_UNID_PRED
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_METRAJE_TIPO_UNID_PRED,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_METRAJE_TIPO_UNID_PRED in styLDC_METRAJE_TIPO_UNID_PRED,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PROYECTO');
			raise ex.controlled_error;
		end if;
		if ircLDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|TIPO_UNID_PREDIAL');
			raise ex.controlled_error;
		end if;

		insert into LDC_METRAJE_TIPO_UNID_PRED
		(
			TIPO_UNID_PREDIAL,
			ID_PROYECTO,
			FLAUTA,
			HORNO,
			BBQ,
			ESTUFA,
			SECADORA,
			CALENTADOR,
			LONG_VAL_BAJANTE,
			LONG_BAJANTE_TABL,
			LONG_TABLERO
		)
		values
		(
			ircLDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL,
			ircLDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO,
			ircLDC_METRAJE_TIPO_UNID_PRED.FLAUTA,
			ircLDC_METRAJE_TIPO_UNID_PRED.HORNO,
			ircLDC_METRAJE_TIPO_UNID_PRED.BBQ,
			ircLDC_METRAJE_TIPO_UNID_PRED.ESTUFA,
			ircLDC_METRAJE_TIPO_UNID_PRED.SECADORA,
			ircLDC_METRAJE_TIPO_UNID_PRED.CALENTADOR,
			ircLDC_METRAJE_TIPO_UNID_PRED.LONG_VAL_BAJANTE,
			ircLDC_METRAJE_TIPO_UNID_PRED.LONG_BAJANTE_TABL,
			ircLDC_METRAJE_TIPO_UNID_PRED.LONG_TABLERO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_METRAJE_TIPO_UNID_PRED));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_METRAJE_TIPO_UNID_PRED in out nocopy tytbLDC_METRAJE_TIPO_UNID_PRED
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_METRAJE_TIPO_UNID_PRED,blUseRowID);
		forall n in iotbLDC_METRAJE_TIPO_UNID_PRED.first..iotbLDC_METRAJE_TIPO_UNID_PRED.last
			insert into LDC_METRAJE_TIPO_UNID_PRED
			(
				TIPO_UNID_PREDIAL,
				ID_PROYECTO,
				FLAUTA,
				HORNO,
				BBQ,
				ESTUFA,
				SECADORA,
				CALENTADOR,
				LONG_VAL_BAJANTE,
				LONG_BAJANTE_TABL,
				LONG_TABLERO
			)
			values
			(
				rcRecOfTab.TIPO_UNID_PREDIAL(n),
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.FLAUTA(n),
				rcRecOfTab.HORNO(n),
				rcRecOfTab.BBQ(n),
				rcRecOfTab.ESTUFA(n),
				rcRecOfTab.SECADORA(n),
				rcRecOfTab.CALENTADOR(n),
				rcRecOfTab.LONG_VAL_BAJANTE(n),
				rcRecOfTab.LONG_BAJANTE_TABL(n),
				rcRecOfTab.LONG_TABLERO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;

		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuTIPO_UNID_PREDIAL,
				rcData
			);
		end if;


		delete
		from LDC_METRAJE_TIPO_UNID_PRED
		where
       		ID_PROYECTO=inuID_PROYECTO and
       		TIPO_UNID_PREDIAL=inuTIPO_UNID_PREDIAL;
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
		rcError  styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_METRAJE_TIPO_UNID_PRED
		where
			rowid = iriRowID
		returning
			TIPO_UNID_PREDIAL,
			ID_PROYECTO
		into
			rcError.TIPO_UNID_PREDIAL,
			rcError.ID_PROYECTO;
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
		iotbLDC_METRAJE_TIPO_UNID_PRED in out nocopy tytbLDC_METRAJE_TIPO_UNID_PRED,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN
		FillRecordOfTables(iotbLDC_METRAJE_TIPO_UNID_PRED, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_METRAJE_TIPO_UNID_PRED.first .. iotbLDC_METRAJE_TIPO_UNID_PRED.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_METRAJE_TIPO_UNID_PRED.first .. iotbLDC_METRAJE_TIPO_UNID_PRED.last
				delete
				from LDC_METRAJE_TIPO_UNID_PRED
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_METRAJE_TIPO_UNID_PRED.first .. iotbLDC_METRAJE_TIPO_UNID_PRED.last loop
					LockByPk
					(
						rcRecOfTab.ID_PROYECTO(n),
						rcRecOfTab.TIPO_UNID_PREDIAL(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_METRAJE_TIPO_UNID_PRED.first .. iotbLDC_METRAJE_TIPO_UNID_PRED.last
				delete
				from LDC_METRAJE_TIPO_UNID_PRED
				where
		         	ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n) and
		         	TIPO_UNID_PREDIAL = rcRecOfTab.TIPO_UNID_PREDIAL(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_METRAJE_TIPO_UNID_PRED in styLDC_METRAJE_TIPO_UNID_PRED,
		inuLock in number default 0
	)
	IS
		nuID_PROYECTO	LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type;
		nuTIPO_UNID_PREDIAL	LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type;
	BEGIN
		if ircLDC_METRAJE_TIPO_UNID_PRED.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_METRAJE_TIPO_UNID_PRED.rowid,rcData);
			end if;
			update LDC_METRAJE_TIPO_UNID_PRED
			set
				FLAUTA = ircLDC_METRAJE_TIPO_UNID_PRED.FLAUTA,
				HORNO = ircLDC_METRAJE_TIPO_UNID_PRED.HORNO,
				BBQ = ircLDC_METRAJE_TIPO_UNID_PRED.BBQ,
				ESTUFA = ircLDC_METRAJE_TIPO_UNID_PRED.ESTUFA,
				SECADORA = ircLDC_METRAJE_TIPO_UNID_PRED.SECADORA,
				CALENTADOR = ircLDC_METRAJE_TIPO_UNID_PRED.CALENTADOR,
				LONG_VAL_BAJANTE = ircLDC_METRAJE_TIPO_UNID_PRED.LONG_VAL_BAJANTE,
				LONG_BAJANTE_TABL = ircLDC_METRAJE_TIPO_UNID_PRED.LONG_BAJANTE_TABL,
				LONG_TABLERO = ircLDC_METRAJE_TIPO_UNID_PRED.LONG_TABLERO
			where
				rowid = ircLDC_METRAJE_TIPO_UNID_PRED.rowid
			returning
				ID_PROYECTO,
				TIPO_UNID_PREDIAL
			into
				nuID_PROYECTO,
				nuTIPO_UNID_PREDIAL;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO,
					ircLDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL,
					rcData
				);
			end if;

			update LDC_METRAJE_TIPO_UNID_PRED
			set
				FLAUTA = ircLDC_METRAJE_TIPO_UNID_PRED.FLAUTA,
				HORNO = ircLDC_METRAJE_TIPO_UNID_PRED.HORNO,
				BBQ = ircLDC_METRAJE_TIPO_UNID_PRED.BBQ,
				ESTUFA = ircLDC_METRAJE_TIPO_UNID_PRED.ESTUFA,
				SECADORA = ircLDC_METRAJE_TIPO_UNID_PRED.SECADORA,
				CALENTADOR = ircLDC_METRAJE_TIPO_UNID_PRED.CALENTADOR,
				LONG_VAL_BAJANTE = ircLDC_METRAJE_TIPO_UNID_PRED.LONG_VAL_BAJANTE,
				LONG_BAJANTE_TABL = ircLDC_METRAJE_TIPO_UNID_PRED.LONG_BAJANTE_TABL,
				LONG_TABLERO = ircLDC_METRAJE_TIPO_UNID_PRED.LONG_TABLERO
			where
				ID_PROYECTO = ircLDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO and
				TIPO_UNID_PREDIAL = ircLDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL
			returning
				ID_PROYECTO,
				TIPO_UNID_PREDIAL
			into
				nuID_PROYECTO,
				nuTIPO_UNID_PREDIAL;
		end if;
		if
			nuID_PROYECTO is NULL OR
			nuTIPO_UNID_PREDIAL is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_METRAJE_TIPO_UNID_PRED));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_METRAJE_TIPO_UNID_PRED in out nocopy tytbLDC_METRAJE_TIPO_UNID_PRED,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN
		FillRecordOfTables(iotbLDC_METRAJE_TIPO_UNID_PRED,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_METRAJE_TIPO_UNID_PRED.first .. iotbLDC_METRAJE_TIPO_UNID_PRED.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_METRAJE_TIPO_UNID_PRED.first .. iotbLDC_METRAJE_TIPO_UNID_PRED.last
				update LDC_METRAJE_TIPO_UNID_PRED
				set
					FLAUTA = rcRecOfTab.FLAUTA(n),
					HORNO = rcRecOfTab.HORNO(n),
					BBQ = rcRecOfTab.BBQ(n),
					ESTUFA = rcRecOfTab.ESTUFA(n),
					SECADORA = rcRecOfTab.SECADORA(n),
					CALENTADOR = rcRecOfTab.CALENTADOR(n),
					LONG_VAL_BAJANTE = rcRecOfTab.LONG_VAL_BAJANTE(n),
					LONG_BAJANTE_TABL = rcRecOfTab.LONG_BAJANTE_TABL(n),
					LONG_TABLERO = rcRecOfTab.LONG_TABLERO(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_METRAJE_TIPO_UNID_PRED.first .. iotbLDC_METRAJE_TIPO_UNID_PRED.last loop
					LockByPk
					(
						rcRecOfTab.ID_PROYECTO(n),
						rcRecOfTab.TIPO_UNID_PREDIAL(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_METRAJE_TIPO_UNID_PRED.first .. iotbLDC_METRAJE_TIPO_UNID_PRED.last
				update LDC_METRAJE_TIPO_UNID_PRED
				SET
					FLAUTA = rcRecOfTab.FLAUTA(n),
					HORNO = rcRecOfTab.HORNO(n),
					BBQ = rcRecOfTab.BBQ(n),
					ESTUFA = rcRecOfTab.ESTUFA(n),
					SECADORA = rcRecOfTab.SECADORA(n),
					CALENTADOR = rcRecOfTab.CALENTADOR(n),
					LONG_VAL_BAJANTE = rcRecOfTab.LONG_VAL_BAJANTE(n),
					LONG_BAJANTE_TABL = rcRecOfTab.LONG_BAJANTE_TABL(n),
					LONG_TABLERO = rcRecOfTab.LONG_TABLERO(n)
				where
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n) and
					TIPO_UNID_PREDIAL = rcRecOfTab.TIPO_UNID_PREDIAL(n)
;
		end if;
	END;
	PROCEDURE updFLAUTA
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuFLAUTA$ in LDC_METRAJE_TIPO_UNID_PRED.FLAUTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuTIPO_UNID_PREDIAL,
				rcData
			);
		end if;

		update LDC_METRAJE_TIPO_UNID_PRED
		set
			FLAUTA = inuFLAUTA$
		where
			ID_PROYECTO = inuID_PROYECTO and
			TIPO_UNID_PREDIAL = inuTIPO_UNID_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FLAUTA:= inuFLAUTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updHORNO
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuHORNO$ in LDC_METRAJE_TIPO_UNID_PRED.HORNO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuTIPO_UNID_PREDIAL,
				rcData
			);
		end if;

		update LDC_METRAJE_TIPO_UNID_PRED
		set
			HORNO = inuHORNO$
		where
			ID_PROYECTO = inuID_PROYECTO and
			TIPO_UNID_PREDIAL = inuTIPO_UNID_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.HORNO:= inuHORNO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBBQ
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuBBQ$ in LDC_METRAJE_TIPO_UNID_PRED.BBQ%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuTIPO_UNID_PREDIAL,
				rcData
			);
		end if;

		update LDC_METRAJE_TIPO_UNID_PRED
		set
			BBQ = inuBBQ$
		where
			ID_PROYECTO = inuID_PROYECTO and
			TIPO_UNID_PREDIAL = inuTIPO_UNID_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BBQ:= inuBBQ$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updESTUFA
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuESTUFA$ in LDC_METRAJE_TIPO_UNID_PRED.ESTUFA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuTIPO_UNID_PREDIAL,
				rcData
			);
		end if;

		update LDC_METRAJE_TIPO_UNID_PRED
		set
			ESTUFA = inuESTUFA$
		where
			ID_PROYECTO = inuID_PROYECTO and
			TIPO_UNID_PREDIAL = inuTIPO_UNID_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ESTUFA:= inuESTUFA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSECADORA
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuSECADORA$ in LDC_METRAJE_TIPO_UNID_PRED.SECADORA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuTIPO_UNID_PREDIAL,
				rcData
			);
		end if;

		update LDC_METRAJE_TIPO_UNID_PRED
		set
			SECADORA = inuSECADORA$
		where
			ID_PROYECTO = inuID_PROYECTO and
			TIPO_UNID_PREDIAL = inuTIPO_UNID_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SECADORA:= inuSECADORA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCALENTADOR
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuCALENTADOR$ in LDC_METRAJE_TIPO_UNID_PRED.CALENTADOR%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuTIPO_UNID_PREDIAL,
				rcData
			);
		end if;

		update LDC_METRAJE_TIPO_UNID_PRED
		set
			CALENTADOR = inuCALENTADOR$
		where
			ID_PROYECTO = inuID_PROYECTO and
			TIPO_UNID_PREDIAL = inuTIPO_UNID_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CALENTADOR:= inuCALENTADOR$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLONG_VAL_BAJANTE
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuLONG_VAL_BAJANTE$ in LDC_METRAJE_TIPO_UNID_PRED.LONG_VAL_BAJANTE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuTIPO_UNID_PREDIAL,
				rcData
			);
		end if;

		update LDC_METRAJE_TIPO_UNID_PRED
		set
			LONG_VAL_BAJANTE = inuLONG_VAL_BAJANTE$
		where
			ID_PROYECTO = inuID_PROYECTO and
			TIPO_UNID_PREDIAL = inuTIPO_UNID_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LONG_VAL_BAJANTE:= inuLONG_VAL_BAJANTE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLONG_BAJANTE_TABL
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuLONG_BAJANTE_TABL$ in LDC_METRAJE_TIPO_UNID_PRED.LONG_BAJANTE_TABL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuTIPO_UNID_PREDIAL,
				rcData
			);
		end if;

		update LDC_METRAJE_TIPO_UNID_PRED
		set
			LONG_BAJANTE_TABL = inuLONG_BAJANTE_TABL$
		where
			ID_PROYECTO = inuID_PROYECTO and
			TIPO_UNID_PREDIAL = inuTIPO_UNID_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LONG_BAJANTE_TABL:= inuLONG_BAJANTE_TABL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLONG_TABLERO
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuLONG_TABLERO$ in LDC_METRAJE_TIPO_UNID_PRED.LONG_TABLERO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuTIPO_UNID_PREDIAL,
				rcData
			);
		end if;

		update LDC_METRAJE_TIPO_UNID_PRED
		set
			LONG_TABLERO = inuLONG_TABLERO$
		where
			ID_PROYECTO = inuID_PROYECTO and
			TIPO_UNID_PREDIAL = inuTIPO_UNID_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LONG_TABLERO:= inuLONG_TABLERO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetTIPO_UNID_PREDIAL
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
			 )
		then
			 return(rcData.TIPO_UNID_PREDIAL);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
		);
		return(rcData.TIPO_UNID_PREDIAL);
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
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
			 )
		then
			 return(rcData.ID_PROYECTO);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
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
	FUNCTION fnuGetFLAUTA
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.FLAUTA%type
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
			 )
		then
			 return(rcData.FLAUTA);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
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
	FUNCTION fnuGetHORNO
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.HORNO%type
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
			 )
		then
			 return(rcData.HORNO);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
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
	FUNCTION fnuGetBBQ
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.BBQ%type
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
			 )
		then
			 return(rcData.BBQ);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
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
	FUNCTION fnuGetESTUFA
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.ESTUFA%type
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
			 )
		then
			 return(rcData.ESTUFA);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
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
	FUNCTION fnuGetSECADORA
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.SECADORA%type
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
			 )
		then
			 return(rcData.SECADORA);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
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
	FUNCTION fnuGetCALENTADOR
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.CALENTADOR%type
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
			 )
		then
			 return(rcData.CALENTADOR);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
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
	FUNCTION fnuGetLONG_VAL_BAJANTE
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.LONG_VAL_BAJANTE%type
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
			 )
		then
			 return(rcData.LONG_VAL_BAJANTE);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
		);
		return(rcData.LONG_VAL_BAJANTE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLONG_BAJANTE_TABL
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.LONG_BAJANTE_TABL%type
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
			 )
		then
			 return(rcData.LONG_BAJANTE_TABL);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
		);
		return(rcData.LONG_BAJANTE_TABL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLONG_TABLERO
	(
		inuID_PROYECTO in LDC_METRAJE_TIPO_UNID_PRED.ID_PROYECTO%type,
		inuTIPO_UNID_PREDIAL in LDC_METRAJE_TIPO_UNID_PRED.TIPO_UNID_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_TIPO_UNID_PRED.LONG_TABLERO%type
	IS
		rcError styLDC_METRAJE_TIPO_UNID_PRED;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.TIPO_UNID_PREDIAL := inuTIPO_UNID_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
			 )
		then
			 return(rcData.LONG_TABLERO);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuTIPO_UNID_PREDIAL
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
	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALDC_METRAJE_TIPO_UNID_PRED;
/
PROMPT Otorgando permisos de ejecucion a DALDC_METRAJE_TIPO_UNID_PRED
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_METRAJE_TIPO_UNID_PRED', 'ADM_PERSON');
END;
/