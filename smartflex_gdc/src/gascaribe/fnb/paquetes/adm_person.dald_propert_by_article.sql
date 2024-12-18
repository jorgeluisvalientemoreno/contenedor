CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_propert_by_article
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_propert_by_article
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    31/05/2024              PAcosta         OSF-2767: Cambio de esquema ADM_PERSON                                              
    ****************************************************************/       
    
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type
  )
  IS
		SELECT LD_propert_by_article.*,LD_propert_by_article.rowid
		FROM LD_propert_by_article
		WHERE
			PROPERT_BY_ARTICLE_Id = inuPROPERT_BY_ARTICLE_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_propert_by_article.*,LD_propert_by_article.rowid
		FROM LD_propert_by_article
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_propert_by_article  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_propert_by_article is table of styLD_propert_by_article index by binary_integer;
	type tyrfRecords is ref cursor return styLD_propert_by_article;

	/* Tipos referenciando al registro */
	type tytbPropert_By_Article_Id is table of LD_propert_by_article.Propert_By_Article_Id%type index by binary_integer;
	type tytbArticle_Id is table of LD_propert_by_article.Article_Id%type index by binary_integer;
	type tytbProperty_Id is table of LD_propert_by_article.Property_Id%type index by binary_integer;
	type tytbValue is table of LD_propert_by_article.Value%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_propert_by_article is record
	(

		Propert_By_Article_Id   tytbPropert_By_Article_Id,
		Article_Id   tytbArticle_Id,
		Property_Id   tytbProperty_Id,
		Value   tytbValue,
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
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type
	);

	PROCEDURE getRecord
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		orcRecord out nocopy styLD_propert_by_article
	);

	FUNCTION frcGetRcData
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type
	)
	RETURN styLD_propert_by_article;

	FUNCTION frcGetRcData
	RETURN styLD_propert_by_article;

	FUNCTION frcGetRecord
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type
	)
	RETURN styLD_propert_by_article;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_propert_by_article
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_propert_by_article in styLD_propert_by_article
	);

 	  PROCEDURE insRecord
	(
		ircLD_propert_by_article in styLD_propert_by_article,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_propert_by_article in out nocopy tytbLD_propert_by_article
	);

	PROCEDURE delRecord
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_propert_by_article in out nocopy tytbLD_propert_by_article,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_propert_by_article in styLD_propert_by_article,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_propert_by_article in out nocopy tytbLD_propert_by_article,
		inuLock in number default 1
	);

		PROCEDURE updArticle_Id
		(
				inuPROPERT_BY_ARTICLE_Id   in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
				inuArticle_Id$  in LD_propert_by_article.Article_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updProperty_Id
		(
				inuPROPERT_BY_ARTICLE_Id   in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
				inuProperty_Id$  in LD_propert_by_article.Property_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updValue
		(
				inuPROPERT_BY_ARTICLE_Id   in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
				isbValue$  in LD_propert_by_article.Value%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetPropert_By_Article_Id
    	(
    	    inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_propert_by_article.Propert_By_Article_Id%type;

    	FUNCTION fnuGetArticle_Id
    	(
    	    inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_propert_by_article.Article_Id%type;

    	FUNCTION fnuGetProperty_Id
    	(
    	    inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_propert_by_article.Property_Id%type;

    	FUNCTION fsbGetValue
    	(
    	    inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_propert_by_article.Value%type;


	PROCEDURE LockByPk
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		orcLD_propert_by_article  out styLD_propert_by_article
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_propert_by_article  out styLD_propert_by_article
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_propert_by_article;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_propert_by_article
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_PROPERT_BY_ARTICLE';
	  cnuGeEntityId constant varchar2(30) := 8378; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type
	)
	IS
		SELECT LD_propert_by_article.*,LD_propert_by_article.rowid
		FROM LD_propert_by_article
		WHERE  PROPERT_BY_ARTICLE_Id = inuPROPERT_BY_ARTICLE_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_propert_by_article.*,LD_propert_by_article.rowid
		FROM LD_propert_by_article
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_propert_by_article is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_propert_by_article;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_propert_by_article default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PROPERT_BY_ARTICLE_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		orcLD_propert_by_article  out styLD_propert_by_article
	)
	IS
		rcError styLD_propert_by_article;
	BEGIN
		rcError.PROPERT_BY_ARTICLE_Id := inuPROPERT_BY_ARTICLE_Id;

		Open cuLockRcByPk
		(
			inuPROPERT_BY_ARTICLE_Id
		);

		fetch cuLockRcByPk into orcLD_propert_by_article;
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
		orcLD_propert_by_article  out styLD_propert_by_article
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_propert_by_article;
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
		itbLD_propert_by_article  in out nocopy tytbLD_propert_by_article
	)
	IS
	BEGIN
			rcRecOfTab.Propert_By_Article_Id.delete;
			rcRecOfTab.Article_Id.delete;
			rcRecOfTab.Property_Id.delete;
			rcRecOfTab.Value.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_propert_by_article  in out nocopy tytbLD_propert_by_article,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_propert_by_article);
		for n in itbLD_propert_by_article.first .. itbLD_propert_by_article.last loop
			rcRecOfTab.Propert_By_Article_Id(n) := itbLD_propert_by_article(n).Propert_By_Article_Id;
			rcRecOfTab.Article_Id(n) := itbLD_propert_by_article(n).Article_Id;
			rcRecOfTab.Property_Id(n) := itbLD_propert_by_article(n).Property_Id;
			rcRecOfTab.Value(n) := itbLD_propert_by_article(n).Value;
			rcRecOfTab.row_id(n) := itbLD_propert_by_article(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPROPERT_BY_ARTICLE_Id
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
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPROPERT_BY_ARTICLE_Id = rcData.PROPERT_BY_ARTICLE_Id
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
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPROPERT_BY_ARTICLE_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type
	)
	IS
		rcError styLD_propert_by_article;
	BEGIN		rcError.PROPERT_BY_ARTICLE_Id:=inuPROPERT_BY_ARTICLE_Id;

		Load
		(
			inuPROPERT_BY_ARTICLE_Id
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
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuPROPERT_BY_ARTICLE_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		orcRecord out nocopy styLD_propert_by_article
	)
	IS
		rcError styLD_propert_by_article;
	BEGIN		rcError.PROPERT_BY_ARTICLE_Id:=inuPROPERT_BY_ARTICLE_Id;

		Load
		(
			inuPROPERT_BY_ARTICLE_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type
	)
	RETURN styLD_propert_by_article
	IS
		rcError styLD_propert_by_article;
	BEGIN
		rcError.PROPERT_BY_ARTICLE_Id:=inuPROPERT_BY_ARTICLE_Id;

		Load
		(
			inuPROPERT_BY_ARTICLE_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type
	)
	RETURN styLD_propert_by_article
	IS
		rcError styLD_propert_by_article;
	BEGIN
		rcError.PROPERT_BY_ARTICLE_Id:=inuPROPERT_BY_ARTICLE_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROPERT_BY_ARTICLE_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPROPERT_BY_ARTICLE_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_propert_by_article
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_propert_by_article
	)
	IS
		rfLD_propert_by_article tyrfLD_propert_by_article;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_propert_by_article.Propert_By_Article_Id,
		            LD_propert_by_article.Article_Id,
		            LD_propert_by_article.Property_Id,
		            LD_propert_by_article.Value,
		            LD_propert_by_article.rowid
                FROM LD_propert_by_article';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_propert_by_article for sbFullQuery;
		fetch rfLD_propert_by_article bulk collect INTO otbResult;
		close rfLD_propert_by_article;
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
		            LD_propert_by_article.Propert_By_Article_Id,
		            LD_propert_by_article.Article_Id,
		            LD_propert_by_article.Property_Id,
		            LD_propert_by_article.Value,
		            LD_propert_by_article.rowid
                FROM LD_propert_by_article';
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
		ircLD_propert_by_article in styLD_propert_by_article
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_propert_by_article,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_propert_by_article in styLD_propert_by_article,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_propert_by_article.PROPERT_BY_ARTICLE_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|PROPERT_BY_ARTICLE_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_propert_by_article
		(
			Propert_By_Article_Id,
			Article_Id,
			Property_Id,
			Value
		)
		values
		(
			ircLD_propert_by_article.Propert_By_Article_Id,
			ircLD_propert_by_article.Article_Id,
			ircLD_propert_by_article.Property_Id,
			ircLD_propert_by_article.Value
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_propert_by_article));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_propert_by_article in out nocopy tytbLD_propert_by_article
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_propert_by_article, blUseRowID);
		forall n in iotbLD_propert_by_article.first..iotbLD_propert_by_article.last
			insert into LD_propert_by_article
			(
			Propert_By_Article_Id,
			Article_Id,
			Property_Id,
			Value
		)
		values
		(
			rcRecOfTab.Propert_By_Article_Id(n),
			rcRecOfTab.Article_Id(n),
			rcRecOfTab.Property_Id(n),
			rcRecOfTab.Value(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_propert_by_article;
	BEGIN
		rcError.PROPERT_BY_ARTICLE_Id:=inuPROPERT_BY_ARTICLE_Id;

		if inuLock=1 then
			LockByPk
			(
				inuPROPERT_BY_ARTICLE_Id,
				rcData
			);
		end if;

		delete
		from LD_propert_by_article
		where
       		PROPERT_BY_ARTICLE_Id=inuPROPERT_BY_ARTICLE_Id;
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
		rcError  styLD_propert_by_article;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_propert_by_article
		where
			rowid = iriRowID
		returning
   PROPERT_BY_ARTICLE_Id
		into
			rcError.PROPERT_BY_ARTICLE_Id;

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
		iotbLD_propert_by_article in out nocopy tytbLD_propert_by_article,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_propert_by_article;
	BEGIN
		FillRecordOfTables(iotbLD_propert_by_article, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_propert_by_article.first .. iotbLD_propert_by_article.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_propert_by_article.first .. iotbLD_propert_by_article.last
				delete
				from LD_propert_by_article
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_propert_by_article.first .. iotbLD_propert_by_article.last loop
					LockByPk
					(
							rcRecOfTab.PROPERT_BY_ARTICLE_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_propert_by_article.first .. iotbLD_propert_by_article.last
				delete
				from LD_propert_by_article
				where
		         	PROPERT_BY_ARTICLE_Id = rcRecOfTab.PROPERT_BY_ARTICLE_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_propert_by_article in styLD_propert_by_article,
		inuLock	  in number default 0
	)
	IS
		nuPROPERT_BY_ARTICLE_Id LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type;

	BEGIN
		if ircLD_propert_by_article.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_propert_by_article.rowid,rcData);
			end if;
			update LD_propert_by_article
			set

        Article_Id = ircLD_propert_by_article.Article_Id,
        Property_Id = ircLD_propert_by_article.Property_Id,
        Value = ircLD_propert_by_article.Value
			where
				rowid = ircLD_propert_by_article.rowid
			returning
    PROPERT_BY_ARTICLE_Id
			into
				nuPROPERT_BY_ARTICLE_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_propert_by_article.PROPERT_BY_ARTICLE_Id,
					rcData
				);
			end if;

			update LD_propert_by_article
			set
        Article_Id = ircLD_propert_by_article.Article_Id,
        Property_Id = ircLD_propert_by_article.Property_Id,
        Value = ircLD_propert_by_article.Value
			where
	         	PROPERT_BY_ARTICLE_Id = ircLD_propert_by_article.PROPERT_BY_ARTICLE_Id
			returning
    PROPERT_BY_ARTICLE_Id
			into
				nuPROPERT_BY_ARTICLE_Id;
		end if;

		if
			nuPROPERT_BY_ARTICLE_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_propert_by_article));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_propert_by_article in out nocopy tytbLD_propert_by_article,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_propert_by_article;
  BEGIN
    FillRecordOfTables(iotbLD_propert_by_article,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_propert_by_article.first .. iotbLD_propert_by_article.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_propert_by_article.first .. iotbLD_propert_by_article.last
        update LD_propert_by_article
        set

            Article_Id = rcRecOfTab.Article_Id(n),
            Property_Id = rcRecOfTab.Property_Id(n),
            Value = rcRecOfTab.Value(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_propert_by_article.first .. iotbLD_propert_by_article.last loop
          LockByPk
          (
              rcRecOfTab.PROPERT_BY_ARTICLE_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_propert_by_article.first .. iotbLD_propert_by_article.last
        update LD_propert_by_article
        set
					Article_Id = rcRecOfTab.Article_Id(n),
					Property_Id = rcRecOfTab.Property_Id(n),
					Value = rcRecOfTab.Value(n)
          where
          PROPERT_BY_ARTICLE_Id = rcRecOfTab.PROPERT_BY_ARTICLE_Id(n)
;
    end if;
  END;

	PROCEDURE updArticle_Id
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		inuArticle_Id$ in LD_propert_by_article.Article_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_propert_by_article;
	BEGIN
		rcError.PROPERT_BY_ARTICLE_Id := inuPROPERT_BY_ARTICLE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPROPERT_BY_ARTICLE_Id,
				rcData
			);
		end if;

		update LD_propert_by_article
		set
			Article_Id = inuArticle_Id$
		where
			PROPERT_BY_ARTICLE_Id = inuPROPERT_BY_ARTICLE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Article_Id:= inuArticle_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updProperty_Id
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		inuProperty_Id$ in LD_propert_by_article.Property_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_propert_by_article;
	BEGIN
		rcError.PROPERT_BY_ARTICLE_Id := inuPROPERT_BY_ARTICLE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPROPERT_BY_ARTICLE_Id,
				rcData
			);
		end if;

		update LD_propert_by_article
		set
			Property_Id = inuProperty_Id$
		where
			PROPERT_BY_ARTICLE_Id = inuPROPERT_BY_ARTICLE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Property_Id:= inuProperty_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updValue
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		isbValue$ in LD_propert_by_article.Value%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_propert_by_article;
	BEGIN
		rcError.PROPERT_BY_ARTICLE_Id := inuPROPERT_BY_ARTICLE_Id;
		if inuLock=1 then
			LockByPk
			(
				inuPROPERT_BY_ARTICLE_Id,
				rcData
			);
		end if;

		update LD_propert_by_article
		set
			Value = isbValue$
		where
			PROPERT_BY_ARTICLE_Id = inuPROPERT_BY_ARTICLE_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Value:= isbValue$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetPropert_By_Article_Id
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_propert_by_article.Propert_By_Article_Id%type
	IS
		rcError styLD_propert_by_article;
	BEGIN

		rcError.PROPERT_BY_ARTICLE_Id := inuPROPERT_BY_ARTICLE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPROPERT_BY_ARTICLE_Id
			 )
		then
			 return(rcData.Propert_By_Article_Id);
		end if;
		Load
		(
			inuPROPERT_BY_ARTICLE_Id
		);
		return(rcData.Propert_By_Article_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetArticle_Id
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_propert_by_article.Article_Id%type
	IS
		rcError styLD_propert_by_article;
	BEGIN

		rcError.PROPERT_BY_ARTICLE_Id := inuPROPERT_BY_ARTICLE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPROPERT_BY_ARTICLE_Id
			 )
		then
			 return(rcData.Article_Id);
		end if;
		Load
		(
			inuPROPERT_BY_ARTICLE_Id
		);
		return(rcData.Article_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetProperty_Id
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_propert_by_article.Property_Id%type
	IS
		rcError styLD_propert_by_article;
	BEGIN

		rcError.PROPERT_BY_ARTICLE_Id := inuPROPERT_BY_ARTICLE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPROPERT_BY_ARTICLE_Id
			 )
		then
			 return(rcData.Property_Id);
		end if;
		Load
		(
			inuPROPERT_BY_ARTICLE_Id
		);
		return(rcData.Property_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetValue
	(
		inuPROPERT_BY_ARTICLE_Id in LD_propert_by_article.PROPERT_BY_ARTICLE_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_propert_by_article.Value%type
	IS
		rcError styLD_propert_by_article;
	BEGIN

		rcError.PROPERT_BY_ARTICLE_Id:=inuPROPERT_BY_ARTICLE_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuPROPERT_BY_ARTICLE_Id
			 )
		then
			 return(rcData.Value);
		end if;
		Load
		(
			inuPROPERT_BY_ARTICLE_Id
		);
		return(rcData.Value);
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
end DALD_propert_by_article;
/
PROMPT Otorgando permisos de ejecucion a DALD_propert_by_article
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_PROPERT_BY_ARTICLE', 'ADM_PERSON');
END;
/
