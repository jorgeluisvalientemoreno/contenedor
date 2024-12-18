CREATE OR REPLACE PACKAGE ADM_PERSON.LD_BOLASTSUSPENSIONDATA AS

    /***************************************************************************
    Package: LD_BOLastSuspension

    Descripción:    Métodos y funciones para obtener información de la última
                    actividad de suspensión del producto.

    Autor: Alejandro Cárdenas.
    Fecha: Septiembre 22/2014

    Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    22-09-2014     acardenas       Creación. RQ1169
    15-04-2016     KCienfuegos     Se crea método <<fsbUltLecOrdSuspension>> (CA200-2015)

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
     Método :       LoadLastSuspenAttribs
     Descripción:   Carga los atributos de la consulta de la última
                    actividad de suspensión del producto

     Autor       :  Alejandro Cárdenas
     Fecha       :  22-09-2014

     Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    22-09-2014     acardenas       Creación. RQ1169
    ***************************************************************************/

    PROCEDURE  LoadLastSuspenAttribs;

    /***************************************************************************
     Método :       GetLastSuspension
     Descripción:   Retorna CURSOR referenciado con los datos de la última
                    actividad de suspensión del producto

     Autor       :  Alejandro Cárdenas
     Fecha       :  22-09-2014

     Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    22-09-2014     acardenas       Creación. RQ1169
    ***************************************************************************/

    PROCEDURE GetLastSuspension
    (
        inuProductId    IN      pr_product.product_id%type,
        orfSuspenData   OUT     constants.tyRefCursor

    );

    /***************************************************************************
     Método :       GetProductId
     Descripción:   Retorna el identificador del producto (Padre de Hijo)

     Autor       :  Alejandro Cárdenas
     Fecha       :  22-09-2014

     Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    22-09-2014     acardenas       Creación. RQ1169
    ***************************************************************************/


    PROCEDURE GetProductId
    (
        inuOrderActId    IN     OR_order_activity.order_activity_id%type,
        onuProductId    OUT     pr_product.product_id%type

    );

    /*****************************************************************
    Propiedad intelectual de CSC.

    Unidad         : fsbUltLecOrdSuspension
    Descripcion    : Función para obtener la lectura de la última orden de suspensión.
    Autor          : KCienfuegos
    Caso           : CA200-215
    Fecha          : 15/04/2016

    Parametros           Descripcion
    ============       ===================
    nuProduct            Producto

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    ******************************************************************/
    FUNCTION fsbUltLecOrdSuspension(nuProduct  or_order_activity.product_id%type)
    RETURN VARCHAR2;


END LD_BOLASTSUSPENSIONDATA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LD_BOLASTSUSPENSIONDATA AS

    /***************************************************************************
    Package: LD_BOLastSuspension

    Descripción:    Métodos y funciones para obtener información de la última
                    actividad de suspensión del producto.

    Autor: Alejandro Cárdenas.
    Fecha: Septiembre 22/2014

    Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    22-09-2014     acardenas       Creación. RQ1169
    15-04-2016     KCienfuegos     Se crea método <<fsbUltLecOrdSuspension>> (CA200-2015)

    ***************************************************************************/

    ----------------------------------------------------------------------------
    -- Constantes
    ----------------------------------------------------------------------------
    -- Esta constante se debe modificar cada vez que se entregue el paquete
    csbVersion  CONSTANT VARCHAR2(250)  := 'RQ1169';

    ----------------------------------------------------------------------------
    -- Variables
    ----------------------------------------------------------------------------

  	/*Variables Globales*/

  	gsbLastSuspenAttributes  varchar2(32000);

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
     Método :       LoadLastSuspenAttribs
     Descripción:   Carga los atributos de la consulta de la última
                    actividad de suspensión del producto

     Autor       :  Alejandro Cárdenas
     Fecha       :  22-09-2014

     Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    22-09-2014     acardenas       Creación. RQ1169
    ***************************************************************************/

    PROCEDURE LoadLastSuspenAttribs
    IS
    BEGIN

    ut_trace.trace('INICIO [LD_BOLastSuspensionData.LoadLastSuspenAttribs]',8);

    -- Verifica si ya se cargaron los atributos

    /*
    if  gsbLastSuspenAttributes IS not null then
        return;
    END IF; */

    gsbLastSuspenAttributes :=
    'SELECT OR_order.order_id                                                Orden,
            OR_order_activity.order_activity_id                              Actividad_Orden,
            pr_product.product_id                                            Producto,
            OR_order_activity.activity_id||'' - ''||ge_items.description     Actividad,
            OR_order.task_type_id||'' - ''||OR_task_type.description         Tipo_Trabajo,
            OR_order.order_status_id||'' - ''||or_order_status.description   Estado_Orden,
            OR_order.created_date                                            Fecha_Creacion,
            OR_order.assigned_date                                           Fecha_Asign,
            OR_order.legalization_date                                       Fecha_Legal,
            OR_order.operating_unit_id||'' - ''||or_operating_unit.name      Unidad_Trabajo,
            OR_order.causal_id||'' - ''||ge_causal.description               Causal,
            ge_causal.causal_type_id||'' - ''||ge_causal_type.description    Tipo_Causal,
            ge_causal.class_causal_id||'' - ''||ge_class_causal.description  Clase_Causal
    FROM    OR_order_activity,
            OR_order,
            OR_task_type,
            or_operating_unit,
            or_order_status,
            ge_items,
            ge_causal,
            ge_causal_type,
            ge_class_causal,
            pr_product
    WHERE   OR_order_activity.product_id = pr_product.product_id
            AND OR_order_activity.order_activity_id = pr_product.suspen_ord_act_id
            AND OR_order_activity.order_id = OR_order.order_id
            AND OR_order_activity.activity_id = ge_items.items_id
            AND OR_order.task_type_id = OR_task_type.task_type_id
            AND OR_order.operating_unit_id = or_operating_unit.operating_unit_id
            AND OR_order.causal_id = ge_causal.causal_id
            AND OR_order.order_status_id = or_order_status.order_status_id
            AND ge_causal.causal_type_id = ge_causal_type.causal_type_id
            AND ge_causal.class_causal_id = ge_class_causal.class_causal_id';


    ut_trace.trace('FIN [LD_BOLastSuspensionData.LoadLastSuspenAttribs]',8);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;

    END LoadLastSuspenAttribs;



   /***************************************************************************
     Método :       GetLastSuspension
     Descripción:   Retorna CURSOR referenciado con los datos de la última
                    actividad de suspensión del producto

     Autor       :  Alejandro Cárdenas
     Fecha       :  22-09-2014

     Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    22-09-2014     acardenas       Creación. RQ1169
    ***************************************************************************/

    PROCEDURE GetLastSuspension
    (
        inuProductId    IN      pr_product.product_id%type,
        orfSuspenData   OUT     constants.tyRefCursor
    )
    IS
        -- Consulta
        sbQuery     varchar2(32000);

    BEGIN

        ut_trace.trace('Inicio [LD_BOLastSuspensionData.GetLastSuspension]', 8);

        ut_trace.trace('Producto ['|| inuProductId || ']', 9 );

        -- Carga lista de atributos a consultar
        LoadLastSuspenAttribs;

        -- Adiciona filtro
        sbQuery :=  gsbLastSuspenAttributes
                    ||chr(10)||'AND pr_product.product_id = :Product_id';

        -- Ejecuta sentencia
        open orfSuspenData for sbQuery using inuProductId;

        ut_trace.trace('Sentencia ['|| sbQuery || ']', 9 );

        ut_trace.trace('Fin [LD_BOLastSuspensionData.GetLastSuspension]', 8);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END GetLastSuspension;


    /***************************************************************************
     Método :       GetProductId
     Descripción:   Retorna el identificador del producto (Padre de Hijo)

     Autor       :  Alejandro Cárdenas
     Fecha       :  22-09-2014

     Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    22-09-2014     acardenas       Creación. RQ1169
    ***************************************************************************/

    PROCEDURE GetProductId
    (
        inuOrderActId    IN     OR_order_activity.order_activity_id%type,
        onuProductId    OUT     pr_product.product_id%type

    )
    IS
    BEGIN

        ut_trace.trace('Inicio [LD_BOLastSuspensionData.GetProductId]', 8);

        ut_trace.trace('Actividad Orden ['|| inuOrderActId || ']', 9 );

        -- Obtiene el producto asociado a la actividad orden

        onuProductId := daor_order_activity.fnugetproduct_id(inuOrderActId);

        ut_trace.trace('Fin [LD_BOLastSuspensionData.GetProductId]', 8);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END GetProductId;

    /*****************************************************************
    Propiedad intelectual de CSC.

    Unidad         : fsbUltLecOrdSuspension
    Descripcion    : Función para obtener la lectura de la última orden de suspensión.
    Autor          : KCienfuegos
    Caso           : CA200-215
    Fecha          : 15/04/2016

    Parametros           Descripcion
    ============       ===================
    nuProduct            Producto

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    ******************************************************************/
    FUNCTION fsbUltLecOrdSuspension(nuProduct  or_order_activity.product_id%type)
    RETURN VARCHAR2 IS

        sbValor Varchar2(1000);

        CURSOR cuUltLectura IS
          SELECT l.leemleto
            FROM or_order_activity a, pr_product p, lectelme l
           WHERE a.order_activity_id = p.suspen_ord_act_id
             AND a.product_id = p.product_id
             AND a.order_activity_id = l.leemdocu
             AND p.product_id = nuProduct;
    BEGIN

        OPEN cuUltLectura;
        FETCH cuUltLectura INTO sbValor;
        IF cuUltLectura%NOTFOUND THEN
          sbValor := ' - ';
        END IF;
        CLOSE cuUltLectura;

        -- Retorna el valor obtenido
        RETURN sbValor;

    EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
          RETURN ' - ';
      WHEN OTHERS THEN
          RETURN ' - ';
    END fsbUltLecOrdSuspension;

END LD_BOLASTSUSPENSIONDATA;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LD_BOLASTSUSPENSIONDATA', 'ADM_PERSON');
END;
/
