create or replace package body pkServNumberMgr AS
--{
/*******************************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Package     :       pkServNumberMgr
    Descripcion :       Variables, procedimientos y funciones privados del
                        package

    Parametros  :               Descripcion
    Retorno     :

    Autor       :       Leonor Buenaventura
    Fecha       :       November 16 2001

    Historia de Modificaciones
    Fecha       ID Entrega
	Modificacion

    04-03-2013  dzunigaSAO203431 (28-02-2013  jvelasquezSAO203393)
    Estabilizacion: Modificacion metodo <<UpServNumberToWithDraw>>

    15-02-2013  mlozanoSAO201685
    Se elimina la variable nuESTAFINA.

    12-12-2012  dhurtadoSAO197798
    [
        Se modifica el metodo <ValWithoutNonAppPayClaim>
    ]

	28-11-2012 jcuervoSAO196967
	Se modifica el metodo <RetireRetiredWithFinan>
    Se eliminan los metodos  <ftbGetErrorProd> y <SetGlobalError>

    08-10-2012  abermudezSAO193346
    Se modifica el metodo GetProductsByContract

    30-08-2012  jllanoSAO189020 Ref: gvargasSAO160884
    Se agrega metodo <GetProductsByContract>

    31-05-2012 cramirezSAO182843
    Se elimina la funcion <fboWithSpecialServices>

    29-05-2012  dcardonaSAO181542
    Estabilizacion 7.7 ref. mramosSAO180130
    {
        Se adiciona el metodo <UpFraudProfile>
    }

    04-05-2012  hcruz.SAO177713
    Se elimina el metodo FBLEXISTPREMISE

    10-04-2012    mramosSAO179532
    Se modifican los metodos
        <InitializeBasicData>
        <CreateServNumberForWithDraw.FillRecord>
        <FillInputDataRecord>

    09-04-2012  jcuervoSAO175668
    Se crea la variable global "gtbProdErr".
    Se a?ade el metodo <ftbGetErrorProd>
    Se a?ade el metodo Privado <SetGlobalError>
    Se modifica el metodo <RetireRetiredWithFinan>

    23-03-2012  aylopezSAO175104
    Se modifican los cursores cuSubsServicesWithServ, cuSubsServices. Se modifica
    el metodo <fblGetSubsServices>.

    12/01/2012  hlopezSAO168675
    Se moficica el llamado al metodo <pkBCMevacode.fnuGetMethod> calculando la
    ubicaciones geografica a partir de la direccion de servsusc

    04-01-2012  yclavijo.SAO166076 Se elimina la cariable nuESTATECN
                                   Se modifica el metodo GetParameters
                                   Se elimina el metodo UpdServNumMeasuElemAddress
    09-05-2011  sgomezSAO150179
    Se introduce nuevo modelo de ubicacion geografica:
        - Se modifican los procedimientos
            *  <GenServSubsBasic>
            *  <FillInputDataRecord>

    07-06-2011  jgtorresSAO151257
    Se modifica el metodo <RetireRetiredWithFinan>.

    11-02-2011  jfrojasSAO139346
    Nivelacion SA0115181 (ref hnsanchez)
      Se modifican los metodos <ValTimeForBilling>, <fnuValTimeForBilling>.

    21/09/2010  lfernandezSAO128171
    <fboIsBillable> Se elimina validacion de suscripcion castigada

    16/09/2010  lfernandezSAO124550
    <fboIsBillable> Se elimina parametro SesuCast, se valida si la suscripcion
    tiene facturas castigadas

    Se eliminan los metodos:
    <InsRecordWithOutDefaultValues>
    <UpRecordWithoutDefaultValues>

    09-09-2010  druizSAO123836
    <fblValIsRetireServSusc>
    Se modifica la forma de validar si un producto esta conectado, de manera que
    no compare si el estado de corte del producto es igual a "CONECTADO", sino
    que verifique si dicho estado de corte es un estado activo.
    Se eliminan las referencias a <pkErrors.Push> y <pkErrors.Pop> por el llamado
    al procedimiento <UT_Trace.Trace>.

    <fboIsSuspended>
    Se modifica la forma de validar si un producto esta conectado, de manera que
    no compare si el estado de corte del producto es igual a "CONECTADO", sino
    que verifique si dicho estado de corte es un estado activo.
    Se eliminan las referencias a <pkErrors.Push> y <pkErrors.Pop> por el llamado
    al procedimiento <UT_Trace.Trace>.

    08-09-2010  dzunigaSAO126903
    Se modifica CURSOR <cuSubsServ>

    07-09-2010  dzunigaSAO120006
    Se modifica CURSOR <cuSubsServ>

    15-06-2010  aframirezSAO117789
    Se modifica el metodo <fblGetSubsServices>. Se modifican los cursores
    <cuSubsServices> y <cuSubsServicesWithServ>, se les adicionan los campos
    estado de corte y sistema.

    08-06-2010  jgtorresSAO117789
    Se modifica el metodo <fblServiceNumberOnTimePayment>.

    28-05-2010  cgarcia<SAO115817>
    <FillInputDataRecord>
    Se eliminan referencias de sesuprca y sesuenco
    <SetAcntRcvblInfo><fnuGetHistory><fnuGetHistCaCaAc> Se eliminan metodos

    19-05-2010  cfrancoSAO117754
    Se eliminan las referencias a sesufulf por cambio de esquema.

    06-05-2010   jllanoSAO114862
    Se agrega consulta de perfil de fraudes e insercion en sesuperf.

    07/04/2010  lfernandezSAO115741
    Se eliminan los metodos:
    <fblGetAccountRecords>
    <ClearMemory>
    <UpDateCollProgState>
    <SetCollection>
    <SetProductCollectProgram>
    <GetProduct>
    <GetSubscriber>
    <GetSuscripc>
    <fblEvaluaCondNum>
    <fblEvaluaCondicion>

    cgarcia Se elimina metodos
    <UpdCollectionProgram>

    <UpdCollectionProgram> Se elimina actualizacion del estado del programa de
    cartera
    En el metodo encapsulado <InitCollectGestion> se obtiene las facturas con
    saldo del contrato

    <SetAcntRcvblInfo> Se elimina la actualizacion del estado del programa de
    cartera en los metodos encapsulados:
    <SetOldDataOnNewService>
    <SetNullOnOldService>

    <FreeServNumber> En el metodo encapsulado <FillRecord> ya no se asigna el
    estado del programa de cartera

    <FreeServNumberChgStat> En el metodo encapsulado <FillRecord> ya no se
    asigna el estado del programa de cartera

    <frcFillRecordDefault> En el metodo encapsulado <FillRecord> ya no se asigna
    el estado del programa de cartera

    14-01-2010  aframirezSAO110035
    Nivelacion del SAO 91262:
        "Se modifica el CURSOR <cuSubsServices>, se elimina el decode, para suplir este
        cambio de crea el CURSOR <cuSubsServicesWithServ>. Se modifica el metodo
        <fblGetSubsServices>".

    14/01/2010  juasanchez106317  Se actualiza el metodo
                 <UpDateAccountCollector.FetchDynSQLStatment>

    16-Dic-2009 taraujo SAO109807
    Se adiciona el metodo UpdProdAccountColl. Se modifica el metodo UpdCollectionProgram
    (Ref. SAO92832)

    26-10-2008  cjaramilloSAO104553
    <ChangeNumServSuspendFinancing>
    Se modifica el procedimiento adicionando un parametro de entrada correspondiente
    a un flag que indica si el producto se encuentra retirado voluntariamente por
    peticion del cliente. De ser asi, actualiza el estado de corte del producto al
    estado de corte configurado en el parametro EST_FACT_CONVENIO_VOLUNTARIO
    (100 - CONVENIO DE PAGO RETIRO VOLUNTARIO).

    <RetireRetiredWithFinan>
    Se modifica el procedimiento para que actualice el estado de corte de los
    productos que se encuentren en estado retirado voluntariamente con financiacion
    y ya esten a paz y salvo, al estado de corte configurado en el parametro
    RETIRO_ATENCLIE (95 - ESTADO FINAL RETIRO ATENCION CLIENTE).


    06-10-2009  DBarragan SAO103746 Se modifica el metodo GenServSubsBasic y
    FillInputDataRecord. Se adiciona la variable global gnuDef_CompanyId.
    10-Feb-2009 jgtorresSAO88648
    <fnuValProdAccWithinRange>
    Se crea la funcion para validar que el numero de cuentas con saldo se encuentre
    dentro del rango especificado.

    30-01-2009  druizSAO88556
    <fnuProductWithService>
    Se modifica la consulta asociada al CURSOR <cuProduct> para que no tenga en
    cuenta la fecha de retiro y en su lugar, verifique que el estado del producto
    tenga activo el flag de producto activo

    <fnuValPendingBalRange>
    Se crea funcion para validar que el saldo pendiente del producto se encuentre
    dentro del rango especificado

    <GetSuscripc>
    Se modifica la funcion para que evalue el tipo de suscripcion especificado
    como criterio

    28-01-2009  druizSAO89604
    <pkServNumberMgr.UpdCollectionProgram.InitCollectGestion>
    Se reemplaza el llamado al procedimiento <pkBCAvanpcss.BorActividadesProd>
    por el llamado al procedimiento <pkAccReivAdvanceMgr.DelPendingActivities>

    26-01-2009  aframirezSAO89485
    Se modifica el metodo <ValAccNumBalRequest>.

    17-12-2008  lfernandezSAO86807
    <cuAccountServsusc> Se pasa dentro del metodo <fblGetAccountRecords> y se
    elimina parametro y se quita validacion del estado del programa de cartera

    <fblGetAccountRecords> Se elimina parametro estado del programa de cartera

    <FillInputDataRecord> Se valida que si encuentra programa de cartera para el
    tipo de cliente se lo asigna al producto

    <UpdCollectionProgram> En el metodo encapsulado <InitCollectGestion> se
    envia el tipo de producto al metodo <RegisterActivities>. Se elimina
    validacion de que el programa de cartera origen exista en PrcaTicl

    05-01-2009 hhammadSAO79711 (Cambios realizados por hrios en la solucion
                                operativa entregada con el SAO 79711)
    Se modifica:
        <fnuProductWithService>
        <GetProduct>
        <GetSuscripc>
        <GetSubscriber>
        <fnuGetExpiredBill>
    Se crea:
        <fblEvaluaCondNum>

    13-12-2008  hhammadSAO86953
    <UpdCollectionProgram>
    Se modifica la actualizacion de cartera: Se borran las actividades del programa
    de cartera anterior del producto y se programa las actividades del nuevo programa
    de cartera.

    03-12-2008  lfernandezSAO86953
    <FillInputDataRecord> Se adiciona obtencion del programa de cartera a partir
    del tipo de cliente

    16-Oct-2008 aochoaSAO84021
    Se modifica metodo <UpDateStatusSubsServ>.

    10-06-2008    cjaramilloSAO76735
    Se modifica en el procedimiento <FillInputDataRecord> el tipo de dato del registro
    "rcDireccionPars" de addrpars%rowtype a pktbladdrpars.cuAddrpars%rowtype.

    29-Abr-2008 cdominguSAO71632
    Se crean los siguientes metodos <fnuProductWithService>,<fnuGetHistory>,
    <fnuGetExpiredDaysAccounts>,>fnuGetExpiredBill>,<fnuGetHistCaCaAc>,
    <fnuValidateAvance>,<UpdCollectionProgram>,<SetCollection>,
    <SetProductCollectProgram>, <fblEvaluaCondicion>
    Se elimina el metodo <UpDateCollectionProgra>

    24-Abr-2008     lilianirSAO73881
    Se modifica el metodo <UpDateCollectionProgra>

    22-04-2008  spcastrillonSAO74677 - 73371
    Se modifica el metodo UpDateCollectionProgra.ProcessData, debe actualizarse
    el estado del programa en -1


    10-01-2008  mriveraSAO70474
    Se modifica para adicionar referencias al campo sesudiad.

    19-11-2007  jnogueraSAO67795
    Se adiciona <ValExistProdByCompany>

    26-09-2007  isinisteSAO65820 (Multiempresa)
    <FillInputDataRecord>

    17-07-2007 jcassoSAO62655
    Se modifica metodo fblGetSubsServices para poblar campo de bolsa (
    coleccion tbsesupane del registro tytbServNumber). Se modifica el cursor
    cuSubsServices para proyectar el campo sesupane.

    30-04-2007 jcassoSAO61975
    Se crea variable global gbDependingServices para almacenar el parametro
    MANEJA_SERV_DEMANDA. Se crea variable global para manejar la carga de
    los parametros (blIsLoaded). Entrega ultima version SAO 58141.

    02-03-2007  jnogueraSAO56734
    Se modifica <FillInputDataRecord>

    28-Mar-2006 Yclavijo SAO45736
    se modifican los metodos GenServSubsBasic y FillInputDataRecord para que reciba el ciclo de consumo.
    Este se asiganara en caso que no se encuentre otro ciclo de otra forma

    01-Dic-2005 HBossaSAO40563
    Incluir funcionalidad Productos dependientes indicando en el nuevo campo
    sesusesb de Servsusc el producto padre al que pertenece el producto
    dependiente  - <FillInputDataRecord>

    31-10-2005  isinisteSAO41873
    <GenServSubsBasic>
    <FillInputDataRecord>

    22-Sep-2005 jcastroSAO40318
    Se adiciona el servicio UpdActivaMobileLine.
    Open Cali.

    11-May-2005    cnaviaSAO37568
    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG.

    30-Mar-2005 aocacionSAO36775
    Se incrementa el indice del registro de los servicios suscritos
    adecuadamente.

    30-Mar-2005 aocacionSAO36762
    Se modifica RetireRetiredWithFinan:
    Se obtiene ultimo codigo de inconsistencia generado, para insertar
    inconsistencias desde este numero.
    Se agrega commit por cada servicio suscrito procesado correctamente.

    23-Mar-2005 aocacionSAO36448
    Se agrega metodo: RetireRetiredWithFinan, fblWithPositiveBalance,
    ChangeNumServSuspendFinancing.

    17-10-2004  isinisteSAO31895
    Se crea el metodo fblServiceNumberOnTimePayment.

    22-Jun-2004 lbuenaveSAO30126
    Se modifica metodo FillInputDataRecord.

    16-Jun-2004 isinisteSAO30231
    Se modifica el metodo UpServNumberToWithDraw
    Se recibe el parametro iboVoluntary para indicar si es un retiro voluntario
    y se actualiza el servicio dependiendo del valor del parametro.

    07-Jun-2004 jferreroSAO29928
    [cuSubsServices] Cursor para obtener servicios suscritos de una suscripcion
    [fblGetSubsServices] Servidor de Datos para obtener BULK de Servicios
    Suscritos asociados a una suscripcion.

    12-Ene-2003 jcastroSAO26751
    Se modifica el servicio frcFillRecordDefault en su metodo encapsulado
    FillRecord. Open Cali.

    13-Dic-2003 DescobarSAO24526
    Se modifica el metodo GenServSubsBasic

    22-MAY-2002 osilvaSAO11002
    Se adiciono el parametro socio

    03-DIC-2001 osilvaOP8689
    Se adiciono metodos ValInputData,FillInputDataRecord,GetParameters
    para insertar un registro servicio suscrito con sus datos basicos

    16-11-2001  lbuenaveSAE6461
    Creacion del objeto.
*******************************************************************************/
    ----------------------------------------------
    -- Package's Elements
    ----------------------------------------------

    ----------------------------------------------
    -- CONSTANTES --------------------------------
    ----------------------------------------------
    nuBulkNum  NUMBER := 100; --Limite del bulk


    -----------------------
    -- Private Variables
    -----------------------
    sbErrMsg            ge_error_log.description%type;   -- Mensaje de Error
    nuErrCode           ge_error_log.error_log_id%type;  -- Codigo de Error
    rcServsusc          servsusc%rowtype;
    rcRecordNull        servsusc%rowtype;
    nuRowid             rowid;

    -- Estan cargados los Parametros?.
    blIsLoaded          boolean := FALSE;

    gbDependingServices CHAR(1) := NULL;

    -- Definicion tablas servsusc
    gtbSesunuse    pktblServsusc.tySesunuse ;

    -- Criterios para Subscriber
    gtbFilterSubscriber        ut_string.TyTb_String;
    -- Criterios para Subscription
    gtbFilterSubscription      ut_string.TyTb_String;
    -- Criterios para Product
    gtbFilterProduct           ut_string.TyTb_String;
    -- Empresa por defecto
    gnuDef_CompanyId           NUMBER := ge_boparameter.fnuGet('DEFAULT_COMPANY');

    -- Memoria para los ultimos productos cargados --
    gnuContractMem             servsusc.sesususc%type;
    gtbServsuscMem             tytbServsusc;

    --------------------------------------------------------------------
    -- Private Constants
    --------------------------------------------------------------------
    -- El servicio suscrito tiene cargos de Terceros a la -1
    cnuCARGTERCCUCONULA constant number := 12043;

    CURSOR cuTipocons is
    SELECT tconcodi
      FROM tipocons
     WHERE tconcodi <> pkConstante.NULLNUM;


    -- 08-09-2010  dzunigaSAO126903
    -- Se modifica CURSOR <cuSubsServ> para eliminar filtrar por productos no simulados

    -- 07-09-2010  dzunigaSAO120006
    -- Se modifica CURSOR <cuSubsServ> para filtrar por productos no simulados
    cursor cuSubsServ
    (
        inuSusc    servsusc.sesususc%type
    )
    IS
        SELECT sesunuse FROM servsusc
         WHERE sesususc = inuSusc;

    -- Cursor para obtener los servicios suscritos de un suscriptor
    -- Mayores a SesuMin
    CURSOR cuSubsServices
    (
        inuSusccodi  in  servsusc.sesususc%type,
        inuSesuMin   in  servsusc.sesunuse%type
    ) IS
    SELECT rowid   , sesunuse, sesuserv, sesuplfa, sesususc, sesudepa, sesuloca,
           sesucate, sesusuca, sesuclpr, sesusesg, sesufein, sesufere,
           sesuboui, sesucico, sesuesco, sesusist, sesucicl, sesumult
    FROM   servsusc
    WHERE  sesususc = inuSusccodi
    AND    sesunuse > inuSesuMin;

    CURSOR cuSubsServicesWithServ
    (
        inuSusccodi  in  servsusc.sesususc%type,
        inuSesunuse  in  servsusc.sesunuse%type
    ) IS
    SELECT rowid   , sesunuse, sesuserv, sesuplfa, sesususc, sesudepa, sesuloca,
           sesucate, sesusuca, sesuclpr, sesusesg, sesufein, sesufere,
           sesuboui, sesucico, sesuesco, sesusist, sesucicl, sesumult
    FROM   servsusc
    WHERE  sesususc = inuSusccodi
    AND    sesunuse = inuSesunuse;

    CURSOR cuServsusc ( inuRowid        in      rowid)
    IS
    SELECT *
    FROM servsusc
    WHERE rowid = inuRowid;

    -----------------------
    -- Constants
    -----------------------
    cnuRECORD_YA_EXISTE constant number := 216 ; -- Reg. ya esta en BD
    cnuRECORD_NO_EXISTE constant number := 6021; -- Reg. no esta en BD
    csbDIVISION         constant varchar2(20) := pkConstante.csbDIVISION;
    csbMODULE           constant varchar2(20) := pkConstante.csbMOD_SAT;
    CACHE               constant number := 1;   -- Buscar en Cache

    -- Numero de ultimo sao entregado
    csbVersion   CONSTANT VARCHAR2(250) := 'SAO257783';

    ----------------------------------------------
    -- Private Methods
    ----------------------------------------------
    PROCEDURE FillInputDataRecord
    (
        inuSesuServ in servsusc.sesuserv%type             ,
        inuSesuSusc in servsusc.sesususc%type             ,
        inuSesuCate in servsusc.sesucate%type             ,
        inuSesuSuca in servsusc.sesusuca%type             ,
        idtSesuFein in servsusc.sesufein%type             ,
        inuSesuPlfa in servsusc.sesuplfa%type             ,
        inuSesuCodi in servsusc.sesunuse%type             ,
        isbSesuImld in servsusc.sesuimld%type             ,
        idtSesuFeRe in servsusc.sesufere%type             ,
        inuSesuEsco in servsusc.sesuesco%type default null,
        isbSesuRoga in servsusc.sesuroga%type default null,
        isbSesuRoca in servsusc.sesuclpr%type default null,
        inuSesumult in servsusc.sesumult%type default 1   ,
        orcServsusc out servsusc%rowtype,
        inuSesucico in servsusc.sesucico%type default null,
        inuSesuCain in servsusc.sesucain%type default null,
        inuSesuDiad in servsusc.sesudiad%type default -1,
        inuSesulicr in servsusc.sesulicr%type default null,
        inuSesuSist IN servsusc.sesusist%type default NULL
    ) ;
    --Obtiene los parametros
    PROCEDURE GetParameters ;

    procedure AccKey
        (
            inuRowid    in      rowid,
            inuCACHE    in      number default 1
        ) ;
    function fblInMemory
        (
            inuRowid    in      rowid
        )
    return boolean ;

    procedure LoadRecord
    (
        inuRowid           in   rowid
    ) ;
    procedure Load
    (
        inuRowid           in   rowid
    ) ;

/*
    Propiedad intelectual de Open International Systems. (c)
    Procedure     : ClearGlobalMemory
                    Clear Global Memory
    Descripcion   : Limpia memoria global
    Parametros    :       Descripcion
    Retorno       :
    Autor         : rcalixto
    Fecha         : 08-AGO-04
    Historia de Modificaciones
    Fecha          IDEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    08-08-2004    rcalixtoSAO29223

    Creacion
*/
PROCEDURE ClearGlobalMemory
IS
BEGIN
    pkErrors.Push('pkServNumberMgr.ClearGlobalMemory');
    pkErrors.pop;
EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ClearGlobalMemory;
/*******************************************************************************
    Propiedad Intelectual de Open International Systems (c).
    Procedure    : FillInputDataRecord
    Descripcion    : Llena con datos de entrada el registro del Servicio
          Suscripto

    Parametros    :         Descripcion
        inuSesuServ         Servicio
        inuSesuSusc         Suscripcion
        inuSesuCate         Categoria
        inuSesuSuca         SubCategoria
        idtSesuFein         Fecha Inicial del Servicio
        inuSesuPlfa         Plan de Facturacion
        inuSesuCodi         Numero de servicio
        isbSesuImld         Flag de si impreme larga distancia
        idtSesuFeRe         Fecha de retiro
        inuSesuEsco         Estado de corte
        isbSesuRoga         Rol de la garantia
        isbSesuRoca         Clase de producto
        inuSesumult         Multifamiliar
        inuSesucico         Ciclo de consumo  servsusc
        inuSesuCain         Carga instalada
        inuSesuDiad         Distribucion administrativa
        inuSesulicr         Limite de credito
        inuSesuSist         Empresa prestadora del servicio

    Retorna    :
        orcServSusc    Registro de Servicio suscripto.

    Autor    : osilva
    Fecha    : 03-DIC-2001

    Historia de Modificaciones
    Fecha       ID Entrega
    10-04-2012    mramosSAO179532
    Se modifica para incluir el campo "Estado Financiero" en la creacion de
    producto

    12/01/2012  hlopezSAO168675
    Se moficica el llamado al metodo <pkBCMevacode.fnuGetMethod> calculando la
    ubicaciones geografica a partir de la direccion de servsusc

    15-05-2010  amendezSAO115254
    Se cambia los parametros de entrada
        inusesudebi por inusesudepa
        inusesulobi por inusesuloca
    por eliminacion de los campos sesudebi y sesulobi de servsusc.

    06-10-2009  DBarragan SAO103746 Se adiciona el parametro empresa.
    18-12-2008  lfernandezSAO86807
    Se valida que si encuentra programa de cartera para el tipo de cliente se lo
    asigna al producto

    03-12-2008  lfernandezSAO86953
    Se adiciona obtencion del programa de cartera a partir del tipo de cliente

    10-06-2008    cjaramilloSAO76735
    Se modifica el tipo de dato del registro "rcAddrpars" de addrpars%rowtype a
    pktbladdrpars.cuAddrpars%rowtype.

    26-09-2007  isinisteSAO65820 (Multiempresa)
    Se asigna a la empresa del producto la empresa del usuario que ejecuta el
    proceso.

    02-03-2007  jnogueraSAO56734
    Se adiciona el tipo de producto como parametro para obtener el metodo de
    variacion de consumo.

    30-Ago-2006 Miguel A. Arenas R. SAO 46553 : Se adicionan parametros de
    entrada para los campos SesuEsco y SesuCain.

    01-Dic-2005 HBossaSAO40563
    Asignacion del valor -1 al campo Servsusc.Sesusesb (servicio suscrito base)

    31-10-2005  isinisteSAO41873
    Se recibe el numero de unidades habitacionales (inuSesumult).

    11-MAY-05   cnaviaSAO37568
    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG.

    01-abr-2005 avalenciaSAO36805
    Se adiciona el calculo para el metodo de analisis de variacion de consumo.

    28-Jun-2004 lilianirSAO30296
    Se adicionan 3 parametros de entrada para el registro ( sesuesco,
    sesuroga, sesuroca ).

    22-Jun-2004 lbuenaveSAO30126
    Se elimina asignacion a sesudipr. Este campo no debe tener valor porque se
    utiliza para el proceso de inclusion en corte.

    06-Feb-2004 DescobarSAO26937
    Se modifica para que en los campos privados asigne:
        nombre privivado         = nombre de usuario
        Direccion Privada        = Direccion de instalacion
        Direccion de Instalacion = Direccion de instalacion

    18-Jun-2003 mfmorenoSAO22133
    Se adiciona el parametro de Fecha de Retiro, en caso de ser nulo
    se ASigna el maximo de ORacle

    14-abr-2003    cquinteroSAO19750
    Se adiciona el telefono garante (sesutefa)

    05-AGO-2002 osilvaSAO12107
    Se adiciono asignacion alos campos de sesudepa,susucloca
    los valores de sus similares de instalacion para evitar que quedaran
    en nulos

    22-MAY-2002 osilvaSAO11002
    Se adiciono el parametro socio

    22-ENE-2002 osilvaSAE8431
    Se adiciono Asignacion de parametros de estados tecnico y servicio

    03-DIC-2001 osilvaOP8689
    Creacion del objeto.

*******************************************************************************/
PROCEDURE FillInputDataRecord
(
    inuSesuServ in servsusc.sesuserv%type             ,
    inuSesuSusc in servsusc.sesususc%type             ,
    inuSesuCate in servsusc.sesucate%type             ,
    inuSesuSuca in servsusc.sesusuca%type             ,
    idtSesuFein in servsusc.sesufein%type             ,
    inuSesuPlfa in servsusc.sesuplfa%type             ,
    inuSesuCodi in servsusc.sesunuse%type             ,
    isbSesuImld in servsusc.sesuimld%type             ,
    idtSesuFeRe in servsusc.sesufere%type             ,
    inuSesuEsco in servsusc.sesuesco%type default null,
    isbSesuRoga in servsusc.sesuroga%type default null,
    isbSesuRoca in servsusc.sesuclpr%type default null,
    inuSesumult in servsusc.sesumult%type default 1   ,
    orcServsusc out servsusc%rowtype,
    inuSesucico in servsusc.sesucico%type default null,
    inuSesuCain in servsusc.sesucain%type default null,
    inuSesuDiad in servsusc.sesudiad%type default -1,
    inuSesulicr in servsusc.sesulicr%type default NULL,
    inuSesuSist IN servsusc.sesusist%type default NULL
)
IS
   -- Almacena la ubicacion geografica del producto
    nuProductUbiGeoLOC      number;

    -- Direccion del producto
    nuProductAddress        number;

BEGIN

    pkErrors.push('pkServNumberMgr.FillInputDataRecord');

    -- !!!SANTIMAN
    -- !!!Debe pasar un codigo de ubicacion geografica
    orcServsusc.sesudepa := -1;
    orcServsusc.sesuloca := -1;

    -- Se llena registro con datos defaults.
    orcServsusc := pkServNumberMgr.frcFillRecordDefault;

    -- Se llena registro con datos de entrada.
    orcServsusc.sesunuse := inuSesuCodi;
    orcServsusc.sesuserv := inuSesuServ;
    orcServsusc.sesususc := inuSesuSusc;
    orcServsusc.sesucate := inuSesuCate;
    orcServsusc.sesusuca := inuSesuSuca;
    orcServsusc.sesuplfa := inuSesuPlfa;
    orcServsusc.sesucico := inuSesucico;
    orcServsusc.SesuCain := inuSesuCain;
    orcServsusc.SesuDiad := inuSesuDiad;
    orcServsusc.Sesulicr := inuSesulicr;
    -- Si las fechas son nulas asigna la maxima fecha permitida por Oracle.
    orcServsusc.sesufein := nvl(idtSesuFein,pkGeneralServices.fdtGetMaxDate);
    orcServsusc.sesufere := nvl(idtSesuFeRe,pkGeneralServices.fdtGetMaxDate);

    -- Setea los estados de acuerdo a los parametros.
    if ( inuSesuEsco is null ) then
        orcServsusc.sesuesco := nuESTACORT;
    else
        orcServsusc.sesuesco := inuSesuEsco ;
    end if;

    -- Asigna el flag de impresion de larga distancia y la central.
    orcServsusc.sesuImld := upper(isbSesuImld);


    -- Valores utilizados para el roll de la garantia y del contrato.
    orcServsusc.sesuroga := isbSesuRoga;
    orcServsusc.sesuclpr := isbSesuRoca;

    -- Se calcula la ubicacion a nivel LOC del producto
    nuProductAddress := dapr_product.fnugetaddress_id( inuSesuCodi );
    nuProductUbiGeoLOC := daab_address.fnuGetGeograp_Location_Id( nuProductAddress );


    orcServsusc.sesumecv := pkBCMevacode.fnuGetMethod
                            (
                                inuSesuSuca,
                                inuSesuCate,
                                nuProductUbiGeoLOC,
                                inuSesuserv
                            );


    -- Asigna -1 al campo de servicio suscrito base (Productos dependientes)
    orcServsusc.sesusesb := pkConstante.NULLNUM ;

    -- Numero de unidades habitacionales.
    orcServsusc.sesumult := inuSesumult;

    -- Empresa.
    orcServsusc.Sesusist := nvl(inuSesuSist, gnuDef_CompanyId);

    -- Perfil
    orcServsusc.sesuperf := LE_BOServiciosFraudes.fnuObtenerPerfil(
                                                                   inuSesuSusc,
                                                                   inuSesuCodi,
                                                                   inuSesuServ
                                                                   );

    -- Estado Financiero
    orcServsusc.sesuesfn := pkbillconst.csbEST_AL_DIA;

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
        pkErrors.pop;
        raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        -- Error Oracle nivel dos
        pkErrors.pop;
        raise pkConstante.exERROR_LEVEL2;
    when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);
END FillInputDataRecord;

/*
    Propiedad intelectual de Open International Systems (c).
    Procedure       :       GetParameters
    Descripcion     :       Obtiene el valor de parametros generales
                GetParameters
    Parametros      :       Descripcion
    Retorno         :
    Autor           :       osilva
    Fecha           :       03-DIC-2001
    Historia de Modificaciones
    Fecha       IDEntrega
    04-01-2012  yclavijo.SAO166076 Se elimina la variable nuESTATECN
    30-04-2007 jcassoSAO61975
    Se establece variable global gbDependingServices con parametro
    MANEJA_SERV_DEMANDA. Se adiciona manejo de variable para indicar que los
    parametros ya fueron cargados(blIsLoaded). Entrega ultima version SAO 58141.

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    22-ENE-2002 osilvaSAE8431

    Se adiciono obtencion de parametros de estados tecnico y servicio
    03-DIC-2001 osilvaOP8689
    Creacion del objeto
    Modificacion
*/
PROCEDURE GetParameters is
BEGIN
    pkErrors.Push('pkServNumberMgr.GetParameters');

    IF ( blIsLoaded ) THEN

        pkErrors.Pop;
        RETURN;

    END IF;

    --obtiene el parametro Estado de Corte
    nuESTACORT := pkGeneralParametersMgr.fnuGetNumberValue
                                ('EST_SERVICIO_SIN_CORTE');

    -- obtiene el parametro Estado sin suspension
    nuESTASUSP := pkGeneralParametersMgr.fnuGetNumberValue
                                ('EST_SERVICIO_SIN_SUSPENSION');

    -- obtiene el parametro Estado Telefono Activo
    nuESTASERV := pkGeneralParametersMgr.fnuGetNumberValue
                                ('TELEF_ACTIVO');

    -- Obtener parametro que indica si el sistema maneja productos dependientes
    gbDependingServices := pkGeneralParametersMgr.fsbGetStringValue
                                ('MANEJA_SERV_DEMANDA');

    blIsLoaded := TRUE;

    pkErrors.Pop;

EXCEPTION

    WHEN LOGIN_DENIED THEN
        blIsLoaded := FALSE;
        pkErrors.pop;
        RAISE LOGIN_DENIED;

     when pkConstante.exERROR_LEVEL2 then
        blIsLoaded := FALSE;
        -- Error Oracle nivel dos
        pkErrors.pop;
        RAISE pkConstante.exERROR_LEVEL2;

     WHEN OTHERS THEN
        blIsLoaded := FALSE;
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);
END GetParameters;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    AccCurrentPeriod
    Descripcion    :    Accesa el Periodo current de la Suscripcion del
            servicio suscrito
            Access Current Period
    Parametros    :    Descripcion
    inuNumeServ    Numero del servicio suscrito
    onuPeriodoCurr    Codigo del Periodo de Facturacion Current
    inuCACHE    Indicador de memoria cache
            0 - No busca en cache
            1 - Busca en cache primero
    Retorno    :
    Autor    :    Carlos Alberto Quintero
    Fecha    :    Septiembre 20 del 2000
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    20.sep.2000    Caq    Creacion del procedimiento

*/
PROCEDURE AccCurrentPeriod
    (
    inuNumeServ    in    servsusc.sesunuse%type,
    onuPeriodoCurr    out    perifact.pefacodi%type,
    inuCACHE    in    number default pkConstante.CACHE
    )
    IS
    nuSuscripcion    servsusc.sesususc%type;    -- Codigo suscripcion
BEGIN
    pkErrors.Push('pkServNumberMgr.AccCurrentPeriod');
    -- Obtiene la suscripcion
    nuSuscripcion := pktblServsusc.fnuGetSuscription
                    (
                        inuNumeServ,
                        inuCACHE
                    );
    -- Accesa periodo de facturacion current para la suscripcion dada
    pkSubscriberMgr.AccCurrentPeriod
    (
        nuSuscripcion,
        onuPeriodoCurr,
        inuCACHE
    );
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END AccCurrentPeriod;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    AccCurrentPeriod_rc
    Descripcion    :    Accesa el Periodo current de la Suscripcion del
            servicio suscrito
            Accesa el registro completo del periodo de facturacion
            current
            Access Current Period
    Parametros    :    Descripcion
    inuNumeServ    Numero del servicio suscrito
    orcPeriFact    Record del Periodo de Facturacion Current
    inuCACHE    Indicador de memoria cache
            0 - No busca en cache
            1 - Busca en cache primero
    Retorno    :
    Autor    :    Carlos Alberto Quintero
    Fecha    :    Septiembre 20 del 2000
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    20.sep.2000    Caq    Creacion del procedimiento

*/
PROCEDURE AccCurrentPeriod
    (
    inuNumeServ    in    servsusc.sesunuse%type,
    orcPeriFact    out    perifact%rowtype,
    inuCACHE    in    number default pkConstante.CACHE
    )
    IS
    nuSuscripcion    servsusc.sesususc%type;    -- Codigo suscripcion
BEGIN
    pkErrors.Push('pkServNumberMgr.AccCurrentPeriod');
    -- Obtiene la suscripcion
    nuSuscripcion := pktblServsusc.fnuGetSuscription
                    (
                        inuNumeServ,
                        inuCACHE
                    );
    -- Accesa periodo de facturacion current para la suscripcion dada
    pkSubscriberMgr.AccCurrentPeriod
    (
        nuSuscripcion,
        orcPeriFact,
        inuCACHE
    );
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END AccCurrentPeriod;

/*
    Propiedad intelectual de Open Systems (c).
    Function    :    CopyServNumForOtherService
    Descripcion    :    Crea copia de un servicio suscrito a partir de uno base
            -- Clona un servicio suscrito base
            -- Actualiza el numero de servicio del servicio
            suscrito clonado
            -- Inserta en la base de datos el nuevo servicio
            suscrito
    Parametros    :    Descripcion
    inuNuseBase     Numero de Servicio suscrito base
    inuServNuev     Numero del nuevo Servicio
    onuNuseNuev     Numero del servicio suscrito que se a creado
    Retorno    :
    Autor    :    Omar Lopez
    Fecha    :    16-Ene-2002
    Historia de Modificaciones
    Fecha    Autor        Modificacion

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    19-May-2003    rcalixtoSAO21182
    Para inicializar los datos basicos se usa el metodo InitializeBasicData.

    06-Nov.2002 kmarcosSAO15994.01
    Se inicializan los campos que no deben ser copiados del servicio suscrito
    base.
    16-Ene-2002 olopezOP8906.03
    Creacion del objeto.
*/

PROCEDURE CopyServNumForOtherService
    (
    inuNuseBase     in      servsusc.sesunuse%type,
    inuServNuev     in      servicio.servcodi%type,
    onuNuseNuev     out     servsusc.sesunuse%type
    )
IS
    -----------------
    -- VARIABLES
    -----------------

    -- Record Tabla Servsusc
    rcServsuscClone      Servsusc%rowtype;

BEGIN
--{

    pkErrors.Push ('pkServNumberMgr.CopyServNumForOtherService');

    -- Clona el servicio suscrito base
    rcServsuscClone := frcCloneServNumber ( inuNuseBase,
                        pkConstante.CACHE );

    -- Actualiza el numero de servicio del servicio suscrito clonado
    rcServsuscClone.sesuserv := inuServNuev;

    -- Inicializa datos basicos
    InitializeBasicData ( rcServsuscClone );

    -- Inserta en la base de datos el nuevo servicio suscrito
    pktblServsusc.InsRecord ( rcServsuscClone );

    -- Setea el parametro de salida del nuevo servicio suscrito
    onuNuseNuev := rcServsuscClone.sesunuse;

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
END CopyServNumForOtherService;


/*
    Propiedad intelectual de Open Systems (c).
    Procedimiento :    CreateServNumberForWithDraw
    Descripcion   :    Crear numero de servicio basado en un telefono que se
            va retirar
    Parametros    :    Descripcion
        inuNumeServ        Numero de servicio a retirar
    Retorno    :
    onuSesuNuev        Nuevo numero de servicio
    Autor    :    rcalixto
    Fecha    :    03-Nov-2000
    Historia de Modificaciones
    Fecha    Id Entrega
    10-04-2012    mramosSAO179532
    Se modifica para incluir el campo "Estado Financiero" en la creacion de
    producto

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    26-Nov-2003    lilianirSAO25831
    Habilita manejo de cache para parametros.

    25-Nov-2003    lilianirSAO25558
    Se elimina en el retiro la actualizacion del plan de facturacion del servicio
    suscrito con el valor del parametro PLAN_FACT_RETIRADOS, se deja el plan de
    facturacion ORiginal. Por lo tanto ya no es necesario obtener el valor de
    este parametro.


    20-Ago-2003 mfmorenoSAO23046
    Se adiciona el parametro iblRetiroVolun por defaul en FALSE, para
    manejar el estado de corte en el que queda el servicio cuando
    el retiro es voluntario o por no pago.

    13-Ago-2002 kmarcosSAO13354.01
    Se crea el nuevo numero de servicio con fecha de estado de corte igual
    a la fecha del sistema. Anteriormente dejaba la fecha del estado de
    corte anterior. Se iguala la fecha de retiro, aunque no se utiliza.
    Fecha    Autor    Modificacion
    09.may.2001    Caq    Se guarda el telefono que se va a retirar como

            telefono anterior.
*/
PROCEDURE CreateServNumberForWithDraw
(
    inuNumeServ    in  servsusc.sesunuse%type,
    onuSesuNuev    out servsusc.sesunuse%type,
    iblRetiroVolun in  boolean default FALSE
) IS

    sbErrorMsg              varchar2(2000)         ; -- Mensaje error.
    sbNULLSB                varchar2(1)            ; -- Nulo string.
    nuNULLNUM               number                 ;
    nuTEL_RET_DEF           estacort.escocodi%type ;
    nuINICIORETIRO_ATENCLIE estacort.escocodi%type ;
    nuPLAN_RETIRA           plansusc.plsucodi%type ;

    /* ********************************************************** */
    /*                  Metodos Encapsulados                      */
    /* ********************************************************** */
    /*--------------------------------------------------------------------------
    Procedure    :    GetParameters
    Descripcion    :    Obtiene parametros
    --------------------------------------------------------------------------*/
    PROCEDURE GetParameters
    IS
    BEGIN
        pkErrors.Push('pkServNumberMgr.GetParameters');

        -- Habilita manejo de cache para parametros
        pkGrlParamExtendedMgr.SetCacheOn;

        -- Obtiene el parametro RETIRO_LINEA_POR_NO_PAGO.
        nuTEL_RET_DEF := pkGeneralParametersMgr.fnuGetNumberValue
                         ('RETIRO_LINEA_POR_NO_PAGO');

        -- Obtiene el parametro RETIRO_LINEA Voluntario.
        nuINICIORETIRO_ATENCLIE := pkGeneralParametersMgr.fnuGetNumberValue
                                   ('INICIORETIRO_ATENCLIE');

        -- Obtiene el parametro NULLSB
        sbNULLSB :=pkGeneralParametersMgr.fsbGetStringValue('NULLSB');
        -- Obtiene el parametro NULLNUM
        nuNULLNUM :=pkGeneralParametersMgr.fnuGetNumberValue('NULLNUM');

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
    END GetParameters;
    /*--------------------------------------------------------------------------
    Procedure    :    FillRecord
    Descripcion    :    Llena registro de servsusc
    --------------------------------------------------------------------------*/
    PROCEDURE FillRecord
    (
        iorcServsusc    in out   servsusc%rowtype,
        inuSesuNuev        in         servsusc.sesunuse%type
    )
    IS
      --  nuEstaServ        servsusc.sesuessv%type ;
    BEGIN
        pkErrors.Push('pkServNumberMgr.FillRecord');
        -- Campos actualizar
        -- Guarda el telefono anterior
        iorcServsusc.sesunuse := inuSesuNuev ;
        iorcServsusc.sesuboui := nuNULLNUM ;
        -- En caso de ser retiro voluntario
        iorcServsusc.sesuesco := nuTEL_RET_DEF ;
        if ( iblRetiroVolun ) then
           iorcServsusc.sesuesco := nuINICIORETIRO_ATENCLIE ;
        end if;

        iorcServsusc.sesufeco := pkGeneralServices.fdtGetSystemDate ;
        iorcServsusc.sesufere := pkGeneralServices.fdtGetSystemDate ;

        -- Estado Financiero
        iorcServsusc.sesuesfn := pkbillconst.csbEST_AL_DIA;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
    END FillRecord;
    /*--------------------------------------------------------------------------
    Procedure    :    Process
    Descripcion    :    Libera numero de servicio
    --------------------------------------------------------------------------*/
    PROCEDURE Process
    IS
        rcServsusc servsusc%rowtype ;    -- Registro servsusc
        nuSesuNuev servsusc.sesunuse%type ;
    BEGIN
        pkErrors.Push('pkServNumberMgr.FreeServiceNumber');
        -- Evalua si el numero de servicio es el nulo del aplicativo
        if ( inuNumeServ = pkConstante.NULLNUM ) then
            pkErrors.Pop;
            return ;
        end if ;

        -- Obtiene el registro de servsusc
        rcServsusc := pktblServsusc.frcGetRecord
                      (
                        inuNumeServ,
                        pkConstante.NOCACHE
                      );

        -- Obtiene el proximo numero de secuencia para servsusc
        nuSesuNuev := pkServNumberMgr.fnuGetNextServNumber ;

        -- Llena el registro de servsusc
        FillRecord ( rcServsusc, nuSesuNuev );

        -- Actualiza el numero de servicio
        pktblServsusc.InsRecord ( rcServsusc );

        -- Asigna el nuevo numero a la variables de salida
        onuSesuNuev := nuSesuNuev ;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
    END Process;
    ----------------------------------------------------------------------------
BEGIN
    pkErrors.Push ('pkServNumberMgr.CreateServNumberForWithDraw');

    -- Obtiene parametros.
    GetParameters ;

    -- Liberar numero de servicio.
    Process ;

    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END CreateServNumberForWithDraw;


/*
    Propiedad intelectual de Open Systems (c).
    Procedimiento :    FreeServNumber
    Descripcion   :    Libera numero de servicio dado como parametro
    Parametros    :    Descripcion
    Retorno    :
    Autor    :    rcalixto
    Fecha    :    30-Jun-2000
    Historia de Modificaciones
    Fecha    Id entrega

    13/04/2010  lfernandezSAO115741
    <FillRecord> En el metodo encapsulado ya no se asigna el estado del programa
    de cartera

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    26-nov-2002 wmontealSAOi16734

    No se actualiza ni la categoria ni sucategoria cuando se retira
    el usuario, estas se limpian cuando pasa a estado libre  en SCES.
    26-Dic-2001 sgilSae7627
    Eliminar setear a cero las lecturas anterior y actual.
    26-11-2001  lbuenaveSAE7229
    Se modifica el metodo FillRecord:
    Al final del procedimiento, se estaba inicializando el servicio a -1, lo
    que causaba error al ejecutar el retiro definitivo.  Se elimina esta
    asignacion.
    22-11-2001  rruizSAE6461
    Se adiciona los procedimientos de FillRecord y FreeRatedConsumption para
    que tambien libere los consumos de la tabla colotasa. Adicionalmente
    se actualiza a nulos los campos de consumo para servsusc, ya que se les
    asignaba cero
    21-09-2001    cnaviaSAE6067
    Se actualiza a nulos los campos SESUFESE, SESUFEIN, SESEFEAS, SESUFEPE
    19-09-2001    cnaviaSAE6038
    Se modifica la actualizacion de los campos en el metodo FillRecord.
    El campo sesuiddi = -1 y el campo sesunius a nulo.
    14.jun.2001    Caq
    Se modifica FillRecord para que copie el registro
    completo a modificar y cambie unicamente los
    campos que se liberan
    Se elimina la modificacion de la fecha de instalacion
    a sysdate.
*/
PROCEDURE FreeServNumber
    (
        inuNumeServ        in    servsusc.sesunuse%type,
        inuCache        in    number Default pkConstante.CACHE
    )
is
    sbErrorMsg      varchar2(2000);        -- Mensaje error
    sbNULLSB         varchar2(1);        -- Nulo string
    nuNULLNUM        number ;
    /* ********************************************************** */
    /*           Encapsulateds Methodos             */
    /* ********************************************************** */
    /* ------------------------------------------------------------ */
    /*
    Procedure    :    GetParameters
    Descripcion    :    Obtiene parametros
    */
    procedure GetParameters
        is
    BEGIN
    pkErrors.Push('pkServNumberMgr.GetParameters');
    -- Obtiene el parametro NULLSB
    sbNULLSB :=pkGeneralParametersMgr.fsbGetStringValue('NULLSB');
    -- Obtiene el parametro NULLNUM
    nuNULLNUM :=pkGeneralParametersMgr.fnuGetNumberValue('NULLNUM');

    pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;
    END GetParameters;
    /* ------------------------------------------------------------ */
    /*
    Procedure    :    FillRecord
    Descripcion    :    Llena registro de servsusc
    */
    PROCEDURE FillRecord
    (
        ircServSusc    in    servsusc%rowtype,
        orcServSusc    out   servsusc%rowtype
    )
        is
        nuEstaServ        number;
    BEGIN
    pkErrors.Push('pkServNumberMgr.FillRecord');
    -- Asigna el registro inicial al record que se va a actualizar
    orcServSusc := ircServSusc;

    -- Los campos que no se actualizan
    orcServsusc.sesunuse := ircServSusc.sesunuse ;
    orcServsusc.sesuserv := ircServSusc.sesuserv ;
    -- Campos actualizar
    orcServsusc.sesususc := nuNULLNUM ;
    orcServsusc.sesufere := sysdate ;
    orcServsusc.sesufucp := ircServSusc.sesufein;
    orcServsusc.sesufucb := ircServSusc.sesufein;
    orcServsusc.sesuboui := nuNULLNUM ;
    orcServsusc.sesucaan := nuNULLNUM ;
    orcServsusc.sesusuan := nuNULLNUM ;
    orcServsusc.sesudepa := nuNULLNUM ;
    orcServsusc.sesuloca := nuNULLNUM ;

    orcServsusc.sesusafa := pkBillConst.CERO ;

    orcServsusc.sesuplfa := nuNULLNUM ;
    orcServsusc.sesuesco := nuNULLNUM ;

    orcServsusc.sesuperf := NULL;

    pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;
    END FillRecord;
    /*
    Procedure    :    FillRecord
    Descripcion    :    Llena registro de colotasa
    */
    PROCEDURE FillRecord
    (
        ircColotasa    in    colotasa%rowtype,
        orcColotasa    out   colotasa%rowtype
    )
        is
    BEGIN
    pkErrors.Push('pkServNumberMgr.FillRecord');
    -- Asigna el registro inicial al record que se va a actualizar
    orcColotasa := ircColotasa;
        -- Campos actualizar
        orcColotasa.cotacopr := NULL;
        orcColotasa.cotacoac := NULL ;
    orcColotasa.cotacom0 := NULL ;
    orcColotasa.cotacom1 := NULL ;
    orcColotasa.cotacom2 := NULL ;
    orcColotasa.cotacom3 := NULL ;
    orcColotasa.cotacom4 := NULL ;
    orcColotasa.cotacom5 := NULL ;
    orcColotasa.cotalean := ircColotasa.cotalean ;
    orcColotasa.cotaleac := ircColotasa.cotaleac ;
    pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;
    END FillRecord;
    /*
    Procedure    :    FreeRatedConsumption
    Descripcion    :    Libera registros de consumo de colotasa
    */
    PROCEDURE FreeRatedConsumption
      IS
    nuConsType    cuTipoCons%rowtype;    -- Registro del CURSOR
        rcColoTasaOld   colotasa%rowtype ;      -- Registro consumo tasado
    rcColoTasaNew   colotasa%rowtype ;      -- Registro consumo tasado
    BEGIN
    if (cuTipoCons%isopen) then
        close cuTipoCons;
    end if;
    for nuConsType in cuTipoCons loop
        if (pktblColotasa.fblExist (inuNumeServ, nuConsType.tconcodi)) then
        -- Obtiene registro de consumo
        rcColoTasaOld := pktblColotasa.frcGetRecord
                 (inuNumeServ,
                  nuConsType.tconcodi,
                  pkConstante.NOCACHE);
        -- Llena nuevo registro de consumos
        FillRecord ( rcColoTasaOld, rcColoTasaNew );
        -- Actualiza registro
            pktblcolotasa.UpRecord (rcColoTasaNew);
        end if;
    end loop;

    EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;
    END FreeRatedConsumption;
    /*
    PROCEDURE    :    Process
    Descripcion    :    Libera numero de servicio
    */
    PROCEDURE Process
        IS
    rcServsuscOld    servsusc%rowtype ;    -- Registro servsusc
    rcServsuscNew    servsusc%rowtype ;    -- Registro servsusc
    BEGIN
    pkErrors.Push('pkServNumberMgr.Process');
    -- Evalua si el numero de servicio es el nulo del aplicativo
    if ( inuNumeServ = pkConstante.NULLNUM ) then

        pkErrors.Pop;
        return ;
    end if ;
    -- Obtiene el registro de servsusc
    rcServsuscOld := pktblServsusc.frcGetRecord (   inuNumeServ,
                            pkConstante.NOCACHE );
    -- Llena el registro de servsusc
    FillRecord ( rcServsuscOld, rcServsuscNew );
    -- Actualiza el numero de servicio
    pktblServsusc.UpRecord ( rcServsuscNew );

    -- Se evalua si tiene consumos en colotasa para dejarlos en cero
        FreeRatedConsumption;
    pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;
    END Process;
    /* ------------------------------------------------------------ */
    /* ********************************************************** */
BEGIN
    pkErrors.Push ('pkServNumberMgr.FreeServNumber');
    -- Obtiene parametros
    GetParameters ;
    -- Liberar numero de servicio
    Process ;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END FreeServNumber;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    FreeServNumberChgStat
    Descripcion    :    Derivado de FreeServNumber.
            Se usa para que no actualice la fecha de retiro.
            Para cuando se esta realizando un cambio de estado
            del numero de servicio por medio de SCES, no debe
            actualizarse la fecha de retiro.
    Parametros    :    Descripcion
    inuNumeServ        Servicio suscrito
    Retorno    :
    Autor    :    Carlos Alberto Quintero
    Fecha    :    Junio 12 del 2001
    Historia de Modificaciones
    Fecha    Autor    Modificacion

    13/04/2010  lfernandezSAO115741
    <FillRecord> En el metodo encapsulado ya no se asigna el estado del programa
    de cartera

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    pordonez_SAO13324    25-JUL-2002

    Se corrige para que no deje NULL la fecha de retiro del abonado.  Se
    requiere este valor para que asignaciones tome el numero como libre y
    realice bien el calculo del periodo de cuarentena requerido para asignar
    nuevamente este numero de servicio.
    jradaSAO11857.01    21-MAY-2002
    No se modifica la fecha de instalacion del numero de servicio. En caso
    de que tenga un dato NULL se asigna sysdate.
    12.jun.2001    Caq    Creacion del procedimiento
*/
PROCEDURE FreeServNumberChgStat
    (
        inuNumeServ        in    servsusc.sesunuse%type
    )
    IS
    sbErrorMsg      varchar2(2000);        -- Mensaje error
    sbNULLSB         varchar2(1);        -- Nulo string
    nuNULLNUM        number ;
    /* ********************************************************** */
    /*           Encapsulateds Methodos             */
    /* ********************************************************** */
    /*
    Procedure    :    GetParameters
    Descripcion    :    Obtiene parametros
    */
    PROCEDURE GetParameters IS
    BEGIN
    pkErrors.Push('pkServNumberMgr.GetParameters');
    -- Obtiene el parametro NULLSB
    sbNULLSB :=pkGeneralParametersMgr.fsbGetStringValue('NULLSB');
    -- Obtiene el parametro NULLNUM
    nuNULLNUM := pkConstante.NULLNUM ;
    pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;
    END GetParameters;
    /* ------------------------------------------------------------ */
    /*
    Procedure    :    FillRecord
    Descripcion    :    Llena registro de servsusc
    */
    PROCEDURE FillRecord
    (
        ircServSusc    in    servsusc%rowtype,
        orcServSusc    out   servsusc%rowtype
    )
        IS
       -- nuEstaServ        servsusc.sesuessv%type ;
    BEGIN
    pkErrors.Push('pkServNumberMgr.FillRecord');

    -- Los campos que no se actualizan
    orcServsusc := ircServSusc ;
    orcServsusc.sesunuse := ircServSusc.sesunuse ;
    orcServsusc.sesuserv := ircServSusc.sesuserv ;
    -- Campos actualizar
    orcServsusc.sesufein := nvl( ircServSusc.sesufein, sysdate );
    orcServsusc.sesususc := nuNULLNUM ;
    orcServsusc.sesuboui := nuNULLNUM ;
    orcServsusc.sesucate := nuNULLNUM ;
    orcServsusc.sesusuca := nuNULLNUM ;
    orcServsusc.sesucaan := nuNULLNUM ;
    orcServsusc.sesusuan := nuNULLNUM ;
    orcServsusc.sesudepa := nuNULLNUM ;
    orcServsusc.sesuloca := nuNULLNUM ;
    orcServsusc.sesusafa := pkBillConst.CERO ;
    orcServsusc.sesuplfa := nuNULLNUM ;
    orcServsusc.sesuesco := nuNULLNUM ;

    pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;
    END FillRecord;
    /*
    Procedure    :    Process
    Descripcion    :    Libera numero de servicio
    */
    PROCEDURE Process IS
    rcServsuscOld    servsusc%rowtype ;    -- Registro servsusc
    rcServsuscNew    servsusc%rowtype ;    -- Registro servsusc
    BEGIN
    pkErrors.Push('pkServNumberMgr.FreeServiceNumber');
    -- Evalua si el numero de servicio es el nulo del aplicativo
    if ( inuNumeServ = pkConstante.NULLNUM ) then

        pkErrors.Pop;
        return ;
    end if ;
    -- Obtiene el registro de servsusc
    rcServsuscOld := pktblServsusc.frcGetRecord
                (
                inuNumeServ,
                pkConstante.NOCACHE
                );
    -- Llena el registro de servsusc
    FillRecord ( rcServsuscOld, rcServsuscNew );
    -- Actualiza el numero de servicio
    pktblServsusc.UpRecord (rcServsuscNew);
    pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;
    END Process;
    /* ********************************************************** */
BEGIN
    pkErrors.Push ('pkServNumberMgr.FreeServNumberChgStat');
    -- Obtiene parametros
    GetParameters ;
    -- Liberar numero de servicio
    Process ;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END FreeServNumberChgStat;

/*******************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Procedure    :    GenServSubsBasic

    Descripcion    :      Metodo para registro de Servicio Suscripto
    Parametros    :        Descripcion
                inuSesuServ     in  Servicio
                isbSesuSusc     in  Suscripcion
                isbSesuCate     in  Categoria
                isbSesuSubc     in  SubCategoria
                isbSesuCadi     in  Cadena de la direccion de Instalacion
                inuSesuFein     in  Fecha Inicial del Servicio
                inuSesuFefi     in  Fecha Final del Servicio(Provisional)
                inuSesuPlfa     in  Plan de Facturacion
                inuSesuTisu     in  Tipo de Suscripcion
                inuSesuSoci     in  Socio
                sbSesuCodi      in  Codigo del Servicio suscripto
                onuErrorCode    in Codigo de Error Generado
                                    --Valores
                                    0 - si el registro tuvo exito
                                    ### - (diferente de 0) codigo del error
                osbErrorMessage out     Mensaje de Error

    Retorno             :       Codigo y Mensaje de Error
    ************************************************************************
        Propiedad intelectual de Open International Systems (c).
        Procedure       :       Initialize
        Descripcion     :       Inicializa variables de salida
    ************************************************************************
    ************************************************************************
        Propiedad intelectual de Open International Systems (c).
        Procedure       :       ClearMemory
        Descripcion     :       Libera memoria.
    ************************************************************************
    ************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Procedure       :       ValIsNull
    Descripcion     :       Valida los datos not null
    ************************************************************************
    ************************************************************************
        Propiedad intelectual de Open International Systems (c).
        Procedure       :       ValiDate
        Descripcion     :       Valida los datos de la
                Fecha de servicio cuando
                trae un valor.
    ************************************************************************
    ************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Procedure       :       ValInputData
    Descripcion     :       Valida los parametros de entrada
    ************************************************************************
    ************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Procedure       :       GenServSubscriber
    Descripcion     :       Registra un Servicio suscripto
    ************************************************************************
    ------------------------------------------------------------------------
    Fin Metodos Encapsulados
    ------------------------------------------------------------------------
    Autor               :       osilva
    Fecha               :       03-Dic-2001

    Historia de Modificaciones
    Fecha       IDEntrega

    09-05-2011  sgomezSAO150179
    Se introduce nuevo modelo de ubicacion geografica:
        - Se eliminan parametros de entrada:
            *  <Departamento>
            *  <Localidad>

    06-Oct-2009 DBarragan SAO103746 Se adiciona el parametro empresa.
    30-Ago-2006 Miguel A. Arenas R. SAO 46553 : Se adicionan parametros de
    entrada para los campos SesuEsco y SesuCain.

    28-Mar-2006 Yclavijo SAO45736
    se modifica el metodo GenServSubsBasic para que reciba el ciclo de consumo.

    31-10-2005  isinisteSAO41873
    Se recibe el parametro inuSesumult (numero de unidades habitacionales).
    <GenServSubscriber> : Se envia inuSesumult al llenado del registro.

    11-MAY-05   cnaviaSAO37568
    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG.

    28-Jun-2004 lilianirSAO30296
    Se adicionan 3 parametros de entrada para el registro ( sesuesco,
    sesuroga, sesuroca ).

    13-Dic-2003 DescobarSAO24526
    Se agregan parametros: isbSesurutl, inuSesunpas, inuSesunext, isbsesunous,
    isbsesunius.

    14-abr-2003    cquinteroSAO19750
    Se adiciona el Telefono garante (sesutefa) como parametro de entrada.
    Tiene valor default null.

    05-AGO-2002 osilvaSAO12107
    Se le cambio parametro de servicio suscrito
    de salida por parametro de entrada, se quito la generacion
    del nuemro del servicio suscrito y validaciones basicas.

    08-Jul-2002    SpcastriSAO12832
    Se elimina validacion del socio con pkPartnerMgr.ValBasicData para
    validar :
    . Que el socio NO sea NULO
    . Que el socio exista en la B.D.

    28-JUN-2002 JcruzSAO12681
    Se adiciono la validacion del Departamento y la Categoria en el metodo
    ValInputData

    22-MAY-2002 osilvaSAO11002
    Se adiciono el parametro socio

    03-DIC-2001 osilvaOP8689
    Creacion del objeto.

*******************************************************************************/
PROCEDURE GenServSubsBasic
(
        inuSesuServ in servsusc.sesuserv%type             ,
        inuSesuSusc in servsusc.sesususc%type             ,
        inuSesuCate in servsusc.sesucate%type             ,
        inuSesuSuca in servsusc.sesusuca%type             ,
        idtSesuFein in servsusc.sesufein%type             ,
        inuSesuPlfa in servsusc.sesuplfa%type             ,
        inuSesuCodi in servsusc.sesunuse%type             ,
        isbSesuImld in servsusc.sesuimld%type             ,
        inuSesuEsco in servsusc.sesuesco%type default null,
        isbSesuRoga in servsusc.sesuroga%type default null,
        isbSesuRoca in servsusc.sesuclpr%type default null,
        inuSesumult in servsusc.sesumult%type default 1,
        inuSesucico in servsusc.sesucico%type default null,
        inuSesuCain in servsusc.sesucain%type default null,
        inuSesuDiad in servsusc.sesudiad%type default -1,
        inuSesulicr in servsusc.sesulicr%type default null,
        inuSesuSist IN servsusc.sesusist%type default NULL
)
IS
    -- ********************************************************************** --
    -- ********                 Metodos Encapsulados                 ******** --
    -- ********************************************************************** --

    PROCEDURE Initialize
    IS
    BEGIN
        pkErrors.Push('pkServNumberMgr.GenServSubsBasic.Initialize');
        -- Inicializa variables de error
        pkErrors.Initialize;
        pkErrors.Pop;
     EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise LOGIN_DENIED;
    END Initialize;

    -- ********************************************************************** --

    PROCEDURE GenServSubscriber is
        orcServsusc servsusc%rowtype;
    BEGIN
        pkErrors.push( 'pkServNumberMgr.GenServSubsBasic.GenServSubscriber' );

        -- Se llena registro con datos de entrada
        FillInputDataRecord
        (
            inuSesuServ,
            inuSesuSusc,
            inuSesuCate,
            inuSesuSuca,
            idtSesuFein,
            inuSesuPlfa,
            inuSesuCodi,
            isbSesuImld,
            null       ,
            inuSesuEsco,
            isbSesuRoga,
            isbSesuRoca,
            inuSesumult,
            orcServsusc,
            inuSesucico,
            inuSesuCain,
            inusesudiad,
            inuSesulicr,
            inuSesuSist
        );

        -- Se inserta servicio suscrito.
        pktblServsusc.InsRecord( orcServsusc );

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.Pop;
            raise LOGIN_DENIED;
        when pkConstante.exERROR_LEVEL2  then
            pkErrors.Pop;
            raise pkConstante.exERROR_LEVEL2;
    END GenServSubscriber;

    -- ********************************************************************** --

BEGIN
    pkErrors.Push('pkServNumberMgr.GenServSubsBasic');

    -- Inicializa variables.
    Initialize;

    -- Obtiene los parametros.
    Getparameters;

    -- Inserta el servicio suscrito.
    GenServSubscriber;

    pkErrors.Pop;
EXCEPTION
     when LOGIN_DENIED then
          pkErrors.pop;
          raise LOGIN_DENIED;
     when pkConstante.exERROR_LEVEL2 then
          -- Error Oracle nivel dos
          pkErrors.pop;
          raise pkConstante.exERROR_LEVEL2;
     when OTHERS then
          pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
          pkErrors.pop;
          raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);
END GenServSubsBasic;

/*
    Propiedad Intelectual de Open International Systems (c)
    Procedure   : GetFinancingData
    Descripcion : Consulta el estado financiero de un servicio
    Parametros :
        inuServNumber   Numero de servicio
    Retorna :
        onuSaldoPendiente    Saldo Pendiente
        onuSaldoAFavor       Saldo A Favor
        onuSaldoAnterior     Saldo Anterior
        onuCuentasConSaldo   Cuentas con Saldo
        onuValorAnticipo     Valor anticipo
    Autor : Carlos Duque
    Fecha : Nov.30.2001
    Historia de Modificaciones
    Fecha       IdEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
    Nov.30.2001 cduqueOP8610   Creacion
*/
PROCEDURE GetFinancingData
   (
      inuServNumber         in  servsusc.sesunuse%type,
      onuSaldoPendiente     out cuencobr.cucosacu%type,
      onuSaldoAFavor        out servsusc.sesusafa%type,
      onuCuentasConSaldo    out number
   )
IS
    -------------------------------------
    -- Procedimiento : FillOutData
    -- Autor         : cduque
    -- Fecha         : [Dec-01-2001]
    -------------------------------------
    Procedure FillOutData
    is
      rcServSusc    servsusc%rowtype ;
    Begin
      pkErrors.Push('pkServNumberMgr.FillOutData');
      rcServSusc := pktblServsusc.frcGetRecord  ( inuServNumber );
      onuSaldoPendiente   :=  pkbccuencobr.fnuGetOutStandBal(inuServNumber);
      onuSaldoAFavor      :=  rcServsusc.sesusafa;
      onuCuentasConSaldo  := pkBCCuencobr.fnuGetBalAccNum(inuServNumber);
      pkErrors.Pop;
      EXCEPTION
      when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;
      when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
      when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    End FillOutData;
BEGIN
    pkErrors.Push('pkServNumberMgr.GetFinancingData');
    -- Limpia toda la memoria cache
    pktblServsusc.ClearMemory;
    -- Valida datos de entrada
    pktblServsusc.acckey ( inuServNumber );
    FillOutData;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
          pkErrors.Pop;
          raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
          pkErrors.Pop;
          raise pkConstante.exERROR_LEVEL2;
    when others then
          pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
          pkErrors.Pop;
          raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END GetFinancingData;
/*
    Propiedad intelectual de Open International Systems. (c).
    Procedimiento:    GetSubsServices
            Get Subscriber Services

    Descripcion     :    Obtiene la coleccion de servicios suscrito de una
            suscripcion

    Parametros     :    Descripcion
    inuSusc             Suscripcion
    iotnuSubsServBulk    Coleccion de servicios suscritos de la
                suscripcion
    Retorno     :
    ------------------------------------------------------------------------
    Metodos Encapsulados
    ------------------------------------------------------------------------
    ************************************************************************
    Procedimiento :
    Descripcion      :
    ************************************************************************
    Funcion      :
    Descripcion      :
    ************************************************************************
    ------------------------------------------------------------------------
    Fin Metodos Encapsulados
    ------------------------------------------------------------------------
    Autor     :    Fabian Manrique Ramirez
    Fecha     :    Septiembre 06 de 2002
    Historia de Modificaciones
    Fecha    IDEntrega
    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    06-SEP-2002    fmanriqueSAO12027
    Creacion del objeto.
*/
PROCEDURE GetSubsServices
    (
    inuSusc             in          servsusc.sesususc%type,
    iotnuSubsServBulk    in out nocopy pktblServsusc.tySesunuse
    )
IS
    --------------------------------------------------------------------
    -- Constants
    --------------------------------------------------------------------
    -- Obtiene numero de registros a tomar del cursor
    cnuNUM_REC_FETCHED    constant number := 100;
    -- La suscripcion no tiene servicios suscritos asociados
    cnuSERV_NOT_FOUND   constant number := 9;
    --------------------------------------------------------------------
    -- Variables
    --------------------------------------------------------------------
    -- Definicion de coleccion de primer nivel
    tnuSubsServBulk_tmp        pktblServsusc.tySesunuse;
    -- Indice temporal
    nuIndice                number :=0;
    -- Indice coleccion general
    nuIndx                number :=0;
    --------------------------------------------------------------------
    -- Cursors
    --------------------------------------------------------------------
BEGIN
    pkErrors.Push('pkServNumberMgr.GetSubsServices');
    -- Destruye cache
    tnuSubsServBulk_tmp.delete;
    iotnuSubsServBulk.delete;
    --------------------------------------------------------------------
    -- Toma la informacion del cursor a traves una coleccion temporal
    -- y se pobla la coleccion final, si no hay datos genera error
    --------------------------------------------------------------------
    If (cuSubsServ%isopen) then
    close cuSubsServ;
    End if;
    open cuSubsServ ( inuSusc ) ;
    loop
    -- {
    fetch cuSubsServ bulk collect into tnuSubsServBulk_tmp
    limit cnuNUM_REC_FETCHED;
    if ( tnuSubsServBulk_tmp.first is null ) then
        exit ;
    end if ;
    nuIndice := tnuSubsServBulk_tmp.first;
    loop
        exit when nuIndice is null;
        nuIndx := nuIndx + 1;
        iotnuSubsServBulk(nuIndx):= tnuSubsServBulk_tmp (nuIndice);
        nuIndice := tnuSubsServBulk_tmp.next (nuIndice);
    end loop;
    tnuSubsServBulk_tmp.delete;
    exit when cuSubsServ%notfound;
    -- }
    end loop;
    close cuSubsServ;
    if ( iotnuSubsServBulk.count <= 0 ) then
    pkErrors.SetErrorCode
        (
        pkConstante.csbDIVISION,
        pkConstante.csbMOD_GRL,
        cnuSERV_NOT_FOUND
        );
    raise LOGIN_DENIED;
    end if;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END GetSubsServices;

/*
    Propiedad intelectual de Open International Systems. (c).
    Procedimiento:    fblGetSubsServices
                    FUNCTION GET SUBSCRIBER SERVICES

    Descripcion     :    Obtiene la coleccion de servicios suscrito de una
                    suscripcion

    Parametros     :
        inuSesuSusc         in      Codigo del Suscriptor
        inuSesuMin          in      Limite inferior de los servicios suscritos
        inuBlockSize        in      Limite de la coleccion
        orctbSesuNuse       out     Coleccion de servicios suscritos de
                                    la suscripcion

    Retorno     :
        blMoreRecords    boolean    Informa si hay mas registros para procesar

    ------------------------------------------------------------------------
    Metodos Encapsulados
    ------------------------------------------------------------------------
    ************************************************************************
    Procedimiento :     Initialize
    Descripcion      :     Limpia la tabla PL Temporal
    ************************************************************************
    Funcion      :         FillOutRecord
    Descripcion      :  Llena la tabla PL que sera retornada
    ************************************************************************
    ------------------------------------------------------------------------
    Fin Metodos Encapsulados
    ------------------------------------------------------------------------
    Autor     :    Juan David Ferrerosa
    Fecha     :    Junio 07 de 2004

    Historia de Modificaciones
    Fecha	ID Entrega

    23-03-2012  aylopezSAO175104
    Se adiciona logica para obtener el ciclo de facturacion y multifamiliar del
    producto.

    15-06-2010  aframirezSAO117789
    Se crean dos nuevas tablas temporales:
        <tnusesuescoBulk_tmp>
        <tnusesusistBulk_tmp>.
    Se adiciona logica para el uso de las nuevas tabla temporales.

    14-01-2010  aframirezSAO110035
    Nivelacion del SAO 91262:
        "Se modifica la manera de obtener los datos de servsusc, se valida si el
         parametro <inuSubsService> es diferente de nulo, si es asi busca los datos
         en el CURSOR <cuSubsServicesWithServ>, de lo contrario busca los datos en el
         CURSOR <cuSubsServices>".

    11-11-2008	cquinteroSAO85392
    Se obtiene el ciclo de consumo. Se modifica el cursor cuSubsServices para
    obtener el ciclo de consumo.

    17-07-2007 jcassoSAO62655
    Se modifica para poblar campo de bolsa (coleccion tbsesupane del registro
    tytbServNumber).

    09-08-2006	cquinteroSAO49106
    Se adiciona la seleccion de las columnas sesufein, sesufere y sesufulf.

    07-jul-2004     lgarciaSAO30006
    Se adicionan el servicio suscrito como parametro de entrada para procesos
    individuales

    07-jul-2004     lgarciaSAO30006
    Se adicionan los campos Sesuserv,Sesuplfa,Sesususc,Sesudepa,Sesuloca,
                            Sesucate,Sesusuca,Sesusoci,Sesuclpr,Sesufese
                            al registro de salia
    07-JUN-2004        jferreroSAO29928
    Creacion del objeto.

*/
FUNCTION fblGetSubsServices
(
    inuSesuSusc         in      servsusc.sesususc%type,
    inuSesuMin          in      servsusc.sesunuse%type,
    inuBlockSize        in      number,
    orctbSesuNuse       out     nocopy tytbServNumber,
    inuSubsService      in	servsusc.sesunuse%type default pkConstante.NULLNUM
)
RETURN boolean IS

    --------------------------------------------------------------------
    -- Variables
    --------------------------------------------------------------------

    -- Tabla de RowId
    tsbrowid                tySesurowid ;
    -- Definicion de coleccion de primer nivel
    tnuSubsServBulk_tmp      pktblServsusc.tySesunuse;
    tnuSesuservBulk_tmp      pktblServsusc.tySesuserv;
    tnusesuplfaBulk_tmp      pktblServSusc.tySesuplfa;
    tnusesususcBulk_tmp      pktblServSusc.tySesususc;
    tnusesudepaBulk_tmp      pktblServSusc.tySesudepa;
    tnusesulocaBulk_tmp      pktblServSusc.tySesuloca;
    tnusesucateBulk_tmp      pktblServSusc.tySesucate;
    tnusesusucaBulk_tmp      pktblServSusc.tySesusuca;
    tsbsesuclprBulk_tmp      pktblServSusc.tySesuclpr;
    tdtsesusesgBulk_tmp      pktblServSusc.tySesusesg;
    tdtsesufeinBulk_tmp      pktblServSusc.tySesufein;
    tdtsesufereBulk_tmp      pktblServSusc.tySesufere;
    tdtsesubouiBulk_tmp      pktblServSusc.tySesuboui;
    tnusesucicoBulk_tmp      pktblServsusc.tySesucico;
    tnusesuciclBulk_tmp      pktblServsusc.tySesucicl;
    tnusesuescoBulk_tmp      pktblServsusc.tySesuesco;
    tnusesusistBulk_tmp      pktblServsusc.tySesusist;
    tnusesumultBulk_tmp      pktblServsusc.tySesumult;

    -- Existen mas registros
    blMoreRecords           boolean;

    /* ------------------------------------------------------------ */
    PROCEDURE Initialize
    IS
    BEGIN
    --{
        pkErrors.Push('pkServNumberMgr.fblGetSubsServices.Initialize');

        -- Destruye cache
        tsbrowid.delete;
        tnuSubsServBulk_tmp.delete;
        tnuSesuservBulk_tmp.delete;
        tnusesuplfaBulk_tmp.delete;
        tnusesususcBulk_tmp.delete;
        tnusesudepaBulk_tmp.delete;
        tnusesulocaBulk_tmp.delete;
        tnusesucateBulk_tmp.delete;
        tnusesusucaBulk_tmp.delete;
        tsbsesuclprBulk_tmp.delete;
        tdtsesusesgBulk_tmp.delete;
      	tdtsesufeinBulk_tmp.DELETE;
    	tdtsesufereBulk_tmp.DELETE;
    	tdtsesubouiBulk_tmp.DELETE;
    	tnusesucicoBulk_tmp.DELETE;
    	tnusesuciclBulk_tmp.DELETE;
    	tnusesuescoBulk_tmp.DELETE;
        tnusesusistBulk_tmp.DELETE;
        tnusesumultBulk_tmp.DELETE;

    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
        when others then
            pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
            pkErrors.Pop;
            raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    --}
    END Initialize;
    /* ------------------------------------------------------------ */
    PROCEDURE FillOutRecord
    IS
    BEGIN
    --{
        pkErrors.Push('pkServNumberMgr.fblGetSubsServices.FillOutRecord');

        ORctbSesuNuse.tbSesurowid  := tsbrowid ;
        ORctbSesuNuse.tbSesuNuse   := tnuSubsServBulk_tmp;
        ORctbSesuNuse.tbSesuserv   := tnuSesuservBulk_tmp;
        ORctbSesuNuse.tbsesuplfa   := tnusesuplfaBulk_tmp;
        ORctbSesuNuse.tbsesususc   := tnusesususcBulk_tmp;
        ORctbSesuNuse.tbsesudepa   := tnusesudepaBulk_tmp;
        ORctbSesuNuse.tbsesuloca   := tnusesulocaBulk_tmp;
        ORctbSesuNuse.tbsesucate   := tnusesucateBulk_tmp;
        ORctbSesuNuse.tbsesusuca   := tnusesusucaBulk_tmp;
        ORctbSesuNuse.tbsesuclpr   := tsbsesuclprBulk_tmp;
        ORctbSesuNuse.tbsesusesg   := tdtsesusesgBulk_tmp;
        orctbSesuNuse.tbsesufein   := tdtsesufeinBulk_tmp;
        orctbSesuNuse.tbsesufere   := tdtsesufereBulk_tmp;
        orctbSesuNuse.tbsesuboui   := tdtsesubouiBulk_tmp;
        orctbSesuNuse.tbsesucico   := tnusesucicoBulk_tmp;
        orctbSesuNuse.tbsesucicl   := tnusesuciclBulk_tmp;
        orctbSesuNuse.tbsesuesco   := tnusesuescoBulk_tmp;
        orctbSesuNuse.tbsesusist   := tnusesusistBulk_tmp;
        orctbSesuNuse.tbsesumult   := tnusesumultBulk_tmp;
    EXCEPTION
    --{
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
        when others then
            pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
            pkErrors.Pop;
            raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    --}
    END FillOutRecord;

BEGIN
--{
    pkErrors.Push('pkServNumberMgr.fblGetSubsServices');

    -- Inicializa tabla
    Initialize ;

    --------------------------------------------------------------------
    -- Toma la informacion del cursor a traves una coleccion temporal
    -- y se pobla la coleccion final, si no hay datos no retorna nada
    --------------------------------------------------------------------
    IF (inuSubsService <> pkConstante.NULLNUM) THEN
    --{
        if (cuSubsServicesWithServ%isopen) then
            close cuSubsServicesWithServ ;
        end if;

        blMoreRecords := true ;

        -- Abre CURSOR de datos
        open  cuSubsServicesWithServ (inuSesuSusc, inuSubsService) ;

        -- Recupera registros
        fetch cuSubsServicesWithServ bulk collect into
            tsbrowid           , tnuSubsServBulk_tmp, tnuSesuservBulk_tmp,
            tnusesuplfaBulk_tmp, tnusesususcBulk_tmp, tnusesudepaBulk_tmp,
            tnusesulocaBulk_tmp, tnusesucateBulk_tmp, tnusesusucaBulk_tmp,
            tsbsesuclprBulk_tmp, tdtsesusesgBulk_tmp, tdtsesufeinBulk_tmp,
            tdtsesufereBulk_tmp, tdtsesubouiBulk_tmp, tnusesucicoBulk_tmp,
            tnusesuescoBulk_tmp, tnusesusistBulk_tmp, tnusesuciclBulk_tmp,
            tnusesumultBulk_tmp;

        -- Pobla tabla de salida
        FillOutRecord ;

        if (cuSubsServicesWithServ%Notfound) then
            blMoreRecords := FALSE ;
        end if;

        close cuSubsServicesWithServ;

        -- Inicializa tabla
        Initialize ;
    --}
    ELSE
    --{
        if (cuSubsServices%isopen) then
            close cuSubsServices ;
        end if;

        blMoreRecords := true ;

        -- Abre CURSOR de datos
        open  cuSubsServices (inuSesuSusc, inuSesuMin) ;

        -- Recupera registros
        fetch cuSubsServices bulk collect into
            tsbrowid           , tnuSubsServBulk_tmp, tnuSesuservBulk_tmp,
            tnusesuplfaBulk_tmp, tnusesususcBulk_tmp, tnusesudepaBulk_tmp,
            tnusesulocaBulk_tmp, tnusesucateBulk_tmp, tnusesusucaBulk_tmp,
            tsbsesuclprBulk_tmp, tdtsesusesgBulk_tmp, tdtsesufeinBulk_tmp,
            tdtsesufereBulk_tmp, tdtsesubouiBulk_tmp, tnusesucicoBulk_tmp,
            tnusesuescoBulk_tmp, tnusesusistBulk_tmp, tnusesuciclBulk_tmp,
            tnusesumultBulk_tmp
        limit inuBlockSize;

        -- Pobla tabla de salida
        FillOutRecord ;

        if (cuSubsServices%Notfound) then
            blMoreRecords := FALSE ;
        end if;

        close cuSubsServices;

        -- Inicializa tabla
        Initialize ;
    --}
    END IF;

    pkErrors.Pop;
    return (blMoreRecords) ;
EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
END fblGetSubsServices;

procedure LockRecord
(
    inuServiceNumber in servsusc.sesunuse%type
)
/*
    Propiedad intelectual de Open Systems (c)
    Script         :  LockRecord
    Descripcion    :  Bloquea el registro dado
    Parametros     :  inuServiceNumber     :  Numero de servicio
    Retorna        :
    Autor          :  wmonteal
    Fecha          :  31-Oct-2002
    Historia de Modificaciones
    Autor       Fecha         descripcion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

IS
    cnRECORD_LOCKED         constant  number := 8078;
    sbError                 varchar2(2000);
BEGIN
    pkErrors.push('pkServNumberMgr.LockRecord');
    -- Se verifica que exista el numero de servicio;
    pktblServSusc.AccKey(  inuServiceNumber);
    if (not pktblServSusc.fblLockRegister( inuServiceNumber )) then
        pkErrors.SetErrorCode
        (
            pkConstante.csbDIVISION,
            pkConstante.csbMOD_SAT,
            cnRECORD_LOCKED
        );
        Raise Login_Denied;
    end if;
    pkErrors.pop;
EXCEPTION
    When LOGIN_DENIED or  pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise LOGIN_DENIED;
    When OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbError);
        pkErrors.pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbError );
END;

/*
    Propiedad intelectual de Open Systems (c).
    Function    :    TransfersPendingBalances
    Descripcion    :    Trasladar cartera pendiente de un numero de servicio
            -- Actualiza el numero de servicio de los cargos
               asocidados a la cuenta de cobro
            -- Actualiza el numero de servicio de la cuenta de cobro
    Parametros    :    Descripcion
    inuNuseActu     Numero de Servicio anterior
    inuNuseNuev     Numero de Servicio nuevo
    Retorno    :
    Autor    :    rcalixto
    Fecha    :    03-Nov-2000
    Historia de Modificaciones
    Fecha    Autor        Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

procedure TransfersPendingBalances
    (
    inuNuseActu     in      servsusc.sesunuse%type,
    inuNuseNuev     in      servsusc.sesunuse%type
    )
is
    /* ***************************************************************** */
    /* ********           Procedimientos Encapsulados           ******** */
    /* ***************************************************************** */
    /*
    Procedure    :    UpAccount
    Descripcion    :    Selecciona la cuentas
    */
   procedure UpAccount is
    -- Cuentas de cobro del numero de servicio, con saldo pendiente.
    CURSOR cuCuencobr
    IS
    SELECT *
    FROM cuencobr
    WHERE cuconuse = inuNuseActu
    AND   nvl(cucovato,pkBillConst.CERO) > nvl(cucovaab,pkBillConst.CERO);
    BEGIN
    pkErrors.Push('pkServNumberMgr.UpAccount');
    -- Cuentas de cobro del numero de servicio, con saldo pendiente
    for rcCuencobr in cuCuencobr loop
        -- Actualiza el numero de servicio de los cargos asocidados
        -- a la cuenta de cobro
        pkChargeMgr.UpServNumberAccount
        (
            rcCuencobr.cucocodi,
            inuNuseNuev
        ) ;
        -- Actualiza el numero de servicio de la cuenta de cobro
        pktblCuenCobr.UpServiceNumber
        (
            rcCuencobr.cucocodi,
            inuNuseNuev
        ) ;
    end loop;    -- Fin Ciclo Cuentas de Cobro
    pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;
    END UpAccount;
BEGIN
    pkErrors.Push ('pkServNumberMgr.TransfersPendingBalances');
    -- Actualiza las cuentas y los cargos del numero de servicio
    UpAccount ;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END TransfersPendingBalances;

/*******************************************************************************
    Propiedad intelectual de Open Systems (c).
    Procedure    :    UpServNumberToWithDraw
                    Update Service Number To With Draw
    Descripcion    :    Actualiza el servicio suscrito para retirarlo.
                    Actualiza estado de corte y plan de facturacion.

    Parametros    :        Descripcion

    inuNumeServ    Numero de servicio

    Retorno    :
    Autor    :    kmarcos
    Fecha    :    24-Ene-2002

    Historia de Modificaciones
    Fecha    Id Entrega
    04-03-2013  dzunigaSAO203431 (28-02-2013  jvelasquezSAO203393)
    Estabilizacion: Se actualiza el llamado al pktblSusc.UpSuspensionStatus,
    para utilizar el metodo sobrecargado que contempla la actualizacion de la fecha de corte
    al cambiar el estado.

    30-03-2006  jradaSAO45546
    Se evalua si entra por parametro el estado al cual debe cambiar el producto.

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    16-Jun-2004 isinisteSAO30231
    Se recibe el parametro iboVoluntary para indicar si es un retiro voluntario
    y se actualiza el servicio dependiendo del valor del parametro.

    26-Nov-2003    lilianirSAO25831
    Habilita manejo de cache para parametros.

    25-Nov-2003    lilianirSAO25558
    Se elimina en el retiro la actualizacion del plan de facturacion del servicio
    suscrito con el valor del parametro PLAN_FACT_RETIRADOS, se deja el plan de
    facturacion ORiginal. Por lo tanto ya no es necesario obtener el valor de
    este parametro.

    29-Jun-2003     lilianirSAO22580
    Se adiciona la actualizacion de la fecha
    de retiro (sesufere) del servicio suscrito.

    28-Ene-2003    lgarciaSAO17787.01
    Se adiciona parametro fecha de corte

    12-Ago-2002 kmarcosSAO13354.01
    Se adiciona a la actualizacion la fecha de estado corte, al retirar el
    servicio, se actualiza con sysdate.

    24-Ene-2002 kmarcosOP8994.01
    creacion.
*******************************************************************************/
PROCEDURE UpServNumberToWithDraw
(
    inuNumeServ  in servsusc.sesunuse%type,
    idtSesufeco  in servsusc.sesufeco%type default null,
    iboVoluntary in boolean default FALSE,
    inuNewStatus in servsusc.sesuesco%type default null
) IS

    nuTEL_RET_DEF   estacort.escocodi%type ;
    /* ************************************************************ */
    /*           Encapsulated Methods                     */
    /* ************************************************************ */
    /* ------------------------------------------------------------ */
    PROCEDURE GetParameters
    IS
    BEGIN
        pkErrors.Push('pkServNumberMgr.UpServNumberToWithDraw.GetParameters');

        -- Habilita manejo de cache para parametros.
        pkGrlParamExtendedMgr.SetCacheOn;

        -- Evalua si es un retiro voluntario.
        if (iboVoluntary) then
            -- Obtiene el valor del parametro INICIORETIRO_ATENCLIE (retiro
            -- voluntario).
            nuTEL_RET_DEF := pkGeneralParametersMgr.fnuGetNumberValue
                             ('INICIORETIRO_ATENCLIE');
        else
            -- Obtiene el parametro RETIRO_LINEA_POR_NO_PAGO.
            nuTEL_RET_DEF := pkGeneralParametersMgr.fnuGetNumberValue
                             ('RETIRO_LINEA_POR_NO_PAGO');
        end if;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
        when others then
            pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
            pkErrors.Pop;
            raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END GetParameters;
    /* ------------------------------------------------------------ */
    /* ********************************************************** */
BEGIN
    pkErrors.Push('pkServNumberMgr.UpServNumberToWithDraw');

    --  Verifica si se envio un estado en particular por parametro al cual se
    --  debe actualizar el servicio suscrito
    if ( inuNewStatus IS not null ) then
        nuTEL_RET_DEF := inuNewStatus;
    else
        -- Obtien parametros
        GetParameters;
    end if;

    -- Actualiza el estado y fecha de corte,
    pktblServsusc.UpSuspensionStatus
    (
        inuNumeServ,
        nuTEL_RET_DEF,
        nvl(idtSesufeco,pkGeneralServices.fdtGetSystemDate)
    );
    -- Actualiza la fecha de Retiro del Servicio Suscrito
    pktblServsusc.UpWithDrawDate
    (
        inuNumeServ,
        nvl(idtSesufeco,pkGeneralServices.fdtGetSystemDate)
    );

    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END UpServNumberToWithDraw;

/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    UpServNumberToWithDrawCC
                    Update Service Number To With Draw Customer Care

    Descripcion    :    Actualiza el servicio suscrito para retirarlo por Customer Care.
            Actualiza:
              - estado de corte en retirado por Customer Care
              - Fecha de Corte
              - Fecha de Retiro


    Parametros    :        Descripcion
        inuNumeServ    Numero de servicio
    Retorno    :
    Autor    :    mfmoreno
    Fecha    :    13-Ago-2003
    Historia de Modificaciones
    Fecha    Id Entrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    13-Ago-2003 mfmorneoSAO23046

    creacion.
*/
procedure UpServNumberToWithDrawCC
    (
        inuNumeServ    in    servsusc.sesunuse%type,
        idtSesufeco    in    servsusc.sesufeco%type
    )
    is
    nuTEL_RET_DEF_CC   estacort.escocodi%type ;
    /* ************************************************************ */
    /*           Encapsulated Methods                     */
    /* ************************************************************ */
    /* ------------------------------------------------------------ */
    PROCEDURE GetParameters
    IS
    BEGIN
        pkErrors.Push('pkServNumberMgr.UpServNumberToWithDrawCC.GetParameters');
        -- Obtiene el parametro RETIRO_LINEA_POR_NO_PAGO
        nuTEL_RET_DEF_CC :=pkGeneralParametersMgr.fnuGetNumberValue
                                                    ('INICIORETIRO_ATENCLIE');
        pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END GetParameters;
    /* ------------------------------------------------------------ */
    /* ********************************************************** */
BEGIN
    pkErrors.Push('pkServNumberMgr.UpServNumberToWithDrawCC');
    --Obtien parametros
    GetParameters;

    --Actualiza el estado y la fecha de corte,
    pktblServsusc.UpSuspensionStatus(
            inuNumeServ,
            nuTEL_RET_DEF_CC,
            nvl(idtSesufeco,pkGeneralServices.fdtGetSystemDate));

    --Actualiza la fecha de Retiro del Servicio Suscrito
    pktblServsusc.UpWithDrawDate(inuNumeServ,
                                 nvl(idtSesufeco,pkGeneralServices.fdtGetSystemDate));

    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END UpServNumberToWithDrawCC;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    UpContractChange
    Descripcion    :    Actualiza el servicio suscrito por cambio de contrato
    Parametros    :        Descripcion
        inuNumeServ    Numero de servicio
    Retorno    :
    Autor    :    kmarcos
    Fecha    :    02-Ago-2003
    Historia de Modificaciones
    Fecha    Id Entrega

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    24-Ene-2002 JguerreroSAO20423
    creacion.
*/
procedure UpNewContract
    (
        inuNumeServ    in    servsusc.sesunuse%type,
        inuSuscripc in  suscripc.susccodi%type,
        idtFecha    in  servsusc.sesufucc%type
    )
    is
BEGIN
    pkErrors.Push('pkServNumberMgr.UpNewContract');

    UPDATE servsusc
    SET sesususc = inuSuscripc,
        sesufucc = idtFecha
    WHERE sesunuse = inuNumeServ;

    if ( sql%notfound ) then
        pkErrors.SetErrorCode( csbDIVISION, csbMODULE, cnuRECORD_NO_EXISTE );
        raise LOGIN_DENIED ;
    end if;

    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END UpNewContract;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    UpDateStatusSubsServ
    Descripcion    :    Actualiza el estado y la fecha de corte, la fecha de retiro,
                    la fecha de instalacion y el plan de facturacion del
                    servicio suscrito.

    Parametros    :        Descripcion
    inuNumServ             Numero de servicio
    inuStatus            Estado de Corte
    idtDate              Fecha de Corte
    idtWithDrawDate      Fecha de Retiro
    idtConnDate          Fecha de Instalacion

    Retorno    :
    Autor    :    Liliani Rojas
    Fecha    :    31-Oct-2003
    Historia de Modificaciones
    Fecha    Id Entrega

    16-Oct-2008 aochoaSAO84021
    Se adiciona en el UPDATE la actualizacion del campo SESUFULF - Fecha de
    ultima facturacion a null ya que la funcion liqminplan (customizada ETP)
    liquida el cargo basico desde la fecha que aparezca en este campo.

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    31-Oct-2003 lilianirSAO23853
    creacion.
*/
procedure UpDateStatusSubsServ
    (
        inuNumServ      in  servsusc.sesunuse%type,
        inuBillPlan     in  servsusc.sesuplfa%type,
        inuStatus       in  servsusc.sesuesco%type,
        inuDate         in  servsusc.sesufeco%type,
        idtWithDrawDate in  servsusc.sesufere%type,
        idtConnDate     in  servsusc.sesufein%type
    )
    is
BEGIN
    pkErrors.Push('pkServNumberMgr.UpDateStatusSubsServ');

    UPDATE servsusc
    SET sesuplfa = inuBillPlan,
        sesuesco = inuStatus,
        sesufeco = inuDate,
        sesufere = idtWithDrawDate,
        sesufein = idtConnDate
    WHERE sesunuse = inuNumServ;

    if ( sql%notfound ) then
        pkErrors.SetErrorCode( csbDIVISION, csbMODULE, cnuRECORD_NO_EXISTE );
        raise LOGIN_DENIED ;
    end if;

    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END UpDateStatusSubsServ;
/*
    Propiedad Intelectual de Open Systems (c)
    Procedure    : ValAccNumBalRequest
    Descripcion    : Verifica si el servicio suscrito tiene un numero de cuentas
          de cobro con saldo permitidos para registrar una peticion.

    Parametros    :         Descripcion
    Retorna    :
    Autor    : Sandra Patricia Castrillon V. (spcastri)
    Fecha    : 12-Nov-2000
    Historia de Modificaciones
    Fecha    Autor        Modificacion

    26-01-2009  aframirezSAO89485
    Se elimina el cometario sobre lineas que no deberian tener el comentario.

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

procedure ValAccNumBalRequest( inuNumeServ    in servsusc.sesunuse%type )
IS
    -- Numero de Cuentas con Saldo
    nuCtasSaldo         pkBCsuscripc.stysusccusa;
    -- Ultima cuenta de cobro
    nuUltCtaCobro    cuencobr.cucocodi%type;
    -- Maximo numero de facturas vencidas permitidas
    nuMaxNoFacVenc      parametr.pamenume%type;
    -- Fecha de pago
    dtFechaPago        cuencobr.cucofepa%type;
    -- La suscripcion no esta a Paz y Salvo
    cnuSERV_NO_PAZ_Y_SALVO constant number := 1008;
BEGIN
    pkErrors.push('pkServNumberMgr.ValAccNumBalRequest' );
    pkParameterMgr.GetInLateBillMax( nuMaxNoFacVenc );
    nuCtasSaldo := pkAccountMgr.fnuGetAccNumBalanceService( inuNumeServ );
    if ( nuCtasSaldo <= 0 ) then
    pkErrors.pop;
    return;
    end if;
    -- No se debe tener en cuenta la ultima cuenta de cobro generada en
    -- el periodo si aun no ha cumplido la fecha de pago.
    nuUltCtaCobro := pkAccountMgr.fnuGetLastAccountServ( inuNumeServ );
    dtFechaPago   := trunc( pktblCuencobr.fdtGetPayDate( nuUltCtaCobro ) );
    if ( dtFechaPago > trunc( sysdate ) ) then
    nuCtasSaldo := nuCtasSaldo - 1;
    end if;
    if  (  ( nuCtasSaldo > nuMaxNoFacVenc ) and
         pkServNumberMgr.fboWithBalance( inuNumeServ ) )
    then
         pkErrors.SetErrorCode( pkConstante.csbDIVISION,
                pkConstante.csbMOD_BIL,
                cnuSERV_NO_PAZ_Y_SALVO );
         raise LOGIN_DENIED;
    end if;
    pkErrors.pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        -- Error Oracle nivel dos
        pkErrors.pop;
    raise pkConstante.exERROR_LEVEL2;
    when OTHERS then
    pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
    pkErrors.pop;
    raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);
END;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    ValBasicData
    Descripcion    :    Valida si el numero de servicio existe
            Valida si el numero de servicio es nulo
            Valida si el numero de servicio es el
            nulo de la aplicacion
    Parametros    :        Descripcion
        inuNumServ    Numero de servicio
    Retorno    :
    Autor    :    rcalixto
    Fecha    :    14-Jul-1999
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

procedure ValBasicData
    (
        inuNumServ    in    servsusc.sesunuse%type
    )
    is
BEGIN
    pkErrors.Push('pkServNumberMgr.ValBasicData');
    -- Valida si el numero de servicio es nulo
    ValidateNull ( inuNumServ ) ;
    -- Valida si el numero de servicio es el nulo de la aplicacion
    ValidateNullApp ( inuNumServ ) ;
    -- Valida si el numero de servicio existe
    pktblServSusc.AccKey( inuNumServ );
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValBasicData;

/*
    Propiedad intelectual de Open International Systems. (c).

    Procedure   : ValDischargeableServsusc
    Descripcion : Valida que el servicio suscrito sea descargable
                  para terceros.

    Parametros  :       Descripcion
        inuSesunuse     Codigo servicio suscrito
    Retorno     :

    Autor       :       kmarcos
    Fecha       :       17-Dic-2001

    Historia de Modificaciones
    Fecha       Id Entrega

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    13-Nov-2003 jcastroSAO24868
    Se modifica el metodo para eliminar la validacion de la existencia de
    Diferidos con Saldo, que se hacia por medio del llamado al servicio
    pkDeferredMgr.ValServiceWithoutDeferredBal. Como ahora los Diferidos
    con Saldo se trasladan a Corriente durante el proceso de la Descarga,
    esta validacion ya no tiene ningun sentido hacerla. Open Cali.

    25-Sep-2002 kmarcosSAO10620.01
    Se adiciona validacion de que el servicio suscrito no tenga cargos
    de terceros en la cuenta -1.

    17-Dic-2001 kmarcosOP8916.01
    Creacion.
*/

procedure ValDischargeableServsusc
(
    inuSesunuse    in    servsusc.sesunuse%type
)
is
BEGIN
--{
    pkErrors.Push('pkServNumberMgr.ValDischargeableServsusc');

    -- Valida que el servicio suscrito sea facturable
    pkServNumberMgr.ValIsBillableServNumber (inuSesunuse);

    -- Valida que el servicio suscrito no tenga valor en reclamo
    pkServNumberMgr.ValWithoutClaim (inuSesunuse);

    -- Valida que el servicio suscrito no tenga cargos de
    -- Terceros en la cuenta -1
    pkServNumberMgr.ValNotThirdChargeInNulAcc (inuSesunuse);

    pkErrors.Pop;

    EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
END ValDischargeableServsusc;

/*
    Propiedad intelectual de Open International Systems. (c).

    Procedure   : ValDischargeSubsServ
    Descripcion : Valida que el Servicio Suscrito sea descargable
                  para Terceros de cobro

    Parametros  :       Descripcion
        inuSesunuse     Codigo del Servicio Suscrito
    Retorno     :

    Autor       :       Juan Carlos Castro Prado
    Fecha       :       22-Oct-2003

    Historia de Modificaciones
    Fecha       ID Entrega
    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG


    22-Oct-2003 jcastroSAO17716
    Creacion del objeto. Se crea con base en el servicio
    ValDischargeableServsusc. Se utiliza para el manejo de
    Terceros por Conceptos. Open Cali.
*/

procedure ValDischargeSubsServ
(
    inuSesunuse    in    servsusc.sesunuse%type
)
is
BEGIN
--{
    pkErrors.Push ('pkServNumberMgr.ValDischargeSubsServ');

    -- Valida que el servicio suscrito sea facturable
    pkServNumberMgr.ValIsBillableServNumber (inuSesunuse);

    -- Valida que el servicio suscrito no tenga valor en reclamo
    pkServNumberMgr.ValWithoutClaim (inuSesunuse);

    -- Valida que el servicio suscrito no tenga cargos de
    -- Terceros en la cuenta -1
    pkServNumberMgr.ValThirdChargeInNullAcc (inuSesunuse);

    pkErrors.Pop;

    EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    when others then
        pkErrors.NotifyError (pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.Pop;
        raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
--}
END ValDischargeSubsServ;

/*
    Propiedad intelectual de Open International Systems. (c).
    Procedimiento:    ValHasAccountsWithBalance
            Validate Has Accounts With Balance

    Descripcion     :    Valida si el servicio suscrito tiene cuentas con
            saldo.

    Parametros     :    Descripcion
    Retorno     :
    ------------------------------------------------------------------------
    Metodos Encapsulados
    ------------------------------------------------------------------------
    ************************************************************************
    Procedimiento :
    Descripcion      :
    ************************************************************************
    Funcion      :
    Descripcion      :
    ************************************************************************
    ------------------------------------------------------------------------
    Fin Metodos Encapsulados
    ------------------------------------------------------------------------
    Autor     :    Katalina Marcos
    Fecha     :    13-Sep-2002
    Historia de Modificaciones
    Fecha    IDEntrega
    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    24-Sep-2002 kmarcosSAO14658.01
    Se modifica la validacion. Ya no se verifica el numero de cuentas
    vencidas (pkAccountMgr.fnuGetAccNumBalanceService), se examina
    solamente el campo cuentas con saldo del servicio suscrito.
    13-Sep-2002 kmarcosSAO12823.01
    Creacion del objeto.
*/
PROCEDURE ValHasAccountsWithBalance
(
    inuServsusc  in  servsusc.sesunuse%type
)
IS
    --------------------------------------------------------------------
    -- Constants
    --------------------------------------------------------------------
    -- El servicio tiene cuentas con saldo
    cnuTIENECUENTASALDO constant number := 12030;
    --------------------------------------------------------------------
    -- Variables
    --------------------------------------------------------------------
    -- Numero de cuentas con saldo
    nuAccWithBalance number;
    --------------------------------------------------------------------
    -- Cursors
    --------------------------------------------------------------------
BEGIN
    pkErrors.Push('pkServNumberMgr.ValHasAccountsWithBalance');
    -- Obtiene el numero de cuentas con saldo del servicio suscrito   pkbccuencobr
    nuAccWithBalance := pkbccuencobr.fnuGetBalAccNum(inuServsusc);
    -- Si el numero de cuentas con saldo es mayor a cero, devuelve un
    -- mensaje de error
    if (nuAccWithBalance > 0) then
    pkErrors.SetErrorCode ( pkConstante.csbDIVISION,
                pkConstante.csbMOD_BIL,
                cnuTIENECUENTASALDO
                  );
        raise LOGIN_DENIED;
    end if;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValHasAccountsWithBalance;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    ValIsBillableServNumber
    Descripcion    :    Valida que el servicio suscrito este facturable
    Parametros    :        Descripcion
        inuNumServ    Numero de servicio
    inuCACHE    1- Buscar data en Cache        ( Default )
            0- Buscar data en base de datos
    Retorno    :
    Autor    :    Ricardo Calixto
    Fecha    :    Julio 14 del 2000
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

PROCEDURE ValIsBillableServNumber
    (
        inuNumServ    in    servsusc.sesunuse%type,
    inuCACHE    in    number default 1
    )
    IS
    cnuSERV_NO_FACTURABLE      constant number := 10098;    -- Serv. no fact.
BEGIN
    pkErrors.Push('pkServNumberMgr.ValIsBillableServNumber');
    -- Evalua si el servicio suscrito esta no esta facturable
    if ( not fboIsBillable ( inuNumServ, inuCACHE ) ) then
    -- El servicio suscrito no se encuentra facturable
    pkErrors.SetErrorCode(  pkConstante.csbDIVISION,
                pkConstante.csbMOD_BIL,
                cnuSERV_NO_FACTURABLE );
    raise LOGIN_DENIED;
    end if;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValIsBillableServNumber;

/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    ValIsProvisionalLine
    Descripcion    :    Valida que el servicio suscrito tenga peticiones
            de retiro de linea.

            Validate WithDraw Line Request
    Parametros    :        Descripcion
        inuNumServ    Numero de servicio
    inuCACHE    1- Buscar data en Cache        ( Default )
            0- Buscar data en base de datos
    Retorno    :
    Autor    :    David Julian Lopez V -julopez-
    Fecha    :    24-Abr-2001
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

PROCEDURE ValIsProvisionalLine
    (
        inuNumServ    in    servsusc.sesunuse%type,
    inuCACHE    in    number default 1
    )
    IS
    -- El servicio suscrito es una linea provisional
    cnuSERV_SUSC_IS_PROV  constant number := 11011;
BEGIN
    pkErrors.Push('pkServNumberMgr.ValIsProvisionalLine');
    -- Evalua si el servicio suscrito es provisional
    if ( fblIsProvisionalLine ( inuNumServ, inuCACHE ) ) then
    -- El servicio suscrito tiene peticion retiro de linea
    pkErrors.SetErrorCode(  pkConstante.csbDIVISION,
                pkConstante.csbMOD_CUS,
                cnuSERV_SUSC_IS_PROV );
    raise LOGIN_DENIED;
    end if;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValIsProvisionalLine;


/*
    Propiedad intelectual de Open International Systems (c).
    Procedure    :    ValMaxNumBillWithBal
    Descripcion    :    Valida que el servicio suscrito tenga un numero menor de
            cuentas con saldo al parametro dado o al maximo
            configurado en el sistema.
    Parametros    :    Descripcion
    Retorno    :
    Autor    :    Lilianir
    Fecha    :    10-Abr-2002
    Historia de Modificaciones
    Fecha       IdEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
  10-Abr-2002  lilianir se adiciona constante para identificar el

            mensaje de error de numero  maximo cuentas
            vencidas.
*/
PROCEDURE ValMaxNumBillWithBal
    (
    inuServSuscCodi   in    servsusc.sesunuse%type,
    inuMaxCtas        in    number--pkbcservsusc.stysesucusa
    )
IS
    -- Numero de Cuentas con Saldo
    nuCtasSaldo          pkbcsuscripc.stysusccusa;
    -- Maximo numero de facturas vencidas permitidas
    nuMaxNoFacVenc          parametr.pamenume%type;
    -- Mensaje de error para numero mayor de cuentas con saldo
    cnuSUSC_MAYOR_CTASALD     constant number := 11000;
BEGIN
    pkErrors.Push('pkServNumberMgr.ValMaxNumBillWithBal');
    -- Obtiene el numero de cuentas con saldo
    nuCtasSaldo := pkAccountMgr.fnuGetAccNumBalanceService ( inuServSuscCodi );

    -- Obtiene parametro de facturacion de numero maximo de cuentas vencidas
    nuMaxNoFacVenc := nvl ( inuMaxCtas, pktblParafact.fnuGetMaxPendAcc
                        ( pkConstante.SISTEMA ) );
    -- En caso de que el numero de cuentas con saldo sea mayor.
    if ( nuCtasSaldo > nuMaxNoFacVenc ) then
         pkErrors.SetErrorCode( 'OPF', 'BIL', cnuSUSC_MAYOR_CTASALD );
     raise LOGIN_DENIED;
    end if;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValMaxNumBillWithBal;
/*
    Propiedad intelectual de Open International Systems (c).
    Procedure    :    ValMinNumBillWithBal
    Descripcion    :    Valida que el servicio suscrito tenga un numero mayor de
            cuentas con saldo al parametro dado o al minimo
            configurado en el sistema.
    Parametros    :    Descripcion
    Retorno    :
    Autor    :    Lilianir
    Fecha    :    10-Abr-2002
    Historia de Modificaciones
    Fecha       IdEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    10-Abr-2002  lilianir se adiciona constante para identificar el

            mensaje de error de numero  minimo cuentas
            vencidas.
*/
PROCEDURE ValMinNumBillWithBal
    (
    inuServSuscCodi   in    servsusc.sesunuse%type,
    inuMinCtas        in    number--pkbcservsusc.stysesucusa
    )
IS
    -- Numero de Cuentas con Saldo
    nuCtasSaldo            pkbcsuscripc.stysusccusa;
    -- Mensaje de error para numero mayor de cuentas con saldo
    cnuSUSC_MENOR_CTASALD     constant number := 11607;
BEGIN
    pkErrors.Push('pkServNumberMgr.ValMinNumBillWithBal');
    -- Obtiene el numero de cuentas con saldo
    nuCtasSaldo := pkAccountMgr.fnuGetAccNumBalanceService ( inuServSuscCodi );

    -- En caso de que el numero de cuentas con saldo sea mayor.
    if ( nuCtasSaldo < inuMinCtas  ) then
         pkErrors.SetErrorCode( 'OPF', 'BIL', cnuSUSC_MENOR_CTASALD );
     raise LOGIN_DENIED;
    end if;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValMinNumBillWithBal;
/*
    Propiedad intelectual de Open International Systems. (c).

    Procedimiento:    ValNotThirdChargeInNulAcc
                    Validate Servsusc has not Third Charges In Null
                    Account
    Descripcion     :    Valida que el servicio suscrito no tenga cargos
                    de terceros en la cuenta -1

    Parametros     :    Descripcion
    Retorno     :
    ------------------------------------------------------------------------
    Metodos Encapsulados
    ------------------------------------------------------------------------
    ************************************************************************
    Procedimiento :
    Descripcion      :
    ************************************************************************
    Funcion      :
    Descripcion      :
    ************************************************************************
    ------------------------------------------------------------------------
    Fin Metodos Encapsulados
    ------------------------------------------------------------------------

    Autor     :    Katalina Marcos
    Fecha     :    26-Sep-2002

    Historia de Modificaciones
    Fecha    IDEntrega
    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG


    26-Sep-2002 kmarcosSAO10620.01
    Creacion del objeto.
*/

PROCEDURE ValNotThirdChargeInNulAcc
(
    inuServsusc  in  servsusc.sesunuse%type
)
IS
    --------------------------------------------------------------------
    -- Variables
    --------------------------------------------------------------------
    --------------------------------------------------------------------
    -- Cursors
    --------------------------------------------------------------------
BEGIN
    pkErrors.Push('pkServNumberMgr.ValNotThirdChargeInNulAcc');

    -- Si el servicio tiene cargos de terceros en la cuenta -1

    if (fblHasSesuThirdChargesInNulAcc (inuServsusc)) then
    --{
        pkErrors.SetErrorCode (pkConstante.csbDIVISION,
                               pkConstante.csbMOD_BIL,
                               cnuCARGTERCCUCONULA);
        raise LOGIN_DENIED;
    --}
    end if;

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    when others then
        pkErrors.NotifyError (pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.Pop;
        raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
END ValNotThirdChargeInNulAcc;

/*
    Propiedad intelectual de Open International Systems. (c).

    Procedimiento:    ValThirdChargeInNullAcc
                    Validate Subscriber Service has Third Charges In Null
                    Account
    Descripcion     :    Valida si el Servicio Suscrito tiene cargos de
                    Terceros en la Cuenta de Cobro -1

    Parametros     :    Descripcion
    Retorno     :
    ------------------------------------------------------------------------
    Metodos Encapsulados
    ------------------------------------------------------------------------
    ************************************************************************
    Procedimiento :
    Descripcion      :
    ************************************************************************
    Funcion      :
    Descripcion      :
    ************************************************************************
    ------------------------------------------------------------------------
    Fin Metodos Encapsulados
    ------------------------------------------------------------------------

    Autor     :    Juan Carlos Castro Prado
    Fecha     :    22-Oct-2003

    Historia de Modificaciones
    Fecha    IDEntrega
    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG


    22-Oct-2003 jcastroSAO17716
    Creacion del objeto. Se crea con base en el servicio
    ValNotThirdChargeInNulAcc. Se utiliza para el manejo de
    Terceros por Conceptos. Open Cali.
*/

PROCEDURE ValThirdChargeInNullAcc
(
    inuServsusc  in  servsusc.sesunuse%type
)
IS
    --------------------------------------------------------------------
    -- Constants
    --------------------------------------------------------------------
    --------------------------------------------------------------------
    -- Variables
    --------------------------------------------------------------------
    --------------------------------------------------------------------
    -- Cursors
    --------------------------------------------------------------------
BEGIN
    pkErrors.Push ('pkServNumberMgr.ValThirdChargeInNullAcc');

    -- Varifica si el Servicio Suscrito tiene cargos de Terceros en la
    -- Cuenta de Cobro -1

    if ( fblHasThirdChargesNullAcc (inuServsusc) ) then
    --{
        pkErrors.SetErrorCode (pkConstante.csbDIVISION,
                               pkConstante.csbMOD_BIL,
                               cnuCARGTERCCUCONULA);
        raise LOGIN_DENIED;
    --}
    END if;

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    when others then
        pkErrors.NotifyError (pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.Pop;
        raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
--}
END ValThirdChargeInNullAcc;

/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    ValNumDaysForWithDraw
    Descripcion    :    Valida el numero de dias que debe permanecer el
            servicio en retiro temporal antes de retiro
            definitivo.
    Parametros    :        Descripcion
        inuNumeServ    Numero de servicio
    Retorno    :
    Autor    :    Ricardo Calixto
    Fecha    :    28-Jun-2000
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

procedure ValNumDaysForWithDraw
    (
        inuNumeServ    in    servsusc.sesunuse%type
    )
    is
    rcServSusc    servsusc%rowtype ;    -- Registro de servsusc
    rcConfcose    confcose%rowtype ;    -- Registro de confcose
    nuNO_CUMPLE_NRO_DIAS    constant number := 1308 ;
BEGIN
    pkErrors.Push('pkServNumberMgr.ValNumDaysForWithDraw');
    -- Obtiene el registro del numero de servicio
    rcServsusc := pktblServSusc.frcGetRecord (  inuNumeServ,
                        pkConstante.NOCACHE );
    -- Obtiene el registro de configuracion de corte del servicio
    rcConfcose := pktblConfcose.frcGetRecord (  rcServsusc.sesuserv,
                        pkConstante.NOCACHE );
    -- Evalua si el tiempo de servicio del telefono ha sido suficiente
    -- para permitir un retiro
    if ( sysdate - rcServsusc.sesufere < rcConfcose.cocsndrl ) then
    -- El numero de servicio no ha permanecido el tiempo necesario
    -- segun la configuracion del corte del servicio
    pkErrors.SetErrorCode ( pkConstante.csbDIVISION,
                pkConstante.csbMOD_SAT,
                nuNO_CUMPLE_NRO_DIAS );
    raise LOGIN_DENIED ;
    end if ;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when OTHERS then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValNumDaysForWithDraw;
/*
    Propiedad intelectual de Open International Systems (c).
    Procedure    :    ValPositiveBalance
    Descripcion    :    Valida que el servicio suscrito tenga saldo a favor
            Validate Service Positive Balance
    Parametros    :    Descripcion
    inuNumeServ    Codigo del servicio suscrito
    inuCACHE    1- Buscar en cache
            0- Buscar directamente en la base de datos
    Retorno    :
    Autor    :    Felicia Otero Diaz
    Fecha    :    Diciembre 05 del 2001
    Historia de Modificaciones
    Fecha       IdEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
    Modificacion
    05-Dic-2001    foteroOP8984
    Creacion del procedimiento
*/
PROCEDURE ValPositiveBalance
    (
        inuNumeServ    in    servsusc.sesunuse%type,
    inuCACHE    in    number default 1
    )
    IS
        -- no tiene saldo a favor
    cnuNO_SALDO_FAVOR        constant number := 11005;
    nuValorSalFav            servsusc.sesusafa%type;    -- valor saldo a favor

BEGIN
    pkErrors.Push('pkServNumberMgr.ValPositiveBalance');
    -- Obtiene el valor del saldo a favor

    nuValorSalFav := pktblservsusc.fnuGetPositiveBal
                     (
                     inuNumeServ,
                     inuCACHE
                     );
    if (nuValorSalFav is null) or (nuValorSalFav=0) then

    pkErrors.SetErrorCode ( pkConstante.csbDIVISION,
                pkConstante.csbMOD_BIL,
                cnuNO_SALDO_FAVOR );
    raise LOGIN_DENIED;
    end if;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValPositiveBalance;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    ValSubscription
    Descripcion    :    Valida si la suscripcion es la misma del servicio suscrito
            Validate Subscription
    Parametros    :        Descripcion
    inuSusc        Codigo de la suscripcion
        inuNumServ    Numero de servicio
    Retorno    :
    Autor    :    Carlos Alberto Quintero
    Fecha    :    25.may.2000
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

procedure ValSubscription
    (
    inuSusc        in    servsusc.sesususc%type,
        inuNumServ    in    servsusc.sesunuse%type
    )
    is
    nuSusc    suscripc.susccodi%type;        -- Suscripcion del servicio suscrito
            -- El servicio suscrito no pertenece a la suscripcion dada
    cnuSUSCRIPCION_ERRADA    constant number := 9310;
BEGIN
    pkErrors.Push('pkServNumberMgr.ValSubscription');
    -- Obtiene la suscripcion del servicio suscrito
    nuSusc := pktblServSusc.fnuGetSuscription( inuNumServ );
    -- El servicio suscrito no pertenece a la suscripcion dada
    if ( inuSusc != nuSusc ) then
    pkErrors.SetErrorCode(  pkConstante.csbDIV_GES,
                pkConstante.csbMOD_LIQ,
                cnuSUSCRIPCION_ERRADA );
    raise LOGIN_DENIED;
    end if;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValSubscription;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    ValTimeForBilling
    Descripcion    :    Valida el tiempo necesario de vigencia del servicio
            suscrito para que se pueda facturar.
            Se valida con respecto al numero minimo de dias para
            facturacion que se define en los parametros de
            facturacion.
            Validate Time For Billing
    Parametros    :        Descripcion
        inuNumeServ    Numero de servicio
    inuPeriodoCurr    Codigo del periodo de facturacion current
    inuCACHE    parametro para saber si busca data en cache o
            accesa la base de datos
            1 - Buscar en cache primero ( Default )
            0 - Accesar directamente la Base de datos
    Retorno    :
    Autor    :    Carlos Alberto Quintero
    Fecha    :    Septiembre 20 del 2000
    Historia de Modificaciones
    Fecha    Autor    Modificacion

    11-02-2011  jfrojasSAO139346
    Se reemplaza el llamado al metodo <pkBillingParamMgr.GetMinDaysBill> por
    <pktblServicio.fnuGetBillMinimunDays> para obtener el numero de dias minimos
    para facturar a partir del servicio.

    10-Jun-2009 jgtorresSAO96378
    Se cambian las referencias a pefafefi por pefaffmo.

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    20.sep.2000    Caq    Creacion del procedimiento

*/
PROCEDURE ValTimeForBilling
    (
    inuNumeServ    in    servsusc.sesunuse%type,
    inuPeriodoCurr    in    perifact.pefacodi%type default null,
    inuCACHE    in    number default pkConstante.CACHE
    )
    IS
            -- Periodo de facturacion current
    nuPeriodoFact    perifact.pefacodi%type;
            -- Fecha de ingreso del servicio suscrito
    dtFechaIngreso    servsusc.sesufein%type;
            -- Fecha final del periodo de facturacion current
    dtFechaFinPeriodo    perifact.pefaffmo%type;
    -- Numero de dias minimos a facturar
    nuDiasMinBilling    servicio.servdimi%type;
            -- Mensaje de error indicando que no se debe facturar
            -- el servicio por que no cumple con el tiempo minimo
    cnuNO_CUMPLE_NRO_DIAS    constant number := 10137 ;
    -- Tipo de servicio
    nuServicio       servsusc.sesuserv%type;
BEGIN
    pkErrors.Push('pkServNumberMgr.ValTimeForBilling');

    --Obtiene el tipo de servicio
    nuServicio := pktblServsusc.fnugetservice (
                        inuNumeServ,
                        inuCACHE
                    );

    -- Obtiene el numero de dias minimos a facturar
    nuDiasMinBilling := pktblServicio.fnuGetBillMinimunDays(nuServicio);

    -- Obtiene la fecha de activacion del servicio suscrito
    dtFechaIngreso := pktblServsusc.fdtGetInstallationDate
                    (
                        inuNumeServ,
                        inuCACHE
                    );
    -- Periodo de facturacion current
    nuPeriodoFact := inuPeriodoCurr;
    -- Evalua si se dio el periodo current en los parametros
    if ( inuPeriodoCurr is null ) then
    -- Obtiene periodo current
    pkServNumberMgr.AccCurrentPeriod
        (
        inuNumeServ,
        nuPeriodoFact,
        inuCACHE
        );
    end if;
    -- Obtiene fecha final del periodo current
    dtFechaFinPeriodo := pktblPerifact.fdtGetEndDate
                    (
                        nuPeriodoFact,
                        inuCACHE
                    );
    -- Evalua que tenga tiempo minimo para facturacion
    if ( dtFechaIngreso > ( dtFechaFinPeriodo - nuDiasMinBilling ) ) then
    -- No se debe facturar el servicio suscrito
    pkErrors.SetErrorCode
        (
        pkConstante.csbDIVISION,
        pkConstante.csbMOD_BIL,
        cnuNO_CUMPLE_NRO_DIAS
        );
    raise LOGIN_DENIED;
    end if;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when OTHERS then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValTimeForBilling;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    ValWithDrawLineRequest
    Descripcion    :    Valida que el servicio suscrito tenga peticiones
            de retiro de linea.

            Validate WithDraw Line Request
    Parametros    :        Descripcion
        inuNumServ    Numero de servicio
    inuCACHE    1- Buscar data en Cache        ( Default )
            0- Buscar data en base de datos
    Retorno    :
    Autor    :    David Julian Lopez V -julopez-
    Fecha    :    20-Abr-2001
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

PROCEDURE ValWithDrawLineRequest
    (
        inuNumServ    in    servsusc.sesunuse%type,
    inuCACHE    in    number default 1
    )
    IS
    -- El servicio suscrito no tiene peticion retiro de linea
    cnuSERV_SUSC_CON_PETI_RETI  constant number := 11009;
BEGIN
    pkErrors.Push('pkServNumberMgr.ValWithDrawLineRequest');
    -- Evalua si el servicio suscrito tiene peticion de retiro de linea
    if ( fboWithDrawLineRequest( inuNumServ, inuCACHE ) ) then
    -- El servicio suscrito tiene peticion retiro de linea
    pkErrors.SetErrorCode(  pkConstante.csbDIVISION,
                pkConstante.csbMOD_CUS,
                cnuSERV_SUSC_CON_PETI_RETI );
    raise LOGIN_DENIED;
    end if;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValWithDrawLineRequest;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    ValWithoutClaim
    Descripcion    :    Valida que el servicio suscrito no tenga reclamos
            pendientes
            Validate Without Claim
    Parametros    :        Descripcion
        inuNumServ    Numero de servicio
    inuCACHE    1- Buscar data en Cache        ( Default )
            0- Buscar data en base de datos
    Retorno    :
    Autor    :    Carlos Alberto Quintero
    Fecha    :    Junio 16 del 2000
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

PROCEDURE ValWithoutClaim
    (
        inuNumServ    in    servsusc.sesunuse%type,
    inuCACHE    in    number default 1
    )
    IS
    -- El servicio suscrito tiene valor en reclamo
    cnuSERV_SUSC_CON_RECL_PEND  constant number := 10049;
BEGIN
    pkErrors.Push('pkServNumberMgr.ValWithoutClaim');
    -- Evalua si el servicio suscrito tiene valor en reclamo
    if ( fboWithClaim( inuNumServ, inuCACHE ) ) then
    -- El servicio suscrito tiene valor en reclamo
    pkErrors.SetErrorCode(  pkConstante.csbDIVISION,
                pkConstante.csbMOD_BIL,
                cnuSERV_SUSC_CON_RECL_PEND );
    raise LOGIN_DENIED;
    end if;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValWithoutClaim;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :      ValWithoutNonAppPayClaim
    Descripcion    :    Valida que el servicio suscrito no tenga reclamos
                        pendientes por pago no abonado

            Validate Without Non Applied Payment Claim

    Parametros    :        Descripcion
        inuNumServ    Numero de servicio

        inuCACHE    1- Buscar data en Cache        ( Default )
                    0- Buscar data en base de datos

    Retorno    :
    Autor    :    Carlos Alberto Quintero
    Fecha    :    Marzo 27 del 2002
    Historia de Modificaciones
    Fecha    ID Entrega

    12-12-2012  dhurtadoSAO197798
    [
        Se modifica la asignacion de error, se utiliza el estandar de BSS. Se
        cambia pkErrors.SetErrorCode
        por Errors.SetError( cnuSERV_SUSC_CON_RECL_PEND ).

        Se modifica el literal de la variable cnuSERV_SUSC_CON_RECL_PEND.
    ]

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    27-mar-2002    cquinteroSAE7449.01

    Creacion
*/
PROCEDURE ValWithoutNonAppPayClaim
    (
        inuNumServ    in    servsusc.sesunuse%type,
    inuCACHE    in    number default 1
    )
    IS
    -- El servicio suscrito tiene valor en reclamo por pago no abonado
    cnuSERV_SUSC_CON_RECL_PEND  constant number := 901911;
BEGIN
    pkErrors.Push ('pkServNumberMgr.ValWithoutNonAppPayClaim');
    -- Evalua si el servicio suscrito tiene reclamo por pago no abonado
    if ( fblWithNonAppliedPayClaim (inuNumServ, inuCACHE) ) then
    -- El servicio suscrito tiene reclamo por pago no abonado
        Errors.SetError( cnuSERV_SUSC_CON_RECL_PEND );
        pkErrors.Pop;
        raise LOGIN_DENIED;
    end if;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValWithoutNonAppPayClaim;


/*
    Propiedad intelectual de Open International Systems (c).
    Procedure   :  ValidateIsActive.sql
    Descripcion :  Valida que el numero este activo.
    Parametros  :       Descripcion
        Entrada:
          inuServiceNumber  numero de servico
    Autor       :  Rsegovia
    Fecha       :  24-11-2000
    Historia de Modificaciones
    Fecha       IdEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
*/
PROCEDURE ValidateIsActive
    (
        inuServNumb    in     servsusc.sesunuse%type
    )
IS
    nuActiveStatus   number;
    dtRetireDate servsusc.sesufere%type;
BEGIN
    pkErrors.Push ('pkServNumberMgr.ValidateIsActive');

    dtRetireDate:= pktblServSusc.fdtGetRetireDate(inuServNumb);

    if(dtRetireDate < sysdate) then
       pkErrors.SetErrorCode( cnuNUME_SERV_NOACTIVO );
       raise LOGIN_DENIED;
    END if;

    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
            pkErrors.Pop;
            raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValidateIsActive;


/*
    Propiedad intelectual de Open Systems (c)
    Procedimiento :        ValidateIsServiceRated
    Descripcion   :        Procedimiento que valida si el servicio suscrito
                        corresponde a un servicio tasado.
                        Si el servicio no es tasado se genera un RAISE
                        indicando que el servicio NO es tasado.
    Parametros:
        inuServiceNumber   Numero de Servicio suscrito
    Retorna:
    Autor:   Sandra Patricia Castrillon Vargas
    Fecha:   14-Ene-2002
    Historia de Modificaciones
    Autor              Fecha       Descripcion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    spcastriSAE8240    14-02-2002    Creacion del metodo.

*/
procedure ValidateIsServiceRated
(
    inuServiceNumber     in  servsusc.sesunuse%type
)
is
    nuServicioNoTasado    constant    number := 10265;
BEGIN
    pkErrors.Push ('pkServNumberMgr.ValidateIsServiceRated');
    -- Valida si el servicio es tasado o no
    if ( not fblIsServiceRated( inuServiceNumber ) )
    then
        pkErrors.SetErrorCode(  pkconstante.csbDIVISION,
                                pkconstante.csbMOD_BIL, nuServicioNoTasado );
        raise login_denied;
    end if;
    pkErrors.pop;
EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValidateIsServiceRated;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    ValidateNull
    Descripcion    :    Valida si el numero de servicio es nulo
            Validate Null
    Parametros    :        Descripcion
        inuNumServ    Numero de servicio
    Retorno    :
    Autor    :    cquinter
    Fecha    :    11-MAR-1999
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16.abr.1999    Caq    Maneja excepcion Oracle Nivel 2

*/
procedure ValidateNull
    (
        inuNumServ    in    servsusc.sesunuse%type
    )
    is
BEGIN
    pkErrors.Push('pkServNumberMgr.ValidateNull');
    -- Valida si el numero de servicio es nulo
    if ( inuNumServ is null ) then
    raise LOGIN_DENIED;
    end if;
    pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED then
    pkErrors.SetErrorCode( nuNUME_SERV_NULO );
    pkErrors.Pop;
    raise;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValidateNull;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    ValidateNullApp
    Descripcion    :    Valida si el numero de servicio es nulo aplicacion
            Validate Null Application
    Parametros    :        Descripcion
        inuNumServ    Numero de servicio
    Retorno    :
    Autor    :    cquinter
    Fecha    :    11-MAR-1999
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16.abr.1999    Caq    Maneja excepcion Oracle Nivel 2

*/
procedure ValidateNullApp
    (
        inuNumServ    in    servsusc.sesunuse%type
    )
    is
BEGIN
    pkErrors.Push('pkServNumberMgr.ValidateNullApp');
    -- Valida si el numero de servicio es -1
    if ( inuNumServ = pkBillConst.NULOSAT ) then
    raise LOGIN_DENIED;
    end if;
    pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED then
    pkErrors.SetErrorCode( nuNUME_SERV_NULOSAT );
    pkErrors.Pop;
    raise;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValidateNullApp;

/*
    Propiedad intelectual de Open International Systems. (c).
    Procedimiento:    ValidateRightService
            Validate Rigth Service

    Descripcion     :    Valida que el servicio suscrito si tenga el
            servicio del parametro

    Parametros     :    Descripcion
    Retorno     :
    ------------------------------------------------------------------------
    Metodos Encapsulados
    ------------------------------------------------------------------------
    ************************************************************************
    Procedimiento :
    Descripcion      :
    ************************************************************************
    Funcion      :
    Descripcion      :
    ************************************************************************
    ------------------------------------------------------------------------
    Fin Metodos Encapsulados
    ------------------------------------------------------------------------
    Autor     :    Katalina Marcos
    Fecha     :    13-Sep-2002
    Historia de Modificaciones
    Fecha    IDEntrega
    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    13-Sep-2002 kmarcosSAO12823.01
    Creacion del objeto.
*/
PROCEDURE ValidateRightService
(
    inuServsusc  in  servsusc.sesunuse%type,
    inuService   in  servicio.servcodi%type
)
IS
    --------------------------------------------------------------------
    -- Constants
    --------------------------------------------------------------------
    -- El servicio suscrito no pertenece al servicio
    cnuMALSERVICIO constant number := 12035;
    --------------------------------------------------------------------
    -- Variables
    --------------------------------------------------------------------
    -- Servicio
    nuService  servicio.servcodi%type;
    --------------------------------------------------------------------
    -- Cursors
    --------------------------------------------------------------------
BEGIN
    pkErrors.Push('pkServNumberMgr.ValidateRightService');
    -- Obtiene el servicio del servicio suscrito
    nuService := pktblServsusc.fnuGetService(inuServsusc,pkConstante.CACHE);
    -- Si el servicio no coincide con el servicio de entrada levante error
    if (nuService <> inuService) then
    pkErrors.SetErrorCode ( pkConstante.csbDIVISION,
                pkConstante.csbMOD_BIL,
                cnuMALSERVICIO
                  );
        raise LOGIN_DENIED;
    end if;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValidateRightService;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    ValidateWithBalance
    Descripcion    :    Valida que el servicio suscrito tenga saldo pendiente
            Validate With Balance
    Parametros    :        Descripcion
        inuNumServ    Numero de servicio
    inuCACHE    1- Buscar data en Cache        ( Default )
            0- Buscar data en base de datos
    Retorno    :
    Autor    :    Carlos Alberto Quintero
    Fecha    :    Junio 16 del 2000
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

PROCEDURE ValidateWithBalance
    (
        inuNumServ    in    servsusc.sesunuse%type,
    inuCACHE    in    number default 1
    )
    IS
                    -- El servicio suscrito no tiene saldo pendiente
    cnuSERV_SUSC_SIN_SALDO      constant number := 10002;
BEGIN
    pkErrors.Push('pkServNumberMgr.ValidateWithBalance');
    -- Evalua si el servicio suscrito tiene saldo pendiente
    if ( not fboWithBalance( inuNumServ, inuCACHE ) ) then
    -- El servicio suscrito no tiene saldo pendiente
    pkErrors.SetErrorCode(  pkConstante.csbDIVISION,
                pkConstante.csbMOD_BIL,
                cnuSERV_SUSC_SIN_SALDO );
    raise LOGIN_DENIED;
    end if;
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValidateWithBalance;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    WithDrawServNumber
    Descripcion    :    Retira servicio. Inserta detalle historico de retiro.
            Coloca datos del suscriptor en historico de retiros .
            Atiende peticion de retiro.
            Anula peticiones pendientes.
    Parametros    :        Descripcion
        inuNumeServ    Numero de servicio
    inuMotiSusp     Motivo de suspension
    isbActaReti     Acta retiro
    Retorno    :
    Autor    :    Ricardo Calixto
    Fecha    :    28-Jun-2000
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

procedure WithDrawServNumber
    (
    inuNumeServ    in    servsusc.sesunuse%type,
    inuMotiSusp     in      histreti.hsremosu%type,
    isbActaReti     in      histreti.hsreacre%type
    )
    is
    nuTELEF_CAMBNUM  pkbcservsusc.stysesuessv;    -- Est. pendiente liberar
    /* ***************************************************************** */
    /* ********           Procedimientos Encapsulados           ******** */
    /* ***************************************************************** */
    /*
    Procedure    :    TransDataServNumber
    Descripcion  :    Traslada Datos del numero de servicio a
                historico de retiro.
                Insertar en historico de retiro detalle deuda
                los cargos.
    */
    procedure TransDataServNumber is
    BEGIN
    pkErrors.Push('pkServNumberMgr.TransDataServNumber');
    -- Se trasladan los datos del servicio al historico de retiro
    pkTransDatWithDrawHistMgr.TransDataServNumber ( inuNumeServ,
                            inuMotiSusp,
                            isbActaReti );
    pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;
    END TransDataServNumber;
    /*
    Procedure    :    RequestAttendace
    Descripcion    :    Atender peticion de retiro
    */
    procedure RequestAttention
    is
    BEGIN
    pkErrors.Push('pkServNumberMgr.RequestAttention');
    pkErrors.Pop;
    END RequestAttention;
    /*
    Procedure    :    AttSpecialServReq
    Descripcion    :    Atiende peticiones de desconexion de
                servicios suplementarios
    */
    procedure AttSpecialServReq
    is
    nuDESCONEXION      number ;    -- DesConexion
    BEGIN
    pkErrors.Push('pkServNumberMgr.AttSpecialServReq');
    -- Obtiene el parametro DESCONEXION
    nuDESCONEXION:=pkGeneralParametersMgr.fnuGetNumberValue('DESCONEXION');
    -- Atiende peticiones de desconexion de servicios suplementarios
    pkSpecialServReqMgr.AttenAllReqServNumber ( inuNumeServ,
                            nuDESCONEXION );
    pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;
    END AttSpecialServReq;
    /*
    Procedure    :    AnnulAllReqServNumber
    Descripcion    :    Anula todas las peticiones pendientes
    */
    procedure AnnulAllReqServNumber
    is
    BEGIN
    pkErrors.Push('pkServNumberMgr.AnnulAllReqServNumber');

    pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;
    END AnnulAllReqServNumber;
BEGIN
    pkErrors.Push('pkServNumberMgr.WithDrawServNumber');
    -- Obtiene el parametro TELEF_CAMBNUM_PENDLIBER
    nuTELEF_CAMBNUM :=pkGeneralParametersMgr.fnuGetNumberValue
                        ('TELEF_CAMBNUM_PENDLIBER');
    -- Insertar en historico de retiro detalle deuda
    TransDataServNumber ;
    -- Atiende peticion de retiro
    RequestAttention ;
    -- Atiende peticiones de servicio suplementarios de desconexion
    AttSpecialServReq ;
    -- Anula todas las peticiones pendientes
    AnnulAllReqServNumber  ;
    -- Libera el numero de servicio
    FreeServNumber ( inuNumeServ, pkConstante.NOCACHE );
    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when OTHERS then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END WithDrawServNumber;
/*
    Propiedad intelectual de Open Internatioanl Systems (c).
    Funcion        :    fblAccNumBalRequest
    Descripcion    :    Evalua si el servicio suscrito esta
            en estado Paz y Salvo
            funcion booleana account number balance request
    Parametros    :        Descripcion
    inuSeSu        Codigo del servicio suscrito
    inuCACHE    1- Usar Cache (Default)
                0- No usar Cache
    Retorno    :
    True    -El servicio suscrito se encuentra en estado Paz y Salvo
    False    -El servicio suscrito no se encuentra en estado Paz y Salvo
    Autor    :   Diego Molina Uribe
    Fecha    :    26-abr-2002
    Historia de Modificaciones
    Fecha    IdEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
*/
function fblAccNumBalRequest
    (
        inuSeSu        in    servsusc.sesunuse%type
    )
    return boolean is
BEGIN
    pkErrors.Push('pkServNumberMgr.fblAccNumBalRequest');
    -- se valida si esta a paz y salvo, sino esta a paz y salvo se va por la
    -- exception
    pkServNumberMgr.ValAccNumBalRequest(inuSeSu);

    pkErrors.Pop;
    return( false );
    EXCEPTION
    when LOGIN_DENIED  or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        return( true );
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fblAccNumBalRequest;
/*
    Propiedad intelectual de Open Internacional Systems (c).
    Procedimiento : fblAllSubsServWithDraw
    Descripcion   : Funcion que verifica si todos numero de
                    servicio de una Suscripcion esta Retirados
    Parametros  :       Descripcion
        isbSesuSusc    in    suscripcion
    Retorno     :
            True        Estan retirados todos los numeros de servicio
                        de una Suscripcion
            False       No estan retirados todos los numeros de servicio
                        de una suscripcion
    Autor    :    osilva
    Fecha    :    06-DIC-2001
    Historia de Modificaciones
    Fecha       IDEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
    06-DIC-2001 osilvaOP8810
    Creacion del objeto
    Modificacion
*/
FUNCTION  fblAllSubsServWithDraw
    (
        inuSesuSusc    in    servsusc.sesususc%type
    )
  return boolean IS
    CURSOR cuServsusc( inuSesuSusc  servsusc.sesususc%type)
    is
    SELECT sesunuse from servsusc
    WHERE sesususc = inuSesuSusc;
    nuSesuCodi   servsusc.sesunuse%type;
    boRetirado boolean := TRUE;
    cnuRECORD_NO_EXISTE          constant number := 6021;
BEGIN
    pkErrors.Push( 'pkServNumberMgr.fblAllSubsServWithDraw' );
    --Se cierra el cursor si esta abierto
    if (cuServSusc%isopen) then
    close cuServsusc;
    end if;
    --Se abre el cursor se verifica si tiene datos
    open cuServsusc( inuSesuSusc );
    loop
    --Se Recorre el cursor y se verifica si los numero de servicios
        --que pertenecen a la suscripcion estan retirados el proceso con
        --solo encontrar uno no retirado tiene para no continuar el proceso
        --y devolver que la suscripcion no esta retirada.
    fetch cuServsusc into nuSesuCodi;
    exit when ( cuServsusc%notfound ) or (boRetirado = FALSE);
        --Se verifica que el numero de servicio esta Retirado
        boRetirado := pkServNumberMgr.fblIsWithDrawal(nuSesuCodi);
    end loop ;
    close cuServsusc;
    pkErrors.Pop;
    return(boRetirado);
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fblAllSubsServWithDraw;


/*
    Propiedad intelectual de Open Systems (c).
    Function    :    fblHasRecords
    Descripcion    :    Evalua si existen registros en la tabla servsusc para
                la condicion dada como parametro
    Parametros    :        Descripcion
        isbWhere    Condicion
    Retorno    :
    True        Existen registros sobre la tabla
    False        No existen registros sobre la tabla
    Autor    :    Ricardo Calixto
    Fecha    :    Diciembre 05 del 2000
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

FUNCTION fblHasRecords
    (
        ISBWHERE    IN    GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    RETURN BOOLEAN
    IS
    csbFrom    constant varchar2(20) := 'from servsusc where ';    -- >From Query
    SBWHERE    GE_ERROR_LOG.DESCRIPTION%TYPE ;                 -- WHERE QUERY
BEGIN
    pkErrors.Push('pkServNumberMgr.fblHasRecords');
    -- Concatena el from de servsusc a la condicion
    sbWhere := csbFrom || rtrim ( isbWhere ) ;
    -- Cuenta el numero de registros que existen sobre la tabla servsisc
    if ( pkGeneralServices.fboHasRecords ( sbWhere ) ) then
    pkErrors.Pop;
    -- Si encontro registros
    return( TRUE );
    end if;
    pkErrors.Pop;
    -- No encontro registros
    return( FALSE );
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fblHasRecords;
/*
    Propiedad intelectual de Open International Systems. (c).

    Funcion     :    fblHasSesuThirdChargesInNulAcc
                    Has Servsusc Third Party Charges In Null Account
    Descripcion :    Funcion boolean que indica si el servicio suscrito
                    tiene cargos a la cuenta -1 de conceptos de tercero.

            Proceso que ejecuta los siguientes pasos:

            1. Obtiene el servicio del servicio suscrito
            2. Busca los conceptos de tercero que le aplican
               al servicio
            3. Si no hay conceptos de tercero retorna false.
                3. Busca si hay cargos de la cuenta -1 con los
               conceptos encontrados de tercero.
            4. Devuelve si encuentra o no los conceptos en la
               cuenta -1.

    Parametros     :    Descripcion
    Retorno     :
    ------------------------------------------------------------------------
    Metodos Encapsulados
    ------------------------------------------------------------------------
    ************************************************************************
    Procedimiento :
    Descripcion      :
    ************************************************************************
    Funcion      :
    Descripcion      :
    ************************************************************************
    ------------------------------------------------------------------------
    Fin Metodos Encapsulados
    ------------------------------------------------------------------------

    Autor     :    Katalina Marcos
    Fecha     :    25-Sep-2002

    Historia de Modificaciones
    Fecha    IDEntrega
    Modificacion
    30-04-2007 jcassoSAO61975
    Se cambia para validar que el producto dado tiene o no cargos sin facturar
    en un sistema que maneja productos dependiemntes (MANEJA_SERV_DEMANDA = 'S'),
    verificando simplemente si existe al menos un cargo sin facturar para el
    producto dado, en caso contrario, se realiza el proceso de validar por
    concepto. Entrega ultima version SAO 58141.

    11-05-2005    cnaviaSAO37568
    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    25-Sep-2002 kmarcosSAO10620.01
    Creacion del objeto.
*/

FUNCTION fblHasSesuThirdChargesInNulAcc
(
    inuServsusc  in  servsusc.sesunuse%type
)
RETURN BOOLEAN
IS
    --------------------------------------------------------------------
    -- Constants
    --------------------------------------------------------------------
    --------------------------------------------------------------------
    -- Variables
    --------------------------------------------------------------------
    tbConcepts         pktblConcepto.tyConccodi;
    blExistCargTerc     boolean;
    nuServicio        servicio.servcodi%type;

    --------------------------------------------------------------------
    -- Cursors
    --------------------------------------------------------------------
BEGIN
--{
    pkErrors.Push('pkServNumberMgr.fblHasSesuThirdChargesInNulAcc');


    -- Obtener parametros requeridos
    GetParameters;

    -- Si el sistema maneja servicios dependientes, validar si existe al menos
    -- un cargo sin facturar para el producto.
    IF ( gbDependingServices = pkConstante.SI ) THEN

        RETURN ( pkChargeMgr.fblExistChargBillNullService ( inuServsusc ) );

    END IF;

    -- Obtiene el Servicio asociado al Servicio Suscrito
    nuServicio := pktblServsusc.fnuGetService (inuServsusc, pkConstante.CACHE);

    -- Obtiene los Conceptos de Tercero que le aplican al Servicio
    pkThirdPartyConcMgr.GetServiceThirdConcepts (nuServicio,
                                                 tbConcepts);

    -- Si no hay conceptos de Terceros retorna Falso
    -- (no hay cargos de conceptos de Tercero en la cuenta -1 para el
    -- servicio suscrito)

    if (tbConcepts.COUNT = 0) then
        pkErrors.Pop;
        return (false);
    end if;

    -- Envia tabla de conceptos para ser evaluados, si existen en
    -- la cuenta -1 del servicio suscrito

    blExistCargTerc := pkChargeMgr.fblExistNulAccChargForConcepts
                                        (
                                          inuServsusc,
                                          tbConcepts
                                        );

    -- Retorna si existen cargos o no de los conceptos de Tercero
    -- en la cuenta -1
    pkErrors.Pop;

    return (blExistCargTerc);

EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    when others then
        pkErrors.NotifyError (pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.Pop;
        raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
--}
END fblHasSesuThirdChargesInNulAcc;

/*
    Propiedad intelectual de Open International Systems. (c).

    Funcion     :    fblHasThirdChargesNullAcc
                    Has Subscriber Service some Third Party Charges in Null Account
    Descripcion :    Funcion boolean que indica si el servicio suscrito
                    tiene cargos a la cuenta -1 de conceptos de tercero.

            Proceso que ejecuta los siguientes pasos:

            1. Obtiene el servicio del servicio suscrito
            2. Busca los conceptos de tercero que le aplican
               al servicio
            3. Si no hay conceptos de tercero retorna False.
            4. Busca si hay cargos de la cuenta -1 con los
               conceptos encontrados de tercero.
            5. Devuelve si encuentra o no los conceptos en la
               cuenta de cobro -1.

    Parametros     :    Descripcion
    Retorno     :
    ------------------------------------------------------------------------
    Metodos Encapsulados
    ------------------------------------------------------------------------
    ************************************************************************
    Procedimiento :
    Descripcion      :
    ************************************************************************
    Funcion      :
    Descripcion      :
    ************************************************************************
    ------------------------------------------------------------------------
    Fin Metodos Encapsulados
    ------------------------------------------------------------------------

    Autor     :    Juan Carlos Castro Prado
    Fecha     :    22-Oct-2003

    Historia de Modificaciones
    Fecha    IDEntrega
    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG


    22-Oct-2003 jcastroSAO17716
    Creacion del objeto. Se utiliza para el manejo de
    Terceros por Conceptos. Open Cali.
*/

FUNCTION fblHasThirdChargesNullAcc
(
    inuServsusc  in  servsusc.sesunuse%type
)
RETURN BOOLEAN
IS
    --------------------------------------------------------------------
    -- Constants
    --------------------------------------------------------------------
    --------------------------------------------------------------------
    -- Variables
    --------------------------------------------------------------------
    tbConcepts             pktblConcepto.tyConccodi;
    blExistCargTerc     boolean;

    --------------------------------------------------------------------
    -- Cursors
    --------------------------------------------------------------------
BEGIN
--{
    pkErrors.Push('pkServNumberMgr.fblHasThirdChargesNullAcc');

    -- Obtiene todos los Conceptos de Terceros
    pkThirdPartyConcMgr.GetAllThirdConcepts (tbConcepts);

    -- Si no hay conceptos de Terceros retorna Falso
    -- (no hay cargos de conceptos de Tercero en la cuenta -1 para el
    -- servicio suscrito)

    if (tbConcepts.COUNT = 0) then
        pkErrors.Pop;
        return (false);
    end if;

    -- Envia tabla de conceptos para ser evaluados, si existen en
    -- la cuenta -1 del servicio suscrito

    blExistCargTerc := pkChargeMgr.fblExistNulAccChargForConcepts
                                        (
                                          inuServsusc,
                                          tbConcepts
                                        );

    -- Retorna si existen cargos o no de Conceptos de Tercero
    -- en la Cuenta de Cobro -1
    pkErrors.Pop;

    return (blExistCargTerc);

EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    when others then
        pkErrors.NotifyError (pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.Pop;
        raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
--}
END fblHasThirdChargesNullAcc;

/*
    Propiedad intelectual de Open Systems (c).
    Funcion    :    fblInCurrentStatus
    Descripcion    :    Evalua si el servicio suscrito esta en estado Paz y Salvo
            In Current Status
    Parametros    :        Descripcion
        inuSeSu        Codigo del servicio suscrito
    inuCACHE    1- Usar Cache (Default)
            0- No usar Cache
    Retorno    :
    True    -    El servicio suscrito se encuentra en estado Paz y Salvo
    False    -    El servicio suscrito no se encuentra en estado Paz y Salvo
    Autor    :    Carlos Alberto Quintero
    Fecha    :    17 de mayo del 2000
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

function fblInCurrentStatus
    (
    inuSeSu     in    servsusc.sesunuse%type,
    inuCACHE    in    number default 1
    )
    return boolean is

   nuSaldo cuencobr.cucosacu%type;

BEGIN
    pkErrors.Push('pkServNumberMgr.fblInCurrentStatus');

    nuSaldo := pkbccuencobr.fnuGetOutStandBal(inuSeSu);

    if(nuSaldo = 0) then
      pkErrors.Pop;
    return(true);
    END if;

    pkErrors.Pop;
    return(false);
    EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fblInCurrentStatus;
/*
    Propiedad intelectual de Open Systems (c).
    Funcion    :    fblInLateStatus
    Descripcion    :    Evalua si el servicio suscrito esta en estado Mora
            In Late Status
    Parametros    :        Descripcion
        inuSeSu        Codigo del servicio suscrito
    inuCACHE    1- Usar Cache (Default)
            0- No usar Cache
    Retorno    :
    True    -    El servicio suscrito se encuentra en estado Paz y Salvo
    False    -    El servicio suscrito no se encuentra en estado Paz y Salvo
    Autor    :    Carlos Alberto Quintero
    Fecha    :    17 de mayo del 2000
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

function fblInLateStatus
    (
    inuSeSu        in    servsusc.sesunuse%type,
    inuCACHE    in    number default 1
    )
    return boolean is
   nuSaldo cuencobr.cucosacu%type;
BEGIN
    pkErrors.Push('pkServNumberMgr.fblInLateStatus');

    if(nuSaldo > 0) then
      pkErrors.Pop;
      return(true);
    END if;

    pkErrors.Pop;
    return(false);
    EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fblInLateStatus;
/*
    Propiedad intelectual de Open Systems (c).
    Function    :    fblIsIsolatedPair
    Descripcion    :    Evalua si el numero de servicio es un par aislado
    Parametros    :        Descripcion
        inuNumServ    Numero de servicio
    inuCACHE    1- Buscar data en Cache        ( Default )
            0- Buscar data en base de datos
    Retorno    :
    TRUE            Si es un paraislado
    FALSE           Si no es un paraislado
    Autor    :    Maria Fernanda Moreno H. (mfmoreno)
    Fecha    :    11-Nov-2000
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

FUNCTION fblIsIsolatedPair
    (
        inuNumServ    in    servsusc.sesunuse%type,
    inuCACHE    in    number default 1
    )
    RETURN BOOLEAN
    IS
    nuParAislado    suscripc.susctisu%type;
    nuTipoServicio  suscripc.susctisu%type;
    nuNumSusc       suscripc.susccodi%type;
BEGIN
    pkErrors.Push('pkServNumberMgr.fblIsIsolatedPair');
    -- Obtiene el valor del parametro SUS_PARAISLADO
    nuParAislado := pkGeneralParametersMgr.fnuGetNumberValue(
                                'SUS_PARAISLADO',
                                inuCACHE);

    nuNumSusc := pktblservsusc.fnuGetSuscription(inuNumServ,inuCACHE);

    nuTipoServicio := pktblSuscripc.fnuGetTypeSuscription(nuNumSusc,inuCACHE);
    -- Evalua si el servicio suscrito es de paraislado
    if ( nuTipoServicio = nuParAislado ) then
    pkErrors.Pop;
    return( TRUE );
    end if;
    pkErrors.Pop;
    return( FALSE );
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fblIsIsolatedPair;

/*
    Propiedad intelectual de Open International Systems (c).
    Function    :    fblIsPrivate
    Descripcion    :    Evalua si el tipo de suscripcion del servicio
            suscrito dado es privado.
            Is Private
    Parametros    :        Descripcion
    inuNumServ    Numero del servicio suscrito
    Retorno    :
    TRUE    -    El tipo de suscripcion del servicio suscrito es privado
    FALSE    -    El tipo de suscripcion del servicio suscrito NO es
            privado
    Autor    :       Carlos Alberto Quintero
    Fecha    :    Mayo 25 del 2001
    Historia de Modificaciones
    Fecha       IdEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
    Fecha    Autor    Modificacion
    25.may.2001    Caq    Creacion de la funcion

*/
FUNCTION fblIsPrivate
    (
    inuNumServ   in    servsusc.sesunuse%type
    )
    RETURN boolean
    IS
    -- Tipo de suscripcion del servicio suscrito
    nuTipoSusc    suscripc.susctisu%type;
    nuNumSusc     suscripc.susccodi%type;
BEGIN
    pkErrors.Push('pkServNumberMgr.fblIsPrivate');

    nuNumSusc := pktblservsusc.fnuGetSuscription(inuNumServ,pkConstante.NOCACHE);
    -- Obtiene el tipo de suscripcion del servicio suscrito
    nuTipoSusc := pktblSuscripc.fnuGetTypeSuscription
            (
                nuNumSusc,
                pkConstante.NOCACHE
            );
    pkErrors.Pop;
    return ( pkSubscriberTypeMgr.fblIsPrivate (nuTipoSusc) );
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fblIsPrivate;
/*
    Propiedad intelectual de Open International Systems (c).
    Function    :       fblIsProvisionalLine
    Descripcion :       Evalua si el numero de servicio es una linea provisional
                        Is Provisional line
    Parametros  :               Descripcion
        inuNumServ      Numero de servicio
        inuCACHE        1- Buscar data en Cache         ( Default )
                        0- Buscar data en base de datos
    Retorno     :
    Autor       :       David Julian Lopez - julopez -
    Fecha       :       Abril 23 de 2001
    Historia de Modificaciones
    Fecha       IdEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
*/
FUNCTION fblIsProvisionalLine
    (
        inuNumServ      in      servsusc.sesunuse%type,
        inuCACHE        in      number default 1
    )
    RETURN BOOLEAN
    IS
    --  Obtiene el tipo de suscripcion linea provisiona
    cnuPROVISIONAL_LINE    Constant number := pkGeneralParametersMgr.
                fnuGetNumberValue( 'SUS_PROVISIONAL' );
    --  Obtiene informacion del numero de servicio
    rcNumber        suscripc%rowtype;
    nuNumSusc       suscripc.susccodi%type;
BEGIN
    pkErrors.Push('pkServNumberMgr.fblIsProvisionalLine');

    --  Verifica si el numero de servicio tiene fecha de finalizacion
    nuNumSusc := pktblservsusc.fnuGetSuscription(inuNumServ);
    rcNumber  := pktblSuscripc.frcGetRecord( nuNumSusc );

   if (rcNumber.susctisu = cnuPROVISIONAL_LINE) then
    pkErrors.Pop;
    return( TRUE );
    end if;
    pkErrors.Pop;
    return( FALSE );
EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fblIsProvisionalLine;
function fblIsServiceRated
(
    inuServiceNumber     in  servsusc.sesunuse%type
)
return boolean
is
    nuServicio    servicio.servcodi%type;
    blRated        boolean    := true;
BEGIN
    pkErrors.Push ('pkServNumberMgr.fblIsServiceRated');
    nuServicio := pktblServsusc.fnuGetService(inuServiceNumber);
    -- Valida si el servicio es tasado o no
    if ( upper(pktblServicio.fsbGetRatedServFlag(nuServicio)) <>
             pkConstante.SI )
    then
        blRated := false;
    end if;
    pkErrors.pop;
    return( blRated );
EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fblIsServiceRated;
/*
    Propiedad intelectual de Open International Systems (c).
    Procedimiento : fblIsWithDrawal
    Descripcion   : Funcion que verifica si el  numero de
            servicio esta Retirado

    Parametros    :    Descripcion
        inuNumeServ        Numero de servicio
    Retorno    :
        True    Estan retirados el numero de servicio
        False    No estan retirados el numero de servicio
    Autor    :    osilva
    Fecha    :    05-DIC-2001
    Historia de Modificaciones
    Fecha    IDEntrega
    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    27-Ago-2003  mfmorenoSAO23046
    Despues del desarrollo de los SAOs 23781,  23760 y 23046 (diferenciacion
    del retiro voluntario del retiro por no pago) se acuerda que un numero esta
    retirado si la fecha de retiro es menor al Sysdate, por tanto se cambia esta
    funcionalidad para que se fije solo en la fecha de retiro.

    06-DIC-2001 osilvaOP8810
    Creacion del objeto

*/
FUNCTION fblIsWithDrawal
    (
        inuNumeServ        in    servsusc.sesunuse%type
    )
    return boolean IS

    dtFechRetiro    servsusc.sesufere%type;
    sbErrorMsg      varchar2(2000);        -- Mensaje error
BEGIN
    pkErrors.Push('pkServNumberMgr.fblIsWithDrawal');
    -- Obtiene parametros
    GetParameters ;
    -- Obtiene la fecha de retiro del numero de servicio
    dtFechRetiro := pktblServSusc.fdtGetRetireDate(inuNumeServ,pkConstante.NOCACHE);

    if ( dtFechRetiro is null OR dtFechRetiro >= sysdate ) then
        pkErrors.Pop;
        -- El numero de servicio no esta retirado
        return( FALSE );
    end if;
    pkErrors.Pop;
    -- El numero de servicio esta Retirado  definitivamente
    return( TRUE );
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fblIsWithDrawal;


/*******************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Function    : fblServiceNumberOnTimePayment
                  Service Number OnTime Payment.
    Descripcion : Devuelve verdadero si la ultima cuenta de cobro vencida
                  del servicio suscrito se pago oportunamente, de lo
                  contrario se devuelve FALSE.

    Parametros          :   Descripcion
    inuServiceNumber    ->  Servicio suscrito.

    Retorno     :
    TRUE        ->  Si la ultima cuenta de cobro del servicio se pago
                    oportunamente.
    FALSE       ->  Si la ultima cuenta de cobro del servicio no se pago
                    oportunamente.

    Autor       : Ivan Dario Sinisterra Moreno
    Fecha       : 17-08-2004 14:53:27

    Historia de Modificaciones
    Fecha       IDEntrega

    08-06-2010  jgtorresSAO117789
    Se eliminan las referencias a la clase de documento, se realiza la validacion
    directamente contra el tipo de documento de la factura.

    20-10-2009   mgutierrSAO98340
    Modifica constante de documento factura

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    17-08-2004  isinisteSAO31895
    Creacion.
*******************************************************************************/
FUNCTION fblServiceNumberOnTimePayment
(
    inuServiceNumber in cuencobr.cuconuse%type
) return boolean
IS

    blLastPayTimely boolean := FALSE; -- Ultimo pago oportuno.

    rcCuencobr      cuencobr%rowtype; -- Registro de cuentas de cobro.
    ----------------------------------------------------------------------------
    -- Selecciona cuentas de cobro vencidas del servicio suscrito.
    CURSOR cuLastDueAccount
    IS
        SELECT  cuencobr.*
        FROM    cuencobr, factura
        WHERE   cuconuse = inuServiceNumber
        AND     trunc(nvl(cucofeve,sysdate + 1 )) <= trunc(sysdate)
        AND     cucofact = factcodi
        AND     factcons = GE_BOConstants.fnuGetDocTypeCons
        ORDER BY cucofeve desc;
    ----------------------------------------------------------------------------
BEGIN
--{

    pkErrors.Push ('pkServNumberMgr.fblServiceNumberOnTimePayment');

    --<>
    pkGeneralServices.TraceData('    pkServNumberMgr.fblServiceNumberOnTimePayment');
    --<>

    -- Se verifica que el CURSOR se encuentre cerrado.
    if (cuLastDueAccount%IsOpen) then
        close cuLastDueAccount;
    end if;

    -- Se captura el registro de la ultima cuenta de cobro vencida del
    -- servicio suscrito.
    open  cuLastDueAccount;
    fetch cuLastDueAccount into rcCuencobr;
    close cuLastDueAccount;

    --<>
    pkGeneralServices.TraceData('      cucocodi = '||rcCuencobr.cucocodi);
    pkGeneralServices.TraceData('      cucofepa = '||rcCuencobr.cucofepa);
    pkGeneralServices.TraceData('      cucofeve = '||rcCuencobr.cucofeve);
    pkGeneralServices.TraceData('      cucosacu = '||rcCuencobr.cucosacu);
    pkGeneralServices.TraceData('      cucovare = '||rcCuencobr.cucovare);
    pkGeneralServices.TraceData('      cucovrap = '||rcCuencobr.cucovrap);
    --<>

    -- Evalua si se pago antes de la fecha de vencimiento.
    if ( rcCuencobr.cucofepa <= rcCuencobr.cucofeve ) then

        -- Evalua si el pago cubre el valor de la cuenta.
        if (   nvl(rcCuencobr.cucosacu,0)
             - nvl(rcCuencobr.cucovare,0)
             - nvl(rcCuencobr.cucovrap,0) <= 0 ) then

            blLastPayTimely := TRUE;

            --<>
            pkGeneralServices.TraceData('        Ultima cuenta pagada a tiempo');
            --<>

        end if;

    end if;

    pkErrors.Pop;

    return( blLastPayTimely );

EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    when OTHERS then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END fblServiceNumberOnTimePayment;
/*
    Propiedad intelectual de Open International Systems (c).
    Function    :    fblValIsRetireServSusc
    Descripcion    :    Valida si el servicio suscrito se encuentra en estado
            de Corte.
    Parametros    :        Descripcion
        inuSuscripcion        Suscripcion
    Retorno    :
    Autor    :    Lilianir
    Fecha    :    10-Abr-2002
    Historia de Modificaciones
    Fecha       ID Entrega

    09-09-2010  druizSAO123836
    Se modifica la forma de validar si un producto esta conectado, de manera que
    no compare si el estado de corte del producto es igual a "CONECTADO", sino
    que verifique si dicho estado de corte es un estado activo.
    Se eliminan las referencias a <pkErrors.Push> y <pkErrors.Pop> por el llamado
    al procedimiento <UT_Trace.Trace>.

    Modificacion
    11-MAY-05   cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    01-Ago-2003 mfmorenoSAO23479
    Se cambia el metodo con el que se recupera el parametro
    pktblParametr.fnuGetValueNumber por el metodo
    pkgeneralparametersmgr.fnuGetNumberParameter.
*/

FUNCTION fblValIsRetireServSusc
(
    inuServSusc     in      servsusc.sesunuse%type
) RETURN boolean
IS

    -- Flag que indica si el producto se encuentra desconectado
    blCortado               boolean := FALSE;

    -- Estado de corte del producto
    nuEstCorteServSusc      servsusc.sesuesco%type;

BEGIN
--{
    UT_Trace.Trace( 'Inicio: [pkServNumberMgr.fblValIsRetireServSusc]', 5 );

    -- Se obtiene el estado de corte del producto
    nuEstCorteServSusc := pktblServsusc.fnuGetSuspensionStatus( inuServSusc, pkConstante.CACHE );

    -- Se verifica si el estado de corte del producto no es un estado activo
    if ( not PR_BOSuspCorteReconexion.fboEsEstadoCorteActivo( nuEstCorteServSusc ) ) then
    --{
        blCortado := TRUE;
    --}
    end if;

    UT_Trace.Trace( 'Fin: [pkServNumberMgr.fblValIsRetireServSusc]', 5 );
    return ( blCortado );

EXCEPTION

    when LOGIN_DENIED or ex.CONTROLLED_ERROR or pkConstante.exERROR_LEVEL2 then
        UT_Trace.Trace( 'Error: [pkServNumberMgr.fblValIsRetireServSusc]', 5 );
    	raise;

    when OTHERS then
    	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        UT_Trace.Trace( 'Error: [pkServNumberMgr.fblValIsRetireServSusc]', 5 );
    	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
END;
/*
    Propiedad intelectual de Open International Systems (c).
    Function    :    fblValIsSuspOrRetServSusc
    Descripcion    :    Valida si el servicio suscrito se encuentra en estado de
            Corte o en Estado de Suspension.
    Parametros    :        Descripcion
        inuServSusc        ServSusc
    Retorno    :
    Autor    :    Lilianir
    Fecha    :    10-Abr-2002
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

FUNCTION fblValIsSuspOrRetServSusc
    (
        inuServSusc    in    servsusc.sesunuse%type
    )
RETURN boolean
IS
    sbErrMsg        varchar2(2000);
    blEstSuspRetServSusc    boolean := FALSE;
BEGIN
    pkErrors.Push('pkServNumberMgr.fblValIsSuspOrRetServSusc');
    -- Verifica si el servicio suscrito se encuentra en estado de Suspension o Corte
    if (fblValIsRetireServSusc ( inuServSusc )) then
        blEstSuspRetServSusc := TRUE;
    end if;
    pkErrors.Pop;
    return ( blEstSuspRetServSusc );
    EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fblValIsSuspOrRetServSusc;

/*
    Propiedad intelectual de Open Systems (c).
    Function    :    fblWithNonAppliedPayClaim
    Descripcion    :    Evalua si el servicio suscrito tiene reclamos por
            pago no abonado pendientes
            With Non Applied Payment Claim
    Parametros    :        Descripcion
        inuNumServ    Numero de servicio
    inuCACHE    1- Buscar data en Cache        ( Default )
            0- Buscar data en base de datos
    Retorno    :
    Autor    :    Carlos Alberto Quintero
    Fecha    :    Marzo 27 del 2002
    Historia de Modificaciones
    Fecha    ID Entrega
    27-mar-2002    cquinteroSAE7449.01
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    Creacion
*/
FUNCTION fblWithNonAppliedPayClaim
    (
        inuNumServ    in    servsusc.sesunuse%type,
    inuCACHE    in    number default 1
    )
    RETURN BOOLEAN
    IS
    nuVlrReclamo        cuencobr.cucovrap%type; -- Valor en reclamo del servicio
                        -- suscrito
BEGIN
    pkErrors.Push ('pkServNumberMgr.fblWithNonAppliedPayClaim');
    -- Obtiene el valor en reclamo del servicio suscrito
    nuVlrReclamo := pkbccuencobr.fnuGetNonAppliedPay
            (
            inuNumServ
            );
    -- Evalua si el servicio suscrito tiene reclamo por pago no abonado
    if ( nuVlrReclamo = pkBillConst.CERO ) then
    pkErrors.Pop;
    return (FALSE);
    end if;
    pkErrors.Pop;
    return (TRUE);
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fblWithNonAppliedPayClaim;
/*
    Propiedad intelectual de Open International Systems (c).
    Function    :       fboIntercepRequest
    Descripcion :       Evalua si el numero de servicio tiene peticion de
            interceptacion en tramite diferente al estado
            'ATENDIDA' o 'ANULADA'.
    Parametros  :               Descripcion
        inuNumServ      Numero de servicio
        inuCACHE        1- Buscar data en Cache         ( Default )
                        0- Buscar data en base de datos
    Autor       :       Sandra Patricia Casta?eda B. sacastan
    Fecha       :       Mayo 23 de 2001
    Historia de Modificaciones
    Fecha       IdEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
*/
FUNCTION fboIntercepRequest
    (
        inuNumServ      in      servsusc.sesunuse%type,
        inuCACHE        in      number default 1
    )
    RETURN BOOLEAN
    IS

BEGIN
   return( FALSE );
END fboIntercepRequest;

    ---------------------------------------------------------------------

/*
    Propiedad intelectual de Open International Systems (c).

    Function	:    fboIsBillable
    Descripcion	:    Evalua si el numero de servicio es facturable.

    Parametros            Descripcion

        inuNumServ    Numero de servicio
	inuCACHE    1- Buscar data en Cache        ( Default )
		    0- Buscar data en base de datos
    Retorno    :
	TRUE        Es facturable
	FALSE       No es facturable

    Autor    :    Ricardo Calixto
    Fecha    :    Julio 14 del 2000

    Historia de Modificaciones
    Fecha	ID Entrega

    21/09/2010  lfernandezSAO128171
    Se elimina validacion de suscripcion castigada

    16/09/2010  lfernandezSAO124550
    Se elimina parametro SesuCast, se valida si la suscripcion tiene facturas
    castigadas

    10-08-2006	cquinteroSAO46537
    Se adicionan los parametros servicio, estado de corte y flag de castigado
    en cartera del producto, para que cuando ya se tengan en el proceso
    se envien y asi se evite ir a la base de datos al producto.

    30-oct-2003 lgarciaSAO25254
    Se obtiene la configuracion del estado de corte del instanciador de datos

    31-Oct-2002 hgomezSAO15698.01
    Se corrige el nombre colocado en el push.

    24-Oct-2002 hgomezSAO14791.01
    Se elimina la funcionalidad de High perfomance implementada para
    liquidacion.

    16-AGO-2002 OsilvaSAO13892
    Se adiciono pop

    17-Jun-2002 achavezSAO12094
    . Se homologa para los cambios hechos a las unidades de software en ecuador
      el cual consistieron en:
    . Se crea la nueva tabla GST_SESULIQU esta tabla contiene algunos campos
    de la tabla SERVSUSC y de las tablas de GST_SETNMUSA GST_SETENACI (series).
    Para hallar un alto rendimiento la tabla GST_SESULIQU es espejo de la tabla
    SERVSUSC  su entrada de datos es por medio de los trigger de insercion y
    update de la tabla SERVSUSC, esta tabla espejo es accesada de acuerdo al
    parametro del package pkgst_HPparameter.CBOHIGHPERFORMANCE, si este
    parametro esta en FALSE lee la informacion de SERVSUSC y si esta en TRUE
    lee la informacion de GST_SESULIQU basicamente en el procedimiento del
    pkgst_Valoriza.prServSusc.

    16-Dec-2001 julopezOP8779.01
    Si el servicio se encuentra castigado en cartera, no es facturable.

*/

FUNCTION fboIsBillable
    (
    inuNumeServ     in	servsusc.sesunuse%type,
	inuCACHE	in	number default 1,
	inuSesuserv	in	servsusc.sesuserv%type default null,
	inuSesuesco	in	servsusc.sesuesco%type default null
    )
    RETURN BOOLEAN
    IS

    nuSesuServ	servsusc.sesuserv%type;    -- Servicio
    nuSesuEsco  servsusc.sesuesco%type;    -- Estado de corte
    rcConfesco	confesco%rowtype;       -- Reg de confesco
BEGIN
--{

    pkErrors.Push('pkServNumberMgr.fboIsBillable');

    -- Obtiene el servicio del numero de servicio
    if (inuSesuserv is null) then
	nuSesuServ := pktblServSusc.fnuGetService (inuNumeServ, inuCACHE);
    else
	nuSesuServ := inuSesuserv ;
    end if;

    -- Obtiene el estado de corte del numero de servicio
    if (inuSesuesco is null) then
	nuSesuEsco := pktblServSusc.fnuGetSuspensionStatus
			(inuNumeServ,inuCACHE ) ;
    else
	nuSesuesco := inuSesuesco ;
    end if;

    -- Obtiene la configuracion de estados de corte
    pkInstanceDataMgr.GetRecordConfStatusSuspend
	(
	    nuSesuserv,
	    nuSesuesco,
	    rcConfesco
	);
        -- Evalua si el flag de facturable se encuentra en 'S'
    if (rcConfesco.CoecFact = pkConstante.SI) then
	pkErrors.Pop;

	-- El numero de servicio es facturable
	return(TRUE);
    end if;

    -- El numero de servicio no es facturable
    pkErrors.Pop;
    return (FALSE);

EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;

    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
	pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END fboIsBillable;

    ---------------------------------------------------------------------

/*
    Propiedad intelectual de Open International Systems (c).
    Function    :    fboIsSuspended
    Descripcion    :    Evalua si el numero de servicio esta suspendido,
            es decir si el estado de corte es suspendido
            total o parcial.
    Parametros    :        Descripcion
        inuNumServ    Numero de servicio
    inuCACHE    1- Buscar data en Cache        ( Default )
            0- Buscar data en base de datos
    Retorno    :
    True        Esta suspendido
    False        No esta suspendido
    ------------------------------------------------------------------------
    Metodos Encapsulados
    ------------------------------------------------------------------------
    ************************************************************************
    Procedimiento :     GetCurrentData
    Descripcion   :     Obtiene Informacion Current del servicio suscrito
    ************************************************************************
    ------------------------------------------------------------------------
    Fin Metodos Encapsulados
    ------------------------------------------------------------------------
    Autor    :    Leonor Buenaventura
    Fecha    :    Mayo 19 del 2002
    Historia de Modificaciones
    Fecha       Autor
    Modificacion

    09-09-2010  druizSAO123836
    Se modifica la forma de validar si un producto esta conectado, de manera que
    no compare si el estado de corte del producto es igual a "CONECTADO", sino
    que verifique si dicho estado de corte es un estado activo.
    Se eliminan las referencias a <pkErrors.Push> y <pkErrors.Pop> por el llamado
    al procedimiento <UT_Trace.Trace>.

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    19-May-2002 lbuenaveSAO11313
    Creacion.
*/

FUNCTION fboIsSuspended
(
    inuNumeServ     in    servsusc.sesunuse%type,
    inuCACHE        in    number default 1
) RETURN boolean
IS

    sbEventTypeCD   tievcose.tecscodi%type;    -- Parametro tipo evento CD
    nuService       servsusc.sesuserv%type;    -- Servicio
    nuSuspStat      servsusc.sesuesco%type;    -- Estado de corte
    sbEventType     confesco.coectecs%type;    -- Tipo de evento
    rcConfesco      confesco%rowtype;          -- Registro de confesco

    ----------------------------------------------------------------------------
    -- Procedimientos encapsulados                                            --
    ----------------------------------------------------------------------------

    PROCEDURE GetCurrentData
    IS
    BEGIN
    --{
        UT_Trace.Trace( 'Inicio: [pkServNumberMgr.fboIsSuspended.GetCurrentData]', 6 );

        -- Obtiene el servicio del numero de servicio
        nuService := pktblServSusc.fnuGetService( inuNumeServ, inuCACHE );

        -- Obtiene el estado de corte del numero de servicio
        nuSuspStat := pktblServSusc.fnuGetSuspensionStatus( inuNumeServ, inuCACHE );

        -- Obtiene el tipo de evento asociado al estado de corte
        rcConfesco := pktblConfesco.frcGetRecord( nuService, nuSuspStat );

        sbEventType := rcConfesco.coectecs;

        UT_Trace.Trace( 'Fin: [pkServNumberMgr.fboIsSuspended.GetCurrentData]', 6 );

    EXCEPTION

        when LOGIN_DENIED or ex.CONTROLLED_ERROR or pkConstante.exERROR_LEVEL2 then
            UT_Trace.Trace( 'Error: [pkServNumberMgr.fboIsSuspended.GetCurrentData]', 6 );
        	raise;

        when OTHERS then
        	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
            UT_Trace.Trace( 'Error: [pkServNumberMgr.fboIsSuspended.GetCurrentData]', 6 );
        	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    --}
    END;

BEGIN
--{
    UT_Trace.Trace( 'Inicio: [pkServNumberMgr.fboIsSuspended]', 5 );

    -- Se obtiene el valor del parametro general TIPO_EVENTO_CD
    sbEventTypeCD := pkGeneralParametersMgr.fsbGetStringValue( 'TIPO_EVENTO_CD' );

    GetCurrentData;
    -- Evalua si el servicio suscrito esta suspendido:
    -- Si el estado de corte no es el de SERVICIO SIN CORTE
    -- y el tipo de evento asociado es CD --> esta suspendido
    --[
    UT_Trace.Trace( 'Estado del servicio -> ' || nuSuspStat, 6 );
    UT_Trace.Trace( 'Evento del estado   -> ' || sbEventType, 6 );
    UT_Trace.Trace( 'Evento CD           -> ' || sbEventTypeCD, 6 );
    --]
    if ( ( not PR_BOSuspCorteReconexion.fboEsEstadoCorteActivo( nuSuspStat ) ) and
         ( sbEventType = sbEventTypeCD )
    ) then
    --{
        UT_Trace.Trace( 'Fin: [pkServNumberMgr.fboIsSuspended]', 5 );
        return TRUE;
    --}
    end if;

    UT_Trace.Trace( 'Fin: [pkServNumberMgr.fboIsSuspended]', 5 );
    return FALSE;

EXCEPTION

    when LOGIN_DENIED or ex.CONTROLLED_ERROR or pkConstante.exERROR_LEVEL2 then
        UT_Trace.Trace( 'Error: [pkServNumberMgr.fboIsSuspended]', 5 );
    	raise;

    when OTHERS then
    	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        UT_Trace.Trace( 'Error: [pkServNumberMgr.fboIsSuspended]', 5 );
    	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
END;


/*
    Propiedad intelectual de Open International Systems (c).
    Function    :       fboSuspTempRequest
    Descripcion :       Evalua si el numero de servicio tiene peticion de
            suspension temporal en tramite diferente al estado
            'ATENDIDA' o 'ANULADA'.
    Parametros  :               Descripcion
        inuNumServ      Numero de servicio
        inuCACHE        1- Buscar data en Cache         ( Default )
                        0- Buscar data en base de datos
    Autor       :       Sandra Patricia Casta?eda B. sacastan
    Fecha       :       Mayo 23 de 2001
    Historia de Modificaciones
    Fecha       IdEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
*/
FUNCTION fboSuspTempRequest
    (
        inuNumServ      in      servsusc.sesunuse%type,
        inuCACHE        in      number default 1
    )
    RETURN BOOLEAN
    IS
BEGIN
   return( FALSE );
END fboSuspTempRequest;

/*
    Propiedad intelectual de Open Systems (c).
    Function    :    fboValBalServWithBalAcc
    Descripcion    :    Evalua si el el saldo pendiente del numero de servicio
            es igual a la sumatoria de los saldos de la cuentas de
            cobro
    Parametros    :        Descripcion
        inuNumServ    Numero de servicio
    inuCACHE    1- Buscar data en Cache        ( Default )
            0- Buscar data en base de datos
    Retorno    :
    True        Si es igual
    False        Si son diferentes
    Autor    :    Ricardo Calixto
    Fecha    :    Julio 10 del 2000
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

FUNCTION fboValBalServWithBalAcc
    (
        inuNumeServ    in    servsusc.sesunuse%type,
    inuCACHE    in    number default 1
    )
    RETURN BOOLEAN
    IS
    nuSaldCuen   cuencobr.cucosacu%type;    -- Sumatoria del saldo de la cuentas
    nuSesuSape   cuencobr.cucosacu%type;    -- Saldo pendiente numero servicio
BEGIN
    pkErrors.Push('pkServNumberMgr.fboValBalServWithBalAcc');
    -- Obtiene el saldo pendiente del servicio suscrito
    nuSaldCuen := pkbccuencobr.fnuGetOutStandBal(inuNumeServ);
    -- Obtiene la sumatoria  del saldo de las cuentas de cobro del numero
    -- de servicio
 nuSesuSape := pkAccountMgr.fnuGetAccBalanceServ ( inuNumeServ );
    -- Evalua si el saldo pendiente del numero de servicio es igual
    -- a la sumatoria del saldo de las cuentas de cobro
    if ( nuSesuSape = nuSaldCuen ) then
    pkErrors.Pop;
    return( TRUE );
    end if;
    pkErrors.Pop;
    return( FALSE );
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fboValBalServWithBalAcc;
/*
    Propiedad intelectual de Open International Systems (c).
    Function    :    fboWithBalance
    Descripcion    :    Evalua si el numero de servicio tiene saldo pendiente
            With Balance
    Parametros    :        Descripcion
        inuNumServ    Numero de servicio
    inuCACHE    1- Buscar data en Cache        ( Default )
            0- Buscar data en base de datos
    Retorno    :
    Autor    :    Carlos Alberto Quintero
    Fecha    :    Junio 16 del 2000
    Historia de Modificaciones
    Fecha       IdEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
*/
FUNCTION fboWithBalance
    (
    inuNumServ    in    servsusc.sesunuse%type,
    inuCACHE    in    number default 1
    )
    RETURN BOOLEAN
    IS
    nuSaldo    cuencobr.cucosacu%type;    -- Saldo pendiente del servicio suscrito
BEGIN
    pkErrors.Push('pkServNumberMgr.fboWithBalance');
    -- Obtiene el saldo pendiente del servicio suscrito

    nuSaldo := pkbccuencobr.fnuGetOutStandBal(inuNumServ);
    -- Evalua si el servicio suscrito tiene saldo
    if ( nuSaldo = pkBillConst.CERO ) then
    pkErrors.Pop;
    return( FALSE );
    end if;
    pkErrors.Pop;
    return( TRUE );
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fboWithBalance;
/*
    Propiedad intelectual de Open International Systems (c).
    Function    :    fboWithClaim
    Descripcion :    Evalua si el numero de servicio tiene reclamos pendientes
            With Claim
    Parametros    :        Descripcion
        inuNumServ    Numero de servicio
    inuCACHE    1- Buscar data en Cache        ( Default )
            0- Buscar data en base de datos
    Retorno    :
    Autor    :    Carlos Alberto Quintero
    Fecha    :    Junio 16 del 2000
    Historia de Modificaciones
    Fecha       IdEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
*/
FUNCTION fboWithClaim
    (
    inuNumServ    in    servsusc.sesunuse%type,
    inuCACHE    in    number default 1
    )
    RETURN BOOLEAN
    IS
    nuVlrReclamo        cuencobr.cucovare%type; -- Valor en reclamo del servicio
                        -- suscrito
BEGIN
    pkErrors.Push('pkServNumberMgr.fboWithClaim');
    -- Obtiene el valor en reclamo del servicio suscrito
    nuVlrReclamo := pkbccuencobr.fnuGetClaimValue(inuNumServ);
    -- Evalua si el servicio suscrito tiene valor en reclamo
    if ( nuVlrReclamo = pkBillConst.CERO ) then
    pkErrors.Pop;
    return( FALSE );
    end if;
    pkErrors.Pop;
    return( TRUE );
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fboWithClaim;
/*
    Propiedad intelectual de Open International Systems (c).
    Function    :       fboWithDrawLineRequest
    Descripcion :       Evalua si el numero de servicio tiene peticion de retiro
            de linea diferente al estado 'ATENDIDA' o 'ANULADA'.
                        WithDraw Line Request
    Parametros  :               Descripcion
        inuNumServ      Numero de servicio
        inuCACHE        1- Buscar data en Cache         ( Default )
                        0- Buscar data en base de datos
    Retorno     :
    Autor       :       David Julian Lopez - julopez -
    Fecha       :       Abril 21 de 2001
    Historia de Modificaciones
    Fecha       IdEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
*/
FUNCTION fboWithDrawLineRequest
    (
        inuNumServ      in      servsusc.sesunuse%type,
        inuCACHE        in      number default 1
    )
    RETURN BOOLEAN
    IS

BEGIN
   return( FALSE );
END fboWithDrawLineRequest;

/*
    Propiedad Intelectual de Open International Systems (c).
    Funcion    :    fdtGetAtteDateOfSusReq
            Get Attend Date Of Suspension Request

    Descripcion     :    Obtiene fecha de atencion de la ultima peticion de
            suspension.

    Parametros     :    Descripcion
    Retorno     :
    ------------------------------------------------------------------------
    Metodos Encapsulados
    ------------------------------------------------------------------------
    ************************************************************************
    Procediemiento:
    Descripcion      :
    ************************************************************************
    funcion      :
    Descripcion      :
    ************************************************************************
    ------------------------------------------------------------------------
    Fin Metodos Encapsulados
    ------------------------------------------------------------------------
    Autor     :    Fabian Manrique Ramirez
    Fecha     :    Octubre 06 del 2001
    Historia de Modificaciones
    Fecha    IDEntrega
    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    06-OCT-2001    fmanriqueOP8486
    Creacion del objeto.
*/
FUNCTION fdtGetAtteDateOfSusReq
    (
    inuServSusc    in    number
    )
RETURN date IS
BEGIN
    return ( SYSDATE );
END fdtGetAtteDateOfSusReq;
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    fnuGetNextServNumber
    Descripcion    :    Devuelve el proximo consecutivo del numero de servicio
    Parametros    :        Descripcion
    Retorno    :
    servsusc.sesunuse%type    Consecutivo numero de servicio
    Autor    :    Ricardo Calixto
    Fecha    :    03-Dic-2000
    Historia de Modificaciones
    Fecha       Autor     Modificacion
    21-Feb-2007 scastrillonSAO56004
    Se cambia la secuencia sq_gst_sesunuse por SQ_PR_PRODUCT.
    11-MAY-05    cnaviaSAO37568
    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

FUNCTION fnuGetNextServNumber
return servsusc.sesunuse%type
IS
    -- Variables
    nuNextSubsServ    servsusc.sesunuse%type;
BEGIN
    pkErrors.Push ('pkServNumberMgr.fnuGetNextServNumber');
    nuNextSubsServ := pkGeneralServices.fnuGetNextSequenceVal('SEQ_PR_PRODUCT');
    pkErrors.Pop;
    return ( nuNextSubsServ );
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when OTHERS then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fnuGetNextServNumber;
/*
    Propiedad Intelectual de Open International Systems (c)
    Funcion    :    fnuGetServNumber
    Descripcion    :    Obtiene el numero de servicio asociado a una suscripcion
            dada
            Get Service Number
    Parametros    :         Descripcion
    inuSusc        Codigo de la suscripcion
    Retorna    :
    Numero de Servicio asociado a la suscripcion
    Autor    :    Carlos Alberto Quintero
    Fecha    :    Abril 27 de 1999
    Historia de Modificaciones
    Fecha       IdEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
*/
function fnuGetServNumber
    (
    inuSusc    in    servsusc.sesususc%type
    )
    return number is
    nuNumServ    servsusc.sesunuse%type;    -- Numero de servicio
    -- Cursor para obtener el numero de servicio a partir de la suscripcion
    cursor cuServSusc( nuSusc    suscripc.susccodi%type ) is
    SELECT sesunuse
    FROM   servsusc
    WHERE  sesususc = nuSusc;
                    -- Suscripcion sin numero asociado
    cnuSUSC_SIN_TELEFONO    constant number := 1080;
BEGIN
    pkErrors.Push('pkServNumberMgr.fnuGetServNumber');
    -- Obtiene numero de servicio a partir de la suscripcion
    open cuServSusc( inuSusc );
    fetch cuServSusc into nuNumServ;
    if ( cuServSusc%notfound ) then
    close cuServSusc;
    pkErrors.SetErrorCode( cnuSUSC_SIN_TELEFONO );
    raise LOGIN_DENIED;
    end if;
    close cuServSusc;
    pkErrors.pop;
    return( nuNumServ );
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fnuGetServNumber;


/******************************************************************************
    Propiedad intelectual de Open Systems (c).
    PROCEDURE     :    fnuIsBillable
    Descripcion    :    Evalua si el numero de servicio es facturable.
    Parametros            Descripcion
    inuNumServ                Numero de servicio
    inuCACHE                 1- Buscar data en Cache        ( Default )
                               0- Buscar data en base de datos
    Retorno    :
       1                           Es facturable
    0                          No es facturable
    Autor    :        ISinisterra
    Fecha    :        06-Dic-2001
    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR         DESCRIPCION
    ISinisterraOP9070
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    06-12-2001  ISinisterra  Creacion del Metodo
******************************************************************************/
FUNCTION fnuIsBillable
    (
    inuNumeServ    in    servsusc.sesunuse%type,
    inuCACHE    in    number default 1
    )
    RETURN number
    IS
    blIsBillable    boolean;
BEGIN
    pkErrors.Push('pkServNumberMgr.fnuIsBillable');
    blIsBillable := fboIsBillable( inuNumeServ,    inuCACHE );
    if ( blIsBillable ) then
        pkErrors.Pop;
        -- El numero de servicio es facturable
        return( 1 );
    END if;
    pkErrors.Pop;
    -- El numero de servicio no es facturable
    return( 0 );
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fnuIsBillable;
/******************************************************************************
    Propiedad intelectual de Open International Systems (c).
    PROCEDURE     :    fnuValTimeForBilling (tomado de ValTimeForBilling).
    Descripcion    :    Valida el tiempo necesario de vigencia del servicio
                     suscrito para que se pueda facturar.
                     Se valida con respecto al numero minimo de dias para
                     facturacion que se define en los parametros de
                     facturacion.
                     Validate Time For Billing
    Parametros            Descripcion
    inuNumeServ               Numero de servicio
    inuPeriodoCurr        Codigo del periodo de facturacion current
    inuCACHE                 Parametro para saber si busca data en cache o accesa
                                    a la base de datos
                        1 - Buscar en cache primero ( Default )
                        0 - Accesar directamente la Base de datos
    Retorno    :
    Autor    :        ISinisterra
    Fecha    :        06-Dic-2001
    HISTORIA DE MODIFICACIONES
    Fecha       IdEntrega

    11-02-2011  jfrojasSAO139346
    Se reemplaza el llamado al metodo <pkBillingParamMgr.GetMinDaysBill> por
    <pktblServicio.fnuGetBillMinimunDays> para obtener el numero de dias minimos
    para facturar a partir del servicio.

    10-Jun-2009 jgtorresSAO96378
    Se modifican las referencias a pefafefi por pefaffmo.

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
    ISinisterraOP9070
    06-Dic-2001 ISinisterra Creacion del metodo.
******************************************************************************/
FUNCTION fnuValTimeForBilling
    (
    inuNumeServ        in    servsusc.sesunuse%type,
    inuPeriodoCurr    in    perifact.pefacodi%type default null,
    inuCACHE          in    number default pkConstante.NOCACHE
    )
    return number
    IS
    -- Periodo de facturacion current
    nuPeriodoFact    perifact.pefacodi%type;
    -- Fecha de ingreso del servicio suscrito
    dtFechaIngreso    servsusc.sesufein%type;
    -- Fecha final del periodo de facturacion current
    dtFechaFinPeriodo    perifact.pefaffmo%type;
    -- Numero de dias minimos a facturar
    nuDiasMinBilling    servicio.servdimi%type;
    -- Tipo de servicio
    nuServicio       servsusc.sesuserv%type;

BEGIN
    pkErrors.Push('pkServNumberMgr.fnuValTimeForBilling');

    --Obtiene el tipo de servicio
    nuServicio := pktblServsusc.fnugetservice (
                        inuNumeServ,
                        inuCACHE
                    );

    -- Obtiene el numero de dias minimos a facturar
    nuDiasMinBilling := pktblServicio.fnuGetBillMinimunDays(nuServicio);

    -- Obtiene la fecha de activacion del servicio suscrito
-- Elmesesu.emssfein = ServSusc.sesufein ELSE DO pktblElMeSeSu.fdtfdtGetInstallationDate
    dtFechaIngreso := pktblServsusc.fdtGetInstallationDate
                                                        (
                                                            inuNumeServ,
                                                            inuCACHE
                                                        );
    -- Periodo de facturacion current
    nuPeriodoFact := inuPeriodoCurr;
    -- Evalua si se dio el periodo current en los parametros
    if ( inuPeriodoCurr is null ) then
        -- Obtiene periodo current
        pkServNumberMgr.AccCurrentPeriod
                                        (
                                        inuNumeServ,
                                        nuPeriodoFact,
                                        inuCACHE
                                        );
    end if;
    -- Obtiene fecha final del periodo current
    dtFechaFinPeriodo := pktblPerifact.fdtGetEndDate
                                                    (
                                                    nuPeriodoFact,
                                                    inuCACHE
                                                    );
    -- Evalua que tenga tiempo minimo para facturacion
    if ( dtFechaIngreso > ( dtFechaFinPeriodo - nuDiasMinBilling ) ) then
       -- No se debe facturar el servicio suscrito
    pkErrors.Pop;
       return ( 0 );
    end if;
    pkErrors.Pop;
    return ( 1 );
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when OTHERS then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fnuValTimeForBilling;
/*
    Propiedad intelectual de Open Systems (c).
    Function    :    frcCloneServNumber
    Descripcion    :    Clona un servicio suscrito base
            -- Obtiene record del servicio suscrito base
            -- Obtiene consecutivo para el nuevo servicio suscrito
            -- Actualiza el identificador del record de servicio
            suscrito
    Parametros    :    Descripcion
    inuNuseBase     Numero de Servicio suscrito base
    inuCACHE         Cache
    Retorno    :
    rcServsuscBase  Registro del servicio suscrito base
    Autor    :    Omar Lopez
    Fecha    :    16-Ene-2002
    Historia de Modificaciones
    Fecha    Autor        Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-Ene-2002 olopezOP8906.03

    Creacion del objeto.
*/
FUNCTION frcCloneServNumber
    (
    inuNuseBase     in      servsusc.sesunuse%type,
    inuCACHE    in    number default 0
    )
RETURN servsusc%rowtype
is
    -----------------
    -- VARIABLES
    -----------------
    -- Record Tabla Servsusc
    rcServsuscBase    Servsusc%rowtype;
    nuSesuNuevo         servsusc.sesunuse%type ;
BEGIN
    pkErrors.Push ('pkServNumberMgr.frcCloneServNumber');

    -- Obtiene record del servicio suscrito base
    rcServsuscBase := pktblServSusc.frcGetRecord(inuNuseBase,inuCACHE);

    -- Obtiene el proximo numero de secuencia para servsusc
    nuSesuNuevo := pkServNumberMgr.fnuGetNextServNumber ;

    -- Actualiza el identificador del record de servicio suscrito
    rcServsuscBase.sesunuse := nuSesuNuevo;

    pkErrors.Pop;

    return(rcServsuscBase);

EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END frcCloneServNumber;

/*
    Propiedad intelectual de Open International Systems. (c).

    Funcion     :    frcFillRecordDefault.sql
    Descripcion :    Devuelve un registro con los campos NOT NULL
                    de la tabla servsusc inicializados

    Parametros    :    Descripcion
    Retorno    :

    Autor    :    kmarcos
    Fecha    :    10-Oct-2000

    Historia de Modificaciones
    Fecha    Autor    Modificacion

    13/04/2010  lfernandezSAO115741
    <FillRecord> En el metodo encapsulado ya no se asigna el estado del programa
    de cartera

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    12-Ene-2003 jcastroSAO26751
    Se modifica el metodo encapsulado FillRecord para incluir la inicializacion
    de las variables orcServsusc.sesudnec y orcServsusc.sesulnec que junto a
    orcServsusc.sesuenco conforman la llave de la tabla de Entidades de Cobro,
    las cuales faltaban por ser inicializadas. Open Cali.

    25-Mar-2003  mfmorenoSAO19769
    Se inserta el valor de nuNULLNUM en los campos sesuprca, SESUESPC, SESUENCO.

    16-AGO-2002 osilvaSAO
    Se cambio orden del pop por estar despues del return;
*/

FUNCTION frcFillRecordDefault RETURN servsusc%rowtype  IS

    /* -------------------------------------------------------------
                  VARIABLES
    ------------------------------------------------------------- */
    sbNULLSB        varchar2(1);                -- Nulo string
    nuNULLNUM       number ;            -- Nulo numerico
    nuCERO        number ;            -- Valor numerico Cero
    orcServsusc        servsusc%rowtype ; -- Registro de salida

    /* -------------------------------------------------------------
                PROCEDIMIENTOS ENCAPSULADOS
    ------------------------------------------------------------- */
    /*
       obtiene los valores por nulos de algunos campos de la tabla
       parametr.
    */
    PROCEDURE GetValParameters IS
    BEGIN
    --{
        pkErrors.Push('pkServNumberMgr.frcFillRecordDefault.GetValParameters');

        -- Obtiene la constante para el valor CERO
        nuCERO := pkBillConst.CERO;

        -- Obtiene el parametro NULLSB
        sbNULLSB :=pkGeneralParametersMgr.fsbGetStringValue('NULLSB');

        -- Obtiene el parametro NULLNUM
        nuNULLNUM :=pkGeneralParametersMgr.fnuGetNumberValue('NULLNUM');

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.Pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise pkConstante.exERROR_LEVEL2;
    --}
    END GetValParameters;

    /* Llena el valor del registro con los valores por nulos y por defecto */

    PROCEDURE FillRecord IS
    BEGIN
    --{
        pkErrors.Push ('pkServNumberMgr.frcFillRecordDefault.FillRecord');

        orcServsusc.sesunuse := nuNULLNUM ;
        orcServsusc.sesususc := nuNULLNUM ;
        orcServsusc.sesuserv := nuNULLNUM ;
        orcServsusc.sesufein := sysdate ;
        orcServsusc.sesuboui := nuNULLNUM ;
        orcServsusc.sesucate := nuNULLNUM ;
        orcServsusc.sesusuca := nuNULLNUM ;
        orcServsusc.sesucaan := nuNULLNUM ;
        orcServsusc.sesusuan := nuNULLNUM ;
        orcServsusc.sesudepa := nuNULLNUM ;
        orcServsusc.sesuloca := nuNULLNUM ;
        orcServsusc.sesusafa := nuCERO ;
        orcServsusc.sesuplfa := nuNULLNUM ;
        orcServsusc.sesuesco := nuNULLNUM ;
        orcServsusc.sesuperf := nuNULLNUM ;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.Pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise pkConstante.exERROR_LEVEL2;
    --}
    END FillRecord;

    /* ---------------------------------------------------------- */
    /*            PROCEDIMIENTO PRINCIPAL              */
    /* ********************************************************** */

BEGIN
--{
    pkErrors.Push ('pkServNumberMgr.frcFillRecordDefault');

    -- Obtiene los valores nulos de parametr
    GetValParameters ;

    -- Asigna valores por defectos para inicializar el registo.
    FillRecord ;

    pkErrors.Pop;

    -- Devuelve el registro ya inicializado.
    return (orcServsusc);

EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
END frcFillRecordDefault;

/*
    Propiedad intelectual de Open Internatioanl Systems (c).
    Function    :       frcGetIntercepReq
    Descripcion :       Recupera la peticion de interceptacion en
            tramite que tiene el numero de servicio.
            Interceptacion en tramite diferente al estado
            'ATENDIDA' o 'ANULADA'.
    Parametros  :               Descripcion
        inuNumServ      Numero de servicio
        inuCACHE        1- Buscar data en Cache         ( Default )
                        0- Buscar data en base de datos
    Autor       :       Sandra Patricia Casta?eda B. sacastan
    Fecha       :       Junio 04 de 2001
    Historia de Modificaciones
    Fecha       IdEntrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    16-AGO-2002 OsilvaSAO13892

    Se adicono pop
*/
FUNCTION frcGetIntercepReq
    (
        inuNumServ      in      servsusc.sesunuse%type,
        inuCACHE        in      number default 1
    )
    RETURN number
    IS

BEGIN
    return( 0 );
END frcGetIntercepReq;
/*
    Propiedad intelectual de Open Systems (c).
    Function    :       frcGetSuspTempRequest
    Descripcion :       Recupera la peticion de suspension temporal en
            tramite que tiene el numero de servicio.
            Suspension temporal en tramite diferente al estado
            'ATENDIDA' o 'ANULADA'.
    Parametros  :               Descripcion
        inuNumServ      Numero de servicio
        inuCACHE        1- Buscar data en Cache         ( Default )
                        0- Buscar data en base de datos
    Autor       :       Sandra Patricia Casta?eda B. sacastan
    Fecha       :       Mayo 23 de 2001
    Historia de Modificaciones
    Fecha       Autor   Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

FUNCTION frcGetSuspTempRequest
    (
        inuNumServ      in      servsusc.sesunuse%type,
        inuCACHE        in      number default 1
    )
    RETURN number
    IS

BEGIN
    return( 0 );
END frcGetSuspTempRequest;
/*
    Propiedad Intelectual de Open Systems International (c).
    Funcion    :  fsbGetUserName.sql
    Descripcion    :  Obtiene el nombre del usuario del servicio suscrito.
    Retorno    :
    Nombre del usuario del servicio suscrito
    Autor    :  Juan Jose Rada Gomez
    Fecha    :  15-FEB-2001
    Historia de Modificaciones
    Fecha       Autor
    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    12-Mar-2004 DescobarSAO26487
    Se agrega validacion para evitar que busque el
    nombre del usuario si el nit es nulo.
*/
function fsbGetUserName
    (
    inuServNumber        in    servsusc.sesunuse%type
    ) return usuasesu.usssnomb%type
is
    --  Id del usuario del servicio suscrito
    sbUserId                 usuasesu.usssnit%type := NULL;
    --  Nombre del usuario del servicio suscrito
    sbUserName                usuasesu.usssnomb%type := NULL;
BEGIN
    pkErrors.Push('pkServNumberMgr.fsbGetUserName');
    --  Obtiene el usuario del servicio suscrito
    sbUserId := dage_subscriber.fsbGetIdentification
                (pktblsuscripc.fnuGetCustomer
                  (pktblServsusc.fnuGetSuscription(inuServNumber))
                );
    --  Obtiene el nombre del usuario del servicio
    if sbUserId is not null then
        sbUserName := pktblUsuasesu.fsbGetName( sbUserId );
    else
        sbUserName:=null;
    END if;
    pkErrors.Pop;
    return( sbUserName );
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fsbGetUserName;
/*
    Propiedad intelectual de Open Systems (c).
    Funcion :    fnuCountBillAbleServices
    Descripcion   :    Cuenta los servicios suscritos facturables.
    Parametros    :    Descripcion
    Retorno    :
    Autor    :    hgomez
    Fecha    :    17-Apr-2003
    Historia de Modificaciones
    Fecha       Id. entrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    17-Apr-2003 entregaSAO20657

    Creacion.
*/
FUNCTION fnuCountBillAbleServices return number is

    CURSOR cuCountServices is
    SELECT count(*)
    FROM   servsusc
    WHERE  sesuesco
        IN (select coeccodi FROM confesco WHERE COECFACT=pkConstante.SI);

    nuServices      servsusc.sesunuse%type;

BEGIN

    pkErrors.Push('pkServNumberMgr.fnuCountBillAbleServices');

    open cuCountServices;
    fetch cuCountServices INTO nuServices;

    if cuCountServices%notfound then
        close cuCountServices;
        pkErrors.Pop;
        return(pkBillConst.CERO);
    END if;

    close cuCountServices;
    pkErrors.Pop;
    return(nuServices);

EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fnuCountBillAbleServices;

/*
    Propiedad intelectual de Open Systems (c).

    Procedure    :    CreateServiceNumber
    Descripcion    :    Crea servicio suscrito inicializando datos basicos
            de un servicio suscrito

    Parametros    :    Descripcion
    ircServsusc     Registro servicio suscrito

    Retorno    :

    Autor    :    Ricardo Calixto
    Fecha    :    19-May-2003

    Historia de Modificaciones
    Fecha    Autor        Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    19-May-2003 rcalixtoSAO21182

    Creacion del objeto.
*/

PROCEDURE CreateServiceNumber
    (
    ircServsusc     in     servsusc%rowtype
    )
IS
    -----------------
    -- VARIABLES
    -----------------

    -- Record Tabla Servsusc
    rcServsuscClone     Servsusc%rowtype;

BEGIN
--{
    pkErrors.Push ('pkServNumberMgr.CreateServiceNumber');

    rcServsuscClone := ircServsusc ;

    -- Inicializa datos basicos
    InitializeBasicData ( rcServsuscClone );

    -- Inserta en la base de datos el nuevo servicio suscrito
    pktblServsusc.InsRecord ( rcServsuscClone );

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
END CreateServiceNumber;

/*
    Propiedad intelectual de Open Systems (c).

    Procedure    :    InitializeBasicData
    Descripcion    :    Inicializa datos basicos servicio suscrito

    Parametros    :    Descripcion
    orcServsusc     Registro servicio suscrito
    Retorno    :

    Autor    :    Ricardo Calixto
    Fecha    :    19-May-2003

    Historia de Modificaciones
    Fecha    Autor        Modificacion
    10-04-2012    mramosSAO179532
    Se modifica para incluir el campo "Estado Financiero" en la creacion de
    producto

    11-MAY-05    cnaviaSAO37568
    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    19-May-2003    rcalixtoSAO21182

    Creacion del objeto.
*/

PROCEDURE InitializeBasicData
    (
    orcServsusc     in out     servsusc%rowtype
    )
IS
    -----------------
    -- VARIABLES
    -----------------

    -- Record Tabla Servsusc

    nuCero        number := pkBillConst.CERO;
    nuNULLNUM        number := pkConstante.NULLNUM;

BEGIN
--{

    pkErrors.Push ('pkServNumberMgr.InitializeBasicData');

    -- Obiene parametros
    pkServNumberMgr.GetParameters;

    -- Inicializa los campos de saldos y valores del servicio suscrito

    orcServsusc.sesusafa := nuCero;

       -- Inicializa estados
    orcServsusc.sesuesco := nuESTACORT;
    orcServsusc.sesufeco := null;
    orcServsusc.sesuesfn := pkbillconst.csbEST_AL_DIA;


    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
END InitializeBasicData;

/*
    Propiedad intelectual de Open International Systems (c).
    Function    :       LoadRecord
    Descripcion :      Accesa el Registro indicado de la Tabla
    Parametros  :               Descripcion
    Retorno     :
        rcReportes Registro de tipo Tabla
    Autor       :       Leonardo Garcia
    Fecha       :       05-sep-2003
    Historia de Modificaciones
    Fecha       Autor   Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

procedure LoadRecord
    (
        inuRowid           in   rowid
    ) is
BEGIN
-- {
    pkErrors.Push('pkServNumberMgr.LoadRecord');
    if ( cuServsusc%isopen ) then
        close cuServsusc;
    end if;
    -- Accesa Reportes de la BD
    open cuServsusc( inuRowid );
    fetch cuServsusc into rcServsusc;
    if ( cuServsusc%notfound ) then
        close cuServsusc;
        pkErrors.Pop;
        rcServsusc := rcRecordNull;
        nurowid := null;
        return;
    end if;
    close cuServsusc;
    nurowid := inuRowid;
    pkErrors.Pop;
-- }
END LoadRecord;
/*
    Propiedad intelectual de Open International Systems (c).
    Function    :       Load
    Descripcion :      Accesa el Registro indicado de la Tabla
    Parametros  :               Descripcion
    Retorno     :
        rcReportes Registro de tipo Tabla
    Autor       :       Leonardo Garcia
    Fecha       :       05-sep-2003
    Historia de Modificaciones
    Fecha       Autor   Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

procedure Load
    (
        inuRowid    in      rowid
    ) is
BEGIN
-- {
    pkErrors.Push('pkServnumberMgr.Load');
    LoadRecord( inuRowid );
    -- Evalua si se encontro el registro en la Base de datos
    if ( rcServsusc.sesunuse is null ) then
        pkErrors.Pop;
        raise NO_DATA_FOUND;
    end if;
    pkErrors.Pop;
    EXCEPTION
    when NO_DATA_FOUND then
        pkErrors.SetErrorCode( csbDIVISION, csbMODULE, cnuRECORD_NO_EXISTE );
        raise LOGIN_DENIED;
-- }
END Load;
/*
    Propiedad intelectual de Open International Systems (c).
    Function    :       fblInMemory
    Descripcion :       Valida si el Registro ya esta en memoria
    Parametros  :               Descripcion
    Retorno     :
        rcReportes Registro de tipo Tabla
    Autor       :       Leonardo Garcia
    Fecha       :       05-sep-2003
    Historia de Modificaciones
    Fecha       Autor   Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

function fblInMemory
    (
        inuRowid    in      rowid
    )
    return boolean is
BEGIN
-- {
    pkErrors.Push('pkServnumberMgr.fblInMemory');
    if ( nurowid = inuRowid )
    then
        pkErrors.Pop;
        return( TRUE );
    end if;
    pkErrors.Pop;
    return( FALSE );
-- }
END fblInMemory;
/*
    Propiedad intelectual de Open International Systems (c).
    Function    :       AccKey
    Descripcion :       Accesa el registro indicado directamente o recuperandolo de memori
a
    Parametros  :               Descripcion
    Retorno     :
        rcReportes Registro de tipo Tabla
    Autor       :       Leonardo Garcia
    Fecha       :       05-sep-2003
    Historia de Modificaciones
    Fecha       Autor   Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

procedure AccKey
    (
        inuRowid    in      rowid,
        inuCACHE    in      number default 1
    )
    is
BEGIN
-- {
    pkErrors.Push('pkServnumberMgr.AccKey');
    -- Valida si debe buscar primero en memoria Cache
    if ( inuCACHE = CACHE ) then
        if ( fblInMemory( inuRowid ) ) then
            pkErrors.Pop;
            return;
        end if;
    end if;
    Load( inuRowid );
    pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;
-- }
END AccKey;
/*
    Propiedad intelectual de Open International Systems (c).
    Function    :       frcGetRecord
    Descripcion :       Obtiene el registro de la tabla
    Parametros  :               Descripcion
    Retorno     :
        rcReportes Registro de tipo Tabla
    Autor       :       Leonardo Garcia
    Fecha       :       05-sep-2003
    Historia de Modificaciones
    Fecha       Autor   Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
*/

function frcGetRecord
    (
        inuRowid           in   rowid,
        inuCACHE           in   number default 1
    )
return Servsusc%rowtype
is
BEGIN
-- {
    pkErrors.Push('pkServNumberMgr.frcGetRecord');
    AccKey ( inuRowid ,inuCACHE );
    pkErrors.Pop;
    return ( rcServsusc );
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;
-- }
END frcGetRecord;

/*
    Propiedad intelectual de Open Systems (c)

    Function    :    fblIsOwner
    Descripcion    :    Evalua si el producto es propietario (garantia)

    Parametros    :

    inuProduct    ID del producto

    Retorna    :

    TRUE        Es propietario
    FALSE        No es propietario

    Autor    :    Carlos Alberto Quintero
    Fecha    :    Julio 06 del 2004

    Historia de Modificaciones
    Fecha      ID Entrega

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    06-jul-2004    cquinteroSAO30630
    Creacion

*/

FUNCTION fblIsOwner
    (
    inuProduct    in    servsusc.sesunuse%type
    )
    RETURN boolean IS

    -- Rol de la garantia
    sbWarrantyRole    servsusc.sesuroga%type;

BEGIN
--{

    pkErrors.Push('pkServNumberMgr.fblIsOwner');

    -- Obtiene rol de la garantia
    sbWarrantyRole := pktblServsusc.fsbGetWarrantyRol
            (
                inuProduct
            ) ;

    -- Evalua si es propietario
    if (sbWarrantyRole = csbOWNER) then
    pkErrors.Pop;
    return (TRUE);
    end if;

    pkErrors.Pop;
    return (FALSE);

EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END fblIsOwner;

/*
    Propiedad intelectual de Open Systems (c)

    Function    :    fblIsTenant
    Descripcion    :    Evalua si el producto es inquilino (garantia)

    Parametros    :

    inuProduct    ID del producto

    Retorna    :

    TRUE        Es inquilino
    FALSE        No es inquilino

    Autor    :    Carlos Alberto Quintero
    Fecha    :    Julio 06 del 2004

    Historia de Modificaciones
    Fecha      ID Entrega

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

    06-jul-2004    cquinteroSAO30630
    Creacion

*/

FUNCTION fblIsTenant
    (
    inuProduct    in    servsusc.sesunuse%type
    )
    RETURN boolean IS

    -- Rol de la garantia
    sbWarrantyRole    servsusc.sesuroga%type;

BEGIN
--{

    pkErrors.Push('pkServNumberMgr.fblIsTenant');

    -- Obtiene rol de la garantia
    sbWarrantyRole := pktblServsusc.fsbGetWarrantyRol
            (
                inuProduct
            ) ;

    -- Evalua si es inquilino
    if (sbWarrantyRole = csbTENANT) then
    pkErrors.Pop;
    return (TRUE);
    end if;

    pkErrors.Pop;
    return (FALSE);

EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END fblIsTenant;

/*
    ---Alexis ----------------------------------------------------
    Propiedad intelectual de Open Systems (c).
    Procedure    :    fbServNumverSuspendNoPay
    Descripcion    :    Valida si el numero de servicio se encuentra suspendido
                    totalmente por no pago.
            Service Number Suspend No Pay
    Parametros    :        Descripcion
        inuNumServ    Numero de servicio
    Retorno    :
            TRUE: El servicio suscrito se encuentra suspendido por no pago
            FALSE: No se encuentra suspendido
    Autor    :    Alexis Ocaciones Garcia
    Fecha    :    15-Mar-2005
    Historia de Modificaciones
    Fecha    Autor    Modificacion
     Creacion.
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG

*/
function fboServNumverSuspendNoPay
    (
        inuNumServ    in    servsusc.sesunuse%type
    )
    RETURN boolean
    is

    nuEstateSuspension number;    -- Estado de corte SUSPENSION DEFINITIVA POR NO PAGO.
    nuEstateServNumber number; --Estado de corte actual del servicio.
    sbEstateSuspension varchar2(100) := 'RETIRO_LINEA_POR_NO_PAGO';
    boSuspState boolean := FALSE;

BEGIN
    pkErrors.Push('pkServNumberMgr.fboServNumverSuspendNoPay');

    --Se obtiene estado de corte para RETIRO DEFINITIVO POR NO PAGO
    nuEstateSuspension := pkGeneralParametersMgr.fnuGetNumberValue(sbEstateSuspension);

    --Se obtiene estado de corte actual del servivio suscrito.
    nuEstateServNumber := pktblServsusc.fnuGetSuspensionStatus( inuNumServ );

    if ( nuEstateSuspension = nuEstateServNumber ) then
        boSuspState := TRUE;
    end if;

    pkErrors.Pop;
    return ( boSuspState );

        EXCEPTION
    when LOGIN_DENIED  or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        return( true );
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fboServNumverSuspendNoPay;

/*
    Propiedad intelectual de Open Systems (c).
    Procedimiento : ChangeNumServSuspendFinancing
    Descripcion   :    Cambia el estado de corte de un producto a retirado por no
                    pago con financiacion y fija el plan de facturacion
                    para que se le siga facturando solo la deuda.

    Parametros    :    Descripcion
        inuNumeServ        Numero de servicio a retirar
    Retorno    :

    Autor    :   Alexis Oaciones Garcia.
    Fecha    :    16-Mar-2005
    Historia de Modificaciones
    Fecha    Id Entrega
    26-10-2008  cjaramilloSAO104553
    Se modifica el procedimiento adicionando un parametro de entrada correspondiente
    a un flag que indica si el producto se encuentra retirado voluntariamente por
    peticion del cliente. De ser asi, actualiza el estado de corte del producto al
    estado de corte configurado en el parametro EST_FACT_CONVENIO_VOLUNTARIO
    (100 - CONVENIO DE PAGO RETIRO VOLUNTARIO).

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
      16-Mar-2005 aocacionSAO36448

      Entrega

*/
PROCEDURE ChangeNumServSuspendFinancing
(
    inuNumeServ             in  servsusc.sesunuse%type,
    iblIsRetiredByRequest   IN  boolean default FALSE

) IS

    sbErrorMsg              varchar2(2000); -- Mensaje error.
    nuStateSuspend number; --Estado de corte suspendido definitivo por no pago.

    -- Estado de corte a asignar al producto a retirar
    nuRetireStatus                      servsusc.sesuesco%type;

    -- Valor del parametro general EST_FACT_CONVENIO
    nuEST_FACT_CONVENIO                 parametr.pamenume%type;

    -- Valor del parametro general EST_FACT_CONVENIO_VOLUNTARIO
    nuEST_FACT_CONVENIO_VOLUNTARIO      parametr.pamenume%type;



    /* ********************************************************** */
    /*                  Metodos Encapsulados                      */
    /* ********************************************************** */
    /*--------------------------------------------------------------------------
    Procedure    :    GetParameters
    Descripcion    :    Obtiene parametros
    --------------------------------------------------------------------------*/
    PROCEDURE GetParameters
    IS
    BEGIN
        pkErrors.Push('pkServNumberMgr.ChangeNumServSuspendFinancing.GetParameters');

         -- Se obtiene el valor del parametro general EST_FACT_CONVENIO
        nuEST_FACT_CONVENIO := pkGeneralParametersMgr.fnuGetNumberValue( 'EST_FACT_CONVENIO' );

        -- Se obtiene el valor del parametro general EST_FACT_CONVENIO_VOLUNTARIO
        nuEST_FACT_CONVENIO_VOLUNTARIO := pkGeneralParametersMgr.fnuGetNumberValue( 'EST_FACT_CONVENIO_VOLUNTARIO' );

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
    END GetParameters;
    /*--------------------------------------------------------------------------
    Procedure    :    Process
    Descripcion    :
    --------------------------------------------------------------------------*/
    PROCEDURE Process
    IS
        rcServsusc servsusc%rowtype ;    -- Registro servsusc
        nuSesuNuev servsusc.sesunuse%type ;
    BEGIN
        pkErrors.Push('pkServNumberMgr.ChangeNumServSuspendFinancing.Process');

        -- Se verifica si el producto se encuentra retirado voluntariamente por
        -- peticion del cliente
        if ( iblIsRetiredByRequest ) then
            nuRetireStatus := nuEST_FACT_CONVENIO_VOLUNTARIO;
        else
            nuRetireStatus := nuEST_FACT_CONVENIO;
        end if;

        -- Actualiza el estado de corte del numero de servicio
        pktblServsusc.UpSuspensionStatus( inuNumeServ, nuRetireStatus, sysdate );

        -- Actualiza el plan de facturacion a -1, el cual debe ser facturable
        --y solo permita facturar las deudas financiadas.
        --No debe tener configurado ningun otro concepto para facturacion.
        pktblServsusc.UpBillingPlan( inuNumeServ, pkconstante.NULLNUM );

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
    END Process;
    ----------------------------------------------------------------------------
BEGIN
    pkErrors.Push ('pkServNumberMgr.ChangeNumServSuspendFinancing');

    -- Obtiene parametros.
    GetParameters ;

    -- Actualiza numero de servicio.
    Process ;

    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ChangeNumServSuspendFinancing;

/*    Propiedad intelectual de Open Systems (c).
    Procedure    : RetireRetiredWithFinan

    Descripcion    :        Actualiza el estado de corte de los servicios suscritos
                        que se encuentran en estado retirado con financiacion
                        y ya estan a Paz y salvo y pertenecen al periodo del
                        Ciclo dado.
                        Se le asigna el estado de corte configurado en PARAMETR
                        con el parametro "RETIRADO_POST_FINANC".



    Parametros    :        Descripcion
       inuCiclo         Ciclo
       ionuIncoNume:    Numero de inconsistencia generado.

    Retorno     :

    Autor    :    Alexis Ocaciones Garcia.

    Fecha    :    18-Mar-2005

    Historia de Modificaciones
    Fecha    Id Entrega

    28-11-2012  jcuervoSAO196967
    Se modifica para incluir al registro de inconsistencias, la descripcion del
    error generado.

    09-04-2012  jcuervoSAO175668
    Se modifica  el  metodo  encapsulado  <Initialize>  para  que  inicialice la
    variable global "gtbProdErr" en blanco.
    Se modifica el metodo encapsulado <ProcRetireByRequest> para  que  actualice
    el producto donde se presenta  el error en la variable  global  "gtbProdErr"
    Se modifica el metodo   encapsulado <ProcRetireByNoPay> para  que  actualice
    el servicio subscrito donde se presenta el error en la variable "gtbProdErr"

    07-06-2011  jgtorresSAO151257
    Se modifica el llamado al paquete pkReportsIncMgr.

    26-10-2009  cjaramilloSAO104553
    Se modifica el procedimiento para que actualice el estado de corte de los
    productos que se encuentren en estado retirado voluntariamente con financiacion
    y ya esten a paz y salvo, al estado de corte configurado en el parametro
    RETIRO_ATENCLIE (95 - ESTADO FINAL RETIRO ATENCION CLIENTE).

    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    30-Mar-2005 aocacionSAO36775

     Se incrementa el indice del registro de los servicios suscritos
     adecuadamente.

    30-Mar-2005 aocacionSAO36762
     Se obtiene ultimo codigo de inconsistencia generado, para insertar
     inconsistencias desde este numero.
     Se agrega commit por cada servicio suscrito procesado correctamente.

    18-Mar-2005 aocacionSAO36448
     Creacion.
*/
PROCEDURE RetireRetiredWithFinan
                       (
                       inuCiclo      in      suscripc.susccicl%type,
                       ionuIncoNume  in out  reportes.reponume%type
                       )
is
    ---------------
    -- Variables --
    ---------------
    nuIndex number;
    rctbSubsServices         pkBCServsusc.tytbSubsServices; --Record de servicios suscritos a
    nuCurrSubsServ           servsusc.sesunuse%type;                                              --procesar

    -- Estado de corte al cual sera llevado el producto
    nuProdSuspStatus                    servsusc.sesuesco%type;


    nuESTADORETIRPOSTFINANC  parametr.pamenume%type; --Estado de corte retirado definitivo.
    nuESTADORETIRADOFINAN    parametr.pamenume%type; --Estado de corte retirado con financiacion

    -- Estado de corte correspondiente a 100 - CONVENIO DE PAGO RETIRO VOLUNTARIO
    nuEST_FACT_CONVENIO_VOLUNTARIO      parametr.pamenume%type;

    -- Estado de corte correspondiente a 95 - ESTADO FINAL RETIRO ATENCION CLIENTE
    nuRETIRO_ATENCLIE       parametr.pamenume%type;

    sbTituRepo                 mensaje.mensdesc%type;
    nuMinSubsServ            servsusc.sesunuse%type := 0; --Numero de servicio minimo
                                                        --a procesar.
    blRegToProcess           boolean;
    blRetireDef              boolean;
    cnuINCONSISTEN           constant number := 10543;
    cnuDepaNULL              constant number := pkConstante.NULLNUM;
    cnuLocaNULL              constant number := pkConstante.NULLNUM;

    --Modulo OPF
    csbDIVISION              constant varchar2(3) := pkConstante.csbDIVISION;
    -- Modulo  BIL
    csbMOD_BIL               constant varchar2(3) := pkConstante.csbMOD_BIL;
    nuLinInco                 number :=0;

    /* ------------------------------------------------------------
    Procedure    :    GetParameters
    Descripcion    :    Obtiene parametros
    ------------------------------------------------------------- */
    PROCEDURE GetParameters
    IS
    BEGIN
        pkErrors.Push('pkServNumberMgr.RetireRetiredWithFinan.GetParameters');

        -- Habilita manejo de cache para parametros
        pkGrlParamExtendedMgr.SetCacheOn;

        --Estado retirado con financiacion.
        nuESTADORETIRADOFINAN := pkGeneralParametersMgr.fnuGetNumberValue
                                                   ('EST_FACT_CONVENIO');

        -- Se obtiene el valor del parametro general EST_FACT_CONVENIO_VOLUNTARIO
        nuEST_FACT_CONVENIO_VOLUNTARIO := pkGeneralParametersMgr.fnuGetNumberValue( 'EST_FACT_CONVENIO_VOLUNTARIO' );

        -- Se obtiene el valor del parametro general RETIRO_ATENCLIE
        nuRETIRO_ATENCLIE := pkGeneralParametersMgr.fnuGetNumberValue( 'RETIRO_ATENCLIE' );

        --Estado retirado post-financiacion.
        nuESTADORETIRPOSTFINANC := pkGeneralParametersMgr.fnuGetNumberValue
                                                    ('RETIRADO_POST_FINANC');
        pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;
    END GetParameters;

    PROCEDURE Initialize_SubsServices
    IS
    BEGIN
        pkErrors.Push('pkServNumberMgr.RetireRetiredWithFinan.Initialize_SubsServices');

        rctbSubsServices := null;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
        when others then
            pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
            pkErrors.Pop;
            raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END Initialize_SubsServices;

    -- ******************************************************************
/*
    Propiedad intelectual de Open Systems (c).
    Procedure    : valRetireDef

    Descripcion    :    Valida si el servicio suscrito se puede pasar a estado de
                    corte retirado post-financiacion.

    Parametros    :         Descripcion
        inuCurrSubsServ     Servicio suscrito


    Retorno     :
        TRUE: El servicio suscrito cumple con los requisitos para pasar a estado
              de corte retirado post financiacion.

    Autor    :    Alexis Ocaciones Garcia.

    Fecha    :    18-Mar-2005

    Historia de Modificaciones
    Fecha    Id Entrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    18-Mar-2005 aocacionSAO36448

     Creacion.

*/
    FUNCTION valRetireDef( inuCurrSubsServ servsusc.sesunuse%type )
    RETURN BOOLEAN
    IS
    boProcessSubsServ boolean;
    boValidacion      boolean;
    boValReclamo      boolean;
    boValReclNoPay    boolean;
    boSaldoFavor      boolean;
    cnuTIENE_RECLAMOS constant number := 9565 ;  -- Tiene reclamos pend.
    cnuTIENE_SALDO_FAVOR constant number := 1248; --Tiene saldo a favor
    cnuCARGO_FACTURA     constant number := 8020 ;  -- Tiene cargos en fac -1


    BEGIN
        pkErrors.Push('pkServNumberMgr.RetireRetiredWithFinan.valRetireDef');

        --Valida si el servicio suscrito tiene saldo pendiente
        boValidacion :=  pkServNumberMgr.fboWithBalance( inuCurrSubsServ );
        if( boValidacion ) then
            return(FALSE);
        END if;

        --Valida si el servicio suscrito tiene reclamos en tramite.
        boValReclamo :=  pkServNumberMgr.fboWithClaim( inuCurrSubsServ );

        --Valida si el servicio suscrito tiene reclamos por pago no abonado
        boValReclNoPay :=  pkServNumberMgr.fblWithNonAppliedPayClaim( inuCurrSubsServ );

        if ( boValReclamo OR boValReclNoPay ) then
            pkErrors.SetErrorCode(  pkConstante.csbDIVISION,
                                    pkConstante.csbMOD_SAT,
                                    cnuTIENE_RECLAMOS );
            raise LOGIN_DENIED;
        end if ;

        --Valida si el servicio suscrito tiene saldo a favor
        boSaldoFavor :=  pkServNumberMgr.fblWithPositiveBalance( inuCurrSubsServ );
        if ( boSaldoFavor ) then
            pkErrors.SetErrorCode(  pkConstante.csbDIVISION,
                                    pkConstante.csbMOD_BIL,
                                    cnuTIENE_SALDO_FAVOR );
            raise LOGIN_DENIED;
        end if ;

        -- Valida si tiene cargos a la cuenta -1
        if pkChargeMgr.fblExistChargBillNullService ( inuCurrSubsServ ) then
            pkErrors.SetErrorCode(  pkConstante.csbDIVISION,
                                    pkConstante.csbMOD_SAT,
                                    cnuCARGO_FACTURA );
            raise LOGIN_DENIED;
        end if;


        --Valida si el servicio suscrito tiene diferidos pendientes
        boValidacion :=  pkDeferredMgr.fboServDeferDifZero( inuCurrSubsServ );
        if( boValidacion ) then
            return(FALSE);
        END if;

        pkErrors.Pop;
        return(TRUE);

    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
        when others then
            pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
            pkErrors.Pop;
            raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END valRetireDef;


    FUNCTION fsbGetRepoMessage
    RETURN varchar2
    IS
        sbTituReporte     mensaje.mensdesc%type; -- Titulo reporte
    BEGIN
        pkErrors.Push('pkServNumberMgr.RetireRetiredWithFinan.fsbGetRepoMessage');

        -- Obtiene mensaje de inconsistencias
        sbTituReporte := pktblMensaje.fsbGetDescription
                         (
                            csbDIVISION,
                            csbMOD_BIL,
                            cnuINCONSISTEN
                         );
        pkErrors.Pop;

        return( sbTituReporte );

    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
    END fsbGetRepoMessage;
    /* ------------------------------------------------------------ */
    PROCEDURE InsertIncoReport IS
    BEGIN
        pkErrors.Push('pkServNumberMgr.RetireRetiredWithFinan.InsertIncoReport');

    if not pktblReportes.fblExist ( ionuIncoNume ) then
    --{
        sbTituRepo := fsbGetRepoMessage;

        -- Inserta el reporte  de inconsistencias
        pkReportsMgr.CreateReport (
                    'Inconsistencias ' || sbTituRepo ,
                    ionuIncoNume
                      );
    --}
    end if;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
    END InsertIncoReport;

    Procedure NotifyError
    IS
    BEGIN
        pkErrors.Push ( 'pkServNumberMgr.RetireRetiredWithFinan.NotifyError' );
        rollback TO savepoint svServsusc;

        -- Incrementa el numero de inconsistencias
        nuLinInco := nuLinInco + 1;
        -- Graba inconsistencia
        pkReportsIncMgr.InsertReportLine (
                        ionuInconume,
                        nuLinInco,
                        rctbSubsServices.tbSesuDepartam(nuIndex),
                        rctbSubsServices.tbSesuLocalidad(nuIndex),
                        rctbSubsServices.tbSubsServices(nuIndex),
                        null,
                        pkErrors.fsbGetErrorMessage
                        );

        -- Inicializa variables de pkErrors
        pkErrors.Initialize ;
    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
        when others then
            pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
            pkErrors.Pop;
            raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END NotifyError;


    PROCEDURE ProcesSubsServ
    IS
    BEGIN
        pkErrors.Push('pkServNumberMgr.RetireRetiredWithFinan.ProcesSubsServ');

        -- Obtiene el SERVICIO SUSCRITO
        nuCurrSubsServ := rctbSubsServices.tbSubsServices(nuIndex);

        -----Validacion del servicio suscrito si se puede pasar a retirado
        -----definitivo
        blRetireDef := valRetireDef( nuCurrSubsServ );

        if ( blRetireDef ) then
            --Se actualiza a estado de corte retirado post-financiacion
            --del servicio suscrito y fecha de corte
            pktblServsusc.UpSuspensionStatus( nuCurrSubsServ,
                                              nuESTADORETIRPOSTFINANC,
                                              sysdate
                                            );
        END if;

        pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop ;
        raise LOGIN_DENIED;
    when others then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);
    END ProcesSubsServ;


    PROCEDURE Initialize IS
    BEGIN
        pkErrors.Push('pkServNumberMgr.RetireRetiredWithFinan.Initialize');
        nuLinInco := pkBillingPeriod.fnugetLineNumber();
        FA_BCIncofact.Initialize;
        pkErrors.Pop;
    EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
    END Initialize;

    PROCEDURE ProcRetireByNoPay
    IS
    BEGIN
    --{
        pkErrors.Push( 'pkServNumberMgr.RetireRetiredWithFinan.ProcRetireByNoPay' );

        -- Se asigna el estado de corte a aplicar para los productos procesados
        nuProdSuspStatus := nuESTADORETIRPOSTFINANC;

        -- Se inicializa el producto procesado a cero
        nuMinSubsServ := 0;

        loop
        --{
            --  Inicializa tabla temporal
            Initialize_SubsServices;

            -- Inicializa variable para control de Registros a procesar
            blRegToProcess := FALSE;

            -- Obtiene los servicios a procesar
            blRegToProcess := pkBCServsusc.fblGetsubsServCiclCort
            (
                nuESTADORETIRADOFINAN,
                inuCiclo,
                nuMinSubsServ,
                nuBulkNum,
                rctbSubsServices
            );

            if ( rctbSubsServices.tbSubsServices.first is NULL ) then
                exit;
            end if;

            nuIndex := rctbSubsServices.tbSubsServices.first;

            -- Recorre cada uno del conjunto de registros
            while nuIndex <= rctbSubsServices.tbSubsServices.last loop
            --{
                -- Procesa servicio suscrito.
                BEGIN
                --{
                    SAVEPOINT svServsusc;
                    ProcesSubsServ;
                    COMMIT;

                EXCEPTION

                    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
                        pkErrors.Pop;
                        Errors.GetError(nuErrCode,sbErrMsg);
                        FA_BCIncofact.SetGlobalError
                        (
                            rctbSubsServices.tbSubsServices(nuIndex),
                            sbErrMsg
                        );
                        NotifyError;

                    when OTHERS then
                        pkErrors.NotifyError ( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
                        pkErrors.Pop;
                        FA_BCIncofact.SetGlobalError
                        (
                            rctbSubsServices.tbSubsServices(nuIndex),
                            sbErrMsg
                        );
                        NotifyError;
                --}
                END;

                nuIndex := rctbSubsServices.tbSubsServices.next(nuIndex);
            --}
            end loop;

            -- Condicion de salida del bucle
            exit when not blRegToProcess;

            -- Obtiene el ultimo numero de servicio procesado
            nuMinSubsServ := rctbSubsServices.tbSubsServices( rctbSubsServices.tbSubsServices.last );
        --}
        end loop;
    --}
    END ProcRetireByNoPay;


    PROCEDURE ProcRetireByRequest
    IS
    BEGIN
    --{
        pkErrors.Push( 'pkServNumberMgr.RetireRetiredWithFinan.ProcRetireByRequest' );

        -- Se asigna el estado de corte a aplicar para los productos procesados
        nuProdSuspStatus := nuRETIRO_ATENCLIE;

        -- Se inicializa el producto procesado a cero
        nuMinSubsServ := 0;

        loop
        --{
            --  Inicializa tabla temporal
            Initialize_SubsServices;

            -- Inicializa variable para control de Registros a procesar
            blRegToProcess := FALSE;

            -- Obtiene los servicios a procesar
            blRegToProcess := pkBCServsusc.fblGetsubsServCiclCort
            (
                nuEST_FACT_CONVENIO_VOLUNTARIO,
                inuCiclo,
                nuMinSubsServ,
                nuBulkNum,
                rctbSubsServices
            );

            if ( rctbSubsServices.tbSubsServices.first is NULL ) then
                exit;
            end if;

            nuIndex := rctbSubsServices.tbSubsServices.first;

            -- Recorre cada uno del conjunto de registros
            while nuIndex <= rctbSubsServices.tbSubsServices.last loop
            --{
                -- Procesa servicio suscrito.
                BEGIN
                --{
                    SAVEPOINT svServsusc;
                    ProcesSubsServ;
                    COMMIT;

                EXCEPTION

                    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
                        pkErrors.Pop;
                        Errors.GetError(nuErrCode,sbErrMsg);
                        FA_BCIncofact.SetGlobalError
                        (
                            rctbSubsServices.tbSubsServices(nuIndex),
                            sbErrMsg
                        );
                        NotifyError;

                    when OTHERS then
                        pkErrors.NotifyError ( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
                        pkErrors.pop;
                        FA_BCIncofact.SetGlobalError
                        (
                            rctbSubsServices.tbSubsServices(nuIndex),
                            sbErrMsg
                        );
                        NotifyError;
                --}
                END;

                nuIndex := rctbSubsServices.tbSubsServices.next( nuIndex );
            --}
            end loop;

            -- Condicion de salida del bucle
            exit when not blRegToProcess;

            -- Obtiene el ultimo numero de servicio procesado
            nuMinSubsServ := rctbSubsServices.tbSubsServices( rctbSubsServices.tbSubsServices.last );
        --}
        end loop;
    --}
    END ProcRetireByRequest;


/* ************************************************************ */
BEGIN
    pkErrors.Push('pkServNumberMgr.RetireRetiredWithFinan');

    Initialize;

    GetParameters;

    -- Inserta reporte de inconsistencias
    InsertIncoReport;

    -- Procesa los productos en retiro por no pago con financiacion
    ProcRetireByNoPay;

    -- Procesa los productos en retiro voluntario con financiacion
    ProcRetireByRequest;

    pkBillingPeriod.Setlinenumber( nuLinInco );

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
       pkErrors.Pop;
       raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
       pkErrors.Pop;
       raise pkConstante.exERROR_LEVEL2;
    when OTHERS then
       pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
       pkErrors.Pop;
       raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END RetireRetiredWithFinan;

/*
    Propiedad intelectual de Open Systems (c).
    Procedimiento : fblWithPositiveBalance
    Descripcion   :    Indica si el servicio suscrito tiene saldo a favor.

    Parametros    :    Descripcion
        inuNumeServ        Codigo del servicio suscrito
        inuCACHE        1- Buscar en cache
                        0- Buscar directamente en la base de datos

    Retorno    :
        TRUE: El servicio suscrito tiene saldo.

    Autor    :   Alexis Oaciones Garcia.
    Fecha    :    18-Mar-2005
    Historia de Modificaciones
    Fecha    Id Entrega
    15-JUL-14    LocampoSAO257783  Se modifica para que el metodo consulte si hay saldo
                                   a favor por producto mas no por contrato.
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
      16-Mar-2005 aocacionSAO36448

      Entrega
*/
FUNCTION fblWithPositiveBalance
    (
        inuNumServ    in    servsusc.sesunuse%type,
        inuCACHE    in    number default 1
    )
    RETURN BOOLEAN
    IS
    nuValorSalFav  suscripc.suscsafa%type; -- Valor de saldo a favor.
    nuNumSusc      suscripc.susccodi%type;
BEGIN
    pkErrors.Push ('pkServNumberMgr.fblWithPositiveBalance');
    -- Obtiene el valor del saldo a favor del servicio suscrito.
    nuValorSalFav := pktblservsusc.fnuGetPositiveBal(inuNumServ,inuCACHE);
    -- Evalua si el servicio suscrito tiene saldo a favor.
    if ( nuValorSalFav = pkBillConst.CERO ) then
    pkErrors.Pop;
    return (FALSE);
    end if;
    pkErrors.Pop;
    return (TRUE);
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fblWithPositiveBalance;

/*
    Propiedad intelectual de Open Systems (c).
    function    :    fsbVersion
    Descripcion    :    Obtiene el ultimo sao con el que fue modificado el paquete
    Parametros    :    Descripcion
    Retorno        :
        SAO         Numero de ultimo sao con el que fue entregado

    Autor        :    Alexis Ocaciones Garcia.
    Fecha        :    30-Mar-2005
    Historia de Modificaciones
    Fecha    Autor    Modificacion
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    30-Mar-2005     aocacionSAO36762

    Creacion
*/

FUNCTION fsbVersion RETURN varchar2 IS
BEGIN
--{
    return (csbVersion);
--}
END;

/*
    Propiedad intelectual de Open Systems (c).
    Procedure    :    UpInstalledCharge
    Descripcion    :    Actualiza la carga instalada
    Parametros    :    Descripcion
                    inuNumServ    Numero de Servicio
                    isbsesucain Valor de la carga instalada
    Retorno    :
    Autor    :        Andres David Valencia
    Fecha    :        01-abr-2005

    Historia de Modificaciones
    Fecha    ID Entrega
    11-MAY-05    cnaviaSAO37568    Se reemplazan los llamados a ERRORLOG por GE_ERROR_LOG
    01-abr-2005     avalenciaSAO36805

    Creacion.
*/
PROCEDURE updateInstCharge(inuNumServ    in    servsusc.sesunuse%type,
                           inuCain       in    servsusc.sesucain%type)
                           IS

BEGIN
    pkErrors.Push ('pkServNumberMgr.updateInstCharge');
    -- Obtiene el valor del saldo a favor del servicio suscrito.
    pktblServsusc.UpInstalledCharge( inuNumServ,
                                     inuCain
                                    );

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END updateInstCharge;

/*
    Propiedad intelectual de Open International Systems. (c).

    Procedure   : UpdActivaMobileLine
    Descripcion : Actualiza datos del Producto en el proceso de Activacion
                  de una Linea Movil
                  Update of data for the Activation of Mobile Lines

    Parametros  :           Descripcion
        inuProduct          Codigo del Producto
        idtActivationDate   Fecha de Activacion

    Retorno     :

    Autor       :       Juan Carlos Castro Prado
    Fecha       :       22-Sep-2005

    ------------------------------------------------------------------------
    Metodos Encapsulados
    ------------------------------------------------------------------------
    ************************************************************************
    Procedure       :       GetParameters
    Descripcion     :       Obtiene los parametros necesarios al proceso
    ************************************************************************
    ------------------------------------------------------------------------
    Fin Metodos Encapsulados
    ------------------------------------------------------------------------

    Historia de Modificaciones
    Fecha       ID Entrega
    Modificacion

    22-Sep-2005 jcastroSAO40318.
    Creacion del objeto. Open Cali.
*/

PROCEDURE UpdActivaMobileLine
(
    inuProduct            in    servsusc.sesunuse%type,
    idtActivationDate    in    servsusc.sesufein%type
)
IS

    nuWithService   servsusc.sesuesco%type; -- Estado de Corte Conectado

    /* ************************************************************ */
    /*             Encapsulated Methods                             */
    /* ************************************************************ */

    PROCEDURE GetParameters IS
    BEGIN
    --{
        pkErrors.Push ('pkServNumberMgr.UpdActivaMobileLine.GetParameters');

        -- Habilita manejo de Cache para Parametros
        pkGrlParamExtendedMgr.SetCacheOn;

        -- Obtiene el parametro correspondiente al Estado de Corte Conectado
        -- asumiendo que este Estado siempre esta configurado como Facturable
        -- y es valido para cualquier Servicio (Tipo de Producto)
        nuWithService := pkGeneralParametersMgr.fnuGetNumberValue ('EST_SERVICIO_SIN_CORTE');

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.Pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise pkConstante.exERROR_LEVEL2;

        when others then
            pkErrors.NotifyError (pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
            pkErrors.Pop;
            raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
    --}
    END GetParameters;

    /* ------------------------------------------------------------ */

BEGIN
--{
    pkErrors.Push ('pkServNumberMgr.UpdActivaMobileLine');

    -- Obtiene parametros
    GetParameters;

    -- Actualiza los datos para la activacion del Producto
    pktblServsusc.UpDataActivationMobile (inuProduct, idtActivationDate, nuWithService);

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    when others then
        pkErrors.NotifyError (pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.Pop;
        raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
--}
END UpdActivaMobileLine;
/* *************************************************************************
    Propiedad intelectual de Open Systems (c).

    Function    :    fnuGetSubsServByThread
    Descripcion    :    Obtiene el numero de servicios suscritos que se deben
                    tener en cuenta para los procesos masivos ( procesos
                    a ejecutar por hilos ).
                    Get Subscriber Services By Thread

                    Para tener en cuenta todos los procesos, el nulo de
                    aplicacion ( valor default ) o no enviar ningun valor

    Parametros    :        Descripcion
    inuSuscriber          Codigo de la suscripcion
    inuThreadNumber       Numero de Hilos
    inuThread             Numero del Hilo Procesado

    Retorno    :
       Numero de servicios suscritos a procesar

    Autor    :    Liliani Rojas Salazar
    Fecha    :    Septiembre 26 del 2005

    Historia de Modificaciones
    Fecha        ID Entrega
    26-Sep-2005     lilianirSAO41580
    Creacion de la funcion.
*/
FUNCTION fnuGetSubsServByThread
    (
    inuSubscriber      in  servsusc.sesususc%type default -1,
    inuThreadNumber    in  number default 1,
    inuThread          in  number default 1
    )
    RETURN NUMBER
    IS
    -- Servicios Suscritos a procesar
    nuRegAProcesar           number;
    cuServSuscNumber       pkconstante.tyRefCursor;

    /* ************************************************************ */
    /*           Encapsulated Methods                     */
    /* ************************************************************ */
    /* ------------------------------------------------------------ */
    PROCEDURE GetSubsServices  IS
    BEGIN
    --{
        pkErrors.Push ('pkServNumberMgr.fnuGetSubsServByThread.GetSubsServices');

        if cuServSuscNumber%ISOPEN then
           close cuServSuscNumber;
        END if;

        -- Cursor para contar el numero de servicios suscritos
        -- ASociados al proceso
        open cuServSuscNumber FOR
        SELECT count(*)
        FROM   servsusc
        WHERE  sesunuse > 0 AND
               MOD ( sesunuse, inuThreadNumber ) + 1 = inuThread;

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
        when others then
            pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
            pkErrors.Pop;
            raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    --}
    END GetSubsServices;
    /* ------------------------------------------------------------ */
    PROCEDURE GetSubscriberSubsServ  IS
    BEGIN
    --{
        pkErrors.Push ('pkServNumberMgr.fnuGetSubsServByThread.GetSubscriberSubsServ');

        if cuServSuscNumber%ISOPEN then
           close cuServSuscNumber;
        END if;

        open cuServSuscNumber FOR
        SELECT count(*)
        FROM   servsusc
        WHERE  sesususc = inuSubscriber ;

        pkErrors.Pop;
    --}
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
        when others then
            pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
            pkErrors.Pop;
            raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    --}
    END GetSubscriberSubsServ;
    /* ------------------------------------------------------------ */
BEGIN
--{
    pkErrors.Push('pkServNumberMgr.fnuGetSubsServByThread');

    -- Fija el numero de servicios suscritos a procesar
    nuRegAProcesar := 0;

    -- Carga parametros requeridos para el proceso
    GetParameters;

    if ( inuSubscriber = pkConstante.NULLNUM ) then
        -- Obtiene el numero de servicios suscritos a procesar
        GetSubsServices;
    else
        -- Obtiene el numero de servicios suscritos de la suscripcion
        -- a procesar
        GetSubscriberSubsServ;
    END if;

    -- Cuenta el numero de ervicios suscritos que pertenecen al proceso
    fetch cuServSuscNumber into nuRegAProcesar;

    close cuServSuscNumber;

    pkErrors.Pop;
    return (nuRegAProcesar);

EXCEPTION
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
END fnuGetSubsServByThread;
/* ****************************************************************************
    Propiedad Intelectual de Open Systems (c)

    Procedure    :    fblGetSubsServByThread

    Descripcion    :    Obtiene los servicios suscritos en los procesos masivos
                    ( Procesos por Hilos )

    Parametros    :         Descripcion
       inuSusbcriber          Suscripcion ( -1 si son todas )
       inuSubsServMin        Ultimo servicio suscrito procesado
    inuBlockSize          Limite de la Coleccion
    inuThreadNumber       Numero de Hilos
    inuThread             Numero del Hilo Procesado

    Retorna    :
        orctbSubsServices  Registro de tablas con servicios suscritos

    Autor    :    Liliani Rojas Salazar
    Fecha    :    Septiembre 26 del 2005

    Historia de Modificaciones
    Fecha        ID Entrega
    26-Sep-2005 lilianirSAO41580
    Creacion.
*/

FUNCTION fblGetSubsServByThread
    (
    inuSubscriber       in    servsusc.sesususc%type,
    inuSubsServMin      in    servsusc.sesunuse%type,
    inuBlockSize        in  number,
    inuThreadNumber     in  number,
    inuThread           in  number,
       otbSubsServices     out nocopy pktblServsusc.tySesunuse
    )
RETURN boolean
IS

    cuSuscServices  pkConstante.tyRefCursor;
    blMoreRecords   boolean;
    nuBlockSize     number;
    /* ************************************************************ */
    /*           Encapsulated Methods                     */
    /* ************************************************************ */

    /* ------------------------------------------------------------ */
    PROCEDURE Initialize IS
    BEGIN
    --{
        pkErrors.Push ('pkServNumberMgr.fblGetSubsServByThread.Initialize');

        -- Limpia tabla
        gtbSesunuse.DELETE;
          -- Define tama?o maximo del bloque
        nuBlockSize := 9999999 ;

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;

        when others then
            pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
            pkErrors.Pop;
            raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

    --}
    END Initialize;
    /* ------------------------------------------------------------ */

    PROCEDURE FillOutRecord IS

    BEGIN
    --{

        pkErrors.Push ('pkServNumberMgr.fblGetSubsServByThread.FillOutRecord');

        otbSubsServices :=  gtbSesunuse;

        Initialize;

        pkErrors.Pop;

    EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise;

    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

    --}
    END FillOutRecord;
    /* ------------------------------------------------------------ */
    PROCEDURE GetCursor IS
    BEGIN
    --{

        pkErrors.Push ('pkServNumberMgr.fblGetSubsServByThread.GetCursor');

        if ( inuSubscriber = pkConstante.NULLNUM) then
        --{
            -- Asigna como tama?o del bloque el ingresado
            nuBlockSize := inuBlockSize ;

            -- Abre Cursor para obtener todos los servicios suscritos
            OPEN cuSuscServices FOR
            SELECT sesunuse
            FROM   servsusc
            WHERE  sesunuse > inuSubsServMin
            AND    MOD ( sesunuse, inuThreadNumber ) + 1 = inuThread ;

        else

            -- Abre CURSOR para obtener los servicios suscritos de una
            -- Suscripcion y no se utiliza modulo porque en este para
            -- una sola suscripcion solo se levanta un hilo
            OPEN cuSuscServices FOR
            SELECT sesunuse
            FROM   servsusc
            WHERE  sesususc = inuSubscriber ;
        --}
        END if;

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;

        when others then
            pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
            pkErrors.Pop;
            raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

    --}
    END GetCursor;
    /* ------------------------------------------------------------ */
BEGIN
--{

    pkErrors.Push ('pkServNumberMgr.fblGetSubsServByThread');

    -- Inicializacion de colecciones
    Initialize;

    -- Obtiene parametros requeridos para el proceso
    GetParameters;

    if ( cuSuscServices%isopen ) then
    --{
        close cuSuscServices;
    --}
    end if ;

    blMoreRecords := true;

    GetCursor;

    fetch cuSuscServices bulk collect INTO  gtbSesunuse
    limit nuBlockSize ;

    if ( cuSuscServices%Notfound) then
    --{
        blMoreRecords := false ;
    --}
    END if;

    if ( gtbSesunuse.COUNT > 0 ) then
    --}
        FillOutRecord;
    --}
    END if;

    close cuSuscServices;

    pkErrors.pop;

    return ( blMoreRecords );


EXCEPTION
    when LOGIN_DENIED then
    pkErrors.pop;
    raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        -- Error Oracle nivel dos
        pkErrors.pop;
    raise pkConstante.exERROR_LEVEL2;

    when others then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);

--}
END fblGetSubsServByThread;

/*
    Propiedad intelectual de Open Systems (c).

    Procedure   :    ValExistProdByCompany

    Descripcion :    Valida que el producto pertenezca a la empresa del usuario
                      que ejecuta el proceso

    Parametros  :        Descripcion
        inuProduct    Codigo del producto

    Autor       :    Johanna Noguera Leon

    Fecha       :    19-11-2007

    Historia de Modificaciones
    Fecha    Autor    Modificacion

    19-11-2007      jnogueraSAO67795
    Creacion.
*/
PROCEDURE ValExistProdByCompany
(
    inuProduct          in  servsusc.sesunuse%type
)
IS
    cnuComp_Error       constant    number := 18047;
    nuCompanyUser       servsusc.sesusist%type;
    nuCompanyProd       servsusc.sesusist%type;
BEGIN
    pkErrors.Push('pkServNumberMgr.ValExistProdByCompany');

    -- Obtiene la empresa del usuario que ejecuta el proceso
    nuCompanyUser := SA_BOSystem.fnuGetUserCompanyId;

    -- Obtiene la empresa del producto
    nuCompanyProd := pktblServsusc.fnuGetCompany( inuProduct );

    -- Valida si la emrpesa del usuario es diferente de la empresa del producto
    if ( nuCompanyProd <> nuCompanyUser ) then

        pkErrors.SetErrorCode( pkConstante.csbDIVISION,
                               pkConstante.csbMOD_BIL,
                               cnuComp_Error
                              );
        raise LOGIN_DENIED;

    end if;

    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValExistProdByCompany;

/*
    Propiedad intelectual de Open Systems (c).

    Procedure   :    fnuProductWithService

    Descripcion :    Obtiene numero de productos con servicio

    Parametros  :        Descripcion

    Autor       :    Carlos Andres Dominguez Naranjo

    Fecha       :    07-Abr-2008

    Historia de Modificaciones
    Fecha       Autor    Modificacion

    30-01-2009  druizSAO88556
    Se modifica la consulta asociada al CURSOR <cuProduct> para que no tenga en
    cuenta la fecha de retiro y en su lugar, verifique que el estado del producto
    tenga activo el flag de producto activo

    08-Abr-2008 cdominguSAO71632
    Creacion.
*/

FUNCTION fnuProductWithService (inuSusccodi suscripc.susccodi%type)
return number
IS
    nuTotalProduct  number;
    CURSOR cuProduct IS
        SELECT      count(1)
        FROM        pr_product, suscripc
        WHERE       susccodi = inuSusccodi
        AND         pr_product.subscription_id = suscripc.susccodi
        AND         pr_product.product_status_id IN
        (
            SELECT  product_status_id
            FROM    ps_product_status
            WHERE   is_active_product = 'Y'
        )
        GROUP BY    susccodi;

BEGIN

    pkErrors.Push('pkServNumberMgr.fnuProductWithService');

    nuTotalProduct := 0;

    open cuProduct;
    fetch cuProduct INTO nuTotalProduct;

    if cuProduct%notfound then
        nuTotalProduct := 0;
    END if;

    close cuProduct;

    pkErrors.Pop;

    return nuTotalProduct;

EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fnuProductWithService;

/*
    Propiedad intelectual de Open Systems (c).

    Procedure   :    fnuValidateRangeOfProduct

    Descripcion :    Valida si un contrato tiene la cantidad de productos en un
                    rango

    Parametros  :        Descripcion

    Autor       :    Carlos Andres Dominguez Naranjo

    Fecha       :    07-Abr-2008

    Historia de Modificaciones
    Fecha    Autor    Modificacion

    08-Abr-2008 cdominguSAO71632
    Creacion.
*/

FUNCTION fnuValidateRangeOfProduct
(
    inuMinProduct   in  number,
    inuMaxProduct   in  number,
    inuSusccodi     in  suscripc.susccodi%type
)
return number
IS
    nuTotalProduct  number;
    nuQuery         number;
BEGIN

    pkErrors.Push('pkServNumberMgr.fnuValidateRangeOfProduct');

    nuQuery := 0;
    -- Obtiene cantidad de productos
    nuTotalProduct := fnuProductWithService (inuSusccodi);
    nuQuery := nuTotalProduct;

    if (inuMinProduct IS not null) AND (inuMinProduct != 0) then
        if ( nuTotalProduct < inuMinProduct) then
            nuQuery := -1;
        END if;

    END if;

    if (inuMaxProduct IS not null) AND (inuMaxProduct != 0) then
        if ( nuTotalProduct > inuMaxProduct)    then
            nuQuery := -1;
        END if;
    END if;

    pkErrors.Pop;

    return nuQuery;

EXCEPTION
    when LOGIN_DENIED then
    pkErrors.Pop;
    raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
    pkErrors.Pop;
    raise pkConstante.exERROR_LEVEL2;
    when others then
    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    pkErrors.Pop;
    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END fnuValidateRangeOfProduct;

/* ************************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: fnuGetExpiredDaysAccounts
    Descripcion	: Verifica Dias Cuentas vencidas
    Parametros	:

    Retorno     :  boolean

    Autor	: Carlos Andres Dominguez Naranjo cdomingu
    Fecha	: 17-04-2008

    Historia de Modificaciones
    Fecha	   IDEntrega
    DD-MM-YYYY    <Autor>SAONNNNN
    Modificacion
    17-04-2008    cdominguSAO71632
    creacion
************************************************************************ */
FUNCTION fnuGetExpiredDaysAccounts ( inuSusccodi suscripc.susccodi%type,
    inuMaxVencido in number )
return number
IS
--------------------------------------------------------------------
-- Constantes
--------------------------------------------------------------------
--------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------
-- CURSOR que obtiene cuentas vencidas
cuAccounts          pkConstante.tyRefCursor;
-- Registro de cuenta de cobro
rcAccount           cuencobr%rowtype;
nuValue number;
--------------------------------------------------------------------
-- Cursores
--------------------------------------------------------------------
BEGIN
--{

    pkErrors.push ('pkServNumberMgr.fnuGetExpiredDaysAccounts');

    nuValue := 0;

    -- Captura las cuentas de cobro vencidas.
     pkAccountMgr.GetContractDueBalance( inuSusccodi, cuAccounts );
    -- Obtiene primer registro (mas antiguo)
    fetch cuAccounts INTO rcAccount;
    close cuAccounts;

    -- Dias desde la fecha actual a la cuenta mas antigua
    nuValue := (sysdate - nvl(rcAccount.cucofeve,sysdate));

    if inuMaxVencido > nuValue then
        nuValue := -1;
    END if;

    pkErrors.Pop;
    return nuValue;

EXCEPTION
    when LOGIN_DENIED then
	pkErrors.pop;
	raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
 	-- Error Oracle nivel dos
	pkErrors.pop;
	raise pkConstante.exERROR_LEVEL2;

    when OTHERS then
	pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
	pkErrors.pop;
	raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);

END fnuGetExpiredDaysAccounts;

/* ************************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: fnuGetExpiredBill
    Descripcion	: Verifica Porcentaje de Cuentas vencidas
    Parametros	:

    Retorno     :  boolean

    Autor	: Carlos Andres Dominguez Naranjo cdomingu
    Fecha	: 17-04-2008

    Historia de Modificaciones
    Fecha	   IDEntrega

    05-01-2009  hhammadSAO79711 (Cambios de hrios con el SAO 79711)
    Se modifica para que la deuda tenga en presente el saldo
    de la cuenta menos los valores en reclamo en vez de los saldos pendientes,
    se modifica para que retorne 1 si encuentra alguna cuenta que cumpla con las
    condiciones de porcentaje

    Modificacion
    17-04-2008    cdominguSAO71632
    creacion
************************************************************************ */
FUNCTION fnuGetExpiredBill ( inuSesunuse servsusc.sesunuse%type,
    inuMaxPorcentaje in number )
return number
IS
    --------------------------------------------------------------------
    -- Tipos
    --------------------------------------------------------------------

    type tynuExpBill IS table of number(10) index BY binary_integer;

    --------------------------------------------------------------------
    -- Constantes
    --------------------------------------------------------------------
    --------------------------------------------------------------------
    -- Variables
    --------------------------------------------------------------------
    -- CURSOR que obtiene cuentas vencidas
    cuAccounts          pkConstante.tyRefCursor;
    -- Registro de cuenta de cobro
    rcAccount           cuencobr%rowtype;
    nuValue number;
    nuPorcentaje number;
    nuSaldo      number := 0;
    nuValor      number := 0;

    --------------------------------------------------------------------
    -- Cursores
    --------------------------------------------------------------------
BEGIN
--{

    pkErrors.push ('pkServNumberMgr.fnuGetExpiredBill');
    nuValue  := -1;
    -- Captura las cuentas de cobro vencidas.
    pkAccountMgr.GetProductDueBalance( inuSesunuse, cuAccounts );

    LOOP
    --{
        fetch cuAccounts INTO rcAccount;
        exit when cuAccounts%notfound;

        nuSaldo := ( nvl(rcAccount.cucosacu,0) -
                   nvl(rcAccount.cucovare,0) - nvl(rcAccount.cucovrap,0) );

        nuValor := rcAccount.cucovato;

        nuPorcentaje := (nuSaldo/nuValor)*100;

        if (nuPorcentaje >= inuMaxPorcentaje)  THEN
        --{
            nuValue := 1 ;
        --}
        END if;
    --}
    end loop;

    close cuAccounts;

    pkErrors.Pop;

    return nuValue;

EXCEPTION
    when LOGIN_DENIED then
	pkErrors.pop;
	raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
 	-- Error Oracle nivel dos
	pkErrors.pop;
	raise pkConstante.exERROR_LEVEL2;

    when OTHERS then
	pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
	pkErrors.pop;
	raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);

END fnuGetExpiredBill;

/* ************************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: fnuValidateAvance
    Descripcion	: Verifica Avance
    Parametros	:

    Retorno     :

    Autor	: Carlos Andres Dominguez Naranjo cdomingu
    Fecha	: 17-04-2008

    Historia de Modificaciones
    Fecha	   IDEntrega
    DD-MM-YYYY    <Autor>SAONNNNN
    Modificacion
    17-04-2008    cdominguSAO71632
    creacion
************************************************************************ */
FUNCTION fnuValidateAvance
(
    inuApcssesu in  avanpcss.apcssesu%type,
    inuApcsesac in  avanpcss.apcsesac%type
)
return avanpcss.apcscons%type
IS
    onuAvance number;
    CURSOR cuAvance
    (
    nuApcssesu avanpcss.apcssesu%type,
    nuApcsesac avanpcss.apcsesac%type
    )
    IS
        SELECT APCSCONS
        FROM avanpcss
        WHERE apcssesu = nuApcssesu
        AND apcsesac = nuApcsesac
        and apcsactu = 'S';

BEGIN
    pkErrors.Push('pkServNumberMgr.fnuValidateAvance');
    onuAvance := -1;

    open cuAvance( inuApcssesu, inuApcsesac );
    fetch cuAvance INTO onuAvance;
    if cuAvance%notfound then
        onuAvance := -1;
    END if;
    close cuAvance;

    pkErrors.pop;

    return onuAvance;

EXCEPTION
    when LOGIN_DENIED then
	pkErrors.pop;
	raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
	-- Error Oracle nivel dos
	pkErrors.pop;
	raise pkConstante.exERROR_LEVEL2;

    when OTHERS then
	pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
	pkErrors.pop;
	raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);
END fnuValidateAvance;
 /*******************************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure     : fcuProdBalbyContract

    Description : Selecciona los productos pertenecientes a un Contrato pasado
                  por parametro que tengan saldo pendiente

    Parametros :
                inuSuscripc : contrato del que se desean extraer los productos-

    Retorna : Cursor referenciado con los productos pertenecientes al ontrato
              que tienen saldo pendiente.

    Autor : Andres David Valencia

    Fecha : 20-07-2005
    Historia de Modificaciones
    Fecha         IDEntrega
    Modificacion
    20-07-2005   avalenciaSAO39851
    Se elimina restriccion de solo retornar servicios suscritos que no estuvieran
    retirados.

    20-07-2005   avalenciaSAO38680
    Creacion

*******************************************************************************/
Function fcuProdBalbyContract
(
    inuSuscripc         in      suscripc.susccodi%type
) return pkConstante.tyRefCursor
IS
    ----------------------------------------------------------------------------
    cuRetorno  pkConstante.tyRefCursor;

BEGIN
-- {
    pkErrors.Push('pkServNumberMgr.fcuProdBalbyContract');

    if (cuRetorno%isOpen) then
        close cuRetorno;
    end if;

    open cuRetorno for

        SELECT sesunuse,
               pkbccuencobr.fnuGetBalAccNum(sesunuse) sesusape,
               pkbccuencobr.fnuGetClaimValue(sesunuse) sesuvare,
               pkbccuencobr.fnuGetNonAppliedPay(sesunuse) sesuvrap,
               sesuserv
        FROM servsusc
        WHERE  sesususc = inuSuscripc
        AND    pkbccuencobr.fnuGetBalAccNum(sesunuse) > pkBillConst.CERO;

    pkErrors.Pop;

    return ( cuRetorno );

EXCEPTION

    when LOGIN_DENIED then
        pkErrors.pop;
        raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        -- Error Oracle nivel dos
        pkErrors.pop;
        raise pkConstante.exERROR_LEVEL2;
    when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);
-- }
END fcuProdBalbyContract;


    /*
        Propiedad intelectual de Open International Systems. (c).

        Procedure	: fnuValPendingBalRange
    		  English Description
        Descripcion	: Valida que el saldo pendiente del producto se encuentre
                      dentro del rango especificado

        Parametros	:	Descripcion

            inuProduct              Codigo del producto
            inuPenBalLowerLimit     Limite inferior del saldo pendiente
            inuPenBalUpperLimit     Limite superior del saldo pendiente

        Retorno     :

            1, Si el saldo pendiente del producto se encuentra dentro del rango
            -1, de los contrario

        Autor	:   Diego Alejandro Ruiz Tabares
        Fecha	:   30-01-2009

        HISTORIA DE MODIFICACIONES
        Fecha       ID Entrega
        Descripcion

        30-01-2009  druizSAO88556
        Creacion del objeto.
    */

    FUNCTION fnuValPendingBalRange
    (
        inuProduct              in      servsusc.sesunuse%type,
        inuPenBalLowerLimit     in      number,
        inuPenBalUpperLimit     in      number
    ) RETURN number
    IS

        -- Flag que indica si el saldo pendiente del producto se encuentra dentro
        -- del rango
        nuPendBalInRange        number := 1;

        -- Saldo pendiente del producto
        nuProdPendingBalance    number;

    BEGIN
    --{
        pkErrors.Push( 'pkServNumberMgr.fnuValPendingBalRange' );

        -- Se obtiene el saldo pendiente del producto
        nuProdPendingBalance := pkBCCuencobr.fnuGetOutStandBal( inuProduct );

        -- Se verifica el limite inferior
        if ( ( inuPenBalLowerLimit is not NULL ) and ( nuProdPendingBalance < inuPenBalLowerLimit ) ) then
            nuPendBalInRange := -1;
        end if;

        -- Se verifica el limite superior
        if ( ( inuPenBalUpperLimit is not NULL ) and ( nuProdPendingBalance > inuPenBalUpperLimit ) ) then
            nuPendBalInRange := -1;
        end if;

        pkErrors.Pop;

        return nuPendBalInRange;

    EXCEPTION

        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        	pkErrors.Pop;
        	raise;

        when OTHERS then
        	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        	pkErrors.Pop;
        	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    --}
    END fnuValPendingBalRange;


    /*
        Propiedad intelectual de Open International Systems. (c).

        Procedure	: fnuValProdAccWithBal
    		  English Description
        Descripcion	: Valida si el numero de cuentas con saldo del producto es igual
                      al numero de cuentas especificado

        Parametros	:	Descripcion

            inuProduct              Codigo del producto
            inuAccWitnBal           Numero de cuentas con saldo

        Retorno     :

            1, Si el numero de cuentas con saldo del producto es igual al numero
               de cuentas especificado
            -1, de los contrario

        Autor	:   Diego Alejandro Ruiz Tabares
        Fecha	:   30-01-2009

        HISTORIA DE MODIFICACIONES
        Fecha       ID Entrega
        Descripcion

        30-01-2009  druizSAO88556
        Creacion del objeto.
    */

    FUNCTION fnuValProdAccWithBal
    (
        inuProduct              in      servsusc.sesunuse%type,
        inuAccWithBal           in      number
    ) RETURN number
    IS

        -- Flag que indica si el numero de cuentas con saldo del producto es igual
        -- al numero de cuentas especificado
        nuValAccWithBal         number := 1;

        -- Numero de cuentas con saldo del producto
        nuProdAccWithBal        number;

    BEGIN
    --{
        pkErrors.Push( 'pkServNumberMgr.fnuValProdAccWithBal' );

        -- Se obtiene el numero de cuentas con saldo del producto
        nuProdAccWithBal := pkBCCuencobr.fnuGetBalAccNum( inuProduct );

        -- Se verifica el numero de cuentas especificado
        if ( ( inuAccWithBal is not NULL ) and ( inuAccWithBal <> nuProdAccWithBal ) ) then
            nuValAccWithBal := -1;
        end if;

        pkErrors.Pop;

        return nuValAccWithBal;

    EXCEPTION

        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        	pkErrors.Pop;
        	raise;

        when OTHERS then
        	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        	pkErrors.Pop;
        	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    --}
    END fnuValProdAccWithBal;

--}
    /*
        Propiedad intelectual de Open International Systems. (c).

        Procedure	: fnuValProdAccWithinRange
    		  English Description
        Descripcion	: Valida que las cuentas con saldo del producto se encuentre
                      dentro del rango especificado

        Parametros	:	Descripcion

            inuProduct              Codigo del producto
            inuAccLowerLimit     Limite inferior del saldo pendiente
            inuAccUpperLimit     Limite superior del saldo pendiente

        Retorno     :

            1, Si el numero de cuentas con saldo del producto se encuentra dentro
               del rango
            -1, de los contrario

        Autor	:   Juan Gabriel Torres
        Fecha	:   05-02-2009

        HISTORIA DE MODIFICACIONES
        Fecha       ID Entrega
        Descripcion

        10-Feb-2009  jgtorresSAO88648
        Creacion del objeto.
    */

    FUNCTION fnuValProdAccWithinRange
    (
        inuProduct              in      servsusc.sesunuse%type,
        inuAccLowerLimit        in      number,
        inuAccUpperLimit        in      number
    ) RETURN NUMBER
    IS

        -- Flag que indica si las cuentas con saldo del producto se encuentra dentro
        -- del rango
        nuAccInRange            number := 1;

        -- Numero de cuentas con saldo del producto
        nuAccPending            number;

    BEGIN
    --{
        pkErrors.Push( 'pkServNumberMgr.fnuValProdAccWithinRange' );

        -- Se obtiene el numero de cuentas con saldo del producto
        nuAccPending := pkBCCuencobr.fnuGetBalAccNum( inuProduct );

        -- Se verifica el limite inferior
        if ( ( inuAccLowerLimit is not NULL ) and ( nuAccPending < inuAccLowerLimit ) ) then
            nuAccInRange := -1;
        end if;

        -- Se verifica el limite superior
        if ( ( inuAccUpperLimit is not NULL ) and ( nuAccPending > inuAccUpperLimit ) ) then
            nuAccInRange := -1;
        end if;

        pkErrors.Pop;

        return nuAccInRange;

    EXCEPTION

        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        	pkErrors.Pop;
        	raise;

        when OTHERS then
        	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        	pkErrors.Pop;
        	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    --}
    END fnuValProdAccWithinRange;

/*
    Propiedad intelectual de Open Systems (c).
    Procedure       :    UpdAccoReceivable
    Descripcion     :    Actualiza los campos del servicio suscrito relacionados con cartera

    Parametros      :    Descripcion
    inuNumServ           Numero de servicio
    inuSesusafa          Saldo a Favor
    isbSesuesfn          Estado Financiero
    idtSesufeca          Fecha de Vencimiento de Cuenta mas antigua con saldo

    Retorno         :
    Autor           :    Maryuri Ramos Giraldo
    Fecha           :    16 Marzo de 2012
    Historia de Modificaciones
    Fecha    Id Entrega
    16-Mar-2012 mramosSAO177466
    creacion.
*/
procedure UpdAccoReceivable
(
    inuNumServ      in  servsusc.sesunuse%type,
    inuSesusafa     in  servsusc.sesusafa%type,
    isbSesuesfn     in  servsusc.sesuesfn%type
)
IS
BEGIN
    pkErrors.Push('pkServNumberMgr.UpdAccoReceivable');

    UPDATE servsusc
    SET sesusafa = inuSesusafa,
        sesuesfn = isbSesuesfn
    WHERE sesunuse = inuNumServ;

    if ( sql%notfound ) then
        pkErrors.SetErrorCode( csbDIVISION, csbMODULE, cnuRECORD_NO_EXISTE );
        raise LOGIN_DENIED ;
    end if;

    pkErrors.Pop;
EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;
    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END UpdAccoReceivable;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure   :    UpFraudProfile
        Descripcion :    Actualiza el servicio suscrito en el perfil de fraude
        Parametros  :    Descripcion
            inuNumeServ  Numero de servicio
        Retorno     :
        Autor       :    Diego Cardona Acevedo
        Fecha       :    29-05-2012

        Historia de Modificaciones
        Fecha        Id Entrega
        29-05-2012   dcardonaSAO181542
        Estabilizacion 7.7 ref. mramosSAO180130
        {
            creacion.
        }
    */
    PROCEDURE UpFraudProfile
    (
        inuNumeServ in      servsusc.sesunuse%type,
        inuProfile  in      servsusc.sesuperf%type
    )
    IS
    BEGIN
        pkErrors.Push('pkServNumberMgr.UpFraudProfile');

        UPDATE servsusc
        SET sesuperf = inuProfile
        WHERE sesunuse = inuNumeServ;

        if ( sql%notfound ) then
            pkErrors.SetErrorCode( csbDIVISION, csbMODULE, cnuRECORD_NO_EXISTE );
            raise LOGIN_DENIED ;
        end if;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.Pop;
            raise LOGIN_DENIED;
        when pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise pkConstante.exERROR_LEVEL2;
        when others then
            pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
            pkErrors.Pop;
            raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END UpFraudProfile;

-- =============================================================================


    /***************************************************************************

    Propiedad intelectual de Open International Systems. (c)

    Procedure   :   GetProductsByContract
    Descripcion :   Obtiene una tabla PL con los productos asociados al contrato
                    dado como parametro.

    Parametros  :       Descripcion
        inuContract     Contrato
        iboCache        Indica si usa cache

    Retorno     :   Tabla PL con los productos

    Autor       : Julio Cesar Llano Ref: German Andres Vargas
    Fecha       : 30-09-2011

    Historia de Modificaciones
    Fecha       IDEntrega
    08-10-2012  abermudezSAO193346
    Se modifica para adicionar parametro que indica si hace cache o no.

    30-08-2012  jllanoSAO189020 Ref: gvargasSAO160884
    Creacion
    ***************************************************************************/
    PROCEDURE GetProductsByContract
    (
        inuContract     in  servsusc.sesususc%type,
        otbProducts     out nocopy tytbServsusc,
        iboCache        in  boolean default true
    )
    IS
        cnuSERV_NOT_FOUND   constant number := 9;

        ---------------
        -- Cursores  --
        ---------------
        CURSOR cuProdsByCont
        IS
            SELECT  /*+ index(servsusc IX_SERVSUSC024) */
                    *
            FROM    servsusc /*+ pkServNumberMgr.GetProductsByContract */
            WHERE   sesususc = inuContract;
    BEGIN
        pkErrors.push('pkServNumberMgr.GetProductsByContract');
        ut_trace.trace('INICIO pkServNumberMgr.GetProductsByContract ['||inuContract||']', 5);

        -- Cierra Cursor --
        if ( cuProdsByCont%isOpen ) then
        --{
            close cuProdsByCont;
        --}
        end if;

        -------------------------------------------------------------
        -- Guarda en memoria el ultimo resultado                   --
        -------------------------------------------------------------
        if ( gnuContractMem is null        or
             gnuContractMem != inuContract or
             not iboCache) then
        --{
            -- Open / fetch / Close --
            open cuProdsByCont;
            fetch cuProdsByCont bulk collect INTO otbProducts;
            close cuProdsByCont;

            gtbServsuscMem.delete;
            gtbServsuscMem := otbProducts;
            gnuContractMem := inuContract;

        else
            ut_trace.trace('Productos en cache', 6);
            otbProducts := gtbServsuscMem;
        --}
        end if;

        ut_trace.trace('Obtenidos ' || otbProducts.count || ' productos', 6);

        -- Si no hay datos Genera Error --
        if ( otbProducts.count = 0 ) then
        --{
            pkErrors.SetErrorCode
            (
                pkConstante.csbDIVISION,
                pkConstante.csbMOD_GRL,
                cnuSERV_NOT_FOUND
            );
            raise LOGIN_DENIED;
        --}
        end if;

        ut_trace.trace('FIN pkServNumberMgr.GetProductsByContract', 5);

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        	pkErrors.Pop;
        	raise;
        when OTHERS then
        	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        	pkErrors.Pop;
        	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END GetProductsByContract;

END pkServNumberMgr;
