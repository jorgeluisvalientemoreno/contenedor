CREATE OR REPLACE PACKAGE adm_person.DALD_segment_categ
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : dald_segment_categ
    Descripcion	 : 
    
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
		inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type
  )
  IS
		SELECT LD_segment_categ.*,LD_segment_categ.rowid
		FROM LD_segment_categ
		WHERE
			SEGMENT_CATEG_Id = inuSEGMENT_CATEG_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_segment_categ.*,LD_segment_categ.rowid
		FROM LD_segment_categ
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_segment_categ  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_segment_categ is table of styLD_segment_categ index by binary_integer;
	type tyrfRecords is ref cursor return styLD_segment_categ;

	/* Tipos referenciando al registro */
	type tytbSegment_Categ_Id is table of LD_segment_categ.Segment_Categ_Id%type index by binary_integer;
	type tytbLine_Id is table of LD_segment_categ.Line_Id%type index by binary_integer;
	type tytbSubline_Id is table of LD_segment_categ.Subline_Id%type index by binary_integer;
	type tytbCategory_Id is table of LD_segment_categ.Category_Id%type index by binary_integer;
	type tytbSubcategory_Id is table of LD_segment_categ.Subcategory_Id%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_segment_categ is record
	(

		Segment_Categ_Id   tytbSegment_Categ_Id,
		Line_Id   tytbLine_Id,
		Subline_Id   tytbSubline_Id,
		Category_Id   tytbCategory_Id,
		Subcategory_Id   tytbSubcategory_Id,
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
		inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type
	);

	PROCEDURE getRecord
	(
		inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
		orcRecord out nocopy styLD_segment_categ
	);

	FUNCTION frcGetRcData
	(
		inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type
	)
	RETURN styLD_segment_categ;

	FUNCTION frcGetRcData
	RETURN styLD_segment_categ;

	FUNCTION frcGetRecord
	(
		inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type
	)
	RETURN styLD_segment_categ;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_segment_categ
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_segment_categ in styLD_segment_categ
	);

 	  PROCEDURE insRecord
	(
		ircLD_segment_categ in styLD_segment_categ,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_segment_categ in out nocopy tytbLD_segment_categ
	);

	PROCEDURE delRecord
	(
		inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_segment_categ in out nocopy tytbLD_segment_categ,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_segment_categ in styLD_segment_categ,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_segment_categ in out nocopy tytbLD_segment_categ,
		inuLock in number default 1
	);

		PROCEDURE updLine_Id
		(
				inuSEGMENT_CATEG_Id   in LD_segment_categ.SEGMENT_CATEG_Id%type,
				inuLine_Id$  in LD_segment_categ.Line_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubline_Id
		(
				inuSEGMENT_CATEG_Id   in LD_segment_categ.SEGMENT_CATEG_Id%type,
				inuSubline_Id$  in LD_segment_categ.Subline_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCategory_Id
		(
				inuSEGMENT_CATEG_Id   in LD_segment_categ.SEGMENT_CATEG_Id%type,
				inuCategory_Id$  in LD_segment_categ.Category_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSubcategory_Id
		(
				inuSEGMENT_CATEG_Id   in LD_segment_categ.SEGMENT_CATEG_Id%type,
				inuSubcategory_Id$  in LD_segment_categ.Subcategory_Id%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetSegment_Categ_Id
    	(
    	    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_segment_categ.Segment_Categ_Id%type;

    	FUNCTION fnuGetLine_Id
    	(
    	    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_segment_categ.Line_Id%type;

    	FUNCTION fnuGetSubline_Id
    	(
    	    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_segment_categ.Subline_Id%type;

    	FUNCTION fnuGetCategory_Id
    	(
    	    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_segment_categ.Category_Id%type;

    	FUNCTION fnuGetSubcategory_Id
    	(
    	    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_segment_categ.Subcategory_Id%type;


	PROCEDURE LockByPk
	(
		inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
		orcLD_segment_categ  out styLD_segment_categ
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_segment_categ  out styLD_segment_categ
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_segment_categ;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_segment_categ
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SEGMENT_CATEG';
    cnuGeEntityId constant varchar2(30) := 8370; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type
  )
  IS
    SELECT LD_segment_categ.*,LD_segment_categ.rowid
    FROM LD_segment_categ
    WHERE  SEGMENT_CATEG_Id = inuSEGMENT_CATEG_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_segment_categ.*,LD_segment_categ.rowid
    FROM LD_segment_categ
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_segment_categ is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_segment_categ;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_segment_categ default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.SEGMENT_CATEG_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
    orcLD_segment_categ  out styLD_segment_categ
  )
  IS
    rcError styLD_segment_categ;
  BEGIN
    rcError.SEGMENT_CATEG_Id := inuSEGMENT_CATEG_Id;

    Open cuLockRcByPk
    (
      inuSEGMENT_CATEG_Id
    );

    fetch cuLockRcByPk into orcLD_segment_categ;
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
    orcLD_segment_categ  out styLD_segment_categ
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_segment_categ;
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
    itbLD_segment_categ  in out nocopy tytbLD_segment_categ
  )
  IS
  BEGIN
      rcRecOfTab.Segment_Categ_Id.delete;
      rcRecOfTab.Line_Id.delete;
      rcRecOfTab.Subline_Id.delete;
      rcRecOfTab.Category_Id.delete;
      rcRecOfTab.Subcategory_Id.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_segment_categ  in out nocopy tytbLD_segment_categ,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_segment_categ);
    for n in itbLD_segment_categ.first .. itbLD_segment_categ.last loop
      rcRecOfTab.Segment_Categ_Id(n) := itbLD_segment_categ(n).Segment_Categ_Id;
      rcRecOfTab.Line_Id(n) := itbLD_segment_categ(n).Line_Id;
      rcRecOfTab.Subline_Id(n) := itbLD_segment_categ(n).Subline_Id;
      rcRecOfTab.Category_Id(n) := itbLD_segment_categ(n).Category_Id;
      rcRecOfTab.Subcategory_Id(n) := itbLD_segment_categ(n).Subcategory_Id;
      rcRecOfTab.row_id(n) := itbLD_segment_categ(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuSEGMENT_CATEG_Id
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
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuSEGMENT_CATEG_Id = rcData.SEGMENT_CATEG_Id
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
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuSEGMENT_CATEG_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type
  )
  IS
    rcError styLD_segment_categ;
  BEGIN    rcError.SEGMENT_CATEG_Id:=inuSEGMENT_CATEG_Id;

    Load
    (
      inuSEGMENT_CATEG_Id
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
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuSEGMENT_CATEG_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
    orcRecord out nocopy styLD_segment_categ
  )
  IS
    rcError styLD_segment_categ;
  BEGIN    rcError.SEGMENT_CATEG_Id:=inuSEGMENT_CATEG_Id;

    Load
    (
      inuSEGMENT_CATEG_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type
  )
  RETURN styLD_segment_categ
  IS
    rcError styLD_segment_categ;
  BEGIN
    rcError.SEGMENT_CATEG_Id:=inuSEGMENT_CATEG_Id;

    Load
    (
      inuSEGMENT_CATEG_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type
  )
  RETURN styLD_segment_categ
  IS
    rcError styLD_segment_categ;
  BEGIN
    rcError.SEGMENT_CATEG_Id:=inuSEGMENT_CATEG_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuSEGMENT_CATEG_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuSEGMENT_CATEG_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_segment_categ
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_segment_categ
  )
  IS
    rfLD_segment_categ tyrfLD_segment_categ;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_segment_categ.Segment_Categ_Id,
                LD_segment_categ.Line_Id,
                LD_segment_categ.Subline_Id,
                LD_segment_categ.Category_Id,
                LD_segment_categ.Subcategory_Id,
                LD_segment_categ.rowid
                FROM LD_segment_categ';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_segment_categ for sbFullQuery;
    fetch rfLD_segment_categ bulk collect INTO otbResult;
    close rfLD_segment_categ;
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
                LD_segment_categ.Segment_Categ_Id,
                LD_segment_categ.Line_Id,
                LD_segment_categ.Subline_Id,
                LD_segment_categ.Category_Id,
                LD_segment_categ.Subcategory_Id,
                LD_segment_categ.rowid
                FROM LD_segment_categ';
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
    ircLD_segment_categ in styLD_segment_categ
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_segment_categ,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_segment_categ in styLD_segment_categ,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_segment_categ.SEGMENT_CATEG_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|SEGMENT_CATEG_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_segment_categ
    (
      Segment_Categ_Id,
      Line_Id,
      Subline_Id,
      Category_Id,
      Subcategory_Id
    )
    values
    (
      ircLD_segment_categ.Segment_Categ_Id,
      ircLD_segment_categ.Line_Id,
      ircLD_segment_categ.Subline_Id,
      ircLD_segment_categ.Category_Id,
      ircLD_segment_categ.Subcategory_Id
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_segment_categ));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_segment_categ in out nocopy tytbLD_segment_categ
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_segment_categ, blUseRowID);
    forall n in iotbLD_segment_categ.first..iotbLD_segment_categ.last
      insert into LD_segment_categ
      (
      Segment_Categ_Id,
      Line_Id,
      Subline_Id,
      Category_Id,
      Subcategory_Id
    )
    values
    (
      rcRecOfTab.Segment_Categ_Id(n),
      rcRecOfTab.Line_Id(n),
      rcRecOfTab.Subline_Id(n),
      rcRecOfTab.Category_Id(n),
      rcRecOfTab.Subcategory_Id(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_segment_categ;
  BEGIN
    rcError.SEGMENT_CATEG_Id:=inuSEGMENT_CATEG_Id;

    if inuLock=1 then
      LockByPk
      (
        inuSEGMENT_CATEG_Id,
        rcData
      );
    end if;

    delete
    from LD_segment_categ
    where
           SEGMENT_CATEG_Id=inuSEGMENT_CATEG_Id;
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
    rcError  styLD_segment_categ;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_segment_categ
    where
      rowid = iriRowID
    returning
   SEGMENT_CATEG_Id
    into
      rcError.SEGMENT_CATEG_Id;

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
    iotbLD_segment_categ in out nocopy tytbLD_segment_categ,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_segment_categ;
  BEGIN
    FillRecordOfTables(iotbLD_segment_categ, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_segment_categ.first .. iotbLD_segment_categ.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_segment_categ.first .. iotbLD_segment_categ.last
        delete
        from LD_segment_categ
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_segment_categ.first .. iotbLD_segment_categ.last loop
          LockByPk
          (
              rcRecOfTab.SEGMENT_CATEG_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_segment_categ.first .. iotbLD_segment_categ.last
        delete
        from LD_segment_categ
        where
               SEGMENT_CATEG_Id = rcRecOfTab.SEGMENT_CATEG_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_segment_categ in styLD_segment_categ,
    inuLock    in number default 0
  )
  IS
    nuSEGMENT_CATEG_Id LD_segment_categ.SEGMENT_CATEG_Id%type;

  BEGIN
    if ircLD_segment_categ.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_segment_categ.rowid,rcData);
      end if;
      update LD_segment_categ
      set

        Line_Id = ircLD_segment_categ.Line_Id,
        Subline_Id = ircLD_segment_categ.Subline_Id,
        Category_Id = ircLD_segment_categ.Category_Id,
        Subcategory_Id = ircLD_segment_categ.Subcategory_Id
      where
        rowid = ircLD_segment_categ.rowid
      returning
    SEGMENT_CATEG_Id
      into
        nuSEGMENT_CATEG_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_segment_categ.SEGMENT_CATEG_Id,
          rcData
        );
      end if;

      update LD_segment_categ
      set
        Line_Id = ircLD_segment_categ.Line_Id,
        Subline_Id = ircLD_segment_categ.Subline_Id,
        Category_Id = ircLD_segment_categ.Category_Id,
        Subcategory_Id = ircLD_segment_categ.Subcategory_Id
      where
             SEGMENT_CATEG_Id = ircLD_segment_categ.SEGMENT_CATEG_Id
      returning
    SEGMENT_CATEG_Id
      into
        nuSEGMENT_CATEG_Id;
    end if;

    if
      nuSEGMENT_CATEG_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_segment_categ));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_segment_categ in out nocopy tytbLD_segment_categ,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_segment_categ;
  BEGIN
    FillRecordOfTables(iotbLD_segment_categ,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_segment_categ.first .. iotbLD_segment_categ.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_segment_categ.first .. iotbLD_segment_categ.last
        update LD_segment_categ
        set

            Line_Id = rcRecOfTab.Line_Id(n),
            Subline_Id = rcRecOfTab.Subline_Id(n),
            Category_Id = rcRecOfTab.Category_Id(n),
            Subcategory_Id = rcRecOfTab.Subcategory_Id(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_segment_categ.first .. iotbLD_segment_categ.last loop
          LockByPk
          (
              rcRecOfTab.SEGMENT_CATEG_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_segment_categ.first .. iotbLD_segment_categ.last
        update LD_segment_categ
        set
          Line_Id = rcRecOfTab.Line_Id(n),
          Subline_Id = rcRecOfTab.Subline_Id(n),
          Category_Id = rcRecOfTab.Category_Id(n),
          Subcategory_Id = rcRecOfTab.Subcategory_Id(n)
          where
          SEGMENT_CATEG_Id = rcRecOfTab.SEGMENT_CATEG_Id(n)
;
    end if;
  END;

  PROCEDURE updLine_Id
  (
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
    inuLine_Id$ in LD_segment_categ.Line_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_segment_categ;
  BEGIN
    rcError.SEGMENT_CATEG_Id := inuSEGMENT_CATEG_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSEGMENT_CATEG_Id,
        rcData
      );
    end if;

    update LD_segment_categ
    set
      Line_Id = inuLine_Id$
    where
      SEGMENT_CATEG_Id = inuSEGMENT_CATEG_Id;

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
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
    inuSubline_Id$ in LD_segment_categ.Subline_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_segment_categ;
  BEGIN
    rcError.SEGMENT_CATEG_Id := inuSEGMENT_CATEG_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSEGMENT_CATEG_Id,
        rcData
      );
    end if;

    update LD_segment_categ
    set
      Subline_Id = inuSubline_Id$
    where
      SEGMENT_CATEG_Id = inuSEGMENT_CATEG_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Subline_Id:= inuSubline_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updCategory_Id
  (
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
    inuCategory_Id$ in LD_segment_categ.Category_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_segment_categ;
  BEGIN
    rcError.SEGMENT_CATEG_Id := inuSEGMENT_CATEG_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSEGMENT_CATEG_Id,
        rcData
      );
    end if;

    update LD_segment_categ
    set
      Category_Id = inuCategory_Id$
    where
      SEGMENT_CATEG_Id = inuSEGMENT_CATEG_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Category_Id:= inuCategory_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSubcategory_Id
  (
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
    inuSubcategory_Id$ in LD_segment_categ.Subcategory_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_segment_categ;
  BEGIN
    rcError.SEGMENT_CATEG_Id := inuSEGMENT_CATEG_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSEGMENT_CATEG_Id,
        rcData
      );
    end if;

    update LD_segment_categ
    set
      Subcategory_Id = inuSubcategory_Id$
    where
      SEGMENT_CATEG_Id = inuSEGMENT_CATEG_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Subcategory_Id:= inuSubcategory_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetSegment_Categ_Id
  (
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_segment_categ.Segment_Categ_Id%type
  IS
    rcError styLD_segment_categ;
  BEGIN

    rcError.SEGMENT_CATEG_Id := inuSEGMENT_CATEG_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSEGMENT_CATEG_Id
       )
    then
       return(rcData.Segment_Categ_Id);
    end if;
    Load
    (
      inuSEGMENT_CATEG_Id
    );
    return(rcData.Segment_Categ_Id);
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
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_segment_categ.Line_Id%type
  IS
    rcError styLD_segment_categ;
  BEGIN

    rcError.SEGMENT_CATEG_Id := inuSEGMENT_CATEG_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSEGMENT_CATEG_Id
       )
    then
       return(rcData.Line_Id);
    end if;
    Load
    (
      inuSEGMENT_CATEG_Id
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
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_segment_categ.Subline_Id%type
  IS
    rcError styLD_segment_categ;
  BEGIN

    rcError.SEGMENT_CATEG_Id := inuSEGMENT_CATEG_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSEGMENT_CATEG_Id
       )
    then
       return(rcData.Subline_Id);
    end if;
    Load
    (
      inuSEGMENT_CATEG_Id
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

  FUNCTION fnuGetCategory_Id
  (
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_segment_categ.Category_Id%type
  IS
    rcError styLD_segment_categ;
  BEGIN

    rcError.SEGMENT_CATEG_Id := inuSEGMENT_CATEG_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSEGMENT_CATEG_Id
       )
    then
       return(rcData.Category_Id);
    end if;
    Load
    (
      inuSEGMENT_CATEG_Id
    );
    return(rcData.Category_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetSubcategory_Id
  (
    inuSEGMENT_CATEG_Id in LD_segment_categ.SEGMENT_CATEG_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_segment_categ.Subcategory_Id%type
  IS
    rcError styLD_segment_categ;
  BEGIN

    rcError.SEGMENT_CATEG_Id := inuSEGMENT_CATEG_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSEGMENT_CATEG_Id
       )
    then
       return(rcData.Subcategory_Id);
    end if;
    Load
    (
      inuSEGMENT_CATEG_Id
    );
    return(rcData.Subcategory_Id);
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
end DALD_segment_categ;
/
PROMPT Otorgando permisos de ejecucion a DALD_SEGMENT_CATEG
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SEGMENT_CATEG', 'ADM_PERSON');
END;
/