CREATE OR REPLACE PACKAGE adm_person.LDC_ReportesConsulta
IS
    /*****************************************************************
    Propiedad intelectual de PROYECTO PETI

    Package  : LDC_ReportesConsulta
    Descripci?n  : Empaquetamiento de consultas para reportes

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1

    Historia de Modificaciones

    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
	31/07/2024				cgonzalez		OSF-3056: Adicionar permisos de ejecucion para el rol REXEOPEN
    15/07/2024              PAcosta         OSF-2885: Cambio de esquema ADM_PERSON   
                                            Retiro marcacion esquema .open objetos de lógica 
    24/09/2014              carlosr.Arqs    Se modifica el método fnuGetLastRead

    ******************************************************************/

    --------------------------------------------
    -- Constantes GLOBALES Y PUBLICAS DEL PAQUETE
    --------------------------------------------
    --c<mnemonicoTipoDato>NOMBRECONSTANTEN            TIPODATO := VALOR;

    --------------------------------------------
    -- Variables GLOBALES Y PUBLICAS DEL PAQUETE
    --------------------------------------------
    --<mnemonicoTipoDato>NOMBREVARIABLEN             TIPODATO;
    TYPE atributo IS RECORD
    (
      NAME_ATTRIBUTE    ge_attributes.name_attribute%type,
      attribute_set_id  ge_attrib_set_attrib.attribute_set_id%type
    );
    TYPE tytbAtributos IS TABLE OF atributo INDEX BY BINARY_INTEGER ;

    --------------------------------------------
    -- Funciones y Procedimientos PUBLICAS DEL PAQUETE
    --------------------------------------------
    FUNCTION FSBVERSION
    RETURN VARCHAR2;

    FUNCTION GeograpLocationFather ( nugeograp_location_id ge_geogra_location.geograp_location_id%type ) return number;
    FUNCTION DescriptionGeograpLocation ( nugeograp_location_id ge_geogra_location.geograp_location_id%type ) return varchar2;
    FUNCTION DescriptionPackageType ( nupackage_type_id ps_package_type.package_type_id%type ) return varchar2;
    FUNCTION NameOperatingUnit ( nuOperating_unit_id or_operating_unit.operating_unit_id%type ) return varchar2;
    FUNCTION DescriptionOrderStatus ( nuorder_status_id or_order_status.order_status_id%type ) return varchar2;
    FUNCTION DescriptionProductStatus ( nuProduct_status_id ps_Product_status.product_status_id%type ) return varchar2;
    FUNCTION DescriptionTaskType ( nutask_type_id OR_task_type.task_type_id%type ) return varchar2;
    FUNCTION DescriptionCausal ( nucausal_id ge_causal.causal_id%type ) return varchar2;
    FUNCTION DescriptionOperatingSector ( nuOperating_sector_id or_operating_sector.operating_sector_id%type ) return varchar2;
    FUNCTION SubscriberName ( nusubscriber_id ge_subscriber.subscriber_id%type ) return varchar2;
    FUNCTION PlanComercial ( numotive_id mo_motive.motive_id%type ) return number;
    FUNCTION DescriptionPlanComercial ( nucommercial_plan_id CC_commercial_plan.commercial_plan_id%type ) return varchar2;
    FUNCTION DescriptionCiclo ( nuCiclo_id ciclo.ciclcodi%type ) return varchar2;
    FUNCTION FechaInstalacion ( nuProducto servsusc.sesunuse%type ) return date;
    FUNCTION fnuEstadoTecnicoProducto ( nuproduct_id pr_product.product_id%type ) return number;
    FUNCTION fsbEstadoFinancieroProducto( nuproduct_id servsusc.sesunuse%type ) return varchar2;
    FUNCTION fnuTelefonoProducto ( nuproduct_id pr_product.product_id%type ) return number;
    FUNCTION fnuMedidorProducto (inuProducto servsusc.sesunuse%type) return varchar2;
    FUNCTION fnuLecturaAnterior (inuProducto servsusc.sesunuse%type) return number;
    FUNCTION fnuLecturaActual (inuProducto servsusc.sesunuse%type) return number;
    FUNCTION fsbNombreGe_Person ( nuPerson_id ge_person.person_id%type ) return varchar2;
    FUNCTION fsbDescTipoRecepcion ( nuId GE_RECEPTION_TYPE.RECEPTION_TYPE_ID%type ) return varchar2;
    FUNCTION fnuObtenerTotal (nuse number,fecha date,cons_pro number, mes1 number,mes2 number,mes3 number,mes4 number,mes5 number,mes6 number,mes7 number,mes8 number,mes9 number,mes10 number,mes11 number,mes12 number)return number;
    FUNCTION fnuObtenerTarifa (numserv cargos.cargnuse%type,consumo number,fecha date,concepto concepto.conccodi%type) return number;
    FUNCTION fsbDireccion(address_id ab_address.address_id%type ) return varchar2;
    FUNCTION fsbObservacionOT(nuORDER OR_ORDER_COMMENT.ORDER_ID%type )return varchar2;
    FUNCTION fsbDescConcepto ( nuConcepto concepto.conccodi%type ) return varchar2;
    FUNCTION fsbDamagesByComponent(inuCargnuse cargos.CARGNUSE%type, inuMes number, inuAnio number)RETURN varchar2;
    FUNCTION fdtGetDatePeriod (idtDate date, inuCicle number,  inuDate number) RETURN date;
    FUNCTION ftytbGetAttributes (inuTipoTrab number) RETURN tytbAtributos;
    FUNCTION fnuGetConsumoPromedioAnio(inuProducto servsusc.sesunuse%type, inuPeriodofact conssesu.cosspefa%type)RETURN NUMBER;
    FUNCTION fnuGetPeriFact(inuContrato suscripc.susccodi%type, idtFechaSusp  DATE) RETURN NUMBER;
    FUNCTION fnuTraeReferencia ( nuSubsId GE_SUBS_REFEREN_DATA.subscriber_id%type, nuTypeRef Ge_Subs_Referen_Data.reference_type_id%type ) return varchar2;
    FUNCTION fnuTraeTelefonos ( nuSubsId GE_SUBS_PHONE.subscriber_id%type ) return varchar2;
    FUNCTION fnuTraeCategorias ( nuSesususc servsusc.sesususc%type ) return varchar2;
    FUNCTION fnuCupoBrilla( nuContrato suscripc.susccodi%type) RETURN NUMBER;
    FUNCTION fsbConceptosDiferido( nuSusc suscripc.susccodi%type, inuMeses NUMBER) RETURN VARCHAR2;
    FUNCTION fsbObsActivity(inuOrden or_order.order_id%type) return varchar2;
    FUNCTION fsbGetRefinanc(inuSusc suscripc.susccodi%type) RETURN NUMBER;
    FUNCTION fsbGetLdc_Osf_Sesucier(inucur IN NUMBER, inuano IN LDC_OSF_SESUCIER.NUANO%TYPE, inumes IN LDC_OSF_SESUCIER.NUMES%TYPE, inueda IN LDC_OSF_SESUCIER.EDAD%TYPE, inucar IN NUMBER) RETURN NUMBER;
    FUNCTION fnuVentasBrilla(nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type, nuFechai mo_packages.REQUEST_DATE%type, nuFechaf mo_packages.REQUEST_DATE%type) RETURN NUMBER;
    FUNCTION fnuHabitoPago(nusesunuse servsusc.sesunuse%type,nusesususc servsusc.sesususc%type,nusesuserv servsusc.sesuserv%type,nuano1 NUMBER,numes1 NUMBER) RETURN VARCHAR2;
    FUNCTION fnuVentasBrillaTotales(nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type) RETURN NUMBER;
    FUNCTION fnuVentasBrillaCantidad(nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type) RETURN NUMBER;
    FUNCTION fnuVentasBrillaProductos(nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type) RETURN VARCHAR2;
    FUNCTION fnuVecesConsumoRecuperado(nuYEAR NUMBER, nuMONTH NUMBER, nuSESUNUSE NUMBER, nuPEFACICL NUMBER) RETURN NUMBER;
    FUNCTION fnuCupousado(nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type) RETURN NUMBER;

    /**********************************************************************
        Nombre  :   fnuGetCountTotals
        Autor   :   Carlos Alberto Ram?rez

        Descripci?n : Retorna el total de Productos, Contratos y Clientes dependiendo
                     del tipo que se recibe como par?metro

        Historia de Modificaciones
        Fecha         Autor             Modificaci?n
        ============  ================  ===============================
        26-11-2013   carlosr
        Se hace el conteo por ciclo

        26-Sep-2013   carlosr          Creaci?n
    ***********************************************************************/
    FUNCTION fnuGetCountTotals
    (
         inuType  IN   number,
         inuCycle    ciclo.ciclcodi%type,
         inuProdType in servicio.servcodi%type default null
    )
    return number;

    /**********************************************************************
        Nombre  :   fsbObsNotasCartera
        Autor   :   C?sar Burbano

        Descripci?n :   Retorna una cadena con las notas creadas en las fechas
                        dadas que afectaron la diferencia entre el proyecto
                        de castigo de cartera y lo realmente castigado

        Historia de Modificaciones
        Fecha         Autor             Modificaci?n
        ============  ================  ===============================
        23-Sep-2013   cesaburb          Creaci?n
    ***********************************************************************/
    FUNCTION fsbObsNotasCartera
    (
        inuProducto     in  pr_product.product_id%type,
        idtFecInicial   in  date,
        idtFecFinal     in  date
    )
    return varchar2;

    /**********************************************************************
        Nombre  :   fsbObsPagosCartera
        Autor   :   C?sar Burbano

        Descripci?n :   Retorna una cadena con los pagos creadas en las fechas
                        dadas que afectaron la diferencia entre el proyecto
                        de castigo de cartera y lo realmente castigado

        Historia de Modificaciones
        Fecha         Autor             Modificaci?n
        ============  ================  ===============================
        23-Sep-2013   cesaburb          Creaci?n
    ***********************************************************************/
    FUNCTION fsbObsPagosCartera
    (
        inuProducto     in  pr_product.product_id%type,
        idtFecInicial   in  date,
        idtFecFinal     in  date
    )
    return varchar2;

    /**********************************************************************
        Nombre  :   fsbObsFinancCartera
        Autor   :   C?sar Burbano

        Descripci?n :   Retorna una cadena con las financiaciones creadas en
                        las fechas dadas que afectaron la diferencia entre el
                        proyecto de castigo de cartera y lo realmente castigado

        Historia de Modificaciones
        Fecha         Autor             Modificaci?n
        ============  ================  ===============================
        23-Sep-2013   cesaburb          Creaci?n
    ***********************************************************************/
    FUNCTION fsbObsFinancCartera
    (
        inuProducto     in  pr_product.product_id%type,
        idtFecInicial   in  date,
        idtFecFinal     in  date
    )
    return varchar2;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetProdbyEstCor
    Descripci?n    : Retorna el total de productos por tipo de producto y estado de
                     corte
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuServicio Tipo de Producto
        inuEstacort Estado de Corte


    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-11-2013   carlosr
    Se hace el conteo por ciclo

    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetProdbyEstCor
    (
        inuServicio IN servicio.servcodi%type,
        inuEstacort IN estacort.escocodi%type,
        inuCycle    ciclo.ciclcodi%type
    )
    RETURN number;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetProdbyProdStat
    Descripci?n    : Retorna el total de productos por estado de producto y tipo
                     de servicio
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuProdStatus Estado del Producto
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-11-2013   carlosr
    Se hace el conteo por ciclo

    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetProdbyProdStat
    (
        inuProdStatus IN ps_product_status.product_status_id%type,
        inuServicio IN servicio.servcodi%type,
        inuCycle    ciclo.ciclcodi%type
    )
    RETURN number;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetProdbyFinaState
    Descripci?n    : Retorna el total de productos por estado financiero y tipo
                     de servicio
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuFinanStat Estado Financiero del Producto
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-11-2013   carlosr
    Se hace el conteo por ciclo

    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetProdbyFinaState
    (
        inuFinanStat IN servsusc.sesuesfn%type,
        inuServicio IN servicio.servcodi%type,
        inuCycle    ciclo.ciclcodi%type
    )
    RETURN number;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetReadProducts
    Descripci?n    : Retorna el total de productos con lectura
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-11-2013   carlosr
    Se hace el conteo por ciclo

    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetReadProducts
    (
        inuperifact IN perifact.pefacodi%type,
        inuServicio IN servicio.servcodi%type,
        inuType     IN number
    )
    RETURN number;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetCritConsProd
    Descripci?n    : Retorna el total de productos con lectura
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetCritConsProd
    (
        inuperifact IN perifact.pefacodi%type,
        inuServicio IN servicio.servcodi%type
    )
    RETURN number;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetChargeByServ
    Descripci?n    : Retorna el total de cargos de un servicio en un periodo
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetChargeByServ
    (
        inuperifact IN perifact.pefacodi%type,
        inuServicio IN servicio.servcodi%type
    )
    RETURN number;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetCounts
    Descripci?n    : Retorna el total de cuentas de cobro de un servicio en un
                     periodo
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetCounts
    (
        inuperifact IN perifact.pefacodi%type,
        inuServicio IN servicio.servcodi%type
    )
    RETURN number;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetBills
    Descripci?n    : Retorna el total de facturas de un servicio en un periodo
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetBills
    (
        inuperifact IN perifact.pefacodi%type,
        inuServicio IN servicio.servcodi%type
    )
    RETURN number;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetBillCons
    Descripci?n    : Retorna el total de facturas de un servicio en un periodo
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetBillCons
    (
        inuperifact IN perifact.pefacodi%type,
        inuServicio IN servicio.servcodi%type
    )
    RETURN number;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetConsCharges
    Descripci?n    : Retorna el total de los cargos de consumo de un servicio en
                     un periodo
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetConsCharges
    (
        inuperifact IN perifact.pefacodi%type,
        inuServicio IN servicio.servcodi%type
    )
    RETURN number;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetTotbyServ
    Descripci?n    : Retorna el total facturado de un servicio en un periodo
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetTotbyServ
    (
        inuperifact IN perifact.pefacodi%type,
        inuServicio IN servicio.servcodi%type
    )
    RETURN number;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetTotbyPer
    Descripci?n    : Retorna el total facturado en un periodo
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetTotbyPer
    (
        inuperifact IN perifact.pefacodi%type
    )
    RETURN number;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetDebtManagementInfo
    Descripci?n    : Retorna el valor de Edad de la deuda, Deuda total, Deuda
                     Corriente Vencida, Deuda Corriente no Vencida, Deuda Diferida,
                     Deuda Castigada, seg?n el tipo que reciba como par?metro
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 04-10-2013

    Parametros         Descripcion
    ============  ===================
       inuSubscriberID     C?digo del Cliente
       inuSubscriptionID   C?digo del Contrato
       inuProductID        C?digo del Producto
       inuType             Tipo:
                                1 - Edad de la deuda
                                2 - Deuda total
                                3 - Deuda Corriente Vencida
                                4 - Deuda Corriente no Vencida
                                5 - Deuda Diferida
                                6 - Deuda Castigada

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    04-10-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetDebtMgrInfo
    (
        inuSubscriberID     IN  ge_subscriber.subscriber_id%type,
        inuSubscriptionID   IN  suscripc.susccodi%type,
        inuProductID        IN  pr_product.product_id%type,
        inuType             IN  number
    )
    RETURN number;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetHlemconsbyElme
    Descripci?n    : Retorna el identificador del hist?rico de lectura por c?digo
                     de HLEMELME. En caso de tener m?s de un registro, retorna
                     el primero (primera lectura)

    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 21-11-2013

    Parametros         Descripcion
    ============  ===================
       inuHlemelme     C?digo de lectura por elemento de medici?n

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    21-11-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetHlemconsbyElme
    (
        inuHlemelme     IN  hileelme.hlemelme%type,
        inuType         in  number default 1
    )
    RETURN hileelme.hlemcons%type;
    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuBarrio
    Descripci?n    : Retorna el identificador del barrio de un contrato, cliente
                     o producto

    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 04-12-2013

    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    -----------  -------------------    -------------------------------------

    04-12-2013   carlosr
    Creacion
    ******************************************************************/
    FUNCTION  fnuBarrio
    (
        nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
        nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
        nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type
    )
    return number;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fsbGetPhones
    Descripci?n    : Retorna los telefonos de un cliente

    Autor          : Carlos Alberto Ramirez Herrera
    Fecha          : 04-12-2013

    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    -----------  -------------------    -------------------------------------

    04-12-2013   carlosr
    Creacion
    ******************************************************************/
    FUNCTION  fsbGetPhones
    (
        nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type
    )
    return varchar2;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuCountHlemconsbyElme
    Descripci?n    : Cuenta el total de registros que hay por lectura

    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 05-12-2013

    Parametros         Descripcion
    ============  ===================
       inuHlemelme     C?digo de lectura por elemento de medici?n

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    21-11-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuCountHlemconsbyElme
    (
        inuHlemelme     IN  hileelme.hlemelme%type
    )
    RETURN hileelme.hlemcons%type;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fsbGetPromotions
    Descripci?n    : retorna el total de promociones asignadas a una solicitud

    Autor          : Carlos Alberto Ramirez Herrera
    Fecha          : 17-12-2013

    Parametros         Descripcion
    ============  ===================
       inuMotive_id     Codigo del motivo

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    17-12-2013   carlosr
    Creacion
    ******************************************************************/
    FUNCTION fsbGetPromotions
    (
        inuMotive_id     IN  mo_motive.motive_id%type
    )
    RETURN varchar2;

    /*****************************************************************
    Propiedad intelectual de LDC (c).

    Unidad         : fnuGetDefRecaM
    Descripci?n    : Retorna el valor de los diferidos o del recargo por mora del
                 producto o contrato

    Autor          : Carlos Alberto Ramirez Herrera
    Fecha          : 28-01-2014

    Parametros         Descripcion
    ============	===================

    Historia de Modificaciones

    28-01-2014  carlosr
    Creacion

    ******************************************************************/
    FUNCTION fnuGetDefRecaM
    (
        inuSesu  in servsusc.sesunuse%type,
        inuSusc  in suscripc.susccodi%type,
        inutype  in Number  -- 1-Diferido 2-Recargo por Mora
    )
    RETURN number;

    /*****************************************************************
    Propiedad intelectual de LDC (c).

    Unidad         : fnuGetLastRead
    Descripción    : Retorna el valor de de la última lectura que no fue facturada
                     por el método de estimación

    Autor          : Carlos Alberto Ramirez Herrera
    Fecha          : 16-06-2014

    Parametros         Descripcion
    ============	===================

    Historia de Modificaciones

    16-06-2014  carlosr
    Creacion

    ******************************************************************/
    FUNCTION fnuGetLastRead
    (
        inuperifact in perifact.pefacodi%type,
        inuservsusc in servsusc.sesunuse%type
    )
    RETURN number;

END LDC_ReportesConsulta;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_ReportesConsulta
IS
    /*****************************************************************
    Propiedad intelectual de PROYECTO PETI

    Package  : LDC_ReportesConsulta
    Descripci?n  : Empaquetamiento de consultas para reportes
        Se crea este metodo para encapsular los llamados a primer nivel, con el
        objetivo de otorgar solo grant execute sobre m?todos que realizan consultas.

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1

    Historia de Modificaciones

    -----------  -------------------    -------------------------------------
    24/09/2014  carlosr.Arqs
    Se modifica el método fnuGetLastRead

    ******************************************************************/

    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    csbVERSION                  CONSTANT VARCHAR2(10) := 'REPO_V1';

    --------------------------------------------
    -- Constantes PRIVADAS DEL PAQUETE
    --------------------------------------------
    --c<mnemonicoTipoDato>NOMBRECONSTANTEN            TIPODATO := VALOR;

    nuProductTotal      number;
    nuSuscripTotal      number;
    nuSubscriberTotal   number;

    --------------------------------------------
    -- Variables PRIVADAS DEL PAQUETE
    --------------------------------------------
    --<mnemonicoTipoDato>NOMBREVARIABLE1             TIPODATO;

    type tytbTotalsOnMemoryQuant IS table of number index BY varchar2(12);

    tbChargeQuant           tytbTotalsOnMemoryQuant;
    tbCountQuant            tytbTotalsOnMemoryQuant;
    tbCountBills            tytbTotalsOnMemoryQuant;
    tbTotalConsu            tytbTotalsOnMemoryQuant;
    tbTotalConsCharg        tytbTotalsOnMemoryQuant;
    tbTotalValbyServ        tytbTotalsOnMemoryQuant;
    tbTotalValbyPeriod      tytbTotalsOnMemoryQuant;
    tbTotalReadProd         tytbTotalsOnMemoryQuant;
    tbTotalProdByEstCort    tytbTotalsOnMemoryQuant;
    tbTotalProdByEstProd    tytbTotalsOnMemoryQuant;
    tbTotalProdByEstFina    tytbTotalsOnMemoryQuant;
    tbTotalCritProd         tytbTotalsOnMemoryQuant;
    tbTotalReadProdR        tytbTotalsOnMemoryQuant;

    tbRecaMora  ut_string.TyTb_String;
    tbIntFinan  ut_string.TyTb_String;

    sbFinanConcepts     ld_parameter.value_chain%type;
    sbRecMorConcepts    ld_parameter.value_chain%type;
    nuPercentage        number;

    --------------------------------------------
    -- Funciones y Procedimientos PRIVADAS DEL PAQUETE
    --------------------------------------------

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  FSBVERSION
    Descripcion :  Obtiene la version del paquete

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    Parametros  :  Ninguno

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    26-07-2013    cdominguez.REPO_V1        Modificaci?n
    ***************************************************************/
    FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END FSBVERSION;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  GeograpLocationFather
    Descripcion :  Obtiene el Id de la ubicaci?n geografica padre

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    */
    FUNCTION GeograpLocationFather ( nugeograp_location_id ge_geogra_location.geograp_location_id%type )
    return number IS
        nuFather ge_geogra_location.geo_loca_father_id%type;
    BEGIN
        nuFather := null;
        nuFather := dage_geogra_location.fnuGetGeo_Loca_Father_Id(nugeograp_location_id);
        return nuFather;
    EXCEPTION
        when others then
        nuFather := null;
        return nuFather;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  DescriptionGeograpLocation
    Descripcion :  Obtiene descripci?n de la ubicaci?n geografica

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    */
    FUNCTION DescriptionGeograpLocation ( nugeograp_location_id ge_geogra_location.geograp_location_id%type )
    return varchar2 IS
        sbDescription ge_geogra_location.description%type;
    BEGIN
        sbDescription := null;
        sbDescription := dage_geogra_location.fsbgetdescription(nugeograp_location_id);
        return sbDescription;
    EXCEPTION
        when others then
        sbDescription := null;
        return sbDescription;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  DescriptionPackageType
    Descripcion :  Obtiene descripci?n del tipo de paquete tabla ps_packages_type

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    */
    FUNCTION DescriptionPackageType ( nupackage_type_id ps_package_type.package_type_id%type )
    return varchar2 IS
        sbDescription ps_package_type.description%type;
    BEGIN
        sbDescription := null;
        sbDescription := daps_package_type.fsbgetdescription(nupackage_type_id);
        return sbDescription;
    EXCEPTION
        when others then
        sbDescription := null;
        return sbDescription;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  NameOperatingUnit
    Descripcion :  Obtiene nombre de la unidad operativa tabla OR_operating_unit

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    */
    FUNCTION NameOperatingUnit ( nuOperating_unit_id or_operating_unit.operating_unit_id%type )
    return varchar2 IS
        sbDescription or_operating_unit.name%type;
    BEGIN
        sbDescription := null;
        sbDescription := Daor_operating_unit.Fsbgetname(nuOperating_unit_id);
        return sbDescription;
    EXCEPTION
        when others then
        sbDescription := null;
        return sbDescription;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  DescriptionOrderStatus
    Descripcion :  Obtiene descripci?n de la orden, tabla OR_order_status

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    */
    FUNCTION DescriptionOrderStatus ( nuorder_status_id or_order_status.order_status_id%type )
    return varchar2 IS
        sbDescription or_order_status.description%type;
    BEGIN
        sbDescription := null;
        sbDescription := daor_order_status.fsbgetdescription(nuorder_status_id);
        return sbDescription;
    EXCEPTION
        when others then
        sbDescription := null;
        return sbDescription;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  DescriptionProductStatus
    Descripcion :  Obtiene estado del producto, tabla ps_Product_status

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    */
    FUNCTION DescriptionProductStatus ( nuProduct_status_id ps_Product_status.product_status_id%type )
    return varchar2 IS
        sbDescription ps_Product_status.description%type;
    BEGIN
        sbDescription := null;
        sbDescription := Daps_product_status.Fsbgetdescription(nuProduct_status_id);
        return sbDescription;
    EXCEPTION
        when others then
        sbDescription := null;
        return sbDescription;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  DescriptionTaskType
    Descripcion :  Obtiene descripci?n del tipo de trabajo, tabla OR_task_type

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    */
    FUNCTION DescriptionTaskType ( nutask_type_id OR_task_type.task_type_id%type )
    return varchar2 IS
        sbDescription OR_task_type.description%type;
    BEGIN
        sbDescription := null;
        sbDescription := daOR_task_type.fsbgetdescription(nutask_type_id);
        return sbDescription;
    EXCEPTION
        when others then
        sbDescription := null;
        return sbDescription;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  DescriptionCausal
    Descripcion :  Obtiene descripci?n de la causa, tabla ge_causal

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    */
    FUNCTION DescriptionCausal ( nucausal_id ge_causal.causal_id%type )
    return varchar2 IS
        sbDescription ge_causal.description%type;
    BEGIN
        sbDescription := null;
        sbDescription := dage_causal.fsbgetdescription(nucausal_id);
        return sbDescription;
    EXCEPTION
        when others then
        sbDescription := null;
        return sbDescription;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  DescriptionCausal
    Descripcion :  Obtiene descripci?n de la causa, tabla ge_causal

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    */
    FUNCTION DescriptionOperatingSector ( nuOperating_sector_id or_operating_sector.operating_sector_id%type )
    return varchar2 IS
        sbDescription or_operating_sector.description%type;
    BEGIN
        sbDescription := null;
        sbDescription := Daor_operating_sector.fsbgetdescription(nuOperating_sector_id);
        return sbDescription;
    EXCEPTION
        when others then
        sbDescription := null;
        return sbDescription;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  SubscriberName
    Descripcion :  Obtiene nombre de contrato, tabla ge_subscriber

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    */
    FUNCTION SubscriberName ( nusubscriber_id ge_subscriber.subscriber_id%type )
    return varchar2 IS
        sbNombre varchar2(2000);
    BEGIN
        sbNombre := null;
        sbNombre := GE_BOSubscriber.fsbgetname(nusubscriber_id);
        return sbNombre;
    EXCEPTION
        when others then
        sbNombre := null;
        return sbNombre;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  PlanComercial
    Descripcion :  Obtiene id Plan comercial de un motivo, tabla mo_motive

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    */
    FUNCTION PlanComercial ( numotive_id mo_motive.motive_id%type )
    return number IS
        nuPlanComercial mo_motive.commercial_plan_id%type;
    BEGIN
        nuPlanComercial := null;
        nuPlanComercial := damo_motive.fnugetcommercial_plan_id(numotive_id);
        return nuPlanComercial;
    EXCEPTION
        when others then
        nuPlanComercial := null;
        return nuPlanComercial;
    END;


    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuEstadoTecnicoProducto
    Descripcion :  Obtiene el estado tecnico del producto, tabla pr_product

    Autor  : Miguel Angel Lopez Santos
    Fecha  : 31-07-2013 (Fecha Creacion Paquete)  Peti_v1
    */
    FUNCTION fnuEstadoTecnicoProducto ( nuproduct_id pr_product.product_id%type )
    return number IS
        nuEstadoTecnico pr_product.product_status_id%type;
    BEGIN
        nuEstadoTecnico := null;
        nuEstadoTecnico :=  dapr_product.fnugetproduct_status_id(nuproduct_id);
        return nuEstadoTecnico;
    EXCEPTION
        when others then
        nuEstadoTecnico := null;
        return nuEstadoTecnico;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fsbEstadoFinancieroProducto
    Descripcion :  Obtiene el estado tecnico del producto, tabla servsusc

    Autor  : Miguel Angel Lopez Santos
    Fecha  : 06-08-2013 (Fecha Creacion Paquete)  Peti_v1
    */
    FUNCTION fsbEstadoFinancieroProducto( nuproduct_id servsusc.sesunuse%type )
    return varchar2 IS
        nuEstadoFinanciero servsusc.sesuesfn%type;
    BEGIN
        nuEstadoFinanciero := null;
        nuEstadoFinanciero := pktblservsusc.fsbgetsesuesfn(nuproduct_id);
        return nuEstadoFinanciero;
    EXCEPTION
        when others then
        nuEstadoFinanciero := null;
        return nuEstadoFinanciero;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuTelefonoProducto
    Descripcion :  Obtiene telefono de contacto del producto, tabla pr_product

    Autor  : Miguel Angel Lopez Santos
    Fecha  : 31-07-2013 (Fecha Creacion Paquete)  Peti_v1
    */
    FUNCTION fnuTelefonoProducto ( nuproduct_id pr_product.product_id%type )
    return number IS
        nuTelefono pr_product.subs_phone_id%type;
    BEGIN
        nuTelefono := null;
        nuTelefono :=  dapr_product.fnugetsubs_phone_id(nuproduct_id);
        return nuTelefono;
    EXCEPTION
        when others then

        nuTelefono := null;
        return nuTelefono;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  DescriptionPlanComercial
    Descripcion :  Obtiene nombre Plan comercial , tabla CC_commercial_plan

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    */
    FUNCTION DescriptionPlanComercial ( nucommercial_plan_id CC_commercial_plan.commercial_plan_id%type )
    return varchar2 IS
        sbPlanComercial CC_commercial_plan.description%type;
    BEGIN
        sbPlanComercial := null;
        sbPlanComercial := DACC_commercial_plan.fsbgetdescription(nucommercial_plan_id);
        return sbPlanComercial;
    EXCEPTION
        when others then
        sbPlanComercial := null;
        return sbPlanComercial;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  DescriptionCiclo
    Descripcion :  Obtiene descripci?n de ciclo facturaci?n, tabla ciclo

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    return varchar2 IS
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    */
    FUNCTION DescriptionCiclo ( nuCiclo_id ciclo.ciclcodi%type )
    RETURN varchar2
    IS
      sbCicloDesc ciclo.cicldesc%type;
    BEGIN

        sbCicloDesc := null;
        sbCicloDesc := Pktblciclo.Fsbgetcicldesc(nuCiclo_id);
        return sbCicloDesc;
    EXCEPTION
        when others then
        sbCicloDesc := null;
        return sbCicloDesc;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  FechaInstalacion
    Descripcion :  Obtiene fecha de instalacion de producto, tabla servsusc

    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    */
    FUNCTION FechaInstalacion ( nuProducto servsusc.sesunuse%type )
    return date IS
        dtFechaInstall servsusc.sesufein%type;
    BEGIN
        dtFechaInstall := null;
        dtFechaInstall := Pktblservsusc.fdtgetsesufein(nuProducto);
        return dtFechaInstall;
    EXCEPTION
        when others then
        dtFechaInstall := null;
        return dtFechaInstall;
    END;


    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuMedidorProducto
    Descripcion :  Obtiene medidor del producto

    Autor  : Miguel Angel Lopez Santos
    Fecha  : 31-07-2013 (Fecha Creacion Paquete)  Peti_v1
    */
    FUNCTION fnuMedidorProducto (inuProducto servsusc.sesunuse%type)
    return varchar2
    IS
        OTBELEMMEDI    pkBCElemMedi.TYRCTBELEMMEDI;
        nuElemento     elemmedi.elmecodi%type;
        nuIndice       numbeR;
        sbSerie        ge_items_seriado.serie%type;

        cursor cuSerie(idItem number) is
           select serie from GE_ITEMS_SERIADO t where t.id_items_seriado=idItem;

    BEGIN
        IF ( inuProducto IS not null)  then
            pkBCElemMedi.GETELEMMEDIBYPRODUCT(inuProducto,sysdate,OTBELEMMEDI);
            nuIndice := OTBELEMMEDI.TBELMEIDEM.first;
            if nuIndice is not null then
               nuElemento := OTBELEMMEDI.TBELMEIDEM(nuIndice);
               sbSerie := '-';
               if nuElemento is not null then
                  for i in cuSerie(nuElemento)loop
                      sbSerie := i.serie;
                  end loop;
               end if;
            end if;
        END IF;
        return sbSerie;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuMedidorProducto;


    /**************************************************************

    Propiedad intelectual de Open International Systems (c).
    Unidad      :  ObtieneLectura
    Descripcion :  Obtiene registro de lecturas
    Autor  : Carlos Andr?s Dominguez Naranjo - cadona
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    */
    FUNCTION ObtieneLectura (inuProducto servsusc.sesunuse%type)
    return LECTELME%ROWTYPE
  IS
        nuTipocon      LECTELME.LEEMTCON%TYPE;
      nuLEEMLEAN     LECTELME.LEEMLEAN%TYPE;
      dtLEEMFELA     LECTELME.LEEMFELA%TYPE;
      nuProducto     pr_product.product_id%type;
      OTBELEMMEDI    pkBCElemMedi.TYRCTBELEMMEDI;
      nuElemento     elemmedi.elmecodi%type;
      nuIndice       numbeR;
      rcLECTELME     LECTELME%ROWTYPE;

    BEGIN
        rcLECTELME := null;
        if ( inuProducto IS not null)  then
            pkBCElemMedi.GETELEMMEDIBYPRODUCT(inuProducto,sysdate,OTBELEMMEDI);
            nuIndice := OTBELEMMEDI.TBELMEIDEM.first;
            nuElemento := OTBELEMMEDI.TBELMEIDEM(nuIndice);
            if ( nuElemento  IS not null) then
                rcLECTELME := PKBCLECTELME.FRCGETLASTREAD (inuProducto,1,nuElemento,sysdate);
            END if;
        END if;

        return rcLECTELME;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ObtieneLectura;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  snuLecturaAnterior
    Descripcion :  Obtiene lectura anterior

    Autor  : Miguel Angel Lopez Santos
    Fecha  : 31-07-2013 (Fecha Creacion Paquete)  Peti_v1
    */
    FUNCTION fnuLecturaAnterior (inuProducto servsusc.sesunuse%type)
    return number
    IS
      nuLeemlean LECTELME.LEEMLEAN%TYPE;
      rcLECTELME     LECTELME%ROWTYPE;
    BEGIN
      rcLECTELME := ObtieneLectura (inuProducto);
      nuLeemlean := rcLECTELME.Leemlean;
      RETURN nuLeemlean;
    EXCEPTION
      WHEN OTHERS THEN
        RETURN NULL;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fsbLecturaActual
    Descripcion :  Obtiene lectura actual

    Autor  : Miguel Angel Lopez Santos
    Fecha  : 31-07-2013 (Fecha Creacion Paquete)  Peti_v1
    */
    FUNCTION fnuLecturaActual (inuProducto servsusc.sesunuse%type)
    return number
    IS
      nuleemleto LECTELME.leemleto%TYPE;
      rcLECTELME     LECTELME%ROWTYPE;
    BEGIN
      rcLECTELME := ObtieneLectura (inuProducto);
      nuleemleto := rcLECTELME.Leemleto;
      RETURN nuleemleto;
    EXCEPTION
      WHEN OTHERS THEN
        RETURN NULL;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fsbNombreGe_Person
    Descripcion :  Obtiene nombre de la persona, tabla ge_person

    Autor  : Miguel Angel Lopez Santos - Ludycom
    Fecha  : 01-08-2013 (Fecha Creacion Paquete)  Peti_v1
    */
    FUNCTION fsbNombreGe_Person ( nuPerson_id ge_person.person_id%type )
    return varchar2 IS
        sbnombre ge_person.name_%type;
    BEGIN
        sbnombre := null;
        sbnombre :=  Dage_Person.Fsbgetname_(nuPerson_id);
        return sbnombre;
    EXCEPTION
        when others then
        sbnombre := null;
        return sbnombre;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fsbNombreGe_Person
    Descripcion :  Obtiene nombre de la persona, tabla GE_RECEPTION_TYPE

    Autor  : Miguel Angel Lopez Santos - Ludycom
    Fecha  : 01-08-2013 (Fecha Creacion Paquete)  Peti_v1
    */
    FUNCTION fsbDescTipoRecepcion ( nuId GE_RECEPTION_TYPE.RECEPTION_TYPE_ID%type )
    return varchar2 IS
        sbnombre GE_RECEPTION_TYPE.DESCRIPTION%type;
    BEGIN
        sbnombre := null;
        sbnombre :=  DaGE_RECEPTION_TYPE.Fsbgetdescription(nuId);
        return sbnombre;
    EXCEPTION
        when others then
        sbnombre := null;
        return sbnombre;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuObtenerTotal
    Descripcion :  Obtiene el valor que dejo de perder la empresa despues de normalizar un usuario

    Autor  : Miguel Angel Lopez Santos - Ludycom
    Fecha  : 01-08-2013 (Fecha Creacion Paquete)  Peti_v1
    */
    FUNCTION fnuObtenerTotal(nuse number,fecha date,cons_pro number, mes1 number,mes2 number,mes3 number,mes4 number,mes5 number,mes6 number,mes7 number,mes8 number,mes9 number,mes10 number,mes11 number,mes12 number)
    return number IS
           suma number := 0;

    begin
      if mes1 > 0 then
        suma := suma + ((FNUOBTENERTARIFA(nuse,mes1,ADD_MONTHS(fecha,1),31) * mes1) -
                         (FNUOBTENERTARIFA(nuse,cons_pro,ADD_MONTHS(fecha,1),31) * cons_pro));
      end if;
      if mes2 > 0 then
        suma := suma + ((FNUOBTENERTARIFA(nuse,mes2,ADD_MONTHS(fecha,2),31) * mes2) -
                         (FNUOBTENERTARIFA(nuse,cons_pro,ADD_MONTHS(fecha,2),31) * cons_pro));
      end if;
      if mes3 > 0 then
        suma := suma + ((FNUOBTENERTARIFA(nuse,mes3,ADD_MONTHS(fecha,3),31) * mes3) -
                         (FNUOBTENERTARIFA(nuse,cons_pro,ADD_MONTHS(fecha,3),31) * cons_pro));
      end if;
      if mes4 > 0 then
        suma := suma + ((FNUOBTENERTARIFA(nuse,mes4,ADD_MONTHS(fecha,4),31) * mes4) -
                         (FNUOBTENERTARIFA(nuse,cons_pro,ADD_MONTHS(fecha,4),31) * cons_pro));
      end if;
      if mes5 > 0 then
        suma := suma + ((FNUOBTENERTARIFA(nuse,mes5,ADD_MONTHS(fecha,5),31) * mes5) -
                         (FNUOBTENERTARIFA(nuse,cons_pro,ADD_MONTHS(fecha,5),31) * cons_pro));
      end if;
      if mes6 > 0 then
        suma := suma + ((FNUOBTENERTARIFA(nuse,mes6,ADD_MONTHS(fecha,6),31) * mes6) -
                         (FNUOBTENERTARIFA(nuse,cons_pro,ADD_MONTHS(fecha,6),31) * cons_pro));
      end if;
      if mes7 > 0 then
        suma := suma + ((FNUOBTENERTARIFA(nuse,mes7,ADD_MONTHS(fecha,7),31) * mes7) -
                         (FNUOBTENERTARIFA(nuse,cons_pro,ADD_MONTHS(fecha,7),31) * cons_pro));
      end if;
      if mes8 > 0 then
        suma := suma + ((FNUOBTENERTARIFA(nuse,mes8,ADD_MONTHS(fecha,8),31) * mes8) -
                         (FNUOBTENERTARIFA(nuse,cons_pro,ADD_MONTHS(fecha,8),31) * cons_pro));
      end if;
      if mes9 > 0 then
        suma := suma + ((FNUOBTENERTARIFA(nuse,mes9,ADD_MONTHS(fecha,9),31) * mes9) -
                         (FNUOBTENERTARIFA(nuse,cons_pro,ADD_MONTHS(fecha,9),31) * cons_pro));
      end if;
      if mes10 > 0 then
        suma := suma + ((FNUOBTENERTARIFA(nuse,mes10,ADD_MONTHS(fecha,10),31) * mes10) -
                         (FNUOBTENERTARIFA(nuse,cons_pro,ADD_MONTHS(fecha,10),31) * cons_pro));
      end if;
      if mes11 > 0 then
        suma := suma + ((FNUOBTENERTARIFA(nuse,mes11,ADD_MONTHS(fecha,11),31) * mes11) -
                         (FNUOBTENERTARIFA(nuse,cons_pro,ADD_MONTHS(fecha,11),31) * cons_pro));
      end if;
      if mes12 > 0 then
        suma := suma + ((FNUOBTENERTARIFA(nuse,mes12,ADD_MONTHS(fecha,12),31) * mes12) -
                         (FNUOBTENERTARIFA(nuse,cons_pro,ADD_MONTHS(fecha,12),31) * cons_pro));
      end if;

       return suma;

    exception
      when others then
           return null;
    end;


  /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuObtenerTarifa
    Descripcion :  Obtiene el valor de la tarifa

    Autor  : Miguel Angel Lopez Santos - Ludycom
    Fecha  : 01-08-2013 (Fecha Creacion Paquete)  Peti_v1
    */
    FUNCTION fnuObtenerTarifa (numserv cargos.cargnuse%type,consumo number,fecha date,concepto concepto.conccodi%type)
    return number IS
         cursor cuDatos(nuse servsusc.sesunuse%type) is
             /*select se.sesucate, se.sesusuca
             from servsusc se
             where se.sesunuse = nuse;*/
             /*select se.sesucate, se.sesusuca, me.lomrmeco
             from servsusc se,
                  ciclo ci,
                  fa_locamere me
             where se.sesucicl = ci.ciclcodi
               and ci.ciclloca = me.lomrloid
               and se.sesunuse = nuse;*/
               select se.sesucate, se.sesusuca, me.lomrmeco
             from servsusc se,
                  pr_product pr,
                  ab_address di,
                  ciclo ci,
                  fa_locamere me
             where se.sesucicl = ci.ciclcodi
               and se.sesunuse = pr.product_id
               and pr.address_id = di.address_id
               and di.geograp_location_id = me.lomrloid
               and se.sesunuse = nuse;

         cursor curCons(cate number, suca number, fecha date,concepto number, mrelev number) is
               select distinct vt.vitccons
            from TA_CONFTACO c,
                 ta_tariconc tc,
                 ta_vigetaco vt
            where c.cotccons = tc.TACOCOTC
               and vt.vitctaco = tc.tacocons
               and tc.tacocr01= suca--subcategoria
               and tc.tacocr02= cate--categoria
               and tc.tacocr03= mrelev--mercado relevante
               and c.cotcconc = concepto --in (31 - CONSUMO, 37 - CONTRIBUCION, 196 - SUBSIDIO)
               and vt.vitcfein <= fecha
               and vt.vitcfefi >= fecha;

         cursor curValor(vigencia ta_vigetaco.vitccons%type,consumo number) is
            select rt.ravtvalo
            from ta_rangvitc rt
            where rt.ravtvitc = vigencia
               and rt.ravtliin <= consumo
               and rt.ravtlisu >= consumo;
    begin
      for regCurDatos in cuDatos(numserv) loop
          for regCurCons in curCons(regCurDatos.Sesucate,regCurDatos.Sesusuca,fecha,concepto,regCurDatos.lomrmeco) loop
              for regCurValor in curValor(regCurCons.Vitccons,consumo) loop
                  return regCurValor.Ravtvalo;
              end loop;
          end loop;
      end loop;
      return 0;
    end;

  /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fsbDireccion
    Descripcion :  Obtiene la direccion, tabla ab_address

    Autor  : Miguel Angel Lopez Santos
    Fecha  : 06-08-2013 (Fecha Creacion Paquete)  Peti_v1
    */
    FUNCTION fsbDireccion(address_id ab_address.address_id%type )
    return varchar2 IS
        sbDireccion ab_address.address%type;
    BEGIN
        sbDireccion := null;
        sbDireccion := daab_address.fsbgetaddress(address_id);
        return sbDireccion;
    EXCEPTION
        when others then
        sbDireccion := '-';
        return sbDireccion;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fsbDireccion
    Descripcion :  Obtiene la direccion, tabla ab_address

    Autor  : Miguel Angel Lopez Santos
    Fecha  : 06-08-2013 (Fecha Creacion Paquete)  Peti_v1
    */
    FUNCTION fsbObservacionOT(nuORDER OR_ORDER_COMMENT.ORDER_ID%type )
    return varchar2 IS
       CURSOR cuComments is
         SELECT CO.ORDER_COMMENT coment
         FROM OR_ORDER_COMMENT CO
         WHERE CO.ORDER_ID = nuORDER;
       sbOb  VARCHAR2(32767);
    BEGIN
      for regComments in cuComments loop
        if sbOb is null then
          sbOb := regComments.coment;
        else
          sbOb := sbOb || '-' || regComments.coment;
        end if;
      end loop;
      return sbOb;
    EXCEPTION
      WHEN OTHERS THEN
        RETURN '-';
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fsbDescConcepto
    Descripcion :  Obtiene descripcion de concepto

    Autor  : Miguel Angel Lopez Santos - Ludycom
    Fecha  : 26-07-2013 (Fecha Creaci?n Paquete)  Peti_v1
    */
    FUNCTION fsbDescConcepto ( nuConcepto concepto.conccodi%type )
    return varchar2 IS
        sbDescripcion concepto.concdesc%type;
    BEGIN
        sbDescripcion := null;
        sbDescripcion := Pktblconcepto.Fsbgetconcdesc(nuConcepto);
        return sbDescripcion;
    EXCEPTION
        when others then
        sbDescripcion := null;
        return sbDescripcion;
    END;


    /*******************************************************************************
    Propiedad intelectual de PROYECTO PETI
    Unidad      :  fsbDamagesByComponent
    Descripcion :  Obtiene los ids de los da?os a compensar de un componente en un periodo.

    Autor  : Cesar Figueroa
    Fecha  : 26-08-2013
    */

    FUNCTION fsbDamagesByComponent( inuCargnuse cargos.CARGNUSE%type, inuMes number, inuAnio number)
    RETURN varchar2
    IS
       CURSOR cuDamages is
         SELECT timout.PACKAGE_ID damage,
                packty.description descrip

         FROM pr_timeout_component timout,
              mo_packages pack,
              ps_package_type packty,
              pr_component comp

         WHERE timout.component_id = comp.COMPONENT_ID
         AND pack.package_id = timout.package_id
         AND TO_NUMBER(TO_CHAR(timout.INITIAL_DATE,'MM')) = inuMes
         AND TO_CHAR(timout.INITIAL_DATE, 'YYYY') = inuAnio
         AND pack.package_type_id = packty.package_type_id
         AND comp.PRODUCT_ID = inuCargnuse;

        sbids  VARCHAR2(32767);
    BEGIN
      for regComments in cuDamages loop
        if sbids is null then
          sbids := regComments.damage||':'||regComments.descrip;
        else
          sbids := sbids||' - '||regComments.damage||':'||regComments.descrip;
        end if;
      end loop;

      return sbids;

    EXCEPTION
      WHEN OTHERS THEN
        RETURN '-';
END;

   /*******************************************************************************
    Propiedad intelectual de PROYECTO PETI
    Unidad      :  fdtGetDatePeriod
    Descripcion :  Obtiene la fecha inicial o final de un periodo de consumo
                   inuDate = 1 -> retorna la fecha inicial del periodo
                   inuDate = 2 -> retorna la fecha final del periodo.

    Autor  : Cesar Figueroa
    Fecha  : 26-08-2013
    */

    FUNCTION fdtGetDatePeriod (idtDate date, inuCicle number,  inuDate number)
    RETURN date
    IS
        nuError     NUMBER;
        sbError     VARCHAR2(2000);
        result      date;

    BEGIN

    IF (inuDate = 1) THEN
        SELECT pecsfeci
        INTO result
        FROM pericose
        WHERE idtDate BETWEEN pecsfeci AND pecsfecf
            AND pecscico = inuCicle;
    ELSE

        SELECT pecsfecf
        INTO result
        FROM pericose
        WHERE idtDate BETWEEN pecsfeci AND pecsfecf
            AND pecscico = inuCicle;
    END IF;

     RETURN result;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
END;

  /*******************************************************************************
  Propiedad intelectual de PROYECTO PETI
  Unidad      :  ftytbGetAttributes
    Descripcion :  Obtiene los nombres de los campos adicionales de un tipo de
                   trabajo asociado a una orden de trabajo, con su identificador
                   de grupo de atributos.

    Autor  : Cesar Figueroa
    Fecha  : 23-09-2013
  */
  FUNCTION ftytbGetAttributes (inuTipoTrab number)
  RETURN tytbAtributos
    IS
        nuError     NUMBER;
        sbError     VARCHAR2(2000);
        tbAtributos tytbAtributos;
    BEGIN

    SELECT d.name_attribute, c.attribute_set_id
    BULK COLLECT INTO tbAtributos
      FROM or_tasktype_add_data a, ge_attributes_set b, ge_attrib_set_attrib c, ge_attributes d
      WHERE a.task_type_id =inuTipoTrab
         AND a.attribute_set_id =  b.attribute_set_id
         AND b.attribute_set_id =c.attribute_set_id
         AND c.attribute_id =d.attribute_id;

     RETURN tbAtributos;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
   END ftytbGetAttributes;

   /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetCountTotals
    Descripci?n    : Retorna el total de Productos, Contratos y Clientes dependiendo
                     del tipo que se recibe como par?metro
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 05-08-2013

    Parametros         Descripcion
    ============  ===================
        inuType       Tipo de Total
                          1 - Productos
                          2 - Contratos
                          3 - Clientes


    Historia de Modificaciones

    DD-MM-YYYY   <Autor>.SAONNNNN        Modificaci?n
    21-01-2014  carlosr
    Se hace el conteo por tipo de producto

    26-11-2013   carlosr
    Se hace el conteo por ciclo

    25-09-2013   carlosr
    Creaci?n
    -----------  -------------------    -------------------------------------

    ******************************************************************/
    FUNCTION fnuGetCountTotals
    (
        inuType     number,
        inuCycle    ciclo.ciclcodi%type,
        inuProdType in servicio.servcodi%type default null
    )
    RETURN number
    IS
        nuErrorCode NUMBER;
        sbErrorMessage VARCHAR2(4000);

        CURSOR cuProductTotals
        IS
            SELECT  count(1)
            FROM    servsusc
            WHERE   sesuserv = inuProdType
            AND     sesucicl = inuCycle ;

        CURSOR cuSuscripTotals
        IS
            SELECT  count(1)
            FROM    suscripc
            WHERE   susccicl = inuCycle;

        CURSOR cuSubscriberTotals
        IS
            SELECT  count(distinct suscclie)
            FROM    ge_subscriber,suscripc
            WHERE   suscclie = subscriber_id
            AND     susccicl = inuCycle;

    BEGIN                         -- ge_module

        pkErrors.push('fnuGetCountTotals');

        if (inuType = 1) then -- Productos
            if(nuProductTotal IS null) then
                open  cuProductTotals;
                fetch cuProductTotals into nuProductTotal;
                close cuProductTotals;

                pkErrors.pop;
                return nuProductTotal;
            else
                pkErrors.pop;
                return nuProductTotal;
            end if;

        elsif(inuType = 2) then -- Contratos
            if(nuSuscripTotal IS null) then
                open  cuSuscripTotals;
                fetch cuSuscripTotals into nuSuscripTotal;
                close cuSuscripTotals;

                pkErrors.pop;
                return nuSuscripTotal;
            else
                pkErrors.pop;
                return nuSuscripTotal;
            end if;

        elsif(inuType = 3) then -- Clientes
            if(nuSubscriberTotal IS null) then
                open  cuSubscriberTotals;
                fetch cuSubscriberTotals into nuSubscriberTotal;
                close cuSubscriberTotals;

                pkErrors.pop;

                return nuSubscriberTotal;
            else
                pkErrors.pop;
                return nuSubscriberTotal;
            end if;
        end if;

        pkErrors.pop;
        return 0;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return -1;
        when others then
            Errors.setError;
            pkErrors.pop;
            return -1;
    END fnuGetCountTotals;

    /**********************************************************************
        Descripci?n :   Retorna una cadena con las notas creadas en las fechas
                        dadas que afectaron la diferencia entre el proyecto
                        de castigo de cartera y lo realmente castigado
    ***********************************************************************/
    FUNCTION fsbObsNotasCartera
    (
        inuProducto     in  pr_product.product_id%type,
        idtFecInicial   in  date,
        idtFecFinal     in  date
    )
    return varchar2
    IS

        CURSOR cuNotas
        (
            inuNuse         in  suscripc.susccodi%type,
            idtFechaIni     in  date,
            idtFechaFin     in  date
        )
        IS
            SELECT  /*+ ordered
                        leading(cargos)
                        index (cargos IX_CARGOS04)
                    */
                    ' VALOR='||to_char(sum(cargos.cargvalo), '$999,999,999,999.99') valor,
                    ' NOTA='||notanume nota,
                    ' FECHA_GENERACION='||notafecr FECHA_GENERACION,
                    ' TIPO_NOTA='||decode(notatino, 'C', 'CR', 'D', 'DB', notatino) TIPO_NOTA,
                    ' FACT_AFECTADA='||notafact FACT_AFECTADA
            FROM    cargos, notas
            WHERE   notas.notanume = cargos.cargcodo
            AND     notatino in ('D','C')
            AND     cargnuse = inuNuse
            -- ( 5726, 25, 30109, 10823, 60167, 1003 )
            AND     notafecr between idtFechaIni AND idtFechaFin
            GROUP BY cargnuse, notanume, notafecr, notatino, notafact;

            rcObsNotas      cuNotas%rowtype;
            sbReturn        ge_boInstanceControl.stysbValue:= '';
            sbObservacion   ge_boInstanceControl.stysbValue:= '';

    BEGIN

        if(cuNotas%isopen)then
            close cuNotas;
        END if;

        open    cuNotas(inuProducto, idtFecInicial, idtFecFinal);
        fetch cuNotas INTO rcObsNotas;

        loop


            sbObservacion := rcObsNotas.valor||';'||rcObsNotas.nota||';'||rcObsNotas.FECHA_GENERACION||';'||
                        rcObsNotas.TIPO_NOTA||';'||rcObsNotas.FACT_AFECTADA||'|';

            if(sbObservacion <> ';;;;|')then
                sbReturn := sbReturn||sbObservacion;
            END if;

            fetch cuNotas INTO rcObsNotas;

            exit when (cuNotas%notfound);

        END loop;

        close cuNotas;

        RETURN sbReturn;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if(cuNotas%isopen)then
                close cuNotas;
            END if;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            if(cuNotas%isopen)then
                close cuNotas;
            END if;
            raise ex.CONTROLLED_ERROR;
    END fsbObsNotasCartera;

    /**********************************************************************
        Descripci?n :   Retorna una cadena con los pagos creadas en las fechas
                        dadas que afectaron la diferencia entre el proyecto
                        de castigo de cartera y lo realmente castigado
    ***********************************************************************/
    FUNCTION fsbObsPagosCartera
    (
        inuProducto     in  pr_product.product_id%type,
        idtFecInicial   in  date,
        idtFecFinal     in  date
    )
    return varchar2
    IS

        CURSOR cuPagos
        (
            inuNuse         in  suscripc.susccodi%type,
            idtFechaIni     in  date,
            idtFechaFin     in  date
        )
        IS
            SELECT  ' VALOR_PAGADO='||to_char(sum(pagovapa), '$999,999,999,999.99')valor_pagado,
                    ' CUPON='||pagocupo cupon_,
                    ' FECHA_PAGO='||pagofepa fecha_pago
            FROM    cargos, pagos
            WHERE   pagofepa between idtFechaIni AND idtFechaFin
            AND     pagocupo = cargcodo
            AND     cargnuse = inuNuse
            GROUP BY cargnuse, pagocupo, pagofepa;

            rcObsPagos      cuPagos%rowtype;
            sbReturn        ge_boInstanceControl.stysbValue := '';
            sbObservacion   ge_boInstanceControl.stysbValue := '';
    BEGIN

        if(cuPagos%isopen)then
            close cuPagos;
        END if;

        open    cuPagos(inuProducto, idtFecInicial, idtFecFinal);
        fetch   cuPagos INTO rcObsPagos;

        loop

            sbObservacion := rcObsPagos.valor_pagado||';'||rcObsPagos.cupon_||';'||rcObsPagos.fecha_pago||'|';

            if(sbObservacion <> ';;;;|')then
                sbReturn := sbReturn||sbObservacion;
            END if;

            fetch cuPagos INTO rcObsPagos;

            exit when (cuPagos%notfound);

        END loop;

        close cuPagos;

        RETURN sbReturn;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if(cuPagos%isopen)then
                close cuPagos;
            END if;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            if(cuPagos%isopen)then
                close cuPagos;
            END if;
            raise ex.CONTROLLED_ERROR;
    END fsbObsPagosCartera;

    /**********************************************************************
        Nombre  :   fsbObsFinancCartera
        Autor   :   C?sar Burbano

        Descripci?n :   Retorna una cadena con las financiaciones creadas en
                        las fechas dadas que afectaron la diferencia entre el
                        proyecto de castigo de cartera y lo realmente castigado

        Historia de Modificaciones
        Fecha         Autor             Modificaci?n
        ============  ================  ===============================
        23-Sep-2013   cesaburb          Creaci?n
    ***********************************************************************/
    FUNCTION fsbObsFinancCartera
    (
        inuProducto     in  pr_product.product_id%type,
        idtFecInicial   in  date,
        idtFecFinal     in  date
    )
    return varchar2
    IS

        CURSOR cuPagos
        (
            inuNuse         in  suscripc.susccodi%type,
            idtFechaIni     in  date,
            idtFechaFin     in  date
        )
        IS
            SELECT  ' PAGO_INICIAL='||initial_payment PAGO_INICIAL,
                    ' VALOR_FINANC='||to_char(sum(PEND_BALANCE_TO_FINANCE), '$999,999,999.99') VALOR_FINANC,
                    ' FECHA_REG='||record_date FECHA_REG,
                    ' SOLICITUD='||f.package_id SOLICITUD,
                    ' TIPO_SOLICITUD='||p.package_type_id TIPO_SOLICITUD
            FROM    cc_financing_request f, cc_fin_req_concept r,  mo_packages p
            WHERE   f.package_id = p.package_id
            AND     f.financing_request_id = r.financing_request_id
            AND     p.motive_status_id = 14 -- atendida
            AND     request_type = 'F'
            AND     record_date between idtFechaIni AND idtFechaFin
            AND     r.product_id = inuNuse
            GROUP BY  r.product_id, initial_payment, record_date, f.package_id, p.package_type_id;

            rcObsPagos      cuPagos%rowtype;
            sbReturn        ge_boInstanceControl.stysbValue := '';
            sbObservacion   ge_boInstanceControl.stysbValue := '';

    BEGIN

        if(cuPagos%isopen)then
            close cuPagos;
        END if;

        open    cuPagos(inuProducto, idtFecInicial, idtFecFinal);
        fetch   cuPagos INTO rcObsPagos;

        loop

            sbObservacion := rcObsPagos.PAGO_INICIAL||';'||rcObsPagos.VALOR_FINANC||';'||rcObsPagos.FECHA_REG||
                        rcObsPagos.SOLICITUD||';'||rcObsPagos.TIPO_SOLICITUD||'|';

            if(sbObservacion <> ';;;;|')then
                sbReturn := sbReturn||sbObservacion;
            END if;

            fetch   cuPagos INTO rcObsPagos;

            exit when (cuPagos%notfound);

        END loop;

        close cuPagos;

        RETURN sbReturn;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if(cuPagos%isopen)then
                close cuPagos;
            END if;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            if(cuPagos%isopen)then
                close cuPagos;
            END if;
            raise ex.CONTROLLED_ERROR;
    END fsbObsFinancCartera;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : ldc_fnuGetProdbyEstCor
    Descripci?n    : Retorna el total de productos por tipo de producto y estado de
                     corte
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuServicio Tipo de Producto
        inuEstacort Estado de Corte


    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN        Modificaci?n
    21-01-2014   carlosr
    Se usa memoria para traer la informacion

    26-11-2013   carlosr
    Se hace el conteo por ciclo

    26-09-2013   carlosr
    Creaci?n
    -----------  -------------------    -------------------------------------

    ******************************************************************/
    FUNCTION fnuGetProdbyEstCor
    (
        inuServicio servicio.servcodi%type,
        inuEstacort estacort.escocodi%type,
        inuCycle    ciclo.ciclcodi%type
    )
    RETURN number
    IS
        nuErrorCode NUMBER;
        sbErrorMessage VARCHAR2(4000);

        CURSOR cuTotalProducts
        IS
            SELECT  count(sesunuse)
            FROM    servsusc
            WHERE   sesuserv = inuServicio
            AND     sesuesco = inuEstacort
            AND     sesucicl = inuCycle;

        nuTotalProd number;
        sbKey varchar2(11);
    BEGIN                         -- ge_module

        pkErrors.push('LDC_ReportesConsulta.fnuGetProdbyEstCor');

        sbKey := LPAD(inuServicio,4,'0')||LPAD(inuEstacort,3,'0')||LPAD(inuCycle,4,'0');

        if(tbTotalProdByEstCort.exists(sbKey)) then
            pkErrors.pop;
            return tbTotalProdByEstCort(sbKey);
        else
            open  cuTotalProducts;
            fetch cuTotalProducts INTO nuTotalProd;
            close cuTotalProducts;

            tbTotalProdByEstCort(sbKey) := nuTotalProd;
        end if;

        pkErrors.pop;
        return nuTotalProd;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fnuGetProdbyEstCor;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetProdbyProdStat
    Descripci?n    : Retorna el total de productos por estado de producto
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    21-01-2014  carlosr
    Se usa memoria

    26-11-2013   carlosr
    Se hace el conteo por ciclo

    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetProdbyProdStat
    (
        inuProdStatus IN ps_product_status.product_status_id%type,
        inuServicio IN servicio.servcodi%type,
        inuCycle    ciclo.ciclcodi%type
    )
    RETURN number
    IS
        nuErrorCode NUMBER;
        sbErrorMessage VARCHAR2(4000);

        CURSOR cuTotalProducts
        IS
            SELECT  count(product_id)
            FROM    pr_product,servsusc
            WHERE   product_status_id = inuProdStatus
            AND     sesunuse = product_id
            AND     sesuserv = inuServicio
            AND     sesucicl = inuCycle;

        nuTotalProd number;

        sbKey varchar2(12);

    BEGIN                         -- ge_module

        pkErrors.push('LDC_ReportesConsulta.fnuGetProdbyProdStat');

        sbKey := LPAD(inuProdStatus,4,'0')||LPAD(inuCycle,4,'0')||LPAD(inuServicio,4,'0');

        if(tbTotalProdByEstProd.exists(sbKey)) then
            pkErrors.Pop;
            return tbTotalProdByEstProd(sbKey);
        else
            open  cuTotalProducts;
            fetch cuTotalProducts INTO nuTotalProd;
            close cuTotalProducts;

            tbTotalProdByEstProd(sbKey) := nuTotalProd;
        end if;

        pkErrors.pop;
        return nuTotalProd;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fnuGetProdbyProdStat;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetProdbyFinaState
    Descripci?n    : Retorna el total de productos por estado financiero y tipo
                     de servicio
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuFinanStat Estado Financiero del Producto
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-11-2013   carlosr
    Se hace el conteo por ciclo

    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetProdbyFinaState
    (
        inuFinanStat IN servsusc.sesuesfn%type,
        inuServicio IN servicio.servcodi%type,
        inuCycle    ciclo.ciclcodi%type
    )
    RETURN number
    IS
        nuErrorCode NUMBER;
        sbErrorMessage VARCHAR2(4000);

        CURSOR cuTotalProducts
        IS
            SELECT  count(sesunuse)
            FROM    servsusc
            WHERE   sesuserv = inuServicio
            AND     sesuesfn = inuFinanStat
            AND     sesucicl = inuCycle;

        nuTotalProd number;

        sbKey   varchar2(11);

    BEGIN                         -- ge_module

        pkErrors.push('LDC_ReportesConsulta.fnuGetProdbyFinaState');

        sbKey := LPAD(inuFinanStat,3,'0')||LPAD(inuCycle,4,'0')||LPAD(inuServicio,4,'0');

        if(tbTotalProdByEstFina.exists(sbKey))then

            pkErrors.pop;
            return tbTotalProdByEstFina(sbKey);
        else

            open  cuTotalProducts;
            fetch cuTotalProducts INTO nuTotalProd;
            close cuTotalProducts;

            tbTotalProdByEstFina(sbKey) := nuTotalProd;
        end if;

        pkErrors.pop;
        return nuTotalProd;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fnuGetProdbyFinaState;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetReadProducts
    Descripci?n    : Retorna el total de productos con lectura
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto
        inuType     Tipo: 1 - Lectura
                          2 - Relectura

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetReadProducts
    (
        inuperifact IN perifact.pefacodi%type,
        inuServicio IN servicio.servcodi%type,
        inuType     IN number
    )
    RETURN number
    IS
        nuErrorCode NUMBER;
        sbErrorMessage VARCHAR2(4000);

        CURSOR cuTotalProducts_L
        IS
            SELECT  count(distinct(lectelme.leemsesu))
            FROM    servsusc,lectelme
            WHERE   sesuserv = inuServicio
            AND     leempefa = inuperifact
            AND     sesunuse = leemsesu;

        CURSOR cuTotalProducts_R
        IS
            SELECT  /*+ ordered
                        leading(or_order_activity IX_OR_ORDER_ACTIVITY11)
                        index(or_order_activity )
                        use_nl(or_order_activity lectelme )
                        index(lectelme IX_LECTELME10)
                        index(servsusc IX_SERVSUSC30)
                    */
                    count(distinct(lectelme.leemsesu))
            FROM    or_order_activity, lectelme, servsusc
            WHERE   sesunuse = leemsesu
            AND     leemdocu = order_activity_id
            AND     activity_id = 4294337
            AND     leempefa = inuperifact
            AND     sesuserv = inuServicio;

        sbkey       varchar2(11);
        sbkeyR       varchar2(11);
        nuTotalProd number;

    BEGIN                         -- ge_module

        pkErrors.push('LDC_ReportesConsulta.fnuGetReadProducts');

        if(cuTotalProducts_L%isopen) then
            close cuTotalProducts_L;
        end if;
        if(cuTotalProducts_R%isopen) then
            close cuTotalProducts_R;
        end if;

        sbkey := inuType||RPAD(inuServicio,4,'0')||lpad(inuperifact,6,'0');
        sbkeyR := inuType||RPAD(inuServicio,4,'0')||lpad(inuperifact,6,'0');

        if(inuType = 1) then -- Lectura
            if(tbTotalReadProd.exists(sbkey)) then
                pkErrors.pop;
                return tbTotalReadProd(sbkey);
            else
                open  cuTotalProducts_L;
                fetch cuTotalProducts_L INTO nuTotalProd;
                close cuTotalProducts_L;

                tbTotalReadProd(sbkey) := nuTotalProd;
            end if;
        end if;

        if(inuType = 2) then -- Relectura
            if(tbTotalReadProdR.exists(sbkeyR)) then
                pkErrors.pop;
                return tbTotalReadProdR(sbkeyR);
            else

                open  cuTotalProducts_R;
                fetch cuTotalProducts_R INTO nuTotalProd;
                close cuTotalProducts_R;

                tbTotalReadProdR(sbkeyR) := nuTotalProd;
            end if;
        end if;
        pkErrors.pop;
        return nuTotalProd;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if(cuTotalProducts_L%isopen) then
                close cuTotalProducts_L;
            end if;
            if(cuTotalProducts_R%isopen) then
                close cuTotalProducts_R;
            end if;
            pkErrors.pop;
            return null;
        when others then
            if(cuTotalProducts_L%isopen) then
                close cuTotalProducts_L;
            end if;
            if(cuTotalProducts_R%isopen) then
                close cuTotalProducts_R;
            end if;
            Errors.setError;
            pkErrors.pop;
            return null;
    END fnuGetReadProducts;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetCritConsProd
    Descripci?n    : Retorna el total de productos con critica
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    22-01-2014  carlosr
    Se hace la union entre el producto y las lecturas para que traiga el valor
    correcto

    21-01-2014  carlosr
    Se hace uso de memoria

    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetCritConsProd
    (
        inuperifact IN perifact.pefacodi%type,
        inuServicio IN servicio.servcodi%type
    )
    RETURN number
    IS
        nuErrorCode NUMBER;
        sbErrorMessage VARCHAR2(4000);

        CURSOR cuTotalProducts
        IS
            SELECT  count(orcrorde)
            FROM    servsusc,cm_ordecrit,lectelme
            WHERE   sesuserv = inuServicio
            AND     leempefa = inuperifact
            AND     leemclec = 'F'
            AND     leemsesu = sesunuse
            AND     sesunuse = orcrsesu
            AND     leempecs = orcrpeco;

        nuTotalProd number;

        sbKey varchar(11);

    BEGIN                         -- ge_module

        pkErrors.push('LDC_ReportesConsulta.fnuGetCritConsProd');

        sbKey := LPAD(inuperifact,5,'0')||LPAD(inuServicio,6,'0');

        if(tbTotalCritProd.exists(sbKey)) then
            pkErrors.pop;
            return tbTotalCritProd(sbKey);
        else

            open  cuTotalProducts;
            fetch cuTotalProducts INTO nuTotalProd;
            close cuTotalProducts;

            tbTotalCritProd(sbKey) := nuTotalProd;
        end if;

        pkErrors.pop;
        return nuTotalProd;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fnuGetCritConsProd;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetChargeByServ
    Descripci?n    : Retorna el total de cargos de un servicio en un periodo
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    22-01-2014  carlosr
    Se cambia para contar solo los cargos generados por FGCC FGCA y FGCT

    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetChargeByServ
    (
        inuperifact IN perifact.pefacodi%type,
        inuServicio IN servicio.servcodi%type
    )
    RETURN number
    IS
        nuErrorCode NUMBER;
        sbErrorMessage VARCHAR2(4000);

        CURSOR cuTotalCharges
        IS
            SELECT  count(cargnuse)
            FROM    servsusc,cargos
            WHERE   cargpefa = inuperifact
            AND     sesuserv = inuServicio
            AND     cargprog in (5,6,97)
            AND     sesunuse = cargnuse;

        nuTotalCharges number;

        sbKey   varchar(10);

    BEGIN                         -- ge_module

        pkErrors.push('LDC_ReportesConsulta.fnuGetChargeByServ');

        sbkey := RPAD(inuServicio,4,'0')||lpad(inuperifact,6,'0');

        if(tbChargeQuant.exists(sbkey)) then
            pkErrors.pop;
            return tbChargeQuant(sbkey);
        else
            open  cuTotalCharges;
            fetch cuTotalCharges INTO nuTotalCharges;
            close cuTotalCharges;

            tbChargeQuant(sbkey) :=  nuTotalCharges;
        end if;

        pkErrors.pop;
        return nuTotalCharges;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fnuGetChargeByServ;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetCounts
    Descripci?n    : Retorna el total de cuentas de cobro de un servicio en un
                     periodo
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    22-01-2014  carlosr
    Se cambia para que traiga cuentas que se generaron con el FGCC (6)

    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetCounts
    (
        inuperifact IN perifact.pefacodi%type,
        inuServicio IN servicio.servcodi%type
    )
    RETURN number
    IS
        nuErrorCode NUMBER;
        sbErrorMessage VARCHAR2(4000);

        CURSOR cuTotalCounts
        IS
            SELECT  count(cucocodi)
            FROM    servsusc,cuencobr,factura
            WHERE   sesuserv = inuServicio
            AND     factpefa = inuperifact
            AND     factprog = 6
            AND     sesunuse = cuconuse
            AND     cucofact = factcodi;

        nuTotalCounts number;

        sbKey   varchar(10);

    BEGIN                         -- ge_module

        pkErrors.push('LDC_ReportesConsulta.fnuGetCounts');

        sbkey := RPAD(inuServicio,4,'0')||lpad(inuperifact,6,'0');

        if(tbCountQuant.exists(sbkey)) then
            pkErrors.pop;
            return tbCountQuant(sbkey);
        else
            open  cuTotalCounts;
            fetch cuTotalCounts INTO nuTotalCounts;
            close cuTotalCounts;

            tbCountQuant(sbkey) :=  nuTotalCounts;
        end if;

        pkErrors.pop;
        return nuTotalCounts;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fnuGetCounts;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetBills
    Descripci?n    : Retorna el total de facturas de un servicio en un periodo
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetBills
    (
        inuperifact IN perifact.pefacodi%type,
        inuServicio IN servicio.servcodi%type
    )
    RETURN number
    IS
        nuErrorCode NUMBER;
        sbErrorMessage VARCHAR2(4000);

        CURSOR cuTotalBills
        IS
            SELECT  count(distinct cucofact)
            FROM    servsusc,cuencobr,factura
            WHERE   sesuserv = inuServicio
            AND     sesunuse = cuconuse
            AND     cucofact = factcodi
            AND     factpefa = inuperifact;

        nuTotalBills number;

        sbKey   varchar(10);

    BEGIN                         -- ge_module

        pkErrors.push('LDC_ReportesConsulta.fnuGetBills');

        sbkey := RPAD(inuServicio,4,'0')||lpad(inuperifact,6,'0');

        if(tbCountBills.exists(sbkey)) then
            pkErrors.pop;
            return tbCountBills(sbkey);
        else
            open  cuTotalBills;
            fetch cuTotalBills INTO nuTotalBills;
            close cuTotalBills;

            tbCountBills(sbkey) :=  nuTotalBills;
        end if;

        pkErrors.pop;
        return nuTotalBills;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fnuGetBills;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetBillCons
    Descripci?n    : Retorna el total de facturas de un servicio en un periodo
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetBillCons
    (
        inuperifact IN perifact.pefacodi%type,
        inuServicio IN servicio.servcodi%type
    )
    RETURN number
    IS
        nuErrorCode NUMBER;
        sbErrorMessage VARCHAR2(4000);

        CURSOR cuTotalCons
        IS
            SELECT  sum(cosscoca)
            FROM    servsusc,conssesu
            WHERE   sesuserv = inuServicio
            AND     cosspefa = inuperifact
            AND     cossmecc = 4
            AND     sesunuse = cosssesu;

        nuTotalCons number;

        sbKey   varchar(10);

    BEGIN                         -- ge_module

        pkErrors.push('LDC_ReportesConsulta.fnuGetBillCons');

        sbkey := RPAD(inuServicio,4,'0')||lpad(inuperifact,6,'0');

        if(tbTotalConsu.exists(sbkey)) then
            pkErrors.pop;
            return tbTotalConsu(sbkey);
        else
            open  cuTotalCons;
            fetch cuTotalCons INTO nuTotalCons;
            close cuTotalCons;

            tbTotalConsu(sbkey) :=  nuTotalCons;
        end if;

        pkErrors.pop;
        return nuTotalCons;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fnuGetBillCons;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetConsCharges
    Descripci?n    : Retorna el total de los cargos de consumo de un servicio en
                     un periodo
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetConsCharges
    (
        inuperifact IN perifact.pefacodi%type,
        inuServicio IN servicio.servcodi%type
    )
    RETURN number
    IS
        nuErrorCode NUMBER;
        sbErrorMessage VARCHAR2(4000);

        CURSOR cuTotalCons
        IS
            SELECT  sum(decode(cargsign,'DB',cargvalo,'CR',-cargvalo))
            FROM    servsusc,cargos
            WHERE   sesuserv = inuServicio
            AND     sesunuse = cargnuse
            AND     cargconc = 31  --concepto de consumo
            AND     cargpefa = inuperifact;

        nuTotalCons number;

        sbKey   varchar(10);

    BEGIN                         -- ge_module

        pkErrors.push('LDC_ReportesConsulta.fnuGetConsCharges');

        sbkey := RPAD(inuServicio,4,'0')||lpad(inuperifact,6,'0');

        if(tbTotalConsCharg.exists(sbkey)) then
            pkErrors.pop;
            return tbTotalConsCharg(sbkey);
        else
            open  cuTotalCons;
            fetch cuTotalCons INTO nuTotalCons;
            close cuTotalCons;

            tbTotalConsCharg(sbkey) :=  nuTotalCons;
        end if;

        pkErrors.pop;
        return nuTotalCons;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fnuGetConsCharges;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetTotbyServ
    Descripci?n    : Retorna el total facturado de un servicio en un periodo
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetTotbyServ
    (
        inuperifact IN perifact.pefacodi%type,
        inuServicio IN servicio.servcodi%type
    )
    RETURN number
    IS
        nuErrorCode NUMBER;
        sbErrorMessage VARCHAR2(4000);

        CURSOR cuTotalValbyServ
        IS
            SELECT  sum(cucovato)
            FROM    servsusc,cuencobr, factura
            WHERE   sesuserv = inuServicio
            AND     sesunuse = cuconuse
            AND     cucofact = factcodi
            AND     factpefa = inuperifact;

        nuTotalValbyServ number;

        sbKey   varchar(10);

    BEGIN                         -- ge_module

        pkErrors.push('LDC_ReportesConsulta.fnuGetTotbyServ');

        sbkey := RPAD(inuServicio,4,'0')||lpad(inuperifact,6,'0');

        if(tbTotalValbyServ.exists(sbkey)) then
            pkErrors.pop;
            return tbTotalValbyServ(sbkey);
        else
            open  cuTotalValbyServ;
            fetch cuTotalValbyServ INTO nuTotalValbyServ;
            close cuTotalValbyServ;

            tbTotalValbyServ(sbkey) :=  nuTotalValbyServ;
        end if;

        pkErrors.pop;
        return nuTotalValbyServ;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fnuGetTotbyServ;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetTotbyPer
    Descripci?n    : Retorna el total facturado en un periodo
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 26-09-2013

    Parametros         Descripcion
    ============  ===================
        inuperifact Periodo de Facturaci?n
        inuServicio Tipo de Producto

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    26-09-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetTotbyPer
    (
        inuperifact IN perifact.pefacodi%type
    )
    RETURN number
    IS
        nuErrorCode NUMBER;
        sbErrorMessage VARCHAR2(4000);

        CURSOR cuTotalValbyPeriod
        IS
            SELECT  sum(cucovato)
            FROM    cuencobr, factura
            WHERE   factpefa = inuperifact
            AND     cucofact = factcodi;

        nuTotalValbyPeriod number;

        sbKey   varchar(6);

    BEGIN                         -- ge_module

        pkErrors.push('LDC_ReportesConsulta.fnuGetTotbyPer');

        sbkey := inuperifact;

        if(tbTotalValbyPeriod.exists(sbkey)) then
            pkErrors.pop;
            return tbTotalValbyPeriod(sbkey);
        else
            open  cuTotalValbyPeriod;
            fetch cuTotalValbyPeriod INTO nuTotalValbyPeriod;
            close cuTotalValbyPeriod;

            tbTotalValbyPeriod(sbkey) :=  nuTotalValbyPeriod;
        end if;

        pkErrors.pop;
        return nuTotalValbyPeriod;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fnuGetTotbyPer;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuGetDebtMgrInfo
    Descripci?n    : Retorna el valor de Edad de la deuda, Deuda total, Deuda
                     Corriente Vencida, Deuda Corriente no Vencida, Deuda Diferida,
                     Deuda Castigada, seg?n el tipo que reciba como par?metro
    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 04-10-2013

    Parametros         Descripcion
    ============  ===================
       inuSubscriberID     C?digo del Cliente
       inuSubscriptionID   C?digo del Contrato
       inuProductID        C?digo del Producto
       inuType             Tipo:
                                1 - Edad de la deuda
                                2 - Deuda total
                                3 - Deuda Corriente Vencida
                                4 - Deuda Corriente no Vencida
                                5 - Deuda Diferida
                                6 - Deuda Castigada

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    04-10-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetDebtMgrInfo
    (
        inuSubscriberID     IN  ge_subscriber.subscriber_id%type,
        inuSubscriptionID   IN  suscripc.susccodi%type,
        inuProductID        IN  pr_product.product_id%type,
        inuType             IN  number
    )
    RETURN number
    IS
        nuErrorCode NUMBER;
        sbErrorMessage VARCHAR2(4000);

    BEGIN                         -- ge_module

        pkErrors.push('LDC_ReportesConsulta.fnuGetDebtMgrInfo');

        if(inuType = 1) then --- 1 - Edad de la deuda

            if ((inuSubscriptionID IS null) AND (inuProductID IS null)) then
                pkErrors.pop;
                return GC_BODEBTMANAGEMENT.fnugetdebtagebyclie(inuSubscriberID);

            elsif ((inuSubscriptionID IS not null) AND (inuProductID IS null)) then
                pkErrors.pop;
                return GC_BODEBTMANAGEMENT.fnugetdebtagebysusc(inuSubscriptionID);

            elsif (inuProductID IS not null) then
                pkErrors.pop;
                return GC_BODEBTMANAGEMENT.FnuGetDebtAgeByProd(inuProductID);

            end if;
        end if;

        if(inuType = 2) then --- 2 - Deuda total

            if ((inuSubscriptionID IS null) AND (inuProductID IS null)) then
                pkErrors.pop;
                return (GC_BODEBTMANAGEMENT.fnuGetDefDebtByClie(inuSubscriberID) + -- Diferida
                       (GC_BODEBTMANAGEMENT.fnuGetDebtByClie(inuSubscriberID)));      --corriente vencido y no vencido

            elsif ((inuSubscriptionID IS not null) AND (inuProductID IS null)) then
                pkErrors.pop;
                return (GC_BODEBTMANAGEMENT.fnuGetDefDebtBySusc(inuSubscriptionID) + -- Diferida
                       (GC_BODEBTMANAGEMENT.fnuGetDebtBySusc(inuSubscriptionID)));     --corriente vencido y no vencido

            elsif (inuProductID IS not null) then
                pkErrors.pop;
                return (GC_BODEBTMANAGEMENT.fnuGetDefDebtByProd(inuProductID) + -- Diferida
                       (GC_BODEBTMANAGEMENT.fnuGetDebtByProd(inuProductID)));      --corriente vencido y no vencido

            end if;
        end if;

        if(inuType = 3) then --- 3 - Deuda Corriente Vencida

            if ((inuSubscriptionID IS null) AND (inuProductID IS null)) then
                pkErrors.pop;
                return GC_BODEBTMANAGEMENT.fnuGetExpirDebtByClie(inuSubscriberID);

            elsif ((inuSubscriptionID IS not null) AND (inuProductID IS null)) then
                pkErrors.pop;
                return GC_BODEBTMANAGEMENT.fnuGetExpirDebtBySusc(inuSubscriptionID);

            elsif (inuProductID IS not null) then
                pkErrors.pop;
                return GC_BODEBTMANAGEMENT.fnuGetExpirDebtByProd(inuProductID);

            end if;
        end if;

        if(inuType = 4) then --- 4 - Deuda Corriente no Vencida

            if ((inuSubscriptionID IS null) AND (inuProductID IS null)) then
                pkErrors.pop;
                return (GC_BODEBTMANAGEMENT.fnuGetDebtByClie(inuSubscriberID) -       --corriente vencido y no vencido
                       (GC_BODEBTMANAGEMENT.fnuGetExpirDebtByClie(inuSubscriberID))); -- Vencida

            elsif ((inuSubscriptionID IS not null) AND (inuProductID IS null)) then
                pkErrors.pop;
                return (GC_BODEBTMANAGEMENT.fnuGetDebtBySusc(inuSubscriptionID) -       --corriente vencido y no vencido
                       (GC_BODEBTMANAGEMENT.fnuGetExpirDebtBySusc(inuSubscriptionID))); -- Vencida

            elsif (inuProductID IS not null) then
                pkErrors.pop;
                return (GC_BODEBTMANAGEMENT.fnuGetDebtByProd(inuProductID) -         --corriente vencido y no vencido
                       (GC_BODEBTMANAGEMENT.fnuGetExpirDebtByProd(inuProductID)));   -- Vencida

            end if;
        end if;

        if(inuType = 5) then --- 5 - Deuda Diferida

            if ((inuSubscriptionID IS null) AND (inuProductID IS null)) then
                pkErrors.pop;
                return GC_BODEBTMANAGEMENT.fnugetdefdebtbyclie(inuSubscriberID);

            elsif ((inuSubscriptionID IS not null) AND (inuProductID IS null)) then
                pkErrors.pop;
                return GC_BODEBTMANAGEMENT.fnugetdefdebtbysusc(inuSubscriptionID);

            elsif (inuProductID IS not null) then
                pkErrors.pop;
                return GC_BODEBTMANAGEMENT.fnuGetDefDebtByProd(inuProductID);

            end if;
        end if;

        if(inuType = 6) then --- 6 - Deuda Castigada

            if ((inuSubscriptionID IS null) AND (inuProductID IS null)) then
                pkErrors.pop;
                return GC_BODEBTMANAGEMENT.fnugetpunidebtbyClie(inuSubscriberID);

            elsif ((inuSubscriptionID IS not null) AND (inuProductID IS null)) then
                pkErrors.pop;
                return GC_BODEBTMANAGEMENT.fnugetpunidebtbySusc(inuSubscriptionID);

            elsif (inuProductID IS not null) then
                pkErrors.pop;
                return GC_BODEBTMANAGEMENT.fnugetpunidebtbyProd(inuProductID);

            end if;
        end if;

        pkErrors.pop;
        return 0;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fnuGetDebtMgrInfo;

   /**********************************************************************
        Nombre  :   fnuGetConsumoPromedioAnio
        Autor   :   C?sar Figueroa

        Descripci?n :   Retorna el consumo promedio de los ultimos 12 meses.

        Historia de Modificaciones
        Fecha         Autor             Modificaci?n
        ============  ================  ==============================
        25-10-2013   cesar figueroa    Creaci?n
    ***********************************************************************/

    FUNCTION fnuGetConsumoPromedioAnio
    (
         inuProducto       servsusc.sesunuse%type,
         inuPeriodofact    conssesu.cosspefa%type
    )RETURN NUMBER
    IS
     nuCons      NUMBER;
     contador    NUMBER := 0;
     temp        NUMBER := inuPeriodofact;
     total       NUMBER;
     tempTotal   NUMBER := 0;
     blFlag      BOOLEAN := FALSE;
     dtFEIN      DATE;
     dtFEFIFACT  DATE;
     tempFA      NUMBER;
     nuConsumoZERO number;

    BEGIN

    FOR i IN 1..12 loop


      SELECT sum(cosscoca)
      INTO nuCons
      FROM conssesu cons
      WHERE cons.cosspefa = temp
          AND cons.cossmecc = 4
          AND cons.cosssesu = inuProducto;

     contador := contador+1;

     if(nucons IS null ) then
       nuCons := 0;

       SELECT sum(cosscoca)
       INTO nuConsumoZERO
          FROM conssesu cons
          WHERE cons.cosspefa = temp
          AND cons.cossmecc = 1
          AND cons.cosssesu = inuProducto;

          if (nuConsumoZERO IS NULL) then
            blFlag := TRUE;
            exit;
          END if;

     END if;

     tempTotal := tempTotal+nuCons;
     tempFA := temp;
     temp := pkbillingperiodmgr.fnugetperiodprevious(temp);

    END loop;

    IF blFlag = TRUE THEN

    SELECT perifact.pefafimo
    INTO dtFEIN
    FROM perifact
     WHERE perifact.pefacodi = tempFA;

    SELECT perifact.pefaffmo
    INTO dtFEFIFACT
    FROM perifact
     WHERE perifact.pefacodi = inuPeriodofact;


    total := tempTotal/round((dtFEFIFACT - dtFEIN)*24);

    ELSE

     total := tempTotal/8760;
    END IF;

    RETURN total;

    EXCEPTION
     WHEN LOGIN_DENIED THEN
        return null;
     WHEN ex.CONTROLLED_ERROR THEN
         pkErrors.pop;
        return null;
     WHEN others THEN
         Errors.setError;
        return null;
    END fnuGetConsumoPromedioAnio;

    /**********************************************************************
        Nombre  :   fnuGetPeriFact
        Autor   :   C?sar Figueroa

        Descripci?n :   Retorna el ultimo periodo de facturacion de un contrato.

        Historia de Modificaciones
        Fecha         Autor             Modificaci?n
        ============  ================  ==============================
        29-10-2013   cesar figueroa    Creaci?n
    ***********************************************************************/
    FUNCTION fnuGetPeriFact
    (
         inuContrato       suscripc.susccodi%type,
         idtFechaSusp      DATE
    )RETURN NUMBER
    IS
     nuperifact  NUMBER;

    BEGIN

     SELECT a.factpefa
     INTO nuperifact
     FROM factura a
     WHERE a.factfege = (SELECT max(b.factfege)
                         FROM factura b
                         WHERE b.factfege <= idtFechaSusp
                         AND b.factsusc = inuContrato)
     AND a.factsusc = inuContrato
     AND ROWNUM = 1;


     RETURN nuperifact;

    EXCEPTION
     WHEN LOGIN_DENIED THEN
        return null;
     WHEN ex.CONTROLLED_ERROR THEN
         pkErrors.pop;
        return null;
     WHEN others THEN
         Errors.setError;
        return null;
    END fnuGetPeriFact;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fdtGetHlemconsbyElme
    Descripci?n    : Retorna el identificador del hist?rico de lectura por c?digo
                     de HLEMELME. En caso de tener m?s de un registro, retorna
                     el primero (primera lectura)

    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 21-11-2013

    Parametros         Descripcion
    ============  ===================
       inuHlemelme     C?digo de lectura por elemento de medici?n

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    05-12-2013  carlosr
    Se agrega el parametro tipo para poder retornar la relectura de forma correcta
    usando el segundo CURSOR cuGetHlemelme2

    25-11-2013   carlosr
    Se elimina el uso de memoria ya que est? mostrando productos que no deber?an
    aparecer.

    21-11-2013   carlosr
    Creaci?n
    ******************************************************************/
    FUNCTION fnuGetHlemconsbyElme
    (
        inuHlemelme     IN  hileelme.hlemelme%type,
        inuType         in  number default 1
    )
    RETURN hileelme.hlemcons%type
    IS
        CURSOR cuGetHlemelme
        IS
            SELECT  hlemcons
            FROM    hileelme
            WHERE   hlemelme = inuHlemelme
            ORDER BY hlemcons asc;

        CURSOR cuGetHlemelme2
        IS
            SELECT  hlemcons
            FROM    hileelme
            WHERE   hlemelme = inuHlemelme
            ORDER BY hlemcons desc;

        nuHlemcons  hileelme.hlemcons%type;

    BEGIN
        pkErrors.push('LDC_ReportesConsulta.fnuGetHlemconsbyElme');

        if (inuType = 1) then

            open  cuGetHlemelme;
            fetch cuGetHlemelme INTO nuHlemcons;
            close cuGetHlemelme;

        elsif (inuType = 2) then

            open  cuGetHlemelme2;
            fetch cuGetHlemelme2 INTO nuHlemcons;
            close cuGetHlemelme2;
        end if;

        pkErrors.pop;
        return nuHlemcons;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fnuGetHlemconsbyElme;


    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  Traer Referencias (Personales,Familiares,Bancarias,Comerciales)
    Descripcion :  En una cadena alfanumerica se obtiene los datos de la referencias dada el tipo de referencia y el suscriptor

    Autor  : Francisco Jose Romero Romero - Ludycom
    Fecha  : 28-11-2013 (Fecha Creacion Paquete)  Peti_v1
    */
    FUNCTION fnuTraeReferencia ( nuSubsId GE_SUBS_REFEREN_DATA.subscriber_id%type, nuTypeRef Ge_Subs_Referen_Data.reference_type_id%type )
    return varchar2 IS
        sbReferencia varchar2(4000);

        --Ref Comerciales, Familiares y Personales
        cursor cuReferenciaC is
           SELECT ('TPO_IDEN: '||RC.ident_type_id||'-'||(SELECT b.description FROM ge_identifica_type b WHERE b.ident_type_id = RC.ident_type_id)||
                   ' - IDENTIFICACION: '||RC.identification||
                   ' - NOMBRE: '||RC.name_||' '||RC.last_name||
                   ' - DIRECCION: '||(SELECT b.address FROM ab_address b WHERE b.address_id = RC.address_id)||
                   ' - TEL: '||RC.phone||
                   ' - OBSERV: '||RC.comment_) REFERENCIAS
            FROM GE_SUBS_REFEREN_DATA RC
            WHERE RC.SUBSCRIBER_ID = nuSubsId
            AND RC.REFERENCE_TYPE_ID = nuTypeRef;

        --Ref Comerciales, Familiares y Personales
        cursor cuReferenciaB is
           SELECT ('ENTIDAD_BANCARIA: '||RC.bank_id||'-'||(SELECT bancnomb FROM banco WHERE banccodi = RC.bank_id)||
                   '  - TIPO_CUENTA: '||RC.account_type||'-'||(select tcbadesc FROM ticubanc WHERE tcbacodi = RC.account_type)||
                   '  - OBSERV: '||RC.comment_) REFERENCIAS
            FROM GE_SUBS_REFEREN_DATA RC
            WHERE RC.SUBSCRIBER_ID = nuSubsId
            AND RC.REFERENCE_TYPE_ID = nuTypeRef;

    BEGIN
        sbReferencia := null;
        if nuTypeRef IN (1,2,4) then
          for regcuReferenciaC in cuReferenciaC loop
            if sbReferencia is null then
              sbReferencia := regcuReferenciaC.REFERENCIAS;
            else
              sbReferencia := sbReferencia||',  '||regcuReferenciaC.REFERENCIAS;
            end if;
          end loop;
        end if;

        if nuTypeRef = 3 then
          for regcuReferenciaB in cuReferenciaB loop
            if sbReferencia is null then
              sbReferencia := regcuReferenciaB.REFERENCIAS;
            else
              sbReferencia := sbReferencia||',  '||regcuReferenciaB.REFERENCIAS;
            end if;
          end loop;
        end if;

        return sbReferencia;
    EXCEPTION
        when others then
        sbReferencia := null;
        return sbReferencia;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  Traer Telefonos
    Descripcion :  En una cadena alfanumerica se obtiene los telefonos dado el suscriptor

    Autor  : Francisco Jose Romero Romero - Ludycom
    Fecha  : 28-11-2013 (Fecha Creacion Paquete)  Peti_v1
    */
    FUNCTION fnuTraeTelefonos ( nuSubsId GE_SUBS_PHONE.subscriber_id%type )
    return varchar2 IS
        sbTelefonos varchar2(4000);

        --Telefonos
        cursor cuTelefonos is
           SELECT ('TPO_TEL: '||T.phone_type_id||'-'||(SELECT b.phone_type_desc FROM ge_phone_type b WHERE b.phone_type_id = T.phone_type_id)||
                   ' - NUM_TELEFONO: '||T.full_phone_number||
                   ' - TELEFONO_ING_VENTA: '||T.phone||
                   ' - SMS_TECNICO: '||decode(T.technical_sms, 'Y', 'SI', 'N', 'NO', T.technical_sms)||
                   ' - SMS_ADMIN: '||decode(T.administrative_sms, 'Y', 'SI', 'N', 'NO', T.administrative_sms)||
                   ' - SMS_COMERCIAL: '||decode(T.comercial_sms, 'Y', 'SI', 'N', 'NO', T.comercial_sms)) TELEFONOS
           FROM GE_SUBS_PHONE T
           WHERE T.SUBSCRIBER_ID = nuSubsId;

    BEGIN
        sbTelefonos := null;
        for regTelefonos in cuTelefonos loop
          if sbTelefonos is null then
            sbTelefonos := regTelefonos.TELEFONOS;
          else
            sbTelefonos := sbTelefonos||',  '||regTelefonos.TELEFONOS;
          end if;
        end loop;

        return sbTelefonos;
    EXCEPTION
        when others then
        sbTelefonos := null;
        return sbTelefonos;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  Traer Categorias,Subcategorias dada la suscripcion
    Descripcion :  En una cadena alfanumerica se obtiene las categorias y subcategorias

    Autor  : Francisco Jose Romero Romero - Ludycom
    Fecha  : 28-11-2013 (Fecha Creacion Paquete)  Peti_v1
    */
    FUNCTION fnuTraeCategorias ( nuSesususc servsusc.sesususc%type )
    return varchar2 IS
        sbCate varchar2(4000);

        --Telefonos
        cursor cuCate is
          Select ('CATEGORIA: '||b.catecodi||'-'||b.catedesc||' -- SUBCATEGORIA: '||t.sucacodi||'-'||t.sucadesc) CATEGORIAS
          from servsusc s, CATEGORI b, SUBCATEG t
          where s.sesususc = nuSesususc
          and b.catecodi = s.sesucate
          and t.sucacate = s.sesucate
          and t.sucacodi = s.sesusuca;

    BEGIN
        sbCate := null;
        for regCate in cuCate loop
          if sbCate is null then
            sbCate := regCate.CATEGORIAS;
          else
            sbCate := sbCate||',  '||regCate.CATEGORIAS;
          end if;
        end loop;

        return sbCate;
    EXCEPTION
        when others then
        sbCate := null;
        return sbCate;
    END;



    /**********************************************************************
        Nombre  :   fnuCupoBrilla
        Autor   :   Cesar Figueroa

        Descripcion :   Retorna el cupo disponible de brilla de un contrato.

        Historia de Modificaciones
        Fecha         Autor             Modificacion
        ============  ================  ==============================
        03-12-2013   cesar figueroa    Creacion
    ***********************************************************************/
     FUNCTION fnuCupoBrilla(nuContrato suscripc.susccodi%type)
     RETURN NUMBER
     IS

      TYPE cur_typ IS REF CURSOR;
      c_cursor    CUR_TYP;
      nuAvalibleQuote NUMBER := 0;
      TYPE recor IS RECORD
      (
          cupo_asignado         number,
          cupo_usado            number,
          cupo_disponible       number,
          saldo_red             number,
          cupo_bloqueado        varchar2(5),
          cupo_cedido           number,
          cupo_recibido         number,
          politicas_incumplidas varchar2(200),
          parent_id             number
      );
      fila recor;

     BEGIN

      ld_boqueryfnb.getQuotaInfo(nuContrato, c_cursor);

      LOOP
        FETCH c_cursor INTO fila;
        EXIT WHEN c_cursor%NOTFOUND;
        nuAvalibleQuote := fila.cupo_disponible;
        dbms_output.put_line(fila.cupo_disponible);
      END LOOP;

     RETURN  nuAvalibleQuote;

     END fnuCupoBrilla;

/*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuBarrio
    Descripci?n    : Retorna el identificador del barrio de un contrato, cliente
                     o producto

    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 04-12-2013

    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    -----------  -------------------    -------------------------------------

    04-12-2013   carlosr
    Creacion
    ******************************************************************/


    FUNCTION  fnuBarrio (nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type,
                        nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                        nuPRODUCT_ID      or_order_activity.PRODUCT_ID%type)
    return number
    IS

        nuCadena number;

        -- Barrio por cliente
        cursor cuCliete is
        select gg.geograp_location_id Barrio
                          from ge_geogra_location gg, ab_address ab, ge_subscriber g
                          where gg.geograp_location_id = ab.neighborthood_id
                            and ab.address_id = g.address_id
                            and g.subscriber_id = nuSUBSCRIBER_ID;

        -- Barrio por Contrato
        cursor cuContrato is
        select  gg.geograp_location_id Barrio
                        from ge_geogra_location gg,ab_address ab,ge_subscriber g,suscripc s
                        where gg.geograp_location_id = ab.neighborthood_id
                         and ab.address_id = g.address_id
                         and g.subscriber_id = s.suscclie
                         and s.susccodi = nuSUBSCRIPTION_ID;

        -- Barrio por Producto
        cursor cuProducto is
        select gg.geograp_location_id Barrio
                          from ge_geogra_location gg,ab_address ab,ge_subscriber g,suscripc s,servsusc ss
                          where gg.geograp_location_id = ab.neighborthood_id
                          and ab.address_id = g.address_id
                          and g.subscriber_id = s.suscclie
                          and s.susccodi = ss.sesususc
                          and ss.sesunuse = nuPRODUCT_ID;
    begin
        -- Retorna a nivel de cliete
        if (nuSUBSCRIBER_ID is not null and nuSUBSCRIPTION_ID is null) then
            for rcCliete in cuCliete loop
                nuCadena := rcCliete.Barrio;
            end loop;
        -- Retorna a nivel de Contrato
        elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is null) then
            for rcContrato in cuContrato loop
                nuCadena := rcContrato.Barrio;
            end loop;
        -- Retorna a nivel de producto
        elsif (nuSUBSCRIPTION_ID is not null and nuPRODUCT_ID is not null) then
            for rcProducto in cuProducto loop
                nuCadena := rcProducto.Barrio;
            end loop;
        end if;

        -- Retorna el valor calculado
        return nuCadena;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            return null;
        WHEN others then
            return null;
    END fnuBarrio;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fsbGetPhones
    Descripci?n    : Retorna los telefonos de un cliente

    Autor          : Carlos Alberto Ram?rez Herrera
    Fecha          : 04-12-2013

    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    -----------  -------------------    -------------------------------------

    04-12-2013   carlosr
    Creacion
    ******************************************************************/
    FUNCTION  fsbGetPhones
    (
        nuSUBSCRIBER_ID   or_order_activity.SUBSCRIBER_ID%type
    )
    return varchar2
    IS

        sbCadena varchar(2000);

        CURSOR cuGetPhones
        IS
            SELECT  rtrim (xmlagg (xmlelement (e,phone || ' - ')).extract ('//text()'), ' - ')  Telefonos
            FROM
            (
                 SELECT  subscriber_id, phone
                 FROM    ge_subscriber
                 WHERE   subscriber_id = nuSUBSCRIBER_ID
                 UNION ALL
                 SELECT  ge.subscriber_id, ph.phone
                 FROM    ge_subscriber ge, ge_subs_phone ph
                 WHERE   ge.subscriber_id = ph.subscriber_id
                 AND ge.subscriber_id = nuSUBSCRIBER_ID
            )
           GROUP BY subscriber_id;

    BEGIN

        open cuGetPhones;
        fetch cuGetPhones INTO sbCadena;
        close cuGetPhones;
        return sbCadena;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            return null;
        when others then
            return null;
    END fsbGetPhones;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuCountHlemconsbyElme
    Descripci?n    : Cuenta el total de registros que hay por lectura

    Autor          : Carlos Alberto Ramirez Herrera
    Fecha          : 05-12-2013

    Parametros         Descripcion
    ============  ===================
       inuHlemelme     Codigo de lectura por elemento de medici?n

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    05-12-2013   carlosr
    Creacion
    ******************************************************************/
    FUNCTION fnuCountHlemconsbyElme
    (
        inuHlemelme     IN  hileelme.hlemelme%type
    )
    RETURN hileelme.hlemcons%type
    IS
        CURSOR cuGetHlemelme
        IS
            SELECT  count(hlemcons)
            FROM    hileelme
            WHERE   hlemelme = inuHlemelme;

        nuHlemcons  hileelme.hlemcons%type;

    BEGIN
        pkErrors.push('LDC_ReportesConsulta.fnuCountHlemconsbyElme');

        open  cuGetHlemelme;
        fetch cuGetHlemelme INTO nuHlemcons;
        close cuGetHlemelme;

        pkErrors.pop;
        return nuHlemcons;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fnuCountHlemconsbyElme;

    /**********************************************************************
        Nombre  :   fsbConceptosDiferido
        Autor   :   Cesar Figueroa

        Descripcion :   Retorna los conceptos de los diferidos de un producto.

        Historia de Modificaciones
        Fecha         Autor             Modificacion
        ============  ================  ==============================
        11-12-2013   cesar figueroa    Creacion
    ***********************************************************************/
    FUNCTION fsbConceptosDiferido( nuSusc suscripc.susccodi%type, inuMeses NUMBER)
    RETURN VARCHAR2
    IS

   CURSOR cuConc IS
    SELECT dif.difeconc
    FROM diferido dif,
         servsusc
    WHERE dif.difesusc = nuSusc
     AND servsusc.sesususc = dif.difesusc
     AND servsusc.sesunuse = dif.difenuse
     AND servsusc.sesuserv IN (7055,7056)
     AND MONTHS_BETWEEN(sysdate, dif.difefein) <= inuMeses;

    sbConceptos VARCHAR2(2000);

    BEGIN

     for regComments in cuConc loop
        if sbConceptos is null then
          sbConceptos := regComments.difeconc;
        else
          sbConceptos := sbConceptos || '-' || regComments.difeconc;
        end if;
      end loop;

      return sbConceptos;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fsbConceptosDiferido;


    /**********************************************************************
        Nombre  :   fsbObsActivity
        Autor   :   Cesar Figueroa

        Descripcion :   Retorna las observaciones de las actividades de una orden.

        Historia de Modificaciones
        Fecha         Autor             Modificacion
        ============  ================  ==============================
        15-12-2013   cesar figueroa    Creacion
    ***********************************************************************/
    FUNCTION fsbObsActivity(inuOrden or_order.order_id%type)
    return varchar2 IS
       CURSOR cuComments is
         SELECT OR_order_activity.comment_
           FROM or_order_activity
             WHERE or_order_activity.order_id = inuOrden;
       sbOb  VARCHAR2(32767);
    BEGIN
      for regComments in cuComments loop
        if sbOb is null then
          sbOb := regComments.comment_;
        else
          sbOb := sbOb || '-' || regComments.comment_;
        end if;
      end loop;
      return sbOb;
    EXCEPTION
      WHEN OTHERS THEN
        RETURN '-';
    END fsbObsActivity;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fsbGetPromotions
    Descripci?n    : retorna el total de promociones asignadas a una solicitud

    Autor          : Carlos Alberto Ramirez Herrera
    Fecha          : 17-12-2013

    Parametros         Descripcion
    ============  ===================
       inuMotive_id     Codigo del motivo

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN
    Modificaci?n
    -----------  -------------------    -------------------------------------
    17-12-2013   carlosr
    Creacion
    ******************************************************************/
    FUNCTION fsbGetPromotions
    (
        inuMotive_id     IN  mo_motive.motive_id%type
    )
    RETURN varchar2
    IS
        CURSOR cuGetPromotionsByMotive
        IS
            SELECT  rtrim (xmlagg (xmlelement (e,promtions || ' - ')).extract ('//text()'), ' - ')  promotions
            FROM
            (
                 SELECT  mo.motive_id, '['||pr.promotion_id||' - '||pr.description||']' promtions
                 FROM    mo_mot_promotion mo, cc_promotion pr
                 WHERE   mo.motive_id = inuMotive_id
                 AND     mo.promotion_id = pr.promotion_id

            )
            GROUP BY motive_id;

        sbPromotions  varchar2(4000);

    BEGIN
        pkErrors.push('LDC_ReportesConsulta.fsbGetPromotions');

        open  cuGetPromotionsByMotive;
        fetch cuGetPromotionsByMotive INTO sbPromotions;
        close cuGetPromotionsByMotive;

        pkErrors.pop;
        return sbPromotions;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fsbGetPromotions;

    /**********************************************************************
        Nombre  :   fsbGetRefinanc
        Autor   :   Cesar Figueroa

        Descripcion :   Retorna el numero de refinanciaciones que tiene un contrato.

        Historia de Modificaciones
        Fecha         Autor             Modificacion
        ============  ================  ==============================
        18-12-2013   cesar figueroa    Creacion
    ***********************************************************************/

    FUNCTION fsbGetRefinanc(inuSusc suscripc.susccodi%type)
    RETURN NUMBER
    IS

    nuCount NUMBER;

    BEGIN

    SELECT count(1)
    INTO nuCount
    FROM diferido dif
    WHERE dif.difesusc = inuSusc
     AND dif.difeprog = 'GCNED';

     return nuCount;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            pkErrors.pop;
            return null;
        when others then
            Errors.setError;
            pkErrors.pop;
            return null;
    END fsbGetRefinanc;


    /*****************************************************************
    Propiedad intelectual de LDC (c).

    Unidad         : fnuGetDefRecaM
    Descripci?n    : Retorna el valor de los diferidos o del recargo por mora del
                 producto o contrato

    Autor          : Carlos Alberto Ramirez Herrera
    Fecha          : 28-01-2014

    Parametros         Descripcion
    ============	===================

    Historia de Modificaciones

    07-04-2014  carlosr 95867(aranda)
    Se agrega la logica para calcular el recargo por mora e intereses de los
    usuarios castigados.

    10-02-2014  carlosr
    - Se modifica la forma de traer el interes y el recargo por mora cuando es por
    contrato; solo se suma el saldo vencido y el saldo actual para ambos
    - Se corrige el nombre del parametro de los conceptos de recargo por mora
    - Se agrega el parametro de 'LDC_PORCENTAJE_GCEC', el cual tiene el valor
    del procentaje a mostrar en el interes y recargo por mora

    28-01-2014  carlosr
    Creacion

    ******************************************************************/
    FUNCTION fnuGetDefRecaM
    (
        inuSesu  in servsusc.sesunuse%type,
        inuSusc  in suscripc.susccodi%type,
        inutype  in Number  -- 1-Diferido 2-Recargo por Mora
    )
    RETURN number
    IS
        sbErrMsg    ge_error_log.description%type;

        type tyrfRefCursor IS ref CURSOR;
        rfResumeSubsc   tyrfRefCursor; --- Resumen para el contrato
        rfDetailSubsc   tyrfRefCursor; --- Detalle para el contrato

        type tyrcRecResSubs IS record
        (
            conccodi    concepto.conccodi%type, --- concepto
            concdesc	concepto.concdesc%type, --- desc concepto
            saldactu	number,                 --- saldo actual
            saldvenc    number,                 --- saldo vencido
            salddife    number                  --- saldo diferido
        );

        type tytbResumeSusc is table of tyrcRecResSubs index by binary_integer;
        tbResumeSusc    tytbResumeSusc;

        type tytbPunProd is table of number index by binary_integer;

        CURSOR cuPunProdBySusc
        IS
            SELECT  sesunuse
            FROM    servsusc
            WHERE   sesususc = inuSusc
            AND     sesuesfn = 'C';

        tbBalanceAcc    fa_boaccountstatustodate.tytbBalanceAccounts;
        tbDeferredBal   fa_boaccountstatustodate.tytbDeferredBalance;
        tbPunProd       tytbPunProd;

        nucurrentaccounttotal   number;  -- Variable Dummy
        nudeferredaccounttotal  number;  -- Variable Dummy
        nucreditbalance         number;  -- Variable Dummy
        nuclaimvalue            number;  -- Variable Dummy
        nudefclaimvalue         number;  -- Variable Dummy

        nuIndex             number;
        nuIndexIntDef       number;
        nuIndexLatCha       number;
        nuIdxProdDef        varchar2(100);
        nuIdxProdLatChar    varchar2(100);
        nuIndexPunProd      number;

        nuDefTotalSusc      number;
        nuRecMorTotalSusc   number;
        nuDefTotalProd      number;
        nuRecMorTotalProd   number;
        nuPunProdTotal      number;

        ------------------------------------------------------------------------
        -- Funcion que retorna el valor del recargo por mora o los intereses de los productos castigados
        ------------------------------------------------------------------------
        FUNCTION fnuGetPunValue
        (
            inuProduct  in servsusc.sesunuse%type,
            isbConcepts in ld_parameter.value_chain%type
        ) return number
        IS
            CURSOR cuGetPunValue
            IS
                SELECT  -sum(decode(cargsign,'DB',cargvalo,'CR',-cargvalo)) Total_descuento
                FROM    cargos--, servsusc
                WHERE   cargnuse = inuProduct
                AND     cargcaca in (2,58)
                AND     ','||isbConcepts||',' like '%,'||cargconc||',%';

            nuTotalVal  number;

        BEGIN
            pkErrors.Push ('LDC_ReportesConsulta.fnuGetDefRecaM.fnuGetPunValue');

            if(cuGetPunValue%isopen) then
                    close cuGetPunValue;
            end if;

            open  cuGetPunValue;
            fetch cuGetPunValue into nuTotalVal;
            close cuGetPunValue;

            pkErrors.pop;
            return nuTotalVal;

        EXCEPTION
            when LOGIN_DENIED then
                if(cuGetPunValue%isopen) then
                    close cuGetPunValue;
                end if;
                pkErrors.Pop;
                return null;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                if(cuGetPunValue%isopen) then
                    close cuGetPunValue;
                end if;
                pkErrors.Pop;
                return null;

            when OTHERS then
                pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
                if(cuGetPunValue%isopen) then
                    close cuGetPunValue;
                end if;
                pkErrors.Pop;
                return null;
        --}
        END fnuGetPunValue;

    BEGIN
    --{
        pkErrors.Push ('LDC_ReportesConsulta.fnuGetDefRecaM');

        --- Se cargan los datos de los parametros a memoria
        if(tbIntFinan.count = 0 OR tbRecaMora.count = 0) then
            sbFinanConcepts := dald_parameter.fsbGetValue_Chain('LDC_CONCEPTOS_FINANCIACION');
            ut_string.extstring(sbFinanConcepts,',',tbIntFinan);

            sbRecMorConcepts := dald_parameter.fsbGetValue_Chain('LDC_CONCEPTOS_RECARGOMORA');
            ut_string.extstring(sbRecMorConcepts,',',tbRecaMora);

            nuPercentage := dald_parameter.fnuGetNumeric_Value('LDC_PORCENTAJE_GCEC');

        end if;

        nuDefTotalSusc      := 0;
        nuRecMorTotalSusc   := 0;
        nuDefTotalProd      := 0;
        nuRecMorTotalProd   := 0;
        nuPunProdTotal      := 0;

        -----------------------------------------------------------------------------------
        -- CONSULTA POR CONTRATO
        -----------------------------------------------------------------------------------

        if (inuSesu IS null) then --- Si el producto es nulo entonces se hace por contrato

            open  cuPunProdBySusc;  --- Guarda los productos castigados
            fetch cuPunProdBySusc bulk collect into tbPunProd;
            close cuPunProdBySusc;

            nuIndexPunProd := tbPunProd.first;
            loop
                exit when (nuIndexPunProd is null);
                if(inuType = 1) then     --- Intereses
                    nuPunProdTotal := nuPunProdTotal + nvl(fnuGetPunValue(tbPunProd(nuIndexPunProd),sbFinanConcepts),0);
                elsif (inuType = 2) then --- Valor Recargo por Mora
                    nuPunProdTotal := nuPunProdTotal + nvl(fnuGetPunValue(tbPunProd(nuIndexPunProd),sbRecMorConcepts),0);
                end if;
                nuIndexPunProd := tbPunProd.next(nuIndexPunProd);
            end loop;

            fa_boaccountstatustodate.subscriptaccountstatustodate
                    (
                        inuSusc,
                        sysdate,
                        nucurrentaccounttotal,
                        nudeferredaccounttotal,
                        nucreditbalance,
                        nuclaimvalue,
                        nudefclaimvalue,
                        rfResumeSubsc,
                        rfDetailSubsc
                     );

            fetch   rfResumeSubsc bulk collect into tbResumeSusc;
            close   rfResumeSubsc;
            ------------------------------------------------------------------------
            if (inuType = 1) then --- Valor de Intereses
                nuIndex := tbResumeSusc.first;
                loop
                    exit when (nuIndex is null);

                    nuIndexIntDef :=  tbIntFinan.first; --- Indice que recorre los conceptos de financiacion
                    loop
                        exit when (nuIndexIntDef is null);
                            -- Si el concepto del producto a consultar es igual al del parametro entonces acumula
                            if(tbIntFinan(nuIndexIntDef) = tbResumeSusc(nuIndex).conccodi) then
                                nuDefTotalSusc := nuDefTotalSusc +
                                                  tbResumeSusc(nuIndex).saldactu +
                                                  tbResumeSusc(nuIndex).saldvenc;
                                nuIndexIntDef := null;

                            end if;
                            nuIndexIntDef := tbIntFinan.next(nuIndexIntDef);

                    end loop;

                    nuIndex := tbResumeSusc.next(nuIndex);

                end loop;

                pkErrors.Pop;
                return (nuDefTotalSusc + nuPunProdTotal)*nuPercentage/100;
            ------------------------------------------------------------------------
            elsif (inuType = 2) then --- Valor Recargo por Mora
                nuIndex := tbResumeSusc.first;

                loop
                    exit when (nuIndex is null);

                    nuIndexLatCha :=  tbRecaMora.first; --- Indice que recorre los conceptos de recargo por mora

                    loop
                        exit when (nuIndexLatCha is null);
                            -- Si el concepto del producto a consultar es igual al del parametro entonces acumula
                            if(tbRecaMora(nuIndexLatCha) = tbResumeSusc(nuIndex).conccodi) then
                                nuRecMorTotalSusc := nuRecMorTotalSusc +
                                                     tbResumeSusc(nuIndex).saldactu +
                                                     tbResumeSusc(nuIndex).saldvenc;
                                nuIndexLatCha := null;

                            end if;
                            nuIndexLatCha := tbRecaMora.next(nuIndexLatCha);
                    end loop;

                    nuIndex := tbResumeSusc.next(nuIndex);

                end loop;
                return (nuRecMorTotalSusc + nuPunProdTotal)*nuPercentage/100;
            end if;
        -----------------------------------------------------------------------------------------
        ---- CONSULTA POR PRODUCTO
        ------------------------------------------------------------------------------------------
        else --- Se traen los datos por producto

            if(pktblservsusc.fsbgetsesuesfn(inuSesu) = 'C') then --- Si esta castigado va directamente a CARGOS
                if(inuType = 1) then --- Intereses
                    pkErrors.pop;
                    return (nvl(fnuGetPunValue(inuSesu,sbFinanConcepts),0)*nuPercentage/100);
                elsif (inuType = 2) then --- Valor Recargo por Mora
                    pkErrors.pop;
                    return (nvl(fnuGetPunValue(inuSesu,sbRecMorConcepts),0)*nuPercentage/100);
                end if;

            else
                fa_boaccountstatustodate.ProductBalanceAccountsToDate
                (
                        inuSesu,
                        sysdate,
                        nucurrentaccounttotal   ,
                        nudeferredaccounttotal ,
                        nucreditbalance        ,
                        nuclaimvalue           ,
                        nudefclaimvalue        ,
                        tbBalanceAcc,
                        tbDeferredBal
                );

                if(inuType = 1) then --- Intereses
                    nuIdxProdDef := tbDeferredBal.first;
                    loop
                        exit when (nuIdxProdDef IS null);
                        nuIndexIntDef :=  tbIntFinan.first; --- Indice que recorre los conceptos de financiacion
                        loop
                            exit when (nuIndexIntDef is null);
                                -- Si el concepto del producto a consultar es igual al del parametro entonces acumula
                                if(tbIntFinan(nuIndexIntDef) = tbDeferredBal(nuIdxProdDef).conccodi) then
                                    nuDefTotalProd := nuDefTotalProd + tbDeferredBal(nuIdxProdDef).saldvalo;
                                    nuIndexIntDef := null;

                                end if;
                                nuIndexIntDef := tbIntFinan.next(nuIndexIntDef);

                        end loop;
                        nuIdxProdDef := tbDeferredBal.next(nuIdxProdDef);
                    end loop;
                    pkErrors.Pop;
                    return nuDefTotalProd*nuPercentage/100;

                elsif (inuType = 2) then --- Valor Recargo por Mora
                    nuIdxProdLatChar := tbBalanceAcc.first;
                    loop
                        exit when (nuIdxProdLatChar is null);
                        nuIndexLatCha :=  tbRecaMora.first; --- Indice que recorre los conceptos de recargo por mora
                        loop
                            exit when (nuIndexLatCha is null);

                            -- Si el concepto del producto a consultar es igual al del parametro entonces acumula
                            if(tbRecaMora(nuIndexLatCha) = tbBalanceAcc(nuIdxProdLatChar).conccodi) then
                                nuRecMorTotalProd := nuRecMorTotalProd + tbBalanceAcc(nuIdxProdLatChar).saldvalo;
                                nuIndexLatCha := null;

                            end if;
                            nuIndexLatCha := tbRecaMora.next(nuIndexLatCha);
                        end loop;

                        nuIdxProdLatChar := tbBalanceAcc.next(nuIdxProdLatChar);

                    end loop;
                    pkErrors.Pop;
                    return nuRecMorTotalProd*nuPercentage/100;
                end if;
            end if;
        end if;

        pkErrors.Pop;

        return null;-------------------------

    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.Pop;
            return null;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.Pop;
            return null;

        when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
            pkErrors.Pop;
            return null;
    --}
    END fnuGetDefRecaM;

    /**********************************************************************
        Propiedad intelectual de GDO (c).

        Nombre  :   fsbGetLdc_Osf_Sesucier
        Autor   :   Francisco Romero

        Descripcion :   Retorna Usuarios en Cartera solo Brilla, inucur = 1, inueda = 0 y inucar = 0.
                        Retorna Usuarios en Cartera solo Seguro, inucur = 2, inueda = 0 y inucar = 0.
                        Retorna Usuarios en Cartera Brilla y Seguro, inucur = 3, inueda = 0 y inucar = 0.
                        Retorna Usuarios Refinanciados con Brilla y Seguro, inucur = 4, inueda = 0 y inucar = 0.
                        Retorna Usuarios y Cartera con Brilla y Seguro, inucur = 5, inueda = 0(PMES) o 30(30 dias)
                        o 60(60 dias) o 90(90 dias) o 120(120 dias) o 150(150 dias) o 180(180 dias)
                        y inucar = 1(para traer # usuarios) o 2(para traer el valor de la cartera).
                        Retorna Usuarios y Cartera con Brilla y Seguro, inucur = 6, inueda = 0
                        y inucar = 1(para traer # usuarios) o 2(para traer el valor de la cartera).
                        Retorna Usuarios y Cartera con Brilla y Seguro, inucur = 7, inueda = 0
                        y inucar = 1(para traer # usuarios) o 2(para traer el valor de la cartera).
                        Los parametros inuano y inumes son ano y mes a consultar.

        Historia de Modificaciones
        Fecha         Autor             Modificacion
        ============  ================  ==============================
        07-04-2014    Francisco Romero  Creacion
    ***********************************************************************/
    FUNCTION fsbGetLdc_Osf_Sesucier
    (
        inucur IN NUMBER,
        inuano IN LDC_OSF_SESUCIER.NUANO%TYPE,
        inumes IN LDC_OSF_SESUCIER.NUMES%TYPE,
        inueda IN LDC_OSF_SESUCIER.EDAD%TYPE,
        inucar IN NUMBER
    )
    RETURN NUMBER
    IS
        nuErrorCode NUMBER;
        sbErrorMessage VARCHAR2(4000);

        CURSOR cuBrilla
        IS
          SELECT B.NUANO ANO, B.NUMES MES, B.EDAD, COUNT(DISTINCT B.CONTRATO) USUARIOS
          FROM LDC_OSF_SESUCIER B
          WHERE B.TIPO_PRODUCTO = 7055
          AND NVL(B.SESUSAPE,0) + NVL(B.DEUDA_NO_CORRIENTE,0) > 0
          AND NOT EXISTS(SELECT 'X' FROM LDC_OSF_SESUCIER S
                                    WHERE S.CONTRATO = B.CONTRATO
                                    AND S.TIPO_PRODUCTO = 7053
                                    AND NVL(S.SESUSAPE,0) + NVL(S.DEUDA_NO_CORRIENTE,0) > 0
                                    AND S.NUANO = B.NUANO AND S.NUMES = B.NUMES)
          AND B.NUANO = inuano
          AND B.NUMES = inumes
          GROUP BY B.NUANO, B.NUMES, B.EDAD;

        CURSOR cuSeguros
        IS
          SELECT B.NUANO ANO, B.NUMES MES, B.EDAD, COUNT(DISTINCT B.CONTRATO) USUARIOS
          FROM LDC_OSF_SESUCIER B
          WHERE B.TIPO_PRODUCTO = 7053
          AND NVL(B.SESUSAPE,0) + NVL(B.DEUDA_NO_CORRIENTE,0) > 0
          AND NOT EXISTS(SELECT 'X' FROM LDC_OSF_SESUCIER S
                                    WHERE S.CONTRATO = B.CONTRATO
                                    AND S.TIPO_PRODUCTO = 7055
                                    AND NVL(S.SESUSAPE,0) + NVL(S.DEUDA_NO_CORRIENTE,0) > 0
                                    AND S.NUANO = B.NUANO AND S.NUMES = B.NUMES)
          AND B.NUANO = inuano
          AND B.NUMES = inumes
          GROUP BY B.NUANO, B.NUMES, B.EDAD;

        CURSOR cuBriSeg
        IS
          SELECT D.NUANO ANO, D.NUMES MES, D.EDAD, COUNT(DISTINCT D.CONTRATO) USUARIOS
          FROM LDC_OSF_SESUCIER D
          WHERE D.TIPO_PRODUCTO IN (7053,7055)
          AND EXISTS(
          SELECT B.NUANO ANO, B.NUMES MES, B.CONTRATO
          FROM LDC_OSF_SESUCIER B
          WHERE B.TIPO_PRODUCTO = 7053
          AND NVL(B.SESUSAPE,0) + NVL(B.DEUDA_NO_CORRIENTE,0) > 0
          AND B.CONTRATO = D.CONTRATO
          AND B.NUANO = D.NUANO AND B.NUMES =D.NUMES
          AND EXISTS(SELECT 'X' FROM LDC_OSF_SESUCIER S
                                WHERE S.CONTRATO = B.CONTRATO
                                AND S.TIPO_PRODUCTO = 7055
                                AND NVL(S.SESUSAPE,0) + NVL(S.DEUDA_NO_CORRIENTE,0) > 0
                                AND S.NUANO = B.NUANO AND S.NUMES = B.NUMES)
          GROUP BY B.NUANO, B.NUMES, B.CONTRATO)
          AND D.NUANO = inuano
          AND D.NUMES = inumes
          GROUP BY D.NUANO, D.NUMES, D.EDAD;

        CURSOR cuRefinan
        IS
          SELECT *
            FROM(
          SELECT contrato,sum(brilla) brilla,sum(seguro) seguro
            FROM(
            SELECT d.difeano,d.difemes,d.difecodi,d.difecofi,d.difesusc contrato,d.difevatd,d.difesape brilla,0 as seguro
              FROM ldc_osf_sesucier s,ldc_osf_diferido d
             WHERE s.nuano         = inuano
               AND s.numes         = inumes
               AND s.tipo_producto = 7055
               AND d.difeprog      IN('GCNED','FINAN')
               AND d.difesape       > 0
               AND s.producto      = d.difenuse
               AND s.nuano         = d.difeano
               AND s.numes         = d.difemes
            UNION ALL
            SELECT d.difeano,d.difemes,d.difecodi,d.difecofi,d.difesusc,d.difevatd,0 AS brilla,DIFESAPE as seguro
              FROM ldc_osf_sesucier s,ldc_osf_diferido d
             WHERE s.nuano         = inuano
               AND s.numes         = inumes
               AND s.tipo_producto = 7053
               AND d.difeprog      IN('GCNED','FINAN')
               AND d.difesape       > 0
               AND s.producto      = d.difenuse
               AND s.nuano         = d.difeano
               AND s.numes         = d.difemes
              )
          GROUP BY CONTRATO
          )
          WHERE brilla > 0 AND SEGURO > 0;

        CURSOR cuEdad
        IS
          SELECT D.NUANO ANO, D.NUMES MES, SUM(NVL(D.SESUSAPE,0) + NVL(D.DEUDA_NO_CORRIENTE,0)) PMES, COUNT(DISTINCT D.CONTRATO) USUARIOS
          FROM LDC_OSF_SESUCIER D
          WHERE D.TIPO_PRODUCTO IN (7053,7055)
          AND D.EDAD = inueda
          AND EXISTS(
          SELECT B.NUANO ANO, B.NUMES MES, B.CONTRATO
          FROM LDC_OSF_SESUCIER B
          WHERE B.TIPO_PRODUCTO = 7053
          AND NVL(B.SESUSAPE,0) + NVL(B.DEUDA_NO_CORRIENTE,0) > 0
          AND B.CONTRATO = D.CONTRATO
          AND B.NUANO = D.NUANO AND B.NUMES =D.NUMES
          AND EXISTS(SELECT 'X' FROM LDC_OSF_SESUCIER S
                                WHERE S.CONTRATO = B.CONTRATO
                                AND S.TIPO_PRODUCTO = 7055
                                AND NVL(S.SESUSAPE,0) + NVL(S.DEUDA_NO_CORRIENTE,0) > 0
                                AND S.NUANO = B.NUANO AND S.NUMES = B.NUMES)
          GROUP BY B.NUANO, B.NUMES, B.CONTRATO)
          AND D.NUANO = inuano
          AND D.NUMES = inumes
          GROUP BY D.NUANO, D.NUMES;

        CURSOR cuEdad2
        IS
          SELECT D.NUANO ANO, D.NUMES MES, SUM(NVL(D.SESUSAPE,0) + NVL(D.DEUDA_NO_CORRIENTE,0)) PMES, COUNT(DISTINCT D.CONTRATO) USUARIOS
          FROM LDC_OSF_SESUCIER D
          WHERE D.TIPO_PRODUCTO IN (7053,7055)
          AND D.EDAD BETWEEN 210 AND 360
          AND EXISTS(
          SELECT B.NUANO ANO, B.NUMES MES, B.CONTRATO
          FROM LDC_OSF_SESUCIER B
          WHERE B.TIPO_PRODUCTO = 7053
          AND NVL(B.SESUSAPE,0) + NVL(B.DEUDA_NO_CORRIENTE,0) > 0
          AND B.CONTRATO = D.CONTRATO
          AND B.NUANO = D.NUANO AND B.NUMES =D.NUMES
          AND EXISTS(SELECT 'X' FROM LDC_OSF_SESUCIER S
                                WHERE S.CONTRATO = B.CONTRATO
                                AND S.TIPO_PRODUCTO = 7055
                                AND NVL(S.SESUSAPE,0) + NVL(S.DEUDA_NO_CORRIENTE,0) > 0
                                AND S.NUANO = B.NUANO AND S.NUMES = B.NUMES)
          GROUP BY B.NUANO, B.NUMES, B.CONTRATO)
          AND D.NUANO = inuano
          AND D.NUMES = inumes
          GROUP BY D.NUANO, D.NUMES;

        CURSOR cuEdad3
        IS
          SELECT D.NUANO ANO, D.NUMES MES, SUM(NVL(D.SESUSAPE,0) + NVL(D.DEUDA_NO_CORRIENTE,0)) PMES, COUNT(DISTINCT D.CONTRATO) USUARIOS
          FROM LDC_OSF_SESUCIER D
          WHERE D.TIPO_PRODUCTO IN (7053,7055)
          AND D.EDAD > 360
          AND EXISTS(
          SELECT B.NUANO ANO, B.NUMES MES, B.CONTRATO
          FROM LDC_OSF_SESUCIER B
          WHERE B.TIPO_PRODUCTO = 7053
          AND NVL(B.SESUSAPE,0) + NVL(B.DEUDA_NO_CORRIENTE,0) > 0
          AND B.CONTRATO = D.CONTRATO
          AND B.NUANO = D.NUANO AND B.NUMES =D.NUMES
          AND EXISTS(SELECT 'X' FROM LDC_OSF_SESUCIER S
                                WHERE S.CONTRATO = B.CONTRATO
                                AND S.TIPO_PRODUCTO = 7055
                                AND NVL(S.SESUSAPE,0) + NVL(S.DEUDA_NO_CORRIENTE,0) > 0
                                AND S.NUANO = B.NUANO AND S.NUMES = B.NUMES)
          GROUP BY B.NUANO, B.NUMES, B.CONTRATO)
          AND D.NUANO = inuano
          AND D.NUMES = inumes
          GROUP BY D.NUANO, D.NUMES;

        nusuarios number;
        ncarteras number(15,2);
        rcBrilla  cuBrilla%rowtype;
        rcSeguros cuSeguros%rowtype;
        rcBriSeg  cuBriSeg%rowtype;
        rcRefinan cuRefinan%rowtype;
        rcEdad    cuEdad%rowtype;
        rcEdad2   cuEdad2%rowtype;
        rcEdad3   cuEdad3%rowtype;

    BEGIN

        pkErrors.push('LDC_ReportesConsulta.fsbGetLdc_Osf_Sesucier');

        nusuarios := 0;
        ncarteras := 0;

        IF(inucur = 1) THEN
            IF(cuBrilla%isopen)then
                close cuBrilla;
            END if;

            OPEN  cuBrilla;
            FETCH cuBrilla INTO rcBrilla;
            LOOP

              --IF (rcBrilla.Ano = inuano AND rcBrilla.Mes = inumes) THEN
                nusuarios := NVL(nusuarios,0) + NVL(rcBrilla.Usuarios,0);
              --END IF;

              FETCH cuBrilla INTO rcBrilla;
              EXIT WHEN (cuBrilla%notfound);
            END LOOP;
            CLOSE cuBrilla;

            RETURN nusuarios;
        END IF;

        IF(inucur = 2) THEN
            IF(cuSeguros%isopen)then
                close cuSeguros;
            END if;

            OPEN  cuSeguros;
            FETCH cuSeguros INTO rcSeguros;
            LOOP

              --IF (rcSeguros.Ano = inuano AND rcSeguros.Mes = inumes) THEN
                nusuarios := NVL(nusuarios,0) + NVL(rcSeguros.Usuarios,0);
              --END IF;

              FETCH cuSeguros INTO rcSeguros;
              EXIT WHEN (cuSeguros%notfound);
            END LOOP;
            CLOSE cuSeguros;

            RETURN nusuarios;
        END IF;

        IF(inucur = 3) THEN
            IF(cuBriSeg%isopen)then
                close cuBriSeg;
            END if;

            OPEN  cuBriSeg;
            FETCH cuBriSeg INTO rcBriSeg;
            LOOP

              --IF (rcBriSeg.Ano = inuano AND rcBriSeg.Mes = inumes) THEN
                nusuarios := NVL(nusuarios,0) + NVL(rcBriSeg.Usuarios,0);
              --END IF;

              FETCH cuBriSeg INTO rcBriSeg;
              EXIT WHEN (cuBriSeg%notfound);
            END LOOP;
            CLOSE cuBriSeg;

            RETURN nusuarios;
        END IF;

        IF(inucur = 4) THEN
            IF(cuRefinan%isopen)then
                close cuRefinan;
            END if;

            OPEN  cuRefinan;
            FETCH cuRefinan INTO rcRefinan;
            LOOP
              IF rcRefinan.Contrato IS NOT NULL THEN
                 nusuarios := nusuarios + 1;
              END IF;
              FETCH cuRefinan INTO rcRefinan;
              EXIT WHEN (cuRefinan%notfound);
            END LOOP;
            CLOSE cuRefinan;

            RETURN nusuarios;
        END IF;

        IF(inucur = 5) THEN
            IF(cuEdad%isopen)then
                close cuEdad;
            END if;

            OPEN  cuEdad;
            FETCH cuEdad INTO rcEdad;
            LOOP

              --IF (rcEdad.Ano = inuano AND rcEdad.Mes = inumes) THEN
                IF inucar = 1 THEN
                   nusuarios := NVL(nusuarios,0) + NVL(rcEdad.Usuarios,0);
                ELSE
                   ncarteras := NVL(ncarteras,0) + NVL(rcEdad.Pmes,0);
                END IF;
              --END IF;

              FETCH cuEdad INTO rcEdad;
              EXIT WHEN (cuEdad%notfound);
            END LOOP;
            CLOSE cuEdad;

            IF inucar = 1 THEN
               RETURN nusuarios;
            ELSE
               RETURN ncarteras;
            END IF;

        END IF;

        IF(inucur = 6) THEN
            IF(cuEdad2%isopen)then
                close cuEdad2;
            END if;

            OPEN  cuEdad2;
            FETCH cuEdad2 INTO rcEdad2;
            LOOP

              --IF (rcEdad2.Ano = inuano AND rcEdad2.Mes = inumes) THEN
                IF inucar = 1 THEN
                   nusuarios := NVL(nusuarios,0) + NVL(rcEdad2.Usuarios,0);
                ELSE
                   ncarteras := NVL(ncarteras,0) + NVL(rcEdad2.Pmes,0);
                END IF;
              --END IF;

              FETCH cuEdad2 INTO rcEdad2;
              EXIT WHEN (cuEdad2%notfound);
            END LOOP;
            CLOSE cuEdad2;

            IF inucar = 1 THEN
               RETURN nusuarios;
            ELSE
               RETURN ncarteras;
            END IF;

        END IF;

        IF(inucur = 7) THEN
            IF(cuEdad3%isopen)then
                close cuEdad3;
            END if;

            OPEN  cuEdad3;
            FETCH cuEdad3 INTO rcEdad3;
            LOOP

              --IF (rcEdad3.Ano = inuano AND rcEdad3.Mes = inumes) THEN
                IF inucar = 1 THEN
                   nusuarios := NVL(nusuarios,0) + NVL(rcEdad3.Usuarios,0);
                ELSE
                   ncarteras := NVL(ncarteras,0) + NVL(rcEdad3.Pmes,0);
                END IF;
              --END IF;

              FETCH cuEdad3 INTO rcEdad3;
              EXIT WHEN (cuEdad3%notfound);
            END LOOP;
            CLOSE cuEdad3;

            IF inucar = 1 THEN
               RETURN nusuarios;
            ELSE
               RETURN ncarteras;
            END IF;

        END IF;

    EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
          pkErrors.pop;
          RETURN NULL;
      WHEN OTHERS THEN
          Errors.setError;
          pkErrors.pop;
          RETURN NULL;
    END fsbGetLdc_Osf_Sesucier;

    /*****************************************************************
    Propiedad intelectual de LDC (c).

    Unidad         : fnuGetLastRead
    Descripción    : Retorna el valor de de la última lectura que no fue facturada
                     por el método de estimación

    Autor          : Carlos Alberto Ramirez Herrera
    Fecha          : 16-06-2014

    Parametros         Descripcion
    ============	===================

    Historia de Modificaciones

    24/09/2014  carlosr.Arqs
    Se modifica el método para que traiga la lectura anterior al periodo que se
    está corriendo

    16-06-2014  carlosr
    Creacion

    ******************************************************************/
    FUNCTION fnuGetLastRead
    (
        inuperifact in perifact.pefacodi%type,
        inuservsusc in servsusc.sesunuse%type
    )
    RETURN number
    IS
        CURSOR cuGetLeanLectMenor
        IS
            SELECT  leemleto
            FROM    (
                SELECT  *
                FROM    lectelme
                WHERE   leemsesu = inuservsusc
                AND     leempefa < inuperifact --- Esta es para que escoja la menor al periodo que se está corriendo.

                AND     not exists
                        (SELECT cosspefa
                         FROM   conssesu
                         WHERE  cossmecc = 3
                         AND    leempefa = cosspefa
                         AND    cosssesu = leemsesu

                        )
                ORDER BY leempefa desc
            )
            WHERE   rownum = 1;

        nuLean  number;
    BEGIN
        pkErrors.Push('LDC_ReportesConsulta.fnuGetLastRead');

        open    cuGetLeanLectMenor;
        fetch   cuGetLeanLectMenor into nuLean;
        close   cuGetLeanLectMenor;

        pkErrors.pop;

        return nuLean;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            return null;
        when others then
            return null;
    END fnuGetLastRead;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuVentasBrilla
    Descripci?n    : Retorna el valor de las ventas de brilla,
                     suma cero si las ventas no son efectivas, en proceso o anuladas en la entrega

    Autor          : Francisco Jose Romero Romero
    Fecha          : 14-10-2014

    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    -----------  -------------------    -------------------------------------

    14-10-2013   FRAROM
    Creacion
    ******************************************************************/


    FUNCTION  fnuVentasBrilla (nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type,
                               nuFechai          mo_packages.REQUEST_DATE%type,
                               nuFechaf          mo_packages.REQUEST_DATE%type)
    RETURN NUMBER
    IS

        nuVenta NUMBER;

        CURSOR cuVenta IS
        SELECT DISTINCT
               (NVL(DF.VALUE,0) * NVL(DF.AMOUNT,0)) + NVL(DF.IVA,0) VALOR_VENTA,
               DECODE(DF.STATE,'EP',DECODE(O1.TASK_TYPE_ID,10143,'REGISTRADO',DECODE(O1.ORDER_STATUS_ID,5,'EN_PROCESO_A/D','ENTREGADO')),'RE',DECODE(O1.ORDER_STATUS_ID,8,DECODE(O1.TASK_TYPE_ID,10143,'REGISTRADO','ENTREGADO'),'REGISTRADO'),'AN','ANULADO','PA','APROBACION') ESTADO_ENTREGA,
               DF.ITEM_WORK_ORDER_ID
        FROM MO_PACKAGES P1 LEFT JOIN OR_ORDER_ACTIVITY OA1 ON OA1.PACKAGE_ID = P1.PACKAGE_ID AND OA1.ACTIVITY_ID IN (4000822,4294427)
                                 LEFT JOIN OR_ORDER O1 ON O1.ORDER_ID = OA1.ORDER_ID AND O1.TASK_TYPE_ID IN (12590,10143)
                                 LEFT JOIN LD_ITEM_WORK_ORDER DF ON DF.ORDER_ACTIVITY_ID = OA1.ORDER_ACTIVITY_ID,
             LD_NON_BA_FI_REQU V
        WHERE V.NON_BA_FI_REQU_ID = P1.PACKAGE_ID
        AND ((O1.TASK_TYPE_ID = 12590) OR (O1.TASK_TYPE_ID = 10143 AND NOT EXISTS(SELECT OA3.ORDER_ID FROM OR_ORDER_ACTIVITY OA3 WHERE OA3.PACKAGE_ID = P1.PACKAGE_ID AND OA3.TASK_TYPE_ID = 12590)))
        AND P1.REQUEST_DATE >=  TO_DATE(TO_CHAR(nuFechai,'dd/mm/yyyy') || '00:00:00','dd/mm/yyyy hh24:mi:ss')
        AND P1.REQUEST_DATE <=  TO_DATE(TO_CHAR(nuFechaf,'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')
        AND P1.SUBSCRIPTION_PEND_ID = nuSUBSCRIPTION_ID;

        rcVenta  cuVenta%rowtype;

    BEGIN
        -- Estados de la venta/entrega:
        -- 'REGISTRADO'
        -- 'EN_PROCESO_A/D'
        -- 'APROBACION'
        -- 'ENTREGADO'
        -- 'ANULADO'

        nuVenta := 0;

        IF(cuVenta%ISOPEN)THEN
            CLOSE cuVenta;
        END IF;

        OPEN  cuVenta;

        FETCH cuVenta INTO rcVenta;
        LOOP
              IF rcVenta.Estado_Entrega = 'ENTREGADO' THEN
                 nuVenta := NVL(nuVenta,0) + NVL(rcVenta.Valor_Venta,0);
              ELSE
                 nuVenta := NVL(nuVenta,0) + 0;
              END IF;

        FETCH cuVenta INTO rcVenta;
        EXIT WHEN (cuVenta%notfound);
        END LOOP;

        CLOSE cuVenta;

        -- Retorna el valor calculado
        RETURN nuVenta;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RETURN NULL;
        WHEN OTHERS THEN
            RETURN NULL;
    END fnuVentasBrilla;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuHabitoPago
    Descripci?n    : Retorna el habito de pago de un servicio suscrito

    Autor          : Francisco Jose Romero Romero
    Fecha          : 21-10-2014

    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    -----------  -------------------    -------------------------------------

    21-10-2013   FRAROM
    Creacion
    ******************************************************************/


    FUNCTION  fnuHabitoPago (nusesunuse servsusc.sesunuse%type,
                             nusesususc servsusc.sesususc%type,
                             nusesuserv servsusc.sesuserv%type,
                             nuano1     NUMBER,
                             numes1     NUMBER)
    RETURN VARCHAR2
    IS

        nuHabito VARCHAR2(200);
        nuCuva   NUMBER;
        nuCuab   NUMBER;
        nuFact   NUMBER;

        CURSOR cuEdadMora IS
        SELECT DECODE(SC.EDAD,-1,0,SC.EDAD) EDAD
        FROM LDC_OSF_SESUCIER SC
        WHERE SC.PRODUCTO = nusesunuse
        AND SC.CONTRATO = nusesususc
        AND SC.TIPO_PRODUCTO = nusesuserv
        AND SC.NUANO = nuano1
        AND SC.NUMES = numes1
        AND ROWNUM = 1;

        CURSOR cuFact IS
        SELECT FC.FACTCODI
        FROM FACTURA FC, PERIFACT PF, LDC_CIERCOME LC2
        WHERE PF.PEFACODI = FC.FACTPEFA
        AND PF.PEFAANO = LC2.CICOANO
        AND PF.PEFAMES = LC2.CICOMES
        AND FC.FACTFEGE BETWEEN LC2.CICOFEIN AND LC2.CICOFECH
        AND LC2.CICOANO = nuano1
        AND LC2.CICOMES = numes1
        AND FC.FACTSUSC = nusesususc;

        CURSOR cuCuenta(prFact CUENCOBR.CUCOFACT%type) IS
        SELECT CT.CUCOVAFA, CT.CUCOVAAB
        FROM CUENCOBR CT
        WHERE CT.CUCONUSE = (SELECT SS.SESUNUSE
                                    FROM SERVSUSC SS
                                    WHERE SS.SESUSUSC = nusesususc
                                    AND SS.SESUSERV = 7014
                                    AND ROWNUM = 1)
        AND CT.CUCOFACT = prFact;

        rcEdadMora   cuEdadMora%rowtype;
        rcCuenta     cuCuenta%rowtype;
        rcFact       cuFact%rowtype;

    BEGIN

        nuHabito := NULL;

        IF(cuEdadMora%ISOPEN)THEN
            CLOSE cuEdadMora;
        END IF;

        OPEN  cuEdadMora;

        FETCH cuEdadMora INTO rcEdadMora;
        LOOP
              nuHabito := rcEdadMora.Edad||' - ';

        FETCH cuEdadMora INTO rcEdadMora;
        EXIT WHEN (cuEdadMora%notfound);
        END LOOP;

        CLOSE cuEdadMora;

        nuCuva := 0;
        nuCuab := 0;

        IF(cuFact%ISOPEN)THEN
            CLOSE cuFact;
        END IF;

        OPEN cuFact;

        FETCH cuFact INTO rcFact;
        LOOP

          nuFact := rcFact.Factcodi;

          FOR rcCuenta IN cuCuenta(nuFact)LOOP
            nuCuva := nuCuva + NVL(rcCuenta.Cucovafa,0);
            nuCuab := nuCuab + NVL(rcCuenta.Cucovaab,0);
          END LOOP;

        FETCH cuFact INTO rcFact;
        EXIT WHEN (cuFact%notfound);
        END LOOP;

        CLOSE cuFact;

        nuHabito := NVL(nuHabito,0)||nuCuva||' - '||nuCuab;

        -- Retorna el valor calculado
        RETURN nuHabito;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RETURN NULL;
        WHEN OTHERS THEN
            RETURN NULL;
    END fnuHabitoPago;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuVentasBrillaTotales
    Descripci?n    : Retorna el valor de las ventas de brilla,
                     suma cero si las ventas no son efectivas, en proceso o anuladas en la entrega
                     (totales)sin usar rango de fechas

    Autor          : Francisco Jose Romero Romero
    Fecha          : 27-10-2014

    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    -----------  -------------------    -------------------------------------

    27-10-2013   FRAROM
    Creacion
    ******************************************************************/


    FUNCTION  fnuVentasBrillaTotales (nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type)
    RETURN NUMBER
    IS

        nuVenta NUMBER;

        CURSOR cuVenta IS
        SELECT DISTINCT
               (NVL(DF.VALUE,0) * NVL(DF.AMOUNT,0)) + NVL(DF.IVA,0) VALOR_VENTA,
               DECODE(DF.STATE,'EP',DECODE(O1.TASK_TYPE_ID,10143,'REGISTRADO',DECODE(O1.ORDER_STATUS_ID,5,'EN_PROCESO_A/D','ENTREGADO')),'RE',DECODE(O1.ORDER_STATUS_ID,8,DECODE(O1.TASK_TYPE_ID,10143,'REGISTRADO','ENTREGADO'),'REGISTRADO'),'AN','ANULADO','PA','APROBACION') ESTADO_ENTREGA,
               DF.ITEM_WORK_ORDER_ID
        FROM MO_PACKAGES P1 LEFT JOIN OR_ORDER_ACTIVITY OA1 ON OA1.PACKAGE_ID = P1.PACKAGE_ID AND OA1.ACTIVITY_ID IN (4000822,4294427)
                                 LEFT JOIN OR_ORDER O1 ON O1.ORDER_ID = OA1.ORDER_ID AND O1.TASK_TYPE_ID IN (12590,10143)
                                 LEFT JOIN LD_ITEM_WORK_ORDER DF ON DF.ORDER_ACTIVITY_ID = OA1.ORDER_ACTIVITY_ID,
             LD_NON_BA_FI_REQU V
        WHERE V.NON_BA_FI_REQU_ID = P1.PACKAGE_ID
        AND ((O1.TASK_TYPE_ID = 12590) OR (O1.TASK_TYPE_ID = 10143 AND NOT EXISTS(SELECT OA3.ORDER_ID FROM OR_ORDER_ACTIVITY OA3 WHERE OA3.PACKAGE_ID = P1.PACKAGE_ID AND OA3.TASK_TYPE_ID = 12590)))
        AND P1.SUBSCRIPTION_PEND_ID = nuSUBSCRIPTION_ID;

        rcVenta  cuVenta%rowtype;

    BEGIN
        -- Estados de la venta/entrega:
        -- 'REGISTRADO'
        -- 'EN_PROCESO_A/D'
        -- 'APROBACION'
        -- 'ENTREGADO'
        -- 'ANULADO'

        nuVenta := 0;

        IF(cuVenta%ISOPEN)THEN
            CLOSE cuVenta;
        END IF;

        OPEN  cuVenta;

        FETCH cuVenta INTO rcVenta;
        LOOP
              IF rcVenta.Estado_Entrega = 'ENTREGADO' THEN
                 nuVenta := NVL(nuVenta,0) + NVL(rcVenta.Valor_Venta,0);
              ELSE
                 nuVenta := NVL(nuVenta,0) + 0;
              END IF;

        FETCH cuVenta INTO rcVenta;
        EXIT WHEN (cuVenta%notfound);
        END LOOP;

        CLOSE cuVenta;

        -- Retorna el valor calculado
        RETURN nuVenta;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RETURN NULL;
        WHEN OTHERS THEN
            RETURN NULL;
    END fnuVentasBrillaTotales;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuVentasBrillaCantidad
    Descripci?n    : Retorna la cantidad de las ventas de brilla efectivas

    Autor          : Francisco Jose Romero Romero
    Fecha          : 27-10-2014

    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    -----------  -------------------    -------------------------------------

    27-10-2013   FRAROM
    Creacion
    ******************************************************************/


    FUNCTION  fnuVentasBrillaCantidad (nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type)
    RETURN NUMBER
    IS

        nuVenta NUMBER;

        CURSOR cuVenta IS
        SELECT COUNT(DISTINCT(P1.PACKAGE_ID)) CANTIDAD
        FROM MO_PACKAGES P1 LEFT JOIN OR_ORDER_ACTIVITY OA1 ON OA1.PACKAGE_ID = P1.PACKAGE_ID AND OA1.ACTIVITY_ID IN (4000822,4294427)
                                 LEFT JOIN OR_ORDER O1 ON O1.ORDER_ID = OA1.ORDER_ID AND O1.TASK_TYPE_ID IN (12590,10143)
                                 LEFT JOIN LD_ITEM_WORK_ORDER DF ON DF.ORDER_ACTIVITY_ID = OA1.ORDER_ACTIVITY_ID,
             LD_NON_BA_FI_REQU V
        WHERE V.NON_BA_FI_REQU_ID = P1.PACKAGE_ID
        AND ((O1.TASK_TYPE_ID = 12590) OR (O1.TASK_TYPE_ID = 10143 AND NOT EXISTS(SELECT OA3.ORDER_ID FROM OR_ORDER_ACTIVITY OA3 WHERE OA3.PACKAGE_ID = P1.PACKAGE_ID AND OA3.TASK_TYPE_ID = 12590)))
        AND P1.SUBSCRIPTION_PEND_ID = nuSUBSCRIPTION_ID
        AND DECODE(DF.STATE,'EP',DECODE(O1.TASK_TYPE_ID,10143,'REGISTRADO',DECODE(O1.ORDER_STATUS_ID,5,'EN_PROCESO_A/D','ENTREGADO')),'RE',DECODE(O1.ORDER_STATUS_ID,8,DECODE(O1.TASK_TYPE_ID,10143,'REGISTRADO','ENTREGADO'),'REGISTRADO'),'AN','ANULADO','PA','APROBACION') = 'ENTREGADO';

        rcVenta  cuVenta%rowtype;

    BEGIN

        nuVenta := 0;

        IF(cuVenta%ISOPEN)THEN
            CLOSE cuVenta;
        END IF;

        OPEN  cuVenta;

        FETCH cuVenta INTO rcVenta;
        LOOP
              nuVenta := NVL(rcVenta.Cantidad,0);
        FETCH cuVenta INTO rcVenta;
        EXIT WHEN (cuVenta%notfound);
        END LOOP;

        CLOSE cuVenta;

        -- Retorna el valor calculado
        RETURN nuVenta;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RETURN NULL;
        WHEN OTHERS THEN
            RETURN NULL;
    END fnuVentasBrillaCantidad;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuVentasBrillaProductos
    Descripci?n    : Retorna los productos adquiridos en la ventas efectivas totales del contrato.

    Autor          : Francisco Jose Romero Romero
    Fecha          : 27-10-2014

    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    -----------  -------------------    -------------------------------------

    27-10-2013   FRAROM
    Creacion
    ******************************************************************/


    FUNCTION  fnuVentasBrillaProductos (nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type)
    RETURN VARCHAR2
    IS

        nuVenta VARCHAR2(32000);

        CURSOR cuVenta IS
        SELECT DISTINCT
               (NVL(DF.VALUE,0) * NVL(DF.AMOUNT,0)) + NVL(DF.IVA,0) VALOR_VENTA,
               DECODE(DF.STATE,'EP',DECODE(O1.TASK_TYPE_ID,10143,'REGISTRADO',DECODE(O1.ORDER_STATUS_ID,5,'EN_PROCESO_A/D','ENTREGADO')),'RE',DECODE(O1.ORDER_STATUS_ID,8,DECODE(O1.TASK_TYPE_ID,10143,'REGISTRADO','ENTREGADO'),'REGISTRADO'),'AN','ANULADO','PA','APROBACION') ESTADO_ENTREGA,
               (SELECT AR.ARTICLE_ID||' - '||AR.DESCRIPTION FROM LD_ARTICLE AR WHERE AR.ARTICLE_ID = DF.ARTICLE_ID) ARTICULO,
               DF.ITEM_WORK_ORDER_ID
        FROM MO_PACKAGES P1 LEFT JOIN OR_ORDER_ACTIVITY OA1 ON OA1.PACKAGE_ID = P1.PACKAGE_ID AND OA1.ACTIVITY_ID IN (4000822,4294427)
                                 LEFT JOIN OR_ORDER O1 ON O1.ORDER_ID = OA1.ORDER_ID AND O1.TASK_TYPE_ID IN (12590,10143)
                                 LEFT JOIN LD_ITEM_WORK_ORDER DF ON DF.ORDER_ACTIVITY_ID = OA1.ORDER_ACTIVITY_ID,
             LD_NON_BA_FI_REQU V
        WHERE V.NON_BA_FI_REQU_ID = P1.PACKAGE_ID
        AND ((O1.TASK_TYPE_ID = 12590) OR (O1.TASK_TYPE_ID = 10143 AND NOT EXISTS(SELECT OA3.ORDER_ID FROM OR_ORDER_ACTIVITY OA3 WHERE OA3.PACKAGE_ID = P1.PACKAGE_ID AND OA3.TASK_TYPE_ID = 12590)))
        AND P1.SUBSCRIPTION_PEND_ID = nuSUBSCRIPTION_ID;

        rcVenta  cuVenta%rowtype;

    BEGIN
        -- Estados de la venta/entrega:
        -- 'REGISTRADO'
        -- 'EN_PROCESO_A/D'
        -- 'APROBACION'
        -- 'ENTREGADO'
        -- 'ANULADO'

        nuVenta := '';

        IF(cuVenta%ISOPEN)THEN
            CLOSE cuVenta;
        END IF;

        OPEN  cuVenta;

        FETCH cuVenta INTO rcVenta;
        LOOP
              IF rcVenta.Estado_Entrega = 'ENTREGADO' THEN
                 nuVenta := nuVenta||rcVenta.Articulo||' -- ';
              END IF;

        FETCH cuVenta INTO rcVenta;
        EXIT WHEN (cuVenta%notfound);
        END LOOP;

        CLOSE cuVenta;

        -- Retorna el valor calculado
        RETURN nuVenta;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RETURN NULL;
        WHEN OTHERS THEN
            RETURN NULL;
    END fnuVentasBrillaProductos;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuVecesConsumoRecuperado
    Descripci?n    : Retorna el numero de veces en el que el producto se le calculo el consumo con
                     metodo 5 (consumo recuperado) de los periodos anteriores consecutivamente al
                     periodo que se este consultando.

    Autor          : Francisco Jose Romero Romero
    Fecha          : 11-11-2014

    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    -----------  -------------------    -------------------------------------

    11-11-2013   FRAROM
    Creacion
    ******************************************************************/


    FUNCTION  fnuVecesConsumoRecuperado (nuYEAR NUMBER, nuMONTH NUMBER, nuSESUNUSE NUMBER, nuPEFACICL NUMBER)
    RETURN NUMBER
    IS

        nuVeces NUMBER;
        nuAAAA  NUMBER;
        nuMMMM  NUMBER;
        nuMecc  NUMBER;
        nuPeri  NUMBER;

    BEGIN

        nuVeces := 0;
        nuMecc  := 0;
        nuPeri  := 0;
        nuAAAA  := nuYEAR;
        nuMMMM  := nuMONTH;

        LOOP

          IF (nuMMMM - 1) = 0 THEN
             nuAAAA := nuAAAA - 1;
             nuMMMM := 12;
          ELSE
             nuMMMM := nuMMMM - 1;
          END IF;

          SELECT PF.PEFACODI INTO nuPeri
          FROM CONSSESU CN,
               PERIFACT PF
          WHERE CN.COSSSESU = nuSESUNUSE
          AND CN.COSSPEFA = PF.PEFACODI
          AND PF.PEFAANO = nuAAAA
          AND PF.PEFAMES = nuMMMM
          AND PF.PEFACICL = nuPEFACICL
          AND ROWNUM = 1;

          SELECT V.cossmecc INTO nuMecc
          FROM vw_cmprodconsumptions V
          WHERE V.cosssesu = nuSESUNUSE AND V.COSSPEFA = nuPeri;

          IF nuMecc = 5 THEN
            nuVeces := nuVeces + 1;
          END IF;

        EXIT WHEN (nuMecc <> 5);
        END LOOP;

        -- Retorna el valor calculado
        RETURN nuVeces;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RETURN NULL;
        WHEN OTHERS THEN
            RETURN NULL;
    END fnuVecesConsumoRecuperado;

    /*****************************************************************
    Propiedad intelectual de GDO (c).

    Unidad         : fnuCupousado
    Descripci?n    : Dado un contrato identifica con 1 (si el cupo fue usado) o cero (sin usar).

    Autor          : Francisco Jose Romero Romero
    Fecha          : 05-01-2015

    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    -----------  -------------------    -------------------------------------

    05-01-2014   FRAROM
    Creacion
    ******************************************************************/


    FUNCTION  fnuCupousado (nuSUBSCRIPTION_ID or_order_activity.SUBSCRIPTION_ID%type)
    RETURN NUMBER
    IS

        nuCusa NUMBER;

        CURSOR cuCusa IS
        SELECT COUNT(SS.SESUNUSE) CUPOUSADO
        FROM SERVSUSC SS
        WHERE SS.SESUSUSC = nuSUBSCRIPTION_ID AND SS.SESUSERV = 7055
        AND EXISTS(
        SELECT 'X' FROM DIFERIDO DF
        WHERE DF.DIFENUSE = SS.SESUNUSE
        AND DF.DIFEVATD > 0);

        rcCusa  cuCusa%rowtype;

    BEGIN

        nuCusa := 0;

        IF(cuCusa%ISOPEN)THEN
            CLOSE cuCusa;
        END IF;

        OPEN  cuCusa;

        FETCH cuCusa INTO rcCusa;
        LOOP
              nuCusa := rcCusa.Cupousado;

        FETCH cuCusa INTO rcCusa;
        EXIT WHEN (cuCusa%notfound);
        END LOOP;

        CLOSE cuCusa;

        -- Retorna el valor calculado
        RETURN nuCusa;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RETURN NULL;
        WHEN OTHERS THEN
            RETURN NULL;
    END fnuCupousado;

END LDC_ReportesConsulta;
/
PROMPT Otorgando permisos de ejecucion a LDC_REPORTESCONSULTA
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_REPORTESCONSULTA', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_REPORTESCONSULTA para reportes
GRANT EXECUTE ON ADM_PERSON.LDC_REPORTESCONSULTA TO rexereportes;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_REPORTESCONSULTA para REXEOPEN
GRANT EXECUTE ON ADM_PERSON.LDC_REPORTESCONSULTA TO REXEOPEN;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_REPORTESCONSULTA para RSELSYS
GRANT EXECUTE ON ADM_PERSON.LDC_REPORTESCONSULTA TO RSELSYS;
/