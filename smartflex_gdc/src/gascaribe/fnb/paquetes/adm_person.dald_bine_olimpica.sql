CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_bine_olimpica
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
    06/06/2024              PAcosta         OSF-2778: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    
    
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type
  )
  IS
		SELECT LD_bine_olimpica.*,LD_bine_olimpica.rowid
		FROM LD_bine_olimpica
		WHERE
			BINE_OLIMPICA_Id = inuBINE_OLIMPICA_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_bine_olimpica.*,LD_bine_olimpica.rowid
		FROM LD_bine_olimpica
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_bine_olimpica  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_bine_olimpica is table of styLD_bine_olimpica index by binary_integer;
	type tyrfRecords is ref cursor return styLD_bine_olimpica;

	/* Tipos referenciando al registro */
	type tytbOrder_Id is table of LD_bine_olimpica.Order_Id%type index by binary_integer;
	type tytbBine_Olimpica_Id is table of LD_bine_olimpica.Bine_Olimpica_Id%type index by binary_integer;
	type tytbServcodi is table of LD_bine_olimpica.Servcodi%type index by binary_integer;
	type tytbId_Contratista is table of LD_bine_olimpica.Id_Contratista%type index by binary_integer;
	type tytbUser_Name is table of LD_bine_olimpica.User_Name%type index by binary_integer;
	type tytbBine_Status is table of LD_bine_olimpica.Bine_Status%type index by binary_integer;
	type tytbSale_Value_Financ is table of LD_bine_olimpica.Sale_Value_Financ%type index by binary_integer;
	type tytbCreation_Date_Aprv is table of LD_bine_olimpica.Creation_Date_Aprv%type index by binary_integer;
	type tytbBin_Date_Reported is table of LD_bine_olimpica.Bin_Date_Reported%type index by binary_integer;
	type tytbBin_File_Name is table of LD_bine_olimpica.Bin_File_Name%type index by binary_integer;
	type tytbTerminal is table of LD_bine_olimpica.Terminal%type index by binary_integer;
	type tytbProgram is table of LD_bine_olimpica.Program%type index by binary_integer;
	type tytbLegalization_Date is table of LD_bine_olimpica.Legalization_Date%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_bine_olimpica is record
	(

		Order_Id   tytbOrder_Id,
		Bine_Olimpica_Id   tytbBine_Olimpica_Id,
		Servcodi   tytbServcodi,
		Id_Contratista   tytbId_Contratista,
		User_Name   tytbUser_Name,
		Bine_Status   tytbBine_Status,
		Sale_Value_Financ   tytbSale_Value_Financ,
		Creation_Date_Aprv   tytbCreation_Date_Aprv,
		Bin_Date_Reported   tytbBin_Date_Reported,
		Bin_File_Name   tytbBin_File_Name,
		Terminal   tytbTerminal,
		Program   tytbProgram,
		Legalization_Date   tytbLegalization_Date,
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
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type
	);

	PROCEDURE getRecord
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		orcRecord out nocopy styLD_bine_olimpica
	);

	FUNCTION frcGetRcData
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type
	)
	RETURN styLD_bine_olimpica;

	FUNCTION frcGetRcData
	RETURN styLD_bine_olimpica;

	FUNCTION frcGetRecord
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type
	)
	RETURN styLD_bine_olimpica;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_bine_olimpica
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_bine_olimpica in styLD_bine_olimpica
	);

 	  PROCEDURE insRecord
	(
		ircLD_bine_olimpica in styLD_bine_olimpica,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_bine_olimpica in out nocopy tytbLD_bine_olimpica
	);

	PROCEDURE delRecord
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_bine_olimpica in out nocopy tytbLD_bine_olimpica,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_bine_olimpica in styLD_bine_olimpica,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_bine_olimpica in out nocopy tytbLD_bine_olimpica,
		inuLock in number default 1
	);

		PROCEDURE updOrder_Id
		(
				inuBINE_OLIMPICA_Id   in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
				inuOrder_Id$  in LD_bine_olimpica.Order_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updServcodi
		(
				inuBINE_OLIMPICA_Id   in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
				inuServcodi$  in LD_bine_olimpica.Servcodi%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updId_Contratista
		(
				inuBINE_OLIMPICA_Id   in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
				inuId_Contratista$  in LD_bine_olimpica.Id_Contratista%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updUser_Name
		(
				inuBINE_OLIMPICA_Id   in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
				isbUser_Name$  in LD_bine_olimpica.User_Name%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updBine_Status
		(
				inuBINE_OLIMPICA_Id   in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
				isbBine_Status$  in LD_bine_olimpica.Bine_Status%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSale_Value_Financ
		(
				inuBINE_OLIMPICA_Id   in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
				inuSale_Value_Financ$  in LD_bine_olimpica.Sale_Value_Financ%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCreation_Date_Aprv
		(
				inuBINE_OLIMPICA_Id   in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
				idtCreation_Date_Aprv$  in LD_bine_olimpica.Creation_Date_Aprv%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updBin_Date_Reported
		(
				inuBINE_OLIMPICA_Id   in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
				idtBin_Date_Reported$  in LD_bine_olimpica.Bin_Date_Reported%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updBin_File_Name
		(
				inuBINE_OLIMPICA_Id   in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
				isbBin_File_Name$  in LD_bine_olimpica.Bin_File_Name%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updTerminal
		(
				inuBINE_OLIMPICA_Id   in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
				isbTerminal$  in LD_bine_olimpica.Terminal%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updProgram
		(
				inuBINE_OLIMPICA_Id   in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
				isbProgram$  in LD_bine_olimpica.Program%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updLegalization_Date
		(
				inuBINE_OLIMPICA_Id   in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
				idtLegalization_Date$  in LD_bine_olimpica.Legalization_Date%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetOrder_Id
    	(
    	    inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bine_olimpica.Order_Id%type;

    	FUNCTION fsbGetBine_Olimpica_Id
    	(
    	    inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bine_olimpica.Bine_Olimpica_Id%type;

    	FUNCTION fnuGetServcodi
    	(
    	    inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bine_olimpica.Servcodi%type;

    	FUNCTION fnuGetId_Contratista
    	(
    	    inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bine_olimpica.Id_Contratista%type;

    	FUNCTION fsbGetUser_Name
    	(
    	    inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bine_olimpica.User_Name%type;

    	FUNCTION fsbGetBine_Status
    	(
    	    inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bine_olimpica.Bine_Status%type;

    	FUNCTION fnuGetSale_Value_Financ
    	(
    	    inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bine_olimpica.Sale_Value_Financ%type;

    	FUNCTION fdtGetCreation_Date_Aprv
    	(
    	    inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_bine_olimpica.Creation_Date_Aprv%type;

    	FUNCTION fdtGetBin_Date_Reported
    	(
    	    inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_bine_olimpica.Bin_Date_Reported%type;

    	FUNCTION fsbGetBin_File_Name
    	(
    	    inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bine_olimpica.Bin_File_Name%type;

    	FUNCTION fsbGetTerminal
    	(
    	    inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bine_olimpica.Terminal%type;

    	FUNCTION fsbGetProgram
    	(
    	    inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_bine_olimpica.Program%type;

    	FUNCTION fdtGetLegalization_Date
    	(
    	    inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_bine_olimpica.Legalization_Date%type;


	PROCEDURE LockByPk
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		orcLD_bine_olimpica  out styLD_bine_olimpica
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_bine_olimpica  out styLD_bine_olimpica
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_bine_olimpica;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_bine_olimpica
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156922';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_BINE_OLIMPICA';
	  cnuGeEntityId constant varchar2(30) := 8235; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type
	)
	IS
		SELECT LD_bine_olimpica.*,LD_bine_olimpica.rowid
		FROM LD_bine_olimpica
		WHERE  BINE_OLIMPICA_Id = inuBINE_OLIMPICA_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_bine_olimpica.*,LD_bine_olimpica.rowid
		FROM LD_bine_olimpica
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_bine_olimpica is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_bine_olimpica;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_bine_olimpica default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.BINE_OLIMPICA_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		orcLD_bine_olimpica  out styLD_bine_olimpica
	)
	IS
		rcError styLD_bine_olimpica;
	BEGIN
		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;

		Open cuLockRcByPk
		(
			inuBINE_OLIMPICA_Id
		);

		fetch cuLockRcByPk into orcLD_bine_olimpica;
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
		orcLD_bine_olimpica  out styLD_bine_olimpica
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_bine_olimpica;
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
		itbLD_bine_olimpica  in out nocopy tytbLD_bine_olimpica
	)
	IS
	BEGIN
			rcRecOfTab.Order_Id.delete;
			rcRecOfTab.Bine_Olimpica_Id.delete;
			rcRecOfTab.Servcodi.delete;
			rcRecOfTab.Id_Contratista.delete;
			rcRecOfTab.User_Name.delete;
			rcRecOfTab.Bine_Status.delete;
			rcRecOfTab.Sale_Value_Financ.delete;
			rcRecOfTab.Creation_Date_Aprv.delete;
			rcRecOfTab.Bin_Date_Reported.delete;
			rcRecOfTab.Bin_File_Name.delete;
			rcRecOfTab.Terminal.delete;
			rcRecOfTab.Program.delete;
			rcRecOfTab.Legalization_Date.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_bine_olimpica  in out nocopy tytbLD_bine_olimpica,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_bine_olimpica);
		for n in itbLD_bine_olimpica.first .. itbLD_bine_olimpica.last loop
			rcRecOfTab.Order_Id(n) := itbLD_bine_olimpica(n).Order_Id;
			rcRecOfTab.Bine_Olimpica_Id(n) := itbLD_bine_olimpica(n).Bine_Olimpica_Id;
			rcRecOfTab.Servcodi(n) := itbLD_bine_olimpica(n).Servcodi;
			rcRecOfTab.Id_Contratista(n) := itbLD_bine_olimpica(n).Id_Contratista;
			rcRecOfTab.User_Name(n) := itbLD_bine_olimpica(n).User_Name;
			rcRecOfTab.Bine_Status(n) := itbLD_bine_olimpica(n).Bine_Status;
			rcRecOfTab.Sale_Value_Financ(n) := itbLD_bine_olimpica(n).Sale_Value_Financ;
			rcRecOfTab.Creation_Date_Aprv(n) := itbLD_bine_olimpica(n).Creation_Date_Aprv;
			rcRecOfTab.Bin_Date_Reported(n) := itbLD_bine_olimpica(n).Bin_Date_Reported;
			rcRecOfTab.Bin_File_Name(n) := itbLD_bine_olimpica(n).Bin_File_Name;
			rcRecOfTab.Terminal(n) := itbLD_bine_olimpica(n).Terminal;
			rcRecOfTab.Program(n) := itbLD_bine_olimpica(n).Program;
			rcRecOfTab.Legalization_Date(n) := itbLD_bine_olimpica(n).Legalization_Date;
			rcRecOfTab.row_id(n) := itbLD_bine_olimpica(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuBINE_OLIMPICA_Id
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
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuBINE_OLIMPICA_Id = rcData.BINE_OLIMPICA_Id
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
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuBINE_OLIMPICA_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type
	)
	IS
		rcError styLD_bine_olimpica;
	BEGIN		rcError.BINE_OLIMPICA_Id:=inuBINE_OLIMPICA_Id;

		Load
		(
			inuBINE_OLIMPICA_Id
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
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuBINE_OLIMPICA_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		orcRecord out nocopy styLD_bine_olimpica
	)
	IS
		rcError styLD_bine_olimpica;
	BEGIN		rcError.BINE_OLIMPICA_Id:=inuBINE_OLIMPICA_Id;

		Load
		(
			inuBINE_OLIMPICA_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type
	)
	RETURN styLD_bine_olimpica
	IS
		rcError styLD_bine_olimpica;
	BEGIN
		rcError.BINE_OLIMPICA_Id:=inuBINE_OLIMPICA_Id;

		Load
		(
			inuBINE_OLIMPICA_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type
	)
	RETURN styLD_bine_olimpica
	IS
		rcError styLD_bine_olimpica;
	BEGIN
		rcError.BINE_OLIMPICA_Id:=inuBINE_OLIMPICA_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBINE_OLIMPICA_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuBINE_OLIMPICA_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_bine_olimpica
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_bine_olimpica
	)
	IS
		rfLD_bine_olimpica tyrfLD_bine_olimpica;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_bine_olimpica.Order_Id,
		            LD_bine_olimpica.Bine_Olimpica_Id,
		            LD_bine_olimpica.Servcodi,
		            LD_bine_olimpica.Id_Contratista,
		            LD_bine_olimpica.User_Name,
		            LD_bine_olimpica.Bine_Status,
		            LD_bine_olimpica.Sale_Value_Financ,
		            LD_bine_olimpica.Creation_Date_Aprv,
		            LD_bine_olimpica.Bin_Date_Reported,
		            LD_bine_olimpica.Bin_File_Name,
		            LD_bine_olimpica.Terminal,
		            LD_bine_olimpica.Program,
		            LD_bine_olimpica.Legalization_Date,
		            LD_bine_olimpica.rowid
                FROM LD_bine_olimpica';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_bine_olimpica for sbFullQuery;
		fetch rfLD_bine_olimpica bulk collect INTO otbResult;
		close rfLD_bine_olimpica;
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
		            LD_bine_olimpica.Order_Id,
		            LD_bine_olimpica.Bine_Olimpica_Id,
		            LD_bine_olimpica.Servcodi,
		            LD_bine_olimpica.Id_Contratista,
		            LD_bine_olimpica.User_Name,
		            LD_bine_olimpica.Bine_Status,
		            LD_bine_olimpica.Sale_Value_Financ,
		            LD_bine_olimpica.Creation_Date_Aprv,
		            LD_bine_olimpica.Bin_Date_Reported,
		            LD_bine_olimpica.Bin_File_Name,
		            LD_bine_olimpica.Terminal,
		            LD_bine_olimpica.Program,
		            LD_bine_olimpica.Legalization_Date,
		            LD_bine_olimpica.rowid
                FROM LD_bine_olimpica';
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
		ircLD_bine_olimpica in styLD_bine_olimpica
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_bine_olimpica,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_bine_olimpica in styLD_bine_olimpica,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_bine_olimpica.BINE_OLIMPICA_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|BINE_OLIMPICA_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_bine_olimpica
		(
			Order_Id,
			Bine_Olimpica_Id,
			Servcodi,
			Id_Contratista,
			User_Name,
			Bine_Status,
			Sale_Value_Financ,
			Creation_Date_Aprv,
			Bin_Date_Reported,
			Bin_File_Name,
			Terminal,
			Program,
			Legalization_Date
		)
		values
		(
			ircLD_bine_olimpica.Order_Id,
			ircLD_bine_olimpica.Bine_Olimpica_Id,
			ircLD_bine_olimpica.Servcodi,
			ircLD_bine_olimpica.Id_Contratista,
			ircLD_bine_olimpica.User_Name,
			ircLD_bine_olimpica.Bine_Status,
			ircLD_bine_olimpica.Sale_Value_Financ,
			ircLD_bine_olimpica.Creation_Date_Aprv,
			ircLD_bine_olimpica.Bin_Date_Reported,
			ircLD_bine_olimpica.Bin_File_Name,
			ircLD_bine_olimpica.Terminal,
			ircLD_bine_olimpica.Program,
			ircLD_bine_olimpica.Legalization_Date
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_bine_olimpica));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_bine_olimpica in out nocopy tytbLD_bine_olimpica
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_bine_olimpica, blUseRowID);
		forall n in iotbLD_bine_olimpica.first..iotbLD_bine_olimpica.last
			insert into LD_bine_olimpica
			(
			Order_Id,
			Bine_Olimpica_Id,
			Servcodi,
			Id_Contratista,
			User_Name,
			Bine_Status,
			Sale_Value_Financ,
			Creation_Date_Aprv,
			Bin_Date_Reported,
			Bin_File_Name,
			Terminal,
			Program,
			Legalization_Date
		)
		values
		(
			rcRecOfTab.Order_Id(n),
			rcRecOfTab.Bine_Olimpica_Id(n),
			rcRecOfTab.Servcodi(n),
			rcRecOfTab.Id_Contratista(n),
			rcRecOfTab.User_Name(n),
			rcRecOfTab.Bine_Status(n),
			rcRecOfTab.Sale_Value_Financ(n),
			rcRecOfTab.Creation_Date_Aprv(n),
			rcRecOfTab.Bin_Date_Reported(n),
			rcRecOfTab.Bin_File_Name(n),
			rcRecOfTab.Terminal(n),
			rcRecOfTab.Program(n),
			rcRecOfTab.Legalization_Date(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_bine_olimpica;
	BEGIN
		rcError.BINE_OLIMPICA_Id:=inuBINE_OLIMPICA_Id;

		if inuLock=1 then
			LockByPk
			(
				inuBINE_OLIMPICA_Id,
				rcData
			);
		end if;

		delete
		from LD_bine_olimpica
		where
       		BINE_OLIMPICA_Id=inuBINE_OLIMPICA_Id;
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
		rcError  styLD_bine_olimpica;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_bine_olimpica
		where
			rowid = iriRowID
		returning
   BINE_OLIMPICA_Id
		into
			rcError.BINE_OLIMPICA_Id;

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
		iotbLD_bine_olimpica in out nocopy tytbLD_bine_olimpica,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_bine_olimpica;
	BEGIN
		FillRecordOfTables(iotbLD_bine_olimpica, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_bine_olimpica.first .. iotbLD_bine_olimpica.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_bine_olimpica.first .. iotbLD_bine_olimpica.last
				delete
				from LD_bine_olimpica
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_bine_olimpica.first .. iotbLD_bine_olimpica.last loop
					LockByPk
					(
							rcRecOfTab.BINE_OLIMPICA_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_bine_olimpica.first .. iotbLD_bine_olimpica.last
				delete
				from LD_bine_olimpica
				where
		         	BINE_OLIMPICA_Id = rcRecOfTab.BINE_OLIMPICA_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_bine_olimpica in styLD_bine_olimpica,
		inuLock	  in number default 0
	)
	IS
		nuBINE_OLIMPICA_Id LD_bine_olimpica.BINE_OLIMPICA_Id%type;

	BEGIN
		if ircLD_bine_olimpica.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_bine_olimpica.rowid,rcData);
			end if;
			update LD_bine_olimpica
			set

        Order_Id = ircLD_bine_olimpica.Order_Id,
        Servcodi = ircLD_bine_olimpica.Servcodi,
        Id_Contratista = ircLD_bine_olimpica.Id_Contratista,
        User_Name = ircLD_bine_olimpica.User_Name,
        Bine_Status = ircLD_bine_olimpica.Bine_Status,
        Sale_Value_Financ = ircLD_bine_olimpica.Sale_Value_Financ,
        Creation_Date_Aprv = ircLD_bine_olimpica.Creation_Date_Aprv,
        Bin_Date_Reported = ircLD_bine_olimpica.Bin_Date_Reported,
        Bin_File_Name = ircLD_bine_olimpica.Bin_File_Name,
        Terminal = ircLD_bine_olimpica.Terminal,
        Program = ircLD_bine_olimpica.Program,
        Legalization_Date = ircLD_bine_olimpica.Legalization_Date
			where
				rowid = ircLD_bine_olimpica.rowid
			returning
    BINE_OLIMPICA_Id
			into
				nuBINE_OLIMPICA_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_bine_olimpica.BINE_OLIMPICA_Id,
					rcData
				);
			end if;

			update LD_bine_olimpica
			set
        Order_Id = ircLD_bine_olimpica.Order_Id,
        Servcodi = ircLD_bine_olimpica.Servcodi,
        Id_Contratista = ircLD_bine_olimpica.Id_Contratista,
        User_Name = ircLD_bine_olimpica.User_Name,
        Bine_Status = ircLD_bine_olimpica.Bine_Status,
        Sale_Value_Financ = ircLD_bine_olimpica.Sale_Value_Financ,
        Creation_Date_Aprv = ircLD_bine_olimpica.Creation_Date_Aprv,
        Bin_Date_Reported = ircLD_bine_olimpica.Bin_Date_Reported,
        Bin_File_Name = ircLD_bine_olimpica.Bin_File_Name,
        Terminal = ircLD_bine_olimpica.Terminal,
        Program = ircLD_bine_olimpica.Program,
        Legalization_Date = ircLD_bine_olimpica.Legalization_Date
			where
	         	BINE_OLIMPICA_Id = ircLD_bine_olimpica.BINE_OLIMPICA_Id
			returning
    BINE_OLIMPICA_Id
			into
				nuBINE_OLIMPICA_Id;
		end if;

		if
			nuBINE_OLIMPICA_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_bine_olimpica));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_bine_olimpica in out nocopy tytbLD_bine_olimpica,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_bine_olimpica;
  BEGIN
    FillRecordOfTables(iotbLD_bine_olimpica,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_bine_olimpica.first .. iotbLD_bine_olimpica.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_bine_olimpica.first .. iotbLD_bine_olimpica.last
        update LD_bine_olimpica
        set

            Order_Id = rcRecOfTab.Order_Id(n),
            Servcodi = rcRecOfTab.Servcodi(n),
            Id_Contratista = rcRecOfTab.Id_Contratista(n),
            User_Name = rcRecOfTab.User_Name(n),
            Bine_Status = rcRecOfTab.Bine_Status(n),
            Sale_Value_Financ = rcRecOfTab.Sale_Value_Financ(n),
            Creation_Date_Aprv = rcRecOfTab.Creation_Date_Aprv(n),
            Bin_Date_Reported = rcRecOfTab.Bin_Date_Reported(n),
            Bin_File_Name = rcRecOfTab.Bin_File_Name(n),
            Terminal = rcRecOfTab.Terminal(n),
            Program = rcRecOfTab.Program(n),
            Legalization_Date = rcRecOfTab.Legalization_Date(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_bine_olimpica.first .. iotbLD_bine_olimpica.last loop
          LockByPk
          (
              rcRecOfTab.BINE_OLIMPICA_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_bine_olimpica.first .. iotbLD_bine_olimpica.last
        update LD_bine_olimpica
        set
					Order_Id = rcRecOfTab.Order_Id(n),
					Servcodi = rcRecOfTab.Servcodi(n),
					Id_Contratista = rcRecOfTab.Id_Contratista(n),
					User_Name = rcRecOfTab.User_Name(n),
					Bine_Status = rcRecOfTab.Bine_Status(n),
					Sale_Value_Financ = rcRecOfTab.Sale_Value_Financ(n),
					Creation_Date_Aprv = rcRecOfTab.Creation_Date_Aprv(n),
					Bin_Date_Reported = rcRecOfTab.Bin_Date_Reported(n),
					Bin_File_Name = rcRecOfTab.Bin_File_Name(n),
					Terminal = rcRecOfTab.Terminal(n),
					Program = rcRecOfTab.Program(n),
					Legalization_Date = rcRecOfTab.Legalization_Date(n)
          where
          BINE_OLIMPICA_Id = rcRecOfTab.BINE_OLIMPICA_Id(n)
;
    end if;
  END;

	PROCEDURE updOrder_Id
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuOrder_Id$ in LD_bine_olimpica.Order_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bine_olimpica;
	BEGIN
		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBINE_OLIMPICA_Id,
				rcData
			);
		end if;

		update LD_bine_olimpica
		set
			Order_Id = inuOrder_Id$
		where
			BINE_OLIMPICA_Id = inuBINE_OLIMPICA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Order_Id:= inuOrder_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updServcodi
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuServcodi$ in LD_bine_olimpica.Servcodi%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bine_olimpica;
	BEGIN
		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBINE_OLIMPICA_Id,
				rcData
			);
		end if;

		update LD_bine_olimpica
		set
			Servcodi = inuServcodi$
		where
			BINE_OLIMPICA_Id = inuBINE_OLIMPICA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Servcodi:= inuServcodi$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updId_Contratista
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuId_Contratista$ in LD_bine_olimpica.Id_Contratista%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bine_olimpica;
	BEGIN
		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBINE_OLIMPICA_Id,
				rcData
			);
		end if;

		update LD_bine_olimpica
		set
			Id_Contratista = inuId_Contratista$
		where
			BINE_OLIMPICA_Id = inuBINE_OLIMPICA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Id_Contratista:= inuId_Contratista$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updUser_Name
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		isbUser_Name$ in LD_bine_olimpica.User_Name%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bine_olimpica;
	BEGIN
		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBINE_OLIMPICA_Id,
				rcData
			);
		end if;

		update LD_bine_olimpica
		set
			User_Name = isbUser_Name$
		where
			BINE_OLIMPICA_Id = inuBINE_OLIMPICA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.User_Name:= isbUser_Name$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updBine_Status
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		isbBine_Status$ in LD_bine_olimpica.Bine_Status%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bine_olimpica;
	BEGIN
		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBINE_OLIMPICA_Id,
				rcData
			);
		end if;

		update LD_bine_olimpica
		set
			Bine_Status = isbBine_Status$
		where
			BINE_OLIMPICA_Id = inuBINE_OLIMPICA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Bine_Status:= isbBine_Status$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSale_Value_Financ
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuSale_Value_Financ$ in LD_bine_olimpica.Sale_Value_Financ%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bine_olimpica;
	BEGIN
		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBINE_OLIMPICA_Id,
				rcData
			);
		end if;

		update LD_bine_olimpica
		set
			Sale_Value_Financ = inuSale_Value_Financ$
		where
			BINE_OLIMPICA_Id = inuBINE_OLIMPICA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Sale_Value_Financ:= inuSale_Value_Financ$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCreation_Date_Aprv
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		idtCreation_Date_Aprv$ in LD_bine_olimpica.Creation_Date_Aprv%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bine_olimpica;
	BEGIN
		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBINE_OLIMPICA_Id,
				rcData
			);
		end if;

		update LD_bine_olimpica
		set
			Creation_Date_Aprv = idtCreation_Date_Aprv$
		where
			BINE_OLIMPICA_Id = inuBINE_OLIMPICA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Creation_Date_Aprv:= idtCreation_Date_Aprv$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updBin_Date_Reported
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		idtBin_Date_Reported$ in LD_bine_olimpica.Bin_Date_Reported%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bine_olimpica;
	BEGIN
		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBINE_OLIMPICA_Id,
				rcData
			);
		end if;

		update LD_bine_olimpica
		set
			Bin_Date_Reported = idtBin_Date_Reported$
		where
			BINE_OLIMPICA_Id = inuBINE_OLIMPICA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Bin_Date_Reported:= idtBin_Date_Reported$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updBin_File_Name
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		isbBin_File_Name$ in LD_bine_olimpica.Bin_File_Name%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bine_olimpica;
	BEGIN
		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBINE_OLIMPICA_Id,
				rcData
			);
		end if;

		update LD_bine_olimpica
		set
			Bin_File_Name = isbBin_File_Name$
		where
			BINE_OLIMPICA_Id = inuBINE_OLIMPICA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Bin_File_Name:= isbBin_File_Name$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updTerminal
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		isbTerminal$ in LD_bine_olimpica.Terminal%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bine_olimpica;
	BEGIN
		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBINE_OLIMPICA_Id,
				rcData
			);
		end if;

		update LD_bine_olimpica
		set
			Terminal = isbTerminal$
		where
			BINE_OLIMPICA_Id = inuBINE_OLIMPICA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Terminal:= isbTerminal$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updProgram
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		isbProgram$ in LD_bine_olimpica.Program%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bine_olimpica;
	BEGIN
		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBINE_OLIMPICA_Id,
				rcData
			);
		end if;

		update LD_bine_olimpica
		set
			Program = isbProgram$
		where
			BINE_OLIMPICA_Id = inuBINE_OLIMPICA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Program:= isbProgram$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updLegalization_Date
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		idtLegalization_Date$ in LD_bine_olimpica.Legalization_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_bine_olimpica;
	BEGIN
		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;
		if inuLock=1 then
			LockByPk
			(
				inuBINE_OLIMPICA_Id,
				rcData
			);
		end if;

		update LD_bine_olimpica
		set
			Legalization_Date = idtLegalization_Date$
		where
			BINE_OLIMPICA_Id = inuBINE_OLIMPICA_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Legalization_Date:= idtLegalization_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetOrder_Id
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bine_olimpica.Order_Id%type
	IS
		rcError styLD_bine_olimpica;
	BEGIN

		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBINE_OLIMPICA_Id
			 )
		then
			 return(rcData.Order_Id);
		end if;
		Load
		(
			inuBINE_OLIMPICA_Id
		);
		return(rcData.Order_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetBine_Olimpica_Id
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bine_olimpica.Bine_Olimpica_Id%type
	IS
		rcError styLD_bine_olimpica;
	BEGIN

		rcError.BINE_OLIMPICA_Id:=inuBINE_OLIMPICA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBINE_OLIMPICA_Id
			 )
		then
			 return(rcData.Bine_Olimpica_Id);
		end if;
		Load
		(
			inuBINE_OLIMPICA_Id
		);
		return(rcData.Bine_Olimpica_Id);
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
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bine_olimpica.Servcodi%type
	IS
		rcError styLD_bine_olimpica;
	BEGIN

		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBINE_OLIMPICA_Id
			 )
		then
			 return(rcData.Servcodi);
		end if;
		Load
		(
			inuBINE_OLIMPICA_Id
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

	FUNCTION fnuGetId_Contratista
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bine_olimpica.Id_Contratista%type
	IS
		rcError styLD_bine_olimpica;
	BEGIN

		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBINE_OLIMPICA_Id
			 )
		then
			 return(rcData.Id_Contratista);
		end if;
		Load
		(
			inuBINE_OLIMPICA_Id
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

	FUNCTION fsbGetUser_Name
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bine_olimpica.User_Name%type
	IS
		rcError styLD_bine_olimpica;
	BEGIN

		rcError.BINE_OLIMPICA_Id:=inuBINE_OLIMPICA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBINE_OLIMPICA_Id
			 )
		then
			 return(rcData.User_Name);
		end if;
		Load
		(
			inuBINE_OLIMPICA_Id
		);
		return(rcData.User_Name);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetBine_Status
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bine_olimpica.Bine_Status%type
	IS
		rcError styLD_bine_olimpica;
	BEGIN

		rcError.BINE_OLIMPICA_Id:=inuBINE_OLIMPICA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBINE_OLIMPICA_Id
			 )
		then
			 return(rcData.Bine_Status);
		end if;
		Load
		(
			inuBINE_OLIMPICA_Id
		);
		return(rcData.Bine_Status);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSale_Value_Financ
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bine_olimpica.Sale_Value_Financ%type
	IS
		rcError styLD_bine_olimpica;
	BEGIN

		rcError.BINE_OLIMPICA_Id := inuBINE_OLIMPICA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBINE_OLIMPICA_Id
			 )
		then
			 return(rcData.Sale_Value_Financ);
		end if;
		Load
		(
			inuBINE_OLIMPICA_Id
		);
		return(rcData.Sale_Value_Financ);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetCreation_Date_Aprv
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bine_olimpica.Creation_Date_Aprv%type
	IS
		rcError styLD_bine_olimpica;
	BEGIN

		rcError.BINE_OLIMPICA_Id:=inuBINE_OLIMPICA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBINE_OLIMPICA_Id
			 )
		then
			 return(rcData.Creation_Date_Aprv);
		end if;
		Load
		(
		 		inuBINE_OLIMPICA_Id
		);
		return(rcData.Creation_Date_Aprv);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetBin_Date_Reported
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bine_olimpica.Bin_Date_Reported%type
	IS
		rcError styLD_bine_olimpica;
	BEGIN

		rcError.BINE_OLIMPICA_Id:=inuBINE_OLIMPICA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBINE_OLIMPICA_Id
			 )
		then
			 return(rcData.Bin_Date_Reported);
		end if;
		Load
		(
		 		inuBINE_OLIMPICA_Id
		);
		return(rcData.Bin_Date_Reported);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetBin_File_Name
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bine_olimpica.Bin_File_Name%type
	IS
		rcError styLD_bine_olimpica;
	BEGIN

		rcError.BINE_OLIMPICA_Id:=inuBINE_OLIMPICA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBINE_OLIMPICA_Id
			 )
		then
			 return(rcData.Bin_File_Name);
		end if;
		Load
		(
			inuBINE_OLIMPICA_Id
		);
		return(rcData.Bin_File_Name);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetTerminal
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bine_olimpica.Terminal%type
	IS
		rcError styLD_bine_olimpica;
	BEGIN

		rcError.BINE_OLIMPICA_Id:=inuBINE_OLIMPICA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBINE_OLIMPICA_Id
			 )
		then
			 return(rcData.Terminal);
		end if;
		Load
		(
			inuBINE_OLIMPICA_Id
		);
		return(rcData.Terminal);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetProgram
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bine_olimpica.Program%type
	IS
		rcError styLD_bine_olimpica;
	BEGIN

		rcError.BINE_OLIMPICA_Id:=inuBINE_OLIMPICA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuBINE_OLIMPICA_Id
			 )
		then
			 return(rcData.Program);
		end if;
		Load
		(
			inuBINE_OLIMPICA_Id
		);
		return(rcData.Program);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetLegalization_Date
	(
		inuBINE_OLIMPICA_Id in LD_bine_olimpica.BINE_OLIMPICA_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_bine_olimpica.Legalization_Date%type
	IS
		rcError styLD_bine_olimpica;
	BEGIN

		rcError.BINE_OLIMPICA_Id:=inuBINE_OLIMPICA_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBINE_OLIMPICA_Id
			 )
		then
			 return(rcData.Legalization_Date);
		end if;
		Load
		(
		 		inuBINE_OLIMPICA_Id
		);
		return(rcData.Legalization_Date);
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
end DALD_bine_olimpica;
/
PROMPT Otorgando permisos de ejecucion a DALD_BINE_OLIMPICA
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_BINE_OLIMPICA', 'ADM_PERSON');
END;
/