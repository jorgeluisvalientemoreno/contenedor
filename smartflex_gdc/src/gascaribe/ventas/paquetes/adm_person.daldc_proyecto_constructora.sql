CREATE OR REPLACE PACKAGE adm_person.DALDC_PROYECTO_CONSTRUCTORA
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
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type
	)
	IS
		SELECT LDC_PROYECTO_CONSTRUCTORA.*,LDC_PROYECTO_CONSTRUCTORA.rowid
		FROM LDC_PROYECTO_CONSTRUCTORA
		WHERE
		    ID_PROYECTO = inuID_PROYECTO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_PROYECTO_CONSTRUCTORA.*,LDC_PROYECTO_CONSTRUCTORA.rowid
		FROM LDC_PROYECTO_CONSTRUCTORA
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_PROYECTO_CONSTRUCTORA  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_PROYECTO_CONSTRUCTORA is table of styLDC_PROYECTO_CONSTRUCTORA index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_PROYECTO_CONSTRUCTORA;

	/* Tipos referenciando al registro */
	type tytbTIPO_VIVIENDA is table of LDC_PROYECTO_CONSTRUCTORA.TIPO_VIVIENDA%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type index by binary_integer;
	type tytbNOMBRE is table of LDC_PROYECTO_CONSTRUCTORA.NOMBRE%type index by binary_integer;
	type tytbDESCRIPCION is table of LDC_PROYECTO_CONSTRUCTORA.DESCRIPCION%type index by binary_integer;
	type tytbCLIENTE is table of LDC_PROYECTO_CONSTRUCTORA.CLIENTE%type index by binary_integer;
	type tytbFORMA_PAGO is table of LDC_PROYECTO_CONSTRUCTORA.FORMA_PAGO%type index by binary_integer;
	type tytbCORREO_REC_CUOTA is table of LDC_PROYECTO_CONSTRUCTORA.CORREO_REC_CUOTA%type index by binary_integer;
	type tytbCORREO_REC_CHEQUES is table of LDC_PROYECTO_CONSTRUCTORA.CORREO_REC_CHEQUES%type index by binary_integer;
	type tytbFECHA_CREACION is table of LDC_PROYECTO_CONSTRUCTORA.FECHA_CREACION%type index by binary_integer;
	type tytbFECH_ULT_MODIF is table of LDC_PROYECTO_CONSTRUCTORA.FECH_ULT_MODIF%type index by binary_integer;
	type tytbTIPO_CONSTRUCCION is table of LDC_PROYECTO_CONSTRUCTORA.TIPO_CONSTRUCCION%type index by binary_integer;
	type tytbCANTIDAD_PISOS is table of LDC_PROYECTO_CONSTRUCTORA.CANTIDAD_PISOS%type index by binary_integer;
	type tytbCANTIDAD_TORRES is table of LDC_PROYECTO_CONSTRUCTORA.CANTIDAD_TORRES%type index by binary_integer;
	type tytbCANT_UNID_PREDIAL is table of LDC_PROYECTO_CONSTRUCTORA.CANT_UNID_PREDIAL%type index by binary_integer;
	type tytbCANT_TIP_UNID_PRED is table of LDC_PROYECTO_CONSTRUCTORA.CANT_TIP_UNID_PRED%type index by binary_integer;
	type tytbVALOR_FINAL_APROB is table of LDC_PROYECTO_CONSTRUCTORA.VALOR_FINAL_APROB%type index by binary_integer;
	type tytbID_DIRECCION is table of LDC_PROYECTO_CONSTRUCTORA.ID_DIRECCION%type index by binary_integer;
	type tytbID_LOCALIDAD is table of LDC_PROYECTO_CONSTRUCTORA.ID_LOCALIDAD%type index by binary_integer;
	type tytbUSUARIO_ULT_MODIF is table of LDC_PROYECTO_CONSTRUCTORA.USUARIO_ULT_MODIF%type index by binary_integer;
	type tytbPAGARE is table of LDC_PROYECTO_CONSTRUCTORA.PAGARE%type index by binary_integer;
	type tytbCONTRATO is table of LDC_PROYECTO_CONSTRUCTORA.CONTRATO%type index by binary_integer;
	type tytbUSU_CREACION is table of LDC_PROYECTO_CONSTRUCTORA.USU_CREACION%type index by binary_integer;
	type tytbID_PROYECTO_ORIGEN is table of LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO_ORIGEN%type index by binary_integer;
	type tytbSUSCRIPCION is table of LDC_PROYECTO_CONSTRUCTORA.SUSCRIPCION%type index by binary_integer;
	type tytbPORC_CUOT_INI is table of LDC_PROYECTO_CONSTRUCTORA.PORC_CUOT_INI%type index by binary_integer;
	type tytbID_SOLICITUD is table of LDC_PROYECTO_CONSTRUCTORA.ID_SOLICITUD%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_PROYECTO_CONSTRUCTORA is record
	(
		TIPO_VIVIENDA   tytbTIPO_VIVIENDA,
		ID_PROYECTO   tytbID_PROYECTO,
		NOMBRE   tytbNOMBRE,
		DESCRIPCION   tytbDESCRIPCION,
		CLIENTE   tytbCLIENTE,
		FORMA_PAGO   tytbFORMA_PAGO,
		CORREO_REC_CUOTA   tytbCORREO_REC_CUOTA,
		CORREO_REC_CHEQUES   tytbCORREO_REC_CHEQUES,
		FECHA_CREACION   tytbFECHA_CREACION,
		FECH_ULT_MODIF   tytbFECH_ULT_MODIF,
		TIPO_CONSTRUCCION   tytbTIPO_CONSTRUCCION,
		CANTIDAD_PISOS   tytbCANTIDAD_PISOS,
		CANTIDAD_TORRES   tytbCANTIDAD_TORRES,
		CANT_UNID_PREDIAL   tytbCANT_UNID_PREDIAL,
		CANT_TIP_UNID_PRED   tytbCANT_TIP_UNID_PRED,
		VALOR_FINAL_APROB   tytbVALOR_FINAL_APROB,
		ID_DIRECCION   tytbID_DIRECCION,
		ID_LOCALIDAD   tytbID_LOCALIDAD,
		USUARIO_ULT_MODIF   tytbUSUARIO_ULT_MODIF,
		PAGARE   tytbPAGARE,
		CONTRATO   tytbCONTRATO,
		USU_CREACION   tytbUSU_CREACION,
		ID_PROYECTO_ORIGEN   tytbID_PROYECTO_ORIGEN,
		SUSCRIPCION   tytbSUSCRIPCION,
		PORC_CUOT_INI   tytbPORC_CUOT_INI,
		ID_SOLICITUD   tytbID_SOLICITUD,
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
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type
	);

	PROCEDURE getRecord
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		orcRecord out nocopy styLDC_PROYECTO_CONSTRUCTORA
	);

	FUNCTION frcGetRcData
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type
	)
	RETURN styLDC_PROYECTO_CONSTRUCTORA;

	FUNCTION frcGetRcData
	RETURN styLDC_PROYECTO_CONSTRUCTORA;

	FUNCTION frcGetRecord
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type
	)
	RETURN styLDC_PROYECTO_CONSTRUCTORA;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PROYECTO_CONSTRUCTORA
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_PROYECTO_CONSTRUCTORA in styLDC_PROYECTO_CONSTRUCTORA
	);

	PROCEDURE insRecord
	(
		ircLDC_PROYECTO_CONSTRUCTORA in styLDC_PROYECTO_CONSTRUCTORA,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_PROYECTO_CONSTRUCTORA in out nocopy tytbLDC_PROYECTO_CONSTRUCTORA
	);

	PROCEDURE delRecord
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_PROYECTO_CONSTRUCTORA in out nocopy tytbLDC_PROYECTO_CONSTRUCTORA,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_PROYECTO_CONSTRUCTORA in styLDC_PROYECTO_CONSTRUCTORA,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_PROYECTO_CONSTRUCTORA in out nocopy tytbLDC_PROYECTO_CONSTRUCTORA,
		inuLock in number default 1
	);

	PROCEDURE updTIPO_VIVIENDA
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuTIPO_VIVIENDA$ in LDC_PROYECTO_CONSTRUCTORA.TIPO_VIVIENDA%type,
		inuLock in number default 0
	);

	PROCEDURE updNOMBRE
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbNOMBRE$ in LDC_PROYECTO_CONSTRUCTORA.NOMBRE%type,
		inuLock in number default 0
	);

	PROCEDURE updDESCRIPCION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbDESCRIPCION$ in LDC_PROYECTO_CONSTRUCTORA.DESCRIPCION%type,
		inuLock in number default 0
	);

	PROCEDURE updCLIENTE
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuCLIENTE$ in LDC_PROYECTO_CONSTRUCTORA.CLIENTE%type,
		inuLock in number default 0
	);

	PROCEDURE updFORMA_PAGO
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbFORMA_PAGO$ in LDC_PROYECTO_CONSTRUCTORA.FORMA_PAGO%type,
		inuLock in number default 0
	);

	PROCEDURE updCORREO_REC_CUOTA
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbCORREO_REC_CUOTA$ in LDC_PROYECTO_CONSTRUCTORA.CORREO_REC_CUOTA%type,
		inuLock in number default 0
	);

	PROCEDURE updCORREO_REC_CHEQUES
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbCORREO_REC_CHEQUES$ in LDC_PROYECTO_CONSTRUCTORA.CORREO_REC_CHEQUES%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_CREACION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		idtFECHA_CREACION$ in LDC_PROYECTO_CONSTRUCTORA.FECHA_CREACION%type,
		inuLock in number default 0
	);

	PROCEDURE updFECH_ULT_MODIF
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		idtFECH_ULT_MODIF$ in LDC_PROYECTO_CONSTRUCTORA.FECH_ULT_MODIF%type,
		inuLock in number default 0
	);

	PROCEDURE updTIPO_CONSTRUCCION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuTIPO_CONSTRUCCION$ in LDC_PROYECTO_CONSTRUCTORA.TIPO_CONSTRUCCION%type,
		inuLock in number default 0
	);

	PROCEDURE updCANTIDAD_PISOS
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuCANTIDAD_PISOS$ in LDC_PROYECTO_CONSTRUCTORA.CANTIDAD_PISOS%type,
		inuLock in number default 0
	);

	PROCEDURE updCANTIDAD_TORRES
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuCANTIDAD_TORRES$ in LDC_PROYECTO_CONSTRUCTORA.CANTIDAD_TORRES%type,
		inuLock in number default 0
	);

	PROCEDURE updCANT_UNID_PREDIAL
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuCANT_UNID_PREDIAL$ in LDC_PROYECTO_CONSTRUCTORA.CANT_UNID_PREDIAL%type,
		inuLock in number default 0
	);

	PROCEDURE updCANT_TIP_UNID_PRED
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuCANT_TIP_UNID_PRED$ in LDC_PROYECTO_CONSTRUCTORA.CANT_TIP_UNID_PRED%type,
		inuLock in number default 0
	);

	PROCEDURE updVALOR_FINAL_APROB
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuVALOR_FINAL_APROB$ in LDC_PROYECTO_CONSTRUCTORA.VALOR_FINAL_APROB%type,
		inuLock in number default 0
	);

	PROCEDURE updID_DIRECCION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuID_DIRECCION$ in LDC_PROYECTO_CONSTRUCTORA.ID_DIRECCION%type,
		inuLock in number default 0
	);

	PROCEDURE updID_LOCALIDAD
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuID_LOCALIDAD$ in LDC_PROYECTO_CONSTRUCTORA.ID_LOCALIDAD%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO_ULT_MODIF
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbUSUARIO_ULT_MODIF$ in LDC_PROYECTO_CONSTRUCTORA.USUARIO_ULT_MODIF%type,
		inuLock in number default 0
	);

	PROCEDURE updPAGARE
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbPAGARE$ in LDC_PROYECTO_CONSTRUCTORA.PAGARE%type,
		inuLock in number default 0
	);

	PROCEDURE updCONTRATO
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbCONTRATO$ in LDC_PROYECTO_CONSTRUCTORA.CONTRATO%type,
		inuLock in number default 0
	);

	PROCEDURE updUSU_CREACION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbUSU_CREACION$ in LDC_PROYECTO_CONSTRUCTORA.USU_CREACION%type,
		inuLock in number default 0
	);

	PROCEDURE updID_PROYECTO_ORIGEN
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuID_PROYECTO_ORIGEN$ in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO_ORIGEN%type,
		inuLock in number default 0
	);

	PROCEDURE updSUSCRIPCION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuSUSCRIPCION$ in LDC_PROYECTO_CONSTRUCTORA.SUSCRIPCION%type,
		inuLock in number default 0
	);

	PROCEDURE updPORC_CUOT_INI
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuPORC_CUOT_INI$ in LDC_PROYECTO_CONSTRUCTORA.PORC_CUOT_INI%type,
		inuLock in number default 0
	);

	PROCEDURE updID_SOLICITUD
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuID_SOLICITUD$ in LDC_PROYECTO_CONSTRUCTORA.ID_SOLICITUD%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetTIPO_VIVIENDA
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.TIPO_VIVIENDA%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type;

	FUNCTION fsbGetNOMBRE
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.NOMBRE%type;

	FUNCTION fsbGetDESCRIPCION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.DESCRIPCION%type;

	FUNCTION fnuGetCLIENTE
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.CLIENTE%type;

	FUNCTION fsbGetFORMA_PAGO
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.FORMA_PAGO%type;

	FUNCTION fsbGetCORREO_REC_CUOTA
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.CORREO_REC_CUOTA%type;

	FUNCTION fsbGetCORREO_REC_CHEQUES
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.CORREO_REC_CHEQUES%type;

	FUNCTION fdtGetFECHA_CREACION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.FECHA_CREACION%type;

	FUNCTION fdtGetFECH_ULT_MODIF
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.FECH_ULT_MODIF%type;

	FUNCTION fnuGetTIPO_CONSTRUCCION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.TIPO_CONSTRUCCION%type;

	FUNCTION fnuGetCANTIDAD_PISOS
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.CANTIDAD_PISOS%type;

	FUNCTION fnuGetCANTIDAD_TORRES
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.CANTIDAD_TORRES%type;

	FUNCTION fnuGetCANT_UNID_PREDIAL
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.CANT_UNID_PREDIAL%type;

	FUNCTION fnuGetCANT_TIP_UNID_PRED
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.CANT_TIP_UNID_PRED%type;

	FUNCTION fnuGetVALOR_FINAL_APROB
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.VALOR_FINAL_APROB%type;

	FUNCTION fnuGetID_DIRECCION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.ID_DIRECCION%type;

	FUNCTION fnuGetID_LOCALIDAD
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.ID_LOCALIDAD%type;

	FUNCTION fsbGetUSUARIO_ULT_MODIF
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.USUARIO_ULT_MODIF%type;

	FUNCTION fsbGetPAGARE
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.PAGARE%type;

	FUNCTION fsbGetCONTRATO
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.CONTRATO%type;

	FUNCTION fsbGetUSU_CREACION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.USU_CREACION%type;

	FUNCTION fnuGetID_PROYECTO_ORIGEN
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO_ORIGEN%type;

	FUNCTION fnuGetSUSCRIPCION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.SUSCRIPCION%type;

	FUNCTION fnuGetPORC_CUOT_INI
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.PORC_CUOT_INI%type;

	FUNCTION fnuGetID_SOLICITUD
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.ID_SOLICITUD%type;


	PROCEDURE LockByPk
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		orcLDC_PROYECTO_CONSTRUCTORA  out styLDC_PROYECTO_CONSTRUCTORA
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_PROYECTO_CONSTRUCTORA  out styLDC_PROYECTO_CONSTRUCTORA
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_PROYECTO_CONSTRUCTORA;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_PROYECTO_CONSTRUCTORA
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_PROYECTO_CONSTRUCTORA';
	 cnuGeEntityId constant varchar2(30) := 2857; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type
	)
	IS
		SELECT LDC_PROYECTO_CONSTRUCTORA.*,LDC_PROYECTO_CONSTRUCTORA.rowid
		FROM LDC_PROYECTO_CONSTRUCTORA
		WHERE  ID_PROYECTO = inuID_PROYECTO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_PROYECTO_CONSTRUCTORA.*,LDC_PROYECTO_CONSTRUCTORA.rowid
		FROM LDC_PROYECTO_CONSTRUCTORA
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_PROYECTO_CONSTRUCTORA is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_PROYECTO_CONSTRUCTORA;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_PROYECTO_CONSTRUCTORA default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_PROYECTO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		orcLDC_PROYECTO_CONSTRUCTORA  out styLDC_PROYECTO_CONSTRUCTORA
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;

		Open cuLockRcByPk
		(
			inuID_PROYECTO
		);

		fetch cuLockRcByPk into orcLDC_PROYECTO_CONSTRUCTORA;
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
		orcLDC_PROYECTO_CONSTRUCTORA  out styLDC_PROYECTO_CONSTRUCTORA
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_PROYECTO_CONSTRUCTORA;
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
		itbLDC_PROYECTO_CONSTRUCTORA  in out nocopy tytbLDC_PROYECTO_CONSTRUCTORA
	)
	IS
	BEGIN
			rcRecOfTab.TIPO_VIVIENDA.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.NOMBRE.delete;
			rcRecOfTab.DESCRIPCION.delete;
			rcRecOfTab.CLIENTE.delete;
			rcRecOfTab.FORMA_PAGO.delete;
			rcRecOfTab.CORREO_REC_CUOTA.delete;
			rcRecOfTab.CORREO_REC_CHEQUES.delete;
			rcRecOfTab.FECHA_CREACION.delete;
			rcRecOfTab.FECH_ULT_MODIF.delete;
			rcRecOfTab.TIPO_CONSTRUCCION.delete;
			rcRecOfTab.CANTIDAD_PISOS.delete;
			rcRecOfTab.CANTIDAD_TORRES.delete;
			rcRecOfTab.CANT_UNID_PREDIAL.delete;
			rcRecOfTab.CANT_TIP_UNID_PRED.delete;
			rcRecOfTab.VALOR_FINAL_APROB.delete;
			rcRecOfTab.ID_DIRECCION.delete;
			rcRecOfTab.ID_LOCALIDAD.delete;
			rcRecOfTab.USUARIO_ULT_MODIF.delete;
			rcRecOfTab.PAGARE.delete;
			rcRecOfTab.CONTRATO.delete;
			rcRecOfTab.USU_CREACION.delete;
			rcRecOfTab.ID_PROYECTO_ORIGEN.delete;
			rcRecOfTab.SUSCRIPCION.delete;
			rcRecOfTab.PORC_CUOT_INI.delete;
			rcRecOfTab.ID_SOLICITUD.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_PROYECTO_CONSTRUCTORA  in out nocopy tytbLDC_PROYECTO_CONSTRUCTORA,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_PROYECTO_CONSTRUCTORA);

		for n in itbLDC_PROYECTO_CONSTRUCTORA.first .. itbLDC_PROYECTO_CONSTRUCTORA.last loop
			rcRecOfTab.TIPO_VIVIENDA(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).TIPO_VIVIENDA;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).ID_PROYECTO;
			rcRecOfTab.NOMBRE(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).NOMBRE;
			rcRecOfTab.DESCRIPCION(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).DESCRIPCION;
			rcRecOfTab.CLIENTE(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).CLIENTE;
			rcRecOfTab.FORMA_PAGO(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).FORMA_PAGO;
			rcRecOfTab.CORREO_REC_CUOTA(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).CORREO_REC_CUOTA;
			rcRecOfTab.CORREO_REC_CHEQUES(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).CORREO_REC_CHEQUES;
			rcRecOfTab.FECHA_CREACION(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).FECHA_CREACION;
			rcRecOfTab.FECH_ULT_MODIF(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).FECH_ULT_MODIF;
			rcRecOfTab.TIPO_CONSTRUCCION(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).TIPO_CONSTRUCCION;
			rcRecOfTab.CANTIDAD_PISOS(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).CANTIDAD_PISOS;
			rcRecOfTab.CANTIDAD_TORRES(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).CANTIDAD_TORRES;
			rcRecOfTab.CANT_UNID_PREDIAL(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).CANT_UNID_PREDIAL;
			rcRecOfTab.CANT_TIP_UNID_PRED(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).CANT_TIP_UNID_PRED;
			rcRecOfTab.VALOR_FINAL_APROB(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).VALOR_FINAL_APROB;
			rcRecOfTab.ID_DIRECCION(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).ID_DIRECCION;
			rcRecOfTab.ID_LOCALIDAD(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).ID_LOCALIDAD;
			rcRecOfTab.USUARIO_ULT_MODIF(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).USUARIO_ULT_MODIF;
			rcRecOfTab.PAGARE(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).PAGARE;
			rcRecOfTab.CONTRATO(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).CONTRATO;
			rcRecOfTab.USU_CREACION(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).USU_CREACION;
			rcRecOfTab.ID_PROYECTO_ORIGEN(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).ID_PROYECTO_ORIGEN;
			rcRecOfTab.SUSCRIPCION(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).SUSCRIPCION;
			rcRecOfTab.PORC_CUOT_INI(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).PORC_CUOT_INI;
			rcRecOfTab.ID_SOLICITUD(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).ID_SOLICITUD;
			rcRecOfTab.row_id(n) := itbLDC_PROYECTO_CONSTRUCTORA(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_PROYECTO
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
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_PROYECTO = rcData.ID_PROYECTO
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
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_PROYECTO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_PROYECTO
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
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type
	)
	IS
	BEGIN
		Load
		(
			inuID_PROYECTO
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		orcRecord out nocopy styLDC_PROYECTO_CONSTRUCTORA
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_PROYECTO
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type
	)
	RETURN styLDC_PROYECTO_CONSTRUCTORA
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_PROYECTO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type
	)
	RETURN styLDC_PROYECTO_CONSTRUCTORA
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO:=inuID_PROYECTO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_PROYECTO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_PROYECTO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_PROYECTO_CONSTRUCTORA
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PROYECTO_CONSTRUCTORA
	)
	IS
		rfLDC_PROYECTO_CONSTRUCTORA tyrfLDC_PROYECTO_CONSTRUCTORA;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_PROYECTO_CONSTRUCTORA.*, LDC_PROYECTO_CONSTRUCTORA.rowid FROM LDC_PROYECTO_CONSTRUCTORA';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_PROYECTO_CONSTRUCTORA for sbFullQuery;

		fetch rfLDC_PROYECTO_CONSTRUCTORA bulk collect INTO otbResult;

		close rfLDC_PROYECTO_CONSTRUCTORA;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_PROYECTO_CONSTRUCTORA.*, LDC_PROYECTO_CONSTRUCTORA.rowid FROM LDC_PROYECTO_CONSTRUCTORA';
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
		ircLDC_PROYECTO_CONSTRUCTORA in styLDC_PROYECTO_CONSTRUCTORA
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_PROYECTO_CONSTRUCTORA,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_PROYECTO_CONSTRUCTORA in styLDC_PROYECTO_CONSTRUCTORA,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PROYECTO');
			raise ex.controlled_error;
		end if;

		insert into LDC_PROYECTO_CONSTRUCTORA
		(
			TIPO_VIVIENDA,
			ID_PROYECTO,
			NOMBRE,
			DESCRIPCION,
			CLIENTE,
			FORMA_PAGO,
			CORREO_REC_CUOTA,
			CORREO_REC_CHEQUES,
			FECHA_CREACION,
			FECH_ULT_MODIF,
			TIPO_CONSTRUCCION,
			CANTIDAD_PISOS,
			CANTIDAD_TORRES,
			CANT_UNID_PREDIAL,
			CANT_TIP_UNID_PRED,
			VALOR_FINAL_APROB,
			ID_DIRECCION,
			ID_LOCALIDAD,
			USUARIO_ULT_MODIF,
			PAGARE,
			CONTRATO,
			USU_CREACION,
			ID_PROYECTO_ORIGEN,
			SUSCRIPCION,
			PORC_CUOT_INI,
			ID_SOLICITUD
		)
		values
		(
			ircLDC_PROYECTO_CONSTRUCTORA.TIPO_VIVIENDA,
			ircLDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO,
			ircLDC_PROYECTO_CONSTRUCTORA.NOMBRE,
			ircLDC_PROYECTO_CONSTRUCTORA.DESCRIPCION,
			ircLDC_PROYECTO_CONSTRUCTORA.CLIENTE,
			ircLDC_PROYECTO_CONSTRUCTORA.FORMA_PAGO,
			ircLDC_PROYECTO_CONSTRUCTORA.CORREO_REC_CUOTA,
			ircLDC_PROYECTO_CONSTRUCTORA.CORREO_REC_CHEQUES,
			ircLDC_PROYECTO_CONSTRUCTORA.FECHA_CREACION,
			ircLDC_PROYECTO_CONSTRUCTORA.FECH_ULT_MODIF,
			ircLDC_PROYECTO_CONSTRUCTORA.TIPO_CONSTRUCCION,
			ircLDC_PROYECTO_CONSTRUCTORA.CANTIDAD_PISOS,
			ircLDC_PROYECTO_CONSTRUCTORA.CANTIDAD_TORRES,
			ircLDC_PROYECTO_CONSTRUCTORA.CANT_UNID_PREDIAL,
			ircLDC_PROYECTO_CONSTRUCTORA.CANT_TIP_UNID_PRED,
			ircLDC_PROYECTO_CONSTRUCTORA.VALOR_FINAL_APROB,
			ircLDC_PROYECTO_CONSTRUCTORA.ID_DIRECCION,
			ircLDC_PROYECTO_CONSTRUCTORA.ID_LOCALIDAD,
			ircLDC_PROYECTO_CONSTRUCTORA.USUARIO_ULT_MODIF,
			ircLDC_PROYECTO_CONSTRUCTORA.PAGARE,
			ircLDC_PROYECTO_CONSTRUCTORA.CONTRATO,
			ircLDC_PROYECTO_CONSTRUCTORA.USU_CREACION,
			ircLDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO_ORIGEN,
			ircLDC_PROYECTO_CONSTRUCTORA.SUSCRIPCION,
			ircLDC_PROYECTO_CONSTRUCTORA.PORC_CUOT_INI,
			ircLDC_PROYECTO_CONSTRUCTORA.ID_SOLICITUD
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_PROYECTO_CONSTRUCTORA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_PROYECTO_CONSTRUCTORA in out nocopy tytbLDC_PROYECTO_CONSTRUCTORA
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_PROYECTO_CONSTRUCTORA,blUseRowID);
		forall n in iotbLDC_PROYECTO_CONSTRUCTORA.first..iotbLDC_PROYECTO_CONSTRUCTORA.last
			insert into LDC_PROYECTO_CONSTRUCTORA
			(
				TIPO_VIVIENDA,
				ID_PROYECTO,
				NOMBRE,
				DESCRIPCION,
				CLIENTE,
				FORMA_PAGO,
				CORREO_REC_CUOTA,
				CORREO_REC_CHEQUES,
				FECHA_CREACION,
				FECH_ULT_MODIF,
				TIPO_CONSTRUCCION,
				CANTIDAD_PISOS,
				CANTIDAD_TORRES,
				CANT_UNID_PREDIAL,
				CANT_TIP_UNID_PRED,
				VALOR_FINAL_APROB,
				ID_DIRECCION,
				ID_LOCALIDAD,
				USUARIO_ULT_MODIF,
				PAGARE,
				CONTRATO,
				USU_CREACION,
				ID_PROYECTO_ORIGEN,
				SUSCRIPCION,
				PORC_CUOT_INI,
				ID_SOLICITUD
			)
			values
			(
				rcRecOfTab.TIPO_VIVIENDA(n),
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.NOMBRE(n),
				rcRecOfTab.DESCRIPCION(n),
				rcRecOfTab.CLIENTE(n),
				rcRecOfTab.FORMA_PAGO(n),
				rcRecOfTab.CORREO_REC_CUOTA(n),
				rcRecOfTab.CORREO_REC_CHEQUES(n),
				rcRecOfTab.FECHA_CREACION(n),
				rcRecOfTab.FECH_ULT_MODIF(n),
				rcRecOfTab.TIPO_CONSTRUCCION(n),
				rcRecOfTab.CANTIDAD_PISOS(n),
				rcRecOfTab.CANTIDAD_TORRES(n),
				rcRecOfTab.CANT_UNID_PREDIAL(n),
				rcRecOfTab.CANT_TIP_UNID_PRED(n),
				rcRecOfTab.VALOR_FINAL_APROB(n),
				rcRecOfTab.ID_DIRECCION(n),
				rcRecOfTab.ID_LOCALIDAD(n),
				rcRecOfTab.USUARIO_ULT_MODIF(n),
				rcRecOfTab.PAGARE(n),
				rcRecOfTab.CONTRATO(n),
				rcRecOfTab.USU_CREACION(n),
				rcRecOfTab.ID_PROYECTO_ORIGEN(n),
				rcRecOfTab.SUSCRIPCION(n),
				rcRecOfTab.PORC_CUOT_INI(n),
				rcRecOfTab.ID_SOLICITUD(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;

		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;


		delete
		from LDC_PROYECTO_CONSTRUCTORA
		where
       		ID_PROYECTO=inuID_PROYECTO;
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
		rcError  styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_PROYECTO_CONSTRUCTORA
		where
			rowid = iriRowID
		returning
			TIPO_VIVIENDA
		into
			rcError.TIPO_VIVIENDA;
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
		iotbLDC_PROYECTO_CONSTRUCTORA in out nocopy tytbLDC_PROYECTO_CONSTRUCTORA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		FillRecordOfTables(iotbLDC_PROYECTO_CONSTRUCTORA, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_PROYECTO_CONSTRUCTORA.first .. iotbLDC_PROYECTO_CONSTRUCTORA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PROYECTO_CONSTRUCTORA.first .. iotbLDC_PROYECTO_CONSTRUCTORA.last
				delete
				from LDC_PROYECTO_CONSTRUCTORA
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PROYECTO_CONSTRUCTORA.first .. iotbLDC_PROYECTO_CONSTRUCTORA.last loop
					LockByPk
					(
						rcRecOfTab.ID_PROYECTO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PROYECTO_CONSTRUCTORA.first .. iotbLDC_PROYECTO_CONSTRUCTORA.last
				delete
				from LDC_PROYECTO_CONSTRUCTORA
				where
		         	ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_PROYECTO_CONSTRUCTORA in styLDC_PROYECTO_CONSTRUCTORA,
		inuLock in number default 0
	)
	IS
		nuID_PROYECTO	LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type;
	BEGIN
		if ircLDC_PROYECTO_CONSTRUCTORA.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_PROYECTO_CONSTRUCTORA.rowid,rcData);
			end if;
			update LDC_PROYECTO_CONSTRUCTORA
			set
				TIPO_VIVIENDA = ircLDC_PROYECTO_CONSTRUCTORA.TIPO_VIVIENDA,
				NOMBRE = ircLDC_PROYECTO_CONSTRUCTORA.NOMBRE,
				DESCRIPCION = ircLDC_PROYECTO_CONSTRUCTORA.DESCRIPCION,
				CLIENTE = ircLDC_PROYECTO_CONSTRUCTORA.CLIENTE,
				FORMA_PAGO = ircLDC_PROYECTO_CONSTRUCTORA.FORMA_PAGO,
				CORREO_REC_CUOTA = ircLDC_PROYECTO_CONSTRUCTORA.CORREO_REC_CUOTA,
				CORREO_REC_CHEQUES = ircLDC_PROYECTO_CONSTRUCTORA.CORREO_REC_CHEQUES,
				FECHA_CREACION = ircLDC_PROYECTO_CONSTRUCTORA.FECHA_CREACION,
				FECH_ULT_MODIF = ircLDC_PROYECTO_CONSTRUCTORA.FECH_ULT_MODIF,
				TIPO_CONSTRUCCION = ircLDC_PROYECTO_CONSTRUCTORA.TIPO_CONSTRUCCION,
				CANTIDAD_PISOS = ircLDC_PROYECTO_CONSTRUCTORA.CANTIDAD_PISOS,
				CANTIDAD_TORRES = ircLDC_PROYECTO_CONSTRUCTORA.CANTIDAD_TORRES,
				CANT_UNID_PREDIAL = ircLDC_PROYECTO_CONSTRUCTORA.CANT_UNID_PREDIAL,
				CANT_TIP_UNID_PRED = ircLDC_PROYECTO_CONSTRUCTORA.CANT_TIP_UNID_PRED,
				VALOR_FINAL_APROB = ircLDC_PROYECTO_CONSTRUCTORA.VALOR_FINAL_APROB,
				ID_DIRECCION = ircLDC_PROYECTO_CONSTRUCTORA.ID_DIRECCION,
				ID_LOCALIDAD = ircLDC_PROYECTO_CONSTRUCTORA.ID_LOCALIDAD,
				USUARIO_ULT_MODIF = ircLDC_PROYECTO_CONSTRUCTORA.USUARIO_ULT_MODIF,
				PAGARE = ircLDC_PROYECTO_CONSTRUCTORA.PAGARE,
				CONTRATO = ircLDC_PROYECTO_CONSTRUCTORA.CONTRATO,
				USU_CREACION = ircLDC_PROYECTO_CONSTRUCTORA.USU_CREACION,
				ID_PROYECTO_ORIGEN = ircLDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO_ORIGEN,
				SUSCRIPCION = ircLDC_PROYECTO_CONSTRUCTORA.SUSCRIPCION,
				PORC_CUOT_INI = ircLDC_PROYECTO_CONSTRUCTORA.PORC_CUOT_INI,
				ID_SOLICITUD = ircLDC_PROYECTO_CONSTRUCTORA.ID_SOLICITUD
			where
				rowid = ircLDC_PROYECTO_CONSTRUCTORA.rowid
			returning
				ID_PROYECTO
			into
				nuID_PROYECTO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO,
					rcData
				);
			end if;

			update LDC_PROYECTO_CONSTRUCTORA
			set
				TIPO_VIVIENDA = ircLDC_PROYECTO_CONSTRUCTORA.TIPO_VIVIENDA,
				NOMBRE = ircLDC_PROYECTO_CONSTRUCTORA.NOMBRE,
				DESCRIPCION = ircLDC_PROYECTO_CONSTRUCTORA.DESCRIPCION,
				CLIENTE = ircLDC_PROYECTO_CONSTRUCTORA.CLIENTE,
				FORMA_PAGO = ircLDC_PROYECTO_CONSTRUCTORA.FORMA_PAGO,
				CORREO_REC_CUOTA = ircLDC_PROYECTO_CONSTRUCTORA.CORREO_REC_CUOTA,
				CORREO_REC_CHEQUES = ircLDC_PROYECTO_CONSTRUCTORA.CORREO_REC_CHEQUES,
				FECHA_CREACION = ircLDC_PROYECTO_CONSTRUCTORA.FECHA_CREACION,
				FECH_ULT_MODIF = ircLDC_PROYECTO_CONSTRUCTORA.FECH_ULT_MODIF,
				TIPO_CONSTRUCCION = ircLDC_PROYECTO_CONSTRUCTORA.TIPO_CONSTRUCCION,
				CANTIDAD_PISOS = ircLDC_PROYECTO_CONSTRUCTORA.CANTIDAD_PISOS,
				CANTIDAD_TORRES = ircLDC_PROYECTO_CONSTRUCTORA.CANTIDAD_TORRES,
				CANT_UNID_PREDIAL = ircLDC_PROYECTO_CONSTRUCTORA.CANT_UNID_PREDIAL,
				CANT_TIP_UNID_PRED = ircLDC_PROYECTO_CONSTRUCTORA.CANT_TIP_UNID_PRED,
				VALOR_FINAL_APROB = ircLDC_PROYECTO_CONSTRUCTORA.VALOR_FINAL_APROB,
				ID_DIRECCION = ircLDC_PROYECTO_CONSTRUCTORA.ID_DIRECCION,
				ID_LOCALIDAD = ircLDC_PROYECTO_CONSTRUCTORA.ID_LOCALIDAD,
				USUARIO_ULT_MODIF = ircLDC_PROYECTO_CONSTRUCTORA.USUARIO_ULT_MODIF,
				PAGARE = ircLDC_PROYECTO_CONSTRUCTORA.PAGARE,
				CONTRATO = ircLDC_PROYECTO_CONSTRUCTORA.CONTRATO,
				USU_CREACION = ircLDC_PROYECTO_CONSTRUCTORA.USU_CREACION,
				ID_PROYECTO_ORIGEN = ircLDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO_ORIGEN,
				SUSCRIPCION = ircLDC_PROYECTO_CONSTRUCTORA.SUSCRIPCION,
				PORC_CUOT_INI = ircLDC_PROYECTO_CONSTRUCTORA.PORC_CUOT_INI,
				ID_SOLICITUD = ircLDC_PROYECTO_CONSTRUCTORA.ID_SOLICITUD
			where
				ID_PROYECTO = ircLDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO
			returning
				ID_PROYECTO
			into
				nuID_PROYECTO;
		end if;
		if
			nuID_PROYECTO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_PROYECTO_CONSTRUCTORA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_PROYECTO_CONSTRUCTORA in out nocopy tytbLDC_PROYECTO_CONSTRUCTORA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		FillRecordOfTables(iotbLDC_PROYECTO_CONSTRUCTORA,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_PROYECTO_CONSTRUCTORA.first .. iotbLDC_PROYECTO_CONSTRUCTORA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PROYECTO_CONSTRUCTORA.first .. iotbLDC_PROYECTO_CONSTRUCTORA.last
				update LDC_PROYECTO_CONSTRUCTORA
				set
					TIPO_VIVIENDA = rcRecOfTab.TIPO_VIVIENDA(n),
					NOMBRE = rcRecOfTab.NOMBRE(n),
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n),
					CLIENTE = rcRecOfTab.CLIENTE(n),
					FORMA_PAGO = rcRecOfTab.FORMA_PAGO(n),
					CORREO_REC_CUOTA = rcRecOfTab.CORREO_REC_CUOTA(n),
					CORREO_REC_CHEQUES = rcRecOfTab.CORREO_REC_CHEQUES(n),
					FECHA_CREACION = rcRecOfTab.FECHA_CREACION(n),
					FECH_ULT_MODIF = rcRecOfTab.FECH_ULT_MODIF(n),
					TIPO_CONSTRUCCION = rcRecOfTab.TIPO_CONSTRUCCION(n),
					CANTIDAD_PISOS = rcRecOfTab.CANTIDAD_PISOS(n),
					CANTIDAD_TORRES = rcRecOfTab.CANTIDAD_TORRES(n),
					CANT_UNID_PREDIAL = rcRecOfTab.CANT_UNID_PREDIAL(n),
					CANT_TIP_UNID_PRED = rcRecOfTab.CANT_TIP_UNID_PRED(n),
					VALOR_FINAL_APROB = rcRecOfTab.VALOR_FINAL_APROB(n),
					ID_DIRECCION = rcRecOfTab.ID_DIRECCION(n),
					ID_LOCALIDAD = rcRecOfTab.ID_LOCALIDAD(n),
					USUARIO_ULT_MODIF = rcRecOfTab.USUARIO_ULT_MODIF(n),
					PAGARE = rcRecOfTab.PAGARE(n),
					CONTRATO = rcRecOfTab.CONTRATO(n),
					USU_CREACION = rcRecOfTab.USU_CREACION(n),
					ID_PROYECTO_ORIGEN = rcRecOfTab.ID_PROYECTO_ORIGEN(n),
					SUSCRIPCION = rcRecOfTab.SUSCRIPCION(n),
					PORC_CUOT_INI = rcRecOfTab.PORC_CUOT_INI(n),
					ID_SOLICITUD = rcRecOfTab.ID_SOLICITUD(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PROYECTO_CONSTRUCTORA.first .. iotbLDC_PROYECTO_CONSTRUCTORA.last loop
					LockByPk
					(
						rcRecOfTab.ID_PROYECTO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PROYECTO_CONSTRUCTORA.first .. iotbLDC_PROYECTO_CONSTRUCTORA.last
				update LDC_PROYECTO_CONSTRUCTORA
				SET
					TIPO_VIVIENDA = rcRecOfTab.TIPO_VIVIENDA(n),
					NOMBRE = rcRecOfTab.NOMBRE(n),
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n),
					CLIENTE = rcRecOfTab.CLIENTE(n),
					FORMA_PAGO = rcRecOfTab.FORMA_PAGO(n),
					CORREO_REC_CUOTA = rcRecOfTab.CORREO_REC_CUOTA(n),
					CORREO_REC_CHEQUES = rcRecOfTab.CORREO_REC_CHEQUES(n),
					FECHA_CREACION = rcRecOfTab.FECHA_CREACION(n),
					FECH_ULT_MODIF = rcRecOfTab.FECH_ULT_MODIF(n),
					TIPO_CONSTRUCCION = rcRecOfTab.TIPO_CONSTRUCCION(n),
					CANTIDAD_PISOS = rcRecOfTab.CANTIDAD_PISOS(n),
					CANTIDAD_TORRES = rcRecOfTab.CANTIDAD_TORRES(n),
					CANT_UNID_PREDIAL = rcRecOfTab.CANT_UNID_PREDIAL(n),
					CANT_TIP_UNID_PRED = rcRecOfTab.CANT_TIP_UNID_PRED(n),
					VALOR_FINAL_APROB = rcRecOfTab.VALOR_FINAL_APROB(n),
					ID_DIRECCION = rcRecOfTab.ID_DIRECCION(n),
					ID_LOCALIDAD = rcRecOfTab.ID_LOCALIDAD(n),
					USUARIO_ULT_MODIF = rcRecOfTab.USUARIO_ULT_MODIF(n),
					PAGARE = rcRecOfTab.PAGARE(n),
					CONTRATO = rcRecOfTab.CONTRATO(n),
					USU_CREACION = rcRecOfTab.USU_CREACION(n),
					ID_PROYECTO_ORIGEN = rcRecOfTab.ID_PROYECTO_ORIGEN(n),
					SUSCRIPCION = rcRecOfTab.SUSCRIPCION(n),
					PORC_CUOT_INI = rcRecOfTab.PORC_CUOT_INI(n),
					ID_SOLICITUD = rcRecOfTab.ID_SOLICITUD(n)
				where
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n)
;
		end if;
	END;
	PROCEDURE updTIPO_VIVIENDA
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuTIPO_VIVIENDA$ in LDC_PROYECTO_CONSTRUCTORA.TIPO_VIVIENDA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			TIPO_VIVIENDA = inuTIPO_VIVIENDA$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPO_VIVIENDA:= inuTIPO_VIVIENDA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNOMBRE
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbNOMBRE$ in LDC_PROYECTO_CONSTRUCTORA.NOMBRE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			NOMBRE = isbNOMBRE$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NOMBRE:= isbNOMBRE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESCRIPCION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbDESCRIPCION$ in LDC_PROYECTO_CONSTRUCTORA.DESCRIPCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			DESCRIPCION = isbDESCRIPCION$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPCION:= isbDESCRIPCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCLIENTE
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuCLIENTE$ in LDC_PROYECTO_CONSTRUCTORA.CLIENTE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			CLIENTE = inuCLIENTE$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CLIENTE:= inuCLIENTE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFORMA_PAGO
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbFORMA_PAGO$ in LDC_PROYECTO_CONSTRUCTORA.FORMA_PAGO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			FORMA_PAGO = isbFORMA_PAGO$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FORMA_PAGO:= isbFORMA_PAGO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCORREO_REC_CUOTA
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbCORREO_REC_CUOTA$ in LDC_PROYECTO_CONSTRUCTORA.CORREO_REC_CUOTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			CORREO_REC_CUOTA = isbCORREO_REC_CUOTA$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CORREO_REC_CUOTA:= isbCORREO_REC_CUOTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCORREO_REC_CHEQUES
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbCORREO_REC_CHEQUES$ in LDC_PROYECTO_CONSTRUCTORA.CORREO_REC_CHEQUES%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			CORREO_REC_CHEQUES = isbCORREO_REC_CHEQUES$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CORREO_REC_CHEQUES:= isbCORREO_REC_CHEQUES$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_CREACION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		idtFECHA_CREACION$ in LDC_PROYECTO_CONSTRUCTORA.FECHA_CREACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			FECHA_CREACION = idtFECHA_CREACION$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_CREACION:= idtFECHA_CREACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECH_ULT_MODIF
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		idtFECH_ULT_MODIF$ in LDC_PROYECTO_CONSTRUCTORA.FECH_ULT_MODIF%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			FECH_ULT_MODIF = idtFECH_ULT_MODIF$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECH_ULT_MODIF:= idtFECH_ULT_MODIF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTIPO_CONSTRUCCION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuTIPO_CONSTRUCCION$ in LDC_PROYECTO_CONSTRUCTORA.TIPO_CONSTRUCCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			TIPO_CONSTRUCCION = inuTIPO_CONSTRUCCION$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPO_CONSTRUCCION:= inuTIPO_CONSTRUCCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCANTIDAD_PISOS
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuCANTIDAD_PISOS$ in LDC_PROYECTO_CONSTRUCTORA.CANTIDAD_PISOS%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			CANTIDAD_PISOS = inuCANTIDAD_PISOS$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CANTIDAD_PISOS:= inuCANTIDAD_PISOS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCANTIDAD_TORRES
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuCANTIDAD_TORRES$ in LDC_PROYECTO_CONSTRUCTORA.CANTIDAD_TORRES%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			CANTIDAD_TORRES = inuCANTIDAD_TORRES$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CANTIDAD_TORRES:= inuCANTIDAD_TORRES$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCANT_UNID_PREDIAL
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuCANT_UNID_PREDIAL$ in LDC_PROYECTO_CONSTRUCTORA.CANT_UNID_PREDIAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			CANT_UNID_PREDIAL = inuCANT_UNID_PREDIAL$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CANT_UNID_PREDIAL:= inuCANT_UNID_PREDIAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCANT_TIP_UNID_PRED
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuCANT_TIP_UNID_PRED$ in LDC_PROYECTO_CONSTRUCTORA.CANT_TIP_UNID_PRED%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			CANT_TIP_UNID_PRED = inuCANT_TIP_UNID_PRED$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CANT_TIP_UNID_PRED:= inuCANT_TIP_UNID_PRED$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALOR_FINAL_APROB
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuVALOR_FINAL_APROB$ in LDC_PROYECTO_CONSTRUCTORA.VALOR_FINAL_APROB%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			VALOR_FINAL_APROB = inuVALOR_FINAL_APROB$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALOR_FINAL_APROB:= inuVALOR_FINAL_APROB$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_DIRECCION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuID_DIRECCION$ in LDC_PROYECTO_CONSTRUCTORA.ID_DIRECCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			ID_DIRECCION = inuID_DIRECCION$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_DIRECCION:= inuID_DIRECCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_LOCALIDAD
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuID_LOCALIDAD$ in LDC_PROYECTO_CONSTRUCTORA.ID_LOCALIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			ID_LOCALIDAD = inuID_LOCALIDAD$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_LOCALIDAD:= inuID_LOCALIDAD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUARIO_ULT_MODIF
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbUSUARIO_ULT_MODIF$ in LDC_PROYECTO_CONSTRUCTORA.USUARIO_ULT_MODIF%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			USUARIO_ULT_MODIF = isbUSUARIO_ULT_MODIF$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUARIO_ULT_MODIF:= isbUSUARIO_ULT_MODIF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPAGARE
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbPAGARE$ in LDC_PROYECTO_CONSTRUCTORA.PAGARE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			PAGARE = isbPAGARE$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PAGARE:= isbPAGARE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCONTRATO
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbCONTRATO$ in LDC_PROYECTO_CONSTRUCTORA.CONTRATO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			CONTRATO = isbCONTRATO$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CONTRATO:= isbCONTRATO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSU_CREACION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		isbUSU_CREACION$ in LDC_PROYECTO_CONSTRUCTORA.USU_CREACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			USU_CREACION = isbUSU_CREACION$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USU_CREACION:= isbUSU_CREACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_PROYECTO_ORIGEN
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuID_PROYECTO_ORIGEN$ in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO_ORIGEN%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			ID_PROYECTO_ORIGEN = inuID_PROYECTO_ORIGEN$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_PROYECTO_ORIGEN:= inuID_PROYECTO_ORIGEN$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUSCRIPCION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuSUSCRIPCION$ in LDC_PROYECTO_CONSTRUCTORA.SUSCRIPCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			SUSCRIPCION = inuSUSCRIPCION$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUSCRIPCION:= inuSUSCRIPCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPORC_CUOT_INI
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuPORC_CUOT_INI$ in LDC_PROYECTO_CONSTRUCTORA.PORC_CUOT_INI%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			PORC_CUOT_INI = inuPORC_CUOT_INI$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PORC_CUOT_INI:= inuPORC_CUOT_INI$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_SOLICITUD
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuID_SOLICITUD$ in LDC_PROYECTO_CONSTRUCTORA.ID_SOLICITUD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_PROYECTO_CONSTRUCTORA
		set
			ID_SOLICITUD = inuID_SOLICITUD$
		where
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_SOLICITUD:= inuID_SOLICITUD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetTIPO_VIVIENDA
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.TIPO_VIVIENDA%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.TIPO_VIVIENDA);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.TIPO_VIVIENDA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_PROYECTO
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_PROYECTO);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.ID_PROYECTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetNOMBRE
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.NOMBRE%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.NOMBRE);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.NOMBRE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDESCRIPCION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.DESCRIPCION%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.DESCRIPCION);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.DESCRIPCION);
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
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.CLIENTE%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.CLIENTE);
		end if;
		Load
		(
		 		inuID_PROYECTO
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
	FUNCTION fsbGetFORMA_PAGO
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.FORMA_PAGO%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.FORMA_PAGO);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.FORMA_PAGO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCORREO_REC_CUOTA
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.CORREO_REC_CUOTA%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.CORREO_REC_CUOTA);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.CORREO_REC_CUOTA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCORREO_REC_CHEQUES
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.CORREO_REC_CHEQUES%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.CORREO_REC_CHEQUES);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.CORREO_REC_CHEQUES);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_CREACION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.FECHA_CREACION%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.FECHA_CREACION);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.FECHA_CREACION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECH_ULT_MODIF
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.FECH_ULT_MODIF%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.FECH_ULT_MODIF);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.FECH_ULT_MODIF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTIPO_CONSTRUCCION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.TIPO_CONSTRUCCION%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.TIPO_CONSTRUCCION);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.TIPO_CONSTRUCCION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCANTIDAD_PISOS
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.CANTIDAD_PISOS%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.CANTIDAD_PISOS);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.CANTIDAD_PISOS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCANTIDAD_TORRES
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.CANTIDAD_TORRES%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.CANTIDAD_TORRES);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.CANTIDAD_TORRES);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCANT_UNID_PREDIAL
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.CANT_UNID_PREDIAL%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.CANT_UNID_PREDIAL);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.CANT_UNID_PREDIAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCANT_TIP_UNID_PRED
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.CANT_TIP_UNID_PRED%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.CANT_TIP_UNID_PRED);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.CANT_TIP_UNID_PRED);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALOR_FINAL_APROB
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.VALOR_FINAL_APROB%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.VALOR_FINAL_APROB);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.VALOR_FINAL_APROB);
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
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.ID_DIRECCION%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_DIRECCION);
		end if;
		Load
		(
		 		inuID_PROYECTO
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
	FUNCTION fnuGetID_LOCALIDAD
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.ID_LOCALIDAD%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_LOCALIDAD);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.ID_LOCALIDAD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSUARIO_ULT_MODIF
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.USUARIO_ULT_MODIF%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.USUARIO_ULT_MODIF);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.USUARIO_ULT_MODIF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPAGARE
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.PAGARE%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.PAGARE);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.PAGARE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCONTRATO
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.CONTRATO%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.CONTRATO);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.CONTRATO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSU_CREACION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.USU_CREACION%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.USU_CREACION);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.USU_CREACION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_PROYECTO_ORIGEN
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO_ORIGEN%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_PROYECTO_ORIGEN);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.ID_PROYECTO_ORIGEN);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUSCRIPCION
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.SUSCRIPCION%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.SUSCRIPCION);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.SUSCRIPCION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPORC_CUOT_INI
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.PORC_CUOT_INI%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.PORC_CUOT_INI);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.PORC_CUOT_INI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_SOLICITUD
	(
		inuID_PROYECTO in LDC_PROYECTO_CONSTRUCTORA.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROYECTO_CONSTRUCTORA.ID_SOLICITUD%type
	IS
		rcError styLDC_PROYECTO_CONSTRUCTORA;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_SOLICITUD);
		end if;
		Load
		(
		 		inuID_PROYECTO
		);
		return(rcData.ID_SOLICITUD);
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
end DALDC_PROYECTO_CONSTRUCTORA;
/
PROMPT Otorgando permisos de ejecucion a DALDC_PROYECTO_CONSTRUCTORA
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_PROYECTO_CONSTRUCTORA', 'ADM_PERSON');
END;
/