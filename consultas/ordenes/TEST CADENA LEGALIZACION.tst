PL/SQL Developer Test script 3.0
305
declare

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
    
    SUBTYPE STYSIZELINE           IS         VARCHAR2(32000);
        isbLine         varchar2(4000):='115757725|9322|15992||151195070>1;;;;||K-2367178-13;1=419=T===|1277;prueba automatizacion de cambio de tipo de trabajo 11451 a 12457 pru8eba mal';
        inuLineNumber   number;
        otbLineData     UT_String.TyTb_String;

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
    END;
0
6
otbLineData.count
otbLineData(cnuCOL_ACTIVITY)
otbLineData(cnuCOL_ITEM)
otbLineData(cnuCOL_READ)
tbDataRecord(nuIndex)
csbSEPARATOR_4
