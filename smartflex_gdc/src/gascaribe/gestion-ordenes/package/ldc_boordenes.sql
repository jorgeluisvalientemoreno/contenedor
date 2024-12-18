CREATE OR REPLACE PACKAGE LDC_BOORDENES
AS
    /*******************************************************************************
      Propiedad intelectual de PROYECTO PETI

     Autor                :
      Fecha                :

     Fecha                IDEntrega           Modificacion
      ============    ================    ============================================
      09-Nov-2011     Filigrana           creacion del paquete y adicion de la funcion FnugetTotalOTbyContrDatAdd
      10-Nov-2011     Filigrana           Creacion funcion FnugetValorOTbyDatAdd
      17-Ene-2012     emirol              modificacion tipo de dato en la funcion FnugetTotalOTbyContrDatAdd
                                          para el campo ValorAct. cambia de number a varchar2
      31-Ene-2013     luzaa               obtiene una orden legalizada con cierta clase de causa
      19-02-2013      luzaa               obtiene los tipos de trabajo que se condicionaran para legalizar por ORCAO
      27-02-2013      luzaa               funciones que retornan el id de la localidad y el id del departamento
      21-03-2013      luzaa               funcionalidad para comparar cantidades entre la ordende de certificacion y la orden
                                          de instalacion de nuevas.
      22-03-2013      luzaa               Funcion que permite obtener el valor del dato adicional de la orden de certificacion
                                          de instalacion de nuevas
      04-04-2013      luzaa               Funcionalidad que permite comparar cantidades entre los datos de la orden de certificacion
                                          y/o apoyo frente a la orden de instalacion y cargo por conexion
      30-04-2013      luzaa               Funcion que indica si a la orden de la instancia le aplica multa por mala asesoria-FNB
      02-05-2013      luzaa               Funcion que indica si debe excluir OT de instancia de acuerdo a OT validacion de documentos FNB
      15-05-2013      luzaa               Funcion que valida si los trabajos de reparacion por RP se incumplen con causal de suspension
      26-05-2013      cdominguez          Se adicionan los siguientes metodos:
                                            fsbVersion - Obtiene version del paquete
                                            ValidaTipoOrden - Valida el tipo de trabajo de una orden
                                            ValidaMtoSerie - Valida si una serie esta en un mantenimiento
                                            AL_CUMPLEORDENTRAB - Alerta para ordenes cumplidas
                                            AL_GENEORDENTRAB - Alerta para ordenes generadas
                                            AL_DISENO_REALIZADO - Alerta para dise?o realizado
      30-05-2013      luzaa               proincumplereparacion:Incumple orden de certificacion cuando incumple orden de reparacion
      28-05-2013      luzaa               procreaitemspago:Se encarga de crear la orden con los items de pago para
                                          las ordenes correspondientes de cargo por conexion e instalacion
      04-06-2013      luzaa               procomparacantcertrepara: objeto que se asocia a la actividad de reparacion para la legalizacion
                                          de la orden de reparacion
                                          fnucomparaitemscertrepara: compara las cantidades legalizadas entre los items de reparacion y
                                          los iems de los datos adicionales de la orden de certificacion y/o apoyo
      04-06-2013      luzaa               fsbValDatoAdicOtCertifRepara: obtiene el dato adicional de la orden de certificacion de reparacion
      26-05-2013      cdominguez          Se adicionan el metodo ObtieneLectura
      20-06-2013      luzaa               fsbDatoAdicTmpOrden: obtiene datos adicionales de una orden que se esta legalizando
      10-07-2013      luzaa               se elimina FSBGETIDLOCALIDAD y se crea FNUGETIDLOCALIDAD
      01-08-2013      luzaa               NC396: Al legalizar como incumplida la orden de CxC o de instalacion, debe cerrar la orden de
                                          certificacion y la orden de CxC o instalacion que estaba pendiente.
      01-08-2013      AEZ                 NR1820: Control de visualizacion opcion Anulacion de solicitudes.
      01-08-2013      Emirol              NC200: notificacion de visita de asesoria de constructora
                                          se creo la funcion fsbGetPHONES que concatena los telefonos
                                          del subscriber.
      07-08-2013        luzaa             NC459:Se cambia el API de legalizacion.
                                          Adicionalmente para que los tipos de trabajo que se excluyen sean
                                          configurables
      08-08-2013        jsoto             NC-320 Se realiza cambio en la funcion AL_GENEORDENTRAB para ordenes que aun no estan asigandas
      08-08-2013        luzaa             NC497:Se modifica para que los datos de la orden de la instancia los tome
                                          de lo registrado y no de la instancia
      12-08-2013        jsoto             Se crea la funcion AL_ORDENVENCIDA, para alerta de dise?o, se matricula el objeto en smartflex
                                          para programarlo como JOB
      13-08-2013        jsoto             Correccion funcion AL_DISENO_REALIZADO se ingresan en un parametro las personas a notificar
      22-08-2013        luzaa             NC396: modificacion al uso de causales quemadas por parametros
      13-09-2013        luzaa             NC707: se modifican los parametros que se pasan al API para generar las novedades, ya que la persona
                                          debe ser NULL y el valor no debe ser cero sino NULL
      17-09-2013        luzaa             NC746: Se ajusta la logica de proComparaCantCertInst (comparacion de cantidades instalacion y certificacion),
                                          para el caso en que se genero solo la OT de Cargo o solo la OT de instalacion.El mismo ajuste se realizo en
                                          procreaitemspago
      18-09-2013        luzaa             NC 746v2:se ajusta validacion para la creacion de items de pago, ya que no siempre se van a tener
                                          las 2 ordenes (CxC y/o Instalacion).
      20-09-2013        luzaa             NC 746v3: se ajusta logica del procedimiento procreaitemspago, ya que la OT ultima puede ser instalacion y no
                                          necesriamente la de cargo, como se habia definido
      24-09-2013        luzaa             NC871: Se ajusta logica de fsbexcluirotxvaliddoc, ya que siempre va a tener orden de comision sin importar el
                                          tipo de trabajo
      28-09-2013        luzaa             NC 746: se ajusto toda la logica para que tenga en cuenta la direccion, ya que para multifamiliares es por solicitud
                                          y direccion
      30-09-2013        luzaa             NC 738:se crea procedimiento provaliddatadiccertifnuevas, el cual: Restringe el uso de la causal "Legaliza sin inspeccion
                                          por culpa del cliente" a los contratistas. Si el contratista usa esa causal, entonces mostrara mensaje e impide continuar.
                                          Ademas de validar los datos adicionales de la orden de certificacion de nuevas para que muestre un mensaje cuando se
                                          ingresen datos adicionales de una orden (Cargo por conexion y/o Instalacion) que no existe
      03-10-2013        luzaa             NC999:Se ajusta la logica, ya que estaba trayendo mas de un registro la consulta que obtiene la solicitud
      03-10-2013        luzaa             NC992:se incluye validacion ya que si hay error en mediddor no lo estaba informando y se elimina la validacion
                                          de la presion
      04-10-2013        luzaa             NC999: Valida que la unidad operativa sea externa y no tenga orden de novedad asociada, para generar la multa de correccion
                                          Se corrige la funcion que pinta los datos adicionales de inicializacion para la orden de correccion
      16-10-2013        luzaa             NC746: se ajusta procreaitemspago, para que se muestre un mensaje cuando no se tiene configuracion en ORITC
                                          Se ajusta fnucomparaitemscertrepara, para que los items a comparar solo sean los tipo 51
      18-10-2013        luzaa             NC 746: Se ajusta PROCREAITEMSPAGO para que cuando se trate de una categoria comercial, solo pague la ACOMETIDA. Ademas que si es comercial
                                          y dependiendo del paquete, pague como constructora o como comercial
      18-10-2013        luzaa             NC1119: provalcausal3reparacion, Restringe el uso de la causal "CAUSAL_OT_CUMPLIDA_INST_DEFECT" para los tramites de RP
      22-10-2013        luzaa             NC1296: se impactan cursores que ordenan y deben retornar un registro
      30-10-2013        luzaa             NC 1437: Se ajusta en procreaitemspago, el material GALVANIZADO por ACERO. Ademas que se ajsute el mensaje correspondiente.
      31-10-2013        luzaa             NC1497: se ajusta validacion acerca de que la orden de certificacion debe estar legalizada antes que las de cargo o de
                                          instalacion en procomparacantcertinst
      12-11-2013        luzaa             NC 1148: se cambia la constructora que crea novedades, por constructora que crea ordenes cerradas y posteriormente se debe
                                          actualizar el valor para que se incluya en or_order_items (procreaitemspago)
      19-11-2013        luzaa             NC1586: Se ingresan los tipos de trabajo PAGO DE ARTICULO A PROVEEDOR,COBRO AL PROVEEDOR POR ARTICULO DEVUELTO,
                                          COBRO COMISION A PROVEEDOR, PAGO AL PROVEEDOR POR COMISION COBRADA para validacion y se ajusta la logica para
                                          que tenga en cuenta cuando debe excluir la ot de la instancia si la ot de revision de documentos no se ha legalizado  (fsbexcluirotxvaliddoc)
      26-11-2013        luzaa             NC1776: en procreaitemsapgo se devuelve la creacion de items automaticos de ordenes cerradas a novedades
      29-11-2013        luzaa             NC1925: Se modifica el codigo ya que habia una linea de codigo que impedia cerrar la orden de certificacion
      06-12-2013        luzaa             NC2081: Se modifica procomparaitemscertinst, para que cuando se compare con la orden de apoyo pase el tipo de trabajo adecuado
                                          (certificacion/apoyo). Validacion para la generacion de la multa si corresponde de acuerdo al valor de la ot de apoyo.
                                          Se cambia constructora que obtiene los grupos de atributos de acuerdo al tipo de trabajo.
      15-01-2014        smejia            NC 2459. Se modifica la funcion fsbaplimalaasesoria, para que valide la existencia de causal "Mala Asesoria" teniendo en cuenta
                                          la causal asociada a la solicitud de anulacion/devolucion(en MO_MOTIVE).
      06/03/2014       Jsoto              Caso aranda 3056  cambio de API para generacion de novedades
                                          de OS_REGISTERNEWCHARGE a LDC_OS_REGISTERNEWCHARGE

    27-01-2015  Sergio Gomez        Aranda 5876: Modificacion de la logica del cursor "cuObtOrdenRepara", para que la consulta se realice
                                          sobre la tabla OR_ORDER y no sobre la tabla OR_ORDER_ACTIVITY.
                                          De esta forma solo obtendr?? las ??rdenes de reparaci??n con trabajos
                                          certificables.

    22-04-2015  HAltamiranda        Aranda 6419: Creacion de la funcion fsbexcluirotxvaliddocperiodo para validar la liquidacion de contratistas brilla con las nuevas
                                          condiciones de fecha inicial y fianl que se esta liquidando y legalizaciones con causales de fallo.

    05-05-2015  Sergio Gomez         Se modifica la funcion FSBVALDATOADICOTCERTIF para que traiga la orden mas reciente y de ella
                                          se puedan sacar los atributos para inicializar la nueva orden Aranda 7087
    12-06-2015  Mmejia               Aranda 6555.Se modifica el cursor cucantotcerradas que obtiene la cantidad de ordenes cerradas
                                          para que  filtre las causales de legalizacion  diferentes a fallo.
    12-06-2015  Mmejia               Aranda 6555.Se modifica el cursor para obteng ornde con causal de exito y ordenes sin legalizar , esto daria la cantidad de ordenes
                                          de una solicitud sin tener en cuenta las ordenes con causal de fallo.
     23-06-2015 Mmejia               Aranda 6555: Se modifica el proceso <<procreaitemspago>> los cursores cuordencargo cuordeninst para que filtre las
                                          ordenes legalizadas con causal de exito.Tambien se modifica el cursor cuobtieneitems
                                          para que tenga los itmnes correctamente.
     08-07-2015 Mmejia               Aranda 6555:Se modifica los cursores que obtienen la informacino de ordenes por medio
                                          del paquete y la direccino para que obtenga la orden con causal de legalizacion clase
                                          exito.
    14-07-2015  LDiuza                Aranda 5695: Se modifica el metodo <<fnuvalidaactivpordefectos>>
                                                       Se crea metodo <<fnuValActivAndPackByDefec>>
    24-08-2015  Diegofg               Aranda 7087  se modifica el cursor cuordencorreccioncertif de la funcion FSBVALDATOADICOTCERTIF
    11-09-2015  LDiuza                Aranda 7087: Se modifica el metodo <<fsbValDatoAdicOtCertif>>
    18-10-2016  BCamargo            CA 200-347 Se unifican los paquetes de Efigas y GDC
    28-01-2018  STapias             REQ.2001634 se edita el metodo <<fsbexcluirotxvaliddocperiodo>>
    22-05-2018  DSALTARIN           CA 200-1922 Se corrige la consulta del procedimiento proincumplenuevas
    12-06-2018  josdon              Caso 200-1961 Modificaci??n de Regla de Exclusi??n Cardif.
                                    Se modifica la funci??n fsbexcluirotxvaliddocperiodo para que realice la exclusi??n si la orden de aprobaci??n no est?? legalizada
                                    para las unidades operativas diferentes a las parametrizadas en LDC_UNIDCARDIF
     
    25-11-2018  horbath             200-2179. Se modifica para atender requerimiento: Se solicita validar la legalizaci??n del tipo de trabajo 12149
                                            ya que no deja legalizar porque existen ??rdenes bloqueadas con causal. En la cual el error que arroja es:
                                            la ??ltima orden  de certificaci??n instalaciones legalizadas no tiene causal valida.
    02-01-2020  Eherard(Horbath)    REQ.185. Modificaición para anulación de solicitudes de RP. (100237, 100246, 100156, 100294, 100295, 100321)
    28-01-2020  Eceron(Horbath)     REQ.167. Se modifica AL_DISENO_REALIZADO
    09-09-2020  E.SANTIAGO(HORBATH) CA 494: modificacion del procedimiento PROCDIASATENCIONORDEN
    17-04-2024  jpinedc             OSF-2580: Envio de correo por medio de pkg_Correo en lugar de
                                            ut_mailpost.sendmailblobattachsmtp y ajustes por estandares 
                                            de programación
     *******************************************************************************/
    /*Vactor para almacenar los datos provenienetes linea de archivo*/
    TYPE tbarray IS TABLE OF VARCHAR2 (100)
        INDEX BY BINARY_INTEGER;

    arString   tbarray;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbGetAmount
      Descripción    : Retorna la cantidad de carracteres existentes en la cadena.

      Autor          : Jorge Valiente
      Fecha          : 23/10/2012

      Parametros                  Descripción
      ============           ===================
      isbLine                Linea de registro
      isbDelimiter           caracter a buscar

      Historia de Modificaciones
      Fecha            Autor                 M??todos
      =========        =========             ====================
    ******************************************************************/
    FUNCTION FsbGetAmount (isbLine IN VARCHAR2, isbDelimiter IN VARCHAR2)
        RETURN NUMBER;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbGetArray
      Descripción    : Retorna los datos en un de la linea
                       del archivo en un vector de cadena

      Autor          : Jorge Valiente
      Fecha          : 23/10/2012

      Parametros                  Descripción
      ============           ===================
      inuAmount              Cantidad de caracteres
      isbLine                Linea de registro
      isbDelimiter           caracter a buscar

      Historia de Modificaciones
      Fecha            Autor                 M??todos
      =========        =========             ====================
    ******************************************************************/
    FUNCTION FsbGetArray (inuAmount      IN NUMBER,
                          isbLine        IN VARCHAR2,
                          isbDelimiter   IN VARCHAR2)
        RETURN tbarray;

    /*****************************************
    Metodo: FrgItemOrden
    Descripcion:  Crea un nuevo registro en la entidad
                  OR_ORDER_ITEMS con la orden de
                  conexiones nuevas para items automaticos.

    Autor: Jorge Valiente
    Fecha: 02 Abril 2014

       Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========       =========           ====================
     ******************************************/
    FUNCTION FrgItemOrden (inu_order_id               NUMBER,
                           inu_items_id               NUMBER,
                           inu_assigned_item_amount   NUMBER,
                           inu_legal_item_amount      NUMBER,
                           inu_value                  NUMBER)
        RETURN NUMBER;

    FUNCTION FnugetTotalOTbyContrDatAdd (nuTipoTrab      IN NUMBER,
                                         nuSetAttrib     IN NUMBER,
                                         NombDatAdd      IN VARCHAR2,
                                         NuContratista   IN NUMBER,
                                         ValorAct        IN VARCHAR2,
                                         NuSolicitud     IN NUMBER)
        RETURN NUMBER;

    FUNCTION FnugetValorOTbyDatAdd (nuTipoTrab    IN NUMBER,
                                    nuSetAttrib   IN NUMBER,
                                    NombDatAdd    IN VARCHAR2,
                                    NuOt          IN VARCHAR)
        RETURN VARCHAR;

    FUNCTION FsbGetNombLocalidad (NuOperatingSctor_Id IN NUMBER)
        RETURN VARCHAR;

    FUNCTION FsbGetNombDept (NuOperatingSctor_Id IN NUMBER)
        RETURN VARCHAR;

    FUNCTION FNUGETORDBYPACKCAUSCLASS (INUPACKAGEID      IN NUMBER,
                                       INUACTIVITYID     IN NUMBER,
                                       NUCAUSALCLASSID   IN NUMBER)
        RETURN NUMBER;

    FUNCTION fnuGetFechaReision (NUPRODUCT_ID Pr_product.PRODUCT_ID%TYPE)
        RETURN DATE;

    PROCEDURE OrdIspecOyM (NuOrder_Ir or_order.ORDER_ID%TYPE);

    PROCEDURE AsigOT (
        NuOrder_ID            or_order.ORDER_ID%TYPE,
        NuOPERATING_UNIT_ID   or_operating_unit.OPERATING_UNIT_ID%TYPE);

    FUNCTION FSBTRABAJOSNOLEGALIZAORCAO (TASK_TYPE VARCHAR2)
        RETURN VARCHAR2;

    PROCEDURE PROCVALRANGOTIEMPLEGOT (
        DTASSIGNED_DATE       IN     OR_ORDER.ASSIGNED_DATE%TYPE,
        DTLEGALIZATION_DATE   IN     OR_ORDER.LEGALIZATION_DATE%TYPE,
        NuDEPARTAMENTO        IN     LDC_TMLOCALTTRA.DEPARTAMENTO%TYPE,
        NuLOCALIDAD           IN     LDC_TMLOCALTTRA.LOCALIDAD%TYPE,
        NuTIPOTRABAJO         IN     LDC_TMLOCALTTRA.TIPOTRABAJO%TYPE,
        NuCAUSAL              IN     LDC_TMLOCALTTRA.CAUSAL%TYPE,
        NuPROVEEDOR           IN     LDC_TMLOCALTTRA.PROVEEDOR%TYPE,
        NuNUMERODIAS             OUT LDC_TMLOCALTTRA.TIEMPO%TYPE,
        NuPORCENTAJE             OUT LDC_TMLOCALTTRA.PORCENTAJE%TYPE,
        NuVALOR                  OUT LDC_TMLOCALTTRA.VALOR%TYPE,
        NuDias                   OUT NUMBER);

    FUNCTION FNUVALRANGOTIEMPLEGOT (
        DTASSIGNED_DATE       OR_ORDER.ASSIGNED_DATE%TYPE,
        DTLEGALIZATION_DATE   OR_ORDER.LEGALIZATION_DATE%TYPE,
        SBPARAMETER_ID        LD_PARAMETER.PARAMETER_ID%TYPE)
        RETURN NUMBER;

    /*****************************************
    Metodo: PROCDIASATENCIONORDEN
    Descripcion:  Procedmiento que permite obtener:
                  Numero de dias maximos para la Ejecucion o
                  legalizacion de la orden y el valor con el que multa.

    Autor: Jorge Valiente
    Fecha: 3 de Mayo de 2013

    Parametro               Descripcion
    ==================      ===================================
    IDTASSIGNED_DATE        fecha de asigancion de la orden
    IDTEJECLEGAL_DATE       fecha de ejecucion o legalizacion de la orden
    INuDEPARTAMENTO         codigo del departamento
    INuLOCALIDAD            codigo de la localidad
    INuTIPOTRABAJO          codigo tipo de trabajo
    INuACTIVIDAD            codigo de actividad
    INuCAUSAL               codigo de causal
    INuESTADO               E[Ejecucion] L[Legalizacion] o NULL
    INuPROVEEDOR            codigo proveedor / unidad operativa
    ONuNUMERODIAS           maximo de dias para ejecutar o legalizar la orden
    ONuPORCENTAJE           porcetaje de multa
    ONuVALOR                valor de multa
    ONuDias                 cantidad ed dias para obtener valor de multa

     Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************/
    PROCEDURE PROCDIASATENCIONORDEN (
        IDTASSIGNED_DATE    IN     OR_ORDER.ASSIGNED_DATE%TYPE,
        IDTEJECLEGAL_DATE   IN     OR_ORDER.LEGALIZATION_DATE%TYPE,
        INuDEPARTAMENTO     IN     LDC_TMLOCALTTRA.DEPARTAMENTO%TYPE,
        INuLOCALIDAD        IN     LDC_TMLOCALTTRA.LOCALIDAD%TYPE,
        INuTIPOTRABAJO      IN     LDC_TMLOCALTTRA.TIPOTRABAJO%TYPE,
        INuACTIVIDAD        IN     LDC_TMLOCALTTRA.ACTIVIDAD%TYPE,
        INuCAUSAL           IN     LDC_TMLOCALTTRA.CAUSAL%TYPE,
        ISbESTADO           IN     LDC_TMLOCALTTRA.ESTADO%TYPE,
        INuPROVEEDOR        IN     LDC_TMLOCALTTRA.PROVEEDOR%TYPE,
        ONuTIEMPO              OUT LDC_TMLOCALTTRA.TIEMPO%TYPE,
        ONuPORCENTAJE          OUT LDC_TMLOCALTTRA.PORCENTAJE%TYPE,
        ONuVALOR               OUT LDC_TMLOCALTTRA.VALOR%TYPE,
        ONuDias                OUT LDC_TMLOCALTTRA.TIEMPO%TYPE);

    FUNCTION FnuGETIDLOCALIDAD (nuOrderId IN NUMBER)
        RETURN NUMBER;

    FUNCTION FSBGETIDDEPT (NUOPERATINGSCTOR_ID IN NUMBER)
        RETURN NUMBER;

    PROCEDURE PROCPNOOTLEGFALLO (
        ORDER_ID            OR_ORDER.ORDER_ID%TYPE,
        ORDER_STATUS_ID     OR_ORDER.ORDER_STATUS_ID%TYPE,
        OPERATING_UNIT_ID   OR_ORDER.OPERATING_UNIT_ID%TYPE);

    FUNCTION fsbValDatoAdicOtCertif (
        nuTipoTrab    or_task_type.task_type_id%TYPE,
        nuSetAttrib   ge_attributes_set.attribute_set_id%TYPE,
        nombDatAdd    ge_attributes.name_attribute%TYPE,
        nuOrderId     or_order.order_id%TYPE)
        RETURN VARCHAR2;

    FUNCTION fsbctrllegalizaordenxorcao (NUORDER_ID   IN VARCHAR2,
                                         sbtasktype   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION fsbctrlasignacionordenxorcao (sbtasktype IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION fnucomparadatosadicionales (
        nuordeno        IN OUT or_order.order_id%TYPE,
        nuOrdenCxC      IN OUT or_order.order_id%TYPE,
        nuordeninst     IN OUT or_order.order_id%TYPE,
        nuTipoTrabCa    IN OUT or_task_type.task_type_id%TYPE,
        nutipotrabo     IN OUT or_task_type.task_type_id%TYPE,
        nutipotrabi     IN OUT or_task_type.task_type_id%TYPE,
        sbgrupodato     IN OUT ge_equivalenc_values.target_value%TYPE,
        nuactivid       IN     or_order_activity.order_activity_id%TYPE,
        sbAtributoDif      OUT VARCHAR2)
        RETURN NUMBER;

    PROCEDURE proComparaCantCertInst;

    FUNCTION fsbaplimalaasesoria (nuorder_id IN or_order.order_id%TYPE)
        RETURN VARCHAR2;

    FUNCTION fsbexcluirotxvaliddoc (nuorder_id IN or_order.order_id%TYPE)
        RETURN VARCHAR;

    FUNCTION fsbexcluirotxvaliddocperiodo (
        nuorder_id       IN or_order.order_id%TYPE,
        idafechainicio   IN DATE,
        idafechafin      IN DATE)
        RETURN VARCHAR;

    FUNCTION fnuvalidaactivpordefectos (
        inuActivityId     IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        inuCodActividad   IN OR_ORDER_ACTIVITY.ORDER_ITEM_ID%TYPE)
        RETURN NUMBER;

    FUNCTION fnuValActivAndPackByDefec (
        inuActivityId      IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        inuCodActividad    IN OR_ORDER_ACTIVITY.ORDER_ITEM_ID%TYPE,
        inuPackageTypeId   IN MO_PACKAGES.PACKAGE_TYPE_ID%TYPE)
        RETURN NUMBER;

    FUNCTION fsbvalidareparaincumplidaSusp (
        nupackage   IN or_order_activity.package_id%TYPE)
        RETURN VARCHAR2;

    FUNCTION fsbValidaSerial (nuSerial IN VARCHAR2)
        RETURN VARCHAR2;

    ------------------
    FUNCTION fsbVersion
        RETURN VARCHAR2;

    FUNCTION ValidaTipoOrden (inuOrden   OR_order.order_id%TYPE,
                              isbTipos   VARCHAR2)
        RETURN NUMBER;

    FUNCTION ValidaMtoSerie (isbSerie VARCHAR2)
        RETURN NUMBER;

    PROCEDURE AL_CUMPLEORDENTRAB (inuOrden IN OR_order.order_id%TYPE);

    PROCEDURE AL_GENEORDENTRAB (inuOrden IN OR_order.order_id%TYPE);

    FUNCTION AL_GENEORDENTRAB_NEW (inuOrden IN OR_order.order_id%TYPE)
        RETURN VARCHAR2;

    FUNCTION AL_DISENO_REALIZADO (inuOrden IN OR_order.order_id%TYPE)
        RETURN VARCHAR2;

    FUNCTION AL_CUMPLEORDENTRAB_NEW (inuOrden IN OR_order.order_id%TYPE)
        RETURN VARCHAR2;

    FUNCTION AL_ORDENVENCIDA
        RETURN VARCHAR2;

    FUNCTION GetMailNotify (
        inuOrden    OR_order.order_id%TYPE,
        inuEstado   OR_order_stat_change.final_status_id%TYPE)
        RETURN VARCHAR2;

    PROCEDURE proincumplereparacion;

    PROCEDURE prAsigMasivOrdGC (ORDER_ID OR_ORDER.ORDER_ID%TYPE);

    PROCEDURE procreaitemspago (nuordeninstance or_order.order_id%TYPE);

    FUNCTION fnucomparaitemscertrepara (
        nusolicitud   or_order_activity.package_id%TYPE,
        nuorden       or_order.order_id%TYPE,
        nutipotrab    or_order.task_type_id%TYPE,
        sbGrupos      VARCHAR2)
        RETURN VARCHAR2;

    PROCEDURE procomparacantcertrepara;

    FUNCTION fsbValDatoAdicOtCertifRepara (
        nuTipoTrab    or_task_type.task_type_id%TYPE,
        nuSetAttrib   ge_attributes_set.attribute_set_id%TYPE,
        nombdatadd    ge_attributes.name_attribute%TYPE,
        nuorderid     or_order.order_id%TYPE)
        RETURN VARCHAR2;

    FUNCTION ObtieneLectura (inuOrden OR_order.order_id%TYPE)
        RETURN NUMBER;

    FUNCTION fsbDatoAdicTmpOrden (
        nuorden        or_order.order_id%TYPE,
        nuidatributo   or_temp_data_values.attribute_id%TYPE,
        sbatributo     or_temp_data_values.attribute_name%TYPE)
        RETURN VARCHAR2;

    FUNCTION fnuControlVisualAnulSoli (
        sbPackageTypeId   PS_PACKAGE_TYPE.DESCRIPTION%TYPE)
        RETURN NUMBER;

    --
    PROCEDURE proincumplenuevas;

    FUNCTION fsbGetPHONES (inuSubscriberId ge_subscriber.subscriber_id%TYPE)
        RETURN VARCHAR2;

    FUNCTION fsbActividadVtas (nuMotiveId    mo_motive.motive_id%TYPE,
                               nuPackageId   mo_packages.package_id%TYPE)
        RETURN NUMBER;

    FUNCTION fnuaplicadatoadicionalnuevas (inuorden or_order.order_id%TYPE)
        RETURN NUMBER;

    FUNCTION fnuDevuelveEstadoProducto (
        inuProductId   IN pr_product.product_id%TYPE)
        RETURN NUMBER;

    PROCEDURE provalidatadiccertnuevas;

    PROCEDURE provalcausal3reparacion;

    FUNCTION fnuGetAreaOrganizat (
        nuPackageTypeId    IN MO_PACKAGES.PACKAGE_TYPE_ID%TYPE,
        nuCategory         IN CATEGORI.CATECODI%TYPE,
        inuPackageIdAnul   IN mo_packages.package_id%TYPE)
        RETURN NUMBER;

    /*****************************************
    METODO: FNUCOMPARAITEMSCERTEJE
    DESCRIPCION:  COMPARA CANTIDADES DE ITEMS LEGALIZADOS ENTRE LA ORDEN DE CERTIFICACION O APOYO (CERTIFICADOR)
                  Y LA ORDEN DE NUEVAS (EJECUTOR) RETORNA 0 SI ENCONTRO DIFERENCIAS PARA ORDENES NUEVAS

    AUTOR: JORGE VALIENTE

    FECHA: 18 JUNIO 2014

    FECHA                IDENTREGA           MODIFICACION
    ============    ================    ============================================
    ******************************************/
    FUNCTION FNUCOMPARAITEMSCERTEJE (
        NUORDENLEGALIZADA     IN     OR_ORDER.ORDER_ID%TYPE,
        NUORDENCERITIFCADOR   IN     OR_ORDER.ORDER_ID%TYPE,
        SBGRUPOS              IN     VARCHAR2,
        SBMENSAJE                OUT VARCHAR2)
        RETURN VARCHAR2;

    /*****************************************
    METODO: PRCOMPARAPROCOMPARACANTCERTREPARA
    DESCRIPCION:  COMPARA CANTIDADES DE ITEMS LEGALIZADOS ENTRE LA ORDEN DE CERTIFICACION O APOYO (CERTIFICADOR)
                  Y LA ORDEN DE NUEVAS (EJECUTOR) OBTENIDOS DESDE LA INSTANCIA

    AUTOR: JORGE VALIENTE

    FECHA: 18 JUNIO 2014

    FECHA                IDENTREGA           MODIFICACION
    ============    ================    ============================================
    ******************************************/
    PROCEDURE PROCOMPARAITEMSCERTEJE;

    /*****************************************
    Metodo: FSBDATOITEMNUEVAS
    Descripcion:  Funcion que permite obtener el valor del dato adicional de la orden de
                  INSPECCION Y7O certificacion DE NUEVAS

    Autor: Jorge Valiente
    Fecha: 22 Julio 2014

    Fecha                IDEntrega           Modificacion
    ============    ================    ============================================
     ******************************************/
    FUNCTION FSBDATOITEMNUEVAS (nombDatAdd ge_attributes.name_attribute%TYPE)
        RETURN VARCHAR2;
END;
/

CREATE OR REPLACE PACKAGE BODY LDC_BOORDENES
AS
    /*****************************************************************
      Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
      07/10/2013       Sayra Ocoro      *Se modifica CurTPLOCALTRA para que tenga en cuenta
                                        las cofiguraciones genericas.
      13-12-2013       Sayra Ocoro      * Se modifican los metodos
                                          PROCREAITEMSPAGO - procomparacantcertrepara - proComparaCantCertInst
                                        para solucionar la NC 2094
      20-23-2012       Sayra Ocoro      *NC 2151: Se modifica query deinamico

     06/03/2014       Jsoto            Caso aranda 3056  cambio de API para generacion de novedades
                                        de OS_REGISTERNEWCHARGE a LDC_OS_REGISTERNEWCHARGE
     12-06-2015      Mmejia               Aranda 6555.Se modifica el cursor cucantotcerradas que obtiene la cantidad de ordenes cerradas
                                          para que  filtre las causales de legalizacion  diferentes a fallo.
     12-06-2015      Mmejia               Aranda 6555.Se modifica el cursor para obteng ornde con causal de exito y ordenes sin legalizar , esto daria la cantidad de ordenes
                                          de una solicitud sin tener en cuenta las ordenes con causal de fallo.
     28-01-2018      STapias            REQ.2001634 se edita el metodo <<fsbexcluirotxvaliddocperiodo>>
    08-05-2018      dsaltarin          ca 200-1922. Se modifica el cursor CUULTIMAOTCERTIFICAION  del procedimeinto proincumplenuevas
                    |                  para que solo valide ordenes ene stado 8
    12-06-2018      josdon             Caso 200-1961 Modificación de Regla de Exclusión Cardif.
                                       Se modifica la función fsbexcluirotxvaliddocperiodo para que realice la Exclusión si la orden de aprobación no está legalizada
                                       para las unidades operativas diferentes a las parametrizadas en LDC_UNIDCARDIF
     02-01-2020      Eherard(Horbath)   REQ.185. Modificaición para anulación de solicitudes de RP. (100237, 100246, 100156, 100294, 100295, 100321)
    28-01-2020      Eceron(Horbath)    REQ.167. Se modifica AL_DISENO_REALIZADO
     /*****************************************
      Metodo: fsbgetvalorcampotabla
      Descripcion:  nuTipoTrab: codigo del trabajo
                    nuSetAttrib: Codigo del grupo de atributos
           NombDatAdd: Nombre del atributo
           NuContratista: Numero de contratista
           ValorAct:   valor del dato digitado
           NuSolicitud: Numero de la solicitud

     Autor: Jose C. Filigrna
      Fecha: Noviembre 09/2011
      ******************************************/
    -- Esta constante se debe modificar cada vez que se entregue el paquete con un SAO
    csbVersion   CONSTANT VARCHAR2 (250) := 'OSF-2580';
    nuError               NUMBER;
    sbError               VARCHAR2 (2000);

    FUNCTION fsbVersion
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN csbVersion;
    END;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbGetAmount
      Descripción    : Retorna la cantidad de carracteres existentes en la cadena.

      Autor          : Jorge Valiente
      Fecha          : 23/10/2012

      Parametros                  Descripción
      ============           ===================
      isbLine                Linea de registro
      isbDelimiter           caracter a buscar

      Historia de Modificaciones
      Fecha            Autor                 Modificación
      =========        =========             ====================
    ******************************************************************/
    FUNCTION FsbGetAmount (isbLine IN VARCHAR2, isbDelimiter IN VARCHAR2)
        RETURN NUMBER
    IS
        sbLine   VARCHAR2 (4000);
    BEGIN
        sbLine := isbLine;
        pkg_Traza.Trace ('Inicio LD_BOsubsidy.FsbGetAmount', 10);
        RETURN REGEXP_COUNT (sbLine, '.*?\' || isbDelimiter);
        pkg_Traza.Trace ('Fin LD_BOsubsidy.FsbGetAmount', 10);
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RETURN (-1);
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            RETURN (-1);
            RAISE pkg_Error.CONTROLLED_ERROR;
    END FsbGetAmount;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : FsbGetArray
      Descripción    : Retorna los datos en un de la linea
                       del archivo en un vector de cadena

      Autor          : Jorge Valiente
      Fecha          : 23/10/2012

      Parametros                  Descripción
      ============           ===================
      inuAmount              Cantidad de caracteres
      isbLine                Linea de registro
      isbDelimiter           caracter a buscar

      Historia de Modificaciones
      Fecha            Autor                 Modificación
      =========        =========             ====================
    ******************************************************************/
    FUNCTION FsbGetArray (inuAmount      IN NUMBER,
                          isbLine        IN VARCHAR2,
                          isbDelimiter   IN VARCHAR2)
        RETURN tbarray
    IS
        sbLine        VARCHAR2 (4000);
        nuAmount      NUMBER;
        sbDelimiter   VARCHAR2 (1);
        arString      tbarray;
    BEGIN
        sbLine := isbLine;
        nuAmount := inuAmount;
        sbDelimiter := isbDelimiter;
        pkg_Traza.Trace ('Inicio LD_BOsubsidy.FsbGetArray', 10);

        FOR i IN 1 .. nuAmount
        LOOP
            arString (i) :=
                REGEXP_SUBSTR (sbLine,
                               '.*?\' || sbDelimiter,
                               1,
                               i);
            arString (i) := REPLACE (arString (i), sbDelimiter, NULL);

            IF arString (i) = ' '
            THEN
                arString (i) := NULL;
            END IF;
        END LOOP;

        IF REPLACE (
               REPLACE (SUBSTR (sbLine, INSTR (sbLine, ',', -1)), ',', NULL),
               ' ',
               NULL)
               IS NOT NULL
        THEN
            arString (nuAmount) :=
                REPLACE (
                    REPLACE (SUBSTR (sbLine, INSTR (sbLine, ',', -1)),
                             ',',
                             NULL),
                    ' ',
                    NULL);
        END IF;

        RETURN (arString);
        pkg_Traza.Trace ('Fin LD_BOsubsidy.FsbGetArray', 10);
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;
    END FsbGetArray;

    /*****************************************
    Metodo: FrgItemOrden
    Descripcion:  Crea un nuevo registro en la entidad
                  OR_ORDER_ITEMS con la orden de
                  conexiones nuevas para items automaticos.

    Autor: Jorge Valiente
    Fecha: 02 Abril 2014

       Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========       =========           ====================
     ******************************************/
    FUNCTION FrgItemOrden (inu_order_id               NUMBER,
                           inu_items_id               NUMBER,
                           inu_assigned_item_amount   NUMBER,
                           inu_legal_item_amount      NUMBER,
                           inu_value                  NUMBER)
        RETURN NUMBER
    IS
    BEGIN
        pkg_Traza.Trace ('Finaliza LDC_BOORDENES.FrgItemOrden', 15);

        INSERT INTO or_order_items (order_id,
                                    items_id,
                                    assigned_item_amount,
                                    legal_item_amount,
                                    VALUE,
                                    order_items_id,
                                    total_price,
                                    element_code,
                                    order_activity_id,
                                    element_id,
                                    reused,
                                    serial_items_id,
                                    serie,
                                    out_)
             VALUES (inu_order_id,
                     inu_items_id,
                     inu_assigned_item_amount,
                     inu_legal_item_amount,
                     inu_value,
                     seq_or_order_items.NEXTVAL,
                     0,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL);

        RETURN 0;
        pkg_Traza.Trace ('Finaliza LDC_BOORDENES.FrgItemOrden', 15);
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN -1;
    END FrgItemOrden;

    FUNCTION FnugetTotalOTbyContrDatAdd (nuTipoTrab      IN NUMBER,
                                         nuSetAttrib     IN NUMBER,
                                         NombDatAdd      IN VARCHAR2,
                                         NuContratista   IN NUMBER,
                                         ValorAct        IN VARCHAR2,
                                         NuSolicitud     IN NUMBER)
        RETURN NUMBER
    IS
        NuOrdeValue       NUMBER;
        SnNombAtrib       VARCHAR2 (50);
        NuAtrib           VARCHAR2 (50);
        NuCAPTURE_ORDER   NUMBER;
        query_str         VARCHAR2 (2000);
        nuOk              NUMBER;

        CURSOR CuCAPTURE_ORDER IS
            SELECT b.CAPTURE_ORDER
              FROM ge_attributes a, ge_attrib_set_attrib b
             WHERE     a.ATTRIBUTE_ID = b.ATTRIBUTE_ID
                   AND a.NAME_ATTRIBUTE = NombDatAdd;
    BEGIN
        OPEN CuCAPTURE_ORDER;

        FETCH CuCAPTURE_ORDER INTO NuCAPTURE_ORDER;

        CLOSE CuCAPTURE_ORDER;

        SnNombAtrib := 'a.NAME_' || TO_CHAR (NuCAPTURE_ORDER);
        NuAtrib := 'a.VALUE_' || TO_CHAR (NuCAPTURE_ORDER);
        query_str :=
               'select nvl(count(1),0) '
            || 'from or_requ_data_value a,or_order b, or_operating_unit c, or_order_activity d  '
            || 'where a.ORDER_ID=b.ORDER_ID '
            || ' and b.OPERATING_UNIT_ID=c.OPERATING_UNIT_ID '
            || ' and a.ORDER_ID=d.ORDER_ID'
            || ' and   a.TASK_TYPE_ID= '
            || nuTipoTrab
            || ' and   a.ATTRIBUTE_SET_ID= '
            || nuSetAttrib
            || ' and '
            || SnNombAtrib
            || '= '''
            || NombDatAdd
            || ''' and '
            || NuAtrib
            || '= '''
            || ValorAct
            || ''' and  c.CONTRACTOR_ID= '
            || NuContratista
            || ' and  nvl(d.PACKAGE_ID,0) <> '
            || NVL (NuSolicitud, 0);
        DBMS_OUTPUT.put_line (query_str);

        EXECUTE IMMEDIATE query_str
            INTO NuOrdeValue;

        RETURN NuOrdeValue;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            ---no existen datos
            RETURN -1;
        WHEN OTHERS
        THEN
            DBMS_OUTPUT.put_line ('Error ' || SQLERRM);
            ---se esta generando un error al ejecutar la funcion
            RETURN -2;
    END FnugetTotalOTbyContrDatAdd;

    /*****************************************
    Metodo: FnugetValorOTbyDatAdd
    Descripcion:  Retorna el valor de un datoa adicional teniendo en cuenta el orden, que tenia el dato adiciona al momento de legaliar la orden de trabjo
                  nuTipoTrab: codigo del trabajo
                  nuSetAttrib: Codigo del grupo de atributos
         NombDatAdd: Nombre del atributo
         NuOt: Numero de la Orden de trabajo

    Autor: Jose C. Filigrna
    Fecha: Noviembre 10/2011

       Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========       =========           ====================
      18-03-2014      smejia              Aran 94392. Se modifica la consulta a DBA_TAB_COLUMNS
                                          de modo que el tipo de dato del campo, se obtenga haciendo
                                          uso del squema de Smartflex (GE_ENTITY, GE_ENTITY_ATTRIBUTES,...)
     ******************************************/
    FUNCTION FnugetValorOTbyDatAdd (nuTipoTrab    IN NUMBER,
                                    nuSetAttrib   IN NUMBER,
                                    NombDatAdd    IN VARCHAR2,
                                    NuOt          IN VARCHAR)
        RETURN VARCHAR
    IS
        NuOrdeValue       NUMBER;
        SnNombAtrib       VARCHAR2 (50);
        NuAtrib           VARCHAR2 (50);
        NuCAPTURE_ORDER   NUMBER;
        query_str         VARCHAR2 (2000);
        query_str1        VARCHAR2 (2000);
        query_str2        VARCHAR2 (2000);
        SbVatrib          VARCHAR2 (200);
        SbValue           VARCHAR2 (50);
        SbColumna         VARCHAR2 (50);
        SbPrgunta         VARCHAR2 (2000);
        SbPrgunta1        VARCHAR2 (2000);
        SbValuetrib       VARCHAR2 (100);
        NuPregunta        NUMBER;
        NuVatrib          NUMBER;

        CURSOR CuCAPTURE_ORDER IS
            SELECT b.CAPTURE_ORDER
              FROM ge_attributes a, ge_attrib_set_attrib b
             WHERE     a.ATTRIBUTE_ID = b.ATTRIBUTE_ID
                   AND b.ATTRIBUTE_SET_ID = nuSetAttrib
                   AND a.NAME_ATTRIBUTE = NombDatAdd;

        CURSOR CuColumna IS
            SELECT ea.technical_name     column_name
              FROM ge_entity en, ge_entity_attributes ea
             WHERE     en.name_ = 'OR_REQU_DATA_VALUE'
                   AND ea.entity_id = en.entity_id
                   AND SUBSTR (UPPER (ea.technical_name), 1, 5) = 'NAME_';

        CURSOR CuDatoOt IS
            SELECT *
              FROM or_requ_data_value
             WHERE order_id = NuOt AND ATTRIBUTE_SET_ID = nuTipoTrab;
    BEGIN
        SbValuetrib := '-1';

        FOR CuColumna_rec IN CuColumna
        LOOP
            SbValue := 'VALUE_' || SUBSTR (CuColumna_rec.column_name, 6, 2);
            SbColumna := CuColumna_rec.column_name;
            query_str1 :=
                   'Select count(1)'
                || ' from or_requ_data_value '
                || ' where order_id= '
                || NuOt
                || ' AND   ATTRIBUTE_SET_ID= '
                || nuSetAttrib
                || ' and  '
                || SbColumna
                || '='''
                || NombDatAdd
                || '''';
            --dbms_output.put_Line('QUERY1:'||query_str1);
            query_str2 :=
                   'Select nvl('
                || SbValue
                || ',-1)'
                || ' from or_requ_data_value '
                || ' where order_id= '
                || NuOt
                || ' AND   ATTRIBUTE_SET_ID= '
                || nuSetAttrib
                || ' and  '
                || SbColumna
                || '='''
                || NombDatAdd
                || '''';

            --dbms_output.put_Line('QUERY2:'||query_str2);
            EXECUTE IMMEDIATE query_str1
                INTO SbVatrib;

            NuVatrib := TO_NUMBER (SbVatrib);

            IF NuVatrib > 0
            THEN
                EXECUTE IMMEDIATE query_str2
                    INTO SbValuetrib;

                EXIT WHEN NuVatrib > 0;
            END IF;
        END LOOP;

        RETURN SbValuetrib;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            ---no existen datos
            RETURN '-1';
        WHEN OTHERS
        THEN
            ---se esta generando un error al ejecutar la funcion
            DBMS_OUTPUT.PUT_LINE ('Error ' || SQLERRM);
            RETURN '-2';
    END FnugetValorOTbyDatAdd;

    /*****************************************
    Metodo: FsbGetNombLocalidad
    Descripcion:  Retorna el codigo de la localidad mas la descripcion de la misma
                  El parametro que recibe la funcion es codigo del sector operativo (NuOperatingSctor_Id)

    Autor: Jose C. Filigrna
    Fecha: Enero 11/2012

     ******************************************/
    FUNCTION FsbGetNombLocalidad (NuOperatingSctor_Id IN NUMBER)
        RETURN VARCHAR
    IS
        CURSOR CuNombLocalidad IS
            SELECT    LDC_BOUTILITIES.fsbGetValorCampoTabla (
                          'GE_GEOGRA_LOCATION',
                          'GEOGRAP_LOCATION_ID',
                          'GEO_LOCA_FATHER_ID',
                          d.GEOGRAP_LOCATION_ID)
                   || ' - '
                   || LDC_BOUTILITIES.fsbGetValorCampoTabla (
                          'GE_GEOGRA_LOCATION',
                          'GEOGRAP_LOCATION_ID',
                          'DESCRIPTION',
                          LDC_BOUTILITIES.fsbGetValorCampoTabla (
                              'GE_GEOGRA_LOCATION',
                              'GEOGRAP_LOCATION_ID',
                              'GEO_LOCA_FATHER_ID',
                              d.GEOGRAP_LOCATION_ID))    loca
              FROM ge_geogra_location d
             WHERE d.OPERATING_SECTOR_ID = NuOperatingSctor_Id AND ROWNUM = 1;

        SbNombreLocalidad   VARCHAR2 (1000);
    BEGIN
        OPEN CuNombLocalidad;

        FETCH CuNombLocalidad INTO SbNombreLocalidad;

        IF CuNombLocalidad%NOTFOUND
        THEN
            SbNombreLocalidad := '-1';
        END IF;

        CLOSE CuNombLocalidad;

        RETURN SbNombreLocalidad;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            ---no existen datos
            RETURN '-1';
        WHEN OTHERS
        THEN
            ---se esta generando un error al ejecutar la funcion
            RETURN '-2';
    END FsbGetNombLocalidad;

    /*****************************************
    Metodo: FsbGetNombDept
    Descripcion:  Retorna el codigo del departamento mas la descripcion del mismo
                  El parametro que recibe la funcion es codigo del sector operativo (NuOperatingSctor_Id)

    Autor: Jose C. Filigrna
    Fecha: Enero 11/2012

     ******************************************/
    FUNCTION FsbGetNombDept (NuOperatingSctor_Id IN NUMBER)
        RETURN VARCHAR
    IS
        CURSOR CuNombDept IS
            SELECT    LDC_BOUTILITIES.fsbGetValorCampoTabla (
                          'GE_GEOGRA_LOCATION',
                          'GEOGRAP_LOCATION_ID',
                          'GEO_LOCA_FATHER_ID',
                          LDC_BOUTILITIES.fsbGetValorCampoTabla (
                              'GE_GEOGRA_LOCATION',
                              'GEOGRAP_LOCATION_ID',
                              'GEO_LOCA_FATHER_ID',
                              d.GEOGRAP_LOCATION_ID))
                   || ' - '
                   || LDC_BOUTILITIES.fsbGetValorCampoTabla (
                          'GE_GEOGRA_LOCATION',
                          'GEOGRAP_LOCATION_ID',
                          'DESCRIPTION',
                          LDC_BOUTILITIES.fsbGetValorCampoTabla (
                              'GE_GEOGRA_LOCATION',
                              'GEOGRAP_LOCATION_ID',
                              'GEO_LOCA_FATHER_ID',
                              LDC_BOUTILITIES.fsbGetValorCampoTabla (
                                  'GE_GEOGRA_LOCATION',
                                  'GEOGRAP_LOCATION_ID',
                                  'GEO_LOCA_FATHER_ID',
                                  d.GEOGRAP_LOCATION_ID)))
              FROM ge_geogra_location d
             WHERE d.OPERATING_SECTOR_ID = NuOperatingSctor_Id AND ROWNUM = 1;

        SbNombreDept   VARCHAR2 (1000);
    BEGIN
        OPEN CuNombDept;

        FETCH CuNombDept INTO SbNombreDept;

        IF CuNombDept%NOTFOUND
        THEN
            SbNombreDept := '-1';
        END IF;

        CLOSE CuNombDept;

        RETURN SbNombreDept;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            ---no existen datos
            RETURN '-1';
        WHEN OTHERS
        THEN
            ---se esta generando un error al ejecutar la funcion
            RETURN '-2';
    END FsbGetNombDept;

    /*****************************************
    Metodo: FNUGETORDBYPACKCAUSTYPE
    Descripcion:   Retorna el codigo de la orden de trabajo de acuerdo a la actividad y
                   clase de causal, siempre que la orden se encuentre finalizada.
                   Calse de causal:
                   1 Exito
                   2 Fallo

    Autor: Luz Andrea Angel/OLSoftware
    Fecha: Enero 31/2013

     ******************************************/
    FUNCTION FNUGETORDBYPACKCAUSCLASS (INUPACKAGEID      IN NUMBER,
                                       INUACTIVITYID     IN NUMBER,
                                       NUCAUSALCLASSID   IN NUMBER)
        RETURN NUMBER
    IS
        CURSOR CUORDBYPACKCAUSCLASS (INUPACKAGEID      IN NUMBER,
                                     INUACTIVITYID     IN NUMBER,
                                     NUCAUSALCLASSID   IN NUMBER)
        IS
            SELECT /*+ index(or_order_activity IDX_OR_ORDER_ACTIVITY_06)
                        index(or_order pk_order)
                        index(or_order_status pk_or_order_status) */
                   or_order_activity.order_id
              FROM or_order_activity,
                   OR_ORDER,
                   OR_ORDER_STATUS,
                   GE_CAUSAL,
                   ge_class_causal
             /*+ OR_bcOrder.fnuGetOrdbyPackAct */
             WHERE     OR_ORDER_ACTIVITY.ORDER_ID = OR_ORDER.ORDER_ID
                   AND OR_ORDER.ORDER_STATUS_ID =
                       OR_ORDER_STATUS.ORDER_STATUS_ID
                   AND ge_causal.class_causal_id =
                       ge_class_causal.class_causal_id
                   AND or_order.causal_id = ge_causal.causal_id
                   AND OR_ORDER_ACTIVITY.ACTIVITY_ID = INUACTIVITYID
                   AND OR_ORDER_ACTIVITY.PACKAGE_ID = INUPACKAGEID
                   AND GE_class_causal.CLASS_CAUSAL_ID = NUCAUSALCLASSID
                   AND OR_ORDER_STATUS.IS_FINAL_STATUS = 'Y';

        nuorder_id   or_order.order_id%TYPE;
    BEGIN
        OPEN CUORDBYPACKCAUSCLASS (INUPACKAGEID,
                                   INUACTIVITYID,
                                   NUCAUSALCLASSID);

        FETCH CUORDBYPACKCAUSCLASS INTO nuorder_id;

        IF CUORDBYPACKCAUSCLASS%NOTFOUND
        THEN
            nuorder_id := -1;
        END IF;

        CLOSE CUORDBYPACKCAUSCLASS;

        RETURN nuorder_id;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            ---no existen datos
            RETURN '-1';
        WHEN OTHERS
        THEN
            ---se esta generando un error al ejecutar la funcion Metodo: fnuGetFechaReision
            RETURN '-2';
    END FNUGETORDBYPACKCAUSCLASS;

    /*****************************************
    Descripcion:   Retorna la fecha de maxima de ESTIMATED_END_DATE

     por solicitud del funcional se modifica la funcion tome el campo REGISTER_DATE

    Autor: Jose C Filigrana Paz
    Fecha: Enero 31/2013

     ******************************************/
    FUNCTION fnuGetFechaReision (NUPRODUCT_ID Pr_product.PRODUCT_ID%TYPE)
        RETURN DATE
    IS
        CURSOR CurFechCert (NPRODUCT_ID Pr_product.PRODUCT_ID%TYPE)
        IS
            SELECT MAX (REGISTER_DATE)
              FROM PR_CERTIFICATE
             WHERE PRODUCT_ID = NPRODUCT_ID;

        CURSOR CurServSusc (NPRODUCT_ID Pr_product.PRODUCT_ID%TYPE)
        IS
            SELECT sesufein
              FROM servsusc
             WHERE SESUSERV = 7014 AND SESUNUSE = NPRODUCT_ID;

        DtREVIEW_DATE   PR_CERTIFICATE.REVIEW_DATE%TYPE;
    BEGIN
        DBMS_OUTPUT.put_line (' inicia ' || NUPRODUCT_ID);

        OPEN CurFechCert (NUPRODUCT_ID);

        FETCH CurFechCert INTO DtREVIEW_DATE;

        IF DtREVIEW_DATE IS NULL
        THEN
            ---si no existe una fecha de certificacion para los motivos de periodicas se toma la fecha de instalacion del producto
            OPEN CurServSusc (NUPRODUCT_ID);

            FETCH CurServSusc INTO DtREVIEW_DATE;

            IF DtREVIEW_DATE IS NULL
            THEN
                DtREVIEW_DATE := NULL;
            END IF;

            CLOSE CurServSusc;
        END IF;

        CLOSE CurFechCert;

        RETURN DtREVIEW_DATE;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN NULL;
    END fnuGetFechaReision;

    /*****************************************
     Metodo: OrdIspecOyM
     Descripcion: Procedimiento para generar y asignar OT de inspeccion

     Parametros: Numero de la OT

     Autor: Jose C.Filigrana
     Fecha: Febrero 20 de 2013

    ********************/
    PROCEDURE OrdIspecOyM (NuOrder_Ir or_order.ORDER_ID%TYPE)
    IS
        ---Cursor para recorrer los item de la OT
        CURSOR CurItemOrd (NuORDER_ID or_order_items.ORDER_ID%TYPE)
        IS
            SELECT a.ITEMS_ID, a.DESCRIPTION
              FROM ge_items a, or_order_items b
             WHERE     a.ITEMS_ID = b.ITEMS_ID
                   AND ORDER_ID = NuORDER_ID
                   AND b.LEGAL_ITEM_AMOUNT > 0;

        ---Cursor para obtener el comentario y la direccion
        CURSOR CurOrdenActi (NuORDER_ID or_order.ORDER_ID%TYPE)
        IS
            SELECT ADDRESS_ID, COMMENT_
              FROM or_order_activity
             WHERE ORDER_ID = NuORDER_ID;

        BsObserv              VARCHAR2 (2000);
        sBcOMENTARIO          VARCHAR2 (2000);
        NuCodDir              NUMBER;
        inuReferenceValue     NUMBER (20);
        ionuOrderId           NUMBER (15);
        onuErrorCode          NUMBER (18);
        osbErrorMessage       VARCHAR2 (2000);
        idtArrangedHour       DATE;
        idtChangeDate         DATE;
        --onuErrorCode     NUMBER(18);
        ---osbErrorMessage  VARCHAR2(2000);
        ErrOT                 EXCEPTION;
        NuOPERATING_UNIT_ID   or_operating_unit.OPERATING_UNIT_ID%TYPE;
    BEGIN
        ---Obtiene el codigo de la unidad de trabajo para asignar la OT
        NuOPERATING_UNIT_ID :=
            TO_NUMBER (LDC_BOUTILITIES.fsbgetvalorcampotabla (
                           'ld_parameter',
                           'PARAMETER_ID',
                           'NUMERIC_VALUE',
                           'UT_INSPECCIONOYM'));
        BsObserv := '<ITEM DE LA ORDEN>: ';

        FOR CurItemOrds IN CurItemOrd (NuOrder_Ir)
        LOOP
            --- dbms_output.put_line(CurItemOrds.ITEMS_ID||'--'||CurItemOrds.DESCRIPTION);
            BsObserv :=
                   BsObserv
                || '**'
                || CurItemOrds.ITEMS_ID
                || '--'
                || CurItemOrds.DESCRIPTION;

            IF LENGTH (BsObserv) > 2000
            THEN
                BsObserv := SUBSTR (BsObserv, 1, 2000);
                EXIT;
            END IF;
        END LOOP;

        -- dbms_output.put_line(BsObserv);
        OPEN CurOrdenActi (NuOrder_Ir);

        FETCH CurOrdenActi INTO NuCodDir, sBcOMENTARIO;

        CLOSE CurOrdenActi;

        DBMS_OUTPUT.put_line ('sBcOMENTARIO' || sBcOMENTARIO);

        IF LENGTH (BsObserv) + LENGTH (sBcOMENTARIO) > 2000
        THEN
            BsObserv := BsObserv || ' <OBSERVACIONES>: ' || sBcOMENTARIO;
            BsObserv := SUBSTR (BsObserv, 1, 2000);
        ELSE
            BsObserv := BsObserv || ' <OBSERVACIONES>: ' || sBcOMENTARIO;
        END IF;

        --dbms_output.put_line('BsObserv'||BsObserv);
        ---Creacion de OT inspeccion
        ---dbms_output.put_line('Creacion de OT inspeccion ');
        OS_CREATEORDERACTIVITIES (4000975,
                                  NuCodDir,
                                  SYSDATE,
                                  BsObserv,
                                  inuReferenceValue,
                                  ionuOrderId,
                                  onuErrorCode,
                                  osbErrorMessage);

        IF (onuErrorCode IS NULL OR onuErrorCode <> 0)
        THEN
            RAISE ErrOT;
        END IF;

        ---asigna la orden de trabajo
        ---dbms_output.put_line('asigna la orden de trabajo ');
        OS_ASSIGN_ORDER (ionuOrderId,
                         NuOPERATING_UNIT_ID,
                         idtArrangedHour,
                         idtChangeDate,
                         onuErrorCode,
                         osbErrorMessage);

        IF (onuErrorCode IS NULL OR onuErrorCode <> 0)
        THEN
            RAISE ErrOT;
        END IF;

        ---Para relacionar dos OT
        ---se coloca como parametro el numero de OT que se pasa como parametro al procedimiento NuOTOrigen
        --dbms_output.put_line('relacionar dos OT   ');
        OS_RELATED_ORDER (ionuOrderId,
                          NuOrder_Ir,
                          onuErrorCode,
                          osbErrorMessage);

        IF (onuErrorCode IS NULL OR onuErrorCode <> 0)
        THEN
            RAISE ErrOT;
        END IF;
    EXCEPTION
        WHEN ErrOT
        THEN
            DBMS_OUTPUT.put_line (
                'Error ' || onuErrorCode || ' Mensaje: ' || osbErrorMessage);
        WHEN OTHERS
        THEN
            DBMS_OUTPUT.PUT_LINE ('Error ' || SQLERRM);
    END ORDISPECOYM;

    /*****************************************
    Metodo: FSBTRABAJOSNOLEGALIZAORCAO
    Descripcion:   Retorna la cadena que se usara en la condicion que restringira
                   que los tipos de trabajo creados en el parametro TIPO_TRABAJO_NO_LEG_ORCAO
                   sean legalizados por ORCAO

    Autor: Luz Andrea Angel/OLSoftware
    Fecha: Febrero 19/2013
     ******************************************/
    FUNCTION FSBTRABAJOSNOLEGALIZAORCAO (TASK_TYPE VARCHAR2)
        RETURN VARCHAR2
    IS
        SBTIPOSTRABAJO   VARCHAR2 (1000);
        SBCADENA         VARCHAR2 (4000);

        --obtiene los tipos de trabajo definidos en el parametro
        CURSOR CUTIPOSTRABAJO IS
            SELECT VALUE_CHAIN
              FROM LD_PARAMETER
             WHERE PARAMETER_ID = 'TIPO_TRABAJO_NO_LEG_ORCAO';

        --obtiene la descripcion por cada uno de los tipos de trabajo
        CURSOR CUDESCTIPOTRABAJO (SBTRABAJOS VARCHAR2, TASK_TYPE VARCHAR2)
        IS
            SELECT TO_CHAR (TASK_TYPE_ID || ' - ' || DESCRIPTION)
              FROM OR_TASK_TYPE
             WHERE     TO_CHAR (TASK_TYPE_ID) IN
                           (SELECT TO_NUMBER (COLUMN_VALUE)
                              FROM TABLE (
                                       LDC_BOUTILITIES.SPLITSTRINGS (
                                           SBTRABAJOS,
                                           ',')))
                   AND TO_CHAR (TASK_TYPE_ID || ' - ' || DESCRIPTION) =
                       TASK_TYPE;
    BEGIN
        OPEN CUTIPOSTRABAJO;

        FETCH CUTIPOSTRABAJO INTO SBTIPOSTRABAJO;

        IF CUTIPOSTRABAJO%NOTFOUND
        THEN
            CLOSE CUTIPOSTRABAJO;
        END IF;

        CLOSE CUTIPOSTRABAJO;

        --valida si obtuvo informacion del parametro
        IF (SBTIPOSTRABAJO IS NOT NULL)
        THEN
            OPEN CUDESCTIPOTRABAJO (SBTIPOSTRABAJO, TASK_TYPE);

            FETCH CUDESCTIPOTRABAJO INTO SBCADENA;

            CLOSE CUDESCTIPOTRABAJO;

            IF (SBCADENA IS NOT NULL)
            THEN
                RETURN 1;
            ELSE
                RETURN -1;
            END IF;
        END IF;
    END FSBTRABAJOSNOLEGALIZAORCAO;

    PROCEDURE AsigOT (
        NuOrder_ID            or_order.ORDER_ID%TYPE,
        NuOPERATING_UNIT_ID   or_operating_unit.OPERATING_UNIT_ID%TYPE)
    IS
        BsObserv            VARCHAR2 (2000);
        sBcOMENTARIO        VARCHAR2 (2000);
        NuCodDir            NUMBER;
        inuReferenceValue   NUMBER (20);
        ionuOrderId         NUMBER (15);
        onuErrorCode        NUMBER (18);
        osbErrorMessage     VARCHAR2 (2000);
        idtArrangedHour     DATE;
        idtChangeDate       DATE;
        --onuErrorCode     NUMBER(18);
        ---osbErrorMessage  VARCHAR2(2000);
        ErrOT               EXCEPTION;
    /*
      la cuadrilla que va a realizar los trabajos
     */
    BEGIN
        ---asigna la orden de trabajo
        OS_ASSIGN_ORDER (NuOrder_ID,
                         NuOPERATING_UNIT_ID,
                         idtArrangedHour,
                         idtChangeDate,
                         onuErrorCode,
                         osbErrorMessage);

        IF (onuErrorCode IS NULL OR onuErrorCode <> 0)
        THEN
            RAISE ErrOT;
        END IF;
    ---Para relacionar dos OT
    EXCEPTION
        WHEN ErrOT
        THEN
            DBMS_OUTPUT.put_line (
                'Error ' || onuErrorCode || ' Mensaje: ' || osbErrorMessage);
        WHEN OTHERS
        THEN
            DBMS_OUTPUT.PUT_LINE ('Error ' || SQLERRM);
    END AsigOT;

    /*****************************************
    Metodo: FNUVALRANGOTIEMPLEGOT
    Autor: Jose Filigrana
    Fecha: Febrero 25 de 2013
    Descripcion:   Retorna un 0 cuando la fecha de legalizacion esta dentro del disponible,
                              1 cuando la fecha de legalizacion a sobre los dias de legalizacion
                  -1 cuando se ha generao un error al ejecutar la funcion

     ******************************************/
    FUNCTION FNUVALRANGOTIEMPLEGOT (
        DTASSIGNED_DATE       OR_ORDER.ASSIGNED_DATE%TYPE,
        DTLEGALIZATION_DATE   OR_ORDER.LEGALIZATION_DATE%TYPE,
        SBPARAMETER_ID        LD_PARAMETER.PARAMETER_ID%TYPE)
        RETURN NUMBER
    IS
        CURSOR CurParametro (SBxPARAMETER_ID LD_PARAMETER.PARAMETER_ID%TYPE)
        IS
            SELECT NUMERIC_VALUE
              FROM ld_parameter
             WHERE PARAMETER_ID = SBxPARAMETER_ID AND ROWNUM = 1;

        NuNUMERIC_VALUE   ld_parameter.NUMERIC_VALUE%TYPE;
    BEGIN
        OPEN CurParametro (SBPARAMETER_ID);

        FETCH CurParametro INTO NuNUMERIC_VALUE;

        CLOSE CurParametro;

        DBMS_OUTPUT.put_line ('NuNUMERIC_VALUE ' || NuNUMERIC_VALUE);

        IF NuNUMERIC_VALUE IS NOT NULL
        THEN
            IF TRUNC (DTLEGALIZATION_DATE) - TRUNC (DTASSIGNED_DATE) >
               NuNUMERIC_VALUE
            THEN
                ---Devuleve 0 cuando la diferencia en dias entre las fechas de asignacion y legalizacion
                --- es mayor al parametro
                RETURN 0;
            ELSE
                ---Devuleve 0 cuando la diferencia en dias entre las fechas de asignacion y legalizacion
                --- es mayor al parametro
                RETURN 1;
            END IF;
        ELSE
            RETURN -1;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            DBMS_OUTPUT.put_line ('Error ' || SQLERRM);
            ---Retorna -1 cuando exista un error al ejecutar la funcion
            RETURN -1;
    END FNUVALRANGOTIEMPLEGOT;

    /*****************************************
    Metodo: PROCVALRANGOTIEMPLEGOT
    Descripcion:  Procedmiento que permite obtener:
    Numero de dias maximos para la legalizacion
    Porcentaje de cobro de multa
    Valor de la multa
    Cantidad de dias que ha sobre el contratista en la legalizacion teniendo en cuenta los dias habiles

    Cuando ocurra algun error las variables de salida se colocan con -1

    Autor: Jose Filigrana
    Fecha: Febrero 27/2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    07/10/2013       Sayra Ocoro      Se modifica CurTPLOCALTRA para que tenga en cuenta
                                      las cofiguraciones genericas
     ******************************************/
    PROCEDURE PROCVALRANGOTIEMPLEGOT (
        DTASSIGNED_DATE       IN     OR_ORDER.ASSIGNED_DATE%TYPE,
        DTLEGALIZATION_DATE   IN     OR_ORDER.LEGALIZATION_DATE%TYPE,
        NuDEPARTAMENTO        IN     LDC_TMLOCALTTRA.DEPARTAMENTO%TYPE,
        NuLOCALIDAD           IN     LDC_TMLOCALTTRA.LOCALIDAD%TYPE,
        NuTIPOTRABAJO         IN     LDC_TMLOCALTTRA.TIPOTRABAJO%TYPE,
        NuCAUSAL              IN     LDC_TMLOCALTTRA.CAUSAL%TYPE,
        NuPROVEEDOR           IN     LDC_TMLOCALTTRA.PROVEEDOR%TYPE,
        NuNUMERODIAS             OUT LDC_TMLOCALTTRA.TIEMPO%TYPE,
        NuPORCENTAJE             OUT LDC_TMLOCALTTRA.PORCENTAJE%TYPE,
        NuVALOR                  OUT LDC_TMLOCALTTRA.VALOR%TYPE,
        NuDias                   OUT NUMBER)
    IS
        CURSOR CurTPLOCALTRA (
            NuDEPARTAMENTO   LDC_TMLOCALTTRA.DEPARTAMENTO%TYPE,
            NuLOCALIDAD      LDC_TMLOCALTTRA.LOCALIDAD%TYPE,
            NuTIPOTRABAJO    LDC_TMLOCALTTRA.TIPOTRABAJO%TYPE,
            NuCAUSAL         LDC_TMLOCALTTRA.CAUSAL%TYPE,
            NuPROVEEDOR      LDC_TMLOCALTTRA.PROVEEDOR%TYPE)
        IS
            SELECT TIEMPO, PORCENTAJE, VALOR
              FROM LDC_TMLOCALTTRA
             WHERE     NVL (DEPARTAMENTO, -1) =
                       DECODE (NuDEPARTAMENTO, NULL, -1, NuDEPARTAMENTO)
                   AND NVL (LOCALIDAD, -1) =
                       DECODE (NuLOCALIDAD, NULL, -1, NuLOCALIDAD)
                   AND TIPOTRABAJO = NuTIPOTRABAJO
                   -- and CAUSAL = decode(NuCAUSAL, -1, CAUSAL, NuCAUSAL)
                   -- and PROVEEDOR = decode(NuPROVEEDOR, -1, PROVEEDOR, NuPROVEEDOR);
                   AND NVL (CAUSAL, -1) =
                       DECODE (NuCAUSAL, NULL, -1, NuCAUSAL)
                   AND NVL (PROVEEDOR, -1) =
                       DECODE (NuPROVEEDOR, NULL, -1, NuPROVEEDOR);

        NumDia   NUMBER (3);
    BEGIN
        OPEN CurTPLOCALTRA (NuDEPARTAMENTO,
                            NuLOCALIDAD,
                            NuTIPOTRABAJO,
                            NuCAUSAL,
                            NuPROVEEDOR);

        FETCH CurTPLOCALTRA INTO NuNUMERODIAS, NuPORCENTAJE, NuVALOR;

        CLOSE CurTPLOCALTRA;

        NumDia := 0;
        NuDias := 0;

        IF NuNUMERODIAS IS NOT NULL
        THEN
            NumDia :=
                LDC_BOUTILITIES.FnuDiasHabiles (DTASSIGNED_DATE,
                                                DTLEGALIZATION_DATE);

            IF NumDia > NuNUMERODIAS
            THEN
                NuDias := NumDia - NuNUMERODIAS;
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            NuDias := -1;
            NuNUMERODIAS := -1;
            NuPORCENTAJE := -1;
            NuVALOR := -1;
    END PROCVALRANGOTIEMPLEGOT;

    /*****************************************
    Metodo: PROCDIASATENCIONORDEN
    Descripcion:  Procedmiento que permite obtener:
                  Numero de dias maximos para la Ejecucion o
                  legalizacion de la orden y el valor con el que multa.

    Autor: Jorge Valiente
    Fecha: 3 de Mayo de 2013

    Parametro               Descripcion
    ==================      ===================================
    IDTASSIGNED_DATE        fecha de asigancion de la orden
    IDTEJECLEGAL_DATE       fecha de ejecucion o legalizacion de la orden
    INuDEPARTAMENTO         codigo del departamento
    INuLOCALIDAD            codigo de la localidad
    INuTIPOTRABAJO          codigo tipo de trabajo
    INuACTIVIDAD            codigo de actividad
    INuCAUSAL               codigo de causal
    INuESTADO               E[Ejecucion] L[Legalizacion] o NULL
    INuPROVEEDOR            codigo proveedor / unidad operativa
    ONuNUMERODIAS           maximo de dias para ejecutar o legalizar la orden
    ONuPORCENTAJE           porcetaje de multa
    ONuVALOR                valor de multa
    ONuDias                 cantidad ed dias para obtener valor de multa

     Fecha             Autor             Modificacion
    =========       =========           ====================
   09/09/2020 E.SANTIAGO (HORBATH)   ca294: Se agrega el campo DIA_SIGUIENTE para la validacion del apalica dia siguiente
   ******************************************/
    PROCEDURE PROCDIASATENCIONORDEN (
        IDTASSIGNED_DATE    IN     OR_ORDER.ASSIGNED_DATE%TYPE,
        IDTEJECLEGAL_DATE   IN     OR_ORDER.LEGALIZATION_DATE%TYPE,
        INuDEPARTAMENTO     IN     LDC_TMLOCALTTRA.DEPARTAMENTO%TYPE,
        INuLOCALIDAD        IN     LDC_TMLOCALTTRA.LOCALIDAD%TYPE,
        INuTIPOTRABAJO      IN     LDC_TMLOCALTTRA.TIPOTRABAJO%TYPE,
        INuACTIVIDAD        IN     LDC_TMLOCALTTRA.ACTIVIDAD%TYPE,
        INuCAUSAL           IN     LDC_TMLOCALTTRA.CAUSAL%TYPE,
        ISbESTADO           IN     LDC_TMLOCALTTRA.ESTADO%TYPE,
        INuPROVEEDOR        IN     LDC_TMLOCALTTRA.PROVEEDOR%TYPE,
        ONuTIEMPO              OUT LDC_TMLOCALTTRA.TIEMPO%TYPE,
        ONuPORCENTAJE          OUT LDC_TMLOCALTTRA.PORCENTAJE%TYPE,
        ONuVALOR               OUT LDC_TMLOCALTTRA.VALOR%TYPE,
        ONuDias                OUT LDC_TMLOCALTTRA.TIEMPO%TYPE)
    IS
        ---variables para cupon y peticupo
        TYPE CUR_TYP IS REF CURSOR;

        C_CURSOR     CUR_TYP;
        C_CURSOR1    CUR_TYP;
        v_query0     VARCHAR2 (4000) := NULL;
        v_query1     VARCHAR2 (1000) := NULL;
        v_query2     VARCHAR2 (1000) := NULL;
        SBDEPALOCA   VARCHAR2 (50) := NULL;
        ----------------------------------------
        NumDia       NUMBER (3);
        NUAND        NUMBER := 0;
        NuDia_sig    LDC_TMLOCALTTRA.DIA_SIGUIENTE%TYPE;          -- caso: 494
        dtAsigdate   OR_ORDER.ASSIGNED_DATE%TYPE;                 -- caso: 494
    BEGIN
        v_query1 := 'SELECT TIEMPO, PORCENTAJE, VALOR, DIA_SIGUIENTE'; -- caso:494
        v_query1 :=
               v_query1
            || ' FROM LDC_TMLOCALTTRA WHERE PAIS = '
            || DALD_PARAMETER.fnuGetNumeric_Value ('CODIGO_PAIS')
            || ' AND tipotrabajo = '
            || INuTIPOTRABAJO;
        v_query0 := v_query1;

        --VALDAR SI LA CONFIGURACION DEL
        --DEPARTAMENTO Y LOCALIDAD ESTA DEFINIDA
        IF INuDEPARTAMENTO IS NOT NULL
        THEN
            v_query2 :=
                   v_query0
                || v_query2
                || ' AND departamento = '
                || INuDEPARTAMENTO;

            OPEN C_CURSOR FOR v_query2;

            FETCH C_CURSOR
                INTO ONuTIEMPO,
                     ONuPORCENTAJE,
                     ONuVALOR,
                     NuDia_sig;                                   -- caso: 494

            IF C_CURSOR%FOUND
            THEN
                v_query0 :=
                    v_query0 || ' AND departamento = ' || INuDEPARTAMENTO;

                ----VALIDAR LOCALIDAD
                --SI NO EXSITE DEPARATAMENTO EN LA
                --CONFIGURACION NO SE VALIDA LOCALIDAD AUNQUE
                --ESTA EXISTA EN LA CONFIGURACION.
                IF INuLOCALIDAD IS NOT NULL
                THEN
                    v_query2 :=
                        v_query2 || ' AND localidad = ' || INuLOCALIDAD;

                    OPEN C_CURSOR1 FOR v_query2;

                    FETCH C_CURSOR1
                        INTO ONuTIEMPO,
                             ONuPORCENTAJE,
                             ONuVALOR,
                             NuDia_sig;                           -- caso: 494

                    IF C_CURSOR1%FOUND
                    THEN
                        v_query0 :=
                            v_query0 || ' AND localidad = ' || INuLOCALIDAD;
                    END IF;

                    CLOSE C_CURSOR1;
                ----FIN VALIDAR LOCALIDAD
                ELSE
                    v_query0 := v_query0 || ' AND localidad IS NULL';
                END IF;

                CLOSE C_CURSOR;
            ELSE
                v_query0 :=
                       v_query0
                    || ' AND departamento IS NULL  AND localidad IS NULL';
            END IF;
        ELSE
            v_query0 :=
                   v_query0
                || ' AND departamento IS NULL  AND localidad IS NULL';
        END IF;

        --FIN VALIDACION DEPARTAMENTO LOCALIDAD
        --VALDAR SI HAY CONFIGURACION CON ACTIVIDAD
        IF INuACTIVIDAD IS NOT NULL
        THEN
            v_query2 := v_query0 || ' AND actividad = ' || INuACTIVIDAD;

            OPEN C_CURSOR FOR v_query2;

            FETCH C_CURSOR
                INTO ONuTIEMPO,
                     ONuPORCENTAJE,
                     ONuVALOR,
                     NuDia_sig;                                   -- caso: 494

            IF C_CURSOR%FOUND
            THEN
                v_query0 := v_query0 || ' AND actividad = ' || INuACTIVIDAD;
            ELSE
                v_query0 := v_query0 || ' AND actividad IS NULL';
            END IF;

            CLOSE C_CURSOR;
        ELSE
            v_query0 := v_query0 || ' AND actividad IS NULL';
        END IF;

        --FIN VALDAR SI HAY CONFIGURACION CON ACTIVIDAD
        --VALDAR SI HAY CONFIGURACION CON CAUSAL
        IF INuCAUSAL IS NOT NULL
        THEN
            v_query2 := v_query0 || ' AND causal = ' || INuCAUSAL;

            OPEN C_CURSOR FOR v_query2;

            FETCH C_CURSOR
                INTO ONuTIEMPO,
                     ONuPORCENTAJE,
                     ONuVALOR,
                     NuDia_sig;                                   -- caso: 494

            IF C_CURSOR%FOUND
            THEN
                v_query0 := v_query0 || ' AND causal = ' || INuCAUSAL;
            ELSE
                v_query0 := v_query0 || ' AND causal IS NULL';
            END IF;

            CLOSE C_CURSOR;
        ELSE
            v_query0 := v_query0 || ' AND causal IS NULL';
        END IF;

        --VALDAR SI HAY CONFIGURACION CON CAUSAL
        --VALDAR SI HAY CONFIGURACION CON ESTADO EJECUCION O LEGALIZACION
        IF ISbESTADO IS NOT NULL AND NUAND = 0
        THEN
            v_query2 := v_query0 || ' AND estado = ''' || ISbESTADO || '''';

            OPEN C_CURSOR FOR v_query2;

            FETCH C_CURSOR
                INTO ONuTIEMPO,
                     ONuPORCENTAJE,
                     ONuVALOR,
                     NuDia_sig;                                   -- caso: 494

            IF C_CURSOR%FOUND
            THEN
                v_query0 :=
                    v_query0 || ' AND estado = ''' || ISbESTADO || '''';
            ELSE
                v_query0 := v_query0 || ' AND estado IS NULL';
            END IF;

            CLOSE C_CURSOR;
        ELSE
            v_query0 := v_query0 || ' AND estado IS NULL';
        END IF;

        --FIN VALDAR SI HAY CONFIGURACION CON ESTADO EJECUCION O LEGALIZACION
        --VALDAR SI HAY CONFIGURACION CON PROVEEDOR
        IF INuPROVEEDOR IS NOT NULL AND NUAND = 0
        THEN
            v_query2 := v_query0 || ' AND PROVEEDOR = ' || INuPROVEEDOR;

            OPEN C_CURSOR FOR v_query2;

            FETCH C_CURSOR
                INTO ONuTIEMPO,
                     ONuPORCENTAJE,
                     ONuVALOR,
                     NuDia_sig;                                   -- caso: 494

            IF C_CURSOR%FOUND
            THEN
                v_query0 := v_query0 || ' AND PROVEEDOR = ' || INuPROVEEDOR;
            ELSE
                v_query0 := v_query0 || ' AND PROVEEDOR IS NULL';
            END IF;

            CLOSE C_CURSOR;
        ELSE
            v_query0 := v_query0 || ' AND PROVEEDOR IS NULL';
        END IF;

        --FIN VALDAR SI HAY CONFIGURACION CON PROVEEDOR
        OPEN C_CURSOR FOR v_query0;

        FETCH C_CURSOR
            INTO ONuTIEMPO,
                 ONuPORCENTAJE,
                 ONuVALOR,
                 NuDia_sig;                                       -- caso: 494

        IF C_CURSOR%NOTFOUND
        THEN
            ONuTIEMPO := 0;
            ONuPORCENTAJE := 0;
            ONuVALOR := 0;

            CLOSE C_CURSOR;
        END IF;

        CLOSE C_CURSOR;

        NumDia := 0;
        ONuDias := 0;

        IF ONuTIEMPO IS NOT NULL
        THEN
            -- Inicio caso:494
            IF NuDia_sig = 'S'
            THEN
                NumDia :=
                    pkholidaymgr.FNUGETNUMOFDAYNONHOLIDAY (IDTASSIGNED_DATE,
                                                           IDTEJECLEGAL_DATE);
            ELSE
                NumDia :=
                    LDC_BOUTILITIES.FnuDiasHabiles (IDTASSIGNED_DATE,
                                                    IDTEJECLEGAL_DATE);
            END IF;

            -- Fin caso:494

            IF NumDia > ONuTIEMPO
            THEN
                ONuDias := NumDia - ONuTIEMPO;
            END IF;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ONuDias := 0;
            ONuTIEMPO := 0;
            ONuPORCENTAJE := 0;
            ONuVALOR := 0;
    END PROCDIASATENCIONORDEN;

    /*****************************************
    Metodo: FNUGETIDLOCALIDAD
    Descripcion:  Retorna el codigo de la localidad
                  El parametro que recibe la funcion es codigo de la orden

    Autor: Luz Andrea Angel/OLSoftware
    Fecha: Julio 10/2013
    Autor     Fecha        Observación
   EDMLAR   02-05-2022    CA-OSF-169
                          Para GDCA se modifica la fuente de buscar la localidad de la orden para calcular
                          el ReteIca, el nuevo orden de encontrar esta es el siguiene;
                          1.- Se busca la localidad de la direccion asociada en el campo ADDRESS_ID de la tabla
                              OR_ORDER_ACTIVITY.
                          2.- Si el campo ADDRESS_ID anterior es NULL, se busca la localidad de la direccion de
                              la Orden tabla OR_ORDER campo EXTERNAL_ADDRESS_ID.
     ******************************************/
    FUNCTION FNUGETIDLOCALIDAD (nuOrderId IN NUMBER)
        RETURN NUMBER
    IS
        CURSOR CuIdLocalidadProducto IS
            SELECT ge.geograp_location_id
              FROM or_order_activity   oa,
                   pr_product          p,
                   ab_address          ab,
                   ge_geogra_location  ge
             WHERE     oa.product_id = p.product_id
                   AND p.address_id = ab.address_id
                   AND ge.geograp_location_id = ab.geograp_location_id
                   AND ge.geog_loca_area_type = 3
                   AND oa.order_id = nuOrderId;

        CURSOR cuIdLocalidadOrden IS
            SELECT ge.geograp_location_id
              FROM or_order_activity oa, ab_address ab, ge_geogra_location ge
             WHERE     oa.address_id = ab.address_id
                   AND ge.geograp_location_id = ab.geograp_location_id
                   AND ge.geog_loca_area_type = 3
                   AND oa.order_id = nuOrderId;

        nuIdLocalidad   NUMBER;
        nuAddressId     OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE;

        --<<
        -- CA-OSF-169
        --
        -- Localidad del sector Operativo de la direccion de la Orden
        CURSOR Cu_Order_Loca_Addres IS
            SELECT DECODE (
                       OR_ORDER_ACTIVITY.ADDRESS_ID,
                       NULL, (SELECT AB_ADDRESS.GEOGRAP_LOCATION_ID
                                FROM AB_ADDRESS
                               WHERE AB_ADDRESS.ADDRESS_ID =
                                     OR_ORDER.EXTERNAL_ADDRESS_ID),
                       (SELECT AB_ADDRESS.GEOGRAP_LOCATION_ID
                          FROM AB_ADDRESS
                         WHERE AB_ADDRESS.ADDRESS_ID =
                               OR_ORDER_ACTIVITY.ADDRESS_ID))    GEOGRAP_LOCATION_ID
              FROM OR_ORDER, OR_ORDER_ACTIVITY
             WHERE     OR_ORDER.ORDER_ID = nuOrderId --155587560 ID ORDEN DE TRABAJO
                   AND OR_ORDER_ACTIVITY.ORDER_ID = OR_ORDER.ORDER_ID
                   AND ROWNUM = 1;

    BEGIN
    
        OPEN Cu_Order_Loca_Addres;

        FETCH Cu_Order_Loca_Addres INTO nuidlocalidad;

        CLOSE Cu_Order_Loca_Addres;

        IF nuidlocalidad IS NULL
        THEN
            nuidlocalidad := -1;
        END IF;

        RETURN nuIdLocalidad;
        
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            ---no existen datos
            RETURN -1;
        WHEN OTHERS
        THEN
            ---se esta generando un error al ejecutar la funcion
            RETURN -2;
    END FnuGetIdLocalidad;

    /*****************************************
    Metodo: FsbGetIdDept
    Descripcion:  Retorna el codigo del departamento
                  El parametro que recibe la funcion es codigo del sector operativo (NuOperatingSctor_Id)

    Autor: Luz Andrea Angel/OLSoftware
    Fecha: Febrero 27/2013

     ******************************************/
    FUNCTION FsbGetIdDept (NuOperatingSctor_Id IN NUMBER)
        RETURN NUMBER
    IS
        CURSOR CuIdDept IS
            SELECT LDC_BOUTILITIES.fsbGetValorCampoTabla (
                       'GE_GEOGRA_LOCATION',
                       'GEOGRAP_LOCATION_ID',
                       'GEO_LOCA_FATHER_ID',
                       LDC_BOUTILITIES.fsbGetValorCampoTabla (
                           'GE_GEOGRA_LOCATION',
                           'GEOGRAP_LOCATION_ID',
                           'GEO_LOCA_FATHER_ID',
                           d.GEOGRAP_LOCATION_ID))
              FROM ge_geogra_location d
             WHERE d.OPERATING_SECTOR_ID = NuOperatingSctor_Id AND ROWNUM = 1;

        nuIdDept   NUMBER;
    BEGIN
        OPEN CUIDDEPT;

        FETCH CuIdDept INTO nuIdDept;

        IF CuIdDept%NOTFOUND
        THEN
            nuIdDept := -1;
        END IF;

        CLOSE CuIdDept;

        RETURN nuIdDept;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            ---no existen datos
            RETURN '-1';
        WHEN OTHERS
        THEN
            ---se esta generando un error al ejecutar la funcion
            RETURN '-2';
    END FsbGetIdDept;

    PROCEDURE PROCPNOOTLEGFALLO (
        ORDER_ID            OR_ORDER.ORDER_ID%TYPE,
        ORDER_STATUS_ID     OR_ORDER.ORDER_STATUS_ID%TYPE,
        OPERATING_UNIT_ID   OR_ORDER.OPERATING_UNIT_ID%TYPE)
    IS
        NuUndPno          NUMBER;
        onuErrorCode      NUMBER (18);
        osbErrorMessage   VARCHAR2 (2000);
    BEGIN
        NuUndPno := OPERATING_UNIT_ID;

        IF ORDER_STATUS_ID = 0
        THEN
            NuUndPno :=
                LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA ('LD_PARAMETER',
                                                       'PARAMETER_ID',
                                                       'NUMERIC_VALUE',
                                                       'UNIDAD_PNO_SERV_ING');
            os_assign_order (ORDER_ID,
                             NuUndPno,
                             SYSDATE,
                             SYSDATE,
                             onuErrorCode,
                             osbErrorMessage);
            pkg_Traza.Trace (
                   'Mensaje Asigna Cuadrilla: '
                || onuErrorCode
                || ' ** '
                || osbErrorMessage,
                8);
        END IF;

        OR_BOEXTERNALLEGALIZEACTIVITY.LEGALIZEWITHFAILURE (
            ORDER_ID,
            NuUndPno,
            53,
            'No se inicio Acto administrativo');
        pkg_Traza.Trace (
            'Legaliza OT: ' || ORDER_ID || ' ** ' || OPERATING_UNIT_ID,
            8);
    EXCEPTION
        WHEN OTHERS
        THEN
            Errors.getError (onuErrorCode, osbErrorMessage);
            pkg_Traza.Trace (
                'Error legalizando OT: ' || ORDER_ID || ' ** ' || SQLERRM,
                8);
    END PROCPNOOTLEGFALLO;

    /*****************************************
    Metodo: fsbValDatoAdicOtCertif
    Descripcion:  Funcion que permite obtener el valor del dato adicional de la orden de certificacion
                  de instalacion de nuevas

    Autor: Luz Andrea Angel/OLSoftware
    Fecha: Marzo 22/2013

    Fecha                IDEntrega           Modificacion
    ============    ================    ============================================
    03/10/2013          luzaa            NC999:Se ajusta la logica, ya que estaba trayendo mas de un registro la consulta que obtiene la solicitud
    20-03-2014      Sayra Ocoró          Aranda 3174: Se ajusta el cursor cuordencertif.
    15-04-2014      Jorge Valiente       Aranda 3283: Modificacion de logica de servicio para obtener la orden de CORRECCION DATOS LEGALIZACION CERTIFICACION NUEVAS

    05-05-2015      Sergio Gomez         Aranda 7087: Se modifica la funcion FSBVALDATOADICOTCERTIF para que traiga la orden mas reciente y de ella
                                        se puedan sacar los atributos para inicializar la nueva orden
    24-08-2015     Diegofg               Aranda 7087  se modifica el cursor cuordencorreccioncertif de la funcion FSBVALDATOADICOTCERTIF
    11-09-2015     LDiuza               Aranda 7087: Se modifica cursor cuordencorreccioncertif para que que tome el tipo de
                                                  de trabajo de un parametro y no lo reciba como parametro.
    ******************************************/
    FUNCTION fsbValDatoAdicOtCertif (
        nuTipoTrab    or_task_type.task_type_id%TYPE,
        nuSetAttrib   ge_attributes_set.attribute_set_id%TYPE,
        nombDatAdd    ge_attributes.name_attribute%TYPE,
        nuOrderId     or_order.order_id%TYPE)
        RETURN VARCHAR2
    IS
        nuSolicitud      MO_PACKAGES.package_id%TYPE;         --Solicitud
        nuProducto       PR_PRODUCT.product_id%TYPE;           --Producto
        nuAddressId      OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE;   --Direccion

        --CURSOR PARA OBTENER SOLICITUD, PRODUCTO Y ADDRESS_ID
        CURSOR cuObtenerSolicitudProducto (
            nuOrden   OR_ORDER_ACTIVITY.order_id%TYPE)
        IS
            SELECT oa.package_id, oa.product_id, oa.address_id
              FROM OR_ORDER_ACTIVITY oa
             WHERE oa.order_id = nuOrden AND ROWNUM = 1;

        --ARANDA 3283
        --CURSOR PARA OBTENER LA ULTIMA ORDEN DE CORRECION DE CERTIFICACION
        CURSOR cuordencorreccioncertifEFG (
            nuorden      or_order.order_id%TYPE,
            nutasktype   or_task_type.task_type_id%TYPE)
        IS
            SELECT order_id
              FROM OR_ORDER OO
             WHERE OO.Legalization_Date =
                   (SELECT MAX (legalization_date)
                      FROM (  SELECT o1.order_id,
                                     o1.causal_id,
                                     o1.legalization_date
                                FROM or_order         o1,
                                     or_order_activity oa1
                               WHERE     oa1.order_id = o1.order_id
                                     AND o1.task_type_id =
                                         dald_parameter.fnuGetNumeric_Value (
                                             'COD_COR_DAT_LEG_CER_NUE',
                                             NULL)
                                     AND oa1.product_id =
                                         (SELECT oa.product_id
                                            FROM or_order         o,
                                                 or_order_activity oa
                                           WHERE     oa.order_id = o.order_id
                                                 AND oa.order_id = nuorden)
                                     AND o1.causal_id =
                                         dald_parameter.fnuGetNumeric_Value (
                                             'COD_CAU_OT_LEG',
                                             NULL)
                            ORDER BY 1 DESC) orden_certif);

        /*24-08-2015  Diegofg
        Aranda 7087  se modifica el cursor cuordencorreccioncertif
        de la funcion FSBVALDATOADICOTCERTIF  */
        CURSOR cuordencorreccioncertif (
            inuProductId   pr_product.product_id%TYPE,              --15980494
            inuPackageId   mo_packages.package_id%TYPE,
            inuAddressId   or_order_activity.address_id%TYPE)
        IS
            SELECT MAX (o.order_id)     order_id
              FROM OR_ORDER o, OR_ORDER_ACTIVITY oa
             WHERE     o.order_id = oa.order_id
                   AND oa.product_id = inuProductId
                   AND oa.package_id = inuPackageId
                   AND oa.address_id = inuAddressId
                   AND o.task_type_id =
                       dald_parameter.fnuGetNumeric_Value (
                           'COD_COR_DAT_LEG_CER_NUE',
                           NULL)
                   AND o.order_status_id =
                       dald_parameter.fnuGetNumeric_Value ('ESTADO_CERRADO')
                   AND o.causal_id =
                       dald_parameter.fnuGetNumeric_Value ('COD_CAU_OT_LEG',
                                                           NULL);

        CURSOR cuordencertif (nuorden      or_order.order_id%TYPE,
                              nutasktype   or_task_type.task_type_id%TYPE)
        IS
            SELECT order_id
              FROM (  SELECT o1.order_id
                        FROM or_order o1, or_order_activity oa1
                       WHERE     oa1.order_id = o1.order_id
                             AND o1.task_type_id = nuTaskType
                             AND oa1.product_id =
                                 (SELECT oa.product_id
                                    FROM or_order         o,
                                         or_order_activity oa
                                   WHERE     oa.order_id = o.order_id
                                         AND oa.order_id = nuorden)
                             AND ldc_boutilities.fsbbuscatoken (
                                     dald_parameter.fsbgetvalue_chain (
                                         'CAUSA_CERT_INSTALACION'),
                                     TO_CHAR (o1.causal_id),
                                     ',') =
                                 'S'
                    ORDER BY 1 DESC) orden_certif
             WHERE ROWNUM = 1;

        /* select order_id
        from (
              select o1.order_id
              from or_order o1, or_order_activity oa1
              where oa1.order_id = o1.order_id
                and o1.task_type_id = nuTaskType
                and oa1.package_id =
                     (select oa.package_id
                      from or_order o, or_order_activity oa
                      where oa.order_id = o.order_id
                        and oa.order_id = nuorden)
                and ldc_boutilities.fsbbuscatoken(dald_parameter.fsbgetvalue_chain('CAUSA_CERT_INSTALACION'),to_char(o1.causal_id),',') = 'S'
                order by 1 desc
          )orden_certif
          where rownum = 1;*/
        nuOrderCert      or_order.order_id%TYPE;
        sbValor          VARCHAR2 (4000);

    BEGIN
        pkg_Traza.Trace ('inicio LDC_BOORDENES.fsbValDatoAdicOtCertif', 10);

        --SE BUSCA LA SOLICITUD, PRODUCTO Y ADDREES_ID DE LA ORDEN
        --Obtiene la solicitud y el producto
        IF (cuObtenerSolicitudProducto%ISOPEN)
        THEN
            CLOSE cuObtenerSolicitudProducto;
        END IF;

        OPEN cuObtenerSolicitudProducto (nuOrderId);

        FETCH cuObtenerSolicitudProducto
            INTO nuSolicitud, nuProducto, nuAddressId;

        CLOSE cuObtenerSolicitudProducto;

        pkg_Traza.Trace ('orden instanciada --> ' || nuOrderId, 10);
        pkg_Traza.Trace ('tt instanciada --> ' || nuTipoTrab, 10);

        --Se valida que el cursor cuObtenerSolicitudProducto no este abierto
        IF (cuObtenerSolicitudProducto%ISOPEN)
        THEN
            CLOSE cuObtenerSolicitudProducto;
        END IF;

        OPEN cuordencorreccioncertif (nuProducto,
                                      nuSolicitud,
                                      nuAddressId);

        FETCH cuordencorreccioncertif INTO nuOrderCert;

        CLOSE cuordencorreccioncertif;

        pkg_Traza.Trace ('ot correccion certificacion --> ' || nuOrderCert,
                         10);

        IF (nuOrderCert IS NOT NULL)
        THEN
            pkg_Traza.Trace (
                'cuordencorreccioncertif -->  if (nuOrderCert is not null) then',
                10);
            sbValor :=
                LDC_BOORDENES.FNUGETVALOROTBYDATADD (nuTipoTrab,
                                                     11718,     --nuSetAttrib,
                                                     nombDatAdd,
                                                     nuOrderCert);
            pkg_Traza.Trace ('sbValor --> ' || sbValor, 10);
        ELSE
            --FIN ARANADA 3283
            --DESARROLLO ORGINAL SERVICIO
            pkg_Traza.Trace ('ELSE', 10);

            OPEN cuOrdenCertif (nuOrderId, nuTipoTrab);

            FETCH cuOrdenCertif INTO nuOrderCert;

            CLOSE cuOrdenCertif;

            pkg_Traza.Trace ('ot certificacion original --> ' || nuOrderCert,
                             10);

            IF (nuOrderCert IS NOT NULL)
            THEN
                pkg_Traza.Trace (
                    'cuOrdenCertif -->  if (nuOrderCert is not null) then',
                    10);
                sbValor :=
                    LDC_BOORDENES.FNUGETVALOROTBYDATADD (nuTipoTrab,
                                                         nuSetAttrib,
                                                         nombDatAdd,
                                                         nuOrderCert);
                pkg_Traza.Trace ('sbValor --> ' || sbValor, 10);
            END IF;
        --FIN DESARROLLO ORIGINAL SERVICIO
        --ARANADA 3283
        END IF;

        IF (sbvalor = '-1')
        THEN
            sbvalor := '0';
        END IF;

        pkg_Traza.Trace ('sbValor a retornar --> ' || sbValor, 10);
        pkg_Traza.Trace ('fin LDC_BOORDENES.fsbValDatoAdicOtCertif', 10);
        RETURN sbValor;

    END fsbValDatoAdicOtCertif;

    /*****************************************
    Metodo: FSBCTRLLEGALIZAORDENXORCAO
    Descripcion: Permite visualizar el proceso de Legalizacion de ordenes en orcao
                 si la unidad de trabajo a la cual pertenece el funcionario logueado a SF
                 tiene asignada la orden. Retorna 1 si tiene asignada la orden y la UT es interna, Retorna 2
                 si la UT es externa. -1 si la UT asignada a la orden no es ninguna de las asociadas al usuario del sistema
    Autor: Alvaro Zapata
    Fecha: Abril 04/2013
     ******************************************/
    FUNCTION fsbctrllegalizaordenxorcao (NUORDER_ID   IN VARCHAR2,
                                         sbtasktype   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        nuCantidad   NUMBER;
    BEGIN
        /*Consulta que identifica si el funcionario del sistema tiene la misma UT que la asignada a la orden y que esta UT no tenga contratista, es decir
         que es una UT interna*/
        SELECT COUNT (1)
          INTO nuCantidad
          FROM OR_ORDER O
         WHERE     ORDER_ID = NUORDER_ID
               AND O.OPERATING_UNIT_ID IN
                       (SELECT OU.OPERATING_UNIT_ID
                          FROM OR_OPERATING_UNIT  OU
                               INNER JOIN GE_ORGANIZAT_AREA OA
                                   ON OU.ORGA_AREA_ID = OA.ORGANIZAT_AREA_ID
                         WHERE NOT EXISTS
                                   (SELECT 1
                                      FROM GE_CONTRATISTA GC
                                     WHERE OU.CONTRACTOR_ID =
                                           GC.ID_CONTRATISTA) /*AND     OU.ORGA_AREA_ID = (SELECT GP.ORGANIZAT_AREA_ID
                                                               FROM GE_PERSON GP
                                                               WHERE PERSON_ID = GE_BOPERSONAL.fnuGetPersonId)*/
                                                             );

        IF (nuCantidad > 0)
        THEN
            RETURN 1;
        END IF;

        /* En caso de que la UT de la orden no sea interna, se valida que UTs correspondiente a contratistas tiene asignado
        el usuario administrador del contrato y se confirma si la UT asignada a la orden es una de las asociadas al usuario.*/
        /*    SELECT COUNT(1)
         into nuCantidad
         FROM OR_ORDER O
        WHERE ORDER_ID = NUORDER_ID
          AND O.OPERATING_UNIT_ID IN (SELECT C.OPERATING_UNIT_ID
                                      FROM SA_USER_CONTRACTOR_SEC A INNER JOIN OR_OPERATING_UNIT C
                                        ON A.CONTRACTOR_ID            = C.CONTRACTOR_ID
                                      INNER JOIN OR_OPE_UNI_TASK_TYPE D
                                        ON C.OPERATING_UNIT_ID        = D.OPERATING_UNIT_ID
                                      INNER JOIN OR_TASK_TYPE TT
                                        ON D.TASK_TYPE_ID             = TT.TASK_TYPE_ID
                                        WHERE A.CONTRACTOR_ID         = C.CONTRACTOR_ID
                                        AND A.USER_ID = (SELECT GP.USER_ID
                                                         FROM GE_PERSON GP
                                                         WHERE PERSON_ID = GE_BOPERSONAL.fnuGetPersonId)
                                        AND TO_CHAR(D.task_type_id || ' - ' || tt.description) = sbtasktype
                                        AND C.OPERATING_UNIT_ID = D.OPERATING_UNIT_ID);*/
        /*valida que el tipo de trabajo a legalizar y el usuario logueado al sistema pertenezcan a la misma
        UT de la orden*/
        SELECT COUNT (1)
          INTO nuCantidad
          FROM OR_ORDER O
         WHERE     ORDER_ID = NUORDER_ID
               AND O.OPERATING_UNIT_ID IN
                       (SELECT D.OPERATING_UNIT_ID
                          FROM OR_OPE_UNI_TASK_TYPE  D
                               INNER JOIN OR_OPER_UNIT_PERSONS UP
                                   ON D.OPERATING_UNIT_ID =
                                      UP.OPERATING_UNIT_ID
                               INNER JOIN OR_TASK_TYPE TT
                                   ON D.TASK_TYPE_ID = TT.TASK_TYPE_ID
                         WHERE     TO_CHAR (
                                          D.task_type_id
                                       || ' - '
                                       || tt.description) =
                                   sbtasktype
                               AND UP.PERSON_ID =
                                   GE_BOPERSONAL.fnuGetPersonId);

        IF (nuCantidad > 0)
        THEN
            RETURN 2;
        --dbms_output.put_line(nuCantidad||'Retorna 1');
        END IF;

        RETURN -1;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN -1;
    END fsbctrllegalizaordenxorcao;

    /*****************************************
    Metodo: fnuComparaDatosAdicionales
    Descripcion:  Compara los valores fijados en los datos adicionales entre la orden de certificacion y/o apoyo
                  frente a la orden de instalacion y cargo por conexion

    Autor: Luz Andrea Angel/OLSoftware
    Fecha: Abril 04/2013

    Fecha                IDEntrega           Modificacion
    ============    ================    ============================================
    27-05-2013      luzangel           Adiciona validacion de tolerancia en long. acometida y en long. instalacion de interna
    17-09-2013      luzangel           NC746:se ajusta la logica debido a que la solicitud de venta puede incluir o no,
                                       las dos ordenes (Cargo x conexion y/o Instalacion)
    22-Enero-2014    Jorge Valiente    NC2493: Se actualizo la logica de la validacion de LONG_INST_INTERNA para que valide
                                       entre un rango permitido.
    07-Marzo-2014    Jorge Valiente    NC3027: Se cambiara la logica de validacion para datos adicionales
                                       que realizan la comapacion entre texto.
     ******************************************/
    FUNCTION fnucomparadatosadicionales (
        nuordeno        IN OUT or_order.order_id%TYPE,
        nuOrdenCxC      IN OUT or_order.order_id%TYPE,
        nuordeninst     IN OUT or_order.order_id%TYPE,
        nuTipoTrabCa    IN OUT or_task_type.task_type_id%TYPE,
        nutipotrabo     IN OUT or_task_type.task_type_id%TYPE,
        nuTipoTrabI     IN OUT or_task_type.task_type_id%TYPE,
        sbgrupodato     IN OUT ge_equivalenc_values.target_value%TYPE,
        nuactivid       IN     or_order_activity.order_activity_id%TYPE,
        sbAtributoDif      OUT VARCHAR2)
        RETURN NUMBER
    AS
        --obtiene los datos adicionales por grupo de datos
        CURSOR cuDatosAdicionales (
            nuTipoTrabajo   or_task_type.task_type_id%TYPE,
            sbGrupo         ge_equivalenc_values.target_value%TYPE)
        IS
              SELECT ad.attribute_set_id      id_grupo,
                     at.attribute_id          id_atributo,
                     at.name_attribute        nombre_atributo,
                     at.attribute_type_id     tipo_dato
                FROM OR_TASKTYPE_ADD_DATA ad,
                     GE_ATTRIBUTES       at,
                     GE_ATTRIB_SET_ATTRIB atsa
               WHERE     at.attribute_id = atsa.attribute_id
                     AND ad.attribute_set_id = atsa.attribute_set_id
                     AND ad.attribute_set_id IN
                             ((SELECT TO_NUMBER (COLUMN_VALUE)
                                 FROM TABLE (
                                          ldc_boutilities.splitstrings (
                                              sbGrupo,
                                              ','))))
                     AND ad.task_type_id = nuTipoTrabajo
            ORDER BY 1 ASC;

        sbValorDatoD   VARCHAR2 (500);
        sbvalordatoo   VARCHAR2 (500);
        nuidgrupo      NUMBER;
        sbatributo     VARCHAR2 (1000);
        nuidatributo   NUMBER;
        nudatoo        NUMBER;
        nudatod        NUMBER;
        nudif          NUMBER;
        NURETORNO      NUMBER := 1;
        nuValida       NUMBER;
    BEGIN
        pkg_Traza.Trace (
               'ingresa a fnuComparaDatosAdicionales: '
            || nuOrdenO
            || ','
            || nuOrdenCxC
            || ','
            || nuOrdenInst
            || ','
            || nuTipoTrabCa
            || ','
            || nuTipoTrabO
            || ','
            || nuTipoTrabI
            || ','
            || sbgrupodato
            || ','
            || nuactivid,
            10);

        --obtendra los datos adicionales del grupo asociado a la orden de certificacion
        FOR rtdatosadicionales
            IN cudatosadicionales (nutipotrabo, sbgrupodato)
        LOOP
            nuidgrupo := rtdatosadicionales.id_grupo;
            sbatributo := rtdatosadicionales.nombre_atributo;
            nuidAtributo := rtDatosAdicionales.id_atributo;
            --ad.attribute_set_id id_grupo, at.attribute_id id_atributo, at.name_attribute nombre_atributo, at.attribute_type_id tipo_dato
            --obtiene el valor del dato adicional de la orden de certificacion que sera el ORIGEN
            sbValorDatoO :=
                FnugetValorOTbyDatAdd (nuTipoTrabO,
                                       nuidgrupo,
                                       sbAtributo,
                                       nuOrdenO);
            pkg_Traza.Trace ('rtDatosAdicionales.id_grupo' || nuidgrupo, 10);
            pkg_Traza.Trace (
                'rtDatosAdicionales.nombre_atributo' || sbatributo,
                10);
            pkg_Traza.Trace ('sbValorDatoO-->' || sbValorDatoO, 10);
            sbValorDatoD := NULL;

            --obtiene el valor del dato adicional de la orden de Cargo x Conexion que sera el DESTINO
            IF (nuordencxc IS NOT NULL)
            THEN
                sbValorDatoD :=
                    fsbDatoAdicTmpOrden (nuordencxc,
                                         nuidAtributo,
                                         sbatributo);
                pkg_Traza.Trace ('sbValorDatoD-cxc-->' || sbValorDatoD, 10);
            END IF;

            --si no obtiene el dato en la orden de cargo x conexion debera buscar en la orden de instalacion
            IF (sbvalordatod IS NULL)
            THEN
                IF (nuordeninst IS NOT NULL)
                THEN
                    --obtiene el valor del dato adicional de la orden de Instalacion  que sera el DESTINO
                    pkg_Traza.Trace (
                        'obtiene el valor del dato adicional de la orden de Instalacion  que sera el DESTINO',
                        10);
                    pkg_Traza.Trace ('nuordeninst-->' || nuordeninst, 10);
                    pkg_Traza.Trace ('nuidAtributo-->' || nuidAtributo, 10);
                    pkg_Traza.Trace ('sbatributo-->' || sbatributo, 10);
                    sbValorDatoD :=
                        fsbDatoAdicTmpOrden (nuordeninst,
                                             nuidAtributo,
                                             sbatributo);
                    pkg_Traza.Trace ('sbValorDatoD-inst-->' || sbvalordatod,
                                     10);
                END IF;
            END IF;

            pkg_Traza.Trace ('sbatributo-->' || sbatributo, 10);
            nuvalida := ldc_boordenes.fnuaplicadatoadicionalnuevas (nuordeno);
            pkg_Traza.Trace ('valida ot cxc/interna-nuvalida-->' || nuvalida,
                             10);

            --solo instalacion
            IF (nuvalida = 2)
            THEN
                IF (   sbatributo = 'INST_CENTRO_MEDICION'
                    OR sbatributo = 'TIPO_CENTRO_MEDICION'
                    OR sbatributo = 'DIAM_ACOMETIDA'
                    OR sbatributo = 'SERIE_MEDIDOR')
                THEN
                    sbValorDatoD := 'NO APLICA';
                END IF;

                IF (   sbatributo = 'PRESION_ESTATICA'
                    OR sbatributo = 'PRESION_DINAMICA'
                    OR sbatributo = 'LONG_ACOMETIDA')
                THEN
                    sbValorDatoD := '0';
                END IF;
            END IF;

            --solo cargo
            IF (nuvalida = 3)
            THEN
                IF (   sbatributo = 'MATERIAL_INST_INTERNA'
                    OR sbatributo = 'UBICACIÓN_INST_INTERNA')
                THEN
                    sbValorDatoD := 'NO APLICA';
                END IF;

                IF (   sbatributo = 'LONG_INST_INTERNA'
                    OR sbatributo = 'PUNTOS_CONST_INST'
                    OR sbatributo = 'PTOS_ADICIONALES'
                    OR sbatributo = 'PTOS_OPCIONALES')
                THEN
                    sbValorDatoD := '0';
                END IF;
            END IF;

            IF sbatributo = 'PUNTOS_CONECTADOS'
            THEN
                IF nuValida = 3
                THEN
                    sbValorDatoD :=
                        fsbDatoAdicTmpOrden (nuordencxc,
                                             nuidAtributo,
                                             sbatributo);
                ELSE
                    sbValorDatoD :=
                        fsbDatoAdicTmpOrden (nuordeninst,
                                             nuidAtributo,
                                             sbatributo);
                END IF;

                pkg_Traza.Trace (
                    'valida ot cxc/interna-sbValorDatoD-->' || sbValorDatoD,
                    10);
            END IF;

            pkg_Traza.Trace ('if long acometida e inst_interna', 10);

            IF (   TRIM (sbatributo) = 'LONG_ACOMETIDA'
                OR TRIM (sbatributo) = 'LONG_INST_INTERNA')
            THEN
                nuDatoO := TO_NUMBER (sbValorDatoO);
                pkg_Traza.Trace ('nuDatoO --> ' || nuDatoO, 10);
                nuDatoD := TO_NUMBER (sbValorDatoD);
                pkg_Traza.Trace ('nuDatoD --> ' || nuDatoD, 10);
                nuDif := nuDatoO - nuDatoD;
                pkg_Traza.Trace ('nuDif := nuDatoO - nuDatoD --> ' || nuDif,
                                 10);

                IF (nuDatoO <> nuDatoD)
                THEN
                    IF (sbatributo = 'LONG_ACOMETIDA')
                    THEN
                        --if(nuDif < -0.2 or nuDif > 0.2) then
                        IF (nuDif > -0.2 AND nuDif < 0.2)
                        THEN
                            nuRetorno := 1;
                        ELSE
                            nuRetorno := 0;
                        END IF;
                    END IF;

                    IF (sbatributo = 'LONG_INST_INTERNA')
                    THEN
                        --NC2493
                        --if(nuDif < -05 or nuDif > 0.5) then
                        IF (nuDif > -0.5 AND nuDif < 0.5)
                        THEN
                            nuRetorno := 1;
                        ELSE
                            --NC2493
                            nuRetorno := 0;
                        END IF;
                    END IF;
                END IF;
            END IF;

            --ARANDA 3027
            IF nuretorno <> 1
            THEN
                sbAtributoDif := sbatributo;
            END IF;

            --FIN ARANDA 3027
            pkg_Traza.Trace ('if serie y presion', 10);

            IF (   TRIM (sbatributo) = 'SERIE_MEDIDOR'
                OR TRIM (sbatributo) = 'PRESION_DINAMICA')
            THEN
                nuRetorno := 1;
            ELSE
                pkg_Traza.Trace ('No es serie ', 10);

                IF (sbvalordatoo IS NOT NULL AND sbvalordatod IS NOT NULL)
                THEN
                    pkg_Traza.Trace ('comparando datos', 10);
                    pkg_Traza.Trace (
                           'sbValorDatoO --- sbValorDatoD '
                        || sbValorDatoO
                        || '---'
                        || sbValorDatoD,
                        10);

                    --ARANDA 3027
                    --if (trim(sbValorDatoO) <> trim(sbValorDatoD) and nuretorno <> 1) then
                    IF (TRIM (sbValorDatoO) <> TRIM (sbValorDatoD))
                    THEN
                        --FIN ARANDA 3027
                        nuretorno := 0;
                        sbAtributoDif := sbatributo;
                    END IF;
                END IF;

                IF (nuretorno = 0)
                THEN
                    EXIT;
                END IF;
            END IF;

            nuDatoO := 0;
            nuDatoD := 0;
            nudif := 0;
            nuRetorno := 1;
            pkg_Traza.Trace ('nuRetorno-->' || nuretorno, 10);
            pkg_Traza.Trace ('--', 10);
        END LOOP;

        RETURN nuRetorno;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN -1;
    END fnuComparaDatosAdicionales;

    /*****************************************
    Metodo: proComparaCantCertInst
    Descripcion:  Compara cantidades legalizadas entre la orden de certificacion o apoyo  y la orden de instalacion
                  La orden de cargo por conexion la toma desde la instancia
    Autor: Luz Andrea Angel/OLSoftware
    Fecha: Abril 03/2013

    Fecha                IDEntrega           Modificacion
    ============    ================    ============================================
    27-05-2013        luzaa             Se incluye validacion causal: 9091(OT legaliza sin inspeccion por culpa de cliente)
                                        para que no se realicen las validaciones correspondientes
    13-09-2013        luzaa             NC 707:Se modifica validacion para la comparacion del medidor y la presion, ya que por ser
                                        cadenas no estan llegando con valor -1 sino NULL
    17-09-2013        luzaa             NC746:se ajusta la logica debido a que la solicitud de venta puede incluir o no,
                                        las dos ordenes (Cargo x conexion y/o Instalacion)
    18-09-2013        luzaa             NC 746v2:se ajusta validacion para la creacion de items de pago, ya que no siempre se van a tener
                                        las 2 ordenes.
    28-09-2013        luzaa             NC 746: se ajusto toda la logica para que tenga en cuenta la direccion, ya que para multifamiliares es por solicitud
                                        y direccion
    03-10-2013        luzaa             NC992:se incluye validacion ya que si hay error en mediddor no lo estaba informando y se elimina la validacion
                                        de la presion

    31-10-2013        luzaa             NC1497: se ajusta validacion acerca de que la orden de certificacion debe estar legalizada antes que las de cargo o de
                                        instalacion
    06-12-2013        luzaa             NC2081: Se modifica para que cuando se compare con la orden de apoyo pase el tipo de trabajo adecuado
                                        (certificacion/apoyo). Validacion para la generacion de la multa si corresponde de acuerdo al valor de la ot de apoyo.
                                        Se cambia constructora que obtiene los grupos de atributos de acuerdo al tipo de trabajo.
    13-12-2013     Sayra Ocoro          NC 2094: Se adiciona metodo para obtener el valor del item antes de crear la novedad
    02-04-2014     Jorge Valiente       Aranda 3283: Modificacion de la logica el cursor cuordenapoyo para que filtre y ordene con la ultima
                                                     orden de correccion generada de la certificacion de instalacion.
                                                     al final de la sentencia del cursor se coloca que ordenara descendentemente.
    03-04-2014     Jorge Valiente       Aranda XXXX: Ampliar la validacion de la acusal 9091 para permitir que valide lso datos adicionales
    28-05-2014     Jorge Valiente       RNP 44: Se requiere ajustar el RNP que para el proceso de construcción de instalaciones y especificamente para
                                                (CONEXIONES - INSTALACIONES NUEVAS), está desarrollado en este momento y ajustarlo para que funciones
                                                como está planteado para el proceso de Servicios Asociados y no permitir crear los items automaticos
                                                que si se crear en GDO.
                                                Se creara un parametro el cual valide si permite o no la creaion de los Items Automaticos.
    09/11/2014     Jorge Valiente       NC 3581: Se adiciono codigo para permitirle a las certiifcaciones
                                                 legalizadas con causal 3333 - CLIENTE REALIZA CERTIFICACION CON TERCERO
                                                 generar a las ordenes de cargo por conexion e interna los items dcionales
    **************************************************/
    PROCEDURE proComparaCantCertInst
    IS
        --valida que la orden que llega sea de CxC
        CURSOR cuobtordencargo (nuorden or_order.order_id%TYPE)
        IS
            SELECT a.order_id,
                   a.task_type_id,
                   a.order_activity_id,
                   a.address_id
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.task_type_id IN (12150, 12152)
                   AND b.order_status_id <> 12
                   AND a.order_id = nuOrden;

        --valida que la orden que llega sea de Instalacion
        CURSOR cuobtordeninst (nuorden or_order.order_id%TYPE)
        IS
            SELECT a.order_id,
                   a.task_type_id,
                   a.order_activity_id,
                   a.address_id
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.task_type_id IN (12151, 12149)
                   AND b.order_status_id <> 12
                   AND a.order_id = nuOrden;

        --obtiene la solicitud de venta
        CURSOR cuSolicVta (nuOrden or_order.order_id%TYPE)
        IS
            SELECT b.package_id
              FROM or_order a, or_order_activity b
             WHERE a.order_id = b.order_id AND b.order_id = nuOrden;

        --obtiene la orden de instalacion asociada a la solicitud de venta
        CURSOR cuordeninst (nusolvta      mo_packages.package_id%TYPE,
                            nudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT a.order_id, a.task_type_id, a.address_id
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.task_type_id IN (12149, 12151)
                   AND b.order_status_id <> 12
                   AND a.package_id = nusolvta
                   AND a.address_id = nudireccion;

        --obtiene la orden de instalacion asociada a la solicitud de venta
        CURSOR cuordencargo (nusolvta      mo_packages.package_id%TYPE,
                             nudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT a.order_id, a.task_type_id, a.address_id
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.task_type_id IN (12152, 12150)
                   AND b.order_status_id <> 12
                   AND a.package_id = nusolvta
                   AND a.address_id = nudireccion;

        --obtiene la ultima orden de certificacion asociada a la solicitud de venta
        CURSOR cuordencert (nusolvta      mo_packages.package_id%TYPE,
                            nudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT order_id,
                   task_type_id,
                   operating_unit_id,
                   causal_id
              FROM (  SELECT a.order_id,
                             a.task_type_id,
                             b.operating_unit_id,
                             b.causal_id
                        FROM or_order_activity a, or_order b
                       WHERE     a.order_id = b.order_id
                             AND a.task_type_id = 12162
                             AND b.order_status_id = 8
                             AND a.package_id = nusolvta
                             AND a.address_id = nudireccion
                    ORDER BY 1 DESC) orden_certif
             WHERE ROWNUM = 1;

        --obtiene la orden de apoyo desde la solicitud de venta
        CURSOR cuordenapoyo (nusolicitud   mo_packages.package_id%TYPE,
                             nudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT a.order_id, b.task_type_id
              FROM or_order a, or_order_activity b
             WHERE     a.order_id = b.order_id
                   AND b.package_id = nusolicitud
                   AND b.address_id = nudireccion
                   AND b.task_type_id = 10212 --; --OT apoyo Correccionm datos de legaliz. certif.
                   --Aranda 3283, 3628 se adiciona validacion por direccion
                   AND A.LEGALIZATION_DATE =
                       (SELECT MAX (legalization_date)
                          FROM (  SELECT o1.order_id,
                                         o1.causal_id,
                                         o1.legalization_date
                                    FROM or_order         o1,
                                         or_order_activity oa1
                                   WHERE     oa1.order_id = o1.order_id
                                         AND o1.task_type_id =
                                             dald_parameter.fnuGetNumeric_Value (
                                                 'COD_COR_DAT_LEG_CER_NUE',
                                                 NULL)
                                         AND oa1.Package_Id = nusolicitud
                                         AND o1.causal_id =
                                             dald_parameter.fnuGetNumeric_Value (
                                                 'COD_CAU_OT_LEG',
                                                 NULL)
                                         AND oa1.address_id = nudireccion
                                ORDER BY 1 DESC) orden_certif); --OT apoyo Correccionm datos de legaliz. certif.

        --Fin Aranda 3283,3628
        --obtiene la cantidad de OT CxC y/o Instalacion legalizadas
        --Mmejia
        --Aranda 6555
        --12-06-2015
        --Se modifica el cursor que obtiene la cantidad de ordenes cerradas
        --para que  filtre las causales de legalizacion  diferentes a fallo
        CURSOR cucantotcerradas (
            nusolicitud   mo_packages.package_id%TYPE,
            nuttinstala   or_order.task_type_id%TYPE,
            nuttcarcon    or_order.task_type_id%TYPE,
            nudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT COUNT (a.order_id)
              FROM or_order_activity a, or_order b, ge_causal C
             WHERE     a.order_id = b.order_id
                   AND a.task_type_id IN (nuttinstala, nuttcarcon)
                   AND b.order_status_id = 8
                   AND ldc_boutilities.fsbbuscatoken (
                           dald_parameter.fsbgetvalue_chain (
                               'CAUSA_CERT_INSTALACION'),
                           TO_CHAR (b.causal_id),
                           ',') =
                       'S'
                   AND a.package_id = nusolicitud
                   AND a.address_id = nudireccion
                   AND B.causal_id = C.causal_id
                   AND C.CLASS_CAUSAL_ID <> 2;

        CURSOR cucantotcerradasEFG (
            nusolicitud   mo_packages.package_id%TYPE,
            nuttinstala   or_order.task_type_id%TYPE,
            nuttcarcon    or_order.task_type_id%TYPE,
            nudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT COUNT (a.order_id)
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.task_type_id IN (nuttinstala, nuttcarcon)
                   AND b.order_status_id = 8
                   AND ldc_boutilities.fsbbuscatoken (
                           dald_parameter.fsbgetvalue_chain (
                               'CAUSA_CERT_INSTALACION'),
                           TO_CHAR (b.causal_id),
                           ',') =
                       'S'
                   AND a.package_id = nusolicitud
                   AND a.address_id = nudireccion;

        --NC746
        --obtiene la cantidad de OT CxC y/o Instalacion asociadas a la solicitud
        --Mmejia
        --Aranda 6555
        --12-06-2015
        --Se modifica el cursor para obteng ornde con causal de exito
        --y ordenes sin legalizar , esto daria la cantidad de ordenes
        --de una solicitud sin tener en cuenta las ordenes con causal
        --de fallo
        CURSOR cucantotsol (nusolicitud   mo_packages.package_id%TYPE,
                            nudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT COUNT (*)
              FROM (SELECT B.ORDER_ID
                      FROM or_order_activity a, or_order b, ge_causal C
                     WHERE     a.order_id = b.order_id
                           AND a.task_type_id IN (12149,
                                                  12151,
                                                  12152,
                                                  12150)
                           AND b.order_status_id <> 12               --anulada
                           AND a.package_id = nusolicitud
                           AND a.address_id = nudireccion
                           AND B.causal_id = C.causal_id
                           AND C.CLASS_CAUSAL_ID <> 2
                    UNION
                    SELECT B.ORDER_ID
                      FROM or_order_activity a, or_order b
                     WHERE     a.order_id = b.order_id
                           AND a.task_type_id IN (12149,
                                                  12151,
                                                  12152,
                                                  12150)
                           AND b.order_status_id <> 12               --anulada
                           AND a.package_id = nusolicitud
                           AND a.address_id = nudireccion
                           AND B.causal_id IS NULL);

        CURSOR cucantotsolEFG (
            nusolicitud   mo_packages.package_id%TYPE,
            nudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT COUNT (*)
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.task_type_id IN (12149,
                                          12151,
                                          12152,
                                          12150)
                   AND b.order_status_id <> 12                       --anulada
                   AND a.package_id = nusolicitud
                   AND a.address_id = nudireccion;

        --NC999 valida si la unidad de trabajo es externa
        CURSOR cuunidadexterna (nuunidadoper or_order.operating_unit_id%TYPE)
        IS
            SELECT es_externa
              FROM or_operating_unit
             WHERE operating_unit_id = nuunidadoper;

        --NC999 valida si ya tiene una orden de novedad asociada
        CURSOR cuvalidamulta (nuordenc   or_order.order_id%TYPE,
                              nuitemM    ge_items.items_id%TYPE)
        IS
            SELECT a.order_id
              FROM or_related_order a
             WHERE     a.rela_order_type_id = 14
                   AND a.order_id = nuordenc
                   AND (SELECT b.order_id
                          FROM or_order_activity b
                         WHERE     b.activity_id = nuitemm
                               AND b.order_id = a.related_order_id) =
                       1;

        CURSOR cugruposdatos (inutitpotrabajo or_task_type.task_type_id%TYPE)
        IS
            SELECT attribute_set_id
              FROM or_tasktype_add_data
             WHERE active = 'Y' AND task_type_id = inutitpotrabajo;

        nuSolicitud                   mo_packages.package_id%TYPE;
        nuOrdenCargo                  or_order.order_id%TYPE;
        nuOrdenCert                   or_order.order_id%TYPE;
        nuOrdenInst                   or_order.order_id%TYPE;
        nuOrdenApoyo                  or_order.order_id%TYPE;
        nuTipoTrabI                   or_task_type.task_type_id%TYPE;
        nuTipoTrabCa                  or_task_type.task_type_id%TYPE;
        nuTipoTrabCe                  or_task_type.task_type_id%TYPE;
        nuTipoTrabAp                  or_task_type.task_type_id%TYPE;
        sbgrupodato                   ge_equivalenc_values.target_value%TYPE;
        nuunidoper                    or_order.operating_unit_id%TYPE;
        nutecnico                     or_operating_unit.person_in_charge%TYPE;
        nuactividca                   or_order_activity.order_activity_id%TYPE;
        nuactividin                   or_order_activity.order_activity_id%TYPE;
        nuactivid                     or_order_activity.order_activity_id%TYPE;
        nuordinstance                 or_order.order_id%TYPE;
        nuordenOrig                   or_order.order_id%TYPE;
        nucausalc                     ge_causal.causal_id%TYPE;
        nuordenc                      or_order.order_id%TYPE;
        nudir                         or_order_activity.address_id%TYPE;
        nuordenMulta                  or_order.order_id%TYPE;
        sbAplicaMulta                 VARCHAR2 (2);
        sbMedidorAd                   VARCHAR2 (50);
        sbPresionAd                   VARCHAR2 (50);
        sbMedidorAt                   VARCHAR2 (50);
        sbPresionAt                   VARCHAR2 (50);
        sbmensaje                     VARCHAR2 (2000);
        sbcausal                      VARCHAR2 (20);
        nupersonid                    NUMBER;
        nuretorno                     NUMBER;
        nuitemmulta                   NUMBER;
        nuotcerradas                  NUMBER;
        nuotsolicitud                 NUMBER;
        sbatributodif                 VARCHAR2 (2000);
        nuerrorcode                   NUMBER;
        sberrormessage                VARCHAR2 (4000);
        nutipocomentario              NUMBER := 1298;
        nuTipoTrabOrig                NUMBER;
        nucantot                      NUMBER;
        sbExterna                     VARCHAR2 (2) := 'N';
        EX_ERROR                      EXCEPTION;
        idtDate                       DATE;
        inuContract                   ge_list_unitary_cost.contract_id%TYPE;
        inuContractor                 ge_list_unitary_cost.contractor_id%TYPE;
        inuGeoLocation                ge_list_unitary_cost.geograp_location_id%TYPE;
        isbType                       ge_acta.id_tipo_acta%TYPE;
        onuValue                      ge_unit_cost_ite_lis.price%TYPE;
        onuPriceListId                ge_list_unitary_cost.list_unitary_cost_id%TYPE;
        --INICIO RNP 44 GES
        SBCREAR_ITEM_AUTO             LD_PARAMETER.VALUE_CHAIN%TYPE;
        --FIN RNP 44 GES
        ---NC 3581
        NUCAUSAL_CLIEN_CERTI_TERCER   LD_PARAMETER.NUMERIC_VALUE%TYPE
            := DALD_PARAMETER.fnuGetNumeric_Value (
                   'CAUSAL_CLIEN_CERTI_TERCER',
                   NULL);
        --FIN NC3581
    BEGIN
        pkg_Traza.Trace ('Inicia LDC_BOORDENES.proComparaCantCertInst', 10);
        --INICIO RNP 44 GES
        ---OBTENER EL VALOR DEL PARAMETRO CREAR_ITEM_AUTO
        SBCREAR_ITEM_AUTO :=
            DALD_PARAMETER.fsbGetValue_Chain ('CREAR_ITEM_AUTO', NULL);

        IF SBCREAR_ITEM_AUTO IS NULL
        THEN
            SBCREAR_ITEM_AUTO := 'S';
        END IF;

        pkg_Traza.Trace (
               'VARIABLE VALIDACION ITEM AUTOMATICO [SBCREAR_ITEM_AUTO] --> '
            || SBCREAR_ITEM_AUTO,
            10);
        --FIN RNP 44 GES
        --nuOrdinstance := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER','ORDER_ID');
        nuOrdinstance := or_bolegalizeorder.fnugetcurrentorder;
        pkg_Traza.Trace ('nuOrdinstance-->' || nuOrdinstance, 10);

        OPEN cuObtOrdenCargo (nuOrdinstance);

        FETCH cuobtordencargo
            INTO nuordencargo,
                 nutipotrabca,
                 nuactividca,
                 nudir;

        CLOSE cuobtordencargo;

        pkg_Traza.Trace ('nuOrdenCargo-->' || nuordencargo, 10);
        pkg_Traza.Trace ('nuOrdenCargo-nudir-->' || nudir, 10);

        IF (nuordencargo IS NULL)
        THEN
            OPEN cuObtOrdenInst (nuOrdinstance);

            FETCH cuobtordeninst
                INTO nuOrdenInst,
                     nuTipoTrabI,
                     nuactividin,
                     nudir;

            CLOSE cuobtordeninst;

            IF (nuordeninst IS NOT NULL)
            THEN
                nuactivid := nuactividin;
            END IF;
        ELSE
            nuactivid := nuactividca;
        END IF;

        pkg_Traza.Trace ('nuOrdenInst-->' || nuordeninst, 10);
        pkg_Traza.Trace ('nuOrdenInst-nudir-->' || nudir, 10);

        IF (nuTipoTrabCa IS NOT NULL OR nuTipoTrabI IS NOT NULL)
        THEN
            OPEN cuSolicVta (nuOrdinstance);

            FETCH cuSolicVta INTO nuSolicitud;

            CLOSE cusolicvta;

            pkg_Traza.Trace ('nuSolicitud-->' || nusolicitud, 10);

            IF (nusolicitud IS NOT NULL OR nusolicitud > 0)
            THEN
                --obtener la orden a partir de la solicitud
                IF (nuordeninst IS NULL)
                THEN
                    OPEN cuOrdenInst (nuSolicitud, nudir);

                    FETCH cuordeninst INTO nuOrdenInst, nuTipoTrabI, nudir;

                    CLOSE cuordeninst;
                END IF;

                pkg_Traza.Trace ('nuOrdenInst is null-->' || nuOrdenInst, 10);

                --obtener la orden a partir de la solicitud
                IF (nuordencargo IS NULL)
                THEN
                    OPEN cuOrdenCargo (nuSolicitud, nudir);

                    FETCH cuordencargo INTO nuOrdenCargo, nuTipoTrabCa, nudir;

                    CLOSE cuordencargo;
                END IF;

                pkg_Traza.Trace ('nuordencargo is null-->' || nuOrdenCargo,
                                 10);
                --obtiene la orden certificada
                pkg_Traza.Trace ('nuOrdenCert-nusolicitud-->' || nusolicitud,
                                 10);
                pkg_Traza.Trace ('nuOrdenCert-nudir-->' || nudir, 10);

                OPEN cuordencert (nusolicitud, nudir);

                FETCH cuordencert
                    INTO nuOrdenCert,
                         nuTipoTrabCe,
                         nuUnidOper,
                         nucausalc;

                CLOSE cuordencert;

                pkg_Traza.Trace ('nuOrdenCert-->' || nuOrdenCert, 10);

                --valida que la ot de certificacion este legalizada
                IF (nuOrdenCert IS NOT NULL)
                THEN
                    --si causal es Legalizacion SIN Inspeccion x Culpa Cliente no compara 9091
                    pkg_Traza.Trace ('nucausal-->' || nucausalc, 10);

                    IF (nucausalc !=
                        dald_parameter.fnugetnumeric_value (
                            'COD_CAUSAL_LEG_SIN_INSP_CLIE',
                            NULL))
                    THEN
                        --verifica que la causal sea certificacion exitosa
                        IF (ldc_boutilities.fsbbuscatoken (
                                dald_parameter.fsbgetvalue_chain (
                                    'CAUSA_CERT_INSTALACION'),
                                TO_CHAR (nucausalc),
                                ',') =
                            'S')
                        THEN
                            --obtiene OT de apoyo asociada a la solicitud
                            OPEN cuOrdenApoyo (nuSolicitud, nudir);

                            FETCH cuOrdenApoyo
                                INTO nuOrdenApoyo, nuTipoTrabAp;

                            CLOSE cuordenapoyo;

                            pkg_Traza.Trace (
                                'nuOrdenApoyo-->' || nuordenapoyo,
                                10);
                            pkg_Traza.Trace ('nuactivid-->' || nuactivid, 10);

                            --debe existir la orden origen tanto CxC como de Instalacion
                            IF (   nuOrdenInst IS NOT NULL
                                OR nuOrdenCargo IS NOT NULL)
                            THEN
                                --si existe la orden de apoyo solo valida con la OT de apoyo
                                IF (   nuOrdenApoyo IS NOT NULL
                                    OR nuOrdenApoyo > 0)
                                THEN
                                    --de acuerdo al tipo de trabajo se obtiene el grupo de datos que debera consultar para obtener los datos adicionales
                                    OPEN cugruposdatos (nutipotrabap);

                                    FETCH cugruposdatos INTO sbgrupodato;

                                    CLOSE cugruposdatos;

                                    /*sbgrupodato   := ge_boequivalencvalues.fsbgettargetvaluenoexcep(3,
                                    nutipotrabap);*/
                                    sbAplicaMulta :=
                                        FnugetValorOTbyDatAdd (
                                            nuTipoTrabAp,
                                            11718,
                                            'APLICACION_MULTA?',
                                            nuOrdenApoyo);
                                    sbMedidorAd :=
                                        FnugetValorOTbyDatAdd (
                                            nuTipoTrabAp,
                                            11718,
                                            'SERIE_MEDIDOR',
                                            nuordenapoyo);

                                    --NC992:se elimina, porque ya no se debe comparar
                                    /*sbPresionAd   := FnugetValorOTbyDatAdd(nuTipoTrabAp,
                                    11718,
                                    'PRESION_DINAMICA',
                                    nuOrdenApoyo);*/
                                    --en la orden de apoyo si el valor del dato adicional "Genera_multa" es Si, se debe crear la novedad
                                    IF (UPPER (sbaplicamulta) = UPPER ('Si'))
                                    THEN
                                        pkg_Traza.Trace (
                                               'sbaplicamulta-->'
                                            || sbaplicamulta,
                                            10);
                                        nuitemmulta := 4294545;

                                        --NC999 valida si es unidad operativa externa
                                        OPEN cuunidadexterna (nuunidoper);

                                        FETCH cuunidadexterna INTO sbExterna;

                                        CLOSE cuunidadexterna;

                                        pkg_Traza.Trace (
                                            'nuunidoper-->' || nuunidoper,
                                            10);
                                        pkg_Traza.Trace (
                                            'sbExterna-->' || sbExterna,
                                            10);

                                        --NC999 valida si ya tiene una orden de novedad asociada
                                        OPEN cuvalidamulta (nuordencert,
                                                            nuitemmulta);

                                        FETCH cuvalidamulta INTO nuordenMulta;

                                        CLOSE cuvalidamulta;

                                        nupersonid :=
                                            ge_bopersonal.fnugetpersonid;

                                        IF (    UPPER (sbExterna) =
                                                UPPER ('Y')
                                            AND nuordenMulta IS NULL)
                                        THEN
                                            --NC 2094: Modificacion 13-12-2013
                                            idtDate := SYSDATE; --daor_order.fdtgetlegalization_date(nuordencert);
                                            inuContract :=
                                                daOR_order.Fnugetdefined_Contract_Id (
                                                    nuordencert);
                                            inuContractor :=
                                                daor_operating_unit.fnugetcontractor_id (
                                                    nuunidoper);
                                            inuGeoLocation :=
                                                daOR_order.Fnugetgeograp_Location_Id (
                                                    nuordencert);
                                            isbType := 1; -- Tipo de Acta: 1-Liquidacion, 2-Facturacion
                                            CT_BOLiquidationSupport.GetListItemValue (
                                                nuitemmulta,
                                                idtDate,
                                                nuunidoper,
                                                inuContract,
                                                inuContractor,
                                                inuGeoLocation,
                                                isbType,
                                                onuPriceListId,
                                                onuValue);
                                            --Fin Modificacion 13-12-2013
                                            --Registrar novedad
                                            LDC_OS_REGISTERNEWCHARGE (
                                                nuunidoper,
                                                nuitemmulta,
                                                NULL,
                                                nuordencert,
                                                onuValue,
                                                NULL,
                                                nuTipoComentario,
                                                'Multa por error en digitacion de datos',
                                                nuerrorcode,
                                                sberrormessage);

                                            --OS_REGISTERNEWCHARGE  (nuunidoper, nuitemmulta, NULL, nuordencert, onuValue, 1, nuTipoComentario, 'Multa por error en digitacion de datos', nuerrorcode, sberrormessage);
                                            IF (nuerrorcode <> 0)
                                            THEN
                                                RAISE pkg_Error.CONTROLLED_ERROR;
                                            END IF;

                                            nuerrorcode := NULL;
                                            sberrormessage := NULL;
                                        END IF;
                                    END IF;

                                    nuordenorig := nuordenapoyo;
                                    nuTipoTrabOrig := nuTipoTrabAp;
                                --sino valida por orden de certificacion
                                ELSIF (   nuordencert IS NOT NULL
                                       OR nuordencert > 0)
                                THEN
                                    pkg_Traza.Trace (
                                           'ingresa por orden de certificacion-->'
                                        || nuordencert,
                                        10);

                                    --de acuerdo al tipo de trabajo se obtiene el grupo de datos que debera consultar para obtener los datos adicionales
                                    OPEN cugruposdatos (nutipotrabce);

                                    FETCH cugruposdatos INTO sbgrupodato;

                                    CLOSE cugruposdatos;

                                    /*sbGrupoDato := GE_BOEQUIVALENCVALUES.FSBGETTARGETVALUENOEXCEP(3,
                                    nutipotrabce);*/
                                    pkg_Traza.Trace (
                                        'sbGrupoDato-->' || sbgrupodato,
                                        10);
                                    sbMedidorAd :=
                                        FnugetValorOTbyDatAdd (
                                            nutipotrabce,
                                            11215,
                                            'SERIE_MEDIDOR',
                                            nuordencert);
                                    pkg_Traza.Trace (
                                        'sbMedidorAd-->' || sbMedidorAd,
                                        10);
                                    --NC992:se elimina, porque ya no se debe comparar
                                    /*sbPresionAd := FnugetValorOTbyDatAdd(nutipotrabce,
                                                       11215,
                                                       'PRESION_DINAMICA',
                                                       nuordencert);

                                    pkg_Traza.Trace('sbPresionAd-->'||sbpresionad,10);  */
                                    nuordenorig := nuordencert;
                                    nuTipoTrabOrig := nuTipoTrabCe;
                                END IF;       --si OT de apoyo o certificacion

                                sbMedidorAt :=
                                    or_boinstanceactivities.fsbGetAttributeValue (
                                        'INSTALAR_UTILITIES',
                                        nuactivid);
                                pkg_Traza.Trace (
                                    'sbMedidorAt-->' || sbmedidorat,
                                    10);

                                --NC992:se elimina, porque ya no se debe comparar
                                /*sbPresionAt := or_boinstanceactivities.fsbGetAttributeValue('RES_PROD_PRESSURE',nuactivid);
                                pkg_Traza.Trace('sbPresionAt-->'||sbpresionat,10); */
                                --NC707
                                IF (sbmedidorad IS NOT NULL)
                                THEN
                                    IF (REPLACE (UPPER (sbMedidorAd),
                                                 ' ',
                                                 '') <>
                                        REPLACE (UPPER (sbmedidorat),
                                                 ' ',
                                                 ''))
                                    THEN
                                        nuretorno := 0;
                                        --NC746: retorno atributo con diferencias
                                        sbAtributoDif := 'SERIE_MEDIDOR';
                                    ELSE
                                        nuRetorno := 1;
                                    END IF;
                                END IF;

                                pkg_Traza.Trace (
                                    'nuRetorno-medidor-->' || nuretorno,
                                    10);

                                IF (nuretorno = 1)
                                THEN
                                    nuRetorno :=
                                        ldc_boordenes.fnuComparaDatosAdicionales (
                                            nuOrdenO        => nuordenOrig,
                                            nuOrdenCxC      => nuOrdenCargo,
                                            nuOrdenInst     => nuOrdenInst,
                                            nuTipoTrabCa    => nuTipoTrabCa,
                                            nuTipoTrabO     => nuTipoTrabOrig,
                                            nutipotrabi     => nutipotrabi,
                                            sbgrupodato     => sbgrupodato,
                                            nuactivid       => nuactivid,
                                            sbatributodif   => sbatributodif);
                                END IF;

                                IF (nuretorno = 0)
                                THEN
                                    sbMensaje :=
                                           'Se presentan diferencias entre las cantidades legalizadas entre el certificador y el instalador en el valor del campo '
                                        || sbAtributoDif;
                                    RAISE EX_ERROR;
                                ELSIF (nuRetorno = -1)
                                THEN
                                    sbMensaje :=
                                        'Se presento una excepcion en el proceso';
                                    RAISE ex_error;
                                ELSIF (nuretorno = 1)
                                THEN
                                    --validar que la orden de CxC y de instalacion estan 8
                                    pkg_Traza.Trace (
                                        'nuSolicitud-->' || nusolicitud,
                                        10);
                                    pkg_Traza.Trace (
                                        'nuTipoTrabI-->' || nuTipoTrabI,
                                        10);
                                    pkg_Traza.Trace (
                                        'nuTipoTrabCa-->' || nutipotrabca,
                                        10);

                                    OPEN cucantotcerradas (nuSolicitud,
                                                           nuTipoTrabI,
                                                           nuTipoTrabCa,
                                                           nudir);

                                    FETCH cucantotcerradas
                                        INTO nuotCerradas;

                                    CLOSE cucantotcerradas;

                                    --NC746: para determinar la cantidad de OT (cxc y/o instalacion) asociadas a la solicitud
                                    OPEN cucantotsol (nuSolicitud, nudir);

                                    FETCH cucantotsol INTO nucantot;

                                    CLOSE cucantotsol;
 
                                    pkg_Traza.Trace (
                                        'cucantotcerradas-->' || nuotcerradas,
                                        10);
                                    pkg_Traza.Trace (
                                        'cucantotsol-->' || nucantot,
                                        10);
                                    pkg_Traza.Trace (
                                        'nuordinstance-->' || nuordinstance,
                                        10);

                                    --NC 746:evalua la cantidad de OT cerradas con la cantidad de OT de solicitud -1, a fin que sea
                                    --la ultima que se esta legalizando
                                    IF (nuotcerradas = (nucantot - 1))
                                    THEN
                                        --INICIO RNP 44 GES
                                        IF SBCREAR_ITEM_AUTO = 'S'
                                        THEN
                                            ldc_boordenes.procreaitemspago (
                                                nuordinstance);
                                        END IF;
                                    --FIN RNP 44 GES
                                    --ldc_boordenes.procreaitemspago(nuordinstance);
                                    END IF;
                                END IF;
                            END IF;
                        ELSE
                            --CAUSAL_CERTIFI_TERCER
                            pkg_Traza.Trace (
                                   'CAUSAL CLIENTE CERTIFICA TERCERO -->'
                                || NUCAUSAL_CLIEN_CERTI_TERCER,
                                10);
                            DBMS_OUTPUT.PUT_LINE (
                                   'CAUSAL CLIENTE CERTIFICA TERCERO -->'
                                || NUCAUSAL_CLIEN_CERTI_TERCER);

                            IF     SBCREAR_ITEM_AUTO = 'S'
                               AND NUCAUSAL_CLIEN_CERTI_TERCER = nucausalc
                            THEN
                                ldc_boordenes.procreaitemspago (
                                    nuordinstance);
                            END IF;
                        --fin NC3581 permitir adicionar items automatica a la certificacion con causal 3333 - CLIENTE REALIZA CERTIFICACION CON TERCERO
                        END IF;                  --valida si hay certificacion
                    --Aranda XXXXX
                    ELSE
                        --validar que la orden de CxC y de instalacion estan 8
                        pkg_Traza.Trace ('nuSolicitud-->' || nusolicitud, 10);
                        pkg_Traza.Trace ('nuTipoTrabI-->' || nuTipoTrabI, 10);
                        pkg_Traza.Trace ('nuTipoTrabCa-->' || nutipotrabca,
                                         10);

                        OPEN cucantotcerradas (nuSolicitud,
                                               nuTipoTrabI,
                                               nuTipoTrabCa,
                                               nudir);

                        FETCH cucantotcerradas INTO nuotCerradas;

                        CLOSE cucantotcerradas;

                        --NC746: para determinar la cantidad de OT (cxc y/o instalacion) asociadas a la solicitud
                        OPEN cucantotsol (nuSolicitud, nudir);

                        FETCH cucantotsol INTO nucantot;

                        CLOSE cucantotsol;

                        pkg_Traza.Trace (
                            'cucantotcerradas-->' || nuotcerradas,
                            10);
                        pkg_Traza.Trace ('cucantotsol-->' || nucantot, 10);
                        pkg_Traza.Trace ('nuordinstance-->' || nuordinstance,
                                         10);

                        --NC 746:evalua la cantidad de OT cerradas con la cantidad de OT de solicitud -1, a fin que sea
                        --la ultima que se esta legalizando
                        IF (nuotcerradas = (nucantot - 1))
                        THEN
                            --INICIO RNP 44 GES
                            IF SBCREAR_ITEM_AUTO = 'S'
                            THEN
                                ldc_boordenes.procreaitemspago (
                                    nuordinstance);
                            END IF;
                        --FIN RNP 44 GES
                        --ldc_boordenes.procreaitemspago(nuordinstance);
                        END IF;
                    --Fin Aranda XXXXXX
                    END IF;                       --validacion por causal 9091
                ELSE
                    sbmensaje :=
                        'No es posible legalizar. Aun no se ha certificado la instalacion';
                    RAISE ex_error;
                END IF;                           --si hay OT de certificacion
            END IF;                                         --si hay solicitud
        END IF;                                       --valida tipo de trabajo
    EXCEPTION
        WHEN EX_ERROR
        THEN
            GI_BOERRORS.SETERRORCODEARGUMENT (Ld_Boconstans.cnuGeneric_Error,
                                              sbMensaje);
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE;
    END proComparaCantCertInst;

    /*****************************************
    Metodo: fsbctrlasignacionordenxorcao
    Descripcion: Permite visualizar el proceso de Asignacion de ordenes en orcao
                 si el tipo de trabajo pertenece a la unidad de trabajo a la cual esta logueado el usuario en SF
    Autor: Alvaro Zapata
    Fecha: Abril 08/2013
     ******************************************/
    FUNCTION fsbctrlasignacionordenxorcao (sbtasktype IN VARCHAR2)
        RETURN VARCHAR2
    IS
        /*  sbPerson   VARCHAR2 (5) := NULL;
         sbPersonAO VARCHAR2 (5) := NULL;
         SBCADENA      VARCHAR2(4000);*/
        nuCantidad   NUMBER;
    BEGIN
        SELECT COUNT (1)
          INTO nucantidad
          FROM ldc_ge_clasifxao  ctt
               INNER JOIN or_task_type tt
                   ON ctt.task_type_id = tt.task_type_id
         WHERE     ctt.person_id = GE_BOPERSONAL.fnuGetPersonId
               AND TO_CHAR (ctt.task_type_id || ' - ' || tt.description) =
                   sbtasktype;

        IF (nucantidad > 0)
        THEN
            RETURN 1;
        END IF;

        SELECT COUNT (1)
          INTO nucantidad
          FROM ge_person p
         WHERE     p.person_id = GE_BOPERSONAL.fnuGetPersonId
               AND p.organizat_area_id IN
                       (SELECT ctt.organizat_area_id
                          FROM or_task_type  tt
                               INNER JOIN ldc_ge_clasifxao ctt
                                   ON tt.task_type_classif =
                                      ctt.task_type_classif
                         WHERE     UPPER (
                                       TO_CHAR (
                                              tt.task_type_id
                                           || ' - '
                                           || tt.description)) =
                                   sbtasktype
                               AND ctt.task_type_id IS NULL
                               AND ctt.person_id IS NULL);

        IF (nucantidad > 0)
        THEN
            RETURN 1;
        END IF;

        RETURN -1;
    END fsbctrlasignacionordenxorcao;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProUniConLocExecAmount
    Descripcion    : Consulta lo ejecutado de las unidades constructivas
                     agrupadas por ubicaci?n geogr?fica en el periodo
                     inicia y periodo final.
                     Obteniendo el valor de lo ejecutado y presupestado
                     de un periodo referente a un a?o y mes.
    Autor          : jvaliente
    Fecha          : 14/08/2012 SAO156931

    Parametros                  Descripcion
    ============            ===================
    inuInitialYear          a?o inicial
    inuInitialMonth         mes inicial
    inuFinalYear            a?o final
    inuFinalMonth           mes final
    inuRelevantMarketId     Codigo del Mercado Relevante
    orfConUniBudget         Registros ejecutado de unidades constrcutivas
                            agrupadas por ubicacion geografica

     Historia de Modificaciones
    Fecha             <Autor>.SAONNNNN             Modificacion
    =========         ================         ====================
    ******************************************************************/
    /*  FUNCTION FNUDIASATENCIONORDEN(IDTASSIGNED_DATE     IN OR_ORDER.ASSIGNED_DATE%TYPE,
                                       IDTLEGALIZATION_DATE IN OR_ORDER.LEGALIZATION_DATE%TYPE,
                                       INUDEPARTAMENTO      IN LDC_TMLOCALTTRA.DEPARTAMENTO%TYPE,
                                       INULOCALIDAD         IN LDC_TMLOCALTTRA.LOCALIDAD%TYPE,
                                       INUTIPOTRABAJO       IN LDC_TMLOCALTTRA.TIPOTRABAJO%TYPE,
                                       INUCAUSAL            IN LDC_TMLOCALTTRA.CAUSAL%TYPE,
                                       INUPROVEEDOR         IN LDC_TMLOCALTTRA.PROVEEDOR%TYPE,
                                       INUNUMERODIAS        OUT LDC_TMLOCALTTRA.TIEMPO%TYPE,
                                       INUPORCENTAJE        OUT LDC_TMLOCALTTRA.PORCENTAJE%TYPE,
                                       INUVALOR             OUT LDC_TMLOCALTTRA.VALOR%TYPE,
                                       INUDIAS              OUT NUMBER) is
    ) RETURN NUMBER IS
      BEGIN

        pkg_Traza.Trace('Inicio LD_BCExecutedBudge.ProConUniLocExecAmount', 10);

        OPEN orfConUniLocExecAmount FOR
          SELECT \*+ USE_NL(LDC LDR) *\
           Geograp_Location_Id GeograpLocationId,
           dage_geogra_location.fsbGetDescription(Geograp_Location_Id) DescriptionGeograpLocation,
           SUM(Amount_executed) Executed,
           SUM(Amount) Budget,
           SUM(Amount) - SUM(Amount_executed) Difference,
           round(decode(SUM(Amount),
                        0,
                        0,
                        decode(SUM(Amount_executed),
                               0,
                               0,
                               (SUM(Amount_executed) * 100) / SUM(Amount))),
                 2) Percentage,
           round(decode(SUM(value_executed),
                        0,
                        0,
                        decode(SUM(Amount_executed),
                               0,
                               0,
                               ((SUM(value_executed) / SUM(Amount_executed)) / 1000))),
                 0) ExecutedUnitCost,
                        decode(SUM(value_budget_cop),
           round(decode(SUM(amount),
                        0,
                        0,
                               0,
                               0,
                               ((SUM(value_budget_cop) / SUM(amount)) / 1000))),
                 0) BudgetUnitCost
            FROM LD_Con_Uni_Budget LDC, LD_Rel_Mark_Budget LDR
           WHERE LDC.Rel_Mark_Budget_ID = LDR.Rel_Mark_Budget_ID
             AND LDC.AMOUNT > 0
             AND LDC.VALUE_BUDGET_COP > 0
             AND LDR.Relevant_Market_ID = inuRelevantMarketId
             AND LDR.Year * 100 + LDR.Month >=
                 inuInitialYear * 100 + inuInitialMonth
             AND LDR.Year * 100 + LDR.Month <=
                 inuFinalYear * 100 + inuFinalMonth
           GROUP BY Geograp_Location_Id,
                    dage_geogra_location.fsbGetDescription(Geograp_Location_Id)
           ORDER BY Geograp_Location_Id,
                    dage_geogra_location.fsbGetDescription(Geograp_Location_Id);

        pkg_Traza.Trace('Fin LD_BCExecutedBudge.ProConUniLocExecAmount', 10);

      EXCEPTION
        when pkg_Error.CONTROLLED_ERROR then
          raise pkg_Error.CONTROLLED_ERROR;
        when others then
          pkg_Error.setError;
          raise pkg_Error.CONTROLLED_ERROR;

      END FNUDIASATENCIONORDEN;*/
    /*****************************************
    Metodo: fsbApliMalaAsesoria
    Descripcion: Indica si a la orden que se encuentra en la instancia le aplica
                 novedad por mala asesoria. Para lo cual debe cumplir:
                 1. Orden de trabajo de tipo APLICA ANULACION VENTA
                 2. Legalizada con causal de exito - 3069
                 3. Tener el dato adicional CAUSA_REAL_ANULACION con valor 3. MALA ASESORIA
                 4. No tener una multa por el mismo motivo asociado a la solicitud de venta

    Parametros: nuorder_id: numero de orden de la instancia

    Autor: Luz Andrea Angel/OLSoftware
    Fecha: Abril 30/2013

    Historial de Modificaciones
    =========================================================================
       Fecha                Autor              Descripcion
    14-01-2014           Sayra Ocoro         Se modifica la logica del metodo para solucionar la NC 2459
    15-01-2014           Sergio Mejia        Se modifica para que valide la existencia de causal "Mala Asesoria" teniendo en cuenta
                                             la causal asociada a la solicitud de anulacion/devolucion(en MO_MOTIVE).
    17-01-2014           Sayra Ocoro         Se modifica la logica del metodo para solucionar la NC 2459_2
     ******************************************/
    FUNCTION fsbaplimalaasesoria (nuorder_id IN or_order.order_id%TYPE)
        RETURN VARCHAR2
    IS
        --obtiene el tipo de trabajo de la orden que esta en la instancia
        /*cursor cutipotrabajo(nuorder or_order.order_id%type) is
        select task_type_id, causal_id
          from or_order
         where order_id = nuOrder;*/
        --obtiene la solicitud de anulacion/devolucion de la orden de la instancia
        CURSOR cuSolicitudOrden (nuorder or_order.order_id%TYPE)
        IS
            SELECT package_id
              FROM or_order_activity
             WHERE order_id = nuOrder;

        --obtiene la solicitud de venta asociada a la solicitud anulacion/devolucion
        CURSOR cusolicitudvta (nusolorden or_order_activity.package_id%TYPE)
        IS
            SELECT package_id_asso
              FROM mo_packages_asso
             WHERE PACKAGE_ID = nusolorden;

        CURSOR cuordennovedad (
            nusolicitud      or_order_activity.package_id%TYPE,
            numalaasesoria   or_order_activity.activity_id%TYPE)
        IS
            SELECT a.order_id
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.package_id = nusolicitud
                   AND a.activity_id = numalaasesoria
                   AND b.order_status_id = 8;

        nuaplicaanulavta             NUMBER;
        nucausalaplicaanula          NUMBER;
        nuMalaAsesoria               NUMBER;
        -- Para validar existencia de causal "Mala Asesoria". 1 = SI, 2 = NO
        nuExisteCausalMalaAsesoria   NUMBER := 2;
        nutipotrabajo                or_order.task_type_id%TYPE;
        nusolicitud                  or_order_activity.package_id%TYPE;
        nusolicitudvta               or_order_activity.package_id%TYPE;
        nucausal                     ge_causal.causal_id%TYPE;
        nuOrdenNovedad               or_order.order_id%TYPE;
        sbvalorcausa                 VARCHAR2 (400);
        sbAplica                     VARCHAR2 (1) := 'N';
    BEGIN
        pkg_Traza.Trace ('INICIO LDC_BOOrdenes.fsbaplimalaasesoria', 10);
        nuaplicaanulavta :=
            dald_parameter.fnugetnumeric_value (
                'COD_APLICA_ANULA_VTA_TIPO_TRAB',
                NULL);                                                 --10145
        pkg_Traza.Trace (
               'EJECUCION LDC_BOOrdenes.fsbaplimalaasesoria nuaplicaanulavta => '
            || nuaplicaanulavta,
            11);
        nucausalaplicaanula :=
            dald_parameter.fnugetnumeric_value ('COD_CAUSAL_APRUEBA_ANULA',
                                                NULL);                  --3069
        pkg_Traza.Trace (
               'EJECUCION LDC_BOOrdenes.fsbaplimalaasesoria nucausalaplicaanula => '
            || nucausalaplicaanula,
            11);
        nuMalaAsesoria :=
            dald_parameter.fnugetnumeric_value ('COD_ITEM_MALA_ASESORIA_FNB',
                                                NULL);               --4294776
        pkg_Traza.Trace (
               'EJECUCION LDC_BOOrdenes.fsbaplimalaasesoria nuMalaAsesoria => '
            || nuMalaAsesoria,
            11);
        --obtiene el tipo de trabajo de la orden de la instancia
        /* open cutipotrabajo(nuorder_id);
        FETCH cutipotrabajo
          into nuTipoTrabajo, nucausal;
        close cutipotrabajo;*/
        nuTipoTrabajo := daor_order.fnugettask_type_id (nuorder_id);
        pkg_Traza.Trace (
               'EJECUCION LDC_BOOrdenes.fsbaplimalaasesoria nuTipoTrabajo => '
            || nuTipoTrabajo,
            11);
        nucausal := daor_order.fnugetcausal_id (nuorder_id);
        pkg_Traza.Trace (
               'EJECUCION LDC_BOOrdenes.fsbaplimalaasesoria nucausal => '
            || nucausal,
            11);

        IF (nutipotrabajo IS NOT NULL OR nutipotrabajo > 0)
        THEN
            --si trabajo es 10145 aplica anulacion de la venta y tiene la causal de exito 3069
            IF (    (nutipotrabajo = nuaplicaanulavta)
                AND (nucausal = nucausalaplicaanula))
            THEN
                --obtener el dato adicional Causa_Real_Anulacion  = 3.mala asesoria
                --grupo 10107 Datos Leg. Aceptac. Anul.
                /*sbValorCausa := ldc_boordenes.FnugetValorOTbyDatAdd(nutipotrabajo,
                                                                    10107,
                                                                    'CAUSA_REAL_ANULACION',
                                                                    nuorder_id);

                --valida que la causa sea Mala Asesoria
                if (sbValorCausa = '3. MALA ASESORIA') then*/
                /* Consulta la existencia de causal "Mala Asesoria" en las causales
                  asociadas a la solicitud de anulacion/devolucion
                */
                BEGIN
                    SELECT 1
                      INTO nuExisteCausalMalaAsesoria
                      FROM mo_motive m, or_order_activity a
                     WHERE     a.PACKAGE_id = m.package_id
                           AND m.causal_id = 211                         --137
                           AND a.ORDER_id = nuorder_id
                           AND ROWNUM = 1;
                EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                        nuExisteCausalMalaAsesoria := 2;
                END;

                pkg_Traza.Trace (
                       'EJECUCION LDC_BOOrdenes.fsbaplimalaasesoria nuExisteCausalMalaAsesoria => '
                    || nuExisteCausalMalaAsesoria,
                    11);

                --valida la existencia de causal "Mala Asesoria". 1 = SI, 2 = NO
                IF nuExisteCausalMalaAsesoria = 1
                THEN
                    --obtiene la solicitud asociada a la orden de la instancia
                    OPEN cuSolicitudOrden (nuorder_id);

                    FETCH cuSolicitudOrden INTO nuSolicitud;

                    CLOSE cuSolicitudOrden;

                    pkg_Traza.Trace (
                           'EJECUCION LDC_BOOrdenes.fsbaplimalaasesoria nuSolicitud => '
                        || nuSolicitud,
                        11);

                    IF (nusolicitud IS NOT NULL OR nusolicitud > 0)
                    THEN
                        --obtiene la solicitud de venta asociada a la solicitud de la orden de la instancia
                        OPEN cusolicitudvta (nusolicitud);

                        FETCH cusolicitudvta INTO nuSolicitudVta;

                        CLOSE cusolicitudvta;

                        pkg_Traza.Trace (
                               'EJECUCION LDC_BOOrdenes.fsbaplimalaasesoria nuSolicitudVta => '
                            || nuSolicitudVta,
                            11);

                        IF (nusolicitudvta IS NOT NULL OR nusolicitudvta > 0)
                        THEN
                            OPEN cuordennovedad (nusolicitud, nuMalaAsesoria);

                            FETCH cuordennovedad INTO nuOrdenNovedad;

                            CLOSE cuordennovedad;

                            pkg_Traza.Trace (
                                   'EJECUCION LDC_BOOrdenes.fsbaplimalaasesoria nuOrdenNovedad 1 => '
                                || nuOrdenNovedad,
                                11);

                            IF (nuordennovedad IS NULL)
                            THEN
                                OPEN cuordennovedad (nuSolicitudVta,
                                                     nuMalaAsesoria);

                                FETCH cuordennovedad INTO nuordennovedad;

                                CLOSE cuordennovedad;
                            END IF;

                            pkg_Traza.Trace (
                                   'EJECUCION LDC_BOOrdenes.fsbaplimalaasesoria nuOrdenNovedad 2 => '
                                || nuOrdenNovedad,
                                11);

                            IF (nuordennovedad IS NULL)
                            THEN
                                sbAplica := 'S';
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;

        pkg_Traza.Trace (
               'EJECUCION LDC_BOOrdenes.fsbaplimalaasesoria sbAplica => '
            || sbAplica,
            11);
        pkg_Traza.Trace ('FIN LDC_BOOrdenes.fsbaplimalaasesoria', 10);
        RETURN sbAplica;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN NULL;
    END fsbApliMalaAsesoria;

    FUNCTION fsbexcluirotxvaliddoc (nuorder_id IN or_order.order_id%TYPE)
        /*****************************************
         Metodo: fsbexcluirotxvaliddoc
         Descripcion: Indica si se debe excluir la orden que se encuentra en la instancia, si cumple con:
                      1.si se trata de entrega o devolucion de articulos no debe tener asociada OT de comision
                      2.Para el resto de trabajos deberia tener OT de comision
                      3.validar que la OT de Revision de Documentos esta 5-asignada, causal diferente a documentos en regla

        Parametros: nuorder_id: numero de orden de la instancia

        Autor: Luz Andrea Angel/OLSoftware
         Fecha: Mayo 2/2013

        Fecha                IDEntrega           Modificacion
         ============    ================    ============================================
         24-09-2013        luzangel           NC871: Se ajusta logica, ya que siempre va a tener orden de comision sin improtar el
                                              tipo de trabajo
         19-11-2013        luzangel           NC1586: Se ingresan los tipos de trabajo PAGO DE ARTICULO A PROVEEDOR,COBRO AL PROVEEDOR POR ARTICULO DEVUELTO,
                                              COBRO COMISION A PROVEEDOR, PAGO AL PROVEEDOR POR COMISION COBRADA para validacion y se ajusta la logica para
                                              que tenga en cuenta cuando debe excluir la ot de la instancia si la ot de revision de documentos no se ha legalizado
         06-12-2013        alvzapata          NC 1564: Ajustes a la funcion para excluir tipos de trabajo en la liquidacion cuando no se ha legalizado el TT
                                              10130 (REVISION DE DOCUMENTOS - FNB)

         ******************************************/
        RETURN VARCHAR
    IS
        CURSOR cuordeninstancia (nuorden or_order.order_id%TYPE)
        IS
            SELECT task_type_id, operating_unit_id
              FROM or_order
             WHERE order_id = nuorden;

        CURSOR cuordencomision (nusolicitud   mo_packages.package_id%TYPE,
                                nucobrocomi   or_task_type.task_type_id%TYPE,
                                nupagocomi    or_task_type.task_type_id%TYPE)
        IS
            SELECT a.order_id
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.package_id = nusolicitud
                   AND a.task_type_id IN (nuCobroComi, nupagocomi);

        CURSOR cuordendocumentos (
            nusolicitud    mo_packages.package_id%TYPE,
            nuttrevision   or_task_type.task_type_id%TYPE)
        IS
            SELECT a.order_id, b.order_status_id, b.causal_id
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.package_id = nusolicitud
                   AND a.task_type_id IN (nuttrevision);

        nuttentregart             NUMBER;
        nuttdevart                NUMBER;
        nuttcobrocomipag          NUMBER;
        nuttpagocomi              NUMBER;
        nucausadocregla           NUMBER;
        sbsolvta                  VARCHAR2 (400);
        sbExcluir                 VARCHAR2 (1) := 'N';
        nutipotrabajo             or_order.task_type_id%TYPE;
        nuttValidDoc              or_order.task_type_id%TYPE;
        nusolicitud               mo_packages.package_id%TYPE;
        nusolicitudvta            mo_packages.package_id%TYPE;
        nuordencomi               or_order.order_id%TYPE;
        nuordenrev                or_order.order_id%TYPE;
        nuestado                  or_order.order_status_id%TYPE;
        nucausal                  or_order.causal_id%TYPE;
        nuttpagoartprov           NUMBER;
        nuttcobrocomiprov         NUMBER;
        nuttcobroprovartdev       NUMBER;
        nuttpagoprovcomicobrada   NUMBER;
        nupuntovta                mo_packages.pos_oper_unit_id%TYPE;
        nuunidadoper              or_order.operating_unit_id%TYPE;
    BEGIN
        pkg_Traza.Trace ('Inicio fsbexcluirotxvaliddoc', 10);
        nuttentregart :=
            dald_parameter.fnugetnumeric_value (
                'COD_ENTREGA_ART_FNB_TIPO_TRAB',
                NULL);
        nuttdevart :=
            dald_parameter.fnugetnumeric_value ('COD_ANULA_FNB_TIPO_TRAB',
                                                NULL);
        nuttcobrocomipag :=
            dald_parameter.fnugetnumeric_value (
                'COD_COBRO_CONTRA_COMI_PAG_FNB',
                NULL);                                                 --10138
        nuttpagocomi :=
            dald_parameter.fnugetnumeric_value ('COD_PAGO_COMI_CONT_TT_FNB',
                                                NULL);                 --10136
        nucausadocregla :=
            dald_parameter.fnugetnumeric_value ('REVIEW_CAUSAL', NULL);
        nuttvaliddoc :=
            dald_parameter.fnugetnumeric_value (
                'COD_REVISA_DOC_FNB_TIPO_TRAB',
                NULL);                                                 --10130
        nuttpagoartprov :=
            dald_parameter.fnugetnumeric_value (
                'COD_PAGO_ARTIC_PROVEED_TT_FNB',
                NULL);                                                 --10144
        nuttcobrocomiprov :=
            dald_parameter.fnugetnumeric_value (
                'COD_COBRO_COMI_PROVEED_TT_FNB',
                NULL);                                                 --10137
        nuttcobroprovartdev :=
            dald_parameter.fnugetnumeric_value (
                'COD_COBRO_PROV_ARTI_DEV_TT_FNB',
                NULL);                                                 --10140
        nuttpagoprovcomicobrada :=
            dald_parameter.fnugetnumeric_value (
                'COD_PAGO_PROV_COMI_COBRADA_FNB',
                NULL);                                                 --10139
        /*
        10144    PAGO DE ARTICULO A PROVEEDOR - FNB // COD_PAGO_ARTIC_PROVEED_TT_FNB
        10137    COBRO COMISION A PROVEEDOR - FNB // COD_COBRO_COMI_PROVEED_TT_FNB
        10140    COBRO AL PROVEEDOR POR ARTICULO DEVUELTO - FNB // COD_COBRO_PROV_ARTI_DEV_TT_FNB
        10139    PAGO AL PROVEEDOR POR COMISION COBRADA - FNB // COD_PAGO_PROV_COMI_COBRADA_FNB
        select *
        from or_operating_unit
        WHERE oper_unit_classif_id = 71
        */
        pkg_Traza.Trace ('orden instancia-->' || nuorder_id, 10);

        OPEN cuordeninstancia (nuorder_id);

        FETCH cuordeninstancia INTO nutipotrabajo, nuunidadoper;

        CLOSE cuordeninstancia;

        pkg_Traza.Trace ('nutipotrabajo-->' || nutipotrabajo, 10);

        --valida que haya encontrado tipo de trabajo
        IF (nutipotrabajo IS NOT NULL AND nutipotrabajo > 0)
        THEN
            --obtiene la solicitud de la orden
            nusolicitud :=
                or_bcorderactivities.fnugetpackidinfirstact (nuorder_id);
            pkg_Traza.Trace ('nusolicitud-->' || nusolicitud, 10);

            --si el tipo de trabajo corresponde a una anulacion la solicitud asociada a la orden es la de anulacion
            --por lo que debera obtener la solucitud de venta
            IF (   nutipotrabajo = nuttcobroprovartdev
                OR nutipotrabajo = nuttcobrocomipag
                OR nutipotrabajo = nuttpagoprovcomicobrada)
            THEN
                sbsolvta :=
                    ldc_boutilities.fsbgetvalorcampotabla (
                        'MO_PACKAGES_ASSO',
                        'PACKAGE_ID',
                        'PACKAGE_ID_ASSO',
                        nusolicitud);
                pkg_Traza.Trace ('sbsolvta-->' || sbsolvta, 10);
                nusolicitudVta := UT_CONVERT.FNUCHARTONUMBER (sbSolVta);
            ELSE
                nusolicitudvta := nusolicitud;
            END IF;

            pkg_Traza.Trace ('nusolicitudvta-->' || nusolicitudvta, 10);

            --obtener la orden de revision de documentos
            OPEN cuordendocumentos (nusolicitudvta, nuttvaliddoc);

            FETCH cuordendocumentos INTO nuordenRev, nuEstado, nuCausal;

            CLOSE cuordendocumentos;

            pkg_Traza.Trace ('otdocumentos-nuordenRev-->' || nuordenRev, 10);
            pkg_Traza.Trace ('otdocumentos-nuEstado-->' || nuEstado, 10);
            pkg_Traza.Trace ('otdocumentos-nuCausal-->' || nuCausal, 10);

            --Valida Contratista PAP
            IF (   nutipotrabajo = nuttcobrocomipag
                OR nutipotrabajo = nuttpagocomi)
            THEN
                IF (nuestado = 0 OR nuestado = 5)
                THEN
                    sbexcluir := 'S';
                END IF;
            ELSE
                --obtiene el punto de venta asociado a la solicitud
                nuPuntoVta :=
                    TO_NUMBER (ldc_boutilities.fsbgetvalorcampotabla (
                                   'MO_PACKAGES',
                                   'PACKAGE_ID',
                                   'POS_OPER_UNIT_ID',
                                   nusolicitudvta));

                --Valida Proveedor Punto Fijo
                IF (nuunidadoper = nupuntovta)
                THEN
                    --se agrega la condicion de causal de fallo
                    IF (nuestado = 0 OR nuestado = 5)
                    THEN
                        IF nutipotrabajo IN (nuttpagoartprov,
                                             nuttcobrocomiprov,
                                             nuttcobroprovartdev,
                                             nuttpagoprovcomicobrada)
                        THEN
                            sbexcluir := 'S';
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;

        pkg_Traza.Trace ('sbExcluir-->' || sbExcluir, 10);
        pkg_Traza.Trace ('Fin fsbexcluirotxvaliddoc', 10);
        RETURN sbExcluir;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN NULL;
    END fsbexcluirotxvaliddoc;

    FUNCTION fsbexcluirotxvaliddocperiodo (
        nuorder_id       IN or_order.order_id%TYPE,
        idafechainicio   IN DATE,
        idafechafin      IN DATE)
        /*****************************************
         Metodo: fsbexcluirotxvaliddocperiodo
         Descripcion: Indica si se debe excluir la orden que se encuentra en la instancia, si cumple con:
                      1.si se trata de entrega o devolucion de articulos no debe tener asociada OT de comision
                      2.Para el resto de trabajos deberia tener OT de comision
                      3.validar que la OT de Revision de Documentos esta 5-asignada, causal diferente a documentos en regla
                      4.valida si la revision de documento se encuentra legalizada con una causal de exito y su fecha de legalizacion
                      no se encuentra dentro de la fecha (inicio y final) que se esta liquidando
                      5.valida si fue legaliza con una causal de fallo

        Parametros: nuorder_id: numero de orden de la instancia
                     idafechainicio: fecha inicial de la liquidacion
                     idafechafin: fecha final de la liquidacion

        Autor: Harold Altamiranda
         Fecha: 22-04-2015

        Fecha           IDEntrega           Modificacion
         ============    ================    ============================================
         22-04-2015      HAltamiranda        Creacion
         28-01-2018      STapias.REQ 2001634 se agrega exclusion para tipo de trabajo
                                            [cobro de comision por publicidad] solo aplica EFG
         12-06-2018      josdon             Caso 200-1961 Modificación de Regla de Exclusión Cardif.
                                           Se modifica para que realice la Exclusión si la orden de aprobación no está legalizada
                                           para las unidades operativas diferentes a las parametrizadas en LDC_UNIDCARDIF
          ******************************************/
        RETURN VARCHAR
    IS
        CURSOR cuordeninstancia (nuorden or_order.order_id%TYPE)
        IS
            SELECT task_type_id, operating_unit_id
              FROM or_order
             WHERE order_id = nuorden;

        CURSOR cuordencomision (nusolicitud   mo_packages.package_id%TYPE,
                                nucobrocomi   or_task_type.task_type_id%TYPE,
                                nupagocomi    or_task_type.task_type_id%TYPE)
        IS
            SELECT a.order_id
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.package_id = nusolicitud
                   AND a.task_type_id IN (nuCobroComi, nupagocomi);

        CURSOR cuordendocumentos (
            nusolicitud    mo_packages.package_id%TYPE,
            nuttrevision   or_task_type.task_type_id%TYPE)
        IS
            SELECT a.order_id, b.order_status_id, b.causal_id
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.package_id = nusolicitud
                   AND a.task_type_id IN (nuttrevision);

        CURSOR cucausalfallo (nuordenRev        or_order.order_id%TYPE,
                              nuorderstatusid   NUMBER,
                              nutipocausal      NUMBER)
        IS
            SELECT COUNT (1)     valor
              FROM or_order o, GE_CAUSAL gc
             WHERE     o.order_id = nuordenRev
                   AND o.causal_id = gc.causal_id
                   AND o.order_status_id = nuorderstatusid
                   AND gc.causal_type_id = nutipocausal;

        CURSOR cufechalegcausalexito (nuordenRev        or_order.order_id%TYPE,
                                      nufechainicial    DATE,
                                      nufechafinal      DATE,
                                      nuorderstatusid   NUMBER,
                                      nutipocausal      NUMBER)
        IS
            SELECT COUNT (1)     valor
              FROM or_order o, GE_CAUSAL gc
             WHERE     o.order_id = nuordenRev
                   AND o.causal_id = gc.causal_id
                   AND o.order_status_id = nuorderstatusid
                   --AND nufechainicial <= o.legalization_date --TICKET 2001477 LJLB -- se quita filtro de fecha de legacion menor a la fecha inicial del acta
                   AND nufechafinal >= o.legalization_date
                   AND gc.causal_type_id <> nutipocausal;

        nuttentregart                NUMBER;
        nuttdevart                   NUMBER;
        nuttcobrocomipag             NUMBER;
        nuttpagocomi                 NUMBER;
        nucausadocregla              NUMBER;
        sbsolvta                     VARCHAR2 (400);
        sbExcluir                    VARCHAR2 (1) := 'N';
        nutipotrabajo                or_order.task_type_id%TYPE;
        nuttValidDoc                 or_order.task_type_id%TYPE;
        nusolicitud                  mo_packages.package_id%TYPE;
        nusolicitudvta               mo_packages.package_id%TYPE;
        nuordencomi                  or_order.order_id%TYPE;
        nuordenrev                   or_order.order_id%TYPE;
        nuestado                     or_order.order_status_id%TYPE;
        nucausal                     or_order.causal_id%TYPE;
        nuttpagoartprov              NUMBER;
        nuttcobrocomiprov            NUMBER;
        ----------------------
        -- REQ.2001634 -->
        -- Variables
        ----------------------
        nuttcobrocomipubli           NUMBER;
        
        ----------------------
        -- REQ.2001634 <--
        ----------------------
        nuttcobroprovartdev          NUMBER;
        nuttpagoprovcomicobrada      NUMBER;
        nupuntovta                   mo_packages.pos_oper_unit_id%TYPE;
        nuunidadoper                 or_order.operating_unit_id%TYPE;
        --variables utilizadas para la validacion de la causal de fallo
        nucausalfallo                NUMBER := 0;
        nufechalegalizacion          NUMBER := 0;
        nutipocausalfallofnb         NUMBER;
        sbflagfechaliqcausalfallo    VARCHAR (1);
        nuestadoordencerrada         NUMBER;
        nucausalexito                NUMBER;
    BEGIN
        pkg_Traza.Trace ('Inicio fsbexcluirotxvaliddocperiodo', 10);
        pkg_Traza.Trace ('idafechainicio-->' || idafechainicio, 10);
        pkg_Traza.Trace ('idafechafin-->' || idafechafin, 10);
        nuttentregart :=
            dald_parameter.fnugetnumeric_value (
                'COD_ENTREGA_ART_FNB_TIPO_TRAB',
                NULL);
        nuttdevart :=
            dald_parameter.fnugetnumeric_value ('COD_ANULA_FNB_TIPO_TRAB',
                                                NULL);
        nuttcobrocomipag :=
            dald_parameter.fnugetnumeric_value (
                'COD_COBRO_CONTRA_COMI_PAG_FNB',
                NULL);                                                 --10138
        nuttpagocomi :=
            dald_parameter.fnugetnumeric_value ('COD_PAGO_COMI_CONT_TT_FNB',
                                                NULL);                 --10136
        nucausadocregla :=
            dald_parameter.fnugetnumeric_value ('REVIEW_CAUSAL', NULL);
        nuttvaliddoc :=
            dald_parameter.fnugetnumeric_value (
                'COD_REVISA_DOC_FNB_TIPO_TRAB',
                NULL);                                                 --10130
        nuttpagoartprov :=
            dald_parameter.fnugetnumeric_value (
                'COD_PAGO_ARTIC_PROVEED_TT_FNB',
                NULL);                                                 --10144
        nuttcobrocomiprov :=
            dald_parameter.fnugetnumeric_value (
                'COD_COBRO_COMI_PROVEED_TT_FNB',
                NULL);                                                 --10137
        ---------------------------
        -- STapias.REQ 2001634 -->
        ---------------------------
        nuttcobrocomipubli :=
            dald_parameter.fnugetnumeric_value (
                'COD_COBRO_COMI_PUBLICD_TT_FNB',
                NULL);                                                 --10682
        ---------------------------
        -- STapias.REQ 2001634 <--
        ---------------------------
        nuttcobroprovartdev :=
            dald_parameter.fnugetnumeric_value (
                'COD_COBRO_PROV_ARTI_DEV_TT_FNB',
                NULL);                                                 --10140
        nuttpagoprovcomicobrada :=
            dald_parameter.fnugetnumeric_value (
                'COD_PAGO_PROV_COMI_COBRADA_FNB',
                NULL);                                                 --10139
        nutipocausalfallofnb :=
            dald_parameter.fnugetnumeric_value ('TIPO_CAUSAL_FALLO_FNB',
                                                NULL);
        sbflagfechaliqcausalfallo :=
            dald_parameter.fsbgetvalue_chain (
                'FLAG_REXCLUSION_FLEGACFALLOFNB',
                NULL);
        nuestadoordencerrada :=
            dald_parameter.fnugetnumeric_value ('NUM_ORDER_STATE', NULL);  --8
        nucausalexito :=
            dald_parameter.fnugetnumeric_value ('LDC_CAUSAL_EXITO', NULL); --1
        pkg_Traza.Trace ('orden instancia-->' || nuorder_id, 10);

        OPEN cuordeninstancia (nuorder_id);

        FETCH cuordeninstancia INTO nutipotrabajo, nuunidadoper;

        CLOSE cuordeninstancia;

        pkg_Traza.Trace ('nutipotrabajo-->' || nutipotrabajo, 10);

        --valida que haya encontrado tipo de trabajo
        IF (nutipotrabajo IS NOT NULL AND nutipotrabajo > 0)
        THEN
            --obtiene la solicitud de la orden
            nusolicitud :=
                or_bcorderactivities.fnugetpackidinfirstact (nuorder_id);
            pkg_Traza.Trace ('nusolicitud-->' || nusolicitud, 10);

            --si el tipo de trabajo corresponde a una anulacion la solicitud asociada a la orden es la de anulacion
            --por lo que debera obtener la solucitud de venta
            IF (   nutipotrabajo = nuttcobroprovartdev
                OR nutipotrabajo = nuttcobrocomipag
                OR nutipotrabajo = nuttpagoprovcomicobrada)
            THEN
                sbsolvta :=
                    ldc_boutilities.fsbgetvalorcampotabla (
                        'MO_PACKAGES_ASSO',
                        'PACKAGE_ID',
                        'PACKAGE_ID_ASSO',
                        nusolicitud);
                pkg_Traza.Trace ('sbsolvta-->' || sbsolvta, 10);
                nusolicitudVta := UT_CONVERT.FNUCHARTONUMBER (sbSolVta);
            ELSE
                nusolicitudvta := nusolicitud;
            END IF;

            pkg_Traza.Trace ('nusolicitudvta-->' || nusolicitudvta, 10);

            --obtener la orden de revision de documentos
            OPEN cuordendocumentos (nusolicitudvta, nuttvaliddoc);

            FETCH cuordendocumentos INTO nuordenRev, nuEstado, nuCausal;

            CLOSE cuordendocumentos;

            pkg_Traza.Trace ('otdocumentos-nuordenRev-->' || nuordenRev, 10);
            pkg_Traza.Trace ('otdocumentos-nuEstado-->' || nuEstado, 10);
            pkg_Traza.Trace ('otdocumentos-nuCausal-->' || nuCausal, 10);

            --validar si la orden fue legaliza con causal de fallo
            IF     sbflagfechaliqcausalfallo = 'S'
               AND nuEstado <> 0
               AND nuEstado <> 5
            THEN
                OPEN cucausalfallo (nuordenRev,
                                    nuestadoordencerrada,
                                    nutipocausalfallofnb);

                FETCH cucausalfallo INTO nucausalfallo;

                CLOSE cucausalfallo;

                IF nucausalfallo = 0
                THEN
                    OPEN cufechalegcausalexito (nuordenRev,
                                                idafechainicio,
                                                idafechafin,
                                                nuestadoordencerrada,
                                                nutipocausalfallofnb);

                    FETCH cufechalegcausalexito INTO nufechalegalizacion;

                    CLOSE cufechalegcausalexito;

                    IF nufechalegalizacion = 1
                    THEN
                        nucausalfallo := 0;
                    END IF;
                END IF;
            END IF;

            --Valida Contratista PAP
            IF (   nutipotrabajo = nuttcobrocomipag
                OR nutipotrabajo = nuttpagocomi)
            THEN
                --se agrega la condicion de causal de fallo
                IF (   nuestado = 0
                    OR nuestado = 5
                    OR (sbflagfechaliqcausalfallo = 'S' AND nucausalfallo = 1)
                    OR (    sbflagfechaliqcausalfallo = 'S'
                        AND nucausalfallo = 0
                        AND nufechalegalizacion = 0))
                THEN
                    sbexcluir := 'S';
                END IF;
            ELSE
                --obtiene el punto de venta asociado a la solicitud
                nuPuntoVta :=
                    TO_NUMBER (ldc_boutilities.fsbgetvalorcampotabla (
                                   'MO_PACKAGES',
                                   'PACKAGE_ID',
                                   'POS_OPER_UNIT_ID',
                                   nusolicitudvta));

                --Valida Proveedor Punto Fijo caso 200-1893
                --if (nuunidadoper = nupuntovta OR INSTR(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_UNIDCARDIF', NULL), nuunidadoper) > 0 ) then --TICKET 2001447  LJLB-- se coloca condicion de parametro LDC_UNIDCARDIF
                IF (INSTR (
                        DALD_PARAMETER.FSBGETVALUE_CHAIN ('LDC_UNIDCARDIF',
                                                          NULL),
                        nuunidadoper) =
                    0)
                THEN                                           --caso 200-1961
                    --se agrega la condicion de causal de fallo
                    IF (   nuestado = 0
                        OR nuestado = 5
                        OR (    sbflagfechaliqcausalfallo = 'S'
                            AND nucausalfallo = 1)
                        OR (    sbflagfechaliqcausalfallo = 'S'
                            AND nucausalfallo = 0
                            AND nufechalegalizacion = 0))
                    THEN
                        IF nutipotrabajo IN (nuttpagoartprov,
                                             nuttcobrocomiprov,
                                             nuttcobroprovartdev,
                                             nuttpagoprovcomicobrada)
                        THEN
                            sbexcluir := 'S';
                        END IF;   
                    END IF;
                END IF;
            END IF;
        END IF;

        pkg_Traza.Trace ('sbExcluir-->' || sbExcluir, 10);
        pkg_Traza.Trace ('Fin fsbexcluirotxvaliddocperiodo', 10);
        RETURN sbExcluir;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN NULL;
    END fsbexcluirotxvaliddocperiodo;

    FUNCTION fnuvalidaactivpordefectos (
        inuActivityId     IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        inuCodActividad   IN OR_ORDER_ACTIVITY.ORDER_ITEM_ID%TYPE)
        RETURN NUMBER
    IS
        /**************************************************************
           Propiedad intelectual PETI.

          Funcion  :  fnuvalidaactivpordefectos

          Descripcion  : Funcion usada desde la configuracion ORMTB,
                                 Valida si debe generar la actividad pasada como parametros segun
                                 los defectos registrados en la revision periodica

          Autor  : Jhon Jairo Soto
           Fecha  : 15-05-2013

          Historia de Modificaciones
         Fecha           Autor               Descripcion
           5-05-2013       jsoto               1. Creacion
           29-05-2015   oparra.Aranda 5695     2. Validar si el tramite es "100297 - LDC Acepta Reparaciones"
                                                   para que retorne 1 la funcion para generar la OT 12135 en el flujo
           14-07-2015     LDiuza.Aranda 5695   1. Se elimina validacion de tipo de solicitud.
           **************************************************************/
        nuconta        NUMBER DEFAULT 0;
        sbParameter    ld_parameter.value_chain%TYPE;
        nuPackage_id   OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE;
        nuProduct_id   mo_motive.PRODUCT_ID%TYPE;
    BEGIN
        sbParameter :=
            dald_parameter.fsbGetValue_Chain (
                'ACTIVIDAD_' || inuCodActividad || '_POR_DEFECTOS');
        nuPackage_id := daor_order_activity.fnugetpackage_id (inuActivityId);
        nuProduct_id := daor_order_activity.fnugetproduct_id (inuActivityId);

        SELECT COUNT (1)
          INTO nuconta
          FROM or_activ_defect a, or_order_activity b
         WHERE     A.ORDER_ACTIVITY_ID = B.ORDER_ACTIVITY_ID
               AND b.package_id = nuPackage_id
               AND a.defect_id IN
                       ((SELECT TO_NUMBER (COLUMN_VALUE)
                           FROM TABLE (
                                    ldc_boutilities.splitstrings (
                                        sbParameter,
                                        ','))));

        RETURN nuconta;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN NULL;
    END fnuvalidaactivpordefectos;

    /**************************************************************
      Propiedad intelectual PETI.

      Funcion  :  fnuValActivAndPackByDefec

      Descripcion  : Funcion usada desde la configuracion ORMTB,
                            Valida si debe generar la actividad pasada como parametros segun
                            los defectos registrados en la revision periodica. Se tiene en
                            cuenta el tipo de solicitud

      Autor  : Luis Arturo Diuza C
      Fecha  : 13-07-2015

      Historia de Modificaciones
    Fecha           Autor               Descripcion
      13-07-2015      LDiuza              1. Creación
      **************************************************************/
    FUNCTION fnuValActivAndPackByDefec (
        inuActivityId      IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        inuCodActividad    IN OR_ORDER_ACTIVITY.ORDER_ITEM_ID%TYPE,
        inuPackageTypeId   IN MO_PACKAGES.PACKAGE_TYPE_ID%TYPE)
        RETURN NUMBER
    IS
        nuconta        NUMBER DEFAULT 0;
        sbParameter    ld_parameter.value_chain%TYPE;
        nuPackage_id   OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE;
        nuProduct_id   mo_motive.PRODUCT_ID%TYPE;
    BEGIN
        sbParameter :=
            dald_parameter.fsbGetValue_Chain (
                'ACTIVIDAD_' || inuCodActividad || '_POR_DEFECTOS');
        nuPackage_id := daor_order_activity.fnugetpackage_id (inuActivityId);
        nuProduct_id := daor_order_activity.fnugetproduct_id (inuActivityId);

        -- Aranda 5695
        IF (inuPackageTypeId =
            dald_parameter.fnugetNumeric_Value (
                'TRAMITE_ACEPTA_REPARACIONES'))
        THEN
            RETURN 1;
        END IF;

        SELECT COUNT (1)
          INTO nuconta
          FROM or_activ_defect a, or_order_activity b
         WHERE     A.ORDER_ACTIVITY_ID = B.ORDER_ACTIVITY_ID
               AND b.package_id = nuPackage_id
               AND a.defect_id IN
                       ((SELECT TO_NUMBER (COLUMN_VALUE)
                           FROM TABLE (
                                    ldc_boutilities.splitstrings (
                                        sbParameter,
                                        ','))));

        RETURN nuconta;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN NULL;
    END fnuValActivAndPackByDefec;

    /**************************************************************
    Propiedad intelectual PETI.

    Funcion      :  fsbvalidareparaincumplidaSusp
    Descripcion  :  Funcion usada desde la configuracion ORMTB,
                    Valida si los trabajos de reparacion que se generaron a partir de la
                    orden de RP se incumplieron con causal de suspension

    Autor  : Luz Andrea Angel/OLSoftware
    Fecha  : 15-05-2013

    Historia de Modificaciones
    **************************************************************/
    FUNCTION fsbvalidareparaincumplidaSusp (
        nuPackage   IN or_order_activity.package_id%TYPE)
        RETURN VARCHAR2
    IS
        CURSOR cuotreparacion (nusolicitud or_order_activity.package_id%TYPE)
        IS
            SELECT order_id
              FROM (  SELECT a.order_id
                        FROM or_order a, or_order_activity b
                       WHERE     a.order_id = b.order_id
                             AND b.package_id = nusolicitud
                             AND ldc_boutilities.fsbbuscatoken (
                                     dald_parameter.fsbgetvalue_chain (
                                         'ACTIVIDADES_REPARACION'),
                                     TO_CHAR (b.activity_id),
                                     ',') =
                                 'S'
                             AND a.order_status_id = 8
                    ORDER BY a.legalization_date DESC)
             WHERE ROWNUM = 1;

        CURSOR cuotreparaincumple (
            nusolicitud   or_order_activity.package_id%TYPE,
            nuordenid     or_order.order_id%TYPE)
        IS
            SELECT a.causal_id
              FROM or_order a, or_order_activity b
             WHERE     a.order_id = b.order_id
                   AND b.package_id = nusolicitud
                   AND a.order_id = nuordenid
                   AND ldc_boutilities.fsbbuscatoken (
                           dald_parameter.fsbgetvalue_chain (
                               'CAUSAL_INCUMPLE_REPARACION'),
                           TO_CHAR (a.causal_id),
                           ',') =
                       'S';

        nuorden      or_order.order_id%TYPE;
        nucausal     or_order.causal_id%TYPE;
        sbIncumple   VARCHAR2 (1) := 'N';
    BEGIN
        pkg_Traza.Trace (
            'Inicia LDC_BOORDENES.fsbvalidareparaincumplidaSusp',
            10);
        pkg_Traza.Trace ('nuPackage -->' || nuPackage, 10);

        OPEN cuOtReparacion (nuPackage);

        FETCH cuOtReparacion INTO nuorden;

        CLOSE cuOtReparacion;

        pkg_Traza.Trace ('nuordenRep -->' || nuorden, 10);

        IF (nuorden IS NOT NULL OR nuorden > 0)
        THEN
            OPEN cuotreparaincumple (nuPackage, nuorden);

            FETCH cuotreparaincumple INTO nuCausal;

            CLOSE cuotreparaincumple;

            pkg_Traza.Trace ('nuCausal -->' || nuCausal, 10);

            IF (nucausal IS NOT NULL OR nucausal > 0)
            THEN
                sbIncumple := 'S';
            END IF;

            pkg_Traza.Trace ('sbIncumple -->' || sbIncumple, 10);
        END IF;

        pkg_Traza.Trace ('Fin LDC_BOORDENES.fsbvalidareparaincumplidaSusp',
                         10);
        RETURN sbincumple;
    END fsbvalidareparaincumplidaSusp;

    /*****************************************
    Metodo: fsbValidaSerial
    Descripcion: Consulta que permite identificar si el Numero serial ingresado como dato adicional en la legalizacion, existe en ge_items_serial,
                 en estado Nuevo y que se encuentre asignado a una UT.
    Autor: Alvaro Zapata
    Fecha: Mayo 21/2013
     ******************************************/
    FUNCTION fsbValidaSerial (nuSerial IN VARCHAR2)
        RETURN VARCHAR2
    IS
        nuCantidad   NUMBER;
    BEGIN
        SELECT COUNT (1)
          INTO nuCantidad
          FROM GE_ITEMS_SERIADO
         WHERE     SERIE = nuSerial
               AND id_items_estado_inv = 1                             --nuevo
               AND OPERATING_UNIT_ID IS NOT NULL;

        IF (nuCantidad > 0)
        THEN
            RETURN 1;
        --dbms_output.put_line(nuCantidad||'Retorna 1');
        END IF;

        RETURN -1;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN -1;
    END;

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    /*****************************************************************
    Unidad       : ValidaTipoOrden
    Descripcion     : Valida tipo de trabajo de una orden
    Parametros          Descripcion
    ============        ===================
    inuOrden        numero de alerta
    isbTipoalerta   tipo de alerta a buscar

    Historia de Modificaciones
    Fecha       IDEntrega

    16-May-2013 Carlos Andres Dominguez - cadona
    ******************************************************************/
    FUNCTION ValidaTipoOrden (inuOrden   OR_order.order_id%TYPE,
                              isbTipos   VARCHAR2)
        RETURN NUMBER
    IS
        sbTaskType   ld_parameter.value_chain%TYPE;
        sbSql        VARCHAR2 (2000);
        rcOrdenes    or_order%ROWTYPE;
        cuOrdenes    pkConstante.tyrefcursor;
        nuOrden      OR_order.order_id%TYPE;
    BEGIN
        pkg_Traza.Trace (
               'Inicia LDC_BOORDENES.ValidaTipoOrden['
            || nuError
            || ']sbError:['
            || sbError
            || ']',
            15);
        sbTaskType := dald_parameter.fsbGetValue_Chain (isbTipos, NULL);
        nuError := pkConstante.NO_EXITO;
        sbSql :=
               'select * from or_order where ORDER_id = '
            || inuOrden
            || ' AND task_type_id in ('
            || sbTaskType
            || ')';

        OPEN cuOrdenes FOR sbSql;

        FETCH cuOrdenes INTO rcOrdenes;

        IF cuOrdenes%FOUND
        THEN
            nuError := pkConstante.EXITO;
        END IF;

        CLOSE cuOrdenes;

        pkg_Traza.Trace ('Finaliza LDC_BOORDENES.ValidaTipoOrden', 15);
        DBMS_OUTPUT.put_line (
            nuOrden || ' - ' || sbSql || '  =' || rcOrdenes.task_type_id);
        RETURN nuError;
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;
    END ValidaTipoOrden;

    /*****************************************************************
    Unidad       : GetMailNotify
    Descripcion     : Obtiene el mail de la persona responsable de una alerta
                   en un estado x de la orden
    Parametros          Descripcion
    ============        ===================
    parametro1        descripcion
    inuOrden            id orden de trabajo
    inuEstado           estado final de la orden

    Historia de Modificaciones
    Fecha       IDEntrega

    16-May-2013 Carlos Andres Dominguez - cadona
    14-08-2013  Jsoto  Se modifica para obtener el correo de la persona
                       digitado en el dato adicional
    ******************************************************************/
    FUNCTION GetMailNotify (
        inuOrden    OR_order.order_id%TYPE,
        inuEstado   OR_order_stat_change.final_status_id%TYPE)
        RETURN VARCHAR2
    IS
        sbTaskType               ld_parameter.value_chain%TYPE;
        sbSql                    VARCHAR2 (2000);
        nuUser                   sa_user.user_id%TYPE;
        rcOR_order_stat_change   OR_order_stat_change%ROWTYPE;
        nuPerson                 GE_PERSON.PERSON_ID%TYPE;
        sbMail                   GE_PERSON.E_MAIL%TYPE;
        nuTipoTrab               OR_ORDER.TASK_TYPE_ID%TYPE;

        CURSOR cuPerson (nuUser_id sa_user.user_id%TYPE)
        IS
            SELECT *
              FROM ge_person
             WHERE user_id = nuUser_id;

        rcPerson                 ge_person%ROWTYPE;

        CURSOR cuEstado (
            nuOrden         OR_order.order_id%TYPE,
            nuOrdenStatus   OR_order_status.order_status_id%TYPE)
        IS
            SELECT *
              FROM OR_order_stat_change
             WHERE ORDER_id = nuOrden AND final_status_id = nuOrdenStatus;
    BEGIN
        
        pkg_Traza.Trace (
               'Inicia LDC_BOORDENES.GetMailNotify['
            || nuError
            || ']sbError:['
            || sbError
            || ']',
            15);
        nuPerson :=
            TO_NUMBER (
                SUBSTR (
                    LDC_BOORDENES.fsbDatoAdicTmpOrden (
                        inuOrden,
                        5001309,
                        'FUNCIONARIO_A_NOTIFICAR'),
                    1,
                      INSTR (
                          LDC_BOORDENES.fsbDatoAdicTmpOrden (
                              inuOrden,
                              5001309,
                              'FUNCIONARIO_A_NOTIFICAR'),
                          '-',
                          1,
                          1)
                    - 1));
        pkg_Traza.Trace (
            'Ejecucion LDC_BOORDENES.GetMailNotify  nuPerson => ' || nuPerson,
            10);

        --to_number(substr('1-xx', 1, instr('1-xx', '-', 1, 1) -1))
        --Si no se encontro en la tabla temporal se busca con uno de los grupos configurados
        IF nuPerson IS NULL
        THEN
            pkg_Traza.Trace (
                'Ejecucion LDC_BOORDENES.GetMailNotify  No se encontro en tablas temporales de legalizacion  ',
                10);
            nuTipoTrab := DAOR_ORDER.fnugetTask_type_id (inuOrden);
            nuPerson :=
                TO_NUMBER (SUBSTR (ldc_boordenes.FnugetValorOTbyDatAdd (
                                       nuTipoTrab,
                                       11738,
                                       'FUNCIONARIO_A_NOTIFICAR',
                                       inuOrden),
                                   1,
                                     INSTR (ldc_boordenes.FnugetValorOTbyDatAdd (
                                                nuTipoTrab,
                                                11738,
                                                'FUNCIONARIO_A_NOTIFICAR',
                                                inuOrden),
                                            '-',
                                            1,
                                            1)
                                   - 1));
        END IF;

        --Si no se encontro en la tabla temporal, ni en el grupo anterior se busca con otro de los grupos configurados
        IF nuPerson IS NULL
        THEN
            pkg_Traza.Trace (
                'Ejecucion LDC_BOORDENES.GetMailNotify  No se encontro en tabla persistente con grupo 11738  ',
                10);
            nuTipoTrab := DAOR_ORDER.fnugetTask_type_id (inuOrden);
            nuPerson :=
                TO_NUMBER (SUBSTR (ldc_boordenes.FnugetValorOTbyDatAdd (
                                       nuTipoTrab,
                                       12001,
                                       'FUNCIONARIO_A_NOTIFICAR',
                                       inuOrden),
                                   1,
                                     INSTR (ldc_boordenes.FnugetValorOTbyDatAdd (
                                                nuTipoTrab,
                                                12001,
                                                'FUNCIONARIO_A_NOTIFICAR',
                                                inuOrden),
                                            '-',
                                            1,
                                            1)
                                   - 1));
        END IF;

        IF nuPerson IS NULL
        THEN
            pkg_Traza.Trace (
                'Ejecucion LDC_BOORDENES.GetMailNotify  No se encontro en tabla persistente con grupo 12001  ',
                10);
        END IF;

        sbMail := DAGE_PERSON.fsbgete_mail (nuPerson);
        pkg_Traza.Trace (
            'Ejecucion LDC_BOORDENES.GetMailNotify  sbMail => ' || sbMail,
            10);
        pkg_Traza.Trace ('Finaliza LDC_BOORDENES.GetMailNotify', 15);
        RETURN sbMail;
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;
    END GetMailNotify;

    /*****************************************************************
    Unidad       : AL_CUMPLEORDENTRAB
    Descripcion     : Configuracion de Alerta ordenes de trabajo cumplidas
    Parametros          Descripcion
    ============        ===================
    parametro1        descripcion

    Historia de Modificaciones
    Fecha       IDEntrega

    16-May-2013 Carlos Andres Dominguez - cadona
    ******************************************************************/
    PROCEDURE AL_CUMPLEORDENTRAB (inuOrden IN OR_order.order_id%TYPE)
    IS
        sbSender   VARCHAR2 (2000);
        sbAsunto   VARCHAR2 (250) := 'Orden Cumplida';
    BEGIN
        NULL;
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;
    END AL_CUMPLEORDENTRAB;

    FUNCTION AL_CUMPLEORDENTRAB_NEW (inuOrden IN OR_order.order_id%TYPE)
        --dsaltarin 28/04/2021  609: Se agregan datos al correo de notificación
        RETURN VARCHAR2
    IS
        sbSender                     VARCHAR2 (2000);
        sbAsunto                     VARCHAR2 (250) := 'Orden Cumplida';
        sbComment                    or_order_comment.order_comment%TYPE;
        sbOtRegenerada               VARCHAR2 (2000);
        sbDatoAdiciona               ld_parameter.value_chain%TYPE
            := dald_parameter.fsbgetvalue_chain (
                   'ATRIB_X_GRUPO_X_TITR_NOTIFICAR',
                   NULL);

        sbTitrDis609                 ld_parameter.value_chain%TYPE
            :=    ','
               || dald_parameter.fsbGetValue_Chain (
                      'TITR_MENSAJE_LEGAL_DISENO',
                      NULL)
               || ',';

        sbfromdisplay Varchar2(4000) := 'Open SmartFlex';  
        
        -- cursores
        CURSOR cuOrdenes (nuOrden IN OR_order.order_id%TYPE)
        IS
            SELECT a.ORDER_id              ORDER_id,
                   a.task_type_id          task_type_id,
                   c.description           tt_description,
                   a.causal_id             causal_id,
                   b.description           ca_description,
                   a.operating_unit_id     operating_unit_id,
                   d.name                  name_
              FROM OR_order           a,
                   ge_causal          b,
                   OR_task_type       c,
                   OR_operating_unit  d
             WHERE     a.causal_id = b.causal_id
                   AND a.task_type_id = c.task_type_id
                   AND a.operating_unit_id = d.operating_unit_id
                   AND a.order_id = nuOrden;

        rcOrdenes                    cuOrdenes%ROWTYPE;
        sbNotificacion               VARCHAR2 (32000) := '-';
        sbMail                       ge_person.e_mail%TYPE;
      
        cnuEstadoCumplida   CONSTANT OR_order_status.order_status_id%TYPE
                                         := 8 ;

        --609
        CURSOR cuDatosAdicionales (
            nuTitr   or_task_type.task_type_id%TYPE)
        IS
            WITH
                tabla
                AS
                    (SELECT DISTINCT
                            SUBSTR (COLUMN_VALUE,
                                    1,
                                    INSTR (COLUMN_VALUE, ';') - 1)    titr,
                            SUBSTR (COLUMN_VALUE,
                                      INSTR (COLUMN_VALUE,
                                             ';',
                                             1,
                                             1)
                                    + 1,
                                      INSTR (COLUMN_VALUE,
                                             ';',
                                             1,
                                             2)
                                    - INSTR (COLUMN_VALUE,
                                             ';',
                                             1,
                                             1)
                                    - 1)                              grupo,
                            SUBSTR (COLUMN_VALUE,
                                      INSTR (COLUMN_VALUE,
                                             ';',
                                             1,
                                             2)
                                    + 1,
                                    9999)                             atributo
                       FROM TABLE (
                                LDC_BOUTILITIES.SPLITSTRINGS (sbDatoAdiciona,
                                                              '|'))
                      WHERE COLUMN_VALUE IS NOT NULL)
            SELECT *
              FROM tabla
             WHERE titr = nuTitr;

        CURSOR cuValorDatoAdi (nuTitr NUMBER, nuGrupo NUMBER, nuDato NUMBER)
        IS
            SELECT CASE
                       WHEN CEIL (s.capture_order / 20) > 1
                       THEN
                           DECODE (
                               (  s.capture_order
                                - (CEIL (s.capture_order / 20) * 10)),
                               1, name_1,
                               2, name_2,
                               3, name_3,
                               4, name_4,
                               5, name_5,
                               6, name_6,
                               7, name_7,
                               8, name_8,
                               9, name_9,
                               10, name_10,
                               11, name_11,
                               12, name_12,
                               13, name_13,
                               14, name_14,
                               15, name_15,
                               16, name_16,
                               17, name_17,
                               18, name_18,
                               19, name_19,
                               20, name_20,
                               'na')
                       ELSE
                           DECODE (s.capture_order,
                                   1, name_1,
                                   2, name_2,
                                   3, name_3,
                                   4, name_4,
                                   5, name_5,
                                   6, name_6,
                                   7, name_7,
                                   8, name_8,
                                   9, name_9,
                                   10, name_10,
                                   11, name_11,
                                   12, name_12,
                                   13, name_13,
                                   14, name_14,
                                   15, name_15,
                                   16, name_16,
                                   17, name_17,
                                   18, name_18,
                                   19, name_19,
                                   20, name_20,
                                   'na')
                   END    dato,
                   CASE
                       WHEN CEIL (s.capture_order / 20) > 1
                       THEN
                           DECODE (
                               (  s.capture_order
                                - (CEIL (s.capture_order / 20) * 10)),
                               1, value_1,
                               2, value_2,
                               3, value_3,
                               4, value_4,
                               5, value_5,
                               6, value_6,
                               7, value_7,
                               8, value_8,
                               9, value_9,
                               10, value_10,
                               11, value_11,
                               12, value_12,
                               13, value_13,
                               14, value_14,
                               15, value_15,
                               16, value_16,
                               17, value_17,
                               18, value_18,
                               19, value_19,
                               20, value_20,
                               'na')
                       ELSE
                           DECODE (s.capture_order,
                                   1, value_1,
                                   2, value_2,
                                   3, value_3,
                                   4, value_4,
                                   5, value_5,
                                   6, value_6,
                                   7, value_7,
                                   8, value_8,
                                   9, value_9,
                                   10, value_10,
                                   11, value_11,
                                   12, value_12,
                                   13, value_13,
                                   14, value_14,
                                   15, value_15,
                                   16, value_16,
                                   17, value_17,
                                   18, value_18,
                                   19, value_19,
                                   20, value_20,
                                   'na')
                   END    valor
              FROM or_tasktype_add_data  d,
                   ge_attrib_set_attrib  s,
                   ge_attributes         a,
                   or_requ_data_value    r
             WHERE     d.attribute_set_id = s.attribute_set_id
                   AND s.attribute_id = a.attribute_id
                   AND r.attribute_set_id = d.attribute_set_id
                   AND r.order_id = inuOrden
                   AND d.task_type_id = nutitr
                   AND d.attribute_set_id = nugrupo
                   AND s.attribute_id = nudato
                   AND r.task_type_id = d.task_type_id;
    BEGIN
        pkg_Traza.Trace (
               'Inicia LDC_BOORDENES.AL_CUMPLEORDENTRAB_NEW['
            || nuError
            || ']sbError:['
            || sbError
            || ']',
            15);

        sbSender := DALD_PARAMETER.fsbGetValue_Chain ('LDC_SMTP_SENDER');
        DBMS_OUTPUT.put_Line (sbSender);

        OPEN cuOrdenes (inuOrden);

        FETCH cuOrdenes INTO rcOrdenes;

        IF cuOrdenes%FOUND
        THEN
            IF    INSTR (sbTitrDis609,',' || rcOrdenes.task_type_id || ',') = 0
            THEN
                sbNotificacion :=
                       'La Orden No. '
                    || rcOrdenes.order_id
                    || ' de Tipo '
                    || rcOrdenes.task_type_id
                    || ' - '
                    || rcOrdenes.tt_description
                    || CHR (13)
                    || ' Ya fue cerrada con la causal de legalizacion '
                    || rcOrdenes.causal_id
                    || ' - '
                    || rcOrdenes.ca_description
                    || CHR (13)
                    || ' por la unidad de trabajo '
                    || rcOrdenes.operating_unit_id
                    || ' - '
                    || rcOrdenes.name_
                    || CHR (13);
                pkg_Traza.Trace (
                       'Ejecucion LDC_BOORDENES.AL_CUMPLEORDENTRAB_NEW substr(sbNotificacion,1,240) => '
                    || SUBSTR (sbNotificacion, 1, 240),
                    10);
            ELSE
                pkg_Traza.Trace (
                       'Ejecucion LDC_BOORDENES.AL_CUMPLEORDENTRAB_NEW substr(sbNotificacion,1,240) => '
                    || SUBSTR (sbNotificacion, 1, 240),
                    10);
                sbNotificacion := 'La Orden No. '
                    || rcOrdenes.order_id
                    || ' de Tipo '
                    || rcOrdenes.task_type_id
                    || ' - '
                    || rcOrdenes.tt_description
                    || '<br>'
                    || ' Ya fue cerrada con la causal de legalizacion '
                    || rcOrdenes.causal_id
                    || ' - '
                    || rcOrdenes.ca_description
                    || '<br>';
                sbNotificacion :=
                       sbNotificacion
                    || '<p><b>Orden legalizada: </b>'
                    || rcOrdenes.ORDER_id
                    || '<br>';

                BEGIN
                    SELECT SUBSTR (c.order_comment, 1, 1000)
                      INTO sbComment
                      FROM or_order_comment c
                     WHERE     c.order_id = rcOrdenes.ORDER_id
                           AND c.legalize_comment = 'Y';
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        sbComment := NULL;
                END;

                sbNotificacion :=
                       sbNotificacion
                    || '<b>Unidad Operativa:</b>'
                    || rcOrdenes.operating_unit_id
                    || ' - '
                    || rcOrdenes.name_
                    || '<br>';

                IF sbComment IS NOT NULL
                THEN
                    BEGIN
                        sbNotificacion :=
                               sbNotificacion
                            || '<b>Comentario de legalizacion : </b>'
                            || sbComment
                            || '<br>';
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            NULL;
                    END;
                END IF;

                BEGIN
                    SELECT    o.order_id
                           || '  '
                           || o.task_type_id
                           || '-'
                           || daor_task_type.fsbgetdescription (
                                  o.task_type_id,
                                  NULL)    OtRegenerada
                      INTO sbOtRegenerada
                      FROM or_related_order r, or_order o
                     WHERE     r.order_id = rcOrdenes.ORDER_id
                           AND r.rela_order_type_id = 2
                           AND r.related_order_id = o.order_id
                           AND ROWNUM = 1;
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        sbOtRegenerada := NULL;
                END;

                IF sbOtRegenerada IS NOT NULL
                THEN
                    BEGIN
                        sbNotificacion :=
                               sbNotificacion
                            || '<b>OT generada en la legalizacion  : </b>'
                            || sbOtRegenerada
                            || '<br>';
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            NULL;
                    END;
                END IF;

                FOR reg IN cuDatosAdicionales (rcOrdenes.task_type_id)
                LOOP
                    FOR reg2
                        IN cuValorDatoAdi (reg.titr, reg.grupo, reg.atributo)
                    LOOP
                        BEGIN
                            sbNotificacion :=
                                   sbNotificacion
                                || '<b>'
                                || reg2.dato
                                || ' : </b>'
                                || reg2.valor
                                || '<br>';
                        EXCEPTION
                            WHEN OTHERS
                            THEN
                                NULL;
                        END;
                    END LOOP;
                END LOOP;
                                
            END IF;
        --dbms_output.put_Line(substr(sbNotificacion,1,240));
        END IF;

        CLOSE cuOrdenes;

        -- Obtiene correo
        BEGIN
            sbMail :=
                LDC_BOORDENES.GetMailNotify (rcOrdenes.order_id,
                                             cnuEstadoCumplida);
            pkg_Traza.Trace (
                   'Ejecucion LDC_BOORDENES.AL_CUMPLEORDENTRAB_NEW  sbMail => '
                || sbMail,
                10);

            --dbms_output.put_Line('mail_to:'||sbMail);
            IF sbMail IS NOT NULL
            THEN

                pkg_Correo.prcEnviaCorreo( 
                    isbRemitente        => sbSender,
                    isbDestinatarios    => sbMail,
                    isbAsunto           => sbAsunto,
                    isbMensaje          => sbNotificacion,
                    isbDescRemitente    => sbfromdisplay
                );                        
                                                    
            END IF;
        EXCEPTION
            WHEN OTHERS
            THEN
                sbMail := '-';
        END;

        DBMS_OUTPUT.put_Line (
            'Correo:  ' || sbNotificacion || '  ' || sbMail);
        pkg_Traza.Trace ('Finaliza LDC_BOORDENES.AL_CUMPLEORDENTRAB_NEW', 15);
        RETURN sbAsunto;
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;
    END AL_CUMPLEORDENTRAB_NEW;

    PROCEDURE AL_GENEORDENTRAB (inuOrden IN OR_order.order_id%TYPE)
    IS
    BEGIN
        NULL;
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;
    END AL_GENEORDENTRAB;

    /*****************************************************************
    Unidad       : AL_ORDENVENCIDA
    Descripcion     : Objeto llamado desde JOB de smartflex para
                      generacion de alertas de dise?o
    Parametros          Descripcion
    ============        ===================
    parametro1        descripcion

    Historia de Modificaciones
    Fecha       IDEntrega

    12-08-2013  Jsoto   NC-320 Se crea funcion para alertas de dise?o
    ******************************************************************/
    FUNCTION AL_ORDENVENCIDA
        RETURN VARCHAR2
    IS
        sbSender          VARCHAR2 (2000);
        sbAsunto          VARCHAR2 (250) := 'Ordenes vencidas o por vencer';
        sbError           VARCHAR2 (200);
        nuerror           NUMBER;
        nuDiasDiseno      NUMBER;

        -- cursores
        CURSOR cuOrdenes IS
              SELECT DISTINCT a.order_id,
                              a.task_type_id,
                              f.description     tt_description,
                              E.OPERATING_UNIT_ID,
                              E.NAME,
                              a.order_activity_id,
                              a.activity_id,
                              e.person_in_charge
                FROM or_order_activity a,
                     OR_operating_unit e,
                     OR_task_type     f,
                     or_order         g
               WHERE     A.OPERATING_UNIT_ID = e.operating_unit_id
                     AND A.ORDER_ID = G.ORDER_ID
                     AND E.PERSON_IN_CHARGE IS NOT NULL
                     AND a.task_type_id = f.task_type_id
                     AND TO_CHAR (A.TASK_TYPE_ID) IN
                             (SELECT TO_NUMBER (COLUMN_VALUE)
                                FROM TABLE (
                                         LDC_BOUTILITIES.SPLITSTRINGS (
                                             DALD_parameter.fsbGetValue_Chain (
                                                 'AL_GENE_ORDE_TRAB'),
                                             ',')))
                     AND (  SYSDATE
                          - (  G.CREATED_DATE
                             + DALD_parameter.fnuGetNumeric_Value (
                                   'ANS_DISENO')) >=
                          -1)
                     AND g.order_status_id =
                         DALD_parameter.fnuGetNumeric_Value ('ESTADO_ASIGNADO') --estado asignado
            ORDER BY person_in_charge;

        rcOrdenes         cuOrdenes%ROWTYPE;
        sbNotificacion    VARCHAR2 (4000) := '-';
        sbNotificacion1   VARCHAR2 (4000);
        sbMail            ge_person.e_mail%TYPE;

        TYPE tyrcCorreo IS RECORD
        (
            sbCuerpo          VARCHAR2 (4000),
            sbDestinatario    VARCHAR2 (2000)
        );

        TYPE tytbCorreo IS TABLE OF tyrcCorreo
            INDEX BY BINARY_INTEGER;

        tbCorreo          tytbCorreo;
        nuIndex           NUMBER;
        nuPerson          ge_person.person_id%TYPE;
    BEGIN
        pkg_Traza.Trace (
               'Inicia LDC_BOORDENES.AL_ORDENVENCIDA['
            || nuError
            || ']sbError:['
            || sbError
            || ']',
            15);
        sbSender := DALD_PARAMETER.fsbGetValue_Chain ('LDC_SMTP_SENDER');
        nuDiasDiseno := DALD_PARAMETER.fnuGetNumeric_Value ('ANS_DISENO');
        DBMS_OUTPUT.put_Line (sbSender);

        OPEN cuOrdenes;

        LOOP
            FETCH cuOrdenes INTO rcOrdenes;

            EXIT WHEN cuOrdenes%NOTFOUND;

            IF cuOrdenes%FOUND
            THEN
                sbNotificacion :=
                       'Existen las Siguientes Ordenes que deben ser atendidas, dado que de los '
                    || nuDiasDiseno
                    || CHR (13)
                    || 'dias determinados para su atencion, les hace falta al menos 1 dia para su vencimiento o'
                    || CHR (13)
                    || 'ya se encuentran vencidas.'
                    || CHR (13)
                    || CHR (13)
                    || ' Orden No. '
                    || rcOrdenes.order_id
                    || ' de Tipo '
                    || rcOrdenes.task_type_id
                    || ' - '
                    || rcOrdenes.tt_description
                    || ' perteneciente a la Unidad de Trabajo : '
                    || rcOrdenes.OPERATING_UNIT_ID
                    || '-'
                    || rcOrdenes.name
                    || CHR (13);
                sbNotificacion1 :=
                       ' Orden No. '
                    || rcOrdenes.order_id
                    || ' de Tipo '
                    || rcOrdenes.task_type_id
                    || ' - '
                    || rcOrdenes.tt_description
                    || ' perteneciente a la Unidad de Trabajo : '
                    || rcOrdenes.OPERATING_UNIT_ID
                    || '-'
                    || rcOrdenes.name
                    || CHR (13);
                DBMS_OUTPUT.put_Line (SUBSTR (sbNotificacion, 1, 240));
                DBMS_OUTPUT.put_Line (SUBSTR (sbNotificacion1, 1, 240));

                BEGIN
                    --Or_BOOperatingUnit.GetPersonincharge(rcOrdenes.OPERATING_UNIT_ID,nuPerson);
                    nuPerson :=
                        DAOR_OPERATING_UNIT.fnugetperson_in_charge (
                            rcOrdenes.OPERATING_UNIT_ID);
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        nuPerson := NULL;
                END;

                DBMS_OUTPUT.put_Line ('Person: ' || nuPerson);

                IF nuPerson IS NOT NULL
                THEN
                    sbMail := DAGE_PERSON.FSBGETE_MAIL (nuPerson, 0);
                    DBMS_OUTPUT.put_Line ('mail_to:' || sbMail);

                    IF tbCorreo.EXISTS (rcOrdenes.person_in_charge)
                    THEN
                        tbCorreo (rcOrdenes.person_in_charge).sbCuerpo :=
                               tbCorreo (rcOrdenes.person_in_charge).sbCuerpo
                            || CHR (13)
                            || sbNotificacion1;
                    ELSE
                        tbCorreo (rcOrdenes.person_in_charge).sbCuerpo :=
                            sbNotificacion;
                        tbCorreo (rcOrdenes.person_in_charge).sbDestinatario :=
                            sbMail;
                    END IF;
                END IF;
            END IF;
        END LOOP;

        CLOSE cuOrdenes;

        nuIndex := tbCorreo.FIRST;

        LOOP
            EXIT WHEN nuIndex IS NULL;

            IF tbCorreo (nuIndex).sbDestinatario IS NOT NULL
            THEN
                DBMS_OUTPUT.put_Line (
                    'Correo para:' || tbCorreo (nuIndex).sbDestinatario);
                --Enviar correspondencia
                LDC_Email.mail (sbSender,
                                tbCorreo (nuIndex).sbDestinatario,
                                sbAsunto,
                                tbCorreo (nuIndex).sbCuerpo);
            END IF;

            nuIndex := tbCorreo.NEXT (nuIndex);
        END LOOP;

        RETURN sbAsunto;
        pkg_Traza.Trace ('Finaliza LDC_BOORDENES.AL_ORDENVENCIDA', 15);
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;
    END AL_ORDENVENCIDA;

    /*****************************************************************
    Unidad       : AL_GENEORDENTRAB_NEW
    Descripcion     : Configuracion de Alerta ordenes de trabajo generadas
                   Llamado desde Reglas de Validacion de Alertas
    Parametros          Descripcion
    ============        ===================
    parametro1        descripcion

    Historia de Modificaciones
    Fecha       IDEntrega

    16-May-2013 Carlos Andres Dominguez - cadona
    08-08-2013  Jsoto   NC-320 Se realiza cambio en la funcion AL_GENEORDENTRAB para ordenes que aun no estan asigandas
    ******************************************************************/
    FUNCTION AL_GENEORDENTRAB_NEW (inuOrden IN OR_order.order_id%TYPE)
        RETURN VARCHAR2
    IS
        sbSender          VARCHAR2 (2000);
        sbAsunto          VARCHAR2 (250) := 'Orden Generada';

        -- cursores
        CURSOR cuOrdenes (nuOrden IN OR_order.order_id%TYPE)
        IS
              SELECT DISTINCT a.order_id,
                              a.task_type_id,
                              f.description     tt_description,
                              E.OPERATING_UNIT_ID,
                              a.order_activity_id,
                              a.activity_id,
                              e.person_in_charge,
                              b.id_rol,
                              d.description     rol_description
                FROM or_order_activity a,
                     or_actividades_rol b,
                     or_rol_unidad_trab c,
                     sa_role           d,
                     OR_operating_unit e,
                     OR_task_type      f
               WHERE     a.order_id = nuOrden
                     AND a.activity_id = b.id_actividad
                     AND C.ID_UNIDAD_OPERATIVA = e.operating_unit_id
                     AND b.id_rol = c.id_rol
                     AND c.id_rol = d.role_id
                     AND E.PERSON_IN_CHARGE IS NOT NULL
                     AND a.task_type_id = f.task_type_id
            ORDER BY person_in_charge; -- Se cambia la consulta para ordenes generadas que aun no tienen U Operativa

        rcOrdenes         cuOrdenes%ROWTYPE;
        sbNotificacion    VARCHAR2 (2000) := '-';
        sbNotificacion1   VARCHAR2 (2000);
        sbMail            ge_person.e_mail%TYPE;

        TYPE tyrcCorreo IS RECORD
        (
            sbCuerpo          VARCHAR2 (2000),
            sbDestinatario    VARCHAR2 (2000)
        );

        TYPE tytbCorreo IS TABLE OF tyrcCorreo
            INDEX BY BINARY_INTEGER;

        tbCorreo          tytbCorreo;
        nuIndex           NUMBER;
        nuPerson          ge_person.person_id%TYPE;
    BEGIN
        pkg_Traza.Trace (
               'Inicia LDC_BOORDENES.AL_GENEORDENTRAB['
            || nuError
            || ']sbError:['
            || sbError
            || ']',
            15);
        sbSender := DALD_PARAMETER.fsbGetValue_Chain ('LDC_SMTP_SENDER');
        DBMS_OUTPUT.put_Line (sbSender);

        OPEN cuOrdenes (inuOrden);

        LOOP
            FETCH cuOrdenes INTO rcOrdenes;

            EXIT WHEN cuOrdenes%NOTFOUND;

            IF cuOrdenes%FOUND
            THEN
                sbNotificacion :=
                       ' Se ha generado la Orden No. '
                    || rcOrdenes.order_id
                    || ' de Tipo '
                    || rcOrdenes.task_type_id
                    || ' - '
                    || rcOrdenes.tt_description
                    || CHR (13)
                    || ' perteneciente a los Roles : '
                    || CHR (13)
                    || ' - '
                    || rcOrdenes.id_rol
                    || ' - '
                    || rcOrdenes.rol_description
                    || CHR (13);
                sbNotificacion1 :=
                       ' - '
                    || rcOrdenes.id_rol
                    || ' - '
                    || rcOrdenes.rol_description
                    || CHR (13);
                DBMS_OUTPUT.put_Line (SUBSTR (sbNotificacion, 1, 240));

                BEGIN
                    --Or_BOOperatingUnit.GetPersonincharge(rcOrdenes.OPERATING_UNIT_ID,nuPerson);
                    nuPerson :=
                        DAOR_OPERATING_UNIT.fnugetperson_in_charge (
                            rcOrdenes.OPERATING_UNIT_ID);
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        nuPerson := NULL;
                END;

                DBMS_OUTPUT.put_Line ('Person: ' || nuPerson);

                IF nuPerson IS NOT NULL
                THEN
                    sbMail := DAGE_PERSON.FSBGETE_MAIL (nuPerson, 0);
                    DBMS_OUTPUT.put_Line ('mail_to:' || sbMail);

                    IF tbCorreo.EXISTS (rcOrdenes.person_in_charge)
                    THEN
                        tbCorreo (rcOrdenes.person_in_charge).sbCuerpo :=
                               tbCorreo (rcOrdenes.person_in_charge).sbCuerpo
                            || sbNotificacion1;
                    ELSE
                        tbCorreo (rcOrdenes.person_in_charge).sbCuerpo :=
                            sbNotificacion;
                        tbCorreo (rcOrdenes.person_in_charge).sbDestinatario :=
                            sbMail;
                    END IF;
                END IF;
            END IF;
        END LOOP;

        CLOSE cuOrdenes;

        nuIndex := tbCorreo.FIRST;

        LOOP
            EXIT WHEN nuIndex IS NULL;

            IF tbCorreo (nuIndex).sbDestinatario IS NOT NULL
            THEN
                DBMS_OUTPUT.put_Line (
                    'Correo para:' || tbCorreo (nuIndex).sbDestinatario);
                --Enviar correspondencia
                LDC_Email.mail (sbSender,
                                tbCorreo (nuIndex).sbDestinatario,
                                sbAsunto,
                                tbCorreo (nuIndex).sbCuerpo);
            END IF;

            nuIndex := tbCorreo.NEXT (nuIndex);
        END LOOP;

        RETURN sbAsunto;
        pkg_Traza.Trace ('Finaliza LDC_BOORDENES.AL_GENEORDENTRAB', 15);
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;
    END AL_GENEORDENTRAB_NEW;

    /*****************************************************************
   Unidad       : AL_DISENO_REALIZADO
   Descripcion     : Configuracion de Alerta ordenes de trabajo de dise?o realizado
   Parametros          Descripcion
   ============        ===================
   parametro1        descripcion
    Historia de Modificaciones
   Fecha       IDEntrega
   16-May-2013 Carlos Andres Dominguez - cadona
   13-08-2013  jsoto     Correccion funcion AL_DISENO_REALIZADO se ingresan en un parametro las personas a notificar
   28-01-2020  Eceron(Horbath)    REQ.167. Se modifica para que cuando aplique la entrega, se obtegna el correo
                                  de la tabla LDC_MAIL_GEO_LOCATION
   28-04-2021  dsaltarin          Cambio 609: Se agregan datos a la notificacion
   ******************************************************************/
    FUNCTION AL_DISENO_REALIZADO (inuOrden IN OR_order.order_id%TYPE)
        RETURN VARCHAR2
    IS
        nuSetAttrib      ge_attributes_set.attribute_set_id%TYPE;
        sbValorItem      VARCHAR2 (2000);
        nuATTRIBUTE_ID   GE_ATTRIBUTES.attribute_id%TYPE;
        sbSender         VARCHAR2 (2000);
        sbAsunto         VARCHAR2 (250) := 'Diseño Realizado';
        sbMail           ge_person.e_mail%TYPE;

        -- cursores
        -- Obtener grupo de atributos current
        CURSOR cuSetAttrib (
            nuTASK_TYPE_ID   IN OR_order.TASK_TYPE_ID%TYPE,
            nuATTRIBUTE_ID      GE_ATTRIBUTES.attribute_id%TYPE)
        IS
            SELECT GE_ATTRIBUTES_SET.ATTRIBUTE_SET_ID
              FROM OR_TASK_TYPE,
                   OR_TASKTYPE_ADD_DATA,
                   GE_ATTRIBUTES_SET,
                   GE_ATTRIBUTES,
                   GE_ATTRIB_SET_ATTRIB
             WHERE     OR_TASK_TYPE.TASK_TYPE_ID = nuTASK_TYPE_ID --id tipo de trabajo
                   AND OR_TASK_TYPE.TASK_TYPE_ID =
                       OR_TASKTYPE_ADD_DATA.TASK_TYPE_ID
                   AND OR_TASKTYPE_ADD_DATA.ATTRIBUTE_SET_ID =
                       GE_ATTRIBUTES_SET.ATTRIBUTE_SET_ID
                   AND GE_ATTRIBUTES.ATTRIBUTE_ID = nuATTRIBUTE_ID --id dato adicional
                   AND GE_ATTRIBUTES.ATTRIBUTE_ID =
                       GE_ATTRIB_SET_ATTRIB.ATTRIBUTE_ID
                   AND GE_ATTRIB_SET_ATTRIB.ATTRIBUTE_SET_ID =
                       GE_ATTRIBUTES_SET.ATTRIBUTE_SET_ID
                   AND OR_TASKTYPE_ADD_DATA.USE_ = 'B';                  --uso

        rcSetAttrib      cuSetAttrib%ROWTYPE;

        --------------------
        CURSOR cuOrdenes (nuOrden IN OR_order.order_id%TYPE)
        IS
            SELECT a.ORDER_id         ORDER_id,
                   a.task_type_id     task_type_id,
                   c.description      tt_description,
                   a.causal_id        causal_id,
                   b.description      ca_description,
                   a.operating_unit_id
              FROM OR_order a, ge_causal b, OR_task_type c
             WHERE     a.causal_id = b.causal_id
                   AND a.task_type_id = c.task_type_id
                   AND a.order_id = nuOrden;

        CURSOR cuEmail (inuDepto IN or_order.geograp_location_id%TYPE)
        IS
            SELECT EMAIL
              FROM LDC_MAIL_GEO_LOCATION
             WHERE geo_location_id = inuDepto;

        rcOrdenes        cuOrdenes%ROWTYPE;
        sbNotificacion   VARCHAR2 (2000) := '-';
        nuPerson         ge_person.person_id%TYPE;
        nuGeoLocaOrd     or_order.geograp_location_id%TYPE;
        nuCausalId       or_order.causal_id%TYPE;
        sbCausal         ge_causal.description%TYPE;
        dtFecha          or_order.created_date%TYPE;

        sbComment        or_order_comment.order_comment%TYPE;
        sbOtRegenerada   VARCHAR2 (2000);
        sbDatoAdiciona   ld_parameter.value_chain%TYPE
            := dald_parameter.fsbgetvalue_chain (
                   'ATRIB_X_GRUPO_X_TITR_NOTIFICAR',
                   NULL);
        sbTitrDis609     ld_parameter.value_chain%TYPE
            :=    ','
               || dald_parameter.fsbGetValue_Chain (
                      'TITR_MENSAJE_LEGAL_DISENO',
                      NULL)
               || ',';
        sbfromdisplay Varchar2(4000) := 'Open SmartFlex';

        CURSOR cuDatosAdicionales (
            nuTitr   or_task_type.task_type_id%TYPE)
        IS
            WITH
                tabla
                AS
                    (SELECT DISTINCT
                            SUBSTR (COLUMN_VALUE,
                                    1,
                                    INSTR (COLUMN_VALUE, ';') - 1)    titr,
                            SUBSTR (COLUMN_VALUE,
                                      INSTR (COLUMN_VALUE,
                                             ';',
                                             1,
                                             1)
                                    + 1,
                                      INSTR (COLUMN_VALUE,
                                             ';',
                                             1,
                                             2)
                                    - INSTR (COLUMN_VALUE,
                                             ';',
                                             1,
                                             1)
                                    - 1)                              grupo,
                            SUBSTR (COLUMN_VALUE,
                                      INSTR (COLUMN_VALUE,
                                             ';',
                                             1,
                                             2)
                                    + 1,
                                    9999)                             atributo
                       FROM TABLE (
                                LDC_BOUTILITIES.SPLITSTRINGS (sbDatoAdiciona,
                                                              '|'))
                      WHERE COLUMN_VALUE IS NOT NULL)
            SELECT *
              FROM tabla
             WHERE titr = nuTitr;

        CURSOR cuValorDatoAdi (nuTitr NUMBER, nuGrupo NUMBER, nuDato NUMBER)
        IS
            SELECT CASE
                       WHEN CEIL (s.capture_order / 20) > 1
                       THEN
                           DECODE (
                               (  s.capture_order
                                - (CEIL (s.capture_order / 20) * 10)),
                               1, name_1,
                               2, name_2,
                               3, name_3,
                               4, name_4,
                               5, name_5,
                               6, name_6,
                               7, name_7,
                               8, name_8,
                               9, name_9,
                               10, name_10,
                               11, name_11,
                               12, name_12,
                               13, name_13,
                               14, name_14,
                               15, name_15,
                               16, name_16,
                               17, name_17,
                               18, name_18,
                               19, name_19,
                               20, name_20,
                               'na')
                       ELSE
                           DECODE (s.capture_order,
                                   1, name_1,
                                   2, name_2,
                                   3, name_3,
                                   4, name_4,
                                   5, name_5,
                                   6, name_6,
                                   7, name_7,
                                   8, name_8,
                                   9, name_9,
                                   10, name_10,
                                   11, name_11,
                                   12, name_12,
                                   13, name_13,
                                   14, name_14,
                                   15, name_15,
                                   16, name_16,
                                   17, name_17,
                                   18, name_18,
                                   19, name_19,
                                   20, name_20,
                                   'na')
                   END    dato,
                   CASE
                       WHEN CEIL (s.capture_order / 20) > 1
                       THEN
                           DECODE (
                               (  s.capture_order
                                - (CEIL (s.capture_order / 20) * 10)),
                               1, value_1,
                               2, value_2,
                               3, value_3,
                               4, value_4,
                               5, value_5,
                               6, value_6,
                               7, value_7,
                               8, value_8,
                               9, value_9,
                               10, value_10,
                               11, value_11,
                               12, value_12,
                               13, value_13,
                               14, value_14,
                               15, value_15,
                               16, value_16,
                               17, value_17,
                               18, value_18,
                               19, value_19,
                               20, value_20,
                               'na')
                       ELSE
                           DECODE (s.capture_order,
                                   1, value_1,
                                   2, value_2,
                                   3, value_3,
                                   4, value_4,
                                   5, value_5,
                                   6, value_6,
                                   7, value_7,
                                   8, value_8,
                                   9, value_9,
                                   10, value_10,
                                   11, value_11,
                                   12, value_12,
                                   13, value_13,
                                   14, value_14,
                                   15, value_15,
                                   16, value_16,
                                   17, value_17,
                                   18, value_18,
                                   19, value_19,
                                   20, value_20,
                                   'na')
                   END    valor
              FROM or_tasktype_add_data  d,
                   ge_attrib_set_attrib  s,
                   ge_attributes         a,
                   or_requ_data_value    r
             WHERE     d.attribute_set_id = s.attribute_set_id
                   AND s.attribute_id = a.attribute_id
                   AND r.attribute_set_id = d.attribute_set_id
                   AND r.order_id = inuOrden
                   AND d.task_type_id = nutitr
                   AND d.attribute_set_id = nugrupo
                   AND s.attribute_id = nudato
                   AND r.task_type_id = d.task_type_id;
    BEGIN
        pkg_Traza.Trace (
               'Inicia LDC_BOORDENES.AL_DISENO_REALIZADO['
            || nuError
            || ']sbError:['
            || sbError
            || ']',
            15);
        sbSender := DALD_PARAMETER.fsbGetValue_Chain ('LDC_SMTP_SENDER');
        nuATTRIBUTE_ID := 5011052;              --NOMBRE_PROYECTO_FACTIBILIDAD

        OPEN cuOrdenes (inuOrden);

        FETCH cuOrdenes INTO rcOrdenes;

        rcSetAttrib.ATTRIBUTE_SET_ID := -1;

        OPEN cuSetAttrib (rcOrdenes.task_type_id, nuATTRIBUTE_ID);

        FETCH cuSetAttrib INTO rcSetAttrib;

        CLOSE cuSetAttrib;

        sbValorItem :=
            LDC_BOORDENES.FnugetValorOTbyDatAdd (
                rcOrdenes.task_type_id,
                rcSetAttrib.ATTRIBUTE_SET_ID,
                'NOMBRE_PROYECTO_FACTIBILIDAD',
                rcOrdenes.order_id);
        DBMS_OUTPUT.put_Line (
               rcOrdenes.task_type_id
            || '|'
            || rcSetAttrib.ATTRIBUTE_SET_ID
            || '|'
            || 'NOMBRE_PROYECTO_FACTIBILIDAD'
            || '|'
            || rcOrdenes.order_id);
        DBMS_OUTPUT.put_Line ('Valor Item: ' || sbValorItem);

        IF cuOrdenes%FOUND
        THEN
            IF    INSTR (sbTitrDis609,',' || rcOrdenes.task_type_id || ',') = 0
            THEN
                sbNotificacion :=
                       'Ha sido aprobado el Diseño  de Tipo '
                    || rcOrdenes.task_type_id
                    || ' - '
                    || rcOrdenes.tt_description
                    || CHR (13)
                    || ' correspondiente al Proyecto '
                    || sbValorItem
                    || CHR (13)
                    || ' bajo el No. de Orden '
                    || rcOrdenes.order_id
                    || ' Para mas detalle ver en el Sistema de Informacion Geografica.'
                    || CHR (13);
            ELSE
                sbNotificacion := 'Ha sido aprobado el Diseño  de Tipo '
                    || rcOrdenes.task_type_id
                    || ' - '
                    || rcOrdenes.tt_description
                    || '<br>'
                    || ' correspondiente al Proyecto '
                    || sbValorItem
                    || '<br>'
                    || ' bajo el No. de Orden '
                    || rcOrdenes.order_id
                    || ' Para mas detalle ver en el Sistema de Informacion Geografica.'
                    || '<br>';
                sbNotificacion :=
                       sbNotificacion
                    || '<p><b>Orden legalizada: </b>'
                    || rcOrdenes.ORDER_id
                    || '<br>';

                BEGIN
                    SELECT SUBSTR (c.order_comment, 1, 1000)
                      INTO sbComment
                      FROM or_order_comment c
                     WHERE     c.order_id = rcOrdenes.ORDER_id
                           AND c.legalize_comment = 'Y';
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        sbComment := NULL;
                END;

                sbNotificacion :=
                       sbNotificacion
                    || '<b>Unidad Operativa:</b>'
                    || rcOrdenes.operating_unit_id
                    || ' - '
                    || daor_operating_unit.fsbgetname (
                           rcOrdenes.operating_unit_id,
                           NULL)
                    || '<br>';

                IF sbComment IS NOT NULL
                THEN
                    BEGIN
                        sbNotificacion :=
                               sbNotificacion
                            || '<b>Comentario de legalizacion : </b>'
                            || sbComment
                            || '<br>';
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            NULL;
                    END;
                END IF;

                BEGIN
                    SELECT    o.order_id
                           || '  '
                           || o.task_type_id
                           || '-'
                           || daor_task_type.fsbgetdescription (
                                  o.task_type_id,
                                  NULL)    OtRegenerada
                      INTO sbOtRegenerada
                      FROM or_related_order r, or_order o
                     WHERE     r.order_id = rcOrdenes.ORDER_id
                           AND r.rela_order_type_id = 2
                           AND r.related_order_id = o.order_id
                           AND ROWNUM = 1;
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        sbOtRegenerada := NULL;
                END;

                IF sbOtRegenerada IS NOT NULL
                THEN
                    BEGIN
                        sbNotificacion :=
                               sbNotificacion
                            || '<b>OT generada en la legalizacion  : </b>'
                            || sbOtRegenerada
                            || '<br>';
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            NULL;
                    END;
                END IF;

                FOR reg IN cuDatosAdicionales (rcOrdenes.task_type_id)
                LOOP
                    FOR reg2
                        IN cuValorDatoAdi (reg.titr, reg.grupo, reg.atributo)
                    LOOP
                        BEGIN
                            sbNotificacion :=
                                   sbNotificacion
                                || '<b>'
                                || reg2.dato
                                || ' : </b>'
                                || reg2.valor
                                || '<br>';
                        EXCEPTION
                            WHEN OTHERS
                            THEN
                                NULL;
                        END;
                    END LOOP;
                END LOOP;
                                
            END IF;

            DBMS_OUTPUT.put_Line (SUBSTR (sbNotificacion, 1, 240));
        END IF;

        CLOSE cuOrdenes;

        -- fecha de la orden
        dtFecha := daor_order.fdtgetcreated_date (inuOrden);
        nuCausalId := daor_order.fnugetcausal_id (inuOrden);
        sbCausal := dage_causal.fsbgetdescription (nuCausalId);
        nuGeoLocaOrd :=
            LDC_PKGESTIONACARTASREDES.fnuGetGeoLocation (inuOrden);

        FOR rgMail IN cuEmail (nuGeoLocaOrd)
        LOOP
            
            IF rgMail.email IS NULL
            THEN
                Errors.SetError (
                    2741,
                       'No existe configuración de correo para la ubicación geográfica ['
                    || dage_geogra_location.fsbgetdescription (
                           nuGeoLocaOrd,
                           0)
                    || '] en la forma LDMGEO.');
                RAISE pkg_Error.CONTROLLED_ERROR;
            END IF;

            pkg_Correo.prcEnviaCorreo( 
                isbRemitente        => sbSender,
                isbDestinatarios    => rgMail.email,
                isbAsunto           => sbAsunto,
                isbMensaje          => sbNotificacion,
                isbDescRemitente    => sbfromdisplay  
            );

        END LOOP;

        pkg_Traza.Trace ('Finaliza LDC_BOORDENES.AL_DISENO_REALIZADO', 15);
        RETURN sbNotificacion;
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;
    END AL_DISENO_REALIZADO;

    /*****************************************************************
    Unidad       : ValidaMtoSerie
    Descripcion     : Valida serie con plan de mantenimiento
    Parametros          Descripcion
    ============        ===================
    inuOrden        numero de alerta
    isbTipoalerta   tipo de alerta a buscar

    Historia de Modificaciones
    Fecha       IDEntrega

    16-May-2013 Carlos Andres Dominguez - cadona
    ******************************************************************/
    FUNCTION ValidaMtoSerie (isbSerie VARCHAR2)
        RETURN NUMBER
    IS
        nuItemSeriado      ge_items_seriado.id_items_seriado%TYPE;
        nuRetorno          NUMBER;
        rcIf_maintenance   if_maintenance%ROWTYPE;

        CURSOR cuValidaSerie (nuExternal_id if_maintenance.external_id%TYPE)
        IS
            SELECT *
              FROM if_maintenance
             WHERE     external_id = nuExternal_id
                   AND maintenance_status = 3
                   AND expiration_date >= SYSDATE;
    BEGIN
        pkg_Traza.Trace (
               'Inicia LDC_BOORDENES.ValidaMtoSerie['
            || nuError
            || ']sbError:['
            || sbError
            || ']',
            15);
        -- Obtiene el ID dado una serie
        pkg_Traza.Trace ('isbSerie-->' || isbSerie, 15);
        ge_bcitemsseriado.getidbyserie (isbserie, nuitemseriado);
        pkg_Traza.Trace ('nuitemseriado-->' || nuitemseriado, 15);
        nuRetorno := pkConstante.NO_EXITO;

        OPEN cuValidaSerie (nuItemSeriado);

        FETCH cuValidaSerie INTO rcIf_maintenance;

        IF rcIf_maintenance.maintenance_id IS NOT NULL
        THEN
            nuRetorno := pkConstante.EXITO;
        END IF;

        CLOSE cuvalidaserie;

        pkg_Traza.Trace ('nuRetorno-->' || nuRetorno, 15);
        pkg_Traza.Trace ('Finaliza LDC_BOORDENES.ValidaMtoSerie', 15);
        RETURN nuRetorno;
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;
    END ValidaMtoSerie;

    /*****************************************************************
    Unidad       : proincumplereparacion
    Descripcion     : Al legalizar como incumplida la orden de reparacion, debe cerrar la orden de
                   certificacion con la misma causal.
                   Orden de instalacion:
                   12163 INSPECCION Y/O CERTIFICACION TRABAJO ASOCIADO
                   12164 INSPECCION Y/O CERTIFICACION TRABAJOS REVISION PERIODICA

    Autor: Luz Andrea Angel/OLSoftware
    Fecha: Mayo 30/2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    07-08-2013        luzaa             NC459:Se cambia el API de legalizacion.
                                        Adicionalmente para que los tipos de trabajo que se excluyen sean
                                        configurables
    29-11-2013        luzaa             NC1925: Se modifica el codigo ya que habia una linea de codigo que impedia cerrar la orden de certificacion
    24-Abril-2014   Jorge Valiente      Aranda 3445: 1. Que si en la solicitud existe una orden de trabajo del tipo
                                                          ??12475 - CORRECCIÓN DE DEFECTO SERVICIOS ASOCIADOS O PRP??,
                                                          en estado diferente a ??8 ?? CERRADO?? y la última orden de trabajo del tipo
                                                          ??12163 - INSPECCIÓN Y/O CERTIFICACIÓN TRABAJO ASOCIADO o
                                                          12164 - INSPECCIÓN Y/O CERTIFICACION TRABAJOS REVISI??N PERIODICA??, con una causal de
                                                          legalizaci??n NO VALIDA;??..  NO DEBE permitir la legalizaci??n de las
                                                          ordenes de trabajo de cargo por conexi??n e Instalaci??n interna,
                                                          tanto residencial como comercial
    ******************************************************************/
    PROCEDURE proincumplereparacion
    IS
        --valida que la orden que llega sea de reparacion
        CURSOR cuObtOrdenReparacion (nuorden or_order.order_id%TYPE)
        IS
            SELECT a.order_id, a.task_type_id, b.causal_id
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.task_type_id IN
                           (SELECT id_trabcert
                              FROM ldc_trab_cert
                             WHERE ldc_boutilities.fsbBuscaToken (
                                       dald_parameter.fsbgetvalue_chain (
                                           'TRAB_NO_GENERA_CERT_ASOCIADOS'),
                                       id_trabcert,
                                       ',') =
                                   'N')
                   AND a.order_id = nuOrden;

        --obtiene la solicitud asociada a la orden de reparacion
        CURSOR cuSolicitud (nuOrden or_order.order_id%TYPE)
        IS
            SELECT b.package_id
              FROM or_order a, or_order_activity b
             WHERE a.order_id = b.order_id AND b.order_id = nuOrden;

        --obtiene la orden de certificacion asociada a la solicitud
        CURSOR cuordencert (nusolrepa mo_packages.package_id%TYPE)
        IS
            SELECT a.order_id,
                   a.task_type_id,
                   b.operating_unit_id,
                   a.order_activity_id
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.task_type_id IN (12163, 12164)
                   AND b.order_status_id = 5
                   AND a.package_id = nusolrepa;

        --obtiene las ordenes de reparacion incumplidas
        CURSOR cucantincumple (nusolrepa         mo_packages.package_id%TYPE,
                               sbcausaincumple   VARCHAR2)
        IS
            SELECT COUNT (*)
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.task_type_id IN
                           (SELECT id_trabcert
                              FROM ldc_trab_cert
                             WHERE ldc_boutilities.fsbBuscaToken (
                                       dald_parameter.fsbgetvalue_chain (
                                           'TRAB_NO_GENERA_CERT_ASOCIADOS'),
                                       id_trabcert,
                                       ',') =
                                   'N')
                   AND a.package_id = nusolrepa
                   AND b.ORDER_STATUS_ID = 8
                   AND ldc_boutilities.fsbbuscatoken (sbCausaIncumple,
                                                      TO_CHAR (b.causal_id),
                                                      ',') =
                       'S';

        --cantidad de ordenes de reparacion de una solicitud
        CURSOR cucantotrepara (nusolic or_order_activity.package_id%TYPE)
        IS
            SELECT COUNT (*)
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.task_type_id IN
                           (SELECT ID_TRABCERT
                              FROM LDC_TRAB_CERT
                             WHERE ldc_boutilities.fsbbuscatoken (
                                       dald_parameter.fsbgetvalue_chain (
                                           'TRAB_NO_GENERA_CERT_ASOCIADOS'),
                                       id_trabcert,
                                       ',') =
                                   'N')
                   AND b.order_status_id IN (5, 8)
                   AND a.package_id = nusolic;

        --obtiene las ordenes de reparacion incumplidas
        CURSOR cuobtieneincumplida (nusolrepa         mo_packages.package_id%TYPE,
                                    sbcausaincumple   VARCHAR2)
        IS
            SELECT b.order_id, b.causal_id
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.task_type_id IN
                           (SELECT id_trabcert
                              FROM ldc_trab_cert
                             WHERE ldc_boutilities.fsbBuscaToken (
                                       dald_parameter.fsbgetvalue_chain (
                                           'TRAB_NO_GENERA_CERT_ASOCIADOS'),
                                       id_trabcert,
                                       ',') =
                                   'N')
                   AND a.package_id = nusolrepa
                   AND b.order_status_id = 8
                   AND ldc_boutilities.fsbbuscatoken (sbcausaincumple,
                                                      TO_CHAR (b.causal_id),
                                                      ',') =
                       'S'
                   AND ROWNUM = 1;

        --ordenes en estado 7
        CURSOR cucantotejecutadas (nusolic or_order_activity.package_id%TYPE)
        IS
            SELECT COUNT (*)
              FROM or_order b, OR_ORDER_ACTIVITY c
             WHERE     b.order_id = c.order_id
                   AND b.task_type_id IN
                           (SELECT id_trabcert
                              FROM ldc_trab_cert
                             WHERE ldc_boutilities.fsbBuscaToken (
                                       dald_parameter.fsbgetvalue_chain (
                                           'TRAB_NO_GENERA_CERT_ASOCIADOS'),
                                       id_trabcert,
                                       ',') =
                                   'N')
                   AND b.order_status_id = 7
                   AND c.package_id = nusolic;

        CURSOR cuclasecausa (inucausa ge_causal.causal_id%TYPE)
        IS
            SELECT class_causal_id
              FROM ge_causal
             WHERE causal_id = inucausa;

        CURSOR cuPersonaUT (nuUnidad or_order.operating_unit_id%TYPE)
        IS
            SELECT person_id
              FROM or_oper_unit_persons
             WHERE operating_unit_id = nuunidad AND ROWNUM = 1;

        nuordenrepara                   or_order.order_id%TYPE;
        nuordenr                        or_order.order_id%TYPE;
        nucausalincr                    ge_causal.causal_id%TYPE;
        sbcausales                      ld_parameter.value_chain%TYPE;
        nutipotrabR                     or_order.task_type_id%TYPE;
        nusolicitud                     or_order_activity.package_id%TYPE;
        nuordencert                     or_order.order_id%TYPE;
        nutipotrabce                    or_order.task_type_id%TYPE;
        nuunidoper                      or_order.operating_unit_id%TYPE;
        nuactividad                     or_order_activity.order_activity_id%TYPE;
        nuclasecausa                    ge_causal.class_causal_id%TYPE;
        nuorden                         or_order.order_id%TYPE;
        nucausal                        or_order.causal_id%TYPE;
        nunumeincumplidas               NUMBER;
        nunumereparacion                NUMBER;
        nucantejecutadas                NUMBER;
        nupersonid                      NUMBER;
        nuerrorcode                     NUMBER;
        sberrormessage                  VARCHAR2 (4000);
        nucantactividad                 NUMBER;
        sbcomment                       VARCHAR2 (4000);
        sbdataorder                     VARCHAR2 (2000);
        bCausalInc                      BOOLEAN := FALSE;
        nuCausalWF                      ge_equivalenc_values.target_value%TYPE;
        nuInstance                      NUMBER;
        nuVal                           NUMBER := 0;       ---- Nueva variable

        --Inicia Aranda 3445
        --CURSOR PARA IDENTIFICAR LA CANTIDAD DE ORDENES DE
        --12163 - INSPECCIÓN Y/O CERTIFICACIÓN TRABAJO ASOCIADO o 12164 - INSPECCIÓN Y/O CERTIFICACION TRABAJOS REVISI??N PERIODICA
        --CREADAS Y LEGALIZADAS
        CURSOR CUCANTIDADOTCERTIFICACION (
            nupackage   mo_packages.package_id%TYPE)
        IS
            SELECT (SELECT COUNT (
                               DAOR_ORDER.FDTGETCREATED_DATE (
                                   OOA.ORDER_ID,
                                   NULL))
                      FROM OR_ORDER_ACTIVITY OOA
                     WHERE     DAOR_ORDER.FNUGETTASK_TYPE_ID (
                                   OOA.ORDER_ID,
                                   NULL) IN
                                   (DALD_PARAMETER.fnuGetNumeric_Value (
                                        'COD_TASK_TYPE_INSP_CERT_TRAB_A',
                                        NULL),
                                    DALD_PARAMETER.fnuGetNumeric_Value (
                                        'COD_TASK_TYPE_INSP_CERT_TRA_RP',
                                        NULL))
                           AND OOA.PACKAGE_ID = nupackage)    CANTIDAD_TOTAL,
                   (SELECT COUNT (
                               DAOR_ORDER.FDTGETCREATED_DATE (
                                   OOA.ORDER_ID,
                                   NULL))
                      FROM OR_ORDER_ACTIVITY OOA
                     WHERE     DAOR_ORDER.FNUGETTASK_TYPE_ID (
                                   OOA.ORDER_ID,
                                   NULL) IN
                                   (DALD_PARAMETER.fnuGetNumeric_Value (
                                        'COD_TASK_TYPE_INSP_CERT_TRAB_A',
                                        NULL),
                                    DALD_PARAMETER.fnuGetNumeric_Value (
                                        'COD_TASK_TYPE_INSP_CERT_TRA_RP',
                                        NULL))
                           AND OOA.PACKAGE_ID = nupackage
                           AND DAOR_ORDER.FNUGETORDER_STATUS_ID (
                                   OOA.ORDER_ID,
                                   NULL) =
                               DALD_PARAMETER.fnuGetNumeric_Value (
                                   'ESTADO_CERRADO',
                                   NULL))                     CANTIDAD_LEGALIZADA
              FROM DUAL;

        TEMPCUCANTIDADOTCERTIFICACION   CUCANTIDADOTCERTIFICACION%ROWTYPE;

        --CURSOR PARA IDENTIFICAR LA CANTIDAD DE ORDENES DE
        --12475 CORRECCIÓN DE DEFECTO SERVICIOS ASOCIADOS O PRP
        --CREADAS Y LEGALIZADAS
        CURSOR CUCANTIDADOTCORRECION (nupackage mo_packages.package_id%TYPE)
        IS
            SELECT (SELECT COUNT (
                               DAOR_ORDER.FDTGETCREATED_DATE (
                                   OOA.ORDER_ID,
                                   NULL))
                      FROM OR_ORDER_ACTIVITY OOA
                     WHERE     DAOR_ORDER.FNUGETTASK_TYPE_ID (
                                   OOA.ORDER_ID,
                                   NULL) =
                               DALD_PARAMETER.fnuGetNumeric_Value (
                                   'COD_CORREC_DEF_SER_ASO_PRP',
                                   NULL)
                           AND OOA.PACKAGE_ID = nupackage)    CANTIDAD_TOTAL,
                   (SELECT COUNT (
                               DAOR_ORDER.FDTGETCREATED_DATE (
                                   OOA.ORDER_ID,
                                   NULL))
                      FROM OR_ORDER_ACTIVITY OOA
                     WHERE     DAOR_ORDER.FNUGETTASK_TYPE_ID (
                                   OOA.ORDER_ID,
                                   NULL) =
                               DALD_PARAMETER.fnuGetNumeric_Value (
                                   'COD_CORREC_DEF_SER_ASO_PRP',
                                   NULL)
                           AND OOA.PACKAGE_ID = nupackage
                           AND DAOR_ORDER.FNUGETORDER_STATUS_ID (
                                   OOA.ORDER_ID,
                                   NULL) =
                               DALD_PARAMETER.fnuGetNumeric_Value (
                                   'ESTADO_CERRADO',
                                   NULL))                     CANTIDAD_LEGALIZADA
              FROM DUAL;

        TEMPCUCANTIDADOTCORRECION       CUCANTIDADOTCORRECION%ROWTYPE;

        --CURSOR PARA OBTENER LA ULTIMA ORDEN DE 12162 INSPECCION Y/O CERTIFICACION INSTALACIONES
        CURSOR CUULTIMAOTCERTIFICAION (nupackage mo_packages.package_id%TYPE)
        IS
            SELECT OOA.ORDER_ID,
                   DAOR_ORDER.FNUGETCAUSAL_ID (OOA.ORDER_ID)    CAUSAL_LEGALIZACION
              FROM OR_ORDER_ACTIVITY OOA
             WHERE     DAOR_ORDER.FNUGETTASK_TYPE_ID (OOA.ORDER_ID,
                                                           NULL) IN
                           (DALD_PARAMETER.fnuGetNumeric_Value (
                                'COD_TASK_TYPE_INSP_CERT_TRAB_A',
                                NULL),
                            DALD_PARAMETER.fnuGetNumeric_Value (
                                'COD_TASK_TYPE_INSP_CERT_TRA_RP',
                                NULL))
                   AND OOA.PACKAGE_ID = nupackage
                   AND DAOR_ORDER.FDTGETLEGALIZATION_DATE (OOA.ORDER_ID) IN
                           (SELECT MAX (
                                       DAOR_ORDER.FDTGETLEGALIZATION_DATE (
                                           OOA.ORDER_ID,
                                           NULL))
                              FROM OR_ORDER_ACTIVITY OOA
                             WHERE     DAOR_ORDER.FNUGETTASK_TYPE_ID (
                                           OOA.ORDER_ID,
                                           NULL) IN
                                           (DALD_PARAMETER.fnuGetNumeric_Value (
                                                'COD_TASK_TYPE_INSP_CERT_TRAB_A',
                                                NULL),
                                            DALD_PARAMETER.fnuGetNumeric_Value (
                                                'COD_TASK_TYPE_INSP_CERT_TRA_RP',
                                                NULL))
                                   AND OOA.PACKAGE_ID = nupackage);

        TEMPCUULTIMAOTCERTIFICAION      CUULTIMAOTCERTIFICAION%ROWTYPE;

        --CURSOR PARA OBTENER LA ULTIMA ORDEN DE 12474 CORRECCIÓN DE DEFECTO EN INSTALACIONES NUEVAS
        CURSOR CUULTIMAOTCORRECCION (nupackage mo_packages.package_id%TYPE)
        IS
            SELECT OOA.ORDER_ID,
                   DAOR_ORDER.FNUGETCAUSAL_ID (OOA.ORDER_ID)    CAUSAL_LEGALIZACION
              FROM OR_ORDER_ACTIVITY OOA
             WHERE     DAOR_ORDER.FNUGETTASK_TYPE_ID (OOA.ORDER_ID,
                                                           NULL) =
                       DALD_PARAMETER.fnuGetNumeric_Value (
                           'COD_INSP_CERT_TASK_TYPE',
                           NULL)
                   AND OOA.PACKAGE_ID = nupackage
                   AND DAOR_ORDER.FDTGETLEGALIZATION_DATE (OOA.ORDER_ID) IN
                           (SELECT MAX (
                                       DAOR_ORDER.FDTGETLEGALIZATION_DATE (
                                           OOA.ORDER_ID,
                                           NULL))
                              FROM OR_ORDER_ACTIVITY OOA
                             WHERE     DAOR_ORDER.FNUGETTASK_TYPE_ID (
                                           OOA.ORDER_ID,
                                           NULL) =
                                       DALD_PARAMETER.fnuGetNumeric_Value (
                                           'COD_INSP_CERT_TASK_TYPE',
                                           NULL)
                                   AND OOA.PACKAGE_ID = nupackage);

        TEMPCUULTIMAOTCORRECCION        CUULTIMAOTCORRECCION%ROWTYPE;
        SBCAUSALESVALIDAS               VARCHAR2 (2000);
    --Fin Aranda 3445
    BEGIN
        pkg_Traza.Trace ('Inicio LDC_BOORDENES.proincumplereparacion', 10);
        --orden de reparacion de la instancia
        nuordenrepara := or_bolegalizeorder.fnugetcurrentorder;
        pkg_Traza.Trace ('orden de reparacion: ' || nuordenrepara, 10);

        --valida que se trate de una orden de reparacion
        OPEN cuObtOrdenReparacion (nuordenrepara);

        FETCH cuobtordenreparacion INTO nuOrdenR, nuTipoTrabR, nuCausalIncR;

        CLOSE cuObtOrdenReparacion;

        IF (nuordenr IS NOT NULL OR nuordenr > 0)
        THEN
            --obtiene la solicitud asociada a la orden de reparacion
            OPEN cuSolicitud (nuordenrepara);

            FETCH cuSolicitud INTO nusolicitud;

            CLOSE cuSolicitud;

            --INICIO ARANDA 3445
            --CURSOR PARA OBTENER LA UTLIMA ORDEN 12163 O 12164 EN LA SOLICITUD
            SBCAUSALESVALIDAS :=
                dald_parameter.fsbgetvalue_chain ('COD_CAUSAL_VALIDA');

            --OBTENER LA ULTIMA ORDEN DE CERTIFICACION 12163 O 12164
            OPEN CUULTIMAOTCERTIFICAION (nusolicitud);

            FETCH CUULTIMAOTCERTIFICAION INTO TEMPCUULTIMAOTCERTIFICAION;

            IF CUULTIMAOTCERTIFICAION%FOUND
            THEN
                --VALIDAR SI LA CAUSAL DE LA ORDEN 12163 O 12164 ES UNA CAUSAL VALIDA DE LEGALIZACION
                IF (ldc_boutilities.fsbbuscatoken (
                        SBCAUSALESVALIDAS,
                        TO_CHAR (
                            TEMPCUULTIMAOTCERTIFICAION.CAUSAL_LEGALIZACION),
                        ',') =
                    'N')
                THEN
                    OPEN CUCANTIDADOTCORRECION (nusolicitud);

                    FETCH CUCANTIDADOTCORRECION
                        INTO TEMPCUCANTIDADOTCORRECION;

                    IF TEMPCUCANTIDADOTCORRECION.CANTIDAD_TOTAL <>
                       TEMPCUCANTIDADOTCORRECION.CANTIDAD_LEGALIZADA
                    THEN
                        --/*
                        ge_boerrors.seterrorcodeargument (
                            ld_boconstans.cnugeneric_error,
                            'Existen ordenes de correcci??n de defecto servicios asociados o prp sin legalizar.');
                        RAISE pkg_Error.CONTROLLED_ERROR;
                    --*/
                    END IF;

                    CLOSE CUCANTIDADOTCORRECION;
                END IF;

                --VALIDAR SI LA CAUSAL DE LA ULTIMA ORDEN 12163 O 12164 ES UNA CAUSAL VALIDA DE LEGALIZACION
                IF (ldc_boutilities.fsbbuscatoken (
                        SBCAUSALESVALIDAS,
                        TO_CHAR (
                            TEMPCUULTIMAOTCERTIFICAION.CAUSAL_LEGALIZACION),
                        ',') =
                    'N')
                THEN
                    --/*
                    ge_boerrors.seterrorcodeargument (
                        ld_boconstans.cnugeneric_error,
                        'La ultima orden de inspeccion y/o certificacion legalizada no tiene causal valida.');
                    RAISE pkg_Error.CONTROLLED_ERROR;
                --*/
                END IF;
            END IF;

            CLOSE CUULTIMAOTCERTIFICAION;

            /*
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                              'DETENER LEGALIZACION DE ORDENES CON TIPO DE TRABAJO 12149, 12150, 12151, 12152');

            raise pkg_Error.CONTROLLED_ERROR;
            --*/
            --FIN ARANDA 3445
            IF (nusolicitud IS NOT NULL OR nusolicitud > 0)
            THEN
                --obtiene las causales configuradas
                sbcausales :=
                    dald_parameter.fsbgetvalue_chain (
                        'CAUSAL_INCUMPLE_REPARACION');
                pkg_Traza.Trace (
                    'causales incumplimiento-sbCausales: ' || sbCausales,
                    10);

                --obtiene la cantidad de ordenes incumplidas
                OPEN cucantincumple (nusolicitud, sbCausales);

                FETCH cucantincumple INTO nuNumeIncumplidas;

                CLOSE cucantincumple;

                --obtiene la cantidad de ordenes de reparacion
                OPEN cucantotrepara (nusolicitud);

                FETCH cucantotrepara INTO nunumereparacion;

                CLOSE cucantotrepara;

                --obtiene las ordenes ejecutadas
                OPEN cucantotejecutadas (nusolicitud);

                FETCH cucantotejecutadas INTO nucantejecutadas;

                CLOSE cucantotejecutadas;

                --valida si la causal q llega es de incumplimiento
                IF (nucausalincr IS NOT NULL)
                THEN
                    pkg_Traza.Trace (
                        'causal incumplimiento: ' || nucausalincr,
                        10);

                    IF (ldc_boutilities.fsbbuscatoken (
                            sbcausales,
                            TO_CHAR (nucausalincr),
                            ',') =
                        'S')
                    THEN
                        bcausalinc := TRUE;
                        pkg_Traza.Trace ('cumple con causal', 10);
                    END IF;
                END IF;

                IF (nucantejecutadas <> 0)
                THEN
                    IF (bCausalInc)
                    THEN
                        ge_boerrors.seterrorcodeargument (
                            ld_boconstans.cnugeneric_error,
                            'La causal usada no es valida, ya que existe una orden ejecutada para la misma solicitud');
                        RAISE pkg_Error.CONTROLLED_ERROR;
                    END IF;
                ELSE
                    --valida que el numero de incumplidas sea igual al numero de ot de reparacion
                    pkg_Traza.Trace (
                        'nuNumeIncumplidas--> ' || nunumeincumplidas,
                        10);
                    pkg_Traza.Trace (
                        'nunumereparacion--> ' || nunumereparacion,
                        10);

                    IF (nuNumeIncumplidas = (nunumereparacion - 1))
                    THEN
                        --valida que la causal de reparacion sea una de las causales de incumplimiento
                        IF (bCausalInc)
                        THEN
                            --obtiene la orden de certificacion asociada a la solicitud que origino la reparacion
                            OPEN cuordencert (nusolicitud);

                            FETCH cuordencert
                                INTO nuordencert,
                                     nutipotrabce,
                                     nuunidoper,
                                     nuactividad;

                            CLOSE cuOrdenCert;

                            --obtiene el id de la persona registrada en la aplicacion
                            OPEN cuPersonaUT (nuunidoper);

                            FETCH cuPersonaUT INTO nupersonid;

                            CLOSE cupersonaut;

                            pkg_Traza.Trace (
                                'persona leg. automatica: ' || nupersonid,
                                10);
                            pkg_Traza.Trace (
                                   'orden certificacion a cerrar: '
                                || nuordencert,
                                10);
                            -->>NC459. ajuste al proceso de legalizacion por cambio de API
                            pkg_Traza.Trace (
                                'nuordencert legalizar: ' || nuordencert,
                                10);
                            ldc_closeOrder (nuordencert,
                                            nucausalincr,
                                            nupersonid,
                                            nuunidoper);

                            --legaliza la orden de certificacion con la causal de incumplimiento de la orden de reparacion
                            --sbComment := 'Legalizacion automatica por incumplimiento OT Reparacion';
                            --sbdataorder:= nuordencert||'|'||nucausalincr||'|'||nupersonid||'||'||nuactividad||'>'||nucantactividad||';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||1277;'||sbcomment;
                            --os_legalizeorders(sbdataorder, sysdate, sysdate, sysdate, nuerrorcode, sberrormessage);
                            /*Este segmento es adicionado por Alvaro Zapata con el apoyo de Diego Soto ya que no se estaba empujando el WF*/
                            -- Obtiene la causal de WF
                            SELECT target_value
                              INTO nuCausalWF
                              FROM (SELECT target_value
                                      FROM ge_equivalenc_values
                                     WHERE     equivalence_set_id = 218
                                           AND origin_value = nucausalincr
                                           AND ROWNUM = 1
                                    UNION ALL
                                    SELECT '-1' FLAG_VALIDATE FROM DUAL)
                             WHERE ROWNUM = 1;

                            -- Obtiene la instance del Flujo
                            SELECT instance_id
                              INTO nuInstance
                              FROM or_order_activity
                             WHERE ORDER_id = nuordenrepara AND ROWNUM = 1;

                            --- NUEVA LINEA
                            -- Valida si tiene configurada Regeneracion que detiene el flujo.
                            SELECT COUNT (*)
                              INTO nuVal
                              FROM or_regenera_activida
                             WHERE     actividad IN
                                           (SELECT activity_id
                                              FROM or_order_activity
                                             WHERE order_id IN
                                                       (nuordenrepara))
                                   AND or_regenera_activida.id_causal =
                                       nucausalincr
                                   AND or_regenera_activida.actividad_wf =
                                       'Y';

                            -- Envio de Actividad a la Cola de WF
                            IF nuCausalWF <> -1 AND nuVal = 0
                            THEN
                                --- NUEVA LINEA
                                wf_boanswer_receptor.answerreceptorbyqueue (
                                    nuInstance,
                                    TO_NUMBER (nuCausalWF));
                            END IF;                            --- NUEVA LINEA
                        /* if (nuerrorcode <> 0) then
                           rollback;
                           gw_boerrors.checkerror(nuerrorcode, sberrormessage);
                           raise pkg_Error.CONTROLLED_ERROR;
                         end if;*/
                        -->>NC459
                        END IF;
                    ELSE
                        pkg_Traza.Trace ('no cumple la cantidad de ordenes',
                                         10);

                        IF (bCausalInc)
                        THEN
                            OPEN cuobtieneincumplida (nusolicitud,
                                                      sbCausales);

                            FETCH cuobtieneincumplida INTO nuorden, nucausal;

                            CLOSE cuobtieneincumplida;

                            pkg_Traza.Trace (
                                   'no cumple la cantidad de ordenes-nucausal:'
                                || nucausal,
                                10);

                            IF (nucausal <> nucausalincr)
                            THEN
                                ge_boerrors.seterrorcodeargument (
                                    ld_boconstans.cnugeneric_error,
                                    'La causal de incumplimiento usada no es igual a la usada con anterioridad.');
                                RAISE pkg_Error.CONTROLLED_ERROR;
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;

        pkg_Traza.Trace ('Fin LDC_BOORDENES.proincumplereparacion', 10);
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE;
        WHEN OTHERS
        THEN
            ge_boerrors.seterrorcodeargument (
                Ld_Boconstans.cnuGeneric_Error,
                'Error al ejecutar proceso proincumplereparacion');
            RAISE;
    END proincumplereparacion;

    /*****************************************
    Metodo: FsbGetIdDept
    Descripcion:  Realiza la asignacion masiva de ordenes generadas  por FGCB-->Gestion de Cobro
                  para la gestion por medio del IVR.
    Autor: Alvaro Zapata
    Fecha: Mayo 28/2013

     ******************************************/
    PROCEDURE prAsigMasivOrdGC (ORDER_ID OR_ORDER.ORDER_ID%TYPE)
    IS
        NuUT              NUMBER;
        onuErrorCode      NUMBER (18);
        osbErrorMessage   VARCHAR2 (2000);
    BEGIN
        NuUT :=
            UT_CONVERT.FNUCHARTONUMBER (
                dald_Parameter.fsbGetValue_Chain ('UNID_OPER_ORION')); --Unidad de trabajo ORION
        os_assign_order (ORDER_ID,
                         NuUT,
                         SYSDATE,
                         SYSDATE,
                         onuErrorCode,
                         osbErrorMessage);
        pkg_Traza.Trace (
               'Mensaje Asigna Cuadrilla: '
            || onuErrorCode
            || ' ** '
            || osbErrorMessage,
            8);
    EXCEPTION
        WHEN OTHERS
        THEN
            Errors.getError (onuErrorCode, osbErrorMessage);
            pkg_Traza.Trace (
                'Error Asignacion OT: ' || ORDER_ID || ' ** ' || SQLERRM,
                8);
    END prAsigMasivOrdGC;

    /*****************************************
    Autor: Luz Andrea Angel/OLSoftware
    Metodo: procreaitemspago
    Descripcion:  Se encarga de crear la orden con los items de pago para
                  las ordenes correspondientes de cargo por conexion e instalacion
    Fecha: Mayo 28/2013

    Fecha                IDEntrega           Modificacion
    ============    ================    ============================================
    13-09-2013          luzaa          NC 707:se modifican los parametros que se pasan al API para la generacion
                                       de la orden de novedad, ya que el parametro persona debe ser NULL y el costo
                                       debe ser NULL no cero (0)
    17-09-2013          luzaa          NC746:se ajusta la logica debido a que la solicitud de venta puede incluir o no,
                                       las dos ordenes (Cargo x conexion y/o Instalacion)
    20-09-2013          luzaa          NC 746: se ajusta logica del procedimiento procreaitemspago, ya que la OT ultima puede ser instalacion y no
                                       necesriamente la de cargo, como se habia definido
    28-09-2013          luzaa          NC 746: se ajusto toda la logica para que tenga en cuenta la direccion, ya que para multifamiliares es por solicitud
                                       y direccion
    16-10-2013          luzaa          NC 746: Se implementa mensaje que indica si falta configuracion de items en la forma ORITC
    18-10-2013          luzaa          NC 746: Se ajusta para que cuando se trate de una categoria comercial, solo pague la ACOMETIDA
    30-10-2013          luzaa          NC 1437: Se ajusta en procreaitemspago, el material GALVANIZADO por ACERO. Ademas que se ajsute el mensaje correspondiente.
    12-11-2013          luzaa          NC 1148: se cambia la constructora que crea novedades, por constructora que crea ordenes cerradas y posteriormente se debe
                                       actualizar el valor para que se incluya en or_order_items
    26-11-2013         luzaa           NC1776: se devuelve la creacion de items automaticos de ordenes cerradas a novedades
    13-12-2013     Sayra Ocoro         NC 2094: Se adiciona metodo para obtener el valor del item antes de crear la novedad
    14-01-2014     Jorge Valiente      NC 2493: Se adicionara un cursor el cual permita determinar cuando el producto es
                                                generico.
                                                En caso de ser generico se utilizara un nuevo cursor el cual obtendra la categoria de la direccion yno del producto.
                                                en caso contrario se utilizara el cursor que siempre se a venido usando en el desarrollo.
                                                Nombre nuevo cursor
    07-02-2014     Jorge Valiente      Aranda Cambio 2706: Se controla el ingreso del
                                                           valor de la novedad de los items automaticos para que sean mayores que 0.
                                                           ya que el servicio de novedades de OPEN no soporta valor 0.
                                                           Esta validacion sera para LONGITUD DE ACOMETIDA y LONGITUD DE INTERNA
    26-02-2014     Jorge Valiente      Aranda Cambio 2940: Se valida item fijo y variable para establecer
                                                           de que localidad se obtendra el item configurado en
                                                           ORITC
    10-03-2014     Sayra Ocoró         Aranda 3023:  Se modifica cursor para validar si direcci??n E a multifamiliar
    02-04-2014     Sayra Ocoró         Aranda 3170:  Se modifica cursor para validar si direcci??n E a multifamiliar
                                                   y se modifica la Creación de items para constructoras
    03-04-2014     Jorge Valiente      Aranda Cambio XXXX: Se cambio la logica de generacion de ITEMS Automaticos para
                                                           que genere los items directamente en la orden original de cargo
                                                           x conexion y/o interna (Instalacion)
    25-09-2014     Jorge Valiente      RNP 1751: Validacion en el item de valvula 4294990. En la orden de interna.
                                                 Solo permitira agregar este item si la orden esta asociada aun estrato
                                                 configurado en el parametro COD_SUBCATE_COBRO
                                                 CODIGO DE SUBCATEGORIAS A LOS QUE LES COBRA UN ITEM
                                                 Se creara un cursor para que valide si el subcategoria(Estrato)
                                                 esta dentro del parametro COD_SUBCATE_COBRO.
                                                 En caso de existir retorn 1 en caso contratio 0
    23-06-2015      Mmejia             Aranda 6555: Se modifica los cursores cuordencargo cuordeninst para que filtre las
                                       ordenes legalizadas con causal de exito.Tambien se modifica el cursor cuobtieneitems
                                       para que tenga los itmnes correctamente.
    08-07-2015      Mmejia             Aranda 6555:Se modifica los cursores que obtienen la informacino de ordenes por medio
                                       del paquete y la direccino para que obtenga la orden con causal de legalizacion clase
                                       exito.
    ******************************************************/
    PROCEDURE procreaitemspago (nuordeninstance or_order.order_id%TYPE)
    IS
        --cursor 1751
        CURSOR cudatoexiste (nuvalor NUMBER)
        IS
            SELECT COUNT (*)
              FROM DUAL
             WHERE nuvalor IN
                       (SELECT TO_NUMBER (COLUMN_VALUE)
                          FROM TABLE (
                                   ldc_boutilities.splitstrings (
                                       DALD_PARAMETER.fsbGetValue_Chain (
                                           'COD_SUBCATE_COBRO',
                                           NULL),
                                       ',')));

        nucudatoexiste         NUMBER := 0;

        --valida que la orden que llega sea de CxC
        CURSOR cuordencargoinstancia (nuorden or_order.order_id%TYPE)
        IS
            SELECT a.order_id,
                   a.task_type_id,
                   (SELECT ge.geo_loca_father_id
                      FROM ge_geogra_location ge
                     WHERE ge.geograp_location_id = aa.geograp_location_id)
                       cod_depa,
                   (SELECT ge.geograp_location_id
                      FROM ge_geogra_location ge
                     WHERE     ge.geograp_location_id =
                               aa.geograp_location_id
                           AND ge.geog_loca_area_type = 3)
                       id_loca,
                   p.category_id,
                   p.subcategory_id,
                   o.operating_unit_id,
                   a.address_id
              FROM or_order_activity  a,
                   servsusc           b,
                   pr_product         p,
                   ab_address         aa,
                   or_order           o
             WHERE     a.order_id = o.order_id
                   AND a.subscription_id = b.sesususc
                   AND p.product_id = a.product_id
                   AND aa.address_id = a.address_id
                   AND a.task_type_id IN (12150, 12152)
                   AND a.order_id = nuorden;

        CURSOR cuordencargo (nusolicvta    or_order_activity.order_id%TYPE,
                             nudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT /*+ CHOOSE */
                   a.order_id,
                   a.task_type_id,
                   (SELECT ge.geo_loca_father_id
                      FROM ge_geogra_location ge
                     WHERE ge.geograp_location_id = aa.geograp_location_id)
                       cod_depa,
                   (SELECT ge.geograp_location_id
                      FROM ge_geogra_location ge
                     WHERE     ge.geograp_location_id =
                               aa.geograp_location_id
                           AND ge.geog_loca_area_type = 3)
                       id_loca,
                   p.category_id,
                   p.subcategory_id,
                   o.operating_unit_id,
                   a.address_id
              FROM or_order_activity  a,
                   servsusc           b,
                   pr_product         p,
                   ab_address         aa,
                   or_order           o,
                   GE_CAUSAL          gec
             WHERE     a.order_id = o.order_id
                   AND a.subscription_id = b.sesususc
                   AND p.product_id = a.product_id
                   AND aa.address_id = a.address_id
                   AND a.task_type_id IN (12150, 12152)
                   AND o.causal_id = gec.causal_id
                   AND gec.class_causal_id = 1
                   AND a.package_id = nusolicvta
                   AND a.address_id = nudireccion;

        CURSOR cuordencargoEFG (
            nusolicvta    or_order_activity.order_id%TYPE,
            nudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT a.order_id,
                   a.task_type_id,
                   (SELECT ge.geo_loca_father_id
                      FROM ge_geogra_location ge
                     WHERE ge.geograp_location_id = aa.geograp_location_id)
                       cod_depa,
                   (SELECT ge.geograp_location_id
                      FROM ge_geogra_location ge
                     WHERE     ge.geograp_location_id =
                               aa.geograp_location_id
                           AND ge.geog_loca_area_type = 3)
                       id_loca,
                   p.category_id,
                   p.subcategory_id,
                   b.operating_unit_id,
                   a.address_id
              FROM or_order_activity  a,
                   servsusc           b,
                   pr_product         p,
                   ab_address         aa,
                   or_order           b
             WHERE     a.order_id = b.order_id
                   AND a.subscription_id = b.sesususc
                   AND p.product_id = a.product_id
                   AND aa.address_id = a.address_id
                   AND a.task_type_id IN (12150, 12152)
                   AND a.package_id = nusolicvta
                   AND a.address_id = nudireccion;

        --Aranda 3023
        --Aranda 3170
        --valida si es multifamiliar
        CURSOR cumutifamiliar (nuaddress ab_address.address_id%TYPE)
        IS
            SELECT c.address_id --father_address_id, b.premise_id, c.address, multivivienda
              FROM ldc_info_predio  a,
                   ab_premise       b,
                   ab_address       c
             WHERE     (multivivienda IS NOT NULL AND multivivienda <> -1)
                   AND b.premise_id = c.estate_number
                   AND a.premise_id = b.premise_id
                   AND c.address_id = nuaddress;

        /* select father_address_id
        from ab_address
        where address_id = nuaddress;*/
        --obtiene item fijo y variable
        CURSOR cuobtieneitems (
            nudepart   ldc_items_conexiones.itcondepa%TYPE,
            nulocali   ldc_items_conexiones.itconloca%TYPE,
            nusucate   ldc_items_conexiones.itconsuca%TYPE,
            sbtipo1    ldc_items_conexiones.itcontipo1%TYPE,
            sbtipo2    ldc_items_conexiones.itcontipo2%TYPE)
        IS
            SELECT itconitfi, itconitva
              FROM ldc_items_conexiones
             WHERE     itcondepa = nudepart
                   AND itconloca = nulocali
                   AND itconsuca = nusucate
                   AND itcontipo1 = sbtipo1
                   --and instr(sbtipo2, itcontipo2) > 0;
                   AND UPPER (sbtipo2) LIKE UPPER ('%' || itcontipo2 || '%');

        CURSOR cuobtieneitemsEFG (
            nudepart   ldc_items_conexiones.itcondepa%TYPE,
            nulocali   ldc_items_conexiones.itconloca%TYPE,
            nusucate   ldc_items_conexiones.itconsuca%TYPE,
            sbtipo1    ldc_items_conexiones.itcontipo1%TYPE,
            sbtipo2    ldc_items_conexiones.itcontipo2%TYPE)
        IS
            SELECT itconitfi, itconitva
              FROM ldc_items_conexiones
             WHERE     itcondepa = nudepart
                   AND itconloca = nulocali
                   AND itconsuca = nusucate
                   AND itcontipo1 = sbtipo1
                   AND INSTR (sbtipo2, itcontipo2) > 0;

        --obtiene item fijo y variable de otros tipos
        CURSOR cuobtieneotrositems (
            nudepart   ldc_items_conexiones.itcondepa%TYPE,
            nulocali   ldc_items_conexiones.itconloca%TYPE,
            nusucate   ldc_items_conexiones.itconsuca%TYPE)
        IS
            SELECT itconitfi, itconitva
              FROM ldc_items_conexiones
             WHERE     itcondepa = nudepart
                   AND itconloca = nulocali
                   AND itconsuca = nusucate
                   AND itcontipo1 = 'OTRO'
                   AND itcontipo2 = 'OTRO';

        --obtiene la solicitud de venta
        CURSOR cusolicvta (nuorden or_order.order_id%TYPE)
        IS
            SELECT b.package_id, c.PACKAGE_TYPE_ID
              FROM or_order a, or_order_activity b, mo_packages c
             WHERE     a.order_id = b.order_id
                   AND c.PACKAGE_ID = b.package_id
                   AND b.order_id = nuOrden;

        --obtiene la orden de instalacion asociada a la solicitud de venta
        CURSOR cuordeninst (nusolvta      mo_packages.package_id%TYPE,
                            nudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT a.order_id,
                   a.task_type_id,
                   (SELECT ge.geo_loca_father_id
                      FROM ge_geogra_location ge
                     WHERE ge.geograp_location_id = aa.geograp_location_id)
                       cod_depa,
                   (SELECT ge.geograp_location_id
                      FROM ge_geogra_location ge
                     WHERE     ge.geograp_location_id =
                               aa.geograp_location_id
                           AND ge.geog_loca_area_type = 3)
                       id_loca,
                   p.category_id,
                   p.subcategory_id,
                   o.operating_unit_id
              FROM or_order_activity  a,
                   servsusc           b,
                   pr_product         p,
                   ab_address         aa,
                   or_order           o,
                   GE_CAUSAL          gec
             WHERE     a.order_id = o.order_id
                   AND a.subscription_id = b.sesususc
                   AND p.product_id = a.product_id
                   AND aa.address_id = a.address_id
                   AND a.task_type_id IN (12149, 12151)
                   AND o.causal_id = gec.causal_id
                   AND gec.class_causal_id = 1
                   AND a.package_id = nusolvta
                   AND a.address_id = nudireccion;

        CURSOR cuordeninstEFG (
            nusolvta      mo_packages.package_id%TYPE,
            nudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT a.order_id,
                   a.task_type_id,
                   (SELECT ge.geo_loca_father_id
                      FROM ge_geogra_location ge
                     WHERE ge.geograp_location_id = aa.geograp_location_id)
                       cod_depa,
                   (SELECT ge.geograp_location_id
                      FROM ge_geogra_location ge
                     WHERE     ge.geograp_location_id =
                               aa.geograp_location_id
                           AND ge.geog_loca_area_type = 3)
                       id_loca,
                   p.category_id,
                   p.subcategory_id,
                   b.operating_unit_id
              FROM or_order_activity  a,
                   servsusc           b,
                   pr_product         p,
                   ab_address         aa,
                   or_order           b
             WHERE     a.order_id = b.order_id
                   AND a.subscription_id = b.sesususc
                   AND p.product_id = a.product_id
                   AND aa.address_id = a.address_id
                   AND a.task_type_id IN (12149, 12151)
                   AND a.package_id = nusolvta
                   AND a.address_id = nudireccion;

        --obtiene la orden de instalacion de la instancia
        CURSOR cuordeninstalainstancia (nuotinstance or_order.order_id%TYPE)
        IS
            SELECT a.order_id,
                   a.task_type_id,
                   (SELECT ge.geo_loca_father_id
                      FROM ge_geogra_location ge
                     WHERE ge.geograp_location_id = aa.geograp_location_id)
                       cod_depa,
                   (SELECT ge.geograp_location_id
                      FROM ge_geogra_location ge
                     WHERE     ge.geograp_location_id =
                               aa.geograp_location_id
                           AND ge.geog_loca_area_type = 3)
                       id_loca,
                   p.category_id,
                   p.subcategory_id,
                   o.operating_unit_id,
                   a.address_id
              FROM or_order_activity  a,
                   servsusc           b,
                   pr_product         p,
                   ab_address         aa,
                   or_order           o
             WHERE     a.order_id = o.order_id
                   AND a.subscription_id = b.sesususc
                   AND p.product_id = a.product_id
                   AND aa.address_id = a.address_id
                   AND a.task_type_id IN (12149, 12151)
                   AND a.order_id = nuotinstance;

        CURSOR cuidatributotmp (
            nugrupo      ge_attrib_set_attrib.attribute_set_id%TYPE,
            sbAtributo   GE_ATTRIBUTES.name_attribute%TYPE)
        IS
            SELECT atsa.attribute_id
              FROM GE_ATTRIB_SET_ATTRIB atsa, GE_ATTRIBUTES at
             WHERE     at.attribute_id = atsa.attribute_id
                   AND atsa.attribute_set_id = nugrupo
                   AND at.name_attribute = sbAtributo;

        nuOrdenInst            or_order.order_id%TYPE;
        nuordencargo           or_order.order_id%TYPE;
        nutipotrabca           or_order.task_type_id%TYPE;
        nuTipoTrabI            or_order.task_type_id%TYPE;
        nudepa                 NUMBER;
        nuloca                 NUMBER;
        nusuca                 servsusc.sesusuca%TYPE;
        nucate                 servsusc.sesucate%TYPE;
        nusolicitud            mo_packages.package_id%TYPE;
        nuitfijo               ldc_items_conexiones.itconitfi%TYPE;
        nuitvar                ldc_items_conexiones.itconitva%TYPE;
        nuunidoper             or_order_activity.operating_unit_id%TYPE;
        nupacktype             mo_packages.package_type_id%TYPE;
        nusucai                servsusc.sesusuca%TYPE;
        nucatei                servsusc.sesucate%TYPE;
        nuunidoperi            or_order_activity.operating_unit_id%TYPE;
        nudire                 ab_address.address_id%TYPE;
        nudirepadre            ab_address.address_id%TYPE;
        sbtasktype             or_order.task_type_id%TYPE;
        inuorderid             or_order.order_id%TYPE := NULL;
        nuorderitemsid         or_order_items.order_items_id%TYPE;
        sblongacometida        VARCHAR (2000);
        sbdiamacometida        VARCHAR (2000);
        sbdiamacomettmp        VARCHAR (2000);
        nudepai                NUMBER;
        nulocai                NUMBER;
        sbubicacionint         VARCHAR2 (2000);
        sbmaterialint          VARCHAR2 (2000);
        sblonginterna          VARCHAR2 (2000);
        sbtipointerna          VARCHAR2 (100);
        sbptosadicion          VARCHAR2 (100);
        sbptosconecta          VARCHAR2 (100);
        sbmultimayor6          VARCHAR2 (2) := 'No';
        nuerrorcode            NUMBER;
        nuidatributo           NUMBER;
        nuGrupoDatos           NUMBER;
        sberrormessage         VARCHAR2 (4000);
        nutipocomentario       NUMBER := 1298;
        sbmensaje              VARCHAR2 (4000);
        dtfecha                DATE;
        nuidperson             NUMBER;
        ex_error               EXCEPTION;
        onuValue               ge_unit_cost_ite_lis.price%TYPE;
        onuPriceListId         ge_list_unitary_cost.list_unitary_cost_id%TYPE;
        idtDate                DATE;
        inuContract            ge_list_unitary_cost.contract_id%TYPE;
        inuContractor          ge_list_unitary_cost.contractor_id%TYPE;
        inuGeoLocation         ge_list_unitary_cost.geograp_location_id%TYPE;
        isbType                ge_acta.id_tipo_acta%TYPE;

        -------------------------------------
        CURSOR cuGetOrdenNovedad (inuOrdenPadre NUMBER, inuItemRef NUMBER)
        IS
            SELECT or_order_items.order_items_id
              FROM OR_related_order, or_order_items
             WHERE     OR_related_order.order_id = inuOrdenPadre
                   AND OR_related_order.rela_order_type_id = 14
                   AND OR_related_order.related_order_id =
                       or_order_items.order_id
                   AND or_order_items.items_id = inuItemRef;

        nuRegOrderItem         or_order_items.order_items_id%TYPE;
        inuOrder               NUMBER;
        onuAdmin               NUMBER;
        onuImpre               NUMBER;
        onuUtili               NUMBER;

        --------------------------------------
        -- NC 2493 generacion de cursor para validar producto generico
        --cursor definir si el cursor es o no generico
        CURSOR cuproductogenerico (nuotinstance or_order.order_id%TYPE)
        IS
            SELECT NVL (p.product_type_id, 0)     TIPO_PRODUCTO
              FROM or_order_activity a, pr_product p
             WHERE     a.order_id = nuotinstance
                   AND a.product_id = p.product_id
                   AND p.product_type_id =
                       dald_parameter.fnuGetNumeric_Value ('COD_PRO_GEN',
                                                           NULL);

        RTcuproductogenerico   cuproductogenerico%ROWTYPE;

        --obtiene la categoria de la direccion de la orden
        CURSOR cuordensolointerna (nuotinstance or_order.order_id%TYPE)
        IS
            SELECT a.order_id,
                   a.task_type_id,
                   (SELECT ge.geo_loca_father_id
                      FROM ge_geogra_location ge
                     WHERE ge.geograp_location_id = aa.geograp_location_id)
                       cod_depa,
                   (SELECT ge.geograp_location_id
                      FROM ge_geogra_location ge
                     WHERE     ge.geograp_location_id =
                               aa.geograp_location_id
                           AND ge.geog_loca_area_type = 3)
                       id_loca,
                   S.CATEGORY_,                               --p.category_id,
                   S.SUBCATEGORY_,                         --p.subcategory_id,
                   b.operating_unit_id,
                   a.address_id
              FROM or_order_activity  a,
                   servsusc           b,
                   --pr_product        p,
                   AB_SEGMENTS        S,
                   ab_address         aa,
                   or_order           b
             WHERE     a.order_id = b.order_id
                   AND a.subscription_id = b.sesususc
                   --and p.product_id = a.product_id
                   AND aa.address_id = a.address_id
                   AND AA.SEGMENT_ID = S.SEGMENTS_ID
                   AND a.task_type_id IN (12149, 12151)
                   AND a.order_id = nuotinstance;

        --Fin NC 2493 desarrollo
        -- [inicio NC 3877]
        nuCotCenMed            NUMBER;
        -- [fin NC 3877]
    BEGIN
        pkg_Traza.Trace ('Ingresa procreaitemspago', 10);
        DBMS_OUTPUT.put_Line ('Ingresa procreaitemspago');
        sbtasktype :=
            ldc_boutilities.fsbgetvalorcampotabla ('OR_ORDER',
                                                   'ORDER_ID',
                                                   'TASK_TYPE_ID',
                                                   nuordeninstance);
        pkg_Traza.Trace ('tipo trabajo OT instancia -->' || sbtasktype, 10);
        DBMS_OUTPUT.put_Line ('tipo trabajo OT instancia -->' || sbtasktype);

        --OT cargo
        IF (TO_NUMBER (sbtasktype) IN (12150, 12152))
        THEN
            pkg_Traza.Trace ('ingresa x cargo', 10);
            DBMS_OUTPUT.put_line ('ingresa x cargo');

            OPEN cuordencargoinstancia (nuordeninstance);

            FETCH cuordencargoinstancia
                INTO nuordencargo,
                     nutipotrabca,
                     nudepa,
                     nuloca,
                     nucate,
                     nusuca,
                     nuunidOper,
                     nuDire;

            CLOSE cuordencargoinstancia;

            pkg_Traza.Trace ('ORDEN X CARGO--> ' || nuordencargo, 10);
            DBMS_OUTPUT.put_Line ('ORDEN X CARGO--> ' || nuordencargo);
            pkg_Traza.Trace ('TIPO TRABAJO X CARGO--> ' || nutipotrabca, 10);
            DBMS_OUTPUT.put_Line ('TIPO TRABAJO X CARGO--> ' || nutipotrabca);
            pkg_Traza.Trace ('DEPARTAMENTO X CARGO--> ' || nudepa, 10);
            DBMS_OUTPUT.put_Line ('DEPARTAMENTO X CARGO--> ' || nudepa);
            pkg_Traza.Trace ('LOCALIDAD X CARGO--> ' || nuloca, 10);
            DBMS_OUTPUT.put_Line ('LOCALIDAD X CARGO--> ' || nuloca);
            pkg_Traza.Trace ('CATEGORIA X CARGO--> ' || nucate, 10);
            DBMS_OUTPUT.put_Line ('CATEGORIA X CARGO--> ' || nucate);
            pkg_Traza.Trace ('SUBCATEGORIA X CARGO--> ' || nusuca, 10);
            DBMS_OUTPUT.put_Line ('SUBCATEGORIA X CARGO--> ' || nusuca);
            pkg_Traza.Trace ('UNIDAD OPERATIVA X CARGO--> ' || nuunidOper,
                             10);
            DBMS_OUTPUT.put_Line (
                'UNIDAD OPERATIVA X CARGO--> ' || nuunidOper);
            pkg_Traza.Trace ('DIRECCION X CARGO--> ' || nuDire, 10);
            DBMS_OUTPUT.put_Line ('DIRECCION X CARGO--> ' || nuDire);

            OPEN cuSolicVta (nuOrdenCargo);

            FETCH cusolicvta INTO nuSolicitud, nupacktype;

            CLOSE cusolicvta;

            pkg_Traza.Trace ('SOLICITUD X CARGO-->' || nuSolicitud, 10);
            DBMS_OUTPUT.put_Line ('SOLICITUD X CARGO-->' || nuSolicitud);
            pkg_Traza.Trace ('TIPO SOLICITUD X CARGO-->' || nupacktype, 10);
            DBMS_OUTPUT.put_Line ('TIPO SOLICITUD X CARGO-->' || nupacktype);

            IF (nusolicitud IS NOT NULL OR nusolicitud > 0)
            THEN

                OPEN cuOrdenInst (nuSolicitud, nuDire);

                FETCH cuordeninst
                    INTO nuOrdenInst,
                         nuTipoTrabI,
                         nudepai,
                         nulocai,
                         nucatei,
                         nusucai,
                         nuunidOperi;

                CLOSE cuordeninst;

                pkg_Traza.Trace ('nuordeninst x cargo-->' || nuordeninst, 10);
            END IF;
        --OT instalacion
        ELSIF (TO_NUMBER (sbtasktype) IN (12149, 12151))
        THEN
            pkg_Traza.Trace ('ingresa x instalacion interna', 10);
            DBMS_OUTPUT.put_Line ('ingresa x instalacion interna');

            --VALIDA SI EL PRODUCTO ES GENERICO
            OPEN cuproductogenerico (nuordeninstance);

            FETCH cuproductogenerico INTO RTcuproductogenerico;

            IF RTcuproductogenerico.Tipo_Producto <> 0
            THEN
                --obtiene la categoria de la direccion de la orden
                OPEN cuordensolointerna (nuordeninstance);

                FETCH cuordensolointerna
                    INTO nuordeninst,
                         nutipotrabi,
                         nudepai,
                         nulocai,
                         nucatei,
                         nusucai,
                         nuunidoperi,
                         nuDire;

                CLOSE cuordensolointerna;
            ELSE
                OPEN cuordeninstalaInstancia (nuordeninstance);

                FETCH cuordeninstalainstancia
                    INTO nuordeninst,
                         nutipotrabi,
                         nudepai,
                         nulocai,
                         nucatei,
                         nusucai,
                         nuunidoperi,
                         nuDire;

                CLOSE cuordeninstalainstancia;
            END IF;

            pkg_Traza.Trace (
                'ORDEN X INSTALACION INTERNA--> ' || nuordeninst,
                10);
            DBMS_OUTPUT.put_Line (
                'ORDEN X INSTALACION INTERNA--> ' || nuordeninst);
            pkg_Traza.Trace (
                'TIPO TRABAJO X INSTALACION INTERNA--> ' || nutipotrabi,
                10);
            DBMS_OUTPUT.put_Line (
                'TIPO TRABAJO X INSTALACION INTERNA--> ' || nutipotrabi);
            pkg_Traza.Trace (
                'DEPARTAMENTO X INSTALACION INTERNA--> ' || nudepai,
                10);
            DBMS_OUTPUT.put_Line (
                'DEPARTAMENTO X INSTALACION INTERNA--> ' || nudepai);
            pkg_Traza.Trace (
                'LOCALIDAD X INSTALACION INTERNA--> ' || nulocai,
                10);
            DBMS_OUTPUT.put_Line (
                'LOCALIDAD X INSTALACION INTERNA--> ' || nulocai);
            pkg_Traza.Trace (
                'CATEGORIA X INSTALACION INTERNA--> ' || nucatei,
                10);
            DBMS_OUTPUT.put_Line (
                'CATEGORIA X INSTALACION INTERNA--> ' || nucatei);
            pkg_Traza.Trace (
                'SUBCATEGORIA X INSTALACION INTERNA--> ' || nusucai,
                10);
            DBMS_OUTPUT.put_Line (
                'SUBCATEGORIA X INSTALACION INTERNA--> ' || nusucai);
            pkg_Traza.Trace (
                'UNIDAD OPERATIVA X INSTALACION INTERNA--> ' || nuunidOperi,
                10);
            DBMS_OUTPUT.put_Line (
                'UNIDAD OPERATIVA X INSTALACION INTERNA--> ' || nuunidOperi);
            pkg_Traza.Trace ('DIRECCION X INSTALACION INTERNA--> ' || nuDire,
                             10);
            DBMS_OUTPUT.put_Line (
                'DIRECCION X INSTALACION INTERNA--> ' || nuDire);

            OPEN cuSolicVta (nuordeninst);

            FETCH cusolicvta INTO nuSolicitud, nupacktype;

            CLOSE cusolicvta;

            pkg_Traza.Trace (
                'SOLICITUD X INSTALACION INTERNA-->' || nuSolicitud,
                10);
            DBMS_OUTPUT.put_Line (
                'SOLICITUD X INSTALACION INTERNA-->' || nuSolicitud);
            pkg_Traza.Trace (
                'TIPO SOLICITUD X INSTALACION INTERNA-->' || nupacktype,
                10);
            DBMS_OUTPUT.put_Line (
                'TIPO SOLICITUD X INSTALACION INTERNA-->' || nupacktype);

            IF (nusolicitud IS NOT NULL OR nusolicitud > 0)
            THEN

                OPEN cuordencargo (nuSolicitud, nudire);

                FETCH cuordencargo
                    INTO nuordencargo,
                         nutipotrabca,
                         nudepa,
                         nuloca,
                         nucate,
                         nusuca,
                         nuunidOper,
                         nuDire;

                CLOSE cuordencargo;

                pkg_Traza.Trace (
                    'nuordencargo x instalacion-->' || nuordencargo,
                    10);
                DBMS_OUTPUT.put_Line (
                    'nuordencargo x instalacion-->' || nuordencargo);
            END IF;
        END IF;

        pkg_Traza.Trace ('nuordencargo-->' || nuordencargo, 10);
        DBMS_OUTPUT.put_Line ('nuordencargo-->' || nuordencargo);

        IF (nuordencargo IS NOT NULL)
        THEN
            --ITEMS PARA ORDEN DE CARGO POR CONEXION--
            pkg_Traza.Trace ('nudepa-->' || nudepa, 10);
            pkg_Traza.Trace ('nuloca-->' || nuloca, 10);
            DBMS_OUTPUT.put_Line ('nudepa-->' || nudepa);
            DBMS_OUTPUT.put_Line ('nuloca-->' || nuloca);
            nuGrupoDatos := 11200;

            OPEN cuidatributotmp (nuGrupoDatos, 'DIAM_ACOMETIDA');

            FETCH cuidatributotmp INTO nuidatributo;

            CLOSE cuidatributotmp;

            pkg_Traza.Trace (
                'DIAM_ACOMETIDA-nuordencargo-->' || nuordencargo,
                10);
            DBMS_OUTPUT.put_Line (
                'DIAM_ACOMETIDA-nuordencargo-->' || nuordencargo);
            pkg_Traza.Trace (
                'DIAM_ACOMETIDA-nuidatributo-->' || nuidatributo,
                10);
            DBMS_OUTPUT.put_Line (
                'DIAM_ACOMETIDA-nuidatributo-->' || nuidatributo);
            sbdiamacometida :=
                fsbDatoAdicTmpOrden (nuordencargo,
                                     nuidatributo,
                                     'DIAM_ACOMETIDA');
            pkg_Traza.Trace (
                'DIAM_ACOMETIDA-sbdiamacometida tmp-->' || sbdiamacometida,
                10);
            DBMS_OUTPUT.put_Line (
                'DIAM_ACOMETIDA-sbdiamacometida tmp-->' || sbdiamacometida);

            IF (sbdiamacometida IS NULL)
            THEN
                sbdiamacometida :=
                    LDC_BOORDENES.fnugetvalorotbydatadd (nutipotrabca,
                                                         nugrupodatos,
                                                         'DIAM_ACOMETIDA',
                                                         nuordencargo);
                pkg_Traza.Trace (
                    'DIAM_ACOMETIDA-sbdiamacometida-->' || sbdiamacometida,
                    10);
                DBMS_OUTPUT.put_Line (
                    'DIAM_ACOMETIDA-sbdiamacometida-->' || sbdiamacometida);
            END IF;

            pkg_Traza.Trace ('DIAM_ACOMETIDA-nucate-->' || nucate, 10);
            DBMS_OUTPUT.put_Line ('DIAM_ACOMETIDA-nucate-->' || nucate);

            IF (    sbdiamacometida IS NOT NULL
                AND sbdiamacometida <> 'NO APLICA')
            THEN
                IF (sbdiamacometida <> 'EXISTENTE')
                THEN
                    --para comerciales
                    IF (nupacktype = 100229 AND nucate = 2)
                    THEN
                        sbdiamacomettmp := sbdiamacometida;
                        sbdiamacometida := 'COMERCIALES';
                        nusuca := -1;
                    END IF;

                    --para venta de constructoras
                    --if(nupacktype = 323 and nucate = 2)then
                    IF (nupacktype = 323)
                    THEN
                        sbdiamacomettmp := sbdiamacometida;
                        sbdiamacometida := 'CONSTRUCTORA';
                    END IF;

                    pkg_Traza.Trace ('x- tipo de paquete ' || nupacktype, 10);
                    DBMS_OUTPUT.put_Line (
                        'x- tipo de paquete : ' || nupacktype);
                    pkg_Traza.Trace ('x- categoria ' || nucate, 10);
                    DBMS_OUTPUT.put_Line ('x- categoria: ' || nucate);
                    pkg_Traza.Trace ('x- subcategoria ' || nusuca, 10);
                    DBMS_OUTPUT.put_Line ('x- subcategoria: ' || nusuca);
                    pkg_Traza.Trace (
                        'x- sbdiamacometida: ' || sbdiamacometida,
                        10);
                    DBMS_OUTPUT.put_Line (
                        'x- sbdiamacometida: ' || sbdiamacometida);

                    --obtener el item fijo y variable de acuerdo al tipo y estrato de la Acometida
                    OPEN cuobtieneitems (-1,
                                         -1,
                                         nusuca,
                                         'ACOMETIDA',
                                         sbdiamacometida);

                    FETCH cuobtieneitems INTO nuitfijo, nuitvar;

                    CLOSE cuobtieneitems;

                    pkg_Traza.Trace (
                        'DIAM_ACOMETIDA-nuitfijo-->' || nuitfijo,
                        10);
                    pkg_Traza.Trace ('DIAM_ACOMETIDA-nuitvar-->' || nuitvar,
                                     10);
                    DBMS_OUTPUT.put_Line (
                        'DIAM_ACOMETIDA-nuitfijo-->' || nuitfijo);
                    DBMS_OUTPUT.put_Line (
                        'DIAM_ACOMETIDA-nuitvar-->' || nuitvar);
                    nuidatributo := 0;

                    OPEN cuidatributotmp (nuGrupoDatos, 'LONG_ACOMETIDA');

                    FETCH cuidatributotmp INTO nuidAtributo;

                    CLOSE cuidatributotmp;

                    pkg_Traza.Trace (
                        'LONG_ACOMETIDA-nuidatributo-->' || nuidatributo,
                        10);
                    DBMS_OUTPUT.put_Line (
                        'LONG_ACOMETIDA-nuidatributo-->' || nuidatributo);
                    sblongacometida :=
                        fsbdatoadictmporden (nuordencargo,
                                             nuidatributo,
                                             'LONG_ACOMETIDA');
                    pkg_Traza.Trace (
                           'LONG_ACOMETIDA-sblongacometida tmp-->'
                        || sblongacometida,
                        10);
                    DBMS_OUTPUT.put_Line (
                           'LONG_ACOMETIDA-sblongacometida tmp-->'
                        || sblongacometida);

                    IF (sblongacometida IS NULL)
                    THEN
                        sblongacometida :=
                            LDC_BOORDENES.fnugetvalorotbydatadd (
                                nutipotrabca,
                                nugrupodatos,
                                'LONG_ACOMETIDA',
                                nuordencargo);
                        pkg_Traza.Trace (
                               'LONG_ACOMETIDA-sblongacometida-->'
                            || sblongacometida,
                            10);
                        DBMS_OUTPUT.put_Line (
                               'LONG_ACOMETIDA-sblongacometida-->'
                            || sblongacometida);
                    END IF;

                    --crear orden con itemfijo y variable de la acometida
                    pkg_Traza.Trace ('nuitfijo: ' || nuitfijo, 10);
                    DBMS_OUTPUT.put_Line ('nuitfijo: ' || nuitfijo);

                    --ARANDA 2706
                    --POR SOLICITUD DEL FUNCIONARIO SERGIO HERNANDEZ SE REALIZO LA MODIFICAICION
                    --DEL PROCESO DE VALIDACION PARA VALIDAR LA LONGITUD DE ACOMETIDA Y PERMITIR GENERAR
                    --NOVEDAD DE INTERNA CON ACOMETIDA FIJA SI LA LONGITUD DE ACOMETIDA ES MAYOR A 0
                    --if(nuitfijo is not null) then
                    IF (nuitfijo IS NOT NULL)
                    THEN
                        IF NVL (sblongacometida, 0) > 0
                        THEN
                            --FIN ARANDA 2706
                            --NC 2094: Modificacion 13-12-2013
                            idtDate := SYSDATE; --daor_order.fdtgetlegalization_date(nuordencargo);
                            inuContract :=
                                daOR_order.Fnugetdefined_Contract_Id (
                                    nuordencargo);
                            inuContractor :=
                                daor_operating_unit.fnugetcontractor_id (
                                    nuunidoper);
                            inuGeoLocation :=
                                daOR_order.Fnugetgeograp_Location_Id (
                                    nuordencargo);
                            isbType := 1; -- Tipo de Acta: 1-Liquidacion, 2-Facturacion
                            CT_BOLiquidationSupport.GetListItemValue (
                                nuitfijo,
                                idtDate,
                                nuunidoper,
                                inuContract,
                                inuContractor,
                                inuGeoLocation,
                                isbType,
                                onuPriceListId,
                                onuValue);
                            pkg_Traza.Trace (
                                   'VALOR ITEM ANTE DE AIU --> '
                                || onuValue
                                || ' - ITEM --> '
                                || nuitfijo,
                                10);
                            DBMS_OUTPUT.put_Line (
                                   'VALOR ITEM ANTE DE AIU --> '
                                || onuValue
                                || ' - ITEM --> '
                                || nuitfijo);
                            --/*
                            --aplica AIU a valor de costo de item
                            ldc_getaiubyorder (nuordencargo,
                                               onuadmin,
                                               onuimpre,
                                               onuutili);
                            pkg_Traza.Trace ('VALOR A --> ' || onuadmin, 10);
                            DBMS_OUTPUT.put_Line ('VALOR A --> ' || onuadmin);
                            pkg_Traza.Trace ('VALOR I --> ' || onuimpre, 10);
                            DBMS_OUTPUT.put_Line ('VALOR I --> ' || onuimpre);
                            pkg_Traza.Trace ('VALOR U --> ' || onuutili, 10);
                            DBMS_OUTPUT.put_Line ('VALOR U --> ' || onuutili);

                            IF    onuadmin <> 0
                               OR onuimpre <> 0
                               OR onuutili <> 0
                            THEN
                                onuValue :=
                                    ROUND (
                                          onuValue
                                        + (  (onuValue * (onuadmin / 100))
                                           + (onuValue * (onuimpre / 100))
                                           + (onuValue * (onuutili / 100))));
                            END IF;

                            ---fin aplica AIU a valor de costo de item */
                            --Fin Modificacion 13-12-2013
                            pkg_Traza.Trace (
                                   'ONVALE --> '
                                || onuValue
                                || ' - ITEM --> '
                                || nuitfijo,
                                10);
                            DBMS_OUTPUT.put_Line (
                                   'ONVALE --> '
                                || onuValue
                                || ' - ITEM --> '
                                || nuitfijo);
                            pkg_Traza.Trace (
                                'GENERA item Cargo por Conexion ITEM FIJO ACOMETIDA',
                                10);
                            DBMS_OUTPUT.put_Line (
                                'GENERA item Cargo por Conexion ITEM FIJO ACOMETIDA');
                            --OS_REGISTERNEWCHARGE (nuunidoper, nuitfijo, NULL, nuordencargo, onuValue, 1, nuTipoComentario, 'Pago item Cargo por Conexion', nuerrorcode, sberrormessage);
                            --LDC_OS_REGISTERNEWCHARGE (nuunidoper, nuitfijo, NULL, nuordencargo, onuValue, NULL, nuTipoComentario, 'Pago item Cargo por Conexion', nuerrorcode, sberrormessage);
                            nuerrorcode :=
                                ldc_boordenes.FrgItemOrden (nuordencargo,
                                                            nuitfijo,
                                                            1,
                                                            1,
                                                            onuValue);

                            IF (nuerrorcode <> 0)
                            THEN
                                pkg_Traza.Trace (
                                       'ERROR AL GENERA item Cargo por Conexion ITEM FIJO ACOMETIDA '
                                    || sberrormessage,
                                    10);
                                DBMS_OUTPUT.put_Line (
                                       'ERROR AL GENERA item Cargo por Conexion ITEM FIJO ACOMETIDA '
                                    || sberrormessage);
                                RAISE pkg_Error.CONTROLLED_ERROR;
                            /*
                             ELSE

                              OPEN cuGetOrdenNovedad(nuordencargo,nuitfijo);
                               FETCH cuGetOrdenNovedad INTO nuRegOrderItem;
                               CLOSE cuGetOrdenNovedad;

                              IF daor_order_items.fblexist(nuRegOrderItem) THEN
                                 UPDATE OR_order_items
                                 SET legal_item_amount = 1
                                 WHERE order_items_id = nuRegOrderItem;
                               END IF;
                             */
                            END IF;

                            nuerrorcode := NULL;
                            sberrormessage := NULL;
                        --ARANDA 2706
                        END IF;
                    --FIN ARANDA 2706
                    ELSE
                        sbmensaje :=
                               'No existe item FIJO configurado en ORITC para ACOMEDITDA '
                            || sbdiamacometida;
                        pkg_Traza.Trace (sbmensaje, 10);
                        DBMS_OUTPUT.put_Line (sbmensaje);
                        RAISE ex_error;
                    END IF;

                    pkg_Traza.Trace ('nuitvar: ' || nuitvar, 10);
                    DBMS_OUTPUT.put_Line ('nuitvar: ' || nuitvar);

                    --ARANDA 2706
                    --POR SOLICITUD DEL FUNCIONARIO SERGIO HERNANDEZ SE REALIZO LA MODIFICAICION
                    --DEL PROCESO DE VALIDACION PARA VALIDAR LA LONGITUD DE ACOMETIDA Y PERMITIR GENERAR
                    --NOVEDAD DE INTERNA CON ACOMETIDA FIJA SI LA LONGITUD DE ACOMETIDA ES MAYOR A 0
                    --if(nuitvar is not null)then
                    IF (nuitvar IS NOT NULL)
                    THEN
                        IF NVL (sblongacometida, 0) > 0
                        THEN
                            --FIN ARANDA 2706
                            --NC 2094: Modificacion 13-12-2013
                            idtDate := SYSDATE; --daor_order.fdtgetlegalization_date(nuordencargo);
                            inuContract :=
                                daOR_order.Fnugetdefined_Contract_Id (
                                    nuordencargo);
                            inuContractor :=
                                daor_operating_unit.fnugetcontractor_id (
                                    nuunidoper);
                            inuGeoLocation :=
                                daOR_order.Fnugetgeograp_Location_Id (
                                    nuordencargo);
                            isbType := 1; -- Tipo de Acta: 1-Liquidacion, 2-Facturacion
                            CT_BOLiquidationSupport.GetListItemValue (
                                nuitvar,
                                idtDate,
                                nuunidoper,
                                inuContract,
                                inuContractor,
                                inuGeoLocation,
                                isbType,
                                onuPriceListId,
                                onuValue);
                            --/*
                            --aplica AIU a valor de costo de item
                            ldc_getaiubyorder (nuordencargo,
                                               onuadmin,
                                               onuimpre,
                                               onuutili);

                            IF    onuadmin <> 0
                               OR onuimpre <> 0
                               OR onuutili <> 0
                            THEN
                                onuValue :=
                                    ROUND (
                                          onuValue
                                        + (  (onuValue * (onuadmin / 100))
                                           + (onuValue * (onuimpre / 100))
                                           + (onuValue * (onuutili / 100))));
                            END IF;

                            ---fin aplica AIU a valor de costo de item */
                            pkg_Traza.Trace (
                                   'ONVALE --> '
                                || onuValue
                                || ' - ITEM --> '
                                || nuitvar,
                                10);
                            DBMS_OUTPUT.put_Line (
                                   'ONVALE --> '
                                || onuValue
                                || ' - ITEM --> '
                                || nuitvar);
                            --Fin Modificacion 13-12-2013
                            pkg_Traza.Trace (
                                'GENERA item Cargo por Conexion ITEM VARIABLE ACOMETIDA con el servicio os_registernewcharge de OPEN',
                                10);
                            DBMS_OUTPUT.put_Line (
                                'GENERA item Cargo por Conexion ITEM VARIABLE ACOMETIDA con el servicio os_registernewcharge de OPEN');
                            onuValue :=
                                onuValue * TO_NUMBER (sblongacometida);

                            --Aranda 2706
                            IF onuValue > 0
                            THEN
                                --LDC_os_registernewcharge (nuunidoper, nuitvar, NULL, nuordencargo, onuValue, NULL, nuTipoComentario, 'Pago item Cargo por Conexion', nuerrorcode, sberrormessage);
                                --os_registernewcharge (nuunidoper, nuitvar, NULL, nuordencargo, onuValue, to_number(sblongacometida), nuTipoComentario, 'Pago item Cargo por Conexion', nuerrorcode, sberrormessage);
                                nuerrorcode :=
                                    ldc_boordenes.FrgItemOrden (
                                        nuordencargo,
                                        nuitvar,
                                        TO_NUMBER (sblongacometida),
                                        TO_NUMBER (sblongacometida),
                                        onuValue);

                                IF (nuerrorcode <> 0)
                                THEN
                                    pkg_Traza.Trace (
                                           'ERROR AL GENERA item Cargo por Conexion ITEM VARIABLE ACOMETIDA con el servicio os_registernewcharge de OPEN'
                                        || sberrormessage,
                                        10);
                                    DBMS_OUTPUT.put_Line (
                                           'ERROR AL GENERA item Cargo por Conexion ITEM VARIABLE ACOMETIDA con el servicio os_registernewcharge de OPEN'
                                        || sberrormessage);
                                    RAISE pkg_Error.CONTROLLED_ERROR;
                                /*
                                 ELSE
                                   OPEN cuGetOrdenNovedad(nuordencargo,nuitvar);
                                   FETCH cuGetOrdenNovedad INTO nuRegOrderItem;
                                   CLOSE cuGetOrdenNovedad;

                                  IF daor_order_items.fblexist(nuRegOrderItem) THEN
                                     UPDATE OR_order_items
                                     SET legal_item_amount = to_number(sblongacometida)
                                     WHERE order_items_id = nuRegOrderItem;
                                   END IF;
                                 */
                                END IF;
                            END IF;

                            --Fin aranda 2706
                            nuerrorcode := NULL;
                            sberrormessage := NULL;
                        --ARANDA 2706
                        END IF;
                    --FIN ARANDA 2706
                    ELSE
                        sbmensaje :=
                               'No existe item VARIABLE configurado en ORITC para ACOMEDITDA '
                            || sbdiamacometida;
                        pkg_Traza.Trace (sbmensaje, 10);
                        DBMS_OUTPUT.put_Line (sbmensaje);
                        RAISE ex_error;
                    END IF;

                    --Aranda 3023 => 07-03-2013 => Antes de crear el item fijo para centro de medici??n, se debe
                    --validar si la direcci??n asociada a la orden de la instancia pertenece a un multifamiliar
                    --07-03-2014 ARANDA 3023
                    --esta solucion queda pendiente para un proximo aranda
                    --para el manejo de direcciones padres
                    --Por solicitud del funcionario Sergio Hernandez se
                    --adiciono una validacion para que no genere el
                    --ITEM FIJO DE CENTRO DE MEDICION en caso que exista
                    --direccion padre en la orden.
                    --Open cumutifamiliar(nudire);
                    --fetch cumutifamiliar
                    --  into nudirePadre;
                    --close cumutifamiliar;
                    --if(nuitfijo is not null) and (nudirePadre is null) then
                    --FIN ARANDA 2940
                    nuitfijo := NULL;
                    nuitvar := NULL;

                    --Se crea una temporal, ya que el centro de medicion va por tipo
                    IF (sbdiamacomettmp IS NOT NULL)
                    THEN
                        sbdiamacometida := sbdiamacomettmp;
                    --obtener el item fijo y variable de acuerdo al tipo, depa, loca y cate del centro de medicion
                    END IF;

                    --Aranda 3023 => Validar Direcci??n
                    --validar que se trata de un multifamiliar
                    pkg_Traza.Trace ('nudire: ' || nudire, 10);
                    DBMS_OUTPUT.put_Line ('nudire: ' || nudire);
                    pkg_Traza.Trace ('nucate: ' || nucate, 10);
                    DBMS_OUTPUT.put_Line ('nucate: ' || nucate);
                    nudirePadre := NULL;

                    OPEN cumutifamiliar (nudire);

                    --Si la direcci??n no pertenece a un multifamiliar
                    FETCH cumutifamiliar INTO nudirePadre;

                    pkg_Traza.Trace ('nudire-->' || nudire, 10);
                    pkg_Traza.Trace ('MULTI-nudirePadre-->' || nudirePadre,
                                     10);
                    pkg_Traza.Trace ('nucate: ' || nucate, 10);
                    DBMS_OUTPUT.put_Line ('nucate: ' || nucate);
                    -- if cumutifamiliar%notfound then
                    pkg_Traza.Trace ('nucate: ' || nucate, 10);
                    DBMS_OUTPUT.put_Line ('nucate: ' || nucate);

                    --Aranda 3170
                    IF (    nucate = 1
                        AND (nudirePadre IS NULL OR nupacktype = 323))
                    THEN
                        --if(nucate = 1 and nudirePadre is null)then
                        pkg_Traza.Trace (
                               'CENTRO MEDICION-sbdiamacometida-->'
                            || sbdiamacometida,
                            10);

                        OPEN cuobtieneitems (nudepa,
                                             nuloca,
                                             -1,
                                             'CENTRO MEDICION',
                                             sbdiamacometida);

                        FETCH cuobtieneitems INTO nuitfijo, nuitvar;

                        CLOSE cuobtieneitems;

                        pkg_Traza.Trace (
                            'CENTRO MEDICION-nuitfijo-->' || nuitfijo,
                            10);
                        pkg_Traza.Trace (
                            'CENTRO MEDICION-nuitvar-->' || nuitvar,
                            10);

                        --si no esta por departamento y localidad especifica, busca con -1
                        IF (nuitfijo IS NULL)
                        THEN

                            OPEN cuobtieneitems (-1,
                                                 -1,
                                                 -1,
                                                 'CENTRO MEDICION',
                                                 sbdiamacometida);

                            FETCH cuobtieneitems INTO nuitfijo, nuitvar;

                            CLOSE cuobtieneitems;

                            pkg_Traza.Trace (
                                'CENTRO MEDICION-nuitfijo-->' || nuitfijo,
                                10);
                            pkg_Traza.Trace (
                                'CENTRO MEDICION-nuitvar-->' || nuitvar,
                                10);
                        END IF;

                        --crear orden con itemfijo y variable del centro de medicion
                        IF (nuitfijo IS NOT NULL)
                        THEN
                            --NC 2094: Modificacion 13-12-2013
                            idtDate := SYSDATE; --daor_order.fdtgetlegalization_date(nuordencargo);
                            inuContract :=
                                daOR_order.Fnugetdefined_Contract_Id (
                                    nuordencargo);
                            inuContractor :=
                                daor_operating_unit.fnugetcontractor_id (
                                    nuunidoper);
                            inuGeoLocation :=
                                daOR_order.Fnugetgeograp_Location_Id (
                                    nuordencargo);
                            isbType := 1; -- Tipo de Acta: 1-Liquidacion, 2-Facturacion
                            --Aranda.6555
                            --Se pone en comentario
                            --NC 3877  JOSECF: SE REALIZA LA VALIDACION DEL TIPO DE COTIZACION SE EXCLUYE LA COTIZACION 323 QUE ES DE INDUSTRIAS Y CONSTRUCTORA
                            --      nuCotCenMed := LDC_FNUCENTRMEDCOTI(NUORDENCARGO);
                            ---      IF (nuCotCenMed IS NOT NULL OR NUORDENCARGO<>0) THEN
                            --   NUITFIJO:=LDC_FNUCENTRMEDCOTI(NUORDENCARGO);
                            --END IF;
                            pkg_Traza.Trace (
                                   'CT_BOLiquidationSupport.GetListItemValue-nuitfijo-->'
                                || nuitfijo,
                                10);
                            CT_BOLiquidationSupport.GetListItemValue (
                                nuitfijo,
                                idtDate,
                                nuunidoper,
                                inuContract,
                                inuContractor,
                                inuGeoLocation,
                                isbType,
                                onuPriceListId,
                                onuValue);
                            pkg_Traza.Trace (
                                   'CT_BOLiquidationSupport.GetListItemValue-nuitfijo-->'
                                || nuitfijo,
                                10);
                            --/*
                            --aplica AIU a valor de costo de item
                            ldc_getaiubyorder (nuordencargo,
                                               onuadmin,
                                               onuimpre,
                                               onuutili);

                            IF    onuadmin <> 0
                               OR onuimpre <> 0
                               OR onuutili <> 0
                            THEN
                                onuValue :=
                                    ROUND (
                                          onuValue
                                        + (  (onuValue * (onuadmin / 100))
                                           + (onuValue * (onuimpre / 100))
                                           + (onuValue * (onuutili / 100))));
                            END IF;

                            ---fin aplica AIU a valor de costo de item */
                            pkg_Traza.Trace (
                                   'ONVALE --> '
                                || onuValue
                                || ' - ITEM --> '
                                || nuitFIJO,
                                10);
                            DBMS_OUTPUT.put_Line (
                                   'ONVALE --> '
                                || onuValue
                                || ' - ITEM --> '
                                || nuitFIJO);
                            --Fin Modificacion 13-12-2013
                            pkg_Traza.Trace (
                                'GENERA item Cargo por Conexion ITEM FIJO CENTRO MEDICION',
                                10);
                            DBMS_OUTPUT.put_Line (
                                'GENERA item Cargo por Conexion ITEM FIJO CENTRO MEDICION');
                            --LDC_OS_REGISTERNEWCHARGE (nuunidoper, nuitfijo, NULL, nuordencargo, onuValue, NULL, nuTipoComentario, 'Pago item Cargo por Conexion', nuerrorcode, sberrormessage);
                            --OS_REGISTERNEWCHARGE (nuunidoper, nuitfijo, NULL, nuordencargo, onuValue, 1, nuTipoComentario, 'Pago item Cargo por Conexion', nuerrorcode, sberrormessage);
                            nuerrorcode :=
                                ldc_boordenes.FrgItemOrden (nuordencargo,
                                                            nuitfijo,
                                                            1,
                                                            1,
                                                            onuValue);

                            IF (nuerrorcode <> 0)
                            THEN
                                pkg_Traza.Trace (
                                       'ERROR AL GENERA item Cargo por Conexion ITEM FIJO CENTRO MEDICION'
                                    || sberrormessage,
                                    10);
                                DBMS_OUTPUT.put_Line (
                                       'ERROR AL GENERA item Cargo por Conexion ITEM FIJO CENTRO MEDICION'
                                    || sberrormessage);
                                RAISE pkg_Error.CONTROLLED_ERROR;
                            /*
                             ELSE
                               OPEN cuGetOrdenNovedad(nuordencargo,nuitfijo);
                               FETCH cuGetOrdenNovedad INTO nuRegOrderItem;
                               CLOSE cuGetOrdenNovedad;

                              IF daor_order_items.fblexist(nuRegOrderItem) THEN
                                 UPDATE OR_order_items
                                 SET legal_item_amount = 1
                                 WHERE order_items_id = nuRegOrderItem;
                               END IF;
                             */
                            END IF;

                            nuerrorcode := NULL;
                            sberrormessage := NULL;
                        ELSE
                            sbmensaje :=
                                   'No existe item FIJO configurado en ORITC para CENTRO MEDICION '
                                || sbdiamacometida;
                            pkg_Traza.Trace (sbmensaje, 10);
                            DBMS_OUTPUT.put_Line (sbmensaje);
                            RAISE ex_error;
                        END IF;

                        nuitfijo := NULL;
                        nuitvar := NULL;
                    END IF;                                       --nucate = 1
                END IF;

                --Aranda 3170
                IF (    sbdiamacometida = 'EXISTENTE'
                    AND nucate = 1
                    AND (nudirePadre IS NULL OR nupacktype = 323))
                THEN

                    OPEN cuobtieneitems (nudepa,
                                         nuloca,
                                         -1,
                                         'CENTRO MEDICION',
                                         'SIN MEDIDOR');

                    FETCH cuobtieneitems INTO nuitfijo, nuitvar;

                    CLOSE cuobtieneitems;

                    IF (nuitfijo IS NULL)
                    THEN

                        OPEN cuobtieneitems (-1,
                                             -1,
                                             -1,
                                             'CENTRO MEDICION',
                                             'SIN MEDIDOR');

                        FETCH cuobtieneitems INTO nuitfijo, nuitvar;

                        CLOSE cuobtieneitems;

                    --crear orden con itemfijo y variable del centro de medicion
                    END IF;

                    IF (nuitfijo IS NOT NULL)
                    THEN
                        --NC 2094: Modificacion 13-12-2013
                        idtDate := SYSDATE;
                        inuContract :=
                            daOR_order.Fnugetdefined_Contract_Id (
                                nuordencargo);
                        inuContractor :=
                            daor_operating_unit.fnugetcontractor_id (
                                nuunidoper);
                        inuGeoLocation :=
                            daOR_order.Fnugetgeograp_Location_Id (
                                nuordencargo);
                        isbType := 1; -- Tipo de Acta: 1-Liquidacion, 2-Facturacion
                        CT_BOLiquidationSupport.GetListItemValue (
                            nuitfijo,
                            idtDate,
                            nuunidoper,
                            inuContract,
                            inuContractor,
                            inuGeoLocation,
                            isbType,
                            onuPriceListId,
                            onuValue);
                        --/*
                        --aplica AIU a valor de costo de item
                        ldc_getaiubyorder (nuordencargo,
                                           onuadmin,
                                           onuimpre,
                                           onuutili);

                        IF onuadmin <> 0 OR onuimpre <> 0 OR onuutili <> 0
                        THEN
                            onuValue :=
                                ROUND (
                                      onuValue
                                    + (  (onuValue * (onuadmin / 100))
                                       + (onuValue * (onuimpre / 100))
                                       + (onuValue * (onuutili / 100))));
                        END IF;

                        ---fin aplica AIU a valor de costo de item */
                        pkg_Traza.Trace (
                               'ONVALE --> '
                            || onuValue
                            || ' - ITEM --> '
                            || nuitFIJO,
                            10);
                        DBMS_OUTPUT.put_Line (
                               'ONVALE --> '
                            || onuValue
                            || ' - ITEM --> '
                            || nuitFIJO);
                        --Fin Modificacion 13-12-2013
                        pkg_Traza.Trace (
                            'GENERA item Cargo por Conexion ITEM FIJO CENTRO MEDICION',
                            10);
                        DBMS_OUTPUT.put_Line (
                            'GENERA item Cargo por Conexion ITEM FIJO CENTRO MEDICION');
                        --LDC_OS_REGISTERNEWCHARGE (nuunidoper, nuitfijo, NULL, nuordencargo, onuValue, NULL, nuTipoComentario, 'Pago item Cargo por Conexion', nuerrorcode, sberrormessage);
                        --OS_REGISTERNEWCHARGE (nuunidoper, nuitfijo, NULL, nuordencargo, onuValue, 1, nuTipoComentario, 'Pago item Cargo por Conexion', nuerrorcode, sberrormessage);
                        nuerrorcode :=
                            ldc_boordenes.FrgItemOrden (nuordencargo,
                                                        nuitfijo,
                                                        1,
                                                        1,
                                                        onuValue);

                        IF (nuerrorcode <> 0)
                        THEN
                            pkg_Traza.Trace (
                                   'ERROR AL GENERA item Cargo por Conexion ITEM FIJO CENTRO MEDICION'
                                || sberrormessage,
                                10);
                            DBMS_OUTPUT.put_Line (
                                   'ERROR AL GENERA item Cargo por Conexion ITEM FIJO CENTRO MEDICION'
                                || sberrormessage);
                            RAISE pkg_Error.CONTROLLED_ERROR;
                        /*
                         ELSE

                          OPEN cuGetOrdenNovedad(nuordencargo,nuitfijo);
                           FETCH cuGetOrdenNovedad INTO nuRegOrderItem;
                           CLOSE cuGetOrdenNovedad;

                          IF daor_order_items.fblexist(nuRegOrderItem) THEN
                             UPDATE OR_order_items
                             SET legal_item_amount = 1
                             WHERE order_items_id = nuRegOrderItem;
                           END IF;
                         */
                        END IF;

                        nuerrorcode := NULL;
                        sberrormessage := NULL;
                    ELSE
                        sbmensaje :=
                               'No existe item FIJO configurado en ORITC para CENTRO MEDICION '
                            || sbdiamacometida;
                        pkg_Traza.Trace (sbmensaje, 10);
                        DBMS_OUTPUT.put_Line (sbmensaje);
                        RAISE ex_error;
                    END IF;

                    nuitfijo := NULL;
                    nuitvar := NULL;
                END IF;
            END IF;

            -- else
            --Aranda 3023 => Es un multifamiliar!!
            --Aranda 3170
            IF (    nucate = 1
                AND nudirepadre IS NOT NULL
                AND nudirepadre > 0
                AND nupacktype <> 323)
            THEN

                OPEN cuobtieneitems (nudepa,
                                     nuloca,
                                     -1,
                                     'OTRO',
                                     'MEDIDOR EN MULT');

                FETCH cuobtieneitems INTO nuitfijo, nuitvar;

                CLOSE cuobtieneitems;

                pkg_Traza.Trace ('MEDIDOR EN MULT-nuitfijo-->' || nuitfijo,
                                 10);
                pkg_Traza.Trace ('MEDIDOR EN MULT-nuitvar-->' || nuitvar, 10);

                IF (nuitfijo IS NULL)
                THEN

                    OPEN cuobtieneitems (-1,
                                         -1,
                                         -1,
                                         'OTRO',
                                         'MEDIDOR EN MULT');

                    FETCH cuobtieneitems INTO nuitfijo, nuitvar;

                    CLOSE cuobtieneitems;
 
                    pkg_Traza.Trace (
                        'MEDIDOR EN MULT-nuitfijo-->' || nuitfijo,
                        10);
                    pkg_Traza.Trace ('MEDIDOR EN MULT-nuitvar-->' || nuitvar,
                                     10);
                END IF;

                IF (nuitfijo IS NOT NULL)
                THEN
                    --NC 2094: Modificacion 13-12-2013
                    idtDate := SYSDATE; --daor_order.fdtgetlegalization_date(nuordencargo);
                    inuContract :=
                        daOR_order.Fnugetdefined_Contract_Id (nuordencargo);
                    inuContractor :=
                        daor_operating_unit.fnugetcontractor_id (nuunidoper);
                    inuGeoLocation :=
                        daOR_order.Fnugetgeograp_Location_Id (nuordencargo);
                    isbType := 1; -- Tipo de Acta: 1-Liquidacion, 2-Facturacion
                    CT_BOLiquidationSupport.GetListItemValue (nuitfijo,
                                                              idtDate,
                                                              nuunidoper,
                                                              inuContract,
                                                              inuContractor,
                                                              inuGeoLocation,
                                                              isbType,
                                                              onuPriceListId,
                                                              onuValue);
                    --/*
                    --aplica AIU a valor de costo de item
                    ldc_getaiubyorder (nuordencargo,
                                       onuadmin,
                                       onuimpre,
                                       onuutili);

                    IF onuadmin <> 0 OR onuimpre <> 0 OR onuutili <> 0
                    THEN
                        onuValue :=
                            ROUND (
                                  onuValue
                                + (  (onuValue * (onuadmin / 100))
                                   + (onuValue * (onuimpre / 100))
                                   + (onuValue * (onuutili / 100))));
                    END IF;

                    ---fin aplica AIU a valor de costo de item */
                    pkg_Traza.Trace (
                           'ONVALE --> '
                        || onuValue
                        || ' - ITEM --> '
                        || nuitFIJO,
                        10);
                    DBMS_OUTPUT.put_Line (
                           'ONVALE --> '
                        || onuValue
                        || ' - ITEM --> '
                        || nuitFIJO);
                    --Fin Modificacion 13-12-2013
                    pkg_Traza.Trace (
                        'GENERA item Cargo por Conexion MEDIDOR EN MULTIFAMILIAR',
                        10);
                    DBMS_OUTPUT.put_Line (
                        'GENERA item Cargo por Conexion MEDIDOR EN MULTIFAMILIAR');
                    --LDC_OS_REGISTERNEWCHARGE (nuunidoper, nuitfijo, NULL, nuordencargo, onuValue, NULL, nuTipoComentario, 'Pago item Cargo por Conexion', nuerrorcode, sberrormessage);
                    --OS_REGISTERNEWCHARGE (nuunidoper, nuitfijo, NULL, nuordencargo, onuValue, 1, nuTipoComentario, 'Pago item Cargo por Conexion', nuerrorcode, sberrormessage);
                    nuerrorcode :=
                        ldc_boordenes.FrgItemOrden (nuordencargo,
                                                    nuitfijo,
                                                    1,
                                                    1,
                                                    onuValue);

                    IF (nuerrorcode <> 0)
                    THEN
                        pkg_Traza.Trace (
                               'ERROR AL GENERA item Cargo por Conexion MEDIDOR EN MULTIFAMILIAR'
                            || sberrormessage,
                            10);
                        DBMS_OUTPUT.put_Line (
                               'ERROR AL GENERA item Cargo por Conexion MEDIDOR EN MULTIFAMILIAR'
                            || sberrormessage);
                        RAISE pkg_Error.CONTROLLED_ERROR;
                    /*
                     ELSE

                      OPEN cuGetOrdenNovedad(nuordencargo,nuitfijo);
                       FETCH cuGetOrdenNovedad INTO nuRegOrderItem;
                       CLOSE cuGetOrdenNovedad;

                      IF daor_order_items.fblexist(nuRegOrderItem) THEN
                         UPDATE OR_order_items
                         SET legal_item_amount = 1
                         WHERE order_items_id = nuRegOrderItem;
                       END IF;
                     */
                    END IF;

                    nuerrorcode := NULL;
                    sberrormessage := NULL;
                ELSE
                    sbmensaje :=
                        'No existe item FIJO configurado en ORITC para MEDIDOR EN MULTI';
                    pkg_Traza.Trace (sbmensaje, 10);
                    DBMS_OUTPUT.put_Line (sbmensaje);
                    RAISE ex_error;
                END IF;

                nuitfijo := NULL;
                nuitvar := NULL;
            END IF;

            --  end if;
            IF cumutifamiliar%ISOPEN
            THEN
                CLOSE cumutifamiliar;
            END IF;

            --Fin Aranda 3023
            --NC
            FOR rtotrositems IN cuobtieneotrositems (-1, -1, -1)
            LOOP
                IF (rtotrositems.itconitfi IS NULL)
                THEN
                    sbmensaje :=
                        'No existe item FIJO configurado en ORITC para PTOS CONECTADOS';
                    RAISE ex_error;
                END IF;

                IF (rtotrositems.itconitfi = 4294991)
                THEN
                    nuidatributo := 0;

                    OPEN cuidatributotmp (11203, 'PUNTOS_CONECTADOS');

                    FETCH cuidatributotmp INTO nuidatributo;

                    CLOSE cuidatributotmp;

                    pkg_Traza.Trace ('ATRIBUTO-->' || nuidatributo, 10);
                    DBMS_OUTPUT.put_line ('ATRIBUTO-->' || nuidatributo);
                    pkg_Traza.Trace ('ORDEN CARGO-->' || nuordencargo, 10);
                    DBMS_OUTPUT.put_line ('ORDEN CARGO-->' || nuordencargo);
                    pkg_Traza.Trace ('GRUPO DATOS-->' || nugrupodatos, 10);
                    DBMS_OUTPUT.put_line ('GRUPO DATO-->' || nugrupodatos);
                    pkg_Traza.Trace ('TIPO TRABAJO CARGO-->' || nutipotrabca,
                                     10);
                    DBMS_OUTPUT.put_line (
                        'TIPO TRABAJO CARGO-->' || nutipotrabca);
                    pkg_Traza.Trace ('UNIDAD OPERATIVA-->' || nuunidoper, 10);
                    DBMS_OUTPUT.put_line (
                        'UNIDAD OPERATIVA-->' || nuunidoper);
                    sbptosconecta :=
                        LDC_BOORDENES.fsbdatoadictmporden (
                            nuordencargo,
                            nuidatributo,
                            'PUNTOS_CONECTADOS');
                    pkg_Traza.Trace (
                           'PUNTOS_CONECTADOS-sbptosconecta tmp-->'
                        || sbptosconecta,
                        10);

                    IF (sbptosconecta IS NULL)
                    THEN
                        sbptosconecta :=
                            LDC_BOORDENES.fnugetvalorotbydatadd (
                                nutipotrabca,
                                11203,
                                'PUNTOS_CONECTADOS',
                                nuordencargo);
                        pkg_Traza.Trace (
                               'PUNTOS_CONECTADOS-sbptosconecta-->'
                            || sbptosconecta,
                            10);
                    END IF;

                    IF (    sbptosconecta IS NOT NULL
                        AND TO_NUMBER (sbptosconecta) > 0)
                    THEN
                        --NC 2094: Modificacion 13-12-2013
                        idtDate := SYSDATE; --daor_order.fdtgetlegalization_date(nuordencargo);
                        inuContract :=
                            daOR_order.Fnugetdefined_Contract_Id (
                                nuordencargo);
                        inuContractor :=
                            daor_operating_unit.fnugetcontractor_id (
                                nuunidoper);
                        inuGeoLocation :=
                            daOR_order.Fnugetgeograp_Location_Id (
                                nuordencargo);
                        isbType := 1; -- Tipo de Acta: 1-Liquidacion, 2-Facturacion
                        CT_BOLiquidationSupport.GetListItemValue (
                            rtotrositems.itconitfi,
                            idtDate,
                            nuunidoper,
                            inuContract,
                            inuContractor,
                            inuGeoLocation,
                            isbType,
                            onuPriceListId,
                            onuValue);
                        --/*
                        --aplica AIU a valor de costo de item
                        ldc_getaiubyorder (nuordencargo,
                                           onuadmin,
                                           onuimpre,
                                           onuutili);

                        IF onuadmin <> 0 OR onuimpre <> 0 OR onuutili <> 0
                        THEN
                            onuValue :=
                                ROUND (
                                      onuValue
                                    + (  (onuValue * (onuadmin / 100))
                                       + (onuValue * (onuimpre / 100))
                                       + (onuValue * (onuutili / 100))));
                        END IF;

                        ---fin aplica AIU a valor de costo de item */
                        pkg_Traza.Trace (
                               'ONVALE --> '
                            || onuValue
                            || ' - ITEM --> '
                            || RTOTROSITEMS.ITCONITFI,
                            10);
                        DBMS_OUTPUT.put_Line (
                               'ONVALE --> '
                            || onuValue
                            || ' - ITEM --> '
                            || RTOTROSITEMS.ITCONITFI);
                        --Fin Modificacion 13-12-2013
                        pkg_Traza.Trace (
                            'GENERA item Cargo por Conexion PUNTOS CONECTADOS',
                            10);
                        DBMS_OUTPUT.put_Line (
                            'GENERA item Cargo por Conexion PUNTOS CONECTADOS');
                        onuValue := onuValue * TO_NUMBER (sbptosconecta);
                        --LDC_OS_REGISTERNEWCHARGE (nuunidoper, rtotrositems.itconitfi, NULL, nuordencargo, onuValue, NULL, nuTipoComentario, 'Pago item Instalacion Interna', nuerrorcode, sberrormessage);
                        --OS_REGISTERNEWCHARGE (nuunidoperi, rtotrositems.itconitfi, NULL, nuordencargo, onuValue, sbptosconecta, nuTipoComentario, 'Pago item Instalacion Interna', nuerrorcode, sberrormessage);
                        nuerrorcode :=
                            ldc_boordenes.FrgItemOrden (
                                nuordencargo,
                                rtotrositems.itconitfi,
                                TO_NUMBER (sbptosconecta),
                                TO_NUMBER (sbptosconecta),
                                onuValue);

                        IF (nuerrorcode <> 0)
                        THEN
                            pkg_Traza.Trace (
                                   'ERROR AL GENERAR item Cargo por Conexion PUNTOS CONECTADOS'
                                || sberrormessage,
                                10);
                            DBMS_OUTPUT.put_Line (
                                   'ERROR AL GENERAR item Cargo por Conexion PUNTOS CONECTADOS'
                                || sberrormessage);
                            RAISE pkg_Error.CONTROLLED_ERROR;
                        /*
                         ELSE

                          OPEN cuGetOrdenNovedad(nuordencargo,rtotrositems.itconitfi);
                           FETCH cuGetOrdenNovedad INTO nuRegOrderItem;
                           CLOSE cuGetOrdenNovedad;

                          IF daor_order_items.fblexist(nuRegOrderItem) THEN
                             UPDATE OR_order_items
                             SET legal_item_amount = TO_NUMBER(sbptosconecta)
                             WHERE order_items_id = nuRegOrderItem;
                           END IF;
                         */
                        END IF;

                        nuerrorcode := NULL;
                        sberrormessage := NULL;
                    END IF;
                END IF;
            END LOOP;
        --
        END IF;

        --FIN ITEMS PARA ORDEN DE CARGO POR CONEXION--
        pkg_Traza.Trace ('nuordeninst-->' || nuordeninst, 10);
        DBMS_OUTPUT.put_Line ('nuordeninst-->' || nuordeninst);
        pkg_Traza.Trace ('nucatei-->' || nucatei, 10);
        DBMS_OUTPUT.put_Line ('nucatei-->' || nucatei);
        pkg_Traza.Trace ('(nuordeninst is not null and nucatei = 1)', 10);
        DBMS_OUTPUT.put_Line ('(nuordeninst is not null and nucatei = 1)');

        --ITEMS PARA ORDEN DE INSTALACION--
        IF (nuordeninst IS NOT NULL AND nucatei = 1)
        THEN
            pkg_Traza.Trace ('ITEMS PARA ORDEN DE INSTALACION', 10);
            DBMS_OUTPUT.put_Line ('ITEMS PARA ORDEN DE INSTALACION');
            nugrupodatos := 11202;
            nuidAtributo := 0;

            OPEN cuidatributotmp (nugrupodatos, 'UBICACIÓN_INST_INTERNA');

            FETCH cuidatributotmp INTO nuidAtributo;

            CLOSE cuidatributotmp;

            pkg_Traza.Trace (
                'UBICACIÓN_INST_INTERNA-nuidatributo-->' || nuidatributo,
                10);
            DBMS_OUTPUT.put_Line (
                'UBICACIÓN_INST_INTERNA-nuidatributo-->' || nuidatributo);
            sbubicacionint :=
                LDC_BOORDENES.fsbdatoadictmporden (nuordeninst,
                                                   nuidatributo,
                                                   'UBICACIÓN_INST_INTERNA');
            pkg_Traza.Trace (
                   'UBICACIÓN_INST_INTERNA-sbubicacionint tmp-->'
                || sbubicacionint,
                10);
            DBMS_OUTPUT.put_Line (
                   'UBICACIÓN_INST_INTERNA-sbubicacionint tmp-->'
                || sbubicacionint);

            IF (sbubicacionint IS NULL)
            THEN
                sbubicacionint :=
                    LDC_BOORDENES.fnugetvalorotbydatadd (
                        nutipotrabi,
                        nugrupodatos,
                        'UBICACIÓN_INST_INTERNA',
                        nuordeninst);
                pkg_Traza.Trace (
                       'UBICACIÓN_INST_INTERNA-sbubicacionint-->'
                    || sbubicacionint,
                    10);
                DBMS_OUTPUT.put_Line (
                       'UBICACIÓN_INST_INTERNA-sbubicacionint-->'
                    || sbubicacionint);
            END IF;

            IF (sbubicacionint IS NOT NULL AND sbubicacionint <> 'NO APLICA')
            THEN
                nuidAtributo := 0;

                OPEN cuidatributotmp (nugrupodatos, 'MATERIAL_INST_INTERNA');

                FETCH cuidatributotmp INTO nuidatributo;

                CLOSE cuidatributotmp;

                pkg_Traza.Trace (
                    'MATERIAL_INST_INTERNA-nuidatributo-->' || nuidatributo,
                    10);
                sbmaterialint :=
                    LDC_BOORDENES.fsbdatoadictmporden (
                        nuordeninst,
                        nuidatributo,
                        'MATERIAL_INST_INTERNA');
                pkg_Traza.Trace (
                       'MATERIAL_INST_INTERNA-sbmaterialint tmp-->'
                    || sbmaterialint,
                    10);

                IF (sbmaterialint IS NULL)
                THEN
                    sbmaterialint :=
                        LDC_BOORDENES.fnugetvalorotbydatadd (
                            nutipotrabi,
                            nugrupodatos,
                            'MATERIAL_INST_INTERNA',
                            nuordeninst);
                    pkg_Traza.Trace (
                           'MATERIAL_INST_INTERNA-sbmaterialint-->'
                        || sbmaterialint,
                        10);
                END IF;

                --NC1437: ajuste de material
                IF (sbmaterialint = 'GALVANIZADO')
                THEN
                    sbmaterialint := 'ACERO';
                END IF;

                nuidAtributo := 0;

                OPEN cuidatributotmp (nugrupodatos, 'MULTI_MAYOR_6');

                FETCH cuidatributotmp INTO nuidatributo;

                CLOSE cuidatributotmp;

                pkg_Traza.Trace (
                    'MULTI_MAYOR_6-nuidatributo-->' || nuidatributo,
                    10);
                sbmultimayor6 :=
                    LDC_BOORDENES.fsbdatoadictmporden (nuordeninst,
                                                       nuidatributo,
                                                       'MULTI_MAYOR_6');
                pkg_Traza.Trace (
                    'MULTI_MAYOR_6-sbmultimayor6 tmp-->' || sbmultimayor6,
                    10);

                IF (sbmultimayor6 IS NULL)
                THEN
                    sbmultimayor6 :=
                        LDC_BOORDENES.fnugetvalorotbydatadd (nutipotrabi,
                                                             nugrupodatos,
                                                             'MULTI_MAYOR_6',
                                                             nuordeninst);
                    pkg_Traza.Trace (
                        'MULTI_MAYOR_6-sbmultimayor6-->' || sbmultimayor6,
                        10);
                END IF;

                IF (UPPER (sbmultimayor6) = UPPER ('Si'))
                THEN
                    IF (sbubicacionint = 'A LA VISTA')
                    THEN
                        sbTipoInterna := 'INTERNA A LA VISTA 6';
                    ELSE
                        sbtipointerna := 'INTERNA OCULTA 6';
                    END IF;
                ELSE
                    IF (sbubicacionint = 'A LA VISTA')
                    THEN
                        sbTipoInterna := 'INTERNA A LA VISTA';
                    ELSE
                        sbTipoInterna := 'INTERNA OCULTA';
                    END IF;
                END IF;

                --ARANDA 2940
                pkg_Traza.Trace ('sbTipoInterna-->' || sbtipointerna, 10);

                OPEN cuobtieneitems (nudepa,
                                     nuloca,
                                     -1,
                                     sbTipoInterna,
                                     sbmaterialint);

                FETCH cuobtieneitems INTO nuitfijo, nuitvar;

                CLOSE cuobtieneitems;

                pkg_Traza.Trace ('2940 departamento-->' || nudepa, 10);
                pkg_Traza.Trace ('2940 localidad-->' || nuloca, 10);
                pkg_Traza.Trace ('nuitfijo-->' || nuitfijo, 10);
                pkg_Traza.Trace ('nuitvar-->' || nuitvar, 10);

                IF (nuitfijo IS NULL) AND (nuitvar IS NULL)
                THEN
                    OPEN cuobtieneitems (-1,
                                         -1,
                                         -1,
                                         sbTipoInterna,
                                         sbmaterialint);

                    FETCH cuobtieneitems INTO nuitfijo, nuitvar;

                    CLOSE cuobtieneitems;
                END IF;

                pkg_Traza.Trace ('sbTipoInterna-nuitfijo-->' || nuitfijo, 10);
                pkg_Traza.Trace ('sbTipoInterna-nuitvar-->' || nuitvar, 10);
                --FIN ARANDA2940
                nuidAtributo := 0;

                OPEN cuidatributotmp (nugrupodatos, 'LONG_INST_INTERNA');

                FETCH cuidatributotmp INTO nuidatributo;

                CLOSE cuidatributotmp;

                pkg_Traza.Trace (
                    'LONG_INST_INTERNA-nuidatributo-->' || nuidatributo,
                    10);
                sblonginterna :=
                    LDC_BOORDENES.fnugetvalorotbydatadd (nutipotrabi,
                                                         nugrupodatos,
                                                         'LONG_INST_INTERNA',
                                                         nuordeninst);
                pkg_Traza.Trace (
                    'LONG_INST_INTERNA-sblonginterna -->' || sblonginterna,
                    10);
                DBMS_OUTPUT.put_Line (
                    'LONG_INST_INTERNA-sblonginterna -->' || sblonginterna);

                IF sblonginterna IS NULL OR TO_NUMBER (sblonginterna) <= 0
                THEN
                    sblonginterna :=
                        LDC_BOORDENES.fsbdatoadictmporden (
                            nuordeninst,
                            nuidatributo,
                            'LONG_INST_INTERNA');
                    pkg_Traza.Trace (
                           'LONG_INST_INTERNA-sblonginterna tmp-->'
                        || sblonginterna,
                        10);
                    DBMS_OUTPUT.put_Line (
                           'LONG_INST_INTERNA-sblonginterna tmp-->'
                        || sblonginterna);
                END IF;

                /*
                if(sblonginterna is null) then
                  pkg_Traza.Trace('LONG_INST_INTERNA-sblonginterna-->'||sblonginterna,10);
                  dbms_output.put_Line('LONG_INST_INTERNA-sblonginterna-->'||sblonginterna);
                end if;
                */
                --crear orden con itemfijo y variable de la acometida
                --ARANDA 2706
                --POR SOLICITUD DEL FUNCIONARIO SERGIO HERNANDEZ SE REALIZO LA MODIFICAICION
                --DEL PROCESO DE VALIDACION PARA VALIDAR LA LONGITUD DE INTERNA Y PERMITIR GENERAR
                --NOVEDAD DE INTERNA CON ACOMETIDA FIJA SI LA LONGITUD INTERNA ES MAYOR A 0
                IF (nuitfijo IS NOT NULL)
                THEN
                    IF NVL (sblonginterna, 0) > 0
                    THEN
                        --FIN ARANDA 2706
                        --NC 2094: Modificacion 13-12-2013
                        idtDate := SYSDATE; --daor_order.fdtgetlegalization_date(nuordeninst);
                        inuContract :=
                            daOR_order.Fnugetdefined_Contract_Id (
                                nuordeninst);
                        inuContractor :=
                            daor_operating_unit.fnugetcontractor_id (
                                nuunidoperi);
                        inuGeoLocation :=
                            daOR_order.Fnugetgeograp_Location_Id (
                                nuordeninst);
                        isbType := 1; -- Tipo de Acta: 1-Liquidacion, 2-Facturacion
                        CT_BOLiquidationSupport.GetListItemValue (
                            nuitfijo,
                            idtDate,
                            nuunidoperi,
                            inuContract,
                            inuContractor,
                            inuGeoLocation,
                            isbType,
                            onuPriceListId,
                            onuValue);
                        --/*
                        --aplica AIU a valor de costo de item
                        ldc_getaiubyorder (nuordeninst,
                                           onuadmin,
                                           onuimpre,
                                           onuutili);

                        IF onuadmin <> 0 OR onuimpre <> 0 OR onuutili <> 0
                        THEN
                            onuValue :=
                                ROUND (
                                      onuValue
                                    + (  (onuValue * (onuadmin / 100))
                                       + (onuValue * (onuimpre / 100))
                                       + (onuValue * (onuutili / 100))));
                        END IF;

                        ---fin aplica AIU a valor de costo de item */
                        pkg_Traza.Trace (
                               'ONVALE --> '
                            || onuValue
                            || ' - ITEM --> '
                            || nuitFIJO,
                            10);
                        DBMS_OUTPUT.put_Line (
                               'ONVALE --> '
                            || onuValue
                            || ' - ITEM --> '
                            || nuitFIJO);
                        --Fin Modificacion 13-12-2013
                        pkg_Traza.Trace (
                            'GENERA item ORDEN DE INSTALACION item FIJO configurado en ORITC',
                            10);
                        DBMS_OUTPUT.put_Line (
                            'GENERA item ORDEN DE INSTALACION item FIJO configurado en ORITC');
                        --LDC_OS_REGISTERNEWCHARGE (nuunidoperi, nuitfijo, NULL, nuordeninst, onuValue, NULL, nuTipoComentario, 'Pago item Instalacion Interna', nuerrorcode, sberrormessage);
                        --OS_REGISTERNEWCHARGE (nuunidoperi, nuitfijo, NULL, nuordeninst, onuValue, 1, nuTipoComentario, 'Pago item Instalacion Interna', nuerrorcode, sberrormessage);
                        nuerrorcode :=
                            ldc_boordenes.FrgItemOrden (nuordeninst,
                                                        nuitfijo,
                                                        1,
                                                        1,
                                                        onuValue);

                        IF (nuerrorcode <> 0)
                        THEN
                            pkg_Traza.Trace (
                                   'ERROR AL GENERA item ORDEN DE INSTALACION item FIJO configurado en ORITC'
                                || sberrormessage,
                                10);
                            DBMS_OUTPUT.put_Line (
                                   'ERROR AL GENERA item ORDEN DE INSTALACION item FIJO configurado en ORITC'
                                || sberrormessage);
                            RAISE pkg_Error.CONTROLLED_ERROR;
                        /*
                         ELSE

                          OPEN cuGetOrdenNovedad(nuordeninst,nuitfijo);
                           FETCH cuGetOrdenNovedad INTO nuRegOrderItem;
                           CLOSE cuGetOrdenNovedad;

                          IF daor_order_items.fblexist(nuRegOrderItem) THEN
                             UPDATE OR_order_items
                             SET legal_item_amount = 1
                             WHERE order_items_id = nuRegOrderItem;
                           END IF;
                         */
                        END IF;

                        nuerrorcode := NULL;
                        sberrormessage := NULL;
                    --ARANDA 2706
                    END IF;
                --FIN ARANDA 2706
                ELSE
                    sbmensaje :=
                           'No existe item FIJO configurado en ORITC para '
                        || sbTipoInterna
                        || ' '
                        || sbmaterialint;
                    pkg_Traza.Trace (sbmensaje, 10);
                    DBMS_OUTPUT.put_Line (sbmensaje);
                    RAISE ex_error;
                END IF;

                --ARANDA 2706
                --POR SOLICITUD DEL FUNCIONARIO SERGIO HERNANDEZ SE REALIZO LA MODIFICAICION
                --DEL PROCESO DE VALIDACION PARA VALIDAR LA LONGITUD DE INTERNA Y PERMITIR GENERAR
                --NOVEDAD DE INTERNA CON ACOMETIDA FIJA SI LA LONGITUD INTERNA ES MAYOR A 0
                IF (nuitvar IS NOT NULL)
                THEN
                    IF NVL (sblonginterna, 0) > 0
                    THEN
                        --FIN ARANDA 2706
                        --NC 2094: Modificacion 13-12-2013
                        idtDate := SYSDATE; --daor_order.fdtgetlegalization_date(nuordeninst);
                        inuContract :=
                            daOR_order.Fnugetdefined_Contract_Id (
                                nuordeninst);
                        inuContractor :=
                            daor_operating_unit.fnugetcontractor_id (
                                nuunidoperi);
                        inuGeoLocation :=
                            daOR_order.Fnugetgeograp_Location_Id (
                                nuordeninst);
                        isbType := 1; -- Tipo de Acta: 1-Liquidacion, 2-Facturacion
                        CT_BOLiquidationSupport.GetListItemValue (
                            nuitvar,
                            idtDate,
                            nuunidoperi,
                            inuContract,
                            inuContractor,
                            inuGeoLocation,
                            isbType,
                            onuPriceListId,
                            onuValue);
                        --/*
                        --aplica AIU a valor de costo de item
                        ldc_getaiubyorder (nuordeninst,
                                           onuadmin,
                                           onuimpre,
                                           onuutili);

                        IF onuadmin <> 0 OR onuimpre <> 0 OR onuutili <> 0
                        THEN
                            onuValue :=
                                ROUND (
                                      onuValue
                                    + (  (onuValue * (onuadmin / 100))
                                       + (onuValue * (onuimpre / 100))
                                       + (onuValue * (onuutili / 100))));
                        END IF;

                        ---fin aplica AIU a valor de costo de item */
                        pkg_Traza.Trace (
                               'ONVALE --> '
                            || onuValue
                            || ' - ITEM --> '
                            || nuitvar,
                            10);
                        DBMS_OUTPUT.put_Line (
                               'ONVALE --> '
                            || onuValue
                            || ' - ITEM --> '
                            || nuitvar);
                        --Fin Modificacion 13-12-2013
                        pkg_Traza.Trace (
                            'GENERA item ORDEN DE INSTALACION item VARIABLE configurado en ORITC',
                            10);
                        DBMS_OUTPUT.put_Line (
                            'GENERA item ORDEN DE INSTALACION item VARIABLE configurado en ORITC');
                        pkg_Traza.Trace (
                               'TO_NUMBER(sblonginterna) --> '
                            || TO_NUMBER (sblonginterna),
                            10);
                        DBMS_OUTPUT.put_Line (
                               'TO_NUMBER(sblonginterna) --> '
                            || TO_NUMBER (sblonginterna));
                        onuValue := onuValue * TO_NUMBER (sblonginterna);

                        --Aranda 2706
                        IF onuValue > 0
                        THEN
                            --LDC_OS_REGISTERNEWCHARGE (nuunidoperi, nuitvar, NULL, nuordeninst, onuValue, NULL, nuTipoComentario, 'Pago item Instalacion Interna', nuerrorcode, sberrormessage);
                            --OS_REGISTERNEWCHARGE (nuunidoperi, nuitvar, NULL, nuordeninst, onuValue, sblonginterna, nuTipoComentario, 'Pago item Instalacion Interna', nuerrorcode, sberrormessage);
                            nuerrorcode :=
                                ldc_boordenes.FrgItemOrden (
                                    nuordeninst,
                                    nuitvar,
                                    TO_NUMBER (sblonginterna),
                                    TO_NUMBER (sblonginterna),
                                    onuValue);

                            IF (nuerrorcode <> 0)
                            THEN
                                pkg_Traza.Trace (
                                       'ERROR AL GENERA item ORDEN DE INSTALACION item VARIABLE configurado en ORITC'
                                    || sberrormessage,
                                    10);
                                DBMS_OUTPUT.put_Line (
                                       'ERROR AL GENERA item ORDEN DE INSTALACION item VARIABLE configurado en ORITC'
                                    || sberrormessage);
                                RAISE pkg_Error.CONTROLLED_ERROR;
                            /*
                             ELSE

                              OPEN cuGetOrdenNovedad(nuordeninst,nuitvar);
                               FETCH cuGetOrdenNovedad INTO nuRegOrderItem;
                               CLOSE cuGetOrdenNovedad;

                              IF daor_order_items.fblexist(nuRegOrderItem) THEN
                                 UPDATE OR_order_items
                                 SET legal_item_amount = TO_NUMBER(sblonginterna)
                                 WHERE order_items_id = nuRegOrderItem;
                               END IF;
                             */
                            END IF;
                        END IF;

                        --fin Aranda 2706
                        nuerrorcode := NULL;
                        sberrormessage := NULL;
                    --ARANDA 2706
                    END IF;
                --FIN ARANDA 2706
                ELSE
                    sbmensaje :=
                           'No existe item VARIABLE configurado en ORITC para '
                        || sbTipoInterna
                        || ' '
                        || sbmaterialint;
                    pkg_Traza.Trace (sbmensaje, 10);
                    DBMS_OUTPUT.put_Line (sbmensaje);
                    RAISE ex_error;
                END IF;

                nuitfijo := NULL;
                nuitvar := NULL;
            END IF;

            FOR rtotrositems IN cuobtieneotrositems (-1, -1, -1)
            LOOP
                IF (rtotrositems.itconitfi IS NULL)
                THEN
                    sbmensaje :=
                        'No existe item FIJO configurado en ORITC para PTOS CONECTADOS o PTOS ADICIONALES o EQUIPAMENTO';
                    RAISE ex_error;
                END IF;

                --NC 2094: Modificacion 13-12-2013
                idtDate := SYSDATE; --daor_order.fdtgetlegalization_date(nuordeninst);
                inuContract :=
                    daOR_order.Fnugetdefined_Contract_Id (nuordeninst);
                inuContractor :=
                    daor_operating_unit.fnugetcontractor_id (nuunidoperi);
                inuGeoLocation :=
                    daOR_order.Fnugetgeograp_Location_Id (nuordeninst);
                isbType := 1;    -- Tipo de Acta: 1-Liquidacion, 2-Facturacion
                CT_BOLiquidationSupport.GetListItemValue (
                    rtotrositems.itconitfi,
                    idtDate,
                    nuunidoperi,
                    inuContract,
                    inuContractor,
                    inuGeoLocation,
                    isbType,
                    onuPriceListId,
                    onuValue);
                --/*
                --aplica AIU a valor de costo de item
                ldc_getaiubyorder (nuordeninst,
                                   onuadmin,
                                   onuimpre,
                                   onuutili);

                IF onuadmin <> 0 OR onuimpre <> 0 OR onuutili <> 0
                THEN
                    onuValue :=
                        ROUND (
                              onuValue
                            + (  (onuValue * (onuadmin / 100))
                               + (onuValue * (onuimpre / 100))
                               + (onuValue * (onuutili / 100))));
                END IF;

                ---fin aplica AIU a valor de costo de item */
                pkg_Traza.Trace (
                       'ONVALE --> '
                    || onuValue
                    || ' - ITEM --> '
                    || rtotrositems.itconitfi,
                    10);
                DBMS_OUTPUT.put_Line (
                       'ONVALE --> '
                    || onuValue
                    || ' - ITEM --> '
                    || rtotrositems.itconitfi);
                --Fin Modificacion 13-12-2013
                pkg_Traza.Trace (
                    '1. GENERA item ORDEN DE INSTALACION OTROS itemS',
                    10);
                DBMS_OUTPUT.put_Line (
                    '1. GENERA item ORDEN DE INSTALACION OTROS itemS');

                --rnp1751
                OPEN cudatoexiste (nusucai);

                FETCH cudatoexiste INTO nucudatoexiste;

                CLOSE cudatoexiste;

                --fin rnp1751
                IF (rtotrositems.itconitfi = 4294990 AND nucudatoexiste = 1)
                THEN
                    nuidAtributo := 0;

                    OPEN cuidatributotmp (nugrupodatos, 'PTOS_ADICIONALES');

                    FETCH cuidatributotmp INTO nuidatributo;

                    CLOSE cuidatributotmp;

                    sbptosadicion :=
                        LDC_BOORDENES.fnugetvalorotbydatadd (
                            nutipotrabi,
                            nugrupodatos,
                            'PTOS_ADICIONALES',
                            nuordeninst);
                    pkg_Traza.Trace (
                        'PTOS_ADICIONALES-sblonginterna -->' || sbptosadicion,
                        10);
                    DBMS_OUTPUT.put_Line (
                        'PTOS_ADICIONALES-sblonginterna -->' || sbptosadicion);

                    IF    sbptosadicion IS NULL
                       OR TO_NUMBER (sbptosadicion) <= 0
                    THEN
                        sbptosadicion :=
                            LDC_BOORDENES.fsbdatoadictmporden (
                                nuordeninst,
                                nuidatributo,
                                'PTOS_ADICIONALES');
                        pkg_Traza.Trace (
                               'PTOS_ADICIONALES-sblonginterna tmp-->'
                            || sbptosadicion,
                            10);
                        DBMS_OUTPUT.put_Line (
                               'PTOS_ADICIONALES-sblonginterna tmp-->'
                            || sbptosadicion);
                    END IF;

                    /*
                    pkg_Traza.Trace('PTOS_ADICIONALES-nuidatributo-->'||nuidatributo,10);
                    sbptosadicion := LDC_BOORDENES.fsbdatoadictmporden(nuordeninst, nuidatributo, 'PTOS_ADICIONALES');
                    pkg_Traza.Trace('PTOS_ADICIONALES-sbptosadicion tmp-->'||sbptosadicion,10);
                    --if(sbptosadicion is null) then
                    IF sbptosadicion IS NULL OR TO_NUMBER(sbptosadicion) <= 0  THEN
                      sbptosadicion := LDC_BOORDENES.fnugetvalorotbydatadd(nutipotrabi, nugrupodatos, 'PTOS_ADICIONALES', nuordeninst);
                      pkg_Traza.Trace('PTOS_ADICIONALES-sbptosadicion-->'||sbptosadicion,10);
                    end if;
                    */
                    IF     (    sbptosadicion IS NOT NULL
                            AND TO_NUMBER (sbptosadicion) > 0)
                       AND (onuValue > 0)
                    THEN
                        onuValue := onuValue * TO_NUMBER (sbptosadicion);
                        --LDC_OS_REGISTERNEWCHARGE (nuunidoperi, rtotrositems.itconitfi, NULL, nuordeninst, onuValue, NULL, nuTipoComentario, 'Pago item Instalacion Interna', nuerrorcode, sberrormessage);
                        --OS_REGISTERNEWCHARGE (nuunidoperi, rtotrositems.itconitfi, NULL, nuordeninst, onuValue, sbptosadicion, nuTipoComentario, 'Pago item Instalacion Interna', nuerrorcode, sberrormessage);
                        nuerrorcode :=
                            ldc_boordenes.FrgItemOrden (
                                nuordeninst,
                                rtotrositems.itconitfi,
                                TO_NUMBER (sbptosadicion),
                                TO_NUMBER (sbptosadicion),
                                onuValue);

                        IF (nuerrorcode <> 0)
                        THEN
                            pkg_Traza.Trace (
                                   '2. ERROR AL GENERA item ORDEN DE INSTALACION OTROS itemS '
                                || sberrormessage,
                                10);
                            DBMS_OUTPUT.put_Line (
                                   '2. ERROR AL GENERA item ORDEN DE INSTALACION OTROS itemS '
                                || sberrormessage);
                            RAISE pkg_Error.CONTROLLED_ERROR;
                        /*
                         ELSE

                          OPEN cuGetOrdenNovedad(nuordeninst,rtotrositems.itconitfi);
                           FETCH cuGetOrdenNovedad INTO nuRegOrderItem;
                           CLOSE cuGetOrdenNovedad;

                          IF daor_order_items.fblexist(nuRegOrderItem) THEN
                             UPDATE OR_order_items
                             SET legal_item_amount = TO_NUMBER(sbptosadicion)
                             WHERE order_items_id = nuRegOrderItem;
                           END IF;
                         */
                        END IF;

                        nuerrorcode := NULL;
                        sberrormessage := NULL;
                    ELSE
                        pkg_Traza.Trace (
                            '2. No genero novedad por el dato adicinal nulo o menor que 0',
                            10);
                        DBMS_OUTPUT.put_Line (
                            '2. No genero novedad por el dato adicinal nulo o menor que 0');
                    END IF;
                END IF;

                IF (rtotrositems.itconitfi = 4294991)
                THEN
                    nuidAtributo := 0;

                    OPEN cuidatributotmp (nugrupodatos, 'PUNTOS_CONECTADOS');

                    FETCH cuidatributotmp INTO nuidatributo;

                    CLOSE cuidatributotmp;

                    sbptosconecta :=
                        LDC_BOORDENES.fnugetvalorotbydatadd (
                            nutipotrabi,
                            nugrupodatos,
                            'PUNTOS_CONECTADOS',
                            nuordeninst);
                    pkg_Traza.Trace (
                        'PTOS_ADICIONALES-sblonginterna -->' || sbptosconecta,
                        10);
                    DBMS_OUTPUT.put_Line (
                        'PTOS_ADICIONALES-sblonginterna -->' || sbptosconecta);

                    IF    sbptosconecta IS NULL
                       OR TO_NUMBER (sbptosconecta) <= 0
                    THEN
                        sbptosconecta :=
                            LDC_BOORDENES.fsbdatoadictmporden (
                                nuordeninst,
                                nuidatributo,
                                'PUNTOS_CONECTADOS');
                        pkg_Traza.Trace (
                               'PTOS_ADICIONALES-sblonginterna tmp-->'
                            || sbptosconecta,
                            10);
                        DBMS_OUTPUT.put_Line (
                               'PTOS_ADICIONALES-sblonginterna tmp-->'
                            || sbptosconecta);
                    END IF;

                    /*
                    pkg_Traza.Trace('PUNTOS_CONECTADOS-nuidatributo-->'||nuidatributo,10);
                    sbptosconecta := LDC_BOORDENES.fsbdatoadictmporden(nuordeninst, nuidatributo, 'PUNTOS_CONECTADOS');
                    pkg_Traza.Trace('PUNTOS_CONECTADOS-sbptosconecta tmp-->'||sbptosconecta,10);
                    --if(sbptosconecta is null) then
                    IF sbptosconecta IS NULL OR TO_NUMBER(sbptosconecta) <= 0  THEN
                      sbptosconecta := LDC_BOORDENES.fnugetvalorotbydatadd(nutipotrabi, nugrupodatos, 'PUNTOS_CONECTADOS', nuordeninst);
                      pkg_Traza.Trace('PUNTOS_CONECTADOS-sbptosconecta-->'||sbptosconecta,10);
                    end if;

                    */
                    IF     (    sbptosconecta IS NOT NULL
                            AND TO_NUMBER (sbptosconecta) > 0)
                       AND (onuValue > 0)
                    THEN
                        onuValue := onuValue * TO_NUMBER (sbptosconecta);
                        --LDC_OS_REGISTERNEWCHARGE (nuunidoperi, rtotrositems.itconitfi, NULL, nuordeninst, onuValue, NULL, nuTipoComentario, 'Pago item Instalacion Interna', nuerrorcode, sberrormessage);
                        --OS_REGISTERNEWCHARGE (nuunidoperi, rtotrositems.itconitfi, NULL, nuordeninst, onuValue, sbptosconecta, nuTipoComentario, 'Pago item Instalacion Interna', nuerrorcode, sberrormessage);
                        nuerrorcode :=
                            ldc_boordenes.FrgItemOrden (
                                nuordeninst,
                                rtotrositems.itconitfi,
                                TO_NUMBER (sbptosconecta),
                                TO_NUMBER (sbptosconecta),
                                onuValue);

                        IF (nuerrorcode <> 0)
                        THEN
                            pkg_Traza.Trace (
                                   '3. ERROR AL GENERA item ORDEN DE INSTALACION OTROS itemS '
                                || sberrormessage,
                                10);
                            DBMS_OUTPUT.put_Line (
                                   '3. ERROR AL GENERA item ORDEN DE INSTALACION OTROS itemS '
                                || sberrormessage);
                            RAISE pkg_Error.CONTROLLED_ERROR;
                        /*
                         ELSE

                          OPEN cuGetOrdenNovedad(nuordeninst,rtotrositems.itconitfi);
                           FETCH cuGetOrdenNovedad INTO nuRegOrderItem;
                           CLOSE cuGetOrdenNovedad;

                          IF daor_order_items.fblexist(nuRegOrderItem) THEN
                             UPDATE OR_order_items
                             SET legal_item_amount = TO_NUMBER(sbptosconecta)
                             WHERE order_items_id = nuRegOrderItem;
                           END IF;
                         */
                        END IF;

                        nuerrorcode := NULL;
                        sberrormessage := NULL;
                    ELSE
                        pkg_Traza.Trace (
                            '3. No genero novedad por el dato adicinal nulo o menor que 0',
                            10);
                        DBMS_OUTPUT.put_Line (
                            '3. No genero novedad por el dato adicinal nulo o menor que 0');
                    END IF;
                END IF;

                IF (rtotrositems.itconitfi = 4294992)
                THEN
                    pkg_Traza.Trace ('nusucai-->' || nusucai, 10);

                    IF (nusucai >= 1 AND nusucai <= 3) AND (onuValue > 0)
                    THEN
                        --LDC_OS_REGISTERNEWCHARGE (nuunidoperi, rtotrositems.itconitfi, null, nuordeninst, onuValue, NULL, nuTipoComentario, 'Pago item Instalacion Interna', nuerrorcode, sberrormessage);
                        --OS_REGISTERNEWCHARGE (nuunidoperi, rtotrositems.itconitfi, null, nuordeninst, onuValue, 1, nuTipoComentario, 'Pago item Instalacion Interna', nuerrorcode, sberrormessage);
                        nuerrorcode :=
                            ldc_boordenes.FrgItemOrden (
                                nuordeninst,
                                rtotrositems.itconitfi,
                                1,
                                1,
                                onuValue);

                        IF (nuerrorcode <> 0)
                        THEN
                            pkg_Traza.Trace (
                                   '4. ERROR AL GENERA item ORDEN DE INSTALACION OTROS itemS '
                                || sberrormessage,
                                10);
                            DBMS_OUTPUT.put_Line (
                                   '4. ERROR AL GENERA item ORDEN DE INSTALACION OTROS itemS '
                                || sberrormessage);
                            RAISE pkg_Error.CONTROLLED_ERROR;
                        /*
                         ELSE

                          OPEN cuGetOrdenNovedad(nuordeninst,rtotrositems.itconitfi);
                           FETCH cuGetOrdenNovedad INTO nuRegOrderItem;
                           CLOSE cuGetOrdenNovedad;

                          IF daor_order_items.fblexist(nuRegOrderItem) THEN
                             UPDATE OR_order_items
                             SET legal_item_amount = 1
                             WHERE order_items_id = nuRegOrderItem;
                           END IF;
                         */
                        END IF;

                        nuerrorcode := NULL;
                        sberrormessage := NULL;
                    END IF;
                END IF;
            END LOOP;
        END IF;
    --FIN ITEMS PARA ORDEN DE INSTALACION--
    EXCEPTION
        WHEN ex_error
        THEN
            --raise;
            --pkg_Error.setError;
            --errors.geterror(nuerrorcode, sberrormessage);
            ge_boerrors.seterrorcodeargument (Ld_Boconstans.cnuGeneric_Error,
                                              sberrormessage);
            pkg_Traza.Trace ('Error procreaitemspago: ' || sberrormessage,
                             10);
            DBMS_OUTPUT.put_line (
                'Error procreaitemspago: ' || sberrormessage);
            RAISE;
        --GI_BOERRORS.SETERRORCODEARGUMENT(Ld_Boconstans.cnuGeneric_Error, sbMensaje);
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            --errors.geterror(nuerrorcode, sberrormessage);
            ---pkg_Traza.Trace('Error procreaitemspago: ' || sqlerrm, 8);
            --dbms_output.put_line ('Error procreaitemspago: ' || sqlerrm);
            pkg_Traza.Trace ('Error procreaitemspago: ' || sberrormessage,
                             10);
            DBMS_OUTPUT.put_line (
                'Error procreaitemspago: ' || sberrormessage);
            ge_boerrors.seterrorcodeargument (Ld_Boconstans.cnuGeneric_Error,
                                              sberrormessage);
            RAISE;
        WHEN OTHERS
        THEN
            --pkg_Error.setError;
            --errors.geterror(nuerrorcode, sberrormessage);
            --pkg_Traza.Trace('Error procreaitemspago: ' || sqlerrm, 8);
            --dbms_output.put_line ('Error procreaitemspago: ' || sqlerrm);
            pkg_Traza.Trace ('Error procreaitemspago: ' || sberrormessage,
                             10);
            DBMS_OUTPUT.put_line (
                'Error procreaitemspago: ' || sberrormessage);
            ge_boerrors.seterrorcodeargument (Ld_Boconstans.cnuGeneric_Error,
                                              sberrormessage);
            RAISE;
    END procreaitemspago;

    /*****************************************
    Metodo: fnucomparaitemscertrepara
    Descripcion:  Compara cantidades de items legalizados entre la orden de certificacion o apoyo  y la orden de reparacion
                  Retorna 0 si encontro diferencias
    Autor: Luz Andrea Angel/OLSoftware
    Fecha: Jumio 4/2013

    Fecha                IDEntrega           Modificacion
    ============    ================    ============================================
    16-10-2013          luzaa            NC746: Se impacta el cursor cuitemsrepara para que obtenga los items tipo 51
    27-02-2015          manuelg          ARA5760: Se realizan los cambios comentareados con (Aranda 5760)
     ******************************************/
    FUNCTION fnucomparaitemscertrepara (
        nusolicitud   or_order_activity.package_id%TYPE,
        nuorden       or_order.order_id%TYPE,
        nutipotrab    or_order.task_type_id%TYPE,
        sbgrupos      VARCHAR2)
        RETURN VARCHAR2
    AS
        --obtener las ordenes de reparacion asociadas a la solciitud
        CURSOR cuotsrepara (nusolic mo_packages.package_id%TYPE)
        IS
            SELECT a.order_id, a.task_type_id, b.causal_id
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.task_type_id IN
                           (SELECT id_trabcert
                              FROM ldc_trab_cert
                             WHERE ldc_boutilities.fsbBuscaToken (
                                       dald_parameter.fsbgetvalue_chain (
                                           'TRAB_NO_GENERA_CERT_ASOCIADOS'),
                                       ID_TRABCERT,
                                       ',') =
                                   'N')
                   AND a.package_id = nusolic;

        --obtener los items de una orden de reparacion
        CURSOR cuitemsrepara (nuorden or_order.order_id%TYPE)
        IS
            SELECT a.order_id, a.items_id, a.legal_item_amount
              FROM or_order_items a, ge_items b
             WHERE     b.items_id = a.items_id
                   AND b.item_classif_id = 51
                   AND a.order_id = nuorden;

        --obtiene los grupos de datos adicionales del tipo de trabajo
        CURSOR cugrupos (sbgrupo VARCHAR2)
        IS
            SELECT COLUMN_VALUE
              FROM TABLE (ldc_boutilities.SPLITstrings (sbGrupo, ','));

        nuordenreparacomp   or_order.order_id%TYPE;
        nuitemrepara        or_order_items.items_id%TYPE;
        nucantidad          or_order_items.legal_item_amount%TYPE;
        nuCausal            ge_causal.causal_id%TYPE;
        sbitem              VARCHAR2 (15);
        sbdiferentes        VARCHAR2 (2000);
        sbCausales          VARCHAR2 (2000);
        sbcantitem          VARCHAR2 (15);
        nuCausaTerceros     NUMBER;
        nucompara           NUMBER := 1;
        nucuenta            NUMBER;
        nugrupo             NUMBER;
        sbEncuentra         VARCHAR2 (1) := 'N';
    BEGIN
        pkg_Traza.Trace ('fnucomparaitemscertrepara', 10);

        --obtiene todas las ordenes de reparacion asociadas a la solicitud
        FOR rtotsreparacion IN cuotsrepara (nusolicitud)
        LOOP
            nuordenreparacomp := rtotsreparacion.order_id;
            pkg_Traza.Trace (
                   'fnucomparaitemscertrepara-nuordenreparacomp -->'
                || nuordenreparacomp,
                10);
            nucausal := rtotsreparacion.causal_id;
            pkg_Traza.Trace (
                'fnucomparaitemscertrepara-nucausal -->' || nucausal,
                10);
            sbcausales :=
                dald_parameter.fsbgetvalue_chain (
                    'CAUSAL_INCUMPLE_REPARACION');
            nuCausaTerceros :=
                dald_parameter.fnugetnumeric_value (
                    'CAUSA_TRABAJOS_POR_TERCEROS',
                    NULL);

            --causal trabajos realizados por terceros
            IF (   (nucausal != nuCausaTerceros)
                OR (ldc_boutilities.fsbbuscatoken (sbcausales,
                                                   TO_CHAR (nucausal),
                                                   ',') =
                    'S'))
            THEN
                --obtiene los items de la orden de reparacion
                FOR rtitemsreparacion IN cuitemsrepara (nuordenreparacomp)
                LOOP
                    nuitemrepara := rtitemsreparacion.items_id;
                    nucantidad := rtitemsreparacion.legal_item_amount;

                    IF (nucantidad > 0)
                    THEN
                        pkg_Traza.Trace (
                               'fnucomparaitemscertrepara-nuitemrepara -->'
                            || nuitemrepara,
                            10);
                        pkg_Traza.Trace (
                               'fnucomparaitemscertrepara-nucantidad -->'
                            || nucantidad,
                            10);
                        nucuenta := 1;
                        sbencuentra := 'N';

                        FOR rtgrupos IN cugrupos (sbgrupos)
                        LOOP
                            nugrupo := TO_NUMBER (rtgrupos.COLUMN_VALUE);
                            --<<Aranda 5760: Se inicializa la variable en 1
                            nucuenta := 1;

                            -->>
                            WHILE ((nucuenta <= 20) AND (sbencuentra = 'N'))
                            LOOP
                                sbitem :=
                                    fnugetvalorotbydatadd (
                                        nutipotrab,
                                        nugrupo,
                                        'ITEM_' || nucuenta,
                                        nuorden);
                                pkg_Traza.Trace (
                                       'fnucomparaitemscertrepara-sbitem -->'
                                    || sbitem,
                                    10);
                                sbcantitem :=
                                    fnugetvalorotbydatadd (
                                        nutipotrab,
                                        nugrupo,
                                        'CANTIDAD_ITEM_' || nucuenta,
                                        nuorden);

                                IF (TO_NUMBER (sbitem) = nuitemrepara)
                                THEN
                                    pkg_Traza.Trace (
                                           'fnucomparaitemscertrepara-sbcantitem -->'
                                        || sbcantitem,
                                        10);
                                    --compara cantidad
                                    sbencuentra := 'S';
                                    EXIT;
                                END IF;

                                nucuenta := nucuenta + 1;
                                pkg_Traza.Trace (
                                       'fnucomparaitemscertrepara-nucuenta -->'
                                    || nucuenta,
                                    10);
                            END LOOP;                                  --while

                            --compara la cantidad de la ot de apoyo y la de reparacion
                            pkg_Traza.Trace (
                                'fnucomparaitemscertrepara-compara cantidad',
                                10);

                            IF (sbencuentra = 'S')
                            THEN
                                --<< Aranda 5760: Se incluye la l??gica dentro de la condici??n
                                IF (TO_NUMBER (sbcantitem) != nucantidad)
                                THEN
                                    IF (sbdiferentes IS NULL)
                                    THEN
                                        sbdiferentes := nuitemrepara;
                                    ELSE
                                        sbdiferentes :=
                                               sbdiferentes
                                            || ','
                                            || nuitemrepara;
                                    END IF;
                                END IF;

                                -->>
                                EXIT;
                            END IF;
                        END LOOP;                            --ciclo de grupos
                    END IF;                                  --valida cantidad
                END LOOP;                                     --ciclo de items

                pkg_Traza.Trace (
                       'fnucomparaitemscertrepara-sbdiferentes-->'
                    || sbdiferentes,
                    10);
            END IF;                                          --causal terceros
        END LOOP;                                       --ciclo ots reparacion

        --return nucompara;
        RETURN sbdiferentes;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN '-1';
    END fnucomparaitemscertrepara;

    /*****************************************
    Metodo: proComparaCantCertRepara
    Descripcion:  Compara cantidades legalizadas entre la orden de certificacion o apoyo  y la orden de reparacion
                  La orden de reparacion se toma desde la instancia
    Autor: Luz Andrea Angel/OLSoftware
    Fecha: Mayo 31/2013

    Fecha                IDEntrega           Modificacion
    ============    ================    ============================================
    13-12-2013      Sayra Ocoro         NC 2094: Se adiciona metodo para obtener el valor del item antes de crear la novedad
    02-04-2014      Jorge Valiente      Aranda 3283: Modificacion de la logica el cursor cuordenapoyo para que filtre y ordene con la ultima
                                                     orden de correccion generada de la certificacion de instalacion.
                                                     al final de la sentencia del cursor se coloca que ordenara descendentemente.

    27-Enero-2015   Sergio Gomez        Aranda 5876: Modificacion de la logica del cursor "cuObtOrdenRepara", para que la consulta se realice
                                                     sobre la tabla OR_ORDER y no sobre la tabla OR_ORDER_ACTIVITY.
                                                     De esta forma solo obtendr?? las ??rdenes de reparaci??n con trabajos
                                                     certificables.
    ******************************************/
    PROCEDURE procomparacantcertrepara
    IS
        --valida que la orden que llega sea de reparacion
        CURSOR cuObtOrdenRepara (nuOrden or_order.order_id%TYPE)
        IS
            SELECT a.order_id, a.task_type_id
              FROM or_order a
             WHERE     a.task_type_id IN
                           (SELECT id_trabcert
                              FROM ldc_trab_cert
                             WHERE ldc_boutilities.fsbBuscaToken (
                                       dald_parameter.fsbgetvalue_chain (
                                           'TRAB_NO_GENERA_CERT_ASOCIADOS'),
                                       ID_TRABCERT,
                                       ',') =
                                   'N')
                   AND a.order_id = nuorden;

        --solicitud asociada a la reparacion
        CURSOR cusolicitud (nuorden or_order.order_id%TYPE)
        IS
            SELECT b.package_id, c.package_type_id
              FROM or_order a, or_order_activity b, mo_packages c
             WHERE     a.order_id = b.order_id
                   AND b.package_id = c.package_id
                   AND b.order_id = nuOrden;

        --obtiene la ultima orden de certificacion asociada a la solicitud
        CURSOR cuordencert (nusolic      mo_packages.package_id%TYPE,
                            sbtrabajoc   VARCHAR2)
        IS
            SELECT order_id,
                   task_type_id,
                   operating_unit_id,
                   causal_id
              FROM (  SELECT a.order_id,
                             a.task_type_id,
                             b.operating_unit_id,
                             b.causal_id
                        FROM or_order_activity a, or_order b
                       WHERE     a.order_id = b.order_id
                             AND a.task_type_id IN
                                     (SELECT TO_NUMBER (COLUMN_VALUE)
                                        FROM TABLE (
                                                 ldc_boutilities.splitstrings (
                                                     sbtrabajoc,
                                                     ',')))
                             AND b.order_status_id = 8
                             --      and o1.causal_id in (9944, 9945, 9594, 9947)
                             AND ldc_boutilities.fsbbuscatoken (
                                     dald_parameter.fsbgetvalue_chain (
                                         'CAUSA_CERT_ASOCIADOS'),
                                     TO_CHAR (b.causal_id),
                                     ',') =
                                 'S'
                             AND a.package_id = nusolic
                    ORDER BY 1 DESC) orden_cetif
             WHERE ROWNUM = 1;

        --obtiene la orden de apoyo desde la solicitud de venta
        CURSOR cuOrdenApoyo (nuSolicitud mo_packages.package_id%TYPE)
        IS
            SELECT a.order_id, b.task_type_id
              FROM or_order a, or_order_activity b
             WHERE     a.order_id = b.order_id
                   AND b.package_id = nusolicitud
                   AND b.task_type_id = 10280 --; --OT apoyo CORRECCION DATOS LEGALIZACION CERTIFICACION ASOCIADOS
                   --Aranda 3283
                   AND A.LEGALIZATION_DATE =
                       (SELECT MAX (legalization_date)
                          FROM (  SELECT o1.order_id,
                                         o1.causal_id,
                                         o1.legalization_date
                                    FROM or_order         o1,
                                         or_order_activity oa1
                                   WHERE     oa1.order_id = o1.order_id
                                         AND o1.task_type_id = 10280
                                         --dald_parameter.fnuGetNumeric_Value('COD_COR_DAT_LEG_CER_NUE',
                                         --                                        NULL)
                                         AND oa1.Package_Id = nusolicitud
                                         AND o1.causal_id =
                                             dald_parameter.fnuGetNumeric_Value (
                                                 'COD_CAU_OT_LEG',
                                                 NULL)
                                ORDER BY 1 DESC) orden_certif); --OT apoyo Correccionm datos de legaliz. certif.

        --Fin Aranda 3283
        --NC999 valida si la unidad de trabajo es externa
        CURSOR cuunidadexterna (nuunidadoper or_order.operating_unit_id%TYPE)
        IS
            SELECT es_externa
              FROM or_operating_unit
             WHERE operating_unit_id = nuunidadoper;

        CURSOR cuvalidamulta (nuordenc   or_order.order_id%TYPE,
                              nuitemM    ge_items.items_id%TYPE)
        IS
            SELECT a.order_id
              FROM or_related_order a
             WHERE     a.rela_order_type_id = 14
                   AND a.order_id = nuordenc
                   AND (SELECT b.order_id
                          FROM or_order_activity b
                         WHERE     b.activity_id = nuitemm
                               AND b.order_id = a.related_order_id) =
                       1;

        nuordenrepara      or_order.order_id%TYPE;
        nuordenr           or_order.order_id%TYPE;
        nutipotrabr        or_order.task_type_id%TYPE;
        nutipopaq          mo_packages.package_type_id%TYPE;
        nusolicitud        mo_packages.package_id%TYPE;
        nuordenc           or_order.order_id%TYPE;
        nutrabc            or_order.task_type_id%TYPE;
        nuunioperc         or_order.operating_unit_id%TYPE;
        nucausalc          or_order.causal_id%TYPE;
        nuordenapoyo       or_order.order_id%TYPE;
        nutipotrabap       or_order.task_type_id%TYPE;
        nuitemmulta        ge_items.items_id%TYPE;
        nutitrcertif       or_task_type.task_type_id%TYPE;
        nuOrdenMulta       or_order.order_id%TYPE;
        sbmensaje          VARCHAR2 (2000);
        sbitemDif          VARCHAR2 (2000);
        sbaplicamulta      VARCHAR2 (2);
        sbGrupos           VARCHAR2 (20);
        nucompara          NUMBER;
        nuerrorcode        NUMBER;
        nupersonid         NUMBER;
        sberrormessage     VARCHAR2 (4000);
        nutipocomentario   NUMBER := 1298;
        sbExterna          VARCHAR2 (2) := 'N';
        EX_ERROR           EXCEPTION;
        onuValue           ge_unit_cost_ite_lis.price%TYPE;
        onuPriceListId     ge_list_unitary_cost.list_unitary_cost_id%TYPE;
        idtDate            DATE;
        inuContract        ge_list_unitary_cost.contract_id%TYPE;
        inuContractor      ge_list_unitary_cost.contractor_id%TYPE;
        inuGeoLocation     ge_list_unitary_cost.geograp_location_id%TYPE;
        isbType            ge_acta.id_tipo_acta%TYPE;
        sbtitrcertif       VARCHAR2 (30); --Tiquet 200-1077 LJLB -- Se guarda tipo de trabajo
    BEGIN
        pkg_Traza.Trace ('Inicia LDC_BOORDENES.procomparacantcertrepara', 10);
        --orden de reparacion de la instancia
        nuordenrepara := or_bolegalizeorder.fnugetcurrentorder;
        pkg_Traza.Trace (
            'procomparacantcertrepara-nuordenrepara-->' || nuordenrepara,
            10);

        --valida que sea una orden de reparacion
        OPEN cuObtOrdenRepara (nuordenrepara);

        FETCH cuObtOrdenRepara INTO nuordenR, nutipotrabR;

        CLOSE cuobtordenrepara;

        --si la orden de la instancia es de reparacion
        pkg_Traza.Trace (
            'procomparacantcertrepara-nutipotrabR-->' || nutipotrabR,
            10);

        IF (nutipotrabR IS NOT NULL)
        THEN
            OPEN cuSolicitud (nuordenR);

            FETCH cusolicitud INTO nusolicitud, nutipopaq;

            CLOSE cusolicitud;

            pkg_Traza.Trace (
                'procomparacantcertrepara-nusolicitud-->' || nusolicitud,
                10);
            pkg_Traza.Trace (
                'procomparacantcertrepara-nutipopaq-->' || nutipopaq,
                10);

            --valido el paquete para saber la ot de certificacion correspondiente
            IF (nutipopaq IS NOT NULL)
            THEN
                --NC 2309_2 : Se parametrizan los tipos de solicitu
                --si la reparacion es por medio de RP
                --Tiquet 200-1077 LJLB -- Se cambia forma de busqueda del tipo de trabajo
                /*if (nutipopaq = 100153 or
                   nutipopaq =
                   DALD_PARAMETER.fnuGetNumeric_Value('ID_PKG_TYPE_RP_MASIVA') or
                   nutipopaq =
                   DALD_PARAMETER.fnuGetNumeric_Value('ID_PKG_TYPE_RP') or
                   nutipopaq = DALD_PARAMETER.fnuGetNumeric_Value('COD_SOLI_RECO')) then
                  nutitrcertif := 12164;
                  --si la reparacion es por medio de servicios de ingenieria
                  --elsif(nutipopaq = 100101) then
                  --elsif(nutipopaq = 100101 or nutipopaq = 100225) then
                elsif instr(DALD_PARAMETER.fsbGetValue_Chain('ID_PKG_REPARA_SERV_ING'),
                            to_char(nutipopaq)) > 0 then
                  nutitrcertif := 12163;
                end if;
                */
                --Tiquet 200-1077 LJLB -- Se valida si el tipo de solicitud es para certificado de revision periodica
                IF INSTR (
                       DALD_PARAMETER.fsbGetValue_Chain (
                           'LDC_TIPOSOLI_CERTREPE'),
                       TO_CHAR (nutipopaq)) >
                   0
                THEN
                    sbtitrcertif := '12164';
                END IF;

                --Tiquet 200-1077 LJLB -- Se valida si el tipo de solicitud es para el trabajo  12163
                IF INSTR (
                       DALD_PARAMETER.fsbGetValue_Chain (
                           'ID_PKG_REPARA_SERV_ING'),
                       TO_CHAR (nutipopaq)) >
                   0
                THEN
                    sbtitrcertif := '12163';
                END IF;

                --Tiquet 200-1077 LJLB -- Se valida si el tipo de solicitud es para los tipos de trabajo 12164, 12163
                IF INSTR (
                       DALD_PARAMETER.fsbGetValue_Chain (
                           'LDC_TIPOSOLI_CERTRPTA'),
                       TO_CHAR (nutipopaq)) >
                   0
                THEN
                    sbtitrcertif := '12164,12163';
                END IF;

                OPEN cuordencert (nusolicitud, sbtitrcertif);

                FETCH cuordencert
                    INTO nuordenc,
                         nutrabc,
                         nuunioperc,
                         nucausalc;

                CLOSE cuordencert;
            END IF;

            pkg_Traza.Trace (
                'procomparacantcertrepara-nuordenc-->' || nuordenc,
                10);

            IF (nuordenc IS NOT NULL)
            THEN
                --obtiene la orden de apoyo asociada a la solicitud
                OPEN cuOrdenApoyo (nuSolicitud);

                FETCH cuOrdenApoyo INTO nuordenapoyo, nutipotrabap;

                CLOSE cuOrdenApoyo;

                --validar datos de apoyo y de reparacion
                IF (nuordenapoyo IS NOT NULL)
                THEN
                    --compara cantidades de items ot apoyo - ot reparacion
                    sbgrupos := '10125,10126';
                    sbitemDif :=
                        ldc_boordenes.fnucomparaitemscertrepara (
                            nusolicitud,
                            nuordenapoyo,
                            nutipotrabap,
                            sbGrupos);
                    sbAplicaMulta :=
                        FnugetValorOTbyDatAdd (nuTipoTrabAp,
                                               11734,
                                               'APLICACION_MULTA?',
                                               nuOrdenApoyo);

                    --en la orden de apoyo si el valor del dato adicional "Genera_multa" es Si, se debe crear la novedad
                    IF (UPPER (sbaplicamulta) = UPPER ('Si'))
                    THEN
                        nuitemmulta := 4295071;

                        OPEN cuunidadexterna (nuunioperc);

                        FETCH cuunidadexterna INTO sbExterna;

                        CLOSE cuunidadexterna;

                        OPEN cuvalidamulta (nuordenc, nuitemmulta);

                        IF (    UPPER (sbExterna) = UPPER ('Y')
                            AND nuOrdenMulta IS NULL)
                        THEN
                            FETCH cuvalidamulta INTO nuOrdenMulta;

                            CLOSE cuvalidamulta;

                            nupersonid := ge_bopersonal.fnugetpersonid;
                            --Modificacion 11-12-2013
                            idtDate := SYSDATE; --daor_order.fdtgetlegalization_date(nuordenc);
                            inuContract :=
                                daOR_order.Fnugetdefined_Contract_Id (
                                    nuordenc);
                            inuContractor :=
                                daor_operating_unit.fnugetcontractor_id (
                                    nuunioperc);
                            inuGeoLocation :=
                                daOR_order.Fnugetgeograp_Location_Id (
                                    nuordenc);
                            isbType := 1; -- Tipo de Acta: 1-Liquidacion, 2-Facturacion
                            CT_BOLiquidationSupport.GetListItemValue (
                                nuitemmulta,
                                idtDate,
                                nuunioperc,
                                inuContract,
                                inuContractor,
                                inuGeoLocation,
                                isbType,
                                onuPriceListId,
                                onuValue);
                            pkg_Traza.Trace (
                                   'ONVALE --> '
                                || onuValue
                                || ' - ITEM --> '
                                || nuitemmulta,
                                10);
                            DBMS_OUTPUT.put_Line (
                                   'ONVALE --> '
                                || onuValue
                                || ' - ITEM --> '
                                || nuitemmulta);
                            --Fin Modificacion 11-12-2013
                            LDC_os_registernewcharge (
                                nuunioperc,
                                nuitemmulta,
                                NULL,
                                nuordenc,
                                onuValue,
                                NULL,
                                nuTipoComentario,
                                'Multa por error en digitacion de datos',
                                nuerrorcode,
                                sberrormessage);

                            --os_registernewcharge (nuunioperc, nuitemmulta, NULL, nuordenc, onuValue, 1, nuTipoComentario, 'Multa por error en digitacion de datos', nuerrorcode, sberrormessage);
                            IF (nuerrorcode <> 0)
                            THEN
                                RAISE pkg_Error.CONTROLLED_ERROR;
                            END IF;

                            nuerrorcode := NULL;
                            sberrormessage := NULL;
                        END IF;
                    END IF;
                --valida datos de orden de certificacion y reparacion
                ELSIF (nuordenc IS NOT NULL)
                THEN
                    pkg_Traza.Trace (
                        'procomparacantcertrepara-ingresa por ot certificacion',
                        10);
                    --compara cantidades de items ot certificacion - ot reparacion
                    sbgrupos := '10123,10124';
                    pkg_Traza.Trace (
                        'procomparacantcertrepara-sbgrupos-->' || sbgrupos,
                        10);
                    pkg_Traza.Trace (
                        'procomparacantcertrepara-nuordenc-->' || nuordenc,
                        10);
                    pkg_Traza.Trace (
                        'procomparacantcertrepara-nutrabc-->' || nutrabc,
                        10);
                    sbitemDif :=
                        ldc_boordenes.fnucomparaitemscertrepara (nuSolicitud,
                                                                 nuordenc,
                                                                 nutrabc,
                                                                 sbGrupos);
                END IF;

                IF (sbitemdif IS NOT NULL)
                THEN
                    sbmensaje :=
                           'Se presentan diferencias entre las cantidades legalizadas entre el certificador y el reparador. Items: '
                        || sbitemDif;
                    RAISE ex_error;
                ELSIF (nuCompara = '-1')
                THEN
                    sbmensaje := 'Se presento una excepcion en el proceso';
                    RAISE ex_error;
                END IF;
            ELSE
                sbmensaje :=
                    'No se puede legalizar la orden de reparacion. Aun no se han certificado las reparaciones';
                pkg_Traza.Trace (
                    'procomparacantcertrepara-NO nuordenc-->' || sbmensaje,
                    10);
                RAISE ex_error;
            END IF;
        END IF;

        pkg_Traza.Trace ('Finaliza LDC_BOORDENES.procomparacantcertrepara',
                         10);
    EXCEPTION
        WHEN EX_ERROR
        THEN
            GI_BOERRORS.SETERRORCODEARGUMENT (Ld_Boconstans.cnuGeneric_Error,
                                              sbMensaje);
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE;
    END procomparacantcertrepara;

    /*****************************************
    Metodo: fsbValDatoAdicOtCertifRepara
    Descripcion:  Funcion que permite obtener el valor del dato adicional de la orden de certificacion
                  de reparacion

    Autor: Luz Andrea Angel/OLSoftware
    Fecha: Junio 04/2013

    Fecha                IDEntrega           Modificacion
    ============    ================    ============================================
    03/10/2013          luzaa            NC999:Se ajusta la logica, ya que estaba trayendo mas de un registro la consulta que obtiene la solicitud
    15-04-2014      Jorge Valiente       Aranda 3283: Modificacion de logica de servicio para obtener la orden de CORRECCION DATOS LEGALIZACION CERTIFICACION ASOCIADOS y ASOCIADOS RP
                                                      El servicio utiliza el mismo tipo de tipo de trabajo para este servicio en la regla de grupo de atributos
                                                      para el tipo de trabajo 10280. por lo que hay de identificar cuando es para el grupo de atributos 10125 y 10126
     ******************************************/
    FUNCTION fsbValDatoAdicOtCertifRepara (
        nuTipoTrab    or_task_type.task_type_id%TYPE,
        nuSetAttrib   ge_attributes_set.attribute_set_id%TYPE,
        nombDatAdd    ge_attributes.name_attribute%TYPE,
        nuOrderId     or_order.order_id%TYPE)
        RETURN VARCHAR2
    IS
        --ARANDA 3283
        --CURSOR PARA OBTENER LA ULTIMA ORDEN DE CORRECION DE CERTIFICACION ASOCIADOS
        CURSOR cuordencorreccioncertif (
            nuorden      or_order.order_id%TYPE,
            nutasktype   or_task_type.task_type_id%TYPE)
        IS
            SELECT order_id
              FROM OR_ORDER OO
             WHERE OO.Legalization_Date =
                   (SELECT MAX (legalization_date)
                      FROM (  SELECT o1.order_id,
                                     o1.causal_id,
                                     o1.legalization_date
                                FROM or_order         o1,
                                     or_order_activity oa1
                               WHERE     oa1.order_id = o1.order_id
                                     AND o1.task_type_id =
                                         dald_parameter.fnuGetNumeric_Value (
                                             'COD_COR_DAT_LEG_CER_ASO',
                                             NULL)
                                     AND oa1.product_id =
                                         (SELECT oa.product_id
                                            FROM or_order         o,
                                                 or_order_activity oa
                                           WHERE     oa.order_id = o.order_id
                                                 AND oa.order_id = nuorden)
                                     AND o1.causal_id =
                                         dald_parameter.fnuGetNumeric_Value (
                                             'COD_CAU_OT_LEG',
                                             NULL)
                            ORDER BY 1 DESC) orden_certif);

        --FIN ARANDA 3283
        CURSOR cuordencertif (nuorden      or_order.order_id%TYPE,
                              nutasktype   or_task_type.task_type_id%TYPE)
        IS
            SELECT order_id
              FROM (  SELECT o1.order_id
                        FROM or_order o1, or_order_activity oa1
                       WHERE     oa1.order_id = o1.order_id
                             AND o1.task_type_id = nuTaskType
                             AND oa1.package_id =
                                 (SELECT oa.package_id
                                    FROM or_order o, or_order_activity oa
                                   WHERE     oa.order_id = o.order_id
                                         AND oa.order_id = nuorden)
                             --and o1.causal_id in (9944, 9945, 9594, 9947)
                             AND ldc_boutilities.fsbbuscatoken (
                                     dald_parameter.fsbgetvalue_chain (
                                         'CAUSA_CERT_ASOCIADOS'),
                                     TO_CHAR (o1.causal_id),
                                     ',') =
                                 'S'
                    ORDER BY 1 DESC) orden_certif
             WHERE ROWNUM = 1;

        nuTaskType    or_task_type.task_type_id%TYPE;
        nuOrderCert   or_order.order_id%TYPE;
        sbValor       VARCHAR2 (4000);
    BEGIN
        pkg_Traza.Trace ('inicio LDC_BOORDENES.fsbValDatoAdicOtCertifRepara',
                         10);
        --ARANADA 3283
        --tipo de trabajo 10280 con el grupo de atributos 10125 y 10126
        pkg_Traza.Trace ('orden instanciada --> ' || nuOrderId, 10);
        pkg_Traza.Trace ('tt instanciada --> ' || nuTipoTrab, 10);

        OPEN cuordencorreccioncertif (nuOrderId, nuTipoTrab);

        FETCH cuordencorreccioncertif INTO nuOrderCert;

        CLOSE cuordencorreccioncertif;

        pkg_Traza.Trace ('ot correccion certificacion --> ' || nuOrderCert,
                         10);

        IF (nuOrderCert IS NOT NULL)
        THEN
            pkg_Traza.Trace ('valida grupo atributo 10125', 10);
            sbValor :=
                LDC_BOORDENES.FNUGETVALOROTBYDATADD (nuTipoTrab,
                                                     10125,     --nuSetAttrib,
                                                     nombDatAdd,
                                                     nuOrderCert);

            IF (sbvalor = '-1')
            THEN
                pkg_Traza.Trace ('valida grupo atributo 10126', 10);
                sbValor :=
                    LDC_BOORDENES.FNUGETVALOROTBYDATADD (nuTipoTrab,
                                                         10126, --nuSetAttrib,
                                                         nombDatAdd,
                                                         nuOrderCert);
            END IF;

            pkg_Traza.Trace ('sbValor --> ' || sbValor, 10);
        ELSE
            --FIN ARANADA 3283
            --DESARROLLO ORGINAL SERVICIO
            pkg_Traza.Trace ('ELSE', 10);

            OPEN cuOrdenCertif (nuOrderId, nuTipoTrab);

            FETCH cuOrdenCertif INTO nuOrderCert;

            CLOSE cuOrdenCertif;

            IF (nuOrderCert IS NOT NULL)
            THEN
                sbValor :=
                    LDC_BOORDENES.FNUGETVALOROTBYDATADD (nuTipoTrab,
                                                         nuSetAttrib,
                                                         nombDatAdd,
                                                         nuOrderCert);
            END IF;
        --FIN DESARROLLO ORIGINAL SERVICIO
        --ARANADA 3283
        END IF;                --fin validacion cursor cuordencorreccioncertif

        IF (sbvalor = '-1')
        THEN
            sbvalor := '0';
        END IF;

        pkg_Traza.Trace ('sbValor a retornar --> ' || sbValor, 10);
        pkg_Traza.Trace ('fin LDC_BOORDENES.fsbValDatoAdicOtCertifRepara',
                         10);
        RETURN sbValor;
    --FIN ARANADA 3283
    /* CODIGO ORIGINAL ANTES DE ARANDA 3283
    Open cuOrdenCertif(nuOrderId, nuTipoTrab);
    Fetch cuOrdenCertif
      into nuOrderCert;
    Close cuOrdenCertif;

    if (nuOrderCert is not null) then
      sbValor := LDC_BOORDENES.FNUGETVALOROTBYDATADD(nuTipoTrab,
                                                     nuSetAttrib,
                                                     nombDatAdd,
                                                     nuOrderCert);
    end if;

    if(sbvalor = '-1') then
      sbvalor := '0';
    end if;

    return sbvalor;
    */
    END fsbValDatoAdicOtCertifRepara;

    /*****************************************************************
    Unidad       : ObtieneLectura
    Descripcion     : Obtiene Lectura del elemento de medicion de una orden
    Parametros          Descripcion
    ============        ===================
    inuOrden        numero de orden

    Historia de Modificaciones
    Fecha       IDEntrega

    19-Junio-2013 Carlos Andres Dominguez - cadona
    ******************************************************************/
    FUNCTION ObtieneLectura (inuOrden OR_order.order_id%TYPE)
        RETURN NUMBER
    IS
        nuOrder_activity   OR_Order_activity.order_activity_id%TYPE;
        nuTipocon          LECTELME.LEEMTCON%TYPE;
        nuLEEMLEAN         LECTELME.LEEMLEAN%TYPE;
        dtLEEMFELA         LECTELME.LEEMFELA%TYPE;
        nuProducto         pr_product.product_id%TYPE;
        OTBELEMMEDI        pkBCElemMedi.TYRCTBELEMMEDI;
        nuElemento         elemmedi.elmecodi%TYPE;
        nuIndice           NUMBER;
    BEGIN
        pkg_Traza.Trace (
            'Inicia LDC_BOORDENES.ObtieneLectura orden[' || inuOrden || ']',
            15);
        nuLEEMLEAN := 0;
        nuOrder_activity :=
            Or_BcOrderActivities.fnuGetFirstOrderAct (inuOrden);
        nuProducto := DAOR_order_activity.fnuGetProduct_id (nuOrder_activity);

        IF (nuProducto IS NOT NULL)
        THEN
            pkBCElemMedi.GETELEMMEDIBYPRODUCT (nuProducto,
                                               SYSDATE,
                                               OTBELEMMEDI);
            nuIndice := OTBELEMMEDI.TBELMEIDEM.FIRST;
            nuElemento := OTBELEMMEDI.TBELMEIDEM (nuIndice);

            IF (nuElemento IS NOT NULL)
            THEN
                PKBCLECTELME.GETLASTLECTURE (nuElemento,
                                             1,
                                             nuLEEMLEAN,
                                             dtLEEMFELA);
            END IF;
        END IF;

        -- Obtiene el ID dado una serie
        pkg_Traza.Trace (
               'Finaliza LDC_BOORDENES.ObtieneLectura lectura['
            || nuLEEMLEAN
            || ']',
            15);
        RETURN nuLEEMLEAN;
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;
    END ObtieneLectura;

    /*****************************************************************
      Unidad       : fsbDatoAdicTmpOrden
      Descripcion     : Obtiene los datos adicionales de una orden que se esta legalizando
                     ya que no se encuentran en la INSTANCIA
      Parametros          Descripcion
      ============        ===================
      nuorden             numero de orden instancia
      nuidatributo        id del atributo
      sbatributo          nombre de atributo

       Autor: Luz Andrea Angel/OLSoftware
      Fecha: Junio 20/2013
    ******************************************************************/
    FUNCTION fsbDatoAdicTmpOrden (
        nuorden        or_order.order_id%TYPE,
        nuidatributo   or_temp_data_values.attribute_id%TYPE,
        sbatributo     or_temp_data_values.attribute_name%TYPE)
        RETURN VARCHAR2
    IS
        CURSOR cudatostemporales (
            nuordenleg   or_order.order_id%TYPE,
            nuidatrib    or_temp_data_values.attribute_id%TYPE,
            sbnombre     or_temp_data_values.attribute_name%TYPE)
        IS
            SELECT data_value
              FROM or_temp_data_values
             WHERE     order_id = nuordenleg
                   AND attribute_id = nuidatrib
                   AND attribute_name = sbnombre;

        sbvalordatod   or_temp_data_values.data_value%TYPE;
    BEGIN
        OPEN cudatostemporales (nuorden, nuidAtributo, sbatributo);

        FETCH cudatostemporales INTO sbvalordatod;

        CLOSE cudatostemporales;

        RETURN sbvalordatod;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            ---no existen datos
            RETURN '-1';
        WHEN OTHERS
        THEN
            ---se esta generando un error al ejecutar la funcion
            RETURN '-2';
    END fsbDatoAdicTmpOrden;

    /*****************************************
    Metodo: fnuControlVisualAnulSoli
    Descripcion: Funcion que valida si el usuario es due?o de la solicitud que esta consultando en el CNCRM o si el usuario
    logueado a SF es del area de servicio al cliente. si el usuario es due?o del tramite de acuerdo a lo parametrizado en la tabla
    LDC_REP_AREA_TI_PA_CA, se habilitara el proceso de Anulacion de Solicitud.
    Si el usuario no es due?o de la solicitud, pero el area del usuario logueado a SF es una de las parametrizadas en la
    tabla LD_PARAMETER campo AREAS_SERCLIENTE (766,43,148,41,145), se habilitara la opcion.
    Si la solicitud se encuentra asociada al area del usuario logueado a SF y el modo de uso es Interno, se habilitara la opcion.
    Autor: Alvaro Zapata
    Fecha: Julio 30/2013
    ------------------------
    Modificaciones:
   REQ.185. 02-01-2020. Eherard (Horbath) Se realiza conrol de excepciones en el retorno de la función FNUCONTROLVISUALANULSOLI.
    ------------------------
    ******************************************/
    FUNCTION fnuControlVisualAnulSoli (
        sbPackageTypeId   PS_PACKAGE_TYPE.DESCRIPTION%TYPE)
        RETURN NUMBER
    IS
        CURSOR CuSoli IS
              SELECT COUNT (1), R.MEDIO_USO
                FROM LDC_REP_AREA_TI_PA_CA R
                     INNER JOIN PS_PACKAGE_TYPE PS
                         ON R.PACKAGE_TYPE_ID = PS.PACKAGE_TYPE_ID
               WHERE TO_CHAR (
                         R.PACKAGE_TYPE_ID || ' - ' || UPPER (PS.DESCRIPTION)) =
                     sbPackageTypeId
            GROUP BY MEDIO_USO;

        CURSOR CuAreas IS
            SELECT ORGANIZAT_AREA_ID
              FROM LDC_REP_AREA_TI_PA_CA  R
                   INNER JOIN PS_PACKAGE_TYPE PS
                       ON R.PACKAGE_TYPE_ID = PS.PACKAGE_TYPE_ID
             WHERE TO_CHAR (
                       R.PACKAGE_TYPE_ID || ' - ' || UPPER (PS.DESCRIPTION)) =
                   sbPackageTypeId;

        nuAreaOrga   NUMBER;
        nuCategori   NUMBER;
        nuCateCodi   NUMBER;
        sbMedioUso   VARCHAR2 (1);
        nuCantidad   NUMBER;
        nuArea       NUMBER;
        --REQ.185
        nu_result    NUMBER;
    BEGIN
        SELECT GP.ORGANIZAT_AREA_ID
          INTO nuAreaOrga
          FROM GE_PERSON  GP
               INNER JOIN GE_ORGANIZAT_AREA AO
                   ON GP.ORGANIZAT_AREA_ID = AO.ORGANIZAT_AREA_ID
         WHERE     PERSON_ID = GE_BOPERSONAL.Fnugetpersonid
               AND AO.ORGANIZAT_AREA_TYPE = 10;

        OPEN CuSoli;

        FETCH CuSoli INTO nuCantidad, sbMedioUso;

        CLOSE CuSoli;

        OPEN CuAreas;

        LOOP
            FETCH CuAreas INTO nuArea;

            EXIT WHEN CuAreas%NOTFOUND;

            --Validaciones
            IF (nuCantidad > 0) AND sbMedioUso = 'I' AND nuArea = nuAreaOrga
            THEN
                nu_result := 1;                                    --RETURN 1;
            ELSE
                IF     (nuCantidad > 0)
                   AND sbMedioUso = 'E'
                   AND LDC_BOUTILITIES.fsbBuscaToken (
                           dald_Parameter.fsbGetValue_Chain (
                               'AREAS_SERCLIENTE'),
                           nuAreaOrga,
                           ',') =
                       'S'
                THEN
                    nu_result := 2;                                --RETURN 2;
                ELSE
                    --XLOGPNO_EHG('fnuControlVisualAnulSoli  nuCantidad: '||nuCantidad||' sbMedioUso: '||sbMedioUso||' nuArea: '||nuArea ||' 3 and'||LDC_BOUTILITIES.fsbBuscaToken(dald_Parameter.fsbGetValue_Chain('AREAS_SERCLIENTE'), nuAreaOrga,','));
                    IF     (nuCantidad > 0)
                       AND sbMedioUso = 'M'
                       AND (   nuArea = nuAreaOrga
                            OR LDC_BOUTILITIES.fsbBuscaToken (
                                   dald_Parameter.fsbGetValue_Chain (
                                       'AREAS_SERCLIENTE'),
                                   nuAreaOrga,
                                   ',') =
                               'S')
                    THEN
                        nu_result := 3;                            --RETURN 3;
                    END IF;
                END IF;
            END IF;
        END LOOP;

        CLOSE CuAreas;

        --Si no entrá en ninguna validación, retorna -1
        IF nu_result IS NULL
        THEN
            nu_result := -1;
        END IF;

        --XLOGPNO_EHG('fnuControlVisualAnulSoli resultado: '||nu_result);
        RETURN nu_result;
        DBMS_OUTPUT.put_line ('fin ');
    EXCEPTION
        WHEN OTHERS
        THEN
            DBMS_OUTPUT.put_line ('Error ' || SQLERRM);
            ---Retorna -1 cuando exista un error al ejecutar la funcion
            RETURN -1;
    END fnuControlVisualAnulSoli;

    /*****************************************************************
    Unidad       : proincumplenuevas
    Descripcion     : Al legalizar como incumplida la orden de CxC o de instalacion, debe cerrar la orden de
                   certificacion y la orden de CxC o instalacion que estaba pendiente.
    Fuente       : NC396

     Autor: Luz Andrea Angel/OLSoftware
    Fecha: Agosto 01/2013

      Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    08-08-2013        luzaa             NC497:Se modifica para que los datos de la orden de la instancia los tome
                                        de lo registrado y no de la instancia
    28-09-2013        luzaa             NC746: Se corrige para que las consultas sena por solicitud y direccion, por el tema de multifamiliares
    24-Abril-2014   Jorge Valiente      Aranda 3445: 1. Que si en la solicitud existe una orden de trabajo del tipo
                                                          ??12474 - CORRECCIÓN DE DEFECTO EN INSTALACIONES NUEVAS??,
                                                          en estado diferente a ??8 ?? CERRADO?? y la última orden de trabajo del tipo
                                                          ??12162 - INSPECCION Y/O CERTIFICACION INSTALACIONES??, con una causal de
                                                          legalizaci??n NO VALIDA;??..  NO DEBE permitir la legalizaci??n de las
                                                          ordenes de trabajo de cargo por conexi??n e Instalaci??n interna,
                                                          tanto residencial como comercial
                                                       2. Que la orden de certificaci??n del tipo de trabajo 12162, fue legalizada con una
                                                          causal VALIDA para permitir la legalizaci??n de las ordenes de Cargo por conexi??n e Instalaci??n interna,
                                                          tanto residencial como comercial; tipos de trabajo 12149, 12150, 12151 y 12152, respectivamente.
    17-Dic-2014     Jorge Valiente      NC4325: Se modificara el cursor cuordenessolicitud para quitar los datos quemados de
                                                los tipos de trabajo y parametrizarlos para que sea el funcional que
                                                determine que tipos de trabajo de la solicitud son los que van cerrar y generar como bloqueado.
    16-Mar-2015     Emiro Leyva         aranda-143569: Se modifica el cursor CUULTIMAOTCERTIFICAION para que busque la orden de 12162 segun la fecha de registro de la orden y no segun la fecha
                                                        de legalizacion, para que traiga la ultima orden de certificacion cundo existe una ya legalizada. Para corregir el siguiente error:
                              Al desbloquear las ordenes e intentar legalizar nuevamente con causal de fallo es que está fallando el sistema, ya que al parecer
                              está teniendo en cuenta la primera certificaci??n que se encuentra cerrada y no la que está asignada
      08/05/2018      dsaltarin          ca 200-1922. Se modifica el cursor CUULTIMAOTCERTIFICAION  del procedimeinto proincumplenuevas
                   |                  para que solo valide ordenes ene stado 8
      22/05/2018      dsaltarin          ca 200-1922. Se modifica el cursor CUULTIMAOTCERTIFICAION se toma la consulta original y se agrega la direccion. Se modifica tambi?n el cursor CUCANTIDADOTCORRECION para que reciba la direcci?n
      25/11/2018      horbath            ca 200-2179. Se modifica cursor CUULTIMAOTCERTIFICAION, CUCANTOTCARGO, CUCANTOTINSTALA, CUCANTOTEJECUTADAS.
    ******************************************************************/
    PROCEDURE proincumplenuevas
    IS
        --cantidad de ordenes de cargo x conexion de una solicitud
        CURSOR cucantotcargo (
            nusolic       or_order_activity.package_id%TYPE,
            nudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT COUNT (*)
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.task_type_id IN
                           (SELECT TO_NUMBER (COLUMN_VALUE)
                              FROM TABLE (
                                       LDC_BOUTILITIES.SPLITSTRINGS (
                                           DALD_PARAMETER.fsbGetValue_Chain (
                                               'COD_CANTOTCARGO_TASK_TYPE',
                                               NULL),
                                           ',')))
                   AND b.order_status_id = 5
                   AND a.package_id = nusolic
                   AND a.address_id = nudireccion;

        --cantidad de ordenes de instalacion de una solicitud
        CURSOR cucantotinstala (
            nusolic       or_order_activity.package_id%TYPE,
            nudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT COUNT (*)
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.task_type_id IN
                           (SELECT TO_NUMBER (COLUMN_VALUE)
                              FROM TABLE (
                                       LDC_BOUTILITIES.SPLITSTRINGS (
                                           DALD_PARAMETER.fsbGetValue_Chain (
                                               'COD_CANTOINSTALA_TASK_TYPE',
                                               NULL),
                                           ',')))
                   AND b.order_status_id = 5
                   AND a.package_id = nusolic
                   AND a.address_id = nudireccion;

        --ordenes en estado 7
        CURSOR cucantotejecutadas (
            nusolic       or_order_activity.package_id%TYPE,
            nudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT COUNT (*)
              FROM or_order b, OR_ORDER_ACTIVITY c
             WHERE     b.order_id = c.order_id
                   AND b.task_type_id IN
                           (SELECT TO_NUMBER (COLUMN_VALUE)
                              FROM TABLE (
                                       LDC_BOUTILITIES.SPLITSTRINGS (
                                           DALD_PARAMETER.fsbGetValue_Chain (
                                               'COD_CANTOEJECUTADA_TASK_TYPE',
                                               NULL),
                                           ',')))
                   AND b.order_status_id = 7
                   AND c.package_id = nusolic
                   AND c.address_id = nudireccion;

        --obtiene la solicitud asociada a la orden de instancia
        CURSOR cusolicitud (nuorden or_order.order_id%TYPE)
        IS
            SELECT b.package_id, p.PACKAGE_TYPE_ID
              FROM or_order_activity b, mo_packages p
             WHERE b.package_id = p.package_id AND b.order_id = nuOrden;

        --obtiene las ordenes de la solicitud
        CURSOR cuordenessolicitud (
            nupackage       mo_packages.package_id%TYPE,
            nutipotrabajo   or_order.task_type_id%TYPE,
            nudireccion     or_order_activity.address_id%TYPE)
        IS
            SELECT oo.order_id     orden,
                   oa.order_activity_id,
                   oo.operating_unit_id
              FROM or_order oo, or_order_activity oa
             WHERE     oa.order_id = oo.order_id
                   AND oo.order_status_id = 5
                   AND oa.package_id = nupackage
                   AND oo.task_type_id IN
                           (SELECT TO_NUMBER (COLUMN_VALUE)
                              FROM TABLE (
                                       ldc_boutilities.splitstrings (
                                           DALD_PARAMETER.fsbGetValue_Chain (
                                               'COD_TT_CER_BLO',
                                               NULL),
                                           ',')))
                   AND oo.task_type_id NOT IN nuTipotrabajo
                   AND oa.address_id = nudireccion;

        CURSOR cuclasecausa (inucausa ge_causal.causal_id%TYPE)
        IS
            SELECT class_causal_id
              FROM ge_causal
             WHERE causal_id = inucausa;

        CURSOR cuPersonaUT (nuUnidad or_order.operating_unit_id%TYPE)
        IS
            SELECT person_id
              FROM or_oper_unit_persons
             WHERE operating_unit_id = nuunidad AND ROWNUM = 1;

        --valida que la orden que llega sea de reparacion
        CURSOR cuobtenerdatosot (nuorden or_order.order_id%TYPE)
        IS
            SELECT a.task_type_id, b.causal_id, a.address_id
              FROM or_order_activity a, or_order b
             WHERE a.order_id = b.order_id AND a.order_id = nuOrden;

        nuordeninstancia                or_order.order_id%TYPE;
        nuTTinstancia                   or_order.task_type_id%TYPE;
        nutipopaquete                   mo_packages.package_type_id%TYPE;
        nusolicitud                     mo_packages.package_id%TYPE;
        nucausalid                      ge_causal.causal_id%TYPE;
        nuclasecausa                    ge_causal.class_causal_id%TYPE;
        nudire                          or_order_activity.address_id%TYPE;
        nuordenleg                      or_order.order_id%TYPE;
        nuUnidOper                      or_order.operating_unit_id%TYPE;
        sbCausalesIncumple              VARCHAR2 (2000);
        sbtipospaquetesVtas             VARCHAR2 (2000);
        nucantcargo                     NUMBER;
        nucantinstala                   NUMBER;
        nucantotnueva                   NUMBER;
        nucantejecuta                   NUMBER;
        nucantincumple                  NUMBER;
        nuerrorcode                     NUMBER;
        nuCantActividad                 NUMBER;
        sberrormessage                  VARCHAR2 (4000);
        sbcomment                       VARCHAR2 (4000);
        sbdataorder                     VARCHAR2 (2000);
        nupersonid                      NUMBER;

        --Inicia Aranda 3445
        --CURSOR PARA IDENTIFICAR LA CANTIDAD DE ORDENES DE
        --12162 INSPECCION Y/O CERTIFICACION INSTALACIONES
        --CREADAS Y LEGALIZADAS
        CURSOR CUCANTIDADOTCERTIFICACION (
            nupackage   mo_packages.package_id%TYPE)
        IS
            SELECT (SELECT COUNT (
                               DAOR_ORDER.FDTGETCREATED_DATE (
                                   OOA.ORDER_ID,
                                   NULL))
                      FROM OR_ORDER_ACTIVITY OOA
                     WHERE     DAOR_ORDER.FNUGETTASK_TYPE_ID (
                                   OOA.ORDER_ID,
                                   NULL) =
                               DALD_PARAMETER.fnuGetNumeric_Value (
                                   'COD_INSP_CERT_TASK_TYPE',
                                   NULL)
                           AND OOA.PACKAGE_ID = nupackage)    CANTIDAD_TOTAL,
                   (SELECT COUNT (
                               DAOR_ORDER.FDTGETCREATED_DATE (
                                   OOA.ORDER_ID,
                                   NULL))
                      FROM OR_ORDER_ACTIVITY OOA
                     WHERE     DAOR_ORDER.FNUGETTASK_TYPE_ID (
                                   OOA.ORDER_ID,
                                   NULL) =
                               DALD_PARAMETER.fnuGetNumeric_Value (
                                   'COD_INSP_CERT_TASK_TYPE',
                                   NULL)
                           AND OOA.PACKAGE_ID = nupackage
                           AND DAOR_ORDER.FNUGETORDER_STATUS_ID (
                                   OOA.ORDER_ID,
                                   NULL) =
                               DALD_PARAMETER.fnuGetNumeric_Value (
                                   'ESTADO_CERRADO',
                                   NULL))                     CANTIDAD_LEGALIZADA
              FROM DUAL;

        TEMPCUCANTIDADOTCERTIFICACION   CUCANTIDADOTCERTIFICACION%ROWTYPE;

        --CURSOR PARA IDENTIFICAR LA CANTIDAD DE ORDENES DE
        --12474 CORRECCIÓN DE DEFECTO EN INSTALACIONES NUEVAS
        --CREADAS Y LEGALIZADAS
        CURSOR CUCANTIDADOTCORRECION (
            nupackage       mo_packages.package_id%TYPE,
            nucudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT (SELECT COUNT (
                               DAOR_ORDER.FDTGETCREATED_DATE (
                                   OOA.ORDER_ID,
                                   NULL))
                      FROM OR_ORDER_ACTIVITY OOA
                     WHERE     DAOR_ORDER.FNUGETTASK_TYPE_ID (
                                   OOA.ORDER_ID,
                                   NULL) =
                               DALD_PARAMETER.fnuGetNumeric_Value (
                                   'COD_CORREC_DEF_INST_TASK_TYPE',
                                   NULL)
                           AND OOA.PACKAGE_ID = nupackage
                           AND OOA.ADDRESS_ID = nucudireccion)
                       CANTIDAD_TOTAL,
                   (SELECT COUNT (
                               DAOR_ORDER.FDTGETCREATED_DATE (
                                   OOA.ORDER_ID,
                                   NULL))
                      FROM OR_ORDER_ACTIVITY OOA
                     WHERE     DAOR_ORDER.FNUGETTASK_TYPE_ID (
                                   OOA.ORDER_ID,
                                   NULL) =
                               DALD_PARAMETER.fnuGetNumeric_Value (
                                   'COD_CORREC_DEF_INST_TASK_TYPE',
                                   NULL)
                           AND OOA.PACKAGE_ID = nupackage
                           AND OOA.ADDRESS_ID = nucudireccion
                           AND DAOR_ORDER.FNUGETORDER_STATUS_ID (
                                   OOA.ORDER_ID,
                                   NULL) =
                               DALD_PARAMETER.fnuGetNumeric_Value (
                                   'ESTADO_CERRADO',
                                   NULL))
                       CANTIDAD_LEGALIZADA
              FROM DUAL;

        TEMPCUCANTIDADOTCORRECION       CUCANTIDADOTCORRECION%ROWTYPE;

        --CURSOR PARA OBTENER LA ULTIMA ORDEN DE 12162 INSPECCION Y/O CERTIFICACION INSTALACIONES
        CURSOR CUULTIMAOTCERTIFICAION (
            nupackage       mo_packages.package_id%TYPE,
            nucudireccion   or_order_activity.address_id%TYPE)
        IS
            SELECT OOA.ORDER_ID,
                   DAOR_ORDER.FNUGETCAUSAL_ID (OOA.ORDER_ID, NULL)    CAUSAL_LEGALIZACION
              FROM OR_ORDER_ACTIVITY OOA
             WHERE     DAOR_ORDER.FNUGETTASK_TYPE_ID (OOA.ORDER_ID,
                                                           NULL) IN
                           (SELECT TO_NUMBER (COLUMN_VALUE)
                              FROM TABLE (
                                       ldc_boutilities.splitstrings (
                                           DALD_PARAMETER.fsbGetValue_Chain (
                                               'COD_INSP_CERT_TASK_TYPE_2',
                                               NULL),
                                           ',')))
                   AND OOA.PACKAGE_ID = nupackage
                   AND OOA.ADDRESS_ID = nucudireccion
                   AND DAOR_ORDER.FDTGETCREATED_DATE (OOA.ORDER_ID,
                                                           NULL) IN
                           (SELECT MAX (
                                       DAOR_ORDER.FDTGETCREATED_DATE (
                                           OOA2.ORDER_ID,
                                           NULL))
                              FROM OR_ORDER_ACTIVITY OOA2
                             WHERE     DAOR_ORDER.FNUGETTASK_TYPE_ID (
                                           OOA2.ORDER_ID,
                                           NULL) IN
                                           (SELECT TO_NUMBER (COLUMN_VALUE)
                                              FROM TABLE (
                                                       ldc_boutilities.splitstrings (
                                                           DALD_PARAMETER.fsbGetValue_Chain (
                                                               'COD_INSP_CERT_TASK_TYPE_2',
                                                               NULL),
                                                           ',')))
                                   AND OOA2.PACKAGE_ID = nupackage
                                   AND OOA2.ADDRESS_ID = nucudireccion) 
    ;

        TEMPCUULTIMAOTCERTIFICAION      CUULTIMAOTCERTIFICAION%ROWTYPE;

        --CURSOR PARA OBTENER LA ULTIMA ORDEN DE 12474 CORRECCIÓN DE DEFECTO EN INSTALACIONES NUEVAS
        CURSOR CUULTIMAOTCORRECCION (nupackage mo_packages.package_id%TYPE)
        IS
            SELECT OOA.ORDER_ID,
                   DAOR_ORDER.FNUGETCAUSAL_ID (OOA.ORDER_ID, NULL)    CAUSAL_LEGALIZACION
              FROM OR_ORDER_ACTIVITY OOA
             WHERE     DAOR_ORDER.FNUGETTASK_TYPE_ID (OOA.ORDER_ID,
                                                           NULL) =
                       DALD_PARAMETER.fnuGetNumeric_Value (
                           'COD_INSP_CERT_TASK_TYPE',
                           NULL)
                   AND OOA.PACKAGE_ID = nupackage
                   AND DAOR_ORDER.FDTGETLEGALIZATION_DATE (OOA.ORDER_ID,
                                                                NULL) IN
                           (SELECT MAX (
                                       DAOR_ORDER.FDTGETLEGALIZATION_DATE (
                                           OOA.ORDER_ID,
                                           NULL))
                              FROM OR_ORDER_ACTIVITY OOA
                             WHERE     DAOR_ORDER.FNUGETTASK_TYPE_ID (
                                           OOA.ORDER_ID,
                                           NULL) =
                                       DALD_PARAMETER.fnuGetNumeric_Value (
                                           'COD_INSP_CERT_TASK_TYPE',
                                           NULL)
                                   AND OOA.PACKAGE_ID = nupackage);

        TEMPCUULTIMAOTCORRECCION        CUULTIMAOTCORRECCION%ROWTYPE;
        SBCAUSALESVALIDAS               VARCHAR2 (2000);

        --Fin Aranda 3445
        CURSOR CUEXISTE (NUCAUSAL OR_ORDER.CAUSAL_ID%TYPE)
        IS
            SELECT COUNT (1)     cantidad
              FROM DUAL
             WHERE NUCAUSAL IN
                       (SELECT TO_NUMBER (COLUMN_VALUE)
                          FROM TABLE (
                                   ldc_boutilities.splitstrings (
                                       dald_parameter.fsbgetvalue_chain (
                                           'COD_CAUSAL_VALIDA',
                                           NULL),
                                       ',')));

        NUCANTIDAD                      NUMBER;
    --NC4325 Variables
    --nudireccion number;
    --FIN NC4325
    BEGIN
        pkg_Traza.Trace ('Inicio proincumplenuevas', 10);
        --orden de la instancia
        nuordeninstancia := or_bolegalizeorder.fnugetcurrentorder;

        --NC497 obtiene datos de la orden de la instancia
        OPEN cuobtenerdatosot (nuordeninstancia);

        FETCH cuobtenerdatosot INTO nuTTinstancia, nucausalid, nudire;

        CLOSE cuobtenerdatosot;

        --obtiene la solicitud asociada a la orden de reparacion
        OPEN cuSolicitud (nuordeninstancia);

        FETCH cusolicitud INTO nusolicitud, nutipoPaquete;

        CLOSE cuSolicitud;

        --valida que haya solicitud asociada a la orden
        IF (nutipopaquete IS NOT NULL)
        THEN
            sbtipospaquetesVtas :=
                dald_parameter.fsbgetvalue_chain ('TIPOS_PAQUETES_VENTAS');

            --valida el tipo de paquete
            IF (ldc_boutilities.fsbbuscatoken (sbtipospaquetesVtas,
                                               TO_CHAR (nutipopaquete),
                                               ',') =
                'S')
            THEN
                --INICIO ARANDA 3445
                --CURSOR PARA OBTENER LA UTLIMA ORDEN 12162 EN LA SOLICITUD
                SBCAUSALESVALIDAS :=
                    dald_parameter.fsbgetvalue_chain ('COD_CAUSAL_VALIDA',
                                                      NULL);

                --OBTENER LA ULTIMA ORDEN DE CERTIFICACION 12162
                OPEN CUULTIMAOTCERTIFICAION (nusolicitud, nudire);

                FETCH CUULTIMAOTCERTIFICAION INTO TEMPCUULTIMAOTCERTIFICAION;

                IF CUULTIMAOTCERTIFICAION%FOUND
                THEN
                    --VALIDAR SI LA CAUSAL DE LA ORDEN 12162 ES UNA CAUSAL VALIDA DE LEGALIZACION
                    IF NVL (TEMPCUULTIMAOTCERTIFICAION.CAUSAL_LEGALIZACION,
                            0) >
                       0
                    THEN
                        IF (ldc_boutilities.fsbbuscatoken (
                                SBCAUSALESVALIDAS,
                                TO_CHAR (
                                    TEMPCUULTIMAOTCERTIFICAION.CAUSAL_LEGALIZACION),
                                ',') =
                            'N')
                        THEN
                            OPEN CUCANTIDADOTCORRECION (nusolicitud, nudire);

                            FETCH CUCANTIDADOTCORRECION
                                INTO TEMPCUCANTIDADOTCORRECION;

                            IF TEMPCUCANTIDADOTCORRECION.CANTIDAD_TOTAL <>
                               TEMPCUCANTIDADOTCORRECION.CANTIDAD_LEGALIZADA
                            THEN
                                --/*
                                ge_boerrors.seterrorcodeargument (
                                    ld_boconstans.cnugeneric_error,
                                    'Existen ordenes de correcci??n de defecto sin legalizar.');
                                RAISE pkg_Error.CONTROLLED_ERROR;
                            --*/
                            END IF;

                            CLOSE CUCANTIDADOTCORRECION;
                        END IF;

                        --VALIDAR SI LA CAUSAL DE LA ULTIMA ORDEN 12162 ES UNA CAUSAL VALIDA DE LEGALIZACION
                        --OPEN CUEXISTE(TEMPCUULTIMAOTCERTIFICAION.CAUSAL_LEGALIZACION);
                        --FETCH  CUEXISTE INTO NUCANTIDAD;
                        --CLOSE CUEXISTE;
                        IF (ldc_boutilities.fsbbuscatoken (
                                SBCAUSALESVALIDAS,
                                TO_CHAR (
                                    TEMPCUULTIMAOTCERTIFICAION.CAUSAL_LEGALIZACION),
                                ',') =
                            'N')
                        THEN
                            --IF NUCANTIDAD = 1 THEN
                            --/*
                            ge_boerrors.seterrorcodeargument (
                                ld_boconstans.cnugeneric_error,
                                'La ultima orden de inspeccion y/o certificacion instalaciones legalizada no tiene causal valida.');
                            RAISE pkg_Error.CONTROLLED_ERROR;
                        --*/
                        END IF;
                    END IF;
                END IF;

                CLOSE CUULTIMAOTCERTIFICAION;

                --obtiene las causales de incumplimiento para nuevas
                sbcausalesincumple :=
                    dald_parameter.fsbgetvalue_chain (
                        'CAUSAL_INCUMPLE_NUEVAS');

                OPEN cucantotcargo (nuSolicitud, nudire);

                FETCH cucantotcargo INTO nucantCargo;

                CLOSE cucantotcargo;

                OPEN cucantotinstala (nuSolicitud, nudire);

                FETCH cucantotinstala INTO nucantinstala;

                CLOSE cucantotinstala;

                nucantotnueva := nucantcargo + nucantinstala;

                IF (nucantotnueva > 0)
                THEN
                    OPEN cuCantOTEjecutadas (nuSolicitud, nudire);

                    FETCH cucantotejecutadas INTO nucantejecuta;

                    CLOSE cucantotejecutadas;

                    IF (nucausalid > 0)
                    THEN
                        --valida si hay cambio de estado o incumplimiento
                        --Si hay una ejecutada y la que llega es incumplida, desplegar mensaje
                        IF (nucantejecuta > 0)
                        THEN
                            --valida si es una causal de incumplimiento
                            IF (ldc_boutilities.fsbbuscatoken (
                                    sbcausalesincumple,
                                    TO_CHAR (nucausalid),
                                    ',') =
                                'S')
                            THEN
                                --retorna mensaje para que valie e impide continuar
                                ge_boerrors.seterrorcodeargument (
                                    ld_boconstans.cnugeneric_error,
                                    'La causal usada no es valida, ya que existe una orden ejecutada para la misma solicitud');
                                RAISE pkg_Error.CONTROLLED_ERROR;
                            END IF;
                        --no tuvo cambio de estado
                        ELSIF (nucantejecuta = 0)
                        THEN
                            IF (ldc_boutilities.fsbbuscatoken (
                                    sbcausalesincumple,
                                    TO_CHAR (nucausalid),
                                    ',') =
                                'S')
                            THEN
                                --obtener todas las ordenes de la solicitud y cerrar con la misma causal
                                FOR rcordenessolicitud
                                    IN cuordenessolicitud (nusolicitud,
                                                           nuttinstancia,
                                                           nudire)
                                LOOP

                                    --obtiene el id de la persona asociada a la unidad operativa de la orden q se va a legalizar
                                    nuordenleg := rcordenessolicitud.orden;
                                    nuUnidOper :=
                                        rcordenessolicitud.operating_unit_id;

                                    OPEN cuPersonaUT (nuUnidOper);

                                    FETCH cuPersonaUT INTO nupersonid;

                                    CLOSE cupersonaut;

                                    DBMS_OUTPUT.put_line (
                                        'nupersonid --> ' || nupersonid);

                                    --nuCantActividad: evalua la clase de la causa 0 si es fallo, 1 si es exito
                                    OPEN cuClaseCausa (nuCausalId);

                                    FETCH cuclasecausa INTO nuClaseCausa;

                                    CLOSE cuClaseCausa;

                                    IF nuClaseCausa = 1
                                    THEN
                                        nuCantActividad := 1;
                                    ELSE
                                        nucantactividad := 0;
                                    END IF;

                                    ldc_closeOrder (nuordenleg,
                                                    nuCausalId,
                                                    nupersonid,
                                                    nuUnidOper);
                                    pkg_Traza.Trace (
                                           'proincumplenuevas - Legalizando orden --> '
                                        || nuordenleg,
                                        10);
                                END LOOP;
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;                                --valida el tipo de paquete
        END IF;                             --valida q haya solicitud asociada

        pkg_Traza.Trace ('Fin proincumplenuevas', 10);
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE;
        WHEN OTHERS
        THEN
            ge_boerrors.seterrorcodeargument (
                Ld_Boconstans.cnuGeneric_Error,
                'Error al ejecutar proceso proincumplenuevas');
            RAISE;
    END proincumplenuevas;

    /*****************************************************************
      Unidad       : fsbGetPHONES
      Descripcion     : concatena los telefonos del subscriber almacenados en la tabla ge_subs_phone

      Parametros          Descripcion
      ============        ===================
      inuSubscriberId     id del subscriber

      Autor: Emiro leyva Hernandez
      Fecha: agosto 01/2013
    ******************************************************************/
    FUNCTION fsbGetPHONES (inuSubscriberId ge_subscriber.subscriber_id%TYPE)
        RETURN VARCHAR2
    IS
        CURSOR cuPhones (inuSubscriberId ge_subscriber.subscriber_id%TYPE)
        IS
            SELECT GE_SUBS_PHONE.phone     PHONE
              FROM GE_SUBS_PHONE
             WHERE SUBSCRIBER_ID = inuSubscriberId;

        sbPhones   VARCHAR2 (30000);
    BEGIN
        sbPhones := NULL;

        FOR rgPhones IN cuPhones (inuSubscriberId)
        LOOP
            sbPhones := sbPhones || rgPhones.PHONE || ' - ';
        END LOOP;

        sbPhones := SUBSTR (sbPhones, 1, (LENGTH (sbPhones) - 2));
        DBMS_OUTPUT.put_line (sbPhones);
        RETURN sbPhones;
    END fsbGetPHONES;

    /*****************************************************************
      Unidad       : fsbActividadVtas
      Descripcion   : Obtiene la actividad generada en la orden de acuerdo a los tipos de trabajos 12387 y 10167 para posteriormente validar si existe esta
                    actividad configurada en ld_parameter, si existe generara orden de acuerdo a la actividad configurada en Tareas por modulo equivalentes
      Parametros          Descripcion
      ============        ===================
      nuMotiveId         Codigo del motivo generado en el tramitre de venta de constructora
      nuPackageId        solicitud gen
      sbatributo          nombre de atributo

       Autor: Alvaro Zapata
      Fecha: Septiembre 04/2013
    ******************************************************************/
    FUNCTION fsbActividadVtas (nuMotiveId    mo_motive.motive_id%TYPE,
                               nuPackageId   mo_packages.package_id%TYPE)
        RETURN NUMBER
    IS
        nuActividad   NUMBER;
    BEGIN
        SELECT ACTIVITY_ID
          INTO nuActividad
          FROM OR_ORDER_ACTIVITY
         WHERE     MOTIVE_ID = nuMotiveId
               AND PACKAGE_ID = nuPackageId
               AND LDC_BOUTILITIES.fsbBuscaToken (
                       dald_Parameter.fsbGetValue_Chain (
                           'ACTIVIDADES_VENTAS_CONSTR'),
                       ACTIVITY_ID,
                       ',') =
                   'S';

        IF (nuActividad IS NOT NULL)
        THEN
            RETURN 1;
        -- dbms_output.put_line('ACTIVIDAD '||nuActividad);
        ELSE
            RETURN 2;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            DBMS_OUTPUT.put_line ('La Consulta no arrojo Datos ' || SQLERRM);
            ---Retorna -1 cuando exista un error al ejecutar la funcion
            RETURN -1;
    END fsbActividadVtas;

    FUNCTION fnuaplicadatoadicionalnuevas (inuorden or_order.order_id%TYPE)
        /*****************************************************************
           Unidad       : fnuaplicadatoadicionalnuevas
           Descripcion  : Retorna un valor indicando si la solicitud de ventas contiene solo CxC o solo Instalacion  o
                          contiene las dos ordenes
                          Si retorna 1 es porque contiene las dos ordenes
                          Si retorna 2 es proque contiene la orden de instalacion
                          Si retorna 3 es porque contiene la orden de cargo

          Parametros          Descripcion
           ============        ===================
           inuorden            Orden de certificacion que se encuentra en la instancia

          Autor: Luz Andrea Angel M./OLSoftware
           Fecha: Septiembre 18/2013

          Fecha                Autor           Modificacion
           ============    ================    ============================================
           25/10/2013        NC_1364_1           Se agrega la condicion de address_id para
                                                 aquellas solicitudes de constructora que poseen
                                                 varias OT del mismo TT  pero diferente direccion
           25/11/2014       Jorge Valiente     NC 3430: ESTABLECER QUE TENGA LSO TIPO DE TRABAJO
                                                        VALIDOS PARA INICIALIZZAR VALORES
                                                        PREDETERMINADOS EN AL LISTA DE VALORES DEL
                                                        CERTIIFCADOR.
                                                        MODIFICACION DEL CURSOR cuordenes PARA QUE
                                                        AGRUPE LOS TIPOS DE TRABAJO YA QUE CON LA ORDEN
                                                        EL NO REALIZA NINGUN PORCESO DENTRO DEL SERVICIO
                                                        ADEMAS LA ORDEN NO PERMITE QUE LA LOGICA DE VALIDAR
                                                        LOS TIPOS DE TRABAJO SE REALICE DE FORMA ADECUADA
           06/02/2014        Oparra.Team2003     Se modifica cursor "cuordenes" para que consulte los
                                                 tipos de solicitud por parametro 'TIPOS_PAQUETES_VENTAS'
         ******************************************************************/
        RETURN NUMBER
    IS
        CURSOR cusolicitud (nuorden or_order.order_id%TYPE)
        IS
            SELECT b.package_id, B.ADDRESS_ID
              FROM or_order           a,
                   or_order_activity  b,
                   mo_packages        mp,
                   ps_package_type    ppt
             WHERE     a.order_id = b.order_id
                   AND b.package_id = mp.package_id
                   AND mp.package_type_id = ppt.package_type_id
                   AND mp.package_type_id IN
                           (SELECT TO_NUMBER (COLUMN_VALUE)
                              FROM TABLE (
                                       LDC_BOUTILITIES.SPLITSTRINGS (
                                           DALD_PARAMETER.fsbGetValue_Chain (
                                               'TIPOS_PAQUETES_VENTAS',
                                               NULL),
                                           ',')))
                   AND a.order_id = nuorden;

        CURSOR cuordenes (nusolicitud   or_order_activity.package_id%TYPE,
                          nuaddress     or_order_activity.address_id%TYPE)
        IS
              SELECT b.task_type_id     tipotrab
                FROM or_order         a,
                     or_order_activity b,
                     mo_packages      mp,
                     ps_package_type  ppt
               WHERE     a.order_id = b.order_id
                     AND b.package_id = mp.package_id
                     AND mp.package_type_id = ppt.package_type_id
                     AND mp.package_type_id IN
                             (SELECT TO_NUMBER (COLUMN_VALUE)
                                FROM TABLE (
                                         LDC_BOUTILITIES.SPLITSTRINGS (
                                             DALD_PARAMETER.fsbGetValue_Chain (
                                                 'TIPOS_PAQUETES_VENTAS',
                                                 NULL),
                                             ',')))
                     AND b.task_type_id IN (12149,
                                            12151,
                                            12150,
                                            12152)
                     AND a.order_status_id <> 12
                     AND b.package_id = nusolicitud
                     AND B.ADDRESS_ID = nuaddress
            GROUP BY b.task_type_id;

        nusolicitudot   or_order_activity.package_id%TYPE;
        nuaddressid     or_order_activity.address_id%TYPE;
        nutipotrab      or_order_activity.task_type_id%TYPE;
        nuordensol      or_order.order_id%TYPE;
        nuaplica        NUMBER := -1;
        nucuenta        NUMBER;
    BEGIN
        DBMS_OUTPUT.put_line ('inuorden-->' || inuorden);

        OPEN cusolicitud (inuorden);

        FETCH cusolicitud INTO nuSolicitudOT, nuaddressid;

        CLOSE cusolicitud;

        DBMS_OUTPUT.put_line ('nuSolicitudOT-->' || nuSolicitudOT);
        nucuenta := 0;

        FOR rtordenes IN cuordenes (nuSolicitudOT, nuaddressid)
        LOOP
            nutipotrab := rtordenes.tipotrab;
            DBMS_OUTPUT.put_line ('nutipotrab-->' || nutipotrab);
            nucuenta := nucuenta + 1;
        END LOOP;

        DBMS_OUTPUT.put_line ('nucuenta-->' || nucuenta);

        IF (nucuenta = 2)
        THEN
            nuaplica := 1;                                     --ambas ordenes
        ELSIF (nucuenta = 1)
        THEN
            IF (nutipotrab IN (12149, 12151))
            THEN
                nuaplica := 2;                                   --instalacion
            ELSIF (nutipotrab IN (12150, 12152))
            THEN
                nuaplica := 3;                                         --cargo
            END IF;
        END IF;

        RETURN nuaplica;
    END fnuaplicadatoadicionalNuevas;

    /*****************************************************************
    Propiedad intelectual de Gases de Occidente.

    Unidad         : fnuDevuelveEstadoProducto
    Descripcion    : Devuelte el etado del producto
    Autor          : Alvaro Zapata
    Fecha          : 23/09/2013 NC 324

    Parametros         Descripcion
    ============   ===================
    inuProductId:      Codigo del producto de la instancia

    Historia de Modificaciones
    Fecha            Autor       Modificacion
    =========      =========  ====================
    ******************************************************************/
    FUNCTION fnuDevuelveEstadoProducto (
        inuProductId   IN pr_product.product_id%TYPE)
        RETURN NUMBER
    IS
        nuProductId   NUMBER;
    BEGIN
        pkg_Traza.Trace (
            'INICIO LDC_BOORDENES.fnuDevuelveEstadoProducto ' || inuProductId,
            10);

        SELECT product_status_id
          INTO nuProductId
          FROM Pr_Product
         WHERE product_type_id = 7014 AND PRODUCT_ID = inuProductId;

        pkg_Traza.Trace (
            'FIN LDC_BOORDENES.fnuDevuelveEstadoProducto ' || nuProductId,
            10);
        RETURN nuProductId;
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;
    END fnuDevuelveEstadoProducto;

    PROCEDURE provalidatadiccertnuevas
    IS
        /*****************************************
             Metodo: provalidatadiccertnuevas
             Descripcion:Restringe el uso de la causal "Legaliza sin inspeccion por culpa del cliente" a los contratistas. Si el contratista usa
                         esa causal, entonces mostrara mensaje e impide continuar.
                         Se encarga de validar los datos adicionales de la orden de certificacion de nuevas para que
                         muestre un mensaje cuando se ingresen datos adicionales de una orden que no existe
             Autor: Luz Andrea Angel/OLSoftware
             Fecha: Septiembre 23/2013

            Fecha                IDEntrega           Modificacion
             ============    ================    ============================================

        25/05/2016       OSS_CONEX_SMOR_200347_1  despu??s de las validaciones que realiza actualmente,
                                                    si la variable nuaplica tiene el valor  1 es decir si
                                la solicitud tiene tanto la orden de conexi??n como la de
                                instalaci??n de interna  o 3 es decir solo tiene la orden
                                de cargo x conexi??n, valide que el serial del medidor
                                ingresado en el dato adicional 5000151-Serie Medidor,
                                tenga la misma unidad operativa que la que  de la  12150,
                                12152, 12153 en estado 5 o 7 de la misma solicitud y producto,
                                y si no es igual arroje mensaje de error.
           ******************************************/
        CURSOR cuatributosgrupo (nugrupo NUMBER)
        IS
            SELECT a.attribute_id idAtributo, b.name_attribute nombreatrib
              FROM ge_attrib_set_attrib a, ge_attributes b
             WHERE     a.attribute_id = b.attribute_id
                   AND a.attribute_set_id = nugrupo;

        --valida que la persona conectada es contratista
        CURSOR cupersonacontratista (nupersona ge_person.person_id%TYPE)
        IS
            SELECT 'Y'
              FROM or_oper_unit_persons a, or_operating_unit b
             WHERE     a.operating_unit_id = b.operating_unit_id
                   AND b.oper_unit_classif_id = 2                --Contratista
                   AND a.person_id = nupersona;

        --obtiene la causal de la orden que se esta legalizando
        CURSOR cucausalotinstancia (nuorden or_order.order_id%TYPE)
        IS
            SELECT causal_id
              FROM or_order
             WHERE order_id = nuorden;

        --obtiene la unidad operativa de la orden a de cargo x conexion de la misma
        --solicitud y el mismo producto de la orden de insp. y/o inst. de instalaciones
        CURSOR cuGetCxCOperatingUnit (
            inuInspCertOrderId   or_order.order_id%TYPE)
        IS
            WITH
                paqprod_info
                AS
                    (SELECT DISTINCT
                            or_order_activity.package_id,
                            or_order_activity.product_id
                       FROM or_order_activity
                      WHERE or_order_activity.order_id = inuInspCertOrderId)
            SELECT *
              FROM (  SELECT o.operating_unit_id
                        FROM or_order o, or_order_activity oa, paqprod_info
                       WHERE     o.order_id = oa.order_id
                             AND o.task_type_id IN (12150, 12152, 12153)
                             AND o.order_status_id IN (5, 7)
                             AND oa.package_id = paqprod_info.package_id
                             AND oa.product_id = paqprod_info.product_id
                    ORDER BY o.created_date DESC)
             WHERE ROWNUM = 1;

        CURSOR cuGetSerialledItemOperUnit (
            isbSeries   ge_items_seriado.serie%TYPE)
        IS
            SELECT operating_unit_id
              FROM ge_items_seriado
             WHERE serie = isbSeries;

        CURSOR cuSplitStringData (isbString VARCHAR2)
        IS
            SELECT COLUMN_VALUE
              FROM TABLE (ldc_boutilities.SPLITstrings (isbString, ','));

        CURSOR cuGetAdditionalItemData (
            inuAttributeSetId   or_requ_data_value.attribute_set_id%TYPE,
            inuOrderId          or_requ_data_value.order_id%TYPE)
        IS
            SELECT name_1      item_name,
                   value_1     item_value,
                   name_2      value_name,
                   value_2     value_value
              FROM or_requ_data_value
             WHERE     order_id = inuOrderId
                   AND attribute_set_id = inuAttributeSetId
            UNION
            SELECT name_3      item_name,
                   value_3     item_value,
                   name_4      value_name,
                   value_4     value_value
              FROM or_requ_data_value
             WHERE     order_id = inuOrderId
                   AND attribute_set_id = inuAttributeSetId
            UNION
            SELECT name_5      item_name,
                   value_5     item_value,
                   name_6      value_name,
                   value_6     value_value
              FROM or_requ_data_value
             WHERE     order_id = inuOrderId
                   AND attribute_set_id = inuAttributeSetId
            UNION
            SELECT name_7      item_name,
                   value_7     item_value,
                   name_8      value_name,
                   value_8     value_value
              FROM or_requ_data_value
             WHERE     order_id = inuOrderId
                   AND attribute_set_id = inuAttributeSetId
            UNION
            SELECT name_9       item_name,
                   value_9      item_value,
                   name_10      value_name,
                   value_10     value_value
              FROM or_requ_data_value
             WHERE     order_id = inuOrderId
                   AND attribute_set_id = inuAttributeSetId
            UNION
            SELECT name_11      item_name,
                   value_11     item_value,
                   name_12      value_name,
                   value_12     value_value
              FROM or_requ_data_value
             WHERE     order_id = inuOrderId
                   AND attribute_set_id = inuAttributeSetId
            UNION
            SELECT name_13      item_name,
                   value_13     item_value,
                   name_14      value_name,
                   value_14     value_value
              FROM or_requ_data_value
             WHERE     order_id = inuOrderId
                   AND attribute_set_id = inuAttributeSetId
            UNION
            SELECT name_15      item_name,
                   value_15     item_value,
                   name_16      value_name,
                   value_16     value_value
              FROM or_requ_data_value
             WHERE     order_id = inuOrderId
                   AND attribute_set_id = inuAttributeSetId
            UNION
            SELECT name_17      item_name,
                   value_17     item_value,
                   name_18      value_name,
                   value_18     value_value
              FROM or_requ_data_value
             WHERE     order_id = inuOrderId
                   AND attribute_set_id = inuAttributeSetId
            UNION
            SELECT name_19      item_name,
                   value_19     item_value,
                   name_20      value_name,
                   value_20     value_value
              FROM or_requ_data_value
             WHERE     order_id = inuOrderId
                   AND attribute_set_id = inuAttributeSetId;

        nuotinstancia        or_order.order_id%TYPE;
        nuidatributo         ge_attrib_set_attrib.attribute_id%TYPE;
        sbnombreatrib        ge_attributes.name_attribute%TYPE;
        nuidpersona          ge_person.person_id%TYPE;
        nuCausal             or_order.causal_id%TYPE;
        sbInstCentroMed      VARCHAR2 (500);
        sbPresionEstatica    VARCHAR2 (500);
        sbPresionDinamica    VARCHAR2 (500);
        sbLongAcometida      VARCHAR2 (500);
        sbTipoCentroMed      VARCHAR2 (500);
        sbDiamAcometida      VARCHAR2 (500);
        sbSerieMedidor       VARCHAR2 (500);
        sbPtosConstInst      VARCHAR2 (500);
        sbLongInstInterna    VARCHAR2 (500);
        sbMaterialInterna    VARCHAR2 (500);
        sbPtosConectados     VARCHAR2 (500);
        sbPtosAdicionales    VARCHAR2 (500);
        sbPtosOpcionales     VARCHAR2 (500);
        sbUbicaInstInterna   VARCHAR2 (500);
        sbmensaje            VARCHAR2 (2000);
        sbcontratista        VARCHAR2 (2);
        nuaplica             NUMBER;
        nugrupodatos         NUMBER;
        nutipotrab           NUMBER := 12162;
        nuCxCOperatingUnit   or_order.operating_unit_id%TYPE;
        nuMeterOperaUnit     ge_items_seriado.operating_unit_id%TYPE;
        EX_ERROR             EXCEPTION;
    BEGIN
        pkg_Traza.Trace ('Inicia provaliddatadiccertifnuevas', 10);
        --1.obtener la ot de la instancia
        nuotinstancia := or_bolegalizeorder.fnugetcurrentorder;
        pkg_Traza.Trace ('nuotinstancia-->' || nuotinstancia, 10);
        --validar que si es la causal 9091 y es el certificador NO dejar legalizar
        --1.persona conetctada
        nuidpersona := ge_bopersonal.fnugetpersonid;
        --nuidpersona := 2737;
        pkg_Traza.Trace ('nuidpersona-->' || nuidpersona, 10);

        --2.obtener unidad operativa
        OPEN cupersonacontratista (nuIdPersona);

        FETCH cupersonacontratista INTO sbContratista;

        CLOSE cupersonacontratista;

        pkg_Traza.Trace ('sbContratista-->' || sbContratista, 10);

        OPEN cucausalotinstancia (nuIdPersona);

        FETCH cucausalotinstancia INTO nuCausal;

        CLOSE cucausalotinstancia;

        pkg_Traza.Trace ('nuCausal-->' || nuCausal, 10);

        IF (    sbcontratista = 'Y'
            AND (    nucausal > 0
                 AND nucausal =
                     dald_parameter.fnugetnumeric_value (
                         'COD_CAUSAL_LEG_SIN_INSP_CLIE',
                         NULL)))
        THEN
            sbmensaje :=
                'Causal no es permitida para legalizar por el contratista';
            RAISE ex_error;
        END IF;

        IF (nuotinstancia IS NOT NULL)
        THEN
            --2.validar las ordenes CxC y/o Instalacion asociadas
            nuaplica :=
                ldc_boordenes.fnuaplicadatoadicionalnuevas (nuotinstancia);
            pkg_Traza.Trace ('nuaplica-->' || nuaplica, 10);
            --3.obtener el grupo de atributos de la orden instancia
            nugrupodatos := 11215;

            --4.obtener los atributos de acuerdo a la orden
            FOR rtatributosgrupo IN cuatributosgrupo (nugrupodatos)
            LOOP
                nuidatributo := rtatributosgrupo.idatributo;
                sbnombreatrib := rtatributosgrupo.nombreatrib;

                --atributos de cargo
                --solo instalacion
                IF (nuaplica = 1)
                THEN
                    --5000151 - SERIE_MEDIDOR
                    IF (nuidatributo = 5000151)
                    THEN
                        pkg_Traza.Trace (
                            'SERIE_MEDIDOR-nuidatributo-->' || nuidatributo,
                            10);
                        sbSerieMedidor :=
                            ldc_boordenes.fsbdatoadictmporden (
                                nuotinstancia,
                                nuidatributo,
                                'SERIE_MEDIDOR');
                        pkg_Traza.Trace (
                               'SERIE_MEDIDOR-sbSerieMedidor-->'
                            || sbSerieMedidor,
                            10);
                    END IF;
                ELSIF (nuaplica = 2)
                THEN
                    IF (nuidatributo IN (5012004,
                                         5012023,
                                         5012024,
                                         5012002,
                                         5012003,
                                         5012001,
                                         5000151))
                    THEN
                        --5012004 - INST_CENTRO_MEDICION
                        IF (nuidatributo = 5012004)
                        THEN
                            pkg_Traza.Trace (
                                   'INST_CENTRO_MEDICION-nuidatributo-->'
                                || nuidatributo,
                                10);
                            sbInstCentroMed :=
                                ldc_boordenes.fsbdatoadictmporden (
                                    nuotinstancia,
                                    nuidatributo,
                                    'INST_CENTRO_MEDICION');
                            pkg_Traza.Trace (
                                   'INST_CENTRO_MEDICION-sbInstCentroMed-->'
                                || sbInstCentroMed,
                                10);
                        END IF;

                        --5012023 - PRESION_ESTATICA
                        IF (nuidatributo = 5012023)
                        THEN
                            pkg_Traza.Trace (
                                   'PRESION_ESTATICA-nuidatributo-->'
                                || nuidatributo,
                                10);
                            sbPresionEstatica :=
                                ldc_boordenes.fsbdatoadictmporden (
                                    nuotinstancia,
                                    nuidatributo,
                                    'PRESION_ESTATICA');
                            pkg_Traza.Trace (
                                   'PRESION_ESTATICA-sbPresionEstatica-->'
                                || sbPresionEstatica,
                                10);
                        END IF;

                        --5012024 - PRESION_DINAMICA
                        IF (nuidatributo = 5012024)
                        THEN
                            pkg_Traza.Trace (
                                   'PRESION_DINAMICA-nuidatributo-->'
                                || nuidatributo,
                                10);
                            sbPresionDinamica :=
                                ldc_boordenes.fsbdatoadictmporden (
                                    nuotinstancia,
                                    nuidatributo,
                                    'PRESION_DINAMICA');
                            pkg_Traza.Trace (
                                   'PRESION_DINAMICA-sbPresionDinamica-->'
                                || sbPresionDinamica,
                                10);
                        END IF;

                        --5012002 - LONG_ACOMETIDA
                        IF (nuidatributo = 5012002)
                        THEN
                            pkg_Traza.Trace (
                                   'LONG_ACOMETIDA-nuidatributo-->'
                                || nuidatributo,
                                10);
                            sbLongAcometida :=
                                ldc_boordenes.fsbdatoadictmporden (
                                    nuotinstancia,
                                    nuidatributo,
                                    'LONG_ACOMETIDA');
                            pkg_Traza.Trace (
                                   'LONG_ACOMETIDA-sbLongAcometida-->'
                                || sbLongAcometida,
                                10);
                        END IF;

                        --5012003 - TIPO_CENTRO_MEDICION
                        IF (nuidatributo = 5012003)
                        THEN
                            pkg_Traza.Trace (
                                   'TIPO_CENTRO_MEDICION-nuidatributo-->'
                                || nuidatributo,
                                10);
                            sbTipoCentroMed :=
                                ldc_boordenes.fsbdatoadictmporden (
                                    nuotinstancia,
                                    nuidatributo,
                                    'TIPO_CENTRO_MEDICION');
                            pkg_Traza.Trace (
                                   'TIPO_CENTRO_MEDICION-sbTipoCentroMed-->'
                                || sbTipoCentroMed,
                                10);
                        END IF;

                        --5012001 - DIAM_ACOMETIDA
                        IF (nuidatributo = 5012001)
                        THEN
                            pkg_Traza.Trace (
                                   'DIAM_ACOMETIDA-nuidatributo-->'
                                || nuidatributo,
                                10);
                            sbDiamAcometida :=
                                ldc_boordenes.fsbdatoadictmporden (
                                    nuotinstancia,
                                    nuidatributo,
                                    'DIAM_ACOMETIDA');
                            pkg_Traza.Trace (
                                   'DIAM_ACOMETIDA-sbDiamAcometida-->'
                                || sbDiamAcometida,
                                10);
                        END IF;

                        --5000151 - SERIE_MEDIDOR
                        IF (nuidatributo = 5000151)
                        THEN
                            pkg_Traza.Trace (
                                   'SERIE_MEDIDOR-nuidatributo-->'
                                || nuidatributo,
                                10);
                            sbSerieMedidor :=
                                ldc_boordenes.fsbdatoadictmporden (
                                    nuotinstancia,
                                    nuidatributo,
                                    'SERIE_MEDIDOR');
                            pkg_Traza.Trace (
                                   'SERIE_MEDIDOR-sbSerieMedidor-->'
                                || sbSerieMedidor,
                                10);
                        END IF;
                    END IF;
                --solo cargo
                ELSIF (nuaplica = 3)
                THEN
                    --atributos de instalacion
                    IF (nuidatributo IN (5012008,
                                         5012007,
                                         5012005,
                                         5012013,
                                         5012006,
                                         5000149,
                                         5000150,
                                         5000151))
                    THEN
                        --5012008 - PUNTOS_CONST_INST
                        IF (nuidatributo = 5012008)
                        THEN
                            pkg_Traza.Trace (
                                   'PUNTOS_CONST_INST-nuidatributo-->'
                                || nuidatributo,
                                10);
                            sbPtosConstInst :=
                                ldc_boordenes.fsbdatoadictmporden (
                                    nuotinstancia,
                                    nuidatributo,
                                    'PUNTOS_CONST_INST');
                            pkg_Traza.Trace (
                                   'PUNTOS_CONST_INST-sbPtosConstInst-->'
                                || sbPtosConstInst,
                                10);
                        END IF;

                        --5012007 - LONG_INST_INTERNA
                        IF (nuidatributo = 5012007)
                        THEN
                            pkg_Traza.Trace (
                                   'LONG_INST_INTERNA-nuidatributo-->'
                                || nuidatributo,
                                10);
                            sbLongInstInterna :=
                                ldc_boordenes.fsbdatoadictmporden (
                                    nuotinstancia,
                                    nuidatributo,
                                    'LONG_INST_INTERNA');
                            pkg_Traza.Trace (
                                   'LONG_INST_INTERNA-sbLongInstInterna-->'
                                || sbLongInstInterna,
                                10);
                        END IF;

                        --5012005 - MATERIAL_INST_INTERNA
                        IF (nuidatributo = 5012005)
                        THEN
                            pkg_Traza.Trace (
                                   'MATERIAL_INST_INTERNA-nuidatributo-->'
                                || nuidatributo,
                                10);
                            sbMaterialInterna :=
                                ldc_boordenes.fsbdatoadictmporden (
                                    nuotinstancia,
                                    nuidatributo,
                                    'MATERIAL_INST_INTERNA');
                            pkg_Traza.Trace (
                                   'MATERIAL_INST_INTERNA-sbMaterialInterna-->'
                                || sbMaterialInterna,
                                10);
                        END IF;

                        --5012013 - PUNTOS_CONECTADOS
                        IF (nuidatributo = 5012013)
                        THEN
                            pkg_Traza.Trace (
                                   'PUNTOS_CONECTADOS-nuidatributo-->'
                                || nuidatributo,
                                10);
                            sbPtosConectados :=
                                ldc_boordenes.fsbdatoadictmporden (
                                    nuotinstancia,
                                    nuidatributo,
                                    'PUNTOS_CONECTADOS');
                            pkg_Traza.Trace (
                                   'PUNTOS_CONECTADOS-sbPtosConectados-->'
                                || sbPtosConectados,
                                10);
                        END IF;

                        --5012006 - UBICACIÓN_INST_INTERNA
                        IF (nuidatributo = 5012006)
                        THEN
                            pkg_Traza.Trace (
                                   'UBICACIÓN_INST_INTERNA-nuidatributo-->'
                                || nuidatributo,
                                10);
                            sbUbicaInstInterna :=
                                ldc_boordenes.fsbdatoadictmporden (
                                    nuotinstancia,
                                    nuidatributo,
                                    'UBICACIÓN_INST_INTERNA');
                            pkg_Traza.Trace (
                                   'UBICACIÓN_INST_INTERNA-sbUbicaInstInterna-->'
                                || sbUbicaInstInterna,
                                10);
                        END IF;

                        --5000149 - PTOS_ADICIONALES
                        IF (nuidatributo = 5000149)
                        THEN
                            pkg_Traza.Trace (
                                   'PTOS_ADICIONALES-nuidatributo-->'
                                || nuidatributo,
                                10);
                            sbPtosAdicionales :=
                                ldc_boordenes.fsbdatoadictmporden (
                                    nuotinstancia,
                                    nuidatributo,
                                    'PTOS_ADICIONALES');
                            pkg_Traza.Trace (
                                   'PTOS_ADICIONALES-sbPtosAdicionales-->'
                                || sbPtosAdicionales,
                                10);
                        END IF;

                        --5000150 - PTOS_ADICIONALES
                        IF (nuidatributo = 5000150)
                        THEN
                            pkg_Traza.Trace (
                                   'PTOS_OPCIONALES-nuidatributo-->'
                                || nuidatributo,
                                10);
                            sbPtosOpcionales :=
                                ldc_boordenes.fsbdatoadictmporden (
                                    nuotinstancia,
                                    nuidatributo,
                                    'PTOS_OPCIONALES');
                            pkg_Traza.Trace (
                                   'PTOS_OPCIONALES-sbPtosOpcionales-->'
                                || sbPtosOpcionales,
                                10);
                        END IF;

                        --5000151 - SERIE_MEDIDOR
                        IF (nuidatributo = 5000151)
                        THEN
                            pkg_Traza.Trace (
                                   'SERIE_MEDIDOR-nuidatributo-->'
                                || nuidatributo,
                                10);
                            sbSerieMedidor :=
                                ldc_boordenes.fsbdatoadictmporden (
                                    nuotinstancia,
                                    nuidatributo,
                                    'SERIE_MEDIDOR');
                            pkg_Traza.Trace (
                                   'SERIE_MEDIDOR-sbSerieMedidor-->'
                                || sbSerieMedidor,
                                10);
                        END IF;
                    END IF;
                END IF;
            END LOOP;

            IF (nuaplica = 1)
            THEN
                -- Se obtiene la unidad operativa de la orden de cargo x conexion
                -- perteneciente a la misma solicitud y producto de la orden de certificacion instalacion
                pkg_Traza.Trace ('nuaplica = 1', 10);

                OPEN cuGetCxCOperatingUnit (nuotinstancia);

                FETCH cuGetCxCOperatingUnit INTO nuCxCOperatingUnit;

                CLOSE cuGetCxCOperatingUnit;

                pkg_Traza.Trace ('nuCxCOperatingUnit' || nuCxCOperatingUnit,
                                 10);

                IF (nuCxCOperatingUnit IS NULL)
                THEN
                    sbmensaje :=
                        'No se encontró unidad operativa para la orden Cargo x Conexi??n asociada a la solicitud.';
                    RAISE ex_error;
                END IF;

                --obtiene la unidad operativa del medidor
                OPEN cuGetSerialledItemOperUnit (sbSerieMedidor);

                FETCH cuGetSerialledItemOperUnit INTO nuMeterOperaUnit;

                CLOSE cuGetSerialledItemOperUnit;

                pkg_Traza.Trace ('nuMeterOperaUnit' || nuMeterOperaUnit, 10);

                IF (nuMeterOperaUnit IS NULL)
                THEN
                    sbmensaje :=
                           'No se encontró unidad operativa asociada al medidor con serie '
                        || sbSerieMedidor
                        || '.';
                    RAISE ex_error;
                END IF;

                IF (nuCxCOperatingUnit != nuMeterOperaUnit)
                THEN
                    sbmensaje :=
                           'La Unidad Operativa del medidor serie '
                        || sbSerieMedidor
                        || ' no corresponde con la unidad operativa de la orden de Cargo x Conexi??n.';
                    RAISE ex_error;
                END IF;
            END IF;

            --5.obtener el valor registrado y en caso de ser diferente a NO APLICA o cero(0) mostrar mensaje
            IF (nuaplica = 2)
            THEN
                pkg_Traza.Trace ('nuaplica = 2', 10);

                IF (   (    sbInstCentroMed IS NOT NULL
                        AND sbInstCentroMed != 'NO APLICA')
                    OR (    sbPresionEstatica IS NOT NULL
                        AND sbPresionEstatica != '0')
                    OR (    sbPresionDinamica IS NOT NULL
                        AND sbPresionDinamica != '0')
                    OR (    sbLongAcometida IS NOT NULL
                        AND sbLongAcometida != '0')
                    OR (    sbTipoCentroMed IS NOT NULL
                        AND sbTipoCentroMed != 'NO APLICA')
                    OR (    sbDiamAcometida IS NOT NULL
                        AND sbDiamAcometida != 'NO APLICA')
                    OR (    sbSerieMedidor IS NOT NULL
                        AND sbSerieMedidor != 'NO APLICA'))
                THEN
                    sbmensaje :=
                        'No existe Orden de Cargo x Conexion asociada a la solicitud, por lo que NO deben ingresar datos a certificar.';
                    RAISE ex_error;
                END IF;
            END IF;

            IF (nuaplica = 3)
            THEN
                pkg_Traza.Trace ('nuaplica=3', 10);

                IF (   (    sbPtosConstInst IS NOT NULL
                        AND sbPtosConstInst != '0')
                    OR (    sbLongInstInterna IS NOT NULL
                        AND sbLongInstInterna != '0')
                    OR (    sbMaterialInterna IS NOT NULL
                        AND sbMaterialInterna != 'NO APLICA')
                    OR (    sbPtosAdicionales IS NOT NULL
                        AND sbPtosAdicionales != '0')
                    OR (    sbPtosOpcionales IS NOT NULL
                        AND sbPtosOpcionales != '0')
                    OR (    sbUbicaInstInterna IS NOT NULL
                        AND sbUbicaInstInterna != 'NO APLICA'))
                THEN
                    sbmensaje :=
                        'No existe Orden de Instalacion de Interna asociada a la solicitud, por lo que NO deben ingresar datos a certificar.';
                    RAISE ex_error;
                END IF;

                -- Se obtiene la unidad operativa de la orden de cargo x conexion
                -- perteneciente a la misma solicitud y producto de la orden de certificacion instalacion
                OPEN cuGetCxCOperatingUnit (nuotinstancia);

                FETCH cuGetCxCOperatingUnit INTO nuCxCOperatingUnit;

                CLOSE cuGetCxCOperatingUnit;

                pkg_Traza.Trace (
                    'nuCxCOperatingUnit' || TO_CHAR (nuCxCOperatingUnit),
                    10);

                IF (nuCxCOperatingUnit IS NULL)
                THEN
                    sbmensaje :=
                        'No se encontró unidad operativa para la orden Cargo x Conexi??n asociada a la solicitud.';
                    RAISE ex_error;
                END IF;

                --obtiene la unidad operativa del medidor
                OPEN cuGetSerialledItemOperUnit (sbSerieMedidor);

                FETCH cuGetSerialledItemOperUnit INTO nuMeterOperaUnit;

                CLOSE cuGetSerialledItemOperUnit;

                pkg_Traza.Trace ('nuMeterOperaUnit' || nuMeterOperaUnit, 10);

                IF (nuMeterOperaUnit IS NULL)
                THEN
                    sbmensaje :=
                           'No se encontró unidad operativa asociada al medidor con serie '
                        || sbSerieMedidor
                        || '.';
                    RAISE ex_error;
                END IF;

                IF (nuCxCOperatingUnit != nuMeterOperaUnit)
                THEN
                    sbmensaje :=
                           'La Unidad Operativa del medidor serie '
                        || sbSerieMedidor
                        || ' no corresponde con la unidad operativa de la orden de Cargo x Conexi??n.';
                    RAISE ex_error;
                END IF;
            END IF;

            pkg_Traza.Trace ('rcAttributeSet', 10);

            -- se iteran los grupos de atrinutos
            FOR rcAttributeSet
                IN cuSplitStringData (
                       dald_parameter.fsbGetValue_Chain (
                           'CODIGO_GRUPO_SOLICITUD_NUEVAS'))
            LOOP
                /*
                     Se iteran los datos adicionales de ITEM - CANTIDAD
                     Esta Consulta Obtiene: Nombre_Item, Valor_Item, Nombre_Valor, Valor_Valor
                     Ejemplo:

                    ITEM_NAME       ITEM_VALUE      VALUE_NAME          VALUE_VALUE
                     ----------------------------------------------------------------
                     ITEM_1          Tubo Cobre      CANTIDAD_ITEM_1         2
                 */
                FOR rcAditionalData
                    IN cuGetAdditionalItemData (rcAttributeSet.COLUMN_VALUE,
                                                nuotinstancia)
                LOOP
                    pkg_Traza.Trace (
                        'rcAditionalData' || rcAditionalData.Item_Name,
                        10);
                    pkg_Traza.Trace (
                           'rcAditionalData.ITEM_VALUE'
                        || rcAditionalData.ITEM_VALUE,
                        10);
                    pkg_Traza.Trace (
                           'rcAditionalData.VALUE_VALUE'
                        || rcAditionalData.VALUE_VALUE,
                        10);

                    IF (   (    rcAditionalData.ITEM_VALUE IS NOT NULL
                            AND rcAditionalData.VALUE_VALUE IS NULL)
                        OR (    rcAditionalData.ITEM_VALUE IS NULL
                            AND rcAditionalData.VALUE_VALUE IS NOT NULL))
                    THEN
                        sbmensaje :=
                            'Es obligatorio diligenciar el Item y la Cantidad del Item juntos, no es permitido diligenciar solo uno de ellos. Favor revise los items ingresados.';
                        pkg_Traza.Trace ('sbmensaje' || sbmensaje, 10);
                        ge_boerrors.seterrorcodeargument (
                            Ld_Boconstans.cnuGeneric_Error,
                            sbmensaje);
                        RAISE pkg_Error.CONTROLLED_ERROR;
                    END IF;
                END LOOP;
            END LOOP;
        END IF;

        pkg_Traza.Trace ('Inicia provaliddatadiccertifnuevas', 10);
    EXCEPTION
        WHEN EX_ERROR
        THEN
            pkg_Traza.Trace ('sbmensaje' || sbmensaje, 10);
            GI_BOERRORS.SETERRORCODEARGUMENT (Ld_Boconstans.cnuGeneric_Error,
                                              sbMensaje);
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE;
    END provalidatadiccertnuevas;

    PROCEDURE provalcausal3reparacion
    IS
        /*****************************************
           Metodo: provalcausal3reparacion
           Descripcion:Restringe el uso de la causal "CAUSAL_OT_CUMPLIDA_INST_DEFECT" para los tramites de RP.
           Autor: Luz Andrea Angel/OLSoftware
           Fecha: Septiembre 23/2013

          Fecha              Autor              Modificacion
           ============    ================    ============================================
           28-01-2014        Sayra Ocoró       Se adiciona traza y se modifica manejo de la excepci??n
                                               NC 1119_3

        ******************************************/
        CURSOR cuotreparaleg3 (nusolic or_order_activity.package_id%TYPE)
        IS
            SELECT COUNT (1)
              FROM or_order_activity a, or_order b
             WHERE     a.order_id = b.order_id
                   AND a.task_type_id IN
                           (SELECT id_trabcert
                              FROM ldc_trab_cert
                             WHERE ldc_boutilities.fsbbuscatoken (
                                       dald_parameter.fsbgetvalue_chain (
                                           'TRAB_NO_GENERA_CERT_ASOCIADOS'),
                                       id_trabcert,
                                       ',') =
                                   'N')
                   AND b.order_status_id = 8
                   AND b.causal_id =
                       dald_parameter.fnugetnumeric_value (
                           'CAUSA_TRABAJOS_POR_TERCEROS',
                           NULL)
                   AND a.package_id = nusolic;

        nuordinstance   or_order.order_id%TYPE;
        nucausal        ge_causal.causal_id%TYPE;
        nusolicitud     or_order_activity.package_id%TYPE;
        sbtiposol       VARCHAR2 (20);
        nutiposol       mo_packages.package_type_id%TYPE;
        sbmensaje       VARCHAR2 (1000);
        sbsolicitud     VARCHAR2 (20);
        nucantleg       NUMBER;
        ex_error        EXCEPTION;
    BEGIN
        pkg_Traza.Trace ('Inicia LDC_BOORDENES.provalcausal3reparacion', 10);
        nuOrdinstance := or_bolegalizeorder.fnugetcurrentorder;
        --orden de certificacion de la instancia
        pkg_Traza.Trace (
               'Ejecucion LDC_BOORDENES.provalcausal3reparacion nuordinstance => '
            || nuordinstance,
            10);
        nucausal := daor_order.fnugetcausal_id (nuordinstance);
        pkg_Traza.Trace (
               'Ejecucion LDC_BOORDENES.provalcausal3reparacion nucausal => '
            || nucausal,
            10);

        IF (nucausal =
            dald_parameter.fnugetnumeric_value (
                'CAUSAL_OT_CUMPLIDA_INST_DEFECT',
                NULL))
        THEN
            --9594
            sbsolicitud :=
                ldc_boutilities.fsbgetvalorcampotabla ('OR_ORDER_ACTIVITY',
                                                       'ORDER_ID',
                                                       'PACKAGE_ID',
                                                       nuordinstance);
            nusolicitud := TO_NUMBER (sbsolicitud);
            pkg_Traza.Trace (
                   'Ejecucion LDC_BOORDENES.provalcausal3reparacion nusolicitud => '
                || nusolicitud,
                10);
            nutiposol := damo_packages.fnugetpackage_type_id (nusolicitud);
            -- ldc_boutilities.fsbgetvalorcampotabla('MO_PACKAGES','PACKAGE_ID','PACKAGE_TYPE_ID', nusolicitud);
            -- nutiposol   := to_number(sbtiposol);
            pkg_Traza.Trace (
                   'Ejecucion LDC_BOORDENES.provalcausal3reparacion nutiposol => '
                || nutiposol,
                10);

            IF (nutiposol IN (265, 266))
            THEN
                OPEN cuotreparaleg3 (nusolicitud);

                FETCH cuotreparaleg3 INTO nucantleg;

                CLOSE cuotreparaleg3;

                pkg_Traza.Trace (
                       'Ejecucion LDC_BOORDENES.provalcausal3reparacion nucantleg-->'
                    || nucantleg,
                    10);

                IF (nucantleg > 0)
                THEN
                    sbmensaje :=
                        'Causal no permitida para legalizar, debe usar la causal TRABAJOS HECHOS POR TERCEROS CON DEFECTOS';
                    pkg_Traza.Trace (
                           'Ejecucion LDC_BOORDENES.provalcausal3reparacion sbmensaje =>'
                        || sbmensaje,
                        10);
                    RAISE ex_error;
                END IF;
            END IF;
        END IF;

        pkg_Traza.Trace ('Fin LDC_BOORDENES.provalcausal3reparacion', 10);
    EXCEPTION
        WHEN ex_error
        THEN
            ge_boerrors.seterrorcodeargument (Ld_Boconstans.cnuGeneric_Error,
                                              sbMensaje);
            RAISE;
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            ge_boerrors.seterrorcodeargument (Ld_Boconstans.cnuGeneric_Error,
                                              sbMensaje);
            RAISE;
    END provalcausal3reparacion;

    /*****************************************
    Metodo: fnuGetAreaOrganizat
    Descripcion:  nuPackageId: id_solicitud.
                  nuCategory : id categoria
                  Esta funcion recibe como parametro de entrada la solicitud y la categoria, devuelve el area organizacional
    Autor: Alvaro Zapata
    Fecha: Octubre 26/2013

     ******************************************/
    FUNCTION fnuGetAreaOrganizat (
        nuPackageTypeId    IN MO_PACKAGES.PACKAGE_TYPE_ID%TYPE,
        nuCategory         IN CATEGORI.CATECODI%TYPE,
        inuPackageIdAnul   IN mo_packages.package_id%TYPE)
        RETURN NUMBER
    IS
        nuAreaOrga      NUMBER;
        sbMedioUso      VARCHAR2 (1);
        nuArea          NUMBER; --AREA QUE TIENE CONFIGURADA EN LDCGAS EL TIPO DE PAQUETE
        nuCategoria     NUMBER;
        nuAreaSolAnul   NUMBER;        --AREA QUE ESTA REALIZANDO LA ANULACION

        CURSOR cuLDCGAS (
            nuPackageTypeId   IN MO_PACKAGES.PACKAGE_TYPE_ID%TYPE,
            nuCategory        IN CATEGORI.CATECODI%TYPE)
        IS
            SELECT MEDIO_USO, ORGANIZAT_AREA_ID, CATECODI
              FROM LDC_REP_AREA_TI_PA_CA
             WHERE     PACKAGE_TYPE_ID = nuPackageTypeId
                   AND CATECODI = nuCategory;
    BEGIN
        SELECT SALE_CHANNEL_ID
          INTO nuAreaSolAnul
          FROM MO_PACKAGES
         WHERE PACKAGE_ID = inuPackageIdAnul;

        -- se obtiene la configuracion del tipo de paquete en LDCGAS
        OPEN cuLDCGAS (nuPackageTypeId, nuCategory);

        FETCH cuLDCGAS INTO sbMedioUso, nuArea, nuCategoria;

        CLOSE cuLDCGAS;

        pkg_Traza.Trace ('Inicia LDC_BOORDENES.fnuGetAreaOrganizat', 4);

        IF (nuPackageTypeId IS NULL)
        THEN
            nuAreaOrga := 0;
        ELSE
            IF sbMedioUso = 'I'
            THEN
                DBMS_OUTPUT.put_line (
                    'MEDIO DE USO I, RETORNA nuArea:' || nuArea);
                RETURN nuArea;
            ELSE
                IF sbMedioUso = 'E'
                THEN
                    DBMS_OUTPUT.put_line (
                           'MEDIO DE USO E, RETORNA nuAreaSolAnul:'
                        || nuAreaSolAnul);
                    RETURN nuAreaSolAnul;
                ELSE
                    IF     sbMedioUso = 'M'
                       AND LDC_BOUTILITIES.fsbBuscaToken (
                               dald_Parameter.fsbGetValue_Chain (
                                   'AREAS_SERCLIENTE'),
                               nuAreaSolAnul,
                               ',') =
                           'N'
                    THEN
                        DBMS_OUTPUT.put_line (
                            'MEDIO DE USO M, RETORNA nuArea:' || nuArea);
                        RETURN nuArea;
                    ELSE
                        DBMS_OUTPUT.put_line (
                               'MEDIO DE USO M, RETORNA nuAreaSolAnul:'
                            || nuAreaSolAnul);
                        RETURN nuAreaSolAnul;
                    END IF;
                END IF;
            END IF;
        END IF;

        pkg_Traza.Trace ('Fin LDC_BOORDENES.fnuGetAreaOrganizat', 4);
        RETURN nuAreaOrga;
    EXCEPTION
        WHEN OTHERS
        THEN
            nuAreaOrga := 0;
            RETURN nuAreaOrga;
    END fnuGetAreaOrganizat;

    /*****************************************
    METODO: FNUCOMPARAITEMSCERTEJE
    DESCRIPCION:  COMPARA CANTIDADES DE ITEMS LEGALIZADOS ENTRE LA ORDEN DE CERTIFICACION O APOYO (CERTIFICADOR)
                  Y LA ORDEN DE NUEVAS (EJECUTOR) RETORNA 0 SI ENCONTRO DIFERENCIAS PARA ORDENES NUEVAS

    AUTOR: JORGE VALIENTE

    FECHA: 18 JUNIO 2014

    FECHA                IDENTREGA           MODIFICACION
    ============    ================    ============================================
    ******************************************/
    FUNCTION FNUCOMPARAITEMSCERTEJE (
        NUORDENLEGALIZADA     IN     OR_ORDER.ORDER_ID%TYPE,
        NUORDENCERITIFCADOR   IN     OR_ORDER.ORDER_ID%TYPE,
        SBGRUPOS              IN     VARCHAR2,
        SBMENSAJE                OUT VARCHAR2)
        RETURN VARCHAR2
    AS
        --OBTIENE LOS GRUPOS DE DATOS ADICIONALES DEL TIPO DE TRABAJO
        CURSOR CUGRUPOS IS
            SELECT COLUMN_VALUE
              FROM TABLE (LDC_BOUTILITIES.SPLITSTRINGS (SBGRUPOS, ','));

        --OBTENER LOS ITEMS DE LA ORDEN DEL EJECUTOR
        CURSOR CUOR_ORDER_ITEMS IS
            SELECT *
              FROM OR_ORDER_ITEMS OOI
             WHERE     OOI.ORDER_ID = NUORDENLEGALIZADA
                   AND DAGE_ITEMS.FNUGETITEM_CLASSIF_ID (OOI.ITEMS_ID) IN
                           (SELECT TO_NUMBER (COLUMN_VALUE)
                              FROM TABLE (
                                       ldc_boutilities.splitstrings (
                                           DALD_PARAMETER.fsbGetValue_Chain (
                                               'CODIGO_CLAS_ITEM_VALI',
                                               NULL),
                                           ',')));

        /*
        AND OOI.ITEMS_ID NOT IN
            (select to_number(column_value)
               from table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('CODIGO_ITEM_EXCLUSION',
                                                                                        NULL),
                                                       ',')));
        */
        --OBTENER CANTIDAD DE ITEMS DE LA ORDEN DEL EJECUTOR
        CURSOR CUCOUNTOR_ORDER_ITEMS IS
            SELECT COUNT (*)     CANTIDAD
              FROM OR_ORDER_ITEMS OOI
             WHERE     OOI.ORDER_ID = NUORDENLEGALIZADA
                   AND DAGE_ITEMS.FNUGETITEM_CLASSIF_ID (OOI.ITEMS_ID) IN
                           (SELECT TO_NUMBER (COLUMN_VALUE)
                              FROM TABLE (
                                       ldc_boutilities.splitstrings (
                                           DALD_PARAMETER.fsbGetValue_Chain (
                                               'CODIGO_CLAS_ITEM_VALI',
                                               NULL),
                                           ',')));

        /*
        AND OOI.ITEMS_ID NOT IN
            (select to_number(column_value)
               from table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('CODIGO_ITEM_EXCLUSION',
                                                                                        NULL),
                                                       ',')));
        */
        NUCUCOUNTOR_ORDER_ITEMS   NUMBER;

        --VALIDAR LA RELACION DEL ITEM CON EL TIPO DE TRABAJO DE LA ORDEN DEL EJECUTOR
        CURSOR CUOR_TASK_TYPES_ITEMS (NUITEM NUMBER)
        IS
            SELECT COUNT (1)     CANTIDAD
              FROM OR_TASK_TYPES_ITEMS OTTI
             WHERE     OTTI.TASK_TYPE_ID =
                       DAOR_ORDER.FNUGETTASK_TYPE_ID (NUORDENLEGALIZADA,
                                                      NULL)
                   AND OTTI.ITEMS_ID = NUITEM;

        NUORDENREPARACOMP         OR_ORDER.ORDER_ID%TYPE;
        NUITEMREPARA              OR_ORDER_ITEMS.ITEMS_ID%TYPE;
        NUCAUSAL                  GE_CAUSAL.CAUSAL_ID%TYPE;
        SBITEM                    VARCHAR2 (15);
        SBDIFERENTES              VARCHAR2 (2000);
        SBCAUSALES                VARCHAR2 (2000);
        SBCANTITEM                VARCHAR2 (15);
        NUCAUSATERCEROS           NUMBER;
        NUCOMPARA                 NUMBER := 1;
        NUCUENTA                  NUMBER;
        NUGRUPO                   NUMBER;
        SBENCUENTRA               VARCHAR2 (1) := 'N';
        SBITEMREJECUTOR           VARCHAR2 (250);
        QUERY_STR                 VARCHAR2 (4000);
        NUCANTIDAD                NUMBER;

        TYPE cursor_ref IS REF CURSOR;

        c1                        cursor_ref;
        SBCONTROL                 VARCHAR2 (10) := NULL;
    BEGIN
        pkg_Traza.Trace ('INICIO FNUCOMPARAITEMSCERTEJE', 10);
        pkg_Traza.Trace ('****NUORDENLEGALIZADA --> ' || NUORDENLEGALIZADA,
                         10);
        pkg_Traza.Trace (
            '****NUORDENCERITIFCADOR --> ' || NUORDENCERITIFCADOR,
            10);
        pkg_Traza.Trace ('****SBGRUPOS --> ' || SBGRUPOS, 10);

        OPEN CUCOUNTOR_ORDER_ITEMS;

        FETCH CUCOUNTOR_ORDER_ITEMS INTO NUCUCOUNTOR_ORDER_ITEMS;

        CLOSE CUCOUNTOR_ORDER_ITEMS;

        IF NUCUCOUNTOR_ORDER_ITEMS > 0
        THEN
            FOR TEMPCUOR_ORDER_ITEMS IN CUOR_ORDER_ITEMS
            LOOP
                pkg_Traza.Trace (
                       '**********OR_ORDER_ITEMS ITEM LEGALIZADO --> '
                    || TEMPCUOR_ORDER_ITEMS.ITEMS_ID,
                    10);
                pkg_Traza.Trace (
                       '**********OR_ORDER_ITEMS CANTIDAD LEGALIZADA --> '
                    || TEMPCUOR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT,
                    10);
                NUCUENTA := 2;
                SBENCUENTRA := 'N';
                SBMENSAJE := NULL;

                WHILE ((NUCUENTA <= 20) AND (SBENCUENTRA = 'N'))
                LOOP
                    SBITEM := NULL;
                    SBCANTITEM := NULL;
                    pkg_Traza.Trace ('**********CONTADOR --> ' || NUCUENTA,
                                     10);
                    QUERY_STR :=
                           'SELECT VALUE_'
                        || TO_CHAR (NUCUENTA - 1)
                        || ', VALUE_'
                        || TO_CHAR (NUCUENTA)
                        || '
           FROM OR_REQU_DATA_VALUE
          WHERE ORDER_ID = '
                        || TO_CHAR (NUORDENCERITIFCADOR)
                        || '
            AND ATTRIBUTE_SET_ID IN ('
                        || SBGRUPOS
                        || ')
            AND VALUE_'
                        || TO_CHAR (NUCUENTA - 1)
                        || '= '
                        || TO_CHAR (TEMPCUOR_ORDER_ITEMS.ITEMS_ID);
                    pkg_Traza.Trace ('**********CONSULTA --> ' || QUERY_STR,
                                     10);

                    --OBTENER LOS ITEMS DEL CERTIFICADOR
                    OPEN C1 FOR
                           'SELECT VALUE_'
                        || TO_CHAR (NUCUENTA - 1)
                        || ', VALUE_'
                        || TO_CHAR (NUCUENTA)
                        || '
           FROM OR_REQU_DATA_VALUE
          WHERE ORDER_ID = '
                        || TO_CHAR (NUORDENCERITIFCADOR)
                        || '
            AND ATTRIBUTE_SET_ID IN ('
                        || SBGRUPOS
                        || ')
            AND VALUE_'
                        || TO_CHAR (NUCUENTA - 1)
                        || '= '
                        || TO_CHAR (TEMPCUOR_ORDER_ITEMS.ITEMS_ID);    -- || '

                    --AND VALUE_' || TO_CHAR(NUCUENTA) || ' = ' || TO_CHAR(TEMPCUOR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT);
                    FETCH C1 INTO SBITEM, SBCANTITEM;

                    pkg_Traza.Trace (
                        '****************ITEM CERTIFICADOR --> ' || SBITEM,
                        10);
                    pkg_Traza.Trace (
                           '****************CANTIDAD CERTIFICADOR --> '
                        || SBCANTITEM,
                        10);

                    IF NVL (SBITEM, 0) <> 0
                    THEN
                        IF TO_NUMBER (SBCANTITEM) =
                           TEMPCUOR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT
                        THEN
                            SBENCUENTRA := 'S';
                        ELSE
                            IF SBMENSAJE IS NULL
                            THEN
                                SBMENSAJE :=
                                       'EL ITEM ['
                                    || TEMPCUOR_ORDER_ITEMS.ITEMS_ID
                                    || '] CON LA CANTIDAD ['
                                    || TEMPCUOR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT
                                    || '] NO COINCIDE CON LA CANTIDAD LEGALIZADA POR EL CERTIFICADOR';
                                RETURN '-1';
                            END IF;
                        END IF;
                    END IF;

                    NUCUENTA := NUCUENTA + 2;
                END LOOP;                                              --WHILE

                IF SBENCUENTRA = 'N'
                THEN
                    IF SBMENSAJE IS NULL
                    THEN
                        SBMENSAJE :=
                               'EL ITEM ['
                            || TEMPCUOR_ORDER_ITEMS.ITEMS_ID
                            || '] NO EXISTE EN LOS ITEMS LEGALIZADOS POR EL CERTIIFCADOR';
                        RETURN '-1';
                    END IF;
                END IF;
            END LOOP;
        ELSE
            --VALIDA QUE LOS ITEMS DEL CERTIFICADOR NO ESTE RELACIONADOS CON LOS
            --DEL TIPO DE TRABAJO DE LA ORDEN DEL EJECUTOR A LEGALIZAR
            NUCUENTA := 2;
            SBENCUENTRA := 'N';
            SBMENSAJE := NULL;

            WHILE ((NUCUENTA <= 20) AND (SBENCUENTRA = 'N'))
            LOOP
                SBITEM := NULL;
                SBCANTITEM := NULL;
                pkg_Traza.Trace ('**********CONTADOR --> ' || NUCUENTA, 10);
                QUERY_STR :=
                       'SELECT VALUE_'
                    || TO_CHAR (NUCUENTA - 1)
                    || ', VALUE_'
                    || TO_CHAR (NUCUENTA)
                    || '
           FROM OR_REQU_DATA_VALUE
          WHERE ORDER_ID = '
                    || TO_CHAR (NUORDENCERITIFCADOR)
                    || '
            AND ATTRIBUTE_SET_ID IN ('
                    || SBGRUPOS
                    || ')';
                pkg_Traza.Trace ('**********CONSULTA --> ' || QUERY_STR, 10);

                --OBTENER LOS ITEMS DEL CERTIFICADOR
                OPEN C1 FOR
                       'SELECT VALUE_'
                    || TO_CHAR (NUCUENTA - 1)
                    || ', VALUE_'
                    || TO_CHAR (NUCUENTA)
                    || '
           FROM OR_REQU_DATA_VALUE
          WHERE ORDER_ID = '
                    || TO_CHAR (NUORDENCERITIFCADOR)
                    || '
            AND ATTRIBUTE_SET_ID IN ('
                    || SBGRUPOS
                    || ')';

                FETCH C1 INTO SBITEM, SBCANTITEM;

                pkg_Traza.Trace (
                    '****************ITEM CERTIFICADOR --> ' || SBITEM,
                    10);
                pkg_Traza.Trace (
                       '****************CANTIDAD CERTIFICADOR --> '
                    || SBCANTITEM,
                    10);

                --/*
                IF NVL (SBITEM, 0) <> 0
                THEN
                    OPEN CUOR_TASK_TYPES_ITEMS (TO_NUMBER (SBITEM));

                    FETCH CUOR_TASK_TYPES_ITEMS INTO NUCANTIDAD;

                    CLOSE CUOR_TASK_TYPES_ITEMS;

                    IF NUCANTIDAD > 0
                    THEN
                        SBENCUENTRA := 'S';
                        SBMENSAJE :=
                               'EL ITEM ['
                            || SBITEM
                            || '] FUE LEGALIZADO POR EL CERTIFICADOR. PERO NO EXISTE EN LA LEGALIZACION DEL EJECUTOR';
                        RETURN '-1';
                    END IF;
                END IF;

                --*/
                NUCUENTA := NUCUENTA + 2;
            END LOOP;                                                  --WHILE
        ------------------------------------------------------------------------
        END IF;

        RETURN '1';
        pkg_Traza.Trace (
            'FNUCOMPARAITEMSCERTEJE-SBDIFERENTES-->' || SBDIFERENTES,
            10);
        pkg_Traza.Trace ('FIN FNUCOMPARAITEMSCERTEJE', 10);
        --RETURN NUCOMPARA;
        RETURN SBDIFERENTES;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN '-1';
    END FNUCOMPARAITEMSCERTEJE;

    /*****************************************
    METODO: PRCOMPARAPROCOMPARACANTCERTREPARA
    DESCRIPCION:  COMPARA CANTIDADES DE ITEMS LEGALIZADOS ENTRE LA ORDEN DE CERTIFICACION O APOYO (CERTIFICADOR)
                  Y LA ORDEN DE NUEVAS (EJECUTOR) OBTENIDOS DESDE LA INSTANCIA DE ORDENES NUEVAS

    AUTOR: JORGE VALIENTE

    FECHA: 18 JUNIO 2014

    FECHA                IDENTREGA           MODIFICACION
    ============    ================    ============================================
    17-Sep-2014     Jorge Valiente      NC2353: Validacion de causal de legalizacion
                                                certificacion x terceros para que
                                                no valide los datos del ejecutor en caso
                                                que la causal sea realizada por TERCEROS.

    06-Oct-2014     Alexandra Gordillo  NC 1917: Se consulta la direccion de la orden que se esta legalizando
                                                en or_order_activity
                                                se agrega el parametro nuAddres al cursor CUVISITAACEPTACION
                                                para que se comparen que la direccion de la orden de aceptacion
                                                sea la misma que la que se esta legalizando.

    06-Oct-2014     Alexandra Gordillo  NC 1917: Se consulta la direccion de la orden que se esta legalizando
                                                en or_order_activity
                                                se agrega el parametro nuAddres al cursor CUVISITAACEPTACION
                                                para que se comparen que la direccion de la orden de aceptacion
                                                sea la misma que la que se esta legalizando.

    ******************************************/
    PROCEDURE PROCOMPARAITEMSCERTEJE
    IS
        --SOLICITUD ASOCIADA A LA ORDEN LEGALIZADA
        CURSOR CUSOLICITUD (NUORDEN OR_ORDER.ORDER_ID%TYPE)
        IS
            SELECT B.PACKAGE_ID, C.PACKAGE_TYPE_ID
              FROM OR_ORDER A, OR_ORDER_ACTIVITY B, MO_PACKAGES C
             WHERE     A.ORDER_ID = B.ORDER_ID
                   AND B.PACKAGE_ID = C.PACKAGE_ID
                   AND B.ORDER_ID = NUORDEN;

        --OBTIENE LA ULTIMA ORDEN DE CERTIFICACION ASOCIADA A LA SOLICITUD
        CURSOR CUORDENCERT (NUSOLIC      MO_PACKAGES.PACKAGE_ID%TYPE,
                            NUTRABAJOC   OR_ORDER.TASK_TYPE_ID%TYPE,
                            nuAddres     or_order_activity.address_id%TYPE)
        IS
            SELECT ORDER_ID,
                   TASK_TYPE_ID,
                   OPERATING_UNIT_ID,
                   CAUSAL_ID
              FROM (  SELECT A.ORDER_ID,
                             A.TASK_TYPE_ID,
                             B.OPERATING_UNIT_ID,
                             B.CAUSAL_ID
                        FROM OR_ORDER_ACTIVITY A, OR_ORDER B
                       WHERE     A.ORDER_ID = B.ORDER_ID
                             AND A.TASK_TYPE_ID = NUTRABAJOC
                             AND B.ORDER_STATUS_ID = 8
                             --      AND O1.CAUSAL_ID IN (9944, 9945, 9594, 9947)
                             --AND LDC_BOUTILITIES.FSBBUSCATOKEN(DALD_PARAMETER.FSBGETVALUE_CHAIN('CAUSA_CERT_ASOCIADOS'),
                             --                                 TO_CHAR(B.CAUSAL_ID),
                             --                                  ',') = 'S'
                             AND A.PACKAGE_ID = NUSOLIC
                             AND A.ADDRESS_ID = nuAddres
                    ORDER BY 1 DESC) ORDEN_CETIF
             WHERE ROWNUM = 1;

        --OBTIENE LA ORDEN DE APOYO DESDE LA SOLICITUD DE VENTA
        CURSOR CUORDENAPOYO (NUSOLICITUD   MO_PACKAGES.PACKAGE_ID%TYPE,
                             nuAddres      or_order_activity.address_id%TYPE)
        IS
            SELECT A.ORDER_ID, B.TASK_TYPE_ID
              FROM OR_ORDER A, OR_ORDER_ACTIVITY B
             WHERE     A.ORDER_ID = B.ORDER_ID
                   AND B.PACKAGE_ID = NUSOLICITUD
                   AND B.TASK_TYPE_ID =
                       DALD_PARAMETER.fnuGetNumeric_Value (
                           'COD_COR_DAT_LEG_CER_NUE',
                           NULL) --; --OT APOYO CORRECCION DATOS LEGALIZACION CERTIFICACION ASOCIADOS
                   AND A.LEGALIZATION_DATE =
                       (SELECT MAX (LEGALIZATION_DATE)
                          FROM (  SELECT O1.ORDER_ID,
                                         O1.CAUSAL_ID,
                                         O1.LEGALIZATION_DATE
                                    FROM OR_ORDER         O1,
                                         OR_ORDER_ACTIVITY OA1
                                   WHERE     OA1.ORDER_ID = O1.ORDER_ID
                                         AND O1.TASK_TYPE_ID =
                                             DALD_PARAMETER.fnuGetNumeric_Value (
                                                 'COD_COR_DAT_LEG_CER_NUE',
                                                 NULL)
                                         AND OA1.PACKAGE_ID = NUSOLICITUD
                                         AND OA1.ADDRESS_ID = nuAddres
                                         AND O1.CAUSAL_ID =
                                             DALD_PARAMETER.FNUGETNUMERIC_VALUE (
                                                 'COD_CAU_OT_LEG',
                                                 NULL)
                                ORDER BY 1 DESC) ORDEN_CERTIF)
                   AND B.ADDRESS_ID = nuAddres; --OT APOYO CORRECCIONM DATOS DE LEGALIZ. CERTIF. NUEVAS.

        --NC999 VALIDA SI LA UNIDAD DE TRABAJO ES EXTERNA
        CURSOR CUUNIDADEXTERNA (NUUNIDADOPER OR_ORDER.OPERATING_UNIT_ID%TYPE)
        IS
            SELECT ES_EXTERNA
              FROM OR_OPERATING_UNIT
             WHERE OPERATING_UNIT_ID = NUUNIDADOPER;

        CURSOR CUVALIDAMULTA (NUORDENC   OR_ORDER.ORDER_ID%TYPE,
                              NUITEMM    GE_ITEMS.ITEMS_ID%TYPE)
        IS
            SELECT A.ORDER_ID
              FROM OR_RELATED_ORDER A
             WHERE     A.RELA_ORDER_TYPE_ID = 14
                   AND A.ORDER_ID = NUORDENC
                   AND (SELECT B.ORDER_ID
                          FROM OR_ORDER_ACTIVITY B
                         WHERE     B.ACTIVITY_ID = NUITEMM
                               AND B.ORDER_ID = A.RELATED_ORDER_ID) =
                       1;

        --INICIO NC2353 CURSOR PARA VALIDAR SI EXISTE UAN ORDEN 10500
        --NC1917  Se agrega el parametro nuAddres y la condicion de la direccion
        CURSOR CUVISITAACEPTACION (
            NUSOLIC    MO_PACKAGES.PACKAGE_ID%TYPE,
            nuAddres   or_order_activity.address_id%TYPE)
        IS
              SELECT A.ORDER_ID,
                     A.TASK_TYPE_ID,
                     B.OPERATING_UNIT_ID,
                     B.CAUSAL_ID,
                     B.ORDER_STATUS_ID
                FROM OR_ORDER_ACTIVITY A, OR_ORDER B
               WHERE     A.ORDER_ID = B.ORDER_ID
                     AND A.TASK_TYPE_ID =
                         DALD_PARAMETER.fnuGetNumeric_Value (
                             'VISITA_ACEPTA_CERTIF_INSTAL',
                             NULL)
                     AND A.PACKAGE_ID = NUSOLIC
                     AND a.address_id = nuAddres
                     AND ROWNUM = 1
            ORDER BY 1 DESC;

        TEMPCUVISITAACEPTACION          CUVISITAACEPTACION%ROWTYPE;

        CURSOR CUEXISTE (NUDATO        NUMBER,
                         SBPARAMETRO   LD_PARAMETER.VALUE_CHAIN%TYPE)
        IS
            SELECT COUNT (1)     cantidad
              FROM DUAL
             WHERE NUDATO IN
                       (SELECT TO_NUMBER (COLUMN_VALUE)
                          FROM TABLE (
                                   ldc_boutilities.splitstrings (SBPARAMETRO,
                                                                 ',')));

        SBESTADO_ORDEN_VISI_ACEP_CERT   LD_PARAMETER.VALUE_CHAIN%TYPE
            := DALD_PARAMETER.fsbGetValue_Chain (
                   'ESTADO_ORDEN_VISI_ACEP_CERT',
                   NULL);
        NUESTADO_CERRADO                LD_PARAMETER.NUMERIC_VALUE%TYPE
            := DALD_PARAMETER.fnuGetNumeric_Value ('ESTADO_CERRADO', NULL);
        NUCAUSAL_CLIEN_CERTI_TERCER     LD_PARAMETER.NUMERIC_VALUE%TYPE
            := DALD_PARAMETER.fnuGetNumeric_Value (
                   'CAUSAL_CLIEN_CERTI_TERCER',
                   NULL);
        NUVALIDO                        NUMBER := 0; --VARIABLE PARA DETERMINAR PERMITE LEGALIZAR CARGO X CONEXION E INTERNA
        --FIN NC2353 CURSOR PARA VALIDAR SI EXISTE UAN ORDEN 10500
        NUORDENLEGALIZADA               OR_ORDER.ORDER_ID%TYPE;
        NUTIPOTRABR                     OR_ORDER.TASK_TYPE_ID%TYPE;
        NUTIPOPAQ                       MO_PACKAGES.PACKAGE_TYPE_ID%TYPE;
        NUSOLICITUD                     MO_PACKAGES.PACKAGE_ID%TYPE;
        NUORDENC                        OR_ORDER.ORDER_ID%TYPE;
        NUTRABC                         OR_ORDER.TASK_TYPE_ID%TYPE;
        NUUNIOPERC                      OR_ORDER.OPERATING_UNIT_ID%TYPE;
        NUCAUSALC                       OR_ORDER.CAUSAL_ID%TYPE;
        NUORDENAPOYO                    OR_ORDER.ORDER_ID%TYPE;
        NUTIPOTRABAP                    OR_ORDER.TASK_TYPE_ID%TYPE;
        NUITEMMULTA                     GE_ITEMS.ITEMS_ID%TYPE;
        NUTITRCERTIF                    OR_TASK_TYPE.TASK_TYPE_ID%TYPE;
        NUORDENMULTA                    OR_ORDER.ORDER_ID%TYPE;
        SBMENSAJE                       VARCHAR2 (2000);
        SBITEMDIF                       VARCHAR2 (2000);
        SBAPLICAMULTA                   VARCHAR2 (2);
        SBGRUPOS                        VARCHAR2 (20);
        NUCOMPARA                       NUMBER;
        NUERRORCODE                     NUMBER;
        NUPERSONID                      NUMBER;
        SBERRORMESSAGE                  VARCHAR2 (4000);
        NUTIPOCOMENTARIO                NUMBER := 1298;
        SBEXTERNA                       VARCHAR2 (2) := 'N';
        EX_ERROR                        EXCEPTION;
        ONUVALUE                        GE_UNIT_COST_ITE_LIS.PRICE%TYPE;
        ONUPRICELISTID                  GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID%TYPE;
        IDTDATE                         DATE;
        INUCONTRACT                     GE_LIST_UNITARY_COST.CONTRACT_ID%TYPE;
        INUCONTRACTOR                   GE_LIST_UNITARY_COST.CONTRACTOR_ID%TYPE;
        INUGEOLOCATION                  GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID%TYPE;
        ISBTYPE                         GE_ACTA.ID_TIPO_ACTA%TYPE;
        NUITEM                          NUMBER;
        NUCANTIDAD                      NUMBER;
        NUUNIDOPER                      NUMBER;
        ONUADMIN                        NUMBER;
        ONUIMPRE                        NUMBER;
        ONUUTILI                        NUMBER;
        NUCAUSALCERTIFICATERCERO        LD_PARAMETER.NUMERIC_VALUE%TYPE;
        nuAddressID                     or_order_activity.address_id%TYPE;
    BEGIN
        pkg_Traza.Trace ('INICIA LDC_BOORDENES.PROCOMPARAITEMSCERTEJE', 10);
        --ORDEN NUEVA LEGALIZADA
        NUORDENLEGALIZADA := OR_BOLEGALIZEORDER.FNUGETCURRENTORDER;
        pkg_Traza.Trace (
            'PROCOMPARAITEMSCERTEJE-ORDER LEGALIZADA-->' || NUORDENLEGALIZADA,
            10);
        --SI LA ORDEN DE LA INSTANCIA ES DE REPARACION
        pkg_Traza.Trace (
            'PROCOMPARAITEMSCERTEJE-NUTIPOTRABR-->' || NUTIPOTRABR,
            10);

        --NC1917 Se obtiene la direccion de la orden que en el momento se esta legalizando
        BEGIN
            SELECT address_id
              INTO nuAddressID
              FROM or_order_activity
             WHERE order_id = NUORDENLEGALIZADA AND ROWNUM = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
                nuAddressID := NULL;
        END;

        pkg_Traza.Trace (
            'Direccion de la Orden - nuAddressID-->' || nuAddressID,
            10);

        OPEN CUSOLICITUD (NUORDENLEGALIZADA);

        FETCH CUSOLICITUD INTO NUSOLICITUD, NUTIPOPAQ;

        CLOSE CUSOLICITUD;

        IF (NUSOLICITUD IS NOT NULL)
        THEN
            pkg_Traza.Trace (
                'PROCOMPARAITEMSCERTEJE-SOLICITUD-->' || NUSOLICITUD,
                10);
            pkg_Traza.Trace (
                'PROCOMPARAITEMSCERTEJE-TIPO SOLICITUD-->' || NUTIPOPAQ,
                10);

            --VALIDO EL PAQUETE PARA SABER LA OT DE CERTIFICACION CORRESPONDIENTE
            IF (NUTIPOPAQ IS NOT NULL)
            THEN
                --SI LA SOLICITUD DE CERTIFICACION NUEVAS
                IF INSTR (
                       DALD_PARAMETER.FSBGETVALUE_CHAIN (
                           'CODIGO_TIPO_SOLICITUD_NUEVAS'),
                       TO_CHAR (NUTIPOPAQ)) >
                   0
                THEN
                    NUTITRCERTIF :=
                        DALD_PARAMETER.fnuGetNumeric_Value (
                            'COD_INSP_CERT_TASK_TYPE',
                            NULL);
                END IF;

                pkg_Traza.Trace (
                    'PROCOMPARAITEMSCERTEJE-NUTITRCERTIF-->' || NUTITRCERTIF,
                    10);

                OPEN CUORDENCERT (NUSOLICITUD, NUTITRCERTIF, nuAddressID);

                FETCH CUORDENCERT
                    INTO NUORDENC,
                         NUTRABC,
                         NUUNIOPERC,
                         NUCAUSALC;

                CLOSE CUORDENCERT;
            END IF;

            ---NC2353 CURSOR  VISITA ACEPTACION
            OPEN CUVISITAACEPTACION (NUSOLICITUD, nuAddressID);

            FETCH CUVISITAACEPTACION INTO TEMPCUVISITAACEPTACION;

            IF CUVISITAACEPTACION%FOUND
            THEN
                IF TEMPCUVISITAACEPTACION.ORDER_STATUS_ID <> NUESTADO_CERRADO
                THEN
                    OPEN CUEXISTE (TEMPCUVISITAACEPTACION.ORDER_STATUS_ID,
                                   SBESTADO_ORDEN_VISI_ACEP_CERT);

                    FETCH CUEXISTE INTO NUCANTIDAD;

                    IF NUCANTIDAD = 1
                    THEN
                        SBMENSAJE :=
                               'LA ORDEN ['
                            || TEMPCUVISITAACEPTACION.ORDER_ID
                            || '] CON TIPO DE TRABAJO ['
                            || TEMPCUVISITAACEPTACION.TASK_TYPE_ID
                            || '] NO ESTA LEGALIZADA.';
                        pkg_Traza.Trace (SBMENSAJE, 10);
                        RAISE EX_ERROR;
                    END IF;

                    CLOSE CUEXISTE;
                ELSIF TEMPCUVISITAACEPTACION.ORDER_STATUS_ID =
                      NUESTADO_CERRADO
                THEN
                    IF TEMPCUVISITAACEPTACION.CAUSAL_ID =
                       NUCAUSAL_CLIEN_CERTI_TERCER
                    THEN
                        NUVALIDO := 1;
                    END IF;
                END IF;
            END IF;

            CLOSE CUVISITAACEPTACION;

            ---FIN VALIDACION VISITA DE ACEPTACION
            --INICIO NC2353 VALIDACION CAUSAL VISITA DE ACEPTACION DE CERTIFICION
            IF NUVALIDO = 0
            THEN
                NUCAUSALCERTIFICATERCERO :=
                    DALD_PARAMETER.fnuGetNumeric_Value (
                        'CAUSAL_CERTIFI_TERCER',
                        NULL);
                --PERMITE INGRESAR A VALIDAR LOS ITEMS MIENTRAS LA CAUSAL DE
                --CERTIIFCACION ES DIFERENTE A CAUSAL CLIENTE CERTIFICA TERCERO
                pkg_Traza.Trace ('NUCAUSALC-->' || NUCAUSALC, 10);
                pkg_Traza.Trace (
                       'NUCAUSAL_CLIEN_CERTI_TERCER-->'
                    || NUCAUSAL_CLIEN_CERTI_TERCER,
                    10);
                pkg_Traza.Trace (
                    'NUCAUSALCERTIFICATERCERO-->' || NUCAUSALCERTIFICATERCERO,
                    10);

                IF     NUCAUSALC <> NUCAUSAL_CLIEN_CERTI_TERCER
                   AND NUCAUSALC IS NOT NULL
                THEN
                    --PERMITE INGRESAR A VALIDAR LOS ITEMS MIENTRAS LA CAUSAL DE
                    --CERTIIFCACION ES DIFERENTE A CERTIFICA TERCERO
                    IF     NUCAUSALC <> NUCAUSALCERTIFICATERCERO
                       AND NUCAUSALC IS NOT NULL
                    THEN
                        pkg_Traza.Trace (
                            'PROCOMPARAITEMSCERTEJE-NUORDENC-->' || NUORDENC,
                            10);

                        IF (NUORDENC IS NOT NULL)
                        THEN
                            --OBTIENE LA ORDEN DE APOYO ASOCIADA A LA SOLICITUD
                            OPEN CUORDENAPOYO (NUSOLICITUD, nuAddressID);

                            FETCH CUORDENAPOYO
                                INTO NUORDENAPOYO, NUTIPOTRABAP;

                            CLOSE CUORDENAPOYO;

                            SBGRUPOS :=
                                DALD_PARAMETER.fsbGetValue_Chain (
                                    'CODIGO_GRUPO_SOLICITUD_NUEVAS',
                                    NULL);

                            --VALIDAR DATOS DE APOYO Y DE REPARACION
                            IF (NUORDENAPOYO IS NOT NULL)
                            THEN
                                --COMPARA CANTIDADES DE ITEMS OT APOYO - OT REPARACION
                                SBITEMDIF :=
                                    LDC_BOORDENES.FNUCOMPARAITEMSCERTEJE (
                                        NUORDENLEGALIZADA,
                                        NUORDENAPOYO,
                                        SBGRUPOS,
                                        SBMENSAJE);
                            --VALIDA DATOS DE ORDEN DE CERTIFICACION Y NUEVAS
                            ELSIF (NUORDENC IS NOT NULL)
                            THEN
                                pkg_Traza.Trace (
                                    'PROCOMPARAITEMSCERTEJE-INGRESA POR OT CERTIFICACION',
                                    10);
                                pkg_Traza.Trace (
                                       'PROCOMPARAITEMSCERTEJE-SBGRUPOS-->'
                                    || SBGRUPOS,
                                    10);
                                pkg_Traza.Trace (
                                       'PROCOMPARAITEMSCERTEJE-NUORDENC-->'
                                    || NUORDENC,
                                    10);
                                pkg_Traza.Trace (
                                       'PROCOMPARAITEMSCERTEJE-NUTRABC-->'
                                    || NUTRABC,
                                    10);
                                --COMPARA CANTIDADES DE ITEMS OT CERTIFICACION - OT REPARACION
                                SBITEMDIF :=
                                    LDC_BOORDENES.FNUCOMPARAITEMSCERTEJE (
                                        NUORDENLEGALIZADA,
                                        NUORDENC,
                                        SBGRUPOS,
                                        SBMENSAJE);
                            END IF;

                            IF (SBITEMDIF = '-1')
                            THEN
                                RAISE EX_ERROR;
                            END IF;
                        ELSE
                            SBMENSAJE :=
                                'NO SE PUEDE LEGALIZAR LA ORDEN DE REPARACION. AUN NO SE HAN CERTIFICADO LAS REPARACIONES';
                            pkg_Traza.Trace (
                                   'PROCOMPARAITEMSCERTEJE-NO NUORDENC-->'
                                || SBMENSAJE,
                                10);
                            RAISE EX_ERROR;
                        END IF;
                    END IF; --FIN VALIDACION CAUSAL DIFERENTE A CERTIFICA TERCERO
                END IF;      --FIN VALIDACION CAUSAL CLIENTE CERTIFICA TERCERO
            END IF; --FIN NC 2353 VALIDACION CAUSAL VISITA DE ACEPTACION DE CERTIFICION
        END IF;
    EXCEPTION
        WHEN EX_ERROR
        THEN
            GI_BOERRORS.SETERRORCODEARGUMENT (LD_BOCONSTANS.CNUGENERIC_ERROR,
                                              SBMENSAJE);
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE;
    END PROCOMPARAITEMSCERTEJE;

    /*****************************************
    Metodo: FSBDATOITEMNUEVAS
    Descripcion:  Funcion que permite obtener el valor del dato adicional de la orden de
                  INSPECCION Y7O certificacion DE NUEVAS

    Autor: Jorge Valiente
    Fecha: 22 Julio 2014

    Fecha                IDEntrega           Modificacion
    ============    ================    ============================================
    11/11/2014      Jorge Valiente      NC 2936: Adicional en lso fitros de los cursores
                                                 validacion de la direccion para confirmar
                                                 que la orden de certificacion no tiene orden
                                                 de apoyo de la misma direccion y no tome otras
                                                 odenes de certiifcacion.
     ******************************************/
    FUNCTION FSBDATOITEMNUEVAS (nombDatAdd ge_attributes.name_attribute%TYPE)
        RETURN VARCHAR2
    IS
        --SOLICITUD ASOCIADA A LA ORDEN LEGALIZADA
        CURSOR CUSOLICITUD (NUORDEN OR_ORDER.ORDER_ID%TYPE)
        IS
            SELECT B.PACKAGE_ID, C.PACKAGE_TYPE_ID
              FROM OR_ORDER A, OR_ORDER_ACTIVITY B, MO_PACKAGES C
             WHERE     A.ORDER_ID = B.ORDER_ID
                   AND B.PACKAGE_ID = C.PACKAGE_ID
                   AND B.ORDER_ID = NUORDEN;

        --OBTIENE LA ULTIMA ORDEN DE CERTIFICACION ASOCIADA A LA SOLICITUD
        CURSOR CUORDENCERT (NUSOLIC      MO_PACKAGES.PACKAGE_ID%TYPE,
                            NUTRABAJOC   OR_ORDER.TASK_TYPE_ID%TYPE,
                            nuAddres     or_order_activity.address_id%TYPE)
        IS
            SELECT ORDER_ID,
                   TASK_TYPE_ID,
                   OPERATING_UNIT_ID,
                   CAUSAL_ID
              FROM (  SELECT A.ORDER_ID,
                             A.TASK_TYPE_ID,
                             B.OPERATING_UNIT_ID,
                             B.CAUSAL_ID
                        FROM OR_ORDER_ACTIVITY A, OR_ORDER B
                       WHERE     A.ORDER_ID = B.ORDER_ID
                             AND A.TASK_TYPE_ID = NUTRABAJOC
                             AND B.ORDER_STATUS_ID = 8
                             AND A.PACKAGE_ID = NUSOLIC
                             AND A.ADDRESS_ID = nuAddres
                    ORDER BY 1 DESC) ORDEN_CETIF
             WHERE ROWNUM = 1;

        --OBTIENE LA ORDEN DE APOYO DESDE LA SOLICITUD DE VENTA
        CURSOR CUORDENAPOYO (NUSOLICITUD   MO_PACKAGES.PACKAGE_ID%TYPE,
                             nuAddres      or_order_activity.address_id%TYPE)
        IS
            SELECT A.ORDER_ID, B.TASK_TYPE_ID
              FROM OR_ORDER A, OR_ORDER_ACTIVITY B
             WHERE     A.ORDER_ID = B.ORDER_ID
                   AND B.PACKAGE_ID = NUSOLICITUD
                   AND B.TASK_TYPE_ID =
                       DALD_PARAMETER.fnuGetNumeric_Value (
                           'COD_COR_DAT_LEG_CER_NUE',
                           NULL) --; --OT APOYO CORRECCION DATOS LEGALIZACION CERTIFICACION ASOCIADOS
                   AND A.LEGALIZATION_DATE =
                       (SELECT MAX (LEGALIZATION_DATE)
                          FROM (  SELECT O1.ORDER_ID,
                                         O1.CAUSAL_ID,
                                         O1.LEGALIZATION_DATE
                                    FROM OR_ORDER         O1,
                                         OR_ORDER_ACTIVITY OA1
                                   WHERE     OA1.ORDER_ID = O1.ORDER_ID
                                         AND O1.TASK_TYPE_ID =
                                             DALD_PARAMETER.fnuGetNumeric_Value (
                                                 'COD_COR_DAT_LEG_CER_NUE',
                                                 NULL)
                                         AND OA1.PACKAGE_ID = NUSOLICITUD
                                         AND OA1.ADDRESS_ID = nuAddres
                                         AND O1.CAUSAL_ID =
                                             DALD_PARAMETER.FNUGETNUMERIC_VALUE (
                                                 'COD_CAU_OT_LEG',
                                                 NULL)
                                ORDER BY 1 DESC) ORDEN_CERTIF); --OT APOYO CORRECCIONM DATOS DE LEGALIZ. CERTIF. NUEVAS.

        ---cursor para obtener la cantidad de datos en el parametro
        CURSOR cucantidaddatos (sbparametro VARCHAR2, sbcaracter VARCHAR2)
        IS
            SELECT COUNT (COLUMN_VALUE)
              FROM TABLE (
                       ldc_boutilities.splitstrings (sbparametro,
                                                          sbcaracter));

        nucucantidaddatos   NUMBER;
        NUORDENLEGALIZADA   OR_ORDER.ORDER_ID%TYPE;
        NUTIPOTRABR         OR_ORDER.TASK_TYPE_ID%TYPE;
        NUTIPOPAQ           MO_PACKAGES.PACKAGE_TYPE_ID%TYPE;
        NUSOLICITUD         MO_PACKAGES.PACKAGE_ID%TYPE;
        NUORDENC            OR_ORDER.ORDER_ID%TYPE;
        NUTRABC             OR_ORDER.TASK_TYPE_ID%TYPE;
        NUUNIOPERC          OR_ORDER.OPERATING_UNIT_ID%TYPE;
        NUCAUSALC           OR_ORDER.CAUSAL_ID%TYPE;
        NUORDENAPOYO        OR_ORDER.ORDER_ID%TYPE;
        NUTIPOTRABAP        OR_ORDER.TASK_TYPE_ID%TYPE;
        NUITEMMULTA         GE_ITEMS.ITEMS_ID%TYPE;
        NUTITRCERTIF        OR_TASK_TYPE.TASK_TYPE_ID%TYPE;
        NUORDENMULTA        OR_ORDER.ORDER_ID%TYPE;
        SBMENSAJE           VARCHAR2 (2000);
        SBITEMDIF           VARCHAR2 (2000);
        SBAPLICAMULTA       VARCHAR2 (2);
        SBGRUPOS            VARCHAR2 (20);
        EX_ERROR            EXCEPTION;

        arString            tbarray;
        nuAmount            NUMBER;
        I                   NUMBER;
        nuAddressID         or_order_activity.address_id%TYPE;
    BEGIN
        pkg_Traza.Trace ('INICIA LDC_BOORDENES.FSBDATOITEMNUEVAS', 10);
        --ORDEN NUEVA LEGALIZADA
        NUORDENLEGALIZADA := OR_BOLEGALIZEORDER.FNUGETCURRENTORDER; --11895946; --
        pkg_Traza.Trace (
            'FSBDATOITEMNUEVAS-ORDER LEGALIZADA-->' || NUORDENLEGALIZADA,
            10);

        --OBTENER LA DIRECCION DE LA ORDEN LEGALIZADA
        BEGIN
            SELECT address_id
              INTO nuAddressID
              FROM or_order_activity
             WHERE order_id = NUORDENLEGALIZADA AND ROWNUM = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
                nuAddressID := NULL;
        END;

        pkg_Traza.Trace (
            'Direccion de la Orden - nuAddressID-->' || nuAddressID,
            10);
        -------------------------------------------------------
        --SI LA ORDEN DE LA INSTANCIA ES DE REPARACION
        pkg_Traza.Trace ('FSBDATOITEMNUEVAS-NUTIPOTRABR-->' || NUTIPOTRABR,
                         10);
        pkg_Traza.Trace ('FSBDATOITEMNUEVAS-nombDatAdd-->' || nombDatAdd, 10);

        OPEN CUSOLICITUD (NUORDENLEGALIZADA);

        FETCH CUSOLICITUD INTO NUSOLICITUD, NUTIPOPAQ;

        CLOSE CUSOLICITUD;

        IF (NUSOLICITUD IS NOT NULL)
        THEN
            pkg_Traza.Trace ('FSBDATOITEMNUEVAS-SOLICITUD-->' || NUSOLICITUD,
                             10);
            pkg_Traza.Trace (
                'FSBDATOITEMNUEVAS-TIPO SOLICITUD-->' || NUTIPOPAQ,
                10);

            --VALIDO EL PAQUETE PARA SABER LA OT DE CERTIFICACION CORRESPONDIENTE
            IF (NUTIPOPAQ IS NOT NULL)
            THEN
                --SI LA SOLICITUD DE CERTIFICACION NUEVAS
                IF INSTR (
                       DALD_PARAMETER.FSBGETVALUE_CHAIN (
                           'CODIGO_TIPO_SOLICITUD_NUEVAS'),
                       TO_CHAR (NUTIPOPAQ)) >
                   0
                THEN
                    NUTITRCERTIF :=
                        DALD_PARAMETER.fnuGetNumeric_Value (
                            'COD_INSP_CERT_TASK_TYPE',
                            NULL);
                END IF;

                pkg_Traza.Trace (
                    'FSBDATOITEMNUEVAS-NUTITRCERTIF-->' || NUTITRCERTIF,
                    10);

                OPEN CUORDENCERT (NUSOLICITUD, NUTITRCERTIF, nuAddressID);

                FETCH CUORDENCERT
                    INTO NUORDENC,
                         NUTRABC,
                         NUUNIOPERC,
                         NUCAUSALC;

                CLOSE CUORDENCERT;
            END IF;

            pkg_Traza.Trace ('FSBDATOITEMNUEVAS-NUORDENC-->' || NUORDENC, 10);
            pkg_Traza.Trace ('FSBDATOITEMNUEVAS-NUTRABC-->' || NUTRABC, 10);

            IF (NUORDENC IS NOT NULL)
            THEN
                --OBTIENE LA ORDEN DE APOYO ASOCIADA A LA SOLICITUD
                OPEN CUORDENAPOYO (NUSOLICITUD, nuAddressID);

                FETCH CUORDENAPOYO INTO NUORDENAPOYO, NUTIPOTRABAP;

                CLOSE CUORDENAPOYO;

                SBGRUPOS :=
                    DALD_PARAMETER.fsbGetValue_Chain (
                        'CODIGO_GRUPO_SOLICITUD_NUEVAS',
                        NULL);

                IF SBGRUPOS IS NOT NULL
                THEN
                    --nuAmount := FsbGetAmount(SBGRUPOS, ',');
                    OPEN cucantidaddatos (SBGRUPOS, ',');

                    FETCH cucantidaddatos INTO nuAmount;

                    CLOSE cucantidaddatos;

                    arString := FsbGetArray (nuAmount, SBGRUPOS, ',');

                    --VALIDAR DATOS DE APOYO Y DE REPARACION
                    IF (NUORDENAPOYO IS NOT NULL)
                    THEN
                        pkg_Traza.Trace (
                            'ORDEN DE APOYO -->' || NUORDENAPOYO,
                            10);

                        FOR i IN 1 .. nuAmount
                        LOOP
                            IF     NVL (SBITEMDIF, '-1') = '-1'
                               AND TO_NUMBER (arString (I)) IS NOT NULL
                            THEN
                                pkg_Traza.Trace (
                                       'FSBDATOITEMNUEVAS-arString('
                                    || I
                                    || ')-->'
                                    || arString (I),
                                    10);
                                SBITEMDIF :=
                                    LDC_BOORDENES.FNUGETVALOROTBYDATADD (
                                        NUTRABC,
                                        TO_NUMBER (arString (I)),
                                        nombDatAdd,
                                        NUORDENC);
                            END IF;
                        END LOOP;
                    --VALIDA DATOS DE ORDEN DE CERTIFICACION Y NUEVAS
                    ELSIF (NUORDENC IS NOT NULL)
                    THEN
                        pkg_Traza.Trace (
                            'ORDEN DE CERTIFICACION -->' || NUORDENC,
                            10);

                        FOR i IN 1 .. nuAmount
                        LOOP
                            IF     NVL (SBITEMDIF, '-1') = '-1'
                               AND TO_NUMBER (arString (I)) IS NOT NULL
                            THEN
                                pkg_Traza.Trace (
                                       'FSBDATOITEMNUEVAS-arString('
                                    || I
                                    || ')-->'
                                    || arString (I),
                                    10);
                                SBITEMDIF :=
                                    LDC_BOORDENES.FNUGETVALOROTBYDATADD (
                                        NUTRABC,
                                        TO_NUMBER (arString (I)),
                                        nombDatAdd,
                                        NUORDENC);
                            END IF;
                        END LOOP;
                    END IF;
                ELSE
                    SBMENSAJE :=
                        'EL PARAMETRO CODIGO_GRUPO_SOLICITUD_NUEVAS NO TIENE INFORMACION VALIDA.';
                    pkg_Traza.Trace (
                        'FSBDATOITEMNUEVAS-NO NUORDENC-->' || SBMENSAJE,
                        10);
                    RAISE EX_ERROR;
                END IF;        --VALIDAR PARAMETRO DE CODIGO DE GRUPO DE ITEMS

                IF (SBITEMDIF = '-1')
                THEN
                    SBITEMDIF := NULL;
                END IF;
            END IF;
        END IF;

        pkg_Traza.Trace ('Dato Retornado SBITEMDIF --> ' || SBITEMDIF, 10);
        pkg_Traza.Trace ('FIN LDC_BOORDENES.FSBDATOITEMNUEVAS', 10);
        RETURN (SBITEMDIF);
    EXCEPTION
        WHEN EX_ERROR
        THEN
            GI_BOERRORS.SETERRORCODEARGUMENT (LD_BOCONSTANS.CNUGENERIC_ERROR,
                                              SBMENSAJE);
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            RAISE;
    END FSBDATOITEMNUEVAS;
END;
/

