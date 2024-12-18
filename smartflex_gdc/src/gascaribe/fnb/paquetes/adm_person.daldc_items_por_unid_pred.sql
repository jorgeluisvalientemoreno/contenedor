CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_ITEMS_POR_UNID_PRED
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
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type
	)
	IS
		SELECT LDC_ITEMS_POR_UNID_PRED.*,LDC_ITEMS_POR_UNID_PRED.rowid
		FROM LDC_ITEMS_POR_UNID_PRED
		WHERE
		    ID_TORRE = inuID_TORRE
		    and ID_PISO = inuID_PISO
		    and ID_PROYECTO = inuID_PROYECTO
		    and ID_ITEM_COTIZADO = inuID_ITEM_COTIZADO
		    and ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA
		    and ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ITEMS_POR_UNID_PRED.*,LDC_ITEMS_POR_UNID_PRED.rowid
		FROM LDC_ITEMS_POR_UNID_PRED
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ITEMS_POR_UNID_PRED  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ITEMS_POR_UNID_PRED is table of styLDC_ITEMS_POR_UNID_PRED index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ITEMS_POR_UNID_PRED;

	/* Tipos referenciando al registro */
	type tytbID_TORRE is table of LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type index by binary_integer;
	type tytbID_COTIZACION_DETALLADA is table of LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type index by binary_integer;
	type tytbID_UNIDAD_PREDIAL is table of LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type index by binary_integer;
	type tytbID_ITEM is table of LDC_ITEMS_POR_UNID_PRED.ID_ITEM%type index by binary_integer;
	type tytbCANTIDAD is table of LDC_ITEMS_POR_UNID_PRED.CANTIDAD%type index by binary_integer;
	type tytbPRECIO is table of LDC_ITEMS_POR_UNID_PRED.PRECIO%type index by binary_integer;
	type tytbID_TIPO_TRABAJO is table of LDC_ITEMS_POR_UNID_PRED.ID_TIPO_TRABAJO%type index by binary_integer;
	type tytbCOSTO is table of LDC_ITEMS_POR_UNID_PRED.COSTO%type index by binary_integer;
	type tytbID_VAL_FIJO is table of LDC_ITEMS_POR_UNID_PRED.ID_VAL_FIJO%type index by binary_integer;
	type tytbPRECIO_TOTAL is table of LDC_ITEMS_POR_UNID_PRED.PRECIO_TOTAL%type index by binary_integer;
	type tytbCOSTO_TOTAL is table of LDC_ITEMS_POR_UNID_PRED.COSTO_TOTAL%type index by binary_integer;
	type tytbID_ITEM_COTIZADO is table of LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type index by binary_integer;
	type tytbTIPO_ITEM is table of LDC_ITEMS_POR_UNID_PRED.TIPO_ITEM%type index by binary_integer;
	type tytbID_PISO is table of LDC_ITEMS_POR_UNID_PRED.ID_PISO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ITEMS_POR_UNID_PRED is record
	(
		ID_TORRE   tytbID_TORRE,
		ID_PROYECTO   tytbID_PROYECTO,
		ID_COTIZACION_DETALLADA   tytbID_COTIZACION_DETALLADA,
		ID_UNIDAD_PREDIAL   tytbID_UNIDAD_PREDIAL,
		ID_ITEM   tytbID_ITEM,
		CANTIDAD   tytbCANTIDAD,
		PRECIO   tytbPRECIO,
		ID_TIPO_TRABAJO   tytbID_TIPO_TRABAJO,
		COSTO   tytbCOSTO,
		ID_VAL_FIJO   tytbID_VAL_FIJO,
		PRECIO_TOTAL   tytbPRECIO_TOTAL,
		COSTO_TOTAL   tytbCOSTO_TOTAL,
		ID_ITEM_COTIZADO   tytbID_ITEM_COTIZADO,
		TIPO_ITEM   tytbTIPO_ITEM,
		ID_PISO   tytbID_PISO,
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
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type
	);

	PROCEDURE getRecord
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		orcRecord out nocopy styLDC_ITEMS_POR_UNID_PRED
	);

	FUNCTION frcGetRcData
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type
	)
	RETURN styLDC_ITEMS_POR_UNID_PRED;

	FUNCTION frcGetRcData
	RETURN styLDC_ITEMS_POR_UNID_PRED;

	FUNCTION frcGetRecord
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type
	)
	RETURN styLDC_ITEMS_POR_UNID_PRED;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ITEMS_POR_UNID_PRED
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ITEMS_POR_UNID_PRED in styLDC_ITEMS_POR_UNID_PRED
	);

	PROCEDURE insRecord
	(
		ircLDC_ITEMS_POR_UNID_PRED in styLDC_ITEMS_POR_UNID_PRED,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ITEMS_POR_UNID_PRED in out nocopy tytbLDC_ITEMS_POR_UNID_PRED
	);

	PROCEDURE delRecord
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ITEMS_POR_UNID_PRED in out nocopy tytbLDC_ITEMS_POR_UNID_PRED,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ITEMS_POR_UNID_PRED in styLDC_ITEMS_POR_UNID_PRED,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ITEMS_POR_UNID_PRED in out nocopy tytbLDC_ITEMS_POR_UNID_PRED,
		inuLock in number default 1
	);

	PROCEDURE updID_ITEM
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuID_ITEM$ in LDC_ITEMS_POR_UNID_PRED.ID_ITEM%type,
		inuLock in number default 0
	);

	PROCEDURE updCANTIDAD
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuCANTIDAD$ in LDC_ITEMS_POR_UNID_PRED.CANTIDAD%type,
		inuLock in number default 0
	);

	PROCEDURE updPRECIO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuPRECIO$ in LDC_ITEMS_POR_UNID_PRED.PRECIO%type,
		inuLock in number default 0
	);

	PROCEDURE updID_TIPO_TRABAJO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuID_TIPO_TRABAJO$ in LDC_ITEMS_POR_UNID_PRED.ID_TIPO_TRABAJO%type,
		inuLock in number default 0
	);

	PROCEDURE updCOSTO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuCOSTO$ in LDC_ITEMS_POR_UNID_PRED.COSTO%type,
		inuLock in number default 0
	);

	PROCEDURE updID_VAL_FIJO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuID_VAL_FIJO$ in LDC_ITEMS_POR_UNID_PRED.ID_VAL_FIJO%type,
		inuLock in number default 0
	);

	PROCEDURE updPRECIO_TOTAL
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuPRECIO_TOTAL$ in LDC_ITEMS_POR_UNID_PRED.PRECIO_TOTAL%type,
		inuLock in number default 0
	);

	PROCEDURE updCOSTO_TOTAL
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuCOSTO_TOTAL$ in LDC_ITEMS_POR_UNID_PRED.COSTO_TOTAL%type,
		inuLock in number default 0
	);

	PROCEDURE updTIPO_ITEM
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		isbTIPO_ITEM$ in LDC_ITEMS_POR_UNID_PRED.TIPO_ITEM%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_TORRE
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type;

	FUNCTION fnuGetID_COTIZACION_DETALLADA
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type;

	FUNCTION fnuGetID_UNIDAD_PREDIAL
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type;

	FUNCTION fnuGetID_ITEM
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_ITEM%type;

	FUNCTION fnuGetCANTIDAD
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.CANTIDAD%type;

	FUNCTION fnuGetPRECIO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.PRECIO%type;

	FUNCTION fnuGetID_TIPO_TRABAJO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_TIPO_TRABAJO%type;

	FUNCTION fnuGetCOSTO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.COSTO%type;

	FUNCTION fnuGetID_VAL_FIJO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_VAL_FIJO%type;

	FUNCTION fnuGetPRECIO_TOTAL
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.PRECIO_TOTAL%type;

	FUNCTION fnuGetCOSTO_TOTAL
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.COSTO_TOTAL%type;

	FUNCTION fnuGetID_ITEM_COTIZADO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type;

	FUNCTION fsbGetTIPO_ITEM
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.TIPO_ITEM%type;

	FUNCTION fnuGetID_PISO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_PISO%type;


	PROCEDURE LockByPk
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		orcLDC_ITEMS_POR_UNID_PRED  out styLDC_ITEMS_POR_UNID_PRED
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ITEMS_POR_UNID_PRED  out styLDC_ITEMS_POR_UNID_PRED
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ITEMS_POR_UNID_PRED;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_ITEMS_POR_UNID_PRED
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ITEMS_POR_UNID_PRED';
	 cnuGeEntityId constant varchar2(30) := 2870; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type
	)
	IS
		SELECT LDC_ITEMS_POR_UNID_PRED.*,LDC_ITEMS_POR_UNID_PRED.rowid
		FROM LDC_ITEMS_POR_UNID_PRED
		WHERE  ID_TORRE = inuID_TORRE
			and ID_PISO = inuID_PISO
			and ID_PROYECTO = inuID_PROYECTO
			and ID_ITEM_COTIZADO = inuID_ITEM_COTIZADO
			and ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA
			and ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ITEMS_POR_UNID_PRED.*,LDC_ITEMS_POR_UNID_PRED.rowid
		FROM LDC_ITEMS_POR_UNID_PRED
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ITEMS_POR_UNID_PRED is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ITEMS_POR_UNID_PRED;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ITEMS_POR_UNID_PRED default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_TORRE);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_PISO);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_PROYECTO);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_ITEM_COTIZADO);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_COTIZACION_DETALLADA);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_UNIDAD_PREDIAL);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		orcLDC_ITEMS_POR_UNID_PRED  out styLDC_ITEMS_POR_UNID_PRED
	)
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

		Open cuLockRcByPk
		(
			inuID_TORRE,
			inuID_PISO,
			inuID_PROYECTO,
			inuID_ITEM_COTIZADO,
			inuID_COTIZACION_DETALLADA,
			inuID_UNIDAD_PREDIAL
		);

		fetch cuLockRcByPk into orcLDC_ITEMS_POR_UNID_PRED;
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
		orcLDC_ITEMS_POR_UNID_PRED  out styLDC_ITEMS_POR_UNID_PRED
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ITEMS_POR_UNID_PRED;
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
		itbLDC_ITEMS_POR_UNID_PRED  in out nocopy tytbLDC_ITEMS_POR_UNID_PRED
	)
	IS
	BEGIN
			rcRecOfTab.ID_TORRE.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.ID_COTIZACION_DETALLADA.delete;
			rcRecOfTab.ID_UNIDAD_PREDIAL.delete;
			rcRecOfTab.ID_ITEM.delete;
			rcRecOfTab.CANTIDAD.delete;
			rcRecOfTab.PRECIO.delete;
			rcRecOfTab.ID_TIPO_TRABAJO.delete;
			rcRecOfTab.COSTO.delete;
			rcRecOfTab.ID_VAL_FIJO.delete;
			rcRecOfTab.PRECIO_TOTAL.delete;
			rcRecOfTab.COSTO_TOTAL.delete;
			rcRecOfTab.ID_ITEM_COTIZADO.delete;
			rcRecOfTab.TIPO_ITEM.delete;
			rcRecOfTab.ID_PISO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ITEMS_POR_UNID_PRED  in out nocopy tytbLDC_ITEMS_POR_UNID_PRED,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ITEMS_POR_UNID_PRED);

		for n in itbLDC_ITEMS_POR_UNID_PRED.first .. itbLDC_ITEMS_POR_UNID_PRED.last loop
			rcRecOfTab.ID_TORRE(n) := itbLDC_ITEMS_POR_UNID_PRED(n).ID_TORRE;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_ITEMS_POR_UNID_PRED(n).ID_PROYECTO;
			rcRecOfTab.ID_COTIZACION_DETALLADA(n) := itbLDC_ITEMS_POR_UNID_PRED(n).ID_COTIZACION_DETALLADA;
			rcRecOfTab.ID_UNIDAD_PREDIAL(n) := itbLDC_ITEMS_POR_UNID_PRED(n).ID_UNIDAD_PREDIAL;
			rcRecOfTab.ID_ITEM(n) := itbLDC_ITEMS_POR_UNID_PRED(n).ID_ITEM;
			rcRecOfTab.CANTIDAD(n) := itbLDC_ITEMS_POR_UNID_PRED(n).CANTIDAD;
			rcRecOfTab.PRECIO(n) := itbLDC_ITEMS_POR_UNID_PRED(n).PRECIO;
			rcRecOfTab.ID_TIPO_TRABAJO(n) := itbLDC_ITEMS_POR_UNID_PRED(n).ID_TIPO_TRABAJO;
			rcRecOfTab.COSTO(n) := itbLDC_ITEMS_POR_UNID_PRED(n).COSTO;
			rcRecOfTab.ID_VAL_FIJO(n) := itbLDC_ITEMS_POR_UNID_PRED(n).ID_VAL_FIJO;
			rcRecOfTab.PRECIO_TOTAL(n) := itbLDC_ITEMS_POR_UNID_PRED(n).PRECIO_TOTAL;
			rcRecOfTab.COSTO_TOTAL(n) := itbLDC_ITEMS_POR_UNID_PRED(n).COSTO_TOTAL;
			rcRecOfTab.ID_ITEM_COTIZADO(n) := itbLDC_ITEMS_POR_UNID_PRED(n).ID_ITEM_COTIZADO;
			rcRecOfTab.TIPO_ITEM(n) := itbLDC_ITEMS_POR_UNID_PRED(n).TIPO_ITEM;
			rcRecOfTab.ID_PISO(n) := itbLDC_ITEMS_POR_UNID_PRED(n).ID_PISO;
			rcRecOfTab.row_id(n) := itbLDC_ITEMS_POR_UNID_PRED(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_TORRE,
			inuID_PISO,
			inuID_PROYECTO,
			inuID_ITEM_COTIZADO,
			inuID_COTIZACION_DETALLADA,
			inuID_UNIDAD_PREDIAL
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
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_TORRE = rcData.ID_TORRE AND
			inuID_PISO = rcData.ID_PISO AND
			inuID_PROYECTO = rcData.ID_PROYECTO AND
			inuID_ITEM_COTIZADO = rcData.ID_ITEM_COTIZADO AND
			inuID_COTIZACION_DETALLADA = rcData.ID_COTIZACION_DETALLADA AND
			inuID_UNIDAD_PREDIAL = rcData.ID_UNIDAD_PREDIAL
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
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_TORRE,
			inuID_PISO,
			inuID_PROYECTO,
			inuID_ITEM_COTIZADO,
			inuID_COTIZACION_DETALLADA,
			inuID_UNIDAD_PREDIAL
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type
	)
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN		rcError.ID_TORRE:=inuID_TORRE;		rcError.ID_PISO:=inuID_PISO;		rcError.ID_PROYECTO:=inuID_PROYECTO;		rcError.ID_ITEM_COTIZADO:=inuID_ITEM_COTIZADO;		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;		rcError.ID_UNIDAD_PREDIAL:=inuID_UNIDAD_PREDIAL;

		Load
		(
			inuID_TORRE,
			inuID_PISO,
			inuID_PROYECTO,
			inuID_ITEM_COTIZADO,
			inuID_COTIZACION_DETALLADA,
			inuID_UNIDAD_PREDIAL
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
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type
	)
	IS
	BEGIN
		Load
		(
			inuID_TORRE,
			inuID_PISO,
			inuID_PROYECTO,
			inuID_ITEM_COTIZADO,
			inuID_COTIZACION_DETALLADA,
			inuID_UNIDAD_PREDIAL
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		orcRecord out nocopy styLDC_ITEMS_POR_UNID_PRED
	)
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN		rcError.ID_TORRE:=inuID_TORRE;		rcError.ID_PISO:=inuID_PISO;		rcError.ID_PROYECTO:=inuID_PROYECTO;		rcError.ID_ITEM_COTIZADO:=inuID_ITEM_COTIZADO;		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;		rcError.ID_UNIDAD_PREDIAL:=inuID_UNIDAD_PREDIAL;

		Load
		(
			inuID_TORRE,
			inuID_PISO,
			inuID_PROYECTO,
			inuID_ITEM_COTIZADO,
			inuID_COTIZACION_DETALLADA,
			inuID_UNIDAD_PREDIAL
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type
	)
	RETURN styLDC_ITEMS_POR_UNID_PRED
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN
		rcError.ID_TORRE:=inuID_TORRE;
		rcError.ID_PISO:=inuID_PISO;
		rcError.ID_PROYECTO:=inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO:=inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL:=inuID_UNIDAD_PREDIAL;

		Load
		(
			inuID_TORRE,
			inuID_PISO,
			inuID_PROYECTO,
			inuID_ITEM_COTIZADO,
			inuID_COTIZACION_DETALLADA,
			inuID_UNIDAD_PREDIAL
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type
	)
	RETURN styLDC_ITEMS_POR_UNID_PRED
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN
		rcError.ID_TORRE:=inuID_TORRE;
		rcError.ID_PISO:=inuID_PISO;
		rcError.ID_PROYECTO:=inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO:=inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL:=inuID_UNIDAD_PREDIAL;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_TORRE,
			inuID_PISO,
			inuID_PROYECTO,
			inuID_ITEM_COTIZADO,
			inuID_COTIZACION_DETALLADA,
			inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_TORRE,
			inuID_PISO,
			inuID_PROYECTO,
			inuID_ITEM_COTIZADO,
			inuID_COTIZACION_DETALLADA,
			inuID_UNIDAD_PREDIAL
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_ITEMS_POR_UNID_PRED
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ITEMS_POR_UNID_PRED
	)
	IS
		rfLDC_ITEMS_POR_UNID_PRED tyrfLDC_ITEMS_POR_UNID_PRED;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ITEMS_POR_UNID_PRED.*, LDC_ITEMS_POR_UNID_PRED.rowid FROM LDC_ITEMS_POR_UNID_PRED';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ITEMS_POR_UNID_PRED for sbFullQuery;

		fetch rfLDC_ITEMS_POR_UNID_PRED bulk collect INTO otbResult;

		close rfLDC_ITEMS_POR_UNID_PRED;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ITEMS_POR_UNID_PRED.*, LDC_ITEMS_POR_UNID_PRED.rowid FROM LDC_ITEMS_POR_UNID_PRED';
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
		ircLDC_ITEMS_POR_UNID_PRED in styLDC_ITEMS_POR_UNID_PRED
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ITEMS_POR_UNID_PRED,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ITEMS_POR_UNID_PRED in styLDC_ITEMS_POR_UNID_PRED,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ITEMS_POR_UNID_PRED.ID_TORRE is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_TORRE');
			raise ex.controlled_error;
		end if;
		if ircLDC_ITEMS_POR_UNID_PRED.ID_PISO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PISO');
			raise ex.controlled_error;
		end if;
		if ircLDC_ITEMS_POR_UNID_PRED.ID_PROYECTO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PROYECTO');
			raise ex.controlled_error;
		end if;
		if ircLDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_ITEM_COTIZADO');
			raise ex.controlled_error;
		end if;
		if ircLDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_COTIZACION_DETALLADA');
			raise ex.controlled_error;
		end if;
		if ircLDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_UNIDAD_PREDIAL');
			raise ex.controlled_error;
		end if;

		insert into LDC_ITEMS_POR_UNID_PRED
		(
			ID_TORRE,
			ID_PROYECTO,
			ID_COTIZACION_DETALLADA,
			ID_UNIDAD_PREDIAL,
			ID_ITEM,
			CANTIDAD,
			PRECIO,
			ID_TIPO_TRABAJO,
			COSTO,
			ID_VAL_FIJO,
			PRECIO_TOTAL,
			COSTO_TOTAL,
			ID_ITEM_COTIZADO,
			TIPO_ITEM,
			ID_PISO
		)
		values
		(
			ircLDC_ITEMS_POR_UNID_PRED.ID_TORRE,
			ircLDC_ITEMS_POR_UNID_PRED.ID_PROYECTO,
			ircLDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA,
			ircLDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL,
			ircLDC_ITEMS_POR_UNID_PRED.ID_ITEM,
			ircLDC_ITEMS_POR_UNID_PRED.CANTIDAD,
			ircLDC_ITEMS_POR_UNID_PRED.PRECIO,
			ircLDC_ITEMS_POR_UNID_PRED.ID_TIPO_TRABAJO,
			ircLDC_ITEMS_POR_UNID_PRED.COSTO,
			ircLDC_ITEMS_POR_UNID_PRED.ID_VAL_FIJO,
			ircLDC_ITEMS_POR_UNID_PRED.PRECIO_TOTAL,
			ircLDC_ITEMS_POR_UNID_PRED.COSTO_TOTAL,
			ircLDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO,
			ircLDC_ITEMS_POR_UNID_PRED.TIPO_ITEM,
			ircLDC_ITEMS_POR_UNID_PRED.ID_PISO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ITEMS_POR_UNID_PRED));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ITEMS_POR_UNID_PRED in out nocopy tytbLDC_ITEMS_POR_UNID_PRED
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEMS_POR_UNID_PRED,blUseRowID);
		forall n in iotbLDC_ITEMS_POR_UNID_PRED.first..iotbLDC_ITEMS_POR_UNID_PRED.last
			insert into LDC_ITEMS_POR_UNID_PRED
			(
				ID_TORRE,
				ID_PROYECTO,
				ID_COTIZACION_DETALLADA,
				ID_UNIDAD_PREDIAL,
				ID_ITEM,
				CANTIDAD,
				PRECIO,
				ID_TIPO_TRABAJO,
				COSTO,
				ID_VAL_FIJO,
				PRECIO_TOTAL,
				COSTO_TOTAL,
				ID_ITEM_COTIZADO,
				TIPO_ITEM,
				ID_PISO
			)
			values
			(
				rcRecOfTab.ID_TORRE(n),
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.ID_COTIZACION_DETALLADA(n),
				rcRecOfTab.ID_UNIDAD_PREDIAL(n),
				rcRecOfTab.ID_ITEM(n),
				rcRecOfTab.CANTIDAD(n),
				rcRecOfTab.PRECIO(n),
				rcRecOfTab.ID_TIPO_TRABAJO(n),
				rcRecOfTab.COSTO(n),
				rcRecOfTab.ID_VAL_FIJO(n),
				rcRecOfTab.PRECIO_TOTAL(n),
				rcRecOfTab.COSTO_TOTAL(n),
				rcRecOfTab.ID_ITEM_COTIZADO(n),
				rcRecOfTab.TIPO_ITEM(n),
				rcRecOfTab.ID_PISO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

		if inuLock=1 then
			LockByPk
			(
				inuID_TORRE,
				inuID_PISO,
				inuID_PROYECTO,
				inuID_ITEM_COTIZADO,
				inuID_COTIZACION_DETALLADA,
				inuID_UNIDAD_PREDIAL,
				rcData
			);
		end if;


		delete
		from LDC_ITEMS_POR_UNID_PRED
		where
       		ID_TORRE=inuID_TORRE and
       		ID_PISO=inuID_PISO and
       		ID_PROYECTO=inuID_PROYECTO and
       		ID_ITEM_COTIZADO=inuID_ITEM_COTIZADO and
       		ID_COTIZACION_DETALLADA=inuID_COTIZACION_DETALLADA and
       		ID_UNIDAD_PREDIAL=inuID_UNIDAD_PREDIAL;
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
		rcError  styLDC_ITEMS_POR_UNID_PRED;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ITEMS_POR_UNID_PRED
		where
			rowid = iriRowID
		returning
			ID_TORRE,
			ID_PROYECTO,
			ID_COTIZACION_DETALLADA,
			ID_UNIDAD_PREDIAL,
			ID_ITEM,
			CANTIDAD
		into
			rcError.ID_TORRE,
			rcError.ID_PROYECTO,
			rcError.ID_COTIZACION_DETALLADA,
			rcError.ID_UNIDAD_PREDIAL,
			rcError.ID_ITEM,
			rcError.CANTIDAD;
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
		iotbLDC_ITEMS_POR_UNID_PRED in out nocopy tytbLDC_ITEMS_POR_UNID_PRED,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ITEMS_POR_UNID_PRED;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEMS_POR_UNID_PRED, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_POR_UNID_PRED.first .. iotbLDC_ITEMS_POR_UNID_PRED.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_POR_UNID_PRED.first .. iotbLDC_ITEMS_POR_UNID_PRED.last
				delete
				from LDC_ITEMS_POR_UNID_PRED
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_POR_UNID_PRED.first .. iotbLDC_ITEMS_POR_UNID_PRED.last loop
					LockByPk
					(
						rcRecOfTab.ID_TORRE(n),
						rcRecOfTab.ID_PISO(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcRecOfTab.ID_ITEM_COTIZADO(n),
						rcRecOfTab.ID_COTIZACION_DETALLADA(n),
						rcRecOfTab.ID_UNIDAD_PREDIAL(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_POR_UNID_PRED.first .. iotbLDC_ITEMS_POR_UNID_PRED.last
				delete
				from LDC_ITEMS_POR_UNID_PRED
				where
		         	ID_TORRE = rcRecOfTab.ID_TORRE(n) and
		         	ID_PISO = rcRecOfTab.ID_PISO(n) and
		         	ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n) and
		         	ID_ITEM_COTIZADO = rcRecOfTab.ID_ITEM_COTIZADO(n) and
		         	ID_COTIZACION_DETALLADA = rcRecOfTab.ID_COTIZACION_DETALLADA(n) and
		         	ID_UNIDAD_PREDIAL = rcRecOfTab.ID_UNIDAD_PREDIAL(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_ITEMS_POR_UNID_PRED in styLDC_ITEMS_POR_UNID_PRED,
		inuLock in number default 0
	)
	IS
		nuID_TORRE	LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type;
		nuID_PISO	LDC_ITEMS_POR_UNID_PRED.ID_PISO%type;
		nuID_PROYECTO	LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type;
		nuID_ITEM_COTIZADO	LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type;
		nuID_COTIZACION_DETALLADA	LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type;
		nuID_UNIDAD_PREDIAL	LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type;
	BEGIN
		if ircLDC_ITEMS_POR_UNID_PRED.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ITEMS_POR_UNID_PRED.rowid,rcData);
			end if;
			update LDC_ITEMS_POR_UNID_PRED
			set
				ID_ITEM = ircLDC_ITEMS_POR_UNID_PRED.ID_ITEM,
				CANTIDAD = ircLDC_ITEMS_POR_UNID_PRED.CANTIDAD,
				PRECIO = ircLDC_ITEMS_POR_UNID_PRED.PRECIO,
				ID_TIPO_TRABAJO = ircLDC_ITEMS_POR_UNID_PRED.ID_TIPO_TRABAJO,
				COSTO = ircLDC_ITEMS_POR_UNID_PRED.COSTO,
				ID_VAL_FIJO = ircLDC_ITEMS_POR_UNID_PRED.ID_VAL_FIJO,
				PRECIO_TOTAL = ircLDC_ITEMS_POR_UNID_PRED.PRECIO_TOTAL,
				COSTO_TOTAL = ircLDC_ITEMS_POR_UNID_PRED.COSTO_TOTAL,
				TIPO_ITEM = ircLDC_ITEMS_POR_UNID_PRED.TIPO_ITEM
			where
				rowid = ircLDC_ITEMS_POR_UNID_PRED.rowid
			returning
				ID_TORRE,
				ID_PISO,
				ID_PROYECTO,
				ID_ITEM_COTIZADO,
				ID_COTIZACION_DETALLADA,
				ID_UNIDAD_PREDIAL
			into
				nuID_TORRE,
				nuID_PISO,
				nuID_PROYECTO,
				nuID_ITEM_COTIZADO,
				nuID_COTIZACION_DETALLADA,
				nuID_UNIDAD_PREDIAL;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ITEMS_POR_UNID_PRED.ID_TORRE,
					ircLDC_ITEMS_POR_UNID_PRED.ID_PISO,
					ircLDC_ITEMS_POR_UNID_PRED.ID_PROYECTO,
					ircLDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO,
					ircLDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA,
					ircLDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL,
					rcData
				);
			end if;

			update LDC_ITEMS_POR_UNID_PRED
			set
				ID_ITEM = ircLDC_ITEMS_POR_UNID_PRED.ID_ITEM,
				CANTIDAD = ircLDC_ITEMS_POR_UNID_PRED.CANTIDAD,
				PRECIO = ircLDC_ITEMS_POR_UNID_PRED.PRECIO,
				ID_TIPO_TRABAJO = ircLDC_ITEMS_POR_UNID_PRED.ID_TIPO_TRABAJO,
				COSTO = ircLDC_ITEMS_POR_UNID_PRED.COSTO,
				ID_VAL_FIJO = ircLDC_ITEMS_POR_UNID_PRED.ID_VAL_FIJO,
				PRECIO_TOTAL = ircLDC_ITEMS_POR_UNID_PRED.PRECIO_TOTAL,
				COSTO_TOTAL = ircLDC_ITEMS_POR_UNID_PRED.COSTO_TOTAL,
				TIPO_ITEM = ircLDC_ITEMS_POR_UNID_PRED.TIPO_ITEM
			where
				ID_TORRE = ircLDC_ITEMS_POR_UNID_PRED.ID_TORRE and
				ID_PISO = ircLDC_ITEMS_POR_UNID_PRED.ID_PISO and
				ID_PROYECTO = ircLDC_ITEMS_POR_UNID_PRED.ID_PROYECTO and
				ID_ITEM_COTIZADO = ircLDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO and
				ID_COTIZACION_DETALLADA = ircLDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA and
				ID_UNIDAD_PREDIAL = ircLDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL
			returning
				ID_TORRE,
				ID_PISO,
				ID_PROYECTO,
				ID_ITEM_COTIZADO,
				ID_COTIZACION_DETALLADA,
				ID_UNIDAD_PREDIAL
			into
				nuID_TORRE,
				nuID_PISO,
				nuID_PROYECTO,
				nuID_ITEM_COTIZADO,
				nuID_COTIZACION_DETALLADA,
				nuID_UNIDAD_PREDIAL;
		end if;
		if
			nuID_TORRE is NULL OR
			nuID_PISO is NULL OR
			nuID_PROYECTO is NULL OR
			nuID_ITEM_COTIZADO is NULL OR
			nuID_COTIZACION_DETALLADA is NULL OR
			nuID_UNIDAD_PREDIAL is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ITEMS_POR_UNID_PRED));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ITEMS_POR_UNID_PRED in out nocopy tytbLDC_ITEMS_POR_UNID_PRED,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ITEMS_POR_UNID_PRED;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEMS_POR_UNID_PRED,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_POR_UNID_PRED.first .. iotbLDC_ITEMS_POR_UNID_PRED.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_POR_UNID_PRED.first .. iotbLDC_ITEMS_POR_UNID_PRED.last
				update LDC_ITEMS_POR_UNID_PRED
				set
					ID_ITEM = rcRecOfTab.ID_ITEM(n),
					CANTIDAD = rcRecOfTab.CANTIDAD(n),
					PRECIO = rcRecOfTab.PRECIO(n),
					ID_TIPO_TRABAJO = rcRecOfTab.ID_TIPO_TRABAJO(n),
					COSTO = rcRecOfTab.COSTO(n),
					ID_VAL_FIJO = rcRecOfTab.ID_VAL_FIJO(n),
					PRECIO_TOTAL = rcRecOfTab.PRECIO_TOTAL(n),
					COSTO_TOTAL = rcRecOfTab.COSTO_TOTAL(n),
					TIPO_ITEM = rcRecOfTab.TIPO_ITEM(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_POR_UNID_PRED.first .. iotbLDC_ITEMS_POR_UNID_PRED.last loop
					LockByPk
					(
						rcRecOfTab.ID_TORRE(n),
						rcRecOfTab.ID_PISO(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcRecOfTab.ID_ITEM_COTIZADO(n),
						rcRecOfTab.ID_COTIZACION_DETALLADA(n),
						rcRecOfTab.ID_UNIDAD_PREDIAL(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_POR_UNID_PRED.first .. iotbLDC_ITEMS_POR_UNID_PRED.last
				update LDC_ITEMS_POR_UNID_PRED
				SET
					ID_ITEM = rcRecOfTab.ID_ITEM(n),
					CANTIDAD = rcRecOfTab.CANTIDAD(n),
					PRECIO = rcRecOfTab.PRECIO(n),
					ID_TIPO_TRABAJO = rcRecOfTab.ID_TIPO_TRABAJO(n),
					COSTO = rcRecOfTab.COSTO(n),
					ID_VAL_FIJO = rcRecOfTab.ID_VAL_FIJO(n),
					PRECIO_TOTAL = rcRecOfTab.PRECIO_TOTAL(n),
					COSTO_TOTAL = rcRecOfTab.COSTO_TOTAL(n),
					TIPO_ITEM = rcRecOfTab.TIPO_ITEM(n)
				where
					ID_TORRE = rcRecOfTab.ID_TORRE(n) and
					ID_PISO = rcRecOfTab.ID_PISO(n) and
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n) and
					ID_ITEM_COTIZADO = rcRecOfTab.ID_ITEM_COTIZADO(n) and
					ID_COTIZACION_DETALLADA = rcRecOfTab.ID_COTIZACION_DETALLADA(n) and
					ID_UNIDAD_PREDIAL = rcRecOfTab.ID_UNIDAD_PREDIAL(n)
;
		end if;
	END;
	PROCEDURE updID_ITEM
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuID_ITEM$ in LDC_ITEMS_POR_UNID_PRED.ID_ITEM%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_TORRE,
				inuID_PISO,
				inuID_PROYECTO,
				inuID_ITEM_COTIZADO,
				inuID_COTIZACION_DETALLADA,
				inuID_UNIDAD_PREDIAL,
				rcData
			);
		end if;

		update LDC_ITEMS_POR_UNID_PRED
		set
			ID_ITEM = inuID_ITEM$
		where
			ID_TORRE = inuID_TORRE and
			ID_PISO = inuID_PISO and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM_COTIZADO = inuID_ITEM_COTIZADO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_ITEM:= inuID_ITEM$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCANTIDAD
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuCANTIDAD$ in LDC_ITEMS_POR_UNID_PRED.CANTIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_TORRE,
				inuID_PISO,
				inuID_PROYECTO,
				inuID_ITEM_COTIZADO,
				inuID_COTIZACION_DETALLADA,
				inuID_UNIDAD_PREDIAL,
				rcData
			);
		end if;

		update LDC_ITEMS_POR_UNID_PRED
		set
			CANTIDAD = inuCANTIDAD$
		where
			ID_TORRE = inuID_TORRE and
			ID_PISO = inuID_PISO and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM_COTIZADO = inuID_ITEM_COTIZADO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CANTIDAD:= inuCANTIDAD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRECIO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuPRECIO$ in LDC_ITEMS_POR_UNID_PRED.PRECIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_TORRE,
				inuID_PISO,
				inuID_PROYECTO,
				inuID_ITEM_COTIZADO,
				inuID_COTIZACION_DETALLADA,
				inuID_UNIDAD_PREDIAL,
				rcData
			);
		end if;

		update LDC_ITEMS_POR_UNID_PRED
		set
			PRECIO = inuPRECIO$
		where
			ID_TORRE = inuID_TORRE and
			ID_PISO = inuID_PISO and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM_COTIZADO = inuID_ITEM_COTIZADO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRECIO:= inuPRECIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_TIPO_TRABAJO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuID_TIPO_TRABAJO$ in LDC_ITEMS_POR_UNID_PRED.ID_TIPO_TRABAJO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_TORRE,
				inuID_PISO,
				inuID_PROYECTO,
				inuID_ITEM_COTIZADO,
				inuID_COTIZACION_DETALLADA,
				inuID_UNIDAD_PREDIAL,
				rcData
			);
		end if;

		update LDC_ITEMS_POR_UNID_PRED
		set
			ID_TIPO_TRABAJO = inuID_TIPO_TRABAJO$
		where
			ID_TORRE = inuID_TORRE and
			ID_PISO = inuID_PISO and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM_COTIZADO = inuID_ITEM_COTIZADO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_TIPO_TRABAJO:= inuID_TIPO_TRABAJO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOSTO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuCOSTO$ in LDC_ITEMS_POR_UNID_PRED.COSTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_TORRE,
				inuID_PISO,
				inuID_PROYECTO,
				inuID_ITEM_COTIZADO,
				inuID_COTIZACION_DETALLADA,
				inuID_UNIDAD_PREDIAL,
				rcData
			);
		end if;

		update LDC_ITEMS_POR_UNID_PRED
		set
			COSTO = inuCOSTO$
		where
			ID_TORRE = inuID_TORRE and
			ID_PISO = inuID_PISO and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM_COTIZADO = inuID_ITEM_COTIZADO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COSTO:= inuCOSTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_VAL_FIJO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuID_VAL_FIJO$ in LDC_ITEMS_POR_UNID_PRED.ID_VAL_FIJO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_TORRE,
				inuID_PISO,
				inuID_PROYECTO,
				inuID_ITEM_COTIZADO,
				inuID_COTIZACION_DETALLADA,
				inuID_UNIDAD_PREDIAL,
				rcData
			);
		end if;

		update LDC_ITEMS_POR_UNID_PRED
		set
			ID_VAL_FIJO = inuID_VAL_FIJO$
		where
			ID_TORRE = inuID_TORRE and
			ID_PISO = inuID_PISO and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM_COTIZADO = inuID_ITEM_COTIZADO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_VAL_FIJO:= inuID_VAL_FIJO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRECIO_TOTAL
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuPRECIO_TOTAL$ in LDC_ITEMS_POR_UNID_PRED.PRECIO_TOTAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_TORRE,
				inuID_PISO,
				inuID_PROYECTO,
				inuID_ITEM_COTIZADO,
				inuID_COTIZACION_DETALLADA,
				inuID_UNIDAD_PREDIAL,
				rcData
			);
		end if;

		update LDC_ITEMS_POR_UNID_PRED
		set
			PRECIO_TOTAL = inuPRECIO_TOTAL$
		where
			ID_TORRE = inuID_TORRE and
			ID_PISO = inuID_PISO and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM_COTIZADO = inuID_ITEM_COTIZADO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRECIO_TOTAL:= inuPRECIO_TOTAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOSTO_TOTAL
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuCOSTO_TOTAL$ in LDC_ITEMS_POR_UNID_PRED.COSTO_TOTAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_TORRE,
				inuID_PISO,
				inuID_PROYECTO,
				inuID_ITEM_COTIZADO,
				inuID_COTIZACION_DETALLADA,
				inuID_UNIDAD_PREDIAL,
				rcData
			);
		end if;

		update LDC_ITEMS_POR_UNID_PRED
		set
			COSTO_TOTAL = inuCOSTO_TOTAL$
		where
			ID_TORRE = inuID_TORRE and
			ID_PISO = inuID_PISO and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM_COTIZADO = inuID_ITEM_COTIZADO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COSTO_TOTAL:= inuCOSTO_TOTAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTIPO_ITEM
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		isbTIPO_ITEM$ in LDC_ITEMS_POR_UNID_PRED.TIPO_ITEM%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_TORRE,
				inuID_PISO,
				inuID_PROYECTO,
				inuID_ITEM_COTIZADO,
				inuID_COTIZACION_DETALLADA,
				inuID_UNIDAD_PREDIAL,
				rcData
			);
		end if;

		update LDC_ITEMS_POR_UNID_PRED
		set
			TIPO_ITEM = isbTIPO_ITEM$
		where
			ID_TORRE = inuID_TORRE and
			ID_PISO = inuID_PISO and
			ID_PROYECTO = inuID_PROYECTO and
			ID_ITEM_COTIZADO = inuID_ITEM_COTIZADO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPO_ITEM:= isbTIPO_ITEM$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_TORRE
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN

		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.ID_TORRE);
		end if;
		Load
		(
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.ID_TORRE);
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
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN

		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.ID_PROYECTO);
		end if;
		Load
		(
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
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
	FUNCTION fnuGetID_COTIZACION_DETALLADA
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN

		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.ID_COTIZACION_DETALLADA);
		end if;
		Load
		(
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
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
	FUNCTION fnuGetID_UNIDAD_PREDIAL
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN

		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.ID_UNIDAD_PREDIAL);
		end if;
		Load
		(
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.ID_UNIDAD_PREDIAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_ITEM
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_ITEM%type
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN

		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.ID_ITEM);
		end if;
		Load
		(
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.ID_ITEM);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCANTIDAD
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.CANTIDAD%type
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN

		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.CANTIDAD);
		end if;
		Load
		(
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.CANTIDAD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPRECIO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.PRECIO%type
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN

		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.PRECIO);
		end if;
		Load
		(
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.PRECIO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_TIPO_TRABAJO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_TIPO_TRABAJO%type
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN

		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.ID_TIPO_TRABAJO);
		end if;
		Load
		(
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.ID_TIPO_TRABAJO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOSTO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.COSTO%type
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN

		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.COSTO);
		end if;
		Load
		(
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.COSTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_VAL_FIJO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_VAL_FIJO%type
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN

		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.ID_VAL_FIJO);
		end if;
		Load
		(
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.ID_VAL_FIJO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPRECIO_TOTAL
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.PRECIO_TOTAL%type
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN

		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.PRECIO_TOTAL);
		end if;
		Load
		(
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.PRECIO_TOTAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOSTO_TOTAL
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.COSTO_TOTAL%type
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN

		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.COSTO_TOTAL);
		end if;
		Load
		(
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.COSTO_TOTAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_ITEM_COTIZADO
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN

		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.ID_ITEM_COTIZADO);
		end if;
		Load
		(
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.ID_ITEM_COTIZADO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTIPO_ITEM
	(
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.TIPO_ITEM%type
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN

		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.TIPO_ITEM);
		end if;
		Load
		(
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.TIPO_ITEM);
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
		inuID_TORRE in LDC_ITEMS_POR_UNID_PRED.ID_TORRE%type,
		inuID_PISO in LDC_ITEMS_POR_UNID_PRED.ID_PISO%type,
		inuID_PROYECTO in LDC_ITEMS_POR_UNID_PRED.ID_PROYECTO%type,
		inuID_ITEM_COTIZADO in LDC_ITEMS_POR_UNID_PRED.ID_ITEM_COTIZADO%type,
		inuID_COTIZACION_DETALLADA in LDC_ITEMS_POR_UNID_PRED.ID_COTIZACION_DETALLADA%type,
		inuID_UNIDAD_PREDIAL in LDC_ITEMS_POR_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_POR_UNID_PRED.ID_PISO%type
	IS
		rcError styLDC_ITEMS_POR_UNID_PRED;
	BEGIN

		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_ITEM_COTIZADO := inuID_ITEM_COTIZADO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.ID_PISO);
		end if;
		Load
		(
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_PROYECTO,
		 		inuID_ITEM_COTIZADO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_UNIDAD_PREDIAL
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
	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALDC_ITEMS_POR_UNID_PRED;
/
PROMPT Otorgando permisos de ejecucion a DALDC_ITEMS_POR_UNID_PRED
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_ITEMS_POR_UNID_PRED', 'ADM_PERSON');
END;
/