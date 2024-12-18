CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_property
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_property
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
		inuPROPERTY_Id in LD_property.PROPERTY_Id%type
  )
  IS
		SELECT LD_property.*,LD_property.rowid
		FROM LD_property
		WHERE
			PROPERTY_Id = inuPROPERTY_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_property.*,LD_property.rowid
		FROM LD_property
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_property  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_property is table of styLD_property index by binary_integer;
	type tyrfRecords is ref cursor return styLD_property;

	/* Tipos referenciando al registro */
	type tytbProperty_Id is table of LD_property.Property_Id%type index by binary_integer;
	type tytbDescription is table of LD_property.Description%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_property is record
	(

		Property_Id   tytbProperty_Id,
		Description   tytbDescription,
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
		inuPROPERTY_Id in LD_property.PROPERTY_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuPROPERTY_Id in LD_property.PROPERTY_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuPROPERTY_Id in LD_property.PROPERTY_Id%type
	);

	PROCEDURE getRecord
	(
		inuPROPERTY_Id in LD_property.PROPERTY_Id%type,
		orcRecord out nocopy styLD_property
	);

	FUNCTION frcGetRcData
	(
		inuPROPERTY_Id in LD_property.PROPERTY_Id%type
	)
	RETURN styLD_property;

	FUNCTION frcGetRcData
	RETURN styLD_property;

	FUNCTION frcGetRecord
	(
		inuPROPERTY_Id in LD_property.PROPERTY_Id%type
	)
	RETURN styLD_property;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_property
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_property in styLD_property
	);

 	  PROCEDURE insRecord
	(
		ircLD_property in styLD_property,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_property in out nocopy tytbLD_property
	);

	PROCEDURE delRecord
	(
		inuPROPERTY_Id in LD_property.PROPERTY_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_property in out nocopy tytbLD_property,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_property in styLD_property,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_property in out nocopy tytbLD_property,
		inuLock in number default 1
	);

		PROCEDURE updDescription
		(
				inuPROPERTY_Id   in LD_property.PROPERTY_Id%type,
				isbDescription$  in LD_property.Description%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetProperty_Id
    	(
    	    inuPROPERTY_Id in LD_property.PROPERTY_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_property.Property_Id%type;

    	FUNCTION fsbGetDescription
    	(
    	    inuPROPERTY_Id in LD_property.PROPERTY_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_property.Description%type;


	PROCEDURE LockByPk
	(
		inuPROPERTY_Id in LD_property.PROPERTY_Id%type,
		orcLD_property  out styLD_property
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_property  out styLD_property
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_property;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_property
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_PROPERTY';
	  cnuGeEntityId constant varchar2(30) := 8376; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPROPERTY_Id in LD_property.PROPERTY_Id%type
	)
	IS
		SELECT LD_property.*,LD_property.rowid
		FROM LD_property
		WHERE  PROPERTY_Id = inuPROPERTY_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_property.*,LD_property.rowid
		FROM LD_property
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_property is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_property;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_property default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PROPERTY_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuPROPERTY_Id in LD_property.PROPERTY_Id%type,
		orcLD_property  out styLD_property
  )
  IS
    rcError styLD_property;
  BEGIN
    rcError.PROPERTY_Id := inuPROPERTY_Id;

    Open cuLockRcByPk
    (
      inuPROPERTY_Id
    );

    fetch cuLockRcByPk into orcLD_property;
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
    orcLD_property  out styLD_property
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_property;
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
    itbLD_property  in out nocopy tytbLD_property
  )
  IS
  BEGIN
      rcRecOfTab.Property_Id.delete;
      rcRecOfTab.Description.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_property  in out nocopy tytbLD_property,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_property);
    for n in itbLD_property.first .. itbLD_property.last loop
      rcRecOfTab.Property_Id(n) := itbLD_property(n).Property_Id;
      rcRecOfTab.Description(n) := itbLD_property(n).Description;
      rcRecOfTab.row_id(n) := itbLD_property(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuPROPERTY_Id in LD_property.PROPERTY_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuPROPERTY_Id
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
    inuPROPERTY_Id in LD_property.PROPERTY_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuPROPERTY_Id = rcData.PROPERTY_Id
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
    inuPROPERTY_Id in LD_property.PROPERTY_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuPROPERTY_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuPROPERTY_Id in LD_property.PROPERTY_Id%type
  )
  IS
    rcError styLD_property;
  BEGIN    rcError.PROPERTY_Id:=inuPROPERTY_Id;

    Load
    (
      inuPROPERTY_Id
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
    inuPROPERTY_Id in LD_property.PROPERTY_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuPROPERTY_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuPROPERTY_Id in LD_property.PROPERTY_Id%type,
    orcRecord out nocopy styLD_property
  )
  IS
    rcError styLD_property;
  BEGIN    rcError.PROPERTY_Id:=inuPROPERTY_Id;

    Load
    (
      inuPROPERTY_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuPROPERTY_Id in LD_property.PROPERTY_Id%type
  )
  RETURN styLD_property
  IS
    rcError styLD_property;
  BEGIN
    rcError.PROPERTY_Id:=inuPROPERTY_Id;

    Load
    (
      inuPROPERTY_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuPROPERTY_Id in LD_property.PROPERTY_Id%type
  )
  RETURN styLD_property
  IS
    rcError styLD_property;
  BEGIN
    rcError.PROPERTY_Id:=inuPROPERTY_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuPROPERTY_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuPROPERTY_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_property
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_property
  )
  IS
    rfLD_property tyrfLD_property;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_property.Property_Id,
                LD_property.Description,
                LD_property.rowid
                FROM LD_property';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_property for sbFullQuery;
    fetch rfLD_property bulk collect INTO otbResult;
    close rfLD_property;
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
                LD_property.Property_Id,
                LD_property.Description,
                LD_property.rowid
                FROM LD_property';
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
    ircLD_property in styLD_property
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_property,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_property in styLD_property,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_property.PROPERTY_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|PROPERTY_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_property
    (
      Property_Id,
      Description
    )
    values
    (
      ircLD_property.Property_Id,
      ircLD_property.Description
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_property));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_property in out nocopy tytbLD_property
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_property, blUseRowID);
    forall n in iotbLD_property.first..iotbLD_property.last
      insert into LD_property
      (
      Property_Id,
      Description
    )
    values
    (
      rcRecOfTab.Property_Id(n),
      rcRecOfTab.Description(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuPROPERTY_Id in LD_property.PROPERTY_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_property;
  BEGIN
    rcError.PROPERTY_Id:=inuPROPERTY_Id;

    if inuLock=1 then
      LockByPk
      (
        inuPROPERTY_Id,
        rcData
      );
    end if;

    delete
    from LD_property
    where
           PROPERTY_Id=inuPROPERTY_Id;
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
    rcError  styLD_property;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_property
    where
      rowid = iriRowID
    returning
   PROPERTY_Id
    into
      rcError.PROPERTY_Id;

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
    iotbLD_property in out nocopy tytbLD_property,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_property;
  BEGIN
    FillRecordOfTables(iotbLD_property, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_property.first .. iotbLD_property.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_property.first .. iotbLD_property.last
        delete
        from LD_property
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_property.first .. iotbLD_property.last loop
          LockByPk
          (
              rcRecOfTab.PROPERTY_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_property.first .. iotbLD_property.last
        delete
        from LD_property
        where
               PROPERTY_Id = rcRecOfTab.PROPERTY_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_property in styLD_property,
    inuLock    in number default 0
  )
  IS
    nuPROPERTY_Id LD_property.PROPERTY_Id%type;

  BEGIN
    if ircLD_property.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_property.rowid,rcData);
      end if;
      update LD_property
      set

        Description = ircLD_property.Description
      where
        rowid = ircLD_property.rowid
      returning
    PROPERTY_Id
      into
        nuPROPERTY_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_property.PROPERTY_Id,
          rcData
        );
      end if;

      update LD_property
      set
        Description = ircLD_property.Description
      where
             PROPERTY_Id = ircLD_property.PROPERTY_Id
      returning
    PROPERTY_Id
      into
        nuPROPERTY_Id;
    end if;

    if
      nuPROPERTY_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_property));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_property in out nocopy tytbLD_property,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_property;
  BEGIN
    FillRecordOfTables(iotbLD_property,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_property.first .. iotbLD_property.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_property.first .. iotbLD_property.last
        update LD_property
        set

            Description = rcRecOfTab.Description(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_property.first .. iotbLD_property.last loop
          LockByPk
          (
              rcRecOfTab.PROPERTY_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_property.first .. iotbLD_property.last
        update LD_property
        set
          Description = rcRecOfTab.Description(n)
          where
          PROPERTY_Id = rcRecOfTab.PROPERTY_Id(n)
;
    end if;
  END;

  PROCEDURE updDescription
  (
    inuPROPERTY_Id in LD_property.PROPERTY_Id%type,
    isbDescription$ in LD_property.Description%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_property;
  BEGIN
    rcError.PROPERTY_Id := inuPROPERTY_Id;
    if inuLock=1 then
      LockByPk
      (
        inuPROPERTY_Id,
        rcData
      );
    end if;

    update LD_property
    set
      Description = isbDescription$
    where
      PROPERTY_Id = inuPROPERTY_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Description:= isbDescription$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetProperty_Id
  (
    inuPROPERTY_Id in LD_property.PROPERTY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_property.Property_Id%type
  IS
    rcError styLD_property;
  BEGIN

    rcError.PROPERTY_Id := inuPROPERTY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuPROPERTY_Id
       )
    then
       return(rcData.Property_Id);
    end if;
    Load
    (
      inuPROPERTY_Id
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

  FUNCTION fsbGetDescription
  (
    inuPROPERTY_Id in LD_property.PROPERTY_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_property.Description%type
  IS
    rcError styLD_property;
  BEGIN

    rcError.PROPERTY_Id:=inuPROPERTY_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuPROPERTY_Id
       )
    then
       return(rcData.Description);
    end if;
    Load
    (
      inuPROPERTY_Id
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
  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  ) IS
  Begin
      blDAO_USE_CACHE := iblUseCache;
  END;

begin
    GetDAO_USE_CACHE;
end DALD_property;
/
PROMPT Otorgando permisos de ejecucion a DALD_PROPERTY
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_PROPERTY', 'ADM_PERSON');
END;
/
