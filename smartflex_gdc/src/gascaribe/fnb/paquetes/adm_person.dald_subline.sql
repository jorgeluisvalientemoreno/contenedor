CREATE OR REPLACE PACKAGE adm_person.DALD_subline
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
		inuSUBLINE_Id in LD_subline.SUBLINE_Id%type
  )
  IS
		SELECT LD_subline.*,LD_subline.rowid
		FROM LD_subline
		WHERE
			SUBLINE_Id = inuSUBLINE_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_subline.*,LD_subline.rowid
		FROM LD_subline
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_subline  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_subline is table of styLD_subline index by binary_integer;
	type tyrfRecords is ref cursor return styLD_subline;

	/* Tipos referenciando al registro */
	type tytbSubline_Id is table of LD_subline.Subline_Id%type index by binary_integer;
	type tytbLine_Id is table of LD_subline.Line_Id%type index by binary_integer;
	type tytbDescription is table of LD_subline.Description%type index by binary_integer;
	type tytbApproved is table of LD_subline.Approved%type index by binary_integer;
	type tytbCondition_Approved is table of LD_subline.Condition_Approved%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_subline is record
	(

		Subline_Id   tytbSubline_Id,
		Line_Id   tytbLine_Id,
		Description   tytbDescription,
		Approved   tytbApproved,
		Condition_Approved   tytbCondition_Approved,
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
		inuSUBLINE_Id in LD_subline.SUBLINE_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuSUBLINE_Id in LD_subline.SUBLINE_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuSUBLINE_Id in LD_subline.SUBLINE_Id%type
	);

	PROCEDURE getRecord
	(
		inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
		orcRecord out nocopy styLD_subline
	);

	FUNCTION frcGetRcData
	(
		inuSUBLINE_Id in LD_subline.SUBLINE_Id%type
	)
	RETURN styLD_subline;

	FUNCTION frcGetRcData
	RETURN styLD_subline;

	FUNCTION frcGetRecord
	(
		inuSUBLINE_Id in LD_subline.SUBLINE_Id%type
	)
	RETURN styLD_subline;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_subline
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_subline in styLD_subline
	);

 	  PROCEDURE insRecord
	(
		ircLD_subline in styLD_subline,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_subline in out nocopy tytbLD_subline
	);

	PROCEDURE delRecord
	(
		inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_subline in out nocopy tytbLD_subline,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_subline in styLD_subline,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_subline in out nocopy tytbLD_subline,
		inuLock in number default 1
	);

		PROCEDURE updLine_Id
		(
				inuSUBLINE_Id   in LD_subline.SUBLINE_Id%type,
				inuLine_Id$  in LD_subline.Line_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updDescription
		(
				inuSUBLINE_Id   in LD_subline.SUBLINE_Id%type,
				isbDescription$  in LD_subline.Description%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updApproved
		(
				inuSUBLINE_Id   in LD_subline.SUBLINE_Id%type,
				isbApproved$  in LD_subline.Approved%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCondition_Approved
		(
				inuSUBLINE_Id   in LD_subline.SUBLINE_Id%type,
				isbCondition_Approved$  in LD_subline.Condition_Approved%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetSubline_Id
    	(
    	    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_subline.Subline_Id%type;

    	FUNCTION fnuGetLine_Id
    	(
    	    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_subline.Line_Id%type;

    	FUNCTION fsbGetDescription
    	(
    	    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_subline.Description%type;

    	FUNCTION fsbGetApproved
    	(
    	    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_subline.Approved%type;

    	FUNCTION fsbGetCondition_Approved
    	(
    	    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_subline.Condition_Approved%type;


	PROCEDURE LockByPk
	(
		inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
		orcLD_subline  out styLD_subline
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_subline  out styLD_subline
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_subline;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_subline
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SUBLINE';
	  cnuGeEntityId constant varchar2(30) := 8367; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuSUBLINE_Id in LD_subline.SUBLINE_Id%type
	)
	IS
		SELECT LD_subline.*,LD_subline.rowid
		FROM LD_subline
		WHERE  SUBLINE_Id = inuSUBLINE_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_subline.*,LD_subline.rowid
		FROM LD_subline
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_subline is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_subline;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_subline default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.SUBLINE_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
    orcLD_subline  out styLD_subline
  )
  IS
    rcError styLD_subline;
  BEGIN
    rcError.SUBLINE_Id := inuSUBLINE_Id;

    Open cuLockRcByPk
    (
      inuSUBLINE_Id
    );

    fetch cuLockRcByPk into orcLD_subline;
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
    orcLD_subline  out styLD_subline
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_subline;
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
    itbLD_subline  in out nocopy tytbLD_subline
  )
  IS
  BEGIN
      rcRecOfTab.Subline_Id.delete;
      rcRecOfTab.Line_Id.delete;
      rcRecOfTab.Description.delete;
      rcRecOfTab.Approved.delete;
      rcRecOfTab.Condition_Approved.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_subline  in out nocopy tytbLD_subline,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_subline);
    for n in itbLD_subline.first .. itbLD_subline.last loop
      rcRecOfTab.Subline_Id(n) := itbLD_subline(n).Subline_Id;
      rcRecOfTab.Line_Id(n) := itbLD_subline(n).Line_Id;
      rcRecOfTab.Description(n) := itbLD_subline(n).Description;
      rcRecOfTab.Approved(n) := itbLD_subline(n).Approved;
      rcRecOfTab.Condition_Approved(n) := itbLD_subline(n).Condition_Approved;
      rcRecOfTab.row_id(n) := itbLD_subline(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuSUBLINE_Id
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
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuSUBLINE_Id = rcData.SUBLINE_Id
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
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuSUBLINE_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type
  )
  IS
    rcError styLD_subline;
  BEGIN    rcError.SUBLINE_Id:=inuSUBLINE_Id;

    Load
    (
      inuSUBLINE_Id
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
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuSUBLINE_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
    orcRecord out nocopy styLD_subline
  )
  IS
    rcError styLD_subline;
  BEGIN    rcError.SUBLINE_Id:=inuSUBLINE_Id;

    Load
    (
      inuSUBLINE_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type
  )
  RETURN styLD_subline
  IS
    rcError styLD_subline;
  BEGIN
    rcError.SUBLINE_Id:=inuSUBLINE_Id;

    Load
    (
      inuSUBLINE_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type
  )
  RETURN styLD_subline
  IS
    rcError styLD_subline;
  BEGIN
    rcError.SUBLINE_Id:=inuSUBLINE_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuSUBLINE_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuSUBLINE_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_subline
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_subline
  )
  IS
    rfLD_subline tyrfLD_subline;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_subline.Subline_Id,
                LD_subline.Line_Id,
                LD_subline.Description,
                LD_subline.Approved,
                LD_subline.Condition_Approved,
                LD_subline.rowid
                FROM LD_subline';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_subline for sbFullQuery;
    fetch rfLD_subline bulk collect INTO otbResult;
    close rfLD_subline;
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
                LD_subline.Subline_Id,
                LD_subline.Line_Id,
                LD_subline.Description,
                LD_subline.Approved,
                LD_subline.Condition_Approved,
                LD_subline.rowid
                FROM LD_subline';
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
    ircLD_subline in styLD_subline
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_subline,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_subline in styLD_subline,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_subline.SUBLINE_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|SUBLINE_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_subline
    (
      Subline_Id,
      Line_Id,
      Description,
      Approved,
      Condition_Approved
    )
    values
    (
      ircLD_subline.Subline_Id,
      ircLD_subline.Line_Id,
      ircLD_subline.Description,
      ircLD_subline.Approved,
      ircLD_subline.Condition_Approved
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_subline));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_subline in out nocopy tytbLD_subline
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_subline, blUseRowID);
    forall n in iotbLD_subline.first..iotbLD_subline.last
      insert into LD_subline
      (
      Subline_Id,
      Line_Id,
      Description,
      Approved,
      Condition_Approved
    )
    values
    (
      rcRecOfTab.Subline_Id(n),
      rcRecOfTab.Line_Id(n),
      rcRecOfTab.Description(n),
      rcRecOfTab.Approved(n),
      rcRecOfTab.Condition_Approved(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_subline;
  BEGIN
    rcError.SUBLINE_Id:=inuSUBLINE_Id;

    if inuLock=1 then
      LockByPk
      (
        inuSUBLINE_Id,
        rcData
      );
    end if;

    delete
    from LD_subline
    where
           SUBLINE_Id=inuSUBLINE_Id;
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
    rcError  styLD_subline;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_subline
    where
      rowid = iriRowID
    returning
   SUBLINE_Id
    into
      rcError.SUBLINE_Id;

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
    iotbLD_subline in out nocopy tytbLD_subline,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_subline;
  BEGIN
    FillRecordOfTables(iotbLD_subline, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_subline.first .. iotbLD_subline.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subline.first .. iotbLD_subline.last
        delete
        from LD_subline
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_subline.first .. iotbLD_subline.last loop
          LockByPk
          (
              rcRecOfTab.SUBLINE_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subline.first .. iotbLD_subline.last
        delete
        from LD_subline
        where
               SUBLINE_Id = rcRecOfTab.SUBLINE_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_subline in styLD_subline,
    inuLock    in number default 0
  )
  IS
    nuSUBLINE_Id LD_subline.SUBLINE_Id%type;

  BEGIN
    if ircLD_subline.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_subline.rowid,rcData);
      end if;
      update LD_subline
      set

        Line_Id = ircLD_subline.Line_Id,
        Description = ircLD_subline.Description,
        Approved = ircLD_subline.Approved,
        Condition_Approved = ircLD_subline.Condition_Approved
      where
        rowid = ircLD_subline.rowid
      returning
    SUBLINE_Id
      into
        nuSUBLINE_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_subline.SUBLINE_Id,
          rcData
        );
      end if;

      update LD_subline
      set
        Line_Id = ircLD_subline.Line_Id,
        Description = ircLD_subline.Description,
        Approved = ircLD_subline.Approved,
        Condition_Approved = ircLD_subline.Condition_Approved
      where
             SUBLINE_Id = ircLD_subline.SUBLINE_Id
      returning
    SUBLINE_Id
      into
        nuSUBLINE_Id;
    end if;

    if
      nuSUBLINE_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_subline));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_subline in out nocopy tytbLD_subline,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_subline;
  BEGIN
    FillRecordOfTables(iotbLD_subline,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_subline.first .. iotbLD_subline.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subline.first .. iotbLD_subline.last
        update LD_subline
        set

            Line_Id = rcRecOfTab.Line_Id(n),
            Description = rcRecOfTab.Description(n),
            Approved = rcRecOfTab.Approved(n),
            Condition_Approved = rcRecOfTab.Condition_Approved(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_subline.first .. iotbLD_subline.last loop
          LockByPk
          (
              rcRecOfTab.SUBLINE_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_subline.first .. iotbLD_subline.last
        update LD_subline
        set
          Line_Id = rcRecOfTab.Line_Id(n),
          Description = rcRecOfTab.Description(n),
          Approved = rcRecOfTab.Approved(n),
          Condition_Approved = rcRecOfTab.Condition_Approved(n)
          where
          SUBLINE_Id = rcRecOfTab.SUBLINE_Id(n)
;
    end if;
  END;

  PROCEDURE updLine_Id
  (
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
    inuLine_Id$ in LD_subline.Line_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subline;
  BEGIN
    rcError.SUBLINE_Id := inuSUBLINE_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBLINE_Id,
        rcData
      );
    end if;

    update LD_subline
    set
      Line_Id = inuLine_Id$
    where
      SUBLINE_Id = inuSUBLINE_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Line_Id:= inuLine_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updDescription
  (
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
    isbDescription$ in LD_subline.Description%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subline;
  BEGIN
    rcError.SUBLINE_Id := inuSUBLINE_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBLINE_Id,
        rcData
      );
    end if;

    update LD_subline
    set
      Description = isbDescription$
    where
      SUBLINE_Id = inuSUBLINE_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Description:= isbDescription$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updApproved
  (
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
    isbApproved$ in LD_subline.Approved%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subline;
  BEGIN
    rcError.SUBLINE_Id := inuSUBLINE_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBLINE_Id,
        rcData
      );
    end if;

    update LD_subline
    set
      Approved = isbApproved$
    where
      SUBLINE_Id = inuSUBLINE_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Approved:= isbApproved$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updCondition_Approved
  (
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
    isbCondition_Approved$ in LD_subline.Condition_Approved%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_subline;
  BEGIN
    rcError.SUBLINE_Id := inuSUBLINE_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSUBLINE_Id,
        rcData
      );
    end if;

    update LD_subline
    set
      Condition_Approved = isbCondition_Approved$
    where
      SUBLINE_Id = inuSUBLINE_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Condition_Approved:= isbCondition_Approved$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetSubline_Id
  (
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subline.Subline_Id%type
  IS
    rcError styLD_subline;
  BEGIN

    rcError.SUBLINE_Id := inuSUBLINE_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBLINE_Id
       )
    then
       return(rcData.Subline_Id);
    end if;
    Load
    (
      inuSUBLINE_Id
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

  FUNCTION fnuGetLine_Id
  (
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subline.Line_Id%type
  IS
    rcError styLD_subline;
  BEGIN

    rcError.SUBLINE_Id := inuSUBLINE_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBLINE_Id
       )
    then
       return(rcData.Line_Id);
    end if;
    Load
    (
      inuSUBLINE_Id
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

  FUNCTION fsbGetDescription
  (
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subline.Description%type
  IS
    rcError styLD_subline;
  BEGIN

    rcError.SUBLINE_Id:=inuSUBLINE_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBLINE_Id
       )
    then
       return(rcData.Description);
    end if;
    Load
    (
      inuSUBLINE_Id
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

  FUNCTION fsbGetApproved
  (
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subline.Approved%type
  IS
    rcError styLD_subline;
  BEGIN

    rcError.SUBLINE_Id:=inuSUBLINE_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBLINE_Id
       )
    then
       return(rcData.Approved);
    end if;
    Load
    (
      inuSUBLINE_Id
    );
    return(rcData.Approved);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetCondition_Approved
  (
    inuSUBLINE_Id in LD_subline.SUBLINE_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_subline.Condition_Approved%type
  IS
    rcError styLD_subline;
  BEGIN

    rcError.SUBLINE_Id:=inuSUBLINE_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSUBLINE_Id
       )
    then
       return(rcData.Condition_Approved);
    end if;
    Load
    (
      inuSUBLINE_Id
    );
    return(rcData.Condition_Approved);
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
end DALD_subline;
/
PROMPT Otorgando permisos de ejecucion a DALD_SUBLINE
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SUBLINE', 'ADM_PERSON');
END;
/