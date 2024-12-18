CREATE OR REPLACE PROCEDURE      LDC_PRCREAPLANTNOTI (nuOrder          in  or_order.order_id%type,
                                                 sbInCadenaXLS    in  clob)
IS

     /*******************************************************************************
     Metodo:       LDC_PRCREAPLANTNOTI
     Descripcion:  Procedimiento que se encarga crear el arhivo html recibiendo la cadena de texto
                   como codigo html y creando un archivo en el servidor con la plantilla html llena con
                   los datos de los cursores.
     Fecha:        04/05/2020

     Historia de Modificaciones
     FECHA            AUTOR                       DESCRIPCION
     04/05/2020        Miguel Ballesteros            Creacion de procedimiento LDC_PRCREAPLANTNOTI caso 71
    *******************************************************************************/

    CURSOR CUGETDATA_EMPRESA_VENTAS IS
        SELECT  SISTEMPR NOMBRE_EMPRESA,
                SISTNITC NIT,
                O.ORDER_ID  ORDEN_APOYO
        FROM OPEN.SISTEMA,
             OPEN.OR_ORDER O
        WHERE O.ORDER_ID = nuOrder;


    CURSOR CUGETNOTI_SERVICIOS_VENTAS IS
        SELECT  O.ORDER_ID NO_ORDEN_TRAB,
                OP.OPERATING_UNIT_ID||'-'||U.NAME UNIDAD_TRABAJO,
                O.TASK_TYPE_ID||'-'||T.DESCRIPTION TIPO_TRAB,
                OP.OPERATING_SECTOR_ID||'-'||OS.DESCRIPTION SECTOR_OPERATIVO,
                OPEN.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(O.ADDRESS_ID,NULL)||'-'||OPEN.DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION(OPEN.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(O.ADDRESS_ID,NULL),NULL) LOCALIDAD,
                OPEN.DAGE_GEOGRA_LOCATION.FNUGETGEO_LOCA_FATHER_ID(OPEN.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(O.ADDRESS_ID,NULL),NULL)||'-'||
                OPEN.DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION(OPEN.DAGE_GEOGRA_LOCATION.FNUGETGEO_LOCA_FATHER_ID(OPEN.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(O.ADDRESS_ID,NULL),NULL),NULL) DEPARTAMENTO,
                OPEN.DAOR_ORDER.FDTGETASSIGNED_DATE(O.ORDER_ID) FECHA_ASIGNACION
        FROM OPEN.OR_ORDER_ACTIVITY O,
             OPEN.OR_OPERATING_UNIT U,
             OPEN.OR_TASK_TYPE T,
             OPEN.OR_OPERATING_SECTOR OS,
             OPEN.OR_ORDER OP,
             OPEN.OR_RELATED_ORDER OD
        WHERE OP.OPERATING_UNIT_ID         = U.OPERATING_UNIT_ID
          AND O.ORDER_ID                   = OP.ORDER_ID
          AND O.TASK_TYPE_ID               = T.TASK_TYPE_ID
          AND OP.OPERATING_SECTOR_ID       = OS.OPERATING_SECTOR_ID
          AND O.TASK_TYPE_ID                <> 0
          AND O.ORDER_ID                   = OD.ORDER_ID
          AND OD.RELATED_ORDER_ID          = nuOrder
          OR  OP.OPERATING_UNIT_ID         = U.OPERATING_UNIT_ID
          AND O.ORDER_ID                   = OP.ORDER_ID
          AND O.TASK_TYPE_ID               = T.TASK_TYPE_ID
          AND OP.OPERATING_SECTOR_ID       = OS.OPERATING_SECTOR_ID
          AND O.TASK_TYPE_ID                <> 0
          AND O.ORDER_ID                   = OD.RELATED_ORDER_ID
          AND OD.ORDER_ID                  = nuOrder;


    CURSOR CUGETDATOS_CLIENTE_SERV_VENTAS IS
        SELECT  B.PACKAGE_ID||' - '||DAPS_PACKAGE_TYPE.FSBGETDESCRIPTION(DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(B.PACKAGE_ID,NULL),NULL) NO_SOLICITUD,
                B.ACTIVITY_ID ||' - '||DAGE_ITEMS.FSBGETDESCRIPTION(B.ACTIVITY_ID,NULL) ACTIVIDAD,
                (SELECT DISTINCT ROUND(MONTHS_BETWEEN(SYSDATE, PC.REGISTER_DATE)) FROM PR_CERTIFICATE PC WHERE PC.PRODUCT_ID = B.PRODUCT_ID
                AND PC.REGISTER_DATE = (SELECT MAX(PC1.REGISTER_DATE) FROM PR_CERTIFICATE PC1 WHERE PC1.PRODUCT_ID = B.PRODUCT_ID)) MESES_RP_TRASNCURRIDO,
                (SELECT SSS.SESUESCO||' - '||DAESTACORT.FSBGETESCODESC(SSS.SESUESCO) FROM OPEN.SERVSUSC SSS WHERE SSS.SESUNUSE=B.PRODUCT_ID) ESTADO_CORTE,
                DAMO_PACKAGES.FDTGETREQUEST_DATE(DAOR_ORDER_ACTIVITY.FNUGETPACKAGE_ID(B.ORDER_ACTIVITY_ID,NULL),NULL) FECHA_SOLICITUD,
                DAOR_ORDER_ACTIVITY.FNUGETSUBSCRIPTION_ID(B.ORDER_ACTIVITY_ID)||'-'||
                E.SUBSCRIBER_NAME||' '||E.SUBS_LAST_NAME COD_SUSCRIPCION,
                E.PHONE TELEFONO,
                E.IDENTIFICATION IDENTIFICACION,
                DAAB_ADDRESS.FSBGETADDRESS(S.SUSCIDDI)||' '||
                OPEN.DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION(OPEN.DAAB_ADDRESS.FNUGETNEIGHBORTHOOD_ID(S.SUSCIDDI,NULL)) DIRECCION,
                LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('SERVSUSC','SESUSUSC','SESUCATE', B.SUBSCRIPTION_ID)||'-'||
                LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('CATEGORI','CATECODI','CATEDESC',
                LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('SERVSUSC','SESUSUSC','SESUCATE', B.SUBSCRIPTION_ID)) CATEGORIA,
                LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('SERVSUSC','SESUSUSC','SESUSUCA', B.SUBSCRIPTION_ID)||'-'||
                LDC_BOUTILITIES.FSBGETVALORCAMPOSTABLA('SUBCATEG','SUCACATE','SUCADESC',
                LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('SERVSUSC','SESUSUSC','SESUCATE', B.SUBSCRIPTION_ID),'SUCACODI',
                LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('SERVSUSC','SESUSUSC','SESUSUCA', B.SUBSCRIPTION_ID)) ESTRATO,
                DAPR_PRODUCT.FNUGETPRODUCT_STATUS_ID(B.PRODUCT_ID,NULL)||'-'||DAPS_PRODUCT_STATUS.FSBGETDESCRIPTION(DAPR_PRODUCT.FNUGETPRODUCT_STATUS_ID(B.PRODUCT_ID,NULL),NULL) ESTADO,
                DAAB_PREMISE.FNUGETPREMISE_TYPE_ID(DAAB_ADDRESS.FNUGETESTATE_NUMBER(S.SUSCIDDI,NULL),NULL)||'-'||
                DAAB_PREMISE_TYPE.FSBGETDESCRIPTION(DAAB_PREMISE.FNUGETPREMISE_TYPE_ID(DAAB_ADDRESS.FNUGETESTATE_NUMBER(S.SUSCIDDI,NULL),NULL),NULL) TIPO_PREDIO,
                LDC_FSBGETORDERCOMENTS(B.ORDER_ID,B.PACKAGE_ID,DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(B.PACKAGE_ID)) OBSERVACION,
                OPEN.LDC_BONOTIFICACIONES.FSBNUMMEDIDOR(B.SUBSCRIPTION_ID) MEDIDOR,
                OPEN.LDC_BONOTIFICACIONES.GETMARCA_MEDIDOR(B.SUBSCRIPTION_ID)MARCA_MEDIDOR,
                OPEN.LDC_BONOTIFICACIONES.GETULTIMALECTURA(B.ORDER_ID)ULTIMA_LECTURA,
                OPEN.LDC_BONOTIFICACIONES.FNUGETPRESIONMEDICION(B.SUBSCRIPTION_ID) PRESION, B.PRODUCT_ID PRODUCTO,
                OPEN.DAOR_ORDER.FDTGETARRANGED_HOUR(B.ORDER_ID,NULL) HORA_ACORDADA
        FROM  OR_ORDER_ACTIVITY B,
              GE_SUBSCRIBER E,
              OPEN.OR_RELATED_ORDER OD,
              OPEN.SUSCRIPC S
        WHERE S.SUSCCLIE       = E.SUBSCRIBER_ID
        AND   B.ORDER_ID      = OD.ORDER_ID
        AND   S.SUSCCODI      = B.SUBSCRIPTION_ID
        AND   OD.RELATED_ORDER_ID          = nuOrder
        UNION
        SELECT NULL A,NULL B,NULL C,NULL D,NULL E,NULL F,NULL G,NULL H,
        NULL I,NULL J,NULL K,NULL L,NULL M,LDC_BONOTIFICACIONES.FSBGETCOMMENTRPASOCIADOS(OA.ORDER_ID)||'//'||LDC_REPORTESCONSULTA.FSBOBSERVACIONOT(OA.ORDER_ID) OBSERVACION,
        NULL N,NULL O,NULL P,NULL Q,
        NULL R,NULL S
        FROM  OR_ORDER_ACTIVITY OA, OPEN.OR_RELATED_ORDER OD WHERE   OD.RELATED_ORDER_ID = nuOrder  AND OA.ORDER_ID= OD.ORDER_ID
        AND OA.TASK_TYPE_ID IN (SELECT TO_NUMBER(COLUMN_VALUE) FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.FSBGETVALUE_CHAIN('TIPO_TRABAJO_AUTONOMAS',NULL),',')));


    nuCaso                    varchar2(30):='0000071';
    sbCadenaXLS            CLOB;

    InfoVentaEmpre        CUGETDATA_EMPRESA_VENTAS%ROWTYPE;
    InfoVentaServi        CUGETNOTI_SERVICIOS_VENTAS%ROWTYPE;
    InfoVentaClient        CUGETDATOS_CLIENTE_SERV_VENTAS%ROWTYPE;
    v_archivo           UTL_FILE.FILE_TYPE;
    v_seq               NUMBER;
    sbNombreArchivo     VARCHAR2(100):= 'NOTIF_OT_SERV_INGEN_';
    sbruta                 VARCHAR2(100):= OPEN.DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_PARRUTAORDVENTHTML',NULL);

BEGIN

   IF fblAplicaEntregaxCaso(nuCaso)THEN

       ut_trace.trace('Inicia LDC_PRCREAPLANTNOTI', 10);

        -- se realizan las consultas para obtener la informacion a reemplazar en la plantilla
           OPEN CUGETDATA_EMPRESA_VENTAS;
           FETCH CUGETDATA_EMPRESA_VENTAS INTO InfoVentaEmpre;
           CLOSE CUGETDATA_EMPRESA_VENTAS;

           OPEN CUGETNOTI_SERVICIOS_VENTAS;
           FETCH CUGETNOTI_SERVICIOS_VENTAS INTO InfoVentaServi;
           CLOSE CUGETNOTI_SERVICIOS_VENTAS;

           OPEN CUGETDATOS_CLIENTE_SERV_VENTAS;
           FETCH CUGETDATOS_CLIENTE_SERV_VENTAS INTO InfoVentaClient;
           CLOSE CUGETDATOS_CLIENTE_SERV_VENTAS;

           sbCadenaXLS := sbInCadenaXLS;

        -- el reemplazo de los valores se toma de una consulta que me trae cada dato y se reemplaza los tags del template del mensaje completo
           sbCadenaXLS := replace(sbCadenaXLS, '&nbsp;',                      '');
           sbCadenaXLS := replace(sbCadenaXLS, '<col width="165">',          '');
           sbCadenaXLS := replace(sbCadenaXLS, '<col width="68">',          '');
           sbCadenaXLS := replace(sbCadenaXLS, '<col width="65">',          '');
           sbCadenaXLS := replace(sbCadenaXLS, '<col width="209">',          '');
           sbCadenaXLS := replace(sbCadenaXLS, '<col width="202">',          '');
           sbCadenaXLS := replace(sbCadenaXLS, '<col width="281">',          '');

           sbCadenaXLS := replace(sbCadenaXLS, '  <tr>
    <td colspan = "2" class="Estilo35"><SIMPLE ELEMENT=LDC_DATA_EMPRESA_VENTAS | NAME=TEMPLATE1></td>
  </tr>',    '');

           sbCadenaXLS := replace(sbCadenaXLS, '  <tr height="22">
    <td height="22" colspan="6" class="Estilo35"><SIMPLE ELEMENT=LDC_NOTI_SERVICIOS_VENTAS|NAME=TEMPLATE2></td>
  </tr>',                      '');

           sbCadenaXLS := replace(sbCadenaXLS, '  <tr height="22">
    <td height="22" colspan="5" class="Estilo35"><SIMPLE ELEMENT=LDC_NOTIFI_DATOS_CLIENTE_SERV_VENTAS|NAME=TEMPLATE3></td>
  </tr>',                      '');
           -- con este codigo se eliminan las tildes de la cadena --
           sbCadenaXLS := translate(sbCadenaXLS, 'aeiouAEIOU',          'aeiouAEIOU');

           sbCadenaXLS := replace(sbCadenaXLS, '<NOMBRE_EMPRESA>',          InfoVentaEmpre.NOMBRE_EMPRESA);
           sbCadenaXLS := replace(sbCadenaXLS, '<NIT>',                     InfoVentaEmpre.NIT);
           sbCadenaXLS := replace(sbCadenaXLS, '<ORDEN_APOYO>',             InfoVentaEmpre.ORDEN_APOYO);
           sbCadenaXLS := replace(sbCadenaXLS, '<DEPARTAMENTO>',             InfoVentaServi.DEPARTAMENTO);
           sbCadenaXLS := replace(sbCadenaXLS, '<LOCALIDAD>',                 InfoVentaServi.LOCALIDAD);
           sbCadenaXLS := replace(sbCadenaXLS, '<SECTOR_OPERATIVO>',        InfoVentaServi.SECTOR_OPERATIVO);
           sbCadenaXLS := replace(sbCadenaXLS, '<NO_ORDEN_TRAB>',             InfoVentaServi.NO_ORDEN_TRAB);
           sbCadenaXLS := replace(sbCadenaXLS, '<TIPO_TRAB>',                 InfoVentaServi.TIPO_TRAB);
           sbCadenaXLS := replace(sbCadenaXLS, '<UNIDAD_TRABAJO>',             InfoVentaServi.UNIDAD_TRABAJO);
           sbCadenaXLS := replace(sbCadenaXLS, '<FECHA_ASIGNACION>',         InfoVentaServi.FECHA_ASIGNACION);
           sbCadenaXLS := replace(sbCadenaXLS, '<NO_SOLICITUD>',             InfoVentaClient.NO_SOLICITUD);
           sbCadenaXLS := replace(sbCadenaXLS, '<FECHA_SOLICITUD>',         InfoVentaClient.FECHA_SOLICITUD);
           sbCadenaXLS := replace(sbCadenaXLS, '<ACTIVIDAD>',                 InfoVentaClient.ACTIVIDAD);
           sbCadenaXLS := replace(sbCadenaXLS, '<MESES_RP_TRASNCURRIDO>',     InfoVentaClient.MESES_RP_TRASNCURRIDO);
           sbCadenaXLS := replace(sbCadenaXLS, '<COD_SUSCRIPCION>',         InfoVentaClient.COD_SUSCRIPCION);
           sbCadenaXLS := replace(sbCadenaXLS, '<IDENTIFICACION>',             InfoVentaClient.IDENTIFICACION);
           sbCadenaXLS := replace(sbCadenaXLS, '<DIRECCION>',                 InfoVentaClient.DIRECCION);
           sbCadenaXLS := replace(sbCadenaXLS, '<TELEFONO>',                 InfoVentaClient.TELEFONO);
           sbCadenaXLS := replace(sbCadenaXLS, '<CATEGORIA>',                 InfoVentaClient.CATEGORIA);
           sbCadenaXLS := replace(sbCadenaXLS, '<PRESION>',                 InfoVentaClient.PRESION);
           sbCadenaXLS := replace(sbCadenaXLS, '<ESTADO>',                     InfoVentaClient.ESTADO);
           sbCadenaXLS := replace(sbCadenaXLS, '<TIPO_PREDIO>',             InfoVentaClient.TIPO_PREDIO);
           sbCadenaXLS := replace(sbCadenaXLS, '<MEDIDOR>',                 InfoVentaClient.MEDIDOR);
           sbCadenaXLS := replace(sbCadenaXLS, '<MARCA_MEDIDOR>',             InfoVentaClient.MARCA_MEDIDOR);
           sbCadenaXLS := replace(sbCadenaXLS, '<PRODUCTO>',                 InfoVentaClient.PRODUCTO);
           sbCadenaXLS := replace(sbCadenaXLS, '<HORA_ACORDADA>',             InfoVentaClient.HORA_ACORDADA);
           sbCadenaXLS := replace(sbCadenaXLS, '<OBSERVACION>',             InfoVentaClient.OBSERVACION);

           -- se realiza el proceso de la creacion del archivo .html --
           v_seq       := SEQ_LDCORDVENHTML.NEXTVAL;
           v_archivo   := UTL_FILE.FOPEN (sbruta, sbNombreArchivo||v_seq||'.html', 'W');

           UTL_FILE.PUT_LINE(v_archivo, sbCadenaXLS);
           UTL_FILE.FCLOSE(v_archivo);


            --LOGPRUEBA(sbCadenaXLS);

       ut_trace.trace('Finaliza LDC_PRCREAPLANTNOTI', 10);

    END IF;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END;
/
