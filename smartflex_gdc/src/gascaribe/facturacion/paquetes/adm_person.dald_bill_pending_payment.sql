CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_bill_pending_payment
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
    06/06/2024              PAcosta         OSF-2778: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    
    
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type
  )
  IS
		SELECT LD_bill_pending_payment.*,LD_bill_pending_payment.rowid
		FROM LD_bill_pending_payment
		WHERE
			BILL_PENDING_PAYMENT_Id = inuBILL_PENDING_PAYMENT_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_bill_pending_payment.*,LD_bill_pending_payment.rowid
		FROM LD_bill_pending_payment
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_bill_pending_payment  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_bill_pending_payment is table of styLD_bill_pending_payment index by binary_integer;
	type tyrfRecords is ref cursor return styLD_bill_pending_payment;

	/* Tipos referenciando al registro */
	type tytbBill_Pending_Payment_Id is table of LD_bill_pending_payment.Bill_Pending_Payment_Id%type index by binary_integer;
	type tytbPackage_Id is table of LD_bill_pending_payment.Package_Id%type index by binary_integer;
	type tytbFactcodi is table of LD_bill_pending_payment.Factcodi%type index by binary_integer;
	type tytbRegister_Date is table of LD_bill_pending_payment.Register_Date%type index by binary_integer;
	type tytbPayment is table of LD_bill_pending_payment.Payment%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_bill_pending_payment is record
	(

		Bill_Pending_Payment_Id   tytbBill_Pending_Payment_Id,
		Package_Id   tytbPackage_Id,
		Factcodi   tytbFactcodi,
		Register_Date   tytbRegister_Date,
		Payment   tytbPayment,
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
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type
	);

	PROCEDURE getRecord
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		orcRecord out nocopy styLD_bill_pending_payment
	);

	FUNCTION frcGetRcData
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type
	)
	RETURN styLD_bill_pending_payment;

	FUNCTION frcGetRcData
	RETURN styLD_bill_pending_payment;

	FUNCTION frcGetRecord
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type
	)
	RETURN styLD_bill_pending_payment;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_bill_pending_payment
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_bill_pending_payment in styLD_bill_pending_payment
	);

 	  PROCEDURE insRecord
	(
		ircLD_bill_pending_payment in styLD_bill_pending_payment,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_bill_pending_payment in out nocopy tytbLD_bill_pending_payment
	);

	PROCEDURE delRecord
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_bill_pending_payment in out nocopy tytbLD_bill_pending_payment,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_bill_pending_payment in styLD_bill_pending_payment,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_bill_pending_payment in out nocopy tytbLD_bill_pending_payment,
		inuLock in number default 1
	);

		PROCEDURE updPackage_Id
		(
				inuBILL_PENDING_PAYMENT_Id   in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
				inuPackage_Id$  in LD_bill_pending_payment.Package_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updFactcodi
		(
				inuBILL_PENDING_PAYMENT_Id   in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
				inuFactcodi$  in LD_bill_pending_payment.Factcodi%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updRegister_Date
		(
				inuBILL_PENDING_PAYMENT_Id   in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
				idtRegister_Date$  in LD_bill_pending_payment.Register_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updPayment
		(
				inuBILL_PENDING_PAYMENT_Id   in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
				isbPayment$  in LD_bill_pending_payment.Payment%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetBill_Pending_Payment_Id
    	(
    	    inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bill_pending_payment.Bill_Pending_Payment_Id%type;

    	FUNCTION fnuGetPackage_Id
    	(
    	    inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bill_pending_payment.Package_Id%type;

    	FUNCTION fnuGetFactcodi
    	(
    	    inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bill_pending_payment.Factcodi%type;

    	FUNCTION fdtGetRegister_Date
    	(
    	    inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_bill_pending_payment.Register_Date%type;

    	FUNCTION fsbGetPayment
    	(
    	    inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bill_pending_payment.Payment%type;


	PROCEDURE LockByPk
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		orcLD_bill_pending_payment  out styLD_bill_pending_payment
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_bill_pending_payment  out styLD_bill_pending_payment
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_bill_pending_payment;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_bill_pending_payment
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_BILL_PENDING_PAYMENT';
	  cnuGeEntityId constant varchar2(30) := 8357; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type
	)
	IS
		SELECT LD_bill_pending_payment.*,LD_bill_pending_payment.rowid
		FROM LD_bill_pending_payment
		WHERE  BILL_PENDING_PAYMENT_Id = inuBILL_PENDING_PAYMENT_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_bill_pending_payment.*,LD_bill_pending_payment.rowid
		FROM LD_bill_pending_payment
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_bill_pending_payment is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_bill_pending_payment;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_bill_pending_payment default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.BILL_PENDING_PAYMENT_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		orcLD_bill_pending_payment  out styLD_bill_pending_payment
	)
	IS
		rcError styLD_bill_pending_payment;
	BEGIN
		rcError.BILL_PENDING_PAYMENT_Id := inuBILL_PENDING_PAYMENT_Id;

		Open cuLockRcByPk
		(
			inuBILL_PENDING_PAYMENT_Id
		);

		fetch cuLockRcByPk into orcLD_bill_pending_payment;
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
		orcLD_bill_pending_payment  out styLD_bill_pending_payment
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_bill_pending_payment;
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
		itbLD_bill_pending_payment  in out nocopy tytbLD_bill_pending_payment
	)
	IS
	BEGIN
			rcRecOfTab.Bill_Pending_Payment_Id.delete;
			rcRecOfTab.Package_Id.delete;
			rcRecOfTab.Factcodi.delete;
			rcRecOfTab.Register_Date.delete;
			rcRecOfTab.Payment.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_bill_pending_payment  in out nocopy tytbLD_bill_pending_payment,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_bill_pending_payment);
		for n in itbLD_bill_pending_payment.first .. itbLD_bill_pending_payment.last loop
			rcRecOfTab.Bill_Pending_Payment_Id(n) := itbLD_bill_pending_payment(n).Bill_Pending_Payment_Id;
			rcRecOfTab.Package_Id(n) := itbLD_bill_pending_payment(n).Package_Id;
			rcRecOfTab.Factcodi(n) := itbLD_bill_pending_payment(n).Factcodi;
			rcRecOfTab.Register_Date(n) := itbLD_bill_pending_payment(n).Register_Date;
			rcRecOfTab.Payment(n) := itbLD_bill_pending_payment(n).Payment;
			rcRecOfTab.row_id(n) := itbLD_bill_pending_payment(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuBILL_PENDING_PAYMENT_Id
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
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuBILL_PENDING_PAYMENT_Id = rcData.BILL_PENDING_PAYMENT_Id
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
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuBILL_PENDING_PAYMENT_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type
	)
	IS
		rcError styLD_bill_pending_payment;
	BEGIN		rcError.BILL_PENDING_PAYMENT_Id:=inuBILL_PENDING_PAYMENT_Id;

		Load
		(
			inuBILL_PENDING_PAYMENT_Id
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
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuBILL_PENDING_PAYMENT_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		orcRecord out nocopy styLD_bill_pending_payment
	)
	IS
		rcError styLD_bill_pending_payment;
	BEGIN		rcError.BILL_PENDING_PAYMENT_Id:=inuBILL_PENDING_PAYMENT_Id;

		Load
		(
			inuBILL_PENDING_PAYMENT_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type
	)
	RETURN styLD_bill_pending_payment
	IS
		rcError styLD_bill_pending_payment;
	BEGIN
		rcError.BILL_PENDING_PAYMENT_Id:=inuBILL_PENDING_PAYMENT_Id;

		Load
		(
			inuBILL_PENDING_PAYMENT_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type
	)
	RETURN styLD_bill_pending_payment
	IS
		rcError styLD_bill_pending_payment;
	BEGIN
		rcError.BILL_PENDING_PAYMENT_Id:=inuBILL_PENDING_PAYMENT_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBILL_PENDING_PAYMENT_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuBILL_PENDING_PAYMENT_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_bill_pending_payment
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_bill_pending_payment
	)
	IS
		rfLD_bill_pending_payment tyrfLD_bill_pending_payment;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_bill_pending_payment.Bill_Pending_Payment_Id,
		            LD_bill_pending_payment.Package_Id,
		            LD_bill_pending_payment.Factcodi,
		            LD_bill_pending_payment.Register_Date,
		            LD_bill_pending_payment.Payment,
		            LD_bill_pending_payment.rowid
                FROM LD_bill_pending_payment';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_bill_pending_payment for sbFullQuery;
		fetch rfLD_bill_pending_payment bulk collect INTO otbResult;
		close rfLD_bill_pending_payment;
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
		            LD_bill_pending_payment.Bill_Pending_Payment_Id,
		            LD_bill_pending_payment.Package_Id,
		            LD_bill_pending_payment.Factcodi,
		            LD_bill_pending_payment.Register_Date,
		            LD_bill_pending_payment.Payment,
		            LD_bill_pending_payment.rowid
                FROM LD_bill_pending_payment';
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
		ircLD_bill_pending_payment in styLD_bill_pending_payment
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_bill_pending_payment,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_bill_pending_payment in styLD_bill_pending_payment,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_bill_pending_payment.BILL_PENDING_PAYMENT_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|BILL_PENDING_PAYMENT_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_bill_pending_payment
		(
			Bill_Pending_Payment_Id,
			Package_Id,
			Factcodi,
			Register_Date,
			Payment
		)
		values
		(
			ircLD_bill_pending_payment.Bill_Pending_Payment_Id,
			ircLD_bill_pending_payment.Package_Id,
			ircLD_bill_pending_payment.Factcodi,
			ircLD_bill_pending_payment.Register_Date,
			ircLD_bill_pending_payment.Payment
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_bill_pending_payment));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_bill_pending_payment in out nocopy tytbLD_bill_pending_payment
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_bill_pending_payment, blUseRowID);
		forall n in iotbLD_bill_pending_payment.first..iotbLD_bill_pending_payment.last
			insert into LD_bill_pending_payment
			(
			Bill_Pending_Payment_Id,
			Package_Id,
			Factcodi,
			Register_Date,
			Payment
		)
		values
		(
			rcRecOfTab.Bill_Pending_Payment_Id(n),
			rcRecOfTab.Package_Id(n),
			rcRecOfTab.Factcodi(n),
			rcRecOfTab.Register_Date(n),
			rcRecOfTab.Payment(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_bill_pending_payment;
	BEGIN
		rcError.BILL_PENDING_PAYMENT_Id:=inuBILL_PENDING_PAYMENT_Id;

		if inuLock=1 then
			LockByPk
			(
				inuBILL_PENDING_PAYMENT_Id,
				rcData
			);
		end if;

		delete
		from LD_bill_pending_payment
		where
       		BILL_PENDING_PAYMENT_Id=inuBILL_PENDING_PAYMENT_Id;
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
		rcError  styLD_bill_pending_payment;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_bill_pending_payment
		where
			rowid = iriRowID
		returning
   BILL_PENDING_PAYMENT_Id
		into
			rcError.BILL_PENDING_PAYMENT_Id;

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
		iotbLD_bill_pending_payment in out nocopy tytbLD_bill_pending_payment,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_bill_pending_payment;
	BEGIN
		FillRecordOfTables(iotbLD_bill_pending_payment, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_bill_pending_payment.first .. iotbLD_bill_pending_payment.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_bill_pending_payment.first .. iotbLD_bill_pending_payment.last
				delete
				from LD_bill_pending_payment
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_bill_pending_payment.first .. iotbLD_bill_pending_payment.last loop
					LockByPk
					(
							rcRecOfTab.BILL_PENDING_PAYMENT_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_bill_pending_payment.first .. iotbLD_bill_pending_payment.last
				delete
				from LD_bill_pending_payment
				where
		         	BILL_PENDING_PAYMENT_Id = rcRecOfTab.BILL_PENDING_PAYMENT_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_bill_pending_payment in styLD_bill_pending_payment,
		inuLock	  in number default 0
	)
	IS
		nuBILL_PENDING_PAYMENT_Id LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type;

	BEGIN
		if ircLD_bill_pending_payment.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_bill_pending_payment.rowid,rcData);
			end if;
			update LD_bill_pending_payment
			set

        Package_Id = ircLD_bill_pending_payment.Package_Id,
        Factcodi = ircLD_bill_pending_payment.Factcodi,
        Register_Date = ircLD_bill_pending_payment.Register_Date,
        Payment = ircLD_bill_pending_payment.Payment
			where
				rowid = ircLD_bill_pending_payment.rowid
			returning
    BILL_PENDING_PAYMENT_Id
			into
				nuBILL_PENDING_PAYMENT_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_bill_pending_payment.BILL_PENDING_PAYMENT_Id,
					rcData
				);
			end if;

			update LD_bill_pending_payment
			set
        Package_Id = ircLD_bill_pending_payment.Package_Id,
        Factcodi = ircLD_bill_pending_payment.Factcodi,
        Register_Date = ircLD_bill_pending_payment.Register_Date,
        Payment = ircLD_bill_pending_payment.Payment
			where
	         	BILL_PENDING_PAYMENT_Id = ircLD_bill_pending_payment.BILL_PENDING_PAYMENT_Id
			returning
    BILL_PENDING_PAYMENT_Id
			into
				nuBILL_PENDING_PAYMENT_Id;
		end if;

		if
			nuBILL_PENDING_PAYMENT_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_bill_pending_payment));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_bill_pending_payment in out nocopy tytbLD_bill_pending_payment,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_bill_pending_payment;
  BEGIN
    FillRecordOfTables(iotbLD_bill_pending_payment,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_bill_pending_payment.first .. iotbLD_bill_pending_payment.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_bill_pending_payment.first .. iotbLD_bill_pending_payment.last
        update LD_bill_pending_payment
        set

            Package_Id = rcRecOfTab.Package_Id(n),
            Factcodi = rcRecOfTab.Factcodi(n),
            Register_Date = rcRecOfTab.Register_Date(n),
            Payment = rcRecOfTab.Payment(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_bill_pending_payment.first .. iotbLD_bill_pending_payment.last loop
          LockByPk
          (
              rcRecOfTab.BILL_PENDING_PAYMENT_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_bill_pending_payment.first .. iotbLD_bill_pending_payment.last
        update LD_bill_pending_payment
        set
					Package_Id = rcRecOfTab.Package_Id(n),
					Factcodi = rcRecOfTab.Factcodi(n),
					Register_Date = rcRecOfTab.Register_Date(n),
					Payment = rcRecOfTab.Payment(n)
          where
          BILL_PENDING_PAYMENT_Id = rcRecOfTab.BILL_PENDING_PAYMENT_Id(n)
;
    end if;
  END;

	PROCEDURE updPackage_Id
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		inuPackage_Id$ in LD_bill_pending_payment.Package_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bill_pending_payment;
	BEGIN
		rcError.BILL_PENDING_PAYMENT_Id := inuBILL_PENDING_PAYMENT_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBILL_PENDING_PAYMENT_Id,
				rcData
			);
		end if;

		update LD_bill_pending_payment
		set
			Package_Id = inuPackage_Id$
		where
			BILL_PENDING_PAYMENT_Id = inuBILL_PENDING_PAYMENT_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Package_Id:= inuPackage_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updFactcodi
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		inuFactcodi$ in LD_bill_pending_payment.Factcodi%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bill_pending_payment;
	BEGIN
		rcError.BILL_PENDING_PAYMENT_Id := inuBILL_PENDING_PAYMENT_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBILL_PENDING_PAYMENT_Id,
				rcData
			);
		end if;

		update LD_bill_pending_payment
		set
			Factcodi = inuFactcodi$
		where
			BILL_PENDING_PAYMENT_Id = inuBILL_PENDING_PAYMENT_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Factcodi:= inuFactcodi$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRegister_Date
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		idtRegister_Date$ in LD_bill_pending_payment.Register_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bill_pending_payment;
	BEGIN
		rcError.BILL_PENDING_PAYMENT_Id := inuBILL_PENDING_PAYMENT_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBILL_PENDING_PAYMENT_Id,
				rcData
			);
		end if;

		update LD_bill_pending_payment
		set
			Register_Date = idtRegister_Date$
		where
			BILL_PENDING_PAYMENT_Id = inuBILL_PENDING_PAYMENT_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Register_Date:= idtRegister_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPayment
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		isbPayment$ in LD_bill_pending_payment.Payment%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bill_pending_payment;
	BEGIN
		rcError.BILL_PENDING_PAYMENT_Id := inuBILL_PENDING_PAYMENT_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBILL_PENDING_PAYMENT_Id,
				rcData
			);
		end if;

		update LD_bill_pending_payment
		set
			Payment = isbPayment$
		where
			BILL_PENDING_PAYMENT_Id = inuBILL_PENDING_PAYMENT_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Payment:= isbPayment$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetBill_Pending_Payment_Id
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bill_pending_payment.Bill_Pending_Payment_Id%type
	IS
		rcError styLD_bill_pending_payment;
	BEGIN

		rcError.BILL_PENDING_PAYMENT_Id := inuBILL_PENDING_PAYMENT_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBILL_PENDING_PAYMENT_Id
			 )
		then
			 return(rcData.Bill_Pending_Payment_Id);
		end if;
		Load
		(
			inuBILL_PENDING_PAYMENT_Id
		);
		return(rcData.Bill_Pending_Payment_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPackage_Id
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bill_pending_payment.Package_Id%type
	IS
		rcError styLD_bill_pending_payment;
	BEGIN

		rcError.BILL_PENDING_PAYMENT_Id := inuBILL_PENDING_PAYMENT_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBILL_PENDING_PAYMENT_Id
			 )
		then
			 return(rcData.Package_Id);
		end if;
		Load
		(
			inuBILL_PENDING_PAYMENT_Id
		);
		return(rcData.Package_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetFactcodi
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bill_pending_payment.Factcodi%type
	IS
		rcError styLD_bill_pending_payment;
	BEGIN

		rcError.BILL_PENDING_PAYMENT_Id := inuBILL_PENDING_PAYMENT_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBILL_PENDING_PAYMENT_Id
			 )
		then
			 return(rcData.Factcodi);
		end if;
		Load
		(
			inuBILL_PENDING_PAYMENT_Id
		);
		return(rcData.Factcodi);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetRegister_Date
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bill_pending_payment.Register_Date%type
	IS
		rcError styLD_bill_pending_payment;
	BEGIN

		rcError.BILL_PENDING_PAYMENT_Id:=inuBILL_PENDING_PAYMENT_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBILL_PENDING_PAYMENT_Id
			 )
		then
			 return(rcData.Register_Date);
		end if;
		Load
		(
		 		inuBILL_PENDING_PAYMENT_Id
		);
		return(rcData.Register_Date);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetPayment
	(
		inuBILL_PENDING_PAYMENT_Id in LD_bill_pending_payment.BILL_PENDING_PAYMENT_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bill_pending_payment.Payment%type
	IS
		rcError styLD_bill_pending_payment;
	BEGIN

		rcError.BILL_PENDING_PAYMENT_Id:=inuBILL_PENDING_PAYMENT_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBILL_PENDING_PAYMENT_Id
			 )
		then
			 return(rcData.Payment);
		end if;
		Load
		(
			inuBILL_PENDING_PAYMENT_Id
		);
		return(rcData.Payment);
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
end DALD_bill_pending_payment;
/
PROMPT Otorgando permisos de ejecucion a DALD_BILL_PENDING_PAYMENT
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_BILL_PENDING_PAYMENT', 'ADM_PERSON');
END;
/