CREATE OR REPLACE PACKAGE adm_person.dald_bine_fina_ent
is
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   11/06/2024   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type
  )
  IS
		SELECT LD_bine_fina_ent.*,LD_bine_fina_ent.rowid
		FROM LD_bine_fina_ent
		WHERE
			BINE_FINA_ENT_Id = inuBINE_FINA_ENT_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_bine_fina_ent.*,LD_bine_fina_ent.rowid
		FROM LD_bine_fina_ent
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_bine_fina_ent  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_bine_fina_ent is table of styLD_bine_fina_ent index by binary_integer;
	type tyrfRecords is ref cursor return styLD_bine_fina_ent;

	/* Tipos referenciando al registro */
	type tytbBine_Fina_Ent_Id is table of LD_bine_fina_ent.Bine_Fina_Ent_Id%type index by binary_integer;
	type tytbId_Contratista is table of LD_bine_fina_ent.Id_Contratista%type index by binary_integer;
	type tytbServcodi is table of LD_bine_fina_ent.Servcodi%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_bine_fina_ent is record
	(

		Bine_Fina_Ent_Id   tytbBine_Fina_Ent_Id,
		Id_Contratista   tytbId_Contratista,
		Servcodi   tytbServcodi,
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
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type
	);

	PROCEDURE getRecord
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
		orcRecord out nocopy styLD_bine_fina_ent
	);

	FUNCTION frcGetRcData
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type
	)
	RETURN styLD_bine_fina_ent;

	FUNCTION frcGetRcData
	RETURN styLD_bine_fina_ent;

	FUNCTION frcGetRecord
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type
	)
	RETURN styLD_bine_fina_ent;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_bine_fina_ent
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_bine_fina_ent in styLD_bine_fina_ent
	);

 	  PROCEDURE insRecord
	(
		ircLD_bine_fina_ent in styLD_bine_fina_ent,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_bine_fina_ent in out nocopy tytbLD_bine_fina_ent
	);

	PROCEDURE delRecord
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_bine_fina_ent in out nocopy tytbLD_bine_fina_ent,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_bine_fina_ent in styLD_bine_fina_ent,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_bine_fina_ent in out nocopy tytbLD_bine_fina_ent,
		inuLock in number default 1
	);

		PROCEDURE updBine_Fina_Ent_Id
		(
				inuBINE_FINA_ENT_Id   in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
				isbBine_Fina_Ent_Id$  in LD_bine_fina_ent.Bine_Fina_Ent_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updId_Contratista
		(
				inuBINE_FINA_ENT_Id   in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
				inuId_Contratista$  in LD_bine_fina_ent.Id_Contratista%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updServcodi
		(
				inuBINE_FINA_ENT_Id   in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
				inuServcodi$  in LD_bine_fina_ent.Servcodi%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fsbGetBine_Fina_Ent_Id
    	(
    	    inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bine_fina_ent.Bine_Fina_Ent_Id%type;

    	FUNCTION fnuGetId_Contratista
    	(
    	    inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bine_fina_ent.Id_Contratista%type;

    	FUNCTION fnuGetServcodi
    	(
    	    inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bine_fina_ent.Servcodi%type;


	PROCEDURE LockByPk
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
		orcLD_bine_fina_ent  out styLD_bine_fina_ent
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_bine_fina_ent  out styLD_bine_fina_ent
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_bine_fina_ent;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_bine_fina_ent
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156922';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_BINE_FINA_ENT';
	  cnuGeEntityId constant varchar2(30) := 8236; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type
	)
	IS
		SELECT LD_bine_fina_ent.*,LD_bine_fina_ent.rowid
		FROM LD_bine_fina_ent
		WHERE  BINE_FINA_ENT_Id = inuBINE_FINA_ENT_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_bine_fina_ent.*,LD_bine_fina_ent.rowid
		FROM LD_bine_fina_ent
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_bine_fina_ent is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_bine_fina_ent;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_bine_fina_ent default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.BINE_FINA_ENT_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
		orcLD_bine_fina_ent  out styLD_bine_fina_ent
	)
	IS
		rcError styLD_bine_fina_ent;
	BEGIN
		rcError.BINE_FINA_ENT_Id := inuBINE_FINA_ENT_Id;

		Open cuLockRcByPk
		(
			inuBINE_FINA_ENT_Id
		);

		fetch cuLockRcByPk into orcLD_bine_fina_ent;
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
		orcLD_bine_fina_ent  out styLD_bine_fina_ent
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_bine_fina_ent;
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
		itbLD_bine_fina_ent  in out nocopy tytbLD_bine_fina_ent
	)
	IS
	BEGIN
			rcRecOfTab.Bine_Fina_Ent_Id.delete;
			rcRecOfTab.Id_Contratista.delete;
			rcRecOfTab.Servcodi.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_bine_fina_ent  in out nocopy tytbLD_bine_fina_ent,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_bine_fina_ent);
		for n in itbLD_bine_fina_ent.first .. itbLD_bine_fina_ent.last loop
			rcRecOfTab.Bine_Fina_Ent_Id(n) := itbLD_bine_fina_ent(n).Bine_Fina_Ent_Id;
			rcRecOfTab.Id_Contratista(n) := itbLD_bine_fina_ent(n).Id_Contratista;
			rcRecOfTab.Servcodi(n) := itbLD_bine_fina_ent(n).Servcodi;
			rcRecOfTab.row_id(n) := itbLD_bine_fina_ent(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuBINE_FINA_ENT_Id
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
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuBINE_FINA_ENT_Id = rcData.BINE_FINA_ENT_Id
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
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuBINE_FINA_ENT_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type
	)
	IS
		rcError styLD_bine_fina_ent;
	BEGIN		rcError.BINE_FINA_ENT_Id:=inuBINE_FINA_ENT_Id;

		Load
		(
			inuBINE_FINA_ENT_Id
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
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuBINE_FINA_ENT_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
		orcRecord out nocopy styLD_bine_fina_ent
	)
	IS
		rcError styLD_bine_fina_ent;
	BEGIN		rcError.BINE_FINA_ENT_Id:=inuBINE_FINA_ENT_Id;

		Load
		(
			inuBINE_FINA_ENT_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type
	)
	RETURN styLD_bine_fina_ent
	IS
		rcError styLD_bine_fina_ent;
	BEGIN
		rcError.BINE_FINA_ENT_Id:=inuBINE_FINA_ENT_Id;

		Load
		(
			inuBINE_FINA_ENT_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type
	)
	RETURN styLD_bine_fina_ent
	IS
		rcError styLD_bine_fina_ent;
	BEGIN
		rcError.BINE_FINA_ENT_Id:=inuBINE_FINA_ENT_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBINE_FINA_ENT_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuBINE_FINA_ENT_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_bine_fina_ent
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_bine_fina_ent
	)
	IS
		rfLD_bine_fina_ent tyrfLD_bine_fina_ent;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_bine_fina_ent.Bine_Fina_Ent_Id,
		            LD_bine_fina_ent.Id_Contratista,
		            LD_bine_fina_ent.Servcodi,
		            LD_bine_fina_ent.rowid
                FROM LD_bine_fina_ent';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_bine_fina_ent for sbFullQuery;
		fetch rfLD_bine_fina_ent bulk collect INTO otbResult;
		close rfLD_bine_fina_ent;
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
		            LD_bine_fina_ent.Bine_Fina_Ent_Id,
		            LD_bine_fina_ent.Id_Contratista,
		            LD_bine_fina_ent.Servcodi,
		            LD_bine_fina_ent.rowid
                FROM LD_bine_fina_ent';
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
		ircLD_bine_fina_ent in styLD_bine_fina_ent
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_bine_fina_ent,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_bine_fina_ent in styLD_bine_fina_ent,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_bine_fina_ent.BINE_FINA_ENT_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|BINE_FINA_ENT_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_bine_fina_ent
		(
			Bine_Fina_Ent_Id,
			Id_Contratista,
			Servcodi
		)
		values
		(
			ircLD_bine_fina_ent.Bine_Fina_Ent_Id,
			ircLD_bine_fina_ent.Id_Contratista,
			ircLD_bine_fina_ent.Servcodi
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_bine_fina_ent));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_bine_fina_ent in out nocopy tytbLD_bine_fina_ent
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_bine_fina_ent, blUseRowID);
		forall n in iotbLD_bine_fina_ent.first..iotbLD_bine_fina_ent.last
			insert into LD_bine_fina_ent
			(
			Bine_Fina_Ent_Id,
			Id_Contratista,
			Servcodi
		)
		values
		(
			rcRecOfTab.Bine_Fina_Ent_Id(n),
			rcRecOfTab.Id_Contratista(n),
			rcRecOfTab.Servcodi(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_bine_fina_ent;
	BEGIN
		rcError.BINE_FINA_ENT_Id:=inuBINE_FINA_ENT_Id;

		if inuLock=1 then
			LockByPk
			(
				inuBINE_FINA_ENT_Id,
				rcData
			);
		end if;

		delete
		from LD_bine_fina_ent
		where
       		BINE_FINA_ENT_Id=inuBINE_FINA_ENT_Id;
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
		rcError  styLD_bine_fina_ent;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_bine_fina_ent
		where
			rowid = iriRowID
		returning
   BINE_FINA_ENT_Id
		into
			rcError.BINE_FINA_ENT_Id;

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
		iotbLD_bine_fina_ent in out nocopy tytbLD_bine_fina_ent,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_bine_fina_ent;
	BEGIN
		FillRecordOfTables(iotbLD_bine_fina_ent, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_bine_fina_ent.first .. iotbLD_bine_fina_ent.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_bine_fina_ent.first .. iotbLD_bine_fina_ent.last
				delete
				from LD_bine_fina_ent
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_bine_fina_ent.first .. iotbLD_bine_fina_ent.last loop
					LockByPk
					(
							rcRecOfTab.BINE_FINA_ENT_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_bine_fina_ent.first .. iotbLD_bine_fina_ent.last
				delete
				from LD_bine_fina_ent
				where
		         	BINE_FINA_ENT_Id = rcRecOfTab.BINE_FINA_ENT_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_bine_fina_ent in styLD_bine_fina_ent,
		inuLock	  in number default 0
	)
	IS
		nuBINE_FINA_ENT_Id LD_bine_fina_ent.BINE_FINA_ENT_Id%type;

	BEGIN
		if ircLD_bine_fina_ent.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_bine_fina_ent.rowid,rcData);
			end if;
			update LD_bine_fina_ent
			set

        Bine_Fina_Ent_Id = ircLD_bine_fina_ent.Bine_Fina_Ent_Id,
        Id_Contratista = ircLD_bine_fina_ent.Id_Contratista,
        Servcodi = ircLD_bine_fina_ent.Servcodi
			where
				rowid = ircLD_bine_fina_ent.rowid
			returning
    BINE_FINA_ENT_Id
			into
				nuBINE_FINA_ENT_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_bine_fina_ent.BINE_FINA_ENT_Id,
					rcData
				);
			end if;

			update LD_bine_fina_ent
			set
        Bine_Fina_Ent_Id = ircLD_bine_fina_ent.Bine_Fina_Ent_Id,
        Id_Contratista = ircLD_bine_fina_ent.Id_Contratista,
        Servcodi = ircLD_bine_fina_ent.Servcodi
			where
	         	BINE_FINA_ENT_Id = ircLD_bine_fina_ent.BINE_FINA_ENT_Id
			returning
    BINE_FINA_ENT_Id
			into
				nuBINE_FINA_ENT_Id;
		end if;

		if
			nuBINE_FINA_ENT_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_bine_fina_ent));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_bine_fina_ent in out nocopy tytbLD_bine_fina_ent,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_bine_fina_ent;
  BEGIN
    FillRecordOfTables(iotbLD_bine_fina_ent,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_bine_fina_ent.first .. iotbLD_bine_fina_ent.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_bine_fina_ent.first .. iotbLD_bine_fina_ent.last
        update LD_bine_fina_ent
        set

            Bine_Fina_Ent_Id = rcRecOfTab.Bine_Fina_Ent_Id(n),
            Id_Contratista = rcRecOfTab.Id_Contratista(n),
            Servcodi = rcRecOfTab.Servcodi(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_bine_fina_ent.first .. iotbLD_bine_fina_ent.last loop
          LockByPk
          (
              rcRecOfTab.BINE_FINA_ENT_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_bine_fina_ent.first .. iotbLD_bine_fina_ent.last
        update LD_bine_fina_ent
        set
					Bine_Fina_Ent_Id = rcRecOfTab.Bine_Fina_Ent_Id(n),
					Id_Contratista = rcRecOfTab.Id_Contratista(n),
					Servcodi = rcRecOfTab.Servcodi(n)
          where
          BINE_FINA_ENT_Id = rcRecOfTab.BINE_FINA_ENT_Id(n)
;
    end if;
  END;

	PROCEDURE updBine_Fina_Ent_Id
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
		isbBine_Fina_Ent_Id$ in LD_bine_fina_ent.Bine_Fina_Ent_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bine_fina_ent;
	BEGIN
		rcError.BINE_FINA_ENT_Id := inuBINE_FINA_ENT_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBINE_FINA_ENT_Id,
				rcData
			);
		end if;

		update LD_bine_fina_ent
		set
			Bine_Fina_Ent_Id = isbBine_Fina_Ent_Id$
		where
			BINE_FINA_ENT_Id = inuBINE_FINA_ENT_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Bine_Fina_Ent_Id:= isbBine_Fina_Ent_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updId_Contratista
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
		inuId_Contratista$ in LD_bine_fina_ent.Id_Contratista%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bine_fina_ent;
	BEGIN
		rcError.BINE_FINA_ENT_Id := inuBINE_FINA_ENT_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBINE_FINA_ENT_Id,
				rcData
			);
		end if;

		update LD_bine_fina_ent
		set
			Id_Contratista = inuId_Contratista$
		where
			BINE_FINA_ENT_Id = inuBINE_FINA_ENT_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Id_Contratista:= inuId_Contratista$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updServcodi
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
		inuServcodi$ in LD_bine_fina_ent.Servcodi%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bine_fina_ent;
	BEGIN
		rcError.BINE_FINA_ENT_Id := inuBINE_FINA_ENT_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBINE_FINA_ENT_Id,
				rcData
			);
		end if;

		update LD_bine_fina_ent
		set
			Servcodi = inuServcodi$
		where
			BINE_FINA_ENT_Id = inuBINE_FINA_ENT_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Servcodi:= inuServcodi$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fsbGetBine_Fina_Ent_Id
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bine_fina_ent.Bine_Fina_Ent_Id%type
	IS
		rcError styLD_bine_fina_ent;
	BEGIN

		rcError.BINE_FINA_ENT_Id:=inuBINE_FINA_ENT_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBINE_FINA_ENT_Id
			 )
		then
			 return(rcData.Bine_Fina_Ent_Id);
		end if;
		Load
		(
			inuBINE_FINA_ENT_Id
		);
		return(rcData.Bine_Fina_Ent_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetId_Contratista
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bine_fina_ent.Id_Contratista%type
	IS
		rcError styLD_bine_fina_ent;
	BEGIN

		rcError.BINE_FINA_ENT_Id := inuBINE_FINA_ENT_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBINE_FINA_ENT_Id
			 )
		then
			 return(rcData.Id_Contratista);
		end if;
		Load
		(
			inuBINE_FINA_ENT_Id
		);
		return(rcData.Id_Contratista);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetServcodi
	(
		inuBINE_FINA_ENT_Id in LD_bine_fina_ent.BINE_FINA_ENT_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bine_fina_ent.Servcodi%type
	IS
		rcError styLD_bine_fina_ent;
	BEGIN

		rcError.BINE_FINA_ENT_Id := inuBINE_FINA_ENT_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBINE_FINA_ENT_Id
			 )
		then
			 return(rcData.Servcodi);
		end if;
		Load
		(
			inuBINE_FINA_ENT_Id
		);
		return(rcData.Servcodi);
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
end DALD_bine_fina_ent;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_BINE_FINA_ENT
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_BINE_FINA_ENT', 'ADM_PERSON'); 
END;
/