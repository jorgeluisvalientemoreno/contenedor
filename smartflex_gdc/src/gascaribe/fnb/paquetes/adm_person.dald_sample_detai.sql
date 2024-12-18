CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_SAMPLE_DETAI
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_SAMPLE_DETAI
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
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type
	)
	IS
		SELECT LD_SAMPLE_DETAI.*,LD_SAMPLE_DETAI.rowid
		FROM LD_SAMPLE_DETAI
		WHERE
		    DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID
		    and SAMPLE_ID = inuSAMPLE_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_SAMPLE_DETAI.*,LD_SAMPLE_DETAI.rowid
		FROM LD_SAMPLE_DETAI
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_SAMPLE_DETAI  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_SAMPLE_DETAI is table of styLD_SAMPLE_DETAI index by binary_integer;
	type tyrfRecords is ref cursor return styLD_SAMPLE_DETAI;

	/* Tipos referenciando al registro */
	type tytbNOTIFICATION is table of LD_SAMPLE_DETAI.NOTIFICATION%type index by binary_integer;
	type tytbIS_APPROVED is table of LD_SAMPLE_DETAI.IS_APPROVED%type index by binary_integer;
	type tytbSOURCE is table of LD_SAMPLE_DETAI.SOURCE%type index by binary_integer;
	type tytbSUBSCRIBER_ID is table of LD_SAMPLE_DETAI.SUBSCRIBER_ID%type index by binary_integer;
	type tytbPRODUCT_ID is table of LD_SAMPLE_DETAI.PRODUCT_ID%type index by binary_integer;
	type tytbSUBSCRIPTION_ID is table of LD_SAMPLE_DETAI.SUBSCRIPTION_ID%type index by binary_integer;
	type tytbSAMPLE_ID is table of LD_SAMPLE_DETAI.SAMPLE_ID%type index by binary_integer;
	type tytbRESERVED_CF is table of LD_SAMPLE_DETAI.RESERVED_CF%type index by binary_integer;
	type tytbBRANCH_CODE_CF is table of LD_SAMPLE_DETAI.BRANCH_CODE_CF%type index by binary_integer;
	type tytbQUALITY_CF is table of LD_SAMPLE_DETAI.QUALITY_CF%type index by binary_integer;
	type tytbRATINGS_CF is table of LD_SAMPLE_DETAI.RATINGS_CF%type index by binary_integer;
	type tytbSTATE_STATUS_HOLDER_CF is table of LD_SAMPLE_DETAI.STATE_STATUS_HOLDER_CF%type index by binary_integer;
	type tytbSTATE_CF is table of LD_SAMPLE_DETAI.STATE_CF%type index by binary_integer;
	type tytbMORA_YEARS_CF is table of LD_SAMPLE_DETAI.MORA_YEARS_CF%type index by binary_integer;
	type tytbSTATEMENT_DATE_CF is table of LD_SAMPLE_DETAI.STATEMENT_DATE_CF%type index by binary_integer;
	type tytbINITIAL_ISSUE_DATE_CF is table of LD_SAMPLE_DETAI.INITIAL_ISSUE_DATE_CF%type index by binary_integer;
	type tytbTERMINATION_DATE_CF is table of LD_SAMPLE_DETAI.TERMINATION_DATE_CF%type index by binary_integer;
	type tytbDUE_DATE_CF is table of LD_SAMPLE_DETAI.DUE_DATE_CF%type index by binary_integer;
	type tytbEXTICION_MODE_ID_CF is table of LD_SAMPLE_DETAI.EXTICION_MODE_ID_CF%type index by binary_integer;
	type tytbTYPE_PAYMENT_CF is table of LD_SAMPLE_DETAI.TYPE_PAYMENT_CF%type index by binary_integer;
	type tytbFIXED_CHARGE_VALUE_CF is table of LD_SAMPLE_DETAI.FIXED_CHARGE_VALUE_CF%type index by binary_integer;
	type tytbCREDIT_LINE_CF is table of LD_SAMPLE_DETAI.CREDIT_LINE_CF%type index by binary_integer;
	type tytbRESTR_OBLIGATION_CF is table of LD_SAMPLE_DETAI.RESTRUCTURATED_OBLIGATION_CF%type index by binary_integer;
	type tytbNUMBER_OF_RESTRUCTURING_CF is table of LD_SAMPLE_DETAI.NUMBER_OF_RESTRUCTURING_CF%type index by binary_integer;
	type tytbNUMB_OF_RET_CHKS_CF is table of LD_SAMPLE_DETAI.NUMBER_OF_RETURNED_CHECKS_CF%type index by binary_integer;
	type tytbTERM_CF is table of LD_SAMPLE_DETAI.TERM_CF%type index by binary_integer;
	type tytbDAYS_OF_PORTFOLIO_CF is table of LD_SAMPLE_DETAI.DAYS_OF_PORTFOLIO_CF%type index by binary_integer;
	type tytbTHIRD_HOUSE_ADDRESS_CF is table of LD_SAMPLE_DETAI.THIRD_HOUSE_ADDRESS_CF%type index by binary_integer;
	type tytbTHIRD_HOME_PHONE_CF is table of LD_SAMPLE_DETAI.THIRD_HOME_PHONE_CF%type index by binary_integer;
	type tytbEVERY_CITY_CODE_CF is table of LD_SAMPLE_DETAI.EVERY_CITY_CODE_CF%type index by binary_integer;
	type tytbTOWN_HOUSE_PARTY_CF is table of LD_SAMPLE_DETAI.TOWN_HOUSE_PARTY_CF%type index by binary_integer;
	type tytbHOME_DEPARTMENT_CODE_CF is table of LD_SAMPLE_DETAI.HOME_DEPARTMENT_CODE_CF%type index by binary_integer;
	type tytbDEPT_OF_THIRD_HOU_CF is table of LD_SAMPLE_DETAI.DEPARTMENT_OF_THIRD_HOUSE_CF%type index by binary_integer;
	type tytbCOMPANY_NAME_CF is table of LD_SAMPLE_DETAI.COMPANY_NAME_CF%type index by binary_integer;
	type tytbCOMPANY_ADDRESS_CF is table of LD_SAMPLE_DETAI.COMPANY_ADDRESS_CF%type index by binary_integer;
	type tytbCOMPANY_PHONE_CF is table of LD_SAMPLE_DETAI.COMPANY_PHONE_CF%type index by binary_integer;
	type tytbCITY_CODE_CF is table of LD_SAMPLE_DETAI.CITY_CODE_CF%type index by binary_integer;
	type tytbNOW_CITY_OF_THIRD_CF is table of LD_SAMPLE_DETAI.NOW_CITY_OF_THIRD_CF%type index by binary_integer;
	type tytbDEPARTAMENT_CODE_CF is table of LD_SAMPLE_DETAI.DEPARTAMENT_CODE_CF%type index by binary_integer;
	type tytbTHIRD_COMP_DEPT_CF is table of LD_SAMPLE_DETAI.THIRD_COMPANY_DEPARTMENT_CF%type index by binary_integer;
	type tytbNAT_RESTRUCTURING_CF is table of LD_SAMPLE_DETAI.NAT_RESTRUCTURING_CF%type index by binary_integer;
	type tytbDETAIL_SAMPLE_ID is table of LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type index by binary_integer;
	type tytbLEGAL_NATURE is table of LD_SAMPLE_DETAI.LEGAL_NATURE%type index by binary_integer;
	type tytbVALUE_OF_COLLATERAL is table of LD_SAMPLE_DETAI.VALUE_OF_COLLATERAL%type index by binary_integer;
	type tytbSERVICE_CATEGORY is table of LD_SAMPLE_DETAI.SERVICE_CATEGORY%type index by binary_integer;
	type tytbTYPE_OF_ACCOUNT is table of LD_SAMPLE_DETAI.TYPE_OF_ACCOUNT%type index by binary_integer;
	type tytbSPACE_OVERDRAFT is table of LD_SAMPLE_DETAI.SPACE_OVERDRAFT%type index by binary_integer;
	type tytbAUTHORIZED_DAYS is table of LD_SAMPLE_DETAI.AUTHORIZED_DAYS%type index by binary_integer;
	type tytbDEFAULT_MORA_AGE_ID_CF is table of LD_SAMPLE_DETAI.DEFAULT_MORA_AGE_ID_CF%type index by binary_integer;
	type tytbTYPE_PORTFOLIO_ID_CF is table of LD_SAMPLE_DETAI.TYPE_PORTFOLIO_ID_CF%type index by binary_integer;
	type tytbNUMBER_MONTHS_CONTRACT_CF is table of LD_SAMPLE_DETAI.NUMBER_MONTHS_CONTRACT_CF%type index by binary_integer;
	type tytbCREDIT_MODE is table of LD_SAMPLE_DETAI.CREDIT_MODE%type index by binary_integer;
	type tytbNIVEL is table of LD_SAMPLE_DETAI.NIVEL%type index by binary_integer;
	type tytbST_DATE_EXCEN_GMF_CF is table of LD_SAMPLE_DETAI.START_DATE_EXCENSION_GMF_CF%type index by binary_integer;
	type tytbTERMI_DATE_EXC_GMF_CF is table of LD_SAMPLE_DETAI.TERMINATION_DATE_EXC_GMF_CF%type index by binary_integer;
	type tytbNUMBER_OF_RENEWAL_CDT_CF is table of LD_SAMPLE_DETAI.NUMBER_OF_RENEWAL_CDT_CF%type index by binary_integer;
	type tytbGMF_FREE_SAVINGS_CTA_CF is table of LD_SAMPLE_DETAI.GMF_FREE_SAVINGS_CTA_CF%type index by binary_integer;
	type tytbNATIVE_TYPE_IDENT_CF is table of LD_SAMPLE_DETAI.NATIVE_TYPE_IDENTIFICATION_CF%type index by binary_integer;
	type tytbIDENT_NUMBER_OF_NATIVE_CF is table of LD_SAMPLE_DETAI.IDENT_NUMBER_OF_NATIVE_CF%type index by binary_integer;
	type tytbENTITY_TYPE_NATIVE_CF is table of LD_SAMPLE_DETAI.ENTITY_TYPE_NATIVE_CF%type index by binary_integer;
	type tytbENTITY_CODE_ORIGINATING_CF is table of LD_SAMPLE_DETAI.ENTITY_CODE_ORIGINATING_CF%type index by binary_integer;
	type tytbTYPE_OF_TRUST_CF is table of LD_SAMPLE_DETAI.TYPE_OF_TRUST_CF%type index by binary_integer;
	type tytbNUMBER_OF_TRUST_CF is table of LD_SAMPLE_DETAI.NUMBER_OF_TRUST_CF%type index by binary_integer;
	type tytbNAME_TRUST_CF is table of LD_SAMPLE_DETAI.NAME_TRUST_CF%type index by binary_integer;
	type tytbTYPE_OF_DEBT_PORTFOLIO_CF is table of LD_SAMPLE_DETAI.TYPE_OF_DEBT_PORTFOLIO_CF%type index by binary_integer;
	type tytbPOLICY_TYPE_CF is table of LD_SAMPLE_DETAI.POLICY_TYPE_CF%type index by binary_integer;
	type tytbRAMIFICATION_CODE is table of LD_SAMPLE_DETAI.RAMIFICATION_CODE%type index by binary_integer;
	type tytbDATE_OF_PRESCRIPTION is table of LD_SAMPLE_DETAI.DATE_OF_PRESCRIPTION%type index by binary_integer;
	type tytbSCORE is table of LD_SAMPLE_DETAI.SCORE%type index by binary_integer;
	type tytbTYPE_IDENTIFICATION_DC is table of LD_SAMPLE_DETAI.TYPE_IDENTIFICATION_DC%type index by binary_integer;
	type tytbTYPE_IDENTIFICATION_CF is table of LD_SAMPLE_DETAI.TYPE_IDENTIFICATION_CF%type index by binary_integer;
	type tytbIDENTIFICATION_NUMBER is table of LD_SAMPLE_DETAI.IDENTIFICATION_NUMBER%type index by binary_integer;
	type tytbRECORD_TYPE_ID_CF is table of LD_SAMPLE_DETAI.RECORD_TYPE_ID_CF%type index by binary_integer;
	type tytbFULL_NAME is table of LD_SAMPLE_DETAI.FULL_NAME%type index by binary_integer;
	type tytbACCOUNT_NUMBER is table of LD_SAMPLE_DETAI.ACCOUNT_NUMBER%type index by binary_integer;
	type tytbBRANCH_OFFICE_CF is table of LD_SAMPLE_DETAI.BRANCH_OFFICE_CF%type index by binary_integer;
	type tytbSITUATION_HOLDER_DC is table of LD_SAMPLE_DETAI.SITUATION_HOLDER_DC%type index by binary_integer;
	type tytbOPENING_DATE is table of LD_SAMPLE_DETAI.OPENING_DATE%type index by binary_integer;
	type tytbDUE_DATE_DC is table of LD_SAMPLE_DETAI.DUE_DATE_DC%type index by binary_integer;
	type tytbRESPONSIBLE_DC is table of LD_SAMPLE_DETAI.RESPONSIBLE_DC%type index by binary_integer;
	type tytbTYPE_OBLIGATION_ID_DC is table of LD_SAMPLE_DETAI.TYPE_OBLIGATION_ID_DC%type index by binary_integer;
	type tytbMORTGAGE_SUBSIDY_DC is table of LD_SAMPLE_DETAI.MORTGAGE_SUBSIDY_DC%type index by binary_integer;
	type tytbDATE_SUBSIDY_DC is table of LD_SAMPLE_DETAI.DATE_SUBSIDY_DC%type index by binary_integer;
	type tytbTYPE_CONTRACT_ID_CF is table of LD_SAMPLE_DETAI.TYPE_CONTRACT_ID_CF%type index by binary_integer;
	type tytbSTATE_OF_CONTRACT_CF is table of LD_SAMPLE_DETAI.STATE_OF_CONTRACT_CF%type index by binary_integer;
	type tytbTERM_CONTRACT_CF is table of LD_SAMPLE_DETAI.TERM_CONTRACT_CF%type index by binary_integer;
	type tytbTERM_CONTRACT_DC is table of LD_SAMPLE_DETAI.TERM_CONTRACT_DC%type index by binary_integer;
	type tytbMETHOD_PAYMENT_ID_CF is table of LD_SAMPLE_DETAI.METHOD_PAYMENT_ID_CF%type index by binary_integer;
	type tytbMETHOD_PAYMENT_ID_DC is table of LD_SAMPLE_DETAI.METHOD_PAYMENT_ID_DC%type index by binary_integer;
	type tytbPERIODICITY_ID_DC is table of LD_SAMPLE_DETAI.PERIODICITY_ID_DC%type index by binary_integer;
	type tytbPERIODICITY_ID_CF is table of LD_SAMPLE_DETAI.PERIODICITY_ID_CF%type index by binary_integer;
	type tytbNEW_PORTFOLIO_ID_DC is table of LD_SAMPLE_DETAI.NEW_PORTFOLIO_ID_DC%type index by binary_integer;
	type tytbSTATE_OBLIGATION_CF is table of LD_SAMPLE_DETAI.STATE_OBLIGATION_CF%type index by binary_integer;
	type tytbSITUATION_HOLDER_CF is table of LD_SAMPLE_DETAI.SITUATION_HOLDER_CF%type index by binary_integer;
	type tytbACCOUNT_STATE_ID_DC is table of LD_SAMPLE_DETAI.ACCOUNT_STATE_ID_DC%type index by binary_integer;
	type tytbDATE_STATUS_ORIGIN is table of LD_SAMPLE_DETAI.DATE_STATUS_ORIGIN%type index by binary_integer;
	type tytbSOURCE_STATE_ID is table of LD_SAMPLE_DETAI.SOURCE_STATE_ID%type index by binary_integer;
	type tytbDATE_STATUS_ACCOUNT is table of LD_SAMPLE_DETAI.DATE_STATUS_ACCOUNT%type index by binary_integer;
	type tytbSTATUS_PLASTIC_DC is table of LD_SAMPLE_DETAI.STATUS_PLASTIC_DC%type index by binary_integer;
	type tytbDATE_STATUS_PLASTIC_DC is table of LD_SAMPLE_DETAI.DATE_STATUS_PLASTIC_DC%type index by binary_integer;
	type tytbADJETIVE_DC is table of LD_SAMPLE_DETAI.ADJETIVE_DC%type index by binary_integer;
	type tytbDATE_ADJETIVE_DC is table of LD_SAMPLE_DETAI.DATE_ADJETIVE_DC%type index by binary_integer;
	type tytbCARD_CLASS_DC is table of LD_SAMPLE_DETAI.CARD_CLASS_DC%type index by binary_integer;
	type tytbFRANCHISE_DC is table of LD_SAMPLE_DETAI.FRANCHISE_DC%type index by binary_integer;
	type tytbPRIVATE_BRAND_NAME_DC is table of LD_SAMPLE_DETAI.PRIVATE_BRAND_NAME_DC%type index by binary_integer;
	type tytbTYPE_MONEY_DC is table of LD_SAMPLE_DETAI.TYPE_MONEY_DC%type index by binary_integer;
	type tytbTYPE_WARRANTY_DC is table of LD_SAMPLE_DETAI.TYPE_WARRANTY_DC%type index by binary_integer;
	type tytbRATINGS_DC is table of LD_SAMPLE_DETAI.RATINGS_DC%type index by binary_integer;
	type tytbPROBABILITY_DEFAULT_DC is table of LD_SAMPLE_DETAI.PROBABILITY_DEFAULT_DC%type index by binary_integer;
	type tytbMORA_AGE is table of LD_SAMPLE_DETAI.MORA_AGE%type index by binary_integer;
	type tytbINITIAL_VALUES_DC is table of LD_SAMPLE_DETAI.INITIAL_VALUES_DC%type index by binary_integer;
	type tytbDEBT_TO_DC is table of LD_SAMPLE_DETAI.DEBT_TO_DC%type index by binary_integer;
	type tytbVALUE_AVAILABLE is table of LD_SAMPLE_DETAI.VALUE_AVAILABLE%type index by binary_integer;
	type tytbMONTHLY_VALUE is table of LD_SAMPLE_DETAI.MONTHLY_VALUE%type index by binary_integer;
	type tytbVALUE_DELAY is table of LD_SAMPLE_DETAI.VALUE_DELAY%type index by binary_integer;
	type tytbTOTAL_SHARES is table of LD_SAMPLE_DETAI.TOTAL_SHARES%type index by binary_integer;
	type tytbSHARES_CANCELED is table of LD_SAMPLE_DETAI.SHARES_CANCELED%type index by binary_integer;
	type tytbSHARES_DEBT is table of LD_SAMPLE_DETAI.SHARES_DEBT%type index by binary_integer;
	type tytbCLAUSE_PERMANENCE_DC is table of LD_SAMPLE_DETAI.CLAUSE_PERMANENCE_DC%type index by binary_integer;
	type tytbDATE_CLAUSE_PERMANENCE_DC is table of LD_SAMPLE_DETAI.DATE_CLAUSE_PERMANENCE_DC%type index by binary_integer;
	type tytbPAYMENT_DEADLINE_DC is table of LD_SAMPLE_DETAI.PAYMENT_DEADLINE_DC%type index by binary_integer;
	type tytbPAYMENT_DATE is table of LD_SAMPLE_DETAI.PAYMENT_DATE%type index by binary_integer;
	type tytbRADICATION_OFFICE_DC is table of LD_SAMPLE_DETAI.RADICATION_OFFICE_DC%type index by binary_integer;
	type tytbCITY_RADICATION_OFFICE_DC is table of LD_SAMPLE_DETAI.CITY_RADICATION_OFFICE_DC%type index by binary_integer;
	type tytbCITY_RADI_OFFI_DANE_COD_DC is table of LD_SAMPLE_DETAI.CITY_RADI_OFFI_DANE_COD_DC%type index by binary_integer;
	type tytbRESIDENTIAL_CITY_DC is table of LD_SAMPLE_DETAI.RESIDENTIAL_CITY_DC%type index by binary_integer;
	type tytbCITY_RESI_OFFI_DANE_COD_DC is table of LD_SAMPLE_DETAI.CITY_RESI_OFFI_DANE_COD_DC%type index by binary_integer;
	type tytbRESIDENTIAL_DEPARTMENT_DC is table of LD_SAMPLE_DETAI.RESIDENTIAL_DEPARTMENT_DC%type index by binary_integer;
	type tytbRESIDENTIAL_ADDRESS_DC is table of LD_SAMPLE_DETAI.RESIDENTIAL_ADDRESS_DC%type index by binary_integer;
	type tytbRESIDENTIAL_PHONE_DC is table of LD_SAMPLE_DETAI.RESIDENTIAL_PHONE_DC%type index by binary_integer;
	type tytbCITY_WORK_DC is table of LD_SAMPLE_DETAI.CITY_WORK_DC%type index by binary_integer;
	type tytbCITY_WORK_DANE_CODE_DC is table of LD_SAMPLE_DETAI.CITY_WORK_DANE_CODE_DC%type index by binary_integer;
	type tytbDEPARTMENT_WORK_DC is table of LD_SAMPLE_DETAI.DEPARTMENT_WORK_DC%type index by binary_integer;
	type tytbADDRESS_WORK_DC is table of LD_SAMPLE_DETAI.ADDRESS_WORK_DC%type index by binary_integer;
	type tytbPHONE_WORK_DC is table of LD_SAMPLE_DETAI.PHONE_WORK_DC%type index by binary_integer;
	type tytbCITY_CORRESPONDENCE_DC is table of LD_SAMPLE_DETAI.CITY_CORRESPONDENCE_DC%type index by binary_integer;
	type tytbDEPT_CORRESP_DC is table of LD_SAMPLE_DETAI.DEPARTMENT_CORRESPONDENCE_DC%type index by binary_integer;
	type tytbADDRESS_CORRESPONDENCE_DC is table of LD_SAMPLE_DETAI.ADDRESS_CORRESPONDENCE_DC%type index by binary_integer;
	type tytbEMAIL_DC is table of LD_SAMPLE_DETAI.EMAIL_DC%type index by binary_integer;
	type tytbDESTINATION_SUBSCRIBER_DC is table of LD_SAMPLE_DETAI.DESTINATION_SUBSCRIBER_DC%type index by binary_integer;
	type tytbCEL_PHONE_DC is table of LD_SAMPLE_DETAI.CEL_PHONE_DC%type index by binary_integer;
	type tytbCITY_CORRESP_DANE_CODE is table of LD_SAMPLE_DETAI.CITY_CORRESPONDENCE_DANE_CODE%type index by binary_integer;
	type tytbFILLER is table of LD_SAMPLE_DETAI.FILLER%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_SAMPLE_DETAI is record
	(
		NOTIFICATION   tytbNOTIFICATION,
		IS_APPROVED   tytbIS_APPROVED,
		SOURCE   tytbSOURCE,
		SUBSCRIBER_ID   tytbSUBSCRIBER_ID,
		PRODUCT_ID   tytbPRODUCT_ID,
		SUBSCRIPTION_ID   tytbSUBSCRIPTION_ID,
		SAMPLE_ID   tytbSAMPLE_ID,
		RESERVED_CF   tytbRESERVED_CF,
		BRANCH_CODE_CF   tytbBRANCH_CODE_CF,
		QUALITY_CF   tytbQUALITY_CF,
		RATINGS_CF   tytbRATINGS_CF,
		STATE_STATUS_HOLDER_CF   tytbSTATE_STATUS_HOLDER_CF,
		STATE_CF   tytbSTATE_CF,
		MORA_YEARS_CF   tytbMORA_YEARS_CF,
		STATEMENT_DATE_CF   tytbSTATEMENT_DATE_CF,
		INITIAL_ISSUE_DATE_CF   tytbINITIAL_ISSUE_DATE_CF,
		TERMINATION_DATE_CF   tytbTERMINATION_DATE_CF,
		DUE_DATE_CF   tytbDUE_DATE_CF,
		EXTICION_MODE_ID_CF   tytbEXTICION_MODE_ID_CF,
		TYPE_PAYMENT_CF   tytbTYPE_PAYMENT_CF,
		FIXED_CHARGE_VALUE_CF   tytbFIXED_CHARGE_VALUE_CF,
		CREDIT_LINE_CF   tytbCREDIT_LINE_CF,
		RESTRUCTURATED_OBLIGATION_CF   tytbRESTR_OBLIGATION_CF,
		NUMBER_OF_RESTRUCTURING_CF   tytbNUMBER_OF_RESTRUCTURING_CF,
		NUMBER_OF_RETURNED_CHECKS_CF   tytbNUMB_OF_RET_CHKS_CF,
		TERM_CF   tytbTERM_CF,
		DAYS_OF_PORTFOLIO_CF   tytbDAYS_OF_PORTFOLIO_CF,
		THIRD_HOUSE_ADDRESS_CF   tytbTHIRD_HOUSE_ADDRESS_CF,
		THIRD_HOME_PHONE_CF   tytbTHIRD_HOME_PHONE_CF,
		EVERY_CITY_CODE_CF   tytbEVERY_CITY_CODE_CF,
		TOWN_HOUSE_PARTY_CF   tytbTOWN_HOUSE_PARTY_CF,
		HOME_DEPARTMENT_CODE_CF   tytbHOME_DEPARTMENT_CODE_CF,
		DEPARTMENT_OF_THIRD_HOUSE_CF   tytbDEPT_OF_THIRD_HOU_CF,
		COMPANY_NAME_CF   tytbCOMPANY_NAME_CF,
		COMPANY_ADDRESS_CF   tytbCOMPANY_ADDRESS_CF,
		COMPANY_PHONE_CF   tytbCOMPANY_PHONE_CF,
		CITY_CODE_CF   tytbCITY_CODE_CF,
		NOW_CITY_OF_THIRD_CF   tytbNOW_CITY_OF_THIRD_CF,
		DEPARTAMENT_CODE_CF   tytbDEPARTAMENT_CODE_CF,
		THIRD_COMPANY_DEPARTMENT_CF   tytbTHIRD_COMP_DEPT_CF,
		NAT_RESTRUCTURING_CF   tytbNAT_RESTRUCTURING_CF,
		DETAIL_SAMPLE_ID   tytbDETAIL_SAMPLE_ID,
		LEGAL_NATURE   tytbLEGAL_NATURE,
		VALUE_OF_COLLATERAL   tytbVALUE_OF_COLLATERAL,
		SERVICE_CATEGORY   tytbSERVICE_CATEGORY,
		TYPE_OF_ACCOUNT   tytbTYPE_OF_ACCOUNT,
		SPACE_OVERDRAFT   tytbSPACE_OVERDRAFT,
		AUTHORIZED_DAYS   tytbAUTHORIZED_DAYS,
		DEFAULT_MORA_AGE_ID_CF   tytbDEFAULT_MORA_AGE_ID_CF,
		TYPE_PORTFOLIO_ID_CF   tytbTYPE_PORTFOLIO_ID_CF,
		NUMBER_MONTHS_CONTRACT_CF   tytbNUMBER_MONTHS_CONTRACT_CF,
		CREDIT_MODE   tytbCREDIT_MODE,
		NIVEL   tytbNIVEL,
		START_DATE_EXCENSION_GMF_CF   tytbST_DATE_EXCEN_GMF_CF,
		TERMINATION_DATE_EXC_GMF_CF   tytbTERMI_DATE_EXC_GMF_CF,
		NUMBER_OF_RENEWAL_CDT_CF   tytbNUMBER_OF_RENEWAL_CDT_CF,
		GMF_FREE_SAVINGS_CTA_CF   tytbGMF_FREE_SAVINGS_CTA_CF,
		NATIVE_TYPE_IDENTIFICATION_CF   tytbNATIVE_TYPE_IDENT_CF,
		IDENT_NUMBER_OF_NATIVE_CF   tytbIDENT_NUMBER_OF_NATIVE_CF,
		ENTITY_TYPE_NATIVE_CF   tytbENTITY_TYPE_NATIVE_CF,
		ENTITY_CODE_ORIGINATING_CF   tytbENTITY_CODE_ORIGINATING_CF,
		TYPE_OF_TRUST_CF   tytbTYPE_OF_TRUST_CF,
		NUMBER_OF_TRUST_CF   tytbNUMBER_OF_TRUST_CF,
		NAME_TRUST_CF   tytbNAME_TRUST_CF,
		TYPE_OF_DEBT_PORTFOLIO_CF   tytbTYPE_OF_DEBT_PORTFOLIO_CF,
		POLICY_TYPE_CF   tytbPOLICY_TYPE_CF,
		RAMIFICATION_CODE   tytbRAMIFICATION_CODE,
		DATE_OF_PRESCRIPTION   tytbDATE_OF_PRESCRIPTION,
		SCORE   tytbSCORE,
		TYPE_IDENTIFICATION_DC   tytbTYPE_IDENTIFICATION_DC,
		TYPE_IDENTIFICATION_CF   tytbTYPE_IDENTIFICATION_CF,
		IDENTIFICATION_NUMBER   tytbIDENTIFICATION_NUMBER,
		RECORD_TYPE_ID_CF   tytbRECORD_TYPE_ID_CF,
		FULL_NAME   tytbFULL_NAME,
		ACCOUNT_NUMBER   tytbACCOUNT_NUMBER,
		BRANCH_OFFICE_CF   tytbBRANCH_OFFICE_CF,
		SITUATION_HOLDER_DC   tytbSITUATION_HOLDER_DC,
		OPENING_DATE   tytbOPENING_DATE,
		DUE_DATE_DC   tytbDUE_DATE_DC,
		RESPONSIBLE_DC   tytbRESPONSIBLE_DC,
		TYPE_OBLIGATION_ID_DC   tytbTYPE_OBLIGATION_ID_DC,
		MORTGAGE_SUBSIDY_DC   tytbMORTGAGE_SUBSIDY_DC,
		DATE_SUBSIDY_DC   tytbDATE_SUBSIDY_DC,
		TYPE_CONTRACT_ID_CF   tytbTYPE_CONTRACT_ID_CF,
		STATE_OF_CONTRACT_CF   tytbSTATE_OF_CONTRACT_CF,
		TERM_CONTRACT_CF   tytbTERM_CONTRACT_CF,
		TERM_CONTRACT_DC   tytbTERM_CONTRACT_DC,
		METHOD_PAYMENT_ID_CF   tytbMETHOD_PAYMENT_ID_CF,
		METHOD_PAYMENT_ID_DC   tytbMETHOD_PAYMENT_ID_DC,
		PERIODICITY_ID_DC   tytbPERIODICITY_ID_DC,
		PERIODICITY_ID_CF   tytbPERIODICITY_ID_CF,
		NEW_PORTFOLIO_ID_DC   tytbNEW_PORTFOLIO_ID_DC,
		STATE_OBLIGATION_CF   tytbSTATE_OBLIGATION_CF,
		SITUATION_HOLDER_CF   tytbSITUATION_HOLDER_CF,
		ACCOUNT_STATE_ID_DC   tytbACCOUNT_STATE_ID_DC,
		DATE_STATUS_ORIGIN   tytbDATE_STATUS_ORIGIN,
		SOURCE_STATE_ID   tytbSOURCE_STATE_ID,
		DATE_STATUS_ACCOUNT   tytbDATE_STATUS_ACCOUNT,
		STATUS_PLASTIC_DC   tytbSTATUS_PLASTIC_DC,
		DATE_STATUS_PLASTIC_DC   tytbDATE_STATUS_PLASTIC_DC,
		ADJETIVE_DC   tytbADJETIVE_DC,
		DATE_ADJETIVE_DC   tytbDATE_ADJETIVE_DC,
		CARD_CLASS_DC   tytbCARD_CLASS_DC,
		FRANCHISE_DC   tytbFRANCHISE_DC,
		PRIVATE_BRAND_NAME_DC   tytbPRIVATE_BRAND_NAME_DC,
		TYPE_MONEY_DC   tytbTYPE_MONEY_DC,
		TYPE_WARRANTY_DC   tytbTYPE_WARRANTY_DC,
		RATINGS_DC   tytbRATINGS_DC,
		PROBABILITY_DEFAULT_DC   tytbPROBABILITY_DEFAULT_DC,
		MORA_AGE   tytbMORA_AGE,
		INITIAL_VALUES_DC   tytbINITIAL_VALUES_DC,
		DEBT_TO_DC   tytbDEBT_TO_DC,
		VALUE_AVAILABLE   tytbVALUE_AVAILABLE,
		MONTHLY_VALUE   tytbMONTHLY_VALUE,
		VALUE_DELAY   tytbVALUE_DELAY,
		TOTAL_SHARES   tytbTOTAL_SHARES,
		SHARES_CANCELED   tytbSHARES_CANCELED,
		SHARES_DEBT   tytbSHARES_DEBT,
		CLAUSE_PERMANENCE_DC   tytbCLAUSE_PERMANENCE_DC,
		DATE_CLAUSE_PERMANENCE_DC   tytbDATE_CLAUSE_PERMANENCE_DC,
		PAYMENT_DEADLINE_DC   tytbPAYMENT_DEADLINE_DC,
		PAYMENT_DATE   tytbPAYMENT_DATE,
		RADICATION_OFFICE_DC   tytbRADICATION_OFFICE_DC,
		CITY_RADICATION_OFFICE_DC   tytbCITY_RADICATION_OFFICE_DC,
		CITY_RADI_OFFI_DANE_COD_DC   tytbCITY_RADI_OFFI_DANE_COD_DC,
		RESIDENTIAL_CITY_DC   tytbRESIDENTIAL_CITY_DC,
		CITY_RESI_OFFI_DANE_COD_DC   tytbCITY_RESI_OFFI_DANE_COD_DC,
		RESIDENTIAL_DEPARTMENT_DC   tytbRESIDENTIAL_DEPARTMENT_DC,
		RESIDENTIAL_ADDRESS_DC   tytbRESIDENTIAL_ADDRESS_DC,
		RESIDENTIAL_PHONE_DC   tytbRESIDENTIAL_PHONE_DC,
		CITY_WORK_DC   tytbCITY_WORK_DC,
		CITY_WORK_DANE_CODE_DC   tytbCITY_WORK_DANE_CODE_DC,
		DEPARTMENT_WORK_DC   tytbDEPARTMENT_WORK_DC,
		ADDRESS_WORK_DC   tytbADDRESS_WORK_DC,
		PHONE_WORK_DC   tytbPHONE_WORK_DC,
		CITY_CORRESPONDENCE_DC   tytbCITY_CORRESPONDENCE_DC,
		DEPARTMENT_CORRESPONDENCE_DC   tytbDEPT_CORRESP_DC,
		ADDRESS_CORRESPONDENCE_DC   tytbADDRESS_CORRESPONDENCE_DC,
		EMAIL_DC   tytbEMAIL_DC,
		DESTINATION_SUBSCRIBER_DC   tytbDESTINATION_SUBSCRIBER_DC,
		CEL_PHONE_DC   tytbCEL_PHONE_DC,
		CITY_CORRESPONDENCE_DANE_CODE   tytbCITY_CORRESP_DANE_CODE,
		FILLER   tytbFILLER,
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
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type
	);

	PROCEDURE getRecord
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		orcRecord out nocopy styLD_SAMPLE_DETAI
	);

	FUNCTION frcGetRcData
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type
	)
	RETURN styLD_SAMPLE_DETAI;

	FUNCTION frcGetRcData
	RETURN styLD_SAMPLE_DETAI;

	FUNCTION frcGetRecord
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type
	)
	RETURN styLD_SAMPLE_DETAI;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_SAMPLE_DETAI
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_SAMPLE_DETAI in styLD_SAMPLE_DETAI
	);

	PROCEDURE insRecord
	(
		ircLD_SAMPLE_DETAI in styLD_SAMPLE_DETAI,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_SAMPLE_DETAI in out nocopy tytbLD_SAMPLE_DETAI
	);

	PROCEDURE delRecord
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_SAMPLE_DETAI in out nocopy tytbLD_SAMPLE_DETAI,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_SAMPLE_DETAI in styLD_SAMPLE_DETAI,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_SAMPLE_DETAI in out nocopy tytbLD_SAMPLE_DETAI,
		inuLock in number default 1
	);

	PROCEDURE updNOTIFICATION
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbNOTIFICATION$ in LD_SAMPLE_DETAI.NOTIFICATION%type,
		inuLock in number default 0
	);

	PROCEDURE updIS_APPROVED
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbIS_APPROVED$ in LD_SAMPLE_DETAI.IS_APPROVED%type,
		inuLock in number default 0
	);

	PROCEDURE updSOURCE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbSOURCE$ in LD_SAMPLE_DETAI.SOURCE%type,
		inuLock in number default 0
	);

	PROCEDURE updSUBSCRIBER_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSUBSCRIBER_ID$ in LD_SAMPLE_DETAI.SUBSCRIBER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPRODUCT_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuPRODUCT_ID$ in LD_SAMPLE_DETAI.PRODUCT_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updSUBSCRIPTION_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSUBSCRIPTION_ID$ in LD_SAMPLE_DETAI.SUBSCRIPTION_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updRESERVED_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRESERVED_CF$ in LD_SAMPLE_DETAI.RESERVED_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updBRANCH_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbBRANCH_CODE_CF$ in LD_SAMPLE_DETAI.BRANCH_CODE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updQUALITY_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbQUALITY_CF$ in LD_SAMPLE_DETAI.QUALITY_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updRATINGS_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbRATINGS_CF$ in LD_SAMPLE_DETAI.RATINGS_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updSTATE_STATUS_HOLDER_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbSTATE_STATUS_HOLDER_CF$ in LD_SAMPLE_DETAI.STATE_STATUS_HOLDER_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updSTATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSTATE_CF$ in LD_SAMPLE_DETAI.STATE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updMORA_YEARS_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuMORA_YEARS_CF$ in LD_SAMPLE_DETAI.MORA_YEARS_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updSTATEMENT_DATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		idtSTATEMENT_DATE_CF$ in LD_SAMPLE_DETAI.STATEMENT_DATE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updINITIAL_ISSUE_DATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuINITIAL_ISSUE_DATE_CF$ in LD_SAMPLE_DETAI.INITIAL_ISSUE_DATE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updTERMINATION_DATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTERMINATION_DATE_CF$ in LD_SAMPLE_DETAI.TERMINATION_DATE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updDUE_DATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDUE_DATE_CF$ in LD_SAMPLE_DETAI.DUE_DATE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updEXTICION_MODE_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuEXTICION_MODE_ID_CF$ in LD_SAMPLE_DETAI.EXTICION_MODE_ID_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_PAYMENT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTYPE_PAYMENT_CF$ in LD_SAMPLE_DETAI.TYPE_PAYMENT_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updFIXED_CHARGE_VALUE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuFIXED_CHARGE_VALUE_CF$ in LD_SAMPLE_DETAI.FIXED_CHARGE_VALUE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updCREDIT_LINE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuCREDIT_LINE_CF$ in LD_SAMPLE_DETAI.CREDIT_LINE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updTERM_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTERM_CF$ in LD_SAMPLE_DETAI.TERM_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updDAYS_OF_PORTFOLIO_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDAYS_OF_PORTFOLIO_CF$ in LD_SAMPLE_DETAI.DAYS_OF_PORTFOLIO_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updTHIRD_HOUSE_ADDRESS_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbTHIRD_HOUSE_ADDRESS_CF$ in LD_SAMPLE_DETAI.THIRD_HOUSE_ADDRESS_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updTHIRD_HOME_PHONE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbTHIRD_HOME_PHONE_CF$ in LD_SAMPLE_DETAI.THIRD_HOME_PHONE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updEVERY_CITY_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuEVERY_CITY_CODE_CF$ in LD_SAMPLE_DETAI.EVERY_CITY_CODE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updTOWN_HOUSE_PARTY_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbTOWN_HOUSE_PARTY_CF$ in LD_SAMPLE_DETAI.TOWN_HOUSE_PARTY_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updHOME_DEPARTMENT_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuHOME_DEPARTMENT_CODE_CF$ in LD_SAMPLE_DETAI.HOME_DEPARTMENT_CODE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updCOMPANY_NAME_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbCOMPANY_NAME_CF$ in LD_SAMPLE_DETAI.COMPANY_NAME_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updCOMPANY_ADDRESS_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbCOMPANY_ADDRESS_CF$ in LD_SAMPLE_DETAI.COMPANY_ADDRESS_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updCOMPANY_PHONE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuCOMPANY_PHONE_CF$ in LD_SAMPLE_DETAI.COMPANY_PHONE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updCITY_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuCITY_CODE_CF$ in LD_SAMPLE_DETAI.CITY_CODE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updNOW_CITY_OF_THIRD_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbNOW_CITY_OF_THIRD_CF$ in LD_SAMPLE_DETAI.NOW_CITY_OF_THIRD_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updDEPARTAMENT_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDEPARTAMENT_CODE_CF$ in LD_SAMPLE_DETAI.DEPARTAMENT_CODE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updNAT_RESTRUCTURING_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuNAT_RESTRUCTURING_CF$ in LD_SAMPLE_DETAI.NAT_RESTRUCTURING_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updLEGAL_NATURE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbLEGAL_NATURE$ in LD_SAMPLE_DETAI.LEGAL_NATURE%type,
		inuLock in number default 0
	);

	PROCEDURE updVALUE_OF_COLLATERAL
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbVALUE_OF_COLLATERAL$ in LD_SAMPLE_DETAI.VALUE_OF_COLLATERAL%type,
		inuLock in number default 0
	);

	PROCEDURE updSERVICE_CATEGORY
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbSERVICE_CATEGORY$ in LD_SAMPLE_DETAI.SERVICE_CATEGORY%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_OF_ACCOUNT
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTYPE_OF_ACCOUNT$ in LD_SAMPLE_DETAI.TYPE_OF_ACCOUNT%type,
		inuLock in number default 0
	);

	PROCEDURE updSPACE_OVERDRAFT
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSPACE_OVERDRAFT$ in LD_SAMPLE_DETAI.SPACE_OVERDRAFT%type,
		inuLock in number default 0
	);

	PROCEDURE updAUTHORIZED_DAYS
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuAUTHORIZED_DAYS$ in LD_SAMPLE_DETAI.AUTHORIZED_DAYS%type,
		inuLock in number default 0
	);

	PROCEDURE updDEFAULT_MORA_AGE_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDEFAULT_MORA_AGE_ID_CF$ in LD_SAMPLE_DETAI.DEFAULT_MORA_AGE_ID_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_PORTFOLIO_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTYPE_PORTFOLIO_ID_CF$ in LD_SAMPLE_DETAI.TYPE_PORTFOLIO_ID_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updNUMBER_MONTHS_CONTRACT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuNUMBER_MONTHS_CONTRACT_CF$ in LD_SAMPLE_DETAI.NUMBER_MONTHS_CONTRACT_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updCREDIT_MODE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbCREDIT_MODE$ in LD_SAMPLE_DETAI.CREDIT_MODE%type,
		inuLock in number default 0
	);

	PROCEDURE updNIVEL
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbNIVEL$ in LD_SAMPLE_DETAI.NIVEL%type,
		inuLock in number default 0
	);

	PROCEDURE updNUMBER_OF_RENEWAL_CDT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbNUMBER_OF_RENEWAL_CDT_CF$ in LD_SAMPLE_DETAI.NUMBER_OF_RENEWAL_CDT_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updGMF_FREE_SAVINGS_CTA_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbGMF_FREE_SAVINGS_CTA_CF$ in LD_SAMPLE_DETAI.GMF_FREE_SAVINGS_CTA_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updIDENT_NUMBER_OF_NATIVE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbIDENT_NUMBER_OF_NATIVE_CF$ in LD_SAMPLE_DETAI.IDENT_NUMBER_OF_NATIVE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updENTITY_TYPE_NATIVE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbENTITY_TYPE_NATIVE_CF$ in LD_SAMPLE_DETAI.ENTITY_TYPE_NATIVE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_OF_TRUST_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbTYPE_OF_TRUST_CF$ in LD_SAMPLE_DETAI.TYPE_OF_TRUST_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updNUMBER_OF_TRUST_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbNUMBER_OF_TRUST_CF$ in LD_SAMPLE_DETAI.NUMBER_OF_TRUST_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updNAME_TRUST_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbNAME_TRUST_CF$ in LD_SAMPLE_DETAI.NAME_TRUST_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_OF_DEBT_PORTFOLIO_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbTYPE_OF_DEBT_PORTFOLIO_CF$ in LD_SAMPLE_DETAI.TYPE_OF_DEBT_PORTFOLIO_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updPOLICY_TYPE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbPOLICY_TYPE_CF$ in LD_SAMPLE_DETAI.POLICY_TYPE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updRAMIFICATION_CODE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbRAMIFICATION_CODE$ in LD_SAMPLE_DETAI.RAMIFICATION_CODE%type,
		inuLock in number default 0
	);

	PROCEDURE updDATE_OF_PRESCRIPTION
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDATE_OF_PRESCRIPTION$ in LD_SAMPLE_DETAI.DATE_OF_PRESCRIPTION%type,
		inuLock in number default 0
	);

	PROCEDURE updSCORE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbSCORE$ in LD_SAMPLE_DETAI.SCORE%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_IDENTIFICATION_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTYPE_IDENTIFICATION_DC$ in LD_SAMPLE_DETAI.TYPE_IDENTIFICATION_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_IDENTIFICATION_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTYPE_IDENTIFICATION_CF$ in LD_SAMPLE_DETAI.TYPE_IDENTIFICATION_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updIDENTIFICATION_NUMBER
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbIDENTIFICATION_NUMBER$ in LD_SAMPLE_DETAI.IDENTIFICATION_NUMBER%type,
		inuLock in number default 0
	);

	PROCEDURE updRECORD_TYPE_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRECORD_TYPE_ID_CF$ in LD_SAMPLE_DETAI.RECORD_TYPE_ID_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updFULL_NAME
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbFULL_NAME$ in LD_SAMPLE_DETAI.FULL_NAME%type,
		inuLock in number default 0
	);

	PROCEDURE updACCOUNT_NUMBER
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbACCOUNT_NUMBER$ in LD_SAMPLE_DETAI.ACCOUNT_NUMBER%type,
		inuLock in number default 0
	);

	PROCEDURE updBRANCH_OFFICE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbBRANCH_OFFICE_CF$ in LD_SAMPLE_DETAI.BRANCH_OFFICE_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updSITUATION_HOLDER_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSITUATION_HOLDER_DC$ in LD_SAMPLE_DETAI.SITUATION_HOLDER_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updOPENING_DATE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuOPENING_DATE$ in LD_SAMPLE_DETAI.OPENING_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updDUE_DATE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDUE_DATE_DC$ in LD_SAMPLE_DETAI.DUE_DATE_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updRESPONSIBLE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRESPONSIBLE_DC$ in LD_SAMPLE_DETAI.RESPONSIBLE_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_OBLIGATION_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTYPE_OBLIGATION_ID_DC$ in LD_SAMPLE_DETAI.TYPE_OBLIGATION_ID_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updMORTGAGE_SUBSIDY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuMORTGAGE_SUBSIDY_DC$ in LD_SAMPLE_DETAI.MORTGAGE_SUBSIDY_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updDATE_SUBSIDY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDATE_SUBSIDY_DC$ in LD_SAMPLE_DETAI.DATE_SUBSIDY_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_CONTRACT_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbTYPE_CONTRACT_ID_CF$ in LD_SAMPLE_DETAI.TYPE_CONTRACT_ID_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updSTATE_OF_CONTRACT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSTATE_OF_CONTRACT_CF$ in LD_SAMPLE_DETAI.STATE_OF_CONTRACT_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updTERM_CONTRACT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTERM_CONTRACT_CF$ in LD_SAMPLE_DETAI.TERM_CONTRACT_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updTERM_CONTRACT_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTERM_CONTRACT_DC$ in LD_SAMPLE_DETAI.TERM_CONTRACT_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updMETHOD_PAYMENT_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuMETHOD_PAYMENT_ID_CF$ in LD_SAMPLE_DETAI.METHOD_PAYMENT_ID_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updMETHOD_PAYMENT_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuMETHOD_PAYMENT_ID_DC$ in LD_SAMPLE_DETAI.METHOD_PAYMENT_ID_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updPERIODICITY_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuPERIODICITY_ID_DC$ in LD_SAMPLE_DETAI.PERIODICITY_ID_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updPERIODICITY_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuPERIODICITY_ID_CF$ in LD_SAMPLE_DETAI.PERIODICITY_ID_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updNEW_PORTFOLIO_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuNEW_PORTFOLIO_ID_DC$ in LD_SAMPLE_DETAI.NEW_PORTFOLIO_ID_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updSTATE_OBLIGATION_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSTATE_OBLIGATION_CF$ in LD_SAMPLE_DETAI.STATE_OBLIGATION_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updSITUATION_HOLDER_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSITUATION_HOLDER_CF$ in LD_SAMPLE_DETAI.SITUATION_HOLDER_CF%type,
		inuLock in number default 0
	);

	PROCEDURE updACCOUNT_STATE_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuACCOUNT_STATE_ID_DC$ in LD_SAMPLE_DETAI.ACCOUNT_STATE_ID_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updDATE_STATUS_ORIGIN
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDATE_STATUS_ORIGIN$ in LD_SAMPLE_DETAI.DATE_STATUS_ORIGIN%type,
		inuLock in number default 0
	);

	PROCEDURE updSOURCE_STATE_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSOURCE_STATE_ID$ in LD_SAMPLE_DETAI.SOURCE_STATE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updDATE_STATUS_ACCOUNT
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDATE_STATUS_ACCOUNT$ in LD_SAMPLE_DETAI.DATE_STATUS_ACCOUNT%type,
		inuLock in number default 0
	);

	PROCEDURE updSTATUS_PLASTIC_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSTATUS_PLASTIC_DC$ in LD_SAMPLE_DETAI.STATUS_PLASTIC_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updDATE_STATUS_PLASTIC_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDATE_STATUS_PLASTIC_DC$ in LD_SAMPLE_DETAI.DATE_STATUS_PLASTIC_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updADJETIVE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuADJETIVE_DC$ in LD_SAMPLE_DETAI.ADJETIVE_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updDATE_ADJETIVE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDATE_ADJETIVE_DC$ in LD_SAMPLE_DETAI.DATE_ADJETIVE_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updCARD_CLASS_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuCARD_CLASS_DC$ in LD_SAMPLE_DETAI.CARD_CLASS_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updFRANCHISE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuFRANCHISE_DC$ in LD_SAMPLE_DETAI.FRANCHISE_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updPRIVATE_BRAND_NAME_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbPRIVATE_BRAND_NAME_DC$ in LD_SAMPLE_DETAI.PRIVATE_BRAND_NAME_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_MONEY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTYPE_MONEY_DC$ in LD_SAMPLE_DETAI.TYPE_MONEY_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updTYPE_WARRANTY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTYPE_WARRANTY_DC$ in LD_SAMPLE_DETAI.TYPE_WARRANTY_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updRATINGS_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbRATINGS_DC$ in LD_SAMPLE_DETAI.RATINGS_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updPROBABILITY_DEFAULT_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuPROBABILITY_DEFAULT_DC$ in LD_SAMPLE_DETAI.PROBABILITY_DEFAULT_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updMORA_AGE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuMORA_AGE$ in LD_SAMPLE_DETAI.MORA_AGE%type,
		inuLock in number default 0
	);

	PROCEDURE updINITIAL_VALUES_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuINITIAL_VALUES_DC$ in LD_SAMPLE_DETAI.INITIAL_VALUES_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updDEBT_TO_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDEBT_TO_DC$ in LD_SAMPLE_DETAI.DEBT_TO_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updVALUE_AVAILABLE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuVALUE_AVAILABLE$ in LD_SAMPLE_DETAI.VALUE_AVAILABLE%type,
		inuLock in number default 0
	);

	PROCEDURE updMONTHLY_VALUE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuMONTHLY_VALUE$ in LD_SAMPLE_DETAI.MONTHLY_VALUE%type,
		inuLock in number default 0
	);

	PROCEDURE updVALUE_DELAY
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuVALUE_DELAY$ in LD_SAMPLE_DETAI.VALUE_DELAY%type,
		inuLock in number default 0
	);

	PROCEDURE updTOTAL_SHARES
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTOTAL_SHARES$ in LD_SAMPLE_DETAI.TOTAL_SHARES%type,
		inuLock in number default 0
	);

	PROCEDURE updSHARES_CANCELED
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSHARES_CANCELED$ in LD_SAMPLE_DETAI.SHARES_CANCELED%type,
		inuLock in number default 0
	);

	PROCEDURE updSHARES_DEBT
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSHARES_DEBT$ in LD_SAMPLE_DETAI.SHARES_DEBT%type,
		inuLock in number default 0
	);

	PROCEDURE updCLAUSE_PERMANENCE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuCLAUSE_PERMANENCE_DC$ in LD_SAMPLE_DETAI.CLAUSE_PERMANENCE_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updDATE_CLAUSE_PERMANENCE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDATE_CLAUSE_PERMANENCE_DC$ in LD_SAMPLE_DETAI.DATE_CLAUSE_PERMANENCE_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updPAYMENT_DEADLINE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuPAYMENT_DEADLINE_DC$ in LD_SAMPLE_DETAI.PAYMENT_DEADLINE_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updPAYMENT_DATE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuPAYMENT_DATE$ in LD_SAMPLE_DETAI.PAYMENT_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updRADICATION_OFFICE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbRADICATION_OFFICE_DC$ in LD_SAMPLE_DETAI.RADICATION_OFFICE_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updCITY_RADICATION_OFFICE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbCITY_RADICATION_OFFICE_DC$ in LD_SAMPLE_DETAI.CITY_RADICATION_OFFICE_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updRESIDENTIAL_CITY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbRESIDENTIAL_CITY_DC$ in LD_SAMPLE_DETAI.RESIDENTIAL_CITY_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updRESIDENTIAL_DEPARTMENT_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbRESIDENTIAL_DEPARTMENT_DC$ in LD_SAMPLE_DETAI.RESIDENTIAL_DEPARTMENT_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updRESIDENTIAL_ADDRESS_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbRESIDENTIAL_ADDRESS_DC$ in LD_SAMPLE_DETAI.RESIDENTIAL_ADDRESS_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updRESIDENTIAL_PHONE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRESIDENTIAL_PHONE_DC$ in LD_SAMPLE_DETAI.RESIDENTIAL_PHONE_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updCITY_WORK_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbCITY_WORK_DC$ in LD_SAMPLE_DETAI.CITY_WORK_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updCITY_WORK_DANE_CODE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuCITY_WORK_DANE_CODE_DC$ in LD_SAMPLE_DETAI.CITY_WORK_DANE_CODE_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updDEPARTMENT_WORK_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbDEPARTMENT_WORK_DC$ in LD_SAMPLE_DETAI.DEPARTMENT_WORK_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updADDRESS_WORK_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbADDRESS_WORK_DC$ in LD_SAMPLE_DETAI.ADDRESS_WORK_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updPHONE_WORK_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuPHONE_WORK_DC$ in LD_SAMPLE_DETAI.PHONE_WORK_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updCITY_CORRESPONDENCE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbCITY_CORRESPONDENCE_DC$ in LD_SAMPLE_DETAI.CITY_CORRESPONDENCE_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updADDRESS_CORRESPONDENCE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbADDRESS_CORRESPONDENCE_DC$ in LD_SAMPLE_DETAI.ADDRESS_CORRESPONDENCE_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updEMAIL_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbEMAIL_DC$ in LD_SAMPLE_DETAI.EMAIL_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updDESTINATION_SUBSCRIBER_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDESTINATION_SUBSCRIBER_DC$ in LD_SAMPLE_DETAI.DESTINATION_SUBSCRIBER_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updCEL_PHONE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuCEL_PHONE_DC$ in LD_SAMPLE_DETAI.CEL_PHONE_DC%type,
		inuLock in number default 0
	);

	PROCEDURE updFILLER
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbFILLER$ in LD_SAMPLE_DETAI.FILLER%type,
		inuLock in number default 0
	);

	FUNCTION fsbGetNOTIFICATION
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.NOTIFICATION%type;

	FUNCTION fsbGetIS_APPROVED
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.IS_APPROVED%type;

	FUNCTION fsbGetSOURCE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SOURCE%type;

	FUNCTION fnuGetSUBSCRIBER_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SUBSCRIBER_ID%type;

	FUNCTION fnuGetPRODUCT_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.PRODUCT_ID%type;

	FUNCTION fnuGetSUBSCRIPTION_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SUBSCRIPTION_ID%type;

	FUNCTION fnuGetSAMPLE_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SAMPLE_ID%type;

	FUNCTION fnuGetRESERVED_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RESERVED_CF%type;

	FUNCTION fsbGetBRANCH_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.BRANCH_CODE_CF%type;

	FUNCTION fsbGetQUALITY_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.QUALITY_CF%type;

	FUNCTION fsbGetRATINGS_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RATINGS_CF%type;

	FUNCTION fsbGetSTATE_STATUS_HOLDER_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.STATE_STATUS_HOLDER_CF%type;

	FUNCTION fnuGetSTATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.STATE_CF%type;

	FUNCTION fnuGetMORA_YEARS_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.MORA_YEARS_CF%type;

	FUNCTION fdtGetSTATEMENT_DATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.STATEMENT_DATE_CF%type;

	FUNCTION fnuGetINITIAL_ISSUE_DATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.INITIAL_ISSUE_DATE_CF%type;

	FUNCTION fnuGetTERMINATION_DATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TERMINATION_DATE_CF%type;

	FUNCTION fnuGetDUE_DATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DUE_DATE_CF%type;

	FUNCTION fnuGetEXTICION_MODE_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.EXTICION_MODE_ID_CF%type;

	FUNCTION fnuGetTYPE_PAYMENT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_PAYMENT_CF%type;

	FUNCTION fnuGetFIXED_CHARGE_VALUE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.FIXED_CHARGE_VALUE_CF%type;

	FUNCTION fnuGetCREDIT_LINE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CREDIT_LINE_CF%type;

	FUNCTION fnuGetTERM_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TERM_CF%type;

	FUNCTION fnuGetDAYS_OF_PORTFOLIO_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DAYS_OF_PORTFOLIO_CF%type;

	FUNCTION fsbGetTHIRD_HOUSE_ADDRESS_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.THIRD_HOUSE_ADDRESS_CF%type;

	FUNCTION fsbGetTHIRD_HOME_PHONE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.THIRD_HOME_PHONE_CF%type;

	FUNCTION fnuGetEVERY_CITY_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.EVERY_CITY_CODE_CF%type;

	FUNCTION fsbGetTOWN_HOUSE_PARTY_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TOWN_HOUSE_PARTY_CF%type;

	FUNCTION fnuGetHOME_DEPARTMENT_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.HOME_DEPARTMENT_CODE_CF%type;

	FUNCTION fsbGetCOMPANY_NAME_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.COMPANY_NAME_CF%type;

	FUNCTION fsbGetCOMPANY_ADDRESS_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.COMPANY_ADDRESS_CF%type;

	FUNCTION fnuGetCOMPANY_PHONE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.COMPANY_PHONE_CF%type;

	FUNCTION fnuGetCITY_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CITY_CODE_CF%type;

	FUNCTION fsbGetNOW_CITY_OF_THIRD_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.NOW_CITY_OF_THIRD_CF%type;

	FUNCTION fnuGetDEPARTAMENT_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DEPARTAMENT_CODE_CF%type;

	FUNCTION fnuGetNAT_RESTRUCTURING_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.NAT_RESTRUCTURING_CF%type;

	FUNCTION fnuGetDETAIL_SAMPLE_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type;

	FUNCTION fsbGetLEGAL_NATURE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.LEGAL_NATURE%type;

	FUNCTION fsbGetVALUE_OF_COLLATERAL
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.VALUE_OF_COLLATERAL%type;

	FUNCTION fsbGetSERVICE_CATEGORY
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SERVICE_CATEGORY%type;

	FUNCTION fnuGetTYPE_OF_ACCOUNT
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_OF_ACCOUNT%type;

	FUNCTION fnuGetSPACE_OVERDRAFT
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SPACE_OVERDRAFT%type;

	FUNCTION fnuGetAUTHORIZED_DAYS
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.AUTHORIZED_DAYS%type;

	FUNCTION fnuGetDEFAULT_MORA_AGE_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DEFAULT_MORA_AGE_ID_CF%type;

	FUNCTION fnuGetTYPE_PORTFOLIO_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_PORTFOLIO_ID_CF%type;

	FUNCTION fsbGetCREDIT_MODE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CREDIT_MODE%type;

	FUNCTION fsbGetNIVEL
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.NIVEL%type;

	FUNCTION fsbGetNUMBER_OF_RENEWAL_CDT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.NUMBER_OF_RENEWAL_CDT_CF%type;

	FUNCTION fsbGetGMF_FREE_SAVINGS_CTA_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.GMF_FREE_SAVINGS_CTA_CF%type;

	FUNCTION fsbGetENTITY_TYPE_NATIVE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.ENTITY_TYPE_NATIVE_CF%type;

	FUNCTION fsbGetTYPE_OF_TRUST_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_OF_TRUST_CF%type;

	FUNCTION fsbGetNUMBER_OF_TRUST_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.NUMBER_OF_TRUST_CF%type;

	FUNCTION fsbGetNAME_TRUST_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.NAME_TRUST_CF%type;

	FUNCTION fsbGetPOLICY_TYPE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.POLICY_TYPE_CF%type;

	FUNCTION fsbGetRAMIFICATION_CODE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RAMIFICATION_CODE%type;

	FUNCTION fnuGetDATE_OF_PRESCRIPTION
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DATE_OF_PRESCRIPTION%type;

	FUNCTION fsbGetSCORE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SCORE%type;

	FUNCTION fnuGetTYPE_IDENTIFICATION_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_IDENTIFICATION_DC%type;

	FUNCTION fnuGetTYPE_IDENTIFICATION_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_IDENTIFICATION_CF%type;

	FUNCTION fsbGetIDENTIFICATION_NUMBER
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.IDENTIFICATION_NUMBER%type;

	FUNCTION fnuGetRECORD_TYPE_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RECORD_TYPE_ID_CF%type;

	FUNCTION fsbGetFULL_NAME
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.FULL_NAME%type;

	FUNCTION fsbGetACCOUNT_NUMBER
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.ACCOUNT_NUMBER%type;

	FUNCTION fsbGetBRANCH_OFFICE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.BRANCH_OFFICE_CF%type;

	FUNCTION fnuGetSITUATION_HOLDER_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SITUATION_HOLDER_DC%type;

	FUNCTION fnuGetOPENING_DATE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.OPENING_DATE%type;

	FUNCTION fnuGetDUE_DATE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DUE_DATE_DC%type;

	FUNCTION fnuGetRESPONSIBLE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RESPONSIBLE_DC%type;

	FUNCTION fnuGetTYPE_OBLIGATION_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_OBLIGATION_ID_DC%type;

	FUNCTION fnuGetMORTGAGE_SUBSIDY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.MORTGAGE_SUBSIDY_DC%type;

	FUNCTION fnuGetDATE_SUBSIDY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DATE_SUBSIDY_DC%type;

	FUNCTION fsbGetTYPE_CONTRACT_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_CONTRACT_ID_CF%type;

	FUNCTION fnuGetSTATE_OF_CONTRACT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.STATE_OF_CONTRACT_CF%type;

	FUNCTION fnuGetTERM_CONTRACT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TERM_CONTRACT_CF%type;

	FUNCTION fnuGetTERM_CONTRACT_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TERM_CONTRACT_DC%type;

	FUNCTION fnuGetMETHOD_PAYMENT_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.METHOD_PAYMENT_ID_CF%type;

	FUNCTION fnuGetMETHOD_PAYMENT_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.METHOD_PAYMENT_ID_DC%type;

	FUNCTION fnuGetPERIODICITY_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.PERIODICITY_ID_DC%type;

	FUNCTION fnuGetPERIODICITY_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.PERIODICITY_ID_CF%type;

	FUNCTION fnuGetNEW_PORTFOLIO_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.NEW_PORTFOLIO_ID_DC%type;

	FUNCTION fnuGetSTATE_OBLIGATION_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.STATE_OBLIGATION_CF%type;

	FUNCTION fnuGetSITUATION_HOLDER_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SITUATION_HOLDER_CF%type;

	FUNCTION fnuGetACCOUNT_STATE_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.ACCOUNT_STATE_ID_DC%type;

	FUNCTION fnuGetDATE_STATUS_ORIGIN
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DATE_STATUS_ORIGIN%type;

	FUNCTION fnuGetSOURCE_STATE_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SOURCE_STATE_ID%type;

	FUNCTION fnuGetDATE_STATUS_ACCOUNT
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DATE_STATUS_ACCOUNT%type;

	FUNCTION fnuGetSTATUS_PLASTIC_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.STATUS_PLASTIC_DC%type;

	FUNCTION fnuGetDATE_STATUS_PLASTIC_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DATE_STATUS_PLASTIC_DC%type;

	FUNCTION fnuGetADJETIVE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.ADJETIVE_DC%type;

	FUNCTION fnuGetDATE_ADJETIVE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DATE_ADJETIVE_DC%type;

	FUNCTION fnuGetCARD_CLASS_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CARD_CLASS_DC%type;

	FUNCTION fnuGetFRANCHISE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.FRANCHISE_DC%type;

	FUNCTION fsbGetPRIVATE_BRAND_NAME_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.PRIVATE_BRAND_NAME_DC%type;

	FUNCTION fnuGetTYPE_MONEY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_MONEY_DC%type;

	FUNCTION fnuGetTYPE_WARRANTY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_WARRANTY_DC%type;

	FUNCTION fsbGetRATINGS_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RATINGS_DC%type;

	FUNCTION fnuGetPROBABILITY_DEFAULT_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.PROBABILITY_DEFAULT_DC%type;

	FUNCTION fnuGetMORA_AGE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.MORA_AGE%type;

	FUNCTION fnuGetINITIAL_VALUES_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.INITIAL_VALUES_DC%type;

	FUNCTION fnuGetDEBT_TO_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DEBT_TO_DC%type;

	FUNCTION fnuGetVALUE_AVAILABLE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.VALUE_AVAILABLE%type;

	FUNCTION fnuGetMONTHLY_VALUE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.MONTHLY_VALUE%type;

	FUNCTION fnuGetVALUE_DELAY
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.VALUE_DELAY%type;

	FUNCTION fnuGetTOTAL_SHARES
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TOTAL_SHARES%type;

	FUNCTION fnuGetSHARES_CANCELED
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SHARES_CANCELED%type;

	FUNCTION fnuGetSHARES_DEBT
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SHARES_DEBT%type;

	FUNCTION fnuGetCLAUSE_PERMANENCE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CLAUSE_PERMANENCE_DC%type;

	FUNCTION fnuGetPAYMENT_DEADLINE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.PAYMENT_DEADLINE_DC%type;

	FUNCTION fnuGetPAYMENT_DATE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.PAYMENT_DATE%type;

	FUNCTION fsbGetRADICATION_OFFICE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RADICATION_OFFICE_DC%type;

	FUNCTION fsbGetRESIDENTIAL_CITY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RESIDENTIAL_CITY_DC%type;

	FUNCTION fsbGetRESIDENTIAL_ADDRESS_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RESIDENTIAL_ADDRESS_DC%type;

	FUNCTION fnuGetRESIDENTIAL_PHONE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RESIDENTIAL_PHONE_DC%type;

	FUNCTION fsbGetCITY_WORK_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CITY_WORK_DC%type;

	FUNCTION fnuGetCITY_WORK_DANE_CODE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CITY_WORK_DANE_CODE_DC%type;

	FUNCTION fsbGetDEPARTMENT_WORK_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DEPARTMENT_WORK_DC%type;

	FUNCTION fsbGetADDRESS_WORK_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.ADDRESS_WORK_DC%type;

	FUNCTION fnuGetPHONE_WORK_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.PHONE_WORK_DC%type;

	FUNCTION fsbGetCITY_CORRESPONDENCE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CITY_CORRESPONDENCE_DC%type;

	FUNCTION fsbGetEMAIL_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.EMAIL_DC%type;

	FUNCTION fnuGetCEL_PHONE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CEL_PHONE_DC%type;

	FUNCTION fsbGetFILLER
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.FILLER%type;


	PROCEDURE LockByPk
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		orcLD_SAMPLE_DETAI  out styLD_SAMPLE_DETAI
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_SAMPLE_DETAI  out styLD_SAMPLE_DETAI
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_SAMPLE_DETAI;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_SAMPLE_DETAI
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO193378';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SAMPLE_DETAI';
	 cnuGeEntityId constant varchar2(30) := 8478; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type
	)
	IS
		SELECT LD_SAMPLE_DETAI.*,LD_SAMPLE_DETAI.rowid
		FROM LD_SAMPLE_DETAI
		WHERE  DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID
			and SAMPLE_ID = inuSAMPLE_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_SAMPLE_DETAI.*,LD_SAMPLE_DETAI.rowid
		FROM LD_SAMPLE_DETAI
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_SAMPLE_DETAI is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_SAMPLE_DETAI;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_SAMPLE_DETAI default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.DETAIL_SAMPLE_ID);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.SAMPLE_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		orcLD_SAMPLE_DETAI  out styLD_SAMPLE_DETAI
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

		Open cuLockRcByPk
		(
			inuDETAIL_SAMPLE_ID,
			inuSAMPLE_ID
		);

		fetch cuLockRcByPk into orcLD_SAMPLE_DETAI;
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
		orcLD_SAMPLE_DETAI  out styLD_SAMPLE_DETAI
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_SAMPLE_DETAI;
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
		itbLD_SAMPLE_DETAI  in out nocopy tytbLD_SAMPLE_DETAI
	)
	IS
	BEGIN
			rcRecOfTab.NOTIFICATION.delete;
			rcRecOfTab.IS_APPROVED.delete;
			rcRecOfTab.SOURCE.delete;
			rcRecOfTab.SUBSCRIBER_ID.delete;
			rcRecOfTab.PRODUCT_ID.delete;
			rcRecOfTab.SUBSCRIPTION_ID.delete;
			rcRecOfTab.SAMPLE_ID.delete;
			rcRecOfTab.RESERVED_CF.delete;
			rcRecOfTab.BRANCH_CODE_CF.delete;
			rcRecOfTab.QUALITY_CF.delete;
			rcRecOfTab.RATINGS_CF.delete;
			rcRecOfTab.STATE_STATUS_HOLDER_CF.delete;
			rcRecOfTab.STATE_CF.delete;
			rcRecOfTab.MORA_YEARS_CF.delete;
			rcRecOfTab.STATEMENT_DATE_CF.delete;
			rcRecOfTab.INITIAL_ISSUE_DATE_CF.delete;
			rcRecOfTab.TERMINATION_DATE_CF.delete;
			rcRecOfTab.DUE_DATE_CF.delete;
			rcRecOfTab.EXTICION_MODE_ID_CF.delete;
			rcRecOfTab.TYPE_PAYMENT_CF.delete;
			rcRecOfTab.FIXED_CHARGE_VALUE_CF.delete;
			rcRecOfTab.CREDIT_LINE_CF.delete;
			rcRecOfTab.RESTRUCTURATED_OBLIGATION_CF.delete;
			rcRecOfTab.NUMBER_OF_RESTRUCTURING_CF.delete;
			rcRecOfTab.NUMBER_OF_RETURNED_CHECKS_CF.delete;
			rcRecOfTab.TERM_CF.delete;
			rcRecOfTab.DAYS_OF_PORTFOLIO_CF.delete;
			rcRecOfTab.THIRD_HOUSE_ADDRESS_CF.delete;
			rcRecOfTab.THIRD_HOME_PHONE_CF.delete;
			rcRecOfTab.EVERY_CITY_CODE_CF.delete;
			rcRecOfTab.TOWN_HOUSE_PARTY_CF.delete;
			rcRecOfTab.HOME_DEPARTMENT_CODE_CF.delete;
			rcRecOfTab.DEPARTMENT_OF_THIRD_HOUSE_CF.delete;
			rcRecOfTab.COMPANY_NAME_CF.delete;
			rcRecOfTab.COMPANY_ADDRESS_CF.delete;
			rcRecOfTab.COMPANY_PHONE_CF.delete;
			rcRecOfTab.CITY_CODE_CF.delete;
			rcRecOfTab.NOW_CITY_OF_THIRD_CF.delete;
			rcRecOfTab.DEPARTAMENT_CODE_CF.delete;
			rcRecOfTab.THIRD_COMPANY_DEPARTMENT_CF.delete;
			rcRecOfTab.NAT_RESTRUCTURING_CF.delete;
			rcRecOfTab.DETAIL_SAMPLE_ID.delete;
			rcRecOfTab.LEGAL_NATURE.delete;
			rcRecOfTab.VALUE_OF_COLLATERAL.delete;
			rcRecOfTab.SERVICE_CATEGORY.delete;
			rcRecOfTab.TYPE_OF_ACCOUNT.delete;
			rcRecOfTab.SPACE_OVERDRAFT.delete;
			rcRecOfTab.AUTHORIZED_DAYS.delete;
			rcRecOfTab.DEFAULT_MORA_AGE_ID_CF.delete;
			rcRecOfTab.TYPE_PORTFOLIO_ID_CF.delete;
			rcRecOfTab.NUMBER_MONTHS_CONTRACT_CF.delete;
			rcRecOfTab.CREDIT_MODE.delete;
			rcRecOfTab.NIVEL.delete;
			rcRecOfTab.START_DATE_EXCENSION_GMF_CF.delete;
			rcRecOfTab.TERMINATION_DATE_EXC_GMF_CF.delete;
			rcRecOfTab.NUMBER_OF_RENEWAL_CDT_CF.delete;
			rcRecOfTab.GMF_FREE_SAVINGS_CTA_CF.delete;
			rcRecOfTab.NATIVE_TYPE_IDENTIFICATION_CF.delete;
			rcRecOfTab.IDENT_NUMBER_OF_NATIVE_CF.delete;
			rcRecOfTab.ENTITY_TYPE_NATIVE_CF.delete;
			rcRecOfTab.ENTITY_CODE_ORIGINATING_CF.delete;
			rcRecOfTab.TYPE_OF_TRUST_CF.delete;
			rcRecOfTab.NUMBER_OF_TRUST_CF.delete;
			rcRecOfTab.NAME_TRUST_CF.delete;
			rcRecOfTab.TYPE_OF_DEBT_PORTFOLIO_CF.delete;
			rcRecOfTab.POLICY_TYPE_CF.delete;
			rcRecOfTab.RAMIFICATION_CODE.delete;
			rcRecOfTab.DATE_OF_PRESCRIPTION.delete;
			rcRecOfTab.SCORE.delete;
			rcRecOfTab.TYPE_IDENTIFICATION_DC.delete;
			rcRecOfTab.TYPE_IDENTIFICATION_CF.delete;
			rcRecOfTab.IDENTIFICATION_NUMBER.delete;
			rcRecOfTab.RECORD_TYPE_ID_CF.delete;
			rcRecOfTab.FULL_NAME.delete;
			rcRecOfTab.ACCOUNT_NUMBER.delete;
			rcRecOfTab.BRANCH_OFFICE_CF.delete;
			rcRecOfTab.SITUATION_HOLDER_DC.delete;
			rcRecOfTab.OPENING_DATE.delete;
			rcRecOfTab.DUE_DATE_DC.delete;
			rcRecOfTab.RESPONSIBLE_DC.delete;
			rcRecOfTab.TYPE_OBLIGATION_ID_DC.delete;
			rcRecOfTab.MORTGAGE_SUBSIDY_DC.delete;
			rcRecOfTab.DATE_SUBSIDY_DC.delete;
			rcRecOfTab.TYPE_CONTRACT_ID_CF.delete;
			rcRecOfTab.STATE_OF_CONTRACT_CF.delete;
			rcRecOfTab.TERM_CONTRACT_CF.delete;
			rcRecOfTab.TERM_CONTRACT_DC.delete;
			rcRecOfTab.METHOD_PAYMENT_ID_CF.delete;
			rcRecOfTab.METHOD_PAYMENT_ID_DC.delete;
			rcRecOfTab.PERIODICITY_ID_DC.delete;
			rcRecOfTab.PERIODICITY_ID_CF.delete;
			rcRecOfTab.NEW_PORTFOLIO_ID_DC.delete;
			rcRecOfTab.STATE_OBLIGATION_CF.delete;
			rcRecOfTab.SITUATION_HOLDER_CF.delete;
			rcRecOfTab.ACCOUNT_STATE_ID_DC.delete;
			rcRecOfTab.DATE_STATUS_ORIGIN.delete;
			rcRecOfTab.SOURCE_STATE_ID.delete;
			rcRecOfTab.DATE_STATUS_ACCOUNT.delete;
			rcRecOfTab.STATUS_PLASTIC_DC.delete;
			rcRecOfTab.DATE_STATUS_PLASTIC_DC.delete;
			rcRecOfTab.ADJETIVE_DC.delete;
			rcRecOfTab.DATE_ADJETIVE_DC.delete;
			rcRecOfTab.CARD_CLASS_DC.delete;
			rcRecOfTab.FRANCHISE_DC.delete;
			rcRecOfTab.PRIVATE_BRAND_NAME_DC.delete;
			rcRecOfTab.TYPE_MONEY_DC.delete;
			rcRecOfTab.TYPE_WARRANTY_DC.delete;
			rcRecOfTab.RATINGS_DC.delete;
			rcRecOfTab.PROBABILITY_DEFAULT_DC.delete;
			rcRecOfTab.MORA_AGE.delete;
			rcRecOfTab.INITIAL_VALUES_DC.delete;
			rcRecOfTab.DEBT_TO_DC.delete;
			rcRecOfTab.VALUE_AVAILABLE.delete;
			rcRecOfTab.MONTHLY_VALUE.delete;
			rcRecOfTab.VALUE_DELAY.delete;
			rcRecOfTab.TOTAL_SHARES.delete;
			rcRecOfTab.SHARES_CANCELED.delete;
			rcRecOfTab.SHARES_DEBT.delete;
			rcRecOfTab.CLAUSE_PERMANENCE_DC.delete;
			rcRecOfTab.DATE_CLAUSE_PERMANENCE_DC.delete;
			rcRecOfTab.PAYMENT_DEADLINE_DC.delete;
			rcRecOfTab.PAYMENT_DATE.delete;
			rcRecOfTab.RADICATION_OFFICE_DC.delete;
			rcRecOfTab.CITY_RADICATION_OFFICE_DC.delete;
			rcRecOfTab.CITY_RADI_OFFI_DANE_COD_DC.delete;
			rcRecOfTab.RESIDENTIAL_CITY_DC.delete;
			rcRecOfTab.CITY_RESI_OFFI_DANE_COD_DC.delete;
			rcRecOfTab.RESIDENTIAL_DEPARTMENT_DC.delete;
			rcRecOfTab.RESIDENTIAL_ADDRESS_DC.delete;
			rcRecOfTab.RESIDENTIAL_PHONE_DC.delete;
			rcRecOfTab.CITY_WORK_DC.delete;
			rcRecOfTab.CITY_WORK_DANE_CODE_DC.delete;
			rcRecOfTab.DEPARTMENT_WORK_DC.delete;
			rcRecOfTab.ADDRESS_WORK_DC.delete;
			rcRecOfTab.PHONE_WORK_DC.delete;
			rcRecOfTab.CITY_CORRESPONDENCE_DC.delete;
			rcRecOfTab.DEPARTMENT_CORRESPONDENCE_DC.delete;
			rcRecOfTab.ADDRESS_CORRESPONDENCE_DC.delete;
			rcRecOfTab.EMAIL_DC.delete;
			rcRecOfTab.DESTINATION_SUBSCRIBER_DC.delete;
			rcRecOfTab.CEL_PHONE_DC.delete;
			rcRecOfTab.CITY_CORRESPONDENCE_DANE_CODE.delete;
			rcRecOfTab.FILLER.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_SAMPLE_DETAI  in out nocopy tytbLD_SAMPLE_DETAI,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_SAMPLE_DETAI);

		for n in itbLD_SAMPLE_DETAI.first .. itbLD_SAMPLE_DETAI.last loop
			rcRecOfTab.NOTIFICATION(n) := itbLD_SAMPLE_DETAI(n).NOTIFICATION;
			rcRecOfTab.IS_APPROVED(n) := itbLD_SAMPLE_DETAI(n).IS_APPROVED;
			rcRecOfTab.SOURCE(n) := itbLD_SAMPLE_DETAI(n).SOURCE;
			rcRecOfTab.SUBSCRIBER_ID(n) := itbLD_SAMPLE_DETAI(n).SUBSCRIBER_ID;
			rcRecOfTab.PRODUCT_ID(n) := itbLD_SAMPLE_DETAI(n).PRODUCT_ID;
			rcRecOfTab.SUBSCRIPTION_ID(n) := itbLD_SAMPLE_DETAI(n).SUBSCRIPTION_ID;
			rcRecOfTab.SAMPLE_ID(n) := itbLD_SAMPLE_DETAI(n).SAMPLE_ID;
			rcRecOfTab.RESERVED_CF(n) := itbLD_SAMPLE_DETAI(n).RESERVED_CF;
			rcRecOfTab.BRANCH_CODE_CF(n) := itbLD_SAMPLE_DETAI(n).BRANCH_CODE_CF;
			rcRecOfTab.QUALITY_CF(n) := itbLD_SAMPLE_DETAI(n).QUALITY_CF;
			rcRecOfTab.RATINGS_CF(n) := itbLD_SAMPLE_DETAI(n).RATINGS_CF;
			rcRecOfTab.STATE_STATUS_HOLDER_CF(n) := itbLD_SAMPLE_DETAI(n).STATE_STATUS_HOLDER_CF;
			rcRecOfTab.STATE_CF(n) := itbLD_SAMPLE_DETAI(n).STATE_CF;
			rcRecOfTab.MORA_YEARS_CF(n) := itbLD_SAMPLE_DETAI(n).MORA_YEARS_CF;
			rcRecOfTab.STATEMENT_DATE_CF(n) := itbLD_SAMPLE_DETAI(n).STATEMENT_DATE_CF;
			rcRecOfTab.INITIAL_ISSUE_DATE_CF(n) := itbLD_SAMPLE_DETAI(n).INITIAL_ISSUE_DATE_CF;
			rcRecOfTab.TERMINATION_DATE_CF(n) := itbLD_SAMPLE_DETAI(n).TERMINATION_DATE_CF;
			rcRecOfTab.DUE_DATE_CF(n) := itbLD_SAMPLE_DETAI(n).DUE_DATE_CF;
			rcRecOfTab.EXTICION_MODE_ID_CF(n) := itbLD_SAMPLE_DETAI(n).EXTICION_MODE_ID_CF;
			rcRecOfTab.TYPE_PAYMENT_CF(n) := itbLD_SAMPLE_DETAI(n).TYPE_PAYMENT_CF;
			rcRecOfTab.FIXED_CHARGE_VALUE_CF(n) := itbLD_SAMPLE_DETAI(n).FIXED_CHARGE_VALUE_CF;
			rcRecOfTab.CREDIT_LINE_CF(n) := itbLD_SAMPLE_DETAI(n).CREDIT_LINE_CF;
			rcRecOfTab.RESTRUCTURATED_OBLIGATION_CF(n) := itbLD_SAMPLE_DETAI(n).RESTRUCTURATED_OBLIGATION_CF;
			rcRecOfTab.NUMBER_OF_RESTRUCTURING_CF(n) := itbLD_SAMPLE_DETAI(n).NUMBER_OF_RESTRUCTURING_CF;
			rcRecOfTab.NUMBER_OF_RETURNED_CHECKS_CF(n) := itbLD_SAMPLE_DETAI(n).NUMBER_OF_RETURNED_CHECKS_CF;
			rcRecOfTab.TERM_CF(n) := itbLD_SAMPLE_DETAI(n).TERM_CF;
			rcRecOfTab.DAYS_OF_PORTFOLIO_CF(n) := itbLD_SAMPLE_DETAI(n).DAYS_OF_PORTFOLIO_CF;
			rcRecOfTab.THIRD_HOUSE_ADDRESS_CF(n) := itbLD_SAMPLE_DETAI(n).THIRD_HOUSE_ADDRESS_CF;
			rcRecOfTab.THIRD_HOME_PHONE_CF(n) := itbLD_SAMPLE_DETAI(n).THIRD_HOME_PHONE_CF;
			rcRecOfTab.EVERY_CITY_CODE_CF(n) := itbLD_SAMPLE_DETAI(n).EVERY_CITY_CODE_CF;
			rcRecOfTab.TOWN_HOUSE_PARTY_CF(n) := itbLD_SAMPLE_DETAI(n).TOWN_HOUSE_PARTY_CF;
			rcRecOfTab.HOME_DEPARTMENT_CODE_CF(n) := itbLD_SAMPLE_DETAI(n).HOME_DEPARTMENT_CODE_CF;
			rcRecOfTab.DEPARTMENT_OF_THIRD_HOUSE_CF(n) := itbLD_SAMPLE_DETAI(n).DEPARTMENT_OF_THIRD_HOUSE_CF;
			rcRecOfTab.COMPANY_NAME_CF(n) := itbLD_SAMPLE_DETAI(n).COMPANY_NAME_CF;
			rcRecOfTab.COMPANY_ADDRESS_CF(n) := itbLD_SAMPLE_DETAI(n).COMPANY_ADDRESS_CF;
			rcRecOfTab.COMPANY_PHONE_CF(n) := itbLD_SAMPLE_DETAI(n).COMPANY_PHONE_CF;
			rcRecOfTab.CITY_CODE_CF(n) := itbLD_SAMPLE_DETAI(n).CITY_CODE_CF;
			rcRecOfTab.NOW_CITY_OF_THIRD_CF(n) := itbLD_SAMPLE_DETAI(n).NOW_CITY_OF_THIRD_CF;
			rcRecOfTab.DEPARTAMENT_CODE_CF(n) := itbLD_SAMPLE_DETAI(n).DEPARTAMENT_CODE_CF;
			rcRecOfTab.THIRD_COMPANY_DEPARTMENT_CF(n) := itbLD_SAMPLE_DETAI(n).THIRD_COMPANY_DEPARTMENT_CF;
			rcRecOfTab.NAT_RESTRUCTURING_CF(n) := itbLD_SAMPLE_DETAI(n).NAT_RESTRUCTURING_CF;
			rcRecOfTab.DETAIL_SAMPLE_ID(n) := itbLD_SAMPLE_DETAI(n).DETAIL_SAMPLE_ID;
			rcRecOfTab.LEGAL_NATURE(n) := itbLD_SAMPLE_DETAI(n).LEGAL_NATURE;
			rcRecOfTab.VALUE_OF_COLLATERAL(n) := itbLD_SAMPLE_DETAI(n).VALUE_OF_COLLATERAL;
			rcRecOfTab.SERVICE_CATEGORY(n) := itbLD_SAMPLE_DETAI(n).SERVICE_CATEGORY;
			rcRecOfTab.TYPE_OF_ACCOUNT(n) := itbLD_SAMPLE_DETAI(n).TYPE_OF_ACCOUNT;
			rcRecOfTab.SPACE_OVERDRAFT(n) := itbLD_SAMPLE_DETAI(n).SPACE_OVERDRAFT;
			rcRecOfTab.AUTHORIZED_DAYS(n) := itbLD_SAMPLE_DETAI(n).AUTHORIZED_DAYS;
			rcRecOfTab.DEFAULT_MORA_AGE_ID_CF(n) := itbLD_SAMPLE_DETAI(n).DEFAULT_MORA_AGE_ID_CF;
			rcRecOfTab.TYPE_PORTFOLIO_ID_CF(n) := itbLD_SAMPLE_DETAI(n).TYPE_PORTFOLIO_ID_CF;
			rcRecOfTab.NUMBER_MONTHS_CONTRACT_CF(n) := itbLD_SAMPLE_DETAI(n).NUMBER_MONTHS_CONTRACT_CF;
			rcRecOfTab.CREDIT_MODE(n) := itbLD_SAMPLE_DETAI(n).CREDIT_MODE;
			rcRecOfTab.NIVEL(n) := itbLD_SAMPLE_DETAI(n).NIVEL;
			rcRecOfTab.START_DATE_EXCENSION_GMF_CF(n) := itbLD_SAMPLE_DETAI(n).START_DATE_EXCENSION_GMF_CF;
			rcRecOfTab.TERMINATION_DATE_EXC_GMF_CF(n) := itbLD_SAMPLE_DETAI(n).TERMINATION_DATE_EXC_GMF_CF;
			rcRecOfTab.NUMBER_OF_RENEWAL_CDT_CF(n) := itbLD_SAMPLE_DETAI(n).NUMBER_OF_RENEWAL_CDT_CF;
			rcRecOfTab.GMF_FREE_SAVINGS_CTA_CF(n) := itbLD_SAMPLE_DETAI(n).GMF_FREE_SAVINGS_CTA_CF;
			rcRecOfTab.NATIVE_TYPE_IDENTIFICATION_CF(n) := itbLD_SAMPLE_DETAI(n).NATIVE_TYPE_IDENTIFICATION_CF;
			rcRecOfTab.IDENT_NUMBER_OF_NATIVE_CF(n) := itbLD_SAMPLE_DETAI(n).IDENT_NUMBER_OF_NATIVE_CF;
			rcRecOfTab.ENTITY_TYPE_NATIVE_CF(n) := itbLD_SAMPLE_DETAI(n).ENTITY_TYPE_NATIVE_CF;
			rcRecOfTab.ENTITY_CODE_ORIGINATING_CF(n) := itbLD_SAMPLE_DETAI(n).ENTITY_CODE_ORIGINATING_CF;
			rcRecOfTab.TYPE_OF_TRUST_CF(n) := itbLD_SAMPLE_DETAI(n).TYPE_OF_TRUST_CF;
			rcRecOfTab.NUMBER_OF_TRUST_CF(n) := itbLD_SAMPLE_DETAI(n).NUMBER_OF_TRUST_CF;
			rcRecOfTab.NAME_TRUST_CF(n) := itbLD_SAMPLE_DETAI(n).NAME_TRUST_CF;
			rcRecOfTab.TYPE_OF_DEBT_PORTFOLIO_CF(n) := itbLD_SAMPLE_DETAI(n).TYPE_OF_DEBT_PORTFOLIO_CF;
			rcRecOfTab.POLICY_TYPE_CF(n) := itbLD_SAMPLE_DETAI(n).POLICY_TYPE_CF;
			rcRecOfTab.RAMIFICATION_CODE(n) := itbLD_SAMPLE_DETAI(n).RAMIFICATION_CODE;
			rcRecOfTab.DATE_OF_PRESCRIPTION(n) := itbLD_SAMPLE_DETAI(n).DATE_OF_PRESCRIPTION;
			rcRecOfTab.SCORE(n) := itbLD_SAMPLE_DETAI(n).SCORE;
			rcRecOfTab.TYPE_IDENTIFICATION_DC(n) := itbLD_SAMPLE_DETAI(n).TYPE_IDENTIFICATION_DC;
			rcRecOfTab.TYPE_IDENTIFICATION_CF(n) := itbLD_SAMPLE_DETAI(n).TYPE_IDENTIFICATION_CF;
			rcRecOfTab.IDENTIFICATION_NUMBER(n) := itbLD_SAMPLE_DETAI(n).IDENTIFICATION_NUMBER;
			rcRecOfTab.RECORD_TYPE_ID_CF(n) := itbLD_SAMPLE_DETAI(n).RECORD_TYPE_ID_CF;
			rcRecOfTab.FULL_NAME(n) := itbLD_SAMPLE_DETAI(n).FULL_NAME;
			rcRecOfTab.ACCOUNT_NUMBER(n) := itbLD_SAMPLE_DETAI(n).ACCOUNT_NUMBER;
			rcRecOfTab.BRANCH_OFFICE_CF(n) := itbLD_SAMPLE_DETAI(n).BRANCH_OFFICE_CF;
			rcRecOfTab.SITUATION_HOLDER_DC(n) := itbLD_SAMPLE_DETAI(n).SITUATION_HOLDER_DC;
			rcRecOfTab.OPENING_DATE(n) := itbLD_SAMPLE_DETAI(n).OPENING_DATE;
			rcRecOfTab.DUE_DATE_DC(n) := itbLD_SAMPLE_DETAI(n).DUE_DATE_DC;
			rcRecOfTab.RESPONSIBLE_DC(n) := itbLD_SAMPLE_DETAI(n).RESPONSIBLE_DC;
			rcRecOfTab.TYPE_OBLIGATION_ID_DC(n) := itbLD_SAMPLE_DETAI(n).TYPE_OBLIGATION_ID_DC;
			rcRecOfTab.MORTGAGE_SUBSIDY_DC(n) := itbLD_SAMPLE_DETAI(n).MORTGAGE_SUBSIDY_DC;
			rcRecOfTab.DATE_SUBSIDY_DC(n) := itbLD_SAMPLE_DETAI(n).DATE_SUBSIDY_DC;
			rcRecOfTab.TYPE_CONTRACT_ID_CF(n) := itbLD_SAMPLE_DETAI(n).TYPE_CONTRACT_ID_CF;
			rcRecOfTab.STATE_OF_CONTRACT_CF(n) := itbLD_SAMPLE_DETAI(n).STATE_OF_CONTRACT_CF;
			rcRecOfTab.TERM_CONTRACT_CF(n) := itbLD_SAMPLE_DETAI(n).TERM_CONTRACT_CF;
			rcRecOfTab.TERM_CONTRACT_DC(n) := itbLD_SAMPLE_DETAI(n).TERM_CONTRACT_DC;
			rcRecOfTab.METHOD_PAYMENT_ID_CF(n) := itbLD_SAMPLE_DETAI(n).METHOD_PAYMENT_ID_CF;
			rcRecOfTab.METHOD_PAYMENT_ID_DC(n) := itbLD_SAMPLE_DETAI(n).METHOD_PAYMENT_ID_DC;
			rcRecOfTab.PERIODICITY_ID_DC(n) := itbLD_SAMPLE_DETAI(n).PERIODICITY_ID_DC;
			rcRecOfTab.PERIODICITY_ID_CF(n) := itbLD_SAMPLE_DETAI(n).PERIODICITY_ID_CF;
			rcRecOfTab.NEW_PORTFOLIO_ID_DC(n) := itbLD_SAMPLE_DETAI(n).NEW_PORTFOLIO_ID_DC;
			rcRecOfTab.STATE_OBLIGATION_CF(n) := itbLD_SAMPLE_DETAI(n).STATE_OBLIGATION_CF;
			rcRecOfTab.SITUATION_HOLDER_CF(n) := itbLD_SAMPLE_DETAI(n).SITUATION_HOLDER_CF;
			rcRecOfTab.ACCOUNT_STATE_ID_DC(n) := itbLD_SAMPLE_DETAI(n).ACCOUNT_STATE_ID_DC;
			rcRecOfTab.DATE_STATUS_ORIGIN(n) := itbLD_SAMPLE_DETAI(n).DATE_STATUS_ORIGIN;
			rcRecOfTab.SOURCE_STATE_ID(n) := itbLD_SAMPLE_DETAI(n).SOURCE_STATE_ID;
			rcRecOfTab.DATE_STATUS_ACCOUNT(n) := itbLD_SAMPLE_DETAI(n).DATE_STATUS_ACCOUNT;
			rcRecOfTab.STATUS_PLASTIC_DC(n) := itbLD_SAMPLE_DETAI(n).STATUS_PLASTIC_DC;
			rcRecOfTab.DATE_STATUS_PLASTIC_DC(n) := itbLD_SAMPLE_DETAI(n).DATE_STATUS_PLASTIC_DC;
			rcRecOfTab.ADJETIVE_DC(n) := itbLD_SAMPLE_DETAI(n).ADJETIVE_DC;
			rcRecOfTab.DATE_ADJETIVE_DC(n) := itbLD_SAMPLE_DETAI(n).DATE_ADJETIVE_DC;
			rcRecOfTab.CARD_CLASS_DC(n) := itbLD_SAMPLE_DETAI(n).CARD_CLASS_DC;
			rcRecOfTab.FRANCHISE_DC(n) := itbLD_SAMPLE_DETAI(n).FRANCHISE_DC;
			rcRecOfTab.PRIVATE_BRAND_NAME_DC(n) := itbLD_SAMPLE_DETAI(n).PRIVATE_BRAND_NAME_DC;
			rcRecOfTab.TYPE_MONEY_DC(n) := itbLD_SAMPLE_DETAI(n).TYPE_MONEY_DC;
			rcRecOfTab.TYPE_WARRANTY_DC(n) := itbLD_SAMPLE_DETAI(n).TYPE_WARRANTY_DC;
			rcRecOfTab.RATINGS_DC(n) := itbLD_SAMPLE_DETAI(n).RATINGS_DC;
			rcRecOfTab.PROBABILITY_DEFAULT_DC(n) := itbLD_SAMPLE_DETAI(n).PROBABILITY_DEFAULT_DC;
			rcRecOfTab.MORA_AGE(n) := itbLD_SAMPLE_DETAI(n).MORA_AGE;
			rcRecOfTab.INITIAL_VALUES_DC(n) := itbLD_SAMPLE_DETAI(n).INITIAL_VALUES_DC;
			rcRecOfTab.DEBT_TO_DC(n) := itbLD_SAMPLE_DETAI(n).DEBT_TO_DC;
			rcRecOfTab.VALUE_AVAILABLE(n) := itbLD_SAMPLE_DETAI(n).VALUE_AVAILABLE;
			rcRecOfTab.MONTHLY_VALUE(n) := itbLD_SAMPLE_DETAI(n).MONTHLY_VALUE;
			rcRecOfTab.VALUE_DELAY(n) := itbLD_SAMPLE_DETAI(n).VALUE_DELAY;
			rcRecOfTab.TOTAL_SHARES(n) := itbLD_SAMPLE_DETAI(n).TOTAL_SHARES;
			rcRecOfTab.SHARES_CANCELED(n) := itbLD_SAMPLE_DETAI(n).SHARES_CANCELED;
			rcRecOfTab.SHARES_DEBT(n) := itbLD_SAMPLE_DETAI(n).SHARES_DEBT;
			rcRecOfTab.CLAUSE_PERMANENCE_DC(n) := itbLD_SAMPLE_DETAI(n).CLAUSE_PERMANENCE_DC;
			rcRecOfTab.DATE_CLAUSE_PERMANENCE_DC(n) := itbLD_SAMPLE_DETAI(n).DATE_CLAUSE_PERMANENCE_DC;
			rcRecOfTab.PAYMENT_DEADLINE_DC(n) := itbLD_SAMPLE_DETAI(n).PAYMENT_DEADLINE_DC;
			rcRecOfTab.PAYMENT_DATE(n) := itbLD_SAMPLE_DETAI(n).PAYMENT_DATE;
			rcRecOfTab.RADICATION_OFFICE_DC(n) := itbLD_SAMPLE_DETAI(n).RADICATION_OFFICE_DC;
			rcRecOfTab.CITY_RADICATION_OFFICE_DC(n) := itbLD_SAMPLE_DETAI(n).CITY_RADICATION_OFFICE_DC;
			rcRecOfTab.CITY_RADI_OFFI_DANE_COD_DC(n) := itbLD_SAMPLE_DETAI(n).CITY_RADI_OFFI_DANE_COD_DC;
			rcRecOfTab.RESIDENTIAL_CITY_DC(n) := itbLD_SAMPLE_DETAI(n).RESIDENTIAL_CITY_DC;
			rcRecOfTab.CITY_RESI_OFFI_DANE_COD_DC(n) := itbLD_SAMPLE_DETAI(n).CITY_RESI_OFFI_DANE_COD_DC;
			rcRecOfTab.RESIDENTIAL_DEPARTMENT_DC(n) := itbLD_SAMPLE_DETAI(n).RESIDENTIAL_DEPARTMENT_DC;
			rcRecOfTab.RESIDENTIAL_ADDRESS_DC(n) := itbLD_SAMPLE_DETAI(n).RESIDENTIAL_ADDRESS_DC;
			rcRecOfTab.RESIDENTIAL_PHONE_DC(n) := itbLD_SAMPLE_DETAI(n).RESIDENTIAL_PHONE_DC;
			rcRecOfTab.CITY_WORK_DC(n) := itbLD_SAMPLE_DETAI(n).CITY_WORK_DC;
			rcRecOfTab.CITY_WORK_DANE_CODE_DC(n) := itbLD_SAMPLE_DETAI(n).CITY_WORK_DANE_CODE_DC;
			rcRecOfTab.DEPARTMENT_WORK_DC(n) := itbLD_SAMPLE_DETAI(n).DEPARTMENT_WORK_DC;
			rcRecOfTab.ADDRESS_WORK_DC(n) := itbLD_SAMPLE_DETAI(n).ADDRESS_WORK_DC;
			rcRecOfTab.PHONE_WORK_DC(n) := itbLD_SAMPLE_DETAI(n).PHONE_WORK_DC;
			rcRecOfTab.CITY_CORRESPONDENCE_DC(n) := itbLD_SAMPLE_DETAI(n).CITY_CORRESPONDENCE_DC;
			rcRecOfTab.DEPARTMENT_CORRESPONDENCE_DC(n) := itbLD_SAMPLE_DETAI(n).DEPARTMENT_CORRESPONDENCE_DC;
			rcRecOfTab.ADDRESS_CORRESPONDENCE_DC(n) := itbLD_SAMPLE_DETAI(n).ADDRESS_CORRESPONDENCE_DC;
			rcRecOfTab.EMAIL_DC(n) := itbLD_SAMPLE_DETAI(n).EMAIL_DC;
			rcRecOfTab.DESTINATION_SUBSCRIBER_DC(n) := itbLD_SAMPLE_DETAI(n).DESTINATION_SUBSCRIBER_DC;
			rcRecOfTab.CEL_PHONE_DC(n) := itbLD_SAMPLE_DETAI(n).CEL_PHONE_DC;
			rcRecOfTab.CITY_CORRESPONDENCE_DANE_CODE(n) := itbLD_SAMPLE_DETAI(n).CITY_CORRESPONDENCE_DANE_CODE;
			rcRecOfTab.FILLER(n) := itbLD_SAMPLE_DETAI(n).FILLER;
			rcRecOfTab.row_id(n) := itbLD_SAMPLE_DETAI(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuDETAIL_SAMPLE_ID,
			inuSAMPLE_ID
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
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuDETAIL_SAMPLE_ID = rcData.DETAIL_SAMPLE_ID AND
			inuSAMPLE_ID = rcData.SAMPLE_ID
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
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuDETAIL_SAMPLE_ID,
			inuSAMPLE_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN		rcError.DETAIL_SAMPLE_ID:=inuDETAIL_SAMPLE_ID;		rcError.SAMPLE_ID:=inuSAMPLE_ID;

		Load
		(
			inuDETAIL_SAMPLE_ID,
			inuSAMPLE_ID
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
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuDETAIL_SAMPLE_ID,
			inuSAMPLE_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		orcRecord out nocopy styLD_SAMPLE_DETAI
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN		rcError.DETAIL_SAMPLE_ID:=inuDETAIL_SAMPLE_ID;		rcError.SAMPLE_ID:=inuSAMPLE_ID;

		Load
		(
			inuDETAIL_SAMPLE_ID,
			inuSAMPLE_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type
	)
	RETURN styLD_SAMPLE_DETAI
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID:=inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID:=inuSAMPLE_ID;

		Load
		(
			inuDETAIL_SAMPLE_ID,
			inuSAMPLE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type
	)
	RETURN styLD_SAMPLE_DETAI
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID:=inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID:=inuSAMPLE_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuDETAIL_SAMPLE_ID,
			inuSAMPLE_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuDETAIL_SAMPLE_ID,
			inuSAMPLE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_SAMPLE_DETAI
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_SAMPLE_DETAI
	)
	IS
		rfLD_SAMPLE_DETAI tyrfLD_SAMPLE_DETAI;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_SAMPLE_DETAI.*, LD_SAMPLE_DETAI.rowid FROM LD_SAMPLE_DETAI';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_SAMPLE_DETAI for sbFullQuery;

		fetch rfLD_SAMPLE_DETAI bulk collect INTO otbResult;

		close rfLD_SAMPLE_DETAI;
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
		sbSQL VARCHAR2 (32000) := 'select LD_SAMPLE_DETAI.*, LD_SAMPLE_DETAI.rowid FROM LD_SAMPLE_DETAI';
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
		ircLD_SAMPLE_DETAI in styLD_SAMPLE_DETAI
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_SAMPLE_DETAI,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_SAMPLE_DETAI in styLD_SAMPLE_DETAI,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_SAMPLE_DETAI.DETAIL_SAMPLE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|DETAIL_SAMPLE_ID');
			raise ex.controlled_error;
		end if;
		if ircLD_SAMPLE_DETAI.SAMPLE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|SAMPLE_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_SAMPLE_DETAI
		(
			NOTIFICATION,
			IS_APPROVED,
			SOURCE,
			SUBSCRIBER_ID,
			PRODUCT_ID,
			SUBSCRIPTION_ID,
			SAMPLE_ID,
			RESERVED_CF,
			BRANCH_CODE_CF,
			QUALITY_CF,
			RATINGS_CF,
			STATE_STATUS_HOLDER_CF,
			STATE_CF,
			MORA_YEARS_CF,
			STATEMENT_DATE_CF,
			INITIAL_ISSUE_DATE_CF,
			TERMINATION_DATE_CF,
			DUE_DATE_CF,
			EXTICION_MODE_ID_CF,
			TYPE_PAYMENT_CF,
			FIXED_CHARGE_VALUE_CF,
			CREDIT_LINE_CF,
			RESTRUCTURATED_OBLIGATION_CF,
			NUMBER_OF_RESTRUCTURING_CF,
			NUMBER_OF_RETURNED_CHECKS_CF,
			TERM_CF,
			DAYS_OF_PORTFOLIO_CF,
			THIRD_HOUSE_ADDRESS_CF,
			THIRD_HOME_PHONE_CF,
			EVERY_CITY_CODE_CF,
			TOWN_HOUSE_PARTY_CF,
			HOME_DEPARTMENT_CODE_CF,
			DEPARTMENT_OF_THIRD_HOUSE_CF,
			COMPANY_NAME_CF,
			COMPANY_ADDRESS_CF,
			COMPANY_PHONE_CF,
			CITY_CODE_CF,
			NOW_CITY_OF_THIRD_CF,
			DEPARTAMENT_CODE_CF,
			THIRD_COMPANY_DEPARTMENT_CF,
			NAT_RESTRUCTURING_CF,
			DETAIL_SAMPLE_ID,
			LEGAL_NATURE,
			VALUE_OF_COLLATERAL,
			SERVICE_CATEGORY,
			TYPE_OF_ACCOUNT,
			SPACE_OVERDRAFT,
			AUTHORIZED_DAYS,
			DEFAULT_MORA_AGE_ID_CF,
			TYPE_PORTFOLIO_ID_CF,
			NUMBER_MONTHS_CONTRACT_CF,
			CREDIT_MODE,
			NIVEL,
			START_DATE_EXCENSION_GMF_CF,
			TERMINATION_DATE_EXC_GMF_CF,
			NUMBER_OF_RENEWAL_CDT_CF,
			GMF_FREE_SAVINGS_CTA_CF,
			NATIVE_TYPE_IDENTIFICATION_CF,
			IDENT_NUMBER_OF_NATIVE_CF,
			ENTITY_TYPE_NATIVE_CF,
			ENTITY_CODE_ORIGINATING_CF,
			TYPE_OF_TRUST_CF,
			NUMBER_OF_TRUST_CF,
			NAME_TRUST_CF,
			TYPE_OF_DEBT_PORTFOLIO_CF,
			POLICY_TYPE_CF,
			RAMIFICATION_CODE,
			DATE_OF_PRESCRIPTION,
			SCORE,
			TYPE_IDENTIFICATION_DC,
			TYPE_IDENTIFICATION_CF,
			IDENTIFICATION_NUMBER,
			RECORD_TYPE_ID_CF,
			FULL_NAME,
			ACCOUNT_NUMBER,
			BRANCH_OFFICE_CF,
			SITUATION_HOLDER_DC,
			OPENING_DATE,
			DUE_DATE_DC,
			RESPONSIBLE_DC,
			TYPE_OBLIGATION_ID_DC,
			MORTGAGE_SUBSIDY_DC,
			DATE_SUBSIDY_DC,
			TYPE_CONTRACT_ID_CF,
			STATE_OF_CONTRACT_CF,
			TERM_CONTRACT_CF,
			TERM_CONTRACT_DC,
			METHOD_PAYMENT_ID_CF,
			METHOD_PAYMENT_ID_DC,
			PERIODICITY_ID_DC,
			PERIODICITY_ID_CF,
			NEW_PORTFOLIO_ID_DC,
			STATE_OBLIGATION_CF,
			SITUATION_HOLDER_CF,
			ACCOUNT_STATE_ID_DC,
			DATE_STATUS_ORIGIN,
			SOURCE_STATE_ID,
			DATE_STATUS_ACCOUNT,
			STATUS_PLASTIC_DC,
			DATE_STATUS_PLASTIC_DC,
			ADJETIVE_DC,
			DATE_ADJETIVE_DC,
			CARD_CLASS_DC,
			FRANCHISE_DC,
			PRIVATE_BRAND_NAME_DC,
			TYPE_MONEY_DC,
			TYPE_WARRANTY_DC,
			RATINGS_DC,
			PROBABILITY_DEFAULT_DC,
			MORA_AGE,
			INITIAL_VALUES_DC,
			DEBT_TO_DC,
			VALUE_AVAILABLE,
			MONTHLY_VALUE,
			VALUE_DELAY,
			TOTAL_SHARES,
			SHARES_CANCELED,
			SHARES_DEBT,
			CLAUSE_PERMANENCE_DC,
			DATE_CLAUSE_PERMANENCE_DC,
			PAYMENT_DEADLINE_DC,
			PAYMENT_DATE,
			RADICATION_OFFICE_DC,
			CITY_RADICATION_OFFICE_DC,
			CITY_RADI_OFFI_DANE_COD_DC,
			RESIDENTIAL_CITY_DC,
			CITY_RESI_OFFI_DANE_COD_DC,
			RESIDENTIAL_DEPARTMENT_DC,
			RESIDENTIAL_ADDRESS_DC,
			RESIDENTIAL_PHONE_DC,
			CITY_WORK_DC,
			CITY_WORK_DANE_CODE_DC,
			DEPARTMENT_WORK_DC,
			ADDRESS_WORK_DC,
			PHONE_WORK_DC,
			CITY_CORRESPONDENCE_DC,
			DEPARTMENT_CORRESPONDENCE_DC,
			ADDRESS_CORRESPONDENCE_DC,
			EMAIL_DC,
			DESTINATION_SUBSCRIBER_DC,
			CEL_PHONE_DC,
			CITY_CORRESPONDENCE_DANE_CODE,
			FILLER
		)
		values
		(
			ircLD_SAMPLE_DETAI.NOTIFICATION,
			ircLD_SAMPLE_DETAI.IS_APPROVED,
			ircLD_SAMPLE_DETAI.SOURCE,
			ircLD_SAMPLE_DETAI.SUBSCRIBER_ID,
			ircLD_SAMPLE_DETAI.PRODUCT_ID,
			ircLD_SAMPLE_DETAI.SUBSCRIPTION_ID,
			ircLD_SAMPLE_DETAI.SAMPLE_ID,
			ircLD_SAMPLE_DETAI.RESERVED_CF,
			ircLD_SAMPLE_DETAI.BRANCH_CODE_CF,
			ircLD_SAMPLE_DETAI.QUALITY_CF,
			ircLD_SAMPLE_DETAI.RATINGS_CF,
			ircLD_SAMPLE_DETAI.STATE_STATUS_HOLDER_CF,
			ircLD_SAMPLE_DETAI.STATE_CF,
			ircLD_SAMPLE_DETAI.MORA_YEARS_CF,
			ircLD_SAMPLE_DETAI.STATEMENT_DATE_CF,
			ircLD_SAMPLE_DETAI.INITIAL_ISSUE_DATE_CF,
			ircLD_SAMPLE_DETAI.TERMINATION_DATE_CF,
			ircLD_SAMPLE_DETAI.DUE_DATE_CF,
			ircLD_SAMPLE_DETAI.EXTICION_MODE_ID_CF,
			ircLD_SAMPLE_DETAI.TYPE_PAYMENT_CF,
			ircLD_SAMPLE_DETAI.FIXED_CHARGE_VALUE_CF,
			ircLD_SAMPLE_DETAI.CREDIT_LINE_CF,
			ircLD_SAMPLE_DETAI.RESTRUCTURATED_OBLIGATION_CF,
			ircLD_SAMPLE_DETAI.NUMBER_OF_RESTRUCTURING_CF,
			ircLD_SAMPLE_DETAI.NUMBER_OF_RETURNED_CHECKS_CF,
			ircLD_SAMPLE_DETAI.TERM_CF,
			ircLD_SAMPLE_DETAI.DAYS_OF_PORTFOLIO_CF,
			ircLD_SAMPLE_DETAI.THIRD_HOUSE_ADDRESS_CF,
			ircLD_SAMPLE_DETAI.THIRD_HOME_PHONE_CF,
			ircLD_SAMPLE_DETAI.EVERY_CITY_CODE_CF,
			ircLD_SAMPLE_DETAI.TOWN_HOUSE_PARTY_CF,
			ircLD_SAMPLE_DETAI.HOME_DEPARTMENT_CODE_CF,
			ircLD_SAMPLE_DETAI.DEPARTMENT_OF_THIRD_HOUSE_CF,
			ircLD_SAMPLE_DETAI.COMPANY_NAME_CF,
			ircLD_SAMPLE_DETAI.COMPANY_ADDRESS_CF,
			ircLD_SAMPLE_DETAI.COMPANY_PHONE_CF,
			ircLD_SAMPLE_DETAI.CITY_CODE_CF,
			ircLD_SAMPLE_DETAI.NOW_CITY_OF_THIRD_CF,
			ircLD_SAMPLE_DETAI.DEPARTAMENT_CODE_CF,
			ircLD_SAMPLE_DETAI.THIRD_COMPANY_DEPARTMENT_CF,
			ircLD_SAMPLE_DETAI.NAT_RESTRUCTURING_CF,
			ircLD_SAMPLE_DETAI.DETAIL_SAMPLE_ID,
			ircLD_SAMPLE_DETAI.LEGAL_NATURE,
			ircLD_SAMPLE_DETAI.VALUE_OF_COLLATERAL,
			ircLD_SAMPLE_DETAI.SERVICE_CATEGORY,
			ircLD_SAMPLE_DETAI.TYPE_OF_ACCOUNT,
			ircLD_SAMPLE_DETAI.SPACE_OVERDRAFT,
			ircLD_SAMPLE_DETAI.AUTHORIZED_DAYS,
			ircLD_SAMPLE_DETAI.DEFAULT_MORA_AGE_ID_CF,
			ircLD_SAMPLE_DETAI.TYPE_PORTFOLIO_ID_CF,
			ircLD_SAMPLE_DETAI.NUMBER_MONTHS_CONTRACT_CF,
			ircLD_SAMPLE_DETAI.CREDIT_MODE,
			ircLD_SAMPLE_DETAI.NIVEL,
			ircLD_SAMPLE_DETAI.START_DATE_EXCENSION_GMF_CF,
			ircLD_SAMPLE_DETAI.TERMINATION_DATE_EXC_GMF_CF,
			ircLD_SAMPLE_DETAI.NUMBER_OF_RENEWAL_CDT_CF,
			ircLD_SAMPLE_DETAI.GMF_FREE_SAVINGS_CTA_CF,
			ircLD_SAMPLE_DETAI.NATIVE_TYPE_IDENTIFICATION_CF,
			ircLD_SAMPLE_DETAI.IDENT_NUMBER_OF_NATIVE_CF,
			ircLD_SAMPLE_DETAI.ENTITY_TYPE_NATIVE_CF,
			ircLD_SAMPLE_DETAI.ENTITY_CODE_ORIGINATING_CF,
			ircLD_SAMPLE_DETAI.TYPE_OF_TRUST_CF,
			ircLD_SAMPLE_DETAI.NUMBER_OF_TRUST_CF,
			ircLD_SAMPLE_DETAI.NAME_TRUST_CF,
			ircLD_SAMPLE_DETAI.TYPE_OF_DEBT_PORTFOLIO_CF,
			ircLD_SAMPLE_DETAI.POLICY_TYPE_CF,
			ircLD_SAMPLE_DETAI.RAMIFICATION_CODE,
			ircLD_SAMPLE_DETAI.DATE_OF_PRESCRIPTION,
			ircLD_SAMPLE_DETAI.SCORE,
			ircLD_SAMPLE_DETAI.TYPE_IDENTIFICATION_DC,
			ircLD_SAMPLE_DETAI.TYPE_IDENTIFICATION_CF,
			ircLD_SAMPLE_DETAI.IDENTIFICATION_NUMBER,
			ircLD_SAMPLE_DETAI.RECORD_TYPE_ID_CF,
			ircLD_SAMPLE_DETAI.FULL_NAME,
			ircLD_SAMPLE_DETAI.ACCOUNT_NUMBER,
			ircLD_SAMPLE_DETAI.BRANCH_OFFICE_CF,
			ircLD_SAMPLE_DETAI.SITUATION_HOLDER_DC,
			ircLD_SAMPLE_DETAI.OPENING_DATE,
			ircLD_SAMPLE_DETAI.DUE_DATE_DC,
			ircLD_SAMPLE_DETAI.RESPONSIBLE_DC,
			ircLD_SAMPLE_DETAI.TYPE_OBLIGATION_ID_DC,
			ircLD_SAMPLE_DETAI.MORTGAGE_SUBSIDY_DC,
			ircLD_SAMPLE_DETAI.DATE_SUBSIDY_DC,
			ircLD_SAMPLE_DETAI.TYPE_CONTRACT_ID_CF,
			ircLD_SAMPLE_DETAI.STATE_OF_CONTRACT_CF,
			ircLD_SAMPLE_DETAI.TERM_CONTRACT_CF,
			ircLD_SAMPLE_DETAI.TERM_CONTRACT_DC,
			ircLD_SAMPLE_DETAI.METHOD_PAYMENT_ID_CF,
			ircLD_SAMPLE_DETAI.METHOD_PAYMENT_ID_DC,
			ircLD_SAMPLE_DETAI.PERIODICITY_ID_DC,
			ircLD_SAMPLE_DETAI.PERIODICITY_ID_CF,
			ircLD_SAMPLE_DETAI.NEW_PORTFOLIO_ID_DC,
			ircLD_SAMPLE_DETAI.STATE_OBLIGATION_CF,
			ircLD_SAMPLE_DETAI.SITUATION_HOLDER_CF,
			ircLD_SAMPLE_DETAI.ACCOUNT_STATE_ID_DC,
			ircLD_SAMPLE_DETAI.DATE_STATUS_ORIGIN,
			ircLD_SAMPLE_DETAI.SOURCE_STATE_ID,
			ircLD_SAMPLE_DETAI.DATE_STATUS_ACCOUNT,
			ircLD_SAMPLE_DETAI.STATUS_PLASTIC_DC,
			ircLD_SAMPLE_DETAI.DATE_STATUS_PLASTIC_DC,
			ircLD_SAMPLE_DETAI.ADJETIVE_DC,
			ircLD_SAMPLE_DETAI.DATE_ADJETIVE_DC,
			ircLD_SAMPLE_DETAI.CARD_CLASS_DC,
			ircLD_SAMPLE_DETAI.FRANCHISE_DC,
			ircLD_SAMPLE_DETAI.PRIVATE_BRAND_NAME_DC,
			ircLD_SAMPLE_DETAI.TYPE_MONEY_DC,
			ircLD_SAMPLE_DETAI.TYPE_WARRANTY_DC,
			ircLD_SAMPLE_DETAI.RATINGS_DC,
			ircLD_SAMPLE_DETAI.PROBABILITY_DEFAULT_DC,
			ircLD_SAMPLE_DETAI.MORA_AGE,
			ircLD_SAMPLE_DETAI.INITIAL_VALUES_DC,
			ircLD_SAMPLE_DETAI.DEBT_TO_DC,
			ircLD_SAMPLE_DETAI.VALUE_AVAILABLE,
			ircLD_SAMPLE_DETAI.MONTHLY_VALUE,
			ircLD_SAMPLE_DETAI.VALUE_DELAY,
			ircLD_SAMPLE_DETAI.TOTAL_SHARES,
			ircLD_SAMPLE_DETAI.SHARES_CANCELED,
			ircLD_SAMPLE_DETAI.SHARES_DEBT,
			ircLD_SAMPLE_DETAI.CLAUSE_PERMANENCE_DC,
			ircLD_SAMPLE_DETAI.DATE_CLAUSE_PERMANENCE_DC,
			ircLD_SAMPLE_DETAI.PAYMENT_DEADLINE_DC,
			ircLD_SAMPLE_DETAI.PAYMENT_DATE,
			ircLD_SAMPLE_DETAI.RADICATION_OFFICE_DC,
			ircLD_SAMPLE_DETAI.CITY_RADICATION_OFFICE_DC,
			ircLD_SAMPLE_DETAI.CITY_RADI_OFFI_DANE_COD_DC,
			ircLD_SAMPLE_DETAI.RESIDENTIAL_CITY_DC,
			ircLD_SAMPLE_DETAI.CITY_RESI_OFFI_DANE_COD_DC,
			ircLD_SAMPLE_DETAI.RESIDENTIAL_DEPARTMENT_DC,
			ircLD_SAMPLE_DETAI.RESIDENTIAL_ADDRESS_DC,
			ircLD_SAMPLE_DETAI.RESIDENTIAL_PHONE_DC,
			ircLD_SAMPLE_DETAI.CITY_WORK_DC,
			ircLD_SAMPLE_DETAI.CITY_WORK_DANE_CODE_DC,
			ircLD_SAMPLE_DETAI.DEPARTMENT_WORK_DC,
			ircLD_SAMPLE_DETAI.ADDRESS_WORK_DC,
			ircLD_SAMPLE_DETAI.PHONE_WORK_DC,
			ircLD_SAMPLE_DETAI.CITY_CORRESPONDENCE_DC,
			ircLD_SAMPLE_DETAI.DEPARTMENT_CORRESPONDENCE_DC,
			ircLD_SAMPLE_DETAI.ADDRESS_CORRESPONDENCE_DC,
			ircLD_SAMPLE_DETAI.EMAIL_DC,
			ircLD_SAMPLE_DETAI.DESTINATION_SUBSCRIBER_DC,
			ircLD_SAMPLE_DETAI.CEL_PHONE_DC,
			ircLD_SAMPLE_DETAI.CITY_CORRESPONDENCE_DANE_CODE,
			ircLD_SAMPLE_DETAI.FILLER
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_SAMPLE_DETAI));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_SAMPLE_DETAI in out nocopy tytbLD_SAMPLE_DETAI
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_SAMPLE_DETAI,blUseRowID);
		forall n in iotbLD_SAMPLE_DETAI.first..iotbLD_SAMPLE_DETAI.last
			insert into LD_SAMPLE_DETAI
			(
				NOTIFICATION,
				IS_APPROVED,
				SOURCE,
				SUBSCRIBER_ID,
				PRODUCT_ID,
				SUBSCRIPTION_ID,
				SAMPLE_ID,
				RESERVED_CF,
				BRANCH_CODE_CF,
				QUALITY_CF,
				RATINGS_CF,
				STATE_STATUS_HOLDER_CF,
				STATE_CF,
				MORA_YEARS_CF,
				STATEMENT_DATE_CF,
				INITIAL_ISSUE_DATE_CF,
				TERMINATION_DATE_CF,
				DUE_DATE_CF,
				EXTICION_MODE_ID_CF,
				TYPE_PAYMENT_CF,
				FIXED_CHARGE_VALUE_CF,
				CREDIT_LINE_CF,
				RESTRUCTURATED_OBLIGATION_CF,
				NUMBER_OF_RESTRUCTURING_CF,
				NUMBER_OF_RETURNED_CHECKS_CF,
				TERM_CF,
				DAYS_OF_PORTFOLIO_CF,
				THIRD_HOUSE_ADDRESS_CF,
				THIRD_HOME_PHONE_CF,
				EVERY_CITY_CODE_CF,
				TOWN_HOUSE_PARTY_CF,
				HOME_DEPARTMENT_CODE_CF,
				DEPARTMENT_OF_THIRD_HOUSE_CF,
				COMPANY_NAME_CF,
				COMPANY_ADDRESS_CF,
				COMPANY_PHONE_CF,
				CITY_CODE_CF,
				NOW_CITY_OF_THIRD_CF,
				DEPARTAMENT_CODE_CF,
				THIRD_COMPANY_DEPARTMENT_CF,
				NAT_RESTRUCTURING_CF,
				DETAIL_SAMPLE_ID,
				LEGAL_NATURE,
				VALUE_OF_COLLATERAL,
				SERVICE_CATEGORY,
				TYPE_OF_ACCOUNT,
				SPACE_OVERDRAFT,
				AUTHORIZED_DAYS,
				DEFAULT_MORA_AGE_ID_CF,
				TYPE_PORTFOLIO_ID_CF,
				NUMBER_MONTHS_CONTRACT_CF,
				CREDIT_MODE,
				NIVEL,
				START_DATE_EXCENSION_GMF_CF,
				TERMINATION_DATE_EXC_GMF_CF,
				NUMBER_OF_RENEWAL_CDT_CF,
				GMF_FREE_SAVINGS_CTA_CF,
				NATIVE_TYPE_IDENTIFICATION_CF,
				IDENT_NUMBER_OF_NATIVE_CF,
				ENTITY_TYPE_NATIVE_CF,
				ENTITY_CODE_ORIGINATING_CF,
				TYPE_OF_TRUST_CF,
				NUMBER_OF_TRUST_CF,
				NAME_TRUST_CF,
				TYPE_OF_DEBT_PORTFOLIO_CF,
				POLICY_TYPE_CF,
				RAMIFICATION_CODE,
				DATE_OF_PRESCRIPTION,
				SCORE,
				TYPE_IDENTIFICATION_DC,
				TYPE_IDENTIFICATION_CF,
				IDENTIFICATION_NUMBER,
				RECORD_TYPE_ID_CF,
				FULL_NAME,
				ACCOUNT_NUMBER,
				BRANCH_OFFICE_CF,
				SITUATION_HOLDER_DC,
				OPENING_DATE,
				DUE_DATE_DC,
				RESPONSIBLE_DC,
				TYPE_OBLIGATION_ID_DC,
				MORTGAGE_SUBSIDY_DC,
				DATE_SUBSIDY_DC,
				TYPE_CONTRACT_ID_CF,
				STATE_OF_CONTRACT_CF,
				TERM_CONTRACT_CF,
				TERM_CONTRACT_DC,
				METHOD_PAYMENT_ID_CF,
				METHOD_PAYMENT_ID_DC,
				PERIODICITY_ID_DC,
				PERIODICITY_ID_CF,
				NEW_PORTFOLIO_ID_DC,
				STATE_OBLIGATION_CF,
				SITUATION_HOLDER_CF,
				ACCOUNT_STATE_ID_DC,
				DATE_STATUS_ORIGIN,
				SOURCE_STATE_ID,
				DATE_STATUS_ACCOUNT,
				STATUS_PLASTIC_DC,
				DATE_STATUS_PLASTIC_DC,
				ADJETIVE_DC,
				DATE_ADJETIVE_DC,
				CARD_CLASS_DC,
				FRANCHISE_DC,
				PRIVATE_BRAND_NAME_DC,
				TYPE_MONEY_DC,
				TYPE_WARRANTY_DC,
				RATINGS_DC,
				PROBABILITY_DEFAULT_DC,
				MORA_AGE,
				INITIAL_VALUES_DC,
				DEBT_TO_DC,
				VALUE_AVAILABLE,
				MONTHLY_VALUE,
				VALUE_DELAY,
				TOTAL_SHARES,
				SHARES_CANCELED,
				SHARES_DEBT,
				CLAUSE_PERMANENCE_DC,
				DATE_CLAUSE_PERMANENCE_DC,
				PAYMENT_DEADLINE_DC,
				PAYMENT_DATE,
				RADICATION_OFFICE_DC,
				CITY_RADICATION_OFFICE_DC,
				CITY_RADI_OFFI_DANE_COD_DC,
				RESIDENTIAL_CITY_DC,
				CITY_RESI_OFFI_DANE_COD_DC,
				RESIDENTIAL_DEPARTMENT_DC,
				RESIDENTIAL_ADDRESS_DC,
				RESIDENTIAL_PHONE_DC,
				CITY_WORK_DC,
				CITY_WORK_DANE_CODE_DC,
				DEPARTMENT_WORK_DC,
				ADDRESS_WORK_DC,
				PHONE_WORK_DC,
				CITY_CORRESPONDENCE_DC,
				DEPARTMENT_CORRESPONDENCE_DC,
				ADDRESS_CORRESPONDENCE_DC,
				EMAIL_DC,
				DESTINATION_SUBSCRIBER_DC,
				CEL_PHONE_DC,
				CITY_CORRESPONDENCE_DANE_CODE,
				FILLER
			)
			values
			(
				rcRecOfTab.NOTIFICATION(n),
				rcRecOfTab.IS_APPROVED(n),
				rcRecOfTab.SOURCE(n),
				rcRecOfTab.SUBSCRIBER_ID(n),
				rcRecOfTab.PRODUCT_ID(n),
				rcRecOfTab.SUBSCRIPTION_ID(n),
				rcRecOfTab.SAMPLE_ID(n),
				rcRecOfTab.RESERVED_CF(n),
				rcRecOfTab.BRANCH_CODE_CF(n),
				rcRecOfTab.QUALITY_CF(n),
				rcRecOfTab.RATINGS_CF(n),
				rcRecOfTab.STATE_STATUS_HOLDER_CF(n),
				rcRecOfTab.STATE_CF(n),
				rcRecOfTab.MORA_YEARS_CF(n),
				rcRecOfTab.STATEMENT_DATE_CF(n),
				rcRecOfTab.INITIAL_ISSUE_DATE_CF(n),
				rcRecOfTab.TERMINATION_DATE_CF(n),
				rcRecOfTab.DUE_DATE_CF(n),
				rcRecOfTab.EXTICION_MODE_ID_CF(n),
				rcRecOfTab.TYPE_PAYMENT_CF(n),
				rcRecOfTab.FIXED_CHARGE_VALUE_CF(n),
				rcRecOfTab.CREDIT_LINE_CF(n),
				rcRecOfTab.RESTRUCTURATED_OBLIGATION_CF(n),
				rcRecOfTab.NUMBER_OF_RESTRUCTURING_CF(n),
				rcRecOfTab.NUMBER_OF_RETURNED_CHECKS_CF(n),
				rcRecOfTab.TERM_CF(n),
				rcRecOfTab.DAYS_OF_PORTFOLIO_CF(n),
				rcRecOfTab.THIRD_HOUSE_ADDRESS_CF(n),
				rcRecOfTab.THIRD_HOME_PHONE_CF(n),
				rcRecOfTab.EVERY_CITY_CODE_CF(n),
				rcRecOfTab.TOWN_HOUSE_PARTY_CF(n),
				rcRecOfTab.HOME_DEPARTMENT_CODE_CF(n),
				rcRecOfTab.DEPARTMENT_OF_THIRD_HOUSE_CF(n),
				rcRecOfTab.COMPANY_NAME_CF(n),
				rcRecOfTab.COMPANY_ADDRESS_CF(n),
				rcRecOfTab.COMPANY_PHONE_CF(n),
				rcRecOfTab.CITY_CODE_CF(n),
				rcRecOfTab.NOW_CITY_OF_THIRD_CF(n),
				rcRecOfTab.DEPARTAMENT_CODE_CF(n),
				rcRecOfTab.THIRD_COMPANY_DEPARTMENT_CF(n),
				rcRecOfTab.NAT_RESTRUCTURING_CF(n),
				rcRecOfTab.DETAIL_SAMPLE_ID(n),
				rcRecOfTab.LEGAL_NATURE(n),
				rcRecOfTab.VALUE_OF_COLLATERAL(n),
				rcRecOfTab.SERVICE_CATEGORY(n),
				rcRecOfTab.TYPE_OF_ACCOUNT(n),
				rcRecOfTab.SPACE_OVERDRAFT(n),
				rcRecOfTab.AUTHORIZED_DAYS(n),
				rcRecOfTab.DEFAULT_MORA_AGE_ID_CF(n),
				rcRecOfTab.TYPE_PORTFOLIO_ID_CF(n),
				rcRecOfTab.NUMBER_MONTHS_CONTRACT_CF(n),
				rcRecOfTab.CREDIT_MODE(n),
				rcRecOfTab.NIVEL(n),
				rcRecOfTab.START_DATE_EXCENSION_GMF_CF(n),
				rcRecOfTab.TERMINATION_DATE_EXC_GMF_CF(n),
				rcRecOfTab.NUMBER_OF_RENEWAL_CDT_CF(n),
				rcRecOfTab.GMF_FREE_SAVINGS_CTA_CF(n),
				rcRecOfTab.NATIVE_TYPE_IDENTIFICATION_CF(n),
				rcRecOfTab.IDENT_NUMBER_OF_NATIVE_CF(n),
				rcRecOfTab.ENTITY_TYPE_NATIVE_CF(n),
				rcRecOfTab.ENTITY_CODE_ORIGINATING_CF(n),
				rcRecOfTab.TYPE_OF_TRUST_CF(n),
				rcRecOfTab.NUMBER_OF_TRUST_CF(n),
				rcRecOfTab.NAME_TRUST_CF(n),
				rcRecOfTab.TYPE_OF_DEBT_PORTFOLIO_CF(n),
				rcRecOfTab.POLICY_TYPE_CF(n),
				rcRecOfTab.RAMIFICATION_CODE(n),
				rcRecOfTab.DATE_OF_PRESCRIPTION(n),
				rcRecOfTab.SCORE(n),
				rcRecOfTab.TYPE_IDENTIFICATION_DC(n),
				rcRecOfTab.TYPE_IDENTIFICATION_CF(n),
				rcRecOfTab.IDENTIFICATION_NUMBER(n),
				rcRecOfTab.RECORD_TYPE_ID_CF(n),
				rcRecOfTab.FULL_NAME(n),
				rcRecOfTab.ACCOUNT_NUMBER(n),
				rcRecOfTab.BRANCH_OFFICE_CF(n),
				rcRecOfTab.SITUATION_HOLDER_DC(n),
				rcRecOfTab.OPENING_DATE(n),
				rcRecOfTab.DUE_DATE_DC(n),
				rcRecOfTab.RESPONSIBLE_DC(n),
				rcRecOfTab.TYPE_OBLIGATION_ID_DC(n),
				rcRecOfTab.MORTGAGE_SUBSIDY_DC(n),
				rcRecOfTab.DATE_SUBSIDY_DC(n),
				rcRecOfTab.TYPE_CONTRACT_ID_CF(n),
				rcRecOfTab.STATE_OF_CONTRACT_CF(n),
				rcRecOfTab.TERM_CONTRACT_CF(n),
				rcRecOfTab.TERM_CONTRACT_DC(n),
				rcRecOfTab.METHOD_PAYMENT_ID_CF(n),
				rcRecOfTab.METHOD_PAYMENT_ID_DC(n),
				rcRecOfTab.PERIODICITY_ID_DC(n),
				rcRecOfTab.PERIODICITY_ID_CF(n),
				rcRecOfTab.NEW_PORTFOLIO_ID_DC(n),
				rcRecOfTab.STATE_OBLIGATION_CF(n),
				rcRecOfTab.SITUATION_HOLDER_CF(n),
				rcRecOfTab.ACCOUNT_STATE_ID_DC(n),
				rcRecOfTab.DATE_STATUS_ORIGIN(n),
				rcRecOfTab.SOURCE_STATE_ID(n),
				rcRecOfTab.DATE_STATUS_ACCOUNT(n),
				rcRecOfTab.STATUS_PLASTIC_DC(n),
				rcRecOfTab.DATE_STATUS_PLASTIC_DC(n),
				rcRecOfTab.ADJETIVE_DC(n),
				rcRecOfTab.DATE_ADJETIVE_DC(n),
				rcRecOfTab.CARD_CLASS_DC(n),
				rcRecOfTab.FRANCHISE_DC(n),
				rcRecOfTab.PRIVATE_BRAND_NAME_DC(n),
				rcRecOfTab.TYPE_MONEY_DC(n),
				rcRecOfTab.TYPE_WARRANTY_DC(n),
				rcRecOfTab.RATINGS_DC(n),
				rcRecOfTab.PROBABILITY_DEFAULT_DC(n),
				rcRecOfTab.MORA_AGE(n),
				rcRecOfTab.INITIAL_VALUES_DC(n),
				rcRecOfTab.DEBT_TO_DC(n),
				rcRecOfTab.VALUE_AVAILABLE(n),
				rcRecOfTab.MONTHLY_VALUE(n),
				rcRecOfTab.VALUE_DELAY(n),
				rcRecOfTab.TOTAL_SHARES(n),
				rcRecOfTab.SHARES_CANCELED(n),
				rcRecOfTab.SHARES_DEBT(n),
				rcRecOfTab.CLAUSE_PERMANENCE_DC(n),
				rcRecOfTab.DATE_CLAUSE_PERMANENCE_DC(n),
				rcRecOfTab.PAYMENT_DEADLINE_DC(n),
				rcRecOfTab.PAYMENT_DATE(n),
				rcRecOfTab.RADICATION_OFFICE_DC(n),
				rcRecOfTab.CITY_RADICATION_OFFICE_DC(n),
				rcRecOfTab.CITY_RADI_OFFI_DANE_COD_DC(n),
				rcRecOfTab.RESIDENTIAL_CITY_DC(n),
				rcRecOfTab.CITY_RESI_OFFI_DANE_COD_DC(n),
				rcRecOfTab.RESIDENTIAL_DEPARTMENT_DC(n),
				rcRecOfTab.RESIDENTIAL_ADDRESS_DC(n),
				rcRecOfTab.RESIDENTIAL_PHONE_DC(n),
				rcRecOfTab.CITY_WORK_DC(n),
				rcRecOfTab.CITY_WORK_DANE_CODE_DC(n),
				rcRecOfTab.DEPARTMENT_WORK_DC(n),
				rcRecOfTab.ADDRESS_WORK_DC(n),
				rcRecOfTab.PHONE_WORK_DC(n),
				rcRecOfTab.CITY_CORRESPONDENCE_DC(n),
				rcRecOfTab.DEPARTMENT_CORRESPONDENCE_DC(n),
				rcRecOfTab.ADDRESS_CORRESPONDENCE_DC(n),
				rcRecOfTab.EMAIL_DC(n),
				rcRecOfTab.DESTINATION_SUBSCRIBER_DC(n),
				rcRecOfTab.CEL_PHONE_DC(n),
				rcRecOfTab.CITY_CORRESPONDENCE_DANE_CODE(n),
				rcRecOfTab.FILLER(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;


		delete
		from LD_SAMPLE_DETAI
		where
       		DETAIL_SAMPLE_ID=inuDETAIL_SAMPLE_ID and
       		SAMPLE_ID=inuSAMPLE_ID;
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
		rcError  styLD_SAMPLE_DETAI;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_SAMPLE_DETAI
		where
			rowid = iriRowID
		returning
			NOTIFICATION,
			IS_APPROVED
		into
			rcError.NOTIFICATION,
			rcError.IS_APPROVED;
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
		iotbLD_SAMPLE_DETAI in out nocopy tytbLD_SAMPLE_DETAI,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_SAMPLE_DETAI;
	BEGIN
		FillRecordOfTables(iotbLD_SAMPLE_DETAI, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_SAMPLE_DETAI.first .. iotbLD_SAMPLE_DETAI.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SAMPLE_DETAI.first .. iotbLD_SAMPLE_DETAI.last
				delete
				from LD_SAMPLE_DETAI
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_SAMPLE_DETAI.first .. iotbLD_SAMPLE_DETAI.last loop
					LockByPk
					(
						rcRecOfTab.DETAIL_SAMPLE_ID(n),
						rcRecOfTab.SAMPLE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SAMPLE_DETAI.first .. iotbLD_SAMPLE_DETAI.last
				delete
				from LD_SAMPLE_DETAI
				where
		         	DETAIL_SAMPLE_ID = rcRecOfTab.DETAIL_SAMPLE_ID(n) and
		         	SAMPLE_ID = rcRecOfTab.SAMPLE_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_SAMPLE_DETAI in styLD_SAMPLE_DETAI,
		inuLock in number default 0
	)
	IS
		nuDETAIL_SAMPLE_ID	LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type;
		nuSAMPLE_ID	LD_SAMPLE_DETAI.SAMPLE_ID%type;
	BEGIN
		if ircLD_SAMPLE_DETAI.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_SAMPLE_DETAI.rowid,rcData);
			end if;
			update LD_SAMPLE_DETAI
			set
				NOTIFICATION = ircLD_SAMPLE_DETAI.NOTIFICATION,
				IS_APPROVED = ircLD_SAMPLE_DETAI.IS_APPROVED,
				SOURCE = ircLD_SAMPLE_DETAI.SOURCE,
				SUBSCRIBER_ID = ircLD_SAMPLE_DETAI.SUBSCRIBER_ID,
				PRODUCT_ID = ircLD_SAMPLE_DETAI.PRODUCT_ID,
				SUBSCRIPTION_ID = ircLD_SAMPLE_DETAI.SUBSCRIPTION_ID,
				RESERVED_CF = ircLD_SAMPLE_DETAI.RESERVED_CF,
				BRANCH_CODE_CF = ircLD_SAMPLE_DETAI.BRANCH_CODE_CF,
				QUALITY_CF = ircLD_SAMPLE_DETAI.QUALITY_CF,
				RATINGS_CF = ircLD_SAMPLE_DETAI.RATINGS_CF,
				STATE_STATUS_HOLDER_CF = ircLD_SAMPLE_DETAI.STATE_STATUS_HOLDER_CF,
				STATE_CF = ircLD_SAMPLE_DETAI.STATE_CF,
				MORA_YEARS_CF = ircLD_SAMPLE_DETAI.MORA_YEARS_CF,
				STATEMENT_DATE_CF = ircLD_SAMPLE_DETAI.STATEMENT_DATE_CF,
				INITIAL_ISSUE_DATE_CF = ircLD_SAMPLE_DETAI.INITIAL_ISSUE_DATE_CF,
				TERMINATION_DATE_CF = ircLD_SAMPLE_DETAI.TERMINATION_DATE_CF,
				DUE_DATE_CF = ircLD_SAMPLE_DETAI.DUE_DATE_CF,
				EXTICION_MODE_ID_CF = ircLD_SAMPLE_DETAI.EXTICION_MODE_ID_CF,
				TYPE_PAYMENT_CF = ircLD_SAMPLE_DETAI.TYPE_PAYMENT_CF,
				FIXED_CHARGE_VALUE_CF = ircLD_SAMPLE_DETAI.FIXED_CHARGE_VALUE_CF,
				CREDIT_LINE_CF = ircLD_SAMPLE_DETAI.CREDIT_LINE_CF,
				RESTRUCTURATED_OBLIGATION_CF = ircLD_SAMPLE_DETAI.RESTRUCTURATED_OBLIGATION_CF,
				NUMBER_OF_RESTRUCTURING_CF = ircLD_SAMPLE_DETAI.NUMBER_OF_RESTRUCTURING_CF,
				NUMBER_OF_RETURNED_CHECKS_CF = ircLD_SAMPLE_DETAI.NUMBER_OF_RETURNED_CHECKS_CF,
				TERM_CF = ircLD_SAMPLE_DETAI.TERM_CF,
				DAYS_OF_PORTFOLIO_CF = ircLD_SAMPLE_DETAI.DAYS_OF_PORTFOLIO_CF,
				THIRD_HOUSE_ADDRESS_CF = ircLD_SAMPLE_DETAI.THIRD_HOUSE_ADDRESS_CF,
				THIRD_HOME_PHONE_CF = ircLD_SAMPLE_DETAI.THIRD_HOME_PHONE_CF,
				EVERY_CITY_CODE_CF = ircLD_SAMPLE_DETAI.EVERY_CITY_CODE_CF,
				TOWN_HOUSE_PARTY_CF = ircLD_SAMPLE_DETAI.TOWN_HOUSE_PARTY_CF,
				HOME_DEPARTMENT_CODE_CF = ircLD_SAMPLE_DETAI.HOME_DEPARTMENT_CODE_CF,
				DEPARTMENT_OF_THIRD_HOUSE_CF = ircLD_SAMPLE_DETAI.DEPARTMENT_OF_THIRD_HOUSE_CF,
				COMPANY_NAME_CF = ircLD_SAMPLE_DETAI.COMPANY_NAME_CF,
				COMPANY_ADDRESS_CF = ircLD_SAMPLE_DETAI.COMPANY_ADDRESS_CF,
				COMPANY_PHONE_CF = ircLD_SAMPLE_DETAI.COMPANY_PHONE_CF,
				CITY_CODE_CF = ircLD_SAMPLE_DETAI.CITY_CODE_CF,
				NOW_CITY_OF_THIRD_CF = ircLD_SAMPLE_DETAI.NOW_CITY_OF_THIRD_CF,
				DEPARTAMENT_CODE_CF = ircLD_SAMPLE_DETAI.DEPARTAMENT_CODE_CF,
				THIRD_COMPANY_DEPARTMENT_CF = ircLD_SAMPLE_DETAI.THIRD_COMPANY_DEPARTMENT_CF,
				NAT_RESTRUCTURING_CF = ircLD_SAMPLE_DETAI.NAT_RESTRUCTURING_CF,
				LEGAL_NATURE = ircLD_SAMPLE_DETAI.LEGAL_NATURE,
				VALUE_OF_COLLATERAL = ircLD_SAMPLE_DETAI.VALUE_OF_COLLATERAL,
				SERVICE_CATEGORY = ircLD_SAMPLE_DETAI.SERVICE_CATEGORY,
				TYPE_OF_ACCOUNT = ircLD_SAMPLE_DETAI.TYPE_OF_ACCOUNT,
				SPACE_OVERDRAFT = ircLD_SAMPLE_DETAI.SPACE_OVERDRAFT,
				AUTHORIZED_DAYS = ircLD_SAMPLE_DETAI.AUTHORIZED_DAYS,
				DEFAULT_MORA_AGE_ID_CF = ircLD_SAMPLE_DETAI.DEFAULT_MORA_AGE_ID_CF,
				TYPE_PORTFOLIO_ID_CF = ircLD_SAMPLE_DETAI.TYPE_PORTFOLIO_ID_CF,
				NUMBER_MONTHS_CONTRACT_CF = ircLD_SAMPLE_DETAI.NUMBER_MONTHS_CONTRACT_CF,
				CREDIT_MODE = ircLD_SAMPLE_DETAI.CREDIT_MODE,
				NIVEL = ircLD_SAMPLE_DETAI.NIVEL,
				START_DATE_EXCENSION_GMF_CF = ircLD_SAMPLE_DETAI.START_DATE_EXCENSION_GMF_CF,
				TERMINATION_DATE_EXC_GMF_CF = ircLD_SAMPLE_DETAI.TERMINATION_DATE_EXC_GMF_CF,
				NUMBER_OF_RENEWAL_CDT_CF = ircLD_SAMPLE_DETAI.NUMBER_OF_RENEWAL_CDT_CF,
				GMF_FREE_SAVINGS_CTA_CF = ircLD_SAMPLE_DETAI.GMF_FREE_SAVINGS_CTA_CF,
				NATIVE_TYPE_IDENTIFICATION_CF = ircLD_SAMPLE_DETAI.NATIVE_TYPE_IDENTIFICATION_CF,
				IDENT_NUMBER_OF_NATIVE_CF = ircLD_SAMPLE_DETAI.IDENT_NUMBER_OF_NATIVE_CF,
				ENTITY_TYPE_NATIVE_CF = ircLD_SAMPLE_DETAI.ENTITY_TYPE_NATIVE_CF,
				ENTITY_CODE_ORIGINATING_CF = ircLD_SAMPLE_DETAI.ENTITY_CODE_ORIGINATING_CF,
				TYPE_OF_TRUST_CF = ircLD_SAMPLE_DETAI.TYPE_OF_TRUST_CF,
				NUMBER_OF_TRUST_CF = ircLD_SAMPLE_DETAI.NUMBER_OF_TRUST_CF,
				NAME_TRUST_CF = ircLD_SAMPLE_DETAI.NAME_TRUST_CF,
				TYPE_OF_DEBT_PORTFOLIO_CF = ircLD_SAMPLE_DETAI.TYPE_OF_DEBT_PORTFOLIO_CF,
				POLICY_TYPE_CF = ircLD_SAMPLE_DETAI.POLICY_TYPE_CF,
				RAMIFICATION_CODE = ircLD_SAMPLE_DETAI.RAMIFICATION_CODE,
				DATE_OF_PRESCRIPTION = ircLD_SAMPLE_DETAI.DATE_OF_PRESCRIPTION,
				SCORE = ircLD_SAMPLE_DETAI.SCORE,
				TYPE_IDENTIFICATION_DC = ircLD_SAMPLE_DETAI.TYPE_IDENTIFICATION_DC,
				TYPE_IDENTIFICATION_CF = ircLD_SAMPLE_DETAI.TYPE_IDENTIFICATION_CF,
				IDENTIFICATION_NUMBER = ircLD_SAMPLE_DETAI.IDENTIFICATION_NUMBER,
				RECORD_TYPE_ID_CF = ircLD_SAMPLE_DETAI.RECORD_TYPE_ID_CF,
				FULL_NAME = ircLD_SAMPLE_DETAI.FULL_NAME,
				ACCOUNT_NUMBER = ircLD_SAMPLE_DETAI.ACCOUNT_NUMBER,
				BRANCH_OFFICE_CF = ircLD_SAMPLE_DETAI.BRANCH_OFFICE_CF,
				SITUATION_HOLDER_DC = ircLD_SAMPLE_DETAI.SITUATION_HOLDER_DC,
				OPENING_DATE = ircLD_SAMPLE_DETAI.OPENING_DATE,
				DUE_DATE_DC = ircLD_SAMPLE_DETAI.DUE_DATE_DC,
				RESPONSIBLE_DC = ircLD_SAMPLE_DETAI.RESPONSIBLE_DC,
				TYPE_OBLIGATION_ID_DC = ircLD_SAMPLE_DETAI.TYPE_OBLIGATION_ID_DC,
				MORTGAGE_SUBSIDY_DC = ircLD_SAMPLE_DETAI.MORTGAGE_SUBSIDY_DC,
				DATE_SUBSIDY_DC = ircLD_SAMPLE_DETAI.DATE_SUBSIDY_DC,
				TYPE_CONTRACT_ID_CF = ircLD_SAMPLE_DETAI.TYPE_CONTRACT_ID_CF,
				STATE_OF_CONTRACT_CF = ircLD_SAMPLE_DETAI.STATE_OF_CONTRACT_CF,
				TERM_CONTRACT_CF = ircLD_SAMPLE_DETAI.TERM_CONTRACT_CF,
				TERM_CONTRACT_DC = ircLD_SAMPLE_DETAI.TERM_CONTRACT_DC,
				METHOD_PAYMENT_ID_CF = ircLD_SAMPLE_DETAI.METHOD_PAYMENT_ID_CF,
				METHOD_PAYMENT_ID_DC = ircLD_SAMPLE_DETAI.METHOD_PAYMENT_ID_DC,
				PERIODICITY_ID_DC = ircLD_SAMPLE_DETAI.PERIODICITY_ID_DC,
				PERIODICITY_ID_CF = ircLD_SAMPLE_DETAI.PERIODICITY_ID_CF,
				NEW_PORTFOLIO_ID_DC = ircLD_SAMPLE_DETAI.NEW_PORTFOLIO_ID_DC,
				STATE_OBLIGATION_CF = ircLD_SAMPLE_DETAI.STATE_OBLIGATION_CF,
				SITUATION_HOLDER_CF = ircLD_SAMPLE_DETAI.SITUATION_HOLDER_CF,
				ACCOUNT_STATE_ID_DC = ircLD_SAMPLE_DETAI.ACCOUNT_STATE_ID_DC,
				DATE_STATUS_ORIGIN = ircLD_SAMPLE_DETAI.DATE_STATUS_ORIGIN,
				SOURCE_STATE_ID = ircLD_SAMPLE_DETAI.SOURCE_STATE_ID,
				DATE_STATUS_ACCOUNT = ircLD_SAMPLE_DETAI.DATE_STATUS_ACCOUNT,
				STATUS_PLASTIC_DC = ircLD_SAMPLE_DETAI.STATUS_PLASTIC_DC,
				DATE_STATUS_PLASTIC_DC = ircLD_SAMPLE_DETAI.DATE_STATUS_PLASTIC_DC,
				ADJETIVE_DC = ircLD_SAMPLE_DETAI.ADJETIVE_DC,
				DATE_ADJETIVE_DC = ircLD_SAMPLE_DETAI.DATE_ADJETIVE_DC,
				CARD_CLASS_DC = ircLD_SAMPLE_DETAI.CARD_CLASS_DC,
				FRANCHISE_DC = ircLD_SAMPLE_DETAI.FRANCHISE_DC,
				PRIVATE_BRAND_NAME_DC = ircLD_SAMPLE_DETAI.PRIVATE_BRAND_NAME_DC,
				TYPE_MONEY_DC = ircLD_SAMPLE_DETAI.TYPE_MONEY_DC,
				TYPE_WARRANTY_DC = ircLD_SAMPLE_DETAI.TYPE_WARRANTY_DC,
				RATINGS_DC = ircLD_SAMPLE_DETAI.RATINGS_DC,
				PROBABILITY_DEFAULT_DC = ircLD_SAMPLE_DETAI.PROBABILITY_DEFAULT_DC,
				MORA_AGE = ircLD_SAMPLE_DETAI.MORA_AGE,
				INITIAL_VALUES_DC = ircLD_SAMPLE_DETAI.INITIAL_VALUES_DC,
				DEBT_TO_DC = ircLD_SAMPLE_DETAI.DEBT_TO_DC,
				VALUE_AVAILABLE = ircLD_SAMPLE_DETAI.VALUE_AVAILABLE,
				MONTHLY_VALUE = ircLD_SAMPLE_DETAI.MONTHLY_VALUE,
				VALUE_DELAY = ircLD_SAMPLE_DETAI.VALUE_DELAY,
				TOTAL_SHARES = ircLD_SAMPLE_DETAI.TOTAL_SHARES,
				SHARES_CANCELED = ircLD_SAMPLE_DETAI.SHARES_CANCELED,
				SHARES_DEBT = ircLD_SAMPLE_DETAI.SHARES_DEBT,
				CLAUSE_PERMANENCE_DC = ircLD_SAMPLE_DETAI.CLAUSE_PERMANENCE_DC,
				DATE_CLAUSE_PERMANENCE_DC = ircLD_SAMPLE_DETAI.DATE_CLAUSE_PERMANENCE_DC,
				PAYMENT_DEADLINE_DC = ircLD_SAMPLE_DETAI.PAYMENT_DEADLINE_DC,
				PAYMENT_DATE = ircLD_SAMPLE_DETAI.PAYMENT_DATE,
				RADICATION_OFFICE_DC = ircLD_SAMPLE_DETAI.RADICATION_OFFICE_DC,
				CITY_RADICATION_OFFICE_DC = ircLD_SAMPLE_DETAI.CITY_RADICATION_OFFICE_DC,
				CITY_RADI_OFFI_DANE_COD_DC = ircLD_SAMPLE_DETAI.CITY_RADI_OFFI_DANE_COD_DC,
				RESIDENTIAL_CITY_DC = ircLD_SAMPLE_DETAI.RESIDENTIAL_CITY_DC,
				CITY_RESI_OFFI_DANE_COD_DC = ircLD_SAMPLE_DETAI.CITY_RESI_OFFI_DANE_COD_DC,
				RESIDENTIAL_DEPARTMENT_DC = ircLD_SAMPLE_DETAI.RESIDENTIAL_DEPARTMENT_DC,
				RESIDENTIAL_ADDRESS_DC = ircLD_SAMPLE_DETAI.RESIDENTIAL_ADDRESS_DC,
				RESIDENTIAL_PHONE_DC = ircLD_SAMPLE_DETAI.RESIDENTIAL_PHONE_DC,
				CITY_WORK_DC = ircLD_SAMPLE_DETAI.CITY_WORK_DC,
				CITY_WORK_DANE_CODE_DC = ircLD_SAMPLE_DETAI.CITY_WORK_DANE_CODE_DC,
				DEPARTMENT_WORK_DC = ircLD_SAMPLE_DETAI.DEPARTMENT_WORK_DC,
				ADDRESS_WORK_DC = ircLD_SAMPLE_DETAI.ADDRESS_WORK_DC,
				PHONE_WORK_DC = ircLD_SAMPLE_DETAI.PHONE_WORK_DC,
				CITY_CORRESPONDENCE_DC = ircLD_SAMPLE_DETAI.CITY_CORRESPONDENCE_DC,
				DEPARTMENT_CORRESPONDENCE_DC = ircLD_SAMPLE_DETAI.DEPARTMENT_CORRESPONDENCE_DC,
				ADDRESS_CORRESPONDENCE_DC = ircLD_SAMPLE_DETAI.ADDRESS_CORRESPONDENCE_DC,
				EMAIL_DC = ircLD_SAMPLE_DETAI.EMAIL_DC,
				DESTINATION_SUBSCRIBER_DC = ircLD_SAMPLE_DETAI.DESTINATION_SUBSCRIBER_DC,
				CEL_PHONE_DC = ircLD_SAMPLE_DETAI.CEL_PHONE_DC,
				CITY_CORRESPONDENCE_DANE_CODE = ircLD_SAMPLE_DETAI.CITY_CORRESPONDENCE_DANE_CODE,
				FILLER = ircLD_SAMPLE_DETAI.FILLER
			where
				rowid = ircLD_SAMPLE_DETAI.rowid
			returning
				DETAIL_SAMPLE_ID,
				SAMPLE_ID
			into
				nuDETAIL_SAMPLE_ID,
				nuSAMPLE_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_SAMPLE_DETAI.DETAIL_SAMPLE_ID,
					ircLD_SAMPLE_DETAI.SAMPLE_ID,
					rcData
				);
			end if;

			update LD_SAMPLE_DETAI
			set
				NOTIFICATION = ircLD_SAMPLE_DETAI.NOTIFICATION,
				IS_APPROVED = ircLD_SAMPLE_DETAI.IS_APPROVED,
				SOURCE = ircLD_SAMPLE_DETAI.SOURCE,
				SUBSCRIBER_ID = ircLD_SAMPLE_DETAI.SUBSCRIBER_ID,
				PRODUCT_ID = ircLD_SAMPLE_DETAI.PRODUCT_ID,
				SUBSCRIPTION_ID = ircLD_SAMPLE_DETAI.SUBSCRIPTION_ID,
				RESERVED_CF = ircLD_SAMPLE_DETAI.RESERVED_CF,
				BRANCH_CODE_CF = ircLD_SAMPLE_DETAI.BRANCH_CODE_CF,
				QUALITY_CF = ircLD_SAMPLE_DETAI.QUALITY_CF,
				RATINGS_CF = ircLD_SAMPLE_DETAI.RATINGS_CF,
				STATE_STATUS_HOLDER_CF = ircLD_SAMPLE_DETAI.STATE_STATUS_HOLDER_CF,
				STATE_CF = ircLD_SAMPLE_DETAI.STATE_CF,
				MORA_YEARS_CF = ircLD_SAMPLE_DETAI.MORA_YEARS_CF,
				STATEMENT_DATE_CF = ircLD_SAMPLE_DETAI.STATEMENT_DATE_CF,
				INITIAL_ISSUE_DATE_CF = ircLD_SAMPLE_DETAI.INITIAL_ISSUE_DATE_CF,
				TERMINATION_DATE_CF = ircLD_SAMPLE_DETAI.TERMINATION_DATE_CF,
				DUE_DATE_CF = ircLD_SAMPLE_DETAI.DUE_DATE_CF,
				EXTICION_MODE_ID_CF = ircLD_SAMPLE_DETAI.EXTICION_MODE_ID_CF,
				TYPE_PAYMENT_CF = ircLD_SAMPLE_DETAI.TYPE_PAYMENT_CF,
				FIXED_CHARGE_VALUE_CF = ircLD_SAMPLE_DETAI.FIXED_CHARGE_VALUE_CF,
				CREDIT_LINE_CF = ircLD_SAMPLE_DETAI.CREDIT_LINE_CF,
				RESTRUCTURATED_OBLIGATION_CF = ircLD_SAMPLE_DETAI.RESTRUCTURATED_OBLIGATION_CF,
				NUMBER_OF_RESTRUCTURING_CF = ircLD_SAMPLE_DETAI.NUMBER_OF_RESTRUCTURING_CF,
				NUMBER_OF_RETURNED_CHECKS_CF = ircLD_SAMPLE_DETAI.NUMBER_OF_RETURNED_CHECKS_CF,
				TERM_CF = ircLD_SAMPLE_DETAI.TERM_CF,
				DAYS_OF_PORTFOLIO_CF = ircLD_SAMPLE_DETAI.DAYS_OF_PORTFOLIO_CF,
				THIRD_HOUSE_ADDRESS_CF = ircLD_SAMPLE_DETAI.THIRD_HOUSE_ADDRESS_CF,
				THIRD_HOME_PHONE_CF = ircLD_SAMPLE_DETAI.THIRD_HOME_PHONE_CF,
				EVERY_CITY_CODE_CF = ircLD_SAMPLE_DETAI.EVERY_CITY_CODE_CF,
				TOWN_HOUSE_PARTY_CF = ircLD_SAMPLE_DETAI.TOWN_HOUSE_PARTY_CF,
				HOME_DEPARTMENT_CODE_CF = ircLD_SAMPLE_DETAI.HOME_DEPARTMENT_CODE_CF,
				DEPARTMENT_OF_THIRD_HOUSE_CF = ircLD_SAMPLE_DETAI.DEPARTMENT_OF_THIRD_HOUSE_CF,
				COMPANY_NAME_CF = ircLD_SAMPLE_DETAI.COMPANY_NAME_CF,
				COMPANY_ADDRESS_CF = ircLD_SAMPLE_DETAI.COMPANY_ADDRESS_CF,
				COMPANY_PHONE_CF = ircLD_SAMPLE_DETAI.COMPANY_PHONE_CF,
				CITY_CODE_CF = ircLD_SAMPLE_DETAI.CITY_CODE_CF,
				NOW_CITY_OF_THIRD_CF = ircLD_SAMPLE_DETAI.NOW_CITY_OF_THIRD_CF,
				DEPARTAMENT_CODE_CF = ircLD_SAMPLE_DETAI.DEPARTAMENT_CODE_CF,
				THIRD_COMPANY_DEPARTMENT_CF = ircLD_SAMPLE_DETAI.THIRD_COMPANY_DEPARTMENT_CF,
				NAT_RESTRUCTURING_CF = ircLD_SAMPLE_DETAI.NAT_RESTRUCTURING_CF,
				LEGAL_NATURE = ircLD_SAMPLE_DETAI.LEGAL_NATURE,
				VALUE_OF_COLLATERAL = ircLD_SAMPLE_DETAI.VALUE_OF_COLLATERAL,
				SERVICE_CATEGORY = ircLD_SAMPLE_DETAI.SERVICE_CATEGORY,
				TYPE_OF_ACCOUNT = ircLD_SAMPLE_DETAI.TYPE_OF_ACCOUNT,
				SPACE_OVERDRAFT = ircLD_SAMPLE_DETAI.SPACE_OVERDRAFT,
				AUTHORIZED_DAYS = ircLD_SAMPLE_DETAI.AUTHORIZED_DAYS,
				DEFAULT_MORA_AGE_ID_CF = ircLD_SAMPLE_DETAI.DEFAULT_MORA_AGE_ID_CF,
				TYPE_PORTFOLIO_ID_CF = ircLD_SAMPLE_DETAI.TYPE_PORTFOLIO_ID_CF,
				NUMBER_MONTHS_CONTRACT_CF = ircLD_SAMPLE_DETAI.NUMBER_MONTHS_CONTRACT_CF,
				CREDIT_MODE = ircLD_SAMPLE_DETAI.CREDIT_MODE,
				NIVEL = ircLD_SAMPLE_DETAI.NIVEL,
				START_DATE_EXCENSION_GMF_CF = ircLD_SAMPLE_DETAI.START_DATE_EXCENSION_GMF_CF,
				TERMINATION_DATE_EXC_GMF_CF = ircLD_SAMPLE_DETAI.TERMINATION_DATE_EXC_GMF_CF,
				NUMBER_OF_RENEWAL_CDT_CF = ircLD_SAMPLE_DETAI.NUMBER_OF_RENEWAL_CDT_CF,
				GMF_FREE_SAVINGS_CTA_CF = ircLD_SAMPLE_DETAI.GMF_FREE_SAVINGS_CTA_CF,
				NATIVE_TYPE_IDENTIFICATION_CF = ircLD_SAMPLE_DETAI.NATIVE_TYPE_IDENTIFICATION_CF,
				IDENT_NUMBER_OF_NATIVE_CF = ircLD_SAMPLE_DETAI.IDENT_NUMBER_OF_NATIVE_CF,
				ENTITY_TYPE_NATIVE_CF = ircLD_SAMPLE_DETAI.ENTITY_TYPE_NATIVE_CF,
				ENTITY_CODE_ORIGINATING_CF = ircLD_SAMPLE_DETAI.ENTITY_CODE_ORIGINATING_CF,
				TYPE_OF_TRUST_CF = ircLD_SAMPLE_DETAI.TYPE_OF_TRUST_CF,
				NUMBER_OF_TRUST_CF = ircLD_SAMPLE_DETAI.NUMBER_OF_TRUST_CF,
				NAME_TRUST_CF = ircLD_SAMPLE_DETAI.NAME_TRUST_CF,
				TYPE_OF_DEBT_PORTFOLIO_CF = ircLD_SAMPLE_DETAI.TYPE_OF_DEBT_PORTFOLIO_CF,
				POLICY_TYPE_CF = ircLD_SAMPLE_DETAI.POLICY_TYPE_CF,
				RAMIFICATION_CODE = ircLD_SAMPLE_DETAI.RAMIFICATION_CODE,
				DATE_OF_PRESCRIPTION = ircLD_SAMPLE_DETAI.DATE_OF_PRESCRIPTION,
				SCORE = ircLD_SAMPLE_DETAI.SCORE,
				TYPE_IDENTIFICATION_DC = ircLD_SAMPLE_DETAI.TYPE_IDENTIFICATION_DC,
				TYPE_IDENTIFICATION_CF = ircLD_SAMPLE_DETAI.TYPE_IDENTIFICATION_CF,
				IDENTIFICATION_NUMBER = ircLD_SAMPLE_DETAI.IDENTIFICATION_NUMBER,
				RECORD_TYPE_ID_CF = ircLD_SAMPLE_DETAI.RECORD_TYPE_ID_CF,
				FULL_NAME = ircLD_SAMPLE_DETAI.FULL_NAME,
				ACCOUNT_NUMBER = ircLD_SAMPLE_DETAI.ACCOUNT_NUMBER,
				BRANCH_OFFICE_CF = ircLD_SAMPLE_DETAI.BRANCH_OFFICE_CF,
				SITUATION_HOLDER_DC = ircLD_SAMPLE_DETAI.SITUATION_HOLDER_DC,
				OPENING_DATE = ircLD_SAMPLE_DETAI.OPENING_DATE,
				DUE_DATE_DC = ircLD_SAMPLE_DETAI.DUE_DATE_DC,
				RESPONSIBLE_DC = ircLD_SAMPLE_DETAI.RESPONSIBLE_DC,
				TYPE_OBLIGATION_ID_DC = ircLD_SAMPLE_DETAI.TYPE_OBLIGATION_ID_DC,
				MORTGAGE_SUBSIDY_DC = ircLD_SAMPLE_DETAI.MORTGAGE_SUBSIDY_DC,
				DATE_SUBSIDY_DC = ircLD_SAMPLE_DETAI.DATE_SUBSIDY_DC,
				TYPE_CONTRACT_ID_CF = ircLD_SAMPLE_DETAI.TYPE_CONTRACT_ID_CF,
				STATE_OF_CONTRACT_CF = ircLD_SAMPLE_DETAI.STATE_OF_CONTRACT_CF,
				TERM_CONTRACT_CF = ircLD_SAMPLE_DETAI.TERM_CONTRACT_CF,
				TERM_CONTRACT_DC = ircLD_SAMPLE_DETAI.TERM_CONTRACT_DC,
				METHOD_PAYMENT_ID_CF = ircLD_SAMPLE_DETAI.METHOD_PAYMENT_ID_CF,
				METHOD_PAYMENT_ID_DC = ircLD_SAMPLE_DETAI.METHOD_PAYMENT_ID_DC,
				PERIODICITY_ID_DC = ircLD_SAMPLE_DETAI.PERIODICITY_ID_DC,
				PERIODICITY_ID_CF = ircLD_SAMPLE_DETAI.PERIODICITY_ID_CF,
				NEW_PORTFOLIO_ID_DC = ircLD_SAMPLE_DETAI.NEW_PORTFOLIO_ID_DC,
				STATE_OBLIGATION_CF = ircLD_SAMPLE_DETAI.STATE_OBLIGATION_CF,
				SITUATION_HOLDER_CF = ircLD_SAMPLE_DETAI.SITUATION_HOLDER_CF,
				ACCOUNT_STATE_ID_DC = ircLD_SAMPLE_DETAI.ACCOUNT_STATE_ID_DC,
				DATE_STATUS_ORIGIN = ircLD_SAMPLE_DETAI.DATE_STATUS_ORIGIN,
				SOURCE_STATE_ID = ircLD_SAMPLE_DETAI.SOURCE_STATE_ID,
				DATE_STATUS_ACCOUNT = ircLD_SAMPLE_DETAI.DATE_STATUS_ACCOUNT,
				STATUS_PLASTIC_DC = ircLD_SAMPLE_DETAI.STATUS_PLASTIC_DC,
				DATE_STATUS_PLASTIC_DC = ircLD_SAMPLE_DETAI.DATE_STATUS_PLASTIC_DC,
				ADJETIVE_DC = ircLD_SAMPLE_DETAI.ADJETIVE_DC,
				DATE_ADJETIVE_DC = ircLD_SAMPLE_DETAI.DATE_ADJETIVE_DC,
				CARD_CLASS_DC = ircLD_SAMPLE_DETAI.CARD_CLASS_DC,
				FRANCHISE_DC = ircLD_SAMPLE_DETAI.FRANCHISE_DC,
				PRIVATE_BRAND_NAME_DC = ircLD_SAMPLE_DETAI.PRIVATE_BRAND_NAME_DC,
				TYPE_MONEY_DC = ircLD_SAMPLE_DETAI.TYPE_MONEY_DC,
				TYPE_WARRANTY_DC = ircLD_SAMPLE_DETAI.TYPE_WARRANTY_DC,
				RATINGS_DC = ircLD_SAMPLE_DETAI.RATINGS_DC,
				PROBABILITY_DEFAULT_DC = ircLD_SAMPLE_DETAI.PROBABILITY_DEFAULT_DC,
				MORA_AGE = ircLD_SAMPLE_DETAI.MORA_AGE,
				INITIAL_VALUES_DC = ircLD_SAMPLE_DETAI.INITIAL_VALUES_DC,
				DEBT_TO_DC = ircLD_SAMPLE_DETAI.DEBT_TO_DC,
				VALUE_AVAILABLE = ircLD_SAMPLE_DETAI.VALUE_AVAILABLE,
				MONTHLY_VALUE = ircLD_SAMPLE_DETAI.MONTHLY_VALUE,
				VALUE_DELAY = ircLD_SAMPLE_DETAI.VALUE_DELAY,
				TOTAL_SHARES = ircLD_SAMPLE_DETAI.TOTAL_SHARES,
				SHARES_CANCELED = ircLD_SAMPLE_DETAI.SHARES_CANCELED,
				SHARES_DEBT = ircLD_SAMPLE_DETAI.SHARES_DEBT,
				CLAUSE_PERMANENCE_DC = ircLD_SAMPLE_DETAI.CLAUSE_PERMANENCE_DC,
				DATE_CLAUSE_PERMANENCE_DC = ircLD_SAMPLE_DETAI.DATE_CLAUSE_PERMANENCE_DC,
				PAYMENT_DEADLINE_DC = ircLD_SAMPLE_DETAI.PAYMENT_DEADLINE_DC,
				PAYMENT_DATE = ircLD_SAMPLE_DETAI.PAYMENT_DATE,
				RADICATION_OFFICE_DC = ircLD_SAMPLE_DETAI.RADICATION_OFFICE_DC,
				CITY_RADICATION_OFFICE_DC = ircLD_SAMPLE_DETAI.CITY_RADICATION_OFFICE_DC,
				CITY_RADI_OFFI_DANE_COD_DC = ircLD_SAMPLE_DETAI.CITY_RADI_OFFI_DANE_COD_DC,
				RESIDENTIAL_CITY_DC = ircLD_SAMPLE_DETAI.RESIDENTIAL_CITY_DC,
				CITY_RESI_OFFI_DANE_COD_DC = ircLD_SAMPLE_DETAI.CITY_RESI_OFFI_DANE_COD_DC,
				RESIDENTIAL_DEPARTMENT_DC = ircLD_SAMPLE_DETAI.RESIDENTIAL_DEPARTMENT_DC,
				RESIDENTIAL_ADDRESS_DC = ircLD_SAMPLE_DETAI.RESIDENTIAL_ADDRESS_DC,
				RESIDENTIAL_PHONE_DC = ircLD_SAMPLE_DETAI.RESIDENTIAL_PHONE_DC,
				CITY_WORK_DC = ircLD_SAMPLE_DETAI.CITY_WORK_DC,
				CITY_WORK_DANE_CODE_DC = ircLD_SAMPLE_DETAI.CITY_WORK_DANE_CODE_DC,
				DEPARTMENT_WORK_DC = ircLD_SAMPLE_DETAI.DEPARTMENT_WORK_DC,
				ADDRESS_WORK_DC = ircLD_SAMPLE_DETAI.ADDRESS_WORK_DC,
				PHONE_WORK_DC = ircLD_SAMPLE_DETAI.PHONE_WORK_DC,
				CITY_CORRESPONDENCE_DC = ircLD_SAMPLE_DETAI.CITY_CORRESPONDENCE_DC,
				DEPARTMENT_CORRESPONDENCE_DC = ircLD_SAMPLE_DETAI.DEPARTMENT_CORRESPONDENCE_DC,
				ADDRESS_CORRESPONDENCE_DC = ircLD_SAMPLE_DETAI.ADDRESS_CORRESPONDENCE_DC,
				EMAIL_DC = ircLD_SAMPLE_DETAI.EMAIL_DC,
				DESTINATION_SUBSCRIBER_DC = ircLD_SAMPLE_DETAI.DESTINATION_SUBSCRIBER_DC,
				CEL_PHONE_DC = ircLD_SAMPLE_DETAI.CEL_PHONE_DC,
				CITY_CORRESPONDENCE_DANE_CODE = ircLD_SAMPLE_DETAI.CITY_CORRESPONDENCE_DANE_CODE,
				FILLER = ircLD_SAMPLE_DETAI.FILLER
			where
				DETAIL_SAMPLE_ID = ircLD_SAMPLE_DETAI.DETAIL_SAMPLE_ID and
				SAMPLE_ID = ircLD_SAMPLE_DETAI.SAMPLE_ID
			returning
				DETAIL_SAMPLE_ID,
				SAMPLE_ID
			into
				nuDETAIL_SAMPLE_ID,
				nuSAMPLE_ID;
		end if;
		if
			nuDETAIL_SAMPLE_ID is NULL OR
			nuSAMPLE_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_SAMPLE_DETAI));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_SAMPLE_DETAI in out nocopy tytbLD_SAMPLE_DETAI,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_SAMPLE_DETAI;
	BEGIN
		FillRecordOfTables(iotbLD_SAMPLE_DETAI,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_SAMPLE_DETAI.first .. iotbLD_SAMPLE_DETAI.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SAMPLE_DETAI.first .. iotbLD_SAMPLE_DETAI.last
				update LD_SAMPLE_DETAI
				set
					NOTIFICATION = rcRecOfTab.NOTIFICATION(n),
					IS_APPROVED = rcRecOfTab.IS_APPROVED(n),
					SOURCE = rcRecOfTab.SOURCE(n),
					SUBSCRIBER_ID = rcRecOfTab.SUBSCRIBER_ID(n),
					PRODUCT_ID = rcRecOfTab.PRODUCT_ID(n),
					SUBSCRIPTION_ID = rcRecOfTab.SUBSCRIPTION_ID(n),
					RESERVED_CF = rcRecOfTab.RESERVED_CF(n),
					BRANCH_CODE_CF = rcRecOfTab.BRANCH_CODE_CF(n),
					QUALITY_CF = rcRecOfTab.QUALITY_CF(n),
					RATINGS_CF = rcRecOfTab.RATINGS_CF(n),
					STATE_STATUS_HOLDER_CF = rcRecOfTab.STATE_STATUS_HOLDER_CF(n),
					STATE_CF = rcRecOfTab.STATE_CF(n),
					MORA_YEARS_CF = rcRecOfTab.MORA_YEARS_CF(n),
					STATEMENT_DATE_CF = rcRecOfTab.STATEMENT_DATE_CF(n),
					INITIAL_ISSUE_DATE_CF = rcRecOfTab.INITIAL_ISSUE_DATE_CF(n),
					TERMINATION_DATE_CF = rcRecOfTab.TERMINATION_DATE_CF(n),
					DUE_DATE_CF = rcRecOfTab.DUE_DATE_CF(n),
					EXTICION_MODE_ID_CF = rcRecOfTab.EXTICION_MODE_ID_CF(n),
					TYPE_PAYMENT_CF = rcRecOfTab.TYPE_PAYMENT_CF(n),
					FIXED_CHARGE_VALUE_CF = rcRecOfTab.FIXED_CHARGE_VALUE_CF(n),
					CREDIT_LINE_CF = rcRecOfTab.CREDIT_LINE_CF(n),
					RESTRUCTURATED_OBLIGATION_CF = rcRecOfTab.RESTRUCTURATED_OBLIGATION_CF(n),
					NUMBER_OF_RESTRUCTURING_CF = rcRecOfTab.NUMBER_OF_RESTRUCTURING_CF(n),
					NUMBER_OF_RETURNED_CHECKS_CF = rcRecOfTab.NUMBER_OF_RETURNED_CHECKS_CF(n),
					TERM_CF = rcRecOfTab.TERM_CF(n),
					DAYS_OF_PORTFOLIO_CF = rcRecOfTab.DAYS_OF_PORTFOLIO_CF(n),
					THIRD_HOUSE_ADDRESS_CF = rcRecOfTab.THIRD_HOUSE_ADDRESS_CF(n),
					THIRD_HOME_PHONE_CF = rcRecOfTab.THIRD_HOME_PHONE_CF(n),
					EVERY_CITY_CODE_CF = rcRecOfTab.EVERY_CITY_CODE_CF(n),
					TOWN_HOUSE_PARTY_CF = rcRecOfTab.TOWN_HOUSE_PARTY_CF(n),
					HOME_DEPARTMENT_CODE_CF = rcRecOfTab.HOME_DEPARTMENT_CODE_CF(n),
					DEPARTMENT_OF_THIRD_HOUSE_CF = rcRecOfTab.DEPARTMENT_OF_THIRD_HOUSE_CF(n),
					COMPANY_NAME_CF = rcRecOfTab.COMPANY_NAME_CF(n),
					COMPANY_ADDRESS_CF = rcRecOfTab.COMPANY_ADDRESS_CF(n),
					COMPANY_PHONE_CF = rcRecOfTab.COMPANY_PHONE_CF(n),
					CITY_CODE_CF = rcRecOfTab.CITY_CODE_CF(n),
					NOW_CITY_OF_THIRD_CF = rcRecOfTab.NOW_CITY_OF_THIRD_CF(n),
					DEPARTAMENT_CODE_CF = rcRecOfTab.DEPARTAMENT_CODE_CF(n),
					THIRD_COMPANY_DEPARTMENT_CF = rcRecOfTab.THIRD_COMPANY_DEPARTMENT_CF(n),
					NAT_RESTRUCTURING_CF = rcRecOfTab.NAT_RESTRUCTURING_CF(n),
					LEGAL_NATURE = rcRecOfTab.LEGAL_NATURE(n),
					VALUE_OF_COLLATERAL = rcRecOfTab.VALUE_OF_COLLATERAL(n),
					SERVICE_CATEGORY = rcRecOfTab.SERVICE_CATEGORY(n),
					TYPE_OF_ACCOUNT = rcRecOfTab.TYPE_OF_ACCOUNT(n),
					SPACE_OVERDRAFT = rcRecOfTab.SPACE_OVERDRAFT(n),
					AUTHORIZED_DAYS = rcRecOfTab.AUTHORIZED_DAYS(n),
					DEFAULT_MORA_AGE_ID_CF = rcRecOfTab.DEFAULT_MORA_AGE_ID_CF(n),
					TYPE_PORTFOLIO_ID_CF = rcRecOfTab.TYPE_PORTFOLIO_ID_CF(n),
					NUMBER_MONTHS_CONTRACT_CF = rcRecOfTab.NUMBER_MONTHS_CONTRACT_CF(n),
					CREDIT_MODE = rcRecOfTab.CREDIT_MODE(n),
					NIVEL = rcRecOfTab.NIVEL(n),
					START_DATE_EXCENSION_GMF_CF = rcRecOfTab.START_DATE_EXCENSION_GMF_CF(n),
					TERMINATION_DATE_EXC_GMF_CF = rcRecOfTab.TERMINATION_DATE_EXC_GMF_CF(n),
					NUMBER_OF_RENEWAL_CDT_CF = rcRecOfTab.NUMBER_OF_RENEWAL_CDT_CF(n),
					GMF_FREE_SAVINGS_CTA_CF = rcRecOfTab.GMF_FREE_SAVINGS_CTA_CF(n),
					NATIVE_TYPE_IDENTIFICATION_CF = rcRecOfTab.NATIVE_TYPE_IDENTIFICATION_CF(n),
					IDENT_NUMBER_OF_NATIVE_CF = rcRecOfTab.IDENT_NUMBER_OF_NATIVE_CF(n),
					ENTITY_TYPE_NATIVE_CF = rcRecOfTab.ENTITY_TYPE_NATIVE_CF(n),
					ENTITY_CODE_ORIGINATING_CF = rcRecOfTab.ENTITY_CODE_ORIGINATING_CF(n),
					TYPE_OF_TRUST_CF = rcRecOfTab.TYPE_OF_TRUST_CF(n),
					NUMBER_OF_TRUST_CF = rcRecOfTab.NUMBER_OF_TRUST_CF(n),
					NAME_TRUST_CF = rcRecOfTab.NAME_TRUST_CF(n),
					TYPE_OF_DEBT_PORTFOLIO_CF = rcRecOfTab.TYPE_OF_DEBT_PORTFOLIO_CF(n),
					POLICY_TYPE_CF = rcRecOfTab.POLICY_TYPE_CF(n),
					RAMIFICATION_CODE = rcRecOfTab.RAMIFICATION_CODE(n),
					DATE_OF_PRESCRIPTION = rcRecOfTab.DATE_OF_PRESCRIPTION(n),
					SCORE = rcRecOfTab.SCORE(n),
					TYPE_IDENTIFICATION_DC = rcRecOfTab.TYPE_IDENTIFICATION_DC(n),
					TYPE_IDENTIFICATION_CF = rcRecOfTab.TYPE_IDENTIFICATION_CF(n),
					IDENTIFICATION_NUMBER = rcRecOfTab.IDENTIFICATION_NUMBER(n),
					RECORD_TYPE_ID_CF = rcRecOfTab.RECORD_TYPE_ID_CF(n),
					FULL_NAME = rcRecOfTab.FULL_NAME(n),
					ACCOUNT_NUMBER = rcRecOfTab.ACCOUNT_NUMBER(n),
					BRANCH_OFFICE_CF = rcRecOfTab.BRANCH_OFFICE_CF(n),
					SITUATION_HOLDER_DC = rcRecOfTab.SITUATION_HOLDER_DC(n),
					OPENING_DATE = rcRecOfTab.OPENING_DATE(n),
					DUE_DATE_DC = rcRecOfTab.DUE_DATE_DC(n),
					RESPONSIBLE_DC = rcRecOfTab.RESPONSIBLE_DC(n),
					TYPE_OBLIGATION_ID_DC = rcRecOfTab.TYPE_OBLIGATION_ID_DC(n),
					MORTGAGE_SUBSIDY_DC = rcRecOfTab.MORTGAGE_SUBSIDY_DC(n),
					DATE_SUBSIDY_DC = rcRecOfTab.DATE_SUBSIDY_DC(n),
					TYPE_CONTRACT_ID_CF = rcRecOfTab.TYPE_CONTRACT_ID_CF(n),
					STATE_OF_CONTRACT_CF = rcRecOfTab.STATE_OF_CONTRACT_CF(n),
					TERM_CONTRACT_CF = rcRecOfTab.TERM_CONTRACT_CF(n),
					TERM_CONTRACT_DC = rcRecOfTab.TERM_CONTRACT_DC(n),
					METHOD_PAYMENT_ID_CF = rcRecOfTab.METHOD_PAYMENT_ID_CF(n),
					METHOD_PAYMENT_ID_DC = rcRecOfTab.METHOD_PAYMENT_ID_DC(n),
					PERIODICITY_ID_DC = rcRecOfTab.PERIODICITY_ID_DC(n),
					PERIODICITY_ID_CF = rcRecOfTab.PERIODICITY_ID_CF(n),
					NEW_PORTFOLIO_ID_DC = rcRecOfTab.NEW_PORTFOLIO_ID_DC(n),
					STATE_OBLIGATION_CF = rcRecOfTab.STATE_OBLIGATION_CF(n),
					SITUATION_HOLDER_CF = rcRecOfTab.SITUATION_HOLDER_CF(n),
					ACCOUNT_STATE_ID_DC = rcRecOfTab.ACCOUNT_STATE_ID_DC(n),
					DATE_STATUS_ORIGIN = rcRecOfTab.DATE_STATUS_ORIGIN(n),
					SOURCE_STATE_ID = rcRecOfTab.SOURCE_STATE_ID(n),
					DATE_STATUS_ACCOUNT = rcRecOfTab.DATE_STATUS_ACCOUNT(n),
					STATUS_PLASTIC_DC = rcRecOfTab.STATUS_PLASTIC_DC(n),
					DATE_STATUS_PLASTIC_DC = rcRecOfTab.DATE_STATUS_PLASTIC_DC(n),
					ADJETIVE_DC = rcRecOfTab.ADJETIVE_DC(n),
					DATE_ADJETIVE_DC = rcRecOfTab.DATE_ADJETIVE_DC(n),
					CARD_CLASS_DC = rcRecOfTab.CARD_CLASS_DC(n),
					FRANCHISE_DC = rcRecOfTab.FRANCHISE_DC(n),
					PRIVATE_BRAND_NAME_DC = rcRecOfTab.PRIVATE_BRAND_NAME_DC(n),
					TYPE_MONEY_DC = rcRecOfTab.TYPE_MONEY_DC(n),
					TYPE_WARRANTY_DC = rcRecOfTab.TYPE_WARRANTY_DC(n),
					RATINGS_DC = rcRecOfTab.RATINGS_DC(n),
					PROBABILITY_DEFAULT_DC = rcRecOfTab.PROBABILITY_DEFAULT_DC(n),
					MORA_AGE = rcRecOfTab.MORA_AGE(n),
					INITIAL_VALUES_DC = rcRecOfTab.INITIAL_VALUES_DC(n),
					DEBT_TO_DC = rcRecOfTab.DEBT_TO_DC(n),
					VALUE_AVAILABLE = rcRecOfTab.VALUE_AVAILABLE(n),
					MONTHLY_VALUE = rcRecOfTab.MONTHLY_VALUE(n),
					VALUE_DELAY = rcRecOfTab.VALUE_DELAY(n),
					TOTAL_SHARES = rcRecOfTab.TOTAL_SHARES(n),
					SHARES_CANCELED = rcRecOfTab.SHARES_CANCELED(n),
					SHARES_DEBT = rcRecOfTab.SHARES_DEBT(n),
					CLAUSE_PERMANENCE_DC = rcRecOfTab.CLAUSE_PERMANENCE_DC(n),
					DATE_CLAUSE_PERMANENCE_DC = rcRecOfTab.DATE_CLAUSE_PERMANENCE_DC(n),
					PAYMENT_DEADLINE_DC = rcRecOfTab.PAYMENT_DEADLINE_DC(n),
					PAYMENT_DATE = rcRecOfTab.PAYMENT_DATE(n),
					RADICATION_OFFICE_DC = rcRecOfTab.RADICATION_OFFICE_DC(n),
					CITY_RADICATION_OFFICE_DC = rcRecOfTab.CITY_RADICATION_OFFICE_DC(n),
					CITY_RADI_OFFI_DANE_COD_DC = rcRecOfTab.CITY_RADI_OFFI_DANE_COD_DC(n),
					RESIDENTIAL_CITY_DC = rcRecOfTab.RESIDENTIAL_CITY_DC(n),
					CITY_RESI_OFFI_DANE_COD_DC = rcRecOfTab.CITY_RESI_OFFI_DANE_COD_DC(n),
					RESIDENTIAL_DEPARTMENT_DC = rcRecOfTab.RESIDENTIAL_DEPARTMENT_DC(n),
					RESIDENTIAL_ADDRESS_DC = rcRecOfTab.RESIDENTIAL_ADDRESS_DC(n),
					RESIDENTIAL_PHONE_DC = rcRecOfTab.RESIDENTIAL_PHONE_DC(n),
					CITY_WORK_DC = rcRecOfTab.CITY_WORK_DC(n),
					CITY_WORK_DANE_CODE_DC = rcRecOfTab.CITY_WORK_DANE_CODE_DC(n),
					DEPARTMENT_WORK_DC = rcRecOfTab.DEPARTMENT_WORK_DC(n),
					ADDRESS_WORK_DC = rcRecOfTab.ADDRESS_WORK_DC(n),
					PHONE_WORK_DC = rcRecOfTab.PHONE_WORK_DC(n),
					CITY_CORRESPONDENCE_DC = rcRecOfTab.CITY_CORRESPONDENCE_DC(n),
					DEPARTMENT_CORRESPONDENCE_DC = rcRecOfTab.DEPARTMENT_CORRESPONDENCE_DC(n),
					ADDRESS_CORRESPONDENCE_DC = rcRecOfTab.ADDRESS_CORRESPONDENCE_DC(n),
					EMAIL_DC = rcRecOfTab.EMAIL_DC(n),
					DESTINATION_SUBSCRIBER_DC = rcRecOfTab.DESTINATION_SUBSCRIBER_DC(n),
					CEL_PHONE_DC = rcRecOfTab.CEL_PHONE_DC(n),
					CITY_CORRESPONDENCE_DANE_CODE = rcRecOfTab.CITY_CORRESPONDENCE_DANE_CODE(n),
					FILLER = rcRecOfTab.FILLER(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_SAMPLE_DETAI.first .. iotbLD_SAMPLE_DETAI.last loop
					LockByPk
					(
						rcRecOfTab.DETAIL_SAMPLE_ID(n),
						rcRecOfTab.SAMPLE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_SAMPLE_DETAI.first .. iotbLD_SAMPLE_DETAI.last
				update LD_SAMPLE_DETAI
				SET
					NOTIFICATION = rcRecOfTab.NOTIFICATION(n),
					IS_APPROVED = rcRecOfTab.IS_APPROVED(n),
					SOURCE = rcRecOfTab.SOURCE(n),
					SUBSCRIBER_ID = rcRecOfTab.SUBSCRIBER_ID(n),
					PRODUCT_ID = rcRecOfTab.PRODUCT_ID(n),
					SUBSCRIPTION_ID = rcRecOfTab.SUBSCRIPTION_ID(n),
					RESERVED_CF = rcRecOfTab.RESERVED_CF(n),
					BRANCH_CODE_CF = rcRecOfTab.BRANCH_CODE_CF(n),
					QUALITY_CF = rcRecOfTab.QUALITY_CF(n),
					RATINGS_CF = rcRecOfTab.RATINGS_CF(n),
					STATE_STATUS_HOLDER_CF = rcRecOfTab.STATE_STATUS_HOLDER_CF(n),
					STATE_CF = rcRecOfTab.STATE_CF(n),
					MORA_YEARS_CF = rcRecOfTab.MORA_YEARS_CF(n),
					STATEMENT_DATE_CF = rcRecOfTab.STATEMENT_DATE_CF(n),
					INITIAL_ISSUE_DATE_CF = rcRecOfTab.INITIAL_ISSUE_DATE_CF(n),
					TERMINATION_DATE_CF = rcRecOfTab.TERMINATION_DATE_CF(n),
					DUE_DATE_CF = rcRecOfTab.DUE_DATE_CF(n),
					EXTICION_MODE_ID_CF = rcRecOfTab.EXTICION_MODE_ID_CF(n),
					TYPE_PAYMENT_CF = rcRecOfTab.TYPE_PAYMENT_CF(n),
					FIXED_CHARGE_VALUE_CF = rcRecOfTab.FIXED_CHARGE_VALUE_CF(n),
					CREDIT_LINE_CF = rcRecOfTab.CREDIT_LINE_CF(n),
					RESTRUCTURATED_OBLIGATION_CF = rcRecOfTab.RESTRUCTURATED_OBLIGATION_CF(n),
					NUMBER_OF_RESTRUCTURING_CF = rcRecOfTab.NUMBER_OF_RESTRUCTURING_CF(n),
					NUMBER_OF_RETURNED_CHECKS_CF = rcRecOfTab.NUMBER_OF_RETURNED_CHECKS_CF(n),
					TERM_CF = rcRecOfTab.TERM_CF(n),
					DAYS_OF_PORTFOLIO_CF = rcRecOfTab.DAYS_OF_PORTFOLIO_CF(n),
					THIRD_HOUSE_ADDRESS_CF = rcRecOfTab.THIRD_HOUSE_ADDRESS_CF(n),
					THIRD_HOME_PHONE_CF = rcRecOfTab.THIRD_HOME_PHONE_CF(n),
					EVERY_CITY_CODE_CF = rcRecOfTab.EVERY_CITY_CODE_CF(n),
					TOWN_HOUSE_PARTY_CF = rcRecOfTab.TOWN_HOUSE_PARTY_CF(n),
					HOME_DEPARTMENT_CODE_CF = rcRecOfTab.HOME_DEPARTMENT_CODE_CF(n),
					DEPARTMENT_OF_THIRD_HOUSE_CF = rcRecOfTab.DEPARTMENT_OF_THIRD_HOUSE_CF(n),
					COMPANY_NAME_CF = rcRecOfTab.COMPANY_NAME_CF(n),
					COMPANY_ADDRESS_CF = rcRecOfTab.COMPANY_ADDRESS_CF(n),
					COMPANY_PHONE_CF = rcRecOfTab.COMPANY_PHONE_CF(n),
					CITY_CODE_CF = rcRecOfTab.CITY_CODE_CF(n),
					NOW_CITY_OF_THIRD_CF = rcRecOfTab.NOW_CITY_OF_THIRD_CF(n),
					DEPARTAMENT_CODE_CF = rcRecOfTab.DEPARTAMENT_CODE_CF(n),
					THIRD_COMPANY_DEPARTMENT_CF = rcRecOfTab.THIRD_COMPANY_DEPARTMENT_CF(n),
					NAT_RESTRUCTURING_CF = rcRecOfTab.NAT_RESTRUCTURING_CF(n),
					LEGAL_NATURE = rcRecOfTab.LEGAL_NATURE(n),
					VALUE_OF_COLLATERAL = rcRecOfTab.VALUE_OF_COLLATERAL(n),
					SERVICE_CATEGORY = rcRecOfTab.SERVICE_CATEGORY(n),
					TYPE_OF_ACCOUNT = rcRecOfTab.TYPE_OF_ACCOUNT(n),
					SPACE_OVERDRAFT = rcRecOfTab.SPACE_OVERDRAFT(n),
					AUTHORIZED_DAYS = rcRecOfTab.AUTHORIZED_DAYS(n),
					DEFAULT_MORA_AGE_ID_CF = rcRecOfTab.DEFAULT_MORA_AGE_ID_CF(n),
					TYPE_PORTFOLIO_ID_CF = rcRecOfTab.TYPE_PORTFOLIO_ID_CF(n),
					NUMBER_MONTHS_CONTRACT_CF = rcRecOfTab.NUMBER_MONTHS_CONTRACT_CF(n),
					CREDIT_MODE = rcRecOfTab.CREDIT_MODE(n),
					NIVEL = rcRecOfTab.NIVEL(n),
					START_DATE_EXCENSION_GMF_CF = rcRecOfTab.START_DATE_EXCENSION_GMF_CF(n),
					TERMINATION_DATE_EXC_GMF_CF = rcRecOfTab.TERMINATION_DATE_EXC_GMF_CF(n),
					NUMBER_OF_RENEWAL_CDT_CF = rcRecOfTab.NUMBER_OF_RENEWAL_CDT_CF(n),
					GMF_FREE_SAVINGS_CTA_CF = rcRecOfTab.GMF_FREE_SAVINGS_CTA_CF(n),
					NATIVE_TYPE_IDENTIFICATION_CF = rcRecOfTab.NATIVE_TYPE_IDENTIFICATION_CF(n),
					IDENT_NUMBER_OF_NATIVE_CF = rcRecOfTab.IDENT_NUMBER_OF_NATIVE_CF(n),
					ENTITY_TYPE_NATIVE_CF = rcRecOfTab.ENTITY_TYPE_NATIVE_CF(n),
					ENTITY_CODE_ORIGINATING_CF = rcRecOfTab.ENTITY_CODE_ORIGINATING_CF(n),
					TYPE_OF_TRUST_CF = rcRecOfTab.TYPE_OF_TRUST_CF(n),
					NUMBER_OF_TRUST_CF = rcRecOfTab.NUMBER_OF_TRUST_CF(n),
					NAME_TRUST_CF = rcRecOfTab.NAME_TRUST_CF(n),
					TYPE_OF_DEBT_PORTFOLIO_CF = rcRecOfTab.TYPE_OF_DEBT_PORTFOLIO_CF(n),
					POLICY_TYPE_CF = rcRecOfTab.POLICY_TYPE_CF(n),
					RAMIFICATION_CODE = rcRecOfTab.RAMIFICATION_CODE(n),
					DATE_OF_PRESCRIPTION = rcRecOfTab.DATE_OF_PRESCRIPTION(n),
					SCORE = rcRecOfTab.SCORE(n),
					TYPE_IDENTIFICATION_DC = rcRecOfTab.TYPE_IDENTIFICATION_DC(n),
					TYPE_IDENTIFICATION_CF = rcRecOfTab.TYPE_IDENTIFICATION_CF(n),
					IDENTIFICATION_NUMBER = rcRecOfTab.IDENTIFICATION_NUMBER(n),
					RECORD_TYPE_ID_CF = rcRecOfTab.RECORD_TYPE_ID_CF(n),
					FULL_NAME = rcRecOfTab.FULL_NAME(n),
					ACCOUNT_NUMBER = rcRecOfTab.ACCOUNT_NUMBER(n),
					BRANCH_OFFICE_CF = rcRecOfTab.BRANCH_OFFICE_CF(n),
					SITUATION_HOLDER_DC = rcRecOfTab.SITUATION_HOLDER_DC(n),
					OPENING_DATE = rcRecOfTab.OPENING_DATE(n),
					DUE_DATE_DC = rcRecOfTab.DUE_DATE_DC(n),
					RESPONSIBLE_DC = rcRecOfTab.RESPONSIBLE_DC(n),
					TYPE_OBLIGATION_ID_DC = rcRecOfTab.TYPE_OBLIGATION_ID_DC(n),
					MORTGAGE_SUBSIDY_DC = rcRecOfTab.MORTGAGE_SUBSIDY_DC(n),
					DATE_SUBSIDY_DC = rcRecOfTab.DATE_SUBSIDY_DC(n),
					TYPE_CONTRACT_ID_CF = rcRecOfTab.TYPE_CONTRACT_ID_CF(n),
					STATE_OF_CONTRACT_CF = rcRecOfTab.STATE_OF_CONTRACT_CF(n),
					TERM_CONTRACT_CF = rcRecOfTab.TERM_CONTRACT_CF(n),
					TERM_CONTRACT_DC = rcRecOfTab.TERM_CONTRACT_DC(n),
					METHOD_PAYMENT_ID_CF = rcRecOfTab.METHOD_PAYMENT_ID_CF(n),
					METHOD_PAYMENT_ID_DC = rcRecOfTab.METHOD_PAYMENT_ID_DC(n),
					PERIODICITY_ID_DC = rcRecOfTab.PERIODICITY_ID_DC(n),
					PERIODICITY_ID_CF = rcRecOfTab.PERIODICITY_ID_CF(n),
					NEW_PORTFOLIO_ID_DC = rcRecOfTab.NEW_PORTFOLIO_ID_DC(n),
					STATE_OBLIGATION_CF = rcRecOfTab.STATE_OBLIGATION_CF(n),
					SITUATION_HOLDER_CF = rcRecOfTab.SITUATION_HOLDER_CF(n),
					ACCOUNT_STATE_ID_DC = rcRecOfTab.ACCOUNT_STATE_ID_DC(n),
					DATE_STATUS_ORIGIN = rcRecOfTab.DATE_STATUS_ORIGIN(n),
					SOURCE_STATE_ID = rcRecOfTab.SOURCE_STATE_ID(n),
					DATE_STATUS_ACCOUNT = rcRecOfTab.DATE_STATUS_ACCOUNT(n),
					STATUS_PLASTIC_DC = rcRecOfTab.STATUS_PLASTIC_DC(n),
					DATE_STATUS_PLASTIC_DC = rcRecOfTab.DATE_STATUS_PLASTIC_DC(n),
					ADJETIVE_DC = rcRecOfTab.ADJETIVE_DC(n),
					DATE_ADJETIVE_DC = rcRecOfTab.DATE_ADJETIVE_DC(n),
					CARD_CLASS_DC = rcRecOfTab.CARD_CLASS_DC(n),
					FRANCHISE_DC = rcRecOfTab.FRANCHISE_DC(n),
					PRIVATE_BRAND_NAME_DC = rcRecOfTab.PRIVATE_BRAND_NAME_DC(n),
					TYPE_MONEY_DC = rcRecOfTab.TYPE_MONEY_DC(n),
					TYPE_WARRANTY_DC = rcRecOfTab.TYPE_WARRANTY_DC(n),
					RATINGS_DC = rcRecOfTab.RATINGS_DC(n),
					PROBABILITY_DEFAULT_DC = rcRecOfTab.PROBABILITY_DEFAULT_DC(n),
					MORA_AGE = rcRecOfTab.MORA_AGE(n),
					INITIAL_VALUES_DC = rcRecOfTab.INITIAL_VALUES_DC(n),
					DEBT_TO_DC = rcRecOfTab.DEBT_TO_DC(n),
					VALUE_AVAILABLE = rcRecOfTab.VALUE_AVAILABLE(n),
					MONTHLY_VALUE = rcRecOfTab.MONTHLY_VALUE(n),
					VALUE_DELAY = rcRecOfTab.VALUE_DELAY(n),
					TOTAL_SHARES = rcRecOfTab.TOTAL_SHARES(n),
					SHARES_CANCELED = rcRecOfTab.SHARES_CANCELED(n),
					SHARES_DEBT = rcRecOfTab.SHARES_DEBT(n),
					CLAUSE_PERMANENCE_DC = rcRecOfTab.CLAUSE_PERMANENCE_DC(n),
					DATE_CLAUSE_PERMANENCE_DC = rcRecOfTab.DATE_CLAUSE_PERMANENCE_DC(n),
					PAYMENT_DEADLINE_DC = rcRecOfTab.PAYMENT_DEADLINE_DC(n),
					PAYMENT_DATE = rcRecOfTab.PAYMENT_DATE(n),
					RADICATION_OFFICE_DC = rcRecOfTab.RADICATION_OFFICE_DC(n),
					CITY_RADICATION_OFFICE_DC = rcRecOfTab.CITY_RADICATION_OFFICE_DC(n),
					CITY_RADI_OFFI_DANE_COD_DC = rcRecOfTab.CITY_RADI_OFFI_DANE_COD_DC(n),
					RESIDENTIAL_CITY_DC = rcRecOfTab.RESIDENTIAL_CITY_DC(n),
					CITY_RESI_OFFI_DANE_COD_DC = rcRecOfTab.CITY_RESI_OFFI_DANE_COD_DC(n),
					RESIDENTIAL_DEPARTMENT_DC = rcRecOfTab.RESIDENTIAL_DEPARTMENT_DC(n),
					RESIDENTIAL_ADDRESS_DC = rcRecOfTab.RESIDENTIAL_ADDRESS_DC(n),
					RESIDENTIAL_PHONE_DC = rcRecOfTab.RESIDENTIAL_PHONE_DC(n),
					CITY_WORK_DC = rcRecOfTab.CITY_WORK_DC(n),
					CITY_WORK_DANE_CODE_DC = rcRecOfTab.CITY_WORK_DANE_CODE_DC(n),
					DEPARTMENT_WORK_DC = rcRecOfTab.DEPARTMENT_WORK_DC(n),
					ADDRESS_WORK_DC = rcRecOfTab.ADDRESS_WORK_DC(n),
					PHONE_WORK_DC = rcRecOfTab.PHONE_WORK_DC(n),
					CITY_CORRESPONDENCE_DC = rcRecOfTab.CITY_CORRESPONDENCE_DC(n),
					DEPARTMENT_CORRESPONDENCE_DC = rcRecOfTab.DEPARTMENT_CORRESPONDENCE_DC(n),
					ADDRESS_CORRESPONDENCE_DC = rcRecOfTab.ADDRESS_CORRESPONDENCE_DC(n),
					EMAIL_DC = rcRecOfTab.EMAIL_DC(n),
					DESTINATION_SUBSCRIBER_DC = rcRecOfTab.DESTINATION_SUBSCRIBER_DC(n),
					CEL_PHONE_DC = rcRecOfTab.CEL_PHONE_DC(n),
					CITY_CORRESPONDENCE_DANE_CODE = rcRecOfTab.CITY_CORRESPONDENCE_DANE_CODE(n),
					FILLER = rcRecOfTab.FILLER(n)
				where
					DETAIL_SAMPLE_ID = rcRecOfTab.DETAIL_SAMPLE_ID(n) and
					SAMPLE_ID = rcRecOfTab.SAMPLE_ID(n)
;
		end if;
	END;
	PROCEDURE updNOTIFICATION
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbNOTIFICATION$ in LD_SAMPLE_DETAI.NOTIFICATION%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			NOTIFICATION = isbNOTIFICATION$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NOTIFICATION:= isbNOTIFICATION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIS_APPROVED
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbIS_APPROVED$ in LD_SAMPLE_DETAI.IS_APPROVED%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			IS_APPROVED = isbIS_APPROVED$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IS_APPROVED:= isbIS_APPROVED$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSOURCE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbSOURCE$ in LD_SAMPLE_DETAI.SOURCE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			SOURCE = isbSOURCE$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SOURCE:= isbSOURCE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUBSCRIBER_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSUBSCRIBER_ID$ in LD_SAMPLE_DETAI.SUBSCRIBER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			SUBSCRIBER_ID = inuSUBSCRIBER_ID$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUBSCRIBER_ID:= inuSUBSCRIBER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRODUCT_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuPRODUCT_ID$ in LD_SAMPLE_DETAI.PRODUCT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			PRODUCT_ID = inuPRODUCT_ID$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRODUCT_ID:= inuPRODUCT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUBSCRIPTION_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSUBSCRIPTION_ID$ in LD_SAMPLE_DETAI.SUBSCRIPTION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			SUBSCRIPTION_ID = inuSUBSCRIPTION_ID$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUBSCRIPTION_ID:= inuSUBSCRIPTION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRESERVED_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRESERVED_CF$ in LD_SAMPLE_DETAI.RESERVED_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			RESERVED_CF = inuRESERVED_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RESERVED_CF:= inuRESERVED_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBRANCH_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbBRANCH_CODE_CF$ in LD_SAMPLE_DETAI.BRANCH_CODE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			BRANCH_CODE_CF = isbBRANCH_CODE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BRANCH_CODE_CF:= isbBRANCH_CODE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updQUALITY_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbQUALITY_CF$ in LD_SAMPLE_DETAI.QUALITY_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			QUALITY_CF = isbQUALITY_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.QUALITY_CF:= isbQUALITY_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRATINGS_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbRATINGS_CF$ in LD_SAMPLE_DETAI.RATINGS_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			RATINGS_CF = isbRATINGS_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RATINGS_CF:= isbRATINGS_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSTATE_STATUS_HOLDER_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbSTATE_STATUS_HOLDER_CF$ in LD_SAMPLE_DETAI.STATE_STATUS_HOLDER_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			STATE_STATUS_HOLDER_CF = isbSTATE_STATUS_HOLDER_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.STATE_STATUS_HOLDER_CF:= isbSTATE_STATUS_HOLDER_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSTATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSTATE_CF$ in LD_SAMPLE_DETAI.STATE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			STATE_CF = inuSTATE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.STATE_CF:= inuSTATE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMORA_YEARS_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuMORA_YEARS_CF$ in LD_SAMPLE_DETAI.MORA_YEARS_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			MORA_YEARS_CF = inuMORA_YEARS_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MORA_YEARS_CF:= inuMORA_YEARS_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSTATEMENT_DATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		idtSTATEMENT_DATE_CF$ in LD_SAMPLE_DETAI.STATEMENT_DATE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			STATEMENT_DATE_CF = idtSTATEMENT_DATE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.STATEMENT_DATE_CF:= idtSTATEMENT_DATE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updINITIAL_ISSUE_DATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuINITIAL_ISSUE_DATE_CF$ in LD_SAMPLE_DETAI.INITIAL_ISSUE_DATE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			INITIAL_ISSUE_DATE_CF = inuINITIAL_ISSUE_DATE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.INITIAL_ISSUE_DATE_CF:= inuINITIAL_ISSUE_DATE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTERMINATION_DATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTERMINATION_DATE_CF$ in LD_SAMPLE_DETAI.TERMINATION_DATE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TERMINATION_DATE_CF = inuTERMINATION_DATE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERMINATION_DATE_CF:= inuTERMINATION_DATE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDUE_DATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDUE_DATE_CF$ in LD_SAMPLE_DETAI.DUE_DATE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			DUE_DATE_CF = inuDUE_DATE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DUE_DATE_CF:= inuDUE_DATE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updEXTICION_MODE_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuEXTICION_MODE_ID_CF$ in LD_SAMPLE_DETAI.EXTICION_MODE_ID_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			EXTICION_MODE_ID_CF = inuEXTICION_MODE_ID_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.EXTICION_MODE_ID_CF:= inuEXTICION_MODE_ID_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_PAYMENT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTYPE_PAYMENT_CF$ in LD_SAMPLE_DETAI.TYPE_PAYMENT_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TYPE_PAYMENT_CF = inuTYPE_PAYMENT_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_PAYMENT_CF:= inuTYPE_PAYMENT_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFIXED_CHARGE_VALUE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuFIXED_CHARGE_VALUE_CF$ in LD_SAMPLE_DETAI.FIXED_CHARGE_VALUE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			FIXED_CHARGE_VALUE_CF = inuFIXED_CHARGE_VALUE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FIXED_CHARGE_VALUE_CF:= inuFIXED_CHARGE_VALUE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCREDIT_LINE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuCREDIT_LINE_CF$ in LD_SAMPLE_DETAI.CREDIT_LINE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			CREDIT_LINE_CF = inuCREDIT_LINE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CREDIT_LINE_CF:= inuCREDIT_LINE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTERM_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTERM_CF$ in LD_SAMPLE_DETAI.TERM_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TERM_CF = inuTERM_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERM_CF:= inuTERM_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDAYS_OF_PORTFOLIO_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDAYS_OF_PORTFOLIO_CF$ in LD_SAMPLE_DETAI.DAYS_OF_PORTFOLIO_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			DAYS_OF_PORTFOLIO_CF = inuDAYS_OF_PORTFOLIO_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DAYS_OF_PORTFOLIO_CF:= inuDAYS_OF_PORTFOLIO_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTHIRD_HOUSE_ADDRESS_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbTHIRD_HOUSE_ADDRESS_CF$ in LD_SAMPLE_DETAI.THIRD_HOUSE_ADDRESS_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			THIRD_HOUSE_ADDRESS_CF = isbTHIRD_HOUSE_ADDRESS_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.THIRD_HOUSE_ADDRESS_CF:= isbTHIRD_HOUSE_ADDRESS_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTHIRD_HOME_PHONE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbTHIRD_HOME_PHONE_CF$ in LD_SAMPLE_DETAI.THIRD_HOME_PHONE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			THIRD_HOME_PHONE_CF = isbTHIRD_HOME_PHONE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.THIRD_HOME_PHONE_CF:= isbTHIRD_HOME_PHONE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updEVERY_CITY_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuEVERY_CITY_CODE_CF$ in LD_SAMPLE_DETAI.EVERY_CITY_CODE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			EVERY_CITY_CODE_CF = inuEVERY_CITY_CODE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.EVERY_CITY_CODE_CF:= inuEVERY_CITY_CODE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTOWN_HOUSE_PARTY_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbTOWN_HOUSE_PARTY_CF$ in LD_SAMPLE_DETAI.TOWN_HOUSE_PARTY_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TOWN_HOUSE_PARTY_CF = isbTOWN_HOUSE_PARTY_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TOWN_HOUSE_PARTY_CF:= isbTOWN_HOUSE_PARTY_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updHOME_DEPARTMENT_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuHOME_DEPARTMENT_CODE_CF$ in LD_SAMPLE_DETAI.HOME_DEPARTMENT_CODE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			HOME_DEPARTMENT_CODE_CF = inuHOME_DEPARTMENT_CODE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.HOME_DEPARTMENT_CODE_CF:= inuHOME_DEPARTMENT_CODE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOMPANY_NAME_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbCOMPANY_NAME_CF$ in LD_SAMPLE_DETAI.COMPANY_NAME_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			COMPANY_NAME_CF = isbCOMPANY_NAME_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMPANY_NAME_CF:= isbCOMPANY_NAME_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOMPANY_ADDRESS_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbCOMPANY_ADDRESS_CF$ in LD_SAMPLE_DETAI.COMPANY_ADDRESS_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			COMPANY_ADDRESS_CF = isbCOMPANY_ADDRESS_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMPANY_ADDRESS_CF:= isbCOMPANY_ADDRESS_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOMPANY_PHONE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuCOMPANY_PHONE_CF$ in LD_SAMPLE_DETAI.COMPANY_PHONE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			COMPANY_PHONE_CF = inuCOMPANY_PHONE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMPANY_PHONE_CF:= inuCOMPANY_PHONE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCITY_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuCITY_CODE_CF$ in LD_SAMPLE_DETAI.CITY_CODE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			CITY_CODE_CF = inuCITY_CODE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CITY_CODE_CF:= inuCITY_CODE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNOW_CITY_OF_THIRD_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbNOW_CITY_OF_THIRD_CF$ in LD_SAMPLE_DETAI.NOW_CITY_OF_THIRD_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			NOW_CITY_OF_THIRD_CF = isbNOW_CITY_OF_THIRD_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NOW_CITY_OF_THIRD_CF:= isbNOW_CITY_OF_THIRD_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEPARTAMENT_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDEPARTAMENT_CODE_CF$ in LD_SAMPLE_DETAI.DEPARTAMENT_CODE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			DEPARTAMENT_CODE_CF = inuDEPARTAMENT_CODE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEPARTAMENT_CODE_CF:= inuDEPARTAMENT_CODE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNAT_RESTRUCTURING_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuNAT_RESTRUCTURING_CF$ in LD_SAMPLE_DETAI.NAT_RESTRUCTURING_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			NAT_RESTRUCTURING_CF = inuNAT_RESTRUCTURING_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NAT_RESTRUCTURING_CF:= inuNAT_RESTRUCTURING_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLEGAL_NATURE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbLEGAL_NATURE$ in LD_SAMPLE_DETAI.LEGAL_NATURE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			LEGAL_NATURE = isbLEGAL_NATURE$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LEGAL_NATURE:= isbLEGAL_NATURE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALUE_OF_COLLATERAL
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbVALUE_OF_COLLATERAL$ in LD_SAMPLE_DETAI.VALUE_OF_COLLATERAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			VALUE_OF_COLLATERAL = isbVALUE_OF_COLLATERAL$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALUE_OF_COLLATERAL:= isbVALUE_OF_COLLATERAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSERVICE_CATEGORY
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbSERVICE_CATEGORY$ in LD_SAMPLE_DETAI.SERVICE_CATEGORY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			SERVICE_CATEGORY = isbSERVICE_CATEGORY$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SERVICE_CATEGORY:= isbSERVICE_CATEGORY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_OF_ACCOUNT
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTYPE_OF_ACCOUNT$ in LD_SAMPLE_DETAI.TYPE_OF_ACCOUNT%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TYPE_OF_ACCOUNT = inuTYPE_OF_ACCOUNT$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_OF_ACCOUNT:= inuTYPE_OF_ACCOUNT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSPACE_OVERDRAFT
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSPACE_OVERDRAFT$ in LD_SAMPLE_DETAI.SPACE_OVERDRAFT%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			SPACE_OVERDRAFT = inuSPACE_OVERDRAFT$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SPACE_OVERDRAFT:= inuSPACE_OVERDRAFT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updAUTHORIZED_DAYS
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuAUTHORIZED_DAYS$ in LD_SAMPLE_DETAI.AUTHORIZED_DAYS%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			AUTHORIZED_DAYS = inuAUTHORIZED_DAYS$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.AUTHORIZED_DAYS:= inuAUTHORIZED_DAYS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEFAULT_MORA_AGE_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDEFAULT_MORA_AGE_ID_CF$ in LD_SAMPLE_DETAI.DEFAULT_MORA_AGE_ID_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			DEFAULT_MORA_AGE_ID_CF = inuDEFAULT_MORA_AGE_ID_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEFAULT_MORA_AGE_ID_CF:= inuDEFAULT_MORA_AGE_ID_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_PORTFOLIO_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTYPE_PORTFOLIO_ID_CF$ in LD_SAMPLE_DETAI.TYPE_PORTFOLIO_ID_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TYPE_PORTFOLIO_ID_CF = inuTYPE_PORTFOLIO_ID_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_PORTFOLIO_ID_CF:= inuTYPE_PORTFOLIO_ID_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNUMBER_MONTHS_CONTRACT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuNUMBER_MONTHS_CONTRACT_CF$ in LD_SAMPLE_DETAI.NUMBER_MONTHS_CONTRACT_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			NUMBER_MONTHS_CONTRACT_CF = inuNUMBER_MONTHS_CONTRACT_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NUMBER_MONTHS_CONTRACT_CF:= inuNUMBER_MONTHS_CONTRACT_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCREDIT_MODE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbCREDIT_MODE$ in LD_SAMPLE_DETAI.CREDIT_MODE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			CREDIT_MODE = isbCREDIT_MODE$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CREDIT_MODE:= isbCREDIT_MODE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNIVEL
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbNIVEL$ in LD_SAMPLE_DETAI.NIVEL%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			NIVEL = isbNIVEL$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NIVEL:= isbNIVEL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNUMBER_OF_RENEWAL_CDT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbNUMBER_OF_RENEWAL_CDT_CF$ in LD_SAMPLE_DETAI.NUMBER_OF_RENEWAL_CDT_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			NUMBER_OF_RENEWAL_CDT_CF = isbNUMBER_OF_RENEWAL_CDT_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NUMBER_OF_RENEWAL_CDT_CF:= isbNUMBER_OF_RENEWAL_CDT_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updGMF_FREE_SAVINGS_CTA_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbGMF_FREE_SAVINGS_CTA_CF$ in LD_SAMPLE_DETAI.GMF_FREE_SAVINGS_CTA_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			GMF_FREE_SAVINGS_CTA_CF = isbGMF_FREE_SAVINGS_CTA_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.GMF_FREE_SAVINGS_CTA_CF:= isbGMF_FREE_SAVINGS_CTA_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIDENT_NUMBER_OF_NATIVE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbIDENT_NUMBER_OF_NATIVE_CF$ in LD_SAMPLE_DETAI.IDENT_NUMBER_OF_NATIVE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			IDENT_NUMBER_OF_NATIVE_CF = isbIDENT_NUMBER_OF_NATIVE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IDENT_NUMBER_OF_NATIVE_CF:= isbIDENT_NUMBER_OF_NATIVE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updENTITY_TYPE_NATIVE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbENTITY_TYPE_NATIVE_CF$ in LD_SAMPLE_DETAI.ENTITY_TYPE_NATIVE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			ENTITY_TYPE_NATIVE_CF = isbENTITY_TYPE_NATIVE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ENTITY_TYPE_NATIVE_CF:= isbENTITY_TYPE_NATIVE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_OF_TRUST_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbTYPE_OF_TRUST_CF$ in LD_SAMPLE_DETAI.TYPE_OF_TRUST_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TYPE_OF_TRUST_CF = isbTYPE_OF_TRUST_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_OF_TRUST_CF:= isbTYPE_OF_TRUST_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNUMBER_OF_TRUST_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbNUMBER_OF_TRUST_CF$ in LD_SAMPLE_DETAI.NUMBER_OF_TRUST_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			NUMBER_OF_TRUST_CF = isbNUMBER_OF_TRUST_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NUMBER_OF_TRUST_CF:= isbNUMBER_OF_TRUST_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNAME_TRUST_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbNAME_TRUST_CF$ in LD_SAMPLE_DETAI.NAME_TRUST_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			NAME_TRUST_CF = isbNAME_TRUST_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NAME_TRUST_CF:= isbNAME_TRUST_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_OF_DEBT_PORTFOLIO_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbTYPE_OF_DEBT_PORTFOLIO_CF$ in LD_SAMPLE_DETAI.TYPE_OF_DEBT_PORTFOLIO_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TYPE_OF_DEBT_PORTFOLIO_CF = isbTYPE_OF_DEBT_PORTFOLIO_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_OF_DEBT_PORTFOLIO_CF:= isbTYPE_OF_DEBT_PORTFOLIO_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPOLICY_TYPE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbPOLICY_TYPE_CF$ in LD_SAMPLE_DETAI.POLICY_TYPE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			POLICY_TYPE_CF = isbPOLICY_TYPE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.POLICY_TYPE_CF:= isbPOLICY_TYPE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRAMIFICATION_CODE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbRAMIFICATION_CODE$ in LD_SAMPLE_DETAI.RAMIFICATION_CODE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			RAMIFICATION_CODE = isbRAMIFICATION_CODE$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RAMIFICATION_CODE:= isbRAMIFICATION_CODE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDATE_OF_PRESCRIPTION
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDATE_OF_PRESCRIPTION$ in LD_SAMPLE_DETAI.DATE_OF_PRESCRIPTION%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			DATE_OF_PRESCRIPTION = inuDATE_OF_PRESCRIPTION$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DATE_OF_PRESCRIPTION:= inuDATE_OF_PRESCRIPTION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSCORE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbSCORE$ in LD_SAMPLE_DETAI.SCORE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			SCORE = isbSCORE$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SCORE:= isbSCORE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_IDENTIFICATION_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTYPE_IDENTIFICATION_DC$ in LD_SAMPLE_DETAI.TYPE_IDENTIFICATION_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TYPE_IDENTIFICATION_DC = inuTYPE_IDENTIFICATION_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_IDENTIFICATION_DC:= inuTYPE_IDENTIFICATION_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_IDENTIFICATION_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTYPE_IDENTIFICATION_CF$ in LD_SAMPLE_DETAI.TYPE_IDENTIFICATION_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TYPE_IDENTIFICATION_CF = inuTYPE_IDENTIFICATION_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_IDENTIFICATION_CF:= inuTYPE_IDENTIFICATION_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIDENTIFICATION_NUMBER
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbIDENTIFICATION_NUMBER$ in LD_SAMPLE_DETAI.IDENTIFICATION_NUMBER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			IDENTIFICATION_NUMBER = isbIDENTIFICATION_NUMBER$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IDENTIFICATION_NUMBER:= isbIDENTIFICATION_NUMBER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRECORD_TYPE_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRECORD_TYPE_ID_CF$ in LD_SAMPLE_DETAI.RECORD_TYPE_ID_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			RECORD_TYPE_ID_CF = inuRECORD_TYPE_ID_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RECORD_TYPE_ID_CF:= inuRECORD_TYPE_ID_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFULL_NAME
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbFULL_NAME$ in LD_SAMPLE_DETAI.FULL_NAME%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			FULL_NAME = isbFULL_NAME$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FULL_NAME:= isbFULL_NAME$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updACCOUNT_NUMBER
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbACCOUNT_NUMBER$ in LD_SAMPLE_DETAI.ACCOUNT_NUMBER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			ACCOUNT_NUMBER = isbACCOUNT_NUMBER$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACCOUNT_NUMBER:= isbACCOUNT_NUMBER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBRANCH_OFFICE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbBRANCH_OFFICE_CF$ in LD_SAMPLE_DETAI.BRANCH_OFFICE_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			BRANCH_OFFICE_CF = isbBRANCH_OFFICE_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BRANCH_OFFICE_CF:= isbBRANCH_OFFICE_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSITUATION_HOLDER_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSITUATION_HOLDER_DC$ in LD_SAMPLE_DETAI.SITUATION_HOLDER_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			SITUATION_HOLDER_DC = inuSITUATION_HOLDER_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SITUATION_HOLDER_DC:= inuSITUATION_HOLDER_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updOPENING_DATE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuOPENING_DATE$ in LD_SAMPLE_DETAI.OPENING_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			OPENING_DATE = inuOPENING_DATE$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OPENING_DATE:= inuOPENING_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDUE_DATE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDUE_DATE_DC$ in LD_SAMPLE_DETAI.DUE_DATE_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			DUE_DATE_DC = inuDUE_DATE_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DUE_DATE_DC:= inuDUE_DATE_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRESPONSIBLE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRESPONSIBLE_DC$ in LD_SAMPLE_DETAI.RESPONSIBLE_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			RESPONSIBLE_DC = inuRESPONSIBLE_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RESPONSIBLE_DC:= inuRESPONSIBLE_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_OBLIGATION_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTYPE_OBLIGATION_ID_DC$ in LD_SAMPLE_DETAI.TYPE_OBLIGATION_ID_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TYPE_OBLIGATION_ID_DC = inuTYPE_OBLIGATION_ID_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_OBLIGATION_ID_DC:= inuTYPE_OBLIGATION_ID_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMORTGAGE_SUBSIDY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuMORTGAGE_SUBSIDY_DC$ in LD_SAMPLE_DETAI.MORTGAGE_SUBSIDY_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			MORTGAGE_SUBSIDY_DC = inuMORTGAGE_SUBSIDY_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MORTGAGE_SUBSIDY_DC:= inuMORTGAGE_SUBSIDY_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDATE_SUBSIDY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDATE_SUBSIDY_DC$ in LD_SAMPLE_DETAI.DATE_SUBSIDY_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			DATE_SUBSIDY_DC = inuDATE_SUBSIDY_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DATE_SUBSIDY_DC:= inuDATE_SUBSIDY_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_CONTRACT_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbTYPE_CONTRACT_ID_CF$ in LD_SAMPLE_DETAI.TYPE_CONTRACT_ID_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TYPE_CONTRACT_ID_CF = isbTYPE_CONTRACT_ID_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_CONTRACT_ID_CF:= isbTYPE_CONTRACT_ID_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSTATE_OF_CONTRACT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSTATE_OF_CONTRACT_CF$ in LD_SAMPLE_DETAI.STATE_OF_CONTRACT_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			STATE_OF_CONTRACT_CF = inuSTATE_OF_CONTRACT_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.STATE_OF_CONTRACT_CF:= inuSTATE_OF_CONTRACT_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTERM_CONTRACT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTERM_CONTRACT_CF$ in LD_SAMPLE_DETAI.TERM_CONTRACT_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TERM_CONTRACT_CF = inuTERM_CONTRACT_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERM_CONTRACT_CF:= inuTERM_CONTRACT_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTERM_CONTRACT_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTERM_CONTRACT_DC$ in LD_SAMPLE_DETAI.TERM_CONTRACT_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TERM_CONTRACT_DC = inuTERM_CONTRACT_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERM_CONTRACT_DC:= inuTERM_CONTRACT_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMETHOD_PAYMENT_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuMETHOD_PAYMENT_ID_CF$ in LD_SAMPLE_DETAI.METHOD_PAYMENT_ID_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			METHOD_PAYMENT_ID_CF = inuMETHOD_PAYMENT_ID_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.METHOD_PAYMENT_ID_CF:= inuMETHOD_PAYMENT_ID_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMETHOD_PAYMENT_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuMETHOD_PAYMENT_ID_DC$ in LD_SAMPLE_DETAI.METHOD_PAYMENT_ID_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			METHOD_PAYMENT_ID_DC = inuMETHOD_PAYMENT_ID_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.METHOD_PAYMENT_ID_DC:= inuMETHOD_PAYMENT_ID_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPERIODICITY_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuPERIODICITY_ID_DC$ in LD_SAMPLE_DETAI.PERIODICITY_ID_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			PERIODICITY_ID_DC = inuPERIODICITY_ID_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PERIODICITY_ID_DC:= inuPERIODICITY_ID_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPERIODICITY_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuPERIODICITY_ID_CF$ in LD_SAMPLE_DETAI.PERIODICITY_ID_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			PERIODICITY_ID_CF = inuPERIODICITY_ID_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PERIODICITY_ID_CF:= inuPERIODICITY_ID_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNEW_PORTFOLIO_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuNEW_PORTFOLIO_ID_DC$ in LD_SAMPLE_DETAI.NEW_PORTFOLIO_ID_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			NEW_PORTFOLIO_ID_DC = inuNEW_PORTFOLIO_ID_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NEW_PORTFOLIO_ID_DC:= inuNEW_PORTFOLIO_ID_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSTATE_OBLIGATION_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSTATE_OBLIGATION_CF$ in LD_SAMPLE_DETAI.STATE_OBLIGATION_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			STATE_OBLIGATION_CF = inuSTATE_OBLIGATION_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.STATE_OBLIGATION_CF:= inuSTATE_OBLIGATION_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSITUATION_HOLDER_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSITUATION_HOLDER_CF$ in LD_SAMPLE_DETAI.SITUATION_HOLDER_CF%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			SITUATION_HOLDER_CF = inuSITUATION_HOLDER_CF$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SITUATION_HOLDER_CF:= inuSITUATION_HOLDER_CF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updACCOUNT_STATE_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuACCOUNT_STATE_ID_DC$ in LD_SAMPLE_DETAI.ACCOUNT_STATE_ID_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			ACCOUNT_STATE_ID_DC = inuACCOUNT_STATE_ID_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACCOUNT_STATE_ID_DC:= inuACCOUNT_STATE_ID_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDATE_STATUS_ORIGIN
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDATE_STATUS_ORIGIN$ in LD_SAMPLE_DETAI.DATE_STATUS_ORIGIN%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			DATE_STATUS_ORIGIN = inuDATE_STATUS_ORIGIN$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DATE_STATUS_ORIGIN:= inuDATE_STATUS_ORIGIN$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSOURCE_STATE_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSOURCE_STATE_ID$ in LD_SAMPLE_DETAI.SOURCE_STATE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			SOURCE_STATE_ID = inuSOURCE_STATE_ID$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SOURCE_STATE_ID:= inuSOURCE_STATE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDATE_STATUS_ACCOUNT
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDATE_STATUS_ACCOUNT$ in LD_SAMPLE_DETAI.DATE_STATUS_ACCOUNT%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			DATE_STATUS_ACCOUNT = inuDATE_STATUS_ACCOUNT$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DATE_STATUS_ACCOUNT:= inuDATE_STATUS_ACCOUNT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSTATUS_PLASTIC_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSTATUS_PLASTIC_DC$ in LD_SAMPLE_DETAI.STATUS_PLASTIC_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			STATUS_PLASTIC_DC = inuSTATUS_PLASTIC_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.STATUS_PLASTIC_DC:= inuSTATUS_PLASTIC_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDATE_STATUS_PLASTIC_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDATE_STATUS_PLASTIC_DC$ in LD_SAMPLE_DETAI.DATE_STATUS_PLASTIC_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			DATE_STATUS_PLASTIC_DC = inuDATE_STATUS_PLASTIC_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DATE_STATUS_PLASTIC_DC:= inuDATE_STATUS_PLASTIC_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updADJETIVE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuADJETIVE_DC$ in LD_SAMPLE_DETAI.ADJETIVE_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			ADJETIVE_DC = inuADJETIVE_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ADJETIVE_DC:= inuADJETIVE_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDATE_ADJETIVE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDATE_ADJETIVE_DC$ in LD_SAMPLE_DETAI.DATE_ADJETIVE_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			DATE_ADJETIVE_DC = inuDATE_ADJETIVE_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DATE_ADJETIVE_DC:= inuDATE_ADJETIVE_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCARD_CLASS_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuCARD_CLASS_DC$ in LD_SAMPLE_DETAI.CARD_CLASS_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			CARD_CLASS_DC = inuCARD_CLASS_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CARD_CLASS_DC:= inuCARD_CLASS_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFRANCHISE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuFRANCHISE_DC$ in LD_SAMPLE_DETAI.FRANCHISE_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			FRANCHISE_DC = inuFRANCHISE_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FRANCHISE_DC:= inuFRANCHISE_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRIVATE_BRAND_NAME_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbPRIVATE_BRAND_NAME_DC$ in LD_SAMPLE_DETAI.PRIVATE_BRAND_NAME_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			PRIVATE_BRAND_NAME_DC = isbPRIVATE_BRAND_NAME_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRIVATE_BRAND_NAME_DC:= isbPRIVATE_BRAND_NAME_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_MONEY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTYPE_MONEY_DC$ in LD_SAMPLE_DETAI.TYPE_MONEY_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TYPE_MONEY_DC = inuTYPE_MONEY_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_MONEY_DC:= inuTYPE_MONEY_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTYPE_WARRANTY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTYPE_WARRANTY_DC$ in LD_SAMPLE_DETAI.TYPE_WARRANTY_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TYPE_WARRANTY_DC = inuTYPE_WARRANTY_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TYPE_WARRANTY_DC:= inuTYPE_WARRANTY_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRATINGS_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbRATINGS_DC$ in LD_SAMPLE_DETAI.RATINGS_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			RATINGS_DC = isbRATINGS_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RATINGS_DC:= isbRATINGS_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPROBABILITY_DEFAULT_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuPROBABILITY_DEFAULT_DC$ in LD_SAMPLE_DETAI.PROBABILITY_DEFAULT_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			PROBABILITY_DEFAULT_DC = inuPROBABILITY_DEFAULT_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PROBABILITY_DEFAULT_DC:= inuPROBABILITY_DEFAULT_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMORA_AGE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuMORA_AGE$ in LD_SAMPLE_DETAI.MORA_AGE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			MORA_AGE = inuMORA_AGE$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MORA_AGE:= inuMORA_AGE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updINITIAL_VALUES_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuINITIAL_VALUES_DC$ in LD_SAMPLE_DETAI.INITIAL_VALUES_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			INITIAL_VALUES_DC = inuINITIAL_VALUES_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.INITIAL_VALUES_DC:= inuINITIAL_VALUES_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEBT_TO_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDEBT_TO_DC$ in LD_SAMPLE_DETAI.DEBT_TO_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			DEBT_TO_DC = inuDEBT_TO_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEBT_TO_DC:= inuDEBT_TO_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALUE_AVAILABLE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuVALUE_AVAILABLE$ in LD_SAMPLE_DETAI.VALUE_AVAILABLE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			VALUE_AVAILABLE = inuVALUE_AVAILABLE$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALUE_AVAILABLE:= inuVALUE_AVAILABLE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMONTHLY_VALUE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuMONTHLY_VALUE$ in LD_SAMPLE_DETAI.MONTHLY_VALUE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			MONTHLY_VALUE = inuMONTHLY_VALUE$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MONTHLY_VALUE:= inuMONTHLY_VALUE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALUE_DELAY
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuVALUE_DELAY$ in LD_SAMPLE_DETAI.VALUE_DELAY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			VALUE_DELAY = inuVALUE_DELAY$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALUE_DELAY:= inuVALUE_DELAY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTOTAL_SHARES
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuTOTAL_SHARES$ in LD_SAMPLE_DETAI.TOTAL_SHARES%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			TOTAL_SHARES = inuTOTAL_SHARES$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TOTAL_SHARES:= inuTOTAL_SHARES$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSHARES_CANCELED
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSHARES_CANCELED$ in LD_SAMPLE_DETAI.SHARES_CANCELED%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			SHARES_CANCELED = inuSHARES_CANCELED$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SHARES_CANCELED:= inuSHARES_CANCELED$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSHARES_DEBT
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuSHARES_DEBT$ in LD_SAMPLE_DETAI.SHARES_DEBT%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			SHARES_DEBT = inuSHARES_DEBT$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SHARES_DEBT:= inuSHARES_DEBT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCLAUSE_PERMANENCE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuCLAUSE_PERMANENCE_DC$ in LD_SAMPLE_DETAI.CLAUSE_PERMANENCE_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			CLAUSE_PERMANENCE_DC = inuCLAUSE_PERMANENCE_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CLAUSE_PERMANENCE_DC:= inuCLAUSE_PERMANENCE_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDATE_CLAUSE_PERMANENCE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDATE_CLAUSE_PERMANENCE_DC$ in LD_SAMPLE_DETAI.DATE_CLAUSE_PERMANENCE_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			DATE_CLAUSE_PERMANENCE_DC = inuDATE_CLAUSE_PERMANENCE_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DATE_CLAUSE_PERMANENCE_DC:= inuDATE_CLAUSE_PERMANENCE_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPAYMENT_DEADLINE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuPAYMENT_DEADLINE_DC$ in LD_SAMPLE_DETAI.PAYMENT_DEADLINE_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			PAYMENT_DEADLINE_DC = inuPAYMENT_DEADLINE_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PAYMENT_DEADLINE_DC:= inuPAYMENT_DEADLINE_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPAYMENT_DATE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuPAYMENT_DATE$ in LD_SAMPLE_DETAI.PAYMENT_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			PAYMENT_DATE = inuPAYMENT_DATE$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PAYMENT_DATE:= inuPAYMENT_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRADICATION_OFFICE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbRADICATION_OFFICE_DC$ in LD_SAMPLE_DETAI.RADICATION_OFFICE_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			RADICATION_OFFICE_DC = isbRADICATION_OFFICE_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RADICATION_OFFICE_DC:= isbRADICATION_OFFICE_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCITY_RADICATION_OFFICE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbCITY_RADICATION_OFFICE_DC$ in LD_SAMPLE_DETAI.CITY_RADICATION_OFFICE_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			CITY_RADICATION_OFFICE_DC = isbCITY_RADICATION_OFFICE_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CITY_RADICATION_OFFICE_DC:= isbCITY_RADICATION_OFFICE_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRESIDENTIAL_CITY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbRESIDENTIAL_CITY_DC$ in LD_SAMPLE_DETAI.RESIDENTIAL_CITY_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			RESIDENTIAL_CITY_DC = isbRESIDENTIAL_CITY_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RESIDENTIAL_CITY_DC:= isbRESIDENTIAL_CITY_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRESIDENTIAL_DEPARTMENT_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbRESIDENTIAL_DEPARTMENT_DC$ in LD_SAMPLE_DETAI.RESIDENTIAL_DEPARTMENT_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			RESIDENTIAL_DEPARTMENT_DC = isbRESIDENTIAL_DEPARTMENT_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RESIDENTIAL_DEPARTMENT_DC:= isbRESIDENTIAL_DEPARTMENT_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRESIDENTIAL_ADDRESS_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbRESIDENTIAL_ADDRESS_DC$ in LD_SAMPLE_DETAI.RESIDENTIAL_ADDRESS_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			RESIDENTIAL_ADDRESS_DC = isbRESIDENTIAL_ADDRESS_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RESIDENTIAL_ADDRESS_DC:= isbRESIDENTIAL_ADDRESS_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRESIDENTIAL_PHONE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRESIDENTIAL_PHONE_DC$ in LD_SAMPLE_DETAI.RESIDENTIAL_PHONE_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			RESIDENTIAL_PHONE_DC = inuRESIDENTIAL_PHONE_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RESIDENTIAL_PHONE_DC:= inuRESIDENTIAL_PHONE_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCITY_WORK_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbCITY_WORK_DC$ in LD_SAMPLE_DETAI.CITY_WORK_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			CITY_WORK_DC = isbCITY_WORK_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CITY_WORK_DC:= isbCITY_WORK_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCITY_WORK_DANE_CODE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuCITY_WORK_DANE_CODE_DC$ in LD_SAMPLE_DETAI.CITY_WORK_DANE_CODE_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			CITY_WORK_DANE_CODE_DC = inuCITY_WORK_DANE_CODE_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CITY_WORK_DANE_CODE_DC:= inuCITY_WORK_DANE_CODE_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEPARTMENT_WORK_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbDEPARTMENT_WORK_DC$ in LD_SAMPLE_DETAI.DEPARTMENT_WORK_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			DEPARTMENT_WORK_DC = isbDEPARTMENT_WORK_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEPARTMENT_WORK_DC:= isbDEPARTMENT_WORK_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updADDRESS_WORK_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbADDRESS_WORK_DC$ in LD_SAMPLE_DETAI.ADDRESS_WORK_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			ADDRESS_WORK_DC = isbADDRESS_WORK_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ADDRESS_WORK_DC:= isbADDRESS_WORK_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPHONE_WORK_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuPHONE_WORK_DC$ in LD_SAMPLE_DETAI.PHONE_WORK_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			PHONE_WORK_DC = inuPHONE_WORK_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PHONE_WORK_DC:= inuPHONE_WORK_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCITY_CORRESPONDENCE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbCITY_CORRESPONDENCE_DC$ in LD_SAMPLE_DETAI.CITY_CORRESPONDENCE_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			CITY_CORRESPONDENCE_DC = isbCITY_CORRESPONDENCE_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CITY_CORRESPONDENCE_DC:= isbCITY_CORRESPONDENCE_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updADDRESS_CORRESPONDENCE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbADDRESS_CORRESPONDENCE_DC$ in LD_SAMPLE_DETAI.ADDRESS_CORRESPONDENCE_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			ADDRESS_CORRESPONDENCE_DC = isbADDRESS_CORRESPONDENCE_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ADDRESS_CORRESPONDENCE_DC:= isbADDRESS_CORRESPONDENCE_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updEMAIL_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbEMAIL_DC$ in LD_SAMPLE_DETAI.EMAIL_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			EMAIL_DC = isbEMAIL_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.EMAIL_DC:= isbEMAIL_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESTINATION_SUBSCRIBER_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuDESTINATION_SUBSCRIBER_DC$ in LD_SAMPLE_DETAI.DESTINATION_SUBSCRIBER_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			DESTINATION_SUBSCRIBER_DC = inuDESTINATION_SUBSCRIBER_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESTINATION_SUBSCRIBER_DC:= inuDESTINATION_SUBSCRIBER_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCEL_PHONE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuCEL_PHONE_DC$ in LD_SAMPLE_DETAI.CEL_PHONE_DC%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			CEL_PHONE_DC = inuCEL_PHONE_DC$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CEL_PHONE_DC:= inuCEL_PHONE_DC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFILLER
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		isbFILLER$ in LD_SAMPLE_DETAI.FILLER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN
		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_SAMPLE_ID,
				inuSAMPLE_ID,
				rcData
			);
		end if;

		update LD_SAMPLE_DETAI
		set
			FILLER = isbFILLER$
		where
			DETAIL_SAMPLE_ID = inuDETAIL_SAMPLE_ID and
			SAMPLE_ID = inuSAMPLE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FILLER:= isbFILLER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fsbGetNOTIFICATION
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.NOTIFICATION%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.NOTIFICATION);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.NOTIFICATION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIS_APPROVED
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.IS_APPROVED%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.IS_APPROVED);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.IS_APPROVED);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSOURCE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SOURCE%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.SOURCE);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.SOURCE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUBSCRIBER_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SUBSCRIBER_ID%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.SUBSCRIBER_ID);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.SUBSCRIBER_ID);
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
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.PRODUCT_ID%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.PRODUCT_ID);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
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
	FUNCTION fnuGetSUBSCRIPTION_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SUBSCRIPTION_ID%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.SUBSCRIPTION_ID);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.SUBSCRIPTION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSAMPLE_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SAMPLE_ID%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.SAMPLE_ID);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.SAMPLE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRESERVED_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RESERVED_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.RESERVED_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.RESERVED_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetBRANCH_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.BRANCH_CODE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.BRANCH_CODE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.BRANCH_CODE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetQUALITY_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.QUALITY_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.QUALITY_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.QUALITY_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetRATINGS_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RATINGS_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.RATINGS_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.RATINGS_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSTATE_STATUS_HOLDER_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.STATE_STATUS_HOLDER_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.STATE_STATUS_HOLDER_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.STATE_STATUS_HOLDER_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSTATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.STATE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.STATE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.STATE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetMORA_YEARS_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.MORA_YEARS_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.MORA_YEARS_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.MORA_YEARS_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetSTATEMENT_DATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.STATEMENT_DATE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.STATEMENT_DATE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.STATEMENT_DATE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetINITIAL_ISSUE_DATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.INITIAL_ISSUE_DATE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.INITIAL_ISSUE_DATE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.INITIAL_ISSUE_DATE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTERMINATION_DATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TERMINATION_DATE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TERMINATION_DATE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.TERMINATION_DATE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDUE_DATE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DUE_DATE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.DUE_DATE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.DUE_DATE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetEXTICION_MODE_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.EXTICION_MODE_ID_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.EXTICION_MODE_ID_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.EXTICION_MODE_ID_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTYPE_PAYMENT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_PAYMENT_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TYPE_PAYMENT_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.TYPE_PAYMENT_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetFIXED_CHARGE_VALUE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.FIXED_CHARGE_VALUE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.FIXED_CHARGE_VALUE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.FIXED_CHARGE_VALUE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCREDIT_LINE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CREDIT_LINE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.CREDIT_LINE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.CREDIT_LINE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTERM_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TERM_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TERM_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.TERM_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDAYS_OF_PORTFOLIO_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DAYS_OF_PORTFOLIO_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.DAYS_OF_PORTFOLIO_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.DAYS_OF_PORTFOLIO_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTHIRD_HOUSE_ADDRESS_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.THIRD_HOUSE_ADDRESS_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.THIRD_HOUSE_ADDRESS_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.THIRD_HOUSE_ADDRESS_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTHIRD_HOME_PHONE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.THIRD_HOME_PHONE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.THIRD_HOME_PHONE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.THIRD_HOME_PHONE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetEVERY_CITY_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.EVERY_CITY_CODE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.EVERY_CITY_CODE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.EVERY_CITY_CODE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTOWN_HOUSE_PARTY_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TOWN_HOUSE_PARTY_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TOWN_HOUSE_PARTY_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.TOWN_HOUSE_PARTY_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetHOME_DEPARTMENT_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.HOME_DEPARTMENT_CODE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.HOME_DEPARTMENT_CODE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.HOME_DEPARTMENT_CODE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCOMPANY_NAME_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.COMPANY_NAME_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.COMPANY_NAME_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.COMPANY_NAME_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCOMPANY_ADDRESS_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.COMPANY_ADDRESS_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.COMPANY_ADDRESS_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.COMPANY_ADDRESS_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOMPANY_PHONE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.COMPANY_PHONE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.COMPANY_PHONE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.COMPANY_PHONE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCITY_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CITY_CODE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.CITY_CODE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.CITY_CODE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetNOW_CITY_OF_THIRD_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.NOW_CITY_OF_THIRD_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.NOW_CITY_OF_THIRD_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.NOW_CITY_OF_THIRD_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDEPARTAMENT_CODE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DEPARTAMENT_CODE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.DEPARTAMENT_CODE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.DEPARTAMENT_CODE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetNAT_RESTRUCTURING_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.NAT_RESTRUCTURING_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.NAT_RESTRUCTURING_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.NAT_RESTRUCTURING_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDETAIL_SAMPLE_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.DETAIL_SAMPLE_ID);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.DETAIL_SAMPLE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetLEGAL_NATURE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.LEGAL_NATURE%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.LEGAL_NATURE);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.LEGAL_NATURE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetVALUE_OF_COLLATERAL
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.VALUE_OF_COLLATERAL%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.VALUE_OF_COLLATERAL);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.VALUE_OF_COLLATERAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSERVICE_CATEGORY
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SERVICE_CATEGORY%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.SERVICE_CATEGORY);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.SERVICE_CATEGORY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTYPE_OF_ACCOUNT
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_OF_ACCOUNT%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TYPE_OF_ACCOUNT);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.TYPE_OF_ACCOUNT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSPACE_OVERDRAFT
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SPACE_OVERDRAFT%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.SPACE_OVERDRAFT);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.SPACE_OVERDRAFT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetAUTHORIZED_DAYS
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.AUTHORIZED_DAYS%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.AUTHORIZED_DAYS);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.AUTHORIZED_DAYS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDEFAULT_MORA_AGE_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DEFAULT_MORA_AGE_ID_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.DEFAULT_MORA_AGE_ID_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.DEFAULT_MORA_AGE_ID_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTYPE_PORTFOLIO_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_PORTFOLIO_ID_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TYPE_PORTFOLIO_ID_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.TYPE_PORTFOLIO_ID_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCREDIT_MODE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CREDIT_MODE%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.CREDIT_MODE);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.CREDIT_MODE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetNIVEL
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.NIVEL%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.NIVEL);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.NIVEL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetNUMBER_OF_RENEWAL_CDT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.NUMBER_OF_RENEWAL_CDT_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.NUMBER_OF_RENEWAL_CDT_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.NUMBER_OF_RENEWAL_CDT_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetGMF_FREE_SAVINGS_CTA_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.GMF_FREE_SAVINGS_CTA_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.GMF_FREE_SAVINGS_CTA_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.GMF_FREE_SAVINGS_CTA_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetENTITY_TYPE_NATIVE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.ENTITY_TYPE_NATIVE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.ENTITY_TYPE_NATIVE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.ENTITY_TYPE_NATIVE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTYPE_OF_TRUST_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_OF_TRUST_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TYPE_OF_TRUST_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.TYPE_OF_TRUST_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetNUMBER_OF_TRUST_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.NUMBER_OF_TRUST_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.NUMBER_OF_TRUST_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.NUMBER_OF_TRUST_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetNAME_TRUST_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.NAME_TRUST_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.NAME_TRUST_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.NAME_TRUST_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPOLICY_TYPE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.POLICY_TYPE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.POLICY_TYPE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.POLICY_TYPE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetRAMIFICATION_CODE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RAMIFICATION_CODE%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.RAMIFICATION_CODE);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.RAMIFICATION_CODE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDATE_OF_PRESCRIPTION
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DATE_OF_PRESCRIPTION%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.DATE_OF_PRESCRIPTION);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.DATE_OF_PRESCRIPTION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSCORE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SCORE%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.SCORE);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.SCORE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTYPE_IDENTIFICATION_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_IDENTIFICATION_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TYPE_IDENTIFICATION_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.TYPE_IDENTIFICATION_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTYPE_IDENTIFICATION_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_IDENTIFICATION_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TYPE_IDENTIFICATION_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.TYPE_IDENTIFICATION_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIDENTIFICATION_NUMBER
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.IDENTIFICATION_NUMBER%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.IDENTIFICATION_NUMBER);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.IDENTIFICATION_NUMBER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRECORD_TYPE_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RECORD_TYPE_ID_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.RECORD_TYPE_ID_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.RECORD_TYPE_ID_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetFULL_NAME
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.FULL_NAME%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.FULL_NAME);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.FULL_NAME);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetACCOUNT_NUMBER
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.ACCOUNT_NUMBER%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.ACCOUNT_NUMBER);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.ACCOUNT_NUMBER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetBRANCH_OFFICE_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.BRANCH_OFFICE_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.BRANCH_OFFICE_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.BRANCH_OFFICE_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSITUATION_HOLDER_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SITUATION_HOLDER_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.SITUATION_HOLDER_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.SITUATION_HOLDER_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetOPENING_DATE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.OPENING_DATE%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.OPENING_DATE);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.OPENING_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDUE_DATE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DUE_DATE_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.DUE_DATE_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.DUE_DATE_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRESPONSIBLE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RESPONSIBLE_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.RESPONSIBLE_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.RESPONSIBLE_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTYPE_OBLIGATION_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_OBLIGATION_ID_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TYPE_OBLIGATION_ID_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.TYPE_OBLIGATION_ID_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetMORTGAGE_SUBSIDY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.MORTGAGE_SUBSIDY_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.MORTGAGE_SUBSIDY_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.MORTGAGE_SUBSIDY_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDATE_SUBSIDY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DATE_SUBSIDY_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.DATE_SUBSIDY_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.DATE_SUBSIDY_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTYPE_CONTRACT_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_CONTRACT_ID_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TYPE_CONTRACT_ID_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.TYPE_CONTRACT_ID_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSTATE_OF_CONTRACT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.STATE_OF_CONTRACT_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.STATE_OF_CONTRACT_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.STATE_OF_CONTRACT_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTERM_CONTRACT_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TERM_CONTRACT_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TERM_CONTRACT_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.TERM_CONTRACT_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTERM_CONTRACT_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TERM_CONTRACT_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TERM_CONTRACT_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.TERM_CONTRACT_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetMETHOD_PAYMENT_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.METHOD_PAYMENT_ID_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.METHOD_PAYMENT_ID_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.METHOD_PAYMENT_ID_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetMETHOD_PAYMENT_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.METHOD_PAYMENT_ID_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.METHOD_PAYMENT_ID_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.METHOD_PAYMENT_ID_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPERIODICITY_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.PERIODICITY_ID_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.PERIODICITY_ID_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.PERIODICITY_ID_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPERIODICITY_ID_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.PERIODICITY_ID_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.PERIODICITY_ID_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.PERIODICITY_ID_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetNEW_PORTFOLIO_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.NEW_PORTFOLIO_ID_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.NEW_PORTFOLIO_ID_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.NEW_PORTFOLIO_ID_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSTATE_OBLIGATION_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.STATE_OBLIGATION_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.STATE_OBLIGATION_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.STATE_OBLIGATION_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSITUATION_HOLDER_CF
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SITUATION_HOLDER_CF%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.SITUATION_HOLDER_CF);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.SITUATION_HOLDER_CF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetACCOUNT_STATE_ID_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.ACCOUNT_STATE_ID_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.ACCOUNT_STATE_ID_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.ACCOUNT_STATE_ID_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDATE_STATUS_ORIGIN
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DATE_STATUS_ORIGIN%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.DATE_STATUS_ORIGIN);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.DATE_STATUS_ORIGIN);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSOURCE_STATE_ID
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SOURCE_STATE_ID%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.SOURCE_STATE_ID);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.SOURCE_STATE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDATE_STATUS_ACCOUNT
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DATE_STATUS_ACCOUNT%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.DATE_STATUS_ACCOUNT);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.DATE_STATUS_ACCOUNT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSTATUS_PLASTIC_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.STATUS_PLASTIC_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.STATUS_PLASTIC_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.STATUS_PLASTIC_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDATE_STATUS_PLASTIC_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DATE_STATUS_PLASTIC_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.DATE_STATUS_PLASTIC_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.DATE_STATUS_PLASTIC_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetADJETIVE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.ADJETIVE_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.ADJETIVE_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.ADJETIVE_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDATE_ADJETIVE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DATE_ADJETIVE_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.DATE_ADJETIVE_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.DATE_ADJETIVE_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCARD_CLASS_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CARD_CLASS_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.CARD_CLASS_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.CARD_CLASS_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetFRANCHISE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.FRANCHISE_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.FRANCHISE_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.FRANCHISE_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPRIVATE_BRAND_NAME_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.PRIVATE_BRAND_NAME_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.PRIVATE_BRAND_NAME_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.PRIVATE_BRAND_NAME_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTYPE_MONEY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_MONEY_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TYPE_MONEY_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.TYPE_MONEY_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTYPE_WARRANTY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TYPE_WARRANTY_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TYPE_WARRANTY_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.TYPE_WARRANTY_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetRATINGS_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RATINGS_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.RATINGS_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.RATINGS_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPROBABILITY_DEFAULT_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.PROBABILITY_DEFAULT_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.PROBABILITY_DEFAULT_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.PROBABILITY_DEFAULT_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetMORA_AGE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.MORA_AGE%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.MORA_AGE);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.MORA_AGE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetINITIAL_VALUES_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.INITIAL_VALUES_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.INITIAL_VALUES_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.INITIAL_VALUES_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDEBT_TO_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DEBT_TO_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.DEBT_TO_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.DEBT_TO_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALUE_AVAILABLE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.VALUE_AVAILABLE%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.VALUE_AVAILABLE);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.VALUE_AVAILABLE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetMONTHLY_VALUE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.MONTHLY_VALUE%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.MONTHLY_VALUE);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.MONTHLY_VALUE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALUE_DELAY
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.VALUE_DELAY%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.VALUE_DELAY);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.VALUE_DELAY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTOTAL_SHARES
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.TOTAL_SHARES%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.TOTAL_SHARES);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.TOTAL_SHARES);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSHARES_CANCELED
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SHARES_CANCELED%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.SHARES_CANCELED);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.SHARES_CANCELED);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSHARES_DEBT
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.SHARES_DEBT%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.SHARES_DEBT);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.SHARES_DEBT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCLAUSE_PERMANENCE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CLAUSE_PERMANENCE_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.CLAUSE_PERMANENCE_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.CLAUSE_PERMANENCE_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPAYMENT_DEADLINE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.PAYMENT_DEADLINE_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.PAYMENT_DEADLINE_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.PAYMENT_DEADLINE_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPAYMENT_DATE
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.PAYMENT_DATE%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.PAYMENT_DATE);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.PAYMENT_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetRADICATION_OFFICE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RADICATION_OFFICE_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.RADICATION_OFFICE_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.RADICATION_OFFICE_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetRESIDENTIAL_CITY_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RESIDENTIAL_CITY_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.RESIDENTIAL_CITY_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.RESIDENTIAL_CITY_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetRESIDENTIAL_ADDRESS_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RESIDENTIAL_ADDRESS_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.RESIDENTIAL_ADDRESS_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.RESIDENTIAL_ADDRESS_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRESIDENTIAL_PHONE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.RESIDENTIAL_PHONE_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.RESIDENTIAL_PHONE_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.RESIDENTIAL_PHONE_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCITY_WORK_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CITY_WORK_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.CITY_WORK_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.CITY_WORK_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCITY_WORK_DANE_CODE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CITY_WORK_DANE_CODE_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.CITY_WORK_DANE_CODE_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.CITY_WORK_DANE_CODE_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDEPARTMENT_WORK_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.DEPARTMENT_WORK_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.DEPARTMENT_WORK_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.DEPARTMENT_WORK_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetADDRESS_WORK_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.ADDRESS_WORK_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.ADDRESS_WORK_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.ADDRESS_WORK_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPHONE_WORK_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.PHONE_WORK_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.PHONE_WORK_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.PHONE_WORK_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCITY_CORRESPONDENCE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CITY_CORRESPONDENCE_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.CITY_CORRESPONDENCE_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.CITY_CORRESPONDENCE_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetEMAIL_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.EMAIL_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.EMAIL_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.EMAIL_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCEL_PHONE_DC
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.CEL_PHONE_DC%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.CEL_PHONE_DC);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.CEL_PHONE_DC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetFILLER
	(
		inuDETAIL_SAMPLE_ID in LD_SAMPLE_DETAI.DETAIL_SAMPLE_ID%type,
		inuSAMPLE_ID in LD_SAMPLE_DETAI.SAMPLE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_SAMPLE_DETAI.FILLER%type
	IS
		rcError styLD_SAMPLE_DETAI;
	BEGIN

		rcError.DETAIL_SAMPLE_ID := inuDETAIL_SAMPLE_ID;
		rcError.SAMPLE_ID := inuSAMPLE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
			 )
		then
			 return(rcData.FILLER);
		end if;
		Load
		(
		 		inuDETAIL_SAMPLE_ID,
		 		inuSAMPLE_ID
		);
		return(rcData.FILLER);
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
end DALD_SAMPLE_DETAI;
/
PROMPT Otorgando permisos de ejecucion a DALD_SAMPLE_DETAI
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SAMPLE_DETAI', 'ADM_PERSON');
END;
/
