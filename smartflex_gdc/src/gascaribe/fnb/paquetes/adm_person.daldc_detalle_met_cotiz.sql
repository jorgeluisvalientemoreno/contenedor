CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_DETALLE_MET_COTIZ
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
    04/05/2024              PAcosta         OSF-2776: Cambio de esquema ADM_PERSON                              
    ****************************************************************/
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type
	)
	IS
		SELECT LDC_DETALLE_MET_COTIZ.*,LDC_DETALLE_MET_COTIZ.rowid
		FROM LDC_DETALLE_MET_COTIZ
		WHERE
		    ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA
		    and ID_PROYECTO = inuID_PROYECTO
		    and ID_PISO = inuID_PISO
		    and ID_TIPO = inuID_TIPO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_DETALLE_MET_COTIZ.*,LDC_DETALLE_MET_COTIZ.rowid
		FROM LDC_DETALLE_MET_COTIZ
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_DETALLE_MET_COTIZ  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_DETALLE_MET_COTIZ is table of styLDC_DETALLE_MET_COTIZ index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_DETALLE_MET_COTIZ;

	/* Tipos referenciando al registro */
	type tytbID_COTIZACION_DETALLADA is table of LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type index by binary_integer;
	type tytbID_PISO is table of LDC_DETALLE_MET_COTIZ.ID_PISO%type index by binary_integer;
	type tytbID_TIPO is table of LDC_DETALLE_MET_COTIZ.ID_TIPO%type index by binary_integer;
	type tytbFLAUTA is table of LDC_DETALLE_MET_COTIZ.FLAUTA%type index by binary_integer;
	type tytbHORNO is table of LDC_DETALLE_MET_COTIZ.HORNO%type index by binary_integer;
	type tytbBBQ is table of LDC_DETALLE_MET_COTIZ.BBQ%type index by binary_integer;
	type tytbESTUFA is table of LDC_DETALLE_MET_COTIZ.ESTUFA%type index by binary_integer;
	type tytbSECADORA is table of LDC_DETALLE_MET_COTIZ.SECADORA%type index by binary_integer;
	type tytbCALENTADOR is table of LDC_DETALLE_MET_COTIZ.CALENTADOR%type index by binary_integer;
	type tytbLONG_VAL_BAJ is table of LDC_DETALLE_MET_COTIZ.LONG_VAL_BAJ%type index by binary_integer;
	type tytbLONG_BAJANTE is table of LDC_DETALLE_MET_COTIZ.LONG_BAJANTE%type index by binary_integer;
	type tytbLONG_BAJ_TAB is table of LDC_DETALLE_MET_COTIZ.LONG_BAJ_TAB%type index by binary_integer;
	type tytbLONG_TABLERO is table of LDC_DETALLE_MET_COTIZ.LONG_TABLERO%type index by binary_integer;
	type tytbCANT_UNID_PRED is table of LDC_DETALLE_MET_COTIZ.CANT_UNID_PRED%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_DETALLE_MET_COTIZ is record
	(
		ID_COTIZACION_DETALLADA   tytbID_COTIZACION_DETALLADA,
		ID_PISO   tytbID_PISO,
		ID_TIPO   tytbID_TIPO,
		FLAUTA   tytbFLAUTA,
		HORNO   tytbHORNO,
		BBQ   tytbBBQ,
		ESTUFA   tytbESTUFA,
		SECADORA   tytbSECADORA,
		CALENTADOR   tytbCALENTADOR,
		LONG_VAL_BAJ   tytbLONG_VAL_BAJ,
		LONG_BAJANTE   tytbLONG_BAJANTE,
		LONG_BAJ_TAB   tytbLONG_BAJ_TAB,
		LONG_TABLERO   tytbLONG_TABLERO,
		CANT_UNID_PRED   tytbCANT_UNID_PRED,
		ID_PROYECTO   tytbID_PROYECTO,
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
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type
	);

	PROCEDURE getRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		orcRecord out nocopy styLDC_DETALLE_MET_COTIZ
	);

	FUNCTION frcGetRcData
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type
	)
	RETURN styLDC_DETALLE_MET_COTIZ;

	FUNCTION frcGetRcData
	RETURN styLDC_DETALLE_MET_COTIZ;

	FUNCTION frcGetRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type
	)
	RETURN styLDC_DETALLE_MET_COTIZ;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_DETALLE_MET_COTIZ
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_DETALLE_MET_COTIZ in styLDC_DETALLE_MET_COTIZ
	);

	PROCEDURE insRecord
	(
		ircLDC_DETALLE_MET_COTIZ in styLDC_DETALLE_MET_COTIZ,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_DETALLE_MET_COTIZ in out nocopy tytbLDC_DETALLE_MET_COTIZ
	);

	PROCEDURE delRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_DETALLE_MET_COTIZ in out nocopy tytbLDC_DETALLE_MET_COTIZ,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_DETALLE_MET_COTIZ in styLDC_DETALLE_MET_COTIZ,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_DETALLE_MET_COTIZ in out nocopy tytbLDC_DETALLE_MET_COTIZ,
		inuLock in number default 1
	);

	PROCEDURE updFLAUTA
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuFLAUTA$ in LDC_DETALLE_MET_COTIZ.FLAUTA%type,
		inuLock in number default 0
	);

	PROCEDURE updHORNO
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuHORNO$ in LDC_DETALLE_MET_COTIZ.HORNO%type,
		inuLock in number default 0
	);

	PROCEDURE updBBQ
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuBBQ$ in LDC_DETALLE_MET_COTIZ.BBQ%type,
		inuLock in number default 0
	);

	PROCEDURE updESTUFA
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuESTUFA$ in LDC_DETALLE_MET_COTIZ.ESTUFA%type,
		inuLock in number default 0
	);

	PROCEDURE updSECADORA
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuSECADORA$ in LDC_DETALLE_MET_COTIZ.SECADORA%type,
		inuLock in number default 0
	);

	PROCEDURE updCALENTADOR
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuCALENTADOR$ in LDC_DETALLE_MET_COTIZ.CALENTADOR%type,
		inuLock in number default 0
	);

	PROCEDURE updLONG_VAL_BAJ
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuLONG_VAL_BAJ$ in LDC_DETALLE_MET_COTIZ.LONG_VAL_BAJ%type,
		inuLock in number default 0
	);

	PROCEDURE updLONG_BAJANTE
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuLONG_BAJANTE$ in LDC_DETALLE_MET_COTIZ.LONG_BAJANTE%type,
		inuLock in number default 0
	);

	PROCEDURE updLONG_BAJ_TAB
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuLONG_BAJ_TAB$ in LDC_DETALLE_MET_COTIZ.LONG_BAJ_TAB%type,
		inuLock in number default 0
	);

	PROCEDURE updLONG_TABLERO
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuLONG_TABLERO$ in LDC_DETALLE_MET_COTIZ.LONG_TABLERO%type,
		inuLock in number default 0
	);

	PROCEDURE updCANT_UNID_PRED
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuCANT_UNID_PRED$ in LDC_DETALLE_MET_COTIZ.CANT_UNID_PRED%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_COTIZACION_DETALLADA
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type;

	FUNCTION fnuGetID_PISO
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.ID_PISO%type;

	FUNCTION fnuGetID_TIPO
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.ID_TIPO%type;

	FUNCTION fnuGetFLAUTA
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.FLAUTA%type;

	FUNCTION fnuGetHORNO
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.HORNO%type;

	FUNCTION fnuGetBBQ
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.BBQ%type;

	FUNCTION fnuGetESTUFA
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.ESTUFA%type;

	FUNCTION fnuGetSECADORA
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.SECADORA%type;

	FUNCTION fnuGetCALENTADOR
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.CALENTADOR%type;

	FUNCTION fnuGetLONG_VAL_BAJ
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.LONG_VAL_BAJ%type;

	FUNCTION fnuGetLONG_BAJANTE
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.LONG_BAJANTE%type;

	FUNCTION fnuGetLONG_BAJ_TAB
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.LONG_BAJ_TAB%type;

	FUNCTION fnuGetLONG_TABLERO
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.LONG_TABLERO%type;

	FUNCTION fnuGetCANT_UNID_PRED
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.CANT_UNID_PRED%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type;


	PROCEDURE LockByPk
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		orcLDC_DETALLE_MET_COTIZ  out styLDC_DETALLE_MET_COTIZ
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_DETALLE_MET_COTIZ  out styLDC_DETALLE_MET_COTIZ
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_DETALLE_MET_COTIZ;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_DETALLE_MET_COTIZ
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_DETALLE_MET_COTIZ';
	 cnuGeEntityId constant varchar2(30) := 2950; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type
	)
	IS
		SELECT LDC_DETALLE_MET_COTIZ.*,LDC_DETALLE_MET_COTIZ.rowid
		FROM LDC_DETALLE_MET_COTIZ
		WHERE  ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA
			and ID_PROYECTO = inuID_PROYECTO
			and ID_PISO = inuID_PISO
			and ID_TIPO = inuID_TIPO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_DETALLE_MET_COTIZ.*,LDC_DETALLE_MET_COTIZ.rowid
		FROM LDC_DETALLE_MET_COTIZ
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_DETALLE_MET_COTIZ is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_DETALLE_MET_COTIZ;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_DETALLE_MET_COTIZ default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_COTIZACION_DETALLADA);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_PROYECTO);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_PISO);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_TIPO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		orcLDC_DETALLE_MET_COTIZ  out styLDC_DETALLE_MET_COTIZ
	)
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

		Open cuLockRcByPk
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_PISO,
			inuID_TIPO
		);

		fetch cuLockRcByPk into orcLDC_DETALLE_MET_COTIZ;
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
		orcLDC_DETALLE_MET_COTIZ  out styLDC_DETALLE_MET_COTIZ
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_DETALLE_MET_COTIZ;
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
		itbLDC_DETALLE_MET_COTIZ  in out nocopy tytbLDC_DETALLE_MET_COTIZ
	)
	IS
	BEGIN
			rcRecOfTab.ID_COTIZACION_DETALLADA.delete;
			rcRecOfTab.ID_PISO.delete;
			rcRecOfTab.ID_TIPO.delete;
			rcRecOfTab.FLAUTA.delete;
			rcRecOfTab.HORNO.delete;
			rcRecOfTab.BBQ.delete;
			rcRecOfTab.ESTUFA.delete;
			rcRecOfTab.SECADORA.delete;
			rcRecOfTab.CALENTADOR.delete;
			rcRecOfTab.LONG_VAL_BAJ.delete;
			rcRecOfTab.LONG_BAJANTE.delete;
			rcRecOfTab.LONG_BAJ_TAB.delete;
			rcRecOfTab.LONG_TABLERO.delete;
			rcRecOfTab.CANT_UNID_PRED.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_DETALLE_MET_COTIZ  in out nocopy tytbLDC_DETALLE_MET_COTIZ,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_DETALLE_MET_COTIZ);

		for n in itbLDC_DETALLE_MET_COTIZ.first .. itbLDC_DETALLE_MET_COTIZ.last loop
			rcRecOfTab.ID_COTIZACION_DETALLADA(n) := itbLDC_DETALLE_MET_COTIZ(n).ID_COTIZACION_DETALLADA;
			rcRecOfTab.ID_PISO(n) := itbLDC_DETALLE_MET_COTIZ(n).ID_PISO;
			rcRecOfTab.ID_TIPO(n) := itbLDC_DETALLE_MET_COTIZ(n).ID_TIPO;
			rcRecOfTab.FLAUTA(n) := itbLDC_DETALLE_MET_COTIZ(n).FLAUTA;
			rcRecOfTab.HORNO(n) := itbLDC_DETALLE_MET_COTIZ(n).HORNO;
			rcRecOfTab.BBQ(n) := itbLDC_DETALLE_MET_COTIZ(n).BBQ;
			rcRecOfTab.ESTUFA(n) := itbLDC_DETALLE_MET_COTIZ(n).ESTUFA;
			rcRecOfTab.SECADORA(n) := itbLDC_DETALLE_MET_COTIZ(n).SECADORA;
			rcRecOfTab.CALENTADOR(n) := itbLDC_DETALLE_MET_COTIZ(n).CALENTADOR;
			rcRecOfTab.LONG_VAL_BAJ(n) := itbLDC_DETALLE_MET_COTIZ(n).LONG_VAL_BAJ;
			rcRecOfTab.LONG_BAJANTE(n) := itbLDC_DETALLE_MET_COTIZ(n).LONG_BAJANTE;
			rcRecOfTab.LONG_BAJ_TAB(n) := itbLDC_DETALLE_MET_COTIZ(n).LONG_BAJ_TAB;
			rcRecOfTab.LONG_TABLERO(n) := itbLDC_DETALLE_MET_COTIZ(n).LONG_TABLERO;
			rcRecOfTab.CANT_UNID_PRED(n) := itbLDC_DETALLE_MET_COTIZ(n).CANT_UNID_PRED;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_DETALLE_MET_COTIZ(n).ID_PROYECTO;
			rcRecOfTab.row_id(n) := itbLDC_DETALLE_MET_COTIZ(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type
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
			inuID_PROYECTO,
			inuID_PISO,
			inuID_TIPO
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
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_COTIZACION_DETALLADA = rcData.ID_COTIZACION_DETALLADA AND
			inuID_PROYECTO = rcData.ID_PROYECTO AND
			inuID_PISO = rcData.ID_PISO AND
			inuID_TIPO = rcData.ID_TIPO
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
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_PISO,
			inuID_TIPO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type
	)
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;		rcError.ID_PROYECTO:=inuID_PROYECTO;		rcError.ID_PISO:=inuID_PISO;		rcError.ID_TIPO:=inuID_TIPO;

		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_PISO,
			inuID_TIPO
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
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type
	)
	IS
	BEGIN
		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_PISO,
			inuID_TIPO
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		orcRecord out nocopy styLDC_DETALLE_MET_COTIZ
	)
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;		rcError.ID_PROYECTO:=inuID_PROYECTO;		rcError.ID_PISO:=inuID_PISO;		rcError.ID_TIPO:=inuID_TIPO;

		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_PISO,
			inuID_TIPO
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type
	)
	RETURN styLDC_DETALLE_MET_COTIZ
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO:=inuID_PROYECTO;
		rcError.ID_PISO:=inuID_PISO;
		rcError.ID_TIPO:=inuID_TIPO;

		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_PISO,
			inuID_TIPO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type
	)
	RETURN styLDC_DETALLE_MET_COTIZ
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO:=inuID_PROYECTO;
		rcError.ID_PISO:=inuID_PISO;
		rcError.ID_TIPO:=inuID_TIPO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_PISO,
			inuID_TIPO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO,
			inuID_PISO,
			inuID_TIPO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_DETALLE_MET_COTIZ
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_DETALLE_MET_COTIZ
	)
	IS
		rfLDC_DETALLE_MET_COTIZ tyrfLDC_DETALLE_MET_COTIZ;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_DETALLE_MET_COTIZ.*, LDC_DETALLE_MET_COTIZ.rowid FROM LDC_DETALLE_MET_COTIZ';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_DETALLE_MET_COTIZ for sbFullQuery;

		fetch rfLDC_DETALLE_MET_COTIZ bulk collect INTO otbResult;

		close rfLDC_DETALLE_MET_COTIZ;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_DETALLE_MET_COTIZ.*, LDC_DETALLE_MET_COTIZ.rowid FROM LDC_DETALLE_MET_COTIZ';
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
		ircLDC_DETALLE_MET_COTIZ in styLDC_DETALLE_MET_COTIZ
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_DETALLE_MET_COTIZ,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_DETALLE_MET_COTIZ in styLDC_DETALLE_MET_COTIZ,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_COTIZACION_DETALLADA');
			raise ex.controlled_error;
		end if;
		if ircLDC_DETALLE_MET_COTIZ.ID_PROYECTO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PROYECTO');
			raise ex.controlled_error;
		end if;
		if ircLDC_DETALLE_MET_COTIZ.ID_PISO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PISO');
			raise ex.controlled_error;
		end if;
		if ircLDC_DETALLE_MET_COTIZ.ID_TIPO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_TIPO');
			raise ex.controlled_error;
		end if;

		insert into LDC_DETALLE_MET_COTIZ
		(
			ID_COTIZACION_DETALLADA,
			ID_PISO,
			ID_TIPO,
			FLAUTA,
			HORNO,
			BBQ,
			ESTUFA,
			SECADORA,
			CALENTADOR,
			LONG_VAL_BAJ,
			LONG_BAJANTE,
			LONG_BAJ_TAB,
			LONG_TABLERO,
			CANT_UNID_PRED,
			ID_PROYECTO
		)
		values
		(
			ircLDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA,
			ircLDC_DETALLE_MET_COTIZ.ID_PISO,
			ircLDC_DETALLE_MET_COTIZ.ID_TIPO,
			ircLDC_DETALLE_MET_COTIZ.FLAUTA,
			ircLDC_DETALLE_MET_COTIZ.HORNO,
			ircLDC_DETALLE_MET_COTIZ.BBQ,
			ircLDC_DETALLE_MET_COTIZ.ESTUFA,
			ircLDC_DETALLE_MET_COTIZ.SECADORA,
			ircLDC_DETALLE_MET_COTIZ.CALENTADOR,
			ircLDC_DETALLE_MET_COTIZ.LONG_VAL_BAJ,
			ircLDC_DETALLE_MET_COTIZ.LONG_BAJANTE,
			ircLDC_DETALLE_MET_COTIZ.LONG_BAJ_TAB,
			ircLDC_DETALLE_MET_COTIZ.LONG_TABLERO,
			ircLDC_DETALLE_MET_COTIZ.CANT_UNID_PRED,
			ircLDC_DETALLE_MET_COTIZ.ID_PROYECTO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_DETALLE_MET_COTIZ));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_DETALLE_MET_COTIZ in out nocopy tytbLDC_DETALLE_MET_COTIZ
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_DETALLE_MET_COTIZ,blUseRowID);
		forall n in iotbLDC_DETALLE_MET_COTIZ.first..iotbLDC_DETALLE_MET_COTIZ.last
			insert into LDC_DETALLE_MET_COTIZ
			(
				ID_COTIZACION_DETALLADA,
				ID_PISO,
				ID_TIPO,
				FLAUTA,
				HORNO,
				BBQ,
				ESTUFA,
				SECADORA,
				CALENTADOR,
				LONG_VAL_BAJ,
				LONG_BAJANTE,
				LONG_BAJ_TAB,
				LONG_TABLERO,
				CANT_UNID_PRED,
				ID_PROYECTO
			)
			values
			(
				rcRecOfTab.ID_COTIZACION_DETALLADA(n),
				rcRecOfTab.ID_PISO(n),
				rcRecOfTab.ID_TIPO(n),
				rcRecOfTab.FLAUTA(n),
				rcRecOfTab.HORNO(n),
				rcRecOfTab.BBQ(n),
				rcRecOfTab.ESTUFA(n),
				rcRecOfTab.SECADORA(n),
				rcRecOfTab.CALENTADOR(n),
				rcRecOfTab.LONG_VAL_BAJ(n),
				rcRecOfTab.LONG_BAJANTE(n),
				rcRecOfTab.LONG_BAJ_TAB(n),
				rcRecOfTab.LONG_TABLERO(n),
				rcRecOfTab.CANT_UNID_PRED(n),
				rcRecOfTab.ID_PROYECTO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_PISO,
				inuID_TIPO,
				rcData
			);
		end if;


		delete
		from LDC_DETALLE_MET_COTIZ
		where
       		ID_COTIZACION_DETALLADA=inuID_COTIZACION_DETALLADA and
       		ID_PROYECTO=inuID_PROYECTO and
       		ID_PISO=inuID_PISO and
       		ID_TIPO=inuID_TIPO;
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
		rcError  styLDC_DETALLE_MET_COTIZ;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_DETALLE_MET_COTIZ
		where
			rowid = iriRowID
		returning
			ID_COTIZACION_DETALLADA,
			ID_PISO,
			ID_TIPO,
			FLAUTA
		into
			rcError.ID_COTIZACION_DETALLADA,
			rcError.ID_PISO,
			rcError.ID_TIPO,
			rcError.FLAUTA;
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
		iotbLDC_DETALLE_MET_COTIZ in out nocopy tytbLDC_DETALLE_MET_COTIZ,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_DETALLE_MET_COTIZ;
	BEGIN
		FillRecordOfTables(iotbLDC_DETALLE_MET_COTIZ, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_DETALLE_MET_COTIZ.first .. iotbLDC_DETALLE_MET_COTIZ.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_DETALLE_MET_COTIZ.first .. iotbLDC_DETALLE_MET_COTIZ.last
				delete
				from LDC_DETALLE_MET_COTIZ
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_DETALLE_MET_COTIZ.first .. iotbLDC_DETALLE_MET_COTIZ.last loop
					LockByPk
					(
						rcRecOfTab.ID_COTIZACION_DETALLADA(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcRecOfTab.ID_PISO(n),
						rcRecOfTab.ID_TIPO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_DETALLE_MET_COTIZ.first .. iotbLDC_DETALLE_MET_COTIZ.last
				delete
				from LDC_DETALLE_MET_COTIZ
				where
		         	ID_COTIZACION_DETALLADA = rcRecOfTab.ID_COTIZACION_DETALLADA(n) and
		         	ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n) and
		         	ID_PISO = rcRecOfTab.ID_PISO(n) and
		         	ID_TIPO = rcRecOfTab.ID_TIPO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_DETALLE_MET_COTIZ in styLDC_DETALLE_MET_COTIZ,
		inuLock in number default 0
	)
	IS
		nuID_COTIZACION_DETALLADA	LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type;
		nuID_PROYECTO	LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type;
		nuID_PISO	LDC_DETALLE_MET_COTIZ.ID_PISO%type;
		nuID_TIPO	LDC_DETALLE_MET_COTIZ.ID_TIPO%type;
	BEGIN
		if ircLDC_DETALLE_MET_COTIZ.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_DETALLE_MET_COTIZ.rowid,rcData);
			end if;
			update LDC_DETALLE_MET_COTIZ
			set
				FLAUTA = ircLDC_DETALLE_MET_COTIZ.FLAUTA,
				HORNO = ircLDC_DETALLE_MET_COTIZ.HORNO,
				BBQ = ircLDC_DETALLE_MET_COTIZ.BBQ,
				ESTUFA = ircLDC_DETALLE_MET_COTIZ.ESTUFA,
				SECADORA = ircLDC_DETALLE_MET_COTIZ.SECADORA,
				CALENTADOR = ircLDC_DETALLE_MET_COTIZ.CALENTADOR,
				LONG_VAL_BAJ = ircLDC_DETALLE_MET_COTIZ.LONG_VAL_BAJ,
				LONG_BAJANTE = ircLDC_DETALLE_MET_COTIZ.LONG_BAJANTE,
				LONG_BAJ_TAB = ircLDC_DETALLE_MET_COTIZ.LONG_BAJ_TAB,
				LONG_TABLERO = ircLDC_DETALLE_MET_COTIZ.LONG_TABLERO,
				CANT_UNID_PRED = ircLDC_DETALLE_MET_COTIZ.CANT_UNID_PRED
			where
				rowid = ircLDC_DETALLE_MET_COTIZ.rowid
			returning
				ID_COTIZACION_DETALLADA,
				ID_PROYECTO,
				ID_PISO,
				ID_TIPO
			into
				nuID_COTIZACION_DETALLADA,
				nuID_PROYECTO,
				nuID_PISO,
				nuID_TIPO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA,
					ircLDC_DETALLE_MET_COTIZ.ID_PROYECTO,
					ircLDC_DETALLE_MET_COTIZ.ID_PISO,
					ircLDC_DETALLE_MET_COTIZ.ID_TIPO,
					rcData
				);
			end if;

			update LDC_DETALLE_MET_COTIZ
			set
				FLAUTA = ircLDC_DETALLE_MET_COTIZ.FLAUTA,
				HORNO = ircLDC_DETALLE_MET_COTIZ.HORNO,
				BBQ = ircLDC_DETALLE_MET_COTIZ.BBQ,
				ESTUFA = ircLDC_DETALLE_MET_COTIZ.ESTUFA,
				SECADORA = ircLDC_DETALLE_MET_COTIZ.SECADORA,
				CALENTADOR = ircLDC_DETALLE_MET_COTIZ.CALENTADOR,
				LONG_VAL_BAJ = ircLDC_DETALLE_MET_COTIZ.LONG_VAL_BAJ,
				LONG_BAJANTE = ircLDC_DETALLE_MET_COTIZ.LONG_BAJANTE,
				LONG_BAJ_TAB = ircLDC_DETALLE_MET_COTIZ.LONG_BAJ_TAB,
				LONG_TABLERO = ircLDC_DETALLE_MET_COTIZ.LONG_TABLERO,
				CANT_UNID_PRED = ircLDC_DETALLE_MET_COTIZ.CANT_UNID_PRED
			where
				ID_COTIZACION_DETALLADA = ircLDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA and
				ID_PROYECTO = ircLDC_DETALLE_MET_COTIZ.ID_PROYECTO and
				ID_PISO = ircLDC_DETALLE_MET_COTIZ.ID_PISO and
				ID_TIPO = ircLDC_DETALLE_MET_COTIZ.ID_TIPO
			returning
				ID_COTIZACION_DETALLADA,
				ID_PROYECTO,
				ID_PISO,
				ID_TIPO
			into
				nuID_COTIZACION_DETALLADA,
				nuID_PROYECTO,
				nuID_PISO,
				nuID_TIPO;
		end if;
		if
			nuID_COTIZACION_DETALLADA is NULL OR
			nuID_PROYECTO is NULL OR
			nuID_PISO is NULL OR
			nuID_TIPO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_DETALLE_MET_COTIZ));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_DETALLE_MET_COTIZ in out nocopy tytbLDC_DETALLE_MET_COTIZ,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_DETALLE_MET_COTIZ;
	BEGIN
		FillRecordOfTables(iotbLDC_DETALLE_MET_COTIZ,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_DETALLE_MET_COTIZ.first .. iotbLDC_DETALLE_MET_COTIZ.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_DETALLE_MET_COTIZ.first .. iotbLDC_DETALLE_MET_COTIZ.last
				update LDC_DETALLE_MET_COTIZ
				set
					FLAUTA = rcRecOfTab.FLAUTA(n),
					HORNO = rcRecOfTab.HORNO(n),
					BBQ = rcRecOfTab.BBQ(n),
					ESTUFA = rcRecOfTab.ESTUFA(n),
					SECADORA = rcRecOfTab.SECADORA(n),
					CALENTADOR = rcRecOfTab.CALENTADOR(n),
					LONG_VAL_BAJ = rcRecOfTab.LONG_VAL_BAJ(n),
					LONG_BAJANTE = rcRecOfTab.LONG_BAJANTE(n),
					LONG_BAJ_TAB = rcRecOfTab.LONG_BAJ_TAB(n),
					LONG_TABLERO = rcRecOfTab.LONG_TABLERO(n),
					CANT_UNID_PRED = rcRecOfTab.CANT_UNID_PRED(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_DETALLE_MET_COTIZ.first .. iotbLDC_DETALLE_MET_COTIZ.last loop
					LockByPk
					(
						rcRecOfTab.ID_COTIZACION_DETALLADA(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcRecOfTab.ID_PISO(n),
						rcRecOfTab.ID_TIPO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_DETALLE_MET_COTIZ.first .. iotbLDC_DETALLE_MET_COTIZ.last
				update LDC_DETALLE_MET_COTIZ
				SET
					FLAUTA = rcRecOfTab.FLAUTA(n),
					HORNO = rcRecOfTab.HORNO(n),
					BBQ = rcRecOfTab.BBQ(n),
					ESTUFA = rcRecOfTab.ESTUFA(n),
					SECADORA = rcRecOfTab.SECADORA(n),
					CALENTADOR = rcRecOfTab.CALENTADOR(n),
					LONG_VAL_BAJ = rcRecOfTab.LONG_VAL_BAJ(n),
					LONG_BAJANTE = rcRecOfTab.LONG_BAJANTE(n),
					LONG_BAJ_TAB = rcRecOfTab.LONG_BAJ_TAB(n),
					LONG_TABLERO = rcRecOfTab.LONG_TABLERO(n),
					CANT_UNID_PRED = rcRecOfTab.CANT_UNID_PRED(n)
				where
					ID_COTIZACION_DETALLADA = rcRecOfTab.ID_COTIZACION_DETALLADA(n) and
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n) and
					ID_PISO = rcRecOfTab.ID_PISO(n) and
					ID_TIPO = rcRecOfTab.ID_TIPO(n)
;
		end if;
	END;
	PROCEDURE updFLAUTA
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuFLAUTA$ in LDC_DETALLE_MET_COTIZ.FLAUTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_PISO,
				inuID_TIPO,
				rcData
			);
		end if;

		update LDC_DETALLE_MET_COTIZ
		set
			FLAUTA = inuFLAUTA$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_PISO = inuID_PISO and
			ID_TIPO = inuID_TIPO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FLAUTA:= inuFLAUTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updHORNO
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuHORNO$ in LDC_DETALLE_MET_COTIZ.HORNO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_PISO,
				inuID_TIPO,
				rcData
			);
		end if;

		update LDC_DETALLE_MET_COTIZ
		set
			HORNO = inuHORNO$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_PISO = inuID_PISO and
			ID_TIPO = inuID_TIPO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.HORNO:= inuHORNO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBBQ
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuBBQ$ in LDC_DETALLE_MET_COTIZ.BBQ%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_PISO,
				inuID_TIPO,
				rcData
			);
		end if;

		update LDC_DETALLE_MET_COTIZ
		set
			BBQ = inuBBQ$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_PISO = inuID_PISO and
			ID_TIPO = inuID_TIPO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BBQ:= inuBBQ$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updESTUFA
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuESTUFA$ in LDC_DETALLE_MET_COTIZ.ESTUFA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_PISO,
				inuID_TIPO,
				rcData
			);
		end if;

		update LDC_DETALLE_MET_COTIZ
		set
			ESTUFA = inuESTUFA$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_PISO = inuID_PISO and
			ID_TIPO = inuID_TIPO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ESTUFA:= inuESTUFA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSECADORA
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuSECADORA$ in LDC_DETALLE_MET_COTIZ.SECADORA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_PISO,
				inuID_TIPO,
				rcData
			);
		end if;

		update LDC_DETALLE_MET_COTIZ
		set
			SECADORA = inuSECADORA$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_PISO = inuID_PISO and
			ID_TIPO = inuID_TIPO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SECADORA:= inuSECADORA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCALENTADOR
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuCALENTADOR$ in LDC_DETALLE_MET_COTIZ.CALENTADOR%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_PISO,
				inuID_TIPO,
				rcData
			);
		end if;

		update LDC_DETALLE_MET_COTIZ
		set
			CALENTADOR = inuCALENTADOR$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_PISO = inuID_PISO and
			ID_TIPO = inuID_TIPO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CALENTADOR:= inuCALENTADOR$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLONG_VAL_BAJ
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuLONG_VAL_BAJ$ in LDC_DETALLE_MET_COTIZ.LONG_VAL_BAJ%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_PISO,
				inuID_TIPO,
				rcData
			);
		end if;

		update LDC_DETALLE_MET_COTIZ
		set
			LONG_VAL_BAJ = inuLONG_VAL_BAJ$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_PISO = inuID_PISO and
			ID_TIPO = inuID_TIPO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LONG_VAL_BAJ:= inuLONG_VAL_BAJ$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLONG_BAJANTE
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuLONG_BAJANTE$ in LDC_DETALLE_MET_COTIZ.LONG_BAJANTE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_PISO,
				inuID_TIPO,
				rcData
			);
		end if;

		update LDC_DETALLE_MET_COTIZ
		set
			LONG_BAJANTE = inuLONG_BAJANTE$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_PISO = inuID_PISO and
			ID_TIPO = inuID_TIPO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LONG_BAJANTE:= inuLONG_BAJANTE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLONG_BAJ_TAB
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuLONG_BAJ_TAB$ in LDC_DETALLE_MET_COTIZ.LONG_BAJ_TAB%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_PISO,
				inuID_TIPO,
				rcData
			);
		end if;

		update LDC_DETALLE_MET_COTIZ
		set
			LONG_BAJ_TAB = inuLONG_BAJ_TAB$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_PISO = inuID_PISO and
			ID_TIPO = inuID_TIPO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LONG_BAJ_TAB:= inuLONG_BAJ_TAB$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLONG_TABLERO
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuLONG_TABLERO$ in LDC_DETALLE_MET_COTIZ.LONG_TABLERO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_PISO,
				inuID_TIPO,
				rcData
			);
		end if;

		update LDC_DETALLE_MET_COTIZ
		set
			LONG_TABLERO = inuLONG_TABLERO$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_PISO = inuID_PISO and
			ID_TIPO = inuID_TIPO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LONG_TABLERO:= inuLONG_TABLERO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCANT_UNID_PRED
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuCANT_UNID_PRED$ in LDC_DETALLE_MET_COTIZ.CANT_UNID_PRED%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;
		if inuLock=1 then
			LockByPk
			(
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				inuID_PISO,
				inuID_TIPO,
				rcData
			);
		end if;

		update LDC_DETALLE_MET_COTIZ
		set
			CANT_UNID_PRED = inuCANT_UNID_PRED$
		where
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO and
			ID_PISO = inuID_PISO and
			ID_TIPO = inuID_TIPO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CANT_UNID_PRED:= inuCANT_UNID_PRED$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_COTIZACION_DETALLADA
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
			 )
		then
			 return(rcData.ID_COTIZACION_DETALLADA);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
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
	FUNCTION fnuGetID_PISO
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.ID_PISO%type
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
			 )
		then
			 return(rcData.ID_PISO);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
		);
		return(rcData.ID_PISO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_TIPO
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.ID_TIPO%type
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
			 )
		then
			 return(rcData.ID_TIPO);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
		);
		return(rcData.ID_TIPO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetFLAUTA
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.FLAUTA%type
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
			 )
		then
			 return(rcData.FLAUTA);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
		);
		return(rcData.FLAUTA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetHORNO
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.HORNO%type
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
			 )
		then
			 return(rcData.HORNO);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
		);
		return(rcData.HORNO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetBBQ
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.BBQ%type
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
			 )
		then
			 return(rcData.BBQ);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
		);
		return(rcData.BBQ);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetESTUFA
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.ESTUFA%type
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
			 )
		then
			 return(rcData.ESTUFA);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
		);
		return(rcData.ESTUFA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSECADORA
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.SECADORA%type
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
			 )
		then
			 return(rcData.SECADORA);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
		);
		return(rcData.SECADORA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCALENTADOR
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.CALENTADOR%type
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
			 )
		then
			 return(rcData.CALENTADOR);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
		);
		return(rcData.CALENTADOR);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLONG_VAL_BAJ
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.LONG_VAL_BAJ%type
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
			 )
		then
			 return(rcData.LONG_VAL_BAJ);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
		);
		return(rcData.LONG_VAL_BAJ);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLONG_BAJANTE
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.LONG_BAJANTE%type
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
			 )
		then
			 return(rcData.LONG_BAJANTE);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
		);
		return(rcData.LONG_BAJANTE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLONG_BAJ_TAB
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.LONG_BAJ_TAB%type
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
			 )
		then
			 return(rcData.LONG_BAJ_TAB);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
		);
		return(rcData.LONG_BAJ_TAB);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLONG_TABLERO
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.LONG_TABLERO%type
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
			 )
		then
			 return(rcData.LONG_TABLERO);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
		);
		return(rcData.LONG_TABLERO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCANT_UNID_PRED
	(
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.CANT_UNID_PRED%type
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
			 )
		then
			 return(rcData.CANT_UNID_PRED);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
		);
		return(rcData.CANT_UNID_PRED);
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
		inuID_COTIZACION_DETALLADA in LDC_DETALLE_MET_COTIZ.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type,
		inuID_PISO in LDC_DETALLE_MET_COTIZ.ID_PISO%type,
		inuID_TIPO in LDC_DETALLE_MET_COTIZ.ID_TIPO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_DETALLE_MET_COTIZ.ID_PROYECTO%type
	IS
		rcError styLDC_DETALLE_MET_COTIZ;
	BEGIN

		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_TIPO := inuID_TIPO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
			 )
		then
			 return(rcData.ID_PROYECTO);
		end if;
		Load
		(
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO,
		 		inuID_PISO,
		 		inuID_TIPO
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
	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALDC_DETALLE_MET_COTIZ;
/
PROMPT Otorgando permisos de ejecucion a DALDC_DETALLE_MET_COTIZ
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_DETALLE_MET_COTIZ', 'ADM_PERSON');
END;
/