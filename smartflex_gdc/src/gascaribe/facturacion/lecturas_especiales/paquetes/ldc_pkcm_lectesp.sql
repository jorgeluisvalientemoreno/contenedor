CREATE OR REPLACE PACKAGE ldc_pkcm_lectesp
IS
    /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: LDC_PKCM_LECTESP
  Descripcion:        Gestiona las ordenes de lecturas especiales

  Autor    : Oscar Ospino P.
  Fecha    : 06-05-2016  CA 200-210

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  06-05-2016   Oscar Ospino P.        Creacion
  20-05-2016   Oscar Ospino P.        Se agrega funcion fcrultlect para devolver las ultimas 3 lecturas de
                                      presion por orden.
  23-05-2016   Oscar Ospino P.        Se agrega Funcion FcrGetLecturas para devolver las ordenes en estado
                                      5-Asignadas, 6-En Ejecución y 7-Ejecutadas.
  09-07-2016   Oscar Ospino P.        FrcDatosCritica: Se corrigen consultas para obteners datos de la critica
  22-07-2016   Oscar Ospino P.        ProInsLectura: Se mejora gestion de excepciones.
                                      ProProcesaCritica: Se cambia proceso que realiza la legalizacion de las ordenes de lectura
                                                         Adicion de Parametros para obtener la causa, Comentario y Observacion.
  05-01-2017   Oscar Ospino P.        CA 200-856: ProProcesaCritica: Se modifican parametros de fecha enviados (sysdate) al proceso
                                      de legalizacion OS_LEGALIZEORDERS para que la fecha de legalizacion sea igual a la fecha de
                                      lectura para prevenir aumento del # de dias de consumo del producto.
  27-11-2019   F.Castro.              Cambio 254 - Se modifica cursor cuData2 en progeneracritica  para que la lectura del periodo
                                      la busque solo por el tipo de lectura F (de facturacion)
  27-01-2020   HB                     Cambio 90 - Se modifica para manejar funcionalidad de los nuevos ciclos especiales (No Regulados
                                      y Telemedidos)
  21-05-2021   Horbath                CA633 (CA333): Se ajusta el servicio ProProcesaCritica y proinslectura
  20-07-2021   Horbath                CA633 (Cambio de alcance) Se modifica el servicio ProProcesaCritica para que si el tipo de trabajo no
                                      es el de lectura normal (12617) no se actualice la presion
  03-03-2022   Luis Llach R.          OSF-158 Se modifica el servicio ProInsLectura para que el volumen corregido y el volumen no corregido
                                      acepten una mayor cantidad de dígitos en la conversiónde texto a número
  16-02-2022   Horbath                CA869 - Se adiciona parametro en el proceso proprocesacritica de ultima fecha de lectura para
                                      actualizarlo en la tabla ldc_cm_lectesp_crit.
  18-02-2022   Horbath                CA869:
                                      *Se ajusta FCROBTENERCRITICAS adiciona condicion para consultar historico de criticas con periodos previos.
                                      *Se ajutsa progeneracritica, quitando parametro isbAccion pues no estaba en uso dentro de la logica del
                                      metodo
                                      *Se ajusta funcion fcrciclosparam para obtener los ciclos parametrizados para el proceso
                                      de lecturas especiales la opcion -1-Todos-
                                      *Se ajusta funcion fcrpefaciclos para que se retorne el periodo -1-Todos-
                                      cuando el ciclo que se recibe -1-Todos. Ademas, se acondiciona para
                                      que muestre los periodos de los ultimos dos a¿os
  30-06-2023   cgonzalez              OSF-1282:
                                      Se modifica el servicio proinslectura para consultar la direccion de lectura del producto y no la del contrato
                                      Se modifica el servicio fcrobtenercriticas para retornar la direccion de lectura del producto y no la del cliente
  14-07-2023   jpinedc                OSF-1309: Se modifica progeneracritica
  18-09-2023    jcatuchemvm           OSF-1440: Se ajusta los procedimientos
                                        [proinslectura]
                                        [progeneracritica]
                                        [proprocesacritica]
                                        
                                      Se agrega nueva variable global sbObservaciones para almacenar información del parámetro OBSERVACIONES_NLECTURA_LECTESP
                                      A nivel general, se elimina codigo que ya no aplica, se estandariza la traza, se eliminan esquemas de los llamados a métodos y sentencias.
                                      Se cambian definiciones de tipo de cursor pkconstante.tyrefcursor por constants_per.tyrefcursor, ut_session.getterminal y pkgeneralservices.fsbgetterminal por pkg_session.fsbgetterminal,
                                      sa_bouser.fnugetuserid por pkg_session.getuserid, ge_bopersonal.fnugetpersonid por pkg_bopersonal.fnugetpersonaid, pktblservsusc.fnugetsesuesco por pkg_bcproducto.fnuestadocorte,
                                      daor_order.fnugetorder_status_id por pkg_bcordenes.fnuobtieneestado, dage_geogra_location.fsbgetdescription por pkg_bcdirecciones.fsbgetdescripcionubicageo, dage_geogra_location.fnugetgeo_loca_father_id
                                      por pkg_bcdirecciones.fnugetubicageopadre, daab_address.fnugetgeograp_location_id por pkg_bcdirecciones.fnugetlocalidad, dald_parameter.fnugetnumeric_value por pkg_bcld_parameter.fnuobtienevalornumerico,
                                      dald_parameter.fsbgetvalue_chain por pkg_bcld_parameter.fsbobtienevalorcadena, ldc_boutilities.splitstrings por regexp_substr en casos donde no se requiera listar campos nulos
  ******************************************************************/

    sbMostrarDatosNR   VARCHAR2 (1) := 'N';

    FUNCTION fcrsplitdata (isbdata IN VARCHAR2, osberror OUT VARCHAR2)
        RETURN constants_per.tyrefcursor;

    PROCEDURE proupdatepecobypefa (osberror OUT VARCHAR2);

    PROCEDURE proinslectura (isbdatos       IN     VARCHAR2,
                             onuerrorcode      OUT NUMBER,      --numero error
                             osberror          OUT VARCHAR2);

    PROCEDURE progeneraordenes (osberror OUT VARCHAR2);

    FUNCTION frcdatoscritica (
        inuproductoid   IN     ldc_cm_lectesp.sesunuse%TYPE,
        inupericons     IN     ldc_cm_lectesp.pecscons%TYPE,
        osberror        IN OUT VARCHAR2)
        RETURN ldc_cm_lectesp_crit%ROWTYPE;

    FUNCTION frcultimaslect (
        inusesunuse   IN     ldc_cm_lectesp.sesunuse%TYPE,
        inupefacodi   IN     ldc_cm_lectesp.pefacodi%TYPE,
        osberror      IN OUT VARCHAR2)
        RETURN ldc_cm_lectesp_crit%ROWTYPE;

    FUNCTION fcrciclosparam (osberror OUT VARCHAR2)
        RETURN constants_per.tyrefcursor;

    FUNCTION fcrperiodoscriticahist (osberror OUT VARCHAR2)
        RETURN constants_per.tyrefcursor;

    FUNCTION fcrpefaciclos (inupefaciclo   IN     perifact.pefacicl%TYPE,
                            osberror          OUT VARCHAR2)
        RETURN constants_per.tyrefcursor;

    PROCEDURE proactualizapresfaco (
        inuproducto     IN     cm_vavafaco.vvfcsesu%TYPE,
        inuorden        IN     ldc_cm_lectesp_crit.order_id%TYPE,
        inupresionact   IN     cm_vavafaco.vvfcvapr%TYPE,
        inuperiocons    IN     ldc_cm_lectesp_crit.PECSCONS%TYPE,
        osberror           OUT VARCHAR2);

    PROCEDURE proprocesacritica (
        inucriticaid      IN     ldc_cm_lectesp_crit.critica_id%TYPE,
        inupresionfinal   IN     ldc_cm_lectesp_crit.presfin%TYPE,
        inulecturafinal   IN     ldc_cm_lectesp_crit.lectfin%TYPE,
        osberror          OUT VARCHAR2,
        inuObselect       IN     NUMBER DEFAULT NULL);

    PROCEDURE progeneracritica (isbAccion   IN     VARCHAR2 DEFAULT 'T',
                                osberror       OUT VARCHAR2);

    FUNCTION fcrobtenercriticas (isbAccion   IN     VARCHAR2 DEFAULT 'NP',
                                 osberror       OUT VARCHAR2)
        RETURN constants_per.tyrefcursor;

    PROCEDURE proactordenamiento (isbdatos       IN     VARCHAR2,
                                  onuerrorcode      OUT NUMBER,
                                  osberror          OUT VARCHAR2);

    PROCEDURE prodatosvalidacion (
        orfestructuratablas   OUT constants_per.tyrefcursor,
        orfdatosvalidacion    OUT constants_per.tyrefcursor,
        onuerrorcode          OUT NUMBER,
        osberrormessage       OUT VARCHAR2);

    PROCEDURE proborrarimpprevia (osberror OUT VARCHAR2);

    PROCEDURE proActualizaCritExcel (
        ocrdatosprocesados      OUT constants_per.tyrefcursor,
        isbProcParciales     IN OUT VARCHAR2                   /*Default 'N'*/
                                            ,
        osberror                OUT VARCHAR2);

    FUNCTION fsbGetCiclo (inuciclo IN servsusc.sesucicl%TYPE)
        RETURN VARCHAR2;

    FUNCTION fsbGetTipoTrab (osberror OUT VARCHAR2)
        RETURN constants_per.tyrefcursor;

    FUNCTION fsbEsTelemedido (inupecscons pericose.pecscons%TYPE)
        RETURN VARCHAR2;
END ldc_pkcm_lectesp;
/

CREATE OR REPLACE PACKAGE BODY ldc_pkcm_lectesp
IS
    ------------------------------------------------------------------------------------------------
    -- Datos de paquete
    ------------------------------------------------------------------------------------------------
    csbPaquete              CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';           -- Constante para nombre del paquete    
    csbNivelTraza           CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para este paquete. 
    csbInicio               CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin                  CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    
    gnusesion               NUMBER := USERENV ('sessionid');
    nuConsecutivo           NUMBER := 0;
    --Variables
    sbVarPresionOperacion   VARCHAR2 (50) := 'PRESION_OPERACION';
    --Observación de no lectura
    sbObservaciones         VARCHAR2 (4000) := pkg_parametros.fsbGetValorCadena('OBSERVACIONES_NLECTURA_LECTESP');
    
    
    gnuErr                  NUMBER;
    gsbErr                  VARCHAR2(4000);

    FUNCTION fcrsplitdata (isbdata IN VARCHAR2, osberror OUT VARCHAR2)
        RETURN constants_per.tyrefcursor
    IS
        /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fcrsplitdata
    Descripcion:        Toma la cadena de entrada separada por '|' y la devuelve
                        en un cursor referenciado de una sola fila.

    Autor    : Oscar Ospino P.
    Fecha    : 26-05-2016  CA 200-210

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    26-05-2016   Oscar Ospino P.        Creacion
    ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fcrsplitdata';
        cuparam     constants_per.tyrefcursor;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('isbdata    <= '||isbdata, csbNivelTraza);

        --Se abre el cursor con la consulta que separa la cadena y hace el pivot para que los datos queden en una fila.
        OPEN cuparam FOR
            SELECT *
              FROM (SELECT CASE WHEN ROWNUM >= 1 THEN ROWNUM END     idcampo,
                           COLUMN_VALUE
                      FROM TABLE (
                               ldc_boutilities.splitstrings (isbdata, '|')))
                       --Se transponen las filas en columnas
                       PIVOT (MAX (COLUMN_VALUE)
                             --Valores Columna rownum
                             FOR idcampo
                             IN (1,
                                 2,
                                 3,
                                 4,
                                 5,
                                 6,
                                 7,
                                 8,
                                 9,
                                 10,
                                 11,
                                 12,
                                 13,
                                 14,
                                 15,
                                 16,
                                 17));

        --Datos de Prueba
        --3036632|1123100|1|10-05-2016 00:00:00|16-05-2016 00:00:00|1000|||||100|||||50|N
        --1999|2999|3999|4999|5999|6999|7999|8999|9999|10999|11999|12999|13999|14999|15999|16999|17999|18999

        OPEN cuparam FOR
            SELECT CASE WHEN ROWNUM >= 1 THEN ROWNUM END     idcampo,
                   COLUMN_VALUE
              FROM TABLE (ldc_boutilities.splitstrings (isbdata, '|'));

        pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN cuparam;
        
    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr,gsbErr);
            osberror :=
                   'TERMINO CON ERROR NO CONTROLADO  '
                || ' | '
                || csbMetodo
                || CHR (10)
                || gsbErr;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END fcrsplitdata;

    PROCEDURE proupdatepecobypefa (osberror OUT VARCHAR2)
    IS
        nupercons    pericose.pecscons%TYPE;
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:   proUpdatePecobyPefa
        Descripcion:          Busca y actualiza los periodos de consumo de la tabla LDC_CM_LECTESP
                              de acuerdo al periodo de facturacion.

        Autor    : Oscar Ospino P.

        Fecha    : 28-05-2016  CA 200-210

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.             Modificacion
        -----------  -------------------   -------------------------------------
        28-05-2016   Oscar Ospino P.       Creacion
        02-07-2016   Oscar Ospino P.

        ******************************************************************/

        PRAGMA AUTONOMOUS_TRANSACTION;

        csbMetodo    CONSTANT VARCHAR2(100) := csbPaquete||'proupdatepecobypefa';                 
        nutasktype   or_order.task_type_id%TYPE;
        nupecscons   pericose.pecscons%TYPE;

        --Cursor con los registros que no tienen asignado Periodo de Consumo.
        CURSOR curegistro IS
            SELECT DISTINCT pefacodi, pecscons
              FROM ldc_cm_lectesp l
             WHERE     l.pefacodi IS NOT NULL
                   AND l.pecscons IS NULL
                   AND l.procesado = 'N';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);

        --Abro el Cursor para realizar la actualización.
        FOR rclectesp IN curegistro
        LOOP
            -- valida si ciclo es de tt especial de lecturas
            BEGIN
                SELECT tp.task_type_id, pecscons
                  INTO nutasktype, nupecscons
                  FROM LDC_CM_LECTESP_CICL  CI,
                       ldc_cm_lectesp_tpcl  tp,
                       perifact             p,
                       pericose             p2
                 WHERE     ci.pecstpci = tp.tipocicl_id
                       AND p.pefacicl = ci.pecscico
                       AND p2.pecsfecf BETWEEN p.pefafimo AND p.pefaffmo
                       AND p.pefacicl = p2.pecscico
                       AND p.pefacodi = rclectesp.pefacodi;
            EXCEPTION
                WHEN OTHERS
                THEN
                    nutasktype := NULL;
            END;

            BEGIN
                --busco el periodo de consumo asociado al periodo de facturacion del registro actual
                IF nutasktype IS NULL
                THEN
                    SELECT DISTINCT le.leempecs
                      INTO nupercons
                      FROM lectelme le
                     WHERE     le.leempefa = rclectesp.pefacodi
                           AND le.leempecs IS NOT NULL;
                ELSE
                    nupercons := nupecscons;
                END IF;

                --valido que el campo pecscons no se haya actualizado en iteracciones anteriores del cursor.
                IF rclectesp.pecscons IS NULL
                THEN
                    --Guardo el nuevo periodo de consumo a asignar.
                    rclectesp.pecscons := nupercons;

                    --Actualizo los periodos de consumo de todos los registros en la tabla LDC_CM_LECTESP
                    -- que tengan el mismo periodo de facturacion del registro actual.
                    UPDATE ldc_cm_lectesp l
                       SET l.pecscons = rclectesp.pecscons
                     WHERE     l.pefacodi = rclectesp.pefacodi
                           AND l.pecscons IS NULL;

                    --Se confirman los cambios
                    COMMIT;
                END IF;
            EXCEPTION
                WHEN OTHERS
                THEN
                    pkg_Error.setError;
                    pkg_Error.getError(gnuErr,gsbErr);                
                    osberror :=
                           'NO HAY DATOS QUE ACTUALIZAR | '
                        || ''
                        || ' | '
                        || csbMetodo
                        || '('
                        || '): '
                        || gsbErr;
                    
            END;
        END LOOP;
        
        pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr,gsbErr);          
            osberror :=
                   'NO HAY DATOS QUE ACTUALIZAR  '
                || ''
                || ' | '
                || csbMetodo
                || '('
                || '): '
                || gsbErr;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr,gsbErr);        
            osberror :=
                   'TERMINO CON ERROR NO CONTROLADO  '
                || '.'
                || ''
                || '.'
                || '('
                || '): '
                || gsbErr;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proupdatepecobypefa;

    PROCEDURE proinslectura (isbdatos       IN     VARCHAR2,
                             onuerrorcode      OUT NUMBER,
                             osberror          OUT VARCHAR2)
    IS
        /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: ProInsLectura
    Descripcion:        Inserta una un registro en la tabla LDC_CM_LECTESP

    Autor    : Oscar Ospino P.
    Fecha    : 06-05-2016  CA 200-210

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    06-05-2016   Oscar Ospino P.        Creacion
    26-05-2016   Oscar Ospino P.        Se establece como parametro de entrada una cadena concatenada con "|"
                                        con los valores a insertar
    15-06-2016   Oscar Ospino P.        Solo se dejan en 18 los campos que utiliza el pivot para transponer
                                        las columnas debido a que se quito el campo PRESCALC de la tabla LDC_CM_LECTESP.
                                        NUPASO 10.
    19-07-2016   Oscar Ospino P.        Se obtienen datos adicionales de la lectura (cliente, medidor, contrato) para
                                        insertarla en la tabla LDC_CM_LECTESP que se modifico
    22-07-2016   Oscar Ospino P.        ProInsLectura: Se mejora gestion de excepciones.
    02-08-2016   Oscar Ospino P.        ProInsLectura: Se modifica para devolver datos numericos diferentes a cero
                                        en todas las excepciones de acuerdo a reglas de validacion en integracion con
                                        dispositivos moviles.
                                        WS SIGELE detecta una operacion de insercion positiva cuando el parametro de
                                        salida onuErrorCode es 0-Exito y el resto como fallo.
    12-12-2016   Oscar Ospino P.        CA 200-856: Se validan 2 campos adicionales en LDC_CM_LECTESP: Causal y Causal_obs, los cuales son excluyentes
                                        con el campo Pres.
                                        Al parametro de entrada isbdatos se le debe concatenar estos campos al final con el separador "|".
    21-05-2021   Horbath                CA633 (CA333): Se ajusta el tamano de la variable Lectura Eagle
    03-03-2022   Luis Llach R.          OSF-158 Se actualiza el formato de casteo del to_number del volumen corregido y volumen no corregido para
                                        Que acepten mayor cantidad de digitos
    30-06-2023   cgonzalez              OSF-1282:
                                        Se modifica el servicio proinslectura para consultar la direccion de lectura del producto y no la del contrato
    18-09-2023   jcatuchemvm            OSF-1440:   
                                        Se agrega validación para nuevo campo solicitado, observación de no lectura para clientes especiales, posición 21
                                        Se elimina código que ya no aplica por aplicaentrega y los esquemas a las tablas en las consultas.
    ******************************************************************/

    /*
        Para tener en cuenta:

        1. Los campos requeridos son order_id, sesunuse, consec_ext, pefacodi, felectura, lectura, temperatura y pres
        2. Los campos con FK son order_id, sesunuse,pefacodi
        3. Index Unique: Campos order_id, sesunuse, consec_ext, pefacodi (No se debe repetir ese conjunto de datos)

        <<La cadena de los Parametros debe pasarse exactamente en este mismo orden para evitar errores>>
            order_id     NUMBER(15) not null,
            sesunuse     NUMBER(15) not null,
            consec_ext   NUMBER(15) not null,
            pecscons     NUMBER(15),
            pefacodi     NUMBER(6) not null,
            felectura    DATE not null,
            feregistro   DATE default SYSDATE,
            lectura      NUMBER(14,4) not null,
            temperatura  NUMBER(14,4) not null,
            pres         NUMBER(14,4) not null,
            presalt      NUMBER(14,4),
            presbj       NUMBER(14,4),
            volcorr      NUMBER(14,4),
            volncorr     NUMBER(14,4),
            lect_eagle   NUMBER(14,4),
            voltbat      NUMBER(14,4),
            usocons      VARCHAR2(1) default 'N',
            procesado    VARCHAR2(1) default 'N',
            causal       NUMBER(6),
            causal_obs   VARCHAR2(1000),
            observacion  NUMBER(4)
    */

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proinslectura';
        nupaso                      NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error

        --Se reemplazan comas por puntos para que los valores decimales de presion y temperatura
        --se inserten correctamente
        isbdata                     VARCHAR2 (4000) := REPLACE (isbdatos, ',', '.');
        nucampos                    NUMBER; --Numero de campos pasados en el parametro de entrada

        numero                      NUMBER (14, 4); --Validar conversion numerica
        sbmsg                       VARCHAR2 (4000);   --Descripcion del Campo
        sbmsgfinal                  VARCHAR2 (4000);
        excerror                    EXCEPTION;
        excdatosinv                 EXCEPTION;              -- Datos Invalidos
        excpefa                     EXCEPTION; -- Periodo de Facturacion invalido
        excdatoreq                  EXCEPTION;               -- Dato Requerido
        exerror                     EXCEPTION;             -- Error controlado
        exdatosinsuf                EXCEPTION; -- Cant. campos en cadena de entrada

        rclectesp                   ldc_cm_lectesp%ROWTYPE; --Record para almacenar los datos recibidos

        CURSOR cudata IS
            SELECT CASE WHEN ROWNUM >= 1 THEN ROWNUM END     idcampo,
                   COLUMN_VALUE
              FROM TABLE (ldc_boutilities.splitstrings (isbdata, '|'));

        rcdata                      cudata%ROWTYPE;

        -- CA 200-856 [Fase 2 Lecturas Industriales]
        boexistepresion             BOOLEAN;
        boexistecausalnolectura     BOOLEAN;
        --Excepcion para capturar la restriccion check
        check_constraint_violated   EXCEPTION;
        PRAGMA EXCEPTION_INIT (check_constraint_violated, -2290);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('isbdatos   <= '||isbdatos, csbNivelTraza);
        
        nupaso := 0;

        --Separo la cadena y relleno el registro.
        FOR rcdata IN cudata
        LOOP
            BEGIN
                --Cuenta la cantidad de datos /iteracciones del cursor
                nucampos := rcdata.idcampo;

                --Actualizo el paso en cada iteraccion (Campo)
                --parametro onuErrorCode sera el ultimo paso procesado antes de una excepcion
                IF osberror IS NULL
                THEN
                    nupaso := nupaso + 1;
                END IF;

                --Acciones por cada campo
                IF rcdata.idcampo = 1
                THEN
                    sbmsg := 'Orden';

                    IF rcdata.COLUMN_VALUE >= 0
                    THEN
                        rcdata.COLUMN_VALUE :=
                            TRUNC (rcdata.COLUMN_VALUE);

                        SELECT COUNT (1)
                          INTO numero
                          FROM or_order o
                         WHERE o.order_id = rcdata.COLUMN_VALUE;

                        IF numero > 0
                        THEN
                            numero := rcdata.COLUMN_VALUE;
                            rclectesp.order_id := numero;
                        ELSE
                            RAISE excdatosinv;
                        END IF;
                    ELSE
                        RAISE excdatoreq;
                    END IF;
                ELSIF rcdata.idcampo = 2
                THEN
                    sbmsg := 'Producto';

                    IF rcdata.COLUMN_VALUE >= 0
                    THEN
                        rcdata.COLUMN_VALUE :=
                            TRUNC (rcdata.COLUMN_VALUE);

                        SELECT COUNT (1)
                          INTO numero
                          FROM servsusc s
                         WHERE s.sesunuse = rcdata.COLUMN_VALUE;

                        IF numero > 0
                        THEN
                            numero := TO_NUMBER (rcdata.COLUMN_VALUE);
                            rclectesp.sesunuse := numero;
                        ELSE
                            RAISE excdatosinv;
                        END IF;
                    ELSE
                        RAISE excdatoreq;
                    END IF;
                ELSIF rcdata.idcampo = 3
                THEN
                    sbmsg := 'Consecutivo Externo';

                    IF rcdata.COLUMN_VALUE >= 0
                    THEN
                        numero := TO_NUMBER (rcdata.COLUMN_VALUE);
                        rclectesp.consec_ext := numero;
                    ELSE
                        RAISE excdatoreq;
                    END IF;
                ELSIF rcdata.idcampo = 4
                THEN
                    sbmsg := 'Periodo de Consumo';

                    BEGIN
                        SELECT COUNT (1)
                          INTO numero
                          FROM pericose p
                         WHERE p.pecscons = rcdata.COLUMN_VALUE;
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            numero := 0;
                    END;

                    IF numero > 0
                    THEN
                        numero := TO_NUMBER (rcdata.COLUMN_VALUE);
                        rclectesp.pecscons := numero;
                    ELSE
                        --No se genera error para intentar obtenerlo en la siguiente iteraccion
                        rclectesp.pecscons := NULL;
                        rcdata.COLUMN_VALUE := 'NULL'; --Descriptivo para el Output
                    END IF;
                ELSIF rcdata.idcampo = 5
                THEN
                    sbmsg := 'Periodo de Facturacion';

                    IF rcdata.COLUMN_VALUE >= 0
                    THEN
                        rcdata.COLUMN_VALUE :=
                            TRUNC (rcdata.COLUMN_VALUE);

                        SELECT COUNT (pf.pefacodi)
                          INTO numero
                          FROM perifact pf
                         WHERE pf.pefacodi = rcdata.COLUMN_VALUE;

                        IF numero > 0
                        THEN
                            numero := TO_NUMBER (rcdata.COLUMN_VALUE);
                            rclectesp.pefacodi := numero;

                            --Valida si el periodo pertenece a los ciclos de Lecturas Complementarias
                            BEGIN
                                SELECT DISTINCT COUNT (1)     cant
                                  INTO numero
                                  FROM ldc_cm_lectesp_cicl  l,
                                       ciclo                c,
                                       perifact             pf
                                 WHERE     c.ciclcico = l.pecscico
                                       AND pf.pefacicl = c.ciclcodi
                                       AND pf.pefacodi =
                                           rclectesp.pefacodi;

                                IF numero = 0
                                THEN
                                    RAISE excpefa;
                                END IF;
                            EXCEPTION
                                WHEN OTHERS
                                THEN
                                    --Periodo de Facturacion No valido
                                    --Descriptivo para el Output
                                    rcdata.COLUMN_VALUE :=
                                           TO_CHAR (rclectesp.pefacodi)
                                        || ' << No pertenece a los ciclos de Lecturas Complementarias >>';
                                    RAISE excpefa;
                            END;

                            --Buscar Periodo de Consumo si no se paso en la cadena
                            IF rclectesp.pecscons IS NULL
                            THEN
                                BEGIN
                                    SELECT DISTINCT l.leempecs
                                      INTO rclectesp.pecscons
                                      FROM lectelme l
                                     WHERE     l.leempefa =
                                               rclectesp.pefacodi
                                           AND ROWNUM = 1;
                                EXCEPTION
                                    WHEN OTHERS
                                    THEN
                                        rclectesp.pecscons := NULL;
                                END;
                            END IF;
                        ELSE
                            --Periodo de Facturacion No valido
                            RAISE excpefa;
                        END IF;
                    ELSE
                        RAISE excdatoreq;
                    END IF;
                ELSIF rcdata.idcampo = 6
                THEN
                    sbmsg := 'Fecha de Lectura';

                    IF rcdata.COLUMN_VALUE IS NOT NULL
                    THEN
                        rclectesp.felectura :=
                            TO_DATE (rcdata.COLUMN_VALUE,
                                     'dd/mm/yyyy HH24:mi:ss');
                    ELSE
                        RAISE excdatoreq;
                    END IF;
                ELSIF rcdata.idcampo = 7
                THEN
                    sbmsg := 'Fecha de Registro';
                    rclectesp.feregistro := SYSDATE;
                    rcdata.COLUMN_VALUE := SYSDATE;
                ELSIF rcdata.idcampo = 8
                THEN
                    sbmsg := 'Lectura';

                    IF rcdata.COLUMN_VALUE >= 0
                    THEN
                        numero := TRUNC (rcdata.COLUMN_VALUE);
                        rclectesp.lectura := numero;
                        rcdata.COLUMN_VALUE := rclectesp.lectura;
                    ELSE
                        RAISE excdatoreq;
                    END IF;
                ELSIF rcdata.idcampo = 9
                THEN
                    sbmsg := 'Temperatura';

                    IF rcdata.COLUMN_VALUE >= 0
                    THEN
                        rclectesp.temperatura := rcdata.COLUMN_VALUE;
                    ELSIF rcdata.COLUMN_VALUE IS NULL
                    THEN
                        rclectesp.temperatura := rcdata.COLUMN_VALUE;
                        rcdata.COLUMN_VALUE := 'NULL'; --Descriptivo para el Output
                    ELSE
                        RAISE excdatosinv;
                    END IF;
                ELSIF rcdata.idcampo = 10
                THEN
                    sbmsg := 'Presion';

                    IF rcdata.COLUMN_VALUE >= 0
                    THEN
                        rclectesp.pres := rcdata.COLUMN_VALUE;
                        boexistepresion := TRUE;
                    ELSIF rcdata.COLUMN_VALUE IS NULL
                    THEN
                        rclectesp.pres := rcdata.COLUMN_VALUE;
                        rcdata.COLUMN_VALUE := 'NULL'; --Descriptivo para el Output
                    END IF;
         
                ELSIF rcdata.idcampo = 11
                THEN
                    sbmsg := 'Presion Alta';

                    IF    rcdata.COLUMN_VALUE >= 0
                       OR rcdata.COLUMN_VALUE IS NULL
                    THEN
                        numero :=
                            TO_NUMBER (rcdata.COLUMN_VALUE, '9999.99');
                        rclectesp.presalt := numero;

                        IF rclectesp.presalt IS NULL
                        THEN
                            rcdata.COLUMN_VALUE := 'NULL'; --Descriptivo para el Output
                        END IF;
                    ELSE
                        RAISE excdatosinv;
                    END IF;
                ELSIF rcdata.idcampo = 12
                THEN
                    sbmsg := 'Presion Baja';

                    IF    rcdata.COLUMN_VALUE >= 0
                       OR rcdata.COLUMN_VALUE IS NULL
                    THEN
                        numero :=
                            TO_NUMBER (rcdata.COLUMN_VALUE, '9999.99');
                        rclectesp.presbj := numero;

                        IF rclectesp.presbj IS NULL
                        THEN
                            rcdata.COLUMN_VALUE := 'NULL'; --Descriptivo para el Output
                        END IF;
                    ELSE
                        RAISE excdatosinv;
                    END IF;
                ELSIF rcdata.idcampo = 13
                THEN
                    sbmsg := 'Volumen Corregido';
                    numero :=
                        TO_NUMBER (rcdata.COLUMN_VALUE, '9999999999.99');

                    IF numero >= 0 OR rcdata.COLUMN_VALUE IS NULL
                    THEN
                        rclectesp.volcorr := numero;

                        IF rclectesp.volcorr IS NULL
                        THEN
                            rcdata.COLUMN_VALUE := 'NULL'; --Descriptivo para el Output
                        END IF;
                    ELSE
                        RAISE excdatosinv;
                    END IF;
                ELSIF rcdata.idcampo = 14
                THEN
                    sbmsg := 'Volumen No Corregido';
                    numero :=
                        TO_NUMBER (rcdata.COLUMN_VALUE, '9999999999.99');

                    IF numero >= 0 OR rcdata.COLUMN_VALUE IS NULL
                    THEN
                        rclectesp.volncorr := numero;

                        IF rclectesp.volncorr IS NULL
                        THEN
                            rcdata.COLUMN_VALUE := 'NULL'; --Descriptivo para el Output
                        END IF;
                    ELSE
                        RAISE excdatosinv;
                    END IF;
                ELSIF rcdata.idcampo = 15
                THEN
                    sbmsg := 'Lectura Eagle';

                    IF    rcdata.COLUMN_VALUE >= 0
                       OR rcdata.COLUMN_VALUE IS NULL
                    THEN
                        numero :=
                            TO_NUMBER (rcdata.COLUMN_VALUE,
                                       '9999999999.99');
                        rclectesp.lect_eagle := numero;

                        IF rclectesp.lect_eagle IS NULL
                        THEN
                            rcdata.COLUMN_VALUE := 'NULL'; --Descriptivo para el Output
                        END IF;
                    ELSE
                        RAISE excdatosinv;
                    END IF;
                ELSIF rcdata.idcampo = 16
                THEN
                    sbmsg := 'Voltaje de Bateria';

                    IF    rcdata.COLUMN_VALUE >= 0
                       OR rcdata.COLUMN_VALUE IS NULL
                    THEN
                        numero :=
                            TO_NUMBER (rcdata.COLUMN_VALUE, '9999.99');
                        rclectesp.voltbat := numero;

                        IF rclectesp.voltbat IS NULL
                        THEN
                            rcdata.COLUMN_VALUE := 'NULL'; --Descriptivo para el Output
                        END IF;
                    ELSE
                        RAISE excdatosinv;
                    END IF;
                ELSIF rcdata.idcampo = 17
                THEN
                    sbmsg := 'Uso Consumiendo';

                    IF rcdata.COLUMN_VALUE IS NULL
                    THEN
                        --Valor por Defecto
                        rclectesp.usocons := 'F';
                        rcdata.COLUMN_VALUE := 'F';
                    ELSE
                        --Solo se valida el primer caracter de la cadena recibida
                        IF INSTR (
                               'FSY',
                               SUBSTR (UPPER (rcdata.COLUMN_VALUE), 1, 1)) >=
                           1
                        THEN
                            rclectesp.usocons := 'F';
                        ELSIF INSTR (
                                  'PN',
                                  SUBSTR (UPPER (rcdata.COLUMN_VALUE),
                                          1,
                                          1)) >=
                              1
                        THEN
                            rclectesp.usocons := 'P';
                        ELSE
                            RAISE excdatosinv;
                        END IF;
                    END IF;
                ELSIF rcdata.idcampo = 18
                THEN
                    sbmsg := 'Procesado';
                    --Coloco siempre el Flag de Procesado en N, independientemente lo que manden los moviles
                    rclectesp.procesado := 'N'; --Por defecto No Procesado
                    rcdata.COLUMN_VALUE := rclectesp.procesado;
                ELSIF rcdata.idcampo = 19
                THEN
                    sbmsg := 'Causal';

                    IF rcdata.COLUMN_VALUE IS NULL
                    THEN
                        rcdata.COLUMN_VALUE := 'NULL'; --Descriptivo para el Output
                        boexistecausalnolectura := FALSE;
                    ELSE
                        rclectesp.causal := rcdata.COLUMN_VALUE;
                        boexistecausalnolectura := TRUE;
                    END IF;
 
                ELSIF rcdata.idcampo = 20
                THEN
                    sbmsg := 'Causal_Observacion';

                    IF rcdata.COLUMN_VALUE IS NULL
                    THEN
                        rcdata.COLUMN_VALUE := 'NULL'; --Descriptivo para el Output
                    ELSE
                        rclectesp.causal_obs := rcdata.COLUMN_VALUE;
                    END IF;

                ELSIF rcdata.idcampo = 21
                THEN
                    sbmsg := 'Observacion no lectura';

                    IF rcdata.COLUMN_VALUE IS NULL
                    THEN
                        rcdata.COLUMN_VALUE := 'NULL'; --Descriptivo para el Output
                    ELSE
                        BEGIN
                            numero := TO_NUMBER (rcdata.COLUMN_VALUE);
                            
                            --Validación obselect
                            IF ldc_bcConsGenerales.fsbValorColumna('OBSELECT','OBLECODI','OBLECODI',numero) IS NULL THEN
                                sbmsg := sbmsg||' no existe ';
                                RAISE excdatosinv;
                            END IF;    
                            --Asignación observación no lectura validada
                            rclectesp.observacion := numero;
                            
                        EXCEPTION 
                            WHEN excdatosinv THEN
                                RAISE;
                            WHEN OTHERS THEN
                                RAISE excerror;
                        END;
                        
                    END IF;
                ELSE
                    sbmsg := '*** No Requerido *** ';

                    IF rcdata.COLUMN_VALUE IS NULL
                    THEN
                        rcdata.COLUMN_VALUE := 'NULL'; --Descriptivo para el Output
                    END IF;
                END IF;

                --Variable para mostrar el registro de la insercion en el Output.
                sbmsgfinal :=
                       sbmsgfinal
                    || CHR (10)
                    || 'CAMPO: '
                    || LPAD (rcdata.idcampo, 2)
                    || ' - '
                    || RPAD (sbmsg, 33)
                    || ' | VALOR: '
                    || RPAD (rcdata.COLUMN_VALUE, 25)
                    || ' | '
                    || 'OK';

            EXCEPTION
                WHEN excdatoreq
                THEN
                    onuerrorcode := nupaso;
                    osberror :=
                           'CAMPO: '
                        || LPAD (rcdata.idcampo, 2)
                        || ' - '
                        || RPAD (sbmsg, 33)
                        || ' | VALOR: '
                        || RPAD (rcdata.COLUMN_VALUE, 25)
                        || ' | '
                        || '*** ERROR: DATO REQUERIDO ***';
                    sbmsgfinal := sbmsgfinal || CHR (10) || osberror;
                WHEN excerror
                THEN
                    onuerrorcode := nupaso;
                    osberror :=
                           'CAMPO: '
                        || LPAD (rcdata.idcampo, 2)
                        || ' - '
                        || RPAD (sbmsg, 33)
                        || ' | VALOR: '
                        || RPAD (rcdata.COLUMN_VALUE, 25)
                        || ' | '
                        || '*** ERROR DE CONVERSION DE DATOS ***';
                    sbmsgfinal := sbmsgfinal || CHR (10) || osberror;
                WHEN excpefa
                THEN
                    onuerrorcode := nupaso;
                    osberror :=
                           'CAMPO: '
                        || LPAD (rcdata.idcampo, 2)
                        || ' - '
                        || RPAD (sbmsg, 33)
                        || ' | VALOR: '
                        || RPAD (rcdata.COLUMN_VALUE, 65)
                        || ' | '
                        || '*** ERROR: PERIODO NO VALIDO ***';
                    sbmsgfinal := sbmsgfinal || CHR (10) || osberror;
                WHEN excdatosinv
                THEN
                    onuerrorcode := nupaso;
                    osberror :=
                           'CAMPO: '
                        || LPAD (rcdata.idcampo, 2)
                        || ' - '
                        || RPAD (sbmsg, 33)
                        || ' | VALOR: '
                        || RPAD (rcdata.COLUMN_VALUE, 25)
                        || ' | '
                        || '*** ERROR: DATOS INVALIDOS ***';
                    sbmsgfinal := sbmsgfinal || CHR (10) || osberror;
                WHEN OTHERS
                THEN
                    pkg_Error.setError;
                    pkg_Error.getError(gnuErr, gsbErr);   
                    onuerrorcode := nupaso;
                    osberror :=
                           'CAMPO: '
                        || LPAD (rcdata.idcampo, 2)
                        || ' - '
                        || RPAD (sbmsg, 33)
                        || ' | VALOR: '
                        || RPAD (rcdata.COLUMN_VALUE, 25)
                        || ' | '
                        || '*** ERROR DE CONVERSION DE DATOS *** '||gsbErr;
                    sbmsgfinal := sbmsgfinal || CHR (10) || osberror;
            END;
        END LOOP;

        --Se valida la cantidad de campos de la cadena de entrada
        IF nucampos < 20
        THEN
            RAISE exdatosinsuf;
        END IF;


        --Se adiciona el contrato, medidor y nombre del cliente
        IF rclectesp.sesunuse IS NOT NULL AND osberror IS NULL
        THEN
            nupaso := 30;

            BEGIN
                SELECT pr.subscription_id         contrato,
                          gs.subscriber_id
                       || '-'
                       || gs.subs_last_name
                       || ' '
                       || gs.subscriber_name      cliente,
                       (SELECT z.emsscoem
                          FROM elmesesu z
                         WHERE     z.emsssesu = pr.product_id
                               AND (   z.emssfere IS NULL
                                    OR z.emssfere > SYSDATE)
                               AND ROWNUM = 1)    medidor
                  INTO rclectesp.contrato,
                       rclectesp.cliente,
                       rclectesp.medidor
                  FROM ge_subscriber  gs,
                       pr_product     pr,
                       suscripc       s
                 WHERE     pr.subscription_id = s.susccodi
                       AND s.suscclie = gs.subscriber_id
                       AND pr.product_type_id = 7014
                       AND pr.product_id = rclectesp.sesunuse;

                --Se obtienen los identificadores de Suscriptor y Direccion
                nupaso := 31;
                
                SELECT gs.subscriber_id, pr.address_id
                  INTO rclectesp.subscriber_id, rclectesp.address_id
                  FROM suscripc       contr,
                       servsusc       serv,
                       ge_subscriber  gs,
                       ab_address     ad,
                       pr_product     pr
                 WHERE     sesunuse = rclectesp.sesunuse
                       AND serv.sesususc = contr.susccodi
                       AND contr.suscclie = gs.subscriber_id
                       AND sesunuse = pr.product_id
                       AND pr.address_id = ad.address_id;
            EXCEPTION
                WHEN OTHERS
                THEN
                    --Devuelvo el Numero de Error
                    onuerrorcode := nupaso;
                    pkg_Error.setError;
                    pkg_Error.getError(gnuErr, gsbErr);

                    IF rclectesp.contrato IS NULL
                    THEN
                        osberror :=
                            'NO SE PUDO OBTENER EL NUMERO DE CONTRATO: ' || gsbErr;
                    ELSIF rclectesp.cliente IS NULL
                    THEN
                        osberror :=
                            'NO SE PUDO OBTENER EL NOMBRE DEL CLIENTE: ' || gsbErr;
                    ELSIF rclectesp.medidor IS NULL
                    THEN
                        osberror :=
                            'NO SE PUDO OBTENER EL NUMERO DEL MEDIDOR: ' || gsbErr;
                    ELSE
                        osberror := 'Error No Controlado: ' || gsbErr;
                    END IF;

                    pkg_traza.trace (
                           'ERROR: '
                        || ''
                        || ' | '
                        || '.'
                        || csbMetodo
                        || '('
                        || nupaso
                        || '): '
                        || CHR (10)
                        || osberror,  csbNivelTraza);
            END;
        ELSE
            RAISE exerror;
        END IF;

        --Se inserta el registro en la tabla si no hay errores
        IF osberror IS NULL
        THEN
            BEGIN
                nupaso := 40;
                pkg_traza.trace (
                       'Insertando registros en la tabla. | '
                    || ''
                    || ' | '
                    || csbMetodo, csbNivelTraza);

                INSERT INTO ldc_cm_lectesp
                     VALUES rclectesp;

                COMMIT;

                --(Validacion en Dispositivos Moviles) | onuerrorcode 0-Exito
                onuerrorcode := 0;

            EXCEPTION
                WHEN OTHERS
                THEN
                    pkg_traza.trace('Sqlcode: ' || Sqlcode, csbNivelTraza);
                    IF SQLCODE = '-2290'
                    THEN
                        RAISE check_constraint_violated;
                    ELSE
                        RAISE;
                    END IF;
            END;
        ELSE
            RAISE exerror;
        END IF;
     
        pkg_traza.trace('onuerrorcode   => '||onuerrorcode, csbNivelTraza);
        pkg_traza.trace('osberror       => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN check_constraint_violated
        THEN
            -- catch the ORA-02290 exception (CHK_LECTESP_CAUS_PRES)
            ROLLBACK;
            --Devuelvo el Numero de Error
            onuerrorcode := nupaso;
            osberror :=
                   CHR (10)
                || 'TERMINO CON ERROR: '
                || ''
                || ' | '
                || csbMetodo
                || '('
                || nupaso
                || '): '
                || CHR (10)
                || 'Campos PRESION y (CAUSAL/CAUSAL_OBS) son excluyentes.';
            
            --Devuelvo el Error en el parametro
            pkg_traza.trace(chr(10) || 'No se inserto nada!' || chr(10), csbNivelTraza);
            osberror := osberror || CHR (10) || sbmsgfinal;
            pkg_traza.trace('onuerrorcode   => '||onuerrorcode, csbNivelTraza);
            pkg_traza.trace('osberror       => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN exdatosinsuf
        THEN
            ROLLBACK;
            --Devuelvo el Numero de Error
            onuerrorcode := nupaso;
            osberror :=
                   CHR (10)
                || 'TERMINO CON ERROR: '
                || ''
                || ' | '
                || csbMetodo
                || '('
                || nupaso
                || '): '
                || CHR (10)
                || 'La cadena de entrada no tiene la cantidad de campos requeridos';
            
            --Devuelvo el Error en el parametro
            pkg_traza.trace(chr(10) || 'No se inserto nada!' || chr(10), csbNivelTraza);
            osberror := osberror || CHR (10) || sbmsgfinal;
            pkg_traza.trace('onuerrorcode   => '||onuerrorcode, csbNivelTraza);
            pkg_traza.trace('osberror       => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN exerror
        THEN
            ROLLBACK;
            --Devuelvo el Numero de Error
            onuerrorcode := nupaso;
            osberror :=
                   CHR (10)
                || 'TERMINO CON ERROR: '
                || ''
                || ' | '
                || csbMetodo
                || '('
                || nupaso
                || '): '
                || CHR (10)
                || 'Procesamiento de la cadena de entrada con errores';
            
            --Devuelvo el Error en el parametro
            pkg_traza.trace (chr(10) || 'No se inserto nada!' || chr(10), csbNivelTraza);
            osberror := osberror || CHR (10) || sbmsgfinal;
            pkg_traza.trace('onuerrorcode   => '||onuerrorcode, csbNivelTraza);
            pkg_traza.trace('osberror       => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr, gsbErr);        
            ROLLBACK;
            --Devuelvo el Numero de Error
            onuerrorcode := nupaso;
            osberror :=
                   CHR (10)
                || 'ERROR AL INSERTAR EL REGISTRO EN LA TABLA  LDC_CM_LECTESP. '
                || CHR (10)
                || ''
                || ' | '
                || csbMetodo
                || '('
                || nupaso
                || '): '
                || CHR (10)
                || gsbErr;
            
            --Devuelvo el Error en el parametro
            pkg_traza.trace (chr(10) || 'No se inserto nada!' || chr(10), csbNivelTraza);
            osberror := osberror || CHR (10) || sbmsgfinal;
            pkg_traza.trace('onuerrorcode   => '||onuerrorcode, csbNivelTraza);
            pkg_traza.trace('osberror       => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proinslectura;

    FUNCTION frcdatoscritica (
        inuproductoid   IN     ldc_cm_lectesp.sesunuse%TYPE,
        inupericons     IN     ldc_cm_lectesp.pecscons%TYPE,
        osberror        IN OUT VARCHAR2)
        RETURN ldc_cm_lectesp_crit%ROWTYPE
    IS
        /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete:   frcDatosCritica
    Descripcion:          Funcion para devolver el producto con los datos basicos para la critica en la forma .NET LECTESPCRIT.

    Autor    : Oscar Ospino P.

    Fecha    : 23-05-2016  CA 200-210

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    27-05-2016   Oscar Ospino P.        Creacion
    09-07-2016   Oscar Ospino P.        Se modifican las consultas de los campos Lectura Actual, Lect. Final,
                                        Consumo 12 meses atras, Presion Mes Anterior, Factor Correccion.
    05/05/2022  LJLB                    CA OSF-75 se ajusta para que ciclos telemedidos puedan ser procesado sin problema
    ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'frcdatoscritica';
        rccritica      ldc_cm_lectesp_crit%ROWTYPE;
        rclecturas     ldc_cm_lectesp_crit%ROWTYPE;

        exerror        EXCEPTION;                          -- Error controlado
        sberrultlect   VARCHAR2 (4000); -- Errores devueltos por el proceso FcrUltimasLect

        nupaso         NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuproductoid  <= '||inuproductoid, csbNivelTraza);
        pkg_traza.trace('inupericons    <= '||inupericons, csbNivelTraza);
        

        --Producto
        rccritica.sesunuse := inuproductoid;

        --Critica ID y Proc (Estado)
        BEGIN
            nupaso := 5;

            --Se obtiene el ID de Critica si existe
            --Si es NULL se pasa en 0 para que luego el proceso proGeneraCritica la inserte.
            SELECT NVL (c.critica_id, 0), NVL (c.proc, 'N')
              INTO rccritica.critica_id, rccritica.proc
              FROM ldc_cm_lectesp_crit c
             WHERE     c.sesunuse = inuproductoid
                   AND c.pecscons = inupericons
                   AND ROWNUM = 1;
        EXCEPTION
            WHEN OTHERS
            THEN
                --El producto no tiene critica en periodo actual
                rccritica.critica_id := 0;
                rccritica.proc := 'N';
        END;

        --Orden de Lectura, Periodo de Consumo y Periodo de Facturacion
        BEGIN
            nupaso := 10;

              SELECT MAX (l.order_id) order_id, l.pefacodi, l.pecscons
                INTO rccritica.order_id, rccritica.pefacodi, rccritica.pecscons
                FROM ldc_cm_lectesp l, perifact pf, pericose pc
               WHERE     l.pefacodi = pf.pefacodi
                     AND l.pecscons = pc.pecscons
                     AND l.sesunuse = inuproductoid
                     AND l.pecscons = inupericons
                     AND pf.pefaactu = 'S'
                     AND pc.pecsflav = 'N'
                     AND l.procesado = 'N'
            GROUP BY l.pefacodi, l.pecscons;
        EXCEPTION
            WHEN OTHERS
            THEN
                pkg_Error.setError;
                pkg_Error.getError(gnuErr, gsbErr);            
                osberror :=
                       osberror
                    || CHR (10)
                    || ' Paso: '
                    || nupaso
                    || ' | Error: No se pudo obtener: Orden | periodo de facturacion | Periodo de consumo.'
                    || CHR (10)
                    || ' | Detalle Error: '
                    || gsbErr;
                
        END;

        --consumo promedio
        BEGIN
            nupaso := 15;

            SELECT NVL (cp.hcppcopr, 0)
              INTO rccritica.consprom
              FROM (  SELECT hcppcopr
                        FROM hicoprpm
                       WHERE hcppsesu = inuproductoid AND hcppcopr IS NOT NULL
                    ORDER BY hcpppeco DESC) cp
             WHERE ROWNUM = 1;
        EXCEPTION
            WHEN OTHERS
            THEN
                rccritica.consprom := 0;
        END;

        --consumo 12 periodos antes al periodo actual
        BEGIN
            nupaso := 20;

            SELECT NVL (SUM (c.cosscoca), 0)
              INTO rccritica.conspromdc
              FROM conssesu c
             WHERE     c.cossflli = 'S'
                   AND c.cosssesu = inuproductoid
                   AND c.cosspecs =
                       (SELECT MIN (c2.cosspecs)     cosspecs
                          FROM (  SELECT c1.cosspecs, c1.cosscoca
                                    FROM (  SELECT c.cosssesu,
                                                   c.cosspecs,
                                                   SUM (c.cosscoca)     cosscoca
                                              FROM conssesu c
                                             WHERE     c.cossmecc = 4
                                                   AND c.cosstcon = 1
                                                   AND c.cosssesu = inuproductoid
                                                   AND c.cosspecs <= inupericons
                                          GROUP BY c.cosssesu, c.cosspecs) c1
                                ORDER BY c1.cosssesu, c1.cosspecs DESC) c2
                         WHERE ROWNUM <= 12);
        EXCEPTION
            WHEN OTHERS
            THEN
                rccritica.conspromdc := 0;
        END;

        BEGIN
            --Presion Mes Anterior
            nupaso := 25;

              SELECT NVL (vv.vvfcvalo, 0)
                INTO rccritica.presmesant
                FROM cm_vavafaco vv
               WHERE     vv.vvfcsesu = inuproductoid
                     AND vv.vvfcvafc = 'PRESION_OPERACION'
                     AND vv.vvfcfefv >= SYSDATE
            ORDER BY vv.vvfcfefv DESC;
        EXCEPTION
            WHEN OTHERS
            THEN
                rccritica.presmesant := 0;
        END;

        --Factor Correccion Mes Anterior
        BEGIN
            --Version 1
            nupaso := 26;

            SELECT NVL (fc.fccofaco, 0)     factcorrmesante
              INTO rccritica.facorrmant
              FROM cm_facocoss fc
             WHERE     fc.fccosesu = inuproductoid
                   AND ROWNUM = 1
                   AND fc.fccopecs =
                       (SELECT MAX (fc.fccopecs)
                          FROM cm_facocoss fc
                         WHERE     fc.fccosesu = inuproductoid
                               AND fc.fccopecs < inupericons);
        EXCEPTION
            WHEN OTHERS
            THEN
                rccritica.facorrmant := 0;
        END;

        --Lectura Actual Y Final: Capturo la ultima lectura de control (se agregan campos de telemedidos Ca-90)
        BEGIN
            nupaso := 30;

            SELECT lact.lectura     l1,
                   lact.lectura     l2,
                   lact.pres,
                   lact.lect_eagle,
                   lact.voltbat
              INTO rccritica.leemleac,
                   rccritica.lectfin,
                   rccritica.presfin,
                   rccritica.lect_eagle,
                   rccritica.volt_bat
              FROM (  SELECT l.lectura,
                             l.pres,
                             l.lect_eagle,
                             l.voltbat
                        FROM ldc_cm_lectesp l
                       WHERE     l.sesunuse = inuproductoid
                             AND l.pecscons = inupericons
                    ORDER BY l.feregistro DESC, l.consec_ext DESC, l.lectura)
                   lact
             WHERE ROWNUM = 1;
        EXCEPTION
            WHEN OTHERS
            THEN
                pkg_Error.setError;
                pkg_Error.getError(gnuErr, gsbErr);            
                osberror :=
                       osberror
                    || CHR (10)
                    || ' Paso: '
                    || nupaso
                    || ' | Error: No se pudo obtener la Lectura Actual/Ultima Lectura de Control.'
                    || CHR (10)
                    || ' | Detalle Error: '
                    || gsbErr;
                
        END;

        --Lectura Anterior
        BEGIN
            nupaso := 31;

            SELECT NVL (l.leemleto, NVL (l.leemlean, 0))     lectanterior
              INTO rccritica.leemlean
              FROM lectelme l
             WHERE     l.leemsesu = inuproductoid
                   AND l.leemclec = 'F'
                   AND l.leempecs =
                       (SELECT MAX (l.leempecs)
                          FROM lectelme l
                         WHERE     l.leemsesu = inuproductoid
                               AND l.leempecs < inupericons)
                   AND ROWNUM = 1;
        EXCEPTION
            WHEN OTHERS
            THEN
                -- si es telemedido no se genera raise
                IF fsbesTelemedido (inupericons) = 'N'
                THEN
                    pkg_Error.setError;
                    pkg_Error.getError(gnuErr, gsbErr);                
                    osberror :=
                           osberror
                        || CHR (10)
                        || ' Paso: '
                        || nupaso
                        || ' | Error: No se pudo obtener la Lectura del periodo anterior.'
                        || CHR (10)
                        || ' | Detalle Error: '
                        || gsbErr;
                ELSE
                    rccritica.leemlean := 0;
                END IF;
        END;

        --Volumen No Corregido  (Lectura Actual menos Lectura Anterior)
        BEGIN
            nupaso := 32;
            rccritica.volncorr :=
                NVL (rccritica.leemleac, 0) - NVL (rccritica.leemlean, 0);
        EXCEPTION
            WHEN OTHERS
            THEN
                pkg_Error.setError;
                pkg_Error.getError(gnuErr, gsbErr);            
                osberror :=
                       osberror
                    || CHR (10)
                    || ' Paso: '
                    || nupaso
                    || ' | Error: No se pudo calcular el Volumen No Corregido.'
                    || CHR (10)
                    || ' | Detalle Error: '
                    || gsbErr;
                
        END;

        --Vol Corregido Estimado
        BEGIN
            nupaso := 33;
            rccritica.volcorrest := rccritica.volncorr * rccritica.facorrmant;
        EXCEPTION
            WHEN OTHERS
            THEN
                pkg_Error.setError;
                pkg_Error.getError(gnuErr, gsbErr);            
                osberror :=
                       osberror
                    || CHR (10)
                    || ' Paso: '
                    || nupaso
                    || ' | Error: No se pudo calcular el Volumen Corregido Estimado.'
                    || CHR (10)
                    || ' | Detalle Error: '
                    || gsbErr;
                
        END;

        --Cargo en un Record temporal las 3 ultimas lecturas de Control tomadas
        BEGIN
            nupaso := 34;
            rclecturas :=
                frcultimaslect (rccritica.sesunuse,
                                rccritica.pefacodi,
                                sberrultlect);
            pkg_traza.trace('frcultimaslect  => sberrultlect '||sberrultlect, csbNivelTraza);
        EXCEPTION
            WHEN OTHERS
            THEN
                pkg_Error.setError;
                pkg_Error.getError(gnuErr, gsbErr);            
                osberror :=
                       osberror
                    || CHR (10)
                    || sberrultlect
                    || CHR (10)
                    || ' NuPaso: '
                    || nupaso
                    || ' | Error: No se pudieron cargar las 3 ultimas lecturas del Producto.'
                    || CHR (10)
                    || ' | Detalle Error: '
                    || gsbErr;
                
        END;

        --Asigno al Record Principal los datos de las lecturas de control anteriores
        BEGIN
            nupaso := 40;
            rccritica.lepresa := rclecturas.lepresa;
            rccritica.lepresb := rclecturas.lepresb;
            rccritica.lepresc := rclecturas.lepresc;
            rccritica.caupresa := rclecturas.caupresa;
            rccritica.caupresb := rclecturas.caupresb;
            rccritica.caupresc := rclecturas.caupresc;
            rccritica.funca := rclecturas.funca;
            rccritica.funcb := rclecturas.funcb;
            rccritica.funcc := rclecturas.funcc;
        EXCEPTION
            WHEN OTHERS
            THEN
                pkg_Error.setError;
                pkg_Error.getError(gnuErr, gsbErr);            
                osberror :=
                       osberror
                    || CHR (10)
                    || ' Paso: '
                    || nupaso
                    || ' | Error: No se pudo asignar las ultimas lecturas del Producto.'
                    || CHR (10)
                    || ' | Detalle Error: '
                    || gsbErr;
                
        END;

        --Si hubo errores en alguno de los pasos se instancia
        IF osberror IS NOT NULL
        THEN
            RAISE exerror;
        END IF;

        pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN rccritica;
    EXCEPTION
        WHEN exerror
        THEN
            osberror :=
                   CHR (10)
                || ' *** Inicio Carga de Datos Critica. Producto: '
                || inuproductoid
                || ' *** '
                || CHR (10)
                || ' | '
                || csbMetodo
                || ' | Paso ('
                || nupaso
                || '):'
                || CHR (10)
                || osberror
                || CHR (10)
                || ' *** Fin Carga de Datos Critica. ***'
                || CHR (10);
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RETURN rccritica;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr, gsbErr);        
            osberror :=
                   CHR (10)
                || ' *** Inicio Carga de Datos Critica  *** '
                || CHR (10)
                || 'Producto: '
                || inuproductoid
                || ' | Periodo Consumo: '
                || inupericons
                || CHR (10)
                || ' | '
                || csbMetodo
                || ' | Paso: ('
                || nupaso
                || ')'
                || CHR (10)
                || osberror
                || CHR (10)
                || ' | Detalle Error: '
                || gsbErr
                || CHR (10)
                || ' *** Fin Carga de Datos Critica. ***'
                || CHR (10);
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN rccritica;
    END frcdatoscritica;

    PROCEDURE progeneraordenes (osberror OUT VARCHAR2)
    IS
        /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete:   proGeneraOrdenes
    Descripcion:          Genera las actividades de lectura para los clientes especiales.
                          Es copia del proceso CM_BOREGLECT.GENREADINGACTIVITIES modificado
                          para que solo procese los periodos de consumo de los ciclos especificados
                          en la tablas LDC_CM_LECTESP_CICL.

    Autor    : Oscar Ospino P.

    Fecha    : 27-05-2016  CA 200-210

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.             Modificacion
    -----------  -------------------   -------------------------------------
    27-05-2016   Oscar Ospino P.       Creacion
    17-10-2023   jcatuchemvm           OSF-1440: Se elmimina código comentdo o que no aplica, se elimina esquemas de tablas.
	29/08/2024	 jsoto				   OSF-3158: Se Agrega registro de inicio y finalizacion del proceso en ESTAPROC
    ******************************************************************/
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'progeneraordenes';                           
        ----------------------------------------------------------------------------
        -- Constantes
        ----------------------------------------------------------------------------
        csbprogram             VARCHAR2 (4) := 'FGRL';
        ----------------------------------------------------------------------------
        dtdatetoprocess        DATE := TRUNC (SYSDATE); /* Fecha a procesar */

        sbconsumptionperiods   VARCHAR2 (32767); /* Lista de Periodos de Consumo */
        sbconsumptioncycles    VARCHAR2 (32767); /* Lista de Ciclos de Consumo */
        sbseparator            VARCHAR2 (1) := '';             /* Separador */

        sbpath                 VARCHAR2 (300);                      /* Ruta */
        sbprogramid            VARCHAR2 (4);  /* Identificador del programa */
        sbterminal             VARCHAR2 (300);                  /* Terminal */
        sbcommand              VARCHAR2 (2000);                  /* Comando */
        sbconnectionstring     VARCHAR2 (1000);       /* Cadena de Conexion */
        sbtracename            VARCHAR2 (500);        /* Nombre de la Traza */
        nusessionid            NUMBER;        /* Identificador de la Sesion */
		
		sbproceso  			   VARCHAR2(100) := 'LDC_PKCM_LECTESP'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

        TYPE rcperiodos IS RECORD
        (
            pecscons    pericose.pecscons%TYPE,
            pecscico    pericose.pecscico%TYPE
        );

        --Obtengo los periodos de consumo No Procesados que inician el dia actual,
        --a partir de los ciclos parametrizados en LDC_CM_LECTESP_CICL.
        CURSOR cuperiodos IS
            SELECT p.pecscons, p.pecscico, p.pecsfeci
              FROM ciclcons c, pericose p
             WHERE     c.cicogele = 'S'
                   AND c.cicocodi = p.pecscico
                   AND p.pecscico IN (SELECT clec.pecscico
                                        FROM ldc_cm_lectesp_cicl clec)
                   AND TRUNC (p.pecsfeci) = dtdatetoprocess
                   AND p.pecsproc = 'N';

        /**************************************************************
        Propiedad intelectual de Open International Systems (c).
        Unidad      :  AddPeriodToProcess
        Descripcion :  Adiciona un periodo para procesar

        Autor       :  Gustavo Adolfo Paz
        Fecha       :  30-04-2013
        Parametros  :
                       inuPecscons        Codigo del Periodo de Consumo
                       inuCiclcons        Codigo del Ciclo de Consumo

        Historia de Modificaciones
        Fecha        Autor              Modificacion
        =========    =========          ====================
        03-05-2013   GPaz.SAO207480     Se corrige error al limpiar el log de REACGELE.
        03-05-2013   GPaz.SAO207443     Se agrega la actualizacion del log del
                                        resultado del proceso a no procesado
        30-04-2013   GPaz.SAO207123     Creacion
        ***************************************************************/
        PROCEDURE addperiodtoprocess (
            inupecscons   IN pericose.pecscons%TYPE,
            inuciclcons   IN ciclcons.cicocodi%TYPE)
        IS
            rcpericose   pericose%ROWTYPE; /* Registro del periodo de consumo */
            rcreacgele   reacgele%ROWTYPE; /* Registro para el log de actividades del registro de insercion */
        BEGIN
            -- Se obtiene el registro del periodo de consumo
            rcpericose := pktblpericose.frcgetrecord (inupecscons);
            -- Se actualiza el periodo de consumo a no procesado
            rcpericose.pecsproc := 'N';
            pktblpericose.uprecord (rcpericose);

            -- Se actualiza el log del resultado del proceso a no procesado
            FOR i IN 0 .. 9
            LOOP
                rcreacgele :=
                    pkbcreacgele.frcgetregbypecsdivi (inupecscons, i);

                IF (rcreacgele.raglcons IS NOT NULL)
                THEN
                    rcreacgele.raglfina := 'N';
                    pktblreacgele.uprecord (rcreacgele);
                END IF;
            END LOOP;

            -- Se procesa el periodo de consumo
            sbconsumptionperiods :=
                sbconsumptionperiods || sbseparator || inupecscons;
            sbconsumptioncycles :=
                sbconsumptioncycles || sbseparator || inuciclcons;
            sbseparator := '|';
        END addperiodtoprocess;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        --CA 200-210
        ------------------------------------------------------------------------------
        FOR rcperiodos IN cuperiodos
        LOOP
            -- Se procesa el periodo de consumo
            addperiodtoprocess (rcperiodos.pecscons, rcperiodos.pecscico);
        END LOOP;

        ------------------------------------------------------------------------------

        -- Si no hay periodos de consumo a procesar
        IF (sbconsumptionperiods IS NULL)
        THEN
            osberror :=  'No hay periodos a procesar';
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
            RETURN;
        END IF;


        pkg_traza.trace('Si hay periodos para procesar: ' || sbconsumptionperiods, csbNivelTraza);
		
		pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);

        -- Se comprometen los cambios
        pkgeneralservices.committransaction;

        --Se ejecuta el Pro*C para la generacion de las actividades de lectura
        sbpath := pkgeneralparametersmgr.fsbgetstringvalue ('RUTA_TRAZA');

        IF (sbpath IS NULL)
        THEN
            sbpath := '/tmp';
        END IF;

        sbprogramid := csbprogram;
        sbterminal := pkg_session.fsbgetterminal;

        -- Remplaza los '/' y '\' por '_'
        sbterminal := ut_string.strreplace (sbterminal, '\', '_');
        sbterminal := ut_string.strreplace (sbterminal, '/', '_');

        -- Obtenemos el Identificador de la Sesion
        nusessionid := SYS_CONTEXT ('USERENV', 'SESSIONID');

        sbtracename :=
               'FGRL'
            || '_'
            || sbterminal
            || '_'
            || nusessionid
            || '_'
            || TO_CHAR (SYSDATE, 'YYYYMMDDHH24MISS')
            || '.trc';

        sbconnectionstring :=
            ge_bodatabaseconnection.fsbgetdefaultconnectionstring;

        /* Se Construye el comando de ejecucion en PRO*C que envia los parametro:

            0. Nombre del Programa a Ejecutar (fgrl)
            1. Usuario/Password@String_Conexion
            2. Periodos de consumo separados por pipes ("12|2|4")
            3. Ciclos correspondientes al periodo de consumo separados por pipes ("12|2|4")
            4. Indica si se deben validar los valores pasados como parametros
            5. Indica el identificador generado para el proceso
            6. Nombre de la Traza que genera la consola.                       
        */

        sbcommand :=
               'fgrl'
            || ' '
            || sbconnectionstring
            || ' "'
            || sbconsumptionperiods
            || '" "'
            || sbconsumptioncycles
            || '" "FALSE" "'
            || sbprogramid
            || '" "'
            || pkconstante.nullnum
            || '" "'
            || sbtracename
            || '" > '
            || sbpath
            || '/'
            || sbtracename
            || ' 2>'
            || CHR (38)
            || '1 '
            || CHR (38);

        pkg_traza.trace ('LLamo el Pro*C: fgrl', csbNivelTraza);
        llamasist (sbcommand);
		
		pkg_estaproc.prActualizaEstaproc(sbProceso,' OK', 'Termina ok');
        
        pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_Error.controlled_error
        THEN
            pkg_Error.getError(gnuErr,gsbErr);
            osberror :=
                   'Termino con error Controlado: '
                || gsbErr
                || ' | Proceso: '
                || csbMetodo;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE pkg_Error.controlled_error;
        WHEN OTHERS
        THEN
            pkg_Error.SetError;
            pkg_Error.getError(gnuErr,osberror);
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE pkg_Error.controlled_error;
    END progeneraordenes;

    FUNCTION frcultimaslect (
        inusesunuse   IN     ldc_cm_lectesp.sesunuse%TYPE,
        inupefacodi   IN     ldc_cm_lectesp.pefacodi%TYPE,
        osberror      IN OUT VARCHAR2)
        RETURN ldc_cm_lectesp_crit%ROWTYPE
    IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:   frcUltimasLect
        Descripcion:          funcion frcUltimasLect para devolver las ultimas 3 lecturas de
                              presion por OT.

        Autor    : Oscar Ospino P.

        Fecha    : 20-05-2016  CA 200-210

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        20-05-2016   Oscar Ospino P.           Creacion
        ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'frcultimaslect';
        nupaso      NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        rclect      ldc_cm_lectesp_crit%ROWTYPE;

        exerror     EXCEPTION;                             -- Error controlado
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inusesunuse    <= '||inusesunuse, csbNivelTraza);
        pkg_traza.trace('inupefacodi    <= '||inupefacodi, csbNivelTraza);
        pkg_traza.trace('osberror       <= '||osberror, csbNivelTraza);

        --Valido que hayan datos en los parametros
        nupaso := 5;

        IF inusesunuse IS NULL OR inupefacodi IS NULL
        THEN
            osberror :=
                   osberror
                || CHR (10)
                || 'NuPaso: '
                || nupaso
                || ' | Error: Niguno de los parametros del proceso puede estar vacio. | Producto: '
                || inusesunuse
                || ' | Periodo de Facturacion: '
                || inupefacodi
                || CHR (10)
                || '';
            RAISE exerror;
        END IF;

        --Se transponen las ultimas 3 lecturas de Control. Uso Consumiendo y Presion
        nupaso := 10;

        BEGIN
            SELECT pres.sesunuse,
                   pres.lect1,
                   func.funcionando1,
                   causal.causal1,
                   pres.lect2,
                   func.funcionando2,
                   causal.causal2,
                   pres.lect3,
                   func.funcionando3,
                   causal.causal3
              INTO rclect.sesunuse,
                   rclect.lepresa,
                   rclect.funca,
                   rclect.caupresa,
                   rclect.lepresb,
                   rclect.funcb,
                   rclect.caupresb,
                   rclect.lepresc,
                   rclect.funcc,
                   rclect.caupresc
              FROM (SELECT t.sesunuse,
                           t.pres,
                           CASE WHEN ROWNUM >= 1 THEN ROWNUM END     numlect
                      FROM (  SELECT l.sesunuse,
                                     l.pefacodi,
                                     l.consec_ext,
                                     l.pres
                                FROM ldc_cm_lectesp l
                               WHERE     l.sesunuse = inusesunuse --Paso el producto
                                     AND l.pefacodi = inupefacodi --paso el periodo de facturacion
                            ORDER BY l.sesunuse, l.feregistro         
                                                             ) t
                     WHERE ROWNUM <= 3)
                       PIVOT (MAX (pres)
                             FOR numlect
                             IN (1 lect1, 2 lect2, 3 lect3)) pres,
                   (SELECT t.sesunuse,
                           t.usocons,
                           CASE WHEN ROWNUM >= 1 THEN ROWNUM END     numlect
                      FROM (  SELECT l.sesunuse,
                                     l.pefacodi,
                                     l.consec_ext,
                                     NVL (l.usocons, 'N')     usocons
                                FROM ldc_cm_lectesp l
                               WHERE     l.sesunuse = inusesunuse --Paso el producto
                                     AND l.pefacodi = inupefacodi --paso el periodo de facturacion
                            ORDER BY l.sesunuse, l.feregistro         
                                                             ) t
                     WHERE ROWNUM <= 3)
                       PIVOT (
                             MAX (usocons)
                             FOR numlect
                             IN (1 funcionando1,
                                2 funcionando2,
                                3 funcionando3)) func,
                   (SELECT t.sesunuse,
                           t.causal,
                           CASE WHEN ROWNUM >= 1 THEN ROWNUM END    numcausal
                      FROM (  SELECT l.sesunuse,
                                     l.pefacodi,
                                     l.consec_ext,
                                        l.causal
                                     || DECODE (l.causal, NULL, NULL, '-')
                                     || l.causal_obs    causal
                                FROM ldc_cm_lectesp l
                               WHERE     l.sesunuse = inusesunuse --Paso el producto
                                     AND l.pefacodi = inupefacodi --paso el periodo de facturacion
                            ORDER BY l.sesunuse, l.feregistro         
                                                             ) t
                     WHERE ROWNUM <= 3)
                       PIVOT (MAX (causal)
                             FOR numcausal
                             IN (1 causal1, 2 causal2, 3 causal3)) causal
             WHERE     pres.sesunuse = func.sesunuse
                   AND pres.sesunuse = causal.sesunuse;
        EXCEPTION
            WHEN OTHERS
            THEN
                pkg_Error.setError;
                pkg_Error.getError(gnuErr, gsbErr);            
                osberror :=
                       osberror
                    || CHR (10)
                    || 'NuPaso: '
                    || nupaso
                    || ' | Error: No se pudieron cargar los datos.'
                    || CHR (10)
                    || gsbErr;
        END;

        pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN rclect;
    EXCEPTION
        WHEN exerror
        THEN
            osberror :=
                   CHR (10)
                || '*** Inicio Carga 3 Ultimas Lecturas de Control. *** '
                || CHR (10)
                || ''
                || ' | '
                || csbMetodo
                || ' | Sesion: '
                || gnusesion
                || ' | Paso ('
                || nupaso
                || ')'
                || CHR (10)
                || osberror
                || CHR (10)
                || '*** Fin Carga Ultimas Lecturas de Control. ***'
                || CHR (10)
                || CHR (10);
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RETURN rclect;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr, gsbErr);        
            osberror :=
                   CHR (10)
                || '*** Inicio Carga 3 Ultimas Lecturas de Control. *** '
                || CHR (10)
                || ''
                || ' | '
                || csbMetodo
                || ' | Sesion: '
                || gnusesion
                || ' | Paso: ('
                || nupaso
                || ')'
                || CHR (10)
                || osberror
                || CHR (10)
                || ' | Detalle Error: '
                || gsbErr
                || CHR (10)
                || '*** Fin Carga de Datos Critica. ***'
                || CHR (10)
                || CHR (10);
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN rclect;
    END frcultimaslect;

    FUNCTION fcrciclosparam (osberror OUT VARCHAR2)
        RETURN constants_per.tyrefcursor
    IS
        /*****************************************************************

        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete:   fcrCiclosLectEsp
        Descripcion:          Consulta los ciclos parametrizados para las lecturas especiales.

        Autor    : Oscar Ospino P.

        Fecha    : 20-05-2016  CA 200-210

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        20-05-2016   Oscar Ospino P.        Creacion
        18-02-2022   hahenao.Horbath        Se acondiciona la consulta para retorna opcion -1-Todos-
    ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fcrciclosparam';
        nupaso      NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        crciclos    constants_per.tyrefcursor;
        exerror     EXCEPTION;                             -- Error controlado
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);

        --Cursor referenciado
        OPEN crciclos FOR
            SELECT -1 "CODIGO", '-Todos-' "DESCRIPCION" FROM DUAL
            UNION ALL
            SELECT DISTINCT
                   c.cicocodi                            "CODIGO",
                   c.cicocodi || ' - ' || c.cicodesc     "DESCRIPCION"
              FROM ciclcons c, ldc_cm_lectesp_cicl lc
             WHERE     lc.pecscico = c.cicocodi
                   AND fsbGetCiclo (c.cicocodi) = 'S';

        pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN crciclos;
    EXCEPTION
        WHEN exerror
        THEN
            osberror := 
                   'TERMINO CON ERROR '
                || csbMetodo
                || ' | Sesion: '
                || gnusesion
                || '('
                || nupaso
                || '):'
                || osberror;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr, gsbErr);        
            osberror :=
                   'TERMINO CON ERROR NO CONTROLADO  '
                || csbMetodo
                || '('
                || nupaso
                || '): '
                || gsbErr;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END fcrciclosparam;

    FUNCTION fcrperiodoscriticahist (osberror OUT VARCHAR2)
        RETURN constants_per.tyrefcursor
    IS
        /*****************************************************************

    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete:   fcrPeriodosCriticaHist
    Descripcion:          Consulta los ciclos historicos utilizados en las criticas de
                          lecturas especiales.

    Autor    : Oscar Ospino P.

    Fecha    : 03-06-2016  CA 200-210

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    03-06-2016   Oscar Ospino P.           Creacion
    05/05/2022   LJLB                     CA OSF-75 se muestran solo los periodos anteriores al mes actual
    ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fcrperiodoscriticahist';
        nupaso        NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        crciclos      constants_per.tyrefcursor;
        exerror       EXCEPTION;                           -- Error controlado
        nuYearAct     NUMBER;
        nuMonthAct    NUMBER;
        nuYearReal    NUMBER;
        nuMonthReal   NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);

        --Se obtiene el a¿o y mes anterior de la fecha actual
        SELECT TO_CHAR (fecha_ant, 'YYYY'), TO_CHAR (fecha_ant, 'MM')
          INTO nuYearReal, nuMonthReal
          FROM (SELECT ADD_MONTHS (SYSDATE, -1) fecha_ant FROM DUAL);

        --Cursor referenciado
        OPEN crciclos FOR
              SELECT pf.pefacicl                  sesucico,
                        LPAD (pf.pefacicl, 5, 0)
                     || ' - '
                     || cipf.cicldesc             ciclofactdesc,
                     l.pefacodi,
                     pc.pecscico,
                        LPAD (pc.pecscico, 5, 0)
                     || ' - '
                     || cico.cicodesc             cicloconsudesc,
                     l.pecscons,
                     (SELECT DECODE (COUNT (B.pefacodi),
                                     0, 'N',
                                     'S')
                    FROM ldc_cm_lectesp_crit B
                       WHERE     B.pefacodi = l.pefacodi
                             AND B.proc = 'S')    Procesado, --Periodo con OT no procesadas
                     pf.pefaano                   ano,
                     pf.pefames                   mes
            FROM ldc_cm_lectesp_crit l,
                     perifact                pf,
                     pericose                pc,
                     ciclo                   cipf,
                     ciclcons                cico
               WHERE     l.pefacodi = pf.pefacodi
                     AND l.pecscons = pc.pecscons
                     AND fsbGetCiclo (pf.pefacicl) = 'S'
                     AND pf.pefacicl = cipf.ciclcodi
                     AND pc.pecscico = cico.cicocodi
                     AND pf.pefaano = nuYearReal
                     AND pf.pefames = nuMonthReal
            GROUP BY pf.pefacicl,
                     cipf.cicldesc,
                     l.pefacodi,
                     pc.pecscico,
                     cico.cicodesc,
                     l.pecscons,
                     pf.pefaano,
                     pf.pefames
            ORDER BY pf.pefacicl,
                     pf.pefaano,
                     pf.pefames,
                     l.pefacodi;
    

        
        pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN crciclos;
    EXCEPTION
        WHEN exerror
        THEN
            osberror :=
                   'TERMINO CON ERROR '
                || ' | '
                || csbMetodo
                || ' | Sesion: '
                || gnusesion
                || '('
                || nupaso
                || '):'
                || osberror;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr, gsbErr);        
            osberror :=
                   'TERMINO CON ERROR NO CONTROLADO  '
                || ' | '
                || csbMetodo
                || '('
                || nupaso
                || '): '
                || gsbErr;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END fcrperiodoscriticahist;


    FUNCTION fcrpefaciclos (inupefaciclo   IN     perifact.pefacicl%TYPE,
                            osberror          OUT VARCHAR2)
        RETURN constants_per.tyrefcursor
    IS
        /*****************************************************************

    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete:   fcrPefaCiclos
    Descripcion:          Obtener los periodos de facturacion de un ciclo.

    Autor    : Oscar Ospino P.

    Fecha    : 01-06-2016  CA 200-210

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    01-06-2016   Oscar Ospino P.        Creacion
    18-02-2022   hahenao.Horbath        Se acondiciona consulta para que se retorne el periodo -1-Todos-
                                        cuando el ciclo que se recibe -1-Todos. Ademas, se acondiciona para
                                        que muestre los periodos de los ultimos dos a¿os
    ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fcrpefaciclos';
        nupaso        NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
        crpefaciclo   constants_per.tyrefcursor;
        exerror       EXCEPTION;                           -- Error controlado
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inupefaciclo   <= '||inupefaciclo, csbNivelTraza);

        --Cursor referenciado
        --Obtengos los periodos de todos los ciclos asociados al usuario configurado
        IF (inuPefaciclo = -1)
        THEN
            OPEN crpefaciclo FOR
                SELECT -1 "CODIGO", '-Todos-' "DESCRIPCION" FROM DUAL;
        ELSE
            --Obtengo los periodos especificos del ciclo seleccionado
            OPEN crpefaciclo FOR
                SELECT DISTINCT
                       pf.pefacodi                             "CODIGO",
                       pf.pefacodi || ' - ' || pf.pefadesc     "DESCRIPCION"
                  FROM perifact pf
                 WHERE     pf.pefacicl = inupefaciclo
                       AND fsbGetCiclo (pf.pefacicl) = 'S'
                       AND pf.pefaactu = 'S'; --ano >= TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - 2;
        END IF;

        
        pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN crpefaciclo;
    EXCEPTION
        WHEN exerror
        THEN
            osberror :=
                   'TERMINO CON ERROR '
                || csbMetodo
                || ' | Sesion: '
                || gnusesion
                || '('
                || nupaso
                || '):'
                || osberror;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr, gsbErr);        
            osberror :=
                   'TERMINO CON ERROR NO CONTROLADO  '
                || csbMetodo
                || '('
                || nupaso
                || '): '
                || gsbErr;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END fcrpefaciclos;

    PROCEDURE proactualizapresfaco (
        inuproducto     IN     cm_vavafaco.vvfcsesu%TYPE,
        inuorden        IN     ldc_cm_lectesp_crit.order_id%TYPE,
        inupresionact   IN     cm_vavafaco.vvfcvapr%TYPE,
        inuperiocons    IN     ldc_cm_lectesp_crit.PECSCONS%TYPE,
        osberror           OUT VARCHAR2)
    IS
        /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete:   proActualizaPresFaco
    Descripcion:          Actualiza la variable PRESION DE OPERACION del producto en la tabla
                          CM_VAVAFACO.

    Autor    : Oscar Ospino P.

    Fecha    : 27-05-2016  CA 200-210

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    27-05-2016   Oscar Ospino P.           Creacion
    29/08/2022   LJLB                    OSF-529 se tome la presión teniendo en cuenta la fecha final
                                         del periodo de consumo
    01/02/2023   LJLB                    OSF-847 se agrega insert de la tabla cm_vavafaco, con el fin de terner
                                         el historial de las presiones
    ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proactualizapresfaco';
        nuvarid              cm_vavafaco.vvfccons%TYPE; --consecutivo de la variable
        rcvavafaco           cm_vavafaco%ROWTYPE; --record de la tabla cm_vavafaco
        rcvavafacoIns        cm_vavafaco%ROWTYPE; --record de la tabla cm_vavafaco
        nuvalantpresion      NUMBER (10, 4); --Valor anterior de la variable Presion Operacion
        nucontador           NUMBER;
        --nupeco          Number(6); --Periodo de COnsumo
        nupefa               NUMBER (6);              --Periodo de Facturacion

        CURSOR cuGetFechaPeriodo IS
            SELECT PECSFECI, PECSFECF
              FROM pericose
             WHERE PECSCONS = inuperiocons;

        regPeriodoCons       cuGetFechaPeriodo%ROWTYPE;

        excnohayvariable     EXCEPTION;
        excmuchasvariables   EXCEPTION;
        exinserror           EXCEPTION;
        exnodatoscritica     EXCEPTION;
        exfelevigenvar       EXCEPTION; --Fecha de ultima lectura, fuera de la vigencia de la variable presion
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuproducto    <= '||inuproducto, csbNivelTraza);
        pkg_traza.trace('inuorden       <= '||inuorden, csbNivelTraza);
        pkg_traza.trace('inupresionact  <= '||inupresionact, csbNivelTraza);
        pkg_traza.trace('inuperiocons   <= '||inuperiocons, csbNivelTraza);

        IF cuGetFechaPeriodo%ISOPEN
        THEN
            CLOSE cuGetFechaPeriodo;
        END IF;

        OPEN cuGetFechaPeriodo;

        FETCH cuGetFechaPeriodo INTO regPeriodoCons;

        CLOSE cuGetFechaPeriodo;

        --Consulto y actualizo la variable de presion vigente para el producto
        BEGIN
            SELECT COUNT (vv.vvfccons)     cont
              INTO nucontador
              FROM cm_vavafaco vv
             WHERE     vv.vvfcvafc = 'PRESION_OPERACION'
                   AND vv.vvfcsesu = inuproducto
                   AND regPeriodoCons.pecsfecf BETWEEN vv.vvfcfeiv
                                                   AND vv.vvfcfefv;

            IF nucontador >= 1
            THEN
                SELECT MAX (vv.vvfccons)
                  INTO nuvarid
                  FROM cm_vavafaco vv
                 WHERE     vv.vvfcvafc = 'PRESION_OPERACION'
                       AND vv.vvfcsesu = inuproducto
                       AND regPeriodoCons.pecsfecf BETWEEN vv.vvfcfeiv
                                                       AND vv.vvfcfefv;

                --Obtengo el registro de acuerdo a la consulta
                rcvavafaco := pktblcm_vavafaco.frcgetrecord (nuvarid);

                IF rcvavafaco.vvfcvalo <> inupresionact
                THEN
                    --Guardo el valor anterior de la presion del producto para el historial de Presiones del Producto
                    nuvalantpresion := rcvavafaco.vvfcvalo;

                    --Establesco el nuevo valor de la presion del producto
                    rcvavafacoIns.VVFCCONS := SQ_CM_VAVAFACO_198733.NEXTVAL;
                    rcvavafacoIns.VVFCVAFC := rcvavafaco.VVFCVAFC;
                    rcvavafacoIns.VVFCFEIV := regPeriodoCons.PECSFECI;
                    rcvavafacoIns.VVFCFEFV := rcvavafaco.VVFCFEFV;
                    rcvavafacoIns.vvfcvalo := inupresionact;
                    rcvavafacoIns.vvfcvapr := inupresionact;
                    rcvavafacoIns.VVFCUBGE := rcvavafaco.VVFCUBGE;
                    rcvavafacoIns.VVFCSESU := rcvavafaco.VVFCSESU;

                    rcvavafaco.VVFCFEFV :=
                        TO_DATE (
                               TO_CHAR (regPeriodoCons.PECSFECI - 1,
                                        'dd/mm/yyyy')
                            || ' 23:59:59',
                            'dd/mm/yyyy hh24:mi:ss');
                    --Actualizo el registro.
                    pktblcm_vavafaco.uprecord (rcvavafaco);
                    PKTBLCM_VAVAFACO.INSRECORD (rcvavafacoIns);
                --Confirmo la instruccion (Modificado, se confirma si la legalizacion es correcta en ProProcesaCritica)
                --Commit;
                END IF;
            ELSE
                --No se encontro la variable de presion para actualizar
                RAISE excnohayvariable;
            END IF;
        EXCEPTION
            WHEN TOO_MANY_ROWS
            THEN
                RAISE excmuchasvariables;
            WHEN exfelevigenvar
            THEN
                RAISE exfelevigenvar;
            WHEN OTHERS
            THEN
                RAISE excnohayvariable;
        END;

        --Inserto en la tabla LDC_CM_HISTVAVAFACO el valor previo de la variable
        BEGIN
            --Se valida que haya registros de la variable
            IF nuvarid IS NOT NULL
            THEN
                SELECT l.pefacodi
                  INTO nupefa
                  FROM ldc_cm_lectesp_crit l
                 WHERE l.order_id = inuorden AND l.sesunuse = inuproducto;

                --Cuando la presion sea diferente se registra en el historial
                IF nuvalantpresion <> inupresionact
                THEN
                    INSERT INTO ldc_cm_histvavafaco (histcons,
                                                     vvfcsesu,
                                                     order_id,
                                                     vvfccons,
                                                     histfere,
                                                     pefacodi,
                                                     vvfcvaloant,
                                                     vvfcvaloact)
                         VALUES (seq_ldc_cm_histvavafaco.NEXTVAL,
                                 inuproducto,
                                 inuorden,
                                 rcvavafaco.vvfccons,
                                 SYSDATE,
                                 nupefa,
                                 nuvalantpresion,
                                 inupresionact);

                    DECLARE
                        CURSOR cuMaq IS
                            SELECT ch.user_id                                usuario,
                                   NVL (c.maquina, NVL (ch.terminal, ''))    maquina
                          FROM ldc_cm_lectesp_crit   c,
                                   or_order                   o,
                               or_order_stat_change  ch
                             WHERE     o.order_id = c.order_id
                                   AND ch.order_id = c.order_id
                                   AND ch.final_status_id =
                                       o.order_status_id
                                   AND c.order_id = inuorden;

                        rcmaq   cuMaq%ROWTYPE;
                    BEGIN
                        FOR rcmaq IN cuMaq
                        LOOP
                            --Actualizo la auditoria de presiones con los datos del usuario
                        UPDATE ldc_cm_histvavafaco h
                               SET usuario = rcmaq.usuario,
                                   terminal = rcmaq.maquina,
                                   sesion = gnusesion
                             WHERE h.order_id = inuorden;
                        END LOOP;
                    END;
                    
                END IF;
            ELSE
                RAISE excnohayvariable;
            END IF;
        EXCEPTION
            WHEN OTHERS
            THEN
                RAISE exinserror;
        END;

        pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN exinserror
        THEN
            osberror :=
                'Error: no se pudo registrar la presion en el historial de cambios del producto.';
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN excmuchasvariables
        THEN
            osberror :=
                'Error: Existe mas de una variable "Presion Operacion" para el Producto. No se actualizó la variable.';
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN excnohayvariable
        THEN
            osberror :=
                'Error: No se encontro la variable "Presion Operacion" para el Producto. No se actualizó  la variable.';
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN exfelevigenvar
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr, gsbErr);        
            osberror :=
                   'Error: Fecha ultima lectura del Producto no esta dentro de la vigencia de la variable -Presion Operacion-. No se actualizó la variable.'
                || CHR (10)
                || ' DetalleError: '
                || gsbErr;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            ROLLBACK;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr, gsbErr);    
            osberror :=
                'Error no Controlado: no se pudo actualizar la presion del producto. '||gsbErr;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proactualizapresfaco;

    FUNCTION fnuCrReportHeader
        RETURN NUMBER
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        -- Variables
        rcRecord   Reportes%ROWTYPE;
    BEGIN
        --{
        -- Fill record
        rcRecord.REPOAPLI := 'LECTESP';
        rcRecord.REPOFECH := SYSDATE;
        rcRecord.REPOUSER := pkg_session.fsbgetterminal;
        rcRecord.REPODESC :=
            'INCONSISTENCIAS EN PROCESO DE CARGUE DE LECTURAS ESPECIALES';
        rcRecord.REPOSTEJ := NULL;
        rcRecord.REPONUME := seq.getnext ('SQ_REPORTES');

        -- Insert record
        pktblReportes.insRecord (rcRecord);

        COMMIT;
        RETURN rcRecord.Reponume;
    --}
    END fnuCrReportHeader;

    PROCEDURE crReportDetail (inuIdReporte   IN repoinco.reinrepo%TYPE,
                              inuProduct     IN repoinco.reinval1%TYPE,
                              isbError       IN repoinco.reinobse%TYPE,
                              isbTipo        IN repoinco.reindes1%TYPE)
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        -- Variables
        rcRepoinco   repoinco%ROWTYPE;
    BEGIN
        --{
        rcRepoinco.reinrepo := inuIdReporte;
        rcRepoinco.reinval1 := inuProduct;
        rcRepoinco.reindes1 := isbTipo;
        rcRepoinco.reinobse := isbError;
        rcRepoinco.reincodi := nuConsecutivo;

        -- Insert record
        pktblRepoinco.insrecord (rcRepoinco);
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_Error.SetError;
    END crReportDetail;


    PROCEDURE progeneracritica (isbAccion   IN     VARCHAR2 DEFAULT 'T',
                                osberror       OUT VARCHAR2)
    IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete:   proGeneraCritica
    Descripcion:          Inserta o actualiza los registros No Procesados de la tabla
    LDC_CM_LECTESP_CRIT con los ultimos datos de la tabla LDC_CM_LECTESP
    del periodo de facturacion actual.


    Autor    : Oscar Ospino P.

    Fecha    : 31-05-2016  CA 200-210

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    31-05-2016   Oscar Ospino P.        Creacion
    25-03-2017   Oscar Ospino P.        Se agrega parametro/Flag isbAccion
    27-11-2019   F.Castro.              Cambio 254 - Se modifica cursor cuData2 para que la lectura del periodo la busque solo
                                        por el tipo de lectura F (de facturacion)
    20-02-2022   hahenao                CA 869 - Se elimina parametro de entrada isbAccion de los parametros del metodo,
                                        pues no estaba en uso dentro de la logica
    04/05/2022   LJLB                   CA OSF-75 se ajusta proceso de log para evitar error en el log,
                                        ademas se ajusta proceso para los ciclos telemedidos puedan ser generados las lecturas anteriores
                                        sin incoveniente

    24/05/2022    LJLB                  CA OSF-324 se actualiza campo
    14/07/2023    jpinedc               CA OSF-1309 * Se quita fblAplicaEntrega
                                        * Se quita código que se encuentra en comentarios
                                        * Se hace RAISE en WHEN OTHERS
    18/07/2023    jpinedc               CA OSF-1309 * Se usa pkg_error en WHEN OTHERS
                                        * Se separa el campo cuData2.NuevaLectura
                                        en el cursor cuNuevaLectura
    02/08/2023    jpinedc               CA OSF-1309 * Se hace RAISE en la
                                        excepción exerrcargarcrit
    18-09-2023   jcatuchemvm            OSF-1440:
                                        Se agrega nuevo cursor cuValidaObs para validar la última lectura registrada.
                                        Se eliminan los esquemas a las tablas en las consultas
    ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'progeneracritica';

        --Record Tabla Criticas
        rccritica          ldc_cm_lectesp_crit%ROWTYPE;
        --Secuencia de la tabla de Criticas de Lecturas Especiales.
        nuconsecutivo      NUMBER := 0;

        --Estado Critica
        sbestadocritica    ldc_cm_lectesp_crit.proc%TYPE;

        --Validar/Contar registros en la tabla de criticas
        nucontar           NUMBER;
        --Contar registros insertados en la tabla de Criticas Lecturas Especiales
        nucontarcambios    NUMBER (10) := 0;
        --Errores FrcDatosCritica
        sberrorfn          VARCHAR2 (32000);
        nupaso             NUMBER := 0;
        
        --Excepciones
        exerrcargarcrit    EXCEPTION;

        --Desde la tabla de Moviles, obtengo los productos del periodo actual que no se hayan procesado
        --para insertar la critica
        CURSOR cuprodpefaactual IS
              SELECT DISTINCT l.sesunuse, l.pefacodi, l.pecscons
                FROM ldc_cm_lectesp l,
                     perifact      pf,
                     or_order      o,
                     pericose      pc
               WHERE     o.order_id = l.order_id
                     AND l.pefacodi = pf.pefacodi
                     AND l.pecscons = pc.pecscons
                     AND pf.pefaactu = 'S'
                     AND pc.pecsflav = 'N'
                     AND o.order_status_id <> 8
                     AND l.procesado = 'N'
            ORDER BY l.sesunuse DESC;

        CURSOR cudata2 IS
            --Actualizar Criticas/Lecturas Complementarias a Procesada cuando la OT se haya legalizado previamente
            SELECT DISTINCT
                   c.sesunuse,
                   c.order_id,
                   c.proc,
                   l.procesado,
                   DECODE (os.is_final_status, 'Y', 'S', 'N')
                       NuevoEstado,
                   c.lectfin,
                   l.lect_eagle,
                   l.voltbat,
                   c.presfin,
                   (SELECT NVL (v.vvfcvalo, 0)
                      FROM cm_vavafaco v
                     WHERE     v.vvfcsesu = c.sesunuse
                           AND (o.legalization_date BETWEEN v.vvfcfeiv
                                                        AND v.vvfcfefv)
                           AND v.vvfcvafc = sbVarPresionOperacion)
                       NuevaPresion,
                   (SELECT ch.user_id
                      FROM or_order_stat_change ch
                     WHERE     ch.order_id = c.order_id
                           AND ch.final_status_id = o.order_status_id)
                       usuario,
                   c.programa,
                   l.pefacodi
              FROM or_order             o,
                   ldc_cm_lectesp_crit  c,
                   ldc_cm_lectesp       l,
                   or_order_status      os,
                   perifact             pf
             WHERE     o.order_id = c.order_id
                   AND l.order_id = c.order_id
                   AND l.pefacodi = pf.pefacodi
                   AND os.order_status_id = o.order_status_id
                   AND o.order_status_id IN (8, 12)
                   AND (c.proc = 'N' OR l.procesado = 'N');

        nuIdReporte        NUMBER;
        nuprodproc         NUMBER;
        dtult_fecha_lect   DATE;
        nuError            NUMBER;
        sbError            VARCHAR2(4000);
        
        CURSOR cuNuevaLectura( inuProducto NUMBER, inuPeriFact NUMBER)
        IS
        SELECT lect.leemleto nuevalectura
        FROM lectelme lect
        WHERE     lect.leemsesu = inuProducto
               AND lect.leemclec = 'F'
               AND lect.leempefa = inuPeriFact
               AND lect.leemleto IS NOT NULL
        ORDER BY lect.leemfele DESC;
        
        rcNuevaLectura cuNuevaLectura%ROWTYPE;       
        
        CURSOR cuValidaObs(inuOrden NUMBER, inuProducto NUMBER, inuPerifact NUMBER, inuPericose NUMBER)
        IS
        select unique l.order_id,l.sesunuse,l.pefacodi,l.pecscons,p.pecsfeci,pecsfecf,
        first_value(l.feregistro) over (order by l.feregistro desc,l.consec_ext desc) feregistro,
        first_value(l.felectura) over (order by l.feregistro desc,l.consec_ext desc) felectura,
        first_value(l.procesado) over (order by l.feregistro desc,l.consec_ext desc) procesado,
        first_value(l.consec_ext) over (order by l.feregistro desc,l.consec_ext desc) consec_ext,
        first_value(l.lectura) over (order by l.feregistro desc,l.consec_ext desc) lectura,
        first_value(l.observacion) over (order by l.feregistro desc,l.consec_ext desc) observacion
        from ldc_cm_lectesp l, pericose p
        where l.order_id = inuOrden
        and l.pefacodi = inuPerifact
        and l.pecscons = inuPericose
        and l.sesunuse = inuProducto
        and p.pecscons = l.pecscons
        --and l.procesado = 'N' --validar si en la atencion se gestionan todas los registros adcionales 
        and l.felectura > trunc(p.pecsfecf); --Se toma fecha de lectura que es la que indica cuando se leyo.

        rcValidaObs     cuValidaObs%ROWTYPE;   
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('isbAccion   <= '||isbAccion, csbNivelTraza);
        
        nuIdReporte := fnuCrReportHeader;

        --Actualizo el periodo de consumo de cada periodo de facturacion en la tabla de lecturas especiales
        nupaso := 5;
        proupdatepecobypefa (osberror);

        --Actualizar registros a Procesados cuando la OT se haya legalizado previamente
        FOR rcrd IN cudata2
        LOOP
        
            rcNuevaLectura := null;
            
            OPEN cuNuevaLectura( rcrd.sesunuse , rcrd.pefacodi);
            FETCH cuNuevaLectura INTO rcNuevaLectura;
            CLOSE cuNuevaLectura;
            
            --Se actualiza si la OT esta legalizada
            UPDATE ldc_cm_lectesp_crit c
               SET c.proc = rcrd.NuevoEstado,
                   c.lectfin = rcNuevaLectura.nuevalectura,
                   c.presfin = rcrd.nuevapresion,
                   c.lect_eagle = rcrd.lect_eagle,
                   c.volt_bat = rcrd.voltbat
             WHERE c.order_id = rcrd.order_id;

            --Se actualizan a Procesadas, las Lecturas complementarias de Criticas Legalizadas
            UPDATE ldc_cm_lectesp l
               SET l.procesado = rcrd.NuevoEstado
             WHERE l.order_id = rcrd.order_id AND l.procesado = 'N';

            --Confirmo los cambios
            COMMIT;
        END LOOP;

        --Validar si hay productos a procesar.
        nupaso := 10;

        SELECT COUNT (*)
          INTO nucontar
          FROM (SELECT DISTINCT l.sesunuse
                  FROM ldc_cm_lectesp  l,
                       perifact             pf,
                       pericose        pc
                 WHERE     l.pefacodi = pf.pefacodi
                       AND l.pecscons = pc.pecscons
                       AND pf.pefaactu = 'S'
                       AND pc.pecsflav = 'N'
                       AND l.procesado = 'N');

        pkg_traza.trace ('Ordenes a Procesar --> ' || nucontar, csbNivelTraza);

        --Si hay Datos se generan las criticas.
        IF nucontar > 0
        THEN
            --abro el cursor con los productos a procesar y realizar acciones de acuerdo al estado de la critica.
            nupaso := 15;

            FOR rcprodpefa IN cuprodpefaactual
            LOOP
                --Valido si el producto y periodo ya estan en la tabla de criticas.
                --nucontar = 0 >>> Insertar nueva Critica
                --nucontar = 1 >>> Actualizar Critica existente
                nupaso := 20;
                
                SELECT COUNT (c.proc)
                  INTO nucontar
                  FROM ldc_cm_lectesp_crit c
                 WHERE     c.pefacodi = rcprodpefa.pefacodi
                       AND c.sesunuse = rcprodpefa.sesunuse;

                --Cargar los datos de la Critica.
                nupaso := 25;

                BEGIN
                    nuprodproc := rcprodpefa.sesunuse;
                    sberrorfn := NULL;
                    rccritica :=
                        frcdatoscritica (rcprodpefa.sesunuse,
                                         rcprodpefa.pecscons,
                                         sberrorfn);
                    --INICIO OSF-324
                    dtult_fecha_lect := NULL;

                    SELECT MAX (l.felectura)
                      INTO dtult_fecha_lect
                      FROM ldc_cm_lectesp l
                     WHERE     l.sesunuse = rcprodpefa.sesunuse
                           AND l.pecscons = rcprodpefa.pecscons;

                    rccritica.FECHA_ULTLECT := dtult_fecha_lect;
                --FIN OSF-324
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        pkg_Error.setError;
                        pkg_Error.getError(gnuErr, gsbErr);                       
                        osberror :=
                               osberror
                            || CHR (10)
                            || sberrorfn
                            || CHR (10)
                            || 'NuPaso: '
                            || nupaso
                            || 'Error al cargar los datos de Critica para el Producto: '
                            || rccritica.sesunuse
                            || ' Periodo de facturacion: '
                            || rccritica.pefacodi
                            || CHR (10)
                            || gsbErr;
                        nuConsecutivo := nuConsecutivo + 1;
                        osberror := SUBSTR (osberror, 1, 4000);
                        crReportDetail (nuIdReporte,
                                        rcprodpefa.sesunuse,
                                        osberror,
                                        'S');
                        ROLLBACK;
                        CONTINUE;
                END;

                --Si FrcDatosCritica no devuelve error
                IF sberrorfn IS NULL AND nucontar = 0
                THEN
                    --nucontar = 0 >>> Insertar nueva Critica
                    pkg_traza.trace (
                        'Procesando OT --> ' || rccritica.order_id, csbNivelTraza);

                    BEGIN
                        nupaso := 30;

                        --Coloco la secuencia del registro a insertar.
                        SELECT MAX (critica_id)
                          INTO nuconsecutivo
                          FROM ldc_cm_lectesp_crit;

                        --Actualizo el consecutivo a insertar
                        -- rccritica.critica_id := seq_ldc_cm_lectespcrit.nextval;
                        IF nuconsecutivo IS NULL
                        THEN
                            rccritica.critica_id := 1;
                        ELSE
                            rccritica.critica_id := nuconsecutivo + 1;
                        END IF;

                        --Coloco los periodos en el Record a insertar
                        rccritica.pecscons := rcprodpefa.pecscons;
                        rccritica.pefacodi := rcprodpefa.pefacodi;

                        --Coloco la critica como no Procesada
                        rccritica.proc := 'N';

                        --inserto el registro en la tabla
                        nupaso := 35;

                        INSERT INTO ldc_cm_lectesp_crit
                             VALUES rccritica;

                        pkg_traza.trace ('Insertada Critica OT --> '|| rccritica.order_id, csbNivelTraza);
                        
                        sbestadocritica := 'N';
                        
                        --Indico una nueva insercion
                        nucontarcambios := nucontarcambios + 1;
                        --Confirmo la actualizacion
                        COMMIT;
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            pkg_Error.setError;
                            pkg_Error.getError(gnuErr, gsbErr);                            
                            osberror :=
                                   osberror
                                || CHR (10)
                                || 'Producto: '
                                || rccritica.sesunuse
                                || ' | Periodo de facturacion: '
                                || rccritica.pefacodi
                                || ' | Paso: '
                                || nupaso
                                || '| Error al insertar los datos de Critica. '
                                || CHR (10)
                                || gsbErr;
                            nuConsecutivo := nuConsecutivo + 1;
                            osberror := SUBSTR (osberror, 1, 4000);
                            crReportDetail (nuIdReporte,
                                            rcprodpefa.sesunuse,
                                            osberror,
                                            'S');
                            ROLLBACK;
                            CONTINUE;
                    END;
                ELSIF sberrorfn IS NULL AND nucontar > 0
                THEN

                    nupaso := 40;

                    --obtengo el estado de la critica del producto procesado
                    SELECT c.proc
                      INTO sbestadocritica
                      FROM ldc_cm_lectesp_crit c
                     WHERE     c.pefacodi = rcprodpefa.pefacodi
                           AND c.sesunuse = rcprodpefa.sesunuse;

                    --Verifico si ya se proceso la critica para el producto en el periodo de facturacion solicitado
                    IF sbestadocritica <> 'S' THEN
                        DECLARE
                            sbsqlfinal   VARCHAR (4000);
                            sbupdate     VARCHAR (4000);
                            sbwhere      VARCHAR (4000);
                            sbespacio    VARCHAR (1) := ' ';
                        BEGIN
                            nupaso := 45;
                            --Actualizo la Critica

                            sbupdate :=
                                   'Update ldc_cm_lectesp_crit c Set c.lepresa = :1,lepresb = :2,lepresc = :3,funca  = :4,funcb  = :5,funcc  = :6'
                                || ',consprom = :7,conspromdc = :8,facorrmant = :9,leemleac = :10,leemlean = :11'
                                || ',lectfin = :12,presfin = :13,presmesant = :14,volcorrest = :15,volncorr = :16, proc=:17, lect_eagle=:18, volt_bat=:19, FECHA_ULTLECT=:20';

                            sbwhere :=
                                   'Where c.critica_id ='
                                || rccritica.critica_id
                                || ' AND proc=''N''';

                            --Se borran los flags que se actualizan de importaciones fallidas desde plantilla
                            nupaso := 46;
                            sbupdate :=
                                   sbupdate
                                || sbespacio
                                || ',impexcel=NULL, userexcel=NULL';

                            nupaso := 47;

                            --Se arma Query Final
                            sbsqlfinal :=
                                sbupdate || sbespacio || sbwhere;

                            EXECUTE IMMEDIATE sbsqlfinal
                                USING NVL (rccritica.lepresa, ''),
                                      NVL (rccritica.lepresb, ''),
                                      NVL (rccritica.lepresc, ''),
                                      NVL (rccritica.funca, ''),
                                      NVL (rccritica.funcb, ''),
                                      NVL (rccritica.funcc, ''),
                                      rccritica.consprom,
                                      rccritica.conspromdc,
                                      rccritica.facorrmant,
                                      rccritica.leemleac,
                                      rccritica.leemlean,
                                      NVL (rccritica.lectfin, ''),
                                      NVL (rccritica.presfin, ''),
                                      rccritica.presmesant,
                                      NVL (rccritica.volcorrest, ''),
                                      NVL (rccritica.volncorr, ''),
                                      rccritica.proc,
                                      rccritica.lect_eagle,
                                      rccritica.volt_bat,
                                      rccritica.FECHA_ULTLECT;


                            pkg_traza.trace ('Actualizada Critica OT --> '|| rccritica.order_id, csbNivelTraza);
                            
                            --Indico un nuevo cambio
                            nucontarcambios := nucontarcambios + 1;
                            --Confirmo la actualizacion
                            COMMIT;
                        EXCEPTION
                            WHEN OTHERS
                            THEN
                                pkg_Error.setError;
                                pkg_Error.getError(gnuErr, gsbErr);                               
                                osberror :=
                                       osberror
                                    || CHR (10)
                                    || 'Producto: '
                                    || rccritica.sesunuse
                                    || ' | Periodo de facturacion: '
                                    || rccritica.pefacodi
                                    || ' | Paso: '
                                    || nupaso
                                    || '| Error al insertar los datos de Critica. '
                                    || CHR (10)
                                    || gsbErr;
                                nuConsecutivo := nuConsecutivo + 1;
                                osberror := SUBSTR (osberror, 1, 4000);
                                crReportDetail (nuIdReporte,
                                                rcprodpefa.sesunuse,
                                                osberror,
                                                'S');
                                ROLLBACK;
                                CONTINUE;

                        END;
                    END IF;
                ELSE
                    nupaso := 50;
                    osberror :=
                           osberror
                        || CHR (10)
                        || 'Producto: '
                        || rccritica.sesunuse
                        || ' | Periodo de facturacion: '
                        || rccritica.pefacodi
                        || ' | Paso: '
                        || nupaso
                        || '| Error al generar los datos de Critica. '
                        || CHR (10)
                        || sberrorfn;
                    nuConsecutivo := nuConsecutivo + 1;
                    osberror := SUBSTR (osberror, 1, 4000);
                    crReportDetail (nuIdReporte,
                                    rcprodpefa.sesunuse,
                                    osberror,
                                    'S');
                    ROLLBACK;
                    CONTINUE;
                    pkg_traza.trace (osberror, csbNivelTraza);
                END IF;
                
                --Validación de observación último registro despúes del fin del periodo
                IF sberrorfn IS NULL AND sbestadocritica <> 'S' THEN
                    
                    IF cuValidaObs%ISOPEN THEN 
                        CLOSE cuValidaObs;
                    END IF;
                    
                    rcValidaObs := null;
                    open cuValidaObs(rccritica.order_id,rccritica.sesunuse,rccritica.pefacodi,rccritica.pecscons);
                    fetch cuValidaObs into rcValidaObs;
                    close cuValidaObs;
                    
                    --Si no obtiene información, corresponden a lecturas piloto previas, no se valida la observación
                    IF rcValidaObs.order_id IS NOT NULL THEN
                        
                        IF NVL(INSTR(','||sbObservaciones||',',','||rcValidaObs.observacion||','),0) > 0 THEN
                            --Gestiona la orden desde el Job, se envia lectura en null ya que tiene observación
                            proprocesacritica(rccritica.critica_id, NVL(rccritica.presfin, ''), NULL, sberrorfn,rcValidaObs.observacion); 
                            
                            if sberrorfn is not null then
                                nupaso := 60;
                                osberror :=
                                       osberror
                                    || CHR (10)
                                    || 'Producto: '
                                    || rccritica.sesunuse
                                    || ' | Periodo de facturacion: '
                                    || rccritica.pefacodi
                                    || ' | Paso: '
                                    || nupaso
                                    || '| Error al procesar critica con observación de no lectura '
                                    || CHR (10)
                                    || sberrorfn;
                                nuConsecutivo := nuConsecutivo + 1;
                                osberror := SUBSTR (osberror, 1, 4000);
                                crReportDetail (nuIdReporte,
                                                rcprodpefa.sesunuse,
                                                osberror,
                                                'S');
                                ROLLBACK;
                                CONTINUE;
                                pkg_traza.trace (osberror, csbNivelTraza);
                            else
                                commit;
                            end  if;
                            
                                      
                        END IF;
                        
                    END IF;
                END IF;
                
            END LOOP;
        END IF;

        -- Si se hicieron insert o updates, confirmo los cambios
        IF nucontarcambios > 0
        THEN
            --Confirmo la actualizacion
            COMMIT;
        END IF;

        --Si hubo errores, se instancia
        IF osberror IS NOT NULL
        THEN
            RAISE exerrcargarcrit;
        END IF;

        pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN exerrcargarcrit
        THEN
            osberror :=
                   CHR (10)
                || '*** Inicio Proceso Generacion de datos Critica   *** '
                || CHR (10)
                || ''
                || ' | '
                || csbMetodo
                || ' | Sesion: '
                || gnusesion
                || ' | Paso: ('
                || nupaso
                || ')'
                || CHR (10)
                || osberror
                || CHR (10)
                || '*** Fin Proceso Generacion de datos Critica. ***'
                || CHR (10)
                || CHR (10);
            nuConsecutivo := nuConsecutivo + 1;
            osberror := SUBSTR (osberror, 1, 4000);
            crReportDetail (nuIdReporte,
                            nuprodproc,
                            osberror,
                            'S');
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            ROLLBACK;
            pkg_error.setErrorMessage( isbMsgErrr => osberror); 
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr, gsbErr);            
            osberror :=
                   CHR (10)
                || '*** Inicio Proceso Generacion de datos Critica   *** '
                || CHR (10)
                || ''
                || ' | '
                || csbMetodo
                || ' | Sesion: '
                || gnusesion
                || ' | Paso: ('
                || nupaso
                || ')'
                || CHR (10)
                || osberror
                || CHR (10)
                || ' | Detalle Error: '
                || gsbErr
                || CHR (10)
                || '*** Fin Proceso Generacion de datos Critica. ***'
                || CHR (10)
                || CHR (10);
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            ROLLBACK;
            pkg_error.setErrorMessage( isbMsgErrr => osberror); 
    END progeneracritica;

    FUNCTION fcrobtenercriticas (isbAccion   IN     VARCHAR2 DEFAULT 'NP',
                                 osberror       OUT VARCHAR2)
        RETURN constants_per.tyrefcursor
    IS
        /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fcrObtenerCriticas
    Descripcion:        Devuelve un cursor referenciado con los productos de la tabla LDC_CM_LECTESP_CRIT
                        del periodo de facturacion actual.

    Parametros:
    isbAccion:          PA-Periodo Actual, T-Todos, H-Historico (No incluye periodos actuales)
    osberror:           Salida de Errores

    Autor    : Oscar Ospino P.
    Fecha    : 06-05-2016  CA 200-210

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    06-05-2016   Oscar Ospino P.        Creacion
    12-12-2016   Oscar Ospino P.        CA 200-856: Se adiciona campo SORT_ID al cursor para manejar ordenamiento
                                        de los datos en la forma .NET.
    25-03-2017   Oscar Ospino P.        Se agrega parametro/Flag isbAccion
    18-02-2022   hahenao.Horbath        CA869:
                                        *Se ajusta FCROBTENERCRITICAS adiciona condicion para consultar historico
                                        de criticas con periodos previos.
 30-06-2023   cgonzalez              OSF-1282:
          Se modifica el servicio para retornar la direccion de lectura del producto y no la del cliente
    ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fcrobtenercriticas';
        cucritica           constants_per.tyrefcursor;
        sbselect            VARCHAR2 (4000);        -- Columnas de la consulta
        sbfrom              ge_boutilities.stystatement; -- Tablas de la consulta
        sbwhere             ge_boutilities.stystatement; -- Filtros de consulta
        sbOrderby           ge_boutilities.stystatement;  -- Orden de Columnas
        sbsqlfinal          ge_boutilities.stystatement;     -- Query Dinamico
        sbEspacio           VARCHAR (1) := ' ';
        sbentrega_2001390   VARCHAR2 (50) := 'BSS_FACT_LJLB_2001390_1'; --TICKET 2001390 LJLB -- se coloca identificador de la entrega
        nuYearAct           NUMBER;
        nuMonthAct          NUMBER;
        nuYearReal          NUMBER;
        nuMonthReal         NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('isbAccion   <= '||isbAccion, csbNivelTraza);

        sbselect :=
               'Select /*+ index(c idxcons01_lectesp_crit) */ c.critica_id,c.sesunuse,gs.subscriber_name || '
            || sbEspacio
            || ' nvl(gs.subs_last_name, '''
            || sbEspacio
            || ''') nombre,'
        || '(select ad.address_parsed from ab_address ad where pr.address_id = ad.address_id ) address_parsed,serv.sesucico,c.pefacodi,c.pecscons,c.consprom,c.conspromdc,c.leemlean,c.leemleac,'
            || 'trunc(c.volncorr,2) volncorr,trunc(c.presmesant,2) presmesant,trunc(c.facorrmant,2) facorrmant,trunc(c.volcorrest,2) volcorrest,'
            || 'trunc(c.lepresa,2) lepresa,c.funca,c.caupresa,trunc(c.lepresb,2) lepresb,c.funcb,'
            || 'c.caupresb,trunc(c.lepresc,2) lepresc,c.funcc,c.caupresc,trunc(c.presfin,2) presfin,c.lectfin,c.proc';

        sbfrom :=
        'From ldc_cm_lectesp_crit c,suscripc contr,servsusc serv,
                     ge_subscriber gs,perifact pf, pr_product pr';

        sbwhere :=
               'Where c.sesunuse = serv.sesunuse And serv.sesunuse = pr.product_id And serv.sesususc = contr.susccodi And'
            || sbEspacio
            || 'ldc_pkcm_lectesp.fsbGetCiclo(pf.pefacicl) = ''S'' And'
            || sbEspacio
            || 'contr.suscclie = gs.subscriber_id  And'
            || sbEspacio
            || 'c.pefacodi = pf.pefacodi And pf.pefaactu = ''S'' ';

        sbOrderby :=
            'Order By c.proc,serv.sesucico,c.pefacodi Desc,c.sesunuse';
       
        --Se agrega campo SORT_ID para funcionalidad de ordenamiento de Productos en la Forma .NET LECTESPCRIT
        sbselect := sbselect || ',c.sort_id';
        sbOrderby :=
            'Order By c.sort_id,c.proc,serv.sesucico,c.pefacodi Desc,c.sesunuse';


        --Marcar como procesados OT legalizadas por fuera de la forma
        sbselect :=
               sbselect
        || ',(SELECT nvl(SUM (cosscoca),0) FROM conssesu WHERE cosssesu=c.sesunuse AND cosspecs=c.pecscons AND cossmecc=4) VolFacturado';
        sbselect :=
               sbselect
        || ',(select o.legalization_date from or_order o where  o.order_id =c.order_id)  Fecha_legal, pf.pefaano ano, pf.pefames mes';
        sbselect :=
               sbselect
        || ', pkg_bcdirecciones.fnugetubicageopadre(pkg_bcdirecciones.fnugetlocalidad(pr.address_id)) || ''-'' ||
                     pkg_bcdirecciones.fsbgetdescripcionubicageo(pkg_bcdirecciones.fnugetubicageopadre(pkg_bcdirecciones.fnugetlocalidad(pr.address_id))) DPTO';

        sbselect :=
               sbselect
            || ', (SELECT user_id usuario FROM or_order_stat_change e WHERE e.order_id =c.order_id AND e.final_status_id=8 AND ROWNUM < 2) Usuario_lega';
        sbselect :=
               sbselect
        || ',nvl(c.maquina,(Select decode(o.order_status_id,8,ch.terminal,12,ch.terminal,'''') From or_order_stat_change ch, or_order o Where ch.order_id = o.order_id and ch.order_id = c.order_id And ch.final_status_id = o.order_status_id AND ROWNUM < 2)) terminal, impexcel';


        IF isbAccion IS NULL OR isbAccion = 'NP'
        THEN
            --Todos los productos/OT No Procesados
            sbselect :=
                   sbselect
            || ',serv.sesuesco || ''-'' || SUBSTR(replace(daestacort.fsbgetescodesc(serv.sesuesco),''-'',''''),1,27) estado_corte';
            sbselect :=
                   sbselect
                || ',decode(UPPER(serv.sesuesfn), ''A'', ''A-AL DIA'', ''D'', ''D-CON DEUDA'', ''M'', ''M-EN MORA'', ''C'', ''C- CASTIGADO'', serv.sesuesfn) estado_financiero';
            sbwhere :=
                   sbwhere
                || sbespacio
                || 'and (c.proc=''N'' OR (c.proc=''S'' AND pf.pefaactu=''S''))';
        ELSIF isbAccion = 'HP'
        THEN
            --Historico de Procesados en Periodos diferentes al Actual
            --Pestaña Historial de Criticas .NET LECTESPCRIT

            --Se obtiene el a¿o y mes anterior de la fecha actual
            SELECT TO_CHAR (SYSDATE, 'YYYY'), TO_CHAR (SYSDATE, 'MM')
              INTO nuYearAct, nuMonthAct
              FROM DUAL;

            IF (nuMonthAct = 1 OR nuMonthAct = 01)
            THEN
                nuYearReal := nuYearAct - 1;
                nuMonthReal := 12;
            ELSE
                nuYearReal := nuYearAct;
                nuMonthReal := nuMonthAct - 1;
            END IF;

            sbwhere :=
                   sbwhere
                || sbespacio
                || 'and c.proc = ''S'' and pf.pefaano = '
                || nuYearReal
                || ' and pf.pefames = '
                || nuMonthReal
                || ' and pf.pefaactu <> ''S''';
      
        END IF;

        sbselect :=
               sbselect
            || ', nvl(TO_CHAR(c.FECHA_ULTLECT),'''')  UFECH_LECT';
        
        IF sbMostrarDatosNR = 'S'
        THEN
            sbselect := sbselect || ', c.lect_eagle, c.volt_bat';
        END IF;

        --Se arma el Query Dinamico
        sbsqlfinal :=
               sbselect
            || sbEspacio
            || sbfrom
            || sbEspacio
            || sbwhere
            || sbEspacio
            || sbOrderby;
        --Log
        pkg_traza.trace (sbsqlfinal, csbNivelTraza);

        OPEN cucritica FOR sbsqlfinal;

        pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN cucritica;
    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr, gsbErr);       
            osberror :=
                'ERROR AL CARGAR LOS DATOS DE LA CRITICA PARA EL PERIODO DE FACTUACION ACTUAL';
            osberror := osberror || CHR (10) || gsbErr;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN cucritica;
    END fcrobtenercriticas;

    PROCEDURE proprocesacritica (
        inucriticaid      IN     ldc_cm_lectesp_crit.critica_id%TYPE,
        inupresionfinal   IN     ldc_cm_lectesp_crit.presfin%TYPE,
        inulecturafinal   IN     ldc_cm_lectesp_crit.lectfin%TYPE,
        osberror          OUT    VARCHAR2,
        inuObselect       IN     NUMBER DEFAULT NULL)
    IS
        /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: proProcesaCritica
    Descripcion:        Actualiza la critica y la marca como procesada en la tabla de Criticas
                        y en la tabla de las Lecturas Moviles.

    Autor    : Oscar Ospino P.
    Fecha    : 02-06-2016  CA 200-210

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    02-06-2016   Oscar Ospino P.        Creacion
    22-07-2016   Oscar Ospino P.        Se cambia proceso que realiza la legalizacion de las ordenes de lectura
                                        Se obtienen los parametros OBSERVACION_LEGA_OR_LECTESP,COMENTARIO_LEGA_OR_LECTESP,
                                        CAUSAL_LEGA_OR_LECTESP para realizar la legalizacion.
    05-01-2017   Oscar Ospino P.        CA 200-856: Se modifican parametros de fecha enviados (sysdate) al proceso de legalizacion
                                        OS_LEGALIZEORDERS para que la fecha de legalizacion sea igual a la fecha de lectura
                                        para prevenir aumento del # de dias de consumo del producto.
    21-05-2021   Horbath                CA633 (CA333): Se ajusta el servicio ProProcesaCritica
    20-07-2021   Horbath                CA633 (Cambio de alcance) Se modifica para que si el tipo de trabajo no
                                        es el de lectura normal (12617) no se actualice la presion
    16-02-2022   hahenao.Horbath        CA869 - Se adiciona parametro de ultima fecha de lectura para actualizarlo en la
                                        tabla ldc_cm_lectesp_crit.
    17-10-2023   jcatuchemvm            OSF-1440:
                                        Se agrega nueva variable de entrada inuObselect, la cual tendra la observación de no lectura validada
                                        Se agrega nuevo cursor cuValidaObs para validar la última lectura registrada desde el identificador de la crítica
                                        Se eliminan los esquemas a las tablas en las consultas
                                        Se valida si el proceso es ejecutado desde lectespcrit, para consultar la obsrvación desde la tabla y asi garantizar
                                        el mismo procesamiento de las órdenes, tanto por el Job, como por la forma. Ref Monica Olivella
                                        Se agrega la observación en la cadena de legalización
    ******************************************************************/

        PRAGMA AUTONOMOUS_TRANSACTION;

        CURSOR cuTipoCiclo IS
            SELECT tc.task_type_id
              FROM ldc_cm_lectesp_crit  c,
                   perifact             pf,
                   LDC_CM_LECTESP_CICL  CI,
                   ldc_cm_lectesp_tpcl  tc
             WHERE     c.pefacodi = pf.pefacodi
                   AND ci.pecscico = pf.pefacicl
                   AND tc.tipocicl_id = ci.pecstpci
                   AND c.critica_id = inucriticaid;
                   
        CURSOR cuValidaObs IS
        with critica as
        (
            select order_id,sesunuse,pefacodi,pecscons 
            from ldc_cm_lectesp_crit
            where critica_id = inucriticaid
        )
        select unique l.order_id,l.sesunuse,l.pefacodi,l.pecscons,p.pecsfeci,pecsfecf,
        first_value(l.feregistro) over (order by l.feregistro desc,l.consec_ext desc) feregistro,
        first_value(l.felectura) over (order by l.feregistro desc,l.consec_ext desc) felectura,
        first_value(l.procesado) over (order by l.feregistro desc,l.consec_ext desc) procesado,
        first_value(l.consec_ext) over (order by l.feregistro desc,l.consec_ext desc) consec_ext,
        first_value(l.lectura) over (order by l.feregistro desc,l.consec_ext desc) lectura,
        first_value(l.observacion) over (order by l.feregistro desc,l.consec_ext desc) observacion
        from ldc_cm_lectesp l, pericose p,critica
        where l.order_id = critica.order_id
        and l.pefacodi = critica.pefacodi
        and l.pecscons = critica.pecscons
        and l.sesunuse = critica.sesunuse
        and p.pecscons = l.pecscons
        and l.felectura > trunc(p.pecsfecf); 
        
        rcValidaObs     cuValidaObs%ROWTYPE;  

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proprocesacritica';
        nupaso                   VARCHAR2 (4000) := '0';
        nutask_type              or_order.task_type_id%TYPE;

        rcorden                  or_order%ROWTYPE;
        rccritica                ldc_cm_lectesp_crit%ROWTYPE;
        
        

        --Usuario Conectado
        nuusuario                NUMBER := pkg_session.getUserId; 
        --Codigo Persona Legalizacion
        nupersonid               NUMBER := pkg_bopersonal.fnugetpersonaid;
        --Codigo Causal Legalizacion
        nucausal                 or_task_type_causal.causal_id%TYPE;
        --Codigo Observacion Legalizacion
        nuobser_lega             obselect.oblecodi%TYPE;
        --Codigo Actividad Legalizacion
        nuactividadot            or_order_activity.order_activity_id%TYPE;
        --Codigo Comentario Legalizacion
        nutipocomentario         or_task_type_comment.comment_type_id%TYPE;
        --Serie del Medidor
        sbmedidor                VARCHAR2 (4000);
        --Validar existencias de datos (consultas Into)
        nucontador               NUMBER;
        --Temperatura de la ultima lectura de control
        nutemperatura            NUMBER;

        --Contador Validacion Lectura registrada en Legalizacion
        nucontlect               NUMBER;
        --Contador Validacion Consumo registrada en Legalizacion
        nucontcons               NUMBER;

        --Variables para Cadena de Legalizacion
        sbcadenalegalizacionot   VARCHAR2 (4000);
        sbcomentario             VARCHAR2 (4000);
        sbdatosadicionales       VARCHAR2 (4000);

        --Excepciones
        excargaorden             EXCEPTION;
        excargacausal            EXCEPTION;
        excargacritica           EXCEPTION;
        exclegalizar             EXCEPTION;
        excordenestado           EXCEPTION;
        excpersonid              EXCEPTION;
        excpresfaco              EXCEPTION;
        excmedidor               EXCEPTION;
        excentrega               EXCEPTION;

        nuerror                  NUMBER;

        nuFlag                   NUMBER;

        --Fecha de Lectura de la Ultima Orden de Control
        dtult_fecha_lect         ldc_cm_lectesp.felectura%TYPE;
        dtfecha_exe_ini          ldc_cm_lectesp.felectura%TYPE;

        nuActividad              LD_PARAMETER.NUMERIC_VALUE%TYPE := pkg_bcld_parameter.fnuobtienevalornumerico ('COD_ACT_LEC');

        sbesTelemedido           VARCHAR2 (1) := 'N';
        
        nuObselect               obselect.oblecodi%TYPE;
        nulecturafinal           number;
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        nupaso := '1';
        pkg_traza.trace('inucriticaid       <= '||inucriticaid,csbNivelTraza);      
        pkg_traza.trace('inupresionfinal    <= '||inupresionfinal,csbNivelTraza);   
        pkg_traza.trace('inulecturafinal    <= '||inulecturafinal,csbNivelTraza); 
        pkg_traza.trace('inuObselect        <= '||inuObselect,csbNivelTraza); 
          
        
        --Asignación variables de entrada
        nuObselect := inuObselect;
        nulecturafinal := inulecturafinal;
        
        --Valida si no hay observación, ejecución desde lectespcrit, se obtiene la observación desde la tabla
        IF nuObselect IS NULL THEN
        
            open cuValidaObs;
            fetch cuValidaObs into rcValidaObs;
            close cuValidaObs;
            
            --Valida si tiene observación
            IF rcValidaObs.order_id IS NOT NULL THEN
                --Valida si la observación esta configurada en el parámetro        
                IF NVL(INSTR(','||sbObservaciones||',',','||rcValidaObs.observacion||','),0) > 0 THEN
                    --Asigna la observación encontrada y asigna la lectura a null
                    nuObselect := rcValidaObs.observacion;
                    nulecturafinal := NULL;
                END IF;
                
            END IF;
            
        END IF;
        
        -- Cargo La Critica a actualizar
        nupaso := '10';

        BEGIN
            SELECT *
              INTO rccritica
        FROM ldc_cm_lectesp_crit c
             WHERE c.critica_id = inucriticaid;
        EXCEPTION
        WHEN OTHERS THEN
                RAISE excargacritica;
        END;

        -- CA633 (CA333) - Se valida si el estado de corte no está dentro del parámetro LDC_ESTA_CORTE_NO_VAL_CRIT
        IF INSTR (
                  ','
               || pkg_bcld_parameter.fsbobtienevalorcadena (
                      'LDC_ESTA_CORTE_NO_VAL_CRIT')
               || ',',
                  ','
               || pkg_bcproducto.fnuestadocorte (rccritica.sesunuse)
               || ',') = 0 THEN
            -- Halla si es telemedido
            sbesTelemedido := fsbesTelemedido (rccritica.pecscons);

            pkg_traza.trace ('sbesTelemedido ' || sbesTelemedido, csbNivelTraza);

            --Temperatura de la ultima lectura de control
            nupaso := 15;

            BEGIN
                SELECT lect.temperatura
                  INTO nutemperatura
                  FROM (  SELECT l.temperatura
                FROM ldc_cm_lectesp l
                           WHERE     l.sesunuse = rccritica.sesunuse
                                 AND l.pecscons = rccritica.pecscons
                        ORDER BY l.feregistro DESC,
                                 l.consec_ext DESC,
                                 l.felectura DESC) lect
                 WHERE ROWNUM = 1;
            EXCEPTION
                WHEN OTHERS THEN
                    nutemperatura := 0;
            END;

            pkg_traza.trace ('nutemperatura ' || nutemperatura, csbNivelTraza);

            -- Cargo los datos de la Orden a Legalizar
            nupaso := '20';

            BEGIN
                SELECT *
                  INTO rcorden
            FROM or_order o
                 WHERE o.order_id = rccritica.order_id;
            EXCEPTION
            WHEN OTHERS THEN
                    RAISE excargaorden;
            END;


            -- halla tipo de ciclo pues si corresponde al nuevo tipo de trabajo de lectura especial no lleva lectura
            nupaso := '25';

            OPEN cuTipoCiclo;

            FETCH cuTipoCiclo INTO nutask_type;

            IF cuTipoCiclo%NOTFOUND OR nutask_type IS NULL THEN
                nutask_type := 12617;                           -- lectura
            END IF;

            CLOSE cuTipoCiclo;

            pkg_traza.trace ('nutask_type ' || nutask_type, csbNivelTraza);

            IF nutask_type = 12617 THEN                                                  -- CA633
                --Valido si el cliente es Especial (Industrial) a traves de las variables de Presion
                nupaso := '30';

                SELECT COUNT (vv.vvfccons)
                  INTO nucontador
                FROM cm_vavafaco vv
                 WHERE     vv.vvfcvafc = 'PRESION_OPERACION'
                       AND vv.vvfcsesu = rccritica.sesunuse;

                pkg_traza.trace ('nucontador ' || nucontador, csbNivelTraza);

                IF nucontador = 0 THEN
                    osberror := 'Error: No se encontro la variable "Presion Operacion" para el Producto.';
                    RAISE excpresfaco;
                END IF;
            END IF;

            --Se Carga la causal de legalizacion asociada al tipo de trabajo de la orden
            nupaso := '40';

            BEGIN
                --Version 1
                SELECT o.causal_id
                  INTO nucausal
                  FROM or_task_type_causal o, ge_causal g
                 WHERE     o.causal_id = g.causal_id
                       AND o.task_type_id = rcorden.task_type_id
                       AND g.causal_type_id = 1;

                pkg_traza.trace ('nucausal ' || nucausal, csbNivelTraza);

                IF NOT (nucausal > 0) THEN
                    osberror := 'No es posible obtener la Causal de Legalizacion definida en el parametro CAUSAL_LEGA_OR_LECTESP. ';
                    RAISE excargacausal;
                END IF;
            EXCEPTION
                WHEN TOO_MANY_ROWS THEN
                    osberror := 'Existe mas de una Causal de cumplimiento para la legalizacion de la orden. ';
                    RAISE pkg_Error.controlled_error;
                WHEN OTHERS THEN
                    osberror := 'No es posible obtener la Causal de Legalizacion definida en el parametro CAUSAL_LEGA_OR_LECTESP. ';
                    RAISE pkg_Error.controlled_error;
            END;

            -- Busco la actividad de la orden
            nupaso := '50';

            BEGIN
                SELECT ooa.order_activity_id
                INTO nuactividadot
                  FROM or_order_activity ooa
                 WHERE ooa.order_id = rcorden.order_id;
            
                pkg_traza.trace ('nuactividadot ' || nuactividadot, csbNivelTraza);
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    osberror := 'No se encontro actividad para legalizar para la orden ' || rcorden.order_id;
                    RAISE pkg_Error.controlled_error;
                WHEN TOO_MANY_ROWS THEN
                    osberror := 'Existe mas de una actividad para legalizar la orden ' || rcorden.order_id;
                    RAISE pkg_Error.controlled_error;
                WHEN OTHERS THEN
                    pkg_Error.setError;
                    pkg_Error.getError(gnuErr, gsbErr);                  
                    osberror := 'No fue posible obtener las actividades a legalizar para la orden generada ' || 
                                rcorden.order_id || 
                                '. ' || gsbErr;
                    RAISE pkg_Error.controlled_error;
            END;

            --Se verifica que la orden tenga un estado valido para legalizar
            nupaso := '60';

            pkg_traza.trace ('order_status_id ' || rcorden.order_status_id, csbNivelTraza);

            IF rcorden.order_status_id NOT IN (5, 6, 7) THEN 
                --la orden no tiene estado valido
                osberror := 'La orden no tiene estado valido para legalizar.';
                RAISE excordenestado;
            END IF;

            --Se valida que el Person_Id este asignado a la unidad operativa
            nupaso := '70';

            BEGIN
                nucontador := 0;

                SELECT COUNT (person_id)
                  INTO nucontador
                  FROM or_oper_unit_persons
                 WHERE     operating_unit_id = rcorden.operating_unit_id
                       AND person_id = nupersonid;

                pkg_traza.trace ('nucontador ' || nucontador, csbNivelTraza);

                IF NOT (nucontador > 0) THEN
                    RAISE excpersonid;
                END IF;
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE excpersonid;
            END;

            --Obtengo el Tipo de comentario asociado al tipo de trabajo de la Orden
            nupaso := '80';

            BEGIN
                SELECT otc.comment_type_id
                  INTO nutipocomentario
                  FROM or_task_type_comment otc
                 WHERE otc.task_type_id = rcorden.task_type_id;

                pkg_traza.trace ('nutipocomentario ' || nutipocomentario, csbNivelTraza);

                --El Comentario de Legalizacion por defecto es almacenado en la variable SBCOMENTARIO
                BEGIN
                    sbcomentario := 'ORDEN LEGALIZADA POR PROCESO DE CRITICA DE LECTURAS COMPLEMENTARIAS FORMA LECTESPCRIT';
                EXCEPTION
                    WHEN OTHERS THEN
                        sbcomentario := 'ORDEN LEGALIZADA POR PROCESO DE CRITICA DE LECTURAS COMPLEMENTARIAS FORMA LECTESPCRIT';
                END;

                -- ** formato de la cadena de legalizacion **
                sbcomentario :=
                       nutipocomentario
                    || ';'
                    || sbcomentario
                    || ', Presion Final: '
                    || inupresionfinal
                    || '  Temperatura: '
                    || nutemperatura;
                    
                pkg_traza.trace ('sbcomentario ' || sbcomentario, csbNivelTraza);
            EXCEPTION
                WHEN TOO_MANY_ROWS THEN
                    osberror := 'Existe mas de un Tipo de Comentario asociado al tipo de trabajo' || rcorden.task_type_id;
                    RAISE pkg_Error.controlled_error;
                WHEN OTHERS THEN
                    osberror := 'No se pudo obtener el Tipo de Comentario asociado al tipo de trabajo' || rcorden.task_type_id;
                    RAISE pkg_Error.controlled_error;
            END;

            --Se carga la observacion con la que se realizara la legalizacion
            --Lectura Normal
            nupaso := '90';

            BEGIN
                
                nuobser_lega := null;
                
                SELECT o.oblecodi
                  INTO nuobser_lega
                  FROM obselect o
                 WHERE o.obledesc = 'LECTURA NORMAL' AND ROWNUM = 1;

                pkg_traza.trace ('nuobser_lega ' || nuobser_lega, csbNivelTraza);

                IF NOT (nuobser_lega) >= 0 THEN
                    osberror := 'No se pudo obtener el codigo de observacion para legalizar.';
                    RAISE pkg_Error.controlled_error;
                END IF;
            EXCEPTION
                WHEN TOO_MANY_ROWS THEN
                    osberror := 'Existe mas de un codigo de observacion para legalizar.';
                    RAISE pkg_Error.controlled_error;
                WHEN OTHERS THEN
                    osberror := 'No se pudo obtener el codigo de observacion para legalizar.';
                    RAISE pkg_Error.controlled_error;
            END;

            --Actualizo la variable de presion en CM_VAVAFACO
            -- si el tipo de trabajo no es el de lectura normal no se actualiza la presion CA633 (CAMBIO DE ALCANCE)
            nupaso := '100';

            --Ojo! No se confirma hasta que la orden este legalizada
            IF nutask_type = 12617 THEN                                                  -- CA633
                BEGIN
            
                    pkg_traza.trace ('proactualizapresfaco rccritica.sesunuse: ' || rccritica.sesunuse || chr(10) || 
                                                     'rccritica.order_id: ' || rccritica.order_id || chr(10) || 
                                                     'inupresionfinal: ' 	|| inupresionfinal	  || chr(10) || 
                                                     'rccritica.PECSCONS: ' || rccritica.PECSCONS, csbNivelTraza);
            
                    proactualizapresfaco (rccritica.sesunuse,
                                          rccritica.order_id,
                                          inupresionfinal,
                                          rccritica.PECSCONS,
                                          osberror);

                    pkg_traza.trace ('proactualizapresfaco osberror' || osberror, csbNivelTraza);

                    IF osberror IS NOT NULL THEN
                        -- si es telemedido no se genera raise
                        IF sbesTelemedido = 'N' THEN
                            RAISE excpresfaco;
                        END IF;
                    END IF;
                EXCEPTION
                    WHEN OTHERS THEN
                        RAISE excpresfaco;
                END;
            END IF;                           -- CA633 (CAMBIO DE ALCANCE)

            pkg_traza.trace('Obteniendo Serie del Medidor del Producto ' || rccritica.sesunuse, csbNivelTraza);

            --Obtengo la serie del medidor actual
            nupaso := '105';

            pkg_traza.trace ('sbesTelemedido ' || sbesTelemedido, csbNivelTraza);

            IF sbesTelemedido = 'N' THEN
                BEGIN
                    SELECT DISTINCT z.emsscoem
                      INTO sbmedidor
                    FROM elmesesu z
                     WHERE     z.emsssesu = rccritica.sesunuse
                           AND (   z.emssfere IS NULL
                                OR z.emssfere > SYSDATE)
                           AND ROWNUM <= 1;
                
                    pkg_traza.trace ('sbmedidor ' || sbmedidor, csbNivelTraza);
                EXCEPTION
                    WHEN OTHERS THEN
                        osberror := 'Error al obtener el medidor actual del Producto';
                        RAISE pkg_Error.controlled_error;
                END;
            END IF;

            --Obtengo la fecha de lectura de la ultima lectura de control
            nupaso := '106';

            BEGIN
                SELECT MAX (l.felectura)
                  INTO dtult_fecha_lect
                FROM ldc_cm_lectesp l
                 WHERE     l.sesunuse = rccritica.sesunuse
                       AND l.pecscons = rccritica.pecscons;

                pkg_traza.trace('Fecha para proceso de legalizacion ' || dtult_fecha_lect, csbNivelTraza);
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    osberror := 'No se pudo obtener la fecha de lectura de la ultima orden de control. | Orden ' || rccritica.order_id;
                    RAISE pkg_Error.controlled_error;
                WHEN OTHERS THEN
                    osberror := 'Error al obtener la fecha de lectura de la ultima orden de control. | Orden ' || rccritica.order_id;
                    RAISE pkg_Error.controlled_error;
            END;

            pkg_traza.trace('Construyendo cadena de legalizacion para la Orden ' || rcorden.order_id, csbNivelTraza);
            --Se arma la cadena de legalizacion como indica en la
            --ayuda de OSF (Legalización de órdenes de Trabajo por Archivo Plano)
            nupaso := '110';
            --Datos adicionales
            sbdatosadicionales := '';

            --Cadena Ejemplo
            /*30181210|9688|1||29812886>1;READING>527>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||1277;, Presion: 1.35, Temperatura: 0*/

            -- Construir la cadena con los datos de la orden --> Orden|Causal|Persona|DatosAdicionales|Actividades|ItemsElementos|TipoComentario|ComentariosOrden


            -- halla tipo de ciclo pues si corresponde al nuevo tipo de trabajo de lectura especial no lleva lectura
            OPEN cuTipoCiclo;

            FETCH cuTipoCiclo INTO nutask_type;

            IF cuTipoCiclo%NOTFOUND OR nutask_type IS NULL THEN
                nutask_type := 12617;                       -- lectura
            END IF;

            CLOSE cuTipoCiclo;

            -- Se valida cuantas veces esta la orden en la entidad LDC_CM_LECTESP para determinar la cantidad a legalizar
            SELECT COUNT (1)
              INTO nuFlag
            FROM LDC_CM_LECTESP
            WHERE LDC_CM_LECTESP.Order_Id = rcorden.order_id;

            pkg_traza.trace('nuFlag ' || nuFlag,  csbNivelTraza);

            IF nuFlag > 3 THEN
                nuFlag := 3;         -- No se puede legalizar mas de 3
            END IF;

            --opcion1
            IF nutask_type = 12617
            THEN
                sbcadenalegalizacionot :=
                       rcorden.order_id
                    || '|'
                    || nucausal
                    || '|'
                    || nupersonid
                    || '|'
                    || sbdatosadicionales
                    || '|'
                    || nuactividadot
                    || '>1;READING>'
                    || nulecturafinal
                    || '>>;COMMENT1>'||nuObselect||'>>;COMMENT2>>>;COMMENT3>>>|'
                    || nuActividad
                    || '>'
                    || nuFlag
                    || '>Y>||'
                    || sbcomentario;
            ELSE
                sbcadenalegalizacionot :=
                       rcorden.order_id
                    || '|'
                    || nucausal
                    || '|'
                    || nupersonid
                    || '|'
                    || sbdatosadicionales
                    || '|'
                    || nuactividadot
                    || '>1;READING>'
                    || '>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|'
                    || nuActividad
                    || '>'
                    || nuFlag
                    || '>Y>||'
                    || sbcomentario;
            END IF;


            -- Legalizar
            pkg_traza.trace ('Legalizando Orden ' || rcorden.order_id, csbNivelTraza);
            pkg_traza.trace (sbcadenalegalizacionot, csbNivelTraza);

            dtfecha_exe_ini := dtult_fecha_lect - 2 / (24 * 60 * 60);
            pkg_traza.trace('Fecha Exec Ini: ' || dtfecha_exe_ini || ' | 2 Seg de Diferencia', csbNivelTraza);

            BEGIN
                -- 'Legalizacion Orden con Critica de Clientes Especiales'
                nupaso := '120';
            
                pkg_traza.trace('Ingresa api_legalizeOrders isbDataOrder: '  || sbcadenalegalizacionot || chr(10) ||
                                                          'idtInitDate: '   || dtfecha_exe_ini 		  || chr(10) ||
                                                          'idtFinalDate: '  || dtult_fecha_lect 	  || chr(10) ||
                                                          'idtChangeDate: ' || dtult_fecha_lect, csbNivelTraza);
                
                api_legalizeOrders(sbcadenalegalizacionot,
                                       dtfecha_exe_ini,
                                       dtult_fecha_lect,
                                       dtult_fecha_lect,
                                       nuerror,
                                       osberror);

                pkg_traza.trace('Sale api_legalizeOrders onuErrorCode: '    || nuerror || chr(10) ||
                                                       'osbErrorMessage: ' || osberror, csbNivelTraza);

                    --Valido que no hayan errores en la legalizacion
                IF osberror IS NOT NULL OR nuerror > 0 THEN
                    osberror := SUBSTR (
                                   nuerror
                                || '-'
                                || osberror
                                || ' '
                                || nulecturafinal
                                || ' '
                                || sbcadenalegalizacionot,
                                1,
                                3999);
                    RAISE pkg_Error.controlled_error;
                END IF;
            EXCEPTION
                WHEN pkg_Error.controlled_error THEN
                    IF nuerror = 346 THEN
                        osberror := osberror 
                            || ' | '
                            || 'Validar OR_ORDER_STAT_CHANGE - Fecha de Asignacion no puede ser mayor que la ultima Lectura de Control (FeLectura).';
                    END IF;

                    RAISE exclegalizar;
                WHEN OTHERS THEN
                    pkg_Error.setError;
                    pkg_Error.getError(gnuErr, gsbErr);                  
                    osberror := osberror || ' | ' || gsbErr;
                    RAISE exclegalizar;
            END;

            --Cargo nuevamente los datos de la Orden Legalizada para validar que
            --haya quedado en estado 8-Cerrada
            nupaso := '121';

            BEGIN
                SELECT *
                  INTO rcorden
                  FROM or_order o
                 WHERE o.order_id = rccritica.order_id;
            EXCEPTION
                WHEN OTHERS  THEN
                    osberror :=
                        'Inconsistencias al validar el estado de la orden luego del proceso de legalizacion. Se marca la Critica como No Procesada.';
                    RAISE excordenestado;
            END;

            --Valido que se haya registrado la lectura del Medidor (no aplica para telemedidos)
            nupaso := '122';

            IF sbesTelemedido = 'N'
            THEN
                SELECT COUNT (l.leemleto)
                  INTO nucontlect
                  FROM lectelme l
                 WHERE     leemclec = 'F'
                       AND nvl(l.leemleto,0) = nvl(nulecturafinal,0)
                       AND l.leempefa = rccritica.pefacodi
                       AND l.leemsesu = rccritica.sesunuse;


                --valido que se haya insertado el consumo para el producto
                nupaso := '123';

                SELECT COUNT (c.cosscoca)     cosscoca
                  INTO nucontcons
                  FROM conssesu c
                 WHERE     c.cosstcon = 1
                       AND c.cosssesu = rccritica.sesunuse
                       AND c.cosspefa = rccritica.pefacodi;


                IF nucontlect = 0
                THEN
                    --Lectura no registrada
                    osberror :=
                           osberror
                        || ' | Proceso de Legalizacion OSF no registro la Lectura.';
                END IF;

                IF nucontcons = 0
                THEN
                    --consumo no registrado
                    osberror :=
                           osberror
                        || ' | Proceso de Legalizacion de OSF no registro el consumo.';
                END IF;
            END IF;

            --Valida estado 8-cerrada despues del proceso de legalizacion
            IF rcorden.order_status_id = 8
            THEN
                --Notifica error registro lectura y consumo
                IF sbesTelemedido = 'N'
                THEN
                    IF nucontcons = 0 OR nucontlect = 0
                    THEN
                        osberror :=
                               ' *** Inconsistencia Legalizacion ***'
                            || osberror
                            || ' | Legalizacion cancelada.';
                    END IF;
                END IF;
            ELSE
                --Legalizacion con inconsistencia
                osberror :=
                       ' *** Inconsistencia Legalizacion ***'
                    || osberror
                    || ' | Legalizacion cancelada.';
            END IF;

            IF osberror IS NOT NULL
            THEN
                --Se genera el error controlado
                RAISE pkg_Error.controlled_error;
            END IF;

            IF rcorden.order_status_id NOT IN (8)
            THEN
                osberror :=
                    'La orden no quedo en estado 8-cerrada tras proceso de legalizacion. Se marca la Critica como No Procesada.';
                RAISE excordenestado;
            END IF;

            pkg_traza.trace (
               'Orden '
            || rcorden.order_id
            || 'Legalizada correctamente',
            csbNivelTraza);

            pkg_traza.trace (
               'Actualizo la critica y marco la Orden '
            || rcorden.order_id
            || ' como procesada...',
            csbNivelTraza);

            --Actualizo la critica con la Presion y Lectura Final
            --Se marca la critica como Procesada
            nupaso := '130';

            pkg_traza.trace ( 'rccritica.proc|' || rccritica.proc, csbNivelTraza); 

            IF rccritica.proc <> 'S'
            THEN
                --Se actualiza la Critica + el campo Programa
                EXECUTE IMMEDIATE 'Update ldc_cm_lectesp_crit c Set c.presfin = :1, c.lectfin = :2, c.proc= ''S'', c.programa=''LECTESPCRIT'', c.fecha_ultlect = :3 Where c.critica_id = :4'
                    USING inupresionfinal,
                          nulecturafinal,
                          dtult_fecha_lect,
                          inucriticaid;


                pkg_traza.trace ('Correcto '||nupaso, csbNivelTraza);

                --Actualizo a Procesado el producto y Periodo de Facturacion en la tabla de los Moviles
                nupaso := '140';
                pkg_traza.trace (
                       'Marcando las Ordenes de Control '
                    || rcorden.order_id
                    || ' como procesadas.',
                    csbNivelTraza);

                UPDATE ldc_cm_lectesp c
                   SET c.procesado = 'S'
                 WHERE     c.sesunuse = rccritica.sesunuse
                       AND c.pefacodi = rccritica.pefacodi;

                pkg_traza.trace ('Correcto '||nupaso, csbNivelTraza);

                --Confirmo los cambios
                nupaso := '150';
                COMMIT;
            END IF;
        END IF;                                           -- CA633 (CA333)
  
        pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        --Nota: Los mensajes de las excepciones no se muestran completos al usuario en la forma .NET LECTESPCRIT
        --El Detalle del Error Solo se muestra por PLSQL y en las trazas.
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR
        THEN
            osberror :=
                   'Critica No. '
                || inucriticaid
                || ' | Paso ('
                || nupaso
                || ')'
                || ' | Orden '
                || rcorden.order_id
                || ' | '
                || osberror
                || CHR (10)
                || ' | DetalleError:'
                || SQLERRM;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            ROLLBACK;
        WHEN excargacritica
        THEN
            osberror :=
                   'Critica No. '
                || inucriticaid
                || ' | Paso ('
                || nupaso
                || ')'
                || ' | Error al obtener el registro de la Critica. '
                || ' | Legalizacion cancelada.'
                || CHR (10)
                || ' | DetalleError:'
                || SQLERRM;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            ROLLBACK;
        WHEN excargaorden
        THEN
            osberror :=
                   'Critica No. '
                || inucriticaid
                || ' | Paso ('
                || nupaso
                || ')'
                || ' | No se pudo cargar la orden asociada a la Critica.'
                || ' | Legalizacion cancelada.'
                || CHR (10)
                || ' | DetalleError:'
                || SQLERRM;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            ROLLBACK;
        WHEN excargacausal
        THEN
            osberror :=
                   'Critica No. '
                || inucriticaid
                || ' | Paso ('
                || nupaso
                || ')'
                || ' | Error al obtener la causal de legalizacion para la Orden. '
                || ' | Orden '
                || rcorden.order_id
                || ' | Causal '
                || nucausal
                || ' | Tipo Trabajo '
                || rcorden.task_type_id
                || ' | Estado Orden: '
                || rcorden.order_status_id
                || ' | Legalizacion cancelada.'
                || CHR (10)
                || ' | DetalleError:'
                || SQLERRM;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            ROLLBACK;
        WHEN excpersonid
        THEN
            osberror :=
                   'Critica No. '
                || inucriticaid
                || ' | Paso ('
                || nupaso
                || ')'
                || ' | El usuario no puede legalizar esta orden porque no esta asignado a la unidad operativa. '
                || ' | Orden '
                || rcorden.order_id
                || ' | Unidad Operativa '
                || rcorden.operating_unit_id
                || ' | Usuario '
                || nuusuario
                || ' | Person_Id '
                || nupersonid
                || ' | Tipo Trabajo '
                || rcorden.task_type_id
                || ' | Estado Orden: '
                || rcorden.order_status_id
                || ' | Legalizacion cancelada.'
                || CHR (10)
                || ' | DetalleError:'
                || SQLERRM;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            ROLLBACK;
        WHEN excordenestado
        THEN
            osberror :=
                   'Critica No. '
                || inucriticaid
                || ' | Paso ('
                || nupaso
                || ') | '
                || osberror
                || ' | Orden '
                || rcorden.order_id
                || ' | Causal '
                || nucausal
                || ' | Tipo Trabajo '
                || rcorden.task_type_id
                || ' | Estado Orden: '
                || rcorden.order_status_id
                || ' | Legalizacion cancelada.'
                || CHR (10)
                || ' | DetalleError:'
                || SQLERRM;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            ROLLBACK;
        WHEN excpresfaco
        THEN
            osberror :=
                   'Critica No. '
                || inucriticaid
                || ' | Paso ('
                || nupaso
                || ')'
                || CHR (10)
                || ' |  '
                || osberror
                || ' | Producto '
                || rccritica.sesunuse
                || ' | Legalizacion cancelada.'
                || CHR (10)
                || ' DetalleError: '
                || SQLERRM;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            ROLLBACK;
        WHEN exclegalizar
        THEN
            osberror :=
                   'Critica No. '
                || inucriticaid
                || ' | Paso ('
                || nupaso
                || ')'
                || CHR (10)
                || ' *** Inconsistencia Legalizacion *** | '
                || osberror
                || ' | Orden '
                || rcorden.order_id
                || ' | Causal '
                || nucausal
                || ' | Tipo Trabajo '
                || rcorden.task_type_id
                || ' | Legalizacion cancelada.'
                || CHR (10)
                || ' DetalleError: '
                || SQLERRM;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            ROLLBACK;
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr, gsbErr);  
            osberror :=
                   'TERMINO CON ERROR NO CONTROLADO.'
                || ' | Paso ('
                || nupaso
                || ')'
                || ' | Legalizacion cancelada.'
                || CHR (10)
                || ' | DetalleError:'
                || gsbErr;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            ROLLBACK;
    END proprocesacritica;

    PROCEDURE proactordenamiento (isbdatos       IN     VARCHAR2,
                                  onuerrorcode      OUT NUMBER,
                                  osberror          OUT VARCHAR2)
    IS
        /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: ProActOrdenamiento
    Descripcion:        Actualizar ordenamiento en la Forma .NET LECTESPCRIT
                        La cadena debe estar separada por "|"

    Autor    : Oscar Ospino P.
    Fecha    : 09-12-2016  CA 200-856

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    09-12-2016   Oscar Ospino P.        Creacion


    ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proactordenamiento';
        nupaso         NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error

        excerror       EXCEPTION;
        excdatosinv    EXCEPTION;                           -- Datos Invalidos
        excdatoreq     EXCEPTION;                            -- Dato Requerido
        exerror        EXCEPTION;                          -- Error controlado

        CURSOR cudata IS
            SELECT CASE WHEN ROWNUM >= 1 THEN ROWNUM END idcampo,regexp_substr(isbdatos,'[^|]+',1,LEVEL) AS COLUMN_VALUE
            FROM dual
            CONNECT BY regexp_substr(isbdatos, '[^|]+', 1, LEVEL) IS NOT NULL;

        rcdata         cudata%ROWTYPE;
        nuexisteprod   NUMBER;
        nuproducto     NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('isbdatos   <= '||isbdatos, csbNivelTraza);

        nupaso := 1;
        onuerrorcode := 0;

        --Borro el ordenamiento previo
        UPDATE ldc_cm_lectesp_crit
           SET sort_id = '';

        nupaso := 10;

        --Separo la cadena y relleno el registro.
        FOR rcdata IN cudata
        LOOP
            BEGIN
                --parametro onuErrorCode sera el ultimo paso procesado antes de una excepcion

                --Actualizo el paso en cada iteraccion (Campo)
                IF osberror IS NULL
                THEN
                    nupaso := nupaso + 5;
                END IF;

                IF rcdata.COLUMN_VALUE >= 0
                THEN
                    nuproducto := rcdata.COLUMN_VALUE;

                    --Valido que los productos existan
                    SELECT COUNT (*)
                      INTO nuexisteprod
                      FROM servsusc s
                     WHERE s.sesunuse = nuproducto;

                    IF nuexisteprod > 0
                    THEN
                        BEGIN
                            rcdata.idcampo := rcdata.idcampo - 1;

                            --Actualizo el orden del registro en la tabla de criticas
                        UPDATE ldc_cm_lectesp_crit
                               SET sort_id = rcdata.idcampo
                             WHERE sesunuse = nuproducto;

                            pkg_traza.trace (
                                   'Actualizando ordenamiento producto: '
                                || nuproducto
                                || ': OK --SORT_ID: '
                            || rcdata.idcampo, csbNivelTraza);
                        EXCEPTION
                            WHEN OTHERS
                            THEN
                                onuerrorcode := nupaso;
                                osberror :=
                                       '(Paso '
                                    || nupaso
                                    || '): Error al actualizar campo SORT_ID del Producto: '
                                    || nuproducto
                                    || CHR (10)
                                    || 'Detalle: '
                                    || SQLERRM
                                    || CHR (10);
                        END;
                    ELSE
                        --Producto no existe
                        onuerrorcode := nupaso;
                        osberror :=
                               osberror
                            || '(Paso '
                            || nupaso
                            || '): Producto '
                            || nuproducto
                            || 'no existe: ';
                    END IF;
                ELSE
                    --El dato del producto no es numerico
                    onuerrorcode := nupaso;
                    osberror :=
                           osberror
                        || '(Paso '
                        || nupaso
                        || '): Datos Invalidos';
                END IF;
            END;
        END LOOP;

        nupaso := nupaso + 5;

        IF onuerrorcode > 0
        THEN
            --Instancio el error
            RAISE pkg_Error.controlled_error;
        ELSE
            --Confirmo la actualizacion de los registros
            COMMIT;
        END IF;        

        pkg_traza.trace('onuerrorcode   => '||onuerrorcode, csbNivelTraza);
        pkg_traza.trace('osberror       => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pkg_Error.setError;
            pkg_Error.getError(gnuErr, gsbErr);          
            onuerrorcode := gnuErr;
            osberror :=
                'Error Controlado: (Paso ' || nupaso || ') ' || gsbErr;
            pkg_traza.trace('onuerrorcode   => '||onuerrorcode, csbNivelTraza);
            pkg_traza.trace('osberror       => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proactordenamiento;

    PROCEDURE prodatosvalidacion (
        orfestructuratablas   OUT constants_per.tyrefcursor,
        orfdatosvalidacion    OUT constants_per.tyrefcursor,
        onuerrorcode          OUT NUMBER,
        osberrormessage       OUT VARCHAR2)
    IS
        /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: prodatosvalidacion
    Descripcion:        Obtiene los datos de las tablas asociadas.
                        Devuelve cursores referenciados de las tablas Padre (FK).

    Autor    : Oscar Ospino P.
    Fecha    : 25-03-2017  CA 200-1105

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    25-03-2017   Oscar Ospino P.        Creacion
    ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'prodatosvalidacion';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);

        --Se abre el cursor con la consulta sobre all_tab_columns col y all_col_comments
        OPEN orfestructuratablas FOR
              SELECT col.owner,
                     col.table_name,
                     col.column_id,
                     col.column_name,
                     col.data_type,
                     NVL (col.data_precision, col.data_length)
                         data_precision,
                     col.nullable,
                     UPPER (com.comments)
                         coldescription
                FROM all_tab_columns col, all_col_comments com
               WHERE     col.table_name = com.table_name
                     AND col.column_name = com.column_name
                     AND col.owner = com.owner
                     AND col.owner = 'OPEN'
                     AND col.table_name IN ('LDC_CM_LECTESP_EXCEL')
            ORDER BY col.table_name, col.column_id;

        --Productos y Ordenes del periodo actual de los ciclos Parametrizados
        OPEN orfdatosvalidacion FOR
            SELECT sesucico                                           cicloconsumo,
                   pefacicl                                           ciclofact,
                   pefaano                                            ano,
                   pefames                                            mes,
                   pf.pefacodi                                        periodo_fact,
                   l.pecscons                                         Periodo_consumo,
                   l.order_id                                         orden,
               (SELECT pkg_bcordenes.fnuobtieneestado (
                               l.order_id
                               )
                      FROM DUAL)                                      orden_estado,
                   l.sesunuse                                         producto,
                   TRUNC (sesufere)                                   fecharetiro,
                   sesusuca                                           categoria,
                   (SELECT DECODE (os.is_final_status, 'Y', 'S', 'N')
                  FROM or_order_status os
                     WHERE os.order_status_id = o.order_status_id)    procesado
          FROM servsusc             s,
               perifact             pf,
               ldc_cm_lectesp_crit  l,
               or_order             o
             WHERE     l.sesunuse = s.sesunuse
                   AND l.order_id = o.order_id
                   AND pf.pefacodi = l.pefacodi
                   AND pf.pefacicl = sesucicl
                   AND l.proc = 'N'
                   AND fsbGetCiclo (pf.pefacicl) = 'S'
                   AND sesucico IN
                           (SELECT pecscico
                              FROM ldc_cm_lectesp_cicl);



        pkg_traza.trace('onuerrorcode       => '||onuerrorcode, csbNivelTraza);
        pkg_traza.trace('osberrormessage    => '||osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr, gsbErr);           
            onuerrorcode := gnuErr;
            osberrormessage :=
                   'TERMINO CON ERROR NO CONTROLADO | '
                || ''
                || ' | '
                || csbMetodo
                || ' | Sesion: '
                || gnusesion
                || CHR (10)
                || gsbErr;
            pkg_traza.trace('onuerrorcode       => '||onuerrorcode, csbNivelTraza);
            pkg_traza.trace('osberrormessage    => '||osberrormessage, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END prodatosvalidacion;

    PROCEDURE proborrarimpprevia (osberror OUT VARCHAR2)
    IS
        /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: proBorrarImpPrevia
    Descripcion:        Borrar datos previos importados de Excel (Tabla LDC_CM_LECTESP_EXCEL)

    Autor    : Oscar Ospino P.
    Fecha    : 01-04-2017  CA 200-1105

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    01-04-2017   Oscar Ospino P.        Creacion

    ******************************************************************/

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'proborrarimpprevia';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);

        EXECUTE IMMEDIATE 'truncate Table LDC_CM_LECTESP_EXCEL';
        
        pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr, gsbErr);         
            osberror :=
                   'TERMINO CON ERROR NO CONTROLADO | Error al borrar registros importacion previos. |'
                || csbMetodo
                || ' | Sesion: '
                || gnusesion
                || CHR (10)
                || gsbErr;
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proborrarimpprevia;

    PROCEDURE proActualizaCritExcel (
        ocrdatosprocesados      OUT constants_per.tyrefcursor,
        isbProcParciales     IN OUT VARCHAR2,
        osberror                OUT VARCHAR2)
    IS
        /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: proActualizaCritExcel
    Descripcion:        Actualiza la Tabla de Criticas de Lecturas Especiales con los datos
                        importados de Excel (Tabla LDC_CM_LECTESP_EXCEL)

    Parametros:
    isbProcParciales:   Flag para validar si el proceso continuara cuando haya por lo menos 1 registro
                        de critica coincidente o esperar que todos los registros sean validos.
    ocrdatosprocesados: Cursor referenciados con las observaciones de error y registros procesados

    Autor    : Oscar Ospino P.
    Fecha    : 26-03-2017  CA 200-1105

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    26-03-2017   Oscar Ospino P.        Creacion
    ******************************************************************/

        PRAGMA AUTONOMOUS_TRANSACTION;

        csbMetodo        CONSTANT VARCHAR2(100) := csbPaquete||'proActualizaCritExcel';
        nucant           NUMBER := 0;
        nucontador       NUMBER := 0;
        nuduplicados     NUMBER := 0;
        nuNoCoincide     NUMBER := 0;
        rccritica        ldc_cm_lectesp_crit%ROWTYPE;
        dtFechaLectura   ldc_cm_lectesp_crit.fecha_ultlect%TYPE;

        --Registros de la tabla Importacion que SI coinciden con las Criticas No Procesadas
        CURSOR cudata IS
            SELECT DISTINCT *
              FROM LDC_CM_LECTESP_EXCEL E
             WHERE EXISTS
                       (SELECT DISTINCT l.critica_id,
                                        l.sesunuse,
                                        pf.pefacodi,
                                        pefaano,
                                        pefames
                          FROM ldc_cm_lectesp_crit  l,
                               perifact             pf,
                               servsusc             s
                         WHERE     l.sesunuse = s.sesunuse
                               AND l.pefacodi = pf.pefacodi
                               AND l.proc = 'N'
                               AND s.sesucicl = e.ciclo
                               AND l.pefacodi = e.periodo
                               AND pf.pefaano = e.ano
                               AND pf.pefames = e.mes
                               AND fsbGetCiclo (pf.pefacicl) = 'S'
                               AND l.sesunuse = e.producto
                               AND e.procesado <> 'N');

        --Datos de la tabla Importacion que NO coinciden con las Criticas No Procesadas
        CURSOR cuNodata IS
            SELECT DISTINCT *
              FROM LDC_CM_LECTESP_EXCEL E
             WHERE NOT EXISTS
                       (SELECT DISTINCT l.critica_id,
                                        l.sesunuse,
                                        pf.pefacodi,
                                        pefaano,
                                        pefames
                          FROM ldc_cm_lectesp_crit  l,
                               perifact             pf,
                               servsusc             s
                         WHERE     l.sesunuse = s.sesunuse
                               AND l.pefacodi = pf.pefacodi
                               AND l.proc = 'N'
                               AND s.sesucicl = e.ciclo
                               AND l.pefacodi = e.periodo
                               AND fsbGetCiclo (pf.pefacicl) = 'S'
                               AND pf.pefaano = e.ano
                               AND pf.pefames = e.mes
                               AND l.sesunuse = e.producto);

        --Cursor que busca registros duplicados en la Tabla de Importacion
        CURSOR cudupli IS
            SELECT *
              FROM LDC_CM_LECTESP_EXCEL e
             WHERE EXISTS
                       (  SELECT ano,
                                 mes,
                                 ciclo,
                                 periodo,
                                 producto,
                                 COUNT (*)
                            FROM LDC_CM_LECTESP_EXCEL
                           WHERE     ano = e.ano
                                 AND mes = e.mes
                                 AND ciclo = e.ciclo
                                 AND fsbGetCiclo (e.ciclo) = 'S'
                                 AND periodo = e.periodo
                                 AND producto = e.producto
                        GROUP BY ano,
                                 mes,
                                 ciclo,
                                 periodo,
                                 producto
                          HAVING COUNT (*) > 1);

        rcdupli          cudupli%ROWTYPE;

        rcnodata         cuNodata%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('isbProcParciales   <= '||isbProcParciales, csbNivelTraza);

        BEGIN
            --Hago reset de las observaciones y flags de procesos en tabla Importacion
            UPDATE LDC_CM_LECTESP_EXCEL e
               SET e.observacion = '-', e.procesado = '-';

            FOR rcnodata IN cuNodata
            LOOP
                UPDATE LDC_CM_LECTESP_EXCEL e
                   SET e.procesado = 'N',
                       e.observacion =
                           'Datos no concidentes con las criticas No Procesadas! Verificar.'
                 WHERE e.id = rcnodata.id;

                nuNoCoincide := nuNoCoincide + 1;
            END LOOP;

            FOR rcdupli IN cudupli
            LOOP
                UPDATE LDC_CM_LECTESP_EXCEL e
                   SET e.procesado = 'N',
                       e.observacion =
                              e.observacion
                           || ' | Registro duplicado! Verificar.'
                 WHERE e.id = rcdupli.id;

                nuduplicados := nuduplicados + 1;
            END LOOP;

            IF nuduplicados >= 0 OR nuNoCoincide >= 0
            THEN
                --Confirmo los cambios de los datos que no se deben procesar
                COMMIT;

                IF    UPPER (isbProcParciales) <> 'S'
                   OR isbProcParciales IS NULL
                THEN
                    --Abro el cursor para devolver la info con las observaciones agregadas a la importacion.
                    OPEN ocrdatosprocesados FOR
                        SELECT *
                      FROM LDC_CM_LECTESP_EXCEL e;

                    RAISE pkg_Error.controlled_error;
                END IF;
            --(osberror Is Not Null)
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
            RAISE;
        END;

        FOR rcdata IN cudata
        LOOP
            SELECT COUNT (1)
              INTO nucant
            FROM ldc_cm_lectesp_crit l
             WHERE     l.pefacodi = rcdata.periodo
                   AND l.sesunuse = rcdata.producto
                   AND l.proc = 'N';

            IF nucant = 1
            THEN
                SELECT *
                  INTO rccritica
                FROM ldc_cm_lectesp_crit l
                 WHERE     l.pefacodi = rcdata.periodo
                       AND l.sesunuse = rcdata.producto
                       AND l.proc = 'N';


                DECLARE
                    sberror   VARCHAR2 (4000);
                BEGIN
                    --Se procesa la critica actualizada
                    proprocesacritica (rccritica.critica_id,
                                       rcdata.presion,
                                       rcdata.lectura,
                                       sberror);

                    --sberror:='Error Prueba';

                    IF sberror IS NULL
                    THEN
                        --Contar registros actualizados sin error
                        nucontador := nucontador + 1;

                        --actualizar critica desde la tabla de importacion
                        UPDATE ldc_cm_lectesp_crit l
                           SET l.lectfin = rcdata.lectura,
                               l.presfin = rcdata.presion,
                               l.impexcel = 'S',
                               l.maquina = rcdata.maquina
                         --,l.userexcel = sbusuario
                         WHERE     l.pefacodi = rcdata.periodo
                               AND l.sesunuse = rcdata.producto
                               AND l.proc = 'S';

                        --Actualizo los registros procesados en la tabla de importacion
                        UPDATE LDC_CM_LECTESP_EXCEL e
                           SET e.procesado = 'S',
                               e.observacion = 'Procesado Correctamente!'
                         WHERE e.id = rcdata.id;

                        --Se confirma actualizacion de cada Registro segun Flag Procesos Parciales
                        IF UPPER (isbProcParciales) = 'S'
                        THEN
                            COMMIT;
                        END IF;
                    ELSE
                        osberror :=
                            osberror || CHR (10) || sberror || CHR (10);
                    END IF;
                END;
            ELSIF nucant = 0
            THEN
                osberror :=
                       'No existen criticas para actualizar. Validar datos de la Plantilla. Producto: '
                    || rcdata.producto
                    || ' | Periodo Fact: '
                    || rcdata.Periodo;
            ELSE
                osberror :=
                       'Existe mas de una critica para actualizar. Validar datos de la Plantilla.  Producto: '
                    || rcdata.producto
                    || ' | Periodo Fact: '
                    || rcdata.Periodo;
            END IF;

            IF osberror IS NULL
            THEN
                --Se confirma actualizacion del Lote de Importacion Completo segun Flag Procesos Parciales
                IF    UPPER (isbProcParciales) <> 'S'
                   OR isbProcParciales IS NULL
                THEN
                    COMMIT;
                END IF;
            ELSE
                ROLLBACK;

                --Actualizo la tabla de importacion para mostrar los errores tras procesar la critica
                UPDATE LDC_CM_LECTESP_EXCEL e
                   SET e.procesado = 'N',
                       e.observacion =
                           'Error al procesar! ver Pestaña LOG'
                 WHERE e.id = rcdata.id;

                --Confirmo los cambios
                COMMIT;
            END IF;
        END LOOP;

        OPEN ocrdatosprocesados FOR SELECT * FROM LDC_CM_LECTESP_EXCEL e;

        pkg_traza.trace('isbProcParciales   => '||isbProcParciales, csbNivelTraza);
        pkg_traza.trace('osberror           => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr, gsbErr);           
            osberror :=
                   'TERMINO CON ERROR NO CONTROLADO | Se actualizaron '
                || nucontador
                || ' criticas antes del error. | '
                || csbMetodo
                || ' | Sesion: '
                || gnusesion
                || CHR (10)
                || gsbErr;
            pkg_traza.trace('isbProcParciales   => '||isbProcParciales, csbNivelTraza);
            pkg_traza.trace('osberror           => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END proActualizaCritExcel;

    /*****************************************************************

    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete:   fsbGetCiclo
    Descripcion:          Obtiene el ciclo

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    02-06-2021   Horbath             caso: 633. Se ajusta para que obtenga los ciclos del usuario conectado
    ******************************************************************/
    FUNCTION fsbGetCiclo (inuciclo IN servsusc.sesucicl%TYPE)
        RETURN VARCHAR2
    IS
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fsbGetCiclo';
        sbRespuesta   VARCHAR2 (1) := 'N';
        sbusu         sa_user.mask%TYPE;
        nucicl        NUMBER;

        CURSOR cuCiclos (sbusuario sa_user.mask%TYPE)
        IS
            SELECT ci.pecscico
              FROM ge_person            p,
                   sa_user              u,
                   ldc_cm_lectesp_petc  tc,
                   LDC_CM_LECTESP_CICL  CI
             WHERE     p.user_id = u.user_id
                   AND tc.person_id = p.person_id
                   AND tc.tipocicl_id = ci.pecstpci
                   AND u.mask = sbusuario
                   AND ci.pecscico = inuciclo;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuciclo   <= '||inuciclo, csbNivelTraza);
        
        SELECT u.mask
          INTO sbusu
          FROM SA_USER U
         WHERE U.USER_ID =
               (SELECT GP.USER_ID
                  FROM GE_PERSON GP
                 WHERE GP.PERSON_ID = pkg_bopersonal.fnugetpersonaid);


        OPEN cuCiclos (sbusu);

        FETCH cuCiclos INTO NUCICL;

        IF cuCiclos%NOTFOUND
        THEN
            sbRespuesta := 'N';
        ELSE
            sbRespuesta := 'S';
        END IF;

        CLOSE cuCiclos;
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        pkg_traza.trace('sbRespuesta    => '||sbRespuesta, csbNivelTraza);        
        RETURN (sbRespuesta);
    EXCEPTION
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr,gsbErr);
            sbRespuesta := 'N';
            pkg_traza.trace('sbError: '||gsbErr,csbNivelTraza);
            pkg_traza.trace('sbRespuesta    => '||sbRespuesta, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN (sbRespuesta);
    END fsbGetCiclo;

    /*****************************************************************

       Propiedad intelectual de Gases del Caribe.

       Nombre del Paquete:   fsbGetTipoTrab
       Descripcion:          Obtiene el tipo de trabajo

       Historia de Modificaciones

       DD-MM-YYYY    <Autor>.              Modificacion
       -----------  -------------------    -------------------------------------
       02-06-2021   Horbath             caso: 633. Se ajusta para que obtenga los ciclos del usuario conectado
       ******************************************************************/
    FUNCTION fsbGetTipoTrab (osberror OUT VARCHAR2)
        RETURN constants_per.tyrefcursor
    IS
        csbMetodo     CONSTANT VARCHAR2(100) := csbPaquete||'fsbGetTipoTrab';
        sbusu         sa_user.mask%TYPE;
        nucantidad    NUMBER;
        crcNoReg      constants_per.tyrefcursor;
        sbRespuesta   VARCHAR2 (1);
        exerror       EXCEPTION;                           -- Error controlado

        CURSOR cuCiclos (sbusuario sa_user.mask%TYPE)
        IS
            SELECT COUNT (tp.task_type_id)     tot
              FROM ge_person            p,
                   sa_user              u,
                   ldc_cm_lectesp_petc  tc,
                   LDC_CM_LECTESP_CICL  CI,
                   ldc_cm_lectesp_tpcl  tp
             WHERE     p.user_id = u.user_id
                   AND tc.person_id = p.person_id
                   AND tc.tipocicl_id = ci.pecstpci
                   AND ci.pecstpci = tp.tipocicl_id
                   AND u.mask = sbusuario
                   AND tp.task_type_id IS NOT NULL;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        SELECT u.mask
          INTO sbusu
          FROM SA_USER U
         WHERE U.USER_ID =
               (SELECT GP.USER_ID
                  FROM GE_PERSON GP
                 WHERE GP.PERSON_ID = pkg_bopersonal.fnugetpersonaid);

        OPEN cuCiclos (sbusu);

        FETCH cuCiclos INTO nucantidad;

        IF cuCiclos%NOTFOUND OR NVL (nucantidad, 0) = 0
        THEN
            sbRespuesta := 'N';
        ELSE
            sbRespuesta := 'S';
        END IF;

        CLOSE cuCiclos;

        OPEN crcNoReg FOR SELECT sbRespuesta FROM DUAL;

        sbMostrarDatosNR := sbRespuesta;
        pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN (crcNoReg);
    EXCEPTION
        WHEN exerror
        THEN                                               -- Error controlado
            osberror :=
                CHR (10) || 'Error en fsbGetTipoTrab' || CHR (10) || CHR (10);
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr,gsbErr);
            osberror :=
                CHR (10) || 'Error en fsbGetTipoTrab' || CHR (10) ||gsbErr|| CHR (10);
            pkg_traza.trace('osberror   => '||osberror, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END fsbGetTipoTrab;

    FUNCTION fsbEsTelemedido (inupecscons pericose.pecscons%TYPE)
        RETURN VARCHAR2
    IS
        csbMetodo     CONSTANT VARCHAR2(100) := csbPaquete||'fsbEsTelemedido';
        nutasktype    or_order.task_type_id%TYPE;
        sbRespuesta   VARCHAR2 (1);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inupecscons   <= '||inupecscons, csbNivelTraza);
        
        BEGIN
            SELECT tp.task_type_id
              INTO nutasktype
              FROM LDC_CM_LECTESP_CICL  CI,
                   ldc_cm_lectesp_tpcl  tp,
                   pericose             p2
             WHERE     ci.pecstpci = tp.tipocicl_id
                   AND p2.pecscico = ci.pecscico
                   AND p2.pecscons = inupecscons;
        EXCEPTION
            WHEN OTHERS
            THEN
                nutasktype := NULL;
        END;

        IF nutasktype IS NULL
        THEN
            sbRespuesta := 'N';
        ELSE
            sbRespuesta := 'S';
        END IF;
        
        pkg_traza.trace('sbRespuesta    => '||sbRespuesta, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN (sbRespuesta);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(gnuErr,gsbErr);
            sbRespuesta := 'N';
            pkg_traza.trace('sbError: '||gsbErr,csbNivelTraza);
            pkg_traza.trace('sbRespuesta    => '||sbRespuesta, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN (sbRespuesta);
    END fsbEsTelemedido;
END ldc_pkcm_lectesp;
/

PROMPT Otorgando permisos de ejecucion para ldc_pkcm_lectesp
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKCM_LECTESP','OPEN');
END;
/

