CREATE OR REPLACE PACKAGE adm_person.LD_BOCONSTANS is
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : LD_BOConstans
    Descripción    : Objeto de negocio para el manejo de constantes

    Autor          : Jonathan Alberto Consuegra Lara
    Fecha          : 20/09/2012

    Historia de Modificaciones
    Fecha             Autor                 Modificación
    =========         =========             ====================
    23/07/2024        jpinedc                 OSF-2886: * Se migra a ADM_PERSON
                                              * Ajustes por estándares    
    08-10-2014        llarrarte.RQ2172      Se adiciona <csbMaxQuotRenew>
                                                        <csbCancelPolicyActivity>
                                                        <cnuCausCancelAge>
    29-09-2014        llarrarte.RQ1834      Se adiciona <csbCausCancBySubs>
    26-09-2014        llarrarte.RQ1719      Se adiciona <csbRenPolicyPeriGrace>
    23-09-2014        llarrarte.RQ1178      Se adiciona <csbMaxPolizasCedula>
    09-12-2013        hjgomez.SAO226584     cnufacturation_note_subsidy
    03/09/2013        jcarrillo.SAO212983   Se adiciona la constante <csbProdLineExe>
    02/09/2013        jcarrillo.SAO211267   Se adiciona la constante <csbActivityVisit>
    27/08/2013        jcarrillo.SAO214742   Se adiciona la función <fsbVersion>
                                            Se elimina la constante <CnuStateOrder>
    27/08/2013        jcastro.SAO214742     Se modifica el Tipo <rcldpolicy>
                                             adicionando el campo <validity_policy_type_id>
    24/07/2013        jcarmona.SAO212942    Creación constante cnuGeneric_Error_TipoM

    20/09/2012        eramos.SAO156931      Creación de constantes
                                             csbYesFlag y csbNOFlag
    20/09/2012        jvaliente.SAO156931   Creacion de constante
                                              csbReview
                                              csbProcess
                                              csbEnd
                                              csbError
                                              csbCodOrderStatus
                                              csbCodClasItem
                                              csbCodTaskTypeId
                                              csbCodServType
                                              cnuCero
                                              cnuExecConstructUnit
                                              cnuGasServiceOrder
                                              cnuGasDemand
                                            Creacion de Record
                                              rcLDRelMarkBudget
                                              rcLDConUniBudget
                                              rcCoUnTaskType
                                              rcLDConUniBudgetExec
                                              rcLdExecMeth
    20/09/2012        jconsuegra.SAO156931    Creación
    31/10/2012        EHerard.SAO153122       csbBrillaService
    11/12/2012        EHerard.                cnuACactivity_Type_FNB
    ******************************************************************/

    /*TIPO DE SUSCRIPCIÿN PARA PROSPECTO - NORMAL*/
    cnuProspectType constant ge_Subscriber.subscriber_type_id%type := 1;

    cnuswupdld_asig_subsidy number := 0;

    cnuAsigSubIndex         number;

    tbld_asig_subsidy       DAld_asig_subsidy.tytbLD_asig_subsidy;

    /*Identificador del aplicativo de remanentes*/
    csbRemain_Sub_App varchar2(5) := 'LDREM';

    /*Identificador del aplicativo que genera los duplicados de factura*/
    cnuidAppSale_Duplicate sa_executable.executable_id%type := 500000000000605;

    /*Código del aplicativo que genera los duplicados de factura*/
    csbGen_Sale_Duplicate varchar2(30) := 'LDGDB';

    /*Código del aplicativo que genera el acta de cobro*/
    csbGen_Record_Collect varchar2(30) := 'LDGRC';

    /*Estado abierto del remanente un subsidio*/
    csbRemainder_Open varchar2(2) := 'AB';

    /*Estado simulado del remanente un subsidio*/
    csbRemainder_Simulate varchar2(2) := 'S';

    /*Estado distribuido del remanente un subsidio*/
    csbRemainder_Distribute varchar2(2) := 'D';

    /*Estado aplicado del remanente un subsidio*/
    csbRemainder_Apply varchar2(2) := 'AP';

    /*Estado cerrado del remanente un subsidio*/
    csbRemainder_Close varchar2(2) := 'CE';

    /*Código del aplicativo encargado de generar las cartas para potenciales*/
    csbPotential_letter_app varchar2(30) := 'LDLTP';

    /*Causa de reversión de un subsidio retroactivo*/
    cnurever_retro_sub_cause ld_parameter.numeric_value%type;

    /*Código del sistema*/
    cnuSystem_id ld_parameter.numeric_value%type;

    /*Código que contiene el formato y el nombre de la plantilla de retroactivo*/
    cnuExtract_Retroactive ld_parameter.numeric_value%type;

    /*Código del aplicativo encargado de generar las cartas para retroactivos*/
    csbRetro_letter_application varchar2(30) := 'LDLRA';

    /*Código que contiene el formato y el nombre de la plantilla de potenciales*/
    cnuExtract_Potential ld_parameter.numeric_value%type;

    /*Estado de legalización de una orden de trabajo*/
    cnulegalizeorderstatus ld_parameter.numeric_value%type;

    /*Localidad para determinar el número de días hábiles para multar
    a un contratista en caso tal de que la documentación de una
    venta subsidiada no haya sido entregada*/
    cnuUbication_to_penalize ld_parameter.numeric_value%type;

    /*Localidad para determinar el número de días hábiles para
    reversar la entrega de un subsidio retroactivo*/
    cnuUbication_remove_retro ld_parameter.numeric_value%type;

    /*Días para multar a un contratista por no legalizar la orden de
    entrega de documentos para una venta no subsidiada*/
    cnuDays_penalize_sale_no_sub ld_parameter.numeric_value%type;

    /*Días para reversar un subsidio retroactivo*/
    cnuDays_to_remove_subsidy ld_parameter.numeric_value%type;

    /*Actividad de una orden de conexión de GAS*/
    cnuorderlegalizeactivity or_order_activity.order_item_id%type;

    /*Tipo de trabajo de una orden de conexión de GAS*/
    cnuorderlegalizetasktype or_order_activity.task_type_id%type;

    /*Transición para multa orden de documentos subsidios*/
    cnuTransitionSub GE_TRANSITION_TYPE.transition_type_id%type;

    /*Estado reversado de un subsidio*/
    cnuSubreverstate ld_subsidy_states.subsidy_states_id%type;

    /*Estado pagado de un subsidio*/
    cnuSubpaystate ld_subsidy_states.subsidy_states_id%type;

    /*Actividad multa a contratista*/
    cnupenalize_activity ge_items.items_id%type;

    /*Causa de nota de facturación*/
    cnufacturation_note causcarg.cacacodi%type;

    /*Causa de nota de facturación de subsidios*/
    cnufacturation_note_subsidy causcarg.cacacodi%type;

    /*Documentación de ventas al día*/
    csbinactive constant varchar2(1) := 'I';

    /*Actividad de solicitud de documentos para ventas no subsidiadas*/
    cnudocactivity_normalsales ld_parameter.numeric_value%type := null;

    /*Causa de cargo de subsidios*/
    cnusubchargecause ld_parameter.numeric_value%type := null;

    /*Documentación de ventas al día*/
    csbapackagedocok constant varchar2(1) := 'S';

    /*ASignación de saldo a favor por subsidio retroactivo*/
    csbapplybalance varchar2(1);

    /*Valor para saber si un dato se encuentra aceptado*/
    csbafirmation constant varchar2(1) := 'Y';

    /*Asignación retroactiva de subsidio*/
    csbretroactivesale constant varchar2(1) := 'R';

    /*Tipo de trabajo de causales de documentacion subsidio */
    cnuCAU_TAS_TYP_DOC_SUB ld_parameter.numeric_value%type := null;

    cnuCAU_TAS_TYP_DOC     ld_parameter.numeric_value%type := null;

    csbCAU_COM_DOC_SUB     ld_parameter.value_chain%type := null;

    csbCAU_NON_COM_DOC_SUB ld_parameter.value_chain%type := null;

    /*Tipo de Actividad Venta FNB*/
    cnuActivity_Type_FNB ld_parameter.numeric_value%type := null;

    /*Tipo de Actividad Entrega FNB*/
    cnuAct_Type_Del_FNB ld_parameter.numeric_value%type := null;

    cnuAct_Type_rev_FNB ld_parameter.numeric_value%type := null;

    /*Estado cobrado de un subsidio*/
    cnucollectstate ld_parameter.numeric_value%type;

    /*Estado por cobrar de un subsidio*/
    cnureceivablestate ld_parameter.numeric_value%type;

    csbsubpaystates ld_parameter.value_chain%type;

    cnudaystofine ld_parameter.numeric_value%type;

    cnudaystofine_normalsale ld_parameter.numeric_value%type;

    cnucolombiancountryid ld_parameter.numeric_value%type;

    csbresidentialsale ld_parameter.value_chain%type;

    csbquotesale ld_parameter.value_chain%type;

    csbconstructorsale ld_parameter.value_chain%type;

    cnubinarythreenumber constant number := 7;

    /*Categoría residencial*/
    cnuresidencategory categori.catecodi%type;

    /*Proceso para orden de solicitud de documentos - subsidio*/
    cnuproordocuments ge_process.process_id%type;

    /*Actividad para orden de solicitud de documentos - subsidio*/
    cnudocactivity ge_items.items_id%type;

    /*Estado inicial de un subsidio*/
    cnuinitial_sub_estate ld_subsidy_states.subsidy_states_id%type;

    /*código del servicio GAS*/
    cnuGasService servicio.servcodi%type;

    /*código de los tipos de producto Brilla*/
    csbBrillaService LD_Parameter.Parameter_Id%type;

    /*tipo de promoción subsidiada*/
    cnuPromotionType cc_prom_type.prom_type_id%type;

    /*prioridad de una promoción tipo subsidio*/
    cnuPromotionPriority ge_priority.priority_id%type;

    /*código del clasificacion proveedor fnb*/
    cnuClaProFNB or_oper_unit_classif.oper_unit_classif_id%type;

    /*código del clasificacion contratista venta fnb*/
    cnuClaConVentaFNB or_oper_unit_classif.oper_unit_classif_id%type;

    /*Letra que representa la venta del GAS*/
    csbGASSale constant varchar2(1) := 'V';

    /*código flag que indica YES*/
    csbYesFlag constant varchar2(1) := 'Y';

    /*código flag que indica NO*/
    csbNOFlag constant varchar2(1) := 'N';

    /*código flag que indica Pendiente */
    csbPendFlag constant varchar2(1) := 'P';

    /*código flag que indica S*/
    csbokFlag constant varchar2(1) := 'S';

    /*código para generar un error genérico*/
    cnuGeneric_Error constant number := 2741;

    /*Constante de error generico con tipo de mensaje M:MENSAJE*/
    cnuGeneric_Error_TipoM constant number := 2691;

    /*código para generar un mensaje de validacion genérico*/
    cnuGeneric_ValMess constant number := 5310;

    /*código de no aprobación de una acción*/
    csbNo_Action constant varchar2(1) := 'N';

    /*código de aprobación de una acción*/
    csbAction_Ok constant varchar2(1) := 'Y';

    /*valor genérico para validaciones*/
    cnuCero_Value constant number(4) := 0;

    /*Tope definido para definir el porcentaje máximo de subsidio para un concepto*/
    cnuCien_Value constant number(4) := 100;

    /*código genérico para validar el año de vigencia de los recursos de un subsidio*/
    cnuInitial_Year constant Ld_Subsidy.Validity_Year_Means%type := 1;

    /*código genérico para validar el año de vigencia de los recursos de un subsidio*/
    cnuFinal_Year constant Ld_Subsidy.Validity_Year_Means%type := 9999;

    /*código genérico para contemplar todos los datos de una columna asociada a una entidad*/
    cnuallrows constant number := -1;

    /*Número de filtros, 4, para obtener el código tarifario de un concepto en binario*/
    cnubinaryfournumber constant number := 15;

    /*Numero Cinco*/
    cnufivenumber constant number := 5;

    /*Número de filtros, 4, para obtener el código tarifario de un concepto*/
    cnufournumber constant number := 4;

    /*Número uno*/
    cnuonenumber constant number := 1;

    /*Número dos*/
    cnutwonumber constant number := 2;

    /*Número tres*/
    cnuthreenumber constant number := 3;

    /*Limite definido para el Bulk Collect de Unidade Constructivas*/
    cnuLimitBulkCollect constant number := 100;

    /*indice para el type que evita error de tablas mutantes*/
    nuSubIndex number(4) := 0;

    tbsubsidy DALD_subsidy.tytbLD_subsidy;

    /*indice para el type que evita error de tablas mutantes*/
    nuUbiIndex number(4) := 0;

    /*Causal del fallo de bloquo y desbloqueo*/
    caufallo ld_parameter.numeric_value%type := 39;

    tbubisubsidy DALD_ubication.tytbLD_ubication;

    /*indice para el type que evita error de tablas mutantes*/
    nuSubdetailindex number(4) := 0;

    tbSub_Detail DALD_subsidy_detail.tytbLD_subsidy_detail;

    /*indice para el type que evita error de tablas mutantes*/
    nuMaxrecovery number(4) := 0;

    tbMaxrecovery DALd_Max_Recovery.tytbLd_Max_Recovery;

    /*codigo ya esta siendo Proceso por un JOB*/
    csbReview constant varchar2(1) := 'R';

    /*codigo para determnar que el metodo esta en Proceso de ejecucion*/
    csbProcess constant varchar2(1) := 'P';

    /*codigo para determnar que el metodo esta Finalizada*/
    csbEnd constant varchar2(1) := 'F';

    /*codigo para determnar que el metodo Finaliza con Errores*/
    csbError constant varchar2(1) := 'E';

    /* Parámetro para configurar el mímáximo número de cuotaspendientes por facturar para renovar una póliza*/
    csbMaxQuotRenew constant ld_parameter.parameter_id%type := 'MAX_QUOT_RENEW';

    /*parametro para el máximo de pólizas que se pueden vender por cédula */
    csbMaxPolizasCedula constant LD_Parameter.Parameter_Id%type := 'MAX_POLIZAS_CEDULA';

    /*parametro para el máximo de pólizas que se pueden vender por cédula */
    csbRenPolicyPeriGrace constant LD_Parameter.Parameter_Id%type := 'REN_POLICY_PERI_GRACE';

    /* Parámetro para la actividad de la orden de cancelación po límite de edad */
    csbCancelPolicyActivity constant ld_parameter.parameter_id%type := 'CANCEL_POLICY_ACTIVITY';

    /*Parámetro para causal de cancelació por solicitud del cliente */
     csbCausCancBySubs constant ld_parameter.parameter_id%type := 'CAUS_CANC_BY_SUBS';

    /*parametro para el codigo de estado de la orden*/
    csbCodOrderStatus constant LD_Parameter.Parameter_Id%type := 'COD_ORDER_STATUS';

    /*parametro para el codigo de clasificacion del item*/
    csbCodClasItem constant LD_Parameter.Parameter_Id%type := 'COD_CLAS_ITEM';

    /*parametro para el codigo de tipo de trabajo de conexion de serivicio de Gas*/
    csbCodTaskTypeId constant LD_Parameter.Parameter_Id%type := 'COD_TASK_TYPE_ID';

    /*parametro para el codigo de tipo de servicio de Gas*/
    csbCodServType constant LD_Parameter.Parameter_Id%type := 'COD_TIPO_SERV';

    /*INICIO de constantes para el DAA-159480 Solicitud de garantía*/
    /*Código del tipo de paquete solicitud de venta de brilla*/
    cnupackTypeSalBr constant LD_Parameter.Parameter_Id%type := 'COD_PACK_FNB';
    /*Fin de constantes para el DAA-159480 Solicitud de garantía*/

    /*Constantes para el DAA-159429 Solicitud de visita */
    /*Medio de referencia tendero referente*/
    cnurefermode constant LD_Parameter.Parameter_Id%type := 'COD_REFER_MODE';
    /*Medio de referencia venta cruzada*/
    cnurefermodecr constant LD_Parameter.Parameter_Id%type := 'COD_REFER_MODE_VTACROSS';
    /*Código del tipo de paquete solicitud de visita*/
    cnupackagestype constant LD_Parameter.Parameter_Id%type := 'COD_PACKAGES_TYPE';
    /*valor genérico para validaciones*/
    cnuStapack constant number(4) := 13;
    /*Código del tipo de producto brilla*/
    cnuCodTypeProductBR constant LD_Parameter.Parameter_Id%type := 'COD_PRODUCT_TYPE_BRILLA';
    /*Código del tipo de producto brilla Promigas*/
    cnuCodTypeProductBRP constant LD_Parameter.Parameter_Id%type := 'COD_PRODUCT_TYPE_BRILLA_PROM';

    /*parametro para la categoria permitida*/
    csbCodCategoryVisit constant LD_Parameter.Parameter_Id%type := 'COD_CATEGORY_VISIT';

    /*Fin de Constantes para el DAA-159429 Solicitud de visita*/

    /*Constantes para el DAA-147879 brilla seguros*/

    /*parametro para el estado de la Póliza de seguros*/
    csbCodStatePolicy constant LD_Parameter.Parameter_Id%type := 'COD_STATE';

    /*parametro para el número de periodos vencidos*/
    cnuCodPerDefeated constant LD_Parameter.Parameter_Id%type := 'COD_PERIOD';

    /*parametro para el codigo del programa de facturas generadas por cuenta de cobro*/
    cnuCodFactProg constant LD_Parameter.Parameter_Id%type := 'COD_FACTPROG';

    /*parametro para la cantidad de pólizas por contrato*/
    cnuCodCant_Poly constant LD_Parameter.Parameter_Id%type := 'COD_CANT_POLY';

    /*parametro para la causal de cancelación de pólizas por edad*/
    cnuCausCancelAge constant LD_Parameter.Parameter_Id%type := 'CAUS_CANCEL_AGE';

    /*parametro para los estados de corte permitidos*/
    csbCodEstacort constant LD_Parameter.Parameter_Id%type := 'COD_ESTACORT';

    /*parametro para la categoria permitida*/
    csbCodCategory constant LD_Parameter.Parameter_Id%type := 'COD_CATEGORY';

    /*parametro para la edad maxima permitida para obtener una póliza*/
    cdtCodDateMin constant LD_Parameter.Parameter_Id%type := 'COD_DATE_MIN';

    /*parametro para la edad minima permitida para obtener una póliza*/
    cdtCodDateMax constant LD_Parameter.Parameter_Id%type := 'COD_DATE_MAX';

    /*parametro para la cuota de financiación permitida*/
    csbCodShare constant LD_Parameter.Parameter_Id%type := 'COD_CUOTA_FIN';

    /*parametro para del tipo de seguros brilla*/
    cnuCodTypeProduct constant LD_Parameter.Parameter_Id%type := 'COD_PRODUCT_TYPE';

    /*parametro para del tipo de seguros brilla*/
    cnuCodTypePackageNoRe constant LD_Parameter.Parameter_Id%type := 'COD_PACKAGES_TYPE_NOREW';

    /*Parametro  para del usuario de la aseguradora*/
    CnuuserIdContra constant LD_Parameter.Parameter_Id%type := 'COD_USER_CONTRACT_ID';

    /*Código de la causal de cancelación por edad*/
    Cnucancau constant LD_Parameter.Parameter_Id%type := 'COD_CANCEL_CAUSAL_AGE';

    /*Numero de meses para la cancelación por doble cupón*/
    CnuNumMoCancel constant LD_Parameter.Parameter_Id%type := 'NUM_MONTH_CANCEL';

    /*Linea de producto Doble cupon */
    CnuNumDobCup constant LD_Parameter.Parameter_Id%type := 'NUM_DOB_CUP';

    /*Número de actividad para la orden de pago para la aseguradora*/
    CsbActivityPay constant LD_Parameter.Parameter_Id%type := 'NUM_ACT_PAYMENT';

    /*Número de actividad para la orden de cobro para la aseguradora*/
    CsbActivityCharge constant LD_Parameter.Parameter_Id%type := 'NUM_ACT_CHARGE';

    /*Codigo del parametro de orden de venta*/
    CsbSaleOrder constant LD_Parameter.Parameter_Id%type := 'NUM_ORDER_SALE';

    /*Código del parametro de la actividad de visita*/
    csbActivityVisit constant LD_Parameter.Parameter_Id%type := 'NUM_ACT_VISIT';

    /*Codigo de la causa de cancelación*/
    cnuCauseCarg constant LD_Parameter.Parameter_Id%type := 'COD_CAUSE_CARG';

    /*Codigo para las pólizas en estado canceladas*/
    csbCodStateCanc constant LD_Parameter.Parameter_Id%type := 'COD_STATE_CANC';

    /*Codigo para las pólizas en estado renovadas*/
    cnuCodStateRenew constant LD_Parameter.Parameter_Id%type := 'COD_STATE_RENEW';

    /*Codigo del programa para la facturación del proceso de renovación*/
    cnuCodProgRenew constant LD_Parameter.Parameter_Id%type := 'COD_PROG_RENEW';

    /*Codigo para el tipo de recepción por xml*/
    cnuRecepType constant LD_Parameter.Parameter_Id%type := 'COD_REC_TYPE';

    /*Codigo para la repuesta por xml*/
    cnuAnswerId constant LD_Parameter.Parameter_Id%type := 'ANSWER_ID';

    /*Codigo para el plan de financiación por xml */
    cnuFinancingPlan constant LD_Parameter.Parameter_Id%type := 'FINANCING_PLAN_ID';

    /*Codigo del tipo de documento para las notas de facturación*/
    cnuDocTypeId constant LD_Parameter.Parameter_Id%type := 'DOC_TYPE_ID';

    /*Codigo de la causa de cancelación por xml*/
    cnuCauseCanc constant LD_Parameter.Parameter_Id%type := 'ID_CAUSE_CANC';

    /*Codigo tipo de cancelación de seguros*/

    csbCanByFil constant LD_Parameter.Parameter_Id%type := 'COD_CAN_BY_FILE';

    /*Codigo de ruta de archivos log de seguros*/
    csbRutLogs constant LD_Parameter.Parameter_Id%type := 'RUT_FILE_SECURE';

    /*Codigo de causal de cumplimiento de venta*/
    csbCauCumpl constant LD_Parameter.Parameter_Id%type := 'COD_CAU_CUMP';

    /*Número de meses*/
    cnuTypeLiqNM constant LD_Parameter.Parameter_Id%type := 'TYPE_NUM_MONTH_CAN';

    /*Devolucion a partir de n meses*/
    cnuTypeLiqDn constant LD_Parameter.Parameter_Id%type := 'TYPE_LIQ_DN';

    /*Devolucion total*/
    cnuTypeLiqDt constant LD_Parameter.Parameter_Id%type := 'TYPE_LIQ_DT';

    /*Cuotas no pagadas*/
    cnuTypeLiqVnp constant LD_Parameter.Parameter_Id%type := 'TYPE_LIQ_VNP';

    /*Lineas de Producto de Tipo exequial*/
    csbProdLineExe constant LD_Parameter.Parameter_Id%type := 'PROD_LINE_EXE';

    /*Fin de constantes para el DAA-147879 brilla seguros*/

    /* Inicio para el DAA-15764 Trámite de siniestros */

    /*Flag que indica que es CUENTA DE COBRO*/
    csbCCOBRO constant varchar2(1) := 'C';

    /*Flag que indica que es APROBACIÿN*/
    csBAproba constant varchar2(1) := 'A';

    /*Flag que indica que es Registro*/
    csBRegistro constant varchar2(1) := 'R';

    /*parametros*/
    cnuTypeState constant LD_Parameter.Parameter_Id%type := 'COD_STATE_MOTIVE';

    /*Codigo de estado del paquete*/

    cnuMotPackage constant LD_Parameter.Parameter_Id%type := 'COD_MOTIVE_PACKAGE';

    csbnuPeriGrac constant LD_Parameter.Parameter_Id%type := 'IDENTIFICADOR_PERIOD_GRACIA';

    csbnuTimePeriGrac constant LD_Parameter.Parameter_Id%type := 'TIEMPO_CONGELACIÿN_DIFERIDOS';

    /*Codigo para la fecha minima de siniestros*/

    csbMinSin constant LD_Parameter.Parameter_Id%type := 'DATE_MIN_SIN';

    /*Codigo tipo de cancelación de siniestros*/

    csbCanBySin constant LD_Parameter.Parameter_Id%type := 'COD_CAN_BY_SIN';

    /*Codigo de encabezado de carta*/

    csbNameFun constant LD_Parameter.Parameter_Id%type := 'NAME_FUN_LETTER';

    /*Codigo de encabezado de carta*/

    csbHeaderLett constant LD_Parameter.Parameter_Id%type := 'HEADER_LETTER';

    /*Codigo de encabezado de carta*/

    csbSigner constant LD_Parameter.Parameter_Id%type := 'ID_SIGNER';

    /*Codigo de encabezado de carta*/

    csbReviews constant LD_Parameter.Parameter_Id%type := 'REVIEW';

    /*Ciudad donde se firma la carta*/

    csbCity constant LD_Parameter.Parameter_Id%type := 'CITY_LETTER';

    /*Persona que elabora la carta*/

    csbUserFrm constant LD_Parameter.Parameter_Id%type := 'USER_FRM_LETTER';

    /*Codigo de ruta de archivos log de siniestros*/

    csbRutLog constant LD_Parameter.Parameter_Id%type := 'RUT_FILE_SINESTER';

    /*Codigo concepto de financiación*/

    cnuConFin constant LD_Parameter.Parameter_Id%type := 'COD_CON_FIN';

    /*Codigo concepto de seguro*/

    cnuConSec constant LD_Parameter.Parameter_Id%type := 'COD_CON_SEG';

    /*Codigo concepto de facturación*/

    cnuConFact constant LD_Parameter.Parameter_Id%type := 'COD_CON_FACT';

    /*Codigo para la repuesta por xml*/

    cnuAnswerIdSin constant LD_Parameter.Parameter_Id%type := 'ANSWER_ID_SIN';

    /*Codigo de la causa de cancelación por xml*/

    cnuCauseCancSin constant LD_Parameter.Parameter_Id%type := 'CAUSAL_ID_SIN';

    /* FIN para el DAA-15764 Trámite de siniestros*/

    /* INICIO para el DAA-159730 Terminación de contrato*/

    /*Codigo concepto de cargos*/

    cnuConCargt constant LD_Parameter.Parameter_Id%type := 'COD_CONCEPTO_CAR';

    /*Codigo causa de cargo*/

    cnuCauCargt constant LD_Parameter.Parameter_Id%type := 'COD_CAUSA_CARG';

    /*Codigo valor de solicitud de cobro*/

    cnuValSolT constant LD_Parameter.Parameter_Id%type := 'COD_COB_CONT';

    /*Codigo de medio recepción escrita*/

    cnuMedRecT constant LD_Parameter.Parameter_Id%type := 'COD_RECEPTION_TYPE';

    /*Codigo de servicios financieros de brilla*/

    csbFinBrillPro constant LD_Parameter.Parameter_Id%type := 'COD_SERVFINBRPRO';

    /*Codigo de tipo de retiro de terminación de contrato*/

    cnuReti_Type_Motive constant LD_Parameter.Parameter_Id%type := 'RETI_TYPE_MOTIVE';

    /*Codigo de notificación de terminación de contrato*/

    cnuCod_Noty_Cont constant LD_Parameter.Parameter_Id%type := 'COD_NOTY_CONT';

    /* FIN para el DAA-159730 Terminación de contrato*/

    /*Valor numerico 0*/
    cnuCero constant number := 0;

    /*codigo metodo de ordenes legalizadas con unidades constrcutivas*/
    cnuExecConstructUnit constant number := 1;

    /*codigo metodo de servicio de conexiones nuevas de gas*/
    cnuGasServiceOrder constant number := 2;

    /*codigo metodo de demanda (Consumo) de gas*/
    cnuGasDemand constant number := 3;

    /*Cadena para comparar si existe un fraude*/
    csbConfirmFraud constant varchar2(200) := 'FRAUDE CONFIRMADO';

    /*Flag que indica que es CODEUDOR*/
    csbCOSIGNERPROTYPE constant varchar2(1) := 'C';

    /*Flag que indica que es DEUDOR*/
    csbDEUDORPROTYPE constant varchar2(1) := 'D';

    /*Políticas de consumo cero*/
    cnuEXCLU_POLICY constant varchar2(200) := '5,6,7,8';

    /*Código del tipo de trabajo FNB*/
    cnuFNBTaskType constant number := pkg_BCLD_Parameter.fnuObtieneValorNumerico( 'FNB_TASK_TYPE');

    /*Código del tipo de trabajo FNB*/
    cnuStatusReg constant number := pkg_BCLD_Parameter.fnuObtieneValorNumerico( 'COD_STATUS_REG');

    /*Código que identifica que la orden es actividad de instalación*/
    cnuActivityInstall constant number := pkg_BCLD_Parameter.fnuObtieneValorNumerico( 'COD_ACTIVITY_INSTALL');
    /*Código que identifica el concepto de instalación*/
    cnuConceptInstall constant number := pkg_BCLD_Parameter.fnuObtieneValorNumerico( 'COD_CONCEPT_INSTALL');

    /*Código tipo de trabajo FNB*/
    csbTaskTypeSaleFNB constant LD_Parameter.Parameter_Id%type := 'TASK_TYPE_SALE_FNB';
    --clasificacin causal de exito
    cnuclascauexito constant number := 1;
    --clasificacin causal de fallo
    cnuclascaufallo constant number := 2;
    --codigo rango de edad datecredito no posee informacion
    cnuRanEdaNPIData constant number := 8;

    /*Tipo Record para la entidad LD_Rel_Mark_Budget*/
    TYPE rcLDRelMarkBudget IS RECORD(
    Rel_Mark_Budget_ID  LD_Rel_Mark_Budget.Rel_Mark_Budget_Id%type,
    Relevant_Market_id  LD_Rel_Mark_Budget.Relevant_Market_Id%type,
    Geograp_Location_Id LD_Rel_Mark_Budget.Geograp_Location_Id%type,
    Year                LD_Rel_Mark_Budget.Year%type,
    month               LD_Rel_Mark_Budget.Month%type);

    TYPE tbLDRelMarkBudget IS TABLE OF rcLDRelMarkBudget;
    tyrcLDRelMarkBudget tbLDRelMarkBudget := tbLDRelMarkBudget();

    /*Tipo Record para la entidad Ld_Con_Uni_Budget*/
    TYPE rcLDConUniBudget IS RECORD(
    Construct_Unit_Id Ld_Con_Uni_Budget.Con_Uni_Budget_Id%type,
    Amount_Executed   Ld_Con_Uni_Budget.Value_Executed%type);

    TYPE tbLDConUniBudget IS TABLE OF rcLDConUniBudget;
    tyrcLDConUniBudget tbLDConUniBudget := tbLDConUniBudget();

    /*Tipo Record para el cruce de entidades OR_ORDER,
    ld_CO_UN_TASK_TYPE,or_order_items,ge_items,or_task_types_items*/

    TYPE rcCoUnTaskType IS RECORD(
    GEOGRAP_LOCATION_ID Or_Order.Geograp_Location_Id%type,
    TASK_TYPE_ID        Or_Task_Type.Task_Type_Id%type,
    ORDER_VALUE         Or_Order.Order_Value%type,
    CONSTRUCTIVE_UNIT   LD_Co_Un_Task_Type.Construct_Unit_Id%type,
    legal_item_amount   Or_Order_Items.Legal_Item_Amount%type,
    order_id            Or_Order.Order_Id%type);

    TYPE tbCoUnTaskType IS TABLE OF rcCoUnTaskType;
    tyrcUnTaskType tbCoUnTaskType := tbCoUnTaskType();

    /*Tipo Record para todos los campos la entidad LD_Con_Uni_Budget*/
    TYPE rcLDConUniBudgetExec IS RECORD(
    Con_Uni_Budget_Id  LD_Con_Uni_Budget.Con_Uni_Budget_Id%type,
    Rel_Mark_Budget_Id LD_Con_Uni_Budget.Rel_Mark_Budget_Id%type,
    Construct_Unit_Id  LD_Con_Uni_Budget.Construct_Unit_Id%type,
    Amount             LD_Con_Uni_Budget.Amount%type,
    Value_Budget_Cop   LD_Con_Uni_Budget.Value_Budget_Cop%type,
    Amount_executed    LD_Con_Uni_Budget.Amount_Executed%type,
    Value_executed     LD_Con_Uni_Budget.Value_Executed%type);

    TYPE tbLDConUniBudgetExec IS TABLE OF rcLDConUniBudgetExec;
    tyrcLDConUniBudgetExec tbLDConUniBudgetExec := tbLDConUniBudgetExec();

    /*Tipo Record para el cruce de entidades
    OR_Order, OR_Order_Activity, PR_Product*/
    TYPE rcGasServiceOrder IS RECORD(
    Category_Id         Ld_Service_Budget.Catecodi%type,
    Subcategory_Id      Ld_Service_Budget.Sucacodi%type,
    Geograp_Location_Id Or_Order.Geograp_Location_Id%type,
    cantidad            Number);

    TYPE tbGasServiceOrder IS TABLE OF rcGasServiceOrder;
    tyrcGasServiceOrder tbGasServiceOrder := tbGasServiceOrder();

    /*Tipo Record para todos los campos la entidad LD_Service_Budget*/
    TYPE rcLdServiceBudget IS RECORD(
    Service_Budget_Id  LD_Service_Budget.Service_Budget_Id%type,
    Rel_Mark_Budget_Id LD_Service_Budget.Rel_Mark_Budget_Id%type,
    Catecodi           LD_Service_Budget.Catecodi%type,
    Sucacodi           LD_Service_Budget.Sucacodi%type,
    Budget_Amount      LD_Service_Budget.Budget_Amount%type,
    Executed_Amount    LD_Service_Budget.Executed_Amount%type);

    TYPE tbLdServiceBudget IS TABLE OF rcLdServiceBudget;
    tyrcLdServiceBudget tbLdServiceBudget := tbLdServiceBudget();

    /*Tipo Record para todos los campos la entidad LD_Demand_Budget*/
    TYPE rcLdDemandBudget IS RECORD(
    Demand_Budget_Id    LD_Demand_Budget.Demand_Budget_Id%type,
    Rel_Mark_Budget_Id  LD_Demand_Budget.Rel_Mark_Budget_Id%type,
    Catecodi            LD_Demand_Budget.Catecodi%type,
    Sucacodi            LD_Demand_Budget.Sucacodi%type,
    Executed_Amount     LD_Demand_Budget.Executed_Amount%type,
    Year                Ld_Rel_Mark_Budget.Year%type,
    Month               Ld_Rel_Mark_Budget.Month%type,
    Geograp_Location_Id Ld_Rel_Mark_Budget.Geograp_Location_Id%type);

    TYPE tbLdDemandBudget IS TABLE OF rcLdDemandBudget;
    tyrcDemandBudget tbLdDemandBudget := tbLdDemandBudget();

    /*Tipo Record para todos los campos la entidad LD_Exec_Meth*/
    TYPE rcLdExecMeth IS RECORD(
    Exec_Meth_Id LD_Exec_Meth.Exec_Meth_Id%type,
    Meth_Id      LD_Exec_Meth.Meth_Id%type,
    Execute_Date LD_Exec_Meth.Execute_Date%type,
    State        LD_Exec_Meth.State%type,
    Description  LD_Exec_Meth.Description%type);

    TYPE tbLdExecMeth IS TABLE OF rcLdExecMeth;
    tyrcLdExecMeth tbLdExecMeth := tbLdExecMeth();

    /*Tipo Record de DAA-147879 Brilla Seguros*/

    /*Tipo Record para todos los campos la entidad LD_POLICY*/

    TYPE rcldpolicy IS RECORD(
    policy_id           ld_policy.policy_id%type,
    state_policy        ld_policy.state_policy%type,
    launch_policy       ld_policy.launch_policy%type,
    contratist_code     ld_policy.contratist_code%type,
    product_line_id     ld_policy.product_line_id%type,
    dt_in_policy        ld_policy.dt_in_policy%type,
    dt_en_policy        ld_policy.dt_en_policy%type,
    value_policy        ld_policy.value_policy%type,
    prem_policy         ld_policy.prem_policy%type,
    name_insured        ld_policy.name_insured%type,
    suscription_id      ld_policy.suscription_id%type,
    product_id          ld_policy.product_id%type,
    identification_id   ld_policy.identification_id%type,
    period_policy       ld_policy.period_policy%type,
    year_policy         ld_policy.year_policy%type,
    month_policy        ld_policy.month_policy%type,
    deferred_policy_id  ld_policy.deferred_policy_id%type,
    dtcreate_policy     ld_policy.dtcreate_policy%type,
    share_policy        ld_policy.share_policy%type,
    dtret_policy        ld_policy.dtret_policy%type,
    valueacr_policy     ld_policy.valueacr_policy%type,
    report_policy       ld_policy.report_policy%type,
    dt_report_policy    ld_policy.dt_report_policy%type,
    dt_insured_policy   ld_policy.dt_insured_policy%type,
    per_report_policy   ld_policy.per_report_policy%type,
    policy_type_id      ld_policy.policy_type_id%type,
    id_report_policy    ld_policy.id_report_policy%type,
    cancel_causal_id    ld_policy.cancel_causal_id%type,
    fees_to_return      ld_policy.fees_to_return%type,
    comments            ld_policy.comments%type,
    policy_exq          ld_policy.policy_exq%type,
    number_acta         ld_policy.number_acta%type,
    geograp_location_id ld_policy.geograp_location_id%type,
    validity_policy_type_id ld_policy.validity_policy_type_id%type,
    policy_number ld_policy.policy_number%type);

    TYPE tbCoUnPolicy IS TABLE OF rcldpolicy;
    rfPolicy tbCoUnPolicy := tbCoUnPolicy();

    /*Tipo Record para la entidad pr_product*/
    TYPE rcldprodid IS RECORD(
    product_id pr_product.product_id%type);

    TYPE tbprprod IS TABLE OF rcldprodid;
    rfProdid tbprprod := tbprprod();

    /*Tipo Record para todos los campos la solicitud de no renovación*/
    TYPE rcldpolicyDif IS RECORD(
    onupolitype ld_policy.policy_type_id%type,
    onuValuep   ld_policy.value_policy%type,
    onuPayFeed  diferido.difecupa%type,
    onuNumDife  ld_policy.deferred_policy_id%type,
    oNucontra   ld_policy.contratist_code%type,
    ONuproline  ld_policy.product_line_id%type);

    TYPE tbpolicyDif IS TABLE OF rcldpolicyDif;
    rfPolicyDif tbpolicyDif := tbpolicyDif();

    /*Inicio Tipo Record de DAA-159764 Tramite de siniestros*/

    /*Tipo Record para todos la tabla de detalle de liquidación de siniestros*/
    TYPE rcldDetLiq IS RECORD(
    onudetaliq ld_detail_liquidation.detail_liquidation_id%type);

    TYPE tbdetliq IS TABLE OF rcldDetLiq;
    rfdelliq tbdetliq := tbdetliq();

    /*Tipo Record para unidades operativas*/
    TYPE rcor_operantig IS RECORD(
    operating_unit_id or_operating_unit.operating_unit_id%type);

    TYPE tboroper IS TABLE OF rcor_operantig;
    rfopoper tboroper := tboroper();

    /*Tipo Record de los valores a insertar en el detalle de liquidación de siniestros*/

    TYPE rcldDetLiqS IS RECORD(
    valtd         diferido.difevatd%type,
    current_value cargos.cargvalo%type,
    intfin        cargos.cargvalo%type,
    secure_value  cargos.cargvalo%type);

    TYPE tbdetliqs IS TABLE OF rcldDetLiqS;
    rfdelliqs tbdetliqs := tbdetliqs();

    /*Fin Tipo Record de DAA-159764 Tramite de siniestros*/

    /*Tipo Record para todos la tabla de detalle de terminación de contrato*/
    TYPE rcldMotSe IS RECORD(
    product_motive_id    mo_motive.product_motive_id%type,
    tag_name             mo_motive.tag_name%type,
    motive_type_id       mo_motive.motive_type_id%type,
    package_id           mo_motive.package_id%type,
    cust_care_reques_num mo_motive.cust_care_reques_num%type,
    nuSubscriptionId     mo_motive.subscription_id%type,
    product_type_id      mo_motive.product_type_id%type,
    service_number       mo_motive.service_number%type,
    commercial_plan_id   mo_motive.commercial_plan_id%type,
    motive_id            mo_motive_asso.motive_id%type,
    annul_dependent      mo_motive_asso.annul_dependent%type);

    TYPE tbMotse IS TABLE OF rcldMotSe;
    rfMotiSear tbMotse := tbMotse();

    /*Tipo Record para GARANTIA*/

    TYPE rffnbwar IS RECORD(
    item_id     ld_fnb_warranty.item_id%type,
    supplier_id ld_article.supplier_id%type);

    TYPE tbWarr IS TABLE OF rffnbwar;
    rfMotiWarra tbWarr := tbWarr();

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure      :  fsbVersion
    Descripcion    :  Obtiene la Version actual del Paquete
    *****************************************************************/
    FUNCTION fsbVersion RETURN varchar2;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnuBlockCausalType
    Descripcion    : Obtiene el tipo de causales de bloqueo.
    Autor          :
    Fecha          : 11/07/2012

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    FUNCTION fnuBlockCausalType return number;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fsbYesFlag
    Descripcion    : Obtiene el flag que indica la constante YES.
    Autor          :
    Fecha          : 11/07/2012

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    FUNCTION fsbYesFlag return varchar2;

    /****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fsbNoFlag
    Descripcion    : Obtiene el flag que indica la constante NO.
    Autor          :
    Fecha          : 11/07/2012

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    FUNCTION fsbNoFlag return varchar2;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : frfSentence
    Descripcion    : Obtiene un cursor referenciado con la sentencia
                   ingresada.
    Autor          :
    Fecha          : 11/07/2012

    Parametros              Descripcion
    ============         ===================
    isbSelect            Consulta a ejecutar,
    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    FUNCTION frfSentence(isbSelect varchar2) return constants.tyrefcursor;

    /*Carater de separador de datos en un archivo*/
    csbPipe constant varchar2(1) := '|';

    /*Carater de separador de datos en un archivo*/
    csbAsterisk constant varchar2(1) := '*';

    /*Carater de separador de datos en un archivo*/
    csbGuion constant varchar2(1) := '-';

    /*Nombre de la entidad LD_ARTICLE como se identificara
    en el archivo de FNB*/
    csbArticle constant varchar2(8) := 'ARTICULO';

    /*Nombre de la entidad LD_PROPERTY como se
    identificara en el archivo de FNB*/
    csbProperty constant varchar2(9) := 'PROPIEDAD';

    /*Nombre de la entidad LD_PRICE_LIST_DETA como se
    identificara en el archivo de FNB*/
    csbPrice constant varchar2(6) := 'PRECIO';

    /*Nombre de la entidad LD_PRICE_LIST como se
    identificara en el archivo de FNB*/
    csbPriceList constant varchar2(11) := 'LISTAPRECIO';

    /*Nombre de la entidad LD_PRICE_LIST_DETA como se
    identificara en el archivo de FNB*/
    csbLPArticle constant varchar2(10) := 'LPARTICULO';

    /*Nombre de la entidad LD_PRICE_LIST_DETA como se
    identificara en el archivo de FNB*/
    csbCommission constant varchar2(8) := 'COMISION';

    /*Vactor para almacenar los datos provenienetes linea de archivo*/
    TYPE tbarray IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
    arString tbarray;

    csbTipoCuponAnticipo constant varchar2(2) := pkBillConst.csbTOKEN_SOLICITUD;

end LD_BOCONSTANS;
/

CREATE OR REPLACE PACKAGE BODY adm_person.LD_BOCONSTANS IS

    -----------------------------------------------------
    -- Constantes
    -----------------------------------------------------
    cnuBlackCausalType number := 2;

    -- Constante con el SAO de la ultima version aplicada
    csbVERSION CONSTANT VARCHAR2(10) := 'OSF-2886';

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME;
    nuError         NUMBER;
    sbError         VARCHAR2(4000);  
            
    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure      :  fsbVersion
    Descripcion    :  Obtiene la Version actual del Paquete

    Parametros     :  Descripcion
    Retorno        :
    csbVersion        Version del Paquete

    Autor          :  jcarrillo
    Fecha          :  27/08/2013

    Historia de Modificaciones
    Fecha       Autor               Modificación
    ==========  =================== ==============================
    27-08-2013  jcarrillo.SAO214742 Creación
    *****************************************************************/
    FUNCTION fsbVersion RETURN varchar2 IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbVersion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);     
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);     
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        -- Retorna el SAO con que se realizo la ultima entrega
        RETURN(csbVersion);
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END fsbVersion;


    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fnuBlockCausalType
    Descripcion    : Procedimiento que imprime un pagare.
    Autor          :
    Fecha          : 11/07/2012

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    FUNCTION fnuBlockCausalType return number IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuBlockCausalType';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);    
    begin

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);     
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        return cnuBlackCausalType;
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END fnuBlockCausalType;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fsbYesFlag
    Descripcion    : Obtiene el flag que indica la constante YES.
    Autor          :
    Fecha          : 11/07/2012

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    FUNCTION fsbYesFlag return varchar2 IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbYesFlag';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);      
    begin

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);   
        return csbYesFlag;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END fsbYesFlag;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : fsbNoFlag
    Descripcion    : Obtiene el flag que indica la constante NO.
    Autor          :
    Fecha          : 11/07/2012

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    FUNCTION fsbNoFlag return varchar2 IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbNoFlag';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
    begin

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);   
        return csbNoFlag;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END fsbNoFlag;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : frfSentence
    Descripcion    : Obtiene un cursor referenciado con la sentencia
                   ingresada.
    Autor          :
    Fecha          : 11/07/2012

    Parametros              Descripcion
    ============         ===================
    isbSelect            Consulta a ejecutar
    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    FUNCTION frfSentence(isbSelect varchar2) return constants.tyrefcursor IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'frfSentence';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);     
        rfSelect constants.tyrefcursor;
    begin
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        pkg_traza.trace('isbSelect|' || isbSelect,csbNivelTraza );    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);       
        open rfSelect for isbSelect;
        return rfSelect;
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END frfSentence;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    cnurever_retro_sub_cause := pkg_BCLD_Parameter.fnuObtieneValorNumerico('REVER_RETRO_SUBSIDY_CAUSE');

    cnuSystem_id  := pkg_BCLD_Parameter.fnuObtieneValorNumerico('SYSTEM_ID');

    cnuExtract_Retroactive := pkg_BCLD_Parameter.fnuObtieneValorNumerico('EXTRACT_RETROACTIVE');

    cnuExtract_Potential := pkg_BCLD_Parameter.fnuObtieneValorNumerico('EXTRACT_POTENTIAL');

    cnulegalizeorderstatus := pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_ORDER_STATUS');

    cnuUbication_to_penalize := pkg_BCLD_Parameter.fnuObtieneValorNumerico('UBICATION_TO_PENALIZE');

    cnuUbication_remove_retro := pkg_BCLD_Parameter.fnuObtieneValorNumerico('UBICATION_REMOVE_RETRO');

    cnuDays_penalize_sale_no_sub := pkg_BCLD_Parameter.fnuObtieneValorNumerico('DAYS_PENALIZE_SALE_NO_SUBSIDY');

    cnuDays_to_remove_subsidy := pkg_BCLD_Parameter.fnuObtieneValorNumerico('DAYS_TO_REMOVE_RETRO_SUBSIDY');

    cnuorderlegalizeactivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('GAS_CONEXION_ACTIVITY');

    cnuorderlegalizetasktype := pkg_BCLD_Parameter.fnuObtieneValorNumerico('GAS_CONEXION_TASK_TYPE');

    cnuTransitionSub := pkg_BCLD_Parameter.fnuObtieneValorNumerico('TRANSITION_SUBSIDY');

    cnuSubreverstate := pkg_BCLD_Parameter.fnuObtieneValorNumerico('SUB_REVERSED_STATE');

    cnuSubpaystate := pkg_BCLD_Parameter.fnuObtieneValorNumerico('SUB_PAY_STATE');

    cnupenalize_activity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('PENALIZE_ACTIVITY');

    cnufacturation_note := pkg_BCLD_Parameter.fnuObtieneValorNumerico('FACTURATION_NOTE');

    cnufacturation_note_subsidy := pkg_BCLD_Parameter.fnuObtieneValorNumerico('FACTURATION_NOTE_SUBSIDY');

    cnudocactivity_normalsales := pkg_BCLD_Parameter.fnuObtieneValorNumerico('NORMAL_SALE_DOC_ACTIVITY');

    cnusubchargecause := pkg_BCLD_Parameter.fnuObtieneValorNumerico('CHARGE_SUBSIDY_CAUSE');

    csbapplybalance := pkg_BCLD_Parameter.fsbObtieneValorCadena('RETRO_APPLY_BALANCE');

    cnucollectstate := pkg_BCLD_Parameter.fnuObtieneValorNumerico('SUB_COLLECT_STATE');

    cnureceivablestate := pkg_BCLD_Parameter.fnuObtieneValorNumerico('SUB_RECEIVABLE_STATE');

    csbsubpaystates := pkg_BCLD_Parameter.fsbObtieneValorCadena('SUB_PAY_STATES');

    cnudaystofine := pkg_BCLD_Parameter.fnuObtieneValorNumerico('DAYS_TO_FINE');

    cnudaystofine_normalsale := pkg_BCLD_Parameter.fnuObtieneValorNumerico('DAYS_TO_FINE_NORMAL_SALE');

    cnucolombiancountryid := pkg_BCLD_Parameter.fnuObtieneValorNumerico('COLOMBIA_COUNTRY');

    csbresidentialsale := pkg_BCLD_Parameter.fsbObtieneValorCadena('SALE_BY_FORM');

    csbquotesale := pkg_BCLD_Parameter.fsbObtieneValorCadena('QUOTE_SALE');

    csbconstructorsale := pkg_BCLD_Parameter.fsbObtieneValorCadena('CONSTRUCTOR_SALE');
    --
    cnuresidencategory := pkg_BCLD_Parameter.fnuObtieneValorNumerico('RESIDEN_CATEGORY');

    cnuproordocuments := pkg_BCLD_Parameter.fnuObtieneValorNumerico('PRO_DOCU_ORDER');

    cnudocactivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('DOC_ACTIVITY_ORDER');

    cnuinitial_sub_estate := pkg_BCLD_Parameter.fnuObtieneValorNumerico('SUB_INITIAL_STATE');

    cnuGasService := pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_TIPO_SERV');

    cnuPromotionType := pkg_BCLD_Parameter.fnuObtieneValorNumerico('SUB_PROM_TYPE');

    cnuPromotionPriority := pkg_BCLD_Parameter.fnuObtieneValorNumerico('PROMOTION_PRIORITY');

    cnuClaProFNB := pkg_BCLD_Parameter.fnuObtieneValorNumerico('SUPPLIER_FNB');

    cnuClaConVentaFNB := pkg_BCLD_Parameter.fnuObtieneValorNumerico('CONTRACTOR_SALES_FNB');

    csbBrillaService := pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_SERFINBRILLA');

    cnuCAU_TAS_TYP_DOC_SUB := pkg_BCLD_Parameter.fnuObtieneValorNumerico('CAU_TAS_TYP_DOC_SUB');

    cnuCAU_TAS_TYP_DOC := pkg_BCLD_Parameter.fnuObtieneValorNumerico('TAS_TYP_DOC');

    csbCAU_COM_DOC_SUB := pkg_BCLD_Parameter.fsbObtieneValorCadena('CAU_COM_DOC_SUB');

    csbCAU_NON_COM_DOC_SUB := pkg_BCLD_Parameter.fsbObtieneValorCadena('CAU_NON_COM_DOC_SUB');

    cnuActivity_Type_FNB := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACTIVITY_TYPE_FNB');

    cnuAct_Type_Del_FNB := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_TYPE_DEL_FNB');

    cnuAct_Type_rev_FNB := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_TYPE_REV_FNB');

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
    
EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_Error.getError(nuError,sbError);        
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
        pkg_error.setError;
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
END LD_BOCONSTANS;
/

Prompt Otorgando permisos sobre ADM_PERSON.LD_BOCONSTANS
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('LD_BOCONSTANS'), 'ADM_PERSON');
END;
/

GRANT EXECUTE on LD_BOCONSTANS to REXEREPORTES; 
GRANT EXECUTE on LD_BOCONSTANS to RSELSYS;
GRANT EXECUTE on LD_BOCONSTANS to REXEINNOVA;
GRANT EXECUTE on LD_BOCONSTANS to ROLE_DESARROLLOOSF;
/

