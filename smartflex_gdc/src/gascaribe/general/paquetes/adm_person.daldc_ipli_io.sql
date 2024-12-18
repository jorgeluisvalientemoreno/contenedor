CREATE OR REPLACE PACKAGE adm_person.DALDC_IPLI_IO
is  
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_IPLI_IO
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
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type
	)
	IS
		SELECT LDC_IPLI_IO.*,LDC_IPLI_IO.rowid
		FROM LDC_IPLI_IO
		WHERE
		    IPLIO_ID = inuIPLIO_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_IPLI_IO.*,LDC_IPLI_IO.rowid
		FROM LDC_IPLI_IO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_IPLI_IO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_IPLI_IO is table of styLDC_IPLI_IO index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_IPLI_IO;

	/* Tipos referenciando al registro */
	type tytbIPLIO_ID is table of LDC_IPLI_IO.IPLIO_ID%type index by binary_integer;
	type tytbIPLIMEDE is table of LDC_IPLI_IO.IPLIMEDE%type index by binary_integer;
	type tytbIPLIFECH is table of LDC_IPLI_IO.IPLIFECH%type index by binary_integer;
	type tytbIPLIHORA is table of LDC_IPLI_IO.IPLIHORA%type index by binary_integer;
	type tytbIPLIDIRE is table of LDC_IPLI_IO.IPLIDIRE%type index by binary_integer;
	type tytbIPLIBARR is table of LDC_IPLI_IO.IPLIBARR%type index by binary_integer;
	type tytbIPLIESTA is table of LDC_IPLI_IO.IPLIESTA%type index by binary_integer;
	type tytbIPLILOCA is table of LDC_IPLI_IO.IPLILOCA%type index by binary_integer;
	type tytbIPLICONCE is table of LDC_IPLI_IO.IPLICONCE%type index by binary_integer;
	type tytbIPLIPRES is table of LDC_IPLI_IO.IPLIPRES%type index by binary_integer;
	type tytbIPLITIOD is table of LDC_IPLI_IO.IPLITIOD%type index by binary_integer;
	type tytbIPLIMETO is table of LDC_IPLI_IO.IPLIMETO%type index by binary_integer;
	type tytbIPLIREGU is table of LDC_IPLI_IO.IPLIREGU%type index by binary_integer;
	type tytbIPLILECT is table of LDC_IPLI_IO.IPLILECT%type index by binary_integer;
	type tytbORDER_ID is table of LDC_IPLI_IO.ORDER_ID%type index by binary_integer;
	type tytbFLAG is table of LDC_IPLI_IO.FLAG%type index by binary_integer;
	type tytbUNIT_OPER is table of LDC_IPLI_IO.UNIT_OPER%type index by binary_integer;
	type tytbIPLIFECC is table of LDC_IPLI_IO.IPLIFECC%type index by binary_integer;
	type tytbIPLIUSUC is table of LDC_IPLI_IO.IPLIUSUC%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_IPLI_IO is record
	(
		IPLIO_ID   tytbIPLIO_ID,
		IPLIMEDE   tytbIPLIMEDE,
		IPLIFECH   tytbIPLIFECH,
		IPLIHORA   tytbIPLIHORA,
		IPLIDIRE   tytbIPLIDIRE,
		IPLIBARR   tytbIPLIBARR,
		IPLIESTA   tytbIPLIESTA,
		IPLILOCA   tytbIPLILOCA,
		IPLICONCE   tytbIPLICONCE,
		IPLIPRES   tytbIPLIPRES,
		IPLITIOD   tytbIPLITIOD,
		IPLIMETO   tytbIPLIMETO,
		IPLIREGU   tytbIPLIREGU,
		IPLILECT   tytbIPLILECT,
		ORDER_ID   tytbORDER_ID,
		FLAG   tytbFLAG,
		UNIT_OPER   tytbUNIT_OPER,
		IPLIFECC   tytbIPLIFECC,
		IPLIUSUC   tytbIPLIUSUC,
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
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type
	);

	PROCEDURE getRecord
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		orcRecord out nocopy styLDC_IPLI_IO
	);

	FUNCTION frcGetRcData
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type
	)
	RETURN styLDC_IPLI_IO;

	FUNCTION frcGetRcData
	RETURN styLDC_IPLI_IO;

	FUNCTION frcGetRecord
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type
	)
	RETURN styLDC_IPLI_IO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_IPLI_IO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_IPLI_IO in styLDC_IPLI_IO
	);

	PROCEDURE insRecord
	(
		ircLDC_IPLI_IO in styLDC_IPLI_IO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_IPLI_IO in out nocopy tytbLDC_IPLI_IO
	);

	PROCEDURE delRecord
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_IPLI_IO in out nocopy tytbLDC_IPLI_IO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_IPLI_IO in styLDC_IPLI_IO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_IPLI_IO in out nocopy tytbLDC_IPLI_IO,
		inuLock in number default 1
	);

	PROCEDURE updIPLIMEDE
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLIMEDE$ in LDC_IPLI_IO.IPLIMEDE%type,
		inuLock in number default 0
	);

	PROCEDURE updIPLIFECH
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		idtIPLIFECH$ in LDC_IPLI_IO.IPLIFECH%type,
		inuLock in number default 0
	);

	PROCEDURE updIPLIHORA
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLIHORA$ in LDC_IPLI_IO.IPLIHORA%type,
		inuLock in number default 0
	);

	PROCEDURE updIPLIDIRE
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLIDIRE$ in LDC_IPLI_IO.IPLIDIRE%type,
		inuLock in number default 0
	);

	PROCEDURE updIPLIBARR
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLIBARR$ in LDC_IPLI_IO.IPLIBARR%type,
		inuLock in number default 0
	);

	PROCEDURE updIPLIESTA
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLIESTA$ in LDC_IPLI_IO.IPLIESTA%type,
		inuLock in number default 0
	);

	PROCEDURE updIPLILOCA
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLILOCA$ in LDC_IPLI_IO.IPLILOCA%type,
		inuLock in number default 0
	);

	PROCEDURE updIPLICONCE
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuIPLICONCE$ in LDC_IPLI_IO.IPLICONCE%type,
		inuLock in number default 0
	);

	PROCEDURE updIPLIPRES
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuIPLIPRES$ in LDC_IPLI_IO.IPLIPRES%type,
		inuLock in number default 0
	);

	PROCEDURE updIPLITIOD
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLITIOD$ in LDC_IPLI_IO.IPLITIOD%type,
		inuLock in number default 0
	);

	PROCEDURE updIPLIMETO
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLIMETO$ in LDC_IPLI_IO.IPLIMETO%type,
		inuLock in number default 0
	);

	PROCEDURE updIPLIREGU
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLIREGU$ in LDC_IPLI_IO.IPLIREGU%type,
		inuLock in number default 0
	);

	PROCEDURE updIPLILECT
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuIPLILECT$ in LDC_IPLI_IO.IPLILECT%type,
		inuLock in number default 0
	);

	PROCEDURE updORDER_ID
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuORDER_ID$ in LDC_IPLI_IO.ORDER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updFLAG
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbFLAG$ in LDC_IPLI_IO.FLAG%type,
		inuLock in number default 0
	);

	PROCEDURE updUNIT_OPER
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbUNIT_OPER$ in LDC_IPLI_IO.UNIT_OPER%type,
		inuLock in number default 0
	);

	PROCEDURE updIPLIFECC
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		idtIPLIFECC$ in LDC_IPLI_IO.IPLIFECC%type,
		inuLock in number default 0
	);

	PROCEDURE updIPLIUSUC
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLIUSUC$ in LDC_IPLI_IO.IPLIUSUC%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetIPLIO_ID
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIO_ID%type;

	FUNCTION fsbGetIPLIMEDE
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIMEDE%type;

	FUNCTION fdtGetIPLIFECH
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIFECH%type;

	FUNCTION fsbGetIPLIHORA
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIHORA%type;

	FUNCTION fsbGetIPLIDIRE
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIDIRE%type;

	FUNCTION fsbGetIPLIBARR
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIBARR%type;

	FUNCTION fsbGetIPLIESTA
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIESTA%type;

	FUNCTION fsbGetIPLILOCA
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLILOCA%type;

	FUNCTION fnuGetIPLICONCE
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLICONCE%type;

	FUNCTION fnuGetIPLIPRES
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIPRES%type;

	FUNCTION fsbGetIPLITIOD
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLITIOD%type;

	FUNCTION fsbGetIPLIMETO
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIMETO%type;

	FUNCTION fsbGetIPLIREGU
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIREGU%type;

	FUNCTION fnuGetIPLILECT
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLILECT%type;

	FUNCTION fnuGetORDER_ID
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.ORDER_ID%type;

	FUNCTION fsbGetFLAG
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.FLAG%type;

	FUNCTION fsbGetUNIT_OPER
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.UNIT_OPER%type;

	FUNCTION fdtGetIPLIFECC
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIFECC%type;

	FUNCTION fsbGetIPLIUSUC
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIUSUC%type;


	PROCEDURE LockByPk
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		orcLDC_IPLI_IO  out styLDC_IPLI_IO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_IPLI_IO  out styLDC_IPLI_IO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_IPLI_IO;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_IPLI_IO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_IPLI_IO';
	 cnuGeEntityId constant varchar2(30) := 8871; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type
	)
	IS
		SELECT LDC_IPLI_IO.*,LDC_IPLI_IO.rowid
		FROM LDC_IPLI_IO
		WHERE  IPLIO_ID = inuIPLIO_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_IPLI_IO.*,LDC_IPLI_IO.rowid
		FROM LDC_IPLI_IO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_IPLI_IO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_IPLI_IO;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_IPLI_IO default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.IPLIO_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		orcLDC_IPLI_IO  out styLDC_IPLI_IO
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;

		Open cuLockRcByPk
		(
			inuIPLIO_ID
		);

		fetch cuLockRcByPk into orcLDC_IPLI_IO;
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
		orcLDC_IPLI_IO  out styLDC_IPLI_IO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_IPLI_IO;
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
		itbLDC_IPLI_IO  in out nocopy tytbLDC_IPLI_IO
	)
	IS
	BEGIN
			rcRecOfTab.IPLIO_ID.delete;
			rcRecOfTab.IPLIMEDE.delete;
			rcRecOfTab.IPLIFECH.delete;
			rcRecOfTab.IPLIHORA.delete;
			rcRecOfTab.IPLIDIRE.delete;
			rcRecOfTab.IPLIBARR.delete;
			rcRecOfTab.IPLIESTA.delete;
			rcRecOfTab.IPLILOCA.delete;
			rcRecOfTab.IPLICONCE.delete;
			rcRecOfTab.IPLIPRES.delete;
			rcRecOfTab.IPLITIOD.delete;
			rcRecOfTab.IPLIMETO.delete;
			rcRecOfTab.IPLIREGU.delete;
			rcRecOfTab.IPLILECT.delete;
			rcRecOfTab.ORDER_ID.delete;
			rcRecOfTab.FLAG.delete;
			rcRecOfTab.UNIT_OPER.delete;
			rcRecOfTab.IPLIFECC.delete;
			rcRecOfTab.IPLIUSUC.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_IPLI_IO  in out nocopy tytbLDC_IPLI_IO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_IPLI_IO);

		for n in itbLDC_IPLI_IO.first .. itbLDC_IPLI_IO.last loop
			rcRecOfTab.IPLIO_ID(n) := itbLDC_IPLI_IO(n).IPLIO_ID;
			rcRecOfTab.IPLIMEDE(n) := itbLDC_IPLI_IO(n).IPLIMEDE;
			rcRecOfTab.IPLIFECH(n) := itbLDC_IPLI_IO(n).IPLIFECH;
			rcRecOfTab.IPLIHORA(n) := itbLDC_IPLI_IO(n).IPLIHORA;
			rcRecOfTab.IPLIDIRE(n) := itbLDC_IPLI_IO(n).IPLIDIRE;
			rcRecOfTab.IPLIBARR(n) := itbLDC_IPLI_IO(n).IPLIBARR;
			rcRecOfTab.IPLIESTA(n) := itbLDC_IPLI_IO(n).IPLIESTA;
			rcRecOfTab.IPLILOCA(n) := itbLDC_IPLI_IO(n).IPLILOCA;
			rcRecOfTab.IPLICONCE(n) := itbLDC_IPLI_IO(n).IPLICONCE;
			rcRecOfTab.IPLIPRES(n) := itbLDC_IPLI_IO(n).IPLIPRES;
			rcRecOfTab.IPLITIOD(n) := itbLDC_IPLI_IO(n).IPLITIOD;
			rcRecOfTab.IPLIMETO(n) := itbLDC_IPLI_IO(n).IPLIMETO;
			rcRecOfTab.IPLIREGU(n) := itbLDC_IPLI_IO(n).IPLIREGU;
			rcRecOfTab.IPLILECT(n) := itbLDC_IPLI_IO(n).IPLILECT;
			rcRecOfTab.ORDER_ID(n) := itbLDC_IPLI_IO(n).ORDER_ID;
			rcRecOfTab.FLAG(n) := itbLDC_IPLI_IO(n).FLAG;
			rcRecOfTab.UNIT_OPER(n) := itbLDC_IPLI_IO(n).UNIT_OPER;
			rcRecOfTab.IPLIFECC(n) := itbLDC_IPLI_IO(n).IPLIFECC;
			rcRecOfTab.IPLIUSUC(n) := itbLDC_IPLI_IO(n).IPLIUSUC;
			rcRecOfTab.row_id(n) := itbLDC_IPLI_IO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuIPLIO_ID
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
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuIPLIO_ID = rcData.IPLIO_ID
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
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuIPLIO_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN		rcError.IPLIO_ID:=inuIPLIO_ID;

		Load
		(
			inuIPLIO_ID
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
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuIPLIO_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		orcRecord out nocopy styLDC_IPLI_IO
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN		rcError.IPLIO_ID:=inuIPLIO_ID;

		Load
		(
			inuIPLIO_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type
	)
	RETURN styLDC_IPLI_IO
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID:=inuIPLIO_ID;

		Load
		(
			inuIPLIO_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type
	)
	RETURN styLDC_IPLI_IO
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID:=inuIPLIO_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuIPLIO_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuIPLIO_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_IPLI_IO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_IPLI_IO
	)
	IS
		rfLDC_IPLI_IO tyrfLDC_IPLI_IO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_IPLI_IO.*, LDC_IPLI_IO.rowid FROM LDC_IPLI_IO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_IPLI_IO for sbFullQuery;

		fetch rfLDC_IPLI_IO bulk collect INTO otbResult;

		close rfLDC_IPLI_IO;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_IPLI_IO.*, LDC_IPLI_IO.rowid FROM LDC_IPLI_IO';
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
		ircLDC_IPLI_IO in styLDC_IPLI_IO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_IPLI_IO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_IPLI_IO in styLDC_IPLI_IO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_IPLI_IO.IPLIO_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|IPLIO_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_IPLI_IO
		(
			IPLIO_ID,
			IPLIMEDE,
			IPLIFECH,
			IPLIHORA,
			IPLIDIRE,
			IPLIBARR,
			IPLIESTA,
			IPLILOCA,
			IPLICONCE,
			IPLIPRES,
			IPLITIOD,
			IPLIMETO,
			IPLIREGU,
			IPLILECT,
			ORDER_ID,
			FLAG,
			UNIT_OPER,
			IPLIFECC,
			IPLIUSUC
		)
		values
		(
			ircLDC_IPLI_IO.IPLIO_ID,
			ircLDC_IPLI_IO.IPLIMEDE,
			ircLDC_IPLI_IO.IPLIFECH,
			ircLDC_IPLI_IO.IPLIHORA,
			ircLDC_IPLI_IO.IPLIDIRE,
			ircLDC_IPLI_IO.IPLIBARR,
			ircLDC_IPLI_IO.IPLIESTA,
			ircLDC_IPLI_IO.IPLILOCA,
			ircLDC_IPLI_IO.IPLICONCE,
			ircLDC_IPLI_IO.IPLIPRES,
			ircLDC_IPLI_IO.IPLITIOD,
			ircLDC_IPLI_IO.IPLIMETO,
			ircLDC_IPLI_IO.IPLIREGU,
			ircLDC_IPLI_IO.IPLILECT,
			ircLDC_IPLI_IO.ORDER_ID,
			ircLDC_IPLI_IO.FLAG,
			ircLDC_IPLI_IO.UNIT_OPER,
			ircLDC_IPLI_IO.IPLIFECC,
			ircLDC_IPLI_IO.IPLIUSUC
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_IPLI_IO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_IPLI_IO in out nocopy tytbLDC_IPLI_IO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_IPLI_IO,blUseRowID);
		forall n in iotbLDC_IPLI_IO.first..iotbLDC_IPLI_IO.last
			insert into LDC_IPLI_IO
			(
				IPLIO_ID,
				IPLIMEDE,
				IPLIFECH,
				IPLIHORA,
				IPLIDIRE,
				IPLIBARR,
				IPLIESTA,
				IPLILOCA,
				IPLICONCE,
				IPLIPRES,
				IPLITIOD,
				IPLIMETO,
				IPLIREGU,
				IPLILECT,
				ORDER_ID,
				FLAG,
				UNIT_OPER,
				IPLIFECC,
				IPLIUSUC
			)
			values
			(
				rcRecOfTab.IPLIO_ID(n),
				rcRecOfTab.IPLIMEDE(n),
				rcRecOfTab.IPLIFECH(n),
				rcRecOfTab.IPLIHORA(n),
				rcRecOfTab.IPLIDIRE(n),
				rcRecOfTab.IPLIBARR(n),
				rcRecOfTab.IPLIESTA(n),
				rcRecOfTab.IPLILOCA(n),
				rcRecOfTab.IPLICONCE(n),
				rcRecOfTab.IPLIPRES(n),
				rcRecOfTab.IPLITIOD(n),
				rcRecOfTab.IPLIMETO(n),
				rcRecOfTab.IPLIREGU(n),
				rcRecOfTab.IPLILECT(n),
				rcRecOfTab.ORDER_ID(n),
				rcRecOfTab.FLAG(n),
				rcRecOfTab.UNIT_OPER(n),
				rcRecOfTab.IPLIFECC(n),
				rcRecOfTab.IPLIUSUC(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;

		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;


		delete
		from LDC_IPLI_IO
		where
       		IPLIO_ID=inuIPLIO_ID;
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
		rcError  styLDC_IPLI_IO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_IPLI_IO
		where
			rowid = iriRowID
		returning
			IPLIO_ID
		into
			rcError.IPLIO_ID;
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
		iotbLDC_IPLI_IO in out nocopy tytbLDC_IPLI_IO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_IPLI_IO;
	BEGIN
		FillRecordOfTables(iotbLDC_IPLI_IO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_IPLI_IO.first .. iotbLDC_IPLI_IO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IPLI_IO.first .. iotbLDC_IPLI_IO.last
				delete
				from LDC_IPLI_IO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_IPLI_IO.first .. iotbLDC_IPLI_IO.last loop
					LockByPk
					(
						rcRecOfTab.IPLIO_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IPLI_IO.first .. iotbLDC_IPLI_IO.last
				delete
				from LDC_IPLI_IO
				where
		         	IPLIO_ID = rcRecOfTab.IPLIO_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_IPLI_IO in styLDC_IPLI_IO,
		inuLock in number default 0
	)
	IS
		nuIPLIO_ID	LDC_IPLI_IO.IPLIO_ID%type;
	BEGIN
		if ircLDC_IPLI_IO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_IPLI_IO.rowid,rcData);
			end if;
			update LDC_IPLI_IO
			set
				IPLIMEDE = ircLDC_IPLI_IO.IPLIMEDE,
				IPLIFECH = ircLDC_IPLI_IO.IPLIFECH,
				IPLIHORA = ircLDC_IPLI_IO.IPLIHORA,
				IPLIDIRE = ircLDC_IPLI_IO.IPLIDIRE,
				IPLIBARR = ircLDC_IPLI_IO.IPLIBARR,
				IPLIESTA = ircLDC_IPLI_IO.IPLIESTA,
				IPLILOCA = ircLDC_IPLI_IO.IPLILOCA,
				IPLICONCE = ircLDC_IPLI_IO.IPLICONCE,
				IPLIPRES = ircLDC_IPLI_IO.IPLIPRES,
				IPLITIOD = ircLDC_IPLI_IO.IPLITIOD,
				IPLIMETO = ircLDC_IPLI_IO.IPLIMETO,
				IPLIREGU = ircLDC_IPLI_IO.IPLIREGU,
				IPLILECT = ircLDC_IPLI_IO.IPLILECT,
				ORDER_ID = ircLDC_IPLI_IO.ORDER_ID,
				FLAG = ircLDC_IPLI_IO.FLAG,
				UNIT_OPER = ircLDC_IPLI_IO.UNIT_OPER,
				IPLIFECC = ircLDC_IPLI_IO.IPLIFECC,
				IPLIUSUC = ircLDC_IPLI_IO.IPLIUSUC
			where
				rowid = ircLDC_IPLI_IO.rowid
			returning
				IPLIO_ID
			into
				nuIPLIO_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_IPLI_IO.IPLIO_ID,
					rcData
				);
			end if;

			update LDC_IPLI_IO
			set
				IPLIMEDE = ircLDC_IPLI_IO.IPLIMEDE,
				IPLIFECH = ircLDC_IPLI_IO.IPLIFECH,
				IPLIHORA = ircLDC_IPLI_IO.IPLIHORA,
				IPLIDIRE = ircLDC_IPLI_IO.IPLIDIRE,
				IPLIBARR = ircLDC_IPLI_IO.IPLIBARR,
				IPLIESTA = ircLDC_IPLI_IO.IPLIESTA,
				IPLILOCA = ircLDC_IPLI_IO.IPLILOCA,
				IPLICONCE = ircLDC_IPLI_IO.IPLICONCE,
				IPLIPRES = ircLDC_IPLI_IO.IPLIPRES,
				IPLITIOD = ircLDC_IPLI_IO.IPLITIOD,
				IPLIMETO = ircLDC_IPLI_IO.IPLIMETO,
				IPLIREGU = ircLDC_IPLI_IO.IPLIREGU,
				IPLILECT = ircLDC_IPLI_IO.IPLILECT,
				ORDER_ID = ircLDC_IPLI_IO.ORDER_ID,
				FLAG = ircLDC_IPLI_IO.FLAG,
				UNIT_OPER = ircLDC_IPLI_IO.UNIT_OPER,
				IPLIFECC = ircLDC_IPLI_IO.IPLIFECC,
				IPLIUSUC = ircLDC_IPLI_IO.IPLIUSUC
			where
				IPLIO_ID = ircLDC_IPLI_IO.IPLIO_ID
			returning
				IPLIO_ID
			into
				nuIPLIO_ID;
		end if;
		if
			nuIPLIO_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_IPLI_IO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_IPLI_IO in out nocopy tytbLDC_IPLI_IO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_IPLI_IO;
	BEGIN
		FillRecordOfTables(iotbLDC_IPLI_IO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_IPLI_IO.first .. iotbLDC_IPLI_IO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IPLI_IO.first .. iotbLDC_IPLI_IO.last
				update LDC_IPLI_IO
				set
					IPLIMEDE = rcRecOfTab.IPLIMEDE(n),
					IPLIFECH = rcRecOfTab.IPLIFECH(n),
					IPLIHORA = rcRecOfTab.IPLIHORA(n),
					IPLIDIRE = rcRecOfTab.IPLIDIRE(n),
					IPLIBARR = rcRecOfTab.IPLIBARR(n),
					IPLIESTA = rcRecOfTab.IPLIESTA(n),
					IPLILOCA = rcRecOfTab.IPLILOCA(n),
					IPLICONCE = rcRecOfTab.IPLICONCE(n),
					IPLIPRES = rcRecOfTab.IPLIPRES(n),
					IPLITIOD = rcRecOfTab.IPLITIOD(n),
					IPLIMETO = rcRecOfTab.IPLIMETO(n),
					IPLIREGU = rcRecOfTab.IPLIREGU(n),
					IPLILECT = rcRecOfTab.IPLILECT(n),
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					FLAG = rcRecOfTab.FLAG(n),
					UNIT_OPER = rcRecOfTab.UNIT_OPER(n),
					IPLIFECC = rcRecOfTab.IPLIFECC(n),
					IPLIUSUC = rcRecOfTab.IPLIUSUC(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_IPLI_IO.first .. iotbLDC_IPLI_IO.last loop
					LockByPk
					(
						rcRecOfTab.IPLIO_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IPLI_IO.first .. iotbLDC_IPLI_IO.last
				update LDC_IPLI_IO
				SET
					IPLIMEDE = rcRecOfTab.IPLIMEDE(n),
					IPLIFECH = rcRecOfTab.IPLIFECH(n),
					IPLIHORA = rcRecOfTab.IPLIHORA(n),
					IPLIDIRE = rcRecOfTab.IPLIDIRE(n),
					IPLIBARR = rcRecOfTab.IPLIBARR(n),
					IPLIESTA = rcRecOfTab.IPLIESTA(n),
					IPLILOCA = rcRecOfTab.IPLILOCA(n),
					IPLICONCE = rcRecOfTab.IPLICONCE(n),
					IPLIPRES = rcRecOfTab.IPLIPRES(n),
					IPLITIOD = rcRecOfTab.IPLITIOD(n),
					IPLIMETO = rcRecOfTab.IPLIMETO(n),
					IPLIREGU = rcRecOfTab.IPLIREGU(n),
					IPLILECT = rcRecOfTab.IPLILECT(n),
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					FLAG = rcRecOfTab.FLAG(n),
					UNIT_OPER = rcRecOfTab.UNIT_OPER(n),
					IPLIFECC = rcRecOfTab.IPLIFECC(n),
					IPLIUSUC = rcRecOfTab.IPLIUSUC(n)
				where
					IPLIO_ID = rcRecOfTab.IPLIO_ID(n)
;
		end if;
	END;
	PROCEDURE updIPLIMEDE
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLIMEDE$ in LDC_IPLI_IO.IPLIMEDE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			IPLIMEDE = isbIPLIMEDE$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IPLIMEDE:= isbIPLIMEDE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIPLIFECH
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		idtIPLIFECH$ in LDC_IPLI_IO.IPLIFECH%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			IPLIFECH = idtIPLIFECH$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IPLIFECH:= idtIPLIFECH$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIPLIHORA
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLIHORA$ in LDC_IPLI_IO.IPLIHORA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			IPLIHORA = isbIPLIHORA$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IPLIHORA:= isbIPLIHORA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIPLIDIRE
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLIDIRE$ in LDC_IPLI_IO.IPLIDIRE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			IPLIDIRE = isbIPLIDIRE$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IPLIDIRE:= isbIPLIDIRE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIPLIBARR
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLIBARR$ in LDC_IPLI_IO.IPLIBARR%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			IPLIBARR = isbIPLIBARR$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IPLIBARR:= isbIPLIBARR$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIPLIESTA
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLIESTA$ in LDC_IPLI_IO.IPLIESTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			IPLIESTA = isbIPLIESTA$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IPLIESTA:= isbIPLIESTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIPLILOCA
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLILOCA$ in LDC_IPLI_IO.IPLILOCA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			IPLILOCA = isbIPLILOCA$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IPLILOCA:= isbIPLILOCA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIPLICONCE
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuIPLICONCE$ in LDC_IPLI_IO.IPLICONCE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			IPLICONCE = inuIPLICONCE$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IPLICONCE:= inuIPLICONCE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIPLIPRES
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuIPLIPRES$ in LDC_IPLI_IO.IPLIPRES%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			IPLIPRES = inuIPLIPRES$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IPLIPRES:= inuIPLIPRES$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIPLITIOD
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLITIOD$ in LDC_IPLI_IO.IPLITIOD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			IPLITIOD = isbIPLITIOD$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IPLITIOD:= isbIPLITIOD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIPLIMETO
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLIMETO$ in LDC_IPLI_IO.IPLIMETO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			IPLIMETO = isbIPLIMETO$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IPLIMETO:= isbIPLIMETO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIPLIREGU
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLIREGU$ in LDC_IPLI_IO.IPLIREGU%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			IPLIREGU = isbIPLIREGU$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IPLIREGU:= isbIPLIREGU$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIPLILECT
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuIPLILECT$ in LDC_IPLI_IO.IPLILECT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			IPLILECT = inuIPLILECT$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IPLILECT:= inuIPLILECT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updORDER_ID
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuORDER_ID$ in LDC_IPLI_IO.ORDER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			ORDER_ID = inuORDER_ID$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ORDER_ID:= inuORDER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFLAG
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbFLAG$ in LDC_IPLI_IO.FLAG%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			FLAG = isbFLAG$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FLAG:= isbFLAG$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUNIT_OPER
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbUNIT_OPER$ in LDC_IPLI_IO.UNIT_OPER%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			UNIT_OPER = isbUNIT_OPER$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.UNIT_OPER:= isbUNIT_OPER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIPLIFECC
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		idtIPLIFECC$ in LDC_IPLI_IO.IPLIFECC%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			IPLIFECC = idtIPLIFECC$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IPLIFECC:= idtIPLIFECC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIPLIUSUC
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		isbIPLIUSUC$ in LDC_IPLI_IO.IPLIUSUC%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IPLI_IO;
	BEGIN
		rcError.IPLIO_ID := inuIPLIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuIPLIO_ID,
				rcData
			);
		end if;

		update LDC_IPLI_IO
		set
			IPLIUSUC = isbIPLIUSUC$
		where
			IPLIO_ID = inuIPLIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IPLIUSUC:= isbIPLIUSUC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetIPLIO_ID
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIO_ID%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.IPLIO_ID);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.IPLIO_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIPLIMEDE
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIMEDE%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.IPLIMEDE);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.IPLIMEDE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetIPLIFECH
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIFECH%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.IPLIFECH);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.IPLIFECH);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIPLIHORA
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIHORA%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.IPLIHORA);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.IPLIHORA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIPLIDIRE
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIDIRE%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.IPLIDIRE);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.IPLIDIRE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIPLIBARR
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIBARR%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.IPLIBARR);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.IPLIBARR);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIPLIESTA
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIESTA%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.IPLIESTA);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.IPLIESTA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIPLILOCA
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLILOCA%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.IPLILOCA);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.IPLILOCA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIPLICONCE
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLICONCE%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.IPLICONCE);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.IPLICONCE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIPLIPRES
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIPRES%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.IPLIPRES);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.IPLIPRES);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIPLITIOD
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLITIOD%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.IPLITIOD);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.IPLITIOD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIPLIMETO
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIMETO%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.IPLIMETO);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.IPLIMETO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIPLIREGU
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIREGU%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.IPLIREGU);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.IPLIREGU);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIPLILECT
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLILECT%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.IPLILECT);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.IPLILECT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetORDER_ID
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.ORDER_ID%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.ORDER_ID);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.ORDER_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetFLAG
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.FLAG%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.FLAG);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.FLAG);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUNIT_OPER
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.UNIT_OPER%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.UNIT_OPER);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.UNIT_OPER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetIPLIFECC
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIFECC%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.IPLIFECC);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.IPLIFECC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIPLIUSUC
	(
		inuIPLIO_ID in LDC_IPLI_IO.IPLIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IPLI_IO.IPLIUSUC%type
	IS
		rcError styLDC_IPLI_IO;
	BEGIN

		rcError.IPLIO_ID := inuIPLIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIPLIO_ID
			 )
		then
			 return(rcData.IPLIUSUC);
		end if;
		Load
		(
		 		inuIPLIO_ID
		);
		return(rcData.IPLIUSUC);
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
end DALDC_IPLI_IO;
/
PROMPT Otorgando permisos de ejecucion a DALDC_IPLI_IO
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_IPLI_IO', 'ADM_PERSON');
END;
/