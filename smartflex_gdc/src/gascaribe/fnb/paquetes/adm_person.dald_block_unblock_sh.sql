CREATE OR REPLACE PACKAGE adm_person.dald_block_unblock_sh
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  04/06/2024   Adrianavg   OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type
  )
  IS
		SELECT LD_block_unblock_sh.*,LD_block_unblock_sh.rowid
		FROM LD_block_unblock_sh
		WHERE
			BLOCK_UNBLOCK_SH_Id = inuBLOCK_UNBLOCK_SH_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_block_unblock_sh.*,LD_block_unblock_sh.rowid
		FROM LD_block_unblock_sh
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_block_unblock_sh  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_block_unblock_sh is table of styLD_block_unblock_sh index by binary_integer;
	type tyrfRecords is ref cursor return styLD_block_unblock_sh;

	/* Tipos referenciando al registro */
	type tytbBlock_Unblock_Sh_Id is table of LD_block_unblock_sh.Block_Unblock_Sh_Id%type index by binary_integer;
	type tytbPackage_Id is table of LD_block_unblock_sh.Package_Id%type index by binary_integer;
	type tytbQuota_Block_Id is table of LD_block_unblock_sh.Quota_Block_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_block_unblock_sh is record
	(

		Block_Unblock_Sh_Id   tytbBlock_Unblock_Sh_Id,
		Package_Id   tytbPackage_Id,
		Quota_Block_Id   tytbQuota_Block_Id,
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
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type
	);

	PROCEDURE getRecord
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type,
		orcRecord out nocopy styLD_block_unblock_sh
	);

	FUNCTION frcGetRcData
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type
	)
	RETURN styLD_block_unblock_sh;

	FUNCTION frcGetRcData
	RETURN styLD_block_unblock_sh;

	FUNCTION frcGetRecord
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type
	)
	RETURN styLD_block_unblock_sh;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_block_unblock_sh
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_block_unblock_sh in styLD_block_unblock_sh
	);

 	  PROCEDURE insRecord
	(
		ircLD_block_unblock_sh in styLD_block_unblock_sh,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_block_unblock_sh in out nocopy tytbLD_block_unblock_sh
	);

	PROCEDURE delRecord
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_block_unblock_sh in out nocopy tytbLD_block_unblock_sh,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_block_unblock_sh in styLD_block_unblock_sh,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_block_unblock_sh in out nocopy tytbLD_block_unblock_sh,
		inuLock in number default 1
	);

		PROCEDURE updPackage_Id
		(
				inuBLOCK_UNBLOCK_SH_Id   in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type,
				inuPackage_Id$  in LD_block_unblock_sh.Package_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updQuota_Block_Id
		(
				inuBLOCK_UNBLOCK_SH_Id   in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type,
				inuQuota_Block_Id$  in LD_block_unblock_sh.Quota_Block_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetBlock_Unblock_Sh_Id
    	(
    	    inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_block_unblock_sh.Block_Unblock_Sh_Id%type;

    	FUNCTION fnuGetPackage_Id
    	(
    	    inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_block_unblock_sh.Package_Id%type;

    	FUNCTION fnuGetQuota_Block_Id
    	(
    	    inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_block_unblock_sh.Quota_Block_Id%type;


	PROCEDURE LockByPk
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type,
		orcLD_block_unblock_sh  out styLD_block_unblock_sh
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_block_unblock_sh  out styLD_block_unblock_sh
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_block_unblock_sh;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_block_unblock_sh
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_BLOCK_UNBLOCK_SH';
	  cnuGeEntityId constant varchar2(30) := 8224; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type
	)
	IS
		SELECT LD_block_unblock_sh.*,LD_block_unblock_sh.rowid
		FROM LD_block_unblock_sh
		WHERE  BLOCK_UNBLOCK_SH_Id = inuBLOCK_UNBLOCK_SH_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_block_unblock_sh.*,LD_block_unblock_sh.rowid
		FROM LD_block_unblock_sh
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_block_unblock_sh is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_block_unblock_sh;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_block_unblock_sh default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.BLOCK_UNBLOCK_SH_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type,
		orcLD_block_unblock_sh  out styLD_block_unblock_sh
	)
	IS
		rcError styLD_block_unblock_sh;
	BEGIN
		rcError.BLOCK_UNBLOCK_SH_Id := inuBLOCK_UNBLOCK_SH_Id;

		Open cuLockRcByPk
		(
			inuBLOCK_UNBLOCK_SH_Id
		);

		fetch cuLockRcByPk into orcLD_block_unblock_sh;
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
		orcLD_block_unblock_sh  out styLD_block_unblock_sh
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_block_unblock_sh;
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
		itbLD_block_unblock_sh  in out nocopy tytbLD_block_unblock_sh
	)
	IS
	BEGIN
			rcRecOfTab.Block_Unblock_Sh_Id.delete;
			rcRecOfTab.Package_Id.delete;
			rcRecOfTab.Quota_Block_Id.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_block_unblock_sh  in out nocopy tytbLD_block_unblock_sh,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_block_unblock_sh);
		for n in itbLD_block_unblock_sh.first .. itbLD_block_unblock_sh.last loop
			rcRecOfTab.Block_Unblock_Sh_Id(n) := itbLD_block_unblock_sh(n).Block_Unblock_Sh_Id;
			rcRecOfTab.Package_Id(n) := itbLD_block_unblock_sh(n).Package_Id;
			rcRecOfTab.Quota_Block_Id(n) := itbLD_block_unblock_sh(n).Quota_Block_Id;
			rcRecOfTab.row_id(n) := itbLD_block_unblock_sh(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuBLOCK_UNBLOCK_SH_Id
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
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuBLOCK_UNBLOCK_SH_Id = rcData.BLOCK_UNBLOCK_SH_Id
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
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuBLOCK_UNBLOCK_SH_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type
	)
	IS
		rcError styLD_block_unblock_sh;
	BEGIN		rcError.BLOCK_UNBLOCK_SH_Id:=inuBLOCK_UNBLOCK_SH_Id;

		Load
		(
			inuBLOCK_UNBLOCK_SH_Id
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
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuBLOCK_UNBLOCK_SH_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type,
		orcRecord out nocopy styLD_block_unblock_sh
	)
	IS
		rcError styLD_block_unblock_sh;
	BEGIN		rcError.BLOCK_UNBLOCK_SH_Id:=inuBLOCK_UNBLOCK_SH_Id;

		Load
		(
			inuBLOCK_UNBLOCK_SH_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type
	)
	RETURN styLD_block_unblock_sh
	IS
		rcError styLD_block_unblock_sh;
	BEGIN
		rcError.BLOCK_UNBLOCK_SH_Id:=inuBLOCK_UNBLOCK_SH_Id;

		Load
		(
			inuBLOCK_UNBLOCK_SH_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type
	)
	RETURN styLD_block_unblock_sh
	IS
		rcError styLD_block_unblock_sh;
	BEGIN
		rcError.BLOCK_UNBLOCK_SH_Id:=inuBLOCK_UNBLOCK_SH_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOCK_UNBLOCK_SH_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuBLOCK_UNBLOCK_SH_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_block_unblock_sh
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_block_unblock_sh
	)
	IS
		rfLD_block_unblock_sh tyrfLD_block_unblock_sh;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_block_unblock_sh.Block_Unblock_Sh_Id,
		            LD_block_unblock_sh.Package_Id,
		            LD_block_unblock_sh.Quota_Block_Id,
		            LD_block_unblock_sh.rowid
                FROM LD_block_unblock_sh';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_block_unblock_sh for sbFullQuery;
		fetch rfLD_block_unblock_sh bulk collect INTO otbResult;
		close rfLD_block_unblock_sh;
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
		            LD_block_unblock_sh.Block_Unblock_Sh_Id,
		            LD_block_unblock_sh.Package_Id,
		            LD_block_unblock_sh.Quota_Block_Id,
		            LD_block_unblock_sh.rowid
                FROM LD_block_unblock_sh';
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
		ircLD_block_unblock_sh in styLD_block_unblock_sh
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_block_unblock_sh,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_block_unblock_sh in styLD_block_unblock_sh,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|BLOCK_UNBLOCK_SH_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_block_unblock_sh
		(
			Block_Unblock_Sh_Id,
			Package_Id,
			Quota_Block_Id
		)
		values
		(
			ircLD_block_unblock_sh.Block_Unblock_Sh_Id,
			ircLD_block_unblock_sh.Package_Id,
			ircLD_block_unblock_sh.Quota_Block_Id
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_block_unblock_sh));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_block_unblock_sh in out nocopy tytbLD_block_unblock_sh
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_block_unblock_sh, blUseRowID);
		forall n in iotbLD_block_unblock_sh.first..iotbLD_block_unblock_sh.last
			insert into LD_block_unblock_sh
			(
			Block_Unblock_Sh_Id,
			Package_Id,
			Quota_Block_Id
		)
		values
		(
			rcRecOfTab.Block_Unblock_Sh_Id(n),
			rcRecOfTab.Package_Id(n),
			rcRecOfTab.Quota_Block_Id(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_block_unblock_sh;
	BEGIN
		rcError.BLOCK_UNBLOCK_SH_Id:=inuBLOCK_UNBLOCK_SH_Id;

		if inuLock=1 then
			LockByPk
			(
				inuBLOCK_UNBLOCK_SH_Id,
				rcData
			);
		end if;

		delete
		from LD_block_unblock_sh
		where
       		BLOCK_UNBLOCK_SH_Id=inuBLOCK_UNBLOCK_SH_Id;
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
		rcError  styLD_block_unblock_sh;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_block_unblock_sh
		where
			rowid = iriRowID
		returning
   BLOCK_UNBLOCK_SH_Id
		into
			rcError.BLOCK_UNBLOCK_SH_Id;

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
		iotbLD_block_unblock_sh in out nocopy tytbLD_block_unblock_sh,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_block_unblock_sh;
	BEGIN
		FillRecordOfTables(iotbLD_block_unblock_sh, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_block_unblock_sh.first .. iotbLD_block_unblock_sh.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_block_unblock_sh.first .. iotbLD_block_unblock_sh.last
				delete
				from LD_block_unblock_sh
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_block_unblock_sh.first .. iotbLD_block_unblock_sh.last loop
					LockByPk
					(
							rcRecOfTab.BLOCK_UNBLOCK_SH_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_block_unblock_sh.first .. iotbLD_block_unblock_sh.last
				delete
				from LD_block_unblock_sh
				where
		         	BLOCK_UNBLOCK_SH_Id = rcRecOfTab.BLOCK_UNBLOCK_SH_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_block_unblock_sh in styLD_block_unblock_sh,
		inuLock	  in number default 0
	)
	IS
		nuBLOCK_UNBLOCK_SH_Id LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type;

	BEGIN
		if ircLD_block_unblock_sh.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_block_unblock_sh.rowid,rcData);
			end if;
			update LD_block_unblock_sh
			set

        Package_Id = ircLD_block_unblock_sh.Package_Id,
        Quota_Block_Id = ircLD_block_unblock_sh.Quota_Block_Id
			where
				rowid = ircLD_block_unblock_sh.rowid
			returning
    BLOCK_UNBLOCK_SH_Id
			into
				nuBLOCK_UNBLOCK_SH_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id,
					rcData
				);
			end if;

			update LD_block_unblock_sh
			set
        Package_Id = ircLD_block_unblock_sh.Package_Id,
        Quota_Block_Id = ircLD_block_unblock_sh.Quota_Block_Id
			where
	         	BLOCK_UNBLOCK_SH_Id = ircLD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id
			returning
    BLOCK_UNBLOCK_SH_Id
			into
				nuBLOCK_UNBLOCK_SH_Id;
		end if;

		if
			nuBLOCK_UNBLOCK_SH_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_block_unblock_sh));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_block_unblock_sh in out nocopy tytbLD_block_unblock_sh,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_block_unblock_sh;
  BEGIN
    FillRecordOfTables(iotbLD_block_unblock_sh,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_block_unblock_sh.first .. iotbLD_block_unblock_sh.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_block_unblock_sh.first .. iotbLD_block_unblock_sh.last
        update LD_block_unblock_sh
        set

            Package_Id = rcRecOfTab.Package_Id(n),
            Quota_Block_Id = rcRecOfTab.Quota_Block_Id(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_block_unblock_sh.first .. iotbLD_block_unblock_sh.last loop
          LockByPk
          (
              rcRecOfTab.BLOCK_UNBLOCK_SH_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_block_unblock_sh.first .. iotbLD_block_unblock_sh.last
        update LD_block_unblock_sh
        set
					Package_Id = rcRecOfTab.Package_Id(n),
					Quota_Block_Id = rcRecOfTab.Quota_Block_Id(n)
          where
          BLOCK_UNBLOCK_SH_Id = rcRecOfTab.BLOCK_UNBLOCK_SH_Id(n)
;
    end if;
  END;

	PROCEDURE updPackage_Id
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type,
		inuPackage_Id$ in LD_block_unblock_sh.Package_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_block_unblock_sh;
	BEGIN
		rcError.BLOCK_UNBLOCK_SH_Id := inuBLOCK_UNBLOCK_SH_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBLOCK_UNBLOCK_SH_Id,
				rcData
			);
		end if;

		update LD_block_unblock_sh
		set
			Package_Id = inuPackage_Id$
		where
			BLOCK_UNBLOCK_SH_Id = inuBLOCK_UNBLOCK_SH_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Package_Id:= inuPackage_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updQuota_Block_Id
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type,
		inuQuota_Block_Id$ in LD_block_unblock_sh.Quota_Block_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_block_unblock_sh;
	BEGIN
		rcError.BLOCK_UNBLOCK_SH_Id := inuBLOCK_UNBLOCK_SH_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBLOCK_UNBLOCK_SH_Id,
				rcData
			);
		end if;

		update LD_block_unblock_sh
		set
			Quota_Block_Id = inuQuota_Block_Id$
		where
			BLOCK_UNBLOCK_SH_Id = inuBLOCK_UNBLOCK_SH_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Quota_Block_Id:= inuQuota_Block_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetBlock_Unblock_Sh_Id
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_block_unblock_sh.Block_Unblock_Sh_Id%type
	IS
		rcError styLD_block_unblock_sh;
	BEGIN

		rcError.BLOCK_UNBLOCK_SH_Id := inuBLOCK_UNBLOCK_SH_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBLOCK_UNBLOCK_SH_Id
			 )
		then
			 return(rcData.Block_Unblock_Sh_Id);
		end if;
		Load
		(
			inuBLOCK_UNBLOCK_SH_Id
		);
		return(rcData.Block_Unblock_Sh_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPackage_Id
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_block_unblock_sh.Package_Id%type
	IS
		rcError styLD_block_unblock_sh;
	BEGIN

		rcError.BLOCK_UNBLOCK_SH_Id := inuBLOCK_UNBLOCK_SH_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBLOCK_UNBLOCK_SH_Id
			 )
		then
			 return(rcData.Package_Id);
		end if;
		Load
		(
			inuBLOCK_UNBLOCK_SH_Id
		);
		return(rcData.Package_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetQuota_Block_Id
	(
		inuBLOCK_UNBLOCK_SH_Id in LD_block_unblock_sh.BLOCK_UNBLOCK_SH_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_block_unblock_sh.Quota_Block_Id%type
	IS
		rcError styLD_block_unblock_sh;
	BEGIN

		rcError.BLOCK_UNBLOCK_SH_Id := inuBLOCK_UNBLOCK_SH_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBLOCK_UNBLOCK_SH_Id
			 )
		then
			 return(rcData.Quota_Block_Id);
		end if;
		Load
		(
			inuBLOCK_UNBLOCK_SH_Id
		);
		return(rcData.Quota_Block_Id);
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
end DALD_block_unblock_sh;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_BLOCK_UNBLOCK_SH
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_BLOCK_UNBLOCK_SH', 'ADM_PERSON'); 
END;
/
