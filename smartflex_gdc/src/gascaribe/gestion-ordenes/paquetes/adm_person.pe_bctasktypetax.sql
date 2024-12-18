CREATE OR REPLACE PACKAGE adm_person.PE_BCTaskTypeTax
IS
/*******************************************************************************
Paquete	    :   PE_BCTaskTypeTax
Descripción :

Autor	    :   Reinel Gamboa López
Fecha       :   04-10-2016 17:33:19

Historia de Modificaciones
Fecha	    IDEntrega

04/10/2016     rgamboa.SAO396720
[Descripción de la Modificación.]
*******************************************************************************/

    -- Retorna el Sao con que se realizó la ultima entrega
    FUNCTION fsbVersion  return varchar2;


    /**************************************************************
    Unidad      :  LoadRetentionType
    Descripcion :  Retorna los tipos de retencion de un tipo de trabajo

    Autor       :  Reinel Gamboa Lopez
    Fecha       :  07-10-2016
    Parametros  :
            iotbTypes   Tipos de retencion

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    24-02-2017   RGamboa.SAO409090  Se modifica para consultar los tipos de
                                    retencion de un tipo d etrabajo
    07-10-2016   RGamboa.SAO396720  Creacion

    ***************************************************************/
    PROCEDURE LoadRetentionType
    (
        inuTaskTypeId   in  or_task_type.task_type_id%type,
        iotbItems       in out nocopy  ge_tytbString
    );

    /**************************************************************
    Unidad      :  GetTaxValue
    Descripcion :  Retorna el porcentaje de IVA de un tipo de trabajo

    Autor       :  Reinel Gamboa Lopez
    Fecha       :  07-10-2016
    Parametros  :
            inuTaskTypeId   Tipo de trabajo
            onuValue        Porcentaje de IVA

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    24-02-2017   RGamboa.SAO409090  Se corrige tipo en variable onuValue
    07-10-2016   RGamboa.SAO396720  Creacion

    ***************************************************************/
    PROCEDURE GetTaxValue
    (
        inuTaskTypeId   in  OR_order.task_type_id%type,
        onuValue        out pe_task_type_tax.tax_percentaje%type
    );


END PE_BCTaskTypeTax;
/
CREATE OR REPLACE PACKAGE BODY adm_person.PE_BCTaskTypeTax
IS
/*******************************************************************************
Paquete	    :   PE_BCTaskTypeTax
Descripción :

Autor	    :   Reinel Gamboa López
Fecha       :   04-10-2016 17:33:19

Historia de Modificaciones
Fecha	    IDEntrega

LoadRetentionType

04/10/2016     rgamboa.SAO396720
[Descripción de la Modificación.]
24/02/2017     rgamboa.SAO409090
Se modifican "LoadRetentionType" y "GetTaxValue"
*******************************************************************************/

    --------------------------------------------
    -- Constantes
    --------------------------------------------
    -- Declaracion de constantes privados del paquete

    -- Constante que indica el último Sao con el que se modificó el paquete
    csbVersion   CONSTANT VARCHAR2(20) := 'OSF-2884';



    /***************************************************************************
    Function    :  fsbVersion
    Descripcion :  Retorna el último Sao con el que se modificó el paquete
    Autor	    :  Reinel Gamboa López
    Fecha	    :  04-10-2016 17:33:19
    Parametros  :

    Retorno     :
    Historia de Modificaciones
    Fecha	    IDEntrega
    04/10/2016     rgamboa.SAO396720
    [Descripción de la Modificación.]
    ***************************************************************************/
    FUNCTION fsbVersion  return varchar2 IS
    BEGIN
        return csbVersion;
    END fsbVersion;



    /**************************************************************
    Unidad      :  LoadRetentionType
    Descripcion :  Retorna los tipos de retencion de un tipo de trabajo

    Autor       :  Reinel Gamboa Lopez
    Fecha       :  07-10-2016
    Parametros  :
            iotbTypes   Tipos de retencion

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    24-02-2017   RGamboa.SAO409090  Se modifica para consultar los tipos de
                                    retencion de un tipo d etrabajo
    07-10-2016   RGamboa.SAO396720  Creacion

    ***************************************************************/
    PROCEDURE LoadRetentionType
    (
        inuTaskTypeId   in  or_task_type.task_type_id%type,
        iotbItems       in out nocopy  ge_tytbString
    )
    IS

        CURSOR  cuRetentionType IS
            SELECT  /*+
                        ordered
                        use_nl (ic_clascott)
                        use_nl (ldc_construction_service)
                    */
                    distinct
                    ldc_construction_service.type_
            FROM    ic_clascott,
                    ldc_construction_service
                    /*+ PE_BCTaskTypeTax.LoadRetentionType SAO409090 */
            WHERE   ic_clascott.clcttitr = inuTaskTypeId
                AND ic_clascott.clctclco = ldc_construction_service.clas_contable;

    BEGIN
    --{
        ut_trace.trace('Inicio [PE_BCTaskTypeTax.LoadRetentionType]', 20);

        for rcRetentionType in cuRetentionType loop
            iotbItems.extend(1);
            iotbItems(iotbItems.last) := rcRetentionType.type_;
        end loop;

        ut_trace.trace('Fin    [PE_BCTaskTypeTax.LoadRetentionType]', 20);
    --}
    EXCEPTION
    --{
        when ex.CONTROLLED_ERROR then
            ut_trace.trace('ex.CONTROLLED_ERROR [PE_BCTaskTypeTax.LoadRetentionType]', 20);
    	    raise ex.CONTROLLED_ERROR;

        when OTHERS then
            Errors.SetError;
            ut_trace.trace('OTHERS [PE_BCTaskTypeTax.LoadRetentionType]', 20);
            raise ex.CONTROLLED_ERROR;
    --}
    END LoadRetentionType;

    /**************************************************************
    Unidad      :  GetTaxValue
    Descripcion :  Retorna el porcentaje de IVA de un tipo de trabajo

    Autor       :  Reinel Gamboa Lopez
    Fecha       :  07-10-2016
    Parametros  :
            inuTaskTypeId   Tipo de trabajo
            onuValue        Porcentaje de IVA

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    24-02-2017   RGamboa.SAO409090  Se corrige tipo en variable onuValue
    07-10-2016   RGamboa.SAO396720  Creacion

    ***************************************************************/
    PROCEDURE GetTaxValue
    (
        inuTaskTypeId   in  OR_order.task_type_id%type,
        onuValue        out pe_task_type_tax.tax_percentaje%type
    )
    IS
        CURSOR cuGetTaxValue IS
            SELECT  tax_percentaje
            FROM    pe_task_type_tax
                    /*+ PE_BCTaskTypeTax.GetTaxValue SAO409090 */
            WHERE   pe_task_type_tax.task_type_id = inuTaskTypeId;

    BEGIN
    --{
        ut_trace.trace('Inicio [PE_BCTaskTypeTax.GetTaxValue]', 20);

        open  cuGetTaxValue;
        fetch cuGetTaxValue INTO onuValue;
        close cuGetTaxValue;

        onuValue := onuValue/100.0;

        ut_trace.trace('Fin    [PE_BCTaskTypeTax.GetTaxValue]('||onuValue||')', 20);
    --}
    EXCEPTION
    --{
        when ex.CONTROLLED_ERROR then
            ut_trace.trace('ex.CONTROLLED_ERROR [PE_BCTaskTypeTax.GetTaxValue]', 20);
            if ( cuGetTaxValue%isopen ) then
                close cuGetTaxValue;
            end if;
    	    raise ex.CONTROLLED_ERROR;

        when OTHERS then
            if ( cuGetTaxValue%isopen ) then
                close cuGetTaxValue;
            end if;
            Errors.SetError;
            ut_trace.trace('OTHERS [PE_BCTaskTypeTax.GetTaxValue]', 20);
            raise ex.CONTROLLED_ERROR;
    --}
    END GetTaxValue;


END PE_BCTaskTypeTax;
/
Prompt Otorgando permisos sobre ADM_PERSON.PE_BCTaskTypeTax
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('PE_BCTaskTypeTax'), 'ADM_PERSON');
END;
/