CREATE OR REPLACE PACKAGE ADM_PERSON.dald_sample_fin
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : dald_sample_fin
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
		inuID in LD_SAMPLE_FIN.ID%type
	)
	IS
		SELECT LD_SAMPLE_FIN.*,LD_SAMPLE_FIN.rowid
		FROM LD_SAMPLE_FIN
		WHERE
		    ID = inuID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_SAMPLE_FIN.*,LD_SAMPLE_FIN.rowid
		FROM LD_SAMPLE_FIN
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_SAMPLE_FIN  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_SAMPLE_FIN is table of styLD_SAMPLE_FIN index by binary_integer;
	type tyrfRecords is ref cursor return styLD_SAMPLE_FIN;

	/* Tipos referenciando al registro */
	type tytbID is table of LD_SAMPLE_FIN.ID%type index by binary_integer;
	type tytbSAMPLE_ID is table of LD_SAMPLE_FIN.SAMPLE_ID%type index by binary_integer;
	type tytbFINAL_RECORD_INDICATOR is table of LD_SAMPLE_FIN.FINAL_RECORD_INDICATOR%type index by binary_integer;
	type tytbDATE_OF_PROCESS is table of LD_SAMPLE_FIN.DATE_OF_PROCESS%type index by binary_integer;
	type tytbNUMBER_OF_RECORD is table of LD_SAMPLE_FIN.NUMBER_OF_RECORD%type index by binary_integer;
	type tytbSUM_OF_NEW is table of LD_SAMPLE_FIN.SUM_OF_NEW%type index by binary_integer;
	type tytbFILLER is table of LD_SAMPLE_FIN.FILLER%type index by binary_integer;
	type tytbTYPE_REGISTER is table of LD_SAMPLE_FIN.TYPE_REGISTER%type index by binary_integer;
	type tytbTOTAL_NUMBER_OF_RECORDS is table of LD_SAMPLE_FIN.TOTAL_NUMBER_OF_RECORDS%type index by binary_integer;
	type tytbNUMBER_OF_RECORDS2 is table of LD_SAMPLE_FIN.NUMBER_OF_RECORDS2%type index by binary_integer;
	type tytbNUMBER_OF_RECORDS3 is table of LD_SAMPLE_FIN.NUMBER_OF_RECORDS3%type index by binary_integer;
	type tytbNUMBER_OF_RECORDS4 is table of LD_SAMPLE_FIN.NUMBER_OF_RECORDS4%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_SAMPLE_FIN is record
	(
		ID   tytbID,
		SAMPLE_ID   tytbSAMPLE_ID,
		FINAL_RECORD_INDICATOR   tytbFINAL_RECORD_INDICATOR,
		DATE_OF_PROCESS   tytbDATE_OF_PROCESS,
		NUMBER_OF_RECORD   tytbNUMBER_OF_RECORD,
		SUM_OF_NEW   tytbSUM_OF_NEW,
		FILLER   tytbFILLER,
		TYPE_REGISTER   tytbTYPE_REGISTER,
		TOTAL_NUMBER_OF_RECORDS   tytbTOTAL_NUMBER_OF_RECORDS,
		NUMBER_OF_RECORDS2   tytbNUMBER_OF_RECORDS2,
		NUMBER_OF_RECORDS3   tytbNUMBER_OF_RECORDS3,
		NUMBER_OF_RECORDS4   tytbNUMBER_OF_RECORDS4,
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
		inuID in LD_SAMPLE_FIN.ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID in LD_SAMPLE_FIN.ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID in LD_SAMPLE_FIN.ID%type
	);

	PROCEDURE getRecord
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		orcRecord out nocopy styLD_SAMPLE_FIN
	);

	FUNCTION frcGetRcData
	(
		inuID in LD_SAMPLE_FIN.ID%type
	)
	RETURN styLD_SAMPLE_FIN;

	FUNCTION frcGetRcData
	RETURN styLD_SAMPLE_FIN;

	FUNCTION frcGetRecord
	(
		inuID in LD_SAMPLE_FIN.ID%type
	)
	RETURN styLD_SAMPLE_FIN;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_SAMPLE_FIN
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_SAMPLE_FIN in styLD_SAMPLE_FIN
	);

	PROCEDURE insRecord
	(
		ircLD_SAMPLE_FIN in styLD_SAMPLE_FIN,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_SAMPLE_FIN in out nocopy tytbLD_SAMPLE_FIN
	);

	PROCEDURE delRecord
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_SAMPLE_FIN in out nocopy tytbLD_SAMPLE_FIN,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_SAMPLE_FIN in styLD_SAMPLE_FIN,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_SAMPLE_FIN in out nocopy tytbLD_SAMPLE_FIN,
		inuLock in number default 1
	);

	PROCEDURE updSAMPLE_ID
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuSAMPLE_ID$ in LD_SAMPLE_FIN.SAMPLE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updFINAL_RECORD_INDICATOR
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		isbFINAL_RECORD_INDICATOR$ in LD_SAMPLE_FIN.FINAL_RECORD_INDICATOR%type,
		inuLock in number default 0
	);

	PROCEDURE updDATE_OF_PROCESS
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		idtDATE_OF_PROCESS$ in LD_SAMPLE_FIN.DATE_OF_PROCESS%type,
		inuLock in number default 0
	);

	PROCEDURE updNUMBER_OF_RECORD
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuNUMBER_OF_RECORD$ in LD_SAMPLE_FIN.NUMBER_OF_RECORD%type,
		inuLock in number default 0
	);

	PROCEDURE updSUM_OF_NEW
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuSUM_OF_NEW$ in LD_SAMPLE_FIN.SUM_OF_NEW%type,
		inuLock in number default 0
	);

	PROCEDURE updFILLER
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		isbFILLER$ in LD_SAMPLE_FIN.FILLER%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_REGISTER
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuTYPE_REGISTER$ in LD_SAMPLE_FIN.TYPE_REGISTER%type,
		inuLock in number default 0
	);

	PROCEDURE updTOTAL_NUMBER_OF_RECORDS
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuTOTAL_NUMBER_OF_RECORDS$ in LD_SAMPLE_FIN.TOTAL_NUMBER_OF_RECORDS%type,
		inuLock in number default 0
	);

	PROCEDURE updNUMBER_OF_RECORDS2
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuNUMBER_OF_RECORDS2$ in LD_SAMPLE_FIN.NUMBER_OF_RECORDS2%type,
		inuLock in number default 0
	);

	PROCEDURE updNUMBER_OF_RECORDS3
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuNUMBER_OF_RECORDS3$ in LD_SAMPLE_FIN.NUMBER_OF_RECORDS3%type,
		inuLock in number default 0
	);

	PROCEDURE updNUMBER_OF_RECORDS4
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuNUMBER_OF_RECORDS4$ in LD_SAMPLE_FIN.NUMBER_OF_RECORDS4%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.ID%type;

	FUNCTION fnuGetSAMPLE_ID
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.SAMPLE_ID%type;

	FUNCTION fsbGetFINAL_RECORD_INDICATOR
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.FINAL_RECORD_INDICATOR%type;

	FUNCTION fdtGetDATE_OF_PROCESS
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.DATE_OF_PROCESS%type;

	FUNCTION fnuGetNUMBER_OF_RECORD
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.NUMBER_OF_RECORD%type;

	FUNCTION fnuGetSUM_OF_NEW
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.SUM_OF_NEW%type;

	FUNCTION fsbGetFILLER
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.FILLER%type;

	FUNCTION fnuGetTYPE_REGISTER
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.TYPE_REGISTER%type;

	FUNCTION fnuGetTOTAL_NUMBER_OF_RECORDS
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.TOTAL_NUMBER_OF_RECORDS%type;

	FUNCTION fnuGetNUMBER_OF_RECORDS2
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.NUMBER_OF_RECORDS2%type;

	FUNCTION fnuGetNUMBER_OF_RECORDS3
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.NUMBER_OF_RECORDS3%type;

	FUNCTION fnuGetNUMBER_OF_RECORDS4
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.NUMBER_OF_RECORDS4%type;


	PROCEDURE LockByPk
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		orcLD_SAMPLE_FIN  out styLD_SAMPLE_FIN
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_SAMPLE_FIN  out styLD_SAMPLE_FIN
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_SAMPLE_FIN;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.dald_sample_fin
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO193378';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SAMPLE_FIN';
	 cnuGeEntityId constant varchar2(30) := 8575; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID in LD_SAMPLE_FIN.ID%type
	)
	IS
		SELECT LD_SAMPLE_FIN.*,LD_SAMPLE_FIN.rowid
		FROM LD_SAMPLE_FIN
		WHERE  ID = inuID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_SAMPLE_FIN.*,LD_SAMPLE_FIN.rowid
		FROM LD_SAMPLE_FIN
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_SAMPLE_FIN is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_SAMPLE_FIN;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_SAMPLE_FIN default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		orcLD_SAMPLE_FIN  out styLD_SAMPLE_FIN
	)
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN
		rcError.ID := inuID;

		Open cuLockRcByPk
		(
			inuID
		);

		fetch cuLockRcByPk into orcLD_SAMPLE_FIN;
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
		orcLD_SAMPLE_FIN  out styLD_SAMPLE_FIN
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_SAMPLE_FIN;
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
		itbLD_SAMPLE_FIN  in out nocopy tytbLD_SAMPLE_FIN
	)
	IS
	BEGIN
			rcRecOfTab.ID.delete;
			rcRecOfTab.SAMPLE_ID.delete;
			rcRecOfTab.FINAL_RECORD_INDICATOR.delete;
			rcRecOfTab.DATE_OF_PROCESS.delete;
			rcRecOfTab.NUMBER_OF_RECORD.delete;
			rcRecOfTab.SUM_OF_NEW.delete;
			rcRecOfTab.FILLER.delete;
			rcRecOfTab.TYPE_REGISTER.delete;
			rcRecOfTab.TOTAL_NUMBER_OF_RECORDS.delete;
			rcRecOfTab.NUMBER_OF_RECORDS2.delete;
			rcRecOfTab.NUMBER_OF_RECORDS3.delete;
			rcRecOfTab.NUMBER_OF_RECORDS4.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_SAMPLE_FIN  in out nocopy tytbLD_SAMPLE_FIN,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_SAMPLE_FIN);

		for n in itbLD_SAMPLE_FIN.first .. itbLD_SAMPLE_FIN.last loop
			rcRecOfTab.ID(n) := itbLD_SAMPLE_FIN(n).ID;
			rcRecOfTab.SAMPLE_ID(n) := itbLD_SAMPLE_FIN(n).SAMPLE_ID;
			rcRecOfTab.FINAL_RECORD_INDICATOR(n) := itbLD_SAMPLE_FIN(n).FINAL_RECORD_INDICATOR;
			rcRecOfTab.DATE_OF_PROCESS(n) := itbLD_SAMPLE_FIN(n).DATE_OF_PROCESS;
			rcRecOfTab.NUMBER_OF_RECORD(n) := itbLD_SAMPLE_FIN(n).NUMBER_OF_RECORD;
			rcRecOfTab.SUM_OF_NEW(n) := itbLD_SAMPLE_FIN(n).SUM_OF_NEW;
			rcRecOfTab.FILLER(n) := itbLD_SAMPLE_FIN(n).FILLER;
			rcRecOfTab.TYPE_REGISTER(n) := itbLD_SAMPLE_FIN(n).TYPE_REGISTER;
			rcRecOfTab.TOTAL_NUMBER_OF_RECORDS(n) := itbLD_SAMPLE_FIN(n).TOTAL_NUMBER_OF_RECORDS;
			rcRecOfTab.NUMBER_OF_RECORDS2(n) := itbLD_SAMPLE_FIN(n).NUMBER_OF_RECORDS2;
			rcRecOfTab.NUMBER_OF_RECORDS3(n) := itbLD_SAMPLE_FIN(n).NUMBER_OF_RECORDS3;
			rcRecOfTab.NUMBER_OF_RECORDS4(n) := itbLD_SAMPLE_FIN(n).NUMBER_OF_RECORDS4;
			rcRecOfTab.row_id(n) := itbLD_SAMPLE_FIN(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID in LD_SAMPLE_FIN.ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID
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
		inuID in LD_SAMPLE_FIN.ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID = rcData.ID
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
		inuID in LD_SAMPLE_FIN.ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID in LD_SAMPLE_FIN.ID%type
	)
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN		rcError.ID:=inuID;

		Load
		(
			inuID
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
		inuID in LD_SAMPLE_FIN.ID%type
	)
	IS
	BEGIN
		Load
		(
			inuID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		orcRecord out nocopy styLD_SAMPLE_FIN
	)
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN		rcError.ID:=inuID;

		Load
		(
			inuID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID in LD_SAMPLE_FIN.ID%type
	)
	RETURN styLD_SAMPLE_FIN
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN
		rcError.ID:=inuID;

		Load
		(
			inuID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID in LD_SAMPLE_FIN.ID%type
	)
	RETURN styLD_SAMPLE_FIN
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN
		rcError.ID:=inuID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_SAMPLE_FIN
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_SAMPLE_FIN
	)
	IS
		rfLD_SAMPLE_FIN tyrfLD_SAMPLE_FIN;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_SAMPLE_FIN.*, LD_SAMPLE_FIN.rowid FROM LD_SAMPLE_FIN';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_SAMPLE_FIN for sbFullQuery;

		fetch rfLD_SAMPLE_FIN bulk collect INTO otbResult;

		close rfLD_SAMPLE_FIN;
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
		sbSQL VARCHAR2 (32000) := 'select LD_SAMPLE_FIN.*, LD_SAMPLE_FIN.rowid FROM LD_SAMPLE_FIN';
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
		ircLD_SAMPLE_FIN in styLD_SAMPLE_FIN
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_SAMPLE_FIN,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_SAMPLE_FIN in styLD_SAMPLE_FIN,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_SAMPLE_FIN.ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID');
			raise ex.controlled_error;
		end if;

		insert into LD_SAMPLE_FIN
		(
			ID,
			SAMPLE_ID,
			FINAL_RECORD_INDICATOR,
			DATE_OF_PROCESS,
			NUMBER_OF_RECORD,
			SUM_OF_NEW,
			FILLER,
			TYPE_REGISTER,
			TOTAL_NUMBER_OF_RECORDS,
			NUMBER_OF_RECORDS2,
			NUMBER_OF_RECORDS3,
			NUMBER_OF_RECORDS4
		)
		values
		(
			ircLD_SAMPLE_FIN.ID,
			ircLD_SAMPLE_FIN.SAMPLE_ID,
			ircLD_SAMPLE_FIN.FINAL_RECORD_INDICATOR,
			ircLD_SAMPLE_FIN.DATE_OF_PROCESS,
			ircLD_SAMPLE_FIN.NUMBER_OF_RECORD,
			ircLD_SAMPLE_FIN.SUM_OF_NEW,
			ircLD_SAMPLE_FIN.FILLER,
			ircLD_SAMPLE_FIN.TYPE_REGISTER,
			ircLD_SAMPLE_FIN.TOTAL_NUMBER_OF_RECORDS,
			ircLD_SAMPLE_FIN.NUMBER_OF_RECORDS2,
			ircLD_SAMPLE_FIN.NUMBER_OF_RECORDS3,
			ircLD_SAMPLE_FIN.NUMBER_OF_RECORDS4
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_SAMPLE_FIN));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_SAMPLE_FIN in out nocopy tytbLD_SAMPLE_FIN
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_SAMPLE_FIN,blUseRowID);
		forall n in iotbLD_SAMPLE_FIN.first..iotbLD_SAMPLE_FIN.last
			insert into LD_SAMPLE_FIN
			(
				ID,
				SAMPLE_ID,
				FINAL_RECORD_INDICATOR,
				DATE_OF_PROCESS,
				NUMBER_OF_RECORD,
				SUM_OF_NEW,
				FILLER,
				TYPE_REGISTER,
				TOTAL_NUMBER_OF_RECORDS,
				NUMBER_OF_RECORDS2,
				NUMBER_OF_RECORDS3,
				NUMBER_OF_RECORDS4
			)
			values
			(
				rcRecOfTab.ID(n),
				rcRecOfTab.SAMPLE_ID(n),
				rcRecOfTab.FINAL_RECORD_INDICATOR(n),
				rcRecOfTab.DATE_OF_PROCESS(n),
				rcRecOfTab.NUMBER_OF_RECORD(n),
				rcRecOfTab.SUM_OF_NEW(n),
				rcRecOfTab.FILLER(n),
				rcRecOfTab.TYPE_REGISTER(n),
				rcRecOfTab.TOTAL_NUMBER_OF_RECORDS(n),
				rcRecOfTab.NUMBER_OF_RECORDS2(n),
				rcRecOfTab.NUMBER_OF_RECORDS3(n),
				rcRecOfTab.NUMBER_OF_RECORDS4(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN
		rcError.ID := inuID;

		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;


		delete
		from LD_SAMPLE_FIN
		where
       		ID=inuID;
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
		rcError  styLD_SAMPLE_FIN;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_SAMPLE_FIN
		where
			rowid = iriRowID
		returning
			ID
		into
			rcError.ID;
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
		iotbLD_SAMPLE_FIN in out nocopy tytbLD_SAMPLE_FIN,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_SAMPLE_FIN;
	BEGIN
		FillRecordOfTables(iotbLD_SAMPLE_FIN, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_SAMPLE_FIN.first .. iotbLD_SAMPLE_FIN.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SAMPLE_FIN.first .. iotbLD_SAMPLE_FIN.last
				delete
				from LD_SAMPLE_FIN
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_SAMPLE_FIN.first .. iotbLD_SAMPLE_FIN.last loop
					LockByPk
					(
						rcRecOfTab.ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SAMPLE_FIN.first .. iotbLD_SAMPLE_FIN.last
				delete
				from LD_SAMPLE_FIN
				where
		         	ID = rcRecOfTab.ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_SAMPLE_FIN in styLD_SAMPLE_FIN,
		inuLock in number default 0
	)
	IS
		nuID	LD_SAMPLE_FIN.ID%type;
	BEGIN
		if ircLD_SAMPLE_FIN.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_SAMPLE_FIN.rowid,rcData);
			end if;
			update LD_SAMPLE_FIN
			set
				SAMPLE_ID = ircLD_SAMPLE_FIN.SAMPLE_ID,
				FINAL_RECORD_INDICATOR = ircLD_SAMPLE_FIN.FINAL_RECORD_INDICATOR,
				DATE_OF_PROCESS = ircLD_SAMPLE_FIN.DATE_OF_PROCESS,
				NUMBER_OF_RECORD = ircLD_SAMPLE_FIN.NUMBER_OF_RECORD,
				SUM_OF_NEW = ircLD_SAMPLE_FIN.SUM_OF_NEW,
				FILLER = ircLD_SAMPLE_FIN.FILLER,
				TYPE_REGISTER = ircLD_SAMPLE_FIN.TYPE_REGISTER,
				TOTAL_NUMBER_OF_RECORDS = ircLD_SAMPLE_FIN.TOTAL_NUMBER_OF_RECORDS,
				NUMBER_OF_RECORDS2 = ircLD_SAMPLE_FIN.NUMBER_OF_RECORDS2,
				NUMBER_OF_RECORDS3 = ircLD_SAMPLE_FIN.NUMBER_OF_RECORDS3,
				NUMBER_OF_RECORDS4 = ircLD_SAMPLE_FIN.NUMBER_OF_RECORDS4
			where
				rowid = ircLD_SAMPLE_FIN.rowid
			returning
				ID
			into
				nuID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_SAMPLE_FIN.ID,
					rcData
				);
			end if;

			update LD_SAMPLE_FIN
			set
				SAMPLE_ID = ircLD_SAMPLE_FIN.SAMPLE_ID,
				FINAL_RECORD_INDICATOR = ircLD_SAMPLE_FIN.FINAL_RECORD_INDICATOR,
				DATE_OF_PROCESS = ircLD_SAMPLE_FIN.DATE_OF_PROCESS,
				NUMBER_OF_RECORD = ircLD_SAMPLE_FIN.NUMBER_OF_RECORD,
				SUM_OF_NEW = ircLD_SAMPLE_FIN.SUM_OF_NEW,
				FILLER = ircLD_SAMPLE_FIN.FILLER,
				TYPE_REGISTER = ircLD_SAMPLE_FIN.TYPE_REGISTER,
				TOTAL_NUMBER_OF_RECORDS = ircLD_SAMPLE_FIN.TOTAL_NUMBER_OF_RECORDS,
				NUMBER_OF_RECORDS2 = ircLD_SAMPLE_FIN.NUMBER_OF_RECORDS2,
				NUMBER_OF_RECORDS3 = ircLD_SAMPLE_FIN.NUMBER_OF_RECORDS3,
				NUMBER_OF_RECORDS4 = ircLD_SAMPLE_FIN.NUMBER_OF_RECORDS4
			where
				ID = ircLD_SAMPLE_FIN.ID
			returning
				ID
			into
				nuID;
		end if;
		if
			nuID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_SAMPLE_FIN));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_SAMPLE_FIN in out nocopy tytbLD_SAMPLE_FIN,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_SAMPLE_FIN;
	BEGIN
		FillRecordOfTables(iotbLD_SAMPLE_FIN,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_SAMPLE_FIN.first .. iotbLD_SAMPLE_FIN.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SAMPLE_FIN.first .. iotbLD_SAMPLE_FIN.last
				update LD_SAMPLE_FIN
				set
					SAMPLE_ID = rcRecOfTab.SAMPLE_ID(n),
					FINAL_RECORD_INDICATOR = rcRecOfTab.FINAL_RECORD_INDICATOR(n),
					DATE_OF_PROCESS = rcRecOfTab.DATE_OF_PROCESS(n),
					NUMBER_OF_RECORD = rcRecOfTab.NUMBER_OF_RECORD(n),
					SUM_OF_NEW = rcRecOfTab.SUM_OF_NEW(n),
					FILLER = rcRecOfTab.FILLER(n),
					TYPE_REGISTER = rcRecOfTab.TYPE_REGISTER(n),
					TOTAL_NUMBER_OF_RECORDS = rcRecOfTab.TOTAL_NUMBER_OF_RECORDS(n),
					NUMBER_OF_RECORDS2 = rcRecOfTab.NUMBER_OF_RECORDS2(n),
					NUMBER_OF_RECORDS3 = rcRecOfTab.NUMBER_OF_RECORDS3(n),
					NUMBER_OF_RECORDS4 = rcRecOfTab.NUMBER_OF_RECORDS4(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_SAMPLE_FIN.first .. iotbLD_SAMPLE_FIN.last loop
					LockByPk
					(
						rcRecOfTab.ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SAMPLE_FIN.first .. iotbLD_SAMPLE_FIN.last
				update LD_SAMPLE_FIN
				SET
					SAMPLE_ID = rcRecOfTab.SAMPLE_ID(n),
					FINAL_RECORD_INDICATOR = rcRecOfTab.FINAL_RECORD_INDICATOR(n),
					DATE_OF_PROCESS = rcRecOfTab.DATE_OF_PROCESS(n),
					NUMBER_OF_RECORD = rcRecOfTab.NUMBER_OF_RECORD(n),
					SUM_OF_NEW = rcRecOfTab.SUM_OF_NEW(n),
					FILLER = rcRecOfTab.FILLER(n),
					TYPE_REGISTER = rcRecOfTab.TYPE_REGISTER(n),
					TOTAL_NUMBER_OF_RECORDS = rcRecOfTab.TOTAL_NUMBER_OF_RECORDS(n),
					NUMBER_OF_RECORDS2 = rcRecOfTab.NUMBER_OF_RECORDS2(n),
					NUMBER_OF_RECORDS3 = rcRecOfTab.NUMBER_OF_RECORDS3(n),
					NUMBER_OF_RECORDS4 = rcRecOfTab.NUMBER_OF_RECORDS4(n)
				where
					ID = rcRecOfTab.ID(n)
;
		end if;
	END;
	PROCEDURE updSAMPLE_ID
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuSAMPLE_ID$ in LD_SAMPLE_FIN.SAMPLE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN
		rcError.ID := inuID;
		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;

		update LD_SAMPLE_FIN
		set
			SAMPLE_ID = inuSAMPLE_ID$
		where
			ID = inuID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SAMPLE_ID:= inuSAMPLE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFINAL_RECORD_INDICATOR
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		isbFINAL_RECORD_INDICATOR$ in LD_SAMPLE_FIN.FINAL_RECORD_INDICATOR%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN
		rcError.ID := inuID;
		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;

		update LD_SAMPLE_FIN
		set
			FINAL_RECORD_INDICATOR = isbFINAL_RECORD_INDICATOR$
		where
			ID = inuID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FINAL_RECORD_INDICATOR:= isbFINAL_RECORD_INDICATOR$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDATE_OF_PROCESS
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		idtDATE_OF_PROCESS$ in LD_SAMPLE_FIN.DATE_OF_PROCESS%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN
		rcError.ID := inuID;
		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;

		update LD_SAMPLE_FIN
		set
			DATE_OF_PROCESS = idtDATE_OF_PROCESS$
		where
			ID = inuID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DATE_OF_PROCESS:= idtDATE_OF_PROCESS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNUMBER_OF_RECORD
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuNUMBER_OF_RECORD$ in LD_SAMPLE_FIN.NUMBER_OF_RECORD%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN
		rcError.ID := inuID;
		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;

		update LD_SAMPLE_FIN
		set
			NUMBER_OF_RECORD = inuNUMBER_OF_RECORD$
		where
			ID = inuID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NUMBER_OF_RECORD:= inuNUMBER_OF_RECORD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUM_OF_NEW
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuSUM_OF_NEW$ in LD_SAMPLE_FIN.SUM_OF_NEW%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN
		rcError.ID := inuID;
		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;

		update LD_SAMPLE_FIN
		set
			SUM_OF_NEW = inuSUM_OF_NEW$
		where
			ID = inuID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUM_OF_NEW:= inuSUM_OF_NEW$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFILLER
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		isbFILLER$ in LD_SAMPLE_FIN.FILLER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN
		rcError.ID := inuID;
		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;

		update LD_SAMPLE_FIN
		set
			FILLER = isbFILLER$
		where
			ID = inuID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FILLER:= isbFILLER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_REGISTER
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuTYPE_REGISTER$ in LD_SAMPLE_FIN.TYPE_REGISTER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN
		rcError.ID := inuID;
		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;

		update LD_SAMPLE_FIN
		set
			TYPE_REGISTER = inuTYPE_REGISTER$
		where
			ID = inuID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_REGISTER:= inuTYPE_REGISTER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTOTAL_NUMBER_OF_RECORDS
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuTOTAL_NUMBER_OF_RECORDS$ in LD_SAMPLE_FIN.TOTAL_NUMBER_OF_RECORDS%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN
		rcError.ID := inuID;
		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;

		update LD_SAMPLE_FIN
		set
			TOTAL_NUMBER_OF_RECORDS = inuTOTAL_NUMBER_OF_RECORDS$
		where
			ID = inuID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TOTAL_NUMBER_OF_RECORDS:= inuTOTAL_NUMBER_OF_RECORDS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNUMBER_OF_RECORDS2
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuNUMBER_OF_RECORDS2$ in LD_SAMPLE_FIN.NUMBER_OF_RECORDS2%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN
		rcError.ID := inuID;
		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;

		update LD_SAMPLE_FIN
		set
			NUMBER_OF_RECORDS2 = inuNUMBER_OF_RECORDS2$
		where
			ID = inuID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NUMBER_OF_RECORDS2:= inuNUMBER_OF_RECORDS2$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNUMBER_OF_RECORDS3
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuNUMBER_OF_RECORDS3$ in LD_SAMPLE_FIN.NUMBER_OF_RECORDS3%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN
		rcError.ID := inuID;
		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;

		update LD_SAMPLE_FIN
		set
			NUMBER_OF_RECORDS3 = inuNUMBER_OF_RECORDS3$
		where
			ID = inuID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NUMBER_OF_RECORDS3:= inuNUMBER_OF_RECORDS3$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNUMBER_OF_RECORDS4
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuNUMBER_OF_RECORDS4$ in LD_SAMPLE_FIN.NUMBER_OF_RECORDS4%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN
		rcError.ID := inuID;
		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;

		update LD_SAMPLE_FIN
		set
			NUMBER_OF_RECORDS4 = inuNUMBER_OF_RECORDS4$
		where
			ID = inuID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NUMBER_OF_RECORDS4:= inuNUMBER_OF_RECORDS4$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.ID%type
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.ID);
		end if;
		Load
		(
		 		inuID
		);
		return(rcData.ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSAMPLE_ID
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.SAMPLE_ID%type
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.SAMPLE_ID);
		end if;
		Load
		(
		 		inuID
		);
		return(rcData.SAMPLE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetFINAL_RECORD_INDICATOR
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.FINAL_RECORD_INDICATOR%type
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.FINAL_RECORD_INDICATOR);
		end if;
		Load
		(
		 		inuID
		);
		return(rcData.FINAL_RECORD_INDICATOR);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetDATE_OF_PROCESS
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.DATE_OF_PROCESS%type
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.DATE_OF_PROCESS);
		end if;
		Load
		(
		 		inuID
		);
		return(rcData.DATE_OF_PROCESS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetNUMBER_OF_RECORD
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.NUMBER_OF_RECORD%type
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.NUMBER_OF_RECORD);
		end if;
		Load
		(
		 		inuID
		);
		return(rcData.NUMBER_OF_RECORD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUM_OF_NEW
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.SUM_OF_NEW%type
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.SUM_OF_NEW);
		end if;
		Load
		(
		 		inuID
		);
		return(rcData.SUM_OF_NEW);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetFILLER
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.FILLER%type
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.FILLER);
		end if;
		Load
		(
		 		inuID
		);
		return(rcData.FILLER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTYPE_REGISTER
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.TYPE_REGISTER%type
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.TYPE_REGISTER);
		end if;
		Load
		(
		 		inuID
		);
		return(rcData.TYPE_REGISTER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTOTAL_NUMBER_OF_RECORDS
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.TOTAL_NUMBER_OF_RECORDS%type
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.TOTAL_NUMBER_OF_RECORDS);
		end if;
		Load
		(
		 		inuID
		);
		return(rcData.TOTAL_NUMBER_OF_RECORDS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetNUMBER_OF_RECORDS2
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.NUMBER_OF_RECORDS2%type
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.NUMBER_OF_RECORDS2);
		end if;
		Load
		(
		 		inuID
		);
		return(rcData.NUMBER_OF_RECORDS2);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetNUMBER_OF_RECORDS3
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.NUMBER_OF_RECORDS3%type
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.NUMBER_OF_RECORDS3);
		end if;
		Load
		(
		 		inuID
		);
		return(rcData.NUMBER_OF_RECORDS3);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetNUMBER_OF_RECORDS4
	(
		inuID in LD_SAMPLE_FIN.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_FIN.NUMBER_OF_RECORDS4%type
	IS
		rcError styLD_SAMPLE_FIN;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.NUMBER_OF_RECORDS4);
		end if;
		Load
		(
		 		inuID
		);
		return(rcData.NUMBER_OF_RECORDS4);
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
end DALD_SAMPLE_FIN;
/
PROMPT Otorgando permisos de ejecucion a DALD_SAMPLE_FIN
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SAMPLE_FIN', 'ADM_PERSON');
END;
/
