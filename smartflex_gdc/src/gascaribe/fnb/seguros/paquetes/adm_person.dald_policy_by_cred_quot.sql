CREATE OR REPLACE PACKAGE adm_person.dald_policy_by_cred_quot
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type
  )
  IS
		SELECT LD_policy_by_cred_quot.*,LD_policy_by_cred_quot.rowid
		FROM LD_policy_by_cred_quot
		WHERE
			POLICY_BY_CRED_QUOT_Id = inuPOLICY_BY_CRED_QUOT_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_policy_by_cred_quot.*,LD_policy_by_cred_quot.rowid
		FROM LD_policy_by_cred_quot
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_policy_by_cred_quot  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_policy_by_cred_quot is table of styLD_policy_by_cred_quot index by binary_integer;
	type tyrfRecords is ref cursor return styLD_policy_by_cred_quot;

	/* Tipos referenciando al registro */
	type tytbPolicy_By_Cred_Quot_Id is table of LD_policy_by_cred_quot.Policy_By_Cred_Quot_Id%type index by binary_integer;
	type tytbCredit_Quota_Id is table of LD_policy_by_cred_quot.Credit_Quota_Id%type index by binary_integer;
	type tytbQuota_Assign_Policy_Id is table of LD_policy_by_cred_quot.Quota_Assign_Policy_Id%type index by binary_integer;
	type tytbParameter_Value is table of LD_policy_by_cred_quot.Parameter_Value%type index by binary_integer;
	type tytbInitial_Date is table of LD_policy_by_cred_quot.Initial_Date%type index by binary_integer;
	type tytbFinal_Date is table of LD_policy_by_cred_quot.Final_Date%type index by binary_integer;
	type tytbActive is table of LD_policy_by_cred_quot.Active%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_policy_by_cred_quot is record
	(

		Policy_By_Cred_Quot_Id   tytbPolicy_By_Cred_Quot_Id,
		Credit_Quota_Id   tytbCredit_Quota_Id,
		Quota_Assign_Policy_Id   tytbQuota_Assign_Policy_Id,
		Parameter_Value   tytbParameter_Value,
		Initial_Date   tytbInitial_Date,
		Final_Date   tytbFinal_Date,
		Active   tytbActive,
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
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type
	);

	PROCEDURE getRecord
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		orcRecord out nocopy styLD_policy_by_cred_quot
	);

	FUNCTION frcGetRcData
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type
	)
	RETURN styLD_policy_by_cred_quot;

	FUNCTION frcGetRcData
	RETURN styLD_policy_by_cred_quot;

	FUNCTION frcGetRecord
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type
	)
	RETURN styLD_policy_by_cred_quot;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_policy_by_cred_quot
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_policy_by_cred_quot in styLD_policy_by_cred_quot
	);

 	  PROCEDURE insRecord
	(
		ircLD_policy_by_cred_quot in styLD_policy_by_cred_quot,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_policy_by_cred_quot in out nocopy tytbLD_policy_by_cred_quot
	);

	PROCEDURE delRecord
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_policy_by_cred_quot in out nocopy tytbLD_policy_by_cred_quot,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_policy_by_cred_quot in styLD_policy_by_cred_quot,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_policy_by_cred_quot in out nocopy tytbLD_policy_by_cred_quot,
		inuLock in number default 1
	);

		PROCEDURE updCredit_Quota_Id
		(
				inuPOLICY_BY_CRED_QUOT_Id   in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
				inuCredit_Quota_Id$  in LD_policy_by_cred_quot.Credit_Quota_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updQuota_Assign_Policy_Id
		(
				inuPOLICY_BY_CRED_QUOT_Id   in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
				inuQuota_Assign_Policy_Id$  in LD_policy_by_cred_quot.Quota_Assign_Policy_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updParameter_Value
		(
				inuPOLICY_BY_CRED_QUOT_Id   in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
				isbParameter_Value$  in LD_policy_by_cred_quot.Parameter_Value%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updInitial_Date
		(
				inuPOLICY_BY_CRED_QUOT_Id   in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
				idtInitial_Date$  in LD_policy_by_cred_quot.Initial_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updFinal_Date
		(
				inuPOLICY_BY_CRED_QUOT_Id   in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
				idtFinal_Date$  in LD_policy_by_cred_quot.Final_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updActive
		(
				inuPOLICY_BY_CRED_QUOT_Id   in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
				isbActive$  in LD_policy_by_cred_quot.Active%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetPolicy_By_Cred_Quot_Id
    	(
    	    inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_policy_by_cred_quot.Policy_By_Cred_Quot_Id%type;

    	FUNCTION fnuGetCredit_Quota_Id
    	(
    	    inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_policy_by_cred_quot.Credit_Quota_Id%type;

    	FUNCTION fnuGetQuota_Assign_Policy_Id
    	(
    	    inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_policy_by_cred_quot.Quota_Assign_Policy_Id%type;

    	FUNCTION fsbGetParameter_Value
    	(
    	    inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_policy_by_cred_quot.Parameter_Value%type;

    	FUNCTION fdtGetInitial_Date
    	(
    	    inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_policy_by_cred_quot.Initial_Date%type;

    	FUNCTION fdtGetFinal_Date
    	(
    	    inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_policy_by_cred_quot.Final_Date%type;

    	FUNCTION fsbGetActive
    	(
    	    inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_policy_by_cred_quot.Active%type;


	PROCEDURE LockByPk
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		orcLD_policy_by_cred_quot  out styLD_policy_by_cred_quot
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_policy_by_cred_quot  out styLD_policy_by_cred_quot
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_policy_by_cred_quot;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_policy_by_cred_quot
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_POLICY_BY_CRED_QUOT';
	  cnuGeEntityId constant varchar2(30) := 8167; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type
	)
	IS
		SELECT LD_policy_by_cred_quot.*,LD_policy_by_cred_quot.rowid
		FROM LD_policy_by_cred_quot
		WHERE  POLICY_BY_CRED_QUOT_Id = inuPOLICY_BY_CRED_QUOT_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_policy_by_cred_quot.*,LD_policy_by_cred_quot.rowid
		FROM LD_policy_by_cred_quot
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_policy_by_cred_quot is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_policy_by_cred_quot;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_policy_by_cred_quot default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.POLICY_BY_CRED_QUOT_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		orcLD_policy_by_cred_quot  out styLD_policy_by_cred_quot
	)
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN
		rcError.POLICY_BY_CRED_QUOT_Id := inuPOLICY_BY_CRED_QUOT_Id;

		Open cuLockRcByPk
		(
			inuPOLICY_BY_CRED_QUOT_Id
		);

		fetch cuLockRcByPk into orcLD_policy_by_cred_quot;
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
		orcLD_policy_by_cred_quot  out styLD_policy_by_cred_quot
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_policy_by_cred_quot;
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
		itbLD_policy_by_cred_quot  in out nocopy tytbLD_policy_by_cred_quot
	)
	IS
	BEGIN
			rcRecOfTab.Policy_By_Cred_Quot_Id.delete;
			rcRecOfTab.Credit_Quota_Id.delete;
			rcRecOfTab.Quota_Assign_Policy_Id.delete;
			rcRecOfTab.Parameter_Value.delete;
			rcRecOfTab.Initial_Date.delete;
			rcRecOfTab.Final_Date.delete;
			rcRecOfTab.Active.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_policy_by_cred_quot  in out nocopy tytbLD_policy_by_cred_quot,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_policy_by_cred_quot);
		for n in itbLD_policy_by_cred_quot.first .. itbLD_policy_by_cred_quot.last loop
			rcRecOfTab.Policy_By_Cred_Quot_Id(n) := itbLD_policy_by_cred_quot(n).Policy_By_Cred_Quot_Id;
			rcRecOfTab.Credit_Quota_Id(n) := itbLD_policy_by_cred_quot(n).Credit_Quota_Id;
			rcRecOfTab.Quota_Assign_Policy_Id(n) := itbLD_policy_by_cred_quot(n).Quota_Assign_Policy_Id;
			rcRecOfTab.Parameter_Value(n) := itbLD_policy_by_cred_quot(n).Parameter_Value;
			rcRecOfTab.Initial_Date(n) := itbLD_policy_by_cred_quot(n).Initial_Date;
			rcRecOfTab.Final_Date(n) := itbLD_policy_by_cred_quot(n).Final_Date;
			rcRecOfTab.Active(n) := itbLD_policy_by_cred_quot(n).Active;
			rcRecOfTab.row_id(n) := itbLD_policy_by_cred_quot(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPOLICY_BY_CRED_QUOT_Id
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
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPOLICY_BY_CRED_QUOT_Id = rcData.POLICY_BY_CRED_QUOT_Id
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
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPOLICY_BY_CRED_QUOT_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type
	)
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN		rcError.POLICY_BY_CRED_QUOT_Id:=inuPOLICY_BY_CRED_QUOT_Id;

		Load
		(
			inuPOLICY_BY_CRED_QUOT_Id
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
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuPOLICY_BY_CRED_QUOT_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		orcRecord out nocopy styLD_policy_by_cred_quot
	)
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN		rcError.POLICY_BY_CRED_QUOT_Id:=inuPOLICY_BY_CRED_QUOT_Id;

		Load
		(
			inuPOLICY_BY_CRED_QUOT_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type
	)
	RETURN styLD_policy_by_cred_quot
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN
		rcError.POLICY_BY_CRED_QUOT_Id:=inuPOLICY_BY_CRED_QUOT_Id;

		Load
		(
			inuPOLICY_BY_CRED_QUOT_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type
	)
	RETURN styLD_policy_by_cred_quot
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN
		rcError.POLICY_BY_CRED_QUOT_Id:=inuPOLICY_BY_CRED_QUOT_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_BY_CRED_QUOT_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPOLICY_BY_CRED_QUOT_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_policy_by_cred_quot
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_policy_by_cred_quot
	)
	IS
		rfLD_policy_by_cred_quot tyrfLD_policy_by_cred_quot;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_policy_by_cred_quot.Policy_By_Cred_Quot_Id,
		            LD_policy_by_cred_quot.Credit_Quota_Id,
		            LD_policy_by_cred_quot.Quota_Assign_Policy_Id,
		            LD_policy_by_cred_quot.Parameter_Value,
		            LD_policy_by_cred_quot.Initial_Date,
		            LD_policy_by_cred_quot.Final_Date,
		            LD_policy_by_cred_quot.Active,
		            LD_policy_by_cred_quot.rowid
                FROM LD_policy_by_cred_quot';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_policy_by_cred_quot for sbFullQuery;
		fetch rfLD_policy_by_cred_quot bulk collect INTO otbResult;
		close rfLD_policy_by_cred_quot;
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
		sbSQL  VARCHAR2 (32000) := 'select
		            LD_policy_by_cred_quot.Policy_By_Cred_Quot_Id,
		            LD_policy_by_cred_quot.Credit_Quota_Id,
		            LD_policy_by_cred_quot.Quota_Assign_Policy_Id,
		            LD_policy_by_cred_quot.Parameter_Value,
		            LD_policy_by_cred_quot.Initial_Date,
		            LD_policy_by_cred_quot.Final_Date,
		            LD_policy_by_cred_quot.Active,
		            LD_policy_by_cred_quot.rowid
                FROM LD_policy_by_cred_quot';
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
		ircLD_policy_by_cred_quot in styLD_policy_by_cred_quot
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_policy_by_cred_quot,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_policy_by_cred_quot in styLD_policy_by_cred_quot,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|POLICY_BY_CRED_QUOT_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_policy_by_cred_quot
		(
			Policy_By_Cred_Quot_Id,
			Credit_Quota_Id,
			Quota_Assign_Policy_Id,
			Parameter_Value,
			Initial_Date,
			Final_Date,
			Active
		)
		values
		(
			ircLD_policy_by_cred_quot.Policy_By_Cred_Quot_Id,
			ircLD_policy_by_cred_quot.Credit_Quota_Id,
			ircLD_policy_by_cred_quot.Quota_Assign_Policy_Id,
			ircLD_policy_by_cred_quot.Parameter_Value,
			ircLD_policy_by_cred_quot.Initial_Date,
			ircLD_policy_by_cred_quot.Final_Date,
			ircLD_policy_by_cred_quot.Active
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_policy_by_cred_quot));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_policy_by_cred_quot in out nocopy tytbLD_policy_by_cred_quot
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_policy_by_cred_quot, blUseRowID);
		forall n in iotbLD_policy_by_cred_quot.first..iotbLD_policy_by_cred_quot.last
			insert into LD_policy_by_cred_quot
			(
			Policy_By_Cred_Quot_Id,
			Credit_Quota_Id,
			Quota_Assign_Policy_Id,
			Parameter_Value,
			Initial_Date,
			Final_Date,
			Active
		)
		values
		(
			rcRecOfTab.Policy_By_Cred_Quot_Id(n),
			rcRecOfTab.Credit_Quota_Id(n),
			rcRecOfTab.Quota_Assign_Policy_Id(n),
			rcRecOfTab.Parameter_Value(n),
			rcRecOfTab.Initial_Date(n),
			rcRecOfTab.Final_Date(n),
			rcRecOfTab.Active(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN
		rcError.POLICY_BY_CRED_QUOT_Id:=inuPOLICY_BY_CRED_QUOT_Id;

		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_BY_CRED_QUOT_Id,
				rcData
			);
		end if;

		delete
		from LD_policy_by_cred_quot
		where
       		POLICY_BY_CRED_QUOT_Id=inuPOLICY_BY_CRED_QUOT_Id;
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
		iriRowID   in rowid,
		inuLock    in number default 1
	)
	IS
		rcRecordNull cuRecord%rowtype;
		rcError  styLD_policy_by_cred_quot;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_policy_by_cred_quot
		where
			rowid = iriRowID
		returning
   POLICY_BY_CRED_QUOT_Id
		into
			rcError.POLICY_BY_CRED_QUOT_Id;

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
		iotbLD_policy_by_cred_quot in out nocopy tytbLD_policy_by_cred_quot,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_policy_by_cred_quot;
	BEGIN
		FillRecordOfTables(iotbLD_policy_by_cred_quot, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_policy_by_cred_quot.first .. iotbLD_policy_by_cred_quot.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_policy_by_cred_quot.first .. iotbLD_policy_by_cred_quot.last
				delete
				from LD_policy_by_cred_quot
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_policy_by_cred_quot.first .. iotbLD_policy_by_cred_quot.last loop
					LockByPk
					(
							rcRecOfTab.POLICY_BY_CRED_QUOT_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_policy_by_cred_quot.first .. iotbLD_policy_by_cred_quot.last
				delete
				from LD_policy_by_cred_quot
				where
		         	POLICY_BY_CRED_QUOT_Id = rcRecOfTab.POLICY_BY_CRED_QUOT_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_policy_by_cred_quot in styLD_policy_by_cred_quot,
		inuLock	  in number default 0
	)
	IS
		nuPOLICY_BY_CRED_QUOT_Id LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type;

	BEGIN
		if ircLD_policy_by_cred_quot.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_policy_by_cred_quot.rowid,rcData);
			end if;
			update LD_policy_by_cred_quot
			set

        Credit_Quota_Id = ircLD_policy_by_cred_quot.Credit_Quota_Id,
        Quota_Assign_Policy_Id = ircLD_policy_by_cred_quot.Quota_Assign_Policy_Id,
        Parameter_Value = ircLD_policy_by_cred_quot.Parameter_Value,
        Initial_Date = ircLD_policy_by_cred_quot.Initial_Date,
        Final_Date = ircLD_policy_by_cred_quot.Final_Date,
        Active = ircLD_policy_by_cred_quot.Active
			where
				rowid = ircLD_policy_by_cred_quot.rowid
			returning
    POLICY_BY_CRED_QUOT_Id
			into
				nuPOLICY_BY_CRED_QUOT_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id,
					rcData
				);
			end if;

			update LD_policy_by_cred_quot
			set
        Credit_Quota_Id = ircLD_policy_by_cred_quot.Credit_Quota_Id,
        Quota_Assign_Policy_Id = ircLD_policy_by_cred_quot.Quota_Assign_Policy_Id,
        Parameter_Value = ircLD_policy_by_cred_quot.Parameter_Value,
        Initial_Date = ircLD_policy_by_cred_quot.Initial_Date,
        Final_Date = ircLD_policy_by_cred_quot.Final_Date,
        Active = ircLD_policy_by_cred_quot.Active
			where
	         	POLICY_BY_CRED_QUOT_Id = ircLD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id
			returning
    POLICY_BY_CRED_QUOT_Id
			into
				nuPOLICY_BY_CRED_QUOT_Id;
		end if;

		if
			nuPOLICY_BY_CRED_QUOT_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_policy_by_cred_quot));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_policy_by_cred_quot in out nocopy tytbLD_policy_by_cred_quot,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_policy_by_cred_quot;
  BEGIN
    FillRecordOfTables(iotbLD_policy_by_cred_quot,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_policy_by_cred_quot.first .. iotbLD_policy_by_cred_quot.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_policy_by_cred_quot.first .. iotbLD_policy_by_cred_quot.last
        update LD_policy_by_cred_quot
        set

            Credit_Quota_Id = rcRecOfTab.Credit_Quota_Id(n),
            Quota_Assign_Policy_Id = rcRecOfTab.Quota_Assign_Policy_Id(n),
            Parameter_Value = rcRecOfTab.Parameter_Value(n),
            Initial_Date = rcRecOfTab.Initial_Date(n),
            Final_Date = rcRecOfTab.Final_Date(n),
            Active = rcRecOfTab.Active(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_policy_by_cred_quot.first .. iotbLD_policy_by_cred_quot.last loop
          LockByPk
          (
              rcRecOfTab.POLICY_BY_CRED_QUOT_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_policy_by_cred_quot.first .. iotbLD_policy_by_cred_quot.last
        update LD_policy_by_cred_quot
        set
					Credit_Quota_Id = rcRecOfTab.Credit_Quota_Id(n),
					Quota_Assign_Policy_Id = rcRecOfTab.Quota_Assign_Policy_Id(n),
					Parameter_Value = rcRecOfTab.Parameter_Value(n),
					Initial_Date = rcRecOfTab.Initial_Date(n),
					Final_Date = rcRecOfTab.Final_Date(n),
					Active = rcRecOfTab.Active(n)
          where
          POLICY_BY_CRED_QUOT_Id = rcRecOfTab.POLICY_BY_CRED_QUOT_Id(n)
;
    end if;
  END;

	PROCEDURE updCredit_Quota_Id
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		inuCredit_Quota_Id$ in LD_policy_by_cred_quot.Credit_Quota_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN
		rcError.POLICY_BY_CRED_QUOT_Id := inuPOLICY_BY_CRED_QUOT_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_BY_CRED_QUOT_Id,
				rcData
			);
		end if;

		update LD_policy_by_cred_quot
		set
			Credit_Quota_Id = inuCredit_Quota_Id$
		where
			POLICY_BY_CRED_QUOT_Id = inuPOLICY_BY_CRED_QUOT_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Credit_Quota_Id:= inuCredit_Quota_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updQuota_Assign_Policy_Id
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		inuQuota_Assign_Policy_Id$ in LD_policy_by_cred_quot.Quota_Assign_Policy_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN
		rcError.POLICY_BY_CRED_QUOT_Id := inuPOLICY_BY_CRED_QUOT_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_BY_CRED_QUOT_Id,
				rcData
			);
		end if;

		update LD_policy_by_cred_quot
		set
			Quota_Assign_Policy_Id = inuQuota_Assign_Policy_Id$
		where
			POLICY_BY_CRED_QUOT_Id = inuPOLICY_BY_CRED_QUOT_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Quota_Assign_Policy_Id:= inuQuota_Assign_Policy_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updParameter_Value
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		isbParameter_Value$ in LD_policy_by_cred_quot.Parameter_Value%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN
		rcError.POLICY_BY_CRED_QUOT_Id := inuPOLICY_BY_CRED_QUOT_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_BY_CRED_QUOT_Id,
				rcData
			);
		end if;

		update LD_policy_by_cred_quot
		set
			Parameter_Value = isbParameter_Value$
		where
			POLICY_BY_CRED_QUOT_Id = inuPOLICY_BY_CRED_QUOT_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Parameter_Value:= isbParameter_Value$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updInitial_Date
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		idtInitial_Date$ in LD_policy_by_cred_quot.Initial_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN
		rcError.POLICY_BY_CRED_QUOT_Id := inuPOLICY_BY_CRED_QUOT_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_BY_CRED_QUOT_Id,
				rcData
			);
		end if;

		update LD_policy_by_cred_quot
		set
			Initial_Date = idtInitial_Date$
		where
			POLICY_BY_CRED_QUOT_Id = inuPOLICY_BY_CRED_QUOT_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Initial_Date:= idtInitial_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updFinal_Date
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		idtFinal_Date$ in LD_policy_by_cred_quot.Final_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN
		rcError.POLICY_BY_CRED_QUOT_Id := inuPOLICY_BY_CRED_QUOT_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_BY_CRED_QUOT_Id,
				rcData
			);
		end if;

		update LD_policy_by_cred_quot
		set
			Final_Date = idtFinal_Date$
		where
			POLICY_BY_CRED_QUOT_Id = inuPOLICY_BY_CRED_QUOT_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Final_Date:= idtFinal_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updActive
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		isbActive$ in LD_policy_by_cred_quot.Active%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN
		rcError.POLICY_BY_CRED_QUOT_Id := inuPOLICY_BY_CRED_QUOT_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_BY_CRED_QUOT_Id,
				rcData
			);
		end if;

		update LD_policy_by_cred_quot
		set
			Active = isbActive$
		where
			POLICY_BY_CRED_QUOT_Id = inuPOLICY_BY_CRED_QUOT_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Active:= isbActive$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetPolicy_By_Cred_Quot_Id
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_by_cred_quot.Policy_By_Cred_Quot_Id%type
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN

		rcError.POLICY_BY_CRED_QUOT_Id := inuPOLICY_BY_CRED_QUOT_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPOLICY_BY_CRED_QUOT_Id
			 )
		then
			 return(rcData.Policy_By_Cred_Quot_Id);
		end if;
		Load
		(
			inuPOLICY_BY_CRED_QUOT_Id
		);
		return(rcData.Policy_By_Cred_Quot_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetCredit_Quota_Id
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_by_cred_quot.Credit_Quota_Id%type
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN

		rcError.POLICY_BY_CRED_QUOT_Id := inuPOLICY_BY_CRED_QUOT_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPOLICY_BY_CRED_QUOT_Id
			 )
		then
			 return(rcData.Credit_Quota_Id);
		end if;
		Load
		(
			inuPOLICY_BY_CRED_QUOT_Id
		);
		return(rcData.Credit_Quota_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetQuota_Assign_Policy_Id
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_by_cred_quot.Quota_Assign_Policy_Id%type
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN

		rcError.POLICY_BY_CRED_QUOT_Id := inuPOLICY_BY_CRED_QUOT_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPOLICY_BY_CRED_QUOT_Id
			 )
		then
			 return(rcData.Quota_Assign_Policy_Id);
		end if;
		Load
		(
			inuPOLICY_BY_CRED_QUOT_Id
		);
		return(rcData.Quota_Assign_Policy_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetParameter_Value
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_by_cred_quot.Parameter_Value%type
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN

		rcError.POLICY_BY_CRED_QUOT_Id:=inuPOLICY_BY_CRED_QUOT_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPOLICY_BY_CRED_QUOT_Id
			 )
		then
			 return(rcData.Parameter_Value);
		end if;
		Load
		(
			inuPOLICY_BY_CRED_QUOT_Id
		);
		return(rcData.Parameter_Value);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetInitial_Date
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_by_cred_quot.Initial_Date%type
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN

		rcError.POLICY_BY_CRED_QUOT_Id:=inuPOLICY_BY_CRED_QUOT_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_BY_CRED_QUOT_Id
			 )
		then
			 return(rcData.Initial_Date);
		end if;
		Load
		(
		 		inuPOLICY_BY_CRED_QUOT_Id
		);
		return(rcData.Initial_Date);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetFinal_Date
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_by_cred_quot.Final_Date%type
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN

		rcError.POLICY_BY_CRED_QUOT_Id:=inuPOLICY_BY_CRED_QUOT_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_BY_CRED_QUOT_Id
			 )
		then
			 return(rcData.Final_Date);
		end if;
		Load
		(
		 		inuPOLICY_BY_CRED_QUOT_Id
		);
		return(rcData.Final_Date);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetActive
	(
		inuPOLICY_BY_CRED_QUOT_Id in LD_policy_by_cred_quot.POLICY_BY_CRED_QUOT_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_policy_by_cred_quot.Active%type
	IS
		rcError styLD_policy_by_cred_quot;
	BEGIN

		rcError.POLICY_BY_CRED_QUOT_Id:=inuPOLICY_BY_CRED_QUOT_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPOLICY_BY_CRED_QUOT_Id
			 )
		then
			 return(rcData.Active);
		end if;
		Load
		(
			inuPOLICY_BY_CRED_QUOT_Id
		);
		return(rcData.Active);
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
end DALD_policy_by_cred_quot;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_POLICY_BY_CRED_QUOT
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_POLICY_BY_CRED_QUOT', 'ADM_PERSON'); 
END;
/  
