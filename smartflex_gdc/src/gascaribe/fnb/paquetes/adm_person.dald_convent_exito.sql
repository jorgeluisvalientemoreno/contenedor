CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_convent_exito
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
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type
  )
  IS
		SELECT LD_convent_exito.*,LD_convent_exito.rowid
		FROM LD_convent_exito
		WHERE
			CONVENT_EXITO_Id = inuCONVENT_EXITO_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_convent_exito.*,LD_convent_exito.rowid
		FROM LD_convent_exito
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_convent_exito  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_convent_exito is table of styLD_convent_exito index by binary_integer;
	type tyrfRecords is ref cursor return styLD_convent_exito;

	/* Tipos referenciando al registro */
	type tytbConvent_Exito_Id is table of LD_convent_exito.Convent_Exito_Id%type index by binary_integer;
	type tytbOrder_Id is table of LD_convent_exito.Order_Id%type index by binary_integer;
	type tytbBar_Code is table of LD_convent_exito.Bar_Code%type index by binary_integer;
	type tytbPrinted_Number is table of LD_convent_exito.Printed_Number%type index by binary_integer;
	type tytbGenerate_File is table of LD_convent_exito.Generate_File%type index by binary_integer;
	type tytbPrinted_Bar_Code is table of LD_convent_exito.Printed_Bar_Code%type index by binary_integer;
	type tytbCreate_Date is table of LD_convent_exito.Create_Date%type index by binary_integer;
	type tytbUser_Name is table of LD_convent_exito.User_Name%type index by binary_integer;
	type tytbTerminal is table of LD_convent_exito.Terminal%type index by binary_integer;
	type tytbProgram is table of LD_convent_exito.Program%type index by binary_integer;
	type tytbStatus is table of LD_convent_exito.Status%type index by binary_integer;
	type tytbOperating_Unit_Id is table of LD_convent_exito.Operating_Unit_Id%type index by binary_integer;
	type tytbSusccodi is table of LD_convent_exito.Susccodi%type index by binary_integer;
	type tytbLegalization_Date is table of LD_convent_exito.Legalization_Date%type index by binary_integer;
	type tytbFile_Name is table of LD_convent_exito.File_Name%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_convent_exito is record
	(

		Convent_Exito_Id   tytbConvent_Exito_Id,
		Order_Id   tytbOrder_Id,
		Bar_Code   tytbBar_Code,
		Printed_Number   tytbPrinted_Number,
		Generate_File   tytbGenerate_File,
		Printed_Bar_Code   tytbPrinted_Bar_Code,
		Create_Date   tytbCreate_Date,
		User_Name   tytbUser_Name,
		Terminal   tytbTerminal,
		Program   tytbProgram,
		Status   tytbStatus,
		Operating_Unit_Id   tytbOperating_Unit_Id,
		Susccodi   tytbSusccodi,
		Legalization_Date   tytbLegalization_Date,
		File_Name   tytbFile_Name,
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
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type
	)
	RETURN boolean;

	 PROCEDURE AccKey
	 (
		 inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		 inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type
	);

	PROCEDURE getRecord
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		orcRecord out nocopy styLD_convent_exito
	);

	FUNCTION frcGetRcData
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type
	)
	RETURN styLD_convent_exito;

	FUNCTION frcGetRcData
	RETURN styLD_convent_exito;

	FUNCTION frcGetRecord
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type
	)
	RETURN styLD_convent_exito;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_convent_exito
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_convent_exito in styLD_convent_exito
	);

 	  PROCEDURE insRecord
	(
		ircLD_convent_exito in styLD_convent_exito,
		orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_convent_exito in out nocopy tytbLD_convent_exito
	);

	PROCEDURE delRecord
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_convent_exito in out nocopy tytbLD_convent_exito,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_convent_exito in styLD_convent_exito,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_convent_exito in out nocopy tytbLD_convent_exito,
		inuLock in number default 1
	);

		PROCEDURE updOrder_Id
		(
				inuCONVENT_EXITO_Id   in LD_convent_exito.CONVENT_EXITO_Id%type,
				inuOrder_Id$  in LD_convent_exito.Order_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updBar_Code
		(
				inuCONVENT_EXITO_Id   in LD_convent_exito.CONVENT_EXITO_Id%type,
				inuBar_Code$  in LD_convent_exito.Bar_Code%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updPrinted_Number
		(
				inuCONVENT_EXITO_Id   in LD_convent_exito.CONVENT_EXITO_Id%type,
				inuPrinted_Number$  in LD_convent_exito.Printed_Number%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updGenerate_File
		(
				inuCONVENT_EXITO_Id   in LD_convent_exito.CONVENT_EXITO_Id%type,
				isbGenerate_File$  in LD_convent_exito.Generate_File%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updPrinted_Bar_Code
		(
				inuCONVENT_EXITO_Id   in LD_convent_exito.CONVENT_EXITO_Id%type,
				isbPrinted_Bar_Code$  in LD_convent_exito.Printed_Bar_Code%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updCreate_Date
		(
				inuCONVENT_EXITO_Id   in LD_convent_exito.CONVENT_EXITO_Id%type,
				idtCreate_Date$  in LD_convent_exito.Create_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updUser_Name
		(
				inuCONVENT_EXITO_Id   in LD_convent_exito.CONVENT_EXITO_Id%type,
				isbUser_Name$  in LD_convent_exito.User_Name%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updTerminal
		(
				inuCONVENT_EXITO_Id   in LD_convent_exito.CONVENT_EXITO_Id%type,
				isbTerminal$  in LD_convent_exito.Terminal%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updProgram
		(
				inuCONVENT_EXITO_Id   in LD_convent_exito.CONVENT_EXITO_Id%type,
				isbProgram$  in LD_convent_exito.Program%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updStatus
		(
				inuCONVENT_EXITO_Id   in LD_convent_exito.CONVENT_EXITO_Id%type,
				isbStatus$  in LD_convent_exito.Status%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updOperating_Unit_Id
		(
				inuCONVENT_EXITO_Id   in LD_convent_exito.CONVENT_EXITO_Id%type,
				inuOperating_Unit_Id$  in LD_convent_exito.Operating_Unit_Id%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updSusccodi
		(
				inuCONVENT_EXITO_Id   in LD_convent_exito.CONVENT_EXITO_Id%type,
				inuSusccodi$  in LD_convent_exito.Susccodi%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updLegalization_Date
		(
				inuCONVENT_EXITO_Id   in LD_convent_exito.CONVENT_EXITO_Id%type,
				idtLegalization_Date$  in LD_convent_exito.Legalization_Date%type,
				inuLock	  in number default 0
    	);

		PROCEDURE updFile_Name
		(
				inuCONVENT_EXITO_Id   in LD_convent_exito.CONVENT_EXITO_Id%type,
				isbFile_Name$  in LD_convent_exito.File_Name%type,
				inuLock	  in number default 0
    	);

    	FUNCTION fnuGetConvent_Exito_Id
    	(
    	    inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_convent_exito.Convent_Exito_Id%type;

    	FUNCTION fnuGetOrder_Id
    	(
    	    inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_convent_exito.Order_Id%type;

    	FUNCTION fnuGetBar_Code
    	(
    	    inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_convent_exito.Bar_Code%type;

    	FUNCTION fnuGetPrinted_Number
    	(
    	    inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_convent_exito.Printed_Number%type;

    	FUNCTION fsbGetGenerate_File
    	(
    	    inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_convent_exito.Generate_File%type;

    	FUNCTION fsbGetPrinted_Bar_Code
    	(
    	    inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_convent_exito.Printed_Bar_Code%type;

    	FUNCTION fdtGetCreate_Date
    	(
    	    inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_convent_exito.Create_Date%type;

    	FUNCTION fsbGetUser_Name
    	(
    	    inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_convent_exito.User_Name%type;

    	FUNCTION fsbGetTerminal
    	(
    	    inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_convent_exito.Terminal%type;

    	FUNCTION fsbGetProgram
    	(
    	    inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_convent_exito.Program%type;

    	FUNCTION fsbGetStatus
    	(
    	    inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_convent_exito.Status%type;

    	FUNCTION fnuGetOperating_Unit_Id
    	(
    	    inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_convent_exito.Operating_Unit_Id%type;

    	FUNCTION fnuGetSusccodi
    	(
    	    inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_convent_exito.Susccodi%type;

    	FUNCTION fdtGetLegalization_Date
    	(
    	    inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_convent_exito.Legalization_Date%type;

    	FUNCTION fsbGetFile_Name
    	(
    	    inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_convent_exito.File_Name%type;


	PROCEDURE LockByPk
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		orcLD_convent_exito  out styLD_convent_exito
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_convent_exito  out styLD_convent_exito
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_convent_exito;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_convent_exito
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156922';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CONVENT_EXITO';
	  cnuGeEntityId constant varchar2(30) := 7339; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type
	)
	IS
		SELECT LD_convent_exito.*,LD_convent_exito.rowid
		FROM LD_convent_exito
		WHERE  CONVENT_EXITO_Id = inuCONVENT_EXITO_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_convent_exito.*,LD_convent_exito.rowid
		FROM LD_convent_exito
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_convent_exito is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_convent_exito;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_convent_exito default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CONVENT_EXITO_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		orcLD_convent_exito  out styLD_convent_exito
	)
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;

		Open cuLockRcByPk
		(
			inuCONVENT_EXITO_Id
		);

		fetch cuLockRcByPk into orcLD_convent_exito;
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
		orcLD_convent_exito  out styLD_convent_exito
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_convent_exito;
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
		itbLD_convent_exito  in out nocopy tytbLD_convent_exito
	)
	IS
	BEGIN
			rcRecOfTab.Convent_Exito_Id.delete;
			rcRecOfTab.Order_Id.delete;
			rcRecOfTab.Bar_Code.delete;
			rcRecOfTab.Printed_Number.delete;
			rcRecOfTab.Generate_File.delete;
			rcRecOfTab.Printed_Bar_Code.delete;
			rcRecOfTab.Create_Date.delete;
			rcRecOfTab.User_Name.delete;
			rcRecOfTab.Terminal.delete;
			rcRecOfTab.Program.delete;
			rcRecOfTab.Status.delete;
			rcRecOfTab.Operating_Unit_Id.delete;
			rcRecOfTab.Susccodi.delete;
			rcRecOfTab.Legalization_Date.delete;
			rcRecOfTab.File_Name.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_convent_exito  in out nocopy tytbLD_convent_exito,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_convent_exito);
		for n in itbLD_convent_exito.first .. itbLD_convent_exito.last loop
			rcRecOfTab.Convent_Exito_Id(n) := itbLD_convent_exito(n).Convent_Exito_Id;
			rcRecOfTab.Order_Id(n) := itbLD_convent_exito(n).Order_Id;
			rcRecOfTab.Bar_Code(n) := itbLD_convent_exito(n).Bar_Code;
			rcRecOfTab.Printed_Number(n) := itbLD_convent_exito(n).Printed_Number;
			rcRecOfTab.Generate_File(n) := itbLD_convent_exito(n).Generate_File;
			rcRecOfTab.Printed_Bar_Code(n) := itbLD_convent_exito(n).Printed_Bar_Code;
			rcRecOfTab.Create_Date(n) := itbLD_convent_exito(n).Create_Date;
			rcRecOfTab.User_Name(n) := itbLD_convent_exito(n).User_Name;
			rcRecOfTab.Terminal(n) := itbLD_convent_exito(n).Terminal;
			rcRecOfTab.Program(n) := itbLD_convent_exito(n).Program;
			rcRecOfTab.Status(n) := itbLD_convent_exito(n).Status;
			rcRecOfTab.Operating_Unit_Id(n) := itbLD_convent_exito(n).Operating_Unit_Id;
			rcRecOfTab.Susccodi(n) := itbLD_convent_exito(n).Susccodi;
			rcRecOfTab.Legalization_Date(n) := itbLD_convent_exito(n).Legalization_Date;
			rcRecOfTab.File_Name(n) := itbLD_convent_exito(n).File_Name;
			rcRecOfTab.row_id(n) := itbLD_convent_exito(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCONVENT_EXITO_Id
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
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCONVENT_EXITO_Id = rcData.CONVENT_EXITO_Id
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
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCONVENT_EXITO_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type
	)
	IS
		rcError styLD_convent_exito;
	BEGIN		rcError.CONVENT_EXITO_Id:=inuCONVENT_EXITO_Id;

		Load
		(
			inuCONVENT_EXITO_Id
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
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuCONVENT_EXITO_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		orcRecord out nocopy styLD_convent_exito
	)
	IS
		rcError styLD_convent_exito;
	BEGIN		rcError.CONVENT_EXITO_Id:=inuCONVENT_EXITO_Id;

		Load
		(
			inuCONVENT_EXITO_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type
	)
	RETURN styLD_convent_exito
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id:=inuCONVENT_EXITO_Id;

		Load
		(
			inuCONVENT_EXITO_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type
	)
	RETURN styLD_convent_exito
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id:=inuCONVENT_EXITO_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONVENT_EXITO_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCONVENT_EXITO_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_convent_exito
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_convent_exito
	)
	IS
		rfLD_convent_exito tyrfLD_convent_exito;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT
		            LD_convent_exito.Convent_Exito_Id,
		            LD_convent_exito.Order_Id,
		            LD_convent_exito.Bar_Code,
		            LD_convent_exito.Printed_Number,
		            LD_convent_exito.Generate_File,
		            LD_convent_exito.Printed_Bar_Code,
		            LD_convent_exito.Create_Date,
		            LD_convent_exito.User_Name,
		            LD_convent_exito.Terminal,
		            LD_convent_exito.Program,
		            LD_convent_exito.Status,
		            LD_convent_exito.Operating_Unit_Id,
		            LD_convent_exito.Susccodi,
		            LD_convent_exito.Legalization_Date,
		            LD_convent_exito.File_Name,
		            LD_convent_exito.rowid
                FROM LD_convent_exito';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_convent_exito for sbFullQuery;
		fetch rfLD_convent_exito bulk collect INTO otbResult;
		close rfLD_convent_exito;
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
		            LD_convent_exito.Convent_Exito_Id,
		            LD_convent_exito.Order_Id,
		            LD_convent_exito.Bar_Code,
		            LD_convent_exito.Printed_Number,
		            LD_convent_exito.Generate_File,
		            LD_convent_exito.Printed_Bar_Code,
		            LD_convent_exito.Create_Date,
		            LD_convent_exito.User_Name,
		            LD_convent_exito.Terminal,
		            LD_convent_exito.Program,
		            LD_convent_exito.Status,
		            LD_convent_exito.Operating_Unit_Id,
		            LD_convent_exito.Susccodi,
		            LD_convent_exito.Legalization_Date,
		            LD_convent_exito.File_Name,
		            LD_convent_exito.rowid
                FROM LD_convent_exito';
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
		ircLD_convent_exito in styLD_convent_exito
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_convent_exito,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_convent_exito in styLD_convent_exito,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_convent_exito.CONVENT_EXITO_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONVENT_EXITO_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_convent_exito
		(
			Convent_Exito_Id,
			Order_Id,
			Bar_Code,
			Printed_Number,
			Generate_File,
			Printed_Bar_Code,
			Create_Date,
			User_Name,
			Terminal,
			Program,
			Status,
			Operating_Unit_Id,
			Susccodi,
			Legalization_Date,
			File_Name
		)
		values
		(
			ircLD_convent_exito.Convent_Exito_Id,
			ircLD_convent_exito.Order_Id,
			ircLD_convent_exito.Bar_Code,
			ircLD_convent_exito.Printed_Number,
			ircLD_convent_exito.Generate_File,
			ircLD_convent_exito.Printed_Bar_Code,
			ircLD_convent_exito.Create_Date,
			ircLD_convent_exito.User_Name,
			ircLD_convent_exito.Terminal,
			ircLD_convent_exito.Program,
			ircLD_convent_exito.Status,
			ircLD_convent_exito.Operating_Unit_Id,
			ircLD_convent_exito.Susccodi,
			ircLD_convent_exito.Legalization_Date,
			ircLD_convent_exito.File_Name
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_convent_exito));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_convent_exito in out nocopy tytbLD_convent_exito
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_convent_exito, blUseRowID);
		forall n in iotbLD_convent_exito.first..iotbLD_convent_exito.last
			insert into LD_convent_exito
			(
			Convent_Exito_Id,
			Order_Id,
			Bar_Code,
			Printed_Number,
			Generate_File,
			Printed_Bar_Code,
			Create_Date,
			User_Name,
			Terminal,
			Program,
			Status,
			Operating_Unit_Id,
			Susccodi,
			Legalization_Date,
			File_Name
		)
		values
		(
			rcRecOfTab.Convent_Exito_Id(n),
			rcRecOfTab.Order_Id(n),
			rcRecOfTab.Bar_Code(n),
			rcRecOfTab.Printed_Number(n),
			rcRecOfTab.Generate_File(n),
			rcRecOfTab.Printed_Bar_Code(n),
			rcRecOfTab.Create_Date(n),
			rcRecOfTab.User_Name(n),
			rcRecOfTab.Terminal(n),
			rcRecOfTab.Program(n),
			rcRecOfTab.Status(n),
			rcRecOfTab.Operating_Unit_Id(n),
			rcRecOfTab.Susccodi(n),
			rcRecOfTab.Legalization_Date(n),
			rcRecOfTab.File_Name(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id:=inuCONVENT_EXITO_Id;

		if inuLock=1 then
			LockByPk
			(
				inuCONVENT_EXITO_Id,
				rcData
			);
		end if;

		delete
		from LD_convent_exito
		where
       		CONVENT_EXITO_Id=inuCONVENT_EXITO_Id;
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
		rcError  styLD_convent_exito;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_convent_exito
		where
			rowid = iriRowID
		returning
   CONVENT_EXITO_Id
		into
			rcError.CONVENT_EXITO_Id;

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
		iotbLD_convent_exito in out nocopy tytbLD_convent_exito,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_convent_exito;
	BEGIN
		FillRecordOfTables(iotbLD_convent_exito, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_convent_exito.first .. iotbLD_convent_exito.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_convent_exito.first .. iotbLD_convent_exito.last
				delete
				from LD_convent_exito
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_convent_exito.first .. iotbLD_convent_exito.last loop
					LockByPk
					(
							rcRecOfTab.CONVENT_EXITO_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_convent_exito.first .. iotbLD_convent_exito.last
				delete
				from LD_convent_exito
				where
		         	CONVENT_EXITO_Id = rcRecOfTab.CONVENT_EXITO_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_convent_exito in styLD_convent_exito,
		inuLock	  in number default 0
	)
	IS
		nuCONVENT_EXITO_Id LD_convent_exito.CONVENT_EXITO_Id%type;

	BEGIN
		if ircLD_convent_exito.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_convent_exito.rowid,rcData);
			end if;
			update LD_convent_exito
			set

        Order_Id = ircLD_convent_exito.Order_Id,
        Bar_Code = ircLD_convent_exito.Bar_Code,
        Printed_Number = ircLD_convent_exito.Printed_Number,
        Generate_File = ircLD_convent_exito.Generate_File,
        Printed_Bar_Code = ircLD_convent_exito.Printed_Bar_Code,
        Create_Date = ircLD_convent_exito.Create_Date,
        User_Name = ircLD_convent_exito.User_Name,
        Terminal = ircLD_convent_exito.Terminal,
        Program = ircLD_convent_exito.Program,
        Status = ircLD_convent_exito.Status,
        Operating_Unit_Id = ircLD_convent_exito.Operating_Unit_Id,
        Susccodi = ircLD_convent_exito.Susccodi,
        Legalization_Date = ircLD_convent_exito.Legalization_Date,
        File_Name = ircLD_convent_exito.File_Name
			where
				rowid = ircLD_convent_exito.rowid
			returning
    CONVENT_EXITO_Id
			into
				nuCONVENT_EXITO_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_convent_exito.CONVENT_EXITO_Id,
					rcData
				);
			end if;

			update LD_convent_exito
			set
        Order_Id = ircLD_convent_exito.Order_Id,
        Bar_Code = ircLD_convent_exito.Bar_Code,
        Printed_Number = ircLD_convent_exito.Printed_Number,
        Generate_File = ircLD_convent_exito.Generate_File,
        Printed_Bar_Code = ircLD_convent_exito.Printed_Bar_Code,
        Create_Date = ircLD_convent_exito.Create_Date,
        User_Name = ircLD_convent_exito.User_Name,
        Terminal = ircLD_convent_exito.Terminal,
        Program = ircLD_convent_exito.Program,
        Status = ircLD_convent_exito.Status,
        Operating_Unit_Id = ircLD_convent_exito.Operating_Unit_Id,
        Susccodi = ircLD_convent_exito.Susccodi,
        Legalization_Date = ircLD_convent_exito.Legalization_Date,
        File_Name = ircLD_convent_exito.File_Name
			where
	         	CONVENT_EXITO_Id = ircLD_convent_exito.CONVENT_EXITO_Id
			returning
    CONVENT_EXITO_Id
			into
				nuCONVENT_EXITO_Id;
		end if;

		if
			nuCONVENT_EXITO_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_convent_exito));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_convent_exito in out nocopy tytbLD_convent_exito,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_convent_exito;
  BEGIN
    FillRecordOfTables(iotbLD_convent_exito,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_convent_exito.first .. iotbLD_convent_exito.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_convent_exito.first .. iotbLD_convent_exito.last
        update LD_convent_exito
        set

            Order_Id = rcRecOfTab.Order_Id(n),
            Bar_Code = rcRecOfTab.Bar_Code(n),
            Printed_Number = rcRecOfTab.Printed_Number(n),
            Generate_File = rcRecOfTab.Generate_File(n),
            Printed_Bar_Code = rcRecOfTab.Printed_Bar_Code(n),
            Create_Date = rcRecOfTab.Create_Date(n),
            User_Name = rcRecOfTab.User_Name(n),
            Terminal = rcRecOfTab.Terminal(n),
            Program = rcRecOfTab.Program(n),
            Status = rcRecOfTab.Status(n),
            Operating_Unit_Id = rcRecOfTab.Operating_Unit_Id(n),
            Susccodi = rcRecOfTab.Susccodi(n),
            Legalization_Date = rcRecOfTab.Legalization_Date(n),
            File_Name = rcRecOfTab.File_Name(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_convent_exito.first .. iotbLD_convent_exito.last loop
          LockByPk
          (
              rcRecOfTab.CONVENT_EXITO_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_convent_exito.first .. iotbLD_convent_exito.last
        update LD_convent_exito
        set
					Order_Id = rcRecOfTab.Order_Id(n),
					Bar_Code = rcRecOfTab.Bar_Code(n),
					Printed_Number = rcRecOfTab.Printed_Number(n),
					Generate_File = rcRecOfTab.Generate_File(n),
					Printed_Bar_Code = rcRecOfTab.Printed_Bar_Code(n),
					Create_Date = rcRecOfTab.Create_Date(n),
					User_Name = rcRecOfTab.User_Name(n),
					Terminal = rcRecOfTab.Terminal(n),
					Program = rcRecOfTab.Program(n),
					Status = rcRecOfTab.Status(n),
					Operating_Unit_Id = rcRecOfTab.Operating_Unit_Id(n),
					Susccodi = rcRecOfTab.Susccodi(n),
					Legalization_Date = rcRecOfTab.Legalization_Date(n),
					File_Name = rcRecOfTab.File_Name(n)
          where
          CONVENT_EXITO_Id = rcRecOfTab.CONVENT_EXITO_Id(n)
;
    end if;
  END;

	PROCEDURE updOrder_Id
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuOrder_Id$ in LD_convent_exito.Order_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONVENT_EXITO_Id,
				rcData
			);
		end if;

		update LD_convent_exito
		set
			Order_Id = inuOrder_Id$
		where
			CONVENT_EXITO_Id = inuCONVENT_EXITO_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Order_Id:= inuOrder_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updBar_Code
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuBar_Code$ in LD_convent_exito.Bar_Code%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONVENT_EXITO_Id,
				rcData
			);
		end if;

		update LD_convent_exito
		set
			Bar_Code = inuBar_Code$
		where
			CONVENT_EXITO_Id = inuCONVENT_EXITO_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Bar_Code:= inuBar_Code$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPrinted_Number
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuPrinted_Number$ in LD_convent_exito.Printed_Number%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONVENT_EXITO_Id,
				rcData
			);
		end if;

		update LD_convent_exito
		set
			Printed_Number = inuPrinted_Number$
		where
			CONVENT_EXITO_Id = inuCONVENT_EXITO_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Printed_Number:= inuPrinted_Number$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updGenerate_File
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		isbGenerate_File$ in LD_convent_exito.Generate_File%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONVENT_EXITO_Id,
				rcData
			);
		end if;

		update LD_convent_exito
		set
			Generate_File = isbGenerate_File$
		where
			CONVENT_EXITO_Id = inuCONVENT_EXITO_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Generate_File:= isbGenerate_File$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPrinted_Bar_Code
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		isbPrinted_Bar_Code$ in LD_convent_exito.Printed_Bar_Code%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONVENT_EXITO_Id,
				rcData
			);
		end if;

		update LD_convent_exito
		set
			Printed_Bar_Code = isbPrinted_Bar_Code$
		where
			CONVENT_EXITO_Id = inuCONVENT_EXITO_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Printed_Bar_Code:= isbPrinted_Bar_Code$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCreate_Date
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		idtCreate_Date$ in LD_convent_exito.Create_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONVENT_EXITO_Id,
				rcData
			);
		end if;

		update LD_convent_exito
		set
			Create_Date = idtCreate_Date$
		where
			CONVENT_EXITO_Id = inuCONVENT_EXITO_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Create_Date:= idtCreate_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updUser_Name
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		isbUser_Name$ in LD_convent_exito.User_Name%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONVENT_EXITO_Id,
				rcData
			);
		end if;

		update LD_convent_exito
		set
			User_Name = isbUser_Name$
		where
			CONVENT_EXITO_Id = inuCONVENT_EXITO_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.User_Name:= isbUser_Name$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updTerminal
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		isbTerminal$ in LD_convent_exito.Terminal%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONVENT_EXITO_Id,
				rcData
			);
		end if;

		update LD_convent_exito
		set
			Terminal = isbTerminal$
		where
			CONVENT_EXITO_Id = inuCONVENT_EXITO_Id;

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
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		isbProgram$ in LD_convent_exito.Program%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONVENT_EXITO_Id,
				rcData
			);
		end if;

		update LD_convent_exito
		set
			Program = isbProgram$
		where
			CONVENT_EXITO_Id = inuCONVENT_EXITO_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Program:= isbProgram$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updStatus
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		isbStatus$ in LD_convent_exito.Status%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONVENT_EXITO_Id,
				rcData
			);
		end if;

		update LD_convent_exito
		set
			Status = isbStatus$
		where
			CONVENT_EXITO_Id = inuCONVENT_EXITO_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Status:= isbStatus$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updOperating_Unit_Id
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuOperating_Unit_Id$ in LD_convent_exito.Operating_Unit_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONVENT_EXITO_Id,
				rcData
			);
		end if;

		update LD_convent_exito
		set
			Operating_Unit_Id = inuOperating_Unit_Id$
		where
			CONVENT_EXITO_Id = inuCONVENT_EXITO_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Operating_Unit_Id:= inuOperating_Unit_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSusccodi
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuSusccodi$ in LD_convent_exito.Susccodi%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONVENT_EXITO_Id,
				rcData
			);
		end if;

		update LD_convent_exito
		set
			Susccodi = inuSusccodi$
		where
			CONVENT_EXITO_Id = inuCONVENT_EXITO_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Susccodi:= inuSusccodi$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updLegalization_Date
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		idtLegalization_Date$ in LD_convent_exito.Legalization_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONVENT_EXITO_Id,
				rcData
			);
		end if;

		update LD_convent_exito
		set
			Legalization_Date = idtLegalization_Date$
		where
			CONVENT_EXITO_Id = inuCONVENT_EXITO_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Legalization_Date:= idtLegalization_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updFile_Name
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		isbFile_Name$ in LD_convent_exito.File_Name%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_convent_exito;
	BEGIN
		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;
		if inuLock=1 then
			LockByPk
			(
				inuCONVENT_EXITO_Id,
				rcData
			);
		end if;

		update LD_convent_exito
		set
			File_Name = isbFile_Name$
		where
			CONVENT_EXITO_Id = inuCONVENT_EXITO_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.File_Name:= isbFile_Name$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetConvent_Exito_Id
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_convent_exito.Convent_Exito_Id%type
	IS
		rcError styLD_convent_exito;
	BEGIN

		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONVENT_EXITO_Id
			 )
		then
			 return(rcData.Convent_Exito_Id);
		end if;
		Load
		(
			inuCONVENT_EXITO_Id
		);
		return(rcData.Convent_Exito_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetOrder_Id
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_convent_exito.Order_Id%type
	IS
		rcError styLD_convent_exito;
	BEGIN

		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONVENT_EXITO_Id
			 )
		then
			 return(rcData.Order_Id);
		end if;
		Load
		(
			inuCONVENT_EXITO_Id
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

	FUNCTION fnuGetBar_Code
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_convent_exito.Bar_Code%type
	IS
		rcError styLD_convent_exito;
	BEGIN

		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONVENT_EXITO_Id
			 )
		then
			 return(rcData.Bar_Code);
		end if;
		Load
		(
			inuCONVENT_EXITO_Id
		);
		return(rcData.Bar_Code);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPrinted_Number
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_convent_exito.Printed_Number%type
	IS
		rcError styLD_convent_exito;
	BEGIN

		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONVENT_EXITO_Id
			 )
		then
			 return(rcData.Printed_Number);
		end if;
		Load
		(
			inuCONVENT_EXITO_Id
		);
		return(rcData.Printed_Number);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetGenerate_File
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_convent_exito.Generate_File%type
	IS
		rcError styLD_convent_exito;
	BEGIN

		rcError.CONVENT_EXITO_Id:=inuCONVENT_EXITO_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONVENT_EXITO_Id
			 )
		then
			 return(rcData.Generate_File);
		end if;
		Load
		(
			inuCONVENT_EXITO_Id
		);
		return(rcData.Generate_File);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetPrinted_Bar_Code
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_convent_exito.Printed_Bar_Code%type
	IS
		rcError styLD_convent_exito;
	BEGIN

		rcError.CONVENT_EXITO_Id:=inuCONVENT_EXITO_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONVENT_EXITO_Id
			 )
		then
			 return(rcData.Printed_Bar_Code);
		end if;
		Load
		(
			inuCONVENT_EXITO_Id
		);
		return(rcData.Printed_Bar_Code);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetCreate_Date
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_convent_exito.Create_Date%type
	IS
		rcError styLD_convent_exito;
	BEGIN

		rcError.CONVENT_EXITO_Id:=inuCONVENT_EXITO_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONVENT_EXITO_Id
			 )
		then
			 return(rcData.Create_Date);
		end if;
		Load
		(
		 		inuCONVENT_EXITO_Id
		);
		return(rcData.Create_Date);
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
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_convent_exito.User_Name%type
	IS
		rcError styLD_convent_exito;
	BEGIN

		rcError.CONVENT_EXITO_Id:=inuCONVENT_EXITO_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONVENT_EXITO_Id
			 )
		then
			 return(rcData.User_Name);
		end if;
		Load
		(
			inuCONVENT_EXITO_Id
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

	FUNCTION fsbGetTerminal
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_convent_exito.Terminal%type
	IS
		rcError styLD_convent_exito;
	BEGIN

		rcError.CONVENT_EXITO_Id:=inuCONVENT_EXITO_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONVENT_EXITO_Id
			 )
		then
			 return(rcData.Terminal);
		end if;
		Load
		(
			inuCONVENT_EXITO_Id
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
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_convent_exito.Program%type
	IS
		rcError styLD_convent_exito;
	BEGIN

		rcError.CONVENT_EXITO_Id:=inuCONVENT_EXITO_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONVENT_EXITO_Id
			 )
		then
			 return(rcData.Program);
		end if;
		Load
		(
			inuCONVENT_EXITO_Id
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

	FUNCTION fsbGetStatus
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_convent_exito.Status%type
	IS
		rcError styLD_convent_exito;
	BEGIN

		rcError.CONVENT_EXITO_Id:=inuCONVENT_EXITO_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONVENT_EXITO_Id
			 )
		then
			 return(rcData.Status);
		end if;
		Load
		(
			inuCONVENT_EXITO_Id
		);
		return(rcData.Status);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetOperating_Unit_Id
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_convent_exito.Operating_Unit_Id%type
	IS
		rcError styLD_convent_exito;
	BEGIN

		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONVENT_EXITO_Id
			 )
		then
			 return(rcData.Operating_Unit_Id);
		end if;
		Load
		(
			inuCONVENT_EXITO_Id
		);
		return(rcData.Operating_Unit_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSusccodi
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_convent_exito.Susccodi%type
	IS
		rcError styLD_convent_exito;
	BEGIN

		rcError.CONVENT_EXITO_Id := inuCONVENT_EXITO_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONVENT_EXITO_Id
			 )
		then
			 return(rcData.Susccodi);
		end if;
		Load
		(
			inuCONVENT_EXITO_Id
		);
		return(rcData.Susccodi);
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
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_convent_exito.Legalization_Date%type
	IS
		rcError styLD_convent_exito;
	BEGIN

		rcError.CONVENT_EXITO_Id:=inuCONVENT_EXITO_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONVENT_EXITO_Id
			 )
		then
			 return(rcData.Legalization_Date);
		end if;
		Load
		(
		 		inuCONVENT_EXITO_Id
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

	FUNCTION fsbGetFile_Name
	(
		inuCONVENT_EXITO_Id in LD_convent_exito.CONVENT_EXITO_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_convent_exito.File_Name%type
	IS
		rcError styLD_convent_exito;
	BEGIN

		rcError.CONVENT_EXITO_Id:=inuCONVENT_EXITO_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuCONVENT_EXITO_Id
			 )
		then
			 return(rcData.File_Name);
		end if;
		Load
		(
			inuCONVENT_EXITO_Id
		);
		return(rcData.File_Name);
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
end DALD_convent_exito;
/
PROMPT Otorgando permisos de ejecucion a DALD_CONVENT_EXITO
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_CONVENT_EXITO', 'ADM_PERSON');
END;
/