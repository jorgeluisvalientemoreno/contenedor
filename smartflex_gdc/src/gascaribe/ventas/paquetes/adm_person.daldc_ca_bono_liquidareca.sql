CREATE OR REPLACE PACKAGE adm_person.daldc_ca_bono_liquidareca
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type
	)
	IS
		SELECT LDC_CA_BONO_LIQUIDARECA.*,LDC_CA_BONO_LIQUIDARECA.rowid
		FROM LDC_CA_BONO_LIQUIDARECA
		WHERE
		    IDLIQUIDABOBORECA = inuIDLIQUIDABOBORECA;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CA_BONO_LIQUIDARECA.*,LDC_CA_BONO_LIQUIDARECA.rowid
		FROM LDC_CA_BONO_LIQUIDARECA
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CA_BONO_LIQUIDARECA  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CA_BONO_LIQUIDARECA is table of styLDC_CA_BONO_LIQUIDARECA index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CA_BONO_LIQUIDARECA;

	/* Tipos referenciando al registro */
	type tytbIDLIQUIDABOBORECA is table of LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type index by binary_integer;
	type tytbIDOPERUNITXRANGOREC is table of LDC_CA_BONO_LIQUIDARECA.IDOPERUNITXRANGOREC%type index by binary_integer;
	type tytbLBLPORCINICIAL is table of LDC_CA_BONO_LIQUIDARECA.LBLPORCINICIAL%type index by binary_integer;
	type tytbLBLPORCFINAL is table of LDC_CA_BONO_LIQUIDARECA.LBLPORCFINAL%type index by binary_integer;
	type tytbLBLVALORFIJO is table of LDC_CA_BONO_LIQUIDARECA.LBLVALORFIJO%type index by binary_integer;
	type tytbLBLDEPARTAMENTO is table of LDC_CA_BONO_LIQUIDARECA.LBLDEPARTAMENTO%type index by binary_integer;
	type tytbLBLLOCALIDA is table of LDC_CA_BONO_LIQUIDARECA.LBLLOCALIDA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CA_BONO_LIQUIDARECA is record
	(
		IDLIQUIDABOBORECA   tytbIDLIQUIDABOBORECA,
		IDOPERUNITXRANGOREC   tytbIDOPERUNITXRANGOREC,
		LBLPORCINICIAL   tytbLBLPORCINICIAL,
		LBLPORCFINAL   tytbLBLPORCFINAL,
		LBLVALORFIJO   tytbLBLVALORFIJO,
		LBLDEPARTAMENTO   tytbLBLDEPARTAMENTO,
		LBLLOCALIDA   tytbLBLLOCALIDA,
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
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type
	);

	PROCEDURE getRecord
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		orcRecord out nocopy styLDC_CA_BONO_LIQUIDARECA
	);

	FUNCTION frcGetRcData
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type
	)
	RETURN styLDC_CA_BONO_LIQUIDARECA;

	FUNCTION frcGetRcData
	RETURN styLDC_CA_BONO_LIQUIDARECA;

	FUNCTION frcGetRecord
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type
	)
	RETURN styLDC_CA_BONO_LIQUIDARECA;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CA_BONO_LIQUIDARECA
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CA_BONO_LIQUIDARECA in styLDC_CA_BONO_LIQUIDARECA
	);

	PROCEDURE insRecord
	(
		ircLDC_CA_BONO_LIQUIDARECA in styLDC_CA_BONO_LIQUIDARECA,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CA_BONO_LIQUIDARECA in out nocopy tytbLDC_CA_BONO_LIQUIDARECA
	);

	PROCEDURE delRecord
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CA_BONO_LIQUIDARECA in out nocopy tytbLDC_CA_BONO_LIQUIDARECA,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CA_BONO_LIQUIDARECA in styLDC_CA_BONO_LIQUIDARECA,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CA_BONO_LIQUIDARECA in out nocopy tytbLDC_CA_BONO_LIQUIDARECA,
		inuLock in number default 1
	);

	PROCEDURE updIDOPERUNITXRANGOREC
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuIDOPERUNITXRANGOREC$ in LDC_CA_BONO_LIQUIDARECA.IDOPERUNITXRANGOREC%type,
		inuLock in number default 0
	);

	PROCEDURE updLBLPORCINICIAL
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuLBLPORCINICIAL$ in LDC_CA_BONO_LIQUIDARECA.LBLPORCINICIAL%type,
		inuLock in number default 0
	);

	PROCEDURE updLBLPORCFINAL
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuLBLPORCFINAL$ in LDC_CA_BONO_LIQUIDARECA.LBLPORCFINAL%type,
		inuLock in number default 0
	);

	PROCEDURE updLBLVALORFIJO
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuLBLVALORFIJO$ in LDC_CA_BONO_LIQUIDARECA.LBLVALORFIJO%type,
		inuLock in number default 0
	);

	PROCEDURE updLBLDEPARTAMENTO
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuLBLDEPARTAMENTO$ in LDC_CA_BONO_LIQUIDARECA.LBLDEPARTAMENTO%type,
		inuLock in number default 0
	);

	PROCEDURE updLBLLOCALIDA
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuLBLLOCALIDA$ in LDC_CA_BONO_LIQUIDARECA.LBLLOCALIDA%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetIDLIQUIDABOBORECA
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type;

	FUNCTION fnuGetIDOPERUNITXRANGOREC
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_BONO_LIQUIDARECA.IDOPERUNITXRANGOREC%type;

	FUNCTION fnuGetLBLPORCINICIAL
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_BONO_LIQUIDARECA.LBLPORCINICIAL%type;

	FUNCTION fnuGetLBLPORCFINAL
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_BONO_LIQUIDARECA.LBLPORCFINAL%type;

	FUNCTION fnuGetLBLVALORFIJO
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_BONO_LIQUIDARECA.LBLVALORFIJO%type;

	FUNCTION fnuGetLBLDEPARTAMENTO
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_BONO_LIQUIDARECA.LBLDEPARTAMENTO%type;

	FUNCTION fnuGetLBLLOCALIDA
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_BONO_LIQUIDARECA.LBLLOCALIDA%type;


	PROCEDURE LockByPk
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		orcLDC_CA_BONO_LIQUIDARECA  out styLDC_CA_BONO_LIQUIDARECA
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CA_BONO_LIQUIDARECA  out styLDC_CA_BONO_LIQUIDARECA
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CA_BONO_LIQUIDARECA;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_CA_BONO_LIQUIDARECA
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CA_BONO_LIQUIDARECA';
	 cnuGeEntityId constant varchar2(30) := 8306; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type
	)
	IS
		SELECT LDC_CA_BONO_LIQUIDARECA.*,LDC_CA_BONO_LIQUIDARECA.rowid
		FROM LDC_CA_BONO_LIQUIDARECA
		WHERE  IDLIQUIDABOBORECA = inuIDLIQUIDABOBORECA
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CA_BONO_LIQUIDARECA.*,LDC_CA_BONO_LIQUIDARECA.rowid
		FROM LDC_CA_BONO_LIQUIDARECA
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CA_BONO_LIQUIDARECA is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CA_BONO_LIQUIDARECA;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CA_BONO_LIQUIDARECA default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.IDLIQUIDABOBORECA);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		orcLDC_CA_BONO_LIQUIDARECA  out styLDC_CA_BONO_LIQUIDARECA
	)
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDABOBORECA := inuIDLIQUIDABOBORECA;

		Open cuLockRcByPk
		(
			inuIDLIQUIDABOBORECA
		);

		fetch cuLockRcByPk into orcLDC_CA_BONO_LIQUIDARECA;
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
		orcLDC_CA_BONO_LIQUIDARECA  out styLDC_CA_BONO_LIQUIDARECA
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CA_BONO_LIQUIDARECA;
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
		itbLDC_CA_BONO_LIQUIDARECA  in out nocopy tytbLDC_CA_BONO_LIQUIDARECA
	)
	IS
	BEGIN
			rcRecOfTab.IDLIQUIDABOBORECA.delete;
			rcRecOfTab.IDOPERUNITXRANGOREC.delete;
			rcRecOfTab.LBLPORCINICIAL.delete;
			rcRecOfTab.LBLPORCFINAL.delete;
			rcRecOfTab.LBLVALORFIJO.delete;
			rcRecOfTab.LBLDEPARTAMENTO.delete;
			rcRecOfTab.LBLLOCALIDA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CA_BONO_LIQUIDARECA  in out nocopy tytbLDC_CA_BONO_LIQUIDARECA,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CA_BONO_LIQUIDARECA);

		for n in itbLDC_CA_BONO_LIQUIDARECA.first .. itbLDC_CA_BONO_LIQUIDARECA.last loop
			rcRecOfTab.IDLIQUIDABOBORECA(n) := itbLDC_CA_BONO_LIQUIDARECA(n).IDLIQUIDABOBORECA;
			rcRecOfTab.IDOPERUNITXRANGOREC(n) := itbLDC_CA_BONO_LIQUIDARECA(n).IDOPERUNITXRANGOREC;
			rcRecOfTab.LBLPORCINICIAL(n) := itbLDC_CA_BONO_LIQUIDARECA(n).LBLPORCINICIAL;
			rcRecOfTab.LBLPORCFINAL(n) := itbLDC_CA_BONO_LIQUIDARECA(n).LBLPORCFINAL;
			rcRecOfTab.LBLVALORFIJO(n) := itbLDC_CA_BONO_LIQUIDARECA(n).LBLVALORFIJO;
			rcRecOfTab.LBLDEPARTAMENTO(n) := itbLDC_CA_BONO_LIQUIDARECA(n).LBLDEPARTAMENTO;
			rcRecOfTab.LBLLOCALIDA(n) := itbLDC_CA_BONO_LIQUIDARECA(n).LBLLOCALIDA;
			rcRecOfTab.row_id(n) := itbLDC_CA_BONO_LIQUIDARECA(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuIDLIQUIDABOBORECA
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
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuIDLIQUIDABOBORECA = rcData.IDLIQUIDABOBORECA
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
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuIDLIQUIDABOBORECA
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type
	)
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN		rcError.IDLIQUIDABOBORECA:=inuIDLIQUIDABOBORECA;

		Load
		(
			inuIDLIQUIDABOBORECA
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
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type
	)
	IS
	BEGIN
		Load
		(
			inuIDLIQUIDABOBORECA
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		orcRecord out nocopy styLDC_CA_BONO_LIQUIDARECA
	)
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN		rcError.IDLIQUIDABOBORECA:=inuIDLIQUIDABOBORECA;

		Load
		(
			inuIDLIQUIDABOBORECA
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type
	)
	RETURN styLDC_CA_BONO_LIQUIDARECA
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDABOBORECA:=inuIDLIQUIDABOBORECA;

		Load
		(
			inuIDLIQUIDABOBORECA
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type
	)
	RETURN styLDC_CA_BONO_LIQUIDARECA
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDABOBORECA:=inuIDLIQUIDABOBORECA;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuIDLIQUIDABOBORECA
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuIDLIQUIDABOBORECA
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CA_BONO_LIQUIDARECA
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CA_BONO_LIQUIDARECA
	)
	IS
		rfLDC_CA_BONO_LIQUIDARECA tyrfLDC_CA_BONO_LIQUIDARECA;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CA_BONO_LIQUIDARECA.*, LDC_CA_BONO_LIQUIDARECA.rowid FROM LDC_CA_BONO_LIQUIDARECA';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CA_BONO_LIQUIDARECA for sbFullQuery;

		fetch rfLDC_CA_BONO_LIQUIDARECA bulk collect INTO otbResult;

		close rfLDC_CA_BONO_LIQUIDARECA;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CA_BONO_LIQUIDARECA.*, LDC_CA_BONO_LIQUIDARECA.rowid FROM LDC_CA_BONO_LIQUIDARECA';
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
		ircLDC_CA_BONO_LIQUIDARECA in styLDC_CA_BONO_LIQUIDARECA
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CA_BONO_LIQUIDARECA,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CA_BONO_LIQUIDARECA in styLDC_CA_BONO_LIQUIDARECA,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|IDLIQUIDABOBORECA');
			raise ex.controlled_error;
		end if;

		insert into LDC_CA_BONO_LIQUIDARECA
		(
			IDLIQUIDABOBORECA,
			IDOPERUNITXRANGOREC,
			LBLPORCINICIAL,
			LBLPORCFINAL,
			LBLVALORFIJO,
			LBLDEPARTAMENTO,
			LBLLOCALIDA
		)
		values
		(
			ircLDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA,
			ircLDC_CA_BONO_LIQUIDARECA.IDOPERUNITXRANGOREC,
			ircLDC_CA_BONO_LIQUIDARECA.LBLPORCINICIAL,
			ircLDC_CA_BONO_LIQUIDARECA.LBLPORCFINAL,
			ircLDC_CA_BONO_LIQUIDARECA.LBLVALORFIJO,
			ircLDC_CA_BONO_LIQUIDARECA.LBLDEPARTAMENTO,
			ircLDC_CA_BONO_LIQUIDARECA.LBLLOCALIDA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CA_BONO_LIQUIDARECA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CA_BONO_LIQUIDARECA in out nocopy tytbLDC_CA_BONO_LIQUIDARECA
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CA_BONO_LIQUIDARECA,blUseRowID);
		forall n in iotbLDC_CA_BONO_LIQUIDARECA.first..iotbLDC_CA_BONO_LIQUIDARECA.last
			insert into LDC_CA_BONO_LIQUIDARECA
			(
				IDLIQUIDABOBORECA,
				IDOPERUNITXRANGOREC,
				LBLPORCINICIAL,
				LBLPORCFINAL,
				LBLVALORFIJO,
				LBLDEPARTAMENTO,
				LBLLOCALIDA
			)
			values
			(
				rcRecOfTab.IDLIQUIDABOBORECA(n),
				rcRecOfTab.IDOPERUNITXRANGOREC(n),
				rcRecOfTab.LBLPORCINICIAL(n),
				rcRecOfTab.LBLPORCFINAL(n),
				rcRecOfTab.LBLVALORFIJO(n),
				rcRecOfTab.LBLDEPARTAMENTO(n),
				rcRecOfTab.LBLLOCALIDA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDABOBORECA := inuIDLIQUIDABOBORECA;

		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDABOBORECA,
				rcData
			);
		end if;


		delete
		from LDC_CA_BONO_LIQUIDARECA
		where
       		IDLIQUIDABOBORECA=inuIDLIQUIDABOBORECA;
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
		rcError  styLDC_CA_BONO_LIQUIDARECA;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CA_BONO_LIQUIDARECA
		where
			rowid = iriRowID
		returning
			IDLIQUIDABOBORECA
		into
			rcError.IDLIQUIDABOBORECA;
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
		iotbLDC_CA_BONO_LIQUIDARECA in out nocopy tytbLDC_CA_BONO_LIQUIDARECA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CA_BONO_LIQUIDARECA;
	BEGIN
		FillRecordOfTables(iotbLDC_CA_BONO_LIQUIDARECA, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CA_BONO_LIQUIDARECA.first .. iotbLDC_CA_BONO_LIQUIDARECA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_BONO_LIQUIDARECA.first .. iotbLDC_CA_BONO_LIQUIDARECA.last
				delete
				from LDC_CA_BONO_LIQUIDARECA
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CA_BONO_LIQUIDARECA.first .. iotbLDC_CA_BONO_LIQUIDARECA.last loop
					LockByPk
					(
						rcRecOfTab.IDLIQUIDABOBORECA(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_BONO_LIQUIDARECA.first .. iotbLDC_CA_BONO_LIQUIDARECA.last
				delete
				from LDC_CA_BONO_LIQUIDARECA
				where
		         	IDLIQUIDABOBORECA = rcRecOfTab.IDLIQUIDABOBORECA(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CA_BONO_LIQUIDARECA in styLDC_CA_BONO_LIQUIDARECA,
		inuLock in number default 0
	)
	IS
		nuIDLIQUIDABOBORECA	LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type;
	BEGIN
		if ircLDC_CA_BONO_LIQUIDARECA.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CA_BONO_LIQUIDARECA.rowid,rcData);
			end if;
			update LDC_CA_BONO_LIQUIDARECA
			set
				IDOPERUNITXRANGOREC = ircLDC_CA_BONO_LIQUIDARECA.IDOPERUNITXRANGOREC,
				LBLPORCINICIAL = ircLDC_CA_BONO_LIQUIDARECA.LBLPORCINICIAL,
				LBLPORCFINAL = ircLDC_CA_BONO_LIQUIDARECA.LBLPORCFINAL,
				LBLVALORFIJO = ircLDC_CA_BONO_LIQUIDARECA.LBLVALORFIJO,
				LBLDEPARTAMENTO = ircLDC_CA_BONO_LIQUIDARECA.LBLDEPARTAMENTO,
				LBLLOCALIDA = ircLDC_CA_BONO_LIQUIDARECA.LBLLOCALIDA
			where
				rowid = ircLDC_CA_BONO_LIQUIDARECA.rowid
			returning
				IDLIQUIDABOBORECA
			into
				nuIDLIQUIDABOBORECA;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA,
					rcData
				);
			end if;

			update LDC_CA_BONO_LIQUIDARECA
			set
				IDOPERUNITXRANGOREC = ircLDC_CA_BONO_LIQUIDARECA.IDOPERUNITXRANGOREC,
				LBLPORCINICIAL = ircLDC_CA_BONO_LIQUIDARECA.LBLPORCINICIAL,
				LBLPORCFINAL = ircLDC_CA_BONO_LIQUIDARECA.LBLPORCFINAL,
				LBLVALORFIJO = ircLDC_CA_BONO_LIQUIDARECA.LBLVALORFIJO,
				LBLDEPARTAMENTO = ircLDC_CA_BONO_LIQUIDARECA.LBLDEPARTAMENTO,
				LBLLOCALIDA = ircLDC_CA_BONO_LIQUIDARECA.LBLLOCALIDA
			where
				IDLIQUIDABOBORECA = ircLDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA
			returning
				IDLIQUIDABOBORECA
			into
				nuIDLIQUIDABOBORECA;
		end if;
		if
			nuIDLIQUIDABOBORECA is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CA_BONO_LIQUIDARECA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CA_BONO_LIQUIDARECA in out nocopy tytbLDC_CA_BONO_LIQUIDARECA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CA_BONO_LIQUIDARECA;
	BEGIN
		FillRecordOfTables(iotbLDC_CA_BONO_LIQUIDARECA,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CA_BONO_LIQUIDARECA.first .. iotbLDC_CA_BONO_LIQUIDARECA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_BONO_LIQUIDARECA.first .. iotbLDC_CA_BONO_LIQUIDARECA.last
				update LDC_CA_BONO_LIQUIDARECA
				set
					IDOPERUNITXRANGOREC = rcRecOfTab.IDOPERUNITXRANGOREC(n),
					LBLPORCINICIAL = rcRecOfTab.LBLPORCINICIAL(n),
					LBLPORCFINAL = rcRecOfTab.LBLPORCFINAL(n),
					LBLVALORFIJO = rcRecOfTab.LBLVALORFIJO(n),
					LBLDEPARTAMENTO = rcRecOfTab.LBLDEPARTAMENTO(n),
					LBLLOCALIDA = rcRecOfTab.LBLLOCALIDA(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CA_BONO_LIQUIDARECA.first .. iotbLDC_CA_BONO_LIQUIDARECA.last loop
					LockByPk
					(
						rcRecOfTab.IDLIQUIDABOBORECA(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_BONO_LIQUIDARECA.first .. iotbLDC_CA_BONO_LIQUIDARECA.last
				update LDC_CA_BONO_LIQUIDARECA
				SET
					IDOPERUNITXRANGOREC = rcRecOfTab.IDOPERUNITXRANGOREC(n),
					LBLPORCINICIAL = rcRecOfTab.LBLPORCINICIAL(n),
					LBLPORCFINAL = rcRecOfTab.LBLPORCFINAL(n),
					LBLVALORFIJO = rcRecOfTab.LBLVALORFIJO(n),
					LBLDEPARTAMENTO = rcRecOfTab.LBLDEPARTAMENTO(n),
					LBLLOCALIDA = rcRecOfTab.LBLLOCALIDA(n)
				where
					IDLIQUIDABOBORECA = rcRecOfTab.IDLIQUIDABOBORECA(n)
;
		end if;
	END;
	PROCEDURE updIDOPERUNITXRANGOREC
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuIDOPERUNITXRANGOREC$ in LDC_CA_BONO_LIQUIDARECA.IDOPERUNITXRANGOREC%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDABOBORECA := inuIDLIQUIDABOBORECA;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDABOBORECA,
				rcData
			);
		end if;

		update LDC_CA_BONO_LIQUIDARECA
		set
			IDOPERUNITXRANGOREC = inuIDOPERUNITXRANGOREC$
		where
			IDLIQUIDABOBORECA = inuIDLIQUIDABOBORECA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IDOPERUNITXRANGOREC:= inuIDOPERUNITXRANGOREC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLBLPORCINICIAL
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuLBLPORCINICIAL$ in LDC_CA_BONO_LIQUIDARECA.LBLPORCINICIAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDABOBORECA := inuIDLIQUIDABOBORECA;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDABOBORECA,
				rcData
			);
		end if;

		update LDC_CA_BONO_LIQUIDARECA
		set
			LBLPORCINICIAL = inuLBLPORCINICIAL$
		where
			IDLIQUIDABOBORECA = inuIDLIQUIDABOBORECA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LBLPORCINICIAL:= inuLBLPORCINICIAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLBLPORCFINAL
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuLBLPORCFINAL$ in LDC_CA_BONO_LIQUIDARECA.LBLPORCFINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDABOBORECA := inuIDLIQUIDABOBORECA;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDABOBORECA,
				rcData
			);
		end if;

		update LDC_CA_BONO_LIQUIDARECA
		set
			LBLPORCFINAL = inuLBLPORCFINAL$
		where
			IDLIQUIDABOBORECA = inuIDLIQUIDABOBORECA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LBLPORCFINAL:= inuLBLPORCFINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLBLVALORFIJO
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuLBLVALORFIJO$ in LDC_CA_BONO_LIQUIDARECA.LBLVALORFIJO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDABOBORECA := inuIDLIQUIDABOBORECA;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDABOBORECA,
				rcData
			);
		end if;

		update LDC_CA_BONO_LIQUIDARECA
		set
			LBLVALORFIJO = inuLBLVALORFIJO$
		where
			IDLIQUIDABOBORECA = inuIDLIQUIDABOBORECA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LBLVALORFIJO:= inuLBLVALORFIJO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLBLDEPARTAMENTO
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuLBLDEPARTAMENTO$ in LDC_CA_BONO_LIQUIDARECA.LBLDEPARTAMENTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDABOBORECA := inuIDLIQUIDABOBORECA;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDABOBORECA,
				rcData
			);
		end if;

		update LDC_CA_BONO_LIQUIDARECA
		set
			LBLDEPARTAMENTO = inuLBLDEPARTAMENTO$
		where
			IDLIQUIDABOBORECA = inuIDLIQUIDABOBORECA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LBLDEPARTAMENTO:= inuLBLDEPARTAMENTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLBLLOCALIDA
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuLBLLOCALIDA$ in LDC_CA_BONO_LIQUIDARECA.LBLLOCALIDA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDABOBORECA := inuIDLIQUIDABOBORECA;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDABOBORECA,
				rcData
			);
		end if;

		update LDC_CA_BONO_LIQUIDARECA
		set
			LBLLOCALIDA = inuLBLLOCALIDA$
		where
			IDLIQUIDABOBORECA = inuIDLIQUIDABOBORECA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LBLLOCALIDA:= inuLBLLOCALIDA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetIDLIQUIDABOBORECA
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN

		rcError.IDLIQUIDABOBORECA := inuIDLIQUIDABOBORECA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDABOBORECA
			 )
		then
			 return(rcData.IDLIQUIDABOBORECA);
		end if;
		Load
		(
		 		inuIDLIQUIDABOBORECA
		);
		return(rcData.IDLIQUIDABOBORECA);
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
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_BONO_LIQUIDARECA.IDOPERUNITXRANGOREC%type
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN

		rcError.IDLIQUIDABOBORECA := inuIDLIQUIDABOBORECA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDABOBORECA
			 )
		then
			 return(rcData.IDOPERUNITXRANGOREC);
		end if;
		Load
		(
		 		inuIDLIQUIDABOBORECA
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
	FUNCTION fnuGetLBLPORCINICIAL
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_BONO_LIQUIDARECA.LBLPORCINICIAL%type
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN

		rcError.IDLIQUIDABOBORECA := inuIDLIQUIDABOBORECA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDABOBORECA
			 )
		then
			 return(rcData.LBLPORCINICIAL);
		end if;
		Load
		(
		 		inuIDLIQUIDABOBORECA
		);
		return(rcData.LBLPORCINICIAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLBLPORCFINAL
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_BONO_LIQUIDARECA.LBLPORCFINAL%type
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN

		rcError.IDLIQUIDABOBORECA := inuIDLIQUIDABOBORECA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDABOBORECA
			 )
		then
			 return(rcData.LBLPORCFINAL);
		end if;
		Load
		(
		 		inuIDLIQUIDABOBORECA
		);
		return(rcData.LBLPORCFINAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLBLVALORFIJO
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_BONO_LIQUIDARECA.LBLVALORFIJO%type
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN

		rcError.IDLIQUIDABOBORECA := inuIDLIQUIDABOBORECA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDABOBORECA
			 )
		then
			 return(rcData.LBLVALORFIJO);
		end if;
		Load
		(
		 		inuIDLIQUIDABOBORECA
		);
		return(rcData.LBLVALORFIJO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLBLDEPARTAMENTO
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_BONO_LIQUIDARECA.LBLDEPARTAMENTO%type
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN

		rcError.IDLIQUIDABOBORECA := inuIDLIQUIDABOBORECA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDABOBORECA
			 )
		then
			 return(rcData.LBLDEPARTAMENTO);
		end if;
		Load
		(
		 		inuIDLIQUIDABOBORECA
		);
		return(rcData.LBLDEPARTAMENTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLBLLOCALIDA
	(
		inuIDLIQUIDABOBORECA in LDC_CA_BONO_LIQUIDARECA.IDLIQUIDABOBORECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_BONO_LIQUIDARECA.LBLLOCALIDA%type
	IS
		rcError styLDC_CA_BONO_LIQUIDARECA;
	BEGIN

		rcError.IDLIQUIDABOBORECA := inuIDLIQUIDABOBORECA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDABOBORECA
			 )
		then
			 return(rcData.LBLLOCALIDA);
		end if;
		Load
		(
		 		inuIDLIQUIDABOBORECA
		);
		return(rcData.LBLLOCALIDA);
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
end DALDC_CA_BONO_LIQUIDARECA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_CA_BONO_LIQUIDARECA
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_CA_BONO_LIQUIDARECA', 'ADM_PERSON'); 
END;
/
