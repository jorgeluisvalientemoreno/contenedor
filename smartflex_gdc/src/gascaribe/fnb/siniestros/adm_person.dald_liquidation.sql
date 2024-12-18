CREATE OR REPLACE PACKAGE adm_person.dald_liquidation
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  04/06/2024   Adrianavg   OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuliquidation_Id in LD_liquidation.liquidation_Id%type
  )
  IS
		SELECT LD_liquidation.*,LD_liquidation.rowid
		FROM LD_liquidation
		WHERE
			liquidation_Id = inuliquidation_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_liquidation.*,LD_liquidation.rowid
		FROM LD_liquidation
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_liquidation  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_liquidation is table of styLD_liquidation index by binary_integer;
	type tyrfRecords is ref cursor return styLD_liquidation;

	/* Tipos referenciando al registro */
	type tytbLiqui_Package_Id is table of LD_liquidation.Liqui_Package_Id%type index by binary_integer;
	type tytbLiquidation_Id is table of LD_liquidation.Liquidation_Id%type index by binary_integer;
	type tytbSubscription_Id is table of LD_liquidation.Subscription_Id%type index by binary_integer;
	type tytbInsured_Id is table of LD_liquidation.Insured_Id%type index by binary_integer;
	type tytbApplication_Cause_Id is table of LD_liquidation.Application_Cause_Id%type index by binary_integer;
	type tytbProduct_Type_Id is table of LD_liquidation.Product_Type_Id%type index by binary_integer;
	type tytbCoverage_Type is table of LD_liquidation.Coverage_Type%type index by binary_integer;
	type tytbLocated is table of LD_liquidation.Located%type index by binary_integer;
	type tytbLoss_Date is table of LD_liquidation.Loss_Date%type index by binary_integer;
	type tytbCreation_Date is table of LD_liquidation.Creation_Date%type index by binary_integer;
	type tytbState is table of LD_liquidation.State%type index by binary_integer;
	type tytbReassessment_Date is table of LD_liquidation.Reassessment_Date%type index by binary_integer;
	type tytbApproval_Date is table of LD_liquidation.Approval_Date%type index by binary_integer;
	type tytbValue is table of LD_liquidation.Value%type index by binary_integer;
	type tytbUser_Liquidation is table of LD_liquidation.User_Liquidation%type index by binary_integer;
	type tytbUser_Reliquidation is table of LD_liquidation.User_Reliquidation%type index by binary_integer;
	type tytbUser_Aprobe is table of LD_liquidation.User_Aprobe%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_liquidation is record
	(

		Liqui_Package_Id   tytbLiqui_Package_Id,
		Liquidation_Id   tytbLiquidation_Id,
		Subscription_Id   tytbSubscription_Id,
		Insured_Id   tytbInsured_Id,
		Application_Cause_Id   tytbApplication_Cause_Id,
		Product_Type_Id   tytbProduct_Type_Id,
		Coverage_Type   tytbCoverage_Type,
		Located   tytbLocated,
		Loss_Date   tytbLoss_Date,
		Creation_Date   tytbCreation_Date,
		State   tytbState,
		Reassessment_Date   tytbReassessment_Date,
		Approval_Date   tytbApproval_Date,
		Value   tytbValue,
		User_Liquidation   tytbUser_Liquidation,
		User_Reliquidation   tytbUser_Reliquidation,
		User_Aprobe   tytbUser_Aprobe,
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
		inuliquidation_Id in LD_liquidation.liquidation_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuliquidation_Id in LD_liquidation.liquidation_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuliquidation_Id in LD_liquidation.liquidation_Id%type
	);

	PROCEDURE getRecord
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		orcRecord out nocopy styLD_liquidation
	);

	FUNCTION frcGetRcData
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type
	)
	RETURN styLD_liquidation;

	FUNCTION frcGetRcData
	RETURN styLD_liquidation;

	FUNCTION frcGetRecord
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type
	)
	RETURN styLD_liquidation;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_liquidation
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_liquidation in styLD_liquidation
	);

 	  PROCEDURE insRecord
	(
		ircLD_liquidation in styLD_liquidation,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_liquidation in out nocopy tytbLD_liquidation
	);

	PROCEDURE delRecord
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_liquidation in out nocopy tytbLD_liquidation,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_liquidation in styLD_liquidation,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_liquidation in out nocopy tytbLD_liquidation,
		inuLock in number default 1
	);

		PROCEDURE updLiqui_Package_Id
		(
				inuliquidation_Id   in LD_liquidation.liquidation_Id%type,
				inuLiqui_Package_Id$  in LD_liquidation.Liqui_Package_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubscription_Id
		(
				inuliquidation_Id   in LD_liquidation.liquidation_Id%type,
				inuSubscription_Id$  in LD_liquidation.Subscription_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updInsured_Id
		(
				inuliquidation_Id   in LD_liquidation.liquidation_Id%type,
				inuInsured_Id$  in LD_liquidation.Insured_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updApplication_Cause_Id
		(
				inuliquidation_Id   in LD_liquidation.liquidation_Id%type,
				inuApplication_Cause_Id$  in LD_liquidation.Application_Cause_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updProduct_Type_Id
		(
				inuliquidation_Id   in LD_liquidation.liquidation_Id%type,
				inuProduct_Type_Id$  in LD_liquidation.Product_Type_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCoverage_Type
		(
				inuliquidation_Id   in LD_liquidation.liquidation_Id%type,
				inuCoverage_Type$  in LD_liquidation.Coverage_Type%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updLocated
		(
				inuliquidation_Id   in LD_liquidation.liquidation_Id%type,
				isbLocated$  in LD_liquidation.Located%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updLoss_Date
		(
				inuliquidation_Id   in LD_liquidation.liquidation_Id%type,
				idtLoss_Date$  in LD_liquidation.Loss_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCreation_Date
		(
				inuliquidation_Id   in LD_liquidation.liquidation_Id%type,
				idtCreation_Date$  in LD_liquidation.Creation_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updState
		(
				inuliquidation_Id   in LD_liquidation.liquidation_Id%type,
				isbState$  in LD_liquidation.State%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updReassessment_Date
		(
				inuliquidation_Id   in LD_liquidation.liquidation_Id%type,
				idtReassessment_Date$  in LD_liquidation.Reassessment_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updApproval_Date
		(
				inuliquidation_Id   in LD_liquidation.liquidation_Id%type,
				idtApproval_Date$  in LD_liquidation.Approval_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updValue
		(
				inuliquidation_Id   in LD_liquidation.liquidation_Id%type,
				inuValue$  in LD_liquidation.Value%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updUser_Liquidation
		(
				inuliquidation_Id   in LD_liquidation.liquidation_Id%type,
				inuUser_Liquidation$  in LD_liquidation.User_Liquidation%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updUser_Reliquidation
		(
				inuliquidation_Id   in LD_liquidation.liquidation_Id%type,
				inuUser_Reliquidation$  in LD_liquidation.User_Reliquidation%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updUser_Aprobe
		(
				inuliquidation_Id   in LD_liquidation.liquidation_Id%type,
				inuUser_Aprobe$  in LD_liquidation.User_Aprobe%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetLiqui_Package_Id
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.Liqui_Package_Id%type;

    	FUNCTION fnuGetLiquidation_Id
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.Liquidation_Id%type;

    	FUNCTION fnuGetSubscription_Id
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.Subscription_Id%type;

    	FUNCTION fnuGetInsured_Id
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.Insured_Id%type;

    	FUNCTION fnuGetApplication_Cause_Id
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.Application_Cause_Id%type;

    	FUNCTION fnuGetProduct_Type_Id
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.Product_Type_Id%type;

    	FUNCTION fnuGetCoverage_Type
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.Coverage_Type%type;

    	FUNCTION fsbGetLocated
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.Located%type;

    	FUNCTION fdtGetLoss_Date
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.Loss_Date%type;

    	FUNCTION fdtGetCreation_Date
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.Creation_Date%type;

    	FUNCTION fsbGetState
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.State%type;

    	FUNCTION fdtGetReassessment_Date
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.Reassessment_Date%type;

    	FUNCTION fdtGetApproval_Date
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.Approval_Date%type;

    	FUNCTION fnuGetValue
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.Value%type;

    	FUNCTION fnuGetUser_Liquidation
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.User_Liquidation%type;

    	FUNCTION fnuGetUser_Reliquidation
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.User_Reliquidation%type;

    	FUNCTION fnuGetUser_Aprobe
    	(
    	    inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_liquidation.User_Aprobe%type;


	PROCEDURE LockByPk
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		orcLD_liquidation  out styLD_liquidation
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_liquidation  out styLD_liquidation
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_liquidation;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_liquidation
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO159764';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_LIQUIDATION';
	  cnuGeEntityId constant varchar2(30) := 8139; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type
	)
	IS
		SELECT LD_liquidation.*,LD_liquidation.rowid
		FROM LD_liquidation
		WHERE  liquidation_Id = inuliquidation_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_liquidation.*,LD_liquidation.rowid
		FROM LD_liquidation
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_liquidation is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_liquidation;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_liquidation default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.liquidation_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		orcLD_liquidation  out styLD_liquidation
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;

		Open cuLockRcByPk
		(
			inuliquidation_Id
		);

		fetch cuLockRcByPk into orcLD_liquidation;
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
		orcLD_liquidation  out styLD_liquidation
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_liquidation;
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
		itbLD_liquidation  in out nocopy tytbLD_liquidation
	)
	IS
	BEGIN
			rcRecOfTab.Liqui_Package_Id.delete;
			rcRecOfTab.Liquidation_Id.delete;
			rcRecOfTab.Subscription_Id.delete;
			rcRecOfTab.Insured_Id.delete;
			rcRecOfTab.Application_Cause_Id.delete;
			rcRecOfTab.Product_Type_Id.delete;
			rcRecOfTab.Coverage_Type.delete;
			rcRecOfTab.Located.delete;
			rcRecOfTab.Loss_Date.delete;
			rcRecOfTab.Creation_Date.delete;
			rcRecOfTab.State.delete;
			rcRecOfTab.Reassessment_Date.delete;
			rcRecOfTab.Approval_Date.delete;
			rcRecOfTab.Value.delete;
			rcRecOfTab.User_Liquidation.delete;
			rcRecOfTab.User_Reliquidation.delete;
			rcRecOfTab.User_Aprobe.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_liquidation  in out nocopy tytbLD_liquidation,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_liquidation);
		for n in itbLD_liquidation.first .. itbLD_liquidation.last loop
			rcRecOfTab.Liqui_Package_Id(n) := itbLD_liquidation(n).Liqui_Package_Id;
			rcRecOfTab.Liquidation_Id(n) := itbLD_liquidation(n).Liquidation_Id;
			rcRecOfTab.Subscription_Id(n) := itbLD_liquidation(n).Subscription_Id;
			rcRecOfTab.Insured_Id(n) := itbLD_liquidation(n).Insured_Id;
			rcRecOfTab.Application_Cause_Id(n) := itbLD_liquidation(n).Application_Cause_Id;
			rcRecOfTab.Product_Type_Id(n) := itbLD_liquidation(n).Product_Type_Id;
			rcRecOfTab.Coverage_Type(n) := itbLD_liquidation(n).Coverage_Type;
			rcRecOfTab.Located(n) := itbLD_liquidation(n).Located;
			rcRecOfTab.Loss_Date(n) := itbLD_liquidation(n).Loss_Date;
			rcRecOfTab.Creation_Date(n) := itbLD_liquidation(n).Creation_Date;
			rcRecOfTab.State(n) := itbLD_liquidation(n).State;
			rcRecOfTab.Reassessment_Date(n) := itbLD_liquidation(n).Reassessment_Date;
			rcRecOfTab.Approval_Date(n) := itbLD_liquidation(n).Approval_Date;
			rcRecOfTab.Value(n) := itbLD_liquidation(n).Value;
			rcRecOfTab.User_Liquidation(n) := itbLD_liquidation(n).User_Liquidation;
			rcRecOfTab.User_Reliquidation(n) := itbLD_liquidation(n).User_Reliquidation;
			rcRecOfTab.User_Aprobe(n) := itbLD_liquidation(n).User_Aprobe;
			rcRecOfTab.row_id(n) := itbLD_liquidation(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuliquidation_Id
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
		inuliquidation_Id in LD_liquidation.liquidation_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuliquidation_Id = rcData.liquidation_Id
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
		inuliquidation_Id in LD_liquidation.liquidation_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuliquidation_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type
	)
	IS
		rcError styLD_liquidation;
	BEGIN		rcError.liquidation_Id:=inuliquidation_Id;

		Load
		(
			inuliquidation_Id
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
		inuliquidation_Id in LD_liquidation.liquidation_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuliquidation_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		orcRecord out nocopy styLD_liquidation
	)
	IS
		rcError styLD_liquidation;
	BEGIN		rcError.liquidation_Id:=inuliquidation_Id;

		Load
		(
			inuliquidation_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type
	)
	RETURN styLD_liquidation
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id:=inuliquidation_Id;

		Load
		(
			inuliquidation_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type
	)
	RETURN styLD_liquidation
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id:=inuliquidation_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuliquidation_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuliquidation_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_liquidation
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_liquidation
	)
	IS
		rfLD_liquidation tyrfLD_liquidation;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_liquidation.Liqui_Package_Id,
		            LD_liquidation.Liquidation_Id,
		            LD_liquidation.Subscription_Id,
		            LD_liquidation.Insured_Id,
		            LD_liquidation.Application_Cause_Id,
		            LD_liquidation.Product_Type_Id,
		            LD_liquidation.Coverage_Type,
		            LD_liquidation.Located,
		            LD_liquidation.Loss_Date,
		            LD_liquidation.Creation_Date,
		            LD_liquidation.State,
		            LD_liquidation.Reassessment_Date,
		            LD_liquidation.Approval_Date,
		            LD_liquidation.Value,
		            LD_liquidation.User_Liquidation,
		            LD_liquidation.User_Reliquidation,
		            LD_liquidation.User_Aprobe,
		            LD_liquidation.rowid
                FROM LD_liquidation';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_liquidation for sbFullQuery;
		fetch rfLD_liquidation bulk collect INTO otbResult;
		close rfLD_liquidation;
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
		            LD_liquidation.Liqui_Package_Id,
		            LD_liquidation.Liquidation_Id,
		            LD_liquidation.Subscription_Id,
		            LD_liquidation.Insured_Id,
		            LD_liquidation.Application_Cause_Id,
		            LD_liquidation.Product_Type_Id,
		            LD_liquidation.Coverage_Type,
		            LD_liquidation.Located,
		            LD_liquidation.Loss_Date,
		            LD_liquidation.Creation_Date,
		            LD_liquidation.State,
		            LD_liquidation.Reassessment_Date,
		            LD_liquidation.Approval_Date,
		            LD_liquidation.Value,
		            LD_liquidation.User_Liquidation,
		            LD_liquidation.User_Reliquidation,
		            LD_liquidation.User_Aprobe,
		            LD_liquidation.rowid
                FROM LD_liquidation';
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
		ircLD_liquidation in styLD_liquidation
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_liquidation,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_liquidation in styLD_liquidation,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_liquidation.liquidation_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|liquidation_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_liquidation
		(
			Liqui_Package_Id,
			Liquidation_Id,
			Subscription_Id,
			Insured_Id,
			Application_Cause_Id,
			Product_Type_Id,
			Coverage_Type,
			Located,
			Loss_Date,
			Creation_Date,
			State,
			Reassessment_Date,
			Approval_Date,
			Value,
			User_Liquidation,
			User_Reliquidation,
			User_Aprobe
		)
		values
		(
			ircLD_liquidation.Liqui_Package_Id,
			ircLD_liquidation.Liquidation_Id,
			ircLD_liquidation.Subscription_Id,
			ircLD_liquidation.Insured_Id,
			ircLD_liquidation.Application_Cause_Id,
			ircLD_liquidation.Product_Type_Id,
			ircLD_liquidation.Coverage_Type,
			ircLD_liquidation.Located,
			ircLD_liquidation.Loss_Date,
			ircLD_liquidation.Creation_Date,
			ircLD_liquidation.State,
			ircLD_liquidation.Reassessment_Date,
			ircLD_liquidation.Approval_Date,
			ircLD_liquidation.Value,
			ircLD_liquidation.User_Liquidation,
			ircLD_liquidation.User_Reliquidation,
			ircLD_liquidation.User_Aprobe
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_liquidation));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_liquidation in out nocopy tytbLD_liquidation
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_liquidation, blUseRowID);
		forall n in iotbLD_liquidation.first..iotbLD_liquidation.last
			insert into LD_liquidation
			(
			Liqui_Package_Id,
			Liquidation_Id,
			Subscription_Id,
			Insured_Id,
			Application_Cause_Id,
			Product_Type_Id,
			Coverage_Type,
			Located,
			Loss_Date,
			Creation_Date,
			State,
			Reassessment_Date,
			Approval_Date,
			Value,
			User_Liquidation,
			User_Reliquidation,
			User_Aprobe
		)
		values
		(
			rcRecOfTab.Liqui_Package_Id(n),
			rcRecOfTab.Liquidation_Id(n),
			rcRecOfTab.Subscription_Id(n),
			rcRecOfTab.Insured_Id(n),
			rcRecOfTab.Application_Cause_Id(n),
			rcRecOfTab.Product_Type_Id(n),
			rcRecOfTab.Coverage_Type(n),
			rcRecOfTab.Located(n),
			rcRecOfTab.Loss_Date(n),
			rcRecOfTab.Creation_Date(n),
			rcRecOfTab.State(n),
			rcRecOfTab.Reassessment_Date(n),
			rcRecOfTab.Approval_Date(n),
			rcRecOfTab.Value(n),
			rcRecOfTab.User_Liquidation(n),
			rcRecOfTab.User_Reliquidation(n),
			rcRecOfTab.User_Aprobe(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id:=inuliquidation_Id;

		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		delete
		from LD_liquidation
		where
       		liquidation_Id=inuliquidation_Id;
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
		rcError  styLD_liquidation;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_liquidation
		where
			rowid = iriRowID
		returning
   liquidation_Id
		into
			rcError.liquidation_Id;

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
		iotbLD_liquidation in out nocopy tytbLD_liquidation,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_liquidation;
	BEGIN
		FillRecordOfTables(iotbLD_liquidation, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_liquidation.first .. iotbLD_liquidation.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_liquidation.first .. iotbLD_liquidation.last
				delete
				from LD_liquidation
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_liquidation.first .. iotbLD_liquidation.last loop
					LockByPk
					(
							rcRecOfTab.liquidation_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_liquidation.first .. iotbLD_liquidation.last
				delete
				from LD_liquidation
				where
		         	liquidation_Id = rcRecOfTab.liquidation_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_liquidation in styLD_liquidation,
		inuLock	  in number default 0
	)
	IS
		nuliquidation_Id LD_liquidation.liquidation_Id%type;

	BEGIN
		if ircLD_liquidation.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_liquidation.rowid,rcData);
			end if;
			update LD_liquidation
			set

        Liqui_Package_Id = ircLD_liquidation.Liqui_Package_Id,
        Subscription_Id = ircLD_liquidation.Subscription_Id,
        Insured_Id = ircLD_liquidation.Insured_Id,
        Application_Cause_Id = ircLD_liquidation.Application_Cause_Id,
        Product_Type_Id = ircLD_liquidation.Product_Type_Id,
        Coverage_Type = ircLD_liquidation.Coverage_Type,
        Located = ircLD_liquidation.Located,
        Loss_Date = ircLD_liquidation.Loss_Date,
        Creation_Date = ircLD_liquidation.Creation_Date,
        State = ircLD_liquidation.State,
        Reassessment_Date = ircLD_liquidation.Reassessment_Date,
        Approval_Date = ircLD_liquidation.Approval_Date,
        Value = ircLD_liquidation.Value,
        User_Liquidation = ircLD_liquidation.User_Liquidation,
        User_Reliquidation = ircLD_liquidation.User_Reliquidation,
        User_Aprobe = ircLD_liquidation.User_Aprobe
			where
				rowid = ircLD_liquidation.rowid
			returning
    liquidation_Id
			into
				nuliquidation_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_liquidation.liquidation_Id,
					rcData
				);
			end if;

			update LD_liquidation
			set
        Liqui_Package_Id = ircLD_liquidation.Liqui_Package_Id,
        Subscription_Id = ircLD_liquidation.Subscription_Id,
        Insured_Id = ircLD_liquidation.Insured_Id,
        Application_Cause_Id = ircLD_liquidation.Application_Cause_Id,
        Product_Type_Id = ircLD_liquidation.Product_Type_Id,
        Coverage_Type = ircLD_liquidation.Coverage_Type,
        Located = ircLD_liquidation.Located,
        Loss_Date = ircLD_liquidation.Loss_Date,
        Creation_Date = ircLD_liquidation.Creation_Date,
        State = ircLD_liquidation.State,
        Reassessment_Date = ircLD_liquidation.Reassessment_Date,
        Approval_Date = ircLD_liquidation.Approval_Date,
        Value = ircLD_liquidation.Value,
        User_Liquidation = ircLD_liquidation.User_Liquidation,
        User_Reliquidation = ircLD_liquidation.User_Reliquidation,
        User_Aprobe = ircLD_liquidation.User_Aprobe
			where
	         	liquidation_Id = ircLD_liquidation.liquidation_Id
			returning
    liquidation_Id
			into
				nuliquidation_Id;
		end if;

		if
			nuliquidation_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_liquidation));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_liquidation in out nocopy tytbLD_liquidation,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_liquidation;
  BEGIN
    FillRecordOfTables(iotbLD_liquidation,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_liquidation.first .. iotbLD_liquidation.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_liquidation.first .. iotbLD_liquidation.last
        update LD_liquidation
        set

            Liqui_Package_Id = rcRecOfTab.Liqui_Package_Id(n),
            Subscription_Id = rcRecOfTab.Subscription_Id(n),
            Insured_Id = rcRecOfTab.Insured_Id(n),
            Application_Cause_Id = rcRecOfTab.Application_Cause_Id(n),
            Product_Type_Id = rcRecOfTab.Product_Type_Id(n),
            Coverage_Type = rcRecOfTab.Coverage_Type(n),
            Located = rcRecOfTab.Located(n),
            Loss_Date = rcRecOfTab.Loss_Date(n),
            Creation_Date = rcRecOfTab.Creation_Date(n),
            State = rcRecOfTab.State(n),
            Reassessment_Date = rcRecOfTab.Reassessment_Date(n),
            Approval_Date = rcRecOfTab.Approval_Date(n),
            Value = rcRecOfTab.Value(n),
            User_Liquidation = rcRecOfTab.User_Liquidation(n),
            User_Reliquidation = rcRecOfTab.User_Reliquidation(n),
            User_Aprobe = rcRecOfTab.User_Aprobe(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_liquidation.first .. iotbLD_liquidation.last loop
          LockByPk
          (
              rcRecOfTab.liquidation_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_liquidation.first .. iotbLD_liquidation.last
        update LD_liquidation
        set
					Liqui_Package_Id = rcRecOfTab.Liqui_Package_Id(n),
					Subscription_Id = rcRecOfTab.Subscription_Id(n),
					Insured_Id = rcRecOfTab.Insured_Id(n),
					Application_Cause_Id = rcRecOfTab.Application_Cause_Id(n),
					Product_Type_Id = rcRecOfTab.Product_Type_Id(n),
					Coverage_Type = rcRecOfTab.Coverage_Type(n),
					Located = rcRecOfTab.Located(n),
					Loss_Date = rcRecOfTab.Loss_Date(n),
					Creation_Date = rcRecOfTab.Creation_Date(n),
					State = rcRecOfTab.State(n),
					Reassessment_Date = rcRecOfTab.Reassessment_Date(n),
					Approval_Date = rcRecOfTab.Approval_Date(n),
					Value = rcRecOfTab.Value(n),
					User_Liquidation = rcRecOfTab.User_Liquidation(n),
					User_Reliquidation = rcRecOfTab.User_Reliquidation(n),
					User_Aprobe = rcRecOfTab.User_Aprobe(n)
          where
          liquidation_Id = rcRecOfTab.liquidation_Id(n)
;
    end if;
  END;

	PROCEDURE updLiqui_Package_Id
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuLiqui_Package_Id$ in LD_liquidation.Liqui_Package_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		update LD_liquidation
		set
			Liqui_Package_Id = inuLiqui_Package_Id$
		where
			liquidation_Id = inuliquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Liqui_Package_Id:= inuLiqui_Package_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSubscription_Id
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuSubscription_Id$ in LD_liquidation.Subscription_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		update LD_liquidation
		set
			Subscription_Id = inuSubscription_Id$
		where
			liquidation_Id = inuliquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subscription_Id:= inuSubscription_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updInsured_Id
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuInsured_Id$ in LD_liquidation.Insured_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		update LD_liquidation
		set
			Insured_Id = inuInsured_Id$
		where
			liquidation_Id = inuliquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Insured_Id:= inuInsured_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updApplication_Cause_Id
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuApplication_Cause_Id$ in LD_liquidation.Application_Cause_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		update LD_liquidation
		set
			Application_Cause_Id = inuApplication_Cause_Id$
		where
			liquidation_Id = inuliquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Application_Cause_Id:= inuApplication_Cause_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updProduct_Type_Id
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuProduct_Type_Id$ in LD_liquidation.Product_Type_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		update LD_liquidation
		set
			Product_Type_Id = inuProduct_Type_Id$
		where
			liquidation_Id = inuliquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Product_Type_Id:= inuProduct_Type_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCoverage_Type
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuCoverage_Type$ in LD_liquidation.Coverage_Type%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		update LD_liquidation
		set
			Coverage_Type = inuCoverage_Type$
		where
			liquidation_Id = inuliquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Coverage_Type:= inuCoverage_Type$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updLocated
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		isbLocated$ in LD_liquidation.Located%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		update LD_liquidation
		set
			Located = isbLocated$
		where
			liquidation_Id = inuliquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Located:= isbLocated$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updLoss_Date
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		idtLoss_Date$ in LD_liquidation.Loss_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		update LD_liquidation
		set
			Loss_Date = idtLoss_Date$
		where
			liquidation_Id = inuliquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Loss_Date:= idtLoss_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCreation_Date
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		idtCreation_Date$ in LD_liquidation.Creation_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		update LD_liquidation
		set
			Creation_Date = idtCreation_Date$
		where
			liquidation_Id = inuliquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Creation_Date:= idtCreation_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updState
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		isbState$ in LD_liquidation.State%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		update LD_liquidation
		set
			State = isbState$
		where
			liquidation_Id = inuliquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.State:= isbState$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updReassessment_Date
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		idtReassessment_Date$ in LD_liquidation.Reassessment_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		update LD_liquidation
		set
			Reassessment_Date = idtReassessment_Date$
		where
			liquidation_Id = inuliquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Reassessment_Date:= idtReassessment_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updApproval_Date
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		idtApproval_Date$ in LD_liquidation.Approval_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		update LD_liquidation
		set
			Approval_Date = idtApproval_Date$
		where
			liquidation_Id = inuliquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Approval_Date:= idtApproval_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updValue
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuValue$ in LD_liquidation.Value%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		update LD_liquidation
		set
			Value = inuValue$
		where
			liquidation_Id = inuliquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Value:= inuValue$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updUser_Liquidation
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuUser_Liquidation$ in LD_liquidation.User_Liquidation%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		update LD_liquidation
		set
			User_Liquidation = inuUser_Liquidation$
		where
			liquidation_Id = inuliquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.User_Liquidation:= inuUser_Liquidation$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updUser_Reliquidation
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuUser_Reliquidation$ in LD_liquidation.User_Reliquidation%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		update LD_liquidation
		set
			User_Reliquidation = inuUser_Reliquidation$
		where
			liquidation_Id = inuliquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.User_Reliquidation:= inuUser_Reliquidation$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updUser_Aprobe
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuUser_Aprobe$ in LD_liquidation.User_Aprobe%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_liquidation;
	BEGIN
		rcError.liquidation_Id := inuliquidation_Id;
		if inuLock=1 then
			LockByPk
			(
				inuliquidation_Id,
				rcData
			);
		end if;

		update LD_liquidation
		set
			User_Aprobe = inuUser_Aprobe$
		where
			liquidation_Id = inuliquidation_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.User_Aprobe:= inuUser_Aprobe$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetLiqui_Package_Id
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.Liqui_Package_Id%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id := inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuliquidation_Id
			 )
		then
			 return(rcData.Liqui_Package_Id);
		end if;
		Load
		(
			inuliquidation_Id
		);
		return(rcData.Liqui_Package_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetLiquidation_Id
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.Liquidation_Id%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id := inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuliquidation_Id
			 )
		then
			 return(rcData.Liquidation_Id);
		end if;
		Load
		(
			inuliquidation_Id
		);
		return(rcData.Liquidation_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSubscription_Id
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.Subscription_Id%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id := inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuliquidation_Id
			 )
		then
			 return(rcData.Subscription_Id);
		end if;
		Load
		(
			inuliquidation_Id
		);
		return(rcData.Subscription_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetInsured_Id
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.Insured_Id%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id := inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuliquidation_Id
			 )
		then
			 return(rcData.Insured_Id);
		end if;
		Load
		(
			inuliquidation_Id
		);
		return(rcData.Insured_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetApplication_Cause_Id
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.Application_Cause_Id%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id := inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuliquidation_Id
			 )
		then
			 return(rcData.Application_Cause_Id);
		end if;
		Load
		(
			inuliquidation_Id
		);
		return(rcData.Application_Cause_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetProduct_Type_Id
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.Product_Type_Id%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id := inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuliquidation_Id
			 )
		then
			 return(rcData.Product_Type_Id);
		end if;
		Load
		(
			inuliquidation_Id
		);
		return(rcData.Product_Type_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetCoverage_Type
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.Coverage_Type%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id := inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuliquidation_Id
			 )
		then
			 return(rcData.Coverage_Type);
		end if;
		Load
		(
			inuliquidation_Id
		);
		return(rcData.Coverage_Type);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetLocated
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.Located%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id:=inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuliquidation_Id
			 )
		then
			 return(rcData.Located);
		end if;
		Load
		(
			inuliquidation_Id
		);
		return(rcData.Located);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetLoss_Date
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.Loss_Date%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id:=inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuliquidation_Id
			 )
		then
			 return(rcData.Loss_Date);
		end if;
		Load
		(
		 		inuliquidation_Id
		);
		return(rcData.Loss_Date);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetCreation_Date
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.Creation_Date%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id:=inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuliquidation_Id
			 )
		then
			 return(rcData.Creation_Date);
		end if;
		Load
		(
		 		inuliquidation_Id
		);
		return(rcData.Creation_Date);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetState
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.State%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id:=inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuliquidation_Id
			 )
		then
			 return(rcData.State);
		end if;
		Load
		(
			inuliquidation_Id
		);
		return(rcData.State);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetReassessment_Date
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.Reassessment_Date%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id:=inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuliquidation_Id
			 )
		then
			 return(rcData.Reassessment_Date);
		end if;
		Load
		(
		 		inuliquidation_Id
		);
		return(rcData.Reassessment_Date);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetApproval_Date
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.Approval_Date%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id:=inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuliquidation_Id
			 )
		then
			 return(rcData.Approval_Date);
		end if;
		Load
		(
		 		inuliquidation_Id
		);
		return(rcData.Approval_Date);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetValue
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.Value%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id := inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuliquidation_Id
			 )
		then
			 return(rcData.Value);
		end if;
		Load
		(
			inuliquidation_Id
		);
		return(rcData.Value);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetUser_Liquidation
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.User_Liquidation%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id := inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuliquidation_Id
			 )
		then
			 return(rcData.User_Liquidation);
		end if;
		Load
		(
			inuliquidation_Id
		);
		return(rcData.User_Liquidation);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetUser_Reliquidation
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.User_Reliquidation%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id := inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuliquidation_Id
			 )
		then
			 return(rcData.User_Reliquidation);
		end if;
		Load
		(
			inuliquidation_Id
		);
		return(rcData.User_Reliquidation);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetUser_Aprobe
	(
		inuliquidation_Id in LD_liquidation.liquidation_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_liquidation.User_Aprobe%type
	IS
		rcError styLD_liquidation;
	BEGIN

		rcError.liquidation_Id := inuliquidation_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuliquidation_Id
			 )
		then
			 return(rcData.User_Aprobe);
		end if;
		Load
		(
			inuliquidation_Id
		);
		return(rcData.User_Aprobe);
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
end DALD_liquidation;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_LIQUIDATION
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_LIQUIDATION', 'ADM_PERSON'); 
END;
/  
