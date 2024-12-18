CREATE OR REPLACE PACKAGE adm_person.DALDC_RECLAMOS
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_RECLAMOS
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
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type
	)
	IS
		SELECT LDC_RECLAMOS.*,LDC_RECLAMOS.rowid
		FROM LDC_RECLAMOS
		WHERE
		    RECLAMOS_ID = inuRECLAMOS_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_RECLAMOS.*,LDC_RECLAMOS.rowid
		FROM LDC_RECLAMOS
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_RECLAMOS  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_RECLAMOS is table of styLDC_RECLAMOS index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_RECLAMOS;

	/* Tipos referenciando al registro */
	type tytbRECONCEP is table of LDC_RECLAMOS.RECONCEP%type index by binary_integer;
	type tytbREPRODUCT is table of LDC_RECLAMOS.REPRODUCT%type index by binary_integer;
	type tytbRESBSIG is table of LDC_RECLAMOS.RESBSIG%type index by binary_integer;
	type tytbRENUCAUSAL is table of LDC_RECLAMOS.RENUCAUSAL%type index by binary_integer;
	type tytbREDOCSOP is table of LDC_RECLAMOS.REDOCSOP%type index by binary_integer;
	type tytbREESTADO is table of LDC_RECLAMOS.REESTADO%type index by binary_integer;
	type tytbRECODOSOP is table of LDC_RECLAMOS.RECODOSOP%type index by binary_integer;
	type tytbRECAUCAR is table of LDC_RECLAMOS.RECAUCAR%type index by binary_integer;
	type tytbVALORCARGO is table of LDC_RECLAMOS.VALORCARGO%type index by binary_integer;
	type tytbSUBSCRIPTION_ID is table of LDC_RECLAMOS.SUBSCRIPTION_ID%type index by binary_integer;
	type tytbRECLAMOS_ID is table of LDC_RECLAMOS.RECLAMOS_ID%type index by binary_integer;
	type tytbPACKAGE_ID is table of LDC_RECLAMOS.PACKAGE_ID%type index by binary_integer;
	type tytbPACKAGE_ID_RECU is table of LDC_RECLAMOS.PACKAGE_ID_RECU%type index by binary_integer;
	type tytbPACKAGE_ID_RECUSUBS is table of LDC_RECLAMOS.PACKAGE_ID_RECUSUBS%type index by binary_integer;
	type tytbFACTCODI is table of LDC_RECLAMOS.FACTCODI%type index by binary_integer;
	type tytbCUCOCODI is table of LDC_RECLAMOS.CUCOCODI%type index by binary_integer;
	type tytbREMES is table of LDC_RECLAMOS.REMES%type index by binary_integer;
	type tytbREANO is table of LDC_RECLAMOS.REANO%type index by binary_integer;
	type tytbREVALTOTAL is table of LDC_RECLAMOS.REVALTOTAL%type index by binary_integer;
	type tytbREVALABONA is table of LDC_RECLAMOS.REVALABONA%type index by binary_integer;
	type tytbRESALPEN is table of LDC_RECLAMOS.RESALPEN%type index by binary_integer;
	type tytbREVALORECA is table of LDC_RECLAMOS.REVALORECA%type index by binary_integer;
	type tytbDATE_GENCODI is table of LDC_RECLAMOS.DATE_GENCODI%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_RECLAMOS is record
	(
		RECONCEP   tytbRECONCEP,
		REPRODUCT   tytbREPRODUCT,
		RESBSIG   tytbRESBSIG,
		RENUCAUSAL   tytbRENUCAUSAL,
		REDOCSOP   tytbREDOCSOP,
		REESTADO   tytbREESTADO,
		RECODOSOP   tytbRECODOSOP,
		RECAUCAR   tytbRECAUCAR,
		VALORCARGO   tytbVALORCARGO,
		SUBSCRIPTION_ID   tytbSUBSCRIPTION_ID,
		RECLAMOS_ID   tytbRECLAMOS_ID,
		PACKAGE_ID   tytbPACKAGE_ID,
		PACKAGE_ID_RECU   tytbPACKAGE_ID_RECU,
		PACKAGE_ID_RECUSUBS   tytbPACKAGE_ID_RECUSUBS,
		FACTCODI   tytbFACTCODI,
		CUCOCODI   tytbCUCOCODI,
		REMES   tytbREMES,
		REANO   tytbREANO,
		REVALTOTAL   tytbREVALTOTAL,
		REVALABONA   tytbREVALABONA,
		RESALPEN   tytbRESALPEN,
		REVALORECA   tytbREVALORECA,
		DATE_GENCODI   tytbDATE_GENCODI,
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
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type
	);

	PROCEDURE getRecord
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		orcRecord out nocopy styLDC_RECLAMOS
	);

	FUNCTION frcGetRcData
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type
	)
	RETURN styLDC_RECLAMOS;

	FUNCTION frcGetRcData
	RETURN styLDC_RECLAMOS;

	FUNCTION frcGetRecord
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type
	)
	RETURN styLDC_RECLAMOS;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_RECLAMOS
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_RECLAMOS in styLDC_RECLAMOS
	);

	PROCEDURE insRecord
	(
		ircLDC_RECLAMOS in styLDC_RECLAMOS,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_RECLAMOS in out nocopy tytbLDC_RECLAMOS
	);

	PROCEDURE delRecord
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_RECLAMOS in out nocopy tytbLDC_RECLAMOS,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_RECLAMOS in styLDC_RECLAMOS,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_RECLAMOS in out nocopy tytbLDC_RECLAMOS,
		inuLock in number default 1
	);

	PROCEDURE updRECONCEP
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRECONCEP$ in LDC_RECLAMOS.RECONCEP%type,
		inuLock in number default 0
	);

	PROCEDURE updREPRODUCT
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuREPRODUCT$ in LDC_RECLAMOS.REPRODUCT%type,
		inuLock in number default 0
	);

	PROCEDURE updRESBSIG
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		isbRESBSIG$ in LDC_RECLAMOS.RESBSIG%type,
		inuLock in number default 0
	);

	PROCEDURE updRENUCAUSAL
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRENUCAUSAL$ in LDC_RECLAMOS.RENUCAUSAL%type,
		inuLock in number default 0
	);

	PROCEDURE updREDOCSOP
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		isbREDOCSOP$ in LDC_RECLAMOS.REDOCSOP%type,
		inuLock in number default 0
	);

	PROCEDURE updREESTADO
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		isbREESTADO$ in LDC_RECLAMOS.REESTADO%type,
		inuLock in number default 0
	);

	PROCEDURE updRECODOSOP
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRECODOSOP$ in LDC_RECLAMOS.RECODOSOP%type,
		inuLock in number default 0
	);

	PROCEDURE updRECAUCAR
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRECAUCAR$ in LDC_RECLAMOS.RECAUCAR%type,
		inuLock in number default 0
	);

	PROCEDURE updVALORCARGO
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuVALORCARGO$ in LDC_RECLAMOS.VALORCARGO%type,
		inuLock in number default 0
	);

	PROCEDURE updSUBSCRIPTION_ID
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuSUBSCRIPTION_ID$ in LDC_RECLAMOS.SUBSCRIPTION_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPACKAGE_ID
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuPACKAGE_ID$ in LDC_RECLAMOS.PACKAGE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPACKAGE_ID_RECU
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuPACKAGE_ID_RECU$ in LDC_RECLAMOS.PACKAGE_ID_RECU%type,
		inuLock in number default 0
	);

	PROCEDURE updPACKAGE_ID_RECUSUBS
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuPACKAGE_ID_RECUSUBS$ in LDC_RECLAMOS.PACKAGE_ID_RECUSUBS%type,
		inuLock in number default 0
	);

	PROCEDURE updFACTCODI
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuFACTCODI$ in LDC_RECLAMOS.FACTCODI%type,
		inuLock in number default 0
	);

	PROCEDURE updCUCOCODI
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuCUCOCODI$ in LDC_RECLAMOS.CUCOCODI%type,
		inuLock in number default 0
	);

	PROCEDURE updREMES
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuREMES$ in LDC_RECLAMOS.REMES%type,
		inuLock in number default 0
	);

	PROCEDURE updREANO
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuREANO$ in LDC_RECLAMOS.REANO%type,
		inuLock in number default 0
	);

	PROCEDURE updREVALTOTAL
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuREVALTOTAL$ in LDC_RECLAMOS.REVALTOTAL%type,
		inuLock in number default 0
	);

	PROCEDURE updREVALABONA
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuREVALABONA$ in LDC_RECLAMOS.REVALABONA%type,
		inuLock in number default 0
	);

	PROCEDURE updRESALPEN
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRESALPEN$ in LDC_RECLAMOS.RESALPEN%type,
		inuLock in number default 0
	);

	PROCEDURE updREVALORECA
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuREVALORECA$ in LDC_RECLAMOS.REVALORECA%type,
		inuLock in number default 0
	);

	PROCEDURE updDATE_GENCODI
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		idtDATE_GENCODI$ in LDC_RECLAMOS.DATE_GENCODI%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetRECONCEP
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.RECONCEP%type;

	FUNCTION fnuGetREPRODUCT
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.REPRODUCT%type;

	FUNCTION fsbGetRESBSIG
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.RESBSIG%type;

	FUNCTION fnuGetRENUCAUSAL
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.RENUCAUSAL%type;

	FUNCTION fsbGetREDOCSOP
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.REDOCSOP%type;

	FUNCTION fsbGetREESTADO
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.REESTADO%type;

	FUNCTION fnuGetRECODOSOP
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.RECODOSOP%type;

	FUNCTION fnuGetRECAUCAR
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.RECAUCAR%type;

	FUNCTION fnuGetVALORCARGO
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.VALORCARGO%type;

	FUNCTION fnuGetSUBSCRIPTION_ID
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.SUBSCRIPTION_ID%type;

	FUNCTION fnuGetRECLAMOS_ID
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.RECLAMOS_ID%type;

	FUNCTION fnuGetPACKAGE_ID
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.PACKAGE_ID%type;

	FUNCTION fnuGetPACKAGE_ID_RECU
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.PACKAGE_ID_RECU%type;

	FUNCTION fnuGetPACKAGE_ID_RECUSUBS
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.PACKAGE_ID_RECUSUBS%type;

	FUNCTION fnuGetFACTCODI
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.FACTCODI%type;

	FUNCTION fnuGetCUCOCODI
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.CUCOCODI%type;

	FUNCTION fnuGetREMES
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.REMES%type;

	FUNCTION fnuGetREANO
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.REANO%type;

	FUNCTION fnuGetREVALTOTAL
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.REVALTOTAL%type;

	FUNCTION fnuGetREVALABONA
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.REVALABONA%type;

	FUNCTION fnuGetRESALPEN
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.RESALPEN%type;

	FUNCTION fnuGetREVALORECA
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.REVALORECA%type;

	FUNCTION fdtGetDATE_GENCODI
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.DATE_GENCODI%type;


	PROCEDURE LockByPk
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		orcLDC_RECLAMOS  out styLDC_RECLAMOS
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_RECLAMOS  out styLDC_RECLAMOS
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_RECLAMOS;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_RECLAMOS
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_RECLAMOS';
	 cnuGeEntityId constant varchar2(30) := 4431; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type
	)
	IS
		SELECT LDC_RECLAMOS.*,LDC_RECLAMOS.rowid
		FROM LDC_RECLAMOS
		WHERE  RECLAMOS_ID = inuRECLAMOS_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_RECLAMOS.*,LDC_RECLAMOS.rowid
		FROM LDC_RECLAMOS
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_RECLAMOS is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_RECLAMOS;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_RECLAMOS default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.RECLAMOS_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		orcLDC_RECLAMOS  out styLDC_RECLAMOS
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

		Open cuLockRcByPk
		(
			inuRECLAMOS_ID
		);

		fetch cuLockRcByPk into orcLDC_RECLAMOS;
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
		orcLDC_RECLAMOS  out styLDC_RECLAMOS
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_RECLAMOS;
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
		itbLDC_RECLAMOS  in out nocopy tytbLDC_RECLAMOS
	)
	IS
	BEGIN
			rcRecOfTab.RECONCEP.delete;
			rcRecOfTab.REPRODUCT.delete;
			rcRecOfTab.RESBSIG.delete;
			rcRecOfTab.RENUCAUSAL.delete;
			rcRecOfTab.REDOCSOP.delete;
			rcRecOfTab.REESTADO.delete;
			rcRecOfTab.RECODOSOP.delete;
			rcRecOfTab.RECAUCAR.delete;
			rcRecOfTab.VALORCARGO.delete;
			rcRecOfTab.SUBSCRIPTION_ID.delete;
			rcRecOfTab.RECLAMOS_ID.delete;
			rcRecOfTab.PACKAGE_ID.delete;
			rcRecOfTab.PACKAGE_ID_RECU.delete;
			rcRecOfTab.PACKAGE_ID_RECUSUBS.delete;
			rcRecOfTab.FACTCODI.delete;
			rcRecOfTab.CUCOCODI.delete;
			rcRecOfTab.REMES.delete;
			rcRecOfTab.REANO.delete;
			rcRecOfTab.REVALTOTAL.delete;
			rcRecOfTab.REVALABONA.delete;
			rcRecOfTab.RESALPEN.delete;
			rcRecOfTab.REVALORECA.delete;
			rcRecOfTab.DATE_GENCODI.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_RECLAMOS  in out nocopy tytbLDC_RECLAMOS,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_RECLAMOS);

		for n in itbLDC_RECLAMOS.first .. itbLDC_RECLAMOS.last loop
			rcRecOfTab.RECONCEP(n) := itbLDC_RECLAMOS(n).RECONCEP;
			rcRecOfTab.REPRODUCT(n) := itbLDC_RECLAMOS(n).REPRODUCT;
			rcRecOfTab.RESBSIG(n) := itbLDC_RECLAMOS(n).RESBSIG;
			rcRecOfTab.RENUCAUSAL(n) := itbLDC_RECLAMOS(n).RENUCAUSAL;
			rcRecOfTab.REDOCSOP(n) := itbLDC_RECLAMOS(n).REDOCSOP;
			rcRecOfTab.REESTADO(n) := itbLDC_RECLAMOS(n).REESTADO;
			rcRecOfTab.RECODOSOP(n) := itbLDC_RECLAMOS(n).RECODOSOP;
			rcRecOfTab.RECAUCAR(n) := itbLDC_RECLAMOS(n).RECAUCAR;
			rcRecOfTab.VALORCARGO(n) := itbLDC_RECLAMOS(n).VALORCARGO;
			rcRecOfTab.SUBSCRIPTION_ID(n) := itbLDC_RECLAMOS(n).SUBSCRIPTION_ID;
			rcRecOfTab.RECLAMOS_ID(n) := itbLDC_RECLAMOS(n).RECLAMOS_ID;
			rcRecOfTab.PACKAGE_ID(n) := itbLDC_RECLAMOS(n).PACKAGE_ID;
			rcRecOfTab.PACKAGE_ID_RECU(n) := itbLDC_RECLAMOS(n).PACKAGE_ID_RECU;
			rcRecOfTab.PACKAGE_ID_RECUSUBS(n) := itbLDC_RECLAMOS(n).PACKAGE_ID_RECUSUBS;
			rcRecOfTab.FACTCODI(n) := itbLDC_RECLAMOS(n).FACTCODI;
			rcRecOfTab.CUCOCODI(n) := itbLDC_RECLAMOS(n).CUCOCODI;
			rcRecOfTab.REMES(n) := itbLDC_RECLAMOS(n).REMES;
			rcRecOfTab.REANO(n) := itbLDC_RECLAMOS(n).REANO;
			rcRecOfTab.REVALTOTAL(n) := itbLDC_RECLAMOS(n).REVALTOTAL;
			rcRecOfTab.REVALABONA(n) := itbLDC_RECLAMOS(n).REVALABONA;
			rcRecOfTab.RESALPEN(n) := itbLDC_RECLAMOS(n).RESALPEN;
			rcRecOfTab.REVALORECA(n) := itbLDC_RECLAMOS(n).REVALORECA;
			rcRecOfTab.DATE_GENCODI(n) := itbLDC_RECLAMOS(n).DATE_GENCODI;
			rcRecOfTab.row_id(n) := itbLDC_RECLAMOS(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuRECLAMOS_ID
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
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuRECLAMOS_ID = rcData.RECLAMOS_ID
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
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuRECLAMOS_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN		rcError.RECLAMOS_ID:=inuRECLAMOS_ID;

		Load
		(
			inuRECLAMOS_ID
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
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuRECLAMOS_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		orcRecord out nocopy styLDC_RECLAMOS
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN		rcError.RECLAMOS_ID:=inuRECLAMOS_ID;

		Load
		(
			inuRECLAMOS_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type
	)
	RETURN styLDC_RECLAMOS
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID:=inuRECLAMOS_ID;

		Load
		(
			inuRECLAMOS_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type
	)
	RETURN styLDC_RECLAMOS
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID:=inuRECLAMOS_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuRECLAMOS_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuRECLAMOS_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_RECLAMOS
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_RECLAMOS
	)
	IS
		rfLDC_RECLAMOS tyrfLDC_RECLAMOS;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_RECLAMOS.*, LDC_RECLAMOS.rowid FROM LDC_RECLAMOS';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_RECLAMOS for sbFullQuery;

		fetch rfLDC_RECLAMOS bulk collect INTO otbResult;

		close rfLDC_RECLAMOS;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_RECLAMOS.*, LDC_RECLAMOS.rowid FROM LDC_RECLAMOS';
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
		ircLDC_RECLAMOS in styLDC_RECLAMOS
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_RECLAMOS,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_RECLAMOS in styLDC_RECLAMOS,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_RECLAMOS.RECLAMOS_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|RECLAMOS_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_RECLAMOS
		(
			RECONCEP,
			REPRODUCT,
			RESBSIG,
			RENUCAUSAL,
			REDOCSOP,
			REESTADO,
			RECODOSOP,
			RECAUCAR,
			VALORCARGO,
			SUBSCRIPTION_ID,
			RECLAMOS_ID,
			PACKAGE_ID,
			PACKAGE_ID_RECU,
			PACKAGE_ID_RECUSUBS,
			FACTCODI,
			CUCOCODI,
			REMES,
			REANO,
			REVALTOTAL,
			REVALABONA,
			RESALPEN,
			REVALORECA,
			DATE_GENCODI
		)
		values
		(
			ircLDC_RECLAMOS.RECONCEP,
			ircLDC_RECLAMOS.REPRODUCT,
			ircLDC_RECLAMOS.RESBSIG,
			ircLDC_RECLAMOS.RENUCAUSAL,
			ircLDC_RECLAMOS.REDOCSOP,
			ircLDC_RECLAMOS.REESTADO,
			ircLDC_RECLAMOS.RECODOSOP,
			ircLDC_RECLAMOS.RECAUCAR,
			ircLDC_RECLAMOS.VALORCARGO,
			ircLDC_RECLAMOS.SUBSCRIPTION_ID,
			ircLDC_RECLAMOS.RECLAMOS_ID,
			ircLDC_RECLAMOS.PACKAGE_ID,
			ircLDC_RECLAMOS.PACKAGE_ID_RECU,
			ircLDC_RECLAMOS.PACKAGE_ID_RECUSUBS,
			ircLDC_RECLAMOS.FACTCODI,
			ircLDC_RECLAMOS.CUCOCODI,
			ircLDC_RECLAMOS.REMES,
			ircLDC_RECLAMOS.REANO,
			ircLDC_RECLAMOS.REVALTOTAL,
			ircLDC_RECLAMOS.REVALABONA,
			ircLDC_RECLAMOS.RESALPEN,
			ircLDC_RECLAMOS.REVALORECA,
			ircLDC_RECLAMOS.DATE_GENCODI
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_RECLAMOS));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_RECLAMOS in out nocopy tytbLDC_RECLAMOS
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_RECLAMOS,blUseRowID);
		forall n in iotbLDC_RECLAMOS.first..iotbLDC_RECLAMOS.last
			insert into LDC_RECLAMOS
			(
				RECONCEP,
				REPRODUCT,
				RESBSIG,
				RENUCAUSAL,
				REDOCSOP,
				REESTADO,
				RECODOSOP,
				RECAUCAR,
				VALORCARGO,
				SUBSCRIPTION_ID,
				RECLAMOS_ID,
				PACKAGE_ID,
				PACKAGE_ID_RECU,
				PACKAGE_ID_RECUSUBS,
				FACTCODI,
				CUCOCODI,
				REMES,
				REANO,
				REVALTOTAL,
				REVALABONA,
				RESALPEN,
				REVALORECA,
				DATE_GENCODI
			)
			values
			(
				rcRecOfTab.RECONCEP(n),
				rcRecOfTab.REPRODUCT(n),
				rcRecOfTab.RESBSIG(n),
				rcRecOfTab.RENUCAUSAL(n),
				rcRecOfTab.REDOCSOP(n),
				rcRecOfTab.REESTADO(n),
				rcRecOfTab.RECODOSOP(n),
				rcRecOfTab.RECAUCAR(n),
				rcRecOfTab.VALORCARGO(n),
				rcRecOfTab.SUBSCRIPTION_ID(n),
				rcRecOfTab.RECLAMOS_ID(n),
				rcRecOfTab.PACKAGE_ID(n),
				rcRecOfTab.PACKAGE_ID_RECU(n),
				rcRecOfTab.PACKAGE_ID_RECUSUBS(n),
				rcRecOfTab.FACTCODI(n),
				rcRecOfTab.CUCOCODI(n),
				rcRecOfTab.REMES(n),
				rcRecOfTab.REANO(n),
				rcRecOfTab.REVALTOTAL(n),
				rcRecOfTab.REVALABONA(n),
				rcRecOfTab.RESALPEN(n),
				rcRecOfTab.REVALORECA(n),
				rcRecOfTab.DATE_GENCODI(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;


		delete
		from LDC_RECLAMOS
		where
       		RECLAMOS_ID=inuRECLAMOS_ID;
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
		rcError  styLDC_RECLAMOS;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_RECLAMOS
		where
			rowid = iriRowID
		returning
			RECONCEP
		into
			rcError.RECONCEP;
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
		iotbLDC_RECLAMOS in out nocopy tytbLDC_RECLAMOS,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_RECLAMOS;
	BEGIN
		FillRecordOfTables(iotbLDC_RECLAMOS, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_RECLAMOS.first .. iotbLDC_RECLAMOS.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_RECLAMOS.first .. iotbLDC_RECLAMOS.last
				delete
				from LDC_RECLAMOS
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_RECLAMOS.first .. iotbLDC_RECLAMOS.last loop
					LockByPk
					(
						rcRecOfTab.RECLAMOS_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_RECLAMOS.first .. iotbLDC_RECLAMOS.last
				delete
				from LDC_RECLAMOS
				where
		         	RECLAMOS_ID = rcRecOfTab.RECLAMOS_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_RECLAMOS in styLDC_RECLAMOS,
		inuLock in number default 0
	)
	IS
		nuRECLAMOS_ID	LDC_RECLAMOS.RECLAMOS_ID%type;
	BEGIN
		if ircLDC_RECLAMOS.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_RECLAMOS.rowid,rcData);
			end if;
			update LDC_RECLAMOS
			set
				RECONCEP = ircLDC_RECLAMOS.RECONCEP,
				REPRODUCT = ircLDC_RECLAMOS.REPRODUCT,
				RESBSIG = ircLDC_RECLAMOS.RESBSIG,
				RENUCAUSAL = ircLDC_RECLAMOS.RENUCAUSAL,
				REDOCSOP = ircLDC_RECLAMOS.REDOCSOP,
				REESTADO = ircLDC_RECLAMOS.REESTADO,
				RECODOSOP = ircLDC_RECLAMOS.RECODOSOP,
				RECAUCAR = ircLDC_RECLAMOS.RECAUCAR,
				VALORCARGO = ircLDC_RECLAMOS.VALORCARGO,
				SUBSCRIPTION_ID = ircLDC_RECLAMOS.SUBSCRIPTION_ID,
				PACKAGE_ID = ircLDC_RECLAMOS.PACKAGE_ID,
				PACKAGE_ID_RECU = ircLDC_RECLAMOS.PACKAGE_ID_RECU,
				PACKAGE_ID_RECUSUBS = ircLDC_RECLAMOS.PACKAGE_ID_RECUSUBS,
				FACTCODI = ircLDC_RECLAMOS.FACTCODI,
				CUCOCODI = ircLDC_RECLAMOS.CUCOCODI,
				REMES = ircLDC_RECLAMOS.REMES,
				REANO = ircLDC_RECLAMOS.REANO,
				REVALTOTAL = ircLDC_RECLAMOS.REVALTOTAL,
				REVALABONA = ircLDC_RECLAMOS.REVALABONA,
				RESALPEN = ircLDC_RECLAMOS.RESALPEN,
				REVALORECA = ircLDC_RECLAMOS.REVALORECA,
				DATE_GENCODI = ircLDC_RECLAMOS.DATE_GENCODI
			where
				rowid = ircLDC_RECLAMOS.rowid
			returning
				RECLAMOS_ID
			into
				nuRECLAMOS_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_RECLAMOS.RECLAMOS_ID,
					rcData
				);
			end if;

			update LDC_RECLAMOS
			set
				RECONCEP = ircLDC_RECLAMOS.RECONCEP,
				REPRODUCT = ircLDC_RECLAMOS.REPRODUCT,
				RESBSIG = ircLDC_RECLAMOS.RESBSIG,
				RENUCAUSAL = ircLDC_RECLAMOS.RENUCAUSAL,
				REDOCSOP = ircLDC_RECLAMOS.REDOCSOP,
				REESTADO = ircLDC_RECLAMOS.REESTADO,
				RECODOSOP = ircLDC_RECLAMOS.RECODOSOP,
				RECAUCAR = ircLDC_RECLAMOS.RECAUCAR,
				VALORCARGO = ircLDC_RECLAMOS.VALORCARGO,
				SUBSCRIPTION_ID = ircLDC_RECLAMOS.SUBSCRIPTION_ID,
				PACKAGE_ID = ircLDC_RECLAMOS.PACKAGE_ID,
				PACKAGE_ID_RECU = ircLDC_RECLAMOS.PACKAGE_ID_RECU,
				PACKAGE_ID_RECUSUBS = ircLDC_RECLAMOS.PACKAGE_ID_RECUSUBS,
				FACTCODI = ircLDC_RECLAMOS.FACTCODI,
				CUCOCODI = ircLDC_RECLAMOS.CUCOCODI,
				REMES = ircLDC_RECLAMOS.REMES,
				REANO = ircLDC_RECLAMOS.REANO,
				REVALTOTAL = ircLDC_RECLAMOS.REVALTOTAL,
				REVALABONA = ircLDC_RECLAMOS.REVALABONA,
				RESALPEN = ircLDC_RECLAMOS.RESALPEN,
				REVALORECA = ircLDC_RECLAMOS.REVALORECA,
				DATE_GENCODI = ircLDC_RECLAMOS.DATE_GENCODI
			where
				RECLAMOS_ID = ircLDC_RECLAMOS.RECLAMOS_ID
			returning
				RECLAMOS_ID
			into
				nuRECLAMOS_ID;
		end if;
		if
			nuRECLAMOS_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_RECLAMOS));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_RECLAMOS in out nocopy tytbLDC_RECLAMOS,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_RECLAMOS;
	BEGIN
		FillRecordOfTables(iotbLDC_RECLAMOS,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_RECLAMOS.first .. iotbLDC_RECLAMOS.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_RECLAMOS.first .. iotbLDC_RECLAMOS.last
				update LDC_RECLAMOS
				set
					RECONCEP = rcRecOfTab.RECONCEP(n),
					REPRODUCT = rcRecOfTab.REPRODUCT(n),
					RESBSIG = rcRecOfTab.RESBSIG(n),
					RENUCAUSAL = rcRecOfTab.RENUCAUSAL(n),
					REDOCSOP = rcRecOfTab.REDOCSOP(n),
					REESTADO = rcRecOfTab.REESTADO(n),
					RECODOSOP = rcRecOfTab.RECODOSOP(n),
					RECAUCAR = rcRecOfTab.RECAUCAR(n),
					VALORCARGO = rcRecOfTab.VALORCARGO(n),
					SUBSCRIPTION_ID = rcRecOfTab.SUBSCRIPTION_ID(n),
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					PACKAGE_ID_RECU = rcRecOfTab.PACKAGE_ID_RECU(n),
					PACKAGE_ID_RECUSUBS = rcRecOfTab.PACKAGE_ID_RECUSUBS(n),
					FACTCODI = rcRecOfTab.FACTCODI(n),
					CUCOCODI = rcRecOfTab.CUCOCODI(n),
					REMES = rcRecOfTab.REMES(n),
					REANO = rcRecOfTab.REANO(n),
					REVALTOTAL = rcRecOfTab.REVALTOTAL(n),
					REVALABONA = rcRecOfTab.REVALABONA(n),
					RESALPEN = rcRecOfTab.RESALPEN(n),
					REVALORECA = rcRecOfTab.REVALORECA(n),
					DATE_GENCODI = rcRecOfTab.DATE_GENCODI(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_RECLAMOS.first .. iotbLDC_RECLAMOS.last loop
					LockByPk
					(
						rcRecOfTab.RECLAMOS_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_RECLAMOS.first .. iotbLDC_RECLAMOS.last
				update LDC_RECLAMOS
				SET
					RECONCEP = rcRecOfTab.RECONCEP(n),
					REPRODUCT = rcRecOfTab.REPRODUCT(n),
					RESBSIG = rcRecOfTab.RESBSIG(n),
					RENUCAUSAL = rcRecOfTab.RENUCAUSAL(n),
					REDOCSOP = rcRecOfTab.REDOCSOP(n),
					REESTADO = rcRecOfTab.REESTADO(n),
					RECODOSOP = rcRecOfTab.RECODOSOP(n),
					RECAUCAR = rcRecOfTab.RECAUCAR(n),
					VALORCARGO = rcRecOfTab.VALORCARGO(n),
					SUBSCRIPTION_ID = rcRecOfTab.SUBSCRIPTION_ID(n),
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					PACKAGE_ID_RECU = rcRecOfTab.PACKAGE_ID_RECU(n),
					PACKAGE_ID_RECUSUBS = rcRecOfTab.PACKAGE_ID_RECUSUBS(n),
					FACTCODI = rcRecOfTab.FACTCODI(n),
					CUCOCODI = rcRecOfTab.CUCOCODI(n),
					REMES = rcRecOfTab.REMES(n),
					REANO = rcRecOfTab.REANO(n),
					REVALTOTAL = rcRecOfTab.REVALTOTAL(n),
					REVALABONA = rcRecOfTab.REVALABONA(n),
					RESALPEN = rcRecOfTab.RESALPEN(n),
					REVALORECA = rcRecOfTab.REVALORECA(n),
					DATE_GENCODI = rcRecOfTab.DATE_GENCODI(n)
				where
					RECLAMOS_ID = rcRecOfTab.RECLAMOS_ID(n)
;
		end if;
	END;
	PROCEDURE updRECONCEP
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRECONCEP$ in LDC_RECLAMOS.RECONCEP%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			RECONCEP = inuRECONCEP$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RECONCEP:= inuRECONCEP$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREPRODUCT
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuREPRODUCT$ in LDC_RECLAMOS.REPRODUCT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			REPRODUCT = inuREPRODUCT$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REPRODUCT:= inuREPRODUCT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRESBSIG
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		isbRESBSIG$ in LDC_RECLAMOS.RESBSIG%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			RESBSIG = isbRESBSIG$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RESBSIG:= isbRESBSIG$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRENUCAUSAL
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRENUCAUSAL$ in LDC_RECLAMOS.RENUCAUSAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			RENUCAUSAL = inuRENUCAUSAL$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RENUCAUSAL:= inuRENUCAUSAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREDOCSOP
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		isbREDOCSOP$ in LDC_RECLAMOS.REDOCSOP%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			REDOCSOP = isbREDOCSOP$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REDOCSOP:= isbREDOCSOP$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREESTADO
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		isbREESTADO$ in LDC_RECLAMOS.REESTADO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			REESTADO = isbREESTADO$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REESTADO:= isbREESTADO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRECODOSOP
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRECODOSOP$ in LDC_RECLAMOS.RECODOSOP%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			RECODOSOP = inuRECODOSOP$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RECODOSOP:= inuRECODOSOP$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRECAUCAR
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRECAUCAR$ in LDC_RECLAMOS.RECAUCAR%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			RECAUCAR = inuRECAUCAR$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RECAUCAR:= inuRECAUCAR$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALORCARGO
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuVALORCARGO$ in LDC_RECLAMOS.VALORCARGO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			VALORCARGO = inuVALORCARGO$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALORCARGO:= inuVALORCARGO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUBSCRIPTION_ID
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuSUBSCRIPTION_ID$ in LDC_RECLAMOS.SUBSCRIPTION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			SUBSCRIPTION_ID = inuSUBSCRIPTION_ID$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUBSCRIPTION_ID:= inuSUBSCRIPTION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPACKAGE_ID
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuPACKAGE_ID$ in LDC_RECLAMOS.PACKAGE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			PACKAGE_ID = inuPACKAGE_ID$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PACKAGE_ID:= inuPACKAGE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPACKAGE_ID_RECU
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuPACKAGE_ID_RECU$ in LDC_RECLAMOS.PACKAGE_ID_RECU%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			PACKAGE_ID_RECU = inuPACKAGE_ID_RECU$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PACKAGE_ID_RECU:= inuPACKAGE_ID_RECU$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPACKAGE_ID_RECUSUBS
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuPACKAGE_ID_RECUSUBS$ in LDC_RECLAMOS.PACKAGE_ID_RECUSUBS%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			PACKAGE_ID_RECUSUBS = inuPACKAGE_ID_RECUSUBS$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PACKAGE_ID_RECUSUBS:= inuPACKAGE_ID_RECUSUBS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFACTCODI
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuFACTCODI$ in LDC_RECLAMOS.FACTCODI%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			FACTCODI = inuFACTCODI$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FACTCODI:= inuFACTCODI$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCUCOCODI
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuCUCOCODI$ in LDC_RECLAMOS.CUCOCODI%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			CUCOCODI = inuCUCOCODI$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CUCOCODI:= inuCUCOCODI$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREMES
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuREMES$ in LDC_RECLAMOS.REMES%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			REMES = inuREMES$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REMES:= inuREMES$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREANO
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuREANO$ in LDC_RECLAMOS.REANO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			REANO = inuREANO$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REANO:= inuREANO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREVALTOTAL
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuREVALTOTAL$ in LDC_RECLAMOS.REVALTOTAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			REVALTOTAL = inuREVALTOTAL$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REVALTOTAL:= inuREVALTOTAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREVALABONA
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuREVALABONA$ in LDC_RECLAMOS.REVALABONA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			REVALABONA = inuREVALABONA$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REVALABONA:= inuREVALABONA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRESALPEN
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRESALPEN$ in LDC_RECLAMOS.RESALPEN%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			RESALPEN = inuRESALPEN$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RESALPEN:= inuRESALPEN$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREVALORECA
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuREVALORECA$ in LDC_RECLAMOS.REVALORECA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			REVALORECA = inuREVALORECA$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REVALORECA:= inuREVALORECA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDATE_GENCODI
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		idtDATE_GENCODI$ in LDC_RECLAMOS.DATE_GENCODI%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RECLAMOS;
	BEGIN
		rcError.RECLAMOS_ID := inuRECLAMOS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRECLAMOS_ID,
				rcData
			);
		end if;

		update LDC_RECLAMOS
		set
			DATE_GENCODI = idtDATE_GENCODI$
		where
			RECLAMOS_ID = inuRECLAMOS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DATE_GENCODI:= idtDATE_GENCODI$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetRECONCEP
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.RECONCEP%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.RECONCEP);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.RECONCEP);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetREPRODUCT
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.REPRODUCT%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.REPRODUCT);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.REPRODUCT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetRESBSIG
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.RESBSIG%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.RESBSIG);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.RESBSIG);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRENUCAUSAL
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.RENUCAUSAL%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.RENUCAUSAL);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.RENUCAUSAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetREDOCSOP
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.REDOCSOP%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.REDOCSOP);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.REDOCSOP);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetREESTADO
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.REESTADO%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.REESTADO);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.REESTADO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRECODOSOP
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.RECODOSOP%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.RECODOSOP);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.RECODOSOP);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRECAUCAR
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.RECAUCAR%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.RECAUCAR);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.RECAUCAR);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALORCARGO
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.VALORCARGO%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.VALORCARGO);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.VALORCARGO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUBSCRIPTION_ID
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.SUBSCRIPTION_ID%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.SUBSCRIPTION_ID);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.SUBSCRIPTION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRECLAMOS_ID
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.RECLAMOS_ID%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.RECLAMOS_ID);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.RECLAMOS_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPACKAGE_ID
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.PACKAGE_ID%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.PACKAGE_ID);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.PACKAGE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPACKAGE_ID_RECU
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.PACKAGE_ID_RECU%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.PACKAGE_ID_RECU);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.PACKAGE_ID_RECU);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPACKAGE_ID_RECUSUBS
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.PACKAGE_ID_RECUSUBS%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.PACKAGE_ID_RECUSUBS);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.PACKAGE_ID_RECUSUBS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetFACTCODI
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.FACTCODI%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.FACTCODI);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.FACTCODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCUCOCODI
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.CUCOCODI%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.CUCOCODI);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.CUCOCODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetREMES
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.REMES%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.REMES);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.REMES);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetREANO
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.REANO%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.REANO);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.REANO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetREVALTOTAL
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.REVALTOTAL%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.REVALTOTAL);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.REVALTOTAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetREVALABONA
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.REVALABONA%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.REVALABONA);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.REVALABONA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRESALPEN
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.RESALPEN%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.RESALPEN);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.RESALPEN);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetREVALORECA
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.REVALORECA%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.REVALORECA);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.REVALORECA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetDATE_GENCODI
	(
		inuRECLAMOS_ID in LDC_RECLAMOS.RECLAMOS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RECLAMOS.DATE_GENCODI%type
	IS
		rcError styLDC_RECLAMOS;
	BEGIN

		rcError.RECLAMOS_ID := inuRECLAMOS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRECLAMOS_ID
			 )
		then
			 return(rcData.DATE_GENCODI);
		end if;
		Load
		(
		 		inuRECLAMOS_ID
		);
		return(rcData.DATE_GENCODI);
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
end DALDC_RECLAMOS;
/
PROMPT Otorgando permisos de ejecucion a DALDC_RECLAMOS
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_RECLAMOS', 'ADM_PERSON');
END;
/