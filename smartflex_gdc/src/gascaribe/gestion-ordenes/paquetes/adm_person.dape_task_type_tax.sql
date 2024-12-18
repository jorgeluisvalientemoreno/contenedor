CREATE OR REPLACE PACKAGE adm_person.DAPE_task_type_tax
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
    19/06/2024              PAcosta         OSF-2845: Cambio de esquema ADM_PERSON                              
    ****************************************************************/   
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type
	)
	IS
		SELECT PE_task_type_tax.*,PE_task_type_tax.rowid
		FROM PE_task_type_tax
		WHERE  Task_Type_Tax_Id = inuTask_Type_Tax_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT PE_task_type_tax.*,PE_task_type_tax.rowid
		FROM PE_task_type_tax
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styPE_task_type_tax  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbPE_task_type_tax is table of styPE_task_type_tax index by binary_integer;
	type tyrfRecords is ref cursor return styPE_task_type_tax;

	/* Tipos referenciando al registro */
	type tytbTask_Type_Tax_Id is table of PE_task_type_tax.Task_Type_Tax_Id%type index by binary_integer;
	type tytbTax_Percentaje is table of PE_task_type_tax.Tax_Percentaje%type index by binary_integer;
	type tytbTask_Type_Id is table of PE_task_type_tax.Task_Type_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcPE_task_type_tax is record
	(
		Task_Type_Tax_Id   tytbTask_Type_Tax_Id,
		Tax_Percentaje   tytbTax_Percentaje,
		Task_Type_Id   tytbTask_Type_Id,
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
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type
	);

	PROCEDURE getRecord
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type,
		orcRecord out nocopy styPE_task_type_tax
	);

	FUNCTION frcGetRcData
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type
	)
	RETURN styPE_task_type_tax;

	FUNCTION frcGetRcData
	RETURN styPE_task_type_tax;

	FUNCTION frcGetRecord
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type
	)
	RETURN styPE_task_type_tax;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbPE_task_type_tax
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircPE_task_type_tax in styPE_task_type_tax
	);

	PROCEDURE insRecord
	(
		ircPE_task_type_tax in styPE_task_type_tax,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbPE_task_type_tax in out nocopy tytbPE_task_type_tax
	);

	PROCEDURE delRecord
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbPE_task_type_tax in out nocopy tytbPE_task_type_tax,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircPE_task_type_tax in styPE_task_type_tax,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbPE_task_type_tax in out nocopy tytbPE_task_type_tax,
		inuLock in number default 1
	);

	PROCEDURE updTax_Percentaje
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type,
		inuTax_Percentaje$ in PE_task_type_tax.Tax_Percentaje%type,
		inuLock in number default 0
	);

	PROCEDURE updTask_Type_Id
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type,
		inuTask_Type_Id$ in PE_task_type_tax.Task_Type_Id%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetTask_Type_Tax_Id
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type,
		inuRaiseError in number default 1
	)
	RETURN PE_task_type_tax.Task_Type_Tax_Id%type;

	FUNCTION fnuGetTax_Percentaje
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type,
		inuRaiseError in number default 1
	)
	RETURN PE_task_type_tax.Tax_Percentaje%type;

	FUNCTION fnuGetTask_Type_Id
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type,
		inuRaiseError in number default 1
	)
	RETURN PE_task_type_tax.Task_Type_Id%type;

	PROCEDURE LockByPk
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type,
		orcPE_task_type_tax  out styPE_task_type_tax
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcPE_task_type_tax  out styPE_task_type_tax
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DAPE_task_type_tax;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DAPE_task_type_tax
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO396720';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'PE_TASK_TYPE_TAX';
	 cnuGeEntityId constant varchar2(30) := 5000; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type
	)
	IS
		SELECT PE_task_type_tax.*,PE_task_type_tax.rowid
		FROM PE_task_type_tax
		WHERE  Task_Type_Tax_Id = inuTask_Type_Tax_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT PE_task_type_tax.*,PE_task_type_tax.rowid
		FROM PE_task_type_tax
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfPE_task_type_tax is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcPE_task_type_tax;

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
	FUNCTION fsbPrimaryKey( rcI in styPE_task_type_tax default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.Task_Type_Tax_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type,
		orcPE_task_type_tax  out styPE_task_type_tax
	)
	IS
		rcError styPE_task_type_tax;
	BEGIN
		rcError.Task_Type_Tax_Id:=inuTask_Type_Tax_Id;

		Open cuLockRcByPk(inuTask_Type_Tax_Id);

		fetch cuLockRcByPk into orcPE_task_type_tax;
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
		orcPE_task_type_tax  out styPE_task_type_tax
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcPE_task_type_tax;
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
		itbPE_task_type_tax  in out nocopy tytbPE_task_type_tax
	)
	IS
	BEGIN
			rcRecOfTab.Task_Type_Tax_Id.delete;
			rcRecOfTab.Tax_Percentaje.delete;
			rcRecOfTab.Task_Type_Id.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbPE_task_type_tax  in out nocopy tytbPE_task_type_tax,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbPE_task_type_tax);

		for n in itbPE_task_type_tax.first .. itbPE_task_type_tax.last loop
			rcRecOfTab.Task_Type_Tax_Id(n) := itbPE_task_type_tax(n).Task_Type_Tax_Id;
			rcRecOfTab.Tax_Percentaje(n) := itbPE_task_type_tax(n).Tax_Percentaje;
			rcRecOfTab.Task_Type_Id(n) := itbPE_task_type_tax(n).Task_Type_Id;
			rcRecOfTab.row_id(n) := itbPE_task_type_tax(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord(inuTask_Type_Tax_Id);

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
		open cuRecordByRowId(irirowid);

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
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuTask_Type_Tax_Id = rcData.Task_Type_Tax_Id
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
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load(inuTask_Type_Tax_Id);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type
	)
	IS
		rcError styPE_task_type_tax;
	BEGIN
		rcError.Task_Type_Tax_Id:=inuTask_Type_Tax_Id;

		Load(inuTask_Type_Tax_Id);
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
		LoadByRowId(iriRowID);
	EXCEPTION
		when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' rowid=['||iriRowID||']');
            raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE ValDuplicate
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type
	)
	IS
	BEGIN
		Load(inuTask_Type_Tax_Id);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type,
		orcRecord out nocopy styPE_task_type_tax
	)
	IS
		rcError styPE_task_type_tax;
	BEGIN
		rcError.Task_Type_Tax_Id:=inuTask_Type_Tax_Id;

		Load(inuTask_Type_Tax_Id);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type
	)
	RETURN styPE_task_type_tax
	IS
		rcError styPE_task_type_tax;
	BEGIN
		rcError.Task_Type_Tax_Id:=inuTask_Type_Tax_Id;

		Load(inuTask_Type_Tax_Id);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type
	)
	RETURN styPE_task_type_tax
	IS
		rcError styPE_task_type_tax;
	BEGIN
		rcError.Task_Type_Tax_Id:=inuTask_Type_Tax_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded(inuTask_Type_Tax_Id) then
			 return(rcData);
		end if;
		Load(inuTask_Type_Tax_Id);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	RETURN styPE_task_type_tax
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbPE_task_type_tax
	)
	IS
		rfPE_task_type_tax tyrfPE_task_type_tax;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT PE_task_type_tax.*, PE_task_type_tax.rowid FROM PE_task_type_tax';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfPE_task_type_tax for sbFullQuery;

		fetch rfPE_task_type_tax bulk collect INTO otbResult;

		close rfPE_task_type_tax;
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
		sbSQL VARCHAR2 (32000) := 'select PE_task_type_tax.*, PE_task_type_tax.rowid FROM PE_task_type_tax';
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
		ircPE_task_type_tax in styPE_task_type_tax
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircPE_task_type_tax,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircPE_task_type_tax in styPE_task_type_tax,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircPE_task_type_tax.Task_Type_Tax_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|Task_Type_Tax_Id');
			raise ex.controlled_error;
		end if;

		insert into PE_task_type_tax
		(
			Task_Type_Tax_Id,
			Tax_Percentaje,
			Task_Type_Id
		)
		values
		(
			ircPE_task_type_tax.Task_Type_Tax_Id,
			ircPE_task_type_tax.Tax_Percentaje,
			ircPE_task_type_tax.Task_Type_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircPE_task_type_tax));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbPE_task_type_tax in out nocopy tytbPE_task_type_tax
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbPE_task_type_tax,blUseRowID);
		forall n in iotbPE_task_type_tax.first..iotbPE_task_type_tax.last
			insert into PE_task_type_tax
			(
				Task_Type_Tax_Id,
				Tax_Percentaje,
				Task_Type_Id
			)
			values
			(
				rcRecOfTab.Task_Type_Tax_Id(n),
				rcRecOfTab.Tax_Percentaje(n),
				rcRecOfTab.Task_Type_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styPE_task_type_tax;
	BEGIN
		rcError.Task_Type_Tax_Id := inuTask_Type_Tax_Id;

		if inuLock=1 then
			LockByPk
			(
				inuTask_Type_Tax_Id,
				rcData
			);
		end if;


		delete
		from PE_task_type_tax
		where
       		Task_Type_Tax_Id=inuTask_Type_Tax_Id;
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
		rcError  styPE_task_type_tax;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from PE_task_type_tax
		where
			rowid = iriRowID
		returning
			Task_Type_Tax_Id
		into
			rcError.Task_Type_Tax_Id;
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
		iotbPE_task_type_tax in out nocopy tytbPE_task_type_tax,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styPE_task_type_tax;
	BEGIN
		FillRecordOfTables(iotbPE_task_type_tax, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbPE_task_type_tax.first .. iotbPE_task_type_tax.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbPE_task_type_tax.first .. iotbPE_task_type_tax.last
				delete
				from PE_task_type_tax
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbPE_task_type_tax.first .. iotbPE_task_type_tax.last loop
					LockByPk
					(
						rcRecOfTab.Task_Type_Tax_Id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbPE_task_type_tax.first .. iotbPE_task_type_tax.last
				delete
				from PE_task_type_tax
				where
		         	Task_Type_Tax_Id = rcRecOfTab.Task_Type_Tax_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircPE_task_type_tax in styPE_task_type_tax,
		inuLock in number default 0
	)
	IS
		nuTask_Type_Tax_Id	PE_task_type_tax.Task_Type_Tax_Id%type;
	BEGIN
		if ircPE_task_type_tax.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircPE_task_type_tax.rowid,rcData);
			end if;
			update PE_task_type_tax
			set
				Tax_Percentaje = ircPE_task_type_tax.Tax_Percentaje,
				Task_Type_Id = ircPE_task_type_tax.Task_Type_Id
			where
				rowid = ircPE_task_type_tax.rowid
			returning
				Task_Type_Tax_Id
			into
				nuTask_Type_Tax_Id;
		else
			if inuLock=1 then
				LockByPk
				(
					ircPE_task_type_tax.Task_Type_Tax_Id,
					rcData
				);
			end if;

			update PE_task_type_tax
			set
				Tax_Percentaje = ircPE_task_type_tax.Tax_Percentaje,
				Task_Type_Id = ircPE_task_type_tax.Task_Type_Id
			where
				Task_Type_Tax_Id = ircPE_task_type_tax.Task_Type_Tax_Id
			returning
				Task_Type_Tax_Id
			into
				nuTask_Type_Tax_Id;
		end if;
		if
			nuTask_Type_Tax_Id is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircPE_task_type_tax));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbPE_task_type_tax in out nocopy tytbPE_task_type_tax,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styPE_task_type_tax;
	BEGIN
		FillRecordOfTables(iotbPE_task_type_tax,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbPE_task_type_tax.first .. iotbPE_task_type_tax.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbPE_task_type_tax.first .. iotbPE_task_type_tax.last
				update PE_task_type_tax
				set
					Tax_Percentaje = rcRecOfTab.Tax_Percentaje(n),
					Task_Type_Id = rcRecOfTab.Task_Type_Id(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbPE_task_type_tax.first .. iotbPE_task_type_tax.last loop
					LockByPk
					(
						rcRecOfTab.Task_Type_Tax_Id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbPE_task_type_tax.first .. iotbPE_task_type_tax.last
				update PE_task_type_tax
				SET
					Tax_Percentaje = rcRecOfTab.Tax_Percentaje(n),
					Task_Type_Id = rcRecOfTab.Task_Type_Id(n)
				where
					Task_Type_Tax_Id = rcRecOfTab.Task_Type_Tax_Id(n)
;
		end if;
	END;
	PROCEDURE updTax_Percentaje
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type,
		inuTax_Percentaje$ in PE_task_type_tax.Tax_Percentaje%type,
		inuLock in number default 0
	)
	IS
		rcError styPE_task_type_tax;
	BEGIN
		rcError.Task_Type_Tax_Id := inuTask_Type_Tax_Id;
		if inuLock=1 then
			LockByPk
			(
				inuTask_Type_Tax_Id,
				rcData
			);
		end if;

		update PE_task_type_tax
		set
			Tax_Percentaje = inuTax_Percentaje$
		where
			Task_Type_Tax_Id = inuTask_Type_Tax_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Tax_Percentaje:= inuTax_Percentaje$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTask_Type_Id
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type,
		inuTask_Type_Id$ in PE_task_type_tax.Task_Type_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styPE_task_type_tax;
	BEGIN
		rcError.Task_Type_Tax_Id := inuTask_Type_Tax_Id;
		if inuLock=1 then
			LockByPk
			(
				inuTask_Type_Tax_Id,
				rcData
			);
		end if;

		update PE_task_type_tax
		set
			Task_Type_Id = inuTask_Type_Id$
		where
			Task_Type_Tax_Id = inuTask_Type_Tax_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Task_Type_Id:= inuTask_Type_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetTask_Type_Tax_Id
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type,
		inuRaiseError in number default 1
	)
	RETURN PE_task_type_tax.Task_Type_Tax_Id%type
	IS
		rcError styPE_task_type_tax;
	BEGIN

		rcError.Task_Type_Tax_Id := inuTask_Type_Tax_Id;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded(inuTask_Type_Tax_Id) then
			 return(rcData.Task_Type_Tax_Id);
		end if;
		Load(inuTask_Type_Tax_Id);
		return(rcData.Task_Type_Tax_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTax_Percentaje
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type,
		inuRaiseError in number default 1
	)
	RETURN PE_task_type_tax.Tax_Percentaje%type
	IS
		rcError styPE_task_type_tax;
	BEGIN

		rcError.Task_Type_Tax_Id := inuTask_Type_Tax_Id;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded(inuTask_Type_Tax_Id) then
			 return(rcData.Tax_Percentaje);
		end if;
		Load(inuTask_Type_Tax_Id);
		return(rcData.Tax_Percentaje);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTask_Type_Id
	(
		inuTask_Type_Tax_Id in PE_task_type_tax.Task_Type_Tax_Id%type,
		inuRaiseError in number default 1
	)
	RETURN PE_task_type_tax.Task_Type_Id%type
	IS
		rcError styPE_task_type_tax;
	BEGIN

		rcError.Task_Type_Tax_Id := inuTask_Type_Tax_Id;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded(inuTask_Type_Tax_Id) then
			 return(rcData.Task_Type_Id);
		end if;
		Load(inuTask_Type_Tax_Id);
		return(rcData.Task_Type_Id);
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
end DAPE_task_type_tax;
/
PROMPT Otorgando permisos de ejecucion a DAPE_TASK_TYPE_TAX
BEGIN
    pkg_utilidades.praplicarpermisos('DAPE_TASK_TYPE_TAX', 'ADM_PERSON');
END;
/