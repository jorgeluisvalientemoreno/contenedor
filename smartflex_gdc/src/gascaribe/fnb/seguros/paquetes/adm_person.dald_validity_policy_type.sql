CREATE OR REPLACE PACKAGE adm_person.dald_validity_policy_type
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type
	)
	IS
		SELECT LD_VALIDITY_POLICY_TYPE.*,LD_VALIDITY_POLICY_TYPE.rowid
		FROM LD_VALIDITY_POLICY_TYPE
		WHERE
		    VALIDITY_POLICY_TYPE_ID = inuVALIDITY_POLICY_TYPE_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_VALIDITY_POLICY_TYPE.*,LD_VALIDITY_POLICY_TYPE.rowid
		FROM LD_VALIDITY_POLICY_TYPE
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_VALIDITY_POLICY_TYPE  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_VALIDITY_POLICY_TYPE is table of styLD_VALIDITY_POLICY_TYPE index by binary_integer;
	type tyrfRecords is ref cursor return styLD_VALIDITY_POLICY_TYPE;

	/* Tipos referenciando al registro */
	type tytbCOMMISSION_PERC_RENEW is table of LD_VALIDITY_POLICY_TYPE.COMMISSION_PERC_RENEW%type index by binary_integer;
	type tytbVALORBAS_PERC is table of LD_VALIDITY_POLICY_TYPE.VALORBAS_PERC%type index by binary_integer;
	type tytbVALIDITY_POLICY_TYPE_ID is table of LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type index by binary_integer;
	type tytbPOLICY_TYPE_ID is table of LD_VALIDITY_POLICY_TYPE.POLICY_TYPE_ID%type index by binary_integer;
	type tytbINITIAL_DATE is table of LD_VALIDITY_POLICY_TYPE.INITIAL_DATE%type index by binary_integer;
	type tytbFINAL_DATE is table of LD_VALIDITY_POLICY_TYPE.FINAL_DATE%type index by binary_integer;
	type tytbPOLICY_VALUE is table of LD_VALIDITY_POLICY_TYPE.POLICY_VALUE%type index by binary_integer;
	type tytbCOVERAGE_MONTH is table of LD_VALIDITY_POLICY_TYPE.COVERAGE_MONTH%type index by binary_integer;
	type tytbSHARE_VALUE is table of LD_VALIDITY_POLICY_TYPE.SHARE_VALUE%type index by binary_integer;
	type tytbCOMMISSION_PERC is table of LD_VALIDITY_POLICY_TYPE.COMMISSION_PERC%type index by binary_integer;
	type tytbOBSERVATION is table of LD_VALIDITY_POLICY_TYPE.OBSERVATION%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_VALIDITY_POLICY_TYPE is record
	(
		COMMISSION_PERC_RENEW   tytbCOMMISSION_PERC_RENEW,
		VALORBAS_PERC   tytbVALORBAS_PERC,
		VALIDITY_POLICY_TYPE_ID   tytbVALIDITY_POLICY_TYPE_ID,
		POLICY_TYPE_ID   tytbPOLICY_TYPE_ID,
		INITIAL_DATE   tytbINITIAL_DATE,
		FINAL_DATE   tytbFINAL_DATE,
		POLICY_VALUE   tytbPOLICY_VALUE,
		COVERAGE_MONTH   tytbCOVERAGE_MONTH,
		SHARE_VALUE   tytbSHARE_VALUE,
		COMMISSION_PERC   tytbCOMMISSION_PERC,
		OBSERVATION   tytbOBSERVATION,
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
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type
	);

	PROCEDURE getRecord
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		orcRecord out nocopy styLD_VALIDITY_POLICY_TYPE
	);

	FUNCTION frcGetRcData
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type
	)
	RETURN styLD_VALIDITY_POLICY_TYPE;

	FUNCTION frcGetRcData
	RETURN styLD_VALIDITY_POLICY_TYPE;

	FUNCTION frcGetRecord
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type
	)
	RETURN styLD_VALIDITY_POLICY_TYPE;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_VALIDITY_POLICY_TYPE
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_VALIDITY_POLICY_TYPE in styLD_VALIDITY_POLICY_TYPE
	);

	PROCEDURE insRecord
	(
		ircLD_VALIDITY_POLICY_TYPE in styLD_VALIDITY_POLICY_TYPE,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_VALIDITY_POLICY_TYPE in out nocopy tytbLD_VALIDITY_POLICY_TYPE
	);

	PROCEDURE delRecord
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_VALIDITY_POLICY_TYPE in out nocopy tytbLD_VALIDITY_POLICY_TYPE,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_VALIDITY_POLICY_TYPE in styLD_VALIDITY_POLICY_TYPE,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_VALIDITY_POLICY_TYPE in out nocopy tytbLD_VALIDITY_POLICY_TYPE,
		inuLock in number default 1
	);

	PROCEDURE updCOMMISSION_PERC_RENEW
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuCOMMISSION_PERC_RENEW$ in LD_VALIDITY_POLICY_TYPE.COMMISSION_PERC_RENEW%type,
		inuLock in number default 0
	);

	PROCEDURE updVALORBAS_PERC
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuVALORBAS_PERC$ in LD_VALIDITY_POLICY_TYPE.VALORBAS_PERC%type,
		inuLock in number default 0
	);

	PROCEDURE updPOLICY_TYPE_ID
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuPOLICY_TYPE_ID$ in LD_VALIDITY_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updINITIAL_DATE
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		idtINITIAL_DATE$ in LD_VALIDITY_POLICY_TYPE.INITIAL_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updFINAL_DATE
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		idtFINAL_DATE$ in LD_VALIDITY_POLICY_TYPE.FINAL_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updPOLICY_VALUE
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuPOLICY_VALUE$ in LD_VALIDITY_POLICY_TYPE.POLICY_VALUE%type,
		inuLock in number default 0
	);

	PROCEDURE updCOVERAGE_MONTH
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuCOVERAGE_MONTH$ in LD_VALIDITY_POLICY_TYPE.COVERAGE_MONTH%type,
		inuLock in number default 0
	);

	PROCEDURE updSHARE_VALUE
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuSHARE_VALUE$ in LD_VALIDITY_POLICY_TYPE.SHARE_VALUE%type,
		inuLock in number default 0
	);

	PROCEDURE updCOMMISSION_PERC
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuCOMMISSION_PERC$ in LD_VALIDITY_POLICY_TYPE.COMMISSION_PERC%type,
		inuLock in number default 0
	);

	PROCEDURE updOBSERVATION
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		isbOBSERVATION$ in LD_VALIDITY_POLICY_TYPE.OBSERVATION%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCOMMISSION_PERC_RENEW
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.COMMISSION_PERC_RENEW%type;

	FUNCTION fnuGetVALORBAS_PERC
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.VALORBAS_PERC%type;

	FUNCTION fnuGetVALIDITY_POLICY_TYPE_ID
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type;

	FUNCTION fnuGetPOLICY_TYPE_ID
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.POLICY_TYPE_ID%type;

	FUNCTION fdtGetINITIAL_DATE
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.INITIAL_DATE%type;

	FUNCTION fdtGetFINAL_DATE
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.FINAL_DATE%type;

	FUNCTION fnuGetPOLICY_VALUE
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.POLICY_VALUE%type;

	FUNCTION fnuGetCOVERAGE_MONTH
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.COVERAGE_MONTH%type;

	FUNCTION fnuGetSHARE_VALUE
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.SHARE_VALUE%type;

	FUNCTION fnuGetCOMMISSION_PERC
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.COMMISSION_PERC%type;

	FUNCTION fsbGetOBSERVATION
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.OBSERVATION%type;


	PROCEDURE LockByPk
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		orcLD_VALIDITY_POLICY_TYPE  out styLD_VALIDITY_POLICY_TYPE
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_VALIDITY_POLICY_TYPE  out styLD_VALIDITY_POLICY_TYPE
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_VALIDITY_POLICY_TYPE;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_VALIDITY_POLICY_TYPE
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_VALIDITY_POLICY_TYPE';
	 cnuGeEntityId constant varchar2(30) := 8668; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type
	)
	IS
		SELECT LD_VALIDITY_POLICY_TYPE.*,LD_VALIDITY_POLICY_TYPE.rowid
		FROM LD_VALIDITY_POLICY_TYPE
		WHERE  VALIDITY_POLICY_TYPE_ID = inuVALIDITY_POLICY_TYPE_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_VALIDITY_POLICY_TYPE.*,LD_VALIDITY_POLICY_TYPE.rowid
		FROM LD_VALIDITY_POLICY_TYPE
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_VALIDITY_POLICY_TYPE is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_VALIDITY_POLICY_TYPE;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_VALIDITY_POLICY_TYPE default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.VALIDITY_POLICY_TYPE_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		orcLD_VALIDITY_POLICY_TYPE  out styLD_VALIDITY_POLICY_TYPE
	)
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;

		Open cuLockRcByPk
		(
			inuVALIDITY_POLICY_TYPE_ID
		);

		fetch cuLockRcByPk into orcLD_VALIDITY_POLICY_TYPE;
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
		orcLD_VALIDITY_POLICY_TYPE  out styLD_VALIDITY_POLICY_TYPE
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_VALIDITY_POLICY_TYPE;
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
		itbLD_VALIDITY_POLICY_TYPE  in out nocopy tytbLD_VALIDITY_POLICY_TYPE
	)
	IS
	BEGIN
			rcRecOfTab.COMMISSION_PERC_RENEW.delete;
			rcRecOfTab.VALORBAS_PERC.delete;
			rcRecOfTab.VALIDITY_POLICY_TYPE_ID.delete;
			rcRecOfTab.POLICY_TYPE_ID.delete;
			rcRecOfTab.INITIAL_DATE.delete;
			rcRecOfTab.FINAL_DATE.delete;
			rcRecOfTab.POLICY_VALUE.delete;
			rcRecOfTab.COVERAGE_MONTH.delete;
			rcRecOfTab.SHARE_VALUE.delete;
			rcRecOfTab.COMMISSION_PERC.delete;
			rcRecOfTab.OBSERVATION.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_VALIDITY_POLICY_TYPE  in out nocopy tytbLD_VALIDITY_POLICY_TYPE,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_VALIDITY_POLICY_TYPE);

		for n in itbLD_VALIDITY_POLICY_TYPE.first .. itbLD_VALIDITY_POLICY_TYPE.last loop
			rcRecOfTab.COMMISSION_PERC_RENEW(n) := itbLD_VALIDITY_POLICY_TYPE(n).COMMISSION_PERC_RENEW;
			rcRecOfTab.VALORBAS_PERC(n) := itbLD_VALIDITY_POLICY_TYPE(n).VALORBAS_PERC;
			rcRecOfTab.VALIDITY_POLICY_TYPE_ID(n) := itbLD_VALIDITY_POLICY_TYPE(n).VALIDITY_POLICY_TYPE_ID;
			rcRecOfTab.POLICY_TYPE_ID(n) := itbLD_VALIDITY_POLICY_TYPE(n).POLICY_TYPE_ID;
			rcRecOfTab.INITIAL_DATE(n) := itbLD_VALIDITY_POLICY_TYPE(n).INITIAL_DATE;
			rcRecOfTab.FINAL_DATE(n) := itbLD_VALIDITY_POLICY_TYPE(n).FINAL_DATE;
			rcRecOfTab.POLICY_VALUE(n) := itbLD_VALIDITY_POLICY_TYPE(n).POLICY_VALUE;
			rcRecOfTab.COVERAGE_MONTH(n) := itbLD_VALIDITY_POLICY_TYPE(n).COVERAGE_MONTH;
			rcRecOfTab.SHARE_VALUE(n) := itbLD_VALIDITY_POLICY_TYPE(n).SHARE_VALUE;
			rcRecOfTab.COMMISSION_PERC(n) := itbLD_VALIDITY_POLICY_TYPE(n).COMMISSION_PERC;
			rcRecOfTab.OBSERVATION(n) := itbLD_VALIDITY_POLICY_TYPE(n).OBSERVATION;
			rcRecOfTab.row_id(n) := itbLD_VALIDITY_POLICY_TYPE(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuVALIDITY_POLICY_TYPE_ID
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
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuVALIDITY_POLICY_TYPE_ID = rcData.VALIDITY_POLICY_TYPE_ID
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
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuVALIDITY_POLICY_TYPE_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type
	)
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN		rcError.VALIDITY_POLICY_TYPE_ID:=inuVALIDITY_POLICY_TYPE_ID;

		Load
		(
			inuVALIDITY_POLICY_TYPE_ID
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
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuVALIDITY_POLICY_TYPE_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		orcRecord out nocopy styLD_VALIDITY_POLICY_TYPE
	)
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN		rcError.VALIDITY_POLICY_TYPE_ID:=inuVALIDITY_POLICY_TYPE_ID;

		Load
		(
			inuVALIDITY_POLICY_TYPE_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type
	)
	RETURN styLD_VALIDITY_POLICY_TYPE
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		rcError.VALIDITY_POLICY_TYPE_ID:=inuVALIDITY_POLICY_TYPE_ID;

		Load
		(
			inuVALIDITY_POLICY_TYPE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type
	)
	RETURN styLD_VALIDITY_POLICY_TYPE
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		rcError.VALIDITY_POLICY_TYPE_ID:=inuVALIDITY_POLICY_TYPE_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuVALIDITY_POLICY_TYPE_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuVALIDITY_POLICY_TYPE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_VALIDITY_POLICY_TYPE
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_VALIDITY_POLICY_TYPE
	)
	IS
		rfLD_VALIDITY_POLICY_TYPE tyrfLD_VALIDITY_POLICY_TYPE;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_VALIDITY_POLICY_TYPE.*, LD_VALIDITY_POLICY_TYPE.rowid FROM LD_VALIDITY_POLICY_TYPE';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_VALIDITY_POLICY_TYPE for sbFullQuery;

		fetch rfLD_VALIDITY_POLICY_TYPE bulk collect INTO otbResult;

		close rfLD_VALIDITY_POLICY_TYPE;
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
		sbSQL VARCHAR2 (32000) := 'select LD_VALIDITY_POLICY_TYPE.*, LD_VALIDITY_POLICY_TYPE.rowid FROM LD_VALIDITY_POLICY_TYPE';
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
		ircLD_VALIDITY_POLICY_TYPE in styLD_VALIDITY_POLICY_TYPE
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_VALIDITY_POLICY_TYPE,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_VALIDITY_POLICY_TYPE in styLD_VALIDITY_POLICY_TYPE,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|VALIDITY_POLICY_TYPE_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_VALIDITY_POLICY_TYPE
		(
			COMMISSION_PERC_RENEW,
			VALORBAS_PERC,
			VALIDITY_POLICY_TYPE_ID,
			POLICY_TYPE_ID,
			INITIAL_DATE,
			FINAL_DATE,
			POLICY_VALUE,
			COVERAGE_MONTH,
			SHARE_VALUE,
			COMMISSION_PERC,
			OBSERVATION
		)
		values
		(
			ircLD_VALIDITY_POLICY_TYPE.COMMISSION_PERC_RENEW,
			ircLD_VALIDITY_POLICY_TYPE.VALORBAS_PERC,
			ircLD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID,
			ircLD_VALIDITY_POLICY_TYPE.POLICY_TYPE_ID,
			ircLD_VALIDITY_POLICY_TYPE.INITIAL_DATE,
			ircLD_VALIDITY_POLICY_TYPE.FINAL_DATE,
			ircLD_VALIDITY_POLICY_TYPE.POLICY_VALUE,
			ircLD_VALIDITY_POLICY_TYPE.COVERAGE_MONTH,
			ircLD_VALIDITY_POLICY_TYPE.SHARE_VALUE,
			ircLD_VALIDITY_POLICY_TYPE.COMMISSION_PERC,
			ircLD_VALIDITY_POLICY_TYPE.OBSERVATION
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_VALIDITY_POLICY_TYPE));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_VALIDITY_POLICY_TYPE in out nocopy tytbLD_VALIDITY_POLICY_TYPE
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_VALIDITY_POLICY_TYPE,blUseRowID);
		forall n in iotbLD_VALIDITY_POLICY_TYPE.first..iotbLD_VALIDITY_POLICY_TYPE.last
			insert into LD_VALIDITY_POLICY_TYPE
			(
				COMMISSION_PERC_RENEW,
				VALORBAS_PERC,
				VALIDITY_POLICY_TYPE_ID,
				POLICY_TYPE_ID,
				INITIAL_DATE,
				FINAL_DATE,
				POLICY_VALUE,
				COVERAGE_MONTH,
				SHARE_VALUE,
				COMMISSION_PERC,
				OBSERVATION
			)
			values
			(
				rcRecOfTab.COMMISSION_PERC_RENEW(n),
				rcRecOfTab.VALORBAS_PERC(n),
				rcRecOfTab.VALIDITY_POLICY_TYPE_ID(n),
				rcRecOfTab.POLICY_TYPE_ID(n),
				rcRecOfTab.INITIAL_DATE(n),
				rcRecOfTab.FINAL_DATE(n),
				rcRecOfTab.POLICY_VALUE(n),
				rcRecOfTab.COVERAGE_MONTH(n),
				rcRecOfTab.SHARE_VALUE(n),
				rcRecOfTab.COMMISSION_PERC(n),
				rcRecOfTab.OBSERVATION(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;

		if inuLock=1 then
			LockByPk
			(
				inuVALIDITY_POLICY_TYPE_ID,
				rcData
			);
		end if;


		delete
		from LD_VALIDITY_POLICY_TYPE
		where
       		VALIDITY_POLICY_TYPE_ID=inuVALIDITY_POLICY_TYPE_ID;
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
		rcError  styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_VALIDITY_POLICY_TYPE
		where
			rowid = iriRowID
		returning
			COMMISSION_PERC_RENEW
		into
			rcError.COMMISSION_PERC_RENEW;
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
		iotbLD_VALIDITY_POLICY_TYPE in out nocopy tytbLD_VALIDITY_POLICY_TYPE,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		FillRecordOfTables(iotbLD_VALIDITY_POLICY_TYPE, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_VALIDITY_POLICY_TYPE.first .. iotbLD_VALIDITY_POLICY_TYPE.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_VALIDITY_POLICY_TYPE.first .. iotbLD_VALIDITY_POLICY_TYPE.last
				delete
				from LD_VALIDITY_POLICY_TYPE
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_VALIDITY_POLICY_TYPE.first .. iotbLD_VALIDITY_POLICY_TYPE.last loop
					LockByPk
					(
						rcRecOfTab.VALIDITY_POLICY_TYPE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_VALIDITY_POLICY_TYPE.first .. iotbLD_VALIDITY_POLICY_TYPE.last
				delete
				from LD_VALIDITY_POLICY_TYPE
				where
		         	VALIDITY_POLICY_TYPE_ID = rcRecOfTab.VALIDITY_POLICY_TYPE_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_VALIDITY_POLICY_TYPE in styLD_VALIDITY_POLICY_TYPE,
		inuLock in number default 0
	)
	IS
		nuVALIDITY_POLICY_TYPE_ID	LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type;
	BEGIN
		if ircLD_VALIDITY_POLICY_TYPE.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_VALIDITY_POLICY_TYPE.rowid,rcData);
			end if;
			update LD_VALIDITY_POLICY_TYPE
			set
				COMMISSION_PERC_RENEW = ircLD_VALIDITY_POLICY_TYPE.COMMISSION_PERC_RENEW,
				VALORBAS_PERC = ircLD_VALIDITY_POLICY_TYPE.VALORBAS_PERC,
				POLICY_TYPE_ID = ircLD_VALIDITY_POLICY_TYPE.POLICY_TYPE_ID,
				INITIAL_DATE = ircLD_VALIDITY_POLICY_TYPE.INITIAL_DATE,
				FINAL_DATE = ircLD_VALIDITY_POLICY_TYPE.FINAL_DATE,
				POLICY_VALUE = ircLD_VALIDITY_POLICY_TYPE.POLICY_VALUE,
				COVERAGE_MONTH = ircLD_VALIDITY_POLICY_TYPE.COVERAGE_MONTH,
				SHARE_VALUE = ircLD_VALIDITY_POLICY_TYPE.SHARE_VALUE,
				COMMISSION_PERC = ircLD_VALIDITY_POLICY_TYPE.COMMISSION_PERC,
				OBSERVATION = ircLD_VALIDITY_POLICY_TYPE.OBSERVATION
			where
				rowid = ircLD_VALIDITY_POLICY_TYPE.rowid
			returning
				VALIDITY_POLICY_TYPE_ID
			into
				nuVALIDITY_POLICY_TYPE_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID,
					rcData
				);
			end if;

			update LD_VALIDITY_POLICY_TYPE
			set
				COMMISSION_PERC_RENEW = ircLD_VALIDITY_POLICY_TYPE.COMMISSION_PERC_RENEW,
				VALORBAS_PERC = ircLD_VALIDITY_POLICY_TYPE.VALORBAS_PERC,
				POLICY_TYPE_ID = ircLD_VALIDITY_POLICY_TYPE.POLICY_TYPE_ID,
				INITIAL_DATE = ircLD_VALIDITY_POLICY_TYPE.INITIAL_DATE,
				FINAL_DATE = ircLD_VALIDITY_POLICY_TYPE.FINAL_DATE,
				POLICY_VALUE = ircLD_VALIDITY_POLICY_TYPE.POLICY_VALUE,
				COVERAGE_MONTH = ircLD_VALIDITY_POLICY_TYPE.COVERAGE_MONTH,
				SHARE_VALUE = ircLD_VALIDITY_POLICY_TYPE.SHARE_VALUE,
				COMMISSION_PERC = ircLD_VALIDITY_POLICY_TYPE.COMMISSION_PERC,
				OBSERVATION = ircLD_VALIDITY_POLICY_TYPE.OBSERVATION
			where
				VALIDITY_POLICY_TYPE_ID = ircLD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID
			returning
				VALIDITY_POLICY_TYPE_ID
			into
				nuVALIDITY_POLICY_TYPE_ID;
		end if;
		if
			nuVALIDITY_POLICY_TYPE_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_VALIDITY_POLICY_TYPE));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_VALIDITY_POLICY_TYPE in out nocopy tytbLD_VALIDITY_POLICY_TYPE,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		FillRecordOfTables(iotbLD_VALIDITY_POLICY_TYPE,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_VALIDITY_POLICY_TYPE.first .. iotbLD_VALIDITY_POLICY_TYPE.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_VALIDITY_POLICY_TYPE.first .. iotbLD_VALIDITY_POLICY_TYPE.last
				update LD_VALIDITY_POLICY_TYPE
				set
					COMMISSION_PERC_RENEW = rcRecOfTab.COMMISSION_PERC_RENEW(n),
					VALORBAS_PERC = rcRecOfTab.VALORBAS_PERC(n),
					POLICY_TYPE_ID = rcRecOfTab.POLICY_TYPE_ID(n),
					INITIAL_DATE = rcRecOfTab.INITIAL_DATE(n),
					FINAL_DATE = rcRecOfTab.FINAL_DATE(n),
					POLICY_VALUE = rcRecOfTab.POLICY_VALUE(n),
					COVERAGE_MONTH = rcRecOfTab.COVERAGE_MONTH(n),
					SHARE_VALUE = rcRecOfTab.SHARE_VALUE(n),
					COMMISSION_PERC = rcRecOfTab.COMMISSION_PERC(n),
					OBSERVATION = rcRecOfTab.OBSERVATION(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_VALIDITY_POLICY_TYPE.first .. iotbLD_VALIDITY_POLICY_TYPE.last loop
					LockByPk
					(
						rcRecOfTab.VALIDITY_POLICY_TYPE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_VALIDITY_POLICY_TYPE.first .. iotbLD_VALIDITY_POLICY_TYPE.last
				update LD_VALIDITY_POLICY_TYPE
				SET
					COMMISSION_PERC_RENEW = rcRecOfTab.COMMISSION_PERC_RENEW(n),
					VALORBAS_PERC = rcRecOfTab.VALORBAS_PERC(n),
					POLICY_TYPE_ID = rcRecOfTab.POLICY_TYPE_ID(n),
					INITIAL_DATE = rcRecOfTab.INITIAL_DATE(n),
					FINAL_DATE = rcRecOfTab.FINAL_DATE(n),
					POLICY_VALUE = rcRecOfTab.POLICY_VALUE(n),
					COVERAGE_MONTH = rcRecOfTab.COVERAGE_MONTH(n),
					SHARE_VALUE = rcRecOfTab.SHARE_VALUE(n),
					COMMISSION_PERC = rcRecOfTab.COMMISSION_PERC(n),
					OBSERVATION = rcRecOfTab.OBSERVATION(n)
				where
					VALIDITY_POLICY_TYPE_ID = rcRecOfTab.VALIDITY_POLICY_TYPE_ID(n)
;
		end if;
	END;
	PROCEDURE updCOMMISSION_PERC_RENEW
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuCOMMISSION_PERC_RENEW$ in LD_VALIDITY_POLICY_TYPE.COMMISSION_PERC_RENEW%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuVALIDITY_POLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_VALIDITY_POLICY_TYPE
		set
			COMMISSION_PERC_RENEW = inuCOMMISSION_PERC_RENEW$
		where
			VALIDITY_POLICY_TYPE_ID = inuVALIDITY_POLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMMISSION_PERC_RENEW:= inuCOMMISSION_PERC_RENEW$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALORBAS_PERC
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuVALORBAS_PERC$ in LD_VALIDITY_POLICY_TYPE.VALORBAS_PERC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuVALIDITY_POLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_VALIDITY_POLICY_TYPE
		set
			VALORBAS_PERC = inuVALORBAS_PERC$
		where
			VALIDITY_POLICY_TYPE_ID = inuVALIDITY_POLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALORBAS_PERC:= inuVALORBAS_PERC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPOLICY_TYPE_ID
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuPOLICY_TYPE_ID$ in LD_VALIDITY_POLICY_TYPE.POLICY_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuVALIDITY_POLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_VALIDITY_POLICY_TYPE
		set
			POLICY_TYPE_ID = inuPOLICY_TYPE_ID$
		where
			VALIDITY_POLICY_TYPE_ID = inuVALIDITY_POLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.POLICY_TYPE_ID:= inuPOLICY_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updINITIAL_DATE
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		idtINITIAL_DATE$ in LD_VALIDITY_POLICY_TYPE.INITIAL_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuVALIDITY_POLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_VALIDITY_POLICY_TYPE
		set
			INITIAL_DATE = idtINITIAL_DATE$
		where
			VALIDITY_POLICY_TYPE_ID = inuVALIDITY_POLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.INITIAL_DATE:= idtINITIAL_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFINAL_DATE
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		idtFINAL_DATE$ in LD_VALIDITY_POLICY_TYPE.FINAL_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuVALIDITY_POLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_VALIDITY_POLICY_TYPE
		set
			FINAL_DATE = idtFINAL_DATE$
		where
			VALIDITY_POLICY_TYPE_ID = inuVALIDITY_POLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FINAL_DATE:= idtFINAL_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPOLICY_VALUE
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuPOLICY_VALUE$ in LD_VALIDITY_POLICY_TYPE.POLICY_VALUE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuVALIDITY_POLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_VALIDITY_POLICY_TYPE
		set
			POLICY_VALUE = inuPOLICY_VALUE$
		where
			VALIDITY_POLICY_TYPE_ID = inuVALIDITY_POLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.POLICY_VALUE:= inuPOLICY_VALUE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOVERAGE_MONTH
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuCOVERAGE_MONTH$ in LD_VALIDITY_POLICY_TYPE.COVERAGE_MONTH%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuVALIDITY_POLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_VALIDITY_POLICY_TYPE
		set
			COVERAGE_MONTH = inuCOVERAGE_MONTH$
		where
			VALIDITY_POLICY_TYPE_ID = inuVALIDITY_POLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COVERAGE_MONTH:= inuCOVERAGE_MONTH$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSHARE_VALUE
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuSHARE_VALUE$ in LD_VALIDITY_POLICY_TYPE.SHARE_VALUE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuVALIDITY_POLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_VALIDITY_POLICY_TYPE
		set
			SHARE_VALUE = inuSHARE_VALUE$
		where
			VALIDITY_POLICY_TYPE_ID = inuVALIDITY_POLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SHARE_VALUE:= inuSHARE_VALUE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOMMISSION_PERC
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuCOMMISSION_PERC$ in LD_VALIDITY_POLICY_TYPE.COMMISSION_PERC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuVALIDITY_POLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_VALIDITY_POLICY_TYPE
		set
			COMMISSION_PERC = inuCOMMISSION_PERC$
		where
			VALIDITY_POLICY_TYPE_ID = inuVALIDITY_POLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMMISSION_PERC:= inuCOMMISSION_PERC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updOBSERVATION
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		isbOBSERVATION$ in LD_VALIDITY_POLICY_TYPE.OBSERVATION%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN
		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuVALIDITY_POLICY_TYPE_ID,
				rcData
			);
		end if;

		update LD_VALIDITY_POLICY_TYPE
		set
			OBSERVATION = isbOBSERVATION$
		where
			VALIDITY_POLICY_TYPE_ID = inuVALIDITY_POLICY_TYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OBSERVATION:= isbOBSERVATION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCOMMISSION_PERC_RENEW
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.COMMISSION_PERC_RENEW%type
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN

		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDITY_POLICY_TYPE_ID
			 )
		then
			 return(rcData.COMMISSION_PERC_RENEW);
		end if;
		Load
		(
		 		inuVALIDITY_POLICY_TYPE_ID
		);
		return(rcData.COMMISSION_PERC_RENEW);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALORBAS_PERC
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.VALORBAS_PERC%type
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN

		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDITY_POLICY_TYPE_ID
			 )
		then
			 return(rcData.VALORBAS_PERC);
		end if;
		Load
		(
		 		inuVALIDITY_POLICY_TYPE_ID
		);
		return(rcData.VALORBAS_PERC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALIDITY_POLICY_TYPE_ID
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN

		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDITY_POLICY_TYPE_ID
			 )
		then
			 return(rcData.VALIDITY_POLICY_TYPE_ID);
		end if;
		Load
		(
		 		inuVALIDITY_POLICY_TYPE_ID
		);
		return(rcData.VALIDITY_POLICY_TYPE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPOLICY_TYPE_ID
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.POLICY_TYPE_ID%type
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN

		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDITY_POLICY_TYPE_ID
			 )
		then
			 return(rcData.POLICY_TYPE_ID);
		end if;
		Load
		(
		 		inuVALIDITY_POLICY_TYPE_ID
		);
		return(rcData.POLICY_TYPE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetINITIAL_DATE
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.INITIAL_DATE%type
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN

		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDITY_POLICY_TYPE_ID
			 )
		then
			 return(rcData.INITIAL_DATE);
		end if;
		Load
		(
		 		inuVALIDITY_POLICY_TYPE_ID
		);
		return(rcData.INITIAL_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFINAL_DATE
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.FINAL_DATE%type
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN

		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDITY_POLICY_TYPE_ID
			 )
		then
			 return(rcData.FINAL_DATE);
		end if;
		Load
		(
		 		inuVALIDITY_POLICY_TYPE_ID
		);
		return(rcData.FINAL_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPOLICY_VALUE
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.POLICY_VALUE%type
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN

		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDITY_POLICY_TYPE_ID
			 )
		then
			 return(rcData.POLICY_VALUE);
		end if;
		Load
		(
		 		inuVALIDITY_POLICY_TYPE_ID
		);
		return(rcData.POLICY_VALUE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOVERAGE_MONTH
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.COVERAGE_MONTH%type
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN

		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDITY_POLICY_TYPE_ID
			 )
		then
			 return(rcData.COVERAGE_MONTH);
		end if;
		Load
		(
		 		inuVALIDITY_POLICY_TYPE_ID
		);
		return(rcData.COVERAGE_MONTH);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSHARE_VALUE
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.SHARE_VALUE%type
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN

		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDITY_POLICY_TYPE_ID
			 )
		then
			 return(rcData.SHARE_VALUE);
		end if;
		Load
		(
		 		inuVALIDITY_POLICY_TYPE_ID
		);
		return(rcData.SHARE_VALUE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOMMISSION_PERC
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.COMMISSION_PERC%type
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN

		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDITY_POLICY_TYPE_ID
			 )
		then
			 return(rcData.COMMISSION_PERC);
		end if;
		Load
		(
		 		inuVALIDITY_POLICY_TYPE_ID
		);
		return(rcData.COMMISSION_PERC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetOBSERVATION
	(
		inuVALIDITY_POLICY_TYPE_ID in LD_VALIDITY_POLICY_TYPE.VALIDITY_POLICY_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_VALIDITY_POLICY_TYPE.OBSERVATION%type
	IS
		rcError styLD_VALIDITY_POLICY_TYPE;
	BEGIN

		rcError.VALIDITY_POLICY_TYPE_ID := inuVALIDITY_POLICY_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVALIDITY_POLICY_TYPE_ID
			 )
		then
			 return(rcData.OBSERVATION);
		end if;
		Load
		(
		 		inuVALIDITY_POLICY_TYPE_ID
		);
		return(rcData.OBSERVATION);
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
end DALD_VALIDITY_POLICY_TYPE;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_VALIDITY_POLICY_TYPE
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_VALIDITY_POLICY_TYPE', 'ADM_PERSON'); 
END;
/ 
