CREATE OR REPLACE PACKAGE adm_person.daldc_ca_liquidaedad
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type
	)
	IS
		SELECT LDC_CA_LIQUIDAEDAD.*,LDC_CA_LIQUIDAEDAD.rowid
		FROM LDC_CA_LIQUIDAEDAD
		WHERE
		    IDLIQUIDAEDAD = inuIDLIQUIDAEDAD;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CA_LIQUIDAEDAD.*,LDC_CA_LIQUIDAEDAD.rowid
		FROM LDC_CA_LIQUIDAEDAD
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CA_LIQUIDAEDAD  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CA_LIQUIDAEDAD is table of styLDC_CA_LIQUIDAEDAD index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CA_LIQUIDAEDAD;

	/* Tipos referenciando al registro */
	type tytbIDLIQUIDAEDAD is table of LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type index by binary_integer;
	type tytbIDOPERUNITXRANGOREC is table of LDC_CA_LIQUIDAEDAD.IDOPERUNITXRANGOREC%type index by binary_integer;
	type tytbLCLPORCINICIAL is table of LDC_CA_LIQUIDAEDAD.LCLPORCINICIAL%type index by binary_integer;
	type tytbLCLPORCFINAL is table of LDC_CA_LIQUIDAEDAD.LCLPORCFINAL%type index by binary_integer;
	type tytbLCLDIAINICIAL is table of LDC_CA_LIQUIDAEDAD.LCLDIAINICIAL%type index by binary_integer;
	type tytbLCLDIAFIANAL is table of LDC_CA_LIQUIDAEDAD.LCLDIAFIANAL%type index by binary_integer;
	type tytbLCLVALORFIJO is table of LDC_CA_LIQUIDAEDAD.LCLVALORFIJO%type index by binary_integer;
	type tytbLCLDEPARTAMENTO is table of LDC_CA_LIQUIDAEDAD.LCLDEPARTAMENTO%type index by binary_integer;
	type tytbLCLLOCALIDA is table of LDC_CA_LIQUIDAEDAD.LCLLOCALIDA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CA_LIQUIDAEDAD is record
	(
		IDLIQUIDAEDAD   tytbIDLIQUIDAEDAD,
		IDOPERUNITXRANGOREC   tytbIDOPERUNITXRANGOREC,
		LCLPORCINICIAL   tytbLCLPORCINICIAL,
		LCLPORCFINAL   tytbLCLPORCFINAL,
		LCLDIAINICIAL   tytbLCLDIAINICIAL,
		LCLDIAFIANAL   tytbLCLDIAFIANAL,
		LCLVALORFIJO   tytbLCLVALORFIJO,
		LCLDEPARTAMENTO   tytbLCLDEPARTAMENTO,
		LCLLOCALIDA   tytbLCLLOCALIDA,
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
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type
	);

	PROCEDURE getRecord
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		orcRecord out nocopy styLDC_CA_LIQUIDAEDAD
	);

	FUNCTION frcGetRcData
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type
	)
	RETURN styLDC_CA_LIQUIDAEDAD;

	FUNCTION frcGetRcData
	RETURN styLDC_CA_LIQUIDAEDAD;

	FUNCTION frcGetRecord
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type
	)
	RETURN styLDC_CA_LIQUIDAEDAD;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CA_LIQUIDAEDAD
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CA_LIQUIDAEDAD in styLDC_CA_LIQUIDAEDAD
	);

	PROCEDURE insRecord
	(
		ircLDC_CA_LIQUIDAEDAD in styLDC_CA_LIQUIDAEDAD,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CA_LIQUIDAEDAD in out nocopy tytbLDC_CA_LIQUIDAEDAD
	);

	PROCEDURE delRecord
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CA_LIQUIDAEDAD in out nocopy tytbLDC_CA_LIQUIDAEDAD,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CA_LIQUIDAEDAD in styLDC_CA_LIQUIDAEDAD,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CA_LIQUIDAEDAD in out nocopy tytbLDC_CA_LIQUIDAEDAD,
		inuLock in number default 1
	);

	PROCEDURE updIDOPERUNITXRANGOREC
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuIDOPERUNITXRANGOREC$ in LDC_CA_LIQUIDAEDAD.IDOPERUNITXRANGOREC%type,
		inuLock in number default 0
	);

	PROCEDURE updLCLPORCINICIAL
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuLCLPORCINICIAL$ in LDC_CA_LIQUIDAEDAD.LCLPORCINICIAL%type,
		inuLock in number default 0
	);

	PROCEDURE updLCLPORCFINAL
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuLCLPORCFINAL$ in LDC_CA_LIQUIDAEDAD.LCLPORCFINAL%type,
		inuLock in number default 0
	);

	PROCEDURE updLCLDIAINICIAL
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuLCLDIAINICIAL$ in LDC_CA_LIQUIDAEDAD.LCLDIAINICIAL%type,
		inuLock in number default 0
	);

	PROCEDURE updLCLDIAFIANAL
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuLCLDIAFIANAL$ in LDC_CA_LIQUIDAEDAD.LCLDIAFIANAL%type,
		inuLock in number default 0
	);

	PROCEDURE updLCLVALORFIJO
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuLCLVALORFIJO$ in LDC_CA_LIQUIDAEDAD.LCLVALORFIJO%type,
		inuLock in number default 0
	);

	PROCEDURE updLCLDEPARTAMENTO
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuLCLDEPARTAMENTO$ in LDC_CA_LIQUIDAEDAD.LCLDEPARTAMENTO%type,
		inuLock in number default 0
	);

	PROCEDURE updLCLLOCALIDA
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuLCLLOCALIDA$ in LDC_CA_LIQUIDAEDAD.LCLLOCALIDA%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetIDLIQUIDAEDAD
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type;

	FUNCTION fnuGetIDOPERUNITXRANGOREC
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.IDOPERUNITXRANGOREC%type;

	FUNCTION fnuGetLCLPORCINICIAL
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.LCLPORCINICIAL%type;

	FUNCTION fnuGetLCLPORCFINAL
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.LCLPORCFINAL%type;

	FUNCTION fnuGetLCLDIAINICIAL
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.LCLDIAINICIAL%type;

	FUNCTION fnuGetLCLDIAFIANAL
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.LCLDIAFIANAL%type;

	FUNCTION fnuGetLCLVALORFIJO
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.LCLVALORFIJO%type;

	FUNCTION fnuGetLCLDEPARTAMENTO
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.LCLDEPARTAMENTO%type;

	FUNCTION fnuGetLCLLOCALIDA
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.LCLLOCALIDA%type;


	PROCEDURE LockByPk
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		orcLDC_CA_LIQUIDAEDAD  out styLDC_CA_LIQUIDAEDAD
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CA_LIQUIDAEDAD  out styLDC_CA_LIQUIDAEDAD
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CA_LIQUIDAEDAD;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_CA_LIQUIDAEDAD
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CA_LIQUIDAEDAD';
	 cnuGeEntityId constant varchar2(30) := 8307; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type
	)
	IS
		SELECT LDC_CA_LIQUIDAEDAD.*,LDC_CA_LIQUIDAEDAD.rowid
		FROM LDC_CA_LIQUIDAEDAD
		WHERE  IDLIQUIDAEDAD = inuIDLIQUIDAEDAD
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CA_LIQUIDAEDAD.*,LDC_CA_LIQUIDAEDAD.rowid
		FROM LDC_CA_LIQUIDAEDAD
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CA_LIQUIDAEDAD is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CA_LIQUIDAEDAD;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CA_LIQUIDAEDAD default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.IDLIQUIDAEDAD);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		orcLDC_CA_LIQUIDAEDAD  out styLDC_CA_LIQUIDAEDAD
	)
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN
		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;

		Open cuLockRcByPk
		(
			inuIDLIQUIDAEDAD
		);

		fetch cuLockRcByPk into orcLDC_CA_LIQUIDAEDAD;
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
		orcLDC_CA_LIQUIDAEDAD  out styLDC_CA_LIQUIDAEDAD
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CA_LIQUIDAEDAD;
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
		itbLDC_CA_LIQUIDAEDAD  in out nocopy tytbLDC_CA_LIQUIDAEDAD
	)
	IS
	BEGIN
			rcRecOfTab.IDLIQUIDAEDAD.delete;
			rcRecOfTab.IDOPERUNITXRANGOREC.delete;
			rcRecOfTab.LCLPORCINICIAL.delete;
			rcRecOfTab.LCLPORCFINAL.delete;
			rcRecOfTab.LCLDIAINICIAL.delete;
			rcRecOfTab.LCLDIAFIANAL.delete;
			rcRecOfTab.LCLVALORFIJO.delete;
			rcRecOfTab.LCLDEPARTAMENTO.delete;
			rcRecOfTab.LCLLOCALIDA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CA_LIQUIDAEDAD  in out nocopy tytbLDC_CA_LIQUIDAEDAD,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CA_LIQUIDAEDAD);

		for n in itbLDC_CA_LIQUIDAEDAD.first .. itbLDC_CA_LIQUIDAEDAD.last loop
			rcRecOfTab.IDLIQUIDAEDAD(n) := itbLDC_CA_LIQUIDAEDAD(n).IDLIQUIDAEDAD;
			rcRecOfTab.IDOPERUNITXRANGOREC(n) := itbLDC_CA_LIQUIDAEDAD(n).IDOPERUNITXRANGOREC;
			rcRecOfTab.LCLPORCINICIAL(n) := itbLDC_CA_LIQUIDAEDAD(n).LCLPORCINICIAL;
			rcRecOfTab.LCLPORCFINAL(n) := itbLDC_CA_LIQUIDAEDAD(n).LCLPORCFINAL;
			rcRecOfTab.LCLDIAINICIAL(n) := itbLDC_CA_LIQUIDAEDAD(n).LCLDIAINICIAL;
			rcRecOfTab.LCLDIAFIANAL(n) := itbLDC_CA_LIQUIDAEDAD(n).LCLDIAFIANAL;
			rcRecOfTab.LCLVALORFIJO(n) := itbLDC_CA_LIQUIDAEDAD(n).LCLVALORFIJO;
			rcRecOfTab.LCLDEPARTAMENTO(n) := itbLDC_CA_LIQUIDAEDAD(n).LCLDEPARTAMENTO;
			rcRecOfTab.LCLLOCALIDA(n) := itbLDC_CA_LIQUIDAEDAD(n).LCLLOCALIDA;
			rcRecOfTab.row_id(n) := itbLDC_CA_LIQUIDAEDAD(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuIDLIQUIDAEDAD
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
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuIDLIQUIDAEDAD = rcData.IDLIQUIDAEDAD
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
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuIDLIQUIDAEDAD
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type
	)
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN		rcError.IDLIQUIDAEDAD:=inuIDLIQUIDAEDAD;

		Load
		(
			inuIDLIQUIDAEDAD
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
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type
	)
	IS
	BEGIN
		Load
		(
			inuIDLIQUIDAEDAD
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		orcRecord out nocopy styLDC_CA_LIQUIDAEDAD
	)
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN		rcError.IDLIQUIDAEDAD:=inuIDLIQUIDAEDAD;

		Load
		(
			inuIDLIQUIDAEDAD
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type
	)
	RETURN styLDC_CA_LIQUIDAEDAD
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN
		rcError.IDLIQUIDAEDAD:=inuIDLIQUIDAEDAD;

		Load
		(
			inuIDLIQUIDAEDAD
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type
	)
	RETURN styLDC_CA_LIQUIDAEDAD
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN
		rcError.IDLIQUIDAEDAD:=inuIDLIQUIDAEDAD;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuIDLIQUIDAEDAD
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuIDLIQUIDAEDAD
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CA_LIQUIDAEDAD
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CA_LIQUIDAEDAD
	)
	IS
		rfLDC_CA_LIQUIDAEDAD tyrfLDC_CA_LIQUIDAEDAD;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CA_LIQUIDAEDAD.*, LDC_CA_LIQUIDAEDAD.rowid FROM LDC_CA_LIQUIDAEDAD';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CA_LIQUIDAEDAD for sbFullQuery;

		fetch rfLDC_CA_LIQUIDAEDAD bulk collect INTO otbResult;

		close rfLDC_CA_LIQUIDAEDAD;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CA_LIQUIDAEDAD.*, LDC_CA_LIQUIDAEDAD.rowid FROM LDC_CA_LIQUIDAEDAD';
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
		ircLDC_CA_LIQUIDAEDAD in styLDC_CA_LIQUIDAEDAD
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CA_LIQUIDAEDAD,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CA_LIQUIDAEDAD in styLDC_CA_LIQUIDAEDAD,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|IDLIQUIDAEDAD');
			raise ex.controlled_error;
		end if;

		insert into LDC_CA_LIQUIDAEDAD
		(
			IDLIQUIDAEDAD,
			IDOPERUNITXRANGOREC,
			LCLPORCINICIAL,
			LCLPORCFINAL,
			LCLDIAINICIAL,
			LCLDIAFIANAL,
			LCLVALORFIJO,
			LCLDEPARTAMENTO,
			LCLLOCALIDA
		)
		values
		(
			ircLDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD,
			ircLDC_CA_LIQUIDAEDAD.IDOPERUNITXRANGOREC,
			ircLDC_CA_LIQUIDAEDAD.LCLPORCINICIAL,
			ircLDC_CA_LIQUIDAEDAD.LCLPORCFINAL,
			ircLDC_CA_LIQUIDAEDAD.LCLDIAINICIAL,
			ircLDC_CA_LIQUIDAEDAD.LCLDIAFIANAL,
			ircLDC_CA_LIQUIDAEDAD.LCLVALORFIJO,
			ircLDC_CA_LIQUIDAEDAD.LCLDEPARTAMENTO,
			ircLDC_CA_LIQUIDAEDAD.LCLLOCALIDA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CA_LIQUIDAEDAD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CA_LIQUIDAEDAD in out nocopy tytbLDC_CA_LIQUIDAEDAD
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CA_LIQUIDAEDAD,blUseRowID);
		forall n in iotbLDC_CA_LIQUIDAEDAD.first..iotbLDC_CA_LIQUIDAEDAD.last
			insert into LDC_CA_LIQUIDAEDAD
			(
				IDLIQUIDAEDAD,
				IDOPERUNITXRANGOREC,
				LCLPORCINICIAL,
				LCLPORCFINAL,
				LCLDIAINICIAL,
				LCLDIAFIANAL,
				LCLVALORFIJO,
				LCLDEPARTAMENTO,
				LCLLOCALIDA
			)
			values
			(
				rcRecOfTab.IDLIQUIDAEDAD(n),
				rcRecOfTab.IDOPERUNITXRANGOREC(n),
				rcRecOfTab.LCLPORCINICIAL(n),
				rcRecOfTab.LCLPORCFINAL(n),
				rcRecOfTab.LCLDIAINICIAL(n),
				rcRecOfTab.LCLDIAFIANAL(n),
				rcRecOfTab.LCLVALORFIJO(n),
				rcRecOfTab.LCLDEPARTAMENTO(n),
				rcRecOfTab.LCLLOCALIDA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN
		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;

		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDAEDAD,
				rcData
			);
		end if;


		delete
		from LDC_CA_LIQUIDAEDAD
		where
       		IDLIQUIDAEDAD=inuIDLIQUIDAEDAD;
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
		rcError  styLDC_CA_LIQUIDAEDAD;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CA_LIQUIDAEDAD
		where
			rowid = iriRowID
		returning
			IDLIQUIDAEDAD
		into
			rcError.IDLIQUIDAEDAD;
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
		iotbLDC_CA_LIQUIDAEDAD in out nocopy tytbLDC_CA_LIQUIDAEDAD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CA_LIQUIDAEDAD;
	BEGIN
		FillRecordOfTables(iotbLDC_CA_LIQUIDAEDAD, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CA_LIQUIDAEDAD.first .. iotbLDC_CA_LIQUIDAEDAD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_LIQUIDAEDAD.first .. iotbLDC_CA_LIQUIDAEDAD.last
				delete
				from LDC_CA_LIQUIDAEDAD
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CA_LIQUIDAEDAD.first .. iotbLDC_CA_LIQUIDAEDAD.last loop
					LockByPk
					(
						rcRecOfTab.IDLIQUIDAEDAD(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_LIQUIDAEDAD.first .. iotbLDC_CA_LIQUIDAEDAD.last
				delete
				from LDC_CA_LIQUIDAEDAD
				where
		         	IDLIQUIDAEDAD = rcRecOfTab.IDLIQUIDAEDAD(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CA_LIQUIDAEDAD in styLDC_CA_LIQUIDAEDAD,
		inuLock in number default 0
	)
	IS
		nuIDLIQUIDAEDAD	LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type;
	BEGIN
		if ircLDC_CA_LIQUIDAEDAD.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CA_LIQUIDAEDAD.rowid,rcData);
			end if;
			update LDC_CA_LIQUIDAEDAD
			set
				IDOPERUNITXRANGOREC = ircLDC_CA_LIQUIDAEDAD.IDOPERUNITXRANGOREC,
				LCLPORCINICIAL = ircLDC_CA_LIQUIDAEDAD.LCLPORCINICIAL,
				LCLPORCFINAL = ircLDC_CA_LIQUIDAEDAD.LCLPORCFINAL,
				LCLDIAINICIAL = ircLDC_CA_LIQUIDAEDAD.LCLDIAINICIAL,
				LCLDIAFIANAL = ircLDC_CA_LIQUIDAEDAD.LCLDIAFIANAL,
				LCLVALORFIJO = ircLDC_CA_LIQUIDAEDAD.LCLVALORFIJO,
				LCLDEPARTAMENTO = ircLDC_CA_LIQUIDAEDAD.LCLDEPARTAMENTO,
				LCLLOCALIDA = ircLDC_CA_LIQUIDAEDAD.LCLLOCALIDA
			where
				rowid = ircLDC_CA_LIQUIDAEDAD.rowid
			returning
				IDLIQUIDAEDAD
			into
				nuIDLIQUIDAEDAD;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD,
					rcData
				);
			end if;

			update LDC_CA_LIQUIDAEDAD
			set
				IDOPERUNITXRANGOREC = ircLDC_CA_LIQUIDAEDAD.IDOPERUNITXRANGOREC,
				LCLPORCINICIAL = ircLDC_CA_LIQUIDAEDAD.LCLPORCINICIAL,
				LCLPORCFINAL = ircLDC_CA_LIQUIDAEDAD.LCLPORCFINAL,
				LCLDIAINICIAL = ircLDC_CA_LIQUIDAEDAD.LCLDIAINICIAL,
				LCLDIAFIANAL = ircLDC_CA_LIQUIDAEDAD.LCLDIAFIANAL,
				LCLVALORFIJO = ircLDC_CA_LIQUIDAEDAD.LCLVALORFIJO,
				LCLDEPARTAMENTO = ircLDC_CA_LIQUIDAEDAD.LCLDEPARTAMENTO,
				LCLLOCALIDA = ircLDC_CA_LIQUIDAEDAD.LCLLOCALIDA
			where
				IDLIQUIDAEDAD = ircLDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD
			returning
				IDLIQUIDAEDAD
			into
				nuIDLIQUIDAEDAD;
		end if;
		if
			nuIDLIQUIDAEDAD is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CA_LIQUIDAEDAD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CA_LIQUIDAEDAD in out nocopy tytbLDC_CA_LIQUIDAEDAD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CA_LIQUIDAEDAD;
	BEGIN
		FillRecordOfTables(iotbLDC_CA_LIQUIDAEDAD,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CA_LIQUIDAEDAD.first .. iotbLDC_CA_LIQUIDAEDAD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_LIQUIDAEDAD.first .. iotbLDC_CA_LIQUIDAEDAD.last
				update LDC_CA_LIQUIDAEDAD
				set
					IDOPERUNITXRANGOREC = rcRecOfTab.IDOPERUNITXRANGOREC(n),
					LCLPORCINICIAL = rcRecOfTab.LCLPORCINICIAL(n),
					LCLPORCFINAL = rcRecOfTab.LCLPORCFINAL(n),
					LCLDIAINICIAL = rcRecOfTab.LCLDIAINICIAL(n),
					LCLDIAFIANAL = rcRecOfTab.LCLDIAFIANAL(n),
					LCLVALORFIJO = rcRecOfTab.LCLVALORFIJO(n),
					LCLDEPARTAMENTO = rcRecOfTab.LCLDEPARTAMENTO(n),
					LCLLOCALIDA = rcRecOfTab.LCLLOCALIDA(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CA_LIQUIDAEDAD.first .. iotbLDC_CA_LIQUIDAEDAD.last loop
					LockByPk
					(
						rcRecOfTab.IDLIQUIDAEDAD(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_LIQUIDAEDAD.first .. iotbLDC_CA_LIQUIDAEDAD.last
				update LDC_CA_LIQUIDAEDAD
				SET
					IDOPERUNITXRANGOREC = rcRecOfTab.IDOPERUNITXRANGOREC(n),
					LCLPORCINICIAL = rcRecOfTab.LCLPORCINICIAL(n),
					LCLPORCFINAL = rcRecOfTab.LCLPORCFINAL(n),
					LCLDIAINICIAL = rcRecOfTab.LCLDIAINICIAL(n),
					LCLDIAFIANAL = rcRecOfTab.LCLDIAFIANAL(n),
					LCLVALORFIJO = rcRecOfTab.LCLVALORFIJO(n),
					LCLDEPARTAMENTO = rcRecOfTab.LCLDEPARTAMENTO(n),
					LCLLOCALIDA = rcRecOfTab.LCLLOCALIDA(n)
				where
					IDLIQUIDAEDAD = rcRecOfTab.IDLIQUIDAEDAD(n)
;
		end if;
	END;
	PROCEDURE updIDOPERUNITXRANGOREC
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuIDOPERUNITXRANGOREC$ in LDC_CA_LIQUIDAEDAD.IDOPERUNITXRANGOREC%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN
		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDAEDAD,
				rcData
			);
		end if;

		update LDC_CA_LIQUIDAEDAD
		set
			IDOPERUNITXRANGOREC = inuIDOPERUNITXRANGOREC$
		where
			IDLIQUIDAEDAD = inuIDLIQUIDAEDAD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IDOPERUNITXRANGOREC:= inuIDOPERUNITXRANGOREC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLCLPORCINICIAL
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuLCLPORCINICIAL$ in LDC_CA_LIQUIDAEDAD.LCLPORCINICIAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN
		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDAEDAD,
				rcData
			);
		end if;

		update LDC_CA_LIQUIDAEDAD
		set
			LCLPORCINICIAL = inuLCLPORCINICIAL$
		where
			IDLIQUIDAEDAD = inuIDLIQUIDAEDAD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LCLPORCINICIAL:= inuLCLPORCINICIAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLCLPORCFINAL
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuLCLPORCFINAL$ in LDC_CA_LIQUIDAEDAD.LCLPORCFINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN
		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDAEDAD,
				rcData
			);
		end if;

		update LDC_CA_LIQUIDAEDAD
		set
			LCLPORCFINAL = inuLCLPORCFINAL$
		where
			IDLIQUIDAEDAD = inuIDLIQUIDAEDAD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LCLPORCFINAL:= inuLCLPORCFINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLCLDIAINICIAL
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuLCLDIAINICIAL$ in LDC_CA_LIQUIDAEDAD.LCLDIAINICIAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN
		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDAEDAD,
				rcData
			);
		end if;

		update LDC_CA_LIQUIDAEDAD
		set
			LCLDIAINICIAL = inuLCLDIAINICIAL$
		where
			IDLIQUIDAEDAD = inuIDLIQUIDAEDAD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LCLDIAINICIAL:= inuLCLDIAINICIAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLCLDIAFIANAL
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuLCLDIAFIANAL$ in LDC_CA_LIQUIDAEDAD.LCLDIAFIANAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN
		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDAEDAD,
				rcData
			);
		end if;

		update LDC_CA_LIQUIDAEDAD
		set
			LCLDIAFIANAL = inuLCLDIAFIANAL$
		where
			IDLIQUIDAEDAD = inuIDLIQUIDAEDAD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LCLDIAFIANAL:= inuLCLDIAFIANAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLCLVALORFIJO
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuLCLVALORFIJO$ in LDC_CA_LIQUIDAEDAD.LCLVALORFIJO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN
		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDAEDAD,
				rcData
			);
		end if;

		update LDC_CA_LIQUIDAEDAD
		set
			LCLVALORFIJO = inuLCLVALORFIJO$
		where
			IDLIQUIDAEDAD = inuIDLIQUIDAEDAD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LCLVALORFIJO:= inuLCLVALORFIJO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLCLDEPARTAMENTO
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuLCLDEPARTAMENTO$ in LDC_CA_LIQUIDAEDAD.LCLDEPARTAMENTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN
		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDAEDAD,
				rcData
			);
		end if;

		update LDC_CA_LIQUIDAEDAD
		set
			LCLDEPARTAMENTO = inuLCLDEPARTAMENTO$
		where
			IDLIQUIDAEDAD = inuIDLIQUIDAEDAD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LCLDEPARTAMENTO:= inuLCLDEPARTAMENTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLCLLOCALIDA
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuLCLLOCALIDA$ in LDC_CA_LIQUIDAEDAD.LCLLOCALIDA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN
		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDAEDAD,
				rcData
			);
		end if;

		update LDC_CA_LIQUIDAEDAD
		set
			LCLLOCALIDA = inuLCLLOCALIDA$
		where
			IDLIQUIDAEDAD = inuIDLIQUIDAEDAD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LCLLOCALIDA:= inuLCLLOCALIDA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetIDLIQUIDAEDAD
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN

		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDAEDAD
			 )
		then
			 return(rcData.IDLIQUIDAEDAD);
		end if;
		Load
		(
		 		inuIDLIQUIDAEDAD
		);
		return(rcData.IDLIQUIDAEDAD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIDOPERUNITXRANGOREC
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.IDOPERUNITXRANGOREC%type
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN

		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDAEDAD
			 )
		then
			 return(rcData.IDOPERUNITXRANGOREC);
		end if;
		Load
		(
		 		inuIDLIQUIDAEDAD
		);
		return(rcData.IDOPERUNITXRANGOREC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLCLPORCINICIAL
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.LCLPORCINICIAL%type
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN

		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDAEDAD
			 )
		then
			 return(rcData.LCLPORCINICIAL);
		end if;
		Load
		(
		 		inuIDLIQUIDAEDAD
		);
		return(rcData.LCLPORCINICIAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLCLPORCFINAL
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.LCLPORCFINAL%type
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN

		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDAEDAD
			 )
		then
			 return(rcData.LCLPORCFINAL);
		end if;
		Load
		(
		 		inuIDLIQUIDAEDAD
		);
		return(rcData.LCLPORCFINAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLCLDIAINICIAL
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.LCLDIAINICIAL%type
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN

		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDAEDAD
			 )
		then
			 return(rcData.LCLDIAINICIAL);
		end if;
		Load
		(
		 		inuIDLIQUIDAEDAD
		);
		return(rcData.LCLDIAINICIAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLCLDIAFIANAL
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.LCLDIAFIANAL%type
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN

		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDAEDAD
			 )
		then
			 return(rcData.LCLDIAFIANAL);
		end if;
		Load
		(
		 		inuIDLIQUIDAEDAD
		);
		return(rcData.LCLDIAFIANAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLCLVALORFIJO
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.LCLVALORFIJO%type
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN

		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDAEDAD
			 )
		then
			 return(rcData.LCLVALORFIJO);
		end if;
		Load
		(
		 		inuIDLIQUIDAEDAD
		);
		return(rcData.LCLVALORFIJO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLCLDEPARTAMENTO
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.LCLDEPARTAMENTO%type
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN

		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDAEDAD
			 )
		then
			 return(rcData.LCLDEPARTAMENTO);
		end if;
		Load
		(
		 		inuIDLIQUIDAEDAD
		);
		return(rcData.LCLDEPARTAMENTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLCLLOCALIDA
	(
		inuIDLIQUIDAEDAD in LDC_CA_LIQUIDAEDAD.IDLIQUIDAEDAD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDAEDAD.LCLLOCALIDA%type
	IS
		rcError styLDC_CA_LIQUIDAEDAD;
	BEGIN

		rcError.IDLIQUIDAEDAD := inuIDLIQUIDAEDAD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDAEDAD
			 )
		then
			 return(rcData.LCLLOCALIDA);
		end if;
		Load
		(
		 		inuIDLIQUIDAEDAD
		);
		return(rcData.LCLLOCALIDA);
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
end DALDC_CA_LIQUIDAEDAD;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_CA_LIQUIDAEDAD
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_CA_LIQUIDAEDAD', 'ADM_PERSON'); 
END;
/

