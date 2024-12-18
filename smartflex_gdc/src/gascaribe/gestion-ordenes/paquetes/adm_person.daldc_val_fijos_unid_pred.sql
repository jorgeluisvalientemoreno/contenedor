CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_VAL_FIJOS_UNID_PRED
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
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type
	)
	IS
		SELECT LDC_VAL_FIJOS_UNID_PRED.*,LDC_VAL_FIJOS_UNID_PRED.rowid
		FROM LDC_VAL_FIJOS_UNID_PRED
		WHERE
		    ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA
		    and ID_PROYECTO = inuID_PROYECTO
		    and ID_ITEM = inuID_ITEM
		    and TIPO_TRAB = inuTIPO_TRAB;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_VAL_FIJOS_UNID_PRED.*,LDC_VAL_FIJOS_UNID_PRED.rowid
		FROM LDC_VAL_FIJOS_UNID_PRED
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_VAL_FIJOS_UNID_PRED  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_VAL_FIJOS_UNID_PRED is table of styLDC_VAL_FIJOS_UNID_PRED index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_VAL_FIJOS_UNID_PRED;

	/* Tipos referenciando al registro */
	type tytbTIPO_TRAB is table of LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type index by binary_integer;
	type tytbID_ITEM is table of LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type index by binary_integer;
	type tytbDESCRIPCION is table of LDC_VAL_FIJOS_UNID_PRED.DESCRIPCION%type index by binary_integer;
	type tytbCANTIDAD is table of LDC_VAL_FIJOS_UNID_PRED.CANTIDAD%type index by binary_integer;
	type tytbPRECIO is table of LDC_VAL_FIJOS_UNID_PRED.PRECIO%type index by binary_integer;
	type tytbTOTAL_PRECIO is table of LDC_VAL_FIJOS_UNID_PRED.TOTAL_PRECIO%type index by binary_integer;
	type tytbID_COTIZACION_DETALLADA is table of LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_VAL_FIJOS_UNID_PRED is record
	(
		TIPO_TRAB   tytbTIPO_TRAB,
		ID_ITEM   tytbID_ITEM,
		ID_PROYECTO   tytbID_PROYECTO,
		DESCRIPCION   tytbDESCRIPCION,
		CANTIDAD   tytbCANTIDAD,
		PRECIO   tytbPRECIO,
		TOTAL_PRECIO   tytbTOTAL_PRECIO,
		ID_COTIZACION_DETALLADA   tytbID_COTIZACION_DETALLADA,
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
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type
	);

	PROCEDURE getRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		orcRecord out nocopy styLDC_VAL_FIJOS_UNID_PRED
	);

	FUNCTION frcGetRcData
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type
	)
	RETURN styLDC_VAL_FIJOS_UNID_PRED;

	FUNCTION frcGetRcData
	RETURN styLDC_VAL_FIJOS_UNID_PRED;

	FUNCTION frcGetRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type
	)
	RETURN styLDC_VAL_FIJOS_UNID_PRED;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VAL_FIJOS_UNID_PRED
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_VAL_FIJOS_UNID_PRED in styLDC_VAL_FIJOS_UNID_PRED
	);

	PROCEDURE insRecord
	(
		ircLDC_VAL_FIJOS_UNID_PRED in styLDC_VAL_FIJOS_UNID_PRED,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_VAL_FIJOS_UNID_PRED in out nocopy tytbLDC_VAL_FIJOS_UNID_PRED
	);

	PROCEDURE delRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_VAL_FIJOS_UNID_PRED in out nocopy tytbLDC_VAL_FIJOS_UNID_PRED,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_VAL_FIJOS_UNID_PRED in styLDC_VAL_FIJOS_UNID_PRED,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_VAL_FIJOS_UNID_PRED in out nocopy tytbLDC_VAL_FIJOS_UNID_PRED,
		inuLock in number default 1
	);

	PROCEDURE updDESCRIPCION
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		isbDESCRIPCION$ in LDC_VAL_FIJOS_UNID_PRED.DESCRIPCION%type,
		inuLock in number default 0
	);

	PROCEDURE updCANTIDAD
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuCANTIDAD$ in LDC_VAL_FIJOS_UNID_PRED.CANTIDAD%type,
		inuLock in number default 0
	);

	PROCEDURE updPRECIO
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuPRECIO$ in LDC_VAL_FIJOS_UNID_PRED.PRECIO%type,
		inuLock in number default 0
	);

	PROCEDURE updTOTAL_PRECIO
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuTOTAL_PRECIO$ in LDC_VAL_FIJOS_UNID_PRED.TOTAL_PRECIO%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetTIPO_TRAB
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type;

	FUNCTION fnuGetID_ITEM
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type;

	FUNCTION fsbGetDESCRIPCION
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VAL_FIJOS_UNID_PRED.DESCRIPCION%type;

	FUNCTION fnuGetCANTIDAD
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VAL_FIJOS_UNID_PRED.CANTIDAD%type;

	FUNCTION fnuGetPRECIO
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VAL_FIJOS_UNID_PRED.PRECIO%type;

	FUNCTION fnuGetTOTAL_PRECIO
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VAL_FIJOS_UNID_PRED.TOTAL_PRECIO%type;

	FUNCTION fnuGetID_COTIZACION_DETALLADA
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type;


	PROCEDURE LockByPk
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		orcLDC_VAL_FIJOS_UNID_PRED  out styLDC_VAL_FIJOS_UNID_PRED
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_VAL_FIJOS_UNID_PRED  out styLDC_VAL_FIJOS_UNID_PRED
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_VAL_FIJOS_UNID_PRED;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_VAL_FIJOS_UNID_PRED
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_VAL_FIJOS_UNID_PRED';
	 cnuGeEntityId constant varchar2(30) := 2868; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type
	)
	IS
		SELECT LDC_VAL_FIJOS_UNID_PRED.*,LDC_VAL_FIJOS_UNID_PRED.rowid
		FROM LDC_VAL_FIJOS_UNID_PRED
		WHERE  ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA
			and ID_PROYECTO = inuID_PROYECTO
			and ID_ITEM = inuID_ITEM
			and TIPO_TRAB = inuTIPO_TRAB
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_VAL_FIJOS_UNID_PRED.*,LDC_VAL_FIJOS_UNID_PRED.rowid
		FROM LDC_VAL_FIJOS_UNID_PRED
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_VAL_FIJOS_UNID_PRED is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_VAL_FIJOS_UNID_PRED;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_VAL_FIJOS_UNID_PRED default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_COTIZACION_DETALLADA);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_PROYECTO);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_ITEM);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.TIPO_TRAB);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		orcLDC_VAL_FIJOS_UNID_PRED  out styLDC_VAL_FIJOS_UNID_PRED
	)
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

		Open cuLockRcByPk
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_ITEM,
			inuTIPO_TRAB
		);

		fetch cuLockRcByPk into orcLDC_VAL_FIJOS_UNID_PRED;
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
		orcLDC_VAL_FIJOS_UNID_PRED  out styLDC_VAL_FIJOS_UNID_PRED
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_VAL_FIJOS_UNID_PRED;
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
		itbLDC_VAL_FIJOS_UNID_PRED  in out nocopy tytbLDC_VAL_FIJOS_UNID_PRED
	)
	IS
	BEGIN
			rcRecOfTab.TIPO_TRAB.delete;
			rcRecOfTab.ID_ITEM.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.DESCRIPCION.delete;
			rcRecOfTab.CANTIDAD.delete;
			rcRecOfTab.PRECIO.delete;
			rcRecOfTab.TOTAL_PRECIO.delete;
			rcRecOfTab.ID_COTIZACION_DETALLADA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_VAL_FIJOS_UNID_PRED  in out nocopy tytbLDC_VAL_FIJOS_UNID_PRED,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_VAL_FIJOS_UNID_PRED);

		for n in itbLDC_VAL_FIJOS_UNID_PRED.first .. itbLDC_VAL_FIJOS_UNID_PRED.last loop
			rcRecOfTab.TIPO_TRAB(n) := itbLDC_VAL_FIJOS_UNID_PRED(n).TIPO_TRAB;
			rcRecOfTab.ID_ITEM(n) := itbLDC_VAL_FIJOS_UNID_PRED(n).ID_ITEM;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_VAL_FIJOS_UNID_PRED(n).ID_PROYECTO;
			rcRecOfTab.DESCRIPCION(n) := itbLDC_VAL_FIJOS_UNID_PRED(n).DESCRIPCION;
			rcRecOfTab.CANTIDAD(n) := itbLDC_VAL_FIJOS_UNID_PRED(n).CANTIDAD;
			rcRecOfTab.PRECIO(n) := itbLDC_VAL_FIJOS_UNID_PRED(n).PRECIO;
			rcRecOfTab.TOTAL_PRECIO(n) := itbLDC_VAL_FIJOS_UNID_PRED(n).TOTAL_PRECIO;
			rcRecOfTab.ID_COTIZACION_DETALLADA(n) := itbLDC_VAL_FIJOS_UNID_PRED(n).ID_COTIZACION_DETALLADA;
			rcRecOfTab.row_id(n) := itbLDC_VAL_FIJOS_UNID_PRED(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type
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
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_COTIZACION_DETALLADA = rcData.ID_COTIZACION_DETALLADA AND
			inuID_PROYECTO = rcData.ID_PROYECTO AND
			inuID_ITEM = rcData.ID_ITEM AND
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
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_ITEM,
			inuTIPO_TRAB
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type
	)
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;		rcError.ID_PROYECTO:=inuID_PROYECTO;		rcError.ID_ITEM:=inuID_ITEM;		rcError.TIPO_TRAB:=inuTIPO_TRAB;

		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_ITEM,
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
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type
	)
	IS
	BEGIN
		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_ITEM,
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
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		orcRecord out nocopy styLDC_VAL_FIJOS_UNID_PRED
	)
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;		rcError.ID_PROYECTO:=inuID_PROYECTO;		rcError.ID_ITEM:=inuID_ITEM;		rcError.TIPO_TRAB:=inuTIPO_TRAB;

		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_ITEM,
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
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type
	)
	RETURN styLDC_VAL_FIJOS_UNID_PRED
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO:=inuID_PROYECTO;
		rcError.ID_ITEM:=inuID_ITEM;
		rcError.TIPO_TRAB:=inuTIPO_TRAB;

		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_ITEM,
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
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type
	)
	RETURN styLDC_VAL_FIJOS_UNID_PRED
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO:=inuID_PROYECTO;
		rcError.ID_ITEM:=inuID_ITEM;
		rcError.TIPO_TRAB:=inuTIPO_TRAB;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_ITEM,
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
			inuTIPO_TRAB
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_VAL_FIJOS_UNID_PRED
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VAL_FIJOS_UNID_PRED
	)
	IS
		rfLDC_VAL_FIJOS_UNID_PRED tyrfLDC_VAL_FIJOS_UNID_PRED;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_VAL_FIJOS_UNID_PRED.*, LDC_VAL_FIJOS_UNID_PRED.rowid FROM LDC_VAL_FIJOS_UNID_PRED';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_VAL_FIJOS_UNID_PRED for sbFullQuery;

		fetch rfLDC_VAL_FIJOS_UNID_PRED bulk collect INTO otbResult;

		close rfLDC_VAL_FIJOS_UNID_PRED;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_VAL_FIJOS_UNID_PRED.*, LDC_VAL_FIJOS_UNID_PRED.rowid FROM LDC_VAL_FIJOS_UNID_PRED';
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
		ircLDC_VAL_FIJOS_UNID_PRED in styLDC_VAL_FIJOS_UNID_PRED
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_VAL_FIJOS_UNID_PRED,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_VAL_FIJOS_UNID_PRED in styLDC_VAL_FIJOS_UNID_PRED,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_COTIZACION_DETALLADA');
			raise ex.controlled_error;
		end if;
		if ircLDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PROYECTO');
			raise ex.controlled_error;
		end if;
		if ircLDC_VAL_FIJOS_UNID_PRED.ID_ITEM is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_ITEM');
			raise ex.controlled_error;
		end if;
		if ircLDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|TIPO_TRAB');
			raise ex.controlled_error;
		end if;

		insert into LDC_VAL_FIJOS_UNID_PRED
		(
			TIPO_TRAB,
			ID_ITEM,
			ID_PROYECTO,
			DESCRIPCION,
			CANTIDAD,
			PRECIO,
			TOTAL_PRECIO,
			ID_COTIZACION_DETALLADA
		)
		values
		(
			ircLDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB,
			ircLDC_VAL_FIJOS_UNID_PRED.ID_ITEM,
			ircLDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO,
			ircLDC_VAL_FIJOS_UNID_PRED.DESCRIPCION,
			ircLDC_VAL_FIJOS_UNID_PRED.CANTIDAD,
			ircLDC_VAL_FIJOS_UNID_PRED.PRECIO,
			ircLDC_VAL_FIJOS_UNID_PRED.TOTAL_PRECIO,
			ircLDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_VAL_FIJOS_UNID_PRED));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_VAL_FIJOS_UNID_PRED in out nocopy tytbLDC_VAL_FIJOS_UNID_PRED
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_VAL_FIJOS_UNID_PRED,blUseRowID);
		forall n in iotbLDC_VAL_FIJOS_UNID_PRED.first..iotbLDC_VAL_FIJOS_UNID_PRED.last
			insert into LDC_VAL_FIJOS_UNID_PRED
			(
				TIPO_TRAB,
				ID_ITEM,
				ID_PROYECTO,
				DESCRIPCION,
				CANTIDAD,
				PRECIO,
				TOTAL_PRECIO,
				ID_COTIZACION_DETALLADA
			)
			values
			(
				rcRecOfTab.TIPO_TRAB(n),
				rcRecOfTab.ID_ITEM(n),
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.DESCRIPCION(n),
				rcRecOfTab.CANTIDAD(n),
				rcRecOfTab.PRECIO(n),
				rcRecOfTab.TOTAL_PRECIO(n),
				rcRecOfTab.ID_COTIZACION_DETALLADA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_ITEM,
				inuTIPO_TRAB,
				rcData
			);
		end if;


		delete
		from LDC_VAL_FIJOS_UNID_PRED
		where
       		ID_COTIZACION_DETALLADA=inuID_COTIZACION_DETALLADA and
       		ID_PROYECTO=inuID_PROYECTO and
       		ID_ITEM=inuID_ITEM and
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
		rcError  styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_VAL_FIJOS_UNID_PRED
		where
			rowid = iriRowID
		returning
			TIPO_TRAB,
			ID_ITEM,
			ID_PROYECTO,
			DESCRIPCION
		into
			rcError.TIPO_TRAB,
			rcError.ID_ITEM,
			rcError.ID_PROYECTO,
			rcError.DESCRIPCION;
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
		iotbLDC_VAL_FIJOS_UNID_PRED in out nocopy tytbLDC_VAL_FIJOS_UNID_PRED,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN
		FillRecordOfTables(iotbLDC_VAL_FIJOS_UNID_PRED, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_VAL_FIJOS_UNID_PRED.first .. iotbLDC_VAL_FIJOS_UNID_PRED.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VAL_FIJOS_UNID_PRED.first .. iotbLDC_VAL_FIJOS_UNID_PRED.last
				delete
				from LDC_VAL_FIJOS_UNID_PRED
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VAL_FIJOS_UNID_PRED.first .. iotbLDC_VAL_FIJOS_UNID_PRED.last loop
					LockByPk
					(
						rcRecOfTab.ID_COTIZACION_DETALLADA(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcRecOfTab.ID_ITEM(n),
						rcRecOfTab.TIPO_TRAB(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VAL_FIJOS_UNID_PRED.first .. iotbLDC_VAL_FIJOS_UNID_PRED.last
				delete
				from LDC_VAL_FIJOS_UNID_PRED
				where
		         	ID_COTIZACION_DETALLADA = rcRecOfTab.ID_COTIZACION_DETALLADA(n) and
		         	ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n) and
		         	ID_ITEM = rcRecOfTab.ID_ITEM(n) and
		         	TIPO_TRAB = rcRecOfTab.TIPO_TRAB(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_VAL_FIJOS_UNID_PRED in styLDC_VAL_FIJOS_UNID_PRED,
		inuLock in number default 0
	)
	IS
		nuID_COTIZACION_DETALLADA	LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type;
		nuID_PROYECTO	LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type;
		nuID_ITEM	LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type;
		nuTIPO_TRAB	LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type;
	BEGIN
		if ircLDC_VAL_FIJOS_UNID_PRED.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_VAL_FIJOS_UNID_PRED.rowid,rcData);
			end if;
			update LDC_VAL_FIJOS_UNID_PRED
			set
				DESCRIPCION = ircLDC_VAL_FIJOS_UNID_PRED.DESCRIPCION,
				CANTIDAD = ircLDC_VAL_FIJOS_UNID_PRED.CANTIDAD,
				PRECIO = ircLDC_VAL_FIJOS_UNID_PRED.PRECIO,
				TOTAL_PRECIO = ircLDC_VAL_FIJOS_UNID_PRED.TOTAL_PRECIO
			where
				rowid = ircLDC_VAL_FIJOS_UNID_PRED.rowid
			returning
				ID_COTIZACION_DETALLADA,
				ID_PROYECTO,
				ID_ITEM,
				TIPO_TRAB
			into
				nuID_COTIZACION_DETALLADA,
				nuID_PROYECTO,
				nuID_ITEM,
				nuTIPO_TRAB;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA,
					ircLDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO,
					ircLDC_VAL_FIJOS_UNID_PRED.ID_ITEM,
					ircLDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB,
					rcData
				);
			end if;

			update LDC_VAL_FIJOS_UNID_PRED
			set
				DESCRIPCION = ircLDC_VAL_FIJOS_UNID_PRED.DESCRIPCION,
				CANTIDAD = ircLDC_VAL_FIJOS_UNID_PRED.CANTIDAD,
				PRECIO = ircLDC_VAL_FIJOS_UNID_PRED.PRECIO,
				TOTAL_PRECIO = ircLDC_VAL_FIJOS_UNID_PRED.TOTAL_PRECIO
			where
				ID_COTIZACION_DETALLADA = ircLDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA and
				ID_PROYECTO = ircLDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO and
				ID_ITEM = ircLDC_VAL_FIJOS_UNID_PRED.ID_ITEM and
				TIPO_TRAB = ircLDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB
			returning
				ID_COTIZACION_DETALLADA,
				ID_PROYECTO,
				ID_ITEM,
				TIPO_TRAB
			into
				nuID_COTIZACION_DETALLADA,
				nuID_PROYECTO,
				nuID_ITEM,
				nuTIPO_TRAB;
		end if;
		if
			nuID_COTIZACION_DETALLADA is NULL OR
			nuID_PROYECTO is NULL OR
			nuID_ITEM is NULL OR
			nuTIPO_TRAB is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_VAL_FIJOS_UNID_PRED));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_VAL_FIJOS_UNID_PRED in out nocopy tytbLDC_VAL_FIJOS_UNID_PRED,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN
		FillRecordOfTables(iotbLDC_VAL_FIJOS_UNID_PRED,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_VAL_FIJOS_UNID_PRED.first .. iotbLDC_VAL_FIJOS_UNID_PRED.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VAL_FIJOS_UNID_PRED.first .. iotbLDC_VAL_FIJOS_UNID_PRED.last
				update LDC_VAL_FIJOS_UNID_PRED
				set
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n),
					CANTIDAD = rcRecOfTab.CANTIDAD(n),
					PRECIO = rcRecOfTab.PRECIO(n),
					TOTAL_PRECIO = rcRecOfTab.TOTAL_PRECIO(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VAL_FIJOS_UNID_PRED.first .. iotbLDC_VAL_FIJOS_UNID_PRED.last loop
					LockByPk
					(
						rcRecOfTab.ID_COTIZACION_DETALLADA(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcRecOfTab.ID_ITEM(n),
						rcRecOfTab.TIPO_TRAB(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VAL_FIJOS_UNID_PRED.first .. iotbLDC_VAL_FIJOS_UNID_PRED.last
				update LDC_VAL_FIJOS_UNID_PRED
				SET
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n),
					CANTIDAD = rcRecOfTab.CANTIDAD(n),
					PRECIO = rcRecOfTab.PRECIO(n),
					TOTAL_PRECIO = rcRecOfTab.TOTAL_PRECIO(n)
				where
					ID_COTIZACION_DETALLADA = rcRecOfTab.ID_COTIZACION_DETALLADA(n) and
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n) and
					ID_ITEM = rcRecOfTab.ID_ITEM(n) and
					TIPO_TRAB = rcRecOfTab.TIPO_TRAB(n)
;
		end if;
	END;
	PROCEDURE updDESCRIPCION
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		isbDESCRIPCION$ in LDC_VAL_FIJOS_UNID_PRED.DESCRIPCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_ITEM,
				inuTIPO_TRAB,
				rcData
			);
		end if;

		update LDC_VAL_FIJOS_UNID_PRED
		set
			DESCRIPCION = isbDESCRIPCION$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM = inuID_ITEM and
			TIPO_TRAB = inuTIPO_TRAB;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPCION:= isbDESCRIPCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCANTIDAD
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuCANTIDAD$ in LDC_VAL_FIJOS_UNID_PRED.CANTIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_ITEM,
				inuTIPO_TRAB,
				rcData
			);
		end if;

		update LDC_VAL_FIJOS_UNID_PRED
		set
			CANTIDAD = inuCANTIDAD$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM = inuID_ITEM and
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
	PROCEDURE updPRECIO
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuPRECIO$ in LDC_VAL_FIJOS_UNID_PRED.PRECIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_ITEM,
				inuTIPO_TRAB,
				rcData
			);
		end if;

		update LDC_VAL_FIJOS_UNID_PRED
		set
			PRECIO = inuPRECIO$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM = inuID_ITEM and
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
	PROCEDURE updTOTAL_PRECIO
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuTOTAL_PRECIO$ in LDC_VAL_FIJOS_UNID_PRED.TOTAL_PRECIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_ITEM,
				inuTIPO_TRAB,
				rcData
			);
		end if;

		update LDC_VAL_FIJOS_UNID_PRED
		set
			TOTAL_PRECIO = inuTOTAL_PRECIO$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM = inuID_ITEM and
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
	FUNCTION fnuGetTIPO_TRAB
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
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
	FUNCTION fnuGetID_ITEM
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
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
	FUNCTION fnuGetID_PROYECTO
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
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
	FUNCTION fsbGetDESCRIPCION
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VAL_FIJOS_UNID_PRED.DESCRIPCION%type
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		inuTIPO_TRAB
			 )
		then
			 return(rcData.DESCRIPCION);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
		 		inuTIPO_TRAB
		);
		return(rcData.DESCRIPCION);
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
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VAL_FIJOS_UNID_PRED.CANTIDAD%type
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
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
	FUNCTION fnuGetPRECIO
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VAL_FIJOS_UNID_PRED.PRECIO%type
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
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
	FUNCTION fnuGetTOTAL_PRECIO
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VAL_FIJOS_UNID_PRED.TOTAL_PRECIO%type
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
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
	FUNCTION fnuGetID_COTIZACION_DETALLADA
	(
		inuID_COTIZACION_DETALLADA in LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_VAL_FIJOS_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM in LDC_VAL_FIJOS_UNID_PRED.ID_ITEM%type,
		inuTIPO_TRAB in LDC_VAL_FIJOS_UNID_PRED.TIPO_TRAB%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VAL_FIJOS_UNID_PRED.ID_COTIZACION_DETALLADA%type
	IS
		rcError styLDC_VAL_FIJOS_UNID_PRED;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM := inuID_ITEM;
		rcError.TIPO_TRAB := inuTIPO_TRAB;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_ITEM,
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
	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALDC_VAL_FIJOS_UNID_PRED;
/
PROMPT Otorgando permisos de ejecucion a DALDC_VAL_FIJOS_UNID_PRED
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_VAL_FIJOS_UNID_PRED', 'ADM_PERSON');
END;
/