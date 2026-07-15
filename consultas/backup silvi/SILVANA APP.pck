CREATE OR REPLACE PACKAGE SSJ_UIEVEN
as

/*******************************************************************************
 Package: SSJ_UIEVEN

 Description:   Methods and functions for the administration of events.
                Training Framework .Net
 Author: John Alexander Espinosa Caicedo
 Date: March 06/2019

 History of Modifications
 Date           Author - Modification
 ===========    ================================================================
 Mar 06/2019     John Alexander Espinosa Caicedo
 
******************************************************************************/


    ----------------------------------------------------------------------------
    -- Variables
    ----------------------------------------------------------------------------
    sbSqlevent                  varchar2(10000);
    sbeventAttributes           varchar2(4000);
    sbSqlAvailability           varchar2(10000);
    sbAvailabilityAttributes    varchar2(4000);
    sbHistoricAttributes        varchar2(4000);
    sbSqlHistoric               varchar2(10000);

    sbMovementAttributes    varchar2(4000);
    sbPaymentAttributes     varchar2(4000);
    sbInstallmentAttributes varchar2(4000);
    sbCreditPlanAttributes  varchar2(4000);
    sbSqlCreditPLan         varchar2(10000);

    ----------------------------------------------------------------------------
    --Functions and Procedures

    ----------------------------------------------------------------------------
    /***************************************************************************
     Método: GetEvent
     Descripción:   Returns the events
    ***************************************************************************/
    PROCEDURE GetEvent
    (
        inuEvent   in SSJ_EVENT.Event_id%type,
        ocuCursor  out constants.tyRefCursor
    );


    ----------------------------------------------------------------------------
    /***************************************************************************
     Método: GetAvailability
     Description:   Returns the Availability
    ***************************************************************************/
    PROCEDURE GetAvailability
    (
        inuAvailability     in SSJ_AVAILABILITY.Availability_Id%type,
        ocuCursor           out constants.tyRefCursor
    );

    /***************************************************************************
     Método: GetHistoric
     Description:    Returns the GetHistoric
    ***************************************************************************/
    PROCEDURE GetHistoric
    (
        inuHistoric      in SSJ_HISTORIC.Historic_id%type,
        ocuCursor        out constants.tyRefCursor
    );

    /***************************************************************************
     Método: FillEventAttributes
     Description: Returns the attributes of an event
    ***************************************************************************/
     PROCEDURE FillEventAttributes;
    /***************************************************************************
     Método: FillAvailabilityAttributes
     Description:   Returns the attributes of Availability
    ***************************************************************************/
     PROCEDURE FillAvailabilityAttributes;
    /***************************************************************************
     Método: FillHistoricAttributes
     Description: Returns the attributes of the historical
    ***************************************************************************/
     PROCEDURE FillHistoricAttributes;
    /***************************************************************************
     Método: GetEvents
     Description: Search method for events
    ***************************************************************************/
     PROCEDURE GetEvents
     (
        isbEventid      in SSJ_EVENT.ID %type,
        isbDescription  in SSJ_EVENT.DESCRIPTION%type,
        isbEventType    in SSJ_EVENT.TYPE_%type,
        isbEventActive  in SSJ_EVENT.FLAG%type,
        ocuCursor       out constants.tyRefCursor
     );

    /***************************************************************************
     Método: GetAvailabilities
     Description:  Search method for Availabilities
    ***************************************************************************/
     PROCEDURE GetAvailabilities
     (
        isbAvailabilityId   in SSJ_AVAILABILITY.ID %type,
        isbEventId          in SSJ_AVAILABILITY.EVENT%type,
        isbStartDate        in SSJ_AVAILABILITY.START_DATE%type,
        isbEndDate          in SSJ_AVAILABILITY.END_DATE%type,
        ocuCursor           out constants.tyRefCursor
     );

    PROCEDURE GeteventByAvaila
    (
        inuAvailabilityId   in SSJ_AVAILABILITY.ID %type,
        onuEventid          out SSJ_EVENT.ID %type
    );

    PROCEDURE GetAvailaByevent
    (
        inuEventId     in SSJ_AVAILABILITY.EVENT%type,
        ocuCursor           out constants.tyRefCursor
    );

    PROCEDURE GetEventByHistoric
    (
        inuHistoricId       in SSJ_HISTORIC.id%type,
        onuEventid          out SSJ_EVENT.ID%type
    );

    PROCEDURE GetHistoricEvent
    (
        inEvenId      in SSJ_HISTORIC.id%type,
        ocuCursor     out constants.tyRefCursor
    );

END GE_UIEVEN;
/
CREATE OR REPLACE PACKAGE BODY SSJ_UIEVEN
as

/*******************************************************************************
 Package: SSJ_UIEVEN

 Description:   Methods and functions for the administration of events.
                Training Framework .Net
 Author: John Alexander Espinosa Caicedo
 Date: March 06/2019

 History of Modifications
 Date           Author - Modification
 ===========    ================================================================
 Mar 06/2019     John Alexander Espinosa Caicedo

*******************************************************************************/

    ----------------------------------------------------------------------------
    -- Variables
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    -- Functions and Procedures
    ----------------------------------------------------------------------------

--------------------------------------------------------------------------------
FUNCTION fsbVersion  return varchar2 IS
BEGIN
    return 'SSJ_UIEVEN';
END;
--------------------------------------------------------------------------------

/*******************************************************************************
 Method: FillEventAttributes
 Description: Get all the data to show an event.
 Author: John Alexander Espinosa Caicedo
 Date: March 06/2019

 History of Modifications
 Date           Author - Modification
 ===========    ================================================================
 Mar 06/2019     John Alexander Espinosa Caicedo
*******************************************************************************/

PROCEDURE FillEventAttributes
IS

sbParent             varchar2(500);
sbEventid            varchar2(500);
sbDescription        varchar2(500);
sbEventType          varchar2(500);
sbEventActive        varchar2(500);

sbFromEvent          varchar2(4000);
sbJoinsevent         varchar2(4000);

BEGIN
    if sbSqlevent IS not null then
        return;
    END if;

    -- Definition of each of the attributes
    sbEventid           := 'SSJ_EVENT.ID';
    sbDescription       := 'SSJ_EVENT.DESCRIPTION';
    sbEventType         := 'SSJ_EVENT.TYPE_' || CC_BOBossUtil.csbSEPARATOR || 'SSJ_TYPE.DESCRIPTION';
    sbEventActive       := 'SSJ_EVENT.FLAG';
    sbParent            := 'to_char(:parent_id) parent_id';



    -- Construction of the attributes
    sbeventAttributes := sbeventAttributes || sbEventid         ||', '|| chr(10);
    sbeventAttributes := sbeventAttributes || sbDescription     ||', '|| chr(10);
    sbeventAttributes := sbeventAttributes || sbEventType       ||'TYPE_, '|| chr(10);
    sbeventAttributes := sbeventAttributes || sbEventActive     ||', '|| chr(10);
    sbeventAttributes := sbeventAttributes || sbParent  ||chr(10);
    
    -- Definition of from
    sbFromEvent      :=  'FROM SSJ_EVENT , SSJ_TYPE '||chr(10);

    -- Relationship between tables
    sbJoinsevent     :=  'WHERE  SSJ_EVENT.TYPE_= SSJ_TYPE.ID' ||chr(10);

    sbSqlevent := 'SELECT '|| chr(10);
    sbSqlevent := sbSqlevent || sbeventAttributes;
    sbSqlevent := sbSqlevent || sbFromEvent;
    sbSqlevent := sbSqlevent || sbJoinsevent;



EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when others then
        errors.seterror;
        raise ex.CONTROLLED_ERROR;
END;

/*******************************************************************************
 Method: FillAvailabilityAttributes
 Description:   Get all the data to show for Availability
 Author: John Alexander Espinosa Caicedo
 Date: March 06/2019

 History of Modifications
 Date           Author - Modification
 ===========    ================================================================
 Mar 06/2019     John Alexander Espinosa Caicedo
*******************************************************************************/

PROCEDURE FillAvailabilityAttributes
IS

sbParent            varchar2(500);
sbAvailabilityId    varchar2(500);
sbEventId           varchar2(500);
sbStartDate         varchar2(500);
sbEnd_Date          varchar2(500);

sbFrom               varchar2(4000);
sbJoins              varchar2(4000);

BEGIN
    if sbAvailabilityAttributes IS not null then
        return;
    END if;

    sbAvailabilityId    := 'SSJ_AVAILABILITY.ID';
    sbEventId           := 'SSJ_AVAILABILITY.EVENT ' || CC_BOBossUtil.csbSEPARATOR || ' SSJ_EVENT.Description';
    sbStartDate         := 'SSJ_AVAILABILITY.START_DATE';
    sbEnd_Date          := 'SSJ_AVAILABILITY.END_DATE';
    sbParent            := 'SSJ_AVAILABILITY.EVENT parent_id';

    sbAvailabilityAttributes := sbAvailabilityAttributes || sbAvailabilityId    ||', '|| chr(10);
    sbAvailabilityAttributes := sbAvailabilityAttributes || sbEventId           ||' EVENT, '|| chr(10);
    sbAvailabilityAttributes := sbAvailabilityAttributes || sbStartDate         ||', '|| chr(10);
    sbAvailabilityAttributes := sbAvailabilityAttributes || sbEnd_Date          ||', '|| chr(10);
    sbAvailabilityAttributes := sbAvailabilityAttributes || sbParent            || chr(10);


    sbFrom      :=  'FROM SSJ_AVAILABILITY, SSJ_EVENT '||chr(10);
    sbJoins     :=  'WHERE SSJ_AVAILABILITY.EVENT  = SSJ_EVENT .Event_id' ||chr(10);

    sbSqlAvailability := 'SELECT '|| chr(10);
    sbSqlAvailability := sbSqlAvailability || sbAvailabilityAttributes;
    sbSqlAvailability := sbSqlAvailability || sbFrom;
    sbSqlAvailability := sbSqlAvailability || sbJoins;


EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when others then
        errors.seterror;
        raise ex.CONTROLLED_ERROR;
END;

/*******************************************************************************
 Method: FillHistoricAttributes
 Description:   Get all the data to show for a historical
 Author: John Alexander Espinosa Caicedo
 Date: March 06/2019

 History of Modifications
 Date           Author - Modification
 ===========    ================================================================
 Mar 06/2019     John Alexander Espinosa Caicedo
*******************************************************************************/

PROCEDURE FillHistoricAttributes
IS

sbHistoricid        varchar2(500);
sbUserid            varchar2(500);
sbEventid           varchar2(500);
sbStartDate         varchar2(500);
sbEndDate           varchar2(500);
sbHistoricActive    varchar2(500);
sbParent            varchar2(500);

sbFromHist          varchar2(4000);
sbJoinHist          varchar2(4000);

BEGIN
    if sbHistoricAttributes IS not null then
        return;
    END if;

    sbHistoricid        := 'SSJ_HISTORIC.id';
    sbUserid            := 'SSJ_HISTORIC.user_' || CC_BOBossUtil.csbSEPARATOR || ' SA_USER.mask';
    sbEventid           := 'SSJ_HISTORIC.event';
    sbStartDate         := 'SSJ_HISTORIC.Start_Date';
    sbEndDate           := 'SSJ_HISTORIC.End_Date';
    sbHistoricActive    := 'SSJ_HISTORIC.active';
    sbParent            := 'SSJ_HISTORIC.id parent_id';

    sbHistoricAttributes := sbHistoricAttributes || sbHistoricid        ||', '|| chr(10);
    sbHistoricAttributes := sbHistoricAttributes || sbUserid            ||' User_id, '|| chr(10);
    sbHistoricAttributes := sbHistoricAttributes || sbEventid           ||', '|| chr(10);
    sbHistoricAttributes := sbHistoricAttributes || sbStartDate         ||', '|| chr(10);
    sbHistoricAttributes := sbHistoricAttributes || sbEndDate           ||', '|| chr(10);
    sbHistoricAttributes := sbHistoricAttributes || sbHistoricActive    ||', '|| chr(10);
    sbHistoricAttributes := sbHistoricAttributes || sbParent          || chr(10);

    -- Definition of from
    sbFromHist     :=  'FROM SSJ_HISTORIC, SA_USER'||chr(10);

    -- Relationship between tables
    sbJoinHist     :=  'WHERE  SSJ_HISTORIC.User_ = SA_USER.User_id' ||chr(10);

    sbSqlHistoric := 'SELECT '|| chr(10);
    sbSqlHistoric := sbSqlHistoric || sbHistoricAttributes;
    sbSqlHistoric := sbSqlHistoric || sbFromHist;
    sbSqlHistoric := sbSqlHistoric || sbJoinHist;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when others then
        errors.seterror;
        raise ex.CONTROLLED_ERROR;
END;

/*******************************************************************************
 Method: GetEvent
 Description:   Get all the data of an event
 Author: John Alexander Espinosa Caicedo
 Date: March 06/2019

 History of Modifications
 Date           Author - Modification
 ===========    ================================================================
 Mar 06/2019     John Alexander Espinosa Caicedo
*******************************************************************************/
PROCEDURE GetEvent
(
     inuEvent   in SSJ_EVENT.ID%type,
     ocuCursor  out constants.tyRefCursor
)
IS
sbSqlFinal varchar2(10000);
BEGIN
    --Call to the method that defines the attributes
    FillEventAttributes;

    -- Condition to bring a single attribute receiving ID value
    sbSqlFinal := sbSqlevent || 'AND SSJ_EVENT.ID = :Event_id'||chr(10);

    --Open CURSOR with sentences and parameters
    open ocuCursor for sbSqlFinal using cc_boBossUtil.cnuNULL, inuEvent;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when others then
        errors.seterror;
        raise ex.CONTROLLED_ERROR;
END;

/*******************************************************************************
 Method: GetAvailability
 Description:   Get all the data of an Availability
 Author: John Alexander Espinosa Caicedo
 Date: March 06/2019

 History of Modifications
 Date           Author - Modification
 ===========    ================================================================
 Mar 06/2019     John Alexander Espinosa Caicedo
*******************************************************************************/
PROCEDURE GetAvailability
(
    inuAvailability     in SSJ_AVAILABILITY.Availability_Id%type,
    ocuCursor           out constants.tyRefCursor
)
IS
sbSqlFinal varchar2(10000);
BEGIN

    FillAvailabilityAttributes;

    sbSqlFinal :=  sbSqlAvailability || 'AND SSJ_AVAILABILITY.Availability_Id = :Availability_Id'||chr(10);

    open ocuCursor for sbSqlFinal using inuAvailability;


EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when others then
        errors.seterror;
        raise ex.CONTROLLED_ERROR;
END;

/*******************************************************************************
 Method: GetHistoric
 Description:   Get all the data of an historical
 Author: John Alexander Espinosa Caicedo
 Date: March 06/2019

 History of Modifications
 Date           Author - Modification
 ===========    ================================================================
 Mar 06/2019     John Alexander Espinosa Caicedo
*******************************************************************************/
PROCEDURE GetHistoric
(
    inuHistoric      in SSJ_HISTORIC.id%type,
    ocuCursor        out constants.tyRefCursor
)
IS
sbSqlFinal           varchar2(4000);
BEGIN
    FillHistoricAttributes;

    sbSqlFinal := sbSqlHistoric || 'AND SSJ_HISTORIC.id = :Historic_id';

    open ocuCursor for sbSqlFinal using inuHistoric;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when others then
        errors.seterror;
        raise ex.CONTROLLED_ERROR;
END;

/*******************************************************************************
 Method: GetEvents
 Description:   Gets all events that meet the selection criteria indicated
                by the user
 Author: John Alexander Espinosa Caicedo
 Date: March 06/2019

 History of Modifications
 Date           Author - Modification
 ===========    ================================================================
 Mar 06/2019     John Alexander Espinosa Caicedo

*******************************************************************************/

PROCEDURE GetEvents
(
    isbEventid      in SSJ_EVENT.id%type,
    isbDescription  in SSJ_EVENT.Description%type,
    isbEventType    in SSJ_EVENT.type_%type,
    isbEventActive  in SSJ_EVENT.flag%type,
    ocuCursor       out constants.tyRefCursor
)
IS

sbSqlFinal varchar2(10000);
sbFilters varchar2(4000);
nuParent varchar2(100);

BEGIN

    -- Validate the event
    if isbEventid is not null then
        sbFilters := sbFilters ||' and SSJ_EVENT.Event_id = :Event_id' ||chr(10);
    else
        sbFilters := sbFilters ||' and SSJ_EVENT.Event_id = nvl(:Event_id,SSJ_EVENT .Event_id )' ||chr(10);
    END if;


    -- Validate the description
    if isbDescription is not null then
        sbFilters := sbFilters ||' and SSJ_EVENT.Description like :Description||''%''' ||chr(10);
    else
        sbFilters := sbFilters ||' and SSJ_EVENT.Description = nvl(:Description , SSJ_EVENT.Description )' ||chr(10);
    END if;

    -- Validate the event type
    if isbEventType is not null then
        sbFilters := sbFilters ||' and SSJ_EVENT.Event_Type = :EventType' ||chr(10);
    else
        sbFilters := sbFilters ||' and SSJ_EVENT.Event_Type = nvl(:EventType,SSJ_EVENT.Event_Type )' ||chr(10);
    END if;

    -- Validate the active
    if isbEventActive is not null then
        sbFilters := sbFilters ||' and SSJ_EVENT.Event_Active = :Event_Active' ||chr(10);
    else
        sbFilters := sbFilters ||' and SSJ_EVENT.Event_Active = nvl(:Event_Active,SSJ_EVENT .Event_Active )' ||chr(10);
    END if;


    --The SQL statement is armed
    FillEventAttributes;
    sbSqlFinal  := sbSqlevent || sbFilters ;

    --Call the cursor always passing ALL parameterss
    open ocuCursor for sbSqlFinal
    using   cc_boBossUtil.cnuNULL, isbEventid, isbDescription, isbEventType, isbEventActive;


EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when others then
        errors.seterror;
        raise ex.CONTROLLED_ERROR;
END;

/*******************************************************************************
 Method: GetAvailabilities
 Description:   Gets all Availabilities that meet the selection criteria
                indicated by the user
 Author: John Alexander Espinosa Caicedo
 Date: March 06/2019

 History of Modifications
 Date           Author - Modification
 ===========    ================================================================
 Mar 06/2019     John Alexander Espinosa Caicedo
*******************************************************************************/

PROCEDURE GetAvailabilities
(
    isbAvailabilityId   in SSJ_AVAILABILITY.Availability_Id %type,
    isbEventId          in SSJ_AVAILABILITY.EVENT %type,
    isbStartDate        in SSJ_AVAILABILITY.Start_Date%type,
    isbEndDate          in SSJ_AVAILABILITY.End_Date%type,
    ocuCursor           out constants.tyRefCursor
)
IS

sbSqlFinal varchar2(10000);
sbFilters varchar2(4000);
nuParent varchar2(100);

BEGIN

    -- Validate the Availability
    if isbAvailabilityId is not null then
        sbFilters := sbFilters ||' and SSJ_AVAILABILITY.ID = :Availability_Id' ||chr(10);
    else
        sbFilters := sbFilters ||' and SSJ_AVAILABILITY.ID = nvl(:Availability_Id,SSJ_AVAILABILITY.Availability_Id )' ||chr(10);
    END if;

    -- Validate the event
    if isbEventId is not null then
        sbFilters := sbFilters ||' and SSJ_AVAILABILITY.EVENT  = :Event_Id' ||chr(10);
    else
        sbFilters := sbFilters ||' and SSJ_AVAILABILITY.EVENT  = nvl(:Event_Id,SSJ_AVAILABILITY.EVENT  )' ||chr(10);
    END if;

    --Validate the Start date
    if isbStartDate is not null then
        sbFilters := sbFilters ||' and SSJ_AVAILABILITY.Start_Date = :Start_Date' ||chr(10);
    else
        sbFilters := sbFilters ||' and SSJ_AVAILABILITY.Start_Date = nvl(:Start_Date,SSJ_AVAILABILITY.Start_Date )' ||chr(10);
    END if;

    --Validate the END date
    if isbEndDate is not null then
        sbFilters := sbFilters ||' and SSJ_AVAILABILITY.End_Date = :End_Date' ||chr(10);
    else
        sbFilters := sbFilters ||' and SSJ_AVAILABILITY.End_Date = nvl(:End_Date,SSJ_AVAILABILITY.End_Date )' ||chr(10);
    END if;


    -- The SQL statement is armed
    FillAvailabilityAttributes;
    sbSqlFinal  := sbSqlAvailability || sbFilters ;

    -- Call the cursor always passing ALL parameterss
    open ocuCursor for sbSqlFinal
    using  isbAvailabilityId, isbEventId, isbStartDate, isbEndDate;


EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when others then
        errors.seterror;
        raise ex.CONTROLLED_ERROR;
END;


/*******************************************************************************
 Method: GeteventByAvaila
 Description: Get the event from an availability
 Author: John Alexander Espinosa Caicedo
 Date: March 08/2019

 History of Modifications
 Date           Author - Modification
 ===========    ================================================================
 MAR 08/2019    John Alexander Espinosa Caicedo: Creation
*******************************************************************************/
PROCEDURE GeteventByAvaila
(
    inuAvailabilityId   in SSJ_AVAILABILITY.ID %type,
    onuEventid          out SSJ_EVENT.ID %type
)
IS

    CURSOR cueventByAvaila
    IS
        SELECT  EVENT
        FROM    SSJ_AVAILABILITY
        WHERE  SSJ_AVAILABILITY.ID = inuAvailabilityId;

BEGIN

        OPEN cueventByAvaila;
        FETCH cueventByAvaila INTO onuEventid;
        CLOSE cueventByAvaila;


EXCEPTION
    when ex.CONTROLLED_ERROR then
    --If it fails returns nul
        onuEventid := null;

    when others then
        ERRORS.seterror;
        raise ex.CONTROLLED_ERROR;
END;

/*******************************************************************************
 Method: GetAvailaByevent
 Description: Get the availability from a event
 Autor: John Alexander Espinosa Caicedo
 Fecha: March 08/2019

 History of Modifications
 Date           Author - Modification
 ===========    ================================================================
 MAR 08/2019    John Alexander Espinosa Caicedo: Creation
*******************************************************************************/
PROCEDURE GetAvailaByevent
(
    inuEventId     in SSJ_AVAILABILITY.EVENT %type,
    ocuCursor           out constants.tyRefCursor
)
IS
sbSqlFinal varchar2(10000);
BEGIN

    FillAvailabilityAttributes;

    sbSqlFinal :=  sbSqlAvailability || 'AND SSJ_AVAILABILITY.EVENT  = :Event_Id'||chr(10);

    open ocuCursor for sbSqlFinal using inuEventId;


EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when others then
        errors.seterror;
        raise ex.CONTROLLED_ERROR;
END;

/*******************************************************************************
 Method: GetEventByHistoric
 Description: Get the event from a Historic
 Autor: John Alexander Espinosa Caicedo
 Fecha: March 08/2019

 History of Modifications
 Date           Author - Modification
 ===========    ================================================================
 MAR 08/2019    John Alexander Espinosa Caicedo: Creation
*******************************************************************************/
PROCEDURE GetEventByHistoric
(
    inuHistoricId       in SSJ_HISTORIC.Historic_id%type,
    onuEventid          out SSJ_EVENT .Event_id%type
)
IS

    CURSOR cuEventByHistoric
    IS
        SELECT  Event_id
        FROM    SSJ_HISTORIC
        WHERE   Historic_id = inuHistoricId;

BEGIN

        OPEN cuEventByHistoric;
        FETCH cuEventByHistoric INTO onuEventid;
        CLOSE cuEventByHistoric;


EXCEPTION
    when ex.CONTROLLED_ERROR then
        onuEventid := null;

    when others then
        ERRORS.seterror;
        raise ex.CONTROLLED_ERROR;
END;

/*******************************************************************************
 Method: GetHistoricEvent
 Description: Get the event from a Historic
 Autor: John Alexander Espinosa Caicedo
 Fecha: March 08/2019

 History of Modifications
 Date           Author - Modification
 ===========    ================================================================
 MAR 08/2019    John Alexander Espinosa Caicedo: Creation
*******************************************************************************/
PROCEDURE GetHistoricEvent
(
    inEvenId      in SSJ_HISTORIC.Event_id%type,
    ocuCursor     out constants.tyRefCursor
)
IS
sbSqlFinal           varchar2(4000);
BEGIN
    FillHistoricAttributes;

    sbSqlFinal := sbSqlHistoric || 'AND SSJ_HISTORIC.Event_id = :inEvenId';

    open ocuCursor for sbSqlFinal using inEvenId;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when others then
        errors.seterror;
        raise ex.CONTROLLED_ERROR;
END;


-- =============================================================================

END SSJ_UIEVEN;
/
