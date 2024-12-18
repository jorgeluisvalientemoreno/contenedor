CREATE OR REPLACE PACKAGE adm_person.daldc_cotizacion_construct
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
	)
	IS
		SELECT LDC_COTIZACION_CONSTRUCT.*,LDC_COTIZACION_CONSTRUCT.rowid
		FROM LDC_COTIZACION_CONSTRUCT
		WHERE
		    ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA
		    and ID_PROYECTO = inuID_PROYECTO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_COTIZACION_CONSTRUCT.*,LDC_COTIZACION_CONSTRUCT.rowid
		FROM LDC_COTIZACION_CONSTRUCT
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_COTIZACION_CONSTRUCT  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_COTIZACION_CONSTRUCT is table of styLDC_COTIZACION_CONSTRUCT index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_COTIZACION_CONSTRUCT;

	/* Tipos referenciando al registro */
	type tytbID_COTIZACION_DETALLADA is table of LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type index by binary_integer;
	type tytbID_CONSECUTIVO is table of LDC_COTIZACION_CONSTRUCT.ID_CONSECUTIVO%type index by binary_integer;
	type tytbESTADO is table of LDC_COTIZACION_CONSTRUCT.ESTADO%type index by binary_integer;
	type tytbOBSERVACION is table of LDC_COTIZACION_CONSTRUCT.OBSERVACION%type index by binary_integer;
	type tytbLISTA_COSTO is table of LDC_COTIZACION_CONSTRUCT.LISTA_COSTO%type index by binary_integer;
	type tytbVALOR_COTIZADO is table of LDC_COTIZACION_CONSTRUCT.VALOR_COTIZADO%type index by binary_integer;
	type tytbFECHA_VIGENCIA is table of LDC_COTIZACION_CONSTRUCT.FECHA_VIGENCIA%type index by binary_integer;
	type tytbID_COTIZACION_OSF is table of LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_OSF%type index by binary_integer;
	type tytbFECHA_CREACION is table of LDC_COTIZACION_CONSTRUCT.FECHA_CREACION%type index by binary_integer;
	type tytbFECHA_ULT_MODIF is table of LDC_COTIZACION_CONSTRUCT.FECHA_ULT_MODIF%type index by binary_integer;
	type tytbUSUA_CREACION is table of LDC_COTIZACION_CONSTRUCT.USUA_CREACION%type index by binary_integer;
	type tytbFECHA_APROBACION is table of LDC_COTIZACION_CONSTRUCT.FECHA_APROBACION%type index by binary_integer;
	type tytbUSUA_ULT_MODIF is table of LDC_COTIZACION_CONSTRUCT.USUA_ULT_MODIF%type index by binary_integer;
    --INICIO CA 200-2022
	type tytbPLAN_COMERCIAL_ESPCL is table of LDC_COTIZACION_CONSTRUCT.PLAN_COMERCIAL_ESPCL%type index by binary_integer;
   type tytbUND_INSTALADORA_ID is table of LDC_COTIZACION_CONSTRUCT.UND_INSTALADORA_ID%type index by binary_integer;
   type tytbUND_CERTIFICADORA_ID is table of LDC_COTIZACION_CONSTRUCT.UND_CERTIFICADORA_ID%type index by binary_integer;
   --FIN CA 200-2022
   --INICIO CA 153
   type tytbFLGOGASO is table of LDC_COTIZACION_CONSTRUCT.FLGOGASO%type index by binary_integer;
   --FIN CA 153

	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_COTIZACION_CONSTRUCT is record
	(
		ID_COTIZACION_DETALLADA   tytbID_COTIZACION_DETALLADA,
		ID_PROYECTO   tytbID_PROYECTO,
		ID_CONSECUTIVO   tytbID_CONSECUTIVO,
		ESTADO   tytbESTADO,
		OBSERVACION   tytbOBSERVACION,
		LISTA_COSTO   tytbLISTA_COSTO,
		VALOR_COTIZADO   tytbVALOR_COTIZADO,
		FECHA_VIGENCIA   tytbFECHA_VIGENCIA,
		ID_COTIZACION_OSF   tytbID_COTIZACION_OSF,
		FECHA_CREACION   tytbFECHA_CREACION,
		FECHA_ULT_MODIF   tytbFECHA_ULT_MODIF,
		USUA_CREACION   tytbUSUA_CREACION,
		FECHA_APROBACION   tytbFECHA_APROBACION,
		USUA_ULT_MODIF   tytbUSUA_ULT_MODIF,
       PLAN_COMERCIAL_ESPCL  tytbPLAN_COMERCIAL_ESPCL,
	   UND_INSTALADORA_ID    tytbUND_INSTALADORA_ID,
	   UND_CERTIFICADORA_ID tytbUND_CERTIFICADORA_ID,
     FLGOGASO    tytbFLGOGASO,
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
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
	);

	PROCEDURE getRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		orcRecord out nocopy styLDC_COTIZACION_CONSTRUCT
	);

	FUNCTION frcGetRcData
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
	)
	RETURN styLDC_COTIZACION_CONSTRUCT;

	FUNCTION frcGetRcData
	RETURN styLDC_COTIZACION_CONSTRUCT;

	FUNCTION frcGetRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
	)
	RETURN styLDC_COTIZACION_CONSTRUCT;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_COTIZACION_CONSTRUCT
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_COTIZACION_CONSTRUCT in styLDC_COTIZACION_CONSTRUCT
	);

	PROCEDURE insRecord
	(
		ircLDC_COTIZACION_CONSTRUCT in styLDC_COTIZACION_CONSTRUCT,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_COTIZACION_CONSTRUCT in out nocopy tytbLDC_COTIZACION_CONSTRUCT
	);

	PROCEDURE delRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_COTIZACION_CONSTRUCT in out nocopy tytbLDC_COTIZACION_CONSTRUCT,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_COTIZACION_CONSTRUCT in styLDC_COTIZACION_CONSTRUCT,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_COTIZACION_CONSTRUCT in out nocopy tytbLDC_COTIZACION_CONSTRUCT,
		inuLock in number default 1
	);

	PROCEDURE updID_CONSECUTIVO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuID_CONSECUTIVO$ in LDC_COTIZACION_CONSTRUCT.ID_CONSECUTIVO%type,
		inuLock in number default 0
	);

	PROCEDURE updESTADO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		isbESTADO$ in LDC_COTIZACION_CONSTRUCT.ESTADO%type,
		inuLock in number default 0
	);

	PROCEDURE updOBSERVACION
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		isbOBSERVACION$ in LDC_COTIZACION_CONSTRUCT.OBSERVACION%type,
		inuLock in number default 0
	);

	PROCEDURE updLISTA_COSTO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuLISTA_COSTO$ in LDC_COTIZACION_CONSTRUCT.LISTA_COSTO%type,
		inuLock in number default 0
	);

	PROCEDURE updVALOR_COTIZADO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuVALOR_COTIZADO$ in LDC_COTIZACION_CONSTRUCT.VALOR_COTIZADO%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_VIGENCIA
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		idtFECHA_VIGENCIA$ in LDC_COTIZACION_CONSTRUCT.FECHA_VIGENCIA%type,
		inuLock in number default 0
	);

	PROCEDURE updID_COTIZACION_OSF
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuID_COTIZACION_OSF$ in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_OSF%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_CREACION
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		idtFECHA_CREACION$ in LDC_COTIZACION_CONSTRUCT.FECHA_CREACION%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_ULT_MODIF
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		idtFECHA_ULT_MODIF$ in LDC_COTIZACION_CONSTRUCT.FECHA_ULT_MODIF%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUA_CREACION
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		isbUSUA_CREACION$ in LDC_COTIZACION_CONSTRUCT.USUA_CREACION%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_APROBACION
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		idtFECHA_APROBACION$ in LDC_COTIZACION_CONSTRUCT.FECHA_APROBACION%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUA_ULT_MODIF
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		isbUSUA_ULT_MODIF$ in LDC_COTIZACION_CONSTRUCT.USUA_ULT_MODIF%type,
		inuLock in number default 0
	);
  --INICIO CA 200-2022
  PROCEDURE updPLAN_COMERCIAL_ESPCL
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuPLAN_COMERCIAL_ESPCL$ in LDC_COTIZACION_CONSTRUCT.PLAN_COMERCIAL_ESPCL%type,
		inuLock in number default 0
	);
	PROCEDURE updUND_INSTALADORA_ID
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuUND_INSTALADORA_ID in LDC_COTIZACION_CONSTRUCT.UND_INSTALADORA_ID%type,
		inuLock in number default 0
	);
	PROCEDURE updUND_CERTIFICADORA_ID
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuUND_CERTIFICADORA_ID in LDC_COTIZACION_CONSTRUCT.UND_CERTIFICADORA_ID%type,
		inuLock in number default 0
	);

	--FIN CA 200-2022
    --INICIO CA 153
  	PROCEDURE updFLGOGASO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		isbFLGOGASO in LDC_COTIZACION_CONSTRUCT.FLGOGASO%type,
		inuLock in number default 0
	);
  --FIN CA 153

	FUNCTION fnuGetID_COTIZACION_DETALLADA
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type;

	FUNCTION fnuGetID_CONSECUTIVO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.ID_CONSECUTIVO%type;

	FUNCTION fsbGetESTADO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.ESTADO%type;

	FUNCTION fsbGetOBSERVACION
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.OBSERVACION%type;

	FUNCTION fnuGetLISTA_COSTO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.LISTA_COSTO%type;

	FUNCTION fnuGetVALOR_COTIZADO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.VALOR_COTIZADO%type;

	FUNCTION fdtGetFECHA_VIGENCIA
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.FECHA_VIGENCIA%type;

	FUNCTION fnuGetID_COTIZACION_OSF
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_OSF%type;

	FUNCTION fdtGetFECHA_CREACION
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.FECHA_CREACION%type;

	FUNCTION fdtGetFECHA_ULT_MODIF
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.FECHA_ULT_MODIF%type;

    --INICIO CA 200-2022
	FUNCTION fnuGetPLAN_COMERCIAL_ESPCL
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.PLAN_COMERCIAL_ESPCL%type;

	FUNCTION fnuGetUND_INSTALADORA_ID
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.UND_INSTALADORA_ID%type;

	FUNCTION fnuGetUND_CERTIFICADORA_ID
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.UND_CERTIFICADORA_ID%type;

	--FIN CA 200-2022

  --INICIO CA 153
  FUNCTION fsbGetFLGOGASO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.FLGOGASO%type;
  --FIN CA 153

	FUNCTION fsbGetUSUA_CREACION
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.USUA_CREACION%type;

	FUNCTION fdtGetFECHA_APROBACION
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.FECHA_APROBACION%type;

	FUNCTION fsbGetUSUA_ULT_MODIF
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.USUA_ULT_MODIF%type;


	PROCEDURE LockByPk
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		orcLDC_COTIZACION_CONSTRUCT  out styLDC_COTIZACION_CONSTRUCT
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_COTIZACION_CONSTRUCT  out styLDC_COTIZACION_CONSTRUCT
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_COTIZACION_CONSTRUCT;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_COTIZACION_CONSTRUCT
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_COTIZACION_CONSTRUCT';
	 cnuGeEntityId constant varchar2(30) := 2864; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
	)
	IS
		SELECT LDC_COTIZACION_CONSTRUCT.*,LDC_COTIZACION_CONSTRUCT.rowid
		FROM LDC_COTIZACION_CONSTRUCT
		WHERE  ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA
			and ID_PROYECTO = inuID_PROYECTO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_COTIZACION_CONSTRUCT.*,LDC_COTIZACION_CONSTRUCT.rowid
		FROM LDC_COTIZACION_CONSTRUCT
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_COTIZACION_CONSTRUCT is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_COTIZACION_CONSTRUCT;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_COTIZACION_CONSTRUCT default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_COTIZACION_DETALLADA);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_PROYECTO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		orcLDC_COTIZACION_CONSTRUCT  out styLDC_COTIZACION_CONSTRUCT
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

		Open cuLockRcByPk
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
		);

		fetch cuLockRcByPk into orcLDC_COTIZACION_CONSTRUCT;
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
		orcLDC_COTIZACION_CONSTRUCT  out styLDC_COTIZACION_CONSTRUCT
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_COTIZACION_CONSTRUCT;
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
		itbLDC_COTIZACION_CONSTRUCT  in out nocopy tytbLDC_COTIZACION_CONSTRUCT
	)
	IS
	BEGIN
			rcRecOfTab.ID_COTIZACION_DETALLADA.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.ID_CONSECUTIVO.delete;
			rcRecOfTab.ESTADO.delete;
			rcRecOfTab.OBSERVACION.delete;
			rcRecOfTab.LISTA_COSTO.delete;
			rcRecOfTab.VALOR_COTIZADO.delete;
			rcRecOfTab.FECHA_VIGENCIA.delete;
			rcRecOfTab.ID_COTIZACION_OSF.delete;
			rcRecOfTab.FECHA_CREACION.delete;
			rcRecOfTab.FECHA_ULT_MODIF.delete;
			rcRecOfTab.USUA_CREACION.delete;
			rcRecOfTab.FECHA_APROBACION.delete;
			rcRecOfTab.USUA_ULT_MODIF.delete;
			--INICIO CA 200-2022
			rcRecOfTab.PLAN_COMERCIAL_ESPCL.delete;
			rcRecOfTab.UND_INSTALADORA_ID.delete;
			rcRecOfTab.UND_CERTIFICADORA_ID.delete;
			--FIN CA 200-20222
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_COTIZACION_CONSTRUCT  in out nocopy tytbLDC_COTIZACION_CONSTRUCT,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_COTIZACION_CONSTRUCT);

		for n in itbLDC_COTIZACION_CONSTRUCT.first .. itbLDC_COTIZACION_CONSTRUCT.last loop
			rcRecOfTab.ID_COTIZACION_DETALLADA(n) := itbLDC_COTIZACION_CONSTRUCT(n).ID_COTIZACION_DETALLADA;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_COTIZACION_CONSTRUCT(n).ID_PROYECTO;
			rcRecOfTab.ID_CONSECUTIVO(n) := itbLDC_COTIZACION_CONSTRUCT(n).ID_CONSECUTIVO;
			rcRecOfTab.ESTADO(n) := itbLDC_COTIZACION_CONSTRUCT(n).ESTADO;
			rcRecOfTab.OBSERVACION(n) := itbLDC_COTIZACION_CONSTRUCT(n).OBSERVACION;
			rcRecOfTab.LISTA_COSTO(n) := itbLDC_COTIZACION_CONSTRUCT(n).LISTA_COSTO;
			rcRecOfTab.VALOR_COTIZADO(n) := itbLDC_COTIZACION_CONSTRUCT(n).VALOR_COTIZADO;
			rcRecOfTab.FECHA_VIGENCIA(n) := itbLDC_COTIZACION_CONSTRUCT(n).FECHA_VIGENCIA;
			rcRecOfTab.ID_COTIZACION_OSF(n) := itbLDC_COTIZACION_CONSTRUCT(n).ID_COTIZACION_OSF;
			rcRecOfTab.FECHA_CREACION(n) := itbLDC_COTIZACION_CONSTRUCT(n).FECHA_CREACION;
			rcRecOfTab.FECHA_ULT_MODIF(n) := itbLDC_COTIZACION_CONSTRUCT(n).FECHA_ULT_MODIF;
			rcRecOfTab.USUA_CREACION(n) := itbLDC_COTIZACION_CONSTRUCT(n).USUA_CREACION;
			rcRecOfTab.FECHA_APROBACION(n) := itbLDC_COTIZACION_CONSTRUCT(n).FECHA_APROBACION;
			rcRecOfTab.USUA_ULT_MODIF(n) := itbLDC_COTIZACION_CONSTRUCT(n).USUA_ULT_MODIF;
			--INICIO CA 200-2022
			rcRecOfTab.PLAN_COMERCIAL_ESPCL(n) := itbLDC_COTIZACION_CONSTRUCT(n).PLAN_COMERCIAL_ESPCL;
			rcRecOfTab.UND_INSTALADORA_ID(n) := itbLDC_COTIZACION_CONSTRUCT(n).UND_INSTALADORA_ID;
			rcRecOfTab.UND_CERTIFICADORA_ID(n) := itbLDC_COTIZACION_CONSTRUCT(n).UND_CERTIFICADORA_ID;
			--FIN CA 200-2022
			rcRecOfTab.row_id(n) := itbLDC_COTIZACION_CONSTRUCT(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_COTIZACION_DETALLADA,
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
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_COTIZACION_DETALLADA = rcData.ID_COTIZACION_DETALLADA AND
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
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_COTIZACION_DETALLADA,
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
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
	)
	IS
	BEGIN
		Load
		(
			inuID_COTIZACION_DETALLADA,
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
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		orcRecord out nocopy styLDC_COTIZACION_CONSTRUCT
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_COTIZACION_DETALLADA,
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
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
	)
	RETURN styLDC_COTIZACION_CONSTRUCT
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_COTIZACION_DETALLADA,
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
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
	)
	RETURN styLDC_COTIZACION_CONSTRUCT
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO:=inuID_PROYECTO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_COTIZACION_CONSTRUCT
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_COTIZACION_CONSTRUCT
	)
	IS
		rfLDC_COTIZACION_CONSTRUCT tyrfLDC_COTIZACION_CONSTRUCT;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_COTIZACION_CONSTRUCT.*, LDC_COTIZACION_CONSTRUCT.rowid FROM LDC_COTIZACION_CONSTRUCT';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_COTIZACION_CONSTRUCT for sbFullQuery;

		fetch rfLDC_COTIZACION_CONSTRUCT bulk collect INTO otbResult;

		close rfLDC_COTIZACION_CONSTRUCT;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_COTIZACION_CONSTRUCT.*, LDC_COTIZACION_CONSTRUCT.rowid FROM LDC_COTIZACION_CONSTRUCT';
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
		ircLDC_COTIZACION_CONSTRUCT in styLDC_COTIZACION_CONSTRUCT
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_COTIZACION_CONSTRUCT,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_COTIZACION_CONSTRUCT in styLDC_COTIZACION_CONSTRUCT,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_COTIZACION_DETALLADA');
			raise ex.controlled_error;
		end if;
		if ircLDC_COTIZACION_CONSTRUCT.ID_PROYECTO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PROYECTO');
			raise ex.controlled_error;
		end if;

		insert into LDC_COTIZACION_CONSTRUCT
		(
			ID_COTIZACION_DETALLADA,
			ID_PROYECTO,
			ID_CONSECUTIVO,
			ESTADO,
			OBSERVACION,
			LISTA_COSTO,
			VALOR_COTIZADO,
			FECHA_VIGENCIA,
			ID_COTIZACION_OSF,
			FECHA_CREACION,
			FECHA_ULT_MODIF,
			USUA_CREACION,
			FECHA_APROBACION,
			USUA_ULT_MODIF,
			--INICIO CA 200-2022
			PLAN_COMERCIAL_ESPCL,
			UND_INSTALADORA_ID,
			UND_CERTIFICADORA_ID,
			--FIN CA 200-2022
      --INICIO CA 153
      FLGOGASO
      --FIN CA 153
		)
		values
		(
			ircLDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA,
			ircLDC_COTIZACION_CONSTRUCT.ID_PROYECTO,
			ircLDC_COTIZACION_CONSTRUCT.ID_CONSECUTIVO,
			ircLDC_COTIZACION_CONSTRUCT.ESTADO,
			ircLDC_COTIZACION_CONSTRUCT.OBSERVACION,
			ircLDC_COTIZACION_CONSTRUCT.LISTA_COSTO,
			ircLDC_COTIZACION_CONSTRUCT.VALOR_COTIZADO,
			ircLDC_COTIZACION_CONSTRUCT.FECHA_VIGENCIA,
			ircLDC_COTIZACION_CONSTRUCT.ID_COTIZACION_OSF,
			ircLDC_COTIZACION_CONSTRUCT.FECHA_CREACION,
			ircLDC_COTIZACION_CONSTRUCT.FECHA_ULT_MODIF,
			ircLDC_COTIZACION_CONSTRUCT.USUA_CREACION,
			ircLDC_COTIZACION_CONSTRUCT.FECHA_APROBACION,
			ircLDC_COTIZACION_CONSTRUCT.USUA_ULT_MODIF,
            --INICIO CA 200-2022
			ircLDC_COTIZACION_CONSTRUCT.PLAN_COMERCIAL_ESPCL,
			ircLDC_COTIZACION_CONSTRUCT.UND_INSTALADORA_ID,
			ircLDC_COTIZACION_CONSTRUCT.UND_CERTIFICADORA_ID,
			--FIN CA 200-2022
      --INIICO CA 153
      ircLDC_COTIZACION_CONSTRUCT.FLGOGASO
      --FIN CA 153

		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_COTIZACION_CONSTRUCT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_COTIZACION_CONSTRUCT in out nocopy tytbLDC_COTIZACION_CONSTRUCT
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_COTIZACION_CONSTRUCT,blUseRowID);
		forall n in iotbLDC_COTIZACION_CONSTRUCT.first..iotbLDC_COTIZACION_CONSTRUCT.last
			insert into LDC_COTIZACION_CONSTRUCT
			(
				ID_COTIZACION_DETALLADA,
				ID_PROYECTO,
				ID_CONSECUTIVO,
				ESTADO,
				OBSERVACION,
				LISTA_COSTO,
				VALOR_COTIZADO,
				FECHA_VIGENCIA,
				ID_COTIZACION_OSF,
				FECHA_CREACION,
				FECHA_ULT_MODIF,
				USUA_CREACION,
				FECHA_APROBACION,
				USUA_ULT_MODIF,
                --INICIO CA 200-2022
				PLAN_COMERCIAL_ESPCL,
				UND_INSTALADORA_ID,
				UND_CERTIFICADORA_ID,
				--FIN CA 200-2022
        --INICIO CA 153
        FLGOGASO
        --FIN CA 153
			)
			values
			(
				rcRecOfTab.ID_COTIZACION_DETALLADA(n),
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.ID_CONSECUTIVO(n),
				rcRecOfTab.ESTADO(n),
				rcRecOfTab.OBSERVACION(n),
				rcRecOfTab.LISTA_COSTO(n),
				rcRecOfTab.VALOR_COTIZADO(n),
				rcRecOfTab.FECHA_VIGENCIA(n),
				rcRecOfTab.ID_COTIZACION_OSF(n),
				rcRecOfTab.FECHA_CREACION(n),
				rcRecOfTab.FECHA_ULT_MODIF(n),
				rcRecOfTab.USUA_CREACION(n),
				rcRecOfTab.FECHA_APROBACION(n),
				rcRecOfTab.USUA_ULT_MODIF(n),
				--INICIO CA 200-2022
				rcRecOfTab.PLAN_COMERCIAL_ESPCL(n),
				rcRecOfTab.UND_INSTALADORA_ID(n),
				rcRecOfTab.UND_CERTIFICADORA_ID(n),
				--FIN CA 200-2022
        --INICIO CA 153
        rcRecOfTab.FLGOGASO(n)
        --FIN CA 153
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;


		delete
		from LDC_COTIZACION_CONSTRUCT
		where
       		ID_COTIZACION_DETALLADA=inuID_COTIZACION_DETALLADA and
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
		rcError  styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_COTIZACION_CONSTRUCT
		where
			rowid = iriRowID
		returning
			ID_COTIZACION_DETALLADA,
			ID_PROYECTO
		into
			rcError.ID_COTIZACION_DETALLADA,
			rcError.ID_PROYECTO;
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
		iotbLDC_COTIZACION_CONSTRUCT in out nocopy tytbLDC_COTIZACION_CONSTRUCT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		FillRecordOfTables(iotbLDC_COTIZACION_CONSTRUCT, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_COTIZACION_CONSTRUCT.first .. iotbLDC_COTIZACION_CONSTRUCT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COTIZACION_CONSTRUCT.first .. iotbLDC_COTIZACION_CONSTRUCT.last
				delete
				from LDC_COTIZACION_CONSTRUCT
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_COTIZACION_CONSTRUCT.first .. iotbLDC_COTIZACION_CONSTRUCT.last loop
					LockByPk
					(
						rcRecOfTab.ID_COTIZACION_DETALLADA(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COTIZACION_CONSTRUCT.first .. iotbLDC_COTIZACION_CONSTRUCT.last
				delete
				from LDC_COTIZACION_CONSTRUCT
				where
		         	ID_COTIZACION_DETALLADA = rcRecOfTab.ID_COTIZACION_DETALLADA(n) and
		         	ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_COTIZACION_CONSTRUCT in styLDC_COTIZACION_CONSTRUCT,
		inuLock in number default 0
	)
	IS
		nuID_COTIZACION_DETALLADA	LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type;
		nuID_PROYECTO	LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type;
	BEGIN
		if ircLDC_COTIZACION_CONSTRUCT.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_COTIZACION_CONSTRUCT.rowid,rcData);
			end if;
			update LDC_COTIZACION_CONSTRUCT
			set
				ID_CONSECUTIVO = ircLDC_COTIZACION_CONSTRUCT.ID_CONSECUTIVO,
				ESTADO = ircLDC_COTIZACION_CONSTRUCT.ESTADO,
				OBSERVACION = ircLDC_COTIZACION_CONSTRUCT.OBSERVACION,
				LISTA_COSTO = ircLDC_COTIZACION_CONSTRUCT.LISTA_COSTO,
				VALOR_COTIZADO = ircLDC_COTIZACION_CONSTRUCT.VALOR_COTIZADO,
				FECHA_VIGENCIA = ircLDC_COTIZACION_CONSTRUCT.FECHA_VIGENCIA,
				ID_COTIZACION_OSF = ircLDC_COTIZACION_CONSTRUCT.ID_COTIZACION_OSF,
				FECHA_CREACION = ircLDC_COTIZACION_CONSTRUCT.FECHA_CREACION,
				FECHA_ULT_MODIF = ircLDC_COTIZACION_CONSTRUCT.FECHA_ULT_MODIF,
				USUA_CREACION = ircLDC_COTIZACION_CONSTRUCT.USUA_CREACION,
				FECHA_APROBACION = ircLDC_COTIZACION_CONSTRUCT.FECHA_APROBACION,
				USUA_ULT_MODIF = ircLDC_COTIZACION_CONSTRUCT.USUA_ULT_MODIF,
				--INICIO CA 200-2022
				PLAN_COMERCIAL_ESPCL = ircLDC_COTIZACION_CONSTRUCT.PLAN_COMERCIAL_ESPCL,
				UND_INSTALADORA_ID = ircLDC_COTIZACION_CONSTRUCT.UND_INSTALADORA_ID,
				UND_CERTIFICADORA_ID = ircLDC_COTIZACION_CONSTRUCT.UND_CERTIFICADORA_ID,
				--FIN CA 200-2022
        --INICIO CA 153
        FLGOGASO  = ircLDC_COTIZACION_CONSTRUCT.FLGOGASO
        --FIN CA 153
			where
				rowid = ircLDC_COTIZACION_CONSTRUCT.rowid
			returning
				ID_COTIZACION_DETALLADA,
				ID_PROYECTO
			into
				nuID_COTIZACION_DETALLADA,
				nuID_PROYECTO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA,
					ircLDC_COTIZACION_CONSTRUCT.ID_PROYECTO,
					rcData
				);
			end if;

			update LDC_COTIZACION_CONSTRUCT
			set
				ID_CONSECUTIVO = ircLDC_COTIZACION_CONSTRUCT.ID_CONSECUTIVO,
				ESTADO = ircLDC_COTIZACION_CONSTRUCT.ESTADO,
				OBSERVACION = ircLDC_COTIZACION_CONSTRUCT.OBSERVACION,
				LISTA_COSTO = ircLDC_COTIZACION_CONSTRUCT.LISTA_COSTO,
				VALOR_COTIZADO = ircLDC_COTIZACION_CONSTRUCT.VALOR_COTIZADO,
				FECHA_VIGENCIA = ircLDC_COTIZACION_CONSTRUCT.FECHA_VIGENCIA,
				ID_COTIZACION_OSF = ircLDC_COTIZACION_CONSTRUCT.ID_COTIZACION_OSF,
				FECHA_CREACION = ircLDC_COTIZACION_CONSTRUCT.FECHA_CREACION,
				FECHA_ULT_MODIF = ircLDC_COTIZACION_CONSTRUCT.FECHA_ULT_MODIF,
				USUA_CREACION = ircLDC_COTIZACION_CONSTRUCT.USUA_CREACION,
				FECHA_APROBACION = ircLDC_COTIZACION_CONSTRUCT.FECHA_APROBACION,
				USUA_ULT_MODIF = ircLDC_COTIZACION_CONSTRUCT.USUA_ULT_MODIF,
				--INICIO CA 200-2022
				PLAN_COMERCIAL_ESPCL = ircLDC_COTIZACION_CONSTRUCT.PLAN_COMERCIAL_ESPCL,
				UND_INSTALADORA_ID = ircLDC_COTIZACION_CONSTRUCT.UND_INSTALADORA_ID,
				UND_CERTIFICADORA_ID = ircLDC_COTIZACION_CONSTRUCT.UND_CERTIFICADORA_ID
				--FIN CA 200-2022
			where
				ID_COTIZACION_DETALLADA = ircLDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA and
				ID_PROYECTO = ircLDC_COTIZACION_CONSTRUCT.ID_PROYECTO
			returning
				ID_COTIZACION_DETALLADA,
				ID_PROYECTO
			into
				nuID_COTIZACION_DETALLADA,
				nuID_PROYECTO;
		end if;
		if
			nuID_COTIZACION_DETALLADA is NULL OR
			nuID_PROYECTO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_COTIZACION_CONSTRUCT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_COTIZACION_CONSTRUCT in out nocopy tytbLDC_COTIZACION_CONSTRUCT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		FillRecordOfTables(iotbLDC_COTIZACION_CONSTRUCT,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_COTIZACION_CONSTRUCT.first .. iotbLDC_COTIZACION_CONSTRUCT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COTIZACION_CONSTRUCT.first .. iotbLDC_COTIZACION_CONSTRUCT.last
				update LDC_COTIZACION_CONSTRUCT
				set
					ID_CONSECUTIVO = rcRecOfTab.ID_CONSECUTIVO(n),
					ESTADO = rcRecOfTab.ESTADO(n),
					OBSERVACION = rcRecOfTab.OBSERVACION(n),
					LISTA_COSTO = rcRecOfTab.LISTA_COSTO(n),
					VALOR_COTIZADO = rcRecOfTab.VALOR_COTIZADO(n),
					FECHA_VIGENCIA = rcRecOfTab.FECHA_VIGENCIA(n),
					ID_COTIZACION_OSF = rcRecOfTab.ID_COTIZACION_OSF(n),
					FECHA_CREACION = rcRecOfTab.FECHA_CREACION(n),
					FECHA_ULT_MODIF = rcRecOfTab.FECHA_ULT_MODIF(n),
					USUA_CREACION = rcRecOfTab.USUA_CREACION(n),
					FECHA_APROBACION = rcRecOfTab.FECHA_APROBACION(n),
					USUA_ULT_MODIF = rcRecOfTab.USUA_ULT_MODIF(n),
					--INICIO CA 200-2022
					PLAN_COMERCIAL_ESPCL = rcRecOfTab.PLAN_COMERCIAL_ESPCL(n),
					UND_INSTALADORA_ID = rcRecOfTab.UND_INSTALADORA_ID(n),
					UND_CERTIFICADORA_ID = rcRecOfTab.UND_CERTIFICADORA_ID(n),
					--FIN CA 200-2022
           --INICIO CA 153
          FLGOGASO  = rcRecOfTab.FLGOGASO(n)
        --FIN CA 153
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_COTIZACION_CONSTRUCT.first .. iotbLDC_COTIZACION_CONSTRUCT.last loop
					LockByPk
					(
						rcRecOfTab.ID_COTIZACION_DETALLADA(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COTIZACION_CONSTRUCT.first .. iotbLDC_COTIZACION_CONSTRUCT.last
				update LDC_COTIZACION_CONSTRUCT
				SET
					ID_CONSECUTIVO = rcRecOfTab.ID_CONSECUTIVO(n),
					ESTADO = rcRecOfTab.ESTADO(n),
					OBSERVACION = rcRecOfTab.OBSERVACION(n),
					LISTA_COSTO = rcRecOfTab.LISTA_COSTO(n),
					VALOR_COTIZADO = rcRecOfTab.VALOR_COTIZADO(n),
					FECHA_VIGENCIA = rcRecOfTab.FECHA_VIGENCIA(n),
					ID_COTIZACION_OSF = rcRecOfTab.ID_COTIZACION_OSF(n),
					FECHA_CREACION = rcRecOfTab.FECHA_CREACION(n),
					FECHA_ULT_MODIF = rcRecOfTab.FECHA_ULT_MODIF(n),
					USUA_CREACION = rcRecOfTab.USUA_CREACION(n),
					FECHA_APROBACION = rcRecOfTab.FECHA_APROBACION(n),
					USUA_ULT_MODIF = rcRecOfTab.USUA_ULT_MODIF(n),
					--INICIO CA 200-2022
					PLAN_COMERCIAL_ESPCL = rcRecOfTab.PLAN_COMERCIAL_ESPCL(n),
					UND_INSTALADORA_ID = rcRecOfTab.UND_INSTALADORA_ID(n),
					UND_CERTIFICADORA_ID = rcRecOfTab.UND_CERTIFICADORA_ID(n)
					--FIN CA 200-2022
				where
					ID_COTIZACION_DETALLADA = rcRecOfTab.ID_COTIZACION_DETALLADA(n) and
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n)
;
		end if;
	END;
	PROCEDURE updID_CONSECUTIVO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuID_CONSECUTIVO$ in LDC_COTIZACION_CONSTRUCT.ID_CONSECUTIVO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_COTIZACION_CONSTRUCT
		set
			ID_CONSECUTIVO = inuID_CONSECUTIVO$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_CONSECUTIVO:= inuID_CONSECUTIVO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updESTADO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		isbESTADO$ in LDC_COTIZACION_CONSTRUCT.ESTADO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_COTIZACION_CONSTRUCT
		set
			ESTADO = isbESTADO$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ESTADO:= isbESTADO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updOBSERVACION
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		isbOBSERVACION$ in LDC_COTIZACION_CONSTRUCT.OBSERVACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_COTIZACION_CONSTRUCT
		set
			OBSERVACION = isbOBSERVACION$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OBSERVACION:= isbOBSERVACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLISTA_COSTO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuLISTA_COSTO$ in LDC_COTIZACION_CONSTRUCT.LISTA_COSTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_COTIZACION_CONSTRUCT
		set
			LISTA_COSTO = inuLISTA_COSTO$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LISTA_COSTO:= inuLISTA_COSTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALOR_COTIZADO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuVALOR_COTIZADO$ in LDC_COTIZACION_CONSTRUCT.VALOR_COTIZADO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_COTIZACION_CONSTRUCT
		set
			VALOR_COTIZADO = inuVALOR_COTIZADO$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALOR_COTIZADO:= inuVALOR_COTIZADO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_VIGENCIA
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		idtFECHA_VIGENCIA$ in LDC_COTIZACION_CONSTRUCT.FECHA_VIGENCIA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_COTIZACION_CONSTRUCT
		set
			FECHA_VIGENCIA = idtFECHA_VIGENCIA$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_VIGENCIA:= idtFECHA_VIGENCIA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_COTIZACION_OSF
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuID_COTIZACION_OSF$ in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_OSF%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_COTIZACION_CONSTRUCT
		set
			ID_COTIZACION_OSF = inuID_COTIZACION_OSF$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_COTIZACION_OSF:= inuID_COTIZACION_OSF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_CREACION
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		idtFECHA_CREACION$ in LDC_COTIZACION_CONSTRUCT.FECHA_CREACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_COTIZACION_CONSTRUCT
		set
			FECHA_CREACION = idtFECHA_CREACION$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
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
	PROCEDURE updFECHA_ULT_MODIF
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		idtFECHA_ULT_MODIF$ in LDC_COTIZACION_CONSTRUCT.FECHA_ULT_MODIF%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_COTIZACION_CONSTRUCT
		set
			FECHA_ULT_MODIF = idtFECHA_ULT_MODIF$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_ULT_MODIF:= idtFECHA_ULT_MODIF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUA_CREACION
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		isbUSUA_CREACION$ in LDC_COTIZACION_CONSTRUCT.USUA_CREACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_COTIZACION_CONSTRUCT
		set
			USUA_CREACION = isbUSUA_CREACION$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUA_CREACION:= isbUSUA_CREACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_APROBACION
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		idtFECHA_APROBACION$ in LDC_COTIZACION_CONSTRUCT.FECHA_APROBACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_COTIZACION_CONSTRUCT
		set
			FECHA_APROBACION = idtFECHA_APROBACION$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_APROBACION:= idtFECHA_APROBACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUA_ULT_MODIF
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		isbUSUA_ULT_MODIF$ in LDC_COTIZACION_CONSTRUCT.USUA_ULT_MODIF%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_COTIZACION_CONSTRUCT
		set
			USUA_ULT_MODIF = isbUSUA_ULT_MODIF$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUA_ULT_MODIF:= isbUSUA_ULT_MODIF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
  PROCEDURE updPLAN_COMERCIAL_ESPCL
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuPLAN_COMERCIAL_ESPCL$ in LDC_COTIZACION_CONSTRUCT.PLAN_COMERCIAL_ESPCL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_COTIZACION_CONSTRUCT
		set
			PLAN_COMERCIAL_ESPCL = inuPLAN_COMERCIAL_ESPCL$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PLAN_COMERCIAL_ESPCL:= inuPLAN_COMERCIAL_ESPCL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	 PROCEDURE updUND_INSTALADORA_ID
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuUND_INSTALADORA_ID in LDC_COTIZACION_CONSTRUCT.UND_INSTALADORA_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_COTIZACION_CONSTRUCT
		set
			UND_INSTALADORA_ID = inuUND_INSTALADORA_ID
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.UND_INSTALADORA_ID:= inuUND_INSTALADORA_ID;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	 PROCEDURE updUND_CERTIFICADORA_ID
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuUND_CERTIFICADORA_ID in LDC_COTIZACION_CONSTRUCT.UND_CERTIFICADORA_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_COTIZACION_CONSTRUCT
		set
			UND_CERTIFICADORA_ID = inuUND_CERTIFICADORA_ID
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.UND_CERTIFICADORA_ID:= inuUND_CERTIFICADORA_ID;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

   --INICIO CA 153
  PROCEDURE updFLGOGASO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		isbFLGOGASO in LDC_COTIZACION_CONSTRUCT.FLGOGASO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_COTIZACION_CONSTRUCT
		set
			FLGOGASO = isbFLGOGASO
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FLGOGASO:= isbFLGOGASO;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION fnuGetID_COTIZACION_DETALLADA
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_COTIZACION_DETALLADA);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.ID_COTIZACION_DETALLADA);
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
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_PROYECTO);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
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
	FUNCTION fnuGetID_CONSECUTIVO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.ID_CONSECUTIVO%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_CONSECUTIVO);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.ID_CONSECUTIVO);
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
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.ESTADO%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ESTADO);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
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
	FUNCTION fsbGetOBSERVACION
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.OBSERVACION%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.OBSERVACION);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
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
	FUNCTION fnuGetLISTA_COSTO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.LISTA_COSTO%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.LISTA_COSTO);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.LISTA_COSTO);
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
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.VALOR_COTIZADO%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.VALOR_COTIZADO);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
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
	FUNCTION fdtGetFECHA_VIGENCIA
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.FECHA_VIGENCIA%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.FECHA_VIGENCIA);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
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
	FUNCTION fnuGetID_COTIZACION_OSF
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_OSF%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_COTIZACION_OSF);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.ID_COTIZACION_OSF);
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
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.FECHA_CREACION%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.FECHA_CREACION);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
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
	FUNCTION fdtGetFECHA_ULT_MODIF
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.FECHA_ULT_MODIF%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.FECHA_ULT_MODIF);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.FECHA_ULT_MODIF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSUA_CREACION
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.USUA_CREACION%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.USUA_CREACION);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.USUA_CREACION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_APROBACION
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.FECHA_APROBACION%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.FECHA_APROBACION);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.FECHA_APROBACION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSUA_ULT_MODIF
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.USUA_ULT_MODIF%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.USUA_ULT_MODIF);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.USUA_ULT_MODIF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
  FUNCTION fnuGetPLAN_COMERCIAL_ESPCL
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.PLAN_COMERCIAL_ESPCL%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.PLAN_COMERCIAL_ESPCL);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.PLAN_COMERCIAL_ESPCL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	 FUNCTION fnuGetUND_INSTALADORA_ID
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.UND_INSTALADORA_ID%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.UND_INSTALADORA_ID);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.UND_INSTALADORA_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	 FUNCTION fnuGetUND_CERTIFICADORA_ID
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.UND_CERTIFICADORA_ID%type
	IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.UND_CERTIFICADORA_ID);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.UND_CERTIFICADORA_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

  --INICIO CA 153
  FUNCTION fSBGetFLGOGASO
	(
		inuID_COTIZACION_DETALLADA in LDC_COTIZACION_CONSTRUCT.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_COTIZACION_CONSTRUCT.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COTIZACION_CONSTRUCT.FLGOGASO%type IS
		rcError styLDC_COTIZACION_CONSTRUCT;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.FLGOGASO);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.FLGOGASO);
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
end DALDC_COTIZACION_CONSTRUCT;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_COTIZACION_CONSTRUCT
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_COTIZACION_CONSTRUCT', 'ADM_PERSON'); 
END;
/ 

