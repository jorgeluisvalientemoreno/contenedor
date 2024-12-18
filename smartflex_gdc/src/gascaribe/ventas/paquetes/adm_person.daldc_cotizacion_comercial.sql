CREATE OR REPLACE PACKAGE adm_person.DALDC_COTIZACION_COMERCIAL
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
    17/06/2024              PAcosta         OSF-2780: Cambio de esquema ADM_PERSON                              
    ****************************************************************/   
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type
	)
	IS
		SELECT LDC_COTIZACION_COMERCIAL.*,LDC_COTIZACION_COMERCIAL.rowid
		FROM LDC_COTIZACION_COMERCIAL
		WHERE
		    ID_COT_COMERCIAL = inuID_COT_COMERCIAL;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_COTIZACION_COMERCIAL.*,LDC_COTIZACION_COMERCIAL.rowid
		FROM LDC_COTIZACION_COMERCIAL
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_COTIZACION_COMERCIAL  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_COTIZACION_COMERCIAL is table of styLDC_COTIZACION_COMERCIAL index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_COTIZACION_COMERCIAL;

	/* Tipos referenciando al registro */
	type tytbID_COT_COMERCIAL is table of LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type index by binary_integer;
	type tytbESTADO is table of LDC_COTIZACION_COMERCIAL.ESTADO%type index by binary_integer;
	type tytbSOL_COTIZACION is table of LDC_COTIZACION_COMERCIAL.SOL_COTIZACION%type index by binary_integer;
	type tytbSOL_VENTA is table of LDC_COTIZACION_COMERCIAL.SOL_VENTA%type index by binary_integer;
	type tytbCLIENTE is table of LDC_COTIZACION_COMERCIAL.CLIENTE%type index by binary_integer;
	type tytbID_DIRECCION is table of LDC_COTIZACION_COMERCIAL.ID_DIRECCION%type index by binary_integer;
	type tytbVALOR_COTIZADO is table of LDC_COTIZACION_COMERCIAL.VALOR_COTIZADO%type index by binary_integer;
	type tytbDESCUENTO is table of LDC_COTIZACION_COMERCIAL.DESCUENTO%type index by binary_integer;
	type tytbOBSERVACION is table of LDC_COTIZACION_COMERCIAL.OBSERVACION%type index by binary_integer;
	type tytbFECHA_REGISTRO is table of LDC_COTIZACION_COMERCIAL.FECHA_REGISTRO%type index by binary_integer;
	type tytbFECHA_VIGENCIA is table of LDC_COTIZACION_COMERCIAL.FECHA_VIGENCIA%type index by binary_integer;
	type tytbFECHA_MODIFICACION is table of LDC_COTIZACION_COMERCIAL.FECHA_MODIFICACION%type index by binary_integer;
	type tytbUSUARIO_REGISTRA is table of LDC_COTIZACION_COMERCIAL.USUARIO_REGISTRA%type index by binary_integer;
	type tytbUSUARIO_MODIF is table of LDC_COTIZACION_COMERCIAL.USUARIO_MODIF%type index by binary_integer;
	type tytbCOMERCIAL_SECTOR_ID is table of LDC_COTIZACION_COMERCIAL.COMERCIAL_SECTOR_ID%type index by binary_integer;
	type tytbNUMERO_FORMULARIO is table of LDC_COTIZACION_COMERCIAL.NUMERO_FORMULARIO%type index by binary_integer;
	type tytbOPERATING_UNIT_ID is table of LDC_COTIZACION_COMERCIAL.OPERATING_UNIT_ID%type index by binary_integer;
	type tytbPACKAGE_ID is table of LDC_COTIZACION_COMERCIAL.PACKAGE_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_COTIZACION_COMERCIAL is record
	(
		ID_COT_COMERCIAL   tytbID_COT_COMERCIAL,
		ESTADO   tytbESTADO,
		SOL_COTIZACION   tytbSOL_COTIZACION,
		SOL_VENTA   tytbSOL_VENTA,
		CLIENTE   tytbCLIENTE,
		ID_DIRECCION   tytbID_DIRECCION,
		VALOR_COTIZADO   tytbVALOR_COTIZADO,
		DESCUENTO   tytbDESCUENTO,
		OBSERVACION   tytbOBSERVACION,
		FECHA_REGISTRO   tytbFECHA_REGISTRO,
		FECHA_VIGENCIA   tytbFECHA_VIGENCIA,
		FECHA_MODIFICACION   tytbFECHA_MODIFICACION,
		USUARIO_REGISTRA   tytbUSUARIO_REGISTRA,
		USUARIO_MODIF   tytbUSUARIO_MODIF,
    COMERCIAL_SECTOR_ID tytbCOMERCIAL_SECTOR_ID,
    NUMERO_FORMULARIO tytbNUMERO_FORMULARIO,
    OPERATING_UNIT_ID tytbOPERATING_UNIT_ID,
    PACKAGE_ID tytbPACKAGE_ID,
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
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type
	);

	PROCEDURE getRecord
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		orcRecord out nocopy styLDC_COTIZACION_COMERCIAL
	);

	FUNCTION frcGetRcData
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type
	)
	RETURN styLDC_COTIZACION_COMERCIAL;

	FUNCTION frcGetRcData
	RETURN styLDC_COTIZACION_COMERCIAL;

	FUNCTION frcGetRecord
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type
	)
	RETURN styLDC_COTIZACION_COMERCIAL;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_COTIZACION_COMERCIAL
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_COTIZACION_COMERCIAL in styLDC_COTIZACION_COMERCIAL
	);

	PROCEDURE insRecord
	(
		ircLDC_COTIZACION_COMERCIAL in styLDC_COTIZACION_COMERCIAL,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_COTIZACION_COMERCIAL in out nocopy tytbLDC_COTIZACION_COMERCIAL
	);

	PROCEDURE delRecord
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_COTIZACION_COMERCIAL in out nocopy tytbLDC_COTIZACION_COMERCIAL,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_COTIZACION_COMERCIAL in styLDC_COTIZACION_COMERCIAL,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_COTIZACION_COMERCIAL in out nocopy tytbLDC_COTIZACION_COMERCIAL,
		inuLock in number default 1
	);

	PROCEDURE updESTADO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		isbESTADO$ in LDC_COTIZACION_COMERCIAL.ESTADO%type,
		inuLock in number default 0
	);

	PROCEDURE updSOL_COTIZACION
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuSOL_COTIZACION$ in LDC_COTIZACION_COMERCIAL.SOL_COTIZACION%type,
		inuLock in number default 0
	);

	PROCEDURE updSOL_VENTA
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuSOL_VENTA$ in LDC_COTIZACION_COMERCIAL.SOL_VENTA%type,
		inuLock in number default 0
	);

	PROCEDURE updCLIENTE
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuCLIENTE$ in LDC_COTIZACION_COMERCIAL.CLIENTE%type,
		inuLock in number default 0
	);

	PROCEDURE updID_DIRECCION
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuID_DIRECCION$ in LDC_COTIZACION_COMERCIAL.ID_DIRECCION%type,
		inuLock in number default 0
	);

	PROCEDURE updVALOR_COTIZADO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuVALOR_COTIZADO$ in LDC_COTIZACION_COMERCIAL.VALOR_COTIZADO%type,
		inuLock in number default 0
	);

	PROCEDURE updDESCUENTO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuDESCUENTO$ in LDC_COTIZACION_COMERCIAL.DESCUENTO%type,
		inuLock in number default 0
	);

	PROCEDURE updOBSERVACION
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		isbOBSERVACION$ in LDC_COTIZACION_COMERCIAL.OBSERVACION%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_REGISTRO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		idtFECHA_REGISTRO$ in LDC_COTIZACION_COMERCIAL.FECHA_REGISTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_VIGENCIA
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		idtFECHA_VIGENCIA$ in LDC_COTIZACION_COMERCIAL.FECHA_VIGENCIA%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_MODIFICACION
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		idtFECHA_MODIFICACION$ in LDC_COTIZACION_COMERCIAL.FECHA_MODIFICACION%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO_REGISTRA
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		isbUSUARIO_REGISTRA$ in LDC_COTIZACION_COMERCIAL.USUARIO_REGISTRA%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO_MODIF
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		isbUSUARIO_MODIF$ in LDC_COTIZACION_COMERCIAL.USUARIO_MODIF%type,
		inuLock in number default 0
	);

  	PROCEDURE updCOMERCIAL_SECTOR_ID
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		isbCOMERCIAL_SECTOR_ID$ in LDC_COTIZACION_COMERCIAL.COMERCIAL_SECTOR_ID%type,
		inuLock in number default 0
	);

		PROCEDURE updNUMERO_FORMULARIO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		isbNUMERO_FORMULARIO$ in LDC_COTIZACION_COMERCIAL.NUMERO_FORMULARIO%type,
		inuLock in number default 0
	);

		PROCEDURE updOPERATING_UNIT_ID
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		isbOPERATING_UNIT_ID$ in LDC_COTIZACION_COMERCIAL.OPERATING_UNIT_ID%type,
		inuLock in number default 0
	);

		PROCEDURE updPACKAGE_ID
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		isbPACKAGE_ID$ in LDC_COTIZACION_COMERCIAL.PACKAGE_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_COT_COMERCIAL
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type;

	FUNCTION fsbGetESTADO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.ESTADO%type;

	FUNCTION fnuGetSOL_COTIZACION
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.SOL_COTIZACION%type;

	FUNCTION fnuGetSOL_VENTA
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.SOL_VENTA%type;

	FUNCTION fnuGetCLIENTE
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.CLIENTE%type;

	FUNCTION fnuGetID_DIRECCION
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.ID_DIRECCION%type;

	FUNCTION fnuGetVALOR_COTIZADO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.VALOR_COTIZADO%type;

	FUNCTION fnuGetDESCUENTO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.DESCUENTO%type;

	FUNCTION fsbGetOBSERVACION
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.OBSERVACION%type;

	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.FECHA_REGISTRO%type;

	FUNCTION fdtGetFECHA_VIGENCIA
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.FECHA_VIGENCIA%type;

	FUNCTION fdtGetFECHA_MODIFICACION
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.FECHA_MODIFICACION%type;

	FUNCTION fsbGetUSUARIO_REGISTRA
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.USUARIO_REGISTRA%type;

	FUNCTION fsbGetUSUARIO_MODIF
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.USUARIO_MODIF%type;

  FUNCTION fsbGetCOMERCIAL_SECTOR_ID
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.COMERCIAL_SECTOR_ID%type;

	FUNCTION fsbGetNUMERO_FORMULARIO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.NUMERO_FORMULARIO%type;

	FUNCTION fsbGetOPERATING_UNIT_ID
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.OPERATING_UNIT_ID%type;

	FUNCTION fsbGetPACKAGE_ID
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.PACKAGE_ID%type;

	PROCEDURE LockByPk
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		orcLDC_COTIZACION_COMERCIAL  out styLDC_COTIZACION_COMERCIAL
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_COTIZACION_COMERCIAL  out styLDC_COTIZACION_COMERCIAL
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_COTIZACION_COMERCIAL;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_COTIZACION_COMERCIAL
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_COTIZACION_COMERCIAL';
	 cnuGeEntityId constant varchar2(30) := 3855; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type
	)
	IS
		SELECT LDC_COTIZACION_COMERCIAL.*,LDC_COTIZACION_COMERCIAL.rowid
		FROM LDC_COTIZACION_COMERCIAL
		WHERE  ID_COT_COMERCIAL = inuID_COT_COMERCIAL
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_COTIZACION_COMERCIAL.*,LDC_COTIZACION_COMERCIAL.rowid
		FROM LDC_COTIZACION_COMERCIAL
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_COTIZACION_COMERCIAL is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_COTIZACION_COMERCIAL;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_COTIZACION_COMERCIAL default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_COT_COMERCIAL);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		orcLDC_COTIZACION_COMERCIAL  out styLDC_COTIZACION_COMERCIAL
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

		Open cuLockRcByPk
		(
			inuID_COT_COMERCIAL
		);

		fetch cuLockRcByPk into orcLDC_COTIZACION_COMERCIAL;
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
		orcLDC_COTIZACION_COMERCIAL  out styLDC_COTIZACION_COMERCIAL
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_COTIZACION_COMERCIAL;
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
		itbLDC_COTIZACION_COMERCIAL  in out nocopy tytbLDC_COTIZACION_COMERCIAL
	)
	IS
	BEGIN
			rcRecOfTab.ID_COT_COMERCIAL.delete;
			rcRecOfTab.ESTADO.delete;
			rcRecOfTab.SOL_COTIZACION.delete;
			rcRecOfTab.SOL_VENTA.delete;
			rcRecOfTab.CLIENTE.delete;
			rcRecOfTab.ID_DIRECCION.delete;
			rcRecOfTab.VALOR_COTIZADO.delete;
			rcRecOfTab.DESCUENTO.delete;
			rcRecOfTab.OBSERVACION.delete;
			rcRecOfTab.FECHA_REGISTRO.delete;
			rcRecOfTab.FECHA_VIGENCIA.delete;
			rcRecOfTab.FECHA_MODIFICACION.delete;
			rcRecOfTab.USUARIO_REGISTRA.delete;
			rcRecOfTab.USUARIO_MODIF.delete;
      rcRecOfTab.COMERCIAL_SECTOR_ID.delete;
			rcRecOfTab.NUMERO_FORMULARIO.delete;
			rcRecOfTab.OPERATING_UNIT_ID.delete;
			rcRecOfTab.PACKAGE_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_COTIZACION_COMERCIAL  in out nocopy tytbLDC_COTIZACION_COMERCIAL,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_COTIZACION_COMERCIAL);

		for n in itbLDC_COTIZACION_COMERCIAL.first .. itbLDC_COTIZACION_COMERCIAL.last loop
			rcRecOfTab.ID_COT_COMERCIAL(n) := itbLDC_COTIZACION_COMERCIAL(n).ID_COT_COMERCIAL;
			rcRecOfTab.ESTADO(n) := itbLDC_COTIZACION_COMERCIAL(n).ESTADO;
			rcRecOfTab.SOL_COTIZACION(n) := itbLDC_COTIZACION_COMERCIAL(n).SOL_COTIZACION;
			rcRecOfTab.SOL_VENTA(n) := itbLDC_COTIZACION_COMERCIAL(n).SOL_VENTA;
			rcRecOfTab.CLIENTE(n) := itbLDC_COTIZACION_COMERCIAL(n).CLIENTE;
			rcRecOfTab.ID_DIRECCION(n) := itbLDC_COTIZACION_COMERCIAL(n).ID_DIRECCION;
			rcRecOfTab.VALOR_COTIZADO(n) := itbLDC_COTIZACION_COMERCIAL(n).VALOR_COTIZADO;
			rcRecOfTab.DESCUENTO(n) := itbLDC_COTIZACION_COMERCIAL(n).DESCUENTO;
			rcRecOfTab.OBSERVACION(n) := itbLDC_COTIZACION_COMERCIAL(n).OBSERVACION;
			rcRecOfTab.FECHA_REGISTRO(n) := itbLDC_COTIZACION_COMERCIAL(n).FECHA_REGISTRO;
			rcRecOfTab.FECHA_VIGENCIA(n) := itbLDC_COTIZACION_COMERCIAL(n).FECHA_VIGENCIA;
			rcRecOfTab.FECHA_MODIFICACION(n) := itbLDC_COTIZACION_COMERCIAL(n).FECHA_MODIFICACION;
			rcRecOfTab.USUARIO_REGISTRA(n) := itbLDC_COTIZACION_COMERCIAL(n).USUARIO_REGISTRA;
			rcRecOfTab.USUARIO_MODIF(n) := itbLDC_COTIZACION_COMERCIAL(n).USUARIO_MODIF;
      rcRecOfTab.COMERCIAL_SECTOR_ID(n) := itbLDC_COTIZACION_COMERCIAL(n).COMERCIAL_SECTOR_ID;
			rcRecOfTab.NUMERO_FORMULARIO(n) := itbLDC_COTIZACION_COMERCIAL(n).NUMERO_FORMULARIO;
			rcRecOfTab.OPERATING_UNIT_ID(n) := itbLDC_COTIZACION_COMERCIAL(n).OPERATING_UNIT_ID;
			rcRecOfTab.PACKAGE_ID(n) := itbLDC_COTIZACION_COMERCIAL(n).PACKAGE_ID;
			rcRecOfTab.row_id(n) := itbLDC_COTIZACION_COMERCIAL(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_COT_COMERCIAL
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
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_COT_COMERCIAL = rcData.ID_COT_COMERCIAL
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
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_COT_COMERCIAL
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN		rcError.ID_COT_COMERCIAL:=inuID_COT_COMERCIAL;

		Load
		(
			inuID_COT_COMERCIAL
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
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type
	)
	IS
	BEGIN
		Load
		(
			inuID_COT_COMERCIAL
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		orcRecord out nocopy styLDC_COTIZACION_COMERCIAL
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN		rcError.ID_COT_COMERCIAL:=inuID_COT_COMERCIAL;

		Load
		(
			inuID_COT_COMERCIAL
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type
	)
	RETURN styLDC_COTIZACION_COMERCIAL
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL:=inuID_COT_COMERCIAL;

		Load
		(
			inuID_COT_COMERCIAL
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type
	)
	RETURN styLDC_COTIZACION_COMERCIAL
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL:=inuID_COT_COMERCIAL;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_COT_COMERCIAL
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_COT_COMERCIAL
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_COTIZACION_COMERCIAL
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_COTIZACION_COMERCIAL
	)
	IS
		rfLDC_COTIZACION_COMERCIAL tyrfLDC_COTIZACION_COMERCIAL;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_COTIZACION_COMERCIAL.*, LDC_COTIZACION_COMERCIAL.rowid FROM LDC_COTIZACION_COMERCIAL';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_COTIZACION_COMERCIAL for sbFullQuery;

		fetch rfLDC_COTIZACION_COMERCIAL bulk collect INTO otbResult;

		close rfLDC_COTIZACION_COMERCIAL;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_COTIZACION_COMERCIAL.*, LDC_COTIZACION_COMERCIAL.rowid FROM LDC_COTIZACION_COMERCIAL';
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
		ircLDC_COTIZACION_COMERCIAL in styLDC_COTIZACION_COMERCIAL
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_COTIZACION_COMERCIAL,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_COTIZACION_COMERCIAL in styLDC_COTIZACION_COMERCIAL,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_COT_COMERCIAL');
			raise ex.controlled_error;
		end if;

		insert into LDC_COTIZACION_COMERCIAL
		(
			ID_COT_COMERCIAL,
			ESTADO,
			SOL_COTIZACION,
			SOL_VENTA,
			CLIENTE,
			ID_DIRECCION,
			VALOR_COTIZADO,
			DESCUENTO,
			OBSERVACION,
			FECHA_REGISTRO,
			FECHA_VIGENCIA,
			FECHA_MODIFICACION,
			USUARIO_REGISTRA,
			USUARIO_MODIF,
      COMERCIAL_SECTOR_ID,
      NUMERO_FORMULARIO,
      OPERATING_UNIT_ID,
      PACKAGE_ID
		)
		values
		(
			ircLDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL,
			ircLDC_COTIZACION_COMERCIAL.ESTADO,
			ircLDC_COTIZACION_COMERCIAL.SOL_COTIZACION,
			ircLDC_COTIZACION_COMERCIAL.SOL_VENTA,
			ircLDC_COTIZACION_COMERCIAL.CLIENTE,
			ircLDC_COTIZACION_COMERCIAL.ID_DIRECCION,
			ircLDC_COTIZACION_COMERCIAL.VALOR_COTIZADO,
			ircLDC_COTIZACION_COMERCIAL.DESCUENTO,
			ircLDC_COTIZACION_COMERCIAL.OBSERVACION,
			ircLDC_COTIZACION_COMERCIAL.FECHA_REGISTRO,
			ircLDC_COTIZACION_COMERCIAL.FECHA_VIGENCIA,
			ircLDC_COTIZACION_COMERCIAL.FECHA_MODIFICACION,
			ircLDC_COTIZACION_COMERCIAL.USUARIO_REGISTRA,
			ircLDC_COTIZACION_COMERCIAL.USUARIO_MODIF,
      ircLDC_COTIZACION_COMERCIAL.COMERCIAL_SECTOR_ID,
			ircLDC_COTIZACION_COMERCIAL.NUMERO_FORMULARIO,
			ircLDC_COTIZACION_COMERCIAL.OPERATING_UNIT_ID,
			ircLDC_COTIZACION_COMERCIAL.PACKAGE_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_COTIZACION_COMERCIAL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_COTIZACION_COMERCIAL in out nocopy tytbLDC_COTIZACION_COMERCIAL
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_COTIZACION_COMERCIAL,blUseRowID);
		forall n in iotbLDC_COTIZACION_COMERCIAL.first..iotbLDC_COTIZACION_COMERCIAL.last
			insert into LDC_COTIZACION_COMERCIAL
			(
				ID_COT_COMERCIAL,
				ESTADO,
				SOL_COTIZACION,
				SOL_VENTA,
				CLIENTE,
				ID_DIRECCION,
				VALOR_COTIZADO,
				DESCUENTO,
				OBSERVACION,
				FECHA_REGISTRO,
				FECHA_VIGENCIA,
				FECHA_MODIFICACION,
				USUARIO_REGISTRA,
				USUARIO_MODIF,
        COMERCIAL_SECTOR_ID,
        NUMERO_FORMULARIO,
        OPERATING_UNIT_ID,
        PACKAGE_ID
			)
			values
			(
				rcRecOfTab.ID_COT_COMERCIAL(n),
				rcRecOfTab.ESTADO(n),
				rcRecOfTab.SOL_COTIZACION(n),
				rcRecOfTab.SOL_VENTA(n),
				rcRecOfTab.CLIENTE(n),
				rcRecOfTab.ID_DIRECCION(n),
				rcRecOfTab.VALOR_COTIZADO(n),
				rcRecOfTab.DESCUENTO(n),
				rcRecOfTab.OBSERVACION(n),
				rcRecOfTab.FECHA_REGISTRO(n),
				rcRecOfTab.FECHA_VIGENCIA(n),
				rcRecOfTab.FECHA_MODIFICACION(n),
				rcRecOfTab.USUARIO_REGISTRA(n),
				rcRecOfTab.USUARIO_MODIF(n),
        rcRecOfTab.COMERCIAL_SECTOR_ID(n),
				rcRecOfTab.NUMERO_FORMULARIO(n),
				rcRecOfTab.OPERATING_UNIT_ID(n),
				rcRecOfTab.PACKAGE_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;


		delete
		from LDC_COTIZACION_COMERCIAL
		where
       		ID_COT_COMERCIAL=inuID_COT_COMERCIAL;
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
		rcError  styLDC_COTIZACION_COMERCIAL;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_COTIZACION_COMERCIAL
		where
			rowid = iriRowID
		returning
			ID_COT_COMERCIAL
		into
			rcError.ID_COT_COMERCIAL;
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
		iotbLDC_COTIZACION_COMERCIAL in out nocopy tytbLDC_COTIZACION_COMERCIAL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_COTIZACION_COMERCIAL;
	BEGIN
		FillRecordOfTables(iotbLDC_COTIZACION_COMERCIAL, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_COTIZACION_COMERCIAL.first .. iotbLDC_COTIZACION_COMERCIAL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COTIZACION_COMERCIAL.first .. iotbLDC_COTIZACION_COMERCIAL.last
				delete
				from LDC_COTIZACION_COMERCIAL
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_COTIZACION_COMERCIAL.first .. iotbLDC_COTIZACION_COMERCIAL.last loop
					LockByPk
					(
						rcRecOfTab.ID_COT_COMERCIAL(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COTIZACION_COMERCIAL.first .. iotbLDC_COTIZACION_COMERCIAL.last
				delete
				from LDC_COTIZACION_COMERCIAL
				where
		         	ID_COT_COMERCIAL = rcRecOfTab.ID_COT_COMERCIAL(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_COTIZACION_COMERCIAL in styLDC_COTIZACION_COMERCIAL,
		inuLock in number default 0
	)
	IS
		nuID_COT_COMERCIAL	LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type;
	BEGIN
		if ircLDC_COTIZACION_COMERCIAL.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_COTIZACION_COMERCIAL.rowid,rcData);
			end if;
			update LDC_COTIZACION_COMERCIAL
			set
				ESTADO = ircLDC_COTIZACION_COMERCIAL.ESTADO,
				SOL_COTIZACION = ircLDC_COTIZACION_COMERCIAL.SOL_COTIZACION,
				SOL_VENTA = ircLDC_COTIZACION_COMERCIAL.SOL_VENTA,
				CLIENTE = ircLDC_COTIZACION_COMERCIAL.CLIENTE,
				ID_DIRECCION = ircLDC_COTIZACION_COMERCIAL.ID_DIRECCION,
				VALOR_COTIZADO = ircLDC_COTIZACION_COMERCIAL.VALOR_COTIZADO,
				DESCUENTO = ircLDC_COTIZACION_COMERCIAL.DESCUENTO,
				OBSERVACION = ircLDC_COTIZACION_COMERCIAL.OBSERVACION,
				FECHA_REGISTRO = ircLDC_COTIZACION_COMERCIAL.FECHA_REGISTRO,
				FECHA_VIGENCIA = ircLDC_COTIZACION_COMERCIAL.FECHA_VIGENCIA,
				FECHA_MODIFICACION = ircLDC_COTIZACION_COMERCIAL.FECHA_MODIFICACION,
				USUARIO_REGISTRA = ircLDC_COTIZACION_COMERCIAL.USUARIO_REGISTRA,
				USUARIO_MODIF = ircLDC_COTIZACION_COMERCIAL.USUARIO_MODIF,
        COMERCIAL_SECTOR_ID = ircLDC_COTIZACION_COMERCIAL.COMERCIAL_SECTOR_ID,
				NUMERO_FORMULARIO = ircLDC_COTIZACION_COMERCIAL.NUMERO_FORMULARIO,
				OPERATING_UNIT_ID = ircLDC_COTIZACION_COMERCIAL.OPERATING_UNIT_ID,
				PACKAGE_ID = ircLDC_COTIZACION_COMERCIAL.PACKAGE_ID
			where
				rowid = ircLDC_COTIZACION_COMERCIAL.rowid
			returning
				ID_COT_COMERCIAL
			into
				nuID_COT_COMERCIAL;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL,
					rcData
				);
			end if;

			update LDC_COTIZACION_COMERCIAL
			set
				ESTADO = ircLDC_COTIZACION_COMERCIAL.ESTADO,
				SOL_COTIZACION = ircLDC_COTIZACION_COMERCIAL.SOL_COTIZACION,
				SOL_VENTA = ircLDC_COTIZACION_COMERCIAL.SOL_VENTA,
				CLIENTE = ircLDC_COTIZACION_COMERCIAL.CLIENTE,
				ID_DIRECCION = ircLDC_COTIZACION_COMERCIAL.ID_DIRECCION,
				VALOR_COTIZADO = ircLDC_COTIZACION_COMERCIAL.VALOR_COTIZADO,
				DESCUENTO = ircLDC_COTIZACION_COMERCIAL.DESCUENTO,
				OBSERVACION = ircLDC_COTIZACION_COMERCIAL.OBSERVACION,
				FECHA_REGISTRO = ircLDC_COTIZACION_COMERCIAL.FECHA_REGISTRO,
				FECHA_VIGENCIA = ircLDC_COTIZACION_COMERCIAL.FECHA_VIGENCIA,
				FECHA_MODIFICACION = ircLDC_COTIZACION_COMERCIAL.FECHA_MODIFICACION,
				USUARIO_REGISTRA = ircLDC_COTIZACION_COMERCIAL.USUARIO_REGISTRA,
				USUARIO_MODIF = ircLDC_COTIZACION_COMERCIAL.USUARIO_MODIF,
        COMERCIAL_SECTOR_ID = ircLDC_COTIZACION_COMERCIAL.COMERCIAL_SECTOR_ID,
				NUMERO_FORMULARIO = ircLDC_COTIZACION_COMERCIAL.NUMERO_FORMULARIO,
				OPERATING_UNIT_ID = ircLDC_COTIZACION_COMERCIAL.OPERATING_UNIT_ID,
				PACKAGE_ID = ircLDC_COTIZACION_COMERCIAL.PACKAGE_ID
			where
				ID_COT_COMERCIAL = ircLDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL
			returning
				ID_COT_COMERCIAL
			into
				nuID_COT_COMERCIAL;
		end if;
		if
			nuID_COT_COMERCIAL is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_COTIZACION_COMERCIAL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_COTIZACION_COMERCIAL in out nocopy tytbLDC_COTIZACION_COMERCIAL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_COTIZACION_COMERCIAL;
	BEGIN
		FillRecordOfTables(iotbLDC_COTIZACION_COMERCIAL,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_COTIZACION_COMERCIAL.first .. iotbLDC_COTIZACION_COMERCIAL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COTIZACION_COMERCIAL.first .. iotbLDC_COTIZACION_COMERCIAL.last
				update LDC_COTIZACION_COMERCIAL
				set
					ESTADO = rcRecOfTab.ESTADO(n),
					SOL_COTIZACION = rcRecOfTab.SOL_COTIZACION(n),
					SOL_VENTA = rcRecOfTab.SOL_VENTA(n),
					CLIENTE = rcRecOfTab.CLIENTE(n),
					ID_DIRECCION = rcRecOfTab.ID_DIRECCION(n),
					VALOR_COTIZADO = rcRecOfTab.VALOR_COTIZADO(n),
					DESCUENTO = rcRecOfTab.DESCUENTO(n),
					OBSERVACION = rcRecOfTab.OBSERVACION(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					FECHA_VIGENCIA = rcRecOfTab.FECHA_VIGENCIA(n),
					FECHA_MODIFICACION = rcRecOfTab.FECHA_MODIFICACION(n),
					USUARIO_REGISTRA = rcRecOfTab.USUARIO_REGISTRA(n),
					USUARIO_MODIF = rcRecOfTab.USUARIO_MODIF(n),
          COMERCIAL_SECTOR_ID = rcRecOfTab.COMERCIAL_SECTOR_ID(n),
          NUMERO_FORMULARIO = rcRecOfTab.NUMERO_FORMULARIO(n),
          OPERATING_UNIT_ID = rcRecOfTab.OPERATING_UNIT_ID(n),
          PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_COTIZACION_COMERCIAL.first .. iotbLDC_COTIZACION_COMERCIAL.last loop
					LockByPk
					(
						rcRecOfTab.ID_COT_COMERCIAL(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COTIZACION_COMERCIAL.first .. iotbLDC_COTIZACION_COMERCIAL.last
				update LDC_COTIZACION_COMERCIAL
				SET
					ESTADO = rcRecOfTab.ESTADO(n),
					SOL_COTIZACION = rcRecOfTab.SOL_COTIZACION(n),
					SOL_VENTA = rcRecOfTab.SOL_VENTA(n),
					CLIENTE = rcRecOfTab.CLIENTE(n),
					ID_DIRECCION = rcRecOfTab.ID_DIRECCION(n),
					VALOR_COTIZADO = rcRecOfTab.VALOR_COTIZADO(n),
					DESCUENTO = rcRecOfTab.DESCUENTO(n),
					OBSERVACION = rcRecOfTab.OBSERVACION(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					FECHA_VIGENCIA = rcRecOfTab.FECHA_VIGENCIA(n),
					FECHA_MODIFICACION = rcRecOfTab.FECHA_MODIFICACION(n),
					USUARIO_REGISTRA = rcRecOfTab.USUARIO_REGISTRA(n),
					USUARIO_MODIF = rcRecOfTab.USUARIO_MODIF(n),
          COMERCIAL_SECTOR_ID = rcRecOfTab.COMERCIAL_SECTOR_ID(n),
          NUMERO_FORMULARIO = rcRecOfTab.NUMERO_FORMULARIO(n),
          OPERATING_UNIT_ID = rcRecOfTab.OPERATING_UNIT_ID(n),
          PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n)
				where
					ID_COT_COMERCIAL = rcRecOfTab.ID_COT_COMERCIAL(n)
;
		end if;
	END;
	PROCEDURE updESTADO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		isbESTADO$ in LDC_COTIZACION_COMERCIAL.ESTADO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			ESTADO = isbESTADO$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ESTADO:= isbESTADO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSOL_COTIZACION
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuSOL_COTIZACION$ in LDC_COTIZACION_COMERCIAL.SOL_COTIZACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			SOL_COTIZACION = inuSOL_COTIZACION$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SOL_COTIZACION:= inuSOL_COTIZACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSOL_VENTA
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuSOL_VENTA$ in LDC_COTIZACION_COMERCIAL.SOL_VENTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			SOL_VENTA = inuSOL_VENTA$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SOL_VENTA:= inuSOL_VENTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCLIENTE
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuCLIENTE$ in LDC_COTIZACION_COMERCIAL.CLIENTE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			CLIENTE = inuCLIENTE$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CLIENTE:= inuCLIENTE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_DIRECCION
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuID_DIRECCION$ in LDC_COTIZACION_COMERCIAL.ID_DIRECCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			ID_DIRECCION = inuID_DIRECCION$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_DIRECCION:= inuID_DIRECCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALOR_COTIZADO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuVALOR_COTIZADO$ in LDC_COTIZACION_COMERCIAL.VALOR_COTIZADO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			VALOR_COTIZADO = inuVALOR_COTIZADO$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALOR_COTIZADO:= inuVALOR_COTIZADO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESCUENTO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuDESCUENTO$ in LDC_COTIZACION_COMERCIAL.DESCUENTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			DESCUENTO = inuDESCUENTO$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCUENTO:= inuDESCUENTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updOBSERVACION
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		isbOBSERVACION$ in LDC_COTIZACION_COMERCIAL.OBSERVACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			OBSERVACION = isbOBSERVACION$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OBSERVACION:= isbOBSERVACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_REGISTRO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		idtFECHA_REGISTRO$ in LDC_COTIZACION_COMERCIAL.FECHA_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			FECHA_REGISTRO = idtFECHA_REGISTRO$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_REGISTRO:= idtFECHA_REGISTRO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_VIGENCIA
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		idtFECHA_VIGENCIA$ in LDC_COTIZACION_COMERCIAL.FECHA_VIGENCIA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			FECHA_VIGENCIA = idtFECHA_VIGENCIA$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_VIGENCIA:= idtFECHA_VIGENCIA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_MODIFICACION
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		idtFECHA_MODIFICACION$ in LDC_COTIZACION_COMERCIAL.FECHA_MODIFICACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			FECHA_MODIFICACION = idtFECHA_MODIFICACION$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_MODIFICACION:= idtFECHA_MODIFICACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUARIO_REGISTRA
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		isbUSUARIO_REGISTRA$ in LDC_COTIZACION_COMERCIAL.USUARIO_REGISTRA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			USUARIO_REGISTRA = isbUSUARIO_REGISTRA$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUARIO_REGISTRA:= isbUSUARIO_REGISTRA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUARIO_MODIF
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		isbUSUARIO_MODIF$ in LDC_COTIZACION_COMERCIAL.USUARIO_MODIF%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			USUARIO_MODIF = isbUSUARIO_MODIF$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUARIO_MODIF:= isbUSUARIO_MODIF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
  PROCEDURE updCOMERCIAL_SECTOR_ID
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		isbCOMERCIAL_SECTOR_ID$ in LDC_COTIZACION_COMERCIAL.COMERCIAL_SECTOR_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			COMERCIAL_SECTOR_ID = isbCOMERCIAL_SECTOR_ID$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMERCIAL_SECTOR_ID:= isbCOMERCIAL_SECTOR_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNUMERO_FORMULARIO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		isbNUMERO_FORMULARIO$ in LDC_COTIZACION_COMERCIAL.NUMERO_FORMULARIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			NUMERO_FORMULARIO = isbNUMERO_FORMULARIO$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NUMERO_FORMULARIO:= isbNUMERO_FORMULARIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
  	PROCEDURE updOPERATING_UNIT_ID
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		isbOPERATING_UNIT_ID$ in LDC_COTIZACION_COMERCIAL.OPERATING_UNIT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			OPERATING_UNIT_ID = isbOPERATING_UNIT_ID$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OPERATING_UNIT_ID:= isbOPERATING_UNIT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPACKAGE_ID
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		isbPACKAGE_ID$ in LDC_COTIZACION_COMERCIAL.PACKAGE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				rcData
			);
		end if;

		update LDC_COTIZACION_COMERCIAL
		set
			PACKAGE_ID = isbPACKAGE_ID$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PACKAGE_ID:= isbPACKAGE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_COT_COMERCIAL
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.ID_COT_COMERCIAL);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.ID_COT_COMERCIAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetESTADO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.ESTADO%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.ESTADO);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.ESTADO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSOL_COTIZACION
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.SOL_COTIZACION%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.SOL_COTIZACION);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.SOL_COTIZACION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSOL_VENTA
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.SOL_VENTA%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.SOL_VENTA);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.SOL_VENTA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCLIENTE
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.CLIENTE%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.CLIENTE);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.CLIENTE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_DIRECCION
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.ID_DIRECCION%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.ID_DIRECCION);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.ID_DIRECCION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALOR_COTIZADO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.VALOR_COTIZADO%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.VALOR_COTIZADO);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.VALOR_COTIZADO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDESCUENTO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.DESCUENTO%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.DESCUENTO);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.DESCUENTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetOBSERVACION
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.OBSERVACION%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.OBSERVACION);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.OBSERVACION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.FECHA_REGISTRO%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.FECHA_REGISTRO);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.FECHA_REGISTRO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_VIGENCIA
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.FECHA_VIGENCIA%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.FECHA_VIGENCIA);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.FECHA_VIGENCIA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_MODIFICACION
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.FECHA_MODIFICACION%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.FECHA_MODIFICACION);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.FECHA_MODIFICACION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSUARIO_REGISTRA
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.USUARIO_REGISTRA%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.USUARIO_REGISTRA);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.USUARIO_REGISTRA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSUARIO_MODIF
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.USUARIO_MODIF%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.USUARIO_MODIF);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.USUARIO_MODIF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
  FUNCTION fsbGetCOMERCIAL_SECTOR_ID
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.COMERCIAL_SECTOR_ID%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.COMERCIAL_SECTOR_ID);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.COMERCIAL_SECTOR_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetNUMERO_FORMULARIO
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.NUMERO_FORMULARIO%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.NUMERO_FORMULARIO);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.NUMERO_FORMULARIO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetOPERATING_UNIT_ID
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.OPERATING_UNIT_ID%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.OPERATING_UNIT_ID);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
		);
		return(rcData.OPERATING_UNIT_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPACKAGE_ID
	(
		inuID_COT_COMERCIAL in LDC_COTIZACION_COMERCIAL.ID_COT_COMERCIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_COMERCIAL.PACKAGE_ID%type
	IS
		rcError styLDC_COTIZACION_COMERCIAL;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL
			 )
		then
			 return(rcData.PACKAGE_ID);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL
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
	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALDC_COTIZACION_COMERCIAL;
/
PROMPT Otorgando permisos de ejecucion a DALDC_COTIZACION_COMERCIAL
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_COTIZACION_COMERCIAL', 'ADM_PERSON');
END;
/