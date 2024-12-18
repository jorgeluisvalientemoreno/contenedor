CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_NOTIFICATION
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_NOTIFICATION
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    07/06/2024              PAcosta         OSF-2812: Cambio de esquema ADM_PERSON                                              
    ****************************************************************/    
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type
	)
	IS
		SELECT LD_NOTIFICATION.*,LD_NOTIFICATION.rowid
		FROM LD_NOTIFICATION
		WHERE
		    NOTIFICATION_ID = inuNOTIFICATION_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_NOTIFICATION.*,LD_NOTIFICATION.rowid
		FROM LD_NOTIFICATION
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_NOTIFICATION  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_NOTIFICATION is table of styLD_NOTIFICATION index by binary_integer;
	type tyrfRecords is ref cursor return styLD_NOTIFICATION;

	/* Tipos referenciando al registro */
	type tytbNOTIFICATION_ID is table of LD_NOTIFICATION.NOTIFICATION_ID%type index by binary_integer;
	type tytbSTATE is table of LD_NOTIFICATION.STATE%type index by binary_integer;
	type tytbDATE_NOTIFICATION is table of LD_NOTIFICATION.DATE_NOTIFICATION%type index by binary_integer;
	type tytbUSER_ID is table of LD_NOTIFICATION.USER_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_NOTIFICATION is record
	(
		NOTIFICATION_ID   tytbNOTIFICATION_ID,
		STATE   tytbSTATE,
		DATE_NOTIFICATION   tytbDATE_NOTIFICATION,
		USER_ID   tytbUSER_ID,
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
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type
	);

	PROCEDURE getRecord
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		orcRecord out nocopy styLD_NOTIFICATION
	);

	FUNCTION frcGetRcData
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type
	)
	RETURN styLD_NOTIFICATION;

	FUNCTION frcGetRcData
	RETURN styLD_NOTIFICATION;

	FUNCTION frcGetRecord
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type
	)
	RETURN styLD_NOTIFICATION;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_NOTIFICATION
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_NOTIFICATION in styLD_NOTIFICATION
	);

	PROCEDURE insRecord
	(
		ircLD_NOTIFICATION in styLD_NOTIFICATION,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_NOTIFICATION in out nocopy tytbLD_NOTIFICATION
	);

	PROCEDURE delRecord
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_NOTIFICATION in out nocopy tytbLD_NOTIFICATION,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_NOTIFICATION in styLD_NOTIFICATION,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_NOTIFICATION in out nocopy tytbLD_NOTIFICATION,
		inuLock in number default 1
	);

	PROCEDURE updSTATE
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		isbSTATE$ in LD_NOTIFICATION.STATE%type,
		inuLock in number default 0
	);

	PROCEDURE updDATE_NOTIFICATION
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		idtDATE_NOTIFICATION$ in LD_NOTIFICATION.DATE_NOTIFICATION%type,
		inuLock in number default 0
	);

	PROCEDURE updUSER_ID
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		inuUSER_ID$ in LD_NOTIFICATION.USER_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetNOTIFICATION_ID
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_NOTIFICATION.NOTIFICATION_ID%type;

	FUNCTION fsbGetSTATE
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_NOTIFICATION.STATE%type;

	FUNCTION fdtGetDATE_NOTIFICATION
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_NOTIFICATION.DATE_NOTIFICATION%type;

	FUNCTION fnuGetUSER_ID
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_NOTIFICATION.USER_ID%type;


	PROCEDURE LockByPk
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		orcLD_NOTIFICATION  out styLD_NOTIFICATION
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_NOTIFICATION  out styLD_NOTIFICATION
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_NOTIFICATION;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_NOTIFICATION
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO193378';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_NOTIFICATION';
	 cnuGeEntityId constant varchar2(30) := 8477; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type
	)
	IS
		SELECT LD_NOTIFICATION.*,LD_NOTIFICATION.rowid
		FROM LD_NOTIFICATION
		WHERE  NOTIFICATION_ID = inuNOTIFICATION_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_NOTIFICATION.*,LD_NOTIFICATION.rowid
		FROM LD_NOTIFICATION
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_NOTIFICATION is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_NOTIFICATION;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_NOTIFICATION default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.NOTIFICATION_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		orcLD_NOTIFICATION  out styLD_NOTIFICATION
	)
	IS
		rcError styLD_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;

		Open cuLockRcByPk
		(
			inuNOTIFICATION_ID
		);

		fetch cuLockRcByPk into orcLD_NOTIFICATION;
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
		orcLD_NOTIFICATION  out styLD_NOTIFICATION
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_NOTIFICATION;
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
		itbLD_NOTIFICATION  in out nocopy tytbLD_NOTIFICATION
	)
	IS
	BEGIN
			rcRecOfTab.NOTIFICATION_ID.delete;
			rcRecOfTab.STATE.delete;
			rcRecOfTab.DATE_NOTIFICATION.delete;
			rcRecOfTab.USER_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_NOTIFICATION  in out nocopy tytbLD_NOTIFICATION,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_NOTIFICATION);

		for n in itbLD_NOTIFICATION.first .. itbLD_NOTIFICATION.last loop
			rcRecOfTab.NOTIFICATION_ID(n) := itbLD_NOTIFICATION(n).NOTIFICATION_ID;
			rcRecOfTab.STATE(n) := itbLD_NOTIFICATION(n).STATE;
			rcRecOfTab.DATE_NOTIFICATION(n) := itbLD_NOTIFICATION(n).DATE_NOTIFICATION;
			rcRecOfTab.USER_ID(n) := itbLD_NOTIFICATION(n).USER_ID;
			rcRecOfTab.row_id(n) := itbLD_NOTIFICATION(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuNOTIFICATION_ID
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
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuNOTIFICATION_ID = rcData.NOTIFICATION_ID
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
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuNOTIFICATION_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type
	)
	IS
		rcError styLD_NOTIFICATION;
	BEGIN		rcError.NOTIFICATION_ID:=inuNOTIFICATION_ID;

		Load
		(
			inuNOTIFICATION_ID
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
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuNOTIFICATION_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		orcRecord out nocopy styLD_NOTIFICATION
	)
	IS
		rcError styLD_NOTIFICATION;
	BEGIN		rcError.NOTIFICATION_ID:=inuNOTIFICATION_ID;

		Load
		(
			inuNOTIFICATION_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type
	)
	RETURN styLD_NOTIFICATION
	IS
		rcError styLD_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID:=inuNOTIFICATION_ID;

		Load
		(
			inuNOTIFICATION_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type
	)
	RETURN styLD_NOTIFICATION
	IS
		rcError styLD_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID:=inuNOTIFICATION_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuNOTIFICATION_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuNOTIFICATION_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_NOTIFICATION
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_NOTIFICATION
	)
	IS
		rfLD_NOTIFICATION tyrfLD_NOTIFICATION;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_NOTIFICATION.*, LD_NOTIFICATION.rowid FROM LD_NOTIFICATION';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_NOTIFICATION for sbFullQuery;

		fetch rfLD_NOTIFICATION bulk collect INTO otbResult;

		close rfLD_NOTIFICATION;
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
		sbSQL VARCHAR2 (32000) := 'select LD_NOTIFICATION.*, LD_NOTIFICATION.rowid FROM LD_NOTIFICATION';
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
		ircLD_NOTIFICATION in styLD_NOTIFICATION
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_NOTIFICATION,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_NOTIFICATION in styLD_NOTIFICATION,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_NOTIFICATION.NOTIFICATION_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|NOTIFICATION_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_NOTIFICATION
		(
			NOTIFICATION_ID,
			STATE,
			DATE_NOTIFICATION,
			USER_ID
		)
		values
		(
			ircLD_NOTIFICATION.NOTIFICATION_ID,
			ircLD_NOTIFICATION.STATE,
			ircLD_NOTIFICATION.DATE_NOTIFICATION,
			ircLD_NOTIFICATION.USER_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_NOTIFICATION));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_NOTIFICATION in out nocopy tytbLD_NOTIFICATION
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_NOTIFICATION,blUseRowID);
		forall n in iotbLD_NOTIFICATION.first..iotbLD_NOTIFICATION.last
			insert into LD_NOTIFICATION
			(
				NOTIFICATION_ID,
				STATE,
				DATE_NOTIFICATION,
				USER_ID
			)
			values
			(
				rcRecOfTab.NOTIFICATION_ID(n),
				rcRecOfTab.STATE(n),
				rcRecOfTab.DATE_NOTIFICATION(n),
				rcRecOfTab.USER_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;

		if inuLock=1 then
			LockByPk
			(
				inuNOTIFICATION_ID,
				rcData
			);
		end if;


		delete
		from LD_NOTIFICATION
		where
       		NOTIFICATION_ID=inuNOTIFICATION_ID;
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
		rcError  styLD_NOTIFICATION;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_NOTIFICATION
		where
			rowid = iriRowID
		returning
			NOTIFICATION_ID
		into
			rcError.NOTIFICATION_ID;
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
		iotbLD_NOTIFICATION in out nocopy tytbLD_NOTIFICATION,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_NOTIFICATION;
	BEGIN
		FillRecordOfTables(iotbLD_NOTIFICATION, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_NOTIFICATION.first .. iotbLD_NOTIFICATION.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_NOTIFICATION.first .. iotbLD_NOTIFICATION.last
				delete
				from LD_NOTIFICATION
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_NOTIFICATION.first .. iotbLD_NOTIFICATION.last loop
					LockByPk
					(
						rcRecOfTab.NOTIFICATION_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_NOTIFICATION.first .. iotbLD_NOTIFICATION.last
				delete
				from LD_NOTIFICATION
				where
		         	NOTIFICATION_ID = rcRecOfTab.NOTIFICATION_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_NOTIFICATION in styLD_NOTIFICATION,
		inuLock in number default 0
	)
	IS
		nuNOTIFICATION_ID	LD_NOTIFICATION.NOTIFICATION_ID%type;
	BEGIN
		if ircLD_NOTIFICATION.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_NOTIFICATION.rowid,rcData);
			end if;
			update LD_NOTIFICATION
			set
				STATE = ircLD_NOTIFICATION.STATE,
				DATE_NOTIFICATION = ircLD_NOTIFICATION.DATE_NOTIFICATION,
				USER_ID = ircLD_NOTIFICATION.USER_ID
			where
				rowid = ircLD_NOTIFICATION.rowid
			returning
				NOTIFICATION_ID
			into
				nuNOTIFICATION_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_NOTIFICATION.NOTIFICATION_ID,
					rcData
				);
			end if;

			update LD_NOTIFICATION
			set
				STATE = ircLD_NOTIFICATION.STATE,
				DATE_NOTIFICATION = ircLD_NOTIFICATION.DATE_NOTIFICATION,
				USER_ID = ircLD_NOTIFICATION.USER_ID
			where
				NOTIFICATION_ID = ircLD_NOTIFICATION.NOTIFICATION_ID
			returning
				NOTIFICATION_ID
			into
				nuNOTIFICATION_ID;
		end if;
		if
			nuNOTIFICATION_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_NOTIFICATION));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_NOTIFICATION in out nocopy tytbLD_NOTIFICATION,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_NOTIFICATION;
	BEGIN
		FillRecordOfTables(iotbLD_NOTIFICATION,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_NOTIFICATION.first .. iotbLD_NOTIFICATION.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_NOTIFICATION.first .. iotbLD_NOTIFICATION.last
				update LD_NOTIFICATION
				set
					STATE = rcRecOfTab.STATE(n),
					DATE_NOTIFICATION = rcRecOfTab.DATE_NOTIFICATION(n),
					USER_ID = rcRecOfTab.USER_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_NOTIFICATION.first .. iotbLD_NOTIFICATION.last loop
					LockByPk
					(
						rcRecOfTab.NOTIFICATION_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_NOTIFICATION.first .. iotbLD_NOTIFICATION.last
				update LD_NOTIFICATION
				SET
					STATE = rcRecOfTab.STATE(n),
					DATE_NOTIFICATION = rcRecOfTab.DATE_NOTIFICATION(n),
					USER_ID = rcRecOfTab.USER_ID(n)
				where
					NOTIFICATION_ID = rcRecOfTab.NOTIFICATION_ID(n)
;
		end if;
	END;
	PROCEDURE updSTATE
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		isbSTATE$ in LD_NOTIFICATION.STATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOTIFICATION_ID,
				rcData
			);
		end if;

		update LD_NOTIFICATION
		set
			STATE = isbSTATE$
		where
			NOTIFICATION_ID = inuNOTIFICATION_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.STATE:= isbSTATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDATE_NOTIFICATION
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		idtDATE_NOTIFICATION$ in LD_NOTIFICATION.DATE_NOTIFICATION%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOTIFICATION_ID,
				rcData
			);
		end if;

		update LD_NOTIFICATION
		set
			DATE_NOTIFICATION = idtDATE_NOTIFICATION$
		where
			NOTIFICATION_ID = inuNOTIFICATION_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DATE_NOTIFICATION:= idtDATE_NOTIFICATION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSER_ID
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		inuUSER_ID$ in LD_NOTIFICATION.USER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_NOTIFICATION;
	BEGIN
		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOTIFICATION_ID,
				rcData
			);
		end if;

		update LD_NOTIFICATION
		set
			USER_ID = inuUSER_ID$
		where
			NOTIFICATION_ID = inuNOTIFICATION_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USER_ID:= inuUSER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetNOTIFICATION_ID
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_NOTIFICATION.NOTIFICATION_ID%type
	IS
		rcError styLD_NOTIFICATION;
	BEGIN

		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOTIFICATION_ID
			 )
		then
			 return(rcData.NOTIFICATION_ID);
		end if;
		Load
		(
		 		inuNOTIFICATION_ID
		);
		return(rcData.NOTIFICATION_ID);
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
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_NOTIFICATION.STATE%type
	IS
		rcError styLD_NOTIFICATION;
	BEGIN

		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOTIFICATION_ID
			 )
		then
			 return(rcData.STATE);
		end if;
		Load
		(
		 		inuNOTIFICATION_ID
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
	FUNCTION fdtGetDATE_NOTIFICATION
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_NOTIFICATION.DATE_NOTIFICATION%type
	IS
		rcError styLD_NOTIFICATION;
	BEGIN

		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOTIFICATION_ID
			 )
		then
			 return(rcData.DATE_NOTIFICATION);
		end if;
		Load
		(
		 		inuNOTIFICATION_ID
		);
		return(rcData.DATE_NOTIFICATION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetUSER_ID
	(
		inuNOTIFICATION_ID in LD_NOTIFICATION.NOTIFICATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_NOTIFICATION.USER_ID%type
	IS
		rcError styLD_NOTIFICATION;
	BEGIN

		rcError.NOTIFICATION_ID := inuNOTIFICATION_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOTIFICATION_ID
			 )
		then
			 return(rcData.USER_ID);
		end if;
		Load
		(
		 		inuNOTIFICATION_ID
		);
		return(rcData.USER_ID);
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
end DALD_NOTIFICATION;
/
PROMPT Otorgando permisos de ejecucion a DALD_NOTIFICATION
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_NOTIFICATION', 'ADM_PERSON');
END;
/