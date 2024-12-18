CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_SUSP_PERSECUCION
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
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type
	)
	IS
		SELECT LDC_SUSP_PERSECUCION.*,LDC_SUSP_PERSECUCION.rowid
		FROM LDC_SUSP_PERSECUCION
		WHERE
		    SUSP_PERSEC_CODI = inuSUSP_PERSEC_CODI;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_SUSP_PERSECUCION.*,LDC_SUSP_PERSECUCION.rowid
		FROM LDC_SUSP_PERSECUCION
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_SUSP_PERSECUCION  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_SUSP_PERSECUCION is table of styLDC_SUSP_PERSECUCION index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_SUSP_PERSECUCION;

	/* Tipos referenciando al registro */
	type tytbSUSP_PERSEC_CODI is table of LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type index by binary_integer;
	type tytbSUSP_PERSEC_PRODUCTO is table of LDC_SUSP_PERSECUCION.SUSP_PERSEC_PRODUCTO%type index by binary_integer;
	type tytbSUSP_PERSEC_SALPEND is table of LDC_SUSP_PERSECUCION.SUSP_PERSEC_SALPEND%type index by binary_integer;
	type tytbSUSP_PERSEC_CONSUMO is table of LDC_SUSP_PERSECUCION.SUSP_PERSEC_CONSUMO%type index by binary_integer;
	type tytbSUSP_PERSEC_ACTIVID is table of LDC_SUSP_PERSECUCION.SUSP_PERSEC_ACTIVID%type index by binary_integer;
	type tytbSUSP_PERSEC_PERVARI is table of LDC_SUSP_PERSECUCION.SUSP_PERSEC_PERVARI%type index by binary_integer;
	type tytbSUSP_PERSEC_PERSEC is table of LDC_SUSP_PERSECUCION.SUSP_PERSEC_PERSEC%type index by binary_integer;
	type tytbSUSP_PERSEC_FEGEOT is table of LDC_SUSP_PERSECUCION.SUSP_PERSEC_FEGEOT%type index by binary_integer;
	type tytbSUSP_PERSEC_USER_ID is table of LDC_SUSP_PERSECUCION.SUSP_PERSEC_USER_ID%type index by binary_integer;
	type tytbSUSP_PERSEC_FEJPROC is table of LDC_SUSP_PERSECUCION.SUSP_PERSEC_FEJPROC%type index by binary_integer;
	type tytbSUSP_PERSEC_CICLCODI is table of LDC_SUSP_PERSECUCION.SUSP_PERSEC_CICLCODI%type index by binary_integer;
	type tytbSUSP_PERSEC_ORDER_ID is table of LDC_SUSP_PERSECUCION.SUSP_PERSEC_ORDER_ID%type index by binary_integer;
	type tytbSUSP_PERSEC_ACT_ORIG is table of LDC_SUSP_PERSECUCION.SUSP_PERSEC_ACT_ORIG%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_SUSP_PERSECUCION is record
	(
		SUSP_PERSEC_CODI   tytbSUSP_PERSEC_CODI,
		SUSP_PERSEC_PRODUCTO   tytbSUSP_PERSEC_PRODUCTO,
		SUSP_PERSEC_SALPEND   tytbSUSP_PERSEC_SALPEND,
		SUSP_PERSEC_CONSUMO   tytbSUSP_PERSEC_CONSUMO,
		SUSP_PERSEC_ACTIVID   tytbSUSP_PERSEC_ACTIVID,
		SUSP_PERSEC_PERVARI   tytbSUSP_PERSEC_PERVARI,
		SUSP_PERSEC_PERSEC   tytbSUSP_PERSEC_PERSEC,
		SUSP_PERSEC_FEGEOT   tytbSUSP_PERSEC_FEGEOT,
		SUSP_PERSEC_USER_ID   tytbSUSP_PERSEC_USER_ID,
		SUSP_PERSEC_FEJPROC   tytbSUSP_PERSEC_FEJPROC,
		SUSP_PERSEC_CICLCODI   tytbSUSP_PERSEC_CICLCODI,
		SUSP_PERSEC_ORDER_ID   tytbSUSP_PERSEC_ORDER_ID,
		SUSP_PERSEC_ACT_ORIG   tytbSUSP_PERSEC_ACT_ORIG,
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
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type
	);

	PROCEDURE getRecord
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		orcRecord out nocopy styLDC_SUSP_PERSECUCION
	);

	FUNCTION frcGetRcData
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type
	)
	RETURN styLDC_SUSP_PERSECUCION;

	FUNCTION frcGetRcData
	RETURN styLDC_SUSP_PERSECUCION;

	FUNCTION frcGetRecord
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type
	)
	RETURN styLDC_SUSP_PERSECUCION;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_SUSP_PERSECUCION
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_SUSP_PERSECUCION in styLDC_SUSP_PERSECUCION
	);

	PROCEDURE insRecord
	(
		ircLDC_SUSP_PERSECUCION in styLDC_SUSP_PERSECUCION,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_SUSP_PERSECUCION in out nocopy tytbLDC_SUSP_PERSECUCION
	);

	PROCEDURE delRecord
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_SUSP_PERSECUCION in out nocopy tytbLDC_SUSP_PERSECUCION,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_SUSP_PERSECUCION in styLDC_SUSP_PERSECUCION,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_SUSP_PERSECUCION in out nocopy tytbLDC_SUSP_PERSECUCION,
		inuLock in number default 1
	);

	PROCEDURE updSUSP_PERSEC_PRODUCTO
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_PRODUCTO$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_PRODUCTO%type,
		inuLock in number default 0
	);

	PROCEDURE updSUSP_PERSEC_SALPEND
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_SALPEND$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_SALPEND%type,
		inuLock in number default 0
	);

	PROCEDURE updSUSP_PERSEC_CONSUMO
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_CONSUMO$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CONSUMO%type,
		inuLock in number default 0
	);

	PROCEDURE updSUSP_PERSEC_ACTIVID
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_ACTIVID$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_ACTIVID%type,
		inuLock in number default 0
	);

	PROCEDURE updSUSP_PERSEC_PERVARI
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_PERVARI$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_PERVARI%type,
		inuLock in number default 0
	);

	PROCEDURE updSUSP_PERSEC_PERSEC
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		isbSUSP_PERSEC_PERSEC$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_PERSEC%type,
		inuLock in number default 0
	);

	PROCEDURE updSUSP_PERSEC_FEGEOT
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		idtSUSP_PERSEC_FEGEOT$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_FEGEOT%type,
		inuLock in number default 0
	);

	PROCEDURE updSUSP_PERSEC_USER_ID
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_USER_ID$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_USER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updSUSP_PERSEC_FEJPROC
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		idtSUSP_PERSEC_FEJPROC$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_FEJPROC%type,
		inuLock in number default 0
	);

	PROCEDURE updSUSP_PERSEC_CICLCODI
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_CICLCODI$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CICLCODI%type,
		inuLock in number default 0
	);

	PROCEDURE updSUSP_PERSEC_ORDER_ID
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_ORDER_ID$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_ORDER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updSUSP_PERSEC_ACT_ORIG
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_ACT_ORIG$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_ACT_ORIG%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetSUSP_PERSEC_CODI
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type;

	FUNCTION fnuGetSUSP_PERSEC_PRODUCTO
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_PRODUCTO%type;

	FUNCTION fnuGetSUSP_PERSEC_SALPEND
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_SALPEND%type;

	FUNCTION fnuGetSUSP_PERSEC_CONSUMO
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_CONSUMO%type;

	FUNCTION fnuGetSUSP_PERSEC_ACTIVID
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_ACTIVID%type;

	FUNCTION fnuGetSUSP_PERSEC_PERVARI
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_PERVARI%type;

	FUNCTION fsbGetSUSP_PERSEC_PERSEC
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_PERSEC%type;

	FUNCTION fdtGetSUSP_PERSEC_FEGEOT
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_FEGEOT%type;

	FUNCTION fnuGetSUSP_PERSEC_USER_ID
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_USER_ID%type;

	FUNCTION fdtGetSUSP_PERSEC_FEJPROC
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_FEJPROC%type;

	FUNCTION fnuGetSUSP_PERSEC_CICLCODI
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_CICLCODI%type;

	FUNCTION fnuGetSUSP_PERSEC_ORDER_ID
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_ORDER_ID%type;

	FUNCTION fnuGetSUSP_PERSEC_ACT_ORIG
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_ACT_ORIG%type;


	PROCEDURE LockByPk
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		orcLDC_SUSP_PERSECUCION  out styLDC_SUSP_PERSECUCION
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_SUSP_PERSECUCION  out styLDC_SUSP_PERSECUCION
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_SUSP_PERSECUCION;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_SUSP_PERSECUCION
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_SUSP_PERSECUCION';
	 cnuGeEntityId constant varchar2(30) := 8760; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type
	)
	IS
		SELECT LDC_SUSP_PERSECUCION.*,LDC_SUSP_PERSECUCION.rowid
		FROM LDC_SUSP_PERSECUCION
		WHERE  SUSP_PERSEC_CODI = inuSUSP_PERSEC_CODI
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_SUSP_PERSECUCION.*,LDC_SUSP_PERSECUCION.rowid
		FROM LDC_SUSP_PERSECUCION
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_SUSP_PERSECUCION is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_SUSP_PERSECUCION;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_SUSP_PERSECUCION default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.SUSP_PERSEC_CODI);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		orcLDC_SUSP_PERSECUCION  out styLDC_SUSP_PERSECUCION
	)
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN
		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;

		Open cuLockRcByPk
		(
			inuSUSP_PERSEC_CODI
		);

		fetch cuLockRcByPk into orcLDC_SUSP_PERSECUCION;
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
		orcLDC_SUSP_PERSECUCION  out styLDC_SUSP_PERSECUCION
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_SUSP_PERSECUCION;
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
		itbLDC_SUSP_PERSECUCION  in out nocopy tytbLDC_SUSP_PERSECUCION
	)
	IS
	BEGIN
			rcRecOfTab.SUSP_PERSEC_CODI.delete;
			rcRecOfTab.SUSP_PERSEC_PRODUCTO.delete;
			rcRecOfTab.SUSP_PERSEC_SALPEND.delete;
			rcRecOfTab.SUSP_PERSEC_CONSUMO.delete;
			rcRecOfTab.SUSP_PERSEC_ACTIVID.delete;
			rcRecOfTab.SUSP_PERSEC_PERVARI.delete;
			rcRecOfTab.SUSP_PERSEC_PERSEC.delete;
			rcRecOfTab.SUSP_PERSEC_FEGEOT.delete;
			rcRecOfTab.SUSP_PERSEC_USER_ID.delete;
			rcRecOfTab.SUSP_PERSEC_FEJPROC.delete;
			rcRecOfTab.SUSP_PERSEC_CICLCODI.delete;
			rcRecOfTab.SUSP_PERSEC_ORDER_ID.delete;
			rcRecOfTab.SUSP_PERSEC_ACT_ORIG.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_SUSP_PERSECUCION  in out nocopy tytbLDC_SUSP_PERSECUCION,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_SUSP_PERSECUCION);

		for n in itbLDC_SUSP_PERSECUCION.first .. itbLDC_SUSP_PERSECUCION.last loop
			rcRecOfTab.SUSP_PERSEC_CODI(n) := itbLDC_SUSP_PERSECUCION(n).SUSP_PERSEC_CODI;
			rcRecOfTab.SUSP_PERSEC_PRODUCTO(n) := itbLDC_SUSP_PERSECUCION(n).SUSP_PERSEC_PRODUCTO;
			rcRecOfTab.SUSP_PERSEC_SALPEND(n) := itbLDC_SUSP_PERSECUCION(n).SUSP_PERSEC_SALPEND;
			rcRecOfTab.SUSP_PERSEC_CONSUMO(n) := itbLDC_SUSP_PERSECUCION(n).SUSP_PERSEC_CONSUMO;
			rcRecOfTab.SUSP_PERSEC_ACTIVID(n) := itbLDC_SUSP_PERSECUCION(n).SUSP_PERSEC_ACTIVID;
			rcRecOfTab.SUSP_PERSEC_PERVARI(n) := itbLDC_SUSP_PERSECUCION(n).SUSP_PERSEC_PERVARI;
			rcRecOfTab.SUSP_PERSEC_PERSEC(n) := itbLDC_SUSP_PERSECUCION(n).SUSP_PERSEC_PERSEC;
			rcRecOfTab.SUSP_PERSEC_FEGEOT(n) := itbLDC_SUSP_PERSECUCION(n).SUSP_PERSEC_FEGEOT;
			rcRecOfTab.SUSP_PERSEC_USER_ID(n) := itbLDC_SUSP_PERSECUCION(n).SUSP_PERSEC_USER_ID;
			rcRecOfTab.SUSP_PERSEC_FEJPROC(n) := itbLDC_SUSP_PERSECUCION(n).SUSP_PERSEC_FEJPROC;
			rcRecOfTab.SUSP_PERSEC_CICLCODI(n) := itbLDC_SUSP_PERSECUCION(n).SUSP_PERSEC_CICLCODI;
			rcRecOfTab.SUSP_PERSEC_ORDER_ID(n) := itbLDC_SUSP_PERSECUCION(n).SUSP_PERSEC_ORDER_ID;
			rcRecOfTab.SUSP_PERSEC_ACT_ORIG(n) := itbLDC_SUSP_PERSECUCION(n).SUSP_PERSEC_ACT_ORIG;
			rcRecOfTab.row_id(n) := itbLDC_SUSP_PERSECUCION(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuSUSP_PERSEC_CODI
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
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuSUSP_PERSEC_CODI = rcData.SUSP_PERSEC_CODI
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
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuSUSP_PERSEC_CODI
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type
	)
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN		rcError.SUSP_PERSEC_CODI:=inuSUSP_PERSEC_CODI;

		Load
		(
			inuSUSP_PERSEC_CODI
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
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type
	)
	IS
	BEGIN
		Load
		(
			inuSUSP_PERSEC_CODI
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		orcRecord out nocopy styLDC_SUSP_PERSECUCION
	)
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN		rcError.SUSP_PERSEC_CODI:=inuSUSP_PERSEC_CODI;

		Load
		(
			inuSUSP_PERSEC_CODI
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type
	)
	RETURN styLDC_SUSP_PERSECUCION
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN
		rcError.SUSP_PERSEC_CODI:=inuSUSP_PERSEC_CODI;

		Load
		(
			inuSUSP_PERSEC_CODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type
	)
	RETURN styLDC_SUSP_PERSECUCION
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN
		rcError.SUSP_PERSEC_CODI:=inuSUSP_PERSEC_CODI;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuSUSP_PERSEC_CODI
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuSUSP_PERSEC_CODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_SUSP_PERSECUCION
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_SUSP_PERSECUCION
	)
	IS
		rfLDC_SUSP_PERSECUCION tyrfLDC_SUSP_PERSECUCION;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_SUSP_PERSECUCION.*, LDC_SUSP_PERSECUCION.rowid FROM LDC_SUSP_PERSECUCION';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_SUSP_PERSECUCION for sbFullQuery;

		fetch rfLDC_SUSP_PERSECUCION bulk collect INTO otbResult;

		close rfLDC_SUSP_PERSECUCION;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_SUSP_PERSECUCION.*, LDC_SUSP_PERSECUCION.rowid FROM LDC_SUSP_PERSECUCION';
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
		ircLDC_SUSP_PERSECUCION in styLDC_SUSP_PERSECUCION
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_SUSP_PERSECUCION,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_SUSP_PERSECUCION in styLDC_SUSP_PERSECUCION,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|SUSP_PERSEC_CODI');
			raise ex.controlled_error;
		end if;

		insert into LDC_SUSP_PERSECUCION
		(
			SUSP_PERSEC_CODI,
			SUSP_PERSEC_PRODUCTO,
			SUSP_PERSEC_SALPEND,
			SUSP_PERSEC_CONSUMO,
			SUSP_PERSEC_ACTIVID,
			SUSP_PERSEC_PERVARI,
			SUSP_PERSEC_PERSEC,
			SUSP_PERSEC_FEGEOT,
			SUSP_PERSEC_USER_ID,
			SUSP_PERSEC_FEJPROC,
			SUSP_PERSEC_CICLCODI,
			SUSP_PERSEC_ORDER_ID,
			SUSP_PERSEC_ACT_ORIG
		)
		values
		(
			ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI,
			ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_PRODUCTO,
			ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_SALPEND,
			ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_CONSUMO,
			ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_ACTIVID,
			ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_PERVARI,
			ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_PERSEC,
			ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_FEGEOT,
			ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_USER_ID,
			ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_FEJPROC,
			ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_CICLCODI,
			ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_ORDER_ID,
			ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_ACT_ORIG
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_SUSP_PERSECUCION));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_SUSP_PERSECUCION in out nocopy tytbLDC_SUSP_PERSECUCION
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_SUSP_PERSECUCION,blUseRowID);
		forall n in iotbLDC_SUSP_PERSECUCION.first..iotbLDC_SUSP_PERSECUCION.last
			insert into LDC_SUSP_PERSECUCION
			(
				SUSP_PERSEC_CODI,
				SUSP_PERSEC_PRODUCTO,
				SUSP_PERSEC_SALPEND,
				SUSP_PERSEC_CONSUMO,
				SUSP_PERSEC_ACTIVID,
				SUSP_PERSEC_PERVARI,
				SUSP_PERSEC_PERSEC,
				SUSP_PERSEC_FEGEOT,
				SUSP_PERSEC_USER_ID,
				SUSP_PERSEC_FEJPROC,
				SUSP_PERSEC_CICLCODI,
				SUSP_PERSEC_ORDER_ID,
				SUSP_PERSEC_ACT_ORIG
			)
			values
			(
				rcRecOfTab.SUSP_PERSEC_CODI(n),
				rcRecOfTab.SUSP_PERSEC_PRODUCTO(n),
				rcRecOfTab.SUSP_PERSEC_SALPEND(n),
				rcRecOfTab.SUSP_PERSEC_CONSUMO(n),
				rcRecOfTab.SUSP_PERSEC_ACTIVID(n),
				rcRecOfTab.SUSP_PERSEC_PERVARI(n),
				rcRecOfTab.SUSP_PERSEC_PERSEC(n),
				rcRecOfTab.SUSP_PERSEC_FEGEOT(n),
				rcRecOfTab.SUSP_PERSEC_USER_ID(n),
				rcRecOfTab.SUSP_PERSEC_FEJPROC(n),
				rcRecOfTab.SUSP_PERSEC_CICLCODI(n),
				rcRecOfTab.SUSP_PERSEC_ORDER_ID(n),
				rcRecOfTab.SUSP_PERSEC_ACT_ORIG(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN
		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;

		if inuLock=1 then
			LockByPk
			(
				inuSUSP_PERSEC_CODI,
				rcData
			);
		end if;


		delete
		from LDC_SUSP_PERSECUCION
		where
       		SUSP_PERSEC_CODI=inuSUSP_PERSEC_CODI;
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
		rcError  styLDC_SUSP_PERSECUCION;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_SUSP_PERSECUCION
		where
			rowid = iriRowID
		returning
			SUSP_PERSEC_CODI
		into
			rcError.SUSP_PERSEC_CODI;
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
		iotbLDC_SUSP_PERSECUCION in out nocopy tytbLDC_SUSP_PERSECUCION,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_SUSP_PERSECUCION;
	BEGIN
		FillRecordOfTables(iotbLDC_SUSP_PERSECUCION, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_SUSP_PERSECUCION.first .. iotbLDC_SUSP_PERSECUCION.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_SUSP_PERSECUCION.first .. iotbLDC_SUSP_PERSECUCION.last
				delete
				from LDC_SUSP_PERSECUCION
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_SUSP_PERSECUCION.first .. iotbLDC_SUSP_PERSECUCION.last loop
					LockByPk
					(
						rcRecOfTab.SUSP_PERSEC_CODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_SUSP_PERSECUCION.first .. iotbLDC_SUSP_PERSECUCION.last
				delete
				from LDC_SUSP_PERSECUCION
				where
		         	SUSP_PERSEC_CODI = rcRecOfTab.SUSP_PERSEC_CODI(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_SUSP_PERSECUCION in styLDC_SUSP_PERSECUCION,
		inuLock in number default 0
	)
	IS
		nuSUSP_PERSEC_CODI	LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type;
	BEGIN
		if ircLDC_SUSP_PERSECUCION.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_SUSP_PERSECUCION.rowid,rcData);
			end if;
			update LDC_SUSP_PERSECUCION
			set
				SUSP_PERSEC_PRODUCTO = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_PRODUCTO,
				SUSP_PERSEC_SALPEND = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_SALPEND,
				SUSP_PERSEC_CONSUMO = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_CONSUMO,
				SUSP_PERSEC_ACTIVID = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_ACTIVID,
				SUSP_PERSEC_PERVARI = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_PERVARI,
				SUSP_PERSEC_PERSEC = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_PERSEC,
				SUSP_PERSEC_FEGEOT = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_FEGEOT,
				SUSP_PERSEC_USER_ID = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_USER_ID,
				SUSP_PERSEC_FEJPROC = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_FEJPROC,
				SUSP_PERSEC_CICLCODI = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_CICLCODI,
				SUSP_PERSEC_ORDER_ID = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_ORDER_ID,
				SUSP_PERSEC_ACT_ORIG = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_ACT_ORIG
			where
				rowid = ircLDC_SUSP_PERSECUCION.rowid
			returning
				SUSP_PERSEC_CODI
			into
				nuSUSP_PERSEC_CODI;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI,
					rcData
				);
			end if;

			update LDC_SUSP_PERSECUCION
			set
				SUSP_PERSEC_PRODUCTO = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_PRODUCTO,
				SUSP_PERSEC_SALPEND = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_SALPEND,
				SUSP_PERSEC_CONSUMO = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_CONSUMO,
				SUSP_PERSEC_ACTIVID = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_ACTIVID,
				SUSP_PERSEC_PERVARI = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_PERVARI,
				SUSP_PERSEC_PERSEC = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_PERSEC,
				SUSP_PERSEC_FEGEOT = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_FEGEOT,
				SUSP_PERSEC_USER_ID = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_USER_ID,
				SUSP_PERSEC_FEJPROC = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_FEJPROC,
				SUSP_PERSEC_CICLCODI = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_CICLCODI,
				SUSP_PERSEC_ORDER_ID = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_ORDER_ID,
				SUSP_PERSEC_ACT_ORIG = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_ACT_ORIG
			where
				SUSP_PERSEC_CODI = ircLDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI
			returning
				SUSP_PERSEC_CODI
			into
				nuSUSP_PERSEC_CODI;
		end if;
		if
			nuSUSP_PERSEC_CODI is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_SUSP_PERSECUCION));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_SUSP_PERSECUCION in out nocopy tytbLDC_SUSP_PERSECUCION,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_SUSP_PERSECUCION;
	BEGIN
		FillRecordOfTables(iotbLDC_SUSP_PERSECUCION,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_SUSP_PERSECUCION.first .. iotbLDC_SUSP_PERSECUCION.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_SUSP_PERSECUCION.first .. iotbLDC_SUSP_PERSECUCION.last
				update LDC_SUSP_PERSECUCION
				set
					SUSP_PERSEC_PRODUCTO = rcRecOfTab.SUSP_PERSEC_PRODUCTO(n),
					SUSP_PERSEC_SALPEND = rcRecOfTab.SUSP_PERSEC_SALPEND(n),
					SUSP_PERSEC_CONSUMO = rcRecOfTab.SUSP_PERSEC_CONSUMO(n),
					SUSP_PERSEC_ACTIVID = rcRecOfTab.SUSP_PERSEC_ACTIVID(n),
					SUSP_PERSEC_PERVARI = rcRecOfTab.SUSP_PERSEC_PERVARI(n),
					SUSP_PERSEC_PERSEC = rcRecOfTab.SUSP_PERSEC_PERSEC(n),
					SUSP_PERSEC_FEGEOT = rcRecOfTab.SUSP_PERSEC_FEGEOT(n),
					SUSP_PERSEC_USER_ID = rcRecOfTab.SUSP_PERSEC_USER_ID(n),
					SUSP_PERSEC_FEJPROC = rcRecOfTab.SUSP_PERSEC_FEJPROC(n),
					SUSP_PERSEC_CICLCODI = rcRecOfTab.SUSP_PERSEC_CICLCODI(n),
					SUSP_PERSEC_ORDER_ID = rcRecOfTab.SUSP_PERSEC_ORDER_ID(n),
					SUSP_PERSEC_ACT_ORIG = rcRecOfTab.SUSP_PERSEC_ACT_ORIG(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_SUSP_PERSECUCION.first .. iotbLDC_SUSP_PERSECUCION.last loop
					LockByPk
					(
						rcRecOfTab.SUSP_PERSEC_CODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_SUSP_PERSECUCION.first .. iotbLDC_SUSP_PERSECUCION.last
				update LDC_SUSP_PERSECUCION
				SET
					SUSP_PERSEC_PRODUCTO = rcRecOfTab.SUSP_PERSEC_PRODUCTO(n),
					SUSP_PERSEC_SALPEND = rcRecOfTab.SUSP_PERSEC_SALPEND(n),
					SUSP_PERSEC_CONSUMO = rcRecOfTab.SUSP_PERSEC_CONSUMO(n),
					SUSP_PERSEC_ACTIVID = rcRecOfTab.SUSP_PERSEC_ACTIVID(n),
					SUSP_PERSEC_PERVARI = rcRecOfTab.SUSP_PERSEC_PERVARI(n),
					SUSP_PERSEC_PERSEC = rcRecOfTab.SUSP_PERSEC_PERSEC(n),
					SUSP_PERSEC_FEGEOT = rcRecOfTab.SUSP_PERSEC_FEGEOT(n),
					SUSP_PERSEC_USER_ID = rcRecOfTab.SUSP_PERSEC_USER_ID(n),
					SUSP_PERSEC_FEJPROC = rcRecOfTab.SUSP_PERSEC_FEJPROC(n),
					SUSP_PERSEC_CICLCODI = rcRecOfTab.SUSP_PERSEC_CICLCODI(n),
					SUSP_PERSEC_ORDER_ID = rcRecOfTab.SUSP_PERSEC_ORDER_ID(n),
					SUSP_PERSEC_ACT_ORIG = rcRecOfTab.SUSP_PERSEC_ACT_ORIG(n)
				where
					SUSP_PERSEC_CODI = rcRecOfTab.SUSP_PERSEC_CODI(n)
;
		end if;
	END;
	PROCEDURE updSUSP_PERSEC_PRODUCTO
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_PRODUCTO$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_PRODUCTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN
		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;
		if inuLock=1 then
			LockByPk
			(
				inuSUSP_PERSEC_CODI,
				rcData
			);
		end if;

		update LDC_SUSP_PERSECUCION
		set
			SUSP_PERSEC_PRODUCTO = inuSUSP_PERSEC_PRODUCTO$
		where
			SUSP_PERSEC_CODI = inuSUSP_PERSEC_CODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUSP_PERSEC_PRODUCTO:= inuSUSP_PERSEC_PRODUCTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUSP_PERSEC_SALPEND
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_SALPEND$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_SALPEND%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN
		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;
		if inuLock=1 then
			LockByPk
			(
				inuSUSP_PERSEC_CODI,
				rcData
			);
		end if;

		update LDC_SUSP_PERSECUCION
		set
			SUSP_PERSEC_SALPEND = inuSUSP_PERSEC_SALPEND$
		where
			SUSP_PERSEC_CODI = inuSUSP_PERSEC_CODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUSP_PERSEC_SALPEND:= inuSUSP_PERSEC_SALPEND$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUSP_PERSEC_CONSUMO
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_CONSUMO$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CONSUMO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN
		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;
		if inuLock=1 then
			LockByPk
			(
				inuSUSP_PERSEC_CODI,
				rcData
			);
		end if;

		update LDC_SUSP_PERSECUCION
		set
			SUSP_PERSEC_CONSUMO = inuSUSP_PERSEC_CONSUMO$
		where
			SUSP_PERSEC_CODI = inuSUSP_PERSEC_CODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUSP_PERSEC_CONSUMO:= inuSUSP_PERSEC_CONSUMO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUSP_PERSEC_ACTIVID
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_ACTIVID$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_ACTIVID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN
		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;
		if inuLock=1 then
			LockByPk
			(
				inuSUSP_PERSEC_CODI,
				rcData
			);
		end if;

		update LDC_SUSP_PERSECUCION
		set
			SUSP_PERSEC_ACTIVID = inuSUSP_PERSEC_ACTIVID$
		where
			SUSP_PERSEC_CODI = inuSUSP_PERSEC_CODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUSP_PERSEC_ACTIVID:= inuSUSP_PERSEC_ACTIVID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUSP_PERSEC_PERVARI
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_PERVARI$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_PERVARI%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN
		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;
		if inuLock=1 then
			LockByPk
			(
				inuSUSP_PERSEC_CODI,
				rcData
			);
		end if;

		update LDC_SUSP_PERSECUCION
		set
			SUSP_PERSEC_PERVARI = inuSUSP_PERSEC_PERVARI$
		where
			SUSP_PERSEC_CODI = inuSUSP_PERSEC_CODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUSP_PERSEC_PERVARI:= inuSUSP_PERSEC_PERVARI$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUSP_PERSEC_PERSEC
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		isbSUSP_PERSEC_PERSEC$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_PERSEC%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN
		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;
		if inuLock=1 then
			LockByPk
			(
				inuSUSP_PERSEC_CODI,
				rcData
			);
		end if;

		update LDC_SUSP_PERSECUCION
		set
			SUSP_PERSEC_PERSEC = isbSUSP_PERSEC_PERSEC$
		where
			SUSP_PERSEC_CODI = inuSUSP_PERSEC_CODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUSP_PERSEC_PERSEC:= isbSUSP_PERSEC_PERSEC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUSP_PERSEC_FEGEOT
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		idtSUSP_PERSEC_FEGEOT$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_FEGEOT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN
		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;
		if inuLock=1 then
			LockByPk
			(
				inuSUSP_PERSEC_CODI,
				rcData
			);
		end if;

		update LDC_SUSP_PERSECUCION
		set
			SUSP_PERSEC_FEGEOT = idtSUSP_PERSEC_FEGEOT$
		where
			SUSP_PERSEC_CODI = inuSUSP_PERSEC_CODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUSP_PERSEC_FEGEOT:= idtSUSP_PERSEC_FEGEOT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUSP_PERSEC_USER_ID
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_USER_ID$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_USER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN
		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;
		if inuLock=1 then
			LockByPk
			(
				inuSUSP_PERSEC_CODI,
				rcData
			);
		end if;

		update LDC_SUSP_PERSECUCION
		set
			SUSP_PERSEC_USER_ID = inuSUSP_PERSEC_USER_ID$
		where
			SUSP_PERSEC_CODI = inuSUSP_PERSEC_CODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUSP_PERSEC_USER_ID:= inuSUSP_PERSEC_USER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUSP_PERSEC_FEJPROC
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		idtSUSP_PERSEC_FEJPROC$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_FEJPROC%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN
		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;
		if inuLock=1 then
			LockByPk
			(
				inuSUSP_PERSEC_CODI,
				rcData
			);
		end if;

		update LDC_SUSP_PERSECUCION
		set
			SUSP_PERSEC_FEJPROC = idtSUSP_PERSEC_FEJPROC$
		where
			SUSP_PERSEC_CODI = inuSUSP_PERSEC_CODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUSP_PERSEC_FEJPROC:= idtSUSP_PERSEC_FEJPROC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUSP_PERSEC_CICLCODI
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_CICLCODI$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CICLCODI%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN
		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;
		if inuLock=1 then
			LockByPk
			(
				inuSUSP_PERSEC_CODI,
				rcData
			);
		end if;

		update LDC_SUSP_PERSECUCION
		set
			SUSP_PERSEC_CICLCODI = inuSUSP_PERSEC_CICLCODI$
		where
			SUSP_PERSEC_CODI = inuSUSP_PERSEC_CODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUSP_PERSEC_CICLCODI:= inuSUSP_PERSEC_CICLCODI$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUSP_PERSEC_ORDER_ID
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_ORDER_ID$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_ORDER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN
		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;
		if inuLock=1 then
			LockByPk
			(
				inuSUSP_PERSEC_CODI,
				rcData
			);
		end if;

		update LDC_SUSP_PERSECUCION
		set
			SUSP_PERSEC_ORDER_ID = inuSUSP_PERSEC_ORDER_ID$
		where
			SUSP_PERSEC_CODI = inuSUSP_PERSEC_CODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUSP_PERSEC_ORDER_ID:= inuSUSP_PERSEC_ORDER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUSP_PERSEC_ACT_ORIG
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuSUSP_PERSEC_ACT_ORIG$ in LDC_SUSP_PERSECUCION.SUSP_PERSEC_ACT_ORIG%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN
		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;
		if inuLock=1 then
			LockByPk
			(
				inuSUSP_PERSEC_CODI,
				rcData
			);
		end if;

		update LDC_SUSP_PERSECUCION
		set
			SUSP_PERSEC_ACT_ORIG = inuSUSP_PERSEC_ACT_ORIG$
		where
			SUSP_PERSEC_CODI = inuSUSP_PERSEC_CODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUSP_PERSEC_ACT_ORIG:= inuSUSP_PERSEC_ACT_ORIG$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetSUSP_PERSEC_CODI
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN

		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUSP_PERSEC_CODI
			 )
		then
			 return(rcData.SUSP_PERSEC_CODI);
		end if;
		Load
		(
		 		inuSUSP_PERSEC_CODI
		);
		return(rcData.SUSP_PERSEC_CODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUSP_PERSEC_PRODUCTO
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_PRODUCTO%type
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN

		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUSP_PERSEC_CODI
			 )
		then
			 return(rcData.SUSP_PERSEC_PRODUCTO);
		end if;
		Load
		(
		 		inuSUSP_PERSEC_CODI
		);
		return(rcData.SUSP_PERSEC_PRODUCTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUSP_PERSEC_SALPEND
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_SALPEND%type
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN

		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUSP_PERSEC_CODI
			 )
		then
			 return(rcData.SUSP_PERSEC_SALPEND);
		end if;
		Load
		(
		 		inuSUSP_PERSEC_CODI
		);
		return(rcData.SUSP_PERSEC_SALPEND);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUSP_PERSEC_CONSUMO
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_CONSUMO%type
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN

		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUSP_PERSEC_CODI
			 )
		then
			 return(rcData.SUSP_PERSEC_CONSUMO);
		end if;
		Load
		(
		 		inuSUSP_PERSEC_CODI
		);
		return(rcData.SUSP_PERSEC_CONSUMO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUSP_PERSEC_ACTIVID
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_ACTIVID%type
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN

		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUSP_PERSEC_CODI
			 )
		then
			 return(rcData.SUSP_PERSEC_ACTIVID);
		end if;
		Load
		(
		 		inuSUSP_PERSEC_CODI
		);
		return(rcData.SUSP_PERSEC_ACTIVID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUSP_PERSEC_PERVARI
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_PERVARI%type
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN

		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUSP_PERSEC_CODI
			 )
		then
			 return(rcData.SUSP_PERSEC_PERVARI);
		end if;
		Load
		(
		 		inuSUSP_PERSEC_CODI
		);
		return(rcData.SUSP_PERSEC_PERVARI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSUSP_PERSEC_PERSEC
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_PERSEC%type
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN

		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUSP_PERSEC_CODI
			 )
		then
			 return(rcData.SUSP_PERSEC_PERSEC);
		end if;
		Load
		(
		 		inuSUSP_PERSEC_CODI
		);
		return(rcData.SUSP_PERSEC_PERSEC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetSUSP_PERSEC_FEGEOT
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_FEGEOT%type
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN

		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUSP_PERSEC_CODI
			 )
		then
			 return(rcData.SUSP_PERSEC_FEGEOT);
		end if;
		Load
		(
		 		inuSUSP_PERSEC_CODI
		);
		return(rcData.SUSP_PERSEC_FEGEOT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUSP_PERSEC_USER_ID
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_USER_ID%type
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN

		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUSP_PERSEC_CODI
			 )
		then
			 return(rcData.SUSP_PERSEC_USER_ID);
		end if;
		Load
		(
		 		inuSUSP_PERSEC_CODI
		);
		return(rcData.SUSP_PERSEC_USER_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetSUSP_PERSEC_FEJPROC
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_FEJPROC%type
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN

		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUSP_PERSEC_CODI
			 )
		then
			 return(rcData.SUSP_PERSEC_FEJPROC);
		end if;
		Load
		(
		 		inuSUSP_PERSEC_CODI
		);
		return(rcData.SUSP_PERSEC_FEJPROC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUSP_PERSEC_CICLCODI
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_CICLCODI%type
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN

		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUSP_PERSEC_CODI
			 )
		then
			 return(rcData.SUSP_PERSEC_CICLCODI);
		end if;
		Load
		(
		 		inuSUSP_PERSEC_CODI
		);
		return(rcData.SUSP_PERSEC_CICLCODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUSP_PERSEC_ORDER_ID
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_ORDER_ID%type
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN

		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUSP_PERSEC_CODI
			 )
		then
			 return(rcData.SUSP_PERSEC_ORDER_ID);
		end if;
		Load
		(
		 		inuSUSP_PERSEC_CODI
		);
		return(rcData.SUSP_PERSEC_ORDER_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUSP_PERSEC_ACT_ORIG
	(
		inuSUSP_PERSEC_CODI in LDC_SUSP_PERSECUCION.SUSP_PERSEC_CODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SUSP_PERSECUCION.SUSP_PERSEC_ACT_ORIG%type
	IS
		rcError styLDC_SUSP_PERSECUCION;
	BEGIN

		rcError.SUSP_PERSEC_CODI := inuSUSP_PERSEC_CODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSUSP_PERSEC_CODI
			 )
		then
			 return(rcData.SUSP_PERSEC_ACT_ORIG);
		end if;
		Load
		(
		 		inuSUSP_PERSEC_CODI
		);
		return(rcData.SUSP_PERSEC_ACT_ORIG);
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
end DALDC_SUSP_PERSECUCION;
/
PROMPT Otorgando permisos de ejecucion a DALDC_SUSP_PERSECUCION
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_SUSP_PERSECUCION', 'ADM_PERSON');
END;
/