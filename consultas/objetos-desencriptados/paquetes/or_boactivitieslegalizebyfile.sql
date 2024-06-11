CREATE OR REPLACE PACKAGE BODY OR_BOActivitiesLegalizeByFile
IS
/*****************************************************************
Propiedad intelectual de Open International Systems (c).

Unidad         : OR_BOActivitiesLegalizeByFile
Descripcion    : Legaliza las actividades y la orden con los datos enviados en un archivo plano
Autor          : Jose Alexander Samboni
Fecha          : 22/Ago/2008


Historia de Modificaciones
Fecha             Autor             Modificacion
===========     =========           ====================
22-08-2014  FSaldanaSAO265233       Se adiciona
                                    <fblGetIsLegalByFile>
                                    gblIsLegalizeByFile

                                    Se modifica LegalizeFromFile

21-06-2013  llopezSoa210199         Se adiciona
                                        cnuMAX_COLUMN_EDT
                                        gnuMAX_COLUMN
                                        gdtInitialDate
                                        gdtFinalDate
                                    Se modifica
                                        valFileStructure
                                        LegalizeFromFile
25-01-2013  yclavijo.SAO200482      Se modifica el metodo LoadAndValidInitialData
18-01-2013  cenaviaSAO199883        Se modifica <cnumaxlengthToleg> <stySizeLine>
28-12-2012  ARojas.SAO198736        Se modifica <LegalizeOrderByLine>
17-12-2012  Arojas.SAO198204        Se modifica <<LegalizeOrderByLine>>
                                                <<ProcessCommentOrderByLine>>
11-12-2012  AEcheverrySAO197519     Se modifica <<processReadData>>
06-12-2012  cenaviaSAO197519        Se modifica <ProcessItemData>
04-12-2012  cenaviaSAO197498        Se modifica <processReadData>
26-10-2012  cenaviaSAO194932        Se modifica <AssociateSealComp> <LoadAndValidInitialData>
17-10-2012  cenaviaSAO194319        Se modifica <ValAssoSealComp>
17-10-2012  cenaviaSAO194244        Se modifica <updAttributeActivity> <AssociateSealComp>
11-10-2012  GPaz.SAO193906          Se modifica <regRubbishLoad>
11-10-2012  MArteaga.SAO193835      Se modifica <regRubbishLoad>
08-10-2012  cenaviaSAO193287        Se modifica <ValAssoSealComp>
06-10-2012  AEcheverrySAO193197     Se modifica AssociateSealComp
27-09-2012  cenaviaSAO192053        Se modifica la estructura del archivo plano
                                    para lecturas, solo se modifica la descripcion
14-09-2012  cenaviaSAO190698        Se modifica
                                        <ValAssoSealComp>
08/08/2012  JGarcia.SAO186231       Se modifica <<ProcessItemData>>

01-08-2012  Arojas.SAO184025        Estabilizacion, Se modifica:
                                        <LegalizeFromFile>
26-07-2012  yclavijo.SAO184604      Se modifica el metodo updComponentData
                                    Se crea el metodo regRubbishLoad
23-07-2012  cenaviaSAO186451        Se adiciona
                                        <ValidInitDataToLegalByFile>
                                    Se modifica
                                        <LoadAndValidInitialData>
                                        <LegalizeOrderAdm>
27-Jun-2012     anietoSAO179521     Se Modifica el procedimiento <<AssociateSealComp >>
                                                      para agregar la opcion de localizacion
22-06-2012      cenaviaSAO182730    Estabilizacion. Ref SAO181241 y SAO180912
                                        Se modifica el metodo:
                                        <valFileStructure>
                                        Se modifica el metodo:
                                        <valFileStructure>
29-05-2012      cenaviaSAO183476    Se modifica el metodo:
                                        <LegalizeFromFile>
17-04-2012      cenaviaSAO159297    Se adiciona los metodos
                                        <processReadData>
                                        <processReadByLine>
                                        <AssociateSealComp>
                                        <fsbValAssoSealComp>
                                    Se modifica los metodos
                                        <UTILITIESCOMPONENT>
09-04-2012      cenaviaSAO179538    Estabilizacion.
                cenaviaSAO179389    Se modifica <LoadAndValidInitialData>
14-03-2012      cenaviaSAO176556    Estabilizacion.
                cenaviaSAO175673    Se crea el subtipo <stySizeLine> y la
                                    constante <cnumaxlengthToleg>
                                    Se modificsa los metodos <LoadAndValidInitialData>
                                    <valFileStructure> y <LegalizeFromFile>
09-02-2012      gpaz.SAO173805      Se elimina <<UtilitiesComponentRuote>>
                                    Se modifica <<updComponentData>>
12-oct-2011     AEcheverrySAO163123 Se modifica el metodo <<updAttributeActivity>>
02-Ago-2011     AEcheverrySAI155143 Se <<procActividadApoyo>>
05-11-2010      cburbano.SAO132231   Se modifica <AddRedElement>
01-10-2010      llopezSAO129961     Se modifica <<LegalizeFromFile>>
28-09-2010      tlopez.SAO128405    Modificacion de ProcessAttibutesActivity
28-09-2010      llopezSAO126327     Se adiciona
                                        cnuMAX_COLUMN_ADM
                                        cnuCOL_COMMENT_ADM
                                        <<LegalizeOrderAdm>>
                                    Se modifica
                                        <<valFileStructure>>
                                        <<LoadAndValidInitialData>>
                                        <<LegalizeFromFile>>
28-09-2010      tlopez.SAO128421    Modificacion de ProcessAttibutesActivity
08-09-2010      tlopez.SAO122399    Estabilizacion sao122345 aalbarracin
                                    Se modifica LegalizeOrderByLine
02-Sep-2010     csolanoSAO123697    Se modifica ProcessAttibutesActivity
25-Ago-2010     amendezSAO125755        Se modifica el metoo
                                        <valFileStructure>
                                        <ProcessItemData>
                                        <valItemOutFlag>
24-May-2010     AEcheverrySAO118590 Se modifica el metodo
                                        <<ProcessAttibutesActivity>>
24-May-2010     AEcheverrySAO118249 Se modifica el metodo
                                        <<procActividadApoyo>>
20-May-2010     AEcheverrySAO118199 Se modifican los metodos
                                        <<LegalizeOrderByLine>>
                                        <<ProcessActivitiesByLine>>
                                        <<ProcessAttibutesActivity>>
                                    se crea el metodo <<procActividadApoyo>>
05-Ene-2010     cburbanoSAO110258   Se modifican los metodos ProcessItemData
                                    valFileStructure, ProcessAttibutesActivity
23-12-2009      AEcheverrySAO109907 estabilizacion [SAO108636]
                                    Se modifica el metodo <<AddRedElement>>
                                    estabilizacion [SAO108850]
                                    Se modifica el metodo <<InsOrUpdTempOrderItems>>
                                    Estabilizacion [SAO109439]
                                    Se modifica el metodo <<LegalizeFromFile>>
30-NOv-2009     MArteagaSAO107945   Se modifican los metodos <<ProcessItemData>>
                                                             <<valFileStructure>>
                                                             <<ProcessAttibutesActivity>>
06-Oct-2009     DMunoz SAO103005    Se modifica updAttributeActivity proceso de
                                    atributos de actividad, para validar indice
                                    a utilizar en tabla de elementos no sea nulo.

24-Nov-2008 jhramirezSAO86243     Se modifica el formato del archivo plano para agregarle los comentarios de la orden
                                y se modifican todos los procedimiento necesarios para hacer efectivo este cambio.

                                Se realizan los siguiente Modificaciones.
                                    <<LegalizeOrderByLine>>         Se agrega llamado a <<ProcessCommentOrder>>
                                    <<cnuCOL_COMMENT>>              Se adiciona constante global privada.
                                    <<ValFileStructure>>            Se modifica la validacon del archivo plano.
                                    <<cnuMAX_COLUMN>>               Se modifica la cantidad de las columnas
                                    <<cnuERR_BADSTRUCTED_COMMENT>>  Se adiciona constante global.
                                    <<ProcessCommentOrderByLine>>   Se adiciona este prodimiento.

13-Nov-2008 jhramirezSAO85682    se modifica el PROCEDURE <<LegalizeOrderByLine>>
                                 el llamado a OR_BOItems.FillOrderItemsTempTable   por
                                 el llamado a OR_BOItems.FillOrderItemsTempTablePL



05-Nov-2008 jhramirezSAO85383     Se modifica <<ProcessAttibutesActivity>>, ya que estaba utilizando un procedimiento de OR_boitems
                                que insertaba un or_temp_order_items, pero sin pasarle el ORDER_items_id, entonces cuando se tenian
                                una orden con varias actividades, esta fallaba. se cambio el llamado por este procedimiento.
                                OR_BOItems.InsertOrUpdateItemsTempTable


30-Oct-2008 jhramirezSAO84757   Se modifica <<updComponentData>> para adicionarle la validacion
                                de OR_boconstants.cnuElemTskTypeComponent al inicio del procedimiento.

                                Se Addicionan constantes para los caracteres separadores del Archivo plano, csbSEPARATOR_n




17-Oct-2008 jhramirezSAO83697   Se Crea el PROCEDURE LockOrder
                                <<updComponentData>>            Se modifica este procedimiento para adicionarle
                                                                los componente de rutas. 6,7
                                <<UtilitiesComponentRuote>>     se crea este procedimiento para manejar el componente 6 de Rutas.
                                <<UtilitiesComponentPower>>     Se crea este procedimiento para manejar el componenete 7 de Tipo de Servicio.

                                <<ProcessAttibutesActivity>>    se modifico este procedimiento para Validar Planeacion y realizar las Actividades planeadas requeridas.
                                <<ProcessElementRead>>          Se modifica este procedimiento para cambiar la line
                                                                UT_String.ExtString(isbRead, '!', tbDataRecord);  por
                                                                UT_String.ExtString(isbRead, ':', tbDataRecord);
                                                                Se le adiciona un Parametro de Entrada, nuElementId

                                <<AddRedElement>>               Se le adiciona un Parametro de Entrada, nuElementId

                                <<LegalizeOrderByLine>>
                                <<ProcessActivitiesByLine>>
                                <<ProcessAttibutesActivity>>
                                <<updComponentData>>
                                                                Se modifica para adicionarle, una Tabla dinamica PL, que indicara,
                                                                para un determinado Code de Elementos Asignables (if_assignable),
                                                                su determinado Producto, dado la Actividad que se este procesando.

                                <<UtilitiesComponent>>          Se Modifica para llenar tabla dinamica PL, que mantiene la relacion entre
                                                                los Elementos Asignables y los productos, dado el ORDER_activity


15-Sep-2008 asamboniSAO82168    Se modifica el metodo
                                <ProcessElementRead>
12-Sep-2008 asamboniSAO82058    se modifica el siguiente metodo
                                <LegalizeOrderByLine>

12-Sep-2008 asamboniSAO78737    se modifica el siguiente metodo
                                <LegalizeOrderByLine>

12-Sep-2008 asamboniSAO81933  se actualiza el instancimiento de datos de acuerdo
                              a los ultimos cambios realizodos en el proceso
                              de generacion de legalizacion.
11-11-2008    asamboniSAO81933   Se modifica el siguiente metodo
                                 <updComponentData>
                                 <UtilitiesComponent>
05-sep-2008   aecheverrySAO81305 Se modifica   <<MulElemComponent>>
02-Sep-2008   asamboni SAO81111 Se adiciona la generacion del componente
28-Ago-2008   asamboni SAO78734 Se optimizan metodos
23-Ago-2008   asamboni SAO80833 SE actualiza el metodo
                                <LegalizeOrderByLine>
                                Se borran metodo publicos que se utilizaban para
                                pruebas
23-Ago-2008   asamboni SAO80792 Creacion.
******************************************************************/

	-- Declaracion de variables y tipos globales privados del paquete
    csbVersion   CONSTANT VARCHAR2(20)            := 'SAO265233';

    -- Posiciones de las columnas principales del archivo
    cnuMAX_COLUMN     constant number(2) := 8;  -- Columnas orden sin fechas de ejecucion
    cnuMAX_COLUMN_EDT constant number(2) := 9;  -- Columnas orden con fechas de ejecucion
    gnuMAX_COLUMN     number(2);
    cnuMAX_COLUMN_ADM constant number(2) := 3;
    cnuCOL_ORDER      constant number(2) := 1;
    cnuCOL_CAUSAL     constant number(2) := 2;
    cnuCOL_PERSON     constant number(2) := 3;
    cnuCOL_ADITI_DATA constant number(2) := 4;
    cnuCOL_ACTIVITY   constant number(2) := 5;
    cnuCOL_ITEM       constant number(2) := 6;
    cnuCOL_READ       constant number(2) := 7;
    cnuCOL_COMMENT    constant number(2) := 8;    --Columna del comentario de la Orden. -- jhramirez SAO86243.
    cnuCOL_EXCDATES   constant number(2) := 9;    --Columna de las fechas de ejucion de la Orden.
    cnuCOL_COMMENT_ADM constant number(2) := 3;   --Columna del comentario de la Orden Administrativa.

    csbSEPARATOR_1      constant varchar2(1)    := '|';
    csbSEPARATOR_2      constant varchar2(1)    := ';';
    csbSEPARATOR_3      constant varchar2(1)    := '=';
    csbSEPARATOR_4      constant varchar2(1)    := '<';
    csbSEPARATOR_5      constant varchar2(1)    := '>'; --Antes era :
    csbSEPARATOR_6      constant varchar2(1)    := '!';


    gdtInitialDate      or_order.exec_initial_date%type;
    gdtFinalDate        or_order.execution_final_date%type;

        -- separador de archivos
    csbFILE_SEPARATOR           constant varchar2(1) := '/';
    -- Datos Adicionales no cumplen la estructura
    cnuERR_UNSTRUCTURED_ADD_DATA            constant number := 620;
    -- tipo Numero
    cnuNumber                               constant number := ge_boparameter.fnuGet('TYPE_ELEM_NUMBER');
	-- Archivo con estructura invalida
    cnuERR_UNSTRUCTURED_FILE                constant number(3) := 619;
    -- Error en el formato de la linea %s1 en los datos de la actividad, no tiene la estructura correcta para la legalizacion de la orden.
    cnuERR_114703 constant number(6) := 114703;
    -- Causal no valida o no existe
    cnuNOTAVALIDCAUSAL constant number := 3627;
    -- No hay datos en la linea %s1 del archivo, no tiene la estructura correcta y requerida para la Legalizacion de la orden..
    cnuERR_114704 constant number(6) := 114704;
    -- Identificador de la causal no puede ser nula.
    cnuERR_114705 constant number(6) := 114705;
    -- Error en el numero de parametros en los datos del atributo %s1 de la actividad %s2.
    cnuERR_114706 constant number(6) := 114706;
    -- Error en el numero de parametros para obtener el identificador de la actividad %s1.
    cnuERR_114707 constant number(6) := 114707;
    -- Error en la cantidad de parametros para obtener los datos del elemento campo LECTURAS_ELEMENTOS_%s1.
    cnuERR_114709 constant number(6) := 114709;
    -- Error en la cantidad de parametros para obtener  los datos de la lectura %s1 del elemento [%s2].
    cnuERR_114710 constant number(6) := 114710;
    -- Error en la cantidad de parametros para obtener los datos del item (Item o Elemento) ITEM_ELEMENTO_%s1.
    cnuERR_114711 constant number(6) := 114711;
    -- El atributo [%s1] no es valido para el componente [%s2].
    cnuERR_114721  constant number(6) := 114721;
    -- Error en el numero de parametros en los datos del atributo %s1 de la actividad %s2.
    cnuERR_114723  constant number(6) := 114723;
     -- El identificador [%s1] del componente no es valido para el atributo %s2 y la actividad [%s3].
    cnuERR_114724 constant number(6) := 114724;
    -- El elemento [%s1] ya existe para la orden [%s2] actividad [%s3].
    cnuERR_114719  constant number(6) := 114719;
    -- El identificador de la orden de trabajo no puede ser nulo.
    cnuERR_850 constant number(3) := 850;
    -- El identificador de  persona no puede ser nulo.
    cnuERR_112063 constant number(6) :=  112063;
    -- La actividad [%s1] no pertenece a la orden [%s2]
    cnuACTIVITY_NOT_IN_ORDER constant ge_message.message_id%type := 20442;
    -- La actividad [%s1] no pertenece a la orden [%s2]
    cnuNULL_ACTIVITY_AMOUNT  constant ge_message.message_id%type := 20543;
    -- el atributo es requerido
    cnuREQUIRED_ATTRIB      constant  ge_message.message_id%type := 950;
    -- No se pueden anular todas las actividades de la orden
    cnuERR_10861    constant ge_message.message_id%type := 10861;
    -- La cantidad a legalizar no es numerica
    cnuERR_900907   constant ge_message.message_id%type := 900907;
    -- Error en la cantidad de parametros para obtener los datos de lecturas de
    -- elementos campo LECTURAS_ELEMENTOS_%s1.
    cnuERR_114708   constant ge_message.message_id%type := 114708;
    -- El tipo de consumo %s1 no es valido para la categoria %s2
    cnuERR_901042   constant ge_message.message_id%type := 901042;
    -- El Equipo con la Serie [%s1] esta en un estado invalido [%s2]
    cnuERR_7615     constant ge_message.message_id%type := 7615;
    -- El estado [%s1] del item seriado [%s2] no es valido.
    cnuERR_901056   constant ge_message.message_id%type := 901056;
    -- El Equipo con la Serie [%s1] no existe
    cnuERR_7613     constant ge_message.message_id%type := 7613;
    -- El valor del atributo %s1 es nulo.
    cnuERR_9511     constant ge_message.message_id%type := 9511;
    -- El sello %s1 no esta asociado al medidor %s2
    cnuERR_901047   constant ge_message.message_id%type := 901047;
    -- El tipo de comentario %s1 no es valido
    cnuERR_901262   Constant ge_message.message_id%type := 901262;
    -- El dato ingresado [%s1] es invalido
    cnuERR_901778   Constant ge_message.message_id%type := 901778;
    -- Clasificacion de items de tipo elemento
    cnuActivityType     constant    number(2)   := 2;
    -- El Elemento no Posee Tipos de Consumo Facturables
    cnuNOTTIPOCONS                          constant number(4) := 3387;
    -- El tipo no es consumible
    cnuCONSUMABLE                           constant number(3) := 249;
    -- La Unidad Operativa no tiene ordenes en el archivo plano,
    -- a pesar que si tiene ordenes pendientes por Legalizar
    cnu_MESS_HAS_NOT_ORD_FLATFILE           constant number(6) := 114712;
    -- El tipo de consumo %s1 no esta configurado para el elemento %s2
    cnuNOTEXISTCONSUMPTYPE                  constant number(4) := 3464;
    --La Linea numero %s1 del archivo no tiene la estructura correcta para los Comentarios de la Orden.
    cnuERR_BADSTRUCTED_COMMENT              constant number(6)  :=  143554; --jhramirezSaoxx.
    --La Linea numero %s1 del archivo no tiene la estructura correcta para las fechas de ejecucion de la Orden.
    cnuERR_BADSTRUCTED_EXEC_DATES           constant number(6)  :=  902264;
    -- Formato de fecha invalido %s1 [ut_date.fsbDATE_FORMAT]
    cnuERR_FORMATDATE                       constant number(6)  :=  6426;
    --Valor invalido para el flag de salida(Y), o entrada (N) en el item %s1
    cnuERR_OUT_ITEM_FLAG                    constant NUMBER(6)  :=   17302;

    type tyrcValSealToProcess is record
	(
        SealSerie           ge_items_seriado.serie%TYPE
	);

    type tytbValSealToProcess is table of tyrcValSealToProcess index by VARCHAR(50);

    -- Variable para almacenar la serie del equipo que no se puede desasociar
    tbSerialError      tytbValSealToProcess;

    gtbActivitiesAttribConf  or_bcorderactivities.tytbActivitiesAttribConf;

    -- Variable para indicar que se esta realizando el proceso de legalizacion por archivo
    gblIsLegalizeByFile     boolean := FALSE;

    -- Duracion de la orden actual para afectar la capacidad da la unidad de trabajo
    gnuOrderUsedCapacity    number := 0;

	-- Definicion de metodos publicos y privados del paquete

    FUNCTION fsbVersion  return varchar2
    IS
    BEGIN
        return csbVersion;
    END;

    /*************************************************
    Metodo  	:   fnugetOrder
    Descripcion	:   Procedimiento que retorna el id de la ORden que esta en la linea del archivo
    ============  	===================

    Autor		: yclavijo
    Fecha		: 22-Ago-06

    Historia de Modificaciones
    Fecha	    Autor	   Modificacion
    =====       =====  ====================
    22-Ago-06 yclavijo  SAO49717 Creacion
    *************************************************/
    FUNCTION   fnuGetOrder (
                                isbLine          in varchar2
                           )
    return number
    IS
        tbData    UT_String.TyTb_String;
        nuOrder   OR_order.order_id%type;
    BEGIN
        UT_String.ExtString(isbLine, csbSEPARATOR_1, tbData);
        nuOrder := to_number(tbData(1));
        return nuOrder;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*************************************************
    Metodo  	:   clearTempTable
    Descripcion	:   Procedimiento que limpia las tablas temporales utilizadas en el proceso
    ============  	===================

    Autor		: yclavijo
    Fecha		: 16-Jun-06

    Historia de Modificaciones
    Fecha	  Autor	Modificacion
    ===== ===== ====================
    *************************************************/
    PROCEDURE clearTempTable
    IS
    BEGIN
        DELETE or_temp_order_items;
        DELETE Or_Temp_Data_Values;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*************************************************
    Metodo  	:   valItemOk
    Descripcion	:   Procedimiento que valida si el item es consumible y si esta configurado para la
                    unidad operativa
    ============  	===================
    inuOrderId      Codigo de la Orden
    inuItemId       codigo del item

    Autor		: yclavijo
    Fecha		: 16-Jun-06

    Historia de Modificaciones
    Fecha	  Autor	Modificacion
    ===== ===== ====================
    *************************************************/
    PROCEDURE valItemOk (
                            inuOrderId     in OR_order.order_id%type,
                            inuItemId      in OR_order_items.items_id%type
                        )
    IS
        nuGetItemClassifId ge_items.Item_classif_id%type;
    BEGIN
        -- el item no es consumible
        nuGetItemClassifId := dage_items.fnuGetItem_classif_id(inuItemId);
        if (dage_item_classif.fsbGetUsed_in_legalize(nuGetItemClassifId) <> Or_BOConstants.csbSI) then
            Errors.setError(cnuCONSUMABLE,dage_items.fsbgetdescription(inuItemId));
            raise ex.CONTROLLED_ERROR;
        END if;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;


    /*************************************************
    Metodo  	:   valItemOutFlag
    Descripcion	:   Valida no nulidad y valor (Y/N) del flag
                    de instalacion/retiro de un item

    Parametros
    ============  	===================
    isbOutItemFlag  Flag de instalacion(Y) o retiro(N) para un item

    Historia de Modificaciones
    Fecha	   Autor	        Modificacion
    ========== =====            ====================
    24-08-2010 amendezSAO125755 Creacion
    *************************************************/
    PROCEDURE valItemOutFlag
    (
        inuItemId       IN or_order_items.items_id%type,
        isbOutItemFlag  IN varchar2
    )
    IS
    BEGIN
        -- Valor invalido para el flag de instalacion o retiro del item %s1
        IF isbOutItemFlag IS NULL OR isbOutItemFlag NOT IN (ge_boconstants.csbYES, ge_boconstants.csbNO) THEN
            Errors.setError(cnuERR_OUT_ITEM_FLAG,dage_items.fsbgetdescription(inuItemId));
            raise ex.CONTROLLED_ERROR;
        END if;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;


	----------------------
    -- valFileStructure --
	----------------------
    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : valFileStructure
    Descripcion	: Valida la estructura de cada linea del archivo

    Parametros          Descripcion
    ============        ===================
    Entrada:
        isbLine         Datos de la linea
        inuLineNumber   Numero de linea a procesar

    Salida:
        otbLineData     tabla temporal con lo datos de la linea

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    21-06-2013      llopezSao210199     Se modifica para obtener las fechas de
                                        ejecucion de la orden del archivo
    22-06-2012      cenaviaSAO182730    Estabilizacion. Ref SAO180912
                                        Se modifica para que valide que el tipo de
                                        comentario no sea de la clase 31 ni 32
    14-03-2012      cenaviaSAO176556    Estabilizacion.
                    cenaviaSAO175863    Se modifica la variable sbLine para que
                                        soporte lineas de maximo 4000 caracteres.
    28-Sep-2010     llopezSAO126327     Se modifica para soportar la estructura
                                        de una orden administrativa
    25-Ago-2010     amendezSAO125755    Se modifica para que reciba hasta 4 datos del
                                        item (Item o Elemento), permitiendo el campo OUT_
                                        el cual indica si los materiales estan siendo retirados (N)
                                        o si se esta instalando (Y)

    30-Nov-2009     MArteagaSAO107945   Se modifica para tener en cuenta el campo REUSED
                                        al momento de registrar los items de la orden
    24-Nov-2008     jhramirezSAO86243     Se modifica para cambiar el formato del archivo
                                        y agregarle los comentarios de orden y las validar
                                        si esta bien conforme al formato.

    23-Ago-2008     asamboni SAO80792 Creacion.
    ******************************************************************/
	PROCEDURE valFileStructure
    (
        isbLine          in varchar2,
        inuLineNumber    in number,
        otbLineData     out UT_String.TyTb_String
    ) IS
        tbDataRecord     UT_String.TyTb_String;
        tbDataRecordNull UT_String.TyTb_String;
        tbDataValue      UT_String.TyTb_String;
        tbDataValue2     UT_String.TyTb_String;
        tbDataValueNull  UT_String.TyTb_String;
        nuIndex          binary_integer;
        sbLine           stySizeLine;
        nuCOL_COMMENT    number(2);
	BEGIN
 	    ut_trace.trace('[OR_BOActivitiesLegalizeByFile.valFileStructure] INICIO',3);


	    sbLine := replace(isbLine,chr(13),'');

        -- Se valida que la cantidad de campos sea 8 o 4
        -- Orden|Causal|Persona|Actividades|Items Tipo de Elementos| Items|Lecturas|Comentario_Order|Fechas de ejecucion
        UT_String.ExtString(sbLine, csbSEPARATOR_1, otbLineData);

        if ((otbLineData.count <> cnuMAX_COLUMN) AND
            (otbLineData.count <> cnuMAX_COLUMN_EDT) AND
            (otbLineData.count <> cnuMAX_COLUMN_ADM)) then
            /* La Linea numero %s1 del archivo no tiene la estructura adecuada
            -- requerida para realizar la Legalizacion de la orden desde un archivo
            -- plano.
            */
            Errors.setError(cnuERR_UNSTRUCTURED_FILE, inuLineNumber);
            raise ex.CONTROLLED_ERROR;
        end if;

        -- Obtiene el numero maximo de columnas para ordenes NO administrativas
        gnuMAX_COLUMN := cnuMAX_COLUMN;
        if (otbLineData.count = cnuMAX_COLUMN_EDT) then
            gnuMAX_COLUMN := cnuMAX_COLUMN_EDT;
        END if;

        if (otbLineData.count = gnuMAX_COLUMN) then
            -- Se valida estructura de los datos adicionales, elemento 4 de la tabla
            if (otbLineData(cnuCOL_ADITI_DATA) is not null) then
                tbDataRecord := tbDataRecordNull;
                -- Se determina la cantidad de registros de Datos adicionales
                UT_String.ExtString(otbLineData(cnuCOL_ADITI_DATA), csbSEPARATOR_2, tbDataRecord);
                -- Por cada registro de Dato adicional debe tener solo dos
                -- campos, seperados por el signo igual (Dato= Valor)
                nuIndex := tbDataRecord.first;
                loop
                    tbDataValue := tbDataValueNull;
                    UT_String.ExtString(tbDataRecord(nuIndex), csbSEPARATOR_3, tbDataValue);
                    if (tbDataValue.count <> 2) then
                        Errors.setError(cnuERR_UNSTRUCTURED_ADD_DATA,inuLineNumber);
                        raise ex.CONTROLLED_ERROR;
                    end if;
                    exit when (nuIndex = tbDataRecord.last);
                    nuIndex := tbDataRecord.next(nuIndex);
                END loop;
            end if;


            ut_trace.trace('Datos a verificar de de actividades['||otbLineData(4)||']',4);
            -- Se valida estructura de los datos
            if (otbLineData(cnuCOL_ACTIVITY) is not null) then
                tbDataRecord := tbDataRecordNull;
                -- Se determina la cantidad de Actividades
                UT_String.ExtString(otbLineData(cnuCOL_ACTIVITY), csbSEPARATOR_4, tbDataRecord);

                nuIndex := tbDataRecord.first;
                loop
                    tbDataValue := tbDataValueNull;
                    UT_String.ExtString(tbDataRecord(nuIndex), csbSEPARATOR_2, tbDataValue);
                    ut_trace.trace('Datos a verificar['||tbDataRecord(nuIndex)||']',5);

                    -- Por cada actividad debe tener el siguiente formato
                    -- Codigo_Actividad; Atributo 1 de Actividad; Atributo 2 de Actividad; Atributo 3 de Actividad; Atributo 4 de Actividad
                    if (tbDataValue.count <> 5) then
                        Errors.setError(cnuERR_114703, inuLineNumber);
                        raise ex.CONTROLLED_ERROR;
                    end if;

                    exit when (nuIndex = tbDataRecord.last);
                    nuIndex := tbDataRecord.next(nuIndex);
                END loop;

            end if;

            ut_trace.trace('Datos a verificar['||otbLineData(6)||']',4);
            -- Se valida estructura de los datos de red,
            -- elemento 6 de la tabla
            if (otbLineData(cnuCOL_ITEM) is not null) then
                tbDataRecord := tbDataRecordNull;
                -- Se determina la cantidad de registros
                UT_String.ExtString(otbLineData(cnuCOL_ITEM), csbSEPARATOR_2, tbDataRecord);
                nuIndex := tbDataRecord.first;
                loop
                    tbDataValue := tbDataValueNull;
                    UT_String.ExtString(tbDataRecord(nuIndex), csbSEPARATOR_5, tbDataValue);
                    ut_trace.trace('Datos a verificar['||tbDataRecord(nuIndex)||']',5);

                    if tbDataValue.count not in (0,2,3,4) then
                        -- Error en la cantidad de parametros para obtener los datos del item (Item o Elemento) ITEM_ELEMENTO_%s1.
                        Errors.setError(cnuERR_114711, nuIndex);
                        raise ex.CONTROLLED_ERROR;
                    end if;

                    exit when (nuIndex = tbDataRecord.last);
                    nuIndex := tbDataRecord.next(nuIndex);
                END loop;
            END if;

            ut_trace.trace('Datos a verificar['||otbLineData(6)||']',4);
            -- por cada registro de medicion deben haber 6 campos
            -- Elemento=Meter1=Valor1=CausalLect1=CausalNoLect1=ObsLect1
            if (otbLineData(cnuCOL_READ) is not null) then
                tbDataRecord := tbDataRecordNull;
                UT_String.ExtString(otbLineData(cnuCOL_READ), csbSEPARATOR_4, tbDataRecord);
                nuIndex := tbDataRecord.first;
                loop
                    tbDataValue := tbDataValueNull;
                    UT_String.ExtString(tbDataRecord(nuIndex), csbSEPARATOR_2, tbDataValue);
                    ut_trace.trace('Datos a verificar['||tbDataRecord(nuIndex)||']',5);
                    exit when (nuIndex = tbDataRecord.last);
                    nuIndex := tbDataRecord.next(nuIndex);
                END loop;
            END if;
            nuCOL_COMMENT := cnuCOL_COMMENT;
        else
            nuCOL_COMMENT := cnuCOL_COMMENT_ADM;
        end if;

        --Se Validan la columna de comentario de la Orden, deben existir
        --el tipo de comentario y el comentario separador por ; csbSEPARATOR_2
        --jhramirez, SAO86243
        if (otbLineData(nuCOL_COMMENT) is not null) then
            tbDataRecord := tbDataRecordNull;
            ut_trace.trace('Linea Comentario:'||otbLineData(nuCOL_COMMENT),5);
            UT_String.ExtString(otbLineData(nuCOL_COMMENT), csbSEPARATOR_2, tbDataRecord);
            if (tbDataRecord.count <> 2) then
                Errors.setError(cnuERR_BADSTRUCTED_COMMENT, inuLineNumber); --El Formato de los comentarios de la orden esta erroneo.
                raise ex.CONTROLLED_ERROR;
            end if;

            --Valida que el tipo de comentario sea valido
            IF(ge_bccommenttype.fsbIsValidType(tbDataRecord(1))=or_boconstants.csbNO) THEN
                ge_boerrors.SetErrorCodeArgument(cnuERR_901262, tbDataRecord(1));
            END IF;

        END if;

        --Se valida que la columna de fechas de ejecucion de la Orden existan
        --la fecha inicial y la fecha final de ejecucion de la orden separadas
        --por ; csbSEPARATOR_2
        gdtInitialDate := null;
        gdtFinalDate := null;
        if (otbLineData.exists(cnuCOL_EXCDATES) AND otbLineData(cnuCOL_EXCDATES) is not null) then
            tbDataRecord := tbDataRecordNull;
            ut_trace.trace('Linea Fechas :'||otbLineData(cnuCOL_EXCDATES),5);
            UT_String.ExtString(otbLineData(cnuCOL_EXCDATES), csbSEPARATOR_2, tbDataRecord);
            if ((tbDataRecord.count <> 2) OR
                (tbDataRecord(1) IS null) OR
                (tbDataRecord(2) IS null)) then
                --La Linea numero %s1 del archivo no tiene la estructura correcta para las fechas de ejecucion de la Orden.
                Errors.setError(cnuERR_BADSTRUCTED_EXEC_DATES, inuLineNumber);
                raise ex.CONTROLLED_ERROR;
            end if;

            -- Obtiene las fechas de ejecucion de la orden
            BEGIN
                gdtInitialDate := ut_date.fdtDateWithFormat(tbDataRecord(1));
                gdtFinalDate := ut_date.fdtDateWithFormat(tbDataRecord(2));
            EXCEPTION
                when others then
                    ge_boerrors.SetErrorCodeArgument(cnuERR_FORMATDATE, '['||ut_date.fsbDATE_FORMAT||']');
            END;
        END if;

 	    ut_trace.trace('[OR_BOActivitiesLegalizeByFile.valFileStructure] FIN',3);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END valFileStructure;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : LoadAndValidInitialData
    Descripcion	: Valida y carga los datos iniciales

    Parametros          Descripcion
    ============        ===================
    Entrada:
        isbLine         Datos de la linea
        inuLineNumber   Numero de linea a procesar

    Salida:
        onuOrderId      Order
        onuCausal       Causal
        onuPerson       Persona
        otbLine         Tabla Temporar con  los datos de la linea
        onuErrorCode    Codigo de error
        osbErrorMessage Mensaje de error

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    25-01-2013  yclavijo.SAO200482      Si no vienen actividades a legalizar se eleva el error:
                                        Debe Existir al menos una Actividad asociada a la orden
    26-10-2012  cenaviaSAO194932        Se modifica el mensaje de error que aparece
                                        Cuando la cantidad a legalizar no es numerica
                                        o es nula.
    23-07-2012  cenaviaSAO186451        Se publica el metodo
    09-04-2012      cenaviaSAO179538    Estabilizacion.
                    cenaviaSAO179389    Se modifica para eliminar la traza donde
                                        estaba realizando el llamado a una tabla
    14-03-2012      cenaviaSAO176556    Estabilizacion.
                    cenaviaSAO175673    Se modifica para que valide:
                                        - Si la cantidad a legalizar es -1 se verifica
                                          si la actividad es anulable.
                                        - Si la cantidad a legalizar es mayor a 1
                                          se valida si la actividad permite legalizacion
                                          multipe
                                        - Valida que exista al menos una actividad
                                          con  la cantidad a legalizar mayor a cero
    28-Sep-2010     llopezSAO126327     Se modifica para que no obtenga el
                                        identificador de la persona si es un
                                        registro de orden administrativa
    23-Ago-2008     asamboni SAO80792 Creacion.
    ******************************************************************/
    PROCEDURE LoadAndValidInitialData
    (
        isbLine          in varchar2,
        inuLineNumber    in number,
        onuOrderId      out OR_order.order_id%type,
        onuCausal       out OR_order.causal_id%type,
        onuPerson       out ge_person.person_id%type,
        otbLine         out nocopy UT_String.TyTb_String,
        onuErrorCode    out ge_error_log.error_log_id%type,
        osbErrorMessage out ge_error_log.description%type
    )
    IS

        rcOrder             DaOr_Order.styOr_Order;
        tbCausal            DAGe_Causal.tytbCausal_Id;
        nuIndex             binary_integer;
        nuValCausal         number := 1;
        rcTempLegOrder      DaOr_Temp_Order_To_Leg.styOR_temp_order_to_leg;
        nuActivityId        or_actividad.id_actividad%type;
        nuTotalActivities   OR_ORDER_ACTIVITY.order_activity_id%TYPE;
        tbDataRecord        UT_String.TyTb_String;
        tbActivityData      UT_String.TyTb_String;
        tbItemData          UT_String.TyTb_String;
        nuIndexActivData    binary_integer;
        nuLegaActivity      OR_order_items.legal_item_amount%type;
        nuOrderActivityId   or_order_activity.order_activity_id%type;
        blExistActToLeg     boolean := FALSE;


        PROCEDURE ValidInitialData IS
        BEGIN
            -- Se valida y se setean los valores de salida
            if (otbLine.count = 0) then
                Errors.setError(cnuERR_114704, inuLineNumber);
                raise ex.CONTROLLED_ERROR;
            END if;

            if (onuOrderId  IS null) then
                Errors.setError(cnuERR_850, inuLineNumber);
                raise ex.CONTROLLED_ERROR;
            END if;

            if (onuCausal  IS null) then
                Errors.setError(cnuERR_114705, inuLineNumber);
                raise ex.CONTROLLED_ERROR;
            END if;

            if ((otbLine.count = gnuMAX_COLUMN) AND (onuPerson IS null)) then
                Errors.setError(cnuERR_112063, inuLineNumber);
                raise ex.CONTROLLED_ERROR;
            END if;

        EXCEPTION
            when ex.CONTROLLED_ERROR then
                raise ex.CONTROLLED_ERROR;
            when others then
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
        END ValidInitialData;

        PROCEDURE ValidCausal IS
        BEGIN
            -- Se valida la causal. Si la causal dada no se encuentra entre las validas se eleva error
            tbCausal:= Or_BOLegalizeOrder.ftbGetValidCausalByOrderLeg(onuOrderId);
            nuIndex := tbCausal.first;
            while nuIndex <= tbCausal.last loop
                if otbLine(2) = tbCausal(nuIndex) then
                   nuValCausal := 0;
                END if;
                nuIndex := tbCausal.next(nuIndex);
            END loop;

            if nuValCausal <> 0 then
                Errors.setError(cnuNOTAVALIDCAUSAL);
                raise ex.CONTROLLED_ERROR;
            END if;

        EXCEPTION
            when ex.CONTROLLED_ERROR then
                raise ex.CONTROLLED_ERROR;
            when others then
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
        END ValidCausal;

    BEGIN
        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.LoadAndValidInitialData] INICIO',4);
        -- Valida que la estructura de la linea este correcta
        ValFileStructure(isbLine,inuLineNumber,otbLine);

        -- Se valida y se setean los valores de salida
        onuOrderId := otbLine(cnuCOL_ORDER);
        onuCausal  := otbLine(cnuCOL_CAUSAL);

        -- Se determina la cantidad de Actividades
        UT_String.ExtString(otbLine(cnuCOL_ACTIVITY), csbSEPARATOR_4, tbDataRecord);
        nuTotalActivities := tbDataRecord.count;

        ut_trace.trace('Total de actividades['||tbDataRecord.count||']',5);

        if (nuTotalActivities = 0) then
            ge_boerrors.SetErrorCode(119000);
        end if;

        -- Se obtiene cada una de las actividades
        nuIndexActivData := tbDataRecord.first;
        loop
            UT_String.ExtString(tbDataRecord(nuIndexActivData), csbSEPARATOR_2, tbActivityData);

            if (tbActivityData(1) IS NOT NULL) THEN
                UT_String.ExtString(tbActivityData(1), csbSEPARATOR_5, tbItemData);

                -- Identificador de la actividad de la orden
                nuOrderActivityId := to_number(tbItemData(1));

                ut_trace.trace('nuOrderActivityId['||nuOrderActivityId||']',5);

                -- Identificador de la actividad
                nuActivityId := daor_order_activity.fnuGetActivity_id(nuOrderActivityId);

                ut_trace.trace('nuActivityId['||nuActivityId||']',5);

                -- Valida que el valor de la cantidad a legalizar sea un numero y que no sea Nulo
                if (UT_Convert.IS_NUMBER(tbItemData(2)) AND tbItemData(2) IS NOT NULL) then
                    -- Cantidad a legalizar
                    nuLegaActivity := to_number(tbItemData(2));
                else
                    ge_boerrors.SetErrorCodeArgument(cnuERR_900907, nuActivityId);
                END IF;

                ut_trace.trace('nuLegaActivity['||nuLegaActivity||']',5);

                -- Se valida si que exista al menos una actividad para legalizar
                IF (nuLegaActivity >=0) THEN
                    blExistActToLeg := TRUE;
                END IF;

                or_bolegalizeorder.GetIsValToLegal(nuActivityId, nuLegaActivity);

            END IF;

            exit when (nuIndexActivData = tbDataRecord.last);
            nuIndexActivData := tbDataRecord.next(nuIndexActivData);
        END loop;

        IF (not blExistActToLeg)THEN
            ut_trace.trace('No se pueden anular todas las actividades de la orden ',5);
            ge_boerrors.SetErrorCode(cnuERR_10861);
        END IF;


        if (otbLine.count = gnuMAX_COLUMN) then
            onuPerson  := otbLine(cnuCOL_PERSON);
        end if;
        --ut_trace.Trace('Datos iniciales onuCausal:['|| onuCausal ||'] onuPerson:['|| onuPerson ||']',3);

        -- Valida los datos iniciales
        ValidInitialData;

        -- se valida la si la causal es valida para el proceso
        ValidCausal;

        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.LoadAndValidInitialData] FIN',4);
    EXCEPTION
		when ex.CONTROLLED_ERROR then
			Errors.getError(onuErrorCode, osbErrorMessage);
		when others then
			Errors.setError;
			Errors.getError(onuErrorCode, osbErrorMessage);
    END LoadAndValidInitialData;

    /*****************************************************************
    Unidad      : LockOrder
    Descripcion	: LockOrder, bloquea la Orden.

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    17-Oct-2008    jhramirezSAO83697    Creacion.
    ******************************************************************/
    PROCEDURE LockOrder
    (
        inuOrder_id in OR_order.Order_id%type,
        onuErrorCode    out number,
        osbErrorMessage out ge_message.description%type
    )
    IS
    BEGIN
        or_bofwlegalizeorderutil.LockOrder(inuOrder_id);
    EXCEPTION
		when ex.CONTROLLED_ERROR then
			Errors.getError(onuErrorCode, osbErrorMessage);
		when others then
			Errors.setError;
			Errors.getError(onuErrorCode, osbErrorMessage);
    END;


    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : InstanceAttribsActivity
    Descripcion	: Instancia los atributos de la actividad

    Parametros          Descripcion
    ============        ===================
    Entrada:
        inuOrderId          Identificador de oren
        inuOrderActivityId  Actividad

    Salida:

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    23-Ago-2008     asamboni SAO80792 Creacion.
    ******************************************************************/
    PROCEDURE InstanceAttribsActivity
    (
        inuOrderId        in  Or_Order.Order_Id%type,
        inuOrderActivityId  in  or_order_activity.order_activity_id%type
    )
    IS
        CURSOR cuTempItemId
        (
            nuOrderId or_order.order_id%type,
            nuOrderActivityId  or_order_activity.order_activity_id%type
        ) IS
            SELECT or_temp_order_items.*
            FROM or_temp_order_items, or_order_activity
            WHERE or_temp_order_items.order_id = nuOrderId
              AND or_order_activity.order_activity_id = nuOrderActivityId
              AND or_temp_order_items.temp_order_items_id = or_order_activity.order_item_id;

        curfGetData        Constants.tyRefCursor;

    BEGIN
        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.InstanceAttribsActivity] INICIO',3);


        -- Instancia los atributos de la actividad
        for rcActivityItems in  cuTempItemId (inuOrderId, inuOrderActivityId)
        loop
            ut_trace.Trace('Item:['|| rcActivityItems.items_id ||'] Actividad:['|| inuOrderActivityId ||']',3);
            -- Carga los datos de la actividad

            or_bolegalizeactivities.setAttribsActivity
                 (rcActivityItems.temp_order_items_id,
                  rcActivityItems.items_id,
                  inuOrderActivityId,
                  curfGetData
                 );

        END loop;

        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.InstanceAttribsActivity] FIN',3);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END InstanceAttribsActivity;

--------------------------------------------------------------------------------
--  INICIO de carga de actividades
--------------------------------------------------------------------------------
    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : UtilitiesComponent
    Descripcion	: Instancia los datos del componente   UtilitiesComponent  4

    Parametros          Descripcion
    ============        ===================
    Entrada:
        inuOrderId          Identificador de oren
        isbAttribute        Atributo
        inuOrderActivityId  Indetificador de la actividad
        isbComponentData    datos del componente
        inuAttibuteIndex    indice del atributo
        inuIndex            Numero de registro
    Salida:

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    07-05-2012      cenaviaSAO159297    Se elimina el llamado al metodo
                                        Or_BoInstanceActivities.setComponentAttribValue
    22-Oct-2008     jhramirezSAO83697   Se modifica para llenar la tabla iotbElemProduct que contiene los
                                        productos dado un elementos Asignable.

    11-Sep-2008     asamboniSAO81933  Se obtiene la ubicacion del elemetno
                                      este campo solo aplica para las reglas de
                                      legalizaci{on que lo requierean
    23-Ago-2008     asamboniSAO80792 Creacion.
    ******************************************************************/
    PROCEDURE UtilitiesComponent
    (
        inuOrderId         in or_order.order_id%type,
        isbAttribute       in  ge_attributes.name_attribute%type,
        inuOrderActivityId in or_order_activity.order_activity_id%type,
        isbComponentData   in varchar2,
        inuAttibuteIndex   in number,
        inuComponentId     in  number,
        iotbElemProduct   in out tytbElementProductId
    )
    IS
        sbValue             varchar2(1000);
        tbDataRecord        UT_String.TyTb_String;
        tbDataRecordNull    UT_String.TyTb_String;
        tbDataValue         UT_String.TyTb_String;
        tbDataValueNull     UT_String.TyTb_String;
        nuRecordId          number := 0;
        nuElementId         number;
        sbElementAction     ge_items.use_%type;
        nuIndex             binary_integer;
        sbAction            varchar2(10);
        nuLocation          number;
    BEGIN
        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.UtilitiesComponent] INICIO',3);

        ut_trace.Trace('[OR_BOActivitiesLegalizeByFile.UtilitiesComponent] Entrada: ['|| isbComponentData ||']',5);
        if isbComponentData IS not null then
            ut_trace.Trace('[Instancia] inuOrderActivityId: ['|| inuOrderActivityId ||'] inuComponentId:['||inuComponentId||'] inuAttibuteIndex:['||inuAttibuteIndex||']',5);

            tbDataRecord := tbDataRecordNull;
            -- Se determina la cantidad de Actividades
            -- [elemento=accion=ubicacion!elemento=accion=ubicacion!elemento=accion=ubicacion]
            UT_String.ExtString(isbComponentData, csbSEPARATOR_6, tbDataRecord);
            if tbDataRecord.count > 0 then
                nuIndex := tbDataRecord.first;
                loop

                    tbDataValue := tbDataValueNull;
                    --  [elemento=accion=ubicacion]
                    UT_String.ExtString(tbDataRecord(nuIndex), csbSEPARATOR_3, tbDataValue);
                    ut_trace.Trace(' [OR_BOActivitiesLegalizeByFile.UtilitiesComponent] Atributo ['|| tbDataRecord(nuIndex) ||']',6);

                    if tbDataValue.count not in (2,3) then
                        -- Error en el numero de parametros en los datos del atributo %s1 de la actividad %s2.
                        Errors.setError(cnuERR_114723,inuAttibuteIndex||'|'||inuOrderActivityId);
                        raise ex.CONTROLLED_ERROR;
                    END if;

                    -- Obtiene datos para el poroceso
                    nuELementId     :=  ut_convert.fnuChartoNumber(tbDataValue(1)); --  identificador del elemento
                    sbElementAction :=  tbDataValue(2);     -- valor del registro

                    --Se llena tabla de Elementos X Productos.
                    sbValue         := daif_assignable.fsbGetCode(nuELementId);
                    iotbElemProduct(sbValue).nuProduct_Id    := daor_order_activity.fnuGetProduct_id(inuOrderActivityId);

                    if tbDataValue.exists(3)  then
                        nuLocation := tbDataValue(3);
                    END if;

                    ut_trace.Trace('[OR_BOActivitiesLegalizeByFile.UtilitiesComponent] nuELementId:['|| nuELementId ||'] sbElementAction:['|| sbElementAction ||']',6);


                    -- Obtiene el identificador del elemento
                    if  if_boelement.fsbGetDataElement(nuElementId) IS null then
                        -- El elemento no existe para la orden %2 actividad  %s3
                        errors.SetError(cnuERR_114719, nuElementId||'|'||inuOrderId||'|'||inuOrderActivityId);
                        raise ex.CONTROLLED_ERROR;
                    END if;

                    exit when (nuIndex = tbDataRecord.last);
                    nuIndex := tbDataRecord.next(nuIndex);
                END loop;
            END if;
        END if;


        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.UtilitiesComponent] FIN',3);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Unidad      : UtilitiesComponentPower
    Descripcion	: Instancia los datos del componente  UtilitiesComponent 7

    Parametros          Descripcion
    ============        ===================
    Entrada:
        inuOrderId          Identificador de orden.
        isbAttribute        Atributo.
        inuOrderActivityId  Indetificador de la actividad.
        isbComponentData    datos del componente.
        inuAttibuteIndex    indice del atributo.
        inuIndex            Numero de registro.
    Salida:

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-Oct-2008     jhramirezSAO83697  Creacion.
    ******************************************************************/
    PROCEDURE UtilitiesComponentPower
    (
        inuOrderId         in   or_order.order_id%type,
        isbAttribute       in   ge_attributes.name_attribute%type,
        inuOrderActivityId in   or_order_activity.order_activity_id%type,
        isbComponentData   in   varchar2,
        inuAttibuteIndex   in   number,
        inuComponentId     in   number,
        isbValue           in   varchar2

    )
    IS
        tbDataRecord        UT_String.TyTb_String;
        tbDataRecordNull    UT_String.TyTb_String;
        tbDataValue         UT_String.TyTb_String;
        tbDataValueNull     UT_String.TyTb_String;
        nuValorAtributo     number;

        type tyrcRoutePower  IS RECORD
        (
            nuCircuit           number, --Circuito.
            nuDistPoste         number, --Distancia al Poste.
            nuCapContr          number, --Capacidad Contratada.
            nuMaxDeman          number
        );

        --type tytbRoutePower IS table  of tyrcRoutePower index BY binary_integer;

        rcRoutePower        tyrcRoutePower;

    BEGIN
        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.UtilitiesComponentRuote] INICIO',3);
        ut_trace.trace('[FORMATO] ELEMENTO_COMPONENTE_N [atributo=valor!atributo=valor!atributo=valor]',3);

        ut_trace.Trace('[OR_BOActivitiesLegalizeByFile.UtilitiesComponent] Entrada: ['|| isbComponentData ||']',5);
        if isbComponentData IS not null then
            ut_trace.Trace('[Instancia] inuOrderActivityId: ['|| inuOrderActivityId ||'] inuComponentId:['||inuComponentId||'] inuAttibuteIndex:['||inuAttibuteIndex||']',5);

            tbDataRecord := tbDataRecordNull;
            -- Se determina la cantidad de Actividades.
            -- [atributo=valor!atributo=valor!atributo=valor]
            UT_String.ExtString(isbComponentData, csbSEPARATOR_6, tbDataRecord);
            ut_trace.Trace('[OR_BOActivitiesLegalizeByFile.UtilitiesComponentRuote] Numero Atributos:'||tbDataRecord.count,5);
            if tbDataRecord.count > 0 then

                UT_String.ExtString(tbDataRecord(1), csbSEPARATOR_3, tbDataValue);
                rcRoutePower.nuCircuit    := ut_convert.fnuChartoNumber(tbDataValue(2));
                tbDataValue                 := tbDataValueNull;

                UT_String.ExtString(tbDataRecord(2), csbSEPARATOR_3, tbDataValue);
                rcRoutePower.nuDistPoste  := ut_convert.fnuChartoNumber(tbDataValue(2));
                tbDataValue                 := tbDataValueNull;

                UT_String.ExtString(tbDataRecord(3), csbSEPARATOR_3, tbDataValue);
                rcRoutePower.nuCapContr   := ut_convert.fnuChartoNumber(tbDataValue(2));
                tbDataValue                 := tbDataValueNull;

                UT_String.ExtString(tbDataRecord(4), csbSEPARATOR_3, tbDataValue);
                rcRoutePower.nuMaxDeman   := ut_convert.fnuChartoNumber(tbDataValue(2));
                tbDataValue                 := tbDataValueNull;

                nuValorAtributo             := ut_convert.fnuChartoNumber(isbValue);

                ut_trace.Trace('(nuDistPoste,nuCapContr,nuMaxDeman,nuCircuit): ( '||rcRoutePower.nuDistPoste||','|| rcRoutePower.nuCapContr||','||rcRoutePower.nuMaxDeman||','||rcRoutePower.nuCircuit||','||nuValorAtributo||')',5);

                --Instancia los Atributos.
                or_boinstanceactivities.instanceInspectData(
                                                             inuOrderActivityId,
                                                             rcRoutePower.nuDistPoste,    --inuPoleDistance,
                                                             rcRoutePower.nuCapContr,     --inuCapacity,
                                                             rcRoutePower.nuMaxDeman,     --inuMaxDemand,
                                                             rcRoutePower.nuCircuit,      --inuCircuit,
                                                             nuValorAtributo);
            END if;
        END if;

        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.UtilitiesComponent] FIN',3);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END UtilitiesComponentPower;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  regRubbishLoad
    Descripcion :  Registra la produccion de Aseo

    Autor       :  yclavijo
    Fecha       :  26-07-2012
    Parametros  :


    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    11-10-2012   GPaz.SAO193906     Se corrige error de bloqueo por loop infinito
    11-10-2012   MArteaga.SAO193835 Se corrige error al obtener el tipo de producto
    26-07-2012   yclavijo.SAO184604    Creacion
    ******************************************************************/
    PROCEDURE regRubbishLoad(
                                inuOrderId         in OR_order.order_id%type,
                                isbAttribute       in ge_attributes.name_attribute%type,
                                inuOrderActivityId in or_order_activity.order_activity_id%type,
                                isbComponentData   in varchar2,
                                inuAttibuteIndex   in number,
                                inuComponentId     in number,
                                isbValue           in varchar2
                            )
    IS
        cnuERROR_6765       constant number(4) := 6765;
        tbDataRecord        ut_string.TyTb_String;
        nuIndexComponent    number;
        tbDataValue         ut_string.TyTb_String;
        nuApplianceId       or_activ_appliance.appliance_id%type;
        nuAmount            or_activ_appliance.amount%type;
        nuProductId         or_order_activity.product_id%type;
        nuValue             detaprod.deprprod%type;
        cnuError_901417     constant number(6) := 901417;
        cnuError_901418     constant number(6) := 901418;
    BEGIN
        ut_trace.trace('INICIO OR_BOActivitiesLegalizeByFile.regRubbishLoad', 5);
        ut_trace.trace('inuOrderId:'||inuOrderId, 10);
        ut_trace.trace('isbAttribute:'||isbAttribute, 10);
        ut_trace.trace('inuOrderActivityId:'||inuOrderActivityId, 10);
        ut_trace.trace('isbComponentData:'||isbComponentData, 10);
        ut_trace.trace('inuAttibuteIndex:'||inuAttibuteIndex, 10);
        ut_trace.trace('inuComponentId:'||inuComponentId, 10);
        ut_trace.trace('isbValue:'||isbValue, 10);

        /* Obtiene los valores del componente */
        UT_String.ExtString(isbComponentData, csbSEPARATOR_6, tbDataRecord);
        if tbDataRecord.count > 0 then
            nuIndexComponent := tbDataRecord.first;
            while(nuIndexComponent IS not null) loop
                tbDataValue.delete;
                /* Obtiene los datos del componente appliance_id_1=amount_1!appliance_id_N=amount_N */
                UT_String.ExtString(tbDataRecord(nuIndexComponent), csbSEPARATOR_3, tbDataValue);
                /* Valida que se envien los dos valores*/
                if (tbDataValue.count != 2) then
                    -- Error en el numero de parametros en los datos del atributo %s1 de la actividad %s2.
                    Errors.setError(cnuERR_114723,inuAttibuteIndex||'|'||inuOrderActivityId);
                    raise ex.CONTROLLED_ERROR;
                END if;

                nuApplianceId := to_number(tbDataValue(1));
                nuAmount      := to_number(tbDataValue(2));
                /* Valida que el registro en ge_appliance exista */
                dage_appliance.AccKey(nuApplianceId);
                /* Valida que el appliance_id sea para el mismo tipo de producto de la orden */
                nuProductId := daor_order_activity.fnuGetProduct_Id(inuOrderActivityId);
                if (dage_appliance.fnuGetProduct_Type_Id(nuApplianceId) != dapr_product.fnuGetProduct_Type_Id(nuProductId)) then
                    Errors.SetError (cnuError_901417,nuApplianceId||ge_boconstants.csbSEPARADOR||dage_appliance.fsbGetDescription(nuApplianceId));
                    raise ex.CONTROLLED_ERROR;
                end if;
                /* Valida que la cantidad no sea nula */
                if (nuAmount IS null) then
                    Errors.setError(cnuERROR_6765);
                    raise ex.CONTROLLED_ERROR;
                end if;

                /* Registra la produccion */
                OR_BOReview.LoadAppliance(nuApplianceId,nuAmount,inuOrderActivityId);

                nuIndexComponent := tbDataRecord.next(nuIndexComponent);
            end loop;

            /* Calcula la produccion total */
            nuValue := OR_BOReview.fnuGetTotalLoad(inuOrderActivityId);
            ut_trace.trace('nuValue:'||nuValue, 10);

            /* Si se envio un valor para la produccion valida que sea igual al calculo de los detalles */
            if (to_number(isbValue) != nuValue) then
                Errors.SetError (cnuError_901418);
                raise ex.CONTROLLED_ERROR;
            end if;

            /* Sube a instancia el calculo */
            or_bolegalizeactivities.setAttributeNewValue(inuOrderId,inuOrderActivityId,isbAttribute,nuValue);
        end if;

        ut_trace.trace('FIN OR_BOActivitiesLegalizeByFile.regRubbishLoad', 5);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END regRubbishLoad;


    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : updComponentData
    Descripcion	: Actuali los datos de los componentes
                  Formato:
    --  COMPONENTE [ATRIBUTOS_COMPONENTE_1>ATRIBUTOS_COMPONENTE_2>ATRIBUTOS_COMPONENTE_N]<br>
    Parametros          Descripcion
    ============        ===================
    Entrada:
        inuOrderId          Identificador de oren
        isbAttribute        Atributo
        inuComponentId      Identificador del componente
        inuOrderActivityId  Identificador de la actividad
        isbCompnentData     Datos del componente
        inuAttibuteIndex    Posicion del atributo 1,2,3 y 4

        isbValue            Valor de Atributo.
        iotbElemProduct     Tabla que contiene los productos dado el CODE del Elemento Asignable. iotbElemProduct(CodeElmento).nuProduct_id

    Salida:

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    26-07-2012      yclavijo.SAO184604  Se adiciona el manejo de procesamiento del componente 17
    09-02-2012      gpaz.SAO173805      Se elimina el componente de rutas
    23-Oct-2008     jhramirezSAO82178   Se modifica para adicionarle la validacion  de
                                        OR_boconstants.cnuElemTskTypeComponent al inicio del procedimiento.

    22-Oct-2008     jhramirezSAO83697   Se modifica para adicionarle 2 parametros isbValue, iotbElemProduct
                                        Se Adiciona el procesamiento para los componentes 6 y 7, utilizando
                                        UtilitiesComponentRuote, y UtilitiesComponentPower para procesarlos.

    11-Sep-2008     asamboni SAO81933 Se adiciona el componente 10
                    para procesar los datos.
    23-Ago-2008     asamboni SAO80792 Creacion.
    ******************************************************************/
    PROCEDURE updComponentData
    (
        inuOrderId          in or_order.order_id%type,
        isbAttribute        in ge_attributes.name_attribute%type,
        inuComponentId      in number,
        inuOrderActivityId  in or_order_activity.order_activity_id%type,
        isbCompnentData     in varchar2,
        inuAttibuteIndex    in number,
        isbValue            in varchar2,
        iotbElemProduct     in out tytbElementProductId
    )
    IS
        sbAttribute         ge_attributes.name_attribute%type;
        tbDataValue         UT_String.TyTb_String;
        nuRecordId          number := 0;
        tbDataRecord        UT_String.TyTb_String;
        tbDataRecordNull    UT_String.TyTb_String;

    BEGIN
        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.updComponentData] INICIO',3);
        ut_trace.trace('[] COMPONENTE [ATRIBUTOS_COMPONENTE_1>ATRIBUTOS_COMPONENTE_2>ATRIBUTOS_COMPONENTE_N]['||
                isbCompnentData ||']',5);

        if inuComponentId  not in
                (
                    OR_boconstants.cnuAsocOfSeal,    --4
                    or_boconstants.cnuPowerInspecComponent, --7
                    or_boconstants.cnuAppliance -- 17

                )then
            --  El identificador [%s1] del componente no es valido para el atributo %s2 y la actividad [%s3].
            Errors.setError(cnuERR_114724,inuComponentId||'|'||isbAttribute||'|'||inuOrderActivityId);
            raise ex.CONTROLLED_ERROR;
        END if;


        ut_trace.Trace('[Componente]:'||inuComponentId,4);
        -- componente 4
        if (inuComponentId = OR_boconstants.cnuAsocOfSeal) then
            OR_BOActivitiesLegalizeByFile.AssociateSealComp
                        (
                            inuOrderId,
                            isbAttribute,
                            inuOrderActivityId,
                            isbCompnentData,
                            inuAttibuteIndex,
                            inuComponentId,
                            isbValue
                        );
        elsif (inuComponentId = OR_boconstants.cnuAppliance) then -- Registro de produccion
            regRubbishLoad(inuOrderId,isbAttribute, inuOrderActivityId, isbCompnentData,
                           inuAttibuteIndex,inuComponentId,isbValue);
        END if;

        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.updComponentData] FIN',3);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;


    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : updAttributeActivity
    Descripcion	: Procesa los atributos de la actividad
                  Formato:
                  ATRIBUTO_N:      [atributo:valor:COMPONENTE]
        NOTA: Si hay datos del compnente el campo valor indica el identificador del componente

    Parametros          Descripcion
    ============        ===================
    Entrada:
        inuOrderId          Identificador de oren
        inuOrderActivityId  Actividad
        isbAttribuesData    Datos del atribto N de la actividad
        inuIndex            Posiscion

    Salida:

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    17-10-2012      cenaviaSAO194244    Se modifica para que si el atributo es
                                        DISSOCIATE_SEAL setee el valor del atributo
                                        en la tabla de errores para que si no esta
                                        asociado genere fraude, no mensaje de error
    12-oct-2011     AEcheverrySAO163123 Se adiciona parametro nuActivity y la
                                        ejecutacion de las reglas de validacion
                                        de los atributos de una actividad.
                                        Si el valor ingresado es nulo pero se tiene
                                        regla de inicializacion se obtiene el valor
                                        con el que se inicializa
    06-Oct-2009     DMunoz SAO103005    Se modifica para validar que el indice a
                                        utilizar en tabla de elementos no sea nulo.
    23-Ago-2008     asamboni SAO80792   Creacion.
    ******************************************************************/
    PROCEDURE updAttributeActivity
    (
        inuOrderId          in  Or_Order.Order_Id%type,
        inuOrderActivityId  in  or_order_activity.order_activity_id%type,
        inuActivityId       in  or_order_activity.activity_id%type,
        isbAttribuesData    in  Varchar2,
        inuAttibuteIndex    in  integer,
        iotbElemProduct     in  out tytbElementProductId
    )
    IS
        sbAttribute         ge_attributes.name_attribute%type;
        sbValue             varchar2(1000);
        sbComponente        varchar2(4000);
        tbDataValue         UT_String.TyTb_String;
        nuComponentId       number;
        nuInitExpression   ge_items_attributes.init_expression_1_id%type;
        nuValidExpression   ge_items_attributes.valid_expression_1_id%type;
        sbRequired          ge_items_attributes.required1%type := or_boconstants.csbNO;
        sbDisplayname       ge_attributes.display_name%type;

    BEGIN
        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.updAttributeActivity] INICIO',3);
        ut_trace.trace('[FORMATO] ATRIBUTO_N [atributo:valor:idcomponente:COMPONENTES]',3);

        ut_trace.Trace('[*****] isbAttribuesData ['|| isbAttribuesData ||']',0);

        if isbAttribuesData IS not null then
            UT_String.ExtString(isbAttribuesData, csbSEPARATOR_5, tbDataValue);

        ut_trace.Trace('[*****] : Numero de datos del atributo ['|| tbDataValue.count ||']',0);

            if tbDataValue.count != 0 then
                if tbDataValue.count != 4 then
                    -- Error en el numero de parametros en los datos del atributo %s1 de la actividad %s2.
                    Errors.setError(cnuERR_114706,inuAttibuteIndex||'|'||inuOrderActivityId);
                    raise ex.CONTROLLED_ERROR;
                END if;
                sbAttribute     := tbDataValue(1);
                sbValue         := tbDataValue(2);
                nuComponentId   := tbDataValue(3);
                sbComponente    := tbDataValue(4);

                IF sbValue IS NOT NULL THEN
                    IF length(sbValue) <= 50 then
                        iotbElemProduct(sbValue).nuProduct_Id    := daor_order_activity.fnuGetProduct_id(inuOrderActivityId);
                    END IF;
                END IF;

                ut_trace.Trace('Instancia Atributo: inuOrderId:['|| inuOrderId ||'] inuOrderActivityId:['|| inuOrderActivityId ||']',6);
                ut_trace.Trace('sbAttribute['||sbAttribute||'] sbValue:['||sbValue||']',6);
                if sbAttribute IS not null then
                    -- si no hay nada en memoria
                    if gtbActivitiesAttribConf.count <= 0 then
                        or_bcorderactivities.GetConfigAttribs(gtbActivitiesAttribConf);
                    END if;

                    -- se valida la configuracion para el atributo que se esta procesando
                    if (gtbActivitiesAttribConf.exists(inuActivityId)) then

                        if (inuAttibuteIndex = 1) then
                            nuInitExpression := gtbActivitiesAttribConf(inuActivityId).nuInitExpression1;
                            nuValidExpression := gtbActivitiesAttribConf(inuActivityId).nuValidExpression1;
                            sbRequired := gtbActivitiesAttribConf(inuActivityId).sbRequired1;
                            sbDisplayname :=   gtbActivitiesAttribConf(inuActivityId).sbDisplayName1;

                        elsif (inuAttibuteIndex = 2) then
                            nuInitExpression := gtbActivitiesAttribConf(inuActivityId).nuInitExpression2;
                            nuValidExpression := gtbActivitiesAttribConf(inuActivityId).nuValidExpression2;
                            sbRequired := gtbActivitiesAttribConf(inuActivityId).sbRequired2;
                            sbDisplayname :=   gtbActivitiesAttribConf(inuActivityId).sbDisplayName2;

                        elsif (inuAttibuteIndex = 3) then
                            nuInitExpression := gtbActivitiesAttribConf(inuActivityId).nuInitExpression3;
                            nuValidExpression := gtbActivitiesAttribConf(inuActivityId).nuValidExpression3;
                            sbRequired := gtbActivitiesAttribConf(inuActivityId).sbRequired3;
                            sbDisplayname :=   gtbActivitiesAttribConf(inuActivityId).sbDisplayName3;

                        else
                            nuInitExpression := gtbActivitiesAttribConf(inuActivityId).nuInitExpression4;
                            nuValidExpression := gtbActivitiesAttribConf(inuActivityId).nuValidExpression4;
                            sbRequired := gtbActivitiesAttribConf(inuActivityId).sbRequired4;
                            sbDisplayname := gtbActivitiesAttribConf(inuActivityId).sbDisplayName4;
                        END if;

                        -- Se obtiene el valor inicializado del atributo
                        if ((nuInitExpression IS not null) AND (sbValue IS null)) then
                            sbValue := or_boinstanceactivities.fsbGetAttributeValue(sbAttribute,inuOrderActivityId);
                        END if;

                        -- ejecutar regla de validacion para el atributo
                        or_bolegalizeactivities.execValExpression(inuOrderId,inuOrderActivityId,nuValidExpression,sbAttribute,sbValue);

                        -- se valida si el atributo es requerido
                        if (sbValue IS null AND sbRequired = or_boconstants.csbSI) then
                            ge_boerrors.SetErrorCodeArgument(cnuREQUIRED_ATTRIB,sbDisplayname);
                        END if;

                    END if;

                    -- actualiza el atributo en la instancia
                    or_bolegalizeactivities.setAttributeNewValue
                         (inuOrderId,
                          inuOrderActivityId,
                          sbAttribute,
                          sbValue
                         );

                    -- Se setea la serie en la tabla de errores para que en caso
                    -- que el sello a desasociar no este asociado genere fraude,
                    -- no error
                    IF(sbAttribute = ge_bcattributes.csbDissociateSeal) THEN
                        tbSerialError(sbValue).SealSerie := sbValue;
                    END IF;
                END if;
                -- carga los atribitos del componente en la instancia
                -- COMPONENTES [COMPONENTE_1>COMPONENTE_2>COMPONENTE_N]<br>
                if sbComponente IS not null then
                    updComponentData (inuOrderId, sbAttribute,nuComponentId,inuOrderActivityId,sbComponente, inuAttibuteIndex, sbValue, iotbElemProduct);
                END if;

            END if;
        END if;

        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.updAttributeActivity] FIN',3);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END updAttributeActivity;



    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : procActividadApoyo
    Descripcion	: Procesa y crea los actividades de apoyo registradas
    Parametros          Descripcion
    ============        ===================
    Entrada:
        inuOrderId          Identificador de oren
        inuOperUnitId       Unidad OPerativa
        inuOrderActivityId  Actividad
        isbAttribuesData    Datos del atribto N de la actividad
        isbActividadesApoyo lista de actividades de apoyo separados por ";"

    Salida:

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    24-May-2010     AEcheverrySAO118249 Se modifica la forma de crear las actividades de apoyo
    20-May-2010     AEcheverrySAO118199 Creacion
    ******************************************************************/
    PROCEDURE procActividadApoyo
    (
        inuOrderId          in  Or_Order.Order_Id%type,
        inuOperUnitId       IN  OR_order.operating_unit_id%type,
        inuOrderActivityId  IN  or_order_activity.order_activity_id%type,
        inuActivityId       IN  or_order_activity.activity_id%type,
        isbActividadesApoyo IN  VARCHAR2,
        onuOrderActApoyoId  out or_order_activity.order_activity_id%type
    )
    IS
        -- instancia
        tbDataValue         UT_String.TyTb_String;
        nuOrdenApoyo        Or_Order.Order_Id%type;
        nuOrderActApoyoId   or_order_activity.order_activity_id%type;
        nuOrderItemId       or_order_items.order_items_id%type;

    BEGIN
        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.procActividadApoyo] INICIO',15);
        nuOrdenApoyo := inuOrderId;
        UT_String.ExtString(isbActividadesApoyo, ',', tbDataValue);

        -- si hay varias actividades de apoyo
        IF tbDataValue.COUNT > 0 THEN
            FOR idx IN tbDataValue.first .. tbDataValue.last LOOP

                onuOrderActApoyoId := NULL;
                nuOrderItemId   := NULL;

                or_bolegalizeactivities.CrearActividadApoyo
                (
                    nuOrdenApoyo,
                    inuOperUnitId,
                    inuOrderActivityId,
                    inuActivityId,
                    tbDataValue(idx),
                    onuOrderActApoyoId,
                    nuOrderItemId

                );
            END LOOP;
        ELSE

            -- solo debe haber una actividad de apoyo
            or_bolegalizeactivities.CrearActividadApoyo
            (
                nuOrdenApoyo,
                inuOperUnitId,
                inuOrderActivityId,
                inuActivityId,
                isbActividadesApoyo,
                onuOrderActApoyoId,
                nuOrderItemId

            );
        END IF;

        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.procActividadApoyo] FIN',15);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END procActividadApoyo;



    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : ProcessAttibutesActivity
    Descripcion	: Procesa los datos de una actividades
                  Formato:
                  [DATOS_ACTIVIDAD;ATRIBUTO_1;ATRIBUTO_2;ATRIBUTO_3;ATRIBUTO_4]
                  DATOS_ACTIVIDAD: [>ejecutada[>actividadApoyo1;actividadApoyo2;...;actividadApoyoN]*]
                        * no son requeridos
                  ATRIBUTO_N:      [atributo:valor:COMPONENTE]   NOTA: Si hay datos del compnente el campo valor indica el identificador del componente
                  COMPONENTE:      [atributo=valor]
    Parametros          Descripcion
    ============        ===================
    Entrada:
        inuOrderId      Identificador de oren
        isbAttribues    datos con los atributos de una actividad
        inuIndex        Posicion

    Salida:
        otbElemProduct  Tabla que contiene los product_id dado un elemento asignable.

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    28-09-2010      tlopez.SAO128405    Modificacion para validar que la cantidad
                                        con la que se legaliza la actividad no venga
                                        nula
    28-09-2010      tlopez.SAO128421    Modificacion para actualizar el registro
                                        de or_temp_order_items segun el archivo
                                        tambien cuando la cantidad a legalizar es 0.
                                        Se valida que la actividad pertenezca a la orden
    02-Sep-2010     csolanoSAO123697    Se modifica el llamado al procedimiento
                                        OR_BOItems.InsertOrUpdateItemsTempTable
    24-May-2010     AEcheverrySAO118590 Se modifica para permitir legalizar activades
                                        con cantidades diferente de 0 y 1 y con decimales
    20-May-2010     AEcheverrySAO118199 Se adiciona parametro de entrada inuOperUnitId
                                        Se adiciona proceso para la creacion de
                                        las actividades de apoyo
    23-12-2009      AEcheverrySAO109907 Se adiciona el parametro onuOrderActivity
    30-Nov-2009     MArteagaSAO107945   Se modifica el llamado al metodo
                                        OR_BOItems.InsertOrUpdateItemsTempTable
                                        se le pasa porque es un item de una actividad
    05-Nov-2008     jhramirezSAO85383   Se modifica para que inserte adecuadamente
                                        en la tabla OR_temp_order_items, con el
                                        sgte Procedure OR_BOItems.InsertOrUpdateItemsTempTable.

    22-Oct-2008     jhramirezSAO83697   Se modifica para adicionarle 1 parametros otbElemProduct y para
                                        Validar Planeacion y realizar las Actividades planeadas, requeridas.

    23-Ago-2008     asamboni SAO80792 Creacion.
    ******************************************************************/
    PROCEDURE ProcessAttibutesActivity
    (
        inuOrderId         in  Or_Order.Order_Id%type,
        inuOperUnitId      IN  OR_order.operating_unit_id%type,
        isbAttribues       in  varchar2,
        inuIndex           in  binary_integer,
        otbElemProduct     out tytbElementProductId,
        onuOrderActivityId OUT or_order_activity.order_activity_id%type
    )
    IS

        nuOrderActivityId   or_order_activity.order_activity_id%type;
        nuOrderOfActivity   or_order_activity.order_id%type;

        nuLegaActivity      OR_order_items.legal_item_amount%type;
        tbDataRecord        UT_String.TyTb_String;
        tbDataRecordNull    UT_String.TyTb_String;
        tbDataValue         UT_String.TyTb_String;
        tbDataValueNull     UT_String.TyTb_String;
        nuActivityId        or_order_activity.activity_id%type;
        ocurfOrder          Constants.tyRefCursor;

        tbElemProduct       tytbElementProductId;
        nuOrderItemId       or_order_items.order_items_id%type;

        -- actividades de apoyo
        sbActividadesApoyo  VARCHAR2(200);
        nuOrderActApoyoId   or_order_activity.order_activity_id%type;

    BEGIN
        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.ProcessAttibutesActivity] INICIO',3);
        ut_trace.Trace('[] Actividades:['|| isbAttribues ||']',4);
        if (isbAttribues is not null) then
            tbDataRecord := tbDataRecordNull;
            -- Se determina la cantidad de Actividades
            UT_String.ExtString(isbAttribues, csbSEPARATOR_2, tbDataRecord);
            ut_trace.Trace('[] Numero de atributos de la actividad:'||tbDataRecord.count,4);

            /*
                ut_trace.Trace('[***** 1 ['|| tbDataRecord(1) ||']',5);
                ut_trace.Trace('[***** 2 ['|| tbDataRecord(2) ||']',5);
                ut_trace.Trace('[***** 3 ['|| tbDataRecord(3) ||']',5);
                ut_trace.Trace('[***** 4 ['|| tbDataRecord(4) ||']',5);
                ut_trace.Trace('[***** 5 ['|| tbDataRecord(5) ||']',5);
            */

            -- obtiene el identificador de la actividad
            if tbDataRecord(1) IS not null then
                tbDataValue := tbDataValueNull;
                UT_String.ExtString(tbDataRecord(1), csbSEPARATOR_5, tbDataValue);
                ut_trace.Trace('['|| tbDataRecord(1) ||'][***** Numero de datos del componsnte:]'|| tbDataValue.count,15);

                if tbDataValue.count NOT IN (2,3) then
                    -- Error en el numero de parametros para obtener el identificador de la actividad %s1
                    Errors.setError(cnuERR_114707, inuIndex);
                    raise ex.CONTROLLED_ERROR;
                END if;

                nuOrderActivityId := tbDataValue(1);
                nuLegaActivity    := tbDataValue(2);

                nuOrderOfActivity := daor_order_activity.fnuGetOrder_id(nuOrderActivityId);

                --Se valida si la actividad pertenece de la orden
                if (nuOrderOfActivity <> inuOrderId) then
                    Errors.setError(cnuACTIVITY_NOT_IN_ORDER, nuOrderActivityId||'|'||inuOrderId);
                    raise ex.CONTROLLED_ERROR;
                end if;

                --Validar que la cantidad no venga nula
                if (nuLegaActivity is null) then
                    Errors.setError(cnuNULL_ACTIVITY_AMOUNT, nuOrderActivityId);
                    raise ex.CONTROLLED_ERROR;
                end if;

                nuActivityId := daor_order_activity.fnuGetActivity_id(nuOrderActivityId);
                onuOrderActivityId:= nuOrderActivityId;  -- para retornar

                IF tbDataValue.exists(3) then
                    sbActividadesApoyo := tbDataValue(3);
                    procActividadApoyo
                    (
                        inuOrderId,
                        inuOperUnitId,
                        nuOrderActivityId,
                        nuActivityId,
                        sbActividadesApoyo,
                        nuOrderActApoyoId
                    );

                    -- se obtiene la actividad de apoyo para su procesamiento
                    -- todas las actividades de apoyo se legalizan con exito
                    -- (no hay sentido en adicionar una actividad que no se va a hacer)
                    if (nuOrderActApoyoId IS not null) then
                        nuOrderActivityId := nuOrderActApoyoId;
                        nuLegaActivity := ge_boconstants.cnuTRUE;
                    END if;


                END IF;
                tbDataValue.delete;
                ut_trace.Trace('nuOrderActivityId:['|| nuOrderActivityId ||'] nuLegaActivity:['|| nuLegaActivity ||']',6);
                -- Instancia los atributos de la actividad
                InstanceAttribsActivity(inuOrderId, nuOrderActivityId);

            END if;

            -- Verifica si la actividad se ejecuto
            if  nuLegaActivity > ge_boconstants.cnuFALSE then

                --Validar Planeacion y realizar las Actividades planeadas, requeridas, --jhramirez SAO83697
                if or_bcplannedactivit.fnuGetPlannedAct(nuActivityId) > 0 then

        			if ocurfOrder%isopen then
        				close ocurfOrder;
        			end if;

                    or_boplanningactivit.GetInitPlannedActivity
                    (
                        nuOrderActivityId,
                        nuActivityId,
                        ge_bosequence.NextGroupSequence,
                        inuOrderId,
                        ocurfOrder
                    );

                END if;

                if tbDataRecord.exists(2) then
                    -- ATRIBUTO_N: [atributo:valor:id_componente:COMPONENTES]
                    -- NOTA: Si hay datos del compnente el campo valor indica el identificador del componente
                    -- Procesa el atributo 1 de la actividad
                     updAttributeActivity(inuOrderId, nuOrderActivityId, nuActivityId, tbDataRecord(2), 1,tbElemProduct);   -- atributo 1 del items
                END if;
                if tbDataRecord.exists(3) then
                    -- ATRIBUTO_N: [atributo:valor:id_componente:COMPONENTES]
                    -- Procesa el atributo 2 de la actividad
                    updAttributeActivity(inuOrderId, nuOrderActivityId, nuActivityId, tbDataRecord(3), 2,tbElemProduct);   -- atributo 2 del items
                END if;
                if tbDataRecord.exists(4) then
                    -- ATRIBUTO_N: [atributo:valor:id_componente:COMPONENTES]
                    -- Procesa el atributo 3 de la actividad
                    updAttributeActivity(inuOrderId, nuOrderActivityId, nuActivityId,tbDataRecord(4), 3,tbElemProduct);   -- atributo 3 del items
                END if;
                if tbDataRecord.exists(5) then
                    -- ATRIBUTO_N: [atributo:valor:id_componente:COMPONENTES]
                    -- Procesa el atributo 4 de la actividad
                    updAttributeActivity(inuOrderId, nuOrderActivityId, nuActivityId,tbDataRecord(5), 4,tbElemProduct);   -- atributo 4 del items
                END if;

                otbElemProduct  := tbElemProduct;
            END if;

            nuOrderItemId := daor_order_activity.fnuGetOrder_item_id(nuOrderActivityId);
            OR_BOItems.InsertOrUpdateItemsTempTable(inuOrderId,
                                                    nuActivityId,
                                                    nuLegaActivity,
                                                    null,
                                                    nuOrderItemId
                                                    );

        end if;

        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.ProcessAttibutesActivity] FIN',3);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessAttibutesActivity;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : ProcessActivitiesByLine
    Descripcion	: Procesa las actividades
                  Formato: [ACTIVIDAD_1<ACTIVIDAD_2<ACTIVIDAD_N]
    Parametros          Descripcion
    ============        ===================
    Entrada:
        inuOrderId      Identificador de oren
        isbActivities   Datos con las actividades

    Salida:
        otbElemProduct  tabla que contiene los product_id dado un Elemento Asignable. otbElemProduct(codeElementoAsignable).nuProdcut_id

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-May-2010     AEcheverrySAO118199 Se adiciona parametro de entrada inuOperUnitId
                                            y llamado al metodo  <<ProcessAttibutesActivity>>
    23-12-2009      AEcheverrySAO109907 Se adiciona el parametro onuOrderActivity
    22-Oct-2008     jhramirezSAO83697   se modifica para adicionarle 1 parametro otbElemProduct
                                        que contiene los product_id dado un elementos Asignable.

    23-Ago-2008     asamboni SAO80792 Creacion.
    ******************************************************************/
    PROCEDURE ProcessActivitiesByLine
    (
        inuOrderId      in  Or_Order.Order_Id%type,
        inuOperUnitId   IN  OR_order.operating_unit_id%type,
        isbActivities   in varchar2,
        otbElemProduct  out tytbElementProductId,
        onuOrderActivityId OUT or_order_activity.order_activity_id%type
    )
    IS
        tbDataRecord        UT_String.TyTb_String;
        tbDataRecordNull    UT_String.TyTb_String;
        nuIndex             binary_integer;
    BEGIN

        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.ProcessActivitiesByLine] INICIO',3);
        if (isbActivities is not null) then
            tbDataRecord := tbDataRecordNull;
            -- Se determina la cantidad de Actividades
            UT_String.ExtString(isbActivities, csbSEPARATOR_4, tbDataRecord);
            ut_trace.Trace('[] Numero de Actividades:'||tbDataRecord.count,4);
            if tbDataRecord.count > 0 then
                ut_trace.Trace('Actividad --------------------------------------------------------------------------------------:'||nuIndex,3);
                nuIndex := tbDataRecord.first;
                loop
                    -- Procesa los atribtos de la actividad
                    -- [DATOS_ACTIVIDAD;ATRIBUTO_1;ATRIBUTO_2;ATRIBUTO_3;ATRIBUTO_4]
                    ProcessAttibutesActivity(inuOrderId,inuOperUnitId, tbDataRecord(nuIndex), nuIndex,otbElemProduct, onuOrderActivityId);
                ut_trace.Trace('--------------------------------------------------------------------------------------',3);
                    exit when (nuIndex = tbDataRecord.last);
                    nuIndex := tbDataRecord.next(nuIndex);
                END loop;
            END if;
        end if;

        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.ProcessActivitiesByLine] FIN',3);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessActivitiesByLine;
--------------------------------------------------------------------------------
--  FIN de carga de actividades
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
--  INICIO de carga de Items
--------------------------------------------------------------------------------
    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : InsOrUpdTempOrderItems
    Descripcion	: Inserta o actualiza los datos del item en la tabla temporar

    Parametros          Descripcion
    ============        ===================
    Entrada:
        inuOrderId      Identificador de oren
        inuItemId       Item
        inuItemValue    Valor del item
        isbElementCode  Code del elemento
        inuElementId    Identificador del elemento

    Salida:

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    23-12-2009      AEcheverrySAO109907 Se modifica para que se actualize la
                                        actividad en los datos de or_temp_order_items
    23-Ago-2008     asamboni SAO80792   Creacion.
    ******************************************************************/
    Procedure InsOrUpdTempOrderItems
    (
        inuOrderId     in Or_Order.Order_Id%type,
        inuItemId      in ge_items.items_id%type,
        inuItemValue   in or_order_items.legal_item_amount%type,
        isbElementCode in if_node.code%type,
        inuElementId   in if_node.id%type,
        inuOrderActivityId in or_order_activity.order_activity_id%type
    )
    is
        --------------
        -- Variables
        --------------
        nuTaskTypeId        or_task_type.task_type_id%type;
        rcOrTempOrderItems  daor_temp_order_items.styor_temp_order_items;
        nuTempOrderItemsId  or_temp_order_items.temp_order_items_id%type := NULL;
    BEGIN
        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.InsOrUpdTempOrderItems] INICIO');

        -- Se obtiene el tipo de trabajo
        nuTaskTypeId := daor_order.fnugettask_type_id(inuOrderId);

        nuTempOrderItemsId := NULL;
        -- Se obtiene identificador de primer registro en tabla temporal de items
        -- de la Orden e Item especificados
        nuTempOrderItemsId := OR_BCItems.fnuGetTempItemId(inuOrderId, inuItemId);
        if (nuTempOrderItemsId is not null) then
            ut_trace.trace('Actualiza Item');
            rcOrTempOrderItems := daor_temp_order_items.frcGetRecord(nuTempOrderItemsId);
            -- Se actualiza los datos en la tabla temporal
            rcOrTempOrderItems.Legal_Item_Amount  := inuItemValue;
            rcOrTempOrderItems.Order_Id           := inuOrderId;
            rcOrTempOrderItems.element_code       := isbElementCode;
            rcOrTempOrderItems.element_id         := inuElementId;
            rcOrTempOrderItems.order_activity_id  := inuOrderActivityId;
            daor_temp_order_items.updRecord(rcOrTempOrderItems);
        else
            ut_trace.trace('Inserta Item');
            -- si se permiten adicionar items se insertan en la tabla temporal
            if daOR_task_type.fsbgetadd_items_allowed(nuTaskTypeId) = ge_boconstants.csbYES then
                -- Verifica item
                valItemOk(inuOrderId, inuItemId);

                -- se arma el registro a insertar
                rcOrTempOrderItems.temp_order_items_id := or_bosequences.fnuNextOR_Order_Items;
                rcOrTempOrderItems.Items_Id            := inuItemId;
                rcOrTempOrderItems.Legal_Item_Amount   := inuItemValue;
                rcOrTempOrderItems.Order_Id            := inuOrderId;
                rcOrTempOrderItems.element_code        := isbElementCode;
                rcOrTempOrderItems.element_id          := inuElementId;
                rcOrTempOrderItems.Assigned_Item_Amount:= 0;
                rcOrTempOrderItems.order_activity_id   := inuOrderActivityId;
                -- Inserta el registro
                daor_temp_order_items.insrecord(rcOrTempOrderItems);
            END if;
        end if;
        -- Se invoca el metodo que hace el calculo de los Items, una vez
        -- esten llenos los campos
        -- Or_BOItems.ComputeItems(inuOrder);

        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.InsOrUpdTempOrderItems] FIN');
    EXCEPTION
        when Or_BOLegalizeOrder.ex_DO_NOTHING then
            ut_trace.trace('Hacer Nada');
            null;
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END InsOrUpdTempOrderItems;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : ProcessItemData
    Descripcion	: Procesa los datos del item
                  Formato: [item:cantidad:code_elemento]
    Parametros          Descripcion
    ============        ===================
    Entrada:
        inuOrderId      Identificador de oren
        isbItemData     Datos del item
        inuIndex        Posicion

    Salida:

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    06-12-2012      cenaviaSAO197519    Se modifica para que no convierta el codigo
                                        externo en un numero.
    08/08/2012      JGarcia.SAO186231   En lugar de enviar el identificador de item se debe enviar el codigo
                                        externo. Con el codigo externo se buscar el identificador y el proceso
                                        sigue funcionado de la misma manera
    24-Ago-2010     amendezSAO125755    Se obtiene de los datos del item,
                                        el atributo out_ que indica si el item
                                        es instalado(Y), o retirado(N),
                                        esto aplica solo para items que no son
                                        elementos de red.
    23-12-2009      AEcheverrySAO109907 Se adiciona el parametro inuOrderActivity
                                        para enviarlo al metodo  <<InsOrUpdTempOrderItems>>
    30-Nov-2009     MArteagaSAO107945   Se modifica el indice de la tabla en la validacion
                                        de elementos y el paso de parametros al metodo
                                        or_boitems.AddItemsTempTable
                                        Se modifica para validar que se incluya para
                                        los items el campo reused con valor Y o N.
    23-Ago-2008     asamboni SAO80792 Creacion.
    ******************************************************************/
    PROCEDURE ProcessItemData
    (
        inuOrderId        in  Or_Order.Order_Id%type,
        isbItemData       in varchar2,
        inuIndex          in  BINARY_INTEGER,
        inuOrderActivityId IN or_order_activity.order_activity_id%type
    )
    IS
        tbDataRecord        UT_String.TyTb_String;
        tbDataRecordNull    UT_String.TyTb_String;
        sbExternCode        ge_items.code%type;
        nuItemId            ge_items.items_id%type;
        nuItemValue         or_order_items.legal_item_amount%type;
        sbElementCode       if_node.code%type;
        nuElementTypeId     if_node.Element_type_id%type;
        nuElementId         if_node.id%type;
        sbSerialNum         if_node.serial_number%type;
        nuClassId           if_node.class_id%type;
        nuOperatingSector   if_node.operating_sector_id%type;
        sbOutFlagValue      or_order_items.out_%type;
    BEGIN
        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.ProcessItemData] INICIO',3);
        ut_trace.Trace('[] Item:['|| isbItemData ||']',4);
        -- [item>cantidad>out_>code_elemento]
        if (isbItemData is not null) then
            tbDataRecord := tbDataRecordNull;
            -- Se determina la cantidad de atributos del elemento
            UT_String.ExtString(isbItemData, csbSEPARATOR_5, tbDataRecord);
            ut_trace.Trace('[] Elementos :'||tbDataRecord.count,4);
            -- obtiene el identificador de la actividad
            if tbDataRecord.count not in (2, 3, 4) then
                -- Error en la cantidad de parametros para obtener los datos del item (Item o Elemento) ITEM_ELEMENTO_%s1.
                Errors.setError(cnuERR_114711, inuIndex);
                raise ex.CONTROLLED_ERROR;
            END if;
            sbExternCode := tbDataRecord(1);
            nuItemValue := ut_convert.fnuChartoNumber(tbDataRecord(2));
            nuItemId := GE_BCItems.fnuGetItemsId(sbExternCode);

            nuElementTypeId := dage_items.fnuGetElement_type_id(nuItemId);

            if nuItemValue = 0 then
                ut_trace.Trace('Si la Cantidad elemento es 0 no se Procesa.',6);
                return;
            END if;

            ut_trace.Trace('[] nuItemId:['|| nuItemId ||'] nuItemValue:['|| nuItemValue ||'] nuElementTypeId:['|| nuElementTypeId ||']',6);

            if   nuElementTypeId IS not null then
                if  tbDataRecord.exists(4) then
                    sbElementCode := tbDataRecord(4);

                    -- Obtiene el identificador del elemento
                    IF_BOElementQuery.getElemInfoFromCode
                        (
                            nuElementTypeId,
                            sbElementCode,
                            nuElementId,
                            sbSerialNum,
                            nuClassId,
                            nuOperatingSector
                        );
                    ut_trace.Trace('sbElementCode:['|| sbElementCode ||'] nuElementId:['|| nuElementId||']',3);

                    -- actualiza los datos en la tabla temporal
                    InsOrUpdTempOrderItems
                    (
                        inuOrderId,
                        nuItemId,
                        nuItemValue,
                        sbElementCode,
                        nuElementId,
                        inuOrderActivityId
                    );
                END if;
            else
                -- valida datos del item
                valItemOk(inuOrderId, nuItemId);
                ge_boitems.ValidIsNormalItem(nuItemId);

                -- Obtiene si el item es de salida=instalado=Y o entrada=retirado=N
                IF tbDataRecord.exists(3) THEN
                    valItemOutFlag(nuItemId, tbDataRecord(3));
                    sbOutFlagValue := tbDataRecord(3);
                ELSE
                    Errors.setError(cnuERR_OUT_ITEM_FLAG,dage_items.fsbgetdescription(nuItemId));
                    raise ex.CONTROLLED_ERROR;
                END IF;

                -- actualiza los datos en la tabla temporal
                or_boitems.AddItemsTempTable(inuOrderId, nuItemId, nuItemValue, sbOutFlagValue);
            END if;

        end if;

        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.ProcessItemData] FIN',3);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessItemData;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : ProcessItemsByLine
    Descripcion	: Procesa los datos que contiene items (Items o elementos)
                  Formato: [ITEM_ELEMENTO_1;ITEM_ELEMENTO_2;ITEM_ELEMENTO_3]
    Parametros          Descripcion
    ============        ===================
    Entrada:
        inuOrderId      Identificador de oren
        isbItems        Datos con los items (item o elementos)
    Salida:

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    23-12-2009      AEcheverrySAO109907 Se adiciona el parametro inuOrderActivity
                                        para enviarlo al metodo  <<ProcessItemData>>
    23-Ago-2008     asamboni SAO80792 Creacion.
    ******************************************************************/
    PROCEDURE ProcessItemsByLine
    (
        inuOrderId    in  Or_Order.Order_Id%type,
        isbItems      in VARCHAR2,
        inuOrderActivityId IN or_order_activity.order_activity_id%type
    )
    IS
        tbDataRecord     UT_String.TyTb_String;
        tbDataRecordNull UT_String.TyTb_String;
        nuIndex             binary_integer;
    BEGIN

        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.ProcessItemsByLine] INICIO',3);
        if (isbItems is not null) then
            tbDataRecord := tbDataRecordNull;
            -- Se determina la cantidad de Actividades
            UT_String.ExtString(isbItems, csbSEPARATOR_2, tbDataRecord);
            if tbDataRecord.count > 0 then
                nuIndex := tbDataRecord.first;
                loop
                    -- Procesa los datos que contiene items
                    ProcessItemData(inuOrderId, tbDataRecord(nuIndex), nuIndex, inuOrderActivityId);

                    exit when (nuIndex = tbDataRecord.last);
                    nuIndex := tbDataRecord.next(nuIndex);
                END loop;
            END if;
        end if;

        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.ProcessItemsByLine] FIN',3);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessItemsByLine;
--------------------------------------------------------------------------------
--  FIN de carga de Items
--------------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    /*****************************************************************
    Unidad      : ProcessCommentOrderByLine
    Descripcion	: Procesa los comentarios de la Orden.

    Parametros          Descripcion
    ============        ===================
    inuOrderId          Id de la Orden.
    isbComentAll        cadena q contiene el tipo de comentario y el comentario
                        de la orden, y estan separados por el caracter csbSEPARATOR_2 ';'

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    17-Dic-2012     Arojas.SAO198204    Se agrega soporte a moviles (inuPersonId)
    24-Nov-2008     jhramirezSAO86243   Creacion.
    ******************************************************************/
    PROCEDURE ProcessCommentOrderByLine
    (
        inuOrderId      in  Or_Order.Order_Id%type,
        isbComentAll    in  varchar2,
        inuPersonId     in  ge_person.person_id%type default null
    )
    IS
        inuCommentTypeId	Or_Order_Comment.Comment_Type_Id%type;
        isbComment		    Or_Order_Comment.Order_Comment%type;
        ionuOrderCommentId  Or_Order_Comment.order_comment_id%type;
        nuIndex             number;
        tbDataRecord        UT_String.TyTb_String;
        tbDataRecordNull    UT_String.TyTb_String;

    BEGIN
        --Solo procesa si se ingreso comentarios.
        ut_trace.trace('INICIO Or_boActivitiesLegalizeByFile.ProcessCommentOrderByLine',12);
        if isbComentAll IS not null then
            tbDataRecord := tbDataRecordNull;
            UT_String.ExtString(isbComentAll, csbSEPARATOR_2, tbDataRecord);
            inuCommentTypeId    :=  tbDataRecord(1);
            isbComment          :=  tbDataRecord(2);
            ut_trace.trace('inuCommentTypeId :'||inuCommentTypeId|| '  isbComment:'||isbComment);
            --OR_BSFWLegalizeOrder.InsertOrUpdateComment
            OR_BOOrderComment.InsertOrUpdateComment
            (
                inuOrderId,
                inuCommentTypeId,
                isbComment,
                or_boconstants.csbSI,
                ionuOrderCommentId,
                inuPersonId
            );
        END if;

        ut_trace.trace('END Or_boActivitiesLegalizeByFile.ProcessCommentOrderByLine',12);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessCommentOrderByLine;
    ----------------------------------------------------------------------------



--------------------------------------------------------------------------------
--  FIN de carga de lecturas
--------------------------------------------------------------------------------

    /***************************************************************************
        Propiedad intelectual de Open International Systems (c).
        Unidad	    :  LegalizeOrderByLine
        Descripcion	:  Procedimiento que legaliza una orden con los datos
                       de una linea del archivo plano

        Autor       :  Alexander Samboni
        Fecha       :  23-Ago-2008
        Parametros  :  Entrada:
                            inuOrderId      Identificador de oren
                            inuPerson       persona
                            inuCausalId     causal
                            idtExeIniDat    Fecha inicial de legalizacion
                            idtExeFinDat    Fecha final de legalizacion
                            itbLine         tabla temporal
                       Salida:
                            onuErrorCode    Codigo de error
                            osbErrorMessage Mensaje  error

        Historia de Modificaciones
        Fecha	     Autor	            Modificacion
        ===========  ===============    ========================================
        28-12-2012  ARojas.SAO198736    Se agrega la posibilidad de insertar fecha diferente a la del sistema.
        17-12-2012  Arojas.SAO198204    Se cambia el llamado a ProcessCommentOrderByLine
                                        agregando el envio del PersonId.
        08-09-2010   tlopez.SAO122399   Estabilizacion sao122345 - aalbarracin
                                        Se cambia el llamado OR_BOItems.FillOrderItemsTempTablePL
                                        para que reciba la causal
        20-May-2010  AEcheverrySAO118199 Se adiciona parametro de entrada UnidadOperativa
                                            y llamado al metodo  <<ProcessActivitiesByLine>>
        23-12-2009   AEcheverrySAO109907 Se modifica llamados a los metodos
                                            <<ProcessActivitiesByLine>>
                                            y <<ProcessItemsByLine>>
                                        para adicionar el parametro id de la actividad

        24-Nov-2008  jhramirezSAO86243   Se agrega el llamado al procedimiento <<ProcessCommentOrder>>
                                        para procesar los comentarios de las ordenes.

        22-Oct-2008  jhramirezSAO83697   se modifico para adicionarle una variable tbElemProduct  contiene los product_id dado un Elemento Asignable. otbElemProduct(codeElementoAsignable).nuProdcut_id
                                        estos los obtiene por ProcessActivitiesByLine y se los pasa a ProcessElementReadByLine para que lo guarde en OR_order_red

        23-Ago-2008  asamboni SAO80833 Se borrar variables que no se utilizan en
                     el proceso
        23-Ago-2008  asamboni SAO80792 Creacion.
    ***************************************************************************/
    PROCEDURE LegalizeOrderByLine
    (
        inuOrderId      in  Or_Order.Order_Id%type,
        inuPerson       in  Ge_Person.Person_Id%type,
        inuCausalId     in  OR_order.causal_id%type,
        inuOperUnitId   IN  OR_order.operating_unit_id%type,
        idtExeIniDate   in  Or_Order.Exec_Initial_Date%type,
        idtExeFinDate   in  Or_Order.Execution_Final_Date%type,
        itbLine         in  UT_String.TyTb_String,
        onuErrorCode    out number,
        osbErrorMessage out varchar2,
        idtChangeDate   in OR_order_stat_change.stat_chg_date%type default null
    )
    IS
        nuTaskTypeId    OR_order.task_type_id%type;
        curfGetData     Constants.tyRefCursor;
        tbElemProduct   tytbElementProductId;
        nuOrderActivityId or_order_activity.order_activity_id%type;

    BEGIN
        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.LegalizeOrderByLine] INICIO',3);

        -- Instancia los datos de la orden
        OR_BOFWLegalizeOrderUtil.InitInstanceData(inuorderId);

        -- obtiene el tipo de trabajo
        nuTaskTypeId := daor_order.fnuGettask_type_id(inuOrderId);

        -- Carga los items en la tabla temporal para su legalizacion
        OR_BOItems.FillOrderItemsTempTablePL(inuOrderId, false, inuCausalId);

        -- Se llama al metodo que Inserta los datos adicionales pasando como parametros: Orden, Causal
        -- y un string con la estructura de los datos adicionales
        Or_BOLegalizeOrder.InsertInAdditionalData(inuOrderId, inuCausalId, itbLine(cnuCOL_ADITI_DATA));

        -- Procesa las actividades enviadas por el usuario
        ProcessActivitiesByLine(inuOrderId,inuOperUnitId, itbLine(cnuCOL_ACTIVITY), tbElemProduct, nuOrderActivityId);

        -- Carga los datos de los items con datos de elementos
        ProcessItemsByLine(inuOrderId, itbLine(cnuCOL_ITEM), nuOrderActivityId);

        -- Carga las lecturas or_order_read
        processReadByLine(itbLine(cnuCOL_READ));

        -- Se procesa el Comentario de la Orden.
        ProcessCommentOrderByLine(inuOrderId, itbLine(cnuCOL_COMMENT),itbLine(cnuCOL_PERSON));

        -- legaliza la orden y sus actividades
        ut_trace.Trace('***[Inicio de Legalizando la orden de trabajo:['||inuorderId||']');
        if ut_trace.getLevel > 31 then
            ge_boinstancecontrol.DsplyAllAttributeStack;
        END if;

        --ut_trace.Trace('[JRH 01 OR_boACtvitiiesLegalizaByFile :['||inuorderId||','||inuPerson||','||inuCausalId||','||nuTaskTypeId||']');
        or_bolegalizeactivities.LegalizeOrder(inuorderId, inuPerson,inuCausalId, idtExeIniDate, idtExeFinDate, nuTaskTypeId,idtChangeDate);

        ut_trace.Trace('***[Fin de Legalizando la orden de trabajo:['||inuorderId||']');
        if ut_trace.getLevel > 31 then
            ge_boinstancecontrol.DsplyAllAttributeStack;
        END if;

        ut_trace.trace('*** '||or_boinstance.fnuGetOrderIdFromInstance,0 );

        -- Se elimina la instancia que fue creada para la evaluacion
        Or_BOInstance.StopInstanceManager;

        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.LegalizeOrderByLine] FIN',3);

    EXCEPTION
		when ex.CONTROLLED_ERROR then
            Or_BOInstance.StopInstanceManager;
			Errors.getError(onuErrorCode, osbErrorMessage);
		when others then
            Or_BOInstance.StopInstanceManager;
			Errors.setError;
            Errors.getError(onuErrorCode, osbErrorMessage);
    END LegalizeOrderByLine;

    /***************************************************************************
        Propiedad intelectual de Open International Systems (c).
        Unidad	    :  LegalizeOrderAdm
        Descripcion	:  Procedimiento que legaliza una orden administrativa
                       con los datos de una linea del archivo plano

        Autor       :  Luis Alberto Lopez Agudelo
        Fecha       :  28-Sep-2010
        Parametros  :  Entrada:
                             inuOrderId     Identificador de la orden.
                             inuCausalId    Identificador de la causal.
                             isbComentAll   Persona que cierra.
                             isbComment     Comentario de la orden (tipo;comentario).

                       Salida:
                            onuErrorCode    Codigo de error
                            osbErrorMessage Mensaje  error

        Historia de Modificaciones
        Fecha	     Autor	            Modificacion
        ===========  ===============    ========================================
        23-07-2012  cenaviaSAO186451        Se publica el metodo
        28-Sep-2010  llopezSAO116327    Creacion.
    ***************************************************************************/
    PROCEDURE LegalizeOrderAdm
    (
        inuOrderId      in  Or_Order.Order_Id%type,
        inuCausalId     in  OR_order.causal_id%type,
        isbComentAll    in  varchar2,
        onuErrorCode    out ge_error_log.error_log_id%type,
        osbErrorMessage out ge_error_log.description%type
    )
    IS
        nuTaskTypeId    OR_order.task_type_id%type;
        curfGetData     Constants.tyRefCursor;
        tbElemProduct   tytbElementProductId;
        nuOrderActivityId or_order_activity.order_activity_id%type;

        inuCommentTypeId	Or_Order_Comment.Comment_Type_Id%type;
        isbComment		    Or_Order_Comment.Order_Comment%type;
        tbDataRecord        UT_String.TyTb_String;
        tbDataRecordNull    UT_String.TyTb_String;

    BEGIN
        inuCommentTypeId    :=  null;
        isbComment          :=  null;

        --Solo procesa si se ingreso comentarios.
        if isbComentAll IS not null then
            tbDataRecord := tbDataRecordNull;
            UT_String.ExtString(isbComentAll, csbSEPARATOR_2, tbDataRecord);
            inuCommentTypeId    :=  tbDataRecord(1);
            isbComment          :=  tbDataRecord(2);
        end if;

        -- Invoca el cierre de la orden
        Or_BoAdminOrder.closeOrder(inuOrderId, inuCausalId, inuCommentTypeId, isbComment);

    EXCEPTION
		when ex.CONTROLLED_ERROR then
            Or_BOInstance.StopInstanceManager;
			Errors.getError(onuErrorCode, osbErrorMessage);
		when others then
            Or_BOInstance.StopInstanceManager;
			Errors.setError;
            Errors.getError(onuErrorCode, osbErrorMessage);
    END LegalizeOrderAdm;

    ----------------------------------------------------------------------------
    --  Metodos publicos
    ----------------------------------------------------------------------------
     /*************************************************
    Metodo   	:   LegalizeFromFile
    Descripcion	:   Toma los datos del archivo y los legaliza linea por linea


    Parametros			Descripcion
    ============  	===================
    isbDirectory        directorio
    isbFile             Ruta del archivo
    idtInitExtDate      fecha inicial de ejecucion
    idtFinalExtDate     fecha final de ejecucion
    inuOperatingUnit    unidad operativa

    Autor		: yclavijo
    Fecha		: 16-Jun-06

    Historia de Modificaciones
    Fecha   	Autor  	   	   	   	Modificacion
    =====   	=====  	   	   	   ====================
    22-08-2014  FSaldanaSAO265233   Se modifica para que indique con variable global
                                    que esta ejecutando el proceso de legalizacion por
                                    archivo plano.
                                    Ademas luego de legalizar cada orden, si aplica,
                                    se actualiza la capacidad usada de la unidad
                                    de trabajo.
    21-06-2013  llopezSao210199     Se modifica para utilizar las fechas de
                                    ejecucion de la orden si vienen en el archivo
    01-08-2012  arojas.SAO184025    Estabilizacion, Se modifica para validar si
                                     la unidad de trabajo se ingreso, de no ser
                                     asi no debe validar que la orden este
                                     asignada una unidad en particular.

    29-05-2012  cenaviaSAO183476    Se modifica para que valide si la unidad de
                                    trabajo se ingreso, de no ser asi no debe
                                    validar que la orden este asignada una unidad
                                    en particular.
    14-03-2012  cenaviaSAO176556    Estabilizacion.
                cenaviaSAO175863    Se modifica la variable sbLine para que
                                    soporte lineas de maximo 4000 caracteres.
    01-10-2010  llopezSAO129961     Se modifica para validar que la estructura corresponda al tipo de orden
    28-09-2010  llopezSAO126327     Se modifica para soportar el cierre de ordenes administrativas
    23-12-2009  AEcheverrySAO109907 Se modifica para que soporte lineas de maximo 4000 caracteres.
    *************************************************/
    PROCEDURE LegalizeFromFile
    (
        isbDirectory         in varchar2,
        isbFileName          in varchar2,
        idtInitExtDate       in date,
        idtFinalExtDate      in date,
        inuOperatingUnit     in or_operating_unit.operating_unit_id%type
    )
    IS
        -- Variables para el manejo de archivos
        fpOrdersData        utl_file.file_type;
        sbLine              stySizeLine;
        nuRecord            number;
        fpOrderErrors       utl_file.file_type;
        sbErrorFile         varchar2(100);
        sbErrorLine         stySizeLine;
        nuOrderId           OR_order.order_id%type;
        nuCausal            OR_order.causal_id%type;
        nuPerson            ge_person.person_id%type;
        nuErrorCode         number;
        sbErrorMessage      varchar2(2000);
        nuComp              number;
        tbLine              UT_String.TyTb_String;
        nuOperatingUnitId   or_order.Operating_unit_id%type;
        sbIsAdminOrder      varchar2(10);
        -- Variables para disminuir la capacidad usada de la orden
        sbOrderAssType       Or_Order.Assigned_With%type;
        sbOperUnitAssType    Or_Operating_Unit.Assign_Type%type;

    BEGIN
        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.LegalizeFromFile] INICIO',3);
        -- se borran los datos en la tabla temporal de mensajes
        Or_BOInternalServicies.DeleteMessageTempTable;
        -- deshabilita el borrado de la tabla temporal
        or_boupdordercontroller.SetDisableDelTempTable;

        -- Verifica si el archivo existe en la ruta especificada
        ge_boFileManager.CheckFileisExisting (isbDirectory||csbFILE_SEPARATOR||isbFileName);

        -- nombra el archivo de errores.
        sbErrorFile := substr(isbFileName,1,instr(isbFileName,'.')-1);

        if sbErrorFile is null then
           sbErrorFile := isbFileName;
        END if;

        sbErrorFile := sbErrorFile||'.err';

        -- Abre el archivo en modo lectura
        ge_boFileManager.FileOpen (fpOrdersData, isbDirectory, isbFileName, ge_boFileManager.csbREAD_OPEN_FILE, cnumaxlengthToleg);
        -- Crea y abre el archivo para el log de errores
        ut_file.FileOpen(fpOrderErrors,isbDirectory,sbErrorFile,'w',cnumaxlengthToleg);

        nuRecord := 0;

        -- Indica que se esta ejecutando legalizacion masiva por archivo plano
        gblIsLegalizeByFile := TRUE;


        -- Procesa cada linea del archivo
        while true loop
            -- Limpia la capacidad usada por la orden
            gnuOrderUsedCapacity := 0;

            -- Limpia las tablas temporales
            clearTempTable;

            -- lee una linea del archivo
            ge_boFileManager.FileRead (fpOrdersData, sbLine);

            exit when sbLine is null;
            nuRecord := nuRecord + 1;
            -- Se estable savepoint
            savepoint legalize;

            -- Llena las tablas temporales
            LoadAndValidInitialData(sbLine,nuRecord,nuOrderId,nuCausal,nuPerson, tbLine, nuErrorCode, sbErrorMessage);

            if nuErrorCode = ge_boconstants.cnuSUCCESS then
                LockOrder(nuOrderId, nuErrorCode, sbErrorMessage);  --Bloquea la Orden, si no ocurrio error, antes.
            end if;

            --ut_trace.trace('JRH, : LegalizeFromFile [nuOrderId,nuCausal,nuPerson] ['||nuOrderId||','||nuCausal||','||nuPerson||' ]',3);

            if nuErrorCode <> ge_boconstants.cnuSUCCESS then
               nuOrderId := fnuGetOrder(sbLine);
               sbErrorLine := nuOrderId ||' '|| nuErrorCode ||'-'|| sbErrorMessage;
               ut_trace.trace('Orden ['||nuOrderId||'] Error '||nuErrorCode||'-'|| sbErrorMessage);
               -- Inserta error en el archivo
               ut_file.FileWrite(fpOrderErrors,sbErrorLine);
               sbErrorLine := null;
               -- inserta error en la tabla temporal de mensajes
               if daor_order.fblExist(nuOrderId) then
                    Or_BOInternalServicies.SaveProcessMessInTempTable(nuOrderId, nuErrorCode, sbErrorMessage);
               else
                    if nuOrderId is not null then
                       nuComp := null;
                    else
                       nuComp := nuErrorCOde;
                    END if;
                    Or_BOInternalServicies.SaveProcessMessInTempTable(nuOrderId, nuErrorCode, sbErrorMessage, nuComp, false);
               END if;
               rollback to legalize;
            else
                -- verifica si la orden esta asignada a la unidad operativa o a una de sus hijas
                nuOperatingUnitId := daor_order.fnuGetOperating_unit_id(nuOrderId, 0);

                -- Se valida si la unidad de trabajo es nula, de ser asi no se valida
                -- si esta asignada a la orden o a una de sus hijas
                if (inuOperatingUnit IS null OR nuOperatingUnitId = inuOperatingUnit) then
                    -- legaliza la orden y trata de notificar al sistema externo
                    ----------------------------------------------------------------
                    --  Legalizacion de la orden de trabajo
                    ----------------------------------------------------------------
                    sbIsAdminOrder := Or_BcOrderActivities.fsbIsAdminOrder(nuorderId);
                    if ((tbLine.count = cnuMAX_COLUMN_ADM) and
                        (sbIsAdminOrder = ge_boconstants.csbYES)) THEN
                        LegalizeOrderAdm(nuorderId, nuCausal, tbLine(cnuCOL_COMMENT_ADM), nuErrorCode, sbErrorMessage);
                    elsif ((tbLine.count = gnuMAX_COLUMN) and
                           (sbIsAdminOrder != ge_boconstants.csbYES)) then
                        -- Obtiene las fechas de ejecucion del archivo, sino, de la interfaz
                        if (gnuMAX_COLUMN = cnuMAX_COLUMN) then
                            gdtInitialDate := idtInitExtDate;
                            gdtFinalDate := idtFinalExtDate;
                        end if;
                        LegalizeOrderByLine(nuorderId, nuperson, nuCausal, nuOperatingUnitId, gdtInitialDate, gdtFinalDate, tbLine, nuErrorCode, sbErrorMessage);

                        ut_trace.trace('Orden :'|| nuorderId, 2);
                        ut_trace.trace('nuOperatingUnitId :'|| nuOperatingUnitId, 2);
                        ut_trace.trace('gnuOrderUsedCapacity :'|| gnuOrderUsedCapacity, 2);
                        -- Actualiza la capacidad usada de la unidad de trabajo
                        daor_operating_unit.updUsed_Assign_Cap(nuOperatingUnitId, gnuOrderUsedCapacity);
                    else
                        BEGIN
                            ge_boerrors.SetErrorCodeArgument(cnuERR_UNSTRUCTURED_FILE, nuRecord);
                        EXCEPTION
                            when ex.CONTROLLED_ERROR  then
                                Errors.getError(nuErrorCode, sbErrorMessage);
                            when OTHERS then
                                Errors.setError;
                                Errors.getError(nuErrorCode, sbErrorMessage);
                        END;
                    end if;


                    if nuErrorCode <> ge_boconstants.cnuSUCCESS then
                       sbErrorLine := '['||nuRecord ||']['|| nuOrderId ||'] '|| nuErrorCode ||'-'|| sbErrorMessage;
                       ut_trace.trace('Error '||nuErrorCode||'-'|| sbErrorMessage);
                       -- Inserta error en el archivo
                       ut_file.FileWrite(fpOrderErrors,sbErrorLine);
                       sbErrorLine := null;
                       -- inserta error en la tabla temporal de mensajes
                       Or_BOInternalServicies.SaveProcessMessInTempTable(nuOrderId, nuErrorCode, sbErrorMessage);
                       rollback to legalize;
                    else
                      --ut_trace.trace('jrh: se hace commit', 2);
                      commit;
                    END if;
                else

                       sbErrorLine := '['||nuRecord ||']['|| nuOrderId ||'] '|| cnu_MESS_HAS_NOT_ORD_FLATFILE ||'-'||
                                      ge_bomessage.fsbGetMessage(cnu_MESS_HAS_NOT_ORD_FLATFILE, inuOperatingUnit||'|'||nuOperatingUnitId);
                       ut_trace.trace('Error '||nuErrorCode||'-'|| sbErrorMessage);
                       -- Inserta error en el archivo
                       ut_file.FileWrite(fpOrderErrors,sbErrorLine);
                       sbErrorLine := null;
                       -- inserta error en la tabla temporal de mensajes
                       Or_BOInternalServicies.SaveProcessMessInTempTable
                                     (nuOrderId, cnu_MESS_HAS_NOT_ORD_FLATFILE,
                                      ge_bomessage.fsbGetMessage(cnu_MESS_HAS_NOT_ORD_FLATFILE,
                                      inuOperatingUnit||'|'||nuOperatingUnitId)
                                     );
                       rollback to legalize;
                END if;
            END if;
        END loop;

        -- Indica que no se esta ejecutando legalizacion masiva por archivo
        gblIsLegalizeByFile := FALSE;
        gnuOrderUsedCapacity := 0;

        -- Cierra el archivo de lectura
        if utl_file.is_open (fpOrdersData) then
            ge_boFileManager.FileClose (fpOrdersData);
        END if;
        -- cierra el archivo de errores
        if utl_file.is_open (fpOrderErrors) then
            ge_boFileManager.FileClose (fpOrderErrors);
        END if;

        -- habilita nuevamente el borrado de la tabla
        or_boupdordercontroller.SetEnableDelTempTable;
        ut_trace.trace('[OR_BOActivitiesLegalizeByFile.LegalizeFromFile] FIN',3);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            -- Indica que no se esta ejecutando legalizacion masiva por archivo
            gblIsLegalizeByFile := FALSE;
            gnuOrderUsedCapacity := 0;
            or_boupdordercontroller.SetEnableDelTempTable;
            raise ex.CONTROLLED_ERROR;
        when others then
            -- Indica que no se esta ejecutando legalizacion masiva por archivo
            gblIsLegalizeByFile := FALSE;
            gnuOrderUsedCapacity := 0;
            or_boupdordercontroller.SetEnableDelTempTable;
            rollback;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : processReadData
    Descripcion	: Procesa las lecturas para un equipo particular

    Parametros          Descripcion
    ============        ===================
    Entrada:
        isbEquipmentReads   Linea de lecturas de elementos
        inuPosition         Posicion de la linea

    Salida:

    Historia de Modificaciones
    Fecha           Autor                   Modificacion
    ============    ===================     ====================
    11-12-2012      AEcheverrySAO197519     Se modifica llamado a setEquipmentRead
                                            para eliminar el parametro fecha de lectura,
                                            Se reducen a 6 los parametros de cada lectura
    04-12-2012      cenaviaSAO197498        Se modifica para enviar la fecha de
                                            lectura con el formato de fecha del
                                            sistema
    17-04-2012      cenaviaSAO159297        Creacion.
    ******************************************************************/
    PROCEDURE processReadData
    (
        isbEquipmentReads   in  varchar2,
        inuPosition         in  number
    )
    IS
        tbEquipmentReads    ut_string.TyTb_String;

        tbReads             ut_string.TyTb_String;

        tbDataRecord        ut_string.TyTb_String;

        nuItemSeriadoId     ge_items_seriado.id_items_seriado%type;

        rcItemsSeriado      dage_items_seriado.styGE_items_seriado;

        nuItemsGamaID       ge_items_gama_item.id_items_gama%type;

        nuIndexRead         number;

    BEGIN

        ut_trace.trace('-- INICIO OR_BOActivitiesLegalizeByFile.processReadData',3);

        IF(isbEquipmentReads IS not null) THEN
            ut_string.ExtString(isbEquipmentReads, csbSEPARATOR_2, tbEquipmentReads);

            IF(tbEquipmentReads.count = 0) THEN
                return;
            ELSIF(tbEquipmentReads.count !=2) THEN
                ge_boerrors.SetErrorCodeArgument(cnuERR_114708, inuPosition);
            END IF;

            --Se obtiene la serie si existe
            GE_BCItemsSeriado.getIdBySerie(tbEquipmentReads(1), nuItemSeriadoId);

            -- Se obtiene los Datos del item seriado
            dage_items_seriado.getRecord(nuItemSeriadoId, rcItemsSeriado);

            -- Se obtiene la categoria del item
            ge_bcitems_gama_item.getItemGamaByItem(rcItemsSeriado.items_id, nuItemsGamaID);

            UT_String.ExtString(tbEquipmentReads(2), csbSEPARATOR_5, tbReads);

            -- Se valida que las lecturas no sean nulas.
            IF (tbReads.count =0) THEN
                ge_boerrors.SetErrorCodeArgument(cnuERR_114704, inuPosition||'|'||tbEquipmentReads(1));
            END IF;

            nuIndexRead := tbReads.first;

            -- Se obtiene cada registro de lectura
            while(nuIndexRead IS not null) Loop

                -- Se obtiene la informacion de cada registro de lectura ingresado
                UT_String.ExtString(tbReads(nuIndexRead), csbSEPARATOR_3, tbDataRecord);

                -- Se valida que la cantidad de datos de la lectura este bien
                IF (tbDataRecord.Count !=6) THEN
                ge_boerrors.SetErrorCodeArgument(cnuERR_114710, inuPosition||'|'||tbEquipmentReads(1));
                END IF;

                -- Se valida que el tipo de consumo sea valido para la categoria
                IF (ge_bcconstypebygama.fsbValConsuByCategory(tbDataRecord(1), nuItemsGamaID)= or_boconstants.csbNO) THEN
                    ge_boerrors.SetErrorCodeArgument(cnuERR_901042, tbDataRecord(1)||'|'||nuItemsGamaID);
                END IF;

                -- se registra la lectura temporalmente
                OR_BOInstanceActivities.SetEquipmentRead
                    (
                        tbEquipmentReads(1),
                        tbDataRecord(1),
                        tbDataRecord(2),
                        tbDataRecord(3),
                        tbDataRecord(4),
                        tbDataRecord(5),
                        tbDataRecord(6)
                    );

                nuIndexRead := tbReads.next(nuIndexRead);
            END LOOP;
        END IF;
        ut_trace.trace('-- FIN OR_BOActivitiesLegalizeByFile.processReadData',3);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END processReadData;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : processReadByLine
    Descripcion	: Procesa las lecturas para un equipo particular

    Parametros          Descripcion
    ============        ===================
    Entrada:
        isbAllReads     Linea de lecturas de elementos

    Salida:

    Historia de Modificaciones
    Fecha           Autor                   Modificacion
    ============    ===================     ====================
    17-04-2012      cenaviaSAO159297        Creacion.
    ******************************************************************/
    PROCEDURE processReadByLine
    (
        isbAllReads     in  varchar2
    )
    IS

        tbEquipmentReads    ut_string.TyTb_String;

        nuIndexRead         number;

    BEGIN

        ut_trace.trace('-- INICIO OR_BOActivitiesLegalizeByFile.processReadByLine',3);

        IF(isbAllReads IS not null) THEN
            ut_string.ExtString(isbAllReads, csbSEPARATOR_4, tbEquipmentReads);

            --QUE PASA SI LA NUEVA TABLA ES NULA
             nuIndexRead := tbEquipmentReads.first;

            -- Se obtiene cada registro de lectura
            while(nuIndexRead IS not null) Loop

                -- Se procesa la lectura para un equipo
                OR_BOActivitiesLegalizeByFile.processReadData(tbEquipmentReads(nuIndexRead), nuIndexRead);

                nuIndexRead := tbEquipmentReads.next(nuIndexRead);
            END LOOP;
        END IF;

        ut_trace.trace('-- FIN OR_BOActivitiesLegalizeByFile.processReadByLine',3);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END processReadByLine;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : AssociateSealComp
    Descripcion	: Procesa la informacion del componente de asociacion de sellos
        Formato:
    --  COMPONENTE
            [ATRIBUTOS_COMPONENTE_1>ATRIBUTOS_COMPONENTE_2>ATRIBUTOS_COMPONENTE_N]
    --  ELEMENTO_COMPONENTE_N
            [serieSello1=ubicacion=Asociar!serieSello2=ubicacion=Asociar?! serieSello3=ubicacion=Asociar]

    Parametros          Descripcion
    ============        ===================
    Entrada:
        inuOrderId          Identificador de orden.
        isbAttribute        Atributo.
        inuOrderActivityId  Indetificador de la actividad.
        isbComponentData    datos del componente.
        inuAttibuteIndex    indice del atributo.
        inuIndex            Numero de registro.

    Salida:

    Historia de Modificaciones
    Fecha              Autor                                  Modificacion
    =========    ===================     ====================
    26-10-2012      cenaviaSAO194932    Se modifican los atributos enviados al
                                        mensaje de error que se muestra cuando la
                                        accion no es valida
    17-10-2012      cenaviaSAO194244    Se elimina el llamado al metodo
                                        OR_BOActivitiesLegalizeByFile.ValAssoSealComp
                                        ya que en el core de legalizacion se valida
                                        Si la accion es 'R' se alamcena la serie
                                        en la tabla de errores para que genere fraude
    06-10-2012      AEcheverrySAO193197 Se modifica para validar las accciones
                                        validas para el manejo de sellos
    14-09-2012      cenaviaSAO190698    Se modifica segun referencia de Anieto para
                                        enviar la ubicacion al metodo de asociar
    27-Jun-2012     anietoSAO179521     Se agregar la opcion de localizacion extraida
                                        del atributo isbComponentData
    17-04-2012      cenaviaSAO159297    Creacion.
    ******************************************************************/
    PROCEDURE AssociateSealComp
    (
        inuOrderId         in   or_order.order_id%type,
        isbAttribute       in   ge_attributes.name_attribute%type,
        inuOrderActivityId in   or_order_activity.order_activity_id%type,
        isbComponentData   in   varchar2,
        inuAttibuteIndex   in   number,
        inuComponentId     in   number,
        isbValue           in   varchar2
    )
    IS

        tbDataRecord        ut_string.TyTb_String;

        tbDataValue         ut_string.TyTb_String;

        tbDataValueNull     ut_string.TyTb_String;

        sbInstanceValue     ge_boinstancecontrol.stysbValue;

        nuIndexComponent    number;

        rcSerialItem    dage_items_seriado.styGE_items_seriado;

    BEGIN

        ut_trace.trace('-- INICIO OR_BOActivitiesLegalizeByFile.AssociateSealComp', 2 );
        -- no se si se deba realizar esto, creo que ya se hizo en la anteriro
        --ut_string.ExtString(isbComponentData, csbSEPARATOR_5, tbComponentData);

        UT_String.ExtString(isbComponentData, csbSEPARATOR_6, tbDataRecord);

            if tbDataRecord.count > 0 then
                nuIndexComponent := tbDataRecord.first;
                while(nuIndexComponent IS not null) loop

                    tbDataValue := tbDataValueNull;
                    --  [elemento=accion=ubicacion]
                    UT_String.ExtString(tbDataRecord(nuIndexComponent), csbSEPARATOR_3, tbDataValue);


                    if (tbDataValue.count not in (2,3)) then
                        -- Error en el numero de parametros en los datos del atributo %s1 de la actividad %s2.
                        Errors.setError(cnuERR_114723,inuAttibuteIndex||'|'||inuOrderActivityId);
                        raise ex.CONTROLLED_ERROR;
                    END if;

                    --  se validan las acciones a aplicar sobre el sello
                    if (  tbDataValue(3) not in (ge_boitemsconstants.csbSealActionInstall,
                                                ge_boitemsconstants.csbSealActionRemove,
                                                ge_boitemsconstants.csbSealActionManipulated,
                                                ge_boitemsconstants.csbSealActionMaintain)) then

                        Errors.setError(cnuERR_901778,tbDataValue(3));
                        raise ex.CONTROLLED_ERROR;
                    END if;

                    rcSerialItem := GE_BCItemsSeriado.frcSerialItemBySerie(sbInstanceValue);

                    or_boinstanceactivities.setEquipToAssoc
                        (
                            tbDataValue(1),
                            rcSerialItem.Items_Id,
                            tbDataValue(3),
                            inuOrderActivityId,
                            tbDataValue(2)
                        );

                    -- Se setea la serie en la tabla de errores para que en caso
                    -- que el sello a desasociar no este asociado genere fraude,
                    -- no error
                    IF(tbDataValue(3) = ge_boitemsconstants.csbSealActionRemove) THEN
                        tbSerialError(tbDataValue(1)).SealSerie := tbDataValue(1);
                    END IF;

                    nuIndexComponent := tbDataRecord.next(nuIndexComponent);
                END LOOP;
            END IF;
        ut_trace.trace('-- FIN OR_BOActivitiesLegalizeByFile.AssociateSealComp', 2 );

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END AssociateSealComp;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).
    Unidad      : ValAssoSealComp
    Descripcion	: Valida la informacion del componente .Net de asociacion
                  de sellos recibida.
                  Retorna el equipo al cual se debe realizar la asociacion

    Parametros          Descripcion
    ============        ===================
    Entrada:
        isbSerie            serie del sello
        inuOrderActivityId  Indetificador de la actividad de la orden
        isbIsToAssoc        Si es para Asociar o Desasociar

    Salida:
        orcSerialItem       Registro del equipo seriado respecto del cual se
                            realiza la asociacion

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    ==========  ====================    ========================================
    16-07-2013  amendezSAO212060        Retorna rc de equipo seriado en vez de
                                        solo su serie
                                        Busca adicionalmente el equipo en estructura
                                        de memoria establecida por ORLOL.
    17-10-2012  cenaviaSAO194319        Se modifican algunos mensajes de error para
                                        enviar la serie, no el id del item seriado,
                                        esto se hace para un mejor entnedimiento
    17-10-2012  cenaviaSAO194244        Se modifica el manejo del error cuando
                                        el sello no tiene el estado valido
    08-10-2012  cenaviaSAO193287        Se impacta debido a que inicialmente
                                        se utilizaba la constante 'Y' y 'N' para
                                        determinar si se asocia un sello, ahora se
                                        utiliza 'I'
                                        Se modifica para que, cuando se valide
                                        una desasociacion de un sello, si es
                                        la primera vez muestre mensaje de error
                                        de lo contrario permita seguir el proceso
    20-04-2012  cenaviaSAO159297        Creacion.
    ******************************************************************/
    PROCEDURE ValAssoSealComp
    (
        isbSerie            in  ge_items_seriado.serie%type,
        inuOrderActivityId  in  or_order_activity.order_activity_id%type,
        isbIsToAssoc        in  varchar2,
        orcSerialItem       out dage_items_seriado.styGE_items_seriado
    )
    IS
        sbInstanceValue     ge_boinstancecontrol.stysbValue;
        nuItemSeriadoId     ge_items_seriado.id_items_seriado%type;
        tbEquipForAsoc      or_boinstanceactivities.tytbEquipmentForAsoc;
        sbIndex             varchar2(70);
    BEGIN
        ut_trace.trace('INICIO OR_BOActivitiesLegalizeByFile.ValAssoSealComp. isbSerie: '
                    ||isbSerie||', inuOrderActivityId: '
                    ||to_char(inuOrderActivityId)||', isbIsToAssoc: '
                    ||isbIsToAssoc, 2 );

        -- Se obtiene la serie si existe
        GE_BCItemsSeriado.getIdBySerie(isbSerie, nuItemSeriadoId);

        -- Se valida que exista
        if(nuItemSeriadoId IS NULL) THEN
            ge_boerrors.SetErrorCodeArgument(cnuERR_7613, isbSerie);
        END IF;

        ut_trace.trace('nuItemSeriadoId '||to_char(nuItemSeriadoId), 2 );
        -- Se obtiene la instancia con el atributo INSTALAR_SERIADO
        sbInstanceValue := or_boinstanceactivities.fsbGetAttributeValue
                        (
                            or_boconstants.csbSerialItemInstall,
                            inuOrderActivityId
                        );
        ut_trace.trace('INSTALAR_SERIADO - obInstanceValue '||sbInstanceValue, 2 );

        -- Si no se obtuvo ningun valor se intenta de nuevo
        IF (sbInstanceValue IS NULL) THEN
            -- Se obtiene la instancia con el atributo ASSOCIATE_EQUIPMENT
            sbInstanceValue := or_boinstanceactivities.fsbGetAttributeValue
                        (
                            ge_bcattributes.csbAssociateEquipment,
                            inuOrderActivityId
                        );
            ut_trace.trace('ASSOCIATE_EQUIPMENT - obInstanceValue '||sbInstanceValue, 2 );
        END IF;

        -- Si no se obtuvo ningun valor se intenta de nuevo
        IF (sbInstanceValue IS NULL) THEN

            -- Se obtiene la instancia con el atributo RECUPERAR_SERIADO
            sbInstanceValue := or_boinstanceactivities.fsbGetAttributeValue
                        (
                            or_boconstants.csbSerialItemRecovery,
                            inuOrderActivityId
                        );
            ut_trace.trace('RECUPERAR_SERIADO - obInstanceValue '||sbInstanceValue, 2 );
        END IF;

        -- Intenta en tabla pl de equipo a asociar (ORLOL)
        IF (sbInstanceValue IS NULL) THEN
            Or_BoInstanceActivities.getEquipmentForAsoc(tbEquipForAsoc);
            sbIndex := tbEquipForAsoc.first;
            WHILE sbIndex IS NOT NULL LOOP

                IF tbEquipForAsoc(sbIndex).nuOrderActivityId = inuOrderActivityId THEN
                    sbInstanceValue := tbEquipForAsoc(sbIndex).sbSerie;
                    ut_trace.trace('Equipo instanciado por ORLOL - obInstanceValue '||sbInstanceValue, 2 );

                    EXIT;
                END IF;

                sbIndex := tbEquipForAsoc.NEXT(sbIndex);
            END LOOP;
        END IF;

        -- Si no se obtuvo ningun valor se muestra error
        IF sbInstanceValue IS NULL THEN
            ge_boerrors.SetErrorCodeArgument(cnuERR_9511, ge_bcattributes.csbAssociateEquipment||', '||or_boconstants.cnuINSTALAR_SERIADO||' y '||or_boconstants.cnuRECUPERAR_SERIADO);
        ELSE
            orcSerialItem := GE_BCItemsSeriado.frcSerialItemBySerie(sbInstanceValue);
        END IF;

        -- Si el componente se va ha asociar
        IF (isbIsToAssoc = GE_BOItemsConstants.csbSealActionInstall) THEN

            -- Se valida que el estado este disponible y su estado tecnico
            -- sea diferente a da?ado
            if(ge_bcitemsseriado.fblValidateItem(isbSerie)) THEN
                ge_boerrors.SetErrorCodeArgument(cnuERR_901056, isbSerie);
            END IF;
        -- Si el componente se va a retirar
        ELSIF(isbIsToAssoc = GE_BOItemsConstants.csbSealActionRemove) THEN
            -- Si el sello no esta asociado a medidor y ademas el sello no se encuentra
            -- en la tabla de errores entonces se muestra mensaje de error
            IF (    ge_bcitems.fsbIsSealAssocToMeter(nuItemSeriadoId, orcSerialItem.Id_Items_Seriado) = or_boconstants.csbNO
                AND
                    not tbSerialError.exists(isbSerie)
                ) THEN
                ut_trace.trace('fsbIsSealAssocToMeter = '||or_boconstants.csbNO||' isbSerie: '||isbSerie, 2 );
                tbSerialError(isbSerie).SealSerie := isbSerie;
                ge_boerrors.SetErrorCodeArgument(cnuERR_901047,isbSerie||'|'||sbInstanceValue);
            END IF;

            IF(dage_items_seriado.fblExist(nuItemSeriadoId))THEN
                ut_trace.trace('el item seriado '||to_char(nuItemSeriadoId)||' Existe', 2 );
                -- Se valida que el estado del item seriado sea "En uso"
                IF (GE_BCItemsSeriado.fsbValItemUseState(nuItemSeriadoId) = or_boconstants.csbNO) THEN
                    ge_boerrors.SetErrorCodeArgument(cnuERR_901056, isbSerie);
                END IF;
            END IF;
        END IF;

        ut_trace.trace('FIN OR_BOActivitiesLegalizeByFile.ValAssoSealComp', 2 );

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ValAssoSealComp;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ValidInitDataToLegalByFile
    Descripcion    : Valida los datos iniciales del proceso de legalizacion por
                     linea de texto
    Autor          : Carlos Eduardo Navia
    Fecha          : 23-07-2012

    Parametros
        Entrada
            isbDataOrder    Linea de texto con los datos de la legalizacion
            idtInitDate     Fecha en la que se inicio la ejecucion del trabajo
            idtFinalDate    Fecha en la que se finalizo la ejecucion del trabajo
        Salida
            osbIsAdminOrder Variable para saber si una orden es administrativa o no

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    ==========  ================        ====================
    23-07-2012  cenaviaSAO186451        Creacion
    ******************************************************************/
    PROCEDURE ValidInitDataToLegalByFile
    (
        isbDataOrder        IN  varchar2,
        idtInitDate         IN  or_order.exec_initial_date%type,
        idtFinalDate        IN  or_order.execution_final_date%type,
        osbIsAdminOrder     OUT VARCHAR2,
        onuOrderId          OUT OR_order.order_id%type,
        onuPersonId         OUT ge_person.person_id%type,
        onuCausalId         OUT OR_order.causal_id%type,
        onuOperUnitId       OUT OR_operating_unit.operating_unit_id%type,
        otbLine             OUT UT_String.TyTb_String,
        onuErrorCode        OUT ge_error_log.error_log_id%type,
        osbErrorMessage     OUT ge_error_log.description%type
    )
    IS
        nulinenumber        constant number(1) := 1;
        nuMAX_COLUMN        number(2) := 8;
        nuMAX_COLUMN_ADM    number(2) := 3;
    BEGIN
        ut_trace.trace('INICIO OR_BOActivitiesLegalizeByFile.ValidInitDataToLegalByFile', 2 );

        -- Se valida la linea de texto a procesar y se cargan los datos para la
        -- legalizacion
        or_boactivitieslegalizebyfile.LoadAndValidInitialData
            (
                isbDataOrder,
                nulinenumber,
                onuOrderId,
                onuCausalId,
                onuPersonId,
                otbline,
                onuErrorCode,
                osbErrorMessage
            );

        -- Si este metodo retorna algun error, este se levanta
        if onuErrorCode <> 0 then
            raise ex.CONTROLLED_ERROR;
        END if;

        -- Se obtiene la unidad de trabajo
        onuOperUnitId := daor_order.fnugetoperating_unit_id(onuOrderId);

        -- Se valida si la orden es administrativa, de ser asi se inicializa la
        -- variable de salida con 'Y', de lo contrario se valida el estado de la
        -- orden a procesar y se inicializa la variable de salida con 'N'
        osbIsAdminOrder := Or_BcOrderActivities.fsbIsAdminOrder(onuorderId);
        -- Si la orden es administrativa
        if ((otbLine.count = nuMAX_COLUMN_ADM) and
            (osbIsAdminOrder = ge_boconstants.csbYES)) THEN
            osbIsAdminOrder := ge_boconstants.csbYES;
        elsif ((otbLine.count = nuMAX_COLUMN) AND (osbIsAdminOrder != ge_boconstants.csbYES)) then
            -- Se valida el estado de la orden a legalizar.
            OR_BSFWLegalizeOrder.ValidateStatusLegalize (onuOrderId, onuErrorCode, osbErrorMessage);
            if onuErrorCode <> 0 then
                raise ex.CONTROLLED_ERROR;
            END if;
        else
             -- Archivo con estructura invalida
             errors.SetError(cnuERR_UNSTRUCTURED_FILE, nulinenumber);
             raise ex.CONTROLLED_ERROR;
        end if;

        -- Se valida que la fecha de inicio de ejecucion no sea mayor a la fecha
        -- final de ejecucion, y que la fecha final no sea mayor a la fecha actual
        --del sistema
        OR_BOFWLegalizeOrder.ValidateFinalDate
            (
                idtInitDate,
                idtFinalDate
            );

        ut_trace.trace('FIN OR_BOActivitiesLegalizeByFile.ValidInitDataToLegalByFile', 2 );
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ValidInitDataToLegalByFile;


    /*************************************************
    Metodo  	:   fblGetIsLegalByFile
    Descripcion	:   Retorna si esta ejecutando legalizacion masiva
                    por archivo plano.
    ============  	===================

    Autor		: FSaldana
    Fecha		: 22-Ago-2     014

    Historia de Modificaciones
    Fecha	    Autor	   Modificacion
    =====       =====  ====================
    22-Ago-2014 FSaldana  SAO265233 Creacion
    *************************************************/
    FUNCTION   fblGetIsLegalByFile
    return boolean
    IS

    BEGIN
        ut_trace.trace('INICIO OR_BOActivitiesLegalizeByFile.fblGetIsLegalByFile', 2 );
        ut_trace.trace('FIN OR_BOActivitiesLegalizeByFile.fblGetIsLegalByFile', 2 );
        return gblIsLegalizeByFile;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fblGetIsLegalByFile;

    /*************************************************
    Metodo  	:   SetOrderUsedCapacity
    Descripcion	:   Registra la capacidad usada por la orden actual.
    ============  	===================
    Parametros
        Entrada
            inuUsedCapacity    Tiempo usado por la orden

    Autor		: FSaldana
    Fecha		: 22-Ago-2014

    Historia de Modificaciones
    Fecha	    Autor	   Modificacion
    =====       =====  ====================
    22-Ago-2014 FSaldana  SAO265233 Creacion
    *************************************************/
    PROCEDURE   SetOrderUsedCapacity
    (
        inuUsedCapacity in  number
    )
    IS

    BEGIN
        ut_trace.trace('INICIO OR_BOActivitiesLegalizeByFile.SetOrderUsedCapacity inuUsedCapacity = '||inuUsedCapacity, 2 );

        gnuOrderUsedCapacity := inuUsedCapacity;

        ut_trace.trace('FIN OR_BOActivitiesLegalizeByFile.SetOrderUsedCapacity', 2 );
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END SetOrderUsedCapacity;


END OR_BOActivitiesLegalizeByFile;
