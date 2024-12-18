CREATE OR REPLACE PACKAGE adm_person.LD_BOReadingOrderData AS

    /***************************************************************************
    Package: LD_BOReadingOrder

    Descripción:    Métodos y funciones para obtener información de la órden
                    con la que se registra una lectura.

    Autor: Alejandro Cárdenas.
    Fecha: Septiembre 23/2014

    Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    23/07/2024     PAcosta         OSF-2952: Cambio de esquema ADM_PERSON
    23-09-2014     acardenas       Creación. RQ663

    ***************************************************************************/

    ----------------------------------------------------------------------------
    -- Constantes
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    -- Cursores
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    -- Variables
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    -- Funciones y Procedimientos
    ----------------------------------------------------------------------------

    FUNCTION fsbVersion return varchar2;

    /***************************************************************************
     Método :       LoadOrderAttribs
     Descripción:   Carga los atributos de la consulta de la órden
                    de lectura

     Autor       :  Alejandro Cárdenas
     Fecha       :  23-09-2014

     Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    23-09-2014     acardenas       Creación. RQ663
    ***************************************************************************/

    PROCEDURE  LoadOrderAttribs;

    /***************************************************************************
     Método :       GetReadingOrder
     Descripción:   Retorna CURSOR referenciado con los datos de la órden con
                    la que se registró la lectura

     Autor       :  Alejandro Cárdenas
     Fecha       :  23-09-2014

     Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    23-09-2014     acardenas       Creación. RQ663
    ***************************************************************************/

    PROCEDURE GetReadingOrder
    (
        inuReadingId     IN     lectelme.leemcons%type,
        orfOrderData    OUT     constants.tyRefCursor
    );

    /***************************************************************************
     Método :       GetReadingId
     Descripción:   Retorna el identificador de la lectura (Padre de Hijo)

     Autor       :  Alejandro Cárdenas
     Fecha       :  23-09-2014

     Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    23-09-2014     acardenas       Creación. RQ1169
    ***************************************************************************/


    PROCEDURE GetReadingId
    (
        inuOrderActId    IN     OR_order_activity.order_activity_id%type,
        onuReadingId    OUT     lectelme.leemcons%type
    );


END LD_BOReadingOrderData;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LD_BOReadingOrderData AS

    /***************************************************************************
    Package: LD_BOReadingOrder

    Descripción:    Métodos y funciones para obtener información de la órden
                    con la que se registra una lectura.

    Autor: Alejandro Cárdenas.
    Fecha: Septiembre 23/2014

    Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    23-09-2014     acardenas       Creación. RQ663

    ***************************************************************************/

    ----------------------------------------------------------------------------
    -- Constantes
    ----------------------------------------------------------------------------
    -- Esta constante se debe modificar cada vez que se entregue el paquete
    csbVersion  CONSTANT VARCHAR2(250)  := 'RQ663';

    ----------------------------------------------------------------------------
    -- Variables
    ----------------------------------------------------------------------------

  	/*Variables Globales*/

  	gsbOrderAttributes  varchar2(32000);

  	-- CURSOR  de Lectura
    CURSOR cuReading(nuOrderActId   OR_order_Activity.order_activity_id%type)
    IS
        SELECT  leemcons
        FROM    lectelme, OR_order_activity
        WHERE   leemsesu = product_id
                AND leemdocu = nuOrderActId
                AND rownum = 1;


    ----------------------------------------------------------------------------
    -- Funciones y Procedimientos
    ----------------------------------------------------------------------------

    FUNCTION fsbVersion
    return varchar2
    IS
    BEGIN
        return csbVersion;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;

        when others then
            ERRORS.seterror;
            raise ex.CONTROLLED_ERROR;
    END fsbVersion;

   /***************************************************************************
     Método :       LoadOrderAttribs
     Descripción:   Carga los atributos de la consulta de la órden de lectura

     Autor       :  Alejandro Cárdenas
     Fecha       :  23-09-2014

     Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    23-09-2014     acardenas       Creación. RQ663
    ***************************************************************************/

    PROCEDURE LoadOrderAttribs
    IS
    BEGIN

    ut_trace.trace('INICIO [LD_BOReadingOrderData.LoadOrderAttribs]',8);

    gsbOrderAttributes :=
        'SELECT OR_order.order_id                                               Orden,
                OR_order_activity.order_activity_id                             Actividad_Orden,
                lectelme.leemcons                                               Lectura,
                OR_order_activity.product_id                                    Producto,
                OR_order_activity.activity_id||'' - ''||ge_items.description    Actividad,
                OR_order.task_type_id||'' - ''||OR_task_type.description        Tipo_Trabajo,
                OR_order.order_status_id||'' - ''||or_order_status.description  Estado_Orden,
                OR_order.operating_unit_id||'' - ''||or_operating_unit.name     Unidad_Trabajo,
                OR_order.causal_id||'' - ''||ge_causal.description              Causal,
                OR_order.created_date                                           Fecha_Creacion,
                OR_order.assigned_date                                          Fecha_Asign,
                OR_order.legalization_date                                      Fecha_Legal,
                OR_order.exec_initial_date                                      Fecha_Inicio,
                OR_order.execution_final_date                                   Fecha_Fin
        FROM    OR_order_activity,
                OR_order,
                OR_task_type,
                or_operating_unit,
                or_order_status,
                ge_items,
                ge_causal,
                lectelme
        WHERE   OR_order_activity.order_id = OR_order.order_id
                AND OR_order_activity.activity_id = ge_items.items_id
                AND OR_order.task_type_id = OR_task_type.task_type_id
                AND OR_order.operating_unit_id = or_operating_unit.operating_unit_id
                AND OR_order.causal_id = ge_causal.causal_id
                AND OR_order.order_status_id = or_order_status.order_status_id
                AND lectelme.leemdocu = OR_order_activity.order_activity_id';

    ut_trace.trace('FIN [LD_BOReadingOrderData.LoadOrderAttribs]',8);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;

    END LoadOrderAttribs;



   /***************************************************************************
     Método :       GetReadingOrder
     Descripción:   Retorna CURSOR referenciado con los datos de la órden con
                    la que se registró la lectura

     Autor       :  Alejandro Cárdenas
     Fecha       :  23-09-2014

     Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    23-09-2014     acardenas       Creación. RQ663
    ***************************************************************************/

    PROCEDURE GetReadingOrder
    (
        inuReadingId     IN     lectelme.leemcons%type,
        orfOrderData    OUT     constants.tyRefCursor
    )
    IS
        -- Consulta
        sbQuery     varchar2(32000);

    BEGIN

        ut_trace.trace('Inicio [LD_BOReadingOrderData.GetReadingOrder]', 8);

        ut_trace.trace('Id de Lectura ['|| inuReadingId || ']', 9 );

        -- Carga lista de atributos a consultar
        LoadOrderAttribs;

        -- Adiciona filtro
        sbQuery :=  gsbOrderAttributes
                    ||chr(10)||'AND lectelme.leemcons = :reading_id';

        -- Ejecuta sentencia
        open orfOrderData for sbQuery using inuReadingId;

        ut_trace.trace('Sentencia ['|| sbQuery || ']', 9 );

        ut_trace.trace('Fin [LD_BOReadingOrderData.GetReadingOrder]', 8);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END GetReadingOrder;


    /***************************************************************************
     Método :       GetReadingId
     Descripción:   Retorna el identificador de la lectura (Padre de Hijo)

     Autor       :  Alejandro Cárdenas
     Fecha       :  23-09-2014

     Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    23-09-2014     acardenas       Creación. RQ663
    ***************************************************************************/

    PROCEDURE GetReadingId
    (
        inuOrderActId    IN     OR_order_activity.order_activity_id%type,
        onuReadingId    OUT     lectelme.leemcons%type
    )
    IS
    BEGIN

        ut_trace.trace('Inicio [LD_BOReadingOrderData.GetReadingId]', 8);

        ut_trace.trace('Actividad Orden ['|| inuOrderActId || ']', 9 );

        -- Obtiene la lectura asociada a la actividad orden
        if(cuReading%isopen) then
            close  cuReading;
        END if;

        open cuReading(inuOrderActId);
        fetch  cuReading INTO onuReadingId;
        close cuReading;

        ut_trace.trace('Fin [LD_BOReadingOrderData.GetReadingId]', 8);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END GetReadingId;


END LD_BOReadingOrderData;
/
PROMPT Otorgando permisos de ejecucion a LD_BOREADINGORDERDATA
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BOREADINGORDERDATA', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LD_BOREADINGORDERDATA para reportes
GRANT EXECUTE ON adm_person.LD_BOREADINGORDERDATA TO rexereportes;
/