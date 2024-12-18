CREATE OR REPLACE PACKAGE adm_person.DALD_POLICY
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
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type
	)
	IS
		SELECT LD_POLICY.*,LD_POLICY.rowid
		FROM LD_POLICY
		WHERE
		    POLICY_ID = inuPOLICY_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_POLICY.*,LD_POLICY.rowid
		FROM LD_POLICY
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_POLICY  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_POLICY is table of styLD_POLICY index by binary_integer;
	type tyrfRecords is ref cursor return styLD_POLICY;

	/* Tipos referenciando al registro */
	type tytbBASE_VALUE is table of LD_POLICY.BASE_VALUE%type index by binary_integer;
	type tytbPORC_BASE_VAL is table of LD_POLICY.PORC_BASE_VAL%type index by binary_integer;
	type tytbSALE_CHANEL_ID is table of LD_POLICY.SALE_CHANEL_ID%type index by binary_integer;
	type tytbOPERATING_UNIT_ID is table of LD_POLICY.OPERATING_UNIT_ID%type index by binary_integer;
	type tytbDESCRIPTION_POLICY is table of LD_POLICY.DESCRIPTION_POLICY%type index by binary_integer;
	type tytbPOLICY_ID is table of LD_POLICY.POLICY_ID%type index by binary_integer;
	type tytbSTATE_POLICY is table of LD_POLICY.STATE_POLICY%type index by binary_integer;
	type tytbLAUNCH_POLICY is table of LD_POLICY.LAUNCH_POLICY%type index by binary_integer;
	type tytbCONTRATIST_CODE is table of LD_POLICY.CONTRATIST_CODE%type index by binary_integer;
	type tytbPRODUCT_LINE_ID is table of LD_POLICY.PRODUCT_LINE_ID%type index by binary_integer;
	type tytbDT_IN_POLICY is table of LD_POLICY.DT_IN_POLICY%type index by binary_integer;
	type tytbDT_EN_POLICY is table of LD_POLICY.DT_EN_POLICY%type index by binary_integer;
	type tytbVALUE_POLICY is table of LD_POLICY.VALUE_POLICY%type index by binary_integer;
	type tytbPREM_POLICY is table of LD_POLICY.PREM_POLICY%type index by binary_integer;
	type tytbNAME_INSURED is table of LD_POLICY.NAME_INSURED%type index by binary_integer;
	type tytbSUSCRIPTION_ID is table of LD_POLICY.SUSCRIPTION_ID%type index by binary_integer;
	type tytbPRODUCT_ID is table of LD_POLICY.PRODUCT_ID%type index by binary_integer;
	type tytbIDENTIFICATION_ID is table of LD_POLICY.IDENTIFICATION_ID%type index by binary_integer;
	type tytbPERIOD_POLICY is table of LD_POLICY.PERIOD_POLICY%type index by binary_integer;
	type tytbYEAR_POLICY is table of LD_POLICY.YEAR_POLICY%type index by binary_integer;
	type tytbMONTH_POLICY is table of LD_POLICY.MONTH_POLICY%type index by binary_integer;
	type tytbDEFERRED_POLICY_ID is table of LD_POLICY.DEFERRED_POLICY_ID%type index by binary_integer;
	type tytbDTCREATE_POLICY is table of LD_POLICY.DTCREATE_POLICY%type index by binary_integer;
	type tytbSHARE_POLICY is table of LD_POLICY.SHARE_POLICY%type index by binary_integer;
	type tytbDTRET_POLICY is table of LD_POLICY.DTRET_POLICY%type index by binary_integer;
	type tytbVALUEACR_POLICY is table of LD_POLICY.VALUEACR_POLICY%type index by binary_integer;
	type tytbREPORT_POLICY is table of LD_POLICY.REPORT_POLICY%type index by binary_integer;
	type tytbDT_REPORT_POLICY is table of LD_POLICY.DT_REPORT_POLICY%type index by binary_integer;
	type tytbDT_INSURED_POLICY is table of LD_POLICY.DT_INSURED_POLICY%type index by binary_integer;
	type tytbPER_REPORT_POLICY is table of LD_POLICY.PER_REPORT_POLICY%type index by binary_integer;
	type tytbPOLICY_TYPE_ID is table of LD_POLICY.POLICY_TYPE_ID%type index by binary_integer;
	type tytbID_REPORT_POLICY is table of LD_POLICY.ID_REPORT_POLICY%type index by binary_integer;
	type tytbCANCEL_CAUSAL_ID is table of LD_POLICY.CANCEL_CAUSAL_ID%type index by binary_integer;
	type tytbFEES_TO_RETURN is table of LD_POLICY.FEES_TO_RETURN%type index by binary_integer;
	type tytbCOMMENTS is table of LD_POLICY.COMMENTS%type index by binary_integer;
	type tytbPOLICY_EXQ is table of LD_POLICY.POLICY_EXQ%type index by binary_integer;
	type tytbNUMBER_ACTA is table of LD_POLICY.NUMBER_ACTA%type index by binary_integer;
	type tytbGEOGRAP_LOCATION_ID is table of LD_POLICY.GEOGRAP_LOCATION_ID%type index by binary_integer;
	type tytbVALIDITY_POLICY_TYPE_ID is table of LD_POLICY.VALIDITY_POLICY_TYPE_ID%type index by binary_integer;
	type tytbPOLICY_NUMBER is table of LD_POLICY.POLICY_NUMBER%type index by binary_integer;
	type tytbCOLLECTIVE_NUMBER is table of LD_POLICY.COLLECTIVE_NUMBER%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_POLICY is record
	(
		BASE_VALUE   tytbBASE_VALUE,
		PORC_BASE_VAL   tytbPORC_BASE_VAL,
		SALE_CHANEL_ID   tytbSALE_CHANEL_ID,
		OPERATING_UNIT_ID   tytbOPERATING_UNIT_ID,
		DESCRIPTION_POLICY   tytbDESCRIPTION_POLICY,
		POLICY_ID   tytbPOLICY_ID,
		STATE_POLICY   tytbSTATE_POLICY,
		LAUNCH_POLICY   tytbLAUNCH_POLICY,
		CONTRATIST_CODE   tytbCONTRATIST_CODE,
		PRODUCT_LINE_ID   tytbPRODUCT_LINE_ID,
		DT_IN_POLICY   tytbDT_IN_POLICY,
		DT_EN_POLICY   tytbDT_EN_POLICY,
		VALUE_POLICY   tytbVALUE_POLICY,
		PREM_POLICY   tytbPREM_POLICY,
		NAME_INSURED   tytbNAME_INSURED,
		SUSCRIPTION_ID   tytbSUSCRIPTION_ID,
		PRODUCT_ID   tytbPRODUCT_ID,
		IDENTIFICATION_ID   tytbIDENTIFICATION_ID,
		PERIOD_POLICY   tytbPERIOD_POLICY,
		YEAR_POLICY   tytbYEAR_POLICY,
		MONTH_POLICY   tytbMONTH_POLICY,
		DEFERRED_POLICY_ID   tytbDEFERRED_POLICY_ID,
		DTCREATE_POLICY   tytbDTCREATE_POLICY,
		SHARE_POLICY   tytbSHARE_POLICY,
		DTRET_POLICY   tytbDTRET_POLICY,
		VALUEACR_POLICY   tytbVALUEACR_POLICY,
		REPORT_POLICY   tytbREPORT_POLICY,
		DT_REPORT_POLICY   tytbDT_REPORT_POLICY,
		DT_INSURED_POLICY   tytbDT_INSURED_POLICY,
		PER_REPORT_POLICY   tytbPER_REPORT_POLICY,
		POLICY_TYPE_ID   tytbPOLICY_TYPE_ID,
		ID_REPORT_POLICY   tytbID_REPORT_POLICY,
		CANCEL_CAUSAL_ID   tytbCANCEL_CAUSAL_ID,
		FEES_TO_RETURN   tytbFEES_TO_RETURN,
		COMMENTS   tytbCOMMENTS,
		POLICY_EXQ   tytbPOLICY_EXQ,
		NUMBER_ACTA   tytbNUMBER_ACTA,
		GEOGRAP_LOCATION_ID   tytbGEOGRAP_LOCATION_ID,
		VALIDITY_POLICY_TYPE_ID   tytbVALIDITY_POLICY_TYPE_ID,
		POLICY_NUMBER   tytbPOLICY_NUMBER,
		COLLECTIVE_NUMBER   tytbCOLLECTIVE_NUMBER,
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
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type
	);

	PROCEDURE getRecord
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		orcRecord out nocopy styLD_POLICY
	);

	FUNCTION frcGetRcData
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type
	)
	RETURN styLD_POLICY;

	FUNCTION frcGetRcData
	RETURN styLD_POLICY;

	FUNCTION frcGetRecord
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type
	)
	RETURN styLD_POLICY;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_POLICY
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_POLICY in styLD_POLICY
	);

	PROCEDURE insRecord
	(
		ircLD_POLICY in styLD_POLICY,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_POLICY in out nocopy tytbLD_POLICY
	);

	PROCEDURE delRecord
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_POLICY in out nocopy tytbLD_POLICY,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_POLICY in styLD_POLICY,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_POLICY in out nocopy tytbLD_POLICY,
		inuLock in number default 1
	);

	PROCEDURE updBASE_VALUE
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuBASE_VALUE$ in LD_POLICY.BASE_VALUE%type,
		inuLock in number default 0
	);

	PROCEDURE updPORC_BASE_VAL
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuPORC_BASE_VAL$ in LD_POLICY.PORC_BASE_VAL%type,
		inuLock in number default 0
	);

	PROCEDURE updSALE_CHANEL_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuSALE_CHANEL_ID$ in LD_POLICY.SALE_CHANEL_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updOPERATING_UNIT_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuOPERATING_UNIT_ID$ in LD_POLICY.OPERATING_UNIT_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updDESCRIPTION_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		isbDESCRIPTION_POLICY$ in LD_POLICY.DESCRIPTION_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updSTATE_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuSTATE_POLICY$ in LD_POLICY.STATE_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updLAUNCH_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuLAUNCH_POLICY$ in LD_POLICY.LAUNCH_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updCONTRATIST_CODE
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuCONTRATIST_CODE$ in LD_POLICY.CONTRATIST_CODE%type,
		inuLock in number default 0
	);

	PROCEDURE updPRODUCT_LINE_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuPRODUCT_LINE_ID$ in LD_POLICY.PRODUCT_LINE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updDT_IN_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		idtDT_IN_POLICY$ in LD_POLICY.DT_IN_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updDT_EN_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		idtDT_EN_POLICY$ in LD_POLICY.DT_EN_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updVALUE_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuVALUE_POLICY$ in LD_POLICY.VALUE_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updPREM_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuPREM_POLICY$ in LD_POLICY.PREM_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updNAME_INSURED
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		isbNAME_INSURED$ in LD_POLICY.NAME_INSURED%type,
		inuLock in number default 0
	);

	PROCEDURE updSUSCRIPTION_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuSUSCRIPTION_ID$ in LD_POLICY.SUSCRIPTION_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPRODUCT_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuPRODUCT_ID$ in LD_POLICY.PRODUCT_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updIDENTIFICATION_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuIDENTIFICATION_ID$ in LD_POLICY.IDENTIFICATION_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPERIOD_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuPERIOD_POLICY$ in LD_POLICY.PERIOD_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updYEAR_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuYEAR_POLICY$ in LD_POLICY.YEAR_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updMONTH_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuMONTH_POLICY$ in LD_POLICY.MONTH_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updDEFERRED_POLICY_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuDEFERRED_POLICY_ID$ in LD_POLICY.DEFERRED_POLICY_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updDTCREATE_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		idtDTCREATE_POLICY$ in LD_POLICY.DTCREATE_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updSHARE_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuSHARE_POLICY$ in LD_POLICY.SHARE_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updDTRET_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		idtDTRET_POLICY$ in LD_POLICY.DTRET_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updVALUEACR_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuVALUEACR_POLICY$ in LD_POLICY.VALUEACR_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updREPORT_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		isbREPORT_POLICY$ in LD_POLICY.REPORT_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updDT_REPORT_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		idtDT_REPORT_POLICY$ in LD_POLICY.DT_REPORT_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updDT_INSURED_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		idtDT_INSURED_POLICY$ in LD_POLICY.DT_INSURED_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updPER_REPORT_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		isbPER_REPORT_POLICY$ in LD_POLICY.PER_REPORT_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updPOLICY_TYPE_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuPOLICY_TYPE_ID$ in LD_POLICY.POLICY_TYPE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updID_REPORT_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		isbID_REPORT_POLICY$ in LD_POLICY.ID_REPORT_POLICY%type,
		inuLock in number default 0
	);

	PROCEDURE updCANCEL_CAUSAL_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuCANCEL_CAUSAL_ID$ in LD_POLICY.CANCEL_CAUSAL_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updFEES_TO_RETURN
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuFEES_TO_RETURN$ in LD_POLICY.FEES_TO_RETURN%type,
		inuLock in number default 0
	);

	PROCEDURE updCOMMENTS
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		isbCOMMENTS$ in LD_POLICY.COMMENTS%type,
		inuLock in number default 0
	);

	PROCEDURE updPOLICY_EXQ
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		isbPOLICY_EXQ$ in LD_POLICY.POLICY_EXQ%type,
		inuLock in number default 0
	);

	PROCEDURE updNUMBER_ACTA
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuNUMBER_ACTA$ in LD_POLICY.NUMBER_ACTA%type,
		inuLock in number default 0
	);

	PROCEDURE updGEOGRAP_LOCATION_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuGEOGRAP_LOCATION_ID$ in LD_POLICY.GEOGRAP_LOCATION_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updVALIDITY_POLICY_TYPE_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuVALIDITY_POLICY_TYPE_ID$ in LD_POLICY.VALIDITY_POLICY_TYPE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPOLICY_NUMBER
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuPOLICY_NUMBER$ in LD_POLICY.POLICY_NUMBER%type,
		inuLock in number default 0
	);

	PROCEDURE updCOLLECTIVE_NUMBER
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuCOLLECTIVE_NUMBER$ in LD_POLICY.COLLECTIVE_NUMBER%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetBASE_VALUE
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.BASE_VALUE%type;

	FUNCTION fnuGetPORC_BASE_VAL
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.PORC_BASE_VAL%type;

	FUNCTION fnuGetSALE_CHANEL_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.SALE_CHANEL_ID%type;

	FUNCTION fnuGetOPERATING_UNIT_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.OPERATING_UNIT_ID%type;

	FUNCTION fsbGetDESCRIPTION_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.DESCRIPTION_POLICY%type;

	FUNCTION fnuGetPOLICY_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.POLICY_ID%type;

	FUNCTION fnuGetSTATE_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.STATE_POLICY%type;

	FUNCTION fnuGetLAUNCH_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.LAUNCH_POLICY%type;

	FUNCTION fnuGetCONTRATIST_CODE
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.CONTRATIST_CODE%type;

	FUNCTION fnuGetPRODUCT_LINE_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.PRODUCT_LINE_ID%type;

	FUNCTION fdtGetDT_IN_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.DT_IN_POLICY%type;

	FUNCTION fdtGetDT_EN_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.DT_EN_POLICY%type;

	FUNCTION fnuGetVALUE_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.VALUE_POLICY%type;

	FUNCTION fnuGetPREM_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.PREM_POLICY%type;

	FUNCTION fsbGetNAME_INSURED
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.NAME_INSURED%type;

	FUNCTION fnuGetSUSCRIPTION_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.SUSCRIPTION_ID%type;

	FUNCTION fnuGetPRODUCT_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.PRODUCT_ID%type;

	FUNCTION fnuGetIDENTIFICATION_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.IDENTIFICATION_ID%type;

	FUNCTION fnuGetPERIOD_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.PERIOD_POLICY%type;

	FUNCTION fnuGetYEAR_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.YEAR_POLICY%type;

	FUNCTION fnuGetMONTH_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.MONTH_POLICY%type;

	FUNCTION fnuGetDEFERRED_POLICY_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.DEFERRED_POLICY_ID%type;

	FUNCTION fdtGetDTCREATE_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.DTCREATE_POLICY%type;

	FUNCTION fnuGetSHARE_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.SHARE_POLICY%type;

	FUNCTION fdtGetDTRET_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.DTRET_POLICY%type;

	FUNCTION fnuGetVALUEACR_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.VALUEACR_POLICY%type;

	FUNCTION fsbGetREPORT_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.REPORT_POLICY%type;

	FUNCTION fdtGetDT_REPORT_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.DT_REPORT_POLICY%type;

	FUNCTION fdtGetDT_INSURED_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.DT_INSURED_POLICY%type;

	FUNCTION fsbGetPER_REPORT_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.PER_REPORT_POLICY%type;

	FUNCTION fnuGetPOLICY_TYPE_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.POLICY_TYPE_ID%type;

	FUNCTION fsbGetID_REPORT_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.ID_REPORT_POLICY%type;

	FUNCTION fnuGetCANCEL_CAUSAL_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.CANCEL_CAUSAL_ID%type;

	FUNCTION fnuGetFEES_TO_RETURN
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.FEES_TO_RETURN%type;

	FUNCTION fsbGetCOMMENTS
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.COMMENTS%type;

	FUNCTION fsbGetPOLICY_EXQ
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.POLICY_EXQ%type;

	FUNCTION fnuGetNUMBER_ACTA
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.NUMBER_ACTA%type;

	FUNCTION fnuGetGEOGRAP_LOCATION_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.GEOGRAP_LOCATION_ID%type;

	FUNCTION fnuGetVALIDITY_POLICY_TYPE_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.VALIDITY_POLICY_TYPE_ID%type;

	FUNCTION fnuGetPOLICY_NUMBER
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.POLICY_NUMBER%type;

	FUNCTION fnuGetCOLLECTIVE_NUMBER
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.COLLECTIVE_NUMBER%type;


	PROCEDURE LockByPk
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		orcLD_POLICY  out styLD_POLICY
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_POLICY  out styLD_POLICY
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_POLICY;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_POLICY
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_POLICY';
	 cnuGeEntityId constant varchar2(30) := 8003; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type
	)
	IS
		SELECT LD_POLICY.*,LD_POLICY.rowid
		FROM LD_POLICY
		WHERE  POLICY_ID = inuPOLICY_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_POLICY.*,LD_POLICY.rowid
		FROM LD_POLICY
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_POLICY is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_POLICY;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_POLICY default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.POLICY_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		orcLD_POLICY  out styLD_POLICY
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;

		Open cuLockRcByPk
		(
			inuPOLICY_ID
		);

		fetch cuLockRcByPk into orcLD_POLICY;
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
		orcLD_POLICY  out styLD_POLICY
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_POLICY;
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
		itbLD_POLICY  in out nocopy tytbLD_POLICY
	)
	IS
	BEGIN
			rcRecOfTab.BASE_VALUE.delete;
			rcRecOfTab.PORC_BASE_VAL.delete;
			rcRecOfTab.SALE_CHANEL_ID.delete;
			rcRecOfTab.OPERATING_UNIT_ID.delete;
			rcRecOfTab.DESCRIPTION_POLICY.delete;
			rcRecOfTab.POLICY_ID.delete;
			rcRecOfTab.STATE_POLICY.delete;
			rcRecOfTab.LAUNCH_POLICY.delete;
			rcRecOfTab.CONTRATIST_CODE.delete;
			rcRecOfTab.PRODUCT_LINE_ID.delete;
			rcRecOfTab.DT_IN_POLICY.delete;
			rcRecOfTab.DT_EN_POLICY.delete;
			rcRecOfTab.VALUE_POLICY.delete;
			rcRecOfTab.PREM_POLICY.delete;
			rcRecOfTab.NAME_INSURED.delete;
			rcRecOfTab.SUSCRIPTION_ID.delete;
			rcRecOfTab.PRODUCT_ID.delete;
			rcRecOfTab.IDENTIFICATION_ID.delete;
			rcRecOfTab.PERIOD_POLICY.delete;
			rcRecOfTab.YEAR_POLICY.delete;
			rcRecOfTab.MONTH_POLICY.delete;
			rcRecOfTab.DEFERRED_POLICY_ID.delete;
			rcRecOfTab.DTCREATE_POLICY.delete;
			rcRecOfTab.SHARE_POLICY.delete;
			rcRecOfTab.DTRET_POLICY.delete;
			rcRecOfTab.VALUEACR_POLICY.delete;
			rcRecOfTab.REPORT_POLICY.delete;
			rcRecOfTab.DT_REPORT_POLICY.delete;
			rcRecOfTab.DT_INSURED_POLICY.delete;
			rcRecOfTab.PER_REPORT_POLICY.delete;
			rcRecOfTab.POLICY_TYPE_ID.delete;
			rcRecOfTab.ID_REPORT_POLICY.delete;
			rcRecOfTab.CANCEL_CAUSAL_ID.delete;
			rcRecOfTab.FEES_TO_RETURN.delete;
			rcRecOfTab.COMMENTS.delete;
			rcRecOfTab.POLICY_EXQ.delete;
			rcRecOfTab.NUMBER_ACTA.delete;
			rcRecOfTab.GEOGRAP_LOCATION_ID.delete;
			rcRecOfTab.VALIDITY_POLICY_TYPE_ID.delete;
			rcRecOfTab.POLICY_NUMBER.delete;
			rcRecOfTab.COLLECTIVE_NUMBER.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_POLICY  in out nocopy tytbLD_POLICY,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_POLICY);

		for n in itbLD_POLICY.first .. itbLD_POLICY.last loop
			rcRecOfTab.BASE_VALUE(n) := itbLD_POLICY(n).BASE_VALUE;
			rcRecOfTab.PORC_BASE_VAL(n) := itbLD_POLICY(n).PORC_BASE_VAL;
			rcRecOfTab.SALE_CHANEL_ID(n) := itbLD_POLICY(n).SALE_CHANEL_ID;
			rcRecOfTab.OPERATING_UNIT_ID(n) := itbLD_POLICY(n).OPERATING_UNIT_ID;
			rcRecOfTab.DESCRIPTION_POLICY(n) := itbLD_POLICY(n).DESCRIPTION_POLICY;
			rcRecOfTab.POLICY_ID(n) := itbLD_POLICY(n).POLICY_ID;
			rcRecOfTab.STATE_POLICY(n) := itbLD_POLICY(n).STATE_POLICY;
			rcRecOfTab.LAUNCH_POLICY(n) := itbLD_POLICY(n).LAUNCH_POLICY;
			rcRecOfTab.CONTRATIST_CODE(n) := itbLD_POLICY(n).CONTRATIST_CODE;
			rcRecOfTab.PRODUCT_LINE_ID(n) := itbLD_POLICY(n).PRODUCT_LINE_ID;
			rcRecOfTab.DT_IN_POLICY(n) := itbLD_POLICY(n).DT_IN_POLICY;
			rcRecOfTab.DT_EN_POLICY(n) := itbLD_POLICY(n).DT_EN_POLICY;
			rcRecOfTab.VALUE_POLICY(n) := itbLD_POLICY(n).VALUE_POLICY;
			rcRecOfTab.PREM_POLICY(n) := itbLD_POLICY(n).PREM_POLICY;
			rcRecOfTab.NAME_INSURED(n) := itbLD_POLICY(n).NAME_INSURED;
			rcRecOfTab.SUSCRIPTION_ID(n) := itbLD_POLICY(n).SUSCRIPTION_ID;
			rcRecOfTab.PRODUCT_ID(n) := itbLD_POLICY(n).PRODUCT_ID;
			rcRecOfTab.IDENTIFICATION_ID(n) := itbLD_POLICY(n).IDENTIFICATION_ID;
			rcRecOfTab.PERIOD_POLICY(n) := itbLD_POLICY(n).PERIOD_POLICY;
			rcRecOfTab.YEAR_POLICY(n) := itbLD_POLICY(n).YEAR_POLICY;
			rcRecOfTab.MONTH_POLICY(n) := itbLD_POLICY(n).MONTH_POLICY;
			rcRecOfTab.DEFERRED_POLICY_ID(n) := itbLD_POLICY(n).DEFERRED_POLICY_ID;
			rcRecOfTab.DTCREATE_POLICY(n) := itbLD_POLICY(n).DTCREATE_POLICY;
			rcRecOfTab.SHARE_POLICY(n) := itbLD_POLICY(n).SHARE_POLICY;
			rcRecOfTab.DTRET_POLICY(n) := itbLD_POLICY(n).DTRET_POLICY;
			rcRecOfTab.VALUEACR_POLICY(n) := itbLD_POLICY(n).VALUEACR_POLICY;
			rcRecOfTab.REPORT_POLICY(n) := itbLD_POLICY(n).REPORT_POLICY;
			rcRecOfTab.DT_REPORT_POLICY(n) := itbLD_POLICY(n).DT_REPORT_POLICY;
			rcRecOfTab.DT_INSURED_POLICY(n) := itbLD_POLICY(n).DT_INSURED_POLICY;
			rcRecOfTab.PER_REPORT_POLICY(n) := itbLD_POLICY(n).PER_REPORT_POLICY;
			rcRecOfTab.POLICY_TYPE_ID(n) := itbLD_POLICY(n).POLICY_TYPE_ID;
			rcRecOfTab.ID_REPORT_POLICY(n) := itbLD_POLICY(n).ID_REPORT_POLICY;
			rcRecOfTab.CANCEL_CAUSAL_ID(n) := itbLD_POLICY(n).CANCEL_CAUSAL_ID;
			rcRecOfTab.FEES_TO_RETURN(n) := itbLD_POLICY(n).FEES_TO_RETURN;
			rcRecOfTab.COMMENTS(n) := itbLD_POLICY(n).COMMENTS;
			rcRecOfTab.POLICY_EXQ(n) := itbLD_POLICY(n).POLICY_EXQ;
			rcRecOfTab.NUMBER_ACTA(n) := itbLD_POLICY(n).NUMBER_ACTA;
			rcRecOfTab.GEOGRAP_LOCATION_ID(n) := itbLD_POLICY(n).GEOGRAP_LOCATION_ID;
			rcRecOfTab.VALIDITY_POLICY_TYPE_ID(n) := itbLD_POLICY(n).VALIDITY_POLICY_TYPE_ID;
			rcRecOfTab.POLICY_NUMBER(n) := itbLD_POLICY(n).POLICY_NUMBER;
			rcRecOfTab.COLLECTIVE_NUMBER(n) := itbLD_POLICY(n).COLLECTIVE_NUMBER;
			rcRecOfTab.row_id(n) := itbLD_POLICY(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPOLICY_ID
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
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPOLICY_ID = rcData.POLICY_ID
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
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPOLICY_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type
	)
	IS
		rcError styLD_POLICY;
	BEGIN		rcError.POLICY_ID:=inuPOLICY_ID;

		Load
		(
			inuPOLICY_ID
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
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuPOLICY_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		orcRecord out nocopy styLD_POLICY
	)
	IS
		rcError styLD_POLICY;
	BEGIN		rcError.POLICY_ID:=inuPOLICY_ID;

		Load
		(
			inuPOLICY_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type
	)
	RETURN styLD_POLICY
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID:=inuPOLICY_ID;

		Load
		(
			inuPOLICY_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type
	)
	RETURN styLD_POLICY
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID:=inuPOLICY_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuPOLICY_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPOLICY_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_POLICY
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_POLICY
	)
	IS
		rfLD_POLICY tyrfLD_POLICY;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_POLICY.*, LD_POLICY.rowid FROM LD_POLICY';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_POLICY for sbFullQuery;

		fetch rfLD_POLICY bulk collect INTO otbResult;

		close rfLD_POLICY;
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
		sbSQL VARCHAR2 (32000) := 'select LD_POLICY.*, LD_POLICY.rowid FROM LD_POLICY';
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
		ircLD_POLICY in styLD_POLICY
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_POLICY,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_POLICY in styLD_POLICY,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_POLICY.POLICY_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|POLICY_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_POLICY
		(
			BASE_VALUE,
			PORC_BASE_VAL,
			SALE_CHANEL_ID,
			OPERATING_UNIT_ID,
			DESCRIPTION_POLICY,
			POLICY_ID,
			STATE_POLICY,
			LAUNCH_POLICY,
			CONTRATIST_CODE,
			PRODUCT_LINE_ID,
			DT_IN_POLICY,
			DT_EN_POLICY,
			VALUE_POLICY,
			PREM_POLICY,
			NAME_INSURED,
			SUSCRIPTION_ID,
			PRODUCT_ID,
			IDENTIFICATION_ID,
			PERIOD_POLICY,
			YEAR_POLICY,
			MONTH_POLICY,
			DEFERRED_POLICY_ID,
			DTCREATE_POLICY,
			SHARE_POLICY,
			DTRET_POLICY,
			VALUEACR_POLICY,
			REPORT_POLICY,
			DT_REPORT_POLICY,
			DT_INSURED_POLICY,
			PER_REPORT_POLICY,
			POLICY_TYPE_ID,
			ID_REPORT_POLICY,
			CANCEL_CAUSAL_ID,
			FEES_TO_RETURN,
			COMMENTS,
			POLICY_EXQ,
			NUMBER_ACTA,
			GEOGRAP_LOCATION_ID,
			VALIDITY_POLICY_TYPE_ID,
			POLICY_NUMBER,
			COLLECTIVE_NUMBER
		)
		values
		(
			ircLD_POLICY.BASE_VALUE,
			ircLD_POLICY.PORC_BASE_VAL,
			ircLD_POLICY.SALE_CHANEL_ID,
			ircLD_POLICY.OPERATING_UNIT_ID,
			ircLD_POLICY.DESCRIPTION_POLICY,
			ircLD_POLICY.POLICY_ID,
			ircLD_POLICY.STATE_POLICY,
			ircLD_POLICY.LAUNCH_POLICY,
			ircLD_POLICY.CONTRATIST_CODE,
			ircLD_POLICY.PRODUCT_LINE_ID,
			ircLD_POLICY.DT_IN_POLICY,
			ircLD_POLICY.DT_EN_POLICY,
			ircLD_POLICY.VALUE_POLICY,
			ircLD_POLICY.PREM_POLICY,
			ircLD_POLICY.NAME_INSURED,
			ircLD_POLICY.SUSCRIPTION_ID,
			ircLD_POLICY.PRODUCT_ID,
			ircLD_POLICY.IDENTIFICATION_ID,
			ircLD_POLICY.PERIOD_POLICY,
			ircLD_POLICY.YEAR_POLICY,
			ircLD_POLICY.MONTH_POLICY,
			ircLD_POLICY.DEFERRED_POLICY_ID,
			ircLD_POLICY.DTCREATE_POLICY,
			ircLD_POLICY.SHARE_POLICY,
			ircLD_POLICY.DTRET_POLICY,
			ircLD_POLICY.VALUEACR_POLICY,
			ircLD_POLICY.REPORT_POLICY,
			ircLD_POLICY.DT_REPORT_POLICY,
			ircLD_POLICY.DT_INSURED_POLICY,
			ircLD_POLICY.PER_REPORT_POLICY,
			ircLD_POLICY.POLICY_TYPE_ID,
			ircLD_POLICY.ID_REPORT_POLICY,
			ircLD_POLICY.CANCEL_CAUSAL_ID,
			ircLD_POLICY.FEES_TO_RETURN,
			ircLD_POLICY.COMMENTS,
			ircLD_POLICY.POLICY_EXQ,
			ircLD_POLICY.NUMBER_ACTA,
			ircLD_POLICY.GEOGRAP_LOCATION_ID,
			ircLD_POLICY.VALIDITY_POLICY_TYPE_ID,
			ircLD_POLICY.POLICY_NUMBER,
			ircLD_POLICY.COLLECTIVE_NUMBER
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_POLICY));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_POLICY in out nocopy tytbLD_POLICY
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_POLICY,blUseRowID);
		forall n in iotbLD_POLICY.first..iotbLD_POLICY.last
			insert into LD_POLICY
			(
				BASE_VALUE,
				PORC_BASE_VAL,
				SALE_CHANEL_ID,
				OPERATING_UNIT_ID,
				DESCRIPTION_POLICY,
				POLICY_ID,
				STATE_POLICY,
				LAUNCH_POLICY,
				CONTRATIST_CODE,
				PRODUCT_LINE_ID,
				DT_IN_POLICY,
				DT_EN_POLICY,
				VALUE_POLICY,
				PREM_POLICY,
				NAME_INSURED,
				SUSCRIPTION_ID,
				PRODUCT_ID,
				IDENTIFICATION_ID,
				PERIOD_POLICY,
				YEAR_POLICY,
				MONTH_POLICY,
				DEFERRED_POLICY_ID,
				DTCREATE_POLICY,
				SHARE_POLICY,
				DTRET_POLICY,
				VALUEACR_POLICY,
				REPORT_POLICY,
				DT_REPORT_POLICY,
				DT_INSURED_POLICY,
				PER_REPORT_POLICY,
				POLICY_TYPE_ID,
				ID_REPORT_POLICY,
				CANCEL_CAUSAL_ID,
				FEES_TO_RETURN,
				COMMENTS,
				POLICY_EXQ,
				NUMBER_ACTA,
				GEOGRAP_LOCATION_ID,
				VALIDITY_POLICY_TYPE_ID,
				POLICY_NUMBER,
				COLLECTIVE_NUMBER
			)
			values
			(
				rcRecOfTab.BASE_VALUE(n),
				rcRecOfTab.PORC_BASE_VAL(n),
				rcRecOfTab.SALE_CHANEL_ID(n),
				rcRecOfTab.OPERATING_UNIT_ID(n),
				rcRecOfTab.DESCRIPTION_POLICY(n),
				rcRecOfTab.POLICY_ID(n),
				rcRecOfTab.STATE_POLICY(n),
				rcRecOfTab.LAUNCH_POLICY(n),
				rcRecOfTab.CONTRATIST_CODE(n),
				rcRecOfTab.PRODUCT_LINE_ID(n),
				rcRecOfTab.DT_IN_POLICY(n),
				rcRecOfTab.DT_EN_POLICY(n),
				rcRecOfTab.VALUE_POLICY(n),
				rcRecOfTab.PREM_POLICY(n),
				rcRecOfTab.NAME_INSURED(n),
				rcRecOfTab.SUSCRIPTION_ID(n),
				rcRecOfTab.PRODUCT_ID(n),
				rcRecOfTab.IDENTIFICATION_ID(n),
				rcRecOfTab.PERIOD_POLICY(n),
				rcRecOfTab.YEAR_POLICY(n),
				rcRecOfTab.MONTH_POLICY(n),
				rcRecOfTab.DEFERRED_POLICY_ID(n),
				rcRecOfTab.DTCREATE_POLICY(n),
				rcRecOfTab.SHARE_POLICY(n),
				rcRecOfTab.DTRET_POLICY(n),
				rcRecOfTab.VALUEACR_POLICY(n),
				rcRecOfTab.REPORT_POLICY(n),
				rcRecOfTab.DT_REPORT_POLICY(n),
				rcRecOfTab.DT_INSURED_POLICY(n),
				rcRecOfTab.PER_REPORT_POLICY(n),
				rcRecOfTab.POLICY_TYPE_ID(n),
				rcRecOfTab.ID_REPORT_POLICY(n),
				rcRecOfTab.CANCEL_CAUSAL_ID(n),
				rcRecOfTab.FEES_TO_RETURN(n),
				rcRecOfTab.COMMENTS(n),
				rcRecOfTab.POLICY_EXQ(n),
				rcRecOfTab.NUMBER_ACTA(n),
				rcRecOfTab.GEOGRAP_LOCATION_ID(n),
				rcRecOfTab.VALIDITY_POLICY_TYPE_ID(n),
				rcRecOfTab.POLICY_NUMBER(n),
				rcRecOfTab.COLLECTIVE_NUMBER(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;

		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;


		delete
		from LD_POLICY
		where
       		POLICY_ID=inuPOLICY_ID;
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
		iriRowID    in rowid,
		inuLock in number default 1
	)
	IS
		rcRecordNull cuRecord%rowtype;
		rcError  styLD_POLICY;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_POLICY
		where
			rowid = iriRowID
		returning
			BASE_VALUE
		into
			rcError.BASE_VALUE;
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
		iotbLD_POLICY in out nocopy tytbLD_POLICY,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_POLICY;
	BEGIN
		FillRecordOfTables(iotbLD_POLICY, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_POLICY.first .. iotbLD_POLICY.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_POLICY.first .. iotbLD_POLICY.last
				delete
				from LD_POLICY
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_POLICY.first .. iotbLD_POLICY.last loop
					LockByPk
					(
						rcRecOfTab.POLICY_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_POLICY.first .. iotbLD_POLICY.last
				delete
				from LD_POLICY
				where
		         	POLICY_ID = rcRecOfTab.POLICY_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_POLICY in styLD_POLICY,
		inuLock in number default 0
	)
	IS
		nuPOLICY_ID	LD_POLICY.POLICY_ID%type;
	BEGIN
		if ircLD_POLICY.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_POLICY.rowid,rcData);
			end if;
			update LD_POLICY
			set
				BASE_VALUE = ircLD_POLICY.BASE_VALUE,
				PORC_BASE_VAL = ircLD_POLICY.PORC_BASE_VAL,
				SALE_CHANEL_ID = ircLD_POLICY.SALE_CHANEL_ID,
				OPERATING_UNIT_ID = ircLD_POLICY.OPERATING_UNIT_ID,
				DESCRIPTION_POLICY = ircLD_POLICY.DESCRIPTION_POLICY,
				STATE_POLICY = ircLD_POLICY.STATE_POLICY,
				LAUNCH_POLICY = ircLD_POLICY.LAUNCH_POLICY,
				CONTRATIST_CODE = ircLD_POLICY.CONTRATIST_CODE,
				PRODUCT_LINE_ID = ircLD_POLICY.PRODUCT_LINE_ID,
				DT_IN_POLICY = ircLD_POLICY.DT_IN_POLICY,
				DT_EN_POLICY = ircLD_POLICY.DT_EN_POLICY,
				VALUE_POLICY = ircLD_POLICY.VALUE_POLICY,
				PREM_POLICY = ircLD_POLICY.PREM_POLICY,
				NAME_INSURED = ircLD_POLICY.NAME_INSURED,
				SUSCRIPTION_ID = ircLD_POLICY.SUSCRIPTION_ID,
				PRODUCT_ID = ircLD_POLICY.PRODUCT_ID,
				IDENTIFICATION_ID = ircLD_POLICY.IDENTIFICATION_ID,
				PERIOD_POLICY = ircLD_POLICY.PERIOD_POLICY,
				YEAR_POLICY = ircLD_POLICY.YEAR_POLICY,
				MONTH_POLICY = ircLD_POLICY.MONTH_POLICY,
				DEFERRED_POLICY_ID = ircLD_POLICY.DEFERRED_POLICY_ID,
				DTCREATE_POLICY = ircLD_POLICY.DTCREATE_POLICY,
				SHARE_POLICY = ircLD_POLICY.SHARE_POLICY,
				DTRET_POLICY = ircLD_POLICY.DTRET_POLICY,
				VALUEACR_POLICY = ircLD_POLICY.VALUEACR_POLICY,
				REPORT_POLICY = ircLD_POLICY.REPORT_POLICY,
				DT_REPORT_POLICY = ircLD_POLICY.DT_REPORT_POLICY,
				DT_INSURED_POLICY = ircLD_POLICY.DT_INSURED_POLICY,
				PER_REPORT_POLICY = ircLD_POLICY.PER_REPORT_POLICY,
				POLICY_TYPE_ID = ircLD_POLICY.POLICY_TYPE_ID,
				ID_REPORT_POLICY = ircLD_POLICY.ID_REPORT_POLICY,
				CANCEL_CAUSAL_ID = ircLD_POLICY.CANCEL_CAUSAL_ID,
				FEES_TO_RETURN = ircLD_POLICY.FEES_TO_RETURN,
				COMMENTS = ircLD_POLICY.COMMENTS,
				POLICY_EXQ = ircLD_POLICY.POLICY_EXQ,
				NUMBER_ACTA = ircLD_POLICY.NUMBER_ACTA,
				GEOGRAP_LOCATION_ID = ircLD_POLICY.GEOGRAP_LOCATION_ID,
				VALIDITY_POLICY_TYPE_ID = ircLD_POLICY.VALIDITY_POLICY_TYPE_ID,
				POLICY_NUMBER = ircLD_POLICY.POLICY_NUMBER,
				COLLECTIVE_NUMBER = ircLD_POLICY.COLLECTIVE_NUMBER
			where
				rowid = ircLD_POLICY.rowid
			returning
				POLICY_ID
			into
				nuPOLICY_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_POLICY.POLICY_ID,
					rcData
				);
			end if;

			update LD_POLICY
			set
				BASE_VALUE = ircLD_POLICY.BASE_VALUE,
				PORC_BASE_VAL = ircLD_POLICY.PORC_BASE_VAL,
				SALE_CHANEL_ID = ircLD_POLICY.SALE_CHANEL_ID,
				OPERATING_UNIT_ID = ircLD_POLICY.OPERATING_UNIT_ID,
				DESCRIPTION_POLICY = ircLD_POLICY.DESCRIPTION_POLICY,
				STATE_POLICY = ircLD_POLICY.STATE_POLICY,
				LAUNCH_POLICY = ircLD_POLICY.LAUNCH_POLICY,
				CONTRATIST_CODE = ircLD_POLICY.CONTRATIST_CODE,
				PRODUCT_LINE_ID = ircLD_POLICY.PRODUCT_LINE_ID,
				DT_IN_POLICY = ircLD_POLICY.DT_IN_POLICY,
				DT_EN_POLICY = ircLD_POLICY.DT_EN_POLICY,
				VALUE_POLICY = ircLD_POLICY.VALUE_POLICY,
				PREM_POLICY = ircLD_POLICY.PREM_POLICY,
				NAME_INSURED = ircLD_POLICY.NAME_INSURED,
				SUSCRIPTION_ID = ircLD_POLICY.SUSCRIPTION_ID,
				PRODUCT_ID = ircLD_POLICY.PRODUCT_ID,
				IDENTIFICATION_ID = ircLD_POLICY.IDENTIFICATION_ID,
				PERIOD_POLICY = ircLD_POLICY.PERIOD_POLICY,
				YEAR_POLICY = ircLD_POLICY.YEAR_POLICY,
				MONTH_POLICY = ircLD_POLICY.MONTH_POLICY,
				DEFERRED_POLICY_ID = ircLD_POLICY.DEFERRED_POLICY_ID,
				DTCREATE_POLICY = ircLD_POLICY.DTCREATE_POLICY,
				SHARE_POLICY = ircLD_POLICY.SHARE_POLICY,
				DTRET_POLICY = ircLD_POLICY.DTRET_POLICY,
				VALUEACR_POLICY = ircLD_POLICY.VALUEACR_POLICY,
				REPORT_POLICY = ircLD_POLICY.REPORT_POLICY,
				DT_REPORT_POLICY = ircLD_POLICY.DT_REPORT_POLICY,
				DT_INSURED_POLICY = ircLD_POLICY.DT_INSURED_POLICY,
				PER_REPORT_POLICY = ircLD_POLICY.PER_REPORT_POLICY,
				POLICY_TYPE_ID = ircLD_POLICY.POLICY_TYPE_ID,
				ID_REPORT_POLICY = ircLD_POLICY.ID_REPORT_POLICY,
				CANCEL_CAUSAL_ID = ircLD_POLICY.CANCEL_CAUSAL_ID,
				FEES_TO_RETURN = ircLD_POLICY.FEES_TO_RETURN,
				COMMENTS = ircLD_POLICY.COMMENTS,
				POLICY_EXQ = ircLD_POLICY.POLICY_EXQ,
				NUMBER_ACTA = ircLD_POLICY.NUMBER_ACTA,
				GEOGRAP_LOCATION_ID = ircLD_POLICY.GEOGRAP_LOCATION_ID,
				VALIDITY_POLICY_TYPE_ID = ircLD_POLICY.VALIDITY_POLICY_TYPE_ID,
				POLICY_NUMBER = ircLD_POLICY.POLICY_NUMBER,
				COLLECTIVE_NUMBER = ircLD_POLICY.COLLECTIVE_NUMBER
			where
				POLICY_ID = ircLD_POLICY.POLICY_ID
			returning
				POLICY_ID
			into
				nuPOLICY_ID;
		end if;
		if
			nuPOLICY_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_POLICY));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_POLICY in out nocopy tytbLD_POLICY,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_POLICY;
	BEGIN
		FillRecordOfTables(iotbLD_POLICY,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_POLICY.first .. iotbLD_POLICY.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_POLICY.first .. iotbLD_POLICY.last
				update LD_POLICY
				set
					BASE_VALUE = rcRecOfTab.BASE_VALUE(n),
					PORC_BASE_VAL = rcRecOfTab.PORC_BASE_VAL(n),
					SALE_CHANEL_ID = rcRecOfTab.SALE_CHANEL_ID(n),
					OPERATING_UNIT_ID = rcRecOfTab.OPERATING_UNIT_ID(n),
					DESCRIPTION_POLICY = rcRecOfTab.DESCRIPTION_POLICY(n),
					STATE_POLICY = rcRecOfTab.STATE_POLICY(n),
					LAUNCH_POLICY = rcRecOfTab.LAUNCH_POLICY(n),
					CONTRATIST_CODE = rcRecOfTab.CONTRATIST_CODE(n),
					PRODUCT_LINE_ID = rcRecOfTab.PRODUCT_LINE_ID(n),
					DT_IN_POLICY = rcRecOfTab.DT_IN_POLICY(n),
					DT_EN_POLICY = rcRecOfTab.DT_EN_POLICY(n),
					VALUE_POLICY = rcRecOfTab.VALUE_POLICY(n),
					PREM_POLICY = rcRecOfTab.PREM_POLICY(n),
					NAME_INSURED = rcRecOfTab.NAME_INSURED(n),
					SUSCRIPTION_ID = rcRecOfTab.SUSCRIPTION_ID(n),
					PRODUCT_ID = rcRecOfTab.PRODUCT_ID(n),
					IDENTIFICATION_ID = rcRecOfTab.IDENTIFICATION_ID(n),
					PERIOD_POLICY = rcRecOfTab.PERIOD_POLICY(n),
					YEAR_POLICY = rcRecOfTab.YEAR_POLICY(n),
					MONTH_POLICY = rcRecOfTab.MONTH_POLICY(n),
					DEFERRED_POLICY_ID = rcRecOfTab.DEFERRED_POLICY_ID(n),
					DTCREATE_POLICY = rcRecOfTab.DTCREATE_POLICY(n),
					SHARE_POLICY = rcRecOfTab.SHARE_POLICY(n),
					DTRET_POLICY = rcRecOfTab.DTRET_POLICY(n),
					VALUEACR_POLICY = rcRecOfTab.VALUEACR_POLICY(n),
					REPORT_POLICY = rcRecOfTab.REPORT_POLICY(n),
					DT_REPORT_POLICY = rcRecOfTab.DT_REPORT_POLICY(n),
					DT_INSURED_POLICY = rcRecOfTab.DT_INSURED_POLICY(n),
					PER_REPORT_POLICY = rcRecOfTab.PER_REPORT_POLICY(n),
					POLICY_TYPE_ID = rcRecOfTab.POLICY_TYPE_ID(n),
					ID_REPORT_POLICY = rcRecOfTab.ID_REPORT_POLICY(n),
					CANCEL_CAUSAL_ID = rcRecOfTab.CANCEL_CAUSAL_ID(n),
					FEES_TO_RETURN = rcRecOfTab.FEES_TO_RETURN(n),
					COMMENTS = rcRecOfTab.COMMENTS(n),
					POLICY_EXQ = rcRecOfTab.POLICY_EXQ(n),
					NUMBER_ACTA = rcRecOfTab.NUMBER_ACTA(n),
					GEOGRAP_LOCATION_ID = rcRecOfTab.GEOGRAP_LOCATION_ID(n),
					VALIDITY_POLICY_TYPE_ID = rcRecOfTab.VALIDITY_POLICY_TYPE_ID(n),
					POLICY_NUMBER = rcRecOfTab.POLICY_NUMBER(n),
					COLLECTIVE_NUMBER = rcRecOfTab.COLLECTIVE_NUMBER(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_POLICY.first .. iotbLD_POLICY.last loop
					LockByPk
					(
						rcRecOfTab.POLICY_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_POLICY.first .. iotbLD_POLICY.last
				update LD_POLICY
				SET
					BASE_VALUE = rcRecOfTab.BASE_VALUE(n),
					PORC_BASE_VAL = rcRecOfTab.PORC_BASE_VAL(n),
					SALE_CHANEL_ID = rcRecOfTab.SALE_CHANEL_ID(n),
					OPERATING_UNIT_ID = rcRecOfTab.OPERATING_UNIT_ID(n),
					DESCRIPTION_POLICY = rcRecOfTab.DESCRIPTION_POLICY(n),
					STATE_POLICY = rcRecOfTab.STATE_POLICY(n),
					LAUNCH_POLICY = rcRecOfTab.LAUNCH_POLICY(n),
					CONTRATIST_CODE = rcRecOfTab.CONTRATIST_CODE(n),
					PRODUCT_LINE_ID = rcRecOfTab.PRODUCT_LINE_ID(n),
					DT_IN_POLICY = rcRecOfTab.DT_IN_POLICY(n),
					DT_EN_POLICY = rcRecOfTab.DT_EN_POLICY(n),
					VALUE_POLICY = rcRecOfTab.VALUE_POLICY(n),
					PREM_POLICY = rcRecOfTab.PREM_POLICY(n),
					NAME_INSURED = rcRecOfTab.NAME_INSURED(n),
					SUSCRIPTION_ID = rcRecOfTab.SUSCRIPTION_ID(n),
					PRODUCT_ID = rcRecOfTab.PRODUCT_ID(n),
					IDENTIFICATION_ID = rcRecOfTab.IDENTIFICATION_ID(n),
					PERIOD_POLICY = rcRecOfTab.PERIOD_POLICY(n),
					YEAR_POLICY = rcRecOfTab.YEAR_POLICY(n),
					MONTH_POLICY = rcRecOfTab.MONTH_POLICY(n),
					DEFERRED_POLICY_ID = rcRecOfTab.DEFERRED_POLICY_ID(n),
					DTCREATE_POLICY = rcRecOfTab.DTCREATE_POLICY(n),
					SHARE_POLICY = rcRecOfTab.SHARE_POLICY(n),
					DTRET_POLICY = rcRecOfTab.DTRET_POLICY(n),
					VALUEACR_POLICY = rcRecOfTab.VALUEACR_POLICY(n),
					REPORT_POLICY = rcRecOfTab.REPORT_POLICY(n),
					DT_REPORT_POLICY = rcRecOfTab.DT_REPORT_POLICY(n),
					DT_INSURED_POLICY = rcRecOfTab.DT_INSURED_POLICY(n),
					PER_REPORT_POLICY = rcRecOfTab.PER_REPORT_POLICY(n),
					POLICY_TYPE_ID = rcRecOfTab.POLICY_TYPE_ID(n),
					ID_REPORT_POLICY = rcRecOfTab.ID_REPORT_POLICY(n),
					CANCEL_CAUSAL_ID = rcRecOfTab.CANCEL_CAUSAL_ID(n),
					FEES_TO_RETURN = rcRecOfTab.FEES_TO_RETURN(n),
					COMMENTS = rcRecOfTab.COMMENTS(n),
					POLICY_EXQ = rcRecOfTab.POLICY_EXQ(n),
					NUMBER_ACTA = rcRecOfTab.NUMBER_ACTA(n),
					GEOGRAP_LOCATION_ID = rcRecOfTab.GEOGRAP_LOCATION_ID(n),
					VALIDITY_POLICY_TYPE_ID = rcRecOfTab.VALIDITY_POLICY_TYPE_ID(n),
					POLICY_NUMBER = rcRecOfTab.POLICY_NUMBER(n),
					COLLECTIVE_NUMBER = rcRecOfTab.COLLECTIVE_NUMBER(n)
				where
					POLICY_ID = rcRecOfTab.POLICY_ID(n)
;
		end if;
	END;
	PROCEDURE updBASE_VALUE
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuBASE_VALUE$ in LD_POLICY.BASE_VALUE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			BASE_VALUE = inuBASE_VALUE$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BASE_VALUE:= inuBASE_VALUE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPORC_BASE_VAL
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuPORC_BASE_VAL$ in LD_POLICY.PORC_BASE_VAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			PORC_BASE_VAL = inuPORC_BASE_VAL$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PORC_BASE_VAL:= inuPORC_BASE_VAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSALE_CHANEL_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuSALE_CHANEL_ID$ in LD_POLICY.SALE_CHANEL_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			SALE_CHANEL_ID = inuSALE_CHANEL_ID$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SALE_CHANEL_ID:= inuSALE_CHANEL_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updOPERATING_UNIT_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuOPERATING_UNIT_ID$ in LD_POLICY.OPERATING_UNIT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			OPERATING_UNIT_ID = inuOPERATING_UNIT_ID$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OPERATING_UNIT_ID:= inuOPERATING_UNIT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESCRIPTION_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		isbDESCRIPTION_POLICY$ in LD_POLICY.DESCRIPTION_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			DESCRIPTION_POLICY = isbDESCRIPTION_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPTION_POLICY:= isbDESCRIPTION_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSTATE_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuSTATE_POLICY$ in LD_POLICY.STATE_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			STATE_POLICY = inuSTATE_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.STATE_POLICY:= inuSTATE_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLAUNCH_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuLAUNCH_POLICY$ in LD_POLICY.LAUNCH_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			LAUNCH_POLICY = inuLAUNCH_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LAUNCH_POLICY:= inuLAUNCH_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCONTRATIST_CODE
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuCONTRATIST_CODE$ in LD_POLICY.CONTRATIST_CODE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			CONTRATIST_CODE = inuCONTRATIST_CODE$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CONTRATIST_CODE:= inuCONTRATIST_CODE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRODUCT_LINE_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuPRODUCT_LINE_ID$ in LD_POLICY.PRODUCT_LINE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			PRODUCT_LINE_ID = inuPRODUCT_LINE_ID$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRODUCT_LINE_ID:= inuPRODUCT_LINE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDT_IN_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		idtDT_IN_POLICY$ in LD_POLICY.DT_IN_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			DT_IN_POLICY = idtDT_IN_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DT_IN_POLICY:= idtDT_IN_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDT_EN_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		idtDT_EN_POLICY$ in LD_POLICY.DT_EN_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			DT_EN_POLICY = idtDT_EN_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DT_EN_POLICY:= idtDT_EN_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALUE_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuVALUE_POLICY$ in LD_POLICY.VALUE_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			VALUE_POLICY = inuVALUE_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALUE_POLICY:= inuVALUE_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPREM_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuPREM_POLICY$ in LD_POLICY.PREM_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			PREM_POLICY = inuPREM_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PREM_POLICY:= inuPREM_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNAME_INSURED
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		isbNAME_INSURED$ in LD_POLICY.NAME_INSURED%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			NAME_INSURED = isbNAME_INSURED$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NAME_INSURED:= isbNAME_INSURED$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUSCRIPTION_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuSUSCRIPTION_ID$ in LD_POLICY.SUSCRIPTION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			SUSCRIPTION_ID = inuSUSCRIPTION_ID$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUSCRIPTION_ID:= inuSUSCRIPTION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRODUCT_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuPRODUCT_ID$ in LD_POLICY.PRODUCT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			PRODUCT_ID = inuPRODUCT_ID$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRODUCT_ID:= inuPRODUCT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIDENTIFICATION_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuIDENTIFICATION_ID$ in LD_POLICY.IDENTIFICATION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			IDENTIFICATION_ID = inuIDENTIFICATION_ID$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IDENTIFICATION_ID:= inuIDENTIFICATION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPERIOD_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuPERIOD_POLICY$ in LD_POLICY.PERIOD_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			PERIOD_POLICY = inuPERIOD_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PERIOD_POLICY:= inuPERIOD_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updYEAR_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuYEAR_POLICY$ in LD_POLICY.YEAR_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			YEAR_POLICY = inuYEAR_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.YEAR_POLICY:= inuYEAR_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMONTH_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuMONTH_POLICY$ in LD_POLICY.MONTH_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			MONTH_POLICY = inuMONTH_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MONTH_POLICY:= inuMONTH_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEFERRED_POLICY_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuDEFERRED_POLICY_ID$ in LD_POLICY.DEFERRED_POLICY_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			DEFERRED_POLICY_ID = inuDEFERRED_POLICY_ID$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEFERRED_POLICY_ID:= inuDEFERRED_POLICY_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDTCREATE_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		idtDTCREATE_POLICY$ in LD_POLICY.DTCREATE_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			DTCREATE_POLICY = idtDTCREATE_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DTCREATE_POLICY:= idtDTCREATE_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSHARE_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuSHARE_POLICY$ in LD_POLICY.SHARE_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			SHARE_POLICY = inuSHARE_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SHARE_POLICY:= inuSHARE_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDTRET_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		idtDTRET_POLICY$ in LD_POLICY.DTRET_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			DTRET_POLICY = idtDTRET_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DTRET_POLICY:= idtDTRET_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALUEACR_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuVALUEACR_POLICY$ in LD_POLICY.VALUEACR_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			VALUEACR_POLICY = inuVALUEACR_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALUEACR_POLICY:= inuVALUEACR_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREPORT_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		isbREPORT_POLICY$ in LD_POLICY.REPORT_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			REPORT_POLICY = isbREPORT_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REPORT_POLICY:= isbREPORT_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDT_REPORT_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		idtDT_REPORT_POLICY$ in LD_POLICY.DT_REPORT_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			DT_REPORT_POLICY = idtDT_REPORT_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DT_REPORT_POLICY:= idtDT_REPORT_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDT_INSURED_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		idtDT_INSURED_POLICY$ in LD_POLICY.DT_INSURED_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			DT_INSURED_POLICY = idtDT_INSURED_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DT_INSURED_POLICY:= idtDT_INSURED_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPER_REPORT_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		isbPER_REPORT_POLICY$ in LD_POLICY.PER_REPORT_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			PER_REPORT_POLICY = isbPER_REPORT_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PER_REPORT_POLICY:= isbPER_REPORT_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPOLICY_TYPE_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuPOLICY_TYPE_ID$ in LD_POLICY.POLICY_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			POLICY_TYPE_ID = inuPOLICY_TYPE_ID$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.POLICY_TYPE_ID:= inuPOLICY_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_REPORT_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		isbID_REPORT_POLICY$ in LD_POLICY.ID_REPORT_POLICY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			ID_REPORT_POLICY = isbID_REPORT_POLICY$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_REPORT_POLICY:= isbID_REPORT_POLICY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCANCEL_CAUSAL_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuCANCEL_CAUSAL_ID$ in LD_POLICY.CANCEL_CAUSAL_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			CANCEL_CAUSAL_ID = inuCANCEL_CAUSAL_ID$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CANCEL_CAUSAL_ID:= inuCANCEL_CAUSAL_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFEES_TO_RETURN
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuFEES_TO_RETURN$ in LD_POLICY.FEES_TO_RETURN%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			FEES_TO_RETURN = inuFEES_TO_RETURN$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FEES_TO_RETURN:= inuFEES_TO_RETURN$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOMMENTS
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		isbCOMMENTS$ in LD_POLICY.COMMENTS%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			COMMENTS = isbCOMMENTS$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMMENTS:= isbCOMMENTS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPOLICY_EXQ
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		isbPOLICY_EXQ$ in LD_POLICY.POLICY_EXQ%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			POLICY_EXQ = isbPOLICY_EXQ$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.POLICY_EXQ:= isbPOLICY_EXQ$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNUMBER_ACTA
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuNUMBER_ACTA$ in LD_POLICY.NUMBER_ACTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			NUMBER_ACTA = inuNUMBER_ACTA$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NUMBER_ACTA:= inuNUMBER_ACTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updGEOGRAP_LOCATION_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuGEOGRAP_LOCATION_ID$ in LD_POLICY.GEOGRAP_LOCATION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			GEOGRAP_LOCATION_ID = inuGEOGRAP_LOCATION_ID$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.GEOGRAP_LOCATION_ID:= inuGEOGRAP_LOCATION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALIDITY_POLICY_TYPE_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuVALIDITY_POLICY_TYPE_ID$ in LD_POLICY.VALIDITY_POLICY_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			VALIDITY_POLICY_TYPE_ID = inuVALIDITY_POLICY_TYPE_ID$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALIDITY_POLICY_TYPE_ID:= inuVALIDITY_POLICY_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPOLICY_NUMBER
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuPOLICY_NUMBER$ in LD_POLICY.POLICY_NUMBER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			POLICY_NUMBER = inuPOLICY_NUMBER$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.POLICY_NUMBER:= inuPOLICY_NUMBER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOLLECTIVE_NUMBER
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuCOLLECTIVE_NUMBER$ in LD_POLICY.COLLECTIVE_NUMBER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_POLICY;
	BEGIN
		rcError.POLICY_ID := inuPOLICY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPOLICY_ID,
				rcData
			);
		end if;

		update LD_POLICY
		set
			COLLECTIVE_NUMBER = inuCOLLECTIVE_NUMBER$
		where
			POLICY_ID = inuPOLICY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COLLECTIVE_NUMBER:= inuCOLLECTIVE_NUMBER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetBASE_VALUE
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.BASE_VALUE%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.BASE_VALUE);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.BASE_VALUE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPORC_BASE_VAL
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.PORC_BASE_VAL%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.PORC_BASE_VAL);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.PORC_BASE_VAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSALE_CHANEL_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.SALE_CHANEL_ID%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.SALE_CHANEL_ID);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.SALE_CHANEL_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetOPERATING_UNIT_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.OPERATING_UNIT_ID%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.OPERATING_UNIT_ID);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.OPERATING_UNIT_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDESCRIPTION_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.DESCRIPTION_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.DESCRIPTION_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.DESCRIPTION_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPOLICY_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.POLICY_ID%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.POLICY_ID);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.POLICY_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSTATE_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.STATE_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.STATE_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.STATE_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLAUNCH_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.LAUNCH_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.LAUNCH_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.LAUNCH_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCONTRATIST_CODE
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.CONTRATIST_CODE%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.CONTRATIST_CODE);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.CONTRATIST_CODE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPRODUCT_LINE_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.PRODUCT_LINE_ID%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.PRODUCT_LINE_ID);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.PRODUCT_LINE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetDT_IN_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.DT_IN_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.DT_IN_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.DT_IN_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetDT_EN_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.DT_EN_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.DT_EN_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.DT_EN_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALUE_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.VALUE_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.VALUE_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.VALUE_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPREM_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.PREM_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.PREM_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.PREM_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetNAME_INSURED
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.NAME_INSURED%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.NAME_INSURED);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.NAME_INSURED);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUSCRIPTION_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.SUSCRIPTION_ID%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.SUSCRIPTION_ID);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.SUSCRIPTION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPRODUCT_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.PRODUCT_ID%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.PRODUCT_ID);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.PRODUCT_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIDENTIFICATION_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.IDENTIFICATION_ID%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.IDENTIFICATION_ID);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.IDENTIFICATION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPERIOD_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.PERIOD_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.PERIOD_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.PERIOD_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetYEAR_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.YEAR_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.YEAR_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.YEAR_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetMONTH_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.MONTH_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.MONTH_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.MONTH_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDEFERRED_POLICY_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.DEFERRED_POLICY_ID%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.DEFERRED_POLICY_ID);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.DEFERRED_POLICY_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetDTCREATE_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.DTCREATE_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.DTCREATE_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.DTCREATE_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSHARE_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.SHARE_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.SHARE_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.SHARE_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetDTRET_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.DTRET_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.DTRET_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.DTRET_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALUEACR_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.VALUEACR_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.VALUEACR_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.VALUEACR_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetREPORT_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.REPORT_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.REPORT_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.REPORT_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetDT_REPORT_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.DT_REPORT_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.DT_REPORT_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.DT_REPORT_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetDT_INSURED_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.DT_INSURED_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.DT_INSURED_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.DT_INSURED_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPER_REPORT_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.PER_REPORT_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.PER_REPORT_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.PER_REPORT_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPOLICY_TYPE_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.POLICY_TYPE_ID%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.POLICY_TYPE_ID);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.POLICY_TYPE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetID_REPORT_POLICY
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.ID_REPORT_POLICY%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.ID_REPORT_POLICY);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.ID_REPORT_POLICY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCANCEL_CAUSAL_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.CANCEL_CAUSAL_ID%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.CANCEL_CAUSAL_ID);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.CANCEL_CAUSAL_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetFEES_TO_RETURN
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.FEES_TO_RETURN%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.FEES_TO_RETURN);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.FEES_TO_RETURN);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCOMMENTS
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.COMMENTS%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.COMMENTS);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.COMMENTS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPOLICY_EXQ
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.POLICY_EXQ%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.POLICY_EXQ);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.POLICY_EXQ);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetNUMBER_ACTA
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.NUMBER_ACTA%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.NUMBER_ACTA);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.NUMBER_ACTA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetGEOGRAP_LOCATION_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.GEOGRAP_LOCATION_ID%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.GEOGRAP_LOCATION_ID);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.GEOGRAP_LOCATION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALIDITY_POLICY_TYPE_ID
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.VALIDITY_POLICY_TYPE_ID%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.VALIDITY_POLICY_TYPE_ID);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.VALIDITY_POLICY_TYPE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPOLICY_NUMBER
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.POLICY_NUMBER%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.POLICY_NUMBER);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.POLICY_NUMBER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOLLECTIVE_NUMBER
	(
		inuPOLICY_ID in LD_POLICY.POLICY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_POLICY.COLLECTIVE_NUMBER%type
	IS
		rcError styLD_POLICY;
	BEGIN

		rcError.POLICY_ID := inuPOLICY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPOLICY_ID
			 )
		then
			 return(rcData.COLLECTIVE_NUMBER);
		end if;
		Load
		(
		 		inuPOLICY_ID
		);
		return(rcData.COLLECTIVE_NUMBER);
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
end DALD_POLICY;
/

PROMPT Otorgando permisos de ejecucion a DALD_POLICY
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_POLICY', 'ADM_PERSON');
END;
/