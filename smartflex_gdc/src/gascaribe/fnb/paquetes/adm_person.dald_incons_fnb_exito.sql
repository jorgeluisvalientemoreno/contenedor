CREATE OR REPLACE PACKAGE adm_person.dald_incons_fnb_exito
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  04/06/2024   Adrianavg   OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type
	)
	IS
		SELECT LD_INCONS_FNB_EXITO.*,LD_INCONS_FNB_EXITO.rowid
		FROM LD_INCONS_FNB_EXITO
		WHERE
		    INCONS_FNB_EXITO_ID = inuINCONS_FNB_EXITO_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_INCONS_FNB_EXITO.*,LD_INCONS_FNB_EXITO.rowid
		FROM LD_INCONS_FNB_EXITO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_INCONS_FNB_EXITO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_INCONS_FNB_EXITO is table of styLD_INCONS_FNB_EXITO index by binary_integer;
	type tyrfRecords is ref cursor return styLD_INCONS_FNB_EXITO;

	/* Tipos referenciando al registro */
	type tytbINCONS_FNB_EXITO_ID is table of LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type index by binary_integer;
	type tytbFILE_NAME is table of LD_INCONS_FNB_EXITO.FILE_NAME%type index by binary_integer;
	type tytbFILE_DATE is table of LD_INCONS_FNB_EXITO.FILE_DATE%type index by binary_integer;
	type tytbSALE_ID is table of LD_INCONS_FNB_EXITO.SALE_ID%type index by binary_integer;
	type tytbDESCRIPTION is table of LD_INCONS_FNB_EXITO.DESCRIPTION%type index by binary_integer;
	type tytbSTATE is table of LD_INCONS_FNB_EXITO.STATE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_INCONS_FNB_EXITO is record
	(
		INCONS_FNB_EXITO_ID   tytbINCONS_FNB_EXITO_ID,
		FILE_NAME   tytbFILE_NAME,
		FILE_DATE   tytbFILE_DATE,
		SALE_ID   tytbSALE_ID,
		DESCRIPTION   tytbDESCRIPTION,
		STATE   tytbSTATE,
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
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type
	);

	PROCEDURE getRecord
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		orcRecord out nocopy styLD_INCONS_FNB_EXITO
	);

	FUNCTION frcGetRcData
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type
	)
	RETURN styLD_INCONS_FNB_EXITO;

	FUNCTION frcGetRcData
	RETURN styLD_INCONS_FNB_EXITO;

	FUNCTION frcGetRecord
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type
	)
	RETURN styLD_INCONS_FNB_EXITO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_INCONS_FNB_EXITO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_INCONS_FNB_EXITO in styLD_INCONS_FNB_EXITO
	);

	PROCEDURE insRecord
	(
		ircLD_INCONS_FNB_EXITO in styLD_INCONS_FNB_EXITO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_INCONS_FNB_EXITO in out nocopy tytbLD_INCONS_FNB_EXITO
	);

	PROCEDURE delRecord
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_INCONS_FNB_EXITO in out nocopy tytbLD_INCONS_FNB_EXITO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_INCONS_FNB_EXITO in styLD_INCONS_FNB_EXITO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_INCONS_FNB_EXITO in out nocopy tytbLD_INCONS_FNB_EXITO,
		inuLock in number default 1
	);

	PROCEDURE updFILE_NAME
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		isbFILE_NAME$ in LD_INCONS_FNB_EXITO.FILE_NAME%type,
		inuLock in number default 0
	);

	PROCEDURE updFILE_DATE
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		idtFILE_DATE$ in LD_INCONS_FNB_EXITO.FILE_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updSALE_ID
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		inuSALE_ID$ in LD_INCONS_FNB_EXITO.SALE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updDESCRIPTION
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		isbDESCRIPTION$ in LD_INCONS_FNB_EXITO.DESCRIPTION%type,
		inuLock in number default 0
	);

	PROCEDURE updSTATE
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		isbSTATE$ in LD_INCONS_FNB_EXITO.STATE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetINCONS_FNB_EXITO_ID
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type;

	FUNCTION fsbGetFILE_NAME
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_INCONS_FNB_EXITO.FILE_NAME%type;

	FUNCTION fdtGetFILE_DATE
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_INCONS_FNB_EXITO.FILE_DATE%type;

	FUNCTION fnuGetSALE_ID
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_INCONS_FNB_EXITO.SALE_ID%type;

	FUNCTION fsbGetDESCRIPTION
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_INCONS_FNB_EXITO.DESCRIPTION%type;

	FUNCTION fsbGetSTATE
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_INCONS_FNB_EXITO.STATE%type;


	PROCEDURE LockByPk
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		orcLD_INCONS_FNB_EXITO  out styLD_INCONS_FNB_EXITO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_INCONS_FNB_EXITO  out styLD_INCONS_FNB_EXITO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_INCONS_FNB_EXITO;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_INCONS_FNB_EXITO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO213685';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_INCONS_FNB_EXITO';
	 cnuGeEntityId constant varchar2(30) := 8464; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type
	)
	IS
		SELECT LD_INCONS_FNB_EXITO.*,LD_INCONS_FNB_EXITO.rowid
		FROM LD_INCONS_FNB_EXITO
		WHERE  INCONS_FNB_EXITO_ID = inuINCONS_FNB_EXITO_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_INCONS_FNB_EXITO.*,LD_INCONS_FNB_EXITO.rowid
		FROM LD_INCONS_FNB_EXITO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_INCONS_FNB_EXITO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_INCONS_FNB_EXITO;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_INCONS_FNB_EXITO default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.INCONS_FNB_EXITO_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		orcLD_INCONS_FNB_EXITO  out styLD_INCONS_FNB_EXITO
	)
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN
		rcError.INCONS_FNB_EXITO_ID := inuINCONS_FNB_EXITO_ID;

		Open cuLockRcByPk
		(
			inuINCONS_FNB_EXITO_ID
		);

		fetch cuLockRcByPk into orcLD_INCONS_FNB_EXITO;
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
		orcLD_INCONS_FNB_EXITO  out styLD_INCONS_FNB_EXITO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_INCONS_FNB_EXITO;
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
		itbLD_INCONS_FNB_EXITO  in out nocopy tytbLD_INCONS_FNB_EXITO
	)
	IS
	BEGIN
			rcRecOfTab.INCONS_FNB_EXITO_ID.delete;
			rcRecOfTab.FILE_NAME.delete;
			rcRecOfTab.FILE_DATE.delete;
			rcRecOfTab.SALE_ID.delete;
			rcRecOfTab.DESCRIPTION.delete;
			rcRecOfTab.STATE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_INCONS_FNB_EXITO  in out nocopy tytbLD_INCONS_FNB_EXITO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_INCONS_FNB_EXITO);

		for n in itbLD_INCONS_FNB_EXITO.first .. itbLD_INCONS_FNB_EXITO.last loop
			rcRecOfTab.INCONS_FNB_EXITO_ID(n) := itbLD_INCONS_FNB_EXITO(n).INCONS_FNB_EXITO_ID;
			rcRecOfTab.FILE_NAME(n) := itbLD_INCONS_FNB_EXITO(n).FILE_NAME;
			rcRecOfTab.FILE_DATE(n) := itbLD_INCONS_FNB_EXITO(n).FILE_DATE;
			rcRecOfTab.SALE_ID(n) := itbLD_INCONS_FNB_EXITO(n).SALE_ID;
			rcRecOfTab.DESCRIPTION(n) := itbLD_INCONS_FNB_EXITO(n).DESCRIPTION;
			rcRecOfTab.STATE(n) := itbLD_INCONS_FNB_EXITO(n).STATE;
			rcRecOfTab.row_id(n) := itbLD_INCONS_FNB_EXITO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuINCONS_FNB_EXITO_ID
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
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuINCONS_FNB_EXITO_ID = rcData.INCONS_FNB_EXITO_ID
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
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuINCONS_FNB_EXITO_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type
	)
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN		rcError.INCONS_FNB_EXITO_ID:=inuINCONS_FNB_EXITO_ID;

		Load
		(
			inuINCONS_FNB_EXITO_ID
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
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuINCONS_FNB_EXITO_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		orcRecord out nocopy styLD_INCONS_FNB_EXITO
	)
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN		rcError.INCONS_FNB_EXITO_ID:=inuINCONS_FNB_EXITO_ID;

		Load
		(
			inuINCONS_FNB_EXITO_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type
	)
	RETURN styLD_INCONS_FNB_EXITO
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN
		rcError.INCONS_FNB_EXITO_ID:=inuINCONS_FNB_EXITO_ID;

		Load
		(
			inuINCONS_FNB_EXITO_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type
	)
	RETURN styLD_INCONS_FNB_EXITO
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN
		rcError.INCONS_FNB_EXITO_ID:=inuINCONS_FNB_EXITO_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuINCONS_FNB_EXITO_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuINCONS_FNB_EXITO_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_INCONS_FNB_EXITO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_INCONS_FNB_EXITO
	)
	IS
		rfLD_INCONS_FNB_EXITO tyrfLD_INCONS_FNB_EXITO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_INCONS_FNB_EXITO.*, LD_INCONS_FNB_EXITO.rowid FROM LD_INCONS_FNB_EXITO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_INCONS_FNB_EXITO for sbFullQuery;

		fetch rfLD_INCONS_FNB_EXITO bulk collect INTO otbResult;

		close rfLD_INCONS_FNB_EXITO;
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
		sbSQL VARCHAR2 (32000) := 'select LD_INCONS_FNB_EXITO.*, LD_INCONS_FNB_EXITO.rowid FROM LD_INCONS_FNB_EXITO';
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
		ircLD_INCONS_FNB_EXITO in styLD_INCONS_FNB_EXITO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_INCONS_FNB_EXITO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_INCONS_FNB_EXITO in styLD_INCONS_FNB_EXITO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|INCONS_FNB_EXITO_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_INCONS_FNB_EXITO
		(
			INCONS_FNB_EXITO_ID,
			FILE_NAME,
			FILE_DATE,
			SALE_ID,
			DESCRIPTION,
			STATE
		)
		values
		(
			ircLD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID,
			ircLD_INCONS_FNB_EXITO.FILE_NAME,
			ircLD_INCONS_FNB_EXITO.FILE_DATE,
			ircLD_INCONS_FNB_EXITO.SALE_ID,
			ircLD_INCONS_FNB_EXITO.DESCRIPTION,
			ircLD_INCONS_FNB_EXITO.STATE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_INCONS_FNB_EXITO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_INCONS_FNB_EXITO in out nocopy tytbLD_INCONS_FNB_EXITO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_INCONS_FNB_EXITO,blUseRowID);
		forall n in iotbLD_INCONS_FNB_EXITO.first..iotbLD_INCONS_FNB_EXITO.last
			insert into LD_INCONS_FNB_EXITO
			(
				INCONS_FNB_EXITO_ID,
				FILE_NAME,
				FILE_DATE,
				SALE_ID,
				DESCRIPTION,
				STATE
			)
			values
			(
				rcRecOfTab.INCONS_FNB_EXITO_ID(n),
				rcRecOfTab.FILE_NAME(n),
				rcRecOfTab.FILE_DATE(n),
				rcRecOfTab.SALE_ID(n),
				rcRecOfTab.DESCRIPTION(n),
				rcRecOfTab.STATE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN
		rcError.INCONS_FNB_EXITO_ID := inuINCONS_FNB_EXITO_ID;

		if inuLock=1 then
			LockByPk
			(
				inuINCONS_FNB_EXITO_ID,
				rcData
			);
		end if;


		delete
		from LD_INCONS_FNB_EXITO
		where
       		INCONS_FNB_EXITO_ID=inuINCONS_FNB_EXITO_ID;
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
		rcError  styLD_INCONS_FNB_EXITO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_INCONS_FNB_EXITO
		where
			rowid = iriRowID
		returning
			INCONS_FNB_EXITO_ID
		into
			rcError.INCONS_FNB_EXITO_ID;
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
		iotbLD_INCONS_FNB_EXITO in out nocopy tytbLD_INCONS_FNB_EXITO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_INCONS_FNB_EXITO;
	BEGIN
		FillRecordOfTables(iotbLD_INCONS_FNB_EXITO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_INCONS_FNB_EXITO.first .. iotbLD_INCONS_FNB_EXITO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_INCONS_FNB_EXITO.first .. iotbLD_INCONS_FNB_EXITO.last
				delete
				from LD_INCONS_FNB_EXITO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_INCONS_FNB_EXITO.first .. iotbLD_INCONS_FNB_EXITO.last loop
					LockByPk
					(
						rcRecOfTab.INCONS_FNB_EXITO_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_INCONS_FNB_EXITO.first .. iotbLD_INCONS_FNB_EXITO.last
				delete
				from LD_INCONS_FNB_EXITO
				where
		         	INCONS_FNB_EXITO_ID = rcRecOfTab.INCONS_FNB_EXITO_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_INCONS_FNB_EXITO in styLD_INCONS_FNB_EXITO,
		inuLock in number default 0
	)
	IS
		nuINCONS_FNB_EXITO_ID	LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type;
	BEGIN
		if ircLD_INCONS_FNB_EXITO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_INCONS_FNB_EXITO.rowid,rcData);
			end if;
			update LD_INCONS_FNB_EXITO
			set
				FILE_NAME = ircLD_INCONS_FNB_EXITO.FILE_NAME,
				FILE_DATE = ircLD_INCONS_FNB_EXITO.FILE_DATE,
				SALE_ID = ircLD_INCONS_FNB_EXITO.SALE_ID,
				DESCRIPTION = ircLD_INCONS_FNB_EXITO.DESCRIPTION,
				STATE = ircLD_INCONS_FNB_EXITO.STATE
			where
				rowid = ircLD_INCONS_FNB_EXITO.rowid
			returning
				INCONS_FNB_EXITO_ID
			into
				nuINCONS_FNB_EXITO_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID,
					rcData
				);
			end if;

			update LD_INCONS_FNB_EXITO
			set
				FILE_NAME = ircLD_INCONS_FNB_EXITO.FILE_NAME,
				FILE_DATE = ircLD_INCONS_FNB_EXITO.FILE_DATE,
				SALE_ID = ircLD_INCONS_FNB_EXITO.SALE_ID,
				DESCRIPTION = ircLD_INCONS_FNB_EXITO.DESCRIPTION,
				STATE = ircLD_INCONS_FNB_EXITO.STATE
			where
				INCONS_FNB_EXITO_ID = ircLD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID
			returning
				INCONS_FNB_EXITO_ID
			into
				nuINCONS_FNB_EXITO_ID;
		end if;
		if
			nuINCONS_FNB_EXITO_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_INCONS_FNB_EXITO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_INCONS_FNB_EXITO in out nocopy tytbLD_INCONS_FNB_EXITO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_INCONS_FNB_EXITO;
	BEGIN
		FillRecordOfTables(iotbLD_INCONS_FNB_EXITO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_INCONS_FNB_EXITO.first .. iotbLD_INCONS_FNB_EXITO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_INCONS_FNB_EXITO.first .. iotbLD_INCONS_FNB_EXITO.last
				update LD_INCONS_FNB_EXITO
				set
					FILE_NAME = rcRecOfTab.FILE_NAME(n),
					FILE_DATE = rcRecOfTab.FILE_DATE(n),
					SALE_ID = rcRecOfTab.SALE_ID(n),
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n),
					STATE = rcRecOfTab.STATE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_INCONS_FNB_EXITO.first .. iotbLD_INCONS_FNB_EXITO.last loop
					LockByPk
					(
						rcRecOfTab.INCONS_FNB_EXITO_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_INCONS_FNB_EXITO.first .. iotbLD_INCONS_FNB_EXITO.last
				update LD_INCONS_FNB_EXITO
				SET
					FILE_NAME = rcRecOfTab.FILE_NAME(n),
					FILE_DATE = rcRecOfTab.FILE_DATE(n),
					SALE_ID = rcRecOfTab.SALE_ID(n),
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n),
					STATE = rcRecOfTab.STATE(n)
				where
					INCONS_FNB_EXITO_ID = rcRecOfTab.INCONS_FNB_EXITO_ID(n)
;
		end if;
	END;
	PROCEDURE updFILE_NAME
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		isbFILE_NAME$ in LD_INCONS_FNB_EXITO.FILE_NAME%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN
		rcError.INCONS_FNB_EXITO_ID := inuINCONS_FNB_EXITO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuINCONS_FNB_EXITO_ID,
				rcData
			);
		end if;

		update LD_INCONS_FNB_EXITO
		set
			FILE_NAME = isbFILE_NAME$
		where
			INCONS_FNB_EXITO_ID = inuINCONS_FNB_EXITO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FILE_NAME:= isbFILE_NAME$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFILE_DATE
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		idtFILE_DATE$ in LD_INCONS_FNB_EXITO.FILE_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN
		rcError.INCONS_FNB_EXITO_ID := inuINCONS_FNB_EXITO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuINCONS_FNB_EXITO_ID,
				rcData
			);
		end if;

		update LD_INCONS_FNB_EXITO
		set
			FILE_DATE = idtFILE_DATE$
		where
			INCONS_FNB_EXITO_ID = inuINCONS_FNB_EXITO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FILE_DATE:= idtFILE_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSALE_ID
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		inuSALE_ID$ in LD_INCONS_FNB_EXITO.SALE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN
		rcError.INCONS_FNB_EXITO_ID := inuINCONS_FNB_EXITO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuINCONS_FNB_EXITO_ID,
				rcData
			);
		end if;

		update LD_INCONS_FNB_EXITO
		set
			SALE_ID = inuSALE_ID$
		where
			INCONS_FNB_EXITO_ID = inuINCONS_FNB_EXITO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SALE_ID:= inuSALE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESCRIPTION
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		isbDESCRIPTION$ in LD_INCONS_FNB_EXITO.DESCRIPTION%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN
		rcError.INCONS_FNB_EXITO_ID := inuINCONS_FNB_EXITO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuINCONS_FNB_EXITO_ID,
				rcData
			);
		end if;

		update LD_INCONS_FNB_EXITO
		set
			DESCRIPTION = isbDESCRIPTION$
		where
			INCONS_FNB_EXITO_ID = inuINCONS_FNB_EXITO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPTION:= isbDESCRIPTION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSTATE
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		isbSTATE$ in LD_INCONS_FNB_EXITO.STATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN
		rcError.INCONS_FNB_EXITO_ID := inuINCONS_FNB_EXITO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuINCONS_FNB_EXITO_ID,
				rcData
			);
		end if;

		update LD_INCONS_FNB_EXITO
		set
			STATE = isbSTATE$
		where
			INCONS_FNB_EXITO_ID = inuINCONS_FNB_EXITO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.STATE:= isbSTATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetINCONS_FNB_EXITO_ID
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN

		rcError.INCONS_FNB_EXITO_ID := inuINCONS_FNB_EXITO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuINCONS_FNB_EXITO_ID
			 )
		then
			 return(rcData.INCONS_FNB_EXITO_ID);
		end if;
		Load
		(
		 		inuINCONS_FNB_EXITO_ID
		);
		return(rcData.INCONS_FNB_EXITO_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetFILE_NAME
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_INCONS_FNB_EXITO.FILE_NAME%type
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN

		rcError.INCONS_FNB_EXITO_ID := inuINCONS_FNB_EXITO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuINCONS_FNB_EXITO_ID
			 )
		then
			 return(rcData.FILE_NAME);
		end if;
		Load
		(
		 		inuINCONS_FNB_EXITO_ID
		);
		return(rcData.FILE_NAME);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFILE_DATE
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_INCONS_FNB_EXITO.FILE_DATE%type
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN

		rcError.INCONS_FNB_EXITO_ID := inuINCONS_FNB_EXITO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuINCONS_FNB_EXITO_ID
			 )
		then
			 return(rcData.FILE_DATE);
		end if;
		Load
		(
		 		inuINCONS_FNB_EXITO_ID
		);
		return(rcData.FILE_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSALE_ID
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_INCONS_FNB_EXITO.SALE_ID%type
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN

		rcError.INCONS_FNB_EXITO_ID := inuINCONS_FNB_EXITO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuINCONS_FNB_EXITO_ID
			 )
		then
			 return(rcData.SALE_ID);
		end if;
		Load
		(
		 		inuINCONS_FNB_EXITO_ID
		);
		return(rcData.SALE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDESCRIPTION
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_INCONS_FNB_EXITO.DESCRIPTION%type
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN

		rcError.INCONS_FNB_EXITO_ID := inuINCONS_FNB_EXITO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuINCONS_FNB_EXITO_ID
			 )
		then
			 return(rcData.DESCRIPTION);
		end if;
		Load
		(
		 		inuINCONS_FNB_EXITO_ID
		);
		return(rcData.DESCRIPTION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSTATE
	(
		inuINCONS_FNB_EXITO_ID in LD_INCONS_FNB_EXITO.INCONS_FNB_EXITO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_INCONS_FNB_EXITO.STATE%type
	IS
		rcError styLD_INCONS_FNB_EXITO;
	BEGIN

		rcError.INCONS_FNB_EXITO_ID := inuINCONS_FNB_EXITO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuINCONS_FNB_EXITO_ID
			 )
		then
			 return(rcData.STATE);
		end if;
		Load
		(
		 		inuINCONS_FNB_EXITO_ID
		);
		return(rcData.STATE);
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
end DALD_INCONS_FNB_EXITO;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_INCONS_FNB_EXITO
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_INCONS_FNB_EXITO', 'ADM_PERSON'); 
END;
/ 
