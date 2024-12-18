CREATE OR REPLACE PACKAGE adm_person.dald_creg_resolution
is
/***************************************************************
Propiedad intelectual de Sincecomp Ltda.

Unidad	     : DALD_creg_resolution
Descripcion	 : Paquete para la gestión de la entidad LD_creg_resolution (Resolución  de la Creg)

Parametro	    Descripcion
============	==============================

Historia de Modificaciones
Fecha   	           Autor            Modificacion
====================   =========        ====================
DD-MM-YYYY             Autor<SAO156931>   <Descripcion de la Modificacion>
11/06/2024             Adrianavg          OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
****************************************************************/

  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type
  )
  IS
    SELECT LD_creg_resolution.*,LD_creg_resolution.rowid
    FROM LD_creg_resolution
    WHERE
      Creg_Resolution_Id = inuCreg_Resolution_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_creg_resolution.*,LD_creg_resolution.rowid
    FROM LD_creg_resolution
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_creg_resolution  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_creg_resolution is table of styLD_creg_resolution index by binary_integer;
  type tyrfRecords is ref cursor return styLD_creg_resolution;

  /* Tipos referenciando al registro */
  type tytbCreg_Resolution_Id is table of LD_creg_resolution.Creg_Resolution_Id%type index by binary_integer;
  type tytbResolution is table of LD_creg_resolution.Resolution%type index by binary_integer;
  type tytbDate_Resolution is table of LD_creg_resolution.Date_Resolution%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_creg_resolution is record
  (

    Creg_Resolution_Id   tytbCreg_Resolution_Id,
    Resolution   tytbResolution,
    Date_Resolution   tytbDate_Resolution,
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
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type
  );

  PROCEDURE getRecord
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type,
    orcRecord out nocopy styLD_creg_resolution
  );

  FUNCTION frcGetRcData
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type
  )
  RETURN styLD_creg_resolution;

  FUNCTION frcGetRcData
  RETURN styLD_creg_resolution;

  FUNCTION frcGetRecord
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type
  )
  RETURN styLD_creg_resolution;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_creg_resolution
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_creg_resolution in styLD_creg_resolution
  );

     PROCEDURE insRecord
  (
    ircLD_creg_resolution in styLD_creg_resolution,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_creg_resolution in out nocopy tytbLD_creg_resolution
  );

  PROCEDURE delRecord
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_creg_resolution in out nocopy tytbLD_creg_resolution,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_creg_resolution in styLD_creg_resolution,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_creg_resolution in out nocopy tytbLD_creg_resolution,
    inuLock in number default 1
  );

    PROCEDURE updResolution
    (
        inuCreg_Resolution_Id   in LD_creg_resolution.Creg_Resolution_Id%type,
        isbResolution$  in LD_creg_resolution.Resolution%type,
        inuLock    in number default 0
      );

    PROCEDURE updDate_Resolution
    (
        inuCreg_Resolution_Id   in LD_creg_resolution.Creg_Resolution_Id%type,
        idtDate_Resolution$  in LD_creg_resolution.Date_Resolution%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetCreg_Resolution_Id
      (
          inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_creg_resolution.Creg_Resolution_Id%type;

      FUNCTION fsbGetResolution
      (
          inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_creg_resolution.Resolution%type;

      FUNCTION fdtGetDate_Resolution
      (
          inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_creg_resolution.Date_Resolution%type;


  PROCEDURE LockByPk
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type,
    orcLD_creg_resolution  out styLD_creg_resolution
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_creg_resolution  out styLD_creg_resolution
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_creg_resolution;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_creg_resolution
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156931';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CREG_RESOLUTION';
    cnuGeEntityId constant varchar2(30) :=8335; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type
  )
  IS
    SELECT LD_creg_resolution.*,LD_creg_resolution.rowid
    FROM LD_creg_resolution
    WHERE  Creg_Resolution_Id = inuCreg_Resolution_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_creg_resolution.*,LD_creg_resolution.rowid
    FROM LD_creg_resolution
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_creg_resolution is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_creg_resolution;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_creg_resolution default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.Creg_Resolution_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type,
    orcLD_creg_resolution  out styLD_creg_resolution
  )
  IS
    rcError styLD_creg_resolution;
  BEGIN
    rcError.Creg_Resolution_Id := inuCreg_Resolution_Id;

    Open cuLockRcByPk
    (
      inuCreg_Resolution_Id
    );

    fetch cuLockRcByPk into orcLD_creg_resolution;
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
    orcLD_creg_resolution  out styLD_creg_resolution
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_creg_resolution;
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
    itbLD_creg_resolution  in out nocopy tytbLD_creg_resolution
  )
  IS
  BEGIN
      rcRecOfTab.Creg_Resolution_Id.delete;
      rcRecOfTab.Resolution.delete;
      rcRecOfTab.Date_Resolution.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_creg_resolution  in out nocopy tytbLD_creg_resolution,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_creg_resolution);
    for n in itbLD_creg_resolution.first .. itbLD_creg_resolution.last loop
      rcRecOfTab.Creg_Resolution_Id(n) := itbLD_creg_resolution(n).Creg_Resolution_Id;
      rcRecOfTab.Resolution(n) := itbLD_creg_resolution(n).Resolution;
      rcRecOfTab.Date_Resolution(n) := itbLD_creg_resolution(n).Date_Resolution;
      rcRecOfTab.row_id(n) := itbLD_creg_resolution(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuCreg_Resolution_Id
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
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuCreg_Resolution_Id = rcData.Creg_Resolution_Id
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
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuCreg_Resolution_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type
  )
  IS
    rcError styLD_creg_resolution;
  BEGIN    rcError.Creg_Resolution_Id:=inuCreg_Resolution_Id;

    Load
    (
      inuCreg_Resolution_Id
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
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuCreg_Resolution_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type,
    orcRecord out nocopy styLD_creg_resolution
  )
  IS
    rcError styLD_creg_resolution;
  BEGIN    rcError.Creg_Resolution_Id:=inuCreg_Resolution_Id;

    Load
    (
      inuCreg_Resolution_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type
  )
  RETURN styLD_creg_resolution
  IS
    rcError styLD_creg_resolution;
  BEGIN
    rcError.Creg_Resolution_Id:=inuCreg_Resolution_Id;

    Load
    (
      inuCreg_Resolution_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type
  )
  RETURN styLD_creg_resolution
  IS
    rcError styLD_creg_resolution;
  BEGIN
    rcError.Creg_Resolution_Id:=inuCreg_Resolution_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuCreg_Resolution_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuCreg_Resolution_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_creg_resolution
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_creg_resolution
  )
  IS
    rfLD_creg_resolution tyrfLD_creg_resolution;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_creg_resolution.Creg_Resolution_Id,
                LD_creg_resolution.Resolution,
                LD_creg_resolution.Date_Resolution,
                LD_creg_resolution.rowid
                FROM LD_creg_resolution';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_creg_resolution for sbFullQuery;
    fetch rfLD_creg_resolution bulk collect INTO otbResult;
    close rfLD_creg_resolution;
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
                LD_creg_resolution.Creg_Resolution_Id,
                LD_creg_resolution.Resolution,
                LD_creg_resolution.Date_Resolution,
                LD_creg_resolution.rowid
                FROM LD_creg_resolution';
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
    ircLD_creg_resolution in styLD_creg_resolution
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_creg_resolution,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_creg_resolution in styLD_creg_resolution,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_creg_resolution.Creg_Resolution_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|Creg_Resolution_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_creg_resolution
    (
      Creg_Resolution_Id,
      Resolution,
      Date_Resolution
    )
    values
    (
      ircLD_creg_resolution.Creg_Resolution_Id,
      ircLD_creg_resolution.Resolution,
      ircLD_creg_resolution.Date_Resolution
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_creg_resolution));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_creg_resolution in out nocopy tytbLD_creg_resolution
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_creg_resolution, blUseRowID);
    forall n in iotbLD_creg_resolution.first..iotbLD_creg_resolution.last
      insert into LD_creg_resolution
      (
      Creg_Resolution_Id,
      Resolution,
      Date_Resolution
    )
    values
    (
      rcRecOfTab.Creg_Resolution_Id(n),
      rcRecOfTab.Resolution(n),
      rcRecOfTab.Date_Resolution(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_creg_resolution;
  BEGIN
    rcError.Creg_Resolution_Id:=inuCreg_Resolution_Id;

    if inuLock=1 then
      LockByPk
      (
        inuCreg_Resolution_Id,
        rcData
      );
    end if;

    delete
    from LD_creg_resolution
    where
           Creg_Resolution_Id=inuCreg_Resolution_Id;
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
    rcError  styLD_creg_resolution;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_creg_resolution
    where
      rowid = iriRowID
    returning
   Creg_Resolution_Id
    into
      rcError.Creg_Resolution_Id;

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
    iotbLD_creg_resolution in out nocopy tytbLD_creg_resolution,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_creg_resolution;
  BEGIN
    FillRecordOfTables(iotbLD_creg_resolution, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_creg_resolution.first .. iotbLD_creg_resolution.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_creg_resolution.first .. iotbLD_creg_resolution.last
        delete
        from LD_creg_resolution
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_creg_resolution.first .. iotbLD_creg_resolution.last loop
          LockByPk
          (
              rcRecOfTab.Creg_Resolution_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_creg_resolution.first .. iotbLD_creg_resolution.last
        delete
        from LD_creg_resolution
        where
               Creg_Resolution_Id = rcRecOfTab.Creg_Resolution_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_creg_resolution in styLD_creg_resolution,
    inuLock    in number default 0
  )
  IS
    nuCreg_Resolution_Id LD_creg_resolution.Creg_Resolution_Id%type;

  BEGIN
    if ircLD_creg_resolution.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_creg_resolution.rowid,rcData);
      end if;
      update LD_creg_resolution
      set

        Resolution = ircLD_creg_resolution.Resolution,
        Date_Resolution = ircLD_creg_resolution.Date_Resolution
      where
        rowid = ircLD_creg_resolution.rowid
      returning
    Creg_Resolution_Id
      into
        nuCreg_Resolution_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_creg_resolution.Creg_Resolution_Id,
          rcData
        );
      end if;

      update LD_creg_resolution
      set
        Resolution = ircLD_creg_resolution.Resolution,
        Date_Resolution = ircLD_creg_resolution.Date_Resolution
      where
             Creg_Resolution_Id = ircLD_creg_resolution.Creg_Resolution_Id
      returning
    Creg_Resolution_Id
      into
        nuCreg_Resolution_Id;
    end if;

    if
      nuCreg_Resolution_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_creg_resolution));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_creg_resolution in out nocopy tytbLD_creg_resolution,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_creg_resolution;
  BEGIN
    FillRecordOfTables(iotbLD_creg_resolution,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_creg_resolution.first .. iotbLD_creg_resolution.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_creg_resolution.first .. iotbLD_creg_resolution.last
        update LD_creg_resolution
        set

            Resolution = rcRecOfTab.Resolution(n),
            Date_Resolution = rcRecOfTab.Date_Resolution(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_creg_resolution.first .. iotbLD_creg_resolution.last loop
          LockByPk
          (
              rcRecOfTab.Creg_Resolution_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_creg_resolution.first .. iotbLD_creg_resolution.last
        update LD_creg_resolution
        set
          Resolution = rcRecOfTab.Resolution(n),
          Date_Resolution = rcRecOfTab.Date_Resolution(n)
          where
          Creg_Resolution_Id = rcRecOfTab.Creg_Resolution_Id(n)
;
    end if;
  END;

  PROCEDURE updResolution
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type,
    isbResolution$ in LD_creg_resolution.Resolution%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_creg_resolution;
  BEGIN
    rcError.Creg_Resolution_Id := inuCreg_Resolution_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCreg_Resolution_Id,
        rcData
      );
    end if;

    update LD_creg_resolution
    set
      Resolution = isbResolution$
    where
      Creg_Resolution_Id = inuCreg_Resolution_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Resolution:= isbResolution$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updDate_Resolution
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type,
    idtDate_Resolution$ in LD_creg_resolution.Date_Resolution%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_creg_resolution;
  BEGIN
    rcError.Creg_Resolution_Id := inuCreg_Resolution_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCreg_Resolution_Id,
        rcData
      );
    end if;

    update LD_creg_resolution
    set
      Date_Resolution = idtDate_Resolution$
    where
      Creg_Resolution_Id = inuCreg_Resolution_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Date_Resolution:= idtDate_Resolution$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetCreg_Resolution_Id
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_creg_resolution.Creg_Resolution_Id%type
  IS
    rcError styLD_creg_resolution;
  BEGIN

    rcError.Creg_Resolution_Id := inuCreg_Resolution_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCreg_Resolution_Id
       )
    then
       return(rcData.Creg_Resolution_Id);
    end if;
    Load
    (
      inuCreg_Resolution_Id
    );
    return(rcData.Creg_Resolution_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetResolution
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_creg_resolution.Resolution%type
  IS
    rcError styLD_creg_resolution;
  BEGIN

    rcError.Creg_Resolution_Id:=inuCreg_Resolution_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCreg_Resolution_Id
       )
    then
       return(rcData.Resolution);
    end if;
    Load
    (
      inuCreg_Resolution_Id
    );
    return(rcData.Resolution);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fdtGetDate_Resolution
  (
    inuCreg_Resolution_Id in LD_creg_resolution.Creg_Resolution_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_creg_resolution.Date_Resolution%type
  IS
    rcError styLD_creg_resolution;
  BEGIN

    rcError.Creg_Resolution_Id:=inuCreg_Resolution_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuCreg_Resolution_Id
       )
    then
       return(rcData.Date_Resolution);
    end if;
    Load
    (
         inuCreg_Resolution_Id
    );
    return(rcData.Date_Resolution);
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
end DALD_creg_resolution;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_CREG_RESOLUTION
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_CREG_RESOLUTION', 'ADM_PERSON'); 
END;
/
