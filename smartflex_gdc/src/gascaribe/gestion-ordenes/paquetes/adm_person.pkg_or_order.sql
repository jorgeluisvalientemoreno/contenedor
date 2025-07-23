CREATE OR REPLACE PACKAGE adm_person.pkg_or_order IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa 	: pkg_or_order
    Autor       : Carlos Gonzalez - Horbath
    Fecha       : 03-01-2024
    Descripcion : Paquete con servicios CRUD sobre la entidad OPEN.OR_ORDER

    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    cgonzalez   03-01-2024  OSF-2155    Creacion
    jpinedc     19-03-2025  OSF-4042    * Se crea CNUITEMS_CLASS_TO_ACTIVITY
                                        * Se crea fnuObtDefined_Contract_id
*******************************************************************************/

    TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF OR_ORDER%ROWTYPE INDEX BY BINARY_INTEGER;

    CNUITEMS_CLASS_TO_ACTIVITY CONSTANT GE_ITEM_CLASSIF.ITEM_CLASSIF_ID%TYPE := OR_BOCONSTANTS.CNUITEMS_CLASS_TO_ACTIVITY;
    CURSOR cuOR_ORDER IS SELECT * FROM OR_ORDER;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe y Efigas
        Autor : OPEN
        Descr : Paquete manejo datos Generado con pkg_GeneraPaqueteN1
        Tabla : OR_ORDER
        Fecha : 09/12/2024 09:22:01
    ***************************************************************************/
    CURSOR cuRegistroRId
    (
        inuORDER_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM OR_ORDER tb
        WHERE
        ORDER_ID = inuORDER_ID;
     
    CURSOR cuRegistroRIdLock
    (
        inuORDER_ID    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM OR_ORDER tb
        WHERE
        ORDER_ID = inuORDER_ID
        FOR UPDATE NOWAIT;
		
    SUBTYPE STYOR_ORDER  IS  cuRegistroRId%ROWTYPE;
     
    -- Obtiene el registro y el rowid
    FUNCTION frcObtRegistroRId(
        inuORDER_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE;
 
    -- Retorna verdadero si existe el registro
    FUNCTION fblExiste(
        inuORDER_ID    NUMBER
    ) RETURN BOOLEAN;
 
    -- Levanta excepciÃ³n si el registro NO existe
    PROCEDURE prValExiste(
        inuORDER_ID    NUMBER
    );
 
    -- Inserta un registro
    PROCEDURE prinsRegistro( ircRegistro cuOR_ORDER%ROWTYPE);
 
    -- Borra un registro
    PROCEDURE prBorRegistro(
        inuORDER_ID    NUMBER
    );
 
    -- Borra un registro por RowId
    PROCEDURE prBorRegistroxRowId(
        iRowId ROWID
    );
 
    -- Obtiene el valor de la columna PRIOR_ORDER_ID
    FUNCTION fnuObtPRIOR_ORDER_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.PRIOR_ORDER_ID%TYPE;
 
    -- Obtiene el valor de la columna NUMERATOR_ID
    FUNCTION fnuObtNUMERATOR_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.NUMERATOR_ID%TYPE;
 
    -- Obtiene el valor de la columna SEQUENCE
    FUNCTION fnuObtSEQUENCE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.SEQUENCE%TYPE;
 
    -- Obtiene el valor de la columna PRIORITY
    FUNCTION fnuObtPRIORITY(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.PRIORITY%TYPE;
 

 
    -- Obtiene el valor de la columna EXEC_ESTIMATE_DATE
    FUNCTION fdtObtEXEC_ESTIMATE_DATE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.EXEC_ESTIMATE_DATE%TYPE;
 
    -- Obtiene el valor de la columna ARRANGED_HOUR
    FUNCTION fdtObtARRANGED_HOUR(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ARRANGED_HOUR%TYPE;
 
 
    -- Obtiene el valor de la columna REPROGRAM_LAST_DATE
    FUNCTION fdtObtREPROGRAM_LAST_DATE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.REPROGRAM_LAST_DATE%TYPE;
 
 
    -- Obtiene el valor de la columna ASSIGNED_WITH
    FUNCTION fsbObtASSIGNED_WITH(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ASSIGNED_WITH%TYPE;
 
    -- Obtiene el valor de la columna MAX_DATE_TO_LEGALIZE
    FUNCTION fdtObtMAX_DATE_TO_LEGALIZE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.MAX_DATE_TO_LEGALIZE%TYPE;
 
    -- Obtiene el valor de la columna ORDER_VALUE
    FUNCTION fnuObtORDER_VALUE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ORDER_VALUE%TYPE;
 
    -- Obtiene el valor de la columna PRINTING_TIME_NUMBER
    FUNCTION fnuObtPRINTING_TIME_NUMBER(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.PRINTING_TIME_NUMBER%TYPE;
 
    -- Obtiene el valor de la columna LEGALIZE_TRY_TIMES
    FUNCTION fnuObtLEGALIZE_TRY_TIMES(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.LEGALIZE_TRY_TIMES%TYPE;
 
 
    -- Obtiene el valor de la columna ADMINIST_DISTRIB_ID
    FUNCTION fnuObtADMINIST_DISTRIB_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ADMINIST_DISTRIB_ID%TYPE;
 
    -- Obtiene el valor de la columna ORDER_CLASSIF_ID
    FUNCTION fnuObtORDER_CLASSIF_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ORDER_CLASSIF_ID%TYPE;
 
 
    -- Obtiene el valor de la columna IS_COUNTERMAND
    FUNCTION fsbObtIS_COUNTERMAND(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.IS_COUNTERMAND%TYPE;
 
    -- Obtiene el valor de la columna REAL_TASK_TYPE_ID
    FUNCTION fnuObtREAL_TASK_TYPE_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.REAL_TASK_TYPE_ID%TYPE;
 
    -- Obtiene el valor de la columna SAVED_DATA_VALUES
    FUNCTION fsbObtSAVED_DATA_VALUES(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.SAVED_DATA_VALUES%TYPE;
 
    -- Obtiene el valor de la columna FOR_AUTOMATIC_LEGA
    FUNCTION fsbObtFOR_AUTOMATIC_LEGA(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.FOR_AUTOMATIC_LEGA%TYPE;
 
    -- Obtiene el valor de la columna ORDER_COST_AVERAGE
    FUNCTION fnuObtORDER_COST_AVERAGE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ORDER_COST_AVERAGE%TYPE;
 
    -- Obtiene el valor de la columna ORDER_COST_BY_LIST
    FUNCTION fnuObtORDER_COST_BY_LIST(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ORDER_COST_BY_LIST%TYPE;
 
    -- Obtiene el valor de la columna OPERATIVE_AIU_VALUE
    FUNCTION fnuObtOPERATIVE_AIU_VALUE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.OPERATIVE_AIU_VALUE%TYPE;
 
    -- Obtiene el valor de la columna ADMIN_AIU_VALUE
    FUNCTION fnuObtADMIN_AIU_VALUE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ADMIN_AIU_VALUE%TYPE;
 
    -- Obtiene el valor de la columna CHARGE_STATUS
    FUNCTION fsbObtCHARGE_STATUS(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.CHARGE_STATUS%TYPE;
 
    -- Obtiene el valor de la columna PREV_ORDER_STATUS_ID
    FUNCTION fnuObtPREV_ORDER_STATUS_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.PREV_ORDER_STATUS_ID%TYPE;
 
    -- Obtiene el valor de la columna PROGRAMING_CLASS_ID
    FUNCTION fnuObtPROGRAMING_CLASS_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.PROGRAMING_CLASS_ID%TYPE;
 
    -- Obtiene el valor de la columna PREVIOUS_WORK
    FUNCTION fsbObtPREVIOUS_WORK(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.PREVIOUS_WORK%TYPE;
 
    -- Obtiene el valor de la columna APPOINTMENT_CONFIRM
    FUNCTION fsbObtAPPOINTMENT_CONFIRM(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.APPOINTMENT_CONFIRM%TYPE;
 
    -- Obtiene el valor de la columna X
    FUNCTION fnuObtX(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.X%TYPE;
 
    -- Obtiene el valor de la columna Y
    FUNCTION fnuObtY(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.Y%TYPE;
 
    -- Obtiene el valor de la columna STAGE_ID
    FUNCTION fnuObtSTAGE_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.STAGE_ID%TYPE;
 
    -- Obtiene el valor de la columna LEGAL_IN_PROJECT
    FUNCTION fsbObtLEGAL_IN_PROJECT(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.LEGAL_IN_PROJECT%TYPE;
 
    -- Obtiene el valor de la columna OFFERED
    FUNCTION fsbObtOFFERED(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.OFFERED%TYPE;
 
    -- Obtiene el valor de la columna ASSO_UNIT_ID
    FUNCTION fnuObtASSO_UNIT_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ASSO_UNIT_ID%TYPE;
 
    -- Obtiene el valor de la columna SUBSCRIBER_ID
    FUNCTION fnuObtSUBSCRIBER_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.SUBSCRIBER_ID%TYPE;
 
    -- Obtiene el valor de la columna ADM_PENDING
    FUNCTION fsbObtADM_PENDING(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ADM_PENDING%TYPE;
 
    -- Obtiene el valor de la columna SHAPE
    FUNCTION fxxObtSHAPE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.SHAPE%TYPE;
 
    -- Obtiene el valor de la columna ROUTE_ID
    FUNCTION fnuObtROUTE_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ROUTE_ID%TYPE;
 
    -- Obtiene el valor de la columna CONSECUTIVE
    FUNCTION fnuObtCONSECUTIVE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.CONSECUTIVE%TYPE;
 
 
    -- Obtiene el valor de la columna SCHED_ITINERARY_ID
    FUNCTION fnuObtSCHED_ITINERARY_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.SCHED_ITINERARY_ID%TYPE;
 
    -- Obtiene el valor de la columna ESTIMATED_COST
    FUNCTION fnuObtESTIMATED_COST(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ESTIMATED_COST%TYPE;
 
    -- Actualiza el valor de la columna PRIOR_ORDER_ID
    PROCEDURE prAcPRIOR_ORDER_ID(
        inuORDER_ID    NUMBER,
        inuPRIOR_ORDER_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna NUMERATOR_ID
    PROCEDURE prAcNUMERATOR_ID(
        inuORDER_ID    NUMBER,
        inuNUMERATOR_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna SEQUENCE
    PROCEDURE prAcSEQUENCE(
        inuORDER_ID    NUMBER,
        inuSEQUENCE    NUMBER
    );
 
    -- Actualiza el valor de la columna PRIORITY
    PROCEDURE prAcPRIORITY(
        inuORDER_ID    NUMBER,
        inuPRIORITY    NUMBER
    );
 
 
    -- Actualiza el valor de la columna CREATED_DATE
    PROCEDURE prAcCREATED_DATE(
        inuORDER_ID    NUMBER,
        idtCREATED_DATE    DATE
    );
 
    -- Actualiza el valor de la columna EXEC_INITIAL_DATE
    PROCEDURE prAcEXEC_INITIAL_DATE(
        inuORDER_ID    NUMBER,
        idtEXEC_INITIAL_DATE    DATE
    );
 
    -- Actualiza el valor de la columna EXECUTION_FINAL_DATE
    PROCEDURE prAcEXECUTION_FINAL_DATE(
        inuORDER_ID    NUMBER,
        idtEXECUTION_FINAL_DATE    DATE
    );
 
    -- Actualiza el valor de la columna EXEC_ESTIMATE_DATE
    PROCEDURE prAcEXEC_ESTIMATE_DATE(
        inuORDER_ID    NUMBER,
        idtEXEC_ESTIMATE_DATE    DATE
    );
 
    -- Actualiza el valor de la columna ARRANGED_HOUR
    PROCEDURE prAcARRANGED_HOUR(
        inuORDER_ID    NUMBER,
        idtARRANGED_HOUR    DATE
    );
 
    -- Actualiza el valor de la columna LEGALIZATION_DATE
    PROCEDURE prAcLEGALIZATION_DATE(
        inuORDER_ID    NUMBER,
        idtLEGALIZATION_DATE    DATE
    );
 
    -- Actualiza el valor de la columna REPROGRAM_LAST_DATE
    PROCEDURE prAcREPROGRAM_LAST_DATE(
        inuORDER_ID    NUMBER,
        idtREPROGRAM_LAST_DATE    DATE
    );
 
    -- Actualiza el valor de la columna ASSIGNED_DATE
    PROCEDURE prAcASSIGNED_DATE(
        inuORDER_ID    NUMBER,
        idtASSIGNED_DATE    DATE
    );
 
    -- Actualiza el valor de la columna ASSIGNED_WITH
    PROCEDURE prAcASSIGNED_WITH(
        inuORDER_ID    NUMBER,
        isbASSIGNED_WITH    VARCHAR2
    );
 
    -- Actualiza el valor de la columna MAX_DATE_TO_LEGALIZE
    PROCEDURE prAcMAX_DATE_TO_LEGALIZE(
        inuORDER_ID    NUMBER,
        idtMAX_DATE_TO_LEGALIZE    DATE
    );
 
    -- Actualiza el valor de la columna ORDER_VALUE
    PROCEDURE prAcORDER_VALUE(
        inuORDER_ID    NUMBER,
        inuORDER_VALUE    NUMBER
    );
 
    -- Actualiza el valor de la columna PRINTING_TIME_NUMBER
    PROCEDURE prAcPRINTING_TIME_NUMBER(
        inuORDER_ID    NUMBER,
        inuPRINTING_TIME_NUMBER    NUMBER
    );
 
    -- Actualiza el valor de la columna LEGALIZE_TRY_TIMES
    PROCEDURE prAcLEGALIZE_TRY_TIMES(
        inuORDER_ID    NUMBER,
        inuLEGALIZE_TRY_TIMES    NUMBER
    );
 

    -- Actualiza el valor de la columna ORDER_STATUS_ID
    PROCEDURE prAcORDER_STATUS_ID(
        inuORDER_ID    NUMBER,
        inuORDER_STATUS_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna TASK_TYPE_ID
    PROCEDURE prAcTASK_TYPE_ID(
        inuORDER_ID    NUMBER,
        inuTASK_TYPE_ID    NUMBER
    );
 
 
    -- Actualiza el valor de la columna ADMINIST_DISTRIB_ID
    PROCEDURE prAcADMINIST_DISTRIB_ID(
        inuORDER_ID    NUMBER,
        inuADMINIST_DISTRIB_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna ORDER_CLASSIF_ID
    PROCEDURE prAcORDER_CLASSIF_ID(
        inuORDER_ID    NUMBER,
        inuORDER_CLASSIF_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna GEOGRAP_LOCATION_ID
    PROCEDURE prAcGEOGRAP_LOCATION_ID(
        inuORDER_ID    NUMBER,
        inuGEOGRAP_LOCATION_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna IS_COUNTERMAND
    PROCEDURE prAcIS_COUNTERMAND(
        inuORDER_ID    NUMBER,
        isbIS_COUNTERMAND    VARCHAR2
    );
 
    -- Actualiza el valor de la columna REAL_TASK_TYPE_ID
    PROCEDURE prAcREAL_TASK_TYPE_ID(
        inuORDER_ID    NUMBER,
        inuREAL_TASK_TYPE_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna SAVED_DATA_VALUES
    PROCEDURE prAcSAVED_DATA_VALUES(
        inuORDER_ID    NUMBER,
        isbSAVED_DATA_VALUES    VARCHAR2
    );
 
    -- Actualiza el valor de la columna FOR_AUTOMATIC_LEGA
    PROCEDURE prAcFOR_AUTOMATIC_LEGA(
        inuORDER_ID    NUMBER,
        isbFOR_AUTOMATIC_LEGA    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ORDER_COST_AVERAGE
    PROCEDURE prAcORDER_COST_AVERAGE(
        inuORDER_ID    NUMBER,
        inuORDER_COST_AVERAGE    NUMBER
    );
 
    -- Actualiza el valor de la columna ORDER_COST_BY_LIST
    PROCEDURE prAcORDER_COST_BY_LIST(
        inuORDER_ID    NUMBER,
        inuORDER_COST_BY_LIST    NUMBER
    );
 
    -- Actualiza el valor de la columna OPERATIVE_AIU_VALUE
    PROCEDURE prAcOPERATIVE_AIU_VALUE(
        inuORDER_ID    NUMBER,
        inuOPERATIVE_AIU_VALUE    NUMBER
    );
 
    -- Actualiza el valor de la columna ADMIN_AIU_VALUE
    PROCEDURE prAcADMIN_AIU_VALUE(
        inuORDER_ID    NUMBER,
        inuADMIN_AIU_VALUE    NUMBER
    );
 
    -- Actualiza el valor de la columna CHARGE_STATUS
    PROCEDURE prAcCHARGE_STATUS(
        inuORDER_ID    NUMBER,
        isbCHARGE_STATUS    VARCHAR2
    );
 
    -- Actualiza el valor de la columna PREV_ORDER_STATUS_ID
    PROCEDURE prAcPREV_ORDER_STATUS_ID(
        inuORDER_ID    NUMBER,
        inuPREV_ORDER_STATUS_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna PROGRAMING_CLASS_ID
    PROCEDURE prAcPROGRAMING_CLASS_ID(
        inuORDER_ID    NUMBER,
        inuPROGRAMING_CLASS_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna PREVIOUS_WORK
    PROCEDURE prAcPREVIOUS_WORK(
        inuORDER_ID    NUMBER,
        isbPREVIOUS_WORK    VARCHAR2
    );
 
    -- Actualiza el valor de la columna APPOINTMENT_CONFIRM
    PROCEDURE prAcAPPOINTMENT_CONFIRM(
        inuORDER_ID    NUMBER,
        isbAPPOINTMENT_CONFIRM    VARCHAR2
    );
 
    -- Actualiza el valor de la columna X
    PROCEDURE prAcX(
        inuORDER_ID    NUMBER,
        inuX    NUMBER
    );
 
    -- Actualiza el valor de la columna Y
    PROCEDURE prAcY(
        inuORDER_ID    NUMBER,
        inuY    NUMBER
    );
 
    -- Actualiza el valor de la columna STAGE_ID
    PROCEDURE prAcSTAGE_ID(
        inuORDER_ID    NUMBER,
        inuSTAGE_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna LEGAL_IN_PROJECT
    PROCEDURE prAcLEGAL_IN_PROJECT(
        inuORDER_ID    NUMBER,
        isbLEGAL_IN_PROJECT    VARCHAR2
    );
 
    -- Actualiza el valor de la columna OFFERED
    PROCEDURE prAcOFFERED(
        inuORDER_ID    NUMBER,
        isbOFFERED    VARCHAR2
    );
 
    -- Actualiza el valor de la columna ASSO_UNIT_ID
    PROCEDURE prAcASSO_UNIT_ID(
        inuORDER_ID    NUMBER,
        inuASSO_UNIT_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna SUBSCRIBER_ID
    PROCEDURE prAcSUBSCRIBER_ID(
        inuORDER_ID    NUMBER,
        inuSUBSCRIBER_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna ADM_PENDING
    PROCEDURE prAcADM_PENDING(
        inuORDER_ID    NUMBER,
        isbADM_PENDING    VARCHAR2
    );
 
    -- Actualiza el valor de la columna SHAPE
    PROCEDURE prAcSHAPE(
        inuORDER_ID    NUMBER,
        ixxSHAPE    SDO_GEOMETRY
    );
 
    -- Actualiza el valor de la columna ROUTE_ID
    PROCEDURE prAcROUTE_ID(
        inuORDER_ID    NUMBER,
        inuROUTE_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna CONSECUTIVE
    PROCEDURE prAcCONSECUTIVE(
        inuORDER_ID    NUMBER,
        inuCONSECUTIVE    NUMBER
    );
 
    -- Actualiza el valor de la columna DEFINED_CONTRACT_ID
    PROCEDURE prAcDEFINED_CONTRACT_ID(
        inuORDER_ID    NUMBER,
        inuDEFINED_CONTRACT_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna IS_PENDING_LIQ
    PROCEDURE prAcIS_PENDING_LIQ(
        inuORDER_ID    NUMBER,
        isbIS_PENDING_LIQ    VARCHAR2
    );
 
    -- Actualiza el valor de la columna SCHED_ITINERARY_ID
    PROCEDURE prAcSCHED_ITINERARY_ID(
        inuORDER_ID    NUMBER,
        inuSCHED_ITINERARY_ID    NUMBER
    );
 
    -- Actualiza el valor de la columna ESTIMATED_COST
    PROCEDURE prAcESTIMATED_COST(
        inuORDER_ID    NUMBER,
        inuESTIMATED_COST    NUMBER
    );
 
    -- Actualiza las columnas del registro cuyo valor sera diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuOR_ORDER%ROWTYPE);
	
-- YA ESTAN HOMOLOGADOS
	    -- Actualiza el valor de la columna OPERATING_UNIT_ID
    PROCEDURE prAcOPERATING_UNIT_ID(
        inuORDER_ID    NUMBER,
        inuOPERATING_UNIT_ID    NUMBER
    );



    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa        : prc_ActualizaCausalOrden
    Descripcion     : Actualizar la causal de una orden
    *******************************************************************************/    
    PROCEDURE prc_ActualizaCausalOrden
    (
        inuOrden    IN  or_order.order_id%type,
        inuCausal 	IN  or_order.causal_id%type,
        onuError    OUT NUMBER,
        osbError    OUT VARCHAR2
    );

    PROCEDURE prcActualizaDireccionOrden
    (
        inuOrden    	IN  or_order.order_id%type,
        isbDireccion 	IN  or_order.external_address_id%type,
        onuError    	OUT NUMBER,
        osbError    	OUT VARCHAR2
    );
    
    --procedimiento que se encarga de actualizar sector operativo de la orden
    PROCEDURE prcActualizaSectorOperativo(inuOrden           IN or_order.order_id%type,
                                          inuSectorOperativo IN or_order.operating_sector_id%type,
                                          onuError           OUT NUMBER,
                                          osbError           OUT VARCHAR2
                                          );

    --procedimiento que se encarga de actualizar estado de la orden
    PROCEDURE prcActualizaEstado(inuOrden  IN or_order.order_id%type,
                                 inuEstado IN or_order.order_status_id%type,
                                 onuError  OUT NUMBER,
                                 osbError  OUT VARCHAR2
                                 );

    --pprocedimiento que se encarga de actualizar estado anterior de la orden
    PROCEDURE prcActualizaEstadoAnterior(inuOrden  IN or_order.order_id%type,
                                         inuEstado IN or_order.prev_order_status_id%type,
                                         onuError  OUT NUMBER,
                                         osbError  OUT VARCHAR2
                                         );

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa        : prcActualizaRecord
    Descripcion     : Actualizar la orden con un record
    ***************************************************************************/
    PROCEDURE prcActualizaRecord(ircOrOrder IN  styOR_order);

    -- Actualiza una orden de novedad    
    PROCEDURE prActOrdenNovedad( inuOrder NUMBER, ircOrden or_order%ROWTYPE);
    
    -- Obtiene el valor de la columna DEFINED_CONTRACT_ID
    FUNCTION fnuObtDEFINED_CONTRACT_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.DEFINED_CONTRACT_ID%TYPE;
        
END pkg_or_order;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_or_order IS
	
    -- Constantes para el control de la traza
    csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
	
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    -- Identificador del ultimo caso que hizo cambios
    csbVersion     CONSTANT VARCHAR2(15) := 'OSF-4042';

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor       	: Carlos Gonzalez - Horbath
    Fecha       	: 03-01-2024

    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   03-01-2024  OSF-2155 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion 
    RETURN VARCHAR2 
    IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;


    -- Obtiene registro y RowId
    FUNCTION frcObtRegistroRId(
        inuORDER_ID    NUMBER, iblBloquea BOOLEAN DEFAULT FALSE
    ) RETURN cuRegistroRId%ROWTYPE IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuORDER_ID);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuORDER_ID);
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
        inuORDER_ID    NUMBER
    ) RETURN BOOLEAN IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.ORDER_ID IS NOT NULL;
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
        inuORDER_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuORDER_ID) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuORDER_ID||'] en la tabla[OR_ORDER]');
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
    PROCEDURE prInsRegistro( ircRegistro cuOR_ORDER%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO OR_ORDER(
            ORDER_ID,PRIOR_ORDER_ID,NUMERATOR_ID,SEQUENCE,PRIORITY,EXTERNAL_ADDRESS_ID,CREATED_DATE,EXEC_INITIAL_DATE,EXECUTION_FINAL_DATE,EXEC_ESTIMATE_DATE,ARRANGED_HOUR,LEGALIZATION_DATE,REPROGRAM_LAST_DATE,ASSIGNED_DATE,ASSIGNED_WITH,MAX_DATE_TO_LEGALIZE,ORDER_VALUE,PRINTING_TIME_NUMBER,LEGALIZE_TRY_TIMES,OPERATING_UNIT_ID,ORDER_STATUS_ID,TASK_TYPE_ID,OPERATING_SECTOR_ID,CAUSAL_ID,ADMINIST_DISTRIB_ID,ORDER_CLASSIF_ID,GEOGRAP_LOCATION_ID,IS_COUNTERMAND,REAL_TASK_TYPE_ID,SAVED_DATA_VALUES,FOR_AUTOMATIC_LEGA,ORDER_COST_AVERAGE,ORDER_COST_BY_LIST,OPERATIVE_AIU_VALUE,ADMIN_AIU_VALUE,CHARGE_STATUS,PREV_ORDER_STATUS_ID,PROGRAMING_CLASS_ID,PREVIOUS_WORK,APPOINTMENT_CONFIRM,X,Y,STAGE_ID,LEGAL_IN_PROJECT,OFFERED,ASSO_UNIT_ID,SUBSCRIBER_ID,ADM_PENDING,SHAPE,ROUTE_ID,CONSECUTIVE,DEFINED_CONTRACT_ID,IS_PENDING_LIQ,SCHED_ITINERARY_ID,ESTIMATED_COST
        )
        VALUES (
            ircRegistro.ORDER_ID,ircRegistro.PRIOR_ORDER_ID,ircRegistro.NUMERATOR_ID,ircRegistro.SEQUENCE,ircRegistro.PRIORITY,ircRegistro.EXTERNAL_ADDRESS_ID,ircRegistro.CREATED_DATE,ircRegistro.EXEC_INITIAL_DATE,ircRegistro.EXECUTION_FINAL_DATE,ircRegistro.EXEC_ESTIMATE_DATE,ircRegistro.ARRANGED_HOUR,ircRegistro.LEGALIZATION_DATE,ircRegistro.REPROGRAM_LAST_DATE,ircRegistro.ASSIGNED_DATE,ircRegistro.ASSIGNED_WITH,ircRegistro.MAX_DATE_TO_LEGALIZE,ircRegistro.ORDER_VALUE,ircRegistro.PRINTING_TIME_NUMBER,ircRegistro.LEGALIZE_TRY_TIMES,ircRegistro.OPERATING_UNIT_ID,ircRegistro.ORDER_STATUS_ID,ircRegistro.TASK_TYPE_ID,ircRegistro.OPERATING_SECTOR_ID,ircRegistro.CAUSAL_ID,ircRegistro.ADMINIST_DISTRIB_ID,ircRegistro.ORDER_CLASSIF_ID,ircRegistro.GEOGRAP_LOCATION_ID,ircRegistro.IS_COUNTERMAND,ircRegistro.REAL_TASK_TYPE_ID,ircRegistro.SAVED_DATA_VALUES,ircRegistro.FOR_AUTOMATIC_LEGA,ircRegistro.ORDER_COST_AVERAGE,ircRegistro.ORDER_COST_BY_LIST,ircRegistro.OPERATIVE_AIU_VALUE,ircRegistro.ADMIN_AIU_VALUE,ircRegistro.CHARGE_STATUS,ircRegistro.PREV_ORDER_STATUS_ID,ircRegistro.PROGRAMING_CLASS_ID,ircRegistro.PREVIOUS_WORK,ircRegistro.APPOINTMENT_CONFIRM,ircRegistro.X,ircRegistro.Y,ircRegistro.STAGE_ID,ircRegistro.LEGAL_IN_PROJECT,ircRegistro.OFFERED,ircRegistro.ASSO_UNIT_ID,ircRegistro.SUBSCRIBER_ID,ircRegistro.ADM_PENDING,ircRegistro.SHAPE,ircRegistro.ROUTE_ID,ircRegistro.CONSECUTIVE,ircRegistro.DEFINED_CONTRACT_ID,ircRegistro.IS_PENDING_LIQ,ircRegistro.SCHED_ITINERARY_ID,ircRegistro.ESTIMATED_COST
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
        inuORDER_ID    NUMBER
    ) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE OR_ORDER
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
            DELETE OR_ORDER
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
 
    -- Obtiene el valor de la columna PRIOR_ORDER_ID
    FUNCTION fnuObtPRIOR_ORDER_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.PRIOR_ORDER_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPRIOR_ORDER_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PRIOR_ORDER_ID;
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
    END fnuObtPRIOR_ORDER_ID;
 
    -- Obtiene el valor de la columna NUMERATOR_ID
    FUNCTION fnuObtNUMERATOR_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.NUMERATOR_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtNUMERATOR_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.NUMERATOR_ID;
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
    END fnuObtNUMERATOR_ID;
 
    -- Obtiene el valor de la columna SEQUENCE
    FUNCTION fnuObtSEQUENCE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.SEQUENCE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtSEQUENCE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SEQUENCE;
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
    END fnuObtSEQUENCE;
 
    -- Obtiene el valor de la columna PRIORITY
    FUNCTION fnuObtPRIORITY(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.PRIORITY%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPRIORITY';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PRIORITY;
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
    END fnuObtPRIORITY;
 
 
 
    -- Obtiene el valor de la columna EXEC_ESTIMATE_DATE
    FUNCTION fdtObtEXEC_ESTIMATE_DATE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.EXEC_ESTIMATE_DATE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtEXEC_ESTIMATE_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.EXEC_ESTIMATE_DATE;
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
    END fdtObtEXEC_ESTIMATE_DATE;
 
    -- Obtiene el valor de la columna ARRANGED_HOUR
    FUNCTION fdtObtARRANGED_HOUR(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ARRANGED_HOUR%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtARRANGED_HOUR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ARRANGED_HOUR;
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
    END fdtObtARRANGED_HOUR;
 
    -- Obtiene el valor de la columna REPROGRAM_LAST_DATE
    FUNCTION fdtObtREPROGRAM_LAST_DATE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.REPROGRAM_LAST_DATE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtREPROGRAM_LAST_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.REPROGRAM_LAST_DATE;
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
    END fdtObtREPROGRAM_LAST_DATE;
 
    -- Obtiene el valor de la columna ASSIGNED_WITH
    FUNCTION fsbObtASSIGNED_WITH(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ASSIGNED_WITH%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtASSIGNED_WITH';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ASSIGNED_WITH;
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
    END fsbObtASSIGNED_WITH;
 
    -- Obtiene el valor de la columna MAX_DATE_TO_LEGALIZE
    FUNCTION fdtObtMAX_DATE_TO_LEGALIZE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.MAX_DATE_TO_LEGALIZE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtMAX_DATE_TO_LEGALIZE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.MAX_DATE_TO_LEGALIZE;
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
    END fdtObtMAX_DATE_TO_LEGALIZE;
 
    -- Obtiene el valor de la columna ORDER_VALUE
    FUNCTION fnuObtORDER_VALUE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ORDER_VALUE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtORDER_VALUE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ORDER_VALUE;
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
    END fnuObtORDER_VALUE;
 
    -- Obtiene el valor de la columna PRINTING_TIME_NUMBER
    FUNCTION fnuObtPRINTING_TIME_NUMBER(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.PRINTING_TIME_NUMBER%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPRINTING_TIME_NUMBER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PRINTING_TIME_NUMBER;
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
    END fnuObtPRINTING_TIME_NUMBER;
 
    -- Obtiene el valor de la columna LEGALIZE_TRY_TIMES
    FUNCTION fnuObtLEGALIZE_TRY_TIMES(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.LEGALIZE_TRY_TIMES%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtLEGALIZE_TRY_TIMES';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.LEGALIZE_TRY_TIMES;
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
    END fnuObtLEGALIZE_TRY_TIMES;
 
 
 
 
    -- Obtiene el valor de la columna ADMINIST_DISTRIB_ID
    FUNCTION fnuObtADMINIST_DISTRIB_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ADMINIST_DISTRIB_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtADMINIST_DISTRIB_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ADMINIST_DISTRIB_ID;
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
    END fnuObtADMINIST_DISTRIB_ID;
 
    -- Obtiene el valor de la columna ORDER_CLASSIF_ID
    FUNCTION fnuObtORDER_CLASSIF_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ORDER_CLASSIF_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtORDER_CLASSIF_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ORDER_CLASSIF_ID;
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
    END fnuObtORDER_CLASSIF_ID;
 
    -- Obtiene el valor de la columna IS_COUNTERMAND
    FUNCTION fsbObtIS_COUNTERMAND(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.IS_COUNTERMAND%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtIS_COUNTERMAND';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.IS_COUNTERMAND;
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
    END fsbObtIS_COUNTERMAND;
 
    -- Obtiene el valor de la columna REAL_TASK_TYPE_ID
    FUNCTION fnuObtREAL_TASK_TYPE_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.REAL_TASK_TYPE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtREAL_TASK_TYPE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.REAL_TASK_TYPE_ID;
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
    END fnuObtREAL_TASK_TYPE_ID;
 
    -- Obtiene el valor de la columna SAVED_DATA_VALUES
    FUNCTION fsbObtSAVED_DATA_VALUES(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.SAVED_DATA_VALUES%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtSAVED_DATA_VALUES';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SAVED_DATA_VALUES;
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
    END fsbObtSAVED_DATA_VALUES;
 
    -- Obtiene el valor de la columna FOR_AUTOMATIC_LEGA
    FUNCTION fsbObtFOR_AUTOMATIC_LEGA(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.FOR_AUTOMATIC_LEGA%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtFOR_AUTOMATIC_LEGA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
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
 
    -- Obtiene el valor de la columna ORDER_COST_AVERAGE
    FUNCTION fnuObtORDER_COST_AVERAGE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ORDER_COST_AVERAGE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtORDER_COST_AVERAGE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ORDER_COST_AVERAGE;
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
    END fnuObtORDER_COST_AVERAGE;
 
    -- Obtiene el valor de la columna ORDER_COST_BY_LIST
    FUNCTION fnuObtORDER_COST_BY_LIST(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ORDER_COST_BY_LIST%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtORDER_COST_BY_LIST';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ORDER_COST_BY_LIST;
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
    END fnuObtORDER_COST_BY_LIST;
 
    -- Obtiene el valor de la columna OPERATIVE_AIU_VALUE
    FUNCTION fnuObtOPERATIVE_AIU_VALUE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.OPERATIVE_AIU_VALUE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtOPERATIVE_AIU_VALUE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.OPERATIVE_AIU_VALUE;
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
    END fnuObtOPERATIVE_AIU_VALUE;
 
    -- Obtiene el valor de la columna ADMIN_AIU_VALUE
    FUNCTION fnuObtADMIN_AIU_VALUE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ADMIN_AIU_VALUE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtADMIN_AIU_VALUE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ADMIN_AIU_VALUE;
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
    END fnuObtADMIN_AIU_VALUE;
 
    -- Obtiene el valor de la columna CHARGE_STATUS
    FUNCTION fsbObtCHARGE_STATUS(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.CHARGE_STATUS%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtCHARGE_STATUS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CHARGE_STATUS;
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
    END fsbObtCHARGE_STATUS;
 
    -- Obtiene el valor de la columna PREV_ORDER_STATUS_ID
    FUNCTION fnuObtPREV_ORDER_STATUS_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.PREV_ORDER_STATUS_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPREV_ORDER_STATUS_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PREV_ORDER_STATUS_ID;
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
    END fnuObtPREV_ORDER_STATUS_ID;
 
    -- Obtiene el valor de la columna PROGRAMING_CLASS_ID
    FUNCTION fnuObtPROGRAMING_CLASS_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.PROGRAMING_CLASS_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPROGRAMING_CLASS_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PROGRAMING_CLASS_ID;
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
    END fnuObtPROGRAMING_CLASS_ID;
 
    -- Obtiene el valor de la columna PREVIOUS_WORK
    FUNCTION fsbObtPREVIOUS_WORK(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.PREVIOUS_WORK%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtPREVIOUS_WORK';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PREVIOUS_WORK;
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
    END fsbObtPREVIOUS_WORK;
 
    -- Obtiene el valor de la columna APPOINTMENT_CONFIRM
    FUNCTION fsbObtAPPOINTMENT_CONFIRM(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.APPOINTMENT_CONFIRM%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtAPPOINTMENT_CONFIRM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.APPOINTMENT_CONFIRM;
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
    END fsbObtAPPOINTMENT_CONFIRM;
 
    -- Obtiene el valor de la columna X
    FUNCTION fnuObtX(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.X%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtX';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.X;
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
    END fnuObtX;
 
    -- Obtiene el valor de la columna Y
    FUNCTION fnuObtY(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.Y%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtY';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.Y;
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
    END fnuObtY;
 
    -- Obtiene el valor de la columna STAGE_ID
    FUNCTION fnuObtSTAGE_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.STAGE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtSTAGE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.STAGE_ID;
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
    END fnuObtSTAGE_ID;
 
    -- Obtiene el valor de la columna LEGAL_IN_PROJECT
    FUNCTION fsbObtLEGAL_IN_PROJECT(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.LEGAL_IN_PROJECT%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtLEGAL_IN_PROJECT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.LEGAL_IN_PROJECT;
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
    END fsbObtLEGAL_IN_PROJECT;
 
    -- Obtiene el valor de la columna OFFERED
    FUNCTION fsbObtOFFERED(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.OFFERED%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtOFFERED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.OFFERED;
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
    END fsbObtOFFERED;
 
    -- Obtiene el valor de la columna ASSO_UNIT_ID
    FUNCTION fnuObtASSO_UNIT_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ASSO_UNIT_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtASSO_UNIT_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ASSO_UNIT_ID;
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
    END fnuObtASSO_UNIT_ID;
 
    -- Obtiene el valor de la columna SUBSCRIBER_ID
    FUNCTION fnuObtSUBSCRIBER_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.SUBSCRIBER_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtSUBSCRIBER_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
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
 
    -- Obtiene el valor de la columna ADM_PENDING
    FUNCTION fsbObtADM_PENDING(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ADM_PENDING%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtADM_PENDING';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ADM_PENDING;
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
    END fsbObtADM_PENDING;
 
    -- Obtiene el valor de la columna SHAPE
    FUNCTION fxxObtSHAPE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.SHAPE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fxxObtSHAPE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SHAPE;
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
    END fxxObtSHAPE;
 
    -- Obtiene el valor de la columna ROUTE_ID
    FUNCTION fnuObtROUTE_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ROUTE_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtROUTE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ROUTE_ID;
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
    END fnuObtROUTE_ID;
 
    -- Obtiene el valor de la columna CONSECUTIVE
    FUNCTION fnuObtCONSECUTIVE(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.CONSECUTIVE%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtCONSECUTIVE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.CONSECUTIVE;
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
    END fnuObtCONSECUTIVE;
 
 
    -- Obtiene el valor de la columna SCHED_ITINERARY_ID
    FUNCTION fnuObtSCHED_ITINERARY_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.SCHED_ITINERARY_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtSCHED_ITINERARY_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.SCHED_ITINERARY_ID;
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
    END fnuObtSCHED_ITINERARY_ID;
 
    -- Obtiene el valor de la columna ESTIMATED_COST
    FUNCTION fnuObtESTIMATED_COST(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.ESTIMATED_COST%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtESTIMATED_COST';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ESTIMATED_COST;
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
    END fnuObtESTIMATED_COST;
 
    -- Actualiza el valor de la columna PRIOR_ORDER_ID
    PROCEDURE prAcPRIOR_ORDER_ID(
        inuORDER_ID    NUMBER,
        inuPRIOR_ORDER_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRIOR_ORDER_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuPRIOR_ORDER_ID,-1) <> NVL(rcRegistroAct.PRIOR_ORDER_ID,-1) THEN
            UPDATE OR_ORDER
            SET PRIOR_ORDER_ID=inuPRIOR_ORDER_ID
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
    END prAcPRIOR_ORDER_ID;
 
    -- Actualiza el valor de la columna NUMERATOR_ID
    PROCEDURE prAcNUMERATOR_ID(
        inuORDER_ID    NUMBER,
        inuNUMERATOR_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNUMERATOR_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuNUMERATOR_ID,-1) <> NVL(rcRegistroAct.NUMERATOR_ID,-1) THEN
            UPDATE OR_ORDER
            SET NUMERATOR_ID=inuNUMERATOR_ID
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
    END prAcNUMERATOR_ID;
 
    -- Actualiza el valor de la columna SEQUENCE
    PROCEDURE prAcSEQUENCE(
        inuORDER_ID    NUMBER,
        inuSEQUENCE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSEQUENCE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuSEQUENCE,-1) <> NVL(rcRegistroAct.SEQUENCE,-1) THEN
            UPDATE OR_ORDER
            SET SEQUENCE=inuSEQUENCE
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
    END prAcSEQUENCE;
 
    -- Actualiza el valor de la columna PRIORITY
    PROCEDURE prAcPRIORITY(
        inuORDER_ID    NUMBER,
        inuPRIORITY    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRIORITY';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuPRIORITY,-1) <> NVL(rcRegistroAct.PRIORITY,-1) THEN
            UPDATE OR_ORDER
            SET PRIORITY=inuPRIORITY
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
    END prAcPRIORITY;
 
    -- Actualiza el valor de la columna CREATED_DATE
    PROCEDURE prAcCREATED_DATE(
        inuORDER_ID    NUMBER,
        idtCREATED_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCREATED_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(idtCREATED_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.CREATED_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET CREATED_DATE=idtCREATED_DATE
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
    END prAcCREATED_DATE;
 
    -- Actualiza el valor de la columna EXEC_INITIAL_DATE
    PROCEDURE prAcEXEC_INITIAL_DATE(
        inuORDER_ID    NUMBER,
        idtEXEC_INITIAL_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEXEC_INITIAL_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(idtEXEC_INITIAL_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.EXEC_INITIAL_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET EXEC_INITIAL_DATE=idtEXEC_INITIAL_DATE
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
    END prAcEXEC_INITIAL_DATE;
 
    -- Actualiza el valor de la columna EXECUTION_FINAL_DATE
    PROCEDURE prAcEXECUTION_FINAL_DATE(
        inuORDER_ID    NUMBER,
        idtEXECUTION_FINAL_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEXECUTION_FINAL_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(idtEXECUTION_FINAL_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.EXECUTION_FINAL_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET EXECUTION_FINAL_DATE=idtEXECUTION_FINAL_DATE
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
    END prAcEXECUTION_FINAL_DATE;
 
    -- Actualiza el valor de la columna EXEC_ESTIMATE_DATE
    PROCEDURE prAcEXEC_ESTIMATE_DATE(
        inuORDER_ID    NUMBER,
        idtEXEC_ESTIMATE_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEXEC_ESTIMATE_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(idtEXEC_ESTIMATE_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.EXEC_ESTIMATE_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET EXEC_ESTIMATE_DATE=idtEXEC_ESTIMATE_DATE
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
    END prAcEXEC_ESTIMATE_DATE;
 
    -- Actualiza el valor de la columna ARRANGED_HOUR
    PROCEDURE prAcARRANGED_HOUR(
        inuORDER_ID    NUMBER,
        idtARRANGED_HOUR    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcARRANGED_HOUR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(idtARRANGED_HOUR,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.ARRANGED_HOUR,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET ARRANGED_HOUR=idtARRANGED_HOUR
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
    END prAcARRANGED_HOUR;
 
    -- Actualiza el valor de la columna LEGALIZATION_DATE
    PROCEDURE prAcLEGALIZATION_DATE(
        inuORDER_ID    NUMBER,
        idtLEGALIZATION_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLEGALIZATION_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(idtLEGALIZATION_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.LEGALIZATION_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET LEGALIZATION_DATE=idtLEGALIZATION_DATE
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
    END prAcLEGALIZATION_DATE;
 
    -- Actualiza el valor de la columna REPROGRAM_LAST_DATE
    PROCEDURE prAcREPROGRAM_LAST_DATE(
        inuORDER_ID    NUMBER,
        idtREPROGRAM_LAST_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcREPROGRAM_LAST_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(idtREPROGRAM_LAST_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.REPROGRAM_LAST_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET REPROGRAM_LAST_DATE=idtREPROGRAM_LAST_DATE
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
    END prAcREPROGRAM_LAST_DATE;
 
    -- Actualiza el valor de la columna ASSIGNED_DATE
    PROCEDURE prAcASSIGNED_DATE(
        inuORDER_ID    NUMBER,
        idtASSIGNED_DATE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcASSIGNED_DATE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(idtASSIGNED_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.ASSIGNED_DATE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET ASSIGNED_DATE=idtASSIGNED_DATE
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
    END prAcASSIGNED_DATE;
 
    -- Actualiza el valor de la columna ASSIGNED_WITH
    PROCEDURE prAcASSIGNED_WITH(
        inuORDER_ID    NUMBER,
        isbASSIGNED_WITH    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcASSIGNED_WITH';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(isbASSIGNED_WITH,'-') <> NVL(rcRegistroAct.ASSIGNED_WITH,'-') THEN
            UPDATE OR_ORDER
            SET ASSIGNED_WITH=isbASSIGNED_WITH
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
    END prAcASSIGNED_WITH;
 
    -- Actualiza el valor de la columna MAX_DATE_TO_LEGALIZE
    PROCEDURE prAcMAX_DATE_TO_LEGALIZE(
        inuORDER_ID    NUMBER,
        idtMAX_DATE_TO_LEGALIZE    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcMAX_DATE_TO_LEGALIZE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(idtMAX_DATE_TO_LEGALIZE,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.MAX_DATE_TO_LEGALIZE,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET MAX_DATE_TO_LEGALIZE=idtMAX_DATE_TO_LEGALIZE
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
    END prAcMAX_DATE_TO_LEGALIZE;
 
    -- Actualiza el valor de la columna ORDER_VALUE
    PROCEDURE prAcORDER_VALUE(
        inuORDER_ID    NUMBER,
        inuORDER_VALUE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_VALUE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuORDER_VALUE,-1) <> NVL(rcRegistroAct.ORDER_VALUE,-1) THEN
            UPDATE OR_ORDER
            SET ORDER_VALUE=inuORDER_VALUE
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
    END prAcORDER_VALUE;
 
    -- Actualiza el valor de la columna PRINTING_TIME_NUMBER
    PROCEDURE prAcPRINTING_TIME_NUMBER(
        inuORDER_ID    NUMBER,
        inuPRINTING_TIME_NUMBER    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRINTING_TIME_NUMBER';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuPRINTING_TIME_NUMBER,-1) <> NVL(rcRegistroAct.PRINTING_TIME_NUMBER,-1) THEN
            UPDATE OR_ORDER
            SET PRINTING_TIME_NUMBER=inuPRINTING_TIME_NUMBER
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
    END prAcPRINTING_TIME_NUMBER;
 
    -- Actualiza el valor de la columna LEGALIZE_TRY_TIMES
    PROCEDURE prAcLEGALIZE_TRY_TIMES(
        inuORDER_ID    NUMBER,
        inuLEGALIZE_TRY_TIMES    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLEGALIZE_TRY_TIMES';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuLEGALIZE_TRY_TIMES,-1) <> NVL(rcRegistroAct.LEGALIZE_TRY_TIMES,-1) THEN
            UPDATE OR_ORDER
            SET LEGALIZE_TRY_TIMES=inuLEGALIZE_TRY_TIMES
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
    END prAcLEGALIZE_TRY_TIMES;
 
    -- Actualiza el valor de la columna ORDER_STATUS_ID
    PROCEDURE prAcORDER_STATUS_ID(
        inuORDER_ID    NUMBER,
        inuORDER_STATUS_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_STATUS_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuORDER_STATUS_ID,-1) <> NVL(rcRegistroAct.ORDER_STATUS_ID,-1) THEN
            UPDATE OR_ORDER
            SET ORDER_STATUS_ID=inuORDER_STATUS_ID
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
    END prAcORDER_STATUS_ID;
 
    -- Actualiza el valor de la columna TASK_TYPE_ID
    PROCEDURE prAcTASK_TYPE_ID(
        inuORDER_ID    NUMBER,
        inuTASK_TYPE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTASK_TYPE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuTASK_TYPE_ID,-1) <> NVL(rcRegistroAct.TASK_TYPE_ID,-1) THEN
            UPDATE OR_ORDER
            SET TASK_TYPE_ID=inuTASK_TYPE_ID
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
    END prAcTASK_TYPE_ID;
 

    -- Actualiza el valor de la columna ADMINIST_DISTRIB_ID
    PROCEDURE prAcADMINIST_DISTRIB_ID(
        inuORDER_ID    NUMBER,
        inuADMINIST_DISTRIB_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADMINIST_DISTRIB_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuADMINIST_DISTRIB_ID,-1) <> NVL(rcRegistroAct.ADMINIST_DISTRIB_ID,-1) THEN
            UPDATE OR_ORDER
            SET ADMINIST_DISTRIB_ID=inuADMINIST_DISTRIB_ID
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
    END prAcADMINIST_DISTRIB_ID;
 
    -- Actualiza el valor de la columna ORDER_CLASSIF_ID
    PROCEDURE prAcORDER_CLASSIF_ID(
        inuORDER_ID    NUMBER,
        inuORDER_CLASSIF_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_CLASSIF_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuORDER_CLASSIF_ID,-1) <> NVL(rcRegistroAct.ORDER_CLASSIF_ID,-1) THEN
            UPDATE OR_ORDER
            SET ORDER_CLASSIF_ID=inuORDER_CLASSIF_ID
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
    END prAcORDER_CLASSIF_ID;
 
    -- Actualiza el valor de la columna GEOGRAP_LOCATION_ID
    PROCEDURE prAcGEOGRAP_LOCATION_ID(
        inuORDER_ID    NUMBER,
        inuGEOGRAP_LOCATION_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcGEOGRAP_LOCATION_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuGEOGRAP_LOCATION_ID,-1) <> NVL(rcRegistroAct.GEOGRAP_LOCATION_ID,-1) THEN
            UPDATE OR_ORDER
            SET GEOGRAP_LOCATION_ID=inuGEOGRAP_LOCATION_ID
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
    END prAcGEOGRAP_LOCATION_ID;
 
    -- Actualiza el valor de la columna IS_COUNTERMAND
    PROCEDURE prAcIS_COUNTERMAND(
        inuORDER_ID    NUMBER,
        isbIS_COUNTERMAND    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIS_COUNTERMAND';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(isbIS_COUNTERMAND,'-') <> NVL(rcRegistroAct.IS_COUNTERMAND,'-') THEN
            UPDATE OR_ORDER
            SET IS_COUNTERMAND=isbIS_COUNTERMAND
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
    END prAcIS_COUNTERMAND;
 
    -- Actualiza el valor de la columna REAL_TASK_TYPE_ID
    PROCEDURE prAcREAL_TASK_TYPE_ID(
        inuORDER_ID    NUMBER,
        inuREAL_TASK_TYPE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcREAL_TASK_TYPE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuREAL_TASK_TYPE_ID,-1) <> NVL(rcRegistroAct.REAL_TASK_TYPE_ID,-1) THEN
            UPDATE OR_ORDER
            SET REAL_TASK_TYPE_ID=inuREAL_TASK_TYPE_ID
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
    END prAcREAL_TASK_TYPE_ID;
 
    -- Actualiza el valor de la columna SAVED_DATA_VALUES
    PROCEDURE prAcSAVED_DATA_VALUES(
        inuORDER_ID    NUMBER,
        isbSAVED_DATA_VALUES    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSAVED_DATA_VALUES';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(isbSAVED_DATA_VALUES,'-') <> NVL(rcRegistroAct.SAVED_DATA_VALUES,'-') THEN
            UPDATE OR_ORDER
            SET SAVED_DATA_VALUES=isbSAVED_DATA_VALUES
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
    END prAcSAVED_DATA_VALUES;
 
    -- Actualiza el valor de la columna FOR_AUTOMATIC_LEGA
    PROCEDURE prAcFOR_AUTOMATIC_LEGA(
        inuORDER_ID    NUMBER,
        isbFOR_AUTOMATIC_LEGA    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFOR_AUTOMATIC_LEGA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(isbFOR_AUTOMATIC_LEGA,'-') <> NVL(rcRegistroAct.FOR_AUTOMATIC_LEGA,'-') THEN
            UPDATE OR_ORDER
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
 
    -- Actualiza el valor de la columna ORDER_COST_AVERAGE
    PROCEDURE prAcORDER_COST_AVERAGE(
        inuORDER_ID    NUMBER,
        inuORDER_COST_AVERAGE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_COST_AVERAGE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuORDER_COST_AVERAGE,-1) <> NVL(rcRegistroAct.ORDER_COST_AVERAGE,-1) THEN
            UPDATE OR_ORDER
            SET ORDER_COST_AVERAGE=inuORDER_COST_AVERAGE
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
    END prAcORDER_COST_AVERAGE;
 
    -- Actualiza el valor de la columna ORDER_COST_BY_LIST
    PROCEDURE prAcORDER_COST_BY_LIST(
        inuORDER_ID    NUMBER,
        inuORDER_COST_BY_LIST    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_COST_BY_LIST';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuORDER_COST_BY_LIST,-1) <> NVL(rcRegistroAct.ORDER_COST_BY_LIST,-1) THEN
            UPDATE OR_ORDER
            SET ORDER_COST_BY_LIST=inuORDER_COST_BY_LIST
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
    END prAcORDER_COST_BY_LIST;
 
    -- Actualiza el valor de la columna OPERATIVE_AIU_VALUE
    PROCEDURE prAcOPERATIVE_AIU_VALUE(
        inuORDER_ID    NUMBER,
        inuOPERATIVE_AIU_VALUE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERATIVE_AIU_VALUE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuOPERATIVE_AIU_VALUE,-1) <> NVL(rcRegistroAct.OPERATIVE_AIU_VALUE,-1) THEN
            UPDATE OR_ORDER
            SET OPERATIVE_AIU_VALUE=inuOPERATIVE_AIU_VALUE
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
    END prAcOPERATIVE_AIU_VALUE;
 
    -- Actualiza el valor de la columna ADMIN_AIU_VALUE
    PROCEDURE prAcADMIN_AIU_VALUE(
        inuORDER_ID    NUMBER,
        inuADMIN_AIU_VALUE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADMIN_AIU_VALUE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuADMIN_AIU_VALUE,-1) <> NVL(rcRegistroAct.ADMIN_AIU_VALUE,-1) THEN
            UPDATE OR_ORDER
            SET ADMIN_AIU_VALUE=inuADMIN_AIU_VALUE
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
    END prAcADMIN_AIU_VALUE;
 
    -- Actualiza el valor de la columna CHARGE_STATUS
    PROCEDURE prAcCHARGE_STATUS(
        inuORDER_ID    NUMBER,
        isbCHARGE_STATUS    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCHARGE_STATUS';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(isbCHARGE_STATUS,'-') <> NVL(rcRegistroAct.CHARGE_STATUS,'-') THEN
            UPDATE OR_ORDER
            SET CHARGE_STATUS=isbCHARGE_STATUS
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
    END prAcCHARGE_STATUS;
 
    -- Actualiza el valor de la columna PREV_ORDER_STATUS_ID
    PROCEDURE prAcPREV_ORDER_STATUS_ID(
        inuORDER_ID    NUMBER,
        inuPREV_ORDER_STATUS_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPREV_ORDER_STATUS_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuPREV_ORDER_STATUS_ID,-1) <> NVL(rcRegistroAct.PREV_ORDER_STATUS_ID,-1) THEN
            UPDATE OR_ORDER
            SET PREV_ORDER_STATUS_ID=inuPREV_ORDER_STATUS_ID
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
    END prAcPREV_ORDER_STATUS_ID;
 
    -- Actualiza el valor de la columna PROGRAMING_CLASS_ID
    PROCEDURE prAcPROGRAMING_CLASS_ID(
        inuORDER_ID    NUMBER,
        inuPROGRAMING_CLASS_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPROGRAMING_CLASS_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuPROGRAMING_CLASS_ID,-1) <> NVL(rcRegistroAct.PROGRAMING_CLASS_ID,-1) THEN
            UPDATE OR_ORDER
            SET PROGRAMING_CLASS_ID=inuPROGRAMING_CLASS_ID
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
    END prAcPROGRAMING_CLASS_ID;
 
    -- Actualiza el valor de la columna PREVIOUS_WORK
    PROCEDURE prAcPREVIOUS_WORK(
        inuORDER_ID    NUMBER,
        isbPREVIOUS_WORK    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPREVIOUS_WORK';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(isbPREVIOUS_WORK,'-') <> NVL(rcRegistroAct.PREVIOUS_WORK,'-') THEN
            UPDATE OR_ORDER
            SET PREVIOUS_WORK=isbPREVIOUS_WORK
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
    END prAcPREVIOUS_WORK;
 
    -- Actualiza el valor de la columna APPOINTMENT_CONFIRM
    PROCEDURE prAcAPPOINTMENT_CONFIRM(
        inuORDER_ID    NUMBER,
        isbAPPOINTMENT_CONFIRM    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcAPPOINTMENT_CONFIRM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(isbAPPOINTMENT_CONFIRM,'-') <> NVL(rcRegistroAct.APPOINTMENT_CONFIRM,'-') THEN
            UPDATE OR_ORDER
            SET APPOINTMENT_CONFIRM=isbAPPOINTMENT_CONFIRM
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
    END prAcAPPOINTMENT_CONFIRM;
 
    -- Actualiza el valor de la columna X
    PROCEDURE prAcX(
        inuORDER_ID    NUMBER,
        inuX    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcX';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuX,-1) <> NVL(rcRegistroAct.X,-1) THEN
            UPDATE OR_ORDER
            SET X=inuX
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
    END prAcX;
 
    -- Actualiza el valor de la columna Y
    PROCEDURE prAcY(
        inuORDER_ID    NUMBER,
        inuY    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcY';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuY,-1) <> NVL(rcRegistroAct.Y,-1) THEN
            UPDATE OR_ORDER
            SET Y=inuY
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
    END prAcY;
 
    -- Actualiza el valor de la columna STAGE_ID
    PROCEDURE prAcSTAGE_ID(
        inuORDER_ID    NUMBER,
        inuSTAGE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSTAGE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuSTAGE_ID,-1) <> NVL(rcRegistroAct.STAGE_ID,-1) THEN
            UPDATE OR_ORDER
            SET STAGE_ID=inuSTAGE_ID
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
    END prAcSTAGE_ID;
 
    -- Actualiza el valor de la columna LEGAL_IN_PROJECT
    PROCEDURE prAcLEGAL_IN_PROJECT(
        inuORDER_ID    NUMBER,
        isbLEGAL_IN_PROJECT    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLEGAL_IN_PROJECT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(isbLEGAL_IN_PROJECT,'-') <> NVL(rcRegistroAct.LEGAL_IN_PROJECT,'-') THEN
            UPDATE OR_ORDER
            SET LEGAL_IN_PROJECT=isbLEGAL_IN_PROJECT
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
    END prAcLEGAL_IN_PROJECT;
 
    -- Actualiza el valor de la columna OFFERED
    PROCEDURE prAcOFFERED(
        inuORDER_ID    NUMBER,
        isbOFFERED    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOFFERED';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(isbOFFERED,'-') <> NVL(rcRegistroAct.OFFERED,'-') THEN
            UPDATE OR_ORDER
            SET OFFERED=isbOFFERED
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
    END prAcOFFERED;
 
    -- Actualiza el valor de la columna ASSO_UNIT_ID
    PROCEDURE prAcASSO_UNIT_ID(
        inuORDER_ID    NUMBER,
        inuASSO_UNIT_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcASSO_UNIT_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuASSO_UNIT_ID,-1) <> NVL(rcRegistroAct.ASSO_UNIT_ID,-1) THEN
            UPDATE OR_ORDER
            SET ASSO_UNIT_ID=inuASSO_UNIT_ID
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
    END prAcASSO_UNIT_ID;
 
    -- Actualiza el valor de la columna SUBSCRIBER_ID
    PROCEDURE prAcSUBSCRIBER_ID(
        inuORDER_ID    NUMBER,
        inuSUBSCRIBER_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSUBSCRIBER_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuSUBSCRIBER_ID,-1) <> NVL(rcRegistroAct.SUBSCRIBER_ID,-1) THEN
            UPDATE OR_ORDER
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
 
    -- Actualiza el valor de la columna ADM_PENDING
    PROCEDURE prAcADM_PENDING(
        inuORDER_ID    NUMBER,
        isbADM_PENDING    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADM_PENDING';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(isbADM_PENDING,'-') <> NVL(rcRegistroAct.ADM_PENDING,'-') THEN
            UPDATE OR_ORDER
            SET ADM_PENDING=isbADM_PENDING
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
    END prAcADM_PENDING;
 
    -- Actualiza el valor de la columna SHAPE
    PROCEDURE prAcSHAPE(
        inuORDER_ID    NUMBER,
        ixxSHAPE    SDO_GEOMETRY
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSHAPE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        --IF NVL(ixxSHAPE,'-') <> NVL(rcRegistroAct.SHAPE,'-') THEN
        --    UPDATE OR_ORDER
        --    SET SHAPE=ixxSHAPE
        --    WHERE Rowid = rcRegistroAct.RowId;
        --END IF;
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
    END prAcSHAPE;
 
    -- Actualiza el valor de la columna ROUTE_ID
    PROCEDURE prAcROUTE_ID(
        inuORDER_ID    NUMBER,
        inuROUTE_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcROUTE_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuROUTE_ID,-1) <> NVL(rcRegistroAct.ROUTE_ID,-1) THEN
            UPDATE OR_ORDER
            SET ROUTE_ID=inuROUTE_ID
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
    END prAcROUTE_ID;
 
    -- Actualiza el valor de la columna CONSECUTIVE
    PROCEDURE prAcCONSECUTIVE(
        inuORDER_ID    NUMBER,
        inuCONSECUTIVE    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONSECUTIVE';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuCONSECUTIVE,-1) <> NVL(rcRegistroAct.CONSECUTIVE,-1) THEN
            UPDATE OR_ORDER
            SET CONSECUTIVE=inuCONSECUTIVE
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
    END prAcCONSECUTIVE;
 
    -- Actualiza el valor de la columna DEFINED_CONTRACT_ID
    PROCEDURE prAcDEFINED_CONTRACT_ID(
        inuORDER_ID    NUMBER,
        inuDEFINED_CONTRACT_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcDEFINED_CONTRACT_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuDEFINED_CONTRACT_ID,-1) <> NVL(rcRegistroAct.DEFINED_CONTRACT_ID,-1) THEN
            UPDATE OR_ORDER
            SET DEFINED_CONTRACT_ID=inuDEFINED_CONTRACT_ID
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
    END prAcDEFINED_CONTRACT_ID;
 
    -- Actualiza el valor de la columna IS_PENDING_LIQ
    PROCEDURE prAcIS_PENDING_LIQ(
        inuORDER_ID    NUMBER,
        isbIS_PENDING_LIQ    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIS_PENDING_LIQ';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(isbIS_PENDING_LIQ,'-') <> NVL(rcRegistroAct.IS_PENDING_LIQ,'-') THEN
            UPDATE OR_ORDER
            SET IS_PENDING_LIQ=isbIS_PENDING_LIQ
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
    END prAcIS_PENDING_LIQ;
 
    -- Actualiza el valor de la columna SCHED_ITINERARY_ID
    PROCEDURE prAcSCHED_ITINERARY_ID(
        inuORDER_ID    NUMBER,
        inuSCHED_ITINERARY_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSCHED_ITINERARY_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuSCHED_ITINERARY_ID,-1) <> NVL(rcRegistroAct.SCHED_ITINERARY_ID,-1) THEN
            UPDATE OR_ORDER
            SET SCHED_ITINERARY_ID=inuSCHED_ITINERARY_ID
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
    END prAcSCHED_ITINERARY_ID;
 
    -- Actualiza el valor de la columna ESTIMATED_COST
    PROCEDURE prAcESTIMATED_COST(
        inuORDER_ID    NUMBER,
        inuESTIMATED_COST    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcESTIMATED_COST';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuESTIMATED_COST,-1) <> NVL(rcRegistroAct.ESTIMATED_COST,-1) THEN
            UPDATE OR_ORDER
            SET ESTIMATED_COST=inuESTIMATED_COST
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
    END prAcESTIMATED_COST;
 
    -- Actualiza por RowId el valor de la columna PRIOR_ORDER_ID
    PROCEDURE prAcPRIOR_ORDER_ID_RId(
        iRowId ROWID,
        inuPRIOR_ORDER_ID_O    NUMBER,
        inuPRIOR_ORDER_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRIOR_ORDER_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPRIOR_ORDER_ID_O,-1) <> NVL(inuPRIOR_ORDER_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET PRIOR_ORDER_ID=inuPRIOR_ORDER_ID_N
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
    END prAcPRIOR_ORDER_ID_RId;
 
    -- Actualiza por RowId el valor de la columna NUMERATOR_ID
    PROCEDURE prAcNUMERATOR_ID_RId(
        iRowId ROWID,
        inuNUMERATOR_ID_O    NUMBER,
        inuNUMERATOR_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcNUMERATOR_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuNUMERATOR_ID_O,-1) <> NVL(inuNUMERATOR_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET NUMERATOR_ID=inuNUMERATOR_ID_N
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
    END prAcNUMERATOR_ID_RId;
 
    -- Actualiza por RowId el valor de la columna SEQUENCE
    PROCEDURE prAcSEQUENCE_RId(
        iRowId ROWID,
        inuSEQUENCE_O    NUMBER,
        inuSEQUENCE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSEQUENCE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuSEQUENCE_O,-1) <> NVL(inuSEQUENCE_N,-1) THEN
            UPDATE OR_ORDER
            SET SEQUENCE=inuSEQUENCE_N
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
    END prAcSEQUENCE_RId;
 
    -- Actualiza por RowId el valor de la columna PRIORITY
    PROCEDURE prAcPRIORITY_RId(
        iRowId ROWID,
        inuPRIORITY_O    NUMBER,
        inuPRIORITY_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRIORITY_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPRIORITY_O,-1) <> NVL(inuPRIORITY_N,-1) THEN
            UPDATE OR_ORDER
            SET PRIORITY=inuPRIORITY_N
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
    END prAcPRIORITY_RId;
 
    -- Actualiza por RowId el valor de la columna EXTERNAL_ADDRESS_ID
    PROCEDURE prAcEXTERNAL_ADDRESS_ID_RId(
        iRowId ROWID,
        inuEXTERNAL_ADDRESS_ID_O    NUMBER,
        inuEXTERNAL_ADDRESS_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEXTERNAL_ADDRESS_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuEXTERNAL_ADDRESS_ID_O,-1) <> NVL(inuEXTERNAL_ADDRESS_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET EXTERNAL_ADDRESS_ID=inuEXTERNAL_ADDRESS_ID_N
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
    END prAcEXTERNAL_ADDRESS_ID_RId;
 
    -- Actualiza por RowId el valor de la columna CREATED_DATE
    PROCEDURE prAcCREATED_DATE_RId(
        iRowId ROWID,
        idtCREATED_DATE_O    DATE,
        idtCREATED_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCREATED_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtCREATED_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtCREATED_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET CREATED_DATE=idtCREATED_DATE_N
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
    END prAcCREATED_DATE_RId;
 
    -- Actualiza por RowId el valor de la columna EXEC_INITIAL_DATE
    PROCEDURE prAcEXEC_INITIAL_DATE_RId(
        iRowId ROWID,
        idtEXEC_INITIAL_DATE_O    DATE,
        idtEXEC_INITIAL_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEXEC_INITIAL_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtEXEC_INITIAL_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtEXEC_INITIAL_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET EXEC_INITIAL_DATE=idtEXEC_INITIAL_DATE_N
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
    END prAcEXEC_INITIAL_DATE_RId;
 
    -- Actualiza por RowId el valor de la columna EXECUTION_FINAL_DATE
    PROCEDURE prAcEXECUTION_FINAL_DATE_RId(
        iRowId ROWID,
        idtEXECUTION_FINAL_DATE_O    DATE,
        idtEXECUTION_FINAL_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEXECUTION_FINAL_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtEXECUTION_FINAL_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtEXECUTION_FINAL_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET EXECUTION_FINAL_DATE=idtEXECUTION_FINAL_DATE_N
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
    END prAcEXECUTION_FINAL_DATE_RId;
 
    -- Actualiza por RowId el valor de la columna EXEC_ESTIMATE_DATE
    PROCEDURE prAcEXEC_ESTIMATE_DATE_RId(
        iRowId ROWID,
        idtEXEC_ESTIMATE_DATE_O    DATE,
        idtEXEC_ESTIMATE_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcEXEC_ESTIMATE_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtEXEC_ESTIMATE_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtEXEC_ESTIMATE_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET EXEC_ESTIMATE_DATE=idtEXEC_ESTIMATE_DATE_N
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
    END prAcEXEC_ESTIMATE_DATE_RId;
 
    -- Actualiza por RowId el valor de la columna ARRANGED_HOUR
    PROCEDURE prAcARRANGED_HOUR_RId(
        iRowId ROWID,
        idtARRANGED_HOUR_O    DATE,
        idtARRANGED_HOUR_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcARRANGED_HOUR_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtARRANGED_HOUR_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtARRANGED_HOUR_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET ARRANGED_HOUR=idtARRANGED_HOUR_N
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
    END prAcARRANGED_HOUR_RId;
 
    -- Actualiza por RowId el valor de la columna LEGALIZATION_DATE
    PROCEDURE prAcLEGALIZATION_DATE_RId(
        iRowId ROWID,
        idtLEGALIZATION_DATE_O    DATE,
        idtLEGALIZATION_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLEGALIZATION_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtLEGALIZATION_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtLEGALIZATION_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET LEGALIZATION_DATE=idtLEGALIZATION_DATE_N
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
    END prAcLEGALIZATION_DATE_RId;
 
    -- Actualiza por RowId el valor de la columna REPROGRAM_LAST_DATE
    PROCEDURE prAcREPROGRAM_LAST_DATE_RId(
        iRowId ROWID,
        idtREPROGRAM_LAST_DATE_O    DATE,
        idtREPROGRAM_LAST_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcREPROGRAM_LAST_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtREPROGRAM_LAST_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtREPROGRAM_LAST_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET REPROGRAM_LAST_DATE=idtREPROGRAM_LAST_DATE_N
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
    END prAcREPROGRAM_LAST_DATE_RId;
 
    -- Actualiza por RowId el valor de la columna ASSIGNED_DATE
    PROCEDURE prAcASSIGNED_DATE_RId(
        iRowId ROWID,
        idtASSIGNED_DATE_O    DATE,
        idtASSIGNED_DATE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcASSIGNED_DATE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtASSIGNED_DATE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtASSIGNED_DATE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET ASSIGNED_DATE=idtASSIGNED_DATE_N
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
    END prAcASSIGNED_DATE_RId;
 
    -- Actualiza por RowId el valor de la columna ASSIGNED_WITH
    PROCEDURE prAcASSIGNED_WITH_RId(
        iRowId ROWID,
        isbASSIGNED_WITH_O    VARCHAR2,
        isbASSIGNED_WITH_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcASSIGNED_WITH_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbASSIGNED_WITH_O,'-') <> NVL(isbASSIGNED_WITH_N,'-') THEN
            UPDATE OR_ORDER
            SET ASSIGNED_WITH=isbASSIGNED_WITH_N
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
    END prAcASSIGNED_WITH_RId;
 
    -- Actualiza por RowId el valor de la columna MAX_DATE_TO_LEGALIZE
    PROCEDURE prAcMAX_DATE_TO_LEGALIZE_RId(
        iRowId ROWID,
        idtMAX_DATE_TO_LEGALIZE_O    DATE,
        idtMAX_DATE_TO_LEGALIZE_N    DATE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcMAX_DATE_TO_LEGALIZE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtMAX_DATE_TO_LEGALIZE_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtMAX_DATE_TO_LEGALIZE_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE OR_ORDER
            SET MAX_DATE_TO_LEGALIZE=idtMAX_DATE_TO_LEGALIZE_N
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
    END prAcMAX_DATE_TO_LEGALIZE_RId;
 
    -- Actualiza por RowId el valor de la columna ORDER_VALUE
    PROCEDURE prAcORDER_VALUE_RId(
        iRowId ROWID,
        inuORDER_VALUE_O    NUMBER,
        inuORDER_VALUE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_VALUE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORDER_VALUE_O,-1) <> NVL(inuORDER_VALUE_N,-1) THEN
            UPDATE OR_ORDER
            SET ORDER_VALUE=inuORDER_VALUE_N
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
    END prAcORDER_VALUE_RId;
 
    -- Actualiza por RowId el valor de la columna PRINTING_TIME_NUMBER
    PROCEDURE prAcPRINTING_TIME_NUMBER_RId(
        iRowId ROWID,
        inuPRINTING_TIME_NUMBER_O    NUMBER,
        inuPRINTING_TIME_NUMBER_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRINTING_TIME_NUMBER_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPRINTING_TIME_NUMBER_O,-1) <> NVL(inuPRINTING_TIME_NUMBER_N,-1) THEN
            UPDATE OR_ORDER
            SET PRINTING_TIME_NUMBER=inuPRINTING_TIME_NUMBER_N
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
    END prAcPRINTING_TIME_NUMBER_RId;
 
    -- Actualiza por RowId el valor de la columna LEGALIZE_TRY_TIMES
    PROCEDURE prAcLEGALIZE_TRY_TIMES_RId(
        iRowId ROWID,
        inuLEGALIZE_TRY_TIMES_O    NUMBER,
        inuLEGALIZE_TRY_TIMES_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLEGALIZE_TRY_TIMES_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuLEGALIZE_TRY_TIMES_O,-1) <> NVL(inuLEGALIZE_TRY_TIMES_N,-1) THEN
            UPDATE OR_ORDER
            SET LEGALIZE_TRY_TIMES=inuLEGALIZE_TRY_TIMES_N
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
    END prAcLEGALIZE_TRY_TIMES_RId;
 
    -- Actualiza por RowId el valor de la columna OPERATING_UNIT_ID
    PROCEDURE prAcOPERATING_UNIT_ID_RId(
        iRowId ROWID,
        inuOPERATING_UNIT_ID_O    NUMBER,
        inuOPERATING_UNIT_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERATING_UNIT_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuOPERATING_UNIT_ID_O,-1) <> NVL(inuOPERATING_UNIT_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET OPERATING_UNIT_ID=inuOPERATING_UNIT_ID_N
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
    END prAcOPERATING_UNIT_ID_RId;
 
    -- Actualiza por RowId el valor de la columna ORDER_STATUS_ID
    PROCEDURE prAcORDER_STATUS_ID_RId(
        iRowId ROWID,
        inuORDER_STATUS_ID_O    NUMBER,
        inuORDER_STATUS_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_STATUS_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORDER_STATUS_ID_O,-1) <> NVL(inuORDER_STATUS_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET ORDER_STATUS_ID=inuORDER_STATUS_ID_N
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
    END prAcORDER_STATUS_ID_RId;
 
    -- Actualiza por RowId el valor de la columna TASK_TYPE_ID
    PROCEDURE prAcTASK_TYPE_ID_RId(
        iRowId ROWID,
        inuTASK_TYPE_ID_O    NUMBER,
        inuTASK_TYPE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcTASK_TYPE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuTASK_TYPE_ID_O,-1) <> NVL(inuTASK_TYPE_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET TASK_TYPE_ID=inuTASK_TYPE_ID_N
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
    END prAcTASK_TYPE_ID_RId;
 
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
            UPDATE OR_ORDER
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
 
    -- Actualiza por RowId el valor de la columna CAUSAL_ID
    PROCEDURE prAcCAUSAL_ID_RId(
        iRowId ROWID,
        inuCAUSAL_ID_O    NUMBER,
        inuCAUSAL_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCAUSAL_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCAUSAL_ID_O,-1) <> NVL(inuCAUSAL_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET CAUSAL_ID=inuCAUSAL_ID_N
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
    END prAcCAUSAL_ID_RId;
 
    -- Actualiza por RowId el valor de la columna ADMINIST_DISTRIB_ID
    PROCEDURE prAcADMINIST_DISTRIB_ID_RId(
        iRowId ROWID,
        inuADMINIST_DISTRIB_ID_O    NUMBER,
        inuADMINIST_DISTRIB_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADMINIST_DISTRIB_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuADMINIST_DISTRIB_ID_O,-1) <> NVL(inuADMINIST_DISTRIB_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET ADMINIST_DISTRIB_ID=inuADMINIST_DISTRIB_ID_N
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
    END prAcADMINIST_DISTRIB_ID_RId;
 
    -- Actualiza por RowId el valor de la columna ORDER_CLASSIF_ID
    PROCEDURE prAcORDER_CLASSIF_ID_RId(
        iRowId ROWID,
        inuORDER_CLASSIF_ID_O    NUMBER,
        inuORDER_CLASSIF_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_CLASSIF_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORDER_CLASSIF_ID_O,-1) <> NVL(inuORDER_CLASSIF_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET ORDER_CLASSIF_ID=inuORDER_CLASSIF_ID_N
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
    END prAcORDER_CLASSIF_ID_RId;
 
    -- Actualiza por RowId el valor de la columna GEOGRAP_LOCATION_ID
    PROCEDURE prAcGEOGRAP_LOCATION_ID_RId(
        iRowId ROWID,
        inuGEOGRAP_LOCATION_ID_O    NUMBER,
        inuGEOGRAP_LOCATION_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcGEOGRAP_LOCATION_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuGEOGRAP_LOCATION_ID_O,-1) <> NVL(inuGEOGRAP_LOCATION_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET GEOGRAP_LOCATION_ID=inuGEOGRAP_LOCATION_ID_N
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
    END prAcGEOGRAP_LOCATION_ID_RId;
 
    -- Actualiza por RowId el valor de la columna IS_COUNTERMAND
    PROCEDURE prAcIS_COUNTERMAND_RId(
        iRowId ROWID,
        isbIS_COUNTERMAND_O    VARCHAR2,
        isbIS_COUNTERMAND_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIS_COUNTERMAND_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbIS_COUNTERMAND_O,'-') <> NVL(isbIS_COUNTERMAND_N,'-') THEN
            UPDATE OR_ORDER
            SET IS_COUNTERMAND=isbIS_COUNTERMAND_N
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
    END prAcIS_COUNTERMAND_RId;
 
    -- Actualiza por RowId el valor de la columna REAL_TASK_TYPE_ID
    PROCEDURE prAcREAL_TASK_TYPE_ID_RId(
        iRowId ROWID,
        inuREAL_TASK_TYPE_ID_O    NUMBER,
        inuREAL_TASK_TYPE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcREAL_TASK_TYPE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuREAL_TASK_TYPE_ID_O,-1) <> NVL(inuREAL_TASK_TYPE_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET REAL_TASK_TYPE_ID=inuREAL_TASK_TYPE_ID_N
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
    END prAcREAL_TASK_TYPE_ID_RId;
 
    -- Actualiza por RowId el valor de la columna SAVED_DATA_VALUES
    PROCEDURE prAcSAVED_DATA_VALUES_RId(
        iRowId ROWID,
        isbSAVED_DATA_VALUES_O    VARCHAR2,
        isbSAVED_DATA_VALUES_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSAVED_DATA_VALUES_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbSAVED_DATA_VALUES_O,'-') <> NVL(isbSAVED_DATA_VALUES_N,'-') THEN
            UPDATE OR_ORDER
            SET SAVED_DATA_VALUES=isbSAVED_DATA_VALUES_N
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
    END prAcSAVED_DATA_VALUES_RId;
 
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
            UPDATE OR_ORDER
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
 
    -- Actualiza por RowId el valor de la columna ORDER_COST_AVERAGE
    PROCEDURE prAcORDER_COST_AVERAGE_RId(
        iRowId ROWID,
        inuORDER_COST_AVERAGE_O    NUMBER,
        inuORDER_COST_AVERAGE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_COST_AVERAGE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORDER_COST_AVERAGE_O,-1) <> NVL(inuORDER_COST_AVERAGE_N,-1) THEN
            UPDATE OR_ORDER
            SET ORDER_COST_AVERAGE=inuORDER_COST_AVERAGE_N
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
    END prAcORDER_COST_AVERAGE_RId;
 
    -- Actualiza por RowId el valor de la columna ORDER_COST_BY_LIST
    PROCEDURE prAcORDER_COST_BY_LIST_RId(
        iRowId ROWID,
        inuORDER_COST_BY_LIST_O    NUMBER,
        inuORDER_COST_BY_LIST_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcORDER_COST_BY_LIST_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuORDER_COST_BY_LIST_O,-1) <> NVL(inuORDER_COST_BY_LIST_N,-1) THEN
            UPDATE OR_ORDER
            SET ORDER_COST_BY_LIST=inuORDER_COST_BY_LIST_N
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
    END prAcORDER_COST_BY_LIST_RId;
 
    -- Actualiza por RowId el valor de la columna OPERATIVE_AIU_VALUE
    PROCEDURE prAcOPERATIVE_AIU_VALUE_RId(
        iRowId ROWID,
        inuOPERATIVE_AIU_VALUE_O    NUMBER,
        inuOPERATIVE_AIU_VALUE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERATIVE_AIU_VALUE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuOPERATIVE_AIU_VALUE_O,-1) <> NVL(inuOPERATIVE_AIU_VALUE_N,-1) THEN
            UPDATE OR_ORDER
            SET OPERATIVE_AIU_VALUE=inuOPERATIVE_AIU_VALUE_N
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
    END prAcOPERATIVE_AIU_VALUE_RId;
 
    -- Actualiza por RowId el valor de la columna ADMIN_AIU_VALUE
    PROCEDURE prAcADMIN_AIU_VALUE_RId(
        iRowId ROWID,
        inuADMIN_AIU_VALUE_O    NUMBER,
        inuADMIN_AIU_VALUE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADMIN_AIU_VALUE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuADMIN_AIU_VALUE_O,-1) <> NVL(inuADMIN_AIU_VALUE_N,-1) THEN
            UPDATE OR_ORDER
            SET ADMIN_AIU_VALUE=inuADMIN_AIU_VALUE_N
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
    END prAcADMIN_AIU_VALUE_RId;
 
    -- Actualiza por RowId el valor de la columna CHARGE_STATUS
    PROCEDURE prAcCHARGE_STATUS_RId(
        iRowId ROWID,
        isbCHARGE_STATUS_O    VARCHAR2,
        isbCHARGE_STATUS_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCHARGE_STATUS_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbCHARGE_STATUS_O,'-') <> NVL(isbCHARGE_STATUS_N,'-') THEN
            UPDATE OR_ORDER
            SET CHARGE_STATUS=isbCHARGE_STATUS_N
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
    END prAcCHARGE_STATUS_RId;
 
    -- Actualiza por RowId el valor de la columna PREV_ORDER_STATUS_ID
    PROCEDURE prAcPREV_ORDER_STATUS_ID_RId(
        iRowId ROWID,
        inuPREV_ORDER_STATUS_ID_O    NUMBER,
        inuPREV_ORDER_STATUS_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPREV_ORDER_STATUS_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPREV_ORDER_STATUS_ID_O,-1) <> NVL(inuPREV_ORDER_STATUS_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET PREV_ORDER_STATUS_ID=inuPREV_ORDER_STATUS_ID_N
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
    END prAcPREV_ORDER_STATUS_ID_RId;
 
    -- Actualiza por RowId el valor de la columna PROGRAMING_CLASS_ID
    PROCEDURE prAcPROGRAMING_CLASS_ID_RId(
        iRowId ROWID,
        inuPROGRAMING_CLASS_ID_O    NUMBER,
        inuPROGRAMING_CLASS_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPROGRAMING_CLASS_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPROGRAMING_CLASS_ID_O,-1) <> NVL(inuPROGRAMING_CLASS_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET PROGRAMING_CLASS_ID=inuPROGRAMING_CLASS_ID_N
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
    END prAcPROGRAMING_CLASS_ID_RId;
 
    -- Actualiza por RowId el valor de la columna PREVIOUS_WORK
    PROCEDURE prAcPREVIOUS_WORK_RId(
        iRowId ROWID,
        isbPREVIOUS_WORK_O    VARCHAR2,
        isbPREVIOUS_WORK_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPREVIOUS_WORK_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbPREVIOUS_WORK_O,'-') <> NVL(isbPREVIOUS_WORK_N,'-') THEN
            UPDATE OR_ORDER
            SET PREVIOUS_WORK=isbPREVIOUS_WORK_N
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
    END prAcPREVIOUS_WORK_RId;
 
    -- Actualiza por RowId el valor de la columna APPOINTMENT_CONFIRM
    PROCEDURE prAcAPPOINTMENT_CONFIRM_RId(
        iRowId ROWID,
        isbAPPOINTMENT_CONFIRM_O    VARCHAR2,
        isbAPPOINTMENT_CONFIRM_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcAPPOINTMENT_CONFIRM_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbAPPOINTMENT_CONFIRM_O,'-') <> NVL(isbAPPOINTMENT_CONFIRM_N,'-') THEN
            UPDATE OR_ORDER
            SET APPOINTMENT_CONFIRM=isbAPPOINTMENT_CONFIRM_N
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
    END prAcAPPOINTMENT_CONFIRM_RId;
 
    -- Actualiza por RowId el valor de la columna X
    PROCEDURE prAcX_RId(
        iRowId ROWID,
        inuX_O    NUMBER,
        inuX_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcX_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuX_O,-1) <> NVL(inuX_N,-1) THEN
            UPDATE OR_ORDER
            SET X=inuX_N
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
    END prAcX_RId;
 
    -- Actualiza por RowId el valor de la columna Y
    PROCEDURE prAcY_RId(
        iRowId ROWID,
        inuY_O    NUMBER,
        inuY_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcY_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuY_O,-1) <> NVL(inuY_N,-1) THEN
            UPDATE OR_ORDER
            SET Y=inuY_N
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
    END prAcY_RId;
 
    -- Actualiza por RowId el valor de la columna STAGE_ID
    PROCEDURE prAcSTAGE_ID_RId(
        iRowId ROWID,
        inuSTAGE_ID_O    NUMBER,
        inuSTAGE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSTAGE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuSTAGE_ID_O,-1) <> NVL(inuSTAGE_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET STAGE_ID=inuSTAGE_ID_N
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
    END prAcSTAGE_ID_RId;
 
    -- Actualiza por RowId el valor de la columna LEGAL_IN_PROJECT
    PROCEDURE prAcLEGAL_IN_PROJECT_RId(
        iRowId ROWID,
        isbLEGAL_IN_PROJECT_O    VARCHAR2,
        isbLEGAL_IN_PROJECT_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcLEGAL_IN_PROJECT_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbLEGAL_IN_PROJECT_O,'-') <> NVL(isbLEGAL_IN_PROJECT_N,'-') THEN
            UPDATE OR_ORDER
            SET LEGAL_IN_PROJECT=isbLEGAL_IN_PROJECT_N
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
    END prAcLEGAL_IN_PROJECT_RId;
 
    -- Actualiza por RowId el valor de la columna OFFERED
    PROCEDURE prAcOFFERED_RId(
        iRowId ROWID,
        isbOFFERED_O    VARCHAR2,
        isbOFFERED_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOFFERED_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbOFFERED_O,'-') <> NVL(isbOFFERED_N,'-') THEN
            UPDATE OR_ORDER
            SET OFFERED=isbOFFERED_N
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
    END prAcOFFERED_RId;
 
    -- Actualiza por RowId el valor de la columna ASSO_UNIT_ID
    PROCEDURE prAcASSO_UNIT_ID_RId(
        iRowId ROWID,
        inuASSO_UNIT_ID_O    NUMBER,
        inuASSO_UNIT_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcASSO_UNIT_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuASSO_UNIT_ID_O,-1) <> NVL(inuASSO_UNIT_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET ASSO_UNIT_ID=inuASSO_UNIT_ID_N
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
    END prAcASSO_UNIT_ID_RId;
 
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
            UPDATE OR_ORDER
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
 
    -- Actualiza por RowId el valor de la columna ADM_PENDING
    PROCEDURE prAcADM_PENDING_RId(
        iRowId ROWID,
        isbADM_PENDING_O    VARCHAR2,
        isbADM_PENDING_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcADM_PENDING_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbADM_PENDING_O,'-') <> NVL(isbADM_PENDING_N,'-') THEN
            UPDATE OR_ORDER
            SET ADM_PENDING=isbADM_PENDING_N
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
    END prAcADM_PENDING_RId;
 
    -- Actualiza por RowId el valor de la columna SHAPE
    PROCEDURE prAcSHAPE_RId(
        iRowId ROWID,
        ixxSHAPE_O    SDO_GEOMETRY,
        ixxSHAPE_N    SDO_GEOMETRY
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSHAPE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        --IF NVL(ixxSHAPE_O,'-') <> NVL(ixxSHAPE_N,'-') THEN
        --    UPDATE OR_ORDER
        --    SET SHAPE=ixxSHAPE_N
        --    WHERE Rowid = iRowId;
        --END IF;
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
    END prAcSHAPE_RId;
 
    -- Actualiza por RowId el valor de la columna ROUTE_ID
    PROCEDURE prAcROUTE_ID_RId(
        iRowId ROWID,
        inuROUTE_ID_O    NUMBER,
        inuROUTE_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcROUTE_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuROUTE_ID_O,-1) <> NVL(inuROUTE_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET ROUTE_ID=inuROUTE_ID_N
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
    END prAcROUTE_ID_RId;
 
    -- Actualiza por RowId el valor de la columna CONSECUTIVE
    PROCEDURE prAcCONSECUTIVE_RId(
        iRowId ROWID,
        inuCONSECUTIVE_O    NUMBER,
        inuCONSECUTIVE_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcCONSECUTIVE_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuCONSECUTIVE_O,-1) <> NVL(inuCONSECUTIVE_N,-1) THEN
            UPDATE OR_ORDER
            SET CONSECUTIVE=inuCONSECUTIVE_N
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
    END prAcCONSECUTIVE_RId;
 
    -- Actualiza por RowId el valor de la columna DEFINED_CONTRACT_ID
    PROCEDURE prAcDEFINED_CONTRACT_ID_RId(
        iRowId ROWID,
        inuDEFINED_CONTRACT_ID_O    NUMBER,
        inuDEFINED_CONTRACT_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcDEFINED_CONTRACT_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuDEFINED_CONTRACT_ID_O,-1) <> NVL(inuDEFINED_CONTRACT_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET DEFINED_CONTRACT_ID=inuDEFINED_CONTRACT_ID_N
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
    END prAcDEFINED_CONTRACT_ID_RId;
 
    -- Actualiza por RowId el valor de la columna IS_PENDING_LIQ
    PROCEDURE prAcIS_PENDING_LIQ_RId(
        iRowId ROWID,
        isbIS_PENDING_LIQ_O    VARCHAR2,
        isbIS_PENDING_LIQ_N    VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcIS_PENDING_LIQ_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbIS_PENDING_LIQ_O,'-') <> NVL(isbIS_PENDING_LIQ_N,'-') THEN
            UPDATE OR_ORDER
            SET IS_PENDING_LIQ=isbIS_PENDING_LIQ_N
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
    END prAcIS_PENDING_LIQ_RId;
 
    -- Actualiza por RowId el valor de la columna SCHED_ITINERARY_ID
    PROCEDURE prAcSCHED_ITINERARY_ID_RId(
        iRowId ROWID,
        inuSCHED_ITINERARY_ID_O    NUMBER,
        inuSCHED_ITINERARY_ID_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcSCHED_ITINERARY_ID_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuSCHED_ITINERARY_ID_O,-1) <> NVL(inuSCHED_ITINERARY_ID_N,-1) THEN
            UPDATE OR_ORDER
            SET SCHED_ITINERARY_ID=inuSCHED_ITINERARY_ID_N
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
    END prAcSCHED_ITINERARY_ID_RId;
 
    -- Actualiza por RowId el valor de la columna ESTIMATED_COST
    PROCEDURE prAcESTIMATED_COST_RId(
        iRowId ROWID,
        inuESTIMATED_COST_O    NUMBER,
        inuESTIMATED_COST_N    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcESTIMATED_COST_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuESTIMATED_COST_O,-1) <> NVL(inuESTIMATED_COST_N,-1) THEN
            UPDATE OR_ORDER
            SET ESTIMATED_COST=inuESTIMATED_COST_N
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
    END prAcESTIMATED_COST_RId;
 
    -- Actualiza las columnas con valor diferente al anterior
    PROCEDURE prActRegistro( ircRegistro cuOR_ORDER%ROWTYPE) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.ORDER_ID,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcPRIOR_ORDER_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PRIOR_ORDER_ID,
                ircRegistro.PRIOR_ORDER_ID
            );
 
            prAcNUMERATOR_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.NUMERATOR_ID,
                ircRegistro.NUMERATOR_ID
            );
 
            prAcSEQUENCE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SEQUENCE,
                ircRegistro.SEQUENCE
            );
 
            prAcPRIORITY_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PRIORITY,
                ircRegistro.PRIORITY
            );
 
            prAcEXTERNAL_ADDRESS_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.EXTERNAL_ADDRESS_ID,
                ircRegistro.EXTERNAL_ADDRESS_ID
            );
 
            prAcCREATED_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CREATED_DATE,
                ircRegistro.CREATED_DATE
            );
 
            prAcEXEC_INITIAL_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.EXEC_INITIAL_DATE,
                ircRegistro.EXEC_INITIAL_DATE
            );
 
            prAcEXECUTION_FINAL_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.EXECUTION_FINAL_DATE,
                ircRegistro.EXECUTION_FINAL_DATE
            );
 
            prAcEXEC_ESTIMATE_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.EXEC_ESTIMATE_DATE,
                ircRegistro.EXEC_ESTIMATE_DATE
            );
 
            prAcARRANGED_HOUR_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ARRANGED_HOUR,
                ircRegistro.ARRANGED_HOUR
            );
 
            prAcLEGALIZATION_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.LEGALIZATION_DATE,
                ircRegistro.LEGALIZATION_DATE
            );
 
            prAcREPROGRAM_LAST_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.REPROGRAM_LAST_DATE,
                ircRegistro.REPROGRAM_LAST_DATE
            );
 
            prAcASSIGNED_DATE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ASSIGNED_DATE,
                ircRegistro.ASSIGNED_DATE
            );
 
            prAcASSIGNED_WITH_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ASSIGNED_WITH,
                ircRegistro.ASSIGNED_WITH
            );
 
            prAcMAX_DATE_TO_LEGALIZE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.MAX_DATE_TO_LEGALIZE,
                ircRegistro.MAX_DATE_TO_LEGALIZE
            );
 
            prAcORDER_VALUE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORDER_VALUE,
                ircRegistro.ORDER_VALUE
            );
 
            prAcPRINTING_TIME_NUMBER_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PRINTING_TIME_NUMBER,
                ircRegistro.PRINTING_TIME_NUMBER
            );
 
            prAcLEGALIZE_TRY_TIMES_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.LEGALIZE_TRY_TIMES,
                ircRegistro.LEGALIZE_TRY_TIMES
            );
 
            prAcOPERATING_UNIT_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OPERATING_UNIT_ID,
                ircRegistro.OPERATING_UNIT_ID
            );
 
            prAcORDER_STATUS_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORDER_STATUS_ID,
                ircRegistro.ORDER_STATUS_ID
            );
 
            prAcTASK_TYPE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.TASK_TYPE_ID,
                ircRegistro.TASK_TYPE_ID
            );
 
            prAcOPERATING_SECTOR_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OPERATING_SECTOR_ID,
                ircRegistro.OPERATING_SECTOR_ID
            );
 
            prAcCAUSAL_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CAUSAL_ID,
                ircRegistro.CAUSAL_ID
            );
 
            prAcADMINIST_DISTRIB_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ADMINIST_DISTRIB_ID,
                ircRegistro.ADMINIST_DISTRIB_ID
            );
 
            prAcORDER_CLASSIF_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORDER_CLASSIF_ID,
                ircRegistro.ORDER_CLASSIF_ID
            );
 
            prAcGEOGRAP_LOCATION_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.GEOGRAP_LOCATION_ID,
                ircRegistro.GEOGRAP_LOCATION_ID
            );
 
            prAcIS_COUNTERMAND_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.IS_COUNTERMAND,
                ircRegistro.IS_COUNTERMAND
            );
 
            prAcREAL_TASK_TYPE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.REAL_TASK_TYPE_ID,
                ircRegistro.REAL_TASK_TYPE_ID
            );
 
            prAcSAVED_DATA_VALUES_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SAVED_DATA_VALUES,
                ircRegistro.SAVED_DATA_VALUES
            );
 
            prAcFOR_AUTOMATIC_LEGA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FOR_AUTOMATIC_LEGA,
                ircRegistro.FOR_AUTOMATIC_LEGA
            );
 
            prAcORDER_COST_AVERAGE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORDER_COST_AVERAGE,
                ircRegistro.ORDER_COST_AVERAGE
            );
 
            prAcORDER_COST_BY_LIST_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ORDER_COST_BY_LIST,
                ircRegistro.ORDER_COST_BY_LIST
            );
 
            prAcOPERATIVE_AIU_VALUE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OPERATIVE_AIU_VALUE,
                ircRegistro.OPERATIVE_AIU_VALUE
            );
 
            prAcADMIN_AIU_VALUE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ADMIN_AIU_VALUE,
                ircRegistro.ADMIN_AIU_VALUE
            );
 
            prAcCHARGE_STATUS_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CHARGE_STATUS,
                ircRegistro.CHARGE_STATUS
            );
 
            prAcPREV_ORDER_STATUS_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PREV_ORDER_STATUS_ID,
                ircRegistro.PREV_ORDER_STATUS_ID
            );
 
            prAcPROGRAMING_CLASS_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PROGRAMING_CLASS_ID,
                ircRegistro.PROGRAMING_CLASS_ID
            );
 
            prAcPREVIOUS_WORK_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PREVIOUS_WORK,
                ircRegistro.PREVIOUS_WORK
            );
 
            prAcAPPOINTMENT_CONFIRM_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.APPOINTMENT_CONFIRM,
                ircRegistro.APPOINTMENT_CONFIRM
            );
 
            prAcX_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.X,
                ircRegistro.X
            );
 
            prAcY_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.Y,
                ircRegistro.Y
            );
 
            prAcSTAGE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.STAGE_ID,
                ircRegistro.STAGE_ID
            );
 
            prAcLEGAL_IN_PROJECT_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.LEGAL_IN_PROJECT,
                ircRegistro.LEGAL_IN_PROJECT
            );
 
            prAcOFFERED_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.OFFERED,
                ircRegistro.OFFERED
            );
 
            prAcASSO_UNIT_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ASSO_UNIT_ID,
                ircRegistro.ASSO_UNIT_ID
            );
 
            prAcSUBSCRIBER_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SUBSCRIBER_ID,
                ircRegistro.SUBSCRIBER_ID
            );
 
            prAcADM_PENDING_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ADM_PENDING,
                ircRegistro.ADM_PENDING
            );
 
            prAcSHAPE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SHAPE,
                ircRegistro.SHAPE
            );
 
            prAcROUTE_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ROUTE_ID,
                ircRegistro.ROUTE_ID
            );
 
            prAcCONSECUTIVE_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.CONSECUTIVE,
                ircRegistro.CONSECUTIVE
            );
 
            prAcDEFINED_CONTRACT_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.DEFINED_CONTRACT_ID,
                ircRegistro.DEFINED_CONTRACT_ID
            );
 
            prAcIS_PENDING_LIQ_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.IS_PENDING_LIQ,
                ircRegistro.IS_PENDING_LIQ
            );
 
            prAcSCHED_ITINERARY_ID_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.SCHED_ITINERARY_ID,
                ircRegistro.SCHED_ITINERARY_ID
            );
 
            prAcESTIMATED_COST_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ESTIMATED_COST,
                ircRegistro.ESTIMATED_COST
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


    -- Actualiza el valor de la columna OPERATING_UNIT_ID
    PROCEDURE prAcOPERATING_UNIT_ID(
        inuORDER_ID    NUMBER,
        inuOPERATING_UNIT_ID    NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcOPERATING_UNIT_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID,TRUE);
        IF NVL(inuOPERATING_UNIT_ID,-1) <> NVL(rcRegistroAct.OPERATING_UNIT_ID,-1) THEN
            UPDATE OR_ORDER
            SET OPERATING_UNIT_ID=inuOPERATING_UNIT_ID
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
    END prAcOPERATING_UNIT_ID;

 

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa        : prc_ActualizaCausalOrden
    Descripcion     : Actualizar la causal de una orden

    Autor       	:   Carlos Gonzalez - Horbath
    Fecha       	:   03-01-2024

    Parametros de Entrada
      inuOrden        Identificador de la orden
      inuCausal       Identificador de la causal
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error

    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   03-01-2024  OSF-2155 Creacion
    ***************************************************************************/
    PROCEDURE prc_ActualizaCausalOrden
    (
        inuOrden    IN  or_order.order_id%type,
        inuCausal 	IN  or_order.causal_id%type,
        onuError    OUT NUMBER,
        osbError    OUT VARCHAR2
    ) 
    IS
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prc_ActualizaCausalOrden';
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden => ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('inuCausal => ' || inuCausal, pkg_traza.cnuNivelTrzDef);
        pkg_error.prInicializaError(onuError, osbError);

        UPDATE or_order
        SET causal_id = inuCausal
        WHERE order_id = inuOrden;

        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(onuError,osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(onuError,osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END prc_ActualizaCausalOrden;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa        : prc_ActualizaDireccionOrden
    Descripcion     : Actualizar la direcciÃƒÂ³n de la orden

    Autor       	:   Luis Felipe Valencia Hurtado
    Fecha       	:   12-0-32024

    Parametros de Entrada
      inuOrden        	Identificador de la orden
      isbDireccion 		Identificador de la Direccion
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error

    Modificaciones  :
    Autor       		Fecha       Caso     	Descripcion
    felipe.valencia   	12-03-2024  OSF-2416 	CreaciÃƒÂ³n
    ***************************************************************************/
    PROCEDURE prcActualizaDireccionOrden
    (
        inuOrden    	IN  or_order.order_id%type,
        isbDireccion 	IN  or_order.external_address_id%type,
        onuError    	OUT NUMBER,
        osbError    	OUT VARCHAR2
    ) 
    IS
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcActualizaDireccionOrden';
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuOrden => ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('isbDireccion => ' || isbDireccion, pkg_traza.cnuNivelTrzDef);
        pkg_error.prInicializaError(onuError, osbError);   
                
        UPDATE or_order SET external_address_id = isbDireccion WHERE order_id = inuOrden;
        
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(onuError,osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(onuError,osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END prcActualizaDireccionOrden;
    
    /**************************************************************************
    Autor       : Jorge Valiente
    Fecha       : 13/03/2024
    Ticket      : OSF-2411
    Proceso     : prcActualizaSectorOperativo
    Descripcion : procedimiento que se encarga de actualizar sector operativo de la orden

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE prcActualizaSectorOperativo(inuOrden           IN or_order.order_id%type,
                        inuSectorOperativo IN or_order.operating_sector_id%type,
                        onuError           OUT NUMBER,
                        osbError           OUT VARCHAR2
                        ) 
    IS
      
        csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.prcActualizaSectorOperativo';
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('Orden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('Sector Operativo: ' || inuSectorOperativo, pkg_traza.cnuNivelTrzDef);
        
        pkg_error.prInicializaError(onuError, osbError);

        UPDATE or_order
        SET OPERATING_SECTOR_ID = inuSectorOperativo
        WHERE order_id = inuOrden;

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END prcActualizaSectorOperativo;
    
    /**************************************************************************
    Autor       : Jorge Valiente / Horbath
    Fecha       : 26/03/2024
    Ticket      : OSF-2411
    Proceso     : prcActualizaEstado
    Descripcion : procedimiento que se encarga de actualizar sector operativo de la orden

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE prcActualizaEstado(inuOrden  IN or_order.order_id%type,
                  inuEstado IN or_order.order_status_id%type,
                  onuError  OUT NUMBER,
                  osbError  OUT VARCHAR2
                  ) 
    IS 
        csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.prcActualizaEstado';
    BEGIN
      
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        pkg_traza.trace('Orden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        
        pkg_traza.trace('Estado: ' || inuEstado, pkg_traza.cnuNivelTrzDef);
        
        pkg_error.prInicializaError(onuError, osbError);

        UPDATE or_order
        SET order_status_id = inuEstado
        WHERE order_id = inuOrden;

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END prcActualizaEstado;
    
    /**************************************************************************
    Autor       : Jorge Valiente / Horbath
    Fecha       : 26/03/2024
    Ticket      : OSF-2411
    Proceso     : prcActualizaEstadoAnterior
    Descripcion : pprocedimiento que se encarga de actualizar estado anterior de la orden

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE prcActualizaEstadoAnterior(inuOrden  IN or_order.order_id%type,
                      inuEstado IN or_order.prev_order_status_id%type,
                      onuError  OUT NUMBER,
                      osbError  OUT VARCHAR2
                      ) 
    IS
      
        csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.prcActualizaEstadoAnterior';
    
    BEGIN
      
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('Orden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('Estado: ' || inuEstado, pkg_traza.cnuNivelTrzDef);
        pkg_error.prInicializaError(onuError, osbError);

        UPDATE or_order
            SET prev_order_status_id = inuEstado
        WHERE order_id = inuOrden;

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END prcActualizaEstadoAnterior;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa        : prcActualizaRecord
    Descripcion     : Actualizar la orden con un record

    Autor       	:   Jhon Eduar Erazo Guachavez
    Fecha       	:   24-04-2024

    Parametros de Entrada
    inuOrden        	Identificador de la orden
    isbDireccion 		Identificador de la Direccion
    Parametros de Salida

    Modificaciones  :
    Autor       	Fecha       Caso     	Descripcion
    jerazomvm  		24-04-2024  OSF-2556 	CreaciÃƒÂ³n
    ***************************************************************************/
    PROCEDURE prcActualizaRecord(ircOrOrder IN  styOR_order) 
    IS
    
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcActualizaRecord';
        
        nuError			NUMBER;  
        nuOrderId		or_order.order_id%type;	
        sbmensaje		VARCHAR2(1000);  
    
    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF ircOrOrder.ROWID IS NOT NULL THEN
          UPDATE OR_ORDER
          SET	PRIOR_ORDER_ID 			= ircOrOrder.PRIOR_ORDER_ID,
            NUMERATOR_ID 			= ircOrOrder.NUMERATOR_ID,
            SEQUENCE 				= ircOrOrder.SEQUENCE,
            PRIORITY 				= ircOrOrder.PRIORITY,
            EXTERNAL_ADDRESS_ID		= ircOrOrder.EXTERNAL_ADDRESS_ID,
            CREATED_DATE 			= ircOrOrder.CREATED_DATE,
            EXEC_INITIAL_DATE 		= ircOrOrder.EXEC_INITIAL_DATE,
            EXECUTION_FINAL_DATE 	= ircOrOrder.EXECUTION_FINAL_DATE,
            EXEC_ESTIMATE_DATE 		= ircOrOrder.EXEC_ESTIMATE_DATE,
            ARRANGED_HOUR 			= ircOrOrder.ARRANGED_HOUR,
            LEGALIZATION_DATE 		= ircOrOrder.LEGALIZATION_DATE,
            REPROGRAM_LAST_DATE 	= ircOrOrder.REPROGRAM_LAST_DATE,
            ASSIGNED_DATE 			= ircOrOrder.ASSIGNED_DATE,
            ASSIGNED_WITH 			= ircOrOrder.ASSIGNED_WITH,
            MAX_DATE_TO_LEGALIZE 	= ircOrOrder.MAX_DATE_TO_LEGALIZE,
            ORDER_VALUE 			= ircOrOrder.ORDER_VALUE,
            PRINTING_TIME_NUMBER 	= ircOrOrder.PRINTING_TIME_NUMBER,
            LEGALIZE_TRY_TIMES 		= ircOrOrder.LEGALIZE_TRY_TIMES,
            OPERATING_UNIT_ID 		= ircOrOrder.OPERATING_UNIT_ID,
            ORDER_STATUS_ID			= ircOrOrder.ORDER_STATUS_ID,
            TASK_TYPE_ID 			= ircOrOrder.TASK_TYPE_ID,
            OPERATING_SECTOR_ID 	= ircOrOrder.OPERATING_SECTOR_ID,
            CAUSAL_ID 				= ircOrOrder.CAUSAL_ID,
            ADMINIST_DISTRIB_ID 	= ircOrOrder.ADMINIST_DISTRIB_ID,
            ORDER_CLASSIF_ID 		= ircOrOrder.ORDER_CLASSIF_ID,
            GEOGRAP_LOCATION_ID 	= ircOrOrder.GEOGRAP_LOCATION_ID,
            IS_COUNTERMAND 			= ircOrOrder.IS_COUNTERMAND,
            REAL_TASK_TYPE_ID 		= ircOrOrder.REAL_TASK_TYPE_ID,
            SAVED_DATA_VALUES 		= ircOrOrder.SAVED_DATA_VALUES,
            FOR_AUTOMATIC_LEGA 		= ircOrOrder.FOR_AUTOMATIC_LEGA,
            ORDER_COST_AVERAGE 		= ircOrOrder.ORDER_COST_AVERAGE,
            ORDER_COST_BY_LIST 		= ircOrOrder.ORDER_COST_BY_LIST,
            OPERATIVE_AIU_VALUE 	= ircOrOrder.OPERATIVE_AIU_VALUE,
            ADMIN_AIU_VALUE 		= ircOrOrder.ADMIN_AIU_VALUE,
            CHARGE_STATUS 			= ircOrOrder.CHARGE_STATUS,
            PREV_ORDER_STATUS_ID 	= ircOrOrder.PREV_ORDER_STATUS_ID,
            PROGRAMING_CLASS_ID 	= ircOrOrder.PROGRAMING_CLASS_ID,
            PREVIOUS_WORK 			= ircOrOrder.PREVIOUS_WORK,
            APPOINTMENT_CONFIRM 	= ircOrOrder.APPOINTMENT_CONFIRM,
            X 						= ircOrOrder.X,
            Y 						= ircOrOrder.Y,
            STAGE_ID 				= ircOrOrder.STAGE_ID,
            LEGAL_IN_PROJECT 		= ircOrOrder.LEGAL_IN_PROJECT,
            OFFERED 				= ircOrOrder.OFFERED,
            ASSO_UNIT_ID 			= ircOrOrder.ASSO_UNIT_ID,
            SUBSCRIBER_ID 			= ircOrOrder.SUBSCRIBER_ID,
            ADM_PENDING 			= ircOrOrder.ADM_PENDING,
            SHAPE 					= ircOrOrder.SHAPE,
            ROUTE_ID 				= ircOrOrder.ROUTE_ID,
            CONSECUTIVE 			= ircOrOrder.CONSECUTIVE,
            DEFINED_CONTRACT_ID 	= ircOrOrder.DEFINED_CONTRACT_ID,
            IS_PENDING_LIQ 			= ircOrOrder.IS_PENDING_LIQ,
            SCHED_ITINERARY_ID 		= ircOrOrder.SCHED_ITINERARY_ID,
            ESTIMATED_COST 			= ircOrOrder.ESTIMATED_COST
          WHERE ROWID = ircOrOrder.ROWID
          RETURNING ORDER_ID
          INTO nuOrderId;
        ELSE
          UPDATE OR_ORDER
          SET PRIOR_ORDER_ID 			= ircOrOrder.PRIOR_ORDER_ID,
            NUMERATOR_ID 			= ircOrOrder.NUMERATOR_ID,
            SEQUENCE 				= ircOrOrder.SEQUENCE,
            PRIORITY 				= ircOrOrder.PRIORITY,
            EXTERNAL_ADDRESS_ID 	= ircOrOrder.EXTERNAL_ADDRESS_ID,
            CREATED_DATE 			= ircOrOrder.CREATED_DATE,
            EXEC_INITIAL_DATE 		= ircOrOrder.EXEC_INITIAL_DATE,
            EXECUTION_FINAL_DATE	= ircOrOrder.EXECUTION_FINAL_DATE,
            EXEC_ESTIMATE_DATE 		= ircOrOrder.EXEC_ESTIMATE_DATE,
            ARRANGED_HOUR 			= ircOrOrder.ARRANGED_HOUR,
            LEGALIZATION_DATE 		= ircOrOrder.LEGALIZATION_DATE,
            REPROGRAM_LAST_DATE 	= ircOrOrder.REPROGRAM_LAST_DATE,
            ASSIGNED_DATE 			= ircOrOrder.ASSIGNED_DATE,
            ASSIGNED_WITH 			= ircOrOrder.ASSIGNED_WITH,
            MAX_DATE_TO_LEGALIZE 	= ircOrOrder.MAX_DATE_TO_LEGALIZE,
            ORDER_VALUE 			= ircOrOrder.ORDER_VALUE,
            PRINTING_TIME_NUMBER 	= ircOrOrder.PRINTING_TIME_NUMBER,
            LEGALIZE_TRY_TIMES 		= ircOrOrder.LEGALIZE_TRY_TIMES,
            OPERATING_UNIT_ID 		= ircOrOrder.OPERATING_UNIT_ID,
            ORDER_STATUS_ID 		= ircOrOrder.ORDER_STATUS_ID,
            TASK_TYPE_ID 			= ircOrOrder.TASK_TYPE_ID,
            OPERATING_SECTOR_ID 	= ircOrOrder.OPERATING_SECTOR_ID,
            CAUSAL_ID 				= ircOrOrder.CAUSAL_ID,
            ADMINIST_DISTRIB_ID 	= ircOrOrder.ADMINIST_DISTRIB_ID,
            ORDER_CLASSIF_ID 		= ircOrOrder.ORDER_CLASSIF_ID,
            GEOGRAP_LOCATION_ID 	= ircOrOrder.GEOGRAP_LOCATION_ID,
            IS_COUNTERMAND 			= ircOrOrder.IS_COUNTERMAND,
            REAL_TASK_TYPE_ID 		= ircOrOrder.REAL_TASK_TYPE_ID,
            SAVED_DATA_VALUES 		= ircOrOrder.SAVED_DATA_VALUES,
            FOR_AUTOMATIC_LEGA 		= ircOrOrder.FOR_AUTOMATIC_LEGA,
            ORDER_COST_AVERAGE 		= ircOrOrder.ORDER_COST_AVERAGE,
            ORDER_COST_BY_LIST 		= ircOrOrder.ORDER_COST_BY_LIST,
            OPERATIVE_AIU_VALUE 	= ircOrOrder.OPERATIVE_AIU_VALUE,
            ADMIN_AIU_VALUE 		= ircOrOrder.ADMIN_AIU_VALUE,
            CHARGE_STATUS 			= ircOrOrder.CHARGE_STATUS,
            PREV_ORDER_STATUS_ID 	= ircOrOrder.PREV_ORDER_STATUS_ID,
            PROGRAMING_CLASS_ID 	= ircOrOrder.PROGRAMING_CLASS_ID,
            PREVIOUS_WORK 			= ircOrOrder.PREVIOUS_WORK,
            APPOINTMENT_CONFIRM 	= ircOrOrder.APPOINTMENT_CONFIRM,
            X 						= ircOrOrder.X,
            Y 						= ircOrOrder.Y,
            STAGE_ID 				= ircOrOrder.STAGE_ID,
            LEGAL_IN_PROJECT 		= ircOrOrder.LEGAL_IN_PROJECT,
            OFFERED 				= ircOrOrder.OFFERED,
            ASSO_UNIT_ID 			= ircOrOrder.ASSO_UNIT_ID,
            SUBSCRIBER_ID 			= ircOrOrder.SUBSCRIBER_ID,
            ADM_PENDING 			= ircOrOrder.ADM_PENDING,
            SHAPE 					= ircOrOrder.SHAPE,
            ROUTE_ID 				= ircOrOrder.ROUTE_ID,
            CONSECUTIVE 			= ircOrOrder.CONSECUTIVE,
            DEFINED_CONTRACT_ID 	= ircOrOrder.DEFINED_CONTRACT_ID,
            IS_PENDING_LIQ 			= ircOrOrder.IS_PENDING_LIQ,
            SCHED_ITINERARY_ID 		= ircOrOrder.SCHED_ITINERARY_ID,
            ESTIMATED_COST 			= ircOrOrder.ESTIMATED_COST
          WHERE ORDER_ID = ircOrOrder.ORDER_ID
          RETURNING ORDER_ID
          INTO nuOrderId;
        END IF;
        
        IF nuOrderId IS NULL THEN
          RAISE NO_DATA_FOUND;
        END IF;

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            Pkg_Error.SetErrorMessage(1,' El registro Ordenes De Trabajo ['|| ircOrOrder.ORDER_ID ||'] no existe, o no estÃƒÂ¡ autorizado para acceder los datos.');
            RAISE PKG_ERROR.CONTROLLED_ERROR;
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbmensaje);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE PKG_ERROR.CONTROLLED_ERROR;
        WHEN others THEN
            Pkg_Error.seterror;
            pkg_error.geterror(nuError, sbmensaje);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE PKG_ERROR.CONTROLLED_ERROR;
    END prcActualizaRecord;

    /***************************************************************************
    Programa        : prActOrdenNovedad
    Descripcion     : Actualiza la orden de novedad
    Autor       	:   Lubin Pineda
    Fecha       	:   15-07-2024

    Parametros de Entrada
    inuOrden        	Identificador de la orden
    ircOrden 		    Registro con la informaciÃƒÂ³n a actualizar
    Parametros de Salida

    Modificaciones  :
    Autor       	Fecha       Caso     	Descripcion
    jpinedc  		15-07-2024  OSF-2204 	CreaciÃƒÂ³n
    ***************************************************************************/        
    PROCEDURE prActOrdenNovedad( inuOrder NUMBER, ircOrden or_order%ROWTYPE)
    IS    
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prActOrdenNovedad';
        
        nuError			    NUMBER;  
        sbmensaje		    VARCHAR2(1000);  

    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
                        
        UPDATE OR_ORDER
        SET defined_contract_id     = ircOrden.defined_contract_id,
            legalization_date       = ircOrden.legalization_date,
            exec_initial_date       = ircOrden.exec_initial_date,
            execution_final_date    = ircOrden.execution_final_date,
            exec_estimate_date      = ircOrden.exec_estimate_date,
            is_pending_liq          = NULL            
        WHERE 
            order_id = inuOrder;
        
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbmensaje);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE PKG_ERROR.CONTROLLED_ERROR;
        WHEN others THEN
            Pkg_Error.seterror;
            pkg_error.geterror(nuError, sbmensaje);
            pkg_traza.trace('nuError: ' || nuError || ', ' || 'sbmensaje: ' || sbmensaje, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE PKG_ERROR.CONTROLLED_ERROR;
    END prActOrdenNovedad;

    -- Obtiene el valor de la columna DEFINED_CONTRACT_ID
    FUNCTION fnuObtDEFINED_CONTRACT_ID(
        inuORDER_ID    NUMBER
        ) RETURN OR_ORDER.DEFINED_CONTRACT_ID%TYPE
        IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtDEFINED_CONTRACT_ID';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuORDER_ID);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.DEFINED_CONTRACT_ID;
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
    END fnuObtDEFINED_CONTRACT_ID;
    
END pkg_or_order;
/

BEGIN
	pkg_utilidades.prAplicarPermisos('PKG_OR_ORDER', 'ADM_PERSON');
END;
/

