CREATE OR REPLACE PACKAGE adm_person.daldc_comi_tarifa
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type
	)
	IS
		SELECT LDC_COMI_TARIFA.*,LDC_COMI_TARIFA.rowid
		FROM LDC_COMI_TARIFA
		WHERE
		    COMI_TARIFA_ID = inuCOMI_TARIFA_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_COMI_TARIFA.*,LDC_COMI_TARIFA.rowid
		FROM LDC_COMI_TARIFA
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_COMI_TARIFA  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_COMI_TARIFA is table of styLDC_COMI_TARIFA index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_COMI_TARIFA;

	/* Tipos referenciando al registro */
	type tytbCOMI_TARIFA_ID is table of LDC_COMI_TARIFA.COMI_TARIFA_ID%type index by binary_integer;
	type tytbCOMISION_PLAN_ID is table of LDC_COMI_TARIFA.COMISION_PLAN_ID%type index by binary_integer;
	type tytbRANG_INI_PENETRA is table of LDC_COMI_TARIFA.RANG_INI_PENETRA%type index by binary_integer;
	type tytbRANG_FIN_PENETRA is table of LDC_COMI_TARIFA.RANG_FIN_PENETRA%type index by binary_integer;
	type tytbPORC_TOTAL_COMI is table of LDC_COMI_TARIFA.PORC_TOTAL_COMI%type index by binary_integer;
	type tytbPORC_ALINICIO is table of LDC_COMI_TARIFA.PORC_ALINICIO%type index by binary_integer;
	type tytbPORC_ALFINAL is table of LDC_COMI_TARIFA.PORC_ALFINAL%type index by binary_integer;
	type tytbVALOR_ALINICIO is table of LDC_COMI_TARIFA.VALOR_ALINICIO%type index by binary_integer;
	type tytbVALOR_ALFINAL is table of LDC_COMI_TARIFA.VALOR_ALFINAL%type index by binary_integer;
	type tytbFECHA_VIG_INICIAL is table of LDC_COMI_TARIFA.FECHA_VIG_INICIAL%type index by binary_integer;
	type tytbFECHA_VIG_FINAL is table of LDC_COMI_TARIFA.FECHA_VIG_FINAL%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_COMI_TARIFA is record
	(
		COMI_TARIFA_ID   tytbCOMI_TARIFA_ID,
		COMISION_PLAN_ID   tytbCOMISION_PLAN_ID,
		RANG_INI_PENETRA   tytbRANG_INI_PENETRA,
		RANG_FIN_PENETRA   tytbRANG_FIN_PENETRA,
		PORC_TOTAL_COMI   tytbPORC_TOTAL_COMI,
		PORC_ALINICIO   tytbPORC_ALINICIO,
		PORC_ALFINAL   tytbPORC_ALFINAL,
		VALOR_ALINICIO   tytbVALOR_ALINICIO,
		VALOR_ALFINAL   tytbVALOR_ALFINAL,
		FECHA_VIG_INICIAL   tytbFECHA_VIG_INICIAL,
		FECHA_VIG_FINAL   tytbFECHA_VIG_FINAL,
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
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type
	);

	PROCEDURE getRecord
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		orcRecord out nocopy styLDC_COMI_TARIFA
	);

	FUNCTION frcGetRcData
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type
	)
	RETURN styLDC_COMI_TARIFA;

	FUNCTION frcGetRcData
	RETURN styLDC_COMI_TARIFA;

	FUNCTION frcGetRecord
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type
	)
	RETURN styLDC_COMI_TARIFA;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_COMI_TARIFA
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_COMI_TARIFA in styLDC_COMI_TARIFA
	);

	PROCEDURE insRecord
	(
		ircLDC_COMI_TARIFA in styLDC_COMI_TARIFA,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_COMI_TARIFA in out nocopy tytbLDC_COMI_TARIFA
	);

	PROCEDURE delRecord
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_COMI_TARIFA in out nocopy tytbLDC_COMI_TARIFA,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_COMI_TARIFA in styLDC_COMI_TARIFA,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_COMI_TARIFA in out nocopy tytbLDC_COMI_TARIFA,
		inuLock in number default 1
	);

	PROCEDURE updCOMISION_PLAN_ID
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuCOMISION_PLAN_ID$ in LDC_COMI_TARIFA.COMISION_PLAN_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updRANG_INI_PENETRA
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRANG_INI_PENETRA$ in LDC_COMI_TARIFA.RANG_INI_PENETRA%type,
		inuLock in number default 0
	);

	PROCEDURE updRANG_FIN_PENETRA
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRANG_FIN_PENETRA$ in LDC_COMI_TARIFA.RANG_FIN_PENETRA%type,
		inuLock in number default 0
	);

	PROCEDURE updPORC_TOTAL_COMI
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuPORC_TOTAL_COMI$ in LDC_COMI_TARIFA.PORC_TOTAL_COMI%type,
		inuLock in number default 0
	);

	PROCEDURE updPORC_ALINICIO
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuPORC_ALINICIO$ in LDC_COMI_TARIFA.PORC_ALINICIO%type,
		inuLock in number default 0
	);

	PROCEDURE updPORC_ALFINAL
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuPORC_ALFINAL$ in LDC_COMI_TARIFA.PORC_ALFINAL%type,
		inuLock in number default 0
	);

	PROCEDURE updVALOR_ALINICIO
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuVALOR_ALINICIO$ in LDC_COMI_TARIFA.VALOR_ALINICIO%type,
		inuLock in number default 0
	);

	PROCEDURE updVALOR_ALFINAL
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuVALOR_ALFINAL$ in LDC_COMI_TARIFA.VALOR_ALFINAL%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_VIG_INICIAL
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		idtFECHA_VIG_INICIAL$ in LDC_COMI_TARIFA.FECHA_VIG_INICIAL%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_VIG_FINAL
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		idtFECHA_VIG_FINAL$ in LDC_COMI_TARIFA.FECHA_VIG_FINAL%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCOMI_TARIFA_ID
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.COMI_TARIFA_ID%type;

	FUNCTION fnuGetCOMISION_PLAN_ID
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.COMISION_PLAN_ID%type;

	FUNCTION fnuGetRANG_INI_PENETRA
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.RANG_INI_PENETRA%type;

	FUNCTION fnuGetRANG_FIN_PENETRA
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.RANG_FIN_PENETRA%type;

	FUNCTION fnuGetPORC_TOTAL_COMI
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.PORC_TOTAL_COMI%type;

	FUNCTION fnuGetPORC_ALINICIO
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.PORC_ALINICIO%type;

	FUNCTION fnuGetPORC_ALFINAL
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.PORC_ALFINAL%type;

	FUNCTION fnuGetVALOR_ALINICIO
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.VALOR_ALINICIO%type;

	FUNCTION fnuGetVALOR_ALFINAL
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.VALOR_ALFINAL%type;

	FUNCTION fdtGetFECHA_VIG_INICIAL
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.FECHA_VIG_INICIAL%type;

	FUNCTION fdtGetFECHA_VIG_FINAL
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.FECHA_VIG_FINAL%type;


	PROCEDURE LockByPk
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		orcLDC_COMI_TARIFA  out styLDC_COMI_TARIFA
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_COMI_TARIFA  out styLDC_COMI_TARIFA
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_COMI_TARIFA;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_COMI_TARIFA
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_COMI_TARIFA';
	 cnuGeEntityId constant varchar2(30) := 8150; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type
	)
	IS
		SELECT LDC_COMI_TARIFA.*,LDC_COMI_TARIFA.rowid
		FROM LDC_COMI_TARIFA
		WHERE  COMI_TARIFA_ID = inuCOMI_TARIFA_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_COMI_TARIFA.*,LDC_COMI_TARIFA.rowid
		FROM LDC_COMI_TARIFA
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_COMI_TARIFA is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_COMI_TARIFA;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_COMI_TARIFA default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.COMI_TARIFA_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		orcLDC_COMI_TARIFA  out styLDC_COMI_TARIFA
	)
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN
		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;

		Open cuLockRcByPk
		(
			inuCOMI_TARIFA_ID
		);

		fetch cuLockRcByPk into orcLDC_COMI_TARIFA;
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
		orcLDC_COMI_TARIFA  out styLDC_COMI_TARIFA
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_COMI_TARIFA;
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
		itbLDC_COMI_TARIFA  in out nocopy tytbLDC_COMI_TARIFA
	)
	IS
	BEGIN
			rcRecOfTab.COMI_TARIFA_ID.delete;
			rcRecOfTab.COMISION_PLAN_ID.delete;
			rcRecOfTab.RANG_INI_PENETRA.delete;
			rcRecOfTab.RANG_FIN_PENETRA.delete;
			rcRecOfTab.PORC_TOTAL_COMI.delete;
			rcRecOfTab.PORC_ALINICIO.delete;
			rcRecOfTab.PORC_ALFINAL.delete;
			rcRecOfTab.VALOR_ALINICIO.delete;
			rcRecOfTab.VALOR_ALFINAL.delete;
			rcRecOfTab.FECHA_VIG_INICIAL.delete;
			rcRecOfTab.FECHA_VIG_FINAL.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_COMI_TARIFA  in out nocopy tytbLDC_COMI_TARIFA,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_COMI_TARIFA);

		for n in itbLDC_COMI_TARIFA.first .. itbLDC_COMI_TARIFA.last loop
			rcRecOfTab.COMI_TARIFA_ID(n) := itbLDC_COMI_TARIFA(n).COMI_TARIFA_ID;
			rcRecOfTab.COMISION_PLAN_ID(n) := itbLDC_COMI_TARIFA(n).COMISION_PLAN_ID;
			rcRecOfTab.RANG_INI_PENETRA(n) := itbLDC_COMI_TARIFA(n).RANG_INI_PENETRA;
			rcRecOfTab.RANG_FIN_PENETRA(n) := itbLDC_COMI_TARIFA(n).RANG_FIN_PENETRA;
			rcRecOfTab.PORC_TOTAL_COMI(n) := itbLDC_COMI_TARIFA(n).PORC_TOTAL_COMI;
			rcRecOfTab.PORC_ALINICIO(n) := itbLDC_COMI_TARIFA(n).PORC_ALINICIO;
			rcRecOfTab.PORC_ALFINAL(n) := itbLDC_COMI_TARIFA(n).PORC_ALFINAL;
			rcRecOfTab.VALOR_ALINICIO(n) := itbLDC_COMI_TARIFA(n).VALOR_ALINICIO;
			rcRecOfTab.VALOR_ALFINAL(n) := itbLDC_COMI_TARIFA(n).VALOR_ALFINAL;
			rcRecOfTab.FECHA_VIG_INICIAL(n) := itbLDC_COMI_TARIFA(n).FECHA_VIG_INICIAL;
			rcRecOfTab.FECHA_VIG_FINAL(n) := itbLDC_COMI_TARIFA(n).FECHA_VIG_FINAL;
			rcRecOfTab.row_id(n) := itbLDC_COMI_TARIFA(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCOMI_TARIFA_ID
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
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCOMI_TARIFA_ID = rcData.COMI_TARIFA_ID
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
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCOMI_TARIFA_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type
	)
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN		rcError.COMI_TARIFA_ID:=inuCOMI_TARIFA_ID;

		Load
		(
			inuCOMI_TARIFA_ID
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
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuCOMI_TARIFA_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		orcRecord out nocopy styLDC_COMI_TARIFA
	)
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN		rcError.COMI_TARIFA_ID:=inuCOMI_TARIFA_ID;

		Load
		(
			inuCOMI_TARIFA_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type
	)
	RETURN styLDC_COMI_TARIFA
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN
		rcError.COMI_TARIFA_ID:=inuCOMI_TARIFA_ID;

		Load
		(
			inuCOMI_TARIFA_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type
	)
	RETURN styLDC_COMI_TARIFA
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN
		rcError.COMI_TARIFA_ID:=inuCOMI_TARIFA_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCOMI_TARIFA_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCOMI_TARIFA_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_COMI_TARIFA
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_COMI_TARIFA
	)
	IS
		rfLDC_COMI_TARIFA tyrfLDC_COMI_TARIFA;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_COMI_TARIFA.*, LDC_COMI_TARIFA.rowid FROM LDC_COMI_TARIFA';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_COMI_TARIFA for sbFullQuery;

		fetch rfLDC_COMI_TARIFA bulk collect INTO otbResult;

		close rfLDC_COMI_TARIFA;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_COMI_TARIFA.*, LDC_COMI_TARIFA.rowid FROM LDC_COMI_TARIFA';
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
		ircLDC_COMI_TARIFA in styLDC_COMI_TARIFA
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_COMI_TARIFA,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_COMI_TARIFA in styLDC_COMI_TARIFA,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_COMI_TARIFA.COMI_TARIFA_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|COMI_TARIFA_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_COMI_TARIFA
		(
			COMI_TARIFA_ID,
			COMISION_PLAN_ID,
			RANG_INI_PENETRA,
			RANG_FIN_PENETRA,
			PORC_TOTAL_COMI,
			PORC_ALINICIO,
			PORC_ALFINAL,
			VALOR_ALINICIO,
			VALOR_ALFINAL,
			FECHA_VIG_INICIAL,
			FECHA_VIG_FINAL
		)
		values
		(
			ircLDC_COMI_TARIFA.COMI_TARIFA_ID,
			ircLDC_COMI_TARIFA.COMISION_PLAN_ID,
			ircLDC_COMI_TARIFA.RANG_INI_PENETRA,
			ircLDC_COMI_TARIFA.RANG_FIN_PENETRA,
			ircLDC_COMI_TARIFA.PORC_TOTAL_COMI,
			ircLDC_COMI_TARIFA.PORC_ALINICIO,
			ircLDC_COMI_TARIFA.PORC_ALFINAL,
			ircLDC_COMI_TARIFA.VALOR_ALINICIO,
			ircLDC_COMI_TARIFA.VALOR_ALFINAL,
			ircLDC_COMI_TARIFA.FECHA_VIG_INICIAL,
			ircLDC_COMI_TARIFA.FECHA_VIG_FINAL
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_COMI_TARIFA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_COMI_TARIFA in out nocopy tytbLDC_COMI_TARIFA
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_COMI_TARIFA,blUseRowID);
		forall n in iotbLDC_COMI_TARIFA.first..iotbLDC_COMI_TARIFA.last
			insert into LDC_COMI_TARIFA
			(
				COMI_TARIFA_ID,
				COMISION_PLAN_ID,
				RANG_INI_PENETRA,
				RANG_FIN_PENETRA,
				PORC_TOTAL_COMI,
				PORC_ALINICIO,
				PORC_ALFINAL,
				VALOR_ALINICIO,
				VALOR_ALFINAL,
				FECHA_VIG_INICIAL,
				FECHA_VIG_FINAL
			)
			values
			(
				rcRecOfTab.COMI_TARIFA_ID(n),
				rcRecOfTab.COMISION_PLAN_ID(n),
				rcRecOfTab.RANG_INI_PENETRA(n),
				rcRecOfTab.RANG_FIN_PENETRA(n),
				rcRecOfTab.PORC_TOTAL_COMI(n),
				rcRecOfTab.PORC_ALINICIO(n),
				rcRecOfTab.PORC_ALFINAL(n),
				rcRecOfTab.VALOR_ALINICIO(n),
				rcRecOfTab.VALOR_ALFINAL(n),
				rcRecOfTab.FECHA_VIG_INICIAL(n),
				rcRecOfTab.FECHA_VIG_FINAL(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN
		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;

		if inuLock=1 then
			LockByPk
			(
				inuCOMI_TARIFA_ID,
				rcData
			);
		end if;


		delete
		from LDC_COMI_TARIFA
		where
       		COMI_TARIFA_ID=inuCOMI_TARIFA_ID;
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
		rcError  styLDC_COMI_TARIFA;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_COMI_TARIFA
		where
			rowid = iriRowID
		returning
			COMI_TARIFA_ID
		into
			rcError.COMI_TARIFA_ID;
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
		iotbLDC_COMI_TARIFA in out nocopy tytbLDC_COMI_TARIFA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_COMI_TARIFA;
	BEGIN
		FillRecordOfTables(iotbLDC_COMI_TARIFA, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_COMI_TARIFA.first .. iotbLDC_COMI_TARIFA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COMI_TARIFA.first .. iotbLDC_COMI_TARIFA.last
				delete
				from LDC_COMI_TARIFA
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_COMI_TARIFA.first .. iotbLDC_COMI_TARIFA.last loop
					LockByPk
					(
						rcRecOfTab.COMI_TARIFA_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COMI_TARIFA.first .. iotbLDC_COMI_TARIFA.last
				delete
				from LDC_COMI_TARIFA
				where
		         	COMI_TARIFA_ID = rcRecOfTab.COMI_TARIFA_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_COMI_TARIFA in styLDC_COMI_TARIFA,
		inuLock in number default 0
	)
	IS
		nuCOMI_TARIFA_ID	LDC_COMI_TARIFA.COMI_TARIFA_ID%type;
	BEGIN
		if ircLDC_COMI_TARIFA.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_COMI_TARIFA.rowid,rcData);
			end if;
			update LDC_COMI_TARIFA
			set
				COMISION_PLAN_ID = ircLDC_COMI_TARIFA.COMISION_PLAN_ID,
				RANG_INI_PENETRA = ircLDC_COMI_TARIFA.RANG_INI_PENETRA,
				RANG_FIN_PENETRA = ircLDC_COMI_TARIFA.RANG_FIN_PENETRA,
				PORC_TOTAL_COMI = ircLDC_COMI_TARIFA.PORC_TOTAL_COMI,
				PORC_ALINICIO = ircLDC_COMI_TARIFA.PORC_ALINICIO,
				PORC_ALFINAL = ircLDC_COMI_TARIFA.PORC_ALFINAL,
				VALOR_ALINICIO = ircLDC_COMI_TARIFA.VALOR_ALINICIO,
				VALOR_ALFINAL = ircLDC_COMI_TARIFA.VALOR_ALFINAL,
				FECHA_VIG_INICIAL = ircLDC_COMI_TARIFA.FECHA_VIG_INICIAL,
				FECHA_VIG_FINAL = ircLDC_COMI_TARIFA.FECHA_VIG_FINAL
			where
				rowid = ircLDC_COMI_TARIFA.rowid
			returning
				COMI_TARIFA_ID
			into
				nuCOMI_TARIFA_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_COMI_TARIFA.COMI_TARIFA_ID,
					rcData
				);
			end if;

			update LDC_COMI_TARIFA
			set
				COMISION_PLAN_ID = ircLDC_COMI_TARIFA.COMISION_PLAN_ID,
				RANG_INI_PENETRA = ircLDC_COMI_TARIFA.RANG_INI_PENETRA,
				RANG_FIN_PENETRA = ircLDC_COMI_TARIFA.RANG_FIN_PENETRA,
				PORC_TOTAL_COMI = ircLDC_COMI_TARIFA.PORC_TOTAL_COMI,
				PORC_ALINICIO = ircLDC_COMI_TARIFA.PORC_ALINICIO,
				PORC_ALFINAL = ircLDC_COMI_TARIFA.PORC_ALFINAL,
				VALOR_ALINICIO = ircLDC_COMI_TARIFA.VALOR_ALINICIO,
				VALOR_ALFINAL = ircLDC_COMI_TARIFA.VALOR_ALFINAL,
				FECHA_VIG_INICIAL = ircLDC_COMI_TARIFA.FECHA_VIG_INICIAL,
				FECHA_VIG_FINAL = ircLDC_COMI_TARIFA.FECHA_VIG_FINAL
			where
				COMI_TARIFA_ID = ircLDC_COMI_TARIFA.COMI_TARIFA_ID
			returning
				COMI_TARIFA_ID
			into
				nuCOMI_TARIFA_ID;
		end if;
		if
			nuCOMI_TARIFA_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_COMI_TARIFA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_COMI_TARIFA in out nocopy tytbLDC_COMI_TARIFA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_COMI_TARIFA;
	BEGIN
		FillRecordOfTables(iotbLDC_COMI_TARIFA,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_COMI_TARIFA.first .. iotbLDC_COMI_TARIFA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COMI_TARIFA.first .. iotbLDC_COMI_TARIFA.last
				update LDC_COMI_TARIFA
				set
					COMISION_PLAN_ID = rcRecOfTab.COMISION_PLAN_ID(n),
					RANG_INI_PENETRA = rcRecOfTab.RANG_INI_PENETRA(n),
					RANG_FIN_PENETRA = rcRecOfTab.RANG_FIN_PENETRA(n),
					PORC_TOTAL_COMI = rcRecOfTab.PORC_TOTAL_COMI(n),
					PORC_ALINICIO = rcRecOfTab.PORC_ALINICIO(n),
					PORC_ALFINAL = rcRecOfTab.PORC_ALFINAL(n),
					VALOR_ALINICIO = rcRecOfTab.VALOR_ALINICIO(n),
					VALOR_ALFINAL = rcRecOfTab.VALOR_ALFINAL(n),
					FECHA_VIG_INICIAL = rcRecOfTab.FECHA_VIG_INICIAL(n),
					FECHA_VIG_FINAL = rcRecOfTab.FECHA_VIG_FINAL(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_COMI_TARIFA.first .. iotbLDC_COMI_TARIFA.last loop
					LockByPk
					(
						rcRecOfTab.COMI_TARIFA_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COMI_TARIFA.first .. iotbLDC_COMI_TARIFA.last
				update LDC_COMI_TARIFA
				SET
					COMISION_PLAN_ID = rcRecOfTab.COMISION_PLAN_ID(n),
					RANG_INI_PENETRA = rcRecOfTab.RANG_INI_PENETRA(n),
					RANG_FIN_PENETRA = rcRecOfTab.RANG_FIN_PENETRA(n),
					PORC_TOTAL_COMI = rcRecOfTab.PORC_TOTAL_COMI(n),
					PORC_ALINICIO = rcRecOfTab.PORC_ALINICIO(n),
					PORC_ALFINAL = rcRecOfTab.PORC_ALFINAL(n),
					VALOR_ALINICIO = rcRecOfTab.VALOR_ALINICIO(n),
					VALOR_ALFINAL = rcRecOfTab.VALOR_ALFINAL(n),
					FECHA_VIG_INICIAL = rcRecOfTab.FECHA_VIG_INICIAL(n),
					FECHA_VIG_FINAL = rcRecOfTab.FECHA_VIG_FINAL(n)
				where
					COMI_TARIFA_ID = rcRecOfTab.COMI_TARIFA_ID(n)
;
		end if;
	END;
	PROCEDURE updCOMISION_PLAN_ID
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuCOMISION_PLAN_ID$ in LDC_COMI_TARIFA.COMISION_PLAN_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN
		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMI_TARIFA_ID,
				rcData
			);
		end if;

		update LDC_COMI_TARIFA
		set
			COMISION_PLAN_ID = inuCOMISION_PLAN_ID$
		where
			COMI_TARIFA_ID = inuCOMI_TARIFA_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMISION_PLAN_ID:= inuCOMISION_PLAN_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRANG_INI_PENETRA
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRANG_INI_PENETRA$ in LDC_COMI_TARIFA.RANG_INI_PENETRA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN
		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMI_TARIFA_ID,
				rcData
			);
		end if;

		update LDC_COMI_TARIFA
		set
			RANG_INI_PENETRA = inuRANG_INI_PENETRA$
		where
			COMI_TARIFA_ID = inuCOMI_TARIFA_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RANG_INI_PENETRA:= inuRANG_INI_PENETRA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRANG_FIN_PENETRA
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRANG_FIN_PENETRA$ in LDC_COMI_TARIFA.RANG_FIN_PENETRA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN
		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMI_TARIFA_ID,
				rcData
			);
		end if;

		update LDC_COMI_TARIFA
		set
			RANG_FIN_PENETRA = inuRANG_FIN_PENETRA$
		where
			COMI_TARIFA_ID = inuCOMI_TARIFA_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RANG_FIN_PENETRA:= inuRANG_FIN_PENETRA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPORC_TOTAL_COMI
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuPORC_TOTAL_COMI$ in LDC_COMI_TARIFA.PORC_TOTAL_COMI%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN
		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMI_TARIFA_ID,
				rcData
			);
		end if;

		update LDC_COMI_TARIFA
		set
			PORC_TOTAL_COMI = inuPORC_TOTAL_COMI$
		where
			COMI_TARIFA_ID = inuCOMI_TARIFA_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PORC_TOTAL_COMI:= inuPORC_TOTAL_COMI$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPORC_ALINICIO
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuPORC_ALINICIO$ in LDC_COMI_TARIFA.PORC_ALINICIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN
		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMI_TARIFA_ID,
				rcData
			);
		end if;

		update LDC_COMI_TARIFA
		set
			PORC_ALINICIO = inuPORC_ALINICIO$
		where
			COMI_TARIFA_ID = inuCOMI_TARIFA_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PORC_ALINICIO:= inuPORC_ALINICIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPORC_ALFINAL
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuPORC_ALFINAL$ in LDC_COMI_TARIFA.PORC_ALFINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN
		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMI_TARIFA_ID,
				rcData
			);
		end if;

		update LDC_COMI_TARIFA
		set
			PORC_ALFINAL = inuPORC_ALFINAL$
		where
			COMI_TARIFA_ID = inuCOMI_TARIFA_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PORC_ALFINAL:= inuPORC_ALFINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALOR_ALINICIO
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuVALOR_ALINICIO$ in LDC_COMI_TARIFA.VALOR_ALINICIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN
		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMI_TARIFA_ID,
				rcData
			);
		end if;

		update LDC_COMI_TARIFA
		set
			VALOR_ALINICIO = inuVALOR_ALINICIO$
		where
			COMI_TARIFA_ID = inuCOMI_TARIFA_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALOR_ALINICIO:= inuVALOR_ALINICIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALOR_ALFINAL
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuVALOR_ALFINAL$ in LDC_COMI_TARIFA.VALOR_ALFINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN
		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMI_TARIFA_ID,
				rcData
			);
		end if;

		update LDC_COMI_TARIFA
		set
			VALOR_ALFINAL = inuVALOR_ALFINAL$
		where
			COMI_TARIFA_ID = inuCOMI_TARIFA_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALOR_ALFINAL:= inuVALOR_ALFINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_VIG_INICIAL
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		idtFECHA_VIG_INICIAL$ in LDC_COMI_TARIFA.FECHA_VIG_INICIAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN
		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMI_TARIFA_ID,
				rcData
			);
		end if;

		update LDC_COMI_TARIFA
		set
			FECHA_VIG_INICIAL = idtFECHA_VIG_INICIAL$
		where
			COMI_TARIFA_ID = inuCOMI_TARIFA_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_VIG_INICIAL:= idtFECHA_VIG_INICIAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_VIG_FINAL
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		idtFECHA_VIG_FINAL$ in LDC_COMI_TARIFA.FECHA_VIG_FINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN
		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMI_TARIFA_ID,
				rcData
			);
		end if;

		update LDC_COMI_TARIFA
		set
			FECHA_VIG_FINAL = idtFECHA_VIG_FINAL$
		where
			COMI_TARIFA_ID = inuCOMI_TARIFA_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_VIG_FINAL:= idtFECHA_VIG_FINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCOMI_TARIFA_ID
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.COMI_TARIFA_ID%type
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN

		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMI_TARIFA_ID
			 )
		then
			 return(rcData.COMI_TARIFA_ID);
		end if;
		Load
		(
		 		inuCOMI_TARIFA_ID
		);
		return(rcData.COMI_TARIFA_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOMISION_PLAN_ID
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.COMISION_PLAN_ID%type
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN

		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMI_TARIFA_ID
			 )
		then
			 return(rcData.COMISION_PLAN_ID);
		end if;
		Load
		(
		 		inuCOMI_TARIFA_ID
		);
		return(rcData.COMISION_PLAN_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRANG_INI_PENETRA
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.RANG_INI_PENETRA%type
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN

		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMI_TARIFA_ID
			 )
		then
			 return(rcData.RANG_INI_PENETRA);
		end if;
		Load
		(
		 		inuCOMI_TARIFA_ID
		);
		return(rcData.RANG_INI_PENETRA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRANG_FIN_PENETRA
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.RANG_FIN_PENETRA%type
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN

		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMI_TARIFA_ID
			 )
		then
			 return(rcData.RANG_FIN_PENETRA);
		end if;
		Load
		(
		 		inuCOMI_TARIFA_ID
		);
		return(rcData.RANG_FIN_PENETRA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPORC_TOTAL_COMI
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.PORC_TOTAL_COMI%type
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN

		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMI_TARIFA_ID
			 )
		then
			 return(rcData.PORC_TOTAL_COMI);
		end if;
		Load
		(
		 		inuCOMI_TARIFA_ID
		);
		return(rcData.PORC_TOTAL_COMI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPORC_ALINICIO
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.PORC_ALINICIO%type
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN

		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMI_TARIFA_ID
			 )
		then
			 return(rcData.PORC_ALINICIO);
		end if;
		Load
		(
		 		inuCOMI_TARIFA_ID
		);
		return(rcData.PORC_ALINICIO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPORC_ALFINAL
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.PORC_ALFINAL%type
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN

		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMI_TARIFA_ID
			 )
		then
			 return(rcData.PORC_ALFINAL);
		end if;
		Load
		(
		 		inuCOMI_TARIFA_ID
		);
		return(rcData.PORC_ALFINAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALOR_ALINICIO
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.VALOR_ALINICIO%type
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN

		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMI_TARIFA_ID
			 )
		then
			 return(rcData.VALOR_ALINICIO);
		end if;
		Load
		(
		 		inuCOMI_TARIFA_ID
		);
		return(rcData.VALOR_ALINICIO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALOR_ALFINAL
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.VALOR_ALFINAL%type
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN

		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMI_TARIFA_ID
			 )
		then
			 return(rcData.VALOR_ALFINAL);
		end if;
		Load
		(
		 		inuCOMI_TARIFA_ID
		);
		return(rcData.VALOR_ALFINAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_VIG_INICIAL
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.FECHA_VIG_INICIAL%type
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN

		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMI_TARIFA_ID
			 )
		then
			 return(rcData.FECHA_VIG_INICIAL);
		end if;
		Load
		(
		 		inuCOMI_TARIFA_ID
		);
		return(rcData.FECHA_VIG_INICIAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_VIG_FINAL
	(
		inuCOMI_TARIFA_ID in LDC_COMI_TARIFA.COMI_TARIFA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COMI_TARIFA.FECHA_VIG_FINAL%type
	IS
		rcError styLDC_COMI_TARIFA;
	BEGIN

		rcError.COMI_TARIFA_ID := inuCOMI_TARIFA_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMI_TARIFA_ID
			 )
		then
			 return(rcData.FECHA_VIG_FINAL);
		end if;
		Load
		(
		 		inuCOMI_TARIFA_ID
		);
		return(rcData.FECHA_VIG_FINAL);
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
end DALDC_COMI_TARIFA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_COMI_TARIFA
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_COMI_TARIFA', 'ADM_PERSON'); 
END;
/

