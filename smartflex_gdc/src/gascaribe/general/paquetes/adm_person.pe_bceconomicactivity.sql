CREATE OR REPLACE PACKAGE adm_person.PE_BCECONOMICACTIVITY
IS

/*****************************************************************
Propiedad intelectual de Open International Systems (c).

Unidad         : PE_BCECONOMICACTIVITY
Descripcion    : "Bussiness Object" personalizado para actividad econÃ³mica por
                contrato.

Autor          : Erika A. Montenegro G.
Fecha          : 28-11-2014

Historia de Modificaciones
Fecha           Autor                  Modificacion
=========       =========              ====================
28-11-2014      emontenegro.SAO295858      CreaciÃ³n..

******************************************************************/

    --------------------------------------------
    -- Tipos y Variables
    --------------------------------------------

    --------------------------------------------
    -- Constantes
    --------------------------------------------

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    /*****************************************************************
    Unidad   : fsbVersion
    Descripcion	: Obtiene la version del paquete
    ******************************************************************/
    FUNCTION fsbVersion  return varchar2;


    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : GetEconomicActivity
    Descripcion	   : Obtiene la Actividad EconÃ³mica del contrato.

                    Retorna   Actividad EconÃ³mica

    Fecha          : 28-11-2014

    Parametros          Descripcion
    ============        ===================
    inuSubscriberId     Identificador del Cliente

    Historia de Modificaciones
    Fecha            Autor                  Modificacion
    =========        =========              ====================
    28-11-2014       emontenegro.SAO295858  CreaciÃ³n
    ******************************************************************/
    FUNCTION GetEconomicActivity (inuSubscriptionId  in suscripc.susccodi%type)
    RETURN pe_eco_act_contract.economic_activity_id%type;


END PE_BCECONOMICACTIVITY;
/
CREATE OR REPLACE PACKAGE BODY adm_person.PE_BCECONOMICACTIVITY
IS

/*****************************************************************
Propiedad intelectual de Open International Systems (c).

Unidad         : PE_BCECONOMICACTIVITY
Descripcion    : Objeto personalizado para consultas de actividad econÃ³mica por
                contrato.

Autor          : Erika A. Montenegro G.
Fecha          : 28-11-2014

Historia de Modificaciones
Fecha           Autor                  Modificacion
=========       =========              ====================
28-11-2014      emontenegro.SAO295858      CreaciÃ³n.
******************************************************************/

 	-- Declaracion de variables y tipos globales privados del paquete
    csbVersion  CONSTANT VARCHAR2(250)  := 'OSF-2884';

    --------------------------------------------
    -- Variables PRIVADAS DEL PAQUETE

    -- Definicion de metodos publicos y privados del paquete

    FUNCTION fsbVersion  return varchar2 IS
    BEGIN
        Return csbVersion;
    END;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : GetEconomicActivity
    Descripcion	   : Obtiene la Actividad EconÃ³mica del contrato.

                    Retorna   Actividad EconÃ³mica

    Fecha          : 28-11-2014

    Parametros          Descripcion
    ============        ===================
    inuSubscriberId     Identificador del Cliente

    Historia de Modificaciones
    Fecha            Autor                  Modificacion
    =========        =========              ====================
    28-11-2014       emontenegro.SAO295858  CreaciÃ³n
    ******************************************************************/
    FUNCTION GetEconomicActivity (inuSubscriptionId  in suscripc.susccodi%type)
    RETURN pe_eco_act_contract.economic_activity_id%type
    IS

         CURSOR cuEconomicAct (inuSubscriptionId  in suscripc.susccodi%type)
         IS
            SELECT  economic_activity_id
            FROM    pe_eco_act_contract
                    /*+ ubicaciÃ³n: PE_BCECONOMICACTIVITY.GetEconomicActivity SAO295858 */
            WHERE  subscription_id = inuSubscriptionId;

          nuEconomicActivity  pe_eco_act_contract.economic_activity_id%type;

    BEGIN
        ut_trace.trace('Inicio: [PE_BCECONOMICACTIVITY.GetEconomicActivity]',10);
        ut_trace.trace('[inuSubscriptionId] '||inuSubscriptionId,10);

        --Cierra cursor
        IF  cuEconomicAct%ISOPEN THEN
            CLOSE cuEconomicAct;
        END IF;

        open cuEconomicAct(inuSubscriptionId);

        fetch cuEconomicAct
        into nuEconomicActivity;

        close cuEconomicAct;

        ut_trace.trace('[FIN] PE_BCECONOMICACTIVITY.GetEconomicActivity:['||nuEconomicActivity||']',10);
        return nuEconomicActivity;
    EXCEPTION
        when ex.CONTROLLED_ERROR THEN
          if(cuEconomicAct%isopen) then
                close cuEconomicAct;
            end if;
            ut_trace.trace('EXCEPTION CONTROLLED_ERROR PE_BCECONOMICACTIVITY.GetEconomicActivity', 2);
            RAISE;
        when OTHERS THEN
            if(cuEconomicAct%isopen) then
                close cuEconomicAct;
            end if;
            ut_trace.trace('EXCEPTION OTHERS PE_BCECONOMICACTIVITY.GetEconomicActivity', 2);
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END GetEconomicActivity;

END PE_BCECONOMICACTIVITY;
/
Prompt Otorgando permisos sobre ADM_PERSON.PE_BCECONOMICACTIVITY
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('PE_BCECONOMICACTIVITY'), 'ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.PE_BCECONOMICACTIVITY to REXEOPEN;
/
