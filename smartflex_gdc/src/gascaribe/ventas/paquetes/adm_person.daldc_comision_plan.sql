CREATE OR REPLACE PACKAGE adm_person.daldc_comision_plan
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type
	)
	IS
		SELECT LDC_COMISION_PLAN.*,LDC_COMISION_PLAN.rowid
		FROM LDC_COMISION_PLAN
		WHERE
		    COMISION_PLAN_ID = inuCOMISION_PLAN_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_COMISION_PLAN.*,LDC_COMISION_PLAN.rowid
		FROM LDC_COMISION_PLAN
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_COMISION_PLAN  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_COMISION_PLAN is table of styLDC_COMISION_PLAN index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_COMISION_PLAN;

	/* Tipos referenciando al registro */
	type tytbCOMISION_PLAN_ID is table of LDC_COMISION_PLAN.COMISION_PLAN_ID%type index by binary_integer;
	type tytbTIPO_COMISION_ID is table of LDC_COMISION_PLAN.TIPO_COMISION_ID%type index by binary_integer;
	type tytbCOMMERCIAL_PLAN_ID is table of LDC_COMISION_PLAN.COMMERCIAL_PLAN_ID%type index by binary_integer;
	type tytbIS_ZONA is table of LDC_COMISION_PLAN.IS_ZONA%type index by binary_integer;
	type tytbMERECODI is table of LDC_COMISION_PLAN.MERECODI%type index by binary_integer;
	type tytbCATECODI is table of LDC_COMISION_PLAN.CATECODI%type index by binary_integer;
	type tytbSUCACODI is table of LDC_COMISION_PLAN.SUCACODI%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_COMISION_PLAN is record
	(
		COMISION_PLAN_ID   tytbCOMISION_PLAN_ID,
		TIPO_COMISION_ID   tytbTIPO_COMISION_ID,
		COMMERCIAL_PLAN_ID   tytbCOMMERCIAL_PLAN_ID,
		IS_ZONA   tytbIS_ZONA,
		MERECODI   tytbMERECODI,
		CATECODI   tytbCATECODI,
		SUCACODI   tytbSUCACODI,
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
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type
	);

	PROCEDURE getRecord
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		orcRecord out nocopy styLDC_COMISION_PLAN
	);

	FUNCTION frcGetRcData
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type
	)
	RETURN styLDC_COMISION_PLAN;

	FUNCTION frcGetRcData
	RETURN styLDC_COMISION_PLAN;

	FUNCTION frcGetRecord
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type
	)
	RETURN styLDC_COMISION_PLAN;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_COMISION_PLAN
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_COMISION_PLAN in styLDC_COMISION_PLAN
	);

	PROCEDURE insRecord
	(
		ircLDC_COMISION_PLAN in styLDC_COMISION_PLAN,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_COMISION_PLAN in out nocopy tytbLDC_COMISION_PLAN
	);

	PROCEDURE delRecord
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_COMISION_PLAN in out nocopy tytbLDC_COMISION_PLAN,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_COMISION_PLAN in styLDC_COMISION_PLAN,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_COMISION_PLAN in out nocopy tytbLDC_COMISION_PLAN,
		inuLock in number default 1
	);

	PROCEDURE updTIPO_COMISION_ID
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuTIPO_COMISION_ID$ in LDC_COMISION_PLAN.TIPO_COMISION_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updCOMMERCIAL_PLAN_ID
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuCOMMERCIAL_PLAN_ID$ in LDC_COMISION_PLAN.COMMERCIAL_PLAN_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updIS_ZONA
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		isbIS_ZONA$ in LDC_COMISION_PLAN.IS_ZONA%type,
		inuLock in number default 0
	);

	PROCEDURE updMERECODI
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuMERECODI$ in LDC_COMISION_PLAN.MERECODI%type,
		inuLock in number default 0
	);

	PROCEDURE updCATECODI
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuCATECODI$ in LDC_COMISION_PLAN.CATECODI%type,
		inuLock in number default 0
	);

	PROCEDURE updSUCACODI
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuSUCACODI$ in LDC_COMISION_PLAN.SUCACODI%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCOMISION_PLAN_ID
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMISION_PLAN.COMISION_PLAN_ID%type;

	FUNCTION fnuGetTIPO_COMISION_ID
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMISION_PLAN.TIPO_COMISION_ID%type;

	FUNCTION fnuGetCOMMERCIAL_PLAN_ID
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMISION_PLAN.COMMERCIAL_PLAN_ID%type;

	FUNCTION fsbGetIS_ZONA
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMISION_PLAN.IS_ZONA%type;

	FUNCTION fnuGetMERECODI
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMISION_PLAN.MERECODI%type;

	FUNCTION fnuGetCATECODI
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMISION_PLAN.CATECODI%type;

	FUNCTION fnuGetSUCACODI
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMISION_PLAN.SUCACODI%type;


	PROCEDURE LockByPk
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		orcLDC_COMISION_PLAN  out styLDC_COMISION_PLAN
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_COMISION_PLAN  out styLDC_COMISION_PLAN
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_COMISION_PLAN;
/
CREATE OR REPLACE PACKAGE BODY adm_person.daldc_comision_plan
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_COMISION_PLAN';
	 cnuGeEntityId constant varchar2(30) := 8147; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type
	)
	IS
		SELECT LDC_COMISION_PLAN.*,LDC_COMISION_PLAN.rowid
		FROM LDC_COMISION_PLAN
		WHERE  COMISION_PLAN_ID = inuCOMISION_PLAN_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_COMISION_PLAN.*,LDC_COMISION_PLAN.rowid
		FROM LDC_COMISION_PLAN
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_COMISION_PLAN is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_COMISION_PLAN;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_COMISION_PLAN default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.COMISION_PLAN_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		orcLDC_COMISION_PLAN  out styLDC_COMISION_PLAN
	)
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN
		rcError.COMISION_PLAN_ID := inuCOMISION_PLAN_ID;

		Open cuLockRcByPk
		(
			inuCOMISION_PLAN_ID
		);

		fetch cuLockRcByPk into orcLDC_COMISION_PLAN;
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
		orcLDC_COMISION_PLAN  out styLDC_COMISION_PLAN
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_COMISION_PLAN;
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
		itbLDC_COMISION_PLAN  in out nocopy tytbLDC_COMISION_PLAN
	)
	IS
	BEGIN
			rcRecOfTab.COMISION_PLAN_ID.delete;
			rcRecOfTab.TIPO_COMISION_ID.delete;
			rcRecOfTab.COMMERCIAL_PLAN_ID.delete;
			rcRecOfTab.IS_ZONA.delete;
			rcRecOfTab.MERECODI.delete;
			rcRecOfTab.CATECODI.delete;
			rcRecOfTab.SUCACODI.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_COMISION_PLAN  in out nocopy tytbLDC_COMISION_PLAN,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_COMISION_PLAN);

		for n in itbLDC_COMISION_PLAN.first .. itbLDC_COMISION_PLAN.last loop
			rcRecOfTab.COMISION_PLAN_ID(n) := itbLDC_COMISION_PLAN(n).COMISION_PLAN_ID;
			rcRecOfTab.TIPO_COMISION_ID(n) := itbLDC_COMISION_PLAN(n).TIPO_COMISION_ID;
			rcRecOfTab.COMMERCIAL_PLAN_ID(n) := itbLDC_COMISION_PLAN(n).COMMERCIAL_PLAN_ID;
			rcRecOfTab.IS_ZONA(n) := itbLDC_COMISION_PLAN(n).IS_ZONA;
			rcRecOfTab.MERECODI(n) := itbLDC_COMISION_PLAN(n).MERECODI;
			rcRecOfTab.CATECODI(n) := itbLDC_COMISION_PLAN(n).CATECODI;
			rcRecOfTab.SUCACODI(n) := itbLDC_COMISION_PLAN(n).SUCACODI;
			rcRecOfTab.row_id(n) := itbLDC_COMISION_PLAN(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCOMISION_PLAN_ID
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
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCOMISION_PLAN_ID = rcData.COMISION_PLAN_ID
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
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCOMISION_PLAN_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type
	)
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN		rcError.COMISION_PLAN_ID:=inuCOMISION_PLAN_ID;

		Load
		(
			inuCOMISION_PLAN_ID
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
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuCOMISION_PLAN_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		orcRecord out nocopy styLDC_COMISION_PLAN
	)
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN		rcError.COMISION_PLAN_ID:=inuCOMISION_PLAN_ID;

		Load
		(
			inuCOMISION_PLAN_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type
	)
	RETURN styLDC_COMISION_PLAN
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN
		rcError.COMISION_PLAN_ID:=inuCOMISION_PLAN_ID;

		Load
		(
			inuCOMISION_PLAN_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type
	)
	RETURN styLDC_COMISION_PLAN
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN
		rcError.COMISION_PLAN_ID:=inuCOMISION_PLAN_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCOMISION_PLAN_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCOMISION_PLAN_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_COMISION_PLAN
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_COMISION_PLAN
	)
	IS
		rfLDC_COMISION_PLAN tyrfLDC_COMISION_PLAN;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_COMISION_PLAN.*, LDC_COMISION_PLAN.rowid FROM LDC_COMISION_PLAN';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_COMISION_PLAN for sbFullQuery;

		fetch rfLDC_COMISION_PLAN bulk collect INTO otbResult;

		close rfLDC_COMISION_PLAN;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_COMISION_PLAN.*, LDC_COMISION_PLAN.rowid FROM LDC_COMISION_PLAN';
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
		ircLDC_COMISION_PLAN in styLDC_COMISION_PLAN
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_COMISION_PLAN,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_COMISION_PLAN in styLDC_COMISION_PLAN,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_COMISION_PLAN.COMISION_PLAN_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|COMISION_PLAN_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_COMISION_PLAN
		(
			COMISION_PLAN_ID,
			TIPO_COMISION_ID,
			COMMERCIAL_PLAN_ID,
			IS_ZONA,
			MERECODI,
			CATECODI,
			SUCACODI
		)
		values
		(
			ircLDC_COMISION_PLAN.COMISION_PLAN_ID,
			ircLDC_COMISION_PLAN.TIPO_COMISION_ID,
			ircLDC_COMISION_PLAN.COMMERCIAL_PLAN_ID,
			ircLDC_COMISION_PLAN.IS_ZONA,
			ircLDC_COMISION_PLAN.MERECODI,
			ircLDC_COMISION_PLAN.CATECODI,
			ircLDC_COMISION_PLAN.SUCACODI
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_COMISION_PLAN));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_COMISION_PLAN in out nocopy tytbLDC_COMISION_PLAN
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_COMISION_PLAN,blUseRowID);
		forall n in iotbLDC_COMISION_PLAN.first..iotbLDC_COMISION_PLAN.last
			insert into LDC_COMISION_PLAN
			(
				COMISION_PLAN_ID,
				TIPO_COMISION_ID,
				COMMERCIAL_PLAN_ID,
				IS_ZONA,
				MERECODI,
				CATECODI,
				SUCACODI
			)
			values
			(
				rcRecOfTab.COMISION_PLAN_ID(n),
				rcRecOfTab.TIPO_COMISION_ID(n),
				rcRecOfTab.COMMERCIAL_PLAN_ID(n),
				rcRecOfTab.IS_ZONA(n),
				rcRecOfTab.MERECODI(n),
				rcRecOfTab.CATECODI(n),
				rcRecOfTab.SUCACODI(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN
		rcError.COMISION_PLAN_ID := inuCOMISION_PLAN_ID;

		if inuLock=1 then
			LockByPk
			(
				inuCOMISION_PLAN_ID,
				rcData
			);
		end if;


		delete
		from LDC_COMISION_PLAN
		where
       		COMISION_PLAN_ID=inuCOMISION_PLAN_ID;
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
		rcError  styLDC_COMISION_PLAN;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_COMISION_PLAN
		where
			rowid = iriRowID
		returning
			COMISION_PLAN_ID
		into
			rcError.COMISION_PLAN_ID;
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
		iotbLDC_COMISION_PLAN in out nocopy tytbLDC_COMISION_PLAN,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_COMISION_PLAN;
	BEGIN
		FillRecordOfTables(iotbLDC_COMISION_PLAN, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_COMISION_PLAN.first .. iotbLDC_COMISION_PLAN.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COMISION_PLAN.first .. iotbLDC_COMISION_PLAN.last
				delete
				from LDC_COMISION_PLAN
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_COMISION_PLAN.first .. iotbLDC_COMISION_PLAN.last loop
					LockByPk
					(
						rcRecOfTab.COMISION_PLAN_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COMISION_PLAN.first .. iotbLDC_COMISION_PLAN.last
				delete
				from LDC_COMISION_PLAN
				where
		         	COMISION_PLAN_ID = rcRecOfTab.COMISION_PLAN_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_COMISION_PLAN in styLDC_COMISION_PLAN,
		inuLock in number default 0
	)
	IS
		nuCOMISION_PLAN_ID	LDC_COMISION_PLAN.COMISION_PLAN_ID%type;
	BEGIN
		if ircLDC_COMISION_PLAN.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_COMISION_PLAN.rowid,rcData);
			end if;
			update LDC_COMISION_PLAN
			set
				TIPO_COMISION_ID = ircLDC_COMISION_PLAN.TIPO_COMISION_ID,
				COMMERCIAL_PLAN_ID = ircLDC_COMISION_PLAN.COMMERCIAL_PLAN_ID,
				IS_ZONA = ircLDC_COMISION_PLAN.IS_ZONA,
				MERECODI = ircLDC_COMISION_PLAN.MERECODI,
				CATECODI = ircLDC_COMISION_PLAN.CATECODI,
				SUCACODI = ircLDC_COMISION_PLAN.SUCACODI
			where
				rowid = ircLDC_COMISION_PLAN.rowid
			returning
				COMISION_PLAN_ID
			into
				nuCOMISION_PLAN_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_COMISION_PLAN.COMISION_PLAN_ID,
					rcData
				);
			end if;

			update LDC_COMISION_PLAN
			set
				TIPO_COMISION_ID = ircLDC_COMISION_PLAN.TIPO_COMISION_ID,
				COMMERCIAL_PLAN_ID = ircLDC_COMISION_PLAN.COMMERCIAL_PLAN_ID,
				IS_ZONA = ircLDC_COMISION_PLAN.IS_ZONA,
				MERECODI = ircLDC_COMISION_PLAN.MERECODI,
				CATECODI = ircLDC_COMISION_PLAN.CATECODI,
				SUCACODI = ircLDC_COMISION_PLAN.SUCACODI
			where
				COMISION_PLAN_ID = ircLDC_COMISION_PLAN.COMISION_PLAN_ID
			returning
				COMISION_PLAN_ID
			into
				nuCOMISION_PLAN_ID;
		end if;
		if
			nuCOMISION_PLAN_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_COMISION_PLAN));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_COMISION_PLAN in out nocopy tytbLDC_COMISION_PLAN,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_COMISION_PLAN;
	BEGIN
		FillRecordOfTables(iotbLDC_COMISION_PLAN,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_COMISION_PLAN.first .. iotbLDC_COMISION_PLAN.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COMISION_PLAN.first .. iotbLDC_COMISION_PLAN.last
				update LDC_COMISION_PLAN
				set
					TIPO_COMISION_ID = rcRecOfTab.TIPO_COMISION_ID(n),
					COMMERCIAL_PLAN_ID = rcRecOfTab.COMMERCIAL_PLAN_ID(n),
					IS_ZONA = rcRecOfTab.IS_ZONA(n),
					MERECODI = rcRecOfTab.MERECODI(n),
					CATECODI = rcRecOfTab.CATECODI(n),
					SUCACODI = rcRecOfTab.SUCACODI(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_COMISION_PLAN.first .. iotbLDC_COMISION_PLAN.last loop
					LockByPk
					(
						rcRecOfTab.COMISION_PLAN_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COMISION_PLAN.first .. iotbLDC_COMISION_PLAN.last
				update LDC_COMISION_PLAN
				SET
					TIPO_COMISION_ID = rcRecOfTab.TIPO_COMISION_ID(n),
					COMMERCIAL_PLAN_ID = rcRecOfTab.COMMERCIAL_PLAN_ID(n),
					IS_ZONA = rcRecOfTab.IS_ZONA(n),
					MERECODI = rcRecOfTab.MERECODI(n),
					CATECODI = rcRecOfTab.CATECODI(n),
					SUCACODI = rcRecOfTab.SUCACODI(n)
				where
					COMISION_PLAN_ID = rcRecOfTab.COMISION_PLAN_ID(n)
;
		end if;
	END;
	PROCEDURE updTIPO_COMISION_ID
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuTIPO_COMISION_ID$ in LDC_COMISION_PLAN.TIPO_COMISION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN
		rcError.COMISION_PLAN_ID := inuCOMISION_PLAN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMISION_PLAN_ID,
				rcData
			);
		end if;

		update LDC_COMISION_PLAN
		set
			TIPO_COMISION_ID = inuTIPO_COMISION_ID$
		where
			COMISION_PLAN_ID = inuCOMISION_PLAN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPO_COMISION_ID:= inuTIPO_COMISION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOMMERCIAL_PLAN_ID
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuCOMMERCIAL_PLAN_ID$ in LDC_COMISION_PLAN.COMMERCIAL_PLAN_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN
		rcError.COMISION_PLAN_ID := inuCOMISION_PLAN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMISION_PLAN_ID,
				rcData
			);
		end if;

		update LDC_COMISION_PLAN
		set
			COMMERCIAL_PLAN_ID = inuCOMMERCIAL_PLAN_ID$
		where
			COMISION_PLAN_ID = inuCOMISION_PLAN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMMERCIAL_PLAN_ID:= inuCOMMERCIAL_PLAN_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIS_ZONA
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		isbIS_ZONA$ in LDC_COMISION_PLAN.IS_ZONA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN
		rcError.COMISION_PLAN_ID := inuCOMISION_PLAN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMISION_PLAN_ID,
				rcData
			);
		end if;

		update LDC_COMISION_PLAN
		set
			IS_ZONA = isbIS_ZONA$
		where
			COMISION_PLAN_ID = inuCOMISION_PLAN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IS_ZONA:= isbIS_ZONA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMERECODI
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuMERECODI$ in LDC_COMISION_PLAN.MERECODI%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN
		rcError.COMISION_PLAN_ID := inuCOMISION_PLAN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMISION_PLAN_ID,
				rcData
			);
		end if;

		update LDC_COMISION_PLAN
		set
			MERECODI = inuMERECODI$
		where
			COMISION_PLAN_ID = inuCOMISION_PLAN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MERECODI:= inuMERECODI$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCATECODI
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuCATECODI$ in LDC_COMISION_PLAN.CATECODI%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN
		rcError.COMISION_PLAN_ID := inuCOMISION_PLAN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMISION_PLAN_ID,
				rcData
			);
		end if;

		update LDC_COMISION_PLAN
		set
			CATECODI = inuCATECODI$
		where
			COMISION_PLAN_ID = inuCOMISION_PLAN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CATECODI:= inuCATECODI$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUCACODI
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuSUCACODI$ in LDC_COMISION_PLAN.SUCACODI%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN
		rcError.COMISION_PLAN_ID := inuCOMISION_PLAN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMISION_PLAN_ID,
				rcData
			);
		end if;

		update LDC_COMISION_PLAN
		set
			SUCACODI = inuSUCACODI$
		where
			COMISION_PLAN_ID = inuCOMISION_PLAN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUCACODI:= inuSUCACODI$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCOMISION_PLAN_ID
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMISION_PLAN.COMISION_PLAN_ID%type
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN

		rcError.COMISION_PLAN_ID := inuCOMISION_PLAN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMISION_PLAN_ID
			 )
		then
			 return(rcData.COMISION_PLAN_ID);
		end if;
		Load
		(
		 		inuCOMISION_PLAN_ID
		);
		return(rcData.COMISION_PLAN_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTIPO_COMISION_ID
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMISION_PLAN.TIPO_COMISION_ID%type
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN

		rcError.COMISION_PLAN_ID := inuCOMISION_PLAN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMISION_PLAN_ID
			 )
		then
			 return(rcData.TIPO_COMISION_ID);
		end if;
		Load
		(
		 		inuCOMISION_PLAN_ID
		);
		return(rcData.TIPO_COMISION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOMMERCIAL_PLAN_ID
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMISION_PLAN.COMMERCIAL_PLAN_ID%type
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN

		rcError.COMISION_PLAN_ID := inuCOMISION_PLAN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMISION_PLAN_ID
			 )
		then
			 return(rcData.COMMERCIAL_PLAN_ID);
		end if;
		Load
		(
		 		inuCOMISION_PLAN_ID
		);
		return(rcData.COMMERCIAL_PLAN_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIS_ZONA
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMISION_PLAN.IS_ZONA%type
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN

		rcError.COMISION_PLAN_ID := inuCOMISION_PLAN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMISION_PLAN_ID
			 )
		then
			 return(rcData.IS_ZONA);
		end if;
		Load
		(
		 		inuCOMISION_PLAN_ID
		);
		return(rcData.IS_ZONA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetMERECODI
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMISION_PLAN.MERECODI%type
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN

		rcError.COMISION_PLAN_ID := inuCOMISION_PLAN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMISION_PLAN_ID
			 )
		then
			 return(rcData.MERECODI);
		end if;
		Load
		(
		 		inuCOMISION_PLAN_ID
		);
		return(rcData.MERECODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCATECODI
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMISION_PLAN.CATECODI%type
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN

		rcError.COMISION_PLAN_ID := inuCOMISION_PLAN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMISION_PLAN_ID
			 )
		then
			 return(rcData.CATECODI);
		end if;
		Load
		(
		 		inuCOMISION_PLAN_ID
		);
		return(rcData.CATECODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUCACODI
	(
		inuCOMISION_PLAN_ID in LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMISION_PLAN.SUCACODI%type
	IS
		rcError styLDC_COMISION_PLAN;
	BEGIN

		rcError.COMISION_PLAN_ID := inuCOMISION_PLAN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMISION_PLAN_ID
			 )
		then
			 return(rcData.SUCACODI);
		end if;
		Load
		(
		 		inuCOMISION_PLAN_ID
		);
		return(rcData.SUCACODI);
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
end DALDC_COMISION_PLAN;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_COMISION_PLAN
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_COMISION_PLAN', 'ADM_PERSON'); 
END;
/
