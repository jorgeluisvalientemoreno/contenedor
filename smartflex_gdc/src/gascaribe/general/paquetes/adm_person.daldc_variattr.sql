CREATE OR REPLACE PACKAGE adm_person.daldc_variattr
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type
	)
	IS
		SELECT LDC_VARIATTR.*,LDC_VARIATTR.rowid
		FROM LDC_VARIATTR
		WHERE
		    VAATCODI = inuVAATCODI;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_VARIATTR.*,LDC_VARIATTR.rowid
		FROM LDC_VARIATTR
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_VARIATTR  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_VARIATTR is table of styLDC_VARIATTR index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_VARIATTR;

	/* Tipos referenciando al registro */
	type tytbVAATCODI is table of LDC_VARIATTR.VAATCODI%type index by binary_integer;
	type tytbVAATVACE is table of LDC_VARIATTR.VAATVACE%type index by binary_integer;
	type tytbVAATPLTE is table of LDC_VARIATTR.VAATPLTE%type index by binary_integer;
	type tytbVAATVAAT is table of LDC_VARIATTR.VAATVAAT%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_VARIATTR is record
	(
		VAATCODI   tytbVAATCODI,
		VAATVACE   tytbVAATVACE,
		VAATPLTE   tytbVAATPLTE,
		VAATVAAT   tytbVAATVAAT,
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
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type
	);

	PROCEDURE getRecord
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		orcRecord out nocopy styLDC_VARIATTR
	);

	FUNCTION frcGetRcData
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type
	)
	RETURN styLDC_VARIATTR;

	FUNCTION frcGetRcData
	RETURN styLDC_VARIATTR;

	FUNCTION frcGetRecord
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type
	)
	RETURN styLDC_VARIATTR;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VARIATTR
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_VARIATTR in styLDC_VARIATTR
	);

	PROCEDURE insRecord
	(
		ircLDC_VARIATTR in styLDC_VARIATTR,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_VARIATTR in out nocopy tytbLDC_VARIATTR
	);

	PROCEDURE delRecord
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_VARIATTR in out nocopy tytbLDC_VARIATTR,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_VARIATTR in styLDC_VARIATTR,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_VARIATTR in out nocopy tytbLDC_VARIATTR,
		inuLock in number default 1
	);

	PROCEDURE updVAATVACE
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		inuVAATVACE$ in LDC_VARIATTR.VAATVACE%type,
		inuLock in number default 0
	);

	PROCEDURE updVAATPLTE
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		inuVAATPLTE$ in LDC_VARIATTR.VAATPLTE%type,
		inuLock in number default 0
	);

	PROCEDURE updVAATVAAT
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		inuVAATVAAT$ in LDC_VARIATTR.VAATVAAT%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetVAATCODI
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIATTR.VAATCODI%type;

	FUNCTION fnuGetVAATVACE
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIATTR.VAATVACE%type;

	FUNCTION fnuGetVAATPLTE
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIATTR.VAATPLTE%type;

	FUNCTION fnuGetVAATVAAT
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIATTR.VAATVAAT%type;


	PROCEDURE LockByPk
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		orcLDC_VARIATTR  out styLDC_VARIATTR
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_VARIATTR  out styLDC_VARIATTR
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_VARIATTR;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_VARIATTR
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_VARIATTR';
	 cnuGeEntityId constant varchar2(30) := 8432; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type
	)
	IS
		SELECT LDC_VARIATTR.*,LDC_VARIATTR.rowid
		FROM LDC_VARIATTR
		WHERE  VAATCODI = inuVAATCODI
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_VARIATTR.*,LDC_VARIATTR.rowid
		FROM LDC_VARIATTR
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_VARIATTR is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_VARIATTR;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_VARIATTR default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.VAATCODI);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		orcLDC_VARIATTR  out styLDC_VARIATTR
	)
	IS
		rcError styLDC_VARIATTR;
	BEGIN
		rcError.VAATCODI := inuVAATCODI;

		Open cuLockRcByPk
		(
			inuVAATCODI
		);

		fetch cuLockRcByPk into orcLDC_VARIATTR;
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
		orcLDC_VARIATTR  out styLDC_VARIATTR
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_VARIATTR;
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
		itbLDC_VARIATTR  in out nocopy tytbLDC_VARIATTR
	)
	IS
	BEGIN
			rcRecOfTab.VAATCODI.delete;
			rcRecOfTab.VAATVACE.delete;
			rcRecOfTab.VAATPLTE.delete;
			rcRecOfTab.VAATVAAT.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_VARIATTR  in out nocopy tytbLDC_VARIATTR,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_VARIATTR);

		for n in itbLDC_VARIATTR.first .. itbLDC_VARIATTR.last loop
			rcRecOfTab.VAATCODI(n) := itbLDC_VARIATTR(n).VAATCODI;
			rcRecOfTab.VAATVACE(n) := itbLDC_VARIATTR(n).VAATVACE;
			rcRecOfTab.VAATPLTE(n) := itbLDC_VARIATTR(n).VAATPLTE;
			rcRecOfTab.VAATVAAT(n) := itbLDC_VARIATTR(n).VAATVAAT;
			rcRecOfTab.row_id(n) := itbLDC_VARIATTR(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuVAATCODI
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
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuVAATCODI = rcData.VAATCODI
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
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuVAATCODI
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type
	)
	IS
		rcError styLDC_VARIATTR;
	BEGIN		rcError.VAATCODI:=inuVAATCODI;

		Load
		(
			inuVAATCODI
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
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type
	)
	IS
	BEGIN
		Load
		(
			inuVAATCODI
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		orcRecord out nocopy styLDC_VARIATTR
	)
	IS
		rcError styLDC_VARIATTR;
	BEGIN		rcError.VAATCODI:=inuVAATCODI;

		Load
		(
			inuVAATCODI
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type
	)
	RETURN styLDC_VARIATTR
	IS
		rcError styLDC_VARIATTR;
	BEGIN
		rcError.VAATCODI:=inuVAATCODI;

		Load
		(
			inuVAATCODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type
	)
	RETURN styLDC_VARIATTR
	IS
		rcError styLDC_VARIATTR;
	BEGIN
		rcError.VAATCODI:=inuVAATCODI;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuVAATCODI
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuVAATCODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_VARIATTR
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VARIATTR
	)
	IS
		rfLDC_VARIATTR tyrfLDC_VARIATTR;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_VARIATTR.*, LDC_VARIATTR.rowid FROM LDC_VARIATTR';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_VARIATTR for sbFullQuery;

		fetch rfLDC_VARIATTR bulk collect INTO otbResult;

		close rfLDC_VARIATTR;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_VARIATTR.*, LDC_VARIATTR.rowid FROM LDC_VARIATTR';
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
		ircLDC_VARIATTR in styLDC_VARIATTR
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_VARIATTR,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_VARIATTR in styLDC_VARIATTR,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_VARIATTR.VAATCODI is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|VAATCODI');
			raise ex.controlled_error;
		end if;

		insert into LDC_VARIATTR
		(
			VAATCODI,
			VAATVACE,
			VAATPLTE,
			VAATVAAT
		)
		values
		(
			ircLDC_VARIATTR.VAATCODI,
			ircLDC_VARIATTR.VAATVACE,
			ircLDC_VARIATTR.VAATPLTE,
			ircLDC_VARIATTR.VAATVAAT
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_VARIATTR));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_VARIATTR in out nocopy tytbLDC_VARIATTR
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_VARIATTR,blUseRowID);
		forall n in iotbLDC_VARIATTR.first..iotbLDC_VARIATTR.last
			insert into LDC_VARIATTR
			(
				VAATCODI,
				VAATVACE,
				VAATPLTE,
				VAATVAAT
			)
			values
			(
				rcRecOfTab.VAATCODI(n),
				rcRecOfTab.VAATVACE(n),
				rcRecOfTab.VAATPLTE(n),
				rcRecOfTab.VAATVAAT(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_VARIATTR;
	BEGIN
		rcError.VAATCODI := inuVAATCODI;

		if inuLock=1 then
			LockByPk
			(
				inuVAATCODI,
				rcData
			);
		end if;


		delete
		from LDC_VARIATTR
		where
       		VAATCODI=inuVAATCODI;
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
		rcError  styLDC_VARIATTR;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_VARIATTR
		where
			rowid = iriRowID
		returning
			VAATCODI
		into
			rcError.VAATCODI;
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
		iotbLDC_VARIATTR in out nocopy tytbLDC_VARIATTR,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VARIATTR;
	BEGIN
		FillRecordOfTables(iotbLDC_VARIATTR, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_VARIATTR.first .. iotbLDC_VARIATTR.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VARIATTR.first .. iotbLDC_VARIATTR.last
				delete
				from LDC_VARIATTR
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VARIATTR.first .. iotbLDC_VARIATTR.last loop
					LockByPk
					(
						rcRecOfTab.VAATCODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VARIATTR.first .. iotbLDC_VARIATTR.last
				delete
				from LDC_VARIATTR
				where
		         	VAATCODI = rcRecOfTab.VAATCODI(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_VARIATTR in styLDC_VARIATTR,
		inuLock in number default 0
	)
	IS
		nuVAATCODI	LDC_VARIATTR.VAATCODI%type;
	BEGIN
		if ircLDC_VARIATTR.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_VARIATTR.rowid,rcData);
			end if;
			update LDC_VARIATTR
			set
				VAATVACE = ircLDC_VARIATTR.VAATVACE,
				VAATPLTE = ircLDC_VARIATTR.VAATPLTE,
				VAATVAAT = ircLDC_VARIATTR.VAATVAAT
			where
				rowid = ircLDC_VARIATTR.rowid
			returning
				VAATCODI
			into
				nuVAATCODI;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_VARIATTR.VAATCODI,
					rcData
				);
			end if;

			update LDC_VARIATTR
			set
				VAATVACE = ircLDC_VARIATTR.VAATVACE,
				VAATPLTE = ircLDC_VARIATTR.VAATPLTE,
				VAATVAAT = ircLDC_VARIATTR.VAATVAAT
			where
				VAATCODI = ircLDC_VARIATTR.VAATCODI
			returning
				VAATCODI
			into
				nuVAATCODI;
		end if;
		if
			nuVAATCODI is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_VARIATTR));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_VARIATTR in out nocopy tytbLDC_VARIATTR,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VARIATTR;
	BEGIN
		FillRecordOfTables(iotbLDC_VARIATTR,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_VARIATTR.first .. iotbLDC_VARIATTR.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VARIATTR.first .. iotbLDC_VARIATTR.last
				update LDC_VARIATTR
				set
					VAATVACE = rcRecOfTab.VAATVACE(n),
					VAATPLTE = rcRecOfTab.VAATPLTE(n),
					VAATVAAT = rcRecOfTab.VAATVAAT(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VARIATTR.first .. iotbLDC_VARIATTR.last loop
					LockByPk
					(
						rcRecOfTab.VAATCODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VARIATTR.first .. iotbLDC_VARIATTR.last
				update LDC_VARIATTR
				SET
					VAATVACE = rcRecOfTab.VAATVACE(n),
					VAATPLTE = rcRecOfTab.VAATPLTE(n),
					VAATVAAT = rcRecOfTab.VAATVAAT(n)
				where
					VAATCODI = rcRecOfTab.VAATCODI(n)
;
		end if;
	END;
	PROCEDURE updVAATVACE
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		inuVAATVACE$ in LDC_VARIATTR.VAATVACE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VARIATTR;
	BEGIN
		rcError.VAATCODI := inuVAATCODI;
		if inuLock=1 then
			LockByPk
			(
				inuVAATCODI,
				rcData
			);
		end if;

		update LDC_VARIATTR
		set
			VAATVACE = inuVAATVACE$
		where
			VAATCODI = inuVAATCODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VAATVACE:= inuVAATVACE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVAATPLTE
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		inuVAATPLTE$ in LDC_VARIATTR.VAATPLTE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VARIATTR;
	BEGIN
		rcError.VAATCODI := inuVAATCODI;
		if inuLock=1 then
			LockByPk
			(
				inuVAATCODI,
				rcData
			);
		end if;

		update LDC_VARIATTR
		set
			VAATPLTE = inuVAATPLTE$
		where
			VAATCODI = inuVAATCODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VAATPLTE:= inuVAATPLTE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVAATVAAT
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		inuVAATVAAT$ in LDC_VARIATTR.VAATVAAT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VARIATTR;
	BEGIN
		rcError.VAATCODI := inuVAATCODI;
		if inuLock=1 then
			LockByPk
			(
				inuVAATCODI,
				rcData
			);
		end if;

		update LDC_VARIATTR
		set
			VAATVAAT = inuVAATVAAT$
		where
			VAATCODI = inuVAATCODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VAATVAAT:= inuVAATVAAT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetVAATCODI
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIATTR.VAATCODI%type
	IS
		rcError styLDC_VARIATTR;
	BEGIN

		rcError.VAATCODI := inuVAATCODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVAATCODI
			 )
		then
			 return(rcData.VAATCODI);
		end if;
		Load
		(
		 		inuVAATCODI
		);
		return(rcData.VAATCODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVAATVACE
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIATTR.VAATVACE%type
	IS
		rcError styLDC_VARIATTR;
	BEGIN

		rcError.VAATCODI := inuVAATCODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVAATCODI
			 )
		then
			 return(rcData.VAATVACE);
		end if;
		Load
		(
		 		inuVAATCODI
		);
		return(rcData.VAATVACE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVAATPLTE
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIATTR.VAATPLTE%type
	IS
		rcError styLDC_VARIATTR;
	BEGIN

		rcError.VAATCODI := inuVAATCODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVAATCODI
			 )
		then
			 return(rcData.VAATPLTE);
		end if;
		Load
		(
		 		inuVAATCODI
		);
		return(rcData.VAATPLTE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVAATVAAT
	(
		inuVAATCODI in LDC_VARIATTR.VAATCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIATTR.VAATVAAT%type
	IS
		rcError styLDC_VARIATTR;
	BEGIN

		rcError.VAATCODI := inuVAATCODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVAATCODI
			 )
		then
			 return(rcData.VAATVAAT);
		end if;
		Load
		(
		 		inuVAATCODI
		);
		return(rcData.VAATVAAT);
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
end DALDC_VARIATTR;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_VARIATTR
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_VARIATTR', 'ADM_PERSON'); 
END;
/
