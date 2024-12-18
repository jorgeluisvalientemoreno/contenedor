CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_construct_unit
is
/***************************************************************
Propiedad intelectual de Sincecomp Ltda.

Unidad	     : DALD_construct_unit
Descripcion	 : Paquete para la gestión de la entidad LD_construct_unit (Unidades Constructivas)

Parametro	    Descripcion
============	==============================

Historia de Modificaciones
Fecha   	           Autor            Modificacion
====================   =========        ====================
DD-MM-YYYY             Autor<SAO156931>   <Descripcion de la Modificacion>
06/06/2024             PAcosta            OSF-2778: Cambio de esquema ADM_PERSON  
****************************************************************/

	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type
  )
  IS
		SELECT LD_construct_unit.*,LD_construct_unit.rowid
		FROM LD_construct_unit
		WHERE
			Construct_Unit_Id = inuConstruct_Unit_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_construct_unit.*,LD_construct_unit.rowid
		FROM LD_construct_unit
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_construct_unit  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_construct_unit is table of styLD_construct_unit index by binary_integer;
	type tyrfRecords is ref cursor return styLD_construct_unit;

	/* Tipos referenciando al registro */
	type tytbConstruct_Unit_Id is table of LD_construct_unit.Construct_Unit_Id%type index by binary_integer;
	type tytbConstructive_Unit is table of LD_construct_unit.Constructive_Unit%type index by binary_integer;
	type tytbDescription is table of LD_construct_unit.Description%type index by binary_integer;
	type tytbActive is table of LD_construct_unit.Active%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_construct_unit is record
	(

		Construct_Unit_Id   tytbConstruct_Unit_Id,
		Constructive_Unit   tytbConstructive_Unit,
		Description   tytbDescription,
		Active   tytbActive,
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
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type
	);

	PROCEDURE getRecord
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		orcRecord out nocopy styLD_construct_unit
	);

	FUNCTION frcGetRcData
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type
	)
	RETURN styLD_construct_unit;

	FUNCTION frcGetRcData
	RETURN styLD_construct_unit;

	FUNCTION frcGetRecord
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type
	)
	RETURN styLD_construct_unit;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_construct_unit
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_construct_unit in styLD_construct_unit
	);

 	  PROCEDURE insRecord
	(
		ircLD_construct_unit in styLD_construct_unit,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_construct_unit in out nocopy tytbLD_construct_unit
	);

	PROCEDURE delRecord
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_construct_unit in out nocopy tytbLD_construct_unit,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_construct_unit in styLD_construct_unit,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_construct_unit in out nocopy tytbLD_construct_unit,
		inuLock in number default 1
	);

		PROCEDURE updConstructive_Unit
		(
				inuConstruct_Unit_Id   in LD_construct_unit.Construct_Unit_Id%type,
				isbConstructive_Unit$  in LD_construct_unit.Constructive_Unit%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updDescription
		(
				inuConstruct_Unit_Id   in LD_construct_unit.Construct_Unit_Id%type,
				isbDescription$  in LD_construct_unit.Description%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updActive
		(
				inuConstruct_Unit_Id   in LD_construct_unit.Construct_Unit_Id%type,
				isbActive$  in LD_construct_unit.Active%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetConstruct_Unit_Id
    	(
    	    inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_construct_unit.Construct_Unit_Id%type;

    	FUNCTION fsbGetConstructive_Unit
    	(
    	    inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_construct_unit.Constructive_Unit%type;

    	FUNCTION fsbGetDescription
    	(
    	    inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_construct_unit.Description%type;

    	FUNCTION fsbGetActive
    	(
    	    inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_construct_unit.Active%type;


	PROCEDURE LockByPk
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		orcLD_construct_unit  out styLD_construct_unit
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_construct_unit  out styLD_construct_unit
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_construct_unit;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_construct_unit
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156931';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CONSTRUCT_UNIT';
	  cnuGeEntityId constant varchar2(30) := 8331; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type
	)
	IS
		SELECT LD_construct_unit.*,LD_construct_unit.rowid
		FROM LD_construct_unit
		WHERE  Construct_Unit_Id = inuConstruct_Unit_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_construct_unit.*,LD_construct_unit.rowid
		FROM LD_construct_unit
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_construct_unit is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_construct_unit;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_construct_unit default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.Construct_Unit_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		orcLD_construct_unit  out styLD_construct_unit
	)
	IS
		rcError styLD_construct_unit;
	BEGIN
		rcError.Construct_Unit_Id := inuConstruct_Unit_Id;

		Open cuLockRcByPk
		(
			inuConstruct_Unit_Id
		);

		fetch cuLockRcByPk into orcLD_construct_unit;
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
		orcLD_construct_unit  out styLD_construct_unit
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_construct_unit;
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
		itbLD_construct_unit  in out nocopy tytbLD_construct_unit
	)
	IS
	BEGIN
			rcRecOfTab.Construct_Unit_Id.delete;
			rcRecOfTab.Constructive_Unit.delete;
			rcRecOfTab.Description.delete;
			rcRecOfTab.Active.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_construct_unit  in out nocopy tytbLD_construct_unit,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_construct_unit);
		for n in itbLD_construct_unit.first .. itbLD_construct_unit.last loop
			rcRecOfTab.Construct_Unit_Id(n) := itbLD_construct_unit(n).Construct_Unit_Id;
			rcRecOfTab.Constructive_Unit(n) := itbLD_construct_unit(n).Constructive_Unit;
			rcRecOfTab.Description(n) := itbLD_construct_unit(n).Description;
			rcRecOfTab.Active(n) := itbLD_construct_unit(n).Active;
			rcRecOfTab.row_id(n) := itbLD_construct_unit(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuConstruct_Unit_Id
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
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuConstruct_Unit_Id = rcData.Construct_Unit_Id
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
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuConstruct_Unit_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type
	)
	IS
		rcError styLD_construct_unit;
	BEGIN		rcError.Construct_Unit_Id:=inuConstruct_Unit_Id;

		Load
		(
			inuConstruct_Unit_Id
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
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuConstruct_Unit_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		orcRecord out nocopy styLD_construct_unit
	)
	IS
		rcError styLD_construct_unit;
	BEGIN		rcError.Construct_Unit_Id:=inuConstruct_Unit_Id;

		Load
		(
			inuConstruct_Unit_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type
	)
	RETURN styLD_construct_unit
	IS
		rcError styLD_construct_unit;
	BEGIN
		rcError.Construct_Unit_Id:=inuConstruct_Unit_Id;

		Load
		(
			inuConstruct_Unit_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type
	)
	RETURN styLD_construct_unit
	IS
		rcError styLD_construct_unit;
	BEGIN
		rcError.Construct_Unit_Id:=inuConstruct_Unit_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuConstruct_Unit_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuConstruct_Unit_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_construct_unit
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_construct_unit
	)
	IS
		rfLD_construct_unit tyrfLD_construct_unit;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_construct_unit.Construct_Unit_Id,
		            LD_construct_unit.Constructive_Unit,
		            LD_construct_unit.Description,
		            LD_construct_unit.Active,
		            LD_construct_unit.rowid
                FROM LD_construct_unit';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_construct_unit for sbFullQuery;
		fetch rfLD_construct_unit bulk collect INTO otbResult;
		close rfLD_construct_unit;
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
		            LD_construct_unit.Construct_Unit_Id,
		            LD_construct_unit.Constructive_Unit,
		            LD_construct_unit.Description,
		            LD_construct_unit.Active,
		            LD_construct_unit.rowid
                FROM LD_construct_unit';
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
		ircLD_construct_unit in styLD_construct_unit
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_construct_unit,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_construct_unit in styLD_construct_unit,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_construct_unit.Construct_Unit_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|Construct_Unit_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_construct_unit
		(
			Construct_Unit_Id,
			Constructive_Unit,
			Description,
			Active
		)
		values
		(
			ircLD_construct_unit.Construct_Unit_Id,
			ircLD_construct_unit.Constructive_Unit,
			ircLD_construct_unit.Description,
			ircLD_construct_unit.Active
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_construct_unit));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_construct_unit in out nocopy tytbLD_construct_unit
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_construct_unit, blUseRowID);
		forall n in iotbLD_construct_unit.first..iotbLD_construct_unit.last
			insert into LD_construct_unit
			(
			Construct_Unit_Id,
			Constructive_Unit,
			Description,
			Active
		)
		values
		(
			rcRecOfTab.Construct_Unit_Id(n),
			rcRecOfTab.Constructive_Unit(n),
			rcRecOfTab.Description(n),
			rcRecOfTab.Active(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_construct_unit;
	BEGIN
		rcError.Construct_Unit_Id:=inuConstruct_Unit_Id;

		if inuLock=1 then
			LockByPk
			(
				inuConstruct_Unit_Id,
				rcData
			);
		end if;

		delete
		from LD_construct_unit
		where
       		Construct_Unit_Id=inuConstruct_Unit_Id;
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
		rcError  styLD_construct_unit;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_construct_unit
		where
			rowid = iriRowID
		returning
   Construct_Unit_Id
		into
			rcError.Construct_Unit_Id;

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
		iotbLD_construct_unit in out nocopy tytbLD_construct_unit,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_construct_unit;
	BEGIN
		FillRecordOfTables(iotbLD_construct_unit, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_construct_unit.first .. iotbLD_construct_unit.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_construct_unit.first .. iotbLD_construct_unit.last
				delete
				from LD_construct_unit
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_construct_unit.first .. iotbLD_construct_unit.last loop
					LockByPk
					(
							rcRecOfTab.Construct_Unit_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_construct_unit.first .. iotbLD_construct_unit.last
				delete
				from LD_construct_unit
				where
		         	Construct_Unit_Id = rcRecOfTab.Construct_Unit_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_construct_unit in styLD_construct_unit,
		inuLock	  in number default 0
	)
	IS
		nuConstruct_Unit_Id LD_construct_unit.Construct_Unit_Id%type;

	BEGIN
		if ircLD_construct_unit.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_construct_unit.rowid,rcData);
			end if;
			update LD_construct_unit
			set

        Constructive_Unit = ircLD_construct_unit.Constructive_Unit,
        Description = ircLD_construct_unit.Description,
        Active = ircLD_construct_unit.Active
			where
				rowid = ircLD_construct_unit.rowid
			returning
    Construct_Unit_Id
			into
				nuConstruct_Unit_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_construct_unit.Construct_Unit_Id,
					rcData
				);
			end if;

			update LD_construct_unit
			set
        Constructive_Unit = ircLD_construct_unit.Constructive_Unit,
        Description = ircLD_construct_unit.Description,
        Active = ircLD_construct_unit.Active
			where
	         	Construct_Unit_Id = ircLD_construct_unit.Construct_Unit_Id
			returning
    Construct_Unit_Id
			into
				nuConstruct_Unit_Id;
		end if;

		if
			nuConstruct_Unit_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_construct_unit));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_construct_unit in out nocopy tytbLD_construct_unit,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_construct_unit;
  BEGIN
    FillRecordOfTables(iotbLD_construct_unit,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_construct_unit.first .. iotbLD_construct_unit.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_construct_unit.first .. iotbLD_construct_unit.last
        update LD_construct_unit
        set

            Constructive_Unit = rcRecOfTab.Constructive_Unit(n),
            Description = rcRecOfTab.Description(n),
            Active = rcRecOfTab.Active(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_construct_unit.first .. iotbLD_construct_unit.last loop
          LockByPk
          (
              rcRecOfTab.Construct_Unit_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_construct_unit.first .. iotbLD_construct_unit.last
        update LD_construct_unit
        set
					Constructive_Unit = rcRecOfTab.Constructive_Unit(n),
					Description = rcRecOfTab.Description(n),
					Active = rcRecOfTab.Active(n)
          where
          Construct_Unit_Id = rcRecOfTab.Construct_Unit_Id(n)
;
    end if;
  END;

	PROCEDURE updConstructive_Unit
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		isbConstructive_Unit$ in LD_construct_unit.Constructive_Unit%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_construct_unit;
	BEGIN
		rcError.Construct_Unit_Id := inuConstruct_Unit_Id;
		if inuLock=1 then
			LockByPk
			(
				inuConstruct_Unit_Id,
				rcData
			);
		end if;

		update LD_construct_unit
		set
			Constructive_Unit = isbConstructive_Unit$
		where
			Construct_Unit_Id = inuConstruct_Unit_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Constructive_Unit:= isbConstructive_Unit$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updDescription
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		isbDescription$ in LD_construct_unit.Description%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_construct_unit;
	BEGIN
		rcError.Construct_Unit_Id := inuConstruct_Unit_Id;
		if inuLock=1 then
			LockByPk
			(
				inuConstruct_Unit_Id,
				rcData
			);
		end if;

		update LD_construct_unit
		set
			Description = isbDescription$
		where
			Construct_Unit_Id = inuConstruct_Unit_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Description:= isbDescription$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updActive
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		isbActive$ in LD_construct_unit.Active%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_construct_unit;
	BEGIN
		rcError.Construct_Unit_Id := inuConstruct_Unit_Id;
		if inuLock=1 then
			LockByPk
			(
				inuConstruct_Unit_Id,
				rcData
			);
		end if;

		update LD_construct_unit
		set
			Active = isbActive$
		where
			Construct_Unit_Id = inuConstruct_Unit_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Active:= isbActive$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetConstruct_Unit_Id
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_construct_unit.Construct_Unit_Id%type
	IS
		rcError styLD_construct_unit;
	BEGIN

		rcError.Construct_Unit_Id := inuConstruct_Unit_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuConstruct_Unit_Id
			 )
		then
			 return(rcData.Construct_Unit_Id);
		end if;
		Load
		(
			inuConstruct_Unit_Id
		);
		return(rcData.Construct_Unit_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetConstructive_Unit
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_construct_unit.Constructive_Unit%type
	IS
		rcError styLD_construct_unit;
	BEGIN

		rcError.Construct_Unit_Id:=inuConstruct_Unit_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuConstruct_Unit_Id
			 )
		then
			 return(rcData.Constructive_Unit);
		end if;
		Load
		(
			inuConstruct_Unit_Id
		);
		return(rcData.Constructive_Unit);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetDescription
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_construct_unit.Description%type
	IS
		rcError styLD_construct_unit;
	BEGIN

		rcError.Construct_Unit_Id:=inuConstruct_Unit_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuConstruct_Unit_Id
			 )
		then
			 return(rcData.Description);
		end if;
		Load
		(
			inuConstruct_Unit_Id
		);
		return(rcData.Description);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetActive
	(
		inuConstruct_Unit_Id in LD_construct_unit.Construct_Unit_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_construct_unit.Active%type
	IS
		rcError styLD_construct_unit;
	BEGIN

		rcError.Construct_Unit_Id:=inuConstruct_Unit_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuConstruct_Unit_Id
			 )
		then
			 return(rcData.Active);
		end if;
		Load
		(
			inuConstruct_Unit_Id
		);
		return(rcData.Active);
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
end DALD_construct_unit;
/
PROMPT Otorgando permisos de ejecucion a DALD_CONSTRUCT_UNIT
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_CONSTRUCT_UNIT', 'ADM_PERSON');
END;
/