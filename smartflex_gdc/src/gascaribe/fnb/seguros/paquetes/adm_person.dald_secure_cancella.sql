CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_secure_cancella
is  
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_secure_cancella
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    31/05/2024              PAcosta         OSF-2767: Cambio de esquema ADM_PERSON                                              
    ****************************************************************/     
    
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type
  )
  IS
		SELECT LD_secure_cancella.*,LD_secure_cancella.rowid
		FROM LD_secure_cancella
		WHERE
			secure_cancella_Id = inusecure_cancella_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_secure_cancella.*,LD_secure_cancella.rowid
		FROM LD_secure_cancella
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_secure_cancella  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_secure_cancella is table of styLD_secure_cancella index by binary_integer;
	type tyrfRecords is ref cursor return styLD_secure_cancella;

	/* Tipos referenciando al registro */
	type tytbSecure_Cancella_Id is table of LD_secure_cancella.Secure_Cancella_Id%type index by binary_integer;
	type tytbPolicy_Id is table of LD_secure_cancella.Policy_Id%type index by binary_integer;
	type tytbContract_Id is table of LD_secure_cancella.Contract_Id%type index by binary_integer;
	type tytbIdentification_Id is table of LD_secure_cancella.Identification_Id%type index by binary_integer;
	type tytbName_Insured is table of LD_secure_cancella.Name_Insured%type index by binary_integer;
	type tytbCancel_Causal_Id is table of LD_secure_cancella.Cancel_Causal_Id%type index by binary_integer;
	type tytbComments is table of LD_secure_cancella.Comments%type index by binary_integer;
	type tytbProduct_Line_Id is table of LD_secure_cancella.Product_Line_Id%type index by binary_integer;
	type tytbType_Cancel is table of LD_secure_cancella.Type_Cancel%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_secure_cancella is record
	(

		Secure_Cancella_Id   tytbSecure_Cancella_Id,
		Policy_Id   tytbPolicy_Id,
		Contract_Id   tytbContract_Id,
		Identification_Id   tytbIdentification_Id,
		Name_Insured   tytbName_Insured,
		Cancel_Causal_Id   tytbCancel_Causal_Id,
		Comments   tytbComments,
		Product_Line_Id   tytbProduct_Line_Id,
		Type_Cancel   tytbType_Cancel,
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
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type
	);

	PROCEDURE getRecord
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		orcRecord out nocopy styLD_secure_cancella
	);

	FUNCTION frcGetRcData
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type
	)
	RETURN styLD_secure_cancella;

	FUNCTION frcGetRcData
	RETURN styLD_secure_cancella;

	FUNCTION frcGetRecord
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type
	)
	RETURN styLD_secure_cancella;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_secure_cancella
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_secure_cancella in styLD_secure_cancella
	);

 	  PROCEDURE insRecord
	(
		ircLD_secure_cancella in styLD_secure_cancella,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_secure_cancella in out nocopy tytbLD_secure_cancella
	);

	PROCEDURE delRecord
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_secure_cancella in out nocopy tytbLD_secure_cancella,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_secure_cancella in styLD_secure_cancella,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_secure_cancella in out nocopy tytbLD_secure_cancella,
		inuLock in number default 1
	);

		PROCEDURE updPolicy_Id
		(
				inusecure_cancella_Id   in LD_secure_cancella.secure_cancella_Id%type,
				inuPolicy_Id$  in LD_secure_cancella.Policy_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updContract_Id
		(
				inusecure_cancella_Id   in LD_secure_cancella.secure_cancella_Id%type,
				inuContract_Id$  in LD_secure_cancella.Contract_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updIdentification_Id
		(
				inusecure_cancella_Id   in LD_secure_cancella.secure_cancella_Id%type,
				inuIdentification_Id$  in LD_secure_cancella.Identification_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updName_Insured
		(
				inusecure_cancella_Id   in LD_secure_cancella.secure_cancella_Id%type,
				isbName_Insured$  in LD_secure_cancella.Name_Insured%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCancel_Causal_Id
		(
				inusecure_cancella_Id   in LD_secure_cancella.secure_cancella_Id%type,
				inuCancel_Causal_Id$  in LD_secure_cancella.Cancel_Causal_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updComments
		(
				inusecure_cancella_Id   in LD_secure_cancella.secure_cancella_Id%type,
				isbComments$  in LD_secure_cancella.Comments%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updProduct_Line_Id
		(
				inusecure_cancella_Id   in LD_secure_cancella.secure_cancella_Id%type,
				inuProduct_Line_Id$  in LD_secure_cancella.Product_Line_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updType_Cancel
		(
				inusecure_cancella_Id   in LD_secure_cancella.secure_cancella_Id%type,
				isbType_Cancel$  in LD_secure_cancella.Type_Cancel%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetSecure_Cancella_Id
    	(
    	    inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_secure_cancella.Secure_Cancella_Id%type;

    	FUNCTION fnuGetPolicy_Id
    	(
    	    inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_secure_cancella.Policy_Id%type;

    	FUNCTION fnuGetContract_Id
    	(
    	    inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_secure_cancella.Contract_Id%type;

    	FUNCTION fnuGetIdentification_Id
    	(
    	    inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_secure_cancella.Identification_Id%type;

    	FUNCTION fsbGetName_Insured
    	(
    	    inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_secure_cancella.Name_Insured%type;

    	FUNCTION fnuGetCancel_Causal_Id
    	(
    	    inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_secure_cancella.Cancel_Causal_Id%type;

    	FUNCTION fsbGetComments
    	(
    	    inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_secure_cancella.Comments%type;

    	FUNCTION fnuGetProduct_Line_Id
    	(
    	    inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_secure_cancella.Product_Line_Id%type;

    	FUNCTION fsbGetType_Cancel
    	(
    	    inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_secure_cancella.Type_Cancel%type;


	PROCEDURE LockByPk
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		orcLD_secure_cancella  out styLD_secure_cancella
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_secure_cancella  out styLD_secure_cancella
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_secure_cancella;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_secure_cancella
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO147879';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SECURE_CANCELLA';
	  cnuGeEntityId constant varchar2(30) := 8482; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type
	)
	IS
		SELECT LD_secure_cancella.*,LD_secure_cancella.rowid
		FROM LD_secure_cancella
		WHERE  secure_cancella_Id = inusecure_cancella_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_secure_cancella.*,LD_secure_cancella.rowid
		FROM LD_secure_cancella
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_secure_cancella is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_secure_cancella;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_secure_cancella default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.secure_cancella_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		orcLD_secure_cancella  out styLD_secure_cancella
	)
	IS
		rcError styLD_secure_cancella;
	BEGIN
		rcError.secure_cancella_Id := inusecure_cancella_Id;

		Open cuLockRcByPk
		(
			inusecure_cancella_Id
		);

		fetch cuLockRcByPk into orcLD_secure_cancella;
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
		orcLD_secure_cancella  out styLD_secure_cancella
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_secure_cancella;
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
		itbLD_secure_cancella  in out nocopy tytbLD_secure_cancella
	)
	IS
	BEGIN
			rcRecOfTab.Secure_Cancella_Id.delete;
			rcRecOfTab.Policy_Id.delete;
			rcRecOfTab.Contract_Id.delete;
			rcRecOfTab.Identification_Id.delete;
			rcRecOfTab.Name_Insured.delete;
			rcRecOfTab.Cancel_Causal_Id.delete;
			rcRecOfTab.Comments.delete;
			rcRecOfTab.Product_Line_Id.delete;
			rcRecOfTab.Type_Cancel.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_secure_cancella  in out nocopy tytbLD_secure_cancella,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_secure_cancella);
		for n in itbLD_secure_cancella.first .. itbLD_secure_cancella.last loop
			rcRecOfTab.Secure_Cancella_Id(n) := itbLD_secure_cancella(n).Secure_Cancella_Id;
			rcRecOfTab.Policy_Id(n) := itbLD_secure_cancella(n).Policy_Id;
			rcRecOfTab.Contract_Id(n) := itbLD_secure_cancella(n).Contract_Id;
			rcRecOfTab.Identification_Id(n) := itbLD_secure_cancella(n).Identification_Id;
			rcRecOfTab.Name_Insured(n) := itbLD_secure_cancella(n).Name_Insured;
			rcRecOfTab.Cancel_Causal_Id(n) := itbLD_secure_cancella(n).Cancel_Causal_Id;
			rcRecOfTab.Comments(n) := itbLD_secure_cancella(n).Comments;
			rcRecOfTab.Product_Line_Id(n) := itbLD_secure_cancella(n).Product_Line_Id;
			rcRecOfTab.Type_Cancel(n) := itbLD_secure_cancella(n).Type_Cancel;
			rcRecOfTab.row_id(n) := itbLD_secure_cancella(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inusecure_cancella_Id
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
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inusecure_cancella_Id = rcData.secure_cancella_Id
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
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inusecure_cancella_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type
	)
	IS
		rcError styLD_secure_cancella;
	BEGIN		rcError.secure_cancella_Id:=inusecure_cancella_Id;

		Load
		(
			inusecure_cancella_Id
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
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type
	)
	IS
	BEGIN
		Load
		(
			inusecure_cancella_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		orcRecord out nocopy styLD_secure_cancella
	)
	IS
		rcError styLD_secure_cancella;
	BEGIN		rcError.secure_cancella_Id:=inusecure_cancella_Id;

		Load
		(
			inusecure_cancella_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type
	)
	RETURN styLD_secure_cancella
	IS
		rcError styLD_secure_cancella;
	BEGIN
		rcError.secure_cancella_Id:=inusecure_cancella_Id;

		Load
		(
			inusecure_cancella_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type
	)
	RETURN styLD_secure_cancella
	IS
		rcError styLD_secure_cancella;
	BEGIN
		rcError.secure_cancella_Id:=inusecure_cancella_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inusecure_cancella_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inusecure_cancella_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_secure_cancella
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_secure_cancella
	)
	IS
		rfLD_secure_cancella tyrfLD_secure_cancella;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_secure_cancella.Secure_Cancella_Id,
		            LD_secure_cancella.Policy_Id,
		            LD_secure_cancella.Contract_Id,
		            LD_secure_cancella.Identification_Id,
		            LD_secure_cancella.Name_Insured,
		            LD_secure_cancella.Cancel_Causal_Id,
		            LD_secure_cancella.Comments,
		            LD_secure_cancella.Product_Line_Id,
		            LD_secure_cancella.Type_Cancel,
		            LD_secure_cancella.rowid
                FROM LD_secure_cancella';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_secure_cancella for sbFullQuery;
		fetch rfLD_secure_cancella bulk collect INTO otbResult;
		close rfLD_secure_cancella;
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
		            LD_secure_cancella.Secure_Cancella_Id,
		            LD_secure_cancella.Policy_Id,
		            LD_secure_cancella.Contract_Id,
		            LD_secure_cancella.Identification_Id,
		            LD_secure_cancella.Name_Insured,
		            LD_secure_cancella.Cancel_Causal_Id,
		            LD_secure_cancella.Comments,
		            LD_secure_cancella.Product_Line_Id,
		            LD_secure_cancella.Type_Cancel,
		            LD_secure_cancella.rowid
                FROM LD_secure_cancella';
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
		ircLD_secure_cancella in styLD_secure_cancella
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_secure_cancella,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_secure_cancella in styLD_secure_cancella,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_secure_cancella.secure_cancella_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|secure_cancella_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_secure_cancella
		(
			Secure_Cancella_Id,
			Policy_Id,
			Contract_Id,
			Identification_Id,
			Name_Insured,
			Cancel_Causal_Id,
			Comments,
			Product_Line_Id,
			Type_Cancel
		)
		values
		(
			ircLD_secure_cancella.Secure_Cancella_Id,
			ircLD_secure_cancella.Policy_Id,
			ircLD_secure_cancella.Contract_Id,
			ircLD_secure_cancella.Identification_Id,
			ircLD_secure_cancella.Name_Insured,
			ircLD_secure_cancella.Cancel_Causal_Id,
			ircLD_secure_cancella.Comments,
			ircLD_secure_cancella.Product_Line_Id,
			ircLD_secure_cancella.Type_Cancel
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_secure_cancella));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_secure_cancella in out nocopy tytbLD_secure_cancella
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_secure_cancella, blUseRowID);
		forall n in iotbLD_secure_cancella.first..iotbLD_secure_cancella.last
			insert into LD_secure_cancella
			(
			Secure_Cancella_Id,
			Policy_Id,
			Contract_Id,
			Identification_Id,
			Name_Insured,
			Cancel_Causal_Id,
			Comments,
			Product_Line_Id,
			Type_Cancel
		)
		values
		(
			rcRecOfTab.Secure_Cancella_Id(n),
			rcRecOfTab.Policy_Id(n),
			rcRecOfTab.Contract_Id(n),
			rcRecOfTab.Identification_Id(n),
			rcRecOfTab.Name_Insured(n),
			rcRecOfTab.Cancel_Causal_Id(n),
			rcRecOfTab.Comments(n),
			rcRecOfTab.Product_Line_Id(n),
			rcRecOfTab.Type_Cancel(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_secure_cancella;
	BEGIN
		rcError.secure_cancella_Id:=inusecure_cancella_Id;

		if inuLock=1 then
			LockByPk
			(
				inusecure_cancella_Id,
				rcData
			);
		end if;

		delete
		from LD_secure_cancella
		where
       		secure_cancella_Id=inusecure_cancella_Id;
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
		rcError  styLD_secure_cancella;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_secure_cancella
		where
			rowid = iriRowID
		returning
   secure_cancella_Id
		into
			rcError.secure_cancella_Id;

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
		iotbLD_secure_cancella in out nocopy tytbLD_secure_cancella,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_secure_cancella;
	BEGIN
		FillRecordOfTables(iotbLD_secure_cancella, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_secure_cancella.first .. iotbLD_secure_cancella.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_secure_cancella.first .. iotbLD_secure_cancella.last
				delete
				from LD_secure_cancella
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_secure_cancella.first .. iotbLD_secure_cancella.last loop
					LockByPk
					(
							rcRecOfTab.secure_cancella_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_secure_cancella.first .. iotbLD_secure_cancella.last
				delete
				from LD_secure_cancella
				where
		         	secure_cancella_Id = rcRecOfTab.secure_cancella_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_secure_cancella in styLD_secure_cancella,
		inuLock	  in number default 0
	)
	IS
		nusecure_cancella_Id LD_secure_cancella.secure_cancella_Id%type;

	BEGIN
		if ircLD_secure_cancella.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_secure_cancella.rowid,rcData);
			end if;
			update LD_secure_cancella
			set

        Policy_Id = ircLD_secure_cancella.Policy_Id,
        Contract_Id = ircLD_secure_cancella.Contract_Id,
        Identification_Id = ircLD_secure_cancella.Identification_Id,
        Name_Insured = ircLD_secure_cancella.Name_Insured,
        Cancel_Causal_Id = ircLD_secure_cancella.Cancel_Causal_Id,
        Comments = ircLD_secure_cancella.Comments,
        Product_Line_Id = ircLD_secure_cancella.Product_Line_Id,
        Type_Cancel = ircLD_secure_cancella.Type_Cancel
			where
				rowid = ircLD_secure_cancella.rowid
			returning
    secure_cancella_Id
			into
				nusecure_cancella_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_secure_cancella.secure_cancella_Id,
					rcData
				);
			end if;

			update LD_secure_cancella
			set
        Policy_Id = ircLD_secure_cancella.Policy_Id,
        Contract_Id = ircLD_secure_cancella.Contract_Id,
        Identification_Id = ircLD_secure_cancella.Identification_Id,
        Name_Insured = ircLD_secure_cancella.Name_Insured,
        Cancel_Causal_Id = ircLD_secure_cancella.Cancel_Causal_Id,
        Comments = ircLD_secure_cancella.Comments,
        Product_Line_Id = ircLD_secure_cancella.Product_Line_Id,
        Type_Cancel = ircLD_secure_cancella.Type_Cancel
			where
	         	secure_cancella_Id = ircLD_secure_cancella.secure_cancella_Id
			returning
    secure_cancella_Id
			into
				nusecure_cancella_Id;
		end if;

		if
			nusecure_cancella_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_secure_cancella));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_secure_cancella in out nocopy tytbLD_secure_cancella,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_secure_cancella;
  BEGIN
    FillRecordOfTables(iotbLD_secure_cancella,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_secure_cancella.first .. iotbLD_secure_cancella.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_secure_cancella.first .. iotbLD_secure_cancella.last
        update LD_secure_cancella
        set

            Policy_Id = rcRecOfTab.Policy_Id(n),
            Contract_Id = rcRecOfTab.Contract_Id(n),
            Identification_Id = rcRecOfTab.Identification_Id(n),
            Name_Insured = rcRecOfTab.Name_Insured(n),
            Cancel_Causal_Id = rcRecOfTab.Cancel_Causal_Id(n),
            Comments = rcRecOfTab.Comments(n),
            Product_Line_Id = rcRecOfTab.Product_Line_Id(n),
            Type_Cancel = rcRecOfTab.Type_Cancel(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_secure_cancella.first .. iotbLD_secure_cancella.last loop
          LockByPk
          (
              rcRecOfTab.secure_cancella_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_secure_cancella.first .. iotbLD_secure_cancella.last
        update LD_secure_cancella
        set
					Policy_Id = rcRecOfTab.Policy_Id(n),
					Contract_Id = rcRecOfTab.Contract_Id(n),
					Identification_Id = rcRecOfTab.Identification_Id(n),
					Name_Insured = rcRecOfTab.Name_Insured(n),
					Cancel_Causal_Id = rcRecOfTab.Cancel_Causal_Id(n),
					Comments = rcRecOfTab.Comments(n),
					Product_Line_Id = rcRecOfTab.Product_Line_Id(n),
					Type_Cancel = rcRecOfTab.Type_Cancel(n)
          where
          secure_cancella_Id = rcRecOfTab.secure_cancella_Id(n)
;
    end if;
  END;

	PROCEDURE updPolicy_Id
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		inuPolicy_Id$ in LD_secure_cancella.Policy_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_secure_cancella;
	BEGIN
		rcError.secure_cancella_Id := inusecure_cancella_Id;
		if inuLock=1 then
			LockByPk
			(
				inusecure_cancella_Id,
				rcData
			);
		end if;

		update LD_secure_cancella
		set
			Policy_Id = inuPolicy_Id$
		where
			secure_cancella_Id = inusecure_cancella_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Policy_Id:= inuPolicy_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updContract_Id
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		inuContract_Id$ in LD_secure_cancella.Contract_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_secure_cancella;
	BEGIN
		rcError.secure_cancella_Id := inusecure_cancella_Id;
		if inuLock=1 then
			LockByPk
			(
				inusecure_cancella_Id,
				rcData
			);
		end if;

		update LD_secure_cancella
		set
			Contract_Id = inuContract_Id$
		where
			secure_cancella_Id = inusecure_cancella_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Contract_Id:= inuContract_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updIdentification_Id
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		inuIdentification_Id$ in LD_secure_cancella.Identification_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_secure_cancella;
	BEGIN
		rcError.secure_cancella_Id := inusecure_cancella_Id;
		if inuLock=1 then
			LockByPk
			(
				inusecure_cancella_Id,
				rcData
			);
		end if;

		update LD_secure_cancella
		set
			Identification_Id = inuIdentification_Id$
		where
			secure_cancella_Id = inusecure_cancella_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Identification_Id:= inuIdentification_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updName_Insured
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		isbName_Insured$ in LD_secure_cancella.Name_Insured%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_secure_cancella;
	BEGIN
		rcError.secure_cancella_Id := inusecure_cancella_Id;
		if inuLock=1 then
			LockByPk
			(
				inusecure_cancella_Id,
				rcData
			);
		end if;

		update LD_secure_cancella
		set
			Name_Insured = isbName_Insured$
		where
			secure_cancella_Id = inusecure_cancella_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Name_Insured:= isbName_Insured$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCancel_Causal_Id
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		inuCancel_Causal_Id$ in LD_secure_cancella.Cancel_Causal_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_secure_cancella;
	BEGIN
		rcError.secure_cancella_Id := inusecure_cancella_Id;
		if inuLock=1 then
			LockByPk
			(
				inusecure_cancella_Id,
				rcData
			);
		end if;

		update LD_secure_cancella
		set
			Cancel_Causal_Id = inuCancel_Causal_Id$
		where
			secure_cancella_Id = inusecure_cancella_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Cancel_Causal_Id:= inuCancel_Causal_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updComments
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		isbComments$ in LD_secure_cancella.Comments%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_secure_cancella;
	BEGIN
		rcError.secure_cancella_Id := inusecure_cancella_Id;
		if inuLock=1 then
			LockByPk
			(
				inusecure_cancella_Id,
				rcData
			);
		end if;

		update LD_secure_cancella
		set
			Comments = isbComments$
		where
			secure_cancella_Id = inusecure_cancella_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Comments:= isbComments$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updProduct_Line_Id
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		inuProduct_Line_Id$ in LD_secure_cancella.Product_Line_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_secure_cancella;
	BEGIN
		rcError.secure_cancella_Id := inusecure_cancella_Id;
		if inuLock=1 then
			LockByPk
			(
				inusecure_cancella_Id,
				rcData
			);
		end if;

		update LD_secure_cancella
		set
			Product_Line_Id = inuProduct_Line_Id$
		where
			secure_cancella_Id = inusecure_cancella_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Product_Line_Id:= inuProduct_Line_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updType_Cancel
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		isbType_Cancel$ in LD_secure_cancella.Type_Cancel%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_secure_cancella;
	BEGIN
		rcError.secure_cancella_Id := inusecure_cancella_Id;
		if inuLock=1 then
			LockByPk
			(
				inusecure_cancella_Id,
				rcData
			);
		end if;

		update LD_secure_cancella
		set
			Type_Cancel = isbType_Cancel$
		where
			secure_cancella_Id = inusecure_cancella_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Type_Cancel:= isbType_Cancel$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetSecure_Cancella_Id
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_secure_cancella.Secure_Cancella_Id%type
	IS
		rcError styLD_secure_cancella;
	BEGIN

		rcError.secure_cancella_Id := inusecure_cancella_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inusecure_cancella_Id
			 )
		then
			 return(rcData.Secure_Cancella_Id);
		end if;
		Load
		(
			inusecure_cancella_Id
		);
		return(rcData.Secure_Cancella_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPolicy_Id
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_secure_cancella.Policy_Id%type
	IS
		rcError styLD_secure_cancella;
	BEGIN

		rcError.secure_cancella_Id := inusecure_cancella_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inusecure_cancella_Id
			 )
		then
			 return(rcData.Policy_Id);
		end if;
		Load
		(
			inusecure_cancella_Id
		);
		return(rcData.Policy_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetContract_Id
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_secure_cancella.Contract_Id%type
	IS
		rcError styLD_secure_cancella;
	BEGIN

		rcError.secure_cancella_Id := inusecure_cancella_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inusecure_cancella_Id
			 )
		then
			 return(rcData.Contract_Id);
		end if;
		Load
		(
			inusecure_cancella_Id
		);
		return(rcData.Contract_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetIdentification_Id
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_secure_cancella.Identification_Id%type
	IS
		rcError styLD_secure_cancella;
	BEGIN

		rcError.secure_cancella_Id := inusecure_cancella_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inusecure_cancella_Id
			 )
		then
			 return(rcData.Identification_Id);
		end if;
		Load
		(
			inusecure_cancella_Id
		);
		return(rcData.Identification_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetName_Insured
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_secure_cancella.Name_Insured%type
	IS
		rcError styLD_secure_cancella;
	BEGIN

		rcError.secure_cancella_Id:=inusecure_cancella_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inusecure_cancella_Id
			 )
		then
			 return(rcData.Name_Insured);
		end if;
		Load
		(
			inusecure_cancella_Id
		);
		return(rcData.Name_Insured);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetCancel_Causal_Id
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_secure_cancella.Cancel_Causal_Id%type
	IS
		rcError styLD_secure_cancella;
	BEGIN

		rcError.secure_cancella_Id := inusecure_cancella_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inusecure_cancella_Id
			 )
		then
			 return(rcData.Cancel_Causal_Id);
		end if;
		Load
		(
			inusecure_cancella_Id
		);
		return(rcData.Cancel_Causal_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetComments
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_secure_cancella.Comments%type
	IS
		rcError styLD_secure_cancella;
	BEGIN

		rcError.secure_cancella_Id:=inusecure_cancella_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inusecure_cancella_Id
			 )
		then
			 return(rcData.Comments);
		end if;
		Load
		(
			inusecure_cancella_Id
		);
		return(rcData.Comments);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetProduct_Line_Id
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_secure_cancella.Product_Line_Id%type
	IS
		rcError styLD_secure_cancella;
	BEGIN

		rcError.secure_cancella_Id := inusecure_cancella_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inusecure_cancella_Id
			 )
		then
			 return(rcData.Product_Line_Id);
		end if;
		Load
		(
			inusecure_cancella_Id
		);
		return(rcData.Product_Line_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetType_Cancel
	(
		inusecure_cancella_Id in LD_secure_cancella.secure_cancella_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_secure_cancella.Type_Cancel%type
	IS
		rcError styLD_secure_cancella;
	BEGIN

		rcError.secure_cancella_Id:=inusecure_cancella_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inusecure_cancella_Id
			 )
		then
			 return(rcData.Type_Cancel);
		end if;
		Load
		(
			inusecure_cancella_Id
		);
		return(rcData.Type_Cancel);
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
end DALD_secure_cancella;
/
PROMPT Otorgando permisos de ejecucion a DALD_SECURE_CANCELLA
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SECURE_CANCELLA', 'ADM_PERSON');
END;
/
