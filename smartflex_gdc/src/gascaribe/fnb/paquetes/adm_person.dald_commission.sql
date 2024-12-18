CREATE OR REPLACE PACKAGE adm_person.dald_commission
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  04/06/2024   Adrianavg   OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type
  )
  IS
		SELECT LD_commission.*,LD_commission.rowid
		FROM LD_commission
		WHERE
			COMMISSION_Id = inuCOMMISSION_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_commission.*,LD_commission.rowid
		FROM LD_commission
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_commission  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_commission is table of styLD_commission index by binary_integer;
	type tyrfRecords is ref cursor return styLD_commission;

	/* Tipos referenciando al registro */
	type tytbCommission_Id is table of LD_commission.Commission_Id%type index by binary_integer;
	type tytbArticle_Id is table of LD_commission.Article_Id%type index by binary_integer;
	type tytbSale_Chanel_Id is table of LD_commission.Sale_Chanel_Id%type index by binary_integer;
	type tytbGeograp_Location_Id is table of LD_commission.Geograp_Location_Id%type index by binary_integer;
	type tytbContrator_Id is table of LD_commission.Contrator_Id%type index by binary_integer;
	type tytbRecovery_Percentage is table of LD_commission.Recovery_Percentage%type index by binary_integer;
	type tytbPyment_Percentage is table of LD_commission.Pyment_Percentage%type index by binary_integer;
	type tytbInclu_Vat_Reco_Commi is table of LD_commission.Inclu_Vat_Reco_Commi%type index by binary_integer;
	type tytbInclu_Vat_Pay_Commi is table of LD_commission.Inclu_Vat_Pay_Commi%type index by binary_integer;
	type tytbInitial_Date is table of LD_commission.Initial_Date%type index by binary_integer;
	type tytbLine_Id is table of LD_commission.Line_Id%type index by binary_integer;
	type tytbSubline_Id is table of LD_commission.Subline_Id%type index by binary_integer;
	type tytbSupplier_Id is table of LD_commission.Supplier_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_commission is record
	(

		Commission_Id   tytbCommission_Id,
		Article_Id   tytbArticle_Id,
		Sale_Chanel_Id   tytbSale_Chanel_Id,
		Geograp_Location_Id   tytbGeograp_Location_Id,
		Contrator_Id   tytbContrator_Id,
		Recovery_Percentage   tytbRecovery_Percentage,
		Pyment_Percentage   tytbPyment_Percentage,
		Inclu_Vat_Reco_Commi   tytbInclu_Vat_Reco_Commi,
		Inclu_Vat_Pay_Commi   tytbInclu_Vat_Pay_Commi,
		Initial_Date   tytbInitial_Date,
		Line_Id   tytbLine_Id,
		Subline_Id   tytbSubline_Id,
		Supplier_Id   tytbSupplier_Id,
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
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type
	);

	PROCEDURE getRecord
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		orcRecord out nocopy styLD_commission
	);

	FUNCTION frcGetRcData
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type
	)
	RETURN styLD_commission;

	FUNCTION frcGetRcData
	RETURN styLD_commission;

	FUNCTION frcGetRecord
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type
	)
	RETURN styLD_commission;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_commission
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_commission in styLD_commission
	);

 	  PROCEDURE insRecord
	(
		ircLD_commission in styLD_commission,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_commission in out nocopy tytbLD_commission
	);

	PROCEDURE delRecord
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_commission in out nocopy tytbLD_commission,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_commission in styLD_commission,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_commission in out nocopy tytbLD_commission,
		inuLock in number default 1
	);

		PROCEDURE updArticle_Id
		(
				inuCOMMISSION_Id   in LD_commission.COMMISSION_Id%type,
				inuArticle_Id$  in LD_commission.Article_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSale_Chanel_Id
		(
				inuCOMMISSION_Id   in LD_commission.COMMISSION_Id%type,
				inuSale_Chanel_Id$  in LD_commission.Sale_Chanel_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updGeograp_Location_Id
		(
				inuCOMMISSION_Id   in LD_commission.COMMISSION_Id%type,
				inuGeograp_Location_Id$  in LD_commission.Geograp_Location_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updContrator_Id
		(
				inuCOMMISSION_Id   in LD_commission.COMMISSION_Id%type,
				inuContrator_Id$  in LD_commission.Contrator_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updRecovery_Percentage
		(
				inuCOMMISSION_Id   in LD_commission.COMMISSION_Id%type,
				inuRecovery_Percentage$  in LD_commission.Recovery_Percentage%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updPyment_Percentage
		(
				inuCOMMISSION_Id   in LD_commission.COMMISSION_Id%type,
				inuPyment_Percentage$  in LD_commission.Pyment_Percentage%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updInclu_Vat_Reco_Commi
		(
				inuCOMMISSION_Id   in LD_commission.COMMISSION_Id%type,
				isbInclu_Vat_Reco_Commi$  in LD_commission.Inclu_Vat_Reco_Commi%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updInclu_Vat_Pay_Commi
		(
				inuCOMMISSION_Id   in LD_commission.COMMISSION_Id%type,
				isbInclu_Vat_Pay_Commi$  in LD_commission.Inclu_Vat_Pay_Commi%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updInitial_Date
		(
				inuCOMMISSION_Id   in LD_commission.COMMISSION_Id%type,
				idtInitial_Date$  in LD_commission.Initial_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updLine_Id
		(
				inuCOMMISSION_Id   in LD_commission.COMMISSION_Id%type,
				inuLine_Id$  in LD_commission.Line_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubline_Id
		(
				inuCOMMISSION_Id   in LD_commission.COMMISSION_Id%type,
				inuSubline_Id$  in LD_commission.Subline_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSupplier_Id
		(
				inuCOMMISSION_Id   in LD_commission.COMMISSION_Id%type,
				inuSupplier_Id$  in LD_commission.Supplier_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetCommission_Id
    	(
    	    inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_commission.Commission_Id%type;

    	FUNCTION fnuGetArticle_Id
    	(
    	    inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_commission.Article_Id%type;

    	FUNCTION fnuGetSale_Chanel_Id
    	(
    	    inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_commission.Sale_Chanel_Id%type;

    	FUNCTION fnuGetGeograp_Location_Id
    	(
    	    inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_commission.Geograp_Location_Id%type;

    	FUNCTION fnuGetContrator_Id
    	(
    	    inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_commission.Contrator_Id%type;

    	FUNCTION fnuGetRecovery_Percentage
    	(
    	    inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_commission.Recovery_Percentage%type;

    	FUNCTION fnuGetPyment_Percentage
    	(
    	    inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_commission.Pyment_Percentage%type;

    	FUNCTION fsbGetInclu_Vat_Reco_Commi
    	(
    	    inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_commission.Inclu_Vat_Reco_Commi%type;

    	FUNCTION fsbGetInclu_Vat_Pay_Commi
    	(
    	    inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_commission.Inclu_Vat_Pay_Commi%type;

    	FUNCTION fdtGetInitial_Date
    	(
    	    inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_commission.Initial_Date%type;

    	FUNCTION fnuGetLine_Id
    	(
    	    inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_commission.Line_Id%type;

    	FUNCTION fnuGetSubline_Id
    	(
    	    inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_commission.Subline_Id%type;

    	FUNCTION fnuGetSupplier_Id
    	(
    	    inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_commission.Supplier_Id%type;


	PROCEDURE LockByPk
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		orcLD_commission  out styLD_commission
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_commission  out styLD_commission
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_commission;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_commission
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_COMMISSION';
	  cnuGeEntityId constant varchar2(30) := ge_bocatalog.fnugetidfromcatalog('LD_COMMISSION', 'ENTITY'); -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type
	)
	IS
		SELECT LD_commission.*,LD_commission.rowid
		FROM LD_commission
		WHERE  COMMISSION_Id = inuCOMMISSION_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_commission.*,LD_commission.rowid
		FROM LD_commission
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_commission is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_commission;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_commission default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.COMMISSION_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		orcLD_commission  out styLD_commission
	)
	IS
		rcError styLD_commission;
	BEGIN
		rcError.COMMISSION_Id := inuCOMMISSION_Id;

		Open cuLockRcByPk
		(
			inuCOMMISSION_Id
		);

		fetch cuLockRcByPk into orcLD_commission;
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
		orcLD_commission  out styLD_commission
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_commission;
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
		itbLD_commission  in out nocopy tytbLD_commission
	)
	IS
	BEGIN
			rcRecOfTab.Commission_Id.delete;
			rcRecOfTab.Article_Id.delete;
			rcRecOfTab.Sale_Chanel_Id.delete;
			rcRecOfTab.Geograp_Location_Id.delete;
			rcRecOfTab.Contrator_Id.delete;
			rcRecOfTab.Recovery_Percentage.delete;
			rcRecOfTab.Pyment_Percentage.delete;
			rcRecOfTab.Inclu_Vat_Reco_Commi.delete;
			rcRecOfTab.Inclu_Vat_Pay_Commi.delete;
			rcRecOfTab.Initial_Date.delete;
			rcRecOfTab.Line_Id.delete;
			rcRecOfTab.Subline_Id.delete;
			rcRecOfTab.Supplier_Id.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_commission  in out nocopy tytbLD_commission,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_commission);
		for n in itbLD_commission.first .. itbLD_commission.last loop
			rcRecOfTab.Commission_Id(n) := itbLD_commission(n).Commission_Id;
			rcRecOfTab.Article_Id(n) := itbLD_commission(n).Article_Id;
			rcRecOfTab.Sale_Chanel_Id(n) := itbLD_commission(n).Sale_Chanel_Id;
			rcRecOfTab.Geograp_Location_Id(n) := itbLD_commission(n).Geograp_Location_Id;
			rcRecOfTab.Contrator_Id(n) := itbLD_commission(n).Contrator_Id;
			rcRecOfTab.Recovery_Percentage(n) := itbLD_commission(n).Recovery_Percentage;
			rcRecOfTab.Pyment_Percentage(n) := itbLD_commission(n).Pyment_Percentage;
			rcRecOfTab.Inclu_Vat_Reco_Commi(n) := itbLD_commission(n).Inclu_Vat_Reco_Commi;
			rcRecOfTab.Inclu_Vat_Pay_Commi(n) := itbLD_commission(n).Inclu_Vat_Pay_Commi;
			rcRecOfTab.Initial_Date(n) := itbLD_commission(n).Initial_Date;
			rcRecOfTab.Line_Id(n) := itbLD_commission(n).Line_Id;
			rcRecOfTab.Subline_Id(n) := itbLD_commission(n).Subline_Id;
			rcRecOfTab.Supplier_Id(n) := itbLD_commission(n).Supplier_Id;
			rcRecOfTab.row_id(n) := itbLD_commission(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCOMMISSION_Id
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
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCOMMISSION_Id = rcData.COMMISSION_Id
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
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCOMMISSION_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type
	)
	IS
		rcError styLD_commission;
	BEGIN		rcError.COMMISSION_Id:=inuCOMMISSION_Id;

		Load
		(
			inuCOMMISSION_Id
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
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuCOMMISSION_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		orcRecord out nocopy styLD_commission
	)
	IS
		rcError styLD_commission;
	BEGIN		rcError.COMMISSION_Id:=inuCOMMISSION_Id;

		Load
		(
			inuCOMMISSION_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type
	)
	RETURN styLD_commission
	IS
		rcError styLD_commission;
	BEGIN
		rcError.COMMISSION_Id:=inuCOMMISSION_Id;

		Load
		(
			inuCOMMISSION_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type
	)
	RETURN styLD_commission
	IS
		rcError styLD_commission;
	BEGIN
		rcError.COMMISSION_Id:=inuCOMMISSION_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMMISSION_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCOMMISSION_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_commission
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_commission
	)
	IS
		rfLD_commission tyrfLD_commission;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_commission.Commission_Id,
		            LD_commission.Article_Id,
		            LD_commission.Sale_Chanel_Id,
		            LD_commission.Geograp_Location_Id,
		            LD_commission.Contrator_Id,
		            LD_commission.Recovery_Percentage,
		            LD_commission.Pyment_Percentage,
		            LD_commission.Inclu_Vat_Reco_Commi,
		            LD_commission.Inclu_Vat_Pay_Commi,
		            LD_commission.Initial_Date,
		            LD_commission.Line_Id,
		            LD_commission.Subline_Id,
		            LD_commission.Supplier_Id,
		            LD_commission.rowid
                FROM LD_commission';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_commission for sbFullQuery;
		fetch rfLD_commission bulk collect INTO otbResult;
		close rfLD_commission;
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
		            LD_commission.Commission_Id,
		            LD_commission.Article_Id,
		            LD_commission.Sale_Chanel_Id,
		            LD_commission.Geograp_Location_Id,
		            LD_commission.Contrator_Id,
		            LD_commission.Recovery_Percentage,
		            LD_commission.Pyment_Percentage,
		            LD_commission.Inclu_Vat_Reco_Commi,
		            LD_commission.Inclu_Vat_Pay_Commi,
		            LD_commission.Initial_Date,
		            LD_commission.Line_Id,
		            LD_commission.Subline_Id,
		            LD_commission.Supplier_Id,
		            LD_commission.rowid
                FROM LD_commission';
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
		ircLD_commission in styLD_commission
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_commission,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_commission in styLD_commission,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_commission.COMMISSION_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|COMMISSION_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_commission
		(
			Commission_Id,
			Article_Id,
			Sale_Chanel_Id,
			Geograp_Location_Id,
			Contrator_Id,
			Recovery_Percentage,
			Pyment_Percentage,
			Inclu_Vat_Reco_Commi,
			Inclu_Vat_Pay_Commi,
			Initial_Date,
			Line_Id,
			Subline_Id,
			Supplier_Id
		)
		values
		(
			ircLD_commission.Commission_Id,
			ircLD_commission.Article_Id,
			ircLD_commission.Sale_Chanel_Id,
			ircLD_commission.Geograp_Location_Id,
			ircLD_commission.Contrator_Id,
			ircLD_commission.Recovery_Percentage,
			ircLD_commission.Pyment_Percentage,
			ircLD_commission.Inclu_Vat_Reco_Commi,
			ircLD_commission.Inclu_Vat_Pay_Commi,
			ircLD_commission.Initial_Date,
			ircLD_commission.Line_Id,
			ircLD_commission.Subline_Id,
			ircLD_commission.Supplier_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_commission));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_commission in out nocopy tytbLD_commission
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_commission, blUseRowID);
		forall n in iotbLD_commission.first..iotbLD_commission.last
			insert into LD_commission
			(
			Commission_Id,
			Article_Id,
			Sale_Chanel_Id,
			Geograp_Location_Id,
			Contrator_Id,
			Recovery_Percentage,
			Pyment_Percentage,
			Inclu_Vat_Reco_Commi,
			Inclu_Vat_Pay_Commi,
			Initial_Date,
			Line_Id,
			Subline_Id,
			Supplier_Id
		)
		values
		(
			rcRecOfTab.Commission_Id(n),
			rcRecOfTab.Article_Id(n),
			rcRecOfTab.Sale_Chanel_Id(n),
			rcRecOfTab.Geograp_Location_Id(n),
			rcRecOfTab.Contrator_Id(n),
			rcRecOfTab.Recovery_Percentage(n),
			rcRecOfTab.Pyment_Percentage(n),
			rcRecOfTab.Inclu_Vat_Reco_Commi(n),
			rcRecOfTab.Inclu_Vat_Pay_Commi(n),
			rcRecOfTab.Initial_Date(n),
			rcRecOfTab.Line_Id(n),
			rcRecOfTab.Subline_Id(n),
			rcRecOfTab.Supplier_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_commission;
	BEGIN
		rcError.COMMISSION_Id:=inuCOMMISSION_Id;

		if inuLock=1 then
			LockByPk
			(
				inuCOMMISSION_Id,
				rcData
			);
		end if;

		delete
		from LD_commission
		where
       		COMMISSION_Id=inuCOMMISSION_Id;
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
		rcError  styLD_commission;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_commission
		where
			rowid = iriRowID
		returning
   COMMISSION_Id
		into
			rcError.COMMISSION_Id;

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
		iotbLD_commission in out nocopy tytbLD_commission,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_commission;
	BEGIN
		FillRecordOfTables(iotbLD_commission, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_commission.first .. iotbLD_commission.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_commission.first .. iotbLD_commission.last
				delete
				from LD_commission
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_commission.first .. iotbLD_commission.last loop
					LockByPk
					(
							rcRecOfTab.COMMISSION_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_commission.first .. iotbLD_commission.last
				delete
				from LD_commission
				where
		         	COMMISSION_Id = rcRecOfTab.COMMISSION_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_commission in styLD_commission,
		inuLock	  in number default 0
	)
	IS
		nuCOMMISSION_Id LD_commission.COMMISSION_Id%type;

	BEGIN
		if ircLD_commission.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_commission.rowid,rcData);
			end if;
			update LD_commission
			set

        Article_Id = ircLD_commission.Article_Id,
        Sale_Chanel_Id = ircLD_commission.Sale_Chanel_Id,
        Geograp_Location_Id = ircLD_commission.Geograp_Location_Id,
        Contrator_Id = ircLD_commission.Contrator_Id,
        Recovery_Percentage = ircLD_commission.Recovery_Percentage,
        Pyment_Percentage = ircLD_commission.Pyment_Percentage,
        Inclu_Vat_Reco_Commi = ircLD_commission.Inclu_Vat_Reco_Commi,
        Inclu_Vat_Pay_Commi = ircLD_commission.Inclu_Vat_Pay_Commi,
        Initial_Date = ircLD_commission.Initial_Date,
        Line_Id = ircLD_commission.Line_Id,
        Subline_Id = ircLD_commission.Subline_Id,
        Supplier_Id = ircLD_commission.Supplier_Id
			where
				rowid = ircLD_commission.rowid
			returning
    COMMISSION_Id
			into
				nuCOMMISSION_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_commission.COMMISSION_Id,
					rcData
				);
			end if;

			update LD_commission
			set
        Article_Id = ircLD_commission.Article_Id,
        Sale_Chanel_Id = ircLD_commission.Sale_Chanel_Id,
        Geograp_Location_Id = ircLD_commission.Geograp_Location_Id,
        Contrator_Id = ircLD_commission.Contrator_Id,
        Recovery_Percentage = ircLD_commission.Recovery_Percentage,
        Pyment_Percentage = ircLD_commission.Pyment_Percentage,
        Inclu_Vat_Reco_Commi = ircLD_commission.Inclu_Vat_Reco_Commi,
        Inclu_Vat_Pay_Commi = ircLD_commission.Inclu_Vat_Pay_Commi,
        Initial_Date = ircLD_commission.Initial_Date,
        Line_Id = ircLD_commission.Line_Id,
        Subline_Id = ircLD_commission.Subline_Id,
        Supplier_Id = ircLD_commission.Supplier_Id
			where
	         	COMMISSION_Id = ircLD_commission.COMMISSION_Id
			returning
    COMMISSION_Id
			into
				nuCOMMISSION_Id;
		end if;

		if
			nuCOMMISSION_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_commission));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_commission in out nocopy tytbLD_commission,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_commission;
  BEGIN
    FillRecordOfTables(iotbLD_commission,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_commission.first .. iotbLD_commission.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_commission.first .. iotbLD_commission.last
        update LD_commission
        set

            Article_Id = rcRecOfTab.Article_Id(n),
            Sale_Chanel_Id = rcRecOfTab.Sale_Chanel_Id(n),
            Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
            Contrator_Id = rcRecOfTab.Contrator_Id(n),
            Recovery_Percentage = rcRecOfTab.Recovery_Percentage(n),
            Pyment_Percentage = rcRecOfTab.Pyment_Percentage(n),
            Inclu_Vat_Reco_Commi = rcRecOfTab.Inclu_Vat_Reco_Commi(n),
            Inclu_Vat_Pay_Commi = rcRecOfTab.Inclu_Vat_Pay_Commi(n),
            Initial_Date = rcRecOfTab.Initial_Date(n),
            Line_Id = rcRecOfTab.Line_Id(n),
            Subline_Id = rcRecOfTab.Subline_Id(n),
            Supplier_Id = rcRecOfTab.Supplier_Id(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_commission.first .. iotbLD_commission.last loop
          LockByPk
          (
              rcRecOfTab.COMMISSION_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_commission.first .. iotbLD_commission.last
        update LD_commission
        set
					Article_Id = rcRecOfTab.Article_Id(n),
					Sale_Chanel_Id = rcRecOfTab.Sale_Chanel_Id(n),
					Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
					Contrator_Id = rcRecOfTab.Contrator_Id(n),
					Recovery_Percentage = rcRecOfTab.Recovery_Percentage(n),
					Pyment_Percentage = rcRecOfTab.Pyment_Percentage(n),
					Inclu_Vat_Reco_Commi = rcRecOfTab.Inclu_Vat_Reco_Commi(n),
					Inclu_Vat_Pay_Commi = rcRecOfTab.Inclu_Vat_Pay_Commi(n),
					Initial_Date = rcRecOfTab.Initial_Date(n),
					Line_Id = rcRecOfTab.Line_Id(n),
					Subline_Id = rcRecOfTab.Subline_Id(n),
					Supplier_Id = rcRecOfTab.Supplier_Id(n)
          where
          COMMISSION_Id = rcRecOfTab.COMMISSION_Id(n)
;
    end if;
  END;

	PROCEDURE updArticle_Id
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuArticle_Id$ in LD_commission.Article_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_commission;
	BEGIN
		rcError.COMMISSION_Id := inuCOMMISSION_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCOMMISSION_Id,
				rcData
			);
		end if;

		update LD_commission
		set
			Article_Id = inuArticle_Id$
		where
			COMMISSION_Id = inuCOMMISSION_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Article_Id:= inuArticle_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSale_Chanel_Id
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuSale_Chanel_Id$ in LD_commission.Sale_Chanel_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_commission;
	BEGIN
		rcError.COMMISSION_Id := inuCOMMISSION_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCOMMISSION_Id,
				rcData
			);
		end if;

		update LD_commission
		set
			Sale_Chanel_Id = inuSale_Chanel_Id$
		where
			COMMISSION_Id = inuCOMMISSION_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Sale_Chanel_Id:= inuSale_Chanel_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updGeograp_Location_Id
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuGeograp_Location_Id$ in LD_commission.Geograp_Location_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_commission;
	BEGIN
		rcError.COMMISSION_Id := inuCOMMISSION_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCOMMISSION_Id,
				rcData
			);
		end if;

		update LD_commission
		set
			Geograp_Location_Id = inuGeograp_Location_Id$
		where
			COMMISSION_Id = inuCOMMISSION_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Geograp_Location_Id:= inuGeograp_Location_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updContrator_Id
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuContrator_Id$ in LD_commission.Contrator_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_commission;
	BEGIN
		rcError.COMMISSION_Id := inuCOMMISSION_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCOMMISSION_Id,
				rcData
			);
		end if;

		update LD_commission
		set
			Contrator_Id = inuContrator_Id$
		where
			COMMISSION_Id = inuCOMMISSION_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Contrator_Id:= inuContrator_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecovery_Percentage
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuRecovery_Percentage$ in LD_commission.Recovery_Percentage%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_commission;
	BEGIN
		rcError.COMMISSION_Id := inuCOMMISSION_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCOMMISSION_Id,
				rcData
			);
		end if;

		update LD_commission
		set
			Recovery_Percentage = inuRecovery_Percentage$
		where
			COMMISSION_Id = inuCOMMISSION_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Recovery_Percentage:= inuRecovery_Percentage$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPyment_Percentage
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuPyment_Percentage$ in LD_commission.Pyment_Percentage%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_commission;
	BEGIN
		rcError.COMMISSION_Id := inuCOMMISSION_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCOMMISSION_Id,
				rcData
			);
		end if;

		update LD_commission
		set
			Pyment_Percentage = inuPyment_Percentage$
		where
			COMMISSION_Id = inuCOMMISSION_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Pyment_Percentage:= inuPyment_Percentage$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updInclu_Vat_Reco_Commi
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		isbInclu_Vat_Reco_Commi$ in LD_commission.Inclu_Vat_Reco_Commi%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_commission;
	BEGIN
		rcError.COMMISSION_Id := inuCOMMISSION_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCOMMISSION_Id,
				rcData
			);
		end if;

		update LD_commission
		set
			Inclu_Vat_Reco_Commi = isbInclu_Vat_Reco_Commi$
		where
			COMMISSION_Id = inuCOMMISSION_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Inclu_Vat_Reco_Commi:= isbInclu_Vat_Reco_Commi$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updInclu_Vat_Pay_Commi
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		isbInclu_Vat_Pay_Commi$ in LD_commission.Inclu_Vat_Pay_Commi%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_commission;
	BEGIN
		rcError.COMMISSION_Id := inuCOMMISSION_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCOMMISSION_Id,
				rcData
			);
		end if;

		update LD_commission
		set
			Inclu_Vat_Pay_Commi = isbInclu_Vat_Pay_Commi$
		where
			COMMISSION_Id = inuCOMMISSION_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Inclu_Vat_Pay_Commi:= isbInclu_Vat_Pay_Commi$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updInitial_Date
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		idtInitial_Date$ in LD_commission.Initial_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_commission;
	BEGIN
		rcError.COMMISSION_Id := inuCOMMISSION_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCOMMISSION_Id,
				rcData
			);
		end if;

		update LD_commission
		set
			Initial_Date = idtInitial_Date$
		where
			COMMISSION_Id = inuCOMMISSION_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Initial_Date:= idtInitial_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updLine_Id
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuLine_Id$ in LD_commission.Line_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_commission;
	BEGIN
		rcError.COMMISSION_Id := inuCOMMISSION_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCOMMISSION_Id,
				rcData
			);
		end if;

		update LD_commission
		set
			Line_Id = inuLine_Id$
		where
			COMMISSION_Id = inuCOMMISSION_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Line_Id:= inuLine_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSubline_Id
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuSubline_Id$ in LD_commission.Subline_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_commission;
	BEGIN
		rcError.COMMISSION_Id := inuCOMMISSION_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCOMMISSION_Id,
				rcData
			);
		end if;

		update LD_commission
		set
			Subline_Id = inuSubline_Id$
		where
			COMMISSION_Id = inuCOMMISSION_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subline_Id:= inuSubline_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSupplier_Id
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuSupplier_Id$ in LD_commission.Supplier_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_commission;
	BEGIN
		rcError.COMMISSION_Id := inuCOMMISSION_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCOMMISSION_Id,
				rcData
			);
		end if;

		update LD_commission
		set
			Supplier_Id = inuSupplier_Id$
		where
			COMMISSION_Id = inuCOMMISSION_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Supplier_Id:= inuSupplier_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetCommission_Id
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_commission.Commission_Id%type
	IS
		rcError styLD_commission;
	BEGIN

		rcError.COMMISSION_Id := inuCOMMISSION_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCOMMISSION_Id
			 )
		then
			 return(rcData.Commission_Id);
		end if;
		Load
		(
			inuCOMMISSION_Id
		);
		return(rcData.Commission_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetArticle_Id
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_commission.Article_Id%type
	IS
		rcError styLD_commission;
	BEGIN

		rcError.COMMISSION_Id := inuCOMMISSION_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCOMMISSION_Id
			 )
		then
			 return(rcData.Article_Id);
		end if;
		Load
		(
			inuCOMMISSION_Id
		);
		return(rcData.Article_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSale_Chanel_Id
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_commission.Sale_Chanel_Id%type
	IS
		rcError styLD_commission;
	BEGIN

		rcError.COMMISSION_Id := inuCOMMISSION_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCOMMISSION_Id
			 )
		then
			 return(rcData.Sale_Chanel_Id);
		end if;
		Load
		(
			inuCOMMISSION_Id
		);
		return(rcData.Sale_Chanel_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetGeograp_Location_Id
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_commission.Geograp_Location_Id%type
	IS
		rcError styLD_commission;
	BEGIN

		rcError.COMMISSION_Id := inuCOMMISSION_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCOMMISSION_Id
			 )
		then
			 return(rcData.Geograp_Location_Id);
		end if;
		Load
		(
			inuCOMMISSION_Id
		);
		return(rcData.Geograp_Location_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetContrator_Id
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_commission.Contrator_Id%type
	IS
		rcError styLD_commission;
	BEGIN

		rcError.COMMISSION_Id := inuCOMMISSION_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCOMMISSION_Id
			 )
		then
			 return(rcData.Contrator_Id);
		end if;
		Load
		(
			inuCOMMISSION_Id
		);
		return(rcData.Contrator_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetRecovery_Percentage
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_commission.Recovery_Percentage%type
	IS
		rcError styLD_commission;
	BEGIN

		rcError.COMMISSION_Id := inuCOMMISSION_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCOMMISSION_Id
			 )
		then
			 return(rcData.Recovery_Percentage);
		end if;
		Load
		(
			inuCOMMISSION_Id
		);
		return(rcData.Recovery_Percentage);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPyment_Percentage
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_commission.Pyment_Percentage%type
	IS
		rcError styLD_commission;
	BEGIN

		rcError.COMMISSION_Id := inuCOMMISSION_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCOMMISSION_Id
			 )
		then
			 return(rcData.Pyment_Percentage);
		end if;
		Load
		(
			inuCOMMISSION_Id
		);
		return(rcData.Pyment_Percentage);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetInclu_Vat_Reco_Commi
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_commission.Inclu_Vat_Reco_Commi%type
	IS
		rcError styLD_commission;
	BEGIN

		rcError.COMMISSION_Id:=inuCOMMISSION_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCOMMISSION_Id
			 )
		then
			 return(rcData.Inclu_Vat_Reco_Commi);
		end if;
		Load
		(
			inuCOMMISSION_Id
		);
		return(rcData.Inclu_Vat_Reco_Commi);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetInclu_Vat_Pay_Commi
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_commission.Inclu_Vat_Pay_Commi%type
	IS
		rcError styLD_commission;
	BEGIN

		rcError.COMMISSION_Id:=inuCOMMISSION_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCOMMISSION_Id
			 )
		then
			 return(rcData.Inclu_Vat_Pay_Commi);
		end if;
		Load
		(
			inuCOMMISSION_Id
		);
		return(rcData.Inclu_Vat_Pay_Commi);
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
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_commission.Initial_Date%type
	IS
		rcError styLD_commission;
	BEGIN

		rcError.COMMISSION_Id:=inuCOMMISSION_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMMISSION_Id
			 )
		then
			 return(rcData.Initial_Date);
		end if;
		Load
		(
		 		inuCOMMISSION_Id
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

	FUNCTION fnuGetLine_Id
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_commission.Line_Id%type
	IS
		rcError styLD_commission;
	BEGIN

		rcError.COMMISSION_Id := inuCOMMISSION_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCOMMISSION_Id
			 )
		then
			 return(rcData.Line_Id);
		end if;
		Load
		(
			inuCOMMISSION_Id
		);
		return(rcData.Line_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSubline_Id
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_commission.Subline_Id%type
	IS
		rcError styLD_commission;
	BEGIN

		rcError.COMMISSION_Id := inuCOMMISSION_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCOMMISSION_Id
			 )
		then
			 return(rcData.Subline_Id);
		end if;
		Load
		(
			inuCOMMISSION_Id
		);
		return(rcData.Subline_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSupplier_Id
	(
		inuCOMMISSION_Id in LD_commission.COMMISSION_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_commission.Supplier_Id%type
	IS
		rcError styLD_commission;
	BEGIN

		rcError.COMMISSION_Id := inuCOMMISSION_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCOMMISSION_Id
			 )
		then
			 return(rcData.Supplier_Id);
		end if;
		Load
		(
			inuCOMMISSION_Id
		);
		return(rcData.Supplier_Id);
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
end DALD_commission;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_COMMISSION
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_COMMISSION', 'ADM_PERSON'); 
END;
/ 
