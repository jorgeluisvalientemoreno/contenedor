CREATE OR REPLACE PACKAGE adm_person.dald_deta_extra_quota_fnb
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  04/06/2024   Adrianavg   OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type
	)
	IS
		SELECT LD_DETA_EXTRA_QUOTA_FNB.*,LD_DETA_EXTRA_QUOTA_FNB.rowid
		FROM LD_DETA_EXTRA_QUOTA_FNB
		WHERE
		    SEQUENCE_ID = inuSEQUENCE_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_DETA_EXTRA_QUOTA_FNB.*,LD_DETA_EXTRA_QUOTA_FNB.rowid
		FROM LD_DETA_EXTRA_QUOTA_FNB
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_DETA_EXTRA_QUOTA_FNB  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_DETA_EXTRA_QUOTA_FNB is table of styLD_DETA_EXTRA_QUOTA_FNB index by binary_integer;
	type tyrfRecords is ref cursor return styLD_DETA_EXTRA_QUOTA_FNB;

	/* Tipos referenciando al registro */
	type tytbSEQUENCE_ID is table of LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type index by binary_integer;
	type tytbEXTRA_QUOTA_ID is table of LD_DETA_EXTRA_QUOTA_FNB.EXTRA_QUOTA_ID%type index by binary_integer;
	type tytbSUBSCRIPTION_ID is table of LD_DETA_EXTRA_QUOTA_FNB.SUBSCRIPTION_ID%type index by binary_integer;
	type tytbUSED_QUOTA is table of LD_DETA_EXTRA_QUOTA_FNB.USED_QUOTA%type index by binary_integer;
	type tytbFECHA_REGISTRO is table of LD_DETA_EXTRA_QUOTA_FNB.FECHA_REGISTRO%type index by binary_integer;
	type tytbPACKAGE_ID_VENTA is table of LD_DETA_EXTRA_QUOTA_FNB.PACKAGE_ID_VENTA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_DETA_EXTRA_QUOTA_FNB is record
	(
		SEQUENCE_ID   tytbSEQUENCE_ID,
		EXTRA_QUOTA_ID   tytbEXTRA_QUOTA_ID,
		SUBSCRIPTION_ID   tytbSUBSCRIPTION_ID,
		USED_QUOTA   tytbUSED_QUOTA,
		FECHA_REGISTRO   tytbFECHA_REGISTRO,
		PACKAGE_ID_VENTA   tytbPACKAGE_ID_VENTA,
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
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type
	);

	PROCEDURE getRecord
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		orcRecord out nocopy styLD_DETA_EXTRA_QUOTA_FNB
	);

	FUNCTION frcGetRcData
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type
	)
	RETURN styLD_DETA_EXTRA_QUOTA_FNB;

	FUNCTION frcGetRcData
	RETURN styLD_DETA_EXTRA_QUOTA_FNB;

	FUNCTION frcGetRecord
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type
	)
	RETURN styLD_DETA_EXTRA_QUOTA_FNB;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_DETA_EXTRA_QUOTA_FNB
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_DETA_EXTRA_QUOTA_FNB in styLD_DETA_EXTRA_QUOTA_FNB
	);

	PROCEDURE insRecord
	(
		ircLD_DETA_EXTRA_QUOTA_FNB in styLD_DETA_EXTRA_QUOTA_FNB,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_DETA_EXTRA_QUOTA_FNB in out nocopy tytbLD_DETA_EXTRA_QUOTA_FNB
	);

	PROCEDURE delRecord
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_DETA_EXTRA_QUOTA_FNB in out nocopy tytbLD_DETA_EXTRA_QUOTA_FNB,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_DETA_EXTRA_QUOTA_FNB in styLD_DETA_EXTRA_QUOTA_FNB,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_DETA_EXTRA_QUOTA_FNB in out nocopy tytbLD_DETA_EXTRA_QUOTA_FNB,
		inuLock in number default 1
	);

	PROCEDURE updEXTRA_QUOTA_ID
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuEXTRA_QUOTA_ID$ in LD_DETA_EXTRA_QUOTA_FNB.EXTRA_QUOTA_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updSUBSCRIPTION_ID
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuSUBSCRIPTION_ID$ in LD_DETA_EXTRA_QUOTA_FNB.SUBSCRIPTION_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updUSED_QUOTA
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuUSED_QUOTA$ in LD_DETA_EXTRA_QUOTA_FNB.USED_QUOTA%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_REGISTRO
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		idtFECHA_REGISTRO$ in LD_DETA_EXTRA_QUOTA_FNB.FECHA_REGISTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updPACKAGE_ID_VENTA
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuPACKAGE_ID_VENTA$ in LD_DETA_EXTRA_QUOTA_FNB.PACKAGE_ID_VENTA%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetSEQUENCE_ID
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type;

	FUNCTION fnuGetEXTRA_QUOTA_ID
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETA_EXTRA_QUOTA_FNB.EXTRA_QUOTA_ID%type;

	FUNCTION fnuGetSUBSCRIPTION_ID
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETA_EXTRA_QUOTA_FNB.SUBSCRIPTION_ID%type;

	FUNCTION fnuGetUSED_QUOTA
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETA_EXTRA_QUOTA_FNB.USED_QUOTA%type;

	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETA_EXTRA_QUOTA_FNB.FECHA_REGISTRO%type;

	FUNCTION fnuGetPACKAGE_ID_VENTA
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETA_EXTRA_QUOTA_FNB.PACKAGE_ID_VENTA%type;


	PROCEDURE LockByPk
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		orcLD_DETA_EXTRA_QUOTA_FNB  out styLD_DETA_EXTRA_QUOTA_FNB
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_DETA_EXTRA_QUOTA_FNB  out styLD_DETA_EXTRA_QUOTA_FNB
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_DETA_EXTRA_QUOTA_FNB;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_DETA_EXTRA_QUOTA_FNB
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_DETA_EXTRA_QUOTA_FNB';
	 cnuGeEntityId constant varchar2(30) := 4125; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type
	)
	IS
		SELECT LD_DETA_EXTRA_QUOTA_FNB.*,LD_DETA_EXTRA_QUOTA_FNB.rowid
		FROM LD_DETA_EXTRA_QUOTA_FNB
		WHERE  SEQUENCE_ID = inuSEQUENCE_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_DETA_EXTRA_QUOTA_FNB.*,LD_DETA_EXTRA_QUOTA_FNB.rowid
		FROM LD_DETA_EXTRA_QUOTA_FNB
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_DETA_EXTRA_QUOTA_FNB is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_DETA_EXTRA_QUOTA_FNB;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_DETA_EXTRA_QUOTA_FNB default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.SEQUENCE_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		orcLD_DETA_EXTRA_QUOTA_FNB  out styLD_DETA_EXTRA_QUOTA_FNB
	)
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

		Open cuLockRcByPk
		(
			inuSEQUENCE_ID
		);

		fetch cuLockRcByPk into orcLD_DETA_EXTRA_QUOTA_FNB;
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
		orcLD_DETA_EXTRA_QUOTA_FNB  out styLD_DETA_EXTRA_QUOTA_FNB
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_DETA_EXTRA_QUOTA_FNB;
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
		itbLD_DETA_EXTRA_QUOTA_FNB  in out nocopy tytbLD_DETA_EXTRA_QUOTA_FNB
	)
	IS
	BEGIN
			rcRecOfTab.SEQUENCE_ID.delete;
			rcRecOfTab.EXTRA_QUOTA_ID.delete;
			rcRecOfTab.SUBSCRIPTION_ID.delete;
			rcRecOfTab.USED_QUOTA.delete;
			rcRecOfTab.FECHA_REGISTRO.delete;
			rcRecOfTab.PACKAGE_ID_VENTA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_DETA_EXTRA_QUOTA_FNB  in out nocopy tytbLD_DETA_EXTRA_QUOTA_FNB,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_DETA_EXTRA_QUOTA_FNB);

		for n in itbLD_DETA_EXTRA_QUOTA_FNB.first .. itbLD_DETA_EXTRA_QUOTA_FNB.last loop
			rcRecOfTab.SEQUENCE_ID(n) := itbLD_DETA_EXTRA_QUOTA_FNB(n).SEQUENCE_ID;
			rcRecOfTab.EXTRA_QUOTA_ID(n) := itbLD_DETA_EXTRA_QUOTA_FNB(n).EXTRA_QUOTA_ID;
			rcRecOfTab.SUBSCRIPTION_ID(n) := itbLD_DETA_EXTRA_QUOTA_FNB(n).SUBSCRIPTION_ID;
			rcRecOfTab.USED_QUOTA(n) := itbLD_DETA_EXTRA_QUOTA_FNB(n).USED_QUOTA;
			rcRecOfTab.FECHA_REGISTRO(n) := itbLD_DETA_EXTRA_QUOTA_FNB(n).FECHA_REGISTRO;
			rcRecOfTab.PACKAGE_ID_VENTA(n) := itbLD_DETA_EXTRA_QUOTA_FNB(n).PACKAGE_ID_VENTA;
			rcRecOfTab.row_id(n) := itbLD_DETA_EXTRA_QUOTA_FNB(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuSEQUENCE_ID
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
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuSEQUENCE_ID = rcData.SEQUENCE_ID
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
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuSEQUENCE_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type
	)
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN		rcError.SEQUENCE_ID:=inuSEQUENCE_ID;

		Load
		(
			inuSEQUENCE_ID
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
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuSEQUENCE_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		orcRecord out nocopy styLD_DETA_EXTRA_QUOTA_FNB
	)
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN		rcError.SEQUENCE_ID:=inuSEQUENCE_ID;

		Load
		(
			inuSEQUENCE_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type
	)
	RETURN styLD_DETA_EXTRA_QUOTA_FNB
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN
		rcError.SEQUENCE_ID:=inuSEQUENCE_ID;

		Load
		(
			inuSEQUENCE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type
	)
	RETURN styLD_DETA_EXTRA_QUOTA_FNB
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN
		rcError.SEQUENCE_ID:=inuSEQUENCE_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuSEQUENCE_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuSEQUENCE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_DETA_EXTRA_QUOTA_FNB
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_DETA_EXTRA_QUOTA_FNB
	)
	IS
		rfLD_DETA_EXTRA_QUOTA_FNB tyrfLD_DETA_EXTRA_QUOTA_FNB;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_DETA_EXTRA_QUOTA_FNB.*, LD_DETA_EXTRA_QUOTA_FNB.rowid FROM LD_DETA_EXTRA_QUOTA_FNB';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_DETA_EXTRA_QUOTA_FNB for sbFullQuery;

		fetch rfLD_DETA_EXTRA_QUOTA_FNB bulk collect INTO otbResult;

		close rfLD_DETA_EXTRA_QUOTA_FNB;
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
		sbSQL VARCHAR2 (32000) := 'select LD_DETA_EXTRA_QUOTA_FNB.*, LD_DETA_EXTRA_QUOTA_FNB.rowid FROM LD_DETA_EXTRA_QUOTA_FNB';
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
		ircLD_DETA_EXTRA_QUOTA_FNB in styLD_DETA_EXTRA_QUOTA_FNB
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_DETA_EXTRA_QUOTA_FNB,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_DETA_EXTRA_QUOTA_FNB in styLD_DETA_EXTRA_QUOTA_FNB,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|SEQUENCE_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_DETA_EXTRA_QUOTA_FNB
		(
			SEQUENCE_ID,
			EXTRA_QUOTA_ID,
			SUBSCRIPTION_ID,
			USED_QUOTA,
			FECHA_REGISTRO,
			PACKAGE_ID_VENTA
		)
		values
		(
			ircLD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID,
			ircLD_DETA_EXTRA_QUOTA_FNB.EXTRA_QUOTA_ID,
			ircLD_DETA_EXTRA_QUOTA_FNB.SUBSCRIPTION_ID,
			ircLD_DETA_EXTRA_QUOTA_FNB.USED_QUOTA,
			ircLD_DETA_EXTRA_QUOTA_FNB.FECHA_REGISTRO,
			ircLD_DETA_EXTRA_QUOTA_FNB.PACKAGE_ID_VENTA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_DETA_EXTRA_QUOTA_FNB));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_DETA_EXTRA_QUOTA_FNB in out nocopy tytbLD_DETA_EXTRA_QUOTA_FNB
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_DETA_EXTRA_QUOTA_FNB,blUseRowID);
		forall n in iotbLD_DETA_EXTRA_QUOTA_FNB.first..iotbLD_DETA_EXTRA_QUOTA_FNB.last
			insert into LD_DETA_EXTRA_QUOTA_FNB
			(
				SEQUENCE_ID,
				EXTRA_QUOTA_ID,
				SUBSCRIPTION_ID,
				USED_QUOTA,
				FECHA_REGISTRO,
				PACKAGE_ID_VENTA
			)
			values
			(
				rcRecOfTab.SEQUENCE_ID(n),
				rcRecOfTab.EXTRA_QUOTA_ID(n),
				rcRecOfTab.SUBSCRIPTION_ID(n),
				rcRecOfTab.USED_QUOTA(n),
				rcRecOfTab.FECHA_REGISTRO(n),
				rcRecOfTab.PACKAGE_ID_VENTA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;


		delete
		from LD_DETA_EXTRA_QUOTA_FNB
		where
       		SEQUENCE_ID=inuSEQUENCE_ID;
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
		rcError  styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_DETA_EXTRA_QUOTA_FNB
		where
			rowid = iriRowID
		returning
			SEQUENCE_ID
		into
			rcError.SEQUENCE_ID;
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
		iotbLD_DETA_EXTRA_QUOTA_FNB in out nocopy tytbLD_DETA_EXTRA_QUOTA_FNB,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN
		FillRecordOfTables(iotbLD_DETA_EXTRA_QUOTA_FNB, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_DETA_EXTRA_QUOTA_FNB.first .. iotbLD_DETA_EXTRA_QUOTA_FNB.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_DETA_EXTRA_QUOTA_FNB.first .. iotbLD_DETA_EXTRA_QUOTA_FNB.last
				delete
				from LD_DETA_EXTRA_QUOTA_FNB
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_DETA_EXTRA_QUOTA_FNB.first .. iotbLD_DETA_EXTRA_QUOTA_FNB.last loop
					LockByPk
					(
						rcRecOfTab.SEQUENCE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_DETA_EXTRA_QUOTA_FNB.first .. iotbLD_DETA_EXTRA_QUOTA_FNB.last
				delete
				from LD_DETA_EXTRA_QUOTA_FNB
				where
		         	SEQUENCE_ID = rcRecOfTab.SEQUENCE_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_DETA_EXTRA_QUOTA_FNB in styLD_DETA_EXTRA_QUOTA_FNB,
		inuLock in number default 0
	)
	IS
		nuSEQUENCE_ID	LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type;
	BEGIN
		if ircLD_DETA_EXTRA_QUOTA_FNB.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_DETA_EXTRA_QUOTA_FNB.rowid,rcData);
			end if;
			update LD_DETA_EXTRA_QUOTA_FNB
			set
				EXTRA_QUOTA_ID = ircLD_DETA_EXTRA_QUOTA_FNB.EXTRA_QUOTA_ID,
				SUBSCRIPTION_ID = ircLD_DETA_EXTRA_QUOTA_FNB.SUBSCRIPTION_ID,
				USED_QUOTA = ircLD_DETA_EXTRA_QUOTA_FNB.USED_QUOTA,
				FECHA_REGISTRO = ircLD_DETA_EXTRA_QUOTA_FNB.FECHA_REGISTRO,
				PACKAGE_ID_VENTA = ircLD_DETA_EXTRA_QUOTA_FNB.PACKAGE_ID_VENTA
			where
				rowid = ircLD_DETA_EXTRA_QUOTA_FNB.rowid
			returning
				SEQUENCE_ID
			into
				nuSEQUENCE_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID,
					rcData
				);
			end if;

			update LD_DETA_EXTRA_QUOTA_FNB
			set
				EXTRA_QUOTA_ID = ircLD_DETA_EXTRA_QUOTA_FNB.EXTRA_QUOTA_ID,
				SUBSCRIPTION_ID = ircLD_DETA_EXTRA_QUOTA_FNB.SUBSCRIPTION_ID,
				USED_QUOTA = ircLD_DETA_EXTRA_QUOTA_FNB.USED_QUOTA,
				FECHA_REGISTRO = ircLD_DETA_EXTRA_QUOTA_FNB.FECHA_REGISTRO,
				PACKAGE_ID_VENTA = ircLD_DETA_EXTRA_QUOTA_FNB.PACKAGE_ID_VENTA
			where
				SEQUENCE_ID = ircLD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID
			returning
				SEQUENCE_ID
			into
				nuSEQUENCE_ID;
		end if;
		if
			nuSEQUENCE_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_DETA_EXTRA_QUOTA_FNB));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_DETA_EXTRA_QUOTA_FNB in out nocopy tytbLD_DETA_EXTRA_QUOTA_FNB,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN
		FillRecordOfTables(iotbLD_DETA_EXTRA_QUOTA_FNB,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_DETA_EXTRA_QUOTA_FNB.first .. iotbLD_DETA_EXTRA_QUOTA_FNB.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_DETA_EXTRA_QUOTA_FNB.first .. iotbLD_DETA_EXTRA_QUOTA_FNB.last
				update LD_DETA_EXTRA_QUOTA_FNB
				set
					EXTRA_QUOTA_ID = rcRecOfTab.EXTRA_QUOTA_ID(n),
					SUBSCRIPTION_ID = rcRecOfTab.SUBSCRIPTION_ID(n),
					USED_QUOTA = rcRecOfTab.USED_QUOTA(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					PACKAGE_ID_VENTA = rcRecOfTab.PACKAGE_ID_VENTA(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_DETA_EXTRA_QUOTA_FNB.first .. iotbLD_DETA_EXTRA_QUOTA_FNB.last loop
					LockByPk
					(
						rcRecOfTab.SEQUENCE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_DETA_EXTRA_QUOTA_FNB.first .. iotbLD_DETA_EXTRA_QUOTA_FNB.last
				update LD_DETA_EXTRA_QUOTA_FNB
				SET
					EXTRA_QUOTA_ID = rcRecOfTab.EXTRA_QUOTA_ID(n),
					SUBSCRIPTION_ID = rcRecOfTab.SUBSCRIPTION_ID(n),
					USED_QUOTA = rcRecOfTab.USED_QUOTA(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					PACKAGE_ID_VENTA = rcRecOfTab.PACKAGE_ID_VENTA(n)
				where
					SEQUENCE_ID = rcRecOfTab.SEQUENCE_ID(n)
;
		end if;
	END;
	PROCEDURE updEXTRA_QUOTA_ID
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuEXTRA_QUOTA_ID$ in LD_DETA_EXTRA_QUOTA_FNB.EXTRA_QUOTA_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_DETA_EXTRA_QUOTA_FNB
		set
			EXTRA_QUOTA_ID = inuEXTRA_QUOTA_ID$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.EXTRA_QUOTA_ID:= inuEXTRA_QUOTA_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUBSCRIPTION_ID
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuSUBSCRIPTION_ID$ in LD_DETA_EXTRA_QUOTA_FNB.SUBSCRIPTION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_DETA_EXTRA_QUOTA_FNB
		set
			SUBSCRIPTION_ID = inuSUBSCRIPTION_ID$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUBSCRIPTION_ID:= inuSUBSCRIPTION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSED_QUOTA
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuUSED_QUOTA$ in LD_DETA_EXTRA_QUOTA_FNB.USED_QUOTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_DETA_EXTRA_QUOTA_FNB
		set
			USED_QUOTA = inuUSED_QUOTA$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USED_QUOTA:= inuUSED_QUOTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_REGISTRO
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		idtFECHA_REGISTRO$ in LD_DETA_EXTRA_QUOTA_FNB.FECHA_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_DETA_EXTRA_QUOTA_FNB
		set
			FECHA_REGISTRO = idtFECHA_REGISTRO$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_REGISTRO:= idtFECHA_REGISTRO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPACKAGE_ID_VENTA
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuPACKAGE_ID_VENTA$ in LD_DETA_EXTRA_QUOTA_FNB.PACKAGE_ID_VENTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN
		rcError.SEQUENCE_ID := inuSEQUENCE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEQUENCE_ID,
				rcData
			);
		end if;

		update LD_DETA_EXTRA_QUOTA_FNB
		set
			PACKAGE_ID_VENTA = inuPACKAGE_ID_VENTA$
		where
			SEQUENCE_ID = inuSEQUENCE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PACKAGE_ID_VENTA:= inuPACKAGE_ID_VENTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetSEQUENCE_ID
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.SEQUENCE_ID);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.SEQUENCE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetEXTRA_QUOTA_ID
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETA_EXTRA_QUOTA_FNB.EXTRA_QUOTA_ID%type
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.EXTRA_QUOTA_ID);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.EXTRA_QUOTA_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUBSCRIPTION_ID
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETA_EXTRA_QUOTA_FNB.SUBSCRIPTION_ID%type
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.SUBSCRIPTION_ID);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.SUBSCRIPTION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetUSED_QUOTA
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETA_EXTRA_QUOTA_FNB.USED_QUOTA%type
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.USED_QUOTA);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.USED_QUOTA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETA_EXTRA_QUOTA_FNB.FECHA_REGISTRO%type
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.FECHA_REGISTRO);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.FECHA_REGISTRO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPACKAGE_ID_VENTA
	(
		inuSEQUENCE_ID in LD_DETA_EXTRA_QUOTA_FNB.SEQUENCE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_DETA_EXTRA_QUOTA_FNB.PACKAGE_ID_VENTA%type
	IS
		rcError styLD_DETA_EXTRA_QUOTA_FNB;
	BEGIN

		rcError.SEQUENCE_ID := inuSEQUENCE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEQUENCE_ID
			 )
		then
			 return(rcData.PACKAGE_ID_VENTA);
		end if;
		Load
		(
		 		inuSEQUENCE_ID
		);
		return(rcData.PACKAGE_ID_VENTA);
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
end DALD_DETA_EXTRA_QUOTA_FNB;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_DETA_EXTRA_QUOTA_FNB
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_DETA_EXTRA_QUOTA_FNB', 'ADM_PERSON'); 
END;
/  