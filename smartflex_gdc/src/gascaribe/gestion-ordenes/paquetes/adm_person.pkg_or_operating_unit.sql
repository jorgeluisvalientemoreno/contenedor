CREATE OR REPLACE PACKAGE adm_person.pkg_OR_OPERATING_UNIT AS
    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF OR_OPERATING_UNIT%ROWTYPE INDEX BY BINARY_INTEGER;
    CURSOR cuOR_OPERATING_UNIT IS SELECT * FROM OR_OPERATING_UNIT;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : jpinedc
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : OR_OPERATING_UNIT
        Caso  : OSF-3828
        Fecha : 10/01/2025 11:16:10
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuOPERATING_UNIT_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM OR_OPERATING_UNIT tb
        WHERE
        OPERATING_UNIT_ID = inuOPERATING_UNIT_ID;
     
    CURSOR cuRegistroRIdLock
    (
        inuOPERATING_UNIT_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM OR_OPERATING_UNIT tb
        WHERE
        OPERATING_UNIT_ID = inuOPERATING_UNIT_ID
        FOR UPDATE NOWAIT;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuOPERATING_UNIT_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuOPERATING_UNIT_ID    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepción si el registro NO existe
    PROCEDURE prValExiste(
        inuOPERATING_UNIT_ID    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuOR_OPERATING_UNIT%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuOPERATING_UNIT_ID    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna OPER_UNIT_CODE
    FUNCTION fsbObtOPER_UNIT_CODE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.OPER_UNIT_CODE%TYPE;
 
    -- Obtiene el valor de la columna NAME
    FUNCTION fsbObtNAME(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.NAME%TYPE;
 
    -- Obtiene el valor de la columna LEGALIZE_PASSWORD
    FUNCTION fsbObtLEGALIZE_PASSWORD(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.LEGALIZE_PASSWORD%TYPE;
 
    -- Obtiene el valor de la columna ASSIGN_TYPE
    FUNCTION fsbObtASSIGN_TYPE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ASSIGN_TYPE%TYPE;
 
    -- Obtiene el valor de la columna ADDRESS
    FUNCTION fsbObtADDRESS(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ADDRESS%TYPE;
 
    -- Obtiene el valor de la columna PHONE_NUMBER
    FUNCTION fsbObtPHONE_NUMBER(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.PHONE_NUMBER%TYPE;
 
    -- Obtiene el valor de la columna FAX_NUMBER
    FUNCTION fsbObtFAX_NUMBER(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.FAX_NUMBER%TYPE;
 
    -- Obtiene el valor de la columna E_MAIL
    FUNCTION fsbObtE_MAIL(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.E_MAIL%TYPE;
 
    -- Obtiene el valor de la columna BEEPER
    FUNCTION fsbObtBEEPER(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.BEEPER%TYPE;
 
    -- Obtiene el valor de la columna EVAL_LAST_DATE
    FUNCTION fdtObtEVAL_LAST_DATE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.EVAL_LAST_DATE%TYPE;
 
    -- Obtiene el valor de la columna VEHICLE_NUMBER_PLATE
    FUNCTION fsbObtVEHICLE_NUMBER_PLATE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.VEHICLE_NUMBER_PLATE%TYPE;
 
    -- Obtiene el valor de la columna WORK_DAYS
    FUNCTION fsbObtWORK_DAYS(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.WORK_DAYS%TYPE;
 
    -- Obtiene el valor de la columna ASSIG_ORDERS_AMOUNT
    FUNCTION fnuObtASSIG_ORDERS_AMOUNT(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ASSIG_ORDERS_AMOUNT%TYPE;
 
    -- Obtiene el valor de la columna FATHER_OPER_UNIT_ID
    FUNCTION fnuObtFATHER_OPER_UNIT_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.FATHER_OPER_UNIT_ID%TYPE;
 
    -- Obtiene el valor de la columna OPER_UNIT_STATUS_ID
    FUNCTION fnuObtOPER_UNIT_STATUS_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.OPER_UNIT_STATUS_ID%TYPE;
 
    -- Obtiene el valor de la columna OPERATING_SECTOR_ID
    FUNCTION fnuObtOPERATING_SECTOR_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.OPERATING_SECTOR_ID%TYPE;
 
    -- Obtiene el valor de la columna PERSON_IN_CHARGE
    FUNCTION fnuObtPERSON_IN_CHARGE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.PERSON_IN_CHARGE%TYPE;
 
    -- Obtiene el valor de la columna OPER_UNIT_CLASSIF_ID
    FUNCTION fnuObtOPER_UNIT_CLASSIF_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.OPER_UNIT_CLASSIF_ID%TYPE;
 
    -- Obtiene el valor de la columna ORGA_AREA_ID
    FUNCTION fnuObtORGA_AREA_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ORGA_AREA_ID%TYPE;
 
    -- Obtiene el valor de la columna FOR_AUTOMATIC_LEGA
    FUNCTION fsbObtFOR_AUTOMATIC_LEGA(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.FOR_AUTOMATIC_LEGA%TYPE;
 
    -- Obtiene el valor de la columna PASSWORD_REQUIRED
    FUNCTION fsbObtPASSWORD_REQUIRED(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.PASSWORD_REQUIRED%TYPE;
 
    -- Obtiene el valor de la columna AIU_VALUE_ADMIN
    FUNCTION fnuObtAIU_VALUE_ADMIN(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.AIU_VALUE_ADMIN%TYPE;
 
    -- Obtiene el valor de la columna AIU_VALUE_UTIL
    FUNCTION fnuObtAIU_VALUE_UTIL(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.AIU_VALUE_UTIL%TYPE;
 
    -- Obtiene el valor de la columna AIU_VALUE_UNEXPECTED
    FUNCTION fnuObtAIU_VALUE_UNEXPECTED(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.AIU_VALUE_UNEXPECTED%TYPE;
 
    -- Obtiene el valor de la columna GEOCODE
    FUNCTION fnuObtGEOCODE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.GEOCODE%TYPE;
 
    -- Obtiene el valor de la columna ES_EXTERNA
    FUNCTION fsbObtES_EXTERNA(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ES_EXTERNA%TYPE;
 
    -- Obtiene el valor de la columna DIAS_REPOSICION
    FUNCTION fnuObtDIAS_REPOSICION(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.DIAS_REPOSICION%TYPE;
 
    -- Obtiene el valor de la columna ES_INSPECCIONABLE
    FUNCTION fsbObtES_INSPECCIONABLE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ES_INSPECCIONABLE%TYPE;
 
    -- Obtiene el valor de la columna CONTRACTOR_ID
    FUNCTION fnuObtCONTRACTOR_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.CONTRACTOR_ID%TYPE;
 
    -- Obtiene el valor de la columna ADMIN_BASE_ID
    FUNCTION fnuObtADMIN_BASE_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ADMIN_BASE_ID%TYPE;
 
    -- Obtiene el valor de la columna UNIT_TYPE_ID
    FUNCTION fnuObtUNIT_TYPE_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.UNIT_TYPE_ID%TYPE;
 
    -- Obtiene el valor de la columna ADD_VALUE_ORDER
    FUNCTION fnuObtADD_VALUE_ORDER(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ADD_VALUE_ORDER%TYPE;
 
    -- Obtiene el valor de la columna OUT_BASE_PREP_TIME
    FUNCTION fnuObtOUT_BASE_PREP_TIME(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.OUT_BASE_PREP_TIME%TYPE;
 
    -- Obtiene el valor de la columna RET_BASE_PREP_TIME
    FUNCTION fnuObtRET_BASE_PREP_TIME(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.RET_BASE_PREP_TIME%TYPE;
 
    -- Obtiene el valor de la columna SNACK_TIME
    FUNCTION fnuObtSNACK_TIME(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.SNACK_TIME%TYPE;
 
    -- Obtiene el valor de la columna NOTIFICATION_FLAG
    FUNCTION fsbObtNOTIFICATION_FLAG(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.NOTIFICATION_FLAG%TYPE;
 
    -- Obtiene el valor de la columna OPERATING_CENTER_ID
    FUNCTION fnuObtOPERATING_CENTER_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.OPERATING_CENTER_ID%TYPE;
 
    -- Obtiene el valor de la columna COMPANY_ID
    FUNCTION fnuObtCOMPANY_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.COMPANY_ID%TYPE;
 
    -- Obtiene el valor de la columna STARTING_ADDRESS
    FUNCTION fnuObtSTARTING_ADDRESS(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.STARTING_ADDRESS%TYPE;
 
    -- Obtiene el valor de la columna UNASSIGNABLE
    FUNCTION fsbObtUNASSIGNABLE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.UNASSIGNABLE%TYPE;
 
    -- Obtiene el valor de la columna NOTIFICABLE
    FUNCTION fsbObtNOTIFICABLE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.NOTIFICABLE%TYPE;
 
    -- Obtiene el valor de la columna ASSO_OPER_UNIT
    FUNCTION fnuObtASSO_OPER_UNIT(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ASSO_OPER_UNIT%TYPE;
 
    -- Obtiene el valor de la columna CURRENT_POSITION
    FUNCTION fxxObtCURRENT_POSITION(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.CURRENT_POSITION%TYPE;
 
    -- Obtiene el valor de la columna GEN_ADMIN_ORDER
    FUNCTION fsbObtGEN_ADMIN_ORDER(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.GEN_ADMIN_ORDER%TYPE;
 
    -- Obtiene el valor de la columna ITEM_REQ_FRECUENCY
    FUNCTION fsbObtITEM_REQ_FRECUENCY(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ITEM_REQ_FRECUENCY%TYPE;
 
    -- Obtiene el valor de la columna NEXT_ITEM_REQUEST
    FUNCTION fdtObtNEXT_ITEM_REQUEST(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.NEXT_ITEM_REQUEST%TYPE;
 
    -- Obtiene el valor de la columna OPERATING_ZONE_ID
    FUNCTION fnuObtOPERATING_ZONE_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.OPERATING_ZONE_ID%TYPE;
 
    -- Obtiene el valor de la columna ASSIGN_CAPACITY
    FUNCTION fnuObtASSIGN_CAPACITY(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ASSIGN_CAPACITY%TYPE;
 
    -- Obtiene el valor de la columna USED_ASSIGN_CAP
    FUNCTION fnuObtUSED_ASSIGN_CAP(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.USED_ASSIGN_CAP%TYPE;
 
    -- Obtiene el valor de la columna VALID_FOR_ASSIGN
    FUNCTION fsbObtVALID_FOR_ASSIGN(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.VALID_FOR_ASSIGN%TYPE;
 
    -- Obtiene el valor de la columna SUBSCRIBER_ID
    FUNCTION fnuObtSUBSCRIBER_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.SUBSCRIBER_ID%TYPE;
 
    -- Actualiza el valor de la columna OPER_UNIT_CODE
    PROCEDURE prAcOPER_UNIT_CODE(
        inuOPERATING_UNIT_ID    NUMBER,
        isbOPER_UNIT_CODE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna NAME
    PROCEDURE prAcNAME(
        inuOPERATING_UNIT_ID    NUMBER,
        isbNAME    VARCHAR2
    );
 
    -- Actualiza el valor de la columna LEGALIZE_PASSWORD
    PROCEDURE prAcLEGALIZE_PASSWORD(
        inuOPERATING_UNIT_ID    NUMBER,
        isbLEGALIZE_PASSWORD    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ASSIGN_TYPE
    PROCEDURE prAcASSIGN_TYPE(
        inuOPERATING_UNIT_ID    NUMBER,
        isbASSIGN_TYPE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ADDRESS
    PROCEDURE prAcADDRESS(
        inuOPERATING_UNIT_ID    NUMBER,
        isbADDRESS    VARCHAR2
    );
 
    -- Actualiza el valor de la columna PHONE_NUMBER
    PROCEDURE prAcPHONE_NUMBER(
        inuOPERATING_UNIT_ID    NUMBER,
        isbPHONE_NUMBER    VARCHAR2
    );
 
    -- Actualiza el valor de la columna FAX_NUMBER
    PROCEDURE prAcFAX_NUMBER(
        inuOPERATING_UNIT_ID    NUMBER,
        isbFAX_NUMBER    VARCHAR2
    );
 
    -- Actualiza el valor de la columna E_MAIL
    PROCEDURE prAcE_MAIL(
        inuOPERATING_UNIT_ID    NUMBER,
        isbE_MAIL    VARCHAR2
    );
 
    -- Actualiza el valor de la columna BEEPER
    PROCEDURE prAcBEEPER(
        inuOPERATING_UNIT_ID    NUMBER,
        isbBEEPER    VARCHAR2
    );
 
    -- Actualiza el valor de la columna EVAL_LAST_DATE
    PROCEDURE prAcEVAL_LAST_DATE(
        inuOPERATING_UNIT_ID    NUMBER,
        idtEVAL_LAST_DATE    DATE
    );
 
    -- Actualiza el valor de la columna VEHICLE_NUMBER_PLATE
    PROCEDURE prAcVEHICLE_NUMBER_PLATE(
        inuOPERATING_UNIT_ID    NUMBER,
        isbVEHICLE_NUMBER_PLATE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna WORK_DAYS
    PROCEDURE prAcWORK_DAYS(
        inuOPERATING_UNIT_ID    NUMBER,
        isbWORK_DAYS    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ASSIG_ORDERS_AMOUNT
    PROCEDURE prAcASSIG_ORDERS_AMOUNT(
        inuOPERATING_UNIT_ID    NUMBER,
        inuASSIG_ORDERS_AMOUNT    NUMBER
    );
 
    -- Actualiza el valor de la columna FATHER_OPER_UNIT_ID
    PROCEDURE prAcFATHER_OPER_UNIT_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuFATHER_OPER_UNIT_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna OPER_UNIT_STATUS_ID
    PROCEDURE prAcOPER_UNIT_STATUS_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuOPER_UNIT_STATUS_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna OPERATING_SECTOR_ID
    PROCEDURE prAcOPERATING_SECTOR_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuOPERATING_SECTOR_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna PERSON_IN_CHARGE
    PROCEDURE prAcPERSON_IN_CHARGE(
        inuOPERATING_UNIT_ID    NUMBER,
        inuPERSON_IN_CHARGE    NUMBER
    );
 
    -- Actualiza el valor de la columna OPER_UNIT_CLASSIF_ID
    PROCEDURE prAcOPER_UNIT_CLASSIF_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuOPER_UNIT_CLASSIF_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna ORGA_AREA_ID
    PROCEDURE prAcORGA_AREA_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuORGA_AREA_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna FOR_AUTOMATIC_LEGA
    PROCEDURE prAcFOR_AUTOMATIC_LEGA(
        inuOPERATING_UNIT_ID    NUMBER,
        isbFOR_AUTOMATIC_LEGA    VARCHAR2
    );
 
    -- Actualiza el valor de la columna PASSWORD_REQUIRED
    PROCEDURE prAcPASSWORD_REQUIRED(
        inuOPERATING_UNIT_ID    NUMBER,
        isbPASSWORD_REQUIRED    VARCHAR2
    );
 
    -- Actualiza el valor de la columna AIU_VALUE_ADMIN
    PROCEDURE prAcAIU_VALUE_ADMIN(
        inuOPERATING_UNIT_ID    NUMBER,
        inuAIU_VALUE_ADMIN    NUMBER
    );
 
    -- Actualiza el valor de la columna AIU_VALUE_UTIL
    PROCEDURE prAcAIU_VALUE_UTIL(
        inuOPERATING_UNIT_ID    NUMBER,
        inuAIU_VALUE_UTIL    NUMBER
    );
 
    -- Actualiza el valor de la columna AIU_VALUE_UNEXPECTED
    PROCEDURE prAcAIU_VALUE_UNEXPECTED(
        inuOPERATING_UNIT_ID    NUMBER,
        inuAIU_VALUE_UNEXPECTED    NUMBER
    );
 
    -- Actualiza el valor de la columna GEOCODE
    PROCEDURE prAcGEOCODE(
        inuOPERATING_UNIT_ID    NUMBER,
        inuGEOCODE    NUMBER
    );
 
    -- Actualiza el valor de la columna ES_EXTERNA
    PROCEDURE prAcES_EXTERNA(
        inuOPERATING_UNIT_ID    NUMBER,
        isbES_EXTERNA    VARCHAR2
    );
 
    -- Actualiza el valor de la columna DIAS_REPOSICION
    PROCEDURE prAcDIAS_REPOSICION(
        inuOPERATING_UNIT_ID    NUMBER,
        inuDIAS_REPOSICION    NUMBER
    );
 
    -- Actualiza el valor de la columna ES_INSPECCIONABLE
    PROCEDURE prAcES_INSPECCIONABLE(
        inuOPERATING_UNIT_ID    NUMBER,
        isbES_INSPECCIONABLE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna CONTRACTOR_ID
    PROCEDURE prAcCONTRACTOR_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuCONTRACTOR_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna ADMIN_BASE_ID
    PROCEDURE prAcADMIN_BASE_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuADMIN_BASE_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna UNIT_TYPE_ID
    PROCEDURE prAcUNIT_TYPE_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuUNIT_TYPE_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna ADD_VALUE_ORDER
    PROCEDURE prAcADD_VALUE_ORDER(
        inuOPERATING_UNIT_ID    NUMBER,
        inuADD_VALUE_ORDER    NUMBER
    );
 
    -- Actualiza el valor de la columna OUT_BASE_PREP_TIME
    PROCEDURE prAcOUT_BASE_PREP_TIME(
        inuOPERATING_UNIT_ID    NUMBER,
        inuOUT_BASE_PREP_TIME    NUMBER
    );
 
    -- Actualiza el valor de la columna RET_BASE_PREP_TIME
    PROCEDURE prAcRET_BASE_PREP_TIME(
        inuOPERATING_UNIT_ID    NUMBER,
        inuRET_BASE_PREP_TIME    NUMBER
    );
 
    -- Actualiza el valor de la columna SNACK_TIME
    PROCEDURE prAcSNACK_TIME(
        inuOPERATING_UNIT_ID    NUMBER,
        inuSNACK_TIME    NUMBER
    );
 
    -- Actualiza el valor de la columna NOTIFICATION_FLAG
    PROCEDURE prAcNOTIFICATION_FLAG(
        inuOPERATING_UNIT_ID    NUMBER,
        isbNOTIFICATION_FLAG    VARCHAR2
    );
 
    -- Actualiza el valor de la columna OPERATING_CENTER_ID
    PROCEDURE prAcOPERATING_CENTER_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuOPERATING_CENTER_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna COMPANY_ID
    PROCEDURE prAcCOMPANY_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuCOMPANY_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna STARTING_ADDRESS
    PROCEDURE prAcSTARTING_ADDRESS(
        inuOPERATING_UNIT_ID    NUMBER,
        inuSTARTING_ADDRESS    NUMBER
    );
 
    -- Actualiza el valor de la columna UNASSIGNABLE
    PROCEDURE prAcUNASSIGNABLE(
        inuOPERATING_UNIT_ID    NUMBER,
        isbUNASSIGNABLE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna NOTIFICABLE
    PROCEDURE prAcNOTIFICABLE(
        inuOPERATING_UNIT_ID    NUMBER,
        isbNOTIFICABLE    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ASSO_OPER_UNIT
    PROCEDURE prAcASSO_OPER_UNIT(
        inuOPERATING_UNIT_ID    NUMBER,
        inuASSO_OPER_UNIT    NUMBER
    );
 
    -- Actualiza el valor de la columna CURRENT_POSITION
    PROCEDURE prAcCURRENT_POSITION(
        inuOPERATING_UNIT_ID    NUMBER,
        igmCURRENT_POSITION    SDO_GEOMETRY
    );
 
    -- Actualiza el valor de la columna GEN_ADMIN_ORDER
    PROCEDURE prAcGEN_ADMIN_ORDER(
        inuOPERATING_UNIT_ID    NUMBER,
        isbGEN_ADMIN_ORDER    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ITEM_REQ_FRECUENCY
    PROCEDURE prAcITEM_REQ_FRECUENCY(
        inuOPERATING_UNIT_ID    NUMBER,
        isbITEM_REQ_FRECUENCY    VARCHAR2
    );
 
    -- Actualiza el valor de la columna NEXT_ITEM_REQUEST
    PROCEDURE prAcNEXT_ITEM_REQUEST(
        inuOPERATING_UNIT_ID    NUMBER,
        idtNEXT_ITEM_REQUEST    DATE
    );
 
    -- Actualiza el valor de la columna OPERATING_ZONE_ID
    PROCEDURE prAcOPERATING_ZONE_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuOPERATING_ZONE_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna ASSIGN_CAPACITY
    PROCEDURE prAcASSIGN_CAPACITY(
        inuOPERATING_UNIT_ID    NUMBER,
        inuASSIGN_CAPACITY    NUMBER
    );
 
    -- Actualiza el valor de la columna USED_ASSIGN_CAP
    PROCEDURE prAcUSED_ASSIGN_CAP(
        inuOPERATING_UNIT_ID    NUMBER,
        inuUSED_ASSIGN_CAP    NUMBER
    );
 
    -- Actualiza el valor de la columna VALID_FOR_ASSIGN
    PROCEDURE prAcVALID_FOR_ASSIGN(
        inuOPERATING_UNIT_ID    NUMBER,
        isbVALID_FOR_ASSIGN    VARCHAR2
    );
 
    -- Actualiza el valor de la columna SUBSCRIBER_ID
    PROCEDURE prAcSUBSCRIBER_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuSUBSCRIBER_ID    NUMBER
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuOR_OPERATING_UNIT%ROWTYPE);
 
END pkg_OR_OPERATING_UNIT;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_OR_OPERATING_UNIT AS
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuOPERATING_UNIT_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuOPERATING_UNIT_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuOPERATING_UNIT_ID);
            FETCH cuRegistroRId INTO rcRegistroRId;
            CLOSE cuRegistroRId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END frcObtRegistroRId;
 
    -- Retorna verdadero si el registro existe
    FUNCTION fblExiste(
        inuOPERATING_UNIT_ID    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.OPERATING_UNIT_ID IS NOT NULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fblExiste;
 
    -- Eleva error si el registro no existe
    PROCEDURE prValExiste(
        inuOPERATING_UNIT_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuOPERATING_UNIT_ID) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuOPERATING_UNIT_ID||'] en la tabla[OR_OPERATING_UNIT]');
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prValExiste;
 
    -- Inserta un registro
    PROCEDURE prInsRegistro( ircRegistro cuOR_OPERATING_UNIT%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO OR_OPERATING_UNIT(
            OPERATING_UNIT_ID,OPER_UNIT_CODE,NAME,LEGALIZE_PASSWORD,ASSIGN_TYPE,ADDRESS,PHONE_NUMBER,FAX_NUMBER,E_MAIL,BEEPER,EVAL_LAST_DATE,VEHICLE_NUMBER_PLATE,WORK_DAYS,ASSIG_ORDERS_AMOUNT,FATHER_OPER_UNIT_ID,OPER_UNIT_STATUS_ID,OPERATING_SECTOR_ID,PERSON_IN_CHARGE,OPER_UNIT_CLASSIF_ID,ORGA_AREA_ID,FOR_AUTOMATIC_LEGA,PASSWORD_REQUIRED,AIU_VALUE_ADMIN,AIU_VALUE_UTIL,AIU_VALUE_UNEXPECTED,GEOCODE,ES_EXTERNA,DIAS_REPOSICION,ES_INSPECCIONABLE,CONTRACTOR_ID,ADMIN_BASE_ID,UNIT_TYPE_ID,ADD_VALUE_ORDER,OUT_BASE_PREP_TIME,RET_BASE_PREP_TIME,SNACK_TIME,NOTIFICATION_FLAG,OPERATING_CENTER_ID,COMPANY_ID,STARTING_ADDRESS,UNASSIGNABLE,NOTIFICABLE,ASSO_OPER_UNIT,CURRENT_POSITION,GEN_ADMIN_ORDER,ITEM_REQ_FRECUENCY,NEXT_ITEM_REQUEST,OPERATING_ZONE_ID,ASSIGN_CAPACITY,USED_ASSIGN_CAP,VALID_FOR_ASSIGN,SUBSCRIBER_ID
        )
        VALUES (
            ircRegistro.OPERATING_UNIT_ID,ircRegistro.OPER_UNIT_CODE,ircRegistro.NAME,ircRegistro.LEGALIZE_PASSWORD,ircRegistro.ASSIGN_TYPE,ircRegistro.ADDRESS,ircRegistro.PHONE_NUMBER,ircRegistro.FAX_NUMBER,ircRegistro.E_MAIL,ircRegistro.BEEPER,ircRegistro.EVAL_LAST_DATE,ircRegistro.VEHICLE_NUMBER_PLATE,ircRegistro.WORK_DAYS,ircRegistro.ASSIG_ORDERS_AMOUNT,ircRegistro.FATHER_OPER_UNIT_ID,ircRegistro.OPER_UNIT_STATUS_ID,ircRegistro.OPERATING_SECTOR_ID,ircRegistro.PERSON_IN_CHARGE,ircRegistro.OPER_UNIT_CLASSIF_ID,ircRegistro.ORGA_AREA_ID,ircRegistro.FOR_AUTOMATIC_LEGA,ircRegistro.PASSWORD_REQUIRED,ircRegistro.AIU_VALUE_ADMIN,ircRegistro.AIU_VALUE_UTIL,ircRegistro.AIU_VALUE_UNEXPECTED,ircRegistro.GEOCODE,ircRegistro.ES_EXTERNA,ircRegistro.DIAS_REPOSICION,ircRegistro.ES_INSPECCIONABLE,ircRegistro.CONTRACTOR_ID,ircRegistro.ADMIN_BASE_ID,ircRegistro.UNIT_TYPE_ID,ircRegistro.ADD_VALUE_ORDER,ircRegistro.OUT_BASE_PREP_TIME,ircRegistro.RET_BASE_PREP_TIME,ircRegistro.SNACK_TIME,ircRegistro.NOTIFICATION_FLAG,ircRegistro.OPERATING_CENTER_ID,ircRegistro.COMPANY_ID,ircRegistro.STARTING_ADDRESS,ircRegistro.UNASSIGNABLE,ircRegistro.NOTIFICABLE,ircRegistro.ASSO_OPER_UNIT,ircRegistro.CURRENT_POSITION,ircRegistro.GEN_ADMIN_ORDER,ircRegistro.ITEM_REQ_FRECUENCY,ircRegistro.NEXT_ITEM_REQUEST,ircRegistro.OPERATING_ZONE_ID,ircRegistro.ASSIGN_CAPACITY,ircRegistro.USED_ASSIGN_CAP,ircRegistro.VALID_FOR_ASSIGN,ircRegistro.SUBSCRIBER_ID
        );
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prInsRegistro;
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuOPERATING_UNIT_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE OR_OPERATING_UNIT
            WHERE 
            ROWID = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prBorRegistro;
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistroxRowId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iRowId IS NOT NULL THEN
            DELETE OR_OPERATING_UNIT
            WHERE RowId = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prBorRegistroxRowId;
 
    -- Obtiene el valor de la columna OPER_UNIT_CODE
    FUNCTION fsbObtOPER_UNIT_CODE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.OPER_UNIT_CODE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtOPER_UNIT_CODE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.OPER_UNIT_CODE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtOPER_UNIT_CODE;
 
    -- Obtiene el valor de la columna NAME
    FUNCTION fsbObtNAME(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.NAME%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtNAME';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.NAME;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtNAME;
 
    -- Obtiene el valor de la columna LEGALIZE_PASSWORD
    FUNCTION fsbObtLEGALIZE_PASSWORD(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.LEGALIZE_PASSWORD%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtLEGALIZE_PASSWORD';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.LEGALIZE_PASSWORD;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtLEGALIZE_PASSWORD;
 
    -- Obtiene el valor de la columna ASSIGN_TYPE
    FUNCTION fsbObtASSIGN_TYPE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ASSIGN_TYPE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtASSIGN_TYPE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ASSIGN_TYPE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtASSIGN_TYPE;
 
    -- Obtiene el valor de la columna ADDRESS
    FUNCTION fsbObtADDRESS(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ADDRESS%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtADDRESS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ADDRESS;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtADDRESS;
 
    -- Obtiene el valor de la columna PHONE_NUMBER
    FUNCTION fsbObtPHONE_NUMBER(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.PHONE_NUMBER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtPHONE_NUMBER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PHONE_NUMBER;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtPHONE_NUMBER;
 
    -- Obtiene el valor de la columna FAX_NUMBER
    FUNCTION fsbObtFAX_NUMBER(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.FAX_NUMBER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtFAX_NUMBER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FAX_NUMBER;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtFAX_NUMBER;
 
    -- Obtiene el valor de la columna E_MAIL
    FUNCTION fsbObtE_MAIL(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.E_MAIL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtE_MAIL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.E_MAIL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtE_MAIL;
 
    -- Obtiene el valor de la columna BEEPER
    FUNCTION fsbObtBEEPER(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.BEEPER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtBEEPER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.BEEPER;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtBEEPER;
 
    -- Obtiene el valor de la columna EVAL_LAST_DATE
    FUNCTION fdtObtEVAL_LAST_DATE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.EVAL_LAST_DATE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtEVAL_LAST_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.EVAL_LAST_DATE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtEVAL_LAST_DATE;
 
    -- Obtiene el valor de la columna VEHICLE_NUMBER_PLATE
    FUNCTION fsbObtVEHICLE_NUMBER_PLATE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.VEHICLE_NUMBER_PLATE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtVEHICLE_NUMBER_PLATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.VEHICLE_NUMBER_PLATE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtVEHICLE_NUMBER_PLATE;
 
    -- Obtiene el valor de la columna WORK_DAYS
    FUNCTION fsbObtWORK_DAYS(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.WORK_DAYS%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtWORK_DAYS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.WORK_DAYS;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtWORK_DAYS;
 
    -- Obtiene el valor de la columna ASSIG_ORDERS_AMOUNT
    FUNCTION fnuObtASSIG_ORDERS_AMOUNT(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ASSIG_ORDERS_AMOUNT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtASSIG_ORDERS_AMOUNT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ASSIG_ORDERS_AMOUNT;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtASSIG_ORDERS_AMOUNT;
 
    -- Obtiene el valor de la columna FATHER_OPER_UNIT_ID
    FUNCTION fnuObtFATHER_OPER_UNIT_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.FATHER_OPER_UNIT_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtFATHER_OPER_UNIT_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FATHER_OPER_UNIT_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtFATHER_OPER_UNIT_ID;
 
    -- Obtiene el valor de la columna OPER_UNIT_STATUS_ID
    FUNCTION fnuObtOPER_UNIT_STATUS_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.OPER_UNIT_STATUS_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtOPER_UNIT_STATUS_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.OPER_UNIT_STATUS_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtOPER_UNIT_STATUS_ID;
 
    -- Obtiene el valor de la columna OPERATING_SECTOR_ID
    FUNCTION fnuObtOPERATING_SECTOR_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.OPERATING_SECTOR_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtOPERATING_SECTOR_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.OPERATING_SECTOR_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtOPERATING_SECTOR_ID;
 
    -- Obtiene el valor de la columna PERSON_IN_CHARGE
    FUNCTION fnuObtPERSON_IN_CHARGE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.PERSON_IN_CHARGE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPERSON_IN_CHARGE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PERSON_IN_CHARGE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtPERSON_IN_CHARGE;
 
    -- Obtiene el valor de la columna OPER_UNIT_CLASSIF_ID
    FUNCTION fnuObtOPER_UNIT_CLASSIF_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.OPER_UNIT_CLASSIF_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtOPER_UNIT_CLASSIF_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.OPER_UNIT_CLASSIF_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtOPER_UNIT_CLASSIF_ID;
 
    -- Obtiene el valor de la columna ORGA_AREA_ID
    FUNCTION fnuObtORGA_AREA_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ORGA_AREA_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtORGA_AREA_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ORGA_AREA_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtORGA_AREA_ID;
 
    -- Obtiene el valor de la columna FOR_AUTOMATIC_LEGA
    FUNCTION fsbObtFOR_AUTOMATIC_LEGA(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.FOR_AUTOMATIC_LEGA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtFOR_AUTOMATIC_LEGA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FOR_AUTOMATIC_LEGA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtFOR_AUTOMATIC_LEGA;
 
    -- Obtiene el valor de la columna PASSWORD_REQUIRED
    FUNCTION fsbObtPASSWORD_REQUIRED(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.PASSWORD_REQUIRED%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtPASSWORD_REQUIRED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PASSWORD_REQUIRED;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtPASSWORD_REQUIRED;
 
    -- Obtiene el valor de la columna AIU_VALUE_ADMIN
    FUNCTION fnuObtAIU_VALUE_ADMIN(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.AIU_VALUE_ADMIN%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtAIU_VALUE_ADMIN';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.AIU_VALUE_ADMIN;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtAIU_VALUE_ADMIN;
 
    -- Obtiene el valor de la columna AIU_VALUE_UTIL
    FUNCTION fnuObtAIU_VALUE_UTIL(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.AIU_VALUE_UTIL%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtAIU_VALUE_UTIL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.AIU_VALUE_UTIL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtAIU_VALUE_UTIL;
 
    -- Obtiene el valor de la columna AIU_VALUE_UNEXPECTED
    FUNCTION fnuObtAIU_VALUE_UNEXPECTED(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.AIU_VALUE_UNEXPECTED%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtAIU_VALUE_UNEXPECTED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.AIU_VALUE_UNEXPECTED;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtAIU_VALUE_UNEXPECTED;
 
    -- Obtiene el valor de la columna GEOCODE
    FUNCTION fnuObtGEOCODE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.GEOCODE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtGEOCODE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.GEOCODE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtGEOCODE;
 
    -- Obtiene el valor de la columna ES_EXTERNA
    FUNCTION fsbObtES_EXTERNA(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ES_EXTERNA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtES_EXTERNA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ES_EXTERNA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtES_EXTERNA;
 
    -- Obtiene el valor de la columna DIAS_REPOSICION
    FUNCTION fnuObtDIAS_REPOSICION(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.DIAS_REPOSICION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtDIAS_REPOSICION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.DIAS_REPOSICION;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtDIAS_REPOSICION;
 
    -- Obtiene el valor de la columna ES_INSPECCIONABLE
    FUNCTION fsbObtES_INSPECCIONABLE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ES_INSPECCIONABLE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtES_INSPECCIONABLE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ES_INSPECCIONABLE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtES_INSPECCIONABLE;
 
    -- Obtiene el valor de la columna CONTRACTOR_ID
    FUNCTION fnuObtCONTRACTOR_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.CONTRACTOR_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCONTRACTOR_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CONTRACTOR_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCONTRACTOR_ID;
 
    -- Obtiene el valor de la columna ADMIN_BASE_ID
    FUNCTION fnuObtADMIN_BASE_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ADMIN_BASE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtADMIN_BASE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ADMIN_BASE_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtADMIN_BASE_ID;
 
    -- Obtiene el valor de la columna UNIT_TYPE_ID
    FUNCTION fnuObtUNIT_TYPE_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.UNIT_TYPE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtUNIT_TYPE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.UNIT_TYPE_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtUNIT_TYPE_ID;
 
    -- Obtiene el valor de la columna ADD_VALUE_ORDER
    FUNCTION fnuObtADD_VALUE_ORDER(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ADD_VALUE_ORDER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtADD_VALUE_ORDER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ADD_VALUE_ORDER;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtADD_VALUE_ORDER;
 
    -- Obtiene el valor de la columna OUT_BASE_PREP_TIME
    FUNCTION fnuObtOUT_BASE_PREP_TIME(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.OUT_BASE_PREP_TIME%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtOUT_BASE_PREP_TIME';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.OUT_BASE_PREP_TIME;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtOUT_BASE_PREP_TIME;
 
    -- Obtiene el valor de la columna RET_BASE_PREP_TIME
    FUNCTION fnuObtRET_BASE_PREP_TIME(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.RET_BASE_PREP_TIME%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtRET_BASE_PREP_TIME';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.RET_BASE_PREP_TIME;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtRET_BASE_PREP_TIME;
 
    -- Obtiene el valor de la columna SNACK_TIME
    FUNCTION fnuObtSNACK_TIME(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.SNACK_TIME%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtSNACK_TIME';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SNACK_TIME;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtSNACK_TIME;
 
    -- Obtiene el valor de la columna NOTIFICATION_FLAG
    FUNCTION fsbObtNOTIFICATION_FLAG(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.NOTIFICATION_FLAG%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtNOTIFICATION_FLAG';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.NOTIFICATION_FLAG;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtNOTIFICATION_FLAG;
 
    -- Obtiene el valor de la columna OPERATING_CENTER_ID
    FUNCTION fnuObtOPERATING_CENTER_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.OPERATING_CENTER_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtOPERATING_CENTER_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.OPERATING_CENTER_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtOPERATING_CENTER_ID;
 
    -- Obtiene el valor de la columna COMPANY_ID
    FUNCTION fnuObtCOMPANY_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.COMPANY_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCOMPANY_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.COMPANY_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtCOMPANY_ID;
 
    -- Obtiene el valor de la columna STARTING_ADDRESS
    FUNCTION fnuObtSTARTING_ADDRESS(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.STARTING_ADDRESS%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtSTARTING_ADDRESS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.STARTING_ADDRESS;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtSTARTING_ADDRESS;
 
    -- Obtiene el valor de la columna UNASSIGNABLE
    FUNCTION fsbObtUNASSIGNABLE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.UNASSIGNABLE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtUNASSIGNABLE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.UNASSIGNABLE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtUNASSIGNABLE;
 
    -- Obtiene el valor de la columna NOTIFICABLE
    FUNCTION fsbObtNOTIFICABLE(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.NOTIFICABLE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtNOTIFICABLE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.NOTIFICABLE;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtNOTIFICABLE;
 
    -- Obtiene el valor de la columna ASSO_OPER_UNIT
    FUNCTION fnuObtASSO_OPER_UNIT(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ASSO_OPER_UNIT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtASSO_OPER_UNIT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ASSO_OPER_UNIT;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtASSO_OPER_UNIT;
 
    -- Obtiene el valor de la columna CURRENT_POSITION
    FUNCTION fxxObtCURRENT_POSITION(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.CURRENT_POSITION%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fxxObtCURRENT_POSITION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CURRENT_POSITION;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fxxObtCURRENT_POSITION;
 
    -- Obtiene el valor de la columna GEN_ADMIN_ORDER
    FUNCTION fsbObtGEN_ADMIN_ORDER(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.GEN_ADMIN_ORDER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtGEN_ADMIN_ORDER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.GEN_ADMIN_ORDER;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtGEN_ADMIN_ORDER;
 
    -- Obtiene el valor de la columna ITEM_REQ_FRECUENCY
    FUNCTION fsbObtITEM_REQ_FRECUENCY(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ITEM_REQ_FRECUENCY%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtITEM_REQ_FRECUENCY';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ITEM_REQ_FRECUENCY;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtITEM_REQ_FRECUENCY;
 
    -- Obtiene el valor de la columna NEXT_ITEM_REQUEST
    FUNCTION fdtObtNEXT_ITEM_REQUEST(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.NEXT_ITEM_REQUEST%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtNEXT_ITEM_REQUEST';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.NEXT_ITEM_REQUEST;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtNEXT_ITEM_REQUEST;
 
    -- Obtiene el valor de la columna OPERATING_ZONE_ID
    FUNCTION fnuObtOPERATING_ZONE_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.OPERATING_ZONE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtOPERATING_ZONE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.OPERATING_ZONE_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtOPERATING_ZONE_ID;
 
    -- Obtiene el valor de la columna ASSIGN_CAPACITY
    FUNCTION fnuObtASSIGN_CAPACITY(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.ASSIGN_CAPACITY%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtASSIGN_CAPACITY';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ASSIGN_CAPACITY;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtASSIGN_CAPACITY;
 
    -- Obtiene el valor de la columna USED_ASSIGN_CAP
    FUNCTION fnuObtUSED_ASSIGN_CAP(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.USED_ASSIGN_CAP%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtUSED_ASSIGN_CAP';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.USED_ASSIGN_CAP;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtUSED_ASSIGN_CAP;
 
    -- Obtiene el valor de la columna VALID_FOR_ASSIGN
    FUNCTION fsbObtVALID_FOR_ASSIGN(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.VALID_FOR_ASSIGN%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtVALID_FOR_ASSIGN';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.VALID_FOR_ASSIGN;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtVALID_FOR_ASSIGN;
 
    -- Obtiene el valor de la columna SUBSCRIBER_ID
    FUNCTION fnuObtSUBSCRIBER_ID(
        inuOPERATING_UNIT_ID    NUMBER
        ) RETURN OR_OPERATING_UNIT.SUBSCRIBER_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtSUBSCRIBER_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SUBSCRIBER_ID;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtSUBSCRIBER_ID;
 
    -- Actualiza el valor de la columna OPER_UNIT_CODE
    PROCEDURE prAcOPER_UNIT_CODE(
        inuOPERATING_UNIT_ID    NUMBER,
        isbOPER_UNIT_CODE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPER_UNIT_CODE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbOPER_UNIT_CODE,'-') <> NVL(rcRegistroAct.OPER_UNIT_CODE,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET OPER_UNIT_CODE=isbOPER_UNIT_CODE
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcOPER_UNIT_CODE;
 
    -- Actualiza el valor de la columna NAME
    PROCEDURE prAcNAME(
        inuOPERATING_UNIT_ID    NUMBER,
        isbNAME    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNAME';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbNAME,'-') <> NVL(rcRegistroAct.NAME,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET NAME=isbNAME
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcNAME;
 
    -- Actualiza el valor de la columna LEGALIZE_PASSWORD
    PROCEDURE prAcLEGALIZE_PASSWORD(
        inuOPERATING_UNIT_ID    NUMBER,
        isbLEGALIZE_PASSWORD    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLEGALIZE_PASSWORD';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbLEGALIZE_PASSWORD,'-') <> NVL(rcRegistroAct.LEGALIZE_PASSWORD,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET LEGALIZE_PASSWORD=isbLEGALIZE_PASSWORD
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcLEGALIZE_PASSWORD;
 
    -- Actualiza el valor de la columna ASSIGN_TYPE
    PROCEDURE prAcASSIGN_TYPE(
        inuOPERATING_UNIT_ID    NUMBER,
        isbASSIGN_TYPE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcASSIGN_TYPE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbASSIGN_TYPE,'-') <> NVL(rcRegistroAct.ASSIGN_TYPE,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET ASSIGN_TYPE=isbASSIGN_TYPE
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcASSIGN_TYPE;
 
    -- Actualiza el valor de la columna ADDRESS
    PROCEDURE prAcADDRESS(
        inuOPERATING_UNIT_ID    NUMBER,
        isbADDRESS    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADDRESS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbADDRESS,'-') <> NVL(rcRegistroAct.ADDRESS,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET ADDRESS=isbADDRESS
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcADDRESS;
 
    -- Actualiza el valor de la columna PHONE_NUMBER
    PROCEDURE prAcPHONE_NUMBER(
        inuOPERATING_UNIT_ID    NUMBER,
        isbPHONE_NUMBER    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPHONE_NUMBER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbPHONE_NUMBER,'-') <> NVL(rcRegistroAct.PHONE_NUMBER,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET PHONE_NUMBER=isbPHONE_NUMBER
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcPHONE_NUMBER;
 
    -- Actualiza el valor de la columna FAX_NUMBER
    PROCEDURE prAcFAX_NUMBER(
        inuOPERATING_UNIT_ID    NUMBER,
        isbFAX_NUMBER    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFAX_NUMBER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbFAX_NUMBER,'-') <> NVL(rcRegistroAct.FAX_NUMBER,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET FAX_NUMBER=isbFAX_NUMBER
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcFAX_NUMBER;
 
    -- Actualiza el valor de la columna E_MAIL
    PROCEDURE prAcE_MAIL(
        inuOPERATING_UNIT_ID    NUMBER,
        isbE_MAIL    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcE_MAIL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbE_MAIL,'-') <> NVL(rcRegistroAct.E_MAIL,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET E_MAIL=isbE_MAIL
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcE_MAIL;
 
    -- Actualiza el valor de la columna BEEPER
    PROCEDURE prAcBEEPER(
        inuOPERATING_UNIT_ID    NUMBER,
        isbBEEPER    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcBEEPER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbBEEPER,'-') <> NVL(rcRegistroAct.BEEPER,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET BEEPER=isbBEEPER
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcBEEPER;
 
    -- Actualiza el valor de la columna EVAL_LAST_DATE
    PROCEDURE prAcEVAL_LAST_DATE(
        inuOPERATING_UNIT_ID    NUMBER,
        idtEVAL_LAST_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEVAL_LAST_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(idtEVAL_LAST_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.EVAL_LAST_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_OPERATING_UNIT
            SET EVAL_LAST_DATE=idtEVAL_LAST_DATE
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcEVAL_LAST_DATE;
 
    -- Actualiza el valor de la columna VEHICLE_NUMBER_PLATE
    PROCEDURE prAcVEHICLE_NUMBER_PLATE(
        inuOPERATING_UNIT_ID    NUMBER,
        isbVEHICLE_NUMBER_PLATE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVEHICLE_NUMBER_PLATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbVEHICLE_NUMBER_PLATE,'-') <> NVL(rcRegistroAct.VEHICLE_NUMBER_PLATE,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET VEHICLE_NUMBER_PLATE=isbVEHICLE_NUMBER_PLATE
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcVEHICLE_NUMBER_PLATE;
 
    -- Actualiza el valor de la columna WORK_DAYS
    PROCEDURE prAcWORK_DAYS(
        inuOPERATING_UNIT_ID    NUMBER,
        isbWORK_DAYS    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcWORK_DAYS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbWORK_DAYS,'-') <> NVL(rcRegistroAct.WORK_DAYS,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET WORK_DAYS=isbWORK_DAYS
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcWORK_DAYS;
 
    -- Actualiza el valor de la columna ASSIG_ORDERS_AMOUNT
    PROCEDURE prAcASSIG_ORDERS_AMOUNT(
        inuOPERATING_UNIT_ID    NUMBER,
        inuASSIG_ORDERS_AMOUNT    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcASSIG_ORDERS_AMOUNT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuASSIG_ORDERS_AMOUNT,-1) <> NVL(rcRegistroAct.ASSIG_ORDERS_AMOUNT,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET ASSIG_ORDERS_AMOUNT=inuASSIG_ORDERS_AMOUNT
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcASSIG_ORDERS_AMOUNT;
 
    -- Actualiza el valor de la columna FATHER_OPER_UNIT_ID
    PROCEDURE prAcFATHER_OPER_UNIT_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuFATHER_OPER_UNIT_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFATHER_OPER_UNIT_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuFATHER_OPER_UNIT_ID,-1) <> NVL(rcRegistroAct.FATHER_OPER_UNIT_ID,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET FATHER_OPER_UNIT_ID=inuFATHER_OPER_UNIT_ID
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcFATHER_OPER_UNIT_ID;
 
    -- Actualiza el valor de la columna OPER_UNIT_STATUS_ID
    PROCEDURE prAcOPER_UNIT_STATUS_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuOPER_UNIT_STATUS_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPER_UNIT_STATUS_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuOPER_UNIT_STATUS_ID,-1) <> NVL(rcRegistroAct.OPER_UNIT_STATUS_ID,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET OPER_UNIT_STATUS_ID=inuOPER_UNIT_STATUS_ID
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcOPER_UNIT_STATUS_ID;
 
    -- Actualiza el valor de la columna OPERATING_SECTOR_ID
    PROCEDURE prAcOPERATING_SECTOR_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuOPERATING_SECTOR_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERATING_SECTOR_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuOPERATING_SECTOR_ID,-1) <> NVL(rcRegistroAct.OPERATING_SECTOR_ID,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET OPERATING_SECTOR_ID=inuOPERATING_SECTOR_ID
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcOPERATING_SECTOR_ID;
 
    -- Actualiza el valor de la columna PERSON_IN_CHARGE
    PROCEDURE prAcPERSON_IN_CHARGE(
        inuOPERATING_UNIT_ID    NUMBER,
        inuPERSON_IN_CHARGE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPERSON_IN_CHARGE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuPERSON_IN_CHARGE,-1) <> NVL(rcRegistroAct.PERSON_IN_CHARGE,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET PERSON_IN_CHARGE=inuPERSON_IN_CHARGE
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcPERSON_IN_CHARGE;
 
    -- Actualiza el valor de la columna OPER_UNIT_CLASSIF_ID
    PROCEDURE prAcOPER_UNIT_CLASSIF_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuOPER_UNIT_CLASSIF_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPER_UNIT_CLASSIF_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuOPER_UNIT_CLASSIF_ID,-1) <> NVL(rcRegistroAct.OPER_UNIT_CLASSIF_ID,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET OPER_UNIT_CLASSIF_ID=inuOPER_UNIT_CLASSIF_ID
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcOPER_UNIT_CLASSIF_ID;
 
    -- Actualiza el valor de la columna ORGA_AREA_ID
    PROCEDURE prAcORGA_AREA_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuORGA_AREA_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORGA_AREA_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuORGA_AREA_ID,-1) <> NVL(rcRegistroAct.ORGA_AREA_ID,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET ORGA_AREA_ID=inuORGA_AREA_ID
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcORGA_AREA_ID;
 
    -- Actualiza el valor de la columna FOR_AUTOMATIC_LEGA
    PROCEDURE prAcFOR_AUTOMATIC_LEGA(
        inuOPERATING_UNIT_ID    NUMBER,
        isbFOR_AUTOMATIC_LEGA    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFOR_AUTOMATIC_LEGA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbFOR_AUTOMATIC_LEGA,'-') <> NVL(rcRegistroAct.FOR_AUTOMATIC_LEGA,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET FOR_AUTOMATIC_LEGA=isbFOR_AUTOMATIC_LEGA
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcFOR_AUTOMATIC_LEGA;
 
    -- Actualiza el valor de la columna PASSWORD_REQUIRED
    PROCEDURE prAcPASSWORD_REQUIRED(
        inuOPERATING_UNIT_ID    NUMBER,
        isbPASSWORD_REQUIRED    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPASSWORD_REQUIRED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbPASSWORD_REQUIRED,'-') <> NVL(rcRegistroAct.PASSWORD_REQUIRED,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET PASSWORD_REQUIRED=isbPASSWORD_REQUIRED
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcPASSWORD_REQUIRED;
 
    -- Actualiza el valor de la columna AIU_VALUE_ADMIN
    PROCEDURE prAcAIU_VALUE_ADMIN(
        inuOPERATING_UNIT_ID    NUMBER,
        inuAIU_VALUE_ADMIN    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcAIU_VALUE_ADMIN';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuAIU_VALUE_ADMIN,-1) <> NVL(rcRegistroAct.AIU_VALUE_ADMIN,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET AIU_VALUE_ADMIN=inuAIU_VALUE_ADMIN
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcAIU_VALUE_ADMIN;
 
    -- Actualiza el valor de la columna AIU_VALUE_UTIL
    PROCEDURE prAcAIU_VALUE_UTIL(
        inuOPERATING_UNIT_ID    NUMBER,
        inuAIU_VALUE_UTIL    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcAIU_VALUE_UTIL';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuAIU_VALUE_UTIL,-1) <> NVL(rcRegistroAct.AIU_VALUE_UTIL,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET AIU_VALUE_UTIL=inuAIU_VALUE_UTIL
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcAIU_VALUE_UTIL;
 
    -- Actualiza el valor de la columna AIU_VALUE_UNEXPECTED
    PROCEDURE prAcAIU_VALUE_UNEXPECTED(
        inuOPERATING_UNIT_ID    NUMBER,
        inuAIU_VALUE_UNEXPECTED    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcAIU_VALUE_UNEXPECTED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuAIU_VALUE_UNEXPECTED,-1) <> NVL(rcRegistroAct.AIU_VALUE_UNEXPECTED,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET AIU_VALUE_UNEXPECTED=inuAIU_VALUE_UNEXPECTED
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcAIU_VALUE_UNEXPECTED;
 
    -- Actualiza el valor de la columna GEOCODE
    PROCEDURE prAcGEOCODE(
        inuOPERATING_UNIT_ID    NUMBER,
        inuGEOCODE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcGEOCODE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuGEOCODE,-1) <> NVL(rcRegistroAct.GEOCODE,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET GEOCODE=inuGEOCODE
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcGEOCODE;
 
    -- Actualiza el valor de la columna ES_EXTERNA
    PROCEDURE prAcES_EXTERNA(
        inuOPERATING_UNIT_ID    NUMBER,
        isbES_EXTERNA    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcES_EXTERNA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbES_EXTERNA,'-') <> NVL(rcRegistroAct.ES_EXTERNA,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET ES_EXTERNA=isbES_EXTERNA
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcES_EXTERNA;
 
    -- Actualiza el valor de la columna DIAS_REPOSICION
    PROCEDURE prAcDIAS_REPOSICION(
        inuOPERATING_UNIT_ID    NUMBER,
        inuDIAS_REPOSICION    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcDIAS_REPOSICION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuDIAS_REPOSICION,-1) <> NVL(rcRegistroAct.DIAS_REPOSICION,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET DIAS_REPOSICION=inuDIAS_REPOSICION
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcDIAS_REPOSICION;
 
    -- Actualiza el valor de la columna ES_INSPECCIONABLE
    PROCEDURE prAcES_INSPECCIONABLE(
        inuOPERATING_UNIT_ID    NUMBER,
        isbES_INSPECCIONABLE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcES_INSPECCIONABLE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbES_INSPECCIONABLE,'-') <> NVL(rcRegistroAct.ES_INSPECCIONABLE,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET ES_INSPECCIONABLE=isbES_INSPECCIONABLE
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcES_INSPECCIONABLE;
 
    -- Actualiza el valor de la columna CONTRACTOR_ID
    PROCEDURE prAcCONTRACTOR_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuCONTRACTOR_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONTRACTOR_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuCONTRACTOR_ID,-1) <> NVL(rcRegistroAct.CONTRACTOR_ID,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET CONTRACTOR_ID=inuCONTRACTOR_ID
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCONTRACTOR_ID;
 
    -- Actualiza el valor de la columna ADMIN_BASE_ID
    PROCEDURE prAcADMIN_BASE_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuADMIN_BASE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADMIN_BASE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuADMIN_BASE_ID,-1) <> NVL(rcRegistroAct.ADMIN_BASE_ID,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET ADMIN_BASE_ID=inuADMIN_BASE_ID
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcADMIN_BASE_ID;
 
    -- Actualiza el valor de la columna UNIT_TYPE_ID
    PROCEDURE prAcUNIT_TYPE_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuUNIT_TYPE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUNIT_TYPE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuUNIT_TYPE_ID,-1) <> NVL(rcRegistroAct.UNIT_TYPE_ID,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET UNIT_TYPE_ID=inuUNIT_TYPE_ID
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcUNIT_TYPE_ID;
 
    -- Actualiza el valor de la columna ADD_VALUE_ORDER
    PROCEDURE prAcADD_VALUE_ORDER(
        inuOPERATING_UNIT_ID    NUMBER,
        inuADD_VALUE_ORDER    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADD_VALUE_ORDER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuADD_VALUE_ORDER,-1) <> NVL(rcRegistroAct.ADD_VALUE_ORDER,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET ADD_VALUE_ORDER=inuADD_VALUE_ORDER
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcADD_VALUE_ORDER;
 
    -- Actualiza el valor de la columna OUT_BASE_PREP_TIME
    PROCEDURE prAcOUT_BASE_PREP_TIME(
        inuOPERATING_UNIT_ID    NUMBER,
        inuOUT_BASE_PREP_TIME    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOUT_BASE_PREP_TIME';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuOUT_BASE_PREP_TIME,-1) <> NVL(rcRegistroAct.OUT_BASE_PREP_TIME,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET OUT_BASE_PREP_TIME=inuOUT_BASE_PREP_TIME
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcOUT_BASE_PREP_TIME;
 
    -- Actualiza el valor de la columna RET_BASE_PREP_TIME
    PROCEDURE prAcRET_BASE_PREP_TIME(
        inuOPERATING_UNIT_ID    NUMBER,
        inuRET_BASE_PREP_TIME    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRET_BASE_PREP_TIME';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuRET_BASE_PREP_TIME,-1) <> NVL(rcRegistroAct.RET_BASE_PREP_TIME,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET RET_BASE_PREP_TIME=inuRET_BASE_PREP_TIME
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcRET_BASE_PREP_TIME;
 
    -- Actualiza el valor de la columna SNACK_TIME
    PROCEDURE prAcSNACK_TIME(
        inuOPERATING_UNIT_ID    NUMBER,
        inuSNACK_TIME    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSNACK_TIME';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuSNACK_TIME,-1) <> NVL(rcRegistroAct.SNACK_TIME,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET SNACK_TIME=inuSNACK_TIME
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcSNACK_TIME;
 
    -- Actualiza el valor de la columna NOTIFICATION_FLAG
    PROCEDURE prAcNOTIFICATION_FLAG(
        inuOPERATING_UNIT_ID    NUMBER,
        isbNOTIFICATION_FLAG    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNOTIFICATION_FLAG';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbNOTIFICATION_FLAG,'-') <> NVL(rcRegistroAct.NOTIFICATION_FLAG,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET NOTIFICATION_FLAG=isbNOTIFICATION_FLAG
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcNOTIFICATION_FLAG;
 
    -- Actualiza el valor de la columna OPERATING_CENTER_ID
    PROCEDURE prAcOPERATING_CENTER_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuOPERATING_CENTER_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERATING_CENTER_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuOPERATING_CENTER_ID,-1) <> NVL(rcRegistroAct.OPERATING_CENTER_ID,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET OPERATING_CENTER_ID=inuOPERATING_CENTER_ID
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcOPERATING_CENTER_ID;
 
    -- Actualiza el valor de la columna COMPANY_ID
    PROCEDURE prAcCOMPANY_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuCOMPANY_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMPANY_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuCOMPANY_ID,-1) <> NVL(rcRegistroAct.COMPANY_ID,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET COMPANY_ID=inuCOMPANY_ID
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCOMPANY_ID;
 
    -- Actualiza el valor de la columna STARTING_ADDRESS
    PROCEDURE prAcSTARTING_ADDRESS(
        inuOPERATING_UNIT_ID    NUMBER,
        inuSTARTING_ADDRESS    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSTARTING_ADDRESS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuSTARTING_ADDRESS,-1) <> NVL(rcRegistroAct.STARTING_ADDRESS,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET STARTING_ADDRESS=inuSTARTING_ADDRESS
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcSTARTING_ADDRESS;
 
    -- Actualiza el valor de la columna UNASSIGNABLE
    PROCEDURE prAcUNASSIGNABLE(
        inuOPERATING_UNIT_ID    NUMBER,
        isbUNASSIGNABLE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUNASSIGNABLE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbUNASSIGNABLE,'-') <> NVL(rcRegistroAct.UNASSIGNABLE,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET UNASSIGNABLE=isbUNASSIGNABLE
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcUNASSIGNABLE;
 
    -- Actualiza el valor de la columna NOTIFICABLE
    PROCEDURE prAcNOTIFICABLE(
        inuOPERATING_UNIT_ID    NUMBER,
        isbNOTIFICABLE    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNOTIFICABLE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbNOTIFICABLE,'-') <> NVL(rcRegistroAct.NOTIFICABLE,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET NOTIFICABLE=isbNOTIFICABLE
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcNOTIFICABLE;
 
    -- Actualiza el valor de la columna ASSO_OPER_UNIT
    PROCEDURE prAcASSO_OPER_UNIT(
        inuOPERATING_UNIT_ID    NUMBER,
        inuASSO_OPER_UNIT    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcASSO_OPER_UNIT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuASSO_OPER_UNIT,-1) <> NVL(rcRegistroAct.ASSO_OPER_UNIT,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET ASSO_OPER_UNIT=inuASSO_OPER_UNIT
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcASSO_OPER_UNIT;
 
    -- Actualiza el valor de la columna CURRENT_POSITION
    PROCEDURE prAcCURRENT_POSITION(
        inuOPERATING_UNIT_ID    NUMBER,
        igmCURRENT_POSITION    SDO_GEOMETRY
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCURRENT_POSITION';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(igmCURRENT_POSITION.Get_WKT,'-') <> NVL(rcRegistroAct.CURRENT_POSITION.Get_WKT,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET CURRENT_POSITION=igmCURRENT_POSITION
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCURRENT_POSITION;
 
    -- Actualiza el valor de la columna GEN_ADMIN_ORDER
    PROCEDURE prAcGEN_ADMIN_ORDER(
        inuOPERATING_UNIT_ID    NUMBER,
        isbGEN_ADMIN_ORDER    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcGEN_ADMIN_ORDER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbGEN_ADMIN_ORDER,'-') <> NVL(rcRegistroAct.GEN_ADMIN_ORDER,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET GEN_ADMIN_ORDER=isbGEN_ADMIN_ORDER
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcGEN_ADMIN_ORDER;
 
    -- Actualiza el valor de la columna ITEM_REQ_FRECUENCY
    PROCEDURE prAcITEM_REQ_FRECUENCY(
        inuOPERATING_UNIT_ID    NUMBER,
        isbITEM_REQ_FRECUENCY    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcITEM_REQ_FRECUENCY';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbITEM_REQ_FRECUENCY,'-') <> NVL(rcRegistroAct.ITEM_REQ_FRECUENCY,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET ITEM_REQ_FRECUENCY=isbITEM_REQ_FRECUENCY
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcITEM_REQ_FRECUENCY;
 
    -- Actualiza el valor de la columna NEXT_ITEM_REQUEST
    PROCEDURE prAcNEXT_ITEM_REQUEST(
        inuOPERATING_UNIT_ID    NUMBER,
        idtNEXT_ITEM_REQUEST    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNEXT_ITEM_REQUEST';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(idtNEXT_ITEM_REQUEST,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.NEXT_ITEM_REQUEST,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_OPERATING_UNIT
            SET NEXT_ITEM_REQUEST=idtNEXT_ITEM_REQUEST
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcNEXT_ITEM_REQUEST;
 
    -- Actualiza el valor de la columna OPERATING_ZONE_ID
    PROCEDURE prAcOPERATING_ZONE_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuOPERATING_ZONE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERATING_ZONE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuOPERATING_ZONE_ID,-1) <> NVL(rcRegistroAct.OPERATING_ZONE_ID,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET OPERATING_ZONE_ID=inuOPERATING_ZONE_ID
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcOPERATING_ZONE_ID;
 
    -- Actualiza el valor de la columna ASSIGN_CAPACITY
    PROCEDURE prAcASSIGN_CAPACITY(
        inuOPERATING_UNIT_ID    NUMBER,
        inuASSIGN_CAPACITY    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcASSIGN_CAPACITY';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuASSIGN_CAPACITY,-1) <> NVL(rcRegistroAct.ASSIGN_CAPACITY,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET ASSIGN_CAPACITY=inuASSIGN_CAPACITY
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcASSIGN_CAPACITY;
 
    -- Actualiza el valor de la columna USED_ASSIGN_CAP
    PROCEDURE prAcUSED_ASSIGN_CAP(
        inuOPERATING_UNIT_ID    NUMBER,
        inuUSED_ASSIGN_CAP    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUSED_ASSIGN_CAP';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuUSED_ASSIGN_CAP,-1) <> NVL(rcRegistroAct.USED_ASSIGN_CAP,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET USED_ASSIGN_CAP=inuUSED_ASSIGN_CAP
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcUSED_ASSIGN_CAP;
 
    -- Actualiza el valor de la columna VALID_FOR_ASSIGN
    PROCEDURE prAcVALID_FOR_ASSIGN(
        inuOPERATING_UNIT_ID    NUMBER,
        isbVALID_FOR_ASSIGN    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALID_FOR_ASSIGN';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(isbVALID_FOR_ASSIGN,'-') <> NVL(rcRegistroAct.VALID_FOR_ASSIGN,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET VALID_FOR_ASSIGN=isbVALID_FOR_ASSIGN
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcVALID_FOR_ASSIGN;
 
    -- Actualiza el valor de la columna SUBSCRIBER_ID
    PROCEDURE prAcSUBSCRIBER_ID(
        inuOPERATING_UNIT_ID    NUMBER,
        inuSUBSCRIBER_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSUBSCRIBER_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuOPERATING_UNIT_ID,TRUE);
        IF NVL(inuSUBSCRIBER_ID,-1) <> NVL(rcRegistroAct.SUBSCRIBER_ID,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET SUBSCRIBER_ID=inuSUBSCRIBER_ID
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcSUBSCRIBER_ID;
 
    -- Actualiza por RowId el valor de la columna OPER_UNIT_CODE
    PROCEDURE prAcOPER_UNIT_CODE_RId(
        iRowId ROWID,
        isbOPER_UNIT_CODE_O    VARCHAR2,
        isbOPER_UNIT_CODE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPER_UNIT_CODE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbOPER_UNIT_CODE_O,'-') <> NVL(isbOPER_UNIT_CODE_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET OPER_UNIT_CODE=isbOPER_UNIT_CODE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcOPER_UNIT_CODE_RId;
 
    -- Actualiza por RowId el valor de la columna NAME
    PROCEDURE prAcNAME_RId(
        iRowId ROWID,
        isbNAME_O    VARCHAR2,
        isbNAME_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNAME_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbNAME_O,'-') <> NVL(isbNAME_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET NAME=isbNAME_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcNAME_RId;
 
    -- Actualiza por RowId el valor de la columna LEGALIZE_PASSWORD
    PROCEDURE prAcLEGALIZE_PASSWORD_RId(
        iRowId ROWID,
        isbLEGALIZE_PASSWORD_O    VARCHAR2,
        isbLEGALIZE_PASSWORD_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLEGALIZE_PASSWORD_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbLEGALIZE_PASSWORD_O,'-') <> NVL(isbLEGALIZE_PASSWORD_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET LEGALIZE_PASSWORD=isbLEGALIZE_PASSWORD_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcLEGALIZE_PASSWORD_RId;
 
    -- Actualiza por RowId el valor de la columna ASSIGN_TYPE
    PROCEDURE prAcASSIGN_TYPE_RId(
        iRowId ROWID,
        isbASSIGN_TYPE_O    VARCHAR2,
        isbASSIGN_TYPE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcASSIGN_TYPE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbASSIGN_TYPE_O,'-') <> NVL(isbASSIGN_TYPE_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET ASSIGN_TYPE=isbASSIGN_TYPE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcASSIGN_TYPE_RId;
 
    -- Actualiza por RowId el valor de la columna ADDRESS
    PROCEDURE prAcADDRESS_RId(
        iRowId ROWID,
        isbADDRESS_O    VARCHAR2,
        isbADDRESS_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADDRESS_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbADDRESS_O,'-') <> NVL(isbADDRESS_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET ADDRESS=isbADDRESS_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcADDRESS_RId;
 
    -- Actualiza por RowId el valor de la columna PHONE_NUMBER
    PROCEDURE prAcPHONE_NUMBER_RId(
        iRowId ROWID,
        isbPHONE_NUMBER_O    VARCHAR2,
        isbPHONE_NUMBER_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPHONE_NUMBER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbPHONE_NUMBER_O,'-') <> NVL(isbPHONE_NUMBER_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET PHONE_NUMBER=isbPHONE_NUMBER_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcPHONE_NUMBER_RId;
 
    -- Actualiza por RowId el valor de la columna FAX_NUMBER
    PROCEDURE prAcFAX_NUMBER_RId(
        iRowId ROWID,
        isbFAX_NUMBER_O    VARCHAR2,
        isbFAX_NUMBER_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFAX_NUMBER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbFAX_NUMBER_O,'-') <> NVL(isbFAX_NUMBER_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET FAX_NUMBER=isbFAX_NUMBER_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcFAX_NUMBER_RId;
 
    -- Actualiza por RowId el valor de la columna E_MAIL
    PROCEDURE prAcE_MAIL_RId(
        iRowId ROWID,
        isbE_MAIL_O    VARCHAR2,
        isbE_MAIL_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcE_MAIL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbE_MAIL_O,'-') <> NVL(isbE_MAIL_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET E_MAIL=isbE_MAIL_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcE_MAIL_RId;
 
    -- Actualiza por RowId el valor de la columna BEEPER
    PROCEDURE prAcBEEPER_RId(
        iRowId ROWID,
        isbBEEPER_O    VARCHAR2,
        isbBEEPER_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcBEEPER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbBEEPER_O,'-') <> NVL(isbBEEPER_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET BEEPER=isbBEEPER_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcBEEPER_RId;
 
    -- Actualiza por RowId el valor de la columna EVAL_LAST_DATE
    PROCEDURE prAcEVAL_LAST_DATE_RId(
        iRowId ROWID,
        idtEVAL_LAST_DATE_O    DATE,
        idtEVAL_LAST_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEVAL_LAST_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtEVAL_LAST_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtEVAL_LAST_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_OPERATING_UNIT
            SET EVAL_LAST_DATE=idtEVAL_LAST_DATE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcEVAL_LAST_DATE_RId;
 
    -- Actualiza por RowId el valor de la columna VEHICLE_NUMBER_PLATE
    PROCEDURE prAcVEHICLE_NUMBER_PLATE_RId(
        iRowId ROWID,
        isbVEHICLE_NUMBER_PLATE_O    VARCHAR2,
        isbVEHICLE_NUMBER_PLATE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVEHICLE_NUMBER_PLATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbVEHICLE_NUMBER_PLATE_O,'-') <> NVL(isbVEHICLE_NUMBER_PLATE_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET VEHICLE_NUMBER_PLATE=isbVEHICLE_NUMBER_PLATE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcVEHICLE_NUMBER_PLATE_RId;
 
    -- Actualiza por RowId el valor de la columna WORK_DAYS
    PROCEDURE prAcWORK_DAYS_RId(
        iRowId ROWID,
        isbWORK_DAYS_O    VARCHAR2,
        isbWORK_DAYS_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcWORK_DAYS_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbWORK_DAYS_O,'-') <> NVL(isbWORK_DAYS_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET WORK_DAYS=isbWORK_DAYS_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcWORK_DAYS_RId;
 
    -- Actualiza por RowId el valor de la columna ASSIG_ORDERS_AMOUNT
    PROCEDURE prAcASSIG_ORDERS_AMOUNT_RId(
        iRowId ROWID,
        inuASSIG_ORDERS_AMOUNT_O    NUMBER,
        inuASSIG_ORDERS_AMOUNT_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcASSIG_ORDERS_AMOUNT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuASSIG_ORDERS_AMOUNT_O,-1) <> NVL(inuASSIG_ORDERS_AMOUNT_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET ASSIG_ORDERS_AMOUNT=inuASSIG_ORDERS_AMOUNT_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcASSIG_ORDERS_AMOUNT_RId;
 
    -- Actualiza por RowId el valor de la columna FATHER_OPER_UNIT_ID
    PROCEDURE prAcFATHER_OPER_UNIT_ID_RId(
        iRowId ROWID,
        inuFATHER_OPER_UNIT_ID_O    NUMBER,
        inuFATHER_OPER_UNIT_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFATHER_OPER_UNIT_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuFATHER_OPER_UNIT_ID_O,-1) <> NVL(inuFATHER_OPER_UNIT_ID_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET FATHER_OPER_UNIT_ID=inuFATHER_OPER_UNIT_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcFATHER_OPER_UNIT_ID_RId;
 
    -- Actualiza por RowId el valor de la columna OPER_UNIT_STATUS_ID
    PROCEDURE prAcOPER_UNIT_STATUS_ID_RId(
        iRowId ROWID,
        inuOPER_UNIT_STATUS_ID_O    NUMBER,
        inuOPER_UNIT_STATUS_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPER_UNIT_STATUS_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuOPER_UNIT_STATUS_ID_O,-1) <> NVL(inuOPER_UNIT_STATUS_ID_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET OPER_UNIT_STATUS_ID=inuOPER_UNIT_STATUS_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcOPER_UNIT_STATUS_ID_RId;
 
    -- Actualiza por RowId el valor de la columna OPERATING_SECTOR_ID
    PROCEDURE prAcOPERATING_SECTOR_ID_RId(
        iRowId ROWID,
        inuOPERATING_SECTOR_ID_O    NUMBER,
        inuOPERATING_SECTOR_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERATING_SECTOR_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuOPERATING_SECTOR_ID_O,-1) <> NVL(inuOPERATING_SECTOR_ID_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET OPERATING_SECTOR_ID=inuOPERATING_SECTOR_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcOPERATING_SECTOR_ID_RId;
 
    -- Actualiza por RowId el valor de la columna PERSON_IN_CHARGE
    PROCEDURE prAcPERSON_IN_CHARGE_RId(
        iRowId ROWID,
        inuPERSON_IN_CHARGE_O    NUMBER,
        inuPERSON_IN_CHARGE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPERSON_IN_CHARGE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPERSON_IN_CHARGE_O,-1) <> NVL(inuPERSON_IN_CHARGE_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET PERSON_IN_CHARGE=inuPERSON_IN_CHARGE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcPERSON_IN_CHARGE_RId;
 
    -- Actualiza por RowId el valor de la columna OPER_UNIT_CLASSIF_ID
    PROCEDURE prAcOPER_UNIT_CLASSIF_ID_RId(
        iRowId ROWID,
        inuOPER_UNIT_CLASSIF_ID_O    NUMBER,
        inuOPER_UNIT_CLASSIF_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPER_UNIT_CLASSIF_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuOPER_UNIT_CLASSIF_ID_O,-1) <> NVL(inuOPER_UNIT_CLASSIF_ID_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET OPER_UNIT_CLASSIF_ID=inuOPER_UNIT_CLASSIF_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcOPER_UNIT_CLASSIF_ID_RId;
 
    -- Actualiza por RowId el valor de la columna ORGA_AREA_ID
    PROCEDURE prAcORGA_AREA_ID_RId(
        iRowId ROWID,
        inuORGA_AREA_ID_O    NUMBER,
        inuORGA_AREA_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORGA_AREA_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORGA_AREA_ID_O,-1) <> NVL(inuORGA_AREA_ID_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET ORGA_AREA_ID=inuORGA_AREA_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcORGA_AREA_ID_RId;
 
    -- Actualiza por RowId el valor de la columna FOR_AUTOMATIC_LEGA
    PROCEDURE prAcFOR_AUTOMATIC_LEGA_RId(
        iRowId ROWID,
        isbFOR_AUTOMATIC_LEGA_O    VARCHAR2,
        isbFOR_AUTOMATIC_LEGA_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFOR_AUTOMATIC_LEGA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbFOR_AUTOMATIC_LEGA_O,'-') <> NVL(isbFOR_AUTOMATIC_LEGA_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET FOR_AUTOMATIC_LEGA=isbFOR_AUTOMATIC_LEGA_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcFOR_AUTOMATIC_LEGA_RId;
 
    -- Actualiza por RowId el valor de la columna PASSWORD_REQUIRED
    PROCEDURE prAcPASSWORD_REQUIRED_RId(
        iRowId ROWID,
        isbPASSWORD_REQUIRED_O    VARCHAR2,
        isbPASSWORD_REQUIRED_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPASSWORD_REQUIRED_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbPASSWORD_REQUIRED_O,'-') <> NVL(isbPASSWORD_REQUIRED_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET PASSWORD_REQUIRED=isbPASSWORD_REQUIRED_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcPASSWORD_REQUIRED_RId;
 
    -- Actualiza por RowId el valor de la columna AIU_VALUE_ADMIN
    PROCEDURE prAcAIU_VALUE_ADMIN_RId(
        iRowId ROWID,
        inuAIU_VALUE_ADMIN_O    NUMBER,
        inuAIU_VALUE_ADMIN_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcAIU_VALUE_ADMIN_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuAIU_VALUE_ADMIN_O,-1) <> NVL(inuAIU_VALUE_ADMIN_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET AIU_VALUE_ADMIN=inuAIU_VALUE_ADMIN_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcAIU_VALUE_ADMIN_RId;
 
    -- Actualiza por RowId el valor de la columna AIU_VALUE_UTIL
    PROCEDURE prAcAIU_VALUE_UTIL_RId(
        iRowId ROWID,
        inuAIU_VALUE_UTIL_O    NUMBER,
        inuAIU_VALUE_UTIL_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcAIU_VALUE_UTIL_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuAIU_VALUE_UTIL_O,-1) <> NVL(inuAIU_VALUE_UTIL_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET AIU_VALUE_UTIL=inuAIU_VALUE_UTIL_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcAIU_VALUE_UTIL_RId;
 
    -- Actualiza por RowId el valor de la columna AIU_VALUE_UNEXPECTED
    PROCEDURE prAcAIU_VALUE_UNEXPECTED_RId(
        iRowId ROWID,
        inuAIU_VALUE_UNEXPECTED_O    NUMBER,
        inuAIU_VALUE_UNEXPECTED_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcAIU_VALUE_UNEXPECTED_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuAIU_VALUE_UNEXPECTED_O,-1) <> NVL(inuAIU_VALUE_UNEXPECTED_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET AIU_VALUE_UNEXPECTED=inuAIU_VALUE_UNEXPECTED_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcAIU_VALUE_UNEXPECTED_RId;
 
    -- Actualiza por RowId el valor de la columna GEOCODE
    PROCEDURE prAcGEOCODE_RId(
        iRowId ROWID,
        inuGEOCODE_O    NUMBER,
        inuGEOCODE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcGEOCODE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuGEOCODE_O,-1) <> NVL(inuGEOCODE_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET GEOCODE=inuGEOCODE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcGEOCODE_RId;
 
    -- Actualiza por RowId el valor de la columna ES_EXTERNA
    PROCEDURE prAcES_EXTERNA_RId(
        iRowId ROWID,
        isbES_EXTERNA_O    VARCHAR2,
        isbES_EXTERNA_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcES_EXTERNA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbES_EXTERNA_O,'-') <> NVL(isbES_EXTERNA_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET ES_EXTERNA=isbES_EXTERNA_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcES_EXTERNA_RId;
 
    -- Actualiza por RowId el valor de la columna DIAS_REPOSICION
    PROCEDURE prAcDIAS_REPOSICION_RId(
        iRowId ROWID,
        inuDIAS_REPOSICION_O    NUMBER,
        inuDIAS_REPOSICION_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcDIAS_REPOSICION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuDIAS_REPOSICION_O,-1) <> NVL(inuDIAS_REPOSICION_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET DIAS_REPOSICION=inuDIAS_REPOSICION_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcDIAS_REPOSICION_RId;
 
    -- Actualiza por RowId el valor de la columna ES_INSPECCIONABLE
    PROCEDURE prAcES_INSPECCIONABLE_RId(
        iRowId ROWID,
        isbES_INSPECCIONABLE_O    VARCHAR2,
        isbES_INSPECCIONABLE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcES_INSPECCIONABLE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbES_INSPECCIONABLE_O,'-') <> NVL(isbES_INSPECCIONABLE_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET ES_INSPECCIONABLE=isbES_INSPECCIONABLE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcES_INSPECCIONABLE_RId;
 
    -- Actualiza por RowId el valor de la columna CONTRACTOR_ID
    PROCEDURE prAcCONTRACTOR_ID_RId(
        iRowId ROWID,
        inuCONTRACTOR_ID_O    NUMBER,
        inuCONTRACTOR_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONTRACTOR_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCONTRACTOR_ID_O,-1) <> NVL(inuCONTRACTOR_ID_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET CONTRACTOR_ID=inuCONTRACTOR_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCONTRACTOR_ID_RId;
 
    -- Actualiza por RowId el valor de la columna ADMIN_BASE_ID
    PROCEDURE prAcADMIN_BASE_ID_RId(
        iRowId ROWID,
        inuADMIN_BASE_ID_O    NUMBER,
        inuADMIN_BASE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADMIN_BASE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuADMIN_BASE_ID_O,-1) <> NVL(inuADMIN_BASE_ID_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET ADMIN_BASE_ID=inuADMIN_BASE_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcADMIN_BASE_ID_RId;
 
    -- Actualiza por RowId el valor de la columna UNIT_TYPE_ID
    PROCEDURE prAcUNIT_TYPE_ID_RId(
        iRowId ROWID,
        inuUNIT_TYPE_ID_O    NUMBER,
        inuUNIT_TYPE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUNIT_TYPE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuUNIT_TYPE_ID_O,-1) <> NVL(inuUNIT_TYPE_ID_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET UNIT_TYPE_ID=inuUNIT_TYPE_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcUNIT_TYPE_ID_RId;
 
    -- Actualiza por RowId el valor de la columna ADD_VALUE_ORDER
    PROCEDURE prAcADD_VALUE_ORDER_RId(
        iRowId ROWID,
        inuADD_VALUE_ORDER_O    NUMBER,
        inuADD_VALUE_ORDER_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADD_VALUE_ORDER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuADD_VALUE_ORDER_O,-1) <> NVL(inuADD_VALUE_ORDER_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET ADD_VALUE_ORDER=inuADD_VALUE_ORDER_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcADD_VALUE_ORDER_RId;
 
    -- Actualiza por RowId el valor de la columna OUT_BASE_PREP_TIME
    PROCEDURE prAcOUT_BASE_PREP_TIME_RId(
        iRowId ROWID,
        inuOUT_BASE_PREP_TIME_O    NUMBER,
        inuOUT_BASE_PREP_TIME_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOUT_BASE_PREP_TIME_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuOUT_BASE_PREP_TIME_O,-1) <> NVL(inuOUT_BASE_PREP_TIME_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET OUT_BASE_PREP_TIME=inuOUT_BASE_PREP_TIME_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcOUT_BASE_PREP_TIME_RId;
 
    -- Actualiza por RowId el valor de la columna RET_BASE_PREP_TIME
    PROCEDURE prAcRET_BASE_PREP_TIME_RId(
        iRowId ROWID,
        inuRET_BASE_PREP_TIME_O    NUMBER,
        inuRET_BASE_PREP_TIME_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcRET_BASE_PREP_TIME_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuRET_BASE_PREP_TIME_O,-1) <> NVL(inuRET_BASE_PREP_TIME_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET RET_BASE_PREP_TIME=inuRET_BASE_PREP_TIME_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcRET_BASE_PREP_TIME_RId;
 
    -- Actualiza por RowId el valor de la columna SNACK_TIME
    PROCEDURE prAcSNACK_TIME_RId(
        iRowId ROWID,
        inuSNACK_TIME_O    NUMBER,
        inuSNACK_TIME_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSNACK_TIME_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuSNACK_TIME_O,-1) <> NVL(inuSNACK_TIME_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET SNACK_TIME=inuSNACK_TIME_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcSNACK_TIME_RId;
 
    -- Actualiza por RowId el valor de la columna NOTIFICATION_FLAG
    PROCEDURE prAcNOTIFICATION_FLAG_RId(
        iRowId ROWID,
        isbNOTIFICATION_FLAG_O    VARCHAR2,
        isbNOTIFICATION_FLAG_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNOTIFICATION_FLAG_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbNOTIFICATION_FLAG_O,'-') <> NVL(isbNOTIFICATION_FLAG_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET NOTIFICATION_FLAG=isbNOTIFICATION_FLAG_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcNOTIFICATION_FLAG_RId;
 
    -- Actualiza por RowId el valor de la columna OPERATING_CENTER_ID
    PROCEDURE prAcOPERATING_CENTER_ID_RId(
        iRowId ROWID,
        inuOPERATING_CENTER_ID_O    NUMBER,
        inuOPERATING_CENTER_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERATING_CENTER_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuOPERATING_CENTER_ID_O,-1) <> NVL(inuOPERATING_CENTER_ID_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET OPERATING_CENTER_ID=inuOPERATING_CENTER_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcOPERATING_CENTER_ID_RId;
 
    -- Actualiza por RowId el valor de la columna COMPANY_ID
    PROCEDURE prAcCOMPANY_ID_RId(
        iRowId ROWID,
        inuCOMPANY_ID_O    NUMBER,
        inuCOMPANY_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCOMPANY_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCOMPANY_ID_O,-1) <> NVL(inuCOMPANY_ID_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET COMPANY_ID=inuCOMPANY_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCOMPANY_ID_RId;
 
    -- Actualiza por RowId el valor de la columna STARTING_ADDRESS
    PROCEDURE prAcSTARTING_ADDRESS_RId(
        iRowId ROWID,
        inuSTARTING_ADDRESS_O    NUMBER,
        inuSTARTING_ADDRESS_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSTARTING_ADDRESS_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuSTARTING_ADDRESS_O,-1) <> NVL(inuSTARTING_ADDRESS_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET STARTING_ADDRESS=inuSTARTING_ADDRESS_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcSTARTING_ADDRESS_RId;
 
    -- Actualiza por RowId el valor de la columna UNASSIGNABLE
    PROCEDURE prAcUNASSIGNABLE_RId(
        iRowId ROWID,
        isbUNASSIGNABLE_O    VARCHAR2,
        isbUNASSIGNABLE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUNASSIGNABLE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbUNASSIGNABLE_O,'-') <> NVL(isbUNASSIGNABLE_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET UNASSIGNABLE=isbUNASSIGNABLE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcUNASSIGNABLE_RId;
 
    -- Actualiza por RowId el valor de la columna NOTIFICABLE
    PROCEDURE prAcNOTIFICABLE_RId(
        iRowId ROWID,
        isbNOTIFICABLE_O    VARCHAR2,
        isbNOTIFICABLE_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNOTIFICABLE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbNOTIFICABLE_O,'-') <> NVL(isbNOTIFICABLE_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET NOTIFICABLE=isbNOTIFICABLE_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcNOTIFICABLE_RId;
 
    -- Actualiza por RowId el valor de la columna ASSO_OPER_UNIT
    PROCEDURE prAcASSO_OPER_UNIT_RId(
        iRowId ROWID,
        inuASSO_OPER_UNIT_O    NUMBER,
        inuASSO_OPER_UNIT_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcASSO_OPER_UNIT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuASSO_OPER_UNIT_O,-1) <> NVL(inuASSO_OPER_UNIT_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET ASSO_OPER_UNIT=inuASSO_OPER_UNIT_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcASSO_OPER_UNIT_RId;
 
    -- Actualiza por RowId el valor de la columna CURRENT_POSITION
    PROCEDURE prAcCURRENT_POSITION_RId(
        iRowId ROWID,
        igmCURRENT_POSITION_O    SDO_GEOMETRY,
        igmCURRENT_POSITION_N    SDO_GEOMETRY
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCURRENT_POSITION_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(igmCURRENT_POSITION_O.Get_WKT,'-') <> NVL(igmCURRENT_POSITION_N.Get_WKT,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET CURRENT_POSITION=igmCURRENT_POSITION_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcCURRENT_POSITION_RId;
 
    -- Actualiza por RowId el valor de la columna GEN_ADMIN_ORDER
    PROCEDURE prAcGEN_ADMIN_ORDER_RId(
        iRowId ROWID,
        isbGEN_ADMIN_ORDER_O    VARCHAR2,
        isbGEN_ADMIN_ORDER_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcGEN_ADMIN_ORDER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbGEN_ADMIN_ORDER_O,'-') <> NVL(isbGEN_ADMIN_ORDER_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET GEN_ADMIN_ORDER=isbGEN_ADMIN_ORDER_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcGEN_ADMIN_ORDER_RId;
 
    -- Actualiza por RowId el valor de la columna ITEM_REQ_FRECUENCY
    PROCEDURE prAcITEM_REQ_FRECUENCY_RId(
        iRowId ROWID,
        isbITEM_REQ_FRECUENCY_O    VARCHAR2,
        isbITEM_REQ_FRECUENCY_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcITEM_REQ_FRECUENCY_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbITEM_REQ_FRECUENCY_O,'-') <> NVL(isbITEM_REQ_FRECUENCY_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET ITEM_REQ_FRECUENCY=isbITEM_REQ_FRECUENCY_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcITEM_REQ_FRECUENCY_RId;
 
    -- Actualiza por RowId el valor de la columna NEXT_ITEM_REQUEST
    PROCEDURE prAcNEXT_ITEM_REQUEST_RId(
        iRowId ROWID,
        idtNEXT_ITEM_REQUEST_O    DATE,
        idtNEXT_ITEM_REQUEST_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNEXT_ITEM_REQUEST_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtNEXT_ITEM_REQUEST_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtNEXT_ITEM_REQUEST_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_OPERATING_UNIT
            SET NEXT_ITEM_REQUEST=idtNEXT_ITEM_REQUEST_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcNEXT_ITEM_REQUEST_RId;
 
    -- Actualiza por RowId el valor de la columna OPERATING_ZONE_ID
    PROCEDURE prAcOPERATING_ZONE_ID_RId(
        iRowId ROWID,
        inuOPERATING_ZONE_ID_O    NUMBER,
        inuOPERATING_ZONE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERATING_ZONE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuOPERATING_ZONE_ID_O,-1) <> NVL(inuOPERATING_ZONE_ID_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET OPERATING_ZONE_ID=inuOPERATING_ZONE_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcOPERATING_ZONE_ID_RId;
 
    -- Actualiza por RowId el valor de la columna ASSIGN_CAPACITY
    PROCEDURE prAcASSIGN_CAPACITY_RId(
        iRowId ROWID,
        inuASSIGN_CAPACITY_O    NUMBER,
        inuASSIGN_CAPACITY_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcASSIGN_CAPACITY_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuASSIGN_CAPACITY_O,-1) <> NVL(inuASSIGN_CAPACITY_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET ASSIGN_CAPACITY=inuASSIGN_CAPACITY_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcASSIGN_CAPACITY_RId;
 
    -- Actualiza por RowId el valor de la columna USED_ASSIGN_CAP
    PROCEDURE prAcUSED_ASSIGN_CAP_RId(
        iRowId ROWID,
        inuUSED_ASSIGN_CAP_O    NUMBER,
        inuUSED_ASSIGN_CAP_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcUSED_ASSIGN_CAP_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuUSED_ASSIGN_CAP_O,-1) <> NVL(inuUSED_ASSIGN_CAP_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET USED_ASSIGN_CAP=inuUSED_ASSIGN_CAP_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcUSED_ASSIGN_CAP_RId;
 
    -- Actualiza por RowId el valor de la columna VALID_FOR_ASSIGN
    PROCEDURE prAcVALID_FOR_ASSIGN_RId(
        iRowId ROWID,
        isbVALID_FOR_ASSIGN_O    VARCHAR2,
        isbVALID_FOR_ASSIGN_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcVALID_FOR_ASSIGN_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbVALID_FOR_ASSIGN_O,'-') <> NVL(isbVALID_FOR_ASSIGN_N,'-') THEN
            UPDATE OR_OPERATING_UNIT
            SET VALID_FOR_ASSIGN=isbVALID_FOR_ASSIGN_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcVALID_FOR_ASSIGN_RId;
 
    -- Actualiza por RowId el valor de la columna SUBSCRIBER_ID
    PROCEDURE prAcSUBSCRIBER_ID_RId(
        iRowId ROWID,
        inuSUBSCRIBER_ID_O    NUMBER,
        inuSUBSCRIBER_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSUBSCRIBER_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuSUBSCRIBER_ID_O,-1) <> NVL(inuSUBSCRIBER_ID_N,-1) THEN
            UPDATE OR_OPERATING_UNIT
            SET SUBSCRIBER_ID=inuSUBSCRIBER_ID_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcSUBSCRIBER_ID_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuOR_OPERATING_UNIT%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.OPERATING_UNIT_ID,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcOPER_UNIT_CODE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OPER_UNIT_CODE,
                ircRegistro.OPER_UNIT_CODE
            );
 
            prAcNAME_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.NAME,
                ircRegistro.NAME
            );
 
            prAcLEGALIZE_PASSWORD_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.LEGALIZE_PASSWORD,
                ircRegistro.LEGALIZE_PASSWORD
            );
 
            prAcASSIGN_TYPE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ASSIGN_TYPE,
                ircRegistro.ASSIGN_TYPE
            );
 
            prAcADDRESS_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ADDRESS,
                ircRegistro.ADDRESS
            );
 
            prAcPHONE_NUMBER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PHONE_NUMBER,
                ircRegistro.PHONE_NUMBER
            );
 
            prAcFAX_NUMBER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FAX_NUMBER,
                ircRegistro.FAX_NUMBER
            );
 
            prAcE_MAIL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.E_MAIL,
                ircRegistro.E_MAIL
            );
 
            prAcBEEPER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.BEEPER,
                ircRegistro.BEEPER
            );
 
            prAcEVAL_LAST_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.EVAL_LAST_DATE,
                ircRegistro.EVAL_LAST_DATE
            );
 
            prAcVEHICLE_NUMBER_PLATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VEHICLE_NUMBER_PLATE,
                ircRegistro.VEHICLE_NUMBER_PLATE
            );
 
            prAcWORK_DAYS_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.WORK_DAYS,
                ircRegistro.WORK_DAYS
            );
 
            prAcASSIG_ORDERS_AMOUNT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ASSIG_ORDERS_AMOUNT,
                ircRegistro.ASSIG_ORDERS_AMOUNT
            );
 
            prAcFATHER_OPER_UNIT_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FATHER_OPER_UNIT_ID,
                ircRegistro.FATHER_OPER_UNIT_ID
            );
 
            prAcOPER_UNIT_STATUS_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OPER_UNIT_STATUS_ID,
                ircRegistro.OPER_UNIT_STATUS_ID
            );
 
            prAcOPERATING_SECTOR_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OPERATING_SECTOR_ID,
                ircRegistro.OPERATING_SECTOR_ID
            );
 
            prAcPERSON_IN_CHARGE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PERSON_IN_CHARGE,
                ircRegistro.PERSON_IN_CHARGE
            );
 
            prAcOPER_UNIT_CLASSIF_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OPER_UNIT_CLASSIF_ID,
                ircRegistro.OPER_UNIT_CLASSIF_ID
            );
 
            prAcORGA_AREA_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORGA_AREA_ID,
                ircRegistro.ORGA_AREA_ID
            );
 
            prAcFOR_AUTOMATIC_LEGA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FOR_AUTOMATIC_LEGA,
                ircRegistro.FOR_AUTOMATIC_LEGA
            );
 
            prAcPASSWORD_REQUIRED_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PASSWORD_REQUIRED,
                ircRegistro.PASSWORD_REQUIRED
            );
 
            prAcAIU_VALUE_ADMIN_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.AIU_VALUE_ADMIN,
                ircRegistro.AIU_VALUE_ADMIN
            );
 
            prAcAIU_VALUE_UTIL_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.AIU_VALUE_UTIL,
                ircRegistro.AIU_VALUE_UTIL
            );
 
            prAcAIU_VALUE_UNEXPECTED_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.AIU_VALUE_UNEXPECTED,
                ircRegistro.AIU_VALUE_UNEXPECTED
            );
 
            prAcGEOCODE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.GEOCODE,
                ircRegistro.GEOCODE
            );
 
            prAcES_EXTERNA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ES_EXTERNA,
                ircRegistro.ES_EXTERNA
            );
 
            prAcDIAS_REPOSICION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.DIAS_REPOSICION,
                ircRegistro.DIAS_REPOSICION
            );
 
            prAcES_INSPECCIONABLE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ES_INSPECCIONABLE,
                ircRegistro.ES_INSPECCIONABLE
            );
 
            prAcCONTRACTOR_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CONTRACTOR_ID,
                ircRegistro.CONTRACTOR_ID
            );
 
            prAcADMIN_BASE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ADMIN_BASE_ID,
                ircRegistro.ADMIN_BASE_ID
            );
 
            prAcUNIT_TYPE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.UNIT_TYPE_ID,
                ircRegistro.UNIT_TYPE_ID
            );
 
            prAcADD_VALUE_ORDER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ADD_VALUE_ORDER,
                ircRegistro.ADD_VALUE_ORDER
            );
 
            prAcOUT_BASE_PREP_TIME_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OUT_BASE_PREP_TIME,
                ircRegistro.OUT_BASE_PREP_TIME
            );
 
            prAcRET_BASE_PREP_TIME_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.RET_BASE_PREP_TIME,
                ircRegistro.RET_BASE_PREP_TIME
            );
 
            prAcSNACK_TIME_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SNACK_TIME,
                ircRegistro.SNACK_TIME
            );
 
            prAcNOTIFICATION_FLAG_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.NOTIFICATION_FLAG,
                ircRegistro.NOTIFICATION_FLAG
            );
 
            prAcOPERATING_CENTER_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OPERATING_CENTER_ID,
                ircRegistro.OPERATING_CENTER_ID
            );
 
            prAcCOMPANY_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.COMPANY_ID,
                ircRegistro.COMPANY_ID
            );
 
            prAcSTARTING_ADDRESS_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.STARTING_ADDRESS,
                ircRegistro.STARTING_ADDRESS
            );
 
            prAcUNASSIGNABLE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.UNASSIGNABLE,
                ircRegistro.UNASSIGNABLE
            );
 
            prAcNOTIFICABLE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.NOTIFICABLE,
                ircRegistro.NOTIFICABLE
            );
 
            prAcASSO_OPER_UNIT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ASSO_OPER_UNIT,
                ircRegistro.ASSO_OPER_UNIT
            );
 
            prAcCURRENT_POSITION_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CURRENT_POSITION,
                ircRegistro.CURRENT_POSITION
            );
 
            prAcGEN_ADMIN_ORDER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.GEN_ADMIN_ORDER,
                ircRegistro.GEN_ADMIN_ORDER
            );
 
            prAcITEM_REQ_FRECUENCY_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ITEM_REQ_FRECUENCY,
                ircRegistro.ITEM_REQ_FRECUENCY
            );
 
            prAcNEXT_ITEM_REQUEST_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.NEXT_ITEM_REQUEST,
                ircRegistro.NEXT_ITEM_REQUEST
            );
 
            prAcOPERATING_ZONE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OPERATING_ZONE_ID,
                ircRegistro.OPERATING_ZONE_ID
            );
 
            prAcASSIGN_CAPACITY_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ASSIGN_CAPACITY,
                ircRegistro.ASSIGN_CAPACITY
            );
 
            prAcUSED_ASSIGN_CAP_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.USED_ASSIGN_CAP,
                ircRegistro.USED_ASSIGN_CAP
            );
 
            prAcVALID_FOR_ASSIGN_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.VALID_FOR_ASSIGN,
                ircRegistro.VALID_FOR_ASSIGN
            );
 
            prAcSUBSCRIBER_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SUBSCRIBER_ID,
                ircRegistro.SUBSCRIBER_ID
            );
 
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prActRegistro;
 
END pkg_OR_OPERATING_UNIT;
/
BEGIN
    -- OSF-3828
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_OR_OPERATING_UNIT'), UPPER('adm_person'));
END;
/
