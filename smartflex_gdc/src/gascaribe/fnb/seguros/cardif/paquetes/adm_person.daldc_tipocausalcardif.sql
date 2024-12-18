CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_TIPOCAUSALCARDIF
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
    05/06/2024              PAcosta         OSF-2777: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord 
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type
	)
	IS
		SELECT LDC_TIPOCAUSALCARDIF.*,LDC_TIPOCAUSALCARDIF.rowid
		FROM LDC_TIPOCAUSALCARDIF
		WHERE 
		    CAUSAL_CARDIF = inuCAUSAL_CARDIF;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TIPOCAUSALCARDIF.*,LDC_TIPOCAUSALCARDIF.rowid
		FROM LDC_TIPOCAUSALCARDIF
		WHERE 
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TIPOCAUSALCARDIF  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TIPOCAUSALCARDIF is table of styLDC_TIPOCAUSALCARDIF index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TIPOCAUSALCARDIF;

	/* Tipos referenciando al registro */
	type tytbCAUSAL_CARDIF is table of LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type index by binary_integer;
	type tytbTIPO_CAUSAL is table of LDC_TIPOCAUSALCARDIF.TIPO_CAUSAL%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_TIPOCAUSALCARDIF is record
	(
		CAUSAL_CARDIF   tytbCAUSAL_CARDIF,
		TIPO_CAUSAL   tytbTIPO_CAUSAL,
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
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type
	);

	PROCEDURE getRecord
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type,
		orcRecord out nocopy styLDC_TIPOCAUSALCARDIF
	);

	FUNCTION frcGetRcData
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type
	)
	RETURN styLDC_TIPOCAUSALCARDIF;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPOCAUSALCARDIF;

	FUNCTION frcGetRecord
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type
	)
	RETURN styLDC_TIPOCAUSALCARDIF;

	PROCEDURE getRecords 
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPOCAUSALCARDIF
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TIPOCAUSALCARDIF in styLDC_TIPOCAUSALCARDIF
	);

	PROCEDURE insRecord
	(
		ircLDC_TIPOCAUSALCARDIF in styLDC_TIPOCAUSALCARDIF,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TIPOCAUSALCARDIF in out nocopy tytbLDC_TIPOCAUSALCARDIF
	);

	PROCEDURE delRecord
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TIPOCAUSALCARDIF in out nocopy tytbLDC_TIPOCAUSALCARDIF,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_TIPOCAUSALCARDIF in styLDC_TIPOCAUSALCARDIF,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_TIPOCAUSALCARDIF in out nocopy tytbLDC_TIPOCAUSALCARDIF,
		inuLock in number default 1
	);

	PROCEDURE updTIPO_CAUSAL
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type,
		inuTIPO_CAUSAL$ in LDC_TIPOCAUSALCARDIF.TIPO_CAUSAL%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCAUSAL_CARDIF
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type;

	FUNCTION fnuGetTIPO_CAUSAL
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOCAUSALCARDIF.TIPO_CAUSAL%type;


	PROCEDURE LockByPk
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type,
		orcLDC_TIPOCAUSALCARDIF  out styLDC_TIPOCAUSALCARDIF
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TIPOCAUSALCARDIF  out styLDC_TIPOCAUSALCARDIF
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TIPOCAUSALCARDIF;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_TIPOCAUSALCARDIF
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO1';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TIPOCAUSALCARDIF';
	 cnuGeEntityId constant varchar2(30) := 6081; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk 
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type
	)
	IS
		SELECT LDC_TIPOCAUSALCARDIF.*,LDC_TIPOCAUSALCARDIF.rowid 
		FROM LDC_TIPOCAUSALCARDIF
		WHERE  CAUSAL_CARDIF = inuCAUSAL_CARDIF
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId 
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TIPOCAUSALCARDIF.*,LDC_TIPOCAUSALCARDIF.rowid 
		FROM LDC_TIPOCAUSALCARDIF
		WHERE 
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TIPOCAUSALCARDIF is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TIPOCAUSALCARDIF;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_TIPOCAUSALCARDIF default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CAUSAL_CARDIF);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type,
		orcLDC_TIPOCAUSALCARDIF  out styLDC_TIPOCAUSALCARDIF
	)
	IS
		rcError styLDC_TIPOCAUSALCARDIF;
	BEGIN
		rcError.CAUSAL_CARDIF := inuCAUSAL_CARDIF;

		Open cuLockRcByPk
		(
			inuCAUSAL_CARDIF
		);

		fetch cuLockRcByPk into orcLDC_TIPOCAUSALCARDIF;
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
		orcLDC_TIPOCAUSALCARDIF  out styLDC_TIPOCAUSALCARDIF
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TIPOCAUSALCARDIF;
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
		itbLDC_TIPOCAUSALCARDIF  in out nocopy tytbLDC_TIPOCAUSALCARDIF
	)
	IS
	BEGIN
			rcRecOfTab.CAUSAL_CARDIF.delete;
			rcRecOfTab.TIPO_CAUSAL.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_TIPOCAUSALCARDIF  in out nocopy tytbLDC_TIPOCAUSALCARDIF,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TIPOCAUSALCARDIF);

		for n in itbLDC_TIPOCAUSALCARDIF.first .. itbLDC_TIPOCAUSALCARDIF.last loop
			rcRecOfTab.CAUSAL_CARDIF(n) := itbLDC_TIPOCAUSALCARDIF(n).CAUSAL_CARDIF;
			rcRecOfTab.TIPO_CAUSAL(n) := itbLDC_TIPOCAUSALCARDIF(n).TIPO_CAUSAL;
			rcRecOfTab.row_id(n) := itbLDC_TIPOCAUSALCARDIF(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCAUSAL_CARDIF
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
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCAUSAL_CARDIF = rcData.CAUSAL_CARDIF
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
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCAUSAL_CARDIF
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type
	)
	IS
		rcError styLDC_TIPOCAUSALCARDIF;
	BEGIN		rcError.CAUSAL_CARDIF:=inuCAUSAL_CARDIF;

		Load
		(
			inuCAUSAL_CARDIF
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
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type
	)
	IS
	BEGIN
		Load
		( 
			inuCAUSAL_CARDIF
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type,
		orcRecord out nocopy styLDC_TIPOCAUSALCARDIF
	)
	IS
		rcError styLDC_TIPOCAUSALCARDIF;
	BEGIN		rcError.CAUSAL_CARDIF:=inuCAUSAL_CARDIF;

		Load
		(
			inuCAUSAL_CARDIF
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type
	)
	RETURN styLDC_TIPOCAUSALCARDIF
	IS
		rcError styLDC_TIPOCAUSALCARDIF;
	BEGIN
		rcError.CAUSAL_CARDIF:=inuCAUSAL_CARDIF;

		Load
		(
			inuCAUSAL_CARDIF
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type
	)
	RETURN styLDC_TIPOCAUSALCARDIF
	IS
		rcError styLDC_TIPOCAUSALCARDIF;
	BEGIN
		rcError.CAUSAL_CARDIF:=inuCAUSAL_CARDIF;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCAUSAL_CARDIF
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCAUSAL_CARDIF
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPOCAUSALCARDIF
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPOCAUSALCARDIF
	)
	IS
		rfLDC_TIPOCAUSALCARDIF tyrfLDC_TIPOCAUSALCARDIF;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TIPOCAUSALCARDIF.*, LDC_TIPOCAUSALCARDIF.rowid FROM LDC_TIPOCAUSALCARDIF';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TIPOCAUSALCARDIF for sbFullQuery;

		fetch rfLDC_TIPOCAUSALCARDIF bulk collect INTO otbResult;

		close rfLDC_TIPOCAUSALCARDIF;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TIPOCAUSALCARDIF.*, LDC_TIPOCAUSALCARDIF.rowid FROM LDC_TIPOCAUSALCARDIF';
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
		ircLDC_TIPOCAUSALCARDIF in styLDC_TIPOCAUSALCARDIF
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TIPOCAUSALCARDIF,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_TIPOCAUSALCARDIF in styLDC_TIPOCAUSALCARDIF,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CAUSAL_CARDIF');
			raise ex.controlled_error;
		end if;

		insert into LDC_TIPOCAUSALCARDIF
		(
			CAUSAL_CARDIF,
			TIPO_CAUSAL
		)
		values
		(
			ircLDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF,
			ircLDC_TIPOCAUSALCARDIF.TIPO_CAUSAL
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TIPOCAUSALCARDIF));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_TIPOCAUSALCARDIF in out nocopy tytbLDC_TIPOCAUSALCARDIF
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPOCAUSALCARDIF,blUseRowID);
		forall n in iotbLDC_TIPOCAUSALCARDIF.first..iotbLDC_TIPOCAUSALCARDIF.last
			insert into LDC_TIPOCAUSALCARDIF
			(
				CAUSAL_CARDIF,
				TIPO_CAUSAL
			)
			values
			(
				rcRecOfTab.CAUSAL_CARDIF(n),
				rcRecOfTab.TIPO_CAUSAL(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TIPOCAUSALCARDIF;
	BEGIN
		rcError.CAUSAL_CARDIF := inuCAUSAL_CARDIF;

		if inuLock=1 then
			LockByPk
			(
				inuCAUSAL_CARDIF,
				rcData
			);
		end if;


		delete
		from LDC_TIPOCAUSALCARDIF
		where
       		CAUSAL_CARDIF=inuCAUSAL_CARDIF;
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
		rcError  styLDC_TIPOCAUSALCARDIF;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TIPOCAUSALCARDIF
		where
			rowid = iriRowID
		returning
			CAUSAL_CARDIF
		into
			rcError.CAUSAL_CARDIF;
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
		iotbLDC_TIPOCAUSALCARDIF in out nocopy tytbLDC_TIPOCAUSALCARDIF,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPOCAUSALCARDIF;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPOCAUSALCARDIF, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TIPOCAUSALCARDIF.first .. iotbLDC_TIPOCAUSALCARDIF.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOCAUSALCARDIF.first .. iotbLDC_TIPOCAUSALCARDIF.last
				delete
				from LDC_TIPOCAUSALCARDIF
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPOCAUSALCARDIF.first .. iotbLDC_TIPOCAUSALCARDIF.last loop
					LockByPk
					(
						rcRecOfTab.CAUSAL_CARDIF(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOCAUSALCARDIF.first .. iotbLDC_TIPOCAUSALCARDIF.last
				delete
				from LDC_TIPOCAUSALCARDIF
				where
		         	CAUSAL_CARDIF = rcRecOfTab.CAUSAL_CARDIF(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_TIPOCAUSALCARDIF in styLDC_TIPOCAUSALCARDIF,
		inuLock in number default 0
	)
	IS
		nuCAUSAL_CARDIF	LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type;
	BEGIN
		if ircLDC_TIPOCAUSALCARDIF.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_TIPOCAUSALCARDIF.rowid,rcData);
			end if;
			update LDC_TIPOCAUSALCARDIF
			set
				TIPO_CAUSAL = ircLDC_TIPOCAUSALCARDIF.TIPO_CAUSAL
			where
				rowid = ircLDC_TIPOCAUSALCARDIF.rowid
			returning
				CAUSAL_CARDIF
			into
				nuCAUSAL_CARDIF;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF,
					rcData
				);
			end if;

			update LDC_TIPOCAUSALCARDIF
			set
				TIPO_CAUSAL = ircLDC_TIPOCAUSALCARDIF.TIPO_CAUSAL
			where
				CAUSAL_CARDIF = ircLDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF
			returning
				CAUSAL_CARDIF
			into
				nuCAUSAL_CARDIF;
		end if;
		if
			nuCAUSAL_CARDIF is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_TIPOCAUSALCARDIF));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_TIPOCAUSALCARDIF in out nocopy tytbLDC_TIPOCAUSALCARDIF,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;    
		rcAux styLDC_TIPOCAUSALCARDIF;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPOCAUSALCARDIF,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_TIPOCAUSALCARDIF.first .. iotbLDC_TIPOCAUSALCARDIF.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOCAUSALCARDIF.first .. iotbLDC_TIPOCAUSALCARDIF.last
				update LDC_TIPOCAUSALCARDIF
				set
					TIPO_CAUSAL = rcRecOfTab.TIPO_CAUSAL(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPOCAUSALCARDIF.first .. iotbLDC_TIPOCAUSALCARDIF.last loop
					LockByPk
					(
						rcRecOfTab.CAUSAL_CARDIF(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOCAUSALCARDIF.first .. iotbLDC_TIPOCAUSALCARDIF.last
				update LDC_TIPOCAUSALCARDIF
				SET
					TIPO_CAUSAL = rcRecOfTab.TIPO_CAUSAL(n)
				where
					CAUSAL_CARDIF = rcRecOfTab.CAUSAL_CARDIF(n)
;
		end if;
	END;
	PROCEDURE updTIPO_CAUSAL
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type,
		inuTIPO_CAUSAL$ in LDC_TIPOCAUSALCARDIF.TIPO_CAUSAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPOCAUSALCARDIF;
	BEGIN
		rcError.CAUSAL_CARDIF := inuCAUSAL_CARDIF;
		if inuLock=1 then
			LockByPk
			(
				inuCAUSAL_CARDIF,
				rcData
			);
		end if;

		update LDC_TIPOCAUSALCARDIF
		set
			TIPO_CAUSAL = inuTIPO_CAUSAL$
		where
			CAUSAL_CARDIF = inuCAUSAL_CARDIF;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPO_CAUSAL:= inuTIPO_CAUSAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCAUSAL_CARDIF
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type
	IS
		rcError styLDC_TIPOCAUSALCARDIF;
	BEGIN

		rcError.CAUSAL_CARDIF := inuCAUSAL_CARDIF;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAUSAL_CARDIF
			 )
		then
			 return(rcData.CAUSAL_CARDIF);
		end if;
		Load
		(
		 		inuCAUSAL_CARDIF
		);
		return(rcData.CAUSAL_CARDIF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTIPO_CAUSAL
	(
		inuCAUSAL_CARDIF in LDC_TIPOCAUSALCARDIF.CAUSAL_CARDIF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOCAUSALCARDIF.TIPO_CAUSAL%type
	IS
		rcError styLDC_TIPOCAUSALCARDIF;
	BEGIN

		rcError.CAUSAL_CARDIF := inuCAUSAL_CARDIF;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAUSAL_CARDIF
			 )
		then
			 return(rcData.TIPO_CAUSAL);
		end if;
		Load
		(
		 		inuCAUSAL_CARDIF
		);
		return(rcData.TIPO_CAUSAL);
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
end DALDC_TIPOCAUSALCARDIF;
/
PROMPT Otorgando permisos de ejecucion a DALDC_TIPOCAUSALCARDIF
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_TIPOCAUSALCARDIF', 'ADM_PERSON');
END;
/