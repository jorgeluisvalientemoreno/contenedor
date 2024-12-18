CREATE OR REPLACE PACKAGE adm_person.DALD_segmen_supplier
is
/***************************************************************
Propiedad intelectual de Sincecomp Ltda.

Unidad	     : DALD_segmen_supplier
Descripcion	 : Paquete para la gestión de la entidad LD_segmen_supplier (Resolución CREG por Unidades Constructivas)

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
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type
  )
  IS
		SELECT LD_segmen_supplier.*,LD_segmen_supplier.rowid
		FROM LD_segmen_supplier
		WHERE
			SEGMEN_SUPPLIER_Id = inuSEGMEN_SUPPLIER_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_segmen_supplier.*,LD_segmen_supplier.rowid
		FROM LD_segmen_supplier
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_segmen_supplier  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_segmen_supplier is table of styLD_segmen_supplier index by binary_integer;
	type tyrfRecords is ref cursor return styLD_segmen_supplier;

	/* Tipos referenciando al registro */
	type tytbSegmen_Supplier_Id is table of LD_segmen_supplier.Segmen_Supplier_Id%type index by binary_integer;
	type tytbLine_Id is table of LD_segmen_supplier.Line_Id%type index by binary_integer;
	type tytbSubline_Id is table of LD_segmen_supplier.Subline_Id%type index by binary_integer;
	type tytbLine_Equivalence is table of LD_segmen_supplier.Line_Equivalence%type index by binary_integer;
	type tytbSupplier_Id is table of LD_segmen_supplier.Supplier_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_segmen_supplier is record
	(

		Segmen_Supplier_Id   tytbSegmen_Supplier_Id,
		Line_Id   tytbLine_Id,
		Subline_Id   tytbSubline_Id,
		Line_Equivalence   tytbLine_Equivalence,
		Supplier_Id   tytbSupplier_Id,
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
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type
	);

	PROCEDURE getRecord
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		orcRecord out nocopy styLD_segmen_supplier
	);

	FUNCTION frcGetRcData
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type
	)
	RETURN styLD_segmen_supplier;

	FUNCTION frcGetRcData
	RETURN styLD_segmen_supplier;

	FUNCTION frcGetRecord
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type
	)
	RETURN styLD_segmen_supplier;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_segmen_supplier
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_segmen_supplier in styLD_segmen_supplier
	);

 	  PROCEDURE insRecord
	(
		ircLD_segmen_supplier in styLD_segmen_supplier,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_segmen_supplier in out nocopy tytbLD_segmen_supplier
	);

	PROCEDURE delRecord
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_segmen_supplier in out nocopy tytbLD_segmen_supplier,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_segmen_supplier in styLD_segmen_supplier,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_segmen_supplier in out nocopy tytbLD_segmen_supplier,
		inuLock in number default 1
	);

		PROCEDURE updLine_Id
		(
				inuSEGMEN_SUPPLIER_Id   in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
				inuLine_Id$  in LD_segmen_supplier.Line_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubline_Id
		(
				inuSEGMEN_SUPPLIER_Id   in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
				inuSubline_Id$  in LD_segmen_supplier.Subline_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updLine_Equivalence
		(
				inuSEGMEN_SUPPLIER_Id   in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
				isbLine_Equivalence$  in LD_segmen_supplier.Line_Equivalence%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSupplier_Id
		(
				inuSEGMEN_SUPPLIER_Id   in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
				inuSupplier_Id$  in LD_segmen_supplier.Supplier_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetSegmen_Supplier_Id
    	(
    	    inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_segmen_supplier.Segmen_Supplier_Id%type;

    	FUNCTION fnuGetLine_Id
    	(
    	    inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_segmen_supplier.Line_Id%type;

    	FUNCTION fnuGetSubline_Id
    	(
    	    inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_segmen_supplier.Subline_Id%type;

    	FUNCTION fsbGetLine_Equivalence
    	(
    	    inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_segmen_supplier.Line_Equivalence%type;

    	FUNCTION fnuGetSupplier_Id
    	(
    	    inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_segmen_supplier.Supplier_Id%type;


	PROCEDURE LockByPk
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		orcLD_segmen_supplier  out styLD_segmen_supplier
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_segmen_supplier  out styLD_segmen_supplier
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_segmen_supplier;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_segmen_supplier
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SEGMEN_SUPPLIER';
	  cnuGeEntityId constant varchar2(30) := 8132; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type
	)
	IS
		SELECT LD_segmen_supplier.*,LD_segmen_supplier.rowid
		FROM LD_segmen_supplier
		WHERE  SEGMEN_SUPPLIER_Id = inuSEGMEN_SUPPLIER_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_segmen_supplier.*,LD_segmen_supplier.rowid
		FROM LD_segmen_supplier
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_segmen_supplier is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_segmen_supplier;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_segmen_supplier default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.SEGMEN_SUPPLIER_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		orcLD_segmen_supplier  out styLD_segmen_supplier
	)
	IS
		rcError styLD_segmen_supplier;
	BEGIN
		rcError.SEGMEN_SUPPLIER_Id := inuSEGMEN_SUPPLIER_Id;

		Open cuLockRcByPk
		(
			inuSEGMEN_SUPPLIER_Id
		);

		fetch cuLockRcByPk into orcLD_segmen_supplier;
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
		orcLD_segmen_supplier  out styLD_segmen_supplier
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_segmen_supplier;
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
		itbLD_segmen_supplier  in out nocopy tytbLD_segmen_supplier
	)
	IS
	BEGIN
			rcRecOfTab.Segmen_Supplier_Id.delete;
			rcRecOfTab.Line_Id.delete;
			rcRecOfTab.Subline_Id.delete;
			rcRecOfTab.Line_Equivalence.delete;
			rcRecOfTab.Supplier_Id.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_segmen_supplier  in out nocopy tytbLD_segmen_supplier,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_segmen_supplier);
		for n in itbLD_segmen_supplier.first .. itbLD_segmen_supplier.last loop
			rcRecOfTab.Segmen_Supplier_Id(n) := itbLD_segmen_supplier(n).Segmen_Supplier_Id;
			rcRecOfTab.Line_Id(n) := itbLD_segmen_supplier(n).Line_Id;
			rcRecOfTab.Subline_Id(n) := itbLD_segmen_supplier(n).Subline_Id;
			rcRecOfTab.Line_Equivalence(n) := itbLD_segmen_supplier(n).Line_Equivalence;
			rcRecOfTab.Supplier_Id(n) := itbLD_segmen_supplier(n).Supplier_Id;
			rcRecOfTab.row_id(n) := itbLD_segmen_supplier(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuSEGMEN_SUPPLIER_Id
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
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuSEGMEN_SUPPLIER_Id = rcData.SEGMEN_SUPPLIER_Id
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
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuSEGMEN_SUPPLIER_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type
	)
	IS
		rcError styLD_segmen_supplier;
	BEGIN		rcError.SEGMEN_SUPPLIER_Id:=inuSEGMEN_SUPPLIER_Id;

		Load
		(
			inuSEGMEN_SUPPLIER_Id
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
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuSEGMEN_SUPPLIER_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		orcRecord out nocopy styLD_segmen_supplier
	)
	IS
		rcError styLD_segmen_supplier;
	BEGIN		rcError.SEGMEN_SUPPLIER_Id:=inuSEGMEN_SUPPLIER_Id;

		Load
		(
			inuSEGMEN_SUPPLIER_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type
	)
	RETURN styLD_segmen_supplier
	IS
		rcError styLD_segmen_supplier;
	BEGIN
		rcError.SEGMEN_SUPPLIER_Id:=inuSEGMEN_SUPPLIER_Id;

		Load
		(
			inuSEGMEN_SUPPLIER_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type
	)
	RETURN styLD_segmen_supplier
	IS
		rcError styLD_segmen_supplier;
	BEGIN
		rcError.SEGMEN_SUPPLIER_Id:=inuSEGMEN_SUPPLIER_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEGMEN_SUPPLIER_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuSEGMEN_SUPPLIER_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_segmen_supplier
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_segmen_supplier
	)
	IS
		rfLD_segmen_supplier tyrfLD_segmen_supplier;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_segmen_supplier.Segmen_Supplier_Id,
		            LD_segmen_supplier.Line_Id,
		            LD_segmen_supplier.Subline_Id,
		            LD_segmen_supplier.Line_Equivalence,
		            LD_segmen_supplier.Supplier_Id,
		            LD_segmen_supplier.rowid
                FROM LD_segmen_supplier';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_segmen_supplier for sbFullQuery;
		fetch rfLD_segmen_supplier bulk collect INTO otbResult;
		close rfLD_segmen_supplier;
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
		sbSQL  VARCHAR2 (32000) := 'select
		            LD_segmen_supplier.Segmen_Supplier_Id,
		            LD_segmen_supplier.Line_Id,
		            LD_segmen_supplier.Subline_Id,
		            LD_segmen_supplier.Line_Equivalence,
		            LD_segmen_supplier.Supplier_Id,
		            LD_segmen_supplier.rowid
                FROM LD_segmen_supplier';
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
		ircLD_segmen_supplier in styLD_segmen_supplier
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_segmen_supplier,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_segmen_supplier in styLD_segmen_supplier,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_segmen_supplier.SEGMEN_SUPPLIER_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|SEGMEN_SUPPLIER_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_segmen_supplier
		(
			Segmen_Supplier_Id,
			Line_Id,
			Subline_Id,
			Line_Equivalence,
			Supplier_Id
		)
		values
		(
			ircLD_segmen_supplier.Segmen_Supplier_Id,
			ircLD_segmen_supplier.Line_Id,
			ircLD_segmen_supplier.Subline_Id,
			ircLD_segmen_supplier.Line_Equivalence,
			ircLD_segmen_supplier.Supplier_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_segmen_supplier));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_segmen_supplier in out nocopy tytbLD_segmen_supplier
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_segmen_supplier, blUseRowID);
		forall n in iotbLD_segmen_supplier.first..iotbLD_segmen_supplier.last
			insert into LD_segmen_supplier
			(
			Segmen_Supplier_Id,
			Line_Id,
			Subline_Id,
			Line_Equivalence,
			Supplier_Id
		)
		values
		(
			rcRecOfTab.Segmen_Supplier_Id(n),
			rcRecOfTab.Line_Id(n),
			rcRecOfTab.Subline_Id(n),
			rcRecOfTab.Line_Equivalence(n),
			rcRecOfTab.Supplier_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_segmen_supplier;
	BEGIN
		rcError.SEGMEN_SUPPLIER_Id:=inuSEGMEN_SUPPLIER_Id;

		if inuLock=1 then
			LockByPk
			(
				inuSEGMEN_SUPPLIER_Id,
				rcData
			);
		end if;

		delete
		from LD_segmen_supplier
		where
       		SEGMEN_SUPPLIER_Id=inuSEGMEN_SUPPLIER_Id;
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
		iriRowID   in rowid,
		inuLock    in number default 1
	)
	IS
		rcRecordNull cuRecord%rowtype;
		rcError  styLD_segmen_supplier;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_segmen_supplier
		where
			rowid = iriRowID
		returning
   SEGMEN_SUPPLIER_Id
		into
			rcError.SEGMEN_SUPPLIER_Id;

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
		iotbLD_segmen_supplier in out nocopy tytbLD_segmen_supplier,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_segmen_supplier;
	BEGIN
		FillRecordOfTables(iotbLD_segmen_supplier, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_segmen_supplier.first .. iotbLD_segmen_supplier.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_segmen_supplier.first .. iotbLD_segmen_supplier.last
				delete
				from LD_segmen_supplier
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_segmen_supplier.first .. iotbLD_segmen_supplier.last loop
					LockByPk
					(
							rcRecOfTab.SEGMEN_SUPPLIER_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_segmen_supplier.first .. iotbLD_segmen_supplier.last
				delete
				from LD_segmen_supplier
				where
		         	SEGMEN_SUPPLIER_Id = rcRecOfTab.SEGMEN_SUPPLIER_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_segmen_supplier in styLD_segmen_supplier,
		inuLock	  in number default 0
	)
	IS
		nuSEGMEN_SUPPLIER_Id LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type;

	BEGIN
		if ircLD_segmen_supplier.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_segmen_supplier.rowid,rcData);
			end if;
			update LD_segmen_supplier
			set

        Line_Id = ircLD_segmen_supplier.Line_Id,
        Subline_Id = ircLD_segmen_supplier.Subline_Id,
        Line_Equivalence = ircLD_segmen_supplier.Line_Equivalence,
        Supplier_Id = ircLD_segmen_supplier.Supplier_Id
			where
				rowid = ircLD_segmen_supplier.rowid
			returning
    SEGMEN_SUPPLIER_Id
			into
				nuSEGMEN_SUPPLIER_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_segmen_supplier.SEGMEN_SUPPLIER_Id,
					rcData
				);
			end if;

			update LD_segmen_supplier
			set
        Line_Id = ircLD_segmen_supplier.Line_Id,
        Subline_Id = ircLD_segmen_supplier.Subline_Id,
        Line_Equivalence = ircLD_segmen_supplier.Line_Equivalence,
        Supplier_Id = ircLD_segmen_supplier.Supplier_Id
			where
	         	SEGMEN_SUPPLIER_Id = ircLD_segmen_supplier.SEGMEN_SUPPLIER_Id
			returning
    SEGMEN_SUPPLIER_Id
			into
				nuSEGMEN_SUPPLIER_Id;
		end if;

		if
			nuSEGMEN_SUPPLIER_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_segmen_supplier));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_segmen_supplier in out nocopy tytbLD_segmen_supplier,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_segmen_supplier;
  BEGIN
    FillRecordOfTables(iotbLD_segmen_supplier,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_segmen_supplier.first .. iotbLD_segmen_supplier.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_segmen_supplier.first .. iotbLD_segmen_supplier.last
        update LD_segmen_supplier
        set

            Line_Id = rcRecOfTab.Line_Id(n),
            Subline_Id = rcRecOfTab.Subline_Id(n),
            Line_Equivalence = rcRecOfTab.Line_Equivalence(n),
            Supplier_Id = rcRecOfTab.Supplier_Id(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_segmen_supplier.first .. iotbLD_segmen_supplier.last loop
          LockByPk
          (
              rcRecOfTab.SEGMEN_SUPPLIER_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_segmen_supplier.first .. iotbLD_segmen_supplier.last
        update LD_segmen_supplier
        set
					Line_Id = rcRecOfTab.Line_Id(n),
					Subline_Id = rcRecOfTab.Subline_Id(n),
					Line_Equivalence = rcRecOfTab.Line_Equivalence(n),
					Supplier_Id = rcRecOfTab.Supplier_Id(n)
          where
          SEGMEN_SUPPLIER_Id = rcRecOfTab.SEGMEN_SUPPLIER_Id(n)
;
    end if;
  END;

	PROCEDURE updLine_Id
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		inuLine_Id$ in LD_segmen_supplier.Line_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_segmen_supplier;
	BEGIN
		rcError.SEGMEN_SUPPLIER_Id := inuSEGMEN_SUPPLIER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSEGMEN_SUPPLIER_Id,
				rcData
			);
		end if;

		update LD_segmen_supplier
		set
			Line_Id = inuLine_Id$
		where
			SEGMEN_SUPPLIER_Id = inuSEGMEN_SUPPLIER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Line_Id:= inuLine_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSubline_Id
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		inuSubline_Id$ in LD_segmen_supplier.Subline_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_segmen_supplier;
	BEGIN
		rcError.SEGMEN_SUPPLIER_Id := inuSEGMEN_SUPPLIER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSEGMEN_SUPPLIER_Id,
				rcData
			);
		end if;

		update LD_segmen_supplier
		set
			Subline_Id = inuSubline_Id$
		where
			SEGMEN_SUPPLIER_Id = inuSEGMEN_SUPPLIER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Subline_Id:= inuSubline_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updLine_Equivalence
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		isbLine_Equivalence$ in LD_segmen_supplier.Line_Equivalence%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_segmen_supplier;
	BEGIN
		rcError.SEGMEN_SUPPLIER_Id := inuSEGMEN_SUPPLIER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSEGMEN_SUPPLIER_Id,
				rcData
			);
		end if;

		update LD_segmen_supplier
		set
			Line_Equivalence = isbLine_Equivalence$
		where
			SEGMEN_SUPPLIER_Id = inuSEGMEN_SUPPLIER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Line_Equivalence:= isbLine_Equivalence$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSupplier_Id
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		inuSupplier_Id$ in LD_segmen_supplier.Supplier_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_segmen_supplier;
	BEGIN
		rcError.SEGMEN_SUPPLIER_Id := inuSEGMEN_SUPPLIER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuSEGMEN_SUPPLIER_Id,
				rcData
			);
		end if;

		update LD_segmen_supplier
		set
			Supplier_Id = inuSupplier_Id$
		where
			SEGMEN_SUPPLIER_Id = inuSEGMEN_SUPPLIER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Supplier_Id:= inuSupplier_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetSegmen_Supplier_Id
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_segmen_supplier.Segmen_Supplier_Id%type
	IS
		rcError styLD_segmen_supplier;
	BEGIN

		rcError.SEGMEN_SUPPLIER_Id := inuSEGMEN_SUPPLIER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSEGMEN_SUPPLIER_Id
			 )
		then
			 return(rcData.Segmen_Supplier_Id);
		end if;
		Load
		(
			inuSEGMEN_SUPPLIER_Id
		);
		return(rcData.Segmen_Supplier_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetLine_Id
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_segmen_supplier.Line_Id%type
	IS
		rcError styLD_segmen_supplier;
	BEGIN

		rcError.SEGMEN_SUPPLIER_Id := inuSEGMEN_SUPPLIER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSEGMEN_SUPPLIER_Id
			 )
		then
			 return(rcData.Line_Id);
		end if;
		Load
		(
			inuSEGMEN_SUPPLIER_Id
		);
		return(rcData.Line_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSubline_Id
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_segmen_supplier.Subline_Id%type
	IS
		rcError styLD_segmen_supplier;
	BEGIN

		rcError.SEGMEN_SUPPLIER_Id := inuSEGMEN_SUPPLIER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSEGMEN_SUPPLIER_Id
			 )
		then
			 return(rcData.Subline_Id);
		end if;
		Load
		(
			inuSEGMEN_SUPPLIER_Id
		);
		return(rcData.Subline_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetLine_Equivalence
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_segmen_supplier.Line_Equivalence%type
	IS
		rcError styLD_segmen_supplier;
	BEGIN

		rcError.SEGMEN_SUPPLIER_Id:=inuSEGMEN_SUPPLIER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSEGMEN_SUPPLIER_Id
			 )
		then
			 return(rcData.Line_Equivalence);
		end if;
		Load
		(
			inuSEGMEN_SUPPLIER_Id
		);
		return(rcData.Line_Equivalence);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSupplier_Id
	(
		inuSEGMEN_SUPPLIER_Id in LD_segmen_supplier.SEGMEN_SUPPLIER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_segmen_supplier.Supplier_Id%type
	IS
		rcError styLD_segmen_supplier;
	BEGIN

		rcError.SEGMEN_SUPPLIER_Id := inuSEGMEN_SUPPLIER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuSEGMEN_SUPPLIER_Id
			 )
		then
			 return(rcData.Supplier_Id);
		end if;
		Load
		(
			inuSEGMEN_SUPPLIER_Id
		);
		return(rcData.Supplier_Id);
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
end DALD_segmen_supplier;
/
PROMPT Otorgando permisos de ejecucion a DALD_SEGMEN_SUPPLIER
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SEGMEN_SUPPLIER', 'ADM_PERSON');
END;
/