CREATE OR REPLACE PACKAGE adm_person.PE_BOTaskTypeTax
IS
/*******************************************************************************
Paquete	    :   PE_BOTaskTypeTax
DescripciÃ³n :

Autor	    :   Reinel Gamboa LÃ³pez
Fecha       :   04-10-2016 17:33:19

Historia de Modificaciones
Fecha	    IDEntrega

24/02/2017     rgamboa.SAO409490
Se modifica "GetOrderData".

12/12/2016     rgamboa.SAO402354
Se publica informacion de la orden costeada para que sea usado por el trigger "trg_aurOr_Order_01"

04/10/2016     rgamboa.SAO396720
CreaciÃ³n
*******************************************************************************/


    csbFULL_TAX     constant    ge_parameter.parameter_id%type :=  'PE_RETENTION_FULLTAX';
    csbPARTIAL_TAX  constant    ge_parameter.parameter_id%type :=  'PE_RETENTION_PARTTAX';
    -- Cadena para identificar tipos de trabajo con ambos tipos de retenciÃ³n
    csbERROR        constant    ge_parameter.parameter_id%type :=  'ERROR';


    -- Retorna el Sao con que se realizÃ³ la ultima entrega
    FUNCTION fsbVersion  return varchar2;


    /**************************************************************
    Unidad      :  GetItemPrice
    Descripcion :  Obtiene el costo de un item, es invocado por el
                   trigger TRG_aurOr_Order_Items.

    Autor       :  Reinel Gamboa Lopez
    Fecha       :  23-02-2016
    Parametros  :
        inuOrderItemsId:    Identificador de items de la orden
        inuOrderId:         Identificador de la orden
        ionuTotalPrice:     Precio total del item


    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    23-02-2016   RGamboa.SAO409090  CreaciÃ³n

    ***************************************************************/

    PROCEDURE GetItemPrice
    (
        inuOrderItemsId in      or_order_items.order_items_id%type,
        inuOrderId      in      or_order.order_id%type,
        ionuTotalPrice 	in out  or_order_items.total_price%type
    );


END PE_BOTaskTypeTax;
/
CREATE OR REPLACE PACKAGE BODY adm_person.PE_BOTaskTypeTax
IS
/*******************************************************************************
Paquete	    :   PE_BOTaskTypeTax
DescripciÃ³n :

Autor	    :   Reinel Gamboa LÃ³pez
Fecha       :   04-10-2016 17:33:19

Historia de Modificaciones
Fecha	    IDEntrega

24/02/2017     rgamboa.SAO409490
Se modifica "GetOrderData".

24/02/2017     rgamboa.SAO409090
Se eliminan los metodos "LoadRetentionType", "LoadCache" y "UpdatePrice".
Se crean los metodos "GetOrderData" y "GetItemPrice".

12/12/2016     rgamboa.SAO402354
Se publica informacion de la orden costeada para que sea usado por el trigger "trg_aurOr_Order_01"

04/10/2016     rgamboa.SAO396720
CreaciÃ³n
*******************************************************************************/

    -- InformaciÃ³n asociado a la orden
    type tyrcOrderInfo is record
	(
        nuOrderId          or_order.order_id%type,
        nuTaxPercentage    number,
        sbRetentionType    ge_parameter.parameter_id%type,
        nuAUI_ADMIN        ldc_configuracionAIU.Valor_Aui_Admin%type,
        nuAUI_UTIL         ldc_configuracionAIU.Valor_Aui_Util%type
    );

    -- Cache informaciÃ³n asociado a la orden
    grcOrderInfo            tyrcOrderInfo;

    --------------------------------------------
    -- Constantes
    --------------------------------------------
    -- Declaracion de constantes privados del paquete

    -- Constante que indica el Ãºltimo Sao con el que se modificÃ³ el paquete
    csbVersion   CONSTANT VARCHAR2(20) := 'OSF-2884';



    /***************************************************************************
    Function    :  fsbVersion
    Descripcion :  Retorna el Ãºltimo Sao con el que se modificÃ³ el paquete
    Autor	    :  Reinel Gamboa LÃ³pez
    Fecha	    :  04-10-2016 17:33:19
    Parametros  :

    Retorno     :
    Historia de Modificaciones
    Fecha	    IDEntrega
    04/10/2016     rgamboa.SAO396720
    [DescripciÃ³n de la ModificaciÃ³n.]
    ***************************************************************************/
    FUNCTION fsbVersion  return varchar2 IS
    BEGIN
        return csbVersion;
    END fsbVersion;



    /**************************************************************
    Unidad      :  GetOrderData
    Descripcion :

    Autor       :  Reinel Gamboa Lopez
    Fecha       :  23-02-2016
    Parametros  :
        inuOrderId:         Identificador de la orden
        osbRetentionType:   Tipo de retencion
        onuTaxPercentage:   Retorna el porcentaje de iva asociado al tipo de trababjo
        onuAUI_ADMIN:       Valor AUI Administrativa
        onuAUI_UTIL:        Valor AUI Utilidades

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    23-02-2016   RGamboa.SAO409490  Se corrige redaccion del mensaje de error
    23-02-2016   RGamboa.SAO409090  CreaciÃ³n

    ***************************************************************/

    PROCEDURE GetOrderData
    (
        inuOrderId          in  or_order.order_id%type,
        osbRetentionType    out ge_parameter.parameter_id%type,
        onuTaxPercentage    out number,
        onuAUI_ADMIN        out ldc_configuracionAIU.Valor_Aui_Admin%type,
        onuAUI_UTIL         out ldc_configuracionAIU.Valor_Aui_Util%type

    )
    IS
        nuAUI_IMPREV        ldc_configuracionAIU.Valor_Aui_Imprev%type;
        nuContractor        ge_contratista.id_contratista%type;
        nuTaskType          or_order.task_type_id%type;
        tbTypes             ge_tytbString;
        sbFullTypes         ge_parameter.value%type;
        sbPartialTypes      ge_parameter.value%type;
    BEGIN
    --{
        ut_trace.trace('Inicio [PE_BOTaskTypeTax.GetOrderData]', 15);

        tbTypes := ge_tytbString();

        if ( grcOrderInfo.nuOrderId = inuOrderId ) then

            ut_trace.trace('se obtienen datos de cache', 20);

            onuTaxPercentage := grcOrderInfo.nuTaxPercentage;
            osbRetentionType := grcOrderInfo.sbRetentionType;
            onuAUI_ADMIN     := grcOrderInfo.nuAUI_ADMIN;
            onuAUI_UTIL      := grcOrderInfo.nuAUI_UTIL;

        else

            nuTaskType := daor_order.fnuGetTask_Type_Id(inuOrderId);

            -- Obtiene el porcentaje de iva asociado al tipo de trabajo
            PE_BCTaskTypeTax.GetTaxValue(nuTaskType,onuTaxPercentage);

            if ( onuTaxPercentage IS not null AND onuTaxPercentage > 0 ) then

                sbFullTypes := dage_parameter.fsbGetValue(csbFULL_TAX,0);
                sbPartialTypes := dage_parameter.fsbGetValue(csbPARTIAL_TAX,0);

                PE_BCTaskTypeTax.LoadRetentionType(nuTaskType,tbTypes);

                if ( tbTypes.first is not null ) then
                    for  nuIndex in tbTypes.first .. tbTypes.last loop

                        if ( instr('|'||sbFullTypes||'|','|'||tbTypes(nuIndex)||'|') > 0 ) then
                            if ( osbRetentionType = csbPARTIAL_TAX ) then
                                osbRetentionType := csbERROR;
                                exit;
                            elsif ( osbRetentionType is null ) then
                                osbRetentionType := csbFULL_TAX;
                            end if;
                        end if;

                        if ( instr('|'||sbPartialTypes||'|','|'||tbTypes(nuIndex)||'|') > 0 ) then
                            if ( osbRetentionType = csbFULL_TAX ) then
                                osbRetentionType := csbERROR;
                                exit;
                            elsif ( osbRetentionType is null ) then
                                osbRetentionType := csbPARTIAL_TAX;
                            end if;
                        end if;

                    end loop;
                end if;


                if ( osbRetentionType = csbERROR ) then

                    ge_boerrors.seterrorcodeargument
                    (   2741,
                        'El clasificador contable del tipo de trabajo ['||nuTaskType||'-'||daor_task_type.fsbgetdescription(nuTaskType)
                            ||'] aplica tanto para IVA pleno como para IVA sobre utilidad'
                    );

                elsif ( osbRetentionType = csbPARTIAL_TAX ) then

                    LDC_Acta.obtenerAIU
                    (
                        inuOrderId,
                        nuContractor,
                        onuAUI_ADMIN,
                        nuAUI_IMPREV,
                        onuAUI_UTIL
                    );

                    if ( onuAUI_ADMIN = 0 ) then
                        onuAUI_ADMIN := 1;
                    end if;

                end if;

            end if;

            grcOrderInfo.nuTaxPercentage    := onuTaxPercentage;
            grcOrderInfo.sbRetentionType    := osbRetentionType;
            grcOrderInfo.nuAUI_ADMIN        := onuAUI_ADMIN;
            grcOrderInfo.nuAUI_UTIL         := onuAUI_UTIL;
            grcOrderInfo.nuOrderId          := inuOrderId;

            ut_trace.trace('se almacena en cache', 20);

        end if;

        ut_trace.trace('onuTaxPercentage    :['||onuTaxPercentage||']', 20);
        ut_trace.trace('osbRetentionType    :['||osbRetentionType||']', 20);
        ut_trace.trace('onuAUI_ADMIN        :['||onuAUI_ADMIN||']', 20);
        ut_trace.trace('onuAUI_UTIL         :['||onuAUI_UTIL||']', 20);

        ut_trace.trace('Fin    [PE_BOTaskTypeTax.GetOrderData]', 15);
    --}
    EXCEPTION
    --{
        when ex.CONTROLLED_ERROR then
            ut_trace.trace('ex.CONTROLLED_ERROR [PE_BOTaskTypeTax.GetOrderData]', 15);
    	    raise ex.CONTROLLED_ERROR;

        when OTHERS then
            Errors.SetError;
            ut_trace.trace('OTHERS [PE_BOTaskTypeTax.GetOrderData]', 15);
            raise ex.CONTROLLED_ERROR;
    --}
    END GetOrderData;


    /**************************************************************
    Unidad      :  GetItemPrice
    Descripcion :  Obtiene el costo de un item, es invocado por el
                   trigger TRG_aurOr_Order_Items.

    Autor       :  Reinel Gamboa Lopez
    Fecha       :  23-02-2016
    Parametros  :
        inuOrderItemsId:    Identificador de items de la orden
        inuOrderId:         Identificador de la orden
        ionuTotalPrice:     Precio total del item


    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    23-02-2016   RGamboa.SAO409090  CreaciÃ³n

    ***************************************************************/

    PROCEDURE GetItemPrice
    (
        inuOrderItemsId in      or_order_items.order_items_id%type,
        inuOrderId      in      or_order.order_id%type,
        ionuTotalPrice 	in out  or_order_items.total_price%type
    )
    IS
        nuTaskType          or_order.task_type_id%type;
        sbRetentionType     ge_parameter.parameter_id%type;
        nuTaxValue          or_order.order_value%type := 0;
        nuTaxPercentage     number;
        nuAUI_ADMIN         ldc_configuracionAIU.Valor_Aui_Admin%type;
        nuAUI_UTIL          ldc_configuracionAIU.Valor_Aui_Util%type;

    BEGIN
    --{
        ut_trace.trace('Inicio [PE_BOTaskTypeTax.GetItemPrice]', 15);

        GetOrderData(inuOrderId,sbRetentionType,nuTaxPercentage,nuAUI_ADMIN,nuAUI_UTIL);


        if ( sbRetentionType = csbFULL_TAX ) then
            ut_trace.trace('[Calculo IVA pleno]',20);
            /* Calculo IVA pleno: (Costo_Total_Orden*Porcentaje_IVA) */
            nuTaxValue := ionuTotalPrice*nuTaxPercentage;
        elsif ( sbRetentionType = csbPARTIAL_TAX ) then
            ut_trace.trace('[Calculo IVA sobre la utilidad]',20);
            /* Calculo IVA sobre la utilidad: ((Costo_Total_Orden/Porcentaje_AIU)*Porcentaje_Utilidad*Porcentaje_IVA) */
            nuTaxValue := (ionuTotalPrice/nuAUI_ADMIN)*nuAUI_UTIL*nuTaxPercentage;
        end if;

        ut_trace.trace
        (
            '['||lpad(inuOrderItemsId,15,' ')||
            '['||nuTaxValue||']'||
            '['||sbRetentionType||']'||
            ']total_price['||ionuTotalPrice||
            ']+tax['||nuTaxValue||']',
            20
        );

        ionuTotalPrice := ionuTotalPrice + nuTaxValue;

        --
        ut_trace.trace('Fin    [PE_BOTaskTypeTax.GetItemPrice]', 15);
    --}
    EXCEPTION
    --{
        when ex.CONTROLLED_ERROR then
            ut_trace.trace('ex.CONTROLLED_ERROR [PE_BOTaskTypeTax.GetItemPrice]', 15);
    	    raise ex.CONTROLLED_ERROR;

        when OTHERS then
            Errors.SetError;
            ut_trace.trace('OTHERS [PE_BOTaskTypeTax.GetItemPrice]', 15);
            raise ex.CONTROLLED_ERROR;
    --}
    END GetItemPrice;



END PE_BOTaskTypeTax;
/
Prompt Otorgando permisos sobre ADM_PERSON.PE_BOTaskTypeTax
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('PE_BOTaskTypeTax'), 'ADM_PERSON');
END;
/