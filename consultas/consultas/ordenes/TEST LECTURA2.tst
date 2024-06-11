PL/SQL Developer Test script 3.0
203
DECLARE
        isbEquipmentReads   varchar2(4000):='K-2367178-13;1=419=T===';
        inuPosition         number:=1;
        tbEquipmentReads    ut_string.TyTb_String;

        tbReads             ut_string.TyTb_String;

        tbDataRecord        ut_string.TyTb_String;

        nuItemSeriadoId     ge_items_seriado.id_items_seriado%type;

        rcItemsSeriado      dage_items_seriado.styGE_items_seriado;

        nuItemsGamaID       ge_items_gama_item.id_items_gama%type;

        nuIndexRead         number;
        
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

    BEGIN

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
    END;
0
0
