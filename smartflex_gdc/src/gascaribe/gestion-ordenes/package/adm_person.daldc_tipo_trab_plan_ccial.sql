CREATE OR REPLACE PACKAGE adm_person.daldc_tipo_trab_plan_ccial
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type
	)
	IS
		SELECT LDC_TIPO_TRAB_PLAN_CCIAL.*,LDC_TIPO_TRAB_PLAN_CCIAL.rowid
		FROM LDC_TIPO_TRAB_PLAN_CCIAL
		WHERE
		    TT_PLAN_CCIAL_ID = inuTT_PLAN_CCIAL_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TIPO_TRAB_PLAN_CCIAL.*,LDC_TIPO_TRAB_PLAN_CCIAL.rowid
		FROM LDC_TIPO_TRAB_PLAN_CCIAL
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TIPO_TRAB_PLAN_CCIAL  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TIPO_TRAB_PLAN_CCIAL is table of styLDC_TIPO_TRAB_PLAN_CCIAL index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TIPO_TRAB_PLAN_CCIAL;

	/* Tipos referenciando al registro */
	type tytbTT_PLAN_CCIAL_ID is table of LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type index by binary_integer;
	type tytbTT_PLAN_CCIAL_PKG_ID is table of LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_PKG_ID%type index by binary_integer;
	type tytbTT_PLAN_CCIAL_PLAN_ID is table of LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_PLAN_ID%type index by binary_integer;
	type tytbTT_PLAN_CCIAL_CATEGORIA is table of LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_CATEGORIA%type index by binary_integer;
	type tytbTT_PLAN_CCIAL_ACTIVIDAD is table of LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ACTIVIDAD%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_TIPO_TRAB_PLAN_CCIAL is record
	(
		TT_PLAN_CCIAL_ID   tytbTT_PLAN_CCIAL_ID,
		TT_PLAN_CCIAL_PKG_ID   tytbTT_PLAN_CCIAL_PKG_ID,
		TT_PLAN_CCIAL_PLAN_ID   tytbTT_PLAN_CCIAL_PLAN_ID,
		TT_PLAN_CCIAL_CATEGORIA   tytbTT_PLAN_CCIAL_CATEGORIA,
		TT_PLAN_CCIAL_ACTIVIDAD   tytbTT_PLAN_CCIAL_ACTIVIDAD,
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
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type
	);

	PROCEDURE getRecord
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		orcRecord out nocopy styLDC_TIPO_TRAB_PLAN_CCIAL
	);

	FUNCTION frcGetRcData
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type
	)
	RETURN styLDC_TIPO_TRAB_PLAN_CCIAL;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPO_TRAB_PLAN_CCIAL;

	FUNCTION frcGetRecord
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type
	)
	RETURN styLDC_TIPO_TRAB_PLAN_CCIAL;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPO_TRAB_PLAN_CCIAL
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TIPO_TRAB_PLAN_CCIAL in styLDC_TIPO_TRAB_PLAN_CCIAL
	);

	PROCEDURE insRecord
	(
		ircLDC_TIPO_TRAB_PLAN_CCIAL in styLDC_TIPO_TRAB_PLAN_CCIAL,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TIPO_TRAB_PLAN_CCIAL in out nocopy tytbLDC_TIPO_TRAB_PLAN_CCIAL
	);

	PROCEDURE delRecord
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TIPO_TRAB_PLAN_CCIAL in out nocopy tytbLDC_TIPO_TRAB_PLAN_CCIAL,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_TIPO_TRAB_PLAN_CCIAL in styLDC_TIPO_TRAB_PLAN_CCIAL,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_TIPO_TRAB_PLAN_CCIAL in out nocopy tytbLDC_TIPO_TRAB_PLAN_CCIAL,
		inuLock in number default 1
	);

	PROCEDURE updTT_PLAN_CCIAL_PKG_ID
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuTT_PLAN_CCIAL_PKG_ID$ in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_PKG_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updTT_PLAN_CCIAL_PLAN_ID
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuTT_PLAN_CCIAL_PLAN_ID$ in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_PLAN_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updTT_PLAN_CCIAL_CATEGORIA
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuTT_PLAN_CCIAL_CATEGORIA$ in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_CATEGORIA%type,
		inuLock in number default 0
	);

	PROCEDURE updTT_PLAN_CCIAL_ACTIVIDAD
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuTT_PLAN_CCIAL_ACTIVIDAD$ in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ACTIVIDAD%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetTT_PLAN_CCIAL_ID
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type;

	FUNCTION fnuGetTT_PLAN_CCIAL_PKG_ID
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_PKG_ID%type;

	FUNCTION fnuGetTT_PLAN_CCIAL_PLAN_ID
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_PLAN_ID%type;

	FUNCTION fnuGetTT_PLAN_CCIAL_CATEGORIA
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_CATEGORIA%type;

	FUNCTION fnuGetTT_PLAN_CCIAL_ACTIVIDAD
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ACTIVIDAD%type;


	PROCEDURE LockByPk
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		orcLDC_TIPO_TRAB_PLAN_CCIAL  out styLDC_TIPO_TRAB_PLAN_CCIAL
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TIPO_TRAB_PLAN_CCIAL  out styLDC_TIPO_TRAB_PLAN_CCIAL
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TIPO_TRAB_PLAN_CCIAL;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_TIPO_TRAB_PLAN_CCIAL
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TIPO_TRAB_PLAN_CCIAL';
	 cnuGeEntityId constant varchar2(30) := 8693; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type
	)
	IS
		SELECT LDC_TIPO_TRAB_PLAN_CCIAL.*,LDC_TIPO_TRAB_PLAN_CCIAL.rowid
		FROM LDC_TIPO_TRAB_PLAN_CCIAL
		WHERE  TT_PLAN_CCIAL_ID = inuTT_PLAN_CCIAL_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TIPO_TRAB_PLAN_CCIAL.*,LDC_TIPO_TRAB_PLAN_CCIAL.rowid
		FROM LDC_TIPO_TRAB_PLAN_CCIAL
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TIPO_TRAB_PLAN_CCIAL is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TIPO_TRAB_PLAN_CCIAL;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_TIPO_TRAB_PLAN_CCIAL default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.TT_PLAN_CCIAL_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		orcLDC_TIPO_TRAB_PLAN_CCIAL  out styLDC_TIPO_TRAB_PLAN_CCIAL
	)
	IS
		rcError styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN
		rcError.TT_PLAN_CCIAL_ID := inuTT_PLAN_CCIAL_ID;

		Open cuLockRcByPk
		(
			inuTT_PLAN_CCIAL_ID
		);

		fetch cuLockRcByPk into orcLDC_TIPO_TRAB_PLAN_CCIAL;
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
		orcLDC_TIPO_TRAB_PLAN_CCIAL  out styLDC_TIPO_TRAB_PLAN_CCIAL
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TIPO_TRAB_PLAN_CCIAL;
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
		itbLDC_TIPO_TRAB_PLAN_CCIAL  in out nocopy tytbLDC_TIPO_TRAB_PLAN_CCIAL
	)
	IS
	BEGIN
			rcRecOfTab.TT_PLAN_CCIAL_ID.delete;
			rcRecOfTab.TT_PLAN_CCIAL_PKG_ID.delete;
			rcRecOfTab.TT_PLAN_CCIAL_PLAN_ID.delete;
			rcRecOfTab.TT_PLAN_CCIAL_CATEGORIA.delete;
			rcRecOfTab.TT_PLAN_CCIAL_ACTIVIDAD.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_TIPO_TRAB_PLAN_CCIAL  in out nocopy tytbLDC_TIPO_TRAB_PLAN_CCIAL,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TIPO_TRAB_PLAN_CCIAL);

		for n in itbLDC_TIPO_TRAB_PLAN_CCIAL.first .. itbLDC_TIPO_TRAB_PLAN_CCIAL.last loop
			rcRecOfTab.TT_PLAN_CCIAL_ID(n) := itbLDC_TIPO_TRAB_PLAN_CCIAL(n).TT_PLAN_CCIAL_ID;
			rcRecOfTab.TT_PLAN_CCIAL_PKG_ID(n) := itbLDC_TIPO_TRAB_PLAN_CCIAL(n).TT_PLAN_CCIAL_PKG_ID;
			rcRecOfTab.TT_PLAN_CCIAL_PLAN_ID(n) := itbLDC_TIPO_TRAB_PLAN_CCIAL(n).TT_PLAN_CCIAL_PLAN_ID;
			rcRecOfTab.TT_PLAN_CCIAL_CATEGORIA(n) := itbLDC_TIPO_TRAB_PLAN_CCIAL(n).TT_PLAN_CCIAL_CATEGORIA;
			rcRecOfTab.TT_PLAN_CCIAL_ACTIVIDAD(n) := itbLDC_TIPO_TRAB_PLAN_CCIAL(n).TT_PLAN_CCIAL_ACTIVIDAD;
			rcRecOfTab.row_id(n) := itbLDC_TIPO_TRAB_PLAN_CCIAL(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuTT_PLAN_CCIAL_ID
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
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuTT_PLAN_CCIAL_ID = rcData.TT_PLAN_CCIAL_ID
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
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuTT_PLAN_CCIAL_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type
	)
	IS
		rcError styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN		rcError.TT_PLAN_CCIAL_ID:=inuTT_PLAN_CCIAL_ID;

		Load
		(
			inuTT_PLAN_CCIAL_ID
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
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuTT_PLAN_CCIAL_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		orcRecord out nocopy styLDC_TIPO_TRAB_PLAN_CCIAL
	)
	IS
		rcError styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN		rcError.TT_PLAN_CCIAL_ID:=inuTT_PLAN_CCIAL_ID;

		Load
		(
			inuTT_PLAN_CCIAL_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type
	)
	RETURN styLDC_TIPO_TRAB_PLAN_CCIAL
	IS
		rcError styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN
		rcError.TT_PLAN_CCIAL_ID:=inuTT_PLAN_CCIAL_ID;

		Load
		(
			inuTT_PLAN_CCIAL_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type
	)
	RETURN styLDC_TIPO_TRAB_PLAN_CCIAL
	IS
		rcError styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN
		rcError.TT_PLAN_CCIAL_ID:=inuTT_PLAN_CCIAL_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuTT_PLAN_CCIAL_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuTT_PLAN_CCIAL_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPO_TRAB_PLAN_CCIAL
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPO_TRAB_PLAN_CCIAL
	)
	IS
		rfLDC_TIPO_TRAB_PLAN_CCIAL tyrfLDC_TIPO_TRAB_PLAN_CCIAL;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TIPO_TRAB_PLAN_CCIAL.*, LDC_TIPO_TRAB_PLAN_CCIAL.rowid FROM LDC_TIPO_TRAB_PLAN_CCIAL';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TIPO_TRAB_PLAN_CCIAL for sbFullQuery;

		fetch rfLDC_TIPO_TRAB_PLAN_CCIAL bulk collect INTO otbResult;

		close rfLDC_TIPO_TRAB_PLAN_CCIAL;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TIPO_TRAB_PLAN_CCIAL.*, LDC_TIPO_TRAB_PLAN_CCIAL.rowid FROM LDC_TIPO_TRAB_PLAN_CCIAL';
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
		ircLDC_TIPO_TRAB_PLAN_CCIAL in styLDC_TIPO_TRAB_PLAN_CCIAL
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TIPO_TRAB_PLAN_CCIAL,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_TIPO_TRAB_PLAN_CCIAL in styLDC_TIPO_TRAB_PLAN_CCIAL,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|TT_PLAN_CCIAL_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_TIPO_TRAB_PLAN_CCIAL
		(
			TT_PLAN_CCIAL_ID,
			TT_PLAN_CCIAL_PKG_ID,
			TT_PLAN_CCIAL_PLAN_ID,
			TT_PLAN_CCIAL_CATEGORIA,
			TT_PLAN_CCIAL_ACTIVIDAD
		)
		values
		(
			ircLDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID,
			ircLDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_PKG_ID,
			ircLDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_PLAN_ID,
			ircLDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_CATEGORIA,
			ircLDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ACTIVIDAD
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TIPO_TRAB_PLAN_CCIAL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_TIPO_TRAB_PLAN_CCIAL in out nocopy tytbLDC_TIPO_TRAB_PLAN_CCIAL
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPO_TRAB_PLAN_CCIAL,blUseRowID);
		forall n in iotbLDC_TIPO_TRAB_PLAN_CCIAL.first..iotbLDC_TIPO_TRAB_PLAN_CCIAL.last
			insert into LDC_TIPO_TRAB_PLAN_CCIAL
			(
				TT_PLAN_CCIAL_ID,
				TT_PLAN_CCIAL_PKG_ID,
				TT_PLAN_CCIAL_PLAN_ID,
				TT_PLAN_CCIAL_CATEGORIA,
				TT_PLAN_CCIAL_ACTIVIDAD
			)
			values
			(
				rcRecOfTab.TT_PLAN_CCIAL_ID(n),
				rcRecOfTab.TT_PLAN_CCIAL_PKG_ID(n),
				rcRecOfTab.TT_PLAN_CCIAL_PLAN_ID(n),
				rcRecOfTab.TT_PLAN_CCIAL_CATEGORIA(n),
				rcRecOfTab.TT_PLAN_CCIAL_ACTIVIDAD(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN
		rcError.TT_PLAN_CCIAL_ID := inuTT_PLAN_CCIAL_ID;

		if inuLock=1 then
			LockByPk
			(
				inuTT_PLAN_CCIAL_ID,
				rcData
			);
		end if;


		delete
		from LDC_TIPO_TRAB_PLAN_CCIAL
		where
       		TT_PLAN_CCIAL_ID=inuTT_PLAN_CCIAL_ID;
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
		rcError  styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TIPO_TRAB_PLAN_CCIAL
		where
			rowid = iriRowID
		returning
			TT_PLAN_CCIAL_ID
		into
			rcError.TT_PLAN_CCIAL_ID;
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
		iotbLDC_TIPO_TRAB_PLAN_CCIAL in out nocopy tytbLDC_TIPO_TRAB_PLAN_CCIAL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPO_TRAB_PLAN_CCIAL, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TIPO_TRAB_PLAN_CCIAL.first .. iotbLDC_TIPO_TRAB_PLAN_CCIAL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_TRAB_PLAN_CCIAL.first .. iotbLDC_TIPO_TRAB_PLAN_CCIAL.last
				delete
				from LDC_TIPO_TRAB_PLAN_CCIAL
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPO_TRAB_PLAN_CCIAL.first .. iotbLDC_TIPO_TRAB_PLAN_CCIAL.last loop
					LockByPk
					(
						rcRecOfTab.TT_PLAN_CCIAL_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_TRAB_PLAN_CCIAL.first .. iotbLDC_TIPO_TRAB_PLAN_CCIAL.last
				delete
				from LDC_TIPO_TRAB_PLAN_CCIAL
				where
		         	TT_PLAN_CCIAL_ID = rcRecOfTab.TT_PLAN_CCIAL_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_TIPO_TRAB_PLAN_CCIAL in styLDC_TIPO_TRAB_PLAN_CCIAL,
		inuLock in number default 0
	)
	IS
		nuTT_PLAN_CCIAL_ID	LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type;
	BEGIN
		if ircLDC_TIPO_TRAB_PLAN_CCIAL.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_TIPO_TRAB_PLAN_CCIAL.rowid,rcData);
			end if;
			update LDC_TIPO_TRAB_PLAN_CCIAL
			set
				TT_PLAN_CCIAL_PKG_ID = ircLDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_PKG_ID,
				TT_PLAN_CCIAL_PLAN_ID = ircLDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_PLAN_ID,
				TT_PLAN_CCIAL_CATEGORIA = ircLDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_CATEGORIA,
				TT_PLAN_CCIAL_ACTIVIDAD = ircLDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ACTIVIDAD
			where
				rowid = ircLDC_TIPO_TRAB_PLAN_CCIAL.rowid
			returning
				TT_PLAN_CCIAL_ID
			into
				nuTT_PLAN_CCIAL_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID,
					rcData
				);
			end if;

			update LDC_TIPO_TRAB_PLAN_CCIAL
			set
				TT_PLAN_CCIAL_PKG_ID = ircLDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_PKG_ID,
				TT_PLAN_CCIAL_PLAN_ID = ircLDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_PLAN_ID,
				TT_PLAN_CCIAL_CATEGORIA = ircLDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_CATEGORIA,
				TT_PLAN_CCIAL_ACTIVIDAD = ircLDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ACTIVIDAD
			where
				TT_PLAN_CCIAL_ID = ircLDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID
			returning
				TT_PLAN_CCIAL_ID
			into
				nuTT_PLAN_CCIAL_ID;
		end if;
		if
			nuTT_PLAN_CCIAL_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_TIPO_TRAB_PLAN_CCIAL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_TIPO_TRAB_PLAN_CCIAL in out nocopy tytbLDC_TIPO_TRAB_PLAN_CCIAL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPO_TRAB_PLAN_CCIAL,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_TIPO_TRAB_PLAN_CCIAL.first .. iotbLDC_TIPO_TRAB_PLAN_CCIAL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_TRAB_PLAN_CCIAL.first .. iotbLDC_TIPO_TRAB_PLAN_CCIAL.last
				update LDC_TIPO_TRAB_PLAN_CCIAL
				set
					TT_PLAN_CCIAL_PKG_ID = rcRecOfTab.TT_PLAN_CCIAL_PKG_ID(n),
					TT_PLAN_CCIAL_PLAN_ID = rcRecOfTab.TT_PLAN_CCIAL_PLAN_ID(n),
					TT_PLAN_CCIAL_CATEGORIA = rcRecOfTab.TT_PLAN_CCIAL_CATEGORIA(n),
					TT_PLAN_CCIAL_ACTIVIDAD = rcRecOfTab.TT_PLAN_CCIAL_ACTIVIDAD(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPO_TRAB_PLAN_CCIAL.first .. iotbLDC_TIPO_TRAB_PLAN_CCIAL.last loop
					LockByPk
					(
						rcRecOfTab.TT_PLAN_CCIAL_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_TRAB_PLAN_CCIAL.first .. iotbLDC_TIPO_TRAB_PLAN_CCIAL.last
				update LDC_TIPO_TRAB_PLAN_CCIAL
				SET
					TT_PLAN_CCIAL_PKG_ID = rcRecOfTab.TT_PLAN_CCIAL_PKG_ID(n),
					TT_PLAN_CCIAL_PLAN_ID = rcRecOfTab.TT_PLAN_CCIAL_PLAN_ID(n),
					TT_PLAN_CCIAL_CATEGORIA = rcRecOfTab.TT_PLAN_CCIAL_CATEGORIA(n),
					TT_PLAN_CCIAL_ACTIVIDAD = rcRecOfTab.TT_PLAN_CCIAL_ACTIVIDAD(n)
				where
					TT_PLAN_CCIAL_ID = rcRecOfTab.TT_PLAN_CCIAL_ID(n)
;
		end if;
	END;
	PROCEDURE updTT_PLAN_CCIAL_PKG_ID
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuTT_PLAN_CCIAL_PKG_ID$ in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_PKG_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN
		rcError.TT_PLAN_CCIAL_ID := inuTT_PLAN_CCIAL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuTT_PLAN_CCIAL_ID,
				rcData
			);
		end if;

		update LDC_TIPO_TRAB_PLAN_CCIAL
		set
			TT_PLAN_CCIAL_PKG_ID = inuTT_PLAN_CCIAL_PKG_ID$
		where
			TT_PLAN_CCIAL_ID = inuTT_PLAN_CCIAL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TT_PLAN_CCIAL_PKG_ID:= inuTT_PLAN_CCIAL_PKG_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTT_PLAN_CCIAL_PLAN_ID
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuTT_PLAN_CCIAL_PLAN_ID$ in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_PLAN_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN
		rcError.TT_PLAN_CCIAL_ID := inuTT_PLAN_CCIAL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuTT_PLAN_CCIAL_ID,
				rcData
			);
		end if;

		update LDC_TIPO_TRAB_PLAN_CCIAL
		set
			TT_PLAN_CCIAL_PLAN_ID = inuTT_PLAN_CCIAL_PLAN_ID$
		where
			TT_PLAN_CCIAL_ID = inuTT_PLAN_CCIAL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TT_PLAN_CCIAL_PLAN_ID:= inuTT_PLAN_CCIAL_PLAN_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTT_PLAN_CCIAL_CATEGORIA
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuTT_PLAN_CCIAL_CATEGORIA$ in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_CATEGORIA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN
		rcError.TT_PLAN_CCIAL_ID := inuTT_PLAN_CCIAL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuTT_PLAN_CCIAL_ID,
				rcData
			);
		end if;

		update LDC_TIPO_TRAB_PLAN_CCIAL
		set
			TT_PLAN_CCIAL_CATEGORIA = inuTT_PLAN_CCIAL_CATEGORIA$
		where
			TT_PLAN_CCIAL_ID = inuTT_PLAN_CCIAL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TT_PLAN_CCIAL_CATEGORIA:= inuTT_PLAN_CCIAL_CATEGORIA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTT_PLAN_CCIAL_ACTIVIDAD
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuTT_PLAN_CCIAL_ACTIVIDAD$ in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ACTIVIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN
		rcError.TT_PLAN_CCIAL_ID := inuTT_PLAN_CCIAL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuTT_PLAN_CCIAL_ID,
				rcData
			);
		end if;

		update LDC_TIPO_TRAB_PLAN_CCIAL
		set
			TT_PLAN_CCIAL_ACTIVIDAD = inuTT_PLAN_CCIAL_ACTIVIDAD$
		where
			TT_PLAN_CCIAL_ID = inuTT_PLAN_CCIAL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TT_PLAN_CCIAL_ACTIVIDAD:= inuTT_PLAN_CCIAL_ACTIVIDAD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetTT_PLAN_CCIAL_ID
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type
	IS
		rcError styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN

		rcError.TT_PLAN_CCIAL_ID := inuTT_PLAN_CCIAL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTT_PLAN_CCIAL_ID
			 )
		then
			 return(rcData.TT_PLAN_CCIAL_ID);
		end if;
		Load
		(
		 		inuTT_PLAN_CCIAL_ID
		);
		return(rcData.TT_PLAN_CCIAL_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTT_PLAN_CCIAL_PKG_ID
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_PKG_ID%type
	IS
		rcError styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN

		rcError.TT_PLAN_CCIAL_ID := inuTT_PLAN_CCIAL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTT_PLAN_CCIAL_ID
			 )
		then
			 return(rcData.TT_PLAN_CCIAL_PKG_ID);
		end if;
		Load
		(
		 		inuTT_PLAN_CCIAL_ID
		);
		return(rcData.TT_PLAN_CCIAL_PKG_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTT_PLAN_CCIAL_PLAN_ID
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_PLAN_ID%type
	IS
		rcError styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN

		rcError.TT_PLAN_CCIAL_ID := inuTT_PLAN_CCIAL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTT_PLAN_CCIAL_ID
			 )
		then
			 return(rcData.TT_PLAN_CCIAL_PLAN_ID);
		end if;
		Load
		(
		 		inuTT_PLAN_CCIAL_ID
		);
		return(rcData.TT_PLAN_CCIAL_PLAN_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTT_PLAN_CCIAL_CATEGORIA
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_CATEGORIA%type
	IS
		rcError styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN

		rcError.TT_PLAN_CCIAL_ID := inuTT_PLAN_CCIAL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTT_PLAN_CCIAL_ID
			 )
		then
			 return(rcData.TT_PLAN_CCIAL_CATEGORIA);
		end if;
		Load
		(
		 		inuTT_PLAN_CCIAL_ID
		);
		return(rcData.TT_PLAN_CCIAL_CATEGORIA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTT_PLAN_CCIAL_ACTIVIDAD
	(
		inuTT_PLAN_CCIAL_ID in LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_TRAB_PLAN_CCIAL.TT_PLAN_CCIAL_ACTIVIDAD%type
	IS
		rcError styLDC_TIPO_TRAB_PLAN_CCIAL;
	BEGIN

		rcError.TT_PLAN_CCIAL_ID := inuTT_PLAN_CCIAL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTT_PLAN_CCIAL_ID
			 )
		then
			 return(rcData.TT_PLAN_CCIAL_ACTIVIDAD);
		end if;
		Load
		(
		 		inuTT_PLAN_CCIAL_ID
		);
		return(rcData.TT_PLAN_CCIAL_ACTIVIDAD);
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
end DALDC_TIPO_TRAB_PLAN_CCIAL;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_TIPO_TRAB_PLAN_CCIAL
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_TIPO_TRAB_PLAN_CCIAL', 'ADM_PERSON'); 
END;
/ 
