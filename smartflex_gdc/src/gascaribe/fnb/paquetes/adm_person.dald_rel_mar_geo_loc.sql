CREATE OR REPLACE PACKAGE adm_person.DALD_rel_mar_geo_loc
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_rel_mar_geo_loc
    Descripcion	 : Paquete para la gestión de la entidad LD_rel_mar_geo_loc (Mercado relevante por Ubicación Geográfica)
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    07/06/2024              PAcosta         OSF-2812: Cambio de esquema ADM_PERSON  
                                            Retiro marcacion esquema .open objetos de lógica 
    DD-MM-YYYY             Autor<SAO156931>   <Descripcion de la Modificacion>
    ****************************************************************/

  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type
  )
  IS
    SELECT LD_rel_mar_geo_loc.*,LD_rel_mar_geo_loc.rowid
    FROM LD_rel_mar_geo_loc
    WHERE
      Rel_Mar_Geo_Loc_Id = inuRel_Mar_Geo_Loc_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_rel_mar_geo_loc.*,LD_rel_mar_geo_loc.rowid
    FROM LD_rel_mar_geo_loc
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_rel_mar_geo_loc  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_rel_mar_geo_loc is table of styLD_rel_mar_geo_loc index by binary_integer;
  type tyrfRecords is ref cursor return styLD_rel_mar_geo_loc;

  /* Tipos referenciando al registro */
  type tytbRel_Mar_Geo_Loc_Id is table of LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type index by binary_integer;
  type tytbRelevant_Market_Id is table of LD_rel_mar_geo_loc.Relevant_Market_Id%type index by binary_integer;
  type tytbGeograp_Location_Id is table of LD_rel_mar_geo_loc.Geograp_Location_Id%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_rel_mar_geo_loc is record
  (

    Rel_Mar_Geo_Loc_Id   tytbRel_Mar_Geo_Loc_Id,
    Relevant_Market_Id   tytbRelevant_Market_Id,
    Geograp_Location_Id   tytbGeograp_Location_Id,
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
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type
  );

  PROCEDURE getRecord
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type,
    orcRecord out nocopy styLD_rel_mar_geo_loc
  );

  FUNCTION frcGetRcData
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type
  )
  RETURN styLD_rel_mar_geo_loc;

  FUNCTION frcGetRcData
  RETURN styLD_rel_mar_geo_loc;

  FUNCTION frcGetRecord
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type
  )
  RETURN styLD_rel_mar_geo_loc;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_rel_mar_geo_loc
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_rel_mar_geo_loc in styLD_rel_mar_geo_loc
  );

     PROCEDURE insRecord
  (
    ircLD_rel_mar_geo_loc in styLD_rel_mar_geo_loc,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_rel_mar_geo_loc in out nocopy tytbLD_rel_mar_geo_loc
  );

  PROCEDURE delRecord
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_rel_mar_geo_loc in out nocopy tytbLD_rel_mar_geo_loc,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_rel_mar_geo_loc in styLD_rel_mar_geo_loc,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_rel_mar_geo_loc in out nocopy tytbLD_rel_mar_geo_loc,
    inuLock in number default 1
  );

    PROCEDURE updRelevant_Market_Id
    (
        inuRel_Mar_Geo_Loc_Id   in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type,
        inuRelevant_Market_Id$  in LD_rel_mar_geo_loc.Relevant_Market_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updGeograp_Location_Id
    (
        inuRel_Mar_Geo_Loc_Id   in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type,
        inuGeograp_Location_Id$  in LD_rel_mar_geo_loc.Geograp_Location_Id%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetRel_Mar_Geo_Loc_Id
      (
          inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type;

      FUNCTION fnuGetRelevant_Market_Id
      (
          inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rel_mar_geo_loc.Relevant_Market_Id%type;

      FUNCTION fnuGetGeograp_Location_Id
      (
          inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_rel_mar_geo_loc.Geograp_Location_Id%type;


  PROCEDURE LockByPk
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type,
    orcLD_rel_mar_geo_loc  out styLD_rel_mar_geo_loc
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_rel_mar_geo_loc  out styLD_rel_mar_geo_loc
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_rel_mar_geo_loc;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_rel_mar_geo_loc
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156931';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_REL_MAR_GEO_LOC';
    cnuGeEntityId constant varchar2(30) := 8338; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type
  )
  IS
    SELECT LD_rel_mar_geo_loc.*,LD_rel_mar_geo_loc.rowid
    FROM LD_rel_mar_geo_loc
    WHERE  Rel_Mar_Geo_Loc_Id = inuRel_Mar_Geo_Loc_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_rel_mar_geo_loc.*,LD_rel_mar_geo_loc.rowid
    FROM LD_rel_mar_geo_loc
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_rel_mar_geo_loc is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_rel_mar_geo_loc;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_rel_mar_geo_loc default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.Rel_Mar_Geo_Loc_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type,
    orcLD_rel_mar_geo_loc  out styLD_rel_mar_geo_loc
  )
  IS
    rcError styLD_rel_mar_geo_loc;
  BEGIN
    rcError.Rel_Mar_Geo_Loc_Id := inuRel_Mar_Geo_Loc_Id;

    Open cuLockRcByPk
    (
      inuRel_Mar_Geo_Loc_Id
    );

    fetch cuLockRcByPk into orcLD_rel_mar_geo_loc;
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
    orcLD_rel_mar_geo_loc  out styLD_rel_mar_geo_loc
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_rel_mar_geo_loc;
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
    itbLD_rel_mar_geo_loc  in out nocopy tytbLD_rel_mar_geo_loc
  )
  IS
  BEGIN
      rcRecOfTab.Rel_Mar_Geo_Loc_Id.delete;
      rcRecOfTab.Relevant_Market_Id.delete;
      rcRecOfTab.Geograp_Location_Id.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_rel_mar_geo_loc  in out nocopy tytbLD_rel_mar_geo_loc,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_rel_mar_geo_loc);
    for n in itbLD_rel_mar_geo_loc.first .. itbLD_rel_mar_geo_loc.last loop
      rcRecOfTab.Rel_Mar_Geo_Loc_Id(n) := itbLD_rel_mar_geo_loc(n).Rel_Mar_Geo_Loc_Id;
      rcRecOfTab.Relevant_Market_Id(n) := itbLD_rel_mar_geo_loc(n).Relevant_Market_Id;
      rcRecOfTab.Geograp_Location_Id(n) := itbLD_rel_mar_geo_loc(n).Geograp_Location_Id;
      rcRecOfTab.row_id(n) := itbLD_rel_mar_geo_loc(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuRel_Mar_Geo_Loc_Id
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
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuRel_Mar_Geo_Loc_Id = rcData.Rel_Mar_Geo_Loc_Id
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
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuRel_Mar_Geo_Loc_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type
  )
  IS
    rcError styLD_rel_mar_geo_loc;
  BEGIN    rcError.Rel_Mar_Geo_Loc_Id:=inuRel_Mar_Geo_Loc_Id;

    Load
    (
      inuRel_Mar_Geo_Loc_Id
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
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuRel_Mar_Geo_Loc_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type,
    orcRecord out nocopy styLD_rel_mar_geo_loc
  )
  IS
    rcError styLD_rel_mar_geo_loc;
  BEGIN    rcError.Rel_Mar_Geo_Loc_Id:=inuRel_Mar_Geo_Loc_Id;

    Load
    (
      inuRel_Mar_Geo_Loc_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type
  )
  RETURN styLD_rel_mar_geo_loc
  IS
    rcError styLD_rel_mar_geo_loc;
  BEGIN
    rcError.Rel_Mar_Geo_Loc_Id:=inuRel_Mar_Geo_Loc_Id;

    Load
    (
      inuRel_Mar_Geo_Loc_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type
  )
  RETURN styLD_rel_mar_geo_loc
  IS
    rcError styLD_rel_mar_geo_loc;
  BEGIN
    rcError.Rel_Mar_Geo_Loc_Id:=inuRel_Mar_Geo_Loc_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuRel_Mar_Geo_Loc_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuRel_Mar_Geo_Loc_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_rel_mar_geo_loc
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_rel_mar_geo_loc
  )
  IS
    rfLD_rel_mar_geo_loc tyrfLD_rel_mar_geo_loc;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id,
                LD_rel_mar_geo_loc.Relevant_Market_Id,
                LD_rel_mar_geo_loc.Geograp_Location_Id,
                LD_rel_mar_geo_loc.rowid
                FROM LD_rel_mar_geo_loc';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_rel_mar_geo_loc for sbFullQuery;
    fetch rfLD_rel_mar_geo_loc bulk collect INTO otbResult;
    close rfLD_rel_mar_geo_loc;
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
                LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id,
                LD_rel_mar_geo_loc.Relevant_Market_Id,
                LD_rel_mar_geo_loc.Geograp_Location_Id,
                LD_rel_mar_geo_loc.rowid
                FROM LD_rel_mar_geo_loc';
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
    ircLD_rel_mar_geo_loc in styLD_rel_mar_geo_loc
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_rel_mar_geo_loc,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_rel_mar_geo_loc in styLD_rel_mar_geo_loc,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|Rel_Mar_Geo_Loc_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_rel_mar_geo_loc
    (
      Rel_Mar_Geo_Loc_Id,
      Relevant_Market_Id,
      Geograp_Location_Id
    )
    values
    (
      ircLD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id,
      ircLD_rel_mar_geo_loc.Relevant_Market_Id,
      ircLD_rel_mar_geo_loc.Geograp_Location_Id
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_rel_mar_geo_loc));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_rel_mar_geo_loc in out nocopy tytbLD_rel_mar_geo_loc
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_rel_mar_geo_loc, blUseRowID);
    forall n in iotbLD_rel_mar_geo_loc.first..iotbLD_rel_mar_geo_loc.last
      insert into LD_rel_mar_geo_loc
      (
      Rel_Mar_Geo_Loc_Id,
      Relevant_Market_Id,
      Geograp_Location_Id
    )
    values
    (
      rcRecOfTab.Rel_Mar_Geo_Loc_Id(n),
      rcRecOfTab.Relevant_Market_Id(n),
      rcRecOfTab.Geograp_Location_Id(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_rel_mar_geo_loc;
  BEGIN
    rcError.Rel_Mar_Geo_Loc_Id:=inuRel_Mar_Geo_Loc_Id;

    if inuLock=1 then
      LockByPk
      (
        inuRel_Mar_Geo_Loc_Id,
        rcData
      );
    end if;

    delete
    from LD_rel_mar_geo_loc
    where
           Rel_Mar_Geo_Loc_Id=inuRel_Mar_Geo_Loc_Id;
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
    rcError  styLD_rel_mar_geo_loc;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_rel_mar_geo_loc
    where
      rowid = iriRowID
    returning
   Rel_Mar_Geo_Loc_Id
    into
      rcError.Rel_Mar_Geo_Loc_Id;

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
    iotbLD_rel_mar_geo_loc in out nocopy tytbLD_rel_mar_geo_loc,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_rel_mar_geo_loc;
  BEGIN
    FillRecordOfTables(iotbLD_rel_mar_geo_loc, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_rel_mar_geo_loc.first .. iotbLD_rel_mar_geo_loc.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rel_mar_geo_loc.first .. iotbLD_rel_mar_geo_loc.last
        delete
        from LD_rel_mar_geo_loc
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_rel_mar_geo_loc.first .. iotbLD_rel_mar_geo_loc.last loop
          LockByPk
          (
              rcRecOfTab.Rel_Mar_Geo_Loc_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rel_mar_geo_loc.first .. iotbLD_rel_mar_geo_loc.last
        delete
        from LD_rel_mar_geo_loc
        where
               Rel_Mar_Geo_Loc_Id = rcRecOfTab.Rel_Mar_Geo_Loc_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_rel_mar_geo_loc in styLD_rel_mar_geo_loc,
    inuLock    in number default 0
  )
  IS
    nuRel_Mar_Geo_Loc_Id LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type;

  BEGIN
    if ircLD_rel_mar_geo_loc.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_rel_mar_geo_loc.rowid,rcData);
      end if;
      update LD_rel_mar_geo_loc
      set

        Relevant_Market_Id = ircLD_rel_mar_geo_loc.Relevant_Market_Id,
        Geograp_Location_Id = ircLD_rel_mar_geo_loc.Geograp_Location_Id
      where
        rowid = ircLD_rel_mar_geo_loc.rowid
      returning
    Rel_Mar_Geo_Loc_Id
      into
        nuRel_Mar_Geo_Loc_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id,
          rcData
        );
      end if;

      update LD_rel_mar_geo_loc
      set
        Relevant_Market_Id = ircLD_rel_mar_geo_loc.Relevant_Market_Id,
        Geograp_Location_Id = ircLD_rel_mar_geo_loc.Geograp_Location_Id
      where
             Rel_Mar_Geo_Loc_Id = ircLD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id
      returning
    Rel_Mar_Geo_Loc_Id
      into
        nuRel_Mar_Geo_Loc_Id;
    end if;

    if
      nuRel_Mar_Geo_Loc_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_rel_mar_geo_loc));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_rel_mar_geo_loc in out nocopy tytbLD_rel_mar_geo_loc,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_rel_mar_geo_loc;
  BEGIN
    FillRecordOfTables(iotbLD_rel_mar_geo_loc,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_rel_mar_geo_loc.first .. iotbLD_rel_mar_geo_loc.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rel_mar_geo_loc.first .. iotbLD_rel_mar_geo_loc.last
        update LD_rel_mar_geo_loc
        set

            Relevant_Market_Id = rcRecOfTab.Relevant_Market_Id(n),
            Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_rel_mar_geo_loc.first .. iotbLD_rel_mar_geo_loc.last loop
          LockByPk
          (
              rcRecOfTab.Rel_Mar_Geo_Loc_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_rel_mar_geo_loc.first .. iotbLD_rel_mar_geo_loc.last
        update LD_rel_mar_geo_loc
        set
          Relevant_Market_Id = rcRecOfTab.Relevant_Market_Id(n),
          Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n)
          where
          Rel_Mar_Geo_Loc_Id = rcRecOfTab.Rel_Mar_Geo_Loc_Id(n)
;
    end if;
  END;

  PROCEDURE updRelevant_Market_Id
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type,
    inuRelevant_Market_Id$ in LD_rel_mar_geo_loc.Relevant_Market_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rel_mar_geo_loc;
  BEGIN
    rcError.Rel_Mar_Geo_Loc_Id := inuRel_Mar_Geo_Loc_Id;
    if inuLock=1 then
      LockByPk
      (
        inuRel_Mar_Geo_Loc_Id,
        rcData
      );
    end if;

    update LD_rel_mar_geo_loc
    set
      Relevant_Market_Id = inuRelevant_Market_Id$
    where
      Rel_Mar_Geo_Loc_Id = inuRel_Mar_Geo_Loc_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Relevant_Market_Id:= inuRelevant_Market_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updGeograp_Location_Id
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type,
    inuGeograp_Location_Id$ in LD_rel_mar_geo_loc.Geograp_Location_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_rel_mar_geo_loc;
  BEGIN
    rcError.Rel_Mar_Geo_Loc_Id := inuRel_Mar_Geo_Loc_Id;
    if inuLock=1 then
      LockByPk
      (
        inuRel_Mar_Geo_Loc_Id,
        rcData
      );
    end if;

    update LD_rel_mar_geo_loc
    set
      Geograp_Location_Id = inuGeograp_Location_Id$
    where
      Rel_Mar_Geo_Loc_Id = inuRel_Mar_Geo_Loc_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Geograp_Location_Id:= inuGeograp_Location_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetRel_Mar_Geo_Loc_Id
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type
  IS
    rcError styLD_rel_mar_geo_loc;
  BEGIN

    rcError.Rel_Mar_Geo_Loc_Id := inuRel_Mar_Geo_Loc_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuRel_Mar_Geo_Loc_Id
       )
    then
       return(rcData.Rel_Mar_Geo_Loc_Id);
    end if;
    Load
    (
      inuRel_Mar_Geo_Loc_Id
    );
    return(rcData.Rel_Mar_Geo_Loc_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetRelevant_Market_Id
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rel_mar_geo_loc.Relevant_Market_Id%type
  IS
    rcError styLD_rel_mar_geo_loc;
  BEGIN

    rcError.Rel_Mar_Geo_Loc_Id := inuRel_Mar_Geo_Loc_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuRel_Mar_Geo_Loc_Id
       )
    then
       return(rcData.Relevant_Market_Id);
    end if;
    Load
    (
      inuRel_Mar_Geo_Loc_Id
    );
    return(rcData.Relevant_Market_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetGeograp_Location_Id
  (
    inuRel_Mar_Geo_Loc_Id in LD_rel_mar_geo_loc.Rel_Mar_Geo_Loc_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_rel_mar_geo_loc.Geograp_Location_Id%type
  IS
    rcError styLD_rel_mar_geo_loc;
  BEGIN

    rcError.Rel_Mar_Geo_Loc_Id := inuRel_Mar_Geo_Loc_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuRel_Mar_Geo_Loc_Id
       )
    then
       return(rcData.Geograp_Location_Id);
    end if;
    Load
    (
      inuRel_Mar_Geo_Loc_Id
    );
    return(rcData.Geograp_Location_Id);
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
end DALD_rel_mar_geo_loc;
/
PROMPT Otorgando permisos de ejecucion a DALD_REL_MAR_GEO_LOC
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_REL_MAR_GEO_LOC', 'ADM_PERSON');
END;
/