CREATE OR REPLACE PROCEDURE ADM_PERSON.PROCREASIGORECA (SBPATHFILE         IN VARCHAR2,
                                                         SBFILE_NAME        IN VARCHAR2) IS
    /*****************************************************************
    Autor       : Elkin Alvarez / Horbath
    Fecha       : 2019-04-09
    Ticket      : 200-2272
    Descripcion : Proceso que obtiene los productos y unidad operativa asociada, cargado por archivo plano,
                  para crear ordenes y asignar ordenes de seguimiento de cartera.
    Valor de entrada

    SBPATHFILE   : RUTA DEL ARCHIVO A CARGAR
    SBFILE_NAME  : NOMBRE DEL ARCHIVO A CARGAR

    Historial de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    22/10/2019      HORBATH (EHG)       OPTIMAZACION DE PROCESO PROCREASIGORECA OK++
    22/11/2019      HORBATH (EHG)       REVISION Y VERSION FINAL OK++
    09/05/2022		CGONZALEZ			OSF-266: Se modifica para que en el insert de la entidad LDC_TMP_OR_ORDER_GC
                                                 se tenga en cuenta la actividad del nuevo tipo de trabajo
    12/12/2022		CGONZALEZ			OSF-741: Se modifica para crear la orden de acuerdo a la actividad diligenciada
                                                 en el archivo plano
    08/02/2024		jpinedc			    OSF-2130:   * Ajustes migración a V8
                                                    * Uso de pkg_gestionArchivos.
    03/04/2024		jpinedc			    OSF-2545:   * Se cambia  pkg_Session.fnuGetSesion
                                                    por userenv debido a que devueve cero
                                                    en PBs programables
    ******************************************************************/
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT ||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PROCREASIGORECA';
            
    SUBTYPE STYSIZELINE   IS VARCHAR2(32000);
    FPORDERSDATA          pkg_gestionArchivos.styArchivo;
    SBLINE                STYSIZELINE;
    NURECORD              NUMBER;
    SBERRORFILE           VARCHAR2(100);
    SBERRORLINE           STYSIZELINE;
    NUPRODUCTID           PR_PRODUCT.PRODUCT_ID%TYPE;
    inuActivity           NUMBER;
    nuActividadCast       NUMBER;
    NUERRORCODE           NUMBER;
    SBERRORMESSAGE        VARCHAR2(2000);
    SBPRODUCT               VARCHAR2(2000);
    SBOPERATING_UNIT      VARCHAR2(2000);
    NUOPERATINGUNITID     OR_ORDER.OPERATING_UNIT_ID%TYPE;
    CSBFILE_SEPARATOR     CONSTANT VARCHAR2(1) := '/';

    SBACTIVITY            VARCHAR2(2000);
    NUACTIVITY            NUMBER;
    NUBOOL                BOOLEAN := FALSE;

    sbEstaOrd VARCHAR2(100)        :=  dald_parameter.fsbGetValue_Chain('PARAM_CONFIG_ESTADOS',NULL);

    DTFECHA                        DATE;
    X                              NUMBER;

    nuTipoTrabOrder			or_order.task_type_id%type;  --- caso 159
    nuvalTT					number;

    sbLDC_PRTIPOTRANAJOUSADO  ld_parameter.value_chain%type := DALD_PARAMETER.fsbGetValue_Chain('LDC_PRTIPOTRANAJOUSADO', NULL);

    --Cursor que obtiene los registros procesados y marcados con ERROR (ESTADO_PR = 1) en la tabla temporal LDC_TMP_FPORDERSDATA
    CURSOR CU_REG_ERROR (NUMSESION NUMBER) IS
    SELECT L.NUTPRODUCTID, L.NUTOPERATINGUNITID, L.NUSESION, L.OBSERVACION
    FROM   LDC_TMP_FPORDERSDATA L
    WHERE  L.ESTADO_PR = 1
    AND    L.NUSESION  = NUMSESION;
    
    -- cursor que obtiene los tipos de trabajo del parametro LDC_PRTIPOTRANAJOUSADO para el caso 159
    Cursor cuVALTTPARAM (nuTT or_order.task_type_id%type) is
    SELECT COUNT(1) FROM
    (
        SELECT to_number(regexp_substr(sbLDC_PRTIPOTRANAJOUSADO,'[^,]+', 1,LEVEL))
        FROM dual
        WHERE to_number(regexp_substr(sbLDC_PRTIPOTRANAJOUSADO,'[^,]+', 1,LEVEL)) = nuTT
        CONNECT BY regexp_substr(sbLDC_PRTIPOTRANAJOUSADO, '[^,]+', 1, LEVEL) IS NOT NULL    
    )
    ;
	 
    Cursor cuGetTaskTypeActivity (nuActividad   or_task_types_items.items_id%type) is
    select task_type_id 
        from open.or_task_types_items 
            where items_id = nuActividad;

    TBSTRING    ut_string.TYTB_STRING;
    sbSeparador VARCHAR2(1) := ';';
    CUANTOS     NUMBER;
    nutsess     NUMBER;

    PROCEDURE prcCierraCursores
    IS
        csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME || 'PROCREASIGORECA'||'.prcCierraCursores' ;
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        if(cuGetTaskTypeActivity%isopen) then
            close cuGetTaskTypeActivity;
        end if;
        
        if(cuVALTTPARAM%isopen)then
            close cuVALTTPARAM;
        end if;        

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
    END prcCierraCursores;

    --Procedimiento LDC_PRREG_TMP_FPORDERSDATA, para insertar los registros del archivo plano a la tabla temporal LDC_TMP_FPORDERSDATA.
    procedure LDC_PRREG_TMP_FPORDERSDATA(NUPRODUCTID       IN NUMBER,
                                       NUOPERATINGUNITID IN NUMBER,
                                       INUACTIVITY		 IN NUMBER,
                                       INUSESION         IN NUMBER
                                       ) is
    begin
        --Se valida que el dato correspondiente al producto y a la unidad operativa no venga null.
        IF (NUPRODUCTID IS NOT NULL AND NUOPERATINGUNITID IS NOT NULL AND INUACTIVITY IS NOT NULL) THEN
            BEGIN
                Insert into LDC_TMP_FPORDERSDATA (NUTPRODUCTID,
                                                NUTOPERATINGUNITID,
                                                ACTIVITY_ID,
                                                NUSESION,
                                                FECHA_REGISTRO
                                                )
                                          values(NUPRODUCTID,
                                                 NUOPERATINGUNITID,
                                                 INUACTIVITY,
                                                 INUSESION,
                                                 SYSDATE
                                                 );
            END;
        END IF;
    End LDC_PRREG_TMP_FPORDERSDATA;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    nutsess := userenv('SESSIONID'); 
    XLOGPNO_EHG('F0 - INICIA EL PROCESO PROCREASIGORECA]', nutsess);

   --Habilitar siempre para ejecución desde el PB GECORECA
    --Limpiar las tablas temporales.
    DELETE FROM LDC_TMP_FPORDERSDATA WHERE FECHA_REGISTRO < SYSDATE - 30;
    DELETE FROM LDC_TEMP_GCORECA_HILOS WHERE FECHA_FINAL < SYSDATE - 30;
    DELETE FROM LDC_TMP_OR_ORDER_GC;
    DELETE FROM LOGPNO_EHG WHERE FECHA < SYSDATE - 30 OR SESSION_ID IS NULL;
    COMMIT;

    pkg_Traza.Trace('[PROCREASIGORECA ] INICIO',3);
    XLOGPNO_EHG('[PROCREASIGORECA ] ARCHIVO: '||SBPATHFILE||CSBFILE_SEPARATOR||sbFILE_NAME, nutsess);-- /smartfiles/tmp/lecehg.txt

    pkg_gestionArchivos.prcValidaExisteArchivo_SMF (SBPATHFILE,sbFILE_NAME);
    XLOGPNO_EHG('[PROCREASIGORECA ] ARCHIVO 1 ', nutsess);

    FPORDERSDATA :=pkg_gestionArchivos.ftAbrirArchivo_SMF ( SBPATHFILE, sbFILE_NAME, pkg_gestionArchivos.csbMODO_LECTURA );

    XLOGPNO_EHG('[PROCREASIGORECA ] ARCHIVO OK '||SBERRORFILE, nutsess);

    NURECORD := 0;

    --Se obtiene el parametro de la actividad.
    inuActivity := dald_parameter.fnuGetNumeric_Value('PARAM_CONFIG_ACTIVIDAD', null);-->4000844

    nuActividadCast := dald_parameter.fnuGetNumeric_Value('ACT_GC_CASTIGADOS', null);

    --Variable contadora para manejo de persistencia cada 1000 registros.
    CUANTOS:= 0;
    XLOGPNO_EHG('F1A - [INICIA LLENANDO LA TABLA LDC_PRREG_TMP_FPORDERSDATA CON LOS REGISTROS DEL PLANO]', nutsess);

    --Ciclo para recorrer el archivo plano y almacenar en la tabla temporal de ordenes
    WHILE TRUE LOOP
    
        prcCierraCursores;
        
        BEGIN        
            SBLINE := pkg_gestionArchivos.fsbObtenerLinea_SMF (FPORDERSDATA );
            EXCEPTION 
                WHEN NO_DATA_FOUND THEN
                    EXIT;
                WHEN OTHERS THEN 
                    RAISE;
        END;              

        pkg_Traza.Trace('Linea '||SBLINE,10);
        XLOGPNO_EHG('[PROCREASIGORECA WHILE pkg_gestionArchivos.FILEREAD] Linea '||SBLINE, nutsess);

        SBLINE:=replace(replace(TRIM(SBLINE),chr(10), ''), chr(13),'');

        pkg_Traza.Trace('Linea 1'||SBLINE,10);
        XLOGPNO_EHG('[PROCREASIGORECA pkg_gestionArchivos.FILEREAD] Linea 1 '||SBLINE, nutsess);

        NURECORD := NURECORD + 1;

        ut_string.EXTSTRING(SBLINE, sbSeparador , TBSTRING);  --se crera tabla pl con los datos correspondiente
    
        SBPRODUCT          := TBSTRING(1);
        SBOPERATING_UNIT := TBSTRING(2);
        SBACTIVITY 		 := TBSTRING(3);

        open cuGetTaskTypeActivity(TO_NUMBER(TRIM(SBACTIVITY)));
        fetch cuGetTaskTypeActivity into nuTipoTrabOrder;
        close cuGetTaskTypeActivity;
    
        open cuVALTTPARAM(nuTipoTrabOrder);
        fetch cuVALTTPARAM into nuvalTT;
        close cuVALTTPARAM;

        IF  nuvalTT > 0 THEN -- SI EXISTE EL TIPO DE TRABAJO DE LA ACTIVIDAD EN EL PARAMETRO LDC_PRTIPOTRANAJOUSADO SE PROCESA LA ACTIVIDAD
    
            BEGIN
                NUPRODUCTID       := TO_NUMBER(SBPRODUCT);
                NUACTIVITY        := TO_NUMBER(TRIM(SBACTIVITY));
                NUOPERATINGUNITID := TO_NUMBER(TRIM(SBOPERATING_UNIT));
              
                LDC_PRCREASIGORDEN(NUPRODUCTID, NUACTIVITY, NUOPERATINGUNITID);
          
            EXCEPTION
                WHEN OTHERS THEN
                    SBERRORLINE := 'SE PRESENTÓ ERROR AL EJECUTAR EL PROCEDIMIENTO DE LA CREACION Y ASIGNACION DE ORDENES (LDC_PRCREASIGORDEN)';
                    XLOGPNO_EHG('F0 - '||SBERRORLINE, nutsess);
                    SBERRORLINE := NULL;
                    NUPRODUCTID := NULL;
                    NUOPERATINGUNITID :=NULL;
                    NUACTIVITY :=NULL;
            END;
        
        ELSE

            BEGIN
                NUPRODUCTID       := TO_NUMBER(SBPRODUCT);
                NUOPERATINGUNITID := TO_NUMBER(TRIM(SBOPERATING_UNIT));
                NUACTIVITY        := TO_NUMBER(TRIM(SBACTIVITY));
    
                --Se llama al procedimento local LDC_PRREG_TMP_FPORDERSDATA, que valida cada registro del archivo plano e inserta en la tabla temporal LDC_TMP_FPORDERSDATA.
                LDC_PRREG_TMP_FPORDERSDATA (NUPRODUCTID,
                                          NUOPERATINGUNITID,
                                          NUACTIVITY,
                                          NUTSESS
                                          );
                CUANTOS := CUANTOS + 1;

                IF CUANTOS = 1000 THEN
                    COMMIT;
                    CUANTOS := 0;
                END IF;
          
                nubool := true;
          
            EXCEPTION
                WHEN OTHERS THEN
                     SBERRORLINE := '['||NURECORD ||']  ERROR AL CONVERTIR EL PRODUCTO O LA UNIDAD OPERATIVA';
                     XLOGPNO_EHG('F0 - '||SBERRORLINE, nutsess);
                     SBERRORLINE := NULL;
                     NUPRODUCTID := NULL;
                     NUOPERATINGUNITID :=NULL;
            END;
        
        END IF;
                
    END LOOP;
    
    COMMIT;

    IF nubool THEN
      
        XLOGPNO_EHG('F1B - [TERMINA DE LLENAR LA TABLA LDC_PRREG_TMP_FPORDERSDATA CON LOS REGISTROS DEL PLANO]', nutsess);
          
        --Valido y cierro el archivo plano de registros cargado.
        IF pkg_gestionArchivos.fblArchivoAbierto_SMF (FPORDERSDATA) THEN
            pkg_gestionArchivos.prcCerrarArchivo_SMF (FPORDERSDATA,SBPATHFILE, sbFILE_NAME);
        END IF;

        COMMIT;
            
        -- Se llena la tabla Temporal con ordenes, si existen ordenes en estados(0,5,11) asociadas a los productos del archivo plano.
        XLOGPNO_EHG('F2A - [LLENANDO LA TABLA LDC_TMP_OR_ORDER_GC CON LAS ORDENES] INICIO', nutsess);
        INSERT INTO LDC_TMP_OR_ORDER_GC (NUORDER_ID,
                                         NUORDER_STATUS_ID,
                                         NUSESION,
                                         NUPRODUCT_ID
                                         )
               SELECT O.ORDER_ID,
                      O.ORDER_STATUS_ID,
                      NUTSESS,
                      A.PRODUCT_ID
               FROM  OR_ORDER O, OR_ORDER_ACTIVITY A, LDC_TMP_FPORDERSDATA L --Tabla TMP
               WHERE O.ORDER_STATUS_ID in (SELECT to_number(regexp_substr(sbEstaOrd,'[^,]+', 1, LEVEL)) AS estado_orden
                                           FROM   dual
                                           CONNECT BY regexp_substr(sbEstaOrd, '[^,]+', 1, LEVEL) IS NOT NULL
                                           ) --(0,5,11)
                                           AND O.ORDER_ID     = A.ORDER_ID
                                           AND (A.activity_id  = inuActivity OR A.activity_id = nuActividadCast OR A.activity_id = NUACTIVITY)
                                           AND L.NUTPRODUCTID = A.PRODUCT_ID
                                           AND L.NUSESION     = NUTSESS;
        
        COMMIT;
        XLOGPNO_EHG('22B - [TERMINA DE LLENAR LA TABLA LDC_TMP_OR_ORDER_GC CON LAS ORDENES] FIN', nutsess);
        
    
        --Se llena la tabla temporal de hilos LDC_TEMP_GCORECA_HILOS y se establecen los registros en estado inicial (C = Creado).
        XLOGPNO_EHG('F3A - [LLENANDO LA TABLA TEMPORAL DE HILOS LDC_TEMP_GCORECA_HILOS] INICIO', nutsess);
        FOR I IN 0..9 LOOP
            INSERT INTO LDC_TEMP_GCORECA_HILOS (HILO , NUSESION , FECHA_INICIAL , FECHA_FINAL, OBSERVACION , STATUS)
            VALUES (I, NUTSESS, SYSDATE, NULL, 'INICIO', 'C');
            COMMIT;
        END LOOP;
        XLOGPNO_EHG('F3B - [TERMINA DE LLENAR LA TABLA TEMPORAL DE HILOS LDC_TEMP_GCORECA_HILOS] FIN', nutsess);
        --
    
        --Se corren los hilos y se establecen los registros de la tabla temporal de hilos LDC_TEMP_GCORECA_HILOS en estado (P = Procesado).
        XLOGPNO_EHG('F4A - [SE EJECUTAN LOS HILOS Y REGISTRO EN LDC_TEMP_GCORECA_HILOS] INICIO', nutsess);
        FOR I IN 0..9 LOOP
            dtFecha := (sysdate);
            DBMS_JOB.SUBMIT ( x,'PROCREASIGORECA_HILOS (' || TO_CHAR(I) ||','||TO_CHAR(NUTSESS) ||');', DTFECHA);
            COMMIT;
            XLOGPNO_EHG('SI ENTRA AL RECORRIDO DE HILOS DEL PROCESO PROCREASIGORECA_HILOS: ' || I ||NUTSESS, nutsess);
        END LOOP;
        XLOGPNO_EHG('F4B - [TERMINA LA EJECUCION DE HILOS Y REGISTRO EN LDC_TEMP_GCORECA_HILOS] FIN', nutsess);
    
        --Se selecciona los registros con errores (ESTADO_PR = 1) de la tabla LDC_TMP_FPORDERSDATA y los escribo en el plano de errores
        XLOGPNO_EHG('[selecciona los registros con errores (ESTADO_PR = 1) de la tabla LDC_TMP_FPORDERSDATA] Y LOS ESCRIBE EN EL ARCHIVO DE ERROR', nutsess);
        FOR RC IN CU_REG_ERROR (NUTSESS) LOOP
            SBERRORLINE := '['||NURECORD ||']'||RC.NUTPRODUCTID||' - '||RC.OBSERVACION;
            SBERRORLINE := NULL;
        END LOOP;
        
    END IF;
    
    XLOGPNO_EHG('F5 - FINALIZA EL PROCESO PROCREASIGORECA]', nutsess);

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
EXCEPTION
	WHEN  pkg_Error.CONTROLLED_ERROR THEN
        pkg_Error.getError(NUERRORCODE, SBERRORMESSAGE);
        pkg_traza.trace('SBERRORMESSAGE => ' || SBERRORMESSAGE, csbNivelTraza );
        ROLLBACK;
        prcCierraCursores;
        XLOGPNO_EHG('F6 - ERROR EN EL pkg_Error.CONTROLLED_ERROR]', nutsess);
        RAISE pkg_Error.CONTROLLED_ERROR;
	WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(NUERRORCODE, SBERRORMESSAGE);
        pkg_traza.trace('SBERRORMESSAGE => ' || SBERRORMESSAGE, csbNivelTraza );
        ROLLBACK;
        prcCierraCursores;
        XLOGPNO_EHG('F7 - ERROR EN EL WHEN OTHERS THEN]', nutsess);
        RAISE pkg_Error.CONTROLLED_ERROR;
END PROCREASIGORECA;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('PROCREASIGORECA', 'ADM_PERSON');
END;
/
